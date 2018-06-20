Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:50915 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754583AbeFTJ0R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2018 05:26:17 -0400
Subject: Re: [RFC PATCH] PCI: dwc: dw_pcie_ep_find_capability() can be static
To: kbuild test robot <fengguang.wu@intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <5beae521c5ee475b1c0e04f5eec07d0120b0fa2b.1529329262.git.gustavo.pimentel@synopsys.com>
 <20180618191207.GA111117@ivb43>
From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <23cdc4a8-2d79-826e-8fa3-3877486c2ae1@synopsys.com>
Date: Wed, 20 Jun 2018 10:23:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180618191207.GA111117@ivb43>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Thanks for the suggestion.

Regards,
Gustavo

On 18/06/2018 20:12, kbuild test robot wrote:
> 
> Fixes: 43f8cf4686e0 ("PCI: dwc: Add MSI-X callbacks handler")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
> ---
>  pcie-designware-ep.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index beee64e..ffc2065 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -59,7 +59,7 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>  	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>  }
>  
> -u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
> +static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
>  {
>  	u8 next_cap_ptr;
>  	u16 reg;
> 
