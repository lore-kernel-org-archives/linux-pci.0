Return-Path: <linux-arch-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] nios2: Add architectural support for PCIe
Date: Tue, 29 Sep 2015 09:37:09 +0200
Message-ID: <3218771.zBxT0jYLDs@wuerfel>
In-Reply-To: <CAFiDJ5_jkEqdAY=TtKOg6=GzT8i4qAFdnSH_z1RsoPVU2Vfr1Q@mail.gmail.com>
References: <1442906367-10935-1-git-send-email-lftan@altera.com> <5408024.XroFc5QNep@wuerfel> <CAFiDJ5_jkEqdAY=TtKOg6=GzT8i4qAFdnSH_z1RsoPVU2Vfr1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 29 September 2015 11:12:24 Ley Foon Tan wrote:
> >
> > I think that would be good, yes. We probably picked defaults for the
> > asm-generic version that are enough to build with CONFIG_PCI disabled,
> > but there are useful defaults for the other case as well.
> >
> > Most architectures that use the file don't support PCI, so you can just
> > add stuff inside of #ifdef CONFIG_PCI. For the remaining 13 architectures
> > (git grep -l generic/pci.h  | wc), see whether there are conflicts first.
> > The normal way would be to have the arch specific definition come before
> > the #include, and then do something like
> >
> > #ifndef pci_proc_domain
> > #define pci_proc_domain pci_proc_domain
> > static inline int pci_proc_domain(struct pci_bus *bus)
> > {
> > #ifdef CONFIG_PCI_DOMAINS_GENERIC
> >         return pci_domain_nr(bus);
> > #else
> >         return 1;
> > }
> > #endif
> 
> Okay, will try add them to asm-generic.

Thanks

> Do you prefer to send it as separate patch or can be part of this patchset?

I prefer the patches to be part of this series and merged through together
with them.

	Arnd
