Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 07/16] ARM: integrator: convert PCI to use generic config accesses
Date: Sat, 10 Jan 2015 22:53:06 +0100
Message-ID: <4938579.0KIk3QtTCP@wuerfel>
In-Reply-To: <CACRpkdbwKN9LenqrWeu4WykhdZOGAdxpC_BYr2cYpc2_cn5GfA@mail.gmail.com>
References: <1420857290-8373-1-git-send-email-robh@kernel.org> <1420857290-8373-8-git-send-email-robh@kernel.org> <CACRpkdbwKN9LenqrWeu4WykhdZOGAdxpC_BYr2cYpc2_cn5GfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday 10 January 2015 22:40:22 Linus Walleij wrote:
> >  static int v3_read_config(struct pci_bus *bus, unsigned int devfn, int where,
> >                           int size, u32 *val)
> >  {
> > -       addr = v3_open_config_window(bus, devfn, where);
> > +       int ret = pci_generic_config_read(bus, devfn, where, size, val);
> >         v3_close_config_window();
> > +       return ret;
> >  }
> >
> >  static int v3_write_config(struct pci_bus *bus, unsigned int devfn, int where,
> >                            int size, u32 val)
> >  {
> > +       int ret = pci_generic_config_write(bus, devfn, where, size, val);
> >         v3_close_config_window();
> > -       raw_spin_unlock_irqrestore(&v3_lock, flags);
> > +       return ret;
> >  }
> >
> >  static struct pci_ops pci_v3_ops = {
> > +       .map_bus = v3_open_config_window,
> >         .read   = v3_read_config,
> >         .write  = v3_write_config,
> 
> So .map_bus is called before every .read/.write operation I take it.
> 
> Wouldn't it be proper to call the v3_close_config_window() from a
> matching .unmap_bus() callback for symmetry?

It would be nicer for integrator but useless for anything else, so
I'd vote for leaving it the way Rob posted.

	Arnd
