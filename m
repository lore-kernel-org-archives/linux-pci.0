Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B27C43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 08:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792C92054F
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 08:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeLSImA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:42:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53367 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbeLSIl7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Dec 2018 03:41:59 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CE01B20A82; Wed, 19 Dec 2018 09:41:56 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5F3A020BE1;
        Wed, 19 Dec 2018 09:41:10 +0100 (CET)
Date:   Wed, 19 Dec 2018 09:41:10 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Antoine =?UTF-8?B?VMOpbmFydA==?= 
        <antoine.tenart@free-electrons.com>,
        =?UTF-8?B?R3LDqWdvcnk=?= Clement 
        <gregory.clement@free-electrons.com>,
        =?UTF-8?B?TWlxdcOobA==?= Raynal 
        <miquel.raynal@free-electrons.com>, Victor Gu <xigu@marvell.com>
Subject: Re: [PATCH RFC v4.14] PCI: aadrvark: warm reset the cores and card
Message-ID: <20181219094110.5ab6aa84@xps13>
In-Reply-To: <20181119170948.GA30910@red-moon>
References: <20181024152056.17813-1-marek.behun@nic.cz>
        <20181119170948.GA30910@red-moon>
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

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote on Mon, 19 Nov
2018 17:09:48 +0000:

> On Wed, Oct 24, 2018 at 05:20:56PM +0200, Marek Behún wrote:
> > Add code to do a warm reset on the PHY and PCIE cores and if PERSTN GPIO
> > is specified in device tree (as reset-gpio), also reset the card.
> > 
> > The reset-gpio is inspired by what is done in U-Boot and linux-marvell,
> > and is not final version: I am hoping this can be done via a PCIe register
> > rather than GPIO - bit 3 of CTRL_WARM_RESET_REG register (which is added
> > by this patch) is called PERSTN_GPIO_EN (Enable PERSTN from GPIO) and
> > I think this is the right register, but manipulating this register did
> > not have any effect on the PERSTN pin, even when pinctrl was correctly set.

Are you sure pinctrl was correctly set? Because in the current state of
the pinctrl driver there is a mismatch in the registers layout. Gregory
Clement will send a patch soon about it but basically, when you use the
pin {func=pcie1,group=pcie}, the bit that is to be toggled is 5, not 4
(then the ptp bit is wrong, but this is a hot fix just for hour
situation):

--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -195,7 +195,7 @@ static struct armada_37xx_pin_group armada_37xx_sb_groups[] = {
        PIN_GRP_GPIO("usb2_drvvbus1", 1, 1, BIT(1), "drvbus"),
        PIN_GRP_GPIO("sdio_sb", 24, 6, BIT(2), "sdio"),
        PIN_GRP_GPIO("rgmii", 6, 12, BIT(3), "mii"),
-       PIN_GRP_GPIO("pcie1", 3, 2, BIT(4), "pcie"),
+       PIN_GRP_GPIO("pcie1", 3, 2, BIT(5), "pcie"),
        PIN_GRP_GPIO("ptp", 20, 3, BIT(5), "ptp"),
        PIN_GRP("ptp_clk", 21, 1, BIT(6), "ptp", "mii"),
        PIN_GRP("ptp_trig", 22, 1, BIT(7), "ptp", "mii"),

> > 
> > I asked Marvell about this and am awaiting their reply.
> > 
> > The reset-gpio is needed for Compex 5 GHz wifi card model WLE900VX. Without
> > this patch the PCIe link never comes up in kernel (although U-Boot pci
> > command was able to enumerate the card).
> > 
> > What is weird is that the link does not come up for this card when
> > pci-aardvark driver is probed in U-Boot. I haven't yet had time to discover
> > the problem there. My temporary solution is to compile out the pci-aardvark
> > driver from U-Boot.
> > 

[...]

> > If you have time, please try it with some PCIe cards and let me know
> > if they work correctly.  

While working on S2RAM, I checked how the reset pin works. I am on
EspressoBin so no reset GPIO available but the "internal" pin that is
controlled by the PCIe IP when "PERSTN_GPIO_EN" is set.

After hours of testing, I could not come with a working setup, it
seems like booting with any bit set in CTRL_WARM_RESET_REG leads to
unstable behavior. AFAIK Marvell BSP does not provide a working example
wrt this register.

Could you actually use it on your platform? I decided to drop the reset
patches from my series for now as it is not actually needed for S2RAM
feature, but it would be great to understand how this works.

Thanks,
Miquèl
