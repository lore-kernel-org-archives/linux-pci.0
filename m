Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020081.outbound.protection.outlook.com [52.101.229.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35402DA74C;
	Tue, 17 Feb 2026 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315573; cv=fail; b=OXOF4LCbmup9ELy9QFB+g1ty93o92gFgRpEKO7M4Pvb7DRK4yzaWRjfEOav7Q6IfS3+ftlGK7bYpyI4a5UZR1OYqfFXsHoY/Hf8cu2TuHDQt1A4yxVYBZOW5KkCPR/NtsYSVUOAqHstiecIh7wWBZITTClLorrohPStoRZgtl2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315573; c=relaxed/simple;
	bh=npNLrhZZhDEpt6U44Dj36mqFUIvZXvaJ9rckyng2isY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gvYD56MWJmAg7rWDBRaQfssMDD1bSTik1w4I0Bq8yqNz+IdVRbdm5dBe67YZ82E5Q4TYH7D7TD9TCKE3iqWAq+M4ijqfgKSphEYatawsVT9sWFySYA8csyeHiITkBDeudOA//BJKA0s+yv7puY93NDgH1XIbT3ilsxpLfWYo8po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=etRGdEsq; arc=fail smtp.client-ip=52.101.229.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="etRGdEsq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMqaTcapTwwAJOTwJUUoAXaZkomDz1EKHMN03qvv/PNF6JuEA3zD/ZcK/7+M5GogyEwbtsY4cHDvjfqVwH5ngV+I2z1YKww8zwoBFWQlopgAnoDAgIxImMRNyKH6zBV60n48vPSwG7OIe0i7qz0DL8L4s+0JawDToPORxkMYEPkFr2bw1USHmo5rY4cu3//qiEXVUIjSKRJ0yqQl6j2jx71C3l6cU24QX0TtbsqHFUctSdspT653ioOyOoziS6Uk45sCCTTxv6+skev71jP5iSQWSXZueARfy5D13OU91iKvKbYdATB6K7zDbG80lQWbsAKTraVWPbJyyos2cmnLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frS66RaTiuw9CWICCg69JaLUv896JQfpx/e3U/sEPws=;
 b=Lzqwns1Frll1jd6LxSugxP1A27mJgL+81aPMDdwxBWTPLPtRT2lWhtps5iXL/Yi4CqiP05yvjPPat2XxFuW/nd4p3emwC4hCFXZBvCK17RzZt9x9xE7VA/beVi9+BcTS0DPDOZUw5yIFSJy3afO4D9gLxKezCKynAGM+oPVON4U1/TE8lFDkzCe6NNSXy7BKofKDgQ2rIY7dLiZmBemKh4xRzvP2AFDJkKJaNCaYnXJW9fAJDV8gFERSmkYTWIQ+bHCWkElel4sb/ZOagsgVAGoe7Zt1QSS8YRxh30PcU1O0STXMsjh5x/+E6oSMh3Ds/D9uZCM3fk9N3OjGkmmUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frS66RaTiuw9CWICCg69JaLUv896JQfpx/e3U/sEPws=;
 b=etRGdEsqympbwMCXUvL+W/qseQqHK2KT2p+p/x3sl48p/ZV6AhE9lrudmhI4WL4+TltAq2R9lF9YEUb++EKraJhAP5t85DPAq5i4UdbuVis1MdJAK+lHCchmb4XrxFApqf2F112nDgvft9QCPVzttBjTCp6aU6m9wq0pEDhpIFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7132.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 08:06:07 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 08:06:07 +0000
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
Subject: [PATCH v8 0/9] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Tue, 17 Feb 2026 17:05:52 +0900
Message-ID: <20260217080601.3808847-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a47462-c772-44d8-0d3f-08de6dfb6791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mawuaKsflY0KZ6TrCwY5Iay+4777zTZRL1XARn63+n/MaoYcUmKXJbqZFNJ+?=
 =?us-ascii?Q?T8g9wnnearZ0zWE6BglERb4VDG1WRVHD9kKQd7zlQi1TSu1P3VTETLuVZahK?=
 =?us-ascii?Q?4k0Bo/ZwsiYSAhLKZLQw+Z1yVPWJBksEkpgECSsv7HPBOWtN2nI8w2QXknlF?=
 =?us-ascii?Q?gnKUbXRurzeixAbRcuvGTDmPRyxV+cT8qV2sK49zT0NVn/u8PC5fSZ+wGbCI?=
 =?us-ascii?Q?c9dEgbpxH9nVFQ3lxPBbj0d6Tobn/Q83fGFFS1jSxgCfvZtPyPFjr/kk43xQ?=
 =?us-ascii?Q?LK1fYGuNKYBfDTMWvzOaLqNTabjDf335fKTO4O4HpoY6iNlrCdcxqJJbPJLT?=
 =?us-ascii?Q?Vx3iaNpre6ORCLuKkfDplPruecyP0BWkMARSSP8Lqr/v9WSYyrF5me+S5+Q9?=
 =?us-ascii?Q?JgxyQn0/3dOKyMJnOk/cq9rfLjZg6pRNa+sqGbe8T+1Zn/r1IoyD4U5AruiV?=
 =?us-ascii?Q?qVT2R79pH+16Gj+7qzHKfqWEb64e4AkU87DR1U6cPtX3jEgo4+uxHGEAyNP6?=
 =?us-ascii?Q?RK/CLlh/c7VOY0ulNEMgHO0xjzyriq64BARR+gOMiMfB/aadqNuvk8Z3UISJ?=
 =?us-ascii?Q?9ufOFR6b6hnxYvOZiLi+ffX8a7z7Aryay6lp1p+D1hZXIDnehSiFi1B/fw+6?=
 =?us-ascii?Q?39YkrIqp78sJ0VhWCGWTAxAstJTsTC8WkWTgOFYMHkauUKEe+ljZl2LJw08V?=
 =?us-ascii?Q?okQr4dXNxRgPCOBSgGd1hftmd0mygegfR+Cc/S8qIqC/0baNq9Ae0uaM2D0v?=
 =?us-ascii?Q?M6OvK4+Vu2AQRCsbsW6UjIs2UrdUHVG6NWRnq/6o7QZ91Ez98my4/sN6S1fe?=
 =?us-ascii?Q?vfNyxXq6jVi4X9GJSM2h4qP4zaOgOpB0XKoSjqjqVbt3gMx6Kw1w1JRNcf1E?=
 =?us-ascii?Q?NaL59piBg+tqeoQhZJarWx2qa+9Zx7c7eQxa/AFeOxbwBln2Rg33A3bRvez8?=
 =?us-ascii?Q?h5KtEABapCalRZ5xokDxjrOA7KtVZNBWUTP3wsfPHGlpSSZ5QSpr18/W3Lk3?=
 =?us-ascii?Q?cB6yeiOMBh70LsUT44SaPN69KOFlZd9/0ggmx7l8ZIBAGJeNl/GKJ1gAtQsU?=
 =?us-ascii?Q?VGqLGNnPxX20UwL/2p3oACL0nEX+Oo9YRlEZaibg3sTAwxTGeiv5FyB5UPzL?=
 =?us-ascii?Q?DYzkMmIaRtgflNRPxDI1LJkwVzxdljFO9S/Edbc7S+dbWMv+L/2nhuc/EcvJ?=
 =?us-ascii?Q?WbQpwxfoPBGW6udV1gDKOKmJzusGl9DREBxBKPXmRUdHui5YKUcPCngpmjO/?=
 =?us-ascii?Q?HCZsHcMcVFlBXkcLmvMu//E0Ml08hmN1mgPtLVzlXUsJsOVfKrdCuzTT/1Db?=
 =?us-ascii?Q?DbWvczPEffhvvvvDbUQeN713iHoqwb/ZMT94DtqWAkvXva2Y16vzVI0dItUE?=
 =?us-ascii?Q?QFPKnBEsnl/cT7MnYVULTL/Nkr+FyAkzJk0AvYVDjaKIL9NHrPAtktORBgwN?=
 =?us-ascii?Q?eBTTJURG1BQBJtrWSkHTbRdrY0bWDaHE0oj+PFO5qxPehERzRhmrOTdqZiLZ?=
 =?us-ascii?Q?XXL6rcL60g2qLXmt5lFaDcYkiPgF20MqrWTeMxXbBZIkz2ON2QTAmMzpbITQ?=
 =?us-ascii?Q?HByyzV/Ri+zyTCmEqOn5RHH3TosFuaaJdUkHDKG8jUQCF923aqcXR4j1zc4m?=
 =?us-ascii?Q?+aU2e+sX5dJe6a0d9kyzpes=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a32D8twZjHug7FSNFVREc+Aso5BuDckSM8GkuTFO0AFeSWGQIuCpAIHaSKSZ?=
 =?us-ascii?Q?XWdGGJrIMmnrgFMC3oekuLTSzY1Umie36+h3sKZRWxtRZBUX64bI+K5SNL8e?=
 =?us-ascii?Q?T/xdsuogUzn6dp4K5qziizr6bsd97Su3cO3S40Gl4RmISrU0dSQHRcUVWs/o?=
 =?us-ascii?Q?+Ke02BeeYz8CK2qbim/2dndtcchsm+GhoKOtnfpc25qW3x9QXjQRYSsCNNR1?=
 =?us-ascii?Q?DocTivqMJbzIZBQ95c/U0aBS56vWFDY0POiZV4chsuQryloLwQKSXunF18ru?=
 =?us-ascii?Q?gq1H32cRwp593EZiZP2Iap2gicOWajOStRKybTE9fPGHX9GYkOLogSkT1nz8?=
 =?us-ascii?Q?EAApOPRhJFBlprAJ6+CSnT6yHMoDGIQnKYDd9TrAejIrcIxjmW7Tnb6ov4ou?=
 =?us-ascii?Q?LciSCYkP38SCO39t9PD8vN+CPsk05dNe687AvQMSJtxFH4F7smes+dX0Esv+?=
 =?us-ascii?Q?bO6TfustOv6iWkuYklbNDFRjaDXeHDF4qUpilQg+0pTbjejTc97JI1XUbVDP?=
 =?us-ascii?Q?RiDZGuToMXb7jW+2Tr6ydVT99uYCSKDQyHfFZZ0WigUfyUuDDQ2yCDO7df3x?=
 =?us-ascii?Q?xoY2PRC4slmgOdCDhoayJwYYoRoexPILPcWBCXoqgkXQ46rKSk+3Fbl9u+zy?=
 =?us-ascii?Q?p3BiPuMasHBBrQMG1CThqEsCRSYoxHhCFWcv1G9lNbCAbvcCTVipAvfkUhxm?=
 =?us-ascii?Q?dELy8ontMMqopUct58QvSFxRrfwMMqd/5nVSnDGyb3K///Ti2A291gCQMUlG?=
 =?us-ascii?Q?3uVXLdTQCoDRzMTCfvnJJ+RovktTLTNlSV4/RkuN5tXTU86ONDvr1YqiEh1/?=
 =?us-ascii?Q?Nzi1DaVRRYxhLSakV+fGGs2fAizuz+MgWB9lTnQtUNJGSArGiXK/t+n6atkn?=
 =?us-ascii?Q?zWJvvB4tjGuxxVM5De9e5HjhXw87gl3PQOoZLjYHpjdaU3WmyEz2g6xJEGEt?=
 =?us-ascii?Q?j2cvj5MPAVJ5vV5Isff1miwyMZ2hxtXdie1PGRwIxwaTmgHtAmmDq2iZ4A7v?=
 =?us-ascii?Q?8sCbSXfIxXPmja0Ys/fch/BDErhMKatgnvQNfMOlxkNO/TEtH5WTp3VjiCyA?=
 =?us-ascii?Q?pBq4XC4jWU8bz/ByXR0UcYD6IxER4v5e4OuYjycDZCycRaWVp7ERD8GG0+M6?=
 =?us-ascii?Q?9bg7LQuYZVZfEIINfGHlWDF1EbypCZf8jdoKnQHtoVto0rP75au2JOBFaqKS?=
 =?us-ascii?Q?pByt4zW1N+nFHWSWJKrMoM0O6VWbQU8mbGm+NNieE40BZzgSqLsFHh8kljrI?=
 =?us-ascii?Q?OuK74Ta6Hcz3yaFsvkdfsQuIYX6W0NIO3LG48zIU39SoFVBvrFAAktvI0Ri5?=
 =?us-ascii?Q?PTWKbFZQqLNaOeopvADBV5OlZib3QFM0KatOQ9A1uWVQfxeRUbKlE69gUg3z?=
 =?us-ascii?Q?OBftUFyc3C3WmBsTV6WSGRAr/5hwtFXfRVM0vVAL0gU03wbB35f5uULqyfQC?=
 =?us-ascii?Q?8UhwB18nTSa1Z+OPAIF441PVS0ed/F4sC9StdBPQ4i3AGRHvyo3LJn50Ww3p?=
 =?us-ascii?Q?rOTMQ+ba2fTf8WOZESVB2025lz/j+Zsb3IGh+s7dw5mSphjCcLilFsnx2H33?=
 =?us-ascii?Q?pvJzBpcoBmrKqUB1OxeG6zErgdLvU7DA8W4qSqKjWRaLiJj2CfUN6YMqRS7G?=
 =?us-ascii?Q?JYcJFV3PgdxKvI8i7pM6lF1/B2MYcrrKMy1x7qYGpfghQX/c/2b2IWMnPLrv?=
 =?us-ascii?Q?JldGjFSb3tctS0pFieik5ycQCyyOHZ+XQfbfsMoNvV8hPZ05VB7+/v7UFk80?=
 =?us-ascii?Q?QJ59MKmAQJoHL2f2R1QXwCFAdUrkVHscUoBlHClJ/jcOOtSzqrJU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a47462-c772-44d8-0d3f-08de6dfb6791
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 08:06:07.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caFebBFoE3rpMxoUgV7xWQQBY4VFdh7/BRZhTOu6xh48m1NiJSQH/sbTc8MRphIVve2eDGpPj9HzkLWxXJSuDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7132

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
  - Describes an RK3588 BAR4 reserved subregion so EPF drivers can reuse
    a platform-owned fixed BAR mapping for the doorbell target.
  - Updates pci-epf-test and pci-epf-vntb to reuse a pre-exposed
    BAR/offset and to honor per-doorbell IRQ flags.


Dependencies
------------

The following two split-out series are prerequisite for this series:

  (1). [PATCH v2 0/4] PCI: endpoint: Doorbell-related fixes
       https://lore.kernel.org/linux-pci/20260217063856.3759713-1-den@valinux.co.jp/
  (2). [PATCH 0/2] dmaengine: dw-edma: Interrupt-emulation doorbell support
       https://lore.kernel.org/dmaengine/20260215152216.3393561-1-den@valinux.co.jp/


Tested on
---------

I re-tested the v8 embedded (DMA) doorbell fallback path (via pci-epf-test)
on R-Car Spider boards:

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

  [   51.332944] pci_epf_vntb pci_epf_vntb.0: Can't find MSI domain for EPC
  [   51.333507] pci_epf_vntb pci_epf_vntb.0: Using embedded (DMA) doorbell fallback

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

  - With this series (on top of pci.git main + Dependency (1) and (2))

    $ ping -c 10 10.0.0.11
    PING 10.0.0.11 (10.0.0.11) 56(84) bytes of data.
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=0.935 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=0.805 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=0.833 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=0.886 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=0.861 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.929 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.970 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=0.946 ms
    64 bytes from 10.0.0.11: icmp_seq=9 ttl=64 time=0.975 ms
    64 bytes from 10.0.0.11: icmp_seq=10 ttl=64 time=0.881 ms

---

Changelog
---------

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

v6: https://lore.kernel.org/all/20260209125316.2132589-1-den@valinux.co.jp/
v5: https://lore.kernel.org/all/20260209062952.2049053-1-den@valinux.co.jp/
v4: https://lore.kernel.org/all/20260206172646.1556847-1-den@valinux.co.jp/
v3: https://lore.kernel.org/all/20260204145440.950609-1-den@valinux.co.jp/
v2: https://lore.kernel.org/all/20260127033420.3460579-1-den@valinux.co.jp/
v1: https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
    +
    https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/


Thanks for reviewing.

Many thanks to Frank and Niklas for the continued review and
constructive feedback throughout the development of this series.


Koichiro Den (9):
  PCI: endpoint: Describe reserved subregions within BARs
  PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl window
  PCI: endpoint: Add auxiliary resource query API
  PCI: dwc: Record integrated eDMA register window
  PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource
    API
  PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new
    backends
  PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
  PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
  PCI: endpoint: pci-ep-msi: Add embedded eDMA doorbell fallback

 .../pci/controller/dwc/pcie-designware-ep.c   | 151 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  15 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |  87 ++++++----
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  61 ++++++-
 drivers/pci/endpoint/pci-ep-msi.c             | 146 +++++++++++++++--
 drivers/pci/endpoint/pci-epc-core.c           |  41 +++++
 include/linux/pci-epc.h                       |  80 ++++++++++
 include/linux/pci-epf.h                       |  23 ++-
 10 files changed, 562 insertions(+), 48 deletions(-)

-- 
2.51.0

