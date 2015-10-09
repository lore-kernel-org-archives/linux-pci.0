Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39560 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbbJIOSS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Oct 2015 10:18:18 -0400
Date: Fri, 9 Oct 2015 15:18:14 +0100
From: Will Deacon <will.deacon@arm.com>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jon Medhurst <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	linux-pci <linux-pci@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	device-tree <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/4] arm64: Juno: Add support for the PCIe host bridge on
 Juno R1
Message-ID: <20151009141814.GR26278@arm.com>
References: <1444398323-17354-1-git-send-email-Liviu.Dudau@arm.com>
 <1444398323-17354-4-git-send-email-Liviu.Dudau@arm.com>
 <CAL_JsqJsb53VXiUfjGBXK37dBEi1r-PXVohg-c-7_x63R04VMA@mail.gmail.com>
 <20151009141107.GD3394@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151009141107.GD3394@e106497-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 09, 2015 at 03:11:07PM +0100, Liviu Dudau wrote:
> On Fri, Oct 09, 2015 at 08:54:33AM -0500, Rob Herring wrote:
> > On Fri, Oct 9, 2015 at 8:45 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > > Juno R1 board sports a functional PCIe host bridge that is
> > > compliant with the SBSA standard found here[1]. With the right
> > > firmware that initialises the XpressRICH3 controller one can
> > > use the generic Host Bridge driver to use the PCIe hardware.
> > >
> > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > >
> > > [1] http://infocenter.arm.com/help/topic/com.arm.doc.den0029a/
> > > ---
> > >  arch/arm64/boot/dts/arm/juno-r1.dts | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
> > > index c627511..a702a6b 100644
> > > --- a/arch/arm64/boot/dts/arm/juno-r1.dts
> > > +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
> > > @@ -109,6 +109,26 @@
> > >
> > >         #include "juno-base.dtsi"
> > >
> > > +       pcie-controller@40000000 {
> > > +               compatible = "pci-host-ecam-generic";
> > 
> > I think this is the first case of real h/w using this. We should have
> > a specific compatible here additionally.
> 
> Or maybe I can claim the use of the string on account on being the first
> on arm64 ;)

This is already being used on arm64 with kvmtool, qemu, the ARM fastmodel
and AMD Seattle.

Will
