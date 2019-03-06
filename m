Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1826C43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 11:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7165920675
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 11:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfCFLjP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:39:15 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59215 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfCFLjO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2019 06:39:14 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h1UtA-0003mw-OE; Wed, 06 Mar 2019 12:39:08 +0100
Message-ID: <1551872347.9298.26.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: dwc: skip MSI init if MSIs have been explicitly
 disabled
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>
Date:   Wed, 06 Mar 2019 12:39:07 +0100
In-Reply-To: <9abfe0b2-edfc-a989-04d3-0dd143b7557b@synopsys.com>
References: <20190227165219.31911-1-l.stach@pengutronix.de>
         <20190304192548.GB26569@google.com>
         <1551728385.9298.18.camel@pengutronix.de>
         <86ef7m1ji2.wl-marc.zyngier@arm.com>
         <9abfe0b2-edfc-a989-04d3-0dd143b7557b@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Mittwoch, den 06.03.2019, 09:53 +0000 schrieb Gustavo Pimentel:
> Hi,
> 
> On 04/03/2019 20:18, Marc Zyngier wrote:
> > Hi both,
> > 
> > On Mon, 04 Mar 2019 19:39:45 +0000,
> > > > Lucas Stach <l.stach@pengutronix.de> wrote:
> > > 
> 
> (snipped)
> 
> > > > > 
> > > > > As MSI and legacy IRQs are already mutually exclusive on the DWC core,
> > > > > as the core won't forward any legacy IRQs once any MSI has been enabled,
> > > > > users wishing to use legacy IRQs already need to explictly disable MSI
> > > > > support (usually via the pci=nomsi kernel commandline option). To avoid
> > > > > any issues with MSI conflicting with legacy IRQs, just skip all of the
> > > > > DWC MSI initalization, including the IRQ line claim, when MSI is disabled.
> > > > 
> > > > Does this mean that if we have a device that uses legacy IRQs, the
> > > > user has to figure out to boot with "pci=nomsi"?
> > > 
> > > As long as there is only a single device connected and there are no
> > > port services things will work. If port services are active, those will
> > > start to use MSIs, breaking legacy IRQs in the process.
> > > 
> > > I've asked Synopsys if there is a workaround for this, but it seems
> > > that the core is working "as designed" with no workaround for this icky
> > > behavior.
> > 
> > Is this the general DWC controller behaviour? Or something that is
> > specific to a given implementation? I can't believe someone actually
> > thought this is an acceptable behaviour...
> > 
> > Gustavo, can you please check with your HW colleagues and let
> > everybody know what's the official Synopsys position on this?
> > 
> 
> Sure, I can ask the HW team to provide me more info about this, This can take a
> while. Unfortunately on my setup I only have MSI and MSI-X, therefore I can't
> really test what has been statemented.

At least this behavior was confirmed by Joao Pinto at Synopsys last
time the issue was discussed.

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/499591.html

Regards,
Lucas
