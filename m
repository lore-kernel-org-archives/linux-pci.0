Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778F6C43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 16:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513DD217D9
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 16:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbeLSQsF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:48:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39681 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbeLSQsF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Dec 2018 11:48:05 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1FF03206FF; Wed, 19 Dec 2018 17:48:02 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8AC842039F;
        Wed, 19 Dec 2018 17:48:01 +0100 (CET)
Date:   Wed, 19 Dec 2018 17:48:01 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
Cc:     Nadav Haklai <nadavh@marvell.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181219174801.1d611436@xps13>
In-Reply-To: <20181219162835.5ff9c33c@dellmb.labs.office.nic.cz>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
        <20181212102142.16053-4-miquel.raynal@bootlin.com>
        <20181214014701.373b220b@nic.cz>
        <20181214015712.31f749ea@nic.cz>
        <20181217170724.58421a29@xps13>
        <20181217223430.182d01d8@nic.cz>
        <20181218091817.4a8a5d42@xps13>
        <20181218092314.725af970@xps13>
        <20181218140920.6935db39@nic.cz>
        <20181218144130.3f1a75de@xps13>
        <20181219162835.5ff9c33c@dellmb.labs.office.nic.cz>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

Marek Behún <marek.behun@nic.cz> wrote on Wed, 19 Dec 2018 16:28:35
+0100:

> Hi,
> 
> One thing for which I would like to be able to disable comphy is that
> each consumes about 100mW of power. On Turris Mox we configure the
> comphys to SGMII1, PCIe and USB3 modes. If there is no USB device
> plugged, the USB3 phy can be disabled, and save 100mW of power. If the
> PCIe extension module is not present, the PCIe can too be disabled, and
> if there is no switch nor SFP module present, so can SGMII1.

Indeed not all PHY types implement ->power_off() (see in ATF code).
Better ask Marvell directly for that.

> 
> The other reason is this: if the SGMII phy is set to 1G mode, and then
> powered on second time in 2.5G mode, will it work? I would like to

This should work, yes.

> patch mvneta driver to power on/off the comphy, if the device node is
> present in device tree. But then the system can request such a change
> (SGMII to 2500BASE-X or back).
> 
> Marek
> 
> On Tue, 18 Dec 2018 14:41:30 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Hi Marek,
> > 
> > Marek Behun <marek.behun@nic.cz> wrote on Tue, 18 Dec 2018 14:09:20
> > +0100:
> >   
> > > > [2]
> > > > https://github.com/ARM-software/arm-trusted-firmware/blob/master/drivers/marvell/comphy/phy-comphy-3700.c      
> > > 
> > > Yes, I used mainline atf (it did not work out of the box with 18.09
> > > atf-marvell of course). But there is no _power_off function for
> > > SGMII, nor a digital_reset function like in cp110 implementation.    
> > 
> > Indeed, but why would you need one? Just use the helpers from the core
> > and if there is no implementation, nothing should happen and the
> > helper should exit without error. Just call
> > phy_set_mode()/phy_power_on() an you should be good.
> > 
> > 
> > Thanks,
> > Miquèl  
> 

For the record, I found out what was wrong in my code, toggling the
reset lines do not produce random effects anymore.


Thanks,
Miquèl
