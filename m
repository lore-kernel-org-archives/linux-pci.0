Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46954 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbbJIXPo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Oct 2015 19:15:44 -0400
Date: Fri, 9 Oct 2015 18:15:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 3/6] pci:host: Add Altera PCIe host controller driver
Message-ID: <20151009231540.GE16112@localhost>
References: <1444297394-3122-1-git-send-email-lftan@altera.com>
 <1444297394-3122-4-git-send-email-lftan@altera.com>
 <20151008094744.GD32532@n2100.arm.linux.org.uk>
 <CAFiDJ58oMa6rgQe_STCiWRpdL+P22BN1=Nin_+QnLXC9RGiSzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFiDJ58oMa6rgQe_STCiWRpdL+P22BN1=Nin_+QnLXC9RGiSzQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 08, 2015 at 06:03:24PM +0800, Ley Foon Tan wrote:
> On Thu, Oct 8, 2015 at 5:47 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >
> > On Thu, Oct 08, 2015 at 05:43:11PM +0800, Ley Foon Tan wrote:
> > > +static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
> > > +                              int where, int size, u32 value)
> > > +{
> > > +     struct altera_pcie *pcie = bus->sysdata;
> > > +     u32 data32;
> > > +     u32 shift = 8 * (where & 3);
> > > +     int ret;
> > > +
> > > +     if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
> > > +             return PCIBIOS_DEVICE_NOT_FOUND;
> > > +
> > > +     /* write partial */
> > > +     if (size != sizeof(u32)) {
> > > +             ret = tlp_cfg_dword_read(pcie, bus->number, devfn,
> > > +                                      where & ~DWORD_MASK, &data32);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     switch (size) {
> > > +     case 1:
> > > +             data32 = (data32 & ~(0xff << shift)) |
> > > +                             ((value & 0xff) << shift);
> > > +             break;
> > > +     case 2:
> > > +             data32 = (data32 & ~(0xffff << shift)) |
> > > +                             ((value & 0xffff) << shift);
> > > +             break;
> > > +     default:
> > > +             data32 = value;
> >
> > Can you generate proper 1, 2 and 4 byte configuration accesses?  That
> > is much preferred over the above read-modify-write, as there are
> > registers in PCI and PCIe that are read/write-1-to-clear.  The above
> > has the effect of inadvertently clearing those RW1C bits.
> No, hardware can only access 4-byte aligned address.

This is non-spec compliant, and we really should have some way of
flagging that because it may break things in ways that would be very
difficult to debug, e.g., we can lose RW1C status bits when writing an
adjacent register, so they would just silently disappear.

I don't know if this should be a kernel taint, a simple warning in
dmesg, or what.  I guess the tainting mechanism is probably too
general-purpose for this, and add_taint() doesn't give any dmesg
indication.  We wouldn't see the taint unless the problem actually
caused an oops or panic.  In this case, I think I want a clue in dmesg
so we have a chance of seeing it even if there is no oops.  So
probably something like a dev_warn("non-compliant config accesses")
would work.

You really should double-check with the hardware guys, because it's
pretty obvious that the PCI spec requires 1- and 2-byte config
accesses to work correctly.  For example, if you read/modify/write to
update PCI_COMMAND, you will inadvertently clear the RW1C bits in
PCI_STATUS.

Bjorn
