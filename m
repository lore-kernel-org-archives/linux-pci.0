Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7034DB56;
	Thu, 24 Sep 2026 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276818; cv=fail; b=giuhL0gUVbXKq92NWxJx5HMIepsEXJ2c/YkgV0f0iQzz4m/EYgX+FhQMRPBiGsGfKf6TuCx9h7DZWkXYWNToGcNJfxyBf/i5MCQrpCuVh8JnLUicHMo1ELjelkBWwfaTxmwUAFUvUxUtV/lSLXxP3iwf9NSDaSMhyRJRJBUrUDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276818; c=relaxed/simple;
	bh=967fZ5alGimzDyohJpCrReF+KAlbLzuwgtAUFdCiRPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCO8TeWsrLpfqhSQXaHRy9i8iqs8pISU9A0GCS5D9WVxPBVNLXjVFq69YohX7jK8vkoBKhV7EuWimW1gkWC4KRl+Yl7LIoX+78H46BdGgxDu62+2bMIiQRe86GNzwFLrj5aGqbC/dTx+w4qOMT9nlJ2BWHBbT4GAXF6SFTh4HJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fWx4Wz7i; arc=fail smtp.client-ip=40.107.200.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fWx4Wz7i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nY7iXKt/soYhQpksvFxlwC7DY2JydHg+2gQAipUlkRw4uS5l167ZDC609Fyx249IMY+zYWM6xflwNA30u5TinfpZew5DBtHW+J+38uslcW7Rn2E/pcTNxqbkXIGpgv8lOJhJ4nvZ5zjbU5DsHO/PCviCpmgzWALMCt6Sd3GB2v8SrxiB04ln9sxA75g+VrrM0/+fk3NpB+KB+OVr0GZWhoouxibqyYLJUZ+0Ya7eFQY+ZZWaI32yW02J5iJCkCP8vhMDCDBPQamROyOEVNfqv2Gi9DUgmanRmIMcgPkQb36Kg5Ylc7Yz2ZLbCjwmAwB4lJvOU9W/tO2HkPoxido+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmUN+LkMZgTbh4GfcnyTU8LPhmSr3EvIKaH37PBdKkk=;
 b=VwLxSRcOjdxrx8GADu24+jxTrs0u9kTWFGB5YpbcgVbYDbhratEPoL3BwR2Crjp1lLTAEqJzZCOqrdKFdMJAtkwQtDBLGIXCIP+IwLArqYHRlt1NhFnGeLYLLdrn5WQa15XUZCFMTeLt9xvUjWmew6df1olAIUkaTnGuGiTE3hcpO4m5uOqZYbtW37FkzCsy+fGh0Ros7k3Al/MmjyFfcgIqRbj5jRfyGG3uwn0AFBUJIqFkSQQ/LWoT3iJiNE2sdeVgwhEHOOQeAYI04rdMM7xbazVYayYPMf+PnPd35y9hP7zY8uOoL4aIrBuyjEgOzuMUtPaiR3ocQ6Fb/eZOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmUN+LkMZgTbh4GfcnyTU8LPhmSr3EvIKaH37PBdKkk=;
 b=fWx4Wz7ifektIKZ6Fe/Ohr8cZ4EvK2uHXI9YmEIiElYS1JJd3I5WsEl96CN7nTLYNAuhmoPx+v+LGdT9XbuwtBcsBUqj2W5ba1x3mq8Ft0dUcpO2oManLJ4kplkTMiojJAVxemN+vqQ++DVEd0HXoANAHack4GewXU+PbLhHwaRVvNOvUk/vIPcN9zDYmratYRIWGVnTEMOJJ+qj+abH1Badf8lLkSSdQ/V1yC8O7sSV+kQ///lzlCeNjvEc4BKi9v130Fqx/l0Jy76qxXUbaPy68yS224EBftSomYtOTqXq1oAmFV6IzfHmN7W9Q7jpqNqR6Q9HVFg/6wezS7IxCw==
Received: from YT4PR01CA0109.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:d7::29)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:06:49 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:b01:d7:cafe::22) by YT4PR01CA0109.outlook.office365.com
 (2603:10b6:b01:d7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 19:06:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 19:06:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:06:30 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:06:30 -0700
Received: from inno-dell.home (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Thu, 24
 Sep 2026 12:06:20 -0700
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
	<alex@shazbot.org>, Peter Colberg <pcolberg@redhat.com>, Zhi Wang
	<zhiw@nvidia.com>
Subject: [PATCH v2 2/8] rust: pci: add vtable attribute to pci::Driver trait
Date: Thu, 24 Sep 2026 22:05:49 +0300
Message-ID: <20260924190556.1620886-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924190556.1620886-1-zhiw@nvidia.com>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6d10f5-1f48-4ddd-3ae4-08df1a6efc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|7416014|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	g+XcgNJy91ZbsBmRf3lPquMrOBH3V9pfpsDsirVQjQ2g2w+/XW4TC2qxQyJ2yfeLAelGnL1NPvfNKxkVlM3MuJ5+A5XSIE9xQFqkU9f4KxLE5cWQxt0KYd9BuSPAR8vGKqPUZnpmAugbZrUqmvdh/SJyteq6OKNl20L/JnSsBTwodRzjhd1mIZHdL3yz/nxSva0Rim0mtMz64B6kC6z1jiFIn9zVNDt8aCkp0S+AwpelZ1taDQeKmZ8WDG3x6BM+yO3KXQtGSB58BN3+2yqiw4VzC8dVUJNbe3IFaH7K8/suThk+SIfzXiA/yrnd+hZxBkc4xvgwXSwCislLAmRhwrkvuc5+iKEkb7pHBsBFseq5tWabcB8mNM9K80UfDMIOsNuWFR87yfkLlYDIPo8UIODaeKosJ4TXEP2drZxRhE/PDbjcxNSykdIuFCG3AyApuFh6f92uINDFvlbHLZw4Qn9eL945einCp9QxzifWkdr6uzU5pSOZIX+n+U3YegaeNIWDuybiDbcuvnD4rdeyP48NQmzw2b1NDKX43KEW3RfaAkeFSj0IVZacRXdVFQX8aFD2sxV+MascJgnufiEB+BbVMpKBcn/XbAVUCcgUTRGxUZYT2oY0XmcxXO3AwivsZ4vyzE/iV4hLAiDDO95kMjJYOWqS74lLGfugM5nQRLaLDDOSC2HG0d/vmxEOhdCIFMe757Pt+xm7NQVQ87/7Og==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(7416014)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UX5TqntBkPCCCFn39uSceFcZRSAQYkgzLCCcR9FkZcJbhDMwVgGFGqfdjsFm2Wzj7X8pyFaexUVJ4BEYgayqYr48IhPA77oFez+z22Ob/H3nJC5RI6LPj3fHW7l2AsLSM0qKQbTBMReSgPqg5l5B1LYf5+qYrd2dEE8Qmh05A3tewhHs3Xo4pIlrLYebqdGyG0pDqjXYjs043zT5IuIIFpICfLMrxvaC2GvPCc9pyV4We6vl6T/4wJbMXYq2xwXAcqBVo0geKfwCMT1jAbpFHInRAIHtPmH4DDIcnZzzqiZLDCnpnN6D60hSfQ3YweZW6kU+1h56o+2Q3DrlwloOtmZjNZnidLBAL+2yAK2UEIcUnfJfUh1uwwu+pN01BRqTN620dT2XHoUHHQPf4RfLg/KxQYQw+56t2CbuYjX/3yGdtY66A44LXoNpHajQK7rI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:06:48.5486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6d10f5-1f48-4ddd-3ae4-08df1a6efc04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598

From: Peter Colberg <pcolberg@redhat.com>

Add the #[vtable] attribute to pci::Driver trait and implementations,
to prepare a subsequent patch that adds an optional bus callback
sriov_configure() to enable or disable the SR-IOV capability.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
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
index e6dac919f02d..622cf91fe5e3 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -276,6 +276,7 @@ macro_rules! pci_device_table {
 ///     ]
 /// );
 ///
+/// #[vtable]
 /// impl pci::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     type Data<'bound> = Self;
@@ -291,6 +292,7 @@ macro_rules! pci_device_table {
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

