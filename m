Return-Path: <SRS0=dwSL=6Q=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=dwSL=6Q=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH 0/2] Workaround for uPD72020x USB3 chips
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <20170710155230.8622-1-marc.zyngier@arm.com>
 <20170713031234.GD4486@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu9VcJU2TBQ0AzMT1yHGRQYagRU1MhPmBKJ89HntOxnW9A@mail.gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-usb <linux-usb@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <544d9c48-9d4f-29f7-1478-afa940b20dd8@arm.com>
Date: Thu, 13 Jul 2017 08:46:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9VcJU2TBQ0AzMT1yHGRQYagRU1MhPmBKJ89HntOxnW9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 13/07/17 07:48, Ard Biesheuvel wrote:
> On 13 July 2017 at 04:12, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Mon, Jul 10, 2017 at 04:52:28PM +0100, Marc Zyngier wrote:
>>> Ard and myself have just spent quite some time lately trying to pin
>>> down an issue in the DMA code which was taking the form of a PCIe USB3
>>> controller issuing a DMA access at some bizarre address, and being
>>> caught red-handed by the IOMMU.
>>>
>>> After much head scratching and most of a week-end spent on tracing the
>>> damn thing, I'm now convinced that the DMA code is fine, the XHCI
>>> driver is correct, but that the HW (a Renesas uPD720202 chip) is a
>>> nasty piece of work.
>>>
>>> The issue is as follow:
>>>
>>> - EFI initializes the controller using physical addresses above the
>>>   4GB limit (this is on an arm64 box where the memory starts at
>>>   0x80_00000000...).
>>>
>>> - The kernel takes over, sends a XHCI reset to the controller, and
>>>   because we have an IOMMU sitting between the controller and memory,
>>>   provides *virtual* addresses. Trying to make things a bit faster for
>>>   our controller, it issues IOVAs in the low 4GB range).
>>>
>>> - Low and behold, the controller is now issuing transactions with a
>>>   0x80 prefix in front of our IOVA. Yes, the same prefix that was
>>>   programmed during the EFI configuration. IOMMU fault, not happy.
>>>
>>> If the kernel is hacked to only generate IOVAs that are more than
>>> 32bit wide, the HW behaves correctly. The only way I can explain this
>>> behaviour is that the HW latches the top 32bit of the ERST (it is
>>> always the ERST IOVA that appears in my traces) in some internal
>>> register, and that the XHCI reset fails to clear it. Writing zero in
>>> the top bits is not enough to clear it either.
>>>
>>> So far, the only solution we have for this lovely piece of kit is to
>>> force a PCI reset at probe time, which puts it right. The patches are
>>> pretty ugly, but that's the best I could come up with so far.
>>>
>>> Tested on a pair of AMD Opteron 1100 boxes with Renesas uPD720201 and
>>> uPD720202 controllers.
>>>
>>> Marc Zyngier (2):
>>>   PCI: Implement pci_reset_function_locked
>>>   usb: host: pci_quirks: Force hard reset of Renesas uPD72020x USB
>>>     controller
>>>
>>>  drivers/pci/pci.c             | 35 +++++++++++++++++++++++++++++++++++
>>>  drivers/usb/host/pci-quirks.c | 20 ++++++++++++++++++++
>>>  drivers/usb/host/pci-quirks.h |  1 +
>>>  drivers/usb/host/xhci-pci.c   |  7 +++++++
>>>  include/linux/pci.h           |  1 +
>>>  5 files changed, 64 insertions(+)
>>
>> I provisionally applied this to pci/virtualization.  I'd like to have an
>> XHCI ack before going further, though.
>>
>> I assume this only affects boxes where the firmware uses addresses above
>> 4GB, i.e., not very many?  So this is v4.14 material?  Or do you think it's
>> important for v4.13?
>>
> 
> As I mentioned, it would be nice if this could at least go into v4.11
> and later, given that v4.11 contains a patch that switches all PCI
> devices to 32-bit addressing only when the IOMMU is involved in DMA,
> and this is what triggered the issue on arm64 boards with such a PCI
> card and no DRAM below 4 GB.

Agreed. It is likely that the issue will trigger on any 64bit->32bit
IOVA transition, not only EFI->kernel, such as a kexec from a 4.10 to a
4.11 kernel.

More importantly, this could have a dramatic effect on a system where
both the 32bit and 64bit address ranges are valid. In my case, I was
saved by the IOMMU blocking the DMA access, but imagine for a second the
device was using PAs... I'm not sure that this is completely
hypothetical, nor arm64 specific.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
