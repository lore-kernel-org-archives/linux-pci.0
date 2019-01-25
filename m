Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3245C282C0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 17:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A581218A6
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 17:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfAYRi4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:38:56 -0500
Received: from foss.arm.com ([217.140.101.70]:51090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAYRiz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jan 2019 12:38:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4252DEBD;
        Fri, 25 Jan 2019 09:38:55 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D8B93F5AF;
        Fri, 25 Jan 2019 09:38:52 -0800 (PST)
Date:   Fri, 25 Jan 2019 17:38:42 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v3 00/15] Bring suspend to RAM support to PCIe Aardvark
 driver
Message-ID: <20190125173834.GA24052@e107981-ln.cambridge.arm.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
 <20190123170509.GB1157@e107981-ln.cambridge.arm.com>
 <20190125110530.0ff11a54@xps13>
 <20190125124011.GA16389@e107981-ln.cambridge.arm.com>
 <20190125135757.6518191e@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125135757.6518191e@xps13>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 25, 2019 at 01:57:57PM +0100, Miquel Raynal wrote:
> Hi Lorenzo,
> 
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote on Fri, 25 Jan 2019
> 12:40:11 +0000:
> 
> > On Fri, Jan 25, 2019 at 11:05:30AM +0100, Miquel Raynal wrote:
> > > Hi Lorenzo,
> > > 
> > > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote on Wed, 23 Jan 2019
> > > 17:05:09 +0000:
> > >   
> > > > On Tue, Jan 08, 2019 at 05:24:25PM +0100, Miquel Raynal wrote:  
> > > > > Hello,
> > > > > 
> > > > > As part of an effort to bring suspend to RAM support to Armada 3700
> > > > > SoCs (main target: ESPRESSObin), this series handles the work around
> > > > > the PCIe IP.
> > > > > 
> > > > > First, more configuration is done in the 'setup' helper as inspired
> > > > > from the U-Boot driver. This is needed to entirely initialize the IP
> > > > > during future resume operation (patch 1).
> > > > > 
> > > > > Then, reset GPIO, PHY and clock support are introduced (patch 2-4). As
> > > > > current device trees do not provide the corresponding properties, not
> > > > > finding one of these properties is not an error and just produces a
> > > > > warning. However, if the property is present, an error during PHY
> > > > > initialization will fail the probe of the driver.
> > > > > 
> > > > > Note: To be sure the clock will be resumed before this driver, a first
> > > > > series adding links between clocks and consumers has been submitted,
> > > > > see [1]. Anyway, having the clock series applied first is not needed.    
> > > > 
> > > > I do not understand what this means, in particular in relation
> > > > to the blocking clock calls in the suspend/resume NOIRQ hooks.  
> > > 
> > > I am not sure to understand your question.
> > > 
> > > As there are multiple points in this sentence I will detail each of
> > > them so please comment on the one which is bothering you:
> > > * I am working in parallel on a series adding device links to the clock
> > >   framework. This way when a driver consumes a clock, the clock
> > >   provider driver will be resumed first.
> > > * If the clock series I am talking about is applied after this one,
> > >   there is no build issue. Of course suspending the platform may
> > >   not work but this is a new feature so nothing will be broken.  
> > 
> > Suspend to RAM will be broken if the clock is suspended and no
> > notification will happen in the NOIRQ phase, it is a new-broken-feature.
> >
> > 
> > > * Device links do not enforce any priority if the suspend/resume phase
> > >   between two drivers is not the same. The PCIe driver suspends in the
> > >   NOIRQ phase. If we want the clock driver to suspend *after* PCIe, its
> > >   suspend/resume callbacks must be promoted to the NOIRQ phase as well
> > >   (and this is part of another series). As of today there is
> > >   no alternative.  
> > 
> > I will merge this series when it works, I have no evidence that it does
> > given what you are writing above, if the series you mention are
> > *necessary* for suspend-to-RAM to work they ought to be merged first.
> 
> I am working actively to bring A3700 SoC suspend to RAM support almost
> from scratch. 
> 
> As of today I have contributed 65 patches spread in 8 series for the
> PHY, clk, PCIe, SATA, USB, pinctrl and net subsystems. Some of them
> have been merged, but the vast majority has not, yet.
> 
> I mentioned this run-time dependency because it exists for people who
> would like to test just the PCIe IP. But S2RAM on A3700 will be a
> new-broken-feature until all patches are merged. While there is
> still one missing, the feature is broken. If everybody waits for
> the other patches to be merged first, it is gonna be a long process :)
> 
> However, if you want to wait for the clock core series to be applied
> first I respect this choice and I will update you when it will be the
> case.

I do not want to merge new code with known issues, it makes no sense.

There are other drivers with a similar problem in the mainline, we
ought to fix those but certainly adding more won't help in that respect.

There is nothing I am saying here that goes against your work, I just
want to have working code in the mainlike kernel, we will merge this
series when it is ready, thanks for bearing with me.

Feel free to ping me/rebase/repost when dependencies are sorted.

Thanks,
Lorenzo
