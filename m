Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770086;
	b=w5I9sEYiX2eDUNuDGRVQOGaTf79W7gdWopjlGbSNLkIYUFvEdcYD/5wCbnutqawYMvlz
	 L+vGuK1GadqL6yGNASmjv/Ts8SWCFkq10wqhqj4SM3jLnxCtN8/ZL1LnD+aiTQ+AMRUZ4
	 mPQGtpwOJ4MnxQDnmjIP9og9aZn19Z52ziCGR7vKCWxbdgU+/lU4GAiYSrr2uRUYtWu+C
	 gGlO11dNHryar+0OTsX3DI0PN+9iOISlV59K+SpEql793ce+28yzKbzxTroP3kgoxIdke
	 tc3tiAacSd3YJcwfwJvph8BtBpqhPiKa7YL2f4tvxGBvNAfogHUwBgGNgIyklQOd65g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770086;
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
	bh=RkfP1OZeK3M8qmQIodlCBgJsG58wBYQjiY33tunm5s4=;
	b=kZm4pYuwutSbgLH66lPtpwSlgAIiZCwLLhb7TlgL0Q/Rz4JRygKhaLUSeVqRPRMcwCxm
	 mYjcJ8F1pnce+jgmHehLYTOpVWx/r2IznUt8Tbj46R+tApyYcdz2/E2QdJ/GScsdxED0f
	 f1/3/InVnX5y/zGDyyJKEkooJubYMPgNvVtF4XcT/AA3CChIVaWgeBeOlPVnzbGxMiNcz
	 dQoX3oIN0BnpNzVmgzYCky+v6/gqOe5z3wqY2/fBa4FYsI9bcrHr2SZUqlDxaTEoFgJw0
	 IuHpp6yEzglJG8E+GqydCagSrAILV46zLKejzaXhxSn8ps8VZJdfxZkl9Y7yRAU7etQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YzGxLblo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.52
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010052.outbound.protection.outlook.com [52.101.193.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA4C606A33B;
	Fri, 23 Oct 2026 15:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFA4C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YzGxLblo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCdokpuRjJ5QL+GrPdJgYCLlBMnupNQqfgmmNVYEdEVwwMPLoGD8tqU9wb3i/KN61Dt7I7A/KNpNlf1+XLHuh9qQIkUv4+D7U+FIonmuLi+6KMId01x33/Zbif1awPG4QlQRCGofnJwU50j0GZl7EKzyNZZkYWAKjLulNPqmrdJ5Ra6h5neQDmcz98IFwG+7zcQrUGTqOI1kugyF+mYsIBcz/t93ehwZRsbu5xmTXQeK1Y4fOaqiPV3uXX3EcSQWieCQxcEHyuBdNfDqSCIkevDckP+zPXnzqZ4lV5PeRDN0AxknPB6mwK7N14jC46n4E9myXuukdAChchIqz2llcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkfP1OZeK3M8qmQIodlCBgJsG58wBYQjiY33tunm5s4=;
 b=OrTHktja52qw3s1J7FD+GuiZXkTzhJTz0Vi7UnGnodMQJ+/hFjiiN3nzZxxvGLZsCoeTGzRCBMLoqokQMkbAQwTp7HYkazfW/c6PVF5qusEnErEMto2AZyVRXdkh/UJxljPYdon3YIARfqApEFGhm13Z8adrTROZUkVhVfvoqWPr4jdxPQuU7E8AAU1uYC7l90kjHSqTg8YviIeK1yH9iuuUclNHxMuTuir8D4nDNMGpjHaWRVSkxp3bWQD8GwK+b+A13DP3bq+9HaQYKAGSz8RcmSv7rSBPtJSMem9/CU/83fdtQVktctYlJ+4ki0CDrTU3+STP3Gk1R/3tFm2I9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkfP1OZeK3M8qmQIodlCBgJsG58wBYQjiY33tunm5s4=;
 b=YzGxLblor/8NsPt0gg/AeE8+glvLMoLLu47l5/jgZnrkCXg9X46VDsFMyqknQE0PLhnx8i+BojLA6r8Ha7u4W0lwMh6lwL2xkN2d4UPbnCQKJu9wywSul1K5pe48zKIPSOHuquYW/8pdWSmtEARpGbmPVK1b+HeduIzEoAJwXWfJwirxB/E2woyH0uiDNJzn34vFPixXIJpifAh+sWGbD7LkioJU9db0OLzPRkqn+lr21xO68Cd7qmqQ/N+KeEgkWyqU8CTYn/DyUX3h+ro0S0pjV2RY5sq1OYpAxGvw81I1DkJbGXzKCVB+qFt0Pjcs9dI9p2JAknL/NISbVPHN1Q==
Received: from MW4PR03CA0303.namprd03.prod.outlook.com (2603:10b6:303:dd::8)
 by CY8PR12MB8267.namprd12.prod.outlook.com (2603:10b6:930:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 15:41:16 +0000
Received: from CO1PEPF0001885F.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::14) by MW4PR03CA0303.outlook.office365.com
 (2603:10b6:303:dd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Fri,
 23 Oct 2026 15:41:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF0001885F.mail.protection.outlook.com (10.167.249.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 15:41:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 08:40:53 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 23 Oct 2026 08:40:51 -0700
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v2 11/12] gpu: nova-core: publish typed SR-IOV PF APIs
Date: Fri, 23 Oct 2026 08:40:06 -0700
Message-ID: <20261023154009.2246627-12-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023154009.2246627-1-xinmengs@nvidia.com>
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885F:EE_|CY8PR12MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c099f5-bde5-4cb3-0629-08df311c12f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|56012099006|11063799006|261021121427099003|261022113327099003|261022105027099003|261009223027099003|261021123027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	K6RCQcZ/9HQo9Gfv9YAKVNCVp8vORN9bgrbXoECwWBB81P/Ra1BIHFAOQlm+q7ADYHZUvNq1g2+xQrOLl5mwPaWNCF0kTxEit2K9pwarPUC8GQmt0z55VPX5/6cg7o6904126r+hSvH4rmLliDcyMLu76Wn03qsHDK24OZmrM3xWxZMNZiOpmoM04PfsitQFu74cnrvfYxDCfXc30sXJOIpUEyslXxtzofNwcjnZ7WUg1xzeTWv+osyceN6Erh/So2c/e1oy2rdc3bqnGE+3AGruswO1S6ywqQU7QhGJvLv6oAkOJy0IEtfS0rHpOhttgqW8292Q19eo3tr6BCDTUdEEWZcZTdSLFW9P3U+Ikh+pLtb3/Op2DSHPEaMIf/Jforl1TpigBVbnuOy9p6NN0ovuYBw+7yISrumEYc+KQuklwF5sUlEG0b8YxrJSNOemBWmr1nKOCPARNGW93HJDvlj1m4awBl3Y9Gbp2glCt+lEyvcq2ntWjR+7jbrN6ZaWk9p7EMgTti91zKtkpIPn2e9wNMsdncWwWouUnJADBAUHH/JQKWt1jckY+DRxzQyW+KohqHXfqew+wlmUVTAzAjLzZryt96/05oy1WJbkIBSJOT+tSj819E8SQX8F2UoMk/Tfatoo4iEA46xMm2F5Q5FoAwEXfyo8FFqFsWSp/XI8aVLsLNv593v5ctdekVdlUiNBYxSxxjzBoNuARYhQRA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(56012099006)(11063799006)(261021121427099003)(261022113327099003)(261022105027099003)(261009223027099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PL0f9H4h8qqYklsJi1oYv46vT+/QwZKZjLLeTJA+mzuDslSG4XrjCK0Lsc7YnHDEdNQoZCGBCJe64AYLVVkadJV4xE7kPVRgsMLxmK3GLS5Hn10HZpIfEL2GeQDvm7ULFOOplALqR91tM6vSiAHLWKjqOXrYdx5T85TfWXQn/0u9Pu0B79uYJv9x1Mt2wBF7Tg2/aR9y3YeGep/eLCDmFGU1+jrU86jUc8JIO6cR4mbAuvmBP3HP/hvUs2o+a8Sq2p5m+297GGe1RX9U6hgFX8BSpA0bguDdJ+4EEx44Ww62KVAyW4f7yJynjWMttfoVRRR7KkZD06liU/dSyijYxklU2ID0BYDIAF4yj8/INI/U6KW1uWWkE12DRnj79bHBhrJxMEV18ilNeFY5uJg7vwiUZz1j2iByYzQK/mk+PztD8qXM0xBYv0lwYEbAifld
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:41:15.6033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c099f5-bde5-4cb3-0629-08df311c12f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8267

From: Zhi Wang <zhiw@nvidia.com>

Register NovaCoreVfApi as typed SR-IOV PF data once the GPU is initialized.

Enable and disable VFs through sriov_configure(). The Rust PCI adapter
removes VFs before dropping PF driver data. Declare the registration
before the GPU so its borrowed services remain valid through VF teardown.

Expose a VF-side handle that borrows these services for each operation.
Return an owned instance on open and close it on drop while the VF
remains bound.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs        | 47 +++++++++++++++
 drivers/gpu/nova-core/nova_core.rs     |  2 +
 drivers/gpu/nova-core/vgpu/vgpu_api.rs | 82 +++++++++++++++++++++++++-
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index dc6febeee65..99beab18987 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -35,6 +35,12 @@
     }, //
 };
 
+#[cfg(CONFIG_PCI_IOV)]
+use kernel::types::ForLt;
+
+#[cfg(CONFIG_PCI_IOV)]
+use crate::vgpu::vgpu_api::NovaCoreVfApi;
+
 /// Counter for generating unique auxiliary device IDs.
 static AUXILIARY_ID_COUNTER: Atomic<u32> = Atomic::new(0);
 
@@ -42,6 +48,10 @@
 pub(crate) struct NovaCore<'bound> {
     /// Firmware-control registration.
     _fwctl: fwctl::Registration<'bound, NovaCoreFwCtl>,
+    #[cfg(CONFIG_PCI_IOV)]
+    #[allow(clippy::type_complexity)]
+    #[pin]
+    _vf_registration: pci::VfRegistration<'bound, ForLt!(NovaCoreVfApi<'_>)>,
     #[pin]
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
@@ -114,6 +124,11 @@ fn probe<'bound>(
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
+            #[cfg(CONFIG_PCI_IOV)]
+            if pdev.is_virtfn() {
+                return Err(ENODEV);
+            }
+
             pdev.enable_device_mem()?;
             pdev.set_master();
 
@@ -144,6 +159,18 @@ fn probe<'bound>(
                 // Run optional GPU selftests.
                 #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
                 _: { gpu.run_selftests(pdev) },
+                #[cfg(CONFIG_PCI_IOV)]
+                _vf_registration <- {
+                    // SAFETY: `gpu` is initialized at its pinned address and
+                    // outlives the registration and its borrowed API data.
+                    let gpu = unsafe { &(*this.as_ptr()).gpu };
+                    let api = NovaCoreVfApi::new(gpu, pdev);
+                    // SAFETY: Probe has exclusive access to the registration
+                    // slot and no VFs are enabled before successful probe. The
+                    // registration keeps PF services available until VF removal
+                    // completes and is dropped before its borrowed GPU resources.
+                    unsafe { pci::VfRegistration::new(pdev, Ok(api)) }
+                },
                 _reg: auxiliary::Registration::new(
                     pdev.as_ref(),
                     c"nova-drm",
@@ -176,4 +203,24 @@ fn probe<'bound>(
             }))
         })
     }
+
+    #[cfg(CONFIG_PCI_IOV)]
+    fn sriov_enable<'bound, 'callback>(
+        _dev: &'bound pci::Device<Core<'_>>,
+        _this: Pin<&Self::Data<'bound>>,
+        token: pci::SriovEnable<'callback>,
+    ) -> Result<pci::SriovEnabled<'callback>> {
+        let num_vfs = token.num_vfs();
+        token.enable(num_vfs)
+    }
+
+    #[cfg(CONFIG_PCI_IOV)]
+    fn sriov_disable<'bound>(
+        _dev: &'bound pci::Device<Core<'_>>,
+        _this: Pin<&Self::Data<'bound>>,
+        token: pci::SriovDisable<'_>,
+    ) -> Result {
+        token.disable();
+        Ok(())
+    }
 }
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 619f32c7941..ee511bdf354 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -33,6 +33,8 @@
 #[cfg(CONFIG_PCI_IOV)]
 pub use vgpu::vgpu_api::{
     NovaCoreVfApi,
+    NovaCoreVfApiHandle,
+    VgpuInstance,
     VgpuTypeInfo, //
 };
 
diff --git a/drivers/gpu/nova-core/vgpu/vgpu_api.rs b/drivers/gpu/nova-core/vgpu/vgpu_api.rs
index f9f3e527bdc..a440108d2c2 100644
--- a/drivers/gpu/nova-core/vgpu/vgpu_api.rs
+++ b/drivers/gpu/nova-core/vgpu/vgpu_api.rs
@@ -11,6 +11,9 @@
     prelude::*, //
 };
 
+#[cfg(CONFIG_PCI_IOV)]
+use kernel::types::ForLt;
+
 use crate::{
     driver::Bar0,
     gpu::Gpu,
@@ -61,7 +64,6 @@ pub struct NovaCoreVfApi<'gpu> {
 }
 
 impl<'gpu> NovaCoreVfApi<'gpu> {
-    #[expect(dead_code)]
     pub(crate) fn new(gpu: &'gpu Gpu<'gpu>, pdev: &'gpu pci::Device<device::Bound>) -> Self {
         Self {
             pdev,
@@ -84,6 +86,20 @@ fn gfid(&self, gfid: u32) -> Result<Gfid> {
 }
 
 impl NovaCoreVfApi<'_> {
+    /// Obtains the enabled PF services for a bound VF.
+    #[cfg(CONFIG_PCI_IOV)]
+    pub fn handle(vf: &pci::Device<device::Bound>) -> Result<NovaCoreVfApiHandle<'_>> {
+        let handle = NovaCoreVfApiHandle { vf };
+        handle.with(|api| {
+            if api.is_available() {
+                Ok(())
+            } else {
+                Err(ENODEV)
+            }
+        })?;
+        Ok(handle)
+    }
+
     /// Creates and boots an instance for a one-based VF ID.
     ///
     /// `sbdf` encodes the VF address as `(segment << 16) | (bus << 8) | devfn`.
@@ -156,3 +172,67 @@ pub fn reset_instance(&self, gfid: u32) -> Result {
         Ok(())
     }
 }
+
+/// Access to PF services for the lifetime of a VF driver binding.
+///
+/// The PF's registration keeps these services available until VF removal
+/// completes and is dropped before the GPU resources they borrow.
+#[cfg(CONFIG_PCI_IOV)]
+pub struct NovaCoreVfApiHandle<'vf> {
+    vf: &'vf pci::Device<device::Bound>,
+}
+
+#[cfg(CONFIG_PCI_IOV)]
+impl<'vf> NovaCoreVfApiHandle<'vf> {
+    /// Borrows the typed PF services for a single operation.
+    fn with<R>(
+        &self,
+        f: impl for<'borrow, 'data> FnOnce(Pin<&'borrow NovaCoreVfApi<'data>>) -> Result<R>,
+    ) -> Result<R> {
+        self.vf
+            .vf_registration_data_with::<ForLt!(NovaCoreVfApi<'_>), _>(f)?
+    }
+
+    /// Creates and boots an instance that closes when dropped.
+    ///
+    /// The arguments have the same meaning as in [`NovaCoreVfApi::open_instance`].
+    pub fn open(&self, gfid: u32, dbdf: u32, vm_pid: u32) -> Result<VgpuInstance<'vf>> {
+        let type_info = self.with(|api| api.open_instance(gfid, dbdf, vm_pid))?;
+        Ok(VgpuInstance {
+            api: Self { vf: self.vf },
+            gfid,
+            type_info,
+        })
+    }
+
+    /// Resets an active instance and scrubs its guest VRAM.
+    pub fn reset(&self, gfid: u32) -> Result {
+        self.with(|api| api.reset_instance(gfid))
+    }
+}
+
+/// An active instance whose teardown runs while its VF driver remains bound.
+///
+/// Dropping this guard may sleep while firmware teardown completes.
+#[cfg(CONFIG_PCI_IOV)]
+pub struct VgpuInstance<'vf> {
+    api: NovaCoreVfApiHandle<'vf>,
+    gfid: u32,
+    type_info: VgpuTypeInfo,
+}
+
+#[cfg(CONFIG_PCI_IOV)]
+impl VgpuInstance<'_> {
+    /// Returns the assigned PCI IDs and BAR1 aperture size.
+    #[inline]
+    pub fn type_info(&self) -> &VgpuTypeInfo {
+        &self.type_info
+    }
+}
+
+#[cfg(CONFIG_PCI_IOV)]
+impl Drop for VgpuInstance<'_> {
+    fn drop(&mut self) {
+        let _ = self.api.with(|api| api.close_instance(self.gfid));
+    }
+}
-- 
2.43.7

