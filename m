Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770081;
	b=gewG18m4JoKRAtc+qamlXZYobz/2/uXt16ZsX5HSjvZE82NflTKjPhUawNLO5zioAORH
	 7IqW/iynBl930zxju5bVSDWTaoHJLMypKaEZu7Q4lAvQQMSyNkzBhbuQTerzme1ifsOS8
	 xkg8sEqIfqgjnRc7bd8k4PD2N9MYqPjNF0w5/LtyMVXPS+zXldzzlGGdvsWI9ion/tdQp
	 kFweu4wgufkY+NfuB9eu/88roLbXPudtHFJaibVUuZxyOEqVV07fgnWwQ/NRUvUoMzO52
	 AzYlFKlFqUBIk0iRDUKetjhcOt/qxvksi17w2dMtMORs2OV2k98UrBDbSAxmDsb+jSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770081;
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
	bh=wBJtS2/ii4JthRgJsIdKgZCGCO26tHMqgB0eiwqu1Ck=;
	b=UfQk+uW2rfHEtWJPnqCdZ4FtD8tkwcGrUTT+Fmrs/8Ijojnmy0+Mhe8llGpJqjcJofLD
	 U8LaeJG/17OHNoetZk+w9e97BiPB7D3nhlIxgAkUEwsEv51+JrSt7MKuJt5kHKQPXy5Fb
	 glRrqJB+T8NNdFqNK2nChGmevXbsb8LoP1ueXKqgMRBaq/csrXNLkkPC+PHl3Cvvc1S19
	 LIyknjGa+QlSTDgMdlJIX7W59M2vlWq71Xlpbx4SCxBSyjf1Sr120pv1o981cfey4yIZf
	 dg6FoMjH4pwsrL4GrA3X8L/DKggRToMIMbkxbyjb7idOa7EqYvAxwrikNFrvnMlB4cQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bfi50gxK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.68
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AFD60A260B;
	Fri, 23 Oct 2026 15:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5AFD60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bfi50gxK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHLz2xTUrwX16SLUFNgbuYIZ/0iiz/kTtzHx29/DITKnCIdkKti813OifrZPGWZe99hLcb9mj8aDajUHkz8SnWGEcVIZcNxQv4unnh93cRfLpppKA8GF5zC7QCD14oVszBrjCw/ej0UeuhnG7KqWdWeRH47UyGraugWxqYTKkHuRvXR8xH0PtojXHz5seUiH/b3FwROcOR00hFNyKAMakBYthaVpiZcBG1yw4X+7gB7GEZJkImQh/BY3qDhcMV9RFTXpDIHhe4NAp2bzZq23tS5dQH23+4+Ic6Hh5V8FxDj+qeuwaYcVaeDtLJISOCQIEVvFNsSWWEK9JhknNxS5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBJtS2/ii4JthRgJsIdKgZCGCO26tHMqgB0eiwqu1Ck=;
 b=HLlHfyOVm3kdXNIW77KnA0B7qmFkJzxediOp2pNaQrCQH/q87AH1WvyCr2GUfPcJxcnPmRdffN8FsIRKkJrLNJfNLghWA0KOWgdI53c/dqFj3V58Uh8BHS+we6CIvoO7HmqtrGl62Ek9+EJ0QWfqscU42AepsE7DxSqxHjlSFXWdCHSopEeR4n96g/neuVmhbjeIKuMUiieSd45vtz8/lNlUGAWAX8cvPKVHSWWJw5Ml5prwpEuqLv6Bfstv/utGE/Oc2Ymf2ZSXDHAItPZkikAcIku2mZA122+j2z0sW+0vR7OmuiPe8rocJH0smnvkheO0iaWxN1RGvLhU+ixqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBJtS2/ii4JthRgJsIdKgZCGCO26tHMqgB0eiwqu1Ck=;
 b=bfi50gxKYSMDXX9FYS+pAlpMmOl7goOo67C3aTboOlSM412+60CMv6vpAD7ESXgYr1vUPO6xc6LmIaJPuZwIr9ZEU1Kv75cLSThS8bgx9jrVCQFEsa8CqfpD+QFC99xnJbyhkdH6+I+oGSRHOj3j+NTOjsZ1d+lhAIQaESDifVQqnqqTBdl4HapQNhpK0L4KoiLWwYS7rA8EgRjolKwjE5AEwzi87/M0zxaxIFn0k2CnjjUm1zTjUV1ZMU15qIu6WOzHr1dHgzgUKwyTVsHz6PNmQDbzBu5huMVUslumNWVEpmzqe3HlyBbwE//SHvkG2/pW7kcVf2DN/Bai+FEaxg==
Received: from CH0P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::18)
 by DS4PR12MB508551.namprd12.prod.outlook.com (2603:10b6:8:50e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 15:41:14 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::3d) by CH0P221CA0016.outlook.office365.com
 (2603:10b6:610:11c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 15:41:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 15:41:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 08:40:47 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 23 Oct 2026 08:40:45 -0700
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
Subject: [PATCH v2 08/12] rust: pci: add runtime PM callbacks
Date: Fri, 23 Oct 2026 08:40:03 -0700
Message-ID: <20261023154009.2246627-9-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DS4PR12MB508551:EE_
X-MS-Office365-Filtering-Correlation-Id: 321db5b4-976a-4a2e-9365-08df311c11b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|23010399003|56012099006|11063799006|261021121427099003|261022113327099003|261022075727099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	D0ywcxFfXBYIneO7wxBJ7fGH5lwhDP5AVG3ztzzx7kRXjlNlxKqhCO89B/XmrsuX/n8J1+at1ZJqbPRnKae/dqmlvlWY7UUdzEcY7zpyutQBj5wYWzocmBW1f0G5ncAfLHFH40ZcBxFGRgVYs+z8gmcUmLaFy080ZW7YNRbIf6NTU189bNdGqKslXFlmAld0DALr8pKVOsmPTwSWVUVoHcgd6QISyXsJABxVT0tTK7MjK/bvx4Yc+MGshotANFWdkI0ghI8YDMzeEzvYlYSB79jgMUhMX+xtYYM+68qZT53knkI1yCbBEnibgRbaiPLB572jldNfKL/YrC/gwsbqBQApUiD2xgpNSJ9ptYeG+EjJ4iQ7dMYqoU02lYxCFc5frs7x5ioAdfAnafulv8RMxV1KdqlX1D/mnxoU6Q3/IFFoy0UF1Ddu7F+0KLlF5SLvE/hLk8Bww+aRGAmijbe2vedPRiYDlwXf2jMu7+hC+XbMnYBd0dCLQkCs7y7JyAi06coJ9yYgyLqRj0sAIzo+mgWgOT4z9yFUID62Nlca79Sod1IyX5qSZQIvtTpK4uPUQ9TdejAq6sFAQxhPyNbF7uOgm3Fn2Ie9LipAIgf7Ghil4W71E/dgsVJPq+YT+E83oKB9hk8FxVfkSl/uVfCNIMTCIMRSrRE+meviLdondFer2AQzuVxGBB1FYsRoNZH2i2VLC7LFkezNk++zS9907Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(23010399003)(56012099006)(11063799006)(261021121427099003)(261022113327099003)(261022075727099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7wIcaMwqNZAzLqK7FsmIlE8QFPZpS/rqMqcmh8qGJCtt8jiwsRRde16G4l5qooVDWijRRng5YBzV74GuN8BUwIMS7tgzXCAwT0/wOLgBRGkLwlpZRbksHs0z+ab5qiwawvJYyEXd3TnvnoRi0OWMnXBhUbQ2hxp+X8lSNFIfmgJeqKD6nF7FPpxlFmYZD5LCNEEjMCrohtqve17Oe6eg8yAiqYuQlMRqzVc/Jw8TniD7+qA7Tu78tUOKfLSPlZ+X5JiDcnEn7+4RYZ+tgMMdWCVfudPq35KEOO4VEmBjpMu+sm+gOPzA6RSJZ6j8NajzEA5mRoXEax/p3rUpOFdCnXUXzzaN+hiZRBlQQpQxnVCCME9dF+A5eyF3epdLlExw2AZzkBp+Ez7561+m9X19PmiH/qiNMlbULqd8apWcND+hzo3Y+QA9ubfCgCv25KIN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:41:13.4429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 321db5b4-976a-4a2e-9365-08df311c11b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB508551

VFIO PCI variant drivers will use runtime_suspend() and runtime_resume()
to forward runtime PM callbacks to vfio-pci-core.

Adding these callbacks to pci::Driver lets VFIO variants reuse the PCI
adapter's runtime PM callback dispatch. A following patch removes the
duplicate vfio::pci::Adapter.

Require Sync driver data only for runtime PM, whose callbacks run
without the PCI device lock.

Suggested-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs | 103 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index ddc28099087..136a817a833 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -112,6 +112,10 @@ unsafe fn register(
             if T::HAS_ERROR_DETECTED || T::HAS_RESET_PREPARE || T::HAS_RESET_DONE {
                 (*pdrv.get()).err_handler = &Self::ERROR_HANDLERS;
             }
+            #[cfg(CONFIG_PM)]
+            if let Some(ops) = T::PM_OPS {
+                (*pdrv.get()).driver.pm = ops.raw;
+            }
             #[cfg(CONFIG_PCI_IOV)]
             if T::HAS_SRIOV_ENABLE {
                 (*pdrv.get()).sriov_configure = Some(Self::sriov_configure_callback);
@@ -261,6 +265,72 @@ extern "C" fn error_detected_callback(
     };
 }
 
+#[cfg(CONFIG_PM)]
+impl<T: Driver> Adapter<T>
+where
+    for<'a> T::Data<'a>: Sync,
+{
+    extern "C" fn runtime_suspend_callback(dev: *mut bindings::device) -> c_int {
+        // SAFETY: PCI supplies its embedded device; runtime PM excludes driver-data removal.
+        let pdev =
+            unsafe { &*container_of!(dev, bindings::pci_dev, dev).cast::<Device<device::Bound>>() };
+        // SAFETY: Runtime PM keeps installed data alive; `T::Data: Sync` permits shared borrows.
+        let result =
+            unsafe { Self::callback_data_with(dev, |data| T::runtime_suspend(pdev, data)) }
+                .unwrap_or(Err(EBUSY));
+        match result {
+            Ok(()) => 0,
+            Err(error) => error.to_errno(),
+        }
+    }
+
+    extern "C" fn runtime_resume_callback(dev: *mut bindings::device) -> c_int {
+        // SAFETY: PCI supplies its embedded device; runtime PM excludes driver-data removal.
+        let pdev =
+            unsafe { &*container_of!(dev, bindings::pci_dev, dev).cast::<Device<device::Bound>>() };
+        // SAFETY: Runtime PM keeps installed data alive; `T::Data: Sync` permits shared borrows.
+        let result = unsafe { Self::callback_data_with(dev, |data| T::runtime_resume(pdev, data)) }
+            .unwrap_or(Err(ENODEV));
+        match result {
+            Ok(()) => 0,
+            Err(error) => error.to_errno(),
+        }
+    }
+
+    const PM_OPS: bindings::dev_pm_ops = bindings::dev_pm_ops {
+        runtime_suspend: Some(Self::runtime_suspend_callback),
+        runtime_resume: Some(Self::runtime_resume_callback),
+        ..pin_init::zeroed()
+    };
+}
+
+/// Runtime PM callbacks for PCI driver `T`, installed through [`Driver::PM_OPS`].
+#[cfg(CONFIG_PM)]
+pub struct PmOps<T: ?Sized> {
+    raw: &'static bindings::dev_pm_ops,
+    // Invariant in `T`, so subtyping can't pass one driver's callbacks off as another's.
+    _driver: PhantomData<fn(&T) -> &T>,
+}
+
+#[cfg(CONFIG_PM)]
+impl<T: Driver> PmOps<T>
+where
+    for<'a> T::Data<'a>: Sync,
+{
+    /// Returns the runtime PM callbacks for `T`, which must override both PM methods.
+    #[expect(clippy::new_without_default)]
+    pub const fn new() -> Self {
+        const_assert!(
+            T::HAS_RUNTIME_SUSPEND && T::HAS_RUNTIME_RESUME,
+            "PCI runtime PM requires both runtime_suspend and runtime_resume"
+        );
+        Self {
+            raw: &Adapter::<T>::PM_OPS,
+            _driver: PhantomData,
+        }
+    }
+}
+
 /// Declares a kernel module that exposes a single PCI driver.
 ///
 /// # Examples
@@ -425,6 +495,9 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
+    ///
+    /// Callbacks access this data under the PCI device lock, except runtime PM callbacks,
+    /// which additionally require [`Sync`].
     type Data<'bound>: Send + 'bound;
 
     /// The table of device ids supported by the driver.
@@ -462,6 +535,9 @@ fn bind<'bound>(dev: &Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>)
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
     ///
+    /// PCI has drained runtime-PM work before this callback. Driver data remains installed
+    /// until this callback returns.
+    ///
     /// For a PF with enabled VFs, `VfRegistration` disables SR-IOV when it is dropped. This
     /// callback must leave resources accessed by VF drivers available until then.
     fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
@@ -490,6 +566,33 @@ fn error_detected<'bound>(
         build_error!(crate::error::VTABLE_DEFAULT_ERROR)
     }
 
+    /// Prepare for runtime suspend, without holding the PCI device lock.
+    #[cfg(CONFIG_PM)]
+    fn runtime_suspend<'bound>(
+        dev: &Device<device::Bound>,
+        this: Pin<&Self::Data<'bound>>,
+    ) -> Result
+    where
+        for<'a> Self::Data<'a>: Sync,
+    {
+        let _ = (dev, this);
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Finish runtime resume, without holding the PCI device lock.
+    #[cfg(CONFIG_PM)]
+    fn runtime_resume<'bound>(dev: &Device<device::Bound>, this: Pin<&Self::Data<'bound>>) -> Result
+    where
+        for<'a> Self::Data<'a>: Sync,
+    {
+        let _ = (dev, this);
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Runtime PM callbacks, if any. Construct with [`PmOps::new`].
+    #[cfg(CONFIG_PM)]
+    const PM_OPS: Option<PmOps<Self>> = None;
+
     /// Enables Single Root I/O Virtualization (SR-IOV) for a PF.
     ///
     /// Called when userspace writes a nonzero VF count to `sriov_numvfs`. The token carries the
-- 
2.43.7

