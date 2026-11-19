Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795125272;
	b=cQ5h7oJ1H/LzZaHLJPfhI4kdJpI+adUsnnf9UQfXJUvgEvLwDmfhpGATd5UByoQnp7VQ
	 VdfKphBvkaoEgCw1wH+Po/VKf9j40IDrb+7s9mTsNmq+sJJFdnlRRSQun8ihAT87KKT0f
	 BsTa58hjF9dcw4bvDbdpSpRTdicEcWQm/uw+6Jhv5FseqXdq2mw3ThKfSdjySklgfbUH0
	 yWFrbkD/mg6WovZWbEXXVri12cA5nzzI3p6hwqjtZrcuy+pTYU54DpNtvp01Gma2D3hEV
	 1Uv6eORfeDkEwpkjj+q56kp4zdcFFA7dWhGTnXfwOQmuebg+8GpzRQPLnr9Yalyeczw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125272;
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
	bh=oR30ekZYMu2C9cH8jeCrLe8nwMdZqXzf908DlFYgipk=;
	b=nvpAUqs9a/YgmZNCfV3GwtSogZXfQVSM6pnH/Lepm3T79txgl7ajp5UFzMyvOludJeHe
	 SgDDY6Fy0xBWznn1UQInASEEcnKTPlXTzK89PHzD4mJ5zSdD/ICGRArXtdF3YTPJ065hQ
	 ELY7IEyALonYfqUmhfRY+EqASjpeIMnubjngS/yQ76R0iOCzs4qGIWl6k1BG+jL0RPtyi
	 YYBzb213bCVT13faTUSDTZL1+VkjO6HeKmxBhrlAZAPfo+P67g3BknDYg8v6OjvnmxGvY
	 6zbnVW7m+winnJ9Wg6afjc5I9ila7GLBPkqKczAiE3GnFmmeP4GSs2kV0vtb3v8yGkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I+hdinaN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.5
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6F606A320;
	Thu, 19 Nov 2026 21:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9E6F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I+hdinaN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSwW2StPjIw5PqI+wRbN9PZQBVpNoqu1kjiNrzqQsF/bxlmlQbxsSUbFxt0uO9TWdxacjy62Y/pz1CGdp834AsSpuzP4hT+jfRjhwdSXGrBBuTFhZYk7ysILcqTx9Wwx3A8OzGchTEA3cR1LItYEafUY5mgOSNZ/158iSX/UhejzvS6EiSqGbz3P+jqgJIY9NVmpsNaF2JxF2RYm+wasB35vVAux4UySRKy2/yOn2jW1A/s6She+QydWfilISlz2NpoP8e+UIKSzx0/L2sBwm6w6NhyF9x4xohkHjboLozS286vJESOfca1fDz3xyf2OGE8DYc8zrUZFb7HpRXB6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oR30ekZYMu2C9cH8jeCrLe8nwMdZqXzf908DlFYgipk=;
 b=msJAuexTnVWWgH1GJxgp4BOtHoCj2XZIEVvSpDNn2K/yCS+QfY9/omZGb5aJClfVys6CSecn28OdAkIPL9wRDzKjnOIrqo78SQKIrzXDX1iLCNWZuaQ5rErpnpWlRExWfd3BBMBZrib8/MKTX3UgYGYlZ4j3frpCf6SPr8mHp1NNzncxGLs+Rg11KLY0w/DHmrC3X3XF3EtT77Eu+2sFtpFt56Vu5fr1muTijmkDbB8ztkHGdaEzljiA1a7AMJgdXVcgmchpSJMGO4InkyFjgPGalbL1/TILHMYwuln03UDoGWsEAe0MTbelTOqVhi5UJQ4G8uQHWSPt+ZzEZiF9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oR30ekZYMu2C9cH8jeCrLe8nwMdZqXzf908DlFYgipk=;
 b=I+hdinaNon0MzbU/N5ZWzOpkl7C6jPW2WTycFmMJ2tmCj4Qa+0Ohhv168kxe50gAaJD07f5j3dEmxsntZK/hFZvecIljVfz15P5/Cbll81Oih8lbW6NU9D1If85hFqSEAAtgSIEtLhZv0kte6GrZo6CyEf+yvf2CoQLHVrsLWmCc5vdjY9zvGnJmKuqnYnmUVMGM2+EJRh+dm8wHBD5OzVzaU/eXASbkd9yXr0qarQyHulvoexC+lTlxpJ7Y2pQozBbz48BhXEYk2/z0vrL63uVOptR8qEXdb99Zt+S0DEDd6Wfx9Fa7GxUdxCpnFpGN1VoQWiHKZiB8JnkbuQyJVw==
Received: from MN0PR02CA0029.namprd02.prod.outlook.com (2603:10b6:208:530::32)
 by DSVPR12MB213845.namprd12.prod.outlook.com (2603:10b6:8:4ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 21:51:40 +0000
Received: from BL4PEPF000003F3.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::79) by MN0PR02CA0029.outlook.office365.com
 (2603:10b6:208:530::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 21:51:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL4PEPF000003F3.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 21:51:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:51:13 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 13:51:11 -0800
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: Simon Song <xinmengs@nvidia.com>, <alex@shazbot.org>, <jgg@nvidia.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
	<ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>
Subject: [PATCH v3 4/9] rust: pci: add reset callbacks
Date: Thu, 19 Nov 2026 13:50:39 -0800
Message-ID: <20261119215046.2892839-5-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL4PEPF000003F3:EE_|DSVPR12MB213845:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5f20df-ab2e-46a9-3c73-08df46874a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|23010399003|56012099006|5023799004|11063799006|261021121427099003|261009223027099003|10067099003|261102123227099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	urPbnS+k/uM8AgaCd4QpojKyQT2g8VyfKzqcX7KJ7lfBJq8GWjK0cVGny01VaeqIvZqosNdmtB9wdMNaKPPX2y+Is9w0YPLETiEFo/eBSWzMcT1kLUgaD3FEldv1TI0Ru9HzHAUzCJc8j5q1cHLEFi4xzPzM+HHyy4tmpoRAR3pGVlvxP6dgWxR/+yaNtiv5LItNyI6tq+Uto7WThfeIQ1+h6MLRDgjkAD1Br5GZJHEKNRJZOBL0OxgN7jg78PVTCSNJVQqlMgo6OGOzxc2mWDfvG6vKolVeoyZH2ucQUV1SIpR2GOA9fze7pzEgF9PAAS3runQoejaTYE4Ki9CrcURqvKmLedhRCbcma+Sqrl+y3DVZZNEFBxA0caF84FSRSz3C3I710OjCbP+B7Kq4/e3XylKHB9mj9+mCyZ9cBiU04agqvuLKfDpnk5Wi/aBwxNWKAgtSvhoXtzD2dmObZxZQJNej1WqQdgMUtkllToP5ZsdlD6dqzssFGXOT44H+huJiXs7VFoK+BGnHgyFgwp9BV5MbMEg+ShEe9Fbwlnof7SKuqa/hk6du+pfMiIx4ZDYElDuqPK0tdwwqOYXdtdwR+Lk4rbe6cayAUvUMEpXMdd5E6zmGV1BqSIRy2/8sE8lIgWpU/WkI2YDC70H1WqmZ5Er7ysMkIWinqGSdobWCouvEgETBj71TERTCAZCX/CPNvgkNfPmrMwQbJeR2iA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(23010399003)(56012099006)(5023799004)(11063799006)(261021121427099003)(261009223027099003)(10067099003)(261102123227099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O8KWp5J4C4cmfCGSmle96LHgbTKQR+NnlcZx46IXV54HrPD7HmWmGJIB1yBL41fPt15HaeW/KMpOlEJNun+iF0xPP78UeZtxMLQXfjJfow+KssV1anHryWg+aQOq/3qrqdkxCaZ5BEvRpqPrCTz/dpsnjJQlAhF03Bry4wYtqQRIPgP/UrB4t3ntysWKHGBWIf5xuhyeaLhvSnslzEj4ulNf6ht5OeHZCXNuvyhIFzQs33vlzvjFmWla8a8/FYZTyDn4EpoEpw3LuET1FQmW7bwXDyvT4E9jPgoUHH+kR4Wsm3z5UTa5qeTiYY3aH3Ku0mu2odtCsWg71zif00oJ8651LCv8RpFi9hC981ejhApqsm06WByeXKAttMYwscIVlFYuJYvxXb6tyy2wUF8S9Hh2FtfnplGH+EIoq0yV1sGkry4OqZ/4+VOJwGJ27/VJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:51:38.9756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5f20df-ab2e-46a9-3c73-08df46874a4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL4PEPF000003F3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB213845

Because a VFIO PCI variant driver may need to update its state when its
device is reset, it needs notifications before and after the reset.
The NVIDIA VFIO variant driver resets a VF's active vGPU instance.

Add reset_prepare() and reset_done() as optional callbacks to
pci::Driver.

Suggested-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 6013c89bfb5e..8fcec16e6ccf 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -106,6 +106,9 @@ unsafe fn register(
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
             (*pdrv.get()).driver_managed_dma = T::DRIVER_MANAGED_DMA.is_some();
+            if T::HAS_RESET_PREPARE || T::HAS_RESET_DONE {
+                (*pdrv.get()).err_handler = &Self::ERROR_HANDLERS;
+            }
             if T::HAS_SRIOV_ENABLE {
                 (*pdrv.get()).sriov_configure = Some(Self::sriov_configure_callback);
             }
@@ -178,6 +181,54 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         // before `devres_release_all()` in `device_unbind_cleanup()` is sufficient.
         drop(data);
     }
+
+    extern "C" fn reset_prepare_callback(pdev: *mut bindings::pci_dev) {
+        // SAFETY: The PCI core only ever calls the reset_prepare callback with a valid pointer to
+        // a `struct pci_dev`, while holding the device lock.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `reset_prepare_callback()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
+
+        // SAFETY: The PCI core only calls this callback for a device bound to this driver. The
+        // device lock excludes `probe_callback()` and `remove_callback()`, so the stored pointer
+        // has type `T::Data<'_>` and remains valid throughout this callback.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
+
+        T::reset_prepare(pdev, data);
+    }
+
+    extern "C" fn reset_done_callback(pdev: *mut bindings::pci_dev) {
+        // SAFETY: The PCI core only ever calls the reset_done callback with a valid pointer to a
+        // `struct pci_dev`, while holding the device lock.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `reset_done_callback()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
+
+        // SAFETY: The PCI core only calls this callback for a device bound to this driver. The
+        // device lock excludes `probe_callback()` and `remove_callback()`, so the stored pointer
+        // has type `T::Data<'_>` and remains valid throughout this callback.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
+
+        T::reset_done(pdev, data);
+    }
+
+    const ERROR_HANDLERS: bindings::pci_error_handlers = bindings::pci_error_handlers {
+        error_detected: None,
+        mmio_enabled: None,
+        slot_reset: None,
+        reset_prepare: if T::HAS_RESET_PREPARE {
+            Some(Self::reset_prepare_callback)
+        } else {
+            None
+        },
+        reset_done: if T::HAS_RESET_DONE {
+            Some(Self::reset_done_callback)
+        } else {
+            None
+        },
+        resume: None,
+        cor_error_detected: None,
+    };
 }
 
 /// Declares a kernel module that exposes a single PCI driver.
@@ -402,6 +453,14 @@ fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'
         let _ = (dev, this);
     }
 
+    /// Called before a PCI function reset, with the device lock held.
+    #[optional]
+    fn reset_prepare<'bound>(_dev: &Device<device::Core<'_>>, _this: Pin<&Self::Data<'bound>>);
+
+    /// Called after a PCI function reset, with the device lock held.
+    #[optional]
+    fn reset_done<'bound>(_dev: &Device<device::Core<'_>>, _this: Pin<&Self::Data<'bound>>);
+
     /// Enables Single Root I/O Virtualization (SR-IOV) for a PF.
     ///
     /// This callback is only invoked when `CONFIG_PCI_IOV` is enabled.
-- 
2.43.7

