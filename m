Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE6D2D97BF;
	Tue,  3 Feb 2026 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083728; cv=fail; b=dv9ppHOhwJPaYI4d+BzaWaKBlwXmC7kc4WMHIiZ7psk90EbqKE3fLK8CNOjTiM/Zzbzwfru19B7lRPxreS09sUmYmbvnQJoxhAzML7tNVJGtmNEOfdp0uaENmFEmWDDGi4kG6SS67Vm5vIe0tkgVdCEMXN94A8i621Z2lDUR2g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083728; c=relaxed/simple;
	bh=Weo5KvTadWK4buBE909PBaH7yOk0MJpvDKa9mhQfHrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NU2rX0Amd17R60g9asY15x88Qp80Uogg2w+l3VmQrSuG+v4Xt/uMWQaBZyZj7enf4EPoYFSiAcL2wg7YhK97oygUrUFZztOxKHkHXco//W3oYuYbxhAZzUILmpD2mw1ZrZudrQQ0JVHrsrD96u3nWjhjlHyUlnf6HypyxVOZQjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TeWj4n2j; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TeWj4n2j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4tIxUxdwL6nGDKzjcqxL13jpgC06yBmHWZGePjNuefVw9qMgZWWhptqBKYu9N6mUY/rF2/o1Tg0oUSvQjgVe9JOt32MoxG5I6DC2TRfawyv9KLjHoxaVQ0cDCWD62e2C/vSfx59hbwddyPq+cPs1tYYfGJUlcAef6lW+fKF3MnSti57FYkS8U0L7oFT+G8pHcS4TY6SoB3SnexCTK+8soTz+ivQAOF967SYdEiDmAJjVaA/R5YKID5I6NsXfle+MtEmI6MY+YucoZ9q+uHwRz6HDNtOrjUbZqWUoZ/NXFrQOHZipV5OnBzVZqxGaCTdxoKw2b8bP/1VJfLDPcnd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=Z1vz6ocheA5/dXbOK3xr3xQkmFs8yPJfRnr0OxJBSwIDtHximUlsp5WXHOdqK3790YZ1Bi9C8rCNgxMmuoE5nLS9buzLFTNLwUEhI4UID5fYMAjA/D/UXBB/KU3rcxFpDBQEYGldBwfzCt2bzQktDMMjFmjHzR4vFMQ6Oqd6a2tdLAKZy8d9T/y20oaZ5uDDQ4i72xcH2fxbUz94/P8J6aZgDVyqb+PLRm+aCvQtte8R5eNAJ2qocFodQCiO+cjomRSWedkQJGQQE//l9bWjvofhNfetLIfDq25bhyhSdzgTFj2MaiWXTrtRGm7jOyXHgAjGHgGhIuipgqMxzZD8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=TeWj4n2jF75012Yn3h4dpwk694MlNqqkyUThPZmhjsaKxfzvd8s28S67lepbouDL//xiAZJ9GS3Yy+ME2Wd4AbkgPMKM35/s+PVeQgKLmcSllWPbjInrlv1QdNerwUBSVzzBu/xsg5qO7wY4YGdpG5y2lAdmZPXXbTM7G9kLllB8qv7/UnE79dEefb8JIDpOC/933PSo0NrzDlE/7U33Q1QzqUWC1uSCf14QAKEaFlasQF2WbTa2u7sscT3rveilS+EebZrQmpXrEyTuCMMhcVxTgFzkWjW9DgBvq/Y7FKH/ZTKE/lscILChDqJUrfZTZxP57reqCJa3WJg5Akh9gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB10301.eurprd04.prod.outlook.com
 (2603:10a6:150:1dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:23 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:23 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 01/10] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
Date: Tue,  3 Feb 2026 09:56:05 +0800
Message-Id: <20260203015614.2957479-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260203015614.2957479-1-sherry.sun@nxp.com>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GVXPR04MB10301:EE_
X-MS-Office365-Filtering-Correlation-Id: c7caac37-6474-4bcc-fa4d-08de62c74b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XnEuDaZNswvbDTCjT24I18hIokNoN00sVUY5D802blqt/7y2ncdUpHB0h/Bj?=
 =?us-ascii?Q?bj0Q92k4IaPkccx3xnRnlSBo9/K1Ke7rA9goHL8Olcng3zd/zIzFFAMYmwZK?=
 =?us-ascii?Q?TA4fvj2QlI/hIXjde9etbxqy52R9ockYRUKyM5T32Sp+Y6sviNuOkML2QPON?=
 =?us-ascii?Q?EaxVNhTRetCJ4c8IXKs0swg8mWL7XDgpK7ZGdl0XvJB4PbcpnXZ01NwnmxSh?=
 =?us-ascii?Q?QgUO9x1yh3LjI69eR9p7iUBwFNCpsJd7NCbBIl0f9EVXSEgLnevRmB7oX0Ea?=
 =?us-ascii?Q?BQmlf95kyMhAd6G8ggzLJV+xayMbWOcpzOdmD1RdZwtfIsXaW58B4zn2acIN?=
 =?us-ascii?Q?QSnwzaaBq94/zrVll7nDwCzvyt6qcuGV8ii9ggnseGmL5uLbsAX0TJMYrdSU?=
 =?us-ascii?Q?7b+DcqYPpcaJ4fb2/B9G1do7NpQQPdk14wl/5kHT2y4EbJr7ihGyPs4OsAro?=
 =?us-ascii?Q?V7kxgRw3gGqZGXfoZmwEf1q3o10/XrZvZhaH95EPxY3pOwb9ggz9sDQAg6fz?=
 =?us-ascii?Q?NR9YU7OqvA09fkwSStKhq4ReXaUR9pWsFec4EayYwoaF26jaZKkva55n+FI8?=
 =?us-ascii?Q?oIwTpEniOF01fX3X60mf0u8qILTqY4RG042U0sWYOEbPmo/FJI9rVtotN1BE?=
 =?us-ascii?Q?hIPeCVPKdxe6c8fuLAsgK4r68HPUtCeVjWAo3e9WynghdFBq6JRvt1K39QHa?=
 =?us-ascii?Q?mmZOMSoAfumHOBwHcF4ZbB0/xFRwYiUTbKQ+G/ZGuxtfLYHS6KI5KNUZh6C+?=
 =?us-ascii?Q?EJtuIqRjY3AgYhmZWnDweL1Xzn1oj+WJMBlzYfncGDj4FrIymVSSnd7brE1f?=
 =?us-ascii?Q?6S3vysNAyHtWPuF8e/GtzlD0JZZULnDxUed8z7Qx0PTq+IfW+CXAr8Dapzs5?=
 =?us-ascii?Q?BOExOE9gaKW0vFiIBWV1uoMJMYDimDPlw3FSDYTZMe0/88isKmmkvzTFhXRI?=
 =?us-ascii?Q?nevUhm3J8qK/pmM/E07DzIWGoykA1VJvoxMe5jOHsKrLFA+XTp7ntBGV8DNP?=
 =?us-ascii?Q?sockZPy0lmR8x37Vy7VnLQsGl9Clq6NZBIs36ASADAQ2Jf9BPa1Wx0Ox6FoE?=
 =?us-ascii?Q?nTxqtSF4jtVgRTGnzic3FT1pf1AhLL8NmlzhkyqLumt3z+qCmMQPO4JUUYKp?=
 =?us-ascii?Q?/DXuysIMAk/WOw5SPe79jcpy1VLhBrh4su32i9awR+Zlw/agTRmuowXU2NMh?=
 =?us-ascii?Q?uEkeTda7u2X9vigKyg6MAA39gR+vjxxoZn/dQ3bFeUXB/vKlHRX/LF6x3Gba?=
 =?us-ascii?Q?GdnnqkBrA7tXWKCvAL972tDRFMZZttfSqeSRLFaIeXtKQmpGpDpnb9Z1/PVt?=
 =?us-ascii?Q?LfoI5ZbNergNxwNVEyYAKcESMsOsYg6uni8aaz1lu0fQM0TOhPJIzF5qSeth?=
 =?us-ascii?Q?z41+6qCMT2abk1tRrAaMdwDHlCWjd/mPItpffxBcZtgms/NRsHmX0PBXwZY0?=
 =?us-ascii?Q?Qbo75/lvzuJMBkzuD9uFVHa/4B/13sPJdAJwvpIv5zXGpzjQB0e2znAaTMzk?=
 =?us-ascii?Q?ENRGCR3YkOJeMIgR3aTbK5CAPR1ja/hOnOxO4fvD40ALimPpRizIXihqvtNm?=
 =?us-ascii?Q?+S9JUQeQi0VKz3ve+lWe5zRk8wCfpqeRQnTnNlqon4DceEVOD68JoJscI7QY?=
 =?us-ascii?Q?TYo9j7Ms7mrpwXo0k4KP6bBq0AR6Fb4HUeWYoFlNO8/R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o2cLIphSkRZ/bKs5FlPoiUvKxOSfNf+wrW0VMsBBPyC5rKjrQTyKhVsaQcBC?=
 =?us-ascii?Q?X/NusTvEx/VjAwMlE091XPc64cZvDKOC0q3JlmqfCa9RanDLEvQHgYqic553?=
 =?us-ascii?Q?MwpEAnnB6lwq9PEIme1iYRWh7AYb23IluQT9U3bgEIpbITKmP0kqN50WhziM?=
 =?us-ascii?Q?JFw2dXlX8pELfM0GJtUFaFBwvI+JPOCsqPs1Gz/bK7f4GRaO0Z/Jap4mX5rw?=
 =?us-ascii?Q?Q10vNEUI+w4qMHxtvWkf8o6K12itPXtQQdxaAbS8BUhgpS/Tfn3xve1/EMhN?=
 =?us-ascii?Q?YxLd4iENo2mvAu6FANb54dSjkTEXXzE3D6g4KBO7JTUD1lMyhYBOZHeHMbFa?=
 =?us-ascii?Q?+6+TaNbk0CkBIlZ9GNvis+620FPaRA8FhGOR/KuBr6qi5AlvQam5SLATTFgr?=
 =?us-ascii?Q?fPUtJojoKOEPlJuu0axe2lSuQBgIWMaUZSU7307lMjg/sCD+8lasjADirQzP?=
 =?us-ascii?Q?+yNwaeH12KRiCmLaN0vq+AU/Dia6/4FEXqStnvJLOoaTvGed0bG+aGaCJyza?=
 =?us-ascii?Q?wSCL6q482/l3y2aIvLTpJUJTXFAXZVkdcKBjcu9MD7EE76IKCKyIkM0Qv6Oz?=
 =?us-ascii?Q?RWFV5D+pQjkuAWjO0A6Eg9Y9w8FC16OCiYOXWyJfq0SjnkZF0OK+kQl3dgAX?=
 =?us-ascii?Q?VLA45Pc0Z3G0vHtBZVDMRkGm0NIP5RXOcokQUuha3H4IP86L6ro7FWAIRUJD?=
 =?us-ascii?Q?1Xx+BcjGnSbKQ/21Z4IwaHVVEAVMD3LWWz+Nftl2ms8VnNoP/VFa41MXEWwS?=
 =?us-ascii?Q?TUXgUGSsNrnuaDHP9mT3rpAotVK7zEwyQcmPZyzC/Z3X7z9tgS/axIab2Wad?=
 =?us-ascii?Q?06B8OULqdYI7p15kKXjKLU4BqDRCfW+D37hNcDYPaBU9Cx1d9sVIzrj1Ufxy?=
 =?us-ascii?Q?4FfFsgXbPgOAXtbqfbvfIVsgoSEs4Kd6YvyVbh8azMtx/xYf0Pih6QNxLQlH?=
 =?us-ascii?Q?byIOxMyPyyp9fQEuF5GElgMpuPwGYS8x33ZdbUxSr+bgHC1BtMHwlNXAwJ4l?=
 =?us-ascii?Q?EjIbfm80SHdEZnXXrZRKM2TjLe7/EpXohFyiG+g31rzM9RfvKjw/LB8moveC?=
 =?us-ascii?Q?gNQnGeT7ira0PzbJQeKA550mMaOFOb5bW4VGL8LgV8B1hfsIhztuopLUi5py?=
 =?us-ascii?Q?fCzpB5sDP4bZA/pexsLlTESek3eUezee2rfHMPEoEXRfEuzUO9zDCQf4Ex7B?=
 =?us-ascii?Q?vCkkFJskIkPRrnC5SQ0LAUZKLglTJXI/uL8E0uisRWlQPMxdTpwdUZezfFcL?=
 =?us-ascii?Q?dGdur5r/AP678J1BZvuJV5c7HZ1lNq8tHK0V37We98v3P84399QIfSdcTy7I?=
 =?us-ascii?Q?+d50Nki0UWOyf/hqXBML6qXxg1AvPP2Vxu8yk/N8kdGXQnTz2FbXGcI8AodA?=
 =?us-ascii?Q?6o/Zi1MT8ByE/2+t+SUasf16tl5tGyzser3wLUVj/kl4zSt+3jVErxsKJB/U?=
 =?us-ascii?Q?llS4IZT3c32Tt5HYbSf//L2BbJYklalrSNWyvjqQzoh1vK5LudPLFCYmIJoT?=
 =?us-ascii?Q?g3jEho4WKEN1vqXXCBSutpAQ088qQ7Ga1HWStIT76MegkJTiXCl9pSAQTCdK?=
 =?us-ascii?Q?1Ptn8F7RinnIE42F1/7Rob2miYyIH+x13CJOvpmowa0yoH5i9upGNyHGVK7s?=
 =?us-ascii?Q?e/o14m2dAONojkRtJtHz0DaEE35+bagEHGFcibKkRsWbpNReDUep9lyKnarv?=
 =?us-ascii?Q?wYR1iYUFM1SB+Wljcvxgzlb72Fteat0MyOE/bE7CyNRx+KU9LgPRFdYu5Mbz?=
 =?us-ascii?Q?XDR0Ha2YoA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7caac37-6474-4bcc-fa4d-08de62c74b67
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 01:55:23.7003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdS9YiCFNCl7WU/dS8aH/UHe+ZsWzH6U7i+R1rzkK1GP9xN49LW8lzLB8kzV+5wvtYksry7zCqtrilzqe0fAhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10301

Update fsl,imx6q-pcie.yaml to include the standard reset-gpios property
for the Root Port node.

The reset-gpios property is already defined in pci-bus-common.yaml for
PERST#, so use it instead of the local reset-gpio property. Keep the
existing reset-gpio property in the bridge node for backward
compatibility, but mark it as deprecated.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 12a01f7a5744..d1a2526f43dc 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -59,16 +59,34 @@ properties:
       - const: dma
 
   reset-gpio:
+    deprecated: true
     description: Should specify the GPIO for controlling the PCI bus device
       reset signal. It's not polarity aware and defaults to active-low reset
       sequence (L=reset state, H=operation state) (optional required).
+      This property is deprecated, instead of referencing this property from the
+      host bridge node, use the reset-gpios property from the root port node.
 
   reset-gpio-active-high:
+    deprecated: true
     description: If present then the reset sequence using the GPIO
       specified in the "reset-gpio" property is reversed (H=reset state,
       L=operation state) (optional required).
+      This property is deprecated along with the reset-gpio property above, use
+      the reset-gpios property from the root port node.
     type: boolean
 
+  pcie@0:
+    description:
+      Describe the i.MX6 PCIe Root Port.
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -229,6 +247,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/clock/imx6qdl-clock.h>
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     pcie: pcie@1ffc000 {
@@ -255,5 +274,18 @@ examples:
                 <&clks IMX6QDL_CLK_LVDS1_GATE>,
                 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
         clock-names = "pcie", "pcie_bus", "pcie_phy";
+
+        pcie_port0: pcie@0 {
+            compatible = "pciclass,0604";
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            bus-range = <0x01 0xff>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+
+            reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+        };
     };
 ...
-- 
2.37.1

