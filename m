Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748FC43BDC8;
	Sun,  4 Oct 2026 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115749; cv=fail; b=BuzS7o4s8glHUX2XJ0wFUqSOHBgIPrHmStPPEXiB7TIJNEvF/HgVyehb0CVs3WaEn6tnoWfYqiDfUUGpXiOdRX2D6iH/wvjAf0H5VY39jBmXXMI+0VFW8OwJSjGpMkdaUOA8rmLnniC11JuzySSLuoC9fs2A872gCsdu5Sox7dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115749; c=relaxed/simple;
	bh=AfyOZX5AV33gnJjhpWqn3WJlPx5TQu4zaahnu4LiBMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPxR63epMyhO4ZtvrZWHG/UPv7Ud5JzSO/5t3HkKDPQAXqiR11P9Ij902OoP8kdMEXgAE5qARanG32k0qaqMPi2QrUPmvsXSc1vCNMd5pj78hsqnOevaEzrwb9rvFjW5fEmZjBjoGY5dGkSbYdUzuwkquUGq5LiBcURb+2220ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rdKRH4Dx; arc=fail smtp.client-ip=52.101.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rdKRH4Dx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yI0OU0gTdx6jwA39pL59S7Xy/q/NO4+W2+zEBqjVL3zqI1YVspZXMvuJ/kdO+Tc9lrj8nU3Csy6cyYidZJnXUmLmTCRYqeNqWCG4jsN8SoT8nPoPXPOo75L1upbtPIeOVIZE+iRguMOARi+0abefo1S6jpQMOcVQ0vq45nKYANxGMoulEC5fOAsneEohqY1zUhXt5DKUuVdQcIb3O8C5w5zG8DricFyCqCB88rmhVD+1axj1oTRotiIBGhzvEg9JZ6Tm/O9i6fMtzSHOfpjCar/1M9wbTySmcbplRW1APNOmgb5pQGuh7R5FpfVBCcEywCzEZpcraNRgNxC3z9rnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JdPDJnqu7UfbdNFzIctJZc44mUTxdflZqMNj1Z3rsw=;
 b=Ad+YfUBQVyV2dJp5K/ZKM5AOytBvcLgSb4g3LyDm18unilmEGaC+xudolWgUHlqxLL8/F7BkH9K2OBZwTcX03dHud+8AQ9sE/2z5+CBdmN9LgGl25U7lGFazCY62ynGtKw4FN/iiaz2FpikAALnsOEfEwwSRX9nHOFv3bwX0/ljmWbGIct3Oy20QZx1dfSzyixYxFvYmCphuZQ8CZ0/WEw956zPunr4/o4CyQHr+mMycbcPHNFAKxoWrEtI9m3W9jCnIzs2blPR4BLo5ZHGfU9ndz8DSZsP8cKO5fWNKc70eoM02C0ex6cSMEvD8g4j6DjHn1gDfREoxSh5nOiS+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JdPDJnqu7UfbdNFzIctJZc44mUTxdflZqMNj1Z3rsw=;
 b=rdKRH4DxImdxUAuSsbAlQJNe418/tD1x/vkElLYrZLl2OFoIzTi3z7gZ+01CipnD5QrHwC8IWl+TpW9vQY+1mE9gN1IzmkMfeA7wD6FrVDzhvUvpfmZguLWm/UB+AnowvFVgL6+viZDIL8qXzwO7njZIUzyrvZn7QLyJcjaq3yEltOv7koK5SqH5F0R2bsZaABPMlYC3FZ7mtDNGh0hiUhTXNUVMDjeTqcSQHqHTxNWiJg1yQutVoE+zY6wu34QZxpS3Ve9OfmYj52OiIJ+0tokJjupuIWP97tjHd6cxe/JrELFl+PloFcQdxGkyybVkqzGzqkvqZRz0A6nk7k+fLg==
Received: from BN9PR03CA0212.namprd03.prod.outlook.com (2603:10b6:408:f8::7)
 by DS2PR12MB9566.namprd12.prod.outlook.com (2603:10b6:8:279::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Sun, 4 Oct
 2026 12:09:00 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::52) by BN9PR03CA0212.outlook.office365.com
 (2603:10b6:408:f8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Sun, 4
 Oct 2026 12:09:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 12:08:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:08:44 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:08:44 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Sun, 4 Oct
 2026 05:08:37 -0700
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
	<alex@shazbot.org>, Peter Colberg <peter@colberg.org>, Zhi Wang
	<zhiw@nvidia.com>
Subject: [PATCH v4 9/9] samples: rust: add Rust SR-IOV PF and VF driver samples
Date: Sun, 4 Oct 2026 15:07:30 +0300
Message-ID: <20261004120732.1045629-10-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004120732.1045629-1-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DS2PR12MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7bace7-c356-4983-0cf7-08df22104620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|56012099006|3023799007|10067099003|11063799006|13003099007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	98nUz/8+IDaKGwQldHq+UnfiCM17dRIvgfAy1QDC43Dnl8H9R63oPE8p7u9oIGPFF4uHTsbiCXtaj4e4rowx79R3rGH0fFxQ3Q8NvlFkrXJKNJn9gEktgkkY4iHmMs/wzQ6RZcp5V8/t466f6j8Jx8QMI61vI9hlDFfeOdzeCd2CB9sALkmxivWfBPwn6C7i5hPdHAWHxASj1o1yfkK23+ciFlmKYGWuU+gb/aK0GoTWP64qoWD/lmwA4kCWMZej84K5kU+FCc0saHY+1cyLPgY0k6rVsnEFA1eytU9eLa/rHHC6AfUgnpmLfnnQ1B9JH39veyb6NFmsJ6Ey21w95nG1Ko8ls36F80hXRJIViNhJyhOkKqiqK3wHEuzw4Vrjxfn7099Kb/JRNY5ay5oVhtYOjoUBA3pIba+4Nf6D7PiD865ANXWptxElQT7t9EbRP8XWW0x5+HqLEQQCABUalDWhhIqecNZYoDD0vpXApHPdXHiOShfTLqME9osyMNH2xiWb04ENhGf2dNqYwS563D1NT5+anifaEUXgwk8YX3yLXDMv/c6nn7RkyuYtgsSSe/k9eGY7Emc9Y+YNc9q2RmkuiZDRkMA2rdKu8aS00E4laz3nycQ/l/+lesDsIMafkC2/ana/eybVvnLXc/5RT7q9g/poWSSUkTWywORO2n6zrj0VKHmwAK/XeSGG8cl9C8UiiaX7v+EQy+uRWUY1SQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(56012099006)(3023799007)(10067099003)(11063799006)(13003099007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pQIrvFGhJjlW/uF77nYrTKDC+K825cZ03AUL/EK+UKui/g++ElFYfc42co63Yq/692Jjpgjh58hpeGLpFnoyT6Zb32FhTM5jMMuPl4+/IUX0ERBGOz5SuJxdy1DgB1FBXDS+b7UMqlI7EJi0a0oG4zEGr1U28Z7pyY8IzvPIMmSgTWrAEYrDAoNO3L0wtteuEaHDnm5peNuKhY+9Ne/gwLwnKEnK3KYuWJgx0t3TPZXmKYBIUnO1bNUaqHeJ1iTn65mAsssgm9q4Gy4dYHrCTsXW4+NykvrhZcxIC7q7T4aNki39jcdk5NldQ299NI0OGc4moKQIDAPpHge7jysfeJxA75yih5XsUqDE2XgLm6IDEg/02EQPw88mFnXUgWpv9/2VSslMXIvJArtbUEtGV4sxh69qwuJQLXNfhPhxWd9BHTRUuHjNc9zHXn8FUx9r
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:08:59.9439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7bace7-c356-4983-0cf7-08df22104620
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9566

From: Peter Colberg <peter@colberg.org>

Add separate PF and VF driver modules that demonstrate SR-IOV using
QEMU's 82576 (igb) emulation.

The PF publishes a pinned API object in its private data and exposes a
submit_request() helper. The VF calls this helper with its Bound device
borrow. The helper performs the typed registration lookup in the PF
crate, keeping the API object and its lifetime encoding private. The PF
also reads the same object through its pinned registration borrow.

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
---
 MAINTAINERS                                 |   1 +
 samples/rust/Kconfig                        |  12 ++
 samples/rust/Makefile                       |  50 ++++++
 samples/rust/rust_driver_sriov_pf_exports.c |   9 +
 samples/rust/rust_driver_sriov_pf_main.rs   | 173 ++++++++++++++++++++
 samples/rust/rust_driver_sriov_vf.rs        |  70 ++++++++
 6 files changed, 315 insertions(+)
 create mode 100644 samples/rust/rust_driver_sriov_pf_exports.c
 create mode 100644 samples/rust/rust_driver_sriov_pf_main.rs
 create mode 100644 samples/rust/rust_driver_sriov_vf.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 5534401fdcce..15298da872a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21136,6 +21136,7 @@ F:	rust/helpers/pci.c
 F:	rust/kernel/pci.rs
 F:	rust/kernel/pci/
 F:	samples/rust/rust_driver_pci.rs
+F:	samples/rust/rust_driver_sriov_*
 
 PCIE BANDWIDTH CONTROLLER
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 31d62533ef25..00e20e9f1222 100644
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
index b986b681cde5..f7142bc4ddc3 100644
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
index 000000000000..49e435f8f6ec
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
index 000000000000..2fb21ff27a49
--- /dev/null
+++ b/samples/rust/rust_driver_sriov_pf_main.rs
@@ -0,0 +1,173 @@
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
+    registration: pci::VfRegistration<'bound, PfApiForLt>,
+    pdev: &'bound pci::Device<Bound>,
+}
+
+impl<'bound> PfDriverData<'bound> {
+    fn api(self: Pin<&Self>) -> Pin<&PfApi<'bound>> {
+        // SAFETY: `registration` is structurally pinned.
+        unsafe { self.map_unchecked(|data| &data.registration) }.data()
+    }
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
+            registration <- unsafe {
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
+        let api = data.api();
+        dev_info!(dev, "PF handled {} VF requests.\n", *api.requests.lock());
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
index 000000000000..bc8e5fdc8ce7
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
2.53.0

