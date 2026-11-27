Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795819814;
	b=jYromhzLmogxuNI1d+U1lhd1S1PhUfk9RHz/00kM0L3k4IRVnXqMWBU/Nac5Cd3RxBpQ
	 MHYWvAAU/Mbr+GIpeBPNnWVHf3k+/+IbRqtXS3y06qevFj85ZYYwjOzXOtqfHC3KJo4R3
	 LY9lO5q2wCMeDtGc54/EFlLu4TdOhS6duQxbRsqlFeojygBvD3kYm++EqRv69vc+ptcmv
	 DQU6dygqjCRhjDMOmKJ+GDBFI17GnncZr92cRPxRKX4pH6Gh4e1AgJRHyxVKL8GNbRgut
	 XelrtwlN/tQPT8DuB4l2VT/xLkPFeWx6K1jBbHb7sHV4v7eOZPUNPGBI8wr8tB8hIKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795819814;
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
	bh=Vv33MO1wihpEeb70Us0fQ5UW2HU7t1UIuZ07+F4easE=;
	b=cZe61xLYkbgZ/ytW9dy+IIhFIFm1/efWTyfpJOswIC8h/d2ZaDjSfTfvVouKT6hbFyZw
	 qUt7YHb1CwUQWvSIcpVkdbNjxPNrw+hInIij4tY3EzhyclfGUU8hd+CkBsO22GPu3MFou
	 OLV3LVM9+I4LtCWCfbdEEpAyvqi5LVEQRK2S3MvvknBTtvDDw52YrmJY6Q9V+dOgRFBeS
	 JJQWQQBky/2fXql8G5GnAWYdrhwquA2CNS2sbUO7QQH7IfA41hiiYDzKPr4uxHH++Bjyx
	 vIBn1EW9FQNYSnsWVlPmyhNSjpc+tyg900FNYEmHITl+sMlZuy9ApTVQtO+Nwqt3mww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Z5Vkq2um;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.53
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15667606A682;
	Fri, 27 Nov 2026 22:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15667606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Z5Vkq2um
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4cR3SMrIH5ty/xfwbU65D7EmkorGWFtS9z8AV3Eu+Y78TLAfF0iceTD3stzsw8VjDEkzO6aWanEn9MNR33lBz4WI9EquptccWgavEJwiCGWtyEQcjDW4t+HPnlmgZ+ZSyT31qyrqBOGNFvDsXhjRoXElk3w9Ghx+RIze0dcSpA9FOH2qpZGOsFymRn3eyecNHjBuMhCDWp6sabNbku2VJTdhM2TSJ+W/Ys6t5PXDMcq24+XGGHw7eW0Ws2PgisO1iwi5dNCdnaB/gBsjxXLQcFiKiCRA0IdfWyscAIg9PQZv+aXq8WURTL/UbNLWbbehniT0wSrhJkz3qqurajGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vv33MO1wihpEeb70Us0fQ5UW2HU7t1UIuZ07+F4easE=;
 b=YMywYiQYvVYfk/e7QJTuK7ohq2Fq355I+InYEpDLP1DFabP3N1FmWel54hTOzdPg19uKbFsdNDlWfGiDP492FX63e2kPAAm8VJ+Et+zCn+Pu0OGtz/f8gk0id9lniwLSBIEDlRbkkoX7GLdB5KSXEsKPI8VpnXMezZPl+u6m+ygvYcY+JJXbgW93WH+39toRCRzv3/DvIKZvvaQR5rKlE7WBBtrJnAi7LHsIgWKCikcmEM/W20++tvm1DYs/vjVhzDboKljXFSMahR5hGgg5qyENlRXx00QB+1/JRbj+YxHBidOWm9PnlvYv4IwIfUmijanZ+XZP1LOIKIirYm9T8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv33MO1wihpEeb70Us0fQ5UW2HU7t1UIuZ07+F4easE=;
 b=Z5Vkq2umtxwcXhCTRup1FPuTUV3SPixHPFCliI6olvdnd3aNsALo6nYY7OKFXgmIi+z6B/i6menK+NkeOoZz0cc6/LS3QVrZENgOHK40Wakf4b51S0Wd5YmgvqtU3K4Thn9l5KYIWsMOGL/+0d68q8L1tJ8VmHPChmLnjk9N3VQjMkcct7kmp2Y4VvyKRZSTa2ALL1lEqtF97E7fCDSbgr2eU0sIsL++1x8fPXEQPJE7gLRsesUrBss46yNrJiyuUWqoOKk6+xrETAsvDEymP5fpo/NW73BkvbYD1ZKjyj4ECWLPkmpT4MeWziHY7Mg2oBJaRH3Gt2c00OF4/sBmoQ==
Received: from PH8P221CA0035.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::28)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 22:50:03 +0000
Received: from BY1PEPF000264B0.namprd02.prod.outlook.com
 (2603:10b6:510:346:cafe::aa) by PH8P221CA0035.outlook.office365.com
 (2603:10b6:510:346::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 22:50:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264B0.mail.protection.outlook.com (10.167.242.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Fri, 27 Nov 2026 22:50:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 14:49:57 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 14:49:55 -0800
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
	<dri-devel@lists.freedesktop.org>, <peter@colberg.org>,
	<xinmengs@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>,
	<linux-mm@kvack.org>, Lorenzo Stoakes <ljs@kernel.org>
Subject: [PATCH v4 4/5] gpu: nova-core: publish typed SR-IOV PF APIs
Date: Fri, 27 Nov 2026 14:49:16 -0800
Message-ID: <20261127224928.1511382-5-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261127224928.1511382-1-xinmengs@nvidia.com>
References: <20261127224928.1511382-1-xinmengs@nvidia.com>
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
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B0:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e77a77b-ef33-451b-fa7a-08df4cd8c621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|23010399003|18002099003|22082099003|6133799003|261009223027099003|261022105027099003|261022113327099003|261026121527099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261026140227099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	FBuUaWZICAnlJWBoa0wP/zAkw6A95lH9eJ/q7XO7qds1jiVX2OuzD/USe51oKulL6wFCNXPEs5XC109FBD5QG53l1u7cD5hQTrBdkms0HclMf/LMumOEUBzMKkDnrtkmdyTRbjLTdFGVO1j4Gh0IHZsZVzTotJ7VeXZ2lBygKo9Z0L8ytpf3HnRrRz6J3c1csas8apH1mjMoVRKQjkKGNDDuhlkKTfef/0JmKb5BW3uG0g0ed0BF2vIJ+fxE3xXorpMdSZoQ+ve+MOHqoj3L+Yin5s6Prg2kf9EHjETqBsMQOpTmHYdnHdFtrynPTThMeAIJ/C1mzhfrfxwT/Oj/5ZGmF/cO66hJKJjiMwsPGbycquyV4dQVvz4TmMcPJ+aeM1Nb88hRRr4pGBAwbaYf8XrEYOZQUZmzwoIfUF0C+VgjM043+1Cbnn9XgIvpyGlQoxKdeihZ67yvUSzP2EGN2vtNqIhUr/ie0yp/7si/kQ24PqFq19WUIW9IKoRVvgkqpXj8slBvc+Ek53nNZQ8yGKBKkYZdFymdserQ1w6smt3qMKU8bN52r9Wz7FQH9GUkl0fsww/WMs4saoWfggG5wNd19EEZjno/Q65qhjMtenoaCAdtdf7pU2+vXHhKzHcD7VEzqZmzoiQrr5Q6MaUCGqCoM3g5UnwNEoubTmU5Zxvj4ee+o8fAwtR8Qcg/RYJVOqambogy37PvkM0kQU90KQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(261022105027099003)(261022113327099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261026140227099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OJL6g8bGQyjGyPo1043ZVVFoVDo2mrv19Gic6s5A8G4L1KdRVGvof90bOc2B4w6t4wZzDNkqpIQDL6tEQRRpXrq3lXy02cCV4jnUgws3zPDFLuniDeBl0lImDu/ms47fo1xOyIc2B733ZPTmkOSVKH8hQyLDphGhGpipPIxvQcCYj4f7UywWqvyrCXh9ybulWPQIxECx6j3FNTEC9wPbrAENWHUcK1YhQ2soSyOf1wXYbRV5Uivm28sxaRN9cgMHWDwbB/MI9VP5lzNdP9SYHxYxfMK1+CXcniI134Cz2eVBYj791gDuiXt51Qsw7bKQqXv6hLnCNddeX6jcuMulDW6iQ7Hs/yt0qXSTkf2fTCjqA6a5h+AfPIS8olyPFa74FHVgZ527Vn/He5hnuR5A6BTtLuUzv85oON03OVhQC/SwAepXDHN854HQlMhWdsIx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 22:50:03.0400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e77a77b-ef33-451b-fa7a-08df4cd8c621
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451

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
 drivers/gpu/nova-core/vgpu/vgpu_api.rs | 171 +++++++++++++++++++------
 4 files changed, 167 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 86f47016dcff8..6b99e88e2090e 100644
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
@@ -43,6 +44,10 @@ pub(crate) struct NovaCore<'bound> {
     /// Unregisters fwctl and drains its callbacks before GPU resources are dropped.
     #[uses('gpu: invariant)]
     _fwctl: fwctl::Registration<'gpu, NovaCoreFwCtl>,
+    #[allow(clippy::type_complexity)]
+    #[pin]
+    #[uses('gpu: invariant)]
+    _vf_registration: pci::VfRegistration<'gpu, ForLt!(NovaCoreVfApi<'_>)>,
     #[pin]
     #[uses('bar1)]
     pub(crate) gpu: Gpu<'bar>,
@@ -115,6 +120,10 @@ fn probe<'bound>(
 
         try_pin_init!(NovaCore {
             _: {
+                if pdev.is_virtfn() {
+                    return Err(ENODEV);
+                }
+
                 pdev.enable_device_mem()?;
                 pdev.set_master();
             },
@@ -146,6 +155,12 @@ fn probe<'bound>(
                 Ok(())
             }),
 
+            // SAFETY: The registration is stored in `NovaCore`, this driver's bus device
+            // private data.
+            _vf_registration <- unsafe {
+                pci::VfRegistration::new(pdev, NovaCoreVfApi::new(pdev, gpu))
+            },
+
             // SAFETY: `NovaCore` is dropped when the device is unbound; i.e. `mem::forget()` is
             // never called on it.
             _reg: unsafe {
@@ -177,4 +192,21 @@ fn probe<'bound>(
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
index b2cb11c0a4d20..03e01003674df 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -35,9 +35,10 @@
 
 use debugfs::DebugfsData;
 
-#[cfg(CONFIG_PCI_IOV)]
 pub use vgpu::vgpu_api::{
     NovaCoreVfApi,
+    NovaCoreVfApiHandle,
+    VgpuInstance,
     VgpuTypeInfo, //
 };
 
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index 1aee21dbe740d..3353faf737903 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -42,7 +42,6 @@
 mod hal;
 mod instance;
 mod scrubber;
-#[cfg_attr(not(CONFIG_PCI_IOV), expect(dead_code, unreachable_pub))]
 pub(crate) mod vgpu_api;
 mod vram;
 
diff --git a/drivers/gpu/nova-core/vgpu/vgpu_api.rs b/drivers/gpu/nova-core/vgpu/vgpu_api.rs
index b263e96098a80..1064e461cd269 100644
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
@@ -51,27 +52,38 @@ fn from(vgpu_properties: &VgpuProperties) -> Self {
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
-    vgpu: Option<&'gpu VgpuManager<'gpu>>,
+    #[uses('gpu_resources: invariant)]
+    cmdq: &'gpu Cmdq<'gpu_resources>,
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
@@ -81,11 +93,29 @@ fn gfid(&self, gfid: u32) -> Result<Gfid> {
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
@@ -97,29 +127,31 @@ pub fn open_instance(&self, gfid: u32, sbdf: u32, vm_pid: u32) -> Result<VgpuTyp
             dbdf.into_raw()
         );
 
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
-        let vgpu_properties = query_vgpu_properties(dev, cmdq, type_id)?;
-        dev_dbg!(
-            dev,
-            "vgpu_open: gfid={} vgpu_type={} fb_length={:#x}\n",
-            gfid.get(),
-            vgpu_properties.type_id,
-            vgpu_properties.fb_length
-        );
-
-        vgpu.create_instance(InstanceInfo::new(gfid, dbdf, &vgpu_properties, vm_pid))?;
-
-        Ok(VgpuTypeInfo::from(&*vgpu_properties))
+        self.with_project_ref(|this| {
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
+            let vgpu_properties = query_vgpu_properties(dev, cmdq, type_id)?;
+            dev_dbg!(
+                dev,
+                "vgpu_open: gfid={} vgpu_type={} fb_length={:#x}\n",
+                gfid.get(),
+                vgpu_properties.type_id,
+                vgpu_properties.fb_length
+            );
+
+            vgpu.create_instance(InstanceInfo::new(gfid, dbdf, &vgpu_properties, vm_pid))?;
+
+            Ok(VgpuTypeInfo::from(&*vgpu_properties))
+        })
     }
 
     /// Tears down an instance, retaining resources if firmware cleanup fails.
@@ -131,11 +163,13 @@ pub fn close_instance(&self, gfid: u32) -> Result {
 
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
@@ -145,9 +179,68 @@ pub fn reset_instance(&self, gfid: u32) -> Result {
 
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

