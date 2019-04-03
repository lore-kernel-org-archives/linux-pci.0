Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F303CC10F06
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 09:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8772171F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 09:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XOXCngxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDCJQF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:16:05 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18363 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCJQF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 05:16:05 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca479d70000>; Wed, 03 Apr 2019 02:16:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 03 Apr 2019 02:16:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 03 Apr 2019 02:16:03 -0700
Received: from [10.24.47.153] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Apr
 2019 09:15:52 +0000
Subject: Re: [PATCH 09/10] PCI: tegra: Add Tegra194 PCIe support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>, <kishon@ti.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <lorenzo.pieralisi@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <tiwai@suse.de>, <spujar@nvidia.com>, <skomatineni@nvidia.com>,
        <liviu.dudau@arm.com>, <krzk@kernel.org>, <heiko@sntech.de>,
        <horms+renesas@verge.net.au>, <olof@lixom.net>,
        <maxime.ripard@bootlin.com>, <andy.gross@linaro.org>,
        <bjorn.andersson@linaro.org>, <jagan@amarulasolutions.com>,
        <enric.balletbo@collabora.com>, <ezequiel@collabora.com>,
        <stefan.wahren@i2se.com>, <marc.w.gonzalez@free.fr>,
        <l.stach@pengutronix.de>, <tpiepho@impinj.com>,
        <hayashi.kunihiko@socionext.com>, <yue.wang@amlogic.com>,
        <shawn.lin@rock-chips.com>, <xiaowei.bao@nxp.com>,
        <devicetree@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kthota@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-10-git-send-email-vidyas@nvidia.com>
 <20190329203159.GG24180@google.com>
 <5eb9599c-a6d6-d3a3-beef-5225ed7393f9@nvidia.com>
 <20190402141424.GB8017@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <d51370ab-16be-18c8-5912-73ff9863a8ca@nvidia.com>
Date:   Wed, 3 Apr 2019 14:45:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402141424.GB8017@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554282967; bh=c8MvKeNkm6jRMFC23RiJXHefhPBDTqQ9LaEl0LP157I=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XOXCngxm765cJ6zww+F0HIGSXw86e6cX3pkHYvyOMqf3JbibcKhTASUKnfcdY96Nm
         t72n3jP6kGHzhiOtRoj16nv8Qv7w44xaHd+7dowbFd1p+WviUEjbZ67sfRL+nqIkSP
         TaYbkusIdEOSR4Qwr2WdCeb+c6wImfsZ8L7HJM8ddfkZmPOAg9SX0vKwmLMRUStFZW
         HUNdRyveeOsxSFNwSx/Kw4dQIm9+sfi9SeeZLinKywWp1+W+frRBAlbrJOszBXH6KN
         GBilyA7cC7vBakLVrrKAcEJXn5lqT9md9a0cCDCYopJHGLMIZGsmD7R3nWB5+SB1FB
         FKrXHIN6Hc9pg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/2/2019 7:44 PM, Thierry Reding wrote:
> On Tue, Apr 02, 2019 at 12:47:48PM +0530, Vidya Sagar wrote:
>> On 3/30/2019 2:22 AM, Bjorn Helgaas wrote:
> [...]
>>>> +static int tegra_pcie_dw_host_init(struct pcie_port *pp)
>>>> +{
> [...]
>>>> +	val_w = dw_pcie_readw_dbi(pci, CFG_LINK_STATUS);
>>>> +	while (!(val_w & PCI_EXP_LNKSTA_DLLLA)) {
>>>> +		if (!count) {
>>>> +			val = readl(pcie->appl_base + APPL_DEBUG);
>>>> +			val &= APPL_DEBUG_LTSSM_STATE_MASK;
>>>> +			val >>= APPL_DEBUG_LTSSM_STATE_SHIFT;
>>>> +			tmp = readl(pcie->appl_base + APPL_LINK_STATUS);
>>>> +			tmp &= APPL_LINK_STATUS_RDLH_LINK_UP;
>>>> +			if (val == 0x11 && !tmp) {
>>>> +				dev_info(pci->dev, "link is down in DLL");
>>>> +				dev_info(pci->dev,
>>>> +					 "trying again with DLFE disabled\n");
>>>> +				/* disable LTSSM */
>>>> +				val = readl(pcie->appl_base + APPL_CTRL);
>>>> +				val &= ~APPL_CTRL_LTSSM_EN;
>>>> +				writel(val, pcie->appl_base + APPL_CTRL);
>>>> +
>>>> +				reset_control_assert(pcie->core_rst);
>>>> +				reset_control_deassert(pcie->core_rst);
>>>> +
>>>> +				offset =
>>>> +				dw_pcie_find_ext_capability(pci,
>>>> +							    PCI_EXT_CAP_ID_DLF)
>>>> +				+ PCI_DLF_CAP;
>>>
>>> This capability offset doesn't change, does it?  Could it be computed
>>> outside the loop?
>> This is the only place where DLF offset is needed and gets calculated and this
>> scenario is very rare as so far only a legacy ASMedia USB3.0 card requires DLF
>> to be disabled to get PCIe link up. So, I thought of calculating the offset
>> here itself instead of using a separate variable.
>>
>>>
>>>> +				val = dw_pcie_readl_dbi(pci, offset);
>>>> +				val &= ~DL_FEATURE_EXCHANGE_EN;
>>>> +				dw_pcie_writel_dbi(pci, offset, val);
>>>> +
>>>> +				tegra_pcie_dw_host_init(&pcie->pci.pp);
>>>
>>> This looks like some sort of "wait for link up" retry loop, but a
>>> recursive call seems a little unusual.  My 5 second analysis is that
>>> the loop could run this 200 times, and you sure don't want the
>>> possibility of a 200-deep call chain.  Is there way to split out the
>>> host init from the link-up polling?
>> Again, this recursive calling comes into picture only for a legacy ASMedia
>> USB3.0 card and it is going to be a 1-deep call chain as the recursion takes
>> place only once depending on the condition. Apart from the legacy ASMedia card,
>> there is no other card at this point in time out of a huge number of cards that we have
>> tested.
> 
> A more idiomatic way would be to add a "retry:" label somewhere and goto
> that after disabling DLFE. That way you achieve the same effect, but you
> can avoid the recursion, even if it is harmless in practice.
Initially I thought of using goto to keep it simple, but I thought it would be
discouraged and hence used recursion. But, yeah.. agree that goto would keep
it simple and I'll switch to goto now.

> 
>>>> +static int tegra_pcie_dw_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct tegra_pcie_dw *pcie;
>>>> +	struct pcie_port *pp;
>>>> +	struct dw_pcie *pci;
>>>> +	struct phy **phy;
>>>> +	struct resource	*dbi_res;
>>>> +	struct resource	*atu_dma_res;
>>>> +	const struct of_device_id *match;
>>>> +	const struct tegra_pcie_of_data *data;
>>>> +	char *name;
>>>> +	int ret, i;
>>>> +
>>>> +	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
>>>> +	if (!pcie)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	pci = &pcie->pci;
>>>> +	pci->dev = &pdev->dev;
>>>> +	pci->ops = &tegra_dw_pcie_ops;
>>>> +	pp = &pci->pp;
>>>> +	pcie->dev = &pdev->dev;
>>>> +
>>>> +	match = of_match_device(of_match_ptr(tegra_pcie_dw_of_match),
>>>> +				&pdev->dev);
>>>> +	if (!match)
>>>> +		return -EINVAL;
>>>
>>> Logically could be the first thing in the function since it doesn't
>>> depend on anything.
>> Done
>>
>>>
>>>> +	data = (struct tegra_pcie_of_data *)match->data;
> 
> of_device_get_match_data() can help remove some of the above
> boilerplate. Also, there's no reason to check for a failure with these
> functions. The driver is OF-only and can only ever be probed if the
> device exists, in which case match (or data for that matter) will never
> be NULL.
Done.

> 
>>> I see that an earlier patch added "bus" to struct pcie_port.  I think
>>> it would be better to somehow connect to the pci_host_bridge struct.
>>> Several other drivers already do this; see uses of
>>> pci_host_bridge_from_priv().
>> All non-DesignWare based implementations save their private data structure
>> in 'private' pointer of struct pci_host_bridge and use pci_host_bridge_from_priv()
>> to get it back. But, DesignWare based implementations save pcie_port in 'sysdata'
>> and nothing in 'private' pointer. So,  I'm not sure if pci_host_bridge_from_priv()
>> can be used in this case. Please do let me know if you think otherwise.
> 
> If nothing is currently stored in the private pointer, why not do like
> the other drivers and store the struct pci_host_bridge pointer there?
non-designware drivers get their private data allocated as part of pci_alloc_host_bridge()
by passing the size of their private structure and use pci_host_bridge_from_priv() to get
pointer to their own private structure (which is within struct pci_host_bridge).
Whereas in Designware core, we can get the memory for struct pcie_port much before than
calling pci_alloc_host_bridge() API, in fact, size '0' is passed as an argument to alloc API.
This is the reason why struct pcie_port pointer is saved in 'sysdata'.

> 
> Thierry
> 

