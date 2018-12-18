Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC813C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 08:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B96214C6
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 08:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeLRIMS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:12:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48248 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbeLRIMS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 03:12:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2EB2820AB1; Tue, 18 Dec 2018 09:12:16 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id BBEF920834;
        Tue, 18 Dec 2018 09:12:05 +0100 (CET)
Date:   Tue, 18 Dec 2018 09:12:05 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Marek Behun <marek.behun@nic.cz>,
        Nadav Haklai <nadavh@marvell.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        devicetree@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-pci@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181218091205.04588033@xps13>
In-Reply-To: <87zht480v5.fsf@tkos.co.il>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
        <20181212102142.16053-4-miquel.raynal@bootlin.com>
        <20181214014701.373b220b@nic.cz>
        <20181214015712.31f749ea@nic.cz>
        <20181217170724.58421a29@xps13>
        <87zht480v5.fsf@tkos.co.il>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Baruch,

Baruch Siach <baruch@tkos.co.il> wrote on Mon, 17 Dec 2018 20:27:42
+0200:

> Hi Miquel,
> 
> Miquel Raynal writes:
> > Marek Behun <marek.behun@nic.cz> wrote on Fri, 14 Dec 2018 01:57:12
> > +0100:
> >  
> >> On Fri, 14 Dec 2018 01:47:01 +0100
> >> Marek Behun <marek.behun@nic.cz> wrote:
> >>   
> >> > are there already patches for the A37xx comphy driver?    
> >
> > Please try the latest patches on top of phy -next (with PHY interface
> > mode), available there [1]. You can pick only the COMPHY patches, but
> > keep them over the phy -next branch.
> >
> > Please note that for the SMC calls to succeed you must use a recent
> > ATF. Personally I used to work with the 'atf-v1.5-devel' branch of
> > Marvell's misl-atf repository but it is not available anymore. If you
> > already have a clone, then you are good to go, otherwise it might be
> > great if someone from Marvell could share a public Github link?  
> 
> The latest ATF from Marvell is at the 'atf-v1.5-armada-18.09' branch at
> 
>   https://github.com/MarvellEmbeddedProcessors/atf-marvell

Indeed, but I don't see A3700 COMPHY support there (only CP110's), I
think it will be merged into 18.12 release (will happen this month).


Thanks,
Miquèl
