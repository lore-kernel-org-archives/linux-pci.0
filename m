Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793963923;
	b=P4HVSEHOCPkUoZ8iqi+MJ5Ml/heSvl9ePNxlcIXvajbauFtlK12e4S7lmjnUFctYV4TB
	 mANXF904S8O8TxT4LPCatKPMBs1zoxodsdwfYco3vLzFiOlKn7JjON869yJhpEWwuJBK1
	 z+5zCRGRC8PGvOLXGvsGFzt8sJakFFV+TsA1YUKPVFsOEg5lhb+JMlLCNBLdEJG3Yh3jC
	 nO0gO7gp0hVp2ENk4npt8aNTgKD5KxF0AmIlnsEg+gt39zPocMk6epyAC8ZHm+/IIXje2
	 8cD82BCQW9sO2vfFBhe9ch3LSJBOnyidkDZxM9sDBC2ZIRspZhIjeQKNfdLJXBNttNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963923;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jeY7U/8VtHKGP00Kx5gZ4ncb6RoLlvnFoDja1mpRODM=;
	b=KfasFt6gnlkOJ4fRNz7We/2sMrpQ0/7TOzd5hsUoqGYtNcdTZZqQ3k8JikHnnwYOU6Mr
	 ItvtnlFzTRA2fNbf2ACtfIRtmTzadTvwnc0K2qQey8OLKHryZaJtWtY6Y9I/cumTW7Osq
	 m8Wm5Tda30cGR9i7lYojV866Rsda2yo6q/lERrxZV27mGpReWxIYHj8aB96IMQxszgjVK
	 tyHW5Kb3LnhHxCIHMMILffX6eXSuY+LRwV2ApkOj89YG98m17HH7mJuDvQ/W1L+DRAj6K
	 JsqB24e3uNDy3tkqwanGgfqQi1BqjjO2ar3U95Rep70dF3lwifTNkHZ69WhAJYy15gQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=euM9uMzo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.25
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64F606A837;
	Fri,  6 Nov 2026 11:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A64F606A837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=euM9uMzo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ec5NDhuv9YVEzj50OkB1clC2Sdbkj71FUWG6krnk3zgm1cNgyBBbPd4G0S+b+zO574qStHcLnDdhrPHp1L364Yvo09H1vKq9Gz+s4zdYqNPO0O5nt34efptWhMfEvHaTbbZAi7VXdPuDxHK5ahioslr+8IPzExyfonTobm9gibHqDRiwCG7P+T8ytyq/6NuGDf8mTHyvB75T3c3Wb47wNZRlgC2PC1NIVCiCsmRSQg865lGD+D0+JXpAPGP5sbz70qUQ/eDGPaqcnU6rbfvseqOQCSdguKdITBuVhaEvPb1zvYxcY/s521M3ZIAD3ciBO1qg2lwJo/gsP+KA4W+PXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeY7U/8VtHKGP00Kx5gZ4ncb6RoLlvnFoDja1mpRODM=;
 b=iRZH6xde76W3FsqZLoCHdXPR5x640Yxxa86ZUKWtiRZuZ5K/Bb/Y3dVF/EE9IaX51Z/Jz8WuH2WiEPg7KeQdkPJTdSuozSHDEhZEVWqYY+LokPvjQyXOZ3jIMhGJX9GuIbGcKKxuefAgZOP2uzb7/6PvXc6k6oKp4V+0wfKx1uP4Oof0hvPUjb2ijWitbE/Cok3cCYFFnYgO00OLTZAp8464Cx7XkATeF9Y5XOdnh0hgHfXH7x4Ojg++IQ9HDWOYYURvgKIRgqIe9y6oa5xVWga03de8JbRu4fPcuKZzXocNdF+tJIjK1Ylss+wk5Dk2HqwcQhOOqw/3rRIAyhFueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeY7U/8VtHKGP00Kx5gZ4ncb6RoLlvnFoDja1mpRODM=;
 b=euM9uMzodk7di1Awg2qFKcVFrzaRl869bQAmJ+DIexiWvutWwbCyG0DLEQaflHDwotsXE86ECVg8SkzbVy0hQ0Hv0zSLZyES8JSGleki/Hh9brYpaNVFxI0zp3Cvr2DeLBb456o5fhfdkVRRDXKFmegNGqfNItJkZp4hZh6ZUc6t7JOnkJvrJ/DfVWaVa94p3Mg5LKYf1UUEdEP2+ov/m5gGlZa11lBSXX3GLSgpkL9PrH5UPP41DeSMhYgx2RBUlts6I3vUToQC5pQ8wzQFJiKQOXUzb36MNK1ccNJpSbXuuffQbMH0j4rG8f+mteyXDDAoh+o0mt6L3tcAe/ZjdQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 11:18:37 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 11:18:37 +0000
From: Richard Cheng <icheng@nvidia.com>
To: bhelgaas@google.com,
	dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	benjamin.cheatham@amd.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	tglx@kernel.org,
	wangruikang@iscas.ac.cn,
	vidyas@nvidia.com,
	lihaoxiang@isrc.iscas.ac.cn,
	xiangzao@linux.alibaba.com,
	shawn.lin@rock-chips.com,
	alifm@linux.ibm.com,
	18255117159@163.com
Subject: [PATCH v2 0/2] PCI/CXL: Guard MMIO accesses during reset recovery
Date: Fri,  6 Nov 2026 19:18:27 +0800
Message-ID: <20261106111829.55823-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: f49df910-918c-4f0f-fe4e-08df3bf7b39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|11063799006|56012099006|261009223027099003|261102123227099003|261026121527099003|261021121427099003|261028144727099003|261022075727099003|261022105027099003|261026140227099003|261021123027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Nr7YGKRmOIfQVUTy8yZ2NoiFKliEqcf9gEEStsXa8vZBco7kgtIQK4tzJ6LI5/ZOJGBZnLHEuDe7XFR1Lmr+/eQLlXYq2Jx6ZGAvTL9knt7+AR9oAYamXFhD/Oa1soLD/Wi4IXrFwOywZCs3bMk6atptq/T1m/rddh84ROwYNNbx1Wr9ovWDqb/F2i8lo46fiCgS24aRk/06gWeLPzFLsCgCAuK6x/npTXswdb9j9a4Bulv6hA8VMH53+L4Fb+dW5sYGJsge50Jjux0HfbAnyXFGw0Y+GDDOKn3w+zRFImltzdkevfXM4lpnUGjaydiOJt7Tpw+52p0oeWHkowLGuNvkYMrSk/A5VXr5n1PW1g6LcZY1FWYxqGpBg8Zu0vfKavZcVWinjDH1HcCaWqvpjqYVY1VeeLGf+wl3Aw1ZIG99DWvQp6lZ8o31+S52azCNShsnUsx5a1j6DE6/ZPDVekGcsIfM9UxHMkpclhK6ZXqnKh0IRwyY+6LHAAb0tLy9YfKBfKGtaOWriConDOrptjx2ao7nUMRbr4YGKyGlIZhQJezVcfMH74y42gfCQw0qT/aA+mN7MYca51KVeWos3IfgNtxWm2VG1K6FGaWQHRTYrR8WxV4UAPey/dFOzP8c+/kCcEN2XsrYujvOgQ6PODzFqJo4DbNAqmQcb+IUv0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(261009223027099003)(261102123227099003)(261026121527099003)(261021121427099003)(261028144727099003)(261022075727099003)(261022105027099003)(261026140227099003)(261021123027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eb4KA6ZZFBGF98PHnmPNLUszPCQWCKDtpVjPe4+TGfQ9WerARGfZYGuSCRBL?=
 =?us-ascii?Q?Jg7G1AOu+yRdw8OcR0W6mKamlWhEsc3zE06lskciHgLk4RryztoniQA32e7P?=
 =?us-ascii?Q?mA7ls6UhJ2ajnk9fwGlr/d6i3Kxnyr1Ki2mBiaJ7AEJJc1MV6m8g+B1o4lY8?=
 =?us-ascii?Q?eVyuyHkCl7auvDorTKjJRZhmcYvOy/QfwR1OTbI7EaxuJJFY/EfHI+/PPb5q?=
 =?us-ascii?Q?SlYVeXcQ/QRNq7tAF6g8o2B4yOFOXZzfJHSQVsFjKKVTnQT/gqqr92cnxugl?=
 =?us-ascii?Q?s3ZvH2yN0iSTGSE8daL2MnXCgtv/zaKp83+0gbOvsXlKos9TS/ZWZs6hh775?=
 =?us-ascii?Q?Rq4Y/+v3MDKnSE4rboXdzB8Yh83UWpBaOA/44zt5XFxNShyTndTgA80uX75v?=
 =?us-ascii?Q?lcrTltJd0HUd6KVSBJ9jWFe8/NOIWFEw36qnhDvM7BTjBpMxHTLWVohYlyMs?=
 =?us-ascii?Q?aKi/UEtwvdZNsvOHfucTWyVc/7LTNeTjOg+IZmV/PFK3IIG7CNRQhOVjTtHc?=
 =?us-ascii?Q?J8taya2o8w6hyILbiBpGtij6GcvgxcTUJ0oSbgVuTohJ7/hjJntTWZnEbeHi?=
 =?us-ascii?Q?HgbhUzX5Nvsgo/9LT+WPB/i/MWU/FcqfwWy6WJLOBltM3aDQ3Mc3a5Yvy+B0?=
 =?us-ascii?Q?ZEfK8YAfzwHEnKOXYPSYvmoNigUwqlLGRWICl8s2aO3b6mDXCXXcJPa0j0XR?=
 =?us-ascii?Q?kBbv3Uvmo1bL4AC+5JQ9GPlf6KC+jo6CPGwFelZRllf78UWPe8BoM+i7b5Xd?=
 =?us-ascii?Q?Wjgunp3GuyPwjVCy62U3+PYVCk5jWn8BO3HsDJSyrn/nvh+9Yb4gG4K3vgH1?=
 =?us-ascii?Q?vSK9y7MC06CNz1IKONPz6ljqfhhFRhPndGtX7DsWv9MjBu0TU5VosFd8kIW2?=
 =?us-ascii?Q?5KXfwUSVEZpOEOlKyc3uuC4ykda6kPVIo3SiCNYZJsGMNudE9nDvUg1OqJkG?=
 =?us-ascii?Q?N/yQKlLjiSepnQ9ZLRbMe1r1OGvXwtDKEhKq1j5/LCCN8sQ7WnkGocq/Epnc?=
 =?us-ascii?Q?7g4twEh+9XrBMDepkv4B7PairQmP3TKXfb5OJYe+Pt+zJqKjk74mrZGzwfsc?=
 =?us-ascii?Q?FuAJcj6PRrK2CF6uTFDMjsT3DiMcE3aHyN0iwryCd5ZQd1PtIhdZhHJEHhIz?=
 =?us-ascii?Q?H4RzgCc83OtyoEqqvUxhJCw1/QFbu8DIv3t/FthW3SuYCYvnf2PhrkjGy7v3?=
 =?us-ascii?Q?IZYt+rotl1JWq/s77lCmj3RVgyvNT0ms9Mg/q5dNXm3MQEezUVbPOvVhFshN?=
 =?us-ascii?Q?MUpliYCkzZzzcH/5FnsBibjrPF2NopGteCeX3AIH+kxxq2bDLbLlRbqT9ZxY?=
 =?us-ascii?Q?+lWuy0K+0j/6Ch7J+gSyBCevl2T2PQTiSACcK+2f1QSyANCpiAvV8nEV8NfG?=
 =?us-ascii?Q?2o1SAMC6noEorEXK63yJ3S4wGQylRVKPRXP+WatfEO5owwCxZYCw/at0AGij?=
 =?us-ascii?Q?tPwOhBSaY0jQO3bMkhcqb+0cLxxMyPx63Zdn5x+UZl6s51BVMyjzwNyFFge4?=
 =?us-ascii?Q?ZL5T332vTXrHv3XOFhSPgne40cM4iZHYJYyWAB6WaYrHhu9qnpTawzrQb6CN?=
 =?us-ascii?Q?Wq23RmKgFp9g0oEJxgRN4nagTU2QydZ52dc64P3pzRpOUj4pEQO3iUl6jXIR?=
 =?us-ascii?Q?ezrvWa2zg5QQPtXj9cPa89Nx4FjUMQUN+2VfgvjxCoR6RdzGb3oqLXCB+ttQ?=
 =?us-ascii?Q?zBYRRAUWKnO8S2028at95eVFGHjTF2F4S8firicMX1Umx8vNPjW/Bl/gd+g9?=
 =?us-ascii?Q?EA6mmf8u0Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49df910-918c-4f0f-fe4e-08df3bf7b39a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:18:36.9355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMQABjxJP7TIFG/j0ZRcrz1b2svwJIgqMPhmZMKzMiXxQ9DmUebn/kM3x6q7jkJGamtcf4U+0ljDBorwOUvbOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652

PCI reset recovery may proceed with state restoration and driver
reset_done() callbacks even when a device has not recovered.
Accessing device MMIO in that state can cause additional errors, including
DPC containment.

This series adds checks before two MMIO access paths: MSI-X table
resoration and CXL HDM decoder checking.

Patch 1 checks the existing PCI Command register read in
__pci_restore_msix_state(). If the read fails or returns all ones,
warn and return before accessing the MSI-X table.

Patch 2 guards CXL decoder accesses after reset.
The CXL reset_done() callback independently accesses HDM decoder
MMIO to check whether decoder state was lost during reset.

Changes since v1 [1]:
- Dropped v1 patch 1, since commit e8df1d194c39
  ("PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV")
  already addresses the issue.
- Dropped v1 patch 2, following Benjamin Cheatham's review.
  That some devices rely on the existing fallback behavior.
- Reworked v1 patch 3 into v2 patch 1. Instead of skipping all PCI
  state restoration, check config accessibility before MSI-X restoration.
  This reduces the impact on other restoration paths.
- Retained v1 patch 4 as v2 patch 2.


Richard Cheng (2):
  PCI/MSI: Skip MSI-X restoration when configuration is inaccessible
  cxl/pci: Guard decoder accesses after reset

 drivers/cxl/pci.c     | 6 ++++++
 drivers/pci/msi/msi.c | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)


base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
-- 
2.43.0

