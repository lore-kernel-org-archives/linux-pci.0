Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029746;
	b=Knr1BqNFVMngIpqGyQkdZKlfRbkFNaJpYkikQ8c/V7l7Z0w+MUoSrSjBmsEQA12ojXv3
	 NSnEngGMh1pmwHmpghHxdHLjAoerKeM+HEjz90EmYv6CnNsnUqFDe6++jDM0OXao3A1FL
	 6sU8q66XGzEaO1jHVZdDJLS04dkPxJI31g1HnmX8iFAEx/hhDWlMpjKuRqPSBnssN7XWu
	 qhimuQW/7sHgxwnHwm401ED+H34G5PcvPmNvBVmb4JMGf8J6xFv2yFEU/QQTClgss0pK7
	 W7JUyD1h9r+HiR64dmF+UdUu3K/rzgBVgDTlfMlSTBwYTra4y7TaSZpip+NvizTH/tQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029746;
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
	bh=Y3YveFxMxw83M3Yd+eCUAaJ7wBgNOrXPCdK3NcMjPBI=;
	b=2xz9X3yRL5OwTo/TstbhKn69zGyToU9r7W4m3CYUFO3GCY1A+dzPoKvU3E6Pg/eRJy6t
	 cNsJb2yV/LD3gQautmOkzCP4b6VQW7rcvou+WL7CHthBhMeKw0MgbBGN2lGvyG0g12uKV
	 B0vK3IS3ONhUNNb4EN2y3fW30wJo2s8eWsGfCpRvk/Lw5QEFn82KwdeZ4jX6dA4lbttip
	 aX5bg8Oij6jzu/GVM7yBbZUHUUxeeJ+eO2wLpF/SkqK+FqatYhtmGYQJM1wcHj9d3Kjjl
	 SjldkYq34mVB+qcgI/hjyxgessoaZ90+dkOI7kjarpg0u6IrPI32VNgVNKz6FVJMewQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tG2IEyU3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.66
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BCB606A323;
	Mon, 26 Oct 2026 15:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04BCB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tG2IEyU3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBvKEm5dbK6sjg5WyyUpmgN0TNl836gc2eD9rihR/+0yI3TZU+xWbnfghKOvG7TlDQjeVVrM+KKhzNeqbOr/WuuRY/A2YNLC5Kh7VjLQeP7yn/7uwZKAhzEXpos/h6QU46pR9Oy3cmo2w0fJTzfbI1FfPEvWNUmXEQgp58NzN2hoaLaCzLNcGi/NqUUIdpZ+SjR9a8i8FmcEz7X/GjOqvhoQFUZ1cuHFsgt123Krvry51ic287UQ7cZ5JMfckY5BXdo2FDZB1SDBRxgSxMYt93sgaReeo3PaRLbPOOaM9Qzly+y3x2nrJ+3a00iYT6pRibm17+VuZWanNDCx/PALcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3YveFxMxw83M3Yd+eCUAaJ7wBgNOrXPCdK3NcMjPBI=;
 b=RkGTYwrBHeqX575HYIAyF2b+D/8N6mLteCOtJ+qdNk5Syq3uI2SuYBaQ+tIDgNJyYy+UiXCcyXmW78BfxszLqruVN8RK161+eDTJXjYdNwDcXpK0fXPCoj3yQTuMSZYqT5C2u8aqtGEe7yFj1GcX4cBWNGXfjNcxSbBbfUEbzzBE6flSZNqH0ni/8XgpbGBcWbrir42yoO2dtDm5eX487oSLm1nK68lxjIGXVxfdMhIUQbbrKjEgCsBUFicNjgtU9f7Z2Ihqe8vTSd4hXoqGaKGNOsUOvyGEsIuy4RCeGfu2VUjx+mWjlNRMn3JdV0u19M0t2cdq0M2nAsWWoYMYBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3YveFxMxw83M3Yd+eCUAaJ7wBgNOrXPCdK3NcMjPBI=;
 b=tG2IEyU3jY1P2uZydcXaZug9BvkaeMRnoOrB+NETSgwZ2awvz+gSXLUycu7nw2NFc1vV4wu/3vZTqY+1f0BG2h+Yas5jbVUyl/Btd7kd3KS2hhV00TO2dfk9w3pvTlu9gsfpC3NMr+t99HqY8PfxWbzz4dZwFoZORRfbJTNGfbg=
Received: from SJ2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:a03:505::21)
 by AT6PR12MB255547.namprd12.prod.outlook.com (2603:10b6:170:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 15:49:02 +0000
Received: from SJ1PEPF000037A0.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::8f) by SJ2PR07CA0019.outlook.office365.com
 (2603:10b6:a03:505::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 15:49:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A0.mail.protection.outlook.com (10.167.244.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 15:49:02 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 10:49:00 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 26 Oct 2026 10:48:33 -0500
Subject: [PATCH v3 2/3] drm/amdgpu: Match VFCT using initial PCI bus number
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
Message-ID: <20261026-vfct-regression-v3-2-fe9586ed6978@amd.com>
References: <20261026-vfct-regression-v3-0-fe9586ed6978@amd.com>
In-Reply-To: <20261026-vfct-regression-v3-0-fe9586ed6978@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A0:EE_|AT6PR12MB255547:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc0adbe-ec62-40ba-4175-08df3378a852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|18002099003|22082099003|261026140227099003|56012099006|11063799006|261021121427099003|261009223027099003|261022075727099003|261022115727099003|261022105027099003|261021123027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	4dG9MVn83/XY4j7Ij4nlWOhFwxLeE670JjVrYRRIJicqq1yHM+9fqEH809RI3EbOPlD8Y2V3UPf33qjnsKW6Y/1wJmxiaJyqovTp+nqKUyEkbhQqJtNlQk0eTL0tBeM5fWREgFyaHyMMyS6bGgpC2Q7FB/spjLELNlbXmsLXCQiT3DDVDG6vPxWovUHFbt9PqMhQIsSjD9rpNUw7EhYsnuZ4LKndqPBv4j+C67g4J0vbtBUmaTc/70wkRuPSRZEsBmKVBFZ3MP9w/e6xqEXiwyhAKP/PowUK1ZmA6MYNahQDd53L7+rq+w0ml8+3l/6XhTaqg2KaertUXJwm1YXsm98dHEE59fE8Zwf4+v9iw8VZhzRdrhpI2UGFssft+nZqQSjjioWKIC5+DKGPqcZ03K6EYdWrY/9MkeUFztCLj2g36swnsWBoWpGAP+9015S3wVXnEsVkN1jJlE4coO8qcQwt54qBScXM34Dz7ImdXojKG8/XyXugkQ5C86Odf7ZVdqji6SW4cXUdj5VlRvl/+gYIkRKQHGTP2MYN6SKn/ZwThXMRFhrmpztNEhv6eBlKva5Z7JRPm/zXZDSyJXVE72SKbeI9yk/Erk0FjJQkRxMk13OFM1LCNbjAYesRx9Jj7UXwnKLGrZZdf/plIbsfnZM3fgIa/ArF/lPDMKMJOpg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(261026140227099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261022075727099003)(261022115727099003)(261022105027099003)(261021123027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xb4g5mHPhbuNI5Nt7T1rbOKpH0lE70tBZndnMguWQuqSfZ3r6WnYtH3RwEQaNbAckGjExQO6foPCUy9kBGl/QkAS2AI+lqLvU+JLbH7DFFP9DD+HnIoEiVQ8/dCeyGYC4pq8MVM698OlJRFqLA5n0XTYbTAEqms6X92YDYXbs8ej6e/LFlgeQ8C0zYtlVRYyIWxZsyLeM9DFEYnr3LydG31IgIif0l5zHSsDsDVV/mFx5go55cgNoYmI0NaUBdnwj2l00h0FeoEIwNicPSRQKZ9L5dwyLaiUGYy9zF/gSj1qIm5zpw4A82mQ86NdHzOTuRJVYPcWLVSOaDulA1QeO47i2tdJIxHpiLZqECFuqOLNCNp1djCOKWXpQHtxjo6O45JFqMxY2CuRBE6Swu8bhG5HfOODHw790GHSV54dJeYpPefX8h2E++MaJ/k0s8Zn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 15:49:02.1675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc0adbe-ec62-40ba-4175-08df3378a852
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB255547

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 08ed1eb695586..051be1905e296 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -386,10 +386,8 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
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
@@ -405,16 +403,7 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
 	    vhdr->PCIFunction != PCI_FUNC(adev->pdev->devfn))
 		return -ENODEV;
 
-	/* Exact bus number match - preferred */
-	if (vhdr->PCIBus == adev->pdev->bus->number)
-		return 0;
-
-	/* Bus mismatch but device identity matches (PCI renumbering case) */
-	dev_notice(adev->dev,
-		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
-		   vhdr->PCIBus, adev->pdev->bus->number,
-		   adev->pdev->vendor, adev->pdev->device);
-	return 0;
+	return vhdr->PCIBus == adev->pdev->bus->number_initial ? 0 : -ENODEV;
 }
 
 static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)

-- 
2.43.0

