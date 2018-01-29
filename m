Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19490 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeA2EmN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jan 2018 23:42:13 -0500
Subject: Re: [PATCH V6 6/7] PCI: tegra: Broadcast PME_Turn_Off message before
 link goes to L2
To: Thierry Reding <thierry.reding@gmail.com>
CC: <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <cyndis@kapsi.fi>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1515650888-9459-1-git-send-email-mmaddireddy@nvidia.com>
 <1515650888-9459-7-git-send-email-mmaddireddy@nvidia.com>
 <20180125143627.GH27888@ulmo>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <8adc2a7d-009b-168c-07f6-b50526ce0605@nvidia.com>
Date: Mon, 29 Jan 2018 10:11:42 +0530
MIME-Version: 1.0
In-Reply-To: <20180125143627.GH27888@ulmo>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 25-Jan-18 8:06 PM, Thierry Reding wrote:
> On Thu, Jan 11, 2018 at 11:38:07AM +0530, Manikanta Maddireddy wrote:
>> Per PCIe r3.0, sec 5.3.3.2.1, PCIe root port shoould broadcast PME_Turn_Off
>> message before PCIe link goes to L2. PME_Turn_Off broadcast mechanism is
>> implemented in AFI module. Each Tegra PCIe root port has its own
>> PME_Turn_Off and PME_TO_Ack bitmap in AFI_PME register, program this
>> register to broadcast PME_Turn_Off message.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> V2:
>> * no change in this patch
>> V3:
>> * add PME bitmap in soc data instead of using compatible string
>> * replace while loop with readl_poll_timeout() for polling
>> * commit log correction
>> V4:
>> * no change in this patch
>> V5:
>> * Rebased on linux-next
>> V6:
>> * no change in this patch
>>
>>  drivers/pci/host/pci-tegra.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>> index 981f126b14d6..cc33fc0fb300 100644
>> --- a/drivers/pci/host/pci-tegra.c
>> +++ b/drivers/pci/host/pci-tegra.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/export.h>
>>  #include <linux/interrupt.h>
>> +#include <linux/iopoll.h>
>>  #include <linux/irq.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/kernel.h>
>> @@ -153,6 +154,8 @@
>>  #define  AFI_INTR_EN_FPCI_TIMEOUT	(1 << 7)
>>  #define  AFI_INTR_EN_PRSNT_SENSE	(1 << 8)
>>  
>> +#define AFI_PCIE_PME		0xf0
>> +
>>  #define AFI_PCIE_CONFIG					0x0f8
>>  #define  AFI_PCIE_CONFIG_PCIE_DISABLE(x)		(1 << ((x) + 1))
>>  #define  AFI_PCIE_CONFIG_PCIE_DISABLE_ALL		0xe
>> @@ -233,6 +236,8 @@
>>  #define PADS_REFCLK_CFG_PREDI_SHIFT		8  /* 11:8 */
>>  #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
>>  
>> +#define PME_ACK_TIMEOUT 10000
>> +
>>  struct tegra_msi {
>>  	struct msi_controller chip;
>>  	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
>> @@ -251,6 +256,8 @@ struct tegra_pcie_soc {
>>  	u32 tx_ref_sel;
>>  	u32 pads_refclk_cfg0;
>>  	u32 pads_refclk_cfg1;
>> +	u8 pme_turnoff_bit[3];
>> +	u8 pme_ack_bit[3];
> 
> This seems suboptimal to me. Perhaps a better way would be:
> 
> 	struct tegra_pcie_port_soc {
> 		struct {
> 			u8 turnoff_bit;
> 			u8 ack_bit;
> 		} pme;
> 	};
> 
> And since we already have num_ports which defines exactly how many ports
> we have:
> 
> 	struct tegra_pcie_soc {
> 		unsigned int num_ports;
> 		const struct tegra_pcie_port_soc *ports;
> 		...
> 	};
> 
> I suspect that as you're adding more features we may need more of this
> data.
> 
> But I'm fine to keep it like this. We can always switch to something
> different if the above becomes too much cluttered.
> 
I agree it is sub optimal. I moved pme bitmap values to soc data because
tegra30 and tegra186 have different bitmap values. To differentiate this
I allocated static memory in tegra_pcie_soc. I am a bit hesitant do dynamic
allocation based on num_ports because I need to use compatible string
to distinguish between tegra30 & tegra186 in runtime. I believe it is OK
to have trade off 16 bits to avoid these compatible check?

>>  	bool has_pex_clkreq_en;
>>  	bool has_pex_bias_ctrl;
>>  	bool has_intr_prsnt_sense;
>> @@ -1358,6 +1365,31 @@ static int tegra_pcie_put_resources(struct tegra_pcie *pcie)
>>  	return 0;
>>  }
>>  
>> +static void tegra_pcie_pme_turnoff(struct tegra_pcie_port *port)
>> +{
>> +	struct tegra_pcie *pcie = port->pcie;
>> +	const struct tegra_pcie_soc *soc = pcie->soc;
>> +	int err;
>> +	u32 val;
>> +
>> +	val = afi_readl(pcie, AFI_PCIE_PME);
>> +	val |= (0x1 << soc->pme_turnoff_bit[port->index]);
>> +	afi_writel(pcie, val, AFI_PCIE_PME);
>> +
>> +	err = readl_poll_timeout(pcie->afi + AFI_PCIE_PME, val,
>> +				 val & (0x1 << soc->pme_ack_bit[port->index]),
>> +				 1, PME_ACK_TIMEOUT);
>> +	if (err)
>> +		dev_err(pcie->dev, "PME Ack is not received on port: %d\n",
>> +			port->index);
>> +
>> +	usleep_range(10000, 11000);
>> +
>> +	val = afi_readl(pcie, AFI_PCIE_PME);
>> +	val &= ~(0x1 << soc->pme_turnoff_bit[port->index]);
>> +	afi_writel(pcie, val, AFI_PCIE_PME);
>> +}
>> +
>>  static int tegra_msi_alloc(struct tegra_msi *chip)
>>  {
>>  	int msi;
>> @@ -2109,6 +2141,8 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA20,
>>  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_DIV10,
>>  	.pads_refclk_cfg0 = 0xfa5cfa5c,
>> +	.pme_turnoff_bit = {0, 8},
>> +	.pme_ack_bit = {5, 10},
>>  	.has_pex_clkreq_en = false,
>>  	.has_pex_bias_ctrl = false,
>>  	.has_intr_prsnt_sense = false,
>> @@ -2125,6 +2159,8 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>>  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
>>  	.pads_refclk_cfg0 = 0xfa5cfa5c,
>>  	.pads_refclk_cfg1 = 0xfa5cfa5c,
>> +	.pme_turnoff_bit = {0, 8, 16},
>> +	.pme_ack_bit = {5, 10, 18},
>>  	.has_pex_clkreq_en = true,
>>  	.has_pex_bias_ctrl = true,
>>  	.has_intr_prsnt_sense = true,
>> @@ -2140,6 +2176,8 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
>>  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
>>  	.pads_refclk_cfg0 = 0x44ac44ac,
>> +	.pme_turnoff_bit = {0, 8},
>> +	.pme_ack_bit = {5, 10},
>>  	.has_pex_clkreq_en = true,
>>  	.has_pex_bias_ctrl = true,
>>  	.has_intr_prsnt_sense = true,
>> @@ -2155,6 +2193,8 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
>>  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
>>  	.pads_refclk_cfg0 = 0x90b890b8,
>> +	.pme_turnoff_bit = {0, 8},
>> +	.pme_ack_bit = {5, 10},
>>  	.has_pex_clkreq_en = true,
>>  	.has_pex_bias_ctrl = true,
>>  	.has_intr_prsnt_sense = true,
>> @@ -2171,6 +2211,8 @@ static const struct tegra_pcie_soc tegra186_pcie = {
>>  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
>>  	.pads_refclk_cfg0 = 0x80b880b8,
>>  	.pads_refclk_cfg1 = 0x000480b8,
>> +	.pme_turnoff_bit = {0, 8, 12},
>> +	.pme_ack_bit = {5, 10, 14},
>>  	.has_pex_clkreq_en = true,
>>  	.has_pex_bias_ctrl = true,
>>  	.has_intr_prsnt_sense = true,
>> @@ -2399,11 +2441,14 @@ static int tegra_pcie_remove(struct platform_device *pdev)
>>  {
>>  	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
>>  	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
>> +	struct tegra_pcie_port *port, *tmp;
>>  
>>  	if (IS_ENABLED(CONFIG_DEBUG_FS))
>>  		tegra_pcie_debugfs_exit(pcie);
>>  	pci_stop_root_bus(host->bus);
>>  	pci_remove_root_bus(host->bus);
>> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
>> +		tegra_pcie_pme_turnoff(port);
> 
> Why list_for_each_entry_safe()? tegra_pcie_pme_turnoff() doesn't do
> anything that would make port become invalid.
Apart from this reason, I don't see a scenario where "making port invalid"
code run in parallel to this function. So it safe to use list_for_each_entry,
I'll do this change in next version.
> 
> Thierry
> 
