Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170608081228.GA26932@infradead.org>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-7-palmer@dabbelt.com> <CAMuHMdUiuqB3vPYkAJfP5+qotcH=o1gJnH8Mosr9VSKxAQGJMQ@mail.gmail.com>
 <20170608081228.GA26932@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 Jun 2017 10:35:29 +0200
Message-ID: <CAK8P3a1Q=LoAPU_6X_z1=4Yp-Q=TCYpVz3R2MOv_UikX-tPDQg@mail.gmail.com>
Subject: Re: [PATCH 06/17] pci: Add generic pcibios_{fixup_bus,align_resource}
To: Christoph Hellwig <hch@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, albert@sifive.com,
        patches@groups.riscv.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 8, 2017 at 10:12 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Jun 07, 2017 at 09:19:49AM +0200, Geert Uytterhoeven wrote:
>> CC pci folks
>
> Ok, replying with pci folks in Cc then :)
>
> Weak symbols have (rightly) gotten a bad reputation, so maybe
> we should approach this without them.

Agreed, I would almost never recommend using a __weak symbol,
but they are already widely used in the PCI subsystem, so I suggested
using them here for consistency.

We have a struct pci_host_bridge now, and we should eventually
move most of the 38 pci specific weak  per-architecture symbols
into per-host driver callbacks, but that I think that would be too much
to ask for when adding an architecture port.

> It seems we have a large number of emptry pcibios_fixup_bus calls
> alreayd, so I think we should simply have the architectures
> that do define it define a Kconfig or header symbol and not call
> it at all otherwise.

I would argue that most of them should not be per-architecture
in the first place, the current state is mostly an artifact of the
times when each architecture had just one PCI implementation.

The ones that have multiple implementations (arm, powerpc, ...)
tend to actually override the weak functions with their own
per-host multiplexers again.

> For the ones that exist as lot just seem to call pci_read_bridge_bases
> and/or pcibios_fixup_device_resources in one form or another,
> and I wonder why we even need the arch indirection for that.
>
> Similarly for pcibios_align_resource: a lot of architetures seem
> to have a noop, and the once that don't mostly seem copy and
> paste code, so we should again have a symbol for architectures
> to opt into it, and we probably should have a generic helper
> for the VGA window mirroring code instead of duplicating it multiple
> times.

I now remember that we already have a host_bridge->align_resource
callback pointer, so the generic function should definitely try
to use that.

We could just use the version from arch/mips/pci/pci-generic.c
and remove that in the process. I'm not sure about why mips calls
pci_read_bridge_bases() in pcibios_fixup_bus() though, or whether
this make sense to put in the generic version.

       Arnd
