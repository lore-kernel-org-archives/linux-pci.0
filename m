Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793289525;
	b=z8ZniwJrOlCktdchsdArXBjVXYWiJS+QBnObzzmACWea3EqgXeqag0HD4Ej3IUXue8WS
	 4RH8Oh1bSJZJVoiG+F+UxYXexYgS9g0MVSJRwDQJ9mzkFsu+l4jcAFV7yGpHEHDfNxwoA
	 489wsrviqiFble0i+/ZvLKNgg8RAGhuRAHCzOWeqWH+ZOaTAzWxAgkqpVGU9MmTwWWQOP
	 npD1yuS0d1TesiuekvLWFrUQNet5oXBVGveywNt3aykgTzMHR3HeOvT+i0ZCF698O0QaZ
	 uOQW4gCyTgRnP9r2theYw6H9ge2OSzfvMZCI0cDsOBd6Fe3CqLAmebImQ8CGVAz/1/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289525;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=H1cqxFrVKquOOum3+Hhh+FgmtxuDsLwprwiR/2+fVXo=;
	b=vHm0bbd76r2mliIcYc4H8OQr2hc1Yq7wz9l0dGl0jjxRvaYPjbuacEeO+qh+7AKsAv2v
	 r18a6+TCDdnwe1OL2KTL7zxR/ONqeoJe+ZB4/HaRYuX6vvA+wlnXqQVvIMLvLmxnL/DAB
	 gZzidfbkw9WLL74+bHtoVgN0Hf7TmWx4pOWFT9Wuvtaf+r/pCrVqxFqHbgtFdPwmracF/
	 AwR5+bzy2bfZ+c0sAm4paCCXX+0mG1lHzeMApyOSFCbE9L53SX7fOqhLP3TscLnExqBEl
	 p4eFZVkDZuHS8wgSwh3BRYj/G7KUw2DYLDDSSaOzTSoU8RhGxXuE2bXWK5MCwkiOZhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fgRz5CBd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.52
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B36606A31A;
	Thu, 29 Oct 2026 15:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67B36606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fgRz5CBd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2OnFRoUclgnJCj8iX0i/uKUiOwJpRSm9b53R2d5luAkqpMRF4sqVPrGeOBbp5SoUd4ukKymUId4WvBUiSwTMC3JHb/yNKOfeI1uCQH9djIFXzXiRo2AEEwxT+qm1TQQC0ZpQnHfGUhBym16iIcaS/puK4b7lllTeC4keyI0rvRBlXmM6nThUl3pEm2SBX8MJJznpJP7KHbZqPivhhd2zLY47ZqIMpxXM+GvOIUrvnWbT9dhlx9l0KcjrXwkf22NO6YQnt85oJvQ9begTlQgs2d4OhrnoXyTxHmQwSzasrDKjddGcYWyg/Q7eSNWT7G4Obe+mJk0JpEMLfuzke2EfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1cqxFrVKquOOum3+Hhh+FgmtxuDsLwprwiR/2+fVXo=;
 b=qLy0UAzxuz7Ki4UKxb4SPH1zl81Lzd54Cq/qG7pJj7t6Vo6hZ2+DgQE2zhJtrsl+tbwJnJ/3CXdL2qqYzx1nNZaNx/fbAZ64daDSp9BIBWQpADZk42fc68Qrt71SNeXyzI/XPHbXLkWfUKm9KHF8PsAYUU85fsMWYnY/CYp4RiG6Q+84xobRzz64ZoR8Q3ZO+GssiHuQG8Xot8sj0KBrFK0gDcXM4j7TvEgu6wbs3x6SQkURxmNNHqi8gX1Qyt+oS31ocNCR2kfoY11HsBZQ1FCqbEEUsb/yG0YRQYAn7rUyFb1axvFcULME5fcBz74+EVkBlrBTjlgFuxn1YUb3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1cqxFrVKquOOum3+Hhh+FgmtxuDsLwprwiR/2+fVXo=;
 b=fgRz5CBdsbifEB1jg/gHi2oF7+YdTslsspwDb4nlBt6IUugjB1w2pT2vMq67PG4pf6/EHFarcYehweGhRzqil5nqVhJa5uRgbX2pKMkF/i/CtCSaMYdP2plSQuIYRhb7znMwC/4UhYnXVWU9pDRcYJOCMp6jskMjdJKdqoutK4omKJX/btru+BjkgERusD/zYLN6ensUfJs0MOMct8KIQD4H1Dfvzr44SvjBwzURESwjG75ZWAuptuHUsL0FPwi+uwsqlvG7nD06DLVHzad7SRy6IIDTw0mgTUOiYq6q3urPSVqmJkynzasVd79vTq1Cub6LltjvrpKOvYR+yV+x0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SA1PR12MB6845.namprd12.prod.outlook.com
 (2603:10b6:806:25c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 15:58:39 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 15:58:39 +0000
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
Subject: [PATCH] PCI/CXL: Flush host and device caches for CXL bus reset
Date: Thu, 29 Oct 2026 15:58:36 +0000
Message-ID: <20261029155836.2253844-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::14) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cfc9c1a-6e36-4051-7754-08df35d57f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|18002099003|921020|56012099006|5023799004|11063799006|261028144727099003|261022075727099003|10067099003|261021121427099003|261022105027099003|261021123027099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	DUCFI4Hso90h4uLpe82VFCF11RDNDBkYqyHhYYtU/UKtBOHZ6HFINi+4ffbSEcT7xJUs+y6U/4w6YFWF0u1bZjPY2nBqxCYCWudD/l5NNzY7buSSi0phEBkEozBqQs75xH1KLU4UOSPorZg9WzzhDWSZ3eNfX4tcuiDPp+/ojR2x17eBcVnunGpOdd39etd2BSi2KzjhBBQbPtseTdI/pA+ZzSdnw3xh3GpuVDOulG3ETzxvOncPY+8GKg6hkFAlL+jmRC8uzLhbHBC4rlKPTw2mGkCLzc/Riaw9VjewcTltiptqvDN9FxFER5UsHb/u/QyE9pbBSF9khIruYkuvaJm3um5Z0LmwU06ym7C+gYLqQ/9Xg7ap+f7wqSQrT9YoS1aXC7/DODl2jfkgyyx+wLJQ6gNY3OYA3sINCakgEFGQNKZiq4o/0QrQ1reuPhf0X7WEpODaYsO6fk2b3YmahGQZYGR5s/5ClNrKCcB3Qc7zgRWhfTiy07qSfjTWjlfJ5DCzeSleTnoF1YZeuX5+nk6ebYU9ohEInsRrKOwcA/giJ6IvPG0xJfgSdoccfCkvaGRTAjRA79rAfdSBh0IYBXIe4DMPuoHHsxmEzVaRSXalbxMk8vU3gg9003GIhCxhdlwKRYHQ38Pusm9rFTdYj/IS6mWqQWXAnQ35bkI+yK6aq0WEAB7DcMDZSTrJ5tlIj+QIe/UNbQHO4ivoPojq1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(18002099003)(921020)(56012099006)(5023799004)(11063799006)(261028144727099003)(261022075727099003)(10067099003)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2fYIkGj3VecaiWp/At3heZmxIeuSe80vFzXVqiIvMd3nMuGHdJeCRP+VTQO2?=
 =?us-ascii?Q?vzB5A0rU4XUde+KFYpsp84XCENCufPcFbuJGusZRRb4CFCY/NQD8vvzt/j8A?=
 =?us-ascii?Q?k+/clQU8vPXey+nCHamWrSN0BV5F7rDvx+55e9PQGpXr/36X9LA1TR4tAlKb?=
 =?us-ascii?Q?9t0N/6I4vcRvD9zV3OOzPzJeimd3OwOzXqNa+eBmeSlrkw9bp0suO9UAcEba?=
 =?us-ascii?Q?ss8qJHeM2K1J0vLbmlDsf8Se/k8jARPwFVy7ZlQBPrpIgQiMt5nSoTZ9kB/u?=
 =?us-ascii?Q?bFO3yIl29rTIG2ReDhuaWzNJ4lw4BdarcDFQJhAzxIimWrlIDj88Nbd39wKQ?=
 =?us-ascii?Q?2ocDWklCCV6U25f6OUyP6iFv0xxXENxsUOBYJPKV2A+GzOyK5GeoRHQzSXrZ?=
 =?us-ascii?Q?bBauVG/FXYX1Z85IotTCvin/EDi8j0G4Jk3kCXpntPYv2yAPrwg7nYPH56ev?=
 =?us-ascii?Q?7cN206jEebJD6KoHOqnY0Er3HKFTBqiAhI2ePWKFaFz3q6IEzIg+eUIq0Y2+?=
 =?us-ascii?Q?dOn7IBY7WU+ooAwv2O2vMjXhTKGoNZ089xRSUHHWRggxQJDhDFe3z1NMqly3?=
 =?us-ascii?Q?Fb4hxbxL7njdvg2iGc+GzVlRdc60qNgOKNMq2PYljSQqOOLhLU/bKsLYgprx?=
 =?us-ascii?Q?TfaxEcRC3zo5oSR4sERHH7jxkmIoU0HlQNayNqPB4PLNIFlsQiPEcpySz993?=
 =?us-ascii?Q?qvNl6VSjawH3TUoqg5EEKJNLcQz9qSgOn2G+U9W/pPDVSwfq3L5JBJRRFiAs?=
 =?us-ascii?Q?z3Km7QLZ/zLbd4fi3oq6qrCDmh6mGBDcreyR3xcrHD1/1//XI46rA14GY9Qm?=
 =?us-ascii?Q?Owe65NTv3uOOJgWsG9MoQkXRAwUrPSdzD8I1Dx35U6x3Dra7Mrw5MX1CzA4b?=
 =?us-ascii?Q?yqmwkAcWn0gdHmjFJ91WnUWleKxICWxPpNqjqJgmgOj4FnbXR7I31Efmm4TU?=
 =?us-ascii?Q?MkJKt7czFiKExnJSBjH0aPNtyWII9ZtA5AMNlJxczbSAnlrpwkaUSO/cbC7Y?=
 =?us-ascii?Q?41XU8HJjVOXJFb1MFkJPNeJX5uIZF/6fQr2sGz3cqPx+cofFwc1r1mXXx1dJ?=
 =?us-ascii?Q?+Pqq50nMJlv3+RM8YLHkEr/5jMzsjio4GRO2d6yuQdfjqqkA6oDr81FkPl3W?=
 =?us-ascii?Q?rK4PdjCjGiLlMZqTwYrQeO3fPK1LkwHPwbFjTO1DsdjimiCFTQFGAUEa6bLT?=
 =?us-ascii?Q?74kAquZJV2YX+r0OxOwc/p7hEHGEJMigHGYi6yzuDxug4CmVR3VWe4hwe5KW?=
 =?us-ascii?Q?hUu4i8U+b6vqlILqYCtkwcwvDP9f17+dJc0eXd6OBp0WbepIN0Qr9ozlM8wJ?=
 =?us-ascii?Q?JPFDlGTb6BNYiS4x6pMpZy2neBouBxCQdDZuVKAYaepL6J14omd8Y0pIVI7k?=
 =?us-ascii?Q?zIHAHbpDDjCdx9BQk3XNQAuGC3fciIQOrQ7P4NSchktTvu4+Bv4FLRoxpt5Z?=
 =?us-ascii?Q?BXq7dyDYIWwPpzMHDTpB6yfvI9aquJvJbkZ3Ewj8RHMtsJ2B961VMgvC0jAm?=
 =?us-ascii?Q?u0GbZOBYSsq5RSGXuOiPy8W/hgDi1TwKuNaiJEz+ea9MfhjQB2Z+nWj2nl8b?=
 =?us-ascii?Q?vFPmHU0MUr7Kggt775VHLiUmToE7iZMWNRQ30jQrhbBeVapXMaosHDAYQfTs?=
 =?us-ascii?Q?m3GHCZ6Y6ufDFGqYYMNWJQD3qcbc0ununt/aBVCgEvG1Bo90EyHbWP8m9lYA?=
 =?us-ascii?Q?CydFcgzlpBUaawZecDTM5Bus0cvB60AlKrPjX0jLzLEwnbyQUqVE1dj85/xH?=
 =?us-ascii?Q?c7+pp4ZqEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfc9c1a-6e36-4051-7754-08df35d57f93
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:58:39.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2cFny+BVSiQ9BE6y4w40WCI1Pdxq3pqKGplI6GuxKBz05O/Th/xFbliYyQ8ZKrDgOee7I7ByCGjvGV8Qaj1HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845

CXL bus reset can reset a Type 2 device while its host and device caches
still contain data for the device's HDM ranges. Flush the host caches,
disable device caching, and trigger device cache writeback and
invalidation when supported before reset. Invalidate the host caches
again before ending IOMMU exclusion.

Hold the CXL region quiesce from snapshot through restoration so region
commit and teardown cannot change the decoder state while the reset is
in progress. Reserve the affected HPA ranges and preserve the device's
cache policy across the operation.

If reset was not attempted, undo preparation without changing the saved
PCI command unless cleanup fails. After an attempted reset, keep the
device disabled on recovery failure and do not re-enable caching against
unrestored HDM state.

If no cached HDM state exists, retain the existing CXL bus reset path.
For a device with cached state, reject the reset if its cache-maintenance
state cannot be safely prepared or restored. An invalidation provider is
required unless the existing test-only CXL_REGION_INVALIDATION_TEST bypass
is enabled.

This builds on the v16 CXL reset series. The global region lock is held
through bus reset and restoration.

Link: https://lore.kernel.org/linux-cxl/20261029145703.2185231-1-smadhavan@nvidia.com/
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/cxl.c | 168 ++++++++++++++++++++++++++++++++++++----------
 drivers/pci/pci.c |   9 +--
 drivers/pci/pci.h |  18 +++--
 3 files changed, 152 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index 5aa97705a669..60e9e45f80b9 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -389,71 +389,169 @@ static int pci_cxl_restore_state(struct pci_dev *pdev,
 	return cxl_restore_state(pdev, snapshot);
 }
 
+static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec,
+					  u16 saved_ctrl2);
+static int cxl_reset_cache_prepare(struct pci_dev *pdev, int dvsec, u16 cap,
+				   const struct cxl_hdm_info *snapshot,
+				   struct cxl_pci_cache *cache);
+
 /**
- * pci_cxl_reset_prepare() - allocate HDM state storage ahead of a bus reset
+ * pci_cxl_reset_prepare() - prepare HDM state and caches before a bus reset
  * @pdev: device about to be reset
+ * @cachep: receives cache state owning the region quiesce on success
  *
- * Copy the cached HDM state before the reset, so that restoring cannot fail
- * for lack of memory. The decoder settings are refreshed when the state is
- * restored.
+ * Capture HDM state under the region quiesce, reserve its ranges, and complete
+ * host and device cache maintenance. Hold the quiesce through reset and
+ * cxl_restore_state_after_pci_reset(), which consumes *@cachep.
  *
- * Return: storage for cxl_restore_state_after_pci_reset(), to be freed with
- * kfree(); NULL when @pdev has no cached HDM state; or an ERR_PTR() on
- * failure.
+ * Return: snapshot to be freed with kfree(), NULL when no cached HDM state is
+ * present, or an ERR_PTR() on failure. A cached device without a valid DVSEC
+ * snapshot is rejected because its cache-maintenance scope is unknown.
+ * Only a successful non-NULL snapshot returns with the region quiesce held
+ * and *@cachep set. The caller must pass both to
+ * cxl_restore_state_after_pci_reset() even if reset is never attempted.
+ * The snapshot remains caller-owned. All other returns leave the quiesce
+ * unheld and *@cachep NULL.
  */
-struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
+struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev,
+					struct cxl_pci_cache **cachep)
 {
 	struct cxl_hdm_info *snapshot;
+	struct cxl_pci_cache *cache;
+	u16 dvsec, cap;
+	int rc;
 
 	device_lock_assert(&pdev->dev);
-	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
-	if (IS_ERR(snapshot))
-		return PTR_ERR(snapshot) == -ENXIO ? NULL : snapshot;
+	*cachep = NULL;
+	if (!cxl_hdm_cache_present(&pdev->hdm))
+		return NULL;
 
+	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
+	if (rc == -ENOTTY)
+		return ERR_PTR(-ENODEV);
+	if (rc)
+		return ERR_PTR(rc);
 	/* Raw reset callers may not have saved the PCI state needed for restore. */
 	if (!pdev->state_saved) {
 		pci_err(pdev, "CXL bus reset requires saved PCI state\n");
-		kfree(snapshot);
 		return ERR_PTR(-EINVAL);
 	}
 
+	cache = kzalloc_obj(*cache);
+	if (!cache)
+		return ERR_PTR(-ENOMEM);
+	cxl_region_quiesce_lock();
+	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
+	if (IS_ERR(snapshot)) {
+		rc = PTR_ERR(snapshot);
+		goto unlock;
+	}
+	if (!snapshot->dvsec_ctrl_valid) {
+		rc = -ENXIO;
+		goto free_snapshot;
+	}
+	if (cxl_hdm_cache_dvsec_decode(&pdev->hdm) ||
+	    (snapshot->dvsec_ctrl & PCI_DVSEC_CXL_CACHE_ENABLE &&
+	     !(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))) {
+		rc = -EOPNOTSUPP;
+		goto free_snapshot;
+	}
+
+	if (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) {
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
+					  &cache->saved_ctrl2);
+		if (rc || PCI_POSSIBLE_ERROR(cache->saved_ctrl2)) {
+			rc = rc ? pcibios_err_to_errno(rc) : -ENODEV;
+			goto free_snapshot;
+		}
+	}
+
+	rc = cxl_reset_cache_prepare(pdev, dvsec, cap, snapshot, cache);
+	if (rc) {
+		if (cache->cache_disabled)
+			goto finish;
+		pci_err(pdev, "failed to prepare CXL bus reset ranges: %d\n", rc);
+		cxl_hdm_quiesce_destroy(&cache->quiesce);
+		goto free_snapshot;
+	}
+	if (!pci_wait_for_pending_transaction(pdev)) {
+		rc = -ETIMEDOUT;
+		goto finish;
+	}
+	*cachep = cache;
 	return snapshot;
+
+finish:
+	rc = cxl_restore_state_after_pci_reset(pdev, snapshot, cache, false, rc);
+	kfree(snapshot);
+	return ERR_PTR(rc);
+free_snapshot:
+	kfree(snapshot);
+unlock:
+	cxl_region_quiesce_unlock();
+	kfree(cache);
+	return ERR_PTR(rc);
 }
 
 /**
- * cxl_restore_state_after_pci_reset() - restore CXL state after a bus reset
+ * cxl_restore_state_after_pci_reset() - finish a prepared reset and release its quiesce
  * @pdev: device that was reset
  * @snapshot: storage from pci_cxl_reset_prepare()
+ * @cache: quiesce state from pci_cxl_reset_prepare()
+ * @reset_attempted: reset helper was invoked and may have affected hardware
+ * @rc: preparation or PCI reset result
  *
- * Under the region quiesce, refresh the decoder settings in @snapshot from the
- * cache and restore: first the PCI configuration needed to reach HDM MMIO,
- * then the HDM decoder and CXL Device DVSEC state. Leave @pdev disabled on
- * failure.
+ * Restore state through pci_cxl_restore_state(), complete host invalidation,
+ * and restore the cache policy changed by planned-reset preparation. When
+ * @reset_attempted is false, undo preparation without changing the saved PCI
+ * command, unless cleanup itself fails. After an attempted reset, keep caching
+ * and the device disabled if state restoration or host invalidation fails.
+ * A reset-helper error does not prove that hardware was untouched.
+ * Unplanned recovery uses pci_cxl_restore_state() directly and owns its own
+ * quiesce and cache-maintenance sequencing.
  *
- * Refresh the decoders now rather than rely on the copy taken before the
- * reset: a region commit or teardown during the reset has updated the cache,
- * and restoring older decoders would leave the device decoding ranges the
- * CXL core considers free.
+ * The quiesce blocks region commit and teardown throughout reset. Complete
+ * host cache invalidation before PCI operation resumes, then release the
+ * quiesce and free @cache on every exit. @snapshot remains caller-owned.
  */
 int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
-				      struct cxl_hdm_info *snapshot)
+				      const struct cxl_hdm_info *snapshot,
+				      struct cxl_pci_cache *cache,
+				      bool reset_attempted, int rc)
 {
-	u16 command;
-	int rc;
+	u16 command = 0;
+	int rc2, policy_rc = 0;
 
+	if (!cache)
+		return rc;
 	device_lock_assert(&pdev->dev);
-	cxl_region_quiesce_lock();
-
-	rc = cxl_hdm_cache_copy_decoders(&pdev->hdm, snapshot);
-	if (!rc) {
+	if (reset_attempted && !rc)
 		rc = pci_cxl_restore_state(pdev, snapshot, &command);
+
+	/* Complete host invalidation before ending IOMMU exclusion. */
+	rc2 = cxl_hdm_quiesce_flush(&cache->quiesce);
+	if (rc2)
+		pci_err(pdev, "failed to invalidate CPU cache after CXL bus reset: %d\n", rc2);
+	/* Undo preparation on abort; enable caching after reset only if safe. */
+	if (cache->cache_disabled && (!reset_attempted || (!rc && !rc2)))
+		policy_rc = cxl_reset_restore_cache_policy(pdev, snapshot->dvsec,
+							  cache->saved_ctrl2);
+	if (reset_attempted) {
+		rc = rc ?: rc2 ?: policy_rc;
+		if (rc)
+			cxl_reset_save_disabled_state(pdev);
+		else
+			rc = cxl_reset_save_restored_state(pdev, command);
+	} else {
+		/* An aborted reset alone must not poison the saved PCI command. */
+		if (rc2 || policy_rc)
+			cxl_reset_save_disabled_state(pdev);
+		rc = rc ?: rc2 ?: policy_rc;
 	}
-	if (rc)
-		cxl_reset_save_disabled_state(pdev);
-	else
-		rc = cxl_reset_save_restored_state(pdev, command);
 
+	cxl_hdm_quiesce_destroy(&cache->quiesce);
 	cxl_region_quiesce_unlock();
+	kfree(cache);
 	return rc;
 }
 
@@ -573,7 +671,7 @@ static int cxl_reset_cache_prepare(struct pci_dev *pdev, int dvsec, u16 cap,
 	int rc;
 
 	rc = cxl_hdm_quiesce_prepare(&cache->quiesce, snapshot);
-	if (rc)
+	if (rc || !(cap & PCI_DVSEC_CXL_CACHE_CAPABLE))
 		return rc;
 
 	/* Track an attempted change so partial failures still restore policy. */
@@ -710,7 +808,9 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
 		rc = __cxl_reset_execute(pdev, dvsec, cap, snapshot, &cache.quiesce,
 					 &command);
 	/* Restore cache policy after any attempt to disable caching. */
-	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
+	rc2 = 0;
+	if (cache.cache_disabled)
+		rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
 	cxl_hdm_quiesce_destroy(&cache.quiesce);
 	if (rc)
 		return rc;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 22f740417673..351a0f0500c1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5015,6 +5015,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 {
 	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
+	struct cxl_pci_cache *cache;
 	struct pci_dev *bridge;
 	u16 dvsec, reg, val;
 	int rc;
@@ -5037,14 +5038,14 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (rc)
 		return -ENOTTY;
 
-	snapshot = pci_cxl_reset_prepare(dev);
+	snapshot = pci_cxl_reset_prepare(dev, &cache);
 	if (IS_ERR(snapshot))
 		return PTR_ERR(snapshot);
 
 	rc = pci_dev_reset_iommu_prepare(dev);
 	if (rc) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
-		return rc;
+		return cxl_restore_state_after_pci_reset(dev, snapshot, cache, false, rc);
 	}
 
 	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
@@ -5061,8 +5062,8 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
-	if (!rc && snapshot)
-		rc = cxl_restore_state_after_pci_reset(dev, snapshot);
+	/* Reset-helper failure does not prove that no hardware reset occurred. */
+	rc = cxl_restore_state_after_pci_reset(dev, snapshot, cache, true, rc);
 
 	pci_dev_reset_iommu_done(dev);
 	return rc;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 476e8eefafb2..f0ebfd408f8b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -731,13 +731,17 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
 struct cxl_hdm_info;
+struct cxl_pci_cache;
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
 void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
-struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev);
+struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev,
+					struct cxl_pci_cache **cachep);
 int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
-				      struct cxl_hdm_info *snapshot);
+				      const struct cxl_hdm_info *snapshot,
+				      struct cxl_pci_cache *cache,
+				      bool reset_attempted, int rc);
 #else
 static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
 static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
@@ -746,16 +750,20 @@ static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	return -ENOTTY;
 }
 
-static inline struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
+static inline struct cxl_hdm_info *
+pci_cxl_reset_prepare(struct pci_dev *pdev, struct cxl_pci_cache **cachep)
 {
+	*cachep = NULL;
 	return NULL;
 }
 
 static inline int
 cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
-				  struct cxl_hdm_info *snapshot)
+				  const struct cxl_hdm_info *snapshot,
+				  struct cxl_pci_cache *cache,
+				  bool reset_attempted, int rc)
 {
-	return 0;
+	return rc;
 }
 #endif
 
-- 
2.43.0

