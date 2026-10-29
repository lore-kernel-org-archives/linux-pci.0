Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285873;
	b=sSI7vLDUlC7xGDKRVHmB/LNXlmcDaqHYdqPd19twhRk2fn4BybwycZXoSO6uLf3d2mhK
	 3sw4pyGocrkmp96qZqH0xRnQDU4V2ID8ipYSv1MCFd+wfpE8ti9aq5UiQATlXSWbVuX/r
	 OB6Czi1OgTCHV+9Kd6v83ThaWtGK1CoobBMMnogNmulWdGK9Jhk8DPDgVD6poGf0qOMh2
	 azEYa1SxhHeIlgBjD4zyRN6hR4CWN2I5XrEQ+DBylfW4m06pVuN0RNYUUMSt+WrA9h8ps
	 eKpIz4umMMe2sKWHWavNLUwy6BCTBcXDEl1NXdA87OULKjM2SpqA3vs3nlG09NWJTdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285873;
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
	bh=ZA01ZNGbOO8nx00FxhxoOQPRlbx0d8Kx/FwtD0qY/C8=;
	b=gAwaFzX2ZDhS8BDvpZaq8MBebIr2LBGf/FsCSB6BRiooI6QIlUfJV8+NUWmJXsqctTIX
	 +bxwKKxlUE3HtXEMEzngh18qyJ1E2xkGfl5e4A7UQLE2u0bXLr4inxiy5l1TqxYri29p6
	 QrQYUflDYt/A6l0+gNR1XnNgZTm/WebZCkSM3pYLZDwS1z5MPyxyzkviYzDIZTZa35cJ4
	 O5xXIH7PAke2YiozM9Dy0LaVe24vrkzKifmLk2/YX9MywxlOQzIdUy3Xlu/k6JlCzO1Ig
	 4SryY8tu/22ovcIvw93XE/CXqTnYjT8zBH/de5vplTFYMFhGm1oERZPDUTEeBtihs5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZMbbwPgY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.4
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D7960A2634;
	Thu, 29 Oct 2026 14:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03D7960A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZMbbwPgY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2Ru/atAq605SRL40ekiynmB5x/e+7dxiKFUSDnZ0C/+cPCwHTyslS7kNgTfi06NALFQ5cYe6Bs5K452ytuNvT/La3l9yvBBr5vMj7b3rJeDCC4UKyTZ+GH1o1Eb8iVOv0A7jeZYOmDHggY5G66TadRL0iDTvw8AgvBPNR5X3PY8lJAS+QFPeU7k6e9ZSaBkuUnNYBa7mnryr8qAOQn+SUT4KB2zOkDFF6HWFIsKYTLCHtz+yXKyBNsKf4YHko38wHzG4H48T9HuxkYkJHTattjcbKb/YzSxAsKrozEDvVYH8BaM9BTbM3UQYgsIdHxqxgfpJ4vzq7zwQGstzZRcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA01ZNGbOO8nx00FxhxoOQPRlbx0d8Kx/FwtD0qY/C8=;
 b=DY9eitKTlCUasb8g5VpDadnmlVDBvhewDtbG+ROW6xjc/ytwqRYrNK1xnatVkveqiLe3p8O4inIMefxuFAC9x3Qlvx4EHgcDE7eYSmt3XFu0x9a0TUHS2242u4EnOoMcyXb4yGEoLaXLzljWDVIM8LlUHRrtF3W31E52u9gtL8WrvMhcZWAy4ZxaVu8giKN+PuGS5A00fe1vJlBBGqVJgkTN2S0uj0BSOB+CJFUSy0d79CyjpbHj4SbgCjksCtDR7PmZiWnjKFF/QqTRd0SmS2n1O3RVIZSqNq1kh+i09GujAtV8VCRfoxxxp3149LbdLLsOhqwP+SPYQbGBb7EG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZA01ZNGbOO8nx00FxhxoOQPRlbx0d8Kx/FwtD0qY/C8=;
 b=ZMbbwPgYjXg+QCC6H5+5wkaqHj8ukq2xxwudOl37qweS6jwFm8eFhMEfWqNtO2eF/ZtZ3uOsyCYl/zrzDGev+e8U9bMRDT9LtPQ1yWtCrDmAU0k8qWaNwcIssZDRzlbakcMesZApjO6JPcx7OTfs6SXJBx7D3C27I7ysM7on7Teu3j9Bm5ZrO1hKLcmZBJ7k0LxKS2gxLN/m01bxUEymBkaIVpne7TrhBxkmWTzIUANEKePy63tUMCamWN94OGriHy5x6WCYyyOAlqcP/OVKGtDFDj4fnWSVWNkGK0muD25dqt1FmHRxQN0WnI/ywvDADVBsX1G4HRM5M58kv3+npg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DM6PR12MB4355.namprd12.prod.outlook.com
 (2603:10b6:5:2a3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:57:48 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:47 +0000
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
Cc: Li Ming <ming.li@zohomail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v16 13/18] cxl: Validate and synchronize HDM ranges around reset
Date: Thu, 29 Oct 2026 14:56:58 +0000
Message-ID: <20261029145703.2185231-14-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0057.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::20) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: d04ccfe4-05a8-43f3-4be5-08df35ccfef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|921020|261028144727099003|261009223027099003|261022105027099003|5023799004|56012099006|261026121527099003|261026140227099003|261022113327099003|10067099003|11063799006|261022075727099003|261021121427099003|261021123027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	alR2ukOzVA/QPy3gXjvRhSGmP5RAvT/W6Xy3rDrpN+gMhSptBs20U9+GkJcCBhVjHwAoDLesVRg3DTpmmVjbOAtysqOko66+IV8Y//TGI+a81a/MlHfvbyEPhLc3z3+8TzMq6/+oAd4BP1yLoPU8Lsa+AkVD1jhTlr4m4QA9eJIXZrsC6VWtTpwRJDVCYasEXu7oxdGZ4km268HMfKASYqkF4V2NeWF9ZkpuQ/t43aLicgSek4F/bM6i0sfKQcnWZpKz18wZVheXF6npdZ+gDlh0UFPSRdp3RzPRZPCtJ18sRyXA6+RR0mnydR6X7PAY4U2sjczTsuKbZPQm+wizMsvnBuNci0tspJMafvq5+zYdcpR4bbYBY/K75zeknhay9sCkMcXQA4OLUsA8VKHqaqPtksWPjQu1VPIG3EbNhXQa3s6rQvqdgDUBkm+CWAfPVAsSzcS4iRa2ilUtrieK8CESGFSYFLdxtXNP4HNjVAciTDxs3nwub5HZYrqx1olzN2ChSMC626BLLdEiimeolNK/Oq//qm24+39JXTf5JVFk8jNly+ersAIYPpT7ZxoNhPZ6BJS2bhulTLZcIev2cZE1ZrPx1DMbucCAzO/frcZvDRKqjO0Iv5o7BMryriqER8dAe5jM8NfMCNfozOfo8dDO/1MnDMjycdbIBr8lcfvpGQlHfKdzWzkSUr81ZXI/9iYZdgGxNmfkU3kVENgtxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(921020)(261028144727099003)(261009223027099003)(261022105027099003)(5023799004)(56012099006)(261026121527099003)(261026140227099003)(261022113327099003)(10067099003)(11063799006)(261022075727099003)(261021121427099003)(261021123027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3GrpJD/+KgOPqepIzfZDAC2jwSA68Znl9Sbxhzi815EPuxKOyMG7oTvQGc9l?=
 =?us-ascii?Q?jG7iu/x6zyfmpwlSpB2KHDk/JPhGiT9TygerKZidFLD+mrYxlp5dGFTpIjBC?=
 =?us-ascii?Q?2NOCerH+h/fyQ1T9M/mdAFW9iR/WhPMmGYTIt3EGkEPHiGv7yGANtJY9md6I?=
 =?us-ascii?Q?6Uwq98LtNHXo3lo4IvFrheQdPB+DaIkmccdJBEwUu/NCJT0UkuOcEZ1xoM6x?=
 =?us-ascii?Q?1lMmeob04JCSj9xgwxEfGyL0/J6tG2aeIduUKmMIZe0OArU+Wf0OGOjyj6qw?=
 =?us-ascii?Q?4WyCLBV1xCaQizPgDs+Kqs5SLrw/4yVpuKYzlndOWKxiymEjZ3/FWTlZe433?=
 =?us-ascii?Q?fYzj58MaaohbNhcZH6dXTts/gfN8SfRIdeWDiX9hwi7BX+zIvwvXGvkudiat?=
 =?us-ascii?Q?0k5cfMIieQbK6cjBJoPifMeSzLZR+JzCnnceEktwOieiuA+XJZF+S2YQLXKR?=
 =?us-ascii?Q?gdGqIZsJtST8JdT+xBczJE/x1fhKkJfTNniGZn7WGAMkJjQBawa/Zzu4QPkN?=
 =?us-ascii?Q?M3K7LtiZIrBH3pdH2Oh34V/5YQU+ggPK+hBnaI3+7ij3F1iik+//J6iEGEeF?=
 =?us-ascii?Q?msYF0sLb4wfp+52dVyiFmrSlpCKINLZbIHrYoXs6NXw8frykdCexnca9O0Mh?=
 =?us-ascii?Q?kyvJJIS+Sf62MLmKCkYiL/DrbalacntMh0NmuQSxuInZAqTZN3eJovEaVS1K?=
 =?us-ascii?Q?6AkatO2pzZ+IhUxN+R4oM6HrQVdgFp7nKzXs9YQJ2pDaY67QfTVHQWJBjibZ?=
 =?us-ascii?Q?hxaBel0/AnjKYQmiH3WCwI0FsQ/3ExThr8JEXWUrH+qFh0TKn5O5wZ2YiS5C?=
 =?us-ascii?Q?gmMAgWSZZW1kLLz9UoNi+apVQdfbbYuPhzJgg62MVh+r6Yip696GP1EvBeqv?=
 =?us-ascii?Q?K1xhOlDHD4Pw77ztmP4e+gODmY4RMraTo/4R8+/T/EwxDnr/riiHHqLOBNTX?=
 =?us-ascii?Q?meYyCp2mPyNgNnY+z+2IT4lftw7Cg4uVWIjlU6uQh0+1J6Nfoi01OvZFWrty?=
 =?us-ascii?Q?lcURp2smwhgNDjaRWm6jI7qkzmO/4CNDj419xc/oCozSJBdluFVpYm1s0u7O?=
 =?us-ascii?Q?k+/nkyibISh74zT/rPNLMBOvb2SIk7H5p9IDKJ10Nrshuv8f4CoYEf4tIt5M?=
 =?us-ascii?Q?qnBWdWwuiO+SDRvKe68kpWR1Ysi6vR496G+rnkLUjNltOmKeHazKrmjbfjbP?=
 =?us-ascii?Q?dmzl+Vg4RFZgXFhBGIHb/glNkfYLjTLO4gu0Z2RYeELefVmsFmVursL2MN1D?=
 =?us-ascii?Q?epcl92WJuLmZJmqjeKDoCfGhfmip9tQgCP6Vh94tc2IsLyZQd7FcmKkORH6s?=
 =?us-ascii?Q?GZ5A4MOgZn6i2QLOzCzUUcCzKWH9bV7aQ+TNGsm8MnsOx2t2vPisJ9OyNc97?=
 =?us-ascii?Q?u5Q6bAeOF9GRyCJ3Z7bB/Iodh3haovjds0hG4M7t2/UPmvceRsxvDK8TjDEU?=
 =?us-ascii?Q?Xj+/RQowDvWNjoD28ZX02wbPdDUZNOTLAjxHnRdrtA/axYt44dKZBoR0wAw/?=
 =?us-ascii?Q?kxsjHptP00TJT6DLpxOvUXYzXIGNHjyy42Ms1UBElKpv103dbZy1Cz5Z/UmF?=
 =?us-ascii?Q?gGHIV9kCnbcl+x6470nYHviGayNmZ2YWXEYcXQEFXu5EE+XXwu723TRqI0TM?=
 =?us-ascii?Q?vg1Wb6SVmAuQ8/Pd8QHZJ/6HDxZDFLqjPoz0WPvXdg2bcvUBjkhnCdPzLrUT?=
 =?us-ascii?Q?//tYOOlQK8dySZZ/UmedMOYmJ+b2tEiJuNNwBK8GSd86xa+B68+xxhtnxlDc?=
 =?us-ascii?Q?/beZusUKgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04ccfe4-05a8-43f3-4be5-08df35ccfef1
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:47.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hy8r5dfC9SXuSJDPdLt/oalSuUOL++qjxv35N6bI3ed81hf8Yo3rVp8fiL+ItBDCBG287fCU9ZkrKOxo5oWWBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355

Refuse reset unless enabled system-physical HDM ranges can be reserved
exclusively and CPU-cache invalidation is available. Invalidate before
reset and again before ending IOMMU exclusion, holding range reservations
until the second invalidation completes. A later patch places state
restoration before the second invalidation.

Reject normalized-addressing decoders because their cached ranges are not
system physical addresses. Ignore zero-size decoders because they map no
address range. Refuse reset when the device decodes memory through its
DVSEC ranges instead of HDM decoders, since the cache holds no range to
reserve for that memory.

Hold the global cxl_rwsem.region write lock across snapshot, reset and
restoration to keep the decoder state and reserved ranges stable. This also
blocks region and decoder sysfs, region probe, poison operations, sanitize
and region-aware event tracing across CXL devices. The Memory Clear wait is
capped at 20 seconds; cache flushes and other reset work extend the hold.

Allow the existing CXL_REGION_INVALIDATION_TEST option to bypass missing
CPU cache invalidation for test environments without a provider.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM

---
Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=5944c6e61f14c0dd28d54537be15edb2cadb0e8b
---
 drivers/cxl/Kconfig          |   3 +-
 drivers/cxl/core/hdm_state.c | 245 ++++++++++++++++++++++++++++++++++-
 drivers/pci/cxl.c            |  86 ++++++++++--
 include/cxl/hdm.h            |  44 ++++++-
 4 files changed, 367 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 8b08bfdc4982..e927e69a3f7b 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -226,7 +226,8 @@ config CXL_REGION_INVALIDATION_TEST
 	  invalidation mechanism. For example usage of wbinvd is restricted to
 	  bare metal x86. However, for testing purposes toggling this option
 	  can disable that data integrity safety and proceed with enabling
-	  regions when there might be conflicting contents in the CPU cache.
+	  regions or performing CXL reset when there might be conflicting
+	  contents in the CPU cache.
 
 	  If unsure, or if this kernel is meant for production environments,
 	  say N.
diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
index 1140006de50d..cb7ec0f86ab1 100644
--- a/drivers/cxl/core/hdm_state.c
+++ b/drivers/cxl/core/hdm_state.c
@@ -1,8 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
 #include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/list.h>
+#include <linux/memregion.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
@@ -13,7 +19,8 @@
 
 /*
  * CXL state that must stay available while no CXL driver is bound: the CXL
- * locks and the per-device HDM cache filled during PCI enumeration.
+ * locks, the per-device HDM cache filled during PCI enumeration, and the
+ * region quiesce used around a reset.
  */
 struct cxl_rwsem cxl_rwsem = {
 	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
@@ -132,3 +139,239 @@ void cxl_hdm_cache_release(struct cxl_hdm_info **slot)
 	}
 	kfree(info);
 }
+
+/**
+ * cxl_hdm_cache_dvsec_decode() - check for memory decoded by DVSEC ranges
+ * @slot: cache pointer owned by the device
+ *
+ * Return: true if the published state shows CXL.mem enabled while HDM
+ * decoders are globally disabled, so that the device decodes memory through
+ * its DVSEC ranges, which the cache does not describe.
+ */
+bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot)
+{
+	struct cxl_hdm_info *info;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = *slot;
+	return info && (info->dvsec_ctrl & PCI_DVSEC_CXL_MEM_ENABLE) &&
+	       !(info->global_ctrl & CXL_HDM_DECODER_ENABLE);
+}
+
+/**
+ * cxl_hdm_cache_snapshot() - copy the published HDM state
+ * @slot: cache pointer owned by the device
+ *
+ * Return: a copy the caller frees with kfree(), ERR_PTR(-ENXIO) when nothing
+ * is published, or another ERR_PTR() on failure.
+ */
+struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot)
+{
+	struct cxl_hdm_info *info, *copy;
+	size_t size;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = *slot;
+	if (!info)
+		return ERR_PTR(-ENXIO);
+	if (info->decoder_count <= 0)
+		return ERR_PTR(-EINVAL);
+
+	size = struct_size(info, settings, info->decoder_count);
+	if (size == SIZE_MAX)
+		return ERR_PTR(-EOVERFLOW);
+
+	copy = kmemdup(info, size, GFP_KERNEL);
+	if (!copy)
+		return ERR_PTR(-ENOMEM);
+
+	return copy;
+}
+
+void cxl_region_quiesce_lock(void)
+	__acquires(cxl_region_quiesce)
+	__context_unsafe(token maps to cxl_rwsem.region)
+{
+	down_write(&cxl_rwsem.region);
+	__acquire(cxl_region_quiesce);
+}
+
+void cxl_region_quiesce_unlock(void)
+	__releases(cxl_region_quiesce)
+	__context_unsafe(token maps to cxl_rwsem.region)
+{
+	__release(cxl_region_quiesce);
+	up_write(&cxl_rwsem.region);
+}
+
+/*
+ * Bound the range twice: request_mem_region() takes resource_size_t while
+ * cpu_cache_invalidate_memregion() takes size_t, and the two differ on
+ * 32-bit builds with CONFIG_PHYS_ADDR_T_64BIT. range_len() can also reach
+ * RESOURCE_SIZE_MAX + 1 for a full-width range, and wraps to zero when
+ * resource_size_t is 64-bit, which the !len test catches.
+ */
+static int cxl_hdm_range_validate(const struct range *hpa_range)
+{
+	u64 len = range_len(hpa_range);
+
+	if (!len)
+		return -EINVAL;
+	if (hpa_range->end > RESOURCE_SIZE_MAX || len > RESOURCE_SIZE_MAX ||
+	    len > SIZE_MAX)
+		return -EOVERFLOW;
+
+	return 0;
+}
+
+static int cxl_hdm_range_add(struct cxl_hdm_quiesce *q,
+			     const struct range *hpa_range)
+{
+	struct cxl_hdm_range *range, *next, *new_range;
+	int rc;
+
+	rc = cxl_hdm_range_validate(hpa_range);
+	if (rc)
+		return rc;
+
+	list_for_each_entry(range, &q->ranges, list)
+		if (range_contains(&range->hpa_range, hpa_range))
+			return 0;
+
+	new_range = kzalloc_obj(*new_range);
+	if (!new_range)
+		return -ENOMEM;
+
+	new_range->hpa_range = *hpa_range;
+	new_range->len = range_len(hpa_range);
+
+	list_for_each_entry_safe(range, next, &q->ranges, list) {
+		if (range_contains(hpa_range, &range->hpa_range)) {
+			list_del(&range->list);
+			kfree(range);
+		}
+	}
+	list_add_tail(&new_range->list, &q->ranges);
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_collect(struct cxl_hdm_quiesce *q,
+				  const struct cxl_hdm_info *snapshot)
+{
+	int rc;
+
+	for (int i = 0; i < snapshot->decoder_count; i++) {
+		const struct cxl_decoder_config *config =
+			&snapshot->settings[i].config;
+
+		/* A committed zero-size decoder maps no HPA. */
+		if (!(config->flags & CXL_DECODER_F_ENABLE) ||
+		    !range_len(&config->hpa_range))
+			continue;
+
+		if (config->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
+			return -EOPNOTSUPP;
+
+		rc = cxl_hdm_range_add(q, &config->hpa_range);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q)
+{
+	struct cxl_hdm_range *range;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	list_for_each_entry(range, &q->ranges, list) {
+		const struct range *hpa_range = &range->hpa_range;
+
+		range->res = request_mem_region(hpa_range->start, range->len,
+						"cxl_reset");
+		if (!range->res)
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_invalidate(struct cxl_hdm_quiesce *q)
+{
+	struct cxl_hdm_range *range;
+	int rc = 0;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	if (!cpu_cache_has_invalidate_memregion() &&
+	    IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
+		pr_info_once("CXL reset: bypassing CPU cache invalidation for testing\n");
+		return 0;
+	}
+
+	list_for_each_entry(range, &q->ranges, list) {
+		const struct range *hpa_range = &range->hpa_range;
+		int rc2;
+
+		rc2 = cpu_cache_invalidate_memregion(hpa_range->start, range->len);
+		rc = rc ?: rc2;
+	}
+
+	return rc;
+}
+
+/**
+ * cxl_hdm_quiesce_prepare() - take the HPA ranges of a device out of use
+ * @q: quiesce state to initialize
+ * @snapshot: HDM state from cxl_hdm_cache_snapshot()
+ *
+ * Reserve every enabled system-physical range in @snapshot exclusively, then
+ * write back and invalidate CPU caches for them. Call
+ * cxl_hdm_quiesce_destroy() afterwards whether or not this succeeds.
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+int cxl_hdm_quiesce_prepare(struct cxl_hdm_quiesce *q,
+			    const struct cxl_hdm_info *snapshot)
+{
+	int rc;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+	INIT_LIST_HEAD(&q->ranges);
+
+	if (!cpu_cache_has_invalidate_memregion() &&
+	    !IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST))
+		return -ENXIO;
+
+	rc = cxl_hdm_ranges_collect(q, snapshot);
+	if (rc)
+		return rc;
+
+	rc = cxl_hdm_ranges_request(q);
+	if (rc)
+		return rc;
+
+	return cxl_hdm_ranges_invalidate(q);
+}
+
+/* Evict lines fetched during reset before DMA exclusion ends. */
+int cxl_hdm_quiesce_flush(struct cxl_hdm_quiesce *q)
+{
+	return cxl_hdm_ranges_invalidate(q);
+}
+
+void cxl_hdm_quiesce_destroy(struct cxl_hdm_quiesce *q)
+{
+	struct cxl_hdm_range *range, *next;
+
+	list_for_each_entry_safe(range, next, &q->ranges, list) {
+		list_del(&range->list);
+		if (range->res)
+			release_mem_region(range->hpa_range.start,
+					   resource_size(range->res));
+		kfree(range);
+	}
+}
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index bfc31f821d01..4a8969145f8b 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -15,6 +15,7 @@
 #include <linux/iommu.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/memregion.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -23,6 +24,13 @@
 
 #include "pci.h"
 
+struct cxl_pci_cache {
+	struct cxl_hdm_quiesce quiesce;
+	u16 saved_ctrl2;
+	/* A cache-policy write was attempted and may need undoing. */
+	bool cache_disabled;
+};
+
 /* Find the CXL Device DVSEC and read its capability register. */
 static int cxl_pci_device_dvsec(struct pci_dev *pdev, u16 *dvsec, u16 *cap)
 {
@@ -331,6 +339,23 @@ static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec,
 	return rc;
 }
 
+/* Shared range reservation, host invalidation, and device cache writeback. */
+static int cxl_reset_cache_prepare(struct pci_dev *pdev, int dvsec, u16 cap,
+				   const struct cxl_hdm_info *snapshot,
+				   struct cxl_pci_cache *cache)
+	__must_hold(cxl_region_quiesce)
+{
+	int rc;
+
+	rc = cxl_hdm_quiesce_prepare(&cache->quiesce, snapshot);
+	if (rc)
+		return rc;
+
+	/* Track an attempted change so partial failures still restore policy. */
+	cache->cache_disabled = true;
+	return cxl_reset_disable_cache(pdev, dvsec, cap);
+}
+
 static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
 {
 	unsigned long deadline;
@@ -386,7 +411,8 @@ static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
 				      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
 }
 
-static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
+			      struct cxl_hdm_quiesce *q)
 {
 	int rc, rc2;
 
@@ -411,29 +437,61 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
 		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
 	rc = rc ?: rc2;
 
+	rc2 = cxl_hdm_quiesce_flush(q);
+	if (rc2)
+		pci_err(pdev, "failed to invalidate CPU cache after CXL reset: %d\n", rc2);
+	rc = rc ?: rc2;
+
 	pci_dev_reset_iommu_done(pdev);
 	return rc;
 }
 
-static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
+	__must_hold(cxl_region_quiesce)
 {
-	u16 saved_ctrl2;
+	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
+	struct cxl_pci_cache cache = {};
 	int rc, rc2;
 
-	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
+				  &cache.saved_ctrl2);
 	if (rc)
 		return pcibios_err_to_errno(rc);
-	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
+	if (PCI_POSSIBLE_ERROR(cache.saved_ctrl2))
 		return -ENODEV;
 
-	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
+	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
+	if (IS_ERR(snapshot)) {
+		pci_err(pdev, "CXL HDM decoder state unavailable: %ld\n",
+			PTR_ERR(snapshot));
+		return PTR_ERR(snapshot);
+	}
+
+	rc = cxl_reset_cache_prepare(pdev, dvsec, cap, snapshot, &cache);
+	if (rc && !cache.cache_disabled) {
+		pci_err(pdev, "failed to prepare CXL reset ranges: %d\n", rc);
+		cxl_hdm_quiesce_destroy(&cache.quiesce);
+		return rc;
+	}
 	if (!rc)
-		rc = __cxl_reset_execute(pdev, dvsec, cap);
+		rc = __cxl_reset_execute(pdev, dvsec, cap, &cache.quiesce);
 	/* Restore cache policy after any attempt to disable caching. */
-	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
+	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
+	cxl_hdm_quiesce_destroy(&cache.quiesce);
 	return rc ?: rc2;
 }
 
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc;
+
+	cxl_region_quiesce_lock();
+	rc = cxl_reset_quiesced(pdev, dvsec, cap);
+	cxl_region_quiesce_unlock();
+
+	return rc;
+}
+
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	u16 dvsec, cap, ctrl;
@@ -460,5 +518,17 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (probe)
 		return 0;
 
+	/* The cache is owned by @pdev and does not require a bound CXL driver. */
+	if (!cxl_hdm_cache_present(&pdev->hdm))
+		return -ENOTTY;
+
+	/* Memory decoded through DVSEC ranges has no HPA ranges to quiesce. */
+	if (cxl_hdm_cache_dvsec_decode(&pdev->hdm))
+		return -ENOTTY;
+
+	if (!cpu_cache_has_invalidate_memregion() &&
+	    !IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST))
+		return -ENOTTY;
+
 	return cxl_reset_execute(pdev, dvsec, cap);
 }
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index cfb55b10f8ac..7919d872a34d 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -3,10 +3,14 @@
 #ifndef __CXL_HDM_H__
 #define __CXL_HDM_H__
 
+#include <linux/list.h>
 #include <linux/types.h>
+
 #include <cxl/cxl.h>
 
+struct device;
 struct pci_dev;
+struct resource;
 struct cxl_endpoint_decoder;
 
 /**
@@ -45,7 +49,6 @@ struct cxl_hdm_info {
 	bool dvsec_ctrl_valid;
 	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
 };
-struct device;
 
 int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
 				 resource_size_t size);
@@ -59,5 +62,44 @@ int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count);
 void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
 			   struct cxl_hdm_info *info);
 void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
+bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot);
+struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot);
+
+/*
+ * Region quiesce blocks CXL region commit and teardown, and with them decoder
+ * reprogramming, while reset handling captures or restores HDM decoder state.
+ */
+token_context_lock(cxl_region_quiesce);
+
+/**
+ * struct cxl_hdm_range - HPA range held exclusively across a reset
+ * @list: entry in &cxl_hdm_quiesce.ranges
+ * @hpa_range: system physical address range decoded by the device
+ * @len: length of @hpa_range
+ * @res: reservation of @hpa_range, once requested
+ */
+struct cxl_hdm_range {
+	struct list_head list;
+	struct range hpa_range;
+	u64 len;
+	struct resource *res;
+};
+
+/**
+ * struct cxl_hdm_quiesce - HPA ranges held exclusively across a reset
+ * @ranges: list of &struct cxl_hdm_range, see cxl_hdm_quiesce_prepare()
+ */
+struct cxl_hdm_quiesce {
+	struct list_head ranges;
+};
+
+void cxl_region_quiesce_lock(void);
+void cxl_region_quiesce_unlock(void);
+int cxl_hdm_quiesce_prepare(struct cxl_hdm_quiesce *q,
+			    const struct cxl_hdm_info *snapshot)
+	__must_hold(cxl_region_quiesce);
+int cxl_hdm_quiesce_flush(struct cxl_hdm_quiesce *q)
+	__must_hold(cxl_region_quiesce);
+void cxl_hdm_quiesce_destroy(struct cxl_hdm_quiesce *q);
 
 #endif /* __CXL_HDM_H__ */
-- 
2.43.0

