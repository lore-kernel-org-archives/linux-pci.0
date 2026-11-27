Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749144;
	b=QUZCbMD9gD/9mcDUVzfTUoZqyzU0eYUsD/mb1tFhLM3kT89HGLP8PFzfMQgRriR5X37X
	 DXdnP3OsWG6YNpo8mLS1doJdv0sjUZJb4/ZZN3PVhYY+BXhrrnuvgPc0p7Y2G+BMEG4ox
	 3g+qBZhRRn0OL2VKOpHQeyhOLrZeVOpfxJxCsgaJFLKfPD8c8Bpf/ehMw0G9AuPqezPgt
	 bJ1q71vfCQ0QnEL75LWyzUYlhr+PbC0wEMB77lPFHDDzZ8EjF+rvToIF5GUm5R1nF7J5d
	 BWdUsUwt+WRPlA4xbl7Fp1wYHrdjp/G2wCLvq2rSMXpxf2Fi9yf5Yzhz8XRpwRDmaxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749144;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5kWjFRzRGcLjbfoysdzP6+KZcPSKSCHfpp5Gi+0TdeM=;
	b=DJyiJKmBXoarksgp1v125uAr6Dgx6JaccDhSIlzBzuDwBM58wNM4Mpd3Grqy5rPFSA0H
	 8CL2SUim4ZMXlydK82YMzpQnfEdxz+2vxTs80wOWCSAzjrYVYCuvD03db3b66ZGPTKPE1
	 PY5LIyaMfywOPj2MxtytOxCxaonkO1WIF3t8fKSW/Jw8VHiSKV5QJEkmSeLFQu1GmoWU0
	 PKpqM4TSrlSwxH+pQw/lhz+zkXAKdSxzoUpht2lJhRXX9iZKyHPrbI71gVZhtb09Hryki
	 HmdVrSgb3GZtkE5TaUOjuNuF5CS8q7nX/rZelLni0gkbKrsKNuub9zy8zBVAudP4d7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=vpz20kN6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E886D60A260D;
	Fri, 27 Nov 2026 03:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E886D60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=vpz20kN6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCURFOEe3aVq1S+GlDQ86tbPYbo0xVw9MKxJswWcmlOdCikDDhKAVjA+WYh/sb/pnlSwnqjB44eTWpniNIhgBq2qcLN+m/A3vEQbjN246HEZOsUr7FnjhpnsEgZjP5D4cfnYGF4GKRmDC52j9n5A4O4J+d1PBHLXgNJbCiEBuDFAZ//ANDVnQqtPpwBTNcJFjaroy8t7ULzqawW0uiSd/31VGh921u9LD6MDROXvPBbKlT64EdsInioCrtjmJH8Y+IcYAK6mOD784kPsfBBWzvoPoJMw8wi1jKgzVjtPGgEtntg4+TFfo7QEXrttFCCfGcX0hhQPb0kEhyHp/1csqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kWjFRzRGcLjbfoysdzP6+KZcPSKSCHfpp5Gi+0TdeM=;
 b=LZuvCsJdgmbp251FdHMblAdeinVbu4l3kmMtDcWfagGrF1dGoH4BcppRCfu+5MCFtLBzoYHyIc7vidC+XEpxFvzoJi6bsAm1b58XQBLkwSIMCDCJ8160ojxuX0OqxoiJznbA6LtG7A8x6KeLrU0fmiJvppHLIKsZxVldapnIbKQTkB61Zkf4/u/juMbcUNaYo0lDabaKqT8I7/uEoVJRLjFS4cJKpwPBjTOnbDervPLoB0BwfsZUzCZg56UF8Yo9patk52xNWtGQLqNgTDsgVc9CFqCAf2W+7aXdPQnNui5RVkcRbWJLG+2XbOzdfTGquy1PtRQXKsEdmA9HilzGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kWjFRzRGcLjbfoysdzP6+KZcPSKSCHfpp5Gi+0TdeM=;
 b=vpz20kN6DVpB4iPSdnOZNiCSSmuqJ3hkpG8lSzqWGELpj283tHfhmUnGLDZ3/mQcCT150GoaaoxxRqXSOYKF/KI6fOupWqnva8tKIKqg5yCh1qfVr34Zl6PbihSsQPg3Vzh/z64nhNv62PzOOhLqf1eXrM3UHhdO0zACmrFYDWk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4873.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:16 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:16 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/17] PCI: rcar-gen4: Add Root Port reset support
Date: Fri, 27 Nov 2026 12:11:37 +0900
Message-ID: <20261127031145.2521228-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0191.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: cf16c6ee-2db7-4fcc-9ad7-08df4c343cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|6133799003|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	sRoEp3Ybbrl3gzRZtzqDhr1kysFzFfr9B3boeVVbadk9sbLj1B37ew2MGt9euM9qeZOWK/c3+WeBR8E8Ab9k4ZEh71dhqeLwGKQNV1qUeYe6K/uNp68D6Rf1kE8m40OFNHMC1etCn78+EDe3Sf6xa9JdiVDz52ABnB2Xg/emVBqiiDDPCbjMCXk6UMFHKOHb4LgPWpFJNC79hhRZuj4+RVdgZT7rbvqQRQkRvuy4B2sGzvOBfXUxYxw/Rxa9XZOCANsuKH6WAt7I358XxsjFJ+VdoUqX34lLvgCoqiud/dg+RnmiBj0pY1Ok4+cHBH5m6SzoHZBq/ONmgO5LiO7j/heI34v42FMtpP61d+6xNfZZ/A4WbR8SNCJUrkV0xAzMBpEbaXD2iKorT+DRTbfsX4HwCZ1Ipq9lwkdoKSPIXbgP2UY8i9HNVnJm1PoINsU7llK4F4Db+LSeEXHG0vDb/MFsnCv9/SwAUIEk9qtmFZN+VpJC5vytPPuBvI9MdZYH9RorjRKfvrl7LB4hqbcv7j9mOOxR6LO8Myn0bvONjvsaYheAUkTerKkOyQQvwHZyc+6undaL4UMlwEJdyjHghie755nEHOGFDptcBIfdbtkqm6vB/UE7oMP492vUsQkdSFkxo01+ycDdFDNLhJdfwZYm5GM/yMtphesBXZr8JRmlnag9mpEqp6OzNxuKx8VNEOZJYTJDCI/Yiu6/BcZRRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e2ogsPH5LDah4/Z4qBFkRHO2i1mIbYX3OP8udEG1hs5V/wIeUAGKuEHWVqY0?=
 =?us-ascii?Q?nufND5++IePgUJQrorGtD/34LZ/P5ynEn4bevaMXOGyzJig48sVVipPWVjMZ?=
 =?us-ascii?Q?OHrLjlrIR7bBQwzSFoHsEDaWElfif8BxR0uBwV8CRqdy8WoIxVQp+qDvH0sf?=
 =?us-ascii?Q?65vmoPABjEAUWC3132teBVIMxeHmZ3pxJ+MvlJA2gUV/6l8vLzs3goQHvmxu?=
 =?us-ascii?Q?MusUaK1QgHNYELh0dUhsQ4kb9lckRG4uvwv3m0vXTbj9UeKCoU3jDKFKcoIq?=
 =?us-ascii?Q?B6lPlDKCYTVbWdrBio5Muai5MpGOJ+peimz9NBcvxZrPnROuuBujrQ/foqDs?=
 =?us-ascii?Q?dYmNrj4aPRzJQgiVSWQPrbw6HpZuunU/2e1ooi1fvrgzxPngRqQr0bsBwIOZ?=
 =?us-ascii?Q?cQLzMzQdfKX/fH8rR0um83Z8PQdIbgfr06nGpd4Jtz2cKzMJMmA+tN+axcsb?=
 =?us-ascii?Q?0bkmhquMsrnR4z0XDVi6hCqd5xgT4yKy2VPMqJ7RlFSMUXldULiRpaA3k8vX?=
 =?us-ascii?Q?LkO+3ZcuQArnRaehGBSRNw/T+OAt9p065vRclVbU4/sBb8HbHBSefV/6L40W?=
 =?us-ascii?Q?NyNcHMnL7/v4FfN7dGV1osbxt/oUoYcwAUGbCFzDV4Wq1OObm/HQI+3s8rAs?=
 =?us-ascii?Q?N729lBTAJdtCSOUf7wVVjae34HxfSh5uZFZMweXsJvMe/3qRqn+pGelR6qSt?=
 =?us-ascii?Q?4bNXuzevFF7eTbEbbtG12C+AlHH2KPsw9Y+1P0zCqSN12mrwSJRmMllHVXQh?=
 =?us-ascii?Q?b9Im3QRa9o2jza0sFMTA1HaZ1XTpEl/RRJROJ+bsiyktdsxyWE6sGWolIQyj?=
 =?us-ascii?Q?CydjanNT+bsoEjOYuDsrBwPh9pGnWReiumjJxmQGY9QUajNSnBg3PVYpmfrL?=
 =?us-ascii?Q?Qy5lePxdUv6NOihOlI1ASEF6RoDVwMHARVHtlLDqQTPWUrcvuyB6b6N4aK7S?=
 =?us-ascii?Q?RGB8OxtJaYzTo8xz9T08wpbgHZ3GNejbZFj8w+bvCQqoERybFSzqU4o+VYs1?=
 =?us-ascii?Q?80DjFowHJa8jo8M3DmaOErqLL7MjWcFeJa3CA3yvv6uIPGUUNAMeOZ6XFzJ0?=
 =?us-ascii?Q?++vtU6BmEvsHvgiawx4NiPij+/Wuip/NrKUjwxWCQ6ykDmfXFsN4wC+H9EhX?=
 =?us-ascii?Q?wQL2CX4AuoUW1JIk5V+h5AhLizfsGRW95GfxDkD/K4Nh7Xdqd+khivpsnTPN?=
 =?us-ascii?Q?2T7PdgdfOg96VaNOTARc+v8RrYpdgOd91Mjx2VPuJruEWr549HFEEegFUdNj?=
 =?us-ascii?Q?duSCVaAcbkOGvAWcnscyc63Jvgfm+qDGsKWUAvSQD1oD/mzkpcC+J6RtLGB8?=
 =?us-ascii?Q?4+2d6nvo+qpgpcMStnJe7o7h/PFrhfauuXwOG0IBQ1Z5xv0O31NWBSUNS2ei?=
 =?us-ascii?Q?A0RfJvwtbUdYJlMISUBoELymXFAXfpACSvJUTEzhPRTKJIWY8S1BgF1C6aJ4?=
 =?us-ascii?Q?yq/ZYhhrjfsej8QO2tSb9gT3VrFDVjpl2BBk2GsHihCCvpLSEjK22otWtYGU?=
 =?us-ascii?Q?3mxHg/m3Y6LCRWe8/1o6zvZ4HUk5DzrSXXMA6gW/rTDkL3wMDp6ZU45r/NWh?=
 =?us-ascii?Q?AZcOXbhA+iklBEtRUph0YQJGF8oUpvmHEXwSmsWaVMXdJ9OZgqSmq+wd+lu8?=
 =?us-ascii?Q?NzXQutVbdV646qN9g6Y+1Q7jdO85gRoqIuIS2xP1I+4mwUK4euvWPx/adSCl?=
 =?us-ascii?Q?xlxyG60u/DZG1F3+zF6+udwkZM2OOQH6/tyIpZSCuCvy1b+pjpiOgqBzVfSf?=
 =?us-ascii?Q?GEtNXw93KrbzR7ZZ4PUbA90R2r0tk17BczL9xfiDrSEdwoN3lrKx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cf16c6ee-2db7-4fcc-9ad7-08df4c343cf5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:15.6090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIwQ5OJOfDtQ6IQ0hGz2d4GO+WbfNF/IYAU2hkOneca7Qj5GqMRDuJUC1wF8M0MrDDUUjrbdtzqdx1aa/pEyqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

Implement the host bridge reset_root_port() callback so PCI error
recovery can reset and reinitialize the R-Car controller. This also
provides the reset operation for the link-down handling added later.

Reinitialize without going through .deinit() and .init(), which would
release and re-acquire the clocks and the R-Car Gen5 SoC PHY: split the
SoC-specific register setup that the power reset wipes out into a
.configure callback and repeat only that, then restore the Root Port
registers and restart link training.

Rather than tracking which APP interrupt enables survive the power
reset, derive them from software state through a single helper. A flag
keeps the sources masked from the start of a reset until one succeeds,
so a failed reinitialization does not re-enable them against an
uninitialized controller.

Reject a reset while the controller is suspended, as a failed resume may
have left it powered down.

Track whether the R-Car Gen5 SoC PHY power-on has been requested so a
reset retry, or teardown after a failed reset, does not call
phy_power_off() twice. Continue to ignore the PHY power operation return
values.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - None.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 146 ++++++++++++++++++--
 1 file changed, 136 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index c513294df5a0..4277ddcffccd 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -99,6 +99,8 @@ struct rcar_gen4_pcie;
 struct rcar_gen4_pcie_drvdata {
 	int (*init)(struct rcar_gen4_pcie *rcar);
 	void (*deinit)(struct rcar_gen4_pcie *rcar);
+	/* SoC-specific register setup, repeated after a power reset */
+	void (*configure)(struct rcar_gen4_pcie *rcar);
 	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
 	int (*speed_control)(struct rcar_gen4_pcie *rcar);
 	enum dw_pcie_device_mode mode;
@@ -109,9 +111,17 @@ struct rcar_gen4_pcie {
 	void __iomem *base;
 	void __iomem *phy_base;
 	struct phy *phy;
+	bool phy_powered;
 	struct platform_device *pdev;
 	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
+	/*
+	 * The controller needs reinitializing; the APP interrupt sources
+	 * stay masked until a reset succeeds.
+	 */
+	bool reinit_pending;
+	/* Protects APP interrupt enable registers and their software state. */
+	raw_spinlock_t app_lock;
 };
 #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
 
@@ -322,6 +332,21 @@ static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
 	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
 }
 
+/* Reset and restore registers while clocks and PHY remain initialized. */
+static int rcar_gen4_pcie_common_reinit(struct rcar_gen4_pcie *rcar)
+{
+	int ret;
+
+	ret = rcar_gen4_pcie_reset(rcar);
+	if (ret)
+		return ret;
+
+	if (rcar->drvdata->configure)
+		rcar->drvdata->configure(rcar);
+
+	return 0;
+}
+
 static void rcar_gen4_v4h_v4m_pcie_configure(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
@@ -513,6 +538,26 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 	return 0;
 }
 
+static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
+{
+	u32 val;
+
+	lockdep_assert_held(&rcar->app_lock);
+
+	val = readl(rcar->base + PCIEINTSTS0EN);
+	val &= ~MSI_CTRL_INT;
+	if (!rcar->reinit_pending && pci_msi_enabled())
+		val |= MSI_CTRL_INT;
+	writel(val, rcar->base + PCIEINTSTS0EN);
+}
+
+static void rcar_gen4_pcie_app_irq_sync(struct rcar_gen4_pcie *rcar)
+{
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+
+	rcar_gen4_pcie_app_irq_sync_locked(rcar);
+}
+
 static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
@@ -543,12 +588,7 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	}
 
 	/* Configure MSI interrupt signal */
-	val = readl(rcar->base + PCIEINTSTS0EN);
-	if (pci_msi_enabled())
-		val |= MSI_CTRL_INT;
-	else
-		val &= ~MSI_CTRL_INT;
-	writel(val, rcar->base + PCIEINTSTS0EN);
+	rcar_gen4_pcie_app_irq_sync(rcar);
 
 	return 0;
 
@@ -563,9 +603,11 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	writel(0, rcar->base + AXIINTCCONT);
 
 	/* Deconfigure MSI interrupt signal */
-	val = readl(rcar->base + PCIEINTSTS0EN);
-	val &= ~MSI_CTRL_INT;
-	writel(val, rcar->base + PCIEINTSTS0EN);
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		val = readl(rcar->base + PCIEINTSTS0EN);
+		val &= ~MSI_CTRL_INT;
+		writel(val, rcar->base + PCIEINTSTS0EN);
+	}
 
 	return ret;
 }
@@ -661,14 +703,87 @@ static int rcar_gen4_pcie_host_setup(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
+{
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		rcar->reinit_pending = true;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+	}
+}
+
+static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
+				       bool recovered)
+{
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		rcar->reinit_pending = !recovered;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+	}
+}
+
+/*
+ * R-Car Gen4 SoC PCIe controllers and R-Car Gen5 SoC PCIe4 controller have
+ * a single Root Port per instance, so the 'pci_dev' is ignored and the whole
+ * controller is reset. The PCI core serializes the callers through its
+ * device locks.
+ */
+static int rcar_gen4_pcie_reset_root_port(struct pci_host_bridge *bridge,
+					  struct pci_dev *pdev)
+{
+	struct rcar_gen4_pcie *rcar = dev_get_drvdata(bridge->dev.parent);
+	struct dw_pcie *dw = &rcar->dw;
+	struct dw_pcie_rp *pp = &dw->pp;
+	struct device *dev = dw->dev;
+	int ret;
+
+	/* A failed resume may have left the controller powered down. */
+	if (dw->suspended)
+		return -EBUSY;
+
+	rcar_gen4_pcie_quiesce_irqs(rcar);
+
+	dw_pcie_stop_link(dw);
+
+	rcar_gen4_pcie_host_perst_assert(pp, true);
+
+	ret = rcar_gen4_pcie_common_reinit(rcar);
+	if (ret)
+		goto out;
+
+	ret = rcar_gen4_pcie_host_setup(pp);
+	if (ret)
+		goto out;
+
+	ret = dw_pcie_setup_rc(pp);
+	if (ret)
+		goto out;
+
+	ret = dw_pcie_start_link(dw);
+	if (ret)
+		goto out;
+
+	/* Ignore errors, the link may come up later */
+	dw_pcie_wait_for_link(dw);
+	dev_dbg(dev, "Root Port reset completed\n");
+
+out:
+	rcar_gen4_pcie_resume_irqs(rcar, !ret);
+	if (ret)
+		dev_err(dev, "Root Port reset failed (%d); interrupts stay masked until a reset succeeds\n",
+			ret);
+
+	return ret;
+}
+
 static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
-	if (pp->bridge)
+	if (pp->bridge) {
 		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
+		pp->bridge->reset_root_port = rcar_gen4_pcie_reset_root_port;
+	}
 
 	rcar_gen4_pcie_host_perst_assert(pp, true);
 
@@ -708,6 +823,8 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 	if (!IS_ENABLED(CONFIG_PCIE_RCAR_GEN4_HOST))
 		return -ENODEV;
 
+	raw_spin_lock_init(&rcar->app_lock);
+
 	pp->num_vectors = MAX_MSI_IRQS;
 	/* Reserve an iATU window for the generic PME_Turn_Off implementation. */
 	pp->use_atu_msg = true;
@@ -944,11 +1061,17 @@ static int rcar_gen5_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 	}
 	writel(val, rcar->base + PCIERSTCTRL1);
 
+	/* A reset retry may find the PHY already powered off. */
+	if (enable == rcar->phy_powered)
+		return 0;
+
 	if (enable)
 		phy_power_on(rcar->phy);
 	else
 		phy_power_off(rcar->phy);
 
+	rcar->phy_powered = enable;
+
 	return 0;
 }
 
@@ -1141,6 +1264,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
+	.configure = rcar_gen4_v4h_v4m_pcie_configure,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
 	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
@@ -1149,6 +1273,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 	.init = rcar_gen4_v4h_v4m_pcie_init,
 	.deinit = rcar_gen4_pcie_common_deinit,
+	.configure = rcar_gen4_v4h_v4m_pcie_configure,
 	.ltssm_control = rcar_gen4_pcie_ltssm_control,
 	.speed_control = rcar_gen4_pcie_speed_control,
 	.mode = DW_PCIE_EP_TYPE,
@@ -1157,6 +1282,7 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen5_pcie = {
 	.init = rcar_gen5_pcie_init,
 	.deinit = rcar_gen5_pcie_deinit,
+	.configure = rcar_gen5_pcie_configure,
 	.ltssm_control = rcar_gen5_pcie_ltssm_control,
 	.speed_control = rcar_gen5_pcie_speed_control,
 	.mode = DW_PCIE_RC_TYPE,
-- 
2.54.0

