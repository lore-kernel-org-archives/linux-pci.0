Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57808 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbbGXIWu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2015 04:22:50 -0400
Message-ID: <1437726167.3071.43.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] PCI: imx6: Mark the msi cascade handler
 IRQF_NO_THREAD
From: Lucas Stach <l.stach@pengutronix.de>
To: Kevin Hao <haokexin@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Richard Zhu <Richard.Zhu@freescale.com>
Date: Fri, 24 Jul 2015 10:22:47 +0200
In-Reply-To: <20150724081917.GC29472@pek-khao-d1.corp.ad.wrs.com>
References: <1437715776-2243-1-git-send-email-haokexin@gmail.com>
	 <1437715776-2243-2-git-send-email-haokexin@gmail.com>
	 <1437724859.3071.40.camel@pengutronix.de>
	 <20150724081917.GC29472@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 24.07.2015, 16:19 +0800 schrieb Kevin Hao:
> On Fri, Jul 24, 2015 at 10:00:59AM +0200, Lucas Stach wrote:
> > Hi Kevin,
> > 
> > Am Freitag, den 24.07.2015, 13:29 +0800 schrieb Kevin Hao:
> > > The cascade handler must run in hard interrupt context, otherwise
> > > it will cause the following kernel warning if we force threading
> > > of all the interrupt handlers via kernel command parameter
> > > "threadirqs":
> > 
> > The change looks good, but there are a few other designware drivers that
> > use the same logic to trigger the cascaded MSI handler. Can you please
> > make sure to change them, too?
> 
> I have made the same change for the following drivers:
> Kevin Hao (4):
>   PCI: imx6: Mark the msi cascade handler IRQF_NO_THREAD
>   PCI: dra7xx: Mark the msi cascade handler IRQF_NO_THREAD
>   PCI: exynos: Mark the msi cascade handler IRQF_NO_THREAD
>   PCI: spear: Mark the msi cascade handler IRQF_NO_THREAD
> 
>  drivers/pci/host/pci-dra7xx.c     | 3 ++-
>  drivers/pci/host/pci-exynos.c     | 3 ++-
>  drivers/pci/host/pci-imx6.c       | 3 ++-
>  drivers/pci/host/pcie-spear13xx.c | 3 ++-
>  4 files changed, 8 insertions(+), 4 deletions(-)
> 
> Did I miss something?

Sorry, I did miss that the patch CC'ed to me was part of a series. I was
under the impression that such a trivial change could be done in one
patch for all drivers. But it's up to Bjorn to decide if he wants to
take this as individual patches.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

