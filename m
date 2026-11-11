Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794436501;
	b=RIO2mcZbiwE9QM1mRmnZimWL0XZ+Zh5h0vo8E7XHdCixhDfO7vxzn1wHgZa4kiLZcWak
	 ZQ/MX5ZM+1T9r1k33RLxO/1GIAAKm61czAIi7Sv9+TF5nIcUl29wXzR0qe+s3K0Jm+ret
	 Z7/yKJhyEttBdRvHNb0BPFLczn+eSEThPU+G9XPB/LrmPPH3ZN2NV+689f5bhYt9tr+Cr
	 zKsSPu4qbZ4FQrM5dmc+gZF6ED+7YARm1OyQTUTbwLZctPXNpOBWI5lVzaMO/xhQzINUM
	 1GUBwIv251LFY98jMa5ZUSWqvfEVLowZbF2ok7+/ZhCckuohelyGmGcqCcLm4pyblJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436501;
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
	bh=K2Mz+UN2UD6wil+qjAA653i8OuGmJW/ddS2+haOoEvA=;
	b=4eaboKh/O6jm7BleQpL9ZlgJY1CZi9wvIzIWW3cP0hoDJb9GM6BKQGS3ctls7RAqxmP9
	 dJTsfk3auH+q5RYc7b1JxDySrqEP2Gh96La+HQEY0o+++zgNUA3S2lnoO/A2uds3csURP
	 mBZ897LJyPr4h4EsCuOrgM9SdJEpc/wvn+T9M5rneq5VrBJ9GntseNe9GDOENlO7GIKps
	 WHXf7x8QanI9buhbWN6KcR3u+jYUYDWK7/+X8l8AxaivvKrFJsGT8OO2B/Hl51bxgjdb5
	 H8pIhAaagGpEfAHuwYUgFuyCPn+Qzd2ca8LqzsxYrc5b1qwrgxOZq8sf6BbJ/iyONzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=loLurpr+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.15
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C43606A8B0;
	Wed, 11 Nov 2026 22:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2C43606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=loLurpr+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uU4etceiPSRV5iA2hnTw6n/RkuH4zMirKzQ5yChKxDmGOTTnPq9UTukcr/+xcfX2eoz1ZFYSId5aFpi7mouEphGFQf80bgIcKEVw8O3NBh//dzViGphPPYw7oN9HFbHDNIq/2Pr4jrKHdkGvwN9F2KoYJrOPBwKlIpjQhlLLXrhw/93Wj53i4eQ8Zr9v12kh2zyedyjXhUZdL2KJ0osOwWRq5vIKZrka/lItk6ILuCM1v2zlS3s+HKXWXH4JYDGhVLXTrq8UrYekyTCZjutDuNeGT3gCO2S1v8nwvfhoLgIdiqnhrIizmPXn7MMFPswnbZRI9YKMbY+8p7Q/Qf0njQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2Mz+UN2UD6wil+qjAA653i8OuGmJW/ddS2+haOoEvA=;
 b=bnGYxIQ/1A6zfhg8w4paXhcsAOAxRsv1tuKlFVueYbEVsf7a+QTbjvy9H9gGMfeaaT5VBeLUm8fiB1sJ7Phh9y7FzLtMZzZeU1dKVTkp+Bfk25WFxs8QGS4zAv0Q48dFRptAEIvPYhoNp5yUcYuI3tSebfWhkzSKUZsDBEIVirwLtUM3sROzZ1EF8aDr2A/4Y9v9ch7Wu4VW0SwTg52a5Ev5bmPFGMMNotPwDmmufhfzAa4jQmAtunzNg73C8VzRBr+/eHDXjQyDJLixrOJui76XuDj9+YHxEhjxNfcY5e+AJHpnpYUtmuYxAXM+eB9KzBGNtn2TytkZtK+Uy9Tr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2Mz+UN2UD6wil+qjAA653i8OuGmJW/ddS2+haOoEvA=;
 b=loLurpr+lakoWZpRlMaFXR4US1or1x4u+4Sjys7KJ7GXkN/rkP3SLH2fsKeiTvc/dWVwgIHMSVRGyWwkzrnt4/HJA0zs+09Nq6BtBqbDnQG55uMD7K985O/Zx21gMB+Ztb1QYDLz+22SZf4oLiD8FTBXwn49yozelx1xhV6YRJcbwzuw1XXG6NpYJvJCEwOrivLYvzNRv0cCTGFmp8BQKB7InZ/LMSs1csbBkBktjlKNIEr1j7itIbBup98HM5RebobgeHTYl65qpnYcTGo5BsVp5sw7W0U4r/HujM4xd97V84g2o/bfHDajCqFezjRYBVpbd1UjHdvxfJjbTXzS2A==
Received: from BY1P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::6)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 22:34:08 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:59e:cafe::7e) by BY1P220CA0048.outlook.office365.com
 (2603:10b6:a03:59e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 22:34:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 22:34:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 14:33:58 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 14:33:55 -0800
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
Subject: [PATCH v6 01/11] rust: pci: add internal SR-IOV enable and disable helpers
Date: Wed, 11 Nov 2026 14:33:26 -0800
Message-ID: <20261111223337.508989-2-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc5314e-d5d6-4d35-9196-08df4043e628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|36860700016|1800799024|82310400026|261022115727099003|10067099003|11063799006|261021123027099003|56012099006|261021121427099003|261021130227099003|261102123227099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261022105027099003|261022113327099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Vl/AgalSOa15lBD0xp6qrdbIdiMm/T8/Rxk40TM/8OwENEN1DBIPL2JQWshXlPOYbOQgo6hBxc0W7W9MME65Y2gLtmYEiGWOGS2OttEyNt/pGNUw+AfGDZIBM6S6VBJai2JVYIbII5Mf3Te2j62/7xVtcPAjBdFE357vwLi2BSiwd9HG30wAU94SBZ4+2KMgLC5u9tfgQP1PQASsNUPAjkpfUp/b+j6S1935nbI0uKf6Uj+6P3EMYw8T0K1wHHNf4h1uKF4AnTCadbeLFpun3Qr3cMTkHTH4vmwhMqARmlJtDzL/9uUAjvddCjw0gBFXY5MIcS7ZFGByzrT9wgxfLb35H9lmUzZi+/+t/bXI2BuQZ3i00cVctetgNaM1P8p2v+GkE5MydYb49BGmegpn8eCuT6VzxYQPDzds9vVf37So6nXsIiC3akbWj4c655OGdp6RmETKMb44h2S4DJsE9mWTi8aAdCx2MdaQyhkN5hoJQsQi01UaaKJeKYPs9Nym7wySeXhJy4fSj9rvLc82P3RxRRZxoBydXt8T3c31li2/L+EEv5id8b1nhXsVOp5Hve+TKozo1hpnWpORE76ASjNZFd9h/whBsN0VHdrJSkvDEcQW4Vud6MAICyqg2U4Q2JDTJss8u7jma+CITmnioCHnh7jUQhobrJZoD6DPjT30NpxfljXt6dOGViQQbJCIkCz5J1BW5/JXXufXS4Pitg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(36860700016)(1800799024)(82310400026)(261022115727099003)(10067099003)(11063799006)(261021123027099003)(56012099006)(261021121427099003)(261021130227099003)(261102123227099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022113327099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UCJiXcRLFyIEdJB2VIVx4z4UlC2cHPAhzWk8J+ou9KKJoP0CBjKPqbDLvBHyBya8VviueIpUgUP1/Jd9Dl9gk/X1yruHUVu7MQgYYKFVWCD7yOdp+2Z6twG5WmOxPwXqRvcjFVbECfVJr5LLpf+tuygorey8kcCALlgvv77gvoACnRbaIwci944zibjMIZ4P2CRX8wIRDxxnJc3UDDRKYTTVohmD75Xd3BQTjzy2YR9E4Ab6qacpfPNSfDtPUO1b87PKLQtlYg4/dNjKfSQMvo7H+jlUG945hRmesg/N2L5DFwZFKVeOHi17dH8o32bh9S6qo8qdEP8CJpTYwf14SvYvoQs4FGiH0h7AfH/8sfXy/7G+5mbNJKK7ggZzCFEkxa9ZlNhAMeDoUlyV9w8zRFA6ElyXRhOOSaUM2lKlooqHswB09FucShP6j1WvVTsH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:34:07.8045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc5314e-d5d6-4d35-9196-08df4043e628
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191

From: Peter Colberg <peter@colberg.org>

Wrap pci_enable_sriov() and pci_disable_sriov() on Device<CoreInternal>
for use by the SR-IOV callback tokens and their rollback guard.
Keep these operations internal so drivers can only enable or disable
VFs through the callback-scoped API introduced later in this series.

Stub both helpers when CONFIG_PCI_IOV is disabled, so the SR-IOV API
builds regardless and drivers need no configuration guards.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/helpers/pci.c     | 11 ++++++++++
 rust/kernel/pci.rs     |  1 +
 rust/kernel/pci/iov.rs | 48 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 rust/kernel/pci/iov.rs

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index a8540f90b13c..a87b5a77efef 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -41,6 +41,17 @@ __rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
 }
 
 #ifndef CONFIG_PCI_IOV
+__rust_helper int rust_helper_pci_enable_sriov(struct pci_dev *pdev,
+					       int nr_virtfn)
+{
+	return pci_enable_sriov(pdev, nr_virtfn);
+}
+
+__rust_helper void rust_helper_pci_disable_sriov(struct pci_dev *pdev)
+{
+	pci_disable_sriov(pdev);
+}
+
 __rust_helper unsigned int
 rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
 {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 769d01d23429..8a4af261d1d4 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -36,6 +36,7 @@
 mod cap;
 mod id;
 mod io;
+mod iov;
 mod irq;
 
 pub use self::cap::{
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
new file mode 100644
index 000000000000..18e42b2d3965
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
+        // - The `CoreInternal` device context inherits from the `Bound` device context,
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
+        // - The `CoreInternal` device context inherits from the `Bound` device context,
+        //   which guarantees that the PF device is bound to a driver.
+        unsafe { bindings::pci_disable_sriov(self.as_raw()) };
+    }
+}
-- 
2.43.7

