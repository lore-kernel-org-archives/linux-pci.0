Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D2FC282C3
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 07:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91346205C9
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 07:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfAVHMz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:12:55 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60815 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfAVHMz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jan 2019 02:12:55 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1glqEu-0005ki-8J; Tue, 22 Jan 2019 08:12:52 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1glqEt-00072w-Lr; Tue, 22 Jan 2019 08:12:51 +0100
Date:   Tue, 22 Jan 2019 08:12:51 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Lukas F . Hartmann" <lukas@mntmn.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] PCI: imx: Fix probe failure without power domain
Message-ID: <20190122071251.tgdwnunxksa45n5q@pengutronix.de>
References: <cover.1548110502.git.leonard.crestez@nxp.com>
 <375a852ae9170a5f8f53fdd364a7fb7ea642e89c.1548110502.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <375a852ae9170a5f8f53fdd364a7fb7ea642e89c.1548110502.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 21, 2019 at 10:50:04PM +0000, Leonard Crestez wrote:
> On chips without a separate power domain for PCI (such as 6q/6qp) the
> imx6_pcie_attach_pd function incorrectly returns an error.
> 
> Fix by returning 0 if dev_pm_domain_attach_by_name doesn't find
> anything.
> 
> Fixes: 3f7cceeab895 ("PCI: imx: Add multi-pd support")
> Reported-by: Lukas F.Hartmann <lukas@mntmn.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 52e47dac028f..ac5f6ae0b254 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -308,10 +308,13 @@ static int imx6_pcie_attach_pd(struct device *dev)
>  		return 0;
>  
>  	imx6_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
>  	if (IS_ERR(imx6_pcie->pd_pcie))
>  		return PTR_ERR(imx6_pcie->pd_pcie);
> +	/* Do nothing when power domain missing */
> +	if (!imx6_pcie->pd_pcie)
> +		return 0;

As I said in the mail that proposed this patch for testing: I think it
would be better to change dev_pm_domain_attach_by_name to not return an
error indication by returning NULL or an ERR_PTR value. (Or change
device_link_add to accept NULL if NULL is a dummy value.)

Just repeating it here to have it near the actual patch.

Best regards
Uwe

>  	link = device_link_add(dev, imx6_pcie->pd_pcie,
>  			DL_FLAG_STATELESS |
>  			DL_FLAG_PM_RUNTIME |
>  			DL_FLAG_RPM_ACTIVE);
>  	if (!link) {
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
