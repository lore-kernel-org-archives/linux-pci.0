Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793964156;
	b=kBRmqmh68qA6o/E8bM1F2GDNho5eZgwyTfwV7x2WM7OT6velNBlF631c4QZTsWWiEtsM
	 WB4QTAqzb2yslWvzLZIOA3ysmc9XEW+FMGcP8FlCUWYzJpO51ab2Fp65tyDYUL5AuzzQY
	 A36wtgRw7TU+aTqKtYiqoYXluoo2ON0UYFVnLiMq1Yl1Opmss4zwbKY6hUhWeSIL71dbK
	 SwzSXaf2KXzRpCUawYrqyirI9d3iAMIlozKFdJzs/Yt8rvem8MUQz3icvvBNwkOgyxf5O
	 81srxw0vSm8yD5LuOp4AgQDDpRpjbkRwvy2PBDh0biW79ROSttQ06dGJy5I3EQByMCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964156;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=0WGKm/cviKjElrzmAt4X5ZtRO1sXDX79QXEkck1naa8=;
	b=ArVezNH0q/C63gDpNzAWKQRtvDn7vELZtmem8ezlIx0kTOOG/ciLa4GbWtjEIwmCeTzo
	 lT611Racs1puxDfPvFTBCmJdVgBxVRk8q8EYwldNDb+k3kWRMU2xhXZXhzyU6Ahy5W8jO
	 NEyaaOflGambnpjRwpRqXGBa9icq/oWqm3uIsSZGSSQi0y8DrEHRhnGkpL1RaCuqMt/Za
	 1Ub5QMHT6I1F+x7DjAwiN5HUQHyBcwuq9EcKOg9i6m5TOYyTGAEhM9f2sSm8wee1BUin3
	 78+5KcSNnU3SPxDmsDMkLXmud/l+9D9PVP788dT68dpmy4C0z00AhHSbCaTBIsU/3lQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fp3liL5A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.11
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFC2606A32C;
	Fri,  6 Nov 2026 11:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDFC2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fp3liL5A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoBdSdjCiobCXEJyW5CypQ7gwEPBFwrrWzunZaOk75EJr9fQ2XN3Mw0AeK14v8KaRt269MrrgANfynxWjcU2uBgVL0JxTA2g1iQKf4VURtxq1cUwCI880AogF782D2pz65dzR3pLen9S0aE9tpLUCEDLaE7PsREksbigUARcXjR+uzCOjLOX/MsHPmnsXeuLLiCv5cdWIGJyRKiSNprAWROj376psQG9Yhoj1uT9zzx8D7G62vWpmO6cYPUDWiMaStvBFin5flMwc2fZbseN0ipdwoXmbFu6rF5t993ptyJH5JuU2hTbMpr7tYVzRvuJ3ygWcPzPHm9mS0iSCmuwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WGKm/cviKjElrzmAt4X5ZtRO1sXDX79QXEkck1naa8=;
 b=q9Dvx6qxap62XWtOUJcsC2UfIMaItmOXJPLxNLPrpkJF46mWqHAOIFwXijhLFNnLdjyn0+8yD+g8k5Jyjf5XYTzqesqlNbwOGJb6brHcZbJ1mwY5EoYqEn5XhIEzZhgxnouA9JquSav+EPif6k/SbPPveupIUbP/A0kXoUFIOglIbDDResBbLkzyD3to9bdFK9WV6RqhSzi0lwRlmlGTTgpYomk7W3Yq+nh0NLz9wVCTIkMHm11Qd5FkJF55eh2xTS9PHjG0q2s19TqxKiAMSdqjPn5ckhMXSAPjfHeD75Uw4opg3C+niV1qf8SQ3qT73c2buFmnE8vy1LY3k88Pfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WGKm/cviKjElrzmAt4X5ZtRO1sXDX79QXEkck1naa8=;
 b=Fp3liL5AmPi70eWzo6msoeUVNafmwStnmhqcBmLnVR5qxKjtY7tYLjHiouAj7DKa6vLxR7GTppjJ3W/GD6kX410zJas/f/S6+RyndXq8gpQrV5uvO1Tt+XDqhBm2ZkawAAJae3RfPaPqxPjVVBIZnP5ldIHb3/GkCli1jljzCm/xWCWg6htmDL89vzHYF6XZSYbFM9d6NP5Y01pNnDCkKvat/eFgVZa7WiCTaLzcvg14S6YjzaqnhebI6SiiT4mNgS/2mAQE0+qjPWd42G64CYNDmmOskOXITAxMdZlGim6h0AwOhcjG4IMXRjZR5bnLL8yzuS3rJdmL/Xxwt8AU4w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 11:22:30 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 11:22:29 +0000
Date: Fri, 6 Nov 2026 19:22:25 +0800
From: Richard Cheng <icheng@nvidia.com>
To: bhelgaas@google.com, dave@stgolabs.net, jic23@kernel.org, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	benjamin.cheatham@amd.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, tglx@kernel.org, 
	wangruikang@iscas.ac.cn, vidyas@nvidia.com, lihaoxiang@isrc.iscas.ac.cn, 
	xiangzao@linux.alibaba.com, shawn.lin@rock-chips.com, alifm@linux.ibm.com, 
	18255117159@163.com
Subject: Re: [PATCH v2 0/2] PCI/CXL: Guard MMIO accesses during reset recovery
Message-ID: <au24TndoXU-5gSo7@MWDK4CY14F>
References: <20261106111829.55823-1-icheng@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106111829.55823-1-icheng@nvidia.com>
X-ClientProxiedBy: TP0P295CA0015.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee401df-6960-47ad-214a-08df3bf83e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|261021123027099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261009223027099003|261022075727099003|261026140227099003|261102123227099003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	V4dfU3NtOC9Lx2902DGnNPLDmBSiWhzAnmfZQ7o5dOLHXuQdJu8hUtdhSGaLd2+N0XRIv2o017Zjkl2Ml9m7YyMt2zA+tqffH+oblXgVS6MGQon+HoGZBQk79k5MC5y3sYSwNREjhHtgprhA//1TStTvYHAS+uSTYTGqoGkuD5phTPF7Ax+A2Z82OozL+x7AWGQc2tqX2hrqJX+x9enLwN9CkNVEFLbxbl3Wst03gxIb87qrvQhrhpLsnaCvierYzCNn0udGaHyE4UP0qkzAIFJJ2dR+OS5RQr/og+WNW/X9gMOMyZ59kF2xJ/rX6oodLzyFCRi6sC+bukgbwKLuEUOSZJY5yQg9bx3KfQUABqTopztKZlyuTPcUeT8m4Lse0rZyOY4oilIqZjs7JSr6jhbswuarJuLSkvUBD5l9NMpZRBsOkQ7+hO3WDQefXsEGEIz1tuvVpSNLQr7Fri3UoYJIxK62DVXQgRdf7Pboqno5XePzb7VyR58cx29lO5z34z0dx66JEzG9eGeCfhr72doCrlQipAoHDuLhiM2Kk/Y7hZiQZyfambDqhXWXblNIIT433kx2Sa7ki8Y8hDAsGCsT111Cu6JvFCvyxIZ3TBBLW+Ux+ENhSUifpyq3DZQWk/MswgtfqHstgs3bLqIEocF8I+OLSe+21KCniZAZ2O0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(261021123027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261009223027099003)(261022075727099003)(261026140227099003)(261102123227099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RadfVxTQUw8TEe3+JAsUhRc5HfsqBNdZaSaNDN/QLRAW4sR4Z/3iYPxT6VyD?=
 =?us-ascii?Q?I5kVd6jcMtEb0WoaXJ3OFHW4faGcm+Fhp6QUjWwfmD33C39paAssPjL3JUEE?=
 =?us-ascii?Q?M1M+M+UOLaIU9CGcR/FL2mJDXhEaE17hT6GePv4e0SPCBIw0w4dvKlc/xD8T?=
 =?us-ascii?Q?VRc4J29lEKjMsx0TxCXXWzO6ig48Ga4OyFIFlQKhtP5myXblLedYm/yT90Fn?=
 =?us-ascii?Q?yAcSv3lzog9RnzliO2z5gMXTFnMSeeimab1ErxQjmK8yT34dDcUKqPZSDopq?=
 =?us-ascii?Q?D/xuSTx1R/ypi+tEtd48kyzZCZhAoEnwcfzCf1HUBqxsWg4ZmLLbnFKJH/52?=
 =?us-ascii?Q?dDOHXgcJWyqsiI7DuG1V/w3m8rxccU4TJJXzcRG4ihLqD6byZuCYJFHkMtFx?=
 =?us-ascii?Q?DAunS2/xbaEltTLZjdgS+PuBfQ263x1HTawlnY/7l5Fseanwvy4SjzqWyOFP?=
 =?us-ascii?Q?b0yuRQQDct5X607Ao7k42J5Pa9uGptHhelQAUHi9BEDDjUL4x7Z8utkVWnKy?=
 =?us-ascii?Q?jC/oOKPH3wTdd56gLamIPxjo9+9Eg7c3TkzxAkzsZ/GVy6od8cTyLg/idC/e?=
 =?us-ascii?Q?FL+YI2MFOmYLxRBb6sC3Dx5frIKra9gr4H64hRYlMB99KhQC4HrKbYS2Z47t?=
 =?us-ascii?Q?9az2T/nNox1Yoltsj50vgo59E0NnFl29A+Pig645yCG3dt6piVHZq9/S3Zqt?=
 =?us-ascii?Q?WnRtv67OIqpODlxiKh2fWRWgCyAq/9RWLe03BjZWd8p+h5MPH2TEP0hMHIVr?=
 =?us-ascii?Q?RMkxpDn7jbZeX2wjatfYoVHd7T21IswJK4+jtfcDXUPaEzQ87xNzxt1lC9WF?=
 =?us-ascii?Q?lq5M+nF/gl2dwFOuJ9OZBthz1tEi9HlNNbOU/o7xpbnUMFLukXM37UA/85kx?=
 =?us-ascii?Q?gl/8hY9qXGgbWdff+DXSSdPuQqLiolEa0IihlfQJzmGynekNsTr5GIIsc5nz?=
 =?us-ascii?Q?0aAUnXea7ecucGEBNehWNV7uCdUjSyex8WquVsRry16NINYmNIuF4tNc1JN+?=
 =?us-ascii?Q?g7xl6jkWByXxqv6G3VtpgFaMvU2PmIFCTzTtT+whPCsMGLXo4nN1yJqKC4V5?=
 =?us-ascii?Q?N2DBpCJshNOIehhdzsPf8ii29QD8WR33MD82Jb+uKWTDnk1z87f5JtCkFHLP?=
 =?us-ascii?Q?qdVEsTJ1UhTOPw8gamaBUioNHJahlLZ66b4KHqOXaYe34yaVHNgzIwSU67f2?=
 =?us-ascii?Q?SmCfZ6VDEZOcGCM22/Vv04eOfqcplt5cZKhB7vw1zq5OCSLYddn4EaUHM0GC?=
 =?us-ascii?Q?h1NyJ1aAr7TwO7X5tR4O5dXdruD42gX4Xm9wu1c8/fhpNfaxfG4FRbTJ+FQY?=
 =?us-ascii?Q?rh0BEKmAdUtfGHp0tqv64uSIiQCw9KRaiAZde3ENudc7Tt8fu7llyDhSUr7O?=
 =?us-ascii?Q?yMYBwh9M0Oe86M9uI7pzRyw5dki6TvTlO1dKau0Lpn/JBk0UmN2VfXhZIVGT?=
 =?us-ascii?Q?HNAfYPFmH8F4D5ATX2METD5N6Bah90jrFMZTaTADSz7zuCPzjE2m+szdCb36?=
 =?us-ascii?Q?8NBy0OlBpWVTLSCzhVxjLDRPmRRvewEtz4XtF6Bzyk/a054/9nZhe3f/ivTr?=
 =?us-ascii?Q?EAwue0iFsnmqr3K/uDrUdnXiN67CW8HTZ34tZ/4gUUTE31qrS3GAclwrxgEj?=
 =?us-ascii?Q?mBWY59SBrQ+7b442oAM7K1PBxJ1KHA+CY1oMay2pYYkCUjy2P+Kbx6CBeXaq?=
 =?us-ascii?Q?LVqtdMil1BBh6TN3FwtAsgp599s5YbQWIAv9lrt2qljGBVRlUoe03JJdun/1?=
 =?us-ascii?Q?NfZN10j7Lg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee401df-6960-47ad-214a-08df3bf83e23
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:22:29.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+vYnHZda3uhPTOpO+QuCLtJYjucd/Nqu698BzBYFzPUQqYIvIPmNvxrL8K+SSg50wYtR/A/K+DT+YKt3muQdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6191

On Fri, Nov 06, 2026 at 07:18:27PM +0800, Richard Cheng wrote:
> PCI reset recovery may proceed with state restoration and driver
> reset_done() callbacks even when a device has not recovered.
> Accessing device MMIO in that state can cause additional errors, including
> DPC containment.
> 
> This series adds checks before two MMIO access paths: MSI-X table
> resoration and CXL HDM decoder checking.
> 
> Patch 1 checks the existing PCI Command register read in
> __pci_restore_msix_state(). If the read fails or returns all ones,
> warn and return before accessing the MSI-X table.
> 
> Patch 2 guards CXL decoder accesses after reset.
> The CXL reset_done() callback independently accesses HDM decoder
> MMIO to check whether decoder state was lost during reset.
> 
> Changes since v1 [1]:
> - Dropped v1 patch 1, since commit e8df1d194c39
>   ("PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV")
>   already addresses the issue.
> - Dropped v1 patch 2, following Benjamin Cheatham's review.
>   That some devices rely on the existing fallback behavior.
> - Reworked v1 patch 3 into v2 patch 1. Instead of skipping all PCI
>   state restoration, check config accessibility before MSI-X restoration.
>   This reduces the impact on other restoration paths.
> - Retained v1 patch 4 as v2 patch 2.
> 
>

Sorry forgot to attach the link for v1:

https://lore.kernel.org/all/20260929020405.9724-1-icheng@nvidia.com/

Best regards,
Richard Cheng.
 
> Richard Cheng (2):
>   PCI/MSI: Skip MSI-X restoration when configuration is inaccessible
>   cxl/pci: Guard decoder accesses after reset
> 
>  drivers/cxl/pci.c     | 6 ++++++
>  drivers/pci/msi/msi.c | 6 +++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> 
> base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
> -- 
> 2.43.0
> 
