Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36796 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbbLIKYX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2015 05:24:23 -0500
Date: Wed, 9 Dec 2015 10:23:59 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v4 1/5] PCI: designware: add memory barrier after
 enabling region
Message-ID: <20151209102359.GF8644@n2100.arm.linux.org.uk>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
 <1449149725-27607-2-git-send-email-stanimir.varbanov@linaro.org>
 <56669C50.9060700@linaro.org>
 <CAHM4w1k_EAt+xBBYyG3B7W9Fegc4j+uRq5t_biUsxOGt+k+xUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHM4w1k_EAt+xBBYyG3B7W9Fegc4j+uRq5t_biUsxOGt+k+xUA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 09, 2015 at 10:10:05AM +0530, Pratyush Anand wrote:
> On Tue, Dec 8, 2015 at 2:31 PM, Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
> >
> > On 12/03/2015 03:35 PM, Stanimir Varbanov wrote:
> > > Add 'write memory' barrier after enable region in PCIE_ATU_CR2
> > > register. The barrier is needed to ensure that the region enable
> > > request has been reached it's destination at time when we
> > > read/write to PCI configuration space.
> > >
> > > Without this barrier PCI device enumeration during kernel boot
> > > is not reliable, and reading configuration space for particular
> > > PCI device on the bus returns zero aka no device.
> >
> > Anand, Jingoo, what is your opinion?
> >
> > >
> > > Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> > > ---
> > >  drivers/pci/host/pcie-designware.c |    5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > > index 02a7452bdf23..ed4dc2e2553b 100644
> > > --- a/drivers/pci/host/pcie-designware.c
> > > +++ b/drivers/pci/host/pcie-designware.c
> > > @@ -164,6 +164,11 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
> > >       dw_pcie_writel_rc(pp, upper_32_bits(pci_addr), PCIE_ATU_UPPER_TARGET);
> > >       dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
> > >       dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
> > > +     /*
> > > +      * ensure that the ATU enable has been happaned before accessing
> > > +      * pci configuration/io spaces through dw_pcie_cfg_[read|write].
> > > +      */
> > > +     wmb();
> > >  }
> > >
> 
> 
> My understnading is that since writel() of dw_pcie_writel_rc() in
> above code and readl(), writel() of dw_pcie_cfg_[read|write]() (which
> will follow) goes through same device (ie PCIe host here). So, it is
> guaranteed that 1st writel() will be executed before later
> readl()/writel(). If that is true then we do not need any explicit
> barrier here.
> 
> Arnd, Russel: whats your opinion here.
              ^l

writel() has a barrier _before_ the access but not after.

The fact is that there's nothing which guarantees that the write will hit
the hardware in a timely manner (forget any rules about PCI config space,
the PCI ordering rules apply to the PCI bus, not to the ARM buses.)

If you need this write to have hit the hardware before continuing, you
need to read back from the same register.

I'm just looking at this driver, trying to decipher what it's doing.  It
_looks_ to me like it's reprogramming one of the outbound windows (IO?)
so that configuration space can be accessed.  Doesn't this have the
effect of disabling access to the IO segment of the PCI bus from the
host CPU?

What protections are there against other CPUs in the system issuing a
PCI I/O read/write while this outbound window is programmed as
configuration space?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
