Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36100 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932728AbcLSIRn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2016 03:17:43 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: helgaas@google.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/4] PCI: exynos: cleans the minor things
Date: Mon, 19 Dec 2016 17:17:36 +0900
Message-id: <20161219081740.5457-1-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current pci-exnoys.c is used for only EXYNOS5440.
Even if there is no use-case, just cleans the codes for maintaining.

In future, I will upstream for Exynso5433(TM2).
Before sending patches for exynos5433, i want to reuse the some codse in pic-exynos.c.
This patch is for perparing it.

My Final goal is to apply the pcie-exynos5433 into v4.11.

Jaehoon Chung (4):
  PCI: exynos: replace to one register accessor from each accessors
  PCI: exynos: Remove the unnecessary variables
  PCI: exynos: Use the bitops API to operate the bit shifting
  PCI: exynos: remove the duplicated codes

 drivers/pci/host/pci-exynos.c | 260 +++++++++++++++++++-----------------------
 1 file changed, 116 insertions(+), 144 deletions(-)

-- 
2.10.2

