Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA724CDDC5;
	Thu,  1 Oct 2026 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846562; cv=fail; b=bJc8sR+0mE9Abi6VjHHZDnnj6KzqwdibQqU+H1wjyTF+219DTaE8x6TXJ5JVQWFgnvp6u0aI8e5NZ4sCh/qk2RRrZaj1DlB5aPsjDP5ceMfzxv+9+PY4RoZGmZx9s18Cr44DhSq6CuOlzB0OoHbbnpXVaTCWlU++REY86YqSp9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846562; c=relaxed/simple;
	bh=Cu/H07Ftnsgn5jPKQDXjFguFvQhWXPRUCQc13NfCnhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vvuy6kV8sLjDcNAt84TyVu7fnP3GX4RWF4CW2xWzDL8HcAlRFQ3xoVJFZZkBtnZP3EV+kPS7RFJYQlGPJQIrM2xPbZxp5wvQ7vUbd7nnnJexOwhvofZTAmAY1iH2rewEukvgpgJ2h2ZakCbqBVazkxmgVwy8NxY/3zClBtxlEUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jZdb7jiA; arc=fail smtp.client-ip=40.93.194.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jZdb7jiA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwZajT3eklDe8EPoxfgykTLZadGlfKpcKO4Ir2HjYPQtdyZrGXIIdzDiv3Ub28hq/aMF64LeHjLRY1mf1/uuqWXVYfTD5nD9MVAhiwU6cLnJFCAaCgB96dEHnLfZm1dn2MSQ8jTl/o0EdvnsoZxd8VssT1dP7r6th9cAKxFxVffNk4zVU6we+9f1GLTZRbx2LxLNokq3GO8/aMFpVLNxOUUFbcmNnJVgwYj8WefOyN1FmyogEgyaSiDnhmJUiAwEfIuMWyPcakXvF1nJWZBJnZtAZO5Iu2b0ZyW0k3tYvX0LjHMbPSBXY9iYj00O/GD0Iv0hFH7KEOedx7x7IpvaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptzqlsH2wt1VdMygGv7P1z1IEeQx7aPaghsz6opVUOo=;
 b=bLnRxzNbCwB4rsFe2y3dkukRybH6Q2tgf0wi5taizkqf4tPMUCzTxezveSMcuoYosmzZzp+yhrf1Uc7Sn4xBdfEWffGYfH5lG/VA108KvO0IRaD9KxAn7LiNmSMVKAiftFjcHBOMEB9gV+qJ9tzT3lIpEpuQCRxiVuVGaKUQa/lPdw2ppXoN9yNu4C8mpwEWHjxv1txVH8U2rcqIPIcGZp+gjYrRY93PvNjvyS9EtQB1+dzK+qjS0R/mAdyc/UJ0gF4uuwG7/igdSlFWAilRLGlSedQIka3/g0oM0/qNFpUBC4qPtx9bqbnIvCuJeGgqiCluJM+xOOj7AqNVmPcv2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptzqlsH2wt1VdMygGv7P1z1IEeQx7aPaghsz6opVUOo=;
 b=jZdb7jiAxP5UnRVwyXvd3TJQDnlDfoqjvqkN4jEqC4h6zxVMtI/pc5PDNyVu1gVy8P0KHld2ArFeUempmkDlscyKK3YHeQZpoGJr2mZJUQhFpx0ZvTOTa9CAGQauhUdQkY8bKcrO/5PO1+xQnstYPrCkfh6MIphiE5pLeJIpJdOl8HPnITbB6m/dKpnjTmo39uDqSSSu5n0pVrKu4Jl6vY16m3oUkf2UQ0nrZroQIpggFXbKIht1M6rNcbLshnU4T9CO24E8Xrc3dAgllB3/ARPhbprGdu+xlJfaEHnWVMck467MIgZELKrR3W5s2Z8lW7eQJoFTaftWccWLU2Q1iQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:22:33 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:22:33 +0000
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
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v14 01/16] cxl: Drop stale decoder interleave limit comment
Date: Thu,  1 Oct 2026 09:22:12 +0000
Message-ID: <20261001092227.3004747-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:303:8d::17) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 353eaee6-cdb7-4841-b935-08df1f9d868b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	v0VLzYIgg0OFg8XspGt42Q2r2lf70a5u4ncB8/zavu39H2I9qt1wvTK+BEs2hBsOvbJmTTrSDerIQIewPzcIn9rVHLcGkRCT+NdCk7VvH9l3ZI2Mi5VTx8MlKpM/TeULzJDgHzUxF104N4IjY1pd2asyYGX6J8vUiJlftBcd+P1UyvUozPNTwQOP8YA0A8GzCyeDZ07bwxawkoEHbBy2CxybQupac2D+xp2HgLbIm+GAvCUrUHvuut441Mx6ImUrxXuAwooMMYgl7UBIFEK2fQndsHw8GG+os2GGNiMMamhJoq39M+axULyRAXezaUBu+YurigtJ84WsJ4pWl52789oIamYs7yP0wDooadrcKJV6HUl7UlidSkc3DdMtI9g3Qa2nDB+g58aRcuO2WbcPGXipBwSxKeSa1NebMyec9n+Kufpxi42oXYxjFweZ7gncNE5mBUt5PvllYeWvwDrCcP6VHiGDcjzRSGJd1TpeHZwZVclFo5KGzmTFU5CrfVsNSklx16n/6WS/bE6T8cX+nqWd7gCknLHKQ10QBHl6J/xOfNG7fqQgcZdbMqq59te0ChizjDq4mlkFyPOZML19GvpGMYXLY7NnIg2VJ9/fr27XUYNhI3LT7NLH64CvbzjNDsDV8978qIJW3858OBm91m4mb/v3SodqUK95ZFmAiisC3t0pKPtkK0CHK0SXQLtA6zzcdd+o6MYltguOkH0zlA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(921020)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PIL96ksHAAfHO9Wf8Y/gEv7czzdwMZmLqK7WE8UP4XN99gFPk6gWv11UZ9pR?=
 =?us-ascii?Q?EAZGiXzezcWVZJNhWr8rDu2KGWy/NyXJ8wt1ZcdFe+tW9ZrX0RQ0ehMWtT3o?=
 =?us-ascii?Q?AXWXYq19j7RopTUwEdqNnkQUEOMTImE9VSQGdTEMEfdNfAMcXPL+yo+3Roo+?=
 =?us-ascii?Q?AHIDJVXb+hzzGqRbvb/+G3jYPXdsTQzsHjzprAzklFmV51GsO3UlGkBlYjRw?=
 =?us-ascii?Q?dANj1R4tWCTswT6NlNtu+BCNsqdgmWkBO6lDtIguIH+AOTV0TENYjTnmPxDp?=
 =?us-ascii?Q?1gQo7Txapynu4KGOPj6RzmO3XUrQ7z6KlySKuLC9TCURa0sfFTfb10XnRl9o?=
 =?us-ascii?Q?k7Y07ADCAHztbs7i+se7lc4Up4xgef0YX/B1iWXH/AC4RjtXxk+R2tvAQFLB?=
 =?us-ascii?Q?uIpQ036C8G/3ZBPeb4+uLFavGeUU2YzIvxB1kzPCHoJqxeI+69uo/uV0EGOn?=
 =?us-ascii?Q?gSGZjUoc3bApltnjlfHDxCI86YXccE0IDIm5HokaIukonMv82bFp18Ee7aRN?=
 =?us-ascii?Q?o44hJ4DJj/Gydo6kn3/EDJtCj2yviSqwlwkkS9efVLjMnFaWxNnXpIdhkIOK?=
 =?us-ascii?Q?Ci0XXSYYoxZ3m9/9f8LOJBKoyua39XXVMDd/cIQQfKF7hg/sPxsnr9AXIyfr?=
 =?us-ascii?Q?pZctUWaELYw1g0oZkdZe8lTdU0Sz514LlcIGOMYNjtZYMusGzS7zCrwjrgau?=
 =?us-ascii?Q?/G3N5MsvnMvruIQo40q+CDE0YQimlytRLlKrqyXIdGYyoWrPKiyUBN52vjnx?=
 =?us-ascii?Q?AASzLmIOLXv0FIgBFsljJ+gs/hi8PpKW3gHyWtI5UbNuFU+AqXXW+TFFew6x?=
 =?us-ascii?Q?cWwslT8GFqeBZgI30Z3BiQO9LaKFvn0VXpyGJu5hSb5EmnMTzYSFr3+B5VCi?=
 =?us-ascii?Q?qxiLnPckaTY2cEeV+cZBVY+D0CrNLMHPGY1owSs6HKhB68IUqSVGUA/VCYq2?=
 =?us-ascii?Q?ejxINI9AcFlfNSCbBelNoqXDPwvzSf7dCRznGsNJDLw7EfFI9mXGnS9BOrUQ?=
 =?us-ascii?Q?hHsUZ1q0pJVwVzfeYVdRGPw4D9J9n0faGzQrkzKWadHxW3i5TyjAjaBARvP3?=
 =?us-ascii?Q?Mjd2lRtbhsDh21Y8KbkzPQ0c+1VTK4QSy3g7Xd6JJnk3Te1fi/h3zuD93/Qx?=
 =?us-ascii?Q?Xm4huIzAWGczMfe0Q+20NIw9SNc++MwdM5ZunZax5CQOr0kQwxqi1hkgyo+c?=
 =?us-ascii?Q?bZ2N80B1pLLOllCMkagyuW2DwDfq7YT+1CjfQS71B/MffWccb85xBWwh/gVQ?=
 =?us-ascii?Q?S6MhqGGLXDa4KmOo6fUZl/bgYmp3Zb2i2C31qd8CyjVXJ4Vsbb4HWX3mIcXx?=
 =?us-ascii?Q?HVQrbwth7Y07dFvDTNsB8mmDL/vTyCAO6T42C8K+OeI9iAOIDhktNVbgF91z?=
 =?us-ascii?Q?5vdjifFG2veA1IEt+ayrFKB985Fg3dwRHpwisjrRi53UkhCfkZSvexB5PbYQ?=
 =?us-ascii?Q?EqMOt+0kwO+8W3XGD10FwkuPyietB+7r7rD2FGI4kJRUAZzISb7I3e7YarRY?=
 =?us-ascii?Q?+KUSW/zwyCa0jF4fo/YA7LaC38MHySwbR6L3w7l0ffHg1JvwDao4IMcXC2Rg?=
 =?us-ascii?Q?KHKMyrTeewASDZO+n5hzADw3a7PpTWnKbGGIEx5NVoC/JZz7X+zYvrbIY4am?=
 =?us-ascii?Q?Yn8pCvi9IZZ1FzhSG6fYbi5evWqu49l9ontKgp27PqN3FYzm0Yz1HYt18vXG?=
 =?us-ascii?Q?8VmYK30UV4wDQ3YZSnOxWLLDIAueiRQrGYwHff6ZJDkITAbJitikiidaf6Yo?=
 =?us-ascii?Q?aVomJaa05g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353eaee6-cdb7-4841-b935-08df1f9d868b
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:22:33.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5TEZKUggHL+m29GGk+/cTbkwBSk/dVK9PP6mYIqs4X+WOOTYfLmCDg3V9iSRZX0umgfo7qSE3+5bQKH5oOiVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

CXL 2.0 added 16-way memory interleaving, making the comment that the
specification supports only 8-way interleaving stale. Remove the comment
without changing CXL_DECODER_MAX_INTERLEAVE.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hlaptop/
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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

base-commit: fef22d37d47043b63e4007f2f5fe762fa21fae0c
-- 
2.43.0

