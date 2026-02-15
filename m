Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EAE2EBB9E;
	Sun, 15 Feb 2026 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771173549; cv=fail; b=dcepXj0yYXUIydgoaxPx2LdUcezLWEIlP93cNkcfVQyI+yF6xaKDhzv90zjynCAodvrU81tPHpVmJh+0m4GjG+RBfBO/lxvh47HxWh0t2HwTED8mx+NDOb6ZJHIF7hSe022/4wIR0RIFCREO9YctYJoof23YM6Mb5mEtbz+ZDRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771173549; c=relaxed/simple;
	bh=mUTtB8aFb5kR+xTUrZ52lLRiPJEjgs72ScZvmKIVD5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mP1ieGEheOkmcMP4ft1hsFMWeJbIqY43+QqYoJgwaHsA8AE7bZbTSqFkrdHfKVfiYt1rsuCS/2b0O46Zm80zFVqR7HydYdEnfQzjkju1PlRFaymf6GAXLhRds3pJF65Zn2/01Pj8Bq6qM9MlGCfknD29Bh4EaBE0+atAwQwBRco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Rf/Bmdeh; arc=fail smtp.client-ip=52.101.229.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Rf/Bmdeh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPk2REol8i/F+wzJOnwBj2gyzKtEOYPejrMli4iFSBmtaq2/RGNqDcUPCoueMibDdLLmsnAtHyr7Ib8rpDIQHBAj1QCsEuwM1oBfgyOCCNlHoEerrUfaPXy3myuyEcNcbliFBsaxdwVbHguzzaNmjynFYKrbtxH79ZP8yjjZo3aLuZWhHioL+yFQvS/9u1klakeLziBQ+NPDB+yCCW9ooFzt2TOP4VipD+c+/kwyVyyGCmhbXxUZq3F/IizpgSCAKFVWoGzbspTFR9rpZQZXDTIc7XklEqspdMC3VqqPAqM+i/Zidh0/Frv0L2Btt2r9v1m2ysbBOJvIGOA2Ka0Lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spInnTauDhyUjwxofCAO5D7/6vcd1NV/KlDf0/6wvIw=;
 b=gWXUZJIl/M0Sf7l3tybmqPT/omktEUckcZN9LJj05V1eQUkCNYHLnQHaPPg7h/QpjXVTrKpm7TeL2ufAZMoQaA9hDYTnE62J6QErdiSEF2Yfognkn/Wmo5FIaMaoG5TdMNlXpIQM6XVL2Qzf22V+mhWaz3KP1/Mo7jku3BAPhQRQIaUACekRA1kzMu8FL4oD0zBGyrvWR3CrlO+pv7g3VRSW31J/Uzx5TwuLm+OPkM6rVFAO7nNB8py6+HLgyxVojCb1U3sq0nrlgYASWqlrwup+awOId7CmZS04X90k9164tNRjeKq/9vss5mS0LxhDuSdAySwHs2RDBOqApMHBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spInnTauDhyUjwxofCAO5D7/6vcd1NV/KlDf0/6wvIw=;
 b=Rf/Bmdehzr+C0ylBR15947f9kDsTH9iA20i9fvj2/2EHtfp4le5r6wSnRomIcv8YzlTDsWzVtqCVULACR6P82C8i5U6HG7W6ud5Spfl4QcU630uKrsy2AxdT5Q9cWuoVUUdf0JYM14q5w1zVt5g8zAEiOOzDtZavaxN+Ey5bSHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5196.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 16:39:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 16:39:03 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	shawn.lin@rock-chips.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	ntb@lists.linux.dev
Subject: [PATCH v7 2/9] PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl window
Date: Mon, 16 Feb 2026 01:38:40 +0900
Message-ID: <20260215163847.3522572-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215163847.3522572-1-den@valinux.co.jp>
References: <20260215163847.3522572-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0089.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7ff893-7610-476e-4e6d-08de6cb0ba7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pqzhDGyC3ZjQRAYdWKQdzo43VbPD+eAi5ZyhB5kmBku41UljkFZYYApzlVJi?=
 =?us-ascii?Q?EfNwszS/ObfnVhDnQGGDZzvC4xiDbAYm7ry9ReYmj7Xclzi0Lj2GTAt8CRMc?=
 =?us-ascii?Q?4A9NMEFJDCgA9adPepb9+aBDxry/nyUMfOGCo57uzEM0gmgI08Rx5yl8r+c+?=
 =?us-ascii?Q?sBTDWSO8hNzmN2dIPLZDrJUAGtzGwONSoHRQ0te/rnyFn2LfyPtYK5WQ3BNY?=
 =?us-ascii?Q?kgM37TKIZmyZurgungtBN7f1KS4g8tg0xmb9kLx2AH1SuhELNj2vtyLVT0aD?=
 =?us-ascii?Q?mTEz25/nN6XsrPtqtvhS+U9QJMQFmrs4LPAR9/hdR6PQtflko2BnjpVPWyo7?=
 =?us-ascii?Q?XH4A/E84enpkFQdP380TEgRtXoaoK4WRfyvW9MqiLAogdQ6vWqPpEa1Pq3mG?=
 =?us-ascii?Q?BqOPSsIxg7GVfY/IE3Z23h00zaDb3RkyH5khs27V4xUmgfxbKJzcWZm6c8ip?=
 =?us-ascii?Q?1913aGPgSV+p1YmFOilvHHnc+R9MwGVAN6x72QBX8bifVn6ojApAzcmqVGOq?=
 =?us-ascii?Q?+WglYW1kW3MvtjSF1HRclyYWt7I+kCjCRpess/C766OLwt7pwJN2LlYcEP1V?=
 =?us-ascii?Q?5Yu62oMhkZxpJjORRuNDCV2HcBsX9nvQ5Dytt4CPYGyYECsLusy+D3tWOY2F?=
 =?us-ascii?Q?F3JrXn8/zHuYc4s4ACibEiyZuzBjXkc8bgTr9Qiilu+/TH/qN+NjovOcrytE?=
 =?us-ascii?Q?DC7+svwpy95icFuI/3t65n61JPO7ycDP1xBx/R61n+mRTiUXNP+tSuMdyNFr?=
 =?us-ascii?Q?7AHZklZzevgA9EugpJEJ+VQ2UKjiLm8Q6upU1q409M4YcHAR26ffZhHzbPgp?=
 =?us-ascii?Q?FoQgy83E4Tn0TGImJVBsyL6yjfqZIsSZmTC0A2EjNBbtvyo5+hUrdPWbrrXd?=
 =?us-ascii?Q?HJqJm1QvRXwwcZKPW0mH0fcFZ1Q51gaLSeeyFPXOZsF+iahQfqlf8Nuw8N1J?=
 =?us-ascii?Q?/qccWNLu+UjLqNp6vxCjQSfWaYHBYa+ywkfb3zk1wL5N7BNwHjLAjkEtY6CD?=
 =?us-ascii?Q?C7YYCDe+AFm2GfG4sy7RetdhJ/hX9TVBDrlwElSlWKAiSq3+DSPNK1mDGW1B?=
 =?us-ascii?Q?8BF8wWYE+z9QXaSB/7BjGlfDqjY0alIsp/R1cThDkQjZHZlYWeXtGJpRawkk?=
 =?us-ascii?Q?CbiReq2IUFHqEX+mpz4MkFror7t/KYPn4wEJEjhAY050vZAd4qLh0eW2QTq3?=
 =?us-ascii?Q?MqadyhjhCPTAqv584GOJw4yer82mA/mO6piJX5vU0nl2/StpxFx9bmGSykVX?=
 =?us-ascii?Q?CSAJ4bC2vzWw/JQJtsECp/015GAiTUkYn2help+E/ochE34TuMB+yChnCS4O?=
 =?us-ascii?Q?KfbFHgvjcaZSJQCtQjVK9DXWYKRqOgRWiLe2mWXjTNy9YtjJVNCC1R8RVI+o?=
 =?us-ascii?Q?Mcxjw62BhVLL2/WIlkhVtsEdUBIiPUotjb4H5lRqn8R/N0HMWHpdMDnSCz/J?=
 =?us-ascii?Q?RXNCb0yzoYiMxhl3fcbW8+3FD4IiNL3Mye4iRN7OVuYlfj3Rjtn7shcZnUPG?=
 =?us-ascii?Q?DQcmsp2LBgD9lReEiTJy7pBigY1J2cG9YoeDzCtgoALB5LB23B4gNHm21GLB?=
 =?us-ascii?Q?wuNQUATObD2aZ2g//yE2QglRbB6J4atO15zxm8jzGBNItPkr2DtOoxDbqasT?=
 =?us-ascii?Q?Cg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DaBk3iFxCPpEpgZiBNh20Vl8rwRNvLYjw13QcCvUETcg6KiKkq9iq1EbwN1g?=
 =?us-ascii?Q?8P0wu6SfSnbpzQLpcXvjW26eSLt8sLbw9WL/AekT19pnOU/mBT8ig27Ekqcl?=
 =?us-ascii?Q?Gn2bgsXIH+CkbihA1z89N4TtDJkMWFE7heY8ngJM5uN1exn7HLZCOEjSJNMk?=
 =?us-ascii?Q?Ujrp1B7bBhMwDebZV2bnnCtnnud5/c4XpPfNt7OOlg5QlmVn0eekU+wV7x//?=
 =?us-ascii?Q?E5Z9s+byC2Elz8u/6rDsSdEaIRpRr2wcIwLm9WNyD81S2dqnWS2XwRT/w26X?=
 =?us-ascii?Q?ipVB4pTR+RgQ6qdoQorVH09nfbFd/VJHsRxDrrvLDMkIy+3J5/tXMr2Exz5o?=
 =?us-ascii?Q?jQpHw97LeMfqucaC7bzQUKCoICT0iVq/a+AhL4sp9UKJQeFOBFdKpW9WnrNV?=
 =?us-ascii?Q?pV/iV1FQBlnIInoo95uS0p9sybbVvXYzY11YkI5zei6EnztdcnPhwdwSn33P?=
 =?us-ascii?Q?HMQOLCuMk2gohKKIwV9vjzW7rR7eDyleCrE1FsWR3f/TZJBXhfGN0t+nk6q0?=
 =?us-ascii?Q?olr9DaiSscDwXQIZ5bP4AKFqvZ0WeyozBc6aTgxcjeDX2b1wvalZ3/ZXiXo2?=
 =?us-ascii?Q?gVcN6MPVDFraRqHsBv9/1e8t7O5r24eDy2FvLROfqLBZzeLBK2K4/4PESVqO?=
 =?us-ascii?Q?Lj+pqmd0qKQ1gou1FG4MU9aWTf/+cJdlqmX+4meJNsQ8zMA44PihmgsZX3pv?=
 =?us-ascii?Q?0rMGEugzueLBFEdbDURZRWcBD7pWyTWMsjFHxQSF0CTWUyv5y4y+xSq5p9HF?=
 =?us-ascii?Q?Zbn+W6BhmgRnYrtTFF3NaxbUsiNUMp67O+gnJxDdnXDsH6f15yGoTUwAdhU1?=
 =?us-ascii?Q?NzY2KB3gwojbsHsNStU3RElm7nA2wxn4faKzfC4Ul36oHINgFYyyPdPn1cpt?=
 =?us-ascii?Q?kBY08Exi8bjcGYz7Dhr7BrUo+IB5A0snDcbQarIOTeLkm4/4Rhr3W68HtGhR?=
 =?us-ascii?Q?1ClGydl64EAIZKTHlS6p492Wyx4H+r8rujgVgkwfvOHLzsbTcDY84Plx3qkh?=
 =?us-ascii?Q?FAOQEzRhwQdVpTdSXPM3Cr0pnf+/gL89uE3XSUwrYAXEFNOfUwewPuzRlm5u?=
 =?us-ascii?Q?n8aT6qC8W39tltFJSZ7IAbWJUPDIegGTxTOSjJkfrVEZRA2LXvyzUmbGVIxU?=
 =?us-ascii?Q?6r4/6AUFrAb08h8tZ66O8ZR+zeJN0uFTOh/XWTpMzk64AJJlkh1xTjhwlFGa?=
 =?us-ascii?Q?V8cabw8bSoImt3AcTteVfctRV5aPyGFxfwiaNkS8etCHCH2q8/BZq6ISArHp?=
 =?us-ascii?Q?vRdg+I/HzDDOFKeync8oAg5aJJH9/zWnS1QsEModBzmr7YA9fbm6aox7iF94?=
 =?us-ascii?Q?ebNzkJCJuDvVvvB5AD2TBfEuVh+hrWtZ/QUsV5PwN+/2mm5XspLEd+cFhXR2?=
 =?us-ascii?Q?Pdmj+sVfgIhZyWN3l1Ov4yShOM2Kn3ozbU1wlhJJGXQY2ZunpKMzSfD0aPJt?=
 =?us-ascii?Q?mTYbkAZeQs+1MR02sXDAOWGJtlZFWteiDip54Rs7yiTeMVFavsRBR4hfhuqz?=
 =?us-ascii?Q?Mcu1NB+pYlCZCzb713Q7GI1ZVc/oeVGhjbRzUtzcVYVAsIs2MD9oISJ0I22a?=
 =?us-ascii?Q?QRdn7F71jOC+/QGyqbwJXCFUSAdZNZX+nIkucFOu2EUixEsvS3YzLWDj3/0C?=
 =?us-ascii?Q?RWn+RHzE5ShB7HBLD2qvyWT8K1N8PT8q8t+e6Z374JjpXNGe2Uv9sPd43HrO?=
 =?us-ascii?Q?7VNd+MhwH0fHUdJSmwZOIfaKRdlswDaVS2vD/zsDwImCUeLYslvde3qqVtxe?=
 =?us-ascii?Q?ioM1fOvKBCw0/rn5keHvl5rTAmXcHNIGPMiulysyx5Kg9UV0hNX3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7ff893-7610-476e-4e6d-08de6cb0ba7a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 16:39:03.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdjctqbPYI30y95O9tMTK9g2gwdzwiDcCDe8y196P+f+J7QYrtgjTuZHFP3el68aAND/Jj//Gm7BCyw7flTJiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5196

On RK3588 PCIe3_4L in EP mode, the integrated DMA controller registers
are permanently mapped to BAR4 and must not be repurposed by EPF
drivers.

When the remote peer needs to access these registers, it must use the
fixed BAR4 window instead of creating another inbound mapping in a
different BAR. Mixing the fixed window with an additional mapping can
lead to incorrect behavior.

Advertise the DMA controller MMIO window as a reserved BAR subregion so
EPF drivers can reuse it safely.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 5b17da63151d..ecc28093c589 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -403,6 +403,15 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3568 = {
 	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
 };
 
+static const struct pci_epc_bar_rsvd_region rk3588_bar4_rsvd[] = {
+	{
+		/* DMA_CAP (BAR4: DMA Port Logic Structure) */
+		.type = PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
+		.offset = 0x0,
+		.size = 0x2000,
+	},
+};
+
 /*
  * BAR4 on rk3588 exposes the ATU Port Logic Structure to the host regardless of
  * iATU settings for BAR4. This means that BAR4 cannot be used by an EPF driver,
@@ -420,7 +429,11 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3588 = {
 	.bar[BAR_1] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_3] = { .type = BAR_RESIZABLE, },
-	.bar[BAR_4] = { .type = BAR_RESERVED, },
+	.bar[BAR_4] = {
+		.type = BAR_RESERVED,
+		.nr_rsvd_regions = ARRAY_SIZE(rk3588_bar4_rsvd),
+		.rsvd_regions = rk3588_bar4_rsvd,
+	},
 	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
 };
 
-- 
2.51.0

