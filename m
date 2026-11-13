Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576590;
	b=XSW8FRTEbohnlwp27/NXk/M+xXtnDo4VWE3JfI3lua3tfuesmkYUgFKlHE9r5YZBqQpB
	 PBag5xS/0NmBkJp31PdmJXB4ltW7JjslrUL0dg3v47Dd0fZmFIAMDAfhffenclqUzrnx0
	 l7dS8x6YxwXW8z24CJ1Q1081ezSuVIDf8p7O+ygjlRFP73MDT1nts71VgjZ0NolTgGtlB
	 E20iLREvTx45JylioTjY7pggHQLM1zX0Rrzu9lLi1sY6PEu4IbOJao/9gBVmsOkXTNVor
	 3rprKIdOFkumZueI7zfN6//QGshuE3NVQWsC3Uod3bi4cDYFGx9JNG+opbUYxuUMWyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576590;
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
	bh=8tDHt7BQEYtdfMQknb9JWS0YOvWlcrfnPZ0gojlnVqg=;
	b=1x3Zh55TJWCfg8+FzXDMXJfuCTcYFRW4U2f+2pFIta6FPoQ2Bt+3l59TKfGRy2qxdPu9
	 0bk/jfsqAU6X4o/I03AtqM3qC6ZT2coI+iaoQoWUVtL1xzUDODwrlnSIKYl2+DHGpsr+t
	 bPfzbZBx+zRCMsdo5NXrkRCD4IZY3kqj1MnoOyQEQ3RtYoXxcNoW04ylqnMFWJEBoDJp5
	 CWcxQRgMMOp5z4LG5Ilu05S1AqD9N1SP5Yy/qboOhjwHg8WaCHcF2/sDvPVfBHjuievmc
	 eGocddREywU0mL2IoffZDb/3GG429xPs+iT2iV+4rSuQN1lvhIy60ySBZxn1IbrxMyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=G4I65nfz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020108.outbound.protection.outlook.com [52.101.229.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D50606A8BB;
	Fri, 13 Nov 2026 13:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43D50606A8BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=G4I65nfz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMsSx972UClFC1zzHg1B/azjMmKe0Bz1Euq53eRSbMklvo5By+45TrtRbieZ8tVP0265YLSrcqVNZBQZoo36gR39Id/8DvdYpbaRB2rsgFKKRTGraBoSl8VYY+hrefD6YPYZjZ0Or4YuV79VwgCieytDnDA28Nu0SG/Vl2r305lwr0ugytGtw0abcFsy6oAt6YjClbG0UleWWoE/AEc/kquu2jsSi4YOypEmw4DRG4QOpi49oSyqNzWXyQZNenMo9QbfW1R5YzQwnq2QDXbqAU1ltqNxTeUFH4OQPqGzVBuvArpxv1UarqRbZo2mrkolsLvL/3ziGliT269aoNsu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tDHt7BQEYtdfMQknb9JWS0YOvWlcrfnPZ0gojlnVqg=;
 b=xQszeWM7Pgjg6Feiw9RpK0ZWFbU/ySXEIr5T1axwzLjh6BSaykdJ9taxfQ+aW6dwd04dCWp6o2SgwG6UNSvIhvCOnXyQOSZB+BbYar8FGQnctgPx1SCPLk4ilKyU65MUGJZUx1zKk7f7OveI7yyR4LpqE/SSgxjfsIKPMDAoJNRKAJewDhGRN7NEX0KTWxGCUPjnOQuhjmknPl0kWgRMKlbvbDmFTIRv5frl0zfJfg384TfZUX4JK7tv2vqRYNrJ0w4zwulyUze68m2pbGr5Cauu2jNAMXFhktTCp1r+frTG6VgS1oES/fz4Mii0VAr5Hn50F5lssRpx77Ri/SY9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tDHt7BQEYtdfMQknb9JWS0YOvWlcrfnPZ0gojlnVqg=;
 b=G4I65nfzncuCxkPxkPobt1EhF4l7DLzH953yI8PofnQ9AGjbL5X7itxtGyR5ZKLxZnQ3OnI+5uVOGhnYb7d5+timn4LVwk/3nixzdszcl18y+lt+hRrz1vC7u//gwwkjrcz5eiZjCDSCdN++rfUFUi7WtYrinCpvwMuRwhxsDMA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYVP286MB3716.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:29:46 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:29:46 +0000
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
Subject: [PATCH v10 01/10] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Fri, 13 Nov 2026 22:29:26 +0900
Message-ID: <20261113132935.4152566-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113132935.4152566-1-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0145.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 10f2bcfb-1a61-4364-47e7-08df418a2f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|56012099006|10067099003|261102123227099003|261102130727099003|261026121527099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	oo5hB2RVoaRQvKkuLBg3dpsiuCy715B0WbZX7iCUZYgpe6a2wAbGCWpsHc9LUP/Hw1P/rwIXHcwRdbo2gu5/fbEvEqAEtjdMJln2MBF2zkeHHSO3K7/hLT6Oeu14N5zQv0sClkFZQruu3VxrRRxfPuUMILkuqTb1zc0chkA41jzb860W7V6Az6fDijOQ0LRet1ZedDiVOuyE2hfzTngE6x448SNsZXTsTn8A/JOarkysBYqrJHdyhuEnuMU3o5IfPfsgz5NXfy14O8zif/uVDVTt5MrK23IWUwIO1nq6MZv3nv00z27xWi5dZqHtFi4becwGjz5XCprby5myljGAiyjHHaATRujdCqhsykCQzujv1tLZ/1HMAx6acXTMgL+lHDZhjQVmUJBkGFpHBWQJWr4VsfEVKanIJyfUmoDFNRMEY5RrTXOEslLvC7cyW/TEqRlg6O4ObZ60MZN/EjRxmdN/UeRkIiXQwgYVjbZrEEqITSOie5vu2XDEBooplpvw977d7yFxgbLxFaiIeAxQZMXKs5zbMuNb3FAMo78gYxlAuK/Sh8N08+2Pxu5wh+Ck0SR+3VMefcXH2nJkcYZrLulAt4/tzASxEc4N1XICActt2+CfNqCK0K43yUcuu+38U7uquwL8oVUIHeqrhz1r5jSUvGgkP92ixI8MZ3PV0e8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(56012099006)(10067099003)(261102123227099003)(261102130727099003)(261026121527099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dZyP8H1QJn2uLRZL4rtCwobCdJkWctAesJicfsL1EVAGz74pCMZ10zrFLwA0?=
 =?us-ascii?Q?t4m9ggz9HPZV//mrnD+CUgQ7b/6cF16J6S8vJ1ylWMM7YG9QD4MZsqTVTtw2?=
 =?us-ascii?Q?Wb4NkOGRj5iBRJwRllz2uQqBfMtv9sZbG4HVKM9yWVzzGApJ/5mVqKLB2CHd?=
 =?us-ascii?Q?yZVyH0UybPA3qxXFc8qeLdem1722jOOixQtyLNCnioJQkYkp0PpywuimmEAD?=
 =?us-ascii?Q?P/4v4uZyQP9ZqxFQPgry948rJpRdWHeEXispvCl0zkuaSiLCotvfeFADVgsW?=
 =?us-ascii?Q?94Vt1qIOLmhBr5+XfGp6wfDxsrODYcE2G1me8lbCylA6Ifby2AlLG5eJcw0e?=
 =?us-ascii?Q?+Zmrby4WdQFerykDToKoS9LGSMcmSvrWyh0r1W4feyZY8hFhvuDLqye/elN8?=
 =?us-ascii?Q?kSdslH49Ii0Cr9Y3XUlw6Mh036v/kVzh5i+KXcdo1c3vLbYZrP85KS+/Sy6M?=
 =?us-ascii?Q?j+hhwljGrtQq2x5dNoZgLPqONm1DsmiQGZnGpl2+G6Pn2CjAToBd0ROfOi5j?=
 =?us-ascii?Q?Zrq8sSDwLCi8gvgEDAysM+U1xL5VVG1XbPAy37DD6GmB98zfQrc+G96vWiw9?=
 =?us-ascii?Q?Uh904WQrmaEAe+IhiDFu2cWVHvrcF7JlMXxcdJuv97PJ71BHulWmPJyZNHqV?=
 =?us-ascii?Q?CVsozF+OIpQLpPBgvafXgNLoWrPAl8BNYRZw8a6Q42ZbVe7wlYS94QBw09F3?=
 =?us-ascii?Q?Q8KIgBenGrKorCz/7L+Fz3n+LR/vxjV0u1AEoEd9wm5UG5xR+zD6M8MyciAP?=
 =?us-ascii?Q?TvZ0JC4y9faR/98vtXEbUQmrpty4uqpsaspcYAYSfNS81KYeaH+hgoTS9/+h?=
 =?us-ascii?Q?jOREl7u1zEJt7dPZ96jHa3IvTwqeIVoVA5y9psYjK9mITnooTFuQJMbBmdSK?=
 =?us-ascii?Q?m5xW0DPWdvnZmKYx5Wo3Hfienc1s0Ud69rezSng3mEMsWJAqlZnjoiLudQVm?=
 =?us-ascii?Q?XKiSGAQtM4bMlxaDQfQ0PsgPwuCgTeBEde6bX330pFnjLXrWgdOZmcZFRvfK?=
 =?us-ascii?Q?7LChcbN3s2YMDQAj4zwdMvaS0amRh5moHYE9wJAzJ+/HR8oy1ibn/rWs20ks?=
 =?us-ascii?Q?P+nMPLm7uQP3xtZ/wRBNUMQUAOKepZrMBF04cfFrhDkagAGU+3l4mPgMWjsF?=
 =?us-ascii?Q?7R6dYjwAlNxi/tkcOsRuHAKgIlxRJ/k/cAtMs1KGYEvP4vjzOK436cCU1kgJ?=
 =?us-ascii?Q?oElxcvQtAMw+Ak2eg5rvx3ivTQCO9auWkkf14lSfrODkcD6u4uoE8tkxM7dA?=
 =?us-ascii?Q?nga41V+twTlOYBJkT4ofYimNSmBxjP6lkUOEzGlekWW3BUky0QLqVzGV8vUe?=
 =?us-ascii?Q?ro+Sdpn2KipIdVwKb59nY44v0n0ybdgosSA1zre4SnM+zqbRyKEGmsuSJzdQ?=
 =?us-ascii?Q?BI1Wz7PtEdIiGYCp5+hPRQaMW9c17Y1UieHKtHibbk8SrJi29N57PtvRyn3H?=
 =?us-ascii?Q?dWbb6IWl5tQpxo29fVEg6ddEk3NM6w9r4NqWujwCyMF0BGspSJF/4+W+ocEM?=
 =?us-ascii?Q?Pqggl2GqGL8fC2TACRTUsJ+hHnSg9PYOhKJ6GlD8IrvmyPDN6HT15NTQOoCO?=
 =?us-ascii?Q?yvnkAqnyM40Ofn2ODxInEtju9yPFaC65TUhr62GPfaqcDaF8+ks86kHqG3qJ?=
 =?us-ascii?Q?6MXLmYp03VbQPTcZvqQ3TJ08GcmxGOb1o9QKLiRqISwAR+lQDeBwaKseBcxD?=
 =?us-ascii?Q?8SiUVM0BpONQtkg2PKrkdvRjhWWfcGU5IbyjnDxXDVv9ZVB1j/k8IsTecwDR?=
 =?us-ascii?Q?SzIP7WE+4/xUdlnKKtxsBWecu22A0fEj+pIBp0Z8W+c0iS3Lb7wk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f2bcfb-1a61-4364-47e7-08df418a2f0b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:29:46.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnzP062w0npSYoMOwIYOLc2QMBOUBckEiwU1MF81eiCqAA1bl02OJjmTZVmtRBXR5GjaagDEOXpSXvssV2F1FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3716

Endpoint functions that export controller-local DMA channels need the
controller register and descriptor-memory layout.

Add DMA control and descriptor-memory resource types. The control
resource carries the register layout and channel counts. Each descriptor
region is associated with the static channel ID assigned by the local
DMA driver.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - No changes.

 include/linux/pci-epc.h | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f247cf9bcf1a..e0348e7bc534 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -65,6 +65,8 @@ struct pci_epc_map {
  * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
  * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
  *                             controller register window
+ * @PCI_EPC_AUX_DMA_CTRL_MMIO: DMA controller MMIO register window
+ * @PCI_EPC_AUX_DMA_DESC_MEM: DMA descriptor memory
  *
  * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
  * register windows and descriptor memories into BAR space. This enum
@@ -72,13 +74,25 @@ struct pci_epc_map {
  */
 enum pci_epc_aux_resource_type {
 	PCI_EPC_AUX_DOORBELL_MMIO,
+	PCI_EPC_AUX_DMA_CTRL_MMIO,
+	PCI_EPC_AUX_DMA_DESC_MEM,
 };
 
 /**
- * struct pci_epc_aux_resource - a physical auxiliary resource that may be
- *                               exposed for peer use
+ * enum pci_epc_aux_dma_reg_layout - DMA controller register layout
+ * @PCI_EPC_AUX_DMA_REG_LAYOUT_UNKNOWN: unknown or uninitialized layout
+ * @PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA: Synopsys DesignWare eDMA/HDMA layout
+ */
+enum pci_epc_aux_dma_reg_layout {
+	PCI_EPC_AUX_DMA_REG_LAYOUT_UNKNOWN = 0,
+	PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
+};
+
+/**
+ * struct pci_epc_aux_resource - an auxiliary resource that may be exposed for
+ *                               peer use
  * @type:       resource type, see enum pci_epc_aux_resource_type
- * @phys_addr:  physical base address of the resource
+ * @phys_addr:  CPU physical base address of an MMIO resource
  * @size:       size of the resource in bytes
  * @bar:        BAR number where this resource is already exposed to the RC
  *              (NO_BAR if not)
@@ -99,6 +113,20 @@ struct pci_epc_aux_resource {
 			int irq; /* IRQ number for the doorbell handler */
 			u32 data; /* write value to ring the doorbell */
 		} db_mmio;
+
+		/* PCI_EPC_AUX_DMA_CTRL_MMIO */
+		struct {
+			enum pci_epc_aux_dma_reg_layout reg_layout;
+			u32 reg_layout_data;
+			u16 ep_to_rc_ch_cnt;
+			u16 rc_to_ep_ch_cnt;
+		} dma_ctrl;
+
+		/* PCI_EPC_AUX_DMA_DESC_MEM */
+		struct {
+			dma_addr_t dma_addr; /* Endpoint-local DMA address */
+			u16 chan_id;
+		} dma_desc;
 	} u;
 };
 
-- 
2.54.0

