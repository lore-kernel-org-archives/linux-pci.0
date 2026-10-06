Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020139.outbound.protection.outlook.com [52.101.229.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C03C108E;
	Tue,  6 Oct 2026 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276424; cv=fail; b=o9hfi1cbO0t9EPsxrw1FbUrWTVhp3lrx3dReIih309CfwNfBXm0RAtvbwnA7OgKLS+Nw+Ah92ppVR2A4+GWXebZuDYDR8J8fsty0msf+nX+zqvAFMSit1rRIaSaOMBSWn1PAM3lmEBe1FBbfqU178pt2emXOfsFq9ng9w9Vivdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276424; c=relaxed/simple;
	bh=o8lWgqVn6/qargN+nM3jeL3kfP+5hDt6RwYE/gQJF28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HHvOEEw7hp4cVl4pIyoFSmy5mdvttIhpkfNJLeFcd9ILEHopKqHjVCJlWCt03A2rOmeqXRRs7HiBC+xnt2BO/HAZZr5gYaltLm6Opz0w/RqGjUPA9BlDwUBPeHzNDH5+DcC30MMSgFrfoqzI04YnFIszzdhJTeJroamu1nkODeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Dz9H6NsB; arc=fail smtp.client-ip=52.101.229.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Dz9H6NsB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+x6xDY0Y33vdQrXRoiYNUi/uE2+j33cCIYACqkw9BQY4vGGpeqRd3JUGQenSGJyio3rsXzex8Jw73TPhI7Y3GQtGaqNH+TRC2CIdGloTcooAwZYT7Y5jX69Ls1vABoMTug/X6LQwEYyfpMITzB3a0ySzQB1NsIAXeuzsV8kcKH8Whr6+Mtpsqjtsdfg3nNW0AnszdOlc8aerECObOHJ9+zrS4dripzb9QfA4srX4QOJo9F+NKyw2cAn/XLKx7ggs8F5dbc2qAHMpotli4RZ7izuSZqY7vmP5oEZ5ERlWK6jU0vbG6eiJJFZvJn9Bw2gu+7ObczGh2ziszJqmEtGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fgnFevfDzbbvtNSNynQkKa4UyIHN+Q6FfaOIeN+WDw=;
 b=sGhIZ+vq0gKcUQ7fvI9rbrL5S5Zf4RxdbkOBCQ74O4oYOch6Jjfuiav+q+LbAsJO4buNgMCcgaEsp331f21ElYcw7XVk8VHgT1hVJBOEqZkEJNvBwylxjBIjKbUShGI2Dd/6k42wxhgjbbBNDCLjFN5SD3dFF4DibWZET22UVseCaLIdEpzpKxS3uoFry8vq0NSDiwbjRWihvfAYAzW2Mb3RfTAHHu1+UdU4XJPjBJNPNpxusjWDpsGsrsNj2UTipswTVSCkihqGOJM8FezTnNyvOlO2qqEVn2qhFEYzWACcWiJcrRSJzr/7e8v+irWdPLT3QXOO4CtFsvN6kI71rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fgnFevfDzbbvtNSNynQkKa4UyIHN+Q6FfaOIeN+WDw=;
 b=Dz9H6NsBmUY3AWQST913IeyknDpt0baY7rwrUc6lUriheluQPxNznrCKNhRjLdJxsOUiqXSLaEYkEM89asnpeOCL+IAqs/9rSQCdR/tUF1wTZXZOzZxqJlnXuzQYq6ZMmCC4Y545+mYl8E27pzwv5m+iFiuM1f1yhpG8z+g/wrQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:52 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:52 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/18] PCI: rcar-gen4: Assert resets when Gen5 SoC PHY initialization fails
Date: Tue,  6 Oct 2026 17:46:27 +0900
Message-ID: <20261006084638.3821710-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff1a424-c144-45da-0c21-08df23865e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|6133799003|5023799004|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QT6AW140Aw52U1ltZUFQb9ag3JatHtlTemuinbvL9WZWXD57JgoWW9fGJ5iif92vYQVC6NeGuBdJjCiO5xemDYcD2dk9v2nfYoJLEpKxYgkkssZ0AnFGPEUKcrKnm7R+qVCFOhx/CdWfLE60K2Uoh6VIq8GLCUPyX/OtpIjLdbVrpvDJ9sHpj03h7B3KOsFuorCn0gbtpruoOXBDuU5DTz57lVUYe7Hbfh4a9x/a7O1rKFdgEpscBSZ7S9IDL7Vl5ECExaquW+MPPnKRSnIjYggLfiw/JPuvjmvNczgXZ23lYnRsodoxOSKdXxzv6rv214o47c4uAeWf6Cb0NSwZ4P6w2gJmddF4bbF0A95n/T02bJBCmjF45LWMwoPzetGlZkpE7by+fqCkUeATUg+f6JLHGfO+q9GfJqgaiS3+f4byIIkxm09CxPZ0oO9Z9e2HcYpCCCk3XNNtvVonP1ZqYW6u+uAyEuMbmkr1cCMqQSMQPVHsSL/JU34LBOM7HTUWbs5EpY5/N5buNtzJcqszyfdvcDHR2kAuDCnOUzzbErB9+r73WzEU6W9pxWzG76sJhyZljWuUDZBh/44xhhOSX9IowSN2cwmAVLXTDXhbohZZnCaQzXArDYWbONPWnRtfgqxTV3wkDwPJOlK8T2UFSdYbGlicF/RGs5LyqSybLOo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(5023799004)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b1Mjh+vQQFTc6Sqavf0iFUoNF0cITL754d30AMPOIUAQfXV+mHP+gkZXdGEZ?=
 =?us-ascii?Q?+a1sb1NIM+m7MV0vrUYkKvcNaEe2Oy/5Hh9KG6Zwc88WbH/K4EF5gp+N9J7q?=
 =?us-ascii?Q?JgPxnPVX6lI3GNm5nfoZOAPhf+xpn6q8U20DZVfl8MTFhzvgXw7TV6Qy2iNR?=
 =?us-ascii?Q?H04jtdFS+PJyBJ0u9lEXbgCcpN09Su5QX9Zs9fXBp7nmr7L5PKM9CHTrM/FC?=
 =?us-ascii?Q?5ictSoGTzJZPc2sXc8+BfAs6u8axsjNTJ31Iwiz8aLHBOwfd3mXY+b6buqzZ?=
 =?us-ascii?Q?w/kw+/qDK2ALjuho39ndKsgxLyuAineVIzWXFEN2PnENVSLSRIBM9hB2YaAM?=
 =?us-ascii?Q?OkCzPJPhPISnI+eT1CyQC8TeohWmw9R+OydgB3cffIIKY+TsIO/VcVQTLkMx?=
 =?us-ascii?Q?gGwoEgOsxW9wy57UuEw5jpIl19pW0sx1+lQaetrnf1p3Q+7SCAvEEAyVYMZy?=
 =?us-ascii?Q?mt4oM4bf6EB/STbaVT+z/y3Yc8xz1UYQvDINVZCavp2lbsS47MLG1wDLR6YV?=
 =?us-ascii?Q?OHW+PQWgXQgarpZWVGUFGYlX4S1ryeKfGx0uwzSHnROMPb/P+5s0RevLwSdF?=
 =?us-ascii?Q?9u6S5C3RP/BY2FCZfUx4mAv1aZD/XegLAKmR/KIz0ztyuka8wbj6ZUPQan23?=
 =?us-ascii?Q?zFljFMrtRuwURJb0KtptRz4xT65I0P6Z9OIIBnh0WRR/yqeIdG4vpZm5FlJK?=
 =?us-ascii?Q?SG04uZIwkuBncUJD5UakrKXxsSHjQkUJHG9OqwtvwYIdrbkMk/W82zzLuJgs?=
 =?us-ascii?Q?9B9PaRlnvbAGSwvr6VRCrgG0Os+c3Nt9oTw53AQVRxVIyYnzUHtZFacxVs68?=
 =?us-ascii?Q?0YuwQnk5r0y3JKq+VS9yZYf5DU9rYCHrppOwdn6IzpP0Q1xx8+wgWcHAjb5/?=
 =?us-ascii?Q?d5DnGfae2xzxI1KORedMLf9u9kuBadi3AkbOFrGj/WCF93xJQG6srgM2oz5R?=
 =?us-ascii?Q?qGMVb/8xySqGUspvONgrslqLlmMVPiwSqKkEkC/WI9BrLCB4wGakVWy/dcIT?=
 =?us-ascii?Q?bjCCswaVVXsNYiMbny+l0UWm3urKG/YoNny3+T4OdwB6Rdu+hWPmWzyByGkT?=
 =?us-ascii?Q?7ZxnIEkouTAuHY6HByUZw/reGQRXxRbMxXfmN06WgTiLSkLl4Zz6OC/RyrLw?=
 =?us-ascii?Q?zLNpcrwFUcrbWBZqFi5wR+LEy1g16JK8Pvf7x4d+v38H/eBH9K0FiYdnYLy3?=
 =?us-ascii?Q?8goooWx0MOI/mC2WzTN8zfx2Jq2jR6Q5aZSaJvzfzdJT3JgMAXjbNIiuZJUd?=
 =?us-ascii?Q?ddtC12HcTOABznq6rlOuKLENPLaP0W0mLmaCC/l7p825UOEPjjbSUs1DaC+Z?=
 =?us-ascii?Q?ga6/Jf8XRZfen0ci7n0JWQrM4KGc9bNOQLinIMTJ7J1MNJ4mQk1AFxeXEU4A?=
 =?us-ascii?Q?gDRLFK9BR+ax76Ni5EXZ7KtRV2OxYEWZY/6Z7Pce5SrGr4lixbcRc6u2EefS?=
 =?us-ascii?Q?wyZNZNVwDlJQIo82ciHExou6PppKBPmn58+WeG82qf67JpBrJWLD5uihaiH/?=
 =?us-ascii?Q?8u8OTJo0lZ4w0r+z9ZcTxo7KRZSh845LWuLchuM6AUJ8CngOszJ0646Q5Mtv?=
 =?us-ascii?Q?RUo+irr3xpkNlIs9i2kf8wKwK1uLtCWSZiiOECH4QM1ms5gGReEi5w4gbECJ?=
 =?us-ascii?Q?TMsVEgeN9uVxzPauqz1ICGy7FvQtzsVM5xvcaQYP6KtbciJFp1iPQWgy2omT?=
 =?us-ascii?Q?X2pV9iSyUTyzqZobuRCk5UOlcAkenUjJD5qVxthmGJQ1cr+6xOBtnH7JwfSV?=
 =?us-ascii?Q?PbRO1ePmn4vBjQWsQQwExOJpp7daNu0F8iXAbtnv/zeDfl4vcR/f?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff1a424-c144-45da-0c21-08df23865e03
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:52.0735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSkWrFsSFdkLHKA69eWOrKSbY43UcTKHQmjT5tA6cURJlwz8CZnfK33V0DwapnjiTsYhe9PiZOCe0FICpRAdSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

common_init() enables the clocks and deasserts the power and
Application/Local resets before phy_init(). If phy_init() fails, the
error path only disables the clocks, leaving those resets deasserted.

Assert both resets before disabling the clocks to unwind the completed
common initialization.

Fixes: 3283c4db6009 ("PCI: rcar-gen4: Add support for R-Car X5H PCIe4")
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Add the Fixes tag and Marek's R-b tag.
  - Clarify the SoC generation in the subject. No code changes.

v2: https://lore.kernel.org/r/20260928165230.3397664-7-den@valinux.co.jp/

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 0a845b67f6c1..e1b748a9d58b 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -379,7 +379,7 @@ static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
 	return 0;
 
 err_unprepare:
-	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
+	rcar_gen4_pcie_common_deinit(rcar);
 
 	return ret;
 }
-- 
2.51.0

