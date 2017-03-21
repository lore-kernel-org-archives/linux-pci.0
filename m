Return-Path: <SRS0=04wA=26=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=04wA=26=free.fr=slash.tmp@kernel.org>
Subject: Re: [RFC PATCH v0.001] PCI: Add support for tango PCIe controller
To: Liviu Dudau <liviu.dudau@arm.com>
References: <ab110ce2-8678-9b34-6bd1-6cfaaa7fea04@free.fr>
 <f13c385d-dcc9-dacd-2b2c-ca098228f4f4@free.fr>
 <20170321123129.GB6816@e110455-lin.cambridge.arm.com>
 <d5062453-39cc-1435-bb13-87c81b6ef0b3@free.fr>
 <20170321142305.GC6816@e110455-lin.cambridge.arm.com>
From: Mason <slash.tmp@free.fr>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 David Laight <david.laight@aculab.com>, linux-pci
 <linux-pci@vger.kernel.org>, Linux ARM
 <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Joerg Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>
Message-ID: <c4115685-577c-aa6a-3bf7-422ab711d214@free.fr>
Date: Tue, 21 Mar 2017 17:19:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170321142305.GC6816@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 21/03/2017 15:23, Liviu Dudau wrote:

> On Tue, Mar 21, 2017 at 02:01:57PM +0100, Mason wrote:
>
>> My PCIe controller is b/d/f 0/0/0.
>> It ignores all PCI addresses that do not fall within the range
>> defined in BAR0 of b/d/f 0/0/0.
>>
>> BAR0 has a configurable width of 2^(23+i) bytes, i < 8
>> It is implicitly split in 8 regions, which can map to
>> anywhere in CPU space. However, my understanding is that,
>> by default, the DMA framework expects PCI address X to
>> map to CPU address X...
>> (My understanding of that part is still a bit hazy.)
> 
> It looks very much like your PCIe controller (host bridge) has the configuration
> registers on the wrong side of the bridge (PCIe one vs the more normal host side).
> But otherwise it does look very much like an ATS system, where you program how the
> PCIe bus addresses map into the system (you call them CPU) addresses. Do you also
> have a way of controlling the direction of the mapping? (in other words, those 8
> regions are only for translating request coming out of the PCIe bus into system
> addresses, or can you also set the direct mapping of system address to PCIe address?).

There are two (asymmetric) features for these mappings.

For bus-to-system accesses, the scheme described above
of "bus addresses within BAR0 fall into 1 of 8 regions,
and 8 registers define 8 target system addresses".

For system-to-bus accesses, there is a single "offset"
register which gets added to the system address, to form
the bus address. I just use a 0 offset.

(This is made slightly more complex on later chips because
someone in marketing thought it would look good on the
data sheet to support 4 GB of RAM in a SoC using 32-bit
processors. There is an additional cpu-to-foo mapping.)

> As for DMA framework expectations, I'm not sure how that plays a role, unless you
> have some DMA engines on the PCIe bus.

I think the USB3 PCIe card I'm using is a bus master, so
it's able to push data to RAM without any help from the
ARM core.

Regards.

P.S. something in your message is confusing my MUA, likely
your Mail-Followup-To field. My MUA thinks it should not
send you my reply. Is that really what you want?
