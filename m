Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021131.outbound.protection.outlook.com [40.107.74.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4913AD05;
	Tue, 24 Mar 2026 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341513; cv=fail; b=s83KjFfPCNNb8+5YESXtNLZ/qNb2MtlbkBdWslOoFtVr5GFGsvE47i2Mjttgfz+wzoma9nDVBDrKcupxV/fxeiJb+Y0yoOiHnNX3dKk9VkFG88n5pWDz+2QzKbHRqiAM7EN9X0oba+cCW+hXuwtVGZEAZLavNVX5tp+9/ce1w+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341513; c=relaxed/simple;
	bh=6B4FfAEHUJfbmDp71TMxIh42xptCxnBrE63nYv/bKCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=heXa6mXC6O4wBE0020NzTsd/+KfvAPPm1+R3pbJJuXr81Qx260qVj+XHv5ZvdcDyqrhwuAQ7S3VsKmF9inHJMQFuysXb6J5rAQz+JWM3XJbSatBbyM5EoecQndKiOs7Y287J6W8NTq109MHtPPV07bWexoc0BKXftsW75zx+6zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bpCCJU9e; arc=fail smtp.client-ip=40.107.74.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bpCCJU9e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZTNwUEnd/+WgMp8jnYT6hP8sCwTEXWYybw9Poevs9ydmCT1RcDy0tgKVTnXMLLhvKGnHzPfG3MFsZc9SvbLL3yU4CvzihXmLdE3TWwycbctM8Z8w/f0TcBv7eWWG15LNPEX3gvK6JjOvNbITA8kINn2zXuHupCUI+SjKwm11Ti1EmIZELaoGMQNOFKolwGbcUjzJVO0dyhrI+fa9DYm+C4TUo1nRi6XBDUW3cjP11gzy6SmEIgozx1XHAWjJSFtAmcyijUxcHnqgxqgKh2Bj3yqp1LEQkxBfEi2oWDBrS0kbw60xBAO5dCZD/KdRcioVt80wr/ybrf7/HINb231cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvwX2g5b9chSU1MIQd2ksaOVfPCuPhNkjhZs/zf4VBA=;
 b=neMJMXV2yKvKMBiYuKyzA7FrGRKRn7HQXa4+tKoVyt6ASwjwsbPZTH5VK0XzSHZ3jR9YnEUk79Pq1jO2tosppUBrnLJsv4WZPOFi4tmEfBJk4M9+Pqcg1UmG6N2UVFD1h4r/HcV8EyQ+BSyhQJmdh+s4SId9eegFYBJWVW+WWw3zGUmtJ+msGGK/zBKFTYM6OHv72bSzJ7ysjYDyVBAfHKPsOthKLEaro+b3wj27ANAc2KJoXBYwohzM6jb7SdxHd2U9We74Y+Q8KbSf/5Uqw5eSW54OU7lM4eHKFxftkpHpu+gMnyLfW3owrZPQgl4UIhKtN5yhkbDDxazN8LRQhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvwX2g5b9chSU1MIQd2ksaOVfPCuPhNkjhZs/zf4VBA=;
 b=bpCCJU9eweK+ThOZpcHreY3XNrA+ztkhU515XbW9fm0cWc02mKAuY7l+8g8r97YUryyDgEhhw15VHBjGbGRmOzK6rwFozDRA2sXlyXLzY9Kq4Yc2Iqna/9tt0y/Z72yikvkNKfZYr2FoNOZs2TNECfN2qxYPGwWGU64WoDiaBrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6981.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:414::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 08:38:17 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 08:38:17 +0000
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
Subject: [PATCH v11 1/7] PCI: endpoint: Add auxiliary resource query API
Date: Tue, 24 Mar 2026 17:37:22 +0900
Message-ID: <20260324083728.3744734-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324083728.3744734-1-den@valinux.co.jp>
References: <20260324083728.3744734-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0eedf7-d107-4ffb-1177-08de8980b248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Xt8G2ajmtWUfxpIzYNnD7vCoIYjV2QpbHSXeawRpIjvNzekPG9gmGD5qJe+o8RiTJFVJcI0HvMvWMFC5M0mRznWW5KGFwr2sOhnklhyQBRPgGdzNRzsMvu6Yg1HHCGn+EkxPag0GMMJ42rw2tYh8QS++PWOrYA8mUXOirDMhPATUzYaYnShg5pGkfvgYyVe5e6Re32//2B0lgBVhE9lucf5C0x4441ExgE2fphWqiyzKhJNZ+K43WzDLtgLBQjunKX4NK4Uov6TgwcOfdPUS3isSNHHihiHFcpzkl5doRP5G1TBul0rbpvTenjZX5OuRqOUGWJ5hkJPUCBR72tKXbGp+ONhLC6NkVTv5l0CzEkKEZgk9tm0WguE3iC/BedO51ZvW56kKe6OXaDF/rWaGbkIUIosfh94NvrOxDC0PMDxKF3OGXLnbSn6SqilCJAL75/Ty7AFRUjIUJdjbyQGDkhu9OwWMOJLMIwi24zHYYR92XgSgGdhLoindD6sl6tHet9DfIapEVZSOvU/0l/2AN83V2TT+15HSUOU1H8Rj5N2QhK1/YEVBANesOTz/zy9Qb7HhV+W04CA1M9ByIEWKm2GN9q3mEJ+TFycgDB3JmsjO0b65JKUUWYgxNeZL7NMKgPL1g3qMXpgcRTdEowq0ANQngBGTPitEFiLOeEP/unN03RUfuOp5vOB3F5REC7x5ZS6wKNUsyi0Cdox0NwxNZm9jc/TE4PEg5po8kvcspuXtl+r6V5ZJNEKP3fCHuHDT6Ry2e0XOweI7TVx/kdQlPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ta5L2zW7sKvNvkq5FmJeK3NTzUNZQ/ofWkisZiWRGuwMl8QdDdqNHJGzm9Nq?=
 =?us-ascii?Q?AMO03ZPPaUhImd61FM9o+Dm0/Q+7joZzXFIXVneTf+k9p4BmyZWUOx6sHaEJ?=
 =?us-ascii?Q?6Iz8t2lSKIIbzY5arViDKtA43RZGMzOtHbrjBWlZg4yrwZjFtDY1alBMGur5?=
 =?us-ascii?Q?onU8K9bwh2/oHwqOq6TW+ZrtClKlW3pbar8UyGw+TMP8Gvki9TcUpu9JqPf/?=
 =?us-ascii?Q?OBYepRbLCStL/Fq5AUqptqkjW64wA2ukTSo1GHHXgr/enKCttbPEh4SaM2TL?=
 =?us-ascii?Q?cdBYnFV6wM42y59QofTm2PU++EGCRPX75aNKydHKVCYurs5xREHsIHOESkam?=
 =?us-ascii?Q?1QPRt55dDt9H1cDtG2z39Tt0HdvwQOKRv4YgDzppzMe2UBHgT6ugCN1FZhMn?=
 =?us-ascii?Q?agFr/LzjrigXh+Agvb6Rb9jIfu4190TTzLjz3fJ3OJaOWDmQOVnGXzgoGal5?=
 =?us-ascii?Q?pUKMsxRr/36bwUnOQ4wfG/Su9UYXdzRIfbsfqbtv9BCCPwXKDoknlZD7SBpC?=
 =?us-ascii?Q?7A4yKac4846DyqJmNcWrGkAlgJINqEUxTJ21evMfzFv1b/TS84vJjRXT01kl?=
 =?us-ascii?Q?BG2nFo3A+KEbAgZlBUqs4vGJmLRP2aNLViTsk/OxJv5tm3/c4hnJdGjinXRv?=
 =?us-ascii?Q?CzbCcJIFkk0ViHuph7LhXmGoVbPc7fBYuLm3Gm3/RabQL9Cvk1z1imFtKhkC?=
 =?us-ascii?Q?kzRy3JfFyKkJy7++sxWvDeoFDld7012NQ9siUvL46OAQpoxg19mhlrXZ7dK/?=
 =?us-ascii?Q?DX1rYlu1fl0VPjKII5KKpbjF3mrKIqpZfP+gHeq1FIvO+ftV7TnjgRdkXo/t?=
 =?us-ascii?Q?DaBeLSZlghbj+cD8tJqyofJQxUZwXNF4nXXvbwA1+aEQR1/1fd7pnF1ovdQz?=
 =?us-ascii?Q?7p5HFvqEEAZoTcHz+j4XPRAiDtDx/Md8RBOtpywYUzWNjePlYIOcF+F/B6Me?=
 =?us-ascii?Q?Bd2j3wZA8iHhNglKyf72ss5Ooxmb061O3kcUt4Tn4Sah9w2PwXGFM4GnkzZW?=
 =?us-ascii?Q?eKGApiDmHMI2gLB1NcQaN3puToXNM1jHahQEvUGB69uAD2U5I7Br3wm3RcG0?=
 =?us-ascii?Q?KtuIYDJh4zP3PuOLC2W/1G8b7e9dzTUOHNicdpRAhLo5Gih3Lro6TjemrUx3?=
 =?us-ascii?Q?2EHObKJ6IHuB4l4EaTgqaIK8cqonPPOX2gBKWwsU9yRQxwoN9qtsRDaJ2fIS?=
 =?us-ascii?Q?vnKwp56rKLCzMsqktwBq77PwBio245M/1HAgUA2JJeIHl/cVnOkdl1oUxs/L?=
 =?us-ascii?Q?++2OsM4Vl5toX8JS7Rz0pzTZTx8RgiKDXVNzHPtYya2c1cFIZCsVHhhQsR90?=
 =?us-ascii?Q?qdgie6nQ7Au3z1haWu/QjCQ36TuQc4Lxt5oNpiH3NYLZiwaGmOt9353xcR+j?=
 =?us-ascii?Q?wRixTPQDr5vIx4ljRdB2Y3eIbaZc3zUap19L70VvfMz3jco9ZukQ7xDmf6K2?=
 =?us-ascii?Q?mMX2l4SDCgURRWUXasQ4J2jzf5ctY07NYWJBnhNc/xHd4jQ9qDHPQseL5cfK?=
 =?us-ascii?Q?9iB8/5dYFJtLcnGdVAa2TThij/TExxAz5t9EKNf9KM+XeImE3Vfbc0MqbnwZ?=
 =?us-ascii?Q?AX0JvyZ78lq0v4EvW21d2UnWmw1G19/jFzPTvUyw1XmwBKevw8EXH2Jv0EcH?=
 =?us-ascii?Q?Jj+RIquzG95lwtuaQzfPgHcImTgR8ED7xOEUqe6JpTQg9WQSe2qhMijY9uNf?=
 =?us-ascii?Q?FdFiETCrkmc+GpmVVzVp8CndAnXGqpzXc+cfMDbEb3OdQFDNuSHqIdhuuYQn?=
 =?us-ascii?Q?XoPLG636Oj9ezIvR7hYiQzHbkC9ggphxjskyUk9HM22E3v8J5emB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0eedf7-d107-4ffb-1177-08de8980b248
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:38:17.3699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OA1lHL4uD90UOb27642MgSMiysQmnalOaBnq1sl6roFtsKOpyxcJwkHcsLAmXi3ioat8RnjQY+9lPuTYAkDh4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6981

Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
engines) whose register windows and descriptor memories metadata need to
be exposed to a remote peer. Endpoint function drivers need a generic
way to discover such resources without hard-coding controller-specific
helpers.

Add pci_epc_get_aux_resources() and the corresponding pci_epc_ops
get_aux_resources() callback. The API returns a list of resources
described by type, physical address and size, plus type-specific
metadata.

Passing resources == NULL (or num_resources == 0) returns the required
number of entries.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v11:
  - Drop PCI_EPC_AUX_DMA_CTRL_MMIO and PCI_EPC_AUX_DMA_CHAN_DESC from
    the generic aux-resource API for now; keep only the DOORBELL_MMIO
    resource used by this series.

 drivers/pci/endpoint/pci-epc-core.c | 41 ++++++++++++++++++++++++
 include/linux/pci-epc.h             | 48 +++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6c3c58185fc5..dc6d6ab4ea1e 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -156,6 +156,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_features);
 
+/**
+ * pci_epc_get_aux_resources() - query EPC-provided auxiliary resources
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @resources: output array (may be NULL to query required count)
+ * @num_resources: size of @resources array in entries (0 when querying count)
+ *
+ * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
+ * registers and/or descriptor memories can be exposed to the host by mapping
+ * them into BAR space. This helper queries the backend for such resources.
+ *
+ * Return:
+ *   * >= 0: number of resources returned (or required, if @resources is NULL)
+ *   * -EOPNOTSUPP: backend does not support auxiliary resource queries
+ *   * other -errno on failure
+ */
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources)
+{
+	int ret;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (func_no >= epc->max_functions)
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
index 334c2b7578d0..a6131f1636b0 100644
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
@@ -84,6 +125,7 @@ struct pci_epc_map {
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -115,6 +157,9 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     struct pci_epc_aux_resource *resources,
+				     int num_resources);
 	struct module *owner;
 };
 
@@ -339,6 +384,9 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0

