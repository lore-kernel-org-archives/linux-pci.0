Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B40391E7E;
	Wed,  3 Jun 2026 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467740; cv=fail; b=NJ6y2d9CVPxCVlE/verWcKiO9IoROJcY9P1OfeUuGRw5FTzpG8oxfChsniWfiq+B/pkIN/nERQ+jIRYc6esF1iFoVOjJNjE5ekLf2nlAkNF6asH40vjzfsfyZRrOpiCs5ZNOOYouFFoICK+mtT/2j9gx8Jzi3gQg+/8AkeQ/RTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467740; c=relaxed/simple;
	bh=UUX2AQZoqVvr1kJajfr3XtLK1VVRhO9glx3O3OQzoiw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OWajlEW9FtiLfgn+QP0tgY5TpRuExYBKIIRBj9O4VmZUvz8cxJsxFqeX1NFmqCkY/WEu/3uUlb2g/8AjiCr7VyZFJ6w/S706fnLCnTJSCCHP5N7z53hAIs3e0hDXTIY9CP7MXMl/EmVO96dLRtP3ONLKqtUvHh954L5lVwIw258=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Q+X5c+ot; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Q+X5c+ot"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITelHt/Dlactkc2VocHAvDt/R//z2rbNRsIrJgy7iGWeS+SAFZBWeOzTNAIyAVgxo4kSHQDKcyv9ONYTVrA6pVRsi1N1mrnT7lzuLImlikdmxROpbwEsbK/7EjDqK8xiGQrJhE06puJaKS9eWPKG40ehCZ9WdPk8MIQago3R/xRMHhifad7vHUS2qhdmK/cLKzJUzod1OT3YXXEDf8RNOflnxqE6PmvAvscR/vagyErg0vOyqxiMKELusOy/sezBJbMR/prOal7n0Lv6kJ8AE8pbjriICUXFHasCkfDMYWSyUZPhTQ78LVtXq9TI3trPYpSuLybVJzVDGVdjMx6SvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNrz8O+DKJMeDpCP0o5zRwZfo8TFuydf8s9R099zxUE=;
 b=Y8Tgx2lDJrrtYwoPi9VXHJ1rbLWWnk+H8V3GT8FZEKkI0ZP6xxo9iIRKrNRh/GRloxB1PwqkQV9IMANJeP2oaUu63gQgwGxqhMHBt+8WG2axhSLSCdShGbHv8a5nvAylcFrsgdc4CaZCPySLWzkZIyV5GrQnxTJHfn8KTiPdVrwUCrR6jxNbVicHLknG9ALAqJHOdJzv3vrd5wLEZbVaV6mZrpItQ6DmEjMqtBD4tqtzB/sHwjyvPNCXnFXB4u/irewo75qnAKYosWYVlF4jBpfqdt1aJYx4XBFEqXbEK1eo0Y3BBd8GrKJdLxXLovf1HpmoEgk90ZuypQdEKOunxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNrz8O+DKJMeDpCP0o5zRwZfo8TFuydf8s9R099zxUE=;
 b=Q+X5c+ot718HGPJ8NelEe9fqVKygJLJuT9PyXNWhfBR9vVdVS8mcJKABbFZNaCo/EWHA61Kvsn+3Utbk+cJdzxbaALp7dfahjq872HtffVTe6DCLqRyV6JCE3Bp4VtivfN0Kbysz/vBdZ5x5+0fv0K+1FZNtfvUorD1j1oSVFryOkYWp8NtJLas8FT5dLy01ncygdh5NVy2VqBTMyQz32Ri2qoVm/r2YppK9gkYq+aro12GazKnU988nPj0hmz+sCjc+Haey+nXbWUWBBSwNdT8Ddc01Fv7mWKCk4A6A7iw2aQTptzrOg64lTNm6z1xcuRD4enaLPLF8fFqaz9d4aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by PA2PR04MB10311.eurprd04.prod.outlook.com (2603:10a6:102:413::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:22:16 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:22:16 +0000
From: hongxing.zhu@oss.nxp.com
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
Subject: [PATCH v6 0/3] Add root port reset to support link recovery
Date: Wed,  3 Jun 2026 14:25:07 +0800
Message-Id: <20260603062510.3767610-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0316.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::13) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|PA2PR04MB10311:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd361d6-f349-4bd3-5e38-08dec13874f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|921020|6133799003|3023799007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	E+BagWV7SH3iGSyaPjgtbOxYNbRsWu5+2VEqb3sjJCsL4PRQlf1z5yfsTJe9ZmvbFldizpYBFmZ8yeM2T0vtUyrwRbAjzoIWfGEnLB/7OoVvt9XxJXRj1nzppxSAR25sPqOqrcJDTBF/S2HefdYKJkUoMJz8kZB8czrBRrWhfa9z/LBnyVqlX2haqQ76oeBLzibvjEle5pq0h+AgpJGwNhgndJ19qcRDXkSr1xqoBhKlP/uXizVHSwngcC7M8fmTatvb5J+jCOuJTcPRs3hYabmQaeTfwoKhy/y8ik7OGC2J0NjBS4K/FF9S68w3/JAPRg95fK/LNaUUhQQ7VkAvTGtAFD+vLbI/4G14Zfb829l5w4PI8kY+U5yjptAoqEWhDa5aWaVKTI5vB0Gpg+746GJ7FNHrm2/JciXlNMCSRobAQaoVnDpjcFSQZDZTlaFQ/IE2R2VA9mX2pOdZDIgJ9mK2dBA6bFlYWWmVfMp/3FAHOWh/u8OxdYvuXNOlV8nP9LbVaACfbEYRoS3wCXCJ/goKkCBRB34CIQ1FWrqr9uu8rbEdumNhNJJ55oFIkyFmn0h4rX8eH6pxG0nQ+yVQ1hvdqWRN3tVWLhU/lEEHbHAU+ZV3GQ5l39iEqXIzToIxqeCRdYF91QuUJ+u7BVmUEKbGHEdhpusFH+eEeH0GPKcffBtRLaxPdB/3rnjsQ4CF77GWeF2LuHmGBAZ7x/CrrzKz5QujS0uGzjN8o507uOo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(921020)(6133799003)(3023799007)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5wQcCk5TQImVR3fVX013DbVnqrr9r0cWQYnZkEnhKy5DJbXnl1rhYqTMMODt?=
 =?us-ascii?Q?Z0KHC2+Ok4QlrcQ4Hl8SMQDSDVBG1Q9qL4Ve7sBqrFQIcZtCcPKlrukzsowq?=
 =?us-ascii?Q?hwKs2zrx+gi3WoDgeGBZTy+rwDXv8r71elEPm8lUzei1/PxmtyOYWB3SUBOb?=
 =?us-ascii?Q?JBaqRWAlgcliOpFVvGu6RIaFSVGxX9P+oG7DJlYOqhJ84RFsB7qwMGMiq02C?=
 =?us-ascii?Q?FLePzxRhrc6b8PyHQt44RCLAqML9AYBzcX6dfPL67SKahncXiMoa1Y0vZVS7?=
 =?us-ascii?Q?i95x0NX8PiVzoGQWvz/GAusSl53DxfwTpApi7j7wiKB7zEMWJ7EZCJEkUhF+?=
 =?us-ascii?Q?wAY05QtI3Ml9vRSbRj5MpxgxfHx2/OHtRVLTIdF4/XJ9gOtHPbzjX+/IjL5Z?=
 =?us-ascii?Q?v6p2dEfrQz84ue4lS9x4wlOZCceUBTHJ/2a9Qfuv0FbJNlfHx9YXQPkoYrhc?=
 =?us-ascii?Q?fhj/anCfgNroO5lVTf6lH5fIyzZiX6CxRPTQhcFAbfAWq2Ti91g7O3+HfSd2?=
 =?us-ascii?Q?iP6OqzwImI16AZjLUZlxVXXsmd3DH5EYqwehkyiR+VsWr+TYPjqjp43aOCta?=
 =?us-ascii?Q?MPMEQyL1M567M9wri0NvRLkwV52PT5nXjl8IM+v/Hwvpl6Rca0qmY0sUZ66w?=
 =?us-ascii?Q?A/pffi7cy6FvvrHJ23FnhfwvXNpTUEGqIya/IeNUc0Hs5OERiVlgBK2/bPFs?=
 =?us-ascii?Q?16ifH1DcAO0K+mZ/SRxfdRCEvlo7Kq+4vKV2k8fufgYrzQAWeiC2K20rliDR?=
 =?us-ascii?Q?fhpe+yfl0zHeJY5VWEgICsivA1J1YeJnuUKgFSQFN11y40r473Ig9Zu30S26?=
 =?us-ascii?Q?Vd+ssK96W4mfLTdqvjJpMOt7fhFPq7nZxp1jkhovwxJp5Vy3VIXNXEIaX5cX?=
 =?us-ascii?Q?cV//+XteVAemRGN3ldVgG3q5FblWdMypq9ll5qV1KwbJMDERxgTWbEhlZkqR?=
 =?us-ascii?Q?dJqNVu8qmWczvDqXWKsN+JVzpLACDze7ZQE1wjn15YmI8ybbn5ZXEfQbDOO+?=
 =?us-ascii?Q?leSo0MrQHIwdP7PgPZYgJvPplyYtEpQM0ohLuuOIZAOEKWewOpAoXuNXgOIO?=
 =?us-ascii?Q?WzkwfKs9DtnPYhLzDp4Fy9Ws5PKtjn2j6KS3cpQzbcznP79eBqDjbYVcB5a4?=
 =?us-ascii?Q?a5K0YtetqOVErRsIDvV/sOAaNITHAbCb8O41YWze83H72RPU07OcFVW6ox/d?=
 =?us-ascii?Q?624MtiOqEoVA3yAv+tbmKiD+0GJ2Qo6oN2l4jV7T4x4iclt90nipC4PYBXnx?=
 =?us-ascii?Q?tVF2bxgdnKHE6mfOu7vfRBusf7F3xaTmvPbvB6p64fAYmKE+A4nzp17mxpxa?=
 =?us-ascii?Q?2GRWd5+OWsQXHzws3NkBr/dqHiwgJbOECig1mrcV8gRwS1u5qSdhSkHfaDmH?=
 =?us-ascii?Q?DLNDiBPLc1zTnBxWXfB1ps/0qQr7hocwP+iz4Pa9xFGFyzZKesj9Ksv5kTW2?=
 =?us-ascii?Q?5slRhYbKzngPIh93GRAWTAJ98ak1Kc1tAH1KCXdnTZO22HZUgNRdjAg08EMK?=
 =?us-ascii?Q?d+YBnxt/tSKb/OmojFZ9VVDNs+AQfrv25fzMu4IACuCRAKkX2vY5Z1vozncJ?=
 =?us-ascii?Q?6NAExP/C/uCTZcbEuMdbULYAuYYcyj+hB/xMZ6UrvEi3FpnnRsuqFrS9YDt4?=
 =?us-ascii?Q?G2A/XIio7cqklLwC80ryBZkHLc6R9wS7Lv8YnUHu+KBeCiBmddI4hOU1VVbF?=
 =?us-ascii?Q?c2ebL94KpiAQnsJmvibpAJ93q9+ouTKzzoripHMWqCw7UEFRujAhk6JKc++6?=
 =?us-ascii?Q?AU7v9LsW09AA544Pgb1Ek1sqlviP39G1hLO7lbsRKKscdnj1I9Hb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd361d6-f349-4bd3-5e38-08dec13874f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:22:16.1142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqU4DmcKVbyzXx1NwX0/rpFQ3d9TPpfBRolxmozFRrUIU4ovGuGUYq8cSjq/hXYuGlz/DKUFZkY7iRknIXJ8pRreEV98WA9PvfHzQ6ULSIPEEayqqF7FQcYUAHXy7/pz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10311

Based on the following patch-set[1] issued by Mani.
Add support for resetting the Root Port for i.MX PCIe to enable link recovery.

[1] [PATCH v8 0/5] PCI: Add support for resetting the Root Ports in a platform specific way

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

Changes in v6:
- Use conditional constraints (if/then schema) to specify that these three
optional interrupts are only valid for the i.MX95 variant, while other
variants like imx6q should not have them.
- Change lnk_intr data type from u32 to int to properly handle negative
error codes returned by platform_get_irq_byname_optional().
- Replace platform_get_irq_byname() with platform_get_irq_byname_optional()
to suppress unnecessary error messages when the optional link event IRQ is
not present in the device tree.
- To avoid inadvertently clear the pending W1C status bit, clear the W1C
bit firstly, then do the regmap_clear_bits().

Changes in v5:
- Update the commit message of the first dt-binding patch for clarity.
- Add explicit comment explaining that writing 1 to IMX95_LINK_DOWN_INT_STS
clears the bit

Changes in v4:
- Set these new added three interrupts as optional interrupt.

Changes in v3:
- Don't add a new if:block; Drop the maxItems constraint of the interrupts
  property for i.MX95 PCIe.
- Add constraints for the interrupts property for other variants.
- Regarding the ABI break: add descriptions explaining why these new
  interrupts are mandatory and required by i.MX95 PCIe.

Changes in v2:
- Constrain the new added three interrupt entries to be valid only for the
  i.MX95 variant using conditional schemas


[PATCH v6 1/3] dt-bindings: imx6q-pcie: Add optional intr/aer/pme
[PATCH v6 2/3] arm64: dts: imx95: Add dma, intr, aer and pme
[PATCH v6 3/3] PCI: imx6: Add root port reset to support link

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml |  29 +++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx95.dtsi                  |  16 +++++++++---
drivers/pci/controller/dwc/pci-imx6.c                     | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
3 files changed, 164 insertions(+), 4 deletions(-)

