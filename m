Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD1AC43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 11:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD992081B
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 11:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD992081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeK2WRV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:17:21 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57247 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeK2WRV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2018 17:17:21 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gSKEr-0008La-01; Thu, 29 Nov 2018 12:12:08 +0100
Message-ID: <1543489928.2507.59.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        Chris Healy <cphealy@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date:   Thu, 29 Nov 2018 12:12:08 +0100
In-Reply-To: <CAHQ1cqEGABcH3EG9yGo7Ns2fPR1s_u1YPtFoKRjUh50=aa=J2Q@mail.gmail.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
         <20181117181225.10737-4-andrew.smirnov@gmail.com>
         <ce2ac1a880ce2a7a39f0e42b5059676daa748e52.camel@nxp.com>
         <CAHQ1cqH6LT4GsxUchrmVG1m3fqawgyUjxdHvh=SzxhBiQOd8eg@mail.gmail.com>
         <1543313169.2507.39.camel@pengutronix.de>
         <VI1PR04MB5533DE497786CD80D4FE0941EED00@VI1PR04MB5533.eurprd04.prod.outlook.com>
         <CAHQ1cqEGABcH3EG9yGo7Ns2fPR1s_u1YPtFoKRjUh50=aa=J2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, den 27.11.2018, 13:14 -0800 schrieb Andrey Smirnov:
> On Tue, Nov 27, 2018 at 2:46 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > 
> > On 11/27/18 12:06 PM, Lucas Stach wrote:
> > > Hi Andrey,
> > > 
> > > Am Montag, den 26.11.2018, 10:24 -0800 schrieb Andrey Smirnov:
> > > > On Tue, Nov 20, 2018 at 2:49 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > > > > 
> > > > > On Sat, 2018-11-17 at 10:12 -0800, Andrey Smirnov wrote:
> > > > > > @@ -921,7 +1004,28 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > > > > > -     case IMX7D:
> > > > > > +     case IMX8MQ:
> > > > > > +             if (of_property_read_u32(node, "fsl,iomux-gpr1x",
> > > > > > +                                      &imx6_pcie->gpr1x)) {
> > > > > > +                     dev_err(dev, "Failed to get GPR1x address\n");
> > > > > > +                     return -EINVAL;
> > > > > > +             }
> > > > > 
> > > > > This is for distinguishing multiple controllers on the SOC but other
> > > > > registers and bits might differ. Isn't it preferable to have a property
> > > > > for controller id instead of adding many registers to DT?
> > > > 
> > > > I liked encoding necessary info in DT directly slightly better than
> > > > encoding abstract ID and then decoding it further in the driver code.
> > > > OTOH, I am not really attached to that path. Lucas, can you comment on
> > > > this please?
> > > 
> > > Yes, after rereading the patch with this in mind I agree that having
> > > the GPR offset on DT directly is IMO the better approach than an
> > > abstract ID.
> > 
> > But it's not a single offset, for example the device_type (EP/RC) has
> > bits for the two controllers side-by-side in GPR12.
> > 
> 
> Playing devil's advocate for a bit:
> 
> More specifically, currently the following per-controller bits need to
> be configured:
> 
> - Location of the "device type" field within GPR12
> - GPR register to use to control PCIn_CLKREQ_B_OVERRIDE_EN and
> PCIn_CLKREQ_B_OVERRIDE_EN (GPR14 vs GPR16)
> - Now that Philip spoke against PCIE_CTRL_APPS_CLK_REQ being exposed
> via reset controller driver, we need to know which SRC register to use
> to control that bit (SRC_PCIEPHY_RCR vs. SRC_PCIE2_RCR)

If if we need a lot of different GPR offsets, I revise my earlier
opinion. We certainly don't want lots of bit offsets and masks in the
DT. The whole GPR thing is ugly, but I would rather hide this in the
driver code, keyed by compatible and a controller id property, where we
can change things without any worries about DT backward compatibility.

Regards,
Lucas
