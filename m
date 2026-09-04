Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021119.outbound.protection.outlook.com [40.107.74.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA14B4AF666;
	Fri,  4 Sep 2026 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538871; cv=fail; b=CSdXp7+ctclxGuy/WaJAvYgmSfbm5r8G21gF+jbjzeAo/0e0vwKWjs8XnhqX2Ui3IuAohHH/mlQkAM+vGq7+fAjuObmQXk58m7xUxDfNlgk+5AyPqCRBE4FQKSQ+itVOuNd+ysXZ2i6AIj1Egr4ydFwZ+yJlyj66OAcS7yCvl4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538871; c=relaxed/simple;
	bh=X++wC8wWyPIoV8U1v7n5umBRIKqfk/vMsnblRyCaAuc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ljkTrPF3zx8lL1sxD2Iwyaoa5upx+zEXMLV2BM5HgaQoYBtfRtwKYM3pVBRgGwwxNP8+GUJOw5hf4Jxbw7BZkculrUxPLPkbWKJd8H3lB24pAsE4wGJuetTcuA+KR2+oQx/o2nxRTMRvgHfRrGOV8Z40+vvNa5zX5FZ9JjkdHAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=c4mh2GpG; arc=fail smtp.client-ip=40.107.74.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="c4mh2GpG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9yG/wCTUwHZi/EhvP45iT2MXvpmtrcgNPzW+2npUdgex5YQ6S5ZcXq9XRF98GitCz7dnGBnSFONepRjblxut4IUNaTEw9RczKAAyUnLL+TS+JFrYHWBmhrHDoKSeHRY9hkwdLbcZaJtb1zul2reSAk3eOH41wTHzfLklJofe3l5QF7384sKxk7t0Naffab0XaiZnZVLnsYMZT3HbVwz10l51pm+l79UbrnpI/yQbgsD9Zh9Z/uDOhzM8aZ5sW2pbSq9C3mLInBK095hgx+WnG11XnQJaPnAucEXwvio9M/9vTUBGEdZIjVSq7l4kGa/dMaIkBYjp4nsYkenfe11Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFFaC7jdw/PH9tRuLUJIZhG16d2aCtyL+9Lsc4MCtUs=;
 b=lVCHq7oQTSr7cwH6Kuh2K8omoURFANOlB5V3JVXVXrFnL0kLy9AM7m2Z9G37F6AyBqoHR5CgBRdQ5oXexXd0rAE5La8glIAzAE0LlWK95s6XSoZVZw+3JcOcVGtbRK4s1ZaKCQeR4Rsy8uH0nQXdpfMKyIFFxBqOJOJ1MirInME8oboiIB/irdVKyAyE3THatGDI/6VA1MFIpc3hk9zOQW5C8O7m02CDnGsV631Z/v9vBso7/5MBu+AYkNDi6Eti14l9bhURdfdjxY1wuq29YH89QOkVGDfVQoxuF905p8ESovvcrgNb2gYyDziaiezi8jqvEztuFxX1PG2e15iT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFFaC7jdw/PH9tRuLUJIZhG16d2aCtyL+9Lsc4MCtUs=;
 b=c4mh2GpGJpjv8zbbKkL77GZM4ziuFlfbd1uuDogeVT49GsPAile/K9gBnUsZLL2WD9byoZYkQoRLnd44fw/vI8vglkBRJjS7hrtmbRkeLMNV/+9BqoIQ3VtzDN0s6NSNxnuI2PSgoxtY643JLX95cVtNqx7uL1n7u/HlKyv67N0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5513.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:21:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 16:21:05 +0000
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
Subject: [PATCH v2] PCI: endpoint: pci-epf-vntb: Track link state from both sides
Date: Sat,  5 Sep 2026 01:20:49 +0900
Message-ID: <20260904162049.3432464-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0124.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fd483e-2f37-4fd9-36ee-08df0aa08503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|23010399003|10070799003|366016|376014|56012099006|18002099003|3023799007|6133799003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	O3dmtW1md7TC1ObwlqZ4ef8fykgwENhPge0y9gxmQCNeitN8dTlr0imvsqsXS4t+IjEy2dgHwS/kiSOb/O2IO/pD/LHJ1FZfZngM6M9VmqbdKpnygedDR0XmmcD4SzRug1LVPoX5P7u91PzDdf6RUyu949qvKL+QP4Mige43H7b/id3ZMR1fFy7RRLzx/Vhbbakirh2XPVBfGHobQk576UuSzJrf4hUhH4B4T9z94+EbtG/qVvV11UJEHFegCHBi4hTLxVt158hVBZzTrezxMea18m+/ZedyBCNrcW0v0IGMYHaFd+8FyqVR7M4C01qpgfltwTy/jJ8piW+ZuKcyS8rC/tSSagXjgfjw6rB3dlwWRz372ysFBLG0YpQKUnQXht+24VKcEKzZXFgQxHmHsY8MBQqHKPrpDe2koplPfdSJgfDMCPC9E58z1g9Jzyl2Rycx6OTKhv8rL9c1HOLlX4wC+D8ZJe8gWyE9GI/H5LpP9Q/pNGZOdDR3j0Mu30y9HFMMC/Rip8ZcTCkFmIKtQOsTmMw66evxeLFoYTGbc/uTtLM1NZKqtOB5NDluGnKSqZjgAEUhYhWmRfiqQdj6xPnhZl5fzJFgZ9Cj86qEGDNwDKsHlOo6jz3iiXaZd5pf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(10070799003)(366016)(376014)(56012099006)(18002099003)(3023799007)(6133799003)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u4ZjSU6eB56KPDXsXNcqWotKwrVKXv4pcewOi+X5C4Tt5uvGgG2bVM6AoxyQ?=
 =?us-ascii?Q?Y/3Pc1kIjPgcyrBAw2RsPXatk/8VcHqVWgkoQgBhO5rYrcEpG827x0iELFQa?=
 =?us-ascii?Q?0LuysWyhg7wyaDP9YGU/sEzp81mKXXTK6qzH8Djwp0/OfiDQtvCFPjwFyfPV?=
 =?us-ascii?Q?TeQQhoIiEwsFvr6k08L5G+Am7cyheE/cYcilzYuwldEUZQwneJmvdHFZzBTM?=
 =?us-ascii?Q?VdDIsRvdhp0DFKSNH136dIUywfcD/oq0DAHqUY9oaFFWQrHGn/TT0h4EKkDe?=
 =?us-ascii?Q?rgYpGE1CQfGiKVC+2M3yXA5DJEUYE7VVLXi9CUps6M1DzbhuXz1WNku+fdPl?=
 =?us-ascii?Q?MLnCLM0lAmPHVrRqOrit8CnUI3ItrdLx9djVZYdBpe/zfZHnq0H682NeNR48?=
 =?us-ascii?Q?/YzhxMMIiTcZanQbS4/zpwwwbWxkfs64B1/4BW931wmhvfhFSK31Wm0AS/Pi?=
 =?us-ascii?Q?91y8mhbN+RzrvH7pmCZY9iYWt+9+TSBZI7r/UyjCT8cksF8SgVwFPO6PBqhP?=
 =?us-ascii?Q?P830rBHjfOZWGflHC2sGfGL4mXNCtZFBIFlwQTHzwd7F/ZQOdrZxPhTe6HvF?=
 =?us-ascii?Q?j4OSIVIhuSDgoYtGgp0GLYisoyGHl8/d1LH2SRwoVAx0860DsL/gVnL0RXRT?=
 =?us-ascii?Q?lw/XydL4te2CdNEN+btu6AyRsMBR0971vhtrc6WWr2x68oDrfIklBAYY8SED?=
 =?us-ascii?Q?ex6n+XPj4GEpDh/aj5b8Kd4KfjUG6Opj2ATfmKB8XigLKIW0qs8hum9VvSuR?=
 =?us-ascii?Q?E7I/0vB/CQaG2ocCTgFxI0suHkrJzkFX6NCZFYkA545OC48hscZtvjn0XC+z?=
 =?us-ascii?Q?IVeAm7E5vG7J6ZYcu3QEuhsC/BCcEvHEbHiAfUcesh4JJT5p7zAFIiQTTjth?=
 =?us-ascii?Q?C3CoBIBJZqaH8aife8Um49UdSlZ/q1geEj1rCvGfYZdAszLHp2A3OnKhrTqa?=
 =?us-ascii?Q?L0i9bN3zatoLZPsK5JOYf8YDx+El/DFjO/jdhiebUvOx5ufYgv71kG4tzpGu?=
 =?us-ascii?Q?Snec207sKY6LwEdmThZ9ZWYO43KYD1gMONX0MgFpaHfRuVXPivuu6Nal674r?=
 =?us-ascii?Q?2oabJLs2ffag6Aac4JX4TaZt6CRWj1HQjIOjr0LCms2wcR139IF8TYnlgBws?=
 =?us-ascii?Q?PVEDaxJSkX7rXUwkDtKn78y96ztIGL8k4nBPDWfrjwoTgeDICpXxhzrEZjsC?=
 =?us-ascii?Q?ml4irWe+RMKO9FrDEr+2QTzZfk+JQuS4DrBg5aXq4tzEdyqUkf27BcwkzCEm?=
 =?us-ascii?Q?v5Tt46gdYtBHOUccGLO+Nj2nAMdZLASRpTFfSt+zk3yDdbdhefXG5XlN/Lvu?=
 =?us-ascii?Q?kttA+EW2vhQEYWNBDSNwJ4JZICqdf9/oxTaX2gISgQSjGarwr2beq6y6S4kk?=
 =?us-ascii?Q?4lQI8sZF/M9dAxCbB4LKC5dK8o/VkBrsM8+QeHtNSP9iNPtnqQq8ULPtQJXK?=
 =?us-ascii?Q?K+mpKV03ZPfu6qq3x6uygb/IyUkf5Kfj3KaMbjtoYXrkT5iy5v5iJM1oRbY4?=
 =?us-ascii?Q?Ssu/s6rlecqT3AIXwET5+Yv73ZR3CwivXwcuungtUxGGMPhy1aVI6bybrprh?=
 =?us-ascii?Q?kA6GuCDLQueeWYw4gGUlXETvJKiD6eTWSLPOSOZk5sqWa12MRSsUffHgLuWF?=
 =?us-ascii?Q?fWfdnnIp8HTyEVMa2ihqlVWZ2y5gyyzcJOjALToVZLEpD/U2jlbkubecDoLZ?=
 =?us-ascii?Q?bi7puvt170YD22ze0/cj/RQBXT7RUQLSTtoUlLqpEl8uGZYQZUjQqpMOqFnZ?=
 =?us-ascii?Q?3Cw0QrAnrcw4pDYXQt7Y2I2Z/4BP1JIuIwOVEg7Xf5475bFA5Gby?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fd483e-2f37-4fd9-36ee-08df0aa08503
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:21:05.3316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gi1vx3n8nzbpvt4+D+IL4y4O2gVsZET46r9qKqJXQ5PGMiGQvZDax3N4WS+29l/K0cnO71Bb3jTTu920yXHqLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5513

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

Order a link-status change caused by a HOST command before publishing
command completion.

With this patch, peer0/link changes to N on both sides and both waiters
return.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Notify both NTB clients when the effective link state changes. (Sashiko)
  - Use devm_mutex_init(). (Frank)
  - Update the commit message + reproducer accordingly.

v1: https://lore.kernel.org/r/20260904065335.3059625-1-den@valinux.co.jp/

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 92 +++++++++++++++----
 1 file changed, 75 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index fba65abfb6b2..f921c7c7019a 100644
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
@@ -178,24 +182,57 @@ static struct pci_epf_header epf_ntb_header = {
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
+static int epf_ntb_notify_link(struct epf_ntb *ntb)
+{
+	struct pci_epf *epf = ntb->epf;
+	int ret;
+
+	ntb_link_event(&ntb->ntb);
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
+	if (notify) {
+		/* Publish link status before completing the HOST command. */
+		dma_wmb();
+		return epf_ntb_notify_link(ntb);
+	}
 
-	ntb_link_event(&ntb->ntb);
 	return 0;
 }
 
@@ -320,7 +357,6 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 		ctrl->command_status = COMMAND_STATUS_OK;
 		break;
 	case COMMAND_LINK_UP:
-		ntb->linkup = true;
 		ret = epf_ntb_link_up(ntb, true);
 		if (ret < 0)
 			ctrl->command_status = COMMAND_STATUS_ERROR;
@@ -328,7 +364,6 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 			ctrl->command_status = COMMAND_STATUS_OK;
 		goto reset_handler;
 	case COMMAND_LINK_DOWN:
-		ntb->linkup = false;
 		ret = epf_ntb_link_up(ntb, false);
 		if (ret < 0)
 			ctrl->command_status = COMMAND_STATUS_ERROR;
@@ -1456,11 +1491,27 @@ static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
 	return 0;
 }
 
+static int vntb_epf_set_link(struct epf_ntb *ntb, bool link_up)
+{
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
+	return epf_ntb_notify_link(ntb);
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
@@ -1620,7 +1671,7 @@ static u64 vntb_epf_link_is_up(struct ntb_dev *ndev,
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	return ntb->reg->link_status;
+	return READ_ONCE(ntb->reg->link_status);
 }
 
 static int vntb_epf_db_clear_mask(struct ntb_dev *ndev, u64 db_bits)
@@ -1638,7 +1689,7 @@ static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
 
 static int vntb_epf_link_disable(struct ntb_dev *ntb)
 {
-	return 0;
+	return vntb_epf_set_link(ntb_ndev(ntb), false);
 }
 
 static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
@@ -1750,6 +1801,10 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		goto err_bar_alloc;
 	}
 
+	ntb->host_linkup = false;
+	ntb->vhost_linkup = false;
+	ntb->reg->link_status = 0;
+
 	ret = epf_ntb_epc_init(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to initialize EPC\n");
@@ -1822,7 +1877,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
 {
 	struct epf_ntb *ntb;
 	struct device *dev;
-	int i;
+	int ret, i;
 
 	dev = &epf->dev;
 
@@ -1833,6 +1888,9 @@ static int epf_ntb_probe(struct pci_epf *epf,
 	epf->header = &epf_ntb_header;
 	ntb->epf = epf;
 	ntb->vbus_number = 0xff;
+	ret = devm_mutex_init(dev, &ntb->link_lock);
+	if (ret)
+		return ret;
 
 	INIT_WORK(&ntb->peer_db_work, vntb_epf_peer_db_work);
 	disable_work(&ntb->peer_db_work);

base-commit: 68fcdf30a1582574fe67e0b02488f8ba0d4d1242
-- 
2.51.0

