Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A8348C46;
	Fri,  3 Jul 2026 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783116320; cv=fail; b=mm6kZaQXp69pbt2fvqt82JTonaqoyafGvIYCuz6kSm8v/KVxvAspGMgiY63uugsWNBgBh0Ewupa4Rh4pYI+5Y75n3puQzjfR6iYjjXaSLmpt7+2LgnBG97sDxBvn1tQOKRkwbHKnCd+QB4GdLRPiiRbv8e1OAxpoRP/xqwePsyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783116320; c=relaxed/simple;
	bh=R3+CXxL+inB+XNng1jg9s51J09e8hC91ST68oSETzNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VpGWzrrueSrIsmWeYIPOFHPsEL7uBy0M7hm2YAJOMKVeyiFd6LBgFz5OuPl/JrDPz3iCRDaHjyDkz/eISnXLpGQXvxF+g1LjfOKBY0eJb4zBGBqerX5fVRpuqNeFFQlweOXMUwyRK9Nj0NVz4S3xgAhu3VGdvIDzOYN/0JMRfi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p0KHw1sy; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p0KHw1sy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMjYl5qeIYqc9zGE9tqL80DsVZifCqHBxNTCSEUOmggLgEwwSrgWHLyuywcOecVBux87gQ+nI2LOcAiVxWo3HKjkMKSiCKdnep2wJGbeyzNEKiUbNUz17r2EMM/hjyURGaDGrtGyEMdYUZnHURoh4iVs6j/V0I9cfKEI66mRHVW8RIyptXEYSJ7U9Z++KRVTr1LFnJweuIkkQQ//SSaXCTXu+FnLIyuu/PareW4x53WPvv8Qnr/9nM0pGrrUOaTZC2E8BVCetAsXLO1iEsmTK9ifiDo6/sORkDkW/eN53oSCWlgIeutbnglIAcj6T0B54zDY3jNnIF15zMwmpCt1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UShZwuF52nonyPWOTA/u0B4nw745H2doUDmk/qjCxIU=;
 b=YTt5YN0z9vqrumGLq/F0it7JfxoIL8CAiqFQtgb3fDqwDJtP7W4Y0YlxVqZCqaAKJZejxdHRxreKHB7HaIqAO3ZlyQi9cWVY8DxF9j/6IJtdGPgJepoqNNOE3l5mQVBqbcpvh7dajuGLmIDTKhJloPuSJ38umN5uHbEx/gBHknsL0i6+5SvGL5EJ9lu2fHNaIuMnG+YLetzDnwJnIDpSyid7lbPmI4NQmaBUL1XmgS5inslhCaqlCXnM1DAXkL8a32Gcf1qagY+b3sDJ6H1KTlNs9ZeZpQRpkRUxHlp3EJ5paGp2l4s21ceY7k5aTxUF5OUZakvy0QD4jHoHPBj2Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UShZwuF52nonyPWOTA/u0B4nw745H2doUDmk/qjCxIU=;
 b=p0KHw1sy+BeTDI82yM6FdxGYC6p50Bwoz0+aTpHhteS978+IW5O6jClbqB27jTlO0WNzrIP53SiYpQ4MCX2rIgbUygJbQw+KbTy4zSwWrrhRNiDajsI0HHonJjd71C/hqmlAY5KFTvq1nNa1/u04P2WMyHX5iGfiPFFc+U1gy00ASu7Ilv0B45I7abW8J2BOjCjImAbHwdnz3G3ZtCAlHakUmu2Dd4tZmY6DgxbJYF4cKZEx+l6Krcyfu1Zag5XU8RG1ZXgF2BDXNJJG8bvvlxF9hT3Pqs2JpDq0UsFnJV0A+sOjRcTGOsxcI2oZLNnbGXtlUpsgtceyCykl9quYdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 22:05:14 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 22:05:14 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v8 01/10] cxl: Split decoder programming into a reusable helper
Date: Fri,  3 Jul 2026 22:04:59 +0000
Message-ID: <20260703220508.546528-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703220508.546528-1-smadhavan@nvidia.com>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ddab32-3d5f-47e5-33ff-08ded94f2897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	wrcQXBH95C6HlPQ0ZwEG6rMChgcCp5h3Qe6IlPpngo0TINbF4YaR2/OHMSwomCXW3xOIj8wdhv3NRmo2xYR1L+0YJ9fPvl9wq6BUrZ6Ugrd8J1BZPcTpjPtu+BsdQlnI/aAl/NAi4ganqDa/VR3ZYh9OCBtCBPQkuMKPmLKK1yPMH1ZqjyX9TQXO3QqtsXPTSAqKyDiPWGPT525BGEgPcX509Es0vVn0UymNJqhhHnhzA2RP+3fnV+eRByAEp4DDfY9oOfIQnYYnPBL+gsd5Yq+SFyLBfwZAJAQZ6E3vjZNENRc2c2BtcfrsT9FqcvkvVFA9Rdn5JLj4QRrFwXB42IEP1L6VDF9zHHosz7uBMT0fWR/p2lEALJvlsr3puPgV/dDfJt4OkyZAQZSzLAacTDCMhXQ9DIMxNOwAjv89u1SatjWQp7l4Xph5LxuztrZNeGdLmG6kahwtrHVPonZAdxIVTKGM0wPER7hgNjtiHTu3BF8yX8YpnxNvuGL2OlYOoalmiCTJ9BwhaSasdLxmCAsSfaJLDgcB3bhOttIg7qqlbJRfJ93TAWmgSghd5hp7unGqbetD7qM89Jh/SDZuTlC023sUQfHIg2HCKg0Bvj0xOpLskEo1nUqkkWmTshji0MTIJdzhFr0vBhNFteaIC/A4ApEsneQQlUOhGc8k0dkfBfqDy9DunidrbYXK1pHwatkLvjPB+BsAU0Rmy+IUUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aoK5ucmaOcWH6eDiguTkXTVGPofsk+OtfonIk546JM5JExhXBdzvlo6dPWYW?=
 =?us-ascii?Q?6cR3oc6t2StX9EWLMRF3t9yNUKmeGNA2fvQSzsatakQJA0Fz9i3DIKNbKZpZ?=
 =?us-ascii?Q?MKpXIzonC09MsptFEbWPPfUqV5cHNKlv/c+lj8jkpEaDd1K2VSt174bP9Rar?=
 =?us-ascii?Q?d2GPAGgSUhEcUlTwLC+vn77lq734vqTITIhu2E5q6qATZT9JIMcJrRI8wxqn?=
 =?us-ascii?Q?zlnPxWtwd6209CW2Emr2CCFpph33mYh+mi+u9XOVTmrKxIeF/o66bn+2twZ5?=
 =?us-ascii?Q?wTF1w5OQHbP0rk8EguCoT9YqvHrpGul11jKq5mXkAprjN2l6Wtl3w8oJU1Ex?=
 =?us-ascii?Q?HyLaJ7aqrqvKvBAvmajfc7AQeii5VFu1k63tkSnsM6CI1PIjpnk60x6JyCjX?=
 =?us-ascii?Q?GIIayqrcpciq6lNI+bYaITfAhY+Tq9tkorcuFc9etqH2aojp+DTFJq3Q5Jtj?=
 =?us-ascii?Q?bQxH1iPH0zxDwkPZuqtQx71HmTA2kUkig3vkn1PnPBFg6B9j8s9lMQlByc04?=
 =?us-ascii?Q?c9MHnmTL1v8oN+zCMyJHnKBHs//UsURC/FzdIymyDDww+YTxwkddS5Onka/h?=
 =?us-ascii?Q?KxoQokZly6rjWpO5oguJvH59Kx8xc6ibmUCyN48DBnUMSvPIFvuxTasHnVFM?=
 =?us-ascii?Q?xHSyZMrXGMdw0YqXVT3/6j7m7yu1yNAOQpv9z76GU/+81kzPEtMvgFrki1DI?=
 =?us-ascii?Q?2EKPrevKEVJmm5W3QGOFtgzezmzh+lgUNV33jCEGdaZ1qgHVWecqD7mLdbrW?=
 =?us-ascii?Q?wmgu/ZkrO8y2CHvFYCvsAoa4Pj17JM8R78helDrQhsCldT3cGqgO1d47g9RE?=
 =?us-ascii?Q?upi3zQQ4ZqcQIwqXj2aLgfg6ozuvS3UyomLxJ4u9AxRxBGM0WfgFAl4Af2KV?=
 =?us-ascii?Q?EeREDKkV6/qICQ5i+6dg4xE3JVRtesZvGzgyYx1hLfmqMH334rWF5ieeyY0R?=
 =?us-ascii?Q?HTSDNFrGzuk8uF3sxIUSFmjsqNxd/xIuKMIz7cdl2EtrclVMYIKkj8kJt6Zz?=
 =?us-ascii?Q?8dkDVP3Pvgi06QIHNxpghMcBXIWGTtB1Z1kFcyVyj7uzksbhxmLiGYe5btGW?=
 =?us-ascii?Q?Bzvm1S+nN+w4kTd6VGN892NqRiSkfr0dXl0b14RnrXkMWZgbfoQF3EYMHYCh?=
 =?us-ascii?Q?5wjNx7XexgIdtj5VXJhCr8ESHs27Cph9hOCrtVf0msbC1gRcOI/WgaWmbgdc?=
 =?us-ascii?Q?mx4j6c3+IrxkElTsvcD173rIa0gs9djNbKgwoLopYG9OIbav9jA+/wfgb9v6?=
 =?us-ascii?Q?RMwxYgXNiZPkRR54ynzJgwlqd+xPLvXS10YK7nNOPQXBGsDWN7ynskN1B40O?=
 =?us-ascii?Q?9m+6sG6JJfBXl6ism33FekPPOvou8WDjpQ0D6ns0T/yOLPVGvIbb7KPMrle/?=
 =?us-ascii?Q?lqpDaBrwDq0BUYv0i252F63DRWkBqENe3b3/Lew2kE1XVYu6k5HjGuvI7wqz?=
 =?us-ascii?Q?MmcXutX/5+XJhh/tk5OcPIO7M3CfpALCQsBLUzm3gVrOLFlT8sik21yjU5D6?=
 =?us-ascii?Q?iiIS5jZtx1geYVdpNu/Of4fzUL/eznqcywAuATtWxuEf/EoZQED14tmrXH9M?=
 =?us-ascii?Q?m9WiZ+nTE1mZeGws7+WBvO5R0bgPURlkIKAhqKB5Cir1P53b/R4hUf+6iXrS?=
 =?us-ascii?Q?EFhW1LfAz8+XS0NfTd7T++9E2fhKQRAoN9hp3K2ee1xUI6TJ/Z1ediHmB25U?=
 =?us-ascii?Q?+SNqFp2lpVDfDaAAGeegIGc+8CrFe4YvCdK0gZOKEAkaDFAsOBVUnFKWe9rq?=
 =?us-ascii?Q?DpC6dOm9wQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ddab32-3d5f-47e5-33ff-08ded94f2897
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 22:05:14.1032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8O0hNiE5+qYD27/Ou3IJJeycl8iffXeV8fgKlOkIyUBKXuL4uI3Mfoee7oH+dfAdEVoayOBNd+iiIzauCRhNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

Move common HDM decoder settings to include/cxl/cxl.h and route the
register programming sequence through cxl_commit(). This lets reset code
restore cached HDM state without depending on private cxl_core types while
keeping hdm.c in charge of the existing commit policy checks.

Build the low-level HDM helper under CONFIG_CXL_HDM so it is available even
when cxl_core is modular.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/Kconfig          |   4 ++
 drivers/cxl/core/Makefile    |   1 +
 drivers/cxl/core/hdm.c       | 122 ++++-------------------------------
 drivers/cxl/core/region.c    |   6 +-
 drivers/cxl/core/reset.c     | 118 +++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h            |  43 ------------
 include/cxl/cxl.h            |  55 +++++++++++++++-
 tools/testing/cxl/test/cxl.c |  10 +--
 8 files changed, 197 insertions(+), 162 deletions(-)
 create mode 100644 drivers/cxl/core/reset.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 80aeb0d556bd..87d719ea1e14 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -6,6 +6,7 @@ menuconfig CXL_BUS
 	select FW_UPLOAD
 	select PCI_DOE
 	select FIRMWARE_TABLE
+	select CXL_HDM
 	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
 	select FWCTL if CXL_FEATURES
 	help
@@ -243,4 +244,7 @@ config CXL_ATL
 	depends on CXL_REGION
 	depends on ACPI_PRMT && AMD_NB
 
+config CXL_HDM
+	bool
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ce7213818d3c..dc075cee0450 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
+obj-$(CONFIG_CXL_HDM) += reset.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..fa978c297546 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -16,11 +16,6 @@
  * for enumerating these registers and capabilities.
  */
 
-struct cxl_rwsem cxl_rwsem = {
-	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
-	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
-};
-
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
 {
 	int rc;
@@ -255,11 +250,11 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	lockdep_assert_held_write(&cxl_rwsem.dpa);
 
 	/* save @skip_start, before @res is released */
-	skip_start = res->start - cxled->skip;
+	skip_start = res->start - cxled->cxld.skip;
 	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
-	if (cxled->skip)
-		release_skip(cxlds, skip_start, cxled->skip);
-	cxled->skip = 0;
+	if (cxled->cxld.skip)
+		release_skip(cxlds, skip_start, cxled->cxld.skip);
+	cxled->cxld.skip = 0;
 	cxled->dpa_res = NULL;
 	put_device(&cxled->cxld.dev);
 	port->hdm_end--;
@@ -388,7 +383,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 		return -EBUSY;
 	}
 	cxled->dpa_res = res;
-	cxled->skip = skipped;
+	cxled->cxld.skip = skipped;
 
 	/*
 	 * When allocating new capacity, ->part is already set, when
@@ -679,35 +674,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
-static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
-{
-	u16 eig;
-	u8 eiw;
-
-	/*
-	 * Input validation ensures these warns never fire, but otherwise
-	 * suppress unititalized variable usage warnings.
-	 */
-	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
-		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
-		return;
-	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
-		      "invalid interleave_granularity: %d\n",
-		      cxld->interleave_granularity))
-		return;
-
-	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
-	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
-	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
-}
-
-static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
-{
-	u32p_replace_bits(ctrl,
-			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
-			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
-}
-
 static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 {
 	struct cxl_dport **t = &cxlsd->target[0];
@@ -730,73 +696,6 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
 }
 
-/*
- * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
- * committed or error within 10ms, but just be generous with 20ms to account for
- * clock skew and other marginal behavior
- */
-#define COMMIT_TIMEOUT_MS 20
-static int cxld_await_commit(void __iomem *hdm, int id)
-{
-	u32 ctrl;
-	int i;
-
-	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
-		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
-			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
-			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-			return -EIO;
-		}
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
-			return 0;
-		fsleep(1000);
-	}
-
-	return -ETIMEDOUT;
-}
-
-static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
-{
-	int id = cxld->id;
-	u64 base, size;
-	u32 ctrl;
-
-	/* common decoder settings */
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
-	cxld_set_interleave(cxld, &ctrl);
-	cxld_set_type(cxld, &ctrl);
-	base = cxld->hpa_range.start;
-	size = range_len(&cxld->hpa_range);
-
-	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
-	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
-	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
-	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
-
-	if (is_switch_decoder(&cxld->dev)) {
-		struct cxl_switch_decoder *cxlsd =
-			to_cxl_switch_decoder(&cxld->dev);
-		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
-		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
-		u64 targets;
-
-		cxlsd_set_targets(cxlsd, &targets);
-		writel(upper_32_bits(targets), tl_hi);
-		writel(lower_32_bits(targets), tl_lo);
-	} else {
-		struct cxl_endpoint_decoder *cxled =
-			to_cxl_endpoint_decoder(&cxld->dev);
-		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
-		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
-
-		writel(upper_32_bits(cxled->skip), sk_hi);
-		writel(lower_32_bits(cxled->skip), sk_lo);
-	}
-
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-}
-
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
@@ -834,17 +733,20 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		}
 	}
 
-	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
-		setup_hw_decoder(cxld, hdm);
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
+
+		cxlsd_set_targets(cxlsd, &cxld->targets);
+	}
 
-	rc = cxld_await_commit(hdm, cxld->id);
+	rc = cxl_commit(&cxld->settings, hdm);
 	if (rc) {
 		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
 			dev_name(&cxld->dev), rc);
 		return rc;
 	}
 	port->commit_end++;
-	cxld->flags |= CXL_DECODER_F_ENABLE;
 
 	return 0;
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ce99f0650764..00f79b4862cb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2954,9 +2954,9 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	cxlds = cxlmd->cxlds;
 	mode = cxlds->part[cxled->part].mode;
 
-	if (cxled->skip) {
-		offset = cxled->dpa_res->start - cxled->skip;
-		length = cxled->skip;
+	if (cxled->cxld.skip) {
+		offset = cxled->dpa_res->start - cxled->cxld.skip;
+		length = cxled->cxld.skip;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
 		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
 			rc = 0;
diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
new file mode 100644
index 000000000000..14f024098e82
--- /dev/null
+++ b/drivers/cxl/core/reset.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 NVIDIA Corporation. All rights reserved. */
+#include <linux/delay.h>
+#include <linux/bug.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+
+#include "cxl.h"
+#include "core.h"
+
+struct cxl_rwsem cxl_rwsem = {
+	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
+	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
+};
+EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
+
+static void cxld_set_interleave(struct cxl_decoder_settings *settings, u32 *ctrl)
+{
+	u16 eig;
+	u8 eiw;
+
+	/*
+	 * Input validation ensures these warns never fire, but otherwise
+	 * suppress uninitialized variable usage warnings.
+	 */
+	if (WARN_ONCE(ways_to_eiw(settings->interleave_ways, &eiw),
+		      "invalid interleave_ways: %d\n",
+		      settings->interleave_ways))
+		return;
+	if (WARN_ONCE(granularity_to_eig(settings->interleave_granularity, &eig),
+		      "invalid interleave_granularity: %d\n",
+		      settings->interleave_granularity))
+		return;
+
+	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
+	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
+	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
+}
+
+static void cxld_set_type(struct cxl_decoder_settings *settings, u32 *ctrl)
+{
+	u32p_replace_bits(ctrl,
+			  !!(settings->target_type == CXL_DECODER_HOSTONLYMEM),
+			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
+}
+
+/*
+ * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
+ * committed or error within 10ms, but just be generous with 20ms to account for
+ * clock skew and other marginal behavior.
+ */
+#define COMMIT_TIMEOUT_MS 20
+static int cxld_await_commit(void __iomem *hdm, int id)
+{
+	u32 ctrl;
+	int i;
+
+	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
+			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+			return -EIO;
+		}
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			return 0;
+		fsleep(1000);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void setup_hw_decoder(struct cxl_decoder_settings *settings,
+			     void __iomem *hdm)
+{
+	int id = settings->id;
+	u64 target_or_skip;
+	u64 base, size;
+	u32 ctrl;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	cxld_set_interleave(settings, &ctrl);
+	cxld_set_type(settings, &ctrl);
+	base = settings->hpa_range.start;
+	size = range_len(&settings->hpa_range);
+	target_or_skip = settings->targets;
+
+	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	/* Target-list and endpoint-skip registers alias the same slot. */
+	writel(upper_32_bits(target_or_skip),
+	       hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+	writel(lower_32_bits(target_or_skip),
+	       hdm + CXL_HDM_DECODER0_TL_LOW(id));
+
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
+int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm)
+{
+	int rc;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+		setup_hw_decoder(settings, hdm);
+	}
+
+	rc = cxld_await_commit(hdm, settings->id);
+	if (rc)
+		return rc;
+
+	settings->flags |= CXL_DECODER_F_ENABLE;
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_commit, "cxl_core");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f43abd1903ce..b433262ab256 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -252,49 +252,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
 #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
 
-enum cxl_decoder_type {
-	CXL_DECODER_DEVMEM = 2,
-	CXL_DECODER_HOSTONLYMEM = 3,
-};
-
-/*
- * Current specification goes up to 8, double that seems a reasonable
- * software max for the foreseeable future
- */
-#define CXL_DECODER_MAX_INTERLEAVE 16
-
 #define CXL_QOS_CLASS_INVALID -1
 
-/**
- * struct cxl_decoder - Common CXL HDM Decoder Attributes
- * @dev: this decoder's device
- * @id: kernel device name id
- * @hpa_range: Host physical address range mapped by this decoder
- * @interleave_ways: number of cxl_dports in this decode
- * @interleave_granularity: data stride per dport
- * @target_type: accelerator vs expander (type2 vs type3) selector
- * @region: currently assigned region for this decoder
- * @flags: memory type capabilities and locking
- * @target_map: cached copy of hardware port-id list, available at init
- *              before all @dport objects have been instantiated. While
- *              dport id is 8bit, CFMWS interleave targets are 32bits.
- * @commit: device/decoder-type specific callback to commit settings to hw
- * @reset: device/decoder-type specific callback to reset hw settings
-*/
-struct cxl_decoder {
-	struct device dev;
-	int id;
-	struct range hpa_range;
-	int interleave_ways;
-	int interleave_granularity;
-	enum cxl_decoder_type target_type;
-	struct cxl_region *region;
-	unsigned long flags;
-	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
-	int (*commit)(struct cxl_decoder *cxld);
-	void (*reset)(struct cxl_decoder *cxld);
-};
-
 /*
  * Track whether this decoder is free for userspace provisioning, reserved for
  * region autodiscovery, whether it is started connecting (awaiting other
@@ -310,7 +269,6 @@ enum cxl_decoder_state {
  * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
  * @cxld: base cxl_decoder_object
  * @dpa_res: actively claimed DPA span of this decoder
- * @skip: offset into @dpa_res where @cxld.hpa_range maps
  * @state: autodiscovery state
  * @part: partition index this decoder maps
  * @pos: interleave position in @cxld.region
@@ -318,7 +276,6 @@ enum cxl_decoder_state {
 struct cxl_endpoint_decoder {
 	struct cxl_decoder cxld;
 	struct resource *dpa_res;
-	resource_size_t skip;
 	enum cxl_decoder_state state;
 	int part;
 	int pos;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 016c74fb747c..757d916a6330 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -5,8 +5,10 @@
 #ifndef __CXL_CXL_H__
 #define __CXL_CXL_H__
 
+#include <linux/device.h>
 #include <linux/node.h>
 #include <linux/ioport.h>
+#include <linux/range.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -23,7 +25,56 @@ enum cxl_devtype {
 	CXL_DEVTYPE_CLASSMEM,
 };
 
-struct device;
+struct cxl_region;
+
+enum cxl_decoder_type {
+	CXL_DECODER_DEVMEM = 2,
+	CXL_DECODER_HOSTONLYMEM = 3,
+};
+
+/*
+ * Current specification goes up to 8, double that seems a reasonable
+ * software max for the foreseeable future
+ */
+#define CXL_DECODER_MAX_INTERLEAVE 16
+
+/**
+ * struct cxl_decoder - Common CXL HDM Decoder Attributes
+ * @dev: this decoder's device
+ * @id: kernel device name id
+ * @hpa_range: Host physical address range mapped by this decoder
+ * @skip: offset into @dpa_res where @cxld.hpa_range maps (endpoint)
+ * @targets: interleave position to dport mapping (switch)
+ * @interleave_ways: number of cxl_dports in this decode
+ * @interleave_granularity: data stride per dport
+ * @target_type: accelerator vs expander (type2 vs type3) selector
+ * @flags: memory type capabilities and locking
+ * @region: currently assigned region for this decoder
+ * @target_map: cached copy of hardware port-id list, available at init
+ *              before all @dport objects have been instantiated. While
+ *              dport id is 8bit, CFMWS interleave targets are 32bits.
+ * @commit: device/decoder-type specific callback to commit settings to hw
+ * @reset: device/decoder-type specific callback to reset hw settings
+ */
+struct cxl_decoder {
+	struct device dev;
+
+	struct_group_tagged(cxl_decoder_settings, settings, int id;
+		struct range hpa_range;
+		union {
+			u64 skip;
+			u64 targets;
+		};
+		int interleave_ways;
+		int interleave_granularity;
+		enum cxl_decoder_type target_type;
+		unsigned long flags;
+	);
+	struct cxl_region *region;
+	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
+	int (*commit)(struct cxl_decoder *cxld);
+	void (*reset)(struct cxl_decoder *cxld);
+};
 
 /*
  * Using struct_group() allows for per register-block-type helper routines,
@@ -70,6 +121,8 @@ struct cxl_regs {
 	);
 };
 
+int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
+
 struct cxl_reg_map {
 	bool valid;
 	int id;
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 296516eecfd6..4db5071aa25a 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -840,11 +840,11 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
 		dbg_cxld(port, "restore", &td->cxled.cxld);
 		cxld_copy(cxld, &td->cxled.cxld);
 		cxled->state = td->cxled.state;
-		cxled->skip = td->cxled.skip;
+		cxld->skip = td->cxled.cxld.skip;
 		if (range_len(&td->dpa_range)) {
 			rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
 						  range_len(&td->dpa_range),
-						  td->cxled.skip);
+						  td->cxled.cxld.skip);
 			if (rc) {
 				init_disabled_mock_decoder(cxld);
 				return rc;
@@ -882,7 +882,7 @@ static void __cxld_registry_save(struct cxl_test_decoder *td,
 
 		cxld_copy(&td->cxled.cxld, cxld);
 		td->cxled.state = cxled->state;
-		td->cxled.skip = cxled->skip;
+		td->cxled.cxld.skip = cxled->cxld.skip;
 
 		if (!(cxld->flags & CXL_DECODER_F_ENABLE)) {
 			td->dpa_range.start = 0;
@@ -970,7 +970,7 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
 			to_cxl_endpoint_decoder(&cxld->dev);
 
 		cxled->state = CXL_DECODER_STATE_MANUAL;
-		cxled->skip = 0;
+		cxled->cxld.skip = 0;
 	}
 	if (decoder_reset_preserve_registry)
 		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
@@ -1021,7 +1021,7 @@ static void init_disabled_mock_decoder(struct cxl_decoder *cxld)
 			to_cxl_endpoint_decoder(&cxld->dev);
 
 		cxled->state = CXL_DECODER_STATE_MANUAL;
-		cxled->skip = 0;
+		cxled->cxld.skip = 0;
 	}
 }
 
-- 
2.43.0

