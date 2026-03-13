Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A033C19E;
	Fri, 13 Mar 2026 02:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367719; cv=fail; b=MK1dcbp9IzI98rUjFYy9n2d72OBn1aQRz/89CQw1OyWTFGugoOribgUM9zQvUuPdUlC9EEVfxP1I1O1Ol49pSx0nD2jJ1hql0DVS0dkqh6WGEGxFXf/FDaWnf5TTl0R8mf7uIC4wHIKcoqbBPEGhsfREZcZtIMBTrb3dIAtAziw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367719; c=relaxed/simple;
	bh=2QrNdCAJJCRH6qpVacd7O539pJtn47HWWp4UJch0H+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KBmayMq4CDmwYn2HVaMi8kz5uloNYkBgWma3Vsrq7Ebzttpa+tgBqeEjZvTj82QckpI0iyshZLCe8VVPmLbXutfa70b/5C7LosUDQ3Yalrq9zNPLBmGyek7NrNeRdH5uLZFuSo4LWgaLQ9m+sSzbvKwD6Wn5v3inGhtkcy9HCmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FnWDfpMT; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FnWDfpMT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zE8PAyg1m50mP7Oe4ZqyyJ/Rm6BzBGZeUe72Jg8nzffHKPyFVVfCbGu6U4d+sluIihDufVyqOFQvYOKQ8LrzSY6Bzm45nVhYOi1uMQWKQ/H1Q6U/spmQK+NyteTHX7CKm/vMVqK8EFdC13AuOqCmMoorrWRyp/p55XycGa4cjmDmWUetz7MIqlE0fMvKBYxSKJn/RL7t8I3z0j6sLiW6X4n/SkBfHRtiqqYWIL4np9am1jQUAa7+VNiqj9xYCoXYFMEl861l2vZoAAhVJ7AKwSQGd3jeNd7q56yqUfTqglLAHIicH30spfYHEhfTKp7VEOM3t8rDKnJa/pMaWZaytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=rHBAajPZznDfvIwaOZK572OI1BNqZsheC1q90pHAnjNo3P67VYpBOFgIqcsS3XibnaLboYuSSvy5nbUp2suteA89W0cQLzmNi2IgvVYh3SyqaFiqgMak5W3348GsAHapwQcodQPYkqA8AjdaryTMMbG6yvTGlY8yJrgd/M/B+eHQrGWpoh7XdpwV/ghaEzZI13E2AU0d+aTovELOnKJsPvuaAXQ+koRC6Wo9sjVnINm5QFnKMCfkonQ6B1dmdvncLWFeOW9Q3MuskvKm5e4oCyzTXn38Jb9GlQBjHD3M/VBHujQqhOgBJquAR6eErqut9TIfh8v7gHOYVKzzHrrV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=FnWDfpMTWQBEnj3UctXOcw3LOUke/T3xAwO/vBhxBhCxXW2bZneKTp+6FvEl2QV07pV42JfA7nwOEM0A+ogS0s0nBZciSU/WVTVEUlvMndgr4G+oXHLrSHw0a20HPsHw1I+MpItQayLkRaZozx/MCRoC7jahEgSmhp8n0mLFBwVh3lDE01Kb1qW5Bx4x41bBYLnUR2nbp3/Y8jDD/fTmukJQdOjkwDKAOKlbzvJ0pfUnX3jJbn8p/FFHPhHRD3fE039pklYba9HgkFlMX+EnZJ+io6D9GfhKfyxEzufaQczeUUhrWU3zE29QvucbS+DBI1pwVOS8YxoPKwQ5V5FvdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB6844.eurprd04.prod.outlook.com
 (2603:10a6:10:112::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 02:08:21 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 02:08:34 +0000
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
Subject: [PATCH V8 08/13] arm: dts: imx7d: Add Root Port node and PERST property
Date: Fri, 13 Mar 2026 10:08:18 +0800
Message-Id: <20260313020823.1592389-9-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313020823.1592389-1-sherry.sun@nxp.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB8PR04MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 866d97e7-55ee-4226-28d8-08de80a56e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LjP6o5agoPv0V9MuKI6YwODigme/T7j/rok0+oyeCEWroep5rpGmTMMBHdO8ecLGyvYgTQ7U93BPhcVWJwI8nz+VwVS8B9u5fPCxVQdL4QLGMsCK73YNwYdC4S01g+boiOZGC3dO/MA9gGFOmehZF+PmK7y3EY0sFa86imMnFoVWtVGb8A+yzkXo3Pu18dxFG9Q6E7Lhsq0jmIsLgMLhOvvwSPG2dxb8jVv/Ev7N72WekWUzFmHGAd4SORfx/y6q2sO/8+nXjNOn6sh2oOoTOqcD4q5iTbggnD4pYEyGc7uhW49ZMTnc0LWXqzjNcyMrVE1tGqM3WyCNuC85CBgCwd1YW18+EhCllsg3HxPk8EAyL8vHW+vCaUe5mb2Ex7FohbNOT0QNoX4uxqa07PVC3YIwVrx6M+Vp5sQTu44ul3l4T65mRm+TeVKg4EczlHBuVYaYSOb0O/H9KKvyuheVJdD4yB9ljp61XiHy9qxjb4xZ1ldsREgfSlNRtcPi5GnEMxmCSXtPLZstYEYEc/YbI+8u6yRh27TyI2rgVRHBI1coaeY7V1RzN5wgpjYsJIPifqYTNGODlmTFh6Jub/t8qR5E7Lg6gx9ZaqARTUHS1KH1JaSuL1js2YiTUA2oo3lQ1Bi+0mBC5OQzYPNC6ls4Dg0RSGMPhNiSJqchvKJyDyVY97/lSylXYXtb5wHPWvUemAeytj9jRJVQ4IUaUBCenXQMcHWwDcwB/8cixYqHafMyklj05/QcokLMvfFNXfZ6zFGr+rJ+1M/mxAMErD+ho9QUW2rUTdiy3QYfCTE2H4yML3X+eFH1c/bDwJy8rMu4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?819kYtx8TxzsRYGHjDcssXAtls3oZ6TmdLmmGqXejdH3XYdCSWKvexlcOZeK?=
 =?us-ascii?Q?sLPnEQA+wDV4UuIpf9M3mM1+G3zR87baTLp8OlbS00AoVvYsx9N8ZsqZ5I34?=
 =?us-ascii?Q?9QBdb+XkhDkl5V4tYTAPtnVDxCshsTwWOfIMTo8eNnGVgEgCuXAb0F6hn1Dl?=
 =?us-ascii?Q?XAniFoF92GNDlWdReMmtb1I/g8sjUmiymUmF/0U1qOBzRiD9qFNhwLHw3n6x?=
 =?us-ascii?Q?QdGhdZKwtlSG118iIiy73AXe/FknZrL72gMYjVHqeFaKOducHgs6VD7c9oo2?=
 =?us-ascii?Q?FTccxWO4nS10xHQFvXZvODqVijDzkZDalPnxymVgsWO0k4nFwf2APhEc8xn6?=
 =?us-ascii?Q?owZZsBrCOl6MHhIhKMovexVgnjhmnS4OfduAJ9vLvAodK7yMrmGBTyBhM4iK?=
 =?us-ascii?Q?NdnR24x3Tr6xc/bq2Jk+C+gUtUCZo/RtTG4DGMgaRsHV/7UjdW+nAiP1W73Q?=
 =?us-ascii?Q?vLalZ8sItjUybjryvd+KrNN+Xhq7XeDz8j+U1vLS3QDEnMiDqVTb7SholWdU?=
 =?us-ascii?Q?FQ6mkc+teAQHVUNRasQCI5DCBf/F99IuMdSYNdrrKMAk0xbUfRtQ7BPt/Yca?=
 =?us-ascii?Q?C0es+DcvU1cT3D59PzPDKfJlnCTEgmBXDPYeFAMEgZihLQ6lrs6u8FzeodDb?=
 =?us-ascii?Q?83kXRWGjKfIGhH8giXxqXPhpB8XJwu0aeXhaRMyvbp78DpIF0+MbWd0khbGH?=
 =?us-ascii?Q?c+ARaD30sGJaNOuqMlUEAD3QM3wYpoTd90VJzGkm3Hl1p6XwznqYccN2vlxA?=
 =?us-ascii?Q?HNOyLxk0RbK9ivQGCvrgM/19eXIpy8DKVa9gm1uoy+pJITUDPy+skYCwGyXx?=
 =?us-ascii?Q?8suzGK+L11uRDktVoa4uxz4cQyCf9sedSl/hJtdRUVGE7U08Jb3LshbGQEV8?=
 =?us-ascii?Q?DgPAFXNyGr5+OxKawoohfzMztIzUL4TFaJuErCmJJlqsOKbsgXsn2TV+zSMv?=
 =?us-ascii?Q?t0jtIZiiPc5COam8arfJZSHBCLvAHp8sHMWVfP7yHMknt7mnQuMaAJxTqvvw?=
 =?us-ascii?Q?AFhvxTYl+X94mNjWK6kcWIXzFx2J+/M1cSEoC9ce6yO4dOGPI7zGSHYnjsCH?=
 =?us-ascii?Q?FpOZKyWOsqFlR0rUfk3m4lfWcK3rHT2MR1Eu477mDrKKLXE2HL2+on4zXPyI?=
 =?us-ascii?Q?USn+DisZkUpiW3PmmQ7PNUZ/v4rDqdc24KAeiY8V0y0fwOciKLjW7qXoWokc?=
 =?us-ascii?Q?4UJBRmxt+Ug1qtwOtWf5NOWPd9Omx4xr+eowYerReCr1ll6AW8yzbhozu3vd?=
 =?us-ascii?Q?5rNhU02eRML8Dj7m6qPiWcz6z1jQzC1+JxnnPJvUAD7UNPyKmmq0s9BbSQCj?=
 =?us-ascii?Q?G7j4kDogu0LKzqhuGOuHTLf4F35ggKg63iCZGabxlVpYRKxM9HK6d5HuZ94t?=
 =?us-ascii?Q?oWyOdyP+sTI+O5pSLRlmcwY04XC8UJCf9n5zkX2/q5sXvG0FNN3ZSujfjZhD?=
 =?us-ascii?Q?t4+pLOM1PHWj9sszzPXXOsC3XzVVybMHBL3MD5h/S6cocelXMMtRZPBZOehh?=
 =?us-ascii?Q?4p93nh/UiSaY4PLBBZpGuLu3oZ/DMbFC8I6LgAW+dMmaS8IKPFDjHhi9i1Gw?=
 =?us-ascii?Q?pQMf8hK+xc6I83SAHIxbWwAHaRCp8Eb4DMHcjvBApAnd6TZlcbbZrkx4c6nw?=
 =?us-ascii?Q?FGBuqfaoRgcN2PnI977HX4A+m+cHpkexTUiTaW44i2ESOL69cCF62SMCIEBC?=
 =?us-ascii?Q?/LSUf6QgS5mUA5koj2+T6LY3zfkxUv72AADPFYg39GnMTPilDa6dKTL9lTLP?=
 =?us-ascii?Q?4YGsajDIyQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866d97e7-55ee-4226-28d8-08de80a56e60
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:08:34.3610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPmygbub2oGgFKQgf2FErT3wvvr6XWzdJjwdqQcIguYqwglrFZAAIdFpkTUwrx5st8i3/StFN6Cl85ya2mEC2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6844

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

