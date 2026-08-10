Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EA73B6352;
	Mon, 10 Aug 2026 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356622; cv=fail; b=AHiYJue618aTwY2rOvjN+qrkVMRzHLdgBItZ9mMiommK4RRTbGHRB7FbQqhCL2nQifHsLxcHJRVmH0S7jXZA+aRDec515BDW0P7Tm3SbMVk+3yUD1KHHOp3aeDCvFjG44GMX35jANXZMkC48A+vwjeCnv9uZi7v9/vgylMdFAFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356622; c=relaxed/simple;
	bh=6uK05L0olvQowdfE/g6vew9Eb2llVSWfPF2LfGJeFD4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SDvO+1HegapvS616/aykUn2QvxvN8TMFzbC53e2eY6b3hZrOZ7134o7q+Xy7rXWsgPyckiyEOW65w+UomskSzoWetodAaCjm7BHoE0cnyQ0QNvX+mPbLANSuzq4X5+B12egKYcvEDIeKHUaTTFNst1QTTeTCLhdEDjKIjncduhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lKfiTSq5; arc=fail smtp.client-ip=40.93.195.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lKfiTSq5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDKCyJQh45Uze2SSH39iZq8+AVG2uc3sD6pq9D7C1G3OaQs6KN0PMgtoT2ZbqZae9+wnlShlWN3RyhHoijSVNqwV6aCccbinkji65SmZOb8hfp/n0OxQJFhxAGt3I0JvEUHdUkloAItHpwX3OLt/25Ke3Mxr7ThHtQQlOF50fic/+LtJFIMC/t9l4XgmlOlQ+2JRYOy+S45rfWRYizoGbl7eOss+DekJK5hn0EA/8j8OO/Gi87XJD0GQd1eEQ8rTqR9qDIPdLkOTU0AzaL6MVn3fW0bRTdBuigvQsd4UTj4I4atzwPzC8O1LC1vzRKyrCFzJQH8Yun0SKarhP26tWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpPmMuN+WvICnPdJYm7pCwyF8+RZ0c0oy8WNS1ncPEQ=;
 b=ravVy3z6whX79CU+JnpDfn3GhKiDE/rXumgCAluCR72T1SOqBzxf87lM1i9QIGEnMrg3yOdaSJ/pgT9ZeKtjQua/6h9qJF5Tj98uhqWx6u8FuLKVtE2YOz6A6FqSNtw/HEtGQKJ+tWEKPWnTrSiUexql1Vp5D23hpsviqzzERe5P8QA+2RdA66DlgpEmfIK/U/84Qb0STAmIPVCdT3FjjGBDxFhHJtzHrcO4khvXAhD/N7vZq6j9iUdIAxymugjXwgBtxYVjZ3ShMyPeJ7aernBGidjHTobSQojdfXXvStBc9BSriphd43QLGPaXINgk+PcU7MAOKUj3tUeOwhPeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpPmMuN+WvICnPdJYm7pCwyF8+RZ0c0oy8WNS1ncPEQ=;
 b=lKfiTSq5Prq86YnviD7X5k4V/lzdhQNeUsH+4cfxBRPMCqkLeEtjHhR6GXdcmKjxOBk0TrfLjCtKt6lyIQLibEzo6SQSkZdVjApIAvP1XIi4mC8vyXLh/WML3Vf/HzhBjvCFLQ4D3mQ+mwsktZQKDDkcCUA7U+oWbyqCqzkarQY=
Received: from SJ0PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:33f::29)
 by SA1PR12MB8642.namprd12.prod.outlook.com (2603:10b6:806:383::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:10:18 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::26) by SJ0PR05CA0054.outlook.office365.com
 (2603:10b6:a03:33f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Mon,
 10 Aug 2026 10:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 10:10:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:10:05 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Mon, 10 Aug 2026 05:10:02 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v3 0/2] CPM6 Channel Separation Support
Date: Mon, 10 Aug 2026 15:40:00 +0530
Message-ID: <20260810101002.1726131-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SA1PR12MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: e631684f-8eec-47eb-ca94-08def6c79418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FU6BBNqkbeqXOxhf8aRoL3yeaqloKKkbxM/BKjvbrr7nE88JxbljCq3LIzLCtGpYKXFQiarEDCCQUppN9tZM2Or0VsAgvvOGizyNeFJaqB9jGs/VeMsvmvlP0bLwCzoMpWSP+YiMBrzJrxcaSv/e3H1HLQhawQOvgfZPYcsM8WXvOG7KKG4wOAUC6Y0czPPNAUQEWUnidq1QHgbPEoLT8IGN1CFTbH4atYLIU2IG7GFSEaI3i8EThUvvXAhqpMpcyb75u+aCpfL9X7ikwAsT91GNY0XaHLgYniGXUD15AJCTI+rigpLyR+sdGNgSmNspfXMp+8SU/lWPJ1m8n6NZhkpZXDn0mXD6Q65IYl2+KwTJIqvQBO+A/jAEgCUk1DtWX/sn0xG9V7gijrtyK/3PULW6vF9ypOgvQIx4iQ5ylZJan8U4k46LQb3CtHoBPpLAQKBQinWWwMsOPlVH4iWJ37mqfIJ3zCLH1smbl8fxQMKuTGEhSJbuBQJskj1cmJw1xVCVbIj4Xy+PtZgxC8gdxQ4GUV7KFfY7yoO7SRpaFyJFnFG7LlawdmETT5wGAbslTpVlqNoika5cL07wU/vAltbzCxbtmsIH3bGM+kG+kYOmf6EOB0/MSwMzVzbDqb+ok9AoyoshK0FCaBIiq5oll49gdxu5TzZ8K7gnXHIx96Expavmpafilz7iS1FhKbiW2XX/RgxLvmnLTbdliyqgFA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vNAYK1D03mVxlah0KckJOpeq80ZlGGyKh8cWwjt3gapxo0zPjPpNH8D4CYsN8nO8T+HdendqSQO4pKLE1qidooVPg24VlZUH77N/h5h0AE5aZXNRHfsoUY9j1LrNr/7fD6H/w0q9nJIi7bqLdaen/L4gwVKiZP9LDm8Nbl68Qa72mRU0dfbWoqrsRZW6KjnU2QWtGIgV9wgXyLZsfozqsFTptauhWjUWYKmTYKesf3KmnCY715rNFS0/kpjM46+oqVLyl3+chX1NDAtPRWOqcV6MaFk+OJ8/FF+lUJHy/2utwxy9yc8W70LxwIb9T0+lG2J+1DA0/2viX9l/srAF2fN762NAbWFgedfZNtj0gOlL8avzUKLS7jgfACcafMrH3G13PDMy6C+U8esieSazv8ieSjqvcMUGtWPl9+KHFQdi5v1Ck4cXO8npe2MAHduH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:10:17.5656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e631684f-8eec-47eb-ca94-08def6c79418
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642

'Designware Cores PCI Express DM Controller - Reference
Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
the channel separation mechanisms. Basically, the HDMA IP allows
the user to configure the separation between DMA channel
registers and retrieve it via the VSEC capability mentioned
above.
In order to use the VSEC functionality following changes have
been made:

o Utilize the existing VSEC implementation to retrieve
  the channel separation and translate it to correct size.
o Modify the structs and functions to calculate correct
  DMA channel register base using the channel, direction
  and channel separation selected.

Devendra K Verma (2):
  dmaengine: dw-edma: Enable Chan Separation via VSEC
  dmaengine: dw-edma: Add changes to support Channel Separation

 drivers/dma/dw-edma/dw-edma-pcie.c           | 24 +++++++++++++++++---
 drivers/dma/dw-edma/dw-hdma-v0-core.c        | 23 +++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 17 +++++---------
 drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 10 --------
 drivers/pci/controller/dwc/pcie-designware.c |  1 +
 include/linux/dma/edma.h                     |  1 +
 6 files changed, 43 insertions(+), 33 deletions(-)

-- 
2.43.0

