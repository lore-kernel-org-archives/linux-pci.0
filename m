Received: from shmail.montage-tech.com (shmail.montage-tech.com [180.167.85.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8273D47C8;
	Sun, 16 Aug 2026 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.167.85.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786871148; cv=none; b=rH30G3O7pPyZ1XZJOCFEHb2LQzyHn3kqauFeesyxtA8nUulNYf2oG1i/hXalkdqg2FUBb//X/wSN+2ImTWl2SfLj9NDkL4zM7bJnPuMKQ3dEheQicLSMpzbUZZLW3LoetOIB0QDPvtbejqOhmkaAG3Py+d2v9bDD16qfnvgqNm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786871148; c=relaxed/simple;
	bh=xkywXsfP0xfZ+BDgVXdgGTS8VtX4VNzH7ltaFntkgVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfBqkv3NA+0ZosaE/OY983XSx8sfRiv77fnhsH7L7H3HmZrQmH7Xgsp/6YFUx5P3gSbtJYRS1BYvGgUgg9sCiJoICkBF3ij2JtqjqMo8NpuX+Lsk24y8F3CpDF8vPjNh2zruyJtDoYqqLdffksMwEEFOcRGSHzbi93YYSAmtY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=montage-tech.com; spf=pass smtp.mailfrom=montage-tech.com; dkim=pass (1024-bit key) header.d=montage-tech.com header.i=@montage-tech.com header.b=DoxP/otO; arc=none smtp.client-ip=180.167.85.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=montage-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=montage-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=montage-tech.com header.i=@montage-tech.com header.b="DoxP/otO"
Received: from exchmail.montage-tech.com ([10.8.192.33])
	by shmail.montage-tech.com  with ESMTPS id 67G8o0pA003757-67G8o0pC003757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 16 Aug 2026 16:50:00 +0800
Received: from mongtage-NF5468M6.montage-tech.com (10.8.98.235) by
 shexch1.montage-tech.com (10.8.192.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sun, 16 Aug 2026 16:49:58 +0800
From: <peng.guo@montage-tech.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bhelgaas@google.com>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>,
	<johnny.li@montage-tech.com>, <jingzhong.yang@montage-tech.com>,
	<engguopeng@buaa.edu.cn>, pguo <peng.guo@montage-tech.com>
Subject: [PATCH 1/2] PCI: Add MMIO Capabilities Register Block definitions
Date: Sun, 16 Aug 2026 16:49:56 +0800
Message-ID: <20260816084957.3316727-2-peng.guo@montage-tech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260816084957.3316727-1-peng.guo@montage-tech.com>
References: <20260816084957.3316727-1-peng.guo@montage-tech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: shexch2.montage-tech.com (10.8.192.34) To
 shexch1.montage-tech.com (10.8.192.33)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFw8JVpdWFhYXlhaSFpdSBgNBg9GDx0HKAUHBhwJDw1FHA0LAEYLBwVIWUhaXUgEAQYdEEULEAQoHg8NGkYDDRoGDQRGBxoPSFhIWkhZWUhZWEZQRllRWkZbW0hQSFhIWEheSFhIWEhYSFpeSAkEARsHBkYbCwAHDgENBAwoAQYcDQRGCwcFSFhIWVFICgANBA8JCRsoDwcHDwQNRgsHBUhYSFlfSAwJHg0oGxwPBwQJChtGBg0cSFhIWV1IDAIKHygDDRoGDQRGBxoPSFhIWlpIDQYPDx0HGA0GDygKHQkJRg0MHUYLBkhYSFpdSAQBBh0QRQsQBCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 10.8.192.33
X-FE-Policy-ID: 6:5:2:montage-tech.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=montage-tech.com; s=shmail; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=rOCzAl1EPaXdMG1w4tAJLzowFMHmQGFVv2SnmyRS/ow=;
 b=DoxP/otOyfBGnx34BdgQLPKyo4O3nbS4F4riDlN1dP5fKkKlcVXBesPTC5kNGJF+8s+nxp9ipNRv
	N6C6BM1IendkNdarDKfmIaeRaDwlYaiInh8vxcrVIEquuS2gfREimTGd42ybm3jzN4ncYiKocM1R
	2zlURMLNj9TztXRoUqM=

From: pguo <peng.guo@montage-tech.com>

The PCIe Management Message Passthrough via MMIO Mailbox ECN defines
the MMIO Capabilities Register Block (MCAP). MCAP contains an array
header followed by capability headers that describe the ID, version,
location, size, and vendor of each MMIO capability.

Add definitions for the MCAP array and capability headers so that
subsystem drivers can distinguish capabilities with overlapping IDs
by using the Vendor ID field.

Signed-off-by: pguo <peng.guo@montage-tech.com>
---
 include/uapi/linux/pci_regs.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350..5fe6bc711526 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1338,6 +1338,27 @@
 #define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
 #define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
 
+/* MMIO Capabilities Register Block (MCAP) */
+#define PCI_MCAP_ARRAY_1		0x00
+#define  PCI_MCAP_ARRAY_ID		__GENMASK(15, 0)
+#define  PCI_MCAP_ARRAY_VERSION		__GENMASK(23, 16)
+#define  PCI_MCAP_ARRAY_TYPE		__GENMASK(27, 24)
+#define  PCI_MCAP_ARRAY_TYPE_CLASS_CODE	0x0
+#define PCI_MCAP_ARRAY_2		0x04
+#define  PCI_MCAP_ARRAY_COUNT		__GENMASK(15, 0)
+
+#define PCI_MCAP_HDR_SIZEOF		0x10
+#define PCI_MCAP_HDR_BASE(n)		((n) * PCI_MCAP_HDR_SIZEOF)
+#define PCI_MCAP_HDR_REG_1		0x00
+#define  PCI_MCAP_CAP_ID		__GENMASK(15, 0)
+#define  PCI_MCAP_CAP_VERSION		__GENMASK(23, 16)
+#define PCI_MCAP_HDR_REG_2		0x04
+#define  PCI_MCAP_HDR_OFFSET		__GENMASK(31, 0)
+#define PCI_MCAP_HDR_REG_3		0x08
+#define  PCI_MCAP_HDR_LENGTH		__GENMASK(31, 0)
+#define PCI_MCAP_HDR_REG_4		0x0c
+#define  PCI_MCAP_HDR_VENDOR_ID		__GENMASK(15, 0)
+
 /*
  * Compute Express Link (CXL r4.0, sec 8.1)
  *
-- 
2.43.0

