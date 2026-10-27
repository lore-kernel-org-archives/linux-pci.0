Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118171;
	b=yOs82gCKpkVic+Jr4eOZA30VfGHiORIQLDLPs50Afn0OP7iXvm1+dLmjjjDUImVlysBN
	 PrRgCGqDqOhWtlppP3ohyKEWLWpUTPf9/1D4Abkr0/Jrw5/Yjoxj10I5rClQTgWzzJOrE
	 HS+VO7uEaJEES1u7CJdNVyDRB7V+dAqO58eNYFkF1EuZg7IQQf2iwESwmN3RwLm4+zLEJ
	 vGyGrsqQRm+wf3s9NKIu1VLAwb5XnsgT0xSUrgLe2Kx9x2Ef7iDmgonMas294o6hjUxf9
	 Qtd7dj6AbFeM/c/7vzI8QvVzxv8Jw+DpIV68lYqCr97itQA/ieXP3ReFq8IsSboc8oQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118171;
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
	bh=22ywsYlIXPLEZhJs/rKkSRGb+sdBWcXQ3G5P+0AZq5U=;
	b=efEKK7MJQ94uzS/3g1Rrdhie8/5IZzQONyFTfwOEtORFAzXDHJx7E1j93njaqOk32md4
	 lQa88vYzF9dVT5M5PvttULIXx9ya2iBDpBH1G8bdLZLHtSlXNZyhv5ulmGWNFJVI+smEs
	 phWZsK12twXdlyB2pj6Yf13W+lvQnv/LyEv4ZPEpsao5/IhRYso0AbHNp3/z0tLgWEhSJ
	 w9SuZ68+l8JVSnHLxvkWHvh9VQwBYqxa9U5CCTrY9KSo6MLrwdEc1fKu1a/Puu79vcNWf
	 2W+kNGmDCrue/NSWcVtfMkeQuM222eUtddAo+d9S+sm9wlNvdyknViyrmTGe2T6UCAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KKkscxUS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.17
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EB3606A323;
	Tue, 27 Oct 2026 16:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81EB3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KKkscxUS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzRiFpDYC1oEI/UQt+dc6x7pC1UKKQT9J3vinfVtUyEUHs14RQkai+OWy1wW6PM0pwjWVnKkIRuVSmYw201pMudnU+owLSpvGdvzUamKOKTWPk1AQZY4/wCR+JSZ/18xmQ5rtdceEVNrWbAAO4ou8thnAv+i8HrC3r1E33kA9FQWAYvbZ5GY4mXkfVCO0jPuQDQCkoP/V4UGXZvEQAAlsTIMhXdXZp156qWxHiiyvtlOeLDYz+fK9Kj8AG5hDB1/FqPHBNwKJNEu9WAZdpdRGaeXhY2koD71IrbeeP2OOC7rUjV1ytBnDNjev2TUozZHS7UwuZ/zw9DN4R5vIvBH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22ywsYlIXPLEZhJs/rKkSRGb+sdBWcXQ3G5P+0AZq5U=;
 b=pPjVmQ3u8Imu5xLhavC3qPOh1M0odtNLOxLEno31lnb06kClczOV5Tps+YnMPwATK/hgjlQTWBYzMFkdC5gkidruTT80R5IbEP2Pllz6hJgZg2b13KGaqSeS1bjzpTIBhlwpVkJ2pnuMGIlQmpdVgbxh+g4QNU8HXVFRBhSJPJfMqDQyr8DfZefpknBG8P0+ASIEh6AuTJB1sqQP9yY4v7Oifi3QoWX2jiLyzI4cCY2uXG6ZqOyrdRFhfmThwYQEgmSoGeuhJBBTLw4Q5wLuJ/QgmxGCN9VJb2wzmFOBYqMEE98se9Mk98TmZ2ewTWSjzlYyo6BT1r8euxVTjk5ngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22ywsYlIXPLEZhJs/rKkSRGb+sdBWcXQ3G5P+0AZq5U=;
 b=KKkscxUSlKuwhcdzSl/M0lAR1PjZ1MVyybq0sHUfPy7pNDkAHcb4G6cmPn+n9y3PtHMw9vCUDRj8Pzp/ceY6fhK+41s8tUa12H2bb+RYL1QfVntw27Wvj8+Ei3cAx2/MkWRXsmfOUGfcW1QDq9wQYE4JtvTPlE8rcwvkMJXECd4=
Received: from BL1PR13CA0404.namprd13.prod.outlook.com (2603:10b6:208:2c2::19)
 by MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:22:46 +0000
Received: from BN1PEPF00018073.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::62) by BL1PR13CA0404.outlook.office365.com
 (2603:10b6:208:2c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Tue, 27
 Oct 2026 16:22:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018073.mail.protection.outlook.com (10.167.245.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 16:22:46 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 11:22:45 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 27 Oct 2026 11:22:27 -0500
Subject: [PATCH v4 3/3] drm/radeon: Match VFCT using initial PCI bus number
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
Message-ID: <20261027-vfct-regression-v4-3-0e7190e39c2c@amd.com>
References: <20261027-vfct-regression-v4-0-0e7190e39c2c@amd.com>
In-Reply-To: <20261027-vfct-regression-v4-0-0e7190e39c2c@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, Mario Limonciello
	<mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018073:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: e16391a8-29b8-4795-9b05-08df3446895f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|261026140227099003|56012099006|11063799006|261021121427099003|261022115727099003|261022105027099003|261022075727099003|261009223027099003|261021123027099003|10067099003|22082099003|18002099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	7OciLDbswdY73iBfVxzCwM95lho7YuQfXOS3djUMa6lBQkQ2vTRMUpgf1Eg2FWqccr901vwPscn+U6NYmW6cX3NoWaAsa/fgIDF7HrADywB/j1YmM8me7o1N7pViCE/ou6kFp2CEeFRREQMpCAt/QjT85OOJs+Y9ASMy3OGuf5q55uoQeF6/XJrq/9kowBTuQfze7XkIuPQmihJ8bgtxqsMvRBT9KTuH/halo2akS4wCd+7FBtlA4gsiFGt0QQUBTKejgGwuYvtS0P5vo1nG8+AJd3pdj7ZlLM5WfhUBg00in8OOke7eTTzgBuPiDEdI/i1PsXAhj6PEqbfGC+j4Sd8F2VoPgGTkcVLVjHsZ/tvI9+OjddHd0V3m9u9NjdHRK2KESjcAIKkYigh7giJgbzDS43WWoNthYoYTwvd9kaU7ay6CpB8CEvkWzDZLBIk8/M8G924QOXiB6L0HT5Tjm8C7vbhwtYzrAaGsIOUSy02h0nxAXuZE4tHN6KQQSWu47t0skY2uYe3ZRbj/WpMMVK4Pq4yTfpV1J6oa+PjHoa6fMuzWWvvNAAOW3qjwq7O2XbMMAr1QMP5cv3MMhRBL7NUgFmw5wuadIt7EVPYkPDZvwHz+3DIwwFmEnV4xVp2QeMMRXv5HumFs0qqij/SqgaBqIhF/dX604kO7Yc/vdGkHskUjWfeI+vR5/yOkxdOI8lE9x5PYMrAgsnc/v4tDpQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(261026140227099003)(56012099006)(11063799006)(261021121427099003)(261022115727099003)(261022105027099003)(261022075727099003)(261009223027099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WkJuOTve6gyS/eN6QCbVcOW7EQDAhQvakMJO59ItvqRTS8XSd/4JghX6KxLt9emZgFxj4l181ZDrb6VLXLRi6XXmqhKWlmORa7XeNDUn6bHWjJaW/BhOB33vX0amHMGkm6/yc30CvGPMVCFAMzp10MscY21/RcV3XXdaXbtnz0TNi43AbH82nUDnSyoxupG0vAt8SND4m+CLW2v9kruA357KE6jo+0M+A2vnMymy5LgUvnLzpsUUZh5WutuGtkDOg0NTc1HZIeXruJvo51qntf6jMIngwPYYbHLNdCOdV6/GvKbfW71kIFJeNUoWVXCYU+eeiU8wwe4/MMCE/eVU8AQaqV41o44DJQb0DGRTSCQX4zr4rEL99u1N+7oAbjjuyHOTJ+LMuMPMpzBnNfwuXng9gbtThqKYmYSr/LleqXVQnLZmQC1fn0kmuaBLLdJp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:22:46.6547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e16391a8-29b8-4795-9b05-08df3446895f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117

VFCT records the PCI bus number from BIOS POST. The current bus number
can change after PCI core renumbers the bus, while accepting a mismatch
based only on device identity can select the wrong VFCT image when
matching devices are present. Compare against the bus number captured
from the firmware bus assignment before bridge renumbering.

Fixes: 4059e2f02c8a ("drm/radeon: Fix VFCT bus number matching with soft filter")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 1da6bf1c17ff3..bdbca4fad6b8c 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -609,10 +609,8 @@ static bool radeon_read_disabled_bios(struct radeon_device *rdev)
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
@@ -628,16 +626,7 @@ static int radeon_acpi_vfct_match(struct radeon_device *rdev,
 	    vhdr->PCIFunction != PCI_FUNC(rdev->pdev->devfn))
 		return -ENODEV;
 
-	/* Exact bus number match - preferred */
-	if (vhdr->PCIBus == rdev->pdev->bus->number)
-		return 0;
-
-	/* Bus mismatch but device identity matches (PCI renumbering case) */
-	dev_notice(&rdev->pdev->dev,
-		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
-		   vhdr->PCIBus, rdev->pdev->bus->number,
-		   rdev->pdev->vendor, rdev->pdev->device);
-	return 0;
+	return vhdr->PCIBus == rdev->pdev->bus->number_initial ? 0 : -ENODEV;
 }
 
 static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)

-- 
2.43.0

