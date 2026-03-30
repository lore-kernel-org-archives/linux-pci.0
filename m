Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0F37E2EE;
	Mon, 30 Mar 2026 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863743; cv=fail; b=PZVcL5/hi5xgT75j1NdzegGNq1UsvIaytLTDpU6Y0Pk+3eLh8GaS7V+8dxnllm5ybaxxDvQJtfJ4MYzKOOKUDg5bcBy1G+cygMl0/iOjRdd4RtYrs4LgclI6GrW4eIIyL5WOYoKIeUrZuoAN+w6UTtnLS8mffvkZocjPbfnBRsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863743; c=relaxed/simple;
	bh=4IfQixiIpBQCEA9G06tqLNT/5f2tYQZL61Ifq62Eg84=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G8+0j99q/aVNgW0At21ZO76bHjeRYPmMJW3wOubAPZ2lKWAbORc90Z3KhLRvrim1ZDjG2s0fTar+RkkKR3+/3vQruwHeM68F/TApUeVIDcLAAS4JowuTfXaGyp21ae8AYk/NqFn7fRKDKTQVS8RiSez84M6bWIWtaaz0HIkEcHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nRkWKVlQ; arc=fail smtp.client-ip=40.93.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nRkWKVlQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2f5TvLMSiigUnoeuAFklplNgJb4tVn9GssBemK0zsbbzi2uYPVkAUMVmQcLlkEnycD72iqGaBH65j2bXHm3K/xv2+c4y97dLLsjPLPXFj5P7e5NzFN9d7dzPxtvOg/QVTwKdXJvAWvrY87IMZf+F0FB2QADClHMqFnphXA8vIH8+37oN+xMsbjIGSgQcvwUYy6kwtRVEFRCZ1B5G5hhVmvNV2JdMLNbV1X+HuzujciIv6+OD1rJGABtxzniNRGw6lNxcWE5Pb44fJY21fEpNqfGhiaVKz89g8gzX7ruipxVsXbPVsV8aiKNCkKKuvLwAbzYc8LCL4YDTjlZ/e1TXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oojef94e/S316OrxpilcCDTc9obzQqGjYZBq11l2y+c=;
 b=iWDLMNAT5w1GfkbJ+dd3yR4A88RARNAkgkvAurSu6QrYtsRylRqvkZBPKHWeSdSYCxJpQ3JqaHDLb147RE1aX4Y+0HjljcyCHEs4ofG8s5VBaBWoOLIs7C+5BfDuxUzoW8ZMBgkBgDaba1GKLcmYFOGB+f+jiMDa84mVh2jqzsqTGIP9kWdtQxFCzTVZvo3URqAW4Mx8Xvey1fIhTteEkdnvad2O7cyKzyWtOZCxSlk40HcnbGfGBLutLbzDXgt+mX9D18Q/4km4nDs+Ow9/9aFphvmPEeuFRm19DdZJbgUK6zdmGG0T0wiKktQdW/viIX9aFF5iKcFuvRjMFCnfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oojef94e/S316OrxpilcCDTc9obzQqGjYZBq11l2y+c=;
 b=nRkWKVlQBUCWMEpe46XUTgF7h9hsZ1mLHXPn7U7QZtNK3vMp9PHeeryHX7ADe5UxSHRX8AdwnWC8B4582U4+kLvJFW2jzd4W2RkQMNduXQXxGFQa9mBODZAFUHJILH6yBoCfEGilClLQKxqk1iV2Ekl6oe7KV/lSgjGoU6/Q87Xh7kbggCs19eBOO6cY1LG2Guk1y4Owu22ldSKegbE5qwoXkM1LjOshBxcwjG6hAUyfRt03MtunKuCRnETLSheKx5rnoW0bOBD6VGLys1GLk4a0i42LPUsSBmmxYv7dCcdXjBNI23UmINJ8FDpS9RelX7hKUFsSm7asoNEzj/9MGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 09:42:18 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 09:42:18 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: rafael@kernel.org
Cc: jonathan.cameron@huawei.com,
	helgaas@kernel.org,
	guohanjun@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	Kai-Heng Feng <kaihengf@nvidia.com>
Subject: [PATCH v3 0/3] ACPI: APEI: GHES: Add device-managed notifier helper and NVIDIA CPER handler
Date: Mon, 30 Mar 2026 17:41:54 +0800
Message-ID: <20260330094203.38022-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0015.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::10) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5bcf05-f899-4751-d568-08de8e40a217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p8aOqdutM2EQiD+mIEbYGFqxWfHDPhSeJAKlM5x2vGOmX03XCb5YeydYAe2hDFtRtRMMKix1q+pdrY7B9QYtL9bAFOQ6j5w9Bk9CBuH4QxzaRYiicq6JyYBpgF3Jrkms6z250QyJ6SQwkJDh7+wPIqeFPlNGY6kkAcdmxjkPhVTfAMcb4o4t3d8OXytd6Gosjd3l5l2NKAcTcuwrp3Xmfg+pOX1Rb/OuvbERF+Z3dbJn0MnydYEfT6FyVa6XHR/GRRlE5qlYwN31KqY2B87AFj8Bd9BaqOO8uty/+t4iTahkzeQUwZOLXssJaFskQQUlAnKBPm8aHQOpC9UcFDCe7t5Pv5kH167I91YwgzthKAQjwwpGXffIWhm9U82SlSEpJ4ZNQfjzT4+8xCyz/wSRMhbQAOyUahrzBAUE0jUJy1rE8FwHq8tS7RpcDe+MLG82lU22INmqxDyKtizo0xJR2Rzm/p3xwvem1oDualNp7gxrlUsnuEn5o1qzxCCmSKiZjbrdzOfr9sppbTfiRmJkQpWxHWRzY2m20sscN6sZ+8YHKFWQwRZubXDAMGj8YCiJkgHw8XqDEWDEQ7dj5EixRiciV8QgISNLCX23B+8PCQEfU3ArvLjzuh4KUR38n0f2LukwZ1rs7ETWaPp7ydHY9oulk2EUfrrp5UbE90AaxiyMqTDwwD+AEo6SDnOFNnjppk/0B4V2b4LA9KexfVxokYagk3Q6atGHE3p4HzUSdSE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yCe/nuCRh4fR0g4JA5GQK8jUGi/j8XxwTnoLHZaYiCJIbvKG893fwAnCXJG1?=
 =?us-ascii?Q?oQnvtTujMam1bOoirlkKhdp2p0Pl82UnPhT36NoFpDXZ0coLMBoiet02C4XS?=
 =?us-ascii?Q?rslMOsG0nG2QPhp+Jb8Bd4d1VBa4gPBv6WKZvMWPhV0l1/Deh/kCORSvwpT0?=
 =?us-ascii?Q?QSejBj2vPKIECnZJ2G7sZPM5GvwLQ1TQ8l9x5HUbSvcNpXAfI0ahLhduYr3E?=
 =?us-ascii?Q?02N5BdCIMdKLt5bIyvlQhY/XQYKzgKdrPgXh5uweX8GUWpi0FvD6Vo0U2Z1Q?=
 =?us-ascii?Q?JsKC02ObfycAnCebxZoRNLze31Vv87P3yw5QtvYdb1+eBcuskyArvCYe7bV+?=
 =?us-ascii?Q?rxTq2/jzr5+4d7Wd8vk9yE2ntqwSqhLEYmR8GspCOakGJZH3eHwTxTPOg8Kj?=
 =?us-ascii?Q?Fx2jPeVleSHNl5zm/23cNajqeU9ZOFE+K+u6UW4EI4VB7JMpnO9OfxwNLOvp?=
 =?us-ascii?Q?V+Xh/to3fLBH4LiQ8TZJf1zF/ee65llf07UiqfBMdaLqfiK0lND8XXwD3hj5?=
 =?us-ascii?Q?nZfNlQuDKi23n4hnsAI7YlQnAdDpohxww/JT6O1Ngknr963xV+92Yx+c8+x4?=
 =?us-ascii?Q?JIY0AszpriD5urVqrcOjVLRZS5kLeMy0mDieCVkPCF6KVIGXFgV9hjIzm+yj?=
 =?us-ascii?Q?ShWq/qkU9MgVbR4ocNY5Mon/F9p9DKBD89+eL2ygRtviM730UIRTnEPcd91e?=
 =?us-ascii?Q?n5J7PwPug8IZS13T+4TBMIkwE7VnUG16TcgJCLRZVvoqcnwj/eBvY06+tFD7?=
 =?us-ascii?Q?1niPjz78fkNNUCsaHPa/W6/jexk6aAp8ygD+eQ+pnwxqJ0NCthKLwPfDvWGq?=
 =?us-ascii?Q?MWHCJ2PpqmNla0M5ADCHd33TOoWsxYCyHHr8jLFwY5Hn9XBQ3HZu+xBH9n+N?=
 =?us-ascii?Q?1Xwkf/U5i/GqYgyZwQD289+Nj/lO89FTN6qZ8S2fNcgIQdIa4+weQm1e7WiX?=
 =?us-ascii?Q?O3VeDPX+psi2uIcJGD+wXkOooSIeCvSfnVgZ3+u6XEeviM+I6qMJE61IXaKM?=
 =?us-ascii?Q?H+IgyhtJ621n0DfOo9YtT+dG2oR7LAm4lNnLQx0ZFUTCgn4H7NJStb/G5NI7?=
 =?us-ascii?Q?yQfEjSa9gWL1bzJI0eTQ4XBsIF9DKvwPN6FqJt5GjGkHF/xZfqMvC8X4ULLW?=
 =?us-ascii?Q?DksboXYIn3zHNQELLoNzWPh4rP04z24xjnhj4ECK1UxKvIgJj3g+A4UzFUA4?=
 =?us-ascii?Q?LeEODcOq9nMCP9+L0qQOEJThnVfi8AtK4TGi/hfCpxlLulzF4Aj9+Sz5Flcw?=
 =?us-ascii?Q?AynbaJacjDCQQjHT4V3oZ/Wjxe7FwqagPUaLoiCHLdpyyxmK0I1rhfC1Ke8B?=
 =?us-ascii?Q?dF/c6/4izkijZ6QmoDf8soiAELx3Fy3yeoWN0oNzL/G19LkmmgAfn7hh+UwH?=
 =?us-ascii?Q?LQBIaJ4RUyi7PQa+zfbah/xzO0Hpy0wVTInAU2jzEBXObUMiLJLQ6+VxVudD?=
 =?us-ascii?Q?bnp7DauwOU66ZTWYa+njCGZwJ9+NuUzrOXYvIsa5xa9SYtPWVU1mW6wvKv7c?=
 =?us-ascii?Q?/4VS2be8AobDrZaldLJbZwe2H2wX30JkQQv1nqpp00FF+g3KnuTnQZiaC9Tc?=
 =?us-ascii?Q?3Fjt78l0CqZRy5BzHcRokWxFTCuiBCqEWjEiIP+szI9hUhTCtHKjfUz7vCSy?=
 =?us-ascii?Q?VS1MnlrN6umH9oeCbJ68s8ttPWoK91IaA9Rh9+r4TUwDzy2cCgRkScltPbHK?=
 =?us-ascii?Q?DNUmoS/xEkLfOSmhgVZy7DBzmoxNoejQE0FaSusvzcbzIU28rzsT5ZA4G1jZ?=
 =?us-ascii?Q?J/RhxmY5Hg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5bcf05-f899-4751-d568-08de8e40a217
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 09:42:18.4539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRtQ1SN8JNeBbKTQFeFPDHHgJkd0mBsLn6za6tGRgy5YYDFKyuCKHSjZxhdxewsPj4kuyBtCMRraX9frsdT/IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246

NVIDIA DGX and HGX platforms provide an ACPI device (NVDA2012) alongside
the GHES error source. The device does not generate the error records
itself; its purpose is to allow the vendor CPER handler driver to load
automatically via ACPI enumeration rather than manual module loading.

The series introduces devm_ghes_register_vendor_record_notifier() helper,
let HiSilicon PCI driver and new NVIDA GHES driver use the new helper.

Kai-Heng Feng (3):
  ACPI: APEI: GHES: Add devm_ghes_register_vendor_record_notifier()
  PCI: hisi: Use devm_ghes_register_vendor_record_notifier()
  ACPI: APEI: GHES: Add NVIDIA vendor CPER record handler

 MAINTAINERS                              |   6 +
 drivers/acpi/apei/Kconfig                |  14 +++
 drivers/acpi/apei/Makefile               |   1 +
 drivers/acpi/apei/ghes-nvidia.c          | 149 +++++++++++++++++++++++
 drivers/acpi/apei/ghes.c                 |  18 +++
 drivers/pci/controller/pcie-hisi-error.c |  12 +-
 include/acpi/ghes.h                      |  11 ++
 7 files changed, 200 insertions(+), 11 deletions(-)
 create mode 100644 drivers/acpi/apei/ghes-nvidia.c

-- 
2.50.1 (Apple Git-155)

