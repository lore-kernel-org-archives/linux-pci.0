Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794351025;
	b=Kjk1ZGX/+AsURANzgceWyonh4KejcoXYbauQlnAn7Nam4ei4R8GBoszTjXzspGAkVhrO
	 PA+JXOEZxrsAizbkRBgEWKfXh+TGuNV84Pc6xENY2afBPsuGhmKudR5iJiSzWDDskQ6aY
	 80nIFbq4AQKZOv/1WP1bohiFeo+zy8rl29H5lrJBCQLb5Tb7mk43vjw2RZJXy/eAFJ80N
	 Q+lOiJJS7tNvvYsv+OSiqws+liuQngcBOlTJw97dQ2QAIHA9/SV2hN7ZzG7W5KJxzK+RO
	 t6/Kh7s+HVC26D1ONxu1FqDYS9T0WljBcq2a6bjBsPEyyeluKq3b56+jc0JuPYckxTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351025;
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
	bh=w1oTmajYB+D9pPHEvpBIHvOpaYz2Wgm5gEEJjVU6M+k=;
	b=xkcVskBzIrr0pc9dhHnFmLQ+b13TxFGCmAIVwrfxDtf47AxQmWNXZ9hyB0YOqSdW2nir
	 gkzkJNgu1xoa45+Ue9j8jnDWmB98IUSmh/uZowfGlh+kG4TjbWf5Z0075hDaRyzuYe43+
	 zmV1caw1TK8l/BQ2KNG3J+xulJyrxx3qtkC0wOMDi3VGuuJ+xT5PKGNgNXUA4mSziLTLz
	 Y/yCCEB8xsSVq3jxW+nZLn9W/j8JIVnzLlQaEcW7QtA7imIbGk8tZpOl0ld8LkQEe9SYO
	 ALZnKy9f/xwM9kSNcG2LgUxW2pIqbME/nx77+sb3Qbc5spNU4K52N/VDI5k1Rc37VGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gIlY6yOo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.14
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E498660A2601;
	Tue, 10 Nov 2026 22:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E498660A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gIlY6yOo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvJSFFc0kNaF+lnyNHYvkb2FcZpoGiIm+zIthJac95JMciw6oRAdBRgvLH/INgvVzkkeZH05IJfU3Y6A8jQsgtLxHI3aXrVKlYKuxPR/INujv+v2jT0azNwBjwT+wgWLwvgGcDnDv8F5TKRusZgB8UTvwrqxYUdQHNJZkfbVwS43kO7xzVbsMGGkPD0Ecad2LWEjM8nmberfRUu+sr0yy+fMOn+VrZpVTFh+LaMtLWQ1DXXr+NI4Vme2Dy67UI7ZhvHvdVGKax1nuhbK2AMA4PNqQkLDjmcHSGjcoMVDMMJ7rAfruWpk3QTuOLbqkJGY4XwEa8vE+2nv0fkA+d/rdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1oTmajYB+D9pPHEvpBIHvOpaYz2Wgm5gEEJjVU6M+k=;
 b=WcAeRW+mqYRWEOSJ3uVltiLMPr5SQaqjezVR4oas+isbp7n1BYHX85xpJh8LnNVs1JtMRwcoDRDmY+802xX+Us4UetsYpd8EHm0L5sCNNAt39ZqdXsEhzIWV9FyAA7ZqBqb8+MJd+P9XeOj+bsL9TtHJXiCiNmFZHlkuqfKkk8VXY8VTZu7AUWiuO1HfPaZmzblBVfJKvsUsBB6lzh27m3HaEyYA85e+nTrFUXosD8ldZLCllkzd8BkhdZmunr28+P7L0LfidmBYZ8js3xuGCnFDIFsbBrIQJHuu4iqTT0+Ekw+mfc1iiN/fD7WiAi4CU3lsw3W/VFaBghm/4bIu9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1oTmajYB+D9pPHEvpBIHvOpaYz2Wgm5gEEJjVU6M+k=;
 b=gIlY6yOoY2N1ExSmxJcUxtTZcW6H17aOk1AmlPiF7dKak2vKtQ2IrRQdNqKKVovFo5Yl5j+dTbhZawvljdUstQX7HJcRQTtHvg6WoyOKe3X5Z922w2bpUKVfWJGHxVY8xmrhoAs9m+rBWfElxRYs+c70OPtiwhr59+rrnOdVftQ=
Received: from BN9PR03CA0545.namprd03.prod.outlook.com (2603:10b6:408:138::10)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 22:50:16 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::42) by BN9PR03CA0545.outlook.office365.com
 (2603:10b6:408:138::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Tue,
 10 Nov 2026 22:50:16 +0000
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
Date: Tue, 10 Nov 2026 16:48:23 -0600
Subject: [PATCH v5 3/3] drm/radeon: Match VFCT using initial PCI bus number
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
Message-ID: <20261110-vfct-regression-v5-3-f49fae981bf3@amd.com>
References: <20261110-vfct-regression-v5-0-f49fae981bf3@amd.com>
In-Reply-To: <20261110-vfct-regression-v5-0-f49fae981bf3@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 768ce1f9-abf5-4537-ace8-08df3f7cfd43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|56012099006|261102123227099003|261026140227099003|11063799006|261022075727099003|261009223027099003|261022115727099003|261021123027099003|261022105027099003|261021121427099003|261026121527099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dtV4WRLNFoa5Gc3ZeoBzxBNFyzVsTs9KSzcLikEjwSrR0tEZy2uokUyiJGt0/MrfEK6f+rXIQ8UO1DW6TIepQupIPmhx+83ue4BzrTDx8NC4R3hM84h4nGzt47byBUAx92ndnlNZXmTmsQx/HbhhEAT5UamhC4/JfL9Dwjd+TK15xGodNFaM4EvfZzhIMuUNZMWpEEX7/G8QWhqgRDp7cNg9zPNZWmaz520ItOne/tS0zifqphUXuUwrxT3eZssbymqkbpg46h3QlHdcNW6m5/mQSNcEDzdso6xroQGQkFiKFnRH5NThhXvbaEHGPEkbfxq2lhu8lTd9GH2N2H8meXQNrBPh4izoawRmFyOV8Ixcqs0tm7ZCXqp97AXT8kJlyQFHJ5sVe5f8WBZ1odUDri14fG+Lbzf4J5kmbUlrjjKn3ig+QOPtJ2QT3ntVDxjqNKiQMK+hLhvaAGm/MEPWUP862ocy5K0JnZiMWKp5rHbvMXmEFpfYGA1qUnTKdXoSg/KWjvWQ9PCaKGzvfKwc2Qz9qrfa1JXFKmsVtePerNjqiq9NlSrtMl8NiKpvW/x90zoJYaZXY98oE95brtzzC5yEx3/EtPeR1c//mHzRndKKYwp7fZ/tdC/y5RRuyY+JFjHc7Rv1q7KU2KeZ0WE/7Sp24EqYUxLTejK7w+mBy3JGqFfWc/Lt7h26WRopRz0PhJNKwiaHR9U3Sfb+vL+5rw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(261102123227099003)(261026140227099003)(11063799006)(261022075727099003)(261009223027099003)(261022115727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dyIa/I4Ud2sKmnYF1JyTyWjLeCdZc21R1diB/aP8jQzOwt72QuLz3/kQ59gtsAds/GIbZnBH4aoCFyFb8NJ+sm+HysCL63wy44KxF5HUOykTlPzFj10b0YC2Em5y3YX1zr0taFQlzEJCJDouOOEoLjAiDCJ2I5pr1GjFGNcQla7gOgMLdYV+2KdBM6B0AZE625znzOKT5kzJQqaFcK5RylFIQFfqpH6oVN9gSIhvuaxF0U+Sx3/FaGwX1GraVxyWsF5e8cQrkyo0/7Jv3p1LrWW0Z+sv65EK6Ucd9Xz1OipzCmY7pxSLFlNL4T7TnccWnFzWJjScY6TqNxy1CqeXY4ChHsNfFQ0/kUSFY82patEQoF5qNfnYou0WLCvbyJEMjOUxwW1e7wpP3XFkRDy5p1CTpTl2sYz2riwzE6twAAc8xDjhmXl4N2WXUwTaMp1b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 22:50:16.7074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 768ce1f9-abf5-4537-ace8-08df3f7cfd43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773

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
index 1da6bf1c17ff3..e888c8986d7bd 100644
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
+	if (bridge && bridge->fw_sec_busnr_valid)
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

