Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874F6377A99;
	Tue, 14 Jul 2026 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054421; cv=fail; b=VQ2lL68PPTHYeaAJSy5S8HYwo82dh2RZbefAUNnASjzIARnjJUqEdqnKf0K2fAOKW8xZ6IYiqwgq1sZQoujKT30DnLgGtjLWdoeAsIYDo6io63Or+wXQUmM8HrQtnHQCLQ9pfwsD6B1hWXe7ia8jGsgCzRYDj47cXp4ESVKu1uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054421; c=relaxed/simple;
	bh=l+ngKT88x3I8L0UeiCUa2DZjBy7s7N8ETezcQn1lxR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vuq1nf4g6WGkRCimQ45oDQ404pzS1Og623clZve1cu4ehiyQQbiogfZjN50yS/YWcnID1RUOsHqDUisISu6LvFMmo/q0mWYZzNflPxVNGndW2vZIAFUzbkE22f1jqqoCvgNji9PPv4UB5ywA0rJIh6B1ma+fVB6/G6efquxmLuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y4EkPhOE; arc=fail smtp.client-ip=52.101.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y4EkPhOE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOD9HSzPioRuFmCcC0aeIlBkuMnmkq2kX058WAKNIQQvyhP3gpoO2qil8lTcfQt9Qdo3zJbuxYuaIxJyG5MrsxkNEWhJtfIrgL6O6JB9DemE3x/89q6j7TMK0MEaDSUO+SPehGcCWvTG/7EXnvdZKQluhQhvT2dLPS81Mlx/7gFbbrj1E86S6Ysy1sZmL02A4MJef2sn/egJvxHpfgNNJQoaPsZieid71HHxL90Zcc7nph6SG+ZuR0V3KaHE0yo3HPBHJhlmRR97Jkw/lmHQE22LKvQdvvfyIknjthMtDYIDF5D7kHIQZ4xDHyuvnxR9j0vp1AzJxLeVoyq7ur7Lyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnEqdWWkAJEPsDZxIc3WNx1gTyAmz4TdW+xuQF/kq/o=;
 b=bkICpafZlrGKtP3J8ls7ly6otGKqPprd1T1sIGcNFL2fJcQmUX7OzXShm1W0gA1f3l6mjtstcu/phxf9Jh2vDd0IY+5pQilft3pgM2hXWgdZQs4vv3lx43UvPpHejFcASm2gJ70NwkpipdOx6rlXZXfSUcVdI7CC2rKoH15nT3/GkGdc9iQ3gohLg1dHUkf6Xcc2eZDtkMVwrEGrwJoXrm4UM9XjFxflcvFpKLMkJGvju8cKXFI+O8wNKTn24oPT96MyItMoe185z1qv9aSFfu2w1iQDR86Muy44IHiKCg2ee3BPuXX43lB1C2y/C6wofjvYgEUEd3xLX4cOr5nomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnEqdWWkAJEPsDZxIc3WNx1gTyAmz4TdW+xuQF/kq/o=;
 b=y4EkPhOEA2mM0F3Z9X+x2UtTuEni1/ErmObDZHOqkdvHYQf+kXezz/O0n6ZDIOHGereMtHHGwzZL7T8K1YPvzjhJe0dDcrk2uv8sgtWLl3NZmiLeNbHgmEO53C83mY3sxx5yZbuowTHRgtDmrtc48IRihmLFf0b+GV/YEz9Pyrs=
Received: from LV3P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::16)
 by SJ5PPF6375781D1.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::995) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Tue, 14 Jul
 2026 18:40:05 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::4b) by LV3P220CA0004.outlook.office365.com
 (2603:10b6:408:234::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 18:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 18:40:04 +0000
Received: from yaz-khff4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 13:40:03 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 1/5] PCI/portdrv: Group PCI Exp Cap services into a single mask
Date: Tue, 14 Jul 2026 14:39:46 -0400
Message-ID: <20260714183950.1620016-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714183950.1620016-1-yazen.ghannam@amd.com>
References: <20260714183950.1620016-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SJ5PPF6375781D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 939444d9-5687-4b48-afc0-08dee1d7521f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	TEgeAbyzpJ1iBR0BguNyYgfBG9cMo5YcnRCHFjrB9UEdGDcz7eu7IEzjOApK4rt/kYVZOwB/ClHluLYylJF8l7gXuHyCqSPgHiBCCwpB9eyHpMLvLda/3ZCDRBWIg8ts8Gude592Qdg3DLtZhURPY/e1BOFkmN0bLI2cvSZmukQuzb9PFHCWoxaUKdo2oaJaC6zcTW9ztPcEfGK9QoUq0YD88omONJwkhLpwmbf7dACqo/qb0Obcnm3d7kNvsMPqJjsZavMOj3djhnnwPTERS6htGaP0+3i91gKC/sprVIUghGryQAh4Mg2FeabIUADJA5cFXuebZVoN2e8KNARAn7lrR+LRxMTk9MOAYBnelrFBZgZaZ/XO1mB81TJzL3k71DAQPK8ubKYdcOT4rj08AlLXz74t/FnbzIDX/Dc2EA4vAmbBuIkxQz97UNWq5jApkxWdekO9KuYxfxnLflfy4H+YSUZHbx5zaOTMbz5Z2O84VIKpfqQkiTJjUl4WgqLArKX2QQwcVOWek2Y2ETKql1JaDlDzXGZiLkpnwvnyn+vlu+Xfos7bmEoqeX1273+I5a8UGD6sfBkSp51JgVgCnSp5FOcQVrzIFVLSsTrvZ8+sU9RiJOLx5qb2WM1vK5MTdThnMSinD5NS5GtNBwqZ5SbUPTQk4JQnuFCDr/8Cky8wkHyc44S5x3g5+3IptTjEAbvm+W/tKGe4zFWCwSHnUQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EhpEig9WjjzBwSqbimNqNapbhFZNf3ZZ0g6JHABDSSnkxYH2qdPWI6LWHNkXfwjoPYvLMhRtyl/nc8X76NOYUsyu142rFMQmAE8Rtsqa6/4uYaQ3tIQ6GJGYshEeW3ju3EmSOEbHFMBkna/+M8EYCCD08mMaV7uRKhpJeE+hKf2MNOQJhdHvaJ5E7FRylzenAa3aft4vTVceYK8pb3dVU4UGtDe576G3hyV/NF1RWAKggJOGvax3oN3BfhxJ5taouhGGmQxJ7AhdWzZeTeZFN0nCWVUBfGUC5PkLDR4cRU6ckB7A+IfIlVnaVCycv/joBbef0QsoUoUL8OZCC1YPNWnrMBc5SAkid/0phAIKqHCssdSsvmxltCcmc7QO4367sV6cOfEOsx0W32lK0jfM+8TNbSkM7cMWKMWw8OVTvJ4n360SjIZ6r+sQWiZO1gEQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:40:04.4785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 939444d9-5687-4b48-afc0-08dee1d7521f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6375781D1

PME, hotplug, and bandwidth notification are all services of the PCI
Express Capability and share a single MSI/MSI-X interrupt vector. The
set of these services is open-coded as a bitmask in more than one place,
which is repetitive and easy to get out of sync as services are added.

Define a single PCIE_PORT_SERVICE_EXPCAP mask and use it in place of the
open-coded expressions. No functional change intended.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/pci/pcie/portdrv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 2d6aa488fe7b..53144c99cb3c 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -29,6 +29,10 @@
  */
 #define PCIE_PORT_MAX_MSI_ENTRIES	32
 
+#define PCIE_PORT_SERVICE_EXPCAP	(PCIE_PORT_SERVICE_PME | \
+					 PCIE_PORT_SERVICE_HP | \
+					 PCIE_PORT_SERVICE_BWCTRL)
+
 #define get_descriptor_id(type, service) (((type - 4) << 8) | service)
 
 struct portdrv_service_data {
@@ -67,8 +71,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 	 * 7.8.2, 7.10.10, 7.31.2.
 	 */
 
-	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
-		    PCIE_PORT_SERVICE_BWCTRL)) {
+	if (mask & PCIE_PORT_SERVICE_EXPCAP) {
 		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
 		*pme = FIELD_GET(PCI_EXP_FLAGS_IRQ, reg16);
 		nvec = *pme + 1;
@@ -149,8 +152,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 	}
 
 	/* PME, hotplug and bandwidth notification share an MSI/MSI-X vector */
-	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
-		    PCIE_PORT_SERVICE_BWCTRL)) {
+	if (mask & PCIE_PORT_SERVICE_EXPCAP) {
 		pcie_irq = pci_irq_vector(dev, pme);
 		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pcie_irq;
 		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pcie_irq;
-- 
2.53.0

