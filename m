Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52AA4A138B;
	Wed, 22 Jul 2026 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719011; cv=fail; b=M/9DeqUUM3XoW8Agj1WZ9QpawZzHHeAEmzp9aMV9yXDH3Ga4FWXIV9G5VmprVHHAkasMeL6HoUIIj2uQc7bi1StEunlNhPyVVRKHvJSuRro6TQYCsHe+JZtLplL7a6vbqbs3ACt9deSZ/SKPiYyfwgltXdAK2nC4bF5iroLLUlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719011; c=relaxed/simple;
	bh=uCyDWA6NL0xnhBvcF2jTHYlBUf48mPHBH7/rHum92jA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YxOpaFocP81nXcZtSOxvEl5/r/NEqBLksk4hvrsWo4lYsf7SOmIPvsOXMIZ6sBHvtIHyYa+H59BINEnuYklscnt1+Is8tj1FtWNXkpYZkjy5O8T7lYQQOxVbTzJuanXIExSihtaSO5KuSxegghMkPATjDLqJdPNEU/Ke2+FW2jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t9TDTZN1; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t9TDTZN1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ud/C42BKuN2CMJkUey0OumprQkBmYZ3oRjMii94hIrIm6BvqwBJzz5sWUws899880NqsVj5WiFxU8me9zq78CBfvfSecAbBNv3pV3U2e21rFwjli10qGuxlLIFnKkM4A3enN74HzkaFUggu1CDDPr1jH/yUM2Xg2EWImkxMhigOw3yjoSlq9XEfKvPHgvyQglSM0VRfHb5ti0ly5v2+EOfzxu1ZDj2xth+SnH+abnLIHTF/8zXA1zXZOUbtgRyQ4v4jCcc0POhIVemEF1ZcY6yxMGhmztfd7npVNrjGGDjTw0OHjWD4r4lwROUN8W5KBjt+TQY+OY0yUbxRJ+BM+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESdSrFUUKauhFpkZVQkxqlxw49HekbO/bhbWhnMveT4=;
 b=GTXYYPsno67pw5dRkO+dyquCJifYpWXkKWHG7gzMr3gwNIw1dwdJJbXuX1JTDUX2iZXGOG7WSdYEgTR1P9D0IdJjx5uGCERBcEvCy50ArWqZPUwBVSNbiZBf2fds8f3z5Kwlbvrag7g+iUPu6ySBKJZSnIsxT8GebqeFxpF6t7KVAZe/RbJI4VqtHsDnme8t3PVuLoDjsfVu00dNKZ5snL1Z2qioWYmWmFB0y4SPKh4RjspFHLfxnSgr37iu7g/4LmaKdg7jXK0WU6akCCDkfCt5h8ax6yAw5m4h5wmH+PcbB9ZgUDTzNINbtm+X1dYOzyogAsP7O3DTdYfgJYryDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESdSrFUUKauhFpkZVQkxqlxw49HekbO/bhbWhnMveT4=;
 b=t9TDTZN1aFpPrdG797f6NSja3ZX1qnjGMOz7NND1jvQGN9CbPigXOyj980ZNB704G8spZld2OIVPYhks7uXTobn3pRqD0Or8X3hpB022rlg5B3BV92UDP+DkAL2W0zPjWd/5t2CCx/fnITgf92F6u1FH/nzwXWzpQUCeIrBj05U=
Received: from SJ0PR13CA0116.namprd13.prod.outlook.com (2603:10b6:a03:2c5::31)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 11:16:44 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::22) by SJ0PR13CA0116.outlook.office365.com
 (2603:10b6:a03:2c5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Wed, 22
 Jul 2026 11:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 11:16:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 06:16:43 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Wed, 22 Jul 2026 06:16:41 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v1 0/3] CPM6 Channel Separation Support
Date: Wed, 22 Jul 2026 16:46:37 +0530
Message-ID: <20260722111640.1146212-1-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: 86609ccf-0ebd-49e0-4303-08dee7e2b6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Hcrd+idhQF0mH0w0+aKednSLt9Lnf4/vWYrZaxud4eTb8NkUzQ+EKL23wtn36z9/pXJIwO/+en49FIqfJSk9P3UJES9+xc8oyKnaQsIvgCPKI7MXixVNJsuTaF4xdPA+QQyI7thRGhhdt91Ji4+N1Ae95B4hv8u83yeO+EcsV9YAOi4l7+pMyvfF4iICOYd5sNIPtFZqFLV8fO+iFJdT3yg9yp29CRfjG3BJv6hsncGWm9xfDzuXYcwphZ9D+ikVOCdemlELPLoPUcEG/PkjS9LpinXrjvR1LgUCXP3DWUcBpwBg7El8YqhjwilGMytQ5WRZL0HulVBDsv7ruQrn3w8nCObftc64aYnjzQospeM/gZBGg7d4FwKXd6GJFjcWQyj6A7/Dxy73myYLDWUJyImqsNup9q75UVL4AIolCXN5tJjSi8phqa+awPaV2Oqltg0s3COZOv6TwF5JnYjIejhzvW9sRL08ftVDmD8tfzbieLR2Q7+qWZhi0pt4BIZfkK1Ijt7QKsFzGhxj7R16L7JXRjaduQ0GR8E2ScpZvq1AJsV7afC8n1SpBCFxblodgm0NBc7DDVKlkX81CfVeAd1p15SmghbRF15X2r+XHkJP4G1gcPsdTv46yuo1goERurAk1FLPHG7lkO1+S+u9aezu40QMl4nMWFTRQRZHf2yYma2wnssDzHrfvrkVNJjKwV/9npnWsLKTxixAE/KRHA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7y24RgFy93Mllzzh8+Rf/1AUxu2IJz+mm6jusmO7EdwjSgcX4pCAwECS+167eHctIbWU2jeugwaKHs6vzav9OKg/SorGaiZ2eCeONVGMgbUrwo3aHkLBSaiNpcO63PwT4WTPjLhFt+oM9iV0Y3Ncwc0hvS/wV5KvHp06FL8wKpGo6H742U83HIEwjzvrSGry/sGMVxnfkNn55gOz4f1XQ13+904tjbnO4351h2YzLW9jtYCjykoavklN63HNuGRkDt7dHggbps/UDESb1qtOnsJVlous74556DPmogMpyWVH+77X0/jmWsM1ZAqQDLrFlRSddNM9+OsEQLK5+WmhxQT/fHcpWZFWpavX48ibjE0rC+ZbkyxVdF8jTx1qSCA2Tyvw8fYOYpQ1ksfFYZ3vipsN5XH2FONetM63iOCtv+VpVnkXmxQRX4L2hM3r0jLY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 11:16:44.4561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86609ccf-0ebd-49e0-4303-08dee7e2b6a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417

'Designware Cores PCI Express DM Controller - Reference
Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
the channel separation mechanisms. Basically, the HDMA IP allows
the user to configure the separation between DMA channel
registers and retrieve it via the VSEC capability mentioned
above.
In order to use the VSEC functionality following changes have
been made:

o For Xilinx IP alone, the macros declared are made device
  name agnostic to expand the usage of macros for similar
  functionality.
o Utilize the existing VSEC implementation to retrieve
  the channel separation and translate it to correct size.
o Modify the structs and functions to calculate correct
  DMA channel register base using the channel, direction
  and channel separation selected.

Devendra K Verma (3):
  dmaengine: dw-edma: Make Xilinx Macros Dev Name Agnostic
  dmaengine: dw-edma: Enable Chan Separation via VSEC
  dmaengine: dw-edma: Add changes to support Channel Separation

 drivers/dma/dw-edma/dw-edma-pcie.c       | 87 +++++++++++++++---------
 drivers/dma/dw-edma/dw-hdma-v0-core.c    | 23 ++++---
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 17 ++---
 drivers/dma/dw-edma/dw-hdma-v0-regs.h    | 10 ---
 include/linux/dma/edma.h                 |  1 +
 5 files changed, 77 insertions(+), 61 deletions(-)

-- 
2.43.0

