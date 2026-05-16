Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DB53E1681;
	Sat, 16 May 2026 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945849; cv=none; b=MY5VvGdfC+0Yo/M324mACXW8kJG5hTT1Ht260r71bPuyaKJc1rqZlZhuTTAht0JN30CU3zzNviDEZgrXuhReX7OX2kE38l9L7TWJdusnV7D0uDXU8PqRTUnKd2z6DjBRG609xPo5EsojtIxBF598YN/uuAu4S9r3l/y0fY06mMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945849; c=relaxed/simple;
	bh=xVMH3n7NRFYIPigyREaHQtmQL1K/uVZzkSPEzToAtlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZibRpa516S9pNUkqMvtpFkGh4gIAAOLDhAJY8jQhekjuJ3XltSopQwhrPfFcxaPhJyIODWGPSrn02nRM1GAo0PdHTTRP16abKVUVRrOe8viody1OBj3roj61rg11Z4dFqlrv8ry6kE8LS+Ctj1rW9AC5jOu9UTPRuCdcLtZjuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GI++QG0x; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GI++QG0x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Zj
	/PBTSQI0lK9i31CmFmrK/4+AXwZDcQLoEZ32R5WEk=; b=GI++QG0xeypFB2F913
	TejzxaAvcr4z0upzQzC2KRwoMY+7SIbw/JTTqKbwSKuf7SMMfXfp/Piv3PTWchct
	Ot/l9ZiNia/scmwrG4xR9H5XACKHl8QLKXWSuVdIKzXsiaBDTxs2+V5kxOkQD1Je
	9pgzMu7D1P65+CTEprgiC/feA=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3XzoajwhqfCYHBw--.40848S3;
	Sat, 16 May 2026 23:36:59 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	mani@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 1/3] PCI: Add common TLP type macros and convert aspeed/mediatek
Date: Sat, 16 May 2026 23:36:55 +0800
Message-Id: <20260516153657.65214-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516153657.65214-1-18255117159@163.com>
References: <20260516153657.65214-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3XzoajwhqfCYHBw--.40848S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wr15Zr4UWw1UZFykXr1fJFb_yoW7GF1fpr
	15JFWSvr1YqwsxAFn0qa1DJ3WrXFnIkFnrG3sI93y3Was3Ga4xCr4Fg3y5GwnxXr4IqryU
	Zw4jvw18GFnxKrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zCjgUcUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBuGKmoIjxug5AAA3B

Introduce a set of unified TLP type macros in pci.h according to PCIe
r7.0, sec 2.2.1:

  - PCIE_TLP_TYPE_MEM_RDWR   (0x00) for Memory Read/Write
  - PCIE_TLP_TYPE_IO_RDWR    (0x02) for I/O Read/Write
  - PCIE_TLP_TYPE_CFG0_RDWR  (0x04) for Type 0 Config Read/Write
  - PCIE_TLP_TYPE_CFG1_RDWR  (0x05) for Type 1 Config Read/Write
  - PCIE_TLP_TYPE_MSG        (0x10) for Message Request (routing to RC)

These replace the old per-driver hardcoded values or local macros, and
also replace the previous PCIE_TLP_TYPE_CFG0_RD/WR and
PCIE_TLP_TYPE_CFG1_RD/WR definitions which had identical numeric values.
The read/write distinction is already handled by the TLP Format field
(Fmt), so a single type macro suffices.

Convert the aspeed and mediatek drivers to use the new macros, and remove
the obsolete definitions from pci.h.

No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-aspeed.c   | 8 ++++----
 drivers/pci/controller/pcie-mediatek.c | 8 ++------
 drivers/pci/pci.h                      | 9 +++++----
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pcie-aspeed.c b/drivers/pci/controller/pcie-aspeed.c
index 6acfae7d026e..9aa9e14c6148 100644
--- a/drivers/pci/controller/pcie-aspeed.c
+++ b/drivers/pci/controller/pcie-aspeed.c
@@ -127,19 +127,19 @@
 #define CFG0_READ_FMTTYPE                                        \
 	FIELD_PREP(ASPEED_TLP_COMMON_FIELDS,                     \
 		   ASPEED_TLP_FMT_TYPE(PCIE_TLP_FMT_3DW_NO_DATA, \
-				       PCIE_TLP_TYPE_CFG0_RD))
+				       PCIE_TLP_TYPE_CFG0_RDWR))
 #define CFG0_WRITE_FMTTYPE                                    \
 	FIELD_PREP(ASPEED_TLP_COMMON_FIELDS,                  \
 		   ASPEED_TLP_FMT_TYPE(PCIE_TLP_FMT_3DW_DATA, \
-				       PCIE_TLP_TYPE_CFG0_WR))
+				       PCIE_TLP_TYPE_CFG0_RDWR))
 #define CFG1_READ_FMTTYPE                                        \
 	FIELD_PREP(ASPEED_TLP_COMMON_FIELDS,                     \
 		   ASPEED_TLP_FMT_TYPE(PCIE_TLP_FMT_3DW_NO_DATA, \
-				       PCIE_TLP_TYPE_CFG1_RD))
+				       PCIE_TLP_TYPE_CFG1_RDWR))
 #define CFG1_WRITE_FMTTYPE                                    \
 	FIELD_PREP(ASPEED_TLP_COMMON_FIELDS,                  \
 		   ASPEED_TLP_FMT_TYPE(PCIE_TLP_FMT_3DW_DATA, \
-				       PCIE_TLP_TYPE_CFG1_WR))
+				       PCIE_TLP_TYPE_CFG1_RDWR))
 #define CFG_PAYLOAD_SIZE		0x01 /* 1 DWORD */
 #define TLP_HEADER_BYTE_EN(x, y)	((GENMASK((x) - 1, 0) << ((y) % 4)))
 #define TLP_GET_VALUE(x, y, z)	\
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 75722524fe74..fda4658ba9f1 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -111,10 +111,6 @@
 #define APP_CFG_REQ		BIT(0)
 #define APP_CPL_STATUS		GENMASK(7, 5)
 
-#define CFG_WRRD_TYPE_0		4
-#define CFG_WR_FMT		2
-#define CFG_RD_FMT		0
-
 #define CFG_DW0_LENGTH(length)	((length) & GENMASK(9, 0))
 #define CFG_DW0_TYPE(type)	(((type) << 24) & GENMASK(28, 24))
 #define CFG_DW0_FMT(fmt)	(((fmt) << 29) & GENMASK(31, 29))
@@ -295,7 +291,7 @@ static int mtk_pcie_hw_rd_cfg(struct mtk_pcie_port *port, u32 bus, u32 devfn,
 	u32 tmp;
 
 	/* Write PCIe configuration transaction header for Cfgrd */
-	writel(CFG_HEADER_DW0(CFG_WRRD_TYPE_0, CFG_RD_FMT),
+	writel(CFG_HEADER_DW0(PCIE_TLP_TYPE_CFG0_RDWR, PCIE_TLP_FMT_3DW_NO_DATA),
 	       port->base + PCIE_CFG_HEADER0);
 	writel(CFG_HEADER_DW1(where, size), port->base + PCIE_CFG_HEADER1);
 	writel(CFG_HEADER_DW2(where, PCI_FUNC(devfn), PCI_SLOT(devfn), bus),
@@ -325,7 +321,7 @@ static int mtk_pcie_hw_wr_cfg(struct mtk_pcie_port *port, u32 bus, u32 devfn,
 			      int where, int size, u32 val)
 {
 	/* Write PCIe configuration transaction header for Cfgwr */
-	writel(CFG_HEADER_DW0(CFG_WRRD_TYPE_0, CFG_WR_FMT),
+	writel(CFG_HEADER_DW0(PCIE_TLP_TYPE_CFG0_RDWR, PCIE_TLP_FMT_3DW_DATA),
 	       port->base + PCIE_CFG_HEADER0);
 	writel(CFG_HEADER_DW1(where, size), port->base + PCIE_CFG_HEADER1);
 	writel(CFG_HEADER_DW2(where, PCI_FUNC(devfn), PCI_SLOT(devfn), bus),
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..23ad51e4c434 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -71,10 +71,11 @@ struct pcie_tlp_log;
 #define PCIE_TLP_FMT_4DW_DATA		0x03 /* 4DW header, with data */
 
 /* Type of TLP; PCIe r7.0, sec 2.2.1 */
-#define PCIE_TLP_TYPE_CFG0_RD		0x04 /* Config Type 0 Read Request */
-#define PCIE_TLP_TYPE_CFG0_WR		0x04 /* Config Type 0 Write Request */
-#define PCIE_TLP_TYPE_CFG1_RD		0x05 /* Config Type 1 Read Request */
-#define PCIE_TLP_TYPE_CFG1_WR		0x05 /* Config Type 1 Write Request */
+#define PCIE_TLP_TYPE_MEM_RDWR		0x00 /* Memory Read/Write Request */
+#define PCIE_TLP_TYPE_IO_RDWR		0x02 /* I/O Read/Write Request */
+#define PCIE_TLP_TYPE_CFG0_RDWR		0x04 /* Config Type 0 Read/Write Request */
+#define PCIE_TLP_TYPE_CFG1_RDWR		0x05 /* Config Type 1 Read/Write Request */
+#define PCIE_TLP_TYPE_MSG		0x10 /* Message With/Without data Request */
 
 /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
 #define PCIE_MSG_TYPE_R_RC	0
-- 
2.34.1

