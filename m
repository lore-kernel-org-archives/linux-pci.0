Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A86FC4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1112075E
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RkUaFK23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfDDTyK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:54:10 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13702 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbfDDTyK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 15:54:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca660e30001>; Thu, 04 Apr 2019 12:54:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 12:54:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 12:54:07 -0700
Received: from [10.25.75.5] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 19:53:55 +0000
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
 <dcbfbb32-9980-7ee4-89cd-baedfe624ce5@nvidia.com>
 <20190403173641.GI141706@google.com>
From:   Vidya Sagar <vidyas@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <6cc7e047-bc7e-fa60-88ba-0b69c3d5a3f0@nvidia.com>
Date:   Fri, 5 Apr 2019 01:23:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403173641.GI141706@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554407651; bh=OWQn3ig66DJJEGKfNeX2nh87ZZ76PZqAyCzpqdYb3wA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RkUaFK234qmCLk/i7qBEr6lD1thVIURdmkQZ7ffYTsW1wqGRKQSAC5NogTAMOztRk
         XU66JW1VxPZ6eHxBy/AWz/njYd3c+b+uzM+v4bK2lumaGtUdE5ppJb4jJT3JC3Nia9
         U0zU1OfyXWyuwDdXjIwNB87drJWQIwSKgfRmkRgPga7W7FIal+9ILPr/cdQNxKu9i/
         YUw7KGG0hPcS0O4Z/AuKtpBuhSjIEowLgphBTaq68uAYFWIx9uxRDrr7naLUPPz7Bb
         jyy4ZT3k88FmtZJaCleb8U2y4FPJrJx9b6sL0ikdLkT9HQvfg/p0Bdm1ThmVrvN+Gk
         kXQ3TEno5TClA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/3/2019 11:06 PM, Bjorn Helgaas wrote:
> On Wed, Apr 03, 2019 at 03:13:09PM +0530, Vidya Sagar wrote:
>> On 4/3/2019 12:01 AM, Bjorn Helgaas wrote:
>>> On Tue, Apr 02, 2019 at 12:47:48PM +0530, Vidya Sagar wrote:
>>>> On 3/30/2019 2:22 AM, Bjorn Helgaas wrote:
>>>>> On Tue, Mar 26, 2019 at 08:43:26PM +0530, Vidya Sagar wrote:
>>>>>> Add support for Synopsys DesignWare core IP based PCIe host controller
>>>>>> present in Tegra194 SoC.
>>>
>>>     - Why does this chip require pcie_pme_disable_msi()?  The only other
>>>       use is a DMI quirk for "MSI Wind U-100", added by c39fae1416d5
>>>       ("PCI PM: Make it possible to force using INTx for PCIe PME
>>>       signaling").
>>
>> Because Tegra194 doesn't support raising PME interrupts through MSI line.
> 
> What does the spec say about this?  Is hardware supposed to support
> MSI for PME?  Given that MSI Wind U-100 and Tegra194 are the only two
> cases we know about where PME via MSI isn't supported, it seems like
> there must be either a requirement for that or some mechanism for the
> OS to figure this out, e.g., a capability bit.
AFAIU, Spec doesn't say anything about whether PME interrupt should be through MSI
or by other means. As far as Tegra194 is concerned, there are only two
interrupt lanes that go from PCIe IP to GIC, one being legacy interrupt (that
represents legacy interrupts coming over PCIe bus from downstream devices and
also the events happening internal to root port) and the other being MSI
interrupt (that represents MSI interrupts coming over PCIe bus from downstream
devices). Since hardware folks had a choice to route PME interrupts either
through legacy interrupt line or through MSI interrupt line and legacy interrupt
line was chosen as a design choice. That being the case at hardware level, I tried
to inform the same through pcie_pme_disable_msi() to PCIe sub-system that
PME interrupts are not expected over MSI.

> 
>>>>> I see that an earlier patch added "bus" to struct pcie_port.
>>>>> I think it would be better to somehow connect to the
>>>>> pci_host_bridge struct.  Several other drivers already do
>>>>> this; see uses of pci_host_bridge_from_priv().
>>>>
>>>> All non-DesignWare based implementations save their private data
>>>> structure in 'private' pointer of struct pci_host_bridge and use
>>>> pci_host_bridge_from_priv() to get it back. But, DesignWare
>>>> based implementations save pcie_port in 'sysdata' and nothing in
>>>> 'private' pointer. So,  I'm not sure if
>>>> pci_host_bridge_from_priv() can be used in this case. Please do
>>>> let me know if you think otherwise.
>>>
>>> DesignWare-based drivers should have a way to retrieve the
>>> pci_host_bridge pointer.  It doesn't have to be *exactly* the same
>>> as non-DesignWare drivers, but it should be similar.
>>
>> I gave my reasoning as to why with the current code, it is not
>> possible to get the pci_host_bridge structure pointer from struct
>> pcie_port pointer in another thread as a reply to Thierry Reding's
>> comments. Since Jishen'g changes to support remove functionality are
>> accepted, I think using bus pointer saved in struct pcie_port
>> pointer shouldn't be any issue now. Please do let me know if that is
>> something not acceptable.
>>
>>>>> That would give you the bus, as well as flags like
>>>>> no_ext_tags, native_aer, etc, which this driver, being a host
>>>>> bridge driver that's responsible for this part of the
>>>>> firmware/OS interface, may conceivably need.
> 
> I think saving the pp->root_bus pointer as Jisheng's patch does is a
> sub-optimal solution.  If we figure out how to save the
> pci_host_bridge pointer, we automatically get the root bus pointer as
> well.
> 
> It may require some restructuring to save the pci_host_bridge pointer,
> but I doubt it's really *impossible*.
Is it OK to save pci_host_bridge pointer in pcie_port structure directly? I see
that as another way to get pci_host_bridge pointer from pcie_port
structure. My understanding is that, to get pci_host_bridge pointer, either
pcie_port structure should be part of pci_host_bridge structure (which is the
case with all non-DW implementations) or pcie_port should have a pointer to
some structure which is directly (and not by means of a pointer) part of
pci_host_bridge structure so that container_of() can be used to get pci_host_bridge.
As I see, there is no data object of pci_host_bridge whose pointer is saved in
pcie_port structure. In fact, in reverse, pcie_port's struct dev pointer is saved
as parent to pci_host_bridge's struct dev. So, another way would be to iterate over
the children of pcie_port's struct dev pointer to find pci_host_bridge's dev pointer
and from there get pci_host_bridge through container_of. But, I think is complicating
it more than using bus pointer from pcie_port. I'm not sure if I'm able to convey the
issue I'm facing here to get pci_host_bridge from pcie_port, but doing any other thing seems complicating it even more.

> 
>>>>>> +static int tegra_pcie_dw_runtime_suspend(struct device *dev)
>>>>>> +{
>>>>>> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
>>>>>> +
>>>>>> +	tegra_pcie_downstream_dev_to_D0(pcie);
>>>>>> +
>>>>>> +	pci_stop_root_bus(pcie->pci.pp.bus);
>>>>>> +	pci_remove_root_bus(pcie->pci.pp.bus);
>>>>>
>>>>> Why are you calling these?  No other drivers do this except in
>>>>> their .remove() methods.  Is there something special about
>>>>> Tegra, or is this something the other drivers *should* be
>>>>> doing?
>>>>
>>>> Since this API is called by remove, I'm removing the hierarchy
>>>> to safely bring down all the devices. I'll have to re-visit this
>>>> part as Jisheng Zhang's patches
>>>> https://patchwork.kernel.org/project/linux-pci/list/?series=98559
>>>> are now approved and I need to verify this part after
>>>> cherry-picking Jisheng's changes.
>>>
>>> Tegra194 should do this the same way as other drivers, independent
>>> of Jisheng's changes.
>>
>> When other Designware implementations add remove functionality, even
>> they should be calling these APIs (Jisheng also mentioned the same
>> in his commit message)
> 
> My point is that these APIs should be called from driver .remove()
> methods, not from .runtime_suspend() methods.
.remove() internally calls pm_runtime_put_sync() API which calls
.runtime_suspend(). I made a new patch to add a host_deinit() call
which make all these calls. Since host_init() is called from inside
.runtime_resume() of this driver, to be in sync, I'm now calling
host_deinit() from inside .runtime_suspend() API.
  
> 
> Bjorn
> 

