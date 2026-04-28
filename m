Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F182DC792;
	Tue, 28 Apr 2026 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362571; cv=fail; b=BHMF2c7U5/i0hzJJEeqnq6UqxBQ39Y0AypS3HCCvXgrd8/ED77WwDblaM78BCRBraTRJmc07w5jQAQL3vI4pxY7bvmPVmaacVt2ZT1z7kg88/yMFQRTc0WXbVk+ZVbhNiDxZsdci6HUsAAbv0EsqO49cm/yiH+9sqDGy5CpOkYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362571; c=relaxed/simple;
	bh=zCg4PuZXl6wdqP7c/0gxzNLMRTlxaKzBgBvFTwyD/Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=at9myGNnMpNlseqFFyinQfrRyGyzw68Wh8v/bd55rqhLwsw8g8fL6mX02yMr/Y1q2pXsyyx2f8ZBdlOVEHINTSig+OhU6gr8tbqGz15wlcShFesDYkAR/4bCHBb8mREgY1353QdMIuIqLgFYqtBNVMHtWmyjD3uPz8gfgVc6kl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UlLr49A1; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UlLr49A1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4y47mllwDBUdmyFMFqoQ0jQCT3rh6IidQ81fgJEmFPhAo+jylkdWqL5LQYVmcssb4tQHi4t1CQZBfxOm7RBf152C331wy5pIGhqmuGuGydJohHUFV8VxVi6DlRJqdnRTPuv40ortIwQAC32CWYUHkcXube1G9eaWkvwwSV8FcTiuwzL9gDiVNLiFtLBfVkxfwXliHb3TFL2sPVqgVK/bO3nkKi5LHz72UeBh45DSHc3Y/TMYB99w4N6ly4HiLDN03qH+ttFNPSuDOycrvXvLa6QbKgjtC1z4Ex1ylTZZT8uQsw9Es2XcQUdMdHGc7S42knTn9ota6UmLPsC/915tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LS3cjed6wT/ve6oSAab5MfP7jXSZWFqsiBBYZ7azLY=;
 b=u8ZAgCcI+xUAvjNgwidtpnQAgxp+GBr/HO2ivd0KlbRjzKN/8aHO+WirNkkRgZpXveXRJfnO21iFNQqGCPd1u/GGGtWUgAWFg/2J7j7roVJk7FPdnnAKUBDwFC3XiYDtJg+rsWOEcwkllVeeqw4NtCn46ckHpEdTu356UrGyhOWZQzixLKmdTukPfpktFv6VKaJGQzek1bDR0UM0GjKp6Rhi7XTg0UOZOe2IJ3NbgL9SJb4Q709cvRXCAUOR7dkdt7SRVF+YtTYoi8xgZuhRgND5hmeMzrG/cVVeiYw4TlkO3UYNj/cI1pea8sTM7NPfa0y06SxRbc8jdf9Lq2+RTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LS3cjed6wT/ve6oSAab5MfP7jXSZWFqsiBBYZ7azLY=;
 b=UlLr49A1IoE4ZU2bCaBgo24YdCnjFMetlNANWYuv6vOOie9UBOyA0Tr3uNC+Ummx7/HTVh4C54GOlxaDSaDo70iBDLq7wKxhB309wTVMJuGrrEDcMER0dDy9PV0DovaDLKkyXE1sG6cEHFCG+KocKvxvDmja8neoKMdLDi1sbR72fkydFqbKjWj6/JTeiXxbrYwRrP8L33d57KSuebyJAAnzL6uonYkhnsH0VaZIPahYqGwaaFfWhWxWSrcWKDJqHhDE7dQdWMPcboRG4oAD/s6HUzZO8jSHB4zLtgwcrmPO6n6p+RAC1sjGVEEkiE6AwbS4452COytr4gPB/NgbLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
 by VI0PR04MB11024.eurprd04.prod.outlook.com (2603:10a6:800:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 07:49:21 +0000
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5]) by AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 07:49:20 +0000
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
Subject: [PATCH v2 0/3] Add root port reset to support link recovery
Date: Tue, 28 Apr 2026 15:50:27 +0800
Message-Id: <20260428075030.1626440-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AM0PR04MB5220.eurprd04.prod.outlook.com
 (2603:10a6:208:c2::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5220:EE_|VI0PR04MB11024:EE_
X-MS-Office365-Filtering-Correlation-Id: b7957cbf-196b-4f45-f3c3-08dea4faa80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|19092799006|1800799024|52116014|56012099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	RKOoJP3Ihxewdo1Apg4sYIDDk2VOu+gaQLnW2NU4Cs8mgeYmt7ALBdD6ifwNS/Y8wIuDRKRskjpAWmL7DR2fn665MP9cZUNPsw8dJwyw3MUjfK0+h/QOl2DQFHSjB3gnCoFPg4m4QVckY3SrciODky2U2vKysHncMIYfOdxjzGbk4iom94lMmaQ9oGaF0QrRi8yoHijnZIF5g6mLgna0XlwQhkWgs+Uj0kRZYEJ/TsCB3dGc1gQ084t/GUTmwhtMMx6SF2p4Z5t3tUG5lIVnXTr8OnqJG6xA+Bi8G1iHHum9bByaJgwyKZL4OpCoPRngNviUexXtlM+1u2lnqM7Gfq0a0xXCoJfUmsdgzy3EtCOXy3R6IPC4SQzsuRSM2Iv6UOkiZ4o/fezsJcaE2xzwh9GS9ocfzeomFn9Ehn6lAmdQg+2VxyWhJqRykU34PKJFl7LAmuEULKGgYeSiwCrFUeVR20q93HTwmZ+wVhlli/OaiYWLg4nTo1d26EIWLhiXoDec+76Hzod1kxKtFDGFA7PW2ymoz0ri/9WsIHDiX3KRFv0q3973+IiPHrBgbUnXTe2ZykTlGh47DjqUNqfNHa0/eIdUVJNz/Rj+HCJ7zI9qIU+B6iiPV+Td5uyVQ6EAZ5doynfxHrJyDiFGVHLg3cIeIokQzJGzjGIzwaO6q1pq8nQagGw6Q/x7QeSv16uGZtmyBDlfISm74lngoYWowMgI34PvbeSu6Yvm1gCsT/KKw3pT3ME7NXBNAWp3h7lfg07Sr8LOtrwUS130OYouYadnCgEWBcuWD79hUFIZdFaSd2M4hwhEjHUS1L3x70Yz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5220.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(19092799006)(1800799024)(52116014)(56012099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kGZxfR4FDWotBT38W1ahd8PT3r+s6FZ5a+q+nKwc8100UrWN6GySyXOL2pNt?=
 =?us-ascii?Q?H/7DAEtM8D/wmoYbEmf1e97TAs8YuLrdEexymp4QxzIQ91tWHp1fjLOIXfS+?=
 =?us-ascii?Q?g08dnNoECtOMPqUS2TQS/gd43n5RHLNV7dlQJd0lF+vDxZdSr1fXmDWHOEF8?=
 =?us-ascii?Q?klRs+t1pXaPnQ0ua1kv2+LutcNMKDcQy27bVnAQovPQuPgJz/66xWouCGY3M?=
 =?us-ascii?Q?zA5nmGQ5LZh77MOnWxqtRQIu8OMYPexGzhOdPO6gXjfxXKQ/etHDjfdAhbO3?=
 =?us-ascii?Q?34jI2HxY3ee8/VS3FONY2R7mlPx5BgkTE/mhUQuoKK9qQhRcHjpQfzf1/7AH?=
 =?us-ascii?Q?8U20jSjX052tQ1sFNwJ1gQRd/NcDeo2nBj6OtNGFJdKf2bazkafHxDVABh47?=
 =?us-ascii?Q?a6Wxpyx7BBoL0NGvScsFXqpG+EZ0zEQiblxTulJpVdBGl9Ipu7lMiSJ22Jct?=
 =?us-ascii?Q?qa/I/9WyhYLNhu7wAUzHChfwOeF3ZUyfbwXqFHa17b2GPNhycjD5BUwmRlkO?=
 =?us-ascii?Q?aiacK73BWtIB9/mAJ5JrUzFNxodwbpDL6f/IWWsBm9VOyfzKQQwxgTKwVCF0?=
 =?us-ascii?Q?bV6jJq8plVl1J/T37ygDvmYsFuFkb15p0ovLx9Clx/2qdPdIABWsilx+jgK5?=
 =?us-ascii?Q?ffbNVW+cG3ynRO2RSxFSw841Nv755YlKm2QhbYnYowTOGrLffjzMAF6ugD/u?=
 =?us-ascii?Q?WwwuQ0jcci1fDbrWB4lWIh2zayr0/Z4pX098L1qQwnwboUjMmk6MZPQ9U+Hg?=
 =?us-ascii?Q?TbgG4pKYpGPCEK9e8OUqMwl2xQxaTrB7PlF4HTV7b3a8bkISZ4KP+8LdLOAg?=
 =?us-ascii?Q?LhZ5wfuXqPuLILS24TALiiaEjbZqH4XN5Q+K1fbsIWBPseWcObL9fAdO1+A+?=
 =?us-ascii?Q?Jf6BS9oGF+gavslw8G7drx/ODWCqMTEfdqGbhtcJFwuvdQPMNuzfBlrLCC6/?=
 =?us-ascii?Q?23NDpGjSfn5j/fJixWNbU1y5cKb249XHN6+o5zN+zSrEAi8CtQvEtUmxMEBl?=
 =?us-ascii?Q?FgWwnwsTXw49DfCn/KDWcwbbfEu8Q9z0p0GnbpqwV4ob2BsxVWVxBybzOFEm?=
 =?us-ascii?Q?7hkCSbD5qMJqzauyCV+02SClR83aXLdQCa4zUDANJxDub2IxOASpLwKgVtCc?=
 =?us-ascii?Q?N7dxCIRHk/sUcKw7Nk23Op/3zitQ8mtkRCbloEuGY8PbmlsnOOolyRTf3ePS?=
 =?us-ascii?Q?R5y1f3p2CekURZA4RvLACyEqeQlgPg83KK/uGuysqLn5AS7PewmzfgIz1Zz0?=
 =?us-ascii?Q?2ZIfk/lmIn7QSonPpzRhQP2qjTFov8JI5T1jIOy7lWmvrmRZadp/VJWUCVe/?=
 =?us-ascii?Q?z9GLJqNniKqZWYJR9uSxjbQ45UCKNTooB5qOvQdD1rMiDn5aQ+3kxGRIw4ty?=
 =?us-ascii?Q?L0sfhXTKFoJyGA5Aw59h1botZ/oJ/rwGxkfDBuqypil8Cm+IfGysrDL4SnVn?=
 =?us-ascii?Q?qHaw9RPsB+z3ylH0Pl5Kpv/mn/i2fN6HFabYgvc4CEOG/fQiYv1WrTF1dbfR?=
 =?us-ascii?Q?cUAR/fWX6uHttAtxXuJpoNuOvzaepz5DSQZpwkgtytow59B59Yc5iDB9pyR7?=
 =?us-ascii?Q?T3U2mbzFP9wPBeJKvVqgAlnPAo/9BNEXVAg1MvzU+HhijSVqC30YFp/+D6c6?=
 =?us-ascii?Q?b+ouHxSeRQgNwaYRx/O1IcuPw5b79OE5sFugC9vUt0VSxc0JMkOVfzR/ii5Q?=
 =?us-ascii?Q?ReFzPQVmTALwhQAapQIfvSIq/YcgWekpd0GSJX9DvYD8TKgG6CDPdHF43sfL?=
 =?us-ascii?Q?fPZLseFKiA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7957cbf-196b-4f45-f3c3-08dea4faa80d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5220.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:49:20.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0Zvl+Bz9r7nBAS4IsS5fbpXeyq0YFI/vOCVSmSjpRimmsXts5xdtGaZjD3KuN/b8RunA5cpM6GyYtF0YRd1ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11024

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

Changes in v2:
- Constrain the new added three interrupt entries to be valid only for the
i.MX95 variant using conditional schemas

[PATCH v2 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and pme
[PATCH v2 2/3] arm64: dts: imx95: Add dma, intr, aer and pme
[PATCH v2 3/3] PCI: imx6: Add root port reset to support link

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml |  21 ++++++++++++++++
arch/arm64/boot/dts/freescale/imx95.dtsi                  |  16 +++++++++---
drivers/pci/controller/dwc/pci-imx6.c                     | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
3 files changed, 156 insertions(+), 4 deletions(-)

