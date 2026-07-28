Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020115.outbound.protection.outlook.com [52.101.228.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642783A5443;
	Tue, 28 Jul 2026 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259397; cv=fail; b=b6/d4JOOsmZ8p9dK+O88JZmGwd6LNPDp7qYi+blo8AuZZ+cVy9OXuJMRTqUYExzQRGEee+URFNC6kdObUxFjFb74WS32GVlBoi+UnMCqSwoiH0FBYKaeiYCjGd2Fs7FTHeX/KPgxnbykwOoX0jMEUGHUtqeEwSfsDFzydMEn/VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259397; c=relaxed/simple;
	bh=teJ/6lFxncH1R3SERztEG22YkHMZTN1yKszppDLag3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fZb5xh4SrA+Q2Chh/YYbhggYIfydSR9WwOo1E62Y6kNlOtXVtV0/L/w8nz0qKT5aSIR9/Fd1Pt/ZwE56/4prVx333SP+QyVP+4NqDc2ovpctrd35ec6nXEfYMXS3OkRckwgxF6A57qbIOuW3YjV3lP75d5cIMihVHRRW6Q9/yog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=f5a736em; arc=fail smtp.client-ip=52.101.228.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="f5a736em"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMExs52mZf234Gssu9LVWpv129MxHohUJTrmlAwVW1o0ZB6zResfO52xwvK+tlKybmKR9puRVq8cTKrtW37k0/4/FX5epodcVsLUoAvTNRZT+eBOtXLgudKtdxFccw7uvMxHRmfqGysnqSYFcW8EGXLQU7jhF/kPP6gHwydT+8dR1jDwmf3RkksBEuCuewELzQzkOzZ4vNEwWcAC+UI9fi51G6gFGTt47Zt/3rX1Weh/t6a0hTFEvD4w5eHDErg2ZrIh+XUzmqghP97qeCvZoyJe3UyAZg+9WW1VkCuT6XjlTCLYta4b/dhhJ9tdQWQmzaRcdoi+JVEDqeaEy54PHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXVexwpjZ4bMZt/de4bGZPWytcnfsR6rlkz8hxlRfos=;
 b=kp88jEOnYGIf6R99djly5i3oOTuaPStlEfeSzg/b1dM/IxTpZr9cCXq7pmv9AOXL0sIysfUAd0Zq2lazH/dvM1M35kNcfWDrGTCaJUNktGghMpHwwKghRkPssrSGUPx1im4cjvRzey65VOO/rzo4ELdLSATsGmLRmk+o+qn5bJgRssewnnqB02g5HaAG6wkx3HEGQyD+6a7HJC4cXccDit3QZadvQEd7RLX35GoTbuthpmZ6HeMddZcWA/sGdqut5z7mYykWkEWXioy/eFSqcIi65OoA9a62w3br1Xtf7MPzRTI61DsfEskuMv5V9S5ggg+MWaY6gc/EcSq5T9HFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXVexwpjZ4bMZt/de4bGZPWytcnfsR6rlkz8hxlRfos=;
 b=f5a736emWn3QwSMfO81JxFR9w9AAirYINRYLC1jqm4cRynkFjHb0rVgWcPqdLMfSaxoJ9ZH9frRDvIlc36lYxd+efBdnWDDG/hxFOuqjewRHjbwOZxHVbzhUTR0HFezkN2vbaWFFQG6gIJd/o3mMpNALPnX/+JLIBVkzGq77DUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB6129.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 17:23:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 17:23:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI: endpoint: pci-epf-vntb: Pass PF/VF number when BAR programming
Date: Wed, 29 Jul 2026 02:23:04 +0900
Message-ID: <20260728172306.2751813-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260728172306.2751813-1-den@valinux.co.jp>
References: <20260728172306.2751813-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0023.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b9a533-f6e5-4a14-1f61-08deeccce622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|23010399003|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+25JYW2aWaKS3pYRLKjrk6LI4EGbzWZpXlIiJWQL5KzT8mQbQsj4y4sn/UoHIHnGbs4jL8lyfCxyGLsb8+SmptXxD97n5e3NNQ4i9eqALdrPoCxw9xzdk6tsxGsrlNb2/4n1E7Y7yo8ooBx7AasnoCYRk6pPfrLioMABb+FUwejj18AlRpN9oJg3ZctBRFnUGU9CLJdE3/kwA/a7EoIQu3Ws+PT5KSSBjXVoKWzfy1zn2nGPyJvcAIPg2EDqe2lXsNO5K+lE2SgNkHxuwvwjW43yx/SMqxPLL/ii+MgEY2+wybFZnRpiXgHG7XN2zfE4qDfGGPEkxyxPZyuDliC3ZlapWVMF260zqsiyTjqEsZZFnkZlRnwS+YF6vJ8oSdz59wntAKXgYrecE+Xv9y0ky+71uPI09neNopPPbqcId+lbumj3/VH9/WgyHiwWbjpc4oGcD4NFZRp4w+tp3U/kd3d+n1GdBlkaAXFoWMVDEH4TcBXhz1Fm16ywggdqrvoSv2mQdfmsG5gIUNwQVtpIjrh51RwtCCRDG5JrvQMAJXUsVuWgy4sX2XaUda0JiMqyQGJnTXZobAtojWfD91YNIpbAxdtusXsp0zOwSsSxIN+pgZO0Bd6c26EkNb9ywEJAHmqkRqXRbpnw9gSWZSeU3P7M5uWH9Uz14XFTF1mO2o4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(23010399003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CH2QB03qH4kQQhWEMDpA2Y2etQlzFjaJ3WKhY21VCxmI4jNO/AUeEZu5dz/C?=
 =?us-ascii?Q?8WvuihCyJmFf+ZYyp409T7V4wxbomokDnZhzGtKvgTiKnnRguPjswz9pKfPh?=
 =?us-ascii?Q?i37xSQYZo91wYvStr4/OU6F08OcdZZr+TlHC63SWMVgtfGacAYPz1VcIB4YX?=
 =?us-ascii?Q?fCDc5SmHhj5Vc/CbLiOkYHCh9f6Viy+MLdUv6ZqKoFKQ11eR1vagqR/hPmPi?=
 =?us-ascii?Q?KAJLtVVGHVBrWruAoqaLG/rs695wMHVgmzuoBZ2Eie+Rl9FkdTCIM4fPX1Ur?=
 =?us-ascii?Q?2GGr+2FKLf1wA7xsqGYbx8fuSDVTYKFr2Phqum3gLzd+U2gRNmVHWc8pF5SN?=
 =?us-ascii?Q?cwPCk+pC75qiXreXiKw6Ue4TkS29R2UFwbiFy1NOWOTNSke0qq230loIOPQa?=
 =?us-ascii?Q?CQwm9VL556WhVDUS3/97TVxJSy/BQukg7K95Sp98Q0FkN7hgU6a23LrLKvfE?=
 =?us-ascii?Q?0iTXNL1SoSd54czi+iRG9IYJJTScXU7e8LYjkxS3kuqGCmDzTL139eVJ/rEI?=
 =?us-ascii?Q?++Ak0hPpDBO+FXYPT4AvU0FMoScYLfch08HQd+8PhqJl3Ij4l2DPTh7wb7Gv?=
 =?us-ascii?Q?OUxY4Tef8en6ZJpj4Mm9JxzkAwQI8vGbNhQWCLYeH7ipPDmYyiRdpD1U5lrT?=
 =?us-ascii?Q?WEh6usYXjRuzaaVIT41om3tEqndHPd/9WtYG40yLjDJQIM6mnUuDjhccSslp?=
 =?us-ascii?Q?43q9MOW9qjvH6jeOvO6OIv/YDlGuErd1dEGwMDwEtisBGfNCtblvd+1w15Q2?=
 =?us-ascii?Q?ThViK6bRdkZEzxue5/Tn6BlZBPWlGTUE23jHUqB4Af+tUPtM363jCuuSjSbP?=
 =?us-ascii?Q?i/FrqOYZlLPFjWLDls10DTm2ggzvRqNYxtbTfQrNO9v6Qofyi0EiWUWZiwe/?=
 =?us-ascii?Q?yseKeSbuir+oUWGSDRIXWJSgpadhvBdJWbMbn2s5NN/KrYwM/sDv90HnRP5F?=
 =?us-ascii?Q?7NaV/sHj7W66xLNvJeyM79MXOjyeJWmxGQTAy0f1Ngx8BdYMjHHWTYd/FWAr?=
 =?us-ascii?Q?YO9u8muHRz9rMW6BgM2r7ZpC1f8nK9O7Nv3ORoVSi9In7XIrrjc6DVw7NFC8?=
 =?us-ascii?Q?dt98S8aMQPh4mGuVJMKeTerDLiyCmZgdBejgXuNGBruAeod4FN8tc+yUiX49?=
 =?us-ascii?Q?mcxc0RkOpkVZAObPyBZqWj751/X8/PiLxUtOa9fGzVAk+aFnXi024b3IUA4N?=
 =?us-ascii?Q?NUuPg5w9g2+i/McHmJ4RUUa9oDep+jXOdxUPCkOSQQ1Q7uUunuPIH4bSqg9m?=
 =?us-ascii?Q?QeGVvIooFXbd5GF+UU0ZwQKile2IeJQdZXWL93/0KnI+etQeUSwykfrCuKjv?=
 =?us-ascii?Q?SD9NZjuMcYECwyjUcBad5jDhk2vhiYp9HtLvAvOX0T4Yui1noR9QY6qevoD3?=
 =?us-ascii?Q?0GukC4800tj0VXwswr2nt1YJVEO/5zW/De5k4S3K4jX0LoANNJbXdoXAgP4z?=
 =?us-ascii?Q?CR6/BEZEcI6ogrDUXkCZbMggreoC9d3gKNbD+KofyTq/l4+kdQrbs8v2l+Tl?=
 =?us-ascii?Q?ED+FXXisozUae11nv1CGm59KPyBQXwpd7sSzaVUDlZ63weSjG1Mx/yJVmoFQ?=
 =?us-ascii?Q?zUyBhdN2jFO2wGulYEIZaocQYOGsR5o4nx3cR5BBPDx3F+VkiIGHxWHEBzqW?=
 =?us-ascii?Q?vz3d/66tx36shaYwH032S5fJKdqJLx0oblpbNABxwgHcflMo3ck3FKlebxlh?=
 =?us-ascii?Q?mehDa1moFbsnOct1+Qt7x0p4zIkuDlbqS69QHZ/FfRMjeiAUC5wDfyx6suYr?=
 =?us-ascii?Q?xcH08DxAvqQauB95LfsM44ISTIcckipbERHHfppx50iAMcdzKPLt?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b9a533-f6e5-4a14-1f61-08deeccce622
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 17:23:11.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZD4uMpXCms8sbFH2LSMeg1hyipNal5+FGV5oxYPI1FQ6MeCWdUXxMOO1+Z00LO6HZa/3YIzyBEJxESOhVAF3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB6129

vntb_epf_mw_set_trans() programs the memory-window BAR through
pci_epc_set_bar() with hardcoded function numbers (0, 0), so the BAR
lands on the wrong function whenever the vNTB EPF is bound to anything
but PF0. The other BAR programming sites in the vNTB driver already pass
the EPF's own numbers.

Pass the EPF's own func_no/vfunc_no here as well.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c3caec927d74..fba65abfb6b2 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1427,7 +1427,8 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	epf_bar->barno = barno;
 	epf_bar->size = size;
 
-	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			      ntb->epf->vfunc_no, epf_bar);
 	if (ret) {
 		dev_err(dev, "failure set mw trans\n");
 		return ret;
-- 
2.51.0

