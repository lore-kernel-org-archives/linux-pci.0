Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAFDC64EB8
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 17:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A1321479
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 17:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A1321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeJEACT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:02:19 -0400
Received: from foss.arm.com ([217.140.101.70]:40364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbeJEACT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Oct 2018 20:02:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E76567A9;
        Thu,  4 Oct 2018 10:08:09 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74B823F5B3;
        Thu,  4 Oct 2018 10:08:07 -0700 (PDT)
Date:   Thu, 4 Oct 2018 18:08:02 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
Message-ID: <20181004170802.GA12234@e107981-ln.cambridge.arm.com>
References: <cover.1538670431.git.leonard.crestez@nxp.com>
 <c3a7dfd1395b12e170393a3da77e0d1602b9f542.1538670431.git.leonard.crestez@nxp.com>
 <1538671621.14153.20.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538671621.14153.20.camel@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 04, 2018 at 06:47:01PM +0200, Philipp Zabel wrote:
> Hi Leonard,
> 
> On Thu, 2018-10-04 at 16:34 +0000, Leonard Crestez wrote:
> > This is required for the imx pci driver to send the PME_Turn_Off TLP.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/reset/reset-imx7.c             | 1 +
> >  include/dt-bindings/reset/imx7-reset.h | 4 +++-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> > index 97d9f08271c5..77911fa8f31d 100644
> > --- a/drivers/reset/reset-imx7.c
> > +++ b/drivers/reset/reset-imx7.c
> > @@ -65,10 +65,11 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
> >  	[IMX7_RESET_MIPI_PHY_MRST]	= { SRC_MIPIPHY_RCR, BIT(1) },
> >  	[IMX7_RESET_MIPI_PHY_SRST]	= { SRC_MIPIPHY_RCR, BIT(2) },
> >  	[IMX7_RESET_PCIEPHY]		= { SRC_PCIEPHY_RCR, BIT(2) | BIT(1) },
> >  	[IMX7_RESET_PCIEPHY_PERST]	= { SRC_PCIEPHY_RCR, BIT(3) },
> >  	[IMX7_RESET_PCIE_CTRL_APPS_EN]	= { SRC_PCIEPHY_RCR, BIT(6) },
> > +	[IMX7_RESET_PCIE_CTRL_APPS_TURNOFF] = { SRC_PCIEPHY_RCR, BIT(11) },
> >  	[IMX7_RESET_DDRC_PRST]		= { SRC_DDRC_RCR, BIT(0) },
> >  	[IMX7_RESET_DDRC_CORE_RST]	= { SRC_DDRC_RCR, BIT(1) },
> >  };
> >  
> >  static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
> > diff --git a/include/dt-bindings/reset/imx7-reset.h b/include/dt-bindings/reset/imx7-reset.h
> > index 63948170c7b2..31b3f87dde9a 100644
> > --- a/include/dt-bindings/reset/imx7-reset.h
> > +++ b/include/dt-bindings/reset/imx7-reset.h
> > @@ -54,9 +54,11 @@
> >   */
> >  #define IMX7_RESET_PCIE_CTRL_APPS_EN	22
> >  #define IMX7_RESET_DDRC_PRST		23
> >  #define IMX7_RESET_DDRC_CORE_RST	24
> >  
> > -#define IMX7_RESET_NUM			25
> > +#define IMX7_RESET_PCIE_CTRL_APPS_TURNOFF 25
> > +
> > +#define IMX7_RESET_NUM			26
> >  
> >  #endif
> 
> This is contained enough to be merged with the rest of the series,
> patches 1 and 2:
> 
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Let me know if I should pick them up instead.

I can take the whole series but I would like to have it rebased against
v4.19-rc4 please since it does not apply as it is, thanks.

Lorenzo
