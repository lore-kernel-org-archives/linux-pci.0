Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAED30F541;
	Tue, 10 Mar 2026 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107649; cv=fail; b=HK8slTVxWK7YCUXDhn1Gfdzw9kF+1vJ9N9tw7usAuj8amOosMJcJZ5qiGpbVchBW4b2CTjrOTd76rCW/CjJx0Q30q0xPIQVDWBUSg48v8TfsanJReXY0xEtpU0iW7XHjDHe7mky2+2zGN91vjJJUn8/m9+fwZFeEvUcfipr5FPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107649; c=relaxed/simple;
	bh=2QrNdCAJJCRH6qpVacd7O539pJtn47HWWp4UJch0H+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mLtnbvmKNKlOT0xmEaMrX9jwWW62Njsm+qu8ZCeIgWycDOILjdY3yyVuybsXoJHHEfpn6zrYL+S+KO1mJDfsEjXs4JA9VvbRSJoH0bdFIxFbF8swqdPU/1PldX+VR6xGqPr6hToFcREXSQMwRvzeEn4zsgWfksYbvFskFJH3Bao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VY8Ht6da; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VY8Ht6da"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpm+6kSZ6FxeapThTRQ72ufZZ3RUuQi6Q+1GuABAhkqY58EYFB2YkBOF+RiBgi5paHqd7iSjLuZ36tTD6whDajfOpxCoDc2Y3Kgt9qG0etnm9y3l/RhEyA5ooicfnWx/maoah2MOIk0usz/wYr83++6aJsNUeVEFVzauuPA/PlvNarRa3/X+dcY0If78v7DRQvZygW026GvjTnm/4QWj2q8aO+xWH3TCGo+aQLWzcsNHE0QJ725oqIJUlJhT87gSIXR2Yt3OOr1EDFokizLdPIbGOWeqmPZgeByFLUc1inENGM+sCmwojjANRiY44Ad/dCR5NwmfsQwzFtwY9bQhKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=EIiz/QwiX0rjG5S3NnmO9KhDCfFYaVqzJoUSP7kTNWIeNGz/ILmxQE2VYENsiOPmEwZCRL5xZ+jAZmkaVXSFa36gwJrOip0FOorGJNQNHyqDlEdrppO7Du0B7LTulHOrSnAn61yoV+JkixkMzZuDUR8IaMrPCl460iePqdAUC89wRiCgAkM8wPuGuOWobJ/a0A9vFzet/p6YVm/+Kt/n97hjo8qtj8RSCPpSK8h5NR7dXyOsVm5r5E+SmhvitNdHJrT/s+Y6jK/qbQhBBEjIiQVVbE7afm+uYTCkbG4ONOCL6KW6ktZGYf2D6x9F6Y2Ygs5LtpuxwHuFOslq3FyMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=VY8Ht6dadfNUl/rojdnx5j1ephqrFJXR7DhUkWGxy6KEyuLJotFCiIXfu3EzPTvdYrWuRc0VnGwk82auBE0gY169+cpjnek/mB2HwaePIuhu4fdyKQQfkQh6j0/UKk1AYRGkTQ1rWuQrl8S/Awn1YEK1VVTBSNI7ol8HT2XnqGLYUdTZiDJ9iwkNV9ShiIVGiCXmXMDcmn96L/nwMs2T9kfBCPgIhAbJb7YMq4Qm3yWwjDnZyzx3aLa6nTVL95QT5wwZs5RK4L7mayz8Hd3yLY4K2Ba+L02+HXcH2qeut+TU8BDdYWWwQooiU+KS/rckB9NfRY9Sv7btUnr9248GcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8889.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 01:53:57 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 01:53:56 +0000
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
Subject: [PATCH V7 08/13] arm: dts: imx7d: Add Root Port node and PERST property
Date: Tue, 10 Mar 2026 09:54:21 +0800
Message-Id: <20260310015426.365675-9-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260310015426.365675-1-sherry.sun@nxp.com>
References: <20260310015426.365675-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a925289-9355-4d07-7d72-08de7e47e38c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	QOgIH+YFlAd3WJTFaoWcVpgfzq85eqMbyGWlItTm+4E4ZTumkJEtI/fnUERX/iPqhVZWi7HNRGk+drR+EeRzVMHQRazRGq8h2NIq3uySlXvPw66HkgwRoYAxDsznQSVh3hJW/pRT1I5sZwka44anMFYLmZjZKAYLQPgaJZy45+SJZ1jtdze6Khg867jGHMVDYlIfqVkrHqUSDuQrqIt9JVpOJxW+GtwJ5LjIo4GD2257d4LhYuZb5GJkcdJgnC95/xfWoF+bENgF9/k/gp2zQD32uZpc0J3bk+AKVMiMxkADDOolgCberaQrnLMBh4iJrI6bx3Dk34MTv7Fgn+H6/el/x/5/1c1oU+9Ki2x6fcvaDvZDYFO/tYkUjrn+75zhoAo4rnYnMze2H51XiVRy41XjV77gjtpCoQb3idLcRIWXi8Yz6ewX8ZszZWvKbUjL1k5MzBpNV1qK31fHmRVNU6EGSDCe7Tk1O6Wy3ChOucNh3b6NjYp6MEDXk/daxn4pBkDXukH+jZ1qcC7n4nIBIubggwpPzQ8XBuK65aJ+yVZTDwZu+PIlPDqLoIhO5tsp81gsGCodC286/cdRhxwyYCq675jt754wm9TgeWxxRGj/TrMPjdopKC8kiEWpmpJ58DRU7nazCmaEoR4Dq4nZAIAamPsCRcvbimw4rdJt/cZKAoTOkmgrKsMktAJHCh8p1FBycE+Nh3C88X+OqxkY8q+ijdBruhxQ4yxj7pdkCgtZEDpcc0uN1/9PjvrJt6572BRRKuSYAUsoXKrxwNrbT0GwfqLFvjzK6TBkAZSVqyExFNEPgFNh71gTSBpL1Bxg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mC2DJoJNwhB8mDb+aDCi4KLKUgVvHXfAH/6Ug2cJhe9dqXWCs6CiEvqKwGww?=
 =?us-ascii?Q?/rZmnzl/yeUphoVnUPhCJn0AdqmHinTMsXd1tgJYzZRH/qHtMO/4o8WLmCEQ?=
 =?us-ascii?Q?ydgf1ycoRKp3KXiUFfdOsicpa50CabbH8MxdrudKe+pQsOpDZV/PegzK6KIJ?=
 =?us-ascii?Q?+zU7+TnOp8DhESAEYnG4w8pWegooGODhHSwpIq5aXfnc3sgni2qAXkrgiCPi?=
 =?us-ascii?Q?2l0xtddu0OMLXTbxcdPojB1CAlaLYH/Da1mR8wm/GoFfYRmaDZxiZwdM4oMf?=
 =?us-ascii?Q?aPiFuo3kAb1D9xXtJ+DP3/a6VMj5LRv/D/m32PqweMbZ+NhQw1ZrEy3HRAbt?=
 =?us-ascii?Q?BeFrh7CQ4y/rwNL6kaY0XyHLG35AHzv3kMx/pyA3QW18AVNwizte3IxXGifA?=
 =?us-ascii?Q?rJwnCgazDZm4o40u5OavByDP1AQ2je02sEqDl7SJAM5f4wzodVGOia6TcuCs?=
 =?us-ascii?Q?zaU0aQbbyoPkS389Ra+0drwe9MReCFX645AqaG5mt3TRh+uASlhthyxYMRkv?=
 =?us-ascii?Q?QxNdyNaDTTMuXjkFg4zGJIa0lm+S8upWoJxUr04Nif9+0Bx77HPHA2ii5yXw?=
 =?us-ascii?Q?HKjE25Qhdj/JUil8Iy2+tSIJl+9cPD7U4JS72163/18vEhvgqqQCQ/1pZLaS?=
 =?us-ascii?Q?C0Dl68He1vg3YyJ9Vl6gHuAuRHMdryLZR+gwiAf6j1eom7HM+YCVXWHV4Iw0?=
 =?us-ascii?Q?jaG/P5D8VUh4R52wx0ChbMHzeaO2cEnJvcz0Xc+eckRaS7Sw0VsX/CRkj6mj?=
 =?us-ascii?Q?9/Fb+gYi4eWcYGsbw1GqN8rFUdnmHjF58mE6yQiFHG8i40OivdgTHamUHyYx?=
 =?us-ascii?Q?MjgfDbUZ/yj6GYaNLv2d1X3L74wQQxyBMk1WEKZIiVTErRKkqgf0ZzW6XQ5d?=
 =?us-ascii?Q?BjF7+GMoFXHP6clBf8RGp7uogWhiWvW86+Kr/p2NxbimYRrx+5ZMzOogOD4/?=
 =?us-ascii?Q?AerMoquX091MEzulPMou8cIkym/njdhw7sX3qyM7neCTUUS+0JYJOWTAvqap?=
 =?us-ascii?Q?BguLoBgVcVVWxBF7efuJtn1sy2jEl+9nV2U7sda3E0CxtyGE3TU+7PVFUNSp?=
 =?us-ascii?Q?CULJG+zmzWQiJDu4b7cFnW1e6oVl+wRvKN11Lyj8VsDvGIYZSnQR6zdJdpa8?=
 =?us-ascii?Q?IOQIWlHMZLteOfP6h5CPLLEY77crvhrmuMVtlX4694nNhBxgQrHdt/lp7hNn?=
 =?us-ascii?Q?qWrDpBNGmseAEXrUVkjhc3SLDAmuMZspqrQEInM9Azjs6q/B+p0s1ZlNa/P7?=
 =?us-ascii?Q?pOty6xOybyAds7zpRIn6qp1h96UMTChzB0dRaOHQ3VvuGu+xOxkzxYWf6ki9?=
 =?us-ascii?Q?+4m0UEZCP739XH33Pb2t3crYmRzfqs65EK0U048aiOLpJgy7MQeTOhCPrMfL?=
 =?us-ascii?Q?riQtQCmbAd74vYWbPIJ9KWNxr4iBU5OilejWXFfmBjSsegYoykkT+ghz/JfQ?=
 =?us-ascii?Q?/AzqD7q3qB70vJ1vnHFwUpwM0PHf5SPlTx0bQulzN3JSMn7ldD2KJ75yh+lb?=
 =?us-ascii?Q?TBpar3D48qoXuG0h6I6gnmzokmS1vb6LxR9rcRBDDN7qgPD2ODkYv8gnBIai?=
 =?us-ascii?Q?VGqbQa8Fteyy4e9aWyTFYX3VIQzC3MQ6Ne2FLXo+l+C7iNwRCcdIoqCLq/2j?=
 =?us-ascii?Q?hw0HgsfU4+xB6Zm4gQE2xkauwg3wbAsJ9u/6rOL1cQreVn6U8gex73XgSr/5?=
 =?us-ascii?Q?Hm71bNvDOYFeFlJZzqx/Z53VIEGHiYPTNFf1RbMuVCiwV1r/FKiyhIl8+OqS?=
 =?us-ascii?Q?HWol1Tyi7Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a925289-9355-4d07-7d72-08de7e47e38c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 01:53:56.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzIfrX9Grk2Qy+0X/CIZxGYUmBghfkyjD+Aky0bRYLsog1TWsnbB0vQP7NwYD7zlKjSzbLFCPlbsO/hIlx4Raw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8889

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

