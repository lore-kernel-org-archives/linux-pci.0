Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575B376467
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228510; cv=none; b=sIc8RsOvzJPzMJ7pkxOIAa0sRnGcTqJom/msqbd8keyzAjPHdDm09/78tfsqyvOvhvWESIhsPvw45w7ZyNN7tuklvn+rINI55uKmSbv2Vu0JqmKiEtRM8T/YEK1NHM3m16CkCLuF5NItkVtSHyQlREqLabDp+bgSOy7zYauIqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228510; c=relaxed/simple;
	bh=zxqBjMhSSVpB89dg/Rjmf328WU9161TGP2hwu6q5bLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ismRiK8jqdju/v/175pjCQoJZYBqRmy31sRncfHbWRS66esJHpcvNnQC/vgSgvjl0QJnIt2YXjdikScp1TFGM6H2vXM8KXsyWyWpSdjeZl40SCgz8zLHWnLkMU/cgXrLN/q1TM0CTfrZRqbFSkjGWtgf032CZGfDpvobAS57Pa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EbXaJVOr; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EbXaJVOr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778228500; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=hO2PElEIjMvpVRGSGcJtlqbivWyXHypCmbZD2jxc3YE=;
	b=EbXaJVOrCpjqs0X9CuHUGNrKt2hkl5z4kf7a1zWnTnkxpWYYvlBIX+jCzpzLaC0M+RppS8nWjb7PMiQMXDwz9N7wD8W3H1JNU6CWa0r0sDZtJhkQy1oNqqWukNYbsx+3NMMU7J6DwCe84EZ6Vxy5CoqOw51cYH0w1aVU6bcqD1U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X2WlMZ8_1778228494;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X2WlMZ8_1778228494 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 16:21:39 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v12 1/2] PCI: Introduce named defines for PCI ROM
Date: Fri,  8 May 2026 16:21:27 +0800
Message-ID: <20260508082128.3344255-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260508082128.3344255-1-kanie@linux.alibaba.com>
References: <20260508082128.3344255-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the magic numbers associated with PCI ROM into named
definitions. Some of these definitions will be used in the second
fix patch.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/rom.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index e18d3a4383ba..d4a141bd148b 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -5,13 +5,28 @@
  * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
  * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
  */
+
+#include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/pci.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 
 #include "pci.h"
 
+#define PCI_ROM_HEADER_SIZE			0x1A
+#define PCI_ROM_POINTER_TO_DATA_STRUCT		0x18
+#define PCI_ROM_LAST_IMAGE_INDICATOR		0x15
+#define PCI_ROM_LAST_IMAGE_INDICATOR_BIT	BIT(7)
+#define PCI_ROM_IMAGE_LEN			0x10
+#define PCI_ROM_IMAGE_SECTOR_SIZE		SZ_512
+#define PCI_ROM_IMAGE_SIGNATURE			0xAA55
+
+/* Data structure signature is "PCIR" in ASCII representation */
+#define PCI_ROM_DATA_STRUCT_SIGNATURE		0x52494350
+#define PCI_ROM_DATA_STRUCT_LEN			0x0A
+
 /**
  * pci_enable_rom - enable ROM decoding for a PCI device
  * @pdev: PCI device to enable
@@ -91,26 +106,27 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
 	do {
 		void __iomem *pds;
 		/* Standard PCI ROMs start out with these bytes 55 AA */
-		if (readw(image) != 0xAA55) {
-			pci_info(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
-				 readw(image));
+		if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
+			pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
+				 PCI_ROM_IMAGE_SIGNATURE, readw(image));
 			break;
 		}
-		/* get the PCI data structure and check its "PCIR" signature */
-		pds = image + readw(image + 24);
-		if (readl(pds) != 0x52494350) {
-			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
-				 readl(pds));
+		/* Get the PCI data structure and check its "PCIR" signature */
+		pds = image + readw(image + PCI_ROM_POINTER_TO_DATA_STRUCT);
+		if (readl(pds) != PCI_ROM_DATA_STRUCT_SIGNATURE) {
+			pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
+				 PCI_ROM_DATA_STRUCT_SIGNATURE, readl(pds));
 			break;
 		}
-		last_image = readb(pds + 21) & 0x80;
-		length = readw(pds + 16);
-		image += length * 512;
+		last_image = readb(pds + PCI_ROM_LAST_IMAGE_INDICATOR) &
+				   PCI_ROM_LAST_IMAGE_INDICATOR_BIT;
+		length = readw(pds + PCI_ROM_IMAGE_LEN);
+		image += length * PCI_ROM_IMAGE_SECTOR_SIZE;
 		/* Avoid iterating through memory outside the resource window */
 		if (image >= rom + size)
 			break;
 		if (!last_image) {
-			if (readw(image) != 0xAA55) {
+			if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
 				pci_info(pdev, "No more image in the PCI ROM\n");
 				break;
 			}
-- 
2.43.7

