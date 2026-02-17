Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020081.outbound.protection.outlook.com [52.101.229.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C72EBDD3;
	Tue, 17 Feb 2026 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315583; cv=fail; b=mofS6dcBRFx2suqxMKa7WkjpEm9BDmWH/qUEWkN10kVBx5WWtrVaC67yXMfttWqLjDBUPr9vndc5QmJbnXW3C581tasyzN50LTO1V5eL2eoi0IO6lElNTcstVZhncK9vL1n+imXlOvGJ0ovajOtxeJjH2tzJue4DE48jYpYfAJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315583; c=relaxed/simple;
	bh=lb9k9Kras3OEKJiuzh5fCP1G8ZJS4Mpk8i45PyaUz4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRN4cSRn7ugRzzT2lSZe9A1SRynuOA7hN/r9COr8eZZ6U0zJ0xcZVRukl5XbXAwpcNxbCRItklJMnhATmMaAqdBPORpR/l/Xcp6d3+RLIzofMzK6y5kXvYhr7VzcFK2YeT8ra4C0Xiej3tvN8jP5MbgrMeJk7g/rxPfYHasJb6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ufXPRn6i; arc=fail smtp.client-ip=52.101.229.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ufXPRn6i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAChYzMrdoR00U3KrodVvJA11xilq2W2ckLTUPQLxKxvKS9WxWEzbKc1q5PDtYHUggDXDCeyfcjaywAoFmGBqNCaxi2Y8CY6Wss7tLIHwn/5fXQmdL2YgRWT1CNkhhZZoxO4GloeCGiCBjPhzq59gW7h7oWXceWJ38oxDblCqSEhVmDnDgxBmqcKmyoRIlEYYs+rGfbWtVFmjKWrqHTDdZCY98ZpaNeyqAYDWAzurTBJuq0QJmerbgdYv/SHYN7aRV+b3BbQa6p20KT7qnCO7xyWP2Xk4zTbEhr9sWkNHYDuHBQCanpSkzdeVZkN+PExdzXHGZHH1MHCL6py50G7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grlMiPTDP7Nc9QwHhLGOZLZFADyNdipGVN7Bdny519A=;
 b=PseIdxXg9vZHuy9slCxyLw07g8Fl7WUEnNCqg1FPtXSYjfAABdmQtLBfUEeu2GQ7BEOY/BAOXpZylNfJH2rNGGIG3dz7CATqtslRXMhSWTmgAEiDE3Yt4bErZHE7KSLJ/R+ia8x3JFVGegZWq70dhfQF2gDz9EM/mYbEebyebp+5iKrA5OZXf9g+9aN2ECtKPJ6qRpHYcIqyN4VbfrrkAuPvUF/xlN6VXSqXawP9e6FeHRGPU/NlhQmhTAjrCNrRI5r+2DQ2XCw/FWOQcP3I6fs0SNZM6vtgnSGEFSZo+bpIWyjYdPbgyCvZYh0P5aUVF1ijd8V1osC8WQK+SOU4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grlMiPTDP7Nc9QwHhLGOZLZFADyNdipGVN7Bdny519A=;
 b=ufXPRn6iSMIfDk9NON+7LH+MhJzAnlcZBZdvWvGSM7ODYlYjc9qF/yMzaw8I7rPSckoWR9Y9ZDlHcdLKkX09boVDpLv0o7YI39uBMXihPGWsISa9X4u48VRejbUkcf3nXFIVEez9ubmXoWgAkRB0P978uxiWhhNpDs58RbtFD98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7132.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 08:06:15 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 08:06:15 +0000
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
Subject: [PATCH v8 9/9] PCI: endpoint: pci-ep-msi: Add embedded eDMA doorbell fallback
Date: Tue, 17 Feb 2026 17:06:01 +0900
Message-ID: <20260217080601.3808847-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217080601.3808847-1-den@valinux.co.jp>
References: <20260217080601.3808847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0281.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c509650-cc41-44a2-f211-08de6dfb6c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vHcyCrnOBzrlfgMNsEo2by0LBQNZ8Ym8HmYUUjcbSF3Uvn0KmHYf/7qe3cnI?=
 =?us-ascii?Q?AifoLcz9f76/iA2P52qoDVTG+CQ35CZHiCKw0wR3itzGFevptc5xxMPDCNqd?=
 =?us-ascii?Q?HSkdFX905zvmR8xOLwV0WTz7VcknwW+5oJ53C8clxzj++C9yV6EQD51MOlhj?=
 =?us-ascii?Q?+pMmtbnKgjG1stswuUAik0nqcYUkgn4L+8hrDRr9uih6mShLMQlwKoRgoDTp?=
 =?us-ascii?Q?5+z6MfFiWWJgs/8jMLN751Mz9zeHFtKqBf03JqMND7pf48N4zWRTTyk7sVNF?=
 =?us-ascii?Q?NIFt0qhZY+zoAIVlAj6VinI90Zbm/USattuAYYAiWlsmJYwxFo2EkH46eEDO?=
 =?us-ascii?Q?9WUsZNtSpiKS2WpR6Y0lFJe+j1vcE+k2/k3dpJGenliO90+CYzi3px6QdMR3?=
 =?us-ascii?Q?hzUmd7cp8ts8VILfLrCLyb9Kj4hPxocI6zIJnCWnWwAHRnX5GlxTW3mNL+mv?=
 =?us-ascii?Q?7vdlGLDwndgUT0UYI4S2s6hSm5pRCvB0pENkRDDpvgAYH24xHJLZNvI7chU3?=
 =?us-ascii?Q?CuvVdv22zpUP51WxHij8jzHUp0X0RsWgMS0DyWTwTI8EslkWoyMD74kwsJEm?=
 =?us-ascii?Q?1XZjxhO5FCRpqUch7XVxGI+8bEG+G5YP25Q+XlqXZSWt0y8G2JMs/lVyDnyb?=
 =?us-ascii?Q?ygkZ9j7qfpdOZdQnjU+LBEI7+h2g+gOU2COwDM3GuN82CnDDD0H+Dcnb5U2n?=
 =?us-ascii?Q?1hLNaFVxhzfSd81N4YNlOnI2Bfd12290SOO860LYuYkNxCP2T0DW4o46wU6p?=
 =?us-ascii?Q?6ycOQRGNYZTGi1hlFS1HG9GxiFVadAz322/H+4Qz+rP7QYIPgQprAXwZU7ff?=
 =?us-ascii?Q?dWYj8V2ES5+WwKZ9Ly5LUH27mTTBgJjWaOTyZZ+FGiN5JxVX8ihxdzNV6WKb?=
 =?us-ascii?Q?nm8UXerLEJddU387WnEJbgEgxWuB/HS4+gZEXAOIwbLNtRA62rxPdMg0K+bE?=
 =?us-ascii?Q?pvcbeXrF+mhrJOhF0Lrx37o0QwgPg9OgJPMkZzAs17pJGY8eAXAVQ7/nlRYY?=
 =?us-ascii?Q?ioADMVtxMTi9+8qbWhdKitVRZb+znG5bZTnIFZnj67GKTVFDVtLG9xKbGVex?=
 =?us-ascii?Q?9p05mya75J3EZ+r0Ipf3nIUPY7t1oV+igMos5ukTA2UJmIxsNj3+Y5W8Y+9s?=
 =?us-ascii?Q?yUPgVUtgL9zNN0r1mTZkMcxXplKrLDFlLWPyQGTjI1nXk3OTBFa0P4aUybTV?=
 =?us-ascii?Q?AeImH0+X3eLwhJdYM7Z+88uTO+68RFEhnkuNQDVNXxYHVpb2xyIjQ4+R7jiz?=
 =?us-ascii?Q?HiPpEW3sT8P82i331ROTeUVx/O78FzcW1A9b9IIaxFQMncbfLqrxtDiyX+e3?=
 =?us-ascii?Q?RUcbpT05sdIT7hZk8+CF6enbu+D38U1sBG4cyf+zj5GOzp9FGfzwWusTJLYz?=
 =?us-ascii?Q?1+X5t2njqIGT7NRrW8yEGFdIWD8ygUi83ClFO+End/t2YC3AMn22KUH+q5ys?=
 =?us-ascii?Q?4wdbF4cEtie0LuPvV+ONrpQmV63zjFVt4wPWHy/9kt3m6wylwO4digPytI4I?=
 =?us-ascii?Q?5f898HMRs3XrVj1+4thob8TRe46yQMR3KKGvOWMKfqSZypQWi1vqVOhoptWo?=
 =?us-ascii?Q?yfmci04ofZZ6dgvoQIhW/Uj3S8kCyp+7YwTb7axfJBlZmEA7Ijle3eR9N29z?=
 =?us-ascii?Q?tA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XUxlVelVumOfIkFMSPfupBFniNjszlJHtE1mJx704lQUSueTXOVG/RsIC+Uh?=
 =?us-ascii?Q?7k3x/NQt0pgHoRXuo7asRFv7wJU/R/XNeOP6qIq8jySwHurGEKY/N1iRjrop?=
 =?us-ascii?Q?gN4W2/9GTuZWGQUR79VNJYTBJdcqiLgOe5Q0zQrUEAZ0J0/ER0TkRPib+0hS?=
 =?us-ascii?Q?m99I2B/GgfNZc3TMCUjGZZKkeApTf/FfSJODnRgLdVXOLDbKvDBDI+V8uFPN?=
 =?us-ascii?Q?iV1HIGojN/1KzkELWrfqy+ZbTVLuOr1ldfsTNf4mSTKxBerlRup5AtqD7DKI?=
 =?us-ascii?Q?5IbRIKwmdJbeuo8EkajZ7JLw5xXQ/QOG+XmEQ4ecgb+xHANJuVeoKWuhRocw?=
 =?us-ascii?Q?jTiygWl2KoVh4o52MCbIPD6icAsPE5NuO4Z2fEWupYAlPQBtdu4/7itdOMgn?=
 =?us-ascii?Q?JJQH5HsHb6X8/O0mfi4bpGWDzhAN/M1hkTqVwRXAigZwCnFdU4tk/LrKzywL?=
 =?us-ascii?Q?8y6COYhrrXOUqSX7un2wcf509eCKU58xELsnLNqnCRp4F+DOJ+1WcE45Lmrn?=
 =?us-ascii?Q?BTWdmukMdlNPzx5hW/g7BqV4RJTXEkdNCvJ6v1iaZnq9w/M0WckBPQLd9S8q?=
 =?us-ascii?Q?XAlt8bXL0VcVJef45NRp9rd1l1OH5Q1JBxL/mhUxNsng+Sc1F8R4Wq62cvUS?=
 =?us-ascii?Q?hU7VTL3ux7ku4zfyzlqt4QaQg5im4jwsc1qfKGcSV7lzeRFM0wRGLeLAigou?=
 =?us-ascii?Q?FO22uXYRpxwMvuLOyEfWEBPXhiRMPok7ddegyI59c9EhTuldOCbLTb7lEA9U?=
 =?us-ascii?Q?EiZzlfbmZxS7/2n2bEEnmIr1EH8W9YazC5HW70TZbzYGf24vti/s69PDHHIl?=
 =?us-ascii?Q?8Y5aPs60F0Awxfty3Lfl5rYJjcPsZPqlfJO5TRc3Ak38qkK9Me+ZGhMcgy5j?=
 =?us-ascii?Q?uCRQHRWoo+toGRhUxpQRUnigW67UkTCQtI2fA74uBw76FMnmsKSXyO+OqCLe?=
 =?us-ascii?Q?jQlVwPhBpTmR3elXWPw3PdjI40YfN058+kvU0KM8P64roXAX/Eve5TGK+1Nu?=
 =?us-ascii?Q?em/fbIFIKMOjw3v1OwV2FSqEpfQsrUz8KPjbm15NEleSaI7Ku6itGMrBKpZr?=
 =?us-ascii?Q?Q0vyWDjZDuGfU/xSXvKHrjQRb0jW+i9AI7QLh+0Fxi0/m/x8NLwwexsRRca+?=
 =?us-ascii?Q?wPBZDeSSRV8fttBygdJVuItdMRT99kgYwUMYLG0bpVCXfF64aEsk6Rsl6h9B?=
 =?us-ascii?Q?ykPqw6JxV91pX9JldUYIQeRa4e4WM/iCqPsA3LzT04x4un5l2jt4gYmEch++?=
 =?us-ascii?Q?L90rVr/qZV7l0NZSqRH95qEwpYIyfVOJhVegmhS5gTH2OROnT09SrIc5GxTB?=
 =?us-ascii?Q?teiRbAJYQ0mS9ESmh3NDB2g5KIiNF5b24Pt3Zcny3RB8JdnXuSDrG5J4tiFM?=
 =?us-ascii?Q?aXAR3A8gp4ec6+9nLj3TOM0UIesDMvwIK25ljQbyUw8MDPGByaOrKu565JbT?=
 =?us-ascii?Q?qbq+9wucfwu4U3iFQsi0IGyuzt9JMzZxnx2o8n4t/hUOQD9Uec8rOtmURkTy?=
 =?us-ascii?Q?bE7WQD19vrN4+XdUkMwAIYvjPlFOh3a6KUq2/HkiKwLc+EQSLER6AGpkzE20?=
 =?us-ascii?Q?p2zgyVcO2FYoCdo6x0hJ9C9mQEYKxIUZZhvcHKCTwglF3bbAHzrdmQ33NBUB?=
 =?us-ascii?Q?o2X3QR0wWnlHizUP3lMt1r37F92c2xWd7nXG/SESVDClA83MPsL/NlfRlBhW?=
 =?us-ascii?Q?PHnS5MfUDmrIT6TuJrgKP/xU28O/PzObdgv4El9EDjfq4CEs5JbwKnobcl2r?=
 =?us-ascii?Q?5ztgfWKkGRmy04h7w8y7N/CplbMiW55iKgIh/pTWTcVQzWZsYMgg?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c509650-cc41-44a2-f211-08de6dfb6c0c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 08:06:15.0993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LG3SrRWUpQvyLZDfhnNiIVsuIsOsqabzbUiayWJBkOgvlYT7AAMPPOqjTweqIXIsRcHPMQSmrLSkrmLieeT65Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7132

Some endpoint platforms cannot use platform MSI / GIC ITS to implement
EP-side doorbells. In those cases, EPF drivers cannot provide an
interrupt-driven doorbell and often fall back to polling.

Add an "embedded" doorbell backend that uses a controller-integrated
doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
doorbell).

The backend locates the doorbell register and a corresponding Linux IRQ
via the EPC aux-resource API. If the doorbell register is already
exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
the physical address so EPF drivers can map it into BAR space.

When MSI doorbell allocation fails with -ENODEV,
pci_epf_alloc_doorbell() falls back to this embedded backend.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v7:
  - Use designated initializer for consistent styling.
  - Clean up the pci_epf_alloc_doorbell() error path.

 drivers/pci/endpoint/pci-ep-msi.c | 96 ++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 50badffa9d72..66f5a68c81b0 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -6,6 +6,7 @@
  * Author: Frank Li <Frank.Li@nxp.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
@@ -36,6 +37,84 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	pci_epc_put(epc);
 }
 
+static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
+{
+	const struct pci_epc_aux_resource *doorbell = NULL;
+	struct pci_epf_doorbell_msg *msg;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	int count, ret, i;
+	u64 addr;
+
+	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					  NULL, 0);
+	if (count == -EOPNOTSUPP || count == 0)
+		return -ENODEV;
+	if (count < 0)
+		return count;
+
+	struct pci_epc_aux_resource *res __free(kfree) =
+				kcalloc(count, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					res, count);
+	if (ret == -EOPNOTSUPP || ret == 0)
+		return -ENODEV;
+	if (ret < 0)
+		return ret;
+
+	count = ret;
+
+	for (i = 0; i < count; i++) {
+		if (res[i].type == PCI_EPC_AUX_DOORBELL_MMIO) {
+			if (doorbell) {
+				dev_warn(dev,
+					 "Duplicate DOORBELL_MMIO resource found\n");
+				continue;
+			}
+			doorbell = &res[i];
+		}
+	}
+	if (!doorbell)
+		return -ENODEV;
+
+	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	addr = doorbell->phys_addr;
+
+	/*
+	 * Embedded doorbell backends (e.g. DesignWare eDMA interrupt emulation)
+	 * typically provide a single IRQ and do not offer per-doorbell
+	 * distinguishable address/data pairs. The EPC aux resource therefore
+	 * exposes one DOORBELL_MMIO entry (u.db_mmio.irq).
+	 *
+	 * Still, pci_epf_alloc_doorbell() allows requesting multiple doorbells.
+	 * For such backends we replicate the same address/data for each entry
+	 * and mark the IRQ as shared (IRQF_SHARED). Consumers must treat them
+	 * as equivalent "kick" doorbells.
+	 */
+	for (i = 0; i < num_db; i++)
+		msg[i] = (struct pci_epf_doorbell_msg) {
+			.msg.address_lo = (u32)addr,
+			.msg.address_hi = (u32)(addr >> 32),
+			.msg.data = doorbell->u.db_mmio.data,
+			.virq = doorbell->u.db_mmio.irq,
+			.irq_flags = IRQF_SHARED,
+			.type = PCI_EPF_DOORBELL_EMBEDDED,
+			.bar = doorbell->bar,
+			.offset = (doorbell->bar == NO_BAR) ? 0 :
+				  doorbell->bar_offset,
+		};
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+	return 0;
+}
+
 static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
 {
 	struct pci_epf_doorbell_msg *msg;
@@ -109,8 +188,21 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	if (!ret)
 		return 0;
 
-	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
-	return ret;
+	/*
+	 * Fall back to embedded doorbell only when platform MSI is unavailable
+	 * for this EPC.
+	 */
+	if (ret != -ENODEV)
+		return ret;
+
+	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
+	if (ret) {
+		dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
 
-- 
2.51.0

