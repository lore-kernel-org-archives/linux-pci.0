Return-Path: <SRS0=Jscy=BY=ti.com=faiz_abbas@kernel.org>
Return-Path: <SRS0=Jscy=BY=ti.com=faiz_abbas@kernel.org>
Subject: Re: [PATCH v2] dwc: dra7xx: Print link state to console for debug
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <kishon@ti.com>, <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1508417009-30869-1-git-send-email-faiz_abbas@ti.com>
 <20171024195950.GD21840@bhelgaas-glaptop.roam.corp.google.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <c99814db-e349-e4b1-c652-561a3ca1abec@ti.com>
Date: Wed, 25 Oct 2017 13:51:53 +0530
MIME-Version: 1.0
In-Reply-To: <20171024195950.GD21840@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On Wednesday 25 October 2017 01:29 AM, Bjorn Helgaas wrote:
> On Thu, Oct 19, 2017 at 06:13:29PM +0530, Faiz Abbas wrote:
>> Enable support for printing the LTSSM link state for debugging PCI
>> when link is down.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> 
> Applied with Kishon's ack to pci/host-dra7xx for v4.15, thanks!
> 
> I tweaked the "link up" testing as follows (what I suggested before):
> 
> 
> @@ -118,8 +157,18 @@ static int dra7xx_pcie_link_up(struct dw_pcie *pci)
>  {
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
>  	u32 reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_PHY_CS);
> +	int link_up = !!(reg & LINK_UP);
> +	u32 cmd_reg;
> +	u32 ltssm_state;
> +
> +	if (!link_up) {
> +		cmd_reg = dra7xx_pcie_readl(dra7xx,
> +					    PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
> +		ltssm_state = (cmd_reg & GENMASK(7, 2)) >> 2;
> +		dev_dbg(pci->dev, "Link state: %s\n", state[ltssm_state]);
> +	}
>  
> -	return !!(reg & LINK_UP);
> +	return link_up;
>  }
>  
>  static void dra7xx_pcie_stop_link(struct dw_pcie *pci)
> 

I wanted to send another version with David's suggestions included.
Please don't merge.

Thanks,
Faiz
