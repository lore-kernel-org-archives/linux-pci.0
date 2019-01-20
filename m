Return-Path: <SRS0=1Q+I=P4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A837C636A2
	for <linux-pci@archiver.kernel.org>; Sun, 20 Jan 2019 15:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D76A2085A
	for <linux-pci@archiver.kernel.org>; Sun, 20 Jan 2019 15:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbfATPQy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 20 Jan 2019 10:16:54 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57305 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfATPQx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 20 Jan 2019 10:16:53 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D61FB2074A; Sun, 20 Jan 2019 16:16:50 +0100 (CET)
Received: from xps13 (unknown [77.136.42.183])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9EF3D206A7;
        Sun, 20 Jan 2019 16:16:49 +0100 (CET)
Date:   Sun, 20 Jan 2019 16:16:48 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v3 00/15] Bring suspend to RAM support to PCIe Aardvark
 driver
Message-ID: <20190120161648.102191be@xps13>
In-Reply-To: <87va2llxhz.fsf@FE-laptop>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
        <87va2llxhz.fsf@FE-laptop>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gregory,

Gregory CLEMENT <gregory.clement@bootlin.com> wrote on Fri, 18 Jan 2019
17:51:52 +0100:

> Hi Miquel,
>  
>  On mar., janv. 08 2019, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Hello,
> >
> > As part of an effort to bring suspend to RAM support to Armada 3700
> > SoCs (main target: ESPRESSObin), this series handles the work around
> > the PCIe IP.
> >
> > First, more configuration is done in the 'setup' helper as inspired
> > from the U-Boot driver. This is needed to entirely initialize the IP
> > during future resume operation (patch 1).
> >
> > Then, reset GPIO, PHY and clock support are introduced (patch 2-4). As
> > current device trees do not provide the corresponding properties, not
> > finding one of these properties is not an error and just produces a
> > warning. However, if the property is present, an error during PHY
> > initialization will fail the probe of the driver.
> >
> > Note: To be sure the clock will be resumed before this driver, a first
> > series adding links between clocks and consumers has been submitted,
> > see [1]. Anyway, having the clock series applied first is not needed.
> >
> > Patch 5 adds suspend/resume hooks, re-using all the above.
> >
> > Finally, bindings and device trees are updated to reflect the hardware
> > (patch 6-12). While the clock depends on the SoC, the reset GPIO and
> > the PHY depends on the board so the clock is added in the
> > armada-37xx.dtsi file while the two other properties are added in
> > armada-3720-espressobin.dts.
> >
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-January/623885.html
> >
> > Thanks,
> > Miquèl
> >
> >
> > Changes since v2:
> > =================
> > * Minor patches reordering.
> > * Added pinctrl patches from Gregory Clement fixing the PCIe pins. His
> >   changes implied modifications in the DT/bindings patches adding PCIe
> >   reset pin support.  
> 
> Actually these patches are not in this series. You propably meant that
> this series is depend on these patches.
> 
> If needed, for peoaple who wanted to test this series, the pinctrl
> changes are now in linux-next and also in pinctrl/for-next.

Absolutely, this is what I meant, thanks for clarifying.

Thanks,
Miquèl
