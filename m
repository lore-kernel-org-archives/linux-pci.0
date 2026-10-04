Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA9F21FF29;
	Sun,  4 Oct 2026 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115741; cv=fail; b=Lki3bJN6PphJLsJ2FrA7DOl2ouZu6s1dQ1Q1tu5U0I1G5ifTnF0Undkh362QmifvYh/hrOapkB63cN+a+kop+7UxnZ6eAfmv5JatLhLD9DJmaw905A2anR+63hw9uU8O1u04Coa/3n16FjSCpqmQ8474w/zL9SXt/e84Vd7q1ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115741; c=relaxed/simple;
	bh=Op6rrgZ7dQwsOp1BTnoAFOkVFO8WvRPxLt+Xm+hiIWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eM+1XIwTBTtjz33c6N5Mfy2Qvm3DaPETwe/H2qxO7spZ+II2or9wlS9Ga8iQBt8ZFy3+pkO6v4yiDYFlYCLaykRu+8qgyL+zjR0lgh9r4MrSYgf4b/upV1sPzVaZQstJSkUsAEv/d4zpKWjvljov9ESLPO6m6XAMETJniwcbRaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=osIViCF4; arc=fail smtp.client-ip=52.101.61.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="osIViCF4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQYb0wUeq3piEQtln0ITdWqm90tZJNGoSjO2FWIWEOeQLqTzR438XpzSkVPI/LX+deES6S+dtdlIQhkyQYp9KNneBPwEiForw2AfIqvi5Qr9LNTYxw0YZ8ype9fZeFCYvri1MbGii1zE5lfpiasbGd9w5fZcVPKf8TvrG2Gfdzvun6OIkUFUkVfYVEaWCYw5JTNq27u2SB2Hk/iVSuLQOE5sNQxpIeY6lz54F+PAaV+UfatQTMHHkiFJvVDD0DAeDk1hZyW1+r3UC03e4H39kyF++1M4jqKIxf/Gm5dLDjjDX+TcCkmA6k78pmo0qbvSjMphbg4VxRYcTOX8ffNfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAAEYSrGnUosULBKROCJXlIPk58qT0cTHkeGgDP3kOY=;
 b=k/QQgmyUXwz+ZdZhVnO6styrBhp/YnjeSfU+SdEe78dsu6aPBl1YE5r05qBXjDybGzki8yagPlpdQayxO79xaPLm3S/9Y1OO7shNLjsYVxf2w5xOTpPplQQzaz2KGQmAgfn4C+yYmdxNbuv6illTh9bE/blV8w3rE6CGqVxzqnpEyLcua3VoT2jMaF6dI94hcluLN2Urjt20T9fmqoy/CJPVBbnSKqReeZAzpQOPcRv4YcLU38qSoOUFEyNOgvm+Ds30eZR2p8jtpO7OaUyKoxB5AB0NKIJs7Zyk9wFAzr7gAVP05Tcz4+rSS2YWFzEmI4QJ1c+mr3A2qil55G1U1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAAEYSrGnUosULBKROCJXlIPk58qT0cTHkeGgDP3kOY=;
 b=osIViCF4HczegA1p+VPwbPkz6o4K96Ol1gl2PMyfdaOTpj4arKprLwqX0nh4wuY7eXgxh4ohIW/K+APt8wE7rz7UnSX1Fnz6XCPboi57gzzLLOqnAWkECR2lqqGADXynHSNSQllaQj9WsMSVIkU2avtGtPghu/fAwOcfhCULTtFqhr1IQdxAC1V6Z6aYEB8VnahJUTEdXJ+1OUsa3oLEHt46MvfEIGQ2+nr9BkbToml8igNaoPoZA8u7AkTcxaqGHce4VX9XViKzMhl9rgjukDQNIpsI/bOOzazgzqWlEIl+ROXaovy5e/Yrmp+7bTVI33qhYNqZa5KKrGtENRjc8A==
Received: from BN0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:e7::26)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:08:10 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::3a) by BN0PR03CA0051.outlook.office365.com
 (2603:10b6:408:e7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 12:08:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 12:08:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:07:55 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:07:54 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Sun, 4 Oct
 2026 05:07:47 -0700
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
	<alex@shazbot.org>, Peter Colberg <peter@colberg.org>, Zhi Wang
	<zhiw@nvidia.com>
Subject: [PATCH v4 2/9] rust: pci: add vtable attribute to pci::Driver trait
Date: Sun, 4 Oct 2026 15:07:23 +0300
Message-ID: <20261004120732.1045629-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004120732.1045629-1-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff026bb-1c4c-4a84-a1d8-08df22102895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|7416014|376014|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	WMGuhdMkba/Qhb24NmianVWxUcP+Y3b1L/zyQ1g/bEU6B1mEWmnY+rTJ+gDMdYvYfPoLr4yD47YH73YKcJQA5R3Wqk/oiaEm5vj5fuueUne+OLEQD9C87N2Vz9DBA0svQJUrev7d9NJzctODpkXnMOzRLkv3/iqAe8yUZy6JY5zoa4BSdp0BxUTb4M0fr7JYbnr0XvtLALvF8i0Oo2xUj27/x7WIR7Y5zusVhDq0uGbx5QRSQpNxYQMY7ptTHp2W6HRfEy5YKb6pWm1eFpRJ3eIXoSyez5E5DZvOPp8EXczYTvJSYcoMNDll8UywAnHN3SZLjKYcDsLjepXyflp47VoDCoLxCkZ05poGLXjVtNmAV00vHKs3lgPVBO6M4jcvo0juonkd5xCNUQ+4bs5+FPmnN5gav9uRT3mizD1QdSVWj+y84OO134u+LbxDVIz8ROoLxXGQSWNGgFCEqvQMZFbL64onFPDtK4yFgMguMzJn7f4/M8ZmomyMdCPOdTW7Q7GbWH0f9gLiAuNPo2eBFxsGX9ejNZKBoUo2p2yn2snRbV81pD88ZF+SmQVYJbvvlje57wtH4TnxUSzaqvgB2ZYfasKpJ3fSWu5ussD8TtRbUyDVNFaaA3tCvm8MikK/L+/w3iL4hRAP/bFCl+fa1E8Peg/RKoUvCbsjuPTmTGYXlr1xV74ngkJShp0WbJt7LLvSpxQpC4qG26njFtyQ1g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(7416014)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mV0n11mHOwqikaOeCI1+R+PpHM18el0TTKSO4k1y2tAaiztsARDvQQgjCLfUhriN5tA37WbvWQoCcsOI91StwyPREp/NFPCQoRIx54BgLRz+BXzJXCv79kn8wdD4r6LXDdKlxukJrSOX33+wZBxWEX4NzsevcFoPKVLdZIbB70oNWw2zYvbGxgwD69BfDfZYQ8FnsYVwKAeVduKEndG2O4kuWc6wUxGu/MwX4voDv2b9Or+Shn96+wBTpPDz0g+L4s//hZ+9hEUMqoWcbv5Rvtyyffua7KY2fDhu2ggcXnapjnu3LaLDv1JSqhv9rmV5beo2j97w8bHmHzmdVYx+D2/G93XW11zaNv99kb1f+UCI8rsoOqycM0lkTe+W62QEQCnMJBpBKdRE1QlpcX0gXxnccrBOB1k9C913iy7yDR2ZK7G9IJKZj03dMQi+jKXe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:08:10.3800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff026bb-1c4c-4a84-a1d8-08df22102895
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

From: Peter Colberg <peter@colberg.org>

Add the #[vtable] attribute to pci::Driver and its implementations to
support the optional sriov_enable() and sriov_disable() callbacks
introduced later in this series.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs       | 1 +
 rust/kernel/pci.rs                    | 2 ++
 samples/rust/rust_dma.rs              | 1 +
 samples/rust/rust_driver_auxiliary.rs | 1 +
 samples/rust/rust_driver_pci.rs       | 1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index cf3534dd47d4..47a599c9ea4f 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -63,6 +63,7 @@ pub(crate) struct NovaCore<'bound> {
     ]
 );
 
+#[vtable]
 impl pci::Driver for NovaCoreDriver {
     type IdInfo = ();
     type Data<'bound> = NovaCore<'bound>;
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index b11a1d32c5db..dcb0cdd0d426 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -274,6 +274,7 @@ macro_rules! pci_device_table {
 ///     ]
 /// );
 ///
+/// #[vtable]
 /// impl pci::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     type Data<'bound> = Self;
@@ -289,6 +290,7 @@ macro_rules! pci_device_table {
 ///```
 /// Drivers must implement this trait in order to get a PCI driver registered. Please refer to the
 /// `Adapter` documentation for an example.
+#[vtable]
 pub trait Driver {
     /// The type holding information about each device id supported by the driver.
     // TODO: Use `associated_type_defaults` once stabilized:
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index ffb693544673..804d55a63005 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -69,6 +69,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
+#[vtable]
 impl pci::Driver for DmaSampleDriver {
     type IdInfo = ();
     type Data<'bound> = DmaSampleData<'bound>;
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 0bee16faecc6..6cff9bf8c80c 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -90,6 +90,7 @@ struct ParentData<'bound> {
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
+#[vtable]
 impl pci::Driver for ParentDriver {
     type IdInfo = ();
     type Data<'bound> = ParentData<'bound>;
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 13b035a95756..50c8709739c6 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -139,6 +139,7 @@ fn config_space(pdev: &pci::Device<Bound>) {
     }
 }
 
+#[vtable]
 impl pci::Driver for SampleDriver {
     type IdInfo = TestIndex;
     type Data<'bound> = SampleDriverData<'bound>;
-- 
2.53.0

