Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC035187D7;
	Tue, 22 Sep 2026 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066375; cv=fail; b=hQZ/fVsLh81ifBcr7RTWb75xi1ESzD3UcP67Dc+AzD4kdn5MNT1bbcPbjsmMe7bcstlCIfgnJWlw8aSROvd8B8hx9VHCDO2FCJOgf8BLBSgUROInaaOFv+U/al3Csbf4kajQzgbjwxBNSYk9i301SCIfr/C/L9HF2uS7p5J+mV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066375; c=relaxed/simple;
	bh=uhsQ8XXwjBn6lmevrreZ3etPxtOvg0C4y2fRH0WUHkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=emhWJQY5CaZYDsg8EJpYRgN2PLBf/FTDuACXJMEIrGWFYdBzAUrYGzkz+iBcChmmvHHzliYmBsfN5/Gaovip0u/hd6i56Q0tvsZvNqKu7HKgjUgQJ1mzpXLNMXIDu5g/JW29EUmcaf/wOEWCxpRhQ9d38prRDN7ON5PjAKyAqDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RCJ3+tIQ; arc=fail smtp.client-ip=40.93.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RCJ3+tIQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPOyxLdwvS4Bsr+rRzoKXkRzGDqKmlf2w7us4rZxrqhDi1mFudjTcYa7pntwQr546DrGDbj0SvvBhKqB+4j+kSfgyb6+g9nbYpp98zaZJThqw6EWqmefcNUe53MH/JuoG7GtSUNcZYzISrIcw8CoXITH8wTNRuyXBNu1HBHbcJeG2QfnQWBiAbLOAqZVbibhIwvY12XNswFReLbF4GGOfDMSXhAskjT3KIiQELGin47WLP4IUU1lP4ZBwwngb5DdtkZvLUQqfAXsJODrEC8Hbeg0JWfZb2NQINwxLEjl5Td0djgHNw4XteW/AtqLK4s3g2BIfqqaSBJlZuGBVs67bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BU/bFqCdgUKnWdJMQfvEEyvmDHT35iwgYGWTx69TNuk=;
 b=u64u9cw03KC1SPhV+A32xJfgkctT7mSp3Jm8nXSK5xY0qtdBUJ90tv0HP49mg4zBCobMwuL10Jvj8DYFhmJYb4qic7uzsNqvql/zO90MQsZHC5fA2uP/j1rZv7IZ268IY/nB64VcOF04uyMC0hgW0BhgXtcels0+UEP0XkcQ7gd8INQMTR7hghG/xv+eW6bbVxAj6/VzJ+UYVZPfIvXUS5q9Isl9g7LlDz4jnP1jlP6ApRcp6gU7oeBqW9C11HO3GBsKY8l5u1ZcPSTOpCcV2LQ3huNlCh+hdRRVrg7ZFg/jr4+Bw818wF529gA1ckRJzCPpGtpxHRhNxjMxedwLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU/bFqCdgUKnWdJMQfvEEyvmDHT35iwgYGWTx69TNuk=;
 b=RCJ3+tIQJ37TAJ5VwmUaq4Ws5wlpAjNGmR0JYN9Wj4y83cP/IAKJqDxucaQe4B/N05nJrphWyvvQUhtgvIHn+DtzKc+JejQtFVmYHudnSsFUnd4M2mw3GN3LFPUAj6lAcTvKhUCJjH0tFBxn8BXRdpsd19CSEimyW2jvFvkSjJfI7ZqAup3uLyAJPKwGM2kJG4Hyz1f+7Y/QBibNZ6uyC/OML/ZKnu/2/nQFefgK2FJ+ZL3q4n3GP7QTIA/923UC34JZz5HnGghovojetW1aRE00vJavq0vJ2nE8L9HNE1hK7UlLOPMTDo0z0WOn4bML3GahaFVwSrJotJPaLt422g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:31 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:31 +0000
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
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v13 01/15] cxl: Drop stale decoder interleave limit comment
Date: Tue, 22 Sep 2026 08:39:10 +0000
Message-ID: <20260922083924.2451158-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:303:2a::13) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d4c177-7333-4643-021c-08df1885055e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bwYvnv/HzGoLpBcwFexgSxfpiuLtD3jWpoL0n1TPASOdk4oiq0m61p3T5epR5fqJe/Y2BWW74AN83NiEb69c6hyv87SlB3WH12ChU4YJn7DvLomiN9Jsc9hsjzhtXDIWGIfGX8/97JDTrtc02r7PvJvuA87Njm3suLCjjsGyKYS+H23VpKm6V0yNY0peVg46gmKi03mxrpkHXLICZX1h9u0bZNfH0SQh4tmbE7/HYOjh+tbNgp21UKHM0PFu7+RE3wnu2La1OgtS+q31Zk8JbZKvjZUVrjsB+2blyRkFfO5vrUGpi/ZUGh6zEz5pZwUAy0BulR6LnOqKmxCPEUnproxSBu1pAPnBSh0rVboisoqsNz8B/j8INlZn7D/LRLnrFsrzxyAmkzQ7xoKUlFHHPvcN2bO368nLtEsQJIhOy3qKUPI0Pi/kBChgFuyMPH2HWvbZs7rMaubjSXPW6g+yPqgxPQpMmxXBQFt8KpHt5XWqtcCXM7kG9NDGe2HzoheORlE3p94ncuDTfRE0l/wdB8zO/4fTRnwd63/0iKyACYEa/MPQPxu40qKtWcWYhMKDZsF467s6urpXEzW3aghN5tpTVoSBWIfT2lhOlFZvyYye6h7iBaL04rlvOJE65DyDYMfWcVuRqe0d2jW9dN/Dx4xm6Hax/a8qPfv44JGR5iolyHfUKIgwOTAzYhTKymfLvhex9aHLHh4t5Aa1yrhy8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kgu85dBmV72Ak34gYiin5c/Ydu1pSXMEarSUbJaHo73XIyG7E4U16jPDyWyv?=
 =?us-ascii?Q?mD2ewch+x0wpbHACEKVWOqQzxgnlErYkDDfDDwr1vk0AqZqPL+iQ+9FutQpe?=
 =?us-ascii?Q?8J+TLsmwwhcd/sDC+PdJVPk4lnwR2+9z+ySSXw+8zlNhGox2YQmILm34a7B1?=
 =?us-ascii?Q?Vd81g3BKrx6lYnXKSk73IaPiWxKw9sJzLQaX/MALJssiptgChFVmJyKFr6GN?=
 =?us-ascii?Q?6JCZXZJ5Kzy3tjivbYi2RZG50cUdTUVAhoSnrd1DKZEgB1Az55TzzcQh5AZO?=
 =?us-ascii?Q?5ZD+yXQqWXsbsxFdCdadMlqSkerZnD+gG7SIZS/i/yD1tHfE3hGA5MUBjRNx?=
 =?us-ascii?Q?HWEF70MspQsoM/iZXxvtXmuql8NMCVvP87XVJcmAdi3+MxED9JWmwS4ZF3gf?=
 =?us-ascii?Q?hKgjlQ80wt16z3/t+EwmMk++3ExM3ypn6byoewKBnUTFxr4zm+vv/QYhxiTq?=
 =?us-ascii?Q?7e1Fjq0pZlzu/EzlFXRk5hyDmFt0RARtqpclp0vqX4hoOIxSkYVQbgfmRPgf?=
 =?us-ascii?Q?Ib5T7r4eCYtpbiSjuXikRGBRK/6Ghx/iJW27UEGxJa9Ybfg/EtsP4RVtulCC?=
 =?us-ascii?Q?jAaUjsPy1F+sSodxgDBmP0d2r4cMRfVpuTOdcwRWRuLAECjAOTjMpTi5j9Ug?=
 =?us-ascii?Q?Av4IaPvPUCjtRkC3xOMLN3zETwepQV2xvZmvOblO6CVcUrG1UM4WjJnqIo7S?=
 =?us-ascii?Q?nlfiime1Rs6tiaCe3Fz3Ke2y3PMCJaslj2yMbcwSt8r/tXv0B0l2kjqkAyaD?=
 =?us-ascii?Q?Ec4oRESJtf/fZKPS3Urswa6Cjm/CBHE3O1dKGCskkFBfBFxV8ENnvGY2I2r7?=
 =?us-ascii?Q?dCSNeWiLp5qafkppG8s64HCOnxkzWvukBwRiZaZKt5exkrVyOerH2AM/UROV?=
 =?us-ascii?Q?mULyIlVJwF4OAoHgl/NwNGBhLMSFa85LK6PGMAGeBcmX6BsVHTJUHcaS6z10?=
 =?us-ascii?Q?BDdV7ni1WYMu/YQPQQ7uslOeGklAZJBvAbeMLseDBWv/xPCm8HS44xd8tXQG?=
 =?us-ascii?Q?3xLfRMjDuDVhoX8ds3EBmuW5A0CMsEkpbrwXZFT9bmU3coKP5Pf9I3f4Ghqo?=
 =?us-ascii?Q?jI9nW1Z6h+F6iwLYslM4n97Zio3kSs86KOmb68kMR/QJP1/2Slozala9I3ig?=
 =?us-ascii?Q?B7i8Z0FLCN9GhOVyQX4MWvSNztInfDVTuLjAf+zBq1VJRXhsMhkrReb2hnek?=
 =?us-ascii?Q?w30n9xwyQG0guCpuvcjAR8F5mChSIuFv7JLPpdTpfvusGIjSg4AUFKECxwcW?=
 =?us-ascii?Q?HPCItU2hYrG7LA+6SSOoIso5IavIMTlIsrhAoo4pyOGkG6VO/SqS1n111qG0?=
 =?us-ascii?Q?5OeZdk/LVGJM64fhISN4DxwUpCmPIf+YdAsXCClAO6lvuOMX+K4mEUwh5l6S?=
 =?us-ascii?Q?H8nzDMyLOz/HSS3OM+qJrh08d6Qxjl3cusNnPN8ZCWPywo9NuI/ccPXeLyqA?=
 =?us-ascii?Q?r6/lNVqIl/JIMOEZeou+cAT2DUdMgKFwtjufUSZLpLJxtAdYkj5KdjdqR5Ah?=
 =?us-ascii?Q?b7jKwu95WF2uGO0I3CDfZ/c62cg9e522I06HsaMyjhSpC5M1ChgUKyLJeFqQ?=
 =?us-ascii?Q?zldi/nOV1DFeIp4dah3rUHtOaAzpyVNjePpI3WwSr7I4OWam8UawTed2X2Aj?=
 =?us-ascii?Q?llh8CpyCEDNVBgCwV7HUQRL/2tRPOWfLmEgaj9u6SvysXYBJI8YN8Tio7XDq?=
 =?us-ascii?Q?RLGXoisLMTVpDEZD14/3apv+XadqmF4rz9OVav8CmujhZ7EmyZ1EcylCaLzd?=
 =?us-ascii?Q?nNe+zt2g0A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d4c177-7333-4643-021c-08df1885055e
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:31.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Yj6m8VEFJhlEMWvpovs+2II4Aa8pafLhfr7OkJsdFdzqP80LTaJ0fgesSSbYwvS4b5CjTjZULCXnfvVeAertQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

CXL 2.0 added 16-way memory interleaving, making the comment that the
specification supports only 8-way interleaving stale. Remove the comment
without changing CXL_DECODER_MAX_INTERLEAVE.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hlaptop/
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
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

