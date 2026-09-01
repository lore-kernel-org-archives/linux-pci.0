Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021110.outbound.protection.outlook.com [40.107.74.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75022387371;
	Tue,  1 Sep 2026 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244378; cv=fail; b=gBf3yMh/kUNc/fvZyyzkKxv6HqPcRBJ1peQUFf0QQOFzxhkFXvEj6bq5wzDOhsSZaAaovmozG2x/M8/2Ku31X3Olt/WwoctIw03PKiEK1ilQUXJhe82pYTifYASfjZNdmx+FlKfDueQryA2QiOVDSK+TktHoAnyEnCfZ44mphtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244378; c=relaxed/simple;
	bh=IFNa1m0IGBSa2L/eEEZCEOrM9B1qBcBMqjotH2CMG8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dNc+4xKjL54lVwJm7EZu66RvnEi5FYjCCISD4OwgMyX0zU5Sz18ODudr8tpOqbTLrVnn0e++/o/uZ8GeoKw88xr72nW6SPZtH4TmrfqsshEk9Z1/1+vf6N58SC5exKspR9sLf1942BY+8eIa12TFZ1TK2/3vMZPCL0770m3HMCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=m4ZKXSLC; arc=fail smtp.client-ip=40.107.74.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="m4ZKXSLC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E968i0SKDOHiZV7hf/8WkEGg1ZLvZbrnKxo3eKb/0m1/jwj1xn8oAx7RZ07i5ImQazwqIjtEZ4CCPam5DmyEvPTPETK+cXM+sFmPDVFhAy/i2Z4/P6DRUSVZ/Dq88bvH3BFrum8R+EfP3+rDYJleV+LBv5XROJMFashZzYNIA5w8xeTuk4yr+SshSxoTao9651+9ZX2ynKLgWfBOU9ADB5GIa7gStOEHkG6jtVzwnFuA5L1WDmcXUjh9xbfSyP7kLAcjjdmg9qkCSKVBh7kA31hPn5YQfasfSFmeK1HWfge+sMh6ARydpPU43lOCUz/16vDV8SpuO/+tayvH8QNnpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8U9Yj0M7eWCIkmDd0s2PArUjYlCJQI96EfxIHySVx+M=;
 b=UAnWX2qsyeSuni5KnUhYMzBjZ5jYHZiEq4JkUOZ6GcbO4Dld5i8kVq6yIm01G1hjivGMVQP0yokt/Ix9MIIKSVqeQalKz/FB9FHmBoZLDf4Zq13WiUWtbCzfxoyHyOMExoOCbYufIvsOLSEreRGMSJkmZKU+dUJgm8wN6BwX3kqZHdTSQ40fc8iGEpXnFzFMBTU0jy651VENtfOq8pLuY8SsFw4HNHStvtbrxf5u+vmpuTQgqStxniUbxLhilRl7tVxsGVFpHMKrnj0OvvOdTViwvowp5V0hJpBI2PX+jOaxcVHkelWB+BttjoOrD699RN5w6JdrHAuo8k9JSCw/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8U9Yj0M7eWCIkmDd0s2PArUjYlCJQI96EfxIHySVx+M=;
 b=m4ZKXSLCkP2zphg06WjFPNetsFvlmSpy3C5/9P7Cl9Ixy7LrQ7HZrbM5KpVoOF1CaNwZIIvYOFSh5lP8B4GdiKmFsU+64JkiRkVRYhupxJVPdruhWn7NCPKNjtBpbKiuGkheQ3qGBo6GrIwZkCEY8K5PLTFV67RZ0PCmaUjz6Wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2700.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 06:32:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 06:32:49 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] PCI: endpoint: pci-epf-vntb: Manage virtual NTB and PCI bus lifetime
Date: Tue,  1 Sep 2026 15:32:38 +0900
Message-ID: <20260901063238.631166-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260901063238.631166-1-den@valinux.co.jp>
References: <20260901063238.631166-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0353.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2700:EE_
X-MS-Office365-Filtering-Correlation-Id: d4538fa1-a1ef-4b31-ba7c-08df07f2d721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|10070799003|366016|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rG4EQ3KuQijPJuqj5C3RlvDJTA/t+Drk8j8JfJe0J3qsUtkMr1/zi5XdJpRkxy+ioq/o/B6Q5vnJ0VSuSh/4HVKhxGsFkueC1wuo5MOjnf6CnzfIy/lmMKMq1b88BHzo6V0Fph6HGf8nCHB+eWKCoRF5uqHeMxfP1UxmwOgIo8W4GNstiNseYNXHAXX12v8WzDUyCOW+PUMnLXMqPO4mEDqvpj4eyFymdOR4EZlyBAMLdK95MBcNklGnIWm0FUqTY6bpjmSH9r86hTf6045gMX5pNEEG7PKtEOUQEeblwe+HvTYxsfX5TVmAghV+eM6A1sDpGEAZ8RNU+iCphAX6OB48L8OHDb2wTDx9tl8GyigtipU4zJTC6qgF9Uhn/xFEEg6h0EZ5YF7Db0wIufAw+KuXWWvNEoVpGi2m/7/CAwheydlHI1liaW46Jfe63Ypmj6PlZ7SAqz7+q60g/KLHM5iLh3m9JfnhczdueZYh01/KQoMnknRAcC/ZtQKEAfAotS+s8i2SeQ9KKHjCC9AOflrr1wioX1vFo3hqlGJQZeH7/uogj5pGOWS84cillKnmB5QbOLGKqzEe3GOAKDt+8ztKjDM9Csw+6qv6TU3LpAjWreE5bvYVjY58ji4WDPIS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(10070799003)(366016)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6hly8L8ejRwZETfm5QclQymRRb1CsH4QaE/9G+jGfYTbixGLPbXhLiQ5Q2fr?=
 =?us-ascii?Q?D59MNs1L4/T7nASEFNNVsm9B3qReTBlLTiug0GhF2+3JLeOZKIKBYVaUji/V?=
 =?us-ascii?Q?FDoPr1FKnTd5+lgIIywMX3euawrZSSAmXDUtuBIePYr3sCwSTkq1RRhRRehu?=
 =?us-ascii?Q?c6g5ZSW3ERCWLrOnPm9VXUBnaykCm9XV3vaJdPOzpJunz/pd0YY6hB9eJmto?=
 =?us-ascii?Q?K2DlcLBKRcd320BchVm7u5PXJ2nEqAgGEyxijdQZzA5AHUQ/tQkRmxO1VEla?=
 =?us-ascii?Q?zsbwNHVDUORixJxCXIkA2FEGyYFUGlAvjuOAxQ7XHyqr4UzaQwDoScFRFFvc?=
 =?us-ascii?Q?FybmmTzECJCOD6fpQErnMoF34LCQdkHUL8DWCM2QAtXR6XZKBNnzJ6wXet55?=
 =?us-ascii?Q?AHbFD6ckXLmGBHpxpqKAqBQpLQB/S/+RJToSZjh1A9MEIHhai8pqsc1A+O9s?=
 =?us-ascii?Q?lao+fqM2c/1TzRu9j1BDP9sdbhg7KGmwMEZtQewhHBLmCMP+4C9epUwDT3JU?=
 =?us-ascii?Q?YLOoMU4Rtt4xKBMvvsT1YRpo65m/czuv8P6WOrR43KNU+Ae4uOdZQ64a155d?=
 =?us-ascii?Q?M7JuMKeWtMIkZx9N1M3qNVQ34fRf4iHnoq8TTf6jPNtPBK/avyRRiwAkc4Rb?=
 =?us-ascii?Q?jreEQP+cHMZ161bxozkN6o2Fet1LPawe6fV29YbacsQEvneJc5qQg9fsYQ78?=
 =?us-ascii?Q?cNGcY65aH2LhPf2DmG0+GNqJyFylE6zwc1Qd54pWWsjQDPCbWlUI1ZSZQd4X?=
 =?us-ascii?Q?eNl8R+60vgz4cIOzLxlP+TwD2bpe/92YsxSlnL41V7olcPXTxPH+XVGfaqsY?=
 =?us-ascii?Q?zN8zgvaz8qTvUSefZ8Cpf1bFR8DZRe2kECAUUWYdaWVdIWvup96xt0OktXDL?=
 =?us-ascii?Q?srOeyG0ZfB9rGGSI1ICas9cIKl9Xf7ywz2X72t7q7K3+ydg8a8rp+096wgLF?=
 =?us-ascii?Q?bYioE90AJSythlg58yWf2RP7O5rIBN7z3UamI4RJDK7rPWon5AJjVvPbFHMJ?=
 =?us-ascii?Q?NpSrc9yWr/SSLcKX5l/MfHb79BDUa1UIsfo5LZ7vCCwvu0KuBrf2QwM1FjWs?=
 =?us-ascii?Q?kJjWDUdbg7A/Ye6fAgUS9OcXhvoHAo5Hxn7rBv8xov0rPO9j0qMMAZRCLK7x?=
 =?us-ascii?Q?5IPJefIWkzGhJ0xUrITX/JlK0416ghN4TC31CQSX+fYI3s+enVvoAQojiyOd?=
 =?us-ascii?Q?LdESiW0/jB71GW8xWPelY02GyLRbUHvT48Pit2ManYYqkpX4dS7tFQ++a9uy?=
 =?us-ascii?Q?aM8jw+fvP2BjniNHt1Yp6bnS1CPr9e4VA13z0rE9Yf084CX6AUuu9nhL7pGF?=
 =?us-ascii?Q?E5aA4bnD7ItD/Czvyt0pU+oJa5sfSyWO6P45LGeoltgL6FbsG8KeTzQEpMtG?=
 =?us-ascii?Q?5hICGXTNf9fW1YGTW93FUfDjOQNW//+h53HrrG4ycjmDWXemtZ6O5IcAvLx7?=
 =?us-ascii?Q?4U5iAWD/cD65RMsBiaG0YRz9175qYlOlEN3Bz+y7P0/oVc3IvDjR7HfEaC0Q?=
 =?us-ascii?Q?mAuRjkj5Nayfhh1YrqmYtPEFlLl9qdb5mxGDnR4USldEiXCR9rL6XPa+S9gp?=
 =?us-ascii?Q?GlaP2yt/Fw4sFkYO3Gczf7q6c7hPSn9PylJuiulmcKhpRPDLKereTJM+d5qo?=
 =?us-ascii?Q?FOcu1nCqPR3F2iM4/I1fg6adrAYV8nzd9w/lmOMhwpHSM9hI1dsXWVj11Uru?=
 =?us-ascii?Q?41rVeonjBTbr14zBFQeErnJ4Gqt0+ZBePhdtpAO2Atf7C7XzigvCybZ12M2F?=
 =?us-ascii?Q?XB19M8KdW/+OIbJvy5/VlXCrpIQUFJJCq+31WNAJyWQZpmTEyFio?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d4538fa1-a1ef-4b31-ba7c-08df07f2d721
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 06:32:48.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcVJpV5cKGiQmhR06NZJ+rZDrATbMyvoIiYhiihQyPhnGznhZwAx6Jcahhl6XiuoFq+Y1qc4nsOVdoMrTmqJBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2700

The virtual PCI driver registers an ntb_dev but has no remove callback.
Unbinding the endpoint function can therefore free BARs while the NTB
device and its client still use them. It also leaves the virtual PCI
devices and root bus allocated.

Allocate an ntb_dev for each virtual PCI probe and unregister it from the
matching remove callback. Start command processing only after registration.
Publish the device for doorbell IRQs at the same point. During remove, stop
the command work and drain IRQ handlers before unregistering the device.

Retain the root bus returned by pci_scan_bus() so it can be removed on
unbind. Unregister the virtual PCI driver before releasing endpoint
resources. Stop and remove the root bus under the PCI rescan/remove lock,
then release its host bridge.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Cc: stable@vger.kernel.org # 6.0+
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v6:
  - Rework v5 patch 5 on v7.3-rc1.
  - Publish ntb_dev only after registration, and tie command work and
    doorbell delivery to its lifetime.
  - Retain and remove the virtual root bus, then release its host bridge.
  - Drop v5 patch 4; f7245901de89 ("PCI: Check parent for NULL in
    of_pci_bus_release_domain_nr()") fixed the bug it worked around.
    v5: https://lore.kernel.org/r/20260226084142.2226875-6-den@valinux.co.jp/

@Frank, the code changed substantially since v5, so I did not carry your
R-b tag. I would appreciate another look.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 85 +++++++++++++++----
 1 file changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 412e8cc6fb1d..992f5e7f8d4a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -132,7 +132,7 @@ struct epf_ntb_ctrl {
 } __packed;
 
 struct epf_ntb {
-	struct ntb_dev ntb;
+	struct ntb_dev *ntb;
 	struct pci_epf *epf;
 	struct config_group group;
 
@@ -166,10 +166,15 @@ struct epf_ntb {
 	void __iomem *vpci_mw_addr[MAX_MW];
 
 	struct delayed_work cmd_handler;
+	struct pci_bus *vpci_bus;
 };
 
 #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
-#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
+
+static struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
+{
+	return ntb->pdev->sysdata;
+}
 
 static struct pci_epf_header epf_ntb_header = {
 	.vendorid	= PCI_ANY_ID,
@@ -195,7 +200,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 	else
 		ntb->reg->link_status &= ~LINK_STATUS_UP;
 
-	ntb_link_event(&ntb->ntb);
+	ntb_link_event(ntb->ntb);
 	return 0;
 }
 
@@ -284,7 +289,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	     i++) {
 		if (ntb->epf_db[i]) {
 			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
-			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
+			ntb_db_event(ntb->ntb, i - EPF_IRQ_DB_START);
 			ntb->epf_db[i] = 0;
 		}
 	}
@@ -348,12 +353,18 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
 {
 	struct epf_ntb *ntb = data;
+	struct ntb_dev *ndev;
 	int i;
 
+	/* Pair with smp_store_release() in pci_vntb_probe(). */
+	ndev = smp_load_acquire(&ntb->ntb);
+	if (!ndev)
+		return IRQ_HANDLED;
+
 	for (i = EPF_IRQ_DB_START; i < ntb->db_count; i++)
 		if (irq == ntb->epf->db_msg[i].virq) {
 			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
-			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
+			ntb_db_event(ndev, i - EPF_IRQ_DB_START);
 		}
 
 	return IRQ_HANDLED;
@@ -985,7 +996,6 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 	}
 
 	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
-	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
 
 	atomic64_set(&ntb->peer_db_pending, 0);
 	enable_work(&ntb->peer_db_work);
@@ -1340,6 +1350,7 @@ static int vpci_scan_bus(void *sysdata)
 		pci_unlock_rescan_remove();
 		return -EINVAL;
 	}
+	ndev->vpci_bus = vpci_bus;
 
 	pci_bus_add_devices(vpci_bus);
 
@@ -1425,7 +1436,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	int ret;
 	struct device *dev;
 
-	dev = &ntb->ntb.dev;
+	dev = &ndev->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
@@ -1563,7 +1574,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
 						PCI_IRQ_MSI, interrupt_num);
 			if (ret)
-				dev_err(&ntb->ntb.dev,
+				dev_err(&epf->dev,
 					"Failed to raise IRQ for interrupt_num %u: %d\n",
 					interrupt_num, ret);
 		}
@@ -1681,13 +1692,18 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 
 static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	int ret;
 	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
 	struct device *dev = &pdev->dev;
+	struct ntb_dev *ntb;
+	int ret;
+
+	ntb = devm_kzalloc(dev, sizeof(*ntb), GFP_KERNEL);
+	if (!ntb)
+		return -ENOMEM;
 
-	ndev->ntb.pdev = pdev;
-	ndev->ntb.topo = NTB_TOPO_NONE;
-	ndev->ntb.ops =  &vntb_epf_ops;
+	ntb->pdev = pdev;
+	ntb->topo = NTB_TOPO_NONE;
+	ntb->ops = &vntb_epf_ops;
 
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret) {
@@ -1695,16 +1711,41 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = ntb_register_device(&ndev->ntb);
+	ret = ntb_register_device(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to register NTB device\n");
 		return ret;
 	}
 
+	/* Publish after ntb_register_device() succeeds. */
+	smp_store_release(&ndev->ntb, ntb);
+	queue_delayed_work(kpcintb_workqueue, &ndev->cmd_handler, 0);
+
 	dev_dbg(dev, "PCI Virtual NTB driver loaded\n");
 	return 0;
 }
 
+static void pci_vntb_remove(struct pci_dev *pdev)
+{
+	struct epf_ntb *ndev = pdev->sysdata;
+	struct ntb_dev *ntb;
+	unsigned int i;
+
+	/* Stop the work reader, then close and drain the IRQ gate. */
+	cancel_delayed_work_sync(&ndev->cmd_handler);
+
+	ntb = xchg(&ndev->ntb, NULL);
+
+	if (ndev->msi_doorbell)
+		for (i = 0; i < ndev->db_count; i++) {
+			if (epf_ntb_db_irq_is_duplicated(ndev->epf, i))
+				continue;
+			synchronize_irq(ndev->epf->db_msg[i].virq);
+		}
+
+	ntb_unregister_device(ntb);
+}
+
 static struct pci_device_id pci_vntb_table[] = {
 	{
 		PCI_DEVICE(0xffff, 0xffff),
@@ -1716,6 +1757,7 @@ static struct pci_driver vntb_pci_driver = {
 	.name           = "pci-vntb",
 	.id_table       = pci_vntb_table,
 	.probe          = pci_vntb_probe,
+	.remove         = pci_vntb_remove,
 };
 
 /* ============ PCIe EPF Driver Bind ====================*/
@@ -1796,12 +1838,25 @@ static int epf_ntb_bind(struct pci_epf *epf)
  */
 static void epf_ntb_unbind(struct pci_epf *epf)
 {
+	struct pci_host_bridge *bridge;
 	struct epf_ntb *ntb = epf_get_drvdata(epf);
 
+	pci_unregister_driver(&vntb_pci_driver);
+
+	if (ntb->vpci_bus) {
+		bridge = to_pci_host_bridge(ntb->vpci_bus->bridge);
+
+		pci_lock_rescan_remove();
+		pci_stop_root_bus(ntb->vpci_bus);
+		pci_remove_root_bus(ntb->vpci_bus);
+		ntb->vpci_bus = NULL;
+		pci_unlock_rescan_remove();
+
+		pci_free_host_bridge(bridge);
+	}
+
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-
-	pci_unregister_driver(&vntb_pci_driver);
 }
 
 // EPF driver probe
-- 
2.51.0

