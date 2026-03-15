Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A6036F42E;
	Sun, 15 Mar 2026 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773589247; cv=none; b=ofct6FiFklYgtmQDgk+/zzEj3N+i1Lc3lp9ZMV2XfL6Qk48Qay3K1Njde2iX+N60MwHGz03Wk8Md3cXPG8z4zmKg6FzeCnbCeSM+poAKYZbvC5UDxj6jjna59LXI69tIlcSASZEddr6usGAbAlyClNBg349egT2jusrpSer7ynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773589247; c=relaxed/simple;
	bh=tLwwATaOHHazmeAE+UXJmqf7cNq6oF88RIRsYLV8Ppw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ak7arRgK5+8BJY3QHygMttR7+LM/db5Hol2klXZBSesBShe7OZTvMerzRc3fp79wgRkdCcv+C/xt2OpE7zN/UOsk5I+l/dipKe71KzXGc6ACUaNHRw+It9E/b+WOg7i1tPaORtTBWV7ef4ahiNszOfNSnFJkfrJz/CfANEYvK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QOE/sCKA; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QOE/sCKA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yK
	UVVhUjlpkGQZk0KJLfVIc0IIh4GAYVDGZzZ/R+NVA=; b=QOE/sCKA6e3BOJnbL5
	PxPAN+UOnjsuZ/XQSnwq7xyS+YAJ+vHk9UQi0rGfpnN8XBJHfy4BVz1CN+JV1v84
	3roXrOtOOmwzIhLPdv7Ks+pUNlu9TCOIt64KmXliUavV+KfCSwO3kj/6/g0L79Up
	BtdKkXek7Q1DEQ1aOGZqhjMR4=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBnNHnf0rZpLaiCBA--.40077S2;
	Sun, 15 Mar 2026 23:40:16 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: bt1: Use common dw_pcie_ltssm enum for LTSSM states
Date: Sun, 15 Mar 2026 23:40:15 +0800
Message-Id: <20260315154015.126074-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnNHnf0rZpLaiCBA--.40077S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyftFW8Gr1DArWxtFyUAwb_yoW5CF4Up3
	yrJa9IkFW2vanrA3W5tw4rXa17t3WxAFWqkr4jgw4xX3Z7K3s3KF1rZF43KFWktr1xJw17
	Jw1fC34Sqr97W37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRDl1gUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AD0mGm20uBtBQAA3F

Use the generic dw_pcie_ltssm enum from pcie-designware.h instead of
defining private LTSSM state macros. This eliminates duplication and
aligns the driver with common DesignWare core definitions.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-bt1.c | 38 +--------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
index 1340edc18d12..429fab073bba 100644
--- a/drivers/pci/controller/dwc/pcie-bt1.c
+++ b/drivers/pci/controller/dwc/pcie-bt1.c
@@ -41,42 +41,6 @@
 
 #define BT1_CCU_PCIE_PMSC			0x148
 #define BT1_CCU_PCIE_LTSSM_STATE_MASK		GENMASK(5, 0)
-#define BT1_CCU_PCIE_LTSSM_DET_QUIET		0x00
-#define BT1_CCU_PCIE_LTSSM_DET_ACT		0x01
-#define BT1_CCU_PCIE_LTSSM_POLL_ACT		0x02
-#define BT1_CCU_PCIE_LTSSM_POLL_COMP		0x03
-#define BT1_CCU_PCIE_LTSSM_POLL_CONF		0x04
-#define BT1_CCU_PCIE_LTSSM_PRE_DET_QUIET	0x05
-#define BT1_CCU_PCIE_LTSSM_DET_WAIT		0x06
-#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_START	0x07
-#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_ACEPT	0x08
-#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_WAIT	0x09
-#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_ACEPT	0x0a
-#define BT1_CCU_PCIE_LTSSM_CFG_COMPLETE		0x0b
-#define BT1_CCU_PCIE_LTSSM_CFG_IDLE		0x0c
-#define BT1_CCU_PCIE_LTSSM_RCVR_LOCK		0x0d
-#define BT1_CCU_PCIE_LTSSM_RCVR_SPEED		0x0e
-#define BT1_CCU_PCIE_LTSSM_RCVR_RCVRCFG		0x0f
-#define BT1_CCU_PCIE_LTSSM_RCVR_IDLE		0x10
-#define BT1_CCU_PCIE_LTSSM_L0			0x11
-#define BT1_CCU_PCIE_LTSSM_L0S			0x12
-#define BT1_CCU_PCIE_LTSSM_L123_SEND_IDLE	0x13
-#define BT1_CCU_PCIE_LTSSM_L1_IDLE		0x14
-#define BT1_CCU_PCIE_LTSSM_L2_IDLE		0x15
-#define BT1_CCU_PCIE_LTSSM_L2_WAKE		0x16
-#define BT1_CCU_PCIE_LTSSM_DIS_ENTRY		0x17
-#define BT1_CCU_PCIE_LTSSM_DIS_IDLE		0x18
-#define BT1_CCU_PCIE_LTSSM_DISABLE		0x19
-#define BT1_CCU_PCIE_LTSSM_LPBK_ENTRY		0x1a
-#define BT1_CCU_PCIE_LTSSM_LPBK_ACTIVE		0x1b
-#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT		0x1c
-#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT_TOUT	0x1d
-#define BT1_CCU_PCIE_LTSSM_HOT_RST_ENTRY	0x1e
-#define BT1_CCU_PCIE_LTSSM_HOT_RST		0x1f
-#define BT1_CCU_PCIE_LTSSM_RCVR_EQ0		0x20
-#define BT1_CCU_PCIE_LTSSM_RCVR_EQ1		0x21
-#define BT1_CCU_PCIE_LTSSM_RCVR_EQ2		0x22
-#define BT1_CCU_PCIE_LTSSM_RCVR_EQ3		0x23
 #define BT1_CCU_PCIE_SMLH_LINKUP		BIT(6)
 #define BT1_CCU_PCIE_RDLH_LINKUP		BIT(7)
 #define BT1_CCU_PCIE_PM_LINKSTATE_L0S		BIT(8)
@@ -108,7 +72,7 @@
 #define BT1_CCU_PCIE_LTSSM_LINKUP(_pmsc) \
 ({ \
 	int __state = FIELD_GET(BT1_CCU_PCIE_LTSSM_STATE_MASK, _pmsc); \
-	__state >= BT1_CCU_PCIE_LTSSM_L0 && __state <= BT1_CCU_PCIE_LTSSM_L2_WAKE; \
+	__state >= DW_PCIE_LTSSM_L0 && __state <= DW_PCIE_LTSSM_L2_WAKE; \
 })
 
 /* Baikal-T1 PCIe specific control registers */

base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
-- 
2.34.1

