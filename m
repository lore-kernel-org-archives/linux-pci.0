Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808758;
	b=Vsv8JjDCCiZ3KZYMkeKADWMaiFK4YVuCQ3JoBsqg/9Wwjm4ioS4KJZXb59wAPlYleIju
	 lrNSxeKdT6eVLk5wR9+5fn4Eg5DoSstfwOKDL8WVVrb5pYJQ7SrnVwiPHqDQl3PvD4NB5
	 HaMk4tBs7GDnX2TqTKQ+CSjNGdBaZNPd611qIU/JfNg5JblQfusoR0vueRxyZSD8uDJHg
	 +YrP6DKPzLe8Br4tg27r8ofpyfoMSiDsgeySje+0jp2TnoyT9qwVritCFV70yNb6bF9sk
	 /nWi7yVwa3aV/BTwRY747fnfK+E1brqOMLcHbLhxyntJPjHw2aiz/zCEy+WLxChupjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808758;
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
	bh=dgN0Czi5m/bTLVG170SJU2RYs+iMXkfsEaEaRfcQuZ4=;
	b=AQ+2fdQfooBG/eoV6+TO9hKwOdzkcfqD+gUmR/72KuPXJhC95IlYUhg7wI1sRG7lV6TN
	 GaiDDWnwfMYNmcxoDVIPBkFiE+KRoGv1zTg8g+soWpFx4S+Q5516KV9b5cLJc6hNuzd3x
	 2Hy0eRSXHgctYPNNTPuUC+AvPDJLydhqLSi0ndf7R+qbK2LDwaotUw8GtoOg6hMjyAA0q
	 zWgq/ydnfhadvdI9M0tTafAxZy/d1yDTJjivv36vx0KkLwXS/pRgMobmW1LLaU0e1c9SU
	 9zK9f7+S70u1mTQ4YFSJ3h23aHJMNOvn/tfa2gZ3mjNjqmBE8XlUeqbNozdNhzPEINA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ULfo7udZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.123
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021123.outbound.protection.outlook.com [40.107.74.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD57D606A332;
	Wed,  4 Nov 2026 16:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD57D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ULfo7udZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONCEdTstmiIPTtg+TMzqxKVEso8KNbs3TBhvDUjXVZpWZ0iPToXB861bfDfeUP3rzhf4+b7nL/rCLkL7iOn0Qoiz0UdOs8W1fIF9ja5iJdRhLeLlYZ5ObRX8BgjOVZQOBu0HBa+R1FzaDsDo/AzBc6lEDAjTXgweqYMyvXRizCIdrqscGaNK2vc4cCrK4U8pH3iHpFRLROBdKQtHM3d4d5wL9bvsKL/QG089gkSh7NSD8SlZMFTWT+gPRmltiIbJ7E9Dm+x5Sp4D6ZxDcNriwBbjmWLcSs3SwXiJ+Xl4HnGLcqp6efwfLNdNoQHsDAxs9d0df3PZ8nRXJR1b7yS8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgN0Czi5m/bTLVG170SJU2RYs+iMXkfsEaEaRfcQuZ4=;
 b=e5294bkTDyQN3ejb5yKrNMdCA7s2eUGscyajX4fDaU/2zajM5doHPGenMYpzrJtBePw01/XVue6xWPwzqdoMYyG2bAxtGXqBJAOMk32nPyV1iPptU9HBP8eAjjM4RlKt8jyBoxWeeUbzXdR0rovrXYTGl07mM9/CxJ6rPJTwaxDnrzqhmtYsWer+YZagq5OPj9nptVvbUNzf4o1DbntXJxwsuiibEC3UyJwt5WuZIo9PXxgCUAlqxSwR95Yp9YdiI8uUa3gxmQTU+0+m7IYadlpcPuCIEseF70LtZB6vPvRAG5Q54+72yVpukVkQ9BbSYFzUSBGkQYn42Vo/zmRZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgN0Czi5m/bTLVG170SJU2RYs+iMXkfsEaEaRfcQuZ4=;
 b=ULfo7udZyxZyFSJr8a5cIHBdYIscEq8tPf4A30GnJzos93VaU4pKSQx/j1hTyCpp6C4LRd4/K/jV62ctLHDjMbJOBw1NsMNCNWvN+jYkRHpEXJ09i5A3hTx3n6G8/ra/K/pcJETNIcjTDmp3CIogSgtZknUeeSX3z8Zx62mzu6o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6678.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:417::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:12:33 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:12:33 +0000
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
Subject: [PATCH v7 0/7] dmaengine: dw-edma: Support dynamic LL appends
Date: Thu,  5 Nov 2026 01:12:20 +0900
Message-ID: <20261104161227.1742005-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0180.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d8e35e-7576-4f06-13f7-08df3a8e6f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|1800799024|366016|261022105027099003|56012099006|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261102123227099003|261026135527099003|261028144727099003|261026121527099003|261026140227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	cFeB31waWiNgbCstKm0pdxaiE9VkwRxkPt7drcijp0cjgm/g8mjcqORdulNyfJmVASQLWkvwdBAV8AJVxevhJ++kyaYr9/RQpKfsHJ+iwPCWdifvzcgarqSoudOZz3YjPS5ffkZq0gicM4aWkkdNaHNBsS84Kf39Jxy9I9dHF6b8LEfsGNs3vRm+w3KYBMjiM5KSGy/WgLdLj6VbEYNvvx5+11htRxjJWdAukYBWmngqwghaLId7f1PztUinyuU/6zgwZbvem4VimIu+R77Q0Ymg/jWxc/62U6p1hsttdXIav/6VNqN3yzG/u/eK+QmvGLSBmN7zfus8dcQvWSH/LF14Ub+DGswiRqJLlqNp7ya7nj22pf/e7RQkOjefaakOL2P5+P6VZha0VrjM8DdvYHRS6/22XRMfPv3zsItwHhc0kaBI5z6+foRipVOifYzin9VXYRGO1FAelf7qQuMIVUZRO/qL/SBSiyvU2mH83wcpxqo7U0jLYr32vF/OlX5xZJRL776Mbcp/i96/uKdgG4MujwP4rxsQCCDSHxQSqH+4eYq/oUDpZF9XezyIX79FTCFCuAxRWPusfb+BbFcJcE8FAxjhAmXKMpUBC1OHxSPcFJD/OJxjAf/SKzaUzN3K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(1800799024)(366016)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026135527099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GzkiOFlkFwcGp8H9cxoa6+4xWs+YnK3Co6qIV+Rlwhou2jTqtcwXRzIyUelj?=
 =?us-ascii?Q?3fVVN11Tkm549l4bWjb9jXatxXmsyHw2SjiClX+t89a3RNWv2tVUsuEFNk/P?=
 =?us-ascii?Q?RntyI5m/3DiTny8ODUNHlD7ITx5xKPCXCbhmhhPE+fBEgC+kQ+hsesnvjaj8?=
 =?us-ascii?Q?6MeLXG60HBSkADiip2NZIWZkys5A5BDw6kIBqaHknmNh9w1X+9VMLmx8S+Fc?=
 =?us-ascii?Q?v6G6Teuv0Ia9zkzfprSekckriyDnUp8HATscmDO12h12jRaBm9PbOZiEP+TT?=
 =?us-ascii?Q?TSId7wx1EiDiHQ4qecnnM2lmCZAU8L6J60Jw0uYzVwXr/2xOf7g99tPbbGM0?=
 =?us-ascii?Q?ylKDMAlfoELXsJGLjAS6Sl3WFuUFvenb13F3qaj2d/FeWl5EfJoBlCxrcb+l?=
 =?us-ascii?Q?6oY/oyemEm8VyRg4PKZsniYe+es571M6U8Z5ugE4jj3+qgsuRHaocztk2x8Z?=
 =?us-ascii?Q?IeedGZPNLBGgRoc/zXH10BykFaAZB43WVjaYwFq9qGA8K3+9UaEfBGGajDGh?=
 =?us-ascii?Q?YizQ29Qvqq7Tdgrb/dT6ZFRpCXLcub3RXgqIz85xBbTpu0KZtYv8blZ8uM0F?=
 =?us-ascii?Q?QjCyXKR0MI3KjHrszRKHmTy6h0xGnvYy/wkkKBp2gWoSTVl4giAsmsnomf0u?=
 =?us-ascii?Q?4RVmdT2VrNShlGr3ZxzD5+Ruaa/BQh92MxX5jPBAfA+XDmZiT0Fui/D7wpKn?=
 =?us-ascii?Q?bgClqGJmOyxmtc4zvMzG9sKT0twoQDZgFnCY7avX1/kVvbMQUqFRBaUx0duP?=
 =?us-ascii?Q?Qy+MMk9fxG/5lv5BXporDPdqCkcJkTn8kEOBUae1VCwv6262E9Hxz96YmiXF?=
 =?us-ascii?Q?zq9MScZyxkDyqyQ1BmhoMVRfboBe1KPzyvSZEPYb4CR23K1uxyJUsTKpO9iY?=
 =?us-ascii?Q?cA2WtHeBs6/IMqOZhmzvcS6BOILUq5IS1HIeH2iG3NFhmhIquOfTMYJSs64t?=
 =?us-ascii?Q?yV/9rG9ULd7HlHQ/MTd02CDinGWhB4zm5sFoh3LCL/imoRAJNVytyFVA0+cb?=
 =?us-ascii?Q?RNizgY4Szi6Z16k8pEmstpoOIQaNduoWYVZowRVANZChVkIwIhlKbo7VY/mg?=
 =?us-ascii?Q?6+gckj8ezSPfGcxkOylnREghYqTHY2qapdoCwQmlnrumb5uKOwWJfRwEmrzh?=
 =?us-ascii?Q?qbCqMg+NG3p71WFSTUsWpxTyHuo5Og0mvHH4e4gVHMEfcKzHkBEueYGGvJiO?=
 =?us-ascii?Q?2htgva8aNxYfE6PIoHa6YI5i7MtjXUo3BgBezkzlMSoR2Nuj49gBxW4zm5Qd?=
 =?us-ascii?Q?QBShGdhmpaTXpDYcjPGp4r+aEjz53ry9ZmrheBuilBOEetLay9NTsKaayJnX?=
 =?us-ascii?Q?HFwrXdZy3YszqTI9GbBqUJbf34K/L3FjjqdLn+MD3zwYv2wOFUVbx6VdbrAD?=
 =?us-ascii?Q?p73eDRHPfBp3K0OANrfsGOC/syGg5jEXudoJ70hX+zpv2e+yQuUeTjSLBexO?=
 =?us-ascii?Q?P7SJFSN0on+gJLILt0ydL4Sqtem8S8CZifpqjK75NnbhdaQhg4LziHfR1Vdx?=
 =?us-ascii?Q?cGOMVHuKE25lmv+WlXki4w/2ptESKIZuFvAHtUW9SbTpbTsTJjjCgRDSp5Ik?=
 =?us-ascii?Q?eVjNdmeQEl1bCglEce9qFtwu9vHe6DYXElI1U/3vz5qIOv9C9T/2EepNK02J?=
 =?us-ascii?Q?sGl05tk/Cgr44GaUEW2eLUOSIlKzNYg6D76xi4XF0ZsJoBUDysiHHW6vgPz7?=
 =?us-ascii?Q?yBxKMp7GlSfI/+FKUbJ8d5jImwsN6s48/lXOQPlS0YdTzC0JsmzlDHAYtar4?=
 =?us-ascii?Q?UYx/dklRokYrkj9XXhrkYehO3w2IXuh447mkxKZqfuMMs0APwD1r?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d8e35e-7576-4f06-13f7-08df3a8e6f0d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:12:33.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVbhDCKVw47SrFOqomAkdIDSPtAWbWy6OYfE/IqNfhK6z8roIFrkKGXJOoMnF/ScSIlqz8mxHDWgUl7Fa8RUGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6678

Hi,

This series lets dw-edma append requests to a running circular linked
list (LL) using PCS-CCS-CB-TCB Producer-Consumer Synchronization. This
reduces stop/start cycles between descriptors.

v7 addresses feedback from Frank and Sashiko on v6, plus termination
bugs found by testing terminate and pause/resume under DMA load.

Based on dmaengine-7.4-rc1 (aff5e6a77fc6).


v7 (Re-)testing
===============

I used three setups for testing:

  Id   Endpoint                  Link       Host
  ---  ------------------------  ---------  -----------------
  (A)  RK3588 ROCK 5B            Gen3 x4    CIX Sky1 Orion O6
  (B)  SpacemiT K3 [1] Pico-ITX  Gen3 x4    CIX Sky1 Orion O6
  (C)  R-Car S4 Spider           Gen4 x2    R-Car S4 Spider

1. pci-epf-test:

   For all (A)~(C), same PASS/FAIL/SKIP set with and without this series.

2. nvmet-pci-epf:

   I ran fio on the host against a null_blk target, with runtime=30s,
   ramp_time=5s. Each setup was tested five times without the series
   (base) and five times with it (new), alternating as
   base1->new1->base2->new2->...->base5->new5. The table shows median
   throughput in MiB/s.

                           (A) RK3588       (B) K3           (C) R-Car S4
                           (5.60a eDMA)     (6.30a HDMA)     (5.20a eDMA)
   ----------------------  ---------------  ---------------  --------------
   rand read     4K q1       38->  29 -24%    49->  56 +15%   9.2-> 7.7 -16%
   rand read     4K q32     169-> 166  -2%   144-> 145  +1%    17->  19 +16%
   rand read     4K q32/4   172-> 169  -2%   145-> 151  +4%    19->  26 +33%
   rand read   128K q1      703-> 814 +16%   833-> 877  +5%   140-> 131  -6%
   rand read   128K q32      74->1009  x14  1130->1496 +32%   303-> 391 +29%
   rand read   128K q32/4    55-> 879  x16  1773->2251 +27%   431-> 749 +74%
   rand read   512K q1      996->1097 +10%  1313->1202  -8%   138-> 141  +2%
   rand read   512K q32      57-> 950  x17  1758->2094 +19%   372-> 735 +98%
   rand read   512K q32/4    44-> 751  x17  1821->2326 +28%   343-> 766 x2.2
   rand write    4K q1       28->  29  +4%    55->  50 -10%   1.9-> 2.8 +41%
   rand write    4K q32      74->  72  -2%   119-> 212 +78%    13->  19 +44%
   rand write    4K q32/4    71-> 169 x2.4   118-> 211 +79%    16->  26 +64%
   rand write  128K q1      480-> 475  -1%   751-> 810  +8%    48->  55 +15%
   rand write  128K q32     881->1326 +51%  1708->1892 +11%   290-> 525 +81%
   rand write  128K q32/4   888->1306 +47%  1699->1902 +12%   314-> 756 x2.4
   seq read    128K q1      796-> 693 -13%   826-> 767  -7%   147-> 132 -10%
   seq read    128K q32      68->1064  x16  1141->1509 +32%   310-> 393 +27%
   seq read    512K q1     1063->1131  +6%  1268->1212  -4%   136-> 145  +7%
   seq read    512K q32      59-> 953  x16  1757->2126 +21%   379-> 679 +79%
   seq read      1M q32      44-> 742  x17  1819->2305 +27%   384-> 712 +85%
   seq write   128K q1      493-> 464  -6%   821-> 858  +5%    50->  45  -8%
   seq write   128K q32     886->1328 +50%  1704->1898 +11%   300-> 540 +80%
   seq write   512K q1      567-> 737 +30%   243-> 255  +5%   109-> 132 +21%
   seq write   512K q32     868->1313 +51%  1705->1890 +11%   333-> 736 x2.2
   seq write     1M q32     832->1202 +44%  1703->1899 +12%   338-> 778 x2.3
   rw read    4K-1M q8/4    175-> 505 x2.9   542-> 706 +30%   186-> 345 +85%
   rw write   4K-1M q8/4    180-> 506 x2.8   545-> 708 +30%   190-> 348 +83%
   ("/4" in "q32/4" means 4 jobs.)

   More briefly, geometric mean of the new/base ratios across all runs
   in each group (5 runs x N cases):

                      (A) RK3588    (B) K3      (C) S4
     ---------------  ----------  ----------  ----------
     QD32 (16 cases)       x3.91      +12.0%      +50.2%
     QD1   (9 cases)       -2.5%       -2.5%       -6.6%
     rw q8 (2 cases)       x2.85      +24.4%      +52.0%

     Note for (A) and (C):
     - commit efadda401c5c ("PCI: dwc: Set DMA_BYPASS bit in outbound
       IATU CTRL2 register"), which is not in dmaengine-7.4-rc1, was
       applied to both the base and the new kernels. Without it:
       - (A) often hit NVMe I/O timeouts in the 4K q32 write cases with
         the series applied. fio still exits successfully and the
         numbers look plausible, so this is easy to miss unless you
         check dmesg.
       - (C) was unstable in general.

3. Terminate/pause test during dma load

   Following Sashiko's report:
   https://lore.kernel.org/r/rbkljnmrf4ctc7rj6qlwhvhemvzvxx6pdxjxsdc2bmicez56ms@bgshyuvsjuqh/

   On (A) and (B), I used a locally modified nvmet-pci-epf to
   periodically terminate DMA transfers or pause/resume the channels
   under fio load. Terminated transfers were retried. Baseline,
   terminate-only, pause/resume-only, combined and post-injection tests
   passed CRC32C write/readback verification against a memory-backed
   null_blk target.

   These tests exposed additional termination bugs, which are addressed
   in v7.

[1] Based on Ubuntu-riscv-7.3.0-9.9.1 + some other out-of-tree patches,
    especially to make EP mode work on K3.


Note
====

Much of the complexity in v1-v5 came from working around channel stalls
on R-Car S4 with the out-of-tree direct-DMA NTB transport. A channel
could remain stopped and ignore further doorbells without reporting an
error. I have not reproduced this particular behavior on other SoCs with
different DWC IP revisions, or with the in-tree DMA clients I tested on
S4. I have not obtained further information to explain it, so it remains
unresolved. More details:
https://lore.kernel.org/r/tkyu5rsxfa7i6rxxw6qxmmwke5qnlxptwx4j2s24fhftsmmf26@gamef2ec4wwm/

I substantially simplified the series since v6 because I was concerned
that keeping all those workarounds would make it too difficult to review
and leave it pending indefinitely. I continue investigating the S4
stalls separately, alongside the work to upstream the more demanding DMA
clients that expose them.


Best regards,
Koichiro Den
---
v6->v7 changes:
  - Avoid premature LL reset on stale STOPPED status during termination
    (new patch 2).
  - Factor out descriptor completion (new patch 3, Frank).
  - Handle STOP before LL reclamation to avoid scheduling callbacks
    (Sashiko).
  - Restart stopped LL channels to drain published entries during
    termination.
  - Use modulo arithmetic for the running LL boundary and add lockdep
    assertions (Frank).
  - Keep HDMA watermark interrupts masked for non-LL channels (Sashiko).
  - Use the dw_edma_ prefix for tracepoints and the event class
    (Sashiko).
  - Add Frank's Reviewed-by to patch 1.
  - Link to v6: https://lore.kernel.org/all/20261030150742.2586776-1-den@valinux.co.jp/

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
    patches -> 5.

For earlier changes and hardware observations, see v5:
https://lore.kernel.org/r/20260812155721.2807506-1-den@valinux.co.jp/


Frank Li (2):
  dmaengine: dw-edma: Dynamically append requests while running
  dmaengine: dw-edma: Add trace support

Koichiro Den (5):
  dmaengine: dw-edma: Add a channel transfer size operation
  dmaengine: dw-edma: Avoid resetting an LL on stale stopped status
  dmaengine: dw-edma: Factor out descriptor completion
  dmaengine: dw-edma: Reclaim LL entries from hardware progress
  dmaengine: dw-edma: Use HDMA watermark interrupts as LL progress

 drivers/dma/dw-edma/Makefile          |   2 +
 drivers/dma/dw-edma/dw-edma-core.c    | 257 ++++++++++++++++++++++----
 drivers/dma/dw-edma/dw-edma-core.h    |   8 +
 drivers/dma/dw-edma/dw-edma-trace.c   |   4 +
 drivers/dma/dw-edma/dw-edma-trace.h   | 117 ++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c |   6 +
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  68 +++++--
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |   1 +
 8 files changed, 413 insertions(+), 50 deletions(-)
 create mode 100644 drivers/dma/dw-edma/dw-edma-trace.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-trace.h


base-commit: aff5e6a77fc69a7c490246465940d18422d7c631
-- 
2.54.0

