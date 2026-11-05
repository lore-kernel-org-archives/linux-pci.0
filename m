Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905170;
	b=0ORFM7uTE85FpsI56O+3oV44N1HdtQJ9oK0druvGYQ5ok0EnVzLgZbWiiOeUqmJ/4epV
	 v6i4RrYSnktIL/rw0fIyLyhtZ9jKhuIRc5sTIwmXVJ+NyfBTDkEfst66TxjaL3bPkak9b
	 fIcqXsoKqzzkAxS0j912LkgOy2Gy6Dzkz0oxfy2WVkDEmzrWdWQA28hwP8KQ05QkD2YYx
	 ulbhR6DFMY1UXPZlcru+Q/z7Zwc+cjOut09bn4VvCU/94sjvYvLjKDraqGhTUoFPQ+kLG
	 HvtKRQfdDUpDNY7sRSjdrqCUiwvU8CapoD2mdEpquLzpLDmd+mpfrtFfOi+eaI1qoRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905170;
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
	bh=t0a/v8azAOP14NZE2lQjMyPdGcxFd1OXJgNWJNqERmw=;
	b=lm02kvfbYBrOXmVxxrySuNQmJVcBHJgFQwZYVr46v81dGTkZ2FsrShxeL84jcjzkf7bM
	 VXR4zdNdPn8ctPw6jjXDrHZvzGkJI7ollfwW5rl0PDoCcqS+0ZGmJMX5shs36ncHJhGO6
	 IQlG0W+IsrlxPQS6weWOE7jnaKpzytdd0kJ6WV6wXv+i2Pse4iIeDHC3+K6+7dBP1wUkm
	 Clw5W78Ty59qf4tRrLO1Lqi8CbrYOmqW87GuPuO/inQ1aFVM8NEeRmRHXUSLykkNOh58w
	 dYqefWYHpj8QMJ6ULjJnANGqqZYn+c9BYQO/RbuM76wgFqhy0+s+EUE6AhM3ePWfm7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r8ZB4CSI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.21
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A674606A32E;
	Thu,  5 Nov 2026 18:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A674606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r8ZB4CSI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gANwZ76tZjo2P9Fqm1fYPluOmKA6AXvn6ahi92xqlmKISTUbOCPg+VZEcv6SzOEBhiKXlKfNOSUcJRrhHeZOc1rZH8xoIRWTKv+4xNOMdf+wFZpWAotWbX4Y9ldMgx5WXNT/bAZgiRk7dKXkPqfOO9mU5ve658Z+yY7SkS5NAqHqt+PXhxNCmffhVIzpYgcay2VgE/YxeNAPMZP0YkOqYHUvcYBVU5kid/DRGwPKrWDVMrAimwplKNjH+qjTziU+Zsg6iJH4hjAfU6CrFBuK6Ul8JwjvPqUz79vD2cnaiG/68rdATd5R14B4L7NsJNDGnOwZ+9G3cvUNAKvKaewiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0a/v8azAOP14NZE2lQjMyPdGcxFd1OXJgNWJNqERmw=;
 b=F8+gNf/saR6xHma4AHvFgASX8S9hH01lK9hxcUpRHSvDvqFKgFGTwjcPX+Vl3uNcNo7rKBwAHGFdhQpBxDUZviiXISYSsexVW9kMWh+P7DYxvv0IgvvDPpFbGn99uMU6g5DgfqHFg59t7s8BPgadTRX3jiOr+b0cIfMqLn5UNIkskIUYR14CqYkOohhY3Pv2lvtbUaukX69V2N7GXaeghIv5nAVNoULbGuPmqj+aN456fpWi4G1Mk9neElbjl6cVjHB8TW7wAl7QlqsPHjUG9/bfqc2rCPZtwW74O27jbhoqRoIl2q3/qfkalqXZnTT1sXaO6Rj9zuNh8wa5Q4oLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0a/v8azAOP14NZE2lQjMyPdGcxFd1OXJgNWJNqERmw=;
 b=r8ZB4CSIbAA5m7CcaY4BG/P0rJk8uRedUsDJQ1BNeZZWeR8Da1jKpBwNKMoBEy93J7H5sFe4KDbHQlkSUMu+3OewUX1JxHHeINt07Kfh5oIidJdxu0vpw9M7/j3LlB+QMDTCJeF+TfL6dS/zHlqTzlQNm3yD3dS8xEcOYXMYDClcZmOK4SEouFncXnj14q/X9QhN8CFQh+W94hybrbhHBujLnwZS7xsm8lgzP9Rq8LlcV0Cbz4Jv19jF5WrQ2xwZfKVSiCtBJjWofY1hjDXoTxljm2r7ZJRxwWhTBhXeJDCKEbQusF4Rg3aqsJGH5RCUij+BYvVkaqGLNcBsSg0S2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DM6PR12MB4105.namprd12.prod.outlook.com
 (2603:10b6:5:217::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:23 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:23 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Joshua Machauer <machaujo@amazon.de>,
	Alex Williamson <alex.williamson@redhat.com>,
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
Subject: [PATCH v17 01/19] cxl: Clarify decoder interleave limit
Date: Thu,  5 Nov 2026 18:58:59 +0000
Message-ID: <20261105185917.2667656-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::25) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 971f4964-f33b-42f0-0f52-08df3b6ee7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|921020|11063799006|261026121527099003|56012099006|261021123027099003|261026140227099003|261009223027099003|261021121427099003|261102123227099003|261028144727099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WCPCv0VzZV56wYyU7b35Gx5qHS4vxLlsmqQVe4eWwP87wIjiwgJZBoRwCCBava2fD5PpwAddJ9gDuW5xGt2xfMhGpvfG6BvMVhs0NT+nKCbUZHoArFDsqREpgYnHq+nt1Gc6ncMeYpb9H0lZ2FwOoETGb8ku5ZnMrYcpVLeXCchFFJG4iLvySRnGZCIWAupHKpW1agOAkHd8h9rMoTsLaT+7YOlQaw34l0fUUic/9tmU3rhanaFyhAnI9X+3JmkfHvsK4dFEuBFb/Vg1z6+TIxbQ7xezBGxSSXOogAyfRb5kNDhKQofN2PtJebDZ7oxLTRDObHsEmGrcJNFXJJJlcg00eDFfd4mx+txx4DVKo+vhEdEMmwfg/j0oveSsZJkC6rbZqUq5emBLkwvCA8JrrfxGg+9XPKWjqdy9DlJ5qew0fUGdbdKGph0zAfwrkOqkMiyjzJojLuG5cy4mxmVhya+Sexhr5sLTmd4WFT9guwtZ9iRUt2ZwPRnu7QBEfUuQkLQCElCgllybVZE7tni+cWLT6Pfpmog4wQzDCaGbSTrCTKBOdK7SUCJsECXo2irmIC1qqj7TpHZCxtjdPsUkp1TJEiu3+7wTnwWxqqrxmFWy/9xVS0f9TwSemMThziRZYG6/9XZ51jj4hxUX2WvBdyU+zmC9Zm0IqVFBg/rgB+uBbAZ88W+3eqUBUPJa4KNfeI5Vz+ZQ5LcMm/ID2DgckA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(921020)(11063799006)(261026121527099003)(56012099006)(261021123027099003)(261026140227099003)(261009223027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022105027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WGBMmflL648ujkseLX2rtF40KeXK/WLoM/z68jS1UbputeGF5/cMXS8UTldU?=
 =?us-ascii?Q?rkZW4PxtrdSQms1fLCAABQJHL1KwSDQ9RbuJZymjMVzYXqlltpg4m/Y5Yvzn?=
 =?us-ascii?Q?ewIuMJphFY1pINGBVxhl4eJPzslVYfIP99akWjy4qigaJc0TPB1Ixq9aF1d8?=
 =?us-ascii?Q?vZNvISX5V8mQ172X/eoCdrxn9fh3nw4EMEypT/RLwIbbaNd4nNv7msytfkEu?=
 =?us-ascii?Q?OZKmmPyaP1UZCnGKl4Dn1GOtS5SWex0xi9EOe1//x/sZ72jdoAe+xoBWyU1n?=
 =?us-ascii?Q?FhLP6JS2Y/yV0uoPuSYdxkh7xTz9OQ/8dkJ0YetmUYfNeA5WY2bfZyzQqUjO?=
 =?us-ascii?Q?ZIMf/CI1ZW3/ZXhTlEgmMVqTuvGMqzrXAmmXWQPYlgbOZcNQZn/CWc6xT2xB?=
 =?us-ascii?Q?pAagQwooPseDWrAqBsRsmh15pefsJ7V9eag893Ql4GEnpkm5qbnd0xTkitwi?=
 =?us-ascii?Q?rtj/bgOSkhiOUA/A/AZYnVXHmMd0v4ZzGFuIv3uczDDcjaheK7e83VSiOUDO?=
 =?us-ascii?Q?Ti2IoXoCOS6PxD905tX/9u7SvK3hBvkoQ4yByJE4MeAiTIsWzROf1vSX9ICw?=
 =?us-ascii?Q?9BizTsSuMHP6xAgwkGgCwHuzYId9kdljqwbBVT7E7lrbtdjhHXZVn1bevxEE?=
 =?us-ascii?Q?cJDzJGneRNc/vFPKTTOlnaV1vVpMQw7hfPVkjy1CpHPu32n3CTa8ybjW2u5f?=
 =?us-ascii?Q?EeIZPxmO4lAj7y0nzf6ONtzS8ShGJgqXiFyNjgTOaWjzpToNhh2kGvWp8RG9?=
 =?us-ascii?Q?JWSFViUohzG0ZApCZsvkLh8osW2x+y2IhEc5Fc5Pq/FQFtyU6sHouvM9P/ii?=
 =?us-ascii?Q?DjZQ8QPtpiXsoUWbw+JwKW1vr4cpP36v7+sRtHraO/lTPFm1XvgXcxd+LTx7?=
 =?us-ascii?Q?8YTznQeFxBXtGeW/eKJI2b4immMlmLGI4aJYuNY/EbYVWziIkSfi5ibHkbRz?=
 =?us-ascii?Q?T30hiRRCM82RrZotMqgEjM218ijKD69VUNF89hGgWq+bhQehWKCFQ4tcI9Sv?=
 =?us-ascii?Q?3tI65ER3bu86T29TVwe54EYmihkX1x4qio4eCXo7NzdZqcxP/G+S1JU6ssn0?=
 =?us-ascii?Q?U2ySz1uiWDlqOoPlezYFk4A5N87GBKKIqewyuUPOHKPTt1mjnRVss+C+qT8p?=
 =?us-ascii?Q?PAfqzdR91cDUhl7m8bkm0XAUVmQl5NVXoytv1LNK2H0VgfwxvAd8eaK5AIbi?=
 =?us-ascii?Q?tGMA8ZMg1IvR/O3JPP5UtqCUCMJRRny91ZfrVMV6//oo8S/cpUk93PKP/TQ7?=
 =?us-ascii?Q?0y/Ug8r6rC4TsorDIHRcJyTN8JMbMJ7Rl0r8CFsdd/6V03JiEnnYfJqGmD1l?=
 =?us-ascii?Q?4nMM6soyX8V1E3nCGdJbINEgba1w7jptc6zIA1zVjmLyltbQm6x4zXygbXsA?=
 =?us-ascii?Q?L4/AYVwoGYnZ8wqVX6RCshUU3O+ngsjmtwz+PP8vttGxqts+32apftfdcL1U?=
 =?us-ascii?Q?0iWydxOrEsh/n8aEsjIqKCKQeOMWZ/ojP4aQfUNNY5s0dbtq6szuLtmoIKe7?=
 =?us-ascii?Q?l/2N8bxmFAEMtzxf7QnYXvjzAR6mh2wqYH/HyoEHlLQvJCQZeNBb4vMm4r7E?=
 =?us-ascii?Q?5FjnLrZaE58Q2IWdWnKJqZbR8FaxXjRA9znFpb0IG47wOwklDoQIYEmdrOeY?=
 =?us-ascii?Q?eYBU3d7dQkVcWO/Ay/Ewjs4+KLb8ZA99YxCRNY9RZrvouzWYc0DHcPHg8W7o?=
 =?us-ascii?Q?qy/F1MwH9eFnAa20u/HmduK4xonQ/oGvaz+3ICButCYYdJ9bc4dzOJa/6C76?=
 =?us-ascii?Q?SmHMoR3KVg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971f4964-f33b-42f0-0f52-08df3b6ee7dc
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:23.2993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcAOysAfh849kD5J3n5RUj/d1tR51Y0WKAk0UX0r2QRGaKwq7S5Svn/Q6tKbhxnFeM7O43pqtqPA6ALiGunqJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

CXL 2.0 added 16-way memory interleaving, making the comment that the
specification supports only 8-way interleaving stale. Explain that 16 is
the largest interleave a decoder can express, without changing the limit.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hlaptop/
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/cxl.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3ef0810ab86b..50af716f69df 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -269,10 +269,7 @@ enum cxl_decoder_type {
 	CXL_DECODER_HOSTONLYMEM = 3,
 };
 
-/*
- * Current specification goes up to 8, double that seems a reasonable
- * software max for the foreseeable future
- */
+/* 16 is the largest interleave a decoder can express (CXL 4.0 8.2.4.20.7). */
 #define CXL_DECODER_MAX_INTERLEAVE 16
 
 #define CXL_QOS_CLASS_INVALID -1
-- 
2.43.0

