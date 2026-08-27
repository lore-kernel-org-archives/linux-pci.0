Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AA74432E4;
	Thu, 27 Aug 2026 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833164; cv=fail; b=hX28088JorG30tSkR/GAjUXWQKRVtoCBvLoNei98OH00actU4vgXLThYlug6tHOspqGXa9cxwLPwzlKTy0ExA/C6w29Hxf3bYWCpVMDEE+apUnvmiLUqI+dlgSTzyaTX9uWkoo2x8XS0Re0gesjzBAXc2wSdrkUm9HyFdJv5mcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833164; c=relaxed/simple;
	bh=hCOpXnlC7CRKWTRg0oT0QDZOOYLJhGbYa9w0CBXyj44=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mz5vucwljdFOQySxcTzhqa8HV7gpi7nMSfifxRxM2mkgPQy5ij1Wx4d392FuelBFCmLpRzFvJWuoxCDNUw5MADDHW/qIOuRv98o7zU/7fP6QcJaND3aCe7KEQ2gFIPypSBiKeetJuH0FxRd83mBhqpxCYQ2x18/AnvL7CL7UK1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AqE0hbzm; arc=fail smtp.client-ip=40.93.195.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AqE0hbzm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhii0sUJAdTFl7+nyo1QMzosYhxCytNwbrQ6/ptThXhDU1lBbJq81h44iNVzis/ap6rn02fLzPiNR9lUHdf9U8Db0vTzNNuI89Mn+4kPllrelN7MeeeDwLAhPEzbh9H5fRfMkFofKrvz2038rpDmT0AZ49smbfkFLz7Q/GAhSG9t/YFW7oJgPsBrv8zvej50TUNWVTsEw/guCckQZOAUKXJZ1BFj0OyltvNPLWcjPSYCVF4WZBptwvNUS4Y3y1CJRs/1KknVIVFpLcPKyoFx6FAXB7uFEzWKypuxurM3ouQHvPUctSM/J+ZcHtrc16/xAlH+tqFE19w5OGpBVjU4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+vCpUViLBGp7ta/aRo/waPAhWCYWUACsQ1nZGCmFYQ=;
 b=Ur64A9B6vdru74LHV2GTS5HPw5XodPyWOGEY7uqSj46849ybdoJUkt+rV6aguMbL45cs6NUgZKFOyFFKmwodQ9aE9k1fIe3xLkSl5DItGNeLZMvma+GDzBE341ANFCLSr2T+gQvB/WSQesw+3u8XUMY/8Q1iS6exuK8RtAEQWnfJBxu356obytYFuTo5GrG7O9IZ4sttJYbELmM33vqMW2HhnQhEsmb/vT9Mf8N/jbuwIZq0mI2NqdVbOJuAqQgjAsIQAYBCNaHlWvGO3tdXO+DTFhgyBWLVHoA2HJCRvj4QMcykeK/zf7Hqf2iy0EUFb3oYzYLm/KVv2Zv1mR1nJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+vCpUViLBGp7ta/aRo/waPAhWCYWUACsQ1nZGCmFYQ=;
 b=AqE0hbzmIuTDHlvZNocTcG5nipo4k/eWPLwyekNDRV+AI3lTYUO49b4P0EwTZfR5DHXwI035sERHP1S5PkQNtawReoV49aDjNxeVCKM4QcKe/4LvWMp4fcm346HAvPPvgMifKQrZYVBIff1xlArOQwMninilmy7PC1NbHLnPk4ZucA3Kxju2iUNOPAwJg8ShUylb/vv5t0SO53PId5THp/GQRe2R5HPCdxjJJLUCF1A7T59Agj4B5xuSF1lUAKfq4sWL0yhzb54St/cBYopELPxStlojV1tdz7u/Bj16MfvlUzPafU/RGhWm9PtSGTucnZb1nefCvlcLLVxHze67mQ==
Received: from BN9PR03CA0769.namprd03.prod.outlook.com (2603:10b6:408:13a::24)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 12:19:16 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::18) by BN9PR03CA0769.outlook.office365.com
 (2603:10b6:408:13a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 12:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 12:19:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 27 Aug
 2026 05:18:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 27 Aug
 2026 05:18:51 -0700
Received: from inno-dell.home (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.46 via Frontend Transport; Thu, 27
 Aug 2026 05:18:44 -0700
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
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>,
	<joelagnelf@nvidia.com>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>
Subject: [PATCH v9 0/1] Rust PCI capability infrastructure and SR-IOV support
Date: Thu, 27 Aug 2026 15:18:39 +0300
Message-ID: <cover.1787830828.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2877d4-1f4f-4a06-0e00-08df04356953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|23010399003|13003099007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	linJRyIcf7ZF3s7npuqMDglXJOrFM1nyd98je0czDhWSQLKJVKErwB6YFYtfkufnqWcrpeOwbvsAPu87JPiLW5ZqeYyPdEe8ZYkvPi9CTx8JOAsL+jbpc/p2WRwg62IAvNEUYFmJF3cbDXvTJtBlF1D8I/P7H7WM2n/SqX0ltfy5ye3+6hJPGMIWDSaelkEuGDNOgZZ3KN4ggyXkyC8UoGD2mAYYA/FimXOycNULGYCm4eIJPbVzY0bv0zhW6gveG3C4DXZt/9Jy9uUrCyynFM2FNJpfKQSTj1961yP38bQi6xBjswqr2sOADsO3VaOcHQ6Imv5soEwQ0MDowgGMFMQok28qaTd30OXqzSUTQ9rFdWT5x5cDOKxf1OT9mTRjJ9/5hp2EuMNawu31px4jR9/pH3e8vuO4TZuuLgkDAi1FJ79BsL7iAYSCKc8YVCI7X+3kAFCsZNRXQbD3mQ2FSgFqk89cHPepvR8pZoJ2lEx1/wGNeh4dB4v5YjNBYvQ356TkeWuWwTyKp28ReChdzk6DVMfviz1C0Cs3gfeybNrdwrSaYrQGELsNB9lvQ4cF3A+IPFBh9Jcgf2gHwZHtprRzzfdcggnDX89mpYppgarkNanM9PaTLHuW4yosaKnOGjuGmm3QYSmzR2hgVyi4RTxePs0+KP2u2I5mvyeIL9qd2AIXdUe2qdGOWhGorSpJGXSdw7nm7lwBA9kligPdnw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(13003099007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/3Qiap0OjZY4bqhAoAmBKTbBabLIAiAMUAB52I+0W3gLmVOIBCM62L0dwjK47VQs49V90M72phYJt2tO4bkBIHAEDdrkGTIhdXWS8j+XlhvYbY27R5W+rS7lVjdoVc1V51Wo/hQuWcfc7MXmrFw6nnCjCFLF6Em9xvcZ40SkC8R1UMcbcCxvhzheqXgm4AppYRzU7WCJD21bQo02VrvaMGoAfW3V4AuNIef++zSsprGHDTIMzr17RF+8pQlvg2CKVAL3MA3T64X3gkW0tukZdYUWwwXZDM22YiXbkV9ZjfQqHZLUbOlrbI62PSHoopAOcTqUURo22qFD4SYAsI1oiwr2L5cu80A7ffhemfMS/l9SYo6BCmu+BUTUlMuxxhXs8RR0i4QXGcIjsJGfe/qOghSTB+Yrh8UirKbJyFoCYbLPba9diKbNNkND4XHWMwCc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 12:19:15.4795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2877d4-1f4f-4a06-0e00-08df04356953
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794

This is a follow-up to v8 [1].

The patch adds typed PCIe extended-capability lookup to the Rust PCI
abstraction and an SR-IOV layout used by the nova-core vGPU boot work.

This series is based on current mainline. That base provides the existing
num::casts helpers but not const_as!, so the const narrowing call uses the
temporary turbofish form discussed during review. It can be converted as
part of the subsequent const_as! migration before the old helper is
removed.

Changes since v8:
- Made all raw ExtSriovRegs fields private. (Danilo)
- Added a read-only first_vf_offset() accessor for the GSP ABI and
  documented why pci_iov_virtfn_devfn() cannot replace it. (Danilo, Zhi)
- Simplified VF BAR decoding using a slot iterator and removed
  ExtSriovVfBars. (Alexandre, Danilo)
- Explained why I/O-space VF BAR encodings are rejected. (Alexandre)
- Clarified that decoded BAR addresses are PCI bus addresses. (Zhi)
- Removed unused ExtCapId::new() and kept as_raw() private. (Danilo)
- Replaced documented integer casts with the num::casts helpers available
  in current mainline. (Alexandre)
- Rebased onto current mainline.

[1] https://lore.kernel.org/rust-for-linux/20260818084633.1673214-1-zhiw@nvidia.com/

Zhi Wang (1):
  rust: pci: add extended capability and SR-IOV support

 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   8 ++
 rust/kernel/pci/cap.rs | 290 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 303 insertions(+)
 create mode 100644 rust/kernel/pci/cap.rs


base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
-- 
2.53.0
