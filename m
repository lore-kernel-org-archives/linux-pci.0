Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792556584;
	b=p1Kbc6c34HwQ5Wr3tZYgv5GgSg5eDP9Cnqmel6DCKR1NOYRAER5ws7CzOTUn0OY7aZE3
	 SPdAodDrx/n/Kh0zmQChQD66wVo5/ph3y2C9sld0sFN/C2LNCErIlbdyOJf0odpVQgjGf
	 jR+ltiMeSicZFknvdtl4+BNmzwTF7/GAwMAWFxwnNhg+S7PH6/bwE+s9l4Wo3xhzfQpTE
	 OKWKUQlJ0vp+ud7YQ6kkUVSDAdVykVP7metmoDG1dIRJF8yCG5DJbZ52lQ8SG3mGV8I9e
	 /Rx0kt0BaF1FJ5XFYZI7Niox6M7r5HI80lH1Ii7SDWT/vZRD3YcTJm0G0e1tJjr/8cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556584;
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
	bh=Y5ft15uzhZlyTb92+5QzeqwD+mlfNMtjomw0gZohav0=;
	b=xTteet7esu1GcTSAMDyeln5Yvl4gzSzzMOM87GCcmvuO4c931dqvdTHgr34kG/K9Z+ey
	 gA/nBYLEGWL+OjclSLaD0gBLjIhfBscWjcGon9OEP3h/ZX6rPi89Tml40WTqvdPN55hSS
	 VrrWxpledgCR3Rhs3ioLypDTTk+T5J8MM+c08Az5gLVAqWGD+uU210vzDxnZwyqd8TyPw
	 cUIwNBKOi64FAF6y0amts4IVvvez4j+VR/s2P2xUyH/CTE2hZbO8YuUxp6eKhg/gXeWTP
	 oxEdfTwiXSPAEZWegMbjf1gijmNZ0xNhg4v+6BvNKznPzSIntJ/Jl/Ji6QBGHaTVDJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=TxCNVFQA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.72
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020072.outbound.protection.outlook.com [52.101.228.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D538606A33B;
	Wed, 21 Oct 2026 04:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D538606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=TxCNVFQA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsOUH9IUQko6+flQeug/fYJRxp4zQk774EMGL8WfCRvRSlCaRFAiLBX3/OahXJ33runfH7S3oF0n3wSjlnpTb5qWDGPQK3fYHw+X8SFQBkF/GuKLLh+nSEBiO+8c//0PI2/eGLfsAlQy6MICqr9RQ2fBFAVhodHZ1oncZpSYu5cg8moAvHlcTQJ6XfzzJ8B+2hyPEgxluPPgolt7+oTWxf1fWjL0anP378XqOPmc6bGneTB+Xm65EigocfdiezNWtblfOzWYK1N1VU/QtfmPxfxj9tqtceuPDLEIfYE96JvMYwymLM0kzeDyzAuSFacSPo1b8dMDkRm57+/DEzCfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5ft15uzhZlyTb92+5QzeqwD+mlfNMtjomw0gZohav0=;
 b=e6IssR4Ah9J51womNqS0YUJN4DKNzs/Oj9qxXc0zkuK+iucc7GADVfBwrRxFQzTB9nviIdek0fA4KiCRJusYQciA3Ei9+4w14/+VfS1odCOCXW1zSDjklMR5/O6prm//SCu+nGmSe8TUgfGT4ONEwU8TB8Z3MAK7xAGTZkbjZl3bKA6ww5gn9m3zfIYpC+Wb9EwAuAz6/BYfTZODDW1F0uggQ2XErYUMA7RwmvpvspskU/KVNNRh7JgAHHcdLsuAsRtyYpm6yUBieWbs7rGg5/Dn+FaqDoeZaBXDBEDfNMBkJE0NJlgpcbp2MlpP3xPGTo/jZDrxsVLVDBka3x85rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5ft15uzhZlyTb92+5QzeqwD+mlfNMtjomw0gZohav0=;
 b=TxCNVFQAtCgpqFnZTAYG8VwOtIaaIZCodwU/tG5hch+uG2slOtd+zcG6epqmbTCjFv6wxlVPR5qUnpYNsQe+nEhs173+YDEvHc/cKUoEfwUFnPxAO1ssGJhM8bbezd+/I8WLgwFjqcH97oyc4NxLvecmbU8yoqFXPDxYffQVQ0o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB3180.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 04:22:44 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 04:22:44 +0000
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
Subject: [PATCH v7 09/10] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Date: Wed, 21 Oct 2026 13:22:28 +0900
Message-ID: <20261021042229.2280937-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021042229.2280937-1-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0122.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB3180:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9b684b-5d6b-4f0a-8125-08df2f2af475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	lv952PFX1n11vU+9lUN7dR13ZwwSz99P2vQFjd1sp0F1LrxsRFjQTvCzT5aognAurRgiqKBnL8fCtcVb+984YCsgxbI5K+ONw+pEkGL3VJVA8KQbI4MOEwn0/rjcXSMqUt46P+IXFSc1PXagCDSl+8tkrYNi3tvUUeR3Z7r2vIYqbWBMJ3ydi+ZLmn/ezcoZU3/Xf775Af7C7izOaxJp4Q3q+VoZ97uj8z+A4QbuFxjrHB12bGZu0hSYLtBQwh9SjJyEzQUbUBO5mmpQQeWT87/Wr7ph+34ayNJBAsEPYhYea+Z79LvEe6tNqOaWRAwl+4t20vYvTulTju1Rn5hL8T9xLIdZ3NhqAJn01GN8tqp8O7JWuBdmoGQeYkVpi/5TzB9bdlzfCszWPTV7fo6yuKZwLPsDz3VBbNRn5f6xXg1CE4RHQvWWeDU2ZeT0z3mAfWSmDxdIcE+e0HPibh2IZZlNWS+hchaO5xacxysNF05peibRPMVgqSXn8rJ4D3mJyC+B8asL0vu4QLLau7PC6LWRFPQsIYDjMn22SeobLCX9U6TYd0eBo40G+iuvMnjZrAU2bxpzmAKAZ516iKSSgdspt7yBmAsIRy4DcF7kFRlE2Utn1ZzU+2QT3HMCqUuV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GZTgXo6fvfZmAZjFGdYVuwtIpxqZEI+Xeg0FVlu1g9lkntZ9eArT8FcFeeep?=
 =?us-ascii?Q?ZWdR8+aKsyxiWk7dy33TBrmoeLaLVy8rMVHInINmi2wyLmHJspuE+BLtPyjg?=
 =?us-ascii?Q?9MUTqWDCh1y8NMNFfUMhejd0CZMe4Q27NYclVLteGosyC0IHMFblREoQhMo+?=
 =?us-ascii?Q?jQg+JKok2xc0SosV+Z503OFNXHrOqFvvbxw5yVFX0tZbIBtarWAoxTKQ2fZW?=
 =?us-ascii?Q?CdUYfdQpp5yJDwwQA25cj0fjLH7kAyCQWdYt22ze3qF4kxZgyAosxfLuhKvr?=
 =?us-ascii?Q?Z49r+u/mYkevupx1h54MFHYpHSdXbkUP8nB2NWpDRjl4/9lbi7cKl7w0J4su?=
 =?us-ascii?Q?hR4j6EDguxdNXHryoiS+aeUKMwFugBpSiAQ/FK9G4RKaLimjGOtrwe8l+Fgi?=
 =?us-ascii?Q?j3bxkK6Hd3NJPVzZJHC0LJbylPi9RzJALGfqExatFzqUfZer1JCx6qg7FEYD?=
 =?us-ascii?Q?dRIZzQiofJ1RWxmXVzcWvUp+wkpYTAHLkARQ7iyM4q/BnLp+P268dNpsUD8x?=
 =?us-ascii?Q?msyb/Dzp2Eu4I0IuJ0v2NAq9rqxtP8OdU9PRFeUWAw0vZhBgBaj954IgN/Zp?=
 =?us-ascii?Q?TNhfkvZ7c1KQvpHfXgrAFMG8eUmVKewTDIgwHVrshDrhuLR+VB/sPiwu6Z1e?=
 =?us-ascii?Q?aV0OGUnEbtqzHVLS0UBCcyP6gAOqmN0sqHxWVxsIRuR6sYg0xj536wLzuPIT?=
 =?us-ascii?Q?DCft79mX3M2VmUhjiIFClViKcnJwgNID5wVygFyUEj5Uo9V4ZBnYLVg/zzrg?=
 =?us-ascii?Q?2Eczwbp8rNQ6tlkK74TciRlCJvaFQEi2lzAJ2o6HA0vu5RrnXoyhbnvRYyI1?=
 =?us-ascii?Q?CRsX0tBpWogwHYBg/jZzh3go9O3vTBCYeumLWepGPdQGqqdOSc2ydZCQtG5v?=
 =?us-ascii?Q?JjJA9sNfz4mBj/Si/60DtxAc/alzg1Qdfg65+LaFxCMYDLk4ljt9cpuGQNLy?=
 =?us-ascii?Q?9SMX96Hv0pfzEX0/NKRfQ9Ol1fPZ6tUKvP47Z6wA9EWmP7SbsQRVWGqsvGjP?=
 =?us-ascii?Q?qGb860tL3vb1oDtVVX0BC27aeVFp7uUdl/tMppXhbuBmDteLDinjnZw1wTE3?=
 =?us-ascii?Q?QAhyFF0l8+NgsJ5xt43YXXSo1XW6erGl8/JiHJw8Sy4OoTyX7Nrz6KMezqKK?=
 =?us-ascii?Q?KbzJjcETllQZgE803grhMJm4cFZRKeHHZ6uDAahCWB5gmy6huv8d/jKxUZdQ?=
 =?us-ascii?Q?vpff5KgSM1dwnwUaQIfVGlSYvL0oxPoyJJhtQ23PIOpHEOZJpTQvt+PgU88B?=
 =?us-ascii?Q?Zg96fZec3hjvwYHokNA0JqFONdLSMnM287dV7GIAc20HxsweyIYtDETF2r5N?=
 =?us-ascii?Q?I4JgWWBGQCDEWPI2/p18I4oRH3g5X2Zb7lp/LqVTc3KGSbY5Rj2jNunn6LDz?=
 =?us-ascii?Q?GEVP5ta5aPWne/sUlgnzUbb5yBW2xoyubW6SU+VB1C0+FgzfPUBD2BrUa2rL?=
 =?us-ascii?Q?1bOs/Qlyu75shTzWmyrcz5VG3dk+Ibc+FVTdAzFqJcAGAIjgy/PUutj7zIpg?=
 =?us-ascii?Q?4eP1zGBWUGcR2ILS8ehTEaHdJBzD74CAuCLfiUopzqcdi7U+A9M3pHNQYwnE?=
 =?us-ascii?Q?xP7l39T4N/MV6YMgKNAzc7DpCWPqgYc7Sh+P/TF2vzHlrHDuGlvU/60cRuai?=
 =?us-ascii?Q?+X1C7uV0O9i9GnvHsvXpyW8ZIF1NXnGxuSsPWH5sWQishTJXBmbz6uOr1iDg?=
 =?us-ascii?Q?DDcgKG/zv+ITghDFN8xS15IymDXGHzNVIEkK8YjX/8MrztR34FPqf4PHNGd4?=
 =?us-ascii?Q?t8zBNVVhusa7sJvAY0NuGjIt3PFWaW0diMabi0HH60WUd3Rrpc52?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9b684b-5d6b-4f0a-8125-08df2f2af475
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:22:44.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnAvjbadJJ6egk5nmIuY/mtOjfijljezDQdHj0n7VcnmR05FQqyRJ2XzuqhtXsBTSnkvyMLLw8X9o9q3wvgtcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3180

A vNTB PCI function can now expose endpoint-local DMA channels to its
host. Decode the extension and register the advertised channels before
the NTB device, so clients of that NTB device can use the DMA
functionality in the same PCI function. Endpoints without the extension,
or hosts without support for its DMA type or with no DMA IRQ available,
continue without DMA.

Only DW eDMA is supported for now. Dispatch on the advertised DMA type
and keep type-specific setup in local helpers. Support for another
implementation can add a new case and its own helpers.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v6:
  - Added Frank's Reviewed-by tag. No code changes.
  - Link to v6: https://lore.kernel.org/r/20261020054948.1218370-7-den@valinux.co.jp/

 drivers/ntb/hw/epf/ntb_hw_epf.c | 273 +++++++++++++++++++++++++++++++-
 1 file changed, 267 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index ff92c2a61ce7..e0016128b95c 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -8,6 +8,7 @@
 
 #include <linux/atomic.h>
 #include <linux/delay.h>
+#include <linux/dma/edma.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -18,6 +19,12 @@
 /* Offsets into the control region, see include/linux/pci-epf-ntb.h. */
 #define NTB_EPF_CTRL(field)	offsetof(struct epf_ntb_ctrl, field)
 
+/* Private DMA wire extension produced by pci-epf-vntb. */
+#define NTB_EPF_DMA(field)	(EPF_NTB_DMA_CTRL_OFFSET + \
+				 offsetof(struct epf_ntb_dma_ctrl, field))
+#define NTB_EPF_DMA_REGION(field)	\
+	offsetof(struct epf_ntb_dma_region_ctrl, field)
+
 /*
  * Legacy doorbell slot layout when paired with pci-epf-*ntb:
  *
@@ -71,6 +78,24 @@ struct ntb_epf_irq_ctx {
 	unsigned int irq_no;
 };
 
+struct ntb_epf_dma_region {
+	unsigned int bar;
+	resource_size_t offset;
+	resource_size_t size;
+};
+
+struct ntb_epf_dw_edma {
+	struct dw_edma_chip chip;
+	struct ntb_epf_dma_region reg;
+	struct ntb_epf_dma_region ll[EDMA_MAX_RD_CH];
+};
+
+struct ntb_epf_dma {
+	struct ntb_epf_dma_region submap;
+	unsigned int nr_irqs;
+	u32 type;
+};
+
 struct ntb_epf_dev {
 	struct ntb_dev ntb;
 	struct device *dev;
@@ -82,6 +107,8 @@ struct ntb_epf_dev {
 	unsigned int mw_count;
 	unsigned int spad_count;
 	unsigned int db_count;
+	struct ntb_epf_dma dma;
+	struct ntb_epf_dw_edma dw_edma;
 
 	void __iomem *ctrl_reg;
 	void __iomem *db_reg;
@@ -136,6 +163,213 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
 	return ret;
 }
 
+static bool ntb_epf_dma_region_parse(struct ntb_epf_dev *ndev, u32 base,
+				     bool optional,
+				     struct ntb_epf_dma_region *region)
+{
+	void __iomem *reg = ndev->ctrl_reg + base;
+	resource_size_t bar_len;
+	u32 bar, offset, size;
+
+	bar = readl(reg + NTB_EPF_DMA_REGION(bar));
+	offset = readl(reg + NTB_EPF_DMA_REGION(offset));
+	size = readl(reg + NTB_EPF_DMA_REGION(size));
+	region->bar = bar;
+	region->offset = offset;
+	region->size = size;
+	if (!size)
+		return optional && bar == U32_MAX && !offset;
+	if (bar > BAR_5)
+		return false;
+
+	bar_len = pci_resource_len(ndev->ntb.pdev, bar);
+	if (offset > bar_len || size > bar_len - offset)
+		return false;
+
+	return true;
+}
+
+/* DW eDMA */
+
+static int ntb_epf_dw_edma_parse(struct ntb_epf_dev *ndev, u32 length)
+{
+	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
+	struct dw_edma_chip *chip = &edma->chip;
+	u32 count, chan_offset, chan_size;
+	unsigned int i;
+
+	chan_offset = offsetof(struct epf_ntb_dma_ctrl, chan);
+	chan_size = sizeof(struct epf_ntb_dma_chan_ctrl);
+	if (length < chan_offset + chan_size ||
+	    (length - chan_offset) % chan_size)
+		return -EINVAL;
+
+	count = (length - chan_offset) / chan_size;
+	if (count > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA(reg), false,
+				      &edma->reg) ||
+	    !IS_ALIGNED(edma->reg.offset, sizeof(u32)))
+		return -EINVAL;
+
+	chip->mf = EDMA_MF_EDMA_UNROLL;
+	chip->ll_rd_cnt = count;
+	chip->func_no = PCI_FUNC(ndev->ntb.pdev->devfn);
+
+	for (i = 0; i < count; i++) {
+		u64 paddr;
+
+		if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA(chan[i].desc),
+					      false, &edma->ll[i]) ||
+		    !IS_ALIGNED(edma->ll[i].offset, sizeof(u32)))
+			return -EINVAL;
+
+		paddr = readl(ndev->ctrl_reg +
+			      NTB_EPF_DMA(chan[i].desc_addr_lo));
+		paddr |= (u64)readl(ndev->ctrl_reg +
+				    NTB_EPF_DMA(chan[i].desc_addr_hi)) << 32;
+		if (paddr == U64_MAX)
+			return -EINVAL;
+
+		chip->ll_region_rd[i].sz = edma->ll[i].size;
+		chip->ll_region_rd[i].paddr = paddr;
+	}
+	ndev->dma.nr_irqs = count;
+
+	return 0;
+}
+
+static int ntb_epf_dw_edma_irq_vector(struct device *dev, unsigned int nr)
+{
+	struct ntb_epf_dev *ndev = dev_get_drvdata(dev);
+
+	/* DMA vectors follow the NTB link and doorbell vector block. */
+	return pci_irq_vector(ndev->ntb.pdev, ndev->db_count + 1 + nr);
+}
+
+static const struct dw_edma_plat_ops ntb_epf_dw_edma_ops = {
+	.irq_vector = ntb_epf_dw_edma_irq_vector,
+};
+
+static void __iomem *
+ntb_epf_dw_edma_map_region(struct pci_dev *pdev,
+			   const struct ntb_epf_dma_region *region)
+{
+	return pcim_iomap_range(pdev, region->bar, region->offset, region->size);
+}
+
+static int ntb_epf_dw_edma_init(struct ntb_epf_dev *ndev)
+{
+	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
+	struct dw_edma_chip *chip = &edma->chip;
+	struct pci_dev *pdev = ndev->ntb.pdev;
+	unsigned int i;
+	int ret;
+
+	/* Install BAR submaps before mapping the advertised DMA regions. */
+	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_SETUP_DMA_BAR, 0);
+	if (ret)
+		return ret;
+
+	chip->reg_base = ntb_epf_dw_edma_map_region(pdev, &edma->reg);
+	if (IS_ERR(chip->reg_base))
+		return PTR_ERR(chip->reg_base);
+	for (i = 0; i < chip->ll_rd_cnt; i++) {
+		chip->ll_region_rd[i].vaddr.io =
+			ntb_epf_dw_edma_map_region(pdev, &edma->ll[i]);
+		if (IS_ERR(chip->ll_region_rd[i].vaddr.io))
+			return PTR_ERR(chip->ll_region_rd[i].vaddr.io);
+	}
+
+	chip->dev = ndev->dev;
+	chip->nr_irqs = ndev->dma.nr_irqs;
+	chip->ops = &ntb_epf_dw_edma_ops;
+	chip->flags = DW_EDMA_CHIP_PARTIAL;
+
+	return dw_edma_probe(chip);
+}
+
+static void ntb_epf_dw_edma_deinit(struct ntb_epf_dev *ndev)
+{
+	dw_edma_remove(&ndev->dw_edma.chip);
+}
+
+/* Common endpoint DMA */
+
+static int ntb_epf_dma_parse(struct ntb_epf_dev *ndev)
+{
+	u32 magic, type, spad_off;
+	u16 revision, length;
+	int ret;
+
+	/*
+	 * Legacy endpoints place scratchpads where this extension would begin.
+	 * Once the extension is present, malformed metadata is fatal.
+	 */
+	spad_off = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_offset));
+	if (spad_off < EPF_NTB_DMA_CTRL_OFFSET + EPF_NTB_DMA_CTRL_COMMON_SIZE)
+		return 0;
+
+	magic = readl(ndev->ctrl_reg + NTB_EPF_DMA(magic));
+	if (!magic)
+		return 0;
+	if (magic == U32_MAX)
+		return -EIO;
+	if (magic != EPF_NTB_DMA_MAGIC)
+		return -EINVAL;
+
+	revision = readw(ndev->ctrl_reg + NTB_EPF_DMA(revision));
+	length = readw(ndev->ctrl_reg + NTB_EPF_DMA(length));
+	if (revision != EPF_NTB_DMA_REVISION ||
+	    length < EPF_NTB_DMA_CTRL_COMMON_SIZE ||
+	    spad_off < EPF_NTB_DMA_CTRL_OFFSET + length)
+		return -EINVAL;
+	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA(submap), true,
+				      &ndev->dma.submap))
+		return -EINVAL;
+
+	type = readl(ndev->ctrl_reg + NTB_EPF_DMA(type));
+	if (type == U32_MAX)
+		return -EIO;
+
+	switch (type) {
+	case EPF_NTB_DMA_TYPE_DW_EDMA:
+		if (!IS_REACHABLE(CONFIG_DW_EDMA))
+			break;
+		ret = ntb_epf_dw_edma_parse(ndev, length);
+		if (!ret)
+			ndev->dma.type = type;
+		return ret;
+	default:
+		break;
+	}
+
+	dev_warn(ndev->dev,
+		 "Endpoint DMA type %u unavailable, continuing without DMA\n",
+		 type);
+	return 0;
+}
+
+static int ntb_epf_dma_init(struct ntb_epf_dev *ndev)
+{
+	switch (ndev->dma.type) {
+	case EPF_NTB_DMA_TYPE_DW_EDMA:
+		return ntb_epf_dw_edma_init(ndev);
+	default:
+		return 0;
+	}
+}
+
+static void ntb_epf_dma_deinit(struct ntb_epf_dev *ndev)
+{
+	switch (ndev->dma.type) {
+	case EPF_NTB_DMA_TYPE_DW_EDMA:
+		ntb_epf_dw_edma_deinit(ndev);
+		break;
+	}
+}
+
 static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 {
 	struct device *dev = ndev->dev;
@@ -347,16 +581,20 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 {
 	struct pci_dev *pdev = ndev->ntb.pdev;
 	struct device *dev = ndev->dev;
+	unsigned int dma_max = ndev->dma.nr_irqs;
+	unsigned int dma_min;
 	u32 argument = EPF_NTB_MSIX_ENABLE;
+	unsigned int ntb_irqs;
 	int irq;
 	int ret;
 	int i;
 
-	irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
+	irq = pci_alloc_irq_vectors(pdev, msi_min,
+				    msi_max + dma_max, PCI_IRQ_MSIX);
 	if (irq < 0) {
 		dev_dbg(dev, "Failed to get MSIX interrupts\n");
-		irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max,
-					    PCI_IRQ_MSI);
+		irq = pci_alloc_irq_vectors(pdev, msi_min,
+					    msi_max + dma_max, PCI_IRQ_MSI);
 		if (irq < 0) {
 			dev_err(dev, "Failed to get MSI interrupts\n");
 			return irq;
@@ -364,8 +602,17 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		argument &= ~EPF_NTB_MSIX_ENABLE;
 	}
 
-	ndev->db_count = irq - 1;
-	for (i = 0; i < irq; i++) {
+	dma_min = dma_max && irq > msi_min;
+	/* Reserve one shared DMA IRQ when available, then give the rest to NTB. */
+	ntb_irqs = min_t(unsigned int, irq - dma_min, msi_max);
+	ndev->dma.nr_irqs = irq - ntb_irqs;
+	if (dma_max && !ndev->dma.nr_irqs) {
+		dev_warn(dev,
+			 "No IRQ available for endpoint DMA, continuing without DMA\n");
+		ndev->dma.type = 0;
+	}
+	ndev->db_count = ntb_irqs - 1;
+	for (i = 0; i < ntb_irqs; i++) {
 		ndev->irq_ctx[i].ndev = ndev;
 		ndev->irq_ctx[i].irq_no = i;
 		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
@@ -377,7 +624,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 	}
 
 	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_CONFIGURE_DOORBELL,
-				   argument | irq);
+				   argument | ntb_irqs);
 	if (ret) {
 		dev_err(dev, "Failed to configure doorbell\n");
 		goto err_free_irq;
@@ -610,6 +857,11 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
 		return -EINVAL;
 	}
+	ret = ntb_epf_dma_parse(ndev);
+	if (ret) {
+		dev_err(dev, "Invalid endpoint DMA layout\n");
+		return ret;
+	}
 
 	/* One Link interrupt and rest doorbell interrupt */
 	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
@@ -760,6 +1012,12 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 		goto err_init_dev;
 	}
 
+	ret = ntb_epf_dma_init(ndev);
+	if (ret) {
+		dev_err(dev, "Failed to initialize endpoint DMA\n");
+		goto err_dma_init;
+	}
+
 	ret = ntb_register_device(&ndev->ntb);
 	if (ret) {
 		dev_err(dev, "Failed to register NTB device\n");
@@ -769,6 +1027,8 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register_dev:
+	ntb_epf_dma_deinit(ndev);
+err_dma_init:
 	ntb_epf_cleanup_isr(ndev);
 
 err_init_dev:
@@ -782,6 +1042,7 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
 	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
 
 	ntb_unregister_device(&ndev->ntb);
+	ntb_epf_dma_deinit(ndev);
 	ntb_epf_cleanup_isr(ndev);
 	ntb_epf_deinit_pci(ndev);
 }
-- 
2.54.0

