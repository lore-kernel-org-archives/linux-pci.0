Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3673939DB;
	Wed, 25 Feb 2026 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016907; cv=fail; b=QcluzUAF/L1ifAAUPPx+tx92vZm+Z3HKIyu3COPrciadzJ6u3XxZAoVPaCxys9Lb2RBVn2AayMAlfxUWz3euH/oaAA4VsyKPWV24k9NRlie1AnN+g0EKWAvYGF5MRgGrkcYFJTzdAlA3lztGc3WhX/jG4YTohk6bAjWNLdWdz3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016907; c=relaxed/simple;
	bh=Yd2rYyVPnI/NtPSUEej2DU5oRYD3WYLyjDgR2A36ykM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2Ltca5+DyuvKsU7m7tQOxLS4/ngPHeAIYVwYbd7UzdNwiynvd4qYYsEQZQ2bTU+BnnNfEru6hdH1RWoiwjg+ozcK3llbuVd2QlLbDqK7ZY7N3EF1NXPM4N/472MLkTaWBJdvUGCRmOIfY90n1PSloddD/Fg6cxuYuqSq6ESvw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lnjptT2X; arc=fail smtp.client-ip=40.107.159.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lnjptT2X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLLtdWR+CvUDh/HVi12whsf9G9RNBae4JiII9V7wqmGmDR4r6JRrJjthWHk8qeV9QKLb9y0skZKU9hHTfRwoBF/3jZbq517KFpIUWAeAOGuPbGxoIeZRnvSdf8BMX5oEwv7wZWuaC/fR244EETyqrpeFURHZNKgRC9z2Sl1CEiwaF6/tRmv5LxQZX/zd/hWmrj11ll4GkGc/D+6HxtZkwVbUHipLrP4gNLzyJl5lKFBXy7S/xiH1rC5Y3q7uY0M+FglMYnRato0sW+6yCPF9D9KUsjznuyW71wkDyVMdU3v5HyZvWBJVnpn5s3rhW1QBZhkXXCQhyey+BtJAE0tkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gboInUYbdyhxKo27lO7q9QC8e/h2POTBxZYRuF7CkfI=;
 b=nzxQjKBHQzHgK5DvobRLI6tJ36TosSWhHtcuRa4/+rb0d52P8aIV7f12+D2AsF2MfZYwTZ0WovTbxAwLZPrr+ZRTJsyoDwmQEj4RG+Oejm6j/wgAU/qmzvqyngZUmt1qPhJVUBqRXA3002UMklAynJUqIO4RF7oNb0Xad1Aeulj/WpxgdUtmGjNCvwbNeBIwX760b5UY3zdpEWsRHiT4bRovK5/UEQRQLtCZKOWIgu/YQ7g6Kfh72TnsXgTI9HlJMBbHjNX5y/9FjQFad/jo7E6xPA7aR+Z05/JO0qsTI2HUMLAkdtVndEUO0Oj4G/2Js/7yT0Ab/85STb97yBOrXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gboInUYbdyhxKo27lO7q9QC8e/h2POTBxZYRuF7CkfI=;
 b=lnjptT2XYR5snLaD3idqB3u5ij1fB+4Hewv5ZKLlYUArXKuQdbovJefEIayLiWcWa1Zx/5tZvlp5F3jzXDqhf3KFX9bvtCXDyqRvR9mmZqP1Ol970eehywxlfunZWwl3diYbT8RZLKmsD3LR04FAVdDwga7A074NSQ/GaH9s1w4TxtgM2oMzoEY5WypZRWUjT3NxgttQzKKAgptQfrUAcR7tgJMznYp+lmCEVp19MRnMfBB8GaQNf/cZ4JtmXqJLfdJgq6HcKJnfNEiV9TMFo4YQGZ5D8kho6o8+FzVqb+jQsoMXFfmSG6VwjfQYHw3M50xeeYaiOcj+S3gi4+exNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB12224.eurprd04.prod.outlook.com
 (2603:10a6:102:561::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 10:55:03 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:55:03 +0000
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
Subject: [PATCH V6 08/12] arm64: dts: imx8mm: Add Root Port node and PERST property
Date: Wed, 25 Feb 2026 18:55:19 +0800
Message-Id: <20260225105523.748775-9-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260225105523.748775-1-sherry.sun@nxp.com>
References: <20260225105523.748775-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB12224:EE_
X-MS-Office365-Filtering-Correlation-Id: b90b7460-dac8-4331-de28-08de745c540a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	hzSRHShOZWB8BTY1BuNvfzMGVoUpC91bCxGhZcE5cEz3EneQnJQs7/oNsWvpIjRgcVFGXts7vprJuMg5W2PUmkTmgkI5Pad90hd5TiUF5iL0Gca6Bkb6pP+eI1W0YecAUmGMOv+KrZmvBpSGdMRp66OhPmIP4Iivt5Ll85l66aDTz8p1EMTVqmHqQIcY7ozxVtY9NCUSFAc+R02N2u5gFxtOBJsvaLfvIs4US9nfQT4xOIEmhNiSqlm2OZIHLqGlPaaqXtp/Z2TfKqg0jX8n3FdLpfU49dWVzPfPw92zqVmC3gshsMnrKQ8AUwakcvpYpHfboT5HPSy0UIjrbca4bS6EGwJGNSuJvg0Qvja0+fjyO+wZHOtB1BTFinV50GqF7Vq7F3vg+TqoVchOniwWDKHIID56+ogpa4R4o1QozrcaUImVsK2lRxmQnBrXPThyBKkG1Il1z/vmD1vBzyeHWVeWOgacuqIY4Yooy0nBJkLf+E8I0CrbiKiBsG8bc7KqLP6WWMQ52pq3JC4a/LhMUWaB0+ZfdnmNxRPDXNvNu8n/sl9YNn0ZKYCRHkgzpsT31zjuwAFqnsR5Rq5TItEqzYh+U//ESM9ZD2MrTp1w1Th4/GbHwSsyrvmCVLeglVtl1Mc2QjSvrmgQigpwBw3WxeMScC9IXEQtD+MokMxz3XVyg7A7Pv6ntRPefIELuvOQ5ovPMqf2xjyRom+8uOB4nP5F/z3W+JCmo+l6KPBXQyndUjejWuWLilXPlZvDbGqVBJx0Ezd1idbVVD4+3/M51fDCV5HT4kB/Awyc0MuMLiwAxlpWwiDg9N3zZKShDIKz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QakQdlljSa0LoCsdu0qqQWh8PIAOf057rjcI32kWs+zuYTAle0jIaRjaOfgl?=
 =?us-ascii?Q?2SLxrXr3Q5Nyj/nB7gVTDm1RP8DB0k8bSq44srRJjJO5iQQ2fYV5OuAs6+rj?=
 =?us-ascii?Q?bEFsm4aq+QZ13tLHK1RnURIJxNch9Zejdo+GYDwXz6dfJaiGhKRQrYMHDlBy?=
 =?us-ascii?Q?f51cocou7CJ1TKNpU5kEQVjMjZNrUnHK6KM6HU7/62qghcu5NiVDl2fHUMWj?=
 =?us-ascii?Q?mf2XPxY04R8lPmkn5IOiKGLKqquLffhxPADEPN6j+671oyKzz2tFEteXpzKF?=
 =?us-ascii?Q?Bpo5ILl+qlMJms36qtZKNmI3RKo9t5/PHC+YntxBzgHi4ZGm71rGWsgk9Il7?=
 =?us-ascii?Q?79LYQtoB17pKjPZh0va9/HJkQrDwe6duYrFX4mV6S6D8hp0PW7LVMF1Qqk0J?=
 =?us-ascii?Q?n+hmSlmSM+iGidC67WBygJYVZOCJOoyo0x8TxpwxUS2jAMRhJax9Zk7fmaOp?=
 =?us-ascii?Q?FuhgZf+2ZBX/korc/YawdK/iks6Y9FXuRftsGoR+CFrLJlUWBlAZjWzcgAqF?=
 =?us-ascii?Q?wxAXxdU8gIv28ViM3tD9ABs5khOD0LFBLZtSx0YXc68XW2nugZ9pfd1X8eL6?=
 =?us-ascii?Q?7a2Wu11OUM6mpuBb0FTtASdkXpkDrrhpMvRPCnCwMyhmxEtgVBL2+cbfEuSF?=
 =?us-ascii?Q?hwBMbdPW7pzKsfxVbR/SWsj9VKOHf1yKZF/X283qAAikxHpJxN43QgqKQ2o7?=
 =?us-ascii?Q?y2+oMelgu/1DwahtCo6/0+PpDeJkdzQwBonPk+7NGzPZVBL2C6jZbURCpat/?=
 =?us-ascii?Q?T49fOXB0i7hewLbAbex6+mMd7BdcIX4/kMscJPZeEHLw0Ble+tUBUr1qqJvw?=
 =?us-ascii?Q?JZWzyQLE23L9OBr0A5dsIajr/vmpWvP0RZjJMJlxn+pUXBnszQvb//xf4j3i?=
 =?us-ascii?Q?DEcMqENsHgIVWvpSnRwL/sKx5h1O2Rq+KJ1MrU3mOQFkuDbqxoStdEPeOSbB?=
 =?us-ascii?Q?A//VJMnjuhdc9cLKU9RMF344Z/GIvh1pt6jr3Hikb7Nh33u4jvN2IylX6Y33?=
 =?us-ascii?Q?9NbLla/QJ9UPdNJKeaRHSwM/7fPI6/bssKTLZ0WZ753jftZnQx+epRw1s8uj?=
 =?us-ascii?Q?pMcgfPuQZepwkCpafm5E03mCz1yHo53zF58EdVtqcQ1rMXTNKbiJldOHXMB5?=
 =?us-ascii?Q?HssfUsNJ962JzAoYK58m2xk0NWsDj4PEsMmRDvkn0vEwgBJdR3d0LUZaaVCZ?=
 =?us-ascii?Q?rBSi4V2e/eguGMbPochJ02IGjxGqOdkr8JUThklcmvYlL+QOf2529pVRI1/s?=
 =?us-ascii?Q?6d5zuG516UmkmB0ZeuAcOh9PLguxmvDINNjqM1/dEgH3dcbU4zcpG2zNDzx1?=
 =?us-ascii?Q?3R1cKq+PiOb/hSvJH4i1g5oEbEPha6nbj028KP3gNhnh2Gs5vo6ROw9Zot21?=
 =?us-ascii?Q?PO1UxNuymnBfYDMAFCwhoUkBQzQ0wHdfBG1J06PQUbMeLuHvt152kh20vAzf?=
 =?us-ascii?Q?x36U6q2R0EWr38rY1On8yPHwaff7xgSKZTLtfqXx0GyRMOcNqV5/HtIhmvet?=
 =?us-ascii?Q?aW4/u8lrn92MWbx5m9hYIbJ/Ca8bA9pAVzhx7v2WVM3T0tRhfCQ3mVHm6G+i?=
 =?us-ascii?Q?9Y0BH+QcE6sHzvL3lA0IN/OZX2COCQ9H8F8xIX6OILtjs8vFwo8KwIQ8MCmh?=
 =?us-ascii?Q?CZLI4YYY5ap5E1AjsEOix56Xr2kQkch557izxdyKE2VzYXOt2DzOjvpmfi+l?=
 =?us-ascii?Q?N9FzoRhMwlypRSNj7n4/b80tCt0mft1yZel9TQCihULWYfTtU9n4Q45etTX7?=
 =?us-ascii?Q?pVSxFFbjQA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90b7460-dac8-4331-de28-08de745c540a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:55:03.0023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CGXD7KyCU2DZ2bVlc6WFGd0u0iUP6QLAu3Wyzk+rkV8DK1S51aWl5txQ5cADF9OHwmRVw7HpXQPqS3CAu+uIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB12224

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  5 +++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 6eab8a6001db..060860f24e7a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -533,6 +533,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&pcie0_refclk>,
 		 <&clk IMX8MM_CLK_PCIE1_AUX>;
@@ -559,6 +560,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+};
+
 &sai2 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 9f49c0b386d3..1204cc4d3f37 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1369,6 +1369,17 @@ pcie0: pcie@33800000 {
 			phys = <&pcie_phy>;
 			phy-names = "pcie-phy";
 			status = "disabled";
+
+			pcie0_port0: pcie@0 {
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
 
 		pcie0_ep: pcie-ep@33800000 {
-- 
2.37.1

