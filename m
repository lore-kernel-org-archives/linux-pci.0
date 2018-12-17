Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B899C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 16:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C52206A2
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 16:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeLQQHi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:07:38 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60472 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbeLQQHi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 11:07:38 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 499682072D; Mon, 17 Dec 2018 17:07:35 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id D8C2A20723;
        Mon, 17 Dec 2018 17:07:24 +0100 (CET)
Date:   Mon, 17 Dec 2018 17:07:24 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Marek Behun <marek.behun@nic.cz>, Nadav Haklai <nadavh@marvell.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
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
Message-ID: <20181217170724.58421a29@xps13>
In-Reply-To: <20181214015712.31f749ea@nic.cz>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
 <20181212102142.16053-4-miquel.raynal@bootlin.com>
 <20181214014701.373b220b@nic.cz>
 <20181214015712.31f749ea@nic.cz>
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

Marek Behun <marek.behun@nic.cz> wrote on Fri, 14 Dec 2018 01:57:12
+0100:

> On Fri, 14 Dec 2018 01:47:01 +0100
> Marek Behun <marek.behun@nic.cz> wrote:
> 
> > Hi Miquel,
> > are there already patches for the A37xx comphy driver?  

Please try the latest patches on top of phy -next (with PHY interface
mode), available there [1]. You can pick only the COMPHY patches, but
keep them over the phy -next branch.

Please note that for the SMC calls to succeed you must use a recent
ATF. Personally I used to work with the 'atf-v1.5-devel' branch of
Marvell's misl-atf repository but it is not available anymore. If you
already have a clone, then you are good to go, otherwise it might be
great if someone from Marvell could share a public Github link?

> Never mind, I found them. I shall test this on Turris Mox.
> Is the comphy driver supposed to be able to change eth mode from
> 1000BASE-X to 2500BASE-X and back without reboot?

In theory yes, unfortunately I am working on an EspressoBin which uses
the SATA, PCIe and SATA configurations of the COMPHY, but not the
Ethernet ones (SGMII/1000BASE-X and HS_SGMII/2500BASE-X). So the
support is ready to be tested!

> 
> This would be cool for our SFP cage module of Turris Mox, just to add
> support for comphy into mvneta.
> 
> Marek

[1] https://github.com/miquelraynal/linux.git branch marvell/phy-next/pm


Thanks,
Miquèl
