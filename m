Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:58934 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbaANWcD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 17:32:03 -0500
From: Jingoo Han <jg1.han@samsung.com>
To: 'Marek Vasut' <marex@denx.de>, 'Wolfram Sang' <wsa@the-dreams.de>,
	'Fabio Estevam' <fabio.estevam@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	'Richard Zhu' <r65037@freescale.com>,
	linux-pci@vger.kernel.org, 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Shawn Guo' <shawn.guo@linaro.org>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1389700739-3696-1-git-send-email-wsa@the-dreams.de>
 <1389700739-3696-4-git-send-email-wsa@the-dreams.de>
 <201401141417.03349.marex@denx.de>
In-reply-to: <201401141417.03349.marex@denx.de>
Subject: Re: [PATCH 4/7] drivers/pci/host: don't check resource with
 devm_ioremap_resource
Date: Wed, 15 Jan 2014 07:32:01 +0900
Message-id: <001701cf1178$7191ec10$54b5c430$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, January 14, 2014 10:17 PM, Marek Vasut wrote:
> On Tuesday, January 14, 2014 at 12:58:55 PM, Wolfram Sang wrote:
> > devm_ioremap_resource does sanity checks on the given resource. No need to
> > duplicate this in the driver.
> >
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> 
> True that,
> 
> Acked-by: Marek Vasut <marex@denx.de>

(+cc Fabio Estevam)

Hi all,

The same patch was already sent by Fabio Estevam a month ago.[1]
Also, it was applied to pci/next tree.[2]

[1] http://www.spinics.net/lists/linux-pci/msg26873.html
[2] http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=next&id=ebb034a4ce9fc37877b3df2b85b9c33d43349586

Best regards,
Jingoo Han

> 
> > ---
> >
> > Should go via subsystem tree
> >
> >  drivers/pci/host/pci-imx6.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > index bd70af8..5002e23 100644
> > --- a/drivers/pci/host/pci-imx6.c
> > +++ b/drivers/pci/host/pci-imx6.c
> > @@ -426,11 +426,6 @@ static int __init imx6_pcie_probe(struct
> > platform_device *pdev) "imprecise external abort");
> >
> >  	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	if (!dbi_base) {
> > -		dev_err(&pdev->dev, "dbi_base memory resource not found\n");
> > -		return -ENODEV;
> > -	}
> > -
> >  	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
> >  	if (IS_ERR(pp->dbi_base)) {
> >  		ret = PTR_ERR(pp->dbi_base);
> 
> Best regards,
> Marek Vasut

