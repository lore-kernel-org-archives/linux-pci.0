Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0097.outbound.protection.outlook.com ([65.55.169.97]:11269
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756276AbcBHVj3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Feb 2016 16:39:29 -0500
Message-ID: <56B90B09.7090500@caviumnetworks.com>
Date: Mon, 8 Feb 2016 13:39:21 -0800
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Rob Herring <robh@kernel.org>
CC: David Daney <ddaney.cavm@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v5 3/3] pci, pci-thunder-ecam: Add driver for ThunderX-pass1
 on-chip devices
References: <1454715675-17512-1-git-send-email-ddaney.cavm@gmail.com> <1454715675-17512-4-git-send-email-ddaney.cavm@gmail.com> <20160208195642.GA15103@rob-hp-laptop> <56B8FED6.1050804@caviumnetworks.com> <CAL_JsqJNndZ59465YhpkP=dQYaijaar+LcQG4KQEJwF5e1ryLQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJNndZ59465YhpkP=dQYaijaar+LcQG4KQEJwF5e1ryLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/08/2016 01:12 PM, Rob Herring wrote:
> On Mon, Feb 8, 2016 at 2:47 PM, David Daney <ddaney@caviumnetworks.com> wrote:
>> On 02/08/2016 11:56 AM, Rob Herring wrote:
>>>
>>> On Fri, Feb 05, 2016 at 03:41:15PM -0800, David Daney wrote:
>>>>
>>>> From: David Daney <david.daney@cavium.com>
>
> [...]
>
>>>> +Properties of the host controller node that differ from
>>>> +host-generic-pci.txt:
>>>> +
>>>> +- compatible     : Must be "cavium,pci-host-thunder-ecam"
>>>> +
>>>> +Example:
>>>> +
>>>> +       pci@84b0,00000000 {
>>>
>>>
>>> Drop the comma,
>>
>>
>> OK...
>>
>>> and the node name should be "pcie".
>>>
>>
>> Why pcie?
>>
>> There are no PCIe devices or buses reachable from this type of root complex.
>> There are however many PCI devices.
>
> I thought ECAM is a PCIe thing. If not, then nevermind.


Well, Enhanced Configuration Access Mechanism (ECAM) is defined  the the 
PCI Express(R) base Specification, but it just defines a standard layout 
of address bits to memory map config space operations.  Since the PCI 
config space is a sub set of the PCIe config space, ECAM can also be 
used in PCI systems.

Really, it is a bit of a gray area here as we don't have any bridges to 
PCIe buses and there are multiple devices residing on each bus, so from 
that point of view it cannot be PCIe.  There are, however, devices that 
implement the PCI Express Capability structure, so does that make it 
PCIe?  It is not clear what the specifications demand here.

I choose to call it "pci" as it lacks much of what it means to be PCIe, 
and also you cannot plug things into it.

David Daney



>
> Rob
>

