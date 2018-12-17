Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6145C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 14:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916D7206A2
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 14:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeLQObx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:31:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57041 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbeLQObx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 09:31:53 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ADBEB2074F; Mon, 17 Dec 2018 15:31:50 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 468AD20711;
        Mon, 17 Dec 2018 15:31:40 +0100 (CET)
Date:   Mon, 17 Dec 2018 15:31:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v2 10/12] ARM64: dts: marvell: armada-3720-espressobin:
 declare PCIe reset GPIO
Message-ID: <20181217153140.6d51b9f3@xps13>
In-Reply-To: <20181213153619.499aab66@windsurf>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
        <20181212102142.16053-11-miquel.raynal@bootlin.com>
        <20181213153306.4fc3b511@xps13>
        <20181213153619.499aab66@windsurf>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote on Thu, 13 Dec
2018 15:36:19 +0100:

> Hello,
> 
> On Thu, 13 Dec 2018 15:33:06 +0100, Miquel Raynal wrote:
> 
> > I will re-send a series without this patch. I think it does not hurt to
> > keep the previous patch adding the pinmux setting in the
> > Armada-37xx.dtsi file even without using it, so I will drop only this
> > patch.  
> 
> I tend to disagree here (but perhaps you'll have other arguments to
> convince me otherwise): the GPIO used for PCIe reset is a completely
> board-specific thing. You can chose whatever GPIO you want, and each
> board can be different. Therefore, there is no reason to have such a
> pinmux configuration at the SoC level (.dtsi), it should be within the
> particular board that uses that pinmux configuration.
> 
> This is a rule that we have applied to mvebu platforms in general, and
> which I believe is fairly common in many DTs.

Actually this is a pin that may be driven directly by the PCI IP and is
not board-specific (note that the patch is wrong as the functions
should be "pcie" instead of "gpio"). What is board specific is if this
pin is actually wired to the endpoint PCIe card or not.

Anyway, as seen by Gregory, the pinctrl driver must be fixed as when
selecting the "pcie1" group, the driver was poking another area making
the EspressoBin switch unstable. With a quick fix on my side I realized
the reset was not behaving at all as expected. As it is not actually
needed for suspend/resume operation (at least on my setup) I will drop
the 'reset pin' related patches in the next iteration of the series.


Thanks,
Miquèl
