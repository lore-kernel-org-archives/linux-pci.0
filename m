Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794351157;
	b=1d3vLjOkJhLzy7bqmrDu1J1ZPP/EhCNQoLA7QvjYPO+n2Otzti5+YKQ+3a9qB1CT1XyX
	 sTGjugXutW0Nps7Kv/TaNdViv6QnghmpwWSf1D8ejGQ6dvvGtIIm2G2Y/6onBajJoOLgl
	 zX4t5+/62zTM0Z9IK3BwmsE/CNE7Q/fyVQ+8e+FKwo16Ggow7NMbIHILXUuOEmn3fpcPF
	 y+e64K/1zSPIyhHbmkBl/zS8zQPTq3xIc3QajfarQTuAMsU78mlQsPXbROcGhdUwnivM1
	 oExUl+xoVNizgPdR9vpUl5sDRX8HrnpF4yd3r0NfWjebgpqNmMrSvZA1J1ripnX5vkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351157;
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
	bh=DyQQHjoEJxULnN5Ajvw4LYytjIvxD+0flCCAvCCl9Bg=;
	b=KJCe7IbcALdFS0pMLk9tQmO16kD2jmMfzVZbrfNTBWlR9njDW+4laWakgzyh0MYrxGGr
	 xbBz8WPULa0hguUT3XwnykSKlRPvJZ656cj5XV9Vu4j/5ftz9TEua3OXGbBusFVAjeAip
	 UQ2fFUbewgOlmOGgXMw5zwvF0uJQM+dWI85GY1WEQ2kvdZZzcU1EkBvP8DhAvWS1ltOnF
	 f+5jOc7Rly+2LUvvBxifiq1aUdK/aOuUUKCnoCPBW4vE3ahDWkGfahr+yJRl1Qy1/wv7S
	 CBEDb0TmgTbiCx68R2EMV9ZvTY4PwMzbb0bJiYtTci0Me5M1p3G+GBoPXvwLImpkHjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4hvvhv9i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.57
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B2606A31C;
	Tue, 10 Nov 2026 22:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E46B2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4hvvhv9i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXzCmeVKcyNjayT2gX3UlugI6TefKJpvoVhFR8dYtTxOBv8HuP0Yj7Vgl0zJwRkJik7D37fhqZpDe5yfLjXj4OjGaWMIXwwRFYvsqOFp5NIOTdzTZDt8nT51NPlAx4X7w/Hvg/dQuMzc8v7aqFUmuucbQ3dI04C6DcXTNx9LAEj86RVlTFImkZxGp3TxfTcLnBUy9xCQ2G+cOdC8WhJB0d+IofsqNAXg5ICC9jvqSVeoX7M46tbZWrzoqgMrj09PE0sitdoibUaI44bkhVXo+UXokzZl2+m8xeG9EnfXnFPk6g8NmHDd6z0w2j44KR5ZA4pOr+A4a2d4wKTNv0kb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyQQHjoEJxULnN5Ajvw4LYytjIvxD+0flCCAvCCl9Bg=;
 b=nsv58n6LAIPIMk2G6h+KNaj4eRqLuT7HOcp8pJmv1YpDhNnTbMhyvqAFTMSnb1pLV6OIvd66bV3V6bI/kdVGA68880pFF3JHCtBHzYTKxm44nJ69yHGwVxql7XE9lfLWjPkv3h9BrrNh7eL+arwvTFkwkg5VWLMfGyJZtTczpgiEsbb8bH6KJrN2+1ers85bg5nx/+eOV5k0JNhGrMwYNLmyjtamliH9GTG05o4iC9Lz02nAPkpZaO+tkVAWgwdOhgNfvz1hlbhegR5KwyECvHrrV31IRLyRGQ+FcrJBFet1M1l2W9y0Twhz01L1UZfx9W8MprMA8F0V61HPcrU15Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyQQHjoEJxULnN5Ajvw4LYytjIvxD+0flCCAvCCl9Bg=;
 b=4hvvhv9iGJIkRA28HblzdIthkMr0EK6kEu8t8Y73kOr1uEzmdyqNKEuWNHllVMCjeolar1dus9zTRjdNUNz2A1Pxhhq+N10PO/V0kaAWf1XSMHBIpN2OQuFJ5lYsjYmj13b5m96WKCKAqP2Vb/KQPmfu0tjvlUwDvsnqfJ8/Vc0=
Received: from BN9PR03CA0542.namprd03.prod.outlook.com (2603:10b6:408:138::7)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 22:50:16 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::9) by BN9PR03CA0542.outlook.office365.com
 (2603:10b6:408:138::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 10
 Nov 2026 22:50:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC0.mail.protection.outlook.com (10.167.248.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 22:50:16 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 16:50:09 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 10 Nov 2026 16:48:22 -0600
Subject: [PATCH v5 2/3] drm/amdgpu: Match VFCT using initial PCI bus number
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
Message-ID: <20261110-vfct-regression-v5-2-f49fae981bf3@amd.com>
References: <20261110-vfct-regression-v5-0-f49fae981bf3@amd.com>
In-Reply-To: <20261110-vfct-regression-v5-0-f49fae981bf3@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: f94b86d8-d701-4b97-5a71-08df3f7cfd08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|56012099006|261022115727099003|11063799006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261102123227099003|261021123027099003|261022075727099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	fWFNHuHqJCKnxfXnFdJv69+Dox6aSZzmAFvvGyr98BFLRhT8MCUVC3CRq2114ByUXcmMw/fxMlW1rw54e0kgSnlKNO6UGlVsLL8IxZwbCkJlVcnZBZwniphgMxk6YIycFeBxaxRbft/2Y+1hTIK1ce67KK/nidB1XKcPz+lsemaQpmsulDa5mV8qkKmYELf+cD0WCRdjMKG47UNhPqtom/6CnxBoFxYFqns7YJAAUtGtCewFlsIkoIY4PLYPOtAFpkf2ghunuXQmrZj0qeB+4MFPjM27Vr80RFeqlk3cnHOkxyAefXZndZVlxe0YHWN33p9Z8j0qs1LqgZGWHWxCvlcTmeYZs+djvUozDsXS/YDdSNSuTEAY5ZAM9qyc+6Wd1/0vpmqhahBP7hs8bwIJ6xj6w2ZCDkWkuSpsjOcb22jUONWEtkDMPMzIRds8L6QuUL0Cpkce9xWaoYrCrKy5wBOpnMaW6WZCM3kvglz0XrvfGbovJVbWRWuylix6wxUtl/UH5OHKLFAkDKW3Z24SO4JVHJN332tiDLsB+3OSNbanVBa4CIVqDT/icHJkGxLzZMbBMhG9gLN5072RU1442uizgADfmr1irvrAl3Tw7QZKBkEMakIbRD1fb6ommYCjzTjVRt1Z9w23F7RjZ4CbQ2+8qQXIALXthGeX8ixzECA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(261022115727099003)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261102123227099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ULv1m76mWvlXFe6S99EyGfAHa9JA4UNmuRHs8aM0CGmAtlU4UkKksIfz3Ox3AoH+7FS2xStoTNGHwJYtwhr/FEc2AwJQfs9f2EU1WAxZ/LPazMUG6EyGJ9dMtpMEvWFjfwQfMn+BxxY0Oq7fPm0roHvmmBnm1xyM0K1Tgyl+PzUSlKTnJTbj1loQ+girq3CKgj3Ps5KNXL4aPta0gzOkMX1cF3yMQuitrDXZ7d9qnNfhVxNJsO+tUI6DxvS/VVRXrE3vhZKxy+dmnnvq7zueDmWpxv6unDWpuI9HO1m8Pc0w8kKpTz54AzIiDSAU82I3nFlaCMNfrsQhzJhrEis/o6gS0y9OluNeceHjBiIANWKn3qlTdeZA4QchmqkiPz+pGsIN33FdhmRAPDs8EOJIOm7OSvoFtSeqV+yNLpWtMTWOq+nZbj1ZmfnRr9c1jws+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 22:50:16.3139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f94b86d8-d701-4b97-5a71-08df3f7cfd08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409

VFCT records the PCI bus number from BIOS POST. The current bus number
can change after PCI core renumbers the bus, while accepting a mismatch
based only on device identity can select the wrong VFCT image when
matching devices are present. Compare against the bus number captured
from the firmware bus assignment before bridge renumbering.

Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikzadch@gmail.com/
Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft filter")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 08ed1eb695586..a562265eafd26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -386,16 +386,17 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
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
 static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
 				  VFCT_IMAGE_HEADER *vhdr)
 {
+	struct pci_dev *bridge = adev->pdev->bus->self;
+	unsigned char initial_bus;
+
 	/* Vendor and device IDs must always match */
 	if (vhdr->VendorID != adev->pdev->vendor ||
 	    vhdr->DeviceID != adev->pdev->device)
@@ -405,16 +406,12 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
 	    vhdr->PCIFunction != PCI_FUNC(adev->pdev->devfn))
 		return -ENODEV;
 
-	/* Exact bus number match - preferred */
-	if (vhdr->PCIBus == adev->pdev->bus->number)
-		return 0;
+	if (bridge && bridge->fw_sec_busnr_valid)
+		initial_bus = bridge->fw_sec_busnr;
+	else
+		initial_bus = adev->pdev->bus->number;
 
-	/* Bus mismatch but device identity matches (PCI renumbering case) */
-	dev_notice(adev->dev,
-		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
-		   vhdr->PCIBus, adev->pdev->bus->number,
-		   adev->pdev->vendor, adev->pdev->device);
-	return 0;
+	return vhdr->PCIBus == initial_bus ? 0 : -ENODEV;
 }
 
 static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)

-- 
2.43.0

