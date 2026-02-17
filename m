Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021114.outbound.protection.outlook.com [40.107.74.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B52E7BB6;
	Tue, 17 Feb 2026 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315581; cv=fail; b=uUB3JrzgANJt1uClzLkR19ecsYxog2wvcSBGJUysjI7H909gtAsmuFIJggbCuZTnw/9BIPditWi/MHvvuMIzLLrNt+pd9rgFgPxIqrMV9REYgnW56J9H+0m+WdGiHVRpHHlgaZZHVweqEAqxdl2NbRwqIdToC1ZZRzxucTYqyZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315581; c=relaxed/simple;
	bh=0A+Nzvi/THnQlf9+ifmqNuLybQAR767UOD2UXe0VSpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r6O7cug6BKewFmBuNq+AzFm7BYLuEe/D+Bg0KMrpeM9NyLiA3PaqLZl8EdQDdZkpkQMx+OAAe/eo5VNhCaaVzp7uOQGYveBUtyYYLQVtwEc3D6VsIahkMsm24NESQ1SB8Zlkdud3w63+HYJcCjdTU5WKj0KjsrKj2c9mXQt+AOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FdzoWNVD; arc=fail smtp.client-ip=40.107.74.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FdzoWNVD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvUG4CV60TLmIiQ9RQqiLpf2sInJLJKVfZvgttHCnIJoManUYT70h7DiR63QV7qVDz5nfYHloBnturgyQaUxIxIg8pt3JhZSxccsNrr4kBOXKPSZI4tESYlxztJqQA0laJVwFJqf1GRhIt9lq7C/DDTz13CaGrySLU53aot727TGvUmc47gfLPAPwkhb19UMj0XJ77miPnyDepVui6zIryLyBV7roHFeQxZoz6H2OhadFB1ecY85UKKNBH8SiObggAXqknjsK8GVx1UyKGnw9g1gaWguudNtrZzWo/47TVI+ZL/0jW0cbe+d/WsYjLa2AMUw5j5J3QkOWOFF2tvy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MA/cpjlOgnLoTWJQ7J5AKBUtCS2N96V6l8xsnKjShwU=;
 b=shxiGNHDlcwrF5nLIR0hO3IjppwqYx+Gw2O3UBfwbqbuALyVgZnK3XwYf6XuiJFll0jtP5dHQPCHQuAl5uons97TSIbp3Ih73Liy4dITblpX6qWKzfz8/gVSykbxpU5/kt4sofuYWYSiCdhDllvqZOBlRBG6GxkH20h91jjhwPrNEybzRfB7edlrIEE/bCZ2PLzKJUMn9QItZeCbBSjdxG6SwIQFZfavjjl5bEgw0v0sit8L4cwJWY2qYsyDphWf3fWbr1fItkkJ25KWQEK0d8zDrQs+PKJftSgma/I/rK9vCBWNbB4r1p7KfpefJe5mVX8YzJjeyxFnBn41f98SMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MA/cpjlOgnLoTWJQ7J5AKBUtCS2N96V6l8xsnKjShwU=;
 b=FdzoWNVDy4TrWe40JBEiT+fIrsTlodphri8yP8pTXQN4GYSA6xRNEVGeuSzPqMge8Ex/ET4uuLemYa6tX/qcXPxTVpumGnk2m2gslF1S+MYrdt90I/kaoePe1yfshhrT29S/L9KvpGytrKkICqxDsWbOxKdN6QngpXTeXVpttnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7132.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 08:06:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 08:06:12 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	shawn.lin@rock-chips.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	ntb@lists.linux.dev
Subject: [PATCH v8 6/9] PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new backends
Date: Tue, 17 Feb 2026 17:05:58 +0900
Message-ID: <20260217080601.3808847-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217080601.3808847-1-den@valinux.co.jp>
References: <20260217080601.3808847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0250.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 375f6ce8-192d-47cb-b0da-08de6dfb6aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TXSEs4Y6jnuOy6Bq3MlbX8/lqdv7VxNvNOOSnhXovudiDhq/M8T3KuqgX0TI?=
 =?us-ascii?Q?YWMQTVpquijVnWTDk86yiLn4nK+JiZRs1Rnx0aDUeL2wkvX+jOIqfqDnFPnO?=
 =?us-ascii?Q?ShCP7Yym+E7XCLBkWGYkKPVA6ww9u3OfKMapc0GohZB7ORibJ137wNDmPpiM?=
 =?us-ascii?Q?Z5Choe02QxPRrEeh9lFw4mjdLpxkcNa/UmGhdTgsZV8d3XbWAMdtfGWsLCxp?=
 =?us-ascii?Q?wRrPDr5xEMf6P8XERzHoodslrd/nLiG4pxk9ouyyLYh2NmV2P/f8T6pjxbXN?=
 =?us-ascii?Q?ikZXGhMlt4MbVOvg5pYwPSj1mfw+aDyi4k5ZVPuV7yfy8Wt24BU8U02S6mUG?=
 =?us-ascii?Q?6zUhyv7ex+FDHEARE/KsgrHY04Q8Jds7wJG3Az4FMVO6oj2xa3iOicrKZo73?=
 =?us-ascii?Q?JrDwXIhyUurnUl19zwbK0YEzIZLYwwE1aeXz0alrfl9+5l62h0o94ntTQWvk?=
 =?us-ascii?Q?vLYUk6ZyblKV0ZiKKaPCfc3qDWkvUFvo2O0tbZVixTzP8DypBW6Vez3UU9i3?=
 =?us-ascii?Q?0h6Q+eigg3GN+WMDnjHkcqvCwl43P7uYm/KURyzphEp01vUxNk6xoOK9r06S?=
 =?us-ascii?Q?+bk5id2j/9Vw1ywUrcVcSaSuyRmHS1l+l+Z37ivuPURuw38r+KO9SaxEZO0t?=
 =?us-ascii?Q?Io300m529z6ONKWUoAYz8/tReyXkJKE3vumRh/152a8jUqFxVlpHHjKwDrjj?=
 =?us-ascii?Q?XWEK3AiWyRmZWoVC9/YQ8TaGdkQYc4bpWj4TyWX3EIxB+bYxo6EuH4pApjtT?=
 =?us-ascii?Q?QibXT092wQU7TU1unShJbMEU/losUXw6K6SNbVFCS2sguQVNSRVUH8wGY6OU?=
 =?us-ascii?Q?LWGkIVY2J9hUy9w1VR71tIbEURhimX+S98Y3XxlcSP9KqOfb8H68l27kZkI2?=
 =?us-ascii?Q?69WYVKx8/S5UKGSGJR3xg8VnECVS+Yb18PeEkEy5pt72CdTKnEr2/1dFUu4Z?=
 =?us-ascii?Q?qr4GCesA8mjkInWV8CMalT6PVMLKO4K75l2Otms9iQIXDrU3YNLXU+qAxKGA?=
 =?us-ascii?Q?vvQQ+kpdRqxuxrhmmaU7GrjdcsnyXhkGewK2bqmfeLi+/l4v8VrqQn76N5is?=
 =?us-ascii?Q?1coZJopsOmJMyhyVFCSfs6NhYCAhBi+V7cpJga3/yZSeG08OtiBknGcybXa2?=
 =?us-ascii?Q?dcHkJU5FjDzDD6d1cRH8g5Hn0KGJ/HUdRVO1b27LmUP+vGaFnZfUA6IEFm8Q?=
 =?us-ascii?Q?MkV3KsHk+jjkr+uUUjrQDgTkIO1cYIR1yqDiQKg3gY3b3iWveWk4Z3JtrWSK?=
 =?us-ascii?Q?2cuqdWDFBK0FsRjXtP1SmxTHiFy6PpGtC8PDzNAVnp2ZIf9a7HMDKw79QFuY?=
 =?us-ascii?Q?dIQYdtCi6x7LA/KF4R9+AgIbd4e3fjZKEtMRwQ4i+ZctQhLyLec535/F0PUN?=
 =?us-ascii?Q?eHsp6x997KmkQxiUjvKHaIw4wsYRVviRAYLoisznPVgNq/TE7rRb1hW0mRkD?=
 =?us-ascii?Q?0JtHYuoZqBkRm3/wlzzX7hDNRprshPylhnphi3y3dN7TWHtPtlkFgQtMl79l?=
 =?us-ascii?Q?aDLL4f60UXnjfwKrYjO/lmgTgd0UVxPQWqdqRoKNSxhGZPMfGv8zdZCERXBK?=
 =?us-ascii?Q?ELARCdFKQcD+hcWyukzkCgUUoKKKHk77LseOCXPAj9Fn65Hrc2+6KCaZpDdD?=
 =?us-ascii?Q?tA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NkFDMi9+dwP7a8kCGNqzEtNXkkJ/EgSA6GRtMbwC4xBoCmaIbgCUf6EE4DZB?=
 =?us-ascii?Q?5bQ52WCRW3vgfmZgfu9ftdccp09Tn8KCzOJxsMgSbAuJsxNPl1FQbp5KWDZ7?=
 =?us-ascii?Q?7dyn7wvEMEDwMFNt1nXjbOcQTf+i+Xp4NIUM/vbgOsFKr/iSJVz9tzCA87Pn?=
 =?us-ascii?Q?bWJGfMUv185Qqwc7ss83UKd7RDrTIziXJxQAPNSHDaeVcKIj9OCH6EBjssbA?=
 =?us-ascii?Q?BRM/3DMQdvPaKhOsErpdjMVTM3Mvx+uZp1YDdGcFHk0kwR0DNzr85hWZnZ/7?=
 =?us-ascii?Q?2Q1f7vUHfPgnjoYoMbtCjfF2/KzpQdhFvVpJCVarpeti9s9iC7HPfoay7GTA?=
 =?us-ascii?Q?DytNke3icKxcCi9FxMZIqRZVjizot8cFAfZWlIYWw7bwB/UzGJzsc/sBijNV?=
 =?us-ascii?Q?xGl57HoNUzLi2LzMW7HbVkEloggHjj7EGAptXy7HHTN6lKVDXvHVYIw3lA94?=
 =?us-ascii?Q?ZkACgtmXQheJkOBbhswqeGZa81FTuq/QQMmkvlgXrTEmNwO6bbCyEwxTQq9b?=
 =?us-ascii?Q?AdXlt4sfHs7EIxmrzBMmuMQ+aaK6d7aW2t+QEHeXQ2a7zwQPAcr0Sc8GqmR6?=
 =?us-ascii?Q?NHL58Dg0+WszHhjTaANL4GyZ2y0JSykPY3ATw8oGiU78orn8+DBNmSTc9/7q?=
 =?us-ascii?Q?bK+t4zJuLtFdWiW9JIEIfy5uKMwG/52I6GZwyhHPKQREQHyfXjxTBZR7rMEl?=
 =?us-ascii?Q?jPvvzzeIQEIZp0vanzUZt4pEDN9QMSfeOKqjRRQUsSMTGZEPwz1PsjNtiqWv?=
 =?us-ascii?Q?IvxwtE421JLfiHaPvW18GqOkND+JtmX+1VEkLmSU0xW/B5SZQV1qfL+jk5Hs?=
 =?us-ascii?Q?wEdgri22mrNoElUi8VmYHvoibIWuXYBIlQvjintXpUnfGd5z1RMVPeaLdoHn?=
 =?us-ascii?Q?W57Uj1/kYpYEUeKt6CoFtp3YEL/Arntl3dbCl07MQJBEq1Nplzna0uPBdEWO?=
 =?us-ascii?Q?Gvkw0w9raVpYKdvrM/yUSm+996+daJDTMXD6t6FkX7Js15ehZI9npRcibqhI?=
 =?us-ascii?Q?+pPNfWAGQjQ9+C2qbSeak1jzVbHyQOKi5cQegjK1vmD1t1kQ6eJaJvMKeq8G?=
 =?us-ascii?Q?JUgJypHiIpeWYflTWI2XAiBuewCVhJy9q3QzLATy5sPhWVvnXJzvqFAPZYTW?=
 =?us-ascii?Q?jjLV2aRwyz9LVqWwj6i7d5LO/nGrsu5XWaF8WPhUhQZQ4BpajwKbNQO3X5bV?=
 =?us-ascii?Q?7qPKjDkw6qxkZSssycRslX6MbnVKJItIW2MLqr0kCDF1jrJodPQcsfCExdeO?=
 =?us-ascii?Q?eFiLxT5B9qsudxrvnIbvJ/HjCHfobQgL0MeY726AUv9fPRwdnPzOF3vKaZrB?=
 =?us-ascii?Q?u9e6a0mIQ7iMx73SvD0zCF9+1vfzzvWI0wOOAzkqfKybirO06eUw21fVIV+U?=
 =?us-ascii?Q?LzZB94t4JlMRa6SxTUQMWlDISUo2Vf/tiTwZdQyg6RrysetD2oz9FMPkPy7R?=
 =?us-ascii?Q?UAgP3f55fl/mqvogfeNd4ch+RciVI813AcT2HrjACAH9ix03E+quqsxJ0yUB?=
 =?us-ascii?Q?+uwA1kMVglfsliphCA7TG0Uda/olqUNITIkeWDo8Xxa6RkaYMYxikvrKYRqc?=
 =?us-ascii?Q?Ho1NJKV2DClVhGr8jp2vaX/Cn9ux1WRIgHQCTYuxKWOVkcVMkUyyCEqTVH8T?=
 =?us-ascii?Q?DH6N69njX2ZIi8DzA24VLCJrO7bVERiVzmsho0xs5LMBzSkJdwfuSPNYKQ50?=
 =?us-ascii?Q?idkS2fXViiwO+TEZCVcMXcxlxUh0nB/zugPSdPgvJRbCX/srBjWrxLNuDDQn?=
 =?us-ascii?Q?HjCxL5mW2H2cYfXkCzn65q8VGA6bH17n4EE8kNlVTLblccXGHdhZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 375f6ce8-192d-47cb-b0da-08de6dfb6aa4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 08:06:12.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3bMdj9rz+qoiUCHJRQ7e9FFRLuGvNRsySZH/NNxT9QwxFiBKcTSkODGWhrJtikywpDyuhwnT3IyjBn19+Fsww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7132

Prepare pci-ep-msi for non-MSI doorbell backends.

Factor MSI doorbell allocation into a helper and extend struct
pci_epf_doorbell_msg with:

  - irq_flags: required IRQ request flags (e.g. IRQF_SHARED for some
    backends)
  - type: doorbell backend type
  - bar/offset: pre-exposed doorbell target location, if any

Initialize these fields for the existing MSI-backed doorbell
implementation.

Also add PCI_EPF_DOORBELL_EMBEDDED type, which is to be implemented in a
follow-up patch.

No functional changes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v7:
  - Switch to designated initializer and rely on implicit
    zero-initialization.

 drivers/pci/endpoint/pci-ep-msi.c | 54 ++++++++++++++++++++++---------
 include/linux/pci-epf.h           | 23 +++++++++++--
 2 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index ad8a81d6ad77..50badffa9d72 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -8,6 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -35,23 +36,13 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	pci_epc_put(epc);
 }
 
-int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
 {
-	struct pci_epc *epc = epf->epc;
+	struct pci_epf_doorbell_msg *msg;
 	struct device *dev = &epf->dev;
+	struct pci_epc *epc = epf->epc;
 	struct irq_domain *domain;
-	void *msg;
-	int ret;
-	int i;
-
-	/* TODO: Multi-EPF support */
-	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
-		dev_err(dev, "MSI doorbell doesn't support multiple EPF\n");
-		return -EINVAL;
-	}
-
-	if (epf->db_msg)
-		return -EBUSY;
+	int ret, i;
 
 	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
 					      DOMAIN_BUS_PLATFORM_MSI);
@@ -74,6 +65,12 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	if (!msg)
 		return -ENOMEM;
 
+	for (i = 0; i < num_db; i++)
+		msg[i] = (struct pci_epf_doorbell_msg) {
+			.type = PCI_EPF_DOORBELL_MSI,
+			.bar = NO_BAR,
+		};
+
 	epf->num_db = num_db;
 	epf->db_msg = msg;
 
@@ -90,13 +87,40 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	for (i = 0; i < num_db; i++)
 		epf->db_msg[i].virq = msi_get_virq(epc->dev.parent, i);
 
+	return 0;
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	int ret;
+
+	/* TODO: Multi-EPF support */
+	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
+		dev_err(dev, "Doorbell doesn't support multiple EPF\n");
+		return -EINVAL;
+	}
+
+	if (epf->db_msg)
+		return -EBUSY;
+
+	ret = pci_epf_alloc_doorbell_msi(epf, num_db);
+	if (!ret)
+		return 0;
+
+	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
 
 void pci_epf_free_doorbell(struct pci_epf *epf)
 {
-	platform_device_msi_free_irqs_all(epf->epc->dev.parent);
+	if (!epf->db_msg)
+		return;
+
+	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_MSI)
+		platform_device_msi_free_irqs_all(epf->epc->dev.parent);
 
 	kfree(epf->db_msg);
 	epf->db_msg = NULL;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 7737a7c03260..cd747447a1ea 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -152,14 +152,33 @@ struct pci_epf_bar {
 	struct pci_epf_bar_submap	*submap;
 };
 
+enum pci_epf_doorbell_type {
+	PCI_EPF_DOORBELL_MSI = 0,
+	PCI_EPF_DOORBELL_EMBEDDED,
+};
+
 /**
  * struct pci_epf_doorbell_msg - represents doorbell message
- * @msg: MSI message
- * @virq: IRQ number of this doorbell MSI message
+ * @msg: Doorbell address/data pair to be mapped into BAR space.
+ *       For MSI-backed doorbells this is the MSI message, while for
+ *       "embedded" doorbells this represents an MMIO write that asserts
+ *       an interrupt on the EP side.
+ * @virq: IRQ number of this doorbell message
+ * @irq_flags: Required flags for request_irq()/request_threaded_irq().
+ *             Callers may OR-in additional flags (e.g. IRQF_ONESHOT).
+ * @type: Doorbell type.
+ * @bar: BAR number where the doorbell target is already exposed to the RC
+ *       (NO_BAR if not)
+ * @offset: offset within @bar for the doorbell target (valid iff
+ *          @bar != NO_BAR)
  */
 struct pci_epf_doorbell_msg {
 	struct msi_msg msg;
 	int virq;
+	unsigned long irq_flags;
+	enum pci_epf_doorbell_type type;
+	enum pci_barno bar;
+	resource_size_t offset;
 };
 
 /**
-- 
2.51.0

