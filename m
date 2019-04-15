Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A64C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B067C217D6
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Gp71nWy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfDOOLn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:11:43 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19633 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfDOOLm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 10:11:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb491090000>; Mon, 15 Apr 2019 07:11:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 07:11:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 07:11:40 -0700
Received: from [10.24.70.150] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 14:11:36 +0000
Subject: Re: [PATCH 02/30] PCI: tegra: Fix PCIe host power up sequence
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-3-mmaddireddy@nvidia.com> <20190415110136.GC29254@ulmo>
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <63ed1e7e-6630-bdba-3acd-c4372e83b259@nvidia.com>
Date:   Mon, 15 Apr 2019 19:41:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415110136.GC29254@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555337481; bh=bWOUWTKRdH9kfIE+sjyWxg7RjfkSYjMQq2CQ/M+kODw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=Gp71nWy6Us2KzwdpyedAg8/hWSviYPaKCknZDOw98CugRLAlCo3CIBamvb8jdi6VV
         9FXU8uwmC3nfJqgj5swlec1ynY/AkYd6piHUWXyBGwl8B5swf8LO05ypEMY4Os+tod
         tAnkKQneBLImsUz2se3cGOo0yEj48V0LCyGiwWa+t92tpRL3MtNADTpW0Elqq5dzNK
         r28Rlirp/6BUBeGPHFmNze2LLSxsSO5NWmsf5VvPC0/4o9vVDo1hyWbB2M2FK9qFSe
         a0iBZ506Oib3/iDSfoJKW+vPeVIERh+l45gmMmT/FtsCQlH2H0dwAf+o8LuhyEZsOd
         Cof1y5Mbc6NdQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 15-Apr-19 4:31 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:27PM +0530, Manikanta Maddireddy wrote:
>> PCIe host power up sequence involves programming AFI(AXI to FPCI bridge)
>> registers first and then PCIe registers. Otherwise AFI register settings
>> may not latch to PCIe IP.
>>
>> PCIe root port starts LTSSM as soon as PCIe xrst is deasserted.
>> So deassert PCIe xrst after programming PCIe registers.
>>
>> Modify PCIe power up sequence as follows,
>>   - Power ungate PCIe partition
>>   - Enable AFI clock
>>   - Deassert AFI reset
>>   - Program AFI registers
>>   - Enable PCIe clock
>>   - Deassert PCIe reset
>>   - Program PCIe registers
>>   - Deassert PCIe xrst to start LTSSM
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 73 ++++++++++++++++++------------
>>  1 file changed, 43 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index f4f53d092e00..0bf270bcea34 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -966,9 +966,6 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>>  		}
>>  	}
>>  
>> -	/* take the PCIe interface module out of reset */
>> -	reset_control_deassert(pcie->pcie_xrst);
>> -
>>  	/* finally enable PCIe */
>>  	value = afi_readl(pcie, AFI_CONFIGURATION);
>>  	value |= AFI_CONFIGURATION_EN_FPCI;
>> @@ -997,8 +994,6 @@ static void tegra_pcie_disable_controller(struct tegra_pcie *pcie)
>>  {
>>  	int err;
>>  
>> -	reset_control_assert(pcie->pcie_xrst);
>> -
>>  	if (pcie->soc->program_uphy) {
>>  		err = tegra_pcie_phy_power_off(pcie);
>>  		if (err < 0)
>> @@ -1014,13 +1009,11 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
>>  	int err;
>>  
>>  	reset_control_assert(pcie->afi_rst);
>> -	reset_control_assert(pcie->pex_rst);
>>  
>>  	clk_disable_unprepare(pcie->pll_e);
>>  	if (soc->has_cml_clk)
>>  		clk_disable_unprepare(pcie->cml_clk);
>>  	clk_disable_unprepare(pcie->afi_clk);
>> -	clk_disable_unprepare(pcie->pex_clk);
>>  
>>  	if (!dev->pm_domain)
>>  		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
>> @@ -1036,58 +1029,59 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
>>  	const struct tegra_pcie_soc *soc = pcie->soc;
>>  	int err;
>>  
>> -	reset_control_assert(pcie->pcie_xrst);
>> -	reset_control_assert(pcie->afi_rst);
>> -	reset_control_assert(pcie->pex_rst);
>> -
>> -	if (!dev->pm_domain)
>> -		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
>> -
> This code was in place to ensure that PCIe was in a known good state
> before following the power up sequence below. You mentioned elsewhere
> that there's a regression on Cardhu after applying this series, so
> perhaps Cardhu relies on the above hunk?
No, Tegra30 and Tegra20 has legacy PHY which are dependent on PEX clk and rst.
PHY power on is done in tegra_pcie_enable_controller(), but in this patch I am
enabling PEX clk and rst after tegra_pcie_enable_controller(). This caused
regression on Cardhu.
I realized that sanity test is failing on Cardhu after publishing this series, I will
fix the issue in V2.
I believe you are talking about the bootloader(uboot) which can enable
PCIe partition and reset. To bring the PCIe into good state then we
have to take care of clocks as well. AFAIK clock_disable() is not added
because it maintains the refcount and any mismatch in the count
will thrown warning. I downstream kernel I see pmc driver itself taking
care of initial state and there after maintaining the state with refcount.
Since bootloader may or may not enable PCIe, Can we get the state fixed
in pmc driver instead of fixing it in PCIe driver?

>
>>  	/* enable regulators */
>>  	err = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
>>  	if (err < 0)
>>  		dev_err(dev, "failed to enable regulators: %d\n", err);
>>  
>> -	if (dev->pm_domain) {
>> -		err = clk_prepare_enable(pcie->pex_clk);
>> +	if (!dev->pm_domain) {
>> +		err = tegra_powergate_power_on(TEGRA_POWERGATE_PCIE);
>>  		if (err) {
>> -			dev_err(dev, "failed to enable PEX clock: %d\n", err);
>> -			return err;
>> +			dev_err(dev, "power ungate failed: %d\n", err);
>> +			goto regulator_disable;
>>  		}
>> -		reset_control_deassert(pcie->pex_rst);
>> -	} else {
>> -		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
>> -							pcie->pex_clk,
>> -							pcie->pex_rst);
>> +		err = tegra_powergate_remove_clamping(TEGRA_POWERGATE_PCIE);
>>  		if (err) {
>> -			dev_err(dev, "powerup sequence failed: %d\n", err);
>> -			return err;
>> +			dev_err(dev, "remove clamp failed: %d\n", err);
>> +			goto powergate;
>>  		}
>>  	}
>>  
>> -	reset_control_deassert(pcie->afi_rst);
>> -
>>  	err = clk_prepare_enable(pcie->afi_clk);
>>  	if (err < 0) {
>>  		dev_err(dev, "failed to enable AFI clock: %d\n", err);
>> -		return err;
>> +		goto powergate;
>>  	}
>>  
>>  	if (soc->has_cml_clk) {
>>  		err = clk_prepare_enable(pcie->cml_clk);
>>  		if (err < 0) {
>>  			dev_err(dev, "failed to enable CML clock: %d\n", err);
>> -			return err;
>> +			goto afi_clk_disable;
>>  		}
>>  	}
>>  
>>  	err = clk_prepare_enable(pcie->pll_e);
>>  	if (err < 0) {
>>  		dev_err(dev, "failed to enable PLLE clock: %d\n", err);
>> -		return err;
>> +		goto cml_clk_disable;
>>  	}
>>  
>> +	reset_control_deassert(pcie->afi_rst);
>> +
>>  	return 0;
>> +
>> +cml_clk_disable:
>> +	if (soc->has_cml_clk)
>> +		clk_disable_unprepare(pcie->cml_clk);
>> +afi_clk_disable:
>> +	clk_disable_unprepare(pcie->afi_clk);
>> +powergate:
>> +	if (!dev->pm_domain)
>> +		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
>> +regulator_disable:
>> +	regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
>> +	return err;
>>  }
>>  
>>  static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
>> @@ -2108,7 +2102,12 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>>  			 port->index, port->lanes);
>>  
>>  		tegra_pcie_port_enable(port);
>> +	}
>> +
>> +	/* Start LTSSM from Tegra side */
>> +	reset_control_deassert(pcie->pcie_xrst);
>>  
>> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
>>  		if (tegra_pcie_port_check_link(port))
>>  			continue;
>>  
>> @@ -2123,6 +2122,8 @@ static void tegra_pcie_disable_ports(struct tegra_pcie *pcie)
>>  {
>>  	struct tegra_pcie_port *port, *tmp;
>>  
>> +	reset_control_assert(pcie->pcie_xrst);
>> +
>>  	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
>>  		tegra_pcie_port_disable(port);
>>  }
>> @@ -2472,6 +2473,9 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
>>  
>>  	tegra_pcie_disable_ports(pcie);
>>  
>> +	reset_control_assert(pcie->pex_rst);
>> +	clk_disable_unprepare(pcie->pex_clk);
>> +
>>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>>  		tegra_pcie_disable_msi(pcie);
>>  
>> @@ -2501,10 +2505,19 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
>>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>>  		tegra_pcie_enable_msi(pcie);
>>  
>> +	err = clk_prepare_enable(pcie->pex_clk);
>> +	if (err) {
>> +		dev_err(dev, "failed to enable PEX clock: %d\n", err);
>> +		goto disable_controller;
>> +	}
>> +	reset_control_deassert(pcie->pex_rst);
>> +
>>  	tegra_pcie_enable_ports(pcie);
>>  
>>  	return 0;
>>  
>> +disable_controller:
>> +	tegra_pcie_disable_controller(pcie);
>>  poweroff:
>>  	tegra_pcie_power_off(pcie);
>>  
> There's quite a bit going on in this patch in general and I find it hard
> to review because not all the changes seem related to what you described
> in the commit message.
>
> Can you perhaps try to split out the error cleanup changes into a
> separate patch where it makes sense? It seems to me like at least for
> tegra_pcie_power_on() we're currently missing all of the cleanup code.
> You could make that a preparatory patch that goes before this particular
> patch, which will hopefully make this patch easier to review.
>
> Thierry
Okay, I will prepare new patch for error handling and restrict this patch only for
sequence correction
