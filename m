Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37559 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111AbcD2QUc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Apr 2016 12:20:32 -0400
Date: Fri, 29 Apr 2016 11:20:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: PTM preliminary implementation
Message-ID: <20160429162026.GC949@localhost>
References: <1461047358-4736-1-git-send-email-jonathan.yong@intel.com>
 <1461047358-4736-2-git-send-email-jonathan.yong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461047358-4736-2-git-send-email-jonathan.yong@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jonathan,

Thanks for polishing this up.  I think this is really coming together
nicely.

On Tue, Apr 19, 2016 at 06:29:18AM +0000, Yong, Jonathan wrote:
> Simplified Precision Time Measurement driver, activates PTM feature
> if a PCIe PTM requester (as per PCI Express 3.1 Base Specification
> section 7.32)is found, but not before checking if the rest of the
> PCI hierarchy can support it.
> 
> The driver does not take part in facilitating PTM conversations,
> neither does it provide any useful services, it is only responsible
> for setting up the required configuration space bits.
> 
> As of writing, there aren't any PTM capable devices on the market
> yet, but it is supported by the Intel Apollo Lake platform.
> 
> Signed-off-by: Yong, Jonathan <jonathan.yong@intel.com>
> ---
>  drivers/pci/pci-sysfs.c       |   7 ++
>  drivers/pci/pci.h             |  20 +++++
>  drivers/pci/pcie/Kconfig      |   9 ++
>  drivers/pci/pcie/Makefile     |   3 +
>  drivers/pci/pcie/pcie_ptm.c   | 194 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c           |   3 +
>  include/linux/pci.h           |  11 +++
>  include/uapi/linux/pci_regs.h |  14 ++-
>  8 files changed, 260 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/pcie/pcie_ptm.c
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index e982010..11cf97b 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1342,6 +1342,9 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>  	/* Active State Power Management */
>  	pcie_aspm_create_sysfs_dev_files(dev);
>  
> +	/* Precision Time Measurement */
> +	pcie_ptm_create_sysfs_dev_files(dev);
> +
>  	if (!pci_probe_reset_function(dev)) {
>  		retval = device_create_file(&dev->dev, &reset_attr);
>  		if (retval)
> @@ -1351,6 +1354,7 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>  	return 0;
>  
>  error:
> +	pcie_ptm_remove_sysfs_dev_files(dev);
>  	pcie_aspm_remove_sysfs_dev_files(dev);
>  	if (dev->vpd && dev->vpd->attr) {
>  		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
> @@ -1436,6 +1440,9 @@ static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
>  	}
>  
>  	pcie_aspm_remove_sysfs_dev_files(dev);
> +
> +	pcie_ptm_remove_sysfs_dev_files(dev);
> +
>  	if (dev->reset_fn) {
>  		device_remove_file(&dev->dev, &reset_attr);
>  		dev->reset_fn = 0;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index d0fb934..908445b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -320,6 +320,26 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
>  
>  void pci_enable_acs(struct pci_dev *dev);
>  
> +#ifdef CONFIG_PCIE_PTM
> +int pci_enable_ptm(struct pci_dev *dev);
> +int pcie_ptm_create_sysfs_dev_files(struct pci_dev *dev);
> +void pcie_ptm_remove_sysfs_dev_files(struct pci_dev *dev);
> +void pci_disable_ptm(struct pci_dev *dev);
> +void pci_ptm_init(struct pci_dev *dev);
> +#else
> +static inline int pci_enable_ptm(struct pci_dev *dev)
> +{
> +	return -ENXIO;
> +}
> +static inline int pcie_ptm_create_sysfs_dev_files(struct pci_dev *dev)
> +{
> +	return -ENXIO;
> +}
> +static inline void pcie_ptm_remove_sysfs_dev_files(struct pci_dev *dev) {}
> +static inline void pci_disable_ptm(struct pci_dev *dev) {}
> +static inline void pci_ptm_init(struct pci_dev *dev) {}
> +#endif
> +
>  struct pci_dev_reset_methods {
>  	u16 vendor;
>  	u16 device;
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 72db7f4..2baddc5 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -81,3 +81,12 @@ endchoice
>  config PCIE_PME
>  	def_bool y
>  	depends on PCIEPORTBUS && PM
> +
> +config PCIE_PTM
> +	bool "Enable Precision Time Measurement support"
> +	default y
> +	depends on PCIEPORTBUS
> +	help
> +	  Say Y here if you have PCI Express devices that are capable of
> +	  Precision Time Measurement (PTM). This also requires that your
> +	  PCI Express controller or switch fabric is PTM capable.

I think this text might be slightly too discouraging.  Users might get
the idea that this config option cannot be enabled unless they have
PTM-capable hardware.  Maybe something like:

  Say Y here to enable support for PCI Express Precision Time
  Measurement (PTM).  This is only useful if you have devices that
  support PTM, but it is safe to enable even if you don't.

> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 00c62df..726b972 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -14,3 +14,6 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
>  obj-$(CONFIG_PCIEAER)		+= aer/
>  
>  obj-$(CONFIG_PCIE_PME) += pme.o
> +
> +# Precision Time Measurement support
> +obj-$(CONFIG_PCIE_PTM) += pcie_ptm.o
> diff --git a/drivers/pci/pcie/pcie_ptm.c b/drivers/pci/pcie/pcie_ptm.c
> new file mode 100644
> index 0000000..f4e4d61
> --- /dev/null
> +++ b/drivers/pci/pcie/pcie_ptm.c
> @@ -0,0 +1,194 @@
> +/*
> + * PCI Express Precision Time Measurement
> + * Copyright (c) 2016, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include "../pci.h"
> +
> +static bool disable_ptm;
> +
> +module_param_named(disable_ptm, disable_ptm, bool, S_IRUGO | S_IWUSR);

This can be "module_param" since the variable and parameter names are
the same.

> +MODULE_PARM_DESC(disable_ptm, "Don't automatically enable PCIe PTM even if supported.");

Since this can only be built in statically (it can't be a module),
this parameter would have to be specified on the kernel command line
(or, I guess, done via sysfs, which would only affect devices added
via hotplug).

What exactly would that look like?  Maybe we could include an example
in the changelog, e.g., "pcie_ptm.disable_ptm" or whatever it is.  I
don't use these often enough to remember the details and it's always a
hassle for me to figure out the module name.

If it really is "pcie_ptm.disable_ptm", that looks a little redundant.
Probably no need to mention "ptm" twice.  But I suppose that would be
a problem in sysfs?  Where does it show up there?

We do have some similar kernel command-line arguments like "noaer",
"noari", "nomsi", "nommconf".  We could consider that strategy
instead, and I might even prefer it since this is a switch for the PCI
core, not something related to a driver or a loadable module.

> +static int ptm_commit(struct pci_dev *dev)
> +{
> +	u32 dword;
> +	int pos;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> +
> +	/* Is this even possible? */
> +	if (!pos)
> +		return -ENXIO;

It makes me a little scared that it's not obvious whether this is
possible or not :)

I think it's not possible *except* that resetting the device throws a
monkey wrench in things.  When we reset a device, we retain all the
state, including the sysfs files and dev->is_ptm_* bits, but the reset
may have caused the device to load new firmware or otherwise change
its config space.  In that case, the new config space could have no
PTM capability.  Anyway, this scenario breaks lots of things, so I
guess you don't need to worry excessively here.

> +	pci_read_config_dword(dev, pos + PCI_PTM_CONTROL_REG_OFFSET, &dword);
> +	dword = dev->is_ptm_enabled ? dword | PCI_PTM_CTRL_ENABLE :
> +		dword & ~PCI_PTM_CTRL_ENABLE;
> +	dword = dev->is_ptm_root ? dword | PCI_PTM_CTRL_ROOT :
> +		dword & ~PCI_PTM_CTRL_ROOT;
> +
> +	/* Only requester should have it set */
> +	if (dev->is_ptm_requester)
> +		dword = dword | (((u32)dev->ptm_effective_granularity) << 8);
> +	return pci_write_config_dword(dev, pos + PCI_PTM_CONTROL_REG_OFFSET,
> +		dword);
> +}
> +
> +/**
> + * pci_enable_ptm - Try to activate PTM functionality on device.
> + * @dev: PCI Express device with PTM requester role to enable.
> + *
> + * All PCIe Switches/Bridges in between need to be enabled for this to work.
> + *
> + * NOTE: Each requester must be associated with a PTM root (not to be confused
> + * with a root port or root complex). There can be multiple PTM roots in a
> + * a system forming multiple domains. All intervening bridges/switches in a
> + * domain must support PTM responder roles to relay PTM dialogues.
> + */
> +int pci_enable_ptm(struct pci_dev *dev)
> +{
> +	int type;

Unused, remove.

> +	struct pci_dev *upstream;
> +
> +	upstream = pci_upstream_bridge(dev);
> +	type = pci_pcie_type(dev);
> +
> +	if (dev->is_ptm_root_capable) {
> +		/* If we are root capable but already part of a chain, don't set
> +		 * the root select bit, only enable PTM
> +		 */
> +		if (!upstream || !upstream->is_ptm_enabled)
> +			dev->is_ptm_root = 1;
> +		dev->is_ptm_enabled = 1;
> +	}
> +
> +	/* Is possible to be part of the PTM chain */
> +	if (dev->is_ptm_responder && upstream && upstream->is_ptm_enabled)
> +		dev->is_ptm_enabled = 1;

If we're trying to enable PTM on a device, and PTM is not enabled on
the upstream bridge, I think we should fail without touching the
register.  For example, if we're using sysfs to try to enable PTM on a
device below a non-PTM switch, the sysfs write should fail.
Currently, I think it will succeed.  PTM won't be enabled, but we will
write the config register and the sysfs write will return success.

> +
> +	if (dev->is_ptm_requester && upstream && upstream->is_ptm_enabled) {
> +		dev->is_ptm_enabled = 1;
> +		dev->ptm_effective_granularity =
> +			upstream->ptm_clock_granularity;

Per 7.32.3, software must program the Effective Granularity to the
"maximum Local Clock Granularity reported by the PTM Root and all
intervening PTM Time Sources."  So there should be some sort of a
max() somewhere here, shouldn't there?

The spec says this is only relevant for PTM Requesters, i.e.,
endpoints, and provides information about the expected PTM accuracy
but doesn't affect the PTM mechanism.  So I guess this is purely
informational?  But I suppose it would be good to have the right value
here for lspci.  (BTW, have you posted any lspci patches to dump the
PTM capability?)

> +	}
> +	return ptm_commit(dev);
> +}
> +
> +void pci_ptm_init(struct pci_dev *dev)
> +{
> +	u32 dword;
> +	int pos;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> +	if (!pos)
> +		return;
> +
> +	/* Fill in caps, masters are implied to be responders as well */
> +	pci_read_config_dword(dev, pos + PCI_PTM_CAPABILITY_REG_OFFSET, &dword);
> +	dev->is_ptm_capable = 1;
> +	dev->is_ptm_root_capable   = (dword & PCI_PTM_CAP_ROOT) ? 1 : 0;
> +	dev->is_ptm_responder      = (dword & PCI_PTM_CAP_RSP) ? 1 : 0;
> +	dev->is_ptm_requester      = (dword & PCI_PTM_CAP_REQ) ? 1 : 0;
> +	dev->ptm_clock_granularity = dev->is_ptm_responder ?
> +		((dword & PCI_PTM_GRANULARITY_MASK) >> 8) : 0;
> +	dev_info(&dev->dev, "Found PTM %s type device with %uns clock\n",

s/Found //
s/type //
s/device //

> +		dev->is_ptm_root_capable ? "root" :
> +		dev->is_ptm_responder ? "responder" :
> +		dev->is_ptm_requester ? "requester" : "unknown",
> +		dev->ptm_clock_granularity);

I think this printk needs to be expanded a little bit to avoid
confusion.  For example, endpoints will all say:

  PTM requester with 0ns clock

which is not really what we want to know.  For endpoints, I think what
we *do* want to know is their Effective Granularity.

And switches might say:

  PTM responder with 0ns clock

which really means "no local clock".

I think what we'd like to have is information like:

  - PTM root has granularity X
  - endpoint has some larger granularity Y
  - endpoint is limited because an intermediate switch has granularity Y

I'm not sure we know enough at this point in the code.  We might need
to know whether Root Select is set to figure out which clock (Local or
Effective) to print.

> +
> +	/* Get existing settings */
> +	pci_read_config_dword(dev, pos + PCI_PTM_CONTROL_REG_OFFSET, &dword);
> +	dev->is_ptm_enabled            = (dword & PCI_PTM_CTRL_ENABLE) ? 1 : 0;
> +	dev->is_ptm_root               = (dword & PCI_PTM_CTRL_ROOT) ? 1 : 0;
> +	dev->ptm_effective_granularity =
> +		(dword & PCI_PTM_GRANULARITY_MASK) >> 8;
> +
> +	if (!disable_ptm)
> +		pci_enable_ptm(dev);
> +}
> +
> +static int do_disable_ptm(struct pci_dev *dev, void *v)
> +{
> +	if (dev->is_ptm_enabled) {
> +		dev->is_ptm_enabled            = 0;
> +		dev->is_ptm_root               = 0;
> +		dev->ptm_effective_granularity = 0;
> +		ptm_commit(dev);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * pci_disable_ptm - Turn off PTM functionality on device.
> + * @dev: PCI Express device with PTM function to disable.
> + *
> + * Disables PTM functionality by clearing the PTM enable bit, if device is a
> + * switch/bridge it will also disable PTM function on other devices behind it.
> + */
> +void pci_disable_ptm(struct pci_dev *dev)

This is currently only used in this file, so it should be static (and
removed from pci.h).

> +{
> +	if (pci_is_bridge(dev))
> +		pci_walk_bus(dev->bus, &do_disable_ptm, NULL);

This is asymmetric: the sysfs enable path only enables PTM for one
device (and it will fail unless the upstream switch has PTM enabled),
so a user has to walk the tree manually, but the disable will disable
a whole tree.  Since we default to enabling PTM, I think the sysfs
interface is mostly for debugging, and doing it on individual devices
is fine.

Besides, I don't think this actually works correctly.  If you use this
on a switch, we disable PTM on everything *below* the switch, but not
on the switch itself.

> +	else
> +		do_disable_ptm(dev, NULL);
> +}
> +
> +static ssize_t ptm_status_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u16 word;
> +	int pos;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PTM);
> +	if (!pos)
> +		return -ENXIO;
> +
> +	pci_read_config_word(pdev, pos + PCI_PTM_CONTROL_REG_OFFSET, &word);

This is a 32-bit register; read it as a dword, even though the upper
bits are currently reserved.

> +	return sprintf(buf, "%u\n", word & PCI_PTM_CTRL_ENABLE ? 1 : 0);
> +}
> +
> +static ssize_t ptm_status_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	unsigned long val;
> +	ssize_t ret;
> +
> +	ret = kstrtoul(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +	if (val)
> +		return pci_enable_ptm(pdev);
> +	pci_disable_ptm(pdev);
> +	return 0;
> +}
> +
> +static DEVICE_ATTR_RW(ptm_status);
> +
> +void pcie_ptm_remove_sysfs_dev_files(struct pci_dev *dev)
> +{
> +	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM))
> +		return;
> +	device_remove_file(&dev->dev, &dev_attr_ptm_status);
> +}

This is called in the device remove path.  Obviously we want to
remove the sysfs file.  But we currently don't do anything to the PTM
capability itself.

What happens if the device has PTM enabled, we hotplug remove it
(using the sysfs interface so the device stays physically present and
powered up), manually disable PTM on the upstream switch, then hotplug
add the device back?  If the switch has PTM disabled but the device
has PTM enabled, that sounds like an illegal configuration.

Is this scenario possible?  Maybe the hotplug remove would power off
the device?  I guess the current pci_ptm_init() path actually would
disable PTM on the new device because it's disabled on the upstream
switch.

But since PTM is autonomous once enabled, I would assume the new
device (with PTM enabled) could send PTM messages upstream, and it
sounds (per sec 6.22.3) like those would be treated as Unsupported
Requests, which means we'd report errors.

I think we might want to disable PTM before we remove a device.

> +int pcie_ptm_create_sysfs_dev_files(struct pci_dev *dev)
> +{
> +	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM))
> +		return -ENXIO;
> +	return device_create_file(&dev->dev, &dev_attr_ptm_status);
> +}
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8004f67..9d5e96e6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1657,6 +1657,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_enable_acs(dev);
>  
>  	pci_cleanup_aer_error_status_regs(dev);
> +
> +	/* Enable PTM Capabilities */
> +	pci_ptm_init(dev);
>  }
>  
>  /*
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 004b813..ba5dab4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
 @@ -363,6 +363,17 @@ struct pci_dev {
>  	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
>  	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
>  	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
> +
> +#ifdef CONFIG_PCIE_PTM
> +	unsigned int	is_ptm_capable:1;
> +	unsigned int	is_ptm_root_capable:1;
> +	unsigned int	is_ptm_responder:1;
> +	unsigned int	is_ptm_requester:1;
> +	unsigned int	is_ptm_enabled:1;
> +	unsigned int	is_ptm_root:1;

s/is_// above.

> +	u8		ptm_clock_granularity;
> +	u8		ptm_effective_granularity;
> +#endif
>  #ifdef CONFIG_PCI_MSI
>  	const struct attribute_group **msi_irq_groups;
>  #endif
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 1becea8..9dd77be 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -670,7 +670,8 @@
>  #define PCI_EXT_CAP_ID_SECPCI	0x19	/* Secondary PCIe Capability */
>  #define PCI_EXT_CAP_ID_PMUX	0x1A	/* Protocol Multiplexing */
>  #define PCI_EXT_CAP_ID_PASID	0x1B	/* Process Address Space ID */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PASID
> +#define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
>  
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -946,4 +947,15 @@
>  #define PCI_TPH_CAP_ST_SHIFT	16	/* st table shift */
>  #define PCI_TPH_BASE_SIZEOF	12	/* size with no st table */
>  
> +/* Precision Time Measurement */
> +#define PCI_PTM_CAP_REQ			0x0001  /* Requester capable */
> +#define PCI_PTM_CAP_RSP			0x0002  /* Responder capable */
> +#define PCI_PTM_CAP_ROOT		0x0004  /* Root capable */
> +#define PCI_PTM_GRANULARITY_MASK	0xFF00  /* Local clock granularity */
> +#define PCI_PTM_CTRL_ENABLE		0x0001  /* PTM enable */
> +#define PCI_PTM_CTRL_ROOT		0x0002  /* Root select */
> +#define PCI_PTM_HEADER_REG_OFFSET       0x00	/* PTM version and such */

Unused, remove.

> +#define PCI_PTM_CAPABILITY_REG_OFFSET   0x04	/* Capabilities */
> +#define PCI_PTM_CONTROL_REG_OFFSET      0x08	/* Control reg */

Follow existing style in this file for these #defines.  For example:

  - Offsets into the capability do not need "REG_OFFSET", e.g., use
    "#define PCI_PTM_CAP 0x04" and #define PCI_PTM_CTRL 0x08".

  - Definitions sorted by offset into capability, e.g.,
      #define PCI_PTM_CAP ...
      #define  PCI_PTM_CAP_REQ ...
      ...
      #define PCI_PTM_CTRL ...
      #define  PCI_PTM_CTRL_ENABLE ...

  - Definitions for bits inside a register indented an extra space,
    e.g., "#define  PCI_PTM_CAP_REQ ..."

  - The PTM Capability and Control registers are 32 bits wide, so use
    32-bit constants for the bits and fields in them, e.g.,
    "#define PCI_PTM_GRANULARITY_MASK 0x0000FF00"
