Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285866;
	b=SAjiquTiKGRORJeBJdE8DpkecuJmd5QxscEDiDxDmE19NkDQsz0p2EHIdHfeS0qBi0Qb
	 0UHgvd9YjSab6MmUuqWjjlf0U8Svwlgn8RRgVCFipV/0lXTdzdhF8mP/wGVVj58t/IMiO
	 VyOiNiKGm/BYgUQaWYZdZ5HoFceXxdF1UKf99z803pWTpl1jyRL1ovWvIZ5qdBbTpNNvO
	 pvLLZ9+xf/2GP9U9WSmE8Ck1mucU8Cd8BS9K+VyV8Ugy8yXCu5aSklEu79bMlYc8xL6i0
	 plKDqcY2zqUsPmbHWH0os46wzqxDq9U/PsSvgH0p0s0TCnllev6PN8Wych0eawa5Izw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285866;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TovM3ry/XOo4OD7TXaZAy9mfZR3Z6lcvUQwOun9fzeU=;
	b=CktVSF5dR/pD5g+T3K6rBsGz545i1APKTJCyl/FBhqNIelL15pT5J90/pGQT89mp65bb
	 iYNYt5Ncf7OSyPi3cV1nHBuXNhz/fPmxbbRSZNW5dgL/Z4n2sf5hPV9eS5QQNANqTbFAx
	 zz3K6VQMGf61Q7d2NEb3YtyQcF+aY7JBB49Sy8HMcczmhJWPhOnZQLdDuA0qT1hwIgRbl
	 Y29mOCD0WmWb4BEpWCR50fpU07ejfX7bPKYte9Fc4/HtKyh9nk19ocXWsYomfZ7boutRm
	 E300TZMdi4wTDa9jWL89CddqadSp+R8E0vJwgCiCBPPMJfRQVPQ+TbXvbh8utoF30jA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=C1ig5vtl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.56
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AC860A261B;
	Thu, 29 Oct 2026 14:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24AC860A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=C1ig5vtl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEZEgovUO7FJuyBTOBi1/L56o3iKqQ8U9BGVNVlZhxaN/0ATOpClnYsRMRRE902jXz5lZuLM/Fm05G14BDO0zBxEv4eAvzqRTEWEX5brKnc3XzqGarq1rEHwaye0BlK2nLL/WpCGmNeJAlG3IxhjwIApL5cCIY5K+0iqF8NK5Lvq6V6KkyJVaA7cKSHhNHYPD+jjhfzHpU7frhT1OrTq7oeylA9Vi/2eJcdpL4xSlMr0k8psKheurVk5/sJsXCcjBn6hKN9cqGRVOscQGymg8VoQuwxjJw60bU2qJ1Om4ePWAkxMF28fLQzDaNWCOAOi9xBstlbqvwkqgyZFlzCrog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TovM3ry/XOo4OD7TXaZAy9mfZR3Z6lcvUQwOun9fzeU=;
 b=dO5QOAubMQi9SvthcZIQK/9UvbqKAr9KbZCj+3YMON/kIOsxtIfGY0SZ6jsvIoaMMSTQtb4o7OIzsPawJ7IYM++t41nhW6Hck3aLS5JNV1l+dfrabJhgP++g07NZXbcPCFeeZtb/uRYspSNChOpDcKYrt0Ip5dCRRRTYrUpqP7qxIDM+N1JGrJjbgkVqefrfnkhdu49cfSg7FAMOeUlFh3Jlarf/c1lrKr6GjR4j/dYP9527WdEfDjwCUoSJuM9tWzdHSmZVH92dPaQLNGvggnxC9/rGjSIZqLpUFRGnlVO4yzEwiO2yC9qxr4E3w+RPq8b2Q8uIWzR8qW0hH4JBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TovM3ry/XOo4OD7TXaZAy9mfZR3Z6lcvUQwOun9fzeU=;
 b=C1ig5vtlQD/S+fghlC08vg+fzvDTZulm3Eu5S2Yn3JuoDoFRy3LlAsCBgaRrv/Top+VdG6JzN7ZrAHFU03vaqke1rs7mgC/G9Dc84DjcqmFszTSJdUHW0J5Ug0TG/CsCXa5ND8VZYGI9HbTiz5kVdgp09zQwS9E6EtzOM5/NAqN+hUVGiTXe13+Y2Ljc1EIi7TQIMXqG4u3iv3wN5MTMXMdahyZ6bJXN5m9XIAAaA/lYXCcF3rad85bf8IDWOdfA3PdsLItAcVE9LvpYOTW0sXrGIV5C6FDt5OOdv6bHSUSdtoJmi9IMrEc5W/PiSm3XfnIeY142JYwWwWsSNGIvbw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW6PR12MB9020.namprd12.prod.outlook.com
 (2603:10b6:303:240::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 14:57:41 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:40 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v16 10/18] cxl: Build register block helpers into the kernel
Date: Thu, 29 Oct 2026 14:56:55 +0000
Message-ID: <20261029145703.2185231-11-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0273.namprd04.prod.outlook.com
 (2603:10b6:303:89::8) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c9667b-84a9-4939-1a6a-08df35ccfa47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|261028144727099003|261026140227099003|921020|11063799006|5023799004|260925022911599003|56012099006|261021121427099003|10067099003|261022105027099003|261009223027099003|261021123027099003|261022075727099003|260925021311599003|261026121527099003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	Qo2cQOPyov/UVS9/jXoTUM2wWzstsSV3QfhI3zx45iE8HzLEQu7dhTfb9GDJZAfem/V6zhuS23Ku+4yEU7K3smX3DR6mRYM3qsGK7gCTBHjo+9waRg+zoXsCxY1kHrLvYjzsPYmemmr+R/AIS1DGxmSmd8wx1H3ujBk2XkkI8v8uuSlcI3m2dunzjgYoPML1vwMw3lcac06br/aZimfus5VnDBaKWUJSmZJxaNyazMejg2y4/cyP6bPdsi4x9iq2dwVzqGOVA9WY0eOYzNMQDT2v+ICKoRF9qtl8VlY12chFb+qVeu5g8E+sfZMBvStjlA3ZoLrmwDhQHlKfbprvKLJWxP2ZWjtMFgSg+b7hLq09yCsKJaZe6m4FM51Ft+f9PM+M9+QNsA11281YMsW1gSZ+93iC3XGAGSZ/4fwWr6q2Yklz9kj7iA9jlbIiByZMJ34WQVqMpPnR5bTBKGE+pOolRmT5baLMA1KMioGgeF/72fS9iab+yqN5t6fr9CFwhLZVrfzbyATvLsygh4QwXrbGfpyQWO4nci2pSIHWQv16JawG2LAijXdJs3Zl7q6SqqOOBwchFf7Dw4A+TjV8+9oTPA5YkJ2PcWz0Ux4m65FbjFaC9oRqFdJvI8DsD0HpUA6SllUARmwMr0YHcldUQ4KwoomtOoOCb/Zl48FtnfjdZn8zhuSNEUs3+8XfvcKNhWw/CYNgiUg9oDP2UyPNiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261028144727099003)(261026140227099003)(921020)(11063799006)(5023799004)(260925022911599003)(56012099006)(261021121427099003)(10067099003)(261022105027099003)(261009223027099003)(261021123027099003)(261022075727099003)(260925021311599003)(261026121527099003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zULOoove60hzynm+Wadq9J1pdkgKkLukExfgTEX+08gMCg6zjC5p39K/EFlT?=
 =?us-ascii?Q?fOzSRW3DMRPPDD7b4JuRvXB2LX+bCr92TqufSF4gpW8G4ADrg9e5O2MADBSa?=
 =?us-ascii?Q?z/kvLCU0SL/w3C08SCCRnGIvWm1uRtZTP9JKaSa6nTaxLAoeP/qhTOiIrKpz?=
 =?us-ascii?Q?gqNEzY4SFQchd6gauKnGjRwvg0Zk8Csz/s05s9slhtBs5qXtGPMrjiuN01hk?=
 =?us-ascii?Q?SuMQoUejhKHxH6qS+1qnma9OHhKqVjp2jxMvMT4L9qafVUC3Zhj/5igBiedZ?=
 =?us-ascii?Q?f8iajbgSB/9Mcpf7Woxvacf0qNHM0l21gufTDpcXauQcDAaoHuCBAIw1v0sT?=
 =?us-ascii?Q?qUBKTS/1bAoE9EUToexBNluiRbksjnwRjD16+dkuRFtIsQzYdTL31T52lZMC?=
 =?us-ascii?Q?H8tRM6orxPmpW66B5RoDGqdGCNYFEVgQVREgk7qNKGtV1HI7XCZl6JeCKFCp?=
 =?us-ascii?Q?fGC1/XelYYPK8yrrxmOCz4nNw6cuKYkUZrWAoQE1jHFxwJbyGos4Vn/yRWQ8?=
 =?us-ascii?Q?NLveBd9sHh/+7aik8nebKkjt7jtfTRfNplAj1e6TsPguMA742hZIDa9NNIj/?=
 =?us-ascii?Q?e9b8XYRheWEyUA6UVM42sVRZ8F8IQ+e/oBkC5yWNeaZYKJ9ViyRUHNph3vnH?=
 =?us-ascii?Q?P+NCxLL0wfXDpaQSbxSdSznDpppoImF2yDWRVfKh3spNcI1cHYsM+Eo2yZ4c?=
 =?us-ascii?Q?WW/z2aQEsraMMSxpc0/TbPAYcKm03bk472zZnX9BeP5h9kM8FWxV73ac9rxE?=
 =?us-ascii?Q?PPHQHOHSea8NpJ5l6X1aXNuSbvElGBzM04nlmgBahjqT6iV5hZEkccSnZpJ1?=
 =?us-ascii?Q?Ho8J/zlnFPd/mz/9fiw6aE408M2QIiXkXkzJL7p7t8HGYPzP/qfIdRp+gO3g?=
 =?us-ascii?Q?T7aUwWArZiJAwcZadTBkSpnbLQiQdUI0yNH+bF/avxxXCAwEhpuaXEFLD87I?=
 =?us-ascii?Q?YKN2YSIGjPh8qK0HKtaGllJY6sZjoUlegbIzWDpmrI7ik/yneZOqI3z/px/q?=
 =?us-ascii?Q?gp7wsd4O58wfvj8bSGBcfs3YBxQPkwNLFqYlLSHPGGTznvGKPmPAxZHoNg3j?=
 =?us-ascii?Q?TSkDkwk8/rWPvTkgkSzN2+Jxh8ZlKIOndsz5W+mmMzw7kCroOJwukcqFaWlQ?=
 =?us-ascii?Q?Yf9JzYbQVWa8i9BB3GDjRjNPYDYSE0j50/Sid+XQZXWTNooCmJsV18+SbKyj?=
 =?us-ascii?Q?Skk4VQDu3H/iF9QVLIqOD/5Ms5we718qRJ9xWky38ksn81qAuoT+WEMea6dC?=
 =?us-ascii?Q?zsUP7ng0vKapptGWtRXYEFGn60Cq1XmqA6Lu1cnCYz39UKvTHBqnNzirGtxR?=
 =?us-ascii?Q?0vCEStwW+FlzdHdqF1S4MrLcxxCv62vdUkRj3HFuKVnts1xb3YTp3t243RX0?=
 =?us-ascii?Q?Ls6Gjs1G48V6XigBQO9by2BwSXFtphZT9LoS1wOlaoAb5Np+fQCaWfZ+M25J?=
 =?us-ascii?Q?21hzFq0r+qHgiGR/SC4xL8CvninZuCGo6c8dkcAZG2sHItUuLB9nx8C+NjcK?=
 =?us-ascii?Q?Gz36NqZULrt7xIrjb2llUdcEve88JGM1p3zF+t4LyXDhzKeCVRTzvqQqunK8?=
 =?us-ascii?Q?qk0psLsr4fvsOQv8sPWi5cLv4oewpWNNYDT0+vOyga8AkEaZlSV7goI5AAWY?=
 =?us-ascii?Q?Khj2jzumkYY59I3VZ/Q9EN3h9lY2s3hRB5vTeDmbidoPcslUBu90OG1vGoAb?=
 =?us-ascii?Q?OTNJO6IaFIRDLiOORVO+0BtOA8reRZYAPY2JIla6Zr22b9CbOitwijCeTUMr?=
 =?us-ascii?Q?ukXpwTAFog=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c9667b-84a9-4939-1a6a-08df35ccfa47
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:39.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAh2uGtDpVzflVZBa6+7w8VXdcWLho5yDXgiA8ZPauzbl89ICylHswkr3GCUM13I9kEDEZHED3ixiDGfOnwk0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020

Build register discovery with the built-in HDM helpers so PCI enumeration
can use it even when cxl_core is modular. Export the interfaces used by
cxl_core and preserve the BAR and offset in the register map.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/Makefile |  3 +--
 drivers/cxl/core/regs.c   |  9 +++++++++
 drivers/cxl/cxl.h         |  3 ---
 include/cxl/cxl.h         |  6 ++++++
 include/cxl/pci.h         | 13 +++++++++++++
 tools/testing/cxl/Kbuild  |  1 -
 6 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 9971efb237fb..9a77e68d44ce 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o
+obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o regs.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
@@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
 
 cxl_core-y := port.o
 cxl_core-y += pmem.o
-cxl_core-y += regs.o
 cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 20c2d9fbcfe7..def3c20d1a7a 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -200,6 +200,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_FOR_MODULES(devm_cxl_iomap_block, "cxl_core");
 
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
@@ -285,6 +286,8 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 	}
 
 	map->reg_type = reg_type;
+	map->bar = bar;
+	map->bar_offset = offset;
 	map->resource = pci_resource_start(pdev, bar) + offset;
 	map->max_size = pci_resource_len(pdev, bar) - offset;
 	return true;
@@ -309,6 +312,7 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
 	*map = (struct cxl_register_map) {
 		.host = &pdev->dev,
 		.resource = CXL_RESOURCE_NONE,
+		.bar = -1,
 	};
 
 	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
@@ -339,6 +343,8 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
 	}
 
 	map->resource = CXL_RESOURCE_NONE;
+	map->bar = -1;
+	map->bar_offset = 0;
 	if (index == CXL_INSTANCES_COUNT)
 		return instance;
 
@@ -518,6 +524,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
 
 	return offset;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
 
 static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
 {
@@ -634,6 +641,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 
 	return component_reg_phys;
 }
+EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
 
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport)
@@ -642,3 +650,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 688350c7c5fb..ad4e80be2bd7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -239,9 +239,6 @@ enum cxl_regloc_type;
 int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
 int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, unsigned int index);
-int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-		      struct cxl_register_map *map);
-int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 341a7c52894a..206acf5845e1 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -27,6 +27,7 @@ enum cxl_devtype {
 
 struct cxl_region;
 struct cxl_hdm_info;
+struct pci_dev;
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
@@ -150,6 +151,8 @@ struct cxl_pmu_reg_map {
  * @base: virtual base of the register-block-BAR + @block_offset
  * @resource: physical resource base of the register block
  * @max_size: maximum mapping size to perform register search
+ * @bar: PCI BAR containing the register block
+ * @bar_offset: register block offset relative to @bar
  * @reg_type: see enum cxl_regloc_type
  * @component_map: cxl_reg_map for component registers
  * @device_map: cxl_reg_maps for device registers
@@ -160,6 +163,8 @@ struct cxl_register_map {
 	void __iomem *base;
 	resource_size_t resource;
 	resource_size_t max_size;
+	int bar;
+	resource_size_t bar_offset;
 	u8 reg_type;
 	union {
 		struct cxl_component_reg_map component_map;
@@ -168,6 +173,7 @@ struct cxl_register_map {
 	};
 };
 
+
 /**
  * struct cxl_dpa_perf - DPA performance property entry
  * @dpa_range: range for DPA address
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 3e0000015871..b15d7e415e27 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -4,6 +4,8 @@
 #ifndef __CXL_CXL_PCI_H__
 #define __CXL_CXL_PCI_H__
 
+#include <linux/types.h>
+
 /* Register Block Identifier (RBI) */
 enum cxl_regloc_type {
 	CXL_REGLOC_RBI_EMPTY = 0,
@@ -19,4 +21,15 @@ struct pci_dev;
 
 int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 		       struct cxl_register_map *map);
+int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
+		      struct cxl_register_map *map);
+int cxl_setup_regs(struct cxl_register_map *map);
+/*
+ * CXL r4.0 sec 8.1.3.1: a CXL.mem capable device reports one or two HDM
+ * ranges. 00b is illegal when Mem_Capable is set and 11b is reserved.
+ */
+static inline bool cxl_dvsec_hdm_count_valid(unsigned int hdm_count)
+{
+	return hdm_count == 1 || hdm_count == 2;
+}
 #endif
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 2be1df80fcc9..e80500f457a9 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -55,7 +55,6 @@ obj-m += cxl_core.o
 
 cxl_core-y := $(CXL_CORE_SRC)/port.o
 cxl_core-y += $(CXL_CORE_SRC)/pmem.o
-cxl_core-y += $(CXL_CORE_SRC)/regs.o
 cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
-- 
2.43.0

