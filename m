Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CB447D463;
	Wed, 14 Oct 2026 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962102; cv=fail; b=QrgaiCzOSCrc9/aGvfUbQkSH4TI9xVV8YFsntWyRABCTk0e93IhU8+Bt8CjUTfxDJdN+AtdBAatWwciMIycUmiG5kUeyJvGcPP1vusL4Wu95lRx0eDJqVW6sBFPDxDUw6sWZCQDqgR3Y4uqornPaC6cfOHikbE1Ivc13/geisOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962102; c=relaxed/simple;
	bh=cWXOLdSziEZpqv/wpkN/GVi7QFC639eWdGrdDEbym1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TzodUaRbyZImGyNMwi3GhnRy8m9FIH9V2KKOqVz0FJzkzXNQTlDPYuBjirZY2kYhGpZaizxfbfEhipB7gHD62EFXB6ucxLGXdH59fKAQcXEVe4AIogeDmtBx1zxsZeq/fkgX/dW/890T69yY1BvKOFLSjrhFmTKYqp9RaI8Ct64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=XtMBmwwF; arc=fail smtp.client-ip=52.101.229.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="XtMBmwwF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMiX5QBySd9kVDu497ImtDMUaEXmSynZBAFDe52gn/YBeR0dzwvq0vOlKX+lo7s3QkvxUfSuWu6LsZ6T5cTlL5XNzzmZVVr3Mjn61TarrRA1RDnOIBSlSP8lBRDNVI1BG7SzfWvSAhbAw/ziHGPhIpaXYAki/2jD68HzH0ckIvIow6TYtyCJttvG6KMpJA4DyoTUSQcsHA1faoM7HhphBKf2Sbe8IRUV9RVKCdyhLEw+Nh6Tf0mKZHvC4eDGpQahsCLMcOzmyEwkaVLfreStC9ykTbVGLn22rS5gEqs8lFpFpeRF4dWKzIesRmd+tWqeexhGxjD+BKMI7FoiqGEC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCW/IdQnki2GDb97RpYouFJPlIoT5LIXsAM3iK5jSGY=;
 b=QPGH2KB2NNAOFs7QOw2izYKAvljGeqxtlARYpq4Vp+44+w4iXXizkvMwVGDYK91YkeMmWn+kiAjCnGhHfXhU6IWvFlJsa6cnzWsgaY8qpiFh0Is1t5SNRILCX4kCN5vGebymzTqMhV1/ztx91nbDmmKniW+Q0Mpf+d8kjgluWbAD/DXJfkcf6ht/kcWu0VgzWLSBMn36D7uudnwyWH1qW51rzAeGleOpduojbShALfgQAJxCpvrek4xYhfvlaMHxdeY82PthYIMRwbWlQgzu/wFpE5Fl+1xpfawn637sgSDx4sHl5wn2y/BqLp+tJsdZLsuYkppoz/JbLnMQA86JCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCW/IdQnki2GDb97RpYouFJPlIoT5LIXsAM3iK5jSGY=;
 b=XtMBmwwFkdOOxtHXiWR+rQVIfKaoRg9GFZKDtND4RfCWgl/AFc7ybWXmpyF8EdgrOWVzHgLYTz3K6UsjH4cZMKNVlImpMml4OZCLSfAMhRQ3l6RSJZuMi5KJveuL/t2Y70VMzJFE/I3hka3DBGd3ASeHGAta4b8z+y3Of8HDrBo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2635.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 07:14:51 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 07:14:51 +0000
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
Subject: [PATCH v3] PCI: endpoint: pci-epf-vntb: Track link state from both sides
Date: Wed, 14 Oct 2026 16:14:48 +0900
Message-ID: <20261014071448.2473208-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0053.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2635:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1de277-2054-4733-b05e-08df29c2d6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10070799003|5023799004|56012099006|18002099003|6133799003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	ODMbpa0I9zpzX9oKoP5UHhC87vKnh6X8tEIHpUdYXT+qD4hJtS9opA+qcnPDNCjRIjiaimCgCYahYQP+/fEyW2eGlowQOGYfwmUTsw2RUCISQRAoK5YTOReuuK3uh0gYikZkfeU1BsqaP2XRJTqPKEto6n9Gbbpztd3Y1WhQJJ7jleDUfdtsvvoX3aT4cf9guxlu8KPhPeYYuE7Jv/GOYH6bTWqy7AApnacvkMVPXEU6UEEppDG5uA3yg+W2DXuVSG4HHUBe/boKqeqfCexSHyHW0oSqQg02LzOR1buhyX/i88MyDDd5kAXjj3ll44gitZ9OAS06PVMxacw7fyvxRZy9pBAQw0qUtJZuUllh0btyg06Nw/6OQziNV2tH947g3HFtc3cYEqYHPakYkYI7Vdryd3JIesdQjJ+bfa/PsQpYyGMCuLhLaGA7ZVLmGe32+oUGjA9J639m2VAp+7YpvaMGCT8USAJNu9sShXyapVW5lx6CcZ14uAKAwIIHgrsWrqKZ8LA9ERLxrRQv08rmXJp64du5kXrJMXRjSu2+5R47OfS5tbBCAtwcBJK/90ztOBQ++jPNKMTIYXwSQnEOnDeTGOgkYOwPoWjkDObeRBDG3pYxO9lnGNSbX8Y3omHZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10070799003)(5023799004)(56012099006)(18002099003)(6133799003)(261009223027099003)(3023799007)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+G8xz059pPJRqdqv1NnSQtGZ29aH0wVutlfqXzijerPgjXDgR712BAENOsM+?=
 =?us-ascii?Q?Cn0psW+1sd6QBQl9F9kSP+YiU2k2Kvfm/ICPfANm8xMsqnU+w7sCDQ3LuUaf?=
 =?us-ascii?Q?JHKDVUBM7xceR4+0SNUVyB1rzkxPKy+D6quIM83tc+bwJxgyL4THdeZlQj4b?=
 =?us-ascii?Q?7mSjUhDL1RVsMDZQGWMa6ayHdHN/3m3c3ZRhQqvvBumfhk2svjf1F87vcJ1j?=
 =?us-ascii?Q?LeZfMAYxs5ZVJrDishOmMkDF7wqQvVl1wDA39cc4x8P+OANx+HYDOXFOGPPq?=
 =?us-ascii?Q?7KpJcyrOd1tMTXS7m5go9Rjy6hDCnCkRa0NiVVWJH3IyA3A/2orKC6+HK3OT?=
 =?us-ascii?Q?bfq8GfOjLfZCSXmZWUL93Tf3cv2Eqi4Cbj4/9cBdWqAP6XkkalNvdDH2daYY?=
 =?us-ascii?Q?G30kCXWS5p75qif9QpkwHejF4HdfWr6PnDnspAXaPGM9osuKzPnVHikz3G2I?=
 =?us-ascii?Q?6DEQq2aJOsb3QXwwf9X1QryxqvVoFgpwUlc8LSOnTLlkivAHqkorfbTkc4PO?=
 =?us-ascii?Q?kRMqSM8Yoyc5WGMjyDor3iCcxUnnsFc9Rr+GseNjCR4Ek2U2GZBVAVSnXwGI?=
 =?us-ascii?Q?1tL0G6IdC8cNHwDFB4yamZxoA15GFYuqaLmuvKT4vLx9JUpK0JmyvwwX0mkI?=
 =?us-ascii?Q?Q5Nti/h6XWOE+/M82IK/ClqSzzWmWTMapBfCttkqj+/OYeF94W7fFOkcG++Q?=
 =?us-ascii?Q?iaRld6NOfLF7RW7DdkHPOTsqt57y/3gzO5c8cJsEadh/3cv6MdkqNvcB2bNa?=
 =?us-ascii?Q?ZqRerSUYsKHIy845xpgEpiGrQU/A8X1LKEJXlOajmLHXh3L/uiJZOYp3TInF?=
 =?us-ascii?Q?OX6D885Wq+mO9DMCAQQWkq+2rCnvNSiIcF8vRP+SgOD4VJvEkbuYAqIRbH7C?=
 =?us-ascii?Q?y4Kpn2C2BdWufeii2Ljbo6hhRuVf9z0OYSegfd0eaZQTEzEEaPzhwREviIDI?=
 =?us-ascii?Q?+f1Q2CmHZWLk/zJBt4pjxmDwWQhvmY8suNTlQWHwvUA9hm/y6Pm24trQeHcb?=
 =?us-ascii?Q?blnX+MlLBL+ratgIlZSTltGHQO/uNl+v2/h2hjn31ayw8cmacWTHQZXLQpM3?=
 =?us-ascii?Q?Z3VClTfrQQ7IzMeiy/N6EW7XmBYPPdwfwgYOQfNmuSSIPHzqsa2rAIB4ywAo?=
 =?us-ascii?Q?L9n8x8a69tBNZAlDPAM2DnpoYeZGeOZ4wyqLxDYGzRymI9Ser5YxXjtrQs0w?=
 =?us-ascii?Q?Wmt9GvxXdqHyd5adGXGTc7HaU5UMb2cnBK1/vbozQakiTTUnbM7PFxP2Q82y?=
 =?us-ascii?Q?miZFBucm6QMjIUCjlgF6HOvpxGdQnH3Fnmse6ET1H7YM7VzboEeqy04WWFxA?=
 =?us-ascii?Q?7CTLTsNaGs6WnZfi0Bm7Gzl9LgL6WE/VEWXOmAwaJPj+F3e+xqBf5KdfpMiA?=
 =?us-ascii?Q?MIQvZyvOUTspamooTHbmGV5YaQneJOAqa6cwPIrJnxHXGqjbKY8qqGQVZpD8?=
 =?us-ascii?Q?h0RTZNdNTYDJoUhxjHjAwl9HPAPaYKOjJ2UZYsKoynwr6elPOgrH/BHBy3FQ?=
 =?us-ascii?Q?wAHmLOVsxQDrW9nljpbz5rQ19XmiD7sC2b8gGx123iRHc6/+McD686BimWVB?=
 =?us-ascii?Q?EqK4b7pLmMbjy090CGwFWDKc1XbwKlkOXcj1T+oFTtML3VR7LbD2OQ3jdkJF?=
 =?us-ascii?Q?OUsODSaBMk+O7cO8u0OEJ7ZnwwPRbU1ZMcoS9YSSneWPjEEL1w2SGUN/yL7X?=
 =?us-ascii?Q?qDcnBz1F02hm+KVJ2mfEvoBPcly2AVp9HUyvjTgaLn14qIcDU7sbgBOF6sEz?=
 =?us-ascii?Q?pr+L/04Os2vHS4cPm9FEkzOKYzia4sr+6b/kbWF6nZSusH9H36Ac?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1de277-2054-4733-b05e-08df29c2d6d3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:14:51.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKTNVy4adVwzRsdbzbwp6P3a5vD5NlCEhBT+MNwNPxe7kxUfQqgTCVRK0+as1jX8GGleCTQmjdsRYBCM0vUFwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2635

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
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Rebase onto the latest pci/endpoint.
  - Drop redundant dma_wmb(). (Frank)
  - Retest using ntb_tool.
  - Link to v2: https://lore.kernel.org/r/20260904162049.3432464-1-den@valinux.co.jp/

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 90 +++++++++++++++----
 1 file changed, 73 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 07ba338732d4..a11f9260ee86 100644
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
@@ -183,24 +187,54 @@ static struct pci_epf_header epf_ntb_header = {
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
+ * epf_ntb_link_up() - Update the HOST link state
  * @ntb: NTB device that facilitates communication between HOST and VHOST
- * @link_up: true or false indicating Link is UP or Down
- *
- * Once NTB function in HOST invoke ntb_link_enable(),
- * this NTB function driver will trigger a link event to VHOST.
+ * @link_up: true when the HOST has enabled the link
  *
  * Returns: Zero for success, or an error code in case of failure
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
+	if (notify)
+		return epf_ntb_notify_link(ntb->ntb);
 
-	ntb_link_event(ntb->ntb);
 	return 0;
 }
 
@@ -325,7 +359,6 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 		ctrl->command_status = COMMAND_STATUS_OK;
 		break;
 	case COMMAND_LINK_UP:
-		ntb->linkup = true;
 		ret = epf_ntb_link_up(ntb, true);
 		if (ret < 0)
 			ctrl->command_status = COMMAND_STATUS_ERROR;
@@ -333,7 +366,6 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 			ctrl->command_status = COMMAND_STATUS_OK;
 		goto reset_handler;
 	case COMMAND_LINK_DOWN:
-		ntb->linkup = false;
 		ret = epf_ntb_link_up(ntb, false);
 		if (ret < 0)
 			ctrl->command_status = COMMAND_STATUS_ERROR;
@@ -1472,11 +1504,28 @@ static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
 	return 0;
 }
 
+static int vntb_epf_set_link(struct ntb_dev *ndev, bool link_up)
+{
+	struct epf_ntb *ntb = ntb_ndev(ndev);
+	bool notify;
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
+	return epf_ntb_notify_link(ndev);
+}
+
 static int vntb_epf_link_enable(struct ntb_dev *ntb,
 			enum ntb_speed max_speed,
 			enum ntb_width max_width)
 {
-	return 0;
+	return vntb_epf_set_link(ntb, true);
 }
 
 static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
@@ -1636,7 +1685,7 @@ static u64 vntb_epf_link_is_up(struct ntb_dev *ndev,
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	return ntb->reg->link_status;
+	return READ_ONCE(ntb->reg->link_status);
 }
 
 static int vntb_epf_db_clear_mask(struct ntb_dev *ndev, u64 db_bits)
@@ -1654,7 +1703,7 @@ static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
 
 static int vntb_epf_link_disable(struct ntb_dev *ntb)
 {
-	return 0;
+	return vntb_epf_set_link(ntb, false);
 }
 
 static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
@@ -1797,6 +1846,10 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		goto err_bar_alloc;
 	}
 
+	ntb->host_linkup = false;
+	ntb->vhost_linkup = false;
+	ntb->reg->link_status = 0;
+
 	ret = epf_ntb_epc_init(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to initialize EPC\n");
@@ -1882,7 +1935,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
 {
 	struct epf_ntb *ntb;
 	struct device *dev;
-	int i;
+	int ret, i;
 
 	dev = &epf->dev;
 
@@ -1893,6 +1946,9 @@ static int epf_ntb_probe(struct pci_epf *epf,
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

