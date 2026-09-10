Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E83CC32E;
	Thu, 10 Sep 2026 07:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024146; cv=fail; b=aXGZ8l48+TqfSmU1yFTJhKBc6cDM58YKE+7V6dZ483hMzqq7LAd4Hux6y1GjNtwEIFQ+BWDt3V13yGH2mldgseWN7VrEU8yzoTLX1WviUDaRS4x0QyeHbMgf57GAruOJaHukTRk4UUi6xDs45cyxj1vgkWEm2H1uWvFGhAi4Iuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024146; c=relaxed/simple;
	bh=AHaSHH0Ioxm/AOBtW6K6D4kykEpYJJfJtRypLwB3ok4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MtF/Q7DH8xOercOwvkz2knm52ZHzpH+3xzbdW5ExADIT7wPE8CpmcjBKE23/6OzgkDcTfuZWTr0owpooNp3Cd0Lt0w8IhrJn6Uc9TdK2bNN67Rs6p1+fn5/ZSpGSF7wXRrmWHlZF7SVNfeJ/Do3Vfxd2/Jiv/8+XXTQjFhTq2Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ubQ8m1l4; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ubQ8m1l4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM4j3suDPtZX13GUNQJw+FfDfKVUaS+kBpbjnLbmkvClhm9Y9/ZCv9+z7aHHecvtU6sXAc5g1ZNHEmpkB+5eOZqFZH8EosJT9jdha1v+w1iyReXEFgVYdFJrdlxgo44VBom7+NMh0MvEd0+38E4yqUbgn86BdjHk4xoWj3wUAknNwSpFZoHG2cICXz/h7QCHrFuXO1NxMNA7wKVkZusnRZzRcOlOpfpk36L1l2Uv43vUybSO9FnjJ0/KU4QhE3Vy2lCyzV2C9yT7yEv7aLw06MsGSmUudCDydU/G84iHJFYgPaMABjBrSROBNbsHZRYo2vQbLn2N63gT/NDzQCawDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wirV8JOBZR5TuhJCwfuFQeDMyHjK3WB2mAr9HcYDBMs=;
 b=GY2//ZI1vfoRAHuwJPz00gJNIuaCw0/dSCgg5Wvuzo2ZKp622XXoRUJTVuI3MMvw/6NYkASWUE2RBXJA/1AvwKaAw3zjYG9scCOpLWaNXOywut9QIGKwMRlBTHyaWAXc0gwZQd8JOgAnS5A8eMIL2KXgWXM+quYuCFGSOhyDZ3tg9rRH3bschZAqzih0A6z9zACWl5SLXo3K1MR9aI244blziXVMwJfukxQLhmg8R9TmKnaqlcPwa4P/99nwTNFjx5KRn2Y2Y0co9bLx0ZpwXtB6oqTgLuvwlXSmENExR1pmdOZe32sYVbl4ezUXoUqDG1C018x+baTgqdlNDq6Yew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wirV8JOBZR5TuhJCwfuFQeDMyHjK3WB2mAr9HcYDBMs=;
 b=ubQ8m1l4WfsPrWapXR2zJf6w6PwSXK36JBYsLteO6kjQh1aea+GCkCSPswa1T0JccFTii2L3V4w60AADJHmA4fMlRgCjVI+hvPNFF1mnrJA6qLzL/8enlVwsul16l0IATTG/pocDkKYefc5HUWs8dGsS3fPJF9v3Pa3Mh+CYKgzmev3nINpVMnbY/tPbyxdfY1CWYBRpjLr6x6p6lsLZgB/+A1C42C/9KraWsR7RIoCp7Ez1Fa+6qo6BiS8Tx3Y7sY6RdtPycHKK0Olz2tJ2um33t9J9l7OC7ZMc8P+xfYsI/M32mQ90Akt582tCZ1xl0xkfshY3g3aoRRY4yhonOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:08:55 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:08:55 +0000
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
Subject: [PATCH v12 11/12] Documentation/ABI: Document CXL Reset PCI reset method
Date: Thu, 10 Sep 2026 07:08:07 +0000
Message-ID: <20260910070808.1444264-12-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910070808.1444264-1-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0123.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::8) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: c3447d56-fb5d-48cc-9dac-08df0f0a6073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|3023799007|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	hYA8Ec6RSKG2bm2k3Y28PvpjIwS52rG22kGBF53gw3/3npxHl7IQIe2FGbG9hxwQN59x9gbg3bWfyPJJXtBUDvdZ0oj/aZue7mJHFUvLW2yT9ERZRARgpyQ1Ark0ssDCkIq6w2aMlwzOGIgPZQib7liBz3wb7gKmE2Vp6KqZMUXdytQIrGZYcboJ592pdAUu8itTotnOIvBe0D6LJeDMvQv3hZnQtuf7D2stI4Aua4x0l4/66pWLNq3zWgBTGoXSRTdRR0TwpzEqtZZxFjVdzMwcsDudeTRsBoWDiPFLbEqMRsqyJfYE0TveubzLcvrwjBWlmIPWEeYmJ+7p9ILkJWl8MjphwCsO8TtYcgGyfu+q/wJk0pQEFSmmYHhb6sJmexa4MM9VOQHc5jqZmLUMxmYpim8t0k31/uq4eIxfNpY2xQ9q+C3Xms8fy0RnV81HGiWDLP2+LJxgW21AhJNecpRQP5i59gjGKlfOQ3Sjjby5Sxf7F+Izy0ai2AgUwh6WeCKKVNwJ13TqPS9ka8fjNR1J/F8E7O9HcyzCyQm1PQOdhI31fKLWQDeo1xwvzf1sJaGyV/Gt9SjM7WhCQfJAzBPGlxX2laCuinFdiOUyANjBztmp34A8DRyQvRfD7gPPfpwleS7Ke9gpRIj7zs7gQIZW6KqND8k4IRDqNkHmrapudqL095MAqANHysiffgqBE03dXE8p805UFHofkjPZhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B17Y3fwu3rHzjz4F8ytzpmXMMaULM5hzu6Hf0HhRp+4QMZqiCVsmjP0ZsO5E?=
 =?us-ascii?Q?1Jy3hbQuR+dRDe6B2ghqzWgcjIoHCTHNkKcv7U1E6SFWU62eHg1XQgQjYcPX?=
 =?us-ascii?Q?8Qhlz+hpeFZ3J0dkaSvdORfNn6nWKw1QBBRI+RGSyjtKHYQ44AjwIEgA5xrO?=
 =?us-ascii?Q?IXPUEDFAAun+IpXSFrVIFYfuCWol8VUwrPd4SC0zwYM9Vvp/KWuxX5OwucgB?=
 =?us-ascii?Q?qy9swUjwDmMiE8q3TX+ayOt0mUR9Dii2BzcyO2VAM0msrd0k/Ys/uFkfXKRn?=
 =?us-ascii?Q?BMYa1Idb8Rq9CYJPeDdO4eTfwp/78sFnoaxEyxtRXxYKR8YY79qUkONJn7hz?=
 =?us-ascii?Q?0E/n8RWMTE+BMXC/d7EPk/thj6paDYW+xP40tOTzLpuLETaakPF++mUKhiPI?=
 =?us-ascii?Q?gp0pPgAr9sE58yt8qmWeVwF66HIE+qoINkyTQsmAy7AGzCbnNuffxqq9ay8l?=
 =?us-ascii?Q?CxOBsc025o14aSEqtznYnwGrY4urc8zKmhh+ZqFhdLPf3+rvmbxwienCD9UU?=
 =?us-ascii?Q?j7WKaOVoBv62DaUZjEKgMl+8Mcl2W2vv8AG4LOp7IbsBBPdaabgDrv51+T/g?=
 =?us-ascii?Q?bYtauzdaWgq61GHF456NYUibeOxhBhQoDDFTltzdBiFbIAJ2Phd6wE87+fq/?=
 =?us-ascii?Q?5T26dvT0P1YNxz82wjMvcVc4pSPsyZngte7rdoESzxJjOhSwRTEZp6cLaulJ?=
 =?us-ascii?Q?P8seXN4oTPPy5ZKR9NNsjMNXd5i1INNGPBGrIEO1NyCc6w1X06x+kCTAGkb9?=
 =?us-ascii?Q?1asMlaymKZOmMQU1PCW7Dqo2ebGgySOpAe9gVe9N5rcY76VSDd6oHu1ggKNv?=
 =?us-ascii?Q?r2YD6Jycxa4WQ+y6VoP2K+vn1IfgZOs1gl0VVyDIyzb74pI1pp5UFFxV74AD?=
 =?us-ascii?Q?YsEuHgRaPCiNqyh7mreoCyif5JD5k4oGWiSeOFm2B75Z3CgHpKMwSjPP0x+N?=
 =?us-ascii?Q?l2CrSPuCxMSSUpWBAcDT/EegT7EjWCp//SWm8D4gmfZnPEprT3KiefUsBBOi?=
 =?us-ascii?Q?vUD79aPQFHy1TaXSeQwDdBoBohu11DcQ74NB2T58KbKMG8UdBFjR6jpXCkta?=
 =?us-ascii?Q?Xb3J9lHI7h69417pAYC2WN6zE2kKgt/whOC+BawZiVtxMHg+hYAC/blz51MA?=
 =?us-ascii?Q?hKXJbu2D1A3WDE9HSYEbBGhgw9UbKXTj+K13R+t8q0X+c7H0Zzhn5SYpOC7I?=
 =?us-ascii?Q?MtjivxlOJyE70jMKwpTqbvqlMKzDIogF9ROGGtK536dvTYT7vwj8wvENieDt?=
 =?us-ascii?Q?0N4kfb3i4l4L90zloK96d94+8+vw3XUbt64fxhVGxUpUrsZTMfy38PxTLQ5U?=
 =?us-ascii?Q?Ce2sDjR7Jg9+0+ebaMME7+hy1IhlJvXS1uPjRBVa9Ra47UfIPkp3LUd06wS/?=
 =?us-ascii?Q?60i+c/4gQLCugEySF3/lkh02l2id/QECItn6z20J3TR/F3tAG5rx+XZO1uqB?=
 =?us-ascii?Q?5YXtKrRldl1/z6lWZ2d0k+7eNIajY/Sa55XMPIckfrBpWlGyLhwVExjOmGJj?=
 =?us-ascii?Q?tm07HZFbIRI8Qo/DQsAatbRmJYuOk5kgU3/vNwYOKsggdNYzuDRfT+qyDE3g?=
 =?us-ascii?Q?b0NXukeyrrBNyU71wRxnYnyBNvlr353TkIv5J6KD5FI1lyi3HtSAqFqKl28l?=
 =?us-ascii?Q?7TtjJfKw32mMc9YU66GhfRGwTHjX+XPkhh8lRix6nZGkj1G5DZ1lADlA+mHb?=
 =?us-ascii?Q?znHhzZttu/QQEvL/VyDR8qz8Y7g+s0QKXX3K9RkNUdS93nNhCUIWunhDqFbG?=
 =?us-ascii?Q?YYVymHrSdA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3447d56-fb5d-48cc-9dac-08df0f0a6073
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:08:55.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cF4rOjIf0vI+K+tVifn7Xl8bqthqHYCQfGIWMT4swDsK4qJUqqirYu5c7pWu3w7/CPyL++TPrxklKvUuYA/87g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

Document the "cxl_reset" PCI reset_method value for Type 2 CXL devices
and its reset-safety contract. Describe generic PCI driver quiescing,
exclusive HDM range reservation, cache and IOMMU handling, function-scope
restrictions, and state restoration. Clarify that the method does not
offline memory or revoke mappings, and that it requests CXL Reset Memory
Clear.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 55ea1db749a1..248d4f427589 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -153,6 +153,31 @@ Description:
 		"default" enables all supported reset methods in the
 		default ordering.
 
+		If present, "cxl_reset" selects CXL Reset for CXL Type 2
+		devices that advertise CXL Reset and CXL Reset Memory Clear
+		support.  The method is only listed for single-function devices,
+		and reset is rejected if the device has enabled VFs, so CXL Reset
+		cannot affect another PCI function.
+
+		When reset is triggered through the reset attribute, the generic
+		PCI reset path calls the device driver's reset_prepare() callback,
+		when provided, and disables PCI I/O, memory decoding, and bus
+		mastering before invoking this method.
+		The method then rejects the operation if cached HDM state is
+		unavailable or an affected HDM range cannot be exclusively
+		reserved.  It does not offline memory or revoke mappings; CXL.mem
+		users are expected to retain conflicting iomem resources while
+		access to an affected range remains active.
+
+		Before issuing CXL Reset, the kernel invalidates CPU caches for
+		affected HDM ranges where supported, disables CXL.cache, initiates
+		cache write-back where supported, and blocks IOMMU translations
+		where applicable.  After reset, it restores PCI config state needed
+		to access HDM MMIO, cached HDM decoder state, and the CXL Device
+		DVSEC Cache and Mem Enable controls before completing PCI reset
+		recovery.  "cxl_reset" requests CXL Reset Memory Clear so that a
+		successful generic PCI reset does not preserve tenant memory.
+
 What:		/sys/bus/pci/devices/.../reset
 Date:		July 2009
 Contact:	Michael S. Tsirkin <mst@redhat.com>
-- 
2.43.0

