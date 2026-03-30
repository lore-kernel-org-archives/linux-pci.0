Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012071.outbound.protection.outlook.com [40.107.200.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694891C8634;
	Mon, 30 Mar 2026 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863766; cv=fail; b=HeWviAExRu1ByPqEt75jla2qKHyVPHUlKlg5iKWOGTvQlZSscOg2Hq/zFsQYPFaPF+XnE5HXb5jzcW17a3FmpI5e3J2TRIWtu639clf+geD3AEjRtA4Tg9StAvyFOEIadZu5XLWD9w5iFSUZMXkViexczLcxuXBfBnv69C0eRM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863766; c=relaxed/simple;
	bh=EyvVatIVXyXeSNCM6/prcte6RRawCAJS/aS2n47enuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lm8e1xG3zbaNj3MlWv16/2zDOWu0r+VUJK/byfweXr0IJaeHp9/srbnCQKozMs5AGmZJ4loNYO69x8K3HKNtE+dUySk+Mp/ZjYG3l9bPFe8Y+8MDQ+HiitdWN4Qe/NGsM5FWN/rOpZ0yTsW7UcbWXy1Nwj1La0WD5XC4oOHFB3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JvItaTnO; arc=fail smtp.client-ip=40.107.200.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JvItaTnO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlVgq3k2QFTRwYJ5lxEumqZytirX0EvAKtoGenja50je0su95DktM3kpkaQNrRCeW8Qu+uaG248G1X53HCBtRw8JUvuL7yHDZgtA72bljzDZW+SmQW16l3jY2RJQDWRYhY/Lu86x7SOU57rDocMED2OofEkIwHTS6HvJvWVOvSnWQ0O//OnlbzE6riOvbXgtzXkx5K3dLL8VIRz7M7HHUc6nZ0xeb7WI0TewRAwRZ/IWF0Vfar2dM183OLyfuSz0mK/DiWG7G2Ob/heVF8Av1rI4Mqg0vQ+RQ9+Etbl21YKftqgyw/pExK4EgLfLx7Eyd0Wy79at/PKjnREdSE/xVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05puQeVSG8BXZrIx5PxIEjjWtrnc9cX6CzV/3nzePCs=;
 b=NwpLc+a6ZEMwhZRd5txT64h9GXD8Q4bkT63jV72K/1S0pW5ZXJrBU7a4+e6SqQ7kY9+0nahCYdwgh/8tro3P2MUz6zn5c9CLxYyYhGGuwriXtejqdEKglIOYygjArRyF/nPZND+1g0EnpcMjqNS42Y0Ar5oUE9oqEDzIZyPkW8LebJldNVn1Ozj4ri8HevdD3DnZgF+GLg5Qt7aVyGJQ/KAYwuqiLr58Rux2ZQ2UUdHLEOAsiI7KIRrDX5D74PlAItW4SDG3ckMxaMtV6UcAgywQieyQFHXHRsRysAvse7lZAK2kVMPX0CnBzhMaNyKIpQGT61ojT6nVgFxRRlftUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05puQeVSG8BXZrIx5PxIEjjWtrnc9cX6CzV/3nzePCs=;
 b=JvItaTnOuR/tTnyO77z0+AZbmiUzR/tb2tgifKcTftDmrPGNffDQXaqMZBRBMpfGFmSaillWXnC5aenZk71wQEsmwj59Kn8mXy8YGn7Ir6ra+xJEJcCkgtkZIktLMx+cE8oPzi0cjG7w0T9X2utjDm4M2SGt8qYvLH1EF2keor1w398UFy0qub4Xtk1ri0bH+D2XY9x6l6STdV5G8a9q82XyShoIWCyJ7NXCFpsXpx4IFD0GbzONRDIQIJJP8GumbFMe8Kl78hT+47JqXI90GktO5m3unyHMLgEYe0PU0zZjoOe9qxrK3RtczxTlT3mk6Ry1j3bIp5GMNJ01/cmqew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 09:42:38 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 09:42:38 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: rafael@kernel.org
Cc: jonathan.cameron@huawei.com,
	helgaas@kernel.org,
	guohanjun@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v3 3/3] ACPI: APEI: GHES: Add NVIDIA vendor CPER record handler
Date: Mon, 30 Mar 2026 17:41:57 +0800
Message-ID: <20260330094203.38022-4-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260330094203.38022-1-kaihengf@nvidia.com>
References: <20260330094203.38022-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0006.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::16) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 64da0bea-24a7-481c-71b8-08de8e40ade2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ue/Zpe2fRPFbNq700TCIVuM5fIJcHOqlVSOy76sHMCBdSl5D9VUUfSgmH2Y1SRoEPwcAQ8tOtDhFkYkLIuG7q00jG6UbRUYd4FqbUtqAYnUDrQt8jwmjPWfbxxrk48PomoBTcInJYtLcMLcwAaszf8mTsEUAyDewnDOt8Aj78EqYmdFG7vNA4YJ+8oOuy3DQVY0rCLDSGufK+ed6iT2f1RMPpq15RplV7vVY6QWpiXLvIZ5XzAlnfaSJTog4V/7GAMujsZMXBcUDe72y7nlC3NO1Ko9tGal4j8XPAjwRgNso4ZOfSViOVxATL7sDTpuvtxwR/8NRkNyhLwMYFSlvwR7oBuqsX6ZENxbUj8QbEpR8YkGRKyrANgsMVjmLEBnL9x15OjS9EhnP/TMCmCf1o6D65CV5E9xto/roUsDEn3H2eoFBcmM5uJK6gNZFKF/pZSJ6rFrR8pnzy/S+rZ11WsTGIBGKW1PVwRjBk3KhoB8pgGTwXfUmzYlBKKfnJcivskFztGMKWhsJUXUaYTeLTVtxruAlj/UgD8l00nzm/6iezZS7Qdq5dh3LzyCEEvwNtfr7Q9S/umfSzDBOWTzflRJum2QENxaVGhOU4A3TTGo06nB/2D0xDlE0hA8J6rn+rS02acPypB5P9O441BDgrkkf5+AnCluUy16j4Cx706v7U9CsGuad27fFgBfrkRyyt8fSP64TujJqybDWFDNs88C+qlAk5tTIJGgBWcOolat075MOlQspk96rWCI0BHb7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3bVwh53oCCBdEP797WYrzrtoFWpbAo+H0fOq9oJUqPWm3TK8cxpg7bGC5/pT?=
 =?us-ascii?Q?gBRU0qATarZQBMVjuwzSMwS5khbfakqBm/FzLqXWmji0hqZ9lJzAtki4OiBI?=
 =?us-ascii?Q?0zuJrpvtgDXvefz9MCdq97Ad1eTrxd6A2pOejDCTnrcJN2hTZC9HGJzUHH8P?=
 =?us-ascii?Q?nmDdOeDfQXcftgZ2migibgskOtUkiMEPQ111KeC6BZ3ES4Q37awYQTo/R/IY?=
 =?us-ascii?Q?qWTmUamFB8Vd0kLwUV93vh5ZlEdZblPGIEgLSqL3yEh2mRQKxdzlv2K7Qgmv?=
 =?us-ascii?Q?RilWyOJMUe7syBviLIjFZJcXeOq/C1CT4J0BaMNEo07xTeGSLcR1C2rsJ+FG?=
 =?us-ascii?Q?Z7w1SCmDCktSelql6tZWhviUuaNrs7JBHuooIwdUWHWT2OFl+1Ps3g1Aqnq+?=
 =?us-ascii?Q?Tgzzfm2s2ipm09eNdnR0Nw9OBOQZWb9BqbE0hz8ntChpLuNiQJA7NFPLaWcc?=
 =?us-ascii?Q?nEQ2w4P+iSrtKTuxqmpWDXa4B11GKZvHaz/0YPT9z0IkfalatImgtO70+EOD?=
 =?us-ascii?Q?wLHv/tYDW/0eYaoJ7d+0vBv+L1RUpfBQBSf7sMOvUh3mkQqH695RLVLlYm58?=
 =?us-ascii?Q?F+DwWyYxuXWdjDmfa/Ucipp4PfeK9avM8KWSybAxx7G+Uiz+7kVNJo7Kkfm3?=
 =?us-ascii?Q?KDfP413L9GiaEbgiPPUGnRDlqkdFXtDFOzJ3eCdyDzJ2G6qm5rVDQuQu9uuX?=
 =?us-ascii?Q?G+/aDRRnkBhyksDclWrG35VEg15XFVsBOfFTsvFwrIIKZDQLkRmcETnS5CKF?=
 =?us-ascii?Q?wL+IEcQVSRnYjRBB4LfFof+Q/xTbCUozI1UJyGGFlks3WfRyN++55GW4af9H?=
 =?us-ascii?Q?KHcTgq1SvSkFdpGmboZPzUidWa6vYOSKReLbBLCEPa+Tvgsa1DZctdZXwQra?=
 =?us-ascii?Q?odt+ROSf1ZfPtbwOtOu06HkFxwW/cd5xKtrLLps0G1ASVozQqMIqlYgio9yT?=
 =?us-ascii?Q?cFgVzCx+TwGxMSF4jhJJG8Y6W8V3Jw9YPyJUjzwg6BQfH8cC488PTR6hVGRN?=
 =?us-ascii?Q?FJEkIshf595p4nvoLgojYBU7E+2dXt9kvtxi+IrV0MBd3AyAR31OAZRwea8d?=
 =?us-ascii?Q?vKSLEoBVTB6gPV81uOxGZDfkpTVQ15s25UTHrZoMoKz+Xfe0HmFEPf3C/MqK?=
 =?us-ascii?Q?P7EaETqLZ0Bf2ffv8quDEpzhsF4wiH5tWQV5uJSzf3XxIG2V/tUe7LDqylbl?=
 =?us-ascii?Q?prHvSFeBHDB7uUdpDEmZUxFzX/+qP4Usr9iX0j0nVijQQ6RuCXyLHzzoppLJ?=
 =?us-ascii?Q?Sp9hHGGKlUvTNe2lJaHvjkzFP6sY5RF9SPt4ShmWixAKvCdWB72SmuWMKLCl?=
 =?us-ascii?Q?4dYpJ55ejS24ZV6EvxK1HbqyUewSrHIq1C67JVS/CtEzwG7pdodsiQlDNm32?=
 =?us-ascii?Q?9yrRyEogJdBAC/UZcHjT/gsZLc9Cr3jCcZgD4Du3emDomvB5E0I7nc3UO1/0?=
 =?us-ascii?Q?JD+wzZTVq5aHMsY4hDBNLXmdS/h+Oxe2DvzI8oDIvghzwCwMD82+mVqs7Ak7?=
 =?us-ascii?Q?Y3iFwTC2XueowkTyaeMNbZuJfjy0mycxft0czqfMmDZve55PtFsO2M+iEkpH?=
 =?us-ascii?Q?1T2jGSWNhggriiiJbq3NB+vHxsF0H0Ey/VPNWZ8UlsEMTBO+0cLUyY5/3iQH?=
 =?us-ascii?Q?qxcIcWjN44KlQNhlGd360XrDnhYQbolC06/UM0oIg6B6X/0h+FG5miX6TZH+?=
 =?us-ascii?Q?ltEXjQS2jklh65Kuo9x4a5xsUFTBFtFqeSQ8xIgiIBtyXOjfscs/20/KsUQ9?=
 =?us-ascii?Q?1EYAv6IkWg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64da0bea-24a7-481c-71b8-08de8e40ade2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 09:42:38.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jv6LdTnYO3mxet3FMMBGcbBUy+EXPJAFT5mQtVtQr0CXfw7XhKq4O41lqs53AkK4Ke/FIa2gbLTMexuAn50Ncg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246

Add support for decoding NVIDIA-specific CPER sections delivered via
the APEI GHES vendor record notifier chain. NVIDIA hardware generates
vendor-specific CPER sections containing error signatures and diagnostic
register dumps. This implementation registers a notifier_block with the
GHES vendor record notifier and decodes these sections, printing error
details via dev_info().

The driver binds to ACPI device NVDA2012, present on NVIDIA server
platforms. The NVIDIA CPER section contains a fixed header with error
metadata (signature, error type, severity, socket) followed by
variable-length register address-value pairs for hardware diagnostics.

This work is based on libcper [0].

Example output:
nvidia-ghes NVDA2012:00: NVIDIA CPER section, error_data_length: 544
nvidia-ghes NVDA2012:00: signature: CMET-INFO
nvidia-ghes NVDA2012:00: error_type: 0
nvidia-ghes NVDA2012:00: error_instance: 0
nvidia-ghes NVDA2012:00: severity: 3
nvidia-ghes NVDA2012:00: socket: 0
nvidia-ghes NVDA2012:00: number_regs: 32
nvidia-ghes NVDA2012:00: instance_base: 0x0000000000000000
nvidia-ghes NVDA2012:00: register[0]: address=0x8000000100000000 value=0x0000000100000000

[0] https://github.com/openbmc/libcper/commit/683e055061ce
Cc: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
v3:
  - NVIDIA_GHES to GHES_NVIDIA.
  - Better error handling in probe()
  - "int i" in for loop.
v2:
  - Use right headers.
  - Use embedded struct and __counted_by.
  - Drop __packed.
  - Remove unecessary casts. 
  - Use * in sizeof().
  - Use devm_kmalloc() and struct assignment.
  - Use dev_err_probe and new devm helper.

 MAINTAINERS                     |   6 ++
 drivers/acpi/apei/Kconfig       |  14 +++
 drivers/acpi/apei/Makefile      |   1 +
 drivers/acpi/apei/ghes-nvidia.c | 149 ++++++++++++++++++++++++++++++++
 4 files changed, 170 insertions(+)
 create mode 100644 drivers/acpi/apei/ghes-nvidia.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c3fe46d7c4bc..94608f8e247e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18919,6 +18919,12 @@ S:	Maintained
 F:	drivers/video/fbdev/nvidia/
 F:	drivers/video/fbdev/riva/
 
+NVIDIA GHES VENDOR CPER RECORD HANDLER
+M:	Kai-Heng Feng <kaihengf@nvidia.com>
+L:	linux-acpi@vger.kernel.org
+S:	Maintained
+F:	drivers/acpi/apei/nvidia-ghes.c
+
 NVIDIA VRS RTC DRIVER
 M:	Shubhi Garg <shgarg@nvidia.com>
 L:	linux-tegra@vger.kernel.org
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 070c07d68dfb..428458c623f0 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -74,6 +74,20 @@ config ACPI_APEI_EINJ_CXL
 
 	  If unsure say 'n'
 
+config ACPI_APEI_GHES_NVIDIA
+	tristate "NVIDIA GHES vendor record handler"
+	depends on ACPI_APEI_GHES
+	help
+	  Support for decoding NVIDIA-specific CPER sections delivered via
+	  the APEI GHES vendor record notifier chain. Registers a handler
+	  for the NVIDIA section GUID and logs error signatures, severity,
+	  socket, and diagnostic register address-value pairs.
+
+	  Enable on NVIDIA server platforms (e.g. DGX, HGX) that expose
+	  ACPI device NVDA2012 in their firmware tables.
+
+	  If unsure, say N.
+
 config ACPI_APEI_ERST_DEBUG
 	tristate "APEI Error Record Serialization Table (ERST) Debug Support"
 	depends on ACPI_APEI
diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 1a0b85923cd4..66588d6be56f 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -10,5 +10,6 @@ obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
 einj-y				:= einj-core.o
 einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
 obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
+obj-$(CONFIG_ACPI_APEI_GHES_NVIDIA) += ghes-nvidia.o
 
 apei-y := apei-base.o hest.o erst.o bert.o
diff --git a/drivers/acpi/apei/ghes-nvidia.c b/drivers/acpi/apei/ghes-nvidia.c
new file mode 100644
index 000000000000..597275d81de8
--- /dev/null
+++ b/drivers/acpi/apei/ghes-nvidia.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NVIDIA GHES vendor record handler
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+#include <acpi/ghes.h>
+
+static const guid_t nvidia_sec_guid =
+	GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
+		  0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);
+
+struct cper_sec_nvidia {
+	char	signature[16];
+	__le16	error_type;
+	__le16	error_instance;
+	u8	severity;
+	u8	socket;
+	u8	number_regs;
+	u8	reserved;
+	__le64	instance_base;
+	struct {
+		__le64	addr;
+		__le64	val;
+	} regs[] __counted_by(number_regs);
+};
+
+struct nvidia_ghes_private {
+	struct notifier_block	nb;
+	struct device		*dev;
+};
+
+static void nvidia_ghes_print_error(struct device *dev,
+				    const struct cper_sec_nvidia *nvidia_err,
+				    size_t error_data_length, bool fatal)
+{
+	const char *level = fatal ? KERN_ERR : KERN_INFO;
+	size_t min_size;
+
+	dev_printk(level, dev, "signature: %.16s\n", nvidia_err->signature);
+	dev_printk(level, dev, "error_type: %u\n", le16_to_cpu(nvidia_err->error_type));
+	dev_printk(level, dev, "error_instance: %u\n", le16_to_cpu(nvidia_err->error_instance));
+	dev_printk(level, dev, "severity: %u\n", nvidia_err->severity);
+	dev_printk(level, dev, "socket: %u\n", nvidia_err->socket);
+	dev_printk(level, dev, "number_regs: %u\n", nvidia_err->number_regs);
+	dev_printk(level, dev, "instance_base: 0x%016llx\n",
+		   le64_to_cpu(nvidia_err->instance_base));
+
+	if (nvidia_err->number_regs == 0)
+		return;
+
+	/*
+	 * Validate that all registers fit within error_data_length.
+	 * Each register pair is two little-endian u64s.
+	 */
+	min_size = struct_size(nvidia_err, regs, nvidia_err->number_regs);
+	if (error_data_length < min_size) {
+		dev_err(dev, "Invalid number_regs %u (section size %zu, need %zu)\n",
+			nvidia_err->number_regs, error_data_length, min_size);
+		return;
+	}
+
+	for (int i = 0; i < nvidia_err->number_regs; i++)
+		dev_printk(level, dev, "register[%d]: address=0x%016llx value=0x%016llx\n",
+			   i, le64_to_cpu(nvidia_err->regs[i].addr),
+			   le64_to_cpu(nvidia_err->regs[i].val));
+}
+
+static int nvidia_ghes_notify(struct notifier_block *nb,
+			      unsigned long event, void *data)
+{
+	struct acpi_hest_generic_data *gdata = data;
+	struct nvidia_ghes_private *priv;
+	const struct cper_sec_nvidia *nvidia_err;
+	guid_t sec_guid;
+
+	import_guid(&sec_guid, gdata->section_type);
+	if (!guid_equal(&sec_guid, &nvidia_sec_guid))
+		return NOTIFY_DONE;
+
+	priv = container_of(nb, struct nvidia_ghes_private, nb);
+
+	if (acpi_hest_get_error_length(gdata) < sizeof(*nvidia_err)) {
+		dev_err(priv->dev, "Section too small (%d < %zu)\n",
+			acpi_hest_get_error_length(gdata), sizeof(*nvidia_err));
+		return NOTIFY_OK;
+	}
+
+	nvidia_err = acpi_hest_get_payload(gdata);
+
+	if (event >= GHES_SEV_RECOVERABLE)
+		dev_err(priv->dev, "NVIDIA CPER section, error_data_length: %u\n",
+			acpi_hest_get_error_length(gdata));
+	else
+		dev_info(priv->dev, "NVIDIA CPER section, error_data_length: %u\n",
+			 acpi_hest_get_error_length(gdata));
+
+	nvidia_ghes_print_error(priv->dev, nvidia_err, acpi_hest_get_error_length(gdata),
+				event >= GHES_SEV_RECOVERABLE);
+
+	return NOTIFY_OK;
+}
+
+static int nvidia_ghes_probe(struct platform_device *pdev)
+{
+	struct nvidia_ghes_private *priv;
+	int ret;
+
+	priv = devm_kmalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	*priv = (struct nvidia_ghes_private) {
+		.nb.notifier_call = nvidia_ghes_notify,
+		.dev = &pdev->dev,
+	};
+
+	ret = devm_ghes_register_vendor_record_notifier(&pdev->dev, &priv->nb);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register NVIDIA GHES vendor record notifier\n");
+
+	return 0;
+}
+
+static const struct acpi_device_id nvidia_ghes_acpi_match[] = {
+	{ "NVDA2012" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, nvidia_ghes_acpi_match);
+
+static struct platform_driver nvidia_ghes_driver = {
+	.driver = {
+		.name = "nvidia-ghes",
+		.acpi_match_table = nvidia_ghes_acpi_match,
+	},
+	.probe = nvidia_ghes_probe,
+};
+module_platform_driver(nvidia_ghes_driver);
+
+MODULE_AUTHOR("Kai-Heng Feng <kaihengf@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA GHES vendor CPER record handler");
+MODULE_LICENSE("GPL");
-- 
2.50.1 (Apple Git-155)

