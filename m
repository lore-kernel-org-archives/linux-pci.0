Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E00C18DF5
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 14:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9815D2075B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 14:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9815D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeKUBGd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:06:33 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39497 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeKUBGd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 20:06:33 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gP79C-0008KW-1b; Tue, 20 Nov 2018 15:37:02 +0100
Message-ID: <1542724621.2508.16.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] PCI: imx6: limit DBI register length
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Stefan Agner <stefan@agner.ch>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, tpiepho@impinj.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 20 Nov 2018 15:37:01 +0100
In-Reply-To: <20181120132705.6917-3-stefan@agner.ch>
References: <20181120132705.6917-1-stefan@agner.ch>
         <20181120132705.6917-3-stefan@agner.ch>
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

Am Dienstag, den 20.11.2018, 14:27 +0100 schrieb Stefan Agner:
> Define the length of the DBI registers. This makes sure that
> the kernel does not access registers beyond that point, avoiding
> the following abort on a i.MX 6Quad:
>   # cat /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
>   [  100.021433] Unhandled fault: imprecise external abort (0x1406) at 0xb6ea7000
>   ...
>   [  100.056423] PC is at dw_pcie_read+0x50/0x84
>   [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
>   ...
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 7ac1a639fe91..41d6127b40ad 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -41,6 +41,7 @@ enum imx6_pcie_variants {
>  
>  struct imx6_pcie_drvdata {
> >  	enum imx6_pcie_variants variant;
> > > +	int			dbi_length;
>  };
>  
>  struct imx6_pcie {
> @@ -779,6 +780,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  		break;
> >  	}
>  
> > +	pci->dbi_length = imx6_pcie->drvdata->dbi_length;
> +
> >  	/* Grab GPR config register range */
> >  	imx6_pcie->iomuxc_gpr =
> >  		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> @@ -839,7 +842,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  }
>  
>  static const struct imx6_pcie_drvdata drvdata[] = {
> > -	[IMX6Q] = { .variant = IMX6Q },
> > +	[IMX6Q] = { .variant = IMX6Q, .dbi_length = 0x15c },
> >  	[IMX6SX] = { .variant = IMX6SX },
> >  	[IMX6QP] = { .variant = IMX6QP },
> >  	[IMX7D] = { .variant = IMX7D },
