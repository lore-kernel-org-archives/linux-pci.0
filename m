Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7E2C282C3
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 09:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DF720879
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 09:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfAVJok (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:44:40 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36813 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbfAVJoj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jan 2019 04:44:39 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1glsbf-0006MS-Io; Tue, 22 Jan 2019 10:44:31 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1glsbe-0003Vh-HH; Tue, 22 Jan 2019 10:44:30 +0100
Date:   Tue, 22 Jan 2019 10:44:30 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Lukas F . Hartmann" <lukas@mntmn.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 1/2] PCI: imx: Fix probe failure without power domain
Message-ID: <20190122094430.rg76mkemz5wvk5t3@pengutronix.de>
References: <cover.1548110502.git.leonard.crestez@nxp.com>
 <375a852ae9170a5f8f53fdd364a7fb7ea642e89c.1548110502.git.leonard.crestez@nxp.com>
 <20190122071251.tgdwnunxksa45n5q@pengutronix.de>
 <VI1PR04MB5533DE236150B01461555A5BEE980@VI1PR04MB5533.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB5533DE236150B01461555A5BEE980@VI1PR04MB5533.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 22, 2019 at 09:17:22AM +0000, Leonard Crestez wrote:
> On 1/22/2019 9:12 AM, Uwe Kleine-König wrote:
> > On Mon, Jan 21, 2019 at 10:50:04PM +0000, Leonard Crestez wrote:
> >> On chips without a separate power domain for PCI (such as 6q/6qp) the
> >> imx6_pcie_attach_pd function incorrectly returns an error.
> >>
> >> Fix by returning 0 if dev_pm_domain_attach_by_name doesn't find
> >> anything.
> >>
> >> Fixes: 3f7cceeab895 ("PCI: imx: Add multi-pd support")
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> >> @@ -308,10 +308,13 @@ static int imx6_pcie_attach_pd(struct device *dev)
> >>   		return 0;
> >>   
> >>   	imx6_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
> >>   	if (IS_ERR(imx6_pcie->pd_pcie))
> >>   		return PTR_ERR(imx6_pcie->pd_pcie);
> >> +	/* Do nothing when power domain missing */
> >> +	if (!imx6_pcie->pd_pcie)
> >> +		return 0;
> > 
> > As I said in the mail that proposed this patch for testing: I think it
> > would be better to change dev_pm_domain_attach_by_name to not return an
> > error indication by returning NULL or an ERR_PTR value. (Or change
> > device_link_add to accept NULL if NULL is a dummy value.)
> > 
> > Just repeating it here to have it near the actual patch.
> 
> Link to that previous discussion: 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-January/626859.html
> 
> I'm not sure what you mean. Should dev_pm_domain_attach_by_name return 
> ERR_PTR(-ENOENT) for name not found? It would still require special 
> handling for callers.

Yes, callers would still need to handle an error, but they only need to
check for IS_ERR(retval) instead of IS_ERR(retval) && retval != NULL.

> The device_link_add function already returns NULL if the consumer or 
> supplier is NULL but that's also the only way it signals failure. Maybe 
> that function should be adjusted to return ERR_PTR instead?
> 
> Changing core API for a driver bug seems inappropriate.

Well, if the driver bug is there because the API is used in a wrong way
and the right way is strange, fixing the API and checking other users
for similar mistakes is the right thing to do.

> The current imx6_pcie_attach_pd code is complicated because it tries to 
> distinguish between "multi pd" and "no pd / single pd". I wish there was 
> a way for these PM_RUNTIME device_links to be setup automatically in 
> core and have multi-PD behave the same as a single PD.
> 
> There aren't many multi-PD users but commit 6494a9ad86de ("usb: xhci: 
> tegra: Add genpd support") seems to do pretty much the same thing.

I don't know enough about power domains to follow this argumentation in
the time I have available.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
