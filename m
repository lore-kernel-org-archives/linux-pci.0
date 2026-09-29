Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D062FD69D
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790724412; cv=fail; b=Q22xaBYIn9Dr9ydhqp9u0Ub0QsKbUlU7PajB9TC+ElH3vz3sK1CwbE4f7enVFadP/nQhwOLkMgP0jsKdTVNgvJMHmrXWbxIUVkQFidL4fBUTaBLt9/5bU+x8sJ4RXt1kQFWjo52KdEMoDqHogPgfHAzZd7P1HmgmZLawfzh7RQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790724412; c=relaxed/simple;
	bh=G1sK+g+2l+Sl8B42JRyPil7AJE97SqZ7eGZsaOuy1t0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gxbj9brYV+NIQNyPsdSbEmUF2u+VHPlrRwuIfn57MNKXklHZS0DFvEiZsC4oPYKdC9+ACCdZWLyJnApECXbz37VpMZkNP9vZq1BV2Y/jXJ95rYD+7TruLTJSpNKdMLQ8ZgsHrjKutdR4LuNajM2tAod28rZ6OCoxcqnlzs2Cqwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o6Mp5oKB; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o6Mp5oKB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWp+nNFgaLrGRusEY23BaR9+gqtBjyfrTDptLp3o48E7/c825u/iVA9K9MACr7ZyNMItcp8o4/rr+z0Cd0bzsLoz/maKCZ8QXBGyIBk397AXvBfGIPIKhuECYdYJu27UcG6YPDII7v8/k8QbEh3m689IXW4ynA4HTDiA582J2XZliTzlOiLL5Y1bSiyUk2L1Nxuv1qP1glD6/4UUv+nPohZKa5m5XgAtZLsH1SEMMrNeXLhg9hjV+bOiClKqjnnajwKPx6RYgAHWXP82CCYbiWyHm9u8jVLUXRjA0KnQ4m1MlDkMCUJTklJ4k+MA5FjzcXGLWYiaFA7B91OnjFhQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfgwCQiNg/2Dx6RK9ZkuudLty2+btmYBc+qhTpHMmzs=;
 b=Mh4raVQqtE0zj3BHsGVICougCULz8W4j179l9JXNT7VFmyW8YlBNEqhDNSdHQGffqm+etJLMw7yFDY46m/BwqOZPm8qUaMS8hISgvp8SnfXjQCM27+HGm4zEUoQWt5qW2c1JAZU/5WKKasY4+tLj8DpCNdLQ9uM/MWssh6LvvZLZdc2d6ANEsq741sfiIA3InGCESLxPNcwpao/mnsqZl5RBHbPtm2PW4t2+MiX29WjIEmbMt2ujVJmplCFN28tLfdMczgfo1M27EcA3QHRdI8SuFEpm7YCD09muJFNmBR5E2L0whcRfkt6DHu0AGaIrXbAG3S96nvVxPzCylk/byA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfgwCQiNg/2Dx6RK9ZkuudLty2+btmYBc+qhTpHMmzs=;
 b=o6Mp5oKBeaxuXYMMYeHC9hCtGaYdV5mE4WBowxWfy/41mH389XPtVkPWpW/mkNDrBQL7kHJGnmymHv0X/DTRvUP0N2B9BEZHL4LwAbNwfbjVRxKoIsoCduGMik48uNPs/+clGv8R+IetUbff88k8kjf3U5yuWaIVmF1Ottt/hSOpZ7u/E9/B0XGH31UaqFse7rmuUfGlSDMEOXueIasm/45LxHY/ZZYegJ2WUE3FIEv9MqN8zma39Zq79deZL3PgOobljrjZn4eQ+1ktgxXMzVf0V7mRHyHJOiYDlcKiByuNY6F1+mGlx2VvVltCGfRRy8iOism7qmbJqfdwa2tPfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SN7PR12MB7812.namprd12.prod.outlook.com
 (2603:10b6:806:329::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 23:26:43 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 23:26:43 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Alexey Kardashevskiy <aik@amd.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	ankita@nvidia.com,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Cedric Xing <cedric.xing@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Kai Huang <kai.huang@intel.com>,
	Kees Cook <kees@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	=?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Lukas Wunner <lukas@wunner.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	Fang Peter <peter.fang@intel.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	rick.p.edgecombe@intel.com,
	Samuel Ortiz <sameo@rivosinc.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Will Deacon <will@kernel.org>,
	yilun.xu@intel.com,
	Kevin Tian <kevin.tian@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH] coco/tsm: Update maintainership
Date: Tue, 29 Sep 2026 20:26:41 -0300
Message-ID: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0163.namprd05.prod.outlook.com
 (2603:10b6:a03:339::18) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: a74d0450-640a-43c4-de14-08df1e811f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ag3iIOK08Y8OnsvB1H206rvaCYjOUt9MFoyOV9OizUzCORRpN4eBtsANFRR0J0GUE5AouH4TouFE0F4wvV6cB1sTRErUTv4xC4scs8klLZlSUd605sQseS+43obUhugLBA8Ibx+4Qoo7CaQoCFaH8T5AWFul4E3hyr7d2nN8zWiPQsMRwedzzNgyphVhkI5yNmhng+fKIwzD9WKL5omwhSLwPmrJ5VLli+PorzAnHvCRBdenQQA/5YO0yZe+yAeug+2qm4z+Zf/MPuSSh5mwmlbLqSaQn350UIkqo6SGXgOb1I42fS5h0X3jGdlZkbpVQJvSg2PdpCL/nhOZu+1S1TeSba7Z6sB5AU2Ms2k7mUHTgyspt9CEdem5K5MvHPkOuvL1BZUu7uM9CxhCDdwVcz+FHI4Lp2J2svXeJCsjFz9TDoU6XbpEokHa4cEfzlJnDnHS2YeVpU9tbYVxeCi4SXoWRAPkbzx0TWrnlLphTtiOJsyTbX86WUD+hcqmztgg0oBEGRDItEVTjU7FqEdqnZo2AuLSp7kVQZiGuGA0GwBMIezkgRyZiFcRGuuaYrH2v5hWtXCLtd2msQ73iMvdrx0Jj72bJ3rJOV3SwneI8P966oJsrcmvkKJptTHl/kvNHGdsyW5Xqe0D5BdjmL0RXgzb4VYz1oUZYBuspj61Dl0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEV4Y1hIQ0VrY1NIZTFJNlhlZEVzdExhNEJSLzlVak0yTFB1ZU9vc1U0ckZJ?=
 =?utf-8?B?YkZ5UzhicGg2RnJ6dFNFYVV6QlZOTHVyZXVTd0o0VlBsbWhBVVgrTEkvL1pp?=
 =?utf-8?B?MTNEN3l5RUJmSmpnSUV5aTlEV3NJMzhxQmt3SEo1U2NhcEZneGxDc1FmT1o3?=
 =?utf-8?B?NjJkUTl0VlJmZHl4NGpPQktnd1U3T0VpQ1IvWXRHc21vbzVNU0Q5cmNLYkhG?=
 =?utf-8?B?eGE2cHdyVFpUVnMvTnkvMFltM0hnR2tLOGJpZExGWWd2MzM4ZFJ5N3hBOW5F?=
 =?utf-8?B?RTZ6WkMrTzV0cTZ3dnZiclpFVWZST1pWYStBZTAyYnMrZUd5WEYyek5qK0dk?=
 =?utf-8?B?Y0ZUMTVPOGltNStQWVdETVV1VU8rSTlyTUJSQVAyV1Vqb2dyeGpYNEVqTm5i?=
 =?utf-8?B?NUJTRm1UOU1zV1dxVncwbHN6emE2M3MrQ1JCZmNNVTV5dTNoN2hTbWlBeG5R?=
 =?utf-8?B?V24wQWg4aGNhbG9DRnY4K25wL1FqejJRVnVpRkVxNWRzQk0zckdSL3V3dUFw?=
 =?utf-8?B?OUV5U1Q3VW9RenRoSmoxNHBtVjJLR1VVd29pSnJPZDlVejBmOFN1cUMyekkv?=
 =?utf-8?B?Q0JZN1VTelU0L0cyV0tEVW5leTYyOWNrLzRINDdhT2k4cVNNL0hQbFNzWitM?=
 =?utf-8?B?SU5KSEVkSVI2MmpqUC85WjhUblFUc2ZURkxxREpGVDRFZStLSDJUVnFUdjc2?=
 =?utf-8?B?eDh6eU5CeXcyTlp3aGRTaHZBVWlPWEh0RlU4dUJNY1ZHSDVwYjRlMk9aTnZC?=
 =?utf-8?B?aVBpdVZ0T0cvcm5ESnl6ZmJ3dkhhOVNsc2ZMb0twRHQ0SkNpcENHWVpuc1Bx?=
 =?utf-8?B?VEwwVzV0TGNlZ1loSi82TnNvaXp5Z1VkSVVqSGtCQ1pjUXNEdk5MN2FrcFVK?=
 =?utf-8?B?dXdYQ09SWm1oTVZjZG9kMWVlb2ZYSXV4bEJidE5xQXhFVThTSkpKZ0czYkFK?=
 =?utf-8?B?MWFqbDc0clVwUzFRU1VXSGw4SWprWGxTT1EvRnJ6L01Uam03KzMwbmtrTlVR?=
 =?utf-8?B?Q3VYeGFKbUcyblFneDNrMVFRR0libVBVaGRGQ2lHdU4rU2RSY0M0UmJqRHo0?=
 =?utf-8?B?WEJQL2YvZDh1T2VId1hmTWVaRm95cEp3em1RSkdZbGhTRkxMV0tQTmFOaXQx?=
 =?utf-8?B?V3UrTjJTK2dibkVxQ0w3c0tFMTBCTFZ3Q3FFZmdQL2lkdVI4MUtlNkJhWHdt?=
 =?utf-8?B?VVNyc2djY0ZpWitGZjZ2YWIzcng1TGxSUWJRSmUwempVb003L3pRekZ1clZO?=
 =?utf-8?B?ZmtyQ0VDSk1EbW5zMU40SFNnZTFWaVRGMDRwYmU1dEkwRGtWMXdoY2FjQzFM?=
 =?utf-8?B?T25GS1RGQVVhRElRK0lyMW1wdlFLbVhaZGYzMzFsa3NqdGs3WmNMb2FNRnFH?=
 =?utf-8?B?RS9aa0sxUnNmYjVtUi96SXhaY0szZTZjTU5qRUE2d2d5dmFCcXVrb3AyV2F2?=
 =?utf-8?B?UDVLYkR4QTZMTFd2ak5NdlU4dkliTklVZmIxWXJ1ci9MUE8xcTQ4aUFjZzM3?=
 =?utf-8?B?SkUxWnk3TmlNWWFkZ1BJZTYycEFHWmdjb25yWnAxWE1Fd0JkaHFsbnRhR1Rx?=
 =?utf-8?B?L2YxcGNEWUZRRk1TVjE5V0o4NFNJaWtSZHl3K1VCYWlXc0RvLzRiSTVPVnpv?=
 =?utf-8?B?RmlUVjFPS1F3Vk12Uk55WFNGQjBLNVM1bXdFNHNHa3pEbVEzTlVXZ0VGVkk5?=
 =?utf-8?B?S1RjNG52NTlIaGtlZ3YyY0U1YVRHaFprRjdTa2M0Um5OM1dvbTJJdXY0UzNI?=
 =?utf-8?B?S0o2UWJ6eFk5ZEZlcTh4L1llVGs1ZFdMaENLWDZZUXJYYzkvSXpuOTVzMDhx?=
 =?utf-8?B?RHNiSUZXVW03dG9jaXpveVBWd3MrT0ZlS3dxbmtIWWxvMlVOK2dxbDdDUWd2?=
 =?utf-8?B?L1U4YTI4dkVUUWNKK2JrZXlIUUdXdW54U0VKN3FKVTV6NUdjWHRiZjZjcm5S?=
 =?utf-8?B?c2JmK0ttVFc5b0g0YnFXY3IybnZ5WDNGNUdxdUlBT1RWSldWTjhvYUJYdTJm?=
 =?utf-8?B?NW02SHBTTm1ZVUtPd29ydGlXWk9oQVFiZ2FXRm1kQm9yc0p3MHErN0VhcmVh?=
 =?utf-8?B?T3piQktrb1R6RStzeTlIWkhBSThhMXl6UjJ3UmlRQzJUbEorK3Z6TjVZSEJk?=
 =?utf-8?B?MEh1aEtXK1UxeUdiWklqNCs5QzNIMFVaWGExMGYxV2I5KzZ6ZE54eVFtb2w1?=
 =?utf-8?B?Snh5U3lmcDYyS0xDajI2ZU1lVC9iQ1pldjV4UzV0QTFvWVE4bWhsV2cvUlZ0?=
 =?utf-8?B?RWxkS1NmVGhLRnd4dnlnYk5wNjBrNmxFcnJOOUU4QlJoU3lHbnBFZHJKSG5E?=
 =?utf-8?Q?A4t0fCqejYuCanW8uk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74d0450-640a-43c4-de14-08df1e811f38
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:26:43.4085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjE2ai8Um2PxroQiiCrGmDevy/BE6zkdGuEnK1l3/m+PaUfLyzO9ctW3c+yRAhRI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812

With Dan's passing Aneesh and Jason have volunteered to take this on, with
the support of their employers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 CREDITS     | 9 +++++++++
 MAINTAINERS | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

I've now spoken to all the main companies contributing here and asked for
volunteers. This is what I could confirm at this point. I'll be at LPC also
for any further discussion. Regards

diff --git a/CREDITS b/CREDITS
index a0bd941ca5dd26..7749f1e477ab43 100644
--- a/CREDITS
+++ b/CREDITS
@@ -4414,6 +4414,15 @@ W: ftp://ftp.uk.linux.org/pub/linux/people/willy/
 D: Linux/PARISC hacker.  Filesystem hacker.  Random other hacking.  Custom
 D: PPC port hacking.
 
+N: Dan Williams
+D: Technical Advisory Board member
+D: Asynchronous Transfers/Transforms (IOAT) API, Compute Express Link (CXL),
+D: Device Direct Access (DAX), Filesystem Direct Access (DAX),
+D: Intel I/OAT DMA driver, libnvdimm BTT: block translation table,
+D: libnvdimm PMEM: persistent memory driver,
+D: libnvdimm: non-volatile memory device subsystem,
+D: Trusted Execution Environment Security Manager (TSM)
+
 N: G\"unter Windau
 E: gunter@mbfys.kun.nl
 D: Some bug fixes in the polling printer driver (lp.c)
diff --git a/MAINTAINERS b/MAINTAINERS
index 72294ddfa5b757..729ab465af96a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27788,7 +27788,8 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/trigger-source/*
 
 TRUSTED EXECUTION ENVIRONMENT SECURITY MANAGER (TSM)
-M:	Dan Williams <djbw@kernel.org>
+M:	Aneesh Kumar K.V <aneesh.kumar@kernel.org>
+M:	Jason Gunthorpe <jgg@nvidia.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm-report

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.43.0

