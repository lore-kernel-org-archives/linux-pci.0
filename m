Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020104.outbound.protection.outlook.com [52.101.229.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08F543B6FA;
	Thu,  3 Sep 2026 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423912; cv=fail; b=SMcd1O2roJxEWtyIYssbepw2lfq6SvQFIFWUtgIE1w01TJ5dUUqwC+e+MjUUCk5FoXiSnEslQ4BOz1v/2N71RCUviBnIxVnE1yaTUVXNzFpUhfuRkCRgONp70pvD9r1/9RfJpdyC4NXRhHETvcMVPu1pPUgSFXoBb2KGGqibtjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423912; c=relaxed/simple;
	bh=TvZps6Ha54vTb7c77rV0lNJmeIpn9dtvRKG1Vd3CWbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OMViaz+py/LADKZYTaRcThbgvUmyQBVRJsmQxp47u860qHIwR674vijcVBbaIMiuroiDcOTUP/YUDRi7BsqitcltQ8AqAWPfOK+7BxLAsRg8kA2c4TNdfPVMqb1cF+8dL817i5G6yVWUeodSj33MwpkVgLF/OySgwtZ3W0LC6eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UZzRFu9Q; arc=fail smtp.client-ip=52.101.229.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UZzRFu9Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t02hqUgOaZa1cOLL3CieohAUUeiwim7tU7oBDrGYG+A9ySTgkBGqX13Psq+RS6fslNfUX3Z7nnIMfiblDjj4iwuFfaRcnROGxTJ0rALCAxbNP/L9MoeEhqhqbF/CP6EwybY7r5vumdmiF+y//WfLY2EenWndTY949vdgWv7sqOYoUSJ0O7EGwqLy64SeYcD79fGGyDZZr5Pc/AmOy3fxMzbkxCLnhfRthv1zNPKRHz7j3HEU6gdhn6IFvuI2AxivqHOoWECf/4BIx30I5LjzlYwSWfgau9FOQAlFSneqpYl6uyqrg6eM2sqU2kMx0aTK0IensPsQLXZggOKRkTGS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnjU1aZ/N65xf/UcI4aIwHYoNVEONblzm2OPki35Jws=;
 b=kjm987/uI5Nqi5D0NV7NZtCaXffWpw/5949b80HX4t+BEEBPm3CFhJBzqSOiOdN5kxWRJU1nwL0Q1WPvtZM9CEjkgqDnjpUNNPgbdkgaqDMMCga1+D3RF0RpYLiU+K2NJxaXSqvK97HqneCJzqidpui0+9eTe+LCmbR5A1QjEaeuQC9BS0a4xwKN9SZeHtxVj3HnBKsHp6oAogdm0tnWbPoE5wowKk/4x6uplNZDWMdfSo12s3HAv5bsb9iFFOFbY+jhV7tRsim7nIloy196WzcbZE8NFnAOH5dwfSCcdNEMQqC0xfX0oB+aJINA9b+nmaAZd548QBZ+C7W6PdJHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnjU1aZ/N65xf/UcI4aIwHYoNVEONblzm2OPki35Jws=;
 b=UZzRFu9QamjtUUAjtT+eoQywWfajm5gAKgFlJaUe1sqbpWbwWnsnvteuqOYjMAr3tUmkGlXp4QcowcFoXyyFA0YPZ/sTQRmqpgdiUYEzEMKAg74fB4h8RkX1gEGg21KoN2aQ0yl0ZMQ1FJ4qUi6OSVx9I8Wb+z95g4rHSBeJhDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6382.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:41c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:25:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 08:25:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 7/7] Documentation: PCI: endpoint: Document vNTB DMA export
Date: Thu,  3 Sep 2026 17:23:27 +0900
Message-ID: <20260903082327.2345602-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260903082327.2345602-1-den@valinux.co.jp>
References: <20260903082327.2345602-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa87af5-a113-47e6-035a-08df0994daf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|10070799003|366016|6133799003|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	dxumyipGYBtGkM6nKWxPVr9Or3yKzLKrqqSlYlvowFTE7Sm+oFppphAd6GpKLXzoPzrF16jqqxnyxfynG0oE6CKoyIJXR6iVkUvvb2jlufihbi2eJEyyRSWVZLRMU4B6ciRlC064MWpdKo5aEqrVzh+JcBQ66wSh+l+CT3VJ6cr6owfYPn5Q9J4UPN8rKFiiKp3NDIu35H9fB+g9ODXNo5krgdvPHX/VjpTFjEHmZ9Jpd/7y95YI9uWhHMk1WHCdoreFW1d2Oo2H0x2qFV4WT7ncTKd1S4CTBxnEfTlY+3XGQjtKGlAP36uFT1bLX9gZHAAkaCdhmgegxPtTc8gV5YjuWAcxM5vrXIxwlGXduZX+6gDblI8QEpQCqKKs2LLR6IfZfai+bnqByvMg27KdO8TwpeZ5lX5aZ8XPwuBNQtv9FnEZHqkte78gtVQuGZypvPHFaAJGtK2bfDoneZ/ARJMJOjIK2MDF1sV5/JsYYnkHqMc5PUt/iY0h9QcfXBJOMMmsc1XQacVXjEzoTN6Z8O+3YISuNWs9mVVfwmBezoE812PPKrS7/GBtqlbrRrkuOPrqLct/hOjkk64vJLN1cxVIUiILcU7W919T2aRtEe9zwPPHBDmq6+KF9lOnE5Bv17p2cEiPzqxLdvs0GA7VfH2XfJKgSEVNk+0eaOEIW+c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(10070799003)(366016)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DxyxQUUk9FFbi7SnLUOyteo4XSyY4S9CcmJO+RyIKAirJPIHdAap9eOoXXbc?=
 =?us-ascii?Q?xdEaCoWLHA3pDRyBGdeBbrNGZ66nDASVYVqUTNt7ugd0Y6UQHka9SfkmIclh?=
 =?us-ascii?Q?f513CXryyFk62zLaWnDKJiHUhKh7tqpZ8EXKE4rt7558P0Qfdh0NbhvDpPjn?=
 =?us-ascii?Q?xffxIYVFATTyI6mlY4WFu7hlk46SRrI23pxSu9RE13RJevhsUYHFVGXOxIcu?=
 =?us-ascii?Q?8oGH9y0xZqDFr0PffpPxoaGgvDKpesJXlH2tqsAZBpc5d/bAgDwIziiFzwa3?=
 =?us-ascii?Q?07y/k455f1w9HKDZunPufbdIbe8zl9EIEYTb3RNOdRmthi5r0RA7qalp3Quv?=
 =?us-ascii?Q?40hotY/9RDAheWIUG2kZN8QHsuRgvh5YXBMNueYSGwdK+Tnf5gTeLyF2W1Y4?=
 =?us-ascii?Q?fjdW4qgT3745LMnxRzT83UKsRAHK64YNeCgYkVHpxbdJ1UfTfTJOiewhSFxV?=
 =?us-ascii?Q?jJFWqRouAoJLepavSl2EukI6Av6fv1KZlhJjwhGni4OqqF9i9pQs4+mY2TAR?=
 =?us-ascii?Q?C8KPU3UPq9hBZyTFkpLTEM2DyqyN2DfCUtezWkwCyj2rxKfsgcBox/xLkCTb?=
 =?us-ascii?Q?qFjqnqthF9X9UTO0xbVqyzbc2u3hARmJ7b496Vyk/0zsBgu7GTJE11Bu50j7?=
 =?us-ascii?Q?GKubDOrjoATyUzqFircSMyFXIsOrCVAdRK4TtwrnvZluudRYg/5JA5wPt6Ao?=
 =?us-ascii?Q?LuJed/dvHhNgyAzOVoxOplmXGTDtEm3dDDt57qrfqJvF+cIkQnL9iE8C3/DV?=
 =?us-ascii?Q?JFt6wGJeAGbMy0WaI3srBrFksnJvpt6ODd5KtFKa6o3LPGJKup7DSiG3148b?=
 =?us-ascii?Q?x97794qNq7KlUbissJsZynurOWzUbsflPGR/GqizPC+V1Ap2BCMPcJzswPUQ?=
 =?us-ascii?Q?b6A7wgvYcP17zNdr9PC4azlYDSSUdi5YSVL587xNT5JNBOxyle3T9q3+NgHC?=
 =?us-ascii?Q?xSQQBrrTlbb7TfKMhD8+VM4RlEHSKfHn9CwMoPbTWPQYrDIKr7O9GYPb6uSK?=
 =?us-ascii?Q?ivLBFF/8ds5NSj3UMRwLz4mZfamYICsCKjXw78qhhXY0MzBhYUOYmU24htac?=
 =?us-ascii?Q?7jUBYJZUmdMJKZwQcH/JQACTVYR8uCBROyWAtDspu9Pp18SlT3A7bRNZiCPg?=
 =?us-ascii?Q?LPgZAykk0gj8j4reYmcbpiuqUHvSZn3Huil0ky95vRmdArqx5pcUEUga92xG?=
 =?us-ascii?Q?aggwA1zCDOMRM8lbh9hBI+KUCgwCNJ7t/gpVaPMTQd/Pcsy5lbhEof+zo7Kc?=
 =?us-ascii?Q?wHzbeZsC/U/9SaX2HrRKHaQq/8PLrAO3TSmWnL4eqEoDCAp8aB6DzV31KUX6?=
 =?us-ascii?Q?ux7AIbbRqYjW8PNMegpytztPYVTvxVa6hhJngU9Ckgo5WeBvihANHsHoYSmz?=
 =?us-ascii?Q?hrmtvdDVGYOZYy2472u/a0V3m5Pe4idOk8EakTW5ix3n8T6RujTsY4CAMKPe?=
 =?us-ascii?Q?9t+alPOwS6JsuHACB1/T7OZJp7wHkXP39BzyuGDT1QN8UlzjrRiP7Q/TEcma?=
 =?us-ascii?Q?Zwt9Y+jq5+e6blR/vCsayrIgRRF6eundiaCrv35NBPqBiLa5SZK73w3MTyNK?=
 =?us-ascii?Q?rewZXYXVVobJVEMzlQKRiHSkE/w6wzcTDDAMQLNIqQOxAGpM+JaqrRuCC3RK?=
 =?us-ascii?Q?AQ2v9fZIX9H9ps0yvCH11KYDzSda3AO+SqSJ8XBBvu3sYla+lHpwYe5U9WZw?=
 =?us-ascii?Q?J1ob+vlTgIAr4ptcJADoZtjddBHnP/muYnaj5P9S2lR4WOBIB1ISIAf2mApk?=
 =?us-ascii?Q?hVPEBJcKmie9w3T7rpo7aqJUMQvdoFvLRmTMzLZ/HUz88MD+Ydcq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa87af5-a113-47e6-035a-08df0994daf4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:25:04.4326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFLJ3C+HeMHxWq31KoGSaAgk6jEFkt7dgy/hM/wz/7neUwTiVwygQOJamLFrl6O6c+2u/AohUBjBuDpcTmpXrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6382

Document the dma_bar attribute and the requirements for exporting endpoint
DMA channels. Also document how the selected BAR may be shared with an MW.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Document operation without DMA when the advertised type or a DMA IRQ is
    unavailable. (Sashiko)
  - List the constraints for sharing DMA and MW in one BAR.
  - Fix the misleading sentence: s/select their BAR/set dma_bar/.

 Documentation/PCI/endpoint/pci-vntb-howto.rst | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 3679f5c30254..b5f843bdae38 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -90,9 +90,9 @@ of the function device and is populated with the following NTB specific
 attributes that can be configured by the user::
 
 	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
-	ctrl_bar  db_count  mw1_bar  mw2_bar  mw3_bar  mw4_bar	spad_count
-	db_bar	  mw1	    mw2      mw3      mw4      num_mws	vbus_number
-	vntb_vid  vntb_pid
+	ctrl_bar  dma_bar  mw2      mw3_bar  num_mws     vntb_pid
+	db_bar    mw1      mw2_bar  mw4      spad_count  vntb_vid
+	db_count  mw1_bar  mw3      mw4_bar  vbus_number
 
 A sample configuration for NTB function is given below::
 
@@ -105,6 +105,30 @@ By default, each construct is assigned a BAR, as needed and in order.
 Should a specific BAR setup be required by the platform, BAR may be assigned
 to each construct using the related ``XYZ_bar`` entry.
 
+To export DMA channels, set dma_bar before binding the function::
+
+	# echo 5 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/dma_bar
+
+This currently supports the unrolled DesignWare eDMA layout. If any DMA
+resource has no fixed BAR assignment, the EPC must support subrange and
+dynamic inbound mappings.
+
+Leaving ``dma_bar`` unassigned disables DMA export.
+With a separate DMA BAR, an older ``ntb_hw_epf`` peer can ignore the extension
+and continue without DMA. A peer that understands the extension also continues
+without DMA if the advertised type is unavailable or no DMA IRQ can be
+allocated.
+
+When ``dma_bar`` selects an MW BAR, DMA resources follow that MW. In this
+configuration:
+
+* The shared MW size must be a power of two and its translation must cover the
+  full configured size.
+* Any rounded-up BAR tail is scratch-backed.
+* An updated peer is required because older peers treat the whole BAR as an
+  MW.
+* Control and doorbell BARs cannot be shared.
+
 A sample configuration for virtual NTB driver for virtual PCI bus::
 
 	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
-- 
2.51.0

