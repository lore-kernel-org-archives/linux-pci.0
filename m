Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795125102;
	b=DvIuPqE4ao9TQ0YRG2xiVhEl0QAZhaMqT6lN0Bz8DPio6MQr+N02mOOCRdiRPeQUFzfd
	 aAXQS2bYy+iHoTmUMKL/Gfmat9dcYcjUN8ckyw7LphrhWm9lC+AXrabHuj84gBVHqswqb
	 W/N6vtaqIqLn/dJP6ol7zFoeTV1jA23vq8KDcD36s/Cx8QcAsbqj44M7g3ADkTeER1hbC
	 bv3RuX/FiTNXUqN3Kj7Ah7y+GHyRalgXK2m1HMC798p+ox0L4VsqhPKR454SIi0yMfWjs
	 nY4JVWaDM2EMrhXuMpvwj/WzhIKm+1dj6iN8GP2mf9QcUYP2iujY3eaRwFKIB7DopNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125102;
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
	bh=6o9bhW8wsOAIhuGp90K6EKBhtONIi3POQwWye2/rpog=;
	b=f/5E9TSLVVSTKqZrq/3koQXi7UemvGzEmUqrLUo5LbX4cXdkftTk4kbN+0ipc2WWFOV4
	 iXlET04U+f5BxDkJHYOWzQTUtrDYerpZG92NfqjhULg4+ElcczJn0jQXqHrqRxn4FLmEa
	 T2dhpdQQzvGc69YMYhfOdnR7+vTNg2Hiw1decE88Lj+v2Sv88vDiCN1TB5WI/4RRB8YdH
	 zyfFIpvEyClqJ3oVlkB88h1NRGo8bLzL0Lz8jU5Yf3lpcMrpmBViVcR8m68cOrFthGput
	 BYj18GHR3WSzJ7EDD5zaRVQAXbHHKMp1Tmqv1NExFUZokgHepPhE7w4f0SUNiICkW3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=riAMdQGn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.15
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479AC60A2608;
	Thu, 19 Nov 2026 21:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 479AC60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=riAMdQGn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CugFW7Fjtj8p3lkiSZT6paq2yXu8aWrBKY/0wuuqEGiSF5ares02n6jSS4LhR/eEiPEDK9AfwIBg5oQ1wcynYXIzM1RUOBJasXYZml6qABflOQNJus0XSZ8yHasITWfL+E2OXL4m8bkIE+xQU4XsL4ZVlRtnwnt4Bf54wR8EUR7l5o/JfSszzVBtaJaQsjxCJjCCviNEebhoBI+Q6/+DfQYbHfaT0DXwkV1W3R5KqP+XTz1voJmQWIc7Lho0qptx3q+i9Q5CAw9m4iNIAJjjB7PdDeoavuGxV5H+DV3qwTLTSRbHqb44Y6ZHNY7AVGQWpgkRJR4pfDYgIcUNDDvtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o9bhW8wsOAIhuGp90K6EKBhtONIi3POQwWye2/rpog=;
 b=O0zY4Q7N9tHCUubbSsFeWpP/3vbA86DumZBhS2OzyjSI+KCZkZmiRJTz0Fj3mTBTNJGVkoaByXHl5xGcYoQbkF7XTvUde988mm+2KSW8HTp8laOQrrv/SYvxWwLEHOMyKIE8pfA0d3Js97P1PVrCWkAOIYinqPKfLSjxGyqDEB5L+o34bFAIICdriDiXrAHUAIHrIPZmfxq1OBVsBzZ8jISfHNiULbMX9fsYVzUp1GicHfNWrP9O2tWvZquSGt5MgztLgoER4VuvO9uqNurSbd1YM6jebIYWs/IxzUw6sPE/G0Q3NTKvPK07J3J3gfH1U4Vgsz7li2BkWtTcIZfBQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6o9bhW8wsOAIhuGp90K6EKBhtONIi3POQwWye2/rpog=;
 b=riAMdQGnREZlCJMGrghVnTix1XUa38wvf3X9lLgqqpUtbq1D3qtkggp4CGP0i9VyTaM9Zgczi8WJjx6qQVTBxd7a0NUL6LjN/gr3MnmDBcScWw0CI9E0eSSnkLLh+lMFNFHLnFhy+M4IL4fupcqtIIWQdmLkzUmKrPT7m41T1KG6DMR7yh2ZEus2O9bqeHzh7l6ZlAP82Gn7QHrBQArE+OVnDzBSbALJRIHVJMMCX6zSkP5i0IpE4zGxjkP3lutmugvhfmL/z3iqiCnJKp8Zr058vonrEV3FCuNe0324jNFIw0CT30/ostneJLMHG6OGuWmKHpnVC5qbcv0jbhuGmQ==
Received: from MW4PR04CA0223.namprd04.prod.outlook.com (2603:10b6:303:87::18)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 21:51:37 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::58) by MW4PR04CA0223.outlook.office365.com
 (2603:10b6:303:87::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 21:51:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 21:51:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:51:11 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 13:51:09 -0800
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
Subject: [PATCH v3 3/9] rust: pci: allow drivers to manage DMA ownership
Date: Thu, 19 Nov 2026 13:50:38 -0800
Message-ID: <20261119215046.2892839-4-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b591c2-8414-4082-be3c-08df468748c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|23010399003|6133799003|22082099003|18002099003|261009223027099003|261022115727099003|56012099006|11063799006|261102123227099003|261026121527099003|261021130227099003|261028144727099003|261022105027099003|261021121427099003|261026140227099003|261022113327099003|10067099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	QfnbcTfXAax130Hzz3KUgyBRsLusMkf20Ne6E0A5WRHMV73jiyLhccxR/WpZW52JC4ke3mNEVXYFE6nxlisUeZaBZ+XEdCf8LJ4n7pNo0DlYazrgXJw3vZKet/bVcivfYmLrwmM0lg9zQweFWCCNHdJoKtVV56PLpx5vPgMSU/gqyDLZ0MwGN6tn/Scsqxa8iFqhq/Jia0ljPEs3oPJvmy7uCGZXM7CqQcQLqShyUezfKHrI4DMLYVCKMdx1e4SPiVkfcH0ac7t7t1mUMFWNMsQbsjBPdlyJQ8+Dk/5Hj5OAE6Vi7Q/OjZKxsXWwcysQw5r8eUUMfPGjLbUG4T7hDIDm8nz+iQ1UUgiscnhS+uNXPUfsY+MTUajQZYa/hUOweQmm9x02DDe3HdrxNlTgIdyDbPwpj/BTXujvm0NbLWeTxmUDzYV/gxBxC/QNfWaajLdBhTSIjLM1R/O1dDJXOORjm2st6v4gRW0BlkJE2jypZsjuJZ3g/5moZJgg0KQRjbuy4L2RVQP6e16amqPXVGY8J6g50k8d9m1pNXYs3cVzcKEO7kasrtSwVIrOgL+OYcoVi4FIMIYDS7mXhTztqAHcPbqJGBDHn7cYmDDVCU4Bv67pAJVJ//I1EBRclZ/DRkvllGL0aLg1MFpW21zu/ex23A/ZgzG8qrO9RXscXRjDuJczLXYKITdvVzC+DhW9FCXePxBKc819mt4M4DUGGg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(261009223027099003)(261022115727099003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261021130227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261022113327099003)(10067099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lcNTWsD4pZnlb+qn/fPRtvrO0cPgn6AhjzEWx/3rUQ/aKR3k/tTJMlgE6S0BOpigDzpoO0hGo0PlhxC6oZg/RGUcJXa2uxAVj/cYar0UHALWQ+e9CI03F2jUpIDohJYcjjVjxMx+GNpCDRCG41o7OlVreoIMFKbxP+s+K6iUjbpkhwfdPk6mmSBNPcWfKg/JhdbUQZGFagABVrJ1aagOyoL9X7Qm+wQNCR0V1lnElYfbqiwVhPiAUAimUoQVQ4/zz9NqR5oGXobgtfXxuYjRasWAGRmyr1sVXJF1OEYeEajBrm9mXSEqr7K9az8jyHF3CuftD0HZoi5aZaI2Tj66ny9V3+GEVujODWd6bCR2UzjQNlKOVYmM05eQ5g8B2egKwg9O4GMDbtOiWLnMCX+1xWpFQILUhuF4fENNeD6d5tffO72ubhCZKNc80TmYrwxe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:51:36.4904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b591c2-8414-4082-be3c-08df468748c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

From: Danilo Krummrich <dakr@kernel.org>

VFIO manages DMA ownership through the userspace IOMMU interface. Its
PCI variant drivers must opt out of the driver's default DMA domain.

Add Driver::DRIVER_MANAGED_DMA and pass it to the PCI core. Make it an
unsafe marker as suggested, until the DMA setup tokens exist.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index fa67f2fc26bf..6013c89bfb5e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -105,6 +105,7 @@ unsafe fn register(
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*pdrv.get()).driver_managed_dma = T::DRIVER_MANAGED_DMA.is_some();
             if T::HAS_SRIOV_ENABLE {
                 (*pdrv.get()).sriov_configure = Some(Self::sriov_configure_callback);
             }
@@ -293,6 +294,24 @@ unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::pci_device_id, driver_data);
 }
 
+/// Marker for a driver that manages DMA ownership of its devices by itself.
+///
+/// The driver core does not claim the default DMA domain for the devices of such a driver. See
+/// [`Driver::DRIVER_MANAGED_DMA`].
+pub struct DriverManagedDma<D: ?Sized>(PhantomData<fn() -> *mut D>);
+
+impl<D: ?Sized> DriverManagedDma<D> {
+    /// Declares that driver `D` manages DMA ownership of its devices by itself.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that devices bound to `D` are not used for DMA allocations or
+    /// mappings through the kernel DMA API, directly or through helpers.
+    pub const unsafe fn new() -> Self {
+        Self(PhantomData)
+    }
+}
+
 /// `IdTable` type for PCI.
 pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
 
@@ -356,6 +375,10 @@ pub trait Driver {
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
 
+    /// Set if the driver manages DMA ownership of its devices by itself, instead of using the
+    /// default DMA domain. Construct with [`DriverManagedDma::new`].
+    const DRIVER_MANAGED_DMA: Option<DriverManagedDma<Self>> = None;
+
     /// PCI driver probe.
     ///
     /// Called when a new pci device is added or discovered. Implementers should
-- 
2.43.7

