Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795125128;
	b=ZdvEZ1XgBagJAXHQ5ykjuAzUdKiPCEZcnD0UkvNKRqTxNhmTEPJK7eL1DWt5OOdpaNmg
	 6zUiNTg1BCU/GKi0qP4oUPWWSA3QDmoD2/3n4De4r7AmcnGyKiD51bg5WBd5S6v4C0gWA
	 Hp73u0jjHXLX/+0BDgWWwBEKtrt0sCos6Mfxe19BkIfvpYZC2O3Ga/ymhDi7R+KZsNYjv
	 eCZfi9tpKmmfHz6aNEhNWpNpAHng8qi+mm8Gpr0Hh4yXqzxRmvR85OCe89IiL/OlGfr9X
	 9bnKtRofZrSEjS3VBehq/kP5/XJqxglJddyZceHh1XWCas6Jh05Llcx0B1ePmPMo0+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125128;
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
	bh=NpwyCyb8myqsIJ1FCQLX6aZjTnra6j6lFMIoYGvl6YE=;
	b=NdfFN8e/mW1rQIsfhjsEyX/bcC8tlNAQp5dTTrF+rqOaw9Jd7R28alvk2yYkgQodm9KX
	 EZJdmmwcJbj5a6A99Di6aWJKgGYT8t888lLviCRvUoREuB4KPuDyc7hnYy0v3rFoj+ZoA
	 IZ+x6CdH7/ZKljniz83GuY/ceWNlDeU04JDjsqF7iLf7PaQ8JIJUyelh/ZMvHDd2q+Edg
	 nWW4fzUcURB34Mby7raUTzGlTv9zMCmt2WqDt48lZff4kfMEZDx8y8WcnEX91xR6128Bz
	 43tXiB3Zj+nxzleUFXvKxGvP4kr1q2XlKFpP9gtqpuZgb1/tk2V4xG/kuGa9CKY+ZAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AvTlLzIR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.43
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BDB60A5BE0;
	Thu, 19 Nov 2026 21:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84BDB60A5BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AvTlLzIR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hopO6uPldQ1vGkrzy7AvgaJte4pqNXkomb4ux3YZ/wVHe7tuP4CcbjvAuy8khjwZtS4cGpgQN/4uRFtqIe12jpZUHDHnActpPmKaMev0aET9QhrqFu7YRO5pNnYVtZIwLDUP+uhb/0n/LJYoF5+G+0QRMMK2/osl/3lIqXqqYPtYd681rdnpkqAcgZDbwJv+5/Dlwws7NuBdGhHcAPoTRMbt7gRUEURv3yFkneky1dhoNsZ+7tF+6OxxHb1GNftHQARLYJoNz1EUrikA5+E2CLHBaBAw9jK42KwDRDoHubyj6PrrjMO/UDgGDAC0NKhCoTXwgj7+437mPvGdHGiaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpwyCyb8myqsIJ1FCQLX6aZjTnra6j6lFMIoYGvl6YE=;
 b=AYCF9KfJexbKFvAa0JWZ1/Bln/X+LIrY7mHS6o7kYyF64d5g4L/QqX7osys0eblsuwgIwzhEast55yMPKmJKLjdt4GroWXkjp2uDlUa6iFl9+HRTnsJ5GfOuRFLS8uoO9d5/ftodiGKQh5qXp4K+olUXfqqtcQ+Ab6yAXQJYkMrzOT2FiIFEWzSveegepmnGqvFv6lA4qnXwSdp7vfTUhqJHOAIQcZILvYvtdHEKYB8D626a+hqS2sZWCK0XRHp7+DSw3cCAAanf5mqM7hwB+jwiLnMHG1vl+Lqx/UwQzJYn1W8TvKYTZV9/I+urudnX85uvK012kRuLK0/DLRSaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpwyCyb8myqsIJ1FCQLX6aZjTnra6j6lFMIoYGvl6YE=;
 b=AvTlLzIRsDszg/wpShtGVJDLMaDwwcrNgCvKoYo0j2KeSkza/4k0TIc+UpK9sKwsCsB6tG360GBuU4UWxf9Zi/eBLTJWdsX+/IMthS++o9XPst1bQ0FgBpXoGrqA3hE1CVrxstWHjfcVC9oC2IiMLQXI1OzZx1XLzD+RaP+bGLHlFGGaaCy9GKoN16+Xi2bnuSktNC7cp1A8b9exA0I8CgwsXZzz8RyJ8Jv8Rc+CloD/nJKHwrq8UjYiQ3NvFmOwGrXSDX8bsA5qmbPMTUx2tNCL5ueasxCrQY1cCGKMmDImFwYgUKJnPF1nkGSib8rXlhY4KuZmu/jtw8F8UWRafA==
Received: from BN9PR03CA0157.namprd03.prod.outlook.com (2603:10b6:408:f4::12)
 by CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 21:51:53 +0000
Received: from BL4PEPF000003EE.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::12) by BN9PR03CA0157.outlook.office365.com
 (2603:10b6:408:f4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 21:51:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL4PEPF000003EE.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 21:51:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:51:21 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 13:51:17 -0800
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
Subject: [PATCH v3 7/9] rust: vfio: add PCI variant driver abstractions
Date: Thu, 19 Nov 2026 13:50:42 -0800
Message-ID: <20261119215046.2892839-8-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL4PEPF000003EE:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: cc50a8e7-89ce-4ede-76b6-08df468750c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|22082099003|18002099003|6133799003|3023799007|11063799006|5023799004|56012099006|261026121527099003|261022105027099003|261102123227099003|261028144727099003|261022113327099003|261021121427099003|261022075727099003|261021123027099003|261102130727099003|261009223027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	5OK/uLosJ4s+GU2XWfqBO2v7IKtV2FtE7cS/aUO257rhmrS0ZHOFVmGYDlfZ4ECkofU2ES+GE8Qr7QKRxaaXjRDJQSfbRr9wGPAUrrbXlbyz5QYUlrC5wXDL739+u8psvd3BBGnsBz+MbnXpLGaJLZibQtwMmRN2una0k3QHHyGZ7MTJXuMMcbK+i0s1PbqwoVYKE+hmLUGGbkpj9qFX4s3AVtVi6LlY9zoKU3UK/XszCCEUxogCdV4FAQD4EyHwXgS5FADqup+NboXfogQzbETZUmaIPrvAcDihIKrVz5l+U4zhTVesQwOFXwUrrzZnvIROYSNXwuvTlgSO00xpvanWdoYG4OszqsBGYC0qOA2GGUekhSvb/Pc87fotlZjfdXkMP25+MUK6GXxPvlt4/aj6ys8I5IqQBUsiOEBNpdVO6FA16p0+9JQlOYgn2+yck00xrOVTLQj7A+TEo85ZuKMOkS+aBmM1ComVN1KZF5NGG295NbgQ6tyI63WSF0LxxDLMz10wUs8SwEurtAZaSz09hp/A3dZjX9ryVWii0cJiabSb+Y1gi4SNqxaHNng7ZRlwgWHnUBcRr2mE4bp6kpw1u8Rp0L0sZUwKWVz7OXC1nuSupry+8venM5KtP9SzqpA4lh4gCiipGd9xXzDN3NInIC0E/Yy/GXjFanFf/SS89oJs20+5w24dqNYWpV4V0sMJ6sZjh48hHEwA5uTBTg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(6133799003)(3023799007)(11063799006)(5023799004)(56012099006)(261026121527099003)(261022105027099003)(261102123227099003)(261028144727099003)(261022113327099003)(261021121427099003)(261022075727099003)(261021123027099003)(261102130727099003)(261009223027099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aKLYIja9iAQ0FQLc58HRhkGgdmHuQDrlp0r88yuptZqS2/SDOZcevSVE6AUFTzsWc40R4aqxfGpTCaw5FDJ2pGqNLEz+ZQ0gLaDt90h19dRPPjJx/Dyj/5j3kJxDmpKrZZ4d+CUHcqJ7Y40CDBrSeldRpiLArXNY76gjFs29B2RVAI91Pb1WMVY0jwqrZS2kz/7C0CTcX89LEWgahOeLXgUEHkgFL5Nbqmj5SuaEyAhFUP8x8dAQxuVLMbZoLjrve8146bJFsIeJZNrg9vCqqbhQPfr8jxZm1iK5Y2WTAWarj6d7rGPYBJuCN5lp99Q2tepETzFde38cTHBdR32KodYKB1kpoEkW03sR7hd1RwHZYxsj3bHpz9hCfGrEFZh3KKj0lGewZpQhMFp9VNQA1JdMMu99bDPu4ix8LIbNpFh80MtMSyrGzUvia+8ooaRo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:51:49.8094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc50a8e7-89ce-4ede-76b6-08df468750c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL4PEPF000003EE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727

From: Danilo Krummrich <dakr@kernel.org>

Add Rust abstractions for PCI drivers that extend vfio-pci-core with
device-specific operations.

Provide Operations, Device and Registration with separate registration
and first-open/last-close data. Allow open data to borrow registration
data, undo PCI enablement if open fails, and drop open data before
closing the core device.

Let a driver register its VFIO device with Registration::new(), for
example from its PCI probe callback, and unregister it by dropping the
Registration. Let drivers forward PCI reset and error callbacks through
the Registration. Let vfio-pci-core select its VGA arbitration
callbacks. Because runtime PM support follows in a separate patch
series, keep the device active while it is registered.

Restrict core I/O helpers to their corresponding callback contexts. Add
region mapping helpers, and wire up VFIO core support for device
features, matching, IOMMUFD and PASID. Allow passthrough devices to
export physical BARs as DMA buffers.

Add pci::ErsResult::from_raw() for the result of the VFIO PCI core's
error handler.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/pci.rs              |  12 +
 rust/kernel/vfio.rs             |  21 +-
 rust/kernel/vfio/pci.rs         | 777 ++++++++++++++++++++++++++++++++
 4 files changed, 803 insertions(+), 9 deletions(-)
 create mode 100644 rust/kernel/vfio/pci.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a5781bc1ea85..b052f1e874e2 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -94,6 +94,7 @@
 #include <linux/tracepoint.h>
 #include <linux/usb.h>
 #include <linux/vfio.h>
+#include <linux/vfio_pci_core.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
@@ -117,6 +118,7 @@ const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
 const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN = ARCH_KMALLOC_MINALIGN;
 const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
 const unsigned int RUST_CONST_HELPER_VFIO_DEVICE_RESET = VFIO_DEVICE_RESET;
+const unsigned int RUST_CONST_HELPER_VFIO_DEVICE_PCI_HOT_RESET = VFIO_DEVICE_PCI_HOT_RESET;
 const size_t RUST_CONST_HELPER_GENLMSG_DEFAULT_SIZE = GENLMSG_DEFAULT_SIZE;
 const gfp_t RUST_CONST_HELPER_GFP_ATOMIC = GFP_ATOMIC;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 27ac8d8435f7..8a3fdcd1d059 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -429,6 +429,18 @@ pub enum ErsResult {
 }
 
 impl ErsResult {
+    #[cfg_attr(not(CONFIG_VFIO_PCI_CORE), expect(dead_code))]
+    pub(crate) fn from_raw(result: bindings::pci_ers_result_t) -> Option<Self> {
+        match result {
+            bindings::pci_ers_result_PCI_ERS_RESULT_NONE => Some(Self::None),
+            bindings::pci_ers_result_PCI_ERS_RESULT_CAN_RECOVER => Some(Self::CanRecover),
+            bindings::pci_ers_result_PCI_ERS_RESULT_NEED_RESET => Some(Self::NeedReset),
+            bindings::pci_ers_result_PCI_ERS_RESULT_DISCONNECT => Some(Self::Disconnect),
+            bindings::pci_ers_result_PCI_ERS_RESULT_RECOVERED => Some(Self::Recovered),
+            _ => None,
+        }
+    }
+
     fn as_raw(self) -> bindings::pci_ers_result_t {
         match self {
             Self::None => bindings::pci_ers_result_PCI_ERS_RESULT_NONE,
diff --git a/rust/kernel/vfio.rs b/rust/kernel/vfio.rs
index bc50647a2437..43e904e2c980 100644
--- a/rust/kernel/vfio.rs
+++ b/rust/kernel/vfio.rs
@@ -3,7 +3,7 @@
 //! Virtual Function I/O (VFIO) devices and callback data.
 //!
 //! [`DeviceBase`] combines a C VFIO device structure with the data its callbacks use.
-//! [`Device`] is an alias of it for `struct vfio_device`.
+//! [`Device`] and the bus-specific devices, such as `pci::Device`, are aliases of it.
 //!
 //! C header: [`include/linux/vfio.h`](srctree/include/linux/vfio.h)
 
@@ -26,6 +26,9 @@
     ptr::NonNull, //
 };
 
+#[cfg(CONFIG_VFIO_PCI_CORE)]
+pub mod pci;
+
 /// Reset the VFIO device.
 pub const DEVICE_RESET: u32 = bindings::VFIO_DEVICE_RESET;
 
@@ -89,7 +92,7 @@ impl IoContext for GetRegionInfo {}
 
 /// The data the driver of a [`Device`] shares with its callbacks.
 ///
-/// Bus-specific devices take the data types from their own trait.
+/// Bus-specific devices take the data types from their own trait, such as `pci::Operations`.
 pub trait Operations: Sized + Send + Sync + 'static {
     /// Data owned by the registration and passed to VFIO callbacks.
     ///
@@ -148,8 +151,8 @@ struct CallbackData<R, O> {
 /// beginning of `Self`, as `vfio_alloc_device()` requires.
 ///
 /// `R` and `O` are the types of the registration data and the open data of `T`, written with
-/// the placeholder lifetime `'static`. Use the alias [`Device`], which takes both from the
-/// operations trait of `T`.
+/// the placeholder lifetime `'static`. Use the aliases [`Device`] and `pci::Device`, which
+/// take both from the operations trait of `T`.
 ///
 /// # Invariants
 ///
@@ -176,7 +179,7 @@ pub struct DeviceBase<Raw, R, O, T, Ctx: DeviceContext = Normal> {
     Ctx,
 >;
 
-#[expect(dead_code)]
+#[cfg_attr(not(CONFIG_VFIO_PCI_CORE), expect(dead_code))]
 impl<Raw: RawDevice, R, O, T, Ctx: DeviceContext> DeviceBase<Raw, R, O, T, Ctx> {
     /// Initializes the Rust fields of a newly allocated device.
     ///
@@ -217,7 +220,7 @@ fn as_raw_vfio(&self) -> *mut bindings::vfio_device {
     }
 }
 
-#[expect(dead_code)]
+#[cfg_attr(not(CONFIG_VFIO_PCI_CORE), expect(dead_code))]
 impl<Raw: RawDevice, R, O, T> DeviceBase<Raw, R, O, T> {
     /// Publishes the registration data passed to callbacks.
     ///
@@ -258,7 +261,7 @@ unsafe fn close(&self) {
     }
 }
 
-#[expect(dead_code)]
+#[cfg_attr(not(CONFIG_VFIO_PCI_CORE), expect(dead_code))]
 impl<Raw: RawDevice, R, O, T> DeviceBase<Raw, R, O, T, Open> {
     /// Creates the open data from the registration data.
     ///
@@ -301,7 +304,7 @@ unsafe fn open<'a, OD, I>(&'a self, init: impl FnOnce(&'a R) -> I) -> Result
     }
 }
 
-#[expect(dead_code)]
+#[cfg_attr(not(CONFIG_VFIO_PCI_CORE), expect(dead_code))]
 impl<Raw: RawDevice, R, O, T, Ctx: IoContext> DeviceBase<Raw, R, O, T, Ctx> {
     /// Returns the registration data and the open data, for an I/O callback.
     ///
@@ -352,7 +355,7 @@ unsafe impl<Raw: RawDevice, R: Send + Sync, O: Send + Sync, T> Sync for DeviceBa
 
 /// Capability buffer supplied by VFIO for a region-info callback.
 pub struct InfoCap<'a> {
-    #[expect(dead_code)]
+    #[cfg_attr(not(CONFIG_VFIO_PCI_CORE), expect(dead_code))]
     raw: &'a mut bindings::vfio_info_cap,
 }
 
diff --git a/rust/kernel/vfio/pci.rs b/rust/kernel/vfio/pci.rs
new file mode 100644
index 000000000000..bde5ed139e5f
--- /dev/null
+++ b/rust/kernel/vfio/pci.rs
@@ -0,0 +1,777 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! VFIO PCI variant driver abstractions.
+//!
+//! Provides Rust abstractions for writing VFIO PCI variant drivers (also known
+//! as "VFIO PCI core" drivers). A [`Registration`] struct registers the VFIO
+//! device and owns its registration data, tying resource lifetimes to the PCI
+//! driver's binding scope.
+//!
+//! C header: [`include/linux/vfio_pci_core.h`](srctree/include/linux/vfio_pci_core.h)
+
+use super::{
+    DeviceBase,
+    InfoCap,
+    RawDevice,
+    UserBuf, //
+};
+pub use super::{
+    DeviceContext,
+    GetRegionInfo,
+    IoContext,
+    Ioctl,
+    Mmap,
+    Normal,
+    Open,
+    Read,
+    Write, //
+};
+
+use crate::{
+    alloc::allocator::Kmalloc,
+    bindings,
+    device,
+    error::{
+        from_err_ptr,
+        to_result, //
+    },
+    mm::virt::VmaRef,
+    pci,
+    prelude::*,
+    sync::aref::ARef,
+    types::NotThreadSafe,
+    uaccess::UserPtr, //
+};
+use core::{
+    alloc::Layout,
+    ptr::NonNull, //
+};
+
+/// Reset the PCI slot or bus containing a VFIO device.
+pub const DEVICE_PCI_HOT_RESET: u32 = bindings::VFIO_DEVICE_PCI_HOT_RESET;
+
+/// Index of the PCI configuration-space region.
+pub const CONFIG_REGION_INDEX: u32 = bindings::VFIO_PCI_CONFIG_REGION_INDEX;
+
+/// The trait for VFIO PCI variant driver implementations.
+///
+/// Unoverridden callbacks delegate to the corresponding PCI core operation.
+///
+/// # Lifetime of the callback data
+///
+/// [`Registration`] owns the [`RegistrationData`](Operations::RegistrationData), which
+/// borrows from the PCI binding scope, and each callback borrows it. Callbacks are generic over
+/// the lifetime of the registration data, so they cannot store callback-local references in it.
+pub trait Operations: Sized + Send + Sync + 'static {
+    /// The name of the VFIO driver.
+    const NAME: &'static CStr;
+
+    /// Data owned by the [`Registration`] and passed to VFIO callbacks.
+    ///
+    /// It can borrow resources of the driver's binding for `'a`. Per-device state lives here.
+    type RegistrationData<'a>: Send + Sync + 'a;
+
+    /// Data shared by callbacks from the first successful open until the last close.
+    ///
+    /// It can borrow the registration data, of lifetime `'data`, for `'a`.
+    type OpenData<'a, 'data: 'a>: Send + Sync + 'a;
+
+    /// Called when the first file descriptor is opened for this device.
+    ///
+    /// `vfio_pci_core_enable()` has already succeeded; if this returns an
+    /// error, `vfio_pci_core_disable()` is called automatically. The returned
+    /// open data is dropped before PCI core close on the last close.
+    fn open_device<'a, 'data: 'a>(
+        dev: &'a Device<Self, Open>,
+        reg_data: &'a Self::RegistrationData<'data>,
+    ) -> impl PinInit<Self::OpenData<'a, 'data>, Error> + 'a;
+
+    /// Handle a VFIO ioctl.
+    ///
+    /// The default `vfio_pci_core_ioctl()` is available via
+    /// [`Device::core_ioctl()`] for delegation.
+    fn ioctl<'data>(
+        dev: &Device<Self, Ioctl>,
+        reg_data: &Self::RegistrationData<'data>,
+        open_data: Pin<&Self::OpenData<'_, 'data>>,
+        cmd: u32,
+        arg: usize,
+    ) -> Result<isize>;
+
+    /// Read from the device.
+    ///
+    /// `buf` is a user-space buffer provided by the VFIO core. Use
+    /// [`Device::core_read()`] to delegate the default read, and
+    /// [`UserBuf::write_overlapping()`] to override specific bytes afterwards.
+    fn read<'data>(
+        dev: &Device<Self, Read>,
+        reg_data: &Self::RegistrationData<'data>,
+        open_data: Pin<&Self::OpenData<'_, 'data>>,
+        buf: &mut UserBuf,
+        ppos: &mut Position<'_>,
+    ) -> Result<isize>;
+
+    /// Write to the device, delegating to [`Device::core_write()`] if appropriate.
+    fn write<'data>(
+        dev: &Device<Self, Write>,
+        _reg_data: &Self::RegistrationData<'data>,
+        _open_data: Pin<&Self::OpenData<'_, 'data>>,
+        buf: &mut UserBuf,
+        ppos: &mut Position<'_>,
+    ) -> Result<isize> {
+        dev.core_write(buf, ppos)
+    }
+
+    /// Map a device region, delegating to [`Device::core_mmap()`] if appropriate.
+    fn mmap<'data>(
+        dev: &Device<Self, Mmap>,
+        _reg_data: &Self::RegistrationData<'data>,
+        _open_data: Pin<&Self::OpenData<'_, 'data>>,
+        mapping: &mut Mapping<'_>,
+    ) -> Result {
+        dev.core_mmap(mapping)
+    }
+
+    /// Prepare for PCI reset, including resets initiated during enable or close.
+    fn reset_prepare(_reg_data: &Self::RegistrationData<'_>) {}
+
+    /// Finish PCI reset; errors are reported through the VFIO error interrupt.
+    fn reset_done(_reg_data: &Self::RegistrationData<'_>) -> Result {
+        Ok(())
+    }
+
+    /// Fill in region info capabilities.
+    ///
+    /// The default `vfio_pci_ioctl_get_region_info()` is available via
+    /// [`Device::core_get_region_info()`] for delegation.
+    fn get_region_info<'data>(
+        dev: &Device<Self, GetRegionInfo>,
+        reg_data: &Self::RegistrationData<'data>,
+        open_data: Pin<&Self::OpenData<'_, 'data>>,
+        info: &mut bindings::vfio_region_info,
+        caps: &mut InfoCap<'_>,
+    ) -> Result;
+}
+
+/// A VFIO PCI file position, encoding a region index and an offset within that region.
+pub struct Position<'a> {
+    raw: &'a mut i64,
+}
+
+impl Position<'_> {
+    /// Commit a temporary position only after the operation succeeds.
+    ///
+    /// This preserves the original position if a read succeeds but a subsequent
+    /// user copy fails.
+    pub fn with_temporary<R>(
+        &mut self,
+        operation: impl FnOnce(&mut Position<'_>) -> Result<R>,
+    ) -> Result<R> {
+        let mut next = *self.raw;
+        let result = operation(&mut Position { raw: &mut next })?;
+        *self.raw = next;
+        Ok(result)
+    }
+
+    /// Returns the PCI region index.
+    pub fn region_index(&self) -> u32 {
+        ((*self.raw as u64) >> bindings::VFIO_PCI_OFFSET_SHIFT) as u32
+    }
+
+    /// Returns the byte offset within the current region.
+    pub fn region_offset(&self) -> u64 {
+        (*self.raw as u64) & ((1u64 << bindings::VFIO_PCI_OFFSET_SHIFT) - 1)
+    }
+}
+
+/// Mapping metadata supplied by VFIO while the current thread holds the mmap lock.
+///
+/// The underlying VMA can only be passed back to the core mmap operation.
+pub struct Mapping<'a> {
+    vma: &'a VmaRef,
+    _not_thread_safe: NotThreadSafe,
+}
+
+impl Mapping<'_> {
+    fn page_offset(&self) -> u64 {
+        // SAFETY: The mmap callback holds the mmap lock for this VMA.
+        unsafe { (*self.vma.as_ptr()).vm_pgoff as u64 }
+    }
+
+    /// Returns the PCI region index encoded in the mapping offset.
+    pub fn region_index(&self) -> u32 {
+        (self.page_offset() >> (bindings::VFIO_PCI_OFFSET_SHIFT as usize - crate::page::PAGE_SHIFT))
+            as u32
+    }
+
+    /// Returns the byte offset within the PCI region.
+    fn region_offset(&self) -> u64 {
+        let mask = ((1u64 << bindings::VFIO_PCI_OFFSET_SHIFT) - 1) >> crate::page::PAGE_SHIFT;
+        (self.page_offset() & mask) << crate::page::PAGE_SHIFT
+    }
+
+    /// Returns the requested mapping length in bytes.
+    fn size(&self) -> Result<u64> {
+        self.vma
+            .end()
+            .checked_sub(self.vma.start())
+            .map(|size| size as u64)
+            .ok_or(EOVERFLOW)
+    }
+
+    /// Returns the exclusive end of the requested mapping within the PCI region.
+    pub fn region_end(&self) -> Result<u64> {
+        self.region_offset()
+            .checked_add(self.size()?)
+            .ok_or(EOVERFLOW)
+    }
+}
+
+/// A VFIO PCI variant device, wrapping `struct vfio_pci_core_device`.
+///
+/// Callback contexts expose only their matching core helper and cannot be
+/// refcounted or shared across threads.
+///
+/// # Invariants
+///
+/// In addition to the invariants of [`DeviceBase`]:
+///
+/// - The wrapped `vfio_pci_core_device` was initialized by `vfio_pci_core_init_dev()`.
+/// - The callback data follows the VFIO registration and first-open/last-close lifetimes.
+///   Open data is destroyed before PCI core close, and registration data is
+///   released after PCI core unregistration has drained callbacks.
+pub type Device<T, Ctx = Normal> = DeviceBase<
+    bindings::vfio_pci_core_device,
+    <T as Operations>::RegistrationData<'static>,
+    <T as Operations>::OpenData<'static, 'static>,
+    T,
+    Ctx,
+>;
+
+static_assert!(core::mem::offset_of!(bindings::vfio_pci_core_device, vdev) == 0);
+
+// SAFETY: `vdev` is the first field of `vfio_pci_core_device`, as asserted above, and the
+// returned pointer is derived from `raw`.
+unsafe impl RawDevice for bindings::vfio_pci_core_device {
+    unsafe fn raw_vfio_device(raw: *mut Self) -> *mut bindings::vfio_device {
+        // SAFETY: The caller guarantees that `raw` points to a live `Self`.
+        unsafe { &raw mut (*raw).vdev }
+    }
+}
+
+impl<T: Operations> Device<T> {
+    /// Allocate a VFIO PCI device for subsequent registration.
+    pub fn new(pdev: &pci::Device<device::Core<'_>>) -> Result<ARef<Self>> {
+        Self::allocate(pdev, false)
+    }
+
+    /// Allocate a device whose physical BARs may also be exported as DMA buffers.
+    pub fn new_passthrough(pdev: &pci::Device<device::Core<'_>>) -> Result<ARef<Self>> {
+        Self::allocate(pdev, true)
+    }
+
+    fn allocate(pdev: &pci::Device<device::Core<'_>>, passthrough: bool) -> Result<ARef<Self>> {
+        let size = Kmalloc::aligned_layout(Layout::new::<Self>()).size();
+
+        // SAFETY: The bound PCI device and static ops are valid. The allocation
+        // includes the full Rust wrapper with kmalloc-compatible size and alignment.
+        let raw = from_err_ptr(unsafe {
+            bindings::_vfio_alloc_device(size, pdev.as_ref().as_raw(), &Self::OPS)
+        })?;
+        let this = NonNull::new(raw.cast::<Self>()).ok_or(ENOMEM)?;
+
+        // SAFETY: `vfio_pci_core_init_dev()` initialized the C device in this new allocation,
+        // which nothing else can access yet.
+        unsafe { Self::init(this.as_ptr()) };
+
+        if passthrough {
+            // SAFETY: No registration or callbacks can observe this allocation yet.
+            unsafe { (*this.as_ref().as_raw()).pci_ops = &Self::PASSTHROUGH_OPS };
+        }
+
+        // SAFETY: `this` owns the initial VFIO device reference.
+        Ok(unsafe { ARef::from_raw(this) })
+    }
+}
+
+impl<T: Operations, Ctx: IoContext> Device<T, Ctx> {
+    /// Accesses the registration data and the open data from an I/O callback.
+    ///
+    /// The data lifetimes stay independent of the callback borrow, so that borrowed data
+    /// cannot be stored back into the registration data or the open data.
+    fn callback_data_with<V, F>(&self, f: F) -> V
+    where
+        F: for<'a, 'data> FnOnce(&T::RegistrationData<'data>, Pin<&T::OpenData<'a, 'data>>) -> V,
+    {
+        // SAFETY: `f` is generic over the lifetimes of the data, so it uses the data
+        // parametrically.
+        let (reg_data, open_data) = unsafe { self.callback_data() };
+        f(reg_data, open_data)
+    }
+}
+
+impl<T: Operations> Device<T, Open> {
+    /// Set the device ID exposed through VFIO's virtual PCI configuration space.
+    pub fn set_device_id(&self, device_id: u16) {
+        // SAFETY: core_enable allocated vconfig; the exclusive first-open callback
+        // runs before finish_enable publishes the configuration to userspace.
+        unsafe {
+            (*self.as_raw())
+                .vconfig
+                .add(bindings::PCI_DEVICE_ID as usize)
+                .cast::<u16>()
+                .write_unaligned(device_id.to_le());
+        }
+    }
+}
+
+impl<T: Operations> Device<T, Ioctl> {
+    /// Delegate to `vfio_pci_core_ioctl()`.
+    pub fn core_ioctl(&self, cmd: u32, arg: usize) -> Result<isize> {
+        // SAFETY: The Ioctl context keeps this device open on the callback thread.
+        let ret = unsafe { bindings::vfio_pci_core_ioctl(self.as_raw_vfio(), cmd, arg) };
+        if ret < 0 {
+            Err(Error::from_errno(ret as i32))
+        } else {
+            Ok(ret)
+        }
+    }
+}
+
+impl<T: Operations> Device<T, Read> {
+    /// Delegate to `vfio_pci_core_read()`.
+    ///
+    /// The VFIO core fills the user-space buffer with the default PCI data
+    /// for the region identified by `ppos` and advances the position by the bytes read.
+    pub fn core_read(&self, buf: &UserBuf, ppos: &mut Position<'_>) -> Result<isize> {
+        // SAFETY: The Read context keeps this device open on the callback thread;
+        // `buf.ptr` is a user-space pointer supplied by VFIO.
+        let ret = unsafe {
+            bindings::vfio_pci_core_read(
+                self.as_raw_vfio(),
+                buf.ptr.as_mut_ptr().cast(),
+                buf.count,
+                ppos.raw,
+            )
+        };
+        if ret < 0 {
+            Err(Error::from_errno(ret as i32))
+        } else {
+            Ok(ret)
+        }
+    }
+}
+
+impl<T: Operations> Device<T, Write> {
+    /// Delegate to `vfio_pci_core_write()` for this callback's bounded buffer.
+    pub fn core_write(&self, buf: &UserBuf, ppos: &mut Position<'_>) -> Result<isize> {
+        // SAFETY: The Write context keeps the device open on the callback thread;
+        // the buffer is a userspace pointer supplied by VFIO.
+        let ret = unsafe {
+            bindings::vfio_pci_core_write(
+                self.as_raw_vfio(),
+                buf.ptr.as_const_ptr().cast(),
+                buf.count,
+                ppos.raw,
+            )
+        };
+        if ret < 0 {
+            Err(Error::from_errno(ret as i32))
+        } else {
+            Ok(ret)
+        }
+    }
+}
+
+impl<T: Operations> Device<T, Mmap> {
+    /// Delegate to `vfio_pci_core_mmap()` for the current callback's VMA.
+    pub fn core_mmap(&self, mapping: &mut Mapping<'_>) -> Result {
+        // SAFETY: The Mmap context and Mapping keep the open device and locked VMA
+        // on the callback thread. The VMA cannot be replaced by driver code.
+        to_result(unsafe { bindings::vfio_pci_core_mmap(self.as_raw_vfio(), mapping.vma.as_ptr()) })
+    }
+}
+
+impl<T: Operations> Device<T, GetRegionInfo> {
+    /// Delegate to `vfio_pci_ioctl_get_region_info()`.
+    pub fn core_get_region_info(
+        &self,
+        info: &mut bindings::vfio_region_info,
+        caps: &mut InfoCap<'_>,
+    ) -> Result {
+        // SAFETY: GetRegionInfo keeps the device open on the callback thread;
+        // `InfoCap` preserves the validity of VFIO's capability buffer.
+        to_result(unsafe {
+            bindings::vfio_pci_ioctl_get_region_info(self.as_raw_vfio(), info, caps.raw)
+        })
+    }
+}
+
+/// # Safety
+///
+/// `vdev` must belong to a registered `Device<T>` in VFIO's first-open context.
+/// VFIO must exclude other opens, closes and I/O callbacks for this call.
+unsafe extern "C" fn open_device_cb<T: Operations>(vdev: *mut bindings::vfio_device) -> c_int {
+    // SAFETY: `vdev` belongs to a live `Device<T>`; VFIO provides the first-open context.
+    let dev = unsafe { Device::<T, Open>::from_raw_vfio(vdev) };
+
+    // SAFETY: Enable the PCI-core side first.
+    let ret = unsafe { bindings::vfio_pci_core_enable(dev.as_raw()) };
+    if ret != 0 {
+        return ret;
+    }
+
+    // SAFETY: The previous last close destroyed any earlier open data. The open data type
+    // passed is `T::OpenData`, which only differs in lifetimes from the one of `Device<T>`.
+    // `T::open_device()` is generic over the lifetimes of its arguments, and the closure
+    // captures nothing but `dev`, which it passes on with the same lifetime as the
+    // registration data. `close_device_cb()` destroys the open data at the last close.
+    let result = unsafe {
+        dev.open::<T::OpenData<'_, 'static>, _>(|reg_data| T::open_device(dev, reg_data))
+    };
+    match result {
+        Ok(()) => {
+            // SAFETY: open succeeded.
+            unsafe { bindings::vfio_pci_core_finish_enable(dev.as_raw()) };
+            0
+        }
+        Err(e) => {
+            // SAFETY: Undo the enable on failure.
+            unsafe { bindings::vfio_pci_core_disable(dev.as_raw()) };
+            e.to_errno()
+        }
+    }
+}
+
+/// # Safety
+///
+/// `vdev` must belong to a registered `Device<T>` whose first open succeeded.
+/// Call exactly once for the last close, after draining I/O callbacks and while
+/// excluding the next first open.
+unsafe extern "C" fn close_device_cb<T: Operations>(vdev: *mut bindings::vfio_device) {
+    // SAFETY: `vdev` belongs to a live `Device<T>`.
+    let dev = unsafe { Device::<T>::from_raw_vfio(vdev) };
+    // SAFETY: Last close drains I/O callbacks and excludes the next first open.
+    // Registration data and PCI resources remain valid while open data is destroyed.
+    unsafe { dev.close() };
+    // SAFETY: Matches the enable in open_device_cb.
+    unsafe { bindings::vfio_pci_core_close_device(vdev) };
+}
+
+/// # Safety
+///
+/// `vdev` must belong to a registered, open `Device<T>` in VFIO's ioctl callback
+/// context. Registration and open data must remain alive until the call returns.
+unsafe extern "C" fn ioctl_cb<T: Operations>(
+    vdev: *mut bindings::vfio_device,
+    cmd: core::ffi::c_uint,
+    arg: usize,
+) -> isize {
+    // SAFETY: `vdev` belongs to a live `Device<T>`; VFIO provides the ioctl context.
+    let dev = unsafe { Device::<T, Ioctl>::from_raw_vfio(vdev) };
+    match dev.callback_data_with(|rd, od| T::ioctl(dev, rd, od, cmd, arg)) {
+        Ok(v) => v,
+        Err(e) => e.to_errno() as isize,
+    }
+}
+
+/// # Safety
+///
+/// `vdev` must belong to a registered, open `Device<T>` in VFIO's read context.
+/// `buf` must be a userspace address and `ppos` must be exclusively accessible
+/// for this call. Registration and open data must remain alive until it returns.
+unsafe extern "C" fn read_cb<T: Operations>(
+    vdev: *mut bindings::vfio_device,
+    buf: *mut u8,
+    count: usize,
+    ppos: *mut i64,
+) -> isize {
+    // SAFETY: `vdev` belongs to a live `Device<T>`; VFIO provides the read context.
+    let dev = unsafe { Device::<T, Read>::from_raw_vfio(vdev) };
+    let mut ubuf = UserBuf {
+        ptr: UserPtr::from_ptr(buf.cast()),
+        count,
+    };
+    let mut pos = Position {
+        // SAFETY: `ppos` is a valid kernel pointer provided by the VFIO core.
+        raw: unsafe { &mut *ppos },
+    };
+    match dev.callback_data_with(|rd, od| T::read(dev, rd, od, &mut ubuf, &mut pos)) {
+        Ok(n) => n,
+        Err(e) => e.to_errno() as isize,
+    }
+}
+
+/// # Safety
+///
+/// `vdev` must belong to a registered, open `Device<T>` in VFIO's region-info
+/// context. `info` and `caps` must be valid, disjoint, exclusively accessible
+/// objects; the capability buffer must satisfy the VFIO core's invariants.
+/// Registration and open data must remain alive until the call returns.
+unsafe extern "C" fn get_region_info_cb<T: Operations>(
+    vdev: *mut bindings::vfio_device,
+    info: *mut bindings::vfio_region_info,
+    caps: *mut bindings::vfio_info_cap,
+) -> c_int {
+    // SAFETY: `vdev` belongs to a live `Device<T>`; VFIO provides the region-info context.
+    let dev = unsafe { Device::<T, GetRegionInfo>::from_raw_vfio(vdev) };
+    // SAFETY: `info` is a valid pointer provided by the VFIO core.
+    let info = unsafe { &mut *info };
+    let mut caps = InfoCap {
+        // SAFETY: `caps` is a valid pointer provided by the VFIO core.
+        raw: unsafe { &mut *caps },
+    };
+    match dev.callback_data_with(|rd, od| T::get_region_info(dev, rd, od, info, &mut caps)) {
+        Ok(()) => 0,
+        Err(e) => e.to_errno(),
+    }
+}
+
+/// # Safety
+///
+/// `vdev` must belong to a registered, open `Device<T>` in VFIO's write context.
+/// `buf` must be a userspace address and `ppos` must be exclusively accessible
+/// for this call. Registration and open data must remain alive until it returns.
+unsafe extern "C" fn write_cb<T: Operations>(
+    vdev: *mut bindings::vfio_device,
+    buf: *const u8,
+    count: usize,
+    ppos: *mut i64,
+) -> isize {
+    // SAFETY: `vdev` belongs to a live `Device<T>`; VFIO provides the write context.
+    let dev = unsafe { Device::<T, Write>::from_raw_vfio(vdev) };
+    let mut ubuf = UserBuf {
+        ptr: UserPtr::from_ptr(buf.cast_mut().cast()),
+        count,
+    };
+    let mut pos = Position {
+        // SAFETY: VFIO holds the file-position lock when required.
+        raw: unsafe { &mut *ppos },
+    };
+    match dev.callback_data_with(|rd, od| T::write(dev, rd, od, &mut ubuf, &mut pos)) {
+        Ok(n) => n,
+        Err(e) => e.to_errno() as isize,
+    }
+}
+
+/// # Safety
+///
+/// `vdev` must belong to a registered, open `Device<T>` in VFIO's mmap context.
+/// `vma` must be the valid VMA being mapped, with the mmap write lock held on
+/// this thread. Registration and open data must remain alive until return.
+unsafe extern "C" fn mmap_cb<T: Operations>(
+    vdev: *mut bindings::vfio_device,
+    vma: *mut bindings::vm_area_struct,
+) -> c_int {
+    // SAFETY: `vdev` belongs to a live `Device<T>`; VFIO provides the mmap context.
+    let dev = unsafe { Device::<T, Mmap>::from_raw_vfio(vdev) };
+    let mut mapping = Mapping {
+        // SAFETY: The mmap callback holds the mmap lock for this VMA.
+        vma: unsafe { VmaRef::from_raw(vma) },
+        _not_thread_safe: NotThreadSafe,
+    };
+    match dev.callback_data_with(|rd, od| T::mmap(dev, rd, od, &mut mapping)) {
+        Ok(()) => 0,
+        Err(e) => e.to_errno(),
+    }
+}
+
+/// Build the `vfio_device_ops` vtable for a variant driver `T`.
+///
+/// Open and I/O callbacks dispatch to `T`'s trait implementation.
+/// All other callbacks use the `vfio_pci_core_*` defaults.
+macro_rules! build_ops {
+    ($T:ty) => {
+        bindings::vfio_device_ops {
+            #[allow(clippy::disallowed_methods)]
+            name: <$T>::NAME.as_ptr().cast_mut().cast(),
+            init: Some(bindings::vfio_pci_core_init_dev),
+            release: Some(bindings::vfio_pci_core_release_dev),
+            open_device: Some(open_device_cb::<$T>),
+            close_device: Some(close_device_cb::<$T>),
+            ioctl: Some(ioctl_cb::<$T>),
+            read: Some(read_cb::<$T>),
+            write: Some(write_cb::<$T>),
+            mmap: Some(mmap_cb::<$T>),
+            request: Some(bindings::vfio_pci_core_request),
+            get_region_info_caps: Some(get_region_info_cb::<$T>),
+            match_: Some(bindings::vfio_pci_core_match),
+            match_token_uuid: Some(bindings::vfio_pci_core_match_token_uuid),
+            device_feature: Some(bindings::vfio_pci_core_ioctl_feature),
+            #[cfg(CONFIG_IOMMUFD)]
+            bind_iommufd: Some(bindings::vfio_iommufd_physical_bind),
+            #[cfg(not(CONFIG_IOMMUFD))]
+            bind_iommufd: None,
+            #[cfg(CONFIG_IOMMUFD)]
+            unbind_iommufd: Some(bindings::vfio_iommufd_physical_unbind),
+            #[cfg(not(CONFIG_IOMMUFD))]
+            unbind_iommufd: None,
+            #[cfg(CONFIG_IOMMUFD)]
+            attach_ioas: Some(bindings::vfio_iommufd_physical_attach_ioas),
+            #[cfg(not(CONFIG_IOMMUFD))]
+            attach_ioas: None,
+            #[cfg(CONFIG_IOMMUFD)]
+            detach_ioas: Some(bindings::vfio_iommufd_physical_detach_ioas),
+            #[cfg(not(CONFIG_IOMMUFD))]
+            detach_ioas: None,
+            #[cfg(CONFIG_IOMMUFD)]
+            pasid_attach_ioas: Some(bindings::vfio_iommufd_physical_pasid_attach_ioas),
+            #[cfg(not(CONFIG_IOMMUFD))]
+            pasid_attach_ioas: None,
+            #[cfg(CONFIG_IOMMUFD)]
+            pasid_detach_ioas: Some(bindings::vfio_iommufd_physical_pasid_detach_ioas),
+            #[cfg(not(CONFIG_IOMMUFD))]
+            pasid_detach_ioas: None,
+            dma_unmap: None,
+        }
+    };
+}
+
+/// The registration of a VFIO PCI variant device.
+///
+/// Owns both the VFIO device reference and the registration data, tying
+/// resource lifetimes to the PCI binding scope `'a`. The device is registered
+/// on construction and unregistered when the `Registration` is dropped.
+pub struct Registration<'a, T: Operations> {
+    dev: ARef<Device<T>>,
+    reg_data: Pin<KBox<T::RegistrationData<'a>>>,
+    // Released after `Drop::drop()` has unregistered `dev`.
+    _active: RuntimeActive,
+}
+
+/// Keeps the PCI device of a registered VFIO device runtime active.
+///
+/// The VFIO PCI core allows runtime suspend of the PCI device while its VFIO device is
+/// registered, and expects the PCI driver's runtime PM callbacks to call into the VFIO PCI
+/// core. These abstractions do not provide such callbacks yet, so the device must not be
+/// runtime suspended.
+///
+/// # Invariants
+///
+/// This type owns a runtime PM usage reference on the device.
+// TODO: Do not hold this reference for drivers that provide runtime PM callbacks, once these
+// abstractions support them.
+struct RuntimeActive(#[cfg_attr(not(CONFIG_PM), expect(dead_code))] ARef<device::Device>);
+
+impl RuntimeActive {
+    fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
+        // SAFETY: `dev` is a valid device. This is `pm_runtime_get_sync()`, which takes a usage
+        // reference even if it fails.
+        #[cfg(CONFIG_PM)]
+        let ret =
+            unsafe { bindings::__pm_runtime_resume(dev.as_raw(), bindings::RPM_GET_PUT as c_int) };
+        #[cfg(not(CONFIG_PM))]
+        let ret = 0;
+        // INVARIANT: `this` owns the usage reference, and drops it if the resume failed.
+        let this = Self(dev.into());
+        to_result(ret)?;
+        Ok(this)
+    }
+}
+
+impl Drop for RuntimeActive {
+    fn drop(&mut self) {
+        // SAFETY: `self.0` is a valid device, and `new()` took the usage reference dropped
+        // here. This is `pm_runtime_put()`.
+        #[cfg(CONFIG_PM)]
+        unsafe {
+            bindings::__pm_runtime_idle(
+                self.0.as_raw(),
+                (bindings::RPM_GET_PUT | bindings::RPM_ASYNC) as c_int,
+            )
+        };
+    }
+}
+
+impl<T: Operations> Device<T> {
+    const OPS: bindings::vfio_device_ops = build_ops!(T);
+
+    const PASSTHROUGH_OPS: bindings::vfio_pci_device_ops = bindings::vfio_pci_device_ops {
+        #[cfg(CONFIG_VFIO_PCI_DMABUF)]
+        get_dmabuf_phys: Some(bindings::vfio_pci_core_get_dmabuf_phys),
+        #[cfg(not(CONFIG_VFIO_PCI_DMABUF))]
+        get_dmabuf_phys: None,
+    };
+}
+
+impl<'a, T: Operations> Registration<'a, T> {
+    /// Register a previously allocated VFIO PCI device with its callback data.
+    ///
+    /// `dev` must have been allocated for `pdev`, and can be registered only once. `D` is the
+    /// PCI driver bound to `pdev`.
+    ///
+    /// # Safety
+    ///
+    /// The returned `Registration` must be stored in the bus device private data of `D`, the
+    /// driver bound to `pdev`, and must not be leaked: it has to be dropped while that driver
+    /// is being unbound from `pdev`, or when its probe fails.
+    pub unsafe fn new<D: pci::Driver>(
+        pdev: &'a pci::Device<device::Core<'_>>,
+        dev: &Device<T>,
+        reg_data: impl PinInit<T::RegistrationData<'a>, Error>,
+    ) -> Result<Self> {
+        build_assert!(
+            D::DRIVER_MANAGED_DMA.is_some(),
+            "VFIO drivers must manage DMA ownership"
+        );
+        build_assert!(
+            !D::HAS_SRIOV_ENABLE && !D::HAS_SRIOV_DISABLE,
+            "VFIO PCI variant drivers do not support SR-IOV configuration"
+        );
+
+        // SAFETY: `dev` holds a live VFIO allocation; only compare its parent pointer.
+        if unsafe { (*dev.as_raw_vfio()).dev } != pdev.as_ref().as_raw() {
+            return Err(EINVAL);
+        }
+
+        let reg_data: Pin<KBox<T::RegistrationData<'a>>> = KBox::pin_init(reg_data, GFP_KERNEL)?;
+        let ptr: NonNull<T::RegistrationData<'static>> =
+            NonNull::from(Pin::get_ref(reg_data.as_ref())).cast();
+
+        // SAFETY: `dev` belongs to `pdev`, whose device lock serializes publication. The
+        // returned `Registration` keeps the pinned data alive until it has unregistered `dev`;
+        // if registration fails below, `dev` remains unregistered and never accesses the data.
+        unsafe { dev.publish_registration_data(ptr) }?;
+
+        // Registering `dev` allows runtime suspend of `pdev`; see `RuntimeActive`.
+        let active = RuntimeActive::new(pdev.as_ref())?;
+
+        // SAFETY: `dev` is initialized, has published its registration data and has not been
+        // registered before. The caller holds the PCI device lock of its parent.
+        to_result(unsafe { bindings::vfio_pci_core_register_device(dev.as_raw()) })?;
+
+        Ok(Self {
+            dev: dev.into(),
+            reg_data,
+            _active: active,
+        })
+    }
+
+    /// Prepare the variant driver's state for a PCI reset.
+    pub fn reset_prepare(&self) {
+        T::reset_prepare(&self.reg_data);
+    }
+
+    /// Complete the variant driver's state update after a PCI reset.
+    pub fn reset_done(&self) -> Result {
+        T::reset_done(&self.reg_data)
+    }
+
+    /// Signal the VFIO error interrupt and return the PCI recovery result.
+    pub fn error_detected(&self) -> pci::ErsResult {
+        // SAFETY: This owner keeps the initialized VFIO core device alive.
+        let result = unsafe { bindings::vfio_pci_core_aer_err_detected(self.dev.as_raw()) };
+        // The VFIO PCI core only returns results `pci::ErsResult` represents.
+        pci::ErsResult::from_raw(result).unwrap_or(pci::ErsResult::None)
+    }
+}
+
+impl<T: Operations> Drop for Registration<'_, T> {
+    fn drop(&mut self) {
+        // SAFETY: `new()` registered the device. By its safety requirements, this runs with the
+        // PCI device lock held, either from the PCI remove callback or while probe fails.
+        // Unregistration drains the VFIO callbacks, the only users of the registration data
+        // besides this owner, before the data is released.
+        unsafe { bindings::vfio_pci_core_unregister_device(self.dev.as_raw()) };
+    }
+}
-- 
2.43.7

