Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 3 Oct 2015 14:10:37 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ley Foon Tan <lftan@altera.com>, Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"Kumar Gala" <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 5/6] Documentation: dt-bindings: pci: altera pcie
 device tree binding
Message-ID: <20151003141037.140fcbc3@arm.com>
In-Reply-To: <6497772.rqSurELzER@wuerfel>
References: <1442801587-3812-1-git-send-email-lftan@altera.com>
	<CAL_JsqL9eoTRa2-eeNJgVoO=0LyuaaJ87E4_BS0KocRKBXGdGA@mail.gmail.com>
	<CAFiDJ5_MYC=V_L1LyRNq00z=DerzKAF=RF5av9vHnUPP+9a1nw@mail.gmail.com>
	<6497772.rqSurELzER@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2 Oct 2015 23:56:37 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 02 October 2015 15:53:44 Ley Foon Tan wrote:
> > > Strictly speaking, if you have undocumented bindings downstream that
> > > is your problem and we don't have to accept them as-is upstream. I'm
> > > not going to worry about that here.
> > >
> > >>> txs contains the config space?
> > >> It is not the config space, but a memory slave port.
> > >
> > > Then where is the config space? It should not be part of "ranges" is
> > > all I care about.
> > The config space is not part of "ranges". Our IP uses TLP packet to
> > access config space.
> > 
> 
> It took me a bit to figure out what you mean here. To save others
> from reading the source, here is what I found:
> 
> * The config space is accessed indirectly through registers from the
>   "cra" register range, which is the right approach according to the
>   point that Rob made.
> * hardware-wise this basically looks like bit-banged PCIe, which is
>   both awesome and scary ;-)

drivers/pcie/host/pcie-host-gpio.c anyone? ;-)

	M.
-- 
Jazz is not dead. It just smells funny.
