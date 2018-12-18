Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685EAC43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 13:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A1D217D7
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 13:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="XzVO3cxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeLRNJ1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:09:27 -0500
Received: from mail.nic.cz ([217.31.204.67]:55502 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbeLRNJ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 08:09:27 -0500
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id E7EF260255;
        Tue, 18 Dec 2018 14:09:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1545138565; bh=OhFgmvl1ZsheA1tyLTkSU9tM0Ug0GqJTwPx73mVAwMg=;
        h=Date:From:To;
        b=XzVO3cxW+uEC1Ewg07PZpaZRswgCTBe+CIY8TFOxOLeNQ5vv+9z0fw8LEHRwj+qem
         rTofkzzmx3hfKxg6EvR7m6haOInkotv0CaLSt90yr8H05YqAf5QLyhkCGo0nJG8lQA
         Ls6JaKnj++97Y6goGTlPJkdhX/ipFno/a8Hxq5g8=
Date:   Tue, 18 Dec 2018 14:09:20 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
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
Message-ID: <20181218140920.6935db39@nic.cz>
In-Reply-To: <20181218092314.725af970@xps13>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
        <20181212102142.16053-4-miquel.raynal@bootlin.com>
        <20181214014701.373b220b@nic.cz>
        <20181214015712.31f749ea@nic.cz>
        <20181217170724.58421a29@xps13>
        <20181217223430.182d01d8@nic.cz>
        <20181218091817.4a8a5d42@xps13>
        <20181218092314.725af970@xps13>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> [2]
> https://github.com/ARM-software/arm-trusted-firmware/blob/master/drivers/marvell/comphy/phy-comphy-3700.c

Yes, I used mainline atf (it did not work out of the box with 18.09
atf-marvell of course). But there is no _power_off function for SGMII,
nor a digital_reset function like in cp110 implementation.

Marek
