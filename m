Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7A3D5C0B;
	Wed,  2 Sep 2026 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334112; cv=fail; b=T4Xl+F2OZGG7VAPN2oCaFjvZpzbbCzEg3VGlfFS+PMJRe2SFOyw6c4mHzKlPPY4RAtBcdiiPouia/NabqbX/UU4eWIk1YiXwr+uVV1m3PLSoN+C9brAODFAFMRz7hhxQ5N4SbF9+lNsYE1PI8FLCF4RTBlY7OjNnGvjVS8GDkak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334112; c=relaxed/simple;
	bh=zIKAjpjcamAHIrvTsweYCyPu6aAkRKVNZbTZMhxw8x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KRrORb3UX2p1SngxVLuIjQMPWXbYc9rKGEXbhHLjVhsf5HzfB2ZiX2Rj5JuURTfLcw+nNO76pNnW5/6dHVJK1fvSnOH29bD88MovtspARyT8yuEtvunRoLlg8QZQDQ1nd/s25GEEazWM6Cx4nKywKRj/TZXzi1nmsINxAS0TuHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IE5dsD0d; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IE5dsD0d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWejifj4Pbdns/ZlWVf8AyfE8f6RXLBzdu6+Adp+Uaj7kWYCW1yaqp9pybAYQ3bLszAqcuHBzHWWJ8h4t7dVWJfIU0asfdFUrjNyJ6ABNyJYpf0sr5O2DhIL25Z0npxOyuAC/F3vuPosFBAD/6bZqL0dQdaveaTo/Terkj+q/eY/2GBz6sR4KKk2DAn3TfASHKsiNSYbRrdhsu2V+rueyrzh5Hfn3Y+sPXAB1kxDxOD5yCZoknBaa5QCZcWzkV9m161GObUPQ2DZUJ4gBZzjTS3OTPmHmVYnAiorjN31AEO59TZujhgX48Pckidt9F2VSGpIoi3UW9MVutt2fmodKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJ17mzLxD0l0hVsijqb/NWWgKxUy8vZ9VD/dYgjARoQ=;
 b=UqHGY72NofSz/aCnr75SRu88luiwufBDxJLoDpKT/7B1NbBEFpmgRP6uQJCy2ZkS97PAU3VNTSp3WTir3tNtx36rUvKmrxD9VVqXI8BrrcagA2mu7Wsj2vpvIbPeu7vcxqeCI0JNFAFBnA0yx8AFfV4U7/0TmVadTFJR7W/9N3shEWEBp8PWDX7FxL3CCD7/4QZxF3nAamNyGjMLowRMUk0WZWeMm+/EXMxrBxKRmrj4RtduYw6HBhzrMBbwatvEHAb3g1qvtOglmwMwLpBBdSO/aTciF1ozQA/OF/hMcnxXJGDeGX7Ccy1suSBU7dsnbg8AaZc8hTxqGYUjkH8eBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJ17mzLxD0l0hVsijqb/NWWgKxUy8vZ9VD/dYgjARoQ=;
 b=IE5dsD0dOOuLR9DrKBo5xVYZN9NuCnACIa8AJanYeY79ofeANHIfZbKeU2NfR07Dwt8JyY0oFGsnPo+PSbjjaKv3GimYGIONOp1KlOWYPLj6Cwbga/HWeTbRXIX2TqftvsJvlW5TZBrHHzlP7GoNPOrGQHNhVmF2gG4PQTQNNKXw5/F0VzaihS1SBkPVqgK6Myn8eG4y1y0mTeA6OJTd2iFALkTFAiJKEpgB8mgcQGSSV3nz62g5DOgEV6fo8ZIbehPrnYZgsjQ1FVqGgjBDFDHmqE2YUVBFd14TeJ6VjLWO/Ga5Kk7rwQ4UGm6uAslF9FDerT+WjERjvfhp/okx/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:28:19 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:28:19 +0000
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
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v11 04/12] cxl: Cache decoder settings on PCI devices
Date: Wed,  2 Sep 2026 07:27:56 +0000
Message-ID: <20260902072804.665639-5-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902072804.665639-1-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:303:16d::17) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: 166c5425-7d84-430d-2831-08df08c3c307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	H8/c7VUpauJLxMXdMCdVORuLSL4rcke6lL2VgWPx09/CxWzZgjx1fxD2spRqmD5YVz/18NChalSbW2qUMSSmA27AhHNErfpR0F+g7b8IWn9G7pPa9aczrpxtA60T2iTRTkDilmORvgJycehW+tHncfJXgdKW4hE4mGM9DfaeE8tw2n9EvfuBaZlD1Y2IrJ59iL2GpOpJjHSEg5GI5+apy+D+E6Iqc8M5hUUdzflYZwWtUCYZB3j92sZurwQ2ehGijQ+BKabCk96iqbaCySYC8Av61fK6Ymvu8KCKwnM6f1OKZQ2PDgP7xjvs1QCvEpS91M6hH86n+8Sa+NTW3aHOhZRJ23wnnBXEt6dJEJsa5OU7dx/Pw/7f4SBhUri0rucmZU4FyYy0jO0vIlXqDDVi9oP9Pq5B1B8O0pm9AL5Mef3Sfc6Ao6Gp97pY0gJV1lHEvCP2xEdyRm4wr+A9aA0fmm0W4hsWXtwqjoqDCoV9wQkP3X1OTCmFiaG1dgkPw9qPCugXl4qXeowz7fiohsUEM3Bbr53oYo5gJV3m/Isv6MyCawyAs2k5UOonZLzbpuKinLSlaiX93G/jh5H+iMoMsBQQfS0KMej5sh7tmCTVi2KVLIsYzp5LneXu71z8mLC/mlkiSZ8uTT0g4CMczjKZglbYkIEktccA2GjomcQe2laBwtZo9Uui6IpzCEQE3+IBP+YKGjxOmuKZF3yNBFov5Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ubrVwF8fItwM++VRKtLOnnIEc8xBUJzEbkUyhfRdjuJ87VdalQnG1h41X36?=
 =?us-ascii?Q?nJMNwrHqs4s7w2NWzq5FH5AGzwBG21s7kZ9NawPal83Tu/jyU7Xt29J+PAzi?=
 =?us-ascii?Q?rYB81bg17m705SwPqrj8W1n++0+jqbYAdG8OUkTHp8qSrNvAw6v5JUAeMDFn?=
 =?us-ascii?Q?+j6ljVjI2ims+uT/71HNPHK0R0a+bzc/4CcZWLI3FqAxI1WTXGhPtqED8pE1?=
 =?us-ascii?Q?RBJZBOMazqkObuf4HzicUtx9Vwcy4tAIwipBlGuXY8jvMjl/lUkRg3GFOxfI?=
 =?us-ascii?Q?GyDzxBWzf9cOjnuGRFEezq03fC8FDa6lClqWNcD/yu70TZnAJPNhLeqq6yUD?=
 =?us-ascii?Q?YMt+0yZn/HOf38uWvPeL8hJ/PapzA09aEupFzFi5WBNfnnY5efQYs8R9SibY?=
 =?us-ascii?Q?Nfm/6BzgiZSVHOtiAJrThgqVn7OSZzgLqtNbgpbkPr1cevNgAgJZTxy6FWED?=
 =?us-ascii?Q?Wib1Te8nB9eE/EqBfPZzH9+apPqo7eDlJLzF35MMxNX6TDUdgM45Hv/U6+RM?=
 =?us-ascii?Q?Gtj1ph86T0vffGh3VGkRXmknqb61dKbS+Go1hT+X27ZrH/AZtjjFJcnVyLq1?=
 =?us-ascii?Q?sCwrI/hvOaXQ4C1OK6UpL+FDxnfxNULM4oVG+mEyyL1VjXGRpo+m41VdDjlU?=
 =?us-ascii?Q?m8a/ptSBEBIU+BWfpJt+In6Vi0Gpg8tgJHUbOTVRBVBAe3wl8S/dB8Ls5mhO?=
 =?us-ascii?Q?SWlrAJeAftI5n4STWLQ/XJnV3MBSAa7xCzU6oL7XyqdGuExH5MvacFrXsEX1?=
 =?us-ascii?Q?no32ZLxseZ8/nurwVxVMNsgmFmYE4kq7xCA7wxjUYYtUa3Ll7P2Xd+kCWPiW?=
 =?us-ascii?Q?lYugsN2HEsIpYAq6AtOfaHnRe3ak8bnOE3ZBUuSqCAOiVBEBck24s30sgCx3?=
 =?us-ascii?Q?IxbRPLDpvXs1af+iJspLk+lAU8loKtXa0NZ9owOQrutYI44xjYyxrGxcXnzm?=
 =?us-ascii?Q?K+8JCMBZuRlx5705M8Z6eYIuzFDhxVWVhf9RoheQL2kLaD4nuQCant7q0Si8?=
 =?us-ascii?Q?+V1U5xvlNkQnMxvBs2GcVLJzQT1N+Bl48dG9VWuP1Ffjmb0Uzuq3ZDWKdDJ6?=
 =?us-ascii?Q?H/NBoBXwR2Fbbh47L87l+WpNPShTHGTPMMz7gAcE//XrN3UWiWBGMvxyCibI?=
 =?us-ascii?Q?/qYg/8RBbnYTXJR1JEU0Vq2SIazFWQYdOScN+1w8bo0MlmCzSxfwlIkpkvvI?=
 =?us-ascii?Q?1xYDYuvFsmZcXy33JgYavSXrD6JiJgCCV/ShKMptHmNvIXF6AqieBXXoduVk?=
 =?us-ascii?Q?s4dZx1QP4Ax2Ht0uzdPERnxPnbzQanb1EqmEWpt6+8eqMRhoucUUQzjvbEr0?=
 =?us-ascii?Q?D8K9B3mHMxvFmCnQWeJIeHjpmzxybiOurVJjBfYmv2GswUuJMJ8Zd99YjYr2?=
 =?us-ascii?Q?7NeEO41Bhi++lh89UuC00sDJz+0SAn/oNkf5wjbouY1v689hKCvdk2nbGpIL?=
 =?us-ascii?Q?LbGBs6C2pkJLQy/hTfjlb5ck4XT/nxEFtvOc9pRnvDFfQTYipu28IrvCyKgB?=
 =?us-ascii?Q?2DRFA4u78wSaFwpdyUYfM+kn0B+XEYpWdbGtAURze/RsDr7dG5BuZaF98SLW?=
 =?us-ascii?Q?tUhTygIcrsXh/jgdpGpJLDC/Ly3eP1YGlRYKyeo+G/0NqtwWkCKNABqH8H/b?=
 =?us-ascii?Q?ddZJJ/SVlrgUHPhRnVox6p/PMaDU2ppbRPOzpNvkwweOvVjn7zr2AsP2SVhj?=
 =?us-ascii?Q?Pn1kjWJmI3hYTuFUO9tIc+rokCOmYesNQB5QLqwsCXYTzgsFydLz619q2rQ/?=
 =?us-ascii?Q?EOL2uH2Ziw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166c5425-7d84-430d-2831-08df08c3c307
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:28:19.4778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLnYSkvoAY3AC7pEg4TjowZej+DtlRd3o/RMnSO8LpiBrdnt1ZQ/Hq6KQW34N/QFj4EwIoFQRISFJtYlw+66ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472

Add CXL core plumbing to refresh a PCI device HDM decoder cache when
decoders are enumerated, committed, or reset. PCI reset paths can use
this snapshot to restore HDM programming without walking CXL topology
during reset recovery.

The cache is populated by PCI-side discovery in a follow-on patch. Until
then, the CXL core update path is a no-op when no PCI HDM cache is
present.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/hdm.c | 68 +++++++++++++++++++++++++++++++++++++++++-
 include/cxl/cxl.h      | 12 ++++++++
 include/linux/pci.h    |  6 ++++
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d621d827f59f..0927036aed27 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -16,6 +16,9 @@
  * for enumerating these registers and capabilities.
  */
 
+static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
+				 struct cxl_decoder_settings *settings);
+
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
 {
 	int rc;
@@ -84,6 +87,62 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->iw_cap_mask |= BIT(16);
 }
 
+static bool __cxl_pci_hdm_decoder_count_match(struct pci_dev *pdev,
+					      int decoder_count)
+{
+	struct cxl_hdm_info *info;
+	bool match = true;
+
+	down_read(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (info) {
+		if (info->decoder_count != decoder_count) {
+			pci_warn(pdev,
+				 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
+				 info->decoder_count, decoder_count);
+			match = false;
+		}
+	}
+	up_read(&cxl_rwsem.dpa);
+
+	return match;
+}
+
+static bool cxl_pci_hdm_decoder_count_match(struct cxl_hdm *cxlhdm)
+{
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(cxlhdm->port);
+
+	if (!pdev)
+		return true;
+
+	return __cxl_pci_hdm_decoder_count_match(pdev, cxlhdm->decoder_count);
+}
+
+static void cxl_hdm_save_decoder_info(struct cxl_hdm *cxlhdm,
+				      struct cxl_decoder *cxld)
+{
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(cxlhdm->port);
+	struct cxl_decoder_settings *settings;
+	struct cxl_hdm_info *info;
+
+	if (!pdev)
+		return;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (!info || cxld->id >= info->decoder_count)
+		return;
+
+	settings = &info->settings[cxld->id];
+	*settings = (struct cxl_decoder_settings) {
+		.id = cxld->id,
+	};
+	if (cxld->flags & CXL_DECODER_F_ENABLE)
+		cxl_decoder_snapshot(cxld, settings);
+}
+
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm;
@@ -778,6 +837,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	}
 	port->commit_end++;
 	cxld->flags |= CXL_DECODER_F_ENABLE;
+	cxl_hdm_save_decoder_info(cxlhdm, cxld);
 
 	return 0;
 }
@@ -850,6 +910,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+	cxl_hdm_save_decoder_info(cxlhdm, cxld);
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -1068,11 +1129,15 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	struct cxl_port *port = cxlhdm->port;
 	int i;
 	u64 dpa_base = 0;
+	int rc;
 
 	cxl_settle_decoders(cxlhdm);
 
+	if (!cxl_pci_hdm_decoder_count_match(cxlhdm))
+		return -ENXIO;
+
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
-		int rc, target_count = cxlhdm->target_count;
+		int target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
 
 		if (is_cxl_endpoint(port)) {
@@ -1107,6 +1172,7 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 			put_device(&cxld->dev);
 			return rc;
 		}
+		cxl_hdm_save_decoder_info(cxlhdm, cxld);
 		rc = add_hdm_decoder(port, cxld);
 		if (rc) {
 			dev_warn(&port->dev,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index c09492af8fbd..ed5237df510f 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -133,6 +133,18 @@ struct cxl_regs {
 	);
 };
 
+#define CXL_HDM_DECODER_MAX_COUNT 32
+
+/**
+ * struct cxl_hdm_info - PCI device HDM decoder programming cache
+ * @decoder_count: number of decoder settings entries
+ * @settings: cached per-decoder programming state
+ */
+struct cxl_hdm_info {
+	int decoder_count;
+	struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
+};
+
 struct cxl_reg_map {
 	bool valid;
 	int id;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..84d058b1b492 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -339,6 +339,9 @@ struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
+#ifdef CONFIG_CXL_RESET
+struct cxl_hdm_info;
+#endif
 
 /* struct pci_dev - describes a PCI device
  *
@@ -566,6 +569,9 @@ struct pci_dev {
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
+#ifdef CONFIG_CXL_RESET
+	struct cxl_hdm_info *hdm;	/* CXL HDM decoder reset state */
+#endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
-- 
2.43.0

