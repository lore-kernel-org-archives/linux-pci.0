Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021139.outbound.protection.outlook.com [40.107.74.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB536604B;
	Fri,  4 Sep 2026 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504828; cv=fail; b=Msn9BU+sSBtyAVWxfbjFenEoIrBbI2HObEROBOP/2ncXs7xGA2oOZ8YGdiai/8o02jobJAQW6fcHhXPZoao0Snt5c7Bfx9lZO0OyG9XMxjuLnO0WkUZ+T7mNWX9arlMtxCbhyLn/1mteAUrQ6OvXVm83slSHy/nkChLH+FTZfUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504828; c=relaxed/simple;
	bh=28CFsvh6CmoPDpWj7skEDOmktGSRfBM5ggnlSK1JWso=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sbkqPZFXp4A+XE7rBUS3RKIrFeP4G2sFplrAomtY/10xzNX/p+40p2AKXrvidSmuMtluqCqq+qgDRD7YT95LBqFQQw505BJlKhunohtmw1l5qhktG1wz8OCX0dgdFlvYdcUSJh5MVmqmVTmOI4PetQXUXdVEGC8/SN1mn2tdc2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aUrpVUlT; arc=fail smtp.client-ip=40.107.74.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aUrpVUlT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg8zzbM1TIyY+WNDzvBiRRPQFbqxb5aLOHi4ti7lYn/++wlH6lxsv6Z5tvxL3425TP+Y8X///3EQLPutwN2yOMqCp2x0uN7PcBpk0K2QnXmfoJstUXBjNrV2B2r8Gt6chTxzwy/hoXv99giQHAthza/tRpoGBK+totvHpLb1ReLWaXDI6C5gy+6/ccPOqyOIelwmglVnBnQMYEp2oblDtwr6Q3U2rjhdwfEpzOahRFj/U6zbVgU2PCCkg2iVwsGzE4v04WVwmmWkjOJnY8HaWtZOA/VoyhyJvgAwcXKZcY9cpYUooWw8f2t37bthhpYrD3P6mfebAcuaj2TptoOi5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IV/Iu48lj2BOah7RWjUfGtWQza0eFtSp9+NnkwLNCI=;
 b=l7jzEIEKTqFWbRLpww80YGmw6RGGOLsvN54Pfk6kuasaEOUeKB8K3OYvpuz0E5qRct7X5oyqPyiudWUxr7u8lf6MtuCQ1dPlUuVL4hQH+DbZMOguT+oxmr5/Dke5JJqtE+VgHravMr3g0SqigmbB+3jA2ON/B1U7KuOGx1DDhL9URCPYYRj0hQMTCx4sUpg6IGa/RrnmAo7O8fsVkjgg7sn8/4iUbSu+1RR8E/3etlhwHCwFpPq9h4C6fpewOwY1Az0Z4q7mmKWanh/wS930GI8JxwOJqJOzc0C2lFBkhFK6bfOwKsNYYMN/6CNvYMNh3S7dA5hrkxAoyvRyHGdSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IV/Iu48lj2BOah7RWjUfGtWQza0eFtSp9+NnkwLNCI=;
 b=aUrpVUlTfiYHMACY91cx6Gfpn5cvm3iY0HBczUXtyOic51zw+T8lxHECQ1d/ELRoK3NMn7G7L440DqY6OZ//SaP4FSXRt2HjxNJatk7YJyRrjCkt0fgmQYlKSraFQjlQ5iiColQhpZ9y6HSUYLbwboWJB9tjf6w/WD3j785CJns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4205.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 06:53:40 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 06:53:40 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: pci-epf-vntb: Track link state from both sides
Date: Fri,  4 Sep 2026 15:53:35 +0900
Message-ID: <20260904065335.3059625-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0071.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: bc67af66-3fe8-42ec-dcc8-08df0a5140d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|23010399003|1800799024|376014|10070799003|5023799004|10067099003|6133799003|18002099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	25VrEv2fOz/dKRbqDyFV7nV0PsTVAMFUkAABJ+P9W+AoK2tudlm9riEN40xHHZWleqrqbvn+ADZWr2RGLrw4s4U2UkGTc8G5EH6N/McEi74i9WI4eDzCa8rCBKm8cWUWfG6Fc0RgNFI55ROvvmL4pyQxQ2mWpXer+bh6scA7Y1kOQC3ZkKTjt2Pmct8QAPMzxyIJ2XRFdx1THHlUK8gecSh534RTPk5vytqjMoZJVBvW8hJhafNMuTAI9D+FzMZdH+1bp/3BiV3HjqBRlS0XfgE2ex5lIjU7PvTRxXYsyl1tf2QxUGrVnXFLYGznjyWjFaLmMhj82mvPRSrMFVsVTE9PFSQFPaCgrG5iWWFxWhGDa4LIkKdqX5S6PwybkfCxhVJKKpynCVd3+5JvMLtVKJP9ooDgca5q5x5JY/Ldgn3MZ3CAhdtp7pdaci4nBgE8QfEkxKcfq7tlH+7fHWWxOmAVurlueCL74/7tDMkxA5qb7oJCAbOYs0umV6tdxNADESGSyLvX2cwFXE+rstcNPnZVuOsN2QxmrQJdysjUuJui/uROUCTKmXndFsMs94MRkc2jhXP3C4lO2z2IXJ3cSQwVVILxvbcsuUGr8mpRqTD1ntHILyDYDyXrJv5tAHGa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(1800799024)(376014)(10070799003)(5023799004)(10067099003)(6133799003)(18002099003)(56012099006)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YyddI9wTi+bVjPTUPWrb4rIKiVBHL5D1aJQxZuOdUCbjOSKuugjPwCBhpA2m?=
 =?us-ascii?Q?5S/EAjbFHHe8QLZT4gsE35YROGwZ0R4MQ2oyOMZJOuzf+WsKJldPXFxxAQq8?=
 =?us-ascii?Q?o9Gcln7L1mgCzFDA/HcjxpPSs3dCWrB1erRtmfrjV27RbXAkILcBelAz9Csi?=
 =?us-ascii?Q?M7FIJtwUc4YjcH58pbWXfbnykV2LkmcF7/vW93NVavtQSXt5ZW0+RWjcecsi?=
 =?us-ascii?Q?h1L4SgKX+NDeal/oNR6mjjTXMhAAvU9snKI8qDEngjepZXP7K5au1FtaoKEq?=
 =?us-ascii?Q?z2a0y3r3Emq1ilozlz+KKurQ0lHqG+MnaoyVU5BqarIwlqsTuiuQEizSr6e7?=
 =?us-ascii?Q?5YfP6suos3Gw6jgby7sAlHpUiW360yIhxKT3FB2YDe9DiunqYvwpZI+GstDS?=
 =?us-ascii?Q?z5On8RahBCBvnTlfJbCGEn9RCx5OSNjFW/RdBjnsPBpvsOuZ8HkuJJJtlP3H?=
 =?us-ascii?Q?+pOONVSIf644/cZgpP0z0z57maomD6DWzNfLavrtYZV8uZ3qy/0W75ov3dzj?=
 =?us-ascii?Q?UKBf2L/aBB6xmLd8ruL90ZbPJ3jq13dl1+6BvxResaJklvRyUjCDP25LHyl5?=
 =?us-ascii?Q?q6Ute+1EANQKUJgbjyOc401rrPWMntlH6yDwhCyFaTYDmDeqt1hPj2cE3Lif?=
 =?us-ascii?Q?1AK8EHKGEKxc4ZGJqsaYp+FBdG/rGJRySCm64nxe70G3MMvU11+7w2cZPVhf?=
 =?us-ascii?Q?DVYW266NlhcUDcCpsR8APxZKtLyVX99PPKwmazahvHRc3hG3zb8ov5xqj27k?=
 =?us-ascii?Q?FtrQCtS9gIc5miihSUX8PyPd94qBdm2c1ACMPM1mUhFZkbaMDVkJLCGCVX99?=
 =?us-ascii?Q?pm+fcTQWz8LpuvVmB5Wqcx4Tlg1y/FpFa3O5X1ueY/PcaqWFtDybffdJaQVL?=
 =?us-ascii?Q?tEkWt4P8mjqkqv6xRNbemex+dROIuIYYuZFykHDK97H7NdgKfr0XQqekdrbk?=
 =?us-ascii?Q?jxqf1aPSPAKVPCkMUGdXibHFfpPEXI3iL/dA+/4Z6ZsZohYQK3olTvvOcWxM?=
 =?us-ascii?Q?+dOiwfnucE/TCXMyoAtHVvgYRjh441fPewed+0rEJQyMMiHB5RXYFNuWKRIU?=
 =?us-ascii?Q?FbnaF1IxHN/zOk+F2mWjfT47rvDdSgcUVTcG6khzUsprZD3dndXMF1Smhpyh?=
 =?us-ascii?Q?yU/Su0h9cr16lDUOuOabzHUusAgmYA9ts13cwx6RdTKEK93Vlj4YH0WIAL/F?=
 =?us-ascii?Q?LNcbbcx9aMuHG/Py/wOM0HkVazpRXQJrSbOI88XFTE8CSFHZyUnRZldxywNX?=
 =?us-ascii?Q?YdF5KdpZtd5XnHWUVjyJmpIdsZde7r7PDCXgKT3zCZimcmIFlVzG2tmO0g/n?=
 =?us-ascii?Q?LppTpB6bGxHqud3tiN8SIZNLoQChrozuXJyBtwqcP8bcplb+7npFl9VGlVz3?=
 =?us-ascii?Q?OofzpWWmA/Iip5TQSgKZH3yimRtKY4m3CaztVw1ykb00afF36+7KTBvrPqgx?=
 =?us-ascii?Q?z1EVNeJDxgQzk6w7O0uARcMGJaf+rkAoIBzYQNYrWWzwSnJKGSATj9hdx1WL?=
 =?us-ascii?Q?LdBzH++ymZp7FkmPhRnRD1bTsEiwwVKpn1c/qguCBSwX3bcQJVNRfVWoYC5O?=
 =?us-ascii?Q?fKmNYozzNNTQJQdGb/jlzov/HnUvdmAmmIwSpYUcb033O3j3S6Dy2Bl4Wfez?=
 =?us-ascii?Q?TUSXr3Up+IJm6BN+2zBqL5/dbsXqh0bx269ZW3B1IRKpOxZFNkp0HAeQWG18?=
 =?us-ascii?Q?PNtVuYJ4J4ecjvHQCX5PhIsk8OEKP8/qiU4AFotYr7UGAReanhsGAe/g/eKJ?=
 =?us-ascii?Q?PqdWRi9iNwfXGaprx5DrN/A/8eDICx2eonngY7HVMt9c1GdaEAd0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bc67af66-3fe8-42ec-dcc8-08df0a5140d4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 06:53:40.7059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSsHX3CfHz51KLuolkPyeufRK5zBd2Won7CaxZt2W+6Tz+z+IjHXk8h/Uom+1PUsUhGynhQxz66k8rT0T8LX7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4205

The control-region link status is currently updated only by
COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
NTB link callbacks are empty. Consequently, the HOST can see the link as
up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
leaves LINK_STATUS_UP set without notifying the HOST.

ntb_netdev can hide this device-level state bug because ntb_transport uses
a separate per-QP LINK_DOWN_FLAG message. Use ntb_tool to observe the
device link state directly:

After bringing both sides up, start this waiter on the HOST:

  echo N > /sys/kernel/debug/ntb_tool/<H-device>/peer0/link_event

While it is blocked, disable the link on the VHOST:

  echo N > /sys/kernel/debug/ntb_tool/<V-device>/link

Without this patch, the second command succeeds, but peer0/link on the
HOST remains Y and the waiter does not return.

Track HOST and VHOST enablement separately and report the effective link
as up only when both sides have enabled it, as pci-epf-ntb does for its
two physical hosts. Notify the other side only when this effective state
changes. Serialize the two paths because HOST commands run from delayed
work while the VHOST callbacks may run concurrently.

With this patch, peer0/link on the HOST changes to N and the waiter
returns.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Note: This is a standalone fix, but it conflicts with the following
series:

  [PATCH v2 0/3] PCI: endpoint: Support hardware-owned MSI-X table and PBA
  https://lore.kernel.org/r/20260830151948.3547577-1-den@valinux.co.jp/

That series still has pending issues and will need more work. I will base
v3 on this fix and make the new link-event IRQ honor the MSI/MSI-X
selection made by the HOST.
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 82 +++++++++++++++----
 1 file changed, 65 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index fba65abfb6b2..51200223f53c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -41,6 +41,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 
 #include <linux/pci-ep-msi.h>
@@ -147,7 +148,10 @@ struct epf_ntb {
 	u16 vntb_pid;
 	u16 vntb_vid;
 
-	bool linkup;
+	/* Serialize HOST and VHOST link state changes. */
+	struct mutex link_lock;
+	bool host_linkup;
+	bool vhost_linkup;
 
 	/*
 	 * True when doorbells are interrupt-driven (MSI or embedded), false
@@ -178,24 +182,42 @@ static struct pci_epf_header epf_ntb_header = {
 	.interrupt_pin	= PCI_INTERRUPT_INTA,
 };
 
+static void epf_ntb_update_link(struct epf_ntb *ntb)
+{
+	u16 link_status = READ_ONCE(ntb->reg->link_status);
+
+	/* The link is usable only after both sides have enabled it. */
+	if (ntb->host_linkup && ntb->vhost_linkup)
+		link_status |= LINK_STATUS_UP;
+	else
+		link_status &= ~LINK_STATUS_UP;
+
+	WRITE_ONCE(ntb->reg->link_status, link_status);
+}
+
 /**
- * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
+ * epf_ntb_link_up() - Update the HOST link state
  * @ntb: NTB device that facilitates communication between HOST and VHOST
- * @link_up: true or false indicating Link is UP or Down
+ * @link_up: true when the HOST has enabled the link
  *
- * Once NTB function in HOST invoke ntb_link_enable(),
- * this NTB function driver will trigger a link event to VHOST.
- *
- * Returns: Zero for success, or an error code in case of failure
+ * Returns: Zero for success
  */
 static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 {
-	if (link_up)
-		ntb->reg->link_status |= LINK_STATUS_UP;
-	else
-		ntb->reg->link_status &= ~LINK_STATUS_UP;
+	bool notify;
+
+	scoped_guard(mutex, &ntb->link_lock) {
+		notify = ntb->host_linkup != link_up && ntb->vhost_linkup;
+		ntb->host_linkup = link_up;
+		epf_ntb_update_link(ntb);
+	}
+
+	if (notify) {
+		/* Publish link status before completing the HOST command. */
+		dma_wmb();
+		ntb_link_event(&ntb->ntb);
+	}
 
-	ntb_link_event(&ntb->ntb);
 	return 0;
 }
 
@@ -320,7 +342,6 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 		ctrl->command_status = COMMAND_STATUS_OK;
 		break;
 	case COMMAND_LINK_UP:
-		ntb->linkup = true;
 		ret = epf_ntb_link_up(ntb, true);
 		if (ret < 0)
 			ctrl->command_status = COMMAND_STATUS_ERROR;
@@ -328,7 +349,6 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 			ctrl->command_status = COMMAND_STATUS_OK;
 		goto reset_handler;
 	case COMMAND_LINK_DOWN:
-		ntb->linkup = false;
 		ret = epf_ntb_link_up(ntb, false);
 		if (ret < 0)
 			ctrl->command_status = COMMAND_STATUS_ERROR;
@@ -1456,11 +1476,34 @@ static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
 	return 0;
 }
 
+static int vntb_epf_set_link(struct epf_ntb *ntb, bool link_up)
+{
+	struct pci_epf *epf = ntb->epf;
+	bool notify;
+	int ret;
+
+	scoped_guard(mutex, &ntb->link_lock) {
+		notify = ntb->vhost_linkup != link_up && ntb->host_linkup;
+		ntb->vhost_linkup = link_up;
+		epf_ntb_update_link(ntb);
+	}
+
+	if (!notify)
+		return 0;
+
+	ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
+				PCI_IRQ_MSI, EPF_IRQ_LINK + 1);
+	if (ret)
+		dev_err(&epf->dev, "Failed to raise link event IRQ: %d\n", ret);
+
+	return ret;
+}
+
 static int vntb_epf_link_enable(struct ntb_dev *ntb,
 			enum ntb_speed max_speed,
 			enum ntb_width max_width)
 {
-	return 0;
+	return vntb_epf_set_link(ntb_ndev(ntb), true);
 }
 
 static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
@@ -1620,7 +1663,7 @@ static u64 vntb_epf_link_is_up(struct ntb_dev *ndev,
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	return ntb->reg->link_status;
+	return READ_ONCE(ntb->reg->link_status);
 }
 
 static int vntb_epf_db_clear_mask(struct ntb_dev *ndev, u64 db_bits)
@@ -1638,7 +1681,7 @@ static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
 
 static int vntb_epf_link_disable(struct ntb_dev *ntb)
 {
-	return 0;
+	return vntb_epf_set_link(ntb_ndev(ntb), false);
 }
 
 static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
@@ -1750,6 +1793,10 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		goto err_bar_alloc;
 	}
 
+	ntb->host_linkup = false;
+	ntb->vhost_linkup = false;
+	ntb->reg->link_status = 0;
+
 	ret = epf_ntb_epc_init(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to initialize EPC\n");
@@ -1833,6 +1880,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
 	epf->header = &epf_ntb_header;
 	ntb->epf = epf;
 	ntb->vbus_number = 0xff;
+	mutex_init(&ntb->link_lock);
 
 	INIT_WORK(&ntb->peer_db_work, vntb_epf_peer_db_work);
 	disable_work(&ntb->peer_db_work);
-- 
2.51.0

