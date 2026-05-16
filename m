Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ADD3E2778;
	Sat, 16 May 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945868; cv=none; b=BV3Es+FD5V+AmRpND82zBnGmzVNdxLdQBFvIu20QE/rFt7SDSmRX5g8W7ljLWUnsVm0Z5e/gEtW1JoRH9nG0DlC7iWfjHcegVQK8Egi6zBP919CNw7kcYd0sjJcIflu9bOruiSq0bbEy5Iscdf3VI37vyA+HonZBh8PTw4Swas8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945868; c=relaxed/simple;
	bh=XYlkniTWrW9P2XjmDdZTdrggbOC19WNlRek/UVF+f2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QjHTIT2SIWtXvhxV0/Eb1PQ7xdth2y0HADD6f4D1QmYba5ahGw5BQXZJE+7iVtQhX4n52nTzrC5KjY65sjYSDEt98af6U6QBQJwGbWu970zAGzYPB9vaH/U5RFwnf/3LEnVpQCINyorYDvxtKsV+UcFtYotpMZU6IKF0bHX8Hu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F06O7FmN; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F06O7FmN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kF
	ul8ZfF4h9/iqiGeB/9BT7X97REYF0Qo8nJs905hxw=; b=F06O7FmNHOG6IceKog
	StInFeWDBKPNmY5ZQ40NfLIxEBnBS1qEl9lFr7JxTNFzCuy3LT6YUZUISYG7z7Tz
	M4a1Muf4B9hK5X0A39uk3GGL2sIFSN5voCEn0jXh0a8a9GmxG5pv617T0XXAzQ0u
	vgGAd0FDb1wViNWWCUbdDZqB4=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3XzoajwhqfCYHBw--.40848S5;
	Sat, 16 May 2026 23:37:00 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	mani@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 3/3] PCI: cadence: Use common TLP type macros
Date: Sat, 16 May 2026 23:36:57 +0800
Message-Id: <20260516153657.65214-4-18255117159@163.com>
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
X-CM-TRANSID:_____wD3XzoajwhqfCYHBw--.40848S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryfZr1DKF18Gw4rAFy8uFg_yoW5JFW3pa
	48Ar4rAF1SqF42v3yvk3Z5Aa4fJFZFvFnrGw1kKr45W3Z3Ar1xWF4Iqr98JF9IqrnrX3Zr
	Z34UGr9rWF45W3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR0PfdUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxByHK2oIjxyg7wAA3K

The Cadence HPA driver uses hardcoded constants (0x0, 0x2, 0x4, 0x5,
0x10) to program the outbound region type. Replace them with the newly
introduced common TLP type macros from pci.h for better readability
and maintainability.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 .../pci/controller/cadence/pcie-cadence-hpa-regs.h   | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h b/drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
index 026e131600de..72299121fd44 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
+++ b/drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
@@ -14,6 +14,8 @@
 #include <linux/phy/phy.h>
 #include <linux/bitfield.h>
 
+#include "../../pci.h"
+
 /* High Performance Architecture (HPA) PCIe controller registers */
 #define CDNS_PCIE_HPA_IP_REG_BANK		0x01000000
 #define CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK	0x01003C00
@@ -119,15 +121,15 @@
 #define CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r)                (0x1008 + ((r) & 0x1F) * 0x0080)
 #define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK         GENMASK(28, 24)
 #define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM  \
-	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x0)
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, PCIE_TLP_TYPE_MEM_RDWR)
 #define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO   \
-	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x2)
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, PCIE_TLP_TYPE_IO_RDWR)
 #define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0  \
-	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x4)
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, PCIE_TLP_TYPE_CFG0_RDWR)
 #define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1  \
-	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x5)
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, PCIE_TLP_TYPE_CFG1_RDWR)
 #define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG  \
-	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x10)
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, PCIE_TLP_TYPE_MSG)
 
 /* Region r Outbound PCIe Descriptor Register */
 #define CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r)        (0x100C + ((r) & 0x1F) * 0x0080)
-- 
2.34.1

