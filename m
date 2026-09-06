Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A563546C2;
	Sun,  6 Sep 2026 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788674666; cv=fail; b=AXp20ycBPJ1kyYKfTErb1QOp2Y8V8vyWfWK+4Ewmwae2X2XPt5PYktbTN9UNiBnhYSieB0SmE9eisLnh3BF2/WWyZeyx1L68/INVVvcdktPMU8k39RbE2GjCuzl0wTJRFveowepJIuHKOgldzuQ8wnmp7DK7orB7oMI6T4kgEDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788674666; c=relaxed/simple;
	bh=VhWrkoU0WgCRAOWbeYWWcc2PPUlyEMp0lDogUSIUT2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o8RfRqVH+cFrbRNo9GupeyUxsCKm0i3Db8ZyWuI5vjD5FD5dedHGXPEqI2/r64y74q6iJjKnijz5Y/4qFcPY1U7KcDUF8UzvptZ69SuquYJsa+QwkiLRNJg71lcqYRgUwE50v8EVDnoU8uZtzfEWrghAok0KLcurJyrwk2cAVBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nSgBaGyy; arc=fail smtp.client-ip=52.101.57.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nSgBaGyy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGzSlJzEydYuc9M9bi+YEIaJx1vTRTzuwRWRSHB/0bdnF7bWRKShCo6ult+jqiyKKI7PBygfcEdGIJcmXGMRnYFpL3Jt+TT7TnKl/uqBkkFPcr+zW29UzvJmHJ+HKJwOMnAH0Cmh3MMHBUSa5TOitStHEItdUC+jNebjSOID2aSp3MRzeOrqs9rVH/DqvBNmozl8NF+UJ971KpDX5t3WvCUKSLKKtHBLLE6TSfm/85RWUT44SfZxFGmd6nkGQDz0eSyQI5G2YvoAiTuKjeesOXdmKKWrSiudoelmGrVLA+Y2UN9EOe040ZzR1vrTYvZFQ8U+5ZSREahjGspenyFbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iKkf1F6RCWopq5vaOaERef8DnfucqxIgEnbKd7Pv2A=;
 b=sJMrdZNyAgxd5dcYAHbX2YGM8brUuL3TFI4UcaV569Hxi2QT9pIFfBbQohCK4fVSg846iMub5FJxT5z2NjC3v4j7EyuGyVx/wMsovaMRS848aez898FtRnDpW33ufzFF2IoJO/jstvSsczKUw0bn5ziWYNu5MNH4E7o/EElN/i/wi2Sh8m6kzo1/wssfoydeOd9oXcg3WO6S3im7KJ12Jy6lxHsi22AtSVDeLqM+Jo7a6R7CK+kHmZHT8U3lNxFgoLDGhL6+wdxkD0vyTUW+OqZAXsTNLRdBRa4sWRqmAN0UCypPDPgGDLVeD8uD9Fl3jUT1yQQwe32M5NqJ6ly9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iKkf1F6RCWopq5vaOaERef8DnfucqxIgEnbKd7Pv2A=;
 b=nSgBaGyyN8OZEWhVeDR53FRSCMTMx/7TOgs/0tGP+zw+Dvb8lt3TDKSkEntFiDxNPFCXcqFVoPIFtdmI01e5kwY+u7bU8sHdgFcROExPmKKZeOSEPPxWP+TkJSZgYNAwmCZeF1yzYQnJPQlFLCASd2HkwRMns9t2M02izzIJu8wHYm5pIUeJ+NeZSGsz9WJyF3k9PU0FGx9Sh03tLOLEK7udkmE/hgOS8deeUsEvf/v0nQSINCGBor/+PfaB69oWYJ7hWnrW5z3BdgxxFfK1EOaIij7EiBQFRwDwPPpwo2HUEMKJlH3E4Qe79stitm+xV+hXTC9i9YFbPkOQrja1tw==
Received: from SJ0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:33a::32)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 06:04:19 +0000
Received: from BY1PEPF00026968.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::78) by SJ0PR03CA0027.outlook.office365.com
 (2603:10b6:a03:33a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Sun, 6
 Sep 2026 06:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BY1PEPF00026968.mail.protection.outlook.com (10.167.244.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sun, 6 Sep 2026 06:04:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 5 Sep
 2026 23:04:14 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 23:04:14 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sat, 5 Sep 2026 23:04:06 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <acourbot@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v10 0/1] Rust PCI capability infrastructure and SR-IOV support
Date: Sun, 6 Sep 2026 09:04:03 +0300
Message-ID: <20260906060404.3336193-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026968:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: a90654a1-f30a-4720-01a5-08df0bdcb07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|13003099007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ktzBSgDQq3DLYYUH6JECOcks3mDSxStdf6+FyXm6oXqaAdGtQWc6HvqEJoRpzPkHwNC9j9W3UyBpIrMUTJ31oOTofmru6t9I+G32Fq0q1bDPLONzAkDyxj0VhYCDd0NugQltXvxo3BEwK+Ro+tYQpqYQgI65MsgyiSY57Eel0UZvMy+tn3ZIXNcHmhECoxWjAtGt5An8iNriv2/4XoOB8AuKEEZVN2rP13W9ni3X/U6au2cSkvr2AYbux72D8gEPU5ksgyN54ao4UwgSJsAZbjeCp2GI70Yy29137tfZyQKa8aXiC9Wb1cpCscWDi8uvv7ErkPtmC5p5QIh91FM9Yy8+O+r+CshNdk1rPVfPAyesMMSoDXH1brGQtE9Jz0mJlYOCZzQJIbjYNqwXV4wUWfW5rjYijz+TM9qmY3u9gvzbslLOs4EiUcYDP7vigtKOuv9mH58VvGnCTMjcfwH9oSRFFXLXiWXL8Xau4wv+6fRqGmSlQwaAL1LMj2D/cN99Qi+5fNPpGceuo0j4u8VDnHFv2SuxsO41Ma6qwn0ze2mCGR9CjKrBHNge4MW9OWstewLLeha00tj2/sAidj754uHWxa8fDd2hUHJiCH84o1M24FbJu+PplwhEPhXLhkTm7UZ0L+JtJpxC7KvuGSn5aeOO1bIKgCvitAOcN//xIYJm/K542+Rw3+w63RDTZr+HI6837qiQESFN8NpbRREnJg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZXE9Vk1oE83SyRVlCKsbxjL5Ewc6ElpxeSHFrJmhLmZQiX6nSLyjG1BFAMlFik5qzxmtEjBFOFynadv/vd4SDpGXbeIAiYjagRGbhskDhAfx5VfApYuBsCzu9ZklVphTUoFdyXpxdFQ6+/s24XnGy7jRz9+oRd5ryjcvMNUKA959L6/7S73nB7Cax/TXQXs7s+FsNU1KkMlM2Tzwu51XijxtsEvdVoiJ6iwdbftZFuIu6OmdvwchE9SuLPWNkn69J3rxtoWZi3Vzt+bqg/cuaMVTMDOOC6iKyMpCddfU8opjdAKex4MvqUlYXw9ZPlmknxwDpNahZ7P140wJpbym943jB7rVoUXSJF8KMrUyiFoDhsPDZyIveykUyUTetG5IalGgn2iHwbbw90eHzvB2G7kApvmiJiM5DpBrLUH8zhijc7/5bfkA5v/5n5wYsmO/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 06:04:19.1429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a90654a1-f30a-4720-01a5-08df0bdcb07f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026968.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626

This is a follow-up to v9 [1].

The patch adds typed PCIe extended-capability lookup to the Rust PCI
abstraction and an SR-IOV layout used by the nova-core vGPU boot work.

This series is based on v7.3-rc1. That base provides the existing
num::casts helpers but not const_as!, so the const narrowing call uses the
temporary turbofish form discussed during review. It can be converted as
part of the subsequent const_as! migration before the old helper is
removed.

Changes since v9:
- Renamed the internal BAR encoding types to drop the VF-specific prefix
  and added a TODO to move the common definitions into the PCI core
  abstraction. (Ilpo, Alexandre)
- Rebased onto v7.3-rc1.

[1] https://lore.kernel.org/rust-for-linux/cover.1787830828.git.zhiw@nvidia.com/

Zhi Wang (1):
  rust: pci: add extended capability and SR-IOV support

 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   8 ++
 rust/kernel/pci/cap.rs | 292 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 rust/kernel/pci/cap.rs


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.53.0
