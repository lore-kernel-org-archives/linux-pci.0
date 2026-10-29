Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285868;
	b=aZNbEOJGof2DnnSR917kDkzmBrsiE8su0LP7U699HZRbKICgPPsUB+k0X3yE4mOa6jf6
	 0Peb+dwB+QPCUdC2p42Aoi+TDc3uUB2sOQRx6NWFWyaRrnERzJmSzaP1g7DlQ9jyEFlnc
	 jhGbkvV9SPqrtgK2qrc9OKq9KbNbsAG5VRzQvvgMGl6N3VTR6246n/4cdYV3iHc4caDml
	 xKJ2vadD9dLEbdcFCJMxj61jPRI5K8EX6fcrsLofHGUWUDTJWRPoq2I1Un3b1E+TwTCPN
	 PQyrSQUA9VRKkl47ivZJyT07DzoZyLICqj34dxFburYuyYjgnKzkcvcIt/AYNjXmaeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285868;
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
	bh=cKdd3KhTKE4Wd1SWQ6EVD3+J+EBGdxhVlEdpLpsbcNI=;
	b=CUteQD2TzJmwDDHqGfI2rohC6haQ+nhYO1nrvPzDTSiBH8cFwrQPPSWJTfHGJAFsh0L0
	 kQsoNgA3U1fznhY9uzmMaJpO7IfCkYFR0iYwPqUPeh8mVpXB9ZD5bShvMcz2cJkwk7CGu
	 4fYegyEg1JGQfkCPLWvn6RJhWg5Khy2HSx7OAMyGY6cLvki3PFcgeiIrBKmx6nL3DSb1M
	 xWWeTGxdTVQ9GK3NJWICHB2HZ3F5RqErSTb77HVsp/JRjmuOy8u2W8ERmd4Xpzwu7/Le3
	 MlbebkemGqO0nthGicpWs/xOssWDesGb4VCd1dRREGQZylKJBVwY6+5xp/8QOJrR2Cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FkWiplcx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.43
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013043.outbound.protection.outlook.com [40.93.196.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6460A2625;
	Thu, 29 Oct 2026 14:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5B6460A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FkWiplcx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3sRaP2NXhr0OMcatLP18q3kHn2frTaPE0CtbGKk0HGGELQdBxbjHREicodlE+xLZzGB+zwheVpxw3Gkjp76n/QpgR9cvj9XBCP1c/SrcVnMsfk7/8bEwpPwYxbsnax142UR0x9my2xgRjDSJtDawQQlbIYBmJNNHHKtFpVugN/MkRCMyRzSucH4tczFt8f+v/wFwLKn16Q59PKn8STsAazC2Rf4kdqqgsxloe+XhUSURwOvK263s1Ve9Lpd/2mo/08FRH1ExULR/PFmrJrg5vvRxddy2BP5uQviIM4bAnrp80Dyu1bkDx8Q2LXW8moBrYCVs/4nfBPt80SqEBrGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKdd3KhTKE4Wd1SWQ6EVD3+J+EBGdxhVlEdpLpsbcNI=;
 b=T9Y/AI9+69PlVCQmMMBedlBIsoF6EL2LPusPFhvPhaXLaeh+xkVdEv9gTTBdnV8ugaR5sqwfGHaOcBboh3l52ZJjOPyxRVmzfkoouVBTjZbWW5DPwp3BBlr9XOWuCNL2HpVfzeqxZqfV3ySDN+bc+NX7iGNeNkNxkZVoIXSAItAcIqYLUAyUVQ0JzkmCCgOHjknPidgIa5cF2+Oj0PWGnarVEiEYUc2e5nop4rSaOuSXEkLjRlQ6xBOpoFgWg6x/2Tg1k/PFuGx39Hio32kqRq728vsa1V0pzTiae0YH5r9VJKAH+PtAfVrsv+WW7nbIKQ2xAGtb70Ay/xihmbeSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKdd3KhTKE4Wd1SWQ6EVD3+J+EBGdxhVlEdpLpsbcNI=;
 b=FkWiplcx1GvsAqcG/6IqTqsJvjW1t/+2ZicjFM295fjZzET/WUFl0EGqXRg/D0S1cfcggXrTi7NqPBngX5ANMBvMNo087Tyl/IgB+J6uXZQASvs/WrUX6x2gR4qDDqYffTPPdG9Y5wDDyAIJQhF92/5vi6n9SMHwXDXvrJNi2EKFQeN39ju0RNgyqvvwqrx6ptPXut5YFE+7Uu2xzjUHzCZ1wmT/bNESzAnsGSdhxKr6/lDOBtW7nkx6C8LXk0rD8rerY9jMZfXZ/lmx9vHXHq2lGruq+raXMb4DJ2Fk7tw+QwIESghGeM7Vz4AcSiTlVdCMG4w6838EdRjIz/cYIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DS0PR12MB503760.namprd12.prod.outlook.com
 (2603:10b6:8:4ec::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:57:43 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:42 +0000
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
Subject: [PATCH v16 11/18] PCI/CXL: Cache endpoint HDM state during PCI enumeration
Date: Thu, 29 Oct 2026 14:56:56 +0000
Message-ID: <20261029145703.2185231-12-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DS0PR12MB503760:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d99be8-fa3d-4f5a-589b-08df35ccfbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|921020|260925022911599003|260925021911599003|260925021311599003|11063799006|5023799004|56012099006|261009223327099003|261009220027099003|261009223027099003|261009221227099003|261009221727099003|261026140227099003|261026121527099003|261028144727099003|261022113327099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	lkMMyjywcsJA3D2Ibn0Sz9XvdORIW7DK86XneHake250l19kuSm6fiqc5p4xy3DsbZLavrOXYKV2QNzYr4wTt+siGyy7vgbG//6B+iOVuEeLDsQri1qyeZ/3shCO6YRdVwDNkD0npHVoKlVnMsSKQFziu1J3AdTflPsz4Xoheu2tgpDTFSZMO6Zp1XzXZlqLWiC5vKlOQD8LRhsnrnqeQ7qIsbEuraWrROHHa53QaUpCxxKJ2hK29s+0Vi9te+izFGV3etVbL9DrN+nAzMgjOkPIotTT9Zk9jkYByYY3bzvyGDkwuDtkxQuuPag8eKz6MT5kt9kaitPtbqY/IaMTY9UN1AXF/vwpC1aNY1jy/1RJnEEiy0MRfI3Jt9Rag28aSCUsTRg6t+BRa8+L+nHm6Ago5gVgm73VR7YM1ukokNUPFB7UNtcH97kKL9RBuH89sUmeMGeAQ1ocrCNXCmC/W1jjQ5qYVChQo+2tTfWApsepd01SoBzNnl9LeSXYKF7ZYGKOafQs8VX3TSBMQUk/TyNoqDpwXGmOaiOhZyu+v2ZXbIEkleQb4HbnFVAUT133TzHSypAM2JhYrUyb5EapcB6Ix5BvxSk/kfmTko/pqFXQekeg2Q1xRzzVr8cYKMonG9psgumR5DJhCF+iU1oHD8N1tqNPtMwz/6WRrJhKe1nsV78t6DTuLPDGhLZORUDK+eVbj/Ewhd7DmSzrc03+BQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(921020)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(5023799004)(56012099006)(261009223327099003)(261009220027099003)(261009223027099003)(261009221227099003)(261009221727099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1jTOhVDcRueGIMw5taGDpZEByCjQ/ZqsfV4FmOtSOaUxyNL1uVtsJiL1XYqp?=
 =?us-ascii?Q?qdWXpqHUFy3TXfSwitRgAFGGcELSYojcg8Rg6QchxAHqq4T/RblxU2gtf+Ns?=
 =?us-ascii?Q?BXl/CIki7DS1igdGrva0ioJCIFA3+7a0/jF6C/AP0Y40XjlBp4xs4Bq9zs0t?=
 =?us-ascii?Q?cdUnsE9mxw+00CSHV+e2scj8HP0M97YXeF9UwN7pB1EyqR/wmzp2XsFcS/0R?=
 =?us-ascii?Q?ahHYDC4S/YXyDmh1vFGNGaBeEZ7On/vCtpEGn0A0K2e6Pb0WMPlXGz11+hxA?=
 =?us-ascii?Q?bQf0OOWZS5sg1gXeRYD5yLIsLTSJzXJHbljIDHKSCJS832rD7sdRL1ic1S1q?=
 =?us-ascii?Q?wplRsA7XyaCLgpOJ+2qNqirQtJ6S8LUpVDIW9gKh3PQxR690kyiRmHXkouHx?=
 =?us-ascii?Q?G4mNST+fzOtsB5I4dM6r6DqE1m0eqBvONurVY/4VmQzKTU6J5/kJeNb29BKD?=
 =?us-ascii?Q?2K1li4fFeLSpOkAbvGt/KGA6H4u6ptukK8++LMKV+PlJd3kOjq2kggIiNS5n?=
 =?us-ascii?Q?RsrHPgRN42ltMoicXeiYepFvsr54ULbC2KugnM5wgKPqscubuJq9SmfSjGK/?=
 =?us-ascii?Q?wnFx3mMwEX08gOVmUQpCC8jnKAF3mqVSZekhIjdyfQqEqX5PzDvmqcxhVqDU?=
 =?us-ascii?Q?/q9OG8eICA6mre3f+hXlaM+nfRVTjh5rIE51Scf3VqgC+YyNvJe/FXSO+aCv?=
 =?us-ascii?Q?vuLVdmW7fIsskge34zvIyx8wrcebvnUHCc++aRelqGSUBpg9VMe/lsVW2QU1?=
 =?us-ascii?Q?dNUbdrRz9UatTaA/IXqjMH8xEIQL4Td3g8erGqdfCSad1+UeEvsPjQ4PVB3L?=
 =?us-ascii?Q?TsBMjynC/TLrL2WdMvRdtZDhKh+KupbZihCfjSOvD994EdK77oHg1SB4wgQT?=
 =?us-ascii?Q?M0HyHl1XJfNFPMk1JEn2TVfPc3p7Fq0Z0d/RmOBnDxmubI5BkDWcUt3W4LtJ?=
 =?us-ascii?Q?JYoVFDDfxm9+e81u6J2nqTeQPcQoPrpGnwHBMKbIKIQelolB5zTAvQ6gzMRB?=
 =?us-ascii?Q?D5pPNviACAdUaTNuCWicF1/JnojIPsKohRyzNS5+5T3ZrFuNyURbnQa7zqq7?=
 =?us-ascii?Q?YDNb1IooaDEx8FC5NV7nR0uZuQH4UMni6UO/A3BbF88KtEI0saN37p+1JuuC?=
 =?us-ascii?Q?OSSoClSR6K+w/CUpa8u65xYnThsRAYpz4lNBmtJikAFIeQXICXGnDb2bGi4M?=
 =?us-ascii?Q?aHeVQVp6OPG3i7xbtcwWlO0Pozqoe2N9g/IwJlzBZz8xuNZBn/nHt7XiUX8X?=
 =?us-ascii?Q?WBTKqO9y2MYoig1S82YscjvPlP1LE3JcjC0TFsiRpi8mzJyzdn/7p7g3aFXg?=
 =?us-ascii?Q?sXmmmvpLzqb2w8b52dLRC8JumjSn3iiUIAS+PoPZ/ZtSqGsJRwXAxjuMYN+u?=
 =?us-ascii?Q?rXinuM044UCE2FfGZ+zWasSklLkB8TT1/1XV2I9Q/K0T0TDCiz1+sy2RT2KE?=
 =?us-ascii?Q?MfV/zY/+xxYA0XGDIQbqRozW9DqTHMMiul3AzU9wHg35zeKXPJLfls9/TYOp?=
 =?us-ascii?Q?c9fpprNkUzoxM/MEfJ/GyhdGP+PPrrJUrUIByUFYkd38vog5AjqW5F037bZ5?=
 =?us-ascii?Q?FC3J/3KrdLWoSLtNIxc03Axzu8Vp1j6u3dOd9TNZF8JtEw+u5NXM2IfXG182?=
 =?us-ascii?Q?RIFwvov1w2iIbSHe6nTc7F+sf4QxtD4uNKR+t3oaV6WBAIbNbG3sc/FZCek/?=
 =?us-ascii?Q?2DWzSSuxKyLDQXE1BDtmZ+Dh/ANkXxQ7+d/RqnUV6DIBio53V1bnsC1lLDth?=
 =?us-ascii?Q?LHu08IuRoQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d99be8-fa3d-4f5a-589b-08df35ccfbd2
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:42.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEH5jjT42j8eXsB5a3Fc/07FxhkACoRYGOmFjFha+Do0Ipj7qmbuVhUcT2g3DkmZa0yuBndeWEnKaC+I4KA6Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB503760

Cache HDM state in pci_dev->hdm after BAR resource setup and before driver
binding, so reset can restore it without a bound CXL driver.

Limit caching to devices that advertise CXL.cache, CXL.mem, CXL Reset,
and Reset Memory Clear. Save their HDM register location, decoder
settings, and Device DVSEC state.
Validate capability reads and decoder counts, and restore PCI_COMMAND
after temporary MMIO access, reporting restoration failures. Protect cache
publication and updates with the DPA lock.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM

---
Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=b12baa1105f33cc1a10f9c9c0c6376194397d9f3
---
 MAINTAINERS                   |   1 +
 drivers/cxl/core/hdm_regs.c   |  96 +++++++++++++++
 drivers/cxl/core/hdm_state.c  |  64 +++++++++-
 drivers/cxl/core/pci.c        |  22 ++--
 drivers/pci/Makefile          |   1 +
 drivers/pci/bus.c             |   1 +
 drivers/pci/cxl.c             | 221 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |   8 ++
 drivers/pci/probe.c           |   1 +
 include/cxl/hdm.h             |  12 ++
 include/uapi/linux/pci_regs.h |   2 +
 11 files changed, 418 insertions(+), 11 deletions(-)
 create mode 100644 drivers/pci/cxl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c2414447892c..b874340b0265 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6572,6 +6572,7 @@ S:	Maintained
 F:	Documentation/driver-api/cxl
 F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
 F:	drivers/cxl/
+F:	drivers/pci/cxl.c
 F:	include/cxl/
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
index 684a17e9a601..9409beb26478 100644
--- a/drivers/cxl/core/hdm_regs.c
+++ b/drivers/cxl/core/hdm_regs.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
 #include <linux/delay.h>
 #include <linux/bug.h>
+#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
@@ -190,3 +191,98 @@ int cxl_hdm_read_decoder(struct cxl_decoder_config *config, void __iomem *hdm,
 	return cxl_hdm_unpack_decoder(config, id, ctrl, base, size);
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_read_decoder, "cxl_core");
+
+/**
+ * cxl_hdm_decoder_count_mapped() - read the decoder count of a mapped block
+ * @dev: device for error reporting
+ * @hdm: mapped HDM decoder capability
+ * @size: size of the mapping
+ *
+ * Return: the decoder count, or a negative errno if the count is reserved or
+ * the mapping cannot hold every decoder.
+ */
+int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
+				 resource_size_t size)
+{
+	int count;
+
+	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
+	if (count < 0)
+		return count;
+
+	/* The last decoder's target-list high register must fit in the mapping. */
+	if (CXL_HDM_DECODER0_TL_HIGH(count - 1) + sizeof(u32) > size) {
+		dev_err(dev, "CXL HDM decoder count exceeds mapped register block\n");
+		return -ENXIO;
+	}
+
+	return count;
+}
+
+/* Read one endpoint decoder; a disabled decoder keeps only its id. */
+static int cxl_hdm_read_decoder_settings(struct device *dev,
+					 struct cxl_endpoint_decoder_settings *settings,
+					 void __iomem *hdm, int id)
+{
+	u64 lo, hi;
+	u32 ctrl;
+	int rc;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	rc = cxl_hdm_read_decoder(&settings->config, hdm, id, ctrl);
+	if (rc) {
+		dev_err(dev,
+			"CXL HDM decoder %d has invalid configuration: %d\n",
+			id, rc);
+		return rc;
+	}
+
+	if (!(settings->config.flags & CXL_DECODER_F_ENABLE))
+		*settings = (struct cxl_endpoint_decoder_settings) {
+			.config.id = id,
+		};
+	else {
+		lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
+		hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
+		settings->skip = (hi << 32) | lo;
+	}
+
+	return 0;
+}
+
+/**
+ * cxl_hdm_read_state() - read endpoint HDM decoder state
+ * @dev: device for error messages
+ * @hdm: mapped HDM decoder capability
+ * @info: state to fill; @info->decoder_count must be set
+ *
+ * Return: 0 on success, or a negative errno if a decoder holds an invalid
+ * configuration or the decoder count changed while reading.
+ */
+int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
+		       struct cxl_hdm_info *info)
+{
+	int count;
+	int rc;
+
+	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	for (int i = 0; i < info->decoder_count; i++) {
+		rc = cxl_hdm_read_decoder_settings(dev, &info->settings[i],
+						    hdm, i);
+		if (rc)
+			return rc;
+	}
+
+	/*
+	 * A changed decoder count means the snapshot no longer describes the
+	 * complete hardware state. Reject it rather than publish a partial cache.
+	 */
+	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
+	if (count != info->decoder_count) {
+		dev_err(dev, "CXL HDM decoder count changed from %d to %d\n",
+			info->decoder_count, count);
+		return -ENXIO;
+	}
+
+	return 0;
+}
diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
index d4c2be1ef833..1140006de50d 100644
--- a/drivers/cxl/core/hdm_state.c
+++ b/drivers/cxl/core/hdm_state.c
@@ -1,21 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+#include <linux/cleanup.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/pci.h>
 #include <linux/rwsem.h>
+#include <linux/slab.h>
 
 #include <cxl/hdm.h>
-
 #include "cxl.h"
 #include "core.h"
 
+/*
+ * CXL state that must stay available while no CXL driver is bound: the CXL
+ * locks and the per-device HDM cache filled during PCI enumeration.
+ */
 struct cxl_rwsem cxl_rwsem = {
 	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
 	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
 };
 EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
 
+/* A published cache is usable only if its HDM register block was mapped. */
+bool cxl_hdm_cache_present(struct cxl_hdm_info *const *slot)
+{
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+
+	return *slot && (*slot)->hdm_size;
+}
+
+void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl)
+{
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	if (!pdev->hdm)
+		return;
+
+	pdev->hdm->dvsec_ctrl = ctrl;
+	pdev->hdm->dvsec_ctrl_valid = true;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_set_dvsec_ctrl, "cxl_core");
+
 void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
 				   struct cxl_endpoint_decoder *cxled)
 {
@@ -70,3 +94,41 @@ int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count)
 	return 0;
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_check_decoder_count, "cxl_core");
+
+/**
+ * cxl_hdm_cache_publish() - publish HDM state read during enumeration
+ * @slot: cache pointer owned by the device, for example &pci_dev->hdm
+ * @info: state to publish
+ *
+ * Ownership of @info passes to @slot, or @info is freed if another caller
+ * published first.
+ */
+void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
+			   struct cxl_hdm_info *info)
+{
+	struct cxl_hdm_info *new __free(kfree) = info;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	/* Another initializer may have published while we read MMIO. */
+	if (!*slot)
+		*slot = no_free_ptr(new);
+}
+
+/**
+ * cxl_hdm_cache_release() - unpublish and free cached HDM state
+ * @slot: cache pointer owned by the device
+ *
+ * Take the DPA write lock to exclude readers while clearing @slot, then
+ * free the unpublished cache after releasing the lock.
+ */
+void cxl_hdm_cache_release(struct cxl_hdm_info **slot)
+{
+	struct cxl_hdm_info *info;
+
+	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
+		info = *slot;
+		/* Unpublish before freeing so readers cannot see stale state. */
+		*slot = NULL;
+	}
+	kfree(info);
+}
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e2034a2179b4..44fa9d5d1a05 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -209,22 +209,24 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int d = cxlds->cxl_dvsec;
 	u16 ctrl;
-	int rc;
+	int rc, ret = 1;
 
 	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
 	if (rc)
 		return pcibios_err_to_errno(rc);
 
-	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
-		return 1;
-	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
-	ctrl |= val;
+	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) != val) {
+		ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
+		ctrl |= val;
 
-	rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
-	if (rc)
-		return pcibios_err_to_errno(rc);
+		rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		ret = 0;
+	}
 
-	return 0;
+	cxl_hdm_cache_set_dvsec_ctrl(pdev, ctrl);
+	return ret;
 }
 
 static void clear_mem_enable(void *cxlds)
@@ -314,7 +316,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 	 * capable, there is no point in continuing to enable CXL.mem.
 	 */
 	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);
-	if (!hdm_count || hdm_count > 2)
+	if (!cxl_dvsec_hdm_count_valid(hdm_count))
 		return -EINVAL;
 
 	/*
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..7a5d9f7297e9 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
+obj-$(CONFIG_CXL_RESET)		+= cxl.o
 obj-$(CONFIG_PCI_IDE)		+= ide.o
 obj-$(CONFIG_PCI_TSM)		+= tsm.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 655ed53436d3..aad567fb7c56 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -359,6 +359,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	/* Save config space for error recoverability */
 	pci_save_state(dev);
+	pci_cxl_hdm_cache_init(dev);
 
 	/*
 	 * Enable runtime PM, which potentially allows the device to
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
new file mode 100644
index 000000000000..b992f71d964a
--- /dev/null
+++ b/drivers/pci/cxl.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+/*
+ * CXL reset support in the PCI core. Cache the HDM decoder state of a CXL
+ * memory device at enumeration, so it can be restored after a reset without
+ * a CXL driver. HDM register formats and programming live in drivers/cxl.
+ */
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include <cxl/hdm.h>
+#include <cxl/pci.h>
+
+#include "pci.h"
+
+/* Find the CXL Device DVSEC and read its capability register. */
+static int cxl_pci_device_dvsec(struct pci_dev *pdev, u16 *dvsec, u16 *cap)
+{
+	int rc;
+
+	*dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					   PCI_DVSEC_CXL_DEVICE);
+	if (!*dvsec)
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, *dvsec + PCI_DVSEC_CXL_CAP, cap);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(*cap))
+		return -ENODEV;
+
+	return 0;
+}
+
+static bool cxl_pci_bar_assigned(struct pci_dev *pdev, int bar)
+{
+	struct resource *res = &pdev->resource[bar];
+
+	return pci_resource_len(pdev, bar) &&
+	       !(res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) &&
+	       resource_type(res) == IORESOURCE_MEM && res->start && res->end;
+}
+
+static void __iomem *cxl_pci_hdm_map_regs(struct pci_dev *pdev,
+					  struct cxl_register_map *map,
+					  resource_size_t *hdm_offset,
+					  int *decoder_count)
+{
+	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
+	void __iomem *hdm;
+	int rc;
+
+	/* cxl_setup_regs() populates hdm_map, including its valid bit. */
+	rc = cxl_setup_regs(map);
+	if (rc)
+		return ERR_PTR(rc);
+	if (!hdm_map->valid)
+		return ERR_PTR(-ENODEV);
+	if (hdm_map->offset > map->max_size ||
+	    hdm_map->size > map->max_size - hdm_map->offset)
+		return ERR_PTR(-ENXIO);
+	if (check_add_overflow(map->bar_offset,
+			       (resource_size_t)hdm_map->offset, hdm_offset))
+		return ERR_PTR(-EOVERFLOW);
+
+	hdm = ioremap(map->resource + hdm_map->offset, hdm_map->size);
+	if (!hdm)
+		return ERR_PTR(-ENOMEM);
+
+	*decoder_count = cxl_hdm_decoder_count_mapped(&pdev->dev, hdm,
+					      hdm_map->size);
+	if (*decoder_count < 0) {
+		iounmap(hdm);
+		return ERR_PTR(*decoder_count);
+	}
+
+	return hdm;
+}
+
+static struct cxl_hdm_info *__cxl_pci_hdm_read_info(struct pci_dev *pdev,
+						    struct cxl_register_map *map,
+						    int dvsec)
+{
+	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
+	struct cxl_hdm_info *info;
+	resource_size_t hdm_offset;
+	void __iomem *hdm;
+	int decoder_count;
+	u16 dvsec_ctrl;
+	int rc;
+
+	hdm = cxl_pci_hdm_map_regs(pdev, map, &hdm_offset, &decoder_count);
+	if (IS_ERR(hdm))
+		return ERR_CAST(hdm);
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
+				  &dvsec_ctrl);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		goto out_unmap;
+	}
+
+	info = kzalloc_flex(*info, settings, decoder_count, GFP_KERNEL);
+	if (!info) {
+		rc = -ENOMEM;
+		goto out_unmap;
+	}
+
+	info->decoder_count = decoder_count;
+	info->hdm_bar = map->bar;
+	info->hdm_offset = hdm_offset;
+	info->hdm_size = hdm_map->size;
+	info->dvsec = dvsec;
+	info->dvsec_ctrl = dvsec_ctrl;
+	info->dvsec_ctrl_valid = true;
+
+	rc = cxl_hdm_read_state(&pdev->dev, hdm, info);
+	if (rc)
+		goto out_free;
+
+	iounmap(hdm);
+	return info;
+
+out_free:
+	kfree(info);
+out_unmap:
+	iounmap(hdm);
+	return ERR_PTR(rc);
+}
+
+static struct cxl_hdm_info *cxl_pci_hdm_read_info(struct pci_dev *pdev,
+						  struct cxl_register_map *map,
+						  int dvsec)
+{
+	struct cxl_hdm_info *info;
+	u16 command;
+	int rc;
+
+	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
+	if (rc)
+		return ERR_PTR(pcibios_err_to_errno(rc));
+
+	if (!(command & PCI_COMMAND_MEMORY)) {
+		rc = pci_write_config_word(pdev, PCI_COMMAND,
+					   command | PCI_COMMAND_MEMORY);
+		if (rc)
+			return ERR_PTR(pcibios_err_to_errno(rc));
+	}
+
+	info = __cxl_pci_hdm_read_info(pdev, map, dvsec);
+	if (!(command & PCI_COMMAND_MEMORY)) {
+		rc = pci_write_config_word(pdev, PCI_COMMAND, command);
+		if (rc)
+			pci_err(pdev,
+				"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
+				pcibios_err_to_errno(rc));
+	}
+	return info;
+}
+
+static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
+{
+	struct cxl_register_map map = { };
+	struct cxl_hdm_info *read_info;
+	u16 dvsec, cap;
+	int rc;
+
+	guard(pci_dev)(pdev);
+
+	/* Avoid duplicate MMIO reads when the cache is already present. */
+	if (cxl_hdm_cache_present(&pdev->hdm))
+		return 0;
+
+	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
+	if (rc == -ENOTTY)
+		return 0;
+	if (rc)
+		return rc;
+	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE) ||
+	    !cxl_dvsec_hdm_count_valid(FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap)))
+		return 0;
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		return rc;
+	if (map.bar < 0 || map.bar >= PCI_STD_NUM_BARS ||
+	    !cxl_pci_bar_assigned(pdev, map.bar))
+		return -ENODEV;
+
+	read_info = cxl_pci_hdm_read_info(pdev, &map, dvsec);
+	if (IS_ERR(read_info))
+		return PTR_ERR(read_info);
+
+	/* Another initializer may have published while we read MMIO. */
+	cxl_hdm_cache_publish(&pdev->hdm, read_info);
+
+	return 0;
+}
+
+void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
+{
+	int rc;
+
+	rc = __pci_cxl_hdm_cache_init(pdev);
+	if (rc)
+		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
+}
+
+void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
+{
+	cxl_hdm_cache_release(&pdev->hdm);
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..9e218f236e66 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -730,6 +730,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_CXL_RESET
+void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
+void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
+#else
+static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
+static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
+#endif
+
 #ifdef CONFIG_PCI_NPEM
 void pci_npem_create(struct pci_dev *dev);
 void pci_npem_remove(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..cb52357344ed 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2484,6 +2484,7 @@ static void pci_release_dev(struct device *dev)
 	struct pci_dev *pci_dev;
 
 	pci_dev = to_pci_dev(dev);
+	pci_cxl_hdm_cache_release(pci_dev);
 	pci_release_capabilities(pci_dev);
 	pci_release_of_node(pci_dev);
 	pcibios_release_device(pci_dev);
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index 06e9aa4479c2..cfb55b10f8ac 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -26,6 +26,7 @@ struct cxl_endpoint_decoder_settings {
  * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
  * @hdm_size: size of the HDM decoder register block
  * @global_ctrl: HDM decoder global control register
+ * @dvsec: config space offset of the CXL Device DVSEC
  * @dvsec_ctrl: CXL DVSEC control register
  * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
  * @settings: per-endpoint-decoder programming state
@@ -39,13 +40,24 @@ struct cxl_hdm_info {
 	resource_size_t hdm_offset;
 	resource_size_t hdm_size;
 	u32 global_ctrl;
+	u16 dvsec;
 	u16 dvsec_ctrl;
 	bool dvsec_ctrl_valid;
 	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
 };
+struct device;
 
+int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
+				 resource_size_t size);
+int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
+		       struct cxl_hdm_info *info);
+bool cxl_hdm_cache_present(struct cxl_hdm_info *const *slot);
+void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl);
 void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
 				   struct cxl_endpoint_decoder *cxled);
 int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count);
+void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
+			   struct cxl_hdm_info *info);
+void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
 
 #endif /* __CXL_HDM_H__ */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..ca3e77b72d87 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1352,6 +1352,8 @@
 #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
 #define  PCI_DVSEC_CXL_CTRL				0xC
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
 #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
-- 
2.43.0

