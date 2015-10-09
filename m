Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:64727 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbbJIPtb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 11:49:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Jon Medhurst <tixy@linaro.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kumar Gala <galak@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	device-tree <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/4] arm64: Juno: Add support for the PCIe host bridge on Juno R1
Date: Fri, 09 Oct 2015 17:49:18 +0200
Message-ID: <40550712.xdsq5nNSTG@wuerfel>
In-Reply-To: <20151009154408.GD21629@leverpostej>
References: <1444398323-17354-1-git-send-email-Liviu.Dudau@arm.com> <20151009141107.GD3394@e106497-lin.cambridge.arm.com> <20151009154408.GD21629@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 09 October 2015 16:44:08 Mark Rutland wrote:
> On Fri, Oct 09, 2015 at 03:11:07PM +0100, Liviu Dudau wrote:
> > On Fri, Oct 09, 2015 at 08:54:33AM -0500, Rob Herring wrote:
> > Or maybe I can claim the use of the string on account on being the first on arm64 
> > 
> > I can add a vendor prefix if you want, but pci-host-generic is going to ignore it 
> > *because* it is trying to be a generic driver.
> 
> The point here is to have the string ready if we need it later, so it's
> fine that it's not used currently.
> 
> Rob's suggestion is that the compatible list should look something like:
> 
> compatible = "arm,juno-r1-pcie", "plda,xpressrich3", "pci-host-ecam-generic";
> 
> We can match on "pci-host-ecam-generic" for now (and hopefully forever),
> but if for some reason we need to special-case this host controller (or
> Juno's integration thereof), we can do that based on the compatible
> string.

Sounds good to me, it certainly can't hurt.

	Arnd
