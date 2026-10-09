Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020125.outbound.protection.outlook.com [52.101.228.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72F2D8DC4;
	Fri,  9 Oct 2026 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791521708; cv=fail; b=tgKFde4gNanAz1TCdZXi336rWjqdU1MfLSggvfp1cfX6NToT6JqxgSud2C3vVZcPcHIxQnVYLVW2YWUvZH/qXMon0e0PWbFW/8f8vg16xldmaz4N4jKUr0dEjMV2J/qCBtPXXnF7MxhM41g6EnwgVnY0MHLqhlphoIuGkE6F1g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791521708; c=relaxed/simple;
	bh=kzSbrRzp8w/TaSTjs2Z1iazPo6IDsROYA2M2taeDnJw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V8bXLKrvvMYzcYE86jrMLLhTT7JovN4/25E0+AmBEtRcz0wuu7c5Pt00df2lGkNeohxWIq0m1VodkRrDOm4EyhtUyALweUK22syTn6plT/clBtJJ4JYex15Uolh26N1wWyIzIKxCv4k7a3fRUOkSagKzrs7SRbh7OCPKISthb8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=canwu3Jn; arc=fail smtp.client-ip=52.101.228.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="canwu3Jn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVsyi58V1XG4zmAWWEdZCqzLOMtUKofNWxcQN++lBwP37gFocpqrMQ+iCqklla6JlQkuQcf/cJJITFXxu6A0ffLy5ccfpIpNEKZUvWB+70rItY/kLvVyZ5b3bEgckne4Q5yc+r5egdSPykWR+D7vU4RvnYgC9Txn7LEhOvcpMlCeBn9jWOX6yMD+niardHnp/rUawEiMOJIy0PPyQQjosld8R2kS9F22j49mOLcWC4o4RguBUfKoH5o6kyi1oEziV4vAFVQbPOLyIXfGTDQ3tEFJ7UFT1KqtZDcn1VoY/IkS8FOwomsEskhHsdv+Y51q0q35bXyfFP0gXX6bbE05xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FhGNCxo6ybHz6aq8QMrGPBgFCTI7jamDWsvn45bI9w=;
 b=dTE7VwK4/BckSMJ4HOYrT1DoDIIQDY70mssEPywfA6TopkHZcqCxY24E1pTnj3ukhQ46mTWRCalm6VRw0P6CGmBVNl4jqssj7eeVz+LvWBYEfJ5SG6EbsuUCPjzar62gS5VEN+1uzEmysVNQHTOcW7Y690y584IWDcOfjMnYF4dNTw1ev6ma1kit91xwetPjj799IFcWwkq88VUdFsbf0UfdNQHzz7VB2QFMGvrhkhkm3EudnO5RWhRbIM+5mvF+nTbnLnphq3scIL3A2+05ZfDM0xvBgLv02sErZZhdu+NHNJY4cgn5JQ2y1u4b/quDUwHZiTa5L4A26d8ZdBtQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FhGNCxo6ybHz6aq8QMrGPBgFCTI7jamDWsvn45bI9w=;
 b=canwu3JnIdIbhWzBpfsTy90cFwVmQN4bic5jj9/WAJIJiqvdQ8J92GjukO8xoGZ+teNKC5q2R/JqqJ1usdmHZstBg0XQBf7awAxEr9r3rPNyZJ6bu3TY3ZlSsa+QsvJwqr26NUbAI2YYG4m19jIX8CoQ9KTMgRDWoDhYGKox8L0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB2561.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 04:55:03 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 04:55:03 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Alejandro Lucero <alucerop@amd.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/3] cxl: Fix link latency calculations and QTG latency units
Date: Fri,  9 Oct 2026 13:54:49 +0900
Message-ID: <20261009045452.1107921-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0134.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY3P286MB2561:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa4c7be-f88b-47bf-e2f9-08df25c17ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|10070799003|366016|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	101Po0BuZ2HSiC5qQuIka+pNz9kcHwsNGuwOP2OcOSaavKBCMi0f+p6Zo+1dpSNEiBd7Xnb4PpaTbbGL9CtK5pDKP4skJGyNw5SxRGvAXOZTYuGipekQHsd36WWkmPxhYnf18/p9HX/FxbEGhiD7KAucgVgH/lxJXuYsxH9bHo2y/hAJSoiTbnsxFlP8+8/i0caYiCe1ZNd17vlCwkubv6UmPOi1siai7NIN5TyM4WoKX7rcHKHgL77xeJE7IYRWKGM9x8+zOLggyxyLX47tMY1NNzgwWZ4TiJ3S2qkLOhWdK2DWbBLkC+sP7lea1PNMwU9ZLzf/CgwIGbTZ9+n4HoRaF3e9/XB/5tuKCz61wb8vHB7isf/j+zDdIL9BKSnEBf8DPc6NVsR5lat+UjQngHZ3BtUUcgsoVm7/rPo3K/WOmcM1Yk85OuFCm97dCNBxsjgAOjTVZGF/Qnxy6AVrriTOH6+c0nepf0OTaDXSULSkT+RxYk+65uyS9nxQC1u/dHKd/1N+LrifufVISTeR7hTbkg1o5z9X3gtVLMOtjfYXmgnxpAw3nLRc/yIVWr8od91ZfSyt/gm5cWO6StmxnMoSxlPFG3KOx8b0NOVIw8jDN46cfwC5/bN8wj6IxOup7q+7uS2UQ53ZRksc+gIZNPAcKdaqtKK4QM2LBQ6AW/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dAjhhG79Ia0bDnm2Qfx3ZYf/uMIuyrqMI3JIJecE0IrHrQ8mUcsUTnUZXJnk?=
 =?us-ascii?Q?Zs6q+gH+KyWj2jSQ9ixAHfLs7Y6RiUToiC598MXASQVkbisFXyXOG1iATnlI?=
 =?us-ascii?Q?PkLTYXN7uoYw6FXZ36aj6ryO9nLyUg4LXnByUBrbdyp9eqayw7b3+/gjVOLg?=
 =?us-ascii?Q?sB+6rSUTP59Vxv/QhgRLJgMx+bUes+YxMwp8iGp77VmbTPx3JiHh5Mkxmd/r?=
 =?us-ascii?Q?L4vHqRA0RQkiDZq9AcggyD/ln5g+yUesDwIKcd4FX2Tf74rjOR0mtJF+VFIh?=
 =?us-ascii?Q?HgICPLdbzUZSSCg81O0DpnNUyy9F7pDYJ03HncdQwT2AHJbynDQh4M5eTcA/?=
 =?us-ascii?Q?904o91Z09c09SnUm0XWId+WiqptbYYkOEuc+NaUyXV2WrzTOGAS6dU1JlIMO?=
 =?us-ascii?Q?xgkbXNmDzGDSqPUWc/kKAByzwOw+kjMRYTDN8iIBDX/apblLQe1neWitrmS4?=
 =?us-ascii?Q?tNnX+DQl1xrUK9rGKm2U2oE6oSIpm5TW+FK+iExd1ofS/KwQOVjy/moXrlH6?=
 =?us-ascii?Q?4OUaDWhfGjBjwcEhjr53HXyhG3sDKucDPfTCZ1X2avQF6Z5qBlmAHrwMo2cU?=
 =?us-ascii?Q?c8t6f5WZmFBmHiccjVal0eSPSQOSpYRRKOJn8EHyN4hG/FGuIq2nfEvreqZq?=
 =?us-ascii?Q?DGpSBmUqD2fmbxbUT2hyTrJMDDkf3VZAye9KR/SYZGv399N4MHk4mWmVlaSJ?=
 =?us-ascii?Q?cd6wVx4z5sr0HCid+IaDPS3g2hC1gzP9vQ0kVtPVg4Rw3qQK1pzIAhoU6vKb?=
 =?us-ascii?Q?JeJPz+X/cZs1QXkXlv9uDzUquqTBMNKBFiU3mGMvC/+erG9eSR5rLMvtyLyH?=
 =?us-ascii?Q?NRma8qN23Iu6+NAj5SjdVVx41Dyhb4PKA3bx9MwPv2Q9Hm1ybimIkQlhz9iB?=
 =?us-ascii?Q?Pt69a8SUsqXMN6f+I/SkEQKFVgdrtq7n17uPx6u85JETorce1XRtCiafrf/f?=
 =?us-ascii?Q?/HesJUXmRZjsMmIncx9Xg5W8iV49Sj/Fx1DCpWZYMBfOhDgCrqSooFWDurVU?=
 =?us-ascii?Q?T4NGHlPFuBT8Y2xYx5G5zTYTdDYBGQ49GMI6VZ3QVE3Du9jSrXPhA3e/M383?=
 =?us-ascii?Q?a4NQiyhja+d1ZqMAPr+N9pszZPeMFBchUoAWKflRd4tRYjouwgXX1DJIcEpU?=
 =?us-ascii?Q?GycBURg4/+FBq9SAmXre1deGeDV1a0ZNbnqlMw7PndqA0n2ozjuyKMSx/Md8?=
 =?us-ascii?Q?NlCkTPSa6GvPoFD6FLdKNfLODsGWPQivnDsQ/c+8LKrKVS4Pwo7I86fO9O0Q?=
 =?us-ascii?Q?XcaSo041zJMVhJ+Y7V1oFNBHDTu6+h8dZHeUi76vPHfxRd1IW2jJ7YLK2ZJB?=
 =?us-ascii?Q?uTBNy+6M8DpXpxSmYexsV0W/2tJutoIVQUizSYUaNRUnB3DQNi8tO90X7wdO?=
 =?us-ascii?Q?qc+MxNMTwCLy/qzpAnXCPT4iARHjB6d88sZ/j4aq8KAK0thxN00IBg/5QzQK?=
 =?us-ascii?Q?pHN4QmNzRQ8Z2YEuRY3h4/WcUAspuMlaKHpce+M3HWhuKnq1hMpes4k78eGU?=
 =?us-ascii?Q?/rzljMT7t+6Pf6UHnVFvlhhVcLPw9NkoIrCfdLtU8x+S+uDdctfGaMORZzWR?=
 =?us-ascii?Q?wruWtnyuodb0t7GvDdp53rK8GLTTFae05zv9NQXY3P8pLJbsoaZd+Z8Q2taX?=
 =?us-ascii?Q?jsczxVJZhNAz7g/vH+PTUNWWoaumtCxPlM14M6QGQF0I1JxNZnSHXLMc5vYZ?=
 =?us-ascii?Q?luOUKP699uSFP0GUNBeAuzSB6VS6xw/TYzsOu353KfrKkw8KN6HG03iHbrMs?=
 =?us-ascii?Q?RGQ7GYrOoSqAIu3ZyQYoqsutrOlbSIDPftUit5FHU9A6zrcs4Vn3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa4c7be-f88b-47bf-e2f9-08df25c17ac9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 04:55:02.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2zh+WJvs8AOguxqFkueYPQIZfm2tnehcTkilA6gdKQo2eLDx3xjVs/GfP2dpDk3+tyGWk1hZrfkTZa1pPShKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2561

Hi,

This small series intends to correct the FlitLatency portion of the link
latency calculation, as per Intel CXL Type 3 Memory Device Software
Guide 1.1, and restore picosecond latency units for the QTG _DSM input.

The first two issues were found while debugging a QEMU guest. The third
issue was spotted while looking through the code that uses the coord
values. I haven't tested it on real hardware.

Best regards,
Koichiro Den


Koichiro Den (3):
  cxl/port: Convert PCIe link latency to nanoseconds
  cxl: Account for link width in latency calculation
  cxl/acpi: Convert QTG _DSM latencies to picoseconds

 drivers/cxl/acpi.c      | 10 ++++++++--
 drivers/cxl/core/pci.c  | 22 ++++++++--------------
 drivers/cxl/core/port.c |  3 +++
 drivers/pci/pci.c       | 23 ++++++++++++++++++-----
 include/linux/pci.h     |  2 +-
 5 files changed, 38 insertions(+), 22 deletions(-)


base-commit: 71392a644e88c6bb921cdf12cb2b00adec070fe4
-- 
2.51.0

