Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9369024468C;
	Fri, 13 Feb 2026 04:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770955718; cv=fail; b=F1gF3GPKr2wCLlsqGZJqeIe15uaZoHtxXg36DwfqTyntX+Zv+bfpWnkPmz4g/Tl0NQ53DizSPCTfwnnzZszQ3MJGJhyKM8DFb7RLAo9mZPLJQ1drDaFwEt9xd0RCqHNfSUbuP10XDuMH1vLQJ1k5HBFEn0tBB1Yka9Mqdh8QnsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770955718; c=relaxed/simple;
	bh=2QrNdCAJJCRH6qpVacd7O539pJtn47HWWp4UJch0H+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=syQbtGm1QNNJuhRdHCz5fHY1f6WMnEkR8MzyukJHGGF0uZnOlrHWvzUaFjeBLw7EjoIfIRvyjal8FGX9l3dWKYm+NNQdY0YXK9JSe7JNR6JFj7h08cZThJNvv5gC1XXBy2MnM8XOWk6Et4N+0m1xTfBmG6+VCUsYLHDFEZLkEko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e+3sHgZT; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e+3sHgZT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPVfk4i1wPkPGJRuvVcZVItZwbNONYOtZ+QQIEaMtTKUsXWrn1oTSQ2tTm21Kn61ll8+WyEESfVSfVf9xxfFdXkD0Sgqoo7D0qbbqtUuH0LAu59qMJfFniXjo+WgoZk6DBJrsdFwVte//7kcOL6ib5Zj1K0l/sfRKk4RCxh8vuto5D7ARS7ez6xp03KBuGWFdY84YXdrUlCmTkTh9aCqdkJZCtiBBS+7eyVeLHJsZcT7J7Vpm1Xv/LDM4AnYVW1Vcq2b0i+hp5z/T115jiDp0Dl6b0ILQRKxXHj76juX+CscmCsq3zCzucoe93+m5RR1+P7b4IlGXoLQYo7fsxUrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=Mu08bH6vPCfa2MMab2pG7aT1C4XcaJ7dtH6GnuvLy+SpbZl14y9V5dmQKEn6IQ3DLFqlRwZ+9s4pJXL/8KvMbtlWFOF0mQ7LAxzhjGyBy/jp89sELyxcL3Gb/aJDY+GQ0E71Qt4NH1Eceam+loQHfy5gHFlYEVZAT00RB5o2S3CU1T6rim8LYjTRJUGu8HaFjkmCMFDcVq+hB5ebbXzvLy1wbNsOLqhWyYFI2wXBeYuonDVg8tYyiaCA1yszNsIraH7Owjp1Y20DEkbgB4yHqw+iAEfhN0SYueSH1tz/C2o3sIskSrvykZk8DlvNAQUJhwCTYxoDCB1YNnRCbkBTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=e+3sHgZTUWKWjWAvnUnpMq6U3t92TbGaKBLt16Y2PeR3RFSdlO1KMQAvLHPNltEDv5Q65tpJN+9yJ02Q13r7JyX0ORwRFLmp5xfsJVnGQbQeCoL7G2obUSWIk1NVd3OyaAyo5VQBa5a03EZ3lK7UvYJqbORKKmZb/eWirnRjGGJujK7BCWYziie3LsaiIPTm0zuk/DU+YqIy1Dp+RR5h3qgikzc1tcRFHfFHhFoMb3zNYsD+6wD7sxwCfQi3fqwxP43yS99j1o2SH3HEdpvpl51m7knK4uCf312Is7q09rFDgU1nUcliWO0qKxh8C4MF1lcYWGAPQuwCfIxvBZ0NtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB11900.eurprd04.prod.outlook.com
 (2603:10a6:10:61a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 04:08:35 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 04:08:35 +0000
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
Subject: [PATCH V5 07/12] arm: dts: imx7d: Add Root Port node and PERST property
Date: Fri, 13 Feb 2026 12:08:47 +0800
Message-Id: <20260213040852.3340547-8-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260213040852.3340547-1-sherry.sun@nxp.com>
References: <20260213040852.3340547-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DU4PR04MB11900:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b49a479-6a29-4c73-aa44-08de6ab58ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DNsF2PScYjPD/Dtsq6tE1BZgJ+3tsyNuAgEVo8TEiMZqucdXEJHBGmSFFftM?=
 =?us-ascii?Q?Mog+ozt8H8uQBtSTQ+xwlnusU7nYqNK1RoQnPFEinLEoDyGH8yPlYqyopvsu?=
 =?us-ascii?Q?ZZE9oqiNoHadDhsiFa7NJB8UZulqN2NshKd0McO5px4ZgNCiHVWUWKYoI6Sy?=
 =?us-ascii?Q?87Q0COhWlxFKes2kW5nuhuMqN7DHHUELNESr9XdBwgmj63IbcxP0Ay6hJV5s?=
 =?us-ascii?Q?VnYXW+NOQu5F3moNSA3Wo1NVwct4qQ/CiXj9CSVA9cm0XrGFTGPzcYcZKwNs?=
 =?us-ascii?Q?551ugX3LoKPYwvq4g528hpg8o1RCAygnfRYukeqK6EkhRc6SDeSTMnYlCA9e?=
 =?us-ascii?Q?Y6778efhZyXIBFZvkO5XIqXMtKA3b4npv2ObVC5/MK3w9SrV/FcBUKDgEgZU?=
 =?us-ascii?Q?K19TpPwmY3Ev2OEsGIJ9hMYVQY19P/5c6mmdvu+wJT/Jlc9nS+Hk5YlxBdlo?=
 =?us-ascii?Q?rRGLubgTzKPfXgdvLZmMcGh88Fd+5oDnWu4SAAcvfr7K6emblYhy/PaohWAa?=
 =?us-ascii?Q?hUl6pBm9lR9blpLSGZ5zt3TQ0708Cqk6dAfI72XqRIAK7KTJG4ukHFqkAnNS?=
 =?us-ascii?Q?DW74ylR0N4s3LTmZWenKm8MmauSCPFaesz2ISTEgwD7JWh/MzlYHnEbK/PnV?=
 =?us-ascii?Q?dBgfEuTSMiPadzEXAQV6uF/5rGTUjmU1qt5OVRQhS+isi2rzEcXlKDdvj+O4?=
 =?us-ascii?Q?h2q+yo2RBxwMzhYn2Z3Kxy/HeNIGM3PFKG/SqNzQvlMR7oHjriBqmqluXXXE?=
 =?us-ascii?Q?3e3rBY5PpF3URahSvKj0YBTDyT9juMtUBWFkHEiLlIc0pGRkBzvO1cbFNu4d?=
 =?us-ascii?Q?qIDUNN/Rw8BgBHzHuPL5NLMwLn1v5Dvulknq29pe/LSUchgSLoArQgWzKA7u?=
 =?us-ascii?Q?k4h7WO3/Kc0+2I76ixLBOhxqxa370mDkmEjX6YkuoZr9mTRu0TaexhkNoHnE?=
 =?us-ascii?Q?qLGJ7gksrICFrndRofM23FoSqMrz7dw2rcoqpoALvJb2Xmt1x9tX1Ln6AruX?=
 =?us-ascii?Q?g/cMIt/sk8ghHkkgOz88xTwfVBRDZgQyZhQOELyqnTQ3QZvkK9PfG3EOS2Ab?=
 =?us-ascii?Q?ly2JNSz3yZ+/9eks0C392U6ZyBZw0hbs3rBgznsuwVKkq77elsCsrOzzp9nO?=
 =?us-ascii?Q?U8dOEWIYv0Nm1HawZybM/Z/T8O6ZPYVA5B1joWcNYIX4HfxVkYoyzsUA0Ofj?=
 =?us-ascii?Q?B+Z9RM1k0EyfctsePKjKSFmYIxWydmat0Fe2pS01JOF318Fbavb5AH7ITXV6?=
 =?us-ascii?Q?JKUBVUfTb7z7LHgtQCbH7zXYW2rmbbyalQJGS6TdANu+8orTfNpnz+J8ghlv?=
 =?us-ascii?Q?MffkEbeDbqotzmXhKeH40JD7C6FSpHrk07qndrWeMtRk5fmsizSgnL92nQCp?=
 =?us-ascii?Q?ba6Yq0VOGEFI9YBhsTGZ5saRDmNMxGa/J2aVnb1bF6cZ2mDA0RiwWM8jjfZL?=
 =?us-ascii?Q?6nEZ/g/zYPJdZpmMU+C0LHNy4glz3tNSFEiLJIeEQz3QgIpi2K5ja4javWTF?=
 =?us-ascii?Q?2ptFJbSyP+ui81SU3k7xCo608KbD0qu8e3qmncJAJsdhJwkFOftdff4KRNae?=
 =?us-ascii?Q?uAULJvKQD9iIcGOScEmYG2pqlUIuN7B1qZm43zc9krUZ73KRQPHfN6zoXlIN?=
 =?us-ascii?Q?A/1nDe4d+iD26Kl8VmRVlHgEzMCmPSs03Pf2JweGq+pn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ld1EiNi7p0QgkyPoBgss5NDFcNAmqySFfiUkVSYlX+UuK2qrlRJpnENy5wDW?=
 =?us-ascii?Q?Uy7XpMr0ZdiX+LVPnFqTGBSslbRPdozIYMK6RcOmO/bHVN4KpLWq05TcdymZ?=
 =?us-ascii?Q?gf6lEYiJZz0kZi3qg7We9PgzYvNdlofPrFWBgt2I+6V78TMyy9YkfGxP2uB0?=
 =?us-ascii?Q?rtwSJUpyRGFZIzJ5ErALzWHVn1zIWcw7zqwvv/q5Me/Q4YQpZPzY7W0jWq9S?=
 =?us-ascii?Q?UtuS8qXkgFJ0Tjn5RQAMWrILrKCL+lS5OW+PSEG8ZMKzoWCVNJAHbwACPyb0?=
 =?us-ascii?Q?BOY4H27bLLSfmtITjl+Y/WKmEK9Bl6ArSUBKB7twFzoqGHPcNNvOBpLFYsQL?=
 =?us-ascii?Q?TJchMb6A0EwEHGljpnzcimzRpioI8tFaFyKsfMR8GWugqZwJrFCTwggIwJvF?=
 =?us-ascii?Q?VGNzJAx1BS9hlk/kBa6uwz3NQfBQeCGbQ5DkIJFbnI/wqMOWNe5p5H3LR34J?=
 =?us-ascii?Q?+G5DGNKYHzURMOP2ZGbgMsHyLNRWjvBoE/uuLrpzfGHMM6eonYpKvMHBsKyS?=
 =?us-ascii?Q?eBnHrY86U1AI3gp3Gpk/YVw9rQ7QsX0tM0ghX/JnyrmLJv8lFiLDqyQjIp+s?=
 =?us-ascii?Q?G7dM/sHAS4dcevAe7AoUyDGz8BY+WAYZ5Fe3KAvgNIWSGFiPqBJDPliRbPP1?=
 =?us-ascii?Q?ouhkG6CQ+LYXFhHl152JrqtvuSjVdbdWRYgpeoU2mKExSnzAry+KZeUJoYWw?=
 =?us-ascii?Q?sTM0I/lTmsONsBonrkIcCOk9lJ+82ydiayeTJo+dZuykeEESkNrKkzgd4UJS?=
 =?us-ascii?Q?hOjh+bSbZLT+8mbbYZzEArttTTh8ub/inW0EuY9ImGsaQGddqIswWk6eSUhb?=
 =?us-ascii?Q?6bwquIQFVDKmXCSJ9b7RQuX91skfF0Na90c9OyHabswkAB1Q2wC8c11tEoV/?=
 =?us-ascii?Q?kCXzxyJB/yD1x3sT62qyIjnlTTVLzWeLIUZuJDo8jZRaLi8er0SYKwHmv/2+?=
 =?us-ascii?Q?mnsYjhB/A7dZUNKTSSUV8WbYKTJL+xRUSQLFg4HwssskNe6DmDkwI9Xl8GVw?=
 =?us-ascii?Q?f/54nCCkyW8HjYoAjCE2l7I2OiHCKA+mN8nJ9sQvrSlK3wxZEZ6VYgzosxu/?=
 =?us-ascii?Q?Zi/fvQbWXQ8eTV4N9kx/ksSyTY6Eay/AFMaQQT724a+GKtlz1fVAG2ZSDs6y?=
 =?us-ascii?Q?EWwu/mOm7gGsgFXXJOreMVPPuCpsNOAXiTlCloMliZ1qAjTWOlNSK/4A+YLQ?=
 =?us-ascii?Q?qwMV/ng+VNLrosHdOJn/jOnV68vv19MaNepTuD85UPDZ6zdp2pA0qtLod1K/?=
 =?us-ascii?Q?Zvcyx+vhOoBbxj72yBgi2BDfBGeiRrO3GwrRTPLwgdJQj37/+rydxetXVUf7?=
 =?us-ascii?Q?yh9G/Lv+Uad3t5EelBdk8SVIhmGC4Lw+O875jwnaAhAFfj6jtQESUyBRXxt4?=
 =?us-ascii?Q?8secRQbMa6nQXxyUDHzSnOoTQ7IY3C9oJ+Cl/Eo5PqbpiUTBLlNBUd+PzGF9?=
 =?us-ascii?Q?e1EKG8EtMwhNlC5uQUGRmyRsPyT8ox8KvVd0fp5T6/7+urGEvST7dzbQUoX1?=
 =?us-ascii?Q?sK6n20U79vL9Vh52JvaVRsqg4NJn3AK56eFyRlcbPHH3xf79ba+58yvVRiLd?=
 =?us-ascii?Q?CDNoGiCr47agNk34IqfilLMo3lztdrw5bKpHsvaJFnELMLhhi04Mwmp2aRvW?=
 =?us-ascii?Q?k8hR3gSLe2+4knYBVSuAZKotE9g44KzJbFNrxcail7SLocOaGBpjLO0sV9lp?=
 =?us-ascii?Q?AZahNmMWaXlCHUobWFUzwNoypTezLBTrNutavqYoxbvnQSSuuNwX991MNQ5W?=
 =?us-ascii?Q?spJG+KTykg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b49a479-6a29-4c73-aa44-08de6ab58ec6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 04:08:35.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTTWaODSm200uhoD4T3JRt8CTNjaa/KowcB8pyNexh+n6OMuPF8addJcbEA6trtvBWUv/u/yPkHJCwr7Tr8a0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11900

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

