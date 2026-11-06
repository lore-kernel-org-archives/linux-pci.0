Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793945424;
	b=ksXqJBQm9/LQPLc1n26F8+Z/mcXv4w2h6QxCA+qUf9ZN1oNgMaG3cv2gUcF/ELl4wT0E
	 kC2CkA9sZ/5Tf1P2xVVojaAWCagol3jMVK0Rv3pHHkcNpAMWamQkjUlO9LFNWnVhe0U/z
	 d/x7zVA1vXmmCRpP0SL5Vn8UPQPeR1FFCJ/fY7naDuIAO0gWsvKu3tlyOTWpRAu0rRdO1
	 ThHm6qhBYSUBMaFtG5JnNCGDUp5ynNRhIPhAlqifAWJCjVplUd5DQsT+3zjq4jAzRuIQv
	 vA+Im8wlqaT4u2WG9AdrqX84nXrXozQhp9NS+StKr+9HJQ7zo4CuGRCByyfkYSwXDhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945424;
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
	bh=Mj0dMbTy9r7pAxspLE4xjkVaRiqXhWh61EYylaJz/Uc=;
	b=0bdzXVXDRDYt/+7fspUT4lWFmLilNc2a5Jj63Wordkeze4NydxySogkQXT73LPevKaYR
	 PC7cLzrn5Rf+FkZJs44Kr3nmTvr0UlWr4kJ62V078n8MHjjiADP2cx3YfiRAk8GWNI9Ok
	 qBxTDxGIxa4f5Ga8uEnyvXJiBSctDmCeJoRpOjs5gNS3e23hX0+hfJ/BHbT4B+I+f1+sH
	 nIJpt7zDEEsW5o0BJG/oiwMC82K2LbKVvdRpA62Y2UMzJz9MykPFvui796/ruW17KrsVx
	 Ep2/TJw8FYk0xBq1hoHRt23YY315gC+UesMKcw9oQebZUmMomg/BHRuF76FiKL2yNpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V1LtrWYH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.12
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B8606A329;
	Fri,  6 Nov 2026 06:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D2B8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V1LtrWYH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wX8akh4aHrmWTx9BwxmWispKonjfiitSDhgWnB4+dzzkqIABjLkrXLJNyhjpRohCk3zJbc0QBcppdIQ4E1G+ygfjN5q70uiJtgNOF5fi2tvSGjUEqDMJdtktsZW4yy8GHq2yAlHDuS6b2fyiPhtsdFkUHUtiFZwXZpHRkqZovPFx6HjX6xMO+5DOzl4PDDxVlUaKBvW6kJRMMTHC272KrUYjHHFlhVb7UKy1+kQ7gwpHAMSgkPKRrt/RwsU0AuZSAXI3pilKt3w6JcivPUJ7EtJC+MZuzEevGJH5Lj92qlIDqJael3/uu2/1wnmxCyhpHLRWlrFJIzH64Cic0h/yLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mj0dMbTy9r7pAxspLE4xjkVaRiqXhWh61EYylaJz/Uc=;
 b=op0uaZ/EEwZ6xzihJsiCl7nuGgZkrdR708UQpFk7CaayI4uDwLS7FxUW3415mKNIJ+A9Dj9JnZmgHWfsW7dunv9fbqMTRK8OKHLYDolDJZpC1ud1xpvWYYcDIR0xnXj8+InAllUI3lvP2beOAFBI5Ir6P/S54GASah9869wI6stYiP1Ot+YGkLxc4ZUNJ/aWvKD9qzozIHrfwdNaXRk2HypR74OATGgHw7ohzs2arJe+iSEFUglKrOsHPdyu+dj4MtbUqFqKfp9iJl7bHrUAYFyxkS2/a+LjCNzeigoA9oDbpc/s7hSed2ZesLtmQ+PnAOzn8gRpU7JGgHqkl4yB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mj0dMbTy9r7pAxspLE4xjkVaRiqXhWh61EYylaJz/Uc=;
 b=V1LtrWYHio+a8Zw/33w9zFXkRGCwwCf+C8KXWS41BYSqZyvM8VtwsaEia4ca8Vts5oh5eEZqcHQRJJ9cibjxKj9XGVnHVAwa7V6rijY0vy12NhX7lRkl4c/5yBuKCnOhaSX8I1veBq8aihuBZgp42ggEtUr9b1LqtyT2selTcStd146g1EBpyT78HETYlFFsAOqMe0AKNCjMCu+hI8f4LYt7fHMRDoWHnQmjifZgfp8xoJjShsfVK2zKExQZQTG4FrFBQGL1xBq5POvkOxp48tGSf96PHgRDFNOg7t+fHmPKVDbDeawSBBhCrFOE2z1isxXhuOGt3/EeKci0o2HNRw==
Received: from DS7P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::7) by
 SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.11; Fri, 6 Nov 2026 06:10:17 +0000
Received: from CY7PEPF000000F6.namprd05.prod.outlook.com
 (2603:10b6:8:25c:cafe::4e) by DS7P221CA0017.outlook.office365.com
 (2603:10b6:8:25c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 06:10:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY7PEPF000000F6.mail.protection.outlook.com (10.167.247.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 06:10:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 22:09:58 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 22:09:45 -0800
From: Alok Kumar <alkumar@nvidia.com>
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
Subject: [PATCH v2 1/1] gpu: nova-core: add fwctl driver for firmware control interface
Date: Fri, 6 Nov 2026 11:39:14 +0530
Message-ID: <f262007aa406b2c8383501e2c0f8278db7ebef98.1793906674.git.alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793906674.git.alkumar@nvidia.com>
References: <cover.1793906674.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F6:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: da3637c4-c940-4227-eba9-08df3bcca0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|82310400026|36860700016|260925021311599003|260925022911599003|260925021911599003|11063799006|56012099006|261022113327099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	AokVjBK9tDtH95x8VehkFeRV8NEspDuKrubDi42I+NTRgsH6HRIA97bIfk4zRSGpPgC5VLIiPOiZs6Bvm6M8iUGn0ZsoA4eRcGAvC+Kq9Z0tkqKzZs4zheUbWx1wNqY6+quDeBkLp3BtA7sv8XzTOfnVZFT1vWNUDICJBXFnwKb5EE1/iAqnHTv8TZ+JUSNiLys//dcCMUZfypD1QrGfZkr9rVX1dPGXcjhAQr3cfYEokhydGNFwOlbVX63uTMZXv+xm4YTB5Zn8zu6/m3gqCKR8yKlwu1w2iVLgZHbqGKRTw8yw2J37SSYbS5NPnrsQXhusr7cYWucbZzudZk/d77nN0uVn5gga3d7a6HBFgb6I6ye/EpAhR1E88tGfUU7GQm1V02DzxvV7QoXPamsa+98gEy6NR4oJyoIlSvjbp/UX+++7teLKsjXEsSSKle1kcwbemgHAvDOwKGJ08YUyO48uUDF0PHPm8k5J7j5bN7fwPnvu0ucVhWBp+A1wvJ8/1E1Xt0WESjZrfix541WYL0lwQuA4VLz6eQzW7hCNbSf+P2s9n4Ie/dUMZGgWIVTwfLRCaswpy1S4WxRItbq8eLVKBju2414p+peuLEji2aGPdIuH1E2HSfRPSF7RBQD2WBGxCNm2FtLQD3T/adOG+Umaba/kxWxMjBddiTb71+jA/yqypvsh4rdw0En/prpj0OoekDZMGYzQWU+hiwqYnQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(82310400026)(36860700016)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(56012099006)(261022113327099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KIUJF5x7ZvL892gR2380LicNvFb15sXEELuPZvF3rcqtI65DdU9kSTPjYpSZR9VZKngl5cyV28cJsIqaUz0jMdrb2ex0A6Cm+96/4FI6JtD5pLNOKH9Jlmwb6wHqb/OmUFU377nQlSvrICRQfZQ1n6uoUmM519rtWyZkVBSlyhjIPtIoqVicK0S1n11hv15PzMlSqrx8/AadxTWACuOakUgZR34uMazxJDr0B1aVkiC3URCG1cafhk4g8U8yKEUmeN2qIpIUXP4XusG8Drb9T44nZfGgIGiKsxGwTbCzMLQpi7hcWGJhZPhFv0FTmeCE/+7XAuZTbjcGAEU7K3UkZ7L76asjqReF9NJlrAPcccvB7oKu13SUKsLebsajc0rCh4g6zKaXN/0sWhmoUlpFuinkfSjVkOlEauTmONYMuvnW2oBtx5vefHsfECRRfaJO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 06:10:16.4055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da3637c4-c940-4227-eba9-08df3bcca0ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381

From: Zhi Wang <zhiw@nvidia.com>

Add a fwctl driver that provides an interface for userspace to issue
GMC API commands to the GSP. Userspace supplies the command ID and
payload while the transport headers remain internal to the kernel.

Allow the seven vGPU management commands in the configuration scope.
Reject all other commands and scopes.

zhiw: Adapt to the GPU-owned command queue and its GMC transaction API.
Use the existing vGPU firmware module for command constants and register
fwctl after GPU and auxiliary-device initialization.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/Kconfig      |   2 +
 drivers/gpu/nova-core/driver.rs    |  27 +++++++
 drivers/gpu/nova-core/fwctl.rs     | 119 +++++++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs |   2 +
 drivers/gpu/nova-core/vgpu.rs      |  10 +++
 drivers/gpu/nova-core/vgpu/fw.rs   |  18 ++++-
 include/uapi/fwctl/fwctl.h         |   1 +
 include/uapi/fwctl/nova-core.h     |  34 +++++++++
 rust/kernel/fwctl.rs               |   2 +
 rust/uapi/uapi_helper.h            |   2 +
 10 files changed, 215 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/nova-core/fwctl.rs
 create mode 100644 include/uapi/fwctl/nova-core.h

diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
index 2e11e46c99c7..3431cac7f3ba 100644
--- a/drivers/gpu/nova-core/Kconfig
+++ b/drivers/gpu/nova-core/Kconfig
@@ -4,8 +4,10 @@ config NOVA_CORE
 	depends on PCI
 	depends on RUST
 	depends on !CPU_BIG_ENDIAN
+	depends on FWCTL=y
 	select AUXILIARY_BUS
 	select GPU_BUDDY
+	select RUST_FWCTL_ABSTRACTIONS
 	select RUST_FW_LOADER_ABSTRACTIONS
 	default n
 	help
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 560a70c4f5a7..7ad93eca485b 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -6,6 +6,7 @@
         Bound,
         Core, //
     },
+    fwctl,
     io::resource,
     pci,
     pci::{
@@ -24,6 +25,10 @@
 
 use crate::{
     api::NovaCoreApi,
+    fwctl::{
+        NovaCoreFwCtl,
+        NovaCoreFwCtlData, //
+    },
     gpu::Gpu, //
 };
 
@@ -34,6 +39,8 @@
 pub(crate) struct NovaCore<'bound> {
     #[allow(clippy::type_complexity)]
     _reg: auxiliary::Registration<'bound, ForLt!(NovaCoreApi<'_>)>,
+    /// Unregisters fwctl and drains its callbacks before GPU resources are dropped.
+    _fwctl: fwctl::Registration<'bound, NovaCoreFwCtl>,
     #[pin]
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
@@ -168,6 +175,26 @@ fn probe<'bound>(
                     )?
                 }
             },
+
+            _fwctl: {
+                // SAFETY: `gpu` is initialized at its final pinned address. `_fwctl` is
+                // declared before `gpu`, so unregistering fwctl drains callbacks before the
+                // GPU is dropped. Initializer cleanup also unregisters it first, since this
+                // registration is initialized last. The private registration is never leaked.
+                let gpu = unsafe { &*core::ptr::from_ref(gpu.as_ref().get_ref()) };
+                let fwctl_dev = fwctl::Device::<NovaCoreFwCtl>::new(pdev.as_ref())?;
+
+                // SAFETY: The device is newly allocated, unregistered, and parented to `pdev`.
+                // The registration borrows the pinned GPU as described above, and its Drop
+                // runs before the parent device unbinds.
+                unsafe {
+                    fwctl::Registration::new(
+                        pdev.as_ref(),
+                        &fwctl_dev,
+                        NovaCoreFwCtlData::new(gpu.cmdq()),
+                    )?
+                }
+            },
         })
     }
 }
diff --git a/drivers/gpu/nova-core/fwctl.rs b/drivers/gpu/nova-core/fwctl.rs
new file mode 100644
index 000000000000..f1f750e86e4f
--- /dev/null
+++ b/drivers/gpu/nova-core/fwctl.rs
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! fwctl driver for nova-core GMC API pass-through.
+
+use kernel::{
+    fwctl,
+    fwctl::{
+        DeviceType,
+        FwRpcResponse,
+        RpcScope, //
+    },
+    prelude::*, //
+};
+
+use crate::{
+    gsp::cmdq::Cmdq,
+    vgpu::{
+        GMCAPI_CMD_ADD_VGPU_TYPE,
+        GMCAPI_CMD_ASSIGN_VGPU_TYPE,
+        GMCAPI_CMD_DEASSIGN_VGPU_TYPE,
+        GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE,
+        GMCAPI_CMD_QUERY_CREATABLE_VGPU_TYPES,
+        GMCAPI_CMD_QUERY_SUPPORTED_VGPU_TYPES,
+        GMCAPI_CMD_QUERY_VGPU_PROPERTIES, //
+    },
+};
+
+/// Resources used by fwctl callbacks while the GPU is bound.
+#[pin_data]
+pub(crate) struct NovaCoreFwCtlData<'a> {
+    cmdq: &'a Cmdq<'a>,
+}
+
+impl<'a> NovaCoreFwCtlData<'a> {
+    pub(crate) fn new(cmdq: &'a Cmdq<'a>) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self { cmdq })
+    }
+}
+
+/// Per-file fwctl context for nova-core.
+#[pin_data]
+pub(crate) struct NovaCoreFwCtl {}
+
+impl fwctl::Operations for NovaCoreFwCtl {
+    type RegistrationData<'a> = NovaCoreFwCtlData<'a>;
+
+    const DEVICE_TYPE: DeviceType = DeviceType::NovaCore;
+
+    fn open<'a>(
+        _device: &fwctl::Device<Self>,
+        _reg_data: &Self::RegistrationData<'a>,
+    ) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {})
+    }
+
+    fn fw_rpc<'a>(
+        _this: Pin<&Self>,
+        _device: &fwctl::Device<Self>,
+        reg_data: &Self::RegistrationData<'a>,
+        scope: RpcScope,
+        rpc_buf: &mut [u8],
+        _max_output_len: usize,
+    ) -> Result<FwRpcResponse, Error> {
+        if rpc_buf.len() < RPC_HEADER_SIZE {
+            return Err(EINVAL);
+        }
+
+        let (header, payload) = rpc_buf.split_at(RPC_HEADER_SIZE);
+        let command_id = u32::from_le_bytes(header[..4].try_into().map_err(|_| EINVAL)?);
+        let reserved = u32::from_le_bytes(header[4..].try_into().map_err(|_| EINVAL)?);
+
+        if reserved != 0 {
+            return Err(EINVAL);
+        }
+        if !is_command_permitted(scope, command_id) {
+            return Err(EPERM);
+        }
+
+        let response =
+            reg_data
+                .cmdq
+                .send_gmc_and_receive(command_id, payload, GSP_GMC_MAX_RESPONSE_SIZE)?;
+        if response.status != 0 {
+            return Err(EIO);
+        }
+
+        let response_len = RPC_HEADER_SIZE
+            .checked_add(response.payload.len())
+            .ok_or(EOVERFLOW)?;
+        let mut out = KVVec::with_capacity(response_len, GFP_KERNEL)?;
+        out.extend_from_slice(&command_id.to_le_bytes(), GFP_KERNEL)?;
+        out.extend_from_slice(&0u32.to_le_bytes(), GFP_KERNEL)?;
+        out.extend_from_slice(&response.payload, GFP_KERNEL)?;
+
+        Ok(FwRpcResponse::NewBuffer(out))
+    }
+}
+
+/// Size of `fwctl_rpc_nova_core` (`command_id` plus `reserved`).
+const RPC_HEADER_SIZE: usize = 8;
+
+const GSP_GMC_MAX_RESPONSE_SIZE: u32 = 16_384;
+
+/// Returns whether `command_id` may be issued under `scope`.
+fn is_command_permitted(scope: RpcScope, command_id: u32) -> bool {
+    match scope {
+        RpcScope::Configuration => matches!(
+            command_id,
+            GMCAPI_CMD_ADD_VGPU_TYPE
+                | GMCAPI_CMD_QUERY_SUPPORTED_VGPU_TYPES
+                | GMCAPI_CMD_QUERY_CREATABLE_VGPU_TYPES
+                | GMCAPI_CMD_ASSIGN_VGPU_TYPE
+                | GMCAPI_CMD_DEASSIGN_VGPU_TYPE
+                | GMCAPI_CMD_QUERY_VGPU_PROPERTIES
+                | GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE
+        ),
+        _ => false,
+    }
+}
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index f7753d63c432..5f09b69f3b54 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -16,6 +16,7 @@
 mod fb;
 mod firmware;
 mod fsp;
+mod fwctl;
 mod gpu;
 mod gsp;
 mod irq;
@@ -83,6 +84,7 @@ fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
     description: "Nova Core GPU driver",
     license: "GPL v2",
     firmware: [],
+    imports_ns: ["FWCTL"],
 }
 
 kernel::module_firmware!(firmware::ModInfoBuilder);
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index 47a27236a086..f198fa218297 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -46,6 +46,16 @@
 pub(crate) mod vgpu_api;
 mod vram;
 
+pub(crate) use fw::{
+    GMCAPI_CMD_ADD_VGPU_TYPE,
+    GMCAPI_CMD_ASSIGN_VGPU_TYPE,
+    GMCAPI_CMD_DEASSIGN_VGPU_TYPE,
+    GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE,
+    GMCAPI_CMD_QUERY_CREATABLE_VGPU_TYPES,
+    GMCAPI_CMD_QUERY_SUPPORTED_VGPU_TYPES,
+    GMCAPI_CMD_QUERY_VGPU_PROPERTIES, //
+};
+
 /// vGPU state detected during GPU construction.
 #[derive(Debug, Clone, Copy)]
 pub(crate) enum VgpuState {
diff --git a/drivers/gpu/nova-core/vgpu/fw.rs b/drivers/gpu/nova-core/vgpu/fw.rs
index 795ce4855586..8f0fb26da86b 100644
--- a/drivers/gpu/nova-core/vgpu/fw.rs
+++ b/drivers/gpu/nova-core/vgpu/fw.rs
@@ -31,10 +31,24 @@
 
 pub(super) use commands::RpcMessage;
 
-pub(super) const GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE: u32 =
+pub(crate) const GMCAPI_CMD_ADD_VGPU_TYPE: u32 = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_ADD_VGPU_TYPE;
+
+pub(crate) const GMCAPI_CMD_QUERY_SUPPORTED_VGPU_TYPES: u32 =
+    bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_SUPPORTED_VGPU_TYPES;
+
+pub(crate) const GMCAPI_CMD_QUERY_CREATABLE_VGPU_TYPES: u32 =
+    bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_CREATABLE_VGPU_TYPES;
+
+pub(crate) const GMCAPI_CMD_ASSIGN_VGPU_TYPE: u32 =
+    bindings::GMCAPI_COMMANDS_GMCAPI_CMD_ASSIGN_VGPU_TYPE;
+
+pub(crate) const GMCAPI_CMD_DEASSIGN_VGPU_TYPE: u32 =
+    bindings::GMCAPI_COMMANDS_GMCAPI_CMD_DEASSIGN_VGPU_TYPE;
+
+pub(crate) const GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE: u32 =
     bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE;
 
-pub(super) const GMCAPI_CMD_QUERY_VGPU_PROPERTIES: u32 =
+pub(crate) const GMCAPI_CMD_QUERY_VGPU_PROPERTIES: u32 =
     bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_VGPU_PROPERTIES;
 
 pub(super) const GMCAPI_CMD_BOOTLOAD_GSP_VGPU_PLUGIN_TASK: u32 =
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 2d6d4049c205..0e336cbbeb6b 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -46,6 +46,7 @@ enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_CXL = 2,
 	FWCTL_DEVICE_TYPE_BNXT = 3,
 	FWCTL_DEVICE_TYPE_PDS = 4,
+	FWCTL_DEVICE_TYPE_NOVA_CORE = 8,
 };
 
 /**
diff --git a/include/uapi/fwctl/nova-core.h b/include/uapi/fwctl/nova-core.h
new file mode 100644
index 000000000000..c11619660058
--- /dev/null
+++ b/include/uapi/fwctl/nova-core.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2025-2026, NVIDIA CORPORATION & AFFILIATES
+ *
+ * NVIDIA nova-core fwctl interface. All fwctl traffic uses the GMC API
+ * transport. User-space supplies a command_id and optional payload; the
+ * kernel constructs the GMC transport headers, validates the command_id
+ * against the permitted set for the requested scope, and returns only the
+ * response payload.
+ *
+ * The device_type for this file is FWCTL_DEVICE_TYPE_NOVA_CORE.
+ */
+#ifndef _UAPI_FWCTL_NOVA_CORE_H
+#define _UAPI_FWCTL_NOVA_CORE_H
+
+#include <linux/types.h>
+
+/**
+ * struct fwctl_rpc_nova_core - ioctl(FWCTL_RPC) in/out buffer format
+ * @command_id: GMC API command identifier (from GMCAPI_COMMANDS).
+ * @reserved: Must be zero.
+ *
+ * The request buffer passed to FWCTL_RPC begins with this header,
+ * followed by the command-specific payload bytes (if any).
+ *
+ * The response buffer returned by FWCTL_RPC begins with this same
+ * header (echoing the command_id), followed by the response payload.
+ */
+struct fwctl_rpc_nova_core {
+	__u32 command_id;
+	__u32 reserved;
+};
+
+#endif
diff --git a/rust/kernel/fwctl.rs b/rust/kernel/fwctl.rs
index b7778e4d5ee0..92e1cdf6da2d 100644
--- a/rust/kernel/fwctl.rs
+++ b/rust/kernel/fwctl.rs
@@ -44,6 +44,8 @@ pub enum DeviceType {
     Pds = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_PDS,
     /// Broadcom NetXtreme (bnxt) device.
     Bnxt = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_BNXT,
+    /// NVIDIA nova-core GPU device.
+    NovaCore = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_NOVA_CORE,
 }
 
 /// Scope of access for an RPC request.
diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
index 44fb6203c0ad..428a756a9b5c 100644
--- a/rust/uapi/uapi_helper.h
+++ b/rust/uapi/uapi_helper.h
@@ -11,6 +11,8 @@
 #include <uapi/drm/drm.h>
 #include <uapi/drm/nova_drm.h>
 #include <uapi/drm/panthor_drm.h>
+#include <uapi/fwctl/fwctl.h>
+#include <uapi/fwctl/nova-core.h>
 #include <uapi/linux/android/binder.h>
 #include <uapi/linux/android/binder_netlink.h>
 #include <uapi/linux/ioctl.h>
-- 
2.53.0

