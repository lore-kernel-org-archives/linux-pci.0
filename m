Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336043F9A08;
	Wed, 27 May 2026 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902283; cv=fail; b=aNF5rC13y/H2U3LpMbq8I8dIhQz/jlLd8sI46RP+Zxbqf9uNuIfhQiDvIqWb1H9CW1qy53AXmrUILNHis+ZUBvg3Ja0+37I1J8kVfotXGof8ReDn1C/5exQMgtO/GThrx5tR2e5VG5TxeE7Ubyr3OGkTjDKjY3WWjADxjS7ZXHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902283; c=relaxed/simple;
	bh=/3CX7jSjnTk8JybAFH9vqP0sta4V7PHcZxcLdcLkG7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h/QvuhDVfmWhFNXQ6KgIPnl/7TnT+Eg+sH0Kp8iww4VdEaWmUtZI2Q0QZgCesKHAKKUke9AoX/Y3ltgoBjViNgXAE4T6CItnd0cBesOb0fSSWBqrSnRgxbdUN67CxEVC9Jy0bIC1EtGaGcTUSm987WH2Ta8OCbsXN9dJrpei0IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OU+UeQ7L; arc=fail smtp.client-ip=52.101.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OU+UeQ7L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9WbfekwSPz5tTXNSKaklO8bOGdY0/+HL30SB/D9TkXxhT25hRD3OGf1oG3UMotxpCyXrxUR3RbqArdHMTSCPT2AWMyEUAEv6b0dKS/UnMbzh1Z37JkgWcio7V0468RJg2F86xWb+TNjeUtqcpK6MIwtn15fOMqcPUY27kZlJkhIZUmsHHf5KEnlTqRxSobwdD4N/9Zzk6gJNYY3wahdPwJPMF6hXMl1H61ejjm/RaNCbwX6PWd/Yh3TToH/JgBRi7lBGAaIF2GWPDaeXmHWMUqUcvQrt5Cc2F7v5qAK4oNnYXQCAOvUP8jjXUvdukWDi5FGYaMKGrX1lZ8VL/WZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wsz+EE5gLV4/gMIgQl1Gvo/OCWMzWUTc9Aesda9Z+vw=;
 b=mlBVHe9VVN6zmKUtmYSgd5OjPUT6q/We27Qph/p6snw04DRCbuW85Zz6Q34ow4pGpE48j4VYiFpIsa8/G10LWcGIWF+2Clwwj1vw3p2EHqgvl6orm+0n2pDEwPwwtJs/1HjjMKoZ+p5kknKJ7lLJFExIYWBiLR/j1Xx0pUH8yJOHaYtfX0dHHoDFVtQ75sF6dDp5bPNhl1mYGKLlkwTQ6kiZWq+sNp6sXtJ9zfG7YWLV8PmCfCJRvbq4tHEFmk/MzHwzrjf0ihdpR6hB1ulsFveviek25KOx9OBJLcWxvtr5AmkeOkZNfEdFecIaU64jsDYigBiPKnGzi3WLAKrJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wsz+EE5gLV4/gMIgQl1Gvo/OCWMzWUTc9Aesda9Z+vw=;
 b=OU+UeQ7LjY8Zv5KFhID4KXDrqiwR/7ghbcHOL2fYi9oL6Mb8AT4yijMdGt3ViW5QHgY7NMyoL8iIohVj5H62bfIhHfudlxIIHTCjAnLrwqaZ3Y+b5XxPywBSGRygUdHR/90OVbtRfYn9nDM50jJpLC0aHsOaoIm7hWacA+EcBzU=
Received: from BY3PR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:254::19)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 27 May
 2026 17:17:58 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::8c) by BY3PR05CA0014.outlook.office365.com
 (2603:10b6:a03:254::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Wed, 27
 May 2026 17:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 17:17:57 +0000
Received: from dcsm-trdripper1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 12:17:53 -0500
From: Muralidhara M K <muralidhara.mk@amd.com>
To: <bhelgaas@google.com>, <bp@alien8.de>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH] x86/amd_node: Add PCI Device ID for AMD 1Ah Family Models 80h-8Fh
Date: Wed, 27 May 2026 22:47:31 +0530
Message-ID: <20260527171731.2370179-1-muralidhara.mk@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 021e7274-891a-4154-de29-08debc13e5be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	eyjiHzBpcZxcEiLHulRQ+3M8VZ9su8mE5KudzF3BqIh5Vi89Bru2lgCjP5HB6/DNkqYNsyVlqHUkvWzywpCoy32KNf6hWewWLeNMmG7B2Q7P4a9pHLqULKkx5YuZ8L16iBVfZccfJqeT5kcOU1Lwm7PgjF3X1wmmsfl4dhk24DcSN7McOKgWGG63nwzUQ76bj3eTbJ8CGOTwmz58wtS1GwjjH6A4AY+Uy9fmc2V6dXm4htrvXOD1vsyIF31aOFSrEiNqJJ0SVe8H71+mseqITmPLWhm4/T7eOscIfOPkJgNmLBYlLlbykAC0xsN7ccM1cQfPDFISU6hwik2xjCWnYm1n8c7inDXUfcZg/kBfmyPXGuHHM6ZsidlpjRaqflpmLI6H/8tFDwe4egpm5ycWFl9t7ob9+NS3Fr2L2SlUz6mZ274TFNvAPzY6lqgOhek2O6V2qC+V69Ah1HmRRPi4tUgECNUehktORO06mKrr6SHxFGqStlHbgiGKbkgsvOGhaLA8DhtOpmrG/xtoQ+zdUvFpf28vOVYzobRe37O+bforgyG/RORFcuFcJUKz+EBp+Y6Y3efO2Q0u8cpG+u/JNvsGh4QmqfmKbCnXGtt9PYIYgrM7HYpv5h5v0zA1QLEg3hT9Vfwqr1sNZ3YgLETDIsZys3Di/EhhkCSEfzwETswzV5CbXrK5Lfh3YiaEqyswmkraTDhiuA2xWbndnoUmt0+QJRIubo1Vw+Oi3RUlZGw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1dPaB/5CCJA67m8FjV6kGNT9MsE0EyFsiRRRGKao94ClwjKYRwDmplXwFWp8R+TL3CdWCd2zWoh4Xgeo2r9ZTriMMvfa/62ikuZJc5PaymxdyZiSGQb4XY0NV8bq9CoD+8WnMslCrJ1XoGGUSurL2UrBa0FP899oj3xN9cSs0uxXjpbDiSHGQyS9GzQldj6/AcR972vxbL6HmDOS73N/eemoF4H7x5+oxo7rPXLz8OL9QlZemyLg7cbqkLVi4xCpy0sq0P0IHgPwXAF0Y49raBG86WarkQGHJRC0kMoGXx9PiN6Wx/RXUVllwreH7D8UHToHdgwNNUrwdH1Eg0IcXt2lMeFaC66dFCAJ50nVzGg2v6rzAEQ3pTK8y4u+k5QJaDPROigw6OxoMoo4lwYyJ/Q2MnBTZA43aEXB11LpFURU0/ymFprU5B+cBKxSQaGY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:17:57.6732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 021e7274-891a-4154-de29-08debc13e5be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012

Add the new PCI Device ID to the MISC IDs list to support the new
generation of AMD 1Ah family 80h-8Fh Models of processors.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 24cb42f66e4b..3301224c5845 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -585,6 +585,7 @@
 #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
 #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
 #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
+#define PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3 0x1243
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
 #define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
-- 
2.34.1

