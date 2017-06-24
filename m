Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 24 Jun 2017 14:32:26 -0700 (PDT)
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
Subject: Re: [PATCH 2/3] pci: Add a generic, weakly-linked pcibios_align_resource
In-Reply-To: <CAMuHMdWrn4C5nwRSrA8i_8sFtpRbuQH9vtNWjq5rM5_Si15kbw@mail.gmail.com>
Message-ID: <mhng-e09a5c16-4f2f-4360-8a86-8ae90cfcb356@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 24 Jun 2017 02:41:42 PDT (-0700), geert@linux-m68k.org wrote:
> Hi Palmer,
>
> On Sat, Jun 24, 2017 at 3:50 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> Multiple architectures define this as trivial function, and I'm adding
>> another one as part of the RISC-V port.  This adds a __weak version of
>> pcibios_align_resource and deletes the now obselete ones in a handful of
>> ports.
>>
>> The only functional change should be that a handful of ports used to
>> export pcibios_fixup_bus.  Only some architectures export this, so I
>> just dropped it.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>
> This function is only ever used as a pointer passed to
> pci_bus_alloc_resource()?
>
> What about having
>
>     #ifndef pcibios_fixup_bus
>     #define pcibios_fixup_bus NULL
>     #endif
>
> in asm-generic/pci.h, letting the architecture with a non-trivial
> implementation predefine the preprocessor symbol, and teaching
> pci_bus_alloc_resource() to handle NULL?
>
> [...]
>
> Oh, the latter eventually calls into allocate_resource(), which already falls
> back to simple_align_resource() if the alignment function is NULL, which
> does the same thing.
> So NULL should already work.

I'm OK with that, but like your comments on the last one I think it might fit
better as a __weak function.  I think there were also some questions as to
whether these should actually be empty functions or not.  I'm really happy with
either way.

Since this is all out of my wheelhouse, can one of the PCI maintainers chime in
as to what I should do here?
