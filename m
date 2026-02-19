Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021077.outbound.protection.outlook.com [52.101.125.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC86332EB4;
	Thu, 19 Feb 2026 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488806; cv=fail; b=EnxCWfTDW0lqMBhNJM4LcZM/bj+dQJkSce3Qzq1+UnlIGK5c8evNTgaC27ERCv8b8CbDRNQxo0IE78usd9o+6KgTVejMtLsc6Z+IKmPj7fHKFk4es+H6w3Ga5fu9UTpVO+35uJV2YCh3dKrwX+c7RB6YNrki4KIKj9YGvUkOsB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488806; c=relaxed/simple;
	bh=vnhHf8GNNl878ygEZgGFOwu8orZsPY+du4ZNl8ciVtE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VGIQ6rZJKelzt7KfIW1FHgZLVWrAWNOZvtrzOmymxYLP4yuGgyczp4FyTLO2cY7trd87tBYgnFq13utH8s5nc83go5fAkxuZRhF0PCnStxEMB/UBg7Hef12QYZbnu8w4LEcSaoePjLrntE4jVAuryR6HBPfR7GlYr03WgpiScoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FVwC2opu; arc=fail smtp.client-ip=52.101.125.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FVwC2opu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkpjjdVMsgiliAPoDa91Shc2hy1ygEtGH4Q4LePrBwODOyE1WUJZRkkmmsz+s21Em9X/LslSYUe8fkK6Qk30YkYaQcMKbRCno61FleGCfMisat41oaNm04cJSb83hvPVywgoNZG4IovtEitHBK3Fn3QYKAZ5GEzEfeSmubLdbRIgz6GF4U7B/CMoLIsFOXcCt49nEgWzFLDp9BzbNLu8MNtZjYyUE7UlXSyc+9I4TF0+ph6IHKxbBCXkE6R7Dh/CCzM01pccSBZ1i01X3MWWoFyJFkZvGc4CDcdCDJc8WekcAGFZZGNbv4ep06Mv6D1cdk3yHZ1NLHlG0g0I6yOtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmbHi8ZGT55UiE8BZXNEjIawyKv3C8W2RyrL0ecQC6o=;
 b=sc/oIa2mQg9VE+QFaJSLGTeajmRSi2/gJJCLwucrInkc1Sxma5pyzjKdQyjOV67uZKRWde6KxgH0KVqMususCWvy1RPqbsBCrsyzrrWf6um0mBiLQY1D7hwFROdvFuv53ud2nsMo8pfDm9m85v3VRzRNv7iuPy4XOZNojqMvVr3WeGWgGUabpVx2bGPQSetigcHRkqtoA+1ql4i+5AK0dD9O0xpylHIxU52RYK70VcpTCvL46qILd18zZAtMvQs6fthXUZr+p4HvGt5Zuq3YY8S29j30hfAzGWOTzV5CrVUqlfIrzl5ftbxV3GFbP0BJj1kmjOZYFO7KD2xiM7QXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmbHi8ZGT55UiE8BZXNEjIawyKv3C8W2RyrL0ecQC6o=;
 b=FVwC2opuYrkdc9xfsc2XxzIJc00gf1mLN4ati7vdXkAdQKjo4iTbw2rp83nQtw3C04G+MNDq6kP8xuT1T+qgmGdgB88Z0Z80fDrNpHvZzmmZ6ztHZe/KRWuPCI6gu6buoAxM3xnusdZvHLyhUgYV37RGcELYsXkPxqdF/FGREaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5862.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 08:13:21 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 08:13:21 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com,
	shinichiro.kawasaki@wdc.com,
	christian.bruel@foss.st.com
Cc: mmaddireddy@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v9 0/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Thu, 19 Feb 2026 17:13:11 +0900
Message-ID: <20260219081318.4156901-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0066.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 993fad67-7c8d-44bc-523e-08de6f8ebee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vu1eO5yL1t8TtsHOl0HH2cVT+vqsQTjP+ZJ735fSgfbokpqolaGphGsC7zkl?=
 =?us-ascii?Q?a7IjL3FCUecxq4h759CQ1zXV1Q1Hb7hoqG0/mie2SP4YHICkWTtEYYoQip20?=
 =?us-ascii?Q?jLa011JAqLDEhnvpklD+t4M/XgZPmztrRaAx6xnfOOuzrTQwwgogRmW0RQVw?=
 =?us-ascii?Q?MfEOxB7TzAqLfxyHHcUOMcEBRbPF6yfSDsXmKKjrpJ+FqvxWYXeduALimooz?=
 =?us-ascii?Q?rscIOgPYNCn0JqOF99ljGiGg5yRwCxPaefqR8a2tRuz69wIn8ZwiBWemQx17?=
 =?us-ascii?Q?pj/ibtKtN5uZWvWvfPvvHXGrtTtYo2gk0cNeUVxF8vIbaMUB7UJgCyZMXTSE?=
 =?us-ascii?Q?eME5FJJxBU1MvvAxs4xc9HCpeZH7SuFCWf11rBRqaEfXLPt7xsXyPRQotURO?=
 =?us-ascii?Q?CB4P7YueJO/1TVCEEn9VqHLqUftqGXyj/v884gvCdLOwb3pcxEcUc+YMYP4g?=
 =?us-ascii?Q?eXVV3kyrOakqYntGfBXsbBV5seIf9nDRUtNuUgrM1Kjs6AUpb2NMOWPjGn6G?=
 =?us-ascii?Q?wWiGpBQvpkFSr15BGE4XZlt5DjKrrpQVG2k2GMXmO5eCa6VzLYtZWFC6Xdc1?=
 =?us-ascii?Q?92Kb4+2BKFTKw9/b+eZTGRO2rOaa5znhuZ+/OwCYtL5fHH3LdfXjd9w3vqWf?=
 =?us-ascii?Q?+A4WAeQAYMhiWaCrLuhxuSvaFBEnDs1/QbHbA9fFJ2haJ5M89Y/GaPfHwcaX?=
 =?us-ascii?Q?Y4VlgCzO+MMuFOfruVLhzJHGyLUT1QBCurnI7tiaNTUVJ/NIf4hLxowp2O4t?=
 =?us-ascii?Q?EEHaGjbMMi7vdYQZ6gudheS41m06lC3jViRhZYVcM7DJVsjKdQ5bNdqvLR+s?=
 =?us-ascii?Q?JEbwVsMDw70SBjDZBApfedZx0iYDNGQwiW3DGlKQakwI+cbYa3Zr1QVkAHgf?=
 =?us-ascii?Q?PFdw/D900WZFaE7OeL4DnSWWWtaw/jTryhEZtbjY3FDNOL2y61sV26R7MLXY?=
 =?us-ascii?Q?BrE4cIe4CrFEXqmTcqY9R+RSv05ujN/Hw1DdeupKHszV60X2oueYjeEeYpDn?=
 =?us-ascii?Q?h0NwADk7XbUIz0jfXpBHxfw1FJVhyEqrA4e6Rx/j74xKXqPKqZc1rGIkgmdj?=
 =?us-ascii?Q?0J2I1fHwQhjvU4xrAtih3ArYKHFx+dmI/ojF48PXEsD0HeNjtrDEW2TkxQIg?=
 =?us-ascii?Q?sgcNxXnLCm21ZK0HVK5oChWe+6icOZ07qDs2sqgDms42+KmXBASeQ7vfwOGg?=
 =?us-ascii?Q?8W+Zb0/f3El84YU+qBKWRMnrHpqJ482LVXAbZFwZ0DdMVMxyjwcRaAoQZ9Mp?=
 =?us-ascii?Q?tqPv3XtWCh5EXwFAgx+A74BBFAwTIq2IkC0OnwF65eQLdClBY5Lnt+hPyNu9?=
 =?us-ascii?Q?9e2klp/1FLyoax2/eXuQcokm+WfpGdkf2vyMYAPapuB7ixRDj+w3jC1SKlX8?=
 =?us-ascii?Q?fnpLLbCgZxWR9UYCV9dFJ+0lnpSv6qQdsxnXcG0o/8unTVV8FhQ1rwalxXhZ?=
 =?us-ascii?Q?a8CPl0w8TLp3t8hrZ9iRsVRgLw2NzizimdlR2KZT1jDZcbdPLmEgLOOUVDk0?=
 =?us-ascii?Q?k2nCstHXHYZU8ZNsfYqRLH3/VKBvNmRicxoVULT7zZlnHnl9lgWBqgA4hU+Y?=
 =?us-ascii?Q?x022QN38JSDH0HpxWWGEzR7uku43QWn88b95fMJjcQRZrueTVVCJE/Bg9t53?=
 =?us-ascii?Q?TxCMVMqgupHYXPyxwme3aQE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xdM988QfA4MqoMPkdGDs29V7x16dTbQchrPJj6snqVemuh5BWSIzcDJgQL8O?=
 =?us-ascii?Q?yUMwVTz02S4DikjZOQJ/L9N1OES1DCN6pfmQB5RDPbYAc3xxAHVenQEAedMW?=
 =?us-ascii?Q?tHb6VZoZ2yxXFqZaB2MFOvtsD/w8SjpObOY3LS23/W6ZxBK5pHTn82cV63pC?=
 =?us-ascii?Q?vXMqO9ocQq7k4aJzZY1ddA7igvasqaOy6DpCgUYzWZi3XKyukXCgFqiwsVaq?=
 =?us-ascii?Q?MwuSvU9SjdQJTuIVXd3D9/u05W65tWSIJM+orR8vRkeD9igWGMS8ECNO1M2H?=
 =?us-ascii?Q?bY6t28hK4P4DA4eYwHXz58KfY7XkGE99Zyt871z+5/umPtRhvslQrHFB60Zr?=
 =?us-ascii?Q?crh/N0l6grfoeGNm6jh3E4r1xl0Jotz8BSojaEkrr6F6pwHnCdNqjox5rqLV?=
 =?us-ascii?Q?FPBAv9SwJ/WvFLRFxHdtL2yzczqMc9q+2k4VbvSzVkvQbYtktzEWhWyrRTeJ?=
 =?us-ascii?Q?Wh/KhGmIDjuD/UZweEP1t4RNFo6GMk2jO7IAaxLqhOQG9vmsrqRUfg50Qwho?=
 =?us-ascii?Q?p9ndfKT0vhQC3g2XEImfpjXRk9GONUK+h9P2gm/Eli/OONj0mxY1+kkvpF0O?=
 =?us-ascii?Q?N50ZS+ilQjtpPN0s1GkalWQ19WFxDXWxS1wn6JUV6Bh2J9YUzAYxNaqkD/j9?=
 =?us-ascii?Q?VMYEjToflCAluqc+q0Ez1LygyuX8c2mcSR7zUVFO4u97oLZWZEtJtbZvUbZt?=
 =?us-ascii?Q?hboyAESs9Ne1+Vpd4y6nXFkEpSRGvVAjo46mOx/IASnaVPPRrjZyF7xlsPFx?=
 =?us-ascii?Q?DvKLVv7f3ZtaIlD02QrncAku6BRo31xFgDmp/IteuqVl+rMvofpA37biaZzy?=
 =?us-ascii?Q?FOyB4xFA1eG7LBjlqlJLtf//dnuxYbg25HBiQEL3rflb9WH/qn4PReKnJe7Q?=
 =?us-ascii?Q?4OKRIo+AVuOKqIuGYrKR4olNypFEvxpcifSGrXr+OV/kFBdHO7i3QZmubvYx?=
 =?us-ascii?Q?m+sXOSPTPaz6JmM/KfrZwixS+wqU3rfLZoc3wixZg1uVIQJlI/NM4xSfNENH?=
 =?us-ascii?Q?octEdy0EfpdUr7fKZQA0+QrH6oLzfbolLxYjaxZgrIIMnpg1c7ev7tR5qox+?=
 =?us-ascii?Q?FyFkzlWksk/0e4cJUMiSaKlOTTiclasBxMZ8dMBwLJ3voO006d1dtbDZr9HO?=
 =?us-ascii?Q?RFj2aH9JPDaLeQvAN4CcQsulZgKBfyhz3C/CAgAUb3ykCnPrQkEwBfoQ0Ty8?=
 =?us-ascii?Q?KC3BMd7ViRAoNXkYuhbgEXf4xU6uyiCdsBtE4UUn7zT5B43D0JzgIjeUx8jO?=
 =?us-ascii?Q?Vd2bgomLKKjf5xxR6XC+ggkUDlocLVrpu3fsEOampZVVFIku0qyoQFr1XBqk?=
 =?us-ascii?Q?LqbhYTOnMpUcTj2upqnmJLsEP+PELvwA1TNZmII1+nK3mqRBuEB4fdpe6GwG?=
 =?us-ascii?Q?Z8cX9FMeucJe2EWrTTB6mJLP7OxWnZDnG1jY5rl040IJ0ko/v3EhYNDJ34w4?=
 =?us-ascii?Q?se8FzBVkmN9SGKu5fMGM8yyM0+6sHnpsHcz2HthFtZPtzgq8c9q1b5BjgN/x?=
 =?us-ascii?Q?XcmCASS4QSkvYp1REcGGQFO5GxeacxQm5YCQW/RLjqKgxRo95pUPri3lPErP?=
 =?us-ascii?Q?kQoE6xyM7bYW5xsDlayTVgqUWe68XrkPFt/7sqRU7bQ8qwpChQ1qRER79Uha?=
 =?us-ascii?Q?qF6yk//biSH5HhhgQ1sXgdLBhMw3sd3ourbjoPoAw3CslgAbsN0tuHee59Fo?=
 =?us-ascii?Q?FpAo0x/2gpK1imBTamB7Api9A2PyO3vJuRPUE/9hHDyUkKXngVeu2Xh6ExxF?=
 =?us-ascii?Q?/ZMN2zU19/8Jhw2mnpszsdSD0YRWn1wdbp9F8pZzzNmi+AMLBwSI?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 993fad67-7c8d-44bc-523e-08de6f8ebee5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 08:13:21.3000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3QiH1VJrpt8vgiu+Bjy5rZ0Rb/p3YGPHOVx1+AVc9Z4knRDlXYorYMPK+axKhg54nFuAQQVf4vr9TCXCkxiDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5862

Hi,

Some endpoint platforms cannot use a GIC ITS-backed MSI domain for
EP-side doorbells. In those cases, endpoint function (EPF) drivers
cannot provide a doorbell to the root complex (RC), and features such as
vNTB may fall back to polling with significantly higher latency.

This series adds an alternate doorbell backend based on the DesignWare
PCIe controller's integrated eDMA interrupt-emulation feature. The RC
rings the doorbell by doing a single 32-bit MMIO write to an eDMA
doorbell location exposed in a BAR window. The EP side receives a Linux
IRQ that EPF drivers can use as a doorbell interrupt, without relying on
MSI message writes reaching the ITS.

To support this, the series:

  - Adds an EPC auxiliary resource query API so EPF drivers can discover
    controller-integrated resources (DMA MMIO, doorbell MMIO, and DMA LL
    memory).
  - Updates DesignWare EP controllers to report integrated eDMA
    resources via the new API.
  - Updates dw-edma to provide a dedicated virtual IRQ for interrupt
    emulation and to perform the core-specific deassert sequence.
  - Updates pci-epf-test and pci-epf-vntb to reuse a pre-exposed
    BAR/offset and to honor per-doorbell IRQ flags.

Many thanks to Frank and Niklas for their continued review and valuable
feedback throughout the development of this series. The Reviewed-by tags
for the last two patches are dropped due to the additional changes
following Niklas' review in the v8 threads. Since the diff is small, I'd
appreciate it if Frank could re-check them.


Dependencies
------------

The following three series are prerequisites for this series:

  (1). [PATCH v2 0/4] PCI: endpoint: Doorbell-related fixes
       https://lore.kernel.org/linux-pci/20260217063856.3759713-1-den@valinux.co.jp/
  (2). [PATCH 0/2] dmaengine: dw-edma: Interrupt-emulation doorbell support
       https://lore.kernel.org/dmaengine/20260215152216.3393561-1-den@valinux.co.jp/
  (3). [PATCH 0/9] PCI: endpoint differentiate between disabled and reserved BARs
       https://lore.kernel.org/linux-pci/20260217212707.2450423-11-cassel@kernel.org/

Regarding (3):
  - [PATCH 2/9] and [PATCH 3/9] are strictly the prerequisites for this v9 series.
    In fact, they are split out from v8 series.
  - With [PATCH 6/9], this v9 series should allow the embedded doorbell fallback
    path to pass on RK3588 from the beginning. Given that, picking up the whole
    (3) series earlier should be the most streamlined choice.


Tested on
---------

I re-tested the embedded (DMA) doorbell fallback path (via pci-epf-test)
on R-Car Spider boards (with this v9 series):

  $ ./pci_endpoint_test -t DOORBELL_TEST
  TAP version 13
  1..1
  # Starting 1 tests from 1 test cases.
  #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
  #            OK  pcie_ep_doorbell.DOORBELL_TEST
  ok 1 pcie_ep_doorbell.DOORBELL_TEST
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

with the following message observed on the EP side:

  [   82.043715] pci_epf_test pci_epf_test.0: Can't find MSI domain for EPC
  [   82.044382] pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback

(Note: for the test to pass on R-Car Spider, one of the following was required:
 - echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar2_size
 - apply https://lore.kernel.org/linux-pci/20260210160315.2272930-1-den@valinux.co.jp/)


Performance test: vNTB ping latency
-----------------------------------

Setup:
  - configfs (R-Car Spider in EP mode):

      cd /sys/kernel/config/pci_ep/
      mkdir functions/pci_epf_vntb/func1
      echo 0x1912 >   functions/pci_epf_vntb/func1/vendorid
      echo 0x0030 >   functions/pci_epf_vntb/func1/deviceid
      echo 32 >       functions/pci_epf_vntb/func1/msi_interrupts
      echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
      echo 128 >      functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
      echo 1 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
      echo 0x100000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
      echo 0x1912 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
      echo 0x0030 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
      echo 0x10 >     functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
      echo 0 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/ctrl_bar
      echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_bar [*]
      echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
      ln -s controllers/e65d0000.pcie-ep functions/pci_epf_vntb/func1/primary/
      echo 1 > controllers/e65d0000.pcie-ep/start

      [*]: On R-Car Spider, a hack is currently needed to use BAR4 for
           the doorbell. I'll consider posting a patch for that
           separately.

  - ensure ntb_transport/ntb_netdev are loaded on both sides

Results:

  - Without this series (pci.git main)

    $ ping -c 10 10.0.0.11
    PING 10.0.0.11 (10.0.0.11) 56(84) bytes of data.
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=6.04 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=12.6 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=7.40 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=5.38 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=11.4 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=9.42 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=3.36 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=9.48 ms
    64 bytes from 10.0.0.11: icmp_seq=9 ttl=64 time=4.24 ms
    64 bytes from 10.0.0.11: icmp_seq=10 ttl=64 time=10.4 ms

  - With this series (on top of pci.git main + Dependency (1), (2) and (3))

    $ ping -c 10 10.0.0.11
    PING 10.0.0.11 (10.0.0.11) 56(84) bytes of data.
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=0.845 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=0.742 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=0.868 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=0.806 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=0.951 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.965 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.871 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=0.877 ms
    64 bytes from 10.0.0.11: icmp_seq=9 ttl=64 time=0.938 ms
    64 bytes from 10.0.0.11: icmp_seq=10 ttl=64 time=0.960 ms

---

Changelog
---------

* v8->v9 changes:
  - Add a new dependency series (3), which moved the BAR reserved-subregion
    framework + the RK3588 BAR4 example out of v8 (dropping the corresponding
    patches from this series).
  - pci-epf-vntb: rename the duplicate-IRQ helper and invert the return value,
    per Frank's review.
  - pci-epf-test: drop the extra size_add() doorbell-offset check, per Niklas'
    review.
  - pci-ep-msi: add a DWORD alignment check for DOORBELL_MMIO, per Niklas's
    review.
  - Carry over Reviewed-by tags for unchanged patches + drop Reviewed-by tags
    where code changed.
  - Rename the last patch subject (drop 'eDMA' word).

* v7->v8 changes:
  - Deduplicate request_irq()/free_irq() calls based on virq (shared
    IRQ) rather than doorbell type, as suggested during review of v7
    Patch #7.
  - Clean up the pci_epf_alloc_doorbell() error path, as suggested
    during review of v7 Patch #9.
  - Use range_end_overflows_t() instead of an open-coded overflow check,
    following discussion during review of v7 Patch #5.
  - Add a write-data field to the DOORBELL_MMIO aux-resource metadata
    and plumb it through to the embedded doorbell backend (DesignWare
    uses data=0).

* v6->v7 changes:
  - Split out preparatory patches to keep the series below 10 patches.
  - Add support for platforms where the eDMA register block is fixed
    within a reserved BAR window (e.g. RK3588 BAR4) and must be reused
    as-is.
  - Introduce a dedicated virtual IRQ and irq_chip (using
    handle_level_irq) for interrupt-emulation doorbells instead of
    reusing per-channel IRQs. This avoids delivery via different IRQs on
    platforms with chip->nr_irqs > 1.

* v5->v6 changes:
  - Fix a double-free in v5 Patch 8/8 caused by mixing __free(kfree) with
    an explicit kfree(). This is a functional bug (detectable by KASAN),
    hence the respin solely for this fix. Sorry for the noise. No other
    changes.

* v4->v5 changes:
  - Change the series subject now that the series has evolved into a
    consumer-driven set focused on the embedded doorbell fallback and its
    in-tree users (epf-test and epf-vntb).
  - Drop [PATCH v4 01/09] (dw-edma per-channel interrupt routing control)
    from this series for now, so the series focuses on what's needed by the
    current consumer (i.e. the doorbell fallback implementation).
  - Replace the v4 embedded-doorbell "test variant + host/kselftest
    plumbing" with a generic embedded-doorbell fallback in
    pci_epf_alloc_doorbell(), including exposing required IRQ request flags
    to EPF drivers.
  - Two preparatory fix patches (Patch 6/8 and 7/8) to clean up error
    handling and state management ahead of Patch 8/8.
  - Rename *_get_remote_resource() to *_get_aux_resources() and adjust
    relevant variable namings and kernel docs. Discussion may continue.
  - Rework dw-edma per-channel metadata exposure to cache the needed info
    in dw_edma_chip (IRQ number + emulation doorbell offset) and consume it
    from the DesignWare EPC auxiliary resource provider without calling back
    to dw-edma.

* v3->v4 changes:
  - Drop dma_slave_caps.hw_id and the dmaengine selfirq callback
    registration API. Instead, add a dw-edma specific dw_edma_chan_info()
    helper and extend the EPC remote resource metadata accordingly.
  - Add explicit acking for eDMA interrupt emulation and adjust the
    dw-edma IRQ path for embedded-doorbell usage.
  - Replace the previous EPC API smoke test with an embedded doorbell
    test variant (pci-epf-test + pci_endpoint_test/selftests).
  - Rebase onto pci.git controller/dwc commit 43d324eeb08c.

* v2->v3 changes:
  - Replace DWC-specific helpers with a generic EPC remote resource query API.
  - Add pci-epf-test smoke test and host/kselftest support for the new API.
  - Drop the dw-edma-specific notify-only channel and polling approach
    ([PATCH v2 4/7] and [PATCH v2 5/7]), and rework notification handling
    around a generic dmaengine_(un)register_selfirq() API implemented
    by dw-edma.

* v1->v2 changes:
  - Combine the two previously posted series into a single set (per Frank's
    suggestion). Order dmaengine/dw-edma patches first so hw_id support
    lands before the PCI LL-region helper, which assumes
    dma_slave_caps.hw_id availability.

v8: https://lore.kernel.org/linux-pci/20260217080601.3808847-1-den@valinux.co.jp/
v7: https://lore.kernel.org/linux-pci/20260215163847.3522572-1-den@valinux.co.jp/
v6: https://lore.kernel.org/all/20260209125316.2132589-1-den@valinux.co.jp/
v5: https://lore.kernel.org/all/20260209062952.2049053-1-den@valinux.co.jp/
v4: https://lore.kernel.org/all/20260206172646.1556847-1-den@valinux.co.jp/
v3: https://lore.kernel.org/all/20260204145440.950609-1-den@valinux.co.jp/
v2: https://lore.kernel.org/all/20260127033420.3460579-1-den@valinux.co.jp/
v1: https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
    +
    https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/


Thanks for reviewing.


Koichiro Den (7):
  PCI: endpoint: Add auxiliary resource query API
  PCI: dwc: Record integrated eDMA register window
  PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource
    API
  PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new
    backends
  PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
  PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
  PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback

 .../pci/controller/dwc/pcie-designware-ep.c   | 151 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/endpoint/functions/pci-epf-test.c |  84 ++++++----
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  61 ++++++-
 drivers/pci/endpoint/pci-ep-msi.c             | 149 +++++++++++++++--
 drivers/pci/endpoint/pci-epc-core.c           |  41 +++++
 include/linux/pci-epc.h                       |  52 ++++++
 include/linux/pci-epf.h                       |  23 ++-
 9 files changed, 520 insertions(+), 47 deletions(-)

-- 
2.51.0

