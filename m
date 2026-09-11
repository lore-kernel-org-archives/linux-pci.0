Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D403EFFD7;
	Fri, 11 Sep 2026 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154341; cv=fail; b=sJDyukX3xLI73A92LJSw9L/dv82oc89E4+MoMldOSzhKuqIiJmEydRlqlyjg2k5h+kqhhseS21otEm/5Z4Ma4y5StRasfPTHodo/rm7k6LjE1IzcH/netdYfLcQi2S5gqa9LH0jI8mVv9qgH5Tx1gz0+7g3JdVSCY/+/I64b3ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154341; c=relaxed/simple;
	bh=J+a7NpEUa6dHyyy7yAf+KVhiafGOZaME5XWSQeKIbAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFRqI7hvimj1Bw9P333stMv8JMaipnOilJvbcabOKNvOU2dg0OcNi6JK4MEHXQN08J0tNGQAz1dqI4cogWDDOESUrK4wvHAUaY3r5KUTeAhxJfL6QsUmErbzzTiG9LcLp8fb/ka8GyHHFuqQtaosa2UOxt/o/pWwbF3k5Pl51xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FDrPzSfd; arc=fail smtp.client-ip=52.101.61.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FDrPzSfd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsMq1woPDWEiekGFj4ZkV9ove4xyfc9m/offRqtCODlwr7D9w/RcUkIZDf4+VgKpIGupbyVBiSw45ZQTXvOGU4gjpTXIlHCfSA7LoaxLLflN145q6IWwgsHahFZZAffls8IqrtyPYK7b59+hMRUW2CmjEDXomLsRkknD9vggLJPmcMwzhJtLS0AqAwXzl5cTXrDijEkiZCROFmP+5UHomdCRs8ISLkGISZ9huyKofdllZWvHSonoYFr4ujHcGXPwn82Pzkhe7D40+7QNBf3jkfo/1g9dWrydY2NeC/QprB44MN7lYune85x9ULKDb1m722lN1soB2bFJzCoqg8MXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4clVot7AMBKAt4LFJ3Y5AinH7XEID6xB43aAG0dDiQ=;
 b=br9BQAV2vgX4TQQe8rQcLDru0utIqfAjeipGMSEEn1ru8cZ1F7HjgR6TwGYoTNxOYbFNLiQV3GyHgoDZ8kAR3UsNYql/UmvNxhJEZqhbwiZVnBK/2pnS/10QWCGkuwX2wxwfw10fivr4MG0mvGOnVkjWeb8VCwcVugN+22tYlo+GtNVKqPhpJ5apXdT7AIqtETtMHhp6+u7rwGAYfZ9bL8ewD9l274ZoQLrTXXhViVv2P1jvSFX2Q/3xNHa6+7gdCwvNwNxYYcBZ6DvFUcJBfCo0lT4qRIa0odGuoLUI/o+Cp1s+GmCuBiSnudaBsbtK9qxeYYKmKr+CRFya9RlfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4clVot7AMBKAt4LFJ3Y5AinH7XEID6xB43aAG0dDiQ=;
 b=FDrPzSfdX4T1EcwHZIensGJclhISvB0qtz8PMe+IuB6VH6KZJrwUnPIaGwjxuW+nOy3OhWHAA10VfP/kr1OCkRRmzYRQwX/2VHUg1T9JEt4nAm7ZZZoz5PQHsDh2l9rXtBhvpBd682r4SapVqQHgHlyJ1SeIFCxV4Ipne9Fia5A=
Received: from CH2PR15CA0026.namprd15.prod.outlook.com (2603:10b6:610:51::36)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 19:18:32 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::1e) by CH2PR15CA0026.outlook.office365.com
 (2603:10b6:610:51::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 19:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 19:18:32 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 11 Sep 2026 14:18:18 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <bhelgaas@google.com>, <clemens@ladisch.de>, <linux@roeck-us.net>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-hwmon@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2 2/2] hwmon: (k10temp): Define unshared PCI device IDs locally
Date: Fri, 11 Sep 2026 14:17:14 -0500
Message-ID: <20260911191803.1522358-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911191803.1522358-1-mario.limonciello@amd.com>
References: <20260911191803.1522358-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 90853c55-9d19-4208-7a02-08df103977f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NMPuKMjt+wtnK3WQBWWI30tYNvmqVYXvbdWmev4UeRNdXWFS1ssIcVO5IeIOkB+MtsxwRZ6YAtuNVdzdzv9/8sm3yRwD0CrxUxdh+eROs3JnLC2f6mQ9SMgR3DI+BKWl2V6TYqLtel9gCR0kqcYuM9aAau/VsyjmG2ZzXk+AHIawLA0cCTfqtvPE8SUPJ3z42tNNodLUMhRqueg/TREpe43iI4gUm4lmr1T9jQCW61WwyEIbvPv8kap7OfE9Y/yRJpCXWJD6D51HilBCC5bV5COMG4pM976n+5PoO5b62TCbtu9MXI4DimOQMHnbl1lgn9wEKh7hFi1P6dxp/w1EwLjF5awNXvKmRY7swztGzq/SBFLoNiZasHaqgpGjYhM8yqawR80rM4uK3atCdjW7ds3F89xH7y1oRiydUVSGcYgK32ZSILohBhvVI/F8nOjA7p5J5/1XkG2iuhu4bH+eu6iVH7sbMXrHZJi11dx6EaZ/B5vdfqusektp21inUPWUS9Os7k6nZ9wvz4pYkQCbya4qr+qsEvAe56WJXhejF3lYvj8zUqIaXNNLRVNy31/+3x4Fr1cxXky2nIcfiafGR9LtsIEz/GuQPdO06nBnFycannwSRVS1npO0sVop0DrcHDM2MjZ+Ev5kma/jTXI4ASmsKkZE+LmpWz01hyF5PCXoQwi+fh+OFbZfGs1XznKPV97T0StTgtkvfXNOVnV8gg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0FaUcygBl25EvHf++4hZO5VWGS7YvCokPrh/e0bDDIx6kJEeeBxxEOUdlaAZZxorFojovqHObMlU/Z8NQVo6QOGiuMIqsS0ktiTp59nY6Jvtsh5f/m9HYYHuhTs7hDldiCTU4RHjQnLJeQhb8p44po1XjaBh99bM+bUN6cWq5z2w/eYdvKPQRQjnuDaoyUyNVIeAkl//BiORdMk1nX7O+Yf1Yqf6XtqwZ/aNuph6rwfZW06UsNxOYmGZPpOhCMcGVtYlSj42oLV7n+3po7l4S1qeLfd4ysxIWg5WlFP6WU0HPVnV5n0E2JwPF9hp3ugOnz8uKs8mJveudbfIxPF2M5i5kzEanX9kz+KZoVYHakZkZ41xp2TEHROtVIkFVQrqB2uuNUPq3JSXVqDjGHwuxGluOTaNfjW7C+r9lA9sd0Guor9Uh6zAGtDtQsO/7xdo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 19:18:32.1476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90853c55-9d19-4208-7a02-08df103977f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821

Headers (now) only used by k10temp should not be declared in
global headers.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * New patch
---
 drivers/hwmon/k10temp.c | 30 +++++++++++++++++++++---------
 include/linux/pci_ids.h | 20 --------------------
 2 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 5414b7841864b..49a62d7349ca7 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -83,17 +83,29 @@ MODULE_PARM_DESC(force, "force loading on processors with erratum 319");
  */
 #define AMD_I3255_STR				"3255"
 
-/*
- * PCI Device IDs for AMD's Family 17h-based SOCs.
- * Defining locally as IDs are not shared.
- */
+/* PCI Device IDs. Defining locally as IDs are not shared. */
+#define PCI_DEVICE_ID_AMD_11H_NB_MISC		0x1303
+#define PCI_DEVICE_ID_AMD_CNB17H_F3		0x1703
+#define PCI_DEVICE_ID_AMD_17H_DF_F3		0x1463
+#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3	0x15eb
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3	0x1493
+#define PCI_DEVICE_ID_AMD_17H_M40H_DF_F3	0x13f3
+#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3	0x144b
+#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3	0x1443
 #define PCI_DEVICE_ID_AMD_17H_M90H_DF_F3	0x1663
-
-/*
- * PCI Device IDs for AMD's Family 1Ah-based SOCs.
- * Defining locally as IDs are not shared.
- */
+#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3	0x1727
+#define PCI_DEVICE_ID_AMD_19H_DF_F3		0x1653
+#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3	0x14b0
+#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3	0x167c
+#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3	0x166d
+#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3	0x14e3
+#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3	0x14f3
+#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3	0x12fb
+#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3	0x12c3
+#define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3	0x16fb
 #define PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3	0x12cb
+#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3	0x124b
+#define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3	0x12bb
 #define PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3	0x1243
 #define PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3	0x127b
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 63774ae2bf71d..7f2ce86695de4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -550,7 +550,6 @@
 #define PCI_DEVICE_ID_AMD_11H_NB_HT	0x1300
 #define PCI_DEVICE_ID_AMD_11H_NB_MAP	0x1301
 #define PCI_DEVICE_ID_AMD_11H_NB_DRAM	0x1302
-#define PCI_DEVICE_ID_AMD_11H_NB_MISC	0x1303
 #define PCI_DEVICE_ID_AMD_11H_NB_LINK	0x1304
 #define PCI_DEVICE_ID_AMD_15H_M10H_F3	0x1403
 #define PCI_DEVICE_ID_AMD_15H_M30H_NB_F3 0x141d
@@ -567,28 +566,9 @@
 #define PCI_DEVICE_ID_AMD_16H_NB_F4	0x1534
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F3 0x1583
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F4 0x1584
-#define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
-#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
-#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
-#define PCI_DEVICE_ID_AMD_17H_M40H_DF_F3 0x13f3
-#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
-#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
-#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3 0x1727
-#define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
-#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
-#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
-#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
-#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
-#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
-#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
-#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
-#define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
-#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
-#define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
 #define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
-#define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
 #define PCI_DEVICE_ID_AMD_SCSI		0x2020
-- 
2.43.0

