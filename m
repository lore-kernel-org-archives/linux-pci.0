Return-Path: <SRS0=eIvo=2N=linaro.org=ard.biesheuvel@kernel.org>
Return-Path: <SRS0=eIvo=2N=linaro.org=ard.biesheuvel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <c6d21078-b2f0-8dd3-adf7-13fc6456c1aa@free.fr>
References: <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
 <8643c952-e915-bcd1-390e-9d4001789872@free.fr> <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
 <347d4200-e089-60df-5f60-58d16efc7c4e@free.fr> <20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
 <98ee3041-6a94-91af-b4bf-208aa02624ed@free.fr> <20170301215726.GA32286@bhelgaas-glaptop.roam.corp.google.com>
 <258cd6f3-ef17-6705-ff48-ae06f26778c2@free.fr> <20170303154628.GA21522@bhelgaas-glaptop.roam.corp.google.com>
 <8e1a0b5d-8dfb-4be1-a049-b16892a6c0d0@free.fr> <20170303200407.GB30375@bhelgaas-glaptop.roam.corp.google.com>
 <5c899946-4220-a63e-fe98-6a103200c2ad@free.fr> <CAKv+Gu-QxUYZcg4DPwuhhfqKCp4eJEWXCh43ZyvDe12=exEhWw@mail.gmail.com>
 <8daa1f79-8fda-bef9-e216-3c15f53c4f32@free.fr> <CAKv+Gu_fLKvruKy2Aoa95ThPAJ2XDJVUCjeuAWaRwpifsn_A_w@mail.gmail.com>
 <c6d21078-b2f0-8dd3-adf7-13fc6456c1aa@free.fr>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 4 Mar 2017 13:49:01 +0000
Message-ID: <CAKv+Gu_SG9ynmBKCpQyLgVcU2_cxWoHHeoyAhxN+cKQuR+su3Q@mail.gmail.com>
Subject: Re: Using the generic host PCIe driver
To: Mason <slash.tmp@free.fr>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
	Phuong Nguyen <phuong_nguyen@sigmadesigns.com>, David Daney <david.daney@cavium.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Will Deacon <will.deacon@arm.com>,
	Thierry Reding <treding@nvidia.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 4 March 2017 at 13:07, Mason <slash.tmp@free.fr> wrote:
> On 04/03/2017 12:45, Ard Biesheuvel wrote:
>> On 4 March 2017 at 10:56, Mason <slash.tmp@free.fr> wrote:
[...]
>>> In my 32-bit system, there are 2GB of RAM at [0x8000_0000,0x10000_0000[
>>> There are MMIO registers at [0, 16MB[ and also other stuff higher
>>> Suppose there is nothing mapped at [0x7000_0000, 0x8000_0000[
>>>
>>> Can I provide that range to the PCI subsystem?
>>
>> Well, it obviously needs to be a range that is not otherwise occupied.
>> But it is SoC specific where the forwarded MEM region(s) are, and
>> whether they are configurable or not.
>
> My problem is that I don't understand bus addresses vs physical addresses.
> (where and when they are used, and how.) Devices themselves put bus
> addresses in messages in the PCIe protocol, I assume? When does it matter
> what physical address maps to a bus address? When and where does this
> mapping take place? (In the RC HW, in the RC driver, elsewhere?)
>

This is mostly for DMA: there is no 'mapping' that takes place, it
simply means that the CPU physical address may deviate from the
address used by a PCI bus master to refer to the same location.

For instance, there are arm64 SoCs that map the physical RAM way above
the 4 GB limit. In this case, it may make sense to program the PCI
host controller in such a way that it applies an offset so that at
least the first 4 GB of RAM are 32-bit addressable by PCI devices
(which may not be capable of 64-bit addressing).

The implication is that, the memory address used when programming a
PCI device to perform bus master DMA is different from the physical
address used by the host.

> I suppose some devices do actually need access to *real* *actual* memory
> for stuff like DMA. I suppose they must use system memory for that.
> Does the generic PCI(e) framework setup this memory?
>

You don't need to 'set up' this memory in the general case, although
this is different in the presence of IOMMUs, but let's disregard that
for now.

>> IOW, you can ask *us* all you
>> want about these details, but only the H/W designer can answer this
>> for you.
> befor
> My biggest problem is that, in order to get useful answers, one must
> ask specific questions. And my understanding of PCI is still too
> limited to ask good questions.
>
> My current understanding is that I must find a large area in the memory
> map where there is NOTHING (no RAM, no registers). Then I can specify
> this area in the "ranges" prop of my DT node, to be used as a
> non-prefetchable memory address range.
>

'Finding' a memory area suggests that you could pick a range at random
and put that in the DT. This is *not* the case.

The PCIe controller hardware needs to know that it needs to decode
that range, i.e., it needs to forward memory accesses that hit this
window. You need to figure out how this is configured on the h/w that
you are using.

>> The DT node that describes the host bridge should simply describe
>> which MMIO regions are used by the device. This is no different from
>> any other MMO peripheral.
>
> In my limited experience, the DT node for PCI is, by far, the most
> complex node I've had to write.
>

Yes, but that is not the point. My point is that the information you
put in the DT should reflect *reailty* in one way or the other. Every
value you put there should match the current configuration of the h/w
IP block.

>> As for the bus ranges: this also depends on the h/w, as far as i know,
>> and has a direct relation with the size of the PCI configuration space
>> (1 MB per bus for ECAM iirc?) On 32-bit systems, supporting that many
>> buses may be costly in terms of 32-bit addressable space, given that
>> the PCIe config space is typically below 4 GB. But it all depends on
>> the h/w implementation.
>
> That I know. The HW designer has confirmed reserving 256 MB of address
> space for the configuration space. In hind-sight, this was probably a
> waste of address space. Supporting 4 buses seems amply sufficient.
> Am I wrong?
>

PCIe puts every device on its own bus, so it is good to have some headroom imo

> I suppose wasting 256 MB of address space is not an issue on 64-bit
> systems, though.
>

Hardly
