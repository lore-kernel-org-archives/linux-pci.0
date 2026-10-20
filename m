Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465868;
	b=KP7SlRWsVs7sicXEAXvlI1Dw8jVUHDCSKTRwdDaKU/KHnbb1sRaHnOEqZ7vtOSDigggR
	 zyKvZAvU6HL/jUJl1TV888tbW7LVfMKjZ3O3+ZPohvo9KHz8xkWJ4nkpLmsJzoJTGrCoS
	 nDhgyS6/dyk0qCDdDoQZNPCrltrxt8224YPEvW6UhWvrs310zuXzGjXf+v3YAPStFWA+d
	 3smjOodJJ01Mz9MPoD9xzeb3XJeNIEXPikFeIR0678W1mStlz+PqK1RedCvfxqyjqSCpg
	 y/unvnXS8PBbSPexmxQnrpgN0aseIY5C/BfXEdvbz2MpvrmAptgW+gdtW0fA4F0a4nA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465868;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=dA9b6kd9HkZTqu+vCUSLxY5oQCF7Q+jA3nDwuTkyBT8=;
	b=1b4PLPRcWhyzizgRQInXVlV8no/2KyXoGeZaSgVB2+zsn5VelqrNjTciagI4wQF+SWOv
	 4bcO04CcVYwhf493lCe8mHfAn8BkZAd0paSHTK1+xlVXILBknudDeVcQQsTGu4TiLAgTf
	 RxjxOlh6rY1JHjsM524pFSU7hiEsngEwi1Y+9Yp3rc3cP5jxQtlRe3hBuDTeTyv7E3e0j
	 OCdL1sMPSmtdjUw8aOm2Q0c8W8NSgY5hH8MRQUYK9tfAD5y9oYpwA6tJKqSkMvkSXA9zy
	 XP1HeqGMl4YE+Tq0uBmQRLcBOhMvmXGHAA00nULE+IVnfyWUH5sc3/JDuK1mVPw1eLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=mhK5nPVQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F90606AF76;
	Tue, 20 Oct 2026 03:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0F90606AF76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=mhK5nPVQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPcshCggFPIsQm1tlO3zSzddBO1AKA1QZxfCchYyhN/9PyKZzu8yRikoZK8PmkvtENe2U4AmmHaUszceuD/Vx+SIpjvNB/VJzOu6wA/MSz92FfFphQD+F+k4I/hWkAvXv+6AXYqbQBS2GP32OlbkfO8ZezEAxwUqU8tskS13IvzT8Ewrhu2kgNypZ/ygV2cdRw3mPE9JV774fRo5Z/I1uiMe/6ZtxBZz3bCw+NEmqWpvSY2MInmL5gSbp06v+yvw851FPiKXN0t2gnm7yIJ0ssJdV3yMjajhJ4ze8ufIz9gKhnJu0mgBALl6bPoLsVoO5WCRcZx7yiAoY8Bm6zXv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dA9b6kd9HkZTqu+vCUSLxY5oQCF7Q+jA3nDwuTkyBT8=;
 b=TYCKlXxIKuVeUR3VxFjDk8JQcI8+ORDUxCR/fO/QWCHtKVTv7Pmr3uL6Q/h1+33ofWiApVsX0YBSFYLuaSl7opM30yAL/p/etbWXipbKNMGdrk/NSKVWWLWj1IVIQAX3V/+JnupiL5qZkIokB6mwXWA1COs4bXm+5T0qX7QckHqlTYdZcam3H5os7YGgnf7MHkO442RbAlcvDm6l8qqlzB/cEY90tcDzv+trKlAECmGHe1woHiIHUMOzIqA8jsB5EDtjfOXrEO26wvem2Iz4xBNZCjX8qBzmiEakU18RlFnd9ZBVJNge+Z1YUi61yzu5sH2Rz+jcRE1LuNl4Ul/hNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dA9b6kd9HkZTqu+vCUSLxY5oQCF7Q+jA3nDwuTkyBT8=;
 b=mhK5nPVQcvKZmLNF8Wv028SasUR+nVDWGgWaSdlGVdZOSP14+cNLbBjz6PGjlZJGqWDHGsAYsTFgwsob8UVXA2wIdizAOcomxiXIMo8zFcSteBdYIk1pZC5SghIafNyHEAdNlGyK7rV608MAtH0CMT50EQ1YGQENEA3rMBAZJgs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:04 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/17] PCI: rcar-gen4: Assert resets when Gen5 SoC PHY initialization fails
Date: Tue, 20 Oct 2026 12:10:39 +0900
Message-ID: <20261020031049.969895-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0100.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b1e1b8-3ed6-4b83-dd5b-08df2e57c6e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|6133799003|22082099003|18002099003|5023799004|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	v/CvFjpN/83Fx3m3sDfe3mwGcFSTPWjLuiIbZsriFQlXYNnzWKCHVfqN8I8EF/h9otolRwMP+W7F3bKho5bl12RupA0p2OMvAU4pyvb6z4frg1V9b/VihCGlCVk8jxWMYQbLVx1hkqAhqnnLzAQxtZkoY1vGm5J1cfthWJVJCusy+ybyIITDwwtKDX0FJBLiJbfon+GBGoS68L6VutGBEzrf93Hlsff/orxxuz73c3h7TFMFjc+zxDAYxzzP8ARVqelfctLtTOZkzhaAO3lgNZj5EkBD+2iq208kkklxUogdGEd+aS/lwt2n0rqh35ikZ0g9tQl14w24j5qw2laxUwquVOfthEuGN7mgLJu6VOxZpnOeGo0bhGFD+LlNHgUas19qSRFITH6gCjoOXTZLVD2qa7yf4yq3AZ0QrqOcDzXhkqXWYgQP45Zb2gU8JkIjge6i3A87sUkV956xEQTlaD3AuOyLtaUAALSaAzKzwhQkyRs3JxqPZdE1fkrMrlEHvtOpzTQ3Fl52uN/TU+kXIfSNCX2CrsQ829i3l2EVIZz7lSrSGi5AJfl5LplsCzsAAq8t6WnVPbZ9OUB9wk5+XiKNOgOw82F/qYjdIZdg2AUUpeEABxKdD/WANexRbfYbNoA7qVHcHm/dOvK9rTqdo+QynaYvzMiboFPZ7t/TwnFGbk/8/+FWpr1vxTTMRc5YyPlfbBbYISGvaW5OeitVcg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(6133799003)(22082099003)(18002099003)(5023799004)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XQTh8WLu13hqJkjL69UUaKU95Pc2aL7QRpIIBXzgzziliuZX1P9Wu6+BHksb?=
 =?us-ascii?Q?lLCyxpSxwG7U9a5vrlU+4aePJkcXwJ6ZHyRn2rOpTg+VFvrVcZilr7/v/NXb?=
 =?us-ascii?Q?PTZDG4Qgv+dEhUrgNEDZvSVUDIFfs9GtN8Bf7cGG+ycyKo1dnQy/WxPsR+lr?=
 =?us-ascii?Q?xVdyECp7t3N3vby34Z5dSoGNhuNkb36NRrI7ex8KnHdPpEo56dU+oDPh+4uE?=
 =?us-ascii?Q?9QWuWtLLS4exKYrHTuJK9iIdjtBZhuUaN776g0NF4p8paWmRH/h0CDlML7df?=
 =?us-ascii?Q?QO1AziXMBZgCP3Ch/6EZgeo8jgkxzdyaK8Py+FmaRBNV24ZhbN4ybGncQwFy?=
 =?us-ascii?Q?RI9W8/ScZ+HsKnlIc35ezfH/6ICKWS7TbIzFUCkIJSoyXKr1Y09Sbj/PY7kz?=
 =?us-ascii?Q?9XHnsixbczLi1Dj8TXflq1U1Ynj/GfW82FCzDa6icB2xXSdDkyNLmcbEgqv7?=
 =?us-ascii?Q?Ox0sPfjcg1AiyjCjTPryglcGaRlIRi4BHtHHGl0whT7N/YIDpZeX6bkaR1ur?=
 =?us-ascii?Q?V4w+xCmVg0IxyMeeZcQ4+xS4bK6YgSSlqN3IUHf1HouBc1iXzT+NTZnu5Mmh?=
 =?us-ascii?Q?8GkZ8Ss3y6WgQZ7cmlVBn2JC+37qf4dS6wyhYfyXs+NFNkAJLd9QW4stZlQ6?=
 =?us-ascii?Q?TlJbDenwxYviaa7sFfH3gB4R1hApICVsrWw6nsb/8Qu2L0QjS4ZLFqKZRxSB?=
 =?us-ascii?Q?Xkh8NI2FmLYR3J9LtKESwHMp3TLvREqFhKLy8S0tLiXsgNqHFHPaBCsjM3fT?=
 =?us-ascii?Q?YrGcrsaUOTaM7r81HhPFI3hXku1UESgCSA9j5+xBg6flud+2qA023IzFO8CO?=
 =?us-ascii?Q?D8vu71IPoLOJNoOujy//oUOAgCX0HkLhhq48JA5BgyGpYVOSwAx5X4uXznAF?=
 =?us-ascii?Q?J4/0yrZLHlv2M741gTVQ359fszILE+G5Eli++00SRZvOi3/4UqAxITRmdtNK?=
 =?us-ascii?Q?EmWJ+Y9x3Q/tmsm2JvnWyc+JYuEmSwkb/aYDZzhltunNB9M5hOJQy+OfZNZs?=
 =?us-ascii?Q?YsDqkSKBlfFldRq4kBravFlgEhuGDdkFgML8HhFrQqlx7Kju3VkvMYucFEM9?=
 =?us-ascii?Q?OMYHfsllhbkZ+m9u/aTNo5UdqicYINBBgRS5VHekxcFVX1nxhkQh7CIYN1bh?=
 =?us-ascii?Q?2Vh79dXwww2EPNE7J8wvZLMOC1E/NW1vyFXZpaavZNDJl8WL86kadfgomYPB?=
 =?us-ascii?Q?LrtzfKYQQf3tWZSTs34cu424Pa5OPH2WVGwvQ95V02qAo4o0x1NLtrYF8GE1?=
 =?us-ascii?Q?DOBCUH6dOu8G35/2pSHEH3XXVE5IB19H34lqMz+PyHTOSlrdZOElcf0mceRL?=
 =?us-ascii?Q?l1QGGZbr9DKjmeJnlgFipvrF6HgYi55bhLk3eZMbcheObC0w5PtHf7RJCMcv?=
 =?us-ascii?Q?RxlNI27NaaNpBagyqvRDBGUfrpZMcisUwS+HeoFoLLv9AXcgQt1ppX6flkUi?=
 =?us-ascii?Q?wsPlL9Z6h9GOhLtfNwSHqdFXJcprgmcR2dbi9nsgA1Q9MEeIdQBr587sj7C+?=
 =?us-ascii?Q?q8LKe7pDWq8CSOMp2u4KR/4QHlTE1ItEWiW2qoH1p3kGcqxbZwHI63TkeTyL?=
 =?us-ascii?Q?9zDDMIQR8XYHXXdEyeDdYIQe7EKBCh1XxX/xH7kYjNyHKqutotgF5OnNXYdb?=
 =?us-ascii?Q?SfZiZcXwxpq1avWi1lh+iesZHcWTzvWFA3nD5+wIV617Qe8rl99pWJnFkqho?=
 =?us-ascii?Q?sAZpzD7ZWBwn+mWMOV+5cqNSsjzqPqvUhbVfM59WgQ53cnQwnFxahDwAy3MV?=
 =?us-ascii?Q?Xz7dmZuaq6/RmIZEsQ1ec2ZE9hd/X2bFZgyH/H7PfEyezicERGFn?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b1e1b8-3ed6-4b83-dd5b-08df2e57c6e7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:04.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKaRApEEw2JmBCtqG7cbiqVYH23Rz8Fs6w6RVD6gn7mO28QEQLmvU3ZU1524enD99PKfNbDHwkESxSse82qOpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

common_init() enables the clocks and deasserts the power and
Application/Local resets before phy_init(). If phy_init() fails, the
error path only disables the clocks, leaving those resets deasserted.

Assert both resets before disabling the clocks to unwind the completed
common initialization.

Fixes: 3283c4db6009 ("PCI: rcar-gen4: Add support for R-Car X5H PCIe4")
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 0a845b67f6c1..e1b748a9d58b 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -379,7 +379,7 @@ static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
 	return 0;
 
 err_unprepare:
-	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
+	rcar_gen4_pcie_common_deinit(rcar);
 
 	return ret;
 }
-- 
2.54.0

