Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB4AC04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 22:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EDB20851
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 22:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EDB20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbeLCWS6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:18:58 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34451 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbeLCWS6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 17:18:58 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C9D6620791; Mon,  3 Dec 2018 23:18:55 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id BDCEC207AD;
        Mon,  3 Dec 2018 23:18:44 +0100 (CET)
Date:   Mon, 3 Dec 2018 23:18:44 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        sudeep.holla@arm.com,
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
Message-ID: <20181203231844.0791bdee@xps13>
In-Reply-To: <1999610.6DN9RK2Tt3@aspire.rjw.lan>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
        <20181203102708.GA6090@e107981-ln.cambridge.arm.com>
        <20181203163846.494904f9@xps13>
        <1999610.6DN9RK2Tt3@aspire.rjw.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael, Stephen,

"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote on Mon, 03 Dec 2018
23:00:20 +0100:

> On Monday, December 3, 2018 4:38:46 PM CET Miquel Raynal wrote:
> > Hi Lorenzo,
> > 
> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote on Mon, 3 Dec 2018
> > 10:27:08 +0000:
> >   
> > > [+Rafael, Sudeep]
> > > 
> > > On Fri, Nov 23, 2018 at 03:18:24PM +0100, Miquel Raynal wrote:  
> > > > Add suspend and resume callbacks. The priority of these are
> > > > "_noirq()", to workaround early access to the registers done by the
> > > > PCI core through the ->read()/->write() callbacks at resume time.
> > > > 
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  drivers/pci/controller/pci-aardvark.c | 52 +++++++++++++++++++++++++++
> > > >  1 file changed, 52 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > > index 108b3f15c410..7ecf1ac4036b 100644
> > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > @@ -1108,6 +1108,55 @@ static int advk_pcie_setup_clk(struct advk_pcie *pcie)
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +static int __maybe_unused advk_pcie_suspend(struct device *dev)
> > > > +{
> > > > +	struct advk_pcie *pcie = dev_get_drvdata(dev);
> > > > +
> > > > +	advk_pcie_disable_phy(pcie);
> > > > +
> > > > +	clk_disable_unprepare(pcie->clk);    
> > > 
> > > I have noticed it is common practice, still, I would like to check whether
> > > it is allowed to call functions that may sleep in a NOIRQ suspend/resume
> > > callback ?  
> > 
> > You are right this is weird. I double checked and for instance,
> > pcie-mediatek.c, pci-tegra.c and pci-imx6.c do the exact same thing. There are
> > probably other cases where drivers call functions that may sleep from a NOIRQ
> > context. I am interested to know if this is valid and if not, what is the
> > alternative?
> >   
> 
> Yes, it is valid.  _noirq means that the high-level action handlers will not be
> invoked for interrupts occurring during that period, but that doesn't apply to
> timer interrupts.
> 
> IOW, don't expect *your* IRQ handler to be invoked then (if this is not a timer
> IRQ), but you can sleep.
> 
> Thanks,
> Rafael
> 

Thank you both for the enlightenment.


Thanks,
Miquèl
