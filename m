Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41091 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbbJVJE3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 Oct 2015 05:04:29 -0400
Message-ID: <1445504666.3173.20.camel@pengutronix.de>
Subject: Re: [PATCH v4 0/4] PCI: designware: LTSSM #define cleanup
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <festevam@gmail.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-pci@vger.kernel.org, pratyush.anand@gmail.com,
	m-karicheri2@ti.com
Date: Thu, 22 Oct 2015 11:04:26 +0200
In-Reply-To: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Am Mittwoch, den 21.10.2015, 13:42 -0500 schrieb Bjorn Helgaas:
> This is a revision of Fabio's series:
> http://lkml.kernel.org/r/1444664808-16445-1-git-send-email-festevam@gmail.com
> 
> Lucas, you reviewed the v3 patches, but I fiddled enough with this that I
> didn't want to blindly carry your review forward.  I don't *think* I
> changed anything substantive, but I might have missed something.
> 
I'm not sure if I like the removal of all the LTSSM state defines, as
not all reference manuals include them and so I liked to have the header
as a reference. But if you prefer to not carry unused defines in the
kernel I won't object strongly to the removal.

Otherwise the series looks fine, which you may take as a Reviewed-by.

Regards,
Lucas

> Changes since Fabio's v3:
>   - Split removal of spear unused #defines to separate patch
>   - Combine LTSSM_STATE_MASK definition and use changes in one patch
>   - Combine LTSSM_STATE_RCVRY_LOCK definition and use in one patch
>   - Use common LTSSM_STATE_L0 definition
> 
> ---
> 
> Bjorn Helgaas (1):
>       PCI: designware: Use common LTSSM_STATE_L0 definition
> 
> Fabio Estevam (3):
>       PCI: designware: Use common LTSSM_STATE_MASK definition
>       PCI: designware: Use common LTSSM_STATE_RCVRY_LOCK definition
>       PCI: spear: Remove unused #defines
> 
> 
>  drivers/pci/host/pci-imx6.c        |    3 +-
>  drivers/pci/host/pci-keystone-dw.c |    2 -
>  drivers/pci/host/pci-layerscape.c  |    4 +-
>  drivers/pci/host/pcie-designware.h |    4 ++
>  drivers/pci/host/pcie-spear13xx.c  |   70 ------------------------------------
>  5 files changed, 6 insertions(+), 77 deletions(-)

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

