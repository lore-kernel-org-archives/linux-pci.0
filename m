Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794436462;
	b=NFvRZefpNFCCTxnlDs3HLLhPt4vyxojYX/wEeoID4y+RYNlKxmVSM+xZbK2BF9/EkDoj
	 vkEgm43qpTbmU+XXVmrqF1oyoRNCj3CHa4MtwVcw9aBTq9buwwpXPjA2HocGGUYMZW7m8
	 UvJ3UWhPb15PvgpaykXyqgGtNaAxG3Z2S2r9SR2SsJWXsgIUWoLL0zYAyDgukBRFOIZjs
	 /UFvvxJt1O7gZ1Vn/4IkcjsLrlqqS3eFXc9kFgTetJHVHVNR/8MCG4IJn13gqMMXxkzFU
	 5XI1INuyzUp5GLvEi6pF64eEfEGYrx5fLdcOXEroh8lwgZledzfYiMT8MnMgQHA44wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436462;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4dpa1E6CVJt4/9ZmrmfAP8u+UXxkCpQ5RhllPWuWG9A=;
	b=RUGC5o9xQdQZSL1F7/06SIP5yIRLWiYuELtt0oNjk+0uk6H3ofJbvSsalFCaK1wO+mKY
	 b/etEt1MzzplnBqPGdZYbbypCd50qz/4Hv8n2/UcXpHe2Nfb5ebNUGfxCV7OrChHo5w3h
	 6bFlOXwL6ExCd8e85wltS/A8u1vQv0B83tgM0xBDVzsL1Hf/qPGUZ+3Mv1c7t86uVMDcX
	 aXidvFIylQ7hqumkmhv5RNvTOpC7x289vDn9yqE2UC5Z0QWjFe2GVsVwLvponAo47QnPr
	 xxR2Ib7cTlNML4XkN5FozItnJUf1coqzz9CGbLsKzJrA7Z6j3tdFTZpZdeLNDEAFFsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="l/fkjHbi";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.16
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ECB606A31C;
	Wed, 11 Nov 2026 22:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43ECB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l/fkjHbi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZEh8CF7pZzOts2CNLUJ0BB9gYc37OyEipJGCPyxQcghoUvmGjBGHm/i6ickQpbLbRpluqb9+AXB2L9W1KZZVh3pnuqwwN+jbT3ipYLOsC4+HbqJqqFfyJcW86AfyuzGb7qRyaUUvO5aH8W/o7gArEoX8rPS265Px9LpKT1MAsKJM+bCOYDxUaIwkyQQlT5CgR4ZAkZo/8JwOObuKBEjWk+VpXrJex01Bf9R+gQdsXTz/9blol+VMgdmBb8FFgbOZPrU2XZRyKEwwQnMkGrJbFdOFIRud3h/zR81xeHgQJFJTXXmte/xJN95ez+tWY1JVtrOeojSj5Bg35V6MltAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dpa1E6CVJt4/9ZmrmfAP8u+UXxkCpQ5RhllPWuWG9A=;
 b=t7qxr9NQtKsSJVgLXj5p8uEd26JhzOnj3Frd5Ph6Bpnmxq3KGb7Bpmf3EkeKS9hDl//CIaEiNVz19q4dAJfB7VSAu27b7JN9ANTAEDMSIXzzozVZnX6AMuZ1MRvFad/4dByY3MdMaxrPSydYHIK3ZRj1YxrTGgM9xhV4spvno202do3r/b7SRoPTWtstnoHHHRugy+eUqm9abOyDg4DF6CgsHpenOQrXjfgLiHS9xcDnedpnQ/F0RtQLtRkYny30jWXYYT6pZQhpwxAyRQHbEkkbSsmMoJ4VHizKhhNuLuwYa7hQdkXry3hMoCBwjeGuL3N8vEFvTkO29OI0/hdOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dpa1E6CVJt4/9ZmrmfAP8u+UXxkCpQ5RhllPWuWG9A=;
 b=l/fkjHbiYnaEdn11R6teavuMUw8I7D2vweqNFoOklX//ym2PwYXvhAZzM2BRr1U6U27nxvn/fJ70xG+VRNXiSWM2p00CUcTz+dDOqjDiYCVwTfJlPZOaTl/aoEhZ8yGi3V9gVuHmvCQ3sXKJllIXTt9MpKVt5Dhog9IZi0TVPnf7tTtkjijoCEzMsy5Gy6sQBTRSivxrnqVD1Y7kzUCUCjv6Cu5/MyeURh23DTcpvrtqs1STgTryWoIn/n/+4mc8gup/r8VmqR4Yg1CZDBWhwyl732pUlqZ+SSTxzrtIIkVuFkkPJNllsQ7M23dzIgNank0T3J/enlzYT2S8mrs4YQ==
Received: from SJ0PR05CA0083.namprd05.prod.outlook.com (2603:10b6:a03:332::28)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 22:34:14 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::36) by SJ0PR05CA0083.outlook.office365.com
 (2603:10b6:a03:332::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Wed, 11
 Nov 2026 22:34:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 22:34:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 14:34:01 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 14:33:58 -0800
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
	<apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v6 02/11] rust: pci: add vtable attribute to pci::Driver trait
Date: Wed, 11 Nov 2026 14:33:27 -0800
Message-ID: <20261111223337.508989-3-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261111223337.508989-1-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2c2fec-ea48-469f-5ad9-08df4043e9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|23010399003|261026121527099003|261022075727099003|261026140227099003|261028144727099003|261009221227099003|261009223027099003|261009221727099003|261009223327099003|261009220027099003|261021121427099003|261022105027099003|261102123227099003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4XZ83p4HnVoGzgJVf1tlbbQB8auk5ak/80lTqyQmzrhWGIodZDP5tkMgHqL7iInrRBS/p8zkDYuoeyegb+5cuUzIZfWvalg/p/UryMtCNojzL46IjVRxykn22q+9dbMY66HjJ3h8moohRdM41/DfE7NFL+WJ+9St7+slUAsoPX9S5MVQX5aWop40arD2Ao0WRGBYNCiXBNrP3vMPy9CuiR+E3oInL0TUL/f8BulxnY2M/Svio3I7WEp6aBKYmjXwYYjpCFvcgpDAhLnX+y0aOwPzUPbNosnzxnpvrCio6ifOkW4tZZ1/1jDm6bYwgeYyjjkoNdCHLl7/klxyzAAc4TeheA11edvaMWTuJpcTC3tW9bLSQ12MtyJmurdUwmAhCtsuFUAtHZEOFUFuEATn8ic+/MYkicG06xzpPeSet8XaOX3eI+PUdLZ3ABTt9AfT9D1Ma8l+lhai3kT/Wyvxv5mvLNE/FAz4c+SmAj6LDNDGW8llFDA0AxCOlMl3C+KmKxTNLysPYmcoUqCQgYa8CtNv13bczHzXinmDVUjVumiA4kSykol1IYxpNW1rH4ZyibP8kulhQHyLPeogLtkREuGdmtJIi6gITYuoAqb9UTlifqPVlZRmbauhguMrtSo0mE+uTxam10fhYH03JyDOhUT/apkYezifUSZZ/thV9yBpdZ+0Mvn+YTJVju+SLmeLpJrCf4K09t50S8by7LlCJw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(23010399003)(261026121527099003)(261022075727099003)(261026140227099003)(261028144727099003)(261009221227099003)(261009223027099003)(261009221727099003)(261009223327099003)(261009220027099003)(261021121427099003)(261022105027099003)(261102123227099003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F8td1m2n/yCjwAx60G0vBgqMIqFp77XgyNIf7/pxkbJOOHCnxSW5JeWBicW0Ix/Q7cRpa0o1viZ6yliLiGzSt7jbe4343Tos3zr8kF43mW/uHI/HAgQAx+k5ZuzhW1Ey1GyvUrKCSqLjSeGhT7xYoty0LTVKxvkfz4QYTfyrvhGRb/i2DDezFFTF7DN+vhZxyIARV+W+1R70sjS0/igVoY2YiPuDDSNJVvQoIKNdhxtEtBk1yq0DdELBN+lbSzN/NfZPZX5kkusWCkfzTv6Dwx52NrlrpNjdVYIptfR2AIAEWLEj0qOuRHUSHKu7H6+tT/pUYsoyShipLQD0R8d0j/1iPMCv1XnQkAtBshLkKMEPzpjwW4sOCrfbQ9MepWoRjNGdswdWWEC9h3BowyXVxkSTHNJ4WhjoEap0oubGK1MINgPi1UHsQhKoD9aIFuVo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:34:13.7608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2c2fec-ea48-469f-5ad9-08df4043e9b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C

From: Peter Colberg <peter@colberg.org>

Add the #[vtable] attribute to pci::Driver and its implementations to
support the optional sriov_enable() and sriov_disable() callbacks
introduced later in this series.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs       | 1 +
 rust/kernel/pci.rs                    | 2 ++
 samples/rust/rust_dma.rs              | 1 +
 samples/rust/rust_driver_auxiliary.rs | 1 +
 samples/rust/rust_driver_pci.rs       | 1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 560a70c4f5a7..65897c303e7f 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -91,6 +91,7 @@ pub(crate) fn bar1_resource_index(pdev: &pci::Device<Bound>) -> Result<u32> {
     ]
 );
 
+#[vtable]
 impl pci::Driver for NovaCoreDriver {
     type IdInfo = ();
     type Data<'bound> = NovaCore<'bound>;
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8a4af261d1d4..4d32b55779fd 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -282,6 +282,7 @@ macro_rules! pci_device_table {
 ///     ]
 /// );
 ///
+/// #[vtable]
 /// impl pci::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     type Data<'bound> = Self;
@@ -297,6 +298,7 @@ macro_rules! pci_device_table {
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
2.43.7

