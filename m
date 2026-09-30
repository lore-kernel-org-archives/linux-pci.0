Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61E53B6BF0;
	Wed, 30 Sep 2026 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763650; cv=fail; b=e29WujOE700VC8tz12V0+jfOasv1m+w+8AFzg+022HFPhBTRwg7wLFxZCuysrSr/MUexUt2ai1KKwQxJBlYZrRSDSV/7ctFxzoD43TWI5+8DsKS9rpplFZklbAXfxgSI4MGe+VPJYciwMrBmVH0UsBdcPMFCQxHQaTsubxA6tfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763650; c=relaxed/simple;
	bh=JXashQhrQGYct2PcyPt16Oo62fo2WGt6p0vGjLuQuqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfXGgg42BkiXMwIe54nKFox2WQq7KMZr3lDJeOhsY02ZzpPMrRAjwa9BjWbi7Lisy1NpVWpd1ygu5b3gej5f6oAVLNg9H+v2xk+Wti4Caf0bYu5qKu0wi+uuDt+Ldob6hsLoSThGmilu09L3Kr7cwAryKjAW6dYlxBjlDgZVWxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=khTd9zab; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="khTd9zab"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqg6WgBkash4MXJTBHpGk+iijuX4F6Q3HLtDkGdjbUtt1sjOqlkYEbrbNGdJ/OBrS+oEXxhvuF7oJRGrabz3k3krkD1YHXHpflmrz1ekW/U0wqfFOrunNdZLbQrFHgrn3DD0CuXTRDWZBozGw4m6aOruOAhe+uHwZyfSKsMgitYABVDI8+sE8ZdpexSor6DmtgEltA7is3cro6ESCdzl7dzqoDSaP8kGsCXA0ss95b6HBnhzB1yzOH4vXoovg6umNe37Vy4WyKSNpJYQYrSUuzQ9qnqVAqVk0GBStGAXaPPsOx6kaQknR66SXDP8m389uVgV2Bl3u/gL23Or+VROvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zzz71qMYob0plmcSVH+20XNgceDpQF5fN1QFfhn3hTg=;
 b=O0b8tBgCNZWTPqUPMZX2BbfwQsaBZ+AKk9EfGvA4iGgrfqCEJ3dHV//9+Mu7X55zFdpju5WczoO+Y6QLc8bddgW6GBLzELnnGobXKSHt846ooPVc4anmUnLcJFgSMxtpzwTpVYIaDoWtVQ+M16ETMYY6vRrG9B0rUdjbKwnTDcgHjHgbu/kTepx3M4Y6L8tyIqM6LWyaQPjnIiqTSal8L/A4XrkDbPraZV0l+0AMMAA/PBg+9MsIHgit0qUc2J6QfGMTkLrw2jv6hQoGSQ9GaCM3Y18CO3RPtk+cIo3EErgP4uvWCS2JphtpA3VNDiQOtjGdasiVbNzPWDTHRHn0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zzz71qMYob0plmcSVH+20XNgceDpQF5fN1QFfhn3hTg=;
 b=khTd9zabxA4llvn9zDndwzOQzsodAOLQH8DDQqeLqPUGv5ueltwh1S3u/NWCdAMkcJvPGr8+9ehorJyldE3k9cxQWRFLm/LPvdZ79sAj2VO4Z6Nut6Ay3xWbFmeoU2kkLWzzx3yfLjQ/q1bCLK+qRoaMOTDBAbvGA1XbJZJKGjk8dauol6KgCSMwc3kDjfbHVhhVuiuNUgW6lbFBWnuuAerfomjZf8dYEznA2nHZShimochE5s78aiWDgB17rDW15r69Fa7OdAfQutm4U7mIijH91F65ZscUKFvSJZWc7yQfCHRrx7+kkdoyKioNWxupy/9951xxBSacf7oxha9big==
Received: from BN0PR04CA0096.namprd04.prod.outlook.com (2603:10b6:408:ec::11)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 10:19:50 +0000
Received: from BN2PEPF0000A98F.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::2e) by BN0PR04CA0096.outlook.office365.com
 (2603:10b6:408:ec::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 10:19:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A98F.mail.protection.outlook.com (10.167.248.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 10:19:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:19:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:19:28 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:19:20 -0700
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
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, <jgg@nvidia.com>,
	<alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>, Peter Colberg
	<peter@colberg.org>, Alistair Popple <apopple@nvidia.com>, Joel Fernandes
	<joelagnelf@nvidia.com>
Subject: [PATCH v3 03/10] rust: pci: add is_virtfn(), to check for VFs
Date: Wed, 30 Sep 2026 13:18:44 +0300
Message-ID: <eca774843f5bbeec015307d6491ae9da5a222275.1790759932.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790705494.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98F:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 64de4db4-8b54-4902-95e8-08df1edc5ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7tMT0Hemy5Hjs50u+BXN9HZ+hk2KOxpiiX40FFscxbH/4AuD5ZZP+tV4VkC/ipTRCjUk+ngIoeXl5pjDnzMKamU8pfN9hA9MiriuU7U63ehGSq4AB+eM4bSq7I+DVEE+WzqWqKp43FywwsZQo65b0ZVeIG1mV4G/eBr7wu7wf0xwJd9n5UifkTri8b2Hqm3VoTkYP4yDWSy3mT2Q5QkLN5pBAkYxYFWY03Ab3HMPCCFgu0LwXL5Bvaxygf/5nJUYKVSLl/a/CXfIlfxEyTVMwqoPlidw1gD0oGEg5VHT7L6K2/6J/veKAmd2LOUR9slUP1FYZkdU8p7GtMg6XhqlRj5Ef25xwbKEbC/4pQ47pmRLWlXGYaVt9+OXqkx4s/FdrusNe9B6WMhgHS+bA2O0VhqRRsaJ3+tnbuRuj2AifyWefUMvqH8D1BaYJAShMDXJmPWc/gQJhdQv2uUXfJXEoNxxXnW12rVtff82rfKfpm1UhWouK1lRA3CW2yCcFkoHcVN2TJte2IqedBPbaT3PyHA4yWmvXePYEbeCN1FYiiFxiskck2UYX86hMHpQpw8B+2Kzb4ytzchcSokPsnDXJyamQ/2DL61kqlczK+J91OJdYP2HgkPy8GeNL3BtBau+Dnzn2/1RQnNhZUhdun0z+kEmSvQfALfDJjIO+1BNLknxBbVdl5+83a8TnG4MZrZ9V4UT+P105u4KNLIYlgdekw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qiKjROeYUHTBlQ5pZ2RGf5dbrjvb9H242RWJQTQCK7ubZ0hlchYMk8NhkKfwUiNgSYpWb+8h+1wZm8wnMCUfYMOQTkJ/VBSMyiHfkvJmWrU///BtxciYC1dEuVHqCZRLGsWyeqixPb7CGTKUhbQMkh97IpjMBA4piK0xLTcbmp6X2FMZ75mUE8swMl9TMDaclUDLkL+1ABYZOZfuBtShbQPNE7cjUm2kPi7JqjAcFcBxssY4jKVBfkpkjD2VBD82r4vffeF2FSZCtYtG5OiMJpkboJM0ZeXVb3TC8cO4eOHKNSsApXl5WeVETFi+97N9GR0QGYJXmSA8j3MOv6udeM0ur/qvy9fisKoEiuvTnbuGqYUabQXtv+n5TJwdK8R4GtCcO+XYtedI4rmpB8tcMDHu4DrSu4PytgSs4ewJSaygVNYNb3d3sOYPNUHmQ9IP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:19:50.4301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64de4db4-8b54-4902-95e8-08df1edc5ca8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A98F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466

From: John Hubbard <jhubbard@nvidia.com>

Add a method to check if a PCI device is a Virtual Function (VF) created
through Single Root I/O Virtualization (SR-IOV).

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci/iov.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index c37ce5134673..272ed677f145 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -11,6 +11,15 @@
     prelude::*, //
 };
 
+impl Device {
+    /// Returns `true` if this device is a Virtual Function (VF).
+    #[inline]
+    pub fn is_virtfn(&self) -> bool {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).is_virtfn() != 0 }
+    }
+}
+
 impl Device<device::CoreInternal<'_>> {
     /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
     /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
-- 
2.53.0

