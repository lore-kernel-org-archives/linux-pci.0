Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792460688;
	b=kdijSeKjio0JcKkfwk/ErIDqEfNYSpGPFyzq+4fIaAZlyu5sJ1g5wDeV44dVnUdUzHk/
	 M0WLWl0wM4HOlMBURFBBKpjNtZML3/sujmHWsaWk+TVkwRjAQgRx/zs+u9C80CK03rSkn
	 LXqhnQFvZzWAKPDOWZKN/aiEXwK25c0YliLb6XzwxBFX2FdEPJ/Vc8ZF6jP/hR0TE0Rb9
	 9Mj5K+/zkbBYbd57XdhgdfhZ1fmGaE6vT2zY6XKuupA2irE4LpOB1TXHNGKWqJYBiJv9X
	 2wmCvwOisREL0ogWOVAzL9qWwWjCSUsdNLbCisL7vLuqGBm//IfZ5upNIXliZFKPo2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460688;
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
	bh=r72CtLyjIfASOM8Q5bGlUWUGWaMPtbseeVoiDGCrVgk=;
	b=XhMGNSLjLKoJ/mcJ65Ar+WfvwHfM8pDeJgAOcjd/dOMPH1wx0p8sd9dnyQ0XNBN5zLMg
	 3Jn35BMBorsNXbG9jTIAZ2xC3Ij/zkvZZahhWffTFSDzw3NCbBvRZJZ0oTC7uk5czAqK/
	 AfHEBdV48XO4Rs2/G+1QwhJM5UBVCcZQD2eMYQoi4uPMfWeA9eFYF7awaOwkqzBXBmwd4
	 D57a5hENePxDHR83t6gSzVshQajmvRkNdZN0X/QIWgE9r1MVLkjOa8xqcqEUW9IR3UxHb
	 hdmDYbm8f5G6W2lpmYUwk9iGQ8vvtG8qJRxZAcIC859agW++qq8LUXqhNVqzfUid1qA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KqDOydK1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.50
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3FC606A31B;
	Tue, 20 Oct 2026 01:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F3FC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KqDOydK1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWQyxApEEQbsnT6Wqwv5uENbNLj+YIQ+Fuo7oe3Wq8HBmoy7tRDH4Zr+PNklcVen6bt/Gen50DUxinbYFzu9XZ+J6F44JRgKdiPiD5yQJclJuze7Q0e24ejdORyAXiFL2aFl6woJ3m1F3C1OKpzAAwPUlN4lZRVrE1/JouZTGYpdsUdO0+C3N1EUrPbEUyDFpkHgJMBVqAwT6fr62A6c/mmQMI+FzZeYWhXTuMrLOg5y3J/Yz9D6bFNSyDTSKlfD4A942E/b6Pd+e+0ZhVxFi2mc7DYBjqV25UmOotKRFm/ppEHaNZRUSt6wewdX/54hmA0mVTUp791/JXqaFP0cTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r72CtLyjIfASOM8Q5bGlUWUGWaMPtbseeVoiDGCrVgk=;
 b=uip7wmO9swTVXiQ6Ycm5YOciReh2TwEPvZn0KGeZ0TFt08exCsE05OwqPK3bnuQ8FzrTJySlf9njs/HnljxgJKBkEIL+CeWgMsdgYfO1t54MqN60zaq/c9uF5P+BP5FtfGh6gVhWk74IS6Aya+KJpdoADpMuS+dFc3Dg3sG3z+ZGkNxhelKNR4F0zBCk3Ufgh9CLTzmU5xkRJdcCTqme40cxXqbEW106vDIs1xlnqhHQPNuYMuo9Wj1KqPjx3cEu4wO/Pmnxyc/Kd1qwGKUPA4kUWlyRfMrKooIMm+miju9KwcG1SPhO1cRcRA7yyQB1gpZt5fAvknldijnls9fH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r72CtLyjIfASOM8Q5bGlUWUGWaMPtbseeVoiDGCrVgk=;
 b=KqDOydK1ZwLKmrhnH7AW5YCsZkquSiQMW61oSJYGQQesg+E8cXb8zKJohTWYCoyTcoirDY0LnT5L6gmQZfB5OZIM6YV6Uln71DfwANn/32LDmoA0cPw4Hp1e3ooCKJwYERihQoPWrtC3tRW7Gq/SKJXoeAXs93KUseTMDYg1SXU=
Received: from DS1P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::9) by
 DS4PR12MB010122.namprd12.prod.outlook.com (2603:10b6:8:50c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 01:44:45 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:8:242:cafe::3c) by DS1P221CA0016.outlook.office365.com
 (2603:10b6:8:242::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 01:44:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 01:44:45 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 20:44:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 19 Oct 2026 20:44:32 -0500
Subject: [PATCH 2/2] drm/amdgpu: Match VFCT using initial PCI bus number
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
Message-ID: <20261019-vfct-regression-v1-2-5a63ddd378dd@amd.com>
References: <20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com>
In-Reply-To: <20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|DS4PR12MB010122:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ddd029-8674-43ca-3847-08df2e4bb7fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|22082099003|18002099003|10067099003|13003099007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2lj8hyVUOSU3kGyxvYX2NRgu52g9R2yCqHfGenRgDRXQE9NKesUR5y8rY4R7D5c33HTsmdoChIV73/Zjr9HNzuEXTB8rJUPoU+TRIPXhPI5xfft1iHcedxPn88I3MLt3QrsPMinwsnJw8O0Cb+f/JbpPpXfocW5mh5BRWQOFBI+pehMgzbM9w+xoBa/L1/JNeviHdtbZrSLJCv8v2g7nBYeD5w3d25EqbyoQcaHnJfe5KtoD2GpmyVw+KoeW32QqtIEl7fHyNr0ZFRa3PjV1xxakzsdKIaGjEX4qwRgg8maFr3a7PgYBLB/3fkea+Y2u9722UjMRP59DQevqO6OGDjv4Mr9wy1gENbyJ12ejsCZCZkAfYM59qRAm3feR0wvH/E9PxMQIVr4zGMtzML+BSWpYWcakhWI5gn4WHLhq7/N0+mJrOr4ihWz7WQxHDwid168oIdGNhMtaOqFzgpwtcrGr8zLFEH60Cti5kED/NGCB9GOY+Gg6IbSX70bpg956083ftpcqwogdQGvnYmO/EmDVgcteeKsR0/hrW1ViQWGx6sXR9G84W8Rvw5vbpJM2zD9MOJdq/Dj/SReJcbA5SOHc11+A/K3DcJEzZAcmitlcGiz5Lh3ke6XzMwmBQ8z95x1UHfCpGi7MFuZYwjjItimDOSojCsGaR3QEe8R2REk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(13003099007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h9IAiPy46tj7Higu5JDJjeL2gogS36D2Xh++lUv28+G6J8REdUSXbCfKSuwTpc2f+9yDbzn9Cze5xhnPEJ70iosMdi7YT2NzBIIzkIgCv/ppa2mFHP1+WZ93O7atihgC4/drLH4gzyfpkBAs6p/NPMKHSqhUKuR5e9y29YRl2jmQq6egLzqyEOo5Dt9o4DyaCqJKTu7NX20/zQ9FVjO3gWSf6+WFfSMY39g4i7+W/yGW7StMAsTe0/IgrN8gzG7H/mV4bfg+QijuEc19zh2Ob/XdGaeMh/CDB9+Iuxm3Mdu2Gn0wjCbuZ0AZvFpgG1dGve02dvF0NRmoIYsHEFwnvTQYq6BlPRdsdHMDBi0hCopWmFTzlgXWsIln8ZE7scb0M8/8z/AzGoK4twtKGlJn7OgvWvu1JDk6FthBQTLKwP+3i5rIuUQnHAmu3rd+bdA7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 01:44:45.3169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ddd029-8674-43ca-3847-08df2e4bb7fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB010122

VFCT records the PCI bus number from BIOS POST. The current bus number
can change after PCI core renumbers the bus, while accepting a mismatch
based only on device identity can select the wrong VFCT image when
matching devices are present. Compare against the bus number captured
when the PCI device was discovered.

Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikzadch@gmail.com/
Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft filter")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 08ed1eb695586..2b375e6b39d5f 100644
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
+	return vhdr->PCIBus == adev->pdev->initial_bus_number ? 0 : -ENODEV;
 }
 
 static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)

-- 
2.43.0

