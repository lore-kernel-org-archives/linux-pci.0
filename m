Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5A377A9D;
	Tue, 14 Jul 2026 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054421; cv=fail; b=R0wmXVKok+DcbMA+RsdUtPTvEw3Z3ItXVxiWKvZCbxGqvAuROf9IRzU9lqg4w+q0Jn+7S0Xf5/rTfJ7f7PrCiF+JWddrn0AyEj20IWuanIHbzcBjlcaTRqnC7mgjJAFGpCqZjZ70lDScY7LTCBApsI0wl6B7xl4rK9icWWUtOe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054421; c=relaxed/simple;
	bh=5HdNeOPZao3vvNNyT7Jr6rO1yf44tWsUAPS+f099i/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAeRwBeJYe9+U51b0V1VvkNAraGCPZagEktB17rB8CYlc+Xko5FRT0STieOt+2JaZ8HwKQ7ALlcAuz+gm7sV27QYmbWzvpR6unw4ecjYQLECKd3UcxfrVXuZ5YASooXvkmrcgdGfBYhJwtjRMvWE1w4s6WSqo17WYGQU4A7/zj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=36bnKsPg; arc=fail smtp.client-ip=40.107.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="36bnKsPg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB5RDKcCwiEKDC/9cJhv5wDXy1MTpeFaXMPzuwXAfaffSbM4K243paPklkcZp2Fs5exq1b2oo43V9xkodoqXqCV26zpFjKMdHNBVWbyKwn0uu/2zDaIahUhyUw87av5MaBFDCDCzJ0PuIQ19izHicp03aJCoaegscPC9SpOpkCgu9eqtPPwmRfHAY6z41rGsHvX8g1uDEtlAStaldE8ev2I6me1LhfsEg0Og5Xoysg/LMh6NvCkbxOP2wdHkpx01+jcyvV1VWrr9AVnKCnPoClZjrBlTxtu6rWqeKQ2UjMjfitM4fW5Er8HNRnWTtRK6miiEEM9LVtbS3ysAPxlczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fx7iUiqIHT+55muNvRZecODqouQB/BnMX03gIkFhw+U=;
 b=Kh2zrU1DwREThOojFuQY9JBjd5wzt44xYwyNbrZOm9ou/vJ77bUQ9eqKZZD7sleAj2GeRmRXv6df9V486Zf8ucF+2PONkEWtDXGgPE1Uk0KnTkU6zhFMzDO5MSduxXcJ1h/RfcZW3OyUMX+e9bSGSKRiE508gjRL476YBxZ486oXfortYrqAguktAjUvg74tW/whG+0kmbrZrDXjX2rOYLEtbf++T7mZJmolY0jlY+7zGSCDiHlWi+UXnuLTIlE9TGXpurQN5IroKTJAXs3Kmz2v+6nxBLsTAHf0b8rkf5ebg0PvVUaOKSgWqSk5JdHqVlE7ZtTgyo9ocbOt6yhSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fx7iUiqIHT+55muNvRZecODqouQB/BnMX03gIkFhw+U=;
 b=36bnKsPgOjaZH7Vk1ZGA6IyhZsj8pxmqTrrseRkmQydSBMw2MJ+FeOGyL7rJ7VOdui4fPUtDeYqLbGtRnU0jXZ5QJtABIZVnz+7Hj6iJuol0BzYJKo9MS22uBw0VpCbTFj0OB6gXAAyhcPApbJA+wLgTsQRYkEnaTeDeEXsosZ4=
Received: from LV3P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::27)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 18:40:06 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::e) by LV3P220CA0026.outlook.office365.com
 (2603:10b6:408:234::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 18:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 18:40:06 +0000
Received: from yaz-khff4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 13:40:05 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 3/5] PCI/FLIT: Negotiate _OSC control for Flit Error Logging
Date: Tue, 14 Jul 2026 14:39:48 -0400
Message-ID: <20260714183950.1620016-4-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e6833b-7285-452c-9a39-08dee1d75363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Xpp9ypyGbDkYUwb/jepYLCI15eZmxz4fn1kWURPJRI19gO8Xd9knXCFE1hVSG6S9QWpox8/yLvH0hsUBJDsCIn2hXLNGGnMQnoJUGTEnxaiCCeEdFR1dF8QGuRD0cnNp/gu3OVdJECe3HnKZ2C4KjIoqU3Oxie3L/JQ4bbSOC6GgNlf0dkE9v4EeDEhVeHq2rbgoOVHdKjuTA+p01f8uGZauOA6gRzppma/QgwAvHkmAcehEAGj5lIYkNU1KReNlXXrso15bAdgZ09GX+XtfIgfyoh/unXEmYjo53u94QKShU5XsHNzyX/tNRxjps8+P/ZRn6As5cB0AHDCiO3RdceA1EW5JA8Uashly6V5GcMfHisJVyvZKL9NBrDsOFRLHDuPoRmoQG+9lib7yEK5/0tGiohcEEbvdpXMMmSLvHL5jxJ80Q1ldZ5jXo5yxS7ZG685Zci+W6xsyflMh3OZWaSGcZyAdDOhwuP8RLVmY4+uEQqAxg+CsWL662qqtzqU7TBe6MXGaVgBe2avSZWstgYyq1tpZ6avTCE0VPwDsC6IPNThWWF8v5IgYNxnYJ4eAu85B/2hcaaJRgOhWR4JOvorBwref1qOgY3Ze/2LDSW6lmo4PuhozoDRRs+YBHLQt91Kt8bslsDkei/jwBtAZaqmaH4S59PLIp+4d0KxPyd+02eKDF7WqBztEyXs2FuTxNNB79bugdXBbyFP/86wcDg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ts55UkJS5N9uPmybymqTMriWg2YUUujLxDkq7xD18N8xNtXmkjk9jeoYASBSW844Y2M3x2bgQJnILXE4Qrte9r1LCArBBnvSX1wZfbX1IuROtQ6VrTOBKypkkkedBhufYMuNLZMjd/hkeqFfO9ZmRyZUmq4FwhfJIdM0yQUR2cmf2WnAr0AeLJHYaS8F3saHL38hsmaMG3a/ck41I/5aKz4XJXPJYpa3teTZcTPcX7inbKxGBXJDhYT0IUG1LPUA03dP6Z6ZCWo2oG7TXnwZUmr53DoLZwgT2kHMVsO3T1bt58d4DS2T4CxiXqK8sdtTRy6K+85aqj9Ca+T+Bh6KGojBTF6CROdcjn2dMsQGHAt2Yx+FxPI9VWihbslfjEH2J5wOgFAv1Eban0lY/Le1wHGiug+miPzYGEttM7q/hBWiVzQDfxCMxFXHQpe/3k3T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:40:06.6010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e6833b-7285-452c-9a39-08dee1d75363
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853

The Flit Logging Extended Capability may be managed by the platform
firmware. Negotiate ownership through _OSC before the OS enables the
Flit Error Counter, and only register the port service when the OS is
granted native control.

Advertise support via a new OSC_PCI_EXPRESS_FLIT_CONTROL bit, record
the negotiated result in the host bridge's native_flit flag, and gate
the Flit port service on it.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/acpi/pci_root.c    | 6 ++++++
 drivers/pci/pcie/portdrv.c | 2 +-
 drivers/pci/probe.c        | 1 +
 include/linux/acpi.h       | 1 +
 include/linux/pci.h        | 1 +
 5 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 4c06c3ffd0cb..e6f74b8129a3 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -136,6 +136,7 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
 	{ OSC_PCI_EXPRESS_CAPABILITY_CONTROL, "PCIeCapability" },
 	{ OSC_PCI_EXPRESS_LTR_CONTROL, "LTR" },
 	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
+	{ OSC_PCI_EXPRESS_FLIT_CONTROL, "FlitErrorLogging" },
 };
 
 static struct pci_osc_bit_struct cxl_osc_support_bit[] = {
@@ -523,6 +524,9 @@ static u32 calculate_control(void)
 	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
 		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
 
+	if (IS_ENABLED(CONFIG_PCIE_FLIT))
+		control |= OSC_PCI_EXPRESS_FLIT_CONTROL;
+
 	return control;
 }
 
@@ -1039,6 +1043,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		host_bridge->native_ltr = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
 		host_bridge->native_dpc = 0;
+	if (!(root->osc_control_set & OSC_PCI_EXPRESS_FLIT_CONTROL))
+		host_bridge->native_flit = 0;
 
 	if (!(root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL))
 		host_bridge->native_cxl_error = 0;
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 1a649d6f4ab8..ef224e7243f3 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -286,7 +286,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 #ifdef CONFIG_PCIE_FLIT
-	if (dev->flit_cap)
+	if (dev->flit_cap && host->native_flit)
 		services |= PCIE_PORT_SERVICE_FLIT;
 #endif
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a1ec44b04eb0..f9183a4ea3b3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -674,6 +674,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
 	bridge->native_dpc = 1;
+	bridge->native_flit = 1;
 	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 	bridge->native_cxl_error = 1;
 	bridge->dev.type = &pci_host_bridge_type;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 10d6c6c11bdf..507cd985ff14 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -644,6 +644,7 @@ extern u32 osc_sb_native_usb4_control;
 #define OSC_PCI_EXPRESS_CAPABILITY_CONTROL	0x00000010
 #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
 #define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
+#define OSC_PCI_EXPRESS_FLIT_CONTROL		0x00000800
 
 /* CXL _OSC: Capabilities DWORD 4: Support Field */
 #define OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT	0x00000001
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a8d8dbac6640..4e4d1d9eb7fe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -660,6 +660,7 @@ struct pci_host_bridge {
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
 	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
 	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
+	unsigned int	native_flit:1;		/* OS may use PCIe Flit logging */
 	unsigned int	native_cxl_error:1;	/* OS may use CXL RAS/Events */
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
 	unsigned int	size_windows:1;		/* Enable root bus sizing */
-- 
2.53.0

