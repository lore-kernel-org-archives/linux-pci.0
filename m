Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC38C04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 19:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2225C214E0
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 19:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0QI9psdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2225C214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbeLCTT2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLCTT2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 14:19:28 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7453D20848;
        Mon,  3 Dec 2018 19:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543864763;
        bh=loEs24ZyMoNpy+gMXQJBM7jI49KannDP3YHy75Z7URI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=0QI9psdXLbnDJstfNoLdBl4aGNAlhaStszy0pkD/ATX/7QarrlIKH4bPG9feQ7FJx
         BwQFn1UbmF7ajle++cjD4jET4lFnc2kQ9dY7JGf4XAKHgGH9cddMRjVkpV69trptoG
         BeF6feuT7a+qYYIzZfpJjDSr+oaUpI1mW5HiryRE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181203171859.GA12792@e107981-ln.cambridge.arm.com>
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
        Nadav Haklai <nadavh@marvell.com>,
        Michael Turquette <mturquette@baylibre.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181123141831.8214-6-miquel.raynal@bootlin.com>
 <20181203102708.GA6090@e107981-ln.cambridge.arm.com>
 <20181203163846.494904f9@xps13>
 <20181203171859.GA12792@e107981-ln.cambridge.arm.com>
Message-ID: <154386476279.88331.4767594304261181833@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
Date:   Mon, 03 Dec 2018 11:19:22 -0800
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Lorenzo Pieralisi (2018-12-03 09:18:59)
> [+Stephen, Mike]
> =

> On Mon, Dec 03, 2018 at 04:38:46PM +0100, Miquel Raynal wrote:
> > Hi Lorenzo,
> > =

> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote on Mon, 3 Dec 2018
> > 10:27:08 +0000:
> > =

> > > [+Rafael, Sudeep]
> > > =

> > > On Fri, Nov 23, 2018 at 03:18:24PM +0100, Miquel Raynal wrote:
> > > > Add suspend and resume callbacks. The priority of these are
> > > > "_noirq()", to workaround early access to the registers done by the
> > > > PCI core through the ->read()/->write() callbacks at resume time.
> > > > =

> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  drivers/pci/controller/pci-aardvark.c | 52 +++++++++++++++++++++++=
++++
> > > >  1 file changed, 52 insertions(+)
> > > > =

> > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/co=
ntroller/pci-aardvark.c
> > > > index 108b3f15c410..7ecf1ac4036b 100644
> > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > @@ -1108,6 +1108,55 @@ static int advk_pcie_setup_clk(struct advk_p=
cie *pcie)
> > > >   return ret;
> > > >  }
> > > >  =

> > > > +static int __maybe_unused advk_pcie_suspend(struct device *dev)
> > > > +{
> > > > + struct advk_pcie *pcie =3D dev_get_drvdata(dev);
> > > > +
> > > > + advk_pcie_disable_phy(pcie);
> > > > +
> > > > + clk_disable_unprepare(pcie->clk);  =

> > > =

> > > I have noticed it is common practice, still, I would like to check wh=
ether
> > > it is allowed to call functions that may sleep in a NOIRQ suspend/res=
ume
> > > callback ?
> > =

> > You are right this is weird. I double checked and for instance,
> > pcie-mediatek.c, pci-tegra.c and pci-imx6.c do the exact same thing.
> > There are probably other cases where drivers call functions that may
> > sleep from a NOIRQ context. I am interested to know if this is valid
> > and if not, what is the alternative?
> =

> I added Stephen and Mike, who along with Rafael can help us shed some
> light into this, I do not have the necessary bits of info myself, I just
> noticed.
> =


Is the noirq phase of system suspend run with irqs disabled? Or just run
with the device irqs disabled? I thought it was the latter, which is
fine for this scenario because it's still running in a schedulable
context.

