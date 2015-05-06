Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34678 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbbEFTWH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2015 15:22:07 -0400
Received: by iget9 with SMTP id t9so104759379ige.1
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2015 12:22:06 -0700 (PDT)
Date: Wed, 6 May 2015 14:22:01 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	" David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>, m-karicheri2@ti.com,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@stlinux.com, linux-pci@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	Gabriel Fernandez <gabriel.fernandez@linaro.org>
Subject: Re: [PATCH v3 4/5] pci: designware: remove pci_common_init_dev()
Message-ID: <20150506192201.GF24643@google.com>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
 <1428657168-12495-5-git-send-email-gabriel.fernandez@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428657168-12495-5-git-send-email-gabriel.fernandez@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 10, 2015 at 11:12:47AM +0200, Gabriel FERNANDEZ wrote:
> Call directly pci_*() instead of using pci_common_init_dev().
> Enforce error handling in probe.
> It also allows st pcie driver not to declare IO space:
> pci_common_init_dev() is assigning one by default.

Can you verify that none of the other users (dra7xx, exynos, etc.) depends
on the default I/O space, and mention that here?

> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

This requires an ack from Jingoo (DesignWare maintainer), of course.
I think this code is used by dra7xx, exynos, imx6, spear13xx, keystone, and
layerscape.  It'd be nice to have some review and testing from them, too.

> ---
>  drivers/pci/host/pcie-designware.c | 62 ++++++++++++++++++++------------------
>  drivers/pci/host/pcie-designware.h |  1 +
>  2 files changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 1f4ea6f..d4b1bf7 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -67,8 +67,6 @@
>  #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
>  #define PCIE_ATU_UPPER_TARGET		0x91C
>  
> -static struct hw_pci dw_pci;
> -
>  static unsigned long global_io_offset;
>  
>  static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
> @@ -342,6 +340,9 @@ static const struct irq_domain_ops msi_domain_ops = {
>  	.map = dw_pcie_msi_map,
>  };
>  
> +static int dw_pcie_setup(struct pci_sys_data *sys);
> +static struct pci_bus *dw_pcie_scan_bus(struct pci_sys_data *sys);
> +
>  int __init dw_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct device_node *np = pp->dev->of_node;
> @@ -352,6 +353,9 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  	u32 val, na, ns;
>  	const __be32 *addrp;
>  	int i, index, ret;
> +	struct list_head *resources = &pp->sysdata.resources;
> +
> +	INIT_LIST_HEAD(resources);
>  
>  	/* Find the address cell size and the number of cells in order to get
>  	 * the untranslated address.
> @@ -504,13 +508,17 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  
>  #ifdef CONFIG_PCI_MSI
>  	dw_pcie_msi_chip.dev = pp->dev;
> -	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
> +	pp->sysdata.msi_ctrl = &dw_pcie_msi_chip;
>  #endif
>  
> -	dw_pci.nr_controllers = 1;
> -	dw_pci.private_data = (void **)&pp;
> +	pp->sysdata.private_data = pp;
>  
> -	pci_common_init_dev(pp->dev, &dw_pci);
> +	ret = dw_pcie_setup(&pp->sysdata);

It's not completely obvious that replacing pci_common_init_dev() with
dw_pcie_setup() is equivalent.  Here are my notes from trying to convince
myself that this is correct.  I think your changelog could stand some 
enhancement.  It would be ideal if you could break this into a few smaller
patches that were more obviously correct, but I suspect it's too
intertwined to do that.

Here's an outline of pci_common_init_dev():

  pci_common_init_dev(parent, hw)
    pci_add_flags(PCI_REASSIGN_ALL_RSRC)           # [1]
    if (hw->preinit)
      hw->preinit                                  # [2]
    pcibios_init_hw
      for (nr = 0; nr < hw->nr_controllers;        # [3]
          sys = kzalloc                            # [4]
          sys->msi_ctrl = hw->msi_ctrl             # [5]
          sys->busnr = busnr                       # [6]
          sys->swizzle = hw->swizzle               # [7]
          sys->map_irq = hw->map_irq               # [8]
          sys->align_resource = hw->align_resource # [9]
          INIT_LIST_HEAD(&sys->resources)          # [10]
          sys->private_data = hw->private_data     # [11]
          hw->setup                                # [12]
          pcibios_init_resources                   # [13]
          hw->scan                                 # [14]
    if (hw->postinit)
      hw->postinit                                 # [15]
    pci_fixup_irqs                                 # [16]
    list_for_each_entry(sys, &head,                # [17]
      if (!pci_has_flag(PCI_PROBE_ONLY))           # [18]
        pci_bus_size_bridges                       # [19]
        pci_bus_assign_resources
      pci_bus_add_devices
    list_for_each_entry(sys, &head,
      ...
        pcie_bus_configure_settings                # [20]

[1] You don't set PCI_REASSIGN_ALL_RSRC; have you verified that nobody
cares about that?

[2] dw_pci.preinit was NULL, so skipping this doesn't matter; looks OK.

[3] dw_pci.nr_controllers was always 1, so skipping the loop doesn't
matter; looks OK.

[4] You added struct pci_sys_data sysdata as a member of struct
pcie_port, so it is now allocated by dw_pcie_host_init() callers, e.g.,
st_pcie_probe(); looks OK.

[5] You set pp->sysdata.msi_ctrl in dw_pcie_host_init() instead of
pcibios_init_hw(); looks OK. 

[6] Since dw_pci.nr_controllers was always 1, sys->busnr was always 0.
You don't set sys->busnr, so it will retain its initial zero value.  OK, I
guess.  It's still a little broken that we have both pp->busn and
pp->sysdata.busnr, but you didn't break it and it's OK that you didn't
change anything in this regard.

[7] dw_pci.swizzle was NULL, so pcibios_swizzle() would default to
pci_common_swizzle(), which is what you use when you call pci_fixup_irqs()
in dw_pcie_scan_bus(); looks OK.

[8] dw_pci.map_irq was dw_pcie_map_irq() (which used
of_irq_parse_and_map_pci()) and sys->map_irq was used by pcibios_map_irq().
You call pci_fixup_irqs() and pass a pointer to of_irq_parse_and_map_pci();
looks OK.

[9] dw_pci.align_resource was NULL, and I assume
pcie_port.sysdata.align_resource was initialized to zeroes; looks OK.

[10] You call INIT_LIST_HEAD() in dw_pcie_host_init() instead of
pcibios_init_hw(); looks OK.

[11] You set sys->private_data in dw_pcie_host_init() instead of
pcibios_init_hw(); looks OK.

[12] dw_pci.setup was dw_pcie_setup(), and you call that from
dw_pcie_host_init(); looks OK.

[13] You no longer call pcibios_init_resources().  You don't want the
default I/O space, which makes sense; looks OK (but you need to audit other
users and make sure they don't need it either).

[14] dw_pci.scan was dw_pcie_scan_bus(), and you call that from
dw_pcie_host_init(); looks OK.

[15] dw_pci.postinit was NULL, so skipping this doesn't matter; looks OK.

[16] You call pci_fixup_irqs() from dw_pcie_scan_bus() instead of
pci_common_init_dev(); looks OK.

[17] "head" is a local list in pci_common_init_dev(), and you don't need
anything similar because dw_pcie_host_init() is called once per host
bridge; looks OK.

[18] You don't test PCI_PROBE_ONLY; it looks like it can still be set by
booting with "pci=firmware".  So previously, "pci=firmware" prevented
resource assignment, but it no longer does.  Is that right?  Is that what
you intend?

[19] Instead of pci_bus_size_bridges() and pci_bus_assign_resources(), you
call pci_assign_unassigned_bus_resources() from dw_pcie_scan_bus().  That
seems like an improvement because it holds pci_bus_sem and supplies
add_list; looks OK.

[20] I think you no longer call pcie_bus_configure_settings().  That
configured MPS settings, and I think you still want to do that, don't you?

> +	if (ret)
> +		return ret;
> +
> +	if (!dw_pcie_scan_bus(&pp->sysdata))
> +		return -ENXIO;
>  
>  	return 0;
>  }
> @@ -701,15 +709,19 @@ static struct pci_ops dw_pcie_ops = {
>  	.write = dw_pcie_wr_conf,
>  };
>  
> -static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
> +static int dw_pcie_setup(struct pci_sys_data *sys)
>  {
>  	struct pcie_port *pp;
> +	int err;
>  
>  	pp = sys_to_pcie(sys);
>  
>  	if (global_io_offset < SZ_1M && pp->io_size > 0) {
>  		sys->io_offset = global_io_offset - pp->io_bus_addr;
> -		pci_ioremap_io(global_io_offset, pp->io_base);
> +		err = pci_ioremap_io(global_io_offset, pp->io_base);
> +		if (err)
> +			return err;
> +
>  		global_io_offset += SZ_64K;
>  		pci_add_resource_offset(&sys->resources, &pp->io,
>  					sys->io_offset);
> @@ -719,10 +731,10 @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
>  	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
>  	pci_add_resource(&sys->resources, &pp->busn);
>  
> -	return 1;
> +	return 0;
>  }
>  
> -static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
> +static struct pci_bus *dw_pcie_scan_bus(struct pci_sys_data *sys)
>  {
>  	struct pci_bus *bus;
>  	struct pcie_port *pp = sys_to_pcie(sys);
> @@ -738,27 +750,13 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>  	if (bus && pp->ops->scan_bus)
>  		pp->ops->scan_bus(pp);
>  
> -	return bus;
> -}
> -
> -static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> -{
> -	struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
> -	int irq;
> -
> -	irq = of_irq_parse_and_map_pci(dev, slot, pin);
> -	if (!irq)
> -		irq = pp->irq;
> +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +	pci_assign_unassigned_bus_resources(bus);
> +	pci_bus_add_devices(bus);
>  
> -	return irq;
> +	return bus;
>  }
>  
> -static struct hw_pci dw_pci = {
> -	.setup		= dw_pcie_setup,
> -	.scan		= dw_pcie_scan_bus,
> -	.map_irq	= dw_pcie_map_irq,
> -};
> -
>  void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
>  	u32 val;
> @@ -822,8 +820,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	/* setup command register */
>  	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
>  	val &= 0xffff0000;
> -	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> -		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> +
> +	if (!pp->io_size)
> +		val |= PCI_COMMAND_IO;
> +
> +	val |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> +
>  	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
>  }
>  
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index d0bbd27..45bc2c2 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -46,6 +46,7 @@ struct pcie_port {
>  	struct resource		io;
>  	struct resource		mem;
>  	struct resource		busn;
> +	struct pci_sys_data	sysdata;
>  	int			irq;
>  	u32			lanes;
>  	struct pcie_host_ops	*ops;
> -- 
> 1.9.1
> 
