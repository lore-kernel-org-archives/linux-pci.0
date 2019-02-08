Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562F5C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 10:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F6621924
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 10:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfBHKSK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:18:10 -0500
Received: from foss.arm.com ([217.140.101.70]:47966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfBHKSK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 05:18:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D012B1596;
        Fri,  8 Feb 2019 02:18:09 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA1913F557;
        Fri,  8 Feb 2019 02:18:07 -0800 (PST)
Date:   Fri, 8 Feb 2019 10:18:02 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe
 PLL failure
Message-ID: <20190208101802.GA13009@e107981-ln.cambridge.arm.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
 <20190205001721.18639-4-tpiepho@impinj.com>
 <20190207123132.GA21111@e107981-ln.cambridge.arm.com>
 <1549563351.3075.49.camel@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549563351.3075.49.camel@impinj.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 07, 2019 at 06:15:52PM +0000, Trent Piepho wrote:
> On Thu, 2019-02-07 at 12:31 +0000, Lorenzo Pieralisi wrote:
> > +			/* De-assert DCC_FB_EN */
> > > +			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
> > > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG4);
> > > +			/* Assert RX_EQS and RX_EQS_SEL */
> > > +			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
> > > +				| PCIE_PHY_CMN_REG24_RX_EQ,
> > > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG24);
> > > +			/* Assert ATT_MODE */
> > > +			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
> > > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG26);
> > > +		} else {
> > > +			dev_warn(dev, "DT lacks imx7d-pcie-phy, unable to apply ERR010728 workaround\n");
> > 
> > It is a nit but the warning log is not necessarily true ie you may not
> > have a mapped address for other reasons as well. It is up to you but I
> > would change the log message.
> 
> True, but I hardly want to enumerate every possible failure point in a
> log message.  How about:
> 
> Unable to apply ERR010728 workaround.  DT lacks imx7d-pcie-phy?

I would just log "Unable to apply ERR010728 workaround" but it is up
to you. I can make the change myself with no need for reposting.

Lorenzo
