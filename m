Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020083.outbound.protection.outlook.com [52.101.229.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CACE5304A6;
	Thu, 15 Oct 2026 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074451; cv=fail; b=kyTYAgBgheZaKnonvRXl9YFoZw5GXI8F5UIr8MbC0KoJfqdxr9CFN+F4Ab1/mzcLAB+XfsTV4qqfE8yakLOloGjD8P1QdYwkSnBipzyGOvOPwSltkyQErsGGcnAAlOOOSkM1R7psPZfCpqs769w99H43mWy8lsLOah/klu3ykME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074451; c=relaxed/simple;
	bh=6aHz5YmXmZNB3fkUYBntdSj9chmNeTKYKTMrd1X8Z0s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SkkdxRYqenPLnZsWbsmf8AL6DMY+RIAp7MVdcZV9c7PewNW7V+nbjLhhEgBwjlEh3HnkRE+0rO0OrCXJoSHV7JSIODRL5xBh4KsuDrxOaBZydLFbZDLAbFHvwxORmfwaBAYdHPyD5K439x21ZIlx+ps38oyHcOFwqWZcfCKjNag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NuNxrbCE; arc=fail smtp.client-ip=52.101.229.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NuNxrbCE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obp5arQYX4P5vF3WKIK/3II+i/CmS2S1kHHBkdeGMO5Ric2s0XWeF4eNvnb9zusYlJm+Gkk4d2Vh6SdO90amih5VvLcXYdi63VtrO6Gg2NRMWjOwmUe4gKm8RlwisGfj7KsILbBc7rxU+AEan4h1MDF6m4uuw1ptmxwVeaE3xjoW4hkkuGKL2dGWOHUwzZ4oAEQyRrbnkMwpn4lUFJo4EGTiNFQlfxJTXRm2WRdJXMot61VoxLpnvTzADPDXQ+VRTGBuRzrlOH8pX+YoM89FC24GoIXb7MyhUn9/IkhRgpfj5o5p42c7m6gXQTDetbM2FGi5c9eGMePrylHMfF11XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoniFQymjLkXyf8eQ0KquXRJBd6EprL+CrKJXPzd97U=;
 b=cxuOvEoBbT8FZ/InLx8Qr8vZiyHIeh5qAVHF8jHLppHIo3mQkymgKYSL5r1sXSmaSX3tMgjp9mnsdeU8/Ifbg6+qtVShJ3O+6iKS8S9GEcRQxj2nSXDaMpJL0n71zAkQJSiLQdMMPFtvM/AV9dFRpupdFQLL1BaCRnUZxfjjCFB7pbkMolkFPf2tMxSKOgfXS4x6auW6KsnjRWTjOJ1568VFILay2CFhhbhNLGHE/csOP8Ky+KUuMaZGm9Ms8GdxLwZEYBaRQ8RtiG/CvafA23rGHcV+WO/MnpMJGUjdBVH7NEF7XzbximZ8bAEMDlxOKh0cE18cHOi6UjbdlrTTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoniFQymjLkXyf8eQ0KquXRJBd6EprL+CrKJXPzd97U=;
 b=NuNxrbCEDRSiNJxQ+jITkKuxjJ2h9keKTCvGdDbkeW+TLoAYNgy9cUo9oNmM3NcvIquPV1jTP9x9+tCa/JL94V/mj9mm7AsHWb+xdlJLCiyRRNBhnpG7n2gKcjx3d6Z7HUpj7CZPqhQwQ9IZCr59nG/hBismaXWH4R7csaBjJ/E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS7P286MB6240.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:421::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 14:27:25 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 14:27:25 +0000
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
Subject: [PATCH v4] PCI: endpoint: pci-epf-vntb: Track link state from both sides
Date: Thu, 15 Oct 2026 23:27:16 +0900
Message-ID: <20261015142716.3452900-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS7P286MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc4d883-d587-46ce-9764-08df2ac86ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10070799003|6133799003|3023799007|10067099003|18002099003|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	DTC0v6PidktqW/sscPPi5+yDgqbys3jTDFy2SmdW3orUrsgqyyiXC2RsQyAdYY/EO+uE81ylNFzOw2C+AA0vAy7IQSptQPn/Q7fm6eU5gPIQSzGSiaweDM3P4e+jmbRlmanqin2oXJPDWpqXjLZ3b6llPbeGkgJMsW/KCrfn0YXKVZ+MZjGl9b8tKxwmEn6F/Jh/8BLQeBXKs3GYAtDdNh2/crX9Jn/ozEShqWH7OB3Y56+KFjl/8/DUnKvSYBWhKYtmnKUdiY/VFes9atTlV8SWz2ufcXAzUtOSCWeY7zSBxjX3LypDXf67lmzhuoLiUifiM63J9djXVhtiUjOvQLvJ10dUsluRQoYQs8M8CMLy+KTtETsG7ThlWXZbMq1PNXHNqXNS7XZ/dH8djBoCjLpjScOM7Lh8W9dTJ4ej5AWzjG6pFL5Kt4ACuqtvCFLdgBCNmA8XOGxzMp0rjVfWr0eTsXQg2xXp5KQrlu6rTdjaJWUWr7y6kgiYDzYIIjnuC+hf/TuO8bo65xOjN4RejbtwSkOmQ1iagNHhwoNTZ5IWCgi5ex5myEWJlrxJh/cJkHwTZMQiS4OwLoUTkr9pxWqEjExpmJzRKD5lVdAFFdRznJqX81BxEN/DLUc51IFR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10070799003)(6133799003)(3023799007)(10067099003)(18002099003)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ignLGYTwMzY0iLo/8Ugeex4z1GpHUi6s8tu0W+YBXgujBwZJH3HuAq0RAktv?=
 =?us-ascii?Q?ZcRdD2/ZlwIjkbSbkHNJdfgr17r0wzzV73MRbUC9tf67mHdctOeEpOSXK645?=
 =?us-ascii?Q?bdW6w6nMHWXPynquw4WA0zFM/I6KURhj2pX7Oc2frZ6DyISi4weTc1Tf7/jL?=
 =?us-ascii?Q?EzrLGvJQAYyDsnTDLZZZqmI9Y4fx5gjW8q5Bg+Gy1l1XQaErJhnaIGUDNXv+?=
 =?us-ascii?Q?Z222zB32HU6x9UHcocpzgx1/pcBn/PTY3eri3let4KzfIRDDMlM6PelhVyNv?=
 =?us-ascii?Q?l8in+j/w8bUhKPfrKYzWoAkXS/nYAHyK7CHGWc7utc4Av44uQBuWXNHomMPI?=
 =?us-ascii?Q?hIdVFujivQO0CUZtuCb8dLnVr7tufwkAMbSVdMBg5XXdMHGEiSiAB9vvPFLK?=
 =?us-ascii?Q?9RjddJ+HrXEG4uNtjzpR0o0u07wA4ANyNMydg8d+ao9wI0B/aNk8957H0SiR?=
 =?us-ascii?Q?vWRzTUYJQKLHjwZ6O10yygFsaK33fKkDYkIstUAI2oU58RRymknstkRUoJVl?=
 =?us-ascii?Q?9gV/fhrWYGcUJ2yJZAYfP6Ka+KzQ4LVrQEwyh2kjy/SAq3AO2GyAkwXlytFf?=
 =?us-ascii?Q?E7C6Ucoo31K5tq4cH/AwIA4hNkmxCtH6xdp7Eh2cRfwNcmXHfb1YskN1DnIZ?=
 =?us-ascii?Q?LmFCD8TUB8GLjtW+m8yTTKhxMQcHjM91gitKHaEIkxuz7ylzuYMWMBOfeBHL?=
 =?us-ascii?Q?Zvs6lAMBV78+PzzPS549cZ9UJNeteR834gKLL/XhjBl0fdOl0EzSqI8gqtsU?=
 =?us-ascii?Q?BBKg/mVGDmXrjS2o1ho8IadoprMoJnHXj7ZldCNabB5H76i3kGrEGpqoUWTp?=
 =?us-ascii?Q?IVph+r4hzp4OroM2TM8JAfd/CEj1NpgSbsfUULUKWtGy1jXEhHVK3xfil978?=
 =?us-ascii?Q?7fzww9xgsks1EYP/100ZgcCpBfGt6e1kKOVZEEXVGUMLmck3GkwzH2ryN4+k?=
 =?us-ascii?Q?99S6UiPFsF7R9QxSd4vRSCkjbEhXeQy8XNRNQearWNcWFYyg4a2pYaqy9WkF?=
 =?us-ascii?Q?NL1g6tCplo2WX2sR2LYDrJSXr9OnV6tNNNL+XXI5Ii1JzGrfqDQRsTdNnUWM?=
 =?us-ascii?Q?NoaeL1maBjRLfHkwCiyxWNisY66CSXR5ahPIK7S94TOTK4HsyUU+978EpjO+?=
 =?us-ascii?Q?goFj/jZ1WZd/J+N0inHwW/pUlul/PRqz5QoQP/E73jtXUmUbZsvR4bUTAbPc?=
 =?us-ascii?Q?gef1Z1+eHUlP4pUdnkhQ2lTWztLKMGOurclTpUDR3Ly2+IoNlZl9vvYhdFY2?=
 =?us-ascii?Q?Ag7dnLlfLYAppLqdbmdLvIFKO91MoaqxI1V18cl+awjpuiBcyqGyoPD4Ujsb?=
 =?us-ascii?Q?LjC3xcRGyNRfM/pGjGYZpy0o5p6eoJ/78qVEd2ZqdMQ1b0zasjoAG8tj4EnY?=
 =?us-ascii?Q?TNKGBUCfX5CdK62U06BDH89hxsjdOdkX57BIuPDmBfvX7hhk0l+nCI7/gQHh?=
 =?us-ascii?Q?VXp34jcsWSPTahIrAupzNNfNzIFZce0KrVoI7Ubq1gjuFN2vdxMnvIx0x56G?=
 =?us-ascii?Q?FbmHEhZv/0WePtvMTs2sdRWoeyvXWNglp2ElgD43HYmQNkbUWRwqWAG4vDB4?=
 =?us-ascii?Q?F6myCVs34Ayksu/LdnnrdT65xmz6wYWkxY4M/3AiGQBRXg37RsyTfEmXn4bq?=
 =?us-ascii?Q?mGoWT/olOV28SS7arJMXia4kx4hDNIHq5pSeWsrEdyIFiKBwnRwzfMZPTS7i?=
 =?us-ascii?Q?P4+9fU4CMehiOyMBvxDynrklR20Uuev4+jeYYGc773mDMKKZ7PWZiCgrTnnA?=
 =?us-ascii?Q?Yk5pXKUzut81BG6VRwjXsa0mlH9YLsYMkax4B2jlxIWRNSConeal?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc4d883-d587-46ce-9764-08df2ac86ed7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:27:25.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MW2ny73OrQJEao1/2SovetspzfhgehuqQK3jzZ7vSO14FYLmXvye1foSaRH6D60iwLsKANduqsJAoiNy16Beqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6240

The control-region link status is currently updated only by
COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
NTB link callbacks are empty. Consequently, the HOST can see the link as
up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
leaves LINK_STATUS_UP set without notifying either NTB client.

ntb_netdev can hide this device-level state bug because ntb_transport uses
a separate per-QP LINK_DOWN_FLAG message. Use ntb_tool to observe the
device link state directly:

After bringing both sides up, start one waiter on each side:

  HOST# echo N > /sys/kernel/debug/ntb_tool/<H-device>/peer0/link_event
  VHOST# echo N > /sys/kernel/debug/ntb_tool/<V-device>/peer0/link_event

While both waiters are blocked, disable the link on the VHOST:

  VHOST# echo N > /sys/kernel/debug/ntb_tool/<V-device>/link

Without this patch, the link-disable command succeeds, but peer0/link
remains Y on both sides and neither waiter returns.

Track HOST and VHOST enablement separately and report the effective link
as up only when both sides have enabled it, as pci-epf-ntb does for its
two physical hosts. Both NTB clients observe this effective state, so
notify both sides only when it changes, including the side whose request
completes the transition. Serialize the two paths because HOST commands
run from delayed work while the VHOST callbacks may run concurrently.

With this patch, peer0/link changes to N on both sides and both waiters
return.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No functional changes, but:
    * Rename link state flags and helpers for clarity. (Mani)
    * Make the *_set_link_enabled() return patterns symmetric.
  - Add Frank's Reviewed-by tag from v3.
  - Retest using ntb_tool.
  - Link to v3: https://lore.kernel.org/r/20261014071448.2473208-1-den@valinux.co.jp/

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 98 +++++++++++++++----
 1 file changed, 78 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 07ba338732d4..bebdd93a067c 100644
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
+	bool host_link_enabled;
+	bool vhost_link_enabled;
 
 	/*
 	 * True when doorbells are interrupt-driven (MSI or embedded), false
@@ -183,24 +187,55 @@ static struct pci_epf_header epf_ntb_header = {
 	.interrupt_pin	= PCI_INTERRUPT_INTA,
 };
 
+static void epf_ntb_update_link(struct epf_ntb *ntb)
+{
+	u16 link_status = READ_ONCE(ntb->reg->link_status);
+
+	/* The link is usable only after both sides have enabled it. */
+	if (ntb->host_link_enabled && ntb->vhost_link_enabled)
+		link_status |= LINK_STATUS_UP;
+	else
+		link_status &= ~LINK_STATUS_UP;
+
+	WRITE_ONCE(ntb->reg->link_status, link_status);
+}
+
+static int epf_ntb_notify_link(struct ntb_dev *ndev)
+{
+	struct pci_epf *epf = ntb_ndev(ndev)->epf;
+	int ret;
+
+	ntb_link_event(ndev);
+
+	ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
+				PCI_IRQ_MSI, EPF_IRQ_LINK + 1);
+	if (ret)
+		dev_err(&epf->dev, "Failed to raise link event IRQ: %d\n", ret);
+
+	return ret;
+}
+
 /**
- * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
+ * epf_ntb_set_link_enabled() - Set HOST link enablement
  * @ntb: NTB device that facilitates communication between HOST and VHOST
- * @link_up: true or false indicating Link is UP or Down
- *
- * Once NTB function in HOST invoke ntb_link_enable(),
- * this NTB function driver will trigger a link event to VHOST.
+ * @enabled: true when the HOST has enabled the link
  *
  * Returns: Zero for success, or an error code in case of failure
  */
-static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
+static int epf_ntb_set_link_enabled(struct epf_ntb *ntb, bool enabled)
 {
-	if (link_up)
-		ntb->reg->link_status |= LINK_STATUS_UP;
-	else
-		ntb->reg->link_status &= ~LINK_STATUS_UP;
+	bool notify;
+
+	scoped_guard(mutex, &ntb->link_lock) {
+		notify = ntb->host_link_enabled != enabled &&
+			 ntb->vhost_link_enabled;
+		ntb->host_link_enabled = enabled;
+		epf_ntb_update_link(ntb);
+	}
+
+	if (notify)
+		return epf_ntb_notify_link(ntb->ntb);
 
-	ntb_link_event(ntb->ntb);
 	return 0;
 }
 
@@ -325,16 +360,14 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 		ctrl->command_status = COMMAND_STATUS_OK;
 		break;
 	case COMMAND_LINK_UP:
-		ntb->linkup = true;
-		ret = epf_ntb_link_up(ntb, true);
+		ret = epf_ntb_set_link_enabled(ntb, true);
 		if (ret < 0)
 			ctrl->command_status = COMMAND_STATUS_ERROR;
 		else
 			ctrl->command_status = COMMAND_STATUS_OK;
 		goto reset_handler;
 	case COMMAND_LINK_DOWN:
-		ntb->linkup = false;
-		ret = epf_ntb_link_up(ntb, false);
+		ret = epf_ntb_set_link_enabled(ntb, false);
 		if (ret < 0)
 			ctrl->command_status = COMMAND_STATUS_ERROR;
 		else
@@ -1472,11 +1505,29 @@ static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
 	return 0;
 }
 
+static int vntb_epf_set_link_enabled(struct ntb_dev *ndev, bool enabled)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	bool notify;
+
+	scoped_guard(mutex, &ntb->link_lock) {
+		notify = ntb->vhost_link_enabled != enabled &&
+			 ntb->host_link_enabled;
+		ntb->vhost_link_enabled = enabled;
+		epf_ntb_update_link(ntb);
+	}
+
+	if (notify)
+		return epf_ntb_notify_link(ndev);
+
+	return 0;
+}
+
 static int vntb_epf_link_enable(struct ntb_dev *ntb,
 			enum ntb_speed max_speed,
 			enum ntb_width max_width)
 {
-	return 0;
+	return vntb_epf_set_link_enabled(ntb, true);
 }
 
 static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
@@ -1636,7 +1687,7 @@ static u64 vntb_epf_link_is_up(struct ntb_dev *ndev,
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	return ntb->reg->link_status;
+	return READ_ONCE(ntb->reg->link_status);
 }
 
 static int vntb_epf_db_clear_mask(struct ntb_dev *ndev, u64 db_bits)
@@ -1654,7 +1705,7 @@ static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
 
 static int vntb_epf_link_disable(struct ntb_dev *ntb)
 {
-	return 0;
+	return vntb_epf_set_link_enabled(ntb, false);
 }
 
 static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
@@ -1797,6 +1848,10 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		goto err_bar_alloc;
 	}
 
+	ntb->host_link_enabled = false;
+	ntb->vhost_link_enabled = false;
+	ntb->reg->link_status = 0;
+
 	ret = epf_ntb_epc_init(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to initialize EPC\n");
@@ -1882,7 +1937,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
 {
 	struct epf_ntb *ntb;
 	struct device *dev;
-	int i;
+	int ret, i;
 
 	dev = &epf->dev;
 
@@ -1893,6 +1948,9 @@ static int epf_ntb_probe(struct pci_epf *epf,
 	epf->header = &epf_ntb_header;
 	ntb->epf = epf;
 	ntb->vbus_number = 0xff;
+	ret = devm_mutex_init(dev, &ntb->link_lock);
+	if (ret)
+		return ret;
 
 	INIT_WORK(&ntb->peer_db_work, vntb_epf_peer_db_work);
 	disable_work(&ntb->peer_db_work);

base-commit: 5cdbd6d3a3a147fa9975e35f2602cbec9a72a932
-- 
2.54.0

