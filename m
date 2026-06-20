Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021087.outbound.protection.outlook.com [52.101.125.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2412773F7;
	Sat, 20 Jun 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975106; cv=fail; b=IOkxkTq0to5jvylO3W68UNbhTXSXiaqgaYloAlMOo6Uog2ZZxoLJPM8WqWDc3Os918nOwWnwY38R4GAAO6eFoDOJrkiuan6SzthSOhvu3Qwcf9MfRQEXU0e9NXUg0rB0qSIKOSBR5zEcVCoMexeZdrB1CmKDCeilsNagDXcms1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975106; c=relaxed/simple;
	bh=4Z8xUk3MGLz33BzE/3JFub4qHYZRnqf2c1geLsLANWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mR1mlyUTDr2cxruC8/lMZmLJRcUl9WYAxQiffmBkCptwlEoAdezvhLli4upx+Fq+FXCebKZIBRV9FYcZpde0UPHZTdY5nOB+PDKmHfDh7i4VTPrBggqD/0HM66Mz7B3tmhqFVbQpaph0N1yOsKvWrrLK444Swu4QJ0iKkKKISis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GNQnNFHr; arc=fail smtp.client-ip=52.101.125.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GNQnNFHr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qv5Qhbk5N+9UhXfDCbly8f7/RzQxx/Dwkm3b+eQy75s8qe3qvZxRmm3+G7ucYVszxpRTQ4TE6P8JlhzTSQ4TzzTZ+JaBt+4966+ys0uzb7iM/iYVF2j/MfwxZ+AkYMx4d1vx/BH40EBWbGTZ+c5ewJJYjfPv8b6/dgOMNJO7yT58L+C9FujcEM2ITppJDVEsbsVepENwxBr5IxPBO03hiff/9JLFmKXrWE37G2aoy0TNP+lD51lyegubYmY46jjP1zCA9iwSBgUTJ4gWtmK/Dq8ECvqfuMhSAPe0PomnxRReLvhsJnE+a3YXDTctAp+VG4R01mIKiwNysqXMjm6UoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62kG4m7JeUIJ1aZSy2Z/eNJmc+3qVULLX9/3sE3RHi8=;
 b=J/WhP1HWKMimhwExxhR64zK90XJy0GlCCB0q/xLXREvhvV6JzZD/ovQVI+ylW4hgjkFhnNuZ2UY+BVZ+L0BHXiiZRERyvDPEpmiBhtwAIhtS03zjD/6QpStW/jPIFPhxwfdNwhD27vUindLtTArxKGKfOhYIAHL1Jvy3j/71q55HlAQB6wmrPQznVoRkCBAWu1Tf0mVrLI53cTFj8wQ3MKtAbHeAnqIEv1OFhlvteYMiN1AzkEPMssLIH5xoFIzF7frFFw2PMb7NlBjVU6P1tOyfZXbAtyuF/tnkjoFR/GWwXag0GBPA3Lc6OR7ssEvAo+RnC9qbgzSVDlEdYDHp9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62kG4m7JeUIJ1aZSy2Z/eNJmc+3qVULLX9/3sE3RHi8=;
 b=GNQnNFHraJAbth+W3EDfKS/B1wlYZHya5g5crWoiJ2pdGJSbUGgTobWHas1i5Bzc4omM2/GXaT9Xjl2YAdqEamUfTqnQENfr+X9q7Xmyka0K4WmwdNyDZlzaEe3MbRjy/4g/3ZSQ/TNnlkP0S8QDfOurtB9JLiaSObO4g93SACA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:04:58 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:04:58 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 3/5] PCI: endpoint: Add API to delegate EPC DMA channels to the host
Date: Sun, 21 Jun 2026 02:04:36 +0900
Message-ID: <20260620170438.3756593-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170438.3756593-1-den@valinux.co.jp>
References: <20260620170438.3756593-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0087.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a06ce15-5c88-43c5-ef2b-08deceee0ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10070799003|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0+25BHOY7zfPXTeBlnAXfLZc4JUzcM8caHfdaU9ZOzw68yCIqoOe4763HspZ7T1wjb/pD5oJNawgq1KM0ku2OoFdW7Lcku01ulhPA+ZMCH9dMhIuxEGE0Bg9GlhIYqds2WJ9AGG+KDvxFa7cLgGlhAlp4WRa5ZaY+oSOH20sj0Xs2DtLmCR1zo23A9e97Nq8CfCPssYzn/I0GYNDNosXmHOL6rJCW/YtwfpQfCh2etZuXG3Z24XZ4y4cIxtwkEgSYDcryhzeXoiBxvRNGPLrK3tH1lCPhqhRSmQiSJ85lCFkeOHYZyrSrzp1xQHf9GFhWxO7E2M5tyWNA5bcp4gv+pqdNU7ldt/8l5TYKZrQ58x73c7ESZuYmJnkhjaHfO8nci+v59jH8trbJu5Njcck3QeQ8GTgvlEnJ8dFTQ0mxnM1g1tDBDLlE6mHK8m6ODu1Wzk7ZjFbHpb4QJV8ydNxi1NjfmGd9XWoK8Xnb3MAz4IFjPnmOhXifcZa1WNs7y5y/C443QCrFijU423M+nZwU6/Xq65sgY/llh7DjJlq8d29dux4lc7Ok6x+tdQZmyXaILi1FEZ1v18dFGoP08XH4Zc4GIy818wJzlpex8Uc/Y5W6YdHnU9w09ZNnqg0FMu6k+h9eL4XH4CnfF0j66y7t9TrzuIVvD9j5K+ATDn72WI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10070799003)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z/dsJjVx5lFhJ5LvcHfDqAf3/cyHTtXDV32vOUu7K/k9rMfKwnbbtTgNgm5C?=
 =?us-ascii?Q?Wh2Kwd3zU3KfLgbAlF8m7B1BZFszWjjV+mtBCSf4wo7gIt/eRmtUrx1247Vf?=
 =?us-ascii?Q?zVzU1NPQsmaVfpCN0yneyBeLnixG22tNeFPcvudEKMRLlBplwPtted8C4KFC?=
 =?us-ascii?Q?Y8+11XlcIb3Jcz1G8gJmevcrw7f4/Ig75pE9Hl8FrXW/4A6uWiqa2aCzHuol?=
 =?us-ascii?Q?r3vTAcOz424dmgqXoqCgxSYrbk/ad3Z34p4KZxEemPS8NoQKIxTOAaQYTRsN?=
 =?us-ascii?Q?ZMOpbIrgwRAhegjwGgJuZzPKI/YZqvB1/UOkNC6+EPYMOsWlbzVWAABpbpmL?=
 =?us-ascii?Q?qVNSwZgr1pLF3GviQUdJcc16XY1C4MOQIU5vH24SEmQROMuTwHJQeU/I7O0G?=
 =?us-ascii?Q?+Q1K0K45gbxot6O2Od9bi41EP50nXz7loJ4DtOhRqvk1r5pky8PsZs/GoCd+?=
 =?us-ascii?Q?yyV6dNG6S/Kg+jlGNrBSH469kNJvDYiHDe3D7MlsGy9DXLD26APfyPM/k2cq?=
 =?us-ascii?Q?T4km7bUVkcHS/49NegSiFPAaV8MR+tH6aVLuqRcW73xkvjLh7h6/IXeib2f+?=
 =?us-ascii?Q?LrHsWm6aENXFzwtfD3KPZotIplQOxtqFR/pcGhDGrgmzP/KjES04dzejmdnS?=
 =?us-ascii?Q?SCPhxnwbP7DikZ68beca20NCZ0Sz8QGHnqN8BOFeHLvrT8/wECx16JajStry?=
 =?us-ascii?Q?fWwLyUz2j7F0bD2jiI0PKA+bChyuIJhxEAtat6fUXWALJqJXt6BhIpOBpbTG?=
 =?us-ascii?Q?WbBharKZEmwCTPtaQJdHSaNaKt4xBCqFtuo9JG2bEr2VZIgIQ0fDRxQOyxYU?=
 =?us-ascii?Q?/BgGkMIkMW5NPnmXfJayQBXWV3SWbvGJ9RBjl/xQvzb0Ey1lOEG5ERjseZta?=
 =?us-ascii?Q?eDJQLGqUjBnYVk5xbmxyidXgfKS5yK1FCdoJ7k0DgpncFgsLY2DGvrk9mDT8?=
 =?us-ascii?Q?m9X1Fje0Dq7c98HXoaB9TVtLilPyJzuQATDTiduZ6Y1yARAB58TC0dpDn9n6?=
 =?us-ascii?Q?vnZacIv/1dsuEo9xiTbN70PiamB/2Jm9i2agJQcoiyW0srBAt4+x7O+5MIFF?=
 =?us-ascii?Q?8dPaf53hHwoVHJ7ODs0H/hHEywvqCcBAGpDh8mr6VFG/8P6RNkElRM9HjZGs?=
 =?us-ascii?Q?fx8Bn1PT0JGKe3mUTH1Xwilk5p/wQbC2xfpWAgPdkpKZHaA3yFqXzPpw1uHT?=
 =?us-ascii?Q?QJr7+IGKnrDBX+ScgG5VvnOnHPG5Jeaxf0aPgcZoIn3uSpgkFfc0K7UQLQzt?=
 =?us-ascii?Q?SDhEU73LQtJRwi7e/ohVv1gCRK5S0r7JmzH1JIjWqmMAtdBgRVgPrqy/oXu9?=
 =?us-ascii?Q?wiWgnn5b7JdyQUlpk4DmLTirr5bVFhq+nqdI5bTUQAdCCkYwsb9KO+nG4UCv?=
 =?us-ascii?Q?T+vyNLdCtsmi04vMuTiibdHOCglvMOTyGR1RDUA8IMP4USrIRm8vLMh/xAIu?=
 =?us-ascii?Q?CF3H1Daept/ZjR3KSRnO2s9CW4fUPU23pYucQInRYTwOm45+f0Bn1Lm6SEce?=
 =?us-ascii?Q?MpTCuMR0Sv3RJ8ERdXcr/kc36N0bOau5mZ3tiALVsOUeI443FZtsHnHhLF9v?=
 =?us-ascii?Q?LDCy1o7V1HqaQX2AjcxI8jG/ZnyQwihl78r73S5RS03vR61+IDbCkyfrcw4u?=
 =?us-ascii?Q?aEnlrEirm37fycV4JUZ6zIxdXVmjMYezo2VqkESUsatNMS2R6Y9ZRXbdgGLg?=
 =?us-ascii?Q?M2fXkoIFEDK+VwH2DPIAzifo40EtMDLlbZm8jhwBJuMsjkKCsfGJRG6jkMCr?=
 =?us-ascii?Q?gzdjIUEAByAffUNA/8021KRzaFyM8HemYN8lY6TEpxGgMxb0UclI?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a06ce15-5c88-43c5-ef2b-08deceee0ed3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:04:57.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApR0yUH6H8eiSlHKNpbPkwb2EsIvBRwDhzUhIP9wHWBYKQwXjzMKFrkUJP/GeFoqs3VvLwPF6g0hVO3j8L+W9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673

Some endpoint functions expose an EPC-integrated DMA controller to the
host. The endpoint function should not need to know the backend-specific
mechanism used to reserve a channel locally and hand its programming
interface to the host.

Add pci_epc_delegate_dma_chan() and pci_epc_reclaim_dma_chan().
Add matching EPC operations. The public API returns an opaque handle, while
the EPC backend keeps any private channel state. This lets generic endpoint
functions delegate channels without depending on a specific DMAengine
provider.

Let reclaim callers tell the backend whether the channel may have been
exposed to host programming and therefore needs to be quiesced before local
ownership is restored. Bind failure paths that only unwind local
reservations can skip that backend quiesce step.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - New patch. Introduce EPC-level DMA channel delegation to replace
    v2's DMAengine filter-callback metadata path for generic endpoint
    functions.
  - Let reclaim callers skip backend quiesce for delegated channels that
    were never exposed to host programming.

 drivers/pci/endpoint/pci-epc-core.c | 100 ++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  14 ++++
 2 files changed, 114 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 831b40458dcd..0f71c4633ee5 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -18,6 +18,13 @@ static const struct class pci_epc_class = {
 	.name = "pci_epc",
 };
 
+struct pci_epc_dma_chan {
+	struct pci_epc *epc;
+	u8 func_no;
+	u8 vfunc_no;
+	void *data;
+};
+
 static void devm_pci_epc_release(struct device *dev, void *res)
 {
 	struct pci_epc *epc = *(struct pci_epc **)res;
@@ -236,6 +243,99 @@ int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
 
+/**
+ * pci_epc_delegate_dma_chan() - delegate an EPC-owned DMA channel to the host
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @dir: DMA channel direction relative to the endpoint
+ * @hw_ch: hardware channel number
+ * @chan: output delegated-channel handle
+ *
+ * Some EPC backends integrate DMA channels that can be exposed to the host.
+ * This helper asks the backend to reserve the specified channel locally and
+ * place it in a state where the host driver may program it through the exposed
+ * register window.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the backend does not support DMA channel
+ * delegation, or another -errno on failure.
+ */
+int pci_epc_delegate_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      enum pci_epc_aux_dma_dir dir, u16 hw_ch,
+			      struct pci_epc_dma_chan **chan)
+{
+	struct pci_epc_dma_chan *epc_chan;
+	void *data = NULL;
+	int ret;
+
+	if (!chan)
+		return -EINVAL;
+	*chan = NULL;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+		return -EINVAL;
+
+	if (dir != PCI_EPC_AUX_DMA_EP_TO_RC &&
+	    dir != PCI_EPC_AUX_DMA_RC_TO_EP)
+		return -EINVAL;
+
+	if (!epc->ops->delegate_dma_chan || !epc->ops->reclaim_dma_chan)
+		return -EOPNOTSUPP;
+
+	epc_chan = kzalloc_obj(*epc_chan, GFP_KERNEL);
+	if (!epc_chan)
+		return -ENOMEM;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->delegate_dma_chan(epc, func_no, vfunc_no, dir, hw_ch,
+					  &data);
+	mutex_unlock(&epc->lock);
+	if (ret) {
+		kfree(epc_chan);
+		return ret;
+	}
+
+	epc_chan->epc = epc;
+	epc_chan->func_no = func_no;
+	epc_chan->vfunc_no = vfunc_no;
+	epc_chan->data = data;
+	*chan = epc_chan;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epc_delegate_dma_chan);
+
+/**
+ * pci_epc_reclaim_dma_chan() - reclaim a delegated EPC-owned DMA channel
+ * @chan: delegated-channel handle returned by pci_epc_delegate_dma_chan()
+ * @quiesce: quiesce the channel before reclaiming it
+ *
+ * Reclaim a channel previously delegated to the host. Set @quiesce for channels
+ * that may have been exposed to host programming. Bind failure paths that are
+ * unwinding local reservations before exposure may leave it clear.
+ */
+void pci_epc_reclaim_dma_chan(struct pci_epc_dma_chan *chan, bool quiesce)
+{
+	struct pci_epc *epc;
+
+	if (!chan)
+		return;
+
+	epc = chan->epc;
+	if (epc && epc->ops && epc->ops->reclaim_dma_chan) {
+		mutex_lock(&epc->lock);
+		epc->ops->reclaim_dma_chan(epc, chan->func_no, chan->vfunc_no,
+					    chan->data, quiesce);
+		mutex_unlock(&epc->lock);
+	}
+
+	kfree(chan);
+}
+EXPORT_SYMBOL_GPL(pci_epc_reclaim_dma_chan);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index b86d46411065..84b37d7eb124 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -13,6 +13,7 @@
 
 struct device;
 struct pci_epc;
+struct pci_epc_dma_chan;
 
 enum pci_epc_interface_type {
 	UNKNOWN_INTERFACE = -1,
@@ -175,6 +176,10 @@ struct pci_epc_aux_resource {
  * @get_aux_resources_count: ops to get the number of controller-owned
  *                           auxiliary resources
  * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
+ * @delegate_dma_chan: ops to delegate a controller-owned DMA channel to the
+ *                     host
+ * @reclaim_dma_chan: ops to reclaim a previously delegated DMA channel.
+ *		      The callback quiesces the channel when requested.
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -211,6 +216,11 @@ struct pci_epc_ops {
 	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				     struct pci_epc_aux_resource *resources,
 				     int num_resources);
+	int	(*delegate_dma_chan)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     enum pci_epc_aux_dma_dir dir, u16 hw_ch,
+				     void **data);
+	void	(*reclaim_dma_chan)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				    void *data, bool quiesce);
 	struct module *owner;
 };
 
@@ -444,6 +454,10 @@ int pci_epc_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      struct pci_epc_aux_resource *resources,
 			      int num_resources);
+int pci_epc_delegate_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      enum pci_epc_aux_dma_dir dir, u16 hw_ch,
+			      struct pci_epc_dma_chan **chan);
+void pci_epc_reclaim_dma_chan(struct pci_epc_dma_chan *chan, bool quiesce);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0

