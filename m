Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:40003 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbbJPICm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2015 04:02:42 -0400
Date: Fri, 16 Oct 2015 09:02:23 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Rob Herring <robh+dt@kernel.org>
Cc: WingMan Kwok <w-kwok2@ti.com>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Roger Quadros <rogerq@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 0/2] Common SerDes driver for TI's Keystone Platforms
Message-ID: <20151016080222.GH32532@n2100.arm.linux.org.uk>
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com>
 <20151015165105.GE32532@n2100.arm.linux.org.uk>
 <CAL_JsqJTjCT8D-3OryFPEF8nnaPtrai7Mvf-gJRkh60aDixx-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqJTjCT8D-3OryFPEF8nnaPtrai7Mvf-gJRkh60aDixx-g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 15, 2015 at 08:00:41PM -0500, Rob Herring wrote:
> On Thu, Oct 15, 2015 at 11:51 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Oct 15, 2015 at 10:25:43AM -0400, WingMan Kwok wrote:
> >> On TI's Keystone platforms, several peripherals such as the
> >> gbe ethernet switch, 10gbe ethether switch and PCIe controller
> >> require the use of a SerDes for converting SoC parallel data into
> >> serialized data that can be output over a high-speed electrical
> >> interface, and also converting high-speed serial input data
> >> into parallel data that can be processed by the SoC.  The
> >> SerDeses used by those peripherals, though they may be different,
> >> are largely similar in functionality and setup.
> >
> > Given that serdes is not specific to TI, should this be specific to
> > TI, or should there be an effort to come up with something which
> > everyone who has serdes links can make use of?
> >
> > Serdes comes in multiple different forms: PCIe, 1G SGMII ethernet,
> > 1000base-X ethernet, 10g ethernet, SATA... I'd hate to see a
> > plethora of SoC specific stuff for this.
> 
> The licensed IP I've seen doesn't provide a standard register
> interface, but just signals to the IP block. Same with PLL IP. So
> we'll probably get to see vendors continue to differentiate on PHY
> register design. :)

So what?  Network drivers differ radically in register design, yet we
still have a standardised interface to network drivers.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
