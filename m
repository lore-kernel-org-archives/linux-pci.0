Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793372876;
	b=u7oBHhxxJeJXTsu0mmzcPBs0igCIc+/03leA53scTAWaEkQ60lnu/IAGtkjjYch14BhC
	 7mZWdDDpLVGN61bGHXwYqdsv29HIUygKbfoiGaK7oNgbL6b+aaTtrMs7tlcuVicdnHkzR
	 4W2uD8tFhSi/CaRkQEtSAnk5dDkj0AJEZ4Rj1L/bO+xvpUdwi2uupznEXZ+0yohx1OIjX
	 tUwxBYBGVmt7MWHkSKknq9w0TAxgj2cmI9WOXbNgkLWq7R41c1EZN+tqzbY0S6+tI8Lr6
	 M3DHoywyZOtzQUsTOZ4NkZo1KhiQaKZicVeQfVihclvvuYpMo78Bp2A/xti4+fe0aeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372876;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RS8qy4+OXoeUn9klC7eKD2CIDUj8evUUSkKbDJpW6tM=;
	b=acYyUJO5X0PDKjeC9P2tgKhwbnjMwPLXtZwZQffPtCkpgnbobxsXgj3skAfsYw09SSK+
	 iV6+mn9+R7dzNE/SPhCFCK1mrey4WbRKrlFJpaiintARKI/m5lXpXZHN9Vb4aoa4QZW+y
	 jfTAwOu3t4dtB8H4olcN13Eibe9eBUN2jDtGqrSOKUITaFrRbkoWwLg1aXfLtsF31lwh4
	 F/r618olc3xm8cMUt8QdJMdbYQDsPzEnMe/Y9uVrSTDvK6bIbEj7F4wvQb0kpxwywWBC5
	 VaEyQS29LuepAz6CuCtcAbB+OFc7kzDHMT4NHb4EfXJMpAdIfq6/9ZNoPqRFSXAEEHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=uQhxyJN0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.82
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020082.outbound.protection.outlook.com [52.101.229.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FAC606A325;
	Fri, 30 Oct 2026 15:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2FAC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=uQhxyJN0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnQX57VvUHD7n2+iZmLmoDmX64iUR0DoNMVJAf0dYUQt7BUozoJDU71T8JfTbl6fQal42Wu0QoQqvO6bq5zEwygce5wVKe2Jsbsr2DA94LRL6eX/HAc+EfeMHclcCuNxFsl8lFaRbvAdzqPJ8w3oZmoaXVfDD/Lylf48zegtWNnl3KdyAXwba5FOPu+cdKeuZToNDPIlkszDARaDKG5dz4IRSD1GMoooMaiqW/1T7eJPHf73Yj21q2bfAJ0fUk2YRGHwyNp2XhU8wn9u83j7fAPNArun0Y0ehxmGUBTp4v3YJEQZNVwZZeX/mPFD7x5aF/fTdWXS1T0t6TVia01/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS8qy4+OXoeUn9klC7eKD2CIDUj8evUUSkKbDJpW6tM=;
 b=TQ4kM3ASsfkHtWEaRdL+nmtWemH08Vj1AlfOyZ7t2cnb5bucHGPpciny+FSSLPohXaOfknI5qpJ5Vy5C+RYwmfEMtXEwfuw90THMt1eW5VoN7nBHUMXIj3RK+CoTKp9bFZYCo7zKIFu/d2o63KOCDrJJlh/psF9ErcIpfVTCypwtJmZ0chTbNkD3W42sEVeEUMEn38WETSqP2cZ1UcUy2unW6jGxRa5dnurvz/0Twpl3lU83D9SanMc/jK5uSNdhc/Ef5yqz9c6cKpGqyoW6iIIbRYDcFtZj5e91vgNYohe/+76a+uithOPswxwBGEeRr+GpSQT0++8n3WWhQ8NYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS8qy4+OXoeUn9klC7eKD2CIDUj8evUUSkKbDJpW6tM=;
 b=uQhxyJN0kwZHzKu//XkufSBYCemarVRJoXAwm2XAOhzjcdieJChdL69XnAwG15jJ+Jz+nPpuy5nSP9MJgJhyZrcOHZF+jUB1TB0F7yllTAvUA6OKn/n/ESLfTGUbblha9bj/NwC1GhqyYRnFAKTD5RCLBsS7MH2EMBncqwLU2E4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB2389.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 15:07:50 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 15:07:50 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devverma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v6 0/5] dmaengine: dw-edma: Support dynamic LL appends
Date: Sat, 31 Oct 2026 00:07:37 +0900
Message-ID: <20261030150742.2586776-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0038.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB2389:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d6d89d-f728-4ef8-ecee-08df36979097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|56012099006|261009223027099003|261026140227099003|261026135527099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	5fybIyM+xXarokJWkl8uilEsGNdrCFGjqIZMwe/MbbfklvDths5WQZOOZOP/Lu/dCz6wDz7K8OzoNIdOuTKFRsGaBXPbnzvTDRpBbzqEYo2N+KA6Fqe+JAGlzerRiGgu1wD7tK2mjpG49L/ynBygIHULicLgJndd1SbhsHo64Z5npqAQhLCPHt/hW4c+pGAqjl4Jc8qKf5Zlz4ifj7BFUXMxaxUxUf4l4sTTLn2pIEfDP/F+pUk4NnAzUmnqd96T1BCheT/AxvogyEhEvvAcK6kbNTNuaiDKwY/OBRel7snzcRQ+t9N/rrGnHaVYbyg6G9tgIoyZHdNL8YQ9OO/rXeO5U7psczw/QQdMO0Ovp7hrTHsbvMcT5zqdvJIEcBoCBOsqjwdcDjUYYlUcp15ItKzXsDibmcGORa5B2vrIjqJAUNmCyfKpR0KZ5TR+/bOzYL4702d3PmEIdEVp7i/O3nYfbpr8zMyGgNuaMqDWwyw5stM+x1GEQQKyjk4xmo7E+MKdMX2CA3awTwIIjpCZsC37sw4Igj0bUqoqY1A/RtRMVZwJOpLDFIJ/0esaOujAaXo47AfbFiuU7CGfDVVrn/iJAZZ7a6Lz/VJYx6V0OcNXYMNfHrXtMLU2V461Iyhz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(261009223027099003)(261026140227099003)(261026135527099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TTaLFofjs2XTteYYrp7te86PpPGYgD9acbgADFFD5VTNFpTjjJTDkaBulI52?=
 =?us-ascii?Q?1ctmWsvgn1bZk+sueTXWACGgiGGIfJwxCGvh4MWMqL47BVsq3jwXbIxa/6At?=
 =?us-ascii?Q?PWMgiJMZqx7+pI8ql+GIbJskb28oB3cj5XxIBPDLaaIn1FKNC6h7QlzVclzu?=
 =?us-ascii?Q?SkwMYq3ppUDtlYo0QAbTKV+JBocy3HAsKpdSkCRlPJdISlxYSlM4Arsls+kf?=
 =?us-ascii?Q?bRl8ycK+kKd4tUfBBKWDZbLneJL9Eu6hznl7jGkJ8AQWE/8F0/Tw45P7nIcL?=
 =?us-ascii?Q?T+xdvQaUs02YC341vigwatUxaeEHBlk9uZg2GMgwFhI1j4hVvqY50jKHV+xM?=
 =?us-ascii?Q?m0ginyEwugrGGC6Y8tx1/TvclZfBjmSJJ9E2czyJTfhZewbiZclLlp8+fBLm?=
 =?us-ascii?Q?AYH/oM2mE8/nJEadwp/dOKTpzz+znNs3t1UufeDKynu7bJakddUechDCFfCi?=
 =?us-ascii?Q?eES8YbkAVIqv6HR2Yzqlemg4BBuq/tX+qDSvl4WunxYp5yNxWm/oSTxPtJkg?=
 =?us-ascii?Q?VfUMxW0Ijlo8m7BfKBhMOQTDVnV0WSNZ1vt7iSde3Ti5w+4n3z05Pk8Ex+R8?=
 =?us-ascii?Q?7CxcJcm1PvLoZp4U8RfDKivlgVWuoTPhrPp01xAc51z9JYCJ3dhZcRr+t/SE?=
 =?us-ascii?Q?0IXldirPWLnFYD6ZQ0sbwTy+RRR9E3yPm1LUJc5C+EnoUi9fty5OHyFutyhC?=
 =?us-ascii?Q?eUWPU1nmmIjoniQiNCAI6x/QmyLpFDQsf1UUn3rc/dypem3zxNeal8KtFBK6?=
 =?us-ascii?Q?o0U5v+JEkRoekA1XhvNjX/MYnrTyddCNXFPayT0jSwrTEfNJx8+7qgv6wrE7?=
 =?us-ascii?Q?fVUWcWIIB8wrirywBbLD6cUt7OoiAJMBxOHaMHu/iTpuEmisjFo02AvxtJF/?=
 =?us-ascii?Q?v0FHqLvFhyo6M8bpPifDkZpiWpw+NbTXt94TyEO9SKZMB5mhFuNPSEU2sw0O?=
 =?us-ascii?Q?h0W6l1SGGrI4BHfHGg3fEVmO0wCa/oLcQ7LhAM7XJZ0yxcQE99NjFX0Pj1HX?=
 =?us-ascii?Q?yp/2fYPp/UjD7o9XCrEK2xRmofm2C1lHf/wYswyxfLpIXh7iNAEVbepMuO5p?=
 =?us-ascii?Q?q+bFfYtJCi1uXtD/kEeaYbq6Yf4q9c0MJ8Fn8oGNSfyvjoAL/WwxcN7suhBN?=
 =?us-ascii?Q?jgaoEuaJT58oKxOZaEX/8VA1w6Y/hD2vfqEitWLAa3ZP7ZFiNVgvAQ7mvPX9?=
 =?us-ascii?Q?YU3mrOxBLaYCJUk2dgU2kJd5E6dhbtCdSFNQ1PHxGbs8eHXaFLBfrzmuIiu3?=
 =?us-ascii?Q?FvxrIUcYdr/WmitPE3q0oRqyY6a7wcMY8QJGK7fxHbNi0tesZcy0Tu+Ze9fK?=
 =?us-ascii?Q?MHN02nqPOjSb+Vn51z1VBNj/0I6p7wTDVO2BT7nfs/V8rntaCejE6G56fUnK?=
 =?us-ascii?Q?ImSdnzWKhDPi/3LfUk0y5BNN7wtbZGeCoEGZvw0fA+nDZRiqWjPuxJTE/1zi?=
 =?us-ascii?Q?/c0owAZWS8cMfb+pfBZ+a3b3BWPuCOvdTnSN5E/sr70o5lNlWx9ZQhpc1N+c?=
 =?us-ascii?Q?LAAfKDyn+vX4q9RJn2RlohHIClfYElCtJznsROKYD80otpAIW4nT5CwN4Tgx?=
 =?us-ascii?Q?ZXx9PTpnsR7+bwxnVKyhnm9O39ymtrK6beagTX+ImEM8LlnBUflDF1TQk1Ln?=
 =?us-ascii?Q?QxBaoEYVqw2lcWNbdn0+VrbZCFAn4wplSeBAiG2OxriQ5a5LuFMzPCGDKH1+?=
 =?us-ascii?Q?obb6hgVy0peQ5inMDhVQ8Um7evfHW0ZM1fVF48n9LCgrJ/9ya8j30tudjY+M?=
 =?us-ascii?Q?5WKQ8kA+BZWai9/0gwmRhRwoaEjT6M8BiJBCBD61DITBubTLe0JM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d6d89d-f728-4ef8-ecee-08df36979097
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:07:50.5555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4a4xUcV8jmDybzrJgF26+CH+90xYsXaWPvptvBUHmEkCrk1dpFRA32TlS+Kq/GFYf7ajTgrshNxbc7KTJV/cvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2389

Hi,

This series lets dw-edma append requests to a running circular linked
list (LL) using PCS-CCS-CB-TCB Producer-Consumer Synchronization. This
reduces stop/start cycles between descriptors.

The work started with Frank's RFT:
https://lore.kernel.org/r/20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com/

v6 throws away most of v5. v5 included recovery code for stalls seen on
R-Car S4 (DWC IP 5.20a). v6 drops that recovery code and the defensive
doorbell handling built around it. The S4 stalls are still under
investigation [1]. I have not seen the same fatal stall on RK3588 (DWC
IP 5.60a) and SpacemiT K3 (DWC IP 6.30a, native HDMA), either with
nvmet-pci-epf or with the out-of-tree NTB transport described below.

Note for maintainers: the prep work [2], which has already landed, added
the ll_irq_clear core operation. v6 does not use it. If the v6 approach is
acceptable, I will remove it in a follow-up.

Frank, thanks for your review so far. v6 is close to your RFT and my v1
again, but keeps what the v2-v5 reviews established (e.g.
running-boundary accounting, STOP/PAUSE draining, HDMA watermarks).

Based on dmaengine-7.4-rc1 (aff5e6a77fc6).


v6 Testing
==========

I used three setups for testing:

  Id   Endpoint                  Link       Host
  ---  ------------------------  ---------  -----------------
  (A)  RK3588 ROCK 5B            Gen3 x4    CIX Sky1 Orion O6
  (B)  SpacemiT K3 [3] Pico-ITX  Gen3 x4    CIX Sky1 Orion O6
  (C)  R-Car S4 Spider           Gen4 x2    R-Car S4 Spider

1. pci-epf-test:

   For all (A)~(C), same PASS/FAIL/SKIP set with and without this series.

2. nvmet-pci-epf:

   I ran fio on the host against a null_blk target, using the same 26
   cases as in v5. Each setup was tested five times without the series
   (base) and five times with it (new), alternating as
   base1->new1->base2->new2->...->base5->new5. The table shows median
   throughput in MiB/s.

                           (A) RK3588       (B) K3           (C) R-Car S4
                           (5.60a eDMA)     (6.30a HDMA)     (5.20a eDMA)
   ----------------------  ---------------  ---------------  --------------
   rand read     4K q1       34->  28 -17%    54->  42 -21%   9.9-> 8.2 -18%
   rand read     4K q32     180-> 173  -4%   147-> 150  +2%    46->  52 +14%
   rand read     4K q32/4   183-> 176  -4%   143-> 151  +6%    53->  57  +7%
   rand read   128K q1      610-> 765 +25%   933-> 851  -9%   146-> 139  -5%
   rand read   128K q32      80->1139  x14  1121->1480 +32%   591-> 812 +37%
   rand read   128K q32/4    47->1246  x27  1752->2235 +28%  1030->1160 +13%
   rand read   512K q1     1002->1043  +4%  1266->1180  -7%   135-> 176 +30%
   rand read   512K q32      54->1371  x25  1730->2131 +23%   940->1101 +17%
   rand read   512K q32/4    47->1122  x24  1808->2367 +31%  1097->1178  +7%
   rand write    4K q1       37->  24 -35%    56->  35 -38%   8.1-> 6.8 -16%
   rand write    4K q32      73-> 153 x2.1   117-> 216 +85%    37->  42 +12%
   rand write    4K q32/4    71-> 154 x2.2   117-> 214 +83%    40->  53 +32%
   rand write  128K q1      480-> 498  +4%   768-> 634 -17%   111->  97 -13%
   rand write  128K q32     900->1312 +46%  1686->1908 +13%   469-> 632 +35%
   rand write  128K q32/4   899->1292 +44%  1681->1900 +13%   601-> 776 +29%
   seq read    128K q1      617-> 784 +27%   832-> 822  -1%   169-> 128 -24%
   seq read    128K q32      71->1163  x16  1131->1499 +33%   600-> 811 +35%
   seq read    512K q1      987->1054  +7%  1294->1229  -5%   138-> 178 +29%
   seq read    512K q32      56->1535  x27  1726->2140 +24%   930->1080 +16%
   seq read      1M q32      47->1232  x26  1792->2324 +30%  1071->1180 +10%
   seq write   128K q1      471-> 488  +4%   789-> 698 -12%   117-> 102 -13%
   seq write   128K q32     883->1312 +49%  1674->1903 +14%   477-> 646 +35%
   seq write   512K q1      567-> 722 +27%   242-> 321 +33%   113-> 156 +38%
   seq write   512K q32     881->1305 +48%  1701->1901 +12%   597-> 784 +31%
   seq write     1M q32     843->1206 +43%  1685->1902 +13%   592-> 780 +32%
   rw read    4K-1M q8/4    175-> 552 x3.2   529-> 712 +35%   363-> 433 +19%
   rw write   4K-1M q8/4    179-> 553 x3.1   529-> 714 +35%   364-> 433 +19%
   ("/4" in "q32/4" means 4 jobs.)

   More briefly, geometric mean of the new/base ratios across all runs
   in each group (5 runs x N cases):

                      (A) RK3588    (B) K3      (C) S4
     ---------------  ----------  ----------  ----------
     QD32 (16 cases)       x4.59        +32%        +58%
     QD1   (9 cases)         +3%         -5%        +23%
     rw q8 (2 cases)       x3.08        +44%        +47%

     Note for (C):
     - S4 showed substantial run-to-run variation, particularly in
       base2 and base3. This raises the all-run ratios relative to the
       ratios of per-case medians. The cause is unknown.

     Note for (A) and (C):
     - commit efadda401c5c ("PCI: dwc: Set DMA_BYPASS bit in outbound
       IATU CTRL2 register"), which is not in dmaengine-7.4-rc1, was
       applied to both the base and the new kernels. Without it:
       - (A) often hit NVMe I/O timeouts in the 4K q32 write cases with
         the series applied. fio still exits successfully and the
         numbers look plausible, so this is easy to miss unless you
         check dmesg.
       - (C) was unstable in general.
       Test 3 below used next-20261022, which includes efadda401c5c.

3. Stress tests with an out-of-tree direct-DMA NTB transport

   This is for reference only. These results use an out-of-tree NTB
   transport, based on next-20261022.

   (A).
     - No stalls observed with various workloads.
     - EP-to-RC ntb_netdev traffic reached about 25~26 Gbps,
       with no CPU reaching 100% utilization.

   (B).
     - No stalls observed with various workloads.
     - EP-to-RC ntb_netdev traffic reached about 28~29 Gbps,
       with no CPU reaching 100% utilization.

   (C).
     - Can reach 18~19 Gbps, but the stall can be observed and is still
       under investigation [1].

[1] https://lore.kernel.org/r/tkyu5rsxfa7i6rxxw6qxmmwke5qnlxptwx4j2s24fhftsmmf26@gamef2ec4wwm/
[2] https://lore.kernel.org/r/20260820173439.2004068-1-den@valinux.co.jp/
[3] Based on Ubuntu-riscv-7.3.0-9.9.1 + some other out-of-tree patches,
    especially to make EP mode work on K3.


Best regards,
Koichiro Den
---
v5->v6 changes:
  - Drop the recovery code and the defensive doorbell handling added for
    the R-Car S4 stall: IRQ-paired LLP snapshots and event
    serialization, the delayed stopped-channel recheck, tx_status()
    reclaim, the LL interrupt placement policy, engine reset and stall
    recovery. Empirically, the stall so far reproduces only on S4 (5.20a
    (GA)) with out-of-tree direct-DMA NTB transport.
  - Read progress in the deferred handler instead. A channel counts as
    stopped when its status is STOPPED and the transfer size is zero, on
    both eDMA and native HDMA.
  - Fold the STOP/PAUSE drain into the progress handler.
  - Rebase on the circular LL groundwork in dmaengine-7.4-rc1. 14
    patches -> 5. Each patch notes its v5 origin after "---".

For earlier changes and hardware observations, see v5:
https://lore.kernel.org/r/20260812155721.2807506-1-den@valinux.co.jp/


Frank Li (2):
  dmaengine: dw-edma: Dynamically append requests while running
  dmaengine: dw-edma: Add trace support

Koichiro Den (3):
  dmaengine: dw-edma: Add a channel transfer size operation
  dmaengine: dw-edma: Reclaim LL entries from hardware progress
  dmaengine: dw-edma: Use HDMA watermark interrupts as LL progress

 drivers/dma/dw-edma/Makefile          |   2 +
 drivers/dma/dw-edma/dw-edma-core.c    | 216 ++++++++++++++++++++++----
 drivers/dma/dw-edma/dw-edma-core.h    |   8 +
 drivers/dma/dw-edma/dw-edma-trace.c   |   4 +
 drivers/dma/dw-edma/dw-edma-trace.h   | 117 ++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c |   6 +
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  71 +++++++--
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |   1 +
 8 files changed, 383 insertions(+), 42 deletions(-)
 create mode 100644 drivers/dma/dw-edma/dw-edma-trace.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-trace.h


base-commit: aff5e6a77fc69a7c490246465940d18422d7c631
-- 
2.54.0

