Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792475401;
	b=08mNHgAD8LJTdEbKmha5Mlnx6liJQD1Rs7bBaS7eO8YICnDt6W51idf4xpckNHceYf+M
	 aRGg0dJczo3gf/3ox0reL5+73IlR18kc2r+CPenxNyDgIlByVHYywfNqPMe3K64nY54rd
	 vnY9gvpG7ZOEmYZb877PQdQefoGFu9Hdm1fZlq88Z766nbiz/9NMGYmSbYX4hCI7/kuFS
	 RbUK9+hFUBCrqht4UEPDyK5mFMiuhqOi6/Vt+jC8JQLtR7WNL/SYzuEmWAD5CTu4uf4PC
	 4SaZJqa7J5MwrFRyNWA99G/4MMmV5H7cGzZT7qZfFZi6dEX5WsW1eKI9IoayalalA9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792475401;
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
	b=Kj4IS0TcT33d8zFNsunYkux3zCIhO5tz5eJ4lrpFY5R4bQCPyMzsvnDQe9sfjqSMI2UQ
	 OQnE1K5aBGAL5q4QqeEsziWbpVjP4pEYJsD6UQxKmeqjgdGcjfTpK+KO+tl6KAGFBnQJ+
	 SzPagVpe8i+ckD28/g2OyZAT+g9hZkjJ0I1haKK8zUg6FuPzP0+lfwocujGvqvfXADIuK
	 5uYa7F/AHJAxFYJ3KdbSn8Z/SV7JKj3x1PNMGzQE9gWOC4oT3VA06HvEvmDKXGuwmjMRD
	 5eTLFtFeIIvwb75fdENpIHtDqI9XfXpxQzb5Ob2lcXiR5/Yjabr1XSKrOu2/Mmi2NgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=s0hJwENV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.140
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021140.outbound.protection.outlook.com [40.107.74.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EC4606A31B;
	Tue, 20 Oct 2026 05:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97EC4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=s0hJwENV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jtc+TQJWwGWwQ3YhP2XQYyJ50VlsYHoDoinrHIsFH5LVOSYUKA5UlwumRLuvVkIscwLuZAjT3xuMgFl1viVFWIcO95+xvx+XYcFfcd4+fNA/ArS2AMYu4wHPgL4eljaR2oBTMEMN7mfOMXRHjTiOOq4pOelMc7knzK0qI0S8EYeS9OrKoGoz3qX0zdZiOoxksuhMd24cGPmVW77IJoBZGqrFOSPh29By2G2haPXA8QgtUTfo0ThSXiK1v/4g8n8+7GtCCZthsUnhW3e60hZCfq7OehfTmFh6UOllB45Y80ALjdO4XLE6CEwR+jTV6pYYbjzZtQuKYfUFlyU1NSyXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tDHt7BQEYtdfMQknb9JWS0YOvWlcrfnPZ0gojlnVqg=;
 b=Dw+WWVUBWiir83XFVaGJmWCfWqZh34y8a5ZDdvsK7crBMCydpNRTudkQscvrW4dM99WJ5Ag4Le+JNUwNcaCFUV6uVWhSS8DSa4c+6daXGzmcvDZvhKwL40oZ5E7JwuGRj6q1O+iBHJINzHQ1oUXKbcB74FgIyWCyYbs0RjZY30D+8QAA2DHio/s/sGexJuqq/QEy30zxxO5BtcOJTUldcqhid4/UcghrfHS9bUiNhODZcoRPnTJmJobYrbthjYa0XzD0Th9Pt2AJQsQaYO5u7Enq8KebnSHrciyvYFft9Ch/KHEz1uZt0caa5BITrhCOr/EYMgVu8P0IOdhGJ+NG8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tDHt7BQEYtdfMQknb9JWS0YOvWlcrfnPZ0gojlnVqg=;
 b=s0hJwENVBIb2WQU2Vz2iS5HIpAnA8JfH33Gr4fl0Xa0jfxpxoN9sDcOqxSgeA20E1dRHJVQ4i5/DxQ9asDUW9OQDZfRyAcgHCNWqK/r1TXnmdC/QBRTfxHAqe6xD9hPTfKLEeRvCpB/YKxR5N9q8m4tqB6/MWftrwM1Wuwhk8h4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY6P286MB7913.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:49:52 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 05:49:52 +0000
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
Subject: [PATCH v6 1/8] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Tue, 20 Oct 2026 14:49:41 +0900
Message-ID: <20261020054948.1218370-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020054948.1218370-1-den@valinux.co.jp>
References: <20261020054948.1218370-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY6P286MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 07fdd537-69f6-406e-02ba-08df2e6df645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	OBhiIVIhtaN5WoqyVt47JXJ1VKTSqvg7/OiGwWmKYvS2NTlQihRHB3jUnvtRFGGeJORRIrMxkhJRWKG59BFz4dt4K8eyMx8XbvrtuEZ6326pgq8ZuIptF/k/7ovwTcxWpja1jMdkyCKnBvJ3UmCn6OUOb6L9miUmd3C4Ys538DyauSNFdMfdGOxoZ9cvpuh7soTP8bz4QgaRx2RTRRvvXQSd04Fs5um6jee8pIfh4xy6GOdQxAlyGD5/fK6ZJGAHeE3mnxyH8lKj9MVqmKlLQqPv3ikkqsarETtBK0pwqZ5EHnmvf6+6FeoQFBjHzv2s0wzZBcBCgXCTY+ha+fyfaqSlwEWn1n9Vu8fAhE1a3NC+Y39G/cJr8gwQ3y/Too59ZOzXPM7QAYK4x7+i7Fv2A5Zc1OPlhoFnowkF9aWTFnWi87rWJzvJOckOFFAhN9fBNhEj2lO6J9xeM8RJakr+hV1+N1ejDEEd6OBTfmYFI5Fh3couJzI7kSzkherVT8OZheCT0KjowbMGvVvRY+VT/Fp9TF3G4CFXNroVXQ5euSV6s0vZ/Z1s68D2QeXCBMzv17MeuR7ycSNyWIY6yGW8QSC08oWh8dLFRdPy6gVxertNKP56oBCy3wqqKGI2qG1xjiFwim06HipuGB+FbLH1IsDuNhzyg++Kxoyx40HBZSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cVW9S0VEbUa7O1RAUEnYkb1isvQztQSpLg5vRimXKbuBm0kjipinPGzIGTBT?=
 =?us-ascii?Q?Ma9N6kW3Gz1r6bft9/zF/tEJejkJRwZ4i/3rCgoxt4N7IPwn411U3obT8QMV?=
 =?us-ascii?Q?DyYu37Pi0vat84BB76Hl+27iW7N49caAgTLnrGZT3aOXolxMIV0HRMOT8VQZ?=
 =?us-ascii?Q?YzzVYjR0CVvWtg8QrLy99aFGbEGpjN/UwncQQK6myko2tWj8oYOgwEYXgdDp?=
 =?us-ascii?Q?+z3gEXwW02cEaxhCWArsnAiYi7L6RC3oGqGh8L35fbGmNfjwqvepQw4hr2+I?=
 =?us-ascii?Q?wsBzE5ju1Fn5hsDVs0oeyE7pSNMyUoP+2FLvnT59QQlmJCn8lwxrQer3oKa7?=
 =?us-ascii?Q?LjWFF7jM0nzLkoj8YhsKQrVvQBSmaaKxKidlvvyjhZ8mpWgLVDIERb+52UIx?=
 =?us-ascii?Q?Pc5df5sILmqmQxDDOwAin1KhKUO/Mq0nXu8GmiXAaF0ndjqVmcIqBvY3Qjgi?=
 =?us-ascii?Q?jebeOlN69+e2MC2gRp34b6o7mYv2Rigf3ajJrCcMl4kSy5lCyHensE9MylfY?=
 =?us-ascii?Q?lp/gNWKj06RbVCFQiymZuJ4a+Hei2yWWCgknLWSoQC+SXxDtbb+RiLCX8GxY?=
 =?us-ascii?Q?UT9K20I2EuREg5BKXRfom96x8fQzbF/uX8yBIL8FT2ZQimcGB5Tx0BH+MfqZ?=
 =?us-ascii?Q?9361SYoQsYXCV/kLyLzxguK/BtVC5lZ0d4K+GliAL1bE6eMQk23ATBCsD3oU?=
 =?us-ascii?Q?kIlRd1cz76ima/CzDGxwuJ8gN5QQEYeL6EfCswhQq9516hNF2JK3MHiRWWm0?=
 =?us-ascii?Q?NVHaJqJSQcjOu9bXON7r3lLMszaz2t6DyPTbub8ED47K8j0KFuyv5tszJuFF?=
 =?us-ascii?Q?pmROInrqhlTUET9xZnyrQ3yrTOd97f/arY9CXToo0aD9y8wCW/u9aexipnYU?=
 =?us-ascii?Q?LmMulj6yH1Fz9VBBteyNPs/wXcx/bm01Vgl4FfdyhFnaExu2hluY2MdfdViv?=
 =?us-ascii?Q?GamXnegvsoak/5CN+OaUOvikKzoUHoWpILaTxj+H2u6h0gbKsjFJ5muWp18Q?=
 =?us-ascii?Q?vXdWQ3cT3FID0JP+vDtYTEgdlFQOGkuLZirvAd4XaSOnYKnZtiUenUOaFAAE?=
 =?us-ascii?Q?f6rtH/NJa5SnnrUrZd8VCGZm1hxcAoIZxq41ke6IISjdGGNGYirnef16Yvii?=
 =?us-ascii?Q?UZ/XsZA1osRiOOaze/9FrBH8V5NNGlu33yvLmyIfA+xBnu9z159cqUv6Q2mc?=
 =?us-ascii?Q?FQh+XaEioCx/hwMP2ekYRZ4YZlKiQBFep1cnS/JEeQSMkwekFEysWOwIGog5?=
 =?us-ascii?Q?w8dU7SUtYuRiYw+rc/AusaLcoSrGBhtMFk2EzJP8dqqXW9Xcuu99geEUnikK?=
 =?us-ascii?Q?dpIuXfSVZ43anzK8VcI8u3hpE8q2DdxlW2+Dgri/rPUovoK4IBhtqtEnhTWq?=
 =?us-ascii?Q?7B6FHZLf+DyH8KAVNI0pSutbZy0EMR4GXHNplXPq6bZu18hv5xGY0xATvU6R?=
 =?us-ascii?Q?9dXYcqlMUj8VGem6GnX2PSfhe/shHFvDwX2INXsdoS+FT9EDOSnrP6ZjbCuR?=
 =?us-ascii?Q?sYUJ4b4KJG4yODwg/h+XJonAVL45tGhsP1rGVuEnlGH8rgF6czra7qJuxG+3?=
 =?us-ascii?Q?z7yiWXV+TnX+8YbER2y2o4UFxUxi7ZoHvgJH7HyNNaav6RlWOtIKNAYRMjnH?=
 =?us-ascii?Q?qnzo4XyLhQYJnDf/lNpUkBsMIRFcSfcrMXW7C0PJ0QKV2nOY73qwcZTx5euX?=
 =?us-ascii?Q?zmH3YFmHp88+wxYkkyAUahA9sTUe822A0MhWi6p/J7zcltA5OCJ485suNTPp?=
 =?us-ascii?Q?fOTk1wVEbGbOj+zGoVDsxK2yOjnPtdSHQbRf9wicAfEkVxHAP/w0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fdd537-69f6-406e-02ba-08df2e6df645
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:49:52.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2uCj3ocb1bDXgdfDJuFoyNm3u+GFTFolezn7IPLoGLm7KCsYcv16vdFa21GeKhOAPut7Jk1rHw2XkN8TSm6vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7913

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

