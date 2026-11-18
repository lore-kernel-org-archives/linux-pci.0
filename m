Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794983194;
	b=SGgR73IeiTOW1rbsodnkKUz/adad9Rvmt7Tx76qWw+Y+gJEYvVH+yQO9lgVsIWzXZmBa
	 v8S0oiCOqgWYoTCJSeQ2Kh1LcLWkW47uIGmUKLGN1Heq4tETgNqQWtxpVUDRAxyCVzKof
	 8duXd2eGsgBLwm/7pJQz5CGVbTejMcLuxQ1SWtjrArGihQvV1/a1OVVVlbavFnvU0mhBG
	 vE5vO/vf5JsFUL+eOxNovoYzKpgiriVT1x+sQlCRHtxwOtZ+ZKfuUVy/UXAOB+aUrQXNg
	 vY0LjLpbdK/uJo75UfHtXJxmmTiANTJY/2dXLjRsJ76FAPrGEkSjnJY9T8JfhfH083Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794983194;
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
	bh=Ww5buphj/9ocJ1N48f4JcsXP+VQP934a+3geOYkT/uk=;
	b=ojljCUKXf6IIkagtsD1wDM6gD8LO3M4R++Vn/7H/5e2X9svLHkBNorv9zX/H9GjSFfA2
	 ndDqffVpAo2D2h7Iu7CkAR64lImYq8UzcSfuqK2znmWe62JlT1dZyeFCWQmhX68CrzLQK
	 aHlgG7NlU14UAMXATt/qhUjHL5MUZ/q9ax75erwX1b79rVlQfYuTQqYUWUquZrY2nmkDb
	 hi/nic+r/Vrg6nLUqZeJ9Jn6/CdO1DgGwfu4FZSeLuT6hu4m3yO71tQ5yxUW2LJ0J4xWY
	 HQl9EEy79IZwKo4rbUCusHtYcKILa4My83qrsI3G9QtRbgzjJGajjxss7Zau1Kc64rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=NbxqGTie;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.136
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020136.outbound.protection.outlook.com [52.101.228.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2C606A325;
	Wed, 18 Nov 2026 06:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E2C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=NbxqGTie
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKK4szGDaEbZvCZtVnN28DybmGJHhc9aXrRzA4Ei21UpOd0SRWToc7EXMQIsx1AbfjYnaWTgJMh0YRg9eOrrCxSKVDaR6nyZ6EfPLHastuDR+1o7n7SfpugcODrfDg5r2ugGfhrI8Z0G+UviDY7G5bFPYea8/+weTlpUgpj4nHEGjstIRb0Yk7tEKn7YRUPTQeiLI81LHpNpGU2kqsWRgo2V2qzjiOtx+mGLaZDMnD/3fs7qgdJPRCQ3vC/xoxWvcK4+C0R990bdNHqidVbe0SzA28PO3SaZmnpyJJrgxO755zltsI/sUzjwDPwDwc/5D5m3mX80g+y2MhKMDUZj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ww5buphj/9ocJ1N48f4JcsXP+VQP934a+3geOYkT/uk=;
 b=UK/3aE6QcU+EEBvTzNVF6c+H67oY5WdpL3ooFm9B8PguTJoe61xXqGYr6L6xGwf2d72QtqtFUfHhHd+3a9gCwxE4IRhDwyEEj3KUCBNE+Ah8t3HuBH23O0FNEjcGQXkYTGSKbI7tQYRNVsK+VrnplyXSqBlEjcBE6EYmfPI4Sr7hSHPaglwm42Zxc6IwdDTh/tojRcaq9sqReVliDlsn8EXz4tm54Venw2E6DPIHjjzM5ExJboPc0hccG7GdRAFRqwynx4YGQt4whSHoWwirSIrowDhCXgqwNCFfQ5Z+3rLVxBM52H1NkCebS8nPRfvxAYRnvj6y9Vv9qVjjCq8VOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ww5buphj/9ocJ1N48f4JcsXP+VQP934a+3geOYkT/uk=;
 b=NbxqGTie/IvOQvSblGjsb1tqr25L0tjx1LE5ucAYmYFmVQaCEZfIKSVP7Q2W2+MRzULfnG6aULfn6CHHIMXCqwOULrz30cRfesFHem3ekHUDlHibfvAZ8xZba4uGIVtj++s9ru9tpmmUW5c/Bc2gR16erL6GBmWhh1WWpYYyyJo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6324.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:40b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 06:26:31 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 06:26:31 +0000
Date: Wed, 18 Nov 2026 15:26:31 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
	Allen Hubbe <allenbh@gmail.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v10 00/10] PCI: endpoint: Remote DMA support via vNTB
Message-ID: <xuv3q66fdxsp5vjg3dsl4n2rfiinfdunkd2sjtuekcrrf6k5ht@zc3b4ocuq5w6>
References: <20261113132935.4152566-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113132935.4152566-1-den@valinux.co.jp>
X-ClientProxiedBy: TY6P301CA0001.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a279823-582a-4595-569f-08df453ce2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|376014|366016|23010399003|56012099006|261022105027099003|261102130727099003|261021121427099003|10067099003|261026140227099003|261026121527099003|261022075727099003|261026135527099003|261028144727099003|261102123227099003|261021123027099003|261009223027099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IX9qg1YVWZcwWdgfhojAkScjLIgyPA3VxkThWQGLRBm5dd44GbA/GP2WIxqgR16Ufg5hwWWOc9RM/Ez32FyynTuUwFy6oHoVWqzMRky91Zb1OdfVCkmARx2wgM81zwj0MuHbhPv+u9Wb0BIzSsK4QnjImgHfaHB6apuweRFa24n9QAU7R8spKCfZNBx2lqTvo6NBaLpTNKgdEiQPBDCiRx4UEkhXVy1Br22b+F/Kzd3PupdTaBq0QIBLM0uP4ssOKVGK/f0RznNoEB0hjXfPWjReDkDFnQX0a+I3UITG3hnKJpQtno77p4XNBy1V3WrITDQpQ+njfk/eESx90Z2mpIWw5dWZQLVLY7zBNt/Rm0WUtNADU2pYNLtWOMUxgFHdJFpETDN5M8GiGQHCnOdBz0xDxMjzNVlqtRyxi53e819cfBDGryimmjHI8jPAqCVvzoMKJhG8efOn6D56u2OnNOFGaE9CCDXIVBbo5wXnoiH3TdYkHrnvs4vmKkDwJCqNIAXCtrZpcNQ9Xh68TwtxwELlUrIyHr9nlcMZSod80b4sryyb6G2ymc4u1rJGuBPFdM/6Z/D7a0YbaTMHrzfJ+Qh+SHBC/w3VCAP3PODmG8GBpsOSFu+dhGWLlX6cxd9R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016)(23010399003)(56012099006)(261022105027099003)(261102130727099003)(261021121427099003)(10067099003)(261026140227099003)(261026121527099003)(261022075727099003)(261026135527099003)(261028144727099003)(261102123227099003)(261021123027099003)(261009223027099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IJKFCBSBM5u/mg6gnSBs7rbiCKfX8IOiLcMM/hMDhQ5zrnkZeaVvjXY7irKE?=
 =?us-ascii?Q?YNkU0tpD7XyP5PjQ+3X8tLgJC6JmvgkZ52/drsk2ye2HK1M5nnruvTAalUSu?=
 =?us-ascii?Q?jA8v9cdxS9KKbS7VangFsSBjzVee3qrsNH7+wz2XCeJGSD0kQbxJHrNZybBE?=
 =?us-ascii?Q?zGZiL0Kn8S8hX/i23GWx2qumkjMgo+Ju/Ln0Q7mfIle7hEnaUZlACz3QLyTe?=
 =?us-ascii?Q?HTZVCZH13aR0CX7fzmNTggPsoUBXxeiIfSQGyjIfS++SDoNGd9UCmT6OXpDS?=
 =?us-ascii?Q?Q7bNKBW+CZwd2H+I5wfK0dxUsi1uTxQwmN3UgcmIZiBqVNvcqTwyP2C/j92e?=
 =?us-ascii?Q?tUWheiXShE6EmFJPO+uGdlAEYt1l/yk5ybGzu/5Pu5YSVphE/AmUl++vDG3+?=
 =?us-ascii?Q?MMLhz7NeItO73aisAKkM2R4DcruZSLASaJlD11tJAbENHlYf519+H1Hy2Ciy?=
 =?us-ascii?Q?i+ZQ629VTHwXvnOmzHX1bmgLmjle7vBkTRoBHpjS2j7UmqS3P+s5/b+GIeXx?=
 =?us-ascii?Q?JTdyn8niCVRxqf3ZqTjfzwcA544tXKHMJMKKINlgwbVVwB37YQBJZwlLJK51?=
 =?us-ascii?Q?D56HgsJVWQCsdxw7hU+7GIVC/N6j3CL+5n4M8hXbW3XhU2U8XWNBuuecYpMJ?=
 =?us-ascii?Q?X6whBoIcXTt5gCUaILZMP1sBWVURIvHW4xryGhNjVjSUnZjmdD3iZUAU85L4?=
 =?us-ascii?Q?GL1+qxsE7EmcSVvOhl0XCl0dctRH9btj8yX3NAmFLNL1zzbtwODzMiPyK96v?=
 =?us-ascii?Q?fXl0ntz56+TEN0LDDXAIL3LOYNyC5+4+MMDDiyUCuAWWAbBbVK0g/Q4BS7nf?=
 =?us-ascii?Q?ML6kEBm4Jo7We3oB82Pqnhw7tyCJFjR/NYEznEvFNJD3868HJddobRRmybXH?=
 =?us-ascii?Q?iwGqzn4BL2Gp5OK/jUp8oIp453Gl4+4F0Gh3FwVXtwaqyGCursMJC7Oq0Wyw?=
 =?us-ascii?Q?KHyzF9lp3qBubZd7GxN/+4Cz38BxZjTpvBYgr2j764RrAux5s/+h7RIkUA8J?=
 =?us-ascii?Q?VOnkQF1SOchLfDpNtbkFLA2MHkfyoTtFDnY3OmbDoQ9ethOe+2pAPG3Pug5g?=
 =?us-ascii?Q?ipTmTbFAEswWsG8t0ACD+lHhmrQaB1NklJCarleRczR70s2Tqh+FLabgcEeJ?=
 =?us-ascii?Q?cRrzIf1YXlYWZfI1kWJCZ5eDQuXrlhoLPvD4MSCKj38B7/1vel2zDmwtoD9C?=
 =?us-ascii?Q?0rejDfjEq/B9/9XhDtUtsS15OdkMPw/kiop+1N3h8iUgi4d5fim83o2pMG2a?=
 =?us-ascii?Q?JJyN5rzDOFC22t6Hz+0ENtxtqT1M3iG2T9AaTgJDo66zYLcEY1gyj97tf+Qc?=
 =?us-ascii?Q?uRZ4OkV2wfe57MOSoYM5IW8TFTcYJgsnxGS0uSmPDi+4cAzeU7qTyfRdD6Rb?=
 =?us-ascii?Q?scQNJqkqaEJVDUMcsPKGt8DV9zmBHTgmwhq4334R3jJtSpmsJr0lhhHSc5ea?=
 =?us-ascii?Q?7ReYE2HEMEDc7OX8AFdUVm25jW72p7APqve5gqGqfJIe4F+iBeaCz8VOs+HC?=
 =?us-ascii?Q?w+H9jCXskdDGIDhOAjUd10ke/ywM+VBq2a4vKw5qeFslTmpaLGlH5lvaNNAL?=
 =?us-ascii?Q?vaOe6AOTIPbAEVeYSFsq/c387avAgpuCLA0gUaASt8+ToNO1JFOggrUQTP1O?=
 =?us-ascii?Q?xlNYOUp2B24dapefuK9pUWrEyQ0hjaN3a5LZ1PuCHBz7n9j8N/NM/y/V3boz?=
 =?us-ascii?Q?SSWiPzCEEJsROT15WrJ60daWVrHcVCZXW3kk0zEZhZm3p33b5ty49oqaT1ov?=
 =?us-ascii?Q?1dclEIN/GcrMgChKsE09Np6YCKjYpTXRvjWq3yQWCFRxBvj6HNt3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a279823-582a-4595-569f-08df453ce2ee
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 06:26:31.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laerY8nJs1rFNvC3CiSq69qEL3+Qswkm4rPjRptp8cHEbmtMQfcK9ceDuJj3EolntIjjvBEAIsIO+L2Ujzkg4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6324

On Fri, Nov 13, 2026 at 10:29:25PM +0900, Koichiro Den wrote:
> Hi,
> 
> This series lets host Linux use EPC-local DMA read (RC-to-EP) channels
> through vNTB. I also tried a separate PCI DMA EPF, which reached v7 [1],
> but came back to this vNTB-embedded approach after discussion.
> 
> An EPC-local DMA engine can use host DMA addresses (IOVAs when an IOMMU
> is enabled) as PCI addresses to reach any host buffer mapped for the
> endpoint. Letting the RC side drive its read channels also gives the RC
> a direct path into endpoint-local buffers.
> 
> A major motivation is direct TX in ntb_transport. Both sides could use
> the same dmaengine-based TX path (ie. symmetric), sending directly to RX
> buffer DMA addresses supplied by the peer. This would avoid MW bounce
> buffers and per-transfer MW remapping for payloads in both directions.
> 
> This assumes both sides trust each other. The RC side still programs DMA
> over PCIe MMIO, so this is expected to pay off for large data transfers.
> 
> DesignWare eDMA is the only supported dmaengine backend for now. Other
> EPC-local DMA engines can be added if there is a need and they have a
> suitable programming interface.
> 
> This series does not include a consumer for the dmaengine channels exposed
> to RC Linux. Native HDMA support is also left out to keep the series from
> growing too large. I plan to send a follow-up series,
> "PCI: endpoint: Support native HDMA for vNTB DMA",
> once this series is acked or merged.
> 
> Setting pci-epf-vntb's 'dma_bar' configfs attribute enables DMA export.
> The default is -1, which leaves it disabled. pci-epf-ntb only switches to
> the shared control layout header and is functionally unchanged.
> 
> Based on v7.4-rc1. No external patch dependencies.
> 
> v10 uses the previously unused IRQ slot 1 for DMA, so enabling DMA no
> longer takes a doorbell vector. EP behavior and the wire format are
> unchanged.
> 
> Patch 9 needs another review. Using slot 1 makes the changes to
> ntb_epf_init_isr() much smaller than in v9.
> 
> 
> Proposed merge plan
> ===================
> 
> Patches 1-7 are for the PCI tree, and patches 8-10 for the NTB tree.
> The NTB patches need the shared header as updated by patches 4-6.

To Dave, Jon, Allen:

  Could you please take a look at patches 4 and 8-10?
  Patch 4 adds include/linux/pci-epf-ntb.h and lists it under "NTB DRIVER CORE"
  in MAINTAINERS, so I'd like to have your ack on it as well if they look fine.

To Mani (Cc: Jon):

  I wrote "patches 8-10 for the NTB tree" in the cover letter,
  but I'm also fine with them going PCI tree if that is easier.
  And of course, if you have any concerns, please let me know.

To Frank:

  Thank you for your patient and thorough reviews!

Best regards,
Koichiro Den

> 
> 
> Compatibility matrix
> ====================
> 
> "Old" means v7.4-rc1 without this series, and "new" means with it
> applied. The table describes expected behavior.
> 
>   EP                              | Old host     | New host
>   --------------------------------+--------------+----------
>   Old                             | OK*          | OK*
>   New (dma_bar = -1)              | OK*          | OK*
>   New (dedicated DMA BAR)         | OK*          | OK
>   New (shared MW/DMA BAR)         | OK**         | OK
> 
>   *  NTB works without DMA.
>   ** NTB works without DMA. An "Old" host treats the whole shared BAR
>      as an MW, so the EP falls back to that layout at LINK_UP and the
>      DMA ranges are no longer mapped.
> 
> 
> Testing with v10
> ================
> 
> The existing MW-based ntb_netdev path worked with DMA export disabled
> (dma_bar = -1) and enabled with the following EP-side BAR settings:
> 
> * Dedicated DMA BAR configuration on RK3588 Rock 5B:
> 
>   ctrl_bar = 0
>   mw1_bar  = 2
>   db_bar   = 4
>   dma_bar  = 5
> 
> * MW-shared DMA BAR configuration on R-Car S4 Spider:
> 
>   ctrl_bar = 0
>   mw1_bar  = 2
>   dma_bar  = 2
>   db_bar   = 4
> 
> The ntb_netdev tests covered all matrix cases above involving a new
> kernel (i.e. everything except the Old x Old pair).
> 
> Since this series includes no DMA consumer, the tests above are
> regression tests for the existing MW path. With an out-of-tree NTB
> transport that uses the exported DMA channels, I also confirmed that the
> slot 1 DMA IRQ works.
> 
> 
> Best regards,
> Koichiro
> ---
> Changes in v10:
>   - Share IRQ slot 1 across DMA channels instead of taking a doorbell
>     vector, and remove the spare-vector fallback. (Sashiko)
>   - Add Frank's R-b tag for patch 6 and drop it from patch 9 after
>     changing IRQ allocation.
>   - Retest the compatibility matrix on R-Car S4 and RK3588.
>   - Link to v9: https://lore.kernel.org/r/20261110082459.1798763-1-den@valinux.co.jp/
> 
> Changes in v9:
>   - Rebase on v7.4-rc1. All prerequisites are now upstream.
>   - Fix shared-MW size and alignment handling, and validate the shared
>     BAR at bind time. (Sashiko)
>   - Reject SETUP_DMA_BAR when DMA export is disabled. (Sashiko)
>   - Retest the compatibility matrix on R-Car S4 and RK3588.
>   - Link to v8: https://lore.kernel.org/r/20261022082230.3164834-1-den@valinux.co.jp/
> 
> Changes in v8:
>   - Fall back to exposing the whole shared BAR as an MW for hosts
>     without MW/DMA boundary support (ie. "Old" Host), instead of
>     rejecting LINK_UP. (Frank)
>   - Link to v7: https://lore.kernel.org/r/20261021042229.2280937-1-den@valinux.co.jp/
> 
> Changes in v7:
>   - Split and reorder the patches for the PCI and NTB trees. (Frank)
>   - Reject LINK_UP from hosts without MW/DMA boundary support when
>     a BAR is shared. (Frank)
>   - Link to v6: https://lore.kernel.org/r/20261020054948.1218370-1-den@valinux.co.jp/
> 
> Changes in v6:
>   - Add a prep patch that moves the control region layout to
>     include/linux/pci-epf-ntb.h, shared by pci-epf-ntb, pci-epf-vntb and
>     ntb_hw_epf. (Frank)
> 
> For earlier changes, see v5:
> https://lore.kernel.org/r/20261009045949.1109871-1-den@valinux.co.jp/
> 
> [1] Superseded approach, PCI DMA EPF, v7:
>     https://lore.kernel.org/r/20260813063757.3131865-1-den@valinux.co.jp/
> 
> 
> Koichiro Den (10):
>   PCI: endpoint: Add DMA auxiliary resource metadata
>   PCI: dwc: Expose endpoint DMA resources
>   PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
>   PCI: endpoint: Add pci-epf-ntb.h for the shared NTB control layout
>   PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
>   PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
>   Documentation: PCI: endpoint: Document vNTB DMA export
>   NTB: ntb_hw_epf: Use the shared NTB control layout
>   NTB: ntb_hw_epf: Discover vNTB-embedded DMA
>   NTB: ntb_hw_epf: Support DMA and MW sharing a BAR
> 
>  Documentation/PCI/endpoint/pci-vntb-howto.rst |  33 +-
>  MAINTAINERS                                   |   1 +
>  drivers/ntb/hw/epf/ntb_hw_epf.c               | 396 +++++++--
>  .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++-
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  |  85 +-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 840 +++++++++++++++---
>  include/linux/pci-epc.h                       |  34 +-
>  include/linux/pci-epf-ntb.h                   |  90 ++
>  8 files changed, 1311 insertions(+), 275 deletions(-)
>  create mode 100644 include/linux/pci-epf-ntb.h
> 
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.54.0
> 
> 
