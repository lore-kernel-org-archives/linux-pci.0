Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010025.outbound.protection.outlook.com [52.101.229.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE384A840A;
	Thu,  3 Sep 2026 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442428; cv=fail; b=iXk4UvjUwG4pQww+1dIDmsfUVnqtJm391gyJzUgF5xlOd2egDWmSBwDMGOOVQF+skHod9/4tvgrLt8nwE0ZERSugZJ4lSY8o4NSCWeAnNF9eviRnkK0300NH08HpBLkAomWNTHqXYJ5Y5O2zKz6wi2SqGpSEj0U+IDmUGxrCCDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442428; c=relaxed/simple;
	bh=vsF1jogdoBJtrG+WOCneatp4jCnTQUZyuuBRekloMZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JOmGjpA3kHswW9MZaTyW1ofQJLd/Y0WAXN7MCMrMcHUQOQk+MQPtsA/9uMxYstVDi03Tga8l31jyncajbcouDQk48gS05/am3a/UVNE84iwFVLQuCvwE4kI3zRgqec+2oJ7cWxDe3Sntr2YHljhUByG3y8qjWWiWPwnJhAN/hIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=inm7J9Y3; arc=fail smtp.client-ip=52.101.229.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="inm7J9Y3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQUoARqXORtJiEHYWqO91XjUS3KXKt3A+/1sFpBFISdSGl7zU0xr306Bpww6riq31ssdw6/B+4ftu22x/SH9d3NqKuY09kuLA6CbfohR2htvMD3zWgcxX92pn0OkHoy3T7CVRE0onE+uIEm/QQ0R6Cd72a+42GXgG+rCmaENm2eJ5+sehU5sQndkAJSHlFkZJTxeK2YflwNylcip+0Oyq+4x4RxXnc3N/iBE3irKK0+dzEVlzCcsl1p1Bs0drfraRESUfcLAP6SfwqgCKBIcNfJEgFAhLWxpIwNKmOZYyXLrQDUz3JetT77oKcH8Byl/go+eRfRTK0eChBBRQqCKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0tqpWbY/OA0pQKHAzxexGkAm7BqXfEd0pnPWRol/XM=;
 b=TuRRKfbag6CnrjTSQbC8CQlZqjZaOkKnScXQbc04KMt7xzF0z5vKcYDmW/03xBuqgqM5u5JOhkgp9ieWEOYlBGuqnhKkJuhz7NalAasydTwbDChAU9NFw9D7Wd4MFl1XfFIzCh6UF/Mhi9E7sl9HrMROlbKsjA8z32ZOfoqs1vq/wWijf812IwQGhZw8WAxlJyXKexY/Teg20xEMsnUHUyfDn9TRx3TWZqb0rpiBYsOuacUirpthGHjLjE8QCcxKpaChs+D0zSD5Peo8CrO55omkpGvxyLsIg8L3U2Pe3TectvsMLNr1CYBLJYhWThjod427VatZSigY9CLeomzQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0tqpWbY/OA0pQKHAzxexGkAm7BqXfEd0pnPWRol/XM=;
 b=inm7J9Y3wndzNrT4IhvmzDbLaAvZl2noJ4yTr0ACIgpN7wdeHLy2FsbBZN8DaNd3Vn80zle7SRN5zPl7Yu6l/7Zf8wt+P9b+ghaMEn1OhzpuqfUfEc6NvDltuASHrVsnF+5tvDs1wfdapBQPfcHFVzZftIk5uBi1c/lDOT+xFqM=
Received: from OS0PR01CA0193.jpnprd01.prod.outlook.com (2603:1096:604:1c5::12)
 by OSCPR01MB15908.jpnprd01.prod.outlook.com (2603:1096:604:3f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:33:35 +0000
Received: from OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1c5:cafe::6f) by OS0PR01CA0193.outlook.office365.com
 (2603:1096:604:1c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 13:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D216.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 13:33:35 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.93.2])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 8FAA8300020C;
	Thu,  3 Sep 2026 22:33:25 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/2] Add RZ/G3L PCIe support
Date: Thu,  3 Sep 2026 14:33:09 +0100
Message-ID: <20260903133320.144245-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D216:EE_|OSCPR01MB15908:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0e8f7610-87b9-4bbf-59ba-08df09bff460
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|7416014|376014|13003099007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	0psAhT4Cb0qVLW3yZSUSxpBNqP8pBoqmCjWVOzKQoyGYgsMOae1QSSrV80Oz4iUtR3t6oxRGrFjMmu4uAzWB/rdccNAlUBYUvH0YAnL6juKOwE0W/Iau6A91RzaSgRZn3y0jgQmaY/yh/c/9ahc1DhSvT7u4F3bI/WiiuTrlXXAs/060SXfEKOsi99z8mMaRP9/w0L2U3c+F2BzwfOAq16iqJqct4fX8p3e8NG2Lza6SD3WQAfV38D1l6br92JzNbC2MX73OQOY/c6Y0AJx3HFg7s/mvEjoYkZatf5prC5OE5OXnhssuZ4xDwGlsu+QJUbLM6jLobfuJ+8M5XHuxuH6Jp4sqdOYmNdBnKSsknRhRC5urpiTtCY445P/P9Mg0y00l+QfewxlODpG43J/QsX85WlLAS06FmBs0NWvajzss0AAQm3kgmLWJqs1MGRLgbt63qNXo4/aD7wvWWg628GFl8xWHy+KBbDLoOh6nDkCiyQ6ukFgzfgwiusW0J5+paxPQu0rOOSFiv1gMA4WZ21BxJz2xxmZtzFavoOgC5byIpIpFgru2VzEIfuaaWg0el/7e6KCChoNZN0yVBquGscABSCQQFHx0zE314aVLyCm+pVcW76u9hWQwX+6PfsnBrOmWbGQ3p1uHAJXs0AsNxL4njKa+xYTJPsJmt2/XXjDl/6XKTvBhqDhUxXEbLDdTLQWEQyne8+eESJodSQULAA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(7416014)(376014)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dqVih+avli8xLD6mpIjLmmOHg/5X/FVzj9e2YZu12pa+KQB1lSD6NQNRm0fl1FYotyd8QqSDwIKsWj+zj+6BSS/Xl8PppJj+7+DBDjWbzspasyqAb4Ah9ooXPA7sqnWjs8G6MGt9gwtocdyRCljKvVVK9EMKj82K7AH3YFiedY89BuKmSjWIQMKCpsUeFm0LmGmB3CjtmszVyrxuWbnl+SBbDaW+qvWyYDNg6XXYCUWlmhG+323b7CWjQlJY1IVSpVPRbMbMsfiIl8qj4dXrhMWIRQPFAk8iR7Qhq8D8Tzmlf1sBQ490qXY96CaJQJ7aucQzajRpjWm29X6E+5FhZyLWPlsgYnh3bmJfo6fqjCbpqJAV+0AHJ52nTDsR4xMNuklwfPouKtVkLnDIzeoCVV326iMsDHzBDr/ad5oHcOZEbCGodMmw/G9SOjrohl4B
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:33:35.2622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8f7610-87b9-4bbf-59ba-08df09bff460
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15908

Hi All,

The RZ/G3L PCIe controller is similar to RZ/G3S but has
some key differences:
     - Has 3 clocks compared to 2 on other SoCs.
     - Has a different set of reset signals
Add support for RZ/G3L PCIe.

Patch 2 apply on top of [1] and [2]

v1->v2:
 * Dropped "or clock for L1 substate handling" from the description of pmu
   clock
 * Replaced enum->const for pmu clock
 * Collected the tag
 * Dropped clk patch as it is accepted
 * Dropped DTS patches as it is pending acceptance of the binding patch.

[1] https://lore.kernel.org/all/20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[2] https://lore.kernel.org/linux-renesas-soc/20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev/

Biju Das (2):
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3L SoC
  PCI: rzg3s-host: Add support for RZ/G3L SoC

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 33 ++++++++++++++++++-
 drivers/pci/controller/pcie-rzg3s-host.c      | 25 +++++++++++++-
 2 files changed, 56 insertions(+), 2 deletions(-)

-- 
2.43.0

