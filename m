Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 8 Jun 2017 01:12:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        albert@sifive.com, patches@groups.riscv.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 06/17] pci: Add generic pcibios_{fixup_bus,align_resource}
Message-ID: <20170608081228.GA26932@infradead.org>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-7-palmer@dabbelt.com>
 <CAMuHMdUiuqB3vPYkAJfP5+qotcH=o1gJnH8Mosr9VSKxAQGJMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdUiuqB3vPYkAJfP5+qotcH=o1gJnH8Mosr9VSKxAQGJMQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 07, 2017 at 09:19:49AM +0200, Geert Uytterhoeven wrote:
> CC pci folks

Ok, replying with pci folks in Cc then :)

Weak symbols have (rightly) gotten a bad reputation, so maybe
we should approach this without them.

It seems we have a large number of emptry pcibios_fixup_bus calls
alreayd, so I think we should simply have the architectures
that do define it define a Kconfig or header symbol and not call
it at all otherwise.

For the ones that exist as lot just seem to call pci_read_bridge_bases
and/or pcibios_fixup_device_resources in one form or another,
and I wonder why we even need the arch indirection for that.

Similarly for pcibios_align_resource: a lot of architetures seem
to have a noop, and the once that don't mostly seem copy and
paste code, so we should again have a symbol for architectures
to opt into it, and we probably should have a generic helper
for the VGA window mirroring code instead of duplicating it multiple
times.
