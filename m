Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020121.outbound.protection.outlook.com [52.101.228.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B53B95F9;
	Tue,  6 Oct 2026 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276415; cv=fail; b=lakczZsbwIj4LvhGHJJ212ffKdvNicQrTlpzNVxaTFqiKPWLGvpbAmIZ94WYKpJGFJkDt/LWmgn+O690K/9cEoQWAvxgl0o6Kqc4AIw8pLacI6Kv1r2woCYtG2ty8Ve20NUtVDXELJB4lnmqMAMp/c16On546L0vN4ZMmgRlE1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276415; c=relaxed/simple;
	bh=X9qiO79gsL3t/fM3a0BIGsTcb8cXgB6/Skh7UYns23k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mr09CSyZCUe74U1yAAozq/dyBvNoUIO+OGf7opKGiN/Ev3pGdWodR3vd7rEVA+eFD3S0nD2lzylU8LIZnrOi0SXTQrnd7YKKhXtcLoWi2PPfgrzKJYcTGm4ZzzFaxOrKAqzg6L/gbLwx1QRlvfWA7iRGxDfWqt7tvIxvdFcUm6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WLyoqQzE; arc=fail smtp.client-ip=52.101.228.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WLyoqQzE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+6XeplXipQ+dOZIfawphf7pLaJXwnMCMFv+Vl4nksC6bH7DdEYsw1t+wb93l0g7pIteLZsCjcgXx/ezf8WugaNBuJbHV388JligpVNujXvRmkEGw9We+pIKMK+UpmuL1xQf1Zc+r0jN3Pca1Uxt5qmj8H8GToHCHgT1/S7muiFXBX3sOkAWsUeiKLv6f3I0i39cVtMs6JEPLiCZMu90U7GXxnvYXXJmkgwMer2raIR2kRcsjCut3npHORAo7t2+PQqZoVNwhoOfxO6tjDlcp0yZNAO2rCBH4hcK4aIP0hnW3toIaFFyzH2kUuDH9kOJZ9xMvhJWQQFMyKk14yeoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LM4wraq+LJjWGb2XCBeS2QJ8u02sXZhzXXlool2nOJM=;
 b=MHje3B8bd8dbnL8WZLfRhPaXoW/IbdClDYED54fFMbBjdOGhtlKbeRHRPGod5BL2VXR3jNslU68KWGyd8pYYk6QUz/AZYO9H028/nYpWTzw6aZjwh6cWMo2aQ4fHjZ91p5HreIIKp4dtvCFWzigz/N2iOq3rIuf2RRkE7YxNzHridMrHrsuIxGcyN8m0iGYxfpmwHZhRdc5BI4Tml8CNBdUXCwOOtdYoyuw1eg88EL0GF1JfHmhzIlJLotmKPWVT4dc4L9TKtUul15aFtVn0fe8V2GULoNrpB1ys1AZ/wQthxHtelm5O4mtKrSNpolTMGy2lNRb5cZNOz316/w+Nvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LM4wraq+LJjWGb2XCBeS2QJ8u02sXZhzXXlool2nOJM=;
 b=WLyoqQzExXwE1LYIa1Uo5zLV0mwLXCkX/BkFGBakLQAks+/aALY3WNAh/BS2YUTAtJGSXPbCPvTDFGt0rp5W9QGrJzRAlAIy+DNDXL+sPeqmS4p943pr4rZODOAnyP3P4KYDsEvi7jX2jVBSPgUWoJrajhnDQL9rOgbLpKmX8T8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:47 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:47 +0000
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
Subject: [PATCH v3 01/18] PCI: dwc: Add Renesas to the RAS DES VSEC list
Date: Tue,  6 Oct 2026 17:46:21 +0900
Message-ID: <20261006084638.3821710-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0046.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5f562f-b53f-4f44-e089-08df23865a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+kvVwlZrmEr5URRQaf2ulr97in2Trj8S07bYLFxoGUnAI9ysbAZxYtgxFVRFb69T19bAdJ7j6znc6Fdt8IxS4/LZRQyZ5OTa5DExErLbLpCjBvZTEvd2jndW/+Zz/I2bRE9syiEmeC1QWbUBgiBpkgnHxWG+fMb8YkBm9oOsfQ6bBeAefZ40t46YNsC6WmYuzh8iemGjCY22fQEy30B80UdGCMHv33h+dj+KiQrtV2Z5e41jdw9BJdt9y5GMSRa+q02ENobmbZ7lNyw1NuuzaEWRj0ZvyPfL3NjP7vx8M+oieDqw1R9+KSprXvMwsfvT4VfoIRVltrrixhAE6zRwkLhVvYjdqKFBtwmjWsfYQazlbr1pStXaf0V3kr9/r24sOrHGVm6QQuhHN2Irw9GgiTN/EusXxQYKmSHPSuDnv3IMYHX9b2ErOOxC0eKmAk/1CPxj8q+Jkkp81YyTHdSipXOnFcbuuPfDwpmHfoIoHtRXKT+bjhUC9Di1a4zIRSASYyF1yRCZ9j1LCd80VqsNcTuzRM3x95CgUNjTJQTFTkoPTptP7ozJ7PE+jFVzolPmk3qxhy/I1UPaNCFwG5TDZx5ktkxet9RKIInZSin66iiChAb0H2GgOdkFbPDHK8SMmtdW3C1jiDu2LUIPKJlUarFdEiUCDUhNT25he6oEvWUdeECxSEq0+2iDTRW4toUYtejQ8bHT0EDf6019ydBGKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?au5YFyu367pLHWOrEpNYhebfsezG9nYDnCZsHCECxIbYc+82Y63CftF+hWu/?=
 =?us-ascii?Q?dYuGfl1/uW/KZ69VmS65FmCH8lmn+nVEQNqRkmGPTAgxJRanjwtD6StSCd1g?=
 =?us-ascii?Q?yWNJr2XfSyXhSyz849spWpKA5Hb04OAVscqW4yHz5g+9GqmQ02O+WNyvcHCs?=
 =?us-ascii?Q?ST9j2b8zWBjvW6cGIeRuWR0lSJz8Yzx9Rh3QBojLYxOZPg9D3/hzPveTAJbA?=
 =?us-ascii?Q?jbK4XzMeencKELfDrhoY2Kvobfzq8CFb70VD2R1D7+ny+pHSjiAFG0kHvpZl?=
 =?us-ascii?Q?PVCj9e/IK1vFbYNJ522Js34H3ymGUBsBl95rjtkr6NOHc6iRpY23ODS7Yagq?=
 =?us-ascii?Q?Zhk+mqi+CHRf/aBx6LutYysIpct8qG+zy8s5jq4TYZ+eQ0IrWId+/0YNhXQ/?=
 =?us-ascii?Q?iQIvRh8V7RVEG9TyIrcP/T9eTKK+3NXPvdO8EKUzIVJky+nFi4s2TYf942iA?=
 =?us-ascii?Q?0vhrPwhuGFTdfQIRw1pmYp8XQOiNb7HOhbdMiAmJUFeWmfhfT56aazXlvFQL?=
 =?us-ascii?Q?p1UEOuPpA3CUItIiTRcNJwMn0w28gCT0/pA0hfnu5ffRnAxXdq7dyzgr4tir?=
 =?us-ascii?Q?Fug/qRL2g5xUjoL2Z3FrjG6G8BkP4yD0w77PRm8KebFI9+Nb5Z2sgW1A8BxJ?=
 =?us-ascii?Q?8SxrBPvCjMx7CCwlYhUdRXLAVGS6krHkNDxepphMZKZzvu7QVFZ/jfIMDOyP?=
 =?us-ascii?Q?95fdFMAIQ3QLKWo/3ijkgk+DHWunSraSjzUPWzm+kqB+INBVf70hUJ3iV3aN?=
 =?us-ascii?Q?eON8/uOKjV8keq5t/AuMRBiR+zpjC8+caSGEivjAb19AEuuWLDZJzpwAYk4r?=
 =?us-ascii?Q?SDRPpLyOiV+P3b/f9TGBPk+dFM5xjrF1R5Qy8r1CaKUfCX/yr5I4mlrr7syt?=
 =?us-ascii?Q?ux3S8Vb14xE/QuutFaRxGRIAQspI6cbtUek5w7QNsQMoPosA/4zPv6ktydx+?=
 =?us-ascii?Q?cS99UltqjqpSE8Un2NSZ/yg8kYkoVv4x8ubLcN4J3h9+h6MD9I35kgejO3Pj?=
 =?us-ascii?Q?aBuWUfdKB59uMC38jDoBCGoqdD7bGmAXuCMCjDLJn/3ZyTnCWpzERyZIUtYp?=
 =?us-ascii?Q?Bi8gWUR+b/w9KNL3gzFdYMyOliYROKs6n2thHVQPfqWmiuvzQJz5meFZcH4E?=
 =?us-ascii?Q?TycSEnz5CZnG4Jmr1tkrL7LEq3Cas4fhbR2aoQfs+khayjW8MqAW68d/htq0?=
 =?us-ascii?Q?jvvtaht0ugDXGQNSmueqLEMp95qFCU844V4s2UmIy4BHplEm5oieLTfyKc8Q?=
 =?us-ascii?Q?Ah9K3LpOQubSCXt1jhP51MDPSGeVUgI6pHI7ZSKhGgYd0I9p7aY9hp8f3yu6?=
 =?us-ascii?Q?qd70zH5UPurfZ5Ib1T1MEkI4k5fGhTxjBItGJ660D8TR70gCB8TPXOqR6j7P?=
 =?us-ascii?Q?lIg8C39MHzQ1SzsFZa4Qs9fbtteYCtMRPdRwYtzTpBWvfZ7l1YozWsTO/YTz?=
 =?us-ascii?Q?E+/bK+9P5rFtM35k57GLRo6aOGh8yQSHvYzDSLezUDM11oVPaChrZjtRx1t2?=
 =?us-ascii?Q?IzxpBqIecpLo/7WocSJZnv5hfXrMt4CG/v0+VgTz302ECKNAvMlxBM4FLAIe?=
 =?us-ascii?Q?Vs8IyZbV5CKkCoDr9HgjQHSJA7WJD7TVyyIRiU2+AZgnLfhAQQgN1Pj/14XM?=
 =?us-ascii?Q?VOPK4H46L6rZJWqjSDCt6wHViDmdMoJz2/nez1vQZhUJQd1/+UeFN/dBUbqg?=
 =?us-ascii?Q?KgSEmLxzegkoMjbyxkL5m++PdhGxQMuFElK7kAUBeqBv5rFO0oz3FJqZrUVq?=
 =?us-ascii?Q?G7zxfsRurlqhTvYFsrlTBX/Tvzkb9S5acU1c6V+znLvsVqdzGIrD?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5f562f-b53f-4f44-e089-08df23865a53
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:45.9166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOwiWZDOL7wLh6ksJHOuwdzSwF9IlUhPrjBMMhgUEc+8J0ixtpOwUf6xszNEuM/z+pV0aY5NcVZ5YBA9UXCQUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

The Root Port on R-Car Gen4 SoCs (DWC 5.20a) carries the RAS DES capability
with the stock DesignWare VSEC ID (0x02, rev 4), but vendor ID 0x1912 is
not in dwc_pcie_rasdes_vsec_ids[]. Add Renesas to the list.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Clarify the SoC generation in the commit message. No code changes.

 include/linux/pcie-dwc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
index 097e806c714c..e5693895dbd5 100644
--- a/include/linux/pcie-dwc.h
+++ b/include/linux/pcie-dwc.h
@@ -38,6 +38,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{ .vendor_id = PCI_VENDOR_ID_LECARC,
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_RENESAS,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{}
 };
 
-- 
2.51.0

