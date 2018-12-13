Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B69AC65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 14:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4946420880
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 14:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4946420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeLMOaO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:30:14 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53607 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbeLMOaO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 09:30:14 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 52E3E207AD; Thu, 13 Dec 2018 15:30:12 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 53E1D20743;
        Thu, 13 Dec 2018 15:30:01 +0100 (CET)
Date:   Thu, 13 Dec 2018 15:30:00 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, sudeep.holla@arm.com,
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
Message-ID: <20181213153000.245d7d5f@xps13>
In-Reply-To: <20181213105302.GA5330@e107981-ln.cambridge.arm.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
        <1999610.6DN9RK2Tt3@aspire.rjw.lan>
        <20181204094558.GA24588@e107981-ln.cambridge.arm.com>
        <1966692.fVZYlVgWHv@aspire.rjw.lan>
        <20181211141627.GA526@e107981-ln.cambridge.arm.com>
        <154469162632.19322.13092710881803732022@swboyd.mtv.corp.google.com>
        <20181213105302.GA5330@e107981-ln.cambridge.arm.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

> > If that's really the case, then I can see how one device and it's
> > children are suspended and the irq for it is disabled but the providing
> > devices (clk, regulator, bus controller, etc.) are still fully active
> > and not suspended but in fact completely usable and able to service
> > interrupts. If that all makes sense, then I would answer the question
> > with a definitive "yes it's all fine" because the clk consumer could be
> > in the NOIRQ phase of its suspend but the clk provider wouldn't have
> > even started suspending yet when clk_disable_unprepare() is called.  
> 
> That's a very good summary and address my concern, I still question this
> patch correctness (and many others that carry out clk operations in S2R
> NOIRQ phase), they may work but do not tell me they are rock solid given
> your accurate summary above.

I understand your concern but I don't see any alternative right now
and a deep rework of the PM core to respect such dependency is not
something that can be done in a reasonable amount of time. With
regard to this constraint, do you think it is worth blocking the
series?


Thanks,
Miquèl
