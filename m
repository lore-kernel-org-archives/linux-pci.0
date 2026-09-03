Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020092.outbound.protection.outlook.com [52.101.228.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4CF4248A1;
	Thu,  3 Sep 2026 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423902; cv=fail; b=Enc7b740+fk2GXWVzoU2rdQw5XLtGS5YxD6E4hGmgUFeY2s2/5KIXRuAWTCGhUZY+yFrUbh0bOZGbhdCbbXl+7iahiRB78iEsLbbswJX0JqKh99DF3XvqahaKsE+DRR5SILOnkqDtNBcjweMYGZRiqOlbLKCgLcDvMx560Gi2qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423902; c=relaxed/simple;
	bh=twR+BfV5q8SfIyvMjM/pS2vD8OQ2y8iTSaJ1dxh17mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WbcH3qfLtGcdASr4bAlHRHwFeLNXVd8IVMjhMnQQW8N5eCUCvg8YQs8++rzO2bAnaFDQ8oqXkqYHAHaHmobN8/AG0lk11Tsn6dyRvAw/QCi2xaetJmb0XfO4KPKmrVi0nig2eKgV+lMrDqUZPSBIAIHvMA8DPb7ljOWMaBxpAaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QhGVnpPc; arc=fail smtp.client-ip=52.101.228.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QhGVnpPc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEUnxo+wuzoBawTV83aNnIR5yA+84lnN963HkALEySc9S8GLfO/jMklIYeEHLNStMHaSGHdWwwf98K/d2lMPhV25WUFwyQB+KyU1U3cYdHILseS/6XGhRlbW+zJMoaKhM4ybN+UZF7wgSrlx1gr4Paa9ApaeaNjOELUIeOtmEjUMOeF4oEdwe6iTrFhBMA2t20uiI9wal3ul5JgC/nABjFS8pPLZ5++VQy83tt4OTyhS/XrweCDxYZZG4Td+7YRcQF/+mJ329d8DpFd0+NsB4OKn3pXZLc17PgijSGY/KZZUAokghrr8RIJrw2YUUlG8DyHCzf7sQGdaYV79HNNJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6Do3XnbILM+ZELCuUcAhwN3syk8XsicuqiHiHqNvpE=;
 b=mrHW0WfFOrI4xgHBtKxnvoE8HMJgBwjQHAwN1pkPtuYsjjDgs77khhGrNjHvTi+SNm9pucu6Pwj5fc6VgydviAsIjG+Cm63x0bFqnantEjxQsVFUnBrdu4E2DlGtQKfa+KXncvFvPv8FFQrht493G0Js1xXu9o1bNZypyLoyqbEWvT8nCx6L77ZwfdcTBxuzxrpiDdGUajlf7eZpOx0qNAcj0A+FSJTxDlfrjMARniiem+a7E8qXADyu+A+8l4eMoJWoivIsH74Qi53usH5NjpmyJFCbUYIhWMKwi+poyp17oZ7RVh/NRg0eO6iMMYV3b/yxxXqL4pn1QHnAZOQvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6Do3XnbILM+ZELCuUcAhwN3syk8XsicuqiHiHqNvpE=;
 b=QhGVnpPcpmJ1lmevESvR6FndocLqIxIXOCVC6myHNBLIOk/Z9fDGtlIkxLDYKCsXGOqpC6YeXeQs5BAmKS8CfIV7XkMTZ51LaKPGcANHs8i4dE6Jbnb1OGEVb/67VELdLmn8A40d2j4G81XvR1icowIAzqEUvuvK7jMTlC4oj9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7060.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:24:58 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 08:24:58 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
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
Subject: [PATCH v4 1/7] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Thu,  3 Sep 2026 17:23:21 +0900
Message-ID: <20260903082327.2345602-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260903082327.2345602-1-den@valinux.co.jp>
References: <20260903082327.2345602-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0005.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: f4586484-f7f7-4115-521b-08df0994d767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|10070799003|366016|6133799003|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	r4MJ81r+O6KJ7fGSHmP+Ne+ecLYWM5ZUmT4RIVU++8G/wh63CdD6h3jQNEBAssp0Gs76+S4LE4PC+eUeeiRrnC3CuOxFUHHNQ3xZhwTnvDheqgUFkZ9uVc3NP5Sr6Z0bqC8EyZdtGReKu+1ZTdPMbRyE7yQrXbxcbC+AbDo36waMl9l7Jl91se19vxakBzFEOyxqjuboLQc7pX3xP+XFw895wOG5Fg9nwHjzkZpq1/Q+OV2nRxq6oEG/oDGDqxyg2j244Y8znOc6uM221h7rTYHR+YRkYTMQngXhB1oIn+CwgU4stTQs9VqkfXu+hbOcbzUX3c4QhxLCHfToMINNJnb/x12c8CNxquR5hqNpj0b5rkUqpD0TiIlbjiwuBKxNQf1/Aony3J8FI2R/U8zJSoOFz4CngtAYLlnk6S50tuP0TdjgTOPxoT9oMe4U1BqAJxNwrfusxR6HkNL+yZ5Ouddz7ULvpQ7Zcjhxl4+a++WUp+Y+XhT0LTz4+Rfmofa7GSYIC56G5Q8234FzRne3pb1gMjfUpW8gR2TfYxPqZzsjTb2RR8Ef5eZD11Ki9nXMvV4PQjKjl1BHCVQLfxIHn3d2qU2PNQ+2qk4uHiCu1O6E8OtLSRlbHsSwXN5DWZ6CKXZABrSk0AcLh5vzqY1gIdvSnhBjd5MAvGvlaJBC4Bk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(10070799003)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4wzrvjHAt6XNi8oIjuipllX2VgBlo0aHFfdLMvwNkTTcdL8dMfRQbsYsdax6?=
 =?us-ascii?Q?8PKj5ePsnNmrWdnmuSw0q8Xg+4mUEKOP24QAiqaaXWvJMJv4mf57NXgOlmjz?=
 =?us-ascii?Q?8984+T27nrsdC3DD+3CxtjlqlAUR1ITDLDfRmU0M6X1+n9nNi9aSi7uGxGes?=
 =?us-ascii?Q?W9XQGu4EUNZhhnSW6eGsOf2W+9vcUyorbMqnP7nGLDGVbBeeSoajkwpN7wCH?=
 =?us-ascii?Q?Sq+00K1kRI2BVo69yBpVGlscvFVuR+jA6h5JRkVM9XNVcR44O30RlC39QE+l?=
 =?us-ascii?Q?GouFrmqDB6yWW0AtUKFQz4C8+CNfE/Oyuj7SqZTOhmaz+MsiacuI3hvSTghC?=
 =?us-ascii?Q?H3++p6ueUO8ozp4OZt+/4TrArG8MmWXB6lQFBMhylm0PnmG38pXj630hr+mX?=
 =?us-ascii?Q?m0KHBjQ8q4m/KOAxjxKMNEJ96Xdx2AFc5kwPq5cZN0GWTS0UvAWcVZqH8Xlh?=
 =?us-ascii?Q?NkZRDWuzWKRc3HABz1Hc4pOnMrfdksPDPcAKYp+VhlPFDWxa3RH0ARPsjqnt?=
 =?us-ascii?Q?WqP/oDmV+RhUaFXJDLrcPxwUWYKxJIftk/JrnuE46Wr25rDZ6geMq5XYOtl8?=
 =?us-ascii?Q?eWizl4RhJ+8CrUu1nipISaaTiv7Y2g5eqGb9o+x1rNANRWjrRiqEb5YXGzlN?=
 =?us-ascii?Q?eAkUUqBVSgjEJ/MpyySGn6yR4DW6YIn6Wzriwikvt+YZOKrmPhFcin5Alw1r?=
 =?us-ascii?Q?scWOoY7dlQOkqSlJzuR9deMDA0Y7ZetTkFzRdg1Gr3f1XWO35PT8gd3p1JPg?=
 =?us-ascii?Q?54Vsnajk32QXwvo8g98DdCeBDSgOaZS/1yW07pOSZsHlLWbNfeBmRheZjz20?=
 =?us-ascii?Q?C3Zra1rO65cMB1nNjdthmbIOYgIDcNNVVnq4HXhir3s+LJ7zhAw+JVmDKV/y?=
 =?us-ascii?Q?L3UxmtaOFBGlq6dZ8Us/DXzYezgxr4zWMVurV+7eE63B5pEa7L7c2hcEQ3+b?=
 =?us-ascii?Q?+kN8n/Ycmu0AJKc/cXxw80Wl69pJ6HD7c4KJwiP+VnuHovOCr7+01eHDwYay?=
 =?us-ascii?Q?ZwLC7mV9xY7vDKhA/zygCiA1oEDx01eGgR7n/A8dm1a/6m79HfJQumIw86Zd?=
 =?us-ascii?Q?Jsk9+9g0pjQWI539VYy0oUCLVdikTVN2mug33Zj1oUxJ+b71SLoL7sYTmZ+F?=
 =?us-ascii?Q?+Knp6Lqn3HEBZYn/b+WJEBngPIKIYi9+T/mdFcveQOSqJQ95KZT9OU+WzBVK?=
 =?us-ascii?Q?72nqHK13O53sWDXQaA4RUjH/B8N4UQwJT4m/qTd6r5n+6D2/HInk5/0hR9tM?=
 =?us-ascii?Q?LqacnwECbaYFE2366ib4oSM9pMp2ArJPAPe0LeLCn9rV7rLE+3+HSHSSRycZ?=
 =?us-ascii?Q?iMVkg75NNCI7eQAeCOjGwiE8qEeTjpcQLUb/Akdi6TZEZLiz1sFZwNK89PL3?=
 =?us-ascii?Q?K2rew/QcrIhgZpxNk2yF8u80gMkDx+yGIJEdrLkq2rCvJ8LM5gPTtbiyB5d2?=
 =?us-ascii?Q?cHtp4JbAjJIFBvHAIHOBMERDY6k7KXdhaDlwtUt3rruPEnHU5HccfD7pqRKB?=
 =?us-ascii?Q?3QGWAkMsKCeBNAOZQF3gAl8f7FNuPuh0pj1VUmp+MKbWFZZeA80z11adgFN4?=
 =?us-ascii?Q?UBeC3+WVPlPLNFEyZxRWHt16+mhxBMRoYdFNFmuth4FbZ8aOO9PHMTAlA5Xo?=
 =?us-ascii?Q?KexQRs6LkDX/txgITWsuXok0skVKXYSu1WKkbkFq8K3w+ZstV5tv+wnyRVk/?=
 =?us-ascii?Q?SC8Yv+lAAO2GUaylajkqpgNfn8SpqoEoymA5sVyUD9cTs7heQNZ8fywP9BUD?=
 =?us-ascii?Q?IjorV1VeeTtSvOIW/Xc3wOahG+rmoPHkyudBOFAbO+eD0uFDpN8r?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f4586484-f7f7-4115-521b-08df0994d767
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:24:58.4621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BM5CZtDBSPmPqGX6kyj34021ZVAUwhmbqFepeuSmJeREbbI0HHYCX9PcyEEauyk8SbsJwMtfo0DA/vZTOLPn9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7060

Endpoint functions that export controller-local DMA channels need the
controller register and descriptor-memory layout.

Add DMA control and descriptor-memory resource types. The control resource
carries the register layout and channel counts. Each descriptor region is
associated with the static channel ID assigned by the local DMA driver.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
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
2.51.0

