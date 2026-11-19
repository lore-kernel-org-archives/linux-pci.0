Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795116094;
	b=15mdH54EQamcGD3Q+WYJs8oOF1oBgs+M6IIeDsIrJMJE7uIb1EgLy6SV1PhHLn5efTj5
	 1HO0NEv4N9Uh4q3MPvXOtKhIEyQUrUgdBAy/xs8sH5Wp4vSBWILzSrxHqUPpozwX5UP1Y
	 CQqUTYJGPIhJbJPCR3tC+hS9lKe2nu5KuRnHpPmAoo0oghI+P0uut2dr/vviSurd7A+Ri
	 7IUdjWndnQM5lH9hSHqT9Q02uLi1ak+CL43il753KrPU+FIHtEdwp7yVVOd4ADNLTqsDx
	 JszhfcweOgdWXHAecP7GmCIzKQes60cM4OigT5esgVRJJtnFvorUfG19UHqzwn09qmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116094;
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
	bh=/DuTUFYaqM0/Hx5shphRYfzQFRDSciy785KAlvSkA7U=;
	b=Z91Qek+hF1xW+97QZpbFjxv2Nw06THcT0xkCoDSr9KzpTV8pxpPK31/KCdCAjqhkTB/O
	 Nj3TDQ9DokmLmM8Qny3j9UO9OCxBX0zJK2SXvUxuDWvhcmtG3S+Tig/lXH0UzG4KsmygK
	 rTeY4GGS2+mCc/sNLtGbQs6mC9m0y/kTcMSAbc75M/FlaZiRVeu7JZRyWkVfLBYuetvv8
	 IBpGJ7I0O/Q0P+XDmgjZPNpYSCvmV3iRIb9djZUSMB1zrPWHJP4LMfERq6oXL9UC1hlpZ
	 JhjgcPL5Ek4JHrK99q38IZjv6YipRCVGbSB30pOHVs+nQtTbsx6gz6HC3g6PZyDzwYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KfG5EflX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.58
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51597606A320
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 19:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51597606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KfG5EflX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6pMe0VQubwMxHjthoMHQwzzJbrMnsxZPSqi3um0kQpmxx6D+g2MwvxijAaMduhNuNoT5dPrF9uPpmz8CRFWmqALfZauJtobhxD2m8r/hwKPuPDTlOX+2Q8sKfUNZJgUOpx6LSPkuFAMCfp9j0HI6U1IOQLyyC4D77BvUgx8WDcKd/gdhZxvwo7sRaPSPfvaZZfqOHThahSYriYKNpfhJ4nF5fHK1j3+OWIOyPgU3afvl7E9awWzdRTdni+hCObMVyTQQP8vLJMGUyFFRinMY/saVtaFrXlCvFKJ/kIT0bToG46n8LA/4h6PH6lYRuh/mvhkq2P33ye6q1KVcKLRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DuTUFYaqM0/Hx5shphRYfzQFRDSciy785KAlvSkA7U=;
 b=tMWPTyBiUjmd+N88679yZiu/7LJ0K6DrfWmBMR8RffrAYWAdEtuN5WG3DsBs6hgoybkFAn607tY8RBYr1nRowGTaHfPDgcTP+LorntiT9n6q1s0Kt6ZdkBplEy62AhTdre6cmHd9KasjnoTW9FVCKO+xolb3KMl49VsjxcEU8+x7W6BLeYxw7JOPyNBCcVzh2/5oV2hJWtP+3L/PKwgL5iz652LNDUdJPNDwh0X4OthpGkV/A0keBun8CM4tzvk8N7CtrQwwcBgU8BZjPJl/kPphs9V05rxiRT12OARD2j+dlpInQwRq8EC3uvTWFqU39iHHWLr1O4B9G2VFHNLdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DuTUFYaqM0/Hx5shphRYfzQFRDSciy785KAlvSkA7U=;
 b=KfG5EflXEDz4UVXqlizhNIRvCN9FzCb5jURtKosnSIiPuo9XnbcvPYxSp9cFL/0RWpHG9gSw6djRz6byR1PWe/RVMhYsMwiFFAwfoAJw5NCt8ZNKx45aZR//AJyGzfLhc/tVcw8Av/koYravi+aZc/+ld94UGXFKLnYpVsLmeQY=
Received: from CY8P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::18)
 by DSVPR12MB999172.namprd12.prod.outlook.com (2603:10b6:8:38b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 19:21:27 +0000
Received: from EA8PEPF00000007.namprd05.prod.outlook.com
 (2603:10b6:930:6b:cafe::6b) by CY8P222CA0011.outlook.office365.com
 (2603:10b6:930:6b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 19:21:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000007.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:21:26 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:21:24 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 13:21:20 -0600
Subject: [PATCH v8 2/3] drm/amdgpu: Match VFCT using initial PCI bus number
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
Message-ID: <20261119-vfct-regression-v8-v8-2-12463194e457@amd.com>
References: <20261119-vfct-regression-v8-v8-0-12463194e457@amd.com>
In-Reply-To: <20261119-vfct-regression-v8-v8-0-12463194e457@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Alex Deucher
	<alexander.deucher@amd.com>
CC: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Lijo Lazar
	<lijo.lazar@amd.com>, <linux-pci@vger.kernel.org>,
	<amd-gfx@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000007:EE_|DSVPR12MB999172:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f89a5a-40aa-46b2-ee91-08df46724e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006|261026140227099003|261026121527099003|261022115727099003|261022105027099003|10067099003|261022075727099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	/DyXIvVPS9RJCTb6hMgEgbDzD5LmTkQ0ZBZzPHWhmK8x0sOxR1w8BwCL6gGKoMZ2uDeeRBkVYKG57UVaItsbc+LZ/FERLDqm6HqVtodonSUbktoX+U54YKaVp7lsnq8FcpyVGeK0dAxQVrGf6GJDHwX8J8DAxvk+9/s7RXhMcU/oR1/GlXJ3G7n6OuXEEMogWg6TVv0wVruEVC3hj53h2EmEgDBxEbIjEeyQ2Vf0jIsgtpFd+7nXUpEUU8zBThesw/5gs6xcVilHLbKVVim6qDwK79kQY3BPtVoUoMMLXuDWvmz61fH+kye86cSgwuxEifPu9ZTngMqPgWJMMW9RckfVxud5wdbBsvYhLKJRhyJZRJXlHIYrwF4B9AwPfyMIe8BCYV5v7kPf0VcDgTGpuBap6rtJhiZibhjwPmuXfFgzZtrhnXS2DwVLfu9RHAJAiydvy97OYq49Ar+u0QqkYLVYfGtZeKBnIIOojeyBc36SdUuqbz3GGqfWVAWVYegZ5hoOCgKn7epvOWO/XFfdEt0ow+mD5qZcHN/J5KXJ9moDehh3nY7AS6YsVgZBTbRv2K8qGAv7Of68NJqYTX8lZOtJgCh0OwXCxyScOYmLEhin+21ujsIG7Mi+KrBqh79rf2MDhFczgjWa9YDeTHGtCw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261022115727099003)(261022105027099003)(10067099003)(261022075727099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2QY0K1zAK1I5LW5dK0U8fAvXK53mjRsaVWlkViEo9W14h+4VvI92dMAXsbBX13SOV2eWYDsZsNtZGbHxU6aBZZN8UdjSg9BsdcN5N1Ck+Ke+rkP5ClJTR+WlkE7Abz8SpUR7umHrqbjLK+//ooVvEJGF9ZRZD5hFvaNyXoWB5R+/f8+2hWgxKYOaEwWE5IX/s5qPza6MvW0fET9v5EYelyC8onv1nQC+JbdGB+VTescMKbK6PqJQTqhkx2RWzlCA0Cy0tAH0bGSBb6ui6tQHZMZDwEV4BSyC/rK+8hdKHqkcpVaCg0R/33iBGTbp5HHitn6+7BoFbbze9UQjfNOBJKyn7ebGjE1Z+VlKaTt6lju+hH+zq785XB/fbdkTvKME6LwtvyWZdxnJllzia3ZcDEbVPi7+nE3ATJuNE3WgK/Ac7iuwnjZZBu5hbcWsW9yz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:21:26.4989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f89a5a-40aa-46b2-ee91-08df46724e73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000007.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999172

VFCT records the PCI bus number from BIOS POST. The current bus number
can change after PCI core renumbers the bus, while accepting a mismatch
based only on device identity can select the wrong VFCT image when
matching devices are present.

Compare against the secondary bus number of the upstream bridge at
FW/OS handoff, which the PCI core caches before any renumbering. Fall
back to the current bus number for devices on a root bus, which is
never renumbered.

While here, return a bool from amdgpu_acpi_vfct_match() so callers
read naturally.

Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikzadch@gmail.com/
Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft filter")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 42 ++++++++++++--------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f9315e0472fe9..ec5509e36f848 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -436,35 +436,23 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
  * VFCT entries contain the PCI bus number as recorded during BIOS POST.
  * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
  * resource conflicts), the runtime bus number may differ from the POST
- * value.  Match by device identity (vendor + device + function) and use
- * the bus number as a preference: exact bus match is preferred, but when
- * the bus numbers disagree we accept the entry if the device identity
- * matches.
+ * value.  Match against the secondary bus number of the upstream bridge
+ * at FW/OS handoff, which the PCI core caches before any renumbering.
  *
- * Returns: 0 on match, -ENODEV on no match
+ * Returns: true if @vhdr describes this device, false otherwise
  */
-static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
-				  VFCT_IMAGE_HEADER *vhdr)
+static bool amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
+				   VFCT_IMAGE_HEADER *vhdr)
 {
-	/* Vendor and device IDs must always match */
-	if (vhdr->VendorID != adev->pdev->vendor ||
-	    vhdr->DeviceID != adev->pdev->device)
-		return -ENODEV;
-
-	if (vhdr->PCIDevice != PCI_SLOT(adev->pdev->devfn) ||
-	    vhdr->PCIFunction != PCI_FUNC(adev->pdev->devfn))
-		return -ENODEV;
-
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
+	struct pci_dev *pdev = adev->pdev;
+	struct pci_dev *bridge = pci_upstream_bridge(pdev);
+	u8 bus = bridge ? bridge->fw_sec_busnr : pdev->bus->number;
+
+	return vhdr->VendorID == pdev->vendor &&
+	       vhdr->DeviceID == pdev->device &&
+	       vhdr->PCIBus == bus &&
+	       vhdr->PCIDevice == PCI_SLOT(pdev->devfn) &&
+	       vhdr->PCIFunction == PCI_FUNC(pdev->devfn);
 }
 
 static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
@@ -503,7 +491,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 		}
 
 		if (vhdr->ImageLength &&
-		    !amdgpu_acpi_vfct_match(adev, vhdr)) {
+		    amdgpu_acpi_vfct_match(adev, vhdr)) {
 			adev->bios = kmemdup(&vbios->VbiosContent,
 					     vhdr->ImageLength,
 					     GFP_KERNEL);

-- 
2.43.0

