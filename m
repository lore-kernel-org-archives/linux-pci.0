Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:34531 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab3ILL3Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2013 07:29:25 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene@kernel.org>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] MAINTAINERS: add maintainer entry for Samsung Exynos PCIe
 driver
Date: Thu, 12 Sep 2013 20:29:24 +0900
Message-id: <000001ceafab$5529e340$ff7da9c0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add myself as maintainer for Samsung Exynos PCIe driver.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d0dabe..f00c469 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6346,6 +6346,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
 F:	drivers/pci/host/pci-tegra.c
 
+PCI DRIVER FOR SAMSUNG EXYNOS
+M:	Jingoo Han <jg1.han@samsung.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	drivers/pci/host/pci-exynos.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia@lists.infradead.org
-- 
1.7.10.4


