Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794415434;
	b=PjkLTbw92unlGM/FQdqZAqMI1kIxM8ypSlW3VYSIB45zvSYAoLpfWKvy08PfhlHiC2vN
	 diI1TmzdrBd3TMRhO4bT38cTC68pzxWRPKwqHl+mAKnf6ACVlk9g0h71FDl99e7IU27uc
	 qLCFTtPCydL7useanMci2Y7Szae3Dg0at9ApMEVMsTZz8973sP13bJl6zJLsgZFc0qFaa
	 RJHc6GP/y3XhFG6RhFLUbFykq0lTThCPLP0VbxKZ9mzeHtR4Oou3E9VDQLbcgtafwdRRZ
	 GxetxLRAsVQ8q9hvKDa+o2VDviduTiN5XO2Qpq9lpQFglWDjt84lpU5QRBSmgzmGTgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415434;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lZ0Bz1hPv5O2qx+E5MPu+2FgjsX16i7WQUUNCqOeMv4=;
	b=J6oPij5BESwTM70mtb7ilsfjSB4U/DwT3hOFNb4G7Tt89nEf8qdxUIs4Xq3yqM0LtOEd
	 gA20OZJg8oZTEI/iJDi8VkeThkgh9kvtZgJWBkkgBfwZWs96relZ26WTkwrgVJ2xO++ei
	 gmP1vPw0G72WP+SC9ZNTyX8/zjZnqftdMkjKte7pqR2tv71BsczPN47YOGOprHhd8Emrk
	 6r977jAtvqFJxCYtEr1BprNNHfgqdCR2dmp3g0pzE9PrfkNW/D0Mv5DCqLATGHvMcuJL6
	 Q2L6zKh1WC1vZdDobQSLIzMlWl9fUeqAqV6yT+Lmg3lK5B3+X2LninR6SRD0giNIvmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UOaidJgL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.54
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCDF606A8AD;
	Wed, 11 Nov 2026 16:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFCDF606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UOaidJgL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QErNGh8vdslBq872mXa57cweVAYAuYGg6mRV+abbmeyS/1Fzl1z/Gj2IzMBC6sw916wZ27OS5ybAU52yqONO84WXXh9445a8GzdN27tvMDfiNl4q3QtvzR5xbJbVYeeSH19d3Kw92T3VxUoWgqmpxXIvcc/kG7eyhYomkYw5bhUXyZa7ina2B+YvpOTXvadKJxXgaeK8nKoVQrmZ2IqqEDLfuSwVcFeRQwhO8mg6qgD13B4wRtO/ZrkfkC/aICQzbu6rwow4y4iqSzKK0WRgJ7ykW+2qQ88q7rECgWhmg4vE8F2B4rP5dV1alglEZtxddy7HATNGbZZtJuMybBTjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ0Bz1hPv5O2qx+E5MPu+2FgjsX16i7WQUUNCqOeMv4=;
 b=yf2mucCnJQQ9v0p5LLUiwN2nWfTxoC8bxxRXmapLdJZ0XtcPVxbh/QoepE4XDSVVTwxGmTkWgrL3PcWVqoZ+clfbRva3kN55lZH0Aj7XLL9BrF/MJLz0obxEcmxP4G7W78ki6a/UTjqKxW27Hk5AVQuDXKe+5PqQJoVfIAVoYM1x0QK4WIeIop6L2RGmmVoNwmMv7/USf030vdDl506hFOSOVTsKWvV4aiEb7kfzJVgpmC7ZFvfKKYyo4DEvt/Osoze46Qjl8kxuS51U1Carco/wgf9Fx0caK075KGLq0IPzQ6Z3oVqs2vZY2M6jFrcinsM3STR/fjZ0Vc/DqKP3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ0Bz1hPv5O2qx+E5MPu+2FgjsX16i7WQUUNCqOeMv4=;
 b=UOaidJgLaBbBPV+idJaBnNbD16Oj+wOtgiiJ7GtVgYS46eSHPt2msJwSKhFPI4abOleXWcVRWbBJ5sAUOAF6FZjAo4ToH380PSYNQ+PV682qMIlV/VPoGsYmasxUNbfF1t1zkPMScpM24IhqDIPED9Z6ToXHv+VYXxDSLLveq5I=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 16:43:47 +0000
Received: from CO1PEPF00018868.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::17) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 16:43:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018868.mail.protection.outlook.com (10.167.249.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 16:43:47 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 10:43:41 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 11 Nov 2026 10:43:22 -0600
Subject: [PATCH v6 3/3] drm/radeon: Match VFCT using initial PCI bus number
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261111-vfct-regression-v6-3-393797bbb6e3@amd.com>
References: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
In-Reply-To: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018868:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b101ead-4a38-4312-132a-08df4012f4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|22082099003|18002099003|11063799006|56012099006|261102123227099003|261009223027099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|261028144727099003|261022115727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	nbtlgisFPVe+uziAqlJsPDw92ihAxqiz1NIG0GriTbu9KR+EZtuTwno9rd0mWeptJg2yd9HbDZVrG276qYgz7pnpmL1gS/HBCjnuilIrlZsW7QuS/SIInA5YBjozDxoEoDxsBoDsOUzfvgRnD/BaqnPFVxcYaEesm9ZdlhWO0DUFU9VNf/m6i0UeaYJFEDfG866z69TM3yVacKdw8z+PSw9ZLQEMZ+KSYG3UJlMHeCRUOi5kZZTahTR15LqRS8nE4bOt0A7rWPfTG0F0CJoHkHo0K6esXx4+20AhfNC54a8adw++hIfAKMukisMsvkOZsSF0hC3eo1+dzluFrSnEiV6Saj4knAJ0+1+pkOC/8Wng9NfEghrSHgAxtDL/W66QNbWyO012EsGsQIs9Yy3vhHefkTKw2mqhcVcqpEvPvYsDu4h+j6W29Fxp6Poyn7P0uzTkXxGQC/VtASqkvus1w+1Jw3RMwZK+4QtG/eNuX7WFteyxdrVfr3V2t28vEWL21ddLcaGp6rk5qBEHHu9uaozUjlmlsiealkCRMHc6Utp2VVciYvauM8RnjkyOP1p/A3EMoGK+hDLmBIxTXGazs/OG9Y4UUL/jKx4ybmDLtKt+NF4g9xftnHdQG3nmxNsLI+7y5bibzPrHtfLuXW9xCQHiOR58pUvbG17xaANMVPhJMvnsiqg4muLh/YibZ5uMJpp/bmbRORyTSy21A1+rCw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(261102123227099003)(261009223027099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(261028144727099003)(261022115727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rIGAt0s7S48WRNTcj7tGRLylGnh/7BmpnpmGxBeBFtfEnWQcSAIUBLuaVdOlWbbA6p7wJTN5JaJMaxYUj2Um+HYqOnqPwW9zPUZtNAoDhJ4QUu/3RpVmntHcG2SSVeRKHdjPXLMTPREgrQkEwGpX337ilTW7l4ZVl8kwZJ2U19We8iOc5/HTYPchnFOw4d3WP7YXSwszWu6yUskdXYlGl8+9EpKY4UJeiITyIsciHvnZULwkOWTh4KkjwET1g4xjJiIUzslcdjdJviYBaqQjL2FZy0hEkkWJ8cMyi+l6FVWza1i159JRV0UgwVrIuzq2qUh5+G7FuPz/yV6zp2F/k1VMlsI8QieurgdWFs8Ee6O5tLiK8mwwIpMGFZ6wREK1ZhkRcBRN1i/XMrxfWsvAEfEoXOzaiT5de0ahC1aQhScRep6SWpbr92NUkQs1VdQz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:43:47.0039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b101ead-4a38-4312-132a-08df4012f4da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00018868.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223

VFCT records the PCI bus number from BIOS POST. The current bus number
can change after PCI core renumbers the bus, while accepting a mismatch
based only on device identity can select the wrong VFCT image when
matching devices are present. Compare against the bus number captured
from the firmware bus assignment before bridge renumbering.

Fixes: 4059e2f02c8a ("drm/radeon: Fix VFCT bus number matching with soft filter")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 1da6bf1c17ff3..707566e376d05 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -609,16 +609,17 @@ static bool radeon_read_disabled_bios(struct radeon_device *rdev)
  * VFCT entries contain the PCI bus number as recorded during BIOS POST.
  * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
  * resource conflicts), the runtime bus number may differ from the POST
- * value.  Match by device identity (vendor + device + function) and use
- * the bus number as a preference: exact bus match is preferred, but when
- * the bus numbers disagree we accept the entry if the device identity
- * matches.
+ * value.  Match using the bus number captured when the device was
+ * discovered, before any bus renumbering.
  *
  * Returns: 0 on match, -ENODEV on no match
  */
 static int radeon_acpi_vfct_match(struct radeon_device *rdev,
-				  VFCT_IMAGE_HEADER *vhdr)
+				   VFCT_IMAGE_HEADER *vhdr)
 {
+	struct pci_dev *bridge = rdev->pdev->bus->self;
+	unsigned char initial_bus;
+
 	/* Vendor and device IDs must always match */
 	if (vhdr->VendorID != rdev->pdev->vendor ||
 	    vhdr->DeviceID != rdev->pdev->device)
@@ -628,16 +629,12 @@ static int radeon_acpi_vfct_match(struct radeon_device *rdev,
 	    vhdr->PCIFunction != PCI_FUNC(rdev->pdev->devfn))
 		return -ENODEV;
 
-	/* Exact bus number match - preferred */
-	if (vhdr->PCIBus == rdev->pdev->bus->number)
-		return 0;
+	if (bridge && bridge->fw_sec_bus_valid)
+		initial_bus = bridge->fw_sec_busnr;
+	else
+		initial_bus = rdev->pdev->bus->number;
 
-	/* Bus mismatch but device identity matches (PCI renumbering case) */
-	dev_notice(&rdev->pdev->dev,
-		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
-		   vhdr->PCIBus, rdev->pdev->bus->number,
-		   rdev->pdev->vendor, rdev->pdev->device);
-	return 0;
+	return vhdr->PCIBus == initial_bus ? 0 : -ENODEV;
 }
 
 static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)

-- 
2.43.0

