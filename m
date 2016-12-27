Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:35243 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754785AbcL0NgT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2016 08:36:19 -0500
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Pankaj Dubey <pankaj.dubey@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        jingoohan1@gmail.com, Niyas Ahmed S T <niyas.ahmed@samsung.com>,
        krzk@kernel.org, jh80.chung@samsung.com, kgene@kernel.org,
        alim.akhtar@samsung.com, bhelgaas@google.com, sanath@samsung.com
Subject: Re: [PATCH] PCI: exynos: refactor exynos pcie driver
Date: Tue, 27 Dec 2016 14:35:54 +0100
Message-id: <3335251.c58Y1Zf7PB@amdc3058>
In-reply-to: <1482490587-13611-1-git-send-email-pankaj.dubey@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <CGME20161223105411epcas1p3727f726e757ec6c6d7bff04a9af40077@epcas1p3.samsung.com>
 <1482490587-13611-1-git-send-email-pankaj.dubey@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi,

On Friday, December 23, 2016 04:26:27 PM Pankaj Dubey wrote:
> From: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> 
> Currently Exynos PCIe driver is only supported for Exynos5440 SoC.
> This patch does refactoring of Exynos PCIe driver to extend support
> for other Exynos SoC.
> 
> Following are the main changes done via this patch:
> 1) It adds separate structs for memory, clock resources.
> 2) It add exynos_pcie_ops struct which will allow us to support the
> differences in resources in different Exynos SoC.
> 
> No functional change intended.
> 
> Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

I would also like to see the explanation for 1) (as already
requested by Jingoo).  Otherwise it all looks fine to me:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

