Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57437C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 08:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D3F217D9
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 08:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeLRISb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:18:31 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48444 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbeLRISb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 03:18:31 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5040420834; Tue, 18 Dec 2018 09:18:28 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id DB906206A7;
        Tue, 18 Dec 2018 09:18:17 +0100 (CET)
Date:   Tue, 18 Dec 2018 09:18:17 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Marek Behun <marek.behun@nic.cz>
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
Message-ID: <20181218091817.4a8a5d42@xps13>
In-Reply-To: <20181217223430.182d01d8@nic.cz>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
        <20181212102142.16053-4-miquel.raynal@bootlin.com>
        <20181214014701.373b220b@nic.cz>
        <20181214015712.31f749ea@nic.cz>
        <20181217170724.58421a29@xps13>
        <20181217223430.182d01d8@nic.cz>
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

Marek Behun <marek.behun@nic.cz> wrote on Mon, 17 Dec 2018 22:34:30
+0100:

> Miquel,
> 
> I tried the patches and they are working, with the exception of Compex
> WLE900X card, but we know that this card is problematic.

How did you test them? I am surprised that COMPHY calls worked for you
out of the box. I am not sure you have A3700 COMPHY support in your ATF
but it probably work because U-Boot is doing the initial configuration.

> I am interesting if there is a known way to turn of the comphy on
> A3720, or at least change the SGMII mode from 1Gbps to 2.5Gbps and
> back. Marvell documentation does not provide this information and the
> code in ATF providing the SMC calls does not do this either.
> Do you know how this can be achieved?

The driver already handles these calls (see [1]), making use of
them is just a matter of hacking into drivers (in your case, I
suppose it is mvneta) and add phy_set_mode()/phy_power_on() calls.

[1] https://github.com/miquelraynal/linux/blob/marvell/phy-next/pm/drivers/phy/marvell/phy-mvebu-a3700-comphy.c#L189


Thanks,
Miquèl
