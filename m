Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A35B298991;
	Sun, 11 Oct 2026 02:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684880; cv=fail; b=knKmi0EKleRbCPBe0cbE3uziQiWbl9woIlRw2m6faqh+3iLkEbM61Qr4ci07efRy5ao0tRxgGFt3o5A3rqNNSc8YNOMKkkQXSnJoUeUqf55stviRzVwUd94/NxJ7+kDwDU+20vZVZtL4GsmW+na0tx+UkaccUvGs8hrXWsquRs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684880; c=relaxed/simple;
	bh=vO0Nj8UhONeBLJ9OJALz605zS+UcY6JhuEs4AgDrZXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IedbURFLz2gjcQy8foU2fKMioOUAxjXWuFxV/6r40KR+CBlWdUKdYGXGTWfMRqX123W9LvM3ZL1MM4FVPimwgswIJQyw84uR5b548ubynlzV04lGbeXKx7CUM/PhdEBKR6S30V3iRphRd5SkrWvr+mbgOI2dM7RXeJuRhe44234=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AD6ygyTm; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AD6ygyTm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0UGuYdmRV1nIen9WvIhnNLwjuyfLpKM1LXhYpTG2fk1cbS+WVJyscLulRW/AA0qEqzRb3ZX2Dgyhi0oMCYx47XpFYAbQI/V/L6ajy3weTJK3k9ZwImnL3cbosbwEVYDEbJSIcQ5oFB9ZISJflRS427BNfRoS7G0q2bKHZk/dpID3EaSq5+vvwYecE+gxa3Kw3ka5tPjLbomxWOgtUHuritPIzL1IM7mpxCf85kJkadLmjC/gQKUXJyXb7WslHX83ScclPY2+jz5Cs0T19RR3ZlPDYR7UL3c+XnHiU+I4OkjiSQmlPd+1hUdkd+5nmEcBKBPjFT8EgRMPi4tyzPRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5xjnZB4VuVq5ekBr0nWDuGJr5CHTqaeIfUr7eh5OtY=;
 b=kDSeP1wOqrhQNRUPdEhzZfXPujZYLGGVFYBt75M0exEmlvG0rZLu2fMvCMN3KSbJE8OtdLwTxLWdZRZHQYt78/hCUCHj6disk4fO8V90uDUbkKWj2tHDCrpRag0MD6mLBtyzy+/qSdHPebxCqxkvKwCgSBocHbFf8tsB+3vkR3m/e17lbFRw0ey/Kdlkonz/XvBhrPRVefmFGnRh88Vm5uLebiqLEZoerZCcZeqQtmOEkvxSVZgoDYstYtUk1pyYEqQMpzBfpp+oJejtLHzVkN074s+0p11Nn1R/0dCeSYjajDbVQSUqGNM1rgyx/VELjA41FFzm75Vhu/bjUwfJbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5xjnZB4VuVq5ekBr0nWDuGJr5CHTqaeIfUr7eh5OtY=;
 b=AD6ygyTmqe8/1g1HJYtAgOQZfLhRHBx/mvDh5v5PVX6NjPUdy6aE139DgsY6sUk0oCYPgLg1nfmk5SmDSsA07PfiNKmdQsOGV/kSoN0GKP6Mt0Jrtg7u49hA2/A3eKeaU4Z2nZkev0JzByMmfU1VN18vNZfzw1gdjAsxnSSs8pUguUlgQqdXMCT4Ehz/EXvg9dw43Cd1Vs6eqhgTXz9Fmm97Xz3LNTE1P9aaj4nL2WVKiT8S9jeNr534pHGWarECI7HA03DaNBNNtwghiA6JDFl6Zyz+g2rGLBKk1AE/N34eCjPc+aDMoO7ZKuyThTwaD/HHYTc0vwATJ9AxPBHp/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:14:32 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:14:32 +0000
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v15 01/16] cxl: Drop stale decoder interleave limit comment
Date: Sun, 11 Oct 2026 02:14:07 +0000
Message-ID: <20261011021422.3428136-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 11246760-10eb-4dcb-37f1-08df273d6328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|261009223027099003|921020|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xl5NXxX6KxLZF/tosF9XI4TH0FHu++h4QIdt91vwrw8Y/DMgsuZXudTHCQGWmVCJItvXzchShcLxC2Lko9Dof+9sLp+EarRCunOxEzX4owLdyBShrC5J812NLT4V7g7weM8Uv5JqgYK6XOmscfJB3dsllCyRR2bFwFyA/oHUiblhc7Q1p8OWfArYxz74323Yi7qJcBYb0omMuC1qKwoUX9jHlokKN6hqmU28Qnoc7rbKXI5vy+kSkp/BbrM/9xh6TbnrUERJsqJH68R/X48b5kRmwvJN/jaktY33yAAF7eyaz+o97QnYX9SO4eIp2rnUXnsI4oMI/7e0V6jEYo/eARugsOCJRojl0ubC0nSgbWbEQrSgCDtWCRAwgNIVEfA9hp9aQYfzy35kfTtBpSeFInBQ9nvEcai1Q1U6/QvkJFfVkBg2UU3Wkm6wsCJaSfLP/BD4eOM1PZ4l81ppqvaOp/vY9soTr5t0gjWmEXSNLxB34b9wfvO2uQTvtJDHVajmcCgulAxs/GFQ1aV7m6IjGgAXJiUrPO/RzS/CtoGpsQZPM36nAU+vZhP6n29K7N1kMkVoFxuRivCmy+uL9jgPjQiQocNCAXTrnXZDorgTtXJTdc9LtETO/hag/Xc+dEIaTZl1VjePgRogOWez0TRGIrNNLm72N8W/mSXXimSEz9wHj4ew91WuNpLumpGGaZ6PDwcNeVxzSRhFRjIj+IgBYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(261009223027099003)(921020)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PNmKhGvdFBpgwP9E6HEeqvqt9ludQs3xH+noDwIVTXd/UB1pL9R1XcbhRDS7?=
 =?us-ascii?Q?jTP6suZOLX6qq6l/EIBH3qzfUH1n6WOhwWgJgYNjFXB53pjOvuJuqjUi5I7m?=
 =?us-ascii?Q?lpKA13Wl60hcBa4X8MyYg3JYj9UEh3Q5SXyBKK+AF3CcleMOvOVxsWdFHBoR?=
 =?us-ascii?Q?etohAqFPjIrf5lcsLQeIcjk/sjbIQvZz1v8Da5wqc0HXiHQ2NMea5sb4ZMZl?=
 =?us-ascii?Q?6mzJSRCE8rpR3EJzIh/h98Ww6eZftrLo/P/MOh6spq+rDw0jcDZpPvM5nfyY?=
 =?us-ascii?Q?4CfeDeWguda3W1Vc+cB6+IUTKqXC/Aiue29765kIfBaKnSTgTViZI5i9taUF?=
 =?us-ascii?Q?mCqu/oNLOLhzE144a2cuFAp+KXQAUkJmRtDuPTJLsnBB/kfpjXajlbZB07q9?=
 =?us-ascii?Q?HUuKm6p3gl2Hdq18JD0EWJUNP4V9iLcwmdSK+XXBiSHvGRwIhrDPCY7aswPb?=
 =?us-ascii?Q?QNLMz106l9pClUGY/oEQdutWYwed/e8QZJMffaAvExY1pXgpQC5b7VB3xq9v?=
 =?us-ascii?Q?Tx4qmyYEN+TeiDVTJ4XKPtPA55Ftdp86ozYWkwh+LXa8nYZ48SUBxLL1XvOH?=
 =?us-ascii?Q?KNcMm0us8+nGR/4o6LXA21egXSGSCWP/3g8SWfke3armCvhnx4qWkdnU5peE?=
 =?us-ascii?Q?Ugh80nLEkwIwoMj3MBNRr9yig8nhgS/cEGaAsBH3eoJZ0mHrG8s9KMo2xF4p?=
 =?us-ascii?Q?ZCwMu2/1tbp0gMc295zD+SVGisbTIhvqBAiTfHNXw7RgBrmAfZh3zTCQoUuR?=
 =?us-ascii?Q?AapT4cgFluAsMscJKYuEj9mroKuml3QYHD3+P2F5cged2gq+VwbZ3S92YrxM?=
 =?us-ascii?Q?ARqIWqyBVVIdHrfDwyR3Crt9GPqW0FW0Rb/gIpy/ZsQWLoupPajj6x0sWWDy?=
 =?us-ascii?Q?aERkLiqflNL1yKsPy4WyQBdFzOjI+9mr4utsUJ3o+hS0fMFXQzqGeQc2hAOb?=
 =?us-ascii?Q?j1pnFAJQvIa0tq48IRwXtxG4Kpf2xcmaOhYQPbCdM3BaCyeI6/DAm5p74X48?=
 =?us-ascii?Q?hcPMIdt4MHVggez/76s4b3WWUod+sGbmbyw2hjuB7Gjx2h4dtkGwwcrgYnQT?=
 =?us-ascii?Q?BhiOAyFHBEkIAmRNuFdhzNGWWHD9nph1TohtF9FiDRV3iD3CpAghYUqhprd6?=
 =?us-ascii?Q?igSFLOFsBvGYZaS9yhEjVUtrv4MJsFyO8J9kWW2pPY/MhyDPg+EOeoZ/8LY2?=
 =?us-ascii?Q?1aWpivT0Dbo3etLSrEAiqrRU08yzv+F/R9Eh4yvp4NsYVrrvSwsofv/pzv1q?=
 =?us-ascii?Q?IRgtko/VBvRbIwrX0xww1ywpkG9KaRC9CoOipl5ZpMYIjdh4ZPZEVlyQXw/x?=
 =?us-ascii?Q?c1fJflGWQh1ndoFyFitiN0iY/b942b1FuI6JdfupAUxlOwqc0OTZ31RTlCL+?=
 =?us-ascii?Q?fykGlILKz6ZYD0lMm8b9t9uiTBV36dAiPvL088Mmy6yQ0SLsq04D52XcowPD?=
 =?us-ascii?Q?gEE7pW4qnpU1DC3ZP077xzSE1X/NT6zle/WayF+WI+Z0HIhEYbIl4bL7Mv8H?=
 =?us-ascii?Q?kxXUCoFtUM0KLJ430z3FG11iFU2ZQSNSLJRgYH930VflV7a5oWKPBXRfGuKa?=
 =?us-ascii?Q?N8+2tUL3qZUeUNOvzvEFlnW7E59azCZGl5K2g7cemr5lBGo+AMTwxT0dZKu0?=
 =?us-ascii?Q?TKeLrXVBx+g1oANZnnd2Ps6+tw6RuRhqZwhnPh78eRTtYdwPMaa/GgLWCFB8?=
 =?us-ascii?Q?o68hUmuyvNTZT7fR9ozVAtYp/SrV449GDFuRRbuEXE8f315bzDUjSy1EnykT?=
 =?us-ascii?Q?xlMk3FQodw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11246760-10eb-4dcb-37f1-08df273d6328
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:14:32.0600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GH8PPFgcOhNqoVR++H+8wGcSpXJT7Ku9ySrHEEhJaULXmgL8MC5s5JGc94R/EqxWweyuuglZyAPeYi6lD+GfQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

CXL 2.0 added 16-way memory interleaving, making the comment that the
specification supports only 8-way interleaving stale. Remove the comment
without changing CXL_DECODER_MAX_INTERLEAVE.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hlaptop/
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/cxl.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3ef0810ab86b..9e0500d56866 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -269,10 +269,6 @@ enum cxl_decoder_type {
 	CXL_DECODER_HOSTONLYMEM = 3,
 };
 
-/*
- * Current specification goes up to 8, double that seems a reasonable
- * software max for the foreseeable future
- */
 #define CXL_DECODER_MAX_INTERLEAVE 16
 
 #define CXL_QOS_CLASS_INVALID -1
-- 
2.43.0

