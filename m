Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752173AbdHBVE7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 17:04:59 -0400
Date: Wed, 2 Aug 2017 16:04:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <oza.oza@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: iproc: Retry request when CRS returned from
 EP
Message-ID: <20170802210455.GF20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1499310582-21193-1-git-send-email-oza.oza@broadcom.com>
 <1499310582-21193-2-git-send-email-oza.oza@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1499310582-21193-2-git-send-email-oza.oza@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 06, 2017 at 08:39:41AM +0530, Oza Pawandeep wrote:
> For Configuration Requests only, following reset it is possible for a
> device to terminate the request but indicate that it is temporarily unable
> to process the Request, but will be able to process the Request in the
> future – in this case, the Configuration Request Retry Status 100 (CRS)
> Completion Status is used.

Please include the spec reference for this.

The "100" looks like it's supposed to be the Completion Status Field
value for CRS from PCIe r3.1, sec 2.2.9, Table 2-34, but the value in
the table is actually 0b010, not 0b100.  I don't think this level of
detail is necessary unless your hardware exposes those values to the
driver.

> As per PCI spec, CRS Software Visibility only affects config read of the
> Vendor ID, for config write or any other config read the Root must
> automatically re-issue configuration request again as a new request.
> Iproc based PCIe RC (hw) does not retry request on its own.

I think sec 2.3.2 is the relevant part of the spec.  It basically
says that when an RC receives a CRS completion for a config request:

  - If CRS software visibility is not enabled, the RC must reissue the
    config request as a new request.

  - If CRS software visibility is enabled,
    - for a config read of Vendor ID, the RC must return 0x0001 data
    - for all other config reads/writes, the RC must reissue the
      request

Apparently iProc *never* reissues config requests, regardless of
whether CRS software visibility is enabled?

But your CFG_RETRY_STATUS definition suggests that iProc always
fabricates config read data of 0xffff0001 when it sees CRS status, no
matter whether software visibility is enabled and no matter what
config address we read?

What about CRS status for a config *write*?  There's nothing here to
reissue those.

Is there a hardware erratum that describes the actual hardware
behavior?

> As a result of the fact, PCIe RC driver (sw) should take care of CRS.
> This patch fixes the problem, and attempts to read config space again in
> case of PCIe code forwarding the CRS back to CPU.
> It implements iproc_pcie_config_read which gets called for Stingray,
> Otherwise it falls back to PCI generic APIs.
> 
> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 0f39bd2..b0abcd7 100644
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
> @@ -448,6 +451,55 @@ static inline void iproc_pcie_apb_err_disable(struct pci_bus *bus,
>  	}
>  }
>  
> +static int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
> +{
> +	int timeout = CFG_RETRY_STATUS_TIMEOUT_US;
> +	unsigned int ret;
> +
> +	/*
> +	 * As per PCI spec, CRS Software Visibility only
> +	 * affects config read of the Vendor ID.
> +	 * For config write or any other config read the Root must
> +	 * automatically re-issue configuration request again as a
> +	 * new request. Iproc based PCIe RC (hw) does not retry
> +	 * request on its own, so handle it here.
> +	 */
> +	do {
> +		ret = readl(cfg_data_p);
> +		if (ret == CFG_RETRY_STATUS)
> +			udelay(1);
> +		else
> +			return PCIBIOS_SUCCESSFUL;
> +	} while (timeout--);

Shouldn't this check *where* in config space we're reading?

Shouldn't we check whether CRS software visiblity is enabled?  Does
iProc advertise CRS software visibility support in Root Capabilities?

If CRS software visibility is enabled, we should return the 0x0001
data if we're reading the Vendor ID and see CRS status.  It looks like
this loop always retries if we see 0xffff0001 data.

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
> @@ -499,13 +551,48 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
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
