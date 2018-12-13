Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DFBC67872
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AE52086D
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AE52086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeLMKxL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:53:11 -0500
Received: from foss.arm.com ([217.140.101.70]:59026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbeLMKxL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 05:53:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CA4CA78;
        Thu, 13 Dec 2018 02:53:10 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559433F6A8;
        Thu, 13 Dec 2018 02:53:07 -0800 (PST)
Date:   Thu, 13 Dec 2018 10:53:02 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        sudeep.holla@arm.com,
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
Message-ID: <20181213105302.GA5330@e107981-ln.cambridge.arm.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <1999610.6DN9RK2Tt3@aspire.rjw.lan>
 <20181204094558.GA24588@e107981-ln.cambridge.arm.com>
 <1966692.fVZYlVgWHv@aspire.rjw.lan>
 <20181211141627.GA526@e107981-ln.cambridge.arm.com>
 <154469162632.19322.13092710881803732022@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154469162632.19322.13092710881803732022@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 13, 2018 at 01:00:26AM -0800, Stephen Boyd wrote:
> Quoting Lorenzo Pieralisi (2018-12-11 06:16:27)
> > On Tue, Dec 04, 2018 at 10:42:19PM +0100, Rafael J. Wysocki wrote:
> > > On Tuesday, December 4, 2018 10:45:58 AM CET Lorenzo Pieralisi wrote:
> > > > On Mon, Dec 03, 2018 at 11:00:20PM +0100, Rafael J. Wysocki wrote:
> > > > > On Monday, December 3, 2018 4:38:46 PM CET Miquel Raynal wrote:
> > > > 
> > > > I did not ask my question (that may be silly) properly apologies. I know
> > > > that the S2R context allows sleeping the question is, in case
> > > > clk_disable_unprepare() (and resume counterparts) sleeps,
> > > 
> > > If it just sleeps, then this is not a problem, but if it actually *waits*
> > > for something meaningful to happen (which I guess is what you really mean),
> > > then things may go awry.
> > > 
> > > > what is going to wake it up, given that we are in the S2R NOIRQ phase and as
> > > > you said the action handlers (that are possibly required to wake up the eg
> > > > clk_disable_unprepare() caller) are disabled (unless, AFAIK,
> > > > IRQF_NO_SUSPEND is passed at IRQ request time in the respective driver).
> > > 
> > > So if it waits for an action handler to do something and wake it up, it may
> > > very well deadlock.  I have no idea if that really happens, though.
> > > 
> > > > The clk API implementations back-ends are beyond my depth, I just wanted
> > > > to make sure I understand how the S2R flow is expected to work in this
> > > > specific case.
> > > 
> > > Action handlers won't run unless the IRQs are marked as IRQF_NO_SUSPEND
> > > (well, there are a few more complications I don't recall exactly, but
> > > that's the basic rule).  If anything depends on them to run, it will block.
> > 
> > Stephen, any comments on this ?
> 
> Sorry I seemed to miss this email. BTW, what is an "action handler"
> here? The IRQ action handler?

Yes, that is.

> > I would like to understand if it is safe
> > to call a clk_*unprepare/prepare_* function (that may have a blocking
> > back-end waiting on a wake-up event triggered by an IRQ action) in the
> > suspend/resume NOIRQ phase.
> 
> Does this ever occur in practice? I imagine "blocking back-end waiting
> on a wake-up event" would be some sort of i2c or SPI based "slow" clk
> that is prepared/unprepared in the NOIRQ phase of suspend/resume? So
> that function call into the clk API fails because the i2c or SPI
> controller used to toggle the clk on/off state relies on the
> controller's IRQ to manage the transaction over the bus but that IRQ is
> disabled. I suppose this is possible but I've never heard of it
> happening in practice. Do you have such a scenario?

No (because my knowledge of clock internals is poor) but I questioned
the code while reviewing it - I do not think it is a safe assumption
to make (otherwise what's the purpose of having a clk API -
*prepare/unprepare*() - that, AFAIK was implemented to allow back-ends to
block, waiting for an event).

There is clearly an implicit assumption there from clk API caller POW
"this call won't block or an IRQ action - IRQF_NO_SUSPEND - will wake
me up if it does. Or the call can time out, but that's an error path".

This seems fragile to me.

> > It is not clear how the unprepare/prepare() callers can possibly know
> > whether it is safe to block at that stage given that IRQ actions are
> > suspended and the wake-up may never trigger.
> > 
> 
> Is this solved in other situations somehow? I don't think clk consumers
> have any idea that things are safe or not safe to use in the NOIRQ phase
> of suspend, but I also don't see how clks are special here. Any provider
> consumer pattern would fall into the same trap, but maybe clks are the
> first ones to get here.

You have a good point, I do not think clk are specials, I am only saying
this patch code can run into significant issues.

> It seems like a larger problem with NOIRQ suspend in general and how it
> is too coarse of a solution for suspend ordering of devices. It's not
> like we need *all* device interrupts to be disabled to do something in
> suspend with one particular device. Most likely, we just need the device
> and all it's children to be suspended and this device to have it's IRQ
> disabled for the NOIRQ suspend callback to work. (Maybe any devices it's
> supplying with device links too?)
> 
> If that's really the case, then I can see how one device and it's
> children are suspended and the irq for it is disabled but the providing
> devices (clk, regulator, bus controller, etc.) are still fully active
> and not suspended but in fact completely usable and able to service
> interrupts. If that all makes sense, then I would answer the question
> with a definitive "yes it's all fine" because the clk consumer could be
> in the NOIRQ phase of its suspend but the clk provider wouldn't have
> even started suspending yet when clk_disable_unprepare() is called.

That's a very good summary and address my concern, I still question this
patch correctness (and many others that carry out clk operations in S2R
NOIRQ phase), they may work but do not tell me they are rock solid given
your accurate summary above.

Thanks,
Lorenzo
