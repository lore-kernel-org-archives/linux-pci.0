Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021130.outbound.protection.outlook.com [52.101.125.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1D83537FD;
	Fri,  6 Mar 2026 03:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766918; cv=fail; b=uOvzigPeEC5gVL5HpJtYjmw0jva4+z0v2vUPDSHBr0NyOkNjqAQlGSmbRkR8FF5GgjlkWVXkt8Yk9GW/3qR15KT59MTOrnXoxJ08F9Do27hRTB3NIB1+jovffdtorJgFVRY0zBEobWa8fT4i6I3k2AN+zlt1uZko+c664q7x/y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766918; c=relaxed/simple;
	bh=uZLjwyxGooa+oKLVfXH7GYYYyVvP2sz3uPuBXs1v/tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kVM8wrpweyXcblipUqeYgIiJBMdi6xvr3CA++NA/sRHy3SNnPoIBxWZcRWdUyX9AsgsZxF1IYafroRDYDyI7/mfIE/2PAbI5aPIgbTYByNQuhIRkOXHXc6v4UKIv91PN/Yswf6AP+Q2z/a4iryvnDjoZDnCWPi2+glFTVBmuq5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FqzkOtgZ; arc=fail smtp.client-ip=52.101.125.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FqzkOtgZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vf064nBpd3s4rGM0QxLLwPnXZAikLSr/iVCz3if5ZfJ35TMrGznLzIHfJnpDjMCcSOjlfiCuaTgwFkiqvPpgWfsWXiX7GjxXAb4EZ3vcA4549L7lzoAgY49MiTdCTUriWq26Ittxsq+cbDOAIeBpGfOyA1Cu7Uk75oqa5s6jaGijba4moWkEAUlOEB8tbdvSeuDZtGcfddrcWd1+CuD5WBGwPFIrZmAwWgnQplhzBeh0MpzqMYuShIww3NkAyXKncoUoS/631yxCs3j+kEDLpTZ1UcIqpXRmpXWFlWjxP78Fu9sz5+rLSoB5Sr7zc12zfa9ri+rDfuFYviIQIHdzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvtZIMhRBsDN4tP0nBpSrdpKa4JyCeH0wdJS6xvJBOo=;
 b=jEMtwLjU910EA5aPKGbELH3IvoiD3Tcp+io6wdbIsUs6ttqAwLKL3mHfCfT9YYqvD1Y2e1DuTYytwPm7Gg6xQhRksPhoihxf7ExzNQ4rGigmNMiuuG2AXB0fa8a3EZnJSX997sGeMwWqBID2EO2tGntJ/hO0er++Oo6LPoJyTyYMo24YACzAbiP+z3Lzb8+Ayqw4R3UOU2SQLrqlkvHyTmuRX+sN2Szq6N72LG17kciiFLF6n/c5p7NTniTdbKyrxNGg7AmnelLsTOwBbuxf6LF5mDL69HdI84PkJVoCghXqDkbg8kW1locNSsYDVYvv9k1vhSREPodNKD5/TB/vxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvtZIMhRBsDN4tP0nBpSrdpKa4JyCeH0wdJS6xvJBOo=;
 b=FqzkOtgZT0J9WpivlVUP+sjk+WcfudqT2nbxU59v6jdv303xC+wo/5kjdXjP8ZDZdWXlXnHvt/PoIZbHDbCGVkeM6p6bRYpX6qDdAYsI+RFS9LZ5chwQmWYL7NqZVUZMNl5sfVeuc0pb/uS/tzr8DSAlNVywVt5mz6AymH3cAVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6984.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:414::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 03:15:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 03:15:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/3] NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
Date: Fri,  6 Mar 2026 12:14:41 +0900
Message-ID: <20260306031443.1911860-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306031443.1911860-1-den@valinux.co.jp>
References: <20260306031443.1911860-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:405:370::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: cd87e326-1dde-4476-539e-08de7b2e93ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	SubQ8WY/dpNODDCQ8KBWNKu37EA/jK/JEHr0ghWiiZ1vqmsVNgEokC+hGOxY17ii0MkvGxn2s/JSBXYWt+OcVPlFgkwHXWeDhXHzcCLqOW2GzPjvMRY0dQVFYF+cY06PthKp7yTHc+VUK3zzD00Q9o/QPkfy5JX6nIvZcjyUtUpXn8t0obLiXKWJUNRCk6IEpHcTJnPJnpXWtiAWUB1T+9hIg2zp1ccKI1Q+8x+mjiVJDNekLW9LRwg1JgsvadDF72xQQ6ZeX7TbQqDTXlvejLpnDA1Jfmj0sOdpcjzQadmRY3OufX718GJxbgxkYd2fzr0NmQxG/HOyeiIbneQM0MZhfio4654ralTyLCR3Dm+tDYGZWDLCsTpLkB0SIyee3nCF7O25lrTkvVxK5ggRO8YITovu+bwvclv0xQXOlbBlLofmikKVl3t9pZ1t/yA3aS25Z14b9oDTV3NiPuQ67zegzM7P9moGsKuZrpjcEPs068ynhIY8RNihTEGxIfI7m3XDMcnQR83gm+7zRltHjHg5C7rpxuCdCEMuVy6nJ0E88DW86dD4CfT9bdoyqrbWWoI2WGMVrlaMAZvO094j6IH0OTUmwUiTva0t/VOjpQu6d9n2xyLKMQ/KwrefgFFrYJb1QU9RtfZSHscGhKf51v6L3CqLEh/svwxMBMdImS3dEYdEMOdm/oMjthwtmEJNxsWRKkex+i6xgYLr8acvCZ2W36B+/Q9DLIQriJzZaxw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H6AwejVKpX6w9v/t3z+rwvjNZfh68l29GB7D6wkngxIHM+zIzaGr7NY6M0Y/?=
 =?us-ascii?Q?HbY3EFr4I92TT5GaVqdZoGksGzxR+5PjjzC+rqKAIoZNa4XYsgpqfrqnsxtY?=
 =?us-ascii?Q?imCLR900OA4SwtLji2Mmvo4gQfh2BxYA2aAI5a4IiXlPl83Q0wEOoPcJiDle?=
 =?us-ascii?Q?ooFD6ED8nLhtx/HmLIkTkEfq1bTuMvPTwztLdCPylfNvWJ1CHMbAhZXrwPb3?=
 =?us-ascii?Q?kZdklobZEZKSUwHFG5X+cr8lbMEoey+IHqAW+FxYNZ3TKA5XBpTn4VEQigg9?=
 =?us-ascii?Q?bHW9z4gKb+e5bBVlqW/fSUMqjK/N5VubPzgCuidFs42IWNFgpQRbzJjXaaOA?=
 =?us-ascii?Q?8LLEERrivdbRANSqjqUSGlSZEI3sgI7UrJaHFKo5MqS4tzLdBuvbklY++dYn?=
 =?us-ascii?Q?HTePcII+pFqHe5jtMO6jPOUOw2ufhz64dtaoXt889Jo5VjXldjVaXMuV6/zC?=
 =?us-ascii?Q?weGeCrmU/nJ6wtqxjl1f1MRUJzSuogUh+qbGAkXpnFZaMYxHMK+L/HQz6RO6?=
 =?us-ascii?Q?WtmxGX17eWG25kjwsL2QS+ZrJqXLd7aBUhhJyJgi9hqqx+s/7FzFj6F1Uwde?=
 =?us-ascii?Q?G6mW9GDk20jw0d6OKRvok1qkoISMZf/oWDF9OajlP8CM9Mbt/z0Jn2LlOvtX?=
 =?us-ascii?Q?xO9dKo3LD1K03kUVzMSbVDEPDgB1vzJvPFx03N374Sh8tSAycCwbYe8UzT90?=
 =?us-ascii?Q?0y6HsSJMqTAQEbvw1ccN/CYtot8e5YSvJfgwuN7Nl/L6jIn5VtajiYpIQiUu?=
 =?us-ascii?Q?RJNrAAtuA/Uz0qc6Vx3az/qpDv3d6mapzVPChw/46/TuGwuWXol3I0fJNkKC?=
 =?us-ascii?Q?9S/V36SPOaFnL6tWJR/m0lWgjr91LYhnBEdGviegFhxhxe1UKk1RnR+Jc/4m?=
 =?us-ascii?Q?3ar5xxSERqNJahGUKl/PS4gpYFa3CUfc/jZIYO8yfsOygXCf/U4Q/OeH67UY?=
 =?us-ascii?Q?5ctGFYz6x0YKInUG8tmm5yZZly+EJNI14IM8TrEt4pMJzXez8Xc1MwKsD0xM?=
 =?us-ascii?Q?XNVb68gOKo+Xeg/Wv7WTZdzUf0tI1U5z18kCDV/dpc4qhJA1OxPjeLxCUydB?=
 =?us-ascii?Q?ZP+QW/Sw8nUtdHD2/Swv+LE1MCjD5BWfvacslu7EYA2NxVMatmnMJxUgprLH?=
 =?us-ascii?Q?/CfzOUVqJ/g+pU/K1BNAGw/gz2mQjKp5+TaJsV0W81l5TzMMaD+KoqfnX42W?=
 =?us-ascii?Q?uZ64SibHGL58HsRpg77UjJA1GkIaXgKvEPXuLYs/uTeSmbGCqTL7oPUAbjLV?=
 =?us-ascii?Q?itQfuB3Qiza2rYkybLCsg9sfwO2bKRKRuLjqVQTs/NNpBGH+VFEPKWc4legh?=
 =?us-ascii?Q?yr+JGkRWC5zLciAbYzOlZX8TuwvldMyFmbBWyaNfssAapqclZvVrFoXHYmmU?=
 =?us-ascii?Q?PL9yGdnkDsFPVUJofl/oVDzm+ZJBCEZQ6p6UVEOgjFju9ah6Y5j68bz+3bPJ?=
 =?us-ascii?Q?L5Qq5UmxVVytca9uJZXML5zoOWL1Q2wyWW9Mr25cZrJNqv1s6pPeUUbGeuM9?=
 =?us-ascii?Q?A/hCEyCXbCWSbZLUF6gmt4hcMteGus6MqYQaWzn3/xHgM1Ym/h7nbiQZPyHp?=
 =?us-ascii?Q?0NW7RfArzGhlZiD99OfvuNoQj4dr7hIVAL4pFti382t9Oem62IpQ7fS+ThB+?=
 =?us-ascii?Q?phz9tce7ck6TbY2qabo9xE5Llxowupba3LJswgiD1f18l0oSpOZEKqTsA3xH?=
 =?us-ascii?Q?Y+af40HLm48G99ysTgURpKpkXHKrAHn8MCPbR1fzISY/a6oEcTPgYE1ce1cy?=
 =?us-ascii?Q?SWmbp5hRf6uVE+SWCJXvS89NoxXHBkS/F1QRQvqFGl/5FG8EonHW?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cd87e326-1dde-4476-539e-08de7b2e93ed
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:15:11.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ps4iH1VEqU/99mRLNu+BtzdZ+Wu1K5bTIDeMksctBSxuqfKe9FpJcIgUWYL+Zzz2kK1zZs4YFXil24sAOeY1Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6984

Some NTB implementations are backed by a PCI function that is not the
right struct device to use with DMA API helpers (e.g. due to IOMMU
topology, or because the NTB device is virtual).

Add an optional .get_dma_dev() callback to struct ntb_dev_ops and
provide a helper, ntb_get_dma_dev(), so NTB clients can use the
appropriate struct device for DMA allocations and mappings.

If the callback is not implemented, ntb_get_dma_dev() returns the
current default (ntb->dev.parent). Drivers that implement .get_dma_dev()
must return a non-NULL device.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/ntb.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 8ff9d663096b..99209f957eb9 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -256,6 +256,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @msg_clear_mask:	See ntb_msg_clear_mask().
  * @msg_read:		See ntb_msg_read().
  * @peer_msg_write:	See ntb_peer_msg_write().
+ * @get_dma_dev:	See ntb_get_dma_dev().
  */
 struct ntb_dev_ops {
 	int (*port_number)(struct ntb_dev *ntb);
@@ -329,6 +330,7 @@ struct ntb_dev_ops {
 	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
 	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
 	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
+	struct device *(*get_dma_dev)(struct ntb_dev *ntb);
 };
 
 static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
@@ -391,6 +393,8 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		/* !ops->msg_clear_mask == !ops->msg_count	&& */
 		!ops->msg_read == !ops->msg_count		&&
 		!ops->peer_msg_write == !ops->msg_count		&&
+
+		/* ops->get_dma_dev is optional */
 		1;
 }
 
@@ -1563,6 +1567,25 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
 	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
 }
 
+/**
+ * ntb_get_dma_dev() - get the device to use for DMA allocations/mappings
+ * @ntb:	NTB device context.
+ *
+ * Return a struct device suitable for DMA API allocations and mappings.
+ * This is typically the parent of the NTB device, but may be overridden by a
+ * driver by implementing .get_dma_dev().
+ * Drivers that implement .get_dma_dev() must return a non-NULL pointer.
+ *
+ * Return: device pointer to use for DMA operations.
+ */
+static inline struct device *ntb_get_dma_dev(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->get_dma_dev)
+		return ntb->dev.parent;
+
+	return ntb->ops->get_dma_dev(ntb);
+}
+
 /**
  * ntb_peer_resource_idx() - get a resource index for a given peer idx
  * @ntb:	NTB device context.
-- 
2.51.0

