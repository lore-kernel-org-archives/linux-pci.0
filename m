Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174DD36B91A;
	Wed, 30 Sep 2026 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763709; cv=fail; b=HU48mReG1VZxNA9Tvsup7GSr46fLAz9wAiZbP69d5zl1wGR2PzBI+8vAmRz6gQD+SsngjGTIo3wAvKFbQVLUiO50YQF0SGjvStEQBYa5CKznPypJbogXJKhz8VobfUrn7bbandZL4n2FY5s65UofrVLYfYWesfhYq0Csw8y1lFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763709; c=relaxed/simple;
	bh=1UJh/D8XZ5hxu+UVW4tT/wSmwmj1qgFlLMR+uNfeGDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWS8eJ5LeGk/fPDC7Z/NxeSKTOXumU1juKkk5lyx9yIl90Lcv843f9yIrjlZZXsn4PV5r0OBTfIoiWbA40xNZywkeBLtjBhqX+Rc38IYepFcPj3h9OyVKEwv+fNYgiLrkMEp1Jj5sGhK1GDzBxLyQb2pkzmjYS556TpBLzayuxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ET2qeJk2; arc=fail smtp.client-ip=52.101.56.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ET2qeJk2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB7HaN8oPo281abNavVT3fAXfRN8EBzS/D6kqSjkm5tLpn7jSFwUmkHVJ+YscIQGnUKAUC44c5kqF2mX1oqWVtTINTZxngQB1cIoe9wDQA9TMHs1a+dpL4Ha4zJuIUTzFwn8AuvG8Cw4Ovxc+IJzNnzRC1bI02qYSnG4uCBu9iwIdK0GYop3m7/ybYiNrqYpRA0ZhwYhQa1ZHbC9YKBHJC++7KoFLPJE0uWjdpMEuM4whngtqQXGhDCVYfPU45M8WtRJsRTApY3JehoY7273/pA3ezHwIBA8ONmbYwG3XwKzc7ZAf70xr4tX2URwbkPSIJDdNlSav84Yr4o57RlRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eckPloW3FQ5H7hJRYXxri0WWx7tOWVVmnCRed5BE/J8=;
 b=U9nUZFzi1fu01IV6IJ5bqRiqlQOZyg3HJmCC/CB/7ZPNDnbss5CySP6d1Y/o70W0FbXZ6UjQ+os9A5HK4HhmdxwuzgJh02XWsaGsYGrwfM6oWXgAvBwUIrwJUF64jL4awKZgOMeMRe9byv9sKVUxwGu3PEDidPf25cJFIy+sIW6oR319E4UQi/2IvmXbgCCWI+/U7umvCXIP0aLb80rh+f4gaLIUIcYYwYP9+VHNSLS6TsjdzltXRlRx/d1+RzmDs7wEnYyr0Ir5hd81zwmGHgXo4B2fusviSt1gYCL9pBvXZbSZDKEfXWLbMnRwSYFCk04o9ZaUuT7YYPhfz+Ck6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eckPloW3FQ5H7hJRYXxri0WWx7tOWVVmnCRed5BE/J8=;
 b=ET2qeJk2bJl47Zq/CWhJz59gsaSHYm7RCqNe/XpU5jm72hUVGbT7Gcqu7gVa3n75cWpj3yjNtUL3Xz8ltJp1gQ7UnHftmr6G+RF4isFmdegf8HgW9qIFH3rfoPI9hUoIGFeSJ13bzOf6qlQKx/CFxkcJKZmuH7IaUw0nlZFKd3Lo/uypkgG9YGbyLcvZ9FhE+dQHvig+OXlegJRElotaOnBNJNt8zHP483MtmOTMStvRtnSPkDg+uzer0sOT4kOH0x2VVtfiaB3mtCnMMEB9AVoMxaZiSm5aNEkjpFL8SXIswcJ0fBMr8hqpasvdVr9GjwPgUWN6nyOqV2nNsDmkvw==
Received: from SJ0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:2c0::35)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 10:21:41 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::3) by SJ0PR13CA0030.outlook.office365.com
 (2603:10b6:a03:2c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 10:21:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 10:21:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:21:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:21:21 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:21:14 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <acourbot@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, <jgg@nvidia.com>,
	<alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>, Peter Colberg
	<peter@colberg.org>
Subject: [PATCH v3 06/10] rust: pci: drop driver data before remove returns
Date: Wed, 30 Sep 2026 13:18:47 +0300
Message-ID: <26765341363d67dbec03c238aca0ba027a3a9258.1790759932.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790705494.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|MW3PR12MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: f37c8daa-8fe1-466b-b93c-08df1edc9ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|23010399003|36860700016|11063799006|10067099003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	XUijBGlyA1/zaMSbiL3A39etOpFXtcIjG8ZT4rdvdwSE4fL9qlh73ZHmsvbldS9B8+S0s1ihUXinkmJGxtbMmhXAPqIrM6PmNRUp3u1ci1SX78BBB4FOg3HPH9bGEjjzr+A8oR+kXSDZMFVwgsX/glGpw9NzS92DIcCpcUU4r7UFS0Zu/OFhghvQFjIOZPk8anNRaSZTuRFz1xcyFnh4xKRTzVOk+Ux48TvciH+prPTY6Q34WUCkNedkOCO0chHz2s565P9NikFl4BUFwNneH3hdsjmJat091lPijDw/8Vl12CEvjceQ3Tz9EchpbnyMCLlMOqY2qtSLO5f6n1pmAvoCHalQ+NDaY15Mm/5BKhIjcFfz+CuK5x4Bs9Jn5FFzTRO45OzGOYq8F/4ZV9dPsTI5uA+ldcJp4QAQgEdLW5KZxhT8ZujMfEWsa8uq/m+Qhj4uNvF0Bc9sKEleeCps/ZSVGiVj58x0Yis/abiND00X/jBxnpyPtYhzpXJBCor0hcN2/PwuhBnYgTE3lVRPIwJaujz/1onAmhbzfiqiNCOWxbzqCblv3pZN/M6gsVHL9Bx4SlKHfaaezMllbXzisETQR8mX4x+JEB3VJhmkOS7NPdvGEaDnYS7XEc2dPo5UbpzL+TyW5XAGUFJwtye6A7idh8TFfQXw0hqgGxx1MtABxF3EBoEX/lK8Jg2FeZhNDzgRmvDVeyZnXRWNjS1lEA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(23010399003)(36860700016)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3y7BO07R6hkgVs0GvvlX6gkxpMG/NOwnuuXNDTe1zo1aD0UdoR2+1kWQAADd73rIcscWK84RjG61/d5fMU8dzU8CAFuKamw83nxXLtXLifqiTKp8hih27xQJF7Xs9LhCEcc8dznZLj0B3Q8bpvvfK8xLBY+WLTfbb7+qJKoZVgYNxCilxfR7d94X6PqCzYEnTtsnPgyRrL6I9aAjj6GKm6DBdAiquU6mXuZwt+yJCyI32HWQK9csXL03rUGOw+VZVBZNh7+uxIofmy0w76Osbi3iQ06J3rWmmEbeijkYSWRjaAgaeCAoh5omslS3vCddFCZGTZiqAitE3voiKsMmDd5YLs66uBW2pBBsOqwEnpEcBEDtI2e8QSsjiILZREY6eDwpjyJ2J11DzvfFyBnPIuXzCHdyy1eicjeG4hQXncwaZDHSJa5zRLSKlydoeRda
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:21:41.5131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37c8daa-8fe1-466b-b93c-08df1edc9ec8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363

Drop PCI private data before the remove callback returns, so its
destructors run within PCI core's removal context.

Call unbind while private data remains installed, then take and release
the data. Taking it clears drvdata, so post_unbind does not release it
again. All borrows must end before the data is removed.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/device.rs | 4 ++--
 rust/kernel/pci.rs    | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2291d85b6849..1f6bb58396e2 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -243,8 +243,8 @@ impl<Ctx: InternalBoundContext> Device<Ctx> {
     ///
     /// # Safety
     ///
-    /// - Must only be called after a preceding call to [`Device::set_drvdata`] and before the
-    ///   device is fully unbound.
+    /// - The data stored by [`Device::set_drvdata`] must still be installed and remain valid
+    ///   for the returned borrow.
     /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
     ///   [`Device::set_drvdata`].
     pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index dcb0cdd0d426..1599b3a613d7 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -141,6 +141,12 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
 
         T::unbind(pdev, data);
+
+        // SAFETY: The driver's unbind callback has returned, and no callbacks retain a borrow.
+        let data = unsafe { pdev.as_ref().drvdata_obtain::<T::Data<'_>>() };
+
+        // Drop private data before returning to PCI core, while its removal context is valid.
+        drop(data);
     }
 }
 
-- 
2.53.0

