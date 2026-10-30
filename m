Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380405;
	b=d8Kos91O4MgaxxUoyD23xQkAle7MO6KO0DsPGETOCOEq9wGKnHXh+LxIcpXw32qwjaJf
	 VB695C10GvXyY/bkAC0Yp0ZWqmG5aFpegfXtdlkiuQsKd6Ah2nM6NSkOGOwTw5fWwzsSQ
	 ddhqiWRavztJiea1WEVrFqSmI9J8ymeOatD96xqLXl69g+Pcx/RSLFvNx4TklnLB3oJ0b
	 cxKSsYzsJACYDsW5KPNpPpIB7KOnfiHw+0kMMjLbdc5hx5DI3rudL+G8gFP7G8fmTnIKx
	 ttSuyR8AD+6uVcT99gbyWOGgXqA8Y9zFzC1T1x5Q53js1bIBlnmYBdU5BrakTUQsAkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380405;
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
	bh=7euaen88DFUSRetvBRy8dpc9Edd6rRZAvaLqJk2edc4=;
	b=GnlFipRAglTQUFgue8+/c862hNM7//+qWZ2PDwgpyh0JyVeAusUYM97C1teJ7vpFgUzM
	 0oGotrnqs92DMq/FZI+UoaxNfn+x0YdWtv6bw9Ji1AH1LdXdN8UyA/vssryRnFhUK0Vru
	 me9aJXCPfQOPIrHZkD4QOcmNmIG/qA79XzYWVgHP4U0QYmNMSdfrGAGwo3z7YXz1sTm66
	 0xrDnfRvN0PEck+9CRb/p0SDwYMtt8s17F8pGSnvJqU8G1cE8rTwaUKcQKSL1qVTrIq6I
	 Nyph+lml2sx5ctxvuPzazuhNBeT6khnn9pkrfhStpIwQcne11D6gsTQezpbKeK3Cf2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qTevcLBb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.1
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29F2606A338;
	Fri, 30 Oct 2026 17:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E29F2606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qTevcLBb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Slc7687w5rxBmAYawViMMDyFCL11j11TnFM6zxAHcRfI4VYbJyOIe+CSTMbee+BGWQNOdp/Y2hOOl0/ROuDonInIDTkw3QoCgjYWY4B6YPAvdL0ZTMVSBLLT7S6Drjll3TFBq6p+RxJBStwghwlGru63IZ53ryrdDxr8ShCq8suKTClyo6Vt2/slw/1erleWo5isZ7zppQ6UyXaWU4Z3ZGcFwDzIES80ZFdTn+gY+uyEcZivPB6uCgPuZ4CP0z7YwBxGRvLGE/47lpdvpyYZYO/dQ6G043i7VZSkga+8pzEImgi/wreNVh3cheIicz1cyILX//i62YAl4M2ivk3VVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7euaen88DFUSRetvBRy8dpc9Edd6rRZAvaLqJk2edc4=;
 b=xDuh0xqaOQ6P0izQzkAbTHQMbjJVOsXyBMiq6ez6t5m0NBfUKa8APRBupe4pMMegKSzbFpxd11BkM/tilYFXLapxh7PBDF4VoOYJf0YW6eUay9NDENQQyii7y7j/YrLOv5/6vWjWU83ZPruG9jOpyns1J9nNKuVs6PPVHyFNlTgdx26VYg/cQ4hzvboLV7LJtSHgx0xFE4zwu0WQpBjzGeqTthzEBbgFSr/e2MxuKyv+LmOa9kryiWAZT/mZU7rnYH4CmuyR/vHK6nTZYErP9U8PQ4YYvQe3Bsq0zwCuIvVe4NFlNRle483Lj7+PfNPRxsqPKMiQVUuGgNGgagN+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7euaen88DFUSRetvBRy8dpc9Edd6rRZAvaLqJk2edc4=;
 b=qTevcLBbeTiAbsXG622br6URKbCgqskxnJxkCzULmnYpZGpoqIrD2NCRHO+m60W9rCcl6v48gENf9XWBd6BLlmH3y3QT3yu9uC/Teh6PiTiSBTLBzhAtRAepeo9xpnL5a5NolzpdbrXce944NP2j2EfTpJJE7gw8BKj7shaZjjfewygT3FHOI7GrdlX48PdHi6impOWvfdDuQu7WFKmWqcHL51cPBZCpPe/9Bzz8ycKQjTyIP5kYOe36DeoA76M+JkGKSS96R4ItKHvV4vJ1vm/AABbDBdsfLGy265ED0XqZyLv7sB276vygYx1YPYIkPX+ZHxH6jn9NY3AtHFAybQ==
Received: from CH5PR03CA0024.namprd03.prod.outlook.com (2603:10b6:610:1f1::17)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 17:13:18 +0000
Received: from DS2PEPF00006E23.namprd05.prod.outlook.com
 (2603:10b6:610:1f1:cafe::1a) by CH5PR03CA0024.outlook.office365.com
 (2603:10b6:610:1f1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 30 Oct 2026 17:13:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00006E23.mail.protection.outlook.com (10.167.23.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 17:13:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:12:54 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:12:51 -0700
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
Subject: [PATCH v5 2/9] rust: pci: add vtable attribute to pci::Driver trait
Date: Fri, 30 Oct 2026 10:12:20 -0700
Message-ID: <20261030171230.196717-3-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261030171230.196717-1-xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E23:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: cd066a44-f5cd-445c-011b-08df36a916fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|23010399003|36860700016|56012099006|261026121527099003|11063799006|261022075727099003|261009220027099003|261021121427099003|261009223327099003|261022105027099003|261009221727099003|261009221227099003|261009223027099003|10067099003|22082099003|18002099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	u13EJpUOyTPCGx24WWxsNN+CHpaB7q0Uo4obYzDSddfGmSJzU3jb6rjNK1uffvjstR4mPnKLGduZTOGls2t/4MyxMCKY2KLgXBHS5/McL0nothJgK+DtRYckgx/38OexbGqkwOqig52svXXEWZpG1hwFdDh0BgEwMBOGRmgDDeimd2DriQ1r836Gemgm/SOW/Z4BFIfNnlbSVg2To4t5xDDV/lytvonbQtV078FsOYhHT8v9gZCNn7k1zP/B6+QVAxStisksen+z3OR2bz4GxdpBLjuv1IitSDq+IUKjY+dUTvuRjNr75+lnFKQtbvki9Obe1sBfoF0JqKAmfJfl6BX6PCnWMp6LqHDFmCBpG346RzWHHl1IRhjKU9F4iIO9jh5ISHkJPP58UkpX1pwJdCyjdusQNHdRMAHz0Wkco9ZoHMm8897Sb1AlHA+uZa4jiaQoxfyau2FB+H3LtZWm3GpDrmZUKiZSTS5tWwKTUNs5N5wH5tAIrHavTQDkoaqsmD3yMElHAwbhBJGlLf8tjc7mNcjJscoP9pIOCnamgW0k70P/4oZwyfBrndj0FytOzyiKdpN27g/hSNQfzNOnVYnQj6YhdKhFPRiPr3EEaLZdchv58DbWUfgkXcTAAD9C5r57isALBmbiF+897HVS0CYlhyoP2N/E8e4kdOvyD/17V0PHyeFF8z5p+N2KmMpSbFzUy3MAzmhG2A5MSzX2UQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(23010399003)(36860700016)(56012099006)(261026121527099003)(11063799006)(261022075727099003)(261009220027099003)(261021121427099003)(261009223327099003)(261022105027099003)(261009221727099003)(261009221227099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jpad5Rw/AkRliHFnoqH2/tLYoO+np0i1sEAmgGHqMRNUj26rR+fKeqzsSYCqUQFnKIOdLIc0hS8iSS3CQsvSqJgZ1kreWc+L5zh516dEUJo8eb7Ur3gfMOgvxRf1+bPn0LNH/9s0kHb8tcBo3pxED2ZEm36+z/Icu2df4bSGam9Q/Y5JWk64D0Mb9Z7+plgoOm5b1j6Dl5hHtJ7RDqTloJWDX9OWtlcANsiI57kLeAto83Y9ha026kHIftS8YW3OxAAxOq227Lq63s5kDOvq09RO/DprQFgxXsni+rP0dw6z3ValJyZPhb4wAkXGR/fXFvWTgBRA6PH7IHQxbhJV6WqNWXP35n1gald3tEtW0mp/MhhHgjgquDN6A4SeOrFricb3NmchOhd6QljSi6SVHidHSSthFnn0eMjV3VVp+iW9MCqJHUJ48MSLRX50SHxZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:13:17.1773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd066a44-f5cd-445c-011b-08df36a916fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00006E23.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926

From: Peter Colberg <peter@colberg.org>

Add the #[vtable] attribute to pci::Driver and its implementations to
support the optional sriov_enable() and sriov_disable() callbacks
introduced later in this series.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs       | 1 +
 rust/kernel/pci.rs                    | 2 ++
 samples/rust/rust_dma.rs              | 1 +
 samples/rust/rust_driver_auxiliary.rs | 1 +
 samples/rust/rust_driver_pci.rs       | 1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 87917dea4f5..dc6febeee65 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -101,6 +101,7 @@ pub(crate) fn bar1_resource_index(pdev: &pci::Device<Bound>) -> Result<u32> {
     ]
 );
 
+#[vtable]
 impl pci::Driver for NovaCoreDriver {
     type IdInfo = ();
     type Data<'bound> = NovaCore<'bound>;
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index e522fdddc34..c60edd01b70 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -283,6 +283,7 @@ macro_rules! pci_device_table {
 ///     ]
 /// );
 ///
+/// #[vtable]
 /// impl pci::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     type Data<'bound> = Self;
@@ -298,6 +299,7 @@ macro_rules! pci_device_table {
 ///```
 /// Drivers must implement this trait in order to get a PCI driver registered. Please refer to the
 /// `Adapter` documentation for an example.
+#[vtable]
 pub trait Driver {
     /// The type holding information about each device id supported by the driver.
     // TODO: Use `associated_type_defaults` once stabilized:
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index ffb69354467..804d55a6300 100644
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
index 0bee16faecc..6cff9bf8c80 100644
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
index 13b035a9575..50c8709739c 100644
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

