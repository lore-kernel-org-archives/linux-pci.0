Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753119AbdFLXao (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jun 2017 19:30:44 -0400
Date: Mon, 12 Jun 2017 18:30:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <oza.oza@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: iproc: Retry request when CRS returned from
 EP
Message-ID: <20170612233039.GC4379@bhelgaas-glaptop.roam.corp.google.com>
References: <1497153938-26074-1-git-send-email-oza.oza@broadcom.com>
 <1497153938-26074-2-git-send-email-oza.oza@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1497153938-26074-2-git-send-email-oza.oza@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Please wrap your changelogs to use 75 columns.  "git log" indents the
changelog by four spaces, so if your text is 75 wide, it will still
fit without wrapping.

On Sun, Jun 11, 2017 at 09:35:37AM +0530, Oza Pawandeep wrote:
> For Configuration Requests only, following reset
> it is possible for a device to terminate the request
> but indicate that it is temporarily unable to process
> the Request, but will be able to process the Request
> in the future – in this case, the Configuration Request
> Retry Status 10 (CRS) Completion Status is used

How does this relate to the CRS support we already have in the core,
e.g., pci_bus_read_dev_vendor_id()?  It looks like your root complex
already returns 0xffff0001 (CFG_RETRY_STATUS) in some cases.

Also, per spec (PCIe r3.1, sec 2.3.2), CRS Software Visibility only
affects config reads of the Vendor ID, but you call
iproc_pcie_cfg_retry() for all config offsets.

> SPDK user space NVMe driver reinitializes NVMe which
> causes reset, while doing this some configuration requests
> get NAKed by Endpoint (NVMe).

What's SPDK?  I don't know what "NAK" means in a PCIe context.  If you
can use the appropriate PCIe terminology, I think it will make more
sense to me.

> Current iproc PCI driver is agnostic about it.
> PAXB will forward the NAKed response in stipulated AXI code.

In general a native host bridge driver should not have to deal with
the CRS feature because it's supported in the PCI core.  So we need
some explanation about why iProc is special in this regard.

> NVMe spec defines this timeout in 500 ms units, and this
> only happens if controller has been in reset, or with new firmware,
> or in abrupt shutdown case.
> Meanwhile config access could result into retry.

I don't understand why NVMe is relevant here.  Is there something
special about NVMe and CRS?

> This patch fixes the problem, and attempts to read again in case
> of PAXB forwarding the NAK.
> 
> It implements iproc_pcie_config_read which gets called for Stingray.
> Otherwise it falls back to PCI generic APIs.
> 
> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 0f39bd2..05a3647 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -68,6 +68,9 @@
>  #define APB_ERR_EN_SHIFT             0
>  #define APB_ERR_EN                   BIT(APB_ERR_EN_SHIFT)
>  
> +#define CFG_RETRY_STATUS             0xffff0001
> +#define CFG_RETRY_STATUS_TIMEOUT_US  500000 /* 500 milli-seconds. */
> +
>  /* derive the enum index of the outbound/inbound mapping registers */
>  #define MAP_REG(base_reg, index)      ((base_reg) + (index) * 2)
>  
> @@ -448,6 +451,47 @@ static inline void iproc_pcie_apb_err_disable(struct pci_bus *bus,
>  	}
>  }
>  
> +static int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
> +{
> +	int timeout = CFG_RETRY_STATUS_TIMEOUT_US;
> +	unsigned int ret;
> +
> +	do {
> +		ret = readl(cfg_data_p);
> +		if (ret == CFG_RETRY_STATUS)
> +			udelay(1);
> +		else
> +			return PCIBIOS_SUCCESSFUL;
> +	} while (timeout--);
> +
> +	return PCIBIOS_DEVICE_NOT_FOUND;
> +}
> +
> +static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
> +					       unsigned int busno,
> +					       unsigned int slot,
> +					       unsigned int fn,
> +					       int where)
> +{
> +	u16 offset;
> +	u32 val;
> +
> +	/* EP device access */
> +	val = (busno << CFG_ADDR_BUS_NUM_SHIFT) |
> +		(slot << CFG_ADDR_DEV_NUM_SHIFT) |
> +		(fn << CFG_ADDR_FUNC_NUM_SHIFT) |
> +		(where & CFG_ADDR_REG_NUM_MASK) |
> +		(1 & CFG_ADDR_CFG_TYPE_MASK);
> +
> +	iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_ADDR, val);
> +	offset = iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_DATA);
> +
> +	if (iproc_pcie_reg_is_invalid(offset))
> +		return NULL;
> +
> +	return (pcie->base + offset);
> +}
> +
>  /**
>   * Note access to the configuration registers are protected at the higher layer
>   * by 'pci_lock' in drivers/pci/access.c
> @@ -499,13 +543,48 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
>  		return (pcie->base + offset);
>  }
>  
> +static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> +				    int where, int size, u32 *val)
> +{
> +	struct iproc_pcie *pcie = iproc_data(bus);
> +	unsigned int slot = PCI_SLOT(devfn);
> +	unsigned int fn = PCI_FUNC(devfn);
> +	unsigned int busno = bus->number;
> +	void __iomem *cfg_data_p;
> +	int ret;
> +
> +	/* root complex access. */
> +	if (busno == 0)
> +		return pci_generic_config_read32(bus, devfn, where, size, val);
> +
> +	cfg_data_p = iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, where);
> +
> +	if (!cfg_data_p)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	ret = iproc_pcie_cfg_retry(cfg_data_p);
> +	if (ret)
> +		return ret;
> +
> +	*val = readl(cfg_data_p);
> +
> +	if (size <= 2)
> +		*val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
>  static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
>  				    int where, int size, u32 *val)
>  {
>  	int ret;
> +	struct iproc_pcie *pcie = iproc_data(bus);
>  
>  	iproc_pcie_apb_err_disable(bus, true);
> -	ret = pci_generic_config_read32(bus, devfn, where, size, val);
> +	if (pcie->type == IPROC_PCIE_PAXB_V2)
> +		ret = iproc_pcie_config_read(bus, devfn, where, size, val);
> +	else
> +		ret = pci_generic_config_read32(bus, devfn, where, size, val);
>  	iproc_pcie_apb_err_disable(bus, false);
>  
>  	return ret;
> -- 
> 1.9.1
> 
