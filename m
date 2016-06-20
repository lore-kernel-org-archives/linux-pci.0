Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34638 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbcFTSrc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jun 2016 14:47:32 -0400
Date: Mon, 20 Jun 2016 13:45:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: bhelgaas@google.com, jespern@axis.com, akpm@linux-foundation.org,
	davem@davemloft.net, gregkh@linuxfoundation.org,
	mchehab@osg.samsung.com, linux@roeck-us.net, jslaby@suse.cz,
	robh@kernel.org, marc.zyngier@arm.com, rjui@broadcom.com,
	arnd@arndb.de, david.daney@cavium.com, geert+renesas@glider.be,
	lftan@altera.com, bharat.kumar.gogada@xilinx.com, hauke@hauke-m.de,
	thomas.petazzoni@free-electrons.com, simon.horman@netronome.com,
	phil.edworthy@renesas.com, svarbanov@mm-sol.com, dhdang@apm.com,
	wangzhou1@hisilicon.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Subject: Re: [PATCH v2 2/2] pci: host: new driver for Axis ARTPEC-6 PCIe
 controller
Message-ID: <20160620184505.GB31564@localhost>
References: <1462794543-30317-1-git-send-email-niklass@axis.com>
 <20160609224125.GB19309@localhost>
 <575EB12D.1040206@axis.com>
 <20160613133357.GA12221@localhost>
 <57673F5A.7020805@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57673F5A.7020805@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 20, 2016 at 02:56:58AM +0200, Niklas Cassel wrote:
> 
> On 06/13/2016 03:33 PM, Bjorn Helgaas wrote:
> > On Mon, Jun 13, 2016 at 03:12:13PM +0200, Niklas Cassel wrote:
> >> On 06/10/2016 12:41 AM, Bjorn Helgaas wrote:
> >>> On Mon, May 09, 2016 at 01:49:03PM +0200, Niklas Cassel wrote:
> >>>> From: Niklas Cassel <niklas.cassel@axis.com>
> >>>>
> >>>> The Axis ARTPEC-6 SoC integrates a PCIe controller from Synopsys.
> >>>> This commit adds a new driver that provides the small glue
> >>>> needed to use the existing Designware driver to make it work on
> >>>> the Axis ARTPEC-6 SoC.
> >>>>
> >>>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> >>> Hi Niklas,
> >>>
> >>> I'll review this soon.  In the meantime, can you send /proc/iomem and
> >>> /proc/ioport contents?  I'm looking to avoid problems like this:
> >>> http://lkml.kernel.org/r/20160606230537.20936.2892.stgit@bhelgaas-glaptop2.roam.corp.google.com
> >>>
> >>> It looks like this is based on DesignWare, so it probably has the
> >>> problem, and will probably be fixed by these:
> >>>
> >>> http://lkml.kernel.org/r/20160606230452.20936.28937.stgit@bhelgaas-glaptop2.roam.corp.google.com
> >>> http://lkml.kernel.org/r/20160606230501.20936.71818.stgit@bhelgaas-glaptop2.roam.corp.google.com
> >>> http://lkml.kernel.org/r/20160606230508.20936.81845.stgit@bhelgaas-glaptop2.roam.corp.google.com
> >>>
> >>> If you wanted to apply those and then send /proc/iomem and
> >>> /proc/ioports, that would be even better.
> >>>
> >>> Bjorn
> >>>
> >> Output with your patches applied:
> > Great, thanks, Niklas!  Comments below:
> >
> >> [    2.107320] PCI host bridge /pcie@f8050000 ranges:
> >> [    2.112138]   No bus range found for /pcie@f8050000, using [bus 00-ff]
> > Your DT *should* provide a bus number range.  There is no way for the
> > PCI core to correctly determine the range.
> Ok, I will update the DT example to include bus-range.
> 
> >
> >> [    2.118684]    IO 0xc0010000..0xc001ffff -> 0x00010000
> >> [    2.123835]   MEM 0xc0020000..0xdfffffff -> 0xc0020000
> >> [    2.245559] artpec6-pcie f8050000.pcie: link up
> >> [    2.250228] artpec6-pcie f8050000.pcie: PCI host bridge to bus 0000:00
> >> [    2.256773] pci_bus 0000:00: root bus resource [bus 00-ff]
> >> [    2.262273] pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address [0x10000-0x1ffff])
> > This looks questionable.  This says we're using I/O ports
> > 0x10000-0x1ffff on the PCI bus.  That's legal, but unusual.
> >
> > The conventional PCI spec allowed the upper 16 bits of I/O BARs
> > to be hard-wired to zero "for devices intended for 16-bit I/O
> > systems, such as PC compatibles."
> >
> > I don't know whether a PCIe device with an I/O BAR with the
> > upper bits hard-wired to zero exists.  The conservative approach
> > would be to use ports 0x0000-0xffff on PCI.
> Thank you for the detailed explanation.
> We simply chose a value during testing,
> there wasn't any deeper thought behind it.
> Since other DesignWare drivers seem to use 0x0, lets stick to that.
> 
> I'm currently on parental leave, but I'm back on work next week.

Congratulations!

> I will try the new settings and send out a patch that updates the DT example.
> 
> Hopefully there's no hurry, since both changes are in the DT example.

Nope, no hurry.  I'll be on vacation for a while myself.

Bjorn
