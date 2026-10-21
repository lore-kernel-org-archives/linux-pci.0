Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=40.107.74.96
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792556562;
	b=GykU834ywJPtzJDzFVAxQ0em8+EByHhqk5VwXR+ez2UQaYlsLGx83GKn5LsB4kdZ3Z6r
	 nY50z1u/0mGXWnpEqRGkagPyczHtOqghczwCw6I6Nx1/Jra1cA1zKtjm3rmtDI/CliYbT
	 QRHNnucf7pXhXL6SNGN7qhdXKcPvKn9mywGUDpXbxFMGmx2EFmnmnfgSVlEv7cMaCjxYx
	 OX/RWdj1SFTRB+0Gb1+Tl+KGHDranYNwNG47qUjXu36cok6anIIZ3tc2NnfrLtYJuweET
	 oBxPAmUAfH4n073QiNOQXKgMdS7AggxC4T2lS5KgsL5RcCKlAqbB66OGYl8hKsCrcXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556562;
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
	b=tJPFNNyWhKBaVDgUvpGIhTmkx7nwBUgRrpQCwv55A3JP/HBXmaAf9M+jGAgw2slbGoIQ
	 4bSBuQ+lLePHWZaLd60L/7ZteVa6mwDJ9+SgPH7Jt7CYv66Zr1moleM4iuEjLAnivx8MS
	 Wus7ax9hbVwffii7vDyQNo9Onu395cHOM5DEPbjdTxp7+lSQSTzd+w7hLKxsKVI1Ji8/W
	 AxMtFNPsmRBoPuRZzTMZ2Fe156fBFcD3+u0nT/pJ8E69u88YhSsPrimaArzrzmfS3Cwdm
	 pr78wEWjJgwcQGYNj4Vm79RynyWspFRt/6m+usUTM+JTC63TFafeFmaDnW1Dt7CfIZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=KxAmAICU;
	arc=fail smtp.remote-ip=40.107.74.96
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021096.outbound.protection.outlook.com [40.107.74.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6855F606A31F;
	Wed, 21 Oct 2026 04:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6855F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=KxAmAICU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=terMrw8l/zQFbDlZOVl2PuOuU9pvmVvVYKTOgrAOiz8PEsj8/yzuYyRyaqvN7RYeUK/iakykvHKoi7yAPYx0QXn2z1xTQQUsSquhfhDJ9OHB1GfmmEclgFHp2ikW+T5dIyL+yXyyN8O06TGebIYFC5s3KeMH3fxDtkpQ+LrBBSDUKeLXAGwT36xoh1JUdHFHWXESTISd1EnlxZHkGgHoM3N8cXlvpXyhQaQPts5XFcAZMrWUaJCNtjM/lLf8HsUQ4vvKAhl1WyhhV4uqhIYLVr3FjDhiknxjopF27Zj3zGGPh/NZGf3KqysmzF/d+heOUQdi+xwgua4fyF4KIXx/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tDHt7BQEYtdfMQknb9JWS0YOvWlcrfnPZ0gojlnVqg=;
 b=jMZvJoQ9TL5z0VFfZFXFR/Ydj10o0z22ecIOOqaT0brhYzwkkaijjWIZmCIkQqJxXneokHknhWqI/anC5OpnOZEY5y2TbAkuB/rigDlkxdCrNSFbncBQfT4Sq2+VpyguRTLljl4aTsYvlhzgLniYEDLLAGyHMtfnoJpPtUYHZbucElZ9GOBCILiWqdvrErue93Y1ELuC4+P9OZnAY5jSiSHMQkX4yYuLaNTy2Dfd1qvJ2nkkuVhYAUlyeQn80XV3K/UVBfeCG+4sbNta5yKxjz+9RBXHoGm+GiExs8X123FpNXQpXgISnhB031gqGT/VLv7Efvq5b81gLigI8njBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tDHt7BQEYtdfMQknb9JWS0YOvWlcrfnPZ0gojlnVqg=;
 b=KxAmAICUe4q7/IMjhn/ojbKVDai/axtyVXqUdLlv7YA4Q/Du/QTlQYU6EiIlqnBwExQGvGvabdLkvA4XGy5O7gMECiSHTpsRFpz3a1hOAyywJjTk3TPuA0r4grCyL6Rt2dOR/MiEZBfflan2I4axLrRVA9uNqvXk/N6fy6F0aYY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB3180.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 04:22:36 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 04:22:36 +0000
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
Subject: [PATCH v7 01/10] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Wed, 21 Oct 2026 13:22:20 +0900
Message-ID: <20261021042229.2280937-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021042229.2280937-1-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0124.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 301f1833-2967-4e19-b694-08df2f2aef9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Mr9wPDz6MqTPvFDZvUDURDRnzaOjaJo3ACj+aRni8vyDjdYcNbv7jbfyEqcO/573tHJa7sm4P7XAR359dyHcbhI4/6p2FkW88lhY26zpHAvW22LoAQSyPOkWOyWHDqaCueE0TF2fvDwolI0P5tT5Xe6Q4Qyu8zqyXCmYvA7mOWHP/pmLu+5wGk7BOsn9ClBDGPFA8vF/qnnL8Y1s7zNDt2oNfHBFhQb5RHy3T+DuQwAIoK7x+ia5KQwLVG9moN/B9ssZE/HZMNFWrKSC9YQ09cLSsyZk4BLcqESvQZHIUxvemp2UrHarIayrrafJBN/bBCzQdRDI6j/uv1ndUdP+gR3MPOyeirc54q9atsWFXkRvwyfwBUn8Hwk81b7NJm6DGke4HKUlonP+RJTOM+Spv5OIF5kaKtnrdLFJMPwpMLqucQxWXOAYUyKMvSpWIK661AGrSiwTUaN+oG7xLqF6Q2iVow0nlII4PH/CROC5mRpNn24zCNyhOVRlvnf4LpKhc19Sx2Ysa9AH80JVl4vgiZPL9N7r/O7ZLWPZAcQVFhRIZEXSscooJoMcdn+rC6KuOJ4S2cHYl8dQVrwpEdEGFKMHb5TCD+8uZfkbnzY1yibbAqrYEHuudQwVnymBXoXPC3aiiQGXaxYIE6l+WA7gkrhSVUNlKeHD3ZCx9JpxsdA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EcK8BaFv/ldi2mRNWtkoHrUwpq7YL2yzGYhI3drww6IARvk3swj9A2xabmBK?=
 =?us-ascii?Q?+vig3hzPJQztWHvbUmzgyLhpYZH1fH8RUbnSXiTU3dw5RxLUmors6Q6EwsTq?=
 =?us-ascii?Q?T1gichzljkSBVPE0XwfPw9sDwx2+RsJU/L1xJnn6hQGBYJr4SFnJtkJlp4ij?=
 =?us-ascii?Q?okDqKICc/T64ipms35j79QbRIsD8eRAfMxr9V6gDBrVoU0NcJON5NTYTW3oN?=
 =?us-ascii?Q?hgmEt9Qk6dDIpu3wzZNxFQmhNb+w5Dw/XBEIHzePSwOlDLFgXuBVRrEi1riq?=
 =?us-ascii?Q?fBWPO3Rcuje7fL2KGq9VtoKzm5FzyBf9aU9OlvtFYe9WMRL4EFAxFhefttzr?=
 =?us-ascii?Q?L4wcM97ZMXm/zfl8UYhnkKf95FA2LoqMGroj9rDBVI7cpYqRZOgBD1LhjoMP?=
 =?us-ascii?Q?WL9ZYhZgbI70tRVeBekiXRvc03zr0PvcOk7BYgIkxFQKhmcaERU1IL1Aey9m?=
 =?us-ascii?Q?spKISGWgeSD6QZyhbKFlUi48QRrkfGnv4yiGG3o+GcoNQy7XR1YGelz8e+sK?=
 =?us-ascii?Q?eKQtbjMkBaho+ldi4SqGSNQEi3aV1AjwzgEHEK2KywYS7hGfFSRmUV7Osv6G?=
 =?us-ascii?Q?j7PoGDsCCMe1M0XzcjkMMQDLgqNmALttDtxINsI8yXKUEoRcmPZFzgipEk35?=
 =?us-ascii?Q?WB8/Zg4xUEIBJpZL7Adk0eFXxkPiyCMQCRix5DuOnD9Pr5olvBMN2uChX/9w?=
 =?us-ascii?Q?yIyf9cMBuwQ0xSUnp1WN6JrNNL3dGFvuEfo6TV4k0YgM7HIASqSn3i3FsN+Y?=
 =?us-ascii?Q?OTsVZkmFxflzshlSn9qbdhjA/CR6lnHV/vrv3vCswAqSWmrP8h+iBkaoDW8w?=
 =?us-ascii?Q?KabG+/QRAB5zsjZLY03QoSufyMmHpeObH8F78hb6HWdgbDg9Sc/dI9TJMn6y?=
 =?us-ascii?Q?evYVFXfu0ml5xXH7e9dfGRwIMBgXmtGAhPAsNw8WvGoyHbTswgQS59BzIdqW?=
 =?us-ascii?Q?t5Llz8gSiRTTQrAlKcVJT4p9NrYkkfTphn5VuJM5oeZeIgVcHgk0dndRrk4m?=
 =?us-ascii?Q?M2zAR3Cf61sLOu1HvNoQ0E0Gu8KakqU0Orolf/zEr9aRpvRp2BImJrWnWYwn?=
 =?us-ascii?Q?Gl8QFJL9eIxVfDBOwm2RSNQ4i5k29k4LUuSn6jFRzLtewFrpvNPsTGVPCM8T?=
 =?us-ascii?Q?z+XpU4j+gCnD8/jaKLdrqmBPfQbEeTi1dhykb5C4zDL7egrRSuiliqLSH8uB?=
 =?us-ascii?Q?UdkpMEGST9qY7yN2CPeiGq3BN97l7oTh+TYKoXJxHsymewFpUoFlWOmQXpDZ?=
 =?us-ascii?Q?AzNIkKy/2oWy94QJ5BRbVIfL3iujUKc6DJHeQohiXylv3qrbLrCVj+37oDSt?=
 =?us-ascii?Q?M3PA8DAm+dBg4p42bL7UfIt6XjfF3zWH+OE9AYSsw+PsvL44eAKDZ8UZxkDS?=
 =?us-ascii?Q?SyGqPc1N95VDi7xTHeI9X42yOyAXLD7Kg0pIWwm/wlr3UFswhykTZSi0ZoTA?=
 =?us-ascii?Q?eQU2RIYHchOrnpNxPos6317NSK19zPJFMcu4wC69gQTlTGAzw4gmPSSoLy+o?=
 =?us-ascii?Q?gCIy0hOR8/3GWfxV+xnGuRZVuIVT7JRsWxetcWTnl/ANMD2RkHoMbLthKOLG?=
 =?us-ascii?Q?mAy2P5pQEM7sL9IlPqkNtSD0e7sqAr/EqzzzMqQ6/6LO7eJijry7NMfIHNnV?=
 =?us-ascii?Q?sC6Ww3fdFD/6Zx5HiZ2oPClfPcj4SBAlwuFZkKpUXJo731hDH/y9nYjdTVym?=
 =?us-ascii?Q?266CbGsIfuEWEQzzOGq5NG53q9OmtoCOcJ2A3FE0vjLv4Jrvw6zVd8YwR8kf?=
 =?us-ascii?Q?+JA+shy6Z52JquQfVmgc4o9+/gt0F+7azvjV81yuwcs3UdrG3W7z?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 301f1833-2967-4e19-b694-08df2f2aef9a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:22:36.6477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jA86c9uw9qnuq09z8z0QMq23yiGC/m7bfL5PEua07gB8tDQuTDEwez10Q4yiL1yoyg7Cuc6U3qVUxZ7a0SlsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3180

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

