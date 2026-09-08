Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638B5A5157;
	Tue,  8 Sep 2026 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894386; cv=fail; b=DK7xGccdvpsAlGkmYFL/sksTcQ0j2sYxUveBE3byF2tspjSF5+RcEttkM5X0yBXbLG96lhR/fGdJg6Ox9uDr4bmoSGig83SUB8k4SZ3ppUTOnkzn4PO1RUPiDPkW+7FyJ4iSxkxnBKonzzVN/eLMqVFdtWCDaTuy7Xz2kIzGebs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894386; c=relaxed/simple;
	bh=Q98o0adbXPokq1rKjxAV/rg45bWFMO8wfauUhkmWsSU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBIpWEc/9M6GYxNqrP3RX2+d8ltAzWxJz+S4zWU6N3VErDSc9efpbLidOC5L8Dzr3roA8HzjyzJn0x1wCr9LCzbGtq07yGJ5/6wXGWBLd+r+PIbyuUqyJ8ze3ujD2qvehA9DtV0h4j7G3jskCKzTVhF6B5Of9HIlgbgnZCpwvjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NAJV48B3; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NAJV48B3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6/fxVjt35GmadIESGLF2tvUTWXC+I5Um52pT5DXMwMjzmr4H5EJg7Yg7QloULfrWrCh8wlooeLps+9Z5KCoYBUiluPt0qZ5S+nK2+iydg25AajHt6HWlTPyJpIxoWngH/Rap/ESPaFJ0aaw+A/q5A11CcinZ4Lew6o5VYEvbqKVst6k63jOAqQfNUyCCaLPCCxQknypH1kvSkprBnoI+Sz2S9aCU3FJB+cbWS2LuruF2jyt2VyU2Cxf7aAHyqTFGj6H6UXwA8g/VputynCY0gHyfDVxK66OHM3Q5+UJBs0+UO4OWYvKjnte1iEMxtQ/qlqx6s9/0NxhQjCRCk2D0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Spuflq0O4jjhln7uxocfQd4Ngrsv1Y5px6bDxZeZpE=;
 b=j7WsuRNG02pamDvV50PKPT0LkPhjkH/ufqa5hnowtAjQ1hm3NN5ZHbuXLUBJsPqn1dzifU7C2olaviyT8B5Y2uxRj/fZwxru//dhDTk071RyskWfi/gYdes2kFMh8ZGPq6KB+u1tY675A8uFZ/um6opBjZO+dj7D1H3RlHQvscfBnyhB/RwwbPjsYC0lnXYZkW5q8m2oLgWE9SYEDCQwtRgo4FG9mUAuvdIBlsW6SKFkg32tQNXt4olcEFFiNXBpoVjikPKHq42fnIj35N/Uu4utTpt4GGdxesoUKt8AkbsCdjNHg8+h/6qry9f/NP0hmTDA/r88wPmrO/p27mfOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Spuflq0O4jjhln7uxocfQd4Ngrsv1Y5px6bDxZeZpE=;
 b=NAJV48B3aTpkkkCwqZUejsMp76A3j517Jq8NbkbTg6QPEqOD95Hglx6Mi3eowHQWq3NS93Q9neY04mYiycAZVlvmufW4aWAK8MXoRTdIjsfB/SqoXin/T9ndatlZfyen0nvP1uKGldja5RuC2Juf7RGhcnrIul+93H2bfL803tg=
Received: from BLAP220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::14)
 by BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 19:06:21 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::85) by BLAP220CA0009.outlook.office365.com
 (2603:10b6:208:32c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 19:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 19:06:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:06:19 -0500
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 14:06:18 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "open list:PCI SUBSYSTEM"
	<linux-pci@vger.kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
	<linux-kernel@vger.kernel.org>, "open list:LIBATA SUBSYSTEM (Serial and
 Parallel ATA drivers)" <linux-ide@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Arthur Husband <artmoty@gmail.com>
Subject: [PATCH v2 2/2] Revert "ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585"
Date: Tue, 8 Sep 2026 14:06:00 -0500
Message-ID: <20260908190600.226485-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908190600.226485-1-mario.limonciello@amd.com>
References: <20260908190600.226485-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|BN5PR12MB9511:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc1e3e3-3c25-4f00-03da-08df0ddc445a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|7416014|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kml4ibQX6P0eZH0aY+iZdRTsRJ/AdLsChnVobg1WU6SAH/Q4IYqYD2bY3JKknxQQ2k2cCTvWFZx866sI0faOXW1SE2IZE126gTSKjfYR1XwyFk7Ghp3molMlTmlfqqI75V47trb60s3AAqsCD4szTmd/J93ifDUKpPW9VLb+QGEi7bp/V7e2H3y+ufReBcX98FfZxWqjp0+nY5DAt54Lq1Oci5+t9DZ/ySIBqSERI8qHHwaPIhQOYOBy8YIa9TT75F4Ojq9ijbf3/YBTYB35uqb+hesfvgWGHc5xZ15qacEIPcQeUX0qw1KvchNymwNHWL1+C608uu531xmjWK9qqDUedgGBrptpXeHzkEm+xGi1iRDQnZZaMUc69C2+PNaqgZdFkbg9capzgvJJN8VM1BIrWBY1/xBNAHcFOk/z5mr5z0d1Dac0d+IkzTsOWo0iRUwgVUB1acT+HLE9EMx3dT8QMdda5WyU3xncGjAI+zeZuMI3XugLt5dJ6k9LU9QvKFXQ21ehcLvkvVCBq0jLKy82Fh+xMWJ0FkLjdR4bK9rbE1I/DCcuDvRHlTOjnnfnbk8tp7NXjcv3HT2KZ+saXuymvOebmaxvkvlOlC0Bkm6JMBKlIlnzv1zIsqjnEG+hahAkzbin4mgEZpKL+FGxbpM6yeU+09Sc6yB1RUtRmGw1j86QwK/YuWK5j2cN5Use7iyxJ9awbVB9PckxYHKCbw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(7416014)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WO9fkycmxmVLby0aKEt3tyYx6uD54fIxWgRpqminV2TPkdUkeQzvDdgZ1t3hGVGke8wLIZyR0pplVn+nWSrse1weOF2qw/5GrBJ6jzXYGT4X7Pf46joT3ZiKlsrj0g782bvCnK6UFCK0FKG12g70PQXUflNm/KH/PK/d53E8Vv2iLKmFZBtfyQtOdhSm0r3+TUPoxjVcqYawYSrSU1fJ1J89aFtF9Hp4u965sE2COdmF3ONf0QdpYKva0maendpcaDqsmwuV2ZkOpN92TpCeAR9Bu4RtU0qhk5s4TS8aNpbwan/Jm2k1EHn/NJcf5Y/+rBvhJ6V56ZG59f6UsIX9xN8G0JmsNcMkHhfouermopXDCJOSmEam5C6dAWQWwSQXDr+7GCSQ0sBg1Y4IkRrP3lMo4xcdMxznK1igP6+Lm14xeN3AZuuiKjS1H8YYQ+Vg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:06:20.0181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc1e3e3-3c25-4f00-03da-08df0ddc445a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9511

This reverts commit 105c42566a550e2d05fc14f763216a8765ee5d0e.

The issue is actually a problem with BIOS configuaration of PCIe
root ports, enabling a feature that causes problems with 64-bit
DMA.  It is fixed by adjusting the kernel adjusting the
configuration of those root ports.

Cc: Arthur Husband <artmoty@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/ata/ahci.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9b8c0935001cb..bffe50a109b88 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -68,7 +68,6 @@ enum board_ids {
 	/* board IDs for specific chipsets in alphabetical order */
 	board_ahci_al,
 	board_ahci_avn,
-	board_ahci_jmb585,
 	board_ahci_mcp65,
 	board_ahci_mcp77,
 	board_ahci_mcp89,
@@ -213,15 +212,6 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_avn_ops,
 	},
-	/* JMicron JMB582/585: 64-bit DMA is broken, force 32-bit */
-	[board_ahci_jmb585] = {
-		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR |
-				 AHCI_HFLAG_32BIT_ONLY),
-		.flags		= AHCI_FLAG_COMMON,
-		.pio_mask	= ATA_PIO4,
-		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
-	},
 	[board_ahci_mcp65] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_FPDMA_AA | AHCI_HFLAG_NO_PMP |
 				 AHCI_HFLAG_YES_NCQ),
@@ -954,14 +944,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 		/* Elkhart Lake AHCI */
 		PCI_VDEVICE(INTEL, 0x4b63),
 		.driver_data = board_ahci_pcs_quirk,
-	}, {
-		/* JMicron JMB582/585: force 32-bit DMA (broken 64-bit implementation) */
-		PCI_VDEVICE(JMICRON, 0x0582),
-		.driver_data = board_ahci_jmb585,
-
-	}, {
-		PCI_VDEVICE(JMICRON, 0x0585),
-		.driver_data = board_ahci_jmb585,
 	}, {
 		/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 		PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID),
-- 
2.43.0

