Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37050221F39
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228512; cv=none; b=IDzeMAVT6hs1h8i9qT0MbA6FuZJALhv1i1/xE6BsJ+lDUcXH7bEHN3ekh6ZelEgHMvIs5zzgSlZByScBWqpQvZ6oRbU76zZj1ofOe2sUbu2XfiQ1KETxJQ8AA90y8FBgSXDeDAr7SXIN6G+1YPDaqrAxZr4QgZ4GRtOGOeaRcoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228512; c=relaxed/simple;
	bh=V3h4GANUuWozhDK+uvj1J1Ryvja7twnUcXsVZFRh0dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/RofQC/CpjBuNxpQzmcjL39t/jBnxwzr3LhHQyuGEUjeq3djHetCjLE0fYYxncZRSYZr1dUcsW1dn27dcPZ/2D1xiFgT7GlFqg40OOhh8wcl5ytezgZTGYfPZweCL+Yk3RG4QOov8djzVEFxZrRqvKDXmq07kKOyndtrY+nzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x11/5k0G; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x11/5k0G"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778228504; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mcMIv8qaWKZuq2oCWwsjDndEyMqehlPDhIppWbr0hL8=;
	b=x11/5k0GaivZU1q7GgDoK8gM6gZNfoiK789qXKNj97V2OZLAvuvP8Th1ciLjU26KjSzYBeuADbyz0P3Iwv4ed8WvjqAsHFWAK+RfPG728IcK3rkmyyvuT3WE66S5rpvld+VvtDwYy7locewdgw5d7q8YJ3WFZkCsSYQxY1N9OFw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X2Wne7b_1778228499;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X2Wne7b_1778228499 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 16:21:44 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v12 2/2] PCI: Check ROM header and data structure addr before accessing
Date: Fri,  8 May 2026 16:21:28 +0800
Message-ID: <20260508082128.3344255-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260508082128.3344255-1-kanie@linux.alibaba.com>
References: <20260508082128.3344255-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We meet a crash when running stress-ng on x86_64 machine:

  BUG: unable to handle page fault for address: ffa0000007f40000
  RIP: 0010:pci_get_rom_size+0x52/0x220
  Call Trace:
  <TASK>
    pci_map_rom+0x80/0x130
    pci_read_rom+0x4b/0xe0
    kernfs_file_read_iter+0x96/0x180
    vfs_read+0x1b1/0x300

Our analysis reveals that the ROM space's start address is
0xffa0000007f30000, and size is 0x10000. Because of broken ROM
space, before calling readl(pds), the pds's value is
0xffa0000007f3ffff, which is already pointed to the ROM space
end, invoking readl() would read 4 bytes therefore cause an
out-of-bounds access and trigger a crash.
Fix this by adding image header and data structure checking.

We also found another crash on arm64 machine:

  Unable to handle kernel paging request at virtual address
ffff8000dd1393ff
  Mem abort info:
  ESR = 0x0000000096000021
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x21: alignment fault

The call trace is the same with x86_64, but the crash reason is
that the data structure addr is not aligned with 4, and arm64
machine report "alignment fault". Fix this by adding alignment
checking.

Fixes: 47b975d234ea ("PCI: Avoid iterating through memory outside the resource window")
Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/pci/rom.c | 128 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 110 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index d4a141bd148b..9744f1a2923a 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -6,9 +6,12 @@
  * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
  */
 
+#include <linux/align.h>
 #include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/io.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -27,6 +30,16 @@
 #define PCI_ROM_DATA_STRUCT_SIGNATURE		0x52494350
 #define PCI_ROM_DATA_STRUCT_LEN			0x0A
 
+/*
+ * Per PCI Local Bus Spec 2.x / PCI Firmware Spec r3.3 sec 5.1.3
+ * Table 5-2, a conformant PCI Data Structure is at least 24 bytes
+ * (0x18), large enough to cover every fixed field this driver
+ * reads (up to the Indicator byte at offset 0x15).  Reject smaller
+ * device-claimed lengths so the follow-up readers in
+ * pci_get_rom_size() cannot escape the mapped ROM window.
+ */
+#define PCI_ROM_DATA_STRUCT_MIN_LEN		0x18
+
 /**
  * pci_enable_rom - enable ROM decoding for a PCI device
  * @pdev: PCI device to enable
@@ -84,6 +97,95 @@ void pci_disable_rom(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_disable_rom);
 
+static bool pci_rom_is_header_valid(struct pci_dev *pdev,
+				    void __iomem *image,
+				    void __iomem *rom,
+				    size_t size,
+				    bool expect_valid)
+{
+	unsigned long rom_end = (unsigned long)rom + size - 1;
+	unsigned long header_end;
+	u16 signature;
+
+	/*
+	 * Per PCI Firmware Specification r3.3, sec 5.1, each image must
+	 * start on a 512-byte boundary and must contain the PCI Expansion
+	 * ROM header.  Because @rom is page-aligned (returned by ioremap()),
+	 * checking 512-byte alignment of @image is equivalent to enforcing
+	 * the spec's sector-aligned layout within the ROM.  This also
+	 * satisfies the natural-alignment requirement of readw() on archs
+	 * such as arm64 that disallow unaligned IOMEM access.
+	 */
+	if (!IS_ALIGNED((unsigned long)image, PCI_ROM_IMAGE_SECTOR_SIZE))
+		return false;
+
+	if (check_add_overflow((unsigned long)image, PCI_ROM_HEADER_SIZE - 1,
+				&header_end))
+		return false;
+
+	if (image < rom || header_end > rom_end)
+		return false;
+
+	/* Standard PCI ROMs start out with these bytes 55 AA */
+	signature = readw(image);
+	if (signature != PCI_ROM_IMAGE_SIGNATURE) {
+		if (expect_valid) {
+			pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
+				 PCI_ROM_IMAGE_SIGNATURE, signature);
+		} else {
+			pci_info(pdev, "No more image in the PCI ROM\n");
+		}
+		return false;
+	}
+
+	return true;
+}
+
+static bool pci_rom_is_data_struct_valid(struct pci_dev *pdev,
+					 void __iomem *pds,
+					 void __iomem *rom,
+					 size_t size)
+{
+	unsigned long rom_end = (unsigned long)rom + size - 1;
+	unsigned long end;
+	u32 signature;
+	u16 data_len;
+
+	/*
+	 * Some CPU architectures require IOMEM access addresses to
+	 * be aligned, for example arm64, so since we're about to
+	 * call readl(), we check here for 4-byte alignment.
+	 */
+	if (!IS_ALIGNED((unsigned long)pds, 4))
+		return false;
+
+	if (check_add_overflow((unsigned long)pds, PCI_ROM_DATA_STRUCT_LEN + 1,
+				&end))
+		return false;
+
+	if (pds < rom || end > rom_end)
+		return false;
+
+	signature = readl(pds);
+	if (signature != PCI_ROM_DATA_STRUCT_SIGNATURE) {
+		pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
+			 PCI_ROM_DATA_STRUCT_SIGNATURE, signature);
+		return false;
+	}
+
+	data_len = readw(pds + PCI_ROM_DATA_STRUCT_LEN);
+	if (data_len < PCI_ROM_DATA_STRUCT_MIN_LEN || data_len == U16_MAX)
+		return false;
+
+	if (check_add_overflow((unsigned long)pds, data_len - 1, &end))
+		return false;
+
+	if (end > rom_end)
+		return false;
+
+	return true;
+}
+
 /**
  * pci_get_rom_size - obtain the actual size of the ROM image
  * @pdev: target PCI device
@@ -99,38 +201,28 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
 			       size_t size)
 {
 	void __iomem *image;
-	int last_image;
 	unsigned int length;
+	bool last_image;
 
 	image = rom;
 	do {
 		void __iomem *pds;
-		/* Standard PCI ROMs start out with these bytes 55 AA */
-		if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
-			pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
-				 PCI_ROM_IMAGE_SIGNATURE, readw(image));
+		if (!pci_rom_is_header_valid(pdev, image, rom, size, true))
 			break;
-		}
+
 		/* Get the PCI data structure and check its "PCIR" signature */
 		pds = image + readw(image + PCI_ROM_POINTER_TO_DATA_STRUCT);
-		if (readl(pds) != PCI_ROM_DATA_STRUCT_SIGNATURE) {
-			pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
-				 PCI_ROM_DATA_STRUCT_SIGNATURE, readl(pds));
+		if (!pci_rom_is_data_struct_valid(pdev, pds, rom, size))
 			break;
-		}
+
 		last_image = readb(pds + PCI_ROM_LAST_IMAGE_INDICATOR) &
 				   PCI_ROM_LAST_IMAGE_INDICATOR_BIT;
 		length = readw(pds + PCI_ROM_IMAGE_LEN);
 		image += length * PCI_ROM_IMAGE_SECTOR_SIZE;
-		/* Avoid iterating through memory outside the resource window */
-		if (image >= rom + size)
+
+		if (!last_image &&
+		    !pci_rom_is_header_valid(pdev, image, rom, size, false))
 			break;
-		if (!last_image) {
-			if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
-				pci_info(pdev, "No more image in the PCI ROM\n");
-				break;
-			}
-		}
 	} while (length && !last_image);
 
 	/* never return a size larger than the PCI resource window */
-- 
2.43.7

