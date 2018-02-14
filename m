Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43970 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031247AbeBNPcS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Feb 2018 10:32:18 -0500
Date: Wed, 14 Feb 2018 15:32:11 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: kdinh@apm.com, Bjorn Helgaas <bhelgaas@google.com>, dhdang@apm.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene: Fix the error return code
Message-ID: <20180214153211.GA13711@e107981-ln.cambridge.arm.com>
References: <1513730309-18831-1-git-send-email-festevam@gmail.com>
 <20171220121438.GB1709@red-moon>
 <CAOMZO5CwQwxeuaswRHmgY=KA8o8-Zidz0N5tVFhtn9iZJqqh=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5CwQwxeuaswRHmgY=KA8o8-Zidz0N5tVFhtn9iZJqqh=A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 13, 2018 at 11:45:15PM -0200, Fabio Estevam wrote:
> Khuong Dinh, Lorenzo,
> 
> On Wed, Dec 20, 2017 at 10:14 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > [+ Khuong Dinh]
> >
> > On Tue, Dec 19, 2017 at 10:38:29PM -0200, Fabio Estevam wrote:
> >> In the case of IS_ERR() error, we should return PTR_ERR().
> >>
> >> Fix the error return code.
> >>
> >> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> >> ---
> >>  drivers/pci/host/pci-xgene-msi.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > I am about to apply this patch, please let me know if you see
> > any issue with that.
> 
> A gente ping.

Applied to pci/xgene for v4.17, sorry for the delay.

Lorenzo

> > Thanks,
> > Lorenzo
> >
> >> diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
> >> index 1f42a20..4a1fb01 100644
> >> --- a/drivers/pci/host/pci-xgene-msi.c
> >> +++ b/drivers/pci/host/pci-xgene-msi.c
> >> @@ -465,7 +465,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
> >>       xgene_msi->msi_regs = devm_ioremap_resource(&pdev->dev, res);
> >>       if (IS_ERR(xgene_msi->msi_regs)) {
> >>               dev_err(&pdev->dev, "no reg space\n");
> >> -             rc = -EINVAL;
> >> +             rc = PTR_ERR(xgene_msi->msi_regs);
> >>               goto error;
> >>       }
> >>       xgene_msi->msi_addr = res->start;
> >> --
> >> 2.7.4
> >>
