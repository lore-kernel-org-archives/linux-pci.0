Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0FBC43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 21:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A295D20874
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 21:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="Kk1vkqh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeLQVeg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:34:36 -0500
Received: from mail.nic.cz ([217.31.204.67]:59894 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbeLQVeg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 16:34:36 -0500
Received: from localhost (unknown [172.20.6.233])
        by mail.nic.cz (Postfix) with ESMTPS id CEE55601FB;
        Mon, 17 Dec 2018 22:34:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1545082473; bh=8d7f2T8gmoGdbmbuVrMD+gAx0cbRgRHlQgbYUy0eDeg=;
        h=Date:From:To;
        b=Kk1vkqh9c7p2YKhLb/jMnRyee7n1OBuyEsOAtLaPjb5MTL907NUo7Qgf9dYWcF/dY
         +uz30UiTJ9Rs4WzKSuSlURbTylK8KcSS6VsbTsVjz3mUtTuvvTT3ky50sNwRAmvRDh
         ZW7GXyq19o8YLUiXTyVnnjJ0jQmpJOwYZvJA8yLg=
Date:   Mon, 17 Dec 2018 22:34:30 +0100
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
Message-ID: <20181217223430.182d01d8@nic.cz>
In-Reply-To: <20181217170724.58421a29@xps13>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
        <20181212102142.16053-4-miquel.raynal@bootlin.com>
        <20181214014701.373b220b@nic.cz>
        <20181214015712.31f749ea@nic.cz>
        <20181217170724.58421a29@xps13>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Miquel,

I tried the patches and they are working, with the exception of Compex
WLE900X card, but we know that this card is problematic.
I am interesting if there is a known way to turn of the comphy on
A3720, or at least change the SGMII mode from 1Gbps to 2.5Gbps and
back. Marvell documentation does not provide this information and the
code in ATF providing the SMC calls does not do this either.
Do you know how this can be achieved?
Thanks,

Marek

On Mon, 17 Dec 2018 17:07:24 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Marek,
>=20
> Marek Behun <marek.behun@nic.cz> wrote on Fri, 14 Dec 2018 01:57:12
> +0100:
>=20
> > On Fri, 14 Dec 2018 01:47:01 +0100
> > Marek Behun <marek.behun@nic.cz> wrote:
> >  =20
> > > Hi Miquel,
> > > are there already patches for the A37xx comphy driver?   =20
>=20
> Please try the latest patches on top of phy -next (with PHY interface
> mode), available there [1]. You can pick only the COMPHY patches, but
> keep them over the phy -next branch.
>=20
> Please note that for the SMC calls to succeed you must use a recent
> ATF. Personally I used to work with the 'atf-v1.5-devel' branch of
> Marvell's misl-atf repository but it is not available anymore. If you
> already have a clone, then you are good to go, otherwise it might be
> great if someone from Marvell could share a public Github link?
>=20
> > Never mind, I found them. I shall test this on Turris Mox.
> > Is the comphy driver supposed to be able to change eth mode from
> > 1000BASE-X to 2500BASE-X and back without reboot? =20
>=20
> In theory yes, unfortunately I am working on an EspressoBin which uses
> the SATA, PCIe and SATA configurations of the COMPHY, but not the
> Ethernet ones (SGMII/1000BASE-X and HS_SGMII/2500BASE-X). So the
> support is ready to be tested!
>=20
> >=20
> > This would be cool for our SFP cage module of Turris Mox, just to
> > add support for comphy into mvneta.
> >=20
> > Marek =20
>=20
> [1] https://github.com/miquelraynal/linux.git branch
> marvell/phy-next/pm
>=20
>=20
> Thanks,
> Miqu=C3=A8l

