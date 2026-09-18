Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020136.outbound.protection.outlook.com [52.101.229.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808536B929;
	Fri, 18 Sep 2026 03:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701651; cv=fail; b=W3+EfHZXs/9DLT7SNc5WtercLlv6DESCCMpjjrXeHd7TbQi20XRst4IFMjBHPi1452L94OyESSHUQaw4rYj5/ivWJG47rtrl/9USgRctM9ShcTXrCwggGnwNpY45CI0hWELmCG3j7KkTULCeSc1zphMB95219Y4zE5kk/350uDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701651; c=relaxed/simple;
	bh=pDRDnVSDkb2HjDUMpEF+4/DpN4Q3NA6qIIZZS+31waU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kuCCCh4iAC8QnAvaCqPsJyNZfytOwkz8kRvemuTWxIKb89HdFXnZqu88mL9EmRhruNhgvOYDoheIGjJJMgSgYhUi1/+zPRsvCFKFl4o7EBKbLb2ZbentZkhQcRE7gB7uonTJp4iUPUujNPBw7rilOaY5HNUjj1hbEkXVFkmViDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GKK4z5li; arc=fail smtp.client-ip=52.101.229.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GKK4z5li"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZX1x722J81eMIxTIyx0ramb6W/HOGlnYVRIwxOl65vlHLTlIMErN4yc07EwuLkU+fyCqWRjDSNsy3UDcJIZqwUMyTG0EmJs63QsxUDZ93a7Z5bOinGFTXY5px94ifJzbJtbJ2j7klYcRX/Ld0Rc52E3L2BMSUgrAZv6uoprWXPL5XJNZ08uMm9MLX7G+lIp3yCX+6QJ5dFwBpgRgmKk9PCcsLagWkX3DyELslukTYTS19oGQXFFmTCBf3cdLTn6Nx72Za2PuZ+QJ1MkfKfvj32yWF+JPc8FWg1Q75mIhoA+xOZYzE892m6Nn40iLvUY44+K7LB/22YS249EvMQOR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ympRvt843kGqtsBZYUvp9EIuckEy51R/MA5AgcX7Ozw=;
 b=ZCzDI62KqYZlP0pJ7IARpjLV5LiS41gAO++kDT5xWrZODzB8msIeQOsjHxmQ1hQFgLwEsUBufZfPHCFgVAyxDP0Ue8SHqY10kSCeJOC1kXxm8ZSwGO7VX7+wXAzl18QF3q7RbswgaWN4FmZEj442MVEzRS2jNw6cfnUI3ILUduz2+prYf8my8pSXWeHFbqkgm7NP+YB/qxxrnTYJch+zPxvTixM7eZ6R9Cp8oB9nkzl+sCZZELdXjRjB/JXYcK401tILSIwslaWad8I5xQbM/Jh++nf3ZLsbtwfbrsOgpFpm4gjABeY7OXeUpNLdcEufNOzpYcyz1T+8hSmQmx7YcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ympRvt843kGqtsBZYUvp9EIuckEy51R/MA5AgcX7Ozw=;
 b=GKK4z5liWDjktuFNac3VilOsMu4rRVHafxHsT4tixaUmvfBPIH1gDzZ2aNeAZF4DZ5lu6LokwwQtJ62SzzPcecBLK5x6KZ54aAzO9uiFvrtuCazsMmM7tvFDgnIlHsBehHZcY0pcNtDAeFfQARb8ZIt8QDGPE/noFQmmKduQA4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5141.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:350::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:20:44 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:20:44 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
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
Subject: [PATCH 01/11] PCI: dwc: Add Renesas to the RAS DES VSEC list
Date: Fri, 18 Sep 2026 12:20:28 +0900
Message-ID: <20260918032038.2216471-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260918032038.2216471-1-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 243ed47f-221f-4238-4d65-08df1533d35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|7416014|366016|56012099006|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	ayEOZR1TZU/TQ/aFWs8pp0E+r1x/qfMbAghaSANaPdBfzJmnQ3oRUl+pD1BIFeiH7WOncZkRUKpgZGS+U0nJCBRcqUOYme7kjXzKIdbvSGo7Bmf34AuuczxxVQnyA/GqClpiQWx99+z+wrKoZcHRtahnrquU+9uO49SRBHvRPzGPnzAJ0wFDz/maCSAYoqysaNT4bE/1arw/9bSCod811ETJYAAHAcGDRlgtm6ENZapQZMxL7sRsDkFYx0R+WbvM/CJsnaOhChtkibwRr3VfhO18m/OmbEXAuKbtD39KZ6WtpLWiTi9mPv1/hOqhLh270iftIdwghzU0WN5YbZWt3PGcXsswt/ijfMA/FGHM8r3tOqHwWCgWoOMmUkJVIXK/O9z2LFGTWwIp+WdmOXF3PE4bnBCVcSGlgkFXqRaS9mQ97tFcPrAF9xw7VDuSNGv3tAcL0UZYwkmw5RcDuEsFZDZGqo4vPG429aob/P4TNbeCpMjbp7IZF31ShU6Ca7crAdMVNAGU2iCpZhC0vaIH3sbNe95IAup56XhbBpdFvfce8lm/kkyXeRzyplT9UmSVzGbCAqew4IqFek1GYsIWzUhIUcziVxV3S8oNU2mm3nT2vnYS2SiW/dC2/wqETz2cSi7EGFNPfIGrvXj/lp+0RLtYBjuDEkDMRHG2FKnNMjh2rN2MGN8CwNfiCiQU8oJK83AePIsHqR7GXETINjFWhg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(7416014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RbWKMiNVuOsL6US0dv6nFbW/GzTXwsg5ElsJHizi5oq2JECU4sDGI7YQLUNv?=
 =?us-ascii?Q?mwroM/DxQinvqcoSTitjW58w6oh4ETVpicQDeMePRPvmn+hNtgQTQZpsoovQ?=
 =?us-ascii?Q?LHxJanUGUpbyvDUPbzftMhGyNZtrkQb1F6bCbVumxnZ1/dzPtkEQZvSmnhKq?=
 =?us-ascii?Q?RjCaYL8XMHiymX2HK5YaAd6vGlQjp7NE5umR1jzO4bdDqaauItfWcMTNGkrY?=
 =?us-ascii?Q?qW5vtYkxA5eswCYvD9yxgw/ddvCYJH5jQ111Obbu0jEnkEDWtU4Et8onylyW?=
 =?us-ascii?Q?98PC2SyUnw5GjKG3ibl5uX0Dsm4jWpxejdF0grGo65duJFuoQWmPt7BfxyEi?=
 =?us-ascii?Q?kuWj/85Z5A2nRmdviX6+m76jjGaT03len8Lsd/GdnjIwpZJOEIYR+6FJ+FWB?=
 =?us-ascii?Q?Q+5+O3wz3VCQx663C1XOpNHk7cro/vk4/1EwutMLgdKeN10Cq7L4AU66gZ1Q?=
 =?us-ascii?Q?41f3mdJ+2OXglfryQFjzFuScVTmpItGgV1x48q3lxUh+idvUweyevEBklE3j?=
 =?us-ascii?Q?TlGPZjDOcy434av5PJfbOPAdZS+NCpbMc1vYnvWFd7dYLTZca78bbHvO8dGV?=
 =?us-ascii?Q?lT9OSkegaR+UC4nKL6ETrSy/x+eCzTMWQAwG1S6xV4SJ7/t617xW9Z4T2xS0?=
 =?us-ascii?Q?WqeejUUCPcMosoHJdBPtlv/6JMnanlEg4HzL3zt9jz0shWAMBd1hpOaR7Nrw?=
 =?us-ascii?Q?djA/PscK3z5Wz+RQDE1ohOzEN4ds3Qwp5dMd5DNI+j/wGoSZDYIbm9omYSRb?=
 =?us-ascii?Q?xMhWXf+s8pAI0nsCya2hT9ibFzCBkvCf1f1YG86z6ZL4d/N0UT3P1xG0u6oG?=
 =?us-ascii?Q?fWauKYSdReU1nq92t/+o4cgPAbdqvT+P/LUbQHHW08QNSbVCX54L4PBvtWnx?=
 =?us-ascii?Q?hovCA9CqdbQIQKLlsPWZrLgDuhErb2zLYHcfu0n6Qz1AviswTwh8jq3WDqZc?=
 =?us-ascii?Q?4dEl1OGYN165PWaI1jrtbKWsinSYfuu8+vIXpFnfWVgQ///29SULY8r1WqzH?=
 =?us-ascii?Q?kvfCyBiYr7dPsngTIGlx6KQCc83kMKEWyh9jMdb+PuJbPcSDmVkfXCzXrkIh?=
 =?us-ascii?Q?irMctvGzb5n6vDt+Gq0E81lRdctCqzTAsbTg9tMsIV5blfLl5mtfiQ2txm5z?=
 =?us-ascii?Q?veq0OA6QQ1/ROUYYlMCcruU8kSOq7SZkM0+VH3j+McgQ/g6A8kv2Hv8XDilp?=
 =?us-ascii?Q?YDl0lMVUtrwptkd7XYlc3lfASpezOqtqforvPRIVUF56QuEYjAqTZNGYXs34?=
 =?us-ascii?Q?wEQ0T9UFeXpp/7Vh/yhzDrBmHRDtHrZgPjZocS1DvjIn7ETo6OlmE5gWFgdI?=
 =?us-ascii?Q?MVa60IoVUjnnPeHSzDdIEM4LBTbB5+PEeHQtVkvHYcwL8O/6nwSXJRmM9bZY?=
 =?us-ascii?Q?hvwzlanmro5bTLvwtsQ5MQWmmBMw1/T296ET5X3mr+cenJ4p/5bgRKbiy2VX?=
 =?us-ascii?Q?RvKCO4VE+IOaQ6tEuYYUjPXfrW7HiKbOOsDbx06p0aJ3RH+pDaMsVEElvTzH?=
 =?us-ascii?Q?XMRX82uLJWDtote6aKNt/prG0NmXkY1RPbuMNBXTrR9AgOA1uBIGRHWqHTt/?=
 =?us-ascii?Q?cCu+K0MJ2BLRykD2Y1dKb8ccL8SAhvUlPmbkH6dGcN3gejKL4Zxi0hgBdoJh?=
 =?us-ascii?Q?hryW1ymra7dUjGTvm3JohHosfaYQoqmZyM6ZuYYbB1G1m8UnxgnU7R6tjsqA?=
 =?us-ascii?Q?3Dj/v5fBWw4YpKSGy9dZ6WwW143AeK7inkiSDbHHEb8kgQ8ZNdnOIX1NV9hH?=
 =?us-ascii?Q?/z+NrVya9RMSFQSf3jyJvjS9QanRvOaxT6E6ndAqmnXizS6c3NFh?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 243ed47f-221f-4238-4d65-08df1533d35d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:20:44.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ux74uQu80wKxcxWpU2f9Sa6W06sIihPPQMlr7bhwPFCMvPAy8QrrC8zRMnott3xCLqNGXRVipv50ivxebSpYTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5141

The Root Port on R-Car Gen4 (DWC 5.20a) carries the RAS DES capability
with the stock DesignWare VSEC ID (0x02, rev 4), but vendor ID 0x1912 is
not in dwc_pcie_rasdes_vsec_ids[]. Add Renesas to the list.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
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

