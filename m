Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792657357;
	b=hiTepJGxBNbJXj0rPc8YLppTLC6BQ8/gjR97EviDtGQ509EG0uFnQEJqnfUcLk2JQQ5Z
	 wsO7IDi6xO3ZukgPl3sQvKb4CP83QMPYIGlXlt9CZpgCxm8CijHjnrLMJIBpkZH+rU6fK
	 VRsLxo5l+Fe1beCBURN/V+nZDFGFuiSnCHr3/YLDkRmY05dZc+1O/2t0WGMwpbYHKIvYp
	 CO1u6Fzp5QWc/UmYNtO0mLdeh13v531MmOMB/TWQCwi0mYdXX724KBmic1DAumuMNjZlk
	 a7lj0WTh61vSkrdp4eOTgQLrAAgKh2J9KXoXsMFOds/B0TXnIHVrVyUu5veUNUPezAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657357;
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
	bh=QDF+vH7C6dVPva/+z08gSMrAX0jRK7SiWjWXZzTXCPg=;
	b=HzRLHo8FAl0QgBYHcVgKKRODWO4fuqxQIguiRGN6RneGlKGNn3miSoesMDETUw795FUK
	 D/ZAbGU00nuGeBDxUZfSM5uP09Vkp9pKvzXiRC7/9Dbgzw2Mmb2vHbjNvXlsvropjGRdI
	 XDr0GJHD1OXO2hBGsFFawjDkp37Zblf+J4n37Ic9Ya0Ybmaha6Ay43/IXmLT4SGFinLcK
	 Vo6qAzJO9JUFDpyZNjmdqz+IW00ceBsMpSJ45VGWu8MjqCumHN7W1cxalcxESe3M3P9u1
	 kO+7VFRgeUMsPY8G3izyIe3xFZU1l63h6lFmCdMxfJPLUy7NZ3PBGhsLko6JyNwJluw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=WfXbHCk6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.110
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021110.outbound.protection.outlook.com [40.107.74.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AF5606A329;
	Thu, 22 Oct 2026 08:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52AF5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=WfXbHCk6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJem3MK2t1vmyjfFqBGiyqn6mAs0PVu27g7jSfcnvyMpeCjQm5Acj0Dy5au/xXaTaUwSv9WmZBPnOG1y75pEiMG6q4uSJUxC0FxFXNuifsgNI5P8v8LmBpy4E3NgdFDmOppGl6kFXbchXduEXv8aPoUOgJof+bjkmOlL7OvCmzet5pZTF+uZm6Go7Uth78aD6qt5FVfQ1Cru2KU6ThcXy9Ue7FsKEviY2l6s1rlUjwtGpT09nWQQXq57AbD4Hv80t6N6b4EXx920gytQbxEdTWDTXDNr+K7LMi490NvwTGwSp/v7V4l33fmqwjVisrcpjzlGhFhrs6juvf3HOUgicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDF+vH7C6dVPva/+z08gSMrAX0jRK7SiWjWXZzTXCPg=;
 b=hEE5SHVVttdzvsaAHRgZEUvGRpp+mig+mRsFUl18jz33AKun/0LwBu0f0IXO0lDRbBoOGUhtiCr6eg48dG0EQBHgtQImtPfQ1QWY8hUkwJno2ZCxqlHflJPzsGWswnl22ajTMiaR96capcCkuk/b4FxtG+6zH/pgE4xvvSyDN9NTKmcjQUGBw75tL8Z/ItC3QZVXpgqYeJTvO2LHw8hK8C4crBOVBPQ1WREHl6p3el2iqyvhzY3horsAa/ahL1TnkKCoiUNQezfqniGQxE26H4gGxnCkIU1rCOB3op9zCSg6kTSmjmpb8JFQYDQBEwOrlfFEzAdLUpgO2jrO27+k9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDF+vH7C6dVPva/+z08gSMrAX0jRK7SiWjWXZzTXCPg=;
 b=WfXbHCk6D047xOSOuxCKiLHBbp/CDzhU4UmSQJF5yLkM5orIkX+OYJ0lmGdQ0DIFpTSLHOaGppJVVelAeaUw1fkkmKtsYbPg3CDGOaiscvFX62804MdfkPGl2Z48xamB0zGOO2+Gr/MdJy4dKB4VCwu37S+jJ9LesVRDtDVjT2Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5275.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:353::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:22:34 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 08:22:34 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v8 02/10] PCI: dwc: Expose endpoint DMA resources
Date: Thu, 22 Oct 2026 17:22:22 +0900
Message-ID: <20261022082230.3164834-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022082230.3164834-1-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 113f87cb-4d3a-4108-4415-08df3015a002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|23010399003|1800799024|6133799003|18002099003|10067099003|261021121427099003|22082099003|261021123027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	FLbiyDDTAGjPZo5sSfuK5fM9MhqwicvXGP4a7B+zTz7Yy2ItnoXwjgvfvoGZc7LyUg0F+CkZicU0NrVwaWe+EQw5U3Olxvw1l3r+ZCqfAMUI8u2lt/a96NCKU8cQFPYZCUA9qAjA9fC1dEDvb6Dm6CvY8Dgqjx6yQ63FtRRIGzHEbtxb9KKDWjhGC1akY05eYGEcUp3fu4k8zhZGoji4naM80MtVXGJlyF1pO6vQkGEWOg7x6hZoTKJPKjl0SjC5vnix2zHaHPJxqSpfPop2VXgJwLiQAQ64n08ge8SymJzlJWi1kPR/Tcdsc7Nydgl5yLb8J3roZJr//pgjW+TwTun5dQZjcFlwXJy2gOBjbBzok5fV1nHXala00cV5e8laGO5Jarp/uEmYVAfyU8A5pAkvHa268PlpbEuC68z66JtxSVQAR34gR0bh+Dz8EVm1TRBo5B1YnSuf+xkYftdKZ5QC9jD1sJkli7A9RZJpv9VOZ7nEkj797UFQ4Gr9nLoclHjM3gcTZMgll1yhjoQ19+aJprL6ZgXqxKCL0i6pnNfhTNIeZPy4UqA7ezSo3sd9Gp90HA2chBYwgb58ePkEg6vJD9kyVMF/Gu9qJTNF0MEUOKW/+O+2qk/5sh7jpOY2HEIcTHkMSJduQPLPjCjsVldVbYsYUKKgXu9nt3ZaCOg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(22082099003)(261021123027099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aI/zf/BJ0IF1rxUikcRChPk8VwC4EB4Io456ajTjyU48IT3XJfPgeOfMWou+?=
 =?us-ascii?Q?tSu90wF6hcixN0zt8NbUKUxtaxs5AAr2flUn+Okqk7hORYBzLd8NUKEYDEbA?=
 =?us-ascii?Q?n9qlD+gYL19ci5ATfZbuzHG4q8B/sg4EGNy7ZpzMRQmRZGvE/aUHMkhbV+a1?=
 =?us-ascii?Q?7v/NR+O/w8m9fD6N3+o4U3OgfUKyQR+vUE98jLHra6EBN3dPThxifFJbRep7?=
 =?us-ascii?Q?b6lCAwoEmnRLoPDab9JqH+zw9IR3KCYVDsF4sFrOCTBcy0pfvNgPz+rA6q0w?=
 =?us-ascii?Q?GwJz2KfpJBOj8lGE7xiMjvZv8iDL0Sm4IoanzDeztcSTC0wwnD0z32KMSAZV?=
 =?us-ascii?Q?OOd8rjJb+HBuuVmp1qcdJmmaqnU24DHZW/TZ2PAIxmstXR9v1Z+/mTJlFbAq?=
 =?us-ascii?Q?rcbh4iXlZ3mqTB6ZQkYfBPoneXjpjy5Ko1WPFKGTQIXwNxC/UHj0M6Hfn8Ox?=
 =?us-ascii?Q?ToEw2v8JciK+H15HksBWdtqBuy7xjbwWFQdQYVhm9ln9pgnl/tIgvtJLc2qE?=
 =?us-ascii?Q?lOXBvGncJs283zTYJ0BBWLfu5I2wfrTDq4AwFXs3qdsr75MtCkEveXsewMBP?=
 =?us-ascii?Q?Xw/QwF7/KMtjCDxt+gBrXoHsFxhGVqfNPjAEGSSAx2r92cB+fE91SzQ7prFr?=
 =?us-ascii?Q?lLIkgY249afinrKziVKoFIeVJdQ5WHAkA/EoVR52TxUDnZpCOeHrcjCKtJ8f?=
 =?us-ascii?Q?zfpx10RIsnhDxaDpEoWXIxNN70Y/yYr4mhz4gCiE8yKpb2d3tyOTLdpTLWJ0?=
 =?us-ascii?Q?BrWhVbM6xjemtxlY7vUrPlNYupBkjEzF+5VoRtE3achSpczRqwRd3DuS6ALC?=
 =?us-ascii?Q?78KRkWIs5Q5kbDRmnAP1818axz+7//RCKEtTsI0rrKqDW/wFcmZnc+2c0KUd?=
 =?us-ascii?Q?ifoxfY3dJq4YRFMi/KJxKohyT9Yyf6chlVZpjUVIVbea/q0Je6AmH0mJDjPT?=
 =?us-ascii?Q?rvmLObJF+wUXw9YVfsnEkigDvO5QqRehyTL8Tqkf7RtmG+RqMVO/oZLC3Yx+?=
 =?us-ascii?Q?F5uMPFVDe9yntg/Fe5KZgnT/B3oj1YOmHhW3Uy1TsPPGJ7Hn3l8O4nfCZXwi?=
 =?us-ascii?Q?KrnNlOoVv6Y80zPCTJz8yqQZ/uxs+QapRLNGLFeedALDFGPg14DQRdg7SbV4?=
 =?us-ascii?Q?hMrnWTeZxfUkNnUwpReXsaB2NJprYbETxnlSxqqgbqKCNqAC1YVR2dDincV3?=
 =?us-ascii?Q?nPWY2kV9VqBYhHod7ZWTwj6uLecIV7cAXtZ8L7QGkatLNDC9fNRcgIu0GH9v?=
 =?us-ascii?Q?5u2O4CNuo0RycNDWVPmRVG+onEgXb+/N/Ws88JZfVGKuDGTEEwvGDeXGVG0W?=
 =?us-ascii?Q?+1u2Tk7uFBqrgEI5MqKcE4Oc36HRFJHjcRj7ytkKoVZev4Fb/FzNuariHVRG?=
 =?us-ascii?Q?FFuYt3IWEAtvLsNuF4i7T293KXAVc6DzykV9pyU20yZEBwzh58VmMa6zgH9l?=
 =?us-ascii?Q?WfFJ0fgh37NDLYzmkAmzi6KNYRj+8Vb5Qum2mgtnOz8V3Hd+DdT0af46SehW?=
 =?us-ascii?Q?/J3Ljo+yaPsuo2ARy8bQWy5Ej09XZWoFdd/R2dQEj5zaQu6CKB4Ehtpy8r/n?=
 =?us-ascii?Q?qVwbmQt4og18N6c/6dcKTaLZE1LHlAvnytmmwPwxRIKIHd9guJcJtYpxjmiL?=
 =?us-ascii?Q?RYv7fQlYnQ0eHbzkJNbRPHQ4Nju9UzNp2N/9niTwsg2qhgqbHKSebw+suj7E?=
 =?us-ascii?Q?Eyexwwth/A5yJP4UV3Jb37W6JM9iSx5GW6yYwY7ty93Yri1Y+62qM61Xm3SS?=
 =?us-ascii?Q?SbQROUk6v+/wH9d0ZjWmiDsWtlmKJ+WN3Q61L/CMICxS5y1sK/Da?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 113f87cb-4d3a-4108-4415-08df3015a002
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:22:34.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evjdo3YApu5TsB8RWLJmJQW4ztBucgwDxWnoWHGUCuCRNjsNoZGDKZq7BU1vUd3KDn/Fc0d9si1czVODoUrN+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5275

Expose the endpoint-integrated eDMA register window and linked-list memory
through the EPC auxiliary resource API. Endpoint functions can then choose
which channels to export and map the required windows.

Associate each linked-list region with the direction-flattened static
channel ID used by the local dw-edma device. Report these resources only
after that device is registered and only for channels with linked-list
memory.

When the register window is already part of a reserved BAR, report its BAR
and offset. Otherwise report its CPU physical address.

While at it, harden the existing doorbell resource query. Report it
only after the local dw-edma device is registered, and reject VF
queries because DWC cannot assign DMA/HDMA registers to VFs.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - No changes.

 .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++++++++++++++++--
 1 file changed, 99 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 630ba172280c..7166ec7f212b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -858,6 +858,15 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
 	return NULL;
 }
 
+static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
+{
+	/*
+	 * The DWC endpoint databook says it is not possible to assign the
+	 * DMA/HDMA registers to any Virtual Function.
+	 */
+	return vfunc_no ? -EOPNOTSUPP : 0;
+}
+
 static int
 dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 				   u8 vfunc_no)
@@ -865,14 +874,30 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_edma_chip *edma = &pci->edma;
+	u16 ll_wr_cnt, ll_rd_cnt;
+	int count = 0;
+	int ret;
 
 	if (!pci->edma_reg_size)
 		return 0;
 
-	if (edma->db_offset == ~0)
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
+	if (ret)
+		return ret;
+
+	if (!edma->dw)
 		return 0;
 
-	return 1;
+	ll_wr_cnt = edma->ll_wr_cnt;
+	ll_rd_cnt = edma->ll_rd_cnt;
+
+	if (!edma->cfg_non_ll)
+		count += 1 + ll_wr_cnt + ll_rd_cnt;
+
+	if (edma->db_offset != ~0)
+		count++;
+
+	return count;
 }
 
 static int
@@ -885,14 +910,32 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	const struct pci_epc_bar_rsvd_region *rsvd;
 	struct dw_edma_chip *edma = &pci->edma;
 	enum pci_barno dma_ctrl_bar = NO_BAR;
-	resource_size_t db_offset = edma->db_offset;
+	resource_size_t db_offset;
 	resource_size_t dma_ctrl_bar_offset = 0;
 	resource_size_t dma_reg_size;
-	int count;
+	u16 ll_wr_cnt, ll_rd_cnt;
+	bool has_ll;
+	unsigned int i;
+	int count, ret;
 
-	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
-	if (count < 0)
-		return count;
+	if (!pci->edma_reg_size)
+		return 0;
+
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
+	if (ret)
+		return ret;
+
+	if (!edma->dw)
+		return 0;
+
+	ll_wr_cnt = edma->ll_wr_cnt;
+	ll_rd_cnt = edma->ll_rd_cnt;
+	db_offset = edma->db_offset;
+	has_ll = !edma->cfg_non_ll;
+
+	count = db_offset != ~0;
+	if (has_ll)
+		count += 1 + ll_wr_cnt + ll_rd_cnt;
 
 	if (num_resources < count)
 		return -ENOSPC;
@@ -909,6 +952,54 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (rsvd && rsvd->size < dma_reg_size)
 		dma_reg_size = rsvd->size;
 
+	count = 0;
+	if (has_ll) {
+		resources[count++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
+			.phys_addr = pci->edma_reg_phys,
+			.size = dma_reg_size,
+			.bar = dma_ctrl_bar,
+			.bar_offset = dma_ctrl_bar_offset,
+			.u.dma_ctrl = {
+				.reg_layout = PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
+				.reg_layout_data = edma->mf,
+				.ep_to_rc_ch_cnt = ll_wr_cnt,
+				.rc_to_ep_ch_cnt = ll_rd_cnt,
+			},
+		};
+
+		for (i = 0; i < ll_wr_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_wr[i];
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_DESC_MEM,
+				.size = ll->sz,
+				.bar = NO_BAR,
+				.u.dma_desc = {
+					.dma_addr = ll->paddr,
+					.chan_id = i,
+				},
+			};
+		}
+
+		for (i = 0; i < ll_rd_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_rd[i];
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_DESC_MEM,
+				.size = ll->sz,
+				.bar = NO_BAR,
+				.u.dma_desc = {
+					.dma_addr = ll->paddr,
+					.chan_id = ll_wr_cnt + i,
+				},
+			};
+		}
+	}
+
+	if (db_offset == ~0)
+		return 0;
+
 	/*
 	 * For interrupt-emulation doorbells, report a standalone resource
 	 * instead of bundling it into the DMA controller MMIO resource.
@@ -917,7 +1008,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  sizeof(u32), dma_reg_size))
 		return -EINVAL;
 
-	resources[0] = (struct pci_epc_aux_resource) {
+	resources[count] = (struct pci_epc_aux_resource) {
 		.type = PCI_EPC_AUX_DOORBELL_MMIO,
 		.phys_addr = pci->edma_reg_phys + db_offset,
 		.size = sizeof(u32),
-- 
2.54.0

