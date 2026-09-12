Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0AE429CC6;
	Sat, 12 Sep 2026 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789229787; cv=fail; b=Ysq1Umi9pR+nVAE1KasfEcoAiEw8M6QG7bPw1ujK16EweNomIkGAOUKeV1H7oPVcQDsYK8pKYhE2u4LcvB8Us8XdO4rztIcum5UIkIQWgGER9BsQwItzVLYYy/T6E5OPxyQZGSqDLPQwiinGXykH6tRT5NWEht74FygGo+IZuKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789229787; c=relaxed/simple;
	bh=OIwC8MsdPt8N1EqPWDs1GTqtgYgCdu2dHUUA7CbZySE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rCokCw902hCMFnGO8zsYo7PDszGeFWwtjKHmc0QJnAborb26dfczxDI4eXeO4dWzSaKdsTX+D6/SZYuPoHloD1r5eoZ/o3Rc61n6fKG7jzIYhkbwCOEdbWpXT9Rzog5PrROgSh13yQSwWhOfvD5LggXzOT2spYNTHwruN/G1Y3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N1sbYd15; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N1sbYd15"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruGGTyirlMjFDm+yMcw761zJFxTCKusXoDiOKi4TG4na4JGQMvtOI3VNQaM479kl24UG3fEpEZNsvjqofAHuwVBfH6CCdmR0Ay6x4jFM8k7s6HjzjKnknlEeJO2TsTt2Pfarc2xPcdMqFleedFPbL+qMwyTgwinvHNs+Hq/gmJN60mUd4oUcV8C/UOT86GRe1cIbgzzDJeJibq2Im9gQIxhU/T807nmjLeJ88IJ99Gh6k6VdM1ZRMEgo15SpQQYgWlPDtu8n2o9M7Sd8wa05nINC/6f9YbBG3nWWJX3ksmem9UsLSRL5cb1IB9pIZqUiqEkiAGBtxRCIppzXMMJJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sigBdbNoyhNMgqo4KhXtWcQSEXq7xG2EEhlfflBb5+I=;
 b=daIp2m5FF+ULz/4khuFXw5DJ2mTb5stC9a8RrUA0Zsi6i9i//PJ7uLbLte46Xsv9sCsr290E0N2mIrboTYJg3/Ol1T+3VCLdW7PLfAlXGerrCA8Z8snLmFlQdyXpT1Je8DqQjwx8eYsKlZUOePGFbRcQ41iPx9U6awPStctIRE5thNQrRiVVoUfnaPpFVpUFd9ilC3nRsZ0VxGK4ArS1ssZ9fUa99sGO+J1AUOh4tM87IwEPUjGnEZvQKTG8EN3YwGD3IKaXnnYSGIWDXXVRGplfb60lv+s+RqrOeXpgDIuxFD5TQCNsqxVr7i0AUTv44F3Wf0CnPwFlsD6WscECSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sigBdbNoyhNMgqo4KhXtWcQSEXq7xG2EEhlfflBb5+I=;
 b=N1sbYd15mQR171j4D3mBIEOy4A2aFP79LwQAeD8IoNZM0xlxxT+//N+E/o03Xw3zRzuSRvy1mM1q3PDDXqsiTlBvJy+jkHi9si69ZN3cs7VUDsI6hk58SWu8xP38RftwM1SqT7pNKTaLT2wKErMhFW2QrJ1SUIAJKn3fpYDEk3+qBrvz0gs5K8h/tN96WBf7j5I71Oi5Sucx0j3VNcmMsllsDrLJ5R0+m5kQXxZFqzdDtlv8pp+IqgvoJ32M5+xg5LUcul1AC7CmZHr/d2QDCCxjhvnrn4P5nX1evjhREuwkuMEooRG4tX9gNeMnYBAHeEOVtIqqmyV7nIk/JbiK8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU2PR04MB8871.eurprd04.prod.outlook.com (2603:10a6:10:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Sat, 12 Sep
 2026 16:16:19 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 16:16:19 +0000
From: vladimir.oltean@nxp.com
To: linux-pci@vger.kernel.org
Cc: Aksh Garg <a-garg7@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Manikandan K Pillai <mpillai@cadence.com>,
	Felix Gu <ustc.gu@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] PCI: Remove device links to Generic PHY
Date: Sat, 12 Sep 2026 19:14:37 +0300
Message-ID: <20260912161440.1032188-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::22) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU2PR04MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c44006f-fbd1-4442-f6ba-08df10e92ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|366016|23010399003|376014|1800799024|7416014|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	I1RlPiHP9ptThc0ajI+v7bPi1FjSVy6MQifNMMj4Aq7cYfEdH+3H/rAw1WF18CMp7teZclRl8A0+WtKmPhXdSsTwRgUvOIiJAtKwJKy+9/NlJrxzieC4JgAGZAn50wRoLyMcO44pl/pNoVVq+ipgVBv/AVNhgvhp2a13bJHnHSvQeY40q9iL9e9n0uXE35jUNSM9TnoHtPSovp7sPT2Wi6zgpYNDG2fgDt5bO4e0y3RcBRIVLOdj19o0bfYkyBF1ZznM5efPBXZJU3XY6qOUNMCZAGNdsD4xmQk2hDgy0HpnTITcV7zU5js2sAnyHQbFgjGhAxkbpFK5j1O5deHHDZ8TKXcBVryiHJdvdZCwiQyNUwoiMFb54GxG+4He7yGUqKaNM4d11LUVBaBjafapvcyVsY8UCr/pWHI8gHuWh6QMTnkelAHY/PkPD0s5MX4t2rn30eGPn07wnKrQyF1PeehSixR1zJOZ2sq3ekWetuY9ML1w/0DBYvrXZcMhy1QoAce9GAs10Jh/vmdl8MRSohv8qBlcQhE+YSuwqHF5OLO5wT0az+VzFJpM7tTDuY3Nhs2YR4yz78WnmIO+o5IMaNGld5SaOM78dNIm0Hc00aYSX/e6XkNOhLan8KyrhRuFNBD7U2YwqiShz0XHSmkEUkTAM+yJQFSP/fl7epdYfq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hknxGsSpr3OCdg8uaIO85CTPdLGGlztYonG2HQVjXjZsKMtw4BmGomfbNNjR?=
 =?us-ascii?Q?Ro80CSYKRVn+JWtf22yr5fubbSnL+8/UXifDSSA0I7pt3XSs7tSf1F3OTADJ?=
 =?us-ascii?Q?Bp8uvA+q/JXSletcNrKPI0UI5unmJvm7yDkguLMA7jDvm+tifoK1j7ZXJT4X?=
 =?us-ascii?Q?iFgv6SWKnjlNNtzzayEwFPtPkAkijWJD3U8I8FUOtFX+5kJb/VHfOkqIl50o?=
 =?us-ascii?Q?iMJmweBuvakelue1zSooONIzR6O47Rt0L6nmK8hayyzexL+z2+tLcMNtWRSD?=
 =?us-ascii?Q?5aRWMvCp3g19tHwut1TnEbA5XUrZMi6+tx0ZQDUxM0913uGS+0+g3lr5yYP8?=
 =?us-ascii?Q?x15BCr+xWygCybGM/FkHnsiWLTVa3ZKH8IiPfjLxPAGAd6VVZ20p4pHyxS2p?=
 =?us-ascii?Q?lQ7IA3HBrgA2to4iHqQWRBgcoX340MQbi7676QL4sFz1AjbSg/zUPtwaWRxD?=
 =?us-ascii?Q?Jz47xEKEq1U1tzwAhpPVZsuoyHKdgj2c/VlFnZWPzpxcGKJ7DkYv1VEg9cPg?=
 =?us-ascii?Q?f7nf0xxQJAiTBfVw4OOnxSqse/0m78Y9MJfXIFVGoHABhxEYTze4VGpZqMe/?=
 =?us-ascii?Q?Shnsz/JRfwvPhVwtl3aNLX8+jZIGKPxKoSD/MXfNgLjdPu8792tl85arl23y?=
 =?us-ascii?Q?QCxp2qCqK5xN5b8otbAw4+cpzAG8ggLRiB7TsWdRlumuKslKZlgdLcJpAmtq?=
 =?us-ascii?Q?Xr/9bn1JB5DJiQaU1t0LbUyw05xhj/x8omFlYsxwUu1gxIcjSRBPXJs1wzB7?=
 =?us-ascii?Q?vOIyJfgPLck+cmQ3+4GEBFnNIf5cHMhUp7KCoEemr1NpOndDsHTivwpD/k42?=
 =?us-ascii?Q?P/vM0xFMBBcj9VH0TXUJW6MZC0plLL7G46E0yroZ7J1589Km3bK3pcoljXKy?=
 =?us-ascii?Q?z9GGqae+er3ditzY/QTrEvRmmyayKJzwXHLEiWcf8v8/GE+h/FaXg2r3u1nb?=
 =?us-ascii?Q?nTM/7Cy6+1KHJqkySnDNjuqyzfYquxuD4m6gFN3psKFuytFO61Xq5c+3mnC2?=
 =?us-ascii?Q?+R8ZL2eLVV6otSynnI2+GLhK2uU5T22WEFADt2IgtgoCcHMweeotmfXmsBbP?=
 =?us-ascii?Q?UTSb96wU84L4Ps7z90p2qbXl0H5nHZDzCrZC4FkYAau9Pu3Lvd1Z34qiHhMJ?=
 =?us-ascii?Q?cELCGC/fS/GXXdw8TPqHURAZdAA3HuBbBs6X+/tclVaoQJLF/PoUWmNytyrd?=
 =?us-ascii?Q?PJHvb5HwyWFxL19mCJy6BqmiIVJ9Kjkjpnu86AoOw5PMiNLOaLskCc2doM8M?=
 =?us-ascii?Q?ruWVh/6Jha5Uf+LdSrdHH3L9xseYbN60WhR49Xy45KgHmS1I8KwBejmwqAF6?=
 =?us-ascii?Q?iVdjNMCUDiBPwYpwkgcAoJsMhQr3FVX7hIH2ekfuPxm5VMoqvAF11fGmIsv4?=
 =?us-ascii?Q?yvJYiZQPZrVYqwqEj24Mg9AdaQiuaIphusHOqIWHeME3fo+5Per5Pm5VSz41?=
 =?us-ascii?Q?iLoRfAWaWP5pyRGO9aGA1CShChbYy/I9YakxjBlMZUHokN91EGXP8TnnDgeN?=
 =?us-ascii?Q?SrHrLGPLV+VZ8zk+PmygEoO5QKa2CphnT9IRxhIBt9L9mFkLSIOQe5USN1QR?=
 =?us-ascii?Q?b+pvtqlzLgvn/6bWIwAYZI/R89/4zuNFkZaOyTJlmVMU1F8SrHqH1RreLN6R?=
 =?us-ascii?Q?vLblYBne3Jm8FqhC8NGvFM/dFDxUHoTv6pubU+ZS3wnyetMLLznJ1v9vl7UO?=
 =?us-ascii?Q?H823/3VwUWjkD/whVY3swZwPVg0P7oAeQtURyqEf/udbsJWZ74TYx9ndYef+?=
 =?us-ascii?Q?uwhQKfTMOaAuF3jECPRsInEHogTcWIh4RrgslMbmDabtsIAoZizXXMymRXWo?=
X-MS-Exchange-AntiSpam-MessageData-1: 6ZtcEwg3yNyko3tRzgZ6Xz80LmWF2rZwKzw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c44006f-fbd1-4442-f6ba-08df10e92ddc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 16:16:19.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjeNcKE/6gyh3qK84C+Gzf/96HqvazVnENiKwrh7ofjW/0jhIQTCqlRFD4PDYUxZ6ugiEJ87T+VgEqmge9ir+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8871

This is a request from Bjorn Helgaas to replace commit 9a9d18547ddc
("PCI: Remove device links to PHY") from the pci/next branch with 3
distinct changes, per PCI controller, to handle conflicts with bug fixes
in the same area on dra7xx in a better way:
https://lore.kernel.org/linux-pci/20260911221209.GA587622@bhelgaas/

The patches are formatted against the v7.3-rc1 tag. They do *not* apply
to the current pci/next, as the change is already present there.

Previous submission was:
https://lore.kernel.org/linux-pci/20260810124315.433448-1-vladimir.oltean@nxp.com/

There is no other change than splitting up into individual commits and
adjusting each one's commit message. All review/ack tags were dropped in
that process.

Vladimir Oltean (3):
  PCI: cadence: Remove device links to PHY
  PCI: dra7xx: Remove device links to PHY
  PCI: keystone: Remove device links to PHY

 .../controller/cadence/pcie-cadence-plat.c    |  4 ---
 drivers/pci/controller/cadence/pcie-cadence.c | 16 +---------
 drivers/pci/controller/cadence/pcie-cadence.h |  2 --
 drivers/pci/controller/dwc/pci-dra7xx.c       | 16 ----------
 drivers/pci/controller/dwc/pci-keystone.c     | 31 +++----------------
 5 files changed, 5 insertions(+), 64 deletions(-)

-- 
2.43.0

