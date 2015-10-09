Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40375 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757065AbbJIQlb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Oct 2015 12:41:31 -0400
Date: Fri, 9 Oct 2015 17:41:29 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Will Deacon <will.deacon@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	device-tree <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] arm64: Juno: Add support for the PCIe host bridge on
 Juno R1
Message-ID: <20151009164129.GG3394@e106497-lin.cambridge.arm.com>
References: <1444398323-17354-1-git-send-email-Liviu.Dudau@arm.com>
 <20151009141107.GD3394@e106497-lin.cambridge.arm.com>
 <20151009154408.GD21629@leverpostej>
 <40550712.xdsq5nNSTG@wuerfel>
 <20151009160910.GF3394@e106497-lin.cambridge.arm.com>
 <20151009163252.GE21629@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20151009163252.GE21629@leverpostej>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 09, 2015 at 05:32:52PM +0100, Mark Rutland wrote:
> On Fri, Oct 09, 2015 at 05:09:10PM +0100, Liviu Dudau wrote:
> > On Fri, Oct 09, 2015 at 05:49:18PM +0200, Arnd Bergmann wrote:
> > > On Friday 09 October 2015 16:44:08 Mark Rutland wrote:
> > > > On Fri, Oct 09, 2015 at 03:11:07PM +0100, Liviu Dudau wrote:
> > > > > On Fri, Oct 09, 2015 at 08:54:33AM -0500, Rob Herring wrote:
> > > > > Or maybe I can claim the use of the string on account on being the first on arm64 
> > > > > 
> > > > > I can add a vendor prefix if you want, but pci-host-generic is going to ignore it 
> > > > > *because* it is trying to be a generic driver.
> > > > 
> > > > The point here is to have the string ready if we need it later, so it's
> > > > fine that it's not used currently.
> > > > 
> > > > Rob's suggestion is that the compatible list should look something like:
> > > > 
> > > > compatible = "arm,juno-r1-pcie", "plda,xpressrich3", "pci-host-ecam-generic";
> > > > 
> > > > We can match on "pci-host-ecam-generic" for now (and hopefully forever),
> > > > but if for some reason we need to special-case this host controller (or
> > > > Juno's integration thereof), we can do that based on the compatible
> > > > string.
> > > 
> > > Sounds good to me, it certainly can't hurt.
> > > 
> > > 	Arnd
> > 
> > Hmm, I'm sorry, but this time I'm going to disagree.
> > 
> > I understand the principle that the DTS is a description of the
> > hardware and it should not have any built in knowledge of how a driver
> > works but describe the physical properties of the device (where such
> > description makes sense, in this case it does).
> > 
> > However, when ARM has created the Juno platform it has also created a
> > standard called SBSA and has claimed that Juno is compliant with that
> > standard. My current position (and it used to be MarkR's as well when
> > we have argued internally the pros and cons of having a bespoke driver
> > for PLDA's XpressRICH3) is that SBSA compliant behaviour *is* the
> > expected behaviour and if the device doesn't conform it needs to be
> > fixed in firmware.
> 
> We are not arguing for a bespoke driver, and in fact we hope to never
> have to use the addition strings.
> 
> However, experience shows that we might not be lucky, and if we
> encounter some bizarre quirk in future we might need to handle that by
> knowing what the hardware is.
> 
> > Otherwise, I could've posted months ago the other public driver[1]
> > that I've wrote that doesn't depend on firmware and could have been
> > done with this long time ago.
> 
> We're not arguing for kernel support code. What we're arguing for is
> data in the DTB that ideally turns out to be irrelevant.
> 
> I can't see why you object to that.

It is not a strong objection but I don't want to ever have to add bespoke
code to the pci-host-generic.c driver so adding a compatible property that
is going to be ignored is kind of pointless. Yes, one will have a better
idea on what the hardware actually is, but so what?

I will send a v2 with the added values.

Best regards,
Liviu

> 
> Mark.
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
