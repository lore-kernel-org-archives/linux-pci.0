Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DBC3321BF;
	Mon,  6 Apr 2026 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491047; cv=fail; b=EJXQ/q0d1gkJlCj8Q6PufTAz+IWeqWF3VSZ50q4LAY7pjdROuNYtSJAefVXuJYB8/zD5PuXSPz408PWv95jj/3MdhZr30rBQ/aARlAbC9Kc2mXJ9PaxnVv/uxVhCQPotdnBY3ZSqD1P+OQJvssyQ8y9pXuXIMAV8KKc0PFSfVf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491047; c=relaxed/simple;
	bh=O1j5LZpxq6I5aX91Kr7iT72vDZEKBNh3pQaIPouKx0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nm88VCkWddmqFcAqhEhtO6A0cAxbS6o+s0VapR941+YchQKqSGKU2NXsnv/m7twEqm8YRFMDi6yyOVNxLHGyH/tzOdy/4Q5o0kfUekiL76d3IYkFOZ49GUIqBKKiMPBd/qo6L4tUMBcSH/s0lXP40ML41NKyrGKLHEi7OIAjsIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KPerpfKS; arc=fail smtp.client-ip=52.101.229.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KPerpfKS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtsJSVaOQyZfXZsW4wBBLzUW6sRL2sillhGOpsTav2TxGA4lmgTfd8IDux+4M8ih+Hq0EkgF7DJp9pB7nbVaHcTo/a0dPjREPqHOQQ0YZQ0u9otW/+RqVf44UBbrIhRy+Snx8IM38yuFkZUiPTFCHBCFD4v6RKfKvfqCci4bAmGKcgh5kO6+3i/xqWuUDgx3+zcnGZYwpdt7ZoFuUM2wsSTabi2ImL9jqdczaN4L1oLK5g4ZTkZUVgA6uvybIe9bbzjdn68/4POhFIudZmmDPhdNfGZEbJ6XKYy01yqwcIkeQMvo0YyKE20XkWl3jXI2yxwpxD0nDGI2M4Bv5xvgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7T8Gyswva6DI2f39ry6vwmC9Cjo+B5DbSMcPG8o0hxM=;
 b=Gkh7DFrtOf/1t7IyXFHEeDhyk4T89Rrwh72t6vya5/Q+xMYK+3LMt8Ol6Djpq2rhR/RVwkOZuUh1POll/tWB5a2e/2MERD9cLjnm8XdZdr3xDF1Iq1nrANw07p7+lX3kyEy1RADvKH5npmQwR5SRzhWBiEfh1711+HaMJ2bT7ScvanMSxs0CMTjjxnVq5FwG8DjhpgvqN82Qc8MpdtV4f/Ypk7qi6k8My22ljyBOhZGqmezqxXxQMBv8JNnwu4r5VCT0wYu+I6igGkYgyti8toRfN+J1c75mxGnf3B9uWizTjGGlP6+jl/1CA7bEY+AZ3So7ZBzIFX3G4JeJFgLDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T8Gyswva6DI2f39ry6vwmC9Cjo+B5DbSMcPG8o0hxM=;
 b=KPerpfKS7lvA7pKnwR7Ki4AMv0c8mR29G4Ym92TfLF/M80OgP5Y8BdA3Lri+tU5vjtJG8h4ScnfQBgshisfSQWToCeLXNpOusydbmz0IfWBhhqDrPtlkE5J6Mv1bt1kx2X7wlbcSfh3WuTISegqMeajcb8pTyNK557a8xy3oiSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4187.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 15:57:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 15:57:22 +0000
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
Subject: [PATCH v13 1/7] PCI: endpoint: Add auxiliary resource query API
Date: Tue,  7 Apr 2026 00:57:11 +0900
Message-ID: <20260406155717.880246-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406155717.880246-1-den@valinux.co.jp>
References: <20260406155717.880246-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: ef27b04f-524b-442d-41bd-08de93f53088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7416014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	qTK7uqXXN6lGnzp8pJDApyyo10oJV9JMAmC/HN7yX4RXt4dTLMohseWVVJNecxsj2/RzRwz4tShOY1zdNhOvGKwDOJlqvjFmbz9ZKEleNCEOKS5P/RQwWchQMw8YHmxeLwKDnS7SLM0AcMsNVkmha6VejN8Di3AeboBO9zyN6YnCRagyIKoK9MtAQEy1NCqVCZozanLuYhuXTG7vMMx5LDbzmH8hm9zGKuo0q9oXEE6TxPLhiIDkFMxluExEQk7vsmmGWbL36ZQRskNdlUWcUYLEAFodnv9nCH0tkLk3oMDSoBtGPdyERzv/8mD+/bZYbC2xT+EyASM50sGCotIzeGENIbCqxw4ZiUsAy0leAz/5H3sKYB6lhnHvTwENkO3eNy6TdYWrg69n5Efult96/X7wEuWoA36s6DFkfea9H+Ze7SXSMUBoL3nECfJ+72X6xmPlfDjkX5dAqLLxkp2qWpAYjNJmeOsiKSHEnSesQP1lOwpz8B8XF9rB48o25t5Ub0KI7DPON8BSy++LJoo/nLzKo2zaVOgxu/evYhdwUieCSnuFEv74zr+05Idugqiry5jSF20Q1jLc03IxaMI5k2EroV5MvhVMS8Et2shZbusS96LVtQxkt1X6ChoW4pkavgDwZ097h2lU0v6+48MLfhZ58mN0DuRxw/ToyZMRRAKepMIEQqR0hDE2mFalSSacXJt3oQJIIpLs3NWq3pIL/YBbHW6493gV36ncpnAMNFkliwfRNZZuQhsLCL2Lu8V0d2A9Bey/JwMyR5Eu/18Y2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?arosqS8dlmRBwKiK6RzQAZOie4iZMxJiFEUzdW9koPomgXPynot1FTzcrDa0?=
 =?us-ascii?Q?dn67KJNymjLzPUnAE4Y+ppxPfF1R+g9I0lmx4ILZKyqZ5EJ9ONrZh1MznNxR?=
 =?us-ascii?Q?VQowjuwURKNBc/j36TdJGwg94aEIb+bujOTRMdv5m368cQLwZGaS65js/+LS?=
 =?us-ascii?Q?csBPJC+5WgptEix/duH4XYbqtG5hhCiHiH+ItmlvcBLZDTzs2B9AM6v9iCP8?=
 =?us-ascii?Q?OZrCLuZDmrw/M3XqlWBii9MwEfC0uj1V+lNugeiwd+hv2DrwrJ0rXhn64hYu?=
 =?us-ascii?Q?YP2HViaktA3S37oT1i+GBEvS7SesyFjzhcM25CM2aDRhQhTvgKBJh2UkFTng?=
 =?us-ascii?Q?DHBFAiT0shOe1HJD4MATsHW9e2o5MbLFcmfxa39d/0KkT84YQ9wKPeNFypHR?=
 =?us-ascii?Q?DRw7DDnm0zXcnhyX6uX4ItExkCsBHZWR9jcptraIaorc3Mtuuwzj2vuDS/jN?=
 =?us-ascii?Q?9wlfqOJ1Rk2q+f/DuH51b0S/aleLiTt/Xc17moT7dxy01h1KVg0lNmqIPQi4?=
 =?us-ascii?Q?gKH5dNtw0nkURAGUoyp9VOLR1GC30CXwmL7NiLlnPJhiMD9YIJqAB4Wkzn2t?=
 =?us-ascii?Q?FoEvEvZSJKvR/5cFvawtGxuN3640C8iVwKBl3YTvz4qbAcouluEdegowKEbk?=
 =?us-ascii?Q?5/LGQ5HASyLpj4osnFXGs3Hi2aHUqmH+m0zSbhcBli2Jul5qQCffCyht2Mt3?=
 =?us-ascii?Q?eFVGDt0yfP1YfEZX4XQnmeIIVlTpEUJKFRO7KoAvXrQb6uY/uz9hFaMhrXu9?=
 =?us-ascii?Q?qtQCVzsRgPgFp8OZwGH1YvuPfDnCgJ0X3syPV+YQxI+oJ1eSiVPhcDqWFTDW?=
 =?us-ascii?Q?3gvE9s5SfLqblZuAeunO9aW/BKdexokLXAWmS1aX66P4bDHXwlbLJdi8MZlq?=
 =?us-ascii?Q?zPHKWUKqkMXZ++i8NqLWDJfhCVlyt7iy9EhOPgEj07cmxvMpOaAMRsh7TdSs?=
 =?us-ascii?Q?U4Ns9Sl3B6PD9Rmw8JfG2frShEtgSr27u6eX+l+rAZPyJzC1+FQlcs7n+oza?=
 =?us-ascii?Q?HZ6D9fYjV72QUTsbw/63xNLWBvMxt3byIFAgOFCOJGdHy1EXmJgaz6uSKukK?=
 =?us-ascii?Q?EjBXFlXTPxjk8c/N8PVeuolVR+Hfvgo7q0Ridk1Rly6WLiaOSKjy8tVkuaXp?=
 =?us-ascii?Q?P4vo6vRl6XIl2rYT8+LklSeO+a5mQg7PL6dLghZE6Uc/73bP5TiaiPef3v0J?=
 =?us-ascii?Q?ZY2wox8KuSoGTYyz2z8NCemufRMKMOSqih+/MWw+FyXIN7VG6s5Ce8+GGdnF?=
 =?us-ascii?Q?qHxi+YjuGsAHqoWutAZsyqhfr5qdfl3NjYQBmp0pa56V9qDiIoNYTxvx/1Ys?=
 =?us-ascii?Q?Um9eZEVjxbgMbSJMXAJmlI7DCiRfOlVm7Lj5EBbhSAie1CHZ5Q8Q50a/i6r4?=
 =?us-ascii?Q?g4HwRrgitn3FKcokfKXBE7b/H0Rn5znCLEvQt7rh+AwtoSL+DHkUn+YXOyZ9?=
 =?us-ascii?Q?JTJK2/vCUH/Iycgv7B50uKaTTwA6/zvHYeKfW303EVxWxmPQlt2MFkIs5AmT?=
 =?us-ascii?Q?6kIKbCUILM6DnPKvC8SjoSb9hwulIB2e17RChSanE8xUxn6Ow/7/LVGI2wgF?=
 =?us-ascii?Q?IPny8vphc0TIu5+WPAFjGalyjsvdxsGXK+WZjcv0Q/erwH6ISsxDopmy3oNe?=
 =?us-ascii?Q?qWcRnKhThcmEdcRgK85OdgahduFIJmeqZyW1kjGC1hkWQF3UOoMzdCM81AYe?=
 =?us-ascii?Q?L6JnGc/LtlNGpXOCLD/ObDXO+pAzpbOu81s4N3VvJZCQzqfTUEIJZysmvpp0?=
 =?us-ascii?Q?1TWHmNzdvhcBAbWWoMshiCjJpqBUJuazTdPeuZt+Wbdb5wignqjg?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ef27b04f-524b-442d-41bd-08de93f53088
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:57:22.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4yDGPwc4op7LoIo1/GKUjT6W19hElTDY0/rpTmrK9Env0Dn73dNXlImrzbQH8RFyxkudQ37XZjXohlxdLSAoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4187

Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
engines) whose register windows and descriptor memories metadata need to
be exposed to a remote peer. Endpoint function drivers need a generic
way to discover such resources without hard-coding controller-specific
helpers.

Add pci_epc_get_aux_resources_count() / pci_epc_get_aux_resources() and
the corresponding pci_epc_ops callbacks. The count helper returns the
number of available resources, while the get helper fills a
caller-provided array of resources described by type, physical address
and size, plus type-specific metadata.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Suggested-by: Frank Li <Frank.li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v13:
  - Renamed pci_epc_count_aux_resources() to
    pci_epc_get_aux_resources_count() and have it return the count
    directly.
  - Updated commit message accordingly.

 drivers/pci/endpoint/pci-epc-core.c | 80 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             | 54 +++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6c3c58185fc5..efcd0f8b33bc 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -156,6 +156,86 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_features);
 
+/**
+ * pci_epc_get_aux_resources_count() - get the number of EPC-provided auxiliary resources
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ *
+ * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
+ * registers and/or descriptor memories can be exposed to the host by mapping
+ * them into BAR space. This helper queries how many such resources the backend
+ * provides.
+ *
+ * Return: the number of available resources on success, -EOPNOTSUPP if the
+ * backend does not support auxiliary resource queries, or another -errno on
+ * failure.
+ */
+int pci_epc_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
+				    u8 vfunc_no)
+{
+	int count;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+		return -EINVAL;
+
+	if (!epc->ops->get_aux_resources_count)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&epc->lock);
+	count = epc->ops->get_aux_resources_count(epc, func_no,
+					          vfunc_no);
+	mutex_unlock(&epc->lock);
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources_count);
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
index 1eca1264815b..2f2848542726 100644
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
@@ -84,6 +125,9 @@ struct pci_epc_map {
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @get_aux_resources_count: ops to get the number of controller-owned
+ *                           auxiliary resources
+ * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -115,6 +159,11 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	int	(*get_aux_resources_count)(struct pci_epc *epc, u8 func_no,
+				       u8 vfunc_no);
+	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     struct pci_epc_aux_resource *resources,
+				     int num_resources);
 	struct module *owner;
 };
 
@@ -343,6 +392,11 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
+int pci_epc_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
+				    u8 vfunc_no);
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0

