Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:10656 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735AbbJIGiP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 02:38:15 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [PATCH v6 0/3] PCI: designware: change dw_pcie_cfg_write() and
 dw_pcie_cfg_read()
Date: Fri, 9 Oct 2015 06:37:58 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1623DA41@lhreml503-mbs>
References: <1443543636-35105-1-git-send-email-gabriele.paoloni@huawei.com>
 <20151008192558.GF3885@localhost>
In-Reply-To: <20151008192558.GF3885@localhost>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 08 October 2015 20:26
> To: Gabriele Paoloni
> Cc: bhelgaas@google.com; jingoohan1@gmail.com; pratyush.anand@gmail.com;
> linux-pci@vger.kernel.org; Wangzhou (B); Yuanzhichang; Zhudacai; zhangjukuo;
> qiuzhenfa; Liguozhu (Kenneth)
> Subject: Re: [PATCH v6 0/3] PCI: designware: change dw_pcie_cfg_write() and
> dw_pcie_cfg_read()
> 
> On Wed, Sep 30, 2015 at 12:20:33AM +0800, Gabriele Paoloni wrote:
> > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> >
> > This patchset:
> > 1) fixes a bug in spear13xx when calling dw_pcie_cfg_read and
> >    dw_pcie_cfg_write usign the patch from Pratyush in
> >    https://lkml.org/lkml/2015/9/7/5
> > 2) reworks dw_pcie_cfg_read/dw_pcie_cfg_write in pcie-designware.c in
> >    order to make it easier for callers to pass input parameters;
> > 3) changes dw_pcie_cfg_read implementation to make it symmetric with
> >    dw_pcie_cfg_write
> > 4) adds sanity checks in dw_pcie_cfg_read/dw_pcie_cfg_write to make
> >    sure the PCI header offset does not conflict with the size of
> >    the read/written field.
> >
> > Changes from v5: sanity check readibility simplified
> >
> > Changes from v4:
> >    - included https://lkml.org/lkml/2015/9/7/5 back as it was lost in v4
> >
> > Changes from v3:
> >    - changed dw_pcie_cfg_read implementation to make it symmetric with
> >      dw_pcie_cfg_write
> >    - changed dw_pcie_cfg_read/dw_pcie_cfg_write implementations to take
> >      as input param directly the address of the field to read/write rather
> >      than the base address and the offset in the PCI header
> >
> > Change from v2:
> >    Replaced patch 1/3 with Pratyush one in
> >    https://lkml.org/lkml/2015/9/7/5
> >
> > gabriele paoloni (3):
> >   PCIe: SPEAr13xx: fix dw_pcie_cfg_read/write() usage
> >   PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
> >   PCI: designware: add sanity checks on the header offset in
> >     dw_pcie_cfg_read and dw_pcie_cfg_write
> 
> Applied to pci/host-designware for v4.4.  I tweaked a couple things:

Great Many Thanks Bjorn!

> 
>   - Split out the dw_pcie_cfg_read() access size change into its own
>     patch.  This is an important change that got obscured by being
>     combined with the interface change.  Splitting it out makes both
>     patches much easier to review.

Yes agreed

> 
>   - In dw_pcie_cfg_read(), I set *val to zero when we return failure.
>     Previously we always set "*val = readl(addr)" even if we later
>     returned failure.  That could have been garbage or a misaligned
>     read.

Yes you re right, I missed that point. Thanks for fixing.

> 
> Below are the patches as I applied them.  Thanks!
> 
> Bjorn
> 
> 
> commit 0951120a4c778cf043497e4af508588417bef29a
> Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Date:   Wed Sep 30 00:20:34 2015 +0800
> 
>     PCI: spear: Fix dw_pcie_cfg_read/write() usage
> 
>     The first argument of dw_pcie_cfg_read/write() is a 32-bit aligned address.
>     The second argument is the byte offset into a 32-bit word, and
>     dw_pcie_cfg_read/write() only look at the low two bits.
> 
>     SPEAr13xx used dw_pcie_cfg_read() and dw_pcie_cfg_write() incorrectly: it
>     passed important address bits in the second argument, where they were
>     ignored.
> 
>     Pass the complete 32-bit word address in the first argument and only the
>     2-bit offset into that word in the second argument.
> 
>     Without this fix, SPEAr13xx host will never work with few buggy gen1 card
>     which connects with only gen1 host and also with any endpoint which would
>     generate a read request of more than 128 bytes.
> 
>     [bhelgaas: changelog]
>     Reported-by: Bjorn Helgaas <bhelgaas@google.com>
>     Signed-off-by: Pratyush Anand <panand@redhat.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     CC: stable@vger.kernel.org	# v3.17+
> 
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-
> spear13xx.c
> index 98d2683..0754ea3 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -163,34 +163,36 @@ static int spear13xx_pcie_establish_link(struct
> pcie_port *pp)
>  	 * default value in capability register is 512 bytes. So force
>  	 * it to 128 here.
>  	 */
> -	dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, &val);
> +	dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL,
> +				0, 2, &val);
>  	val &= ~PCI_EXP_DEVCTL_READRQ;
> -	dw_pcie_cfg_write(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, val);
> +	dw_pcie_cfg_write(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL,
> +				0, 2, val);
> 
> -	dw_pcie_cfg_write(pp->dbi_base, PCI_VENDOR_ID, 2, 0x104A);
> -	dw_pcie_cfg_write(pp->dbi_base, PCI_DEVICE_ID, 2, 0xCD80);
> +	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 0, 2, 0x104A);
> +	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 2, 2, 0xCD80);
> 
>  	/*
>  	 * if is_gen1 is set then handle it, so that some buggy card
>  	 * also works
>  	 */
>  	if (spear13xx_pcie->is_gen1) {
> -		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCAP, 4,
> -				 &val);
> +		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
> +					0, 4, &val);
>  		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
>  			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
>  			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
> -			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
> -					  PCI_EXP_LNKCAP, 4, val);
> +			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
> +						PCI_EXP_LNKCAP, 0, 4, val);
>  		}
> 
> -		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCTL2, 4,
> -				 &val);
> +		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
> +					0, 2, &val);
>  		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
>  			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
>  			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
> -			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
> -					  PCI_EXP_LNKCTL2, 4, val);
> +			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
> +						PCI_EXP_LNKCTL2, 0, 2, val);
>  		}
>  	}
> 
> 
> commit 6e5d5205ccb07c95931412f1e6fdb9ec5abc8dfd
> Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Date:   Thu Oct 8 11:45:41 2015 -0500
> 
>     PCI: designware: Use exact access size in dw_pcie_cfg_read()
> 
>     dw_pcie_cfg_write() uses the exact 8-, 16-, or 32-bit access size
>     requested, but dw_pcie_cfg_read() previously performed a 32-bit read and
>     masked out the bits requested.
> 
>     Use the exact access size in dw_pcie_cfg_read().  For example, if we want
>     an 8-bit read, use readb() instead of using readl() and masking out the 8
>     bits we need.  This makes it symmetric with dw_pcie_cfg_write().
> 
>     [bhelgaas: split into separate patch, set *val = 0 in failure case]
>     Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-
> designware.c
> index 52aa6e3..9073722 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -82,14 +82,16 @@ static inline struct pcie_port *sys_to_pcie(struct
> pci_sys_data *sys)
> 
>  int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
>  {
> -	*val = readl(addr);
> -
> -	if (size == 1)
> -		*val = (*val >> (8 * (where & 3))) & 0xff;
> +	if (size == 4)
> +		*val = readl(addr);
>  	else if (size == 2)
> -		*val = (*val >> (8 * (where & 3))) & 0xffff;
> -	else if (size != 4)
> +		*val = readw(addr + (where & 2));
> +	else if (size == 1)
> +		*val = readb(addr + (where & 1));
> +	else {
> +		*val = 0;
>  		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> 
>  	return PCIBIOS_SUCCESSFUL;
>  }
> 
> commit 060ca07e0d22f150d237e8d8e7149a88c3055e9a
> Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Date:   Wed Sep 30 00:20:35 2015 +0800
> 
>     PCI: designware: Simplify dw_pcie_cfg_read/write() interfaces
> 
>     Callers of dw_pcie_cfg_read() and dw_pcie_cfg_write() previously had to
>     split the address into "addr" and "where".  The callees assumed "addr" was
>     32-bit aligned (with zeros in the low two bits) and they used only the low
>     two bits of "where".
> 
>     Accept the entire address in "addr" and drop the now-redundant "where"
>     argument.  As an example, this replaces this:
> 
>       int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
>         *val = readb(addr + (where & 1));
> 
>     with this:
> 
>       int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
>         *val = readb(addr):
> 
>     [bhelgaas: changelog, split access size change to separate patch]
>     Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index f9f468d..01095e1 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -454,7 +454,7 @@ static int exynos_pcie_rd_own_conf(struct pcie_port *pp,
> int where, int size,
>  	int ret;
> 
>  	exynos_pcie_sideband_dbi_r_mode(pp, true);
> -	ret = dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where, size, val);
> +	ret = dw_pcie_cfg_read(pp->dbi_base + where, size, val);
>  	exynos_pcie_sideband_dbi_r_mode(pp, false);
>  	return ret;
>  }
> @@ -465,8 +465,7 @@ static int exynos_pcie_wr_own_conf(struct pcie_port *pp,
> int where, int size,
>  	int ret;
> 
>  	exynos_pcie_sideband_dbi_w_mode(pp, true);
> -	ret = dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3),
> -			where, size, val);
> +	ret = dw_pcie_cfg_write(pp->dbi_base + where, size, val);
>  	exynos_pcie_sideband_dbi_w_mode(pp, false);
>  	return ret;
>  }
> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-
> keystone-dw.c
> index e71da99..51789b7 100644
> --- a/drivers/pci/host/pci-keystone-dw.c
> +++ b/drivers/pci/host/pci-keystone-dw.c
> @@ -398,7 +398,7 @@ int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct
> pci_bus *bus,
> 
>  	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
> 
> -	return dw_pcie_cfg_read(addr + (where & ~0x3), where, size, val);
> +	return dw_pcie_cfg_read(addr + where, size, val);
>  }
> 
>  int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> @@ -410,7 +410,7 @@ int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct
> pci_bus *bus,
> 
>  	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
> 
> -	return dw_pcie_cfg_write(addr + (where & ~0x3), where, size, val);
> +	return dw_pcie_cfg_write(addr + where, size, val);
>  }
> 
>  /**
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-
> designware.c
> index 9073722..a7d2352 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -80,14 +80,14 @@ static inline struct pcie_port *sys_to_pcie(struct
> pci_sys_data *sys)
>  	return sys->private_data;
>  }
> 
> -int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
> +int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
>  {
>  	if (size == 4)
>  		*val = readl(addr);
>  	else if (size == 2)
> -		*val = readw(addr + (where & 2));
> +		*val = readw(addr);
>  	else if (size == 1)
> -		*val = readb(addr + (where & 1));
> +		*val = readb(addr);
>  	else {
>  		*val = 0;
>  		return PCIBIOS_BAD_REGISTER_NUMBER;
> @@ -96,14 +96,14 @@ int dw_pcie_cfg_read(void __iomem *addr, int where, int
> size, u32 *val)
>  	return PCIBIOS_SUCCESSFUL;
>  }
> 
> -int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val)
> +int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
>  {
>  	if (size == 4)
>  		writel(val, addr);
>  	else if (size == 2)
> -		writew(val, addr + (where & 2));
> +		writew(val, addr);
>  	else if (size == 1)
> -		writeb(val, addr + (where & 3));
> +		writeb(val, addr);
>  	else
>  		return PCIBIOS_BAD_REGISTER_NUMBER;
> 
> @@ -134,8 +134,7 @@ static int dw_pcie_rd_own_conf(struct pcie_port *pp, int
> where, int size,
>  	if (pp->ops->rd_own_conf)
>  		ret = pp->ops->rd_own_conf(pp, where, size, val);
>  	else
> -		ret = dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where,
> -				size, val);
> +		ret = dw_pcie_cfg_read(pp->dbi_base + where, size, val);
> 
>  	return ret;
>  }
> @@ -148,8 +147,7 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int
> where, int size,
>  	if (pp->ops->wr_own_conf)
>  		ret = pp->ops->wr_own_conf(pp, where, size, val);
>  	else
> -		ret = dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3), where,
> -				size, val);
> +		ret = dw_pcie_cfg_write(pp->dbi_base + where, size, val);
> 
>  	return ret;
>  }
> @@ -541,13 +539,12 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp,
> struct pci_bus *bus,
>  		u32 devfn, int where, int size, u32 *val)
>  {
>  	int ret, type;
> -	u32 address, busdev, cfg_size;
> +	u32 busdev, cfg_size;
>  	u64 cpu_addr;
>  	void __iomem *va_cfg_base;
> 
>  	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
>  		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> -	address = where & ~0x3;
> 
>  	if (bus->parent->number == pp->root_bus_nr) {
>  		type = PCIE_ATU_TYPE_CFG0;
> @@ -564,7 +561,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp,
> struct pci_bus *bus,
>  	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
>  				  type, cpu_addr,
>  				  busdev, cfg_size);
> -	ret = dw_pcie_cfg_read(va_cfg_base + address, where, size, val);
> +	ret = dw_pcie_cfg_read(va_cfg_base + where, size, val);
>  	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
>  				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
>  				  pp->io_bus_addr, pp->io_size);
> @@ -576,13 +573,12 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp,
> struct pci_bus *bus,
>  		u32 devfn, int where, int size, u32 val)
>  {
>  	int ret, type;
> -	u32 address, busdev, cfg_size;
> +	u32 busdev, cfg_size;
>  	u64 cpu_addr;
>  	void __iomem *va_cfg_base;
> 
>  	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
>  		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> -	address = where & ~0x3;
> 
>  	if (bus->parent->number == pp->root_bus_nr) {
>  		type = PCIE_ATU_TYPE_CFG0;
> @@ -599,7 +595,7 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp,
> struct pci_bus *bus,
>  	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
>  				  type, cpu_addr,
>  				  busdev, cfg_size);
> -	ret = dw_pcie_cfg_write(va_cfg_base + address, where, size, val);
> +	ret = dw_pcie_cfg_write(va_cfg_base + where, size, val);
>  	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
>  				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
>  				  pp->io_bus_addr, pp->io_size);
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-
> designware.h
> index d0bbd27..0b29194 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -76,8 +76,8 @@ struct pcie_host_ops {
>  	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
>  };
> 
> -int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val);
> -int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val);
> +int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val);
> +int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val);
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
>  void dw_pcie_msi_init(struct pcie_port *pp);
>  int dw_pcie_link_up(struct pcie_port *pp);
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-
> spear13xx.c
> index 0754ea3..b95b756 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -163,14 +163,12 @@ static int spear13xx_pcie_establish_link(struct
> pcie_port *pp)
>  	 * default value in capability register is 512 bytes. So force
>  	 * it to 128 here.
>  	 */
> -	dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL,
> -				0, 2, &val);
> +	dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, &val);
>  	val &= ~PCI_EXP_DEVCTL_READRQ;
> -	dw_pcie_cfg_write(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL,
> -				0, 2, val);
> +	dw_pcie_cfg_write(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, val);
> 
> -	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 0, 2, 0x104A);
> -	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 2, 2, 0xCD80);
> +	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 2, 0x104A);
> +	dw_pcie_cfg_write(pp->dbi_base + PCI_DEVICE_ID, 2, 0xCD80);
> 
>  	/*
>  	 * if is_gen1 is set then handle it, so that some buggy card
> @@ -178,21 +176,21 @@ static int spear13xx_pcie_establish_link(struct
> pcie_port *pp)
>  	 */
>  	if (spear13xx_pcie->is_gen1) {
>  		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
> -					0, 4, &val);
> +					4, &val);
>  		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
>  			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
>  			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
>  			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
> -						PCI_EXP_LNKCAP, 0, 4, val);
> +				PCI_EXP_LNKCAP, 4, val);
>  		}
> 
>  		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
> -					0, 2, &val);
> +					2, &val);
>  		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
>  			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
>  			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
>  			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
> -						PCI_EXP_LNKCTL2, 0, 2, val);
> +					PCI_EXP_LNKCTL2, 2, val);
>  		}
>  	}
> 
> 
> commit 08a79800db364aabe4422ac4f2e2efdf450e1c31
> Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Date:   Wed Sep 30 00:20:36 2015 +0800
> 
>     PCI: designware: Require config accesses to be naturally aligned
> 
>     Add sanity checks on "addr" input parameter in dw_pcie_cfg_read() and
>     dw_pcie_cfg_write().  These checks make sure that accesses are aligned on
>     their size, e.g., a 4-byte config access is aligned on a 4-byte boundary.
> 
>     [bhelgaas: changelog, set *val = 0 in failure case]
>     Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-
> designware.c
> index a7d2352..6a71f99 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -82,6 +82,11 @@ static inline struct pcie_port *sys_to_pcie(struct
> pci_sys_data *sys)
> 
>  int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
>  {
> +	if ((uintptr_t)addr & (size - 1)) {
> +		*val = 0;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
>  	if (size == 4)
>  		*val = readl(addr);
>  	else if (size == 2)
> @@ -98,6 +103,9 @@ int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
> 
>  int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
>  {
> +	if ((uintptr_t)addr & (size - 1))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
>  	if (size == 4)
>  		writel(val, addr);
>  	else if (size == 2)
