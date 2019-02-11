Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC187C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 12:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CC8218D8
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 12:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfBKMSQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:18:16 -0500
Received: from foss.arm.com ([217.140.101.70]:46718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfBKMSQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 07:18:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC5CA80D;
        Mon, 11 Feb 2019 04:18:15 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98F3E3F557;
        Mon, 11 Feb 2019 04:18:14 -0800 (PST)
Date:   Mon, 11 Feb 2019 12:18:04 +0000
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
Message-ID: <20190211121804.GA19106@e107981-ln.cambridge.arm.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
 <20190205001721.18639-4-tpiepho@impinj.com>
 <20190207123132.GA21111@e107981-ln.cambridge.arm.com>
 <1549563351.3075.49.camel@impinj.com>
 <20190208101802.GA13009@e107981-ln.cambridge.arm.com>
 <1549649949.3075.79.camel@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549649949.3075.79.camel@impinj.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 08, 2019 at 06:19:10PM +0000, Trent Piepho wrote:
> On Fri, 2019-02-08 at 10:18 +0000, Lorenzo Pieralisi wrote:
> > On Thu, Feb 07, 2019 at 06:15:52PM +0000, Trent Piepho wrote:
> > > On Thu, 2019-02-07 at 12:31 +0000, Lorenzo Pieralisi wrote:
> > > > +			/* De-assert DCC_FB_EN */
> > > > > +			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
> > > > > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG4);
> > > > > +			/* Assert RX_EQS and RX_EQS_SEL */
> > > > > +			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
> > > > > +				| PCIE_PHY_CMN_REG24_RX_EQ,
> > > > > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG24);
> > > > > +			/* Assert ATT_MODE */
> > > > > +			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
> > > > > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG26);
> > > > > +		} else {
> > > > > +			dev_warn(dev, "DT lacks imx7d-pcie-phy, unable to apply ERR010728 workaround\n");
> > > > 
> > > > It is a nit but the warning log is not necessarily true ie you may not
> > > > have a mapped address for other reasons as well. It is up to you but I
> > > > would change the log message.
> > > 
> > > True, but I hardly want to enumerate every possible failure point in a
> > > log message.  How about:
> > > 
> > > Unable to apply ERR010728 workaround.  DT lacks imx7d-pcie-phy?
> > 
> > I would just log "Unable to apply ERR010728 workaround" but it is up
> > to you. I can make the change myself with no need for reposting.
> 
> I was following Lucas's comment on the v1 version:
> 
>    the user. It would be better to have something like "No access to
>    PHY registers, can't apply workaround for ERR010728." Maybe even
>    with a hint to update the DT.
> 
> I think the pretty much the only way any of the errors conditions will
> get hit, is when someone with an old DT runs a new kernel.  So the hint
> about the DT change might be actually useful to some users.
> 
> But it's not a big deal so just change it to whatever when applying the
> patch.

Applied the series to pci/dwc for v5.1, please have a look to check
if we are in agreement (slightly tweaked the log string), thanks.

Lorenzo
