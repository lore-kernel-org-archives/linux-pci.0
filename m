Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604A53F5BEC;
	Tue, 30 Jun 2026 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815476; cv=fail; b=VIxn6ObV4gvd/uCnFRNVUAcO/Bwl7d5s+kjsrluWGLmgqgvvJoCUr5B5eqNM6EAw03uMEI+ZTFbL/lqLOGQRM52SM7Yp3FExiyFdJrysyxjbGaK2eRPCFn4Qna+oma2whkaCf2A5lKJYENt5TF811GFWOIz0ccIy5wLXU1Tvgs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815476; c=relaxed/simple;
	bh=ZzGWQgwxlWd5NSMPsOZbed3oQhpWw3p9J3uB1Hrk9zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eVeLpQiBSo8cZzdOTw4/jbpX+sVofXxogKw53bOXx/tUwQ1dqWmoTFj6MCExwR70HhaKvIren94OJ29ieQUdh3x9Ie1uF2e3CfcU1N1/dK/+X/srlKknPPURT19WqhM2pcJOJbKT0Sly4IXPJgHph22eCo+JXMOQGBdfUCyfBs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=d0RNH07d; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d0RNH07d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQU2D5rCfKddWnN9LRUgyqTE/VSJ+cwqnmwE2h367cLP6BZ0QhIQ1w4DIQeDvsBQ91oVGEt/ZXIAmXe0B+lhGWCAzfi/pWxgysTRBiq47JkaEhFccPJqmN97krCEdSfqXCi5k13L+MJGujTd+5GoukmOMGaAfzeaDhgP1SIL5FCPV8NUXFii2ZB8QFQXQLxGcKP0Rn0nHLV+8J6nQC+Cxxlo2Gc4FCHYPj6dIu6ZkDkCmMnnj69qEVIDIWplMrMI+rv6KPVK953+NMvm+hmTcM/PkxJnDkW15omOeNbrfwToKBSFm+VZC3DweFi3pcGz92lY9l8jF+m6Ug4Y6xL6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mAKWOnin1FZz+sGw+5Yw7SMfBJtCVqx/NgRpyQsAy4=;
 b=ESFsyZLo5kvD1xupDKIW1l5E4l1FRuVHc3tltP9pR3fn2AySHUAvG74m2Ta5PT6yUJ2A3ip3udo7Vr7cmpAvuuZ+ledscjXsb3zqZ7NZt5aWiyeXeKaD3JoWbdeA1jzXYOfEcvZ3qsQxs65wUgyotGoragtkqLnLnRTgnD5BhZy2ZBdcnxZm9nkg8AbxPun5x710vPD7BoyLae8Opo0GGxYW1G7atMZpE1QBa1yiVbNnrfaa6jv3aoV7G1qUnkJmylYX+XjNfL+/zOUJtenp+xIdNfKrF5nvh5kEzL/M4f5M5p+wzfsOgVXzpk2jt5XoB9Whg+FyvnvrxtNDFapIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mAKWOnin1FZz+sGw+5Yw7SMfBJtCVqx/NgRpyQsAy4=;
 b=d0RNH07d/MOBSulJ1QwC8zM3HurQ0nv/OUCwIUZagmJUH3d3mfK92/4dUbgTDyDJt4Dlm/bRTgsZ5x3iinSOwC2e8wMCCLIrwdDsM4YfNCOaXEB2JCoMaD89eAzAwhagNrT+U+qkblmNZdHSRvppJjuSEY/pji7bSDluVvaQvu3EDrtnFgP6wcKweiDsW20lFY3fF03CotBshJ9wj88423f1HhLXQs9+vYtXEL8nhE68lyQybzHoZM8CyvcgUWjhxCVUZMMix/qEwFC4vcM9iS62+pfxj/0VFoy+JnfwyPe8y94khsesI9PPianS5JleTKkogEBsBsvQkZomrZ7eNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AS8PR04MB8547.eurprd04.prod.outlook.com (2603:10a6:20b:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:31:12 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:31:12 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	brgl@kernel.org
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V4 8/8] arm64: dts: imx8qxp-mek: Describe the PCIe M.2 Key E connector
Date: Tue, 30 Jun 2026 18:31:39 +0800
Message-ID: <20260630103139.3823329-9-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630103139.3823329-1-sherry.sun@oss.nxp.com>
References: <20260630103139.3823329-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AS8PR04MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ca8b92-acdf-4f6d-250a-08ded692b4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|23010399003|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	/If2+2Cv0QmHv79VQTXjtYtIlcbhdhkRjO3UDfbMsKCkssejMyqX+53egn2g6gFG2FciNV7pdyIgWAk5b+Q65jYbZybshJkpfxqCA4OqrI9nGhFhloPeJX4oRv6uhGzKyDU5n7KO1JehlQuUx6vi1uhqSVHZhhA/yQN4yC5eRqNrUFVwcfzKn89XYMCRjpWp4o/dm1RRJ2guhhhj3L/c1JslHYqmAT2vHnwL23KdarcXrJfQxaTAxiE2FdphExg14xlB5XRYY+jyYM08Cj0VYqge1uupel716SJzwBSUooADUEq+hNOe7HMDMpPVck/lCn2RJu056ot/jNwNNqmYdKnPDQmZfAwEwB2JtEYRIw97AJFYq+ASdFkXVYJD0+4mmiXtsJ0ORAeGpawrR/JN8azfsu+eSjRJ2k2cSX/QnRzSf7pwXiOi1TRd9T08xFRwLrRvrKF5iP6yuI7tF6CL4qeaUEQz0Z2gZBzuobKo8CZ2nu1FXjFYvGzfxf7S0HddtrXUVO/vJ5NoS/pPTW71P6gMHNv8dDCjklLX2l2V6KhzKg51tWuO4BI1M5uteFIwWFQlC6XLW4CddGmb6THiocslCIxv3jdA3mO3AAwd+56mQe4YN4ms7Biq8bmyfH7TFczPH2WwtkqaGIxM6zw8eW6Np9bYiOixCG9prBF/CyGWXjORHdJNqJbfo+4tDmHZe2Bth8CKpGVLpn9letSWbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HGl32/umGFyRPZYAsowpnDrtMzLIJFzVHzptpxDbze7eUsVRjg9xcxFl/332?=
 =?us-ascii?Q?x+uCoSTvbiFpLmcmnLW8x3m7Lt+y7URBY7ayCD8Px78aTCxpeRnd5IAsQBas?=
 =?us-ascii?Q?HP7uPEicc3uiXJXjaWz6gTv7Z3tlIID1+Efo5nuV1lZ0c5lbaQLEKbxEPSGd?=
 =?us-ascii?Q?ISnWLX5szWMjbPECZxLQFJAoNwCTCxuwSlUsJBb6145/bjatHhHq3nhXQ/0m?=
 =?us-ascii?Q?1runI+TwNe320OaLv0Y8A7KxSsMqK/DzKqjrArDubTLYqWIo/8PqMSgzy3tj?=
 =?us-ascii?Q?6SLEO8OHCX7vLCIOKJxHdaKS1+aqo35iddIVgqCFrwhXVzsUJe1QTB3e4E7h?=
 =?us-ascii?Q?r+IYMExYU2jMJIbaVAIV3y8eKi6agiXozpQNRMmQe9XghQy1p1oL/um25/bf?=
 =?us-ascii?Q?YA+7upSoRPw4lEeQPxeC8N7wrj2DzJQsrd+3Ip2KrUXi7t5prO4HlHOJ1KWn?=
 =?us-ascii?Q?ZeeXMVp6gzTGySJcxPchidi16j8ViHAZM58rHjaxEGhkNURmDq/S+4Cnr3Lg?=
 =?us-ascii?Q?+fEsrDjiCb7x5sWg5p2d4iVvUYkf7w3dXtVigThy7A5imAzUpgNnT17Rufo0?=
 =?us-ascii?Q?2Iw8fg77R/iJj4d1vcof+idEd3aGjVWS7eGn5bh5YmxPymnv91y+JYA82NUi?=
 =?us-ascii?Q?JstcPeEVEr1kez+1XOwXdzwrAdDsXyhvLnC9i/GtZSbsa6rdhoWqjzHyQpfe?=
 =?us-ascii?Q?vZW+T+pGiPzCJ6xVMonHllx/vz5k9Uni+UoJ+RHEGDXNFlZux/C8HEFFcuDA?=
 =?us-ascii?Q?6v6xz8RA7XA7XH4AsR+4u3zW1TS/7oR4utt0Wv+vMTvM9B45r4QwkT5HLFqI?=
 =?us-ascii?Q?A99MXEhiMElNRUPPyQT/HaDFEH6C7S5l3CCofRZzZT8aGINPD3fen2eA3xac?=
 =?us-ascii?Q?c+FKMjzqxCv9f4ii2582K8PQfGj069fjJc8MtfFxYrb/doGPHjdS1MS8du8h?=
 =?us-ascii?Q?/zYB/UuhD2x7FwoRn6Rt0IGnUScQ+e2E1PFRt6z2CDnZdxLA1eBQWjcn+ftp?=
 =?us-ascii?Q?68seyutwQBkJxvLyPZ0ekUK1e1ql9mWEfjfZK2dR3EOTbb3JrPD9GYY3CUkY?=
 =?us-ascii?Q?A7KqJcipRyH68mwvAZ/c7Litm4Ndz3HOuUk0RytjK6Z5PGWFPdKxc26NQKEO?=
 =?us-ascii?Q?fhxXcvhYQao2YfSW183kIY2bUtwZE5lG7PAzp+9BYU7oQ913gKUl77R8bJzz?=
 =?us-ascii?Q?LW46HtMymAQrXxwOuPtJAXla2GWqY0gtXJPEPpWgdl9VGqWQXgt6/Tw67wUY?=
 =?us-ascii?Q?9zQe106cBgxHLZNMRzDJnzZd0k4gvsBiQhVHewKfK/+ukmR9HTBN1NqOZ5GA?=
 =?us-ascii?Q?cna+FjwZMo5yIx1IDRBBIrQ9rvmf4gHfxKJrRDhG0t91RVZp5aQzIPGPS+9b?=
 =?us-ascii?Q?ZWJSvjsqWBOpjP3xOsbL1OvX2EtRFaGzNn+sUe+KB0zEupclHmqHY4DHZYai?=
 =?us-ascii?Q?U1bOlxZXbV3rsSeH1F0jkm8kFxFaqeGaXgf/bphcOUV833OdztOZ0j+jPsvh?=
 =?us-ascii?Q?ABShJLQmkeLB0qNxLfllWOdoSt8YU1r8qjt3QtfRUz3yNbdt6MOs2I/P+Czy?=
 =?us-ascii?Q?pfzf/8gi47VeFksKHHaqIdbGlEdH+fhguPqZvvPWo3IyFqV3ZGYWgPYMzGIz?=
 =?us-ascii?Q?G95KqlfZ+QqFiA3MeiC0TAeX5rezzvftE3t4JiyTAAKvKoAB2bCXE/2Z9HE0?=
 =?us-ascii?Q?Ug7HCrdTmWupst5z5yEtdHMhf/R1LjjV3/H/ZV0kPMIkDPkK1M8RLm1HYF/p?=
 =?us-ascii?Q?tSJr5uAJrqdpu36OYH30aJTBIdV3gz1kZLDlB+8oMyz9nhrSdoga?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ca8b92-acdf-4f6d-250a-08ded692b4b0
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:31:12.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCQgPofzb9dv/iWWrs9LDFzSlGMMC1kNETxA/pKwAgbwmklTCizQq+we2Qe8k0NsVuQ+xOpJ0KKc5oxN1w73YygZrvda3xzQ3bUrgjxGOWz2H6MDnZ+S5yU9vC3f1A9t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8547

From: Sherry Sun <sherry.sun@nxp.com>

The i.MX8QXP-MEK has the PCIe M.2 Mechanical Key E connector to connect
wireless connectivity cards over PCIe and UART interfaces. Hence,
describe the connector node and link it with the PCIe b Root Port and
LPUART1 nodes through graph port/endpoint.

The M.2 Key E connector is powered by a 3.3V fixed regulator
(reg_3v3) on board.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 54 ++++++++++++++-----
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 5ec4082bd43e..c9fe4034cc2d 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -40,6 +40,37 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0 0x40000000>;
 	};
 
+	m2-connector {
+		compatible = "pcie-m2-e-connector";
+		vpcie3v3-supply = <&reg_3v3>;
+		w-disable1-gpios = <&pca9557_a 2 GPIO_ACTIVE_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+				m2_e_pcie_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&pcieb_port0_ep>;
+				};
+			};
+
+			port@3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+				m2_e_uart_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&lpuart1_ep>;
+				};
+			};
+		};
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -157,15 +188,6 @@ reg_3v3: regulator-3v3 {
 		regulator-max-microvolt = <3300000>;
 	};
 
-	reg_pcieb: regulator-pcie {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "mpcie_3v3";
-		gpio = <&pca9557_a 2 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	reg_audio: regulator-audio {
 		compatible = "regulator-fixed";
 		regulator-max-microvolt = <3300000>;
@@ -696,8 +718,10 @@ &lpuart1 {
 	pinctrl-0 = <&pinctrl_lpuart1>;
 	status = "okay";
 
-	bluetooth {
-		compatible = "nxp,88w8987-bt";
+	port {
+		lpuart1_ep: endpoint {
+			remote-endpoint = <&m2_e_uart_ep>;
+		};
 	};
 };
 
@@ -746,8 +770,12 @@ &pcie0_ep {
 
 &pcieb_port0 {
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
-	vpcie3v3-supply = <&reg_pcieb>;
-	vpcie3v3aux-supply = <&reg_pcieb>;
+
+	port {
+		pcieb_port0_ep: endpoint {
+			remote-endpoint = <&m2_e_pcie_ep>;
+		};
+	};
 };
 
 &scu_key {
-- 
2.50.1

