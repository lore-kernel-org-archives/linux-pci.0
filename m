Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42762C65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 09:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ED020672
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544691630;
	bh=n60jGYTA/cKtftl3HoEEGpChDFMsL9X1Zzmy/CGdafY=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=z0wPcY3M+gdniJGeTap4w1FKMaj37vn4Vbczpbx/HnGanKOche1WJnd+RvsPi9eqC
	 FdfG/FIVvE7Otw0SkMIni7E3K1lhHt5OQqupx7y5NeszvL1Bgsn8/jSnii8NWobWfQ
	 vW8dfqwD/tLLfJLlbr4EsILWHraiWLANp7hMU2fg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1ED020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeLMJA3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeLMJA2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 04:00:28 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2337D20849;
        Thu, 13 Dec 2018 09:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544691627;
        bh=n60jGYTA/cKtftl3HoEEGpChDFMsL9X1Zzmy/CGdafY=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=Xulx05i19h7jFFRHMAeXFXCVrfhvV+m6PqVuIvnMWKZ+Olr5aILeaRuptg4Irz3fl
         bxqTX8WhPe6tndc3U2APdeMKb7lat3wFpJSL4RA08KSzOuhg+Z+UkxPZg2wkGh8ZJn
         MZrrzcPDJ+PUXd6moutluLNSFavnUTGD4xiQyMkM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181211141627.GA526@e107981-ln.cambridge.arm.com>
Subject: Re: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com> <1999610.6DN9RK2Tt3@aspire.rjw.lan> <20181204094558.GA24588@e107981-ln.cambridge.arm.com> <1966692.fVZYlVgWHv@aspire.rjw.lan> <20181211141627.GA526@e107981-ln.cambridge.arm.com>
Message-ID: <154469162632.19322.13092710881803732022@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
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
Date:   Thu, 13 Dec 2018 01:00:26 -0800
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Lorenzo Pieralisi (2018-12-11 06:16:27)
> On Tue, Dec 04, 2018 at 10:42:19PM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, December 4, 2018 10:45:58 AM CET Lorenzo Pieralisi wrote:
> > > On Mon, Dec 03, 2018 at 11:00:20PM +0100, Rafael J. Wysocki wrote:
> > > > On Monday, December 3, 2018 4:38:46 PM CET Miquel Raynal wrote:
> > >=20
> > > I did not ask my question (that may be silly) properly apologies. I k=
now
> > > that the S2R context allows sleeping the question is, in case
> > > clk_disable_unprepare() (and resume counterparts) sleeps,
> >=20
> > If it just sleeps, then this is not a problem, but if it actually *wait=
s*
> > for something meaningful to happen (which I guess is what you really me=
an),
> > then things may go awry.
> >=20
> > > what is going to wake it up, given that we are in the S2R NOIRQ phase=
 and as
> > > you said the action handlers (that are possibly required to wake up t=
he eg
> > > clk_disable_unprepare() caller) are disabled (unless, AFAIK,
> > > IRQF_NO_SUSPEND is passed at IRQ request time in the respective drive=
r).
> >=20
> > So if it waits for an action handler to do something and wake it up, it=
 may
> > very well deadlock.  I have no idea if that really happens, though.
> >=20
> > > The clk API implementations back-ends are beyond my depth, I just wan=
ted
> > > to make sure I understand how the S2R flow is expected to work in this
> > > specific case.
> >=20
> > Action handlers won't run unless the IRQs are marked as IRQF_NO_SUSPEND
> > (well, there are a few more complications I don't recall exactly, but
> > that's the basic rule).  If anything depends on them to run, it will bl=
ock.
>=20
> Stephen, any comments on this ?

Sorry I seemed to miss this email. BTW, what is an "action handler"
here? The IRQ action handler?

> I would like to understand if it is safe
> to call a clk_*unprepare/prepare_* function (that may have a blocking
> back-end waiting on a wake-up event triggered by an IRQ action) in the
> suspend/resume NOIRQ phase.

Does this ever occur in practice? I imagine "blocking back-end waiting
on a wake-up event" would be some sort of i2c or SPI based "slow" clk
that is prepared/unprepared in the NOIRQ phase of suspend/resume? So
that function call into the clk API fails because the i2c or SPI
controller used to toggle the clk on/off state relies on the
controller's IRQ to manage the transaction over the bus but that IRQ is
disabled. I suppose this is possible but I've never heard of it
happening in practice. Do you have such a scenario?

>=20
> It is not clear how the unprepare/prepare() callers can possibly know
> whether it is safe to block at that stage given that IRQ actions are
> suspended and the wake-up may never trigger.
>=20

Is this solved in other situations somehow? I don't think clk consumers
have any idea that things are safe or not safe to use in the NOIRQ phase
of suspend, but I also don't see how clks are special here. Any provider
consumer pattern would fall into the same trap, but maybe clks are the
first ones to get here.

It seems like a larger problem with NOIRQ suspend in general and how it
is too coarse of a solution for suspend ordering of devices. It's not
like we need *all* device interrupts to be disabled to do something in
suspend with one particular device. Most likely, we just need the device
and all it's children to be suspended and this device to have it's IRQ
disabled for the NOIRQ suspend callback to work. (Maybe any devices it's
supplying with device links too?)

If that's really the case, then I can see how one device and it's
children are suspended and the irq for it is disabled but the providing
devices (clk, regulator, bus controller, etc.) are still fully active
and not suspended but in fact completely usable and able to service
interrupts. If that all makes sense, then I would answer the question
with a definitive "yes it's all fine" because the clk consumer could be
in the NOIRQ phase of its suspend but the clk provider wouldn't have
even started suspending yet when clk_disable_unprepare() is called.

