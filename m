Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794436490;
	b=JO9JO9UxKY3CljFWAHpOwvqtgsT/vGw53LNMw+jI9HYh1+QXyXw7uXvPSHFiXi0AaAIK
	 D0TvZ92/BCAbK0wKR0VQtXO1IXwYhhiwMQw08UCw96LbGK/42a8dOlQbRiMabvlLGo8jL
	 Xktj3MmupxdqKao2qXM2+XMEZmB1vfVvv4OcCL19zurNzb0q1gb8+TJO6Lif9oxz5GV8G
	 IZo6MOipGack4GyFkMxNdOS8tYjCsmqU2yXt2BgREjiNhgfbDPPPAyYY0c5ORDNTM5SF6
	 KJZi5h+UWK16vHwaA07t6CTYB2cOfs0TKcyA2VlcCQAtKFFryJchno5uSY/iuDj94WQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436490;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
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
	bh=c3FZkDemh6lkqX3O+x5U3T9gPMwfvhx4TNA/ELuzfX4=;
	b=b7tqgMjq1qqdSLke/A4cWVjBOIRr6EkY9pu48LRM448JrDoQaMXc7fFeTQNo8kXj8qrR
	 slnq8wd0cqsR+wLgov5FBVsGo2NnhnvRjIpTyVvRUd5oR5bJYxMzDlA3q/0HbQeT8VGFq
	 Wv/8W7RheDjeigp2kGOK4DAcFuA2yCCkUJkfN9l+eRYEl4iUY2SIdyfe5QaCpV9cWphAw
	 8tZCRsRwtJByTZZfPRLpyeX1HW1vVkpgUMcgtTiqB/FZ/S8V0KKvCG0eHDzodk/flOVVO
	 6o4LeuvsgGUN7sEG5ZiPxqPHAIok7zZU0O6GbX4nlWn5fYSwcZyl3VXGgGYYTnx/QYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Je61XPm7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.12
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6038B60A3828;
	Wed, 11 Nov 2026 22:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6038B60A3828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Je61XPm7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMxdkwghlpJ2HB4R+DsBMkXboKTwn7TuRksoNKHNIe4BY04HijkqA61Ckl16Xwx9bGOLLDSLRXuRrOF9JR3n135pyNWC52ZLulRMRq38qIEAnIvWrgmV/1GEzOsTyE91dHekVhhgfg6FnmhjUD7f6Ur96uzuxo0vwEJrX8oDBBz1+XY/u2WiYjMPlnTS9sschMkuI9aX34v3O4DlYwsAENDj/GpmiM8ChA+HtE1+Q003vNE3LjmOs77DlFwd/GgT2oODRmlNWwUNmiwva1Rx+3VO0bZrjlLj5GR1jQKPWshqM4UKhhLi+RfSl14LvP1vhU6XRcPqlBlavhVgB/QGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3FZkDemh6lkqX3O+x5U3T9gPMwfvhx4TNA/ELuzfX4=;
 b=Of0k+BXEwPu8KTboECB5CwgNOl+9W+0CmXFrWq/WrEokutQRtNMbIlm4C7IjETm4GERc3kWTLf8BDauIZSCrnBhNbQJ5TI48TDqC4TPVpUjh+kToj1Tyip4DRz6Y0BjTjKPrd9lHvMUYuWgY6VusZzsOwzOsvfshpC2qZBjBdpxie0rWiHwtxrlSjU1DCfUHFNsp9uVf2obVMjGpEOMZv1VfuPO+9YEcWgrSh1kTaK4aeNCj+a81G4fn27UpuTiSokuoa9RDDWqgT/BwY6gp1H6JUuvbJil0vyVPoih5qh7a72FCHKsvY/YubjqfMGvaQEQboBmG1oa2WrN+RdDyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3FZkDemh6lkqX3O+x5U3T9gPMwfvhx4TNA/ELuzfX4=;
 b=Je61XPm7N3k9uLNALKYW2ACLpPMvLAJ4c0j8Shwq+Y30S5RGwYKZ4q9WhKATFRgxQu8iHRGBnBeInNr4Gt9iQh0aGx8zlaX8Gm4URfLQ6TMstsG8d8luuOFU7fC778VcSMtT3qgXCzO/sJUbZA+p8Mj6sZUSUaDU0+g5kPgPuLNG9fzEw1USHN67kqTerq1ppMveZLIn7To58DnSlTnySIjTzpJyThzj8NE5VEPDRGgxehnxdnxiq4BGWP8IM5bq3QoIYUM5VF69UrWsvVAtziOOdUNB8FVz4jiA5QFEmVDzKjGTzErhKARlz5Lqy7nvz5FXh8PqH9BVkUh3e0duBQ==
Received: from PH7PR17CA0014.namprd17.prod.outlook.com (2603:10b6:510:324::29)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 22:34:41 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:510:324:cafe::ae) by PH7PR17CA0014.outlook.office365.com
 (2603:10b6:510:324::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 22:34:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 22:34:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 14:34:28 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 14:34:25 -0800
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
Subject: [PATCH v6 11/11] samples: rust: add a Rust SR-IOV PF and VF driver sample
Date: Wed, 11 Nov 2026 14:33:36 -0800
Message-ID: <20261111223337.508989-12-xinmengs@nvidia.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: ff66ac58-275a-4ae1-f4af-08df4043fa6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261026140227099003|261022113327099003|261026121527099003|261021121427099003|261028144727099003|261102123227099003|261102130727099003|261009223027099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ZE13SmOjWCmr9TZBaJIRxcy5F+joqQS/vDhyw9iZr9wLSiXaL+U6D1s+pCYo275WWiuLjXvTy6d8WmS6XVev5osVcF2kLn8DF5Lr9krILAcNCCxLhf0hcpYGPgDCD9GxqWQAzofEOkz0AypQCOvukQMpJzo7dTyrqoUp0nx7Vl0g3Uld+cR+Yw9SPjlr1wFniOWvTducJGhFvgzEgcfAn8D77XFgMTNGxrNNQxHqELdrCpcVSUmKAqG7nBYIr0WJsOWaN1CyaxK4AO6hsHxM+OyUNC4MSji+z+6vPXVER9/PX6J46MzGmk2zp0XvoCbLBN1wqnOcRmZ9r8sa0YvBVF6HEp0x5YAifPys/xctrCLjgd0mIegTekxxlIcJdPRLDEND9R0UcNuY4YgVKkGGFBMiakNqAAgDm3paWXB7I1H1kagHcRzoAsABeXUQX5ECmaZVskCt330GVyDayEOpO+fI2OgTKenalPf4oQUaXfAy/5pqyh0v9dCI+cHaWlMqSooqYFhzLvdYqtY4V+zX7e6C2XOqPxJhwLYRli/rMFlQuHf/Qf4Vc/Jpoknt29ey3LagcSLbCGfC457qDZsGeSYQ+oCcssIMCVXd+azL+GVq4vYbfQxq0p3Uz8YDK2Sl1Cvb0KhNGeD3NrE3eZ0h7eqMMxCrtqHwk1GIQCHvIFzU5oyimd2188rQOYPikqbXLSbc8QMa6ys6S0RETRpEJA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261026140227099003)(261022113327099003)(261026121527099003)(261021121427099003)(261028144727099003)(261102123227099003)(261102130727099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JyG4rAWByaUq8PaXQatOWRjDSOzbEtj0pzwn7QTuMNRVLBft1IPlhSIBZP9Yh1ZYPzmcL2nTIXMIQm/XxR8I/Raso+E81yCEHI9dmwbo4/yqewD+jpDWthYS5DpR025aXWtujU2cpbLurfF3Om2WZiRio7slatFqr2ZC/a06WbRlHW8Rs1yrJOWUCrNoMM8D897WAO2+Q1wg5sorX74b+PcM2L2kB0scMMb8kcQ8Sx9ymrJOEvdbYMYq+HfQNaMSn9sImtXZaWkyVUOzRGBVQapSxIPLsgoIwrOLf2WAISbuETIMlOgRP4qrd9vH5K1QVWficMaqwDyrGX0SgHGbv8XeNdpMyoQyQAEdf725HFREuTVYHuWvxgVLh89VbijY0o5t7p2y4U/+vjhVwrUpOXThWT+O1kDihRal2fGpB21YDQOhnsaf7yISAfu4HmVq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:34:41.8145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff66ac58-275a-4ae1-f4af-08df4043fa6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815

From: Peter Colberg <peter@colberg.org>

Add a sample module with a PF and a VF driver that demonstrates SR-IOV
using QEMU's 82576 (igb) emulation.

The PF publishes a pinned API object in its private data and provides a
submit_request() helper. The VF calls this helper with its Bound device
borrow. The helper performs the typed registration lookup, so the VF
driver does not use the API object or its lifetime encoding directly.

Keep the PF and VF drivers in separate files, but build them into a
single module that registers both drivers. Separate modules would need
cross-crate Rust symbol exports, which can be added once the build
system supports them.

Unbinding the PF disables SR-IOV and removes its VFs before releasing
the registered data.

Link: https://www.qemu.org/docs/master/system/devices/igb.html
Signed-off-by: Peter Colberg <peter@colberg.org>
Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Simon Song <xinmengs@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 MAINTAINERS                          |   1 +
 samples/rust/Kconfig                 |  11 ++
 samples/rust/Makefile                |   1 +
 samples/rust/rust_driver_sriov.rs    | 178 +++++++++++++++++++++++++++
 samples/rust/rust_driver_sriov_vf.rs |  49 ++++++++
 5 files changed, 240 insertions(+)
 create mode 100644 samples/rust/rust_driver_sriov.rs
 create mode 100644 samples/rust/rust_driver_sriov_vf.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..4ea281037109 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21634,6 +21634,7 @@ F:	rust/helpers/pci.c
 F:	rust/kernel/pci.rs
 F:	rust/kernel/pci/
 F:	samples/rust/rust_driver_pci.rs
+F:	samples/rust/rust_driver_sriov*
 
 PCIE BANDWIDTH CONTROLLER
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 31d62533ef25..b88473558b9d 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -128,6 +128,17 @@ config SAMPLE_RUST_DRIVER_PLATFORM
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_SRIOV
+	tristate "SR-IOV PF and VF Drivers"
+	depends on PCI_IOV
+	help
+	  This option builds the Rust SR-IOV PF and VF driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_sriov.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_DRIVER_USB
 	tristate "USB Driver"
 	depends on USB = y
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index b986b681cde5..238a11d5ec39 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_I2C)		+= rust_driver_i2c.o
 obj-$(CONFIG_SAMPLE_RUST_I2C_CLIENT)		+= rust_i2c_client.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_SRIOV)		+= rust_driver_sriov.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+= rust_driver_usb.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
diff --git a/samples/rust/rust_driver_sriov.rs b/samples/rust/rust_driver_sriov.rs
new file mode 100644
index 000000000000..35e45297b21d
--- /dev/null
+++ b/samples/rust/rust_driver_sriov.rs
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust SR-IOV driver sample based on QEMU's 82576 ([igb]) emulation.
+//!
+//! To make these drivers probe, QEMU must be run with `-device igb`.
+//!
+//! Further, enable [vIOMMU] with interrupt remapping using, e.g.,
+//!
+//! `-M q35,accel=kvm,kernel-irqchip=split -device intel-iommu,intremap=on,caching-mode=on`
+//!
+//! and append `intel_iommu=on` to the guest kernel arguments.
+//!
+//! This module registers both the PF driver and the VF driver.
+//!
+//! [igb]: https://www.qemu.org/docs/master/system/devices/igb.html
+//! [vIOMMU]: https://wiki.qemu.org/Features/VT-d
+
+use kernel::{
+    device::{
+        Bound,
+        Core, //
+    },
+    driver,
+    pci,
+    prelude::*,
+    sync::atomic::{
+        Atomic,
+        Relaxed, //
+    },
+    types::CovariantForLt,
+    InPlaceModule, //
+};
+
+#[path = "rust_driver_sriov_vf.rs"]
+mod vf;
+
+struct SamplePfDriver;
+
+#[pin_data]
+struct PfApi<'bound> {
+    pdev: &'bound pci::Device<Bound>,
+    next_request: Atomic<u64>,
+}
+
+type PfApiForLt = CovariantForLt!(PfApi<'_>);
+
+impl PfApi<'_> {
+    fn submit(self: Pin<&Self>, vf: &pci::Device<Bound>) -> u64 {
+        let request = self.next_request.fetch_add(1, Relaxed);
+
+        dev_info!(
+            self.pdev,
+            "Handle PF request {} from VF devfn {:#x}.\n",
+            request,
+            vf.dev_id()
+        );
+
+        request
+    }
+}
+
+/// Submits a request to the PF associated with a bound VF.
+fn submit_request(vf: &pci::Device<Bound>) -> Result<u64> {
+    Ok(vf.vf_registration_data::<PfApiForLt>()?.submit(vf))
+}
+
+#[pin_data]
+struct PfDriverData<'bound> {
+    #[pin]
+    _registration: pci::VfRegistration<'bound, PfApiForLt>,
+    pdev: &'bound pci::Device<Bound>,
+}
+
+kernel::pci_device_table!(
+    PF_TABLE,
+    <SamplePfDriver as pci::Driver>::IdInfo,
+    [(
+        // E1000_DEV_ID_82576
+        pci::DeviceId::from_id(pci::Vendor::INTEL, 0x10c9),
+        ()
+    )]
+);
+
+#[vtable]
+impl pci::Driver for SamplePfDriver {
+    type IdInfo = ();
+    type Data<'bound> = PfDriverData<'bound>;
+
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PF_TABLE;
+
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        try_pin_init!(PfDriverData {
+            _: {
+                dev_info!(
+                    pdev,
+                    "Probe Rust SR-IOV PF sample (PCI ID: {}, 0x{:x}).\n",
+                    pdev.vendor_id(),
+                    pdev.device_id()
+                );
+            },
+            // SAFETY: The registration is embedded in the PF driver's private data.
+            _registration <- unsafe {
+                pci::VfRegistration::new(
+                    pdev,
+                    try_pin_init!(PfApi {
+                        pdev,
+                        next_request: Atomic::new(1),
+                    }),
+                )
+            },
+            _: {
+                pdev.enable_device_mem()?;
+                pdev.set_master();
+            },
+            pdev,
+        })
+    }
+
+    fn sriov_enable<'a>(
+        _dev: &'a pci::Device<Core<'_>>,
+        data: Pin<&Self::Data<'a>>,
+        token: pci::SriovEnable<'a>,
+    ) -> Result<pci::SriovEnabled<'a>> {
+        dev_info!(
+            data.pdev,
+            "Enable SR-IOV (PCI ID: {}, 0x{:x}).\n",
+            data.pdev.vendor_id(),
+            data.pdev.device_id()
+        );
+
+        token.enable_all()
+    }
+
+    fn sriov_disable<'a>(
+        _dev: &'a pci::Device<Core<'_>>,
+        data: Pin<&Self::Data<'a>>,
+        token: pci::SriovDisable<'a>,
+    ) -> Result {
+        dev_info!(
+            data.pdev,
+            "Disable SR-IOV (PCI ID: {}, 0x{:x}).\n",
+            data.pdev.vendor_id(),
+            data.pdev.device_id()
+        );
+
+        token.disable();
+        Ok(())
+    }
+}
+
+#[pin_data]
+struct SampleModule {
+    #[pin]
+    _pf_driver: driver::Registration<pci::Adapter<SamplePfDriver>>,
+    #[pin]
+    _vf_driver: driver::Registration<pci::Adapter<vf::SampleVfDriver>>,
+}
+
+impl InPlaceModule for SampleModule {
+    fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
+        // Both drivers are on the PCI bus, so they need distinct driver names.
+        try_pin_init!(Self {
+            _pf_driver <- driver::Registration::new(c"rust_driver_sriov_pf", module),
+            _vf_driver <- driver::Registration::new(c"rust_driver_sriov_vf", module),
+        })
+    }
+}
+
+module! {
+    type: SampleModule,
+    name: "rust_driver_sriov",
+    authors: ["Peter Colberg"],
+    description: "Rust SR-IOV PF and VF driver sample",
+    license: "GPL v2",
+}
diff --git a/samples/rust/rust_driver_sriov_vf.rs b/samples/rust/rust_driver_sriov_vf.rs
new file mode 100644
index 000000000000..e03ff05bb910
--- /dev/null
+++ b/samples/rust/rust_driver_sriov_vf.rs
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Virtual Function driver for the Rust SR-IOV sample.
+
+use kernel::{
+    device::Core,
+    pci,
+    prelude::*, //
+};
+
+pub(crate) struct SampleVfDriver;
+
+kernel::pci_device_table!(
+    VF_TABLE,
+    <SampleVfDriver as pci::Driver>::IdInfo,
+    [(
+        // E1000_DEV_ID_82576_VF
+        pci::DeviceId::from_id(pci::Vendor::INTEL, 0x10ca),
+        ()
+    )]
+);
+
+#[vtable]
+impl pci::Driver for SampleVfDriver {
+    type IdInfo = ();
+    type Data<'bound> = Self;
+
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &VF_TABLE;
+
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
+        dev_info!(
+            pdev,
+            "Probe Rust SR-IOV VF sample (PCI ID: {}, 0x{:x}).\n",
+            pdev.vendor_id(),
+            pdev.device_id()
+        );
+
+        let request = super::submit_request(pdev)?;
+        dev_info!(pdev, "Submitted request {} through PF data.\n", request);
+
+        pdev.enable_device_mem()?;
+        pdev.set_master();
+
+        Ok(Self)
+    }
+}
-- 
2.43.7

