Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1F0C04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 15:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C91208A3
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 15:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C91208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeLCPix convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:38:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43722 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbeLCPix (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 10:38:53 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E06C72072A; Mon,  3 Dec 2018 16:38:46 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 702282037D;
        Mon,  3 Dec 2018 16:38:46 +0100 (CET)
Date:   Mon, 3 Dec 2018 16:38:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, sudeep.holla@arm.com,
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
Message-ID: <20181203163846.494904f9@xps13>
In-Reply-To: <20181203102708.GA6090@e107981-ln.cambridge.arm.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
        <20181123141831.8214-6-miquel.raynal@bootlin.com>
        <20181203102708.GA6090@e107981-ln.cambridge.arm.com>
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

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote on Mon, 3 Dec 2018
10:27:08 +0000:

> [+Rafael, Sudeep]
> 
> On Fri, Nov 23, 2018 at 03:18:24PM +0100, Miquel Raynal wrote:
> > Add suspend and resume callbacks. The priority of these are
> > "_noirq()", to workaround early access to the registers done by the
> > PCI core through the ->read()/->write() callbacks at resume time.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 52 +++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 108b3f15c410..7ecf1ac4036b 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -1108,6 +1108,55 @@ static int advk_pcie_setup_clk(struct advk_pcie *pcie)
> >  	return ret;
> >  }
> >  
> > +static int __maybe_unused advk_pcie_suspend(struct device *dev)
> > +{
> > +	struct advk_pcie *pcie = dev_get_drvdata(dev);
> > +
> > +	advk_pcie_disable_phy(pcie);
> > +
> > +	clk_disable_unprepare(pcie->clk);  
> 
> I have noticed it is common practice, still, I would like to check whether
> it is allowed to call functions that may sleep in a NOIRQ suspend/resume
> callback ?

You are right this is weird. I double checked and for instance,
pcie-mediatek.c, pci-tegra.c and pci-imx6.c do the exact same thing. There are
probably other cases where drivers call functions that may sleep from a NOIRQ
context. I am interested to know if this is valid and if not, what is the
alternative?


Thanks,
Miquèl
