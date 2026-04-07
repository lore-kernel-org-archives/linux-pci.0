Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC93A9D8F;
	Tue,  7 Apr 2026 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558551; cv=fail; b=JXUBKJzkwJ2Vd68Fnx8pAyH2YGS9O76JMOwO7Ow9KONHMo41eXyVBneJuDUC5Qxw6uQMbpEtQQOZ6dD1dgHypLEEftb9gfgrO54vndHjhQwERXqfzSQcVWQ/ylUXQWulJS35atgwy+KCKZwFBviMHvQVpF0VAKCzKlYMxQqKJOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558551; c=relaxed/simple;
	bh=2QrNdCAJJCRH6qpVacd7O539pJtn47HWWp4UJch0H+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gYA+v545PgHA9yrYCRaiu86UybO6z1mcpa58XFVz5qv/vSAj+dk/F5gmV07Nik30i0iabZS8vHsRR1zZa+DxRQVQgk/rZxh2L4eQuz9xSoO0UvIxFsNStsqA3DFyPQ5PBhUofJ9eFGtn6I6hbDcgciLTcpfKhFoQe2haw+epNR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SRGaAYFC; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SRGaAYFC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDvV866WjVTY/96/OWOqwGV84Yh446ZlGqMzcY/V43pTUkRILSKLPNr9/cnoOC0H5xQKsdnQs7EmbVc3zd0O33ALya1KeyxlCNrUlm08rLE/Z39ONecynXAuZire6ri3HIeSB507yqg3LN0oqeRgxksBpQjFkQcp+o2Q2pjDaNtSXn0pZk0KCdiYF+gnHR/aIDfJ2RqGcb1jStAdHTA0jqzVxz+cNISrblSvcnlOrIN0ORrLYIRaiSbGVY54xX1GgU+g5o9oqIsR07KgKnHBen/pTmFAL7GrQ080i58YnPI39WElkYEURDKYWGwJHEWofpqTJmV79Sb2QjEKXici+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=xfSMC3Xk7+V71zMzFcBxrecI2Gjh/0mIKVBv+gTD/VcvXdRuh724gPPRRYPFUSj/XtlrFnnHrlB9wA6xq5K9PsYZZtJ/DRbLJ5j7g/sJ6uUWh8UuZbGiHfSVskLFDpCdLG+krmzAwM62Ndtc4ZT04bH4xAf2G55dGFUkGpGUbQJ5tOy4RAgTpjH+VpODpF0dImAN+NVCyw3BQ3Aod2YhqK8nlyPruRW/3uNgHi3epdMs7DrmKp8V4mTJKQDDxJ6bg5cA2GpqL/3NhIuBCNVw+iXnrdjWfq69mz6gyRLv7zzctSKrGCiiCccN4n+BHDYLskzZTqk/0DteeaIu6xU/7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=SRGaAYFCABZbgv1Z/ZRzrB0zBm1/hmWCmILs+1pr0MqU/Dvsxr+/KC37SK2Odz+PQ2khBbGlb5clT5eXsXa5SPiszdxZDSQkDTbproHSmGhg9r3F/gP0/lQJYc5P8RXnJ0A+tv3fPdseRBt6JFO87pkaEQ41mvbaDbAKM9TdfucoMT+7BlR975firotweE0bUyZscf7ivqsHwxpbCM3HtODMj3FaVcHBZkaVr/eQXEbtmz3C6cRWw2RY4J1N5EZsROwlRLtaypDytXYEn7+AiCCkanSRVsNYTFryUd97OI55o2DBIItgD73FHjle/Tizl5IuwONiqRKXo+oaixjSqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB8281.eurprd04.prod.outlook.com
 (2603:10a6:10:25f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:42:28 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 10:42:28 +0000
From: Sherry Sun <sherry.sun@nxp.com>
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
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 07/12] arm: dts: imx7d: Add Root Port node and PERST property
Date: Tue,  7 Apr 2026 18:41:49 +0800
Message-Id: <20260407104154.2842132-8-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260407104154.2842132-1-sherry.sun@nxp.com>
References: <20260407104154.2842132-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0060.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9048fd-ce7b-4a1c-9d92-08de94925ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2qZ4F6NvAXJS7b3V3br1Q+vcZ+nCoU0r2h/T1WaKGNo9kJJDnt/bQlmxSQMmUwjJwWiwWvp/98rRefeDdKLAWrWAIdlhPK6w4CBl9UWzYNgemmz7vDUwB8SkXHqfwCKt1bqNT2mr17YszEaYHTsE2damkgBk8A1klBgxoGtFlUcBqd4eyBjM6OwmWiB6CtyXI5YDwOeeB/HvI4wC9bMcPFZM0efr16NybuA/J10OgQ95Jma+RV9065/moBVBxKeafRw7hZRD338M1A0jXeGwCx4UdASekRZJGgbMZ3mLHB9odDv8JgPz3u5AoljpfJgKnTlimGqvsvKCiT50JOa9A5/ifv/3hLVOW7n6GmHf8+oGvZFfmvkFOmarYskEdSPsy1MTXA13ADDUiQBHfwyYcDT9ExjaAjESuIgRGMpj6y1vb8Tde4CjUnQdIhjh8+zdNC5JOdETsCS6nQUDTCdhoUWB2POaCzNX6GNEfC+wRFpwx3SRBUQsOm+oYld+sZ0wQVB7WGpmvCuEcFxKWRZIDuBYBc3jwrq+NoM9ksS5ejBLa7zaK9XsY2UAkxplUa0Tm30oOXvA6lPlCNPijsu7dcp8xsRR+/YNcGwP5evLE4BUgdQVsn/I6+gVDqwdNJu2/rpqBQ7uUjNgtWXmcTpgJoIhjTo8J9TA3eYK9Z3zcLERntZMQy4yaLDbAsls5O/ZP7eSZc/aPFb9/vXU0DgDC1c6hO+/kXiFFzTmIYFM/DcLdonSn8mj0p2/Gc+elIe+D/omh/FWNsTLhB+eMRirPQVOrlFfgPk8FNRm+zX4dSaMQ+Th+rM50qDXJ+GccITT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EPqy1ZTIjKcVqhnboXd7xGK2sR/1LljzrMaWbQDcGqUuaZb7+G7VaHl6fLa4?=
 =?us-ascii?Q?fP/Trvjcg6z7pljm5M647SZaE9Nb+0vNbDYHpUxKzyHf0nK0Ow0yBvTAgldT?=
 =?us-ascii?Q?CJUVB2khq2OyEH/8nBal/HPsrPZw74eVoGefs/8sXI4O7gVSsV8ftExCB9PQ?=
 =?us-ascii?Q?D6WvY6w0nv2knKhbgSQbLe48s3dP5GHv2GQ3Igd6C/9hZjMLGgNdpW3Wm4CG?=
 =?us-ascii?Q?S2Ol5UmKW2xyEYN7cB7NDZvVqlmzLeFz0kQRIRL9/VXJrZv0eC7as0WCp1Kb?=
 =?us-ascii?Q?CCaJgCGwu3i7l1javwTC8dW9oZcZ4bD+WLrZg6fThbGwwTrLVRVc2Vcdc/xG?=
 =?us-ascii?Q?60INWfDwdt0za9K0QiOmjoHarF68exF5nG8qNfnHiMol1bYyFMSq1DnWF8F4?=
 =?us-ascii?Q?D97f5+eN64YdIufQwRUZmJjsEjfebAq/wUqzdw1WwCB45IYuvkR9+1I/CLtc?=
 =?us-ascii?Q?KOs9JZS0p24QdFWQd8Jyfnxh82nCaz5x7iD3PM6fQS2+J7qh/eA2TsS8vgzJ?=
 =?us-ascii?Q?Wv4ZhPZmdQsrOfLAZYMWzBLEtJX5YQz09a3ekO8oGDMsBeZ9Wkwk0+PDIJIs?=
 =?us-ascii?Q?yHg1wmTHjJ+gtRMxaVxwV8/lUnILMfO7K549E+Abuhy/WlXcQircWXg+J4PU?=
 =?us-ascii?Q?42z0kK4QYVaHeCkEMrUla0pyAMnsD4eJsJ2MuZ9uTcrM+urcf/8akDazOm2q?=
 =?us-ascii?Q?h9XFLxKckdGlbL0sENJC/hWV4qBeNWSwob79sR53l8YniKXVic31dhXDLW+s?=
 =?us-ascii?Q?Ezi4WnSuPrQhllEHt8gN/F8z7Y06OnE4X/cY4ll6X+OP7/kvJvxFJSwKdtoH?=
 =?us-ascii?Q?YHEnAsSUpVQ/B3STdo+VX9U+UhkhDmcGPjNoo0yW6nxzktwrGtoEROg36ftc?=
 =?us-ascii?Q?Euq89qt0lrK66QhresMqzWTWXyKlk545+VjsVfAO50OnHMn/VMyo7386EpkY?=
 =?us-ascii?Q?ibDJzWRqwcAR35UFBvY1p85z+r1JAMK/3yVLeWD7t7hjFELxYCllXhqCPDjS?=
 =?us-ascii?Q?z6xVXUMzFMYlGTUOKXpiuxBYylggvH7L6XEhtxfgZts+GBEKaLtAtutxpZUT?=
 =?us-ascii?Q?XcscacD785xNO6S5sxRj2NUWGcBkbEPQfb+N7szwqIchwQugMvY/XXc0Qu8Z?=
 =?us-ascii?Q?wMHaiYy3E5x+6BbN+E1xvpO41tDu1v2mGB8/DgE6ivRtOhLL2hLeQmiVwpmb?=
 =?us-ascii?Q?+FJPTG0Stl3GyM6lZL/o4hvK4iRbmsbOyuf/JOpfZFjohfX6JML/Se8Mv7qV?=
 =?us-ascii?Q?I7eIQ713SuBimUZUpJPqQzRv6Ph59pPOzPxR5x4nJi5Aelzb72/pEe3G/THC?=
 =?us-ascii?Q?ih9l2y5/iCswxrKKCyzlSCk5lNb/GObZEsRIpyZbEuKxxIT7hlegnDI00vpg?=
 =?us-ascii?Q?fkIjsYEkEEEugBIXAntqVE19RsHiSUN9DR3eq6eVJcIJgsfaLf3RV4b5QMUC?=
 =?us-ascii?Q?eMmrqO4tNE2lu+/U7ZtkeatYsNz9P1cc8hwv3J/BySStm/pC7BI2a/h0g7xf?=
 =?us-ascii?Q?1E5qbCHyJAGbF0J8uVl7IgR1Z1fOD4ITsz4QdsIGaKMgsj/66tpR7rCo0IgL?=
 =?us-ascii?Q?oNwraexLLnJCqNiEGKPyI8bkWTIj0ncyUTp093IUzfPZuecNB3sTq67DnrWE?=
 =?us-ascii?Q?B7HzCsXumPczT7i2dl7lqNNW31B9XuZgsU3fYnPjOeYhm0/GZ81Fn77Trs8+?=
 =?us-ascii?Q?esF76DjE6IHWU8Z2cBeUvb5XCEHGWq5t71KJblh3hCJupNG25ckx9ebTrNCl?=
 =?us-ascii?Q?K0p/zXWuAQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9048fd-ce7b-4a1c-9d92-08de94925ce6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:42:27.9950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1xHobirtdi/4xJHsHw4PxbFx38DasuU3NsoA8W60pcPUOxsDtBreY73b0ok3fA1zSdcdF7lU7hQ+aC+JkAAPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi    | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
index a370e868cafe..0046b276b8b9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
@@ -456,10 +456,15 @@ display_out: endpoint {
 };
 
 &pcie {
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&extended_io 1 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&extended_io 1 GPIO_ACTIVE_LOW>;
+};
+
 &reg_1p0d {
 	vin-supply = <&sw2_reg>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
index d961c61a93af..3c5c1f2c1460 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
@@ -155,6 +155,17 @@ pcie: pcie@33800000 {
 			reset-names = "pciephy", "apps", "turnoff";
 			fsl,imx7d-pcie-phy = <&pcie_phy>;
 			status = "disabled";
+
+			pcie_port0: pcie@0 {
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 	};
 };
-- 
2.37.1

