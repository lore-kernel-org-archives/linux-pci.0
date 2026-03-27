Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020114.outbound.protection.outlook.com [52.101.229.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D87371CE7;
	Fri, 27 Mar 2026 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583678; cv=fail; b=pgLgBP1AqJhn4EuNdNMVLnvppZX0UUxfZMYTvMoajFabRDBcaAJqXW8HWC5ozuxoMcg2FDsssROP8UVyfXteeyM2oVDHkHVLryvO1AJk0GeuXeFt9fZjlOgYFquqmjgHjT8ous/PJtN1KV9PhDM+AvcrAnjHBlzt8qQNaWyhTA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583678; c=relaxed/simple;
	bh=a/8hsKyEISoPr+dCulGaSqhThqZ0bY0QVVuFPBZ7cmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ggxpE2bmSr+M0KmDAx62cyFbBfwUtoXvGlYD5eozLftgys9cIhvEjGG4XBwcv4xWxlzCkZmom5uE9ExOMeNawqAG2PfXbD7OaqLziLW3b0tg9+fsF8xHV9oOdZ68UywuGJEja/i4MRcKSbIcWxh/18z32n0A/Secyd+sGMHUwf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FXuxWrTV; arc=fail smtp.client-ip=52.101.229.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FXuxWrTV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wzhpv6MgYAvMw6rdgH/RNzZOc0TnPf7w5BMStBPOsfnf94BzP8fy80dQSvFAX+Qpx3bFmfRW7CR9Fb1Q8pGJCi+/ziT0cXj9bdreZ5Vn3cIevxueQbN39ZmtlZTXEqWKr2ycdEsTJ973PfNupsbIRKg0OaStVowZygQzyxO1e19sbeuCVwJf1vYx4lkd+hrI9+3uchcdirfqv+Qd4ouN3E2WZ0qZs+Ib1Cox0npfgCYZrJWUG9dY5cbvAAtjYql1fi2TOqxjoMOcrsRF5HuvsAr6SPQWUS4AEd6e5CkOywdZ7twABvrwSTEF4WZl/KYSIf+oIyDllPVRwHHcFLm/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiOF/Jna8t4zNHuJYK2klo1qxQCLAzs25HB7Vjw7h+c=;
 b=gGnHIl4Jz3sNw92EU2cV1saYSoyddZfSFMB2LwX4LE6X9YGhF/wNP6FpHJkaxWOg/wQG1Km7e9YkC4ujTXzRKH3169pO4WH3q25+RaJnsEIktBUjLVpPPy4jxwfrBWeX5hZqJ0sJWy7MQk4VCc4hq+yblXXzYs7YSmP5mgJTJQuLL/MFbc4SBEghpgaPhXxdLY4wav4rMH9CXlCQOyEFIkMbqamUOJwCThvY5KDDukO5uF+YRJlJ1i3Q+vAzAc0it5f8lUoAQbHWu1Y/HA6084nY9HvFhHypqF7jvEpoL98GucVJ1qMjW9iETxDTNRQMJr9a898iak5PT83OxNBZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiOF/Jna8t4zNHuJYK2klo1qxQCLAzs25HB7Vjw7h+c=;
 b=FXuxWrTVegeCkQ6ysX31id/eBrCLWcirO70ApMo1vegloBfmAeAgpk7mRqp9QaXhWVsrucAFbkUX7Ri9KlbPxHvvYz6xZbmhqXJMIjJJEQ8I9Qx4t6Nm23R0eEQ2wxm0fj9vI/VbtweD3S+6a/w63zd6sMJm2Rku0QnPOm2Y3zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7090.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 03:54:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 03:54:25 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v12 1/7] PCI: endpoint: Add auxiliary resource query API
Date: Fri, 27 Mar 2026 12:54:16 +0900
Message-ID: <20260327035422.4020455-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327035422.4020455-1-den@valinux.co.jp>
References: <20260327035422.4020455-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0048.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: c7be07e5-a277-498f-0e69-08de8bb489e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	sLVZ1SGp4jDHamTr9Ie/jsyk26jv4/eVmS+0WPA2Bf+Dl8JZNOYVL/nFZ6+Cc5rFmIVa3eujCZxoZQLcKtMvtGvTRxNDhmUhFeTKkuOjOdFCu3K/Gp/6RbFckrHdchS/vbXF9All8QyzewuD/OTT6au6JNnuuEzcJPwKZM/hOEoEx4b+NUzRBrIPlCrfLpNXM0/SNdcAqVNs3EA25rgyWKv2OVkOowQn3EIltvmxNQHZRnEEs8Tore83m9ewGiDqG6Gg3TCOKrcHOYcXB4/0oCP9A9OSPt7e9nDypWB7gy2Ta9l16wAeMj+rX7kToXg+ICXoh80NLaEVJxURh8GsckMWQ6tKMF1SxSDhbgwEAGvhotHdzDSYzWicvcs61NsKNrpY0qQJolzQhPI96uf2rloOmsXVYdHGfbkEps28O9wzJmNThQHi5garnHcQZypSRrYXveSq/KsO92ORk6YmYn5cDabZ7AuaN5vc2SVRioaC8jMZwmkX5mJqAArXCCidrEW/8bkR9XjoOayc4q7QrXo0es62qI1oLeH2zri8nJEdkfUOEePtITCzRDEQc1SbwfrnxllGTxsjKh9/1DPOSmP0dWEAth2oKc7SxKXF4rFEqy8IB2qLKLFZUUtSBaKkXpa+/IXSwVA0FgucD7s0TMg1R6uya9fU2S8qliauLucDvtZHno0ghYgBZZiXBm20TPieVo0KyYyEdjiGz3l1F5Uw8A1QRtLVHp2EmNdzP3Tv3CcwYrEyLFOAYIkPS4GpFmLtLBCAQzriulvvynbzuA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y6Zq50sT7JvYaI+g5cpftVZd+IqJ4N6XPQlEv7xSS5a+Ps4caS1nk3+ybyGv?=
 =?us-ascii?Q?UCQndFMOJYAJK0uSYHhANuVdxspzH/+R0U8FrsCBUtEsoqnG/lhwoXuOQVvp?=
 =?us-ascii?Q?e/lgxXNmugxefwC2QJ4TtRtlSXcGwuOgDfFx5jx+3zYCISSMj1QE+hZn/P4O?=
 =?us-ascii?Q?vpUOuiJDJBjhwBuRD1kVVYFpE9aet8vJx+hkOy4IJHMW8yeaW3es9dtO1W7j?=
 =?us-ascii?Q?wc6jv3OQM37vjBDLyuP9kbp6bfEjFLfuFbQ3yqaxN9OZ2hbAO+CZB4npCxVi?=
 =?us-ascii?Q?z09WFgiK8TbVDK+bNXgrqimbwWPrJ7XoMt3DTEaDlQGHpXbBjJX2RMDRz/dM?=
 =?us-ascii?Q?7VhUwJ+GVBYGPy6VRgwU8m3EEpcLm2ia0Q9UcRfv9Xx+tf9kMH4K0ZzOtTV3?=
 =?us-ascii?Q?3W9p+bZ4RHhmOWjVVcD0GrTKqjjq/wijewDGiff1uGKfFVtoFO/t4KDwI8lP?=
 =?us-ascii?Q?c6CHLaNZ4eugQSO33n2RGUAbaks/6VLssRFcgAnTn7JFVLtDwOpkAJ/U02d4?=
 =?us-ascii?Q?aRxu2PLnUr5l+o3w/ax0576rSg+Gvra/1qtrA/NIzoXn6sBCYLkVNCEe0Yzz?=
 =?us-ascii?Q?1NykGWNThg6MAGg6HOFalO8JSb7uATMcJENId9UFwNvr1Jl7YIKAs7P+XA0q?=
 =?us-ascii?Q?mrE1T3kRMWL1Io07juRRoE6r5WYely4Np0RVRj6qCn5PhX/RhWlXhvdHSXPi?=
 =?us-ascii?Q?ecItZDLQ5I/lq7zh/p3ZhtJdLPeKoO8m9Hg9ApXWBOnk4G6NwMSl0BKoeQk0?=
 =?us-ascii?Q?bCSdF5gvPVgIKInLn06FYwyMNbeMtirn6BcTUn4oJYS1nFgj0Z2WhklFKMSp?=
 =?us-ascii?Q?81YtKQOfviX0K09RyNIkw1lsxTPj9TKBSg/UkOXLi8ElibP9GAXHdlbEa9CV?=
 =?us-ascii?Q?Kb3bvIQgk9Wl0TeQO0kn5uhsErG7it4K6Ce1NviXoiNjyLNwE7sCJDy5gOIC?=
 =?us-ascii?Q?p1Rkv/DmsI+GS2iPBoyIW9EtoWBe+whI5fTMkrKPG1Y68E4cFppJMZExuFN9?=
 =?us-ascii?Q?UsGLMQ0w5srDPr67Z6kfv4KsuiQClq1Mi7wiTwMJOimfJudrCb5XSpZScgzQ?=
 =?us-ascii?Q?OJ6cTJokk7SzxMZjuD6neVFTfbFkVrxE3C9BNvhR+TI3WvIRM1MeXXrdrtCE?=
 =?us-ascii?Q?2g+/AuhdInMnfUfOApx0UhkS4eGqGfKeoyK6ZKsnEA4F8ABsi1Qqqi2KJ8Mb?=
 =?us-ascii?Q?JvovKOAB6W06MOKFBhKWD2aq/esYWehW5phDfVRm8q/FSsyk/0ZOgdvFPhlp?=
 =?us-ascii?Q?J+eIcHEvL17g2mDfRP940zC4bllq7vHYWa2rDyLAn6jfIBpJrBftOFUaV9hQ?=
 =?us-ascii?Q?hcUqPJNBVldIYeWOSvLIbNd1Rtq83Z9nqiT4TSLvlH4xI4llRpXtm5dnp079?=
 =?us-ascii?Q?CUBtMIZcZSv6CTcm72P9EY8s/J1xkUawqexqi08By7Q14mKhquM4Wmsuq6zD?=
 =?us-ascii?Q?Gt0QV/3hAZCXbn7SacjrLIczwkjbIfd44nVt9PIs44LcMQQp0M5zX7clDces?=
 =?us-ascii?Q?qDajGZg2iFyRGFDB+toXlZE4w1dAFW1RyzsjiLHMHtXAd/QJXFkE3JfMyRz/?=
 =?us-ascii?Q?MobI6adv9C6mNXPoPCNj8os9ULgAcWL33t02YcQXrq4oCdfQUcQ63pgEr712?=
 =?us-ascii?Q?DWViZFOSkBmpdoJVY6+jffdNfoi1QGZ8zMGGS/DeegKMtDrqu8lpoL69SZvg?=
 =?us-ascii?Q?3Jvg4ERPfc8VxXfYIdxAT4137wDc9ldD09EmyDbh8jTjx+W1ZBIvh+cg+ep+?=
 =?us-ascii?Q?yoOxCMJBWLNcWz3gnO+AmnSi/dHnFqhzEMXrG6TFHwIkTsyexfZU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c7be07e5-a277-498f-0e69-08de8bb489e8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 03:54:25.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vTrALyTvq3F96jDdHHNJ8KeF2tQD7jRi+9LX/RiKM1yVz280bG4vd96sLgrjhROpDZ//0AfhQiuAPSLlVrD9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7090

Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
engines) whose register windows and descriptor memories metadata need to
be exposed to a remote peer. Endpoint function drivers need a generic
way to discover such resources without hard-coding controller-specific
helpers.

Add pci_epc_count_aux_resources() / pci_epc_get_aux_resources() and the
corresponding pci_epc_ops callbacks. The count helper returns the number
of available resources via an output parameter, while the get helper
fills a caller-provided array of resources described by type, physical
address and size, plus type-specific metadata.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v12:
  - Add pci_epc_count_aux_resources() and pci_epc_ops.count_aux_resources
  - Use pci_epc_function_is_valid() instead of open-coding

 drivers/pci/endpoint/pci-epc-core.c | 83 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             | 53 ++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6c3c58185fc5..fded71a19d71 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -156,6 +156,89 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_features);
 
+/**
+ * pci_epc_count_aux_resources() - count EPC-provided auxiliary resources
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @num_resources: returned number of auxiliary resources
+ *
+ * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
+ * registers and/or descriptor memories can be exposed to the host by mapping
+ * them into BAR space. This helper queries how many such resources the backend
+ * provides.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the backend does not support auxiliary
+ * resource queries, or another -errno on failure.
+ */
+int pci_epc_count_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				int *num_resources)
+{
+	int ret;
+
+	if (!num_resources)
+		return -EINVAL;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+		return -EINVAL;
+
+	if (!epc->ops->count_aux_resources)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->count_aux_resources(epc, func_no, vfunc_no,
+					    num_resources);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_count_aux_resources);
+
+/**
+ * pci_epc_get_aux_resources() - query EPC-provided auxiliary resources
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @resources: output array
+ * @num_resources: size of @resources array in entries
+ *
+ * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
+ * registers and/or descriptor memories can be exposed to the host by mapping
+ * them into BAR space. This helper queries the backend for such resources.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the backend does not support auxiliary
+ * resource queries, or another -errno on failure.
+ */
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources)
+{
+	int ret;
+
+	if (!resources || num_resources <= 0)
+		return -EINVAL;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+		return -EINVAL;
+
+	if (!epc->ops->get_aux_resources)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->get_aux_resources(epc, func_no, vfunc_no, resources,
+					  num_resources);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 334c2b7578d0..d8b81fc6ca6a 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -61,6 +61,47 @@ struct pci_epc_map {
 	void __iomem	*virt_addr;
 };
 
+/**
+ * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
+ * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
+ *                             controller register window
+ *
+ * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
+ * register windows and descriptor memories into BAR space. This enum
+ * identifies the type of each exposable resource.
+ */
+enum pci_epc_aux_resource_type {
+	PCI_EPC_AUX_DOORBELL_MMIO,
+};
+
+/**
+ * struct pci_epc_aux_resource - a physical auxiliary resource that may be
+ *                               exposed for peer use
+ * @type:       resource type, see enum pci_epc_aux_resource_type
+ * @phys_addr:  physical base address of the resource
+ * @size:       size of the resource in bytes
+ * @bar:        BAR number where this resource is already exposed to the RC
+ *              (NO_BAR if not)
+ * @bar_offset: offset within @bar where the resource starts (valid iff
+ *              @bar != NO_BAR)
+ * @u:          type-specific metadata
+ */
+struct pci_epc_aux_resource {
+	enum pci_epc_aux_resource_type type;
+	phys_addr_t phys_addr;
+	resource_size_t size;
+	enum pci_barno bar;
+	resource_size_t bar_offset;
+
+	union {
+		/* PCI_EPC_AUX_DOORBELL_MMIO */
+		struct {
+			int irq; /* IRQ number for the doorbell handler */
+			u32 data; /* write value to ring the doorbell */
+		} db_mmio;
+	} u;
+};
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
@@ -84,6 +125,8 @@ struct pci_epc_map {
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @count_aux_resources: ops to count controller-owned auxiliary resources
+ * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -115,6 +158,11 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	int	(*count_aux_resources)(struct pci_epc *epc, u8 func_no,
+				       u8 vfunc_no, int *num_resources);
+	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     struct pci_epc_aux_resource *resources,
+				     int num_resources);
 	struct module *owner;
 };
 
@@ -339,6 +387,11 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
+int pci_epc_count_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				int *num_resources);
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0

