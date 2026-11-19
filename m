Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795125126;
	b=GLwAm9CwzKkFdNcOKFEWtP5kT3G7q/5+/JYLJkNBOKnQSL8yFkLf36NsYoNB62SQb3Gj
	 7X7QiKAY0mYpRQU76/geB6prZlvof178H/07OuVfUS46dXldUoBJbaVbRnfd/+GSiPBbv
	 WCnsJUD7MPJCe8Z+gnrn1sGlh/7tWXGrrjUBpGRD46j0jIXeNHmWL+aw+zWAZrUduSeje
	 bnmRp+Un6fEXE9d6ABo7OFtP29mpPjQU6lTFJAerJpE+zUU6DQnAVpmXVFfUsyllOeOUu
	 fyD2eWcmoQfGdWefeyzDmUYgx3hHzMa3wFmopjuycJEivGLMOS6feY0DstD0O/peScQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125126;
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
	bh=SexsYJ1gA4F86Hb+z0n+hPrGNPBiHuicpheRtM6BR80=;
	b=Fip1LnsBCLC7pfryH7nxgRyFKJePGSJgWUkeiWElGPYO7Ai5Q2XYiJ0GfYKi/iCiRSmT
	 ghS2hLJUQve6d23lvnhP7wlI8d0q0RjecatDyoQ1H/bs23iB4WUQmZOfNlTC4w+DolCWe
	 FqPV6hd2lbjSc1YN7id1yy2zLMnNfLsSGNYT0UyEmd6oUGDy+WZBYPMyabX3tydU61zxe
	 TAUEYqr0dn7SpNrwgc2AkoWB2kL9vW+N3TebJuXG0YyPkGZ4vnyPRMx8eCzXwf6+DyZDs
	 J+U37ouIwbr2fKXB3O8DTFaCGdvXuEBpxCmF5uJMoiDOggmevn1AKkK99SzutjX5QsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jPgO2xNJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.29
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4460A2629;
	Thu, 19 Nov 2026 21:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A4460A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jPgO2xNJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fev2HINEoiQTwcw6mto+0OdM+jiXFcM4zAVsvAyElaKx5q0ff6TlqS7RYbiBaEOTnflXV9HcYwV9uqSnEZjJdTo2W6sSyYOmGkSvKGQsIEpcqRUGZBu3wnkkhf14H75QR1vZSMo7HFxMsNwJ341UKF+Iseni2VV/+AN8xZEhalJgMqqEdg3xzHf1I1C+83QGbHGqB7o6fs2gFA3nFHy72Zl7gv/pFZHWCxCHQ7EYfuuZsGbbK/0G57bSPtlHyYWsUEsoLcLnlx0FwaGLwBAt37ITZLA8UwKVW0sWcvN75znNCPNhvZqBv+LMnlIc6GuwcqAovzMK3DVUoi7pvmgtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SexsYJ1gA4F86Hb+z0n+hPrGNPBiHuicpheRtM6BR80=;
 b=hv1Tzuxy4FVZqFTpc659WNSR7KwgNhe9usCqYrOL6F4FVuOJYHZqS2hw26+MoPJS+p2ahla33CTG0jujY0JHf4r+n9eIslMWmxwiA1fjq8J6QFk1kCU9sDNvp4BSHNv3VeZLf3IUL1pHgy6HKlVJjjJiXeKspt4WBQUtAprNczqpO+/qwYVKqhFi4DA0h9lWlhTJJceNN/urG4jFpC7dSeQ9Ylu8eQ8QzGP5iUXKT8f9OmMtgPyn2y4h1DgUc4BwfJlKrcZkX0THXZ+5r7YtvBX5YJEK9EkTXNO/59uA4a+mlRxRd6oPivg+3IFHKkCtu90OjFvX7ZnoRSbrDiSQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SexsYJ1gA4F86Hb+z0n+hPrGNPBiHuicpheRtM6BR80=;
 b=jPgO2xNJlr+1faSacNZfUelLOLSf7FyRutuIACphszQOCBARrwvCFCGOZL3wMkiEae8idQa7rOuRW+qt4k7NYUDOEfHiI1M/0BqU0Me3Ni1e4i4ANKBwDQq01ZcDhecOtDnh8Q9dAAe5O13eeUl9VZ5bd8iFowz6QJW8zYTjn6S61Uu1PvOKwkPCPWQsjo/Iuf1ggvJLIEynu5YbjRmA9tiL+BGW+cnKn0vt5C3R8Fj7LIS88xkp4/dBHAlvGN6quTa4A/WkKHhO1RM7RvryWQu0h0HyTHrd3HhSYxHVETgOewqqP5V9fTM0oavJiK4z2QeH9DhuDHEVKvYuRafnMQ==
Received: from BN9PR03CA0161.namprd03.prod.outlook.com (2603:10b6:408:f4::16)
 by DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 21:51:55 +0000
Received: from BL4PEPF000003EE.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::89) by BN9PR03CA0161.outlook.office365.com
 (2603:10b6:408:f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 21:51:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL4PEPF000003EE.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 21:51:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:51:23 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 13:51:19 -0800
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: Zhi Wang <zhiw@nvidia.com>, <alex@shazbot.org>, <jgg@nvidia.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
	<ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <boqun@kernel.org>,
	<daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>,
	<jgg@ziepe.ca>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v3 8/9] gpu: nova-core: publish typed SR-IOV PF APIs
Date: Thu, 19 Nov 2026 13:50:43 -0800
Message-ID: <20261119215046.2892839-9-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261119215046.2892839-1-xinmengs@nvidia.com>
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL4PEPF000003EE:EE_|DS2PR12MB9567:EE_
X-MS-Office365-Filtering-Correlation-Id: 160c73dc-221b-4dfe-ddba-08df468753ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|6133799003|261009223027099003|18002099003|22082099003|261026140227099003|261021121427099003|261028144727099003|261021123027099003|261102123227099003|261022105027099003|261022113327099003|56012099006|261026121527099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	+f94IMtRwYWbDDZPVAnPj5ZL8UzZMYKUKwGr4KZfc19a+e8ZIGMSMyrbs2fhNfV8ksRqudQ5vj1d5kNQ9tD0LilJ9vjTmAUf7cwVQsXBHIT2N0mIgnNKEB5CTI+3kQBijyu6Fe277rYMUotOZbkLhGzWM6troKBvr/uOsSoU29A27UsaxkrHZkKsvMnPl0pix0NKqAXLffHy0ASjbGqNmAQOEyi/b66RB/N6ePMN5Xaax/xIE+qcNqtInRKQyjd/7N7ppcPqdqaSNY3FMI1HnBwzRvIL1KHczxKpukEtLTK0+pl6VjF7psY9EPoVj8kv/pckhGJuOhkn+8ZA1q7/UIS0mSz9FV3rK0Q0k23//rU5fbgI+92lDsKQzGCB5gzkUpsLpyP/TXMNdwdtvswhx44pen/hQX6/2e1FooQe4aA1JZyJYXL07Iuimk/kuMRDaJZdwZNf6Bs0QdpL+GnzPoU3g2vPUoHntDS7GRb3rRgYkRsEAMBdJ3L9X0TuHo3hiWWhOwvVgt36Sjk/XYDzInGafVm6vKRT0s+QDnJko7t4qq8wXmDO/3Pv5Lq71mcoClwvEZadtSoM6jDqVgf19W4KIiYXIbqLylwmWji1XrlI/z6lq0BASBERRoGwUTb3l9pSDamH+boxs+HvL3LWcs1kF2t6Gs2U9YuNN7+yT9zd2r7yxeK3X8/no6oDXF4w+V8KSHyaTJFjgejaBi/g3w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(6133799003)(261009223027099003)(18002099003)(22082099003)(261026140227099003)(261021121427099003)(261028144727099003)(261021123027099003)(261102123227099003)(261022105027099003)(261022113327099003)(56012099006)(261026121527099003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/+GXeX4yx/6Oc/tguVivecQ/0HFozUEHjV8d+wFidRWvnZRmOjNLL037O28Sjwgdz75ycG2fqkHkxEs5pWf+Zz8Z73JgtG7d6IXHa6+m6fdQpKijTpDAKtVuXQcZ0Icm6Z0+AVcN5doxBXiesW1U+EvZIKw7fnK3ja9JLOPMGTC9Xy262Ve+HvPPBmhlSwr6OJMPHF7odhOdrFEJk9J0DZtGLqlyMshq6FMHRMcuZ9lGuwCaBi1htUFD8kd7hs/DBYJQifKa7SQYzYsdVdOcMBilnHMfQA9p7b1CxnVEXTRiyyGuer2jDIsxtSdZLCNxSiQ1izWa/REKo89lULGVisXtRmxrGzebo3HHHxVbA4jD+y4j7zFgRdp5vdo3e60pXqGmKbcoa/iUWOgPsuoTizIv/wAy69S9YPMn96BvdWc5vVH5S1kOiST4d6vcG63G
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:51:54.9113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 160c73dc-221b-4dfe-ddba-08df468753ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL4PEPF000003EE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9567

From: Zhi Wang <zhiw@nvidia.com>

Register NovaCoreVfApi as typed SR-IOV PF data once the GPU is initialized.

Enable and disable VFs through the sriov_enable() and sriov_disable()
callbacks. The VF registration removes VFs before dropping its PF API
data. Declare the registration before the GPU so its borrowed services
remain valid through VF teardown.

Expose a VF-side handle that borrows these services for each operation.
Return an owned instance on open and close it on drop while the VF
remains bound.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs        |  34 ++++-
 drivers/gpu/nova-core/nova_core.rs     |   3 +-
 drivers/gpu/nova-core/vgpu.rs          |   1 -
 drivers/gpu/nova-core/vgpu/vgpu_api.rs | 178 +++++++++++++++++++------
 4 files changed, 171 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 1785a5294823..a306e4233df6 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -29,7 +29,8 @@
         NovaCoreFwCtl,
         NovaCoreFwCtlData, //
     },
-    gpu::Gpu, //
+    gpu::Gpu,
+    vgpu::vgpu_api::NovaCoreVfApi, //
 };
 
 /// Counter for generating unique auxiliary device IDs.
@@ -41,6 +42,10 @@ pub(crate) struct NovaCore<'bound> {
     _reg: auxiliary::Registration<'bound, ForLt!(NovaCoreApi<'_>)>,
     /// Unregisters fwctl and drains its callbacks before GPU resources are dropped.
     _fwctl: fwctl::Registration<'bound, NovaCoreFwCtl>,
+    #[allow(clippy::type_complexity)]
+    #[pin]
+    #[uses('gpu: invariant)]
+    _vf_registration: pci::VfRegistration<'gpu, ForLt!(NovaCoreVfApi<'_>)>,
     #[pin]
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
@@ -112,6 +117,10 @@ fn probe<'bound>(
 
         try_pin_init!(NovaCore {
             _: {
+                if pdev.is_virtfn() {
+                    return Err(ENODEV);
+                }
+
                 pdev.enable_device_mem()?;
                 pdev.set_master();
             },
@@ -150,6 +159,12 @@ fn probe<'bound>(
                 Ok(())
             }),
 
+            // SAFETY: The registration is stored in `NovaCore`, this driver's bus device
+            // private data.
+            _vf_registration <- unsafe {
+                pci::VfRegistration::new(pdev, NovaCoreVfApi::new(pdev, gpu))
+            },
+
             _reg: {
                 // TODO: Use `&gpu` self-referential pin-init syntax once available.
                 //
@@ -198,4 +213,21 @@ fn probe<'bound>(
             },
         })
     }
+
+    fn sriov_enable<'a>(
+        _dev: &'a pci::Device<Core<'_>>,
+        _this: Pin<&Self::Data<'a>>,
+        token: pci::SriovEnable<'a>,
+    ) -> Result<pci::SriovEnabled<'a>> {
+        token.enable_all()
+    }
+
+    fn sriov_disable<'a>(
+        _dev: &'a pci::Device<Core<'_>>,
+        _this: Pin<&Self::Data<'a>>,
+        token: pci::SriovDisable<'a>,
+    ) -> Result {
+        token.disable();
+        Ok(())
+    }
 }
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 5f09b69f3b54..a840b663cf73 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -31,9 +31,10 @@
 mod vbios;
 mod vgpu;
 
-#[cfg(CONFIG_PCI_IOV)]
 pub use vgpu::vgpu_api::{
     NovaCoreVfApi,
+    NovaCoreVfApiHandle,
+    VgpuInstance,
     VgpuTypeInfo, //
 };
 
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index f198fa218297..38dcd68f52e7 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -42,7 +42,6 @@
 mod instance;
 mod log;
 mod scrubber;
-#[cfg_attr(not(CONFIG_PCI_IOV), expect(dead_code, unreachable_pub))]
 pub(crate) mod vgpu_api;
 mod vram;
 
diff --git a/drivers/gpu/nova-core/vgpu/vgpu_api.rs b/drivers/gpu/nova-core/vgpu/vgpu_api.rs
index f9f3e527bdc0..cfac0ca10c1e 100644
--- a/drivers/gpu/nova-core/vgpu/vgpu_api.rs
+++ b/drivers/gpu/nova-core/vgpu/vgpu_api.rs
@@ -8,7 +8,8 @@
 use kernel::{
     device,
     pci,
-    prelude::*, //
+    prelude::*,
+    types::ForLt, //
 };
 
 use crate::{
@@ -52,29 +53,41 @@ fn from_vgpu_type(vgpu_type: &VgpuType) -> Self {
 }
 
 /// PF-owned operations available while a VF driver is bound.
-pub struct NovaCoreVfApi<'gpu> {
+#[pin_data]
+pub struct NovaCoreVfApi<'gpu>
+where
+    // The GPU resources are invariant in their lifetime, which outlives this API borrow.
+    exists<'gpu_resources>: 'gpu,
+{
     pdev: &'gpu pci::Device<device::Bound>,
-    cmdq: &'gpu Cmdq<'gpu>,
-    bar: Bar0<'gpu>,
-    vgpu: Option<&'gpu VgpuManager<'gpu>>,
+    #[uses('gpu_resources: invariant)]
+    cmdq: &'gpu Cmdq<'gpu_resources>,
+    #[uses('gpu_resources)]
+    bar: Bar0<'gpu_resources>,
+    #[uses('gpu_resources: invariant)]
+    vgpu: Option<&'gpu VgpuManager<'gpu_resources>>,
     total_vfs: Option<NonZero<u16>>,
 }
 
 impl<'gpu> NovaCoreVfApi<'gpu> {
-    #[expect(dead_code)]
-    pub(crate) fn new(gpu: &'gpu Gpu<'gpu>, pdev: &'gpu pci::Device<device::Bound>) -> Self {
-        Self {
+    /// Creates the PF services that VF drivers access through the VF registration.
+    pub(crate) fn new<'res: 'gpu>(
+        pdev: &'gpu pci::Device<device::Bound>,
+        gpu: Pin<&'gpu Gpu<'res>>,
+    ) -> impl PinInit<Self, Error> + use<'gpu, 'res> {
+        let gpu = gpu.get_ref();
+        try_pin_init!(Self {
             pdev,
             cmdq: gpu.cmdq(),
             bar: gpu.bar0(),
             vgpu: gpu.vgpu_manager(),
             total_vfs: gpu.vgpu_total_vfs(),
-        }
+        })
     }
 
     /// Returns whether the PF booted with vGPU support enabled.
     pub fn is_available(&self) -> bool {
-        self.vgpu.is_some()
+        self.with_vgpu(|vgpu| vgpu.is_some())
     }
 
     fn gfid(&self, gfid: u32) -> Result<Gfid> {
@@ -84,11 +97,29 @@ fn gfid(&self, gfid: u32) -> Result<Gfid> {
 }
 
 impl NovaCoreVfApi<'_> {
+    /// Obtains the enabled PF services for a bound VF.
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
     /// `vm_pid` identifies the VM process's thread group. This call may sleep.
-    pub fn open_instance(&self, gfid: u32, sbdf: u32, vm_pid: u32) -> Result<VgpuTypeInfo> {
+    pub fn open_instance(
+        self: Pin<&Self>,
+        gfid: u32,
+        sbdf: u32,
+        vm_pid: u32,
+    ) -> Result<VgpuTypeInfo> {
         let dev = self.pdev.as_ref();
         let gfid = self.gfid(gfid)?;
         let dbdf = Dbdf::from_raw(sbdf);
@@ -100,31 +131,33 @@ pub fn open_instance(&self, gfid: u32, sbdf: u32, vm_pid: u32) -> Result<VgpuTyp
             dbdf.into_raw()
         );
 
-        let bar = self.bar;
-        let cmdq = self.cmdq;
-        let vgpu = self.vgpu.ok_or(ENODEV)?;
-
-        let type_id = query_assigned_vf_type(dev, cmdq, dbdf)?;
-        dev_dbg!(
-            dev,
-            "vgpu_open: gfid={} assigned type_id={}\n",
-            gfid.get(),
-            type_id
-        );
-
-        let vgpu_type = query_vgpu_type(dev, cmdq, type_id)?;
-        dev_dbg!(
-            dev,
-            "vgpu_open: gfid={} vgpu_type={} fb_length={:#x}\n",
-            gfid.get(),
-            vgpu_type.vgpu_type_id,
-            vgpu_type.fb_length
-        );
-
-        let type_info = VgpuTypeInfo::from_vgpu_type(&vgpu_type);
-        vgpu.create_instance(bar, InstanceInfo::new(gfid, dbdf, vgpu_type, vm_pid))?;
-
-        Ok(type_info)
+        self.with_project_ref(|this| {
+            let bar = *this.bar;
+            let cmdq = *this.cmdq;
+            let vgpu = this.vgpu.ok_or(ENODEV)?;
+
+            let type_id = query_assigned_vf_type(dev, cmdq, dbdf)?;
+            dev_dbg!(
+                dev,
+                "vgpu_open: gfid={} assigned type_id={}\n",
+                gfid.get(),
+                type_id
+            );
+
+            let vgpu_type = query_vgpu_type(dev, cmdq, type_id)?;
+            dev_dbg!(
+                dev,
+                "vgpu_open: gfid={} vgpu_type={} fb_length={:#x}\n",
+                gfid.get(),
+                vgpu_type.vgpu_type_id,
+                vgpu_type.fb_length
+            );
+
+            let type_info = VgpuTypeInfo::from_vgpu_type(&vgpu_type);
+            vgpu.create_instance(bar, InstanceInfo::new(gfid, dbdf, vgpu_type, vm_pid))?;
+
+            Ok(type_info)
+        })
     }
 
     /// Tears down an instance, retaining resources if firmware cleanup fails.
@@ -136,11 +169,13 @@ pub fn close_instance(&self, gfid: u32) -> Result {
 
         dev_dbg!(dev, "vgpu_close: gfid={}\n", gfid.get());
 
-        let result = self.vgpu.ok_or(ENODEV)?.close_instance(gfid);
-        if let Err(error) = result {
-            dev_err!(dev, "vgpu_close: gfid={} failed: {:?}\n", gfid.get(), error);
-        }
-        result
+        self.with_vgpu(|vgpu| {
+            let result = vgpu.ok_or(ENODEV)?.close_instance(gfid);
+            if let Err(error) = result {
+                dev_err!(dev, "vgpu_close: gfid={} failed: {:?}\n", gfid.get(), error);
+            }
+            result
+        })
     }
 
     /// Resets an instance and scrubs its guest VRAM. This call may sleep.
@@ -150,9 +185,68 @@ pub fn reset_instance(&self, gfid: u32) -> Result {
 
         dev_dbg!(dev, "vgpu_reset: gfid={}\n", gfid.get());
 
-        self.vgpu.ok_or(ENODEV)?.reset_instance(gfid)?;
+        self.with_vgpu(|vgpu| vgpu.ok_or(ENODEV)?.reset_instance(gfid))?;
 
         dev_dbg!(dev, "vgpu_reset: gfid={} done\n", gfid.get());
         Ok(())
     }
 }
+
+/// Access to PF services for the lifetime of a VF driver binding.
+///
+/// The PF's registration keeps these services available until VF removal
+/// completes and is dropped before the GPU resources they borrow.
+pub struct NovaCoreVfApiHandle<'vf> {
+    vf: &'vf pci::Device<device::Bound>,
+}
+
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
+pub struct VgpuInstance<'vf> {
+    api: NovaCoreVfApiHandle<'vf>,
+    gfid: u32,
+    type_info: VgpuTypeInfo,
+}
+
+impl VgpuInstance<'_> {
+    /// Returns the assigned PCI IDs and BAR1 aperture size.
+    #[inline]
+    pub fn type_info(&self) -> &VgpuTypeInfo {
+        &self.type_info
+    }
+}
+
+impl Drop for VgpuInstance<'_> {
+    fn drop(&mut self) {
+        let _ = self.api.with(|api| api.close_instance(self.gfid));
+    }
+}
-- 
2.43.7

