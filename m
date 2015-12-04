Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49635 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754705AbbLDVG0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Dec 2015 16:06:26 -0500
Date: Fri, 4 Dec 2015 15:06:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, izumi.taku@jp.fujitsu.com, jcm@redhat.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: enable SERR# forwarding for bridges and
 switches
Message-ID: <20151204210622.GI20125@localhost>
References: <1449074998-9664-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449074998-9664-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On Wed, Dec 02, 2015 at 11:49:56AM -0500, Sinan Kaya wrote:
> A PCIe card behind a switch is unable to report its errors when SERR#
> forwarding is not enabled on the PCIe# switch's secondary interface
> according to the spec. This patch enables SERR# forwarding when the PCI
> header type is bridge.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

I'm sitting on this for the moment because if you have _HPP, it seems
like that should be enough to get SERR# forwarding turned on, and if
it's not, I'd like to understand why.  So no hurry, but I'm waiting on
your investigation.

Bjorn

> ---
>  drivers/pci/pcie/aer/aerdrv_core.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 9803e3d..f248c17 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -37,21 +37,53 @@ module_param(nosourceid, bool, 0);
>  
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
> +	u8 header_type;
> +
>  	if (pcie_aer_get_firmware_first(dev))
>  		return -EIO;
>  
>  	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR))
>  		return -EIO;
>  
> +	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
> +
> +	/* needs to be a bridge/switch */
> +	if (header_type == PCI_HEADER_TYPE_BRIDGE) {
> +		u16 control;
> +
> +		/*
> +		 * A switch will not forward ERR_ messages coming from an
> +		 * endpoint if SERR# forwarding is not enabled.
> +		 * AER driver is checking the errors at the root only.
> +		 */
> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
> +		control |= PCI_BRIDGE_CTL_SERR;
> +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> +	}
> +
>  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
>  }
>  EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
>  
>  int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>  {
> +	u8 header_type;
> +
>  	if (pcie_aer_get_firmware_first(dev))
>  		return -EIO;
>  
> +	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
> +
> +	/* needs to be a bridge/switch */
> +	if (header_type == PCI_HEADER_TYPE_BRIDGE) {
> +		u16 control;
> +
> +		/* clear serr forwarding */
> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
> +		control &= ~PCI_BRIDGE_CTL_SERR;
> +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> +	}
> +
>  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
>  					  PCI_EXP_AER_FLAGS);
>  }
> -- 
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
