Return-Path: <SRS0=Pg8w=26=arm.com=robin.murphy@kernel.org>
Return-Path: <SRS0=Pg8w=26=arm.com=robin.murphy@kernel.org>
Subject: Re: [RFC PATCH v0.001] PCI: Add support for tango PCIe controller
To: Mason <slash.tmp@free.fr>
References: <ab110ce2-8678-9b34-6bd1-6cfaaa7fea04@free.fr>
 <f13c385d-dcc9-dacd-2b2c-ca098228f4f4@free.fr>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Joerg Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9d23357c-fa59-d638-11ba-f1ab24dbeb43@arm.com>
Date: Tue, 21 Mar 2017 11:36:59 +0000
MIME-Version: 1.0
In-Reply-To: <f13c385d-dcc9-dacd-2b2c-ca098228f4f4@free.fr>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 21/03/17 10:15, Mason wrote:
> [ Adding iommu ML ]
> 
> On 17/03/2017 17:11, Mason wrote:
> 
>> + * QUIRK #5
>> + * Only transfers within the BAR are forwarded to the host.
>> + * By default, the DMA framework expects that
>> + * PCI address 0x8000_0000 -> CPU address 0x8000_0000
>> + * which is where DRAM0 is mapped.
> 
> I have an additional question on this topic.
> 
> In a typical system, PCI bus masters are able to access all of RAM,
> unless there is some kind of IOMMU, right?

Typically, yes (as always, exceptions exist, but it happens that we
still need some work to actually support those cases properly).

> I suppose one may consider the above limitation ("Only transfers
> within the BAR are forwarded to the host") as some form of weird
> IOMMU? (There is, in fact, some remapping logic in the controller
> setup which I haven't discussed so far.)

Not really. If it's the 8x128MB region thing mentioned elsewhere, that's
far too coarse a granularity to be much use with the existing IOMMU API
(this vaguely reminds me of a similar discussion about programmable
interconnects ages ago). Unless it's actually got some sort of GART-type
thing or better capable of page-granularity mappings within a
significantly-sized region, I'd put that idea to bed.

> Since this SoC is used for TV, the media cartels mandate some way
> to limit where PCI bus masters can peek/poke in RAM.

FWIW, since that sounds like more of a box-ticking exercise than a real
practical concern, I'd point out that content protection is more or less
the poster child for TrustZone, and your TZASC should help tick that box
regardless.

Robin.

> 
> Regards.
> 
