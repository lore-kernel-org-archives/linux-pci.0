Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010064.outbound.protection.outlook.com [52.101.193.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CCD3C1976;
	Wed, 21 Jan 2026 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026995; cv=fail; b=AmG5DKtrqoEIEtAMvxFzZmRBGpJP6KbYYrLvak1ufUtEFlg64LcmFhVprx+wKZ8F0ogn53IXwtm6cr2xGN1XM8/7O0RtvyMXbI2/sjpy+uPV17BAG67e5r94K5gMXjSbRvKKJ50AEhWbN4TFtucEQkMg6o2bqO5zP0JOuY5LuhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026995; c=relaxed/simple;
	bh=Mgg5rRqyZwHP2sTo/X4MvWcFkp3NIcgILNd3twNdYuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoeL0hNwZouV1PwxoMyfo64cfcTeGel+ImHmcGqKoXTKofxF8k+iXJQIJkEBtJGhQpwWWBWZWBmkfXbs7hmbcb+5lQOMZiu2somrPxeDvDxWIchpGqr0a5ji1VrG27a0MHdyPrRjEkBHVZLPAq0H+NTu57w2C7YQk3lxZSqsXhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lfvXZSl2; arc=fail smtp.client-ip=52.101.193.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lfvXZSl2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8NFmYQPMq8t3SpBnJYlyl8qoYlKHBsqpEjGnkZVz/XExQ6Il19H5tJbrOjaD/B/xSanMcJx8M+/fpCn0yR+ZBOVgMfOoRwA5j7nZQLOILtuOzFf/pMLhCaTn++dEfuZQVYvjI+KE3TQSsWCGXmH5XEIOPNISNA8PCmTFehTA+AyB/WO3lCWut+0xfWypWwGn0sIGijOVNDcGcq8oWOlLpj6T1wKTOXYW4aZFwEh5mLlNGMdP0FhCZEVwh4no3nJubvQg6EtiRfawGC64IBIttWO5HquydlGHZrWd/OPgbjw1DsowIdSwxFhzaFm2JiYRqCvwPfT8x1t4Y8Z2D4OZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WESaqIq8dHbYW0/RrreUMYYjBhW5WCK172vSILfzis=;
 b=KJ6WUq29bV8iX0oyZjyE7K5x9aS9/4o2z3/a0bq3qTsypRXdi+edwf4wGQsWBng1dyIE5bv5uTUy+r0kMPoNbdUe7TLEBJ1XVMTDNSbnD57WaXFfUo3pt6HO6ZIBZ0d6HnfR5mznpms1gPJ8Ll+qWJgadIE9i4cSlMTRWzZXugBb3IRa+PmfDKn0UOHvXt0GKFf/44yZH39j7O7uMXvORhDnRb6srx7z6ZIcOyzMriBP4nC+f6rhdv7KowVlx/SHVSW2WHgkeAEGPYsYAIEgScxcnUfwY1/zFs8Zu8UgHKYuS9YBc7Xw03zQPaHAsKFbrwCbnvjP+kbLvz/ElqjcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WESaqIq8dHbYW0/RrreUMYYjBhW5WCK172vSILfzis=;
 b=lfvXZSl2CEvcwBmCQFQWEJZ/Ps17Keii+coGBr3ZYaMr2u1fpHhVIJYKwbBF+7uGTpKbCfZrK2rKhh59Mr/WSedz5DUZ6/6Z3+rcnBGz+UrIgxtcr0dCzdL9nBYqV8RElZlmh0IM8PotNcAzjdpdgERFY+K5MtILqpImEHtUIkZ6WfhHl+AvIj+eTFQ/3UKWyyR/Yw9d/gchgzqo2cHp7MqCfTZJ/bnL9+uDdnsZPFsOAeL94DCOsI87u3iglktZHk7JPgBQpHl9hD7Mhcyc7d27wRABjwRWveI0sjLqex9vYRJnESP/V0OFHdZvwh9lrRh0cju3Ari2QVLlsUSr8w==
Received: from CH0PR03CA0072.namprd03.prod.outlook.com (2603:10b6:610:cc::17)
 by SJ5PPF6375781D1.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::995) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 20:23:08 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::16) by CH0PR03CA0072.outlook.office365.com
 (2603:10b6:610:cc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 20:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 20:23:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 12:22:52 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 12:22:52 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 12:22:46 -0800
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
Subject: [PATCH v12 5/5] sample: rust: pci: add tests for config space routines
Date: Wed, 21 Jan 2026 22:22:11 +0200
Message-ID: <20260121202212.4438-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121202212.4438-1-zhiw@nvidia.com>
References: <20260121202212.4438-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|SJ5PPF6375781D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 693c3255-d074-460b-f054-08de592ae414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G2YW64pFQbjyaTlI4cbwGF2wFX3Sods5vz0e8oGFh5X19A/1w4bJf3rzjFjA?=
 =?us-ascii?Q?lP2LDTgStJKjqlkbyOYfJqJK+zgn23dK3ePJfZB6SCsWfKUjDiEpBHnCIxME?=
 =?us-ascii?Q?f62zA3AlTwjKXe8VzxgthA9zSM/cEIp/qk9z84BZ656RxzR3Ty+AsrOAM9sP?=
 =?us-ascii?Q?9l/sCJC6itwVXT5t4RuhVtmsSGBa/A/a6GFYxSEXhfcahUtYhDl0GJf1wfh0?=
 =?us-ascii?Q?aNmlK20BcxbMiYKy87sSi/tIKhrXQvjRIVnGSJHJT9hHjPF9Buwd9s5nk9fe?=
 =?us-ascii?Q?EBrZ6bZo3KHHTCat042sckNY7mw39ThVAfR0eQKZEUNBbRVusQzsiORs574i?=
 =?us-ascii?Q?II+DkjMAvHHuhiPvdlCQsQjaUcrOv5kynqGldONUsOyOiuMpIPffsenlh5LP?=
 =?us-ascii?Q?GRDQur0BZS1o//NGsL8Bl+cd/rnurgjDlL6Y4k1qpu6E92eDmp0Yj7ehU9UM?=
 =?us-ascii?Q?8WVa6xE2bdyzxmvhnxw6/tkwviPBaai+8CDHQrehNwoJVjAB6OqD3qBSUTWM?=
 =?us-ascii?Q?KlPy9/ZoJxpUJaPlv/qyQKh6vFpyekXoR/AoCH8w14bXElKBXuRHY3N6MuY8?=
 =?us-ascii?Q?1lKhG0JIknG3KO+XXcSS8+9+DhwrVflFiDw7WRMTbGam/MG7jcPVKRdfYKl+?=
 =?us-ascii?Q?2Hj7gu2nJ9aorisho9egtFEFNsyNUvsoFp/7xlHmqRud9ZUhpqptZ8XEw1BL?=
 =?us-ascii?Q?FLmP8r5z8KumEFB8ziAlobVxtPCDvQcediKrivAv8fkdd98tD3U2vfVSW0dK?=
 =?us-ascii?Q?kOfON99mI8PZE4eVyMaTPHdJyCafC0dV2xI2Vk/yTgcuD8+V+nkNoM5PuSVm?=
 =?us-ascii?Q?Agyoqo86E+WPiPpyMEDtP5wMJpWPlClxVb4iqkzYpdHkfs5KLa/bwxe+x86M?=
 =?us-ascii?Q?zxx/KCz7dnaIyKbnt7baeko4shrgH82DQx14dmkROWVTyRztPUyMI7QXr8JX?=
 =?us-ascii?Q?tuH53ju8JHjfijlAVF5wkTqpsBSBqnpTOTN1lnB68EcaXKH7UkBo/mS3vs1g?=
 =?us-ascii?Q?GTQyTH1WxJahQBbH5ioxjjQaX//PnFo1LxnStIRpT+6T+xCRiJgrzM12YuyX?=
 =?us-ascii?Q?3K5wKGME112OU3mlDKVy4oh88xtEn7AO+Wlst4jhHVvKIGIgVhoETocs4DaS?=
 =?us-ascii?Q?GoJxknJylBiL7TqNrg+2clKZhrFRr3QKvjn/IinHahjaAj0lt6bfyKNw6sxf?=
 =?us-ascii?Q?y8Wy3+9+HLuf627lBdViJtzJqesnn9Z2QjMe/wFnwHmJcc1gS/tY0IjYZRSp?=
 =?us-ascii?Q?lAyu4+Es2nMQE1XENx+ZMKRHtZhmWa++F1SmR85THO2zhoVpMt3AkMa7ZPsd?=
 =?us-ascii?Q?AvglyF2vc6RiW0zFGLAw3x4mnzn0t/7bc6sLqVsqDrAuaQ7B0DVPWcCdQGfX?=
 =?us-ascii?Q?MzBk+SwZgQXPIKMZsujeVvzYQLfEcNBbM0WQD18xX4eeJcNItkCq/4Uk+QZA?=
 =?us-ascii?Q?ZbVL2QHFBmDeCl3wM8WIYVAnu/red6g/V2Jc5j6I3sx70mju7WarqqA80y1+?=
 =?us-ascii?Q?brvnHcDKrXvgL60u2bznY3iKUrhSboDnC4sLATDXUNLDYn9L0QBVjOoI1Ztr?=
 =?us-ascii?Q?zypglSodLH1q8I/0lNhkXCXwt6ZMsozMcz7k6yTAEMlcqVSnjm/aRmucSZyx?=
 =?us-ascii?Q?ympGs7johgjtBSrVhE1JUavhRPLTqdlpHMtsbrICw1lOI0218qUTn+OW9/as?=
 =?us-ascii?Q?Hd/wKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:23:08.1902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 693c3255-d074-460b-f054-08de592ae414
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6375781D1

Add tests exercising the PCI configuration space helpers.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 samples/rust/rust_driver_pci.rs | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 38c949efce38..1bc5bd1a8df5 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -5,6 +5,7 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
+    device::Bound,
     device::Core,
     devres::Devres,
     io::Io,
@@ -65,6 +66,32 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
 
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
@@ -96,6 +123,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
                         "pci-testdev data-match count: {}\n",
                         Self::testdev(info, bar)?
                     );
+                    Self::config_space(pdev)?;
                 },
                 pdev: pdev.into(),
             }))
-- 
2.51.0

