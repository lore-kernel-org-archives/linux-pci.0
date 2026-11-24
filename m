Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795531420;
	b=Fk6XCludc3UPbZskXdekFGd1TsMCYRA71MXqkQQMyXN4YYwVrAWiIIObtRXhc3HKid/e
	 /4jOI3jyOTKCcSeGU+0lKBrjEXZydc/38KRdRg+wQn+9d8AI5RhwV0zX/oOA351DoV6uM
	 S8fePG2vQtfqERFQMdBz+G6juDJhkf68aihLywnGcbzlrOO5+myy46S7jk5oGippIMTGW
	 jL8R9HF4UBlU3CQlDw5AiTABdVwoYU7mT7NzkVP4fG1AB4G/LBih6DsqVvMUR0ch53kt3
	 0acO1aAXa9+ENxU5x/K95G2jYTdXjaqZ5DjQDiIqp8IYMKVIXC24GqQ2AunOXVEvz1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531420;
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
	bh=UQZEbSY5e60+r1TJ29snpzZDWj+f2twQgc2H3gTjF1M=;
	b=ZsD/ej+gKx3dFxbjt+ULhVaaTj0Ea+vlibbUO6nycpCPrnGpUPAdrAJxZQNvVd4IYcf7
	 ssIkv7Ion2Fx3ubjrBsk0Dz4VJdeTgNMb+o6j70TAfNjlgIgLpkR5PsmwZQEgkbrBz+i6
	 6VUzC8vXPIvWJrFIY8kIPUly5nQ+/Fhsex33WFHqQxonnKL/8GJDdXADts3Q0lLqO8TFF
	 iTug4IImjyldQQ1mIXLrwXmZ71ebvTK1IKk18zsqEsd6UdedoTQzUhZjRq1AkOPFluKak
	 nkVkdFj55uZxeGx2lejZq0r1lzN4sb8DT+U54xyehxBatS7BsT8n+87NDEtFsA09ynQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EoeTJt40;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.70
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCCB606A33E;
	Tue, 24 Nov 2026 14:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCCCB606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EoeTJt40
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SANo0HKf42KTROKgObdZchiPcUpzJ8Q9WehVHdnPAQIxhDBT5Y7M/7V5Lg2Y96QeeQ+wfguwltl4nLG7jTPJhcQ1yMxTf2/feW2vCWXi6syA3Og/Yk9y1EkQehmXgbYFfLh6983t5Kyyje3DzWNI8wVqvTW2lGYpLFWrUPkE1ThgCpWq8NXt7qNiOVyS1ehBgwMuPjZqbfvo5b/0h4ivGWbYEQRfiP096/0RlJvICJO8ncdzNz0QQW5BlBIDMb8M4C4u9ZEA6QNQMizoNQwyakTRNR30+Yp8RUXdlefkgQoLih7XDwlZCl5lgB894Q2J7fE8UgSMVmmXJKx0hLszqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQZEbSY5e60+r1TJ29snpzZDWj+f2twQgc2H3gTjF1M=;
 b=ya/jdqQGYmgPxfjB/uSZaTSDBuREu/nfCVhflB9VCR/x9tD7gTUOlOKmLWHTkNUGgbGfbjKQ8r6SmpUX4j4sWQhYPSu59M7OGvDsbHAbRiU1r4Lqck0vODDwHAWDIyeOhO0kwN4r1jPqxG/zj9qco4183ltpHNF1IWTTdZZ6B2Ho2X8Jb2omYHUQRZCFIcWo0GfeRcBGimuH8cJ1pWRQlN8zpblMM55p0zaEN3BrNxPaIACOo3fwjU06G1XEqCXOjc/Ty/q5+LZdl9z33Ldi7mhRlmPz9klRxxiRsLGGH1Pgom9qJJbM77uM++TOUju565E/YLOmirMYRid7Ve0L1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQZEbSY5e60+r1TJ29snpzZDWj+f2twQgc2H3gTjF1M=;
 b=EoeTJt40iGuqSIZMAcU5JGz37SlYxVer4VpIOd0r7RtAB3jKS/vzM9+AG+tGSZB+kzH/QKAKnhlZvrP9M2fIwTr3H0zu2aGI31TdycDXagv7ehA1x1LKsr7L1Qpr4nIvGjmVYYf+t5F058T8+I3T1YKybHIycnl3hcGl9WihAkHwsBAL96Ouq4MXJgZVkThpOb9aMHFwa2GoqeDHyu7hLprHA02PwT4ayOBFl5yU2inWEhC/1zYU1OW369XUZWxcZefCte7bfGiKZWQCIiIabNBykP5uNgKtMjJJmfrRhswBrQAHTwRYHxS2jE47Pk2oSYcWd1gHxT6Nh3WuWCbFLw==
Received: from CY8PR11CA0017.namprd11.prod.outlook.com (2603:10b6:930:48::26)
 by IA3PR12MB880420.namprd12.prod.outlook.com (2603:10b6:208:628::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 14:43:32 +0000
Received: from CY8PEPF00000050.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::7a) by CY8PR11CA0017.outlook.office365.com
 (2603:10b6:930:48::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:43:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY8PEPF00000050.mail.protection.outlook.com (10.167.247.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:43:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:43:07 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:42:53 -0800
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
Subject: [PATCH v3 1/1] gpu: nova-core: add fwctl driver for firmware control interface
Date: Tue, 24 Nov 2026 20:12:04 +0530
Message-ID: <20261124144204.19072-2-alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124144204.19072-1-alkumar@nvidia.com>
References: <20261124144204.19072-1-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY8PEPF00000050:EE_|IA3PR12MB880420:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db9c42b-bf61-4f29-615d-08df4a394fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|23010399003|6133799003|18002099003|22082099003|3023799007|13003099007|11063799006|260925021311599003|260925021911599003|260925022911599003|261026121527099003|261102123227099003|56012099006|261028144727099003|261022113327099003|261009223027099003|261021121427099003|261022075727099003|261022105027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	dv0/mSD6QOiElEF+ZB4otk0nO0AbsI2peGfIQ+C1YVuS+LCNNejQjUXm58up87Trrwt+6UMBMDVd4LqyKlbAhoYwoQsL4b2ZFZJg004RdUBuX3iiiVG9PbRt/nPJTgvnKKng/pDsq3WFKcQHcdbWutyZkc3Wg2UpGuyguCG1vApJM+NQQMBuggpNZ6crIdQ6/WSLg41bOJPSMSnoCRPYJmB9oIYdsYXYUa6eFHRgGouI0wVcwrG2ub1M+TW5jO6CPwoM1l4KedzOzgbpQDk/XX80hjQGGkCQUjShoEf59rZnXiWKHZ/N0WZqvuVhT4gT7IJPgSkergep+BXVPPwTpIUaGdfJ7AJEfNkhwnhAZjbq+HUA8O4489mDe+ggpCJNl/wYOAgwV8P72lMwxg3UtjUiHKI01bB2JTsSykqZtxul4ma4KMfn4S6w+tegm+Ko8TF8rEjIeAEOP7Pgbd+YPPZDAg43iXhZ6mO1NBOdi7vmb+OJjiGFyKPvrPzdtntig9QaMcPqRLUdgsve6uCHy/vUHz8/KUfYqwhs1XirgnXsoyXA27peSmU8EmE8xayYkY3dj9Zs2yx4L49YMBw1zkMAbjI9mG9hqAiLjXsL99AWfa9zDNGi+IITnxRJAEHTSBsCV3wy045Rw4cHYv6RZk3Kj/D1lpnX0AOVONEx/1evV2fhPC7yLdGj6qKY7RGyPPPAtxv0q9Z6HTSFxnXihA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(13003099007)(11063799006)(260925021311599003)(260925021911599003)(260925022911599003)(261026121527099003)(261102123227099003)(56012099006)(261028144727099003)(261022113327099003)(261009223027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vnLslwRFTRbOvbRXVnf0icIs5mbnH4qhLV5hsFoF6pR8pj1KtkF1vvyzVBpm9fLbGkOkzBMwILhoRjuwzZSjE4FVFKDp3UxdP6nXCJZ0anTzvc0rlIMD1k4t7ezGYKi8X+Uu1VnVRKaVoFZnjvKDVCtk4Dn14XAneNov11htqJs7bwGWGSX8OqGudlhPpaapTk9mR7Qp7SJOGh1mTkxxfD5BOMcK5iI5S8pNCC1ig5brSIyvW9r+fdr7vmR2jQWX9e6ByjwESSAjjbO6rpcVgvT6Q5EH7JKL0ZrL63/HGhBh+Kr7L2JoiW5vZQ8dPeRV0qjhrHm0vmOGjlNo7ARj9NiyPxCcJEVnoLdNnWFY45pnitEK/zYr/YfaZPNu5nMrteqd8ZvqhL5cBfsLEilPwkQp3z3p6DsZqEPmwsyQK/wjRB9IlaYk8qGg+cRMwdO6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:43:32.3279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db9c42b-bf61-4f29-615d-08df4a394fe5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000050.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB880420

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
 MAINTAINERS                        |   1 +
 drivers/gpu/nova-core/Kconfig      |   2 +
 drivers/gpu/nova-core/driver.rs    |  23 +++++
 drivers/gpu/nova-core/fwctl.rs     | 160 +++++++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs    |   5 +
 drivers/gpu/nova-core/nova_core.rs |   2 +
 include/uapi/fwctl/fwctl.h         |   1 +
 include/uapi/fwctl/nova-core.h     |  34 ++++++
 rust/kernel/fwctl.rs               |   2 +
 rust/uapi/uapi_helper.h            |   2 +
 10 files changed, 232 insertions(+)
 create mode 100644 drivers/gpu/nova-core/fwctl.rs
 create mode 100644 include/uapi/fwctl/nova-core.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..5d025dea0397 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8583,6 +8583,7 @@ C:	irc://irc.oftc.net/nouveau
 T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git drm-rust-next
 F:	Documentation/gpu/nova/
 F:	drivers/gpu/nova-core/
+F:	include/uapi/fwctl/nova-core.h
 
 DRM DRIVER FOR NVIDIA GPUS [RUST]
 M:	Danilo Krummrich <dakr@kernel.org>
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
index d6bc972d47c7..6a5826a36ddd 100644
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
 
@@ -35,6 +40,9 @@ pub(crate) struct NovaCore<'bound> {
     #[allow(clippy::type_complexity)]
     #[uses('gpu: invariant)]
     _reg: auxiliary::Registration<'gpu, ForLt!(NovaCoreApi<'_>)>,
+    /// Unregisters fwctl and drains its callbacks before GPU resources are dropped.
+    #[uses('gpu: invariant)]
+    _fwctl: fwctl::Registration<'gpu, NovaCoreFwCtl>,
     #[pin]
     #[uses('bar1)]
     pub(crate) gpu: Gpu<'bar>,
@@ -151,6 +159,21 @@ fn probe<'bound>(
                     NovaCoreApi::new(pdev, gpu),
                 )?
             },
+
+            _fwctl: {
+                let fwctl_dev = fwctl::Device::<NovaCoreFwCtl>::new(pdev.as_ref())?;
+
+                // SAFETY: The device is newly allocated, unregistered, and parented to `pdev`.
+                // The self-referential borrow keeps `gpu` alive until fwctl is unregistered
+                // and its callbacks are drained. `NovaCore` is dropped before `pdev` unbinds.
+                unsafe {
+                    fwctl::Registration::new(
+                        pdev.as_ref(),
+                        &fwctl_dev,
+                        NovaCoreFwCtlData::new(gpu.get_ref().cmdq()),
+                    )?
+                }
+            },
         })
     }
 }
diff --git a/drivers/gpu/nova-core/fwctl.rs b/drivers/gpu/nova-core/fwctl.rs
new file mode 100644
index 000000000000..62513a5a4343
--- /dev/null
+++ b/drivers/gpu/nova-core/fwctl.rs
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! fwctl driver for nova-core GMC API pass-through.
+
+use core::convert::Infallible;
+
+use kernel::{
+    fwctl::{
+        self,
+        DeviceType,
+        FwRpcResponse,
+        RpcScope, //
+    },
+    prelude::*, //
+};
+
+use crate::gsp::{
+    cmdq::{
+        gmc::{
+            CommandPayload,
+            CommandToGsp,
+            MessageFromGsp,
+            MessagePayload, //
+        },
+        Cmdq,
+    },
+    GmcCommandId,
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
+        if !matches!(scope, RpcScope::Configuration) {
+            return Err(EPERM);
+        }
+
+        let response = send_command(reg_data.cmdq, command_id, payload)?;
+        let response_len = RPC_HEADER_SIZE
+            .checked_add(response.len())
+            .ok_or(EOVERFLOW)?;
+        let mut out = KVVec::with_capacity(response_len, GFP_KERNEL)?;
+        out.extend_from_slice(&command_id.to_le_bytes(), GFP_KERNEL)?;
+        out.extend_from_slice(&0u32.to_le_bytes(), GFP_KERNEL)?;
+        out.extend_from_slice(&response, GFP_KERNEL)?;
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
+/// Firmware response bytes copied out before the message queue slot is consumed.
+struct Response(KVec<u8>);
+
+impl MessageFromGsp for Response {
+    type InitError = Error;
+
+    fn read(payload: &mut MessagePayload<'_>) -> Result<Self> {
+        payload.flush_into_kvec(GFP_KERNEL).map(Self)
+    }
+}
+
+// Define typed requests and the exact command allowlist together.
+macro_rules! fwctl_commands {
+    ($($command:ident),+ $(,)?) => {
+        $(
+            struct $command<'a>(&'a [u8]);
+
+            impl CommandToGsp for $command<'_> {
+                const COMMAND: GmcCommandId = GmcCommandId::$command;
+                type Command = ();
+                type Reply = Response;
+                const MAX_REPLY_SIZE: u32 = GSP_GMC_MAX_RESPONSE_SIZE;
+                type InitError = Infallible;
+
+                fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+                    pin_init::init_zeroed()
+                }
+
+                fn variable_payload_len(&self) -> usize {
+                    self.0.len()
+                }
+
+                fn init_variable_payload(&self, dst: &mut CommandPayload<'_>) -> Result {
+                    dst.write_all(self.0)
+                }
+            }
+        )+
+
+        fn send_command(cmdq: &Cmdq<'_>, command_id: u32, payload: &[u8]) -> Result<KVec<u8>> {
+            // CAST: `GmcCommandId` is `repr(u32)`, so these casts are lossless.
+            match command_id {
+                $(
+                    id if id == GmcCommandId::$command as u32 => cmdq
+                        .send_gmc_command($command(payload), |_| Ok(()))?
+                        .map(|response| response.0)
+                        .map_err(|_| EIO),
+                )+
+                _ => Err(EPERM),
+            }
+        }
+    };
+}
+
+fwctl_commands! {
+    AddVgpuType,
+    QuerySupportedVgpuTypes,
+    QueryCreatableVgpuTypes,
+    AssignVgpuType,
+    DeassignVgpuType,
+    QueryVgpuProperties,
+    QueryAssignedVfVgpuType,
+}
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 5158f0e7c12c..63ed031d41d6 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -720,6 +720,11 @@ pub(crate) enum GmcCommandId with TryFrom<Bounded<u32, 24>> {
         ExecGenericBootloader = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_EXEC_GENERIC_BOOTLOADER,
         ExecHsBinary = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_EXEC_HS_BINARY,
         GspSuspend = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_GSP_SUSPEND,
+        AddVgpuType = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_ADD_VGPU_TYPE,
+        QuerySupportedVgpuTypes = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_SUPPORTED_VGPU_TYPES,
+        QueryCreatableVgpuTypes = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_CREATABLE_VGPU_TYPES,
+        AssignVgpuType = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_ASSIGN_VGPU_TYPE,
+        DeassignVgpuType = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_DEASSIGN_VGPU_TYPE,
         QueryVgpuProperties = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_VGPU_PROPERTIES,
         QueryAssignedVfVgpuType = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE,
         BootloadGspVgpuPluginTask =
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 418571724543..b2cb11c0a4d2 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -17,6 +17,7 @@
 mod fb;
 mod firmware;
 mod fsp;
+mod fwctl;
 mod gpu;
 mod gsp;
 mod irq;
@@ -98,6 +99,7 @@ fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
     description: "Nova Core GPU driver",
     license: "GPL v2",
     firmware: [],
+    imports_ns: ["FWCTL"],
     params: {
         gsp_keep_logs: bool {
             default: false,
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

