Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021077.outbound.protection.outlook.com [52.101.125.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0016D336EE5;
	Thu, 19 Feb 2026 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488811; cv=fail; b=BSIdwNYfweAYLDYFMc+ekZqT6WO9oq6iv/ev9jNkeVtYkAE2VN8iT7GB4iu9ztJs0gEuXf0htfo13zyM48i8GQg+/Ux1KdTGJRISUpTPUes/gRKFhRZZCPGwbFCWzEvPm6f9v/av7qQtKfoSNwzIaHZJ57zd1zg3NuazHeLUxdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488811; c=relaxed/simple;
	bh=3XBmFh5c4YQPMkFxa2k0OW8vm4trzZK1Hpi3jBKLRE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hqJJUHp/2GMjO/i9MLbj7W3lJCiG4xYcFYifCNWmwqTQnF3hdPO9+/WvnXTu7FDcZQG493aguxj/PZzpt6r/h/vmKZpFXcCq1PdHoZ3AYc2Qt4zjYtiJmcvnB/tWWHfpYLhP7VgdOT84OrD+IUpeOdb/808+7XbCP0bkVYoKNoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=B2JpuSU9; arc=fail smtp.client-ip=52.101.125.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="B2JpuSU9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arQ1Y9XYNoa8He6iFR12RbK0UWnD1qHOddXRIIwXTbN55mWksWVMGmK8GbK0Z3GsGRva1FvmsX2j+kE2cQbNZvMrJdqWI5GuCdrBP/lUQ0EQ/urrt7vyuTsKDHeRxByl3Vp6uFPuKIeQxP1IMEE03vhn9s87mdyhmum9yK7YGlFEOOtT6+pz0aDDsveZ1JsKo2rO+twohzUicAADMssi5Js9jPj0+P6EGzjK89hIfz6rkpUClAJa7bQKWM+77x7LD8uRSKtUpLZlu8Z3NSUNRn8PyVkPDgJbSFUSTQJ+0P3lWC8c44NObSolwPsuWWsCv7DHZyQfx2DsnBXNrKmP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BlxF036CRgSk4TywN6LSCUQiNVlw+RBdxbvkm03Tl0=;
 b=xBHVm5GjMFcgul0DJm1OWG/LmmuuePZYlqUVOGEKtgYuqGgv0Y+E/kHHp4mBNMsafFDgKzY0slVcpampzBumrhv1XFoB/fGvAJRMz6JmOu/DDpgfHY1R6cLzb/PIKi9nEiMp864zaP3KXF5gqmD+wLafez/AibZ0c5ziOYVtdfzJ+vocOVmhX/KTjvFMr6R10j+dPk1ZIjzZlEiVNTGoyzdh12+0QfMVFQ48hXStpvgmqiGcShf4MO3abeYLq34pHY7r5xvVslwfw8B6WDMqarUS2JF8TRlyPW79uxMGp/D+EdmFiZ81omVV4I5kcrCB8bSvP4Fje0rMimdISpWeVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BlxF036CRgSk4TywN6LSCUQiNVlw+RBdxbvkm03Tl0=;
 b=B2JpuSU9MfttQQiOafdP5GtgOaNmUKloWEnmbfyEl0V4Ll0F+CH1JFBx/wFBky6DeQMkBOhldgVh7ewtQDQQkYH4688qCPxykpEmWy+fx56E/bw/wk7FicGebgQDTWwf8bZMV5fLKtzjYntakGy3KHCSlAduDCWiciWnhfo3pro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5862.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 08:13:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 08:13:25 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com,
	shinichiro.kawasaki@wdc.com,
	christian.bruel@foss.st.com
Cc: mmaddireddy@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v9 4/7] PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new backends
Date: Thu, 19 Feb 2026 17:13:15 +0900
Message-ID: <20260219081318.4156901-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219081318.4156901-1-den@valinux.co.jp>
References: <20260219081318.4156901-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 8224cec5-71ab-429e-38db-08de6f8ec119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p+DMOHyS+cicY8IjpIr7p7wBNbkPRIKTX08X0Z9jW3pdBf3e84u/eAZ7TQ4N?=
 =?us-ascii?Q?XMneWxkEvqQiYSxtUgH2E4eDZ+xKFoEjZu2nC5l8Vqs5SW9JPhuhNV9foNo6?=
 =?us-ascii?Q?VCgFanKVIcVWfxMV+Gurd9vDq3pRuwAGpBkoOpFr7g1F5OKtUqtzFSonh6d0?=
 =?us-ascii?Q?NdNB9LiEV9ninvqdV9la81VYnYMSLq+b5zvfmQ7ilzmEAtxu3t79wpYRPcuX?=
 =?us-ascii?Q?aPUTqqZiraQdvP6o+1wORgOIdmowgg8eKNZZzJqoHNUEQ/m/CCzts9JnH6Gv?=
 =?us-ascii?Q?nu40EXH1CY3g3iBNnYdTmE+ND2nEWqUi7VJglq5YGyheBudSnN/1YOgfbjcI?=
 =?us-ascii?Q?YJ79xIJ8xwdNbSmCg7eyYaeM5X83BJIdLmmvEP1EAjK0v0mP4kCz6ZbXHk5v?=
 =?us-ascii?Q?c/SD7fXySbNwRvs9FslPbzl4gF8vosugULoOoN3TnWPtQQOcK2A8kh6H6FCt?=
 =?us-ascii?Q?U1CYgE2Hvq9kpY4NmGwrJTwVkCErA8Qqs78DWsZJWgSWFXCtKm4XFFOkx4GY?=
 =?us-ascii?Q?KSuDt6SavKBuot5vvyGsfxlDr/+nJ9neit3Zc6fzGpQkbVL9ETgVBhwIydmd?=
 =?us-ascii?Q?6yBZsSda48JqfYs4ucU7mgP9JxI5RwJFS7m8ltvJT5kX74iCvY4zvUdcn/pQ?=
 =?us-ascii?Q?YSBnKVke0P5vQvlX0nNWk3YWDTbLWX6z3oMHpAskd/ATrlpNS/rIs5o497R6?=
 =?us-ascii?Q?bkLyA7+QebTAo/fPSbhjPA66awV5Do16BnYJQD5F0ICWEgPIw0VlGkPo3lmC?=
 =?us-ascii?Q?yund9IM8KltPo5kY1QGcVM1W1fD75lljDZo0ZLPppWJqFNu2h+PNdFacLUfy?=
 =?us-ascii?Q?KYKVbipQhPvZx0yD0sTr2JJ9ahVEEBXupedhhco6XcYr6wxR7a2C/Wf5Dp69?=
 =?us-ascii?Q?aU8g4znI3jAQhOgPsu7ZMZLSTy73NHwDeyLevJqvR4vZShg5xv1ZWxFJgg6P?=
 =?us-ascii?Q?q5wYx8PSHJldx9DsxORThkaS2GpkzXl9ulJQefTX/OQUz8sNv8QaNXWAMRUt?=
 =?us-ascii?Q?s3dIbufVCGipgmPcQZdhjU6sdMGKNECJD77ffbwuHGri+tUMSrdmB36e9PkK?=
 =?us-ascii?Q?36iBBFXxjcbcK46c1HP7J5Fj/A4p7GvO/vcAo0cOVGxw8jIse4v2RH0DfhO+?=
 =?us-ascii?Q?IK5EhG5u3Lzhi1xYSnCImjF1FKWTgxoTosw3UyAMNLy4PIwyvJIqcHc1opIu?=
 =?us-ascii?Q?p9JF6/mnRhCUYyEEt3C50hIbBTgXZ+xC8oBbIPwq15zXdlY8e8W96yTzJFgy?=
 =?us-ascii?Q?vQoQJZnmlA1rV3wURdeLtYsVAcslhBYIBep/AqgM7EacAHaCDIE4RFLTJVls?=
 =?us-ascii?Q?uWSD2SEk9oRbbfbO6DdzJMjSBANUQS5Iz3U9j+15acVMHeTVw4bHo5dEhdR2?=
 =?us-ascii?Q?TLrzW0Ihel597fivgqQpRCjRfz2RiNZPSNrX6K4IoJNW0wfU2d5P/UJbqhc7?=
 =?us-ascii?Q?V1t7csPZJeO7sORTapzlHn4qPhdCmPNympX9kGlgOBLbgk/0b1iKn26w2LET?=
 =?us-ascii?Q?HJBVUp2J9x6g67G7SIx1t5Mo6vK2qm6XYFDEb22sfhQ52U9CcCu0F7B95Mja?=
 =?us-ascii?Q?hahhSLRdeLr9nbRkmLo91VENj9bekkgkh3XlEU8ouvalBrGoNjbSHVaFZ1r6?=
 =?us-ascii?Q?Rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cKxTSse9PQGkkrdcK9y2/d6tWWV6b7uzJVyxyxmupvGFsEcm/5VdE9uddm73?=
 =?us-ascii?Q?tKCe7veoayKErTmrhgHpbZxmc/ESEQ93ZxLz2+MSa5k9ZFubbJIzmagCHM2x?=
 =?us-ascii?Q?9sbR6XdmzrC2HoDUGxE3fBkqkPBc81xpEOL+nGwcUVaCJFUQkYOplJPeoBzd?=
 =?us-ascii?Q?jjMa+9sVDW4yxpGTNI7gEx3RWU38MkMutP6TCmsoo7CTIMxZrblSaQboPIGe?=
 =?us-ascii?Q?IW19xbRyFQ8hin1cQlTDBvkcRcwqX3SznqDL3mIKhRtUbZWb9W2pWbQKCPPR?=
 =?us-ascii?Q?JR6QVpHMJ3E4hhtxpDTIVtqPErHNqD8Q5xd3xm+5/JK7JpCSegYu/4HFrLS1?=
 =?us-ascii?Q?t8g2yHSy76XSDubm3tI8GqJMKFUm0VJM9fHhAKG6PRVENny5jGUQ5Glj57me?=
 =?us-ascii?Q?Va0F8CJzeIfNkRylMAZH5cFK6iKYFQkWIsQEP5KvjyD6UqvohPsT06VGXH/N?=
 =?us-ascii?Q?zxpwLWwnOsNYt5H9KATTjIbAjcYeEk2W8jeZvyD6W4wWZhUs8VOcFswnv7Wk?=
 =?us-ascii?Q?ipowGOkFlinzcgVegi2RqpPSVebSMsYIjI4F6nE4UXSccaQ7FNKPSHnpdaTl?=
 =?us-ascii?Q?x78a+O3X+9Kv/4FzWk/cCv1VFWkAKDzcJmNwuiEC7yWHfntcH9G2Y87MGg0z?=
 =?us-ascii?Q?FN/qqKk8YuoXWuC6e0aAYHEr59yKS81+sL1Frckb/Yv3Smt00i4fX4jfGreQ?=
 =?us-ascii?Q?qofQKJChF+e+L7TMxAbfyAqH0DVq+6jd2nMpEow9uJD80PNQnOomoXzt8BLZ?=
 =?us-ascii?Q?r46vFfpnd74Dwktf+RPmEk8hhTMEoLnjGcYJYMwJySzq7j0TU8UvtHchXexm?=
 =?us-ascii?Q?aMYt4Gqzvxk9OgLrpwtYGSsAQ38lKOuDFf3FRScwSd1agQ918naEamnxwUDe?=
 =?us-ascii?Q?yw4JU83itdFa14s0jWFgr0EiQAu97bjHARFz/3JUgdH5qxkyfe3lTdUUcoim?=
 =?us-ascii?Q?nGrUCp6n1zhPxLS+0gz2BgNIphazghDgFCl/6+aCIIfRc1hOq1BDTsIM9cOl?=
 =?us-ascii?Q?EicOjya+lIISAUL7VMnfo2Aiek1UTW5wJy7bscJF1e3xVq79uDp80tDkJTRM?=
 =?us-ascii?Q?ov3gd+PLjoFjnEtACI4c4bZifsb1602sJFeyHBF2kAq7HKJhnNrx2iQuW3yI?=
 =?us-ascii?Q?BvxkYsJf7j6+Haa5SYNGxjUnxal8ut6hh4j5pjDEhBOHhEPYiZqMEiH1xk/F?=
 =?us-ascii?Q?VzImbAu712TvolKujck0F5KlfXz6/3VBf38D84KKsWh8D79h/TiWsQhWh4m9?=
 =?us-ascii?Q?Xrycysaxk5Q+vup6NHD82yXxRWoPJOndSUHOAG4LktF00zlQsbujnkJWDZT4?=
 =?us-ascii?Q?QC8CwWAT+++Tt5QWNcskPskCS9/uNOZdlLVLbNTVShfX3yNRkXnDmU4yyR5J?=
 =?us-ascii?Q?JDJ7a2wvdza1hnmIJcPVGEfgb1XVJ2LmTh92uVuY2gOOo6pumfbZ8PuKRwAe?=
 =?us-ascii?Q?HaqNLvj5oTJnYbiDoiOSCS6eRUXQiVxn5q3tWmijEZqgMAMDtqOD8/jGwn3E?=
 =?us-ascii?Q?fBDZyhyNP3bFDCtth13li40EXxU3LVs76JvlClbV6rdOo0f/xpUGZz8NrW7i?=
 =?us-ascii?Q?TBwBfDYBeYsNCt1nX8pjwEKe72nQO+gStxWU3Kx2AumLg0PFAV3ZfudANmxF?=
 =?us-ascii?Q?TJDtkcf7EVh4y6TuojOpvSkoDr2tbZAfcH2b/4GI8s7QasUkSrrm6U3AqUwp?=
 =?us-ascii?Q?duJiliz9NsdRY2aB2wnUWaAI0t6iVSYTYv2YSnZ4hDghRTT5xP59+ebLN+2o?=
 =?us-ascii?Q?//e1UYISPq14RksNbTPbBISkMFPCkOebZR4qaYKBBW4Ia8WyXPAN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8224cec5-71ab-429e-38db-08de6f8ec119
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 08:13:24.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pgJNWfNub7XCCiqTrBTcTzHVYrM5Hu0Bdbv6aQloDN1uy3NJ2tel1MzNQfjJlHQ9qSiooc2zmPs7fzxwZHTTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5862

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

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
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

