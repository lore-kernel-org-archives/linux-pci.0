Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] dwc: dra7xx: Print link state to console for debug
To: <kishon@ti.com>
CC: <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1508417009-30869-1-git-send-email-faiz_abbas@ti.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <9378c5c9-381d-4c40-3290-f7e3720792ba@ti.com>
Date: Thu, 19 Oct 2017 18:38:54 +0530
MIME-Version: 1.0
In-Reply-To: <1508417009-30869-1-git-send-email-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thursday 19 October 2017 06:13 PM, Faiz Abbas wrote:
> Enable support for printing the LTSSM link state for debugging PCI
> when link is down.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
> v2:
>  1. Changed dev_err() to dev_dbg()
>  2. Changed static char array to static const char * const
>  3. format changes
> 
>  drivers/pci/dwc/pci-dra7xx.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 34427a6..0e70e77 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -98,6 +98,45 @@ struct dra7xx_pcie_of_data {
>  
>  #define to_dra7xx_pcie(x)	dev_get_drvdata((x)->dev)
>  
> +static const char * const state[] = {
> +	"DETECT_QUIET",
> +	"DETECT_ACT",
> +	"POLL_ACTIVE",
> +	"POLL_COMPLIANCE",
> +	"POLL_CONFIG",
> +	"PRE_DETECT_QUIET",
> +	"DETECT_WAIT",
> +	"CFG_LINKWD_START",
> +	"CFG_LINKWD_ACEPT",
> +	"CFG_LANENUM_WAIT",
> +	"CFG_LANENUM_ACEPT",
> +	"CFG_COMPLETE",
> +	"CFG_IDLE",
> +	"RCVRY_LOCK",
> +	"RCVRY_SPEED",
> +	"RCVRY_RCVRCFG",
> +	"RCVRY_IDLE",
> +	"L0",
> +	"L0S",
> +	"L123_SEND_EIDLE",
> +	"L1_IDLE",
> +	"L2_IDLE",
> +	"L2_WAKE",
> +	"DISABLED_ENTRY",
> +	"DISABLED_IDLE",
> +	"DISABLED",
> +	"LPBK_ENTRY",
> +	"LPBK_ACTIVE",
> +	"LPBK_EXIT",
> +	"LPBK_EXIT_TIMEOUT",
> +	"HOT_RESET_ENTRY",
> +	"HOT_RESET",
> +	"RCVRY_EQ0",
> +	"RCVRY_EQ1",
> +	"RCVRY_EQ2",
> +	"RCVRY_EQ3"
> +};
> +
>  static inline u32 dra7xx_pcie_readl(struct dra7xx_pcie *pcie, u32 offset)
>  {
>  	return readl(pcie->base + offset);
> @@ -118,6 +157,15 @@ static int dra7xx_pcie_link_up(struct dw_pcie *pci)
>  {
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
>  	u32 reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_PHY_CS);
> +	u32 cmd_reg;
> +	u32 ltssm_state;
> +
> +	if (!(reg & LINK_UP)) {
> +		cmd_reg = dra7xx_pcie_readl(dra7xx,
> +					    PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
> +		ltssm_state = (cmd_reg & GENMASK(7, 2)) >> 2;
> +		dev_dbg(pci->dev, "Link state:%s\n", state[ltssm_state]);
> +	}
>  
>  	return !!(reg & LINK_UP);
>  }
> 

I missed David's comment in v1. Will submit a new version. Please ignore.

Thanks,
Faiz
