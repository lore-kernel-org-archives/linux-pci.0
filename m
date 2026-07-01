Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1FB3AD50D;
	Wed,  1 Jul 2026 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887237; cv=fail; b=ml6/pDf5m1UwgePNw1Ijg4X1B4+f6E6S2BjWRkrIzwTrtyhBWckawxykuWgKgGmgQ8KJXIvc7Jvs4VMAYyV1o66IAlQJMWHeQH0Lc/L+Ef/6Jn6EWO4ani6n+w1KgklFcK5E6x7uUQ/WRNg2XMinXz/xWgGB63m1t2tqVvPBGKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887237; c=relaxed/simple;
	bh=HxP0gPBKuQPVoqLs0CmGomoya3Ltvs1Jc78WEvc9dGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDGPAeAiWngVIrvbKihL+RwldMuxIQ5z3uMw1rkdP+GS+k4OZppPw8Fvz1/smTS7xP35ymeX/85VdMeTB98x2s0iFKh6v3DzIk2VrGUTTElrE/QMpcXfgabA0TLu0LKCA7z6EOSlTi2GtksXab0fZhGMcGdSyQHH/1YskjwIdW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iAXpjBzD; arc=fail smtp.client-ip=40.93.198.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iAXpjBzD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/AHQhNqNbmg1ikZCyb2X3UJhgDG6813Ngz+rF3mwoCmYdO2R1lKpayj3Dea/HtSTXZ20ujCy/JzZRUFzgiROPgZfE8whIyzRBcfiDrLwv0mRptF/qMss7CrJon/g5mVFIDKzsE+5BQa6ner6f8+UFTOMCjK1aHKkkNDVwDwWeXdDTTj5TIig8RV6ikAXDKTYJDs9WknDkMUDLH0fWTa+tWuWotg1iy55ZX+Lb4vjJPFsMnoEMEdZo2q/CZ3OZxlWyzANp5spNVDFCLcYkuMtErKKwFHU1Mjn8PCH9xlqaed0sVfiBWjVKAjlY/4hcKifx3dMEGojL8XwNlDdc0B5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx+bzVi3urGsSZg0Ui3hzAdXXze4COoapbrCWtWdceU=;
 b=KS72Ot10Yg6niJj2Jz5kXFoAWKXOoxsV0dQk/os2ZZaVRE5l+10IVqkL9Xz1GXj7e1BO99LYt3WeJQ7fmndLr/z+TtKdczBGKzO2DYPhgDt1aVBo5bdjG4KJPIoQBEBhoW2c0KR9r/Wzw3yuTxuXaszdldxK6E/anUWyHqU8AVJ8eTL116p40k/KJw7xcPOwOCWER7qukaWa82snjM+pP127dc1aoV/0TT6BJyNZDIuDcuQ26kxtMogtKszOCxHlNqHVJotivfgPeFE5c1UsiJ3R1hnmxAQ13WguSi3lCEdnZmDiirsWhlU0Yc9GNC+zq/ohMqDpiYIps20i5FQypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx+bzVi3urGsSZg0Ui3hzAdXXze4COoapbrCWtWdceU=;
 b=iAXpjBzD675EEivUDGtK9QPzkF5Yorl8Ij+qr3xeYq1YaYZXXTYsgutczUjAn1u+k3A5tYW43NykhKxytyFLl12mkubymeTjUDa3oIrTTB++r1l/Vje5qmferEg6qQT0gm7SBnEgeYSlNeajnJUb90AZDqOuvBDQoFcOHxzhz4gASXkiB7cVItaDUhjKBsS+ClyV1GMkOrh632pDnabZ+ZzmD0zu7OwHuLVBt3CWmHroyuTs6JGestC/gQQwOaPxSjcqqskmK7eWXIs6Pjh953q5R9KAzh/osX+TO8kiu0pKDael/7GSHNZnO9r307Evlef2WBabKe/PTmO+ZLb3cQ==
Received: from BY3PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:39b::29)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 1 Jul
 2026 06:27:11 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:39b:cafe::41) by BY3PR05CA0054.outlook.office365.com
 (2603:10b6:a03:39b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 06:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 06:27:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 23:26:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 23:26:50 -0700
Received: from inno-dell.home (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 30
 Jun 2026 23:26:39 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>
CC: <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
	<ecourtney@nvidia.com>, <joelagnelf@nvidia.com>, <apopple@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, Zhi Wang
	<zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, David Laight
	<david.laight.linux@gmail.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH v3 1/8] PCI/IOV: Return unsigned int from pci_sriov_get_totalvfs()
Date: Wed, 1 Jul 2026 09:26:15 +0300
Message-ID: <20260701062622.3499033-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260701062622.3499033-1-zhiw@nvidia.com>
References: <20260701062622.3499033-1-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e10c328-ea90-4a83-0c68-08ded739c88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|23010399003|13003099007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	R0xCICzf5V2e2Jp8LseFAgQN/Mh31pSvjhmR9/Z7iMZcol3jFtP0BIznaYRWVp5ZDtUXb8uWTp9kkqqBygm91gSXbYOQ2XJKFyi3uJ+rLbjhwqkEhkGAPR8Mb7/gf/UtLPyYJC/4Nd3vjepR9Ow8FfzVtQTzmkf6poCE/HeOOZ3/Ak+2aSdwbRlbFI1y/L0R5/GhZzEJEIX48N8MTXiy7hIJzVEFYIzsgLlPmb08YbIuuM4CY4ApPu0HE3r7Va278ZGj7obJqI3zGY4Z+ms2a+EyhjwYqDaS7i8ZDuf+FXo8JLezY6MDYY/UyUi47vSg39elu2a4S6gClN8gpze1xV4Zvd0NcCtJjTD3VY2OdGmbQe7Utt7ynZRPYV9IMgPGMB5dxnDs9xs0yOHRVVKi4lEvYvFf1d8HPMInj+/kkaBv/2MIBIZBfx+XUS0nrMqZncm5LPL5WfQMEv7j9LBv63QfJDqIUEWJ0sO+P3ENMyHihVqvqcDdMYjA8CpRvoEndRct5RElWxwLPaUl4zD9zMCeBr9m9tcFpf9oyLj3xrvKl6D59+DFEbstsT85MkZwJwxvVQItvoqEBHI54eAEzKpqs+HPnKyKVWWouLusiNDho6y3SRhG3kxSet0jZoeO/AIjGZh+Jtd4XukGqC7kELWS4p/tjMSZ2NRzsAc6jxQFwuleU+//t4t87zT/gccoo28Yriv14i49pdt2YR2fZA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(23010399003)(13003099007)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Nziw1klfNmxoQxCQ/Umcu1hA8tH0HI+C3nkaUZfqoFXhXkZKHVJ+TVoOPmsOGUjBwNceX3T1L4HjH8tdknAAGtqfAfTjKlEeHJNXRjK1ePtCP90hP/bBUuX4Uq9xcJKMmR1Km/tjUeWgBb8Pw+oeVQj1SlH8ZZSfGO5SK0XmPvZTwsLgWht76mLDt83E8GJYSVu4Vs9xw5Mb5I+V7UbiRvuLMZVTsPiVZJoNs+ASy0QRC72p+Zt6PqDr9DC+3cyGU4dMl8gVSiWt8df7i5clM0Q658NYUKzpAPhjDznHEgl9GkS6gm3+2x+I73o/Ku/oRKzax5sTZRInhzlLQ/ZKNliImjGJ7ExU7HtT+1wU8zr7vMVuzpqSsjqTDGhxlwR35FbDUZOxOkNIXD8yT6m8W2paTvGswPk6qc4ra6ja6FeExZryjglvV04hw4jFMSUC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:27:10.7945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e10c328-ea90-4a83-0c68-08ded739c88c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863

pci_sriov_get_totalvfs() reports a VF count, not an errno-style
status. It returns 0 when SR-IOV is unavailable or the device is not a
PF, and otherwise returns the PF's driver_max_VFs value.

driver_max_VFs is stored as a u16 in struct pci_sriov. It is derived
from the SR-IOV TotalVFs field or from a driver-provided limit, so the
implementation cannot return a negative value.

Change the declaration, CONFIG_PCI_IOV stub, and implementation to
return unsigned int.

Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Laight <david.laight.linux@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org
Link: https://lore.kernel.org/all/DJHPRE4TGGT8.BUTMYOF5YE05@nvidia.com/
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/pci/iov.c   | 2 +-
 include/linux/pci.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index b0d24839c084..9d408fb8ac25 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1283,7 +1283,7 @@ EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);
  * SRIOV capability value of TotalVFs or the value of driver_max_VFs
  * if the driver reduced it.  Otherwise 0.
  */
-int pci_sriov_get_totalvfs(struct pci_dev *dev)
+unsigned int pci_sriov_get_totalvfs(struct pci_dev *dev)
 {
 	if (!dev->is_physfn)
 		return 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ebb5b9d76360..2b9c61de5f67 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2569,7 +2569,7 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id);
 int pci_num_vf(struct pci_dev *dev);
 int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
-int pci_sriov_get_totalvfs(struct pci_dev *dev);
+unsigned int pci_sriov_get_totalvfs(struct pci_dev *dev);
 int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn);
 resource_size_t pci_iov_resource_size(const struct pci_dev *dev, int resno);
 int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size);
@@ -2622,7 +2622,7 @@ static inline int pci_vfs_assigned(struct pci_dev *dev)
 { return 0; }
 static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 { return 0; }
-static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
+static inline unsigned int pci_sriov_get_totalvfs(struct pci_dev *dev)
 { return 0; }
 #define pci_sriov_configure_simple	NULL
 static inline resource_size_t pci_iov_resource_size(const struct pci_dev *dev,
-- 
2.51.0

