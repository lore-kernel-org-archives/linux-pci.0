Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380433;
	b=TheD2Q4Qridorw3dGTGmyExajchhiQ4p88Pfy6PQClfywEaouiCyEu9XpPoK/KhNuIx2
	 zI43kEix7SIRjc/96pup0/F6PunkLWwN+xs5Qp5Pi7hRXnQl0kiy3CHb6DKJ/pYXry92u
	 0lYyqLs7UMIOuq/7hIApa6fXc3qtvFR7K59kY7OIwSf4J/YcVsuW5eQVUl9pXIP91JET+
	 OVslkhyBzzL4UYENAR/Ekk+zr2uBq0Cj7SQwzCJKJxDD6utrntOJfGGtXR3yx4AQiBm0e
	 TIr5AxL3D5lj6ss2Ep9DtEauXbEnzXDUV6q7zdeMNfDWJJkdtrGwIoPYXDb3ik6Q9eQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380433;
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
	bh=rni1eiDTGPfeXphix6BgF2x54TtJxUtfnPvk58o3nEI=;
	b=YXv8Stb70rCGjoBomX5QyeraVqnPzu7GsKFkkJMdJ+6QThEVRoeKQnulnDaLeO3CKHuq
	 vw53hq6nE62RR4sUCGRQwcW8pfQIMtGkpPhJGYvNXjSlSdu7WcNSX0sqaCz2i1jhJY7bc
	 +V6P4MrmUz4vM0nZukc/qvKTdQI6x+vnf9vKHRkv43HWz4edBDT547pkRe/BIU3YImyoD
	 1HpMwOS+lIS0UDM34muWet5hYF5BIWXYEFe3+8hahe3YjR1oqfNDWLYBCD8ELtsaU7T7R
	 Kd0xALSpNV9JTelXggEMZaGGttZckUx17eDNphEDNoUtD6nkp/wOLzcUGh6wBvUHHVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kO6znSXr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.51
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F060A2616;
	Fri, 30 Oct 2026 17:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 033F060A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kO6znSXr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoL7Zp7RnXQwbuNmCvAyY4ENvTahe4iT7/gi88vTkEtXbcQPcONE/RnYl2wKyQ789GBYCZkXmKWC1UnwdFAloqf3o1ypz7tHZV/mdnjD3KEYHBarQ+pPVvkBPsqtGcyXy9oJnJQ6NFlZ8QVyl7UTZs7X+q0MBr+czWQoXhQDbIQ9Kd/s3ftkhjHaSdIw+WQg9wTUfwbbyB/fV+U7QTYefX+nhEc1SGnJm0o993wbQ3NnBGH7zQOw/l1mPCGPt+MUdXBnLBFuIY4Cv1unG8/Go70zxWUPtkDDXx3cJgNt8/9IET4ULJdb+y4a8kxVwhaejlTNDuLv6Ma8D35KSAKVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rni1eiDTGPfeXphix6BgF2x54TtJxUtfnPvk58o3nEI=;
 b=Y7LOlKazE22IafB+uvTJhMPPH3ftGePEkhN16Q9M4XwSM1LDxzHzqDZFpAqwg+wslh2On1Bl/Ukn3ZIZM437vlfQYRO1fduAVGV0gUgocueBGV322uBqqCVJwpEqTr2QpTcDCWZZSm/8kYJH1KzGaCDS7OCmgn+APkRSSOJ1wggZ4rlyaLjL4Q6JxY0Q8X/jdr4CmOGnBkzPnZOujZlqZa88q/YYOLGoU+QBG5UzGtbPTJ6v/saRJm0gdZm2ryDayzkTBq+vvZZ9H2tHYyoeU96RoRM3ms6Ymvay9GWUY40jls5HqHLTNDRsP0ARO2opQqGR9p2uhKLkdM48pzYg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rni1eiDTGPfeXphix6BgF2x54TtJxUtfnPvk58o3nEI=;
 b=kO6znSXrBUjdDDbYgOt74Hj3vgK/madOp58sN7EmDar0c5apEm1/N+k1pO3w3M6lbgEQGfd5oS0ZYJhliE8EBoDMxLxyUV+iv3aHdaPsI8YA0/v1dtlXww771AhwaQCtKii8MUVOJ01FyMP+mU+G7N/HSOia7G0cy5id9HpD6qpcUXb71aDh+hQvF77D8lrjaKNXntwbiww1lKkxh4g23TUN1w5sNv9jMvrWSj0cx9uRJQzj2CG8DvP6dDmnLBuvchIb3EgUOshBPmQNcvq+uMm44uoFX1kHz9651z4Kmm318TVw0K4n00+yXfG4lpY4Fk3+QSrFLkis6FqBELCIIA==
Received: from DS1PR04CA0010.namprd04.prod.outlook.com (2603:10b6:8:44f::13)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:13:46 +0000
Received: from CY5PEPF00000E7A.namprd02.prod.outlook.com
 (2603:10b6:8:44f:cafe::70) by DS1PR04CA0010.outlook.office365.com
 (2603:10b6:8:44f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 17:13:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY5PEPF00000E7A.mail.protection.outlook.com (10.167.247.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 17:13:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:13:22 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:13:19 -0700
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
Subject: [PATCH v5 9/9] samples: rust: add Rust SR-IOV PF and VF driver samples
Date: Fri, 30 Oct 2026 10:12:27 -0700
Message-ID: <20261030171230.196717-10-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261030171230.196717-1-xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E7A:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: bcaaf1bc-2e3e-49ba-9395-08df36a927f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|22082099003|18002099003|13003099007|3023799007|10067099003|11063799006|56012099006|261021121427099003|261022113327099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	foh+XdvWWEz1xukDVuZNLcDASCH4RpZNpqNGMBzgXQecD2rO1N++A4dsVyqE4iuS/WxVQNEJ13Z5e4OVe1AaVVixXgq4dvCFnL1vrNmOfgmCvojcS9w6Ax2ZWXTbioYAncxEduwt0yldfk3ldCxJB9sTzBglm2YK6iERrmQ6Ey+QS/ygYH2s8MPmAqIjSCm0QsNbZ7+QtNbCGfzm9ih+jY56AdGR8FjFZEbheZ24D8YdvUDXir8Dl6p+4U9wue9haqzMdEVXlQ/Gs3OCqfxao9PyHzxt0MV93buX6i75PaJpmthH9hTua1NYKollZE0ad1fDErqz+Yi+fPXdm3x4IAOM9Av3vmDYQbP13rlu8cmEjm73lldL2bipCGjkHdQcFCy466aOdQ1LkdvcpgNUP7TNhbxjflIX8RNba+T4HhmhrmV16IJjPStv6UQGN7BqxCpIFit+9itSHdor89xY6zrXcBvN3B8RTRTCDzFKQq2NooZ2vfx3Fzhk/+hfqCQ2YyRsOV8aQ7dfJv9BnQs+Z/kwJtS/+bqJFsF33t1hpOP0Q+HhP3darSUECsssHjo0BI05o+oblKPeszkwPU19nGH6rr295wqQ/pZ3/DaOJXINYhYJ+y3Be4f+l9Rapxf/HMpIs7+P4l5ANVgUVSDx+uPZjOWrWP/OSguPAIBYly9STqDDIhJtSilDC6KrMAe/BT04K/RxXS5QQ3GOX1pbxQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(13003099007)(3023799007)(10067099003)(11063799006)(56012099006)(261021121427099003)(261022113327099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rTjda5GoSysw1GZmWFCkePQsF4U1rtutr1y0OOQIKIN4R+1jrjczFlw/tJkWKpWJFJqGZsdJRHrg/WeTEQWJZjQfyZGIKN61x9FAcLrfLRxCFw3secYLCtsG9iHnrWk2e3rA6Q4GGiJZMhx+fXQR23poPosrhSv73LEVaUiZzoAR6TXx7AmPrNYPDeL6Xsd26dFWZyXkvH03SpxZmX34e9JLA7xI8iUWYPLjETF4XLFjMIFiVfITgFCcOkA3H5gjlrpPd3BnrNcAtCaBM4ORnPcVYP2vb092t8uM7VAura0d1UqK9NycV9w9AQfqA2UV3qw47xgNXLoZ81R07B5c9WxvonBzF5Fjo8zzf07XZXaISsXHihfacGWBR5/W3WrmHV+2udfAVkS1qTbXU8OC2kHwwC7HP+QuJm0mzu2PIVZj8e2cTHrecr0ZaMQBbwak
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:13:45.7090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcaaf1bc-2e3e-49ba-9395-08df36a927f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E7A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145

From: Peter Colberg <peter@colberg.org>

Add separate PF and VF driver modules that demonstrate SR-IOV using
QEMU's 82576 (igb) emulation.

The PF publishes a pinned API object in its private data and exposes a
submit_request() helper. The VF calls this helper with its Bound device
borrow. The helper performs the typed registration lookup in the PF
crate, keeping the API object and its lifetime encoding private.

Adapt the nova-core/nova-drm rules in drivers/gpu/Makefile, preserving
their metadata, export-selection and MODVERSIONS recipes with the sample
object names and paths. Set the PF crate name explicitly because its Rust
root file has a _main suffix.

Keep the helper out of line so the VF module has a real symbol dependency
on the PF module. The module loader therefore holds the PF module while
the VF module is loaded, and modprobe loads the dependency automatically.

Each driver has its own module registration. The VF module can be unloaded
and reloaded while the PF remains bound. Unbinding the PF disables SR-IOV
and removes its VFs before releasing the registered data. The shared
Kconfig option builds both drivers as modules or both into the kernel.

Link: https://www.qemu.org/docs/master/system/devices/igb.html
Signed-off-by: Peter Colberg <peter@colberg.org>
Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 MAINTAINERS                                 |   1 +
 samples/rust/Kconfig                        |  12 ++
 samples/rust/Makefile                       |  50 ++++++
 samples/rust/rust_driver_sriov_pf_exports.c |   9 ++
 samples/rust/rust_driver_sriov_pf_main.rs   | 164 ++++++++++++++++++++
 samples/rust/rust_driver_sriov_vf.rs        |  70 +++++++++
 6 files changed, 306 insertions(+)
 create mode 100644 samples/rust/rust_driver_sriov_pf_exports.c
 create mode 100644 samples/rust/rust_driver_sriov_pf_main.rs
 create mode 100644 samples/rust/rust_driver_sriov_vf.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 04709f381d0..2f3c0a7f7bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21142,6 +21142,7 @@ F:	rust/helpers/pci.c
 F:	rust/kernel/pci.rs
 F:	rust/kernel/pci/
 F:	samples/rust/rust_driver_pci.rs
+F:	samples/rust/rust_driver_sriov_*
 
 PCIE BANDWIDTH CONTROLLER
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 31d62533ef2..00e20e9f122 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -128,6 +128,18 @@ config SAMPLE_RUST_DRIVER_PLATFORM
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_SRIOV
+	tristate "SR-IOV PF and VF Drivers"
+	depends on PCI_IOV
+	help
+	  This option builds the Rust SR-IOV PF and VF driver samples.
+
+	  To compile these as modules, choose M here:
+	  the modules will be called rust_driver_sriov_pf and rust_driver_sriov_vf.
+	  The VF module depends on the PF module.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_DRIVER_USB
 	tristate "USB Driver"
 	depends on USB = y
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index b986b681cde..f7142bc4ddc 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_I2C)		+= rust_driver_i2c.o
 obj-$(CONFIG_SAMPLE_RUST_I2C_CLIENT)		+= rust_i2c_client.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_SRIOV)		+= rust_driver_sriov_pf.o rust_driver_sriov_vf.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+= rust_driver_usb.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
@@ -20,4 +21,53 @@ obj-$(CONFIG_SAMPLE_RUST_SOC)			+= rust_soc.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
+rust_driver_sriov_pf-y := rust_driver_sriov_pf_main.o rust_driver_sriov_pf_exports.o
+
+# Follow the nova-core/nova-drm cross-crate rules in drivers/gpu/Makefile.
+# Export Rust symbols from the PF only if the VF actually references them.
+sriov-pf-export-deps := $(if $(CONFIG_SAMPLE_RUST_DRIVER_SRIOV),$(obj)/rust_driver_sriov_vf.o)
+
+rust_needed_exports = \
+	{ $(if $(strip $(2)),$(NM) -u $(2);,) echo "__DEFINED_RUST_SYMBOLS__"; \
+	  $(NM) -p --defined-only $(1); } | \
+	awk -v fmt='$(3)' ' \
+		/^__DEFINED_RUST_SYMBOLS__$$/ { defs = 1; next } \
+		!defs { if ($$NF ~ /^_R/) needed[$$NF] = 1; next } \
+		defs && $$2 ~ /(T|R|D|B)/ && $$3 ~ /^_R/ && \
+			$$3 !~ /_(init|cleanup)_module$$/ && \
+			$$3 !~ /__(pfx|cfi|odr_asan)/ && \
+			$$3 in needed { printf fmt, $$3 } \
+	'
+
+quiet_cmd_exports = EXPORTS $@
+      cmd_exports = \
+	$(call rust_needed_exports,$<,$(sriov-pf-export-deps),EXPORT_SYMBOL_RUST_GPL(%s);\n) > $@
+
+$(obj)/exports_rust_driver_sriov_pf_generated.h: $(obj)/rust_driver_sriov_pf_main.o $(sriov-pf-export-deps) FORCE
+	$(call if_changed,exports)
+
+targets += exports_rust_driver_sriov_pf_generated.h
+
+$(obj)/rust_driver_sriov_pf_exports.o: $(obj)/exports_rust_driver_sriov_pf_generated.h
+CFLAGS_rust_driver_sriov_pf_exports.o := -I $(objtree)/$(obj)
+
+ifdef CONFIG_MODVERSIONS
+# The C export shim declares Rust symbols as `extern int`, so reuse its export
+# list but generate symbol CRCs from the Rust object instead of the shim's DWARF.
+$(obj)/rust_driver_sriov_pf_exports.o: private cmd_gensymtypes_c = \
+	$(call getexportsymbols,\1) | \
+	$(objtree)/scripts/gendwarfksyms/gendwarfksyms \
+		$(if $(KBUILD_GENDWARFKSYMS_STABLE), --stable) \
+		$(if $(KBUILD_SYMTYPES), --symtypes $(@:.o=.symtypes),) \
+		$(obj)/rust_driver_sriov_pf_main.o
+endif
+
+# Output the PF's crate metadata for use by the VF at compile time.
+RUSTFLAGS_rust_driver_sriov_pf_main.o += --crate-name rust_driver_sriov_pf \
+	--emit=metadata=$(objtree)/$(obj)/librust_driver_sriov_pf.rmeta
+
+# Allow the VF to import the PF's types.
+$(obj)/rust_driver_sriov_vf.o: $(obj)/rust_driver_sriov_pf_main.o
+RUSTFLAGS_rust_driver_sriov_vf.o := -L $(objtree)/$(obj) --extern rust_driver_sriov_pf
+
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_driver_sriov_pf_exports.c b/samples/rust/rust_driver_sriov_pf_exports.c
new file mode 100644
index 00000000000..49e435f8f6e
--- /dev/null
+++ b/samples/rust/rust_driver_sriov_pf_exports.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Export the PF crate's symbols used by the VF driver. */
+
+#include <linux/export.h>
+
+#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
+
+#include "exports_rust_driver_sriov_pf_generated.h"
diff --git a/samples/rust/rust_driver_sriov_pf_main.rs b/samples/rust/rust_driver_sriov_pf_main.rs
new file mode 100644
index 00000000000..b0795663aea
--- /dev/null
+++ b/samples/rust/rust_driver_sriov_pf_main.rs
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust SR-IOV driver sample based on QEMU's 82576 ([igb]) emulation.
+//!
+//! To make this driver probe, QEMU must be run with `-device igb`.
+//!
+//! Further, enable [vIOMMU] with interrupt remapping using, e.g.,
+//!
+//! `-M q35,accel=kvm,kernel-irqchip=split -device intel-iommu,intremap=on,caching-mode=on`
+//!
+//! and append `intel_iommu=on` to the guest kernel arguments.
+//!
+//! Load `rust_driver_sriov_vf` with `modprobe` to load both the PF and VF drivers.
+//! The VF module depends on the PF module through [`submit_request()`].
+//!
+//! [igb]: https://www.qemu.org/docs/master/system/devices/igb.html
+//! [vIOMMU]: https://wiki.qemu.org/Features/VT-d
+
+use kernel::{
+    device::{
+        Bound,
+        Core, //
+    },
+    new_mutex,
+    pci,
+    prelude::*,
+    sync::Mutex,
+    types::CovariantForLt, //
+};
+
+struct SamplePfDriver;
+
+#[pin_data]
+struct PfApi<'bound> {
+    pdev: &'bound pci::Device<Bound>,
+    #[pin]
+    requests: Mutex<u64>,
+}
+
+type PfApiForLt = CovariantForLt!(PfApi<'_>);
+
+impl PfApi<'_> {
+    fn submit(self: Pin<&Self>, vf: &pci::Device<Bound>) -> Result<u64> {
+        let mut requests = self.requests.lock();
+        let request = requests.checked_add(1).ok_or(EOVERFLOW)?;
+        *requests = request;
+        drop(requests);
+
+        dev_info!(
+            self.pdev,
+            "Handle PF request {} from VF devfn {:#x}.\n",
+            request,
+            vf.dev_id()
+        );
+
+        Ok(request)
+    }
+}
+
+/// Submits a request to the PF associated with a bound VF.
+// Keep this call out of line so the VF module has a symbol dependency on the PF module.
+#[inline(never)]
+pub fn submit_request(vf: &pci::Device<Bound>) -> Result<u64> {
+    vf.vf_registration_data::<PfApiForLt>()?.submit(vf)
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
+                        requests <- new_mutex!(0),
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
+        dev: &'a pci::Device<Core<'_>>,
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
+        let num_vfs = token.num_vfs();
+        let enabled = token.enable(num_vfs)?;
+        assert_eq!(dev.num_vf(), num_vfs);
+        Ok(enabled)
+    }
+
+    fn sriov_disable<'a>(
+        dev: &'a pci::Device<Core<'_>>,
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
+        assert_eq!(dev.num_vf(), 0);
+        Ok(())
+    }
+}
+
+kernel::module_pci_driver! {
+    type: SamplePfDriver,
+    name: "rust_driver_sriov_pf",
+    authors: ["Peter Colberg"],
+    description: "Rust SR-IOV PF driver",
+    license: "GPL v2",
+}
diff --git a/samples/rust/rust_driver_sriov_vf.rs b/samples/rust/rust_driver_sriov_vf.rs
new file mode 100644
index 00000000000..bc8e5fdc8ce
--- /dev/null
+++ b/samples/rust/rust_driver_sriov_vf.rs
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Virtual Function driver for the Rust SR-IOV sample.
+
+use kernel::{
+    device::{
+        Bound,
+        Core, //
+    },
+    pci,
+    prelude::*, //
+};
+
+struct SampleVfDriver;
+
+#[pin_data]
+struct VfDriverData<'bound> {
+    pdev: &'bound pci::Device<Bound>,
+}
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
+    type Data<'bound> = VfDriverData<'bound>;
+
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &VF_TABLE;
+
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        try_pin_init!(VfDriverData {
+            _: {
+                dev_info!(
+                    pdev,
+                    "Probe Rust SR-IOV VF sample (PCI ID: {}, 0x{:x}).\n",
+                    pdev.vendor_id(),
+                    pdev.device_id()
+                );
+            },
+            _: {
+                let request = rust_driver_sriov_pf::submit_request(pdev)?;
+                dev_info!(pdev, "Submitted request {} through PF data.\n", request);
+            },
+            _: {
+                pdev.enable_device_mem()?;
+                pdev.set_master();
+            },
+            pdev,
+        })
+    }
+}
+
+kernel::module_pci_driver! {
+    type: SampleVfDriver,
+    name: "rust_driver_sriov_vf",
+    authors: ["Peter Colberg"],
+    description: "Rust SR-IOV VF driver",
+    license: "GPL v2",
+}
-- 
2.43.7

