Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36561 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754200AbdJIQU0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2017 12:20:26 -0400
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Pankaj Dubey'" <pankaj.dubey@samsung.com>
Cc: "'linux-pci'" <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Anvesh Salveru'" <anvesh.s@samsung.com>
References: <CGME20171009141438epcas2p4ead7e2f2d1af7e0950f2c026e3a9943b@epcas2p4.samsung.com> <1507558478-3218-1-git-send-email-pankaj.dubey@samsung.com> <CAJKOXPeC=cS2cvAXHrKuK5F4tEqH6PppwYkxC+Z8+5D--48CAg@mail.gmail.com>
In-Reply-To: <CAJKOXPeC=cS2cvAXHrKuK5F4tEqH6PppwYkxC+Z8+5D--48CAg@mail.gmail.com>
Subject: Re: [PATCH] PCI: exynos: remove redundant code in exynos_pcie_establish_link
Date: Mon, 9 Oct 2017 12:20:23 -0400
Message-ID: <000a01d3411a$82eea770$88cbf650$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, October 9, 2017 10:44 AM, Krzysztof Kozlowski wrote:
> 
> On Mon, Oct 9, 2017 at 4:14 PM, Pankaj Dubey <pankaj.dubey@samsung.com>
> wrote:
> > From: Anvesh Salveru <anvesh.s@samsung.com>
> >
> > In exynos_pcie_establish_link if driver is not using generic phy,
> > we are resetting PHY twice, which is redundant, so this patch removes
> 
> Hi Pankaj,
> 
> This lacks the information why it is redundant.

(I resend this mail, because email address of pci list was corrupted.)

I think so, too.

Did you test this code on some boards with Exynos PCIe?
Or did hardware engineers confirm this?
Please add more information on this patch.

Best regards,
Jingoo Han

> 
> > repeated lines of code for PHY reset.
> >
> > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> 
> Your Signed-off-by is needed here.
> 
> Best regards,
> Krzysztof
> 
> > ---
> >  drivers/pci/dwc/pci-exynos.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
> > index 5596fde..85d2f4b 100644
> > --- a/drivers/pci/dwc/pci-exynos.c
> > +++ b/drivers/pci/dwc/pci-exynos.c
> > @@ -423,13 +423,6 @@ static int exynos_pcie_establish_link(struct
> exynos_pcie *ep)
> >                 exynos_pcie_deassert_phy_reset(ep);
> >                 exynos_pcie_power_on_phy(ep);
> >                 exynos_pcie_init_phy(ep);
> > -
> > -               /* pulse for common reset */
> > -               exynos_pcie_writel(ep->mem_res->block_base, 1,
> > -                                       PCIE_PHY_COMMON_RESET);
> > -               udelay(500);
> > -               exynos_pcie_writel(ep->mem_res->block_base, 0,
> > -                                       PCIE_PHY_COMMON_RESET);
> >         }
> >
> >         /* pulse for common reset */
> > --
> > 2.7.4
> >
