Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749143;
	b=de0ux2GUxaYWK010APP2eIPJTuRbR6Ic2iHkJ3WFs6Awr1g1f0O2+3X8HcapIydoKRCd
	 S/Ggbqtt2jUnpRsXRLyt1ap0qLeBMdPDYw2xo7sZFuS+mZ+k2ZPQXIzNNcEDIqHADG/OS
	 kQXSw1jHibxMSqJOrizRdV3RWao46/AEPolXBFSbnmmsdt1LL8n27occS8R0O6ZZhSqva
	 m95bPxe4FYxuJ7ed3zzB2VwFlgh3LvQbRa8JLvQeLfu45FM1WtEU/rz+Vq0U3x9DdC8+1
	 UN/c6r6NCo1X30kJfN9FzqOI7WRvYKM8F1ZOixto/io4rvSJ0S6r8+VN5PU5V9v6+ug==
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
	bh=RNXmZMnhVV4/sCAbkyWArtZ2oDjQH795AA1A6FpdZn8=;
	b=YFh1/dKGIg7L9k/dS0nwTG9Xg8UCteOjsIRQfJzp2OXB+qZEol84VL/e6GCD96PRoOk5
	 TL540GcPHMQipgTkV4fut71PR2Lfq/bTzI6PI97Zd8j9paS39YF42NUH7j1jVtFGfhUfE
	 u+2io/OvBsFIBqJ6mEHptYCV3otZjFX0oxtQj/tC4kbvcNKADLTtgoJxCIZPJro8Un6jF
	 g45HrZOiHq+UPzATLG6EbXIkE9lFFootH4YfP5C91GpPudA6C5deLPkbIWjXjOjp/Y9HW
	 hq3p7KzzjIILC2xaqP+2TXbocj9jmIDT1LTMi7AIqO7vYroK4pQ+DRu8/VTuBoXuIXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=WPR5y47F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CDA606A6A0;
	Fri, 27 Nov 2026 03:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86CDA606A6A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=WPR5y47F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpPiL3Gb3nRpOJAo4Th+bgsU1bL61zfmVQoHb7uptg3PLsXX6DO4/UTpxoxa+5qL+gNR4SbKDwQtVJ3poIREEdq/JPztzVqbyPMQH4G+cN6GncC94tX+faJ4MdFogNRuMx7bqN/nUKMkIQq6MPqqnsh4AIk2hmPGVFl8+FM1aBJuCvoTJM0Q64jlPDp22Qo/tWqCTwL0ho8wWApgqh/s1wb8DS/xxNJfD7+y/I8QLEOtNFFFjFXET5ZkuDP/tzwew2/a5pxoa+rqRpmW2Ev6isX/686eMf9HvSZaaufNSoTh1XeBcWRIHfdSUeS8X4mIatGP+Mc8F2PpGSFnd3ZoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNXmZMnhVV4/sCAbkyWArtZ2oDjQH795AA1A6FpdZn8=;
 b=sh/aYqJ+EHsYzIebU1o4OJbxUfr59teu5v5phok2Eezh2QpE96wE6TrxIpEr0dmAV88d73ppXHR7ivYYZUXeHLlV42vgrqXXu6Yao0EPTYSpa0vOEijflIOmo88VnKsLfE1ppuImvDjq7BWhe+qofrdotAERJfqxybkB5U94byHPCunLk7uXwNCcd00MM2UTsptRB1hCzzc6LwyNS37rjtq6ylFcdKTvyJaXkaB9E1+txKebioGnLlZmt6S8mmCDjK5LAaeNdoC9sJY9ZCEf984MCjO0YGHVVIq96OkRsb9AwAcRKlNwyCEOHfUxbYzG1TPwUr0FIkT86tuuuRj8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNXmZMnhVV4/sCAbkyWArtZ2oDjQH795AA1A6FpdZn8=;
 b=WPR5y47FQffTTky4tW1Z+e6qweZewLSO0elBAl9GK0fnEs1VLJMFzb59LXVhu37UzaJlf35TDAtFjMjCShtADhrNCQd2+Y6V1L2DT8+6VT+xR+YCTHZobdymps88/N+26vbUu4VwDSbIOHxRuB5tvdjF/3Io7qcLytHyaYV2dho=
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
 03:12:14 +0000
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
Subject: [PATCH v6 07/17] PCI: rcar-gen4: Assert resets when Gen5 SoC PHY initialization fails
Date: Fri, 27 Nov 2026 12:11:35 +0900
Message-ID: <20261127031145.2521228-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0033.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: b6b4b307-f67b-4b6f-f125-08df4c343b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|5023799004|6133799003|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	04Vpa3NfRYsUTW+ta8SscXBNeMCkvM7vGd1rRY0rlGOYF/japnFQB/S5FQdFqcxKxGhCo7GBv3jv9MlGrhHCOq1bmmJQ6YrbzOXca6Y3enW1EKYZCWwutjKWiL1htNE8HRSbNjnfHThxXLdTLSRn8DLW7vFfeiQgP2ZV1fomvPgs351UClL4eYlW1dGrH1pRqsjKwhwUKrtXW6IlU7r+eSe9MKyfFDpVrGEfUdr9I7zDcvHljqAI5btNMfCk/mxfzaqLBfLB3QRoQtqyS50Q5zokQeR9ql1iVNcOpvNuWBpEpBq6sRpElWcPbmZ24nF+88Le7/rGygy4OOT4xDFo3qah1o/ccnru+c1bQIEMWRhvA/71sSSL49yK8XVE8L/955mFApMzrIpe5k+IL+3OUSUfRRAvg0kla3xOoDF3yme8UOa2mKpk8hMmxwdLirZDhClaFv7Z9qYLHjALys0VprE3Wu9gEbrKxtEatX4xGuD5nNfUO3SXy3mz/4lbRepX1zaDzRVYRm0ZgPnIg6lnA1SqGkuPmzjvusosotXJNW6iQtn6JGWNkOr34tJPEzKnJU48v6UzI+ggJCktyRb0wcnEx/PNcx/m280zyY+3HB1f0p/KqyrTJoaEo3Sy/vYPbF+9bXdvcVZhAyAyzoTWCHuR5FpxDVUoh8q//IGokLB6Drkar4NKSoP+pbLbiMJhfdx/VdxtGQ7SmRC/xDs3oQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(5023799004)(6133799003)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4GPaJVHAM7AJIHWTNFrXuIMUZUeTR8fh9ryQFsEq+TdO0jX+5OGdVjCblilg?=
 =?us-ascii?Q?Fo1J+UM+3E48k3ZGSodzHj4KwVRqD9omBxToaWKrUxGElEMbECB0Mr7YLd3+?=
 =?us-ascii?Q?XZYdR18GAVSGNn2NTczsrsQS7Nm6YdZbJU9n+f58kCOOO355TLwCIElWarDf?=
 =?us-ascii?Q?Z4PTmFeurEYUWdVcSVf5xNc4RHnk6eocD0IyFmLWSiFp7sU53hiW2zqEFXG2?=
 =?us-ascii?Q?tJVtxrnoXMkfOhUBeB97uGvQwR5L394e7xP0KxSN5qMSziZhjKFiFVaGT901?=
 =?us-ascii?Q?tXllbpDKX5BfDKHy2fYZRK8pSc2fw2DyXYvCyLWpzcPZLhpMitbzhoveZB9U?=
 =?us-ascii?Q?E6O6KGKk+gsyVzkhOktRS4lZdBUo9M/VTXUj8Ew5MVPbTdA9YUdRwnEnBD0J?=
 =?us-ascii?Q?4AjL29aPKKgwnrM0B0OOCjWhY/2VbIN0AwLX3O3uK3Pbk+ON4s7SS4jk4iMJ?=
 =?us-ascii?Q?r+0+S+4HX+e07q4lakwSK9ExP1EHvIT20w7C7Yb2m7+LHFwbmmKVwRy/O5Wl?=
 =?us-ascii?Q?hEXv/tkPZzXaRlUZLt3Avg1Go5fUePxEo8LDEjmXDgjWJKTcuDA6SLVJNaRt?=
 =?us-ascii?Q?P57AmrzS+/KhjIMMgnuDxjckjukN4HSGad4QE66/jES1uvkW1z8zTysAiBNj?=
 =?us-ascii?Q?BoXHkF3w+1qhPXvhvIfTa6MtsVvfcjCoT3vmE7Oh9hmL0YwykEzwtxs5n60S?=
 =?us-ascii?Q?lnD3kYO3iYSo8mxhpBtaFVbl3g8veze6CbXH+OQhzeVUNGQ9rn06BUOx+hYc?=
 =?us-ascii?Q?Z7sK5WxSAgPEprBoyl6JPvLgjkIgdpzKZJQ5i8XHqhW5UoX/lXIGmohrACxB?=
 =?us-ascii?Q?50U4Z9NyXpGi8F1iAsXgotwtBmi2+S+KLg7Oh/JeuEBx/wEcB0/CO6BDz3Lx?=
 =?us-ascii?Q?KOjiDrDyOPQDyj5SnNZ7/3uceNITPGIzLFpFK3JhU4FQUoes/tS7uJWQHfQO?=
 =?us-ascii?Q?xTMfnU0uCaExbVReMA9sSx22brA2YeXvYsIgrf3aLLR107eggwQzoXhTJ60m?=
 =?us-ascii?Q?xmbO+NqM+honcRP+5EcE9VFewHPHMkadzWN+lCULrj/RPF/v8KzFpYWI58jL?=
 =?us-ascii?Q?AcRRo1n7nXBwEj4lCviKhkqNTb/Crjmv8f3zj+R7gEKvydJ5MeADhA4zABDe?=
 =?us-ascii?Q?O6+V/2fY4S0g8UTrOk9ZQO3DIDcCGGr4x0YmqkZhqZzCEfFheRqAiEyGefO3?=
 =?us-ascii?Q?t9phqCX3IU6xP4wVbmo67ciR4ZIxY0EbexFy7C/A7bKf7Z0ThJL+iDSf/+ps?=
 =?us-ascii?Q?FsjIKZxqKYplh+S+HaX19Mmtaucol/qfQBms6mmh/s3JoHbGA37kIPkUOzlV?=
 =?us-ascii?Q?/UWsGj6mo//6Jwt+jLGM5ncorFuXlXM6eH8x+QMJ7ARfoTCpUTTG1/JymzkH?=
 =?us-ascii?Q?P5AMR10DxXOoFNKddh1lBhXPwOLTaZsi1E75YkENf4yKfLbAw1TC+aIEZb4+?=
 =?us-ascii?Q?qIkDjUSK5WHHabjuQLNAUWgW42SrRPk9Ch4x+Pc4KsmIuHLx2AqKNJ5Nhf2P?=
 =?us-ascii?Q?jVs/Bs/e4yUwI7DNkM4ihCFuiwGXLLvK6Db3xBQSXC58aP0eIwmk/k2aj7OU?=
 =?us-ascii?Q?Gtk+lz+3X8CGV39Be7VYgySj18gAtXlGn9NiINwAlSdUsrSGM3akAGfUL6uy?=
 =?us-ascii?Q?DC4IIdzpTTA/0TzE/C+L6WvGTDUgbk6idos6iXPIS7548etATEuO1qWU4ZRs?=
 =?us-ascii?Q?ySRfxJXQNm3FbWROXz9ss2oz9SfunIb5j4+m4juvUyTEyKFHIRvhvaa6kFRM?=
 =?us-ascii?Q?p7znwKJrNfkxpyflaJUvZDHw0OKQLWuVjTzcO49jDGlZR06naV/t?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b4b307-f67b-4b6f-f125-08df4c343b1d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:12.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Is/ehI1Ji0d4GYLVMmd5bTmG5VNrkaU1/rU5ishE3w8NdpwzKgG0uDLy8wiGkMJTKswMLhmrf1tNZzNBrmGaXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

common_init() enables the clocks and deasserts the power and
Application/Local resets before phy_init(). If phy_init() fails, the
error path only disables the clocks, leaving those resets deasserted.

Assert both resets before disabling the clocks to unwind the completed
common initialization.

Fixes: 3283c4db6009 ("PCI: rcar-gen4: Add support for R-Car X5H PCIe4")
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - None.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index f0ff94898951..051186ac2d71 100644
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
2.54.0

