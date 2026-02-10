Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE827FB25;
	Tue, 10 Feb 2026 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733272; cv=fail; b=bkge/uL/Gdy6aHYNCSm1yoU+6utsNuK48ErPZylgStxrMzd28WZbkdJ+XibS16HSN7AoH81UVcfnNR4dzNkbyX/i+lZwq9nDxhNXKvizu4LZT83AxWoi3gv12L7DwNcgHazmJU+MxE4I5eV58tfXM/W0+ODciGz6ZrLbM1DSuZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733272; c=relaxed/simple;
	bh=I4/VZ3pb4WBJuHOCQLzQ5Kx1w9kTShQrRVw/JME3MA0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c5qJcLT4Vu+IxLZOkcT6jGllSdiDhH4QahbJ5U+HfPBoIy2ECbmlhqXOwCGbh44gUN5OYzthfTVjFlFDXIbqkVkyzs4j3oV57hhKGXlUlbxIG2ZG0cSjQbJGFj74hfTkwBcYEhKnm8Kvc7dVTdIQAPGQlsltBgCQB2lw/wyJajY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ghYQqPE1; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ghYQqPE1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nI3GF1HWwiK7BUJVuic38uzbnaKp7OQYDXlrj0JWXAF+ttgA9ONuwiB76wiBq9c9L67/e/vKSPtcCbZPut3cbzACbpnCDYnlhs1EJWZ2+k1bfjY4hGSUfbijW7ABOJ+inP9zBn65pdtTv1ElZ3kv5eklaK5uBdImm8iHYBcQQfDCWez/P1j9c3dfDMlqNQBRgZLKSG0En2KsIhmHg26dpK21r6F7Rm77d9oFubay6XUZw2NP2d82TRDO58Sjo0xSOQG8H/DzQTYjHghIGw5p4VTiMo7FBPMkejhApuPKDLV0sorOiUWm7uYTHqIAg6jwVhyHcUoYINHHhZsLNrbpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nC87JOx2qkerJVMXTatNuoOc4mwS63XjzMcKtZH13U=;
 b=Lqbtf8MejE3GA7NAtCGQpmt8bH7wqApQ1Ci8tvFFUel7QHH8SeehXoIxgaUmpLLjwBTtgp3FljUXMHwj89M7hjkaDGy23MMO/Q+n69Un7M4M09aho8S8FeMfW0rR15WMEk8A3KXzqSWIg5iOAFLDGxztyc0gu3Gpjh5CzOEHFEQolEFtuLe4i0MtgPrXif6jAZpxYoYjhZwBfhVIbzE8CNF34rqaOwyMTPE/U0ZM0YVu7nADzVvE66HLmlPfI7rbZpeXtbwpCRgviBwEVlbjA9RlqG56nBHcaCCYs9i6sCzM/PTjRA6aSq4f985wPaRlvRTkFDJ6o9gAoGyc56AFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nC87JOx2qkerJVMXTatNuoOc4mwS63XjzMcKtZH13U=;
 b=ghYQqPE1R8D+i/3dxm+EwIyJZY/th0z3RqwkTkMLIDWb5KLgRZg3DhD78KNYBsNjkx8z8fJpiZl2uk0QA8L10jmSRt9KpfFMQ9LcvqCtnWA0FVVl3rFNhRwy2tRE807+OSMde4x61B72EBTyCA6aiox95CAW97Bcof0kXSrS21CBqGjLzW/xFiqjQOXGJQxe9M97DlMjqqvECFaTvGjqqtMbLMvdE35FRP5Tgnpxh0sY6z6e994P9BmOlaJm0T9Kj5XjvevELmGxxe/lKp7Vozxg+ojte9AfXkv6ZsdFDw+3Nei5ic+V7xVrD9G7DILgxrQ3fzeE9TI1U8qBmDyClA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 14:21:06 +0000
Received: from SJ2PR12MB7917.namprd12.prod.outlook.com
 ([fe80::6e3c:d0e2:fc8b:4e34]) by SJ2PR12MB7917.namprd12.prod.outlook.com
 ([fe80::6e3c:d0e2:fc8b:4e34%6]) with mapi id 15.20.9587.013; Tue, 10 Feb 2026
 14:21:06 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: bhelgaas@google.com
Cc: ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kaihengf@nvidia.com>
Subject: [PATCH] PCI: Validate window resource type in pbus_select_window_for_type()
Date: Tue, 10 Feb 2026 22:20:57 +0800
Message-ID: <20260210142058.82701-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:34::17) To SJ2PR12MB7917.namprd12.prod.outlook.com
 (2603:10b6:a03:4c7::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB7917:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: f18efe14-322c-4442-9caa-08de68afa0b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2fNn/aggx/uC/pfuMTPFPqR8JBMsOxp0PoXElvaGpwpIyaVuOLjzB9Dh8Th9?=
 =?us-ascii?Q?xOeZJsf8uQvei/UboT17nirv56AG5GYNcpnqDcwWIfEp1zT2whF7SkZMfYHQ?=
 =?us-ascii?Q?VHaaKQUkgg2KiJ9p1WRB4vmIZb2keJEDsGDaIz9FEf2By1h9sQXpc8SZwZh3?=
 =?us-ascii?Q?AdwqULI/TycaLgu9UrqU/XtDqMtxG7iIXRObqyi8uBxNZcZHZo/vih0TRQe6?=
 =?us-ascii?Q?bxOvPTCrJZGkBuei8p50HBiFeZoi8QiE0GXiP5WPw7JKp1SOzFLS2aV+r3xC?=
 =?us-ascii?Q?URZxFweiXuNU52Qkn214I9XmpTvHPdqtu368pNCP5su7Ms7WS8NpQ9l8/H9Z?=
 =?us-ascii?Q?aYdFY08CSGdY+FF+kZZE6Uvugx6bZO15zthfGPvVKs1h8Vfm8ZfAIerQjpgp?=
 =?us-ascii?Q?b/1hZQGCo7xkm8+rWvqd2EuWoVMDgVOiVXUhBkAKT/wRqLxHiX2zByiEyXfc?=
 =?us-ascii?Q?H+roQj3dsWhh+PkD/m/1Anig2lhgGMC5SS73bgcMtXKZOZxjQO5pk95O2rtK?=
 =?us-ascii?Q?9EhMtWhoZwN2dr+I1/2ILP6/1nfP86b05oQ0kuLBU+vOFUX+NrXcFvq3vkK2?=
 =?us-ascii?Q?joPusOPw0Aeha3XMHXncvGtpSaGMaDc2O7M+0HdTGEefCeEkLwAgpMYj7InU?=
 =?us-ascii?Q?CE1W5BsZhAkTyLt4zXnRaoeu/NE6kO5d/5C3Qxq430uMegxDL9XqubL+pzry?=
 =?us-ascii?Q?1A8tZLlVX5gcBAiwe0dT5Xw3yA8qhQqOv/6U43hpM4+snT82xBHdQGIQWaqE?=
 =?us-ascii?Q?f5Gyt0LUmewzS5hOgm0uowwogCgzjS8NmSb7XGVUPNjUv9AivtAe5YSYzIV0?=
 =?us-ascii?Q?FXoJwsSQomA4Y4ttWcIzlyem/u3SO6LuS1bjfZ7t/czx48PAbR7Owv8ZQ5bk?=
 =?us-ascii?Q?jwRlpcXkmL39rIL5jGK/ykkB+Ry+OmZBClTQPpEUY5v98GqAblskXsqDC7/+?=
 =?us-ascii?Q?W72Hg9RrQtvcoKh8c92WqWTqNs1/MqIvQ4ef0XEdkLfLTtM8gGCgGik0wbGW?=
 =?us-ascii?Q?MD0LbLmXbt5CxywG3cUkML3kZEHrUAU+hOrW/92BzTUSCOCHJO3ooNpHs0jd?=
 =?us-ascii?Q?uy4ufXMWNLdmIFA7dKN15jcQTOiSdznA/yoU4lIiXRqf20qF6i6aoumkYm+c?=
 =?us-ascii?Q?d6XvfM7eEe84876PFBfXXzVAlS2wF+xFmiFCd21uhkwW7Z98NjI9yxy66+v0?=
 =?us-ascii?Q?CMWy3tkOeHTwRDzSKjTFTOFFberc2oFwVNFVAG8uPKdHSNyRb0YGp3f07XwF?=
 =?us-ascii?Q?c+ud+X9iTro6ukY9ij3YqTGk5XeekYVINniD+ygNwIQDpALofLN5WuCHae1p?=
 =?us-ascii?Q?iPCUcHfIyCAMviJYihAlWhNyU2OcMncH+EzbMCeJ5ga1mAI3yO8wNglHULC1?=
 =?us-ascii?Q?1p395p/Lk9oeQd53CKNZgiII9TJPId2njpXulfKjZBwiXeM4Sid5vzPULeMS?=
 =?us-ascii?Q?nJBzyNaRNJ5CvHCz9QTslUfBx89EJqsWk6Lk0Klj6FlBvHNZvHZsFwDnaHuT?=
 =?us-ascii?Q?7mlsal1DIBA9aII5utY0oBxzyA2e/U0BkO9MX0CwcZiQ2b2jj0u2qOeQe3s2?=
 =?us-ascii?Q?INT+e2LGdE6UcF41TjY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jl/vnA4IUQsuLeWW1CmWFz9yhysf+Pwb9YSF6rfTbpUMdkusvvOrNi6v0pg8?=
 =?us-ascii?Q?6N66LqBru3C3VTE/1B0sGxduMPR2SCgnRCCsFUuQTK0ErZpn4PxNJvvFUuOK?=
 =?us-ascii?Q?oMq9oriZ36kmq5Jbg7WpUwIWinvmxX0wQNXsLySuOl8ZlCWuuourdNvOuIdP?=
 =?us-ascii?Q?5Ccq3Q0pMTTdfR9zQVtibzLZNUrlMAhNluJHwAP7Hnmy80WIBXpNxjr1Quvq?=
 =?us-ascii?Q?c4WPtzDNpqvyCuiyCyDmcEC0qgkSUfZ2bGB5UDDwy39ehjP2Zcyh+YqvwKLB?=
 =?us-ascii?Q?EQgv9Mqx3CwGXaqfR96s58s6BBuoX8RCrT+7CuetWzCiBP0BIeZcUcHcA+bA?=
 =?us-ascii?Q?b8mQot8/eyhqlhOLGDjpEtthXyRyZ1aCB3oXWqy/5DV0474pH/iwwrzEm1DI?=
 =?us-ascii?Q?IScdJcnOx2xxSBwTLG/XXp7inEjD9TnEsUKgR50m6i43CUS0SNTUwsN+ONew?=
 =?us-ascii?Q?rnyv7w3ESdYp9BoEnLL9sJ2XCn9ZFq8I41TVpoAj8qsCh06Nl6sz1AhNqEdP?=
 =?us-ascii?Q?lrbbZwIU+QVMRXfKSXYo5hhxbJys5gd3WG/ijTVocIx8CddV6DoSAea8IKqT?=
 =?us-ascii?Q?/OEKsVeLbPCI12YujEOiu346IElNwwuq6MSKFzpdlv2S5L4RgKwdgeLZg1y0?=
 =?us-ascii?Q?vryXGCYS0G6kLYF/cTCo1DAyW737eLkFPqGmOXjAzuLS5R3b+d83TI0lcpJZ?=
 =?us-ascii?Q?CZAx448IExaNQb9lFkwr3oubC+2lwKN+UhjhLDARAZjgk+5hYOF3/9UPfQcM?=
 =?us-ascii?Q?pc5PyTvugOFOeLlvGAQlOn3fOb3lWA0XHknLv14QJihKfgsiJ5CJ/v1kLvGB?=
 =?us-ascii?Q?e9x5EGGnf7atX96u4CCUzGI2jcIxDu2BH1Aj1FMkGWijUR8p5+3CzNCm6BD/?=
 =?us-ascii?Q?sKUySLM0r6FYu6U1GlqvA/Ww3C77OG1HHGR39pac8u3dkWv1qEEf2itUi8+4?=
 =?us-ascii?Q?YXi4T2YGn//iFFjEe7BMK8ktx9alGLnNfq9oCFEaHddC33q1WE9AflxD9Pe+?=
 =?us-ascii?Q?QjbATmmn8jReZPS8rNA6w6tTzjKlqp9L6WL76yFnkHjNfi1JtR7mwdTwFTL/?=
 =?us-ascii?Q?uzTN81YQaxRFW3AqCv0ey+NbYLw5XFbG0+IiO2oaEyAL8vd0sAH6UZyg3PKw?=
 =?us-ascii?Q?1xGe86qr61gnl+vAW53CCMmtDRIW2/WIhifi0Q47ZUELH4h1B1mMf2Nhocj6?=
 =?us-ascii?Q?2yuir2Z66VpDfUiX/bN3O91TU34b/J5qcNChDgr429gg2bKI2XghwurlQa/5?=
 =?us-ascii?Q?pxyg73i3dbrozL0s1A0zpJec8qPCnyEfLQmSHV30E9Ez5SF4KT8iBuK+R3ER?=
 =?us-ascii?Q?HYGY5t+qsPwF8h6HlEKKxwu8N1KAA2z7kMzCEWpokgEushEdXCfRG2CLhwBY?=
 =?us-ascii?Q?Hd2UHr1bs/eNERX7kD/56nWQHjEsOTcxelsdryhcIWX+wIZ53H0DUOco4uQq?=
 =?us-ascii?Q?7bSQDbNwVSEv/AXog43eO4W4DunW8malc2BhTzNW3JFCE8XR//dJfmE05jbp?=
 =?us-ascii?Q?uzVsMJMfC5ZU2F9uFuq3uXdz1NVzzhWj8huakpfrLes+7MKBH0gNQrV6twmP?=
 =?us-ascii?Q?nBH9tHpf5DDy/yXFPHkYBfsDCGbDTJAU/Nw7uLIUxnsGzjxQOYbD/5CtXTAu?=
 =?us-ascii?Q?gS9hvJMauJzAeF6OLnzcifJtb4njEfJGu554MJp7HpJUAFz16BzRIbOuG/NX?=
 =?us-ascii?Q?Ytsfq2O6nvWYTY9f3+GNOwm20MjLVP+TVL6ZLoh5WqrN6WIgsSCHdfNH93DP?=
 =?us-ascii?Q?Bgu5m4zXcA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18efe14-322c-4442-9caa-08de68afa0b9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:21:06.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qscAOxfKKBw52E0oMP+7FFrnNQYg41Kkq3DKWVaFpdDFQqLApkdluuusisIbD1evGq9cRxbijJnFndQvsYUXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473

Afer commit ebe091ad81e1 ("PCI: Use pbus_select_window_for_type() during
IO window sizing") and commit ae88d0b9c57f ("PCI: Use
pbus_select_window_for_type() during mem window sizing"), many bridge
window can't get resource assigned:
pci 0006:05:00.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
pci 0006:05:00.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
pci 0006:05:04.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
pci 0006:05:04.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
pci 0006:05:08.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
pci 0006:05:08.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
pci 0006:05:0c.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
pci 0006:05:0c.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign

Those commits replace find_bus_resource_of_type() with
pbus_select_window_for_type(), and the latter lacks resource type
validation.

This commit adds the resource type validation back to
pbus_select_window_for_type() to match the original behavior.

Fixes: 74afce3dfcba ("PCI: Add bridge window selection functions")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221072
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
 drivers/pci/setup-bus.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e680f75a5b5e..1b5185697011 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -224,14 +224,21 @@ static struct resource *pbus_select_window_for_type(struct pci_bus *bus,
 
 	switch (iores_type) {
 	case IORESOURCE_IO:
-		return pci_bus_resource_n(bus, PCI_BUS_BRIDGE_IO_WINDOW);
+		win = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_IO_WINDOW);
+		if (win && (win->flags & IORESOURCE_IO))
+			return win;
+		return NULL;
 
 	case IORESOURCE_MEM:
 		mmio = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_MEM_WINDOW);
 		mmio_pref = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_PREF_MEM_WINDOW);
 
-		if (!(type & IORESOURCE_PREFETCH) ||
-		    !(mmio_pref->flags & IORESOURCE_MEM))
+		if (mmio && !(mmio->flags & IORESOURCE_MEM))
+			mmio = NULL;
+		if (mmio_pref && !(mmio_pref->flags & IORESOURCE_MEM))
+			mmio_pref = NULL;
+
+		if (!(type & IORESOURCE_PREFETCH) || !mmio_pref)
 			return mmio;
 
 		if ((type & IORESOURCE_MEM_64) ||
-- 
2.43.0

