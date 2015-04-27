Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56029 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbbD0H63 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Apr 2015 03:58:29 -0400
Message-ID: <553DEC20.3010400@arm.com>
Date: Mon, 27 Apr 2015 08:58:24 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Varun Sethi <Varun.Sethi@freescale.com>,
	Stuart Yoder <stuart.yoder@freescale.com>
CC: Will Deacon <Will.Deacon@arm.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>	<1429091364-31939-2-git-send-email-Minghuan.Lian@freescale.com>	<BN3PR0301MB1219110247416097623B4A7CEAE50@BN3PR0301MB1219.namprd03.prod.outlook.com>	<DM2PR0301MB06402A7F6BF42B9A84669D94E2E50@DM2PR0301MB0640.namprd03.prod.outlook.com>	<BN3PR0301MB121987D3E12F25B79E8C51EFEAE50@BN3PR0301MB1219.namprd03.prod.outlook.com>	<20150416104008.GB25640@arm.com>	<CY1PR0301MB0748D9259F32CBBC2C580BD187E30@CY1PR0301MB0748.namprd03.prod.outlook.com>	<20150422170718.GG13019@arm.com>	<CY1PR0301MB0748AFF942250831769C40E587EE0@CY1PR0301MB0748.namprd03.prod.outlook.com>	<20150424161818.GC7313@arm.com>	<553A72D4.7000801@arm.com>	<CY1PR0301MB074896DF1A06CDEC3A0E09B687EC0@CY1PR0301MB0748.namprd03.prod.outlook.com> <20150425113930.7386a42a@arm.com> <BN1PR0301MB06276181976E880432B8C49AEAEA0@BN1PR0301MB0627.namprd03.prod.outlook.com>
In-Reply-To: <BN1PR0301MB06276181976E880432B8C49AEAEA0@BN1PR0301MB0627.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Varun,

On 26/04/15 19:20, Varun Sethi wrote:
> Hi Marc,
> 
>>>> We can deal with the aliasing, provided that we extend the level of
>>>> quirkiness that pci_for_each_dma_alias can deal with. But that
>>>> doesn't solve any form of hotplug/SR-IOV behaviour.
>>>>
> [varun] Can you please elaborate on "extending the quirkiness of
> pci_for_each_dma_alias". How do you see the case for transparent host
> bridege being handled? We would see a device ID corresponding to the
> host bridge for masters behind that bridge.

The PCI code already has code to deal with aliases, and can deal with
them in a number of cases.

At the moment, this aliasing code can only deal with aliases that belong
to the same PCI bus (or aliasing with the bus itself). Given the way the
problem has been described, I understand that you can have devices
sitting on different buses that will end up with the same DeviceID. This
is where expanding the "quirkiness" of pci_for_each_dma_alias comes into
play. You need to teach it about this kind of topology.

>>>> Somehow, we're going to end-up with grossly oversized ITTs, just to
>>>> accommodate for the fact that we have no idea how many MSIs we're
>>>> going to end-up needing. I'm not thrilled with that prospect.
>>>
>>> How can we avoid that in the face of hotplug?
>>
>> Fortunately, hotplug is not always synonymous of aliasing. The ITS is built
>> around the hypothesis that aliasing doesn't happen, and that you know
>> upfront how many LPIs the device will be allowed to generate.
>>
>>> And what are we really worried about regarding over-sized ITTs...bytes
>>> of memory saved?
>>
>> That's one thing, yes. But more fundamentally, how do you size your MSI
>> capacity for a single alias? Do you evenly split your LPI space among all
>> possible aliases? Assuming 64 aliases and 16 bits of interrupt ID space, you
>> end up with 10 bit per alias. Is that always enough? Or do you need
>> something more fine-grained?
>>
>>> A fundamental thing built into the IOMMU subsystem in Linux is
>>> representing iommu groups that can represent things like multiple PCI
>>> devices that for hardware reasons cannot be isolated (and the example
>>> I've seen given relates to devices behind PCI bridges).
>>>
>>> So, I think the thing we are facing here is that while the IOMMU
>>> subsystem has accounted for reprsenting the isolation characteristics
>>> of a system with iommu groups, there is no corresponding "msi group"
>>> concept.
>>>
>>> In the SMMU/GIC-500-ITS world the iommu isolation ID (the stream ID)
>>> and the GIC-ITS device ID are in fact the same ID.
>>
>> The DeviceID is the "MSI group" you mention. This is what provides isolation
>> at the ITS level.
>>
> [varun] True, in case of a transparent host bridge device Id won't
> provide the necessary isolation.

Well, it depends how you look at it. How necessary is this isolation,
since we've already established that you couldn't distinguish between
these devices at the IOMMU level?

>>> Is there some way we could sanely correlate IOMMU group creation
>>> (which establishes isolation granularity) with the creation of an ITT
>>> for the GIC-ITS?
>>
>> The problem you have is that your ITT already exists before you start
>> "hotpluging" new devices. Take the following (made up) example:
>>
>> System boots, device X is discovered, claims 64 MSIs. An ITT for device X is
>> allocated, and sized for 64 LPIs. SR-IOV kick is, creates a new X'
>> function that is aliased to X, claiming another 64 MSIs. Fail.
>>
>> What do we do here? The ITT is live (X is generating interrupts), and there is
>> no provision to resize it (I've come up with a horrible scheme, but that could
>> fail as well). The only sane option would be to guess how many MSIs a given
>> alias could possibly use. How wrong is this guess going to be?
>>
>> The problem we have is that IOMMU groups are dynamic, while ITT allocation
>> is completely static for a given DeviceID. The architecture doesn't give you
>> any mechanism to resize it, and I have the ugly feeling that static allocation of
>> the ID space to aliases is too rigid...
> 
> [varun] One way would be to restrict the number of stream Ids(device
> Ids) per PCIe controller. In our scheme we have a device id -> stream
> ID translation table, we can restrict the number of entries in the
> table. This would restrict number of virtual functions.

Do you mean reserving a number of StreamIDs per PCIe controller, and
letting virtual functions use these spare StreamIDs? This would indeed
be more restrictive. But more importantly, who is going to be in charge
of this mapping/allocation?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
