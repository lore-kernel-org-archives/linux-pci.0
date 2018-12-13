Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65CEC65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 21:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921ED20870
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 21:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921ED20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeLMVvO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:51:14 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42533 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLMVvO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 16:51:14 -0500
Received: from 79.184.252.35.ipv4.supernova.orange.pl (79.184.252.35) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id bcac4d62866666fd; Thu, 13 Dec 2018 22:51:11 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, sudeep.holla@arm.com,
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
Date:   Thu, 13 Dec 2018 22:50:51 +0100
Message-ID: <61805564.abKDZ2rVK7@aspire.rjw.lan>
In-Reply-To: <20181213153000.245d7d5f@xps13>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com> <20181213105302.GA5330@e107981-ln.cambridge.arm.com> <20181213153000.245d7d5f@xps13>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday, December 13, 2018 3:30:00 PM CET Miquel Raynal wrote:
> Hi Lorenzo,
> 
> > > If that's really the case, then I can see how one device and it's
> > > children are suspended and the irq for it is disabled but the providing
> > > devices (clk, regulator, bus controller, etc.) are still fully active
> > > and not suspended but in fact completely usable and able to service
> > > interrupts. If that all makes sense, then I would answer the question
> > > with a definitive "yes it's all fine" because the clk consumer could be
> > > in the NOIRQ phase of its suspend but the clk provider wouldn't have
> > > even started suspending yet when clk_disable_unprepare() is called.  
> > 
> > That's a very good summary and address my concern, I still question this
> > patch correctness (and many others that carry out clk operations in S2R
> > NOIRQ phase), they may work but do not tell me they are rock solid given
> > your accurate summary above.
> 
> I understand your concern but I don't see any alternative right now
> and a deep rework of the PM core to respect such dependency is not
> something that can be done in a reasonable amount of time.

Maybe you don't need to rework anything. :-)

Have you considered using device links?

Thanks,
Rafael

