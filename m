Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010051.outbound.protection.outlook.com [52.101.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4AB30E85C;
	Thu, 30 Apr 2026 05:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525681; cv=fail; b=PIiR/MjffRCOvenuZs8fC2OzBxXejoJUbOxL0+GDJKMDtgWWjvVtqjKHRa9+yzBPyEXtOPGt7qECcM/tBXjJPaC+eud25tNQkOrJx3ld91zpKw7y8ckmSc64VnhubnO5FCEuWYz3uXzhPz+3O7UUvFxNEuseCPaL48x1J6jWJgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525681; c=relaxed/simple;
	bh=UkIukgU2kSbPs7y0nzjUkepJbXgFELmNizzbMG/McW0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pJSGjuEPWMAnbS6TBR4NrEaxobKOw46yOHhEDw9fIPUnZrr0nQ4R7p91aonlTBs9pHyq4Qm58o1tEXCJ/4odLh6EyQ/ItWWUQoVNiuF4tDMVr/axwhj7UFmlIBj0YItmbfpWCcq0nEug1/Z3QoNBXm9ds9Cvf0TCEFdCtRhrGFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dy3P5ttM; arc=fail smtp.client-ip=52.101.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dy3P5ttM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIsXTYcbBfOmuDXQuFGHOvDk/KMa8+3lGDv6a+FqEkT+gCt1oKeIHr/gdGo9fOzBCxLSfX0xztkOpLXBrjMM4mKgDDqYN0LbssDEwOeusJmOXBOhfsqo9NsmSr3lgKEh+1mFbwHh8c7iexNVngcmSmCro869z06H1Ffb4iAvY2Fsg2onR8/22ypyIO139p831Z51lvGaPy4nID25kEHwheitctjtbAwr7Y95isLm+HDaTtVMRh9OiXeGb0Dql3WFyH4qhxWrOsS4NgcecqkHcg8LCmG+GhqPMZUQ1t6/HNKUObE4CC07CymqYIdgzkI+y+mjuPJSNXCD4+F+cH/uGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rztiqkAf1svYyDkRrboTlBH+jzVuqA5lBU6NuUQaqaw=;
 b=EdtmrXq6slasoGuQpgH/zgN3HIAAJDLxbikTCFohOqEXhNOLnq8fc26KvdJ6Bswfl2qnkR0jw0kKNp805wCN1L4teMzIx/LaH2c+wzJ7/pQlTLE8WvUuhkRywR+QDCOQRXEM3WGIaZNCZQ/WjChj+SoONUSY0erZzna9HxlI7B/R7Qdt7YlEeLaTucKsuT8EQmuYSekVbsxntKQb/pNUHuzZTfxT1y3k+I9Z9guyqvVK7U5tEuo0B2G5ivD91SbJ83Y8qPJoKOWN+3VZotvEA4nHr+4SIVhqx2GKkwOPKkskq74Y+4fZseVZKoigAVeKIuBaNi2ZwJDQSBAdEdHCfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rztiqkAf1svYyDkRrboTlBH+jzVuqA5lBU6NuUQaqaw=;
 b=Dy3P5ttMGyLCYhoXK2x6sLvmQPTcnFSxb/ghEAAR/gYb5Qxnboqfuutz1BO1wEqSbEyEMSh4OETryrIsOFRSV8RBnhO2oqz3LUIeYrRY/0V/OQITx5woc0UpOzLqJqKpV/kI9jTRb9OVBIf2ypwGG6usFbxY6dSyJ+NEIqzqOzbXk8E0PtbWLcT6xpFmhHHXmHgtMtL1ERF8lVxFaWO25TfrW8DE6fiGneroqDAaVuTlgyXE9kp/ybgfKh6jcLrFkLlYH//uuy+ka43vZqNJ/ALKenzP/q1heOTH6n+PD1C3Ak4xUIthEapylJFfd77jauGA7VRQsLpHKBxCPqmkDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
 by GV1PR04MB10108.eurprd04.prod.outlook.com (2603:10a6:150:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 05:07:53 +0000
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5]) by AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 05:07:53 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Add root port reset to support link recovery
Date: Thu, 30 Apr 2026 13:09:51 +0800
Message-Id: <20260430050954.3467984-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5220:EE_|GV1PR04MB10108:EE_
X-MS-Office365-Filtering-Correlation-Id: de607005-aee9-4661-9da6-08dea6766ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|38350700014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sMMYXfRcoo1z+wLmoXtaUjsIsp6ZJ+grk2JHhu1MYA3049Tfp6LColyE755SAkLDCogE5kl0SFk8tr6cXaZhrDxzahss5eGhrzWVNQbDWfuz6zAN3xFlotdjoohNmbUbgpj0oPIUglj0Tsk/5ARuRJiOZLZOFsfsFwSphxpYZaWSlaDiAaor0No8eWaPRxxGdZjwz+32O2Y0pDJpkWlF8Hyq0Lj8NtYPOkVjuLU8vc1rQr9z/3NHbmsf6yhbGi1dgnlW+pwd7Z2t7qOwQ3HmoMNvHq+8AKe80CyFZQFddwjamKDxh1AbgTaIqw0XqfckS78PQ4BQvRn6CZB80U4/YWNLBBoayId+4mDRZzU49nYYcPQ4hn2gDOSi18kNJB7wb+0rXUi/+2teDFapZhy/eXIukd7S/+W5w8umBt31jWZrxy7CVE9G4MFo/Y7DLv+qscmZq6b9XQ01Mw4M18TCPD6G2r97qVvkh2cHp2vxxWr1gpw29pQgy7mo2L4DF/JshzWB59uzriuOAJu/m9crsEDGElaqOvpiX79Jr8phGalfFicBsu2aVPmYwqZ7IZXDaSdCIzwZe2+bYRaNz2C41nSEay52pX9Z0VXwHGXJHxFTPng7iMPZ2JeCGgQmI9GvV6RKHeS911k3z99ERt1SRVZI2uHWrZDiA2/OpK+hKhJp2WSUBJfNHkaNmdeghQjn2W97Pa41IJXxOHipAspy2CfK4Dkk9n4Iz/YOmHz3nHm5SeQ/NDCy/sNY/EHxhpWTI9aOl+d2cyf2dippF5An88Kxcx5Od29Uf3NlFbg+O9Di8bql/fofAaIy9wVMsJkW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5220.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(38350700014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jsuk1vwXobTidbojOWi5BDpVsw9d7jaVFUkVq6cap5XKu6oijrfKcZJQZzWR?=
 =?us-ascii?Q?QV12agFWV7eNfFiR6J5QXgwa9B4RkWiT8l0FPVsYCkraNsyz6W8SVs9fnEdT?=
 =?us-ascii?Q?xbLVtXNUG3HLKDnlIWKt5o0uyiqUCtdh71g3xc99YxBElFEm44t6zI+ptXxU?=
 =?us-ascii?Q?7E0FveJLIHznV/s44eY8piMcsc9p+1yBJnKF0ljCLCU/sO4B0llV7zSDkIEB?=
 =?us-ascii?Q?LSq78/jhQ51G4kkWGTSkCSFs7wECBWXulddr7YHtWalTmwtwgUMOiRlHhui2?=
 =?us-ascii?Q?KJDmvFtfSRSOP50V+pwk5y9s0los4nHrQ4mCvEIgrQa3HJHARXQAnZRQGZhW?=
 =?us-ascii?Q?VWdEj7VfLMK5XAeGvgCfGC5FGlqungpm8NEBc2jKmgBF0rOYpWEcrclfQ7S6?=
 =?us-ascii?Q?LYvcgPGiI7flHW/9HK2cINZM3kFcTqqEQT3b5zNgFcqDZjyv39uqYm4GiC6e?=
 =?us-ascii?Q?8rVYyvARzsgRZ9/2lPiGWTme2HxUGZYqRgrXD3LzMAAh75D8XP7N24KIGqLm?=
 =?us-ascii?Q?bwa68GY19ltzSCahsHoQMwfcF2K9flPaEjQ3PVOJmFRjSXLmgadMYsiAqQQ+?=
 =?us-ascii?Q?FTKBuZVmvfgBtCZ8mDi0bdGnFCPcjw+6UjTenGKycq4Oqwxah+M9gBI+F1QG?=
 =?us-ascii?Q?HBwN8bU9jXKfOLlQy/gHYXuqeTxaWDJ7P14/XFbmNSz5N8peocpPD6laQ9wO?=
 =?us-ascii?Q?u/gcMJVwsZNTvvXRbom53949w+3CxcBOTpPdcRF9WUTZFH4Yvr3G1Gap2qep?=
 =?us-ascii?Q?wEgNTmKmqg3ZkIVBj8vI0kPxHJPuIQ+aFw2HKvaEyWPS2fts0+TJ/3UFSzZT?=
 =?us-ascii?Q?wQALXABctEESKqQuo/q2PWuyc9U2qtl13VABixu9SjU8wISQ2/9GCyK/Gv71?=
 =?us-ascii?Q?jomWJ3v1EDWJ8Cs+ar6yNHg3mOFo3tH/wlTEJwXSVm7WfFg95nIuZhep24fP?=
 =?us-ascii?Q?8ZPBA/nya4sLBH0legmkjozgRibvBaHGPNvqgvH0DCNB2TPtvEmJCErCA7cy?=
 =?us-ascii?Q?TMSPKVnTCPww9/CI/doTnicupgxSwdJwT8OvafZOJ0/KaVfNa94gr06AfVyv?=
 =?us-ascii?Q?t9mUDOaVJir4JMD727X9RhuYYk5MagnNbClEOpeF/O82BPIfNJw0rpPiZs2g?=
 =?us-ascii?Q?+D2N84iC+p8zz8jFiAHTRr9sHp0MHTeNedERXw4DSvfRYiU2qEKvYm79VIrj?=
 =?us-ascii?Q?lIA/hbkg7U1/cE03P5OMM0luUQHl6eonOzr5dozs6BIaWXV/g8aYGG6HWtCz?=
 =?us-ascii?Q?vuFVyKgmn+iJ/Hedt7Ee65h+JmHeTODo+xvugWjrA4sal45CqqwY05kkRmud?=
 =?us-ascii?Q?R8G59p6RTzQO0W/YYzk8lvk5+gsFL0G1RZXxkuyS8V2CpRf01mvAylLrf0t6?=
 =?us-ascii?Q?wMr8yboYO04roSobvkcOFuN8ua/j1LoOtC63J8cd4phNbICfd+LCT00b5v0/?=
 =?us-ascii?Q?WaVKHoNF28P17mQDR5rX0be1pljNMlzQg/TYUJGTODvYOmU+EaXVUOgNUdzq?=
 =?us-ascii?Q?9Wl5Z8rMEpDxvIyQ6gFDJYQfhz1rhtOCE1rS37pEsxxRrW3JqRgr8KsqA3rq?=
 =?us-ascii?Q?QDPskzeWg6c3LQVmvaiXTtSuRAj+V5mmVMK8jnx59/+YfTfF5wksCkGK0cE2?=
 =?us-ascii?Q?as8u1mAhShG43VxmoOLGUCP2yTE6Ui3/Ol18jRWZrYiN4NGaZ9f1qAVwmCpL?=
 =?us-ascii?Q?RJGaTn9M6Eb7FF+FUNP7/muBPrrRsQ6g8dwi8WQi7xDkzRW+tSpEQsiGparS?=
 =?us-ascii?Q?avIgz2/IPQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de607005-aee9-4661-9da6-08dea6766ee0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5220.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 05:07:53.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UgfMi6yIYxDBOUQHCKX8Aijyg+7YgVJSTpsSgADuAEdvBSWUzotS1V+RGUKY5FDnqy6Zjz6UbaYiNcwce9vjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10108

Based on the following patch-set[1] issued by Mani.
Add support for resetting the Root Port for i.MX PCIe to enable link recovery.

[1] [v7,0/4] PCI: Add support for resetting the Root Ports in a platform specific way

PCIe links can go down due to various unexpected circumstances. This patch series
adds root port reset support for link recovery on i.MX PCIe controllers when the
optional "intr" interrupt is present.

When a link down event is detected, the root port reset uninitializes and
reinitializes the PCIe controller, then restarts the PCIe link.

On i.MX95 platforms, link events and PME share the same interrupt line.
Link event interrupts cannot use only an IRQ thread handler because the PME
driver uses request_irq() to bind the PME interrupt directly with only the
IRQF_SHARED flag set.

To address this, we register one handler with IRQF_SHARED for link event
interrupts and manipulate the enable bits of link events to ensure the same
interrupt source is triggered only once at a time.

Additionally, this series adds 'intr', 'aer', and 'pme' interrupt entries to
the i.MX6Q PCIe binding to support PCIe event-based interrupts for general
controller events, Advanced Error Reporting, and Power Management Events
respectively.

Changes in v3:
- Don't add a new if:block; Drop the maxItems constraint of the interrupts
  property for i.MX95 PCIe.
- Add constraints for the interrupts property for other variants.
- Regarding the ABI break: add descriptions explaining why these new
  interrupts are mandatory and required by i.MX95 PCIe.

Changes in v2:
- Constrain the new added three interrupt entries to be valid only for the
  i.MX95 variant using conditional schemas

[PATCH v3 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and pme
[PATCH v3 2/3] arm64: dts: imx95: Add dma, intr, aer and pme
[PATCH v3 3/3] PCI: imx6: Add root port reset to support link

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml |  30 ++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx95.dtsi                  |  16 +++++++++---
drivers/pci/controller/dwc/pci-imx6.c                     | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
3 files changed, 165 insertions(+), 4 deletions(-)

