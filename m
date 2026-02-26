Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013008.outbound.protection.outlook.com [40.93.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F3425CF5;
	Thu, 26 Feb 2026 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130357; cv=fail; b=XW/bY8Qztvd2VcCUiOBy/D/aiTGvD1PX90VHYcdPf9v005fwxYsBE52ZKPaQMhYWnlImtnwXjXFj5nl+3rIWAC+DuuoyXRVocRt1/dlOHSLXy8ao9gbDwhV0D4FsrChGZ1mLbiCHf006Y4wA9+4L9YW9JrHBB9URDH/qvHTxlE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130357; c=relaxed/simple;
	bh=W9fV/XTXCooEnhCLmObWEa3YlbQZF/mtGhs8Uk2pHBc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JDigO1Kf9IP18mTJibMFZDO6Ug1WJ0HP+siKxrJI8HSCDfNauXBx3x+faq6pFUuOeengeabRZSHudvCbshE9GGcz2EetrycG2LdKvvfGcALPWikJiD/4WmkTrgmX+awd6YwrHCIo35u9bhBL94jbpkoJIJnltgqBpxBQw7Xdy/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H4QR1OE8; arc=fail smtp.client-ip=40.93.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H4QR1OE8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUar3qXiKseIr0ZkeW24JpkV6GrcEC8lrkUva92J1+qXLbxL7sV5o5i7mvOGkNk5A16leXyLz5FxrxgOVGZM3VpxSVpjOKAPOyUPFIp2GhA5QW5BgNJC8QK3Y9hspo2Eubs7nL5W48Z/lIcKTWl2syjsX3SopgyqvyEJd/D+Zc3tN9IZhHiCWyfBe0zRY1Xj/uwxVyWR2qS1a4qDUgt8JUHzn7MZ3Di4g7LkXoR+XuZfvuSjW6btas5QJZYbL/Z99Tpwp6hSO7iHHcm0Om2OBfRVBfTPYVHKI61LMSAJUdgM1rwG/HdNZzCpFeeDCnCoqDjp3OW0zzx+LvdsSJSjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOYtUh6aQAn+MyXji/WLaKFf3DglbceN4/YW4htIYGM=;
 b=TGJyufhEZ6tWd6KC4LcoKsifzLCUJatjYcRmeldEBZQEoa9L8rZioT5R8WkMpubk6iUmHXsJCLJdyRxVVYUBKlXOdeksrmyjb+gwQKAckRJ7Oi40K2LrEflZ+qggkEunaKubePWAuTB3r40mtQvXpmRQ9bKlWNXqkkdRFG+8WN9FcK6ACGHIE9i9BCQPxudvmJizbkIWvshMlbbaaAZeJSQnL4aKG6ByX0siEPZ87Abvi9U611UwgeZcl9EbSt9QMOm8QxpHgwU33PgW+WtGX9BI5dEQ5foyEOca9SeqdSBeDHNwX7cE5VI1Gt0qUkEMZ4pf4k1Vr4+mt1WlSPi86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOYtUh6aQAn+MyXji/WLaKFf3DglbceN4/YW4htIYGM=;
 b=H4QR1OE89ba/oRwOHlSO1jpC0z5yBtOBTyzajeUY96/9X9qgxUALci3Jw6IlUc3xDFY1gcMsnO9w3GSGDxjxEi3t3ODwLuG8L09ZCdJD8SAvLc/+s83erit2QwAS4X58g8ChbLJOGdCteHRt6v9sPp8wzRdycJVLS4uR9ZiKl6M=
Received: from BYAPR01CA0051.prod.exchangelabs.com (2603:10b6:a03:94::28) by
 IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Thu, 26 Feb 2026 18:25:51 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::c9) by BYAPR01CA0051.outlook.office365.com
 (2603:10b6:a03:94::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 18:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 18:25:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 26 Feb
 2026 12:25:49 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Feb
 2026 12:25:49 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Feb 2026 12:25:49 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V1] PCI: Avoid FLR for AMD NPU device
Date: Thu, 26 Feb 2026 10:25:45 -0800
Message-ID: <20260226182545.3057330-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fa9a89-cb5d-44b2-0274-08de75647840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	wZlcvXmj9vEnwIc2rQsZr6aHOvtEHqmjOhLUWeLxwYbVcUSod7SPDVrLMWq7tAF5eYmzpem60tlHO9Ui+TTDcUr8Ap1seBe0QLroANPnGJTmiTgQJrgjZr/G2I9qRoGeSxX+ineHW82dHW1orteXm2NLOj/7YdOZJFMkTHZbs0CkuCLOt3nbgSK/5ZbHlKYlJ5XYo2hmvAnSgs4oTV91DgZojNmimRZ2zDS4an1kf+CjrA/iZbY/kFL7wW5jkAZyrdqlZtL5+HHDYku51m6KAKEhwiQ0+3jCYK6UmkDfeWS56ikBvZnlqPMVrGzCl+FaAeAYXao7+pA0F/as6FofTcCeHuN3g4f7Rr7lbCVw/GFWPajSB6VmRfwUwGhT9aNhMcfX8DLPzR3BxaFyU4VD+9euY9l/KG2H87K4Ossn9hPyoemkocyIRFh1ooP2oGEI/yctB3S49P3sSEhrwIHX60hiadGY2kkgf5xEx3QBqPzEYAtgDwPcRq3VXfe3m/HdsC701RPFzT0DgxxqMa/ZDiawysutT6dYPjttasSw35nzHB9PXUGuQIEZGImPC49iLqll6Os1XrnA51tWMDkImbLvUwMfm3d+/tqHuDY0W44XqWk16DM2Yq6aKEJWCf+y4W23bPbjL6VHq02pO5mzAvdDZDfyMTPFzNphRpdUPAGB08KITx8G+rKMYr7bz5xjXzQbZCVC5weacsB78HLDsg4HYqed/N7fF8mdeb2KsuG/CYj+cUT+sXEYsrBlHGAz5a7fnD3v5bo4U31nd3l5U1Zm9DALPnsi/+PXo2mozdBkgwiGcnNm/wNW30JvwPqUdfxsOHd7h88TjZZOsyesWg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kbzcDx4VkSgFiQqkKwzUrJeUOjMCY6GDrfoJQ+Ersk8SLtQWHwO08wOL7TVfIVKbHNMGUFzGRH5mM9PChuGdh8aYaSuX2/SAkB/NeqB1E4RFytDDEkj9vBPIQRIRb7XD23/mkjBD1/AsCR3vq8FYGOLgov73TaB3fV03/t97FZQdIGhyG8qNRNWtxADJySxoLHTrt+PjfXg1RDOM/B4YI3o+tlcgfmqpJmPnGCXMm66EWuLgaYRbDoILTcvf4421wimk2HHUqdTkdvkGI185jSYm6S30E+LTd9Zq5aiK98OLLWrMSFycZ2+/j+Ya/BqNJzx3gt5XspZ+mWg/jRLZ4s28EYUY87IfbtCFIYBI41JWTyM6fi/hM5l+JMw4WoSWyIHAXec6N301j+f3hWEcqA49WOn6N6csmjQ+UTic8FXH9wktS6p96tC1UVgqnaQi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 18:25:50.6731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fa9a89-cb5d-44b2-0274-08de75647840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

The AMD NPU device (PCI device IDs 0x1502 and 0x17f0) advertises FLR
support. However, triggering an FLR causes the device to hang.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be7..757a296eae41 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5603,6 +5603,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
  * AMD Starship/Matisse HD Audio Controller 0x1487
  * AMD Starship USB 3.0 Host Controller 0x148c
  * AMD Matisse USB 3.0 Host Controller 0x149c
+ * AMD Neural Processing Unit 0x1502 0x17f0
  * Intel 82579LM Gigabit Ethernet Controller 0x1502
  * Intel 82579V Gigabit Ethernet Controller 0x1503
  * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
@@ -5615,6 +5616,8 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1502, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x17f0, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
-- 
2.34.1

