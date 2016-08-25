Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 Aug 2016 08:56:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Ley Foon Tan <lftan.linux@gmail.com>
Subject: Re: [PATCH v3] PCI: altera: Retrain link in rootport mode only
Message-ID: <20160825135650.GB11257@localhost>
References: <1472104796-20737-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472104796-20737-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 25, 2016 at 01:59:56PM +0800, Ley Foon Tan wrote:
> Altera PCIe IP can be configured as rootport or device and they might have
> same vendor ID. It will cause the system hang issue if Altera PCIe is in
> endpoint mode and work with other PCIe rootport that from other vendors.
> Moved retrain function to before pci_scan_root_bus and removed _FIXUP.
> Add _altera_pcie_cfg_read() and _altera_pcie_cfg_write() to use struct
> altera_pcie as argument instead of struct pci_bus.

I think this makes sense.  Can you split this into two patches:

  - Rework the config accessors
  - Move retrain from the quirk to altera_pcie_host_init()

I also want to look through the other host bridge drivers and see if
there's any consistency in naming and structure of the config accessors.
The pattern of a wrapper that takes "struct pci_bus *, unsigned int devfn,
..." that calls an internal function that takes the driver structure
instead of the "struct pci_bus *" might be useful in other drivers as well.

> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> ---
> v2: change to check PCIe type is PCI_EXP_TYPE_ROOT_PORT
> v3: Move retrain function to before pci_scan_root_bus and remove _FIXUP
> ---
>  drivers/pci/host/pcie-altera.c | 217 +++++++++++++++++++++++++----------------
>  1 file changed, 134 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
> index 58eef99..4ce6d86 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -43,6 +43,8 @@
>  #define RP_LTSSM_MASK			0x1f
>  #define LTSSM_L0			0xf
>  
> +#define PCIE_CAP_OFFSET			0x80
> +
>  /* TLP configuration type 0 and 1 */
>  #define TLP_FMTTYPE_CFGRD0		0x04	/* Configuration Read Type 0 */
>  #define TLP_FMTTYPE_CFGWR0		0x44	/* Configuration Write Type 0 */
> @@ -100,66 +102,6 @@ static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
>  	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
>  }
>  
> -static void altera_wait_link_retrain(struct pci_dev *dev)
> -{
> -	u16 reg16;
> -	unsigned long start_jiffies;
> -	struct altera_pcie *pcie = dev->bus->sysdata;
> -
> -	/* Wait for link training end. */
> -	start_jiffies = jiffies;
> -	for (;;) {
> -		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &reg16);
> -		if (!(reg16 & PCI_EXP_LNKSTA_LT))
> -			break;
> -
> -		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT)) {
> -			dev_err(&pcie->pdev->dev, "link retrain timeout\n");
> -			break;
> -		}
> -		udelay(100);
> -	}
> -
> -	/* Wait for link is up */
> -	start_jiffies = jiffies;
> -	for (;;) {
> -		if (altera_pcie_link_is_up(pcie))
> -			break;
> -
> -		if (time_after(jiffies, start_jiffies + LINK_UP_TIMEOUT)) {
> -			dev_err(&pcie->pdev->dev, "link up timeout\n");
> -			break;
> -		}
> -		udelay(100);
> -	}
> -}
> -
> -static void altera_pcie_retrain(struct pci_dev *dev)
> -{
> -	u16 linkcap, linkstat;
> -	struct altera_pcie *pcie = dev->bus->sysdata;
> -
> -	if (!altera_pcie_link_is_up(pcie))
> -		return;
> -
> -	/*
> -	 * Set the retrain bit if the PCIe rootport support > 2.5GB/s, but
> -	 * current speed is 2.5 GB/s.
> -	 */
> -	pcie_capability_read_word(dev, PCI_EXP_LNKCAP, &linkcap);
> -
> -	if ((linkcap & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
> -		return;
> -
> -	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
> -	if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
> -		pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
> -					 PCI_EXP_LNKCTL_RL);
> -		altera_wait_link_retrain(dev);
> -	}
> -}
> -DECLARE_PCI_FIXUP_EARLY(0x1172, PCI_ANY_ID, altera_pcie_retrain);
> -
>  /*
>   * Altera PCIe port uses BAR0 of RC's configuration space as the translation
>   * from PCI bus to native BUS.  Entire DDR region is mapped into PCIe space
> @@ -330,22 +272,14 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
>  	return PCIBIOS_SUCCESSFUL;
>  }
>  
> -static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
> -				int where, int size, u32 *value)
> +static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
> +				 unsigned int devfn, int where, int size,
> +				 u32 *value)
>  {
> -	struct altera_pcie *pcie = bus->sysdata;
>  	int ret;
>  	u32 data;
>  	u8 byte_en;
>  
> -	if (altera_pcie_hide_rc_bar(bus, devfn, where))
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -
> -	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn))) {
> -		*value = 0xffffffff;
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> -	}
> -
>  	switch (size) {
>  	case 1:
>  		byte_en = 1 << (where & 3);
> @@ -358,7 +292,7 @@ static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
>  		break;
>  	}
>  
> -	ret = tlp_cfg_dword_read(pcie, bus->number, devfn,
> +	ret = tlp_cfg_dword_read(pcie, busno, devfn,
>  				 (where & ~DWORD_MASK), byte_en, &data);
>  	if (ret != PCIBIOS_SUCCESSFUL)
>  		return ret;
> @@ -378,20 +312,14 @@ static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
>  	return PCIBIOS_SUCCESSFUL;
>  }
>  
> -static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
> -				 int where, int size, u32 value)
> +static int _altera_pcie_cfg_write(struct altera_pcie *pcie, u8 busno,
> +				  unsigned int devfn, int where, int size,
> +				  u32 value)
>  {
> -	struct altera_pcie *pcie = bus->sysdata;
>  	u32 data32;
>  	u32 shift = 8 * (where & 3);
>  	u8 byte_en;
>  
> -	if (altera_pcie_hide_rc_bar(bus, devfn, where))
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -
> -	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> -
>  	switch (size) {
>  	case 1:
>  		data32 = (value & 0xff) << shift;
> @@ -407,8 +335,40 @@ static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
>  		break;
>  	}
>  
> -	return tlp_cfg_dword_write(pcie, bus->number, devfn,
> -		(where & ~DWORD_MASK), byte_en, data32);
> +	return tlp_cfg_dword_write(pcie, busno, devfn, (where & ~DWORD_MASK),
> +				   byte_en, data32);
> +}
> +
> +static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
> +				int where, int size, u32 *value)
> +{
> +	struct altera_pcie *pcie = bus->sysdata;
> +
> +	if (altera_pcie_hide_rc_bar(bus, devfn, where))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn))) {
> +		*value = 0xffffffff;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	return _altera_pcie_cfg_read(pcie, bus->number, devfn, where, size,
> +				     value);
> +}
> +
> +static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
> +				 int where, int size, u32 value)
> +{
> +	struct altera_pcie *pcie = bus->sysdata;
> +
> +	if (altera_pcie_hide_rc_bar(bus, devfn, where))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	return _altera_pcie_cfg_write(pcie, bus->number, devfn, where, size,
> +				     value);
>  }
>  
>  static struct pci_ops altera_pcie_ops = {
> @@ -416,6 +376,90 @@ static struct pci_ops altera_pcie_ops = {
>  	.write = altera_pcie_cfg_write,
>  };
>  
> +static int altera_read_cap_word(struct altera_pcie *pcie, u8 busno,
> +				unsigned int devfn, int offset, u16 *value)
> +{
> +	u32 data;
> +	int ret;
> +
> +	ret = _altera_pcie_cfg_read(pcie, busno, devfn,
> +				    PCIE_CAP_OFFSET + offset, sizeof(*value),
> +				    &data);
> +	*value = data;
> +	return ret;
> +}
> +
> +static int altera_write_cap_word(struct altera_pcie *pcie, u8 busno,
> +				 unsigned int devfn, int offset, u16 value)
> +{
> +	return _altera_pcie_cfg_write(pcie, busno, devfn,
> +				      PCIE_CAP_OFFSET + offset, sizeof(value),
> +				      value);
> +}
> +
> +static void altera_wait_link_retrain(struct altera_pcie *pcie)
> +{
> +	u16 reg16;
> +	unsigned long start_jiffies;
> +
> +	/* Wait for link training end. */
> +	start_jiffies = jiffies;
> +	for (;;) {
> +		altera_read_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN,
> +				     PCI_EXP_LNKSTA, &reg16);
> +		if (!(reg16 & PCI_EXP_LNKSTA_LT))
> +			break;
> +
> +		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT)) {
> +			dev_err(&pcie->pdev->dev, "link retrain timeout\n");
> +			break;
> +		}
> +		udelay(100);
> +	}
> +
> +	/* Wait for link is up */
> +	start_jiffies = jiffies;
> +	for (;;) {
> +		if (altera_pcie_link_is_up(pcie))
> +			break;
> +
> +		if (time_after(jiffies, start_jiffies + LINK_UP_TIMEOUT)) {
> +			dev_err(&pcie->pdev->dev, "link up timeout\n");
> +			break;
> +		}
> +		udelay(100);
> +	}
> +}
> +
> +static void altera_pcie_retrain(struct altera_pcie *pcie)
> +{
> +	u16 linkcap, linkstat, linkctl;
> +
> +	if (!altera_pcie_link_is_up(pcie))
> +		return;
> +
> +	/*
> +	 * Set the retrain bit if the PCIe rootport support > 2.5GB/s, but
> +	 * current speed is 2.5 GB/s.
> +	 */
> +	altera_read_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN, PCI_EXP_LNKCAP,
> +			     &linkcap);
> +	if ((linkcap & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
> +		return;
> +
> +	altera_read_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN, PCI_EXP_LNKSTA,
> +			     &linkstat);
> +	if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
> +		altera_read_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN,
> +				     PCI_EXP_LNKCTL, &linkctl);
> +		linkctl |= PCI_EXP_LNKCTL_RL;
> +		altera_write_cap_word(pcie, pcie->root_bus_nr, RP_DEVFN,
> +				      PCI_EXP_LNKCTL, linkctl);
> +
> +		altera_wait_link_retrain(pcie);
> +	}
> +}
> +
>  static int altera_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
>  				irq_hw_number_t hwirq)
>  {
> @@ -537,6 +581,11 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
>  	return 0;
>  }
>  
> +static void altera_pcie_host_init(struct altera_pcie *pcie)
> +{
> +	altera_pcie_retrain(pcie);
> +}
> +
>  static int altera_pcie_probe(struct platform_device *pdev)
>  {
>  	struct altera_pcie *pcie;
> @@ -575,6 +624,8 @@ static int altera_pcie_probe(struct platform_device *pdev)
>  	/* enable all interrupts */
>  	cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
>  
> +	altera_pcie_host_init(pcie);
> +
>  	bus = pci_scan_root_bus(&pdev->dev, pcie->root_bus_nr, &altera_pcie_ops,
>  				pcie, &pcie->resources);
>  	if (!bus)
> -- 
> 1.8.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
