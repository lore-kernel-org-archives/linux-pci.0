Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC41FDE31;
	Tue, 23 Jun 2026 03:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185148; cv=fail; b=N3JL/A5Ctw0oNhf/tGFexYDih3D8pBsFeJfQE4TsCaE97Tleg6VbsW+vEzKp+yp9XxcmoRnha46Yr3gSDNLDQLJcZuQVSQNKatHIndUun6MNU9fKzhIvUi9D8wxY9ZQRv5zutJBvujzsQWRJzX44NNzrrbWdEmkvyJkqbLzCWfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185148; c=relaxed/simple;
	bh=N/qmPEJmeUuzt4RHWj6Vp0ec1RDPgL91d9Lr7SS2L3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ijjAkAGWaGcHSmCGJn1MjXHpP5F8AvIA8T5R6NnfVRX6LwambLSlgWvtsURUu9tBXEW86RhV0ZvTjDKv0W5wEerI9s7QY1YtYGY5a4v7x7yDL3Aorb84wduAAHgoT8hkIITwOtslEzM1cF547H32KsiZ1RJW8xbZFSyrOg5b4u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CX8Wm8TH; arc=fail smtp.client-ip=52.101.46.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CX8Wm8TH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7ExMaRcJQN6c7MrQw9BTWEraMCvg7H9WiRSHjuDtC1z1eWBhHwnI2UUNi5T3B9VTDs1CGM61YPWr3vVuZCqlCIBAE4z9R7HKBT/s9dN/OwJ6IKXNHaxXupjqF/+f1MuPECrPrL5Z7WYSxkEneS7TYS+cm559rUZhuwYDS8sgOWxIwY6PBt8ClzTb/ezEpcnDwKnUVM8pBfWiYaeVVlajXBOpvLplriTOSmLDgxsLpEve880hKnaV5f0Xh4Xc42/qaLatJHPF9dEyo2yccJdvmfjVgbbscN5xoTYC041zKbfGF6Bh5+uLI5cH7/mwGWMi4xp0czz63PiF6dRk3Y2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU83DfSy0In3GV02b4W9zvq6OHuIEo9MfD5jINr1kho=;
 b=cXUuNnMPEgaOisCatrzL1pioWKcAJY+g4fkVheoRHLWqkR7jZ2YaQrzd0LSKtxJxHWGl9vdMRkoLWwYrw4lHAjYwnWhlbPXdU9zp3qKaaM4wbpf6F6BkOISAK0w5wkcaMaKaVfUuBrjMIuSjVQE57JmRKq+TtaiY4JxPD70Vng+iyee1tFjRe2T5zlOIxf/3JegO/DsnqCOl8BiaDtv6tl6p6GXpAfT9Sx2FBFadbi9oko5J6wrUDS3f2TrYHpb4cEoATY0Rcz+GvnQNAwtu+99ptNK0ZKMZw1XOZFHKkMvO4CpOcfTso9nyEMiSuZ2tGJB2WlTrBpJda3LRR3qmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU83DfSy0In3GV02b4W9zvq6OHuIEo9MfD5jINr1kho=;
 b=CX8Wm8THOdVgnln1uzNPACXdPIWwC02QaI63fPChM7vs/IVKsrADycA0rtlW72dhA1aVANDx1WJPX/Z+VAWdXFZOydDDf0NBcm1cvv7jsIfF5RKgB/ZmJPxGK9gO/1Zlj9q1P38EedeTPu3I6Lokz0uDnba2BIMYrVcMAuNF96gm2VK6h22Iv0m9D53POeZ1KFvyZ+3uBAU0Mh87CmmQK2s0z4+X9MbKyo4XVX2z+1O/pc/onLVeeb0cnuGdbjyf7x9v3AMF/XdLlcHhJma9dksGv+1XGkQ8DsRuELA4obP6QrZ5hYYQjEYa0X0DAJ3jBg+Osok6NxsXgGKut4QH6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 03:25:23 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:25:23 +0000
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
Cc: vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v7 11/11] Documentation/ABI: Document CXL Reset PCI reset method
Date: Tue, 23 Jun 2026 03:24:53 +0000
Message-ID: <20260623032453.3404772-12-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623032453.3404772-1-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: eef8bd7a-39cf-4286-12c6-08ded0d70f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|921020|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PuxJzMS3AbU0dfmskNR3BF9C3cQWExI3Iq6EymUUKG3UfZnNq4YdytlcST2qRnwaiV8N8hENlkfA2q/cQnXdr809J2mAlF1zD/IQvbTGUTOcvkZUZN7kgduSfVVMr4egt91M9jiyAflAfFA8fhteIQNuggQDtGd+fR3JPPfgyTNcUvtMkfFDnZDo2yZ95lxfcTi5jWMxZ/wrXw1ygzSeijpAgnfxMmjPLEPTnWykcIIbwJnTqHUdSu9xh7l8Qy4TI7C1HrA/jl9d3svdyJzmpp58vTGxTF2jLXmkNOIOBzgZ50OLjng3VHxMEDDFBt4vPzzEmPvGa/6LymIULZni2qXtKw+LrjwTefI3gTRjbFlkog8gLxbcjcWSEQp8miiLO4dvLlj0alOBDoIibs1SDYCSHKimD773M6a8HfaSc2z/l9deCAkHbwdNrfxyHpWb1fVdogevrPbLioABEF0Ya1aBksNGDqAsUiWVGmVfX9scHqqc+IBcZ6mLh6os3pSxncfbVuA2W05X+QSlPrQgFun23cJHlIzUn7G2qcI7GhGS3EUeCHWYT+7KinYlb/GigC9nwmOzIQxIxGLEq8xTisVA3v03z1O6JLD38cTmJecuxW63V5cLkZ3RI0w/xECx65xXFkYkYPieMGyv5Ox4ZZ+LftBOVELLM82/tBRpUedsCzn3V8tpxOY63dLLuqmKf73flZnzO9n/KIuLTvdWyg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(921020)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PAeD+Sz3KEPlvnAdJGFXQKRUEiYdl8zRrEimmQk5k/Q6TEcgQuO6KQNy1lVp?=
 =?us-ascii?Q?AAqwE8I+x5SP32Qlu9hVl/rIn+Q+FE9y0pLZoRnDyCGFCsbQVM3wZ4FgaFye?=
 =?us-ascii?Q?rnNnyWj5TM//w/mhA9laAgIMRWM+eigoGr7CZXmRVQG6eAOtuTy7X+kRvg6h?=
 =?us-ascii?Q?VY0Q7cp/ecIZA5FJxPKHzzqjzgV1Hn1OYEksitn5z8L8gOmv2e0lAsMft2XH?=
 =?us-ascii?Q?jhIfS7mjOhdcl7zCi1XAvf/Xge8D37xi5TBDgdKXvowet7LHxMFLre+mk8Fo?=
 =?us-ascii?Q?LG0naU7ktWyyzxa0/dr2m+qzpbv4CAW7kQWju/F6XQz/O9vZ+gt+gFDXvYB1?=
 =?us-ascii?Q?PaJtbmtymzaHuxk4XuSfM1QxGLa5zJ7tjYYizRPfGoDjvNayPfkH4MyEW4CC?=
 =?us-ascii?Q?28egr5GnWNf2eNIkhdj7ykoeNG26s6B1dfSso6sJxJ8Yxs+vqQHDRCE6Y0dB?=
 =?us-ascii?Q?IG/igiYVSuJyUcqjwIrKzvnGT6OfOm2Dn8rGVQjnCfrmVhGKPXpf1944h4t0?=
 =?us-ascii?Q?fGh38tb887B5n71gOsQMxeBQlBANJ8yhR667p7W4AYmQ5tS/hOFJ58IFreL+?=
 =?us-ascii?Q?A5Tl8KejgTu5HHC6+O1GcHx49rwxiV1uPevhqW+nD/NQmH83LTF2aM1j3hAt?=
 =?us-ascii?Q?KYHsPEA8jABwHlhc8nOCqQAcl88eICI8WSQoRT/28iUb9ZTlhVDXDyFK9FPj?=
 =?us-ascii?Q?Qwb5u7UGrjV9DncLlBBK9BRtf+jjFXOykUR7Uz/bUncQaF8NAyXGM0t3iz9O?=
 =?us-ascii?Q?71bUNEDraf9BVeDnS5VGvGJBilktAVRoxAfEpOciW20AnDUEcRGN+CVd/QCl?=
 =?us-ascii?Q?CTHsw+XEn0+xsJ88aF/mZfqLLZRAolPB5kqaL3XxAuBc0k1Bk23/bvvF+HhO?=
 =?us-ascii?Q?+dKzKanZO7+LknZs03xyvyRB+5nv7st7NFhvz82HVrgC4ccNTbVhNlO/hHpf?=
 =?us-ascii?Q?aYsmWNFadCr4BcsphSXh8f/c/uTlHVf6y1x3GUHrwzBzx5crNQKHENTDfpE8?=
 =?us-ascii?Q?WeiBcMdGgYaLZ8pg7MSYMWOP6Ok3rs23I2ZGk85j3c0GOJETUQL3LpJfVa0g?=
 =?us-ascii?Q?ZyA2z8+3Zj+6TzHYd8DaDisZw8N0gLQ11MDtcNbfMWVlZfC3L2pf6tw9g42r?=
 =?us-ascii?Q?EreuCFwcO5d/cSUIa6XWTIDKPp1bW0JBu1c496iiE8pefVKwBs/9QvzPstum?=
 =?us-ascii?Q?33/9BxV6YHYV9ztFRl8VqCuilUMUGA346TPMbcX1ZxIJmikGWYFbbTIEMD6d?=
 =?us-ascii?Q?huQQwoS9yKcfZjpzrZVKQQa5+sMmHwRe2qWKkZ56Q/MnuiUnErKYKTsnTKsf?=
 =?us-ascii?Q?TEFkXkLs/77P3ne/bQj20ssfNgFridfBQsv3Fq2Ep+LsPB2dsj0qk3KjJjZd?=
 =?us-ascii?Q?amYoKJxzHdTEjU/B/0PAKq6VJ5YMOGGiN69hok2vHkPF+f58suFaW8a3Mnge?=
 =?us-ascii?Q?fsv+x4kLQ6VnzWilS10MQa2DB5XWskDkqOPI0ZQIvVqHziJ8oJoezb/P21qN?=
 =?us-ascii?Q?PPDcturpavIHHw3575WHx4nkr+m451SkCRj0yQyz1NrVjfrZLwq2j1Dgbt7f?=
 =?us-ascii?Q?lFWDwu2BUnV4nE2d43HRvVajNyoAd07Qsy17pT/qUHo9JKmhXByNKcymqCRr?=
 =?us-ascii?Q?hZTEuaAy7yj3yOOzaALnJCt0OOR9MBms+OCmnH3/vO3zkfEpae46K6+hom5I?=
 =?us-ascii?Q?bvrBtX5BwsblLk/1Wr0crN/FS/24AxkvOYKpHGGEKiESAf3Pv8ZjMZgAV2uP?=
 =?us-ascii?Q?pGUbGy/+3g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef8bd7a-39cf-4286-12c6-08ded0d70f84
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:25:23.1121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4B8GS5xPjntwNhzKeMKBRB40WG56oC+uMeRuc1J4gc69akacuRaJ2SBmFDtslWXOy5wlDpIlod0RUSVdUhkeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505

Document the "cxl_reset" PCI reset_method value for Type 2 CXL devices.
CXL Reset is device scoped, requires affected memory to be idle,
invalidates CPU caches, restores cached HDM decoder state, and does not
request Memory Clear.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index b767db2c52cb..dd8de5c7eb77 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -153,6 +153,20 @@ Description:
 		"default" enables all supported reset methods in the
 		default ordering.
 
+		If present, "cxl_reset" selects CXL Reset for CXL Type 2
+		devices that advertise CXL Reset support.  CXL Reset is device
+		scoped and affects all CXL.cache and CXL.mem functions.
+
+		Before issuing CXL Reset, the kernel quiesces affected PCI
+		functions, rejects the operation if affected CXL memory is busy,
+		invalidates CPU caches for enabled HDM ranges, disables
+		CXL.cache, and initiates cache write-back where supported.  After
+		reset, the kernel restores PCI config state to access HDM MMIO,
+		restores cached HDM decoder state, and then completes reset
+		recovery for the affected functions.  If cached HDM decoder
+		state is unavailable at reset time, the kernel skips this reset
+		method.  "cxl_reset" does not request CXL Reset Memory Clear.
+
 What:		/sys/bus/pci/devices/.../reset
 Date:		July 2009
 Contact:	Michael S. Tsirkin <mst@redhat.com>
-- 
2.43.0

