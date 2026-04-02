Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA51B4F1F;
	Thu,  2 Apr 2026 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120156; cv=fail; b=TvTfZejQoWrro3ZFCf1es3vPa3U2aqiB1KDiCTPSWOHyLBMrRRLe4B7G0/Phg8oLHDxh9jnKEGWmuPsh0EAkJcMfAhvwiZRl31VCRw8zVS71bYYTGjE8ET1z8BsQhBcNqDZen9BIFne4SEaGhJyNvJhnsomUSZIcR4xqQe+3Dx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120156; c=relaxed/simple;
	bh=AooOAT7AVA4fY0/XfFgOibDviIy7i3sroXvIPIO9Qvk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hpUi246ot1kR77onCuKC1XyUl2l5PPFVHPRWUCxxBqcwfiDfFy93NogceVbF3aeqS+fVw4j4yNrbcEBQ9WaOPTE2LFRa7H7a+AO/QdJ2oi6CcQcL7MKNQXz2QzKfyQbQvqQMt9id0pWqTsCZcZ48ldBIXEm45ohMVQFLFui6Oy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UkPtKQjU; arc=fail smtp.client-ip=52.101.62.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UkPtKQjU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocbdVwlUCjqcKXwhJzL2P9gpAYli2Te4kgSRqkr7jfgaWFClG1P5fqkSgfEPhw3KcalT7IPgVQdMwKnp26ekNNJPLgVOk9z0sbC/1Dls2QGvd/2voe+hKY98Kme/4jnPRcOsGmw+sUQyw241vZ3y4rPQIUQjBRmnZPVqFLX8Nc05A0xwLs/UtNGzWi9pZz9ylxLsBv7arPHZaPxJkwWIf+8gcP9f8dJSzKASjFaT64u67Bh4iR5lkmIc10EJ7OwOJSTnShcJYK4W6t6VR7WeR80C2PoRqlELXGW2O/z4uWHGnZ98rBGMZiRjhbfDNNyQjU9wxDbfUXTQcb1/t0AzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OigpvRnq8Az+RJBJRmOjabUCVoeUyUSdDJvllJ3AJns=;
 b=zVA1wvZw7PJ+CG+RtDDM5dw58g2gv9GweEeJuLeR6q1CuWpv9GUvq8+QwptJJGPD12GmT5VZRSD0IcFp3TswfDCllpT7E0Jlb5+e5pja3dnFGtRQxUdbMtxPF5Kp7BUBaVwh5KQ0fU8jsD+gNH3A15AY6uS/jDK7pJHelzbCeI0rsabYiaHyfVEHeie/UkAnCssEdRiE2shFWU4LuZtJr7Ou14vapgFEkrJwWeohw7O7tuEInsiZT2WB7m8HMdP4qirk0vE8BWsz4oSXNoCYJgC55Vn5bn0TXOOM+JrBq2CkK2hpzhq+GYhUTYnTo2Gnf3NUtXETfRhrDv9PTFecvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=outlook.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OigpvRnq8Az+RJBJRmOjabUCVoeUyUSdDJvllJ3AJns=;
 b=UkPtKQjULQ9NsLl/Kd56rzQinnMPsvgs0iMdpzuKbaF1J0anLt5sQnXPjmKzHv3sbzVRy52BMmsjQKG36C858FGbKBQED27Y6TbPF9yl96WqWAePbiSxVehk5aovbXzBW3xJMMFYMpExwMU44qKFfbhif9QBY0oYdTyPkl3GePo=
Received: from BY3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:254::11)
 by SJ0PR10MB6424.namprd10.prod.outlook.com (2603:10b6:a03:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 08:55:52 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::7e) by BY3PR05CA0006.outlook.office365.com
 (2603:10b6:a03:254::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.16 via Frontend Transport; Thu,
 2 Apr 2026 08:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 08:55:50 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 03:55:49 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 03:55:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 03:55:49 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6328tjUs2171747;
	Thu, 2 Apr 2026 03:55:46 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <lpieralisi@kernel.org>, <mani@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <18255117159@163.com>
CC: <linux-kernel@vger.kernel.org>, <robh@kernel.org>, <mpillai@cadence.com>,
	<unicorn_wang@outlook.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
	<a-garg7@ti.com>
Subject: [PATCH] PCI: cadence: Use cdns_pcie_read_sz() for byte or word read access
Date: Thu, 2 Apr 2026 14:25:45 +0530
Message-ID: <20260402085545.284457-1-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|SJ0PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 4535416b-7a36-4f25-6f87-08de9095a3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700020|36860700016|376014|1800799024|7416014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xn4KuBQDpXQM6LAha8b7qk0hAkqCIExIbY1YUcVl1PJqvqHexFxPEQq838I4ai16O7Impg6EuvnQ4vdixmX016O/HL2L49+bdTlAGluFonDFQN1Jv5JI5ySCDfq4kRFE8zb1LxfWVpuLBsdbPVbzp08brl0j6NvNeCA9zDqBtF0csKzS+q6GwVz3yQ3SF6D2o7b7PbAkvaJijxZ6kUj6ewjNRqHe3ChFBdZ94TiHhQpVaD9h/kpk6OOY0LnL46Fl7YYIuyXJwmDxABAvx0A0oKyn7i1cR2miFSPXLv0OXZ1G4k2MQ4zjYf2cPpzRqI84JNN5xqsy7l82IB1mV4WI9indl513juBKFwGexYwJgMfeFGA+waIH17J0y41ZJbh1Hfwm/S3QWCX+6oRwyplGZJGlR8ue2j7q5HimVJDrjK99DRARgZNVIxAFWYXOEzad8658aek2Knwjy9EoWJFl63wOrMB7PNEl8t1VrQ7Y5SNBKaRjNI/3NCC/yykcQTkrq/QMFp/lOGcpBNeaKP+kdwBfbO0MliolkPHJ6Wr5m0bALc3KOM2xgJ3l24upiOVvh9QpESEysEz1gstcIUyKrjzHayJzoBrO0Sxp586ojcp2hukVnWW2Um21IgPHPRs5hb/AmOdhxKAd8jzSF87W5bszoWG/3DqLHr1XIv576ibGvxbsjl5rbki0aK9lFD3gvBSUN2kym8TGRE97+n+vIrhBGGlt4Z+qoGxg9hyLi/eV+KenWfW2/MUITamv0P06Q+7iPSGAAsMtdVwiM89h2A==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(32650700020)(36860700016)(376014)(1800799024)(7416014)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t2Gz0pNFOmgjnrGUB49U2cSWzyPoJQ0Ml/jD6zE9XVFlXXWd1jg690FBa6WDeSz1CXevOBqKHV44iXVdLWSxTXWmNV9aBWY472rG9jgDN3xgrwmvi3BRtYkzLLdkQHAsfcN/k60GH6OLmv0pkdBNXietcSf5GOCd4eoB3eRtWr2DaMNMCYpRaos5lkhl9xzCC38o63Dout6pX7BJ7Ld1UVeQ7uNRNINIVGUzkGqbnOgMfau0uwVmnVLgNijTHyO5HwED8u/sUFyDshJoJIgXP5+fnJ0DEN2YneQOuLWbyKamOTYje38LKrYrpTmDrjycFtM/xaGD2jf9ra6G+HddacRNP2HZX/N5Jpy86ekgmZZ3MPT9KC5Zx1w3LGg03mGXS06Y+WCzBH2lEmc7yBDTZSgcAGCD1+JLleGQibxjluwprv/i4a0ZE8T1CwMKFtO8
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 08:55:50.4737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4535416b-7a36-4f25-6f87-08de9095a3cf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6424

The commit 18ac51ae9df9 ("PCI: cadence: Implement capability search
using PCI core APIs") assumes all the platforms using Cadence PCIe
controller support byte and word register accesses. This is not true
for all platforms (e.g., TI J721E SoC, which only supports dword
register accesses).

This causes capability searches via cdns_pcie_find_capability() to fail
on such platforms.

Fix this by using cdns_pcie_read_sz() for config read functions, which
properly handles size-aligned accesses. Remove the now-unused byte and
word read wrapper functions (cdns_pcie_readw and cdns_pcie_readb).

Fixes: 18ac51ae9df9 ("PCI: cadence: Implement capability search using PCI core APIs")
Signed-off-by: Aksh Garg <a-garg7@ti.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/cadence/pcie-cadence.h | 56 +++++++++----------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 443033c607d7..277f3706a4f4 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -249,37 +249,6 @@ static inline u32 cdns_pcie_hpa_readl(struct cdns_pcie *pcie,
 	return readl(pcie->reg_base + reg);
 }
 
-static inline u16 cdns_pcie_readw(struct cdns_pcie *pcie, u32 reg)
-{
-	return readw(pcie->reg_base + reg);
-}
-
-static inline u8 cdns_pcie_readb(struct cdns_pcie *pcie, u32 reg)
-{
-	return readb(pcie->reg_base + reg);
-}
-
-static inline int cdns_pcie_read_cfg_byte(struct cdns_pcie *pcie, int where,
-					  u8 *val)
-{
-	*val = cdns_pcie_readb(pcie, where);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static inline int cdns_pcie_read_cfg_word(struct cdns_pcie *pcie, int where,
-					  u16 *val)
-{
-	*val = cdns_pcie_readw(pcie, where);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static inline int cdns_pcie_read_cfg_dword(struct cdns_pcie *pcie, int where,
-					   u32 *val)
-{
-	*val = cdns_pcie_readl(pcie, where);
-	return PCIBIOS_SUCCESSFUL;
-}
-
 static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
 {
 	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
@@ -320,6 +289,31 @@ static inline void cdns_pcie_write_sz(void __iomem *addr, int size, u32 value)
 	writel(val, aligned_addr);
 }
 
+static inline int cdns_pcie_read_cfg_byte(struct cdns_pcie *pcie, int where,
+					  u8 *val)
+{
+	void __iomem *addr = pcie->reg_base + where;
+
+	*val = cdns_pcie_read_sz(addr, 0x1);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static inline int cdns_pcie_read_cfg_word(struct cdns_pcie *pcie, int where,
+					  u16 *val)
+{
+	void __iomem *addr = pcie->reg_base + where;
+
+	*val = cdns_pcie_read_sz(addr, 0x2);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static inline int cdns_pcie_read_cfg_dword(struct cdns_pcie *pcie, int where,
+					   u32 *val)
+{
+	*val = cdns_pcie_readl(pcie, where);
+	return PCIBIOS_SUCCESSFUL;
+}
+
 /* Root Port register access */
 static inline void cdns_pcie_rp_writeb(struct cdns_pcie *pcie,
 				       u32 reg, u8 value)
-- 
2.34.1

