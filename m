Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 Jun 2016 09:58:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>, bhelgaas@google.com,
	niklass@axis.com, jespern@axis.com,
	Andrew Morton <akpm@linux-foundation.org>,
	David Miller <davem@davemloft.net>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	mchehab@osg.samsung.com, linux@roeck-us.net, jslaby@suse.cz,
	robh@kernel.org, marc.zyngier@arm.com, rjui@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>, geert+renesas@glider.be,
	lftan@altera.com, bharat.kumar.gogada@xilinx.com, hauke@hauke-m.de,
	thomas.petazzoni@free-electrons.com, simon.horman@netronome.com,
	phil.edworthy@renesas.com, svarbanov@mm-sol.com, dhdang@apm.com,
	wangzhou1@hisilicon.com, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Subject: Re: [PATCH v2 2/2] pci: host: new driver for Axis ARTPEC-6 PCIe
 controller
Message-ID: <20160621145819.GA31917@localhost>
References: <1462794543-30317-1-git-send-email-niklass@axis.com>
 <CAP=VYLo00R4iv+9_=x2BjjurEfArJzY46Zc=doEtav=BwNhPzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAP=VYLo00R4iv+9_=x2BjjurEfArJzY46Zc=doEtav=BwNhPzg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 20, 2016 at 03:50:07PM -0400, Paul Gortmaker wrote:
> On Mon, May 9, 2016 at 7:49 AM, Niklas Cassel <niklas.cassel@axis.com> wrote:
> > From: Niklas Cassel <niklas.cassel@axis.com>
> >
> > The Axis ARTPEC-6 SoC integrates a PCIe controller from Synopsys.
> > This commit adds a new driver that provides the small glue
> > needed to use the existing Designware driver to make it work on
> > the Axis ARTPEC-6 SoC.
> >
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> 
> [...]
> 
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -244,4 +244,10 @@ config PCIE_ARMADA_8K
> >           Designware hardware and therefore the driver re-uses the
> >           Designware core functions to implement the driver.
> >
> > +config PCIE_ARTPEC6
> > +       bool "Axis ARTPEC-6 PCIe controller"
> 
> Bjorn,
> 
> Can we please start requiring new PCI/PCI-e drivers to either:
> 
>   (a)  be merged and tested as tristate, or
> 
>   (b)  remain bool, but not gratuitously use module macros

That requires somebody to enforce it, which I suppose would end up
being me, and that's not really practical unless you help out by
watching for them.  I know that's not really practical for you either.

I hoped that we could convert them to be modular, but that hasn't
started happening, so I think we need to fall back to your original
proposal of making them bool and removing the modular junk.
Eventually people who feel the pain of building in all the drivers
might step up and make them modular.

Do you want to update your series that removed the gratuitous module
code?  I'll be on vacation June 25-July 17, but maybe we can still
squeeze it in this cycle.

Bjorn
