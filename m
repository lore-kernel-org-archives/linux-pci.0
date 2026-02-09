Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4172FB630;
	Mon,  9 Feb 2026 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625470; cv=fail; b=l5NxIh9ZCXHwJV+qrkaqxBFqw0Cj2akusMqAdlI17GT0S23Kfv3DZtmor6LYxcXpvM1HciRlgwpJEK7oX6xb36oagc/f69cNV0THnu3Y8gccznuafRXUm0N7/ad9zs+RV4+rV7+RCfiebuWrfKVx9w2UuuqYwnS+1B2aZT+XpQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625470; c=relaxed/simple;
	bh=2QrNdCAJJCRH6qpVacd7O539pJtn47HWWp4UJch0H+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BR/9LK/a0vPACkZIKQq5YqmrYH9eobLO9gJDZrYbhYEcrcJh0osOdT1riOzx5oWmp3HtH+Gr6Fs5QATKvRZ2QFGrA8PnVS7sN8iVqRKuemNtXQox25v7e4VhnFUW2zBRa2GEtBMM2v+A/fReJevmqmgBncp+eXc6+GJJp/Zlamw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=abwaYo0C; arc=fail smtp.client-ip=40.107.159.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="abwaYo0C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+65JGhwPQyn04RfhFlJrsQa3RW9K9FL7nRTWAwXqjZI6zE4oE4E5aLMvckUkp8OVGOCNjQYHGkZfO+uQMEHuPpzA9gBq231B20+L6p2T+EKZgovbTzP0vDj95xtQmJrqTvtF9xEhItyhFGf9o36waJZ/mKb2TApOH8eKk/nudAB4NR04w0RY7mfhqM014KPgykI41j2V4v03rSMmrLxIVS0JYX9O/t3yZW0ymYB/u/Qbp7nZHuvztJTSr3IIKW5lKFlGWAR0PQ331azM/HjuCZfwbdCqep8Ug0/+FrmBKet9FMKHg7quy8OMTpl/nRgkTmoky1OsKwGCERcI8LQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=HGavOURUD2AtRGkSaHwhhO0FTGjkt8RCpXV3ODLup1gJzbcdvA0FZM+iITZ+DGyKCK6kV4biyDBlYLk1hNB2IfokrP5j52ZS9uxxveCAQhkrAT70Y/hLPGJLPwGDbtiQl7MV3QIB1lHBXcqbc8ftNrjkHeQnwF9ouKBoEl2PsO7OTpu8C5dOA6mr/wTefuZdD2QsR1lcmyqMBjBBxZmbNuz5ogYQc03Zblzpw907F48bi+IAEPoFBKq0l9+K+aL7OfQixvqpZHvrxHnVguryF9XdfPXGD43jM1eMrGDQMdy/MaacOxy62nwaohkkvjUTjK5xaQescaWKKjrJI2Lpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=abwaYo0Cr+iohs+1qdZez8EI8h/vaZI+JMZXMmw3oItq+2svqnujpTM22efKpFcfjty68/pUhlS8tXM5l/wc99vKcJWeQ74HQV4FnPEzE3x2E1ukH9XdWmYqtdJM59mDwTc7Lns23fJ8m8DThVrVo+CBicVE2ay2dcyagRvkDoyw5PJ7+kZDCpzn69pMjz9b/bVoxI3nXp4PkGwrfrPiZomXmoKxFH4ZnOHuR/+4FfyhJ/MlUwaw4BN1gYDctLlgE8qqOFK+pSDjrwZ2fL5kQlqS/H0Ej/LOIOYRRkbI7JlH0rRvk9tdgYZPLGqz9CNjraDnbDiB/dMYUxVPjZs7Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB7180.eurprd04.prod.outlook.com
 (2603:10a6:10:12c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:24:27 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 08:24:27 +0000
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
	festevam@gmail.com,
	will@kernel.org
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 06/11] arm: dts: imx7d: Add Root Port node and PERST property
Date: Mon,  9 Feb 2026 16:24:49 +0800
Message-Id: <20260209082454.2097628-7-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260209082454.2097628-1-sherry.sun@nxp.com>
References: <20260209082454.2097628-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB8PR04MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bea4781-6dbb-42bd-0e97-08de67b4a394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HUXLNsKCHv1Gir+KvMgNsswerNdsQ94zNbnqW84c3hjujyLlsUE3rSFbMex/?=
 =?us-ascii?Q?FqpkwyKeG4OWm2uddkaeCR1oZzcD+PmGlv+VeQSN+xRlz6X/IoOzffY/43Gg?=
 =?us-ascii?Q?VRUWmXwLyMZVvyhnOiS91znghdWgvGE9XL/9s3lCLQlmtQNFFQiEfA2eITuK?=
 =?us-ascii?Q?z5QGk47aUgWEoP74isFa8/OcweolFPLoXAHvdXGmRZr9h43PZYO4/WFroA4M?=
 =?us-ascii?Q?O5fS+0lZX7aa9WEE/1ml5NNMS2z3rWuQlQXpUe9UtjuAdaDTGodC3Jfm3VlD?=
 =?us-ascii?Q?6UC7il2vJSL3nHdmdH1DsByke5CE9IlH6/ZfNSA56UFSOCcSGucWY0JGZZW5?=
 =?us-ascii?Q?HbFcl2pBqKoPQCWnTDGh/k9hyb8ST9+butFejT08Y+il+kYx7o4skv9OD02F?=
 =?us-ascii?Q?Nl/TKx4iUq2q8+yk/GS7xuvuZFKGg/tNrphVCxi83Dal2y8IWMIGIqzsVMBc?=
 =?us-ascii?Q?LUO9m9temBDEwidcJ5xZMCSiE+5uK4tZo+TyavTDrND9GqWn+f39McwtM7+u?=
 =?us-ascii?Q?tEyPCTPBnoII6kLmX+DqLyy2Yz8vtNluwR0Re53l6mG/g4nZwvOsC9ALTQwv?=
 =?us-ascii?Q?MFq92pJwJQ0E8lCYpbR7WIwKEYoaFls0pXW0YjTuuRA3/w7NSWZMocb2yjzR?=
 =?us-ascii?Q?4cJQDE27cnNZjaVc/ONeaMmGbD1RtJUebJDyA5GOa2LBiX22wbzYUIN8y6J5?=
 =?us-ascii?Q?r90qBGcZpK9yI/kjn5JU9wzjMqDKGfrVkLTPjNroqQMt93c4e1La3iPsxZaG?=
 =?us-ascii?Q?cQTwspMPAGwCogChKCT19tMt09wksp2OIVLB6McC8373QTkfr2PKWSTCaRw+?=
 =?us-ascii?Q?pN98dnrgEPoOdO5sJBHbU8nukEUdNNaeLSrM1DtlXQlVPt3yVVTNfmu8EGYf?=
 =?us-ascii?Q?xG6EM7FEVONxHkTUlMESgIcEbgwAkQXFUrtHOLIoThVy/W/i1oa6NE5YttTV?=
 =?us-ascii?Q?ay8Am9V5JHOjXLdimOXplzCYgM2BvtEzH/iEzw8HPKPrTS9FNFhwdubcOher?=
 =?us-ascii?Q?mHLu57+rMcK4svxI9CDVjvNLDjxLeRUgu3B9LCV+lLOgu6/mfBQ2YrHleDFt?=
 =?us-ascii?Q?eayEbYGLb9bgBrZVPIydmUjdZO6/ZR0Et/HdhD5z9D4JCHoyLaCYVe/avM/L?=
 =?us-ascii?Q?VDVdGKvfi3+V8VxRNPkfg2Fhgl0MQSH7i/Za+Uruo/S9gZ1k1Rty+OXsSLcZ?=
 =?us-ascii?Q?UiDS0u/VFSNdulgJ66YE1aKVIFybYB9ry3yvJmuAOrq30SO7Ev02vX47k2b8?=
 =?us-ascii?Q?HzU/I01EluNaU5FN6sVKDI5QfgQBUTkGugW4F4PaXPdi+PTbmC0olxqSXZs/?=
 =?us-ascii?Q?9h2XUUfoqbbFPDm1n4ML71mllgngzrRuyGKAx+vmkOJu6aWR/MJeaYDY5IFo?=
 =?us-ascii?Q?EDqUePLxYrjPf5foQt9kU0MFTIt5bOA5R9tJm/ew9QzJ0cErbKQ5UZ3LKUqO?=
 =?us-ascii?Q?0KPU2vf5D5FGU6Lh1ZRHtyeoRnDwXaA3nl7xZnsuyXtrLsEok/HvuXXRhzTk?=
 =?us-ascii?Q?4NH23IV5moHhE2/9Sjq/e/YULdteIXWq/jBt654q6m6YMK4PS8KD8gKxp/fE?=
 =?us-ascii?Q?eNj7mof5qeuL2bBuoNskFk4XiN8jjjCIS2sCjq1qZvrOfOf4N93K+nYLtwBY?=
 =?us-ascii?Q?cNxvB3zj82Lucy/UKb4GNMpNHZEBbRdLETz7fWmDrmzS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r0ry1+IuLmFEcQX8XEbpL6QdssgrBrqXLpcbeo/i+OvhVtOcKRHmXT0e5/I2?=
 =?us-ascii?Q?cv7vEKYMONtN3+dCD3FFRF+/YrNOoO07MEHOEZfLZd6GA8g4W8UtoVRQFP9U?=
 =?us-ascii?Q?C3zh8Hp37i51D9/9BmX1VMwUq6NaajbW3bo7tAUPFvL87m4EqSbaajrdKp8H?=
 =?us-ascii?Q?h0iYL9ejzsTGeM4cgGZ8qWcVZzIaGnTlKeeFNz6XLS/NyyguMP3crI7xfwAZ?=
 =?us-ascii?Q?0yAd45jNrrNDJDFB33n3oFxjfZKPQCC3EE5PKpPwNxm+4H1LqQPKlHITOqiH?=
 =?us-ascii?Q?O2D3ep9LbKhkOFVx8wE4Z42RCsZuKGeSfuC8ew5QYDVN75VvkpQ/tw0LSxeN?=
 =?us-ascii?Q?aLfuZRYWrWcsfwvC/vfyGjpPxQWUKzv2LQvgKsGcottAFHk2iZBg+k8RWbej?=
 =?us-ascii?Q?VnGkUCgzfub2CwO5kxSwUIB8K/x5DcnOfdjHop+y5H4LFXuDNM0N/IpX74iX?=
 =?us-ascii?Q?1bI6HB9oHf1Fmjtk2y+1H/uHBKVsd9BA+WgLXTAmHnPIe84BWk8PdWAiumB4?=
 =?us-ascii?Q?GjINkyr4MuAkWCuuDiylsW0hhVTQU21Qf1Sx2zpGKsBuvH57CIaAo5rRAqqV?=
 =?us-ascii?Q?q9O1A6uGDUYYo3XAzE3nPiZuL9ifoe5GuphqkBv6Gfolt7oI3olj5F9sLggp?=
 =?us-ascii?Q?gjy3nhHuxalwBWjF12vvF5tfi0lGuHEwRCRy3G2lH4qOczEaddK+eNrrSDgv?=
 =?us-ascii?Q?5uM5UCtBwir+tdBcNUkf95/Pn/hA2PzHiOta4BJMDmlSi9MVgg1KEtdM5Jel?=
 =?us-ascii?Q?VHOm1S3jKUk4qXd2yg7Qvb4nUgDQB5cptTPno2ZBYIr6c95F2SwZGRgtWhBK?=
 =?us-ascii?Q?D+uT99FQD5CHhrKr2XwEl53PRH4iqlEo/Fq5pnecNHsQEC0db4ylhMn25Trk?=
 =?us-ascii?Q?ZHHRZ70e6QwJYY7tKXt5oshqtdNicnPynCybNn2XuTtxv1N6CAIvcVYeS3KR?=
 =?us-ascii?Q?x26yVsC8rtn0+MZe1hIWWSmjsQXD3gUg8eTrzGEmVOd4+UHd2GntdwMdc7LT?=
 =?us-ascii?Q?nGdeUBz6nAgz59kpqCqthHTRbDZyC5efcrhIx3Sg1Yu8lERydV2hAwEZvodH?=
 =?us-ascii?Q?Oeul6q9PFgLJ4eXfFH/Q4utk951D0Ez5oUg9cht9n53O4El6mzJ5q/OW+ZUu?=
 =?us-ascii?Q?wBuPtjVP3UZHsPWRv3Ue7zA/aTlZoq6JE2EgKPYsuDbdE0dwSiEU/yqdOc53?=
 =?us-ascii?Q?WVue0k6xy3A12f/dLye9hMWgtkPJ2mCFMJxBA6bpB2zouw1lGXKXDDy9ZA+Y?=
 =?us-ascii?Q?XdABgZ7Ovf/3Z5dUNMDi2kSonbTgAB+AQfOUZ5GCoMThA/vWtSTTbGPthIBn?=
 =?us-ascii?Q?X+YIc0e/oesorjBWFBVNBBqg45/QpiSToQAQACoiq9iELihNyk5JyPhSJg05?=
 =?us-ascii?Q?aujyF+lkJqK4dRV6M3R72ikd6fzdVQNKEC4Rvw+OFxqV2ORfpTEzzxTCwlLZ?=
 =?us-ascii?Q?4n2Imsbn+LzRzi5WuqotwkYRAeFotkq4q8vMCuQ7t41GeUyffZMsb05e5VPs?=
 =?us-ascii?Q?rhI12ZUzAT7OPkQ/9eApUYuCjpUOZzFSqu8vhTPKKgX4x/bJeRCGLoMaZ3DA?=
 =?us-ascii?Q?lFA27qwk9ddiEf/rhyg2joYqgxFkkaaYPzj2mYYylP9sQV1L08PEK/yHbAmv?=
 =?us-ascii?Q?geWo8xZtZhKdgMmgDdwDHEfE1UJSp2iJ6NIH4+BKG6xTOc8EFFiDogIGtDkZ?=
 =?us-ascii?Q?+fBNMfWk5hXtNptQeBO97Ne94b3aXuGgP4R/enJkIFpRoV0Ptgi4Ms7dzPeP?=
 =?us-ascii?Q?6BrnvqnhEg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bea4781-6dbb-42bd-0e97-08de67b4a394
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:24:27.0354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmT8f4mj4K/l5fKurbKWDj+Aug90YeIlCNj7b+R/rF8bUNAEAtOw4F202S6ZYaFPGaSub/rAo7yeHbjd4PdraQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180

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

