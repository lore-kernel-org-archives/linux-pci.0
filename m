Return-Path: <SRS0=04wA=26=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=04wA=26=free.fr=slash.tmp@kernel.org>
Subject: Re: [RFC PATCH v0.001] PCI: Add support for tango PCIe controller
To: Liviu Dudau <liviu.dudau@arm.com>
References: <ab110ce2-8678-9b34-6bd1-6cfaaa7fea04@free.fr>
 <f13c385d-dcc9-dacd-2b2c-ca098228f4f4@free.fr>
 <20170321123129.GB6816@e110455-lin.cambridge.arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 David Laight <david.laight@aculab.com>, linux-pci
 <linux-pci@vger.kernel.org>, Linux ARM
 <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Joerg Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>
From: Mason <slash.tmp@free.fr>
Message-ID: <d5062453-39cc-1435-bb13-87c81b6ef0b3@free.fr>
Date: Tue, 21 Mar 2017 14:01:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170321123129.GB6816@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 21/03/2017 13:31, Liviu Dudau wrote:

> On Tue, Mar 21, 2017 at 11:15:16AM +0100, Mason wrote:
>>
>> On 17/03/2017 17:11, Mason wrote:
>>
>>> + * QUIRK #5
>>> + * Only transfers within the BAR are forwarded to the host.
>>> + * By default, the DMA framework expects that
>>> + * PCI address 0x8000_0000 -> CPU address 0x8000_0000
>>> + * which is where DRAM0 is mapped.
>>
>> I have an additional question on this topic.
>>
>> In a typical system, PCI bus masters are able to access all of RAM,
>> unless there is some kind of IOMMU, right?
> 
> Depends where the ATS (Address translation service) lives and what gets
> programmed there, but usually one can restrict the RAM (or system address
> space, to be more precise) that can be accessed from the PCI bus masters
> by only providing PCI(e)-to-system bus mappings that make sense. Remember
> that on any PCI bus you can only see addresses that are a subset of your
> parent bus addresses. If the root PCI bus only allows access to a predefined
> range of addresses, then that is all you can access in the system.

Hmmm, where do I configure the range of addresses which the root
PCI bus allows access to? In the DT?

>> I suppose one may consider the above limitation ("Only transfers
>> within the BAR are forwarded to the host") as some form of weird
>> IOMMU? (There is, in fact, some remapping logic in the controller
>> setup which I haven't discussed so far.)
> 
> Not sure I understand the quirk. What BAR are you referring to when you say
> "within the BAR"? The bus master's? Are you saying that only if you write
> to a PCI bus address XXXXXXX that is in the range assigned by the parent
> bus then you can escape your bus hierarchy and target the system RAM? That
> sounds backwards to me.

My PCIe controller is b/d/f 0/0/0.
It ignores all PCI addresses that do not fall within the range
defined in BAR0 of b/d/f 0/0/0.

BAR0 has a configurable width of 2^(23+i) bytes, i < 8
It is implicitly split in 8 regions, which can map to
anywhere in CPU space. However, my understanding is that,
by default, the DMA framework expects PCI address X to
map to CPU address X...
(My understanding of that part is still a bit hazy.)

>> Since this SoC is used for TV, the media cartels mandate some way
>> to limit where PCI bus masters can peek/poke in RAM.
> 
> And that is usually done by either having a TrustZone controller on top of
> your PCI host bridge or by putting an IOMMU.

It seems we don't have this HW, therefore some kind of custom
HW quirk was required.

Regards.
