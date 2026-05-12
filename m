Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013036.outbound.protection.outlook.com [40.107.159.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39414245031;
	Tue, 12 May 2026 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563247; cv=fail; b=oxU+3S6KeyGi+6mW0xqRaDbajBZL4Ot80w4WKqaKSZ8KU1A5yWv/61F/N/cNdG0cdaemzrsatnjFjCUild+oPUpPp0RrQKZqtOYICyPiobLh7WdqHgLgOOrWpycGm7qpFvCPYjcsiYVPv6eooWmZttXvWUkRmiXZnbl7XUwcOUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563247; c=relaxed/simple;
	bh=jweZBIWoEVqcxEUXiFO6WKkYmKYFpXVseZ6QfRlLIus=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ocy7WZ5ucjUFKlhq8g5n6be3+2TL2n3TmHvmPjnXuYmMr5RbEZYYZcEm2t9rpVwvPeL6Ao+tTRTSACSODe+Cx/SjeOIyynDR2gVCfTpaTi/WHCKgaFnO0PIEqevDCF16/hwZHJ+A4ADje3bp1o8MRDdhQLleWi7D1j3KtFyJReI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OSTaN+3s; arc=fail smtp.client-ip=40.107.159.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OSTaN+3s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWb9bvHUCob2rcpPHWcXDq5T0PNPfBlKRcOP483vnZB/a6NMaW/9XQ4UZyMx7CV23X8qh25rOx/XCki2RY/JARWPUAAcVa1j30zppk1YYzBmmIe9hdLYXUt9E0apf4mpFGvNdAhTRKYesstFCCCRnQ47CESvdFnOCX30YuUhk14HlV+5eOtOI/WFjf8UAo6o24oZCkEBdcD2f+T24SdCOgP+kNefJ5VtsmqXjxLWBpWlybNAeKOsOX2So6YONz7u6lF5vi8uXdJlgD55ELApfofuu7x+k9zDknSfg4bPN/KY5PyLuvcdOSu5tA1S+DXaXz93I5pv/SOJuzqsWgienQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jweZBIWoEVqcxEUXiFO6WKkYmKYFpXVseZ6QfRlLIus=;
 b=hnExN8f/I//CuWq6rManYKr0Hc8DIS9bF4mNw3QHy3gJu+wJmXWQ3eFLxiJLWFJxEEvR6582DXKElpvuhoFvZNWy/dtKJKHOpPv34LKIuD0T8F9Ki0eY1wWVfy8SNoXBMw4TcnCDFbjmlXKHVjqu/MR7W1yDsz1OvTaf90nBdoZZobPe/NPhh6l2T1NrJeNgjR3IwJGYkZkh+hxoCQlzyjgJ3kvYHpYXvDv/oqIOBT3xw791t7LS0CbR4tMggsVP0Df2G5Xz44vvGqw9nyPc7HdPNI1uEBVyNeVvIIxFYlLHwAn8eb7Rx9uTdWyiaT7RDtVf1A1fn9A0tjSBI2hmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jweZBIWoEVqcxEUXiFO6WKkYmKYFpXVseZ6QfRlLIus=;
 b=OSTaN+3sv7fRESoltX2/spwqk+4HFM4bfdWIG7SMDJJKw9uoBk4odYuP5PjDctzqtbWTRQeGekZH3KGWWKS4s+108L2JvxzvhJMnqMjGtVHntMwI6EBj+oiy84w1XaiHxevLPrSz2POKoGdK+jRu7UW3H0Vvs5TGeIxILXmfGSeU07Cix3qU5p/PeLC9b6kbs0Yf7U1vioGXnHgDUOQXtvKrB+r5bBYuT2C0eZpE1ukynsGMEb8B2O7YcCQKWCRH/Sl9J0SYXsKsnzfudAKP6LGnwHvf8crximdtMqZ6fsnE47H0/ZOfOAWjL0LLpWfEMDOpf7MXjfV/wt3UGX1Gaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by AMBPR04MB12287.eurprd04.prod.outlook.com
 (2603:10a6:20b:730::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 05:20:41 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 05:20:40 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] PCI: imx6: Fix i.MX95 PCIe PHY initialization sequence
Date: Tue, 12 May 2026 13:22:42 +0800
Message-Id: <20260512052244.49414-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0200.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::15) To GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12019:EE_|AMBPR04MB12287:EE_
X-MS-Office365-Filtering-Correlation-Id: 76428bcb-5f43-4d17-b53d-08deafe6354f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014|921020|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	jauqZuhCc6HfO1/fAUnt6DbYuBj8q+rmzzmZpX/ePiChbIAxnB762LoJsAcZyAGjm3wvO1v0oiixgiPH7G1K6aqyWMBBkSZjqpYdOpQDpRq5jL/Hfr/WoXqGozwoF/j32Ho39Dy9EfPlMYsYVpatI0nsk8J+GmjWR9mx7/pf2nV6N5HrNLfCAEwZhn/CwWnERKq58rbEfvVpry4rt3T8bLVTTCzhjoOlW0lTW64wl3VVABI8Obv5Bc3G3PveFNVtxHD0b5eyJZ3otCmfBsVqznCD+y7TrfSV644V4FM0Pb8arhOb9fTAQaOIgBfLwCm0AJw7YOXxcQPYlf/Gujq7rYRJSiiCS7o7LFMKLCQ7UkNOGe0gvRxtbV3YVb1aexUuu2mg4dlwbRg85anSFMdirBAdxcV2dewMO9NhNr9yYxF6Z/xGSHYvUp59OW+UCY7t2s4XBCnjj1GE66Px/232iRwGw8fT1M5727HqGFFBaR8jXFc7S4in7VCymhiluvIHxRevbi5LY2uQyoBLWTL0SdjfErAOj3KU7qrlPaqCyygEO4jgDBAdLVNhkwzXpw+MHe1AyDlJaHhZ/9zcale5D7K7Ox3LBUMM70PGjwE8T6mpjJpfCQ1mkpgJ8InY5jmC3Om1Vz0uvauYPqkwxaOMoYwyl6vdv055038NgO7lMv3N44wf1tgdRygqKiP8rW29tR+6eC8TqOGZi8O2cOnyEts9qohSUcwhsuXUdgLhsMK760bCWueRRjOEXTtecLznlsDUKi2mt7oZ52iyUUaWBw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014)(921020)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?785QrmwcpOomsy18atV/+y1bCKwyHvviRhMdiHuZad0/02c8n4Bfb5zGtQR+?=
 =?us-ascii?Q?BfSTHIFikWaYGAo7K8BhzrunX821mijIH9cHh/mad5uczpOpeuKn6LLd+lag?=
 =?us-ascii?Q?YBd8FAYzNhJUQosQHnDxH1ZoIP6/sSNZr/DBNpCv2RA07bWYt88+NaaBdCMq?=
 =?us-ascii?Q?EDvQDt/4sv6u99+0+Mxb7BtKpaHyACwT/usmsJNH0QmoTryCRHyPNscsRwmh?=
 =?us-ascii?Q?bIrkihl/PSVDBc9frwK0qrb+clpvn8hzb1M9aRNkJFfHzomvUIDzW/cJtdQp?=
 =?us-ascii?Q?etgrLkeLxrzsfP2RT3r/XZwy4anVhOyuQhzkGYbb+KzWGNsropZsAAAxOroG?=
 =?us-ascii?Q?QIqTWqIzSZbGuRGJkyS6ec9Azp7v+GlbvW1kzAcpZCV2X4lzGrOrv0DWRBWA?=
 =?us-ascii?Q?tWiV71l/dpOxa/h0XoKfczaAoXJyAS6JnXOedbF9g9rEtQfD0SndINBNtSGb?=
 =?us-ascii?Q?JxOk5wTWXEfJjPApKfkxkZ8az5RCwRUcVf0s1unUAaflKdrM30xOUuV9q0Fz?=
 =?us-ascii?Q?QDDuCDuIFadyVHCXk9ZBzgPvquS3dEdB0Xoz/nJ8NV2I9GzfVGsTCth13/cP?=
 =?us-ascii?Q?YtiVtw+S/J6efNvujaMrVKfChmf4inSQSe4mUNciIpg439IzVeLIyk6zF1fA?=
 =?us-ascii?Q?949xK65+pDA9e30qntVqQwtNuPEvjFf5hWjOWok8HIrjbxI9NuQCOt8sdpjw?=
 =?us-ascii?Q?TderYnBjKqj0PZTK1WOZT6CUdfDMfjxCGyjzyHrfsUtIG2t6ypusOd1eg4j6?=
 =?us-ascii?Q?qilMJEQXqs7CQcXpl+q7RHa0Eu5L7MLAS/SGIG2+gAS/3ElKzvNYA4MnYvi1?=
 =?us-ascii?Q?0KiUtgIX3MUh1QMbIl18FYlPv4u39mjGWzkbyNaLvWUQrdLfuawKXOgC/2oW?=
 =?us-ascii?Q?39XV9FI7+fewFLG13FpZcOJxWhnj89YCV9V3ZD72eY5wzE8Nv7RwInquutPP?=
 =?us-ascii?Q?+7QbK3Y8yn8qhNV/R8XwlloLzCyqgzfsv5E1WOOTtExtW7bVXg2yJIwWG+Lz?=
 =?us-ascii?Q?XG3uBz0fDy0CeIG2hkJM9fUN6UdYen3gECkptW6opRNdJe21DzsKqfD1VdCx?=
 =?us-ascii?Q?Bm1OGhH/Ibn8qwzgBVIjHnMAGkPHgt2ACHK0BvFIrWHd0IFJffMe9/nG5bD9?=
 =?us-ascii?Q?LRRN5b80/F3YfAhswSZ3nsx+oAOm2Ft/Sj9VPwKWPswMiLchFevVNxcbKzFZ?=
 =?us-ascii?Q?QKiAvYhj1vvuWHr+XSUKDN4q1SAoa03FmnbXyVuLx7sjsgUlmV9x/G0JXfwT?=
 =?us-ascii?Q?ZYdoyPqh7e7kOw+YpbUuI66Pf0t5TYlqWJ1LzROvqjBQTXpOvQVOU38zqE1w?=
 =?us-ascii?Q?S4Ayg40meCAtApr+8i3+dr4KDEm6CSMqug7upCows1WjmEbzd6h54tjPUA6I?=
 =?us-ascii?Q?2ACwa3RLZEi8q1BVfyJEOw4kh6GxgYa71B4FROrZSiazx7T+9DZdaTu2U4qO?=
 =?us-ascii?Q?TuJo+OfheGypiTi+Rzs3bUy2fFqke2/IDLwCPtQCqUp4WLP1kjWUjI3PLO+R?=
 =?us-ascii?Q?mb89/cUdmZBRwlFtDwfPpQRVry0kRUrZ7tmWFehTbObyqErVSjtJSUqOqUkG?=
 =?us-ascii?Q?9B/LnaIkMj9bIpSjecUaeTfSPj2wUd2rozOEKyKsu4wlRQDm6jLWZ3qZAnLZ?=
 =?us-ascii?Q?KarreILB3UQZGlibj//sKhgGfxh5mBkvs0pMT22moieNpfUicv6KToPDa3JW?=
 =?us-ascii?Q?6cyfDrKv+Tvym+ItB6O66T9EkCleX8JUeNlQbqMpyUdYRz11+ZrSyOVSi9Gm?=
 =?us-ascii?Q?BtwTyUnvBQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76428bcb-5f43-4d17-b53d-08deafe6354f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 05:20:40.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJX57lWzidXAXswRk6sg7HHijHPOeE+AzAkz/DGNCfzuveq76X/9oUCuwZDr/v+qCK+veWyfCQWzzyDlbAkSrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12287

This series addresses PHY initialization sequence issues for i.MX95 PCIe
that were identified through careful review of the i.MX95 PCIe PHY Databook.

The current implementation does not strictly follow the timing requirements
specified in the PHY documentation for reference clock configuration and
PHY reset sequencing. These violations can potentially lead to unreliable
PHY initialization.

Patch 1 ensures that the REF_USE_PAD configuration is applied before the
PHY reset is toggled, as required by the Common Block Signals specification.
Any change to ref_use_pad must be followed by a PHY reset assertion to take
effect properly.

Patch 2 corrects the ref_clk_en signal timing by moving its manipulation
into the reference clock enable function. This ensures the reference clock
is stable before ref_clk_en is asserted and before the PHY reset is
de-asserted, meeting the PHY's power sequencing requirements.

Together, these patches ensure proper PHY initialization sequence compliance
and improve the reliability of PCIe operation on i.MX95 platforms.

[PATCH v1 1/2] PCI: imx6: Configure REF_USE_PAD before PHY reset for
[PATCH v1 2/2] PCI: imx6: Assert ref_clk_en after reference clock

drivers/pci/controller/dwc/pci-imx6.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++--------------
1 file changed, 51 insertions(+), 14 deletions(-)

