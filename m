Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0064.outbound.protection.outlook.com ([157.56.110.64]:59650
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753284AbbIWQYg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Sep 2015 12:24:36 -0400
Message-ID: <5602D231.5090709@caviumnetworks.com>
Date: Wed, 23 Sep 2015 09:24:17 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>,
	David Daney <ddaney.cavm@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<devicetree@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/3] PCI: Add quirks for devices found on Cavium ThunderX
 SoCs.
References: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com> <3066583.BWDZlYWxXU@wuerfel> <55FC4330.10302@caviumnetworks.com> <2512701.zkjk3n3AQS@wuerfel> <55FCB3AC.8080709@caviumnetworks.com> <20150922131916.GE27964@google.com>
In-Reply-To: <20150922131916.GE27964@google.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/22/2015 06:19 AM, Bjorn Helgaas wrote:
> Hi David,
>
> On Fri, Sep 18, 2015 at 06:00:28PM -0700, David Daney wrote:
>> On 09/18/2015 12:45 PM, Arnd Bergmann wrote:
>>> On Friday 18 September 2015 10:00:32 David Daney wrote:
>>>> On 09/18/2015 12:19 AM, Arnd Bergmann wrote:
>>>>> On Thursday 17 September 2015 15:41:33 David Daney wrote:
>>>>>> From: David Daney <david.daney@cavium.com>
>>>>>>
>>>>>> The on-chip devices all have fixed bars.  So, fix them up.
>>>>>>
>>>>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>>>>>
>>>>>
>>>>> You should be able to just mark the BARs as fixed in DT
>>
>> I think we can switch to PCI_PROBE_ONLY, and have all non-fixed BAR
>> devices configured by firmware.  This may significantly simplify any
>> quirks required in the kernel.
>
> I don't like PCI_PROBE_ONLY, and I'd like to avoid it when we can.

I don't like it either, but if it were the only way the PCI maintainers 
would allow us to support the hardware, I would rewrite the firmware to 
make it possible.  However, as you say below ...

>
> Your original patch description said the on-chip devices have "fixed
> BARs."  In what sense are they "fixed"?  I assume they are writable
> enough so we can learn their sizes?

Yes.  The BAR registers are writable, but ignored.  So, the size is 
correctly probed.  The BAR registers are initialized by 
hardware/firmware to the proper value.

>  If we can't learn their sizes, we
> have bigger problems because we can't tell what space is used.
>
> Are there other parts of the system, e.g., run-time firmware, that
> depend on the devices not being moved?

The devices cannot move, the address decoding is not programmable.  The 
BAR registers are provided as an aid in integrating the devices with OS 
PCI infrastructure.  Although, one might argue that they don't do a very 
good job of adhering to the PCI specifications...

>
>>>> For the record:  The PCI Enhanced Allocation (EA) capability (approved
>>>> by PCI SIG on 23 October 2014) is the proper way to handle this going
>>>> forward.  However, this is not yet implemented in the SoCs that this
>>>> patch addresses.  Our plan is to implement the EA capability in the core
>>>> PCI code, so that we do not need to keep adding devices to this fixup code.
>
> Sean Stalley has posted some patches to add EA support to Linux, but I
> haven't merged them yet.  If we had that, another option would be to
> hook into your config accessors and fabricate an EA capability.

To me, this is the most interesting part of your message.  If you really 
would accept a config read accessor that presented a synthetic EA 
capability, that would be ideal.  We know exactly which roots contain 
the fixed devices, so it would be a trivial exercise to provide a custom 
config accessor.

I am going to work on this in hope of eventual acceptance of this strategy.

Thanks,
David Daney


