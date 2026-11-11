Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794415429;
	b=xLP6tb73MU7IdiAIoLMzikZclhKwqyI+C0U/7MuUbB10KW6dxB+R939jTgVLydsRRidd
	 4PvWlrlgAdYDu9smj6LQOn4f32aK7/zG+mnRwQ2cakpMAvvyh+qd7/3lQB9G03BlTFrW1
	 LfFNVSuDGOr+wuUDIgTPmlGRMbYVw3DSL+I40kMQYrsRwv9sZE0lRNmznIKoIH/bJATjj
	 3OIRWAwn3aTpQ78ZOWKccQudp/prP3nujlorvlWKyUBPTGSUu176lndIe7vWlch7BYMiB
	 jCKMhFLhVcPFKOPbl5amMct+LZuKYYf7dJDpylTzzSnVEDffCvr1b6LomrSkcRNaumw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415429;
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
	bh=GvEtPhKA0/v32b7y2MVPCN7d/SVffvp7nqYfKBD80us=;
	b=CMaWQEvI1UF6WUTCvjjhtxbOXpSy4DXU86bDn/kG/W7X0xUHSXS/MPyPoptG5BaWrHsb
	 Fap2+MeupVHRq+rQXi8up925PbXBtK+Ff0Zkhthtfqy+hExMj1wqTuGG+uuzhycqFzKEF
	 e0vvFlpDrleboL0L9UuQ4PO3xfy8cTIQq/o6BfAMF7gR4BQEmbhpI1KJQd+uoFpkImWkc
	 B5u4V7K7BIQqYtQ4euBZwV+RpnulC4S+o4BVcx0bQfAo7Mrtuo+Qyyxlh7fjZof0iz0Et
	 +R7EVfWxsa69IXZlueS2rLq4j05Q3cc41IvZAUlHRu62VSKbxAxC/WXy+60ZtElS6SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E34mLKdh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.11
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F4E606A337;
	Wed, 11 Nov 2026 16:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8F4E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E34mLKdh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIJH3VhBGRq11Gv964VP9xorqBzCFPA4Cj1EEqiJPe33YJ4F4DHZh4ZYi4SCLHZwW4i3tsY4+0t1vppKhqU+rFgvyee73BmjuV7vWjQe4zjCjkwZfeJe2QzPMHHUr7wiCn8eCBuu9g7BhZnlq68elxnL9vArgMRZ7SirsCCkBmdKdPygZnd+IdhfPK/Pm9MMETvwAa87rb4m2Y/UCq/Mknzfqf8W6FHwfN06lo/q70xEVt/8GDL7ygAlHJ6+6oSbhx2lVv7QNdFz0go8GjJg1shmMlxvccU7fAMqiU0nPx+4yN3vOgpcZApj+BlN2rdyXC5kUW7intFvc4aoSpRfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvEtPhKA0/v32b7y2MVPCN7d/SVffvp7nqYfKBD80us=;
 b=jfwxSqtQ9nK4hhQVi2+e0PELJJ0gd7r/OrfKKapIEbIiyR9Cgi+EzBf6CSpYsd26QPpBKjujJjWnyXXr85KeNtJXVYnFrPQBLD3qG/VtgFWbG79JISySQ3b/F3lWce4ydDQ/qBn5iX7/k2aqIOyLNuR1aNiD0J9Fz3h7D24gO3HzlfI/qwiyeS/BaqYXKsGW9eeMl0IFBDzk/7xmYWt8E5O1BLHZ+4InnJa8dDD/ctLL8anrzvrhMr/HzOa4kw1jo0cDdGEjMhlxndSxWZEUqEM4TywUJ3fe6xW/hG86hUs/sl7Jjroaa3pLqxYJoD7VzrKeBYwjU9C9ffNP6M+Nng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvEtPhKA0/v32b7y2MVPCN7d/SVffvp7nqYfKBD80us=;
 b=E34mLKdhFvYI4XLBFAlAmiVX0T4QKYOwObHVEWuWT19SzTG3IXhZujKJ61ErJ11+pH73JDGrgpwvZ/AYVnzrXNUtLUEYcsGxyMkpnTHHRQKfMeto5fGLlBC/XYrRdfG4CvqNMtqeyesDGgVYGYDCnlj30OEkUcWoEIV6+8WjqsE=
Received: from MW4PR03CA0027.namprd03.prod.outlook.com (2603:10b6:303:8f::32)
 by DSAPR12MB473869.namprd12.prod.outlook.com (2603:10b6:8:518::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 16:43:46 +0000
Received: from CO1PEPF00018868.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::18) by MW4PR03CA0027.outlook.office365.com
 (2603:10b6:303:8f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 16:43:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018868.mail.protection.outlook.com (10.167.249.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 16:43:46 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 10:43:41 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 11 Nov 2026 10:43:21 -0600
Subject: [PATCH v6 2/3] drm/amdgpu: Match VFCT using initial PCI bus number
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
Message-ID: <20261111-vfct-regression-v6-2-393797bbb6e3@amd.com>
References: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
In-Reply-To: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00018868:EE_|DSAPR12MB473869:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d0ec7d-fbb4-4f63-ab3b-08df4012f472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|261022115727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vNOkJO+GKedIO9y82uFEWJPGU97BCEBviX2Gt9bh6jQIqjoCMliBBD3A0V8PBmUzuH471S5m51oM1dqY/unE/vKQgr8yBX9kkFY7GtBbsJsC8A2G1l8AS4RC1A8BBxpgdBCxgUR4deJIuwwLMjmCuaNn7HnACkxSlCbDJlPfBBaHtaBGqnRS5ywxBPLYaD7laa5aUtig1FLWLQFek7to7P8qxvoPOjHyKvscNqxHLYX81gjwPjdBneuiSFec5LlNgqmIPT2IX2TFH6AMljTHOMrVwLWuBNdY8WQN0aUv3LAMvqvikJZV3NYc0usj3CUYLbIZSyCfS4CkQUu/dnMF/0Txib5pXvjWzX9QhTHZKl4nSrnlzB9DsCBO1AGj9ICGgQJKVm1I/EwPuRjFGDcfndOwVIoo1BZxy/dyP4RfhKAZ6YBzzxi4C3OoQytXdEnR6ugWYT48pu8F2fI53TXDvwPe7fTbnoV6qvIbFJc3UIkNUaqXFWnjkUuuj8dwFz4KZbtxV4IBkU4lP0cXMkW7agOgSFeSivceDAos8qfHlosDJZvr6WG/6HJ+bBpSlxf4+LXvmXBXcGCopg0Ue3OmxVY5b8DnqLtSY8YPo3rGfa8OK8rJNcp/vXd8JfoZZ9KohnSbo708LI53fWffGOjXWD7PV7k2XWVmcBUciYufuRg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261022115727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u+AWvMiWe7KRZmqNiTk/U2KWq0FlBajyAgb5ov836QRsDwtSJJ4qHUKYMwVBGXRbTiVY49GlK2T/nexprZswIO46hFHDO84/1qIvHpaJTGEcpNwRQrpndFR8Zv1L7lb4BBZtFPr2aL0Mb3MI8LO3cMAiM7qFcB1ogr0N8FugKGPx+xvrKsHCo5Hm9msdju30JqUK5H4myB4FhLVrV6muHXwIZR7QUF3rxJ9dQcwSFdduuqX6gjLC/LNPw1qXUU3IaXDOiD0ch6NwxX47RSdM+VBKlUF7cXZydRX3w+fxfZDp3YymEhwAB795yqt5rlxjXWCC+G8uX2LKrCs+vBDsBycj34uUL7oCz1lWJFY/qhCeGpGUZE4iMIwCOHxyf9IjizhHZVtsCevju6Aafe8N+Ga+6oIr44tx8qb2Zyh5oCTB6kNP/zB9rn9tXITkBc9h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:43:46.3269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d0ec7d-fbb4-4f63-ab3b-08df4012f472
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00018868.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSAPR12MB473869

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
index 08ed1eb695586..0ee4c6462c4d0 100644
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
+	if (bridge && bridge->fw_sec_bus_valid)
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

