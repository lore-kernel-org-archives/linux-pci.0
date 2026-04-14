Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020133.outbound.protection.outlook.com [52.101.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34742F8BF0;
	Tue, 14 Apr 2026 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176187; cv=fail; b=ucIBtWzQY38EzBRLURaM0nADjGpyQLvtoYyXHsnpwWICLEkCZ0wIXSLd4/1l/ekMaFjiXHN1clpqh8RKAKaMHGG54LVM5HOWXIKtxPWxALf+iaIMWDBFUz54eGmWpdDeDugLlS92tN0gRBx3hen/IyEtK7S3UzA2R48cNi68ZHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176187; c=relaxed/simple;
	bh=jSyxzDyMc+yL3KObyWMDVtqAuUeHAO3mhGBFmXksR7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OkMxnHRGpCJTwS7RPpa1eVwYFHOEHBxhOwLwreLRmGffyjuIQQ3Q2rHAD3v/FHFmbreCPQzO5z6DKMLtSx8fuv0paSLVhStaZCWcCAHffH/4V9VqJpHJR9JGc6iI6cvLkatkXFSocCU4sW1tsSUDaeGC8qGhgzET2RLZGOqCVfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=F90S0QhY; arc=fail smtp.client-ip=52.101.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="F90S0QhY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A96201vMrhT5ZXwoaVW48WBURrQDeYOMK3MGprR5/Oq7ch9m6BsNoaYFvJKSaMl68GYXCir8f2gJT7mO9MKvPLOcBYep5pNMilMVCVpw0vtljrZfZOsIVIw1DrknPzSYLpY6PSrInGpOYncSbD80NAIVZ11UZGL87U5W6bfbwy0XCyFqQXsz1iXpqhiajXoi//nIuAodkeuPdTGJJKhbw0elB+xDocUboIWT3u7ZdJgOVr4aJz7bsR5eD/W5G0vH+Fp2o/xDH0ZdP/JjCn2AByYfOtR7ypQkdqbbs/NOdTXh2gjB/15mnivFWN22fDpch15JK9o05Ko+YJ85EUgNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4HnJvHpfcGaR8/bBQQX4t9TQMonu32ecofiMGCq9CA=;
 b=qtfmjtHGkuTbjH/LrYNrmKKEhzJo2W/qF45r74v3kXm3JPsfi5S+FMHaANxWekDU2D/DZLeWKnd0E+scobrBpXsV0XpZEQWoIeIgyb8fweCIpsjwa/gWM74RmolI1HORTY9kpP3+IE/C5aYLRBK+DSbmBRgAOIdvjAFI0oygflmfiUfKGkG3jKUf23PKnAe5SawEfdk5Tuoz1RvjJOeyXSEO6tWF72EGFXPVf5uwuIVR4n50thGh25mMb8SZcwIMvrKvOdWTI0WssBcBJTx0UwhVVmppBATXru1Qnj8s2C6k3KLggZVTuZv+dsBSQhvqqY0guZSMzyyJvj/VmOXlFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4HnJvHpfcGaR8/bBQQX4t9TQMonu32ecofiMGCq9CA=;
 b=F90S0QhYr2It4KKgsdmTGcLkjWiSz3schs9UoOw43Um4O2qFoSJYy0YHqDgVY5ycUOn/4UJKl5YWkZJQnB3PeKY6ECflUYqZp6NcYbFszk5uYayubbgayzgTs3vJnmIZQILTkbdVCrnanBN7dI85z1SlUVue5S7xtinTqg57280=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2529.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:222::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 14:16:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 14:16:23 +0000
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
Subject: [PATCH v14 1/7] PCI: endpoint: Add auxiliary resource query API
Date: Tue, 14 Apr 2026 23:15:08 +0900
Message-ID: <20260414141514.1341429-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260414141514.1341429-1-den@valinux.co.jp>
References: <20260414141514.1341429-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0071.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2529:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cced81d-566d-4a77-973b-08de9a30686b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Nv47dTs/Ni8noQtu3SKuYQ7p4ih3nRpVw4DEAeVHgh9lToD32Nhlw79BgEzkBwL4YImN07TNAkfuPQwGe7ZRx0Rzsd5nmNHiBXKQmttjkA7y1ycDfDbVLBYOWvuiNroSyfftE8yPpasQ9V1jD3H8m4HhEp/K5nFroci7EP6hi2DXUanCrZ9yeTiZnCJ3CRtofeduH7fupG0jYOnfFQFbYzhx45T5CiPvCvbTZOou7WQP3IFGo65ECUI5xjIcR4ycSxLGEa0vheD6Xv//UtLx64+nkNF47stNwSE/mhWb2Gea6MdoCbBSwSLi0jZWHyUYX0K7IFShzKuat245BrG0rQgu6Usk0PxcJM7s/Hsd/q2YqSQTECujbbyfC9f3byJffFYSjjjIHKbRVuMwlm1tPSl5yJM0G0A9ECFeXeXAhweo1jTi9WEeKj2TS3jbmsYVO6RtyDh1bywMgeM7yOEGh5IpvtMW+bMiTU2dQcbR1Wst0FsYBNBLQJ4Zkt1sb8VK/y0ilYWd9UTT7+LpilcZvHDA2SNGCJk2ODW6QJNWlOxnlkqSXR0FxMeD5R245nkPYkPglcly7l6pqS86DoOYpbgMK40hkWVAFw3DDQyRbKhOVhXl3lMcrKN/t9/baFQlInL5cw6Ai8fDwM79RdomSGrCs7m2f14S/qc1H6w3uvdWr/UpikdH1sBPDazuPuwcJliVNuErRFE95QHymZJLCrOgSqpCGXCCN3i+ofeZ4MHU0MRxushQA9vVLsMFDVCN9FSVTLlS2uCXBo1lcIiXhw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?75rNFHYdZOunYJueJsScVuJMKeOAa6yU/ismXcPizjrM+kt5RdwKtsAvlZc5?=
 =?us-ascii?Q?8sqVHejGUXM5OJONNXAnKmgtpqdQWJE660Y0Vd85cQ3AjkAacaAMP/ZASb9L?=
 =?us-ascii?Q?5XPJfitqnc0kmgi6gFAfhYl0P+VRDadrrtkOHuqhSINOe/nNbmzP0o1G28R8?=
 =?us-ascii?Q?PBP5pcKvL0LElzEYEpPVGEl9pVbA1JEaZSbgkXDRWF5QCm65H8V4XeD654Tb?=
 =?us-ascii?Q?L0flZ/tBu9coQqH77+XH1/RAJn02pgbOUUWkG7FGS62J1FezDD9+l5Vy4ygx?=
 =?us-ascii?Q?E4LYCtLVJgBM5WhHVVB6cN6/dohXZY5jBRy8DxRHYWUvAUn5mnmJF9ADozSX?=
 =?us-ascii?Q?EeA7MDc7rBZGfQN2DeTAJNMOsVf7r4rqjkZg0QjPpa2LJxQFR+kSkmkTdAHG?=
 =?us-ascii?Q?1KioVfR3tWaf2aNvccTExWXi3qj9lVmDX73wpJSnkKEJmvNKX0DA9j2AkAR6?=
 =?us-ascii?Q?x19CjCP+O6Yrt/ZhsOFwpF/ueB2qTNNvzSlm9LKB4dYOmJV7LLQjHXsYYhf3?=
 =?us-ascii?Q?iueLwb6uO8EspRzj6i/v5gQAPy8gR6X7dLDGDgs8BLxqPgzJHwOpmgotYfYF?=
 =?us-ascii?Q?THk0mMzPh0efCpnoOGgBxQ0z4Dd505u6UvR+28HEXWJFbomvXCduegnHIwN6?=
 =?us-ascii?Q?YsIj/c9sU7xZKiYY4Mi5yUeteEyWkqTl7NQW6+PJsG83/cdmaQ3WUVh4uFM+?=
 =?us-ascii?Q?PmuKiH+CotSkEk/w6xMGaknUtAy+EP54/dSiaweJECjFdJSgIQSsMjq7Enjs?=
 =?us-ascii?Q?7QyWc+Z9upoUKz8LI6y2HU70+FkiOqpCVRNTNAaXIOxex4Zbc8o3Zu7ydEP1?=
 =?us-ascii?Q?feaYWBiuaa9lLTa85Qtn0FnBnlrsTv0zAMTHeW1wThzHRyWytwEyI3w8IdQZ?=
 =?us-ascii?Q?6tnDffXwayEBZDjbeeXy11tEdk6u0dPb/JG9lnpkgAJ/kOVEQ175jWZ4/GMK?=
 =?us-ascii?Q?fc416KkO+TOzBeOYrx8epzw7hLRoR0p0uYkraEubZ0dNjkCXqcZmxJooTnjF?=
 =?us-ascii?Q?mBYDMVIlrBF962gDwOWBAHvkNPaSxzldhz3evbw5gYT1bs/7pIYaur2/mL1X?=
 =?us-ascii?Q?CLWe1pp+sEqZRqw60JTYc4qyTaGPXWCZcwnNCDoNTA3qTrRBd5DJNJIb4avR?=
 =?us-ascii?Q?nOTi9346PAi3p0MLwGgCkVByR0/sFC3+/FVD/Q9tESTFQq1U8SR5RvAa9LPV?=
 =?us-ascii?Q?5w44JtbBOaBSj4ZDTh/v8O2yyHhfFj+wI1PvOgd8iJAmcfw3EFfYT2KzNirI?=
 =?us-ascii?Q?Nqqi16hEpNTUcDJcNVsSg7HHwoghteNbqd5rz+YdJiVx8pgjnLtmjKS694KI?=
 =?us-ascii?Q?x218OebgdczLEDHrBZOFi+L6sE1iDTyW8r1MjYNjADseyOpZBbIzaQji6lQG?=
 =?us-ascii?Q?rb9zZu/Vos7wNnrq3M6rERI7avFt9ShWxn9HYCIB+SeY6Q32LLTuLVeUKBfv?=
 =?us-ascii?Q?Ra3QCM6nyCpfZPtOcD0+3dR28vj5cUalFI5EYwtqn39J9+fmik1oQw4GjHtN?=
 =?us-ascii?Q?DDFRgIkRMhngnavNjq0yLkbFl+qcWoM38d/M9eTQCEGy4EK/ALGGq1BfbXQ5?=
 =?us-ascii?Q?SYHrlE7ewnfAnp5Dcf/hYEvlIjOL30oH1f30Xx2AJvXfTy/S+lw1zZJ/fW+M?=
 =?us-ascii?Q?k+fjmet/tqE9Xj6jM27S9n/tIWF0zL0YrmgHi9kkRwTZLuDRHXpA7Dqe4q0N?=
 =?us-ascii?Q?TNh5u/tzHi0Xy3jIU/Rek4OY17rjCe2B92lonq0ql897SFeuqp2yPslXdnOt?=
 =?us-ascii?Q?x8QXceHTQlx8qwPz9rilLb35vuSV2rMRsii01XqtlZjl/50iTX1R?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cced81d-566d-4a77-973b-08de9a30686b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 14:16:23.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leFoA9I8YDZRW1hE1DkojXrrUK4nh2IIHt067mYdvzSL7m0nwBh/6yrQfhsowZcn9s2GzeEok7a3SqSuV6VKCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2529

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
Changes in v14:
  - Fix whitespace and alignment issues reported by checkpatch.pl.

 drivers/pci/endpoint/pci-epc-core.c | 80 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             | 54 +++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6c3c58185fc5..831b40458dcd 100644
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
+						  vfunc_no);
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
index 1eca1264815b..f247cf9bcf1a 100644
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
+					   u8 vfunc_no);
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

