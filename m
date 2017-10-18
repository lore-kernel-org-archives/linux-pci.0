Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: dra7xx: Print link state to console for debug
To: Joe Perches <joe@perches.com>, <kishon@ti.com>
CC: <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1508219031-25592-1-git-send-email-faiz_abbas@ti.com>
 <1508222128.6530.22.camel@perches.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <7ffa762b-292a-be10-b959-4ebb2312bed6@ti.com>
Date: Wed, 18 Oct 2017 11:46:55 +0530
MIME-Version: 1.0
In-Reply-To: <1508222128.6530.22.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Tuesday 17 October 2017 12:05 PM, Joe Perches wrote:
> On Tue, 2017-10-17 at 11:13 +0530, Faiz Abbas wrote:
>> Enable support for printing the LTSSM link state for debugging PCI
>> when link is down.
> []
>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
>> index 34427a6..7b150b0 100644
>> --- a/drivers/pci/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>> @@ -98,6 +98,18 @@ struct dra7xx_pcie_of_data {
>>  
>>  #define to_dra7xx_pcie(x)	dev_get_drvdata((x)->dev)
>>  
>> +static char state[][20] = {
>> +	"DETECT_QUIET", "DETECT_ACT", "POLL_ACTIVE", "POLL_COMPLIANCE",
>> +	"POLL_CONFIG", "PRE_DETECT_QUIET", "DETECT_WAIT", "CFG_LINKWD_START",
>> +	"CFG_LINKWD_ACEPT", "CFG_LANENUM_WAIT", "CFG_LANENUM_ACEPT",
>> +	"CFG_COMPLETE", "CFG_IDLE", "RCVRY_LOCK", "RCVRY_SPEED",
>> +	"RCVRY_RCVRCFG", "RCVRY_IDLE", "L0", "L0S", "L123_SEND_EIDLE",
>> +	"L1_IDLE", "L2_IDLE", "L2_WAKE", "DISABLED_ENTRY", "DISABLED_IDLE",
>> +	"DISABLED", "LPBK_ENTRY", "LPBK_ACTIVE", "LPBK_EXIT",
>> +	"LPBK_EXIT_TIMEOUT", "HOT_RESET_ENTRY", "HOT_RESET", "RCVRY_EQ0",
>> +	"RCVRY_EQ1", "RCVRY_EQ2", "RCVRY_EQ3"
> 
> what's wrong with using the far more typical
> 
> static const char *link_state[] = {
> 	"DETECT_QUIET",
> 	...
> };

Too many lines?

> 
>> +};
>> +
>>  static inline u32 dra7xx_pcie_readl(struct dra7xx_pcie *pcie, u32 offset)
>>  {
>>  	return readl(pcie->base + offset);
>> @@ -118,6 +130,15 @@ static int dra7xx_pcie_link_up(struct dw_pcie *pci)
>>  {
>>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
>>  	u32 reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_PHY_CS);
>> +	u32 cmd_reg;
>> +	u32 ltssm_state;
>> +
>> +	if (!(reg & LINK_UP)) {
>> +		cmd_reg = dra7xx_pcie_readl(dra7xx,
>> +					    PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
>> +		ltssm_state = (cmd_reg & GENMASK(7, 2)) >> 2;
>> +		dev_err(pci->dev, "Link state:%s\n", state[ltssm_state]);
> 
> and why is this a dev_err and not dev_info?
> and if it's really for debugging, why not dev_dbg?
> 
>> +	}
>>  
>>  	return !!(reg & LINK_UP);
>>  }

Will change to dev_dbg.

Thanks,
Faiz
