Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020074.outbound.protection.outlook.com [52.101.229.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9732F4A1E;
	Sun, 15 Feb 2026 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771173554; cv=fail; b=W7BZUeP408AgThFGlqCpjcavl7E9wlf9Vhr+wVxeakC3NXzCC08G+vVTgyMx95h9joVyZsvQDbRU/azdk70I10fSUg9ch0/ADnAj6Xq/0nTMf5RP1R+/+mRHu1APV3XVh461XRVU74NlACpryHrVsyPWkLXvED3nIInDIyGRxEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771173554; c=relaxed/simple;
	bh=kQLaghWTbhqFRvW4nVjJAa8k+WJIb9MfM3jCxVmnSOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=INGGfSS3EGQUigsm2Xj2LCNWCSUFGb/HjGtDCSKGG0XyrPri1nNghyuXo550qKYJwVG8DCCjsz6tb5Y/D6kXlWtuFHNcBqVDt1uXSI28diUQpnDzZn7RI0SPJy+dVXxJy5RZOADBfPOz8GJE7bt+I5JQPGae3cxlI0vLa9r2C04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Xb7ti0vO; arc=fail smtp.client-ip=52.101.229.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Xb7ti0vO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFzo2mTZfu9AZiRA4F2pfg7ci+M/ezSIgchteSqJUKUHgLXqyoqMOun+VraqXbjkulNOqRU5ym6kbHqUrDL+jFd4cHMV2VsE6uK8VPFAs/2kYtwb6YCwGe5aeNLxzcb85cUNEqG9G3QdYyUYnOta3XBADvd2LUZ/auAYSX4RJ8waflr7khvuoYKXYyPrRo8En0CYoEMmbrcE6gPP6DKTtv6OxFNnCddpaUrzIJCwyBn4myo594WS+PS3LamBGfOZT2TqBUMKCoSgQFn4fQumyCFslhas1wZlf1sk6Xrri/HbZboGK2ahwDAV65PlqM4egIzyjIH10vf+gEEGdHMgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iYPc9yJc4Py85yEcj+4KtV6uHXaU0az1EhdarU4HDA=;
 b=sqz15FgovVorOavda4ceyhcy/HlmdDREWpDu4vn+g79Fq+viX8NUg/d2R9nHp61q5bQuxBNVY1ig7UKKlvUgGMQc5ZkxpKRyicY4ltxbsuyTa8v/YeFiiERgLuv/uZXaoirc7wGjM33bd5oiDQ4XphFBOpijRrsEnwMivhYKmmKpT2caQxUlFKKy8G05vGzx5MbZVmf3tBol+qLy0HNKaGgJfpd3ygk5SuLd8z4HJbgy9g5pX8KKzMBNMEPsj56fR/aHEUrV58SybK/Bxcfkhtw60DSBWf2XfxtfPZF62kHPRqNW8ImpGb1m/uPsbiU18gu3xV6kuo9b33z/2V19jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iYPc9yJc4Py85yEcj+4KtV6uHXaU0az1EhdarU4HDA=;
 b=Xb7ti0vO9ADBAoDI19RiNquxP+RrYLDSo+4b1we8lUPNwTnACfxatyEE6NWTkkOUcajnJNoc1oPxsPY/S80nVfC7HjdkVSGH6gY35OLaJzr7+ijreulR4iqO/e2iHLwFhyVBgRH+JTbR4W9sk30/MNVdWEjc57l9pbrBQj4VoRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5196.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 16:39:06 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 16:39:06 +0000
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
Subject: [PATCH v7 6/9] PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new backends
Date: Mon, 16 Feb 2026 01:38:44 +0900
Message-ID: <20260215163847.3522572-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215163847.3522572-1-den@valinux.co.jp>
References: <20260215163847.3522572-1-den@valinux.co.jp>
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
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: cf92bc78-ca5d-491e-4fc8-08de6cb0bca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1+xk3998/xQwnjy2/ujH5fIm28jGedljnExPQo68rpvjcrqEXKqEkAph4a98?=
 =?us-ascii?Q?yl7pUO5cWMwC09cw4wcVXx0H9+jXkjVIcTVP8PcSQEWARo40t9Wv49LeNlKV?=
 =?us-ascii?Q?ilNU7Zy+ctS37GglDnmBTw0HNcMmbu5le/ibLVw/IohRiUmi95bbUyrr0LnZ?=
 =?us-ascii?Q?bfJ1fazb4DyFsZlr94WS2QW4w85dLqvQ6J6lNOdELb7s/rJHSSr4KTYNrxHO?=
 =?us-ascii?Q?oqUqJvXPAbngL0m4Zrnu9F2nyYcOMyzrTsPFMRTbFvv8uO5XUyABcrS3IFlM?=
 =?us-ascii?Q?MNHHW0jZBenIg+Ahgp+8Iw6ovFO7IrrhF2EjcYTwtWgXihmqW+HUmMuYTuJv?=
 =?us-ascii?Q?tjqvjG0fQ+PVrS+Y5Bi+5Hqp3EU75Vx9ezE6/ilR8P3PNi0vDYnwHGy4UDn9?=
 =?us-ascii?Q?EjLkeVJF5j9nLPTuGK8CV6t9Cw8YHcTlU6YHZ1VLqUDd+l29TAWJCvsQ+bCR?=
 =?us-ascii?Q?MxqXN2Tl6W2gR2mjR6b5i9vwItJdoxsXgB+xRAahtms4yDyTKzhEYGSgWUho?=
 =?us-ascii?Q?Azmt/C6K1jKG8jmOgq38obBED30Gq0rtBil8s3gFWntmfuGlT4oBMg2TnQ3h?=
 =?us-ascii?Q?u/aUb9gYPkKHqy6p8bdYysDZzgHOCvmEptaWvAdxIMLhEka2i1WsYgZc7u5i?=
 =?us-ascii?Q?2NytohjqWozMkevKAqt0v6UyNyINW4Cee7QWuix6ou8CHBiUYleH+1oQ3tIO?=
 =?us-ascii?Q?ZgZYJJ9Avtw+gWrYOrL2wV+bO82Sfv+/rXUniDQTFGJ17Y82YD+H7sRWHtVf?=
 =?us-ascii?Q?QloLqIvgIm9L/OeOykwnrmbee3yp8TK76pr0/LRkPBsXY9gg1PzkqAAVkoBn?=
 =?us-ascii?Q?UQtIQoo+1Ryk2MvGYMaQNX07eh4H7RmbYHt6zQs9oa/Hi+V56JDZUuRRiemp?=
 =?us-ascii?Q?EDtZYke/UNG0htrTRFt8jPw+6OjJ6b6Y75vNupbKFU5XRSqyKi2mvRjqrcXP?=
 =?us-ascii?Q?3cv/48AyPPC7WZMgAjBSKaY2i+rPew7hUpdnOgMTjlab5HNdi7XqPyRP1EXc?=
 =?us-ascii?Q?kJjosJfIx8RabA3J3fIb02cB0xhRmbQPmuwtiioIKkOh072cWrIQmSLVl8k1?=
 =?us-ascii?Q?/AolvwBegnEINvOGux+R7oe/OxCLAydMzIRQ68PgylEeyWzMyT9k1lpinyZY?=
 =?us-ascii?Q?py+p8QZEMDSbX79Y7F2y4P2lwUZcq3sNc9WXQom1NFLuI3yeQrPXXpDMDTe6?=
 =?us-ascii?Q?4+ULVBrvXGnRqRzFmiz8po5JFUPdGjXMHmpQHbBpsHF62aiD8zmyssFpgA8o?=
 =?us-ascii?Q?cx8ZBpetrLTVBiGHkONRnoo9LH8IpCfEhD8tUkFMhYHtFIQzHiEdbWVAdWey?=
 =?us-ascii?Q?mhKqEeMQOpe7NPH9oB/KRSdhUz/r51OqrRItdWMJ918Uqq1JB13AT0dOqGvm?=
 =?us-ascii?Q?3Wwa6dahDc4qbjwPXz6F2KZpyg8lSe6Po8nQiBV7G0KPtGwWAsYi8a9eca+t?=
 =?us-ascii?Q?mUbzYxvGySdOvm37UFm/vReMWjGpg5AWz1c75kXq/M3+eUMY5NNvtum0yUb6?=
 =?us-ascii?Q?KaGrR284H6oJBEe6LmVq9tiw1xXH2V7iOU4GpxzQ/G3tKb5KTqFq5epoI3Ym?=
 =?us-ascii?Q?rHJBrbXP+Sb/6XCmfB+lxUu6D+VYbfwDNBfGUD5iPd2pqhrNHV+Z7vXVpy45?=
 =?us-ascii?Q?Xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BwzuZ95TPqlncDjBvyc3W5sP3uYQQn5e1Zo1YMca+vQ+YeP/sGCqaDCZI4gr?=
 =?us-ascii?Q?Ney2nODjXDhaNfu4t74qdLO+uPsiyM2rfn1yKw5ZYGuBD5rXv7lFmLVQmtEo?=
 =?us-ascii?Q?BLeGYssVecU34aTIjJyPyLs+tkQb9KFnDBxepUry/TMEbqKWEra5aGXZPCEi?=
 =?us-ascii?Q?WLUqVibyCfNEMPMmMSr5h2I/Vx3p3I72otX0yFW2ZaOr7Zq7cUmwjtve1xXB?=
 =?us-ascii?Q?PzQnsJiHlRCgK0ByAxZE31CD2AJoGYpAFUdl9G7eM2yC7da/CUrNViZvhyCF?=
 =?us-ascii?Q?1EoC4/HJ48A8GKW9vWvpU/r7fc+dx79p29nU0eHy8/PgFJolLR4TieOZfH90?=
 =?us-ascii?Q?ONs/krn3bMtKGNcANnqhTV3TaI6Sz7cpWKYpZXUEjXT8VY2Z50Nqnlgspttv?=
 =?us-ascii?Q?hIQBCK6vgfDOIur91YxhZm5E/EvXdCVmXv0eI8JruQ7z98RJovs674ER/tMc?=
 =?us-ascii?Q?Qnzmko2b71pLdUQNvqz6dOcG8hNCUfOCpThXQJzOKhkRF5pUC7/0TPY5mdFM?=
 =?us-ascii?Q?DlyYMXeRmTgyPHNuWWA+mjg1ezHUNMn0X34Bx7ZUWw3P3YryirqSwoHZLi+R?=
 =?us-ascii?Q?YwCBn9Td/b44ZtQWUFNcq4IABkjAfZZY9t0Oa2yY6IjbaCXSLz/zxHbbb+sB?=
 =?us-ascii?Q?9L1N66W1JtDeSt+7miqAyjl2lsHhj0zsqF9nltATmwWVWQkVW1tfTeP8SxWm?=
 =?us-ascii?Q?XgXsePm7fkgReQujDzXm5a149RkIezYRPo3kvfj2owJk4UhUZcUQKq9rESlt?=
 =?us-ascii?Q?Vdvig4leOUMDsVlYTkrK80zvfLzizjOMb8EGVSF+UBIQ9WvTkm8aBN2pmWJW?=
 =?us-ascii?Q?F+TNj4LZq+48imEkAz7PDArUvoFYjAmSPv2Sm/vr70QujSTHFnAS+cA8EXpB?=
 =?us-ascii?Q?A3flESLXY1/2ptptWQPYukvuEZPvx+nbpqHvr0oUm+g88ko6Wh9++OsQdisc?=
 =?us-ascii?Q?HKMNVhiI8b5ojC032T2/pfDFx12dvmtGM4iMNEPkffk8HxKaAwzWjGEkJIRB?=
 =?us-ascii?Q?zkhpOv2vLasZCMgu6rvGws8M5wFo9+09ikfwS/QEx1q8xWnDuPlJQtHjIQY6?=
 =?us-ascii?Q?loTlM+fZgTo/n3QEeUPNf/IGqjA5qp+peRXgO1bB3D6G+9sgnTsbdLDSeDZO?=
 =?us-ascii?Q?ewGq5NG67hvtPZxtWhb3YKYLd9UzurAhF3kf2jLmqHKKDMGdYB3rKdR6uGak?=
 =?us-ascii?Q?1F/gs21je85PPdavVayQwi/KlUrGQELpfd8CA0EFRMC+GqhzjwHpImjXSI2x?=
 =?us-ascii?Q?9xDTZH6cm+MWpzawH7FFElJ1wTJcBeJTeBNi3tMWuN9Ws1RUwsdJrqg0C03S?=
 =?us-ascii?Q?jaXUEW9n6xPestVgCU5Vm/CZWJNmZp5tNRGEA0tPqdgm+NTCsNGNvQo9wTy/?=
 =?us-ascii?Q?qDQdFDUTyo5nB1Wgr2ulqzAlshcISUkvlxYEpO68k0oH2kqsxOftZJPpv9uK?=
 =?us-ascii?Q?K/2Gv5yeCSqhBus367SIqaq/csGvpdflaRWVd4r+lkVu37BDPzjOcqMPGqsi?=
 =?us-ascii?Q?9oKSMRlk0lryaEjbF4wfwnXQn0qteWL0v+KXoYTbzx3i4vq2OYkKlyGCoLCG?=
 =?us-ascii?Q?bWZes1icuBEUWJL15B/mq0ADhwmqpmBT2tEGcIIGjKwWcqvCeED5FbrAyu4Q?=
 =?us-ascii?Q?CB0Xbxy5EMBGaYV1dJc2FqELxf+gdSu/UHsq9nLHryGIxDfSGjQHjeJv1Nyo?=
 =?us-ascii?Q?Ud+3r6lg5uzLf/EVQqBy/ej1YbfUNGckeLZozR50aG3nEtMXo1vKqH0psfUG?=
 =?us-ascii?Q?QQAxRVZMIieoz3+/mX4CwWzjsxyB7VI8mtG5VPw4hcux0mMN1hZG?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cf92bc78-ca5d-491e-4fc8-08de6cb0bca9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 16:39:06.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHrw7Y+WRwZ6qrqNoF9YQYnAvOhmLddTE/vT65RNvOT9xUhOordkJMtXZrhUmwOrzfSFOOSoZPyjAcc6ddOmgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5196

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
 drivers/pci/endpoint/pci-ep-msi.c | 55 ++++++++++++++++++++++---------
 include/linux/pci-epf.h           | 23 +++++++++++--
 2 files changed, 61 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index ad8a81d6ad77..a42f69ad24ad 100644
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
@@ -74,6 +65,13 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	if (!msg)
 		return -ENOMEM;
 
+	for (i = 0; i < num_db; i++) {
+		msg[i].irq_flags = 0;
+		msg[i].type = PCI_EPF_DOORBELL_MSI;
+		msg[i].bar = NO_BAR;
+		msg[i].offset = 0;
+	}
+
 	epf->num_db = num_db;
 	epf->db_msg = msg;
 
@@ -90,13 +88,40 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
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

