Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:22407 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab3JNAJI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Oct 2013 20:09:08 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MUM008KOTR67UA0@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 14 Oct 2013 09:09:06 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Wei Yongjun' <weiyj.lk@gmail.com>
Cc: 'Shawn Guo' <shawn.guo@linaro.org>,
	'Grant Likely' <grant.likely@linaro.org>,
	'Rob Herring' <rob.herring@calxeda.com>, xobs@kosagi.com,
	'Sascha Hauer' <s.hauer@pengutronix.de>,
	'Wei Yongjun' <yongjun_wei@trendmicro.com.cn>,
	linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <CAPgLHd-M6y2VkZv_TWkOqugXnu=NgFuxyBVskd-2fQjy79u61g@mail.gmail.com>
 <20131012081130.GG21305@S2101-09.ap.freescale.net>
In-reply-to: <20131012081130.GG21305@S2101-09.ap.freescale.net>
Subject: Re: [PATCH -next] PCI: imx6: remove redundant dev_err call in
 imx6_pcie_probe()
Date: Mon, 14 Oct 2013 09:09:05 +0900
Message-id: <000601cec871$9892f2f0$c9b8d8d0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, October 12, 2013 5:12 PM, Shawn Guo wrote:
> On Sat, Oct 12, 2013 at 02:11:02PM +0800, Wei Yongjun wrote:
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >
> > There is a error message within devm_ioremap_resource
> > already, so remove the dev_err call to avoid redundant
> > error message.
> >
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> 
> > ---
> >  drivers/pci/host/pci-imx6.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > index 5afa922..51338ac 100644
> > --- a/drivers/pci/host/pci-imx6.c
> > +++ b/drivers/pci/host/pci-imx6.c
> > @@ -439,7 +439,6 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
> >
> >  	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
> >  	if (IS_ERR(pp->dbi_base)) {
> > -		dev_err(&pdev->dev, "unable to remap dbi_base\n");
> >  		ret = PTR_ERR(pp->dbi_base);
> >  		goto err;
> >  	}

