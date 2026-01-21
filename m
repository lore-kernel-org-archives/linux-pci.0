Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B34217F33;
	Wed, 21 Jan 2026 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005505; cv=fail; b=QClawXA8d9pyQ1kMWkIXrnlTNMhwedvlxbxrJ22KXN1kt+rFgF/RrNlqgBciB0aVl3Q6yFAVRIz7QgfQRnUhboYzYHdnwpT6Xf7iVs45s63nhUZwg+W5ZlDhee3kj4UAHJ5VjMfG7Qr7KnMdq0vZd3zBGmPxzLDyuOa1T3ht4j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005505; c=relaxed/simple;
	bh=pNOxSD6yFd8ZnohsQf6idEl7i+DFCFKFyff8HtincuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNqvnHc2lGV9W6O/H+Z60kfq6OaiKE5fZefU+6kr0hbUT6uR38orPoDBq7q9AW/qxm345ZOzGCh3aq0ODxQjvoi9dgvVkA03UioBxYamq4lDg7XxCSgGWX/E4lh9gPNuzAGs4+eSNRoluH1LeS49HGFyi8OBrJ/dNgtq7+xERWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kpMn4256; arc=fail smtp.client-ip=52.101.62.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kpMn4256"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mprh8Qo93PtMXO4+U5byVcJ28QCk/ZaD0WRMZCCWxISM4t1eqnSi7TQpm1H3P4LvADREvl9EapeCI5mBZAge9ky32j1+LtTfJ8rwThKFn0zDLzhdYVxnxpSsUC+QqdhpNdJXftx8u7N1SPOaklR+hPeaM2eZxPUtXvHA/B/owH+CdPqemyi6VVAkcaav2y2IWLjZDjrmPGW3l9rvZKG3RbCQ3ncVCkrtFNgKI7PaesKdimts6SR6TAuL5aavFw/Di2dhf79f24QPPfL54p0E99GMAPJrw75dKYLenZ+glw8tc36uWmhoNFYTpGSFsvfzWXhQjsI8Z3K0xkn3uT1zRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOWCeEUJKJc8omTvBPbqZ8eMOnLAHleQc1B8pXqNZq4=;
 b=UxC3DcacdZHWD0FWg6sJ3XOZxQtHJW6XjGGhTTEvIQuK2oe1bCycxC9IonISoLccmRcbdQanYpQ6W98JK7ZAjT1S4bJxl391dD3ux4S5H+91KKYRaVNP63QTniPQIKoUuyFIcit0ORiZQtmtd3y354NCPDGN5r8N/+OnS/Ba3Ie56QLtGz8Hh4Y3NLDHFytkOSabrc9w8JGHpeT936hFEUaHV4RTuAKt6od0BywFVNC7holg6SOTPCiTOmPzGXURb+Z6mkrZ8oyG9tW0+RfxUSkh9YuAgpdk7gCX4qkTJcHEJd0bo+P1f/PyWMiaqx7cEscoFuZU6U1Vecl4Kd3W4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOWCeEUJKJc8omTvBPbqZ8eMOnLAHleQc1B8pXqNZq4=;
 b=kpMn4256SZ1yhWwLcfGkw3S/5yokoOXw63rc7g1DWlRD9YikKEe81FlVp7Ox2fc73GTg5/IYIQIqgmT+7MZzORSA2OeS6Gbjsvx0TK1rr1fd2gJjQful8lBGXTysVmKiGEmnEyiaUIMrd24JK+ZPSUzBQ2EpjFvA3JBAznpvwb2FztjfuEGW/A+drT9h/rmgvIlmlKhvtPipd5RndfaaCrKWxlJMSw1Qdp7PlXbtbjhUcBGUJ0Bcw0MEy3bsKLJVo8RYoP2BssGt7YRrnpRDRGJHzVQsipS6HJV9fifvVBMXrULCoFijIul529AUqTIdkY1LRwwctaTs7ttJjtN5Pg==
Received: from BY5PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:1d0::15)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:24:59 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::31) by BY5PR04CA0005.outlook.office365.com
 (2603:10b6:a03:1d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 14:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 14:24:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 06:24:37 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 06:24:36 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 06:24:30 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v11 5/5] sample: rust: pci: add tests for config space routines
Date: Wed, 21 Jan 2026 16:23:54 +0200
Message-ID: <20260121142355.4761-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121142355.4761-1-zhiw@nvidia.com>
References: <20260121142355.4761-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: b0514011-da9f-476b-5933-08de58f8db99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ONZ3GaIVQKeWXeu5Cx5uzlL4UMer7KLLBUBOSLsDroLe6/XF6O++tGm4qp8M?=
 =?us-ascii?Q?a+LZHLLFl0c8t7t6v0Uaf9ccm23m7WuvFEzd8KEkV+CgddYIz7s75GaMGKjS?=
 =?us-ascii?Q?n0XmqjWEZWEqtAS5PrQaT2fY4/kOQzhRaknZCVPtf0Sy+qrbIKZA0tzeXAgZ?=
 =?us-ascii?Q?WDdJvj1BHRaFjjBitkH3aRkWjmfiIGyGEJy79RHmUuhWLqGYUDTiWlW+LvOA?=
 =?us-ascii?Q?WlRF7et9Q1ppG+giHxBBEaqDhyZxrnJ+8eCcKjNO6ZcVUyt8UFzBEgQdYat2?=
 =?us-ascii?Q?JvXwjPQIW+UkTHM+gpn4fmlkExUrGammzHnYo3KnJa88gjVClH6TuU/mUjFf?=
 =?us-ascii?Q?zUovo1AsNRVeyT18nN82i9p/ydhhKUX7vYdcm5JIlOOkuDxZccpfErBqqFmF?=
 =?us-ascii?Q?6ljoBGayQXnClu1o/yzpcnYqPsPTGog48kJDaddyjetX+xpNiFVAHEbzC0Cd?=
 =?us-ascii?Q?bDZ3VEVGPcSYEB4wiPw8RXxST2PPlW8rGaA+MCcOJiG+Eg6FXDtLwwxQXMDv?=
 =?us-ascii?Q?cnxp4VdENQ/AYAk/ByZTu46B/R55tXMnwZ0hA8EoIgUeaYjueIlMDI64SiEx?=
 =?us-ascii?Q?Gvi8x1MfV9SmnNuZkQev7fqE5P8fTBCqpcQ0lM1o3o5vDxSQ+4ArZVdV3EbN?=
 =?us-ascii?Q?414xBunDZIUelGoOB6ZAGS1dPx6kZ8ffjrpjLcW2fMiDS/67wh+oOc2FWuf4?=
 =?us-ascii?Q?LjZ6zLfL3Ov9ELYU770R51Xd59RQabXxqa+mwIYZo+SqyE55oSUB4SUonrD6?=
 =?us-ascii?Q?hO5WJNeLhn0h7NYs6KwyLPn7tbUnA7mkiaz8nxYB8bXlkJXQ0o1Q9EHI18lF?=
 =?us-ascii?Q?E0VOC74AMeWHu1MupGJXDtkAanYUTbQFYfx6gJA7PgHBLLQNsOeBKqZxmIgU?=
 =?us-ascii?Q?yCaZsIx6WgHE+cYg0tVQTQjGCEXRWn/Itxagyq7cLQc4F9Q1kpY75iIqvyG5?=
 =?us-ascii?Q?yoI5Kvb9vrRmMZEwdtJXKiLI1FjJ4+hic5hWhxXCbP4gxu4LMgqIGx6FuYIa?=
 =?us-ascii?Q?WS4LjW4ixlfbC8PXCjkioWOOJijbtuRi9Pmi3Sq0S2LbvSOuhCWJIQ6ZygpZ?=
 =?us-ascii?Q?YEXQ0xvfr2ELJ52140CrW4msetidvCzHy7CgEKxtNpSYMuUqj0pu26QXQ9m3?=
 =?us-ascii?Q?gav/MEfn6dnS7+9vXk49SzeDSLvA+GYZb/aqQIPyd9J1Xr3Mu5pvCEBqdqu6?=
 =?us-ascii?Q?4WAD8MIAOghxKdEsDHsifjWiOyjjqiQo6M/rKdPpjuZDN1njzjexMUWVMX5o?=
 =?us-ascii?Q?f7SMUEjQyHXhf0x7NV3RpH9QElc7befbix66qJsSoeqQa/r0hvypRodfUVVO?=
 =?us-ascii?Q?gBXOo0ENT/SG/J7f/aCkqDjS6uCTMBzjCGLhWwuF3sGyO9aHFkgB1KVSEQWZ?=
 =?us-ascii?Q?14Oqpr8zD3o1gO+dNGXSspS4N4gpTFIlfylyOLlB3LBzap5BBbZNsCg9Gdvc?=
 =?us-ascii?Q?iIBdzjghQb8nYeVTwtu+LPVyR3d9Xk1vLDlUlWdSD03yPD0AIfYjExCXcZJR?=
 =?us-ascii?Q?e9XUSL0/uwV4jlcdZBr8vYbboOneeW8hKh6lnCr2VZAdJwcyW830nMYW04Xf?=
 =?us-ascii?Q?v1qrqDBqRZuzANNoSjPWbdJ4q/tpVajzKj6z4CeadDs8YDD5IY5gCOE212yn?=
 =?us-ascii?Q?PGPrpU0EHzKeoTF7Z9Ug09MDPs894LRBxeOpfGU22F+OUNhT4m0BSEMBhPL8?=
 =?us-ascii?Q?3e0nNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:24:59.1713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0514011-da9f-476b-5933-08de58f8db99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808

Add tests exercising the PCI configuration space helpers.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 samples/rust/rust_driver_pci.rs | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index bfb053059667..26f0887a74e8 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -5,6 +5,7 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
+    device::Bound,
     device::Core,
     devres::Devres,
     io::{
@@ -68,6 +69,32 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
 
         Ok(bar.read32(Regs::COUNT))
     }
+
+    fn config_space(pdev: &pci::Device<Bound>) -> Result {
+        let config = pdev.config_space()?;
+
+        // TODO: use the register!() macro for defining PCI configuration space registers once it
+        // has been move out of nova-core.
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space read8 rev ID: {:x}\n",
+            config.read8(0x8)
+        );
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space read16 vendor ID: {:x}\n",
+            config.read16(0)
+        );
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space read32 BAR 0: {:x}\n",
+            config.read32(0x10)
+        );
+
+        Ok(())
+    }
 }
 
 impl pci::Driver for SampleDriver {
@@ -99,6 +126,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
                         "pci-testdev data-match count: {}\n",
                         Self::testdev(info, bar)?
                     );
+                    Self::config_space(pdev)?;
                 },
                 pdev: pdev.into(),
             }))
-- 
2.51.0

