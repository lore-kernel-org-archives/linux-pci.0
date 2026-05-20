Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010000.outbound.protection.outlook.com [52.101.84.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D6308F32;
	Wed, 20 May 2026 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266819; cv=fail; b=QsLN5hCoCBOHZo9L850iKZDJ+Yy/axdwO3T8h6SXgeBJxsOeG87Q2XVSNgI4GmxLohgwGX1o7cUXgLHjf+9noalA9qEagIKIKrZnsDwREud5TL8MDgFsv7dRh+Q4TaF9hlWc1c5eIVnNNNZG+66r6P0k1sDYGcI2bIJcYUgCNpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266819; c=relaxed/simple;
	bh=h/vA/3rKRKmivm7BbgvDaeVQvKONPUf6h0eDjnwhAOI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fqKMoUlT8rH+ZdscFWoFtLnAMJ6Rq5FmVoG4DilWKDbVHf75At6PTkpiGllJzdY2KvEd+1y7tqPji34RjrDFDFSkqeQyCLZx+STNHBPL7p+MYhVqbtnuhZj4RcWRtii5gr+hTyhMQAhqusfApS8nzJISkSBC+QFecWhNMSq58l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VA3Ahtkm; arc=fail smtp.client-ip=52.101.84.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VA3Ahtkm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFndW2Vrb2OnxGWugJaHOf/boHsUo+ehgXv8M9JJSj/tbN0WmsYDXzH6keVMCeXYD5uN8FcDEqmuqiINJUVdmYEvIv+hO1cj5wbZBk0BJUGiI3JwByOVIsbS8FVU/hj/nZZWFtMADrLhjk9AambF5xrovpPdgslTdb789+PyKPhdqEXgtb6vIiRz7DLbHT3NPxVuwHnypYgQkmyrOg+DibLNdAzAbBbgA37RjnmLskU/gdsA4I7QkEUBaVtd2XOnS1QCAqBvLBrszynjYLkGB2TPheh4pY4Gmc0cvWjLVoTQXP4vd/Ffoigpc9rZnKxTFCpGYrn6h2/14kPLYPHuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NotSxDzkLl3XodU6+tmsSytnAicz7VFdyjsxTvFPwdI=;
 b=cwZ/D9eddkvlMnvJ84sg8NUOQMpIvBbicsfuSlcmwlBC1yZkRzNV+z67qXN1n5u0S+f9KTOp3uAzpKWE0jl4H35myIJ3kUNkoe1CIfRFV6IG6avDfyeKOHSd2IMXPfV2vId3Y6mfh0mSQ79FoSewtEVwU4ETIBYNeGNHilkaO+TrNbF0sBnakifWJdtzCUt1+NOsiCgspJK2iA0XbZrNYjeZwg+jJQaQ/5NxZvRIzweY/CmSiNvpWpoqnkK4pyGf01Ib7Z24oZGiH+TYZwGlripJAoZPlDdYFsGelvRWhgCRhNFEsjBrAMgQ1EDtqMQV4B1VfUspb2YExTZt2TVabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NotSxDzkLl3XodU6+tmsSytnAicz7VFdyjsxTvFPwdI=;
 b=VA3Ahtkmgrz4VLk/UeOmS2W2o6I9J9oqOztI5PiWkgYDWrUBTxbs3vhG5FTb2TWuOTMeqhAhuYyEstFk4Z80gwr2j5D9budkbSePSJCvJz5smwmSJApw0QOJDSOExiAH/xnFlaSrsQ1s8gOPYK25T6lao/gnRj6JUX6qlw+Vrg2kJJXER3VCCvfqdFKNIMq0tzE+D/5D6HMGGOcA48QKZJZ/odOWCDTdOTsZHHrIyv89kgzXHbzr3DyyIN/mLeJwuj7RrwID8OtGHBEgif5bbxI17WUl0b8C+QLXmLkiCuwFQaOkp3OOkypSgjasDbFMHZ9aNtEqjKp+hlMyL3Z3Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM8PR04MB7442.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 20 May
 2026 08:46:55 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%2]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 08:46:55 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V3 0/8] PCI: imx6: Integrate pwrctrl API and update device trees
Date: Wed, 20 May 2026 16:48:56 +0800
Message-Id: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0201.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::9) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM8PR04MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 55136acb-a06d-43d8-438a-08deb64c5821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|366016|921020|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	1wz2hbQKQnmXxFL6uFPmmW/z8jvNZFxUSlDNBR0LhW8ML0ekJO20BWKv0iNY6sR/vdNAumRHgokMJUBVNQO0/FtgiYrGkeOm1wJ1hX6w7uQrm1MDwTx4zqpzF8PPa/y5K9IAQpyfpPYW4EYUJYn1sQmt27Wb+qVG81w6w8N72cU/N5n2HQrsiXSeeP9U7r9KVfNRK2j8WUM4lrvpuh50TNH5V6IbaiGZIkRELmD436Hp9lWF/7DK+IQW91ZBS9+dFnnS4GNIMF4v1kYk4CtxPS4fj4oMzxmSIKXWbUGWug2+Bris9HAcUhCCr0Q8B5y46+AOSDSie7hWgk/OJhq1mSD7PeJMEk18OhFVhnkekrIgzLYv1LBD4jPkyoodjFL1lPxV7lZd4XR5sc3MLC7wfuwIgv2U9QjdZc0Q38uvtt+UBlHSeGtSqJNNPZkSrXkrGv/88rb8I9ARfgXCQfBGdJlZrfsHZdBexTlavnzxtj55XqctSo+Sp7xRnHpYRZiqV3tcQ6eTFieB0He5HkIqDKeYtYTB5YmmNmrxhvDnvYIlQx8We/rnJFpaiydtmQoYiXieHl/JmytMf15czaMEcRcUNe0sVs8uSFRnB/npWHG7JQCAbCokLCuTnwpU7N9/poMduz4YLRGYSPN/KX6/3n+v+FkZB6f4wDl40D8CFh8jUOw8RIERo8pSIvAUvxS3mzr5HJn9DxlwmtufQA6VRD4uga2na9iUp68foE/sPow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(366016)(921020)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JuD5Dy1Kn3BX3KIuLYmmOs8xvhmueBElUWF5lxmlewsjDAuXy+ZI5xp7ZCn3?=
 =?us-ascii?Q?yUugmQtMPRWzAtdMGzec3ShVCG+JIJrjR0h/J20NsmRvmKKlcI2tHEgzostP?=
 =?us-ascii?Q?lHm7QwR71W+NtbxhGszqO0G0mBleG80DCUYHFQuBtkqXGl5mZpapqmqH64r1?=
 =?us-ascii?Q?dOYC/jGu4pleOIvU0291Qgrx/iug5dBq+xeeOTLg61BDcVMkCFtAtUrMYMBk?=
 =?us-ascii?Q?/cnFzfBDIdlpr4hvM6pj0UdTDErjNiM82dcxUUXKvkZZUQn34PL2AQ5IUcM/?=
 =?us-ascii?Q?po4r48v14dk+do6Qw1L9DYIn3E4LK9GgY+r4Si/ITh6g3XQzjrIY3e8R65gp?=
 =?us-ascii?Q?hALTaDVp3mw2nLYmt7SYR8Fjl7rIqhUug7OS/dpd8nPOFI54KlYDQm8eMLxw?=
 =?us-ascii?Q?h9/+KQM1r0iR58ccX9ssGn1I8Thq4bn5GT8fOHtvsBqhZEa3Fdqt40aU72xH?=
 =?us-ascii?Q?X+d5/Mfux7WMtHdVRvFkyaXPZ/YpJPCSl/lhwLJ5XdGJr98s8ptmsT24Nc8F?=
 =?us-ascii?Q?D4TcKBd5+7TLbBnZOVj9Qs9AqC8CFvbCuVkl0FhlM+UpWOO9nQUMDETdRzJp?=
 =?us-ascii?Q?lMWRQEo05kD31HiQYX6rJKJk23zBIMNEX4nwmG8wNPwyKiJeqHBtz+sBNn7h?=
 =?us-ascii?Q?+jWCf5VYqd1UNZRR1Y8VuIcTfhGCt6XUI7PSkYI62PUJFcYLJ9gkS8+hR9uv?=
 =?us-ascii?Q?ZypKckOHWGFCCHXC8qMSB/V1Vin2FBUBjhNTEtADIXUjtheWP8IHHdV68qI4?=
 =?us-ascii?Q?faVW/48ERugiUMfRd7g+LeBlZZhrw4p78Zfo55Mdplyp9vDhPEShNZLRPMxZ?=
 =?us-ascii?Q?buwe5Mosg2hLPDhaE9U8LLT10i+zM8qEzKirqFSjFoWjRYpdiCRumoxPt2QD?=
 =?us-ascii?Q?RBaC4g1EO7qBrGVInW+xv3ZR4CNVPI7BgEZYVLZwbFDC45sSYQrXLH1x3LaJ?=
 =?us-ascii?Q?R3zROtcwV/04PNHIR9cS3hOlbthOR1tPb1cVJE9TrvfiSunaDs87vP1zS2ED?=
 =?us-ascii?Q?2UN9Vojs/k2nDC6jRTGFawXdFHHy4s4V6MeGatPbTlOTbdyj7IzCoC+cKlsp?=
 =?us-ascii?Q?hlV1tC0RlHmRbJSGF87d+LOF627NHuuVqTeMy6I7a/zHVfLMISM6KlXsG8jE?=
 =?us-ascii?Q?hq1pMfqCqrdlCPGx2TVPAv10gsOwFo3LFmP+yvf5TSZHfULKhS8PDVi2CQaW?=
 =?us-ascii?Q?rbbeZks5hqCSSzRm4ryORjpzzBkDI9oG5p4tCyXVrQqCXHipU9xBgRPTypPb?=
 =?us-ascii?Q?7wtf5twMRoqgZNO/yYS4HYuA1x7yqNXB5pX1d73kmbHMZkPQUs7KNzzuPm+Z?=
 =?us-ascii?Q?l4LxRxB9oW4eQPn6zq2ETIzqFUNuZCxmwem5ksZpSxdZhLVnuKvyJQ3Lkkbw?=
 =?us-ascii?Q?3SUVj7UG72tOk9CGg/MyAfK03dOdRiGx5XNPl31B5bRrXMUekrqq4tmPuy+k?=
 =?us-ascii?Q?5PNTtreFjMikgiuN52AxmZ7WJ4kNxVmrfSW06nByrfeqKQ1cfacPDeNXYLUp?=
 =?us-ascii?Q?fXhHAZrKRkkb5NmJ4jNIoMPwSym+HjNEjrbNxB+nw6yWUGiNzTzuWNooqvpk?=
 =?us-ascii?Q?qPDyqxP+afCD+re0xiTVADDTsgBgoOSMKwIHiK/w+OJnXXrnhS+KqL6ZHDK/?=
 =?us-ascii?Q?TiGO/PCZ6Rli4eOrMKmPPLaBaSATmuo3pz3klSq8dShpCvK5qP9TMyOk6FrD?=
 =?us-ascii?Q?0phWMm9aI04CbMW3Q78ZU+LpJl/sibs7Q0WZnIihz3oGlUsKRmSLdTJBZmAN?=
 =?us-ascii?Q?g2QLCpqBhaanaCDMVoSy2xCFgOa0CfUO6DssRcI2AzIs3HOmWr4u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55136acb-a06d-43d8-438a-08deb64c5821
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:46:54.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2FGHZU/ioypPoSuP8Y93qb0UkrXc1zMldYCryKNusn+OOv4XQ/ht88Z8Y5MKIpinvTZdBG4sHNS7eAZ0G3HtN4E7i03ZGtV7NwUmq83vHu+lcxRfms7PjLNMY6cclvi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7442

From: Sherry Sun <sherry.sun@nxp.com>

This series integrates the PCI pwrctrl framework into the pci-imx6
driver and updates i.MX EVK board device trees to support it.

Patches 2-8 update device trees for i.MX EVK boards which maintained
by NXP to move power supply properties from the PCIe controller node
to the Root Port child node, which is required for pwrctrl framework.
Affected boards:
- i.MX6Q/DL SABRESD
- i.MX6SX SDB
- i.MX8MM EVK
- i.MX8MP EVK
- i.MX8MQ EVK
- i.MX8DXL/QM/QXP EVK
- i.MX95 15x15/19x19 EVK

The driver maintains legacy regulator handling for device trees that
haven't been updated yet. Both old and new device tree structures are
supported.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V3:
1. Rebased on top of latest 7.1.0-rc4

Changes in V2:
1. After commit 2d8c5098b847 ("PCI/pwrctrl: Do not power off on pwrctrl
   device removal"), the pwrctrl drivers no longer power off devices
   during removal. Update pci-imx6 driver's shutdown callback in patch#1
   to explicitly call pci_pwrctrl_power_off_devices() before 
   pci_pwrctrl_destroy_devices() to ensure devices are properly powered
   off.
---

Sherry Sun (8):
  PCI: imx6: Integrate new pwrctrl API for pci-imx6
  arm: dts: imx6qdl-sabresd: Move power supply property to Root Port
    node
  arm: dts: imx6sx-sdb: Move power supply property to Root Port node
  arm64: dts: imx8mm-evk: Move power supply property to Root Port node
  arm64: dts: imx8mp-evk: Move power supply properties to Root Port node
  arm64: dts: imx8mq-evk: Move power supply properties to Root Port node
  arm64: dts: imx8dxl/qm/qxp: Move power supply properties to Root Port
    node
  arm64: dts: imx95: Move power supply properties to Root Port node

 .../arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  2 +-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |  4 ++--
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  4 ++--
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  |  4 ++--
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  4 ++--
 .../boot/dts/freescale/imx95-15x15-evk.dts    |  4 ++--
 .../boot/dts/freescale/imx95-19x19-evk.dts    |  8 +++----
 drivers/pci/controller/dwc/Kconfig            |  1 +
 drivers/pci/controller/dwc/pci-imx6.c         | 24 ++++++++++++++++++-
 12 files changed, 43 insertions(+), 20 deletions(-)

-- 
2.37.1

