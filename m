Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465868;
	b=qG5rupYMSPhajsWII2YhBRD3//taxc/3joMw/Uo2cqN0nJN4Ojn9EqTNhcbpmAKC/Ogy
	 KR7Mz++nO4tPfyKjtVpwCht6QpAJClRZTdG01/bh4EE34TCW+GcMKLBY5s9qdIDZjcOvP
	 NSwBk3t76i1lztHM5FmnlnK+btqyI16lsg3q0QYTrzsyd94ulLvgUALxbVHIImb4HWp+/
	 6FHIBJ01tA+q3naU4ApN+pn2XrgReLYAupOZUnRpL+PhH9vnRy4b9g/534POwOqhYs6dD
	 XvkJkQyJAi70S2AsvXEKkOtsao1pVrb621YaOJDWaOnBNDVglFGiE87Imi+zzoiaj0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465868;
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
	bh=QBQ2+cd/Sc0JBvFn62FPMVIY4EunTzvNHmDShzl+Z0A=;
	b=tcvPYp2qdpOEsHJtv4/803xF5H9oEt4fdBE9u8eEaaYmIDIZl3xj+1xjRBKd5gsRtiEB
	 g9GawH1wqvjc6GZYhuV73lXMZNb4IPSbkUgAXJ0tpsia1ORIQ/hk0gdRwLRDAFvjvhlqG
	 V/l35ZEDaJ4Xg7HhV01aaprZlJrr0jWXm+tt6YCVqDvGvSkMtiAgtIxuurlkHPO5Zaifx
	 xV5zC2NkO2IvIoNWCxf5NTF+VnNdgxkTnGxCfM+S+x3Ek+QZQqxwgMVvnKC3UCEQNWOhr
	 LqPGNKeinXoRWTEV3mbf1XndP/Ju573iP1WdaPNzZm3WYxGYldGz6tE5sPGQhM8dzXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=vgboJCrL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC6060A260F;
	Tue, 20 Oct 2026 03:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EC6060A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=vgboJCrL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lob+J8TFVAgKXOfs9zKmr4A1rHZNo4rYwq6CBxJ8g5TCzr2iRfQ1S1lPInnFSDzJqf1fExK0/u1GJKFmG7Tohv3Snrj24t4j9EynzCQQCiixNcrJ+X+JWM2flL6yoG6PUb8kkMO3hhwt7GpoTv0TuvohyqMeBvhYsLv7/qChDatyMMrLf38ZPSmnoTK0mYvD8cgWzxng1kZuW/WwD0S3VNCSZt6DSxy3enl4YDYqSp7lYnqk4hbSAARj1PMdAqIBBIvPWxU0DPwBMQvuIrGfmqfwRV0kY0HNlhobxZtTWVAb5FjfkytSoCkl9I8JtiQBpUk090qLACfekGok19/mGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBQ2+cd/Sc0JBvFn62FPMVIY4EunTzvNHmDShzl+Z0A=;
 b=PvAGbv6WFu0vGgcHcz5d/nQBqHiupqkSmJbrtkNqe6BGGuvQHP/d30zTVarSzmIr8N18BtzmCpYZTStPxq0H410MQDKriPhFHuvKFTBnlteZeAUeznYN+TwOIZLu7Iv1UpMWbDzJUh25oztD36vTKBEj98N6HcnMpKsKHPg60aSjOcwyDJfaB3+FBvHzy/5ijk2Zk7QAAiBg9HST/NPxNYQ4LCJBzgNu0N8jqceYzvNgQqBeeZEJm44kk2v4/tMoBjdq00KcprxYTFjcMIliuEg3Q9meMcGMIa2GcEJXHBNcJjurfjPcP8FnbucYGkiDpY11kAytdFe8KEwZ2nKM+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBQ2+cd/Sc0JBvFn62FPMVIY4EunTzvNHmDShzl+Z0A=;
 b=vgboJCrLXLbBgnfXkHKtgxVrg1KSHVHKuSJ8RAXO5k/EhEMjGzn7Q4l00snrTPgr/W1NjvbMAcs/bp5zGaCdaNuchv4IIEFF7KRHrocvu2dxQLMwJWCE1GsDkbL+MsvkPN+GDI/1pN0IPX3gIjz3rEy45eSa566jWIzdqbtmOr4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:05 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
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
Subject: [PATCH v5 08/17] PCI: rcar-gen4: Separate hardware setup from resource acquisition
Date: Tue, 20 Oct 2026 12:10:40 +0900
Message-ID: <20261020031049.969895-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0059.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 53caddc8-62ca-4157-26b1-08df2e57c790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|6133799003|22082099003|18002099003|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/ESTgEziIk5Sfo2os+HSx5rzht3TjS/5ZY1FG9n/Z+nMQfUhyRZgDkqIlXBlG/E266DgtaOm2kHxHE8Tbst/vGg9l+vPhIHAWrvPGWw3TA09hmZ+iMgV6ydadm19vZi8m3CInQFQD+W0HGF+t9BDhUhAoNzV/sMvp739Iv+1k3QhhYGxTJqkxRhga0xqoTXkOWMZXE+omUr5u+LXwbMxxjkmT04K5LIuMHIDiEvCRGvRQ0wKddUQJdl8W3uG3JJ3otTaMJXowVMKV/hG8tt3tZK2xsuVvPB76e+WGBwAUJTRzBkHjibrPejQK0w5ttB64DXQxHRuakL1KN1kjBIPMi/kfE2hyVyIwLpBvX8yzS+ZZCXKT3PwakCuwmpGrHvNcS0GoN1dyuwb1CBAjoDiDCHacitz7z+pJjxD/cIom2+ETYj69YuFM1TNWlZ8sfA2m9DRy1q6Fn0mlgUB5YwN4jvs6niunwykLtgGgeXGbdCVHlckrjg9vNbyxqgSfnZoqqXo4vFBHHsKKDtz7ZrpEDJrhXk5LmycsOW6A5WQJYk/YHANodQXNi1UBR6d8bZT+tu+0Jq5sapv/uYwsDNoMK+vN+OKrQepY7CeTAkHEwQgBlv2da9bFb/llZ4NqzKUBX07qAOag+ZzUZUzaWAqAbt7sN3Xaj/LDNDe67/xbSFa3cTgd2tfbkOY92KfEf9EoMva+XlVxMrJVCoWmJJrKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uHxgPFnOcnQTSuL6J1ohPPYyV3VaP6DfcVlM6gywM7ItSgV0UQzhTQthcf1b?=
 =?us-ascii?Q?IctzWR5gmIG5H55KcuKjhtAXUbvW79Kn+IrEULXYheI1D3aCqkUQJVf06e47?=
 =?us-ascii?Q?cs4EvIe/w0xGqFbC90YthkCLL8QmvcsDGz/y69JYI5ia0y57sYrFy+dgUXSb?=
 =?us-ascii?Q?vzJWjy3NnJ3fpI7QRgonST/eNwiKdVW7+TGW56a0CEQ6+0pqdQefB2+5i7Ua?=
 =?us-ascii?Q?uHixZDwgifA7ajaUfwF5cgFAhLSRw1Ov4zmeaGJQvQBtscvPslSMNXxSAK55?=
 =?us-ascii?Q?uf5evFRfjTa9wPLkng3f35cNDpq4Uws90pc2wIB7aLrJO1gSen37Jg13IxIs?=
 =?us-ascii?Q?vK1fJofDCQfovliQtY2umLMykE5shIJfRiitevcaE3ckYPgoaANKgsizaqTd?=
 =?us-ascii?Q?t3p0Ua8LWd3mOA3M9l1F3zZjF301vcsDI95Kv2P+Fn6nWjD5z2LR7VMQ5Bgw?=
 =?us-ascii?Q?CxD8plbn++l3iYgjALFUalrKTI6zld2lYzQtbSSTEUFLs9J1dV03rpZ+Ngxg?=
 =?us-ascii?Q?vcRhSBjfhQxRJV0Y9fN2u4oW783D9oymIyp96YaQLZzIKPSbrNcyjpf0CnHT?=
 =?us-ascii?Q?gE3jk1TmnXYGVJqUIRdktz6XlqnSYX75jbzOdPrp9OGRQ1LtbjQsMfEyuoBU?=
 =?us-ascii?Q?g2y6blbxQS39hFxM+yMckSO82WBhv4WzzjGCpkGfvQu3239YeCrLG3RmJ1jA?=
 =?us-ascii?Q?Dh67WJpV7p1Dc/iiF5fL6S2KPnfycNa9anOdrpo8H0iWkOUTxcdxtSiHepL2?=
 =?us-ascii?Q?11Z1oBXEC94At4V8u6QmmVOGL8WwEm4iZPSX+cG7OH/IvwHc74miH4Fsq3vT?=
 =?us-ascii?Q?15d6qTSj0P7w71Crqle6z/MQOttW74LSQJYLMHhcyPC7oLaGd1PhTLcuFbwg?=
 =?us-ascii?Q?8kWMyZ1BiIXRCh/XfVRS/jYgv14Z1PHc7B7hzVdcXSlktZhz61sWI4oARD6N?=
 =?us-ascii?Q?v7E+iZIzCphFn1hSpDIraNkXdVDWwFwD1w8zmX9O2HQCgEjWtKgyC24U7j3N?=
 =?us-ascii?Q?LMoJtDmx9RHYAdMKxRv1ntal+87jht4YYuxlxzDCSvWTRfAhZAdM57uSloMm?=
 =?us-ascii?Q?oBULTB3h/teAALDmjKM+Uw9AME3DLlxBqJP+qQVFEyqHMIWbZgqBsI8l19oc?=
 =?us-ascii?Q?nI673fSsSZOulCQ6iCQmMcbDBFIAb7OIxCGVWbdQds18qbHMtczZIlViKwUX?=
 =?us-ascii?Q?oSYZKviWOIQrqZgQemxQJcGegqVD2DR8NbojoFwb+WRZEYiNKg6AyrTbgQUZ?=
 =?us-ascii?Q?xajgu/mPgSgcMjYEdhAxy/MCcps9NpnoCKH+bxjTGYiCK6sFfcAPMVWcSKu9?=
 =?us-ascii?Q?KO0+Fq2pme6cTVvDRdQNeem5XC7EM7HvLdH5hCwSP1qNgV67Oj4jWYQ8Lubz?=
 =?us-ascii?Q?VB63eIsmj7JJH4fSDYLxVFo1vi0g3h+XJuyrWvsO8mbhqHP41+4oWqK4Yc/m?=
 =?us-ascii?Q?Lo2YRUQrS6Hzq6zsuBHcFH9J5ChTsaNt67Z3z8ls9jzuT6HIbv3Jdc8oksKW?=
 =?us-ascii?Q?+PmTuVDKv55/CIJd+vZOfOF1OP4CYGvo5sFcIwceFK/0hUcp2exVWrwH/M7n?=
 =?us-ascii?Q?XQ3dhmyw1qCt4w447QnUs9NkNYRZk1tDFeFdSv9GCcFusfUdgvbyopkO8g0E?=
 =?us-ascii?Q?qmTzvhIpkfMsrr4jIPVkQFl3BtyehwLYw+dBTFrBzEzzUEjeNJLwpweGJE/q?=
 =?us-ascii?Q?Cd9Y5cb9k9GkKl5NHED7odMYZvL5QiBkWYeslh0P/g9r71NDB+2jdfRLjMKC?=
 =?us-ascii?Q?9BUWg2QodO1Gow8Jv09YPhtc7OaxvttlG7eWfPUhgXJ5unI9Fi7U?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 53caddc8-62ca-4157-26b1-08df2e57c790
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:05.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vU7n4+vdO1+vrUveMZFDOtL3Elye+gT+iIpOhuYQf0FP7ctsFoME9zhUns6ZpPBWmfwcH21lA+urUzU8oYD7lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

Factor out the hardware setup needed by Root Port recovery into helpers.
Recovery needs to reset and restore the controller while keeping its
clocks enabled and the R-Car Gen5 SoC PHY initialized.

- From rcar_gen4_pcie_common_init(), extract the power reset and mode
  setup. Leave clock enabling and Application/Local reset control in
  common_init(), so recovery can keep the APP registers accessible.

- From rcar_gen4_v4h_v4m_pcie_init() and rcar_gen5_pcie_init(), extract
  the SoC-specific register setup. This allows recovery to restore those
  settings without taking another clock or PHY initialization reference.

- From rcar_gen4_pcie_host_init(), extract the Root Port register setup
  and PERST# release. Both paths need this host-specific sequence after
  the per-SoC initialization or reset.

No functional changes.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 125 ++++++++++++--------
 1 file changed, 77 insertions(+), 48 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index e1b748a9d58b..cbd22e6bb44b 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -234,20 +234,13 @@ static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
 		rcar->drvdata->ltssm_control(rcar, false);
 }
 
-static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
+/* Clocks must be enabled and the Application/Local reset deasserted. */
+static int rcar_gen4_pcie_reset(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
 	u32 val;
 	int ret;
 
-	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
-	if (ret) {
-		dev_err(dw->dev, "Enabling core clocks failed\n");
-		return ret;
-	}
-
-	reset_control_deassert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
-
 	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
 		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
 		/*
@@ -266,8 +259,7 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	} else if (rcar->drvdata->mode == DW_PCIE_EP_TYPE) {
 		val |= DEVICE_TYPE_EP;
 	} else {
-		ret = -EINVAL;
-		goto err_unprepare;
+		return -EINVAL;
 	}
 
 	if (dw->num_lanes < 4)
@@ -277,7 +269,7 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 
 	ret = reset_control_deassert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
 	if (ret)
-		goto err_unprepare;
+		return ret;
 
 	/*
 	 * Assure the reset is latched and the core is ready for DBI access.
@@ -293,6 +285,26 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	fsleep(1000);
 
 	return 0;
+}
+
+static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
+{
+	struct dw_pcie *dw = &rcar->dw;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
+	if (ret) {
+		dev_err(dw->dev, "Enabling core clocks failed\n");
+		return ret;
+	}
+
+	reset_control_deassert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
+
+	ret = rcar_gen4_pcie_reset(rcar);
+	if (ret)
+		goto err_unprepare;
+
+	return 0;
 
 err_unprepare:
 	reset_control_assert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
@@ -310,16 +322,10 @@ static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
 	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
 }
 
-static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
+static void rcar_gen4_v4h_v4m_pcie_configure(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
 	u32 val;
-	int ret;
-
-	/* R-Car Gen4 common initialization. */
-	ret = rcar_gen4_pcie_common_init(rcar);
-	if (ret)
-		return ret;
 
 	/* R-Car V4H and V4M specific additional initialization. */
 	val = dw_pcie_readl_dbi(dw, PORT_LANE_SKEW);
@@ -331,6 +337,17 @@ static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
 	val = readl(rcar->base + PCIEPWRMNGCTRL);
 	val |= APP_CLK_REQ_N | APP_CLK_PM_EN;
 	writel(val, rcar->base + PCIEPWRMNGCTRL);
+}
+
+static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
+{
+	int ret;
+
+	ret = rcar_gen4_pcie_common_init(rcar);
+	if (ret)
+		return ret;
+
+	rcar_gen4_v4h_v4m_pcie_configure(rcar);
 
 	return 0;
 }
@@ -341,22 +358,11 @@ static void rcar_gen5_pcie_deinit(struct rcar_gen4_pcie *rcar)
 	rcar_gen4_pcie_common_deinit(rcar);
 }
 
-static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
+static void rcar_gen5_pcie_configure(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
-	int ret;
 	u32 val;
 
-	/* R-Car Gen4 and Gen5 common initialization. */
-	ret = rcar_gen4_pcie_common_init(rcar);
-	if (ret)
-		return ret;
-
-	/* R-Car Gen5 specific additional initialization. */
-	ret = phy_init(rcar->phy);
-	if (ret)
-		goto err_unprepare;
-
 	dw_pcie_dbi_ro_wr_en(dw);
 
 	val = dw_pcie_readl_dbi(dw, PORT_LANE_SKEW);
@@ -375,13 +381,25 @@ static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
 	val |= APP_CLK_REQ_N | APP_CLK_PM_EN |
 	       APP_READY_ENTR_L23 | APP_REQ_ENTR_L1;
 	writel(val, rcar->base + PCIEPWRMNGCTRL);
+}
 
-	return 0;
+static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
+{
+	int ret;
 
-err_unprepare:
-	rcar_gen4_pcie_common_deinit(rcar);
+	ret = rcar_gen4_pcie_common_init(rcar);
+	if (ret)
+		return ret;
 
-	return ret;
+	ret = phy_init(rcar->phy);
+	if (ret) {
+		rcar_gen4_pcie_common_deinit(rcar);
+		return ret;
+	}
+
+	rcar_gen5_pcie_configure(rcar);
+
+	return 0;
 }
 
 static int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
@@ -619,21 +637,11 @@ static void rcar_gen4_pcie_host_perst_assert(struct dw_pcie_rp *pp, bool assert)
 }
 
 /* Host mode */
-static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
+static int rcar_gen4_pcie_host_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
-	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
-	if (pp->bridge)
-		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
-
-	rcar_gen4_pcie_host_perst_assert(pp, true);
-
-	ret = rcar->drvdata->init(rcar);
-	if (ret)
-		return ret;
-
 	/*
 	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
 	 * Rev.5.20a and 3.5.6.1 "RC mode" in DWC PCIe RC databook v5.20a, we
@@ -645,13 +653,34 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 
 	ret = rcar_gen4_pcie_host_msi_init(pp);
 	if (ret)
-		goto err;
+		return ret;
 
 	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
-
 	rcar_gen4_pcie_host_perst_assert(pp, false);
 
 	return 0;
+}
+
+static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	int ret;
+
+	if (pp->bridge)
+		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
+
+	rcar_gen4_pcie_host_perst_assert(pp, true);
+
+	ret = rcar->drvdata->init(rcar);
+	if (ret)
+		return ret;
+
+	ret = rcar_gen4_pcie_host_setup(pp);
+	if (ret)
+		goto err;
+
+	return 0;
 
 err:
 	rcar->drvdata->deinit(rcar);
-- 
2.54.0

