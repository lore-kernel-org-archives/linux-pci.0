Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35676 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbcLZNxC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Dec 2016 08:53:02 -0500
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Bartlomiej Zolnierkiewicz'" <b.zolnierkie@samsung.com>,
        "'Jaehoon Chung'" <jh80.chung@samsung.com>
Cc: <linux-pci@vger.kernel.org>, <helgaas@google.com>,
        <krzk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <javier@osg.samsung.com>, <kgene@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
References: <20161219081614.5403-1-jh80.chung@samsung.com> <4494696.ZtEANGFldV@amdc3058>
In-Reply-To: <4494696.ZtEANGFldV@amdc3058>
Subject: Re: [PATCH 0/4] PCI: exynos: cleans the minor things
Date: Mon, 26 Dec 2016 08:52:58 -0500
Message-ID: <000001d25f7f$5f0d2cf0$1d2786d0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, December 20, 2016 12:36 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Monday, December 19, 2016 05:16:10 PM Jaehoon Chung wrote:
> > Current pci-exnoys.c is used for only EXYNOS5440.
> > Even if there is no use-case, just cleans the codes for maintaining.
> >
> > In future, I will upstream for Exynso5433(TM2).
> > Before sending patches for exynos5433, i want to reuse the some codse in
> pic-exynos.c.
> > This patch is for perparing it.
> >
> > My Final goal is to apply the pcie-exynos5433 into v4.11.
> >
> > Jaehoon Chung (4):
> >   PCI: exynos: replace to one register accessor from each accessors
> >   PCI: exynos: Remove the unnecessary variables
> >   PCI: exynos: Use the bitops API to operate the bit shifting
> >   PCI: exynos: remove the duplicated codes
> >
> >  drivers/pci/host/pci-exynos.c | 260 +++++++++++++++++++----------------
> -------
> >  1 file changed, 116 insertions(+), 144 deletions(-)
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics


