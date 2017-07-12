Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:38733 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbdGLTEj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2017 15:04:39 -0400
Received: by mail-it0-f44.google.com with SMTP id k192so21267724ith.1
        for <linux-pci@vger.kernel.org>; Wed, 12 Jul 2017 12:04:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_7TCjN=LPdsG+QBwYqRD7fMuOPeH2qBDL7gvsB6tP0wA@mail.gmail.com>
References: <20170710155230.8622-1-marc.zyngier@arm.com> <CAKv+Gu_7TCjN=LPdsG+QBwYqRD7fMuOPeH2qBDL7gvsB6tP0wA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 12 Jul 2017 20:04:38 +0100
Message-ID: <CAKv+Gu8D-t9KqP8CWJpBBEvMLV1EJst=a_xmwPQSRO36677rsA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Workaround for uPD72020x USB3 chips
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10 July 2017 at 18:21, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 10 July 2017 at 16:52, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Ard and myself have just spent quite some time lately trying to pin
>> down an issue in the DMA code which was taking the form of a PCIe USB3
>> controller issuing a DMA access at some bizarre address, and being
>> caught red-handed by the IOMMU.
>>
>> After much head scratching and most of a week-end spent on tracing the
>> damn thing, I'm now convinced that the DMA code is fine, the XHCI
>> driver is correct, but that the HW (a Renesas uPD720202 chip) is a
>> nasty piece of work.
>>
>> The issue is as follow:
>>
>> - EFI initializes the controller using physical addresses above the
>>   4GB limit (this is on an arm64 box where the memory starts at
>>   0x80_00000000...).
>>
>> - The kernel takes over, sends a XHCI reset to the controller, and
>>   because we have an IOMMU sitting between the controller and memory,
>>   provides *virtual* addresses. Trying to make things a bit faster for
>>   our controller, it issues IOVAs in the low 4GB range).
>>
>> - Low and behold, the controller is now issuing transactions with a
>>   0x80 prefix in front of our IOVA. Yes, the same prefix that was
>>   programmed during the EFI configuration. IOMMU fault, not happy.
>>
>> If the kernel is hacked to only generate IOVAs that are more than
>> 32bit wide, the HW behaves correctly. The only way I can explain this
>> behaviour is that the HW latches the top 32bit of the ERST (it is
>> always the ERST IOVA that appears in my traces) in some internal
>> register, and that the XHCI reset fails to clear it. Writing zero in
>> the top bits is not enough to clear it either.
>>
>
> To clarify, this seems to be an issue in the internal DMA logic of the
> controller. The ESRT base address register *is* cleared by the XHCI
> reset, i.e., it reads back as all zeroes. However, any 32-bit value we
> write there is extended with the high word written by the UEFI in the
> actual DMA transactions that take place.
>
>> So far, the only solution we have for this lovely piece of kit is to
>> force a PCI reset at probe time, which puts it right. The patches are
>> pretty ugly, but that's the best I could come up with so far.
>>
>> Tested on a pair of AMD Opteron 1100 boxes with Renesas uPD720201 and
>> uPD720202 controllers.
>>
>> Marc Zyngier (2):
>>   PCI: Implement pci_reset_function_locked
>>   usb: host: pci_quirks: Force hard reset of Renesas uPD72020x USB
>>     controller
>>

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
