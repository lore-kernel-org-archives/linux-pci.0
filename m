Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33422 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753029AbeGFJSZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Jul 2018 05:18:25 -0400
Date: Fri, 6 Jul 2018 10:20:14 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jingoo Han <jingoohan1@gmail.com>
Cc: 'Shawn Guo' <shawn.guo@linaro.org>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Pratyush Anand' <pratyush.anand@gmail.com>,
        'Stanimir Varbanov' <svarbanov@mm-sol.com>,
        'Jianguo Sun' <sunjianguo1@huawei.com>,
        'Joao Pinto' <Joao.Pinto@synopsys.com>,
        'Jesper Nilsson' <jesper.nilsson@axis.com>,
        'Thomas Petazzoni' <thomas.petazzoni@bootlin.com>,
        'Murali Karicheri' <m-karicheri2@ti.com>,
        'Lucas Stach' <l.stach@pengutronix.de>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/9] PCI: exynos: Drop unnecessary root_bus_nr setting
Message-ID: <20180706092013.GA14176@red-moon>
References: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
 <1530417291-30495-2-git-send-email-shawn.guo@linaro.org>
 <20180704162114.GC12996@red-moon>
 <000601d41498$0bdcc7f0$239657d0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000601d41498$0bdcc7f0$239657d0$@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 05, 2018 at 03:40:35PM -0400, Jingoo Han wrote:
> On Wednesday, July 4, 2018 12:21 PM, Lorenzo Pieralisi wrote:
> > 
> > On Sun, Jul 01, 2018 at 11:54:43AM +0800, Shawn Guo wrote:
> > > Function dw_pcie_host_init() already initializes the root_bus_nr field
> > > of 'struct pcie_port', so the -1 assignment prior to calling
> > > dw_pcie_host_init() in platform specific driver is not really needed.
> > > Drop it.
> > >
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-exynos.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > 
> > Jingoo we would need your ACK here, thanks.
> 
> I am not sure that this patch is good.
> Currently, this patch does not make any problem.  However, I prefer to
> keep checking codes unless it makes a lot of burden.  This is because
> we cannot ensure that flow of codes will not change in the future.

If the call flow changes in the future we will have to make changes
anyway since there are bits and pieces of struct pcie_port that are
initialized in dw_pcie_host_init(). Maybe I do not understand your
concern, for the time being Shawn is removing useless code AFAICS.

Lorenzo

> However, if you think that it can be ensured that the problem will not
> happen in the future, please merge this patch.
> 
> Best regards,
> Jingoo Han
> 
> > 
> > Lorenzo
> > 
> > > diff --git a/drivers/pci/controller/dwc/pci-exynos.c
> > b/drivers/pci/controller/dwc/pci-exynos.c
> > > index 4cc1e5df8c79..cee5f2f590e2 100644
> > > --- a/drivers/pci/controller/dwc/pci-exynos.c
> > > +++ b/drivers/pci/controller/dwc/pci-exynos.c
> > > @@ -421,7 +421,6 @@ static int __init exynos_add_pcie_port(struct
> > exynos_pcie *ep,
> > >  		}
> > >  	}
> > >
> > > -	pp->root_bus_nr = -1;
> > >  	pp->ops = &exynos_pcie_host_ops;
> > >
> > >  	ret = dw_pcie_host_init(pp);
> > > --
> > > 1.9.1
> > >
> 
