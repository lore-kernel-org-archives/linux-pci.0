Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.90
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576598;
	b=FQYxn5GzYMNbHKMxg8Qp39v+S9lDYqnkbkRzBgGDJEnDKvvSkacEr/hBMtNVeboP+4Ab
	 hL6p7QmaufeoFumroLlRmFt/8zcoJ5pBGlqCvEgQAYD+Hera1gysVHn9tglv+jPXtIJE2
	 hYUp48gtPRwICod8jIfPqQrtMKGW6XLOpGLpl/cVCzoKIptxeTyVdtPpqXeodXqRZLEbI
	 RV6kgMhOO7untJnii4D9eQJfSO0HvSs30iqYZvJVD7wmE1KaXYMpg/nh6pqkWzk+wKwsu
	 veNZq3waIyFgGkvlF9lXPzyzWeECsem74LRfQdzP8PaABwEXU09u3WVFPHl2PXLof7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576598;
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
	bh=PoMwLHLqdeqcJhD7mNOimzJyeOlc5MkD94oRWyCZFrI=;
	b=HfBfDDFbb+L8d9X+17M/PKc+DFM//z3hSjHTFlSiDROB+JD9n3WxFrAnm7OpWcapLcEx
	 t31kexWROkd918spVYXfVYyOMsrKQHZX32RE+r4/Xdf5NrjmmG3HODA24A+mNZ+75s5wg
	 EuItEZzmQ4vK5cdo0K0XBq+Lj0ueNZWPy3BhVB9Mv2tuba3VNarpWvfAHE1itOmA2TppB
	 D5BDfw5iipLA6hK+LGPs43mF1c+v2JKGPiSDL2UrcrJnt5GgaPlB2+CDZEnziJf0KTX9n
	 522GSV5a7o9LyHlaJHmyJWyi6zRvMZrgiThwg5dk5Y2PoLXR24X9zhTK8m6hU3b2jPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=tTd5LgkF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.90
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021090.outbound.protection.outlook.com [52.101.125.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607960A3839;
	Fri, 13 Nov 2026 13:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6607960A3839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=tTd5LgkF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pG2vhqDY+kVY78Exkjhn/sAe2nMeXABSwfnAfPxDVZ6ETETGpy1r5Dl9/wZEYk/mTrca44AiU9DQUdZs2NZLd+UxVD0UwlFwtIr6PXFFavNwZ6ODl9dfRUAvTj1ngCmHwmsDRpRMwnLnOGvLPE+dXHt7SuyZ7gYF+wV5+3Xu0HikmPjdArxDlKNiT2zQNfUVAqmw5Y1V06Icm9RH+khwsu70DBlomO1JPJC0nSAYuBgVpIzMDsdtKmBvKxlBmZ1aarL7cqbnX0bniJRY1aKqaKn8d4WSmLJ5Cnqcq0ig4oa2Hrw00sVppwsyyutEzXpG9VW0YLVzyGrfkoU0SzOxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoMwLHLqdeqcJhD7mNOimzJyeOlc5MkD94oRWyCZFrI=;
 b=EcKIdsZBeLoK1ISM3JciX/wC4M1/oTCI/uTUy1zycpo75awfJqsFjJeZnpZ1FzWiBD91mGBjVUs6zQG/7es/HdxpFL1rgD0eFQ/WfByAVZlDXiRdWw1dwD5wD4tn7yPVnw52IuTyjz6NoowfIwKEcca8E6/hCmzh2h4MPAzhsKfSdBBp2UtRoMgSr11ubyjoBHtcd08GkFZtN5j0Irbc5MYfapFJrfSVXhj0hQFUtH72eVAdAuH54l6t1m0inVmqAZz95x8RdSE/x7siR3opJYb4fyI9Gctdw37DKq3UCyIv8RFZZTQ7EDiGKMyN74tQI8pg7i5cZjuhyWjc3yl7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoMwLHLqdeqcJhD7mNOimzJyeOlc5MkD94oRWyCZFrI=;
 b=tTd5LgkFwuczhUzILIUJyRvQ4fSBBOjfsmAAc2OJ0xY5soZeqRs99pksZ2unvFdXHxwN546kLFSVdtrcBfAQaSG+5+brzxLvFOjc2hOECOEVrMZ8JOeyoMu6iAoDpIKM/y4wwhy8AHvxdhVhcnoi1nsIONkof0JmFfpAxJdlovE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYVP286MB3716.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:29:54 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:29:54 +0000
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
Subject: [PATCH v10 09/10] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Date: Fri, 13 Nov 2026 22:29:34 +0900
Message-ID: <20261113132935.4152566-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113132935.4152566-1-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYVP286MB3716:EE_
X-MS-Office365-Filtering-Correlation-Id: f7597e62-70fe-4ddd-c8bb-08df418a33f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|56012099006|10067099003|261102123227099003|261026135527099003|261022105027099003|261026121527099003|261022075727099003|261022115727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	PEDFV4s0SfUpP8PSnLvx/p/Y9QmlR/wuHaJQquXQHNhAsXlZWdOJjqSW7jlxwZ5I4vej+zsLmbdNwZ/3+UiP0m8D7s7ZIE0+hHKvsmyVTNbBqJxdq2wkiNPY6qK+T8E5HTJfCQ32p2augGpvrUPG0XVhjmxKuoZYAAJBibyAxBSurDDAQzTZeq/cIHzOjAxs+yxJgrJiKQpU6M29TLEm19GrjdefaJa5T/B2Azuyed9JFNB9x+lsL3VC8f05xh9RwHaRnCgMCPZxPh1F+QL7bIQ1R+1OnoAiyNKdvMSPBEKHeL5csnYCRExPtlIq6UrfbnF5nKBuTsM3LNoAx05hugY///9FvV95afMDJO9YYfT4L+ZRrJpCRQ6sueHOLR+e53zd5p9wwx+KnzTmDG11YbNs2kXcsaq/YhkVt8ir69vNyF/id4oBUtQ8hcLlB9iW4SVTlh2DeUGoAV4gSyCeudODsPBvQdgaJAx/cE506G+HzirVPLCcAxlDsRehn9RKAnHYGOHV4FOXy2lJLApyDpVBUxoyy06kJdxG1/rKTTgTgep21/mia74W9j/9CdjbowA7F+pZzLmq9n6di/q5O+bd6Z3/GJV0Pt++HXT9WTdYk27TW6pyEzP0jVwnxYih
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(56012099006)(10067099003)(261102123227099003)(261026135527099003)(261022105027099003)(261026121527099003)(261022075727099003)(261022115727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xOf13LaYExi5ek/vtaxRFNUn1Ft2uVkrYBMegW1JgN4SzY/HGjhxQLEllvfe?=
 =?us-ascii?Q?LKZtU49pVKHhJ3bTthfE90xHFduB3rt2b8mfZ7WtsR/cyVVWUcLX8CmNZeWI?=
 =?us-ascii?Q?NSMMv+eOoPZ6JGCQYo65pu1UxFwEvayCxKaC3HlrDYryC/qCPLTkzv55+GQy?=
 =?us-ascii?Q?ZN9Lrxi3KHe53PiHPHtiC2s1mhjLHS8RUgbx1WlHZuupDajLasA5N479gTnO?=
 =?us-ascii?Q?bhD097RlOlzOAz4Hx6gs/au4SqqK2zN9yoWpIswvrapfJy1V/hJ7EG8jyG0Q?=
 =?us-ascii?Q?JLfMdMz1VPQ5JCmdEtjzMAymdpU+v9JWI2TZTBOvqVr9Cdz/fHWQFSsfodJV?=
 =?us-ascii?Q?m2EdJH2yjUujCVKmSfZiq1KKQ2mEr8vDIWrS6rNw8ZZ0WIe7tjPRBiBbBpxK?=
 =?us-ascii?Q?qXQSzn+o4v2e6Kl7aRRPdug4IOvfFeT3tSpxBuVTzfyLea+fLYPLGHAJXbDQ?=
 =?us-ascii?Q?K92Ik0UpbTpHfSdnz6hsRqCe/2m/cFh/FrW31rqby+ymxO1OhQg4SO0PayZW?=
 =?us-ascii?Q?xg5f6r+VU+j8NEJtABgKo4+w2O5lYfSFmm2p41NEji907qMejt0ebPFkaK60?=
 =?us-ascii?Q?TIO8FeWKKvEBCxHxlU7qV7A5Dv6ZPzUxsMXtq+hVzoNN1IsRaQG2kmB8BPvK?=
 =?us-ascii?Q?QL/B+V/GS/LEyCjkmX7UssAc5+/xZbIRAP6zgt2dO45g8os6GzBHucioOqjp?=
 =?us-ascii?Q?lklxfJVJrU2WEow/6yC/xP6yhtaBMel7shD6T/1RISL3j5RbJiY6IykaM9OF?=
 =?us-ascii?Q?6JB1NVkJfyju7fb/nZzGgqBMZtI5Cr91WblIgWvDN8Pi/jShO2xfnNdvLYt0?=
 =?us-ascii?Q?O3AOt9BG4ycErcoF2mvopr22LlmU8S+T11Cu/iST4aBeReYpOmG96cMwpCZx?=
 =?us-ascii?Q?UD1ReZrXGA1aQBUAtvSHdmbB/OYQhbi2oskhEwOJ2XH6sagibosUMBFZDja3?=
 =?us-ascii?Q?p89ODws8ux8a/2xuX9LfOJp+IWc+GgC9+10o0IwxSoIUfZb0Kl/3W0WqEBBd?=
 =?us-ascii?Q?F0v/36B3+vH13b7uqgdZxmVWhNO0wczQK8rYseCq+L2xLjLhxyXg/yAb/n9Q?=
 =?us-ascii?Q?iFVQvZDtrs4j9UyeACQmvjRwKxG1LEJ2blAKq2/4ETcIWP73g0WFnl2LdyvB?=
 =?us-ascii?Q?Z5avhFH6Pd+IAu8ocvHzi+VYPBQFrfBHIO4oiRVlBPGeTULcrPkcUyFsC4S6?=
 =?us-ascii?Q?/bCasRBTEDVjT8cO6vvtwkzV2m8tuVTZ4ZOGotpgcViNPUBoW7o56Yj15fbS?=
 =?us-ascii?Q?DxfizVD0PkshxfCBNeuELB/rEI54wwxwxmQ5BrRuCwHBpEXFrYNUrhRPNnIS?=
 =?us-ascii?Q?szZmb1DGkUr1/rn5V8etHW5NwXyJSvINgP4r8jhDDP/wPaya/bZL1cUmhEJp?=
 =?us-ascii?Q?aeluSebhG/f/TNVNpQilBt+Gi3a/aI9Dmi7CxRGhFdE1t38d2Drlfxi+ya65?=
 =?us-ascii?Q?jEroW2PPiPS/kxTik8bixNc/l2ZwcJPASOq+Ip/yKdVcw96GkPmkRldTlber?=
 =?us-ascii?Q?syJQ4kejhpGnwAovrYev4wx90sdyO9G2ouNI1KbWqtCdYN57SVi7ql6OEpKN?=
 =?us-ascii?Q?dGe6gkSNfXBauwxAiTTm/+PqpFqtaEsXeKBazKhe1Cf2eg5+rGwoGru4Cj0b?=
 =?us-ascii?Q?wa0WfxdnSFT9dXEjhsD+tjQrUF4YFKxOj0IX/8mpfiwCYryH6ASdmy6GQKxN?=
 =?us-ascii?Q?zGgBMPRG/tiTsHhyxfD/yesa7EWTPiOJ/Do5JE54yT0X+X7NNZKpZHdwqtvp?=
 =?us-ascii?Q?Ej8ue7h4o8XLh/HrWEcCKV1UPbM2NLHEq32DsBpLJwKEz1fmLL5y?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f7597e62-70fe-4ddd-c8bb-08df418a33f1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:29:54.4136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/Hwke1wt1GhtY3MVgfORPSzZ3fWmUYN/lIx5aG7k3NQRQDx4NEcz8FppOSlrgU39JmnfqYmaviVoPqHv59fxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3716

A vNTB PCI function can now expose endpoint-local DMA channels to its
host. Decode the extension and register the advertised channels before
the NTB device, so clients of that NTB device can use the DMA
functionality in the same PCI function. Endpoints without the extension,
or hosts without support for its DMA type, continue without DMA.

All DMA channels share IRQ slot 1, historically unused by link events
and doorbells. This keeps the doorbell count unchanged and needs no
extra vector.

Only DW eDMA is supported for now. Dispatch on the advertised DMA type
and keep type-specific setup in local helpers. Support for another
implementation can add a new case and its own helpers.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v10:
  - Use the historically unused slot 1 for a shared DMA IRQ without
    taking a doorbell vector. (Sashiko)
  - Drop R-b tag due to the IRQ allocation changes.
  - Link to v9: https://lore.kernel.org/r/20261110082459.1798763-10-den@valinux.co.jp/

 drivers/ntb/hw/epf/ntb_hw_epf.c | 259 +++++++++++++++++++++++++++++++-
 1 file changed, 256 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index ff92c2a61ce7..a70da2b4f187 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -8,6 +8,7 @@
 
 #include <linux/atomic.h>
 #include <linux/delay.h>
+#include <linux/dma/edma.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -18,11 +19,17 @@
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
  *   slot 0 : reserved for link events
- *   slot 1 : unused (historical extra offset)
+ *   slot 1 : unused, or DMA IRQ if enabled on the host
  *   slot 2 : DB#0
  *   slot 3 : DB#1
  *   ...
@@ -71,6 +78,23 @@ struct ntb_epf_irq_ctx {
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
+	u32 type;
+};
+
 struct ntb_epf_dev {
 	struct ntb_dev ntb;
 	struct device *dev;
@@ -82,6 +106,8 @@ struct ntb_epf_dev {
 	unsigned int mw_count;
 	unsigned int spad_count;
 	unsigned int db_count;
+	struct ntb_epf_dma dma;
+	struct ntb_epf_dw_edma dw_edma;
 
 	void __iomem *ctrl_reg;
 	void __iomem *db_reg;
@@ -136,6 +162,209 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
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
+
+	return 0;
+}
+
+static int ntb_epf_dw_edma_irq_vector(struct device *dev, unsigned int nr)
+{
+	return pci_irq_vector(to_pci_dev(dev), EPF_IRQ_RESERVED_DB);
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
+	chip->nr_irqs = 1;
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
@@ -366,6 +595,10 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 
 	ndev->db_count = irq - 1;
 	for (i = 0; i < irq; i++) {
+		/* When DMA is enabled, the DMA driver owns slot 1. */
+		if (ndev->dma.type && i == EPF_IRQ_RESERVED_DB)
+			continue;
+
 		ndev->irq_ctx[i].ndev = ndev;
 		ndev->irq_ctx[i].irq_no = i;
 		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
@@ -386,8 +619,11 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 	return 0;
 
 err_free_irq:
-	while (i--)
+	while (i--) {
+		if (ndev->dma.type && i == EPF_IRQ_RESERVED_DB)
+			continue;
 		free_irq(pci_irq_vector(pdev, i), &ndev->irq_ctx[i]);
+	}
 	pci_free_irq_vectors(pdev);
 
 	return ret;
@@ -610,6 +846,11 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
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
@@ -720,8 +961,11 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
 	ntb_epf_send_command(ndev, EPF_NTB_COMMAND_TEARDOWN_DOORBELL,
 			     ndev->db_count + 1);
 
-	for (i = 0; i < ndev->db_count + 1; i++)
+	for (i = 0; i < ndev->db_count + 1; i++) {
+		if (ndev->dma.type && i == EPF_IRQ_RESERVED_DB)
+			continue;
 		free_irq(pci_irq_vector(pdev, i), &ndev->irq_ctx[i]);
+	}
 	pci_free_irq_vectors(pdev);
 }
 
@@ -760,6 +1004,12 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
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
@@ -769,6 +1019,8 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register_dev:
+	ntb_epf_dma_deinit(ndev);
+err_dma_init:
 	ntb_epf_cleanup_isr(ndev);
 
 err_init_dev:
@@ -782,6 +1034,7 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
 	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
 
 	ntb_unregister_device(&ndev->ntb);
+	ntb_epf_dma_deinit(ndev);
 	ntb_epf_cleanup_isr(ndev);
 	ntb_epf_deinit_pci(ndev);
 }
-- 
2.54.0

