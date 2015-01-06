Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Rob Herring <robh@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] pci: introduce common pci config space accessors
Date: Tue, 06 Jan 2015 21:39:49 +0100
Message-ID: <29617227.2s0RYsxxN0@wuerfel>
In-Reply-To: <CAL_JsqLOJSjE6MUgFe8Biz+MhdGUiZD+kAOWYTvnF1G5saa2wA@mail.gmail.com>
References: <1420424374-32412-1-git-send-email-robh@kernel.org> <1758416.ZHsvLP471N@wuerfel> <CAL_JsqLOJSjE6MUgFe8Biz+MhdGUiZD+kAOWYTvnF1G5saa2wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 05 January 2015 16:28:48 Rob Herring wrote:
> On Mon, Jan 5, 2015 at 2:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 05 January 2015 08:46:09 Rob Herring wrote:
> >> Right, this is what I had in mind for CAM/ECAM. I didn't go this far
> >> because a lot of the map_bus functions do various checks to prevent
> >> certain accesses. Of what I've found, I think only generic host and
> >> Xilinx drivers could be converted to a generic ECAM map_bus. Others
> >> check bus number and/or device number or link-up status or have a
> >> fixup for certain registers, for example. I'm not sure how much of it
> >> is unnecessary or could be common.
> >
> > How do you want to deal with the overrides? I don't see a way to
> > do that in map_bus (with the current definition) if the idea is that
> > for certain registers we return hardcoded values instead of accessing
> > mmio registers.
> 
> It is not done in map_bus unless you want all FFs by returning NULL,
> but by simply by wrapping the generic call with a host specific read
> or write function. Here's one example that modifies one field in a
> register. This means you can do any pre or post processing you need.
> Even the crazy stuff Integrator PCI does.
> 
> static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
>                                    int where, int size, u32 *val)
> {
>         u32 mask = (0x1ull << (size * 8)) - 1;
>         int shift = (where % 4) * 8;
> 
>         ret = pci_generic_config_read32(bus, devfn, where, size, val);
> 
>         if (ret == PCIBIOS_SUCCESSFUL && bus->number == 0 && devfn == 0 &&
>             (where & 0xffc) == PCI_CLASS_REVISION)
>                 /*
>                  * RC's class is 0xb, but Linux PCI driver needs 0x604
>                  * for a PCIe bridge. So we must fixup the class code
>                  * to 0x604 here.
>                  */
>                 *val = ((*val << shift) & 0xff) | (0x604 << 16)) >>
> shift) & mask;
> 
>         return ret;
> }

Ah, I see. Yes this should work fine. 

I had no idea about the Integrator craziness. Does that actually work? ;-)
If I were to write a driver for this hardware, I'd probably give up and
either not support prefetchable memory space, or not support PIO.

	Arnd
