Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021112.outbound.protection.outlook.com [40.107.74.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771A48989D;
	Thu, 27 Aug 2026 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854824; cv=fail; b=EqolcGXHdYKEBqt/G8takaSxRckp8oFTNZWaG/kRokWSvbwj1sxBsQHam1wYKHsnvGVVhmcXufx7+S8QpTiAgbB7Cl7zUbhtlSCD+6hc5EVLC/6SGUszN6TzgywiRotyscA00Crk7oLj515feXC0Nmo4Nd2Cyrczlw3Ui5DMjkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854824; c=relaxed/simple;
	bh=lkRAWyjdPw2iqLJlUEbDeUYLnC9HgHV/l/FTXyJ9vVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rk85cPxkzg/7YyJiMZESzluriatIbsCHjqLSVpREq+PBdyHayCVUVSzD3LQNX/Epun9/8r2ClruJTLnKoaKYM2DtzQz6oMfFbwplzMVG/9gITln2z6Z4InABrI8T47YnzZK/f4F+uN5+UXIhtr+6+JnV+LPRweW4DnxuMDt6AQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=o6i2oFQc; arc=fail smtp.client-ip=40.107.74.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="o6i2oFQc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLR2N2SQKhh0WBbRo23RPjGjLr6Sgj7A77EFKCPVBm80c0Gl18Qzj0l218XpY3CeeHa8jM8Ooubq/S6OB1eOgu8dYpIaiZtnYzGZolXrBICfqflBd8EhiL57RB5l1tIPWFM3D/Bzd9xkq667MkTBGzqRqXwVZcyJFhC+fC+hRVIuGHIBeLB8GSwOXeE4LyJC6wrcXxSNzNxvcSVJNY/v7P7/hthmgLkVRZUD4DItvVJVNUpYEUjpdi970eAsNRkEKsSIfIizDss9z9giCAHOVDT5CEehEVNZ1LzYCfUPRDhV2LYKseoDn5JeWJCRFjHNaUnQHhhHRdJq3gwj4A1APQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtjacCaigq2Si6y5XiwB8SZ6VkEcuottmHl2Lg8WU18=;
 b=oJfhf0LYvmUnhJbe8cxPyvhNAfeDxoauunGsbvr2XGvLof23B5VLp/f+Sn0Ko99rjqDLb/R5FqMxpUcruW1w0ceIBjngdc2Bo9mLZuTnqcWBj3PO7Gdg1MbtNU+zCZ1kQ14QJi0ichUeWK6ivpM3fO2gla85FBzwD5Sw8GqVh2lq1TG5zrZ7WqPCxyAytUgT72RDE/rIifF30CEXQYoMxAp4XpBnEWTcydIdscC4go7uJkjyKS+0A0L3op8jD2y0q8Owfwf6u+lmX5wsvzNfgu7jcMCdzYqB79yG0GeRAouI4cLHwyTBltkJlNnWf1c3QGTZd/Fw6aIJpA4CnEALIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtjacCaigq2Si6y5XiwB8SZ6VkEcuottmHl2Lg8WU18=;
 b=o6i2oFQciJ5mBtIr/NFw+umWYlXS+rx+e49VvylPUsJluFbvgysPSX66ksvRMIO164GDVt39NSuRaCJLUnH2MCa8tFc4FBiymypaILrTRCSiDKHsqD2RdpmJgwdzlbPMEjasemNkFyyNijSQMh1K/t3DvYMT62Tk4b2i8WBoOjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7058.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:31d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 18:20:18 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 18:20:18 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Aksh Garg <a-garg7@ti.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	ntb@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI: endpoint: Support hardware-owned MSI-X table and PBA
Date: Fri, 28 Aug 2026 03:20:10 +0900
Message-ID: <20260827182012.1984960-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260827182012.1984960-1-den@valinux.co.jp>
References: <20260827182012.1984960-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0335.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 535128d3-088b-466e-4151-08df0467d921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|10070799003|366016|6133799003|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QKNqAj2eaaIm4GAWuaYYBrTmivzG4bxCOkdzubbvw3mGfZwBX73l7aL0O+3Ca6byp1XVjW/0eQPlP+jHfAzCXVQUunlVyjdIDFp3lv4XO/1xReSQpbcA4n6ZGmB+2tklWgcNcOzAPn2NuqJm86dto0xvWedSzFHgDDegUN83L665nEuJQVYJ07ewpCH8d0EHxMg8GL/doOzvkVwa6qXGqqYwxAfpgYbBXC6Ls8sqC7DY+PrSeYd+dlZCdA53x4VTEpTycCpqC/lX3e2iOBBrn8F855SHCzsar/eQ68Yo+uu6Bq6VDyjrHgWjXINNK1m60Gik0fVqrOWUr5REuFUbHvD4MjCUJJgL+iihj5nGre3E3q7iaHOEE+zn2iNjCsQ+oU18dxeEuqpxFRiBctt+ojezGZey2e7GjB0shpxWrW1GPE2yqE95mJXjSg8lsf8KKRYo81aciDmjAq4cIDxWnajw03q1LpvPLZ2e77AOSt0fNRCUUyoIYOm1nW9xXikFVDz4krllmQ8lsMHjSaN1nacjO7s9AjE6HqhAIWQ+BiwKvlTbq1jSCuLXFID3SYsAMawAh6eEFm14Y0Me/jUPg+02ZQQhA9Bz4IJvDHWnotgVzflFngVoteelHyy08kJEAKqogbPgxKNkoceLjo70MOV6svl15Fz+Yr4wQo5sCmQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(10070799003)(366016)(6133799003)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?skcvwv9xugQ5Xs6bVYfwMTYPOp92qM4DRjzDhauR8YWTBQcrCDNufs+n0tjC?=
 =?us-ascii?Q?hWoYwzITvYvpOJ4L2aYciBk2JKam5jCWmLKW4p6PhN2ltzxhJQKKyrWpIBQ7?=
 =?us-ascii?Q?ZTbRgcsWgJgTZyTn6JDZWFHb0yVtJ0yv3b/NpxWYd+ts4vInjzjjAfYZ+JIe?=
 =?us-ascii?Q?pBJMFLmcWuuBgyGK9JcdXVJjyhCHC2KhEuRcnAhMbSxqyZXSuz/Tdj7YbJJe?=
 =?us-ascii?Q?7bdYG78njEzc7ihUujag4gggJ44csns0GNrVvK/D77O+H37vUOP5VNmWfLII?=
 =?us-ascii?Q?UN43yk3YNPgoA8UrCvSzthyc46PkfCW9n5Np6dsi1piKoxvgOs9/u6+Mvx6i?=
 =?us-ascii?Q?ZdUmMXtGzHr/eMtnI2VdKFN9UK/YjHxNVIE+hPxlIq/0tFoS5dvtYnuOdyWR?=
 =?us-ascii?Q?AMoCX6/4//GUTF0mpw2lw/OLiokS8H9y0T3FEbqx78TUvk2ChVI55aLZujcv?=
 =?us-ascii?Q?Ce+TSGySkr2QmEtvKtGnCk5nHzSJRdmAHCuJaTVcEcfSN0lfx2lJuzwFcFuC?=
 =?us-ascii?Q?kyosoIiwUL5igxWToMAvqu0zqtL3lCwxKlvhH6/XRk/jx/BA1ukOjhRDmbTI?=
 =?us-ascii?Q?sj3KLFPsrt+VoWlCqvC/R8g6hVmYa55/s11U4hV0qRhwNbvkpC4A+d1M23RD?=
 =?us-ascii?Q?YKVdO0iTjH8LRcib2koLiBNjxNAvlmfh82TlBOhBvKOZ1XHodtgOM/cpyUd5?=
 =?us-ascii?Q?XCRkCFTbqdpx7HyvC3GblVE8FI3L7dMJYMKPuvBBlmyXOYzHKysxZc+HwICl?=
 =?us-ascii?Q?3A6CcMXL+fP/gcpz6wYznryZbsinMfAE7zzuYjyh66qk1Xkwq+bO9BbDuTww?=
 =?us-ascii?Q?hsb/j0YQBA9HCt0GVEUBXTW5Zqm7fQiiXZMYJhNkWc9tJ/mzR2j6rvCCpD1l?=
 =?us-ascii?Q?836re8anQkfhVTNCjdObJm4ytsE0NzOWmwY20OySKqPhVnbkGnIQRrBMjpkS?=
 =?us-ascii?Q?1Y67lY1tItavjKW4hTjSjo7KUVPUQyF8fVXxpve83oMLrz5GsVdhEo93wo7j?=
 =?us-ascii?Q?3LC7cJfHAA954M7AlHVUZcoF76shz6f9HuJTCawCaaYNfihwvr/Nkwf83QRH?=
 =?us-ascii?Q?rWr3idYQzQMN12o09n+Kd7P8RvJnhyhRYybZuXRMINwxdKtCqfJEo7lKaA6Q?=
 =?us-ascii?Q?/IXtphK9UIlzJ2+WmBwqBVoyuGy1dcjgglpy5UhXmu2oMmZe4yaSen27NFs2?=
 =?us-ascii?Q?5PohUCIrLiqgc6v4aOGTHTy7hr30lhk2kH17LWLfZXVbg/S4NU1gAcxCjAkD?=
 =?us-ascii?Q?uolQolEg/y79TGGzMG4y6i3IspTbfebn57d4zYzFj+sYRT+TZZQ2WENA7Kpj?=
 =?us-ascii?Q?Kn+tTGwhgi/uaw5UPwPG3ZCNKcF/3AJbgSn/VmdWDBGCLVSMBvYkTrPtv36N?=
 =?us-ascii?Q?AGsHi5urPM/ZAVa25UKv5zAYI/sy46z2Z5OZY0rAuJOlE+/AuLPiCbOE775M?=
 =?us-ascii?Q?qxxZSmaChgxthLpRAk60+NyXyPsG1tmoOGR/WWNR9ZMjhwQvXscL1KKV3PRU?=
 =?us-ascii?Q?N7a47BH3QYaAhv3DqIzLIO6WKxRoAx7OF/aUUauFtN2RTYSvB4lmXt+j54V/?=
 =?us-ascii?Q?E2JN1BjyIpbNf3L/Ov2AITU7J+VcPYuo0VMjxHogAITgytzbZEb/x3BXNquJ?=
 =?us-ascii?Q?voXKUTT5xmo8+c/7lxKRShLVoszPnUmtd5PpOzlB3PDyZ4i2nJFbgZxbn9Bt?=
 =?us-ascii?Q?pJutUFtiTPCjf5URPUNToyolXehMo2G4MA2pKaf2B6Z7G9N36y88weQJfcR0?=
 =?us-ascii?Q?l0VHf7/dIX+0KgluEo5TYbut6jUzV8STSo84B/3ZMpL3/qywfmyr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 535128d3-088b-466e-4151-08df0467d921
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 18:20:18.1597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ExQJ+a9CfGMHNXIrbylPKqqeadC6FPAj8/PkmEY2aRRHUOG9E2cdNM8z+9/TSFOrmspjMeglOAgfoxEPXvnMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7058

Some endpoint controllers expose the MSI-X table and Pending Bit Array
(PBA) in fixed, hardware-owned BAR regions. The EPC set_msix() callback
currently receives only the table BAR and offset and assumes that the PBA
immediately follows the table in the same BAR. It cannot describe a fixed
layout whose table and PBA have independent locations.

Add struct pci_epc_msix_layout and pass the full layout to
pci_epc_set_msix(). Leave layout selection to EPF implementations. For
instance, pci-epf-ntb reads the MSI-X Table from its own BAR. Using a
fixed layout there would require a way to read hardware-owned Table
entries. Add pci_epc_get_hw_msix_layout() for EPFs that want the fixed
layout. Update the existing callers and validate the supplied layout.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/nvme/target/pci-epf.c                 |  16 ++-
 .../pci/controller/cadence/pcie-cadence-ep.c  |   9 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |   7 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  30 +++---
 drivers/pci/endpoint/functions/pci-epf-test.c |  17 +--
 drivers/pci/endpoint/pci-epc-core.c           | 102 +++++++++++++++++-
 include/linux/pci-epc.h                       |  25 ++++-
 7 files changed, 168 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfec..37182f6d29b1 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -201,7 +201,7 @@ struct nvmet_pci_epf {
 	const struct pci_epc_features	*epc_features;
 
 	void				*reg_bar;
-	size_t				msix_table_offset;
+	struct pci_epc_msix_layout	msix_layout;
 
 	unsigned int			irq_type;
 	unsigned int			nr_vectors;
@@ -2187,8 +2187,14 @@ static int nvmet_pci_epf_configure_bar(struct nvmet_pci_epf *nvme_epf)
 		size_t pba_size;
 
 		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
-		nvme_epf->msix_table_offset = reg_size;
-		pba_size = ALIGN(DIV_ROUND_UP(epf->msix_interrupts, 8), 8);
+		pba_size = BITS_TO_U64(epf->msix_interrupts) * sizeof(u64);
+
+		nvme_epf->msix_layout.table_bar = BAR_0;
+		nvme_epf->msix_layout.table_offset = reg_size;
+		nvme_epf->msix_layout.table_size = msix_table_size;
+		nvme_epf->msix_layout.pba_bar = BAR_0;
+		nvme_epf->msix_layout.pba_offset = reg_size + msix_table_size;
+		nvme_epf->msix_layout.pba_size = pba_size;
 
 		reg_size += msix_table_size + pba_size;
 	}
@@ -2245,8 +2251,8 @@ static int nvmet_pci_epf_init_irq(struct nvmet_pci_epf *nvme_epf)
 	/* Enable MSI-X if supported, otherwise, use MSI. */
 	if (epc_features->msix_capable && epf->msix_interrupts) {
 		ret = pci_epc_set_msix(epf->epc, epf->func_no, epf->vfunc_no,
-				       epf->msix_interrupts, BAR_0,
-				       nvme_epf->msix_table_offset);
+				       epf->msix_interrupts,
+				       &nvme_epf->msix_layout);
 		if (ret) {
 			dev_err(&epf->dev, "Failed to configure MSI-X\n");
 			return ret;
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index c0e1194a936b..2b69ea88aed2 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -293,7 +293,8 @@ static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 }
 
 static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
-				 u16 nr_irqs, enum pci_barno bir, u32 offset)
+				 u16 nr_irqs,
+				 const struct pci_epc_msix_layout *layout)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -311,12 +312,12 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 
 	/* Set MSI-X BAR and offset */
 	reg = cap + PCI_MSIX_TABLE;
-	val = offset | bir;
+	val = layout->table_offset | layout->table_bar;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
 
-	/* Set PBA BAR and offset.  BAR must match MSI-X BAR */
+	/* Set PBA BAR and offset */
 	reg = cap + PCI_MSIX_PBA;
-	val = (offset + (nr_irqs * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = layout->pba_offset | layout->pba_bar;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7d2794945704..147b043589f0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -737,7 +737,8 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 }
 
 static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-			       u16 nr_irqs, enum pci_barno bir, u32 offset)
+			       u16 nr_irqs,
+			       const struct pci_epc_msix_layout *layout)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -757,11 +758,11 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
-	val = offset | bir;
+	val = layout->table_offset | layout->table_bar;
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_PBA;
-	val = (offset + (nr_irqs * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = layout->pba_offset | layout->pba_bar;
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 5314aca2188a..f3e0e1b3ffb9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -90,12 +90,11 @@ struct epf_ntb_epc {
 	u8 vfunc_no;
 	bool linkup;
 	bool is_msix;
-	int msix_bar;
 	u32 spad_size;
 	struct pci_epc *epc;
 	struct epf_ntb *epf_ntb;
 	void __iomem *mw_addr[6];
-	size_t msix_table_offset;
+	struct pci_epc_msix_layout msix_layout;
 	struct epf_ntb_ctrl *reg;
 	struct pci_epf_bar *epf_bar;
 	enum pci_barno epf_ntb_bar[6];
@@ -475,9 +474,9 @@ static int epf_ntb_configure_msi(struct epf_ntb *ntb,
  *
  * The MSI-X address is in the MSI-X table of EP CONTROLLER 2 and
  * the count of doorbell is in ctrl->argument of epf_ntb_epc that is connected
- * to HOST2. MSI-X table is stored memory mapped to ntb_epc->msix_bar and the
- * offset is in ntb_epc->msix_table_offset. From this epf_ntb_configure_msix()
- * gets the MSI-X address and data.
+ * to HOST2. The location of the memory-mapped MSI-X table is described by
+ * ntb_epc->msix_layout. From this epf_ntb_configure_msix() gets the MSI-X
+ * address and data.
  *
  * epf_ntb_configure_msix() also stores the MSI-X data to raise each interrupt
  * in db_data of the peer's control region. This helps the peer to raise
@@ -505,8 +504,8 @@ static int epf_ntb_configure_msix(struct epf_ntb *ntb,
 	ntb_epc = ntb->epc[type];
 	epc = ntb_epc->epc;
 
-	epf_bar = &ntb_epc->epf_bar[ntb_epc->msix_bar];
-	msix_tbl = epf_bar->addr + ntb_epc->msix_table_offset;
+	epf_bar = &ntb_epc->epf_bar[ntb_epc->msix_layout.table_bar];
+	msix_tbl = epf_bar->addr + ntb_epc->msix_layout.table_offset;
 
 	peer_ntb_epc = ntb->epc[!type];
 	peer_barno = peer_ntb_epc->epf_ntb_bar[BAR_DB_MW1];
@@ -1036,10 +1035,14 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb,
 	if (msix_capable) {
 		msix_table_size = PCI_MSIX_ENTRY_SIZE * ntb->db_count;
 		ctrl_size = ALIGN(ctrl_size, 8);
-		ntb_epc->msix_table_offset = ctrl_size;
-		ntb_epc->msix_bar = barno;
-		/* Align to QWORD or 8 Bytes */
-		pba_size = ALIGN(DIV_ROUND_UP(ntb->db_count, 8), 8);
+		pba_size = BITS_TO_U64(ntb->db_count) * sizeof(u64);
+
+		ntb_epc->msix_layout.table_bar = barno;
+		ntb_epc->msix_layout.table_offset = ctrl_size;
+		ntb_epc->msix_layout.table_size = msix_table_size;
+		ntb_epc->msix_layout.pba_bar = barno;
+		ntb_epc->msix_layout.pba_offset = ctrl_size + msix_table_size;
+		ntb_epc->msix_layout.pba_size = pba_size;
 		ctrl_size = ctrl_size + msix_table_size + pba_size;
 	}
 
@@ -1317,10 +1320,9 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
 
 	if (msix_capable) {
 		ret = pci_epc_set_msix(epc, func_no, vfunc_no, ntb->db_count,
-				       ntb_epc->msix_bar,
-				       ntb_epc->msix_table_offset);
+				       &ntb_epc->msix_layout);
 		if (ret) {
-			dev_err(dev, "MSI configuration failed\n");
+			dev_err(dev, "MSI-X configuration failed\n");
 			return ret;
 		}
 	}
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 4802d4f80f78..e48292e0fb37 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -82,7 +82,7 @@ struct pci_epf_test {
 	struct pci_epf		*epf;
 	struct config_group	group;
 	enum pci_barno		test_reg_bar;
-	size_t			msix_table_offset;
+	struct pci_epc_msix_layout msix_layout;
 	struct delayed_work	cmd_handler;
 	struct dma_chan		*dma_chan_tx;
 	struct dma_chan		*dma_chan_rx;
@@ -1221,8 +1221,7 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
 	if (epc_features->msix_capable) {
 		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
 				       epf->msix_interrupts,
-				       epf_test->test_reg_bar,
-				       epf_test->msix_table_offset);
+				       &epf_test->msix_layout);
 		if (ret) {
 			dev_err(dev, "MSI-X configuration failed\n");
 			return ret;
@@ -1288,9 +1287,15 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 
 	if (epc_features->msix_capable) {
 		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
-		epf_test->msix_table_offset = test_reg_bar_size;
-		/* Align to QWORD or 8 Bytes */
-		pba_size = ALIGN(DIV_ROUND_UP(epf->msix_interrupts, 8), 8);
+		pba_size = BITS_TO_U64(epf->msix_interrupts) * sizeof(u64);
+
+		epf_test->msix_layout.table_bar = test_reg_bar;
+		epf_test->msix_layout.table_offset = test_reg_bar_size;
+		epf_test->msix_layout.table_size = msix_table_size;
+		epf_test->msix_layout.pba_bar = test_reg_bar;
+		epf_test->msix_layout.pba_offset = test_reg_bar_size +
+						   msix_table_size;
+		epf_test->msix_layout.pba_size = pba_size;
 	}
 	test_reg_size = test_reg_bar_size + msix_table_size + pba_size;
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 831b40458dcd..4a0ceb62f38f 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -6,6 +6,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -113,6 +114,84 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_next_free_bar);
 
+static int pci_epc_get_msix_region(const struct pci_epc_features *epc_features,
+				   enum pci_epc_bar_rsvd_region_type type,
+				   enum pci_barno *bar, u32 *offset,
+				   resource_size_t *size)
+{
+	const struct pci_epc_bar_rsvd_region *region;
+	const struct pci_epc_bar_desc *bar_desc;
+	bool found = false;
+	int i, j;
+
+	if (!epc_features)
+		return -ENOENT;
+
+	for (i = BAR_0; i < PCI_STD_NUM_BARS; i++) {
+		bar_desc = &epc_features->bar[i];
+		if (bar_desc->nr_rsvd_regions && !bar_desc->rsvd_regions)
+			return -EINVAL;
+
+		for (j = 0; j < bar_desc->nr_rsvd_regions; j++) {
+			region = &bar_desc->rsvd_regions[j];
+			if (region->type != type)
+				continue;
+
+			if (found || bar_desc->type != BAR_RESERVED || !region->size ||
+			    region->offset > PCI_MSIX_TABLE_OFFSET ||
+			    !IS_ALIGNED(region->offset, 8))
+				return -EINVAL;
+
+			found = true;
+			*bar = i;
+			*offset = region->offset;
+			*size = region->size;
+		}
+	}
+
+	return found ? 0 : -ENOENT;
+}
+
+/**
+ * pci_epc_get_hw_msix_layout() - get a hardware-owned MSI-X table and PBA layout
+ * @epc_features: features provided by an EPC for an endpoint function
+ * @layout: layout to populate
+ *
+ * Return: 0 if the EPC describes both hardware-owned MSI-X regions, -ENOENT if
+ * neither region is described, or an error if the description is invalid.
+ */
+int pci_epc_get_hw_msix_layout(const struct pci_epc_features *epc_features,
+			       struct pci_epc_msix_layout *layout)
+{
+	struct pci_epc_msix_layout hw_layout;
+	int table_ret, pba_ret;
+
+	if (!layout)
+		return -EINVAL;
+
+	table_ret = pci_epc_get_msix_region(epc_features,
+					    PCI_EPC_BAR_RSVD_MSIX_TBL_RAM,
+					    &hw_layout.table_bar,
+					    &hw_layout.table_offset,
+					    &hw_layout.table_size);
+	pba_ret = pci_epc_get_msix_region(epc_features,
+					  PCI_EPC_BAR_RSVD_MSIX_PBA_RAM,
+					  &hw_layout.pba_bar,
+					  &hw_layout.pba_offset,
+					  &hw_layout.pba_size);
+
+	if (table_ret == -ENOENT && pba_ret == -ENOENT)
+		return -ENOENT;
+
+	if (table_ret || pba_ret)
+		return -EINVAL;
+
+	*layout = hw_layout;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_hw_msix_layout);
+
 static bool pci_epc_function_is_valid(struct pci_epc *epc,
 				      u8 func_no, u8 vfunc_no)
 {
@@ -443,14 +522,14 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
  * @func_no: the physical endpoint function number in the EPC device
  * @vfunc_no: the virtual endpoint function number in the physical function
  * @nr_irqs: number of MSI-X interrupts required by the EPF
- * @bir: BAR where the MSI-X table resides
- * @offset: Offset pointing to the start of MSI-X table
+ * @layout: MSI-X table and PBA layout selected by the EPF
  *
  * Invoke to set the required number of MSI-X interrupts.
  */
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
-		     enum pci_barno bir, u32 offset)
+		     const struct pci_epc_msix_layout *layout)
 {
+	size_t table_size, pba_size;
 	int ret;
 
 	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
@@ -459,11 +538,26 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
 	if (nr_irqs < 1 || nr_irqs > 2048)
 		return -EINVAL;
 
+	if (!layout || layout->table_bar < BAR_0 ||
+	    layout->table_bar >= PCI_STD_NUM_BARS ||
+	    layout->pba_bar < BAR_0 || layout->pba_bar >= PCI_STD_NUM_BARS ||
+	    !IS_ALIGNED(layout->table_offset, 8) ||
+	    !IS_ALIGNED(layout->pba_offset, 8) ||
+	    layout->table_offset > PCI_MSIX_TABLE_OFFSET ||
+	    layout->pba_offset > PCI_MSIX_PBA_OFFSET)
+		return -EINVAL;
+
+	table_size = nr_irqs * PCI_MSIX_ENTRY_SIZE;
+	pba_size = BITS_TO_U64(nr_irqs) * sizeof(u64);
+
+	if (layout->table_size < table_size || layout->pba_size < pba_size)
+		return -ENOSPC;
+
 	if (!epc->ops->set_msix)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->set_msix(epc, func_no, vfunc_no, nr_irqs, bir, offset);
+	ret = epc->ops->set_msix(epc, func_no, vfunc_no, nr_irqs, layout);
 	mutex_unlock(&epc->lock);
 
 	return ret;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f247cf9bcf1a..3d28231f092a 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -102,6 +102,24 @@ struct pci_epc_aux_resource {
 	} u;
 };
 
+/**
+ * struct pci_epc_msix_layout - layout of an MSI-X table and PBA
+ * @table_bar: BAR containing the MSI-X table
+ * @table_offset: offset of the MSI-X table within @table_bar
+ * @table_size: size of the MSI-X table region
+ * @pba_bar: BAR containing the MSI-X Pending Bit Array (PBA)
+ * @pba_offset: offset of the MSI-X PBA within @pba_bar
+ * @pba_size: size of the MSI-X PBA region
+ */
+struct pci_epc_msix_layout {
+	enum pci_barno		table_bar;
+	u32			table_offset;
+	resource_size_t		table_size;
+	enum pci_barno		pba_bar;
+	u32			pba_offset;
+	resource_size_t		pba_size;
+};
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
@@ -147,7 +165,8 @@ struct pci_epc_ops {
 			   u8 nr_irqs);
 	int	(*get_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-			    u16 nr_irqs, enum pci_barno, u32 offset);
+			    u16 nr_irqs,
+			    const struct pci_epc_msix_layout *layout);
 	int	(*get_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 	int	(*raise_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			     unsigned int type, u16 interrupt_num);
@@ -381,8 +400,10 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 nr_irqs);
 int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
-		     enum pci_barno, u32 offset);
+		     const struct pci_epc_msix_layout *layout);
 int pci_epc_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
+int pci_epc_get_hw_msix_layout(const struct pci_epc_features *epc_features,
+			       struct pci_epc_msix_layout *layout);
 int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			phys_addr_t phys_addr, u8 interrupt_num,
 			u32 entry_size, u32 *msi_data, u32 *msi_addr_offset);
-- 
2.51.0

