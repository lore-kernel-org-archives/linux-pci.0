Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792657357;
	b=L83GigF1N0HgcyIF/VeNJnyUggisIisX9U1YirloY+veDxillf/slluqmdfUPw3ukqBS
	 OfNt3KcWXcPmhP09QRe7qOBEy61f+9isIQNTy3jYDKDCaqGv4jD8c1is5ITHiEkD3It5Z
	 ZTXVXjp0HnJEVZ6E4IE2873gbgWrqjgC1U8bTOY2/0f+wjQ5LkdKCzraLLoXHu45lYgD6
	 ayXNIk3TyqQo/uAp2PVX+qebSONk2suN8Hi9r2OGRNM0OH3VCjHVomAEW0o26GJK4Voy/
	 sbwlEP3t0eUD8aOz42bSBYdwipykFWh1dBKHSOl8YwQBneWTmD65/3d+ev0YzAjJ5+w==
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
	bh=8tDHt7BQEYtdfMQknb9JWS0YOvWlcrfnPZ0gojlnVqg=;
	b=1KCMe7juUj5xdxOI5Hm5ook1cOZOMiRGc6awF6Z61xAYrHI9jc+PQ8MVFJimhD7gsvFA
	 utPMSC4tJ5exg6z8TYt7kR7dZkVRE/SdcVxegVCsezTXcaKCJGIXWpxC4JtyDLMP3C/5t
	 AD+uDaZbm8ITSLlzgqdzDTvt2HRQzqCkrLVbZI+88MTl8a9tpTDwM8fUKZVCWooCZisz6
	 KRzpF0Rc2RlYoEP073R0Z36iRrDsWU7MHaaZVGobGLqttqqmb+9LlYR7699AnK0OoIKX2
	 n/eFq5DHpGMPBeXE/HapJemlJFGmuRFjBPYZY1OCX3/T4MMs6m27U12Diw/GPWXcMFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=qSUSuabU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.110
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021110.outbound.protection.outlook.com [40.107.74.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172F606A31F;
	Thu, 22 Oct 2026 08:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A172F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=qSUSuabU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbiG5x0V2y9+ODdiHSVBq3+S+vNi8O146C4eqRdeJFpq697ma8wrn7ihpqpXmxeXVcATGMGTKric+1CpUuUPUoD0itAus/xYXRlvtwOu0ClHYIV9aOmmJLHfBd9ZV796oqLfPZZuePs8Y2OtD+HDWdf5C8sQRcuG3M0esRn37pRA75s6RNTnheBZFvAQpMI4Bb/ftcHMO2LLHHvN6+xpK2+x/0WEGha4st2Q9yQoJFuU4PGypl8euZWOXYROuuDOpnQ3bHoXfLPFrks5SBWk4jWn9IKzyr9/94EZZq4sB9ShASJTTI0oim2kEuciTMymXkuoW3Rt8//K/UDdLw6yOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tDHt7BQEYtdfMQknb9JWS0YOvWlcrfnPZ0gojlnVqg=;
 b=Pfq8jD4mHP+sDanTwvKGAa9q6gxKJ2KB9CyOPnrUq/3ig57O+QAApDHJN+VhQSPNdWek5KI7uvjF99TTYYt0hK6Q2PTw5qiWAwJCqV5iAjS52EQ/nyacgZpM29Ggw59d/mPKMFOLgcuNgQwgrEh3SWAZNrmxzqRsaqi4nk0a87BuZIbL8+MdJnCMKA4ks9g38Vy7gH/e+r2dTCk34/Gw769+YUfHqXbGgVnQnjmOJ63YQSeTB2ZMjGhdUPABKDNmr5OQTNPmQcxnuN4bmQIZQNTQVUeD9tMmyjXKhvW8YDh2r++z+UsksRD0BhVpmxUJ94Ld3SVXYbZ1ruFB0DpvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tDHt7BQEYtdfMQknb9JWS0YOvWlcrfnPZ0gojlnVqg=;
 b=qSUSuabUAFIYDMehS5BJG6/yA5ql1vo6gyHfcX6iGrcbUjOXI+C+RDK8jF4PZnVEjEJlyyjgE65nPXpJTgP13Nwdv5lcS2wYjxgeV59PjuHUAfHG6T9kCGGhwJdkEmAztqi9kK57vvfQ8enCy49CkFI03XxI8FFB52EvAnG/C4o=
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
Subject: [PATCH v8 01/10] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Thu, 22 Oct 2026 17:22:21 +0900
Message-ID: <20261022082230.3164834-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022082230.3164834-1-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 8078e212-e9ce-4722-7482-08df30159f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|23010399003|1800799024|6133799003|18002099003|10067099003|261021121427099003|22082099003|261021123027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	1O0nF/3PtaKvkMe2xXHmdtoo6WfKbCfUmTcie+iA1OvcUDJtefozp7aAZucJ6WlGCRNmi/SDAETD/wuDvRgI96Oq3dxA6nugrwPnnIJbnxzvqdUyWqqlhoKxXxJ4pbfkuJlH9Q1nxVmUH0YzD7DTm6JIczPiXP1mK5JVxlGh2Iej2G9DklVxC93KX0BaXjaA9BHzyjXGT0h+bMP8F7WCGF2fXILo+fQriplIdiVtFoT7BHarqgUvF6kWWUy7S436gklRPDwf37bvuGhV2hbFuTObBAJFI5FmamGS9GEhvcoHjESlX8+GYrjT0aVHxw6bznTkcCGkKI0DsJAQaxaKfXI+ffOkPjiKaFWdVA3HhjG8x4pk3jCbY1GUeKIb/E2UJw2Uhw9ZAM3wBcna+GatYqJt/cBz+OdLhWZO1EoMLCwqeuNGbqziYaU3bYv85RCUfM9dn7Q62IqnY7FVTwo+1/lCQHZIow6bIcCxRQZCCHkZNrmfcVG9JQ6kGgQ+l34q9xe7giv2PyGokL4IPIgqjm2X+9mizWBrHRLy3g8+n+4jVuXew78ajdsU57mahcfcU0vP7bhfYKXvlgc8bAvftk4+q+wmxcFGghzjbfddK1zYx9ZINxtFUL3NIn7NWrMbKoox7mHAuY6QFEfVuxWHjC3stFYimlDJnPVxGfC6fsg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(22082099003)(261021123027099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KrxTnt0UTeD+iWIhxuhlw1ms86F7hUBUI3CxLrd/9AdDVZ7CK07FCdw6i2a8?=
 =?us-ascii?Q?5bm2ax41romYpFka8QUUSWwJBtydoSe1lE/tAhyamZ2Q9f8m7OMIoH9EIRYa?=
 =?us-ascii?Q?ExDQzGqM+QpoFdv2bFFW6JLRnm3tKjrZsDczQPGkM11gwYuapYFUnFGhD6EF?=
 =?us-ascii?Q?umMQQvZKwiCFjnJZBd7GEyu8ziZah6TDnHNR2YZU/0FYt4i1m0icD71N7alv?=
 =?us-ascii?Q?zBJZXr7PdhA+e4i9/WrW7fJokU1e7Br/8NeshDHRzlSsVxg5CsWd6gkCDxh7?=
 =?us-ascii?Q?hjgWVPkyEw02KYhbK569dsAy+IYN0WzzxHtM/Oyuu11HHtPmXlHw66exhUY/?=
 =?us-ascii?Q?mBEPaH4PPnqyHMmKjHyGO/Wtm68sDht1jMEe0Ncq+CjVenv3FEu5S31/rBbC?=
 =?us-ascii?Q?/7saQ9qikIR1ObOv+qWbKkKMTnw6FrY2HeClqiSj1VP7BCE6eQDP1jKRshMn?=
 =?us-ascii?Q?G1WQuhNz5wfV1+wjNXTEBnzUGfLahbvbeYzyZY2dHlMGJvqZC2dlCReRCRo7?=
 =?us-ascii?Q?Uc7u4eXIR5iZnaClItkKnJ4Mt5MmwPM276exadSmd+XBOyW3AaZ4KnEz0/rH?=
 =?us-ascii?Q?3rUs0Pll30v3B9z1aktMhjEcynZwSHnuD44tCNydyhyWs8POiIo9vm7YOU3u?=
 =?us-ascii?Q?LfouZe5W+OGKRvKQtLCNLsIVGAX9Ub48b5rkFWyvjM+u5cGa6efqlxf4qFYf?=
 =?us-ascii?Q?x/8M2RCrSoKYOEMgthiCTdUVEOoEPd9vn+ynMYf0Z9RqGrHyv2hp2YKfPiF6?=
 =?us-ascii?Q?VhSbjIeUEWUmcEf3RHbJwHNdGSiU+j3H+CCNIKoyYGpWT1eVo5D27lB+wzUL?=
 =?us-ascii?Q?2VvU6YIbtnMHwhJ++gy60HusYwyPpdMPL2az2vcwmGCgo+BCJLa92dl7DWy4?=
 =?us-ascii?Q?xoXqQHNNvRGxZugdkDcoEZCdKGFdPlTocINasTnJMS9a5ejIVu6Esmk+powT?=
 =?us-ascii?Q?9h8rjW17w1nsCKjnuNR/SOxFrKeKNSsSSvInGPRrTS6H3kg1p9F6ZS0s6wWL?=
 =?us-ascii?Q?TfH1DJx9MjxAaiGQNi+XKcImdPcJvxo0ateWngDFEfR6dk4vbtxJRx4o4zXJ?=
 =?us-ascii?Q?HPCVZtqXU/fIo14Wp25TuAzmCvIh51xABTuRoUfZN4h5C68ldxt3FlJHkPuX?=
 =?us-ascii?Q?LLhk2EW6yQO+r8XMRov3SJiH+1Zekl13jJpEMZ0P4nRbPmJ52iih6eXueZLR?=
 =?us-ascii?Q?U6SDM52EzEV1k+H4xmEJcnEQWl4329C8cyWCb0A9Qq9LsXoNSI8XRKhKkg8q?=
 =?us-ascii?Q?LzP4CjgeDfgP38xUQq8B8Lu4eoXOEnU3WKMSbI4SueseNdhDV/blzJCIna54?=
 =?us-ascii?Q?bWZFCqrqGiq/5MxLyEpZmkLyyrKucx0prAUsMn8CKjyrCDaFa3sWSwuPbd1O?=
 =?us-ascii?Q?mo6yjWYOkBHcAB40oGnJJyDEh+0CObBC4836gudypKwcmcQVjxYK8HpiycS3?=
 =?us-ascii?Q?5zXUVvTZ7a6ikKjX8V/mPdLq7siJNmy3r3BC25tipFKUUrhafIPcRRf5j9MI?=
 =?us-ascii?Q?iEANo54xr08qW6NDVJr/Sb5R4VLBos9yPZOZCTKs6BFcJjrYUKWr+/Xl3Yko?=
 =?us-ascii?Q?MOxHnlNDboX7/dlnWUbD4vkIhD14izxuOikbuMT5w/t+bNNFpXgh1kQMZ24T?=
 =?us-ascii?Q?HCnd264V0tNBOWZi7vH+x0qCzS479SVx0EwZiA/UNQBHtUVbLzN33K3bajbW?=
 =?us-ascii?Q?IzHW1d8pDICdDh68BNt1E1XGiKA2XQ+jUXaqsZDJzYd//t8XVlyZmMSVxIse?=
 =?us-ascii?Q?FdhLQn6uVheFhKOAS19vJyCJxYVB8BftVaSEYvXk3vm8znw0SRt/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8078e212-e9ce-4722-7482-08df30159f78
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:22:33.9140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhQ7V4o5TRvwg1u+YvPGs8nU8cSXa4tdg8hUB511uTa27OSb1h0roS03/Kpc5biHORVzKczmtXz0uTxE84N7zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5275

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

