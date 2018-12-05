Return-Path: <SRS0=Hio3=OO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A97C07E85
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 11:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E86720672
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 11:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E86720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeLELAN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:00:13 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51844 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbeLELAN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Dec 2018 06:00:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD35A80D;
        Wed,  5 Dec 2018 03:00:12 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B86383F575;
        Wed,  5 Dec 2018 03:00:09 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:00:02 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, sudeep.holla@arm.com,
        Gregory Clement <gregory.clement@bootlin.com>,
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
Subject: Re: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
Message-ID: <20181205110002.GA12435@e107981-ln.cambridge.arm.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <1999610.6DN9RK2Tt3@aspire.rjw.lan>
 <20181204094558.GA24588@e107981-ln.cambridge.arm.com>
 <1966692.fVZYlVgWHv@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1966692.fVZYlVgWHv@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 04, 2018 at 10:42:19PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, December 4, 2018 10:45:58 AM CET Lorenzo Pieralisi wrote:
> > On Mon, Dec 03, 2018 at 11:00:20PM +0100, Rafael J. Wysocki wrote:
> > > On Monday, December 3, 2018 4:38:46 PM CET Miquel Raynal wrote:
> > > > Hi Lorenzo,
> > > > 
> > > > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote on Mon, 3 Dec 2018
> > > > 10:27:08 +0000:
> > > > 
> > > > > [+Rafael, Sudeep]
> > > > > 
> > > > > On Fri, Nov 23, 2018 at 03:18:24PM +0100, Miquel Raynal wrote:
> > > > > > Add suspend and resume callbacks. The priority of these are
> > > > > > "_noirq()", to workaround early access to the registers done by the
> > > > > > PCI core through the ->read()/->write() callbacks at resume time.
> > > > > > 
> > > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > > ---
> > > > > >  drivers/pci/controller/pci-aardvark.c | 52 +++++++++++++++++++++++++++
> > > > > >  1 file changed, 52 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > > > > index 108b3f15c410..7ecf1ac4036b 100644
> > > > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > > > @@ -1108,6 +1108,55 @@ static int advk_pcie_setup_clk(struct advk_pcie *pci
> > > > > >  	return ret;
> > > > > >  }
> > > > > >  
> > > > > > +static int __maybe_unused advk_pcie_suspend(struct device *dev)
> > > > > > +{
> > > > > > +	struct advk_pcie *pcie = dev_get_drvdata(dev);
> > > > > > +
> > > > > > +	advk_pcie_disable_phy(pcie);
> > > > > > +
> > > > > > +	clk_disable_unprepare(pcie->clk);  
> > > > > 
> > > > > I have noticed it is common practice, still, I would like to check whether
> > > > > it is allowed to call functions that may sleep in a NOIRQ suspend/resume
> > > > > callback ?
> > > > 
> > > > You are right this is weird. I double checked and for instance,
> > > > pcie-mediatek.c, pci-tegra.c and pci-imx6.c do the exact same thing. There are
> > > > probably other cases where drivers call functions that may sleep from a NOIRQ
> > > > context. I am interested to know if this is valid and if not, what is the
> > > > alternative?
> > > > 
> > > 
> > > Yes, it is valid.  _noirq means that the high-level action handlers
> > > will not be invoked for interrupts occurring during that period, but
> > > that doesn't apply to timer interrupts.
> > > 
> > > IOW, don't expect *your* IRQ handler to be invoked then (if this is
> > > not a timer IRQ), but you can sleep.
> > 
> > Hi Rafael, all,
> > 
> > I did not ask my question (that may be silly) properly apologies. I know
> > that the S2R context allows sleeping the question is, in case
> > clk_disable_unprepare() (and resume counterparts) sleeps,
> 
> If it just sleeps, then this is not a problem, but if it actually *waits*
> for something meaningful to happen (which I guess is what you really mean),
> then things may go awry.

That's what I meant and I assume that's reason why the
*_prepare/unprepare() API are allowed to sleep, waiting for
an event to trigger.

> > what is going to wake it up, given that we are in the S2R NOIRQ phase and as
> > you said the action handlers (that are possibly required to wake up the eg
> > clk_disable_unprepare() caller) are disabled (unless, AFAIK,
> > IRQF_NO_SUSPEND is passed at IRQ request time in the respective driver).
> 
> So if it waits for an action handler to do something and wake it up, it may
> very well deadlock.  I have no idea if that really happens, though.

I have no idea either, that's why I asked the clock maintainers too,
the point is, the clk API allows this behaviour, I do not think it is safe
to rely on a non-blocking clk back-end, that's why I raised the question
in the first place.

> > The clk API implementations back-ends are beyond my depth, I just wanted
> > to make sure I understand how the S2R flow is expected to work in this
> > specific case.
> 
> Action handlers won't run unless the IRQs are marked as IRQF_NO_SUSPEND
> (well, there are a few more complications I don't recall exactly, but
> that's the basic rule).  If anything depends on them to run, it will block.

It looks like this patch (and more code in the kernel) expects either
the clk calls not to block or the action handler implemented in the
clock back-ends to run in S2R-NOIRQ (possibly by using the
IRQF_NO_SUSPEND flag).

I would appreciate if the clock maintainers can shed some light on
this.

Thanks,
Lorenzo
