Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749143;
	b=0ggyXL0y61++2vEhfFzwzf+BgRC/3GIS8YYJmzzXpvJntV13le+zP65QdNcuB2ZFhycu
	 7lQdXb4/xw2bBT7Ww6ByabcHGLvHcIEN4xBqxRzNaOYMf58jmM8UpqhPrSrakpX/jqJFe
	 CyAnegSokPmS7KhAXuTKEoizF5rNCC8QPNY7FBgShyB//CvEs+pURtGteMcbbMCg3hiiH
	 Cun8k4xxzPYnz4nSh4JafqJXqwbX+Rjr44fiFhI+8KwCnYzZI/IORAW95YT2tY1oD2GUe
	 rap8aiE1G90d3uh7nA/RBZPDQacw4H75oh1SN3LKNABKSVVBkpcx2OhgXlv0yvzwoAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749143;
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
	bh=IkpLRDsHYtvvpvdlAThZN8CNvYlXQtjIX7k+Dt3hY44=;
	b=c4HGx8kK6xlgJLRAi5HZDSXF7hKo30ldZcSQ9WWflpht7/LuCJM8YW8fRiGR1WCnHL//
	 mI9pm+1Hi5IuYtkaWNX6BbNI5pcKl4hmYI1tl/sdJvoHBxWyRB7tBSNGjilKkLfkJnon+
	 CYmc7HiB9coWV/gl158o6Hp87AfOTbC4c38x3UyR02Yoa7elzc34Hsz5MHlt/FYuBwKOJ
	 ExiOIAy4QmKavc70+l9gHwL1o/sLUODdXApafXfFKnUxwDdoKme33XMUWZ/EIxqDmjqHf
	 TZn8yp6NsATYJ7fs0YOHnXI3dW4JgPlPqEqJOAZkwtjHLV5HqGo1IC24IKW081Fe5Tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=cSbulRpG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46E60A2604;
	Fri, 27 Nov 2026 03:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D46E60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=cSbulRpG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFas6CWrBJv+j4X60qlWQ1zUdiQwp1C+ywlpDNJPe6pBMR+zqUS6p268u5DVDQwE05RWfuk7DlGWlN9TBAHIME3C2NZPqtAV/LYBcQXmqZb+XSCYSAEaS2TjR+ZGct00jSLTbcDgy4SPdHj/5Uk1vCKyPAeb4U4U2xtMubCM0mNnuK56zK66GWIznWC/ClDQkT0pKqUwsDCcEgSQXsQkiXLVyHbfEf8TnmvTaNnc9FhzXJR1uVZsQRTHezlDC4Er8JfH/Vt4deL+DC2gfZEcv3oDgY3+IiR0zQDDu4EeoCksBps16YdSAtVAgeq1O0ImdiLPGTM5UqNAQoL8ZovzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkpLRDsHYtvvpvdlAThZN8CNvYlXQtjIX7k+Dt3hY44=;
 b=PCcdx8N9ayFOmikOeRVgk3EvHCxN8pqzFfe0qdr/6h0s0/6Br/zJPpFjYdeI/c3YIlOQGTvQWhDDUZGmYeFeHlHBzMHj8tnh76TrtoClKn+1Dqj+SFnlHYciLgGGEWtN4DS8zL9R0C64E7dAw99HrwZefMDp7lFQ41HfHWU41jqkRsMNoxg5Fs9JCZOjy+0zMTy6wR5mW+8tC0hoMP5ddvtUoqK8yr1R5yW0GzMVIglYK3JWOWWClG7CiKxuFdYk1f9RoJoP1KPExmJ9HRbegaO23QIV0pAT294oEByiOOOweF3Vtw4J/y6FZQ8NQgTgAsnTdoSbmYmr7mEu7VCKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkpLRDsHYtvvpvdlAThZN8CNvYlXQtjIX7k+Dt3hY44=;
 b=cSbulRpGgVO8b6SxBDwnxu7kUM+cy0tJcd0ckRpninKQvA5kdeDpuu4Q2GgizhSz1mW4VXAG7o6xz5khxWseGeTL7XBXmkDZ85Yanu4dZcJ1XXagcw4crMLMDew1ZDqPUGJ8nzuOU2Fm3ky/Ja3FfnE8yvNKHNkpyUUsFYhZmds=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4873.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:15 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:15 +0000
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
Subject: [PATCH v6 08/17] PCI: rcar-gen4: Separate hardware setup from resource acquisition
Date: Fri, 27 Nov 2026 12:11:36 +0900
Message-ID: <20261127031145.2521228-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0068.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 5aa7f6f5-fa72-487e-2115-08df4c343bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|6133799003|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	0AFj2gYCDpe082LUmVA3LK5/PP+paRus86pJXpThrF8GrEOhMaXsVE3h37yTt2+/+IOyPmM5GJd7+rJSpZke/g46mwMWlcYYsmiR7XexC3lo3dAm+jgD877DNuKkCm0CjXJeP8f3CMGplzmoeThYlmfnGBIZcRe+WROpw+vHp+t6+zVaF2RIMx3+uiuyz3u4B+DkNycU5RrgAhRNtCysXFm62XinhylaE4yIq3v8aQlYMci9WjXdoW7UVFumDfTFM8Ilp9K2PEqCFTpA1PeHJV+KxJXcwbJfj6XxBYFTJ00mm42qkg2t+Hr9nUCJ4IksNUcObaV0O2I3gVZfc6S4OXuQQELBj8ZVk6MgMGhZf9oIk/notIBJdn5sn+HXYTVJR6GtzrC/mlEiPCLZZrJJMtV/5Y0//1X/9IkyyVefmGUNNdRMXraN9WIqCQK4xqzxgJnXHIHzBYw1c4LLPcgep/PBzlaGaUX+TYL1DNSlsakkUiLze1Tb+lAMXmAj1xGG9J19nw2Qxs9n8mD/dErMap50BDxa5Dnj2RWmV9prvbGaGYJ3nsGDmA9WQ2tYuybrbruR7zCKwnR/I72rUXxKtzVzFMHSpvftgDl1C1E2EEiTIP+rRVDFTsewk4EdD2qdigE5QRaSbmrx49dbkgF6D6B95FS5+Af/9uD6TZBe/FUct/5WW1IZvMe0itggON4wARn75mI1Wrr0LrxLmazC7w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KPy0aWIRpR6uKYk1FhkIza/cnpoeiFOLQxDik3YwioTHK++nP2GVVIEVGQ/S?=
 =?us-ascii?Q?mpP7yvbHBeRmr5AggkmOG59Jx0mdQ8z/1JDsDBUpw5EhYCbGvFkAiVe/oC6D?=
 =?us-ascii?Q?LJM0LKsuV2RgBcfe8XIhamq3GJewVT+PfeyJ/0UQfTb/FUE+CNRqc113hBLt?=
 =?us-ascii?Q?glP1RiYus2aLWf/Zxvfarbae34AzoTNy1nLU8SwoNPuxqQg95FbLLSHkh0ec?=
 =?us-ascii?Q?/GEaNtzo+N4DasWYHBbtefj+OxN4mA1oPEMsUPsfczOvCd+rRfXwlyJJGw9y?=
 =?us-ascii?Q?j2N/9pehih4CA7q0JKt6gS/VPbW3fnIAEcQ2AHJQRfqSwFtWtbmC6JlsUJoG?=
 =?us-ascii?Q?c82uZy13174W8QxQ/Gla2Cu31IS2Ak+ZZmK3agKyMpNXda5U26qmHJj0yumv?=
 =?us-ascii?Q?DNFt8DSLCek1ME1e8QwsPP5Ard8gPfx1l3fdyT/Y1Y4sqLUVljmUbcSR7f8B?=
 =?us-ascii?Q?eCqd2ac87Yir9pgCnDCuB9eqkl24UOxTjsi/992Sb3HOsWmLrDHYvVMKcNdZ?=
 =?us-ascii?Q?Fy188dqUEZSMcZwJBNPOcjJOsgjdOE5euW9H4Q+laMlTb1RUR66uWx5ODGFk?=
 =?us-ascii?Q?nmAle3RPlwk6WvVRbmc0jEKuMZrv/UnfcTx4AMpkMcVo/RlXugJBT5Hockp3?=
 =?us-ascii?Q?f4UFSC1h7mpmHh/gD8GM31b+zyOiXIjAJUrm+hOE9Gpuy7FyvAXJimBqTCVr?=
 =?us-ascii?Q?sUxE+7l0W95mKFICtCYbkvX160eQ2lE5WBPUQDmW9JOpFE+jGrP526go2ocp?=
 =?us-ascii?Q?yyaaNYmxftNfGtlBZ90Bntr4DOBiAxz/KP71QsHsqylCm9ukGp0OSz+/6EmT?=
 =?us-ascii?Q?+2L3vWkBRIdgWnZAqyRI+3C3EOIfqVavk1usKP5HFxotQ171iPYGFJocXHpm?=
 =?us-ascii?Q?lYF5Esla6rKsSz/FVoMa7qe+B5R332S14TIQhJNTh4XCfBpoim48Kem71dzY?=
 =?us-ascii?Q?FC0f0GqjWIgu1OuOXwvdwbNQmTzYhvQEEIRxThHyxrFKveD0VHlY7hKzZpGc?=
 =?us-ascii?Q?E+DX5xMXP7IDR8+mwuUO8dj/kgL93pwW8TWHQwG6VtGwXUXjDXQTi1fYsvm8?=
 =?us-ascii?Q?3tDmD5AR81FlkOtfnwG3/nkbGAcCDqjXwyLMtt/KxihSwmVLKAHC46rYDhjK?=
 =?us-ascii?Q?fz6a47TUr+aRiT4MwNVnd49bV5a0avRs8nij20iit1u1ggotrBP6ogEu7wQC?=
 =?us-ascii?Q?Z641Zz5L3hqrP2OgED35qVeonviF8LNhkxEzmlySIfnsnCrv3lTeZ9D+pIAc?=
 =?us-ascii?Q?SME8y4Q2Lui7DJO/homSCG2vFFjf2CvzNrfvrtN3MOYNWoqFPd5RiGh12/3m?=
 =?us-ascii?Q?AWEQSe2V3NZSzOIZBT6fraBc6P2/DaqwNq/P/3/gmslQE+qyHeVUesPFDW7K?=
 =?us-ascii?Q?m/2G9wC1w1E1ehC4ICDlEr5xyIrZh0PNsqan2PsOPJ1L/BKr3Icsaw3aXNzc?=
 =?us-ascii?Q?8pAPSgdkpmp3Xej6Tya4ZHxorjWt2Ff0VF7DlzdLngFZHjbx1hBeyiokCkzA?=
 =?us-ascii?Q?9jNHfTi/olwOrFKDkIUHUgMxhLaRBvzQLmaJ1KeRlvGT0RYVzTo3+6L5omxh?=
 =?us-ascii?Q?AGBGqc6co+QoZAWJquUdrJ6LVLTZP5Rg9vqatWZCXH4DsVDzVllOFKUj9gyY?=
 =?us-ascii?Q?ccUhGWoRWgz3v8Ps7/TRMyzHgDRjKL3yCvYw28DKBgJzOoAX5BTnOfY4yEI1?=
 =?us-ascii?Q?src0otga2eK8NOavbl/Z7TA0ATEnGD/Ej6DIyKYVvEyrCki5c5+nVcxKLvl4?=
 =?us-ascii?Q?F/v50VTpq++D+wpcZ57nPMz9ZuvwWsovggJhmDKFUhZemZz8fjXL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa7f6f5-fa72-487e-2115-08df4c343bfb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:14.2142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ff+Bi/v7J+WvAW7hijZgdCM5aKUt9g1jptWeqWdtcXdZHvAA9kohsMxkaeoNJDgr3/opNNODm5BP6ruSLx+uwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

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
  - None.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 125 ++++++++++++--------
 1 file changed, 77 insertions(+), 48 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 051186ac2d71..c513294df5a0 100644
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

