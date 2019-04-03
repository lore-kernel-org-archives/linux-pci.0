Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4758C4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 09:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F90206B8
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 09:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dp1SHM67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfDCJn0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:43:26 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1305 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDCJn0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 05:43:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca480380001>; Wed, 03 Apr 2019 02:43:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 03 Apr 2019 02:43:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 03 Apr 2019 02:43:23 -0700
Received: from [10.24.47.153] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Apr
 2019 09:43:12 +0000
Subject: Re: [PATCH 09/10] PCI: tegra: Add Tegra194 PCIe support
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
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
 <20190402183110.GE141706@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <dcbfbb32-9980-7ee4-89cd-baedfe624ce5@nvidia.com>
Date:   Wed, 3 Apr 2019 15:13:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402183110.GE141706@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554284601; bh=YICvhpt1zcdsCjrF6+a2YJZMu+Rrp7EjkmMpC2TVyas=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dp1SHM67KsbBsl3217gpI6bxdyXlG+AFtWfBJE86DK/U9AzKDeyknBQd/PU1DIFY3
         KL4eMpLnqzgAny43kfhAwVHUUIejeyIkzsIsJjz0lpWDHMAR0B2OZcTz6rWaAgKjC0
         GuIfUGETNya2T+QGPfr3iWf5aH7RMOFIdp1x+iRrNzmQvhjj8uAs24gp1WZLLEp0/Q
         EIX+Ty3q/ArqEzGWo8LE/mt7uop1ZwmhixSubySchFaKvnw3wsK2aEvQHduRXJbTJ+
         xGoZMLeXGxlgIivE99KpqVF6Fqk/NWgtMd3EJm+XoiYEOu3ZaCGxXwTVUi2a2llIcM
         +XZ/B4wfuZdSA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/3/2019 12:01 AM, Bjorn Helgaas wrote:
> On Tue, Apr 02, 2019 at 12:47:48PM +0530, Vidya Sagar wrote:
>> On 3/30/2019 2:22 AM, Bjorn Helgaas wrote:
>>> On Tue, Mar 26, 2019 at 08:43:26PM +0530, Vidya Sagar wrote:
>>>> Add support for Synopsys DesignWare core IP based PCIe host controller
>>>> present in Tegra194 SoC.
> 
>>>> +#include "../../pcie/portdrv.h"
>>>
>>> What's this for?  I didn't see any obvious uses of things from
>>> portdrv.h, but I didn't actually try to build without it.
>> This is for pcie_pme_disable_msi() API. Since this is defined in portdrv.h
>> file, I'm including it here.
> 
> Hmm, OK, I missed that.  If you need pcie_pme_disable_msi(), you
> definitely need portdrv.h.  But you're still a singleton in terms of
> including it, so it leads to follow-up questions:
> 
>    - Why does this chip require pcie_pme_disable_msi()?  The only other
>      use is a DMI quirk for "MSI Wind U-100", added by c39fae1416d5
>      ("PCI PM: Make it possible to force using INTx for PCIe PME
>      signaling").
Because Tegra194 doesn't support raising PME interrupts through MSI line.
> 
>    - Is this a workaround for a Tegra194 defect?  If so, it should be
>      separated out and identified as such.  Otherwise it will get
>      copied to other places where it doesn't belong.
This is a guideline from the hardware team that MSI for PME should be disabled.
I'll make an explicit comment in the code that it is specific to Tegra194.
> 
>    - You only call it from the .runtime_resume() hook.  That doesn't
>      make sense to me: if you never suspend, you never disable MSI for
>      PME signaling.
.runtime_resume() not only gets called during resume, but also in normal path
as we are using PM framework and pm_runtime_get_sync() gets called finally
in the probe which executes .runtime_resume() hook.

> 
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
> 
> Hmm.  Sounds like this is essentially a quirk to work around some
> hardware issue in Tegra194.
> 
> Is there some way you can pull this out into a separate function so it
> doesn't clutter the normal path and it's more obvious that it's a
> workaround?
> 
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
> We need to be able to analyze the code without spending time working
> out what arcane PCIe spec details might limit this to fewer than 200
> iterations, or relying on assumptions about how many cards have been
> tested.
> 
> If you can restructure this so the "wait for link up" loop looks like
> all the other drivers, and the DLF issue is separated out and just
> causes a retry of the "wait for link up", I think that will help a
> lot.
As per Thierry Reding's suggestion, I'll be using a goto statement to avoid
recursion and that should simplify things here.

> 
>>>> +static void tegra_pcie_dw_scan_bus(struct pcie_port *pp)
>>>> +{
>>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>> +	struct tegra_pcie_dw *pcie = dw_pcie_to_tegra_pcie(pci);
>>>> +	u32 speed;
>>>> +
>>>> +	if (!tegra_pcie_dw_link_up(pci))
>>>> +		return;
>>>> +
>>>> +	speed = (dw_pcie_readw_dbi(pci, CFG_LINK_STATUS) & PCI_EXP_LNKSTA_CLS);
>>>> +	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>>>
>>> I don't understand what's happening here.  This is named
>>> tegra_pcie_dw_scan_bus(), but it doesn't actually scan anything.
>>> Maybe it's just a bad name for the dw_pcie_host_ops hook
>>> (ks_pcie_v3_65_scan_bus() is the only other .scan_bus()
>>> implementation, and it doesn't scan anything either).
>>>
>>> dw_pcie_host_init() calls pci_scan_root_bus_bridge(), which actually
>>> *does* scan the bus, but it does it before calling
>>> pp->ops->scan_bus().  I'd say by the time we get to
>>> pci_scan_root_bus_bridge(), the device-specific init should be all
>>> done and we should be using only generic PCI core interfaces.
>>>
>>> Maybe this stuff could/should be done in the ->host_init() hook?  The
>>> code between ->host_init() and ->scan_bus() is all generic code with
>>> no device-specific stuff, so I don't know why we need both hooks.
>> Agree. At least whatever I'm going here as part of scan_bus can be moved to
>> host_init() itslef. I'm not sure about the original intention of the scan_bus
>> but my understanding is that, after PCIe sub-system enumerates all devices, if
>> something needs to be done, then, probably scan_bus() can be implemented for that.
>> I had some other code initially which was accessing downstream devices, hence I
>> implemented scan_bus(), but, now, given all that is gone, I can move this code to
>> host_init() itself.
> 
> That'd be perfect.  I suspect ks_pcie_v3_65_scan_bus() is left over
> from before the generic PCI core scan interface, and it could probably
> be moved to host_init() as well.
I think so.

> 
>>>> +static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
>>>> +{
>>>> +	struct pci_dev *pdev = NULL;
>>>
>>> Unnecessary initialization.
>> Done.
>>
>>>> +	struct pci_bus *child;
>>>> +	struct pcie_port *pp = &pcie->pci.pp;
>>>> +
>>>> +	list_for_each_entry(child, &pp->bus->children, node) {
>>>> +		/* Bring downstream devices to D0 if they are not already in */
>>>> +		if (child->parent == pp->bus) {
>>>> +			pdev = pci_get_slot(child, PCI_DEVFN(0, 0));
>>>> +			pci_dev_put(pdev);
>>>> +			if (!pdev)
>>>> +				break;
>>>
>>> I don't really like this dance with iterating over the bus children,
>>> comparing parent to pp->bus, pci_get_slot(), pci_dev_put(), etc.
>>>
>>> I guess the idea is to bring only the directly-downstream devices to
>>> D0, not to do it for things deeper in the hierarchy?
>> Yes.
>>
>>> Is this some Tegra-specific wrinkle?  I don't think other drivers do
>>> this.
>> With Tegra PCIe controller, if the downstream device is in non-D0 states,
>> link doesn't go into L2 state. We observed this behavior with some of the
>> devices and the solution would be to bring them to D0 state and then attempt
>> sending PME_TurnOff message to put the link to L2 state.
>> Since spec also supports this mechanism (Rev.4.0 Ver.1.0 Page #428), we chose
>> to implement this.
> 
> Sounds like a Tegra oddity that should be documented as such so it
> doesn't get copied elsewhere.
I'll add a comment explicitly to state the same.

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
> DesignWare-based drivers should have a way to retrieve the
> pci_host_bridge pointer.  It doesn't have to be *exactly* the
> same as non-DesignWare drivers, but it should be similar.
I gave my reasoning as to why with the current code, it is not possible to get the
pci_host_bridge structure pointer from struct pcie_port pointer in another thread as
a reply to Thierry Reding's comments. Since Jishen'g changes to support remove functionality
are accepted, I think using bus pointer saved in struct pcie_port pointer shouldn't be
any issue now. Please do let me know if that is something not acceptable.

> 
>>> That would give you the bus, as well as flags like no_ext_tags,
>>> native_aer, etc, which this driver, being a host bridge driver that's
>>> responsible for this part of the firmware/OS interface, may
>>> conceivably need.
> 
>>>> +static int tegra_pcie_dw_runtime_suspend(struct device *dev)
>>>> +{
>>>> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
>>>> +
>>>> +	tegra_pcie_downstream_dev_to_D0(pcie);
>>>> +
>>>> +	pci_stop_root_bus(pcie->pci.pp.bus);
>>>> +	pci_remove_root_bus(pcie->pci.pp.bus);
>>>
>>> Why are you calling these?  No other drivers do this except in their
>>> .remove() methods.  Is there something special about Tegra, or is this
>>> something the other drivers *should* be doing?
>> Since this API is called by remove, I'm removing the hierarchy to safely
>> bring down all the devices. I'll have to re-visit this part as
>> Jisheng Zhang's patches https://patchwork.kernel.org/project/linux-pci/list/?series=98559
>> are now approved and I need to verify this part after cherry-picking
>> Jisheng's changes.
> 
> Tegra194 should do this the same way as other drivers, independent of
> Jisheng's changes.
When other Designware implementations add remove functionality, even they should
be calling these APIs (Jisheng also mentioned the same in his commit message)

> 
> Bjorn
> 

