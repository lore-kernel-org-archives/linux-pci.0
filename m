Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50409 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbcLTRgA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2016 12:36:00 -0500
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, helgaas@google.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, jingoohan1@gmail.com,
        javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI: exynos: cleans the minor things
Date: Tue, 20 Dec 2016 18:35:56 +0100
Message-id: <4494696.ZtEANGFldV@amdc3058>
In-reply-to: <20161219081614.5403-1-jh80.chung@samsung.com>
References: <20161219081614.5403-1-jh80.chung@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi,

On Monday, December 19, 2016 05:16:10 PM Jaehoon Chung wrote:
> Current pci-exnoys.c is used for only EXYNOS5440.
> Even if there is no use-case, just cleans the codes for maintaining.
> 
> In future, I will upstream for Exynso5433(TM2).
> Before sending patches for exynos5433, i want to reuse the some codse in pic-exynos.c.
> This patch is for perparing it.
> 
> My Final goal is to apply the pcie-exynos5433 into v4.11.
> 
> Jaehoon Chung (4):
>   PCI: exynos: replace to one register accessor from each accessors
>   PCI: exynos: Remove the unnecessary variables
>   PCI: exynos: Use the bitops API to operate the bit shifting
>   PCI: exynos: remove the duplicated codes
> 
>  drivers/pci/host/pci-exynos.c | 260 +++++++++++++++++++-----------------------
>  1 file changed, 116 insertions(+), 144 deletions(-)

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

