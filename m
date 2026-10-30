Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380398;
	b=0b/b1YBT4r1G9HwbHDG+10OyL43vbzXNg6RfNvbquhNhZhrxvbGkDkBim71duy+16I6G
	 tFtd79k3pvDd8Ni9blXneyqoda0l8dm2Uef9sMz7CAXpK9sZVJlHdIWOT6C33ntxWCI0D
	 l0YozYoEKSd1R6nEHtfQk+TLEqlJ2mCVJAbD8l2cYupD3hg43SSltkEybRpq3kbb/oqfo
	 Xh2neno06aYGg/TdUngQ+HsmfjuvRCA3TePLOsEdW7sGe88nqXINA0Dn7Kn/PMN6UHWdm
	 HM9oFbNN8iO147dnRsj9wZdsaFKMInkRPN70L+/zIBztIKNoTLaT4WgPpeT2aH88GkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380398;
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
	bh=bSUJV0DC77OeY6fcyxiVfCIVjH8R4KusIzPWMFAfs/U=;
	b=0CZfqvqkGW8s2tITGC2ydGeisTRakBPN9nd9/eCn7IxngHq6eX08vpOsGDPBr3mq6h/R
	 SDLbPpLEiWl7gB6KGtBWfxcqp7s3is9YcZvlUqRmX2jpTqwrPKXPYIo/bJWbGFE6ZjkSr
	 DtmhFFk86gc5RJKD2hyJE4/YZtnb3Yv15mv8pMG6AshsxmWIfJwVuB3E32OXo2eaO6Ifq
	 gvuus+yR26KZswGbWNBk5n1KjxyQbZz72VIvmMI0tkesxXRlH2T/lu4H4rcWQLeM0Xlwu
	 E8vIV4+T3+N6gmTXgxXXgqfjVT4SaM14kj+1yE+8XHrytH0326MO3qd9AcfsXvRM5Cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ITxyyNeF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.62
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A26606A322;
	Fri, 30 Oct 2026 17:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50A26606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ITxyyNeF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iA/xM/0T5nWXGQ6PeRuC9eU7rkRaH5P/LbtDYdV64zlhZOsZmcZhPDXRl1kMwYJoEUCMdk6YepnveChohBfow4LWPs9PsVIztiIgSTusdw58eqb8SrRlHP0TxjnuCpooNL2LtdjCEMU5NiqkUYZGshHp2Am4CkiqEy4tp6ZxGLBi0YzMqIPqsqkfBSNk1WlK1TdPquBa35gEhlxZstPfnxtULki1PtwkL9VNDgm2a4fy067ii9Wob+rgPdNVv9mPKOwEmizaUC4U6tXzgXHcFaA6tcP2lP9zbhD9+K7/Ta3JMRFJ/CkHib5r4+g70dq+xc7cH4Ndu3+jVdUQ7YgH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSUJV0DC77OeY6fcyxiVfCIVjH8R4KusIzPWMFAfs/U=;
 b=IxaQYSr7Ru31hOWxnVSb07gkGwsPIQAqPPIQDS5sO5lG1ezT/hvcRgslinPYms7UUiNC/MR5Pqp//UNENWqqMfSXc25SxznT+3bAz51ACxX1PPW//76eqtMjUZurx4nAoQyGUbUL4IlPEyTfuvHEhA8EZjq6Bjvckq9ATgsJzwCj070Usyw1ExUz8PS9kJc+XZJz1kFux5HbVgJz4qPS1qfx4d1p08TOQSr6ZHGzR7+r0aApPYld/k8oWSVRAe0PfGMH0y5iOO0eQwfa0/6kRt0eL4rU0FfLOK73eSC9kWsYlYa50Sx5OPOSTeHT73ZOhtZrBtIqxhLhHJvm1m8xsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSUJV0DC77OeY6fcyxiVfCIVjH8R4KusIzPWMFAfs/U=;
 b=ITxyyNeF8dFqiSMktnOJJ7MMYLBACw/5VISboP3jmlXwIPEb6bNKx+GzHwHlNAXXRha19SWmupUgB9i8nUuZ4B3NHxpEmKgRsrl+MyMJWx40tv6lh5bmTp68sWHc0UTaqNRUt88luh51sFD5aJsstRbx9J01zNJ2aborA6skopldDfSLhRG5Rg+XyBBP9M0Vwkksir+KKYpe1jImFCZKkGC6y6c2sbXr36TfuVJV1w6Glm/eOavsvtKJmxIzT4dlm/FnqPwxfZ8TcwJkxeDkvVTDemATkQgrdWw0sYZGqGffGNG9jqEea5OO0nsL1jyQW64UUBRLMSpp01RfSa5QLw==
Received: from DM6PR05CA0056.namprd05.prod.outlook.com (2603:10b6:5:335::25)
 by DS8PR12MB315725.namprd12.prod.outlook.com (2603:10b6:8:447::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 17:13:11 +0000
Received: from DS2PEPF00006E21.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::3b) by DM6PR05CA0056.outlook.office365.com
 (2603:10b6:5:335::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5 via Frontend Transport; Fri, 30
 Oct 2026 17:13:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00006E21.mail.protection.outlook.com (10.167.23.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 17:13:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:12:50 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:12:47 -0700
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
Subject: [PATCH v5 1/9] rust: pci: add internal SR-IOV enable and disable helpers
Date: Fri, 30 Oct 2026 10:12:19 -0700
Message-ID: <20261030171230.196717-2-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E21:EE_|DS8PR12MB315725:EE_
X-MS-Office365-Filtering-Correlation-Id: d84ac46c-8c3f-46a7-30a0-08df36a9138f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|261022115727099003|261022105027099003|261022113327099003|261022075727099003|10067099003|261021123027099003|261021121427099003|261009223027099003|261028144727099003|261026140227099003|261021130227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	NUyIJrbR/lCTplPq01HSbWktis9/HKvKjrmwQJw8Od4HpysBdNpZK5dhek14Jj/6z3puv0Vlb+qmMZJUsSzGkGxTrFjWFt3uNzCnJ7331zxwJPZanYqH1gtV3SU7HHUBuFSnls58b4E3NrJnd9LOLbaFhqa5rqCAQcHzygSTMAmQDDReNT1HUi7/VTBJGCmkHQOelxdYbtOKmoeOEHv+R8BiLqt4Qep8boWnOXfHz/zx6mbi9dI5k/+Kye833KxjlcnavhIa4eG8rLviXhzaxQVsRVAuuzsuTjTuDjqcerZiTIvznY9yJ7pmnIGynY9AiLetyvddxchNtRfkVfbidFHSJpYDuz+A4TCcUa9zxzyHzn9nvhChm78/M9RL7blPlHdLP7pe/XqHYzQSz3pAp1iFHENY4gYii9q8Kf2vsvfnecWtbL81cal5pR3oVe2971Zry9vSDVNWFofrWk+CwZvqBcf3XU8XHRh5l/yN+iV8jdu2JsRvUt73rfY44fPXDdxElrR6kRjkPaaVgvnmHQFFIVW4NGUYznOgrvLmXle/zlyB8YXS4WXPZwy3Uge+cSlhhZ+L2JODElY3HKeazyrZqXFoGCueSmu/2XcT67+AqOx0YrAtewH0q/+lm1k9OIfybDdi/BKXWnZOAfRcVMf5m4DXbT4Ge6f+fA4R1PTlwMBWnEpwL6j5pYBJqAYQkI6rDvnEz0BblzV9Nqk1SQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(261022115727099003)(261022105027099003)(261022113327099003)(261022075727099003)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026140227099003)(261021130227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	peeAUf0NF8lNpCaYiI8B0vktsxs1zq0p4EMAqZlOhcZcOL673qhL0UxOunseviqkgAAWdkdV80zrDcgw/IoVuumyNTmwlZlw/bZb6PnJ4GxYK9zfee/jB19f8z6nfuG4Kl9frTc0baVgS1P9juLuFJ+8sUI0KmkJb4/ungv+lqlpcYGNyhc41dt8nz93RGGmOJPTAOWuflumWJwGW5ipFZh8/9jRYCvKzXu8R5pZXDFs0jwrlAD5Mz3zlBjehuQha2nyxR6QH8AiqBhw3hMYSIxkKp1qgDbA+96vh+K+kzzvFJjzD2NIlNN6CYcoTJTIvoPq0nY/JqyRWk/oLGggAUH6TTj6qnUmuBYXQCfqNoPN8zgmtu/Qp/ADVGP+kInE1Jm9ArFQvjKW4E/PhloWZ0cr4EJlyeyXGZy4cEUTPdLnas1GMlrv4tSp9a93xehS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:13:11.4479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d84ac46c-8c3f-46a7-30a0-08df36a9138f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00006E21.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS8PR12MB315725

From: Peter Colberg <peter@colberg.org>

Wrap pci_enable_sriov() and pci_disable_sriov() on Device<CoreInternal>
for use by the SR-IOV callback tokens and their rollback guard.
Keep these operations internal so drivers can only enable or disable
VFs through the callback-scoped API introduced later in this series.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs     |  2 ++
 rust/kernel/pci/iov.rs | 48 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 rust/kernel/pci/iov.rs

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f47974d3e76..e522fdddc34 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -36,6 +36,8 @@
 mod cap;
 mod id;
 mod io;
+#[cfg(CONFIG_PCI_IOV)]
+mod iov;
 mod irq;
 
 pub use self::cap::{
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
new file mode 100644
index 00000000000..6f8f95ed618
--- /dev/null
+++ b/rust/kernel/pci/iov.rs
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for PCI Single Root I/O Virtualization (SR-IOV) drivers.
+
+use super::Device;
+
+use crate::{
+    bindings,
+    device,
+    error::to_result,
+    prelude::*, //
+};
+
+impl Device<device::CoreInternal<'_>> {
+    /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
+    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
+    #[inline]
+    #[expect(dead_code)]
+    pub(crate) fn enable_sriov(&self, nr_virtfn: u16) -> Result {
+        // SAFETY:
+        // - `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        //
+        // - `pci_enable_sriov()` checks that the enable operation is valid:
+        //   - the device is a Physical Function (PF),
+        //   - SR-IOV is currently disabled, and
+        //   - `nr_virtfn` does not exceed the total number of supported VFs.
+        //
+        // - The [`CoreInternal`] device context inherits from the [`Bound`] device context,
+        //   which guarantees that the PF device is bound to a driver.
+        to_result(unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_virtfn.into()) })
+    }
+
+    /// Disable the Single Root I/O Virtualization (SR-IOV) capability for this device.
+    #[inline]
+    #[expect(dead_code)]
+    pub(crate) fn disable_sriov(&self) {
+        // SAFETY:
+        // - `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        //
+        // - `pci_disable_sriov()` checks that the disable operation is valid:
+        //   - the device is a Physical Function (PF), and
+        //   - SR-IOV is currently enabled.
+        //
+        // - The [`CoreInternal`] device context inherits from the [`Bound`] device context,
+        //   which guarantees that the PF device is bound to a driver.
+        unsafe { bindings::pci_disable_sriov(self.as_raw()) };
+    }
+}
-- 
2.43.7

