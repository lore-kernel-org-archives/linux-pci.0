Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38721 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753752AbeGETki (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jul 2018 15:40:38 -0400
Received: by mail-qk0-f193.google.com with SMTP id y4-v6so5124460qka.5
        for <linux-pci@vger.kernel.org>; Thu, 05 Jul 2018 12:40:38 -0700 (PDT)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Shawn Guo'" <shawn.guo@linaro.org>
Cc: "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Pratyush Anand'" <pratyush.anand@gmail.com>,
        "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
        "'Jianguo Sun'" <sunjianguo1@huawei.com>,
        "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
        "'Jesper Nilsson'" <jesper.nilsson@axis.com>,
        "'Thomas Petazzoni'" <thomas.petazzoni@bootlin.com>,
        "'Murali Karicheri'" <m-karicheri2@ti.com>,
        "'Lucas Stach'" <l.stach@pengutronix.de>,
        <linux-pci@vger.kernel.org>
References: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org> <1530417291-30495-2-git-send-email-shawn.guo@linaro.org> <20180704162114.GC12996@red-moon>
In-Reply-To: <20180704162114.GC12996@red-moon>
Subject: Re: [PATCH v3 1/9] PCI: exynos: Drop unnecessary root_bus_nr setting
Date: Thu, 5 Jul 2018 15:40:35 -0400
Message-ID: <000601d41498$0bdcc7f0$239657d0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 4, 2018 12:21 PM, Lorenzo Pieralisi wrote:
> 
> On Sun, Jul 01, 2018 at 11:54:43AM +0800, Shawn Guo wrote:
> > Function dw_pcie_host_init() already initializes the root_bus_nr field
> > of 'struct pcie_port', so the -1 assignment prior to calling
> > dw_pcie_host_init() in platform specific driver is not really needed.
> > Drop it.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pci-exynos.c | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Jingoo we would need your ACK here, thanks.

I am not sure that this patch is good.
Currently, this patch does not make any problem.
However, I prefer to keep checking codes unless it makes a lot of burden.
This is because we cannot ensure that flow of codes will not change in the
future.
However, if you think that it can be ensured that the problem will not
happen
in the future, please merge this patch.

Best regards,
Jingoo Han

> 
> Lorenzo
> 
> > diff --git a/drivers/pci/controller/dwc/pci-exynos.c
> b/drivers/pci/controller/dwc/pci-exynos.c
> > index 4cc1e5df8c79..cee5f2f590e2 100644
> > --- a/drivers/pci/controller/dwc/pci-exynos.c
> > +++ b/drivers/pci/controller/dwc/pci-exynos.c
> > @@ -421,7 +421,6 @@ static int __init exynos_add_pcie_port(struct
> exynos_pcie *ep,
> >  		}
> >  	}
> >
> > -	pp->root_bus_nr = -1;
> >  	pp->ops = &exynos_pcie_host_ops;
> >
> >  	ret = dw_pcie_host_init(pp);
> > --
> > 1.9.1
> >
