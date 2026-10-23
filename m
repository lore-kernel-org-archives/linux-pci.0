Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770082;
	b=Jeiyf8EO33df77tmrivUFegVIvH8VZkezf1Elr84NTwOFnEgIoFzYVSPWrqExdN7F8GO
	 UPGiCFH/H9S2gjXidq/7XZy2N/F6HR430yU6ERNZMig+5mnM9gLVnXlC9aNo4vaWITkVK
	 s405fpLQbrwe83WuHTlxjbmf9ysL3huYy2pL4qa26epeNNBBzHq+52QAtVGI6/+NQJ5Jm
	 AuEDX2MVS5/S36XTuDOEP2FaLw4OGuYXzyKuGbWV8j1sYJjTyo+vVQ0IlkYO0+WCNOCIE
	 yeuhY9OT9C7MahrL1iH5V1aX11dmkEmwTVLpQV1qtd8hvU1t7gdUVJnAPm/2Ia1DXLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770082;
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
	bh=eBR3Pqe3Pyee5roLi63owH40AL/NWUQhGTuxpN3BGEA=;
	b=kJC/cziTqK3KvpIXy28hE3ZhRL62X+6RhUGJQVHlzcVU1EbtyNc31Z+wUpd1flY0ukJX
	 u3masJLUh2joj82MTZjEqXqHbywRf1bZKyLn1b8lQr0rLlCMo05MOUTuDzG9UaS6LXrWO
	 f6pdpqzKBpg/FDrcuiD8mi69o29qPc+jVW+qNr2O0LIhPZY/1w0CXbnhz9X/TJfbbDild
	 L67trsADPLPeSs1OWbcnGj3TjVsAP16/koz6GbLWEOmag1gEOsNaLu2FtiAvzTxBR852y
	 gytLZfgxVCXwxYmqsQIqrYxERV2uWfEoZXXKuTCSF2oA/WD1PD2bo6Qeu8PpdQ2RZFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="j2L2/ww6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.28
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A44D606A33D;
	Fri, 23 Oct 2026 15:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A44D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=j2L2/ww6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5E5Ai6gyxiJX0vcY2lM2ocb92WVGD4C1wnPZe7qBfZs1RhNCoFNWzw1bB/ErwGsOY9JJpZQTEPEsHHFrHTw2ZrMlTLdI1tLBH6q30V7RHcIJpUlamFI3n+7RQG1yd7cW/apVNcVptGuM5s+0Ql5ipWaN0occm8O6xJINzoyR5RsJTptn/8Jv6Oa1fNJTEEVxAIcskRQfgZrUgBJcf7vRcB0ucaZHLsiFnOkhDWkQ5V26/Ucb8Zmp15hmHZZ8EbbVI5xagwG39cX/WmvelsQLmsZ+mcS/fLVb0Wsw8uwHlsG9GmdfcbePQXAK4pEoFZrC7ua946kucU8JtjMV4oeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBR3Pqe3Pyee5roLi63owH40AL/NWUQhGTuxpN3BGEA=;
 b=cofGUVwB4Du9TD0VuqqhgCsBBZiNZntJQ/8TdBgY12+h+9WG5rnbRr8XT/Yzav8Xuhyng15D9sWncyt2PnXm0TaGr7Qun56QooMqt3ZNgwy/mm+Cuo/8Wv7BgYG3icLVRgmuFIfBHTwKp7ffCp617Xbug8414/hmMAmDH+5BAaEgzkA8F3NgN+9AOSnLc217dA80zdmP0yJ6FB6umMZAPwGXao/7Tbn4xBQ2G/zYhHnwn/kE9Sq1Au9Cntqq+UHTXzK87FDfFh3aF6GvQh2G+OHa6WzF4ptmDKBXMFa0G6pRfc/NJ0cTfndxGjtWhiGYylN6vCOrks2O7dHL1RdMcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBR3Pqe3Pyee5roLi63owH40AL/NWUQhGTuxpN3BGEA=;
 b=j2L2/ww6zTgIOj3rXfdpv0eV3eAExSUPQAdLzGg3XlbSLI/XcXmkKxG7KxTUkuzgdWihh8TMl81IcYAJffC1A6pEGeOh4RfizCN7MoYjzdLZVf4x/q899lg9JvSPEfEvSmxTwuQOECQiOfy/N/Rq1H3NoGS5BBdCMXRMIt4Cw3C2LhwAOdjcpI5Nq9v/uILv0oELpHTsjt2uaivA7RcWGHJBUd+sn6c74TSKnzDK18thoNrU0WzvVIvT2TJf0Suz4SY4OJRf6rrViV8HfCtRFN2Y85bDKdHxEH9T8YApAVqA8t6CZkzLUrVSqky/VIqzKtEBuq3K9NSbRhUIYgs//w==
Received: from SJ0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:33a::28)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Fri, 23 Oct
 2026 15:41:12 +0000
Received: from CO1PEPF0001885E.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::20) by SJ0PR03CA0023.outlook.office365.com
 (2603:10b6:a03:33a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Fri,
 23 Oct 2026 15:41:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF0001885E.mail.protection.outlook.com (10.167.249.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 15:41:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 08:40:49 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 23 Oct 2026 08:40:47 -0700
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
Subject: [PATCH v2 09/12] rust: vfio: use the PCI adapter for variant drivers
Date: Fri, 23 Oct 2026 08:40:04 -0700
Message-ID: <20261023154009.2246627-10-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885E:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf7f2df-f859-43cd-01c3-08df311c1117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|7416014|36860700016|261021121427099003|11063799006|261021123027099003|56012099006|10067099003|3023799007|261009223027099003|22082099003|18002099003|6133799003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	Nafwm4Cugi71zuUJfvURc7u34Fn/qytJue64AqD0kwkzHo3M9mw/64kx8Q1trxBiQAXhjz9sp4ZdJSlhzxtMH2Vbn5WjfDj0SuyqKjbTvSLc61A0+WL6WnjOKXGvAkA3wSQ6lThiYnN1tMBZLWfbZ50ePntQULXGM7ZLSFQLheFnRaZn6gRASXobUMHT34ChFnKMmKuCzgEV1ZPqj12v4zCIjKI1tP75R49z8PBwWfViSZCUObCIKhqWXu15MxCEl9IhwAljNDZPP2iYZ3KzgU2tn1BHukTJGk3k7+VEGaDo2QSTHXnuJasPMRxKnFVeOiJ2tNmA+XdquzDBYRHUP/W5NzplKkfcBK4PzYnWaJf7LBgBQnp+/LeZp0GOEP78lsyYNq08FyNj5iDTuDhUSW0HgjMpY8lTlEWYU1Fqkx89ygHi34zY0SlJ5L+EVCKOQScjZlXUW5Z3ooxaFkzOZ4pHEy+pNum89n3FhrZe7LIVVFVB8BanpY6cVeovMKynmlMF18u2n4Bpepwmt2QtATyxRMoAgwrJKOdZmS3uq2xz/QIN/HkAhgHGSKDnFYJjWm2DU7cKogHtMckmCsqmg+rU8y5l/V0UMjzzMNw/0BhVgS4uHK3C1NmElCuO3/imN6QmO0ZPxswOq/ZinxQTmrfXAC4z/m+l1wixgbgezdpwCJ59tsuQmmQl/mue4NtcBvvRrcIiIjuJIoE8NzKHCw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(7416014)(36860700016)(261021121427099003)(11063799006)(261021123027099003)(56012099006)(10067099003)(3023799007)(261009223027099003)(22082099003)(18002099003)(6133799003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rOckH//4rRyQFfUkuL/ReieXMTsO1Vy6BPsEBzyAxjQrWIXc4Nrrp3eIpHBxuK1BxP3YEDicvIu5YrHDmlJLc8hd0QCcH1R1Q3u9WXNAT9rJj+gdUvvjiTEn7YV4PI2J8qVFJQVUDG31vkdYKaK0QA+IUmBXsHl7PdMshzUP2a1sm1G//HOx3k+h9nr7gYxDzubAjs8XnNWpIdNffER6q8aCRPZgJ8D7GoAxX3WQHKWGNApP16Gkqviy2hnc6yngQ2tOc4zOH7Fy2btvGLHfsElizpqIn+bwrBtdQOR1Ll5SsnOMyxONbsS9jkhFrZGu9FuYnFyhUSpMq4crJmwSFXHK2hqWpEByeMXUCNy2DZBml6K3wcd3jyBI8rOD/JtCbkBe5bJIahWGMJLxJq7w1HlzT8UyTtNYXUTKbGTAGJlGYeH6ODBwoeWt5yQmov0q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:41:12.4795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf7f2df-f859-43cd-01c3-08df311c1117
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720

pci::Driver now provides reset, bind, error, pm callbacks, vfio::pci
now can reuse pci adapter's callback instead of maintain its own
separate adapter

Remove vfio::pci::Adapter and its callback dispatch. Expose VFIO
registration and runtime PM operations for drivers using pci::Adapter.

Move the DMA ownership and SR-IOV checks to registration, and require
VFIO drivers to install PM callbacks when CONFIG_PM is enabled.

Suggested-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/vfio/pci.rs | 287 +++++++---------------------------------
 1 file changed, 51 insertions(+), 236 deletions(-)

diff --git a/rust/kernel/vfio/pci.rs b/rust/kernel/vfio/pci.rs
index 0fbc6a920dc..f3e68a3d18c 100644
--- a/rust/kernel/vfio/pci.rs
+++ b/rust/kernel/vfio/pci.rs
@@ -18,11 +18,8 @@
     alloc::allocator::Kmalloc,
     bindings,
     device,
-    device_id::RawDeviceIdIndex,
-    driver,
     error::{
         from_err_ptr,
-        from_result,
         to_result, //
     },
     mm::virt::VmaRef,
@@ -38,8 +35,7 @@
         NotThreadSafe,
         Opaque, //
     },
-    uaccess::UserPtr,
-    ThisModule, //
+    uaccess::UserPtr, //
 };
 use core::{
     alloc::Layout,
@@ -98,120 +94,6 @@ impl DeviceContext for Ioctl {}
 impl DeviceContext for Read {}
 impl DeviceContext for GetRegionInfo {}
 
-/// Connect a PCI driver's private data to its VFIO registration.
-///
-/// # Safety
-///
-/// `registration` must always select this PCI device's sole registration and must not sleep.
-/// The driver must use [`Adapter`], and its `probe` and `unbind` callbacks must not enable SR-IOV.
-pub unsafe trait Driver: for<'a> pci::Driver<Data<'a>: Sync> + Sized {
-    /// The VFIO operations implemented by this driver.
-    type Operations: Operations;
-
-    /// Select the registration without blocking or changing its identity.
-    fn registration<'a, 'bound>(
-        data: Pin<&'a Self::Data<'bound>>,
-    ) -> &'a Registration<'bound, Self::Operations>;
-}
-
-/// Register a VFIO PCI variant driver and coordinate its callback lifetimes.
-///
-/// The adapter publishes complete private data before registering VFIO, and unregisters VFIO
-/// before calling the driver's optional `unbind` callback or removing private data. SR-IOV
-/// enable and disable callbacks are not supported by this adapter.
-pub struct Adapter<D: Driver>(D);
-
-// SAFETY: The C PCI driver embeds `device_driver` at the stated offset; its private data is
-// the pinned `D::Data` installed by this adapter's probe callback.
-unsafe impl<D: Driver> driver::DriverLayout for Adapter<D> {
-    type DriverType = bindings::pci_driver;
-    type DriverData<'bound> = D::Data<'bound>;
-    const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
-}
-
-// SAFETY: The driver core unregisters only a successfully registered, still-live PCI driver.
-unsafe impl<D: Driver> driver::RegistrationOps for Adapter<D> {
-    unsafe fn register(
-        pdrv: &Opaque<Self::DriverType>,
-        name: &'static CStr,
-        module: &'static ThisModule,
-    ) -> Result {
-        build_assert!(
-            D::DRIVER_MANAGED_DMA,
-            "VFIO drivers must manage DMA ownership"
-        );
-        #[cfg(CONFIG_PCI_IOV)]
-        build_assert!(
-            !D::HAS_SRIOV_ENABLE && !D::HAS_SRIOV_DISABLE,
-            "VFIO PCI variant drivers do not support SR-IOV configuration"
-        );
-
-        // SAFETY: The driver is being initialized and is not yet visible to the PCI core.
-        unsafe {
-            (*pdrv.get()).name = name.as_char_ptr();
-            (*pdrv.get()).probe = Some(Self::probe_callback);
-            (*pdrv.get()).remove = Some(Self::remove_callback);
-            (*pdrv.get()).id_table = D::ID_TABLE.as_ptr();
-            (*pdrv.get()).driver_managed_dma = D::DRIVER_MANAGED_DMA;
-            (*pdrv.get()).err_handler = &PciCallbacks::<D>::ERROR_HANDLERS;
-            (*pdrv.get()).driver.pm = &PciCallbacks::<D>::PM_OPS;
-        }
-
-        // SAFETY: The caller keeps this initialized driver pinned until unregistration.
-        to_result(unsafe {
-            bindings::__pci_register_driver(pdrv.get(), module.as_ptr(), name.as_char_ptr())
-        })
-    }
-
-    unsafe fn unregister(pdrv: &Opaque<Self::DriverType>) {
-        // SAFETY: The registration contract guarantees a live, registered PCI driver.
-        unsafe { bindings::pci_unregister_driver(pdrv.get()) };
-    }
-}
-
-impl<D: Driver> Adapter<D> {
-    extern "C" fn probe_callback(
-        pdev: *mut bindings::pci_dev,
-        id: *const bindings::pci_device_id,
-    ) -> c_int {
-        // SAFETY: PCI supplies a live device and holds its lock throughout probe.
-        let pdev = unsafe { &*pdev.cast::<pci::Device<device::CoreInternal<'_>>>() };
-        // SAFETY: `DeviceId` is a transparent wrapper with no additional invariants.
-        let id = unsafe { &*id.cast::<pci::DeviceId>() };
-        // SAFETY: The ID comes from `D::ID_TABLE`, a dynamic ID with matching driver_data,
-        // or the wildcard ID whose driver_data is zero.
-        let info = unsafe { id.info_unchecked_opt::<D::IdInfo>() };
-
-        from_result(|| {
-            pdev.as_ref().set_drvdata(D::probe(pdev, info))?;
-            // SAFETY: The fully initialized, pinned `D::Data` was just installed above.
-            let data = unsafe { pdev.as_ref().drvdata_borrow::<D::Data<'_>>() };
-            // SAFETY: `D` selects this device's sole registration. Private data is installed
-            // before VFIO can enable runtime PM.
-            if let Err(error) = unsafe { D::registration(data).register() } {
-                // SAFETY: Failed VFIO registration has unwound its callbacks. In particular,
-                // rejecting a PF with enabled VFs must not disable those VFs during rollback.
-                drop(unsafe { pdev.as_ref().drvdata_obtain::<D::Data<'_>>() });
-                return Err(error);
-            }
-            Ok(0)
-        })
-    }
-
-    extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
-        // SAFETY: PCI supplies a live device under its lock, after quiescing runtime PM.
-        let pdev = unsafe { &*pdev.cast::<pci::Device<device::CoreInternal<'_>>>() };
-        // SAFETY: A successful probe installed this device's complete private data.
-        let data = unsafe { pdev.as_ref().drvdata_borrow::<D::Data<'_>>() };
-        // SAFETY: Probe registered this object. Private data and all its fields remain live
-        // while VFIO unregister drains VFIO, VGA and PM callbacks.
-        unsafe { D::registration(data).unregister() };
-        D::unbind(pdev, data);
-        // SAFETY: Callbacks have drained, so private data can now be removed and destroyed.
-        drop(unsafe { pdev.as_ref().drvdata_obtain::<D::Data<'_>>() });
-    }
-}
-
 /// The trait for VFIO PCI variant driver implementations.
 ///
 /// Unoverridden callbacks delegate to the corresponding PCI core operation.
@@ -848,109 +730,6 @@ unsafe impl<T: Operations> Sync for Device<T> {}
     }
 }
 
-/// Callbacks that recover the VFIO device through its PCI driver's private data.
-struct PciCallbacks<D>(PhantomData<D>);
-
-impl<D: Driver> PciCallbacks<D> {
-    /// # Safety
-    ///
-    /// `dev` must belong to `D`. Its private data must remain installed and valid for `'a`,
-    /// or not yet be installed. The caller must exclude its removal; runtime PM callbacks
-    /// use their own synchronization rather than the PCI device lock.
-    unsafe fn registration<'a>(
-        dev: *mut bindings::device,
-    ) -> Option<&'a Registration<'a, D::Operations>> {
-        // SAFETY: The callback supplies a live device bound to `D`.
-        let data = unsafe { bindings::dev_get_drvdata(dev) };
-        if data.is_null() {
-            return None;
-        }
-        // SAFETY: PCI published a fully initialized, pinned `D::Data`. The caller prevents
-        // its removal, and `D::Data: Sync` permits shared runtime PM callback borrows.
-        let data = unsafe { Pin::new_unchecked(&*data.cast::<D::Data<'_>>()) };
-        Some(D::registration(data))
-    }
-
-    unsafe extern "C" fn reset_prepare(pdev: *mut bindings::pci_dev) {
-        // SAFETY: PCI holds the device lock across reset and registration teardown.
-        let Some(reg) = (unsafe { Self::registration(&raw mut (*pdev).dev) }) else {
-            return;
-        };
-        // SAFETY: The registration owns callback data throughout bind and unbind.
-        unsafe { reg.dev.registration_data_with(D::Operations::reset_prepare) };
-    }
-
-    unsafe extern "C" fn reset_done(pdev: *mut bindings::pci_dev) {
-        // SAFETY: PCI holds the device lock across reset and registration teardown.
-        let Some(reg) = (unsafe { Self::registration(&raw mut (*pdev).dev) }) else {
-            return;
-        };
-        // SAFETY: The registration owns callback data throughout bind and unbind.
-        let result = unsafe { reg.dev.registration_data_with(D::Operations::reset_done) };
-        if let Err(error) = result {
-            // SAFETY: The PCI callback keeps its embedded device alive.
-            let dev = unsafe { device::Device::<device::Normal>::from_raw(&raw mut (*pdev).dev) };
-            dev_err!(dev, "VFIO device reset failed: {:?}\n", error);
-            // SAFETY: The initialized VFIO device remains alive for this callback.
-            unsafe {
-                bindings::vfio_pci_core_aer_err_detected(reg.dev.core_device());
-            }
-        }
-    }
-
-    unsafe extern "C" fn error_detected(
-        pdev: *mut bindings::pci_dev,
-        _state: bindings::pci_channel_state_t,
-    ) -> bindings::pci_ers_result_t {
-        // SAFETY: PCI serializes error callbacks with binding and unbinding.
-        let Some(reg) = (unsafe { Self::registration(&raw mut (*pdev).dev) }) else {
-            return bindings::pci_ers_result_PCI_ERS_RESULT_CAN_RECOVER;
-        };
-        // SAFETY: The registered device owns its error notification state.
-        unsafe { bindings::vfio_pci_core_aer_err_detected(reg.dev.core_device()) }
-    }
-
-    #[cfg(CONFIG_PM)]
-    unsafe extern "C" fn runtime_suspend(dev: *mut bindings::device) -> c_int {
-        // SAFETY: Registration enables PM only after private data is installed. PCI remove
-        // and VFIO unregister quiesce runtime PM before private data can be removed.
-        let Some(reg) = (unsafe { Self::registration(dev) }) else {
-            return EBUSY.to_errno();
-        };
-        // SAFETY: This is the runtime-suspend callback for the initialized core device.
-        unsafe { bindings::vfio_pci_core_runtime_suspend(reg.dev.core_device()) }
-    }
-
-    #[cfg(CONFIG_PM)]
-    unsafe extern "C" fn runtime_resume(dev: *mut bindings::device) -> c_int {
-        // SAFETY: Private data remains installed until VFIO unregister has resumed the
-        // device and quiesced PM, including registration failure.
-        let Some(reg) = (unsafe { Self::registration(dev) }) else {
-            return ENODEV.to_errno();
-        };
-        // SAFETY: This is the runtime-resume callback for the initialized core device.
-        unsafe { bindings::vfio_pci_core_runtime_resume(reg.dev.core_device()) }
-    }
-
-    const ERROR_HANDLERS: bindings::pci_error_handlers = bindings::pci_error_handlers {
-        error_detected: Some(Self::error_detected),
-        mmio_enabled: None,
-        slot_reset: None,
-        reset_prepare: Some(Self::reset_prepare),
-        reset_done: Some(Self::reset_done),
-        resume: None,
-        cor_error_detected: None,
-    };
-
-    const PM_OPS: bindings::dev_pm_ops = bindings::dev_pm_ops {
-        #[cfg(CONFIG_PM)]
-        runtime_suspend: Some(Self::runtime_suspend),
-        #[cfg(CONFIG_PM)]
-        runtime_resume: Some(Self::runtime_resume),
-        ..pin_init::zeroed()
-    };
-}
-
 /// Build the `vfio_device_ops` vtable for a variant driver `T`.
 ///
 /// Open and I/O callbacks dispatch to `T`'s trait implementation.
@@ -1007,9 +786,8 @@ macro_rules! build_ops {
 /// Owns both the VFIO device reference and the registration data, tying
 /// resource lifetimes to the PCI binding scope `'a`.
 ///
-/// Prepare this owner during probe. [`Adapter`] registers it after private data is installed
-/// and unregisters it before private data is removed. Dropping the owner releases the VFIO
-/// allocation and registration data after callbacks have drained.
+/// Prepare this owner during probe, register it in [`pci::Driver::bind`], and unregister it
+/// in [`pci::Driver::unbind`] before releasing any driver data.
 pub struct Registration<'a, T: Operations> {
     dev: ARef<Device<T>>,
     _reg_data: Pin<KBox<<T::RegistrationData as ForLt>::Of<'a>>>,
@@ -1034,8 +812,8 @@ impl<'a, T: Operations> Registration<'a, T> {
     /// The device must have been allocated during this parent binding and never registered.
     /// No other `Registration` may own or publish callback data for this device until this
     /// owner is dropped.
-    /// The caller must hold the PCI device lock. The owner must be stored in the private data
-    /// of a driver registered through [`Adapter`] and selected by [`Driver::registration`].
+    /// The caller must hold the PCI device lock. Store the owner in the driver's private data
+    /// and keep it alive until unregistration has completed.
     pub unsafe fn new(
         pdev: &'a pci::Device<device::Core<'_>>,
         dev: &Device<T>,
@@ -1064,10 +842,25 @@ pub unsafe fn new(
     ///
     /// # Safety
     ///
-    /// Call once under the PCI device lock, after installing complete driver data whose
-    /// [`Driver::registration`] selector returns `self`. On success, unregister before
-    /// private data is removed or destroyed.
-    unsafe fn register(&self) -> Result {
+    /// Call once from the bound PCI driver `D`'s `bind` callback, with `self` in its installed
+    /// driver data. Its PCI reset, error and runtime-PM callbacks must delegate to this owner.
+    /// After success, unregister before any later bind error or driver-data teardown.
+    pub unsafe fn register<D: pci::Driver>(&self) -> Result {
+        build_assert!(
+            D::DRIVER_MANAGED_DMA,
+            "VFIO drivers must manage DMA ownership"
+        );
+        #[cfg(CONFIG_PM)]
+        build_assert!(
+            D::PM_OPS.is_some(),
+            "VFIO drivers must install runtime PM callbacks"
+        );
+        #[cfg(CONFIG_PCI_IOV)]
+        build_assert!(
+            !D::HAS_SRIOV_ENABLE && !D::HAS_SRIOV_DISABLE,
+            "VFIO PCI variant drivers do not support SR-IOV configuration"
+        );
+
         // SAFETY: The caller has published complete private data under the PCI device lock;
         // it remains accessible during runtime PM setup.
         to_result(unsafe { bindings::vfio_pci_core_register_device(self.dev.core_device()) })
@@ -1077,9 +870,10 @@ unsafe fn register(&self) -> Result {
     ///
     /// # Safety
     ///
-    /// Call once after successful registration, with the PCI device lock held and private
-    /// data still installed. No private-data fields may have been destroyed.
-    unsafe fn unregister(&self) {
+    /// Call once after successful registration, with the PCI device lock held and all driver
+    /// data still installed. Do not call after registration failed: that can disable VFs
+    /// belonging to a PF which VFIO refused to bind.
+    pub unsafe fn unregister(&self) {
         // SAFETY: The caller keeps private data installed while unregistration drains VFIO,
         // VGA and runtime PM callbacks. No field of the enclosing data is being destroyed.
         unsafe { bindings::vfio_pci_core_unregister_device(self.dev.core_device()) };
@@ -1102,12 +896,33 @@ pub fn error_detected(&self) -> bindings::pci_ers_result_t {
         // SAFETY: This owner keeps the initialized VFIO core device alive.
         unsafe { bindings::vfio_pci_core_aer_err_detected(self.dev.core_device()) }
     }
+
+    /// Prepare the VFIO core device for runtime suspend.
+    ///
+    /// # Safety
+    ///
+    /// Only call from the parent PCI driver's runtime-suspend callback.
+    #[cfg(CONFIG_PM)]
+    pub unsafe fn runtime_suspend(&self) -> Result {
+        // SAFETY: The caller supplies the runtime-suspend callback context.
+        to_result(unsafe { bindings::vfio_pci_core_runtime_suspend(self.dev.core_device()) })
+    }
+
+    /// Complete the VFIO core device's runtime resume.
+    ///
+    /// # Safety
+    ///
+    /// Only call from the parent PCI driver's runtime-resume callback.
+    #[cfg(CONFIG_PM)]
+    pub unsafe fn runtime_resume(&self) -> Result {
+        // SAFETY: The caller supplies the runtime-resume callback context.
+        to_result(unsafe { bindings::vfio_pci_core_runtime_resume(self.dev.core_device()) })
+    }
 }
 
 impl<T: Operations> Drop for Registration<'_, T> {
     fn drop(&mut self) {
-        // SAFETY: The adapter unregisters before removing private data. Failed or unattempted
-        // registration also leaves no callbacks behind.
+        // SAFETY: The driver unregistered in `unbind`, or registration did not succeed.
         unsafe { *self.dev.reg_data.get() = NonNull::dangling() };
     }
 }
-- 
2.43.7

