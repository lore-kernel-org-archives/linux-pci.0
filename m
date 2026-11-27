Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749129;
	b=t3cUio9LkEGyRVhWK16B8mJ4YCU8et6r9bPKy9vtfOIxubudoMdIRonud+P2JNlj0Yju
	 F+7kQnBphVRcYYxeG0kVtOonc+hhqSD9NDfDDt+LxwuZ7qnleErf9vZXTmAfmh+pCSWnJ
	 IUkG7CyTOrRUgxRlg89sa9n7wxlrCUdPWyMkrSJZ3hGgfTCFcDmEIKKIPXN0+V0Ef5ucH
	 pJxlB9zc4UaZViKGXkLk37q1pwzgzDJKFScNrhBES9S+0Vt3s6f8UpAaeRsg4w+3rKKue
	 90RbPg2f8Rxp2NB3fs6kAUlnQMd9enRp+QZz4pMMizXlfuJsL/G5Za9iKX8+jLS/ZZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749129;
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
	bh=bKO5+1gN+rbH2cGa8JyCeEJkAR26X6AOlNMYiC7fioM=;
	b=eCoXJlzZ6LAaNwkIefDQPZ5TJVGx9bJNzhv+DPt+THYb9QbGg4Bf3WnSWmIbElb5wffx
	 fzFWGgyht75RtBAcHCoqsZLsSf4a5/sz+kLSjtzMXoAH1r94BQO2SMgzaIMU7OWAKYLxn
	 MqzYF/BjTPKp6K0pVpwRGTFIr1/YJjMIUxpdy2PL08KcNe5ykOebChbvcZI3xLm26lYnn
	 xY7tqqnEQXCPwONvu0Hg8oJFSuLtm0nQW3KHCHwF0vIlQm0ET1UtFPlvVoQgH3k/6qNag
	 1RKuQc3re/u8zlou1V+x72+LbR7gIQFsK695DwnhviTQN1bSU3+Iv3/gT7iMgQ2tqpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ArzvI5Su;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.135
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020135.outbound.protection.outlook.com [52.101.228.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5312606A31C;
	Fri, 27 Nov 2026 03:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5312606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ArzvI5Su
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOZAPnJyHGt7x0WPZ3Sy8dKR6/ZtXo90dOHdm/i8lenPzbbYccRHcZF7fTexE0EcXCF3gkbQdDb6NYqDfokY9DuHJB1P6T1tr0CIXceG52hH5rkTFYby70mxeoNodEdVllSjNmkcI+RdVJ+BZLldcZgMJfczZXHUpl2nIC/khSe299X7NRScDe2jNp9jo17u8i6BBlZOga0dP82mLwYxsp0KkYTmFZQlZ/iFZrVy26weCTEhbGIDtxLh0fcNW83drOubQDFGQjXtiDHsQtWX1pSuOqAL31GKRwBCtstlkceNDyhoZKDXVwqA1mJwpFUKW1w1gVmrCktjCthrFVK8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKO5+1gN+rbH2cGa8JyCeEJkAR26X6AOlNMYiC7fioM=;
 b=J+5lyW6sehfdyb4cnw9+9jTO0djYtefLUqeajuFPPhG6RqTFVfJz7OgxXwscKW0PIu8rmNzMfsyILvTEY9O/PBqZd6qXMbVt4ecV632cJM5l8+eo0OL2zTt4X07fWKk1gAvBZ/h4APUFN5H5amN2987PbTy/5TAz+QMCTqtaGPrxfcIm70TpbNl5qP+klsdD4P39mO6X0Ij/XwQDtvsRdmdBePgapDKJSMe8aEfWlwfzV7LxMcGBx9A0YpnaI2jKFB1b13dwBWb9FJ9vbXPgI9hjNiwy7+HccI0mlYu8zqMbTTN+LGluCnBhzkJnl0+AW1wmcq0uvyD9h/TcO+1EEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKO5+1gN+rbH2cGa8JyCeEJkAR26X6AOlNMYiC7fioM=;
 b=ArzvI5SubGlluf44t3mvQ6P0Gfu9wUnjGkxhqPfVPIp85A6NMMgBj6h8gV3/xeN4yz8u0xfGjeaGCE3xiVJj07Ej360bQVP/AdzfayOSd8EKNz5AGVQRKDkG+oRFpuxtqr6YYUhsRe7sh8EfwudTjnrb8o49qt2IF3oyv3P16tE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4873.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:04 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:04 +0000
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
Subject: [PATCH v6 01/17] PCI: dwc: Add Renesas to the RAS DES VSEC list
Date: Fri, 27 Nov 2026 12:11:29 +0900
Message-ID: <20261127031145.2521228-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0081.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 5ecc65f0-bc86-422d-7931-08df4c343627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	ixHC8o3shFJ/Z52GOLaqkl5Yq3dYNLnr1SzYmAHDAzF8kkYXqhsypfo21nnhZwgAhYho1UmnB2XXoTeJwbvfFxjrpkhCGXOUbgpMloYNO1SLUrxekE1P1l7MhvCZa8VeAl3qesE0jEvZxMMu17PiqS1zzAXqYQuecHeez0sOf7YtKJELDYBLPbqP9OnJpntXbuuuqGxs0og1cM9k9K4ECWFiDq/XLvee4YBPpvZNIYsaohA7xoIHYrmLPJ8fDhs2fUHolRE8IFj0Opa2g3Spxecv6jOW3GPm7LK4ux26q/A0t8Cj1HywNXb7NpFAI25kmXt90KBGcqC69NLrs36Vbr0UyTQWekjaB8F/CgwOQK6CpOC2ezWwXJhquXIsVzQt/XFiVIhWLvwEtBUFMMiGGtr0skbwvTbvlWD7//jtydCa3YZVmOD9veSlNPSxiNmNNkzHsUPgmR8BdKLdyW+0ZtCz4ujgnz/skp6yXCft7kZlpbAYyiefwKhpopZ1JfPp94KT/78lQn52Cj6JfjXe2KVqhp/NnT49luTfeZQ3wsn3xwZW8GTAt40ZrbCMzx6eXI/cOwaMDqHj9f9Gj/ijShpgTOlqdQM34f7E27yAI2+Ox841LAwwF/+mRlm7rjcHduDjFH/kzsiaVM3yuqFQAEtIszMSa1J3/RJONI7aMtL57wbLiukbtGgRLZh03WHD3VX8yd2F3ew+R2Web3RxsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fl+eooZJ8zdkGUVBvBr9DtOCh8WnDrwgW0a9yhpA0DRpH77UiWKERTiDMC4K?=
 =?us-ascii?Q?uY8pIrxzhddwSzvglObTGt+rV+eT8QyLSU4L+1R89XSzmIPoXbvopH76IORM?=
 =?us-ascii?Q?pp7t40kPsHlAhPCc2i4MoXBYKFmZrAF6xu4x3/7GXjLbfvjIYimA42ki6PLj?=
 =?us-ascii?Q?pUajk0vFFqTdIuBhleG6u2BvDZMRDfVJN1Ryy8ZdrafeWj3qN6RGTWBBb+AR?=
 =?us-ascii?Q?XbPkFwfTgVVtn13iOLSAmhAzV0+Ne2LOQGVI/swG8WbqO0uby9d/tVWNqm3/?=
 =?us-ascii?Q?/Q9lQK1gKvf+2xut8qzRd6nPvARnWasGugSYroSi7ZGHhXXd+myz+7buspQL?=
 =?us-ascii?Q?odA8JHugf3gcP2n7gcjxlVhRPjinYP2U8G+Eb3fTIjSG59yZEXZT2glfz+/z?=
 =?us-ascii?Q?MUSM7LNb+Jl526Ea/i3ldxAzUzkaBE6T8E8R8OxN8uEn2HZfZQZ5wbQIM5Xy?=
 =?us-ascii?Q?cjSiRbFiLRTK6PnrlN4qsm3bTrHloVKFSvAmj6fPkA2kRtQtCzg0nyIIJiGO?=
 =?us-ascii?Q?Nkz/VvlPPR3PR2NdVjEcLRcb3xGKb9PVBh4pNMns65w/bAAmgpCzT9W9H0Mt?=
 =?us-ascii?Q?Tz1K4UYvucFvZsFfAkBLjWCexa4itBwQhYd0km9QFu281bSejuNAS0hZ+S8N?=
 =?us-ascii?Q?wqcoLKNUU5NvKeHN6/ZaVk+FtJpL+rqZo0R0vAy58Qf6JnSIq5hPR+Q+1vJ5?=
 =?us-ascii?Q?MreWjZ4FrsH6uj6vIjGenIg5gauJq/NJSQ3LBWdDsHovm2z4f9EZVvRrNZ+x?=
 =?us-ascii?Q?UEO6RJyghyXlrrtxxIt2DeAL++KU0TNopbiXobV2VmjubflqkEKqnRgb7Fg1?=
 =?us-ascii?Q?Ddpbd8wibv+4xQVj4C4Zn/GeCGy5N6WkTTS1z0sI+OKWPZwKDwWpzr7pRbdE?=
 =?us-ascii?Q?zi3C8mt3BPHfe6/rK8QFzbIYRusPaTAlWBc2ptb72KV9bDbYgJx4N94VTPPx?=
 =?us-ascii?Q?+Lt/eyQyoAX48fNLwVsFGORqBIYj2OVIQkW3DitBh+g0QZofA1ygtRsieABC?=
 =?us-ascii?Q?UH2N5oYIllVHChx4xk8t3vTGsA1CaM2Zzc2lkWtvdsUQjvMgq3+bZZsl63Bs?=
 =?us-ascii?Q?eooqPBh1elxysXafRuUOCKtwGCv6u8Jpyrj9F/3aDx306/TZxN5hkINz9Gzn?=
 =?us-ascii?Q?hvzgzqhTwwz+qe6p4cHYKE1W3xcl9ZXNWX57UvY93Xwu4xzRzWvpSuLPpZQ3?=
 =?us-ascii?Q?BQ4tma14asuKq+e36owwylb4MH7hGVR2y5daLlPcABY1iwDv418DaSea8xmQ?=
 =?us-ascii?Q?3veeUZ/IvQWvSG6QMfis/ta8ECub0oC9dHmZyvhY88O9rci3lUUmmlNabUDR?=
 =?us-ascii?Q?qnnWmSzgpV7jULNj3k0JfCOiBq0HtdHV5Ks0Q1UEvFgTysrNLiZypGjMi3BR?=
 =?us-ascii?Q?s3iwb/Thxtk17QuLwYxhDgSRUbcOGitNM9aQd7mgV2n1+9ftkFqEat20JooJ?=
 =?us-ascii?Q?Q6/w0OeqNnzxckbBihJl22K+JVF6C5m8uEIh4tqD1ptapaPD2EDqmTdqhLG0?=
 =?us-ascii?Q?tLYsMiG+BvChSCyoTcm6LKG3fOXSM1PrFNMx9YyuUVxnTuLFC66kRlMWNKbI?=
 =?us-ascii?Q?K9iKnvT+BFqh3/wAlOUHHIlbRerPAZM8+xVKnT7zfi79QD/8+WU4O8kLvp+R?=
 =?us-ascii?Q?CbfrGxbp+60wDNnkcmHkU/E8Bmg20psFLd1mig+mhA5xU9qmZIrRnJQPUFCz?=
 =?us-ascii?Q?fg99ehtlfSpflqN4t1LjLUYbi2tG3vS3juR8452MtdJ66nvExx44eVUf+p2q?=
 =?us-ascii?Q?/i5xEy9YxrdgeswoZSa1+lgFwk+VQwgERITbzCNIRgDIt+fQHYXM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecc65f0-bc86-422d-7931-08df4c343627
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:04.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/IDunN0ZbdAgXrx0bp5ZsWHDbQiZRYfZlJ+fggHbyEq1+g6qhHm2Onth3f/fpbZQ3Bzc8YJtzK6+9DuooRyrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

The Root Port on R-Car Gen4 SoCs (DWC 5.20a) carries the RAS DES capability
with the stock DesignWare VSEC ID (0x02, rev 4), but vendor ID 0x1912 is
not in dwc_pcie_rasdes_vsec_ids[]. Add Renesas to the list.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - None.

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
2.54.0

