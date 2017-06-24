Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 24 Jun 2017 14:32:25 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
To: geert@linux-m68k.org
CC: linux-pci@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: bhelgaas@google.com
CC: hch@infradead.org
CC: Arnd Bergmann <arnd@arndb.de>
CC: linux-snps-arc@lists.infradead.org
CC: linux-cris-kernel@axis.com
CC: linux-ia64@vger.kernel.org
CC: linux-s390@vger.kernel.org
CC: linux-sh@vger.kernel.org
CC: sparclinux@vger.kernel.org
Subject: Re: [PATCH 1/3] pci: Add a generic, weakly-linked pcibios_fixup_bus
In-Reply-To: <CAMuHMdWd_4GzySTWsb5PupBw3UkLUKAwE-OvAgHScZutT-wiNQ@mail.gmail.com>
Message-ID: <mhng-256cddee-f6a7-4386-a6e7-792d3e9ae6bf@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 24 Jun 2017 02:34:06 PDT (-0700), geert@linux-m68k.org wrote:
> Hi Palmer,
>
> On Sat, Jun 24, 2017 at 3:50 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> Multiple architectures define this as an empty function, and I'm adding
>> another one as part of the RISC-V port.  This adds a __weak version of
>> pci_fixup_bios and deletes the now obselete ones in a handful of ports.
>>
>> The only functional change should be that microblaze used to export
>> pcibios_fixup_bus.  None of the other architectures export this, so I
>> just dropped it.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>
> Given this is an empty function, wouldn't it make more sense to have
> a static inline in asm-generic, protected by #ifndef pcibios_fixup_bus?

I think the PCI people were considering changing this from a per-arch function
to a per-controller function, so I think the inline won't help any there.  I
think since they hope to eventually clean up all the __weak functions it fits a
bit better this way, but I'm really fine with anything here.
