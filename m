Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:42944 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750845AbdAPGbn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2017 01:31:43 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH V3 0/5] PCI: exynos: cleans the minor things
Date: Mon, 16 Jan 2017 15:31:33 +0900
Message-id: <20170116063138.25805-1-jh80.chung@samsung.com>
References: <CGME20170116063140epcas5p38fffe5effdcfd2650cad98c25c31335e@epcas5p3.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current pci-exynos.c is used for only EXYNOS5440.
It's too complex to support the other Exynos SoCs.
Before supporting the other Exynos SoCs, it needs to clean the codes.

Changelog on V3:
- Splits "PCI: exynos: replace to one register accessor from each accessors"

Changelog on V2:
- Changes the all pointer names as "ep" instead of "exynos_pcie"

Jaehoon Chung (5):
  PCI: exynos: Rename all pointer names from "exynos_pcie" to "ep"
  PCI: exynos: Replace the *_blk/*_phy/*_elb accessors
  PCI: exynos: Remove the unnecessary variables
  PCI: exynos: Use the bitops API to operate the bit shifting
  PCI: exynos: remove the duplicated codes

 drivers/pci/host/pci-exynos.c | 392 +++++++++++++++++++-----------------------
 1 file changed, 181 insertions(+), 211 deletions(-)

-- 
2.10.2

