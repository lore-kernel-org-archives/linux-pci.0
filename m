Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45336 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932101AbcCKPxp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 10:53:45 -0500
Date: Fri, 11 Mar 2016 09:53:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: PTM preliminary implementation
Message-ID: <20160311155332.GA31716@localhost>
References: <1457681184-20439-1-git-send-email-jonathan.yong@intel.com>
 <1457681184-20439-2-git-send-email-jonathan.yong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457681184-20439-2-git-send-email-jonathan.yong@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jonathan,

Sorry I didn't see this earlier.  I don't follow linux-kernel, so I
didn't see it until it appeared on linux-pci.  I don't have time for a
full review right now since the merge window is about to open, but
I'll give you some first impressions to get started.

On Fri, Mar 11, 2016 at 07:26:24AM +0000, Yong, Jonathan wrote:
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
>  drivers/pci/pci-sysfs.c     |   7 +
>  drivers/pci/pci.h           |  21 +++
>  drivers/pci/pcie/Kconfig    |   8 +
>  drivers/pci/pcie/Makefile   |   2 +-
>  drivers/pci/pcie/pcie_ptm.c | 353 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c         |   3 +
>  6 files changed, 393 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/pcie/pcie_ptm.c
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 95d9e7b..c634fd11 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1335,6 +1335,9 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>  	/* Active State Power Management */
>  	pcie_aspm_create_sysfs_dev_files(dev);
>  
> +	/* PTM */

Don't add comments like this that merely repeat the code.

> +	pci_create_ptm_sysfs(dev);
> +
>  	if (!pci_probe_reset_function(dev)) {
>  		retval = device_create_file(&dev->dev, &reset_attr);
>  		if (retval)
> @@ -1433,6 +1436,10 @@ static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
>  	}
>  
>  	pcie_aspm_remove_sysfs_dev_files(dev);
> +
> +	/* PTM */
> +	pci_release_ptm_sysfs(dev);
> +
>  	if (dev->reset_fn) {
>  		device_remove_file(&dev->dev, &reset_attr);
>  		dev->reset_fn = 0;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9a1660f..fb90420 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -320,6 +320,27 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
>  
>  void pci_enable_acs(struct pci_dev *dev);
>  
> +#ifdef CONFIG_PCIEPORTBUS
> +int pci_enable_ptm(struct pci_dev *dev);
> +void pci_create_ptm_sysfs(struct pci_dev *dev);
> +void pci_release_ptm_sysfs(struct pci_dev *dev);
> +void pci_disable_ptm(struct pci_dev *dev);
> +#else
> +static inline int pci_enable_ptm(struct pci_dev *dev)
> +{
> +	return -ENXIO;
> +}
> +static inline void pci_create_ptm_sysfs(struct pci_dev *dev)
> +{
> +}
> +static inline void pci_release_ptm_sysfs(struct pci_dev *dev)
> +{
> +}
> +static inline void pci_disable_ptm(struct pci_dev *dev)
> +{
> +}
> +#endif
> +
>  struct pci_dev_reset_methods {
>  	u16 vendor;
>  	u16 device;
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index e294713..f65ff4d 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -80,3 +80,11 @@ endchoice
>  config PCIE_PME
>  	def_bool y
>  	depends on PCIEPORTBUS && PM
> +
> +config PCIE_PTM
> +	bool "Turn on Precision Time Management by default"
> +	depends on PCIEPORTBUS
> +	help
> +	  Say Y here to enable PTM feature on PCI Express devices that
> +	  support them as they are found during device enumeration. Otherwise
> +	  the feature can be enabled manually through sysfs entries.
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 00c62df..d18b4c7 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -5,7 +5,7 @@
>  # Build PCI Express ASPM if needed
>  obj-$(CONFIG_PCIEASPM)		+= aspm.o
>  
> -pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o
> +pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o pcie_ptm.o
>  pcieportdrv-$(CONFIG_ACPI)	+= portdrv_acpi.o
>  
>  obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
> diff --git a/drivers/pci/pcie/pcie_ptm.c b/drivers/pci/pcie/pcie_ptm.c
> new file mode 100644
> index 0000000..a128c79
> --- /dev/null
> +++ b/drivers/pci/pcie/pcie_ptm.c
> @@ -0,0 +1,353 @@
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
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include "../pci.h"
> +
> +#define PCI_PTM_REQ		0x0001  /* Requester capable */
> +#define  PCI_PTM_RSP		0x0002  /* Responder capable */
> +#define  PCI_PTM_ROOT		0x0004  /* Root capable */
> +#define  PCI_PTM_GRANULITY	0xFF00  /* Local clock granulity */

s/granulity/granularity/

> +#define PCI_PTM_ENABLE		0x0001  /* PTM enable */
> +#define  PCI_PTM_ROOT_SEL	0x0002  /* Root select */
> +
> +#define PCI_PTM_HEADER_REG_OFFSET	0x00
> +#define PCI_PTM_CAPABILITY_REG_OFFSET	0x04
> +#define PCI_PTM_CONTROL_REG_OFFSET	0x08
> +
> +#define PCI_EXT_CAP_ID_PTM		0x001f

These should go in include/uapi/linux/pci_regs.h along with the other
PCI capability definitions.  Obviously they should match the style of
the existing code there.

> +#ifdef CONFIG_PCIE_PTM
> +static bool disable_ptm;
> +#else
> +static bool disable_ptm = 1;
> +#endif
> +
> +module_param_named(disable_ptm, disable_ptm, bool, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(disable_ptm,
> +	"Don't automatically enable even if supported.");
> +
> +static inline u8 get_granularity(u32 in)
> +{
> +	return (in & PCI_PTM_GRANULITY) >> 8;
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
> +	return sprintf(buf, "%u\n", word & PCI_PTM_ENABLE);
> +}
> +
> +static ssize_t ptm_status_store(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	unsigned long val;
> +	ssize_t ret;
> +	int pos;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PTM);
> +	if (!pos)
> +		return -ENXIO;
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
> +void pci_release_ptm_sysfs(struct pci_dev *dev)
> +{
> +	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM))
> +		return;
> +	device_remove_file(&dev->dev, &dev_attr_ptm_status);
> +}
> +
> +void pci_create_ptm_sysfs(struct pci_dev *dev)
> +{
> +	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM))
> +		return;
> +	device_create_file(&dev->dev, &dev_attr_ptm_status);
> +}
> +
> +/**
> + * pci_enable_ptm - Try to activate PTM functionality on device.
> + * @dev: PCI Express device with PTM requester role to enable.
> + *
> + * The function will crawl through the PCI Hierarchy to determine if it is
> + * possible to enable the Precision Time Measurement requester role on @dev,
> + * and if so, activate it by setting the granularity field.
> + *
> + * NOTE: Each requester must be associated with a PTM root (not to be confused
> + * with a root port or root complex). There can be multiple PTM roots in a
> + * a system forming multiple domains. All intervening bridges/switches in a
> + * domain must support PTM responder roles to relay PTM dialogues.
> + */
> +int pci_enable_ptm(struct pci_dev *dev)
> +{

This function is way too long to review as it is.  Can you split it up
somehow?

> +	struct pci_dev *curr, **steps;
> +	size_t i = 0, root = 0;
> +	int pos, pos2;
> +	u8 granularity = 0;
> +	u16 word;
> +	int ret = 0;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> +	if (!pos) {
> +		dev_dbg(&dev->dev, "Not PTM capable, skipping.\n");
> +		return -ENXIO;
> +	}
> +
> +	if (disable_ptm)
> +		return 0;
> +
> +	/* Skip if not requester role. */
> +	pci_read_config_word(dev, pos + PCI_PTM_CAPABILITY_REG_OFFSET, &word);
> +	if (!(word & PCI_PTM_REQ)) {
> +		dev_dbg(&dev->dev, "Not a PTM requester, skipping for now.\n");
> +		return 0;
> +	}
> +
> +	/* Just copy and enable PTM granularity for integrated endpoints. */
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> +		dev_dbg(&dev->dev,
> +			"Root integrated endpoint, attempting to copy root granularity.\n");
> +		curr = pci_upstream_bridge(dev);
> +		if (!curr)
> +			return 0;
> +
> +		pos2 = pci_find_ext_capability(curr, PCI_EXT_CAP_ID_PTM);
> +		if (!pos2)
> +			return 0;
> +
> +		/* Get granularity field. */
> +		pci_read_config_word(curr,
> +			pos2 + PCI_PTM_CAPABILITY_REG_OFFSET,
> +			&word);
> +		word &= PCI_PTM_GRANULITY;
> +
> +		/* Copy it over. */
> +		word |= PCI_PTM_ENABLE;
> +		pci_write_config_word(dev, pos + PCI_PTM_CONTROL_REG_OFFSET,
> +			word);
> +
> +		/* Enable PTM on root complex if not already so. */
> +		pci_read_config_word(curr, pos2 + PCI_PTM_CONTROL_REG_OFFSET,
> +			&word);
> +		if (!(word & PCI_PTM_ENABLE)) {
> +			pci_read_config_word(curr,
> +				pos2 + PCI_PTM_CONTROL_REG_OFFSET, &word);
> +			word |= PCI_PTM_ENABLE | PCI_PTM_ROOT_SEL;
> +			pci_write_config_word(curr,
> +				pos2 + PCI_PTM_CONTROL_REG_OFFSET, word);
> +		}
> +	} else {
> +		/* For holding all the bridge/switches in between. */
> +		steps = kzalloc(sizeof(*steps) * dev->bus->number + 1,
> +			GFP_KERNEL);
> +		if (!steps)
> +			return -ENOMEM;
> +
> +		/* Gather all the upstream devices. */
> +		curr = pci_upstream_bridge(dev);
> +		if (curr) {
> +			dev_dbg(&dev->dev,
> +				"Upstream is %d:%d:%x.%d\n",
> +				pci_domain_nr(curr->bus),
> +				curr->bus->number,
> +				PCI_SLOT(curr->devfn),
> +				PCI_FUNC(curr->devfn)
> +				);
> +		} else {
> +			dev_dbg(&dev->dev, "No upstream??\n");
> +			ret = -ENXIO;
> +			goto abort;
> +		}
> +
> +		do {
> +			/* sanity check */
> +			if (i > dev->bus->number)
> +				break;
> +			steps[i++] = curr;
> +		} while ((curr = pci_upstream_bridge(curr)));
> +
> +		/* Check upstream chains capability. */
> +		dev_dbg(&dev->dev,
> +				   "Checking hierarchy capabilities\n");
> +		for (i = 0; i < dev->bus->number + 1; i++) {
> +			curr = steps[i];
> +			if (!curr)
> +				break;
> +
> +			pos2 = pci_find_ext_capability(curr,
> +				PCI_EXT_CAP_ID_PTM);
> +
> +			if (!pos2) {
> +				dev_dbg(&curr->dev,
> +					"PTM Hierarchy %zx: not PTM aware\n",
> +					i);
> +				break;
> +			}
> +
> +			/* End if upstream cannot respond. */
> +			pci_read_config_word(curr,
> +				pos2 + PCI_PTM_CAPABILITY_REG_OFFSET, &word);
> +			if (!(word & PCI_PTM_RSP)) {
> +				dev_dbg(&curr->dev,
> +				"PTM Hierarchy: skipping non-responder\n");
> +				break;
> +			}
> +
> +			/* Is root capable? */
> +			if (word & PCI_PTM_ROOT) {
> +				root = i;
> +				granularity = get_granularity(word);
> +			}
> +		}
> +
> +		if (!steps[root]) {
> +			dev_dbg(&dev->dev, "Cannot find root, aborting\n");
> +			ret = -ENXIO;
> +			goto abort;
> +		}
> +
> +		dev_dbg(&dev->dev,
> +			"Found PTM root at %d:%d:%x.%d granularity %u\n",
> +			pci_domain_nr(steps[root]->bus),
> +			steps[root]->bus->number,
> +			PCI_SLOT(steps[root]->devfn),
> +			PCI_FUNC(steps[root]->devfn),
> +			granularity);
> +
> +		/* Program granularity field. */
> +		for (i = root;;) {
> +			curr = steps[i];
> +			pos2 = pci_find_ext_capability(curr,
> +				PCI_EXT_CAP_ID_PTM);
> +			pci_read_config_word(curr,
> +				pos2 + PCI_PTM_CONTROL_REG_OFFSET, &word);
> +
> +			/* If not yet PTM enabled. */
> +			if (!(word & PCI_PTM_ENABLE)) {
> +				pci_read_config_word(curr,
> +					pos2 + PCI_PTM_CAPABILITY_REG_OFFSET,
> +					&word);
> +				/* If requester capable, program granularity. */
> +				if (word & PCI_PTM_REQ) {
> +					dev_dbg(&curr->dev,
> +						"Programming granularity %u\n",
> +						granularity);
> +					pci_write_config_word(curr,
> +						pos2 +
> +						PCI_PTM_CONTROL_REG_OFFSET,
> +						((u16)granularity) << 8);
> +				}
> +				if ((word & PCI_PTM_ROOT) &&
> +					granularity != 0 &&
> +					((granularity < get_granularity(word))
> +					|| get_granularity(word) == 0)) {
> +					dev_dbg(&curr->dev,
> +					"Updating granularity %u to %u\n",
> +						granularity,
> +						get_granularity(word));
> +					granularity = get_granularity(word);
> +				}
> +			}
> +			if (!i)
> +				break;
> +			i--;
> +		}
> +
> +		/* Program current device granularity and enable it. */
> +		pci_read_config_word(dev, pos + PCI_PTM_CONTROL_REG_OFFSET,
> +			&word);
> +		word = (word & ~PCI_PTM_GRANULITY) | ((u16)granularity) << 8
> +			| PCI_PTM_ENABLE;
> +		pci_write_config_word(dev, pos + PCI_PTM_CONTROL_REG_OFFSET,
> +			word);
> +		dev_dbg(&dev->dev,
> +				"Using granularity %u, %x\n", granularity,
> +				word);
> +
> +		/* Enable PTM root. */
> +		pos2 = pci_find_ext_capability(steps[root],
> +			PCI_EXT_CAP_ID_PTM);
> +		pci_read_config_word(steps[root],
> +			pos2 + PCI_PTM_CONTROL_REG_OFFSET, &word);
> +		word |= PCI_PTM_ROOT_SEL | PCI_PTM_ENABLE;
> +		pci_write_config_word(steps[root],
> +			pos2 + PCI_PTM_CONTROL_REG_OFFSET, word);
> +
> +		/* PTM enable from the bottom up. */
> +		for (i = 0; i <= root; i++) {
> +			pos2 = pci_find_ext_capability(steps[i],
> +				PCI_EXT_CAP_ID_PTM);
> +			pci_read_config_word(steps[i],
> +				pos2 + PCI_PTM_CONTROL_REG_OFFSET, &word);
> +			word |= PCI_PTM_ENABLE;
> +			pci_write_config_word(steps[i],
> +				pos2 + PCI_PTM_CONTROL_REG_OFFSET,
> +				word);
> +		}

I haven't read the PTM spec yet so I don't know how it works.  But in
general, I don't like having to tweak a setting all the way up the
hierarchy based on a leaf device.  That makes it hard to handle
hotplug correctly, because obviously there may be many leaf devices
that share part of all of the upstream path.

> +abort:
> +		kfree(steps);
> +	}
> +	return ret;
> +}
> +
> +static int do_disable_ptm(struct pci_dev *dev, void *v)
> +{
> +	int pos;
> +	u16 word;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> +	if (!pos)
> +		return 0;
> +
> +	pci_read_config_word(dev, pos + PCI_PTM_CONTROL_REG_OFFSET, &word);
> +	word &= ~PCI_PTM_ENABLE;
> +	pci_write_config_word(dev, pos + PCI_PTM_CONTROL_REG_OFFSET, word);
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
> +{
> +	if (pci_is_bridge(dev))
> +		pci_walk_bus(dev->bus, &do_disable_ptm, NULL);
> +	else
> +		do_disable_ptm(dev, NULL);
> +}
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6d7ab9b..8dc8bbc 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1623,6 +1623,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_enable_acs(dev);
>  
>  	pci_cleanup_aer_error_status_regs(dev);
> +
> +	/* Enable PTM Capabilities */

Another superfluous comment.  No need to repeat what the code already
says.

> +	pci_enable_ptm(dev);
>  }
>  
>  /*
> -- 
> 2.4.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
