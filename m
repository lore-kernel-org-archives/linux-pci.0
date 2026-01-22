Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020104.outbound.protection.outlook.com [52.101.228.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8FD328B77;
	Thu, 22 Jan 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090569; cv=fail; b=Q3DkHX7J/4+WUIwdor9Iq8MxB7c/+CTngmbSsVPOZjBnumE2/0DuLfbJRQcAf/kfURj9khxpZJOh/v1dq5d6j8y0QXSmV5nNvtKF1RpvJTUQ66uvQRC6BxW7nIz+6AAZyuaqiTdL0Nhj6pGjLTEgULA7SUultoxcf0XEJ0JeWCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090569; c=relaxed/simple;
	bh=AIkp+RZFP9Xm8dsniBDwdUXH+2GQLosjb6Zh/WXHWlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hO314kIhFjjb3ywxVVTmnNUBUEYZzf4z31ShuG0i+qgYiCxVindgfJArqSR6dngo8Z9olYOfOXGz8cHnSU1Ykxub16/oIy2TMR9qJvfWj7/1X5PvQqwg2y70yd7XR1gJPHxp49/H2JQu8Qttj4UcO7LlYwokPtHle4NmqP9dRls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Qi9EEVRq; arc=fail smtp.client-ip=52.101.228.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Qi9EEVRq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxPpEI8+pM0ZpgUjDhipoC9/Uls4fl4wCJJ8OqieM7oinLIaM6FZxotN/pWAW8iWOnr8ECdlztM1vBklCOxBYAVZaZxo9u/YDIR95jldhpYo9TFkA42CpufnfvyHEeEt0Tat/ZGV+mkwAb4slHDk7bWzN04xgoDD3Z6RCgluNCVlY/hT2KN63OxJRTW94htnMkAlXGxQlPVjGge4SmrDm85sFkh7OSO+jGx6nQnz5LXgnfxdqUvbXcN9Gke8yYPAXluoGbRR+pswwgzesktmFH3L3ehi5FraiM3F3sjZXPAAU3d2xirkPUN0fpMB5URarW8ELThZBeTUIHk1wZle5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUPgWgfusOPXy52CxispRMA5dmu0o5/+a9WebDUxnpA=;
 b=tHRgcwaqYeU0dxM3XZeXoG2aNg4zQt9yYIo98dwIWIvOvmezrfEmqYbg68Saycz4ZfFfVkarchXSIJFO4w8wxNinLDaxjli7Um8FFMTJ4XSJiJi4C1ZI66Bb7j1ST7Jgzqo2l4yix05+TAxTCI4z4l/srLZ9B5F8WJ11H6m63MiT+4DWEO8DuE363q+z2FctjIvwS3E2exGlw8MDS64DmTMq1qnFvAq3ciyqW2AfScgqcdobV8/C0Sm2u2q6G6/8LPOloP4AzgEovxwuzvuuJQb0vjUDM06xEJHR6aDXoFhIUa21o0U7oRw/BcQ3rcc35lXMd+di057+uToKuW7VOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUPgWgfusOPXy52CxispRMA5dmu0o5/+a9WebDUxnpA=;
 b=Qi9EEVRqVW7wUc+CiECTPaQvY5ow9sXBf2A9hQ1ofdhY0DnJUwi4HGK8AZBMb7DVl8mWsVPLK3tDFwjvedXdv2NSirYBqlZQv8ZYJIfbXQSH6Yrs3IFSzJLxK9tWAbYAHx5nRl6i0rLYlfnjdZGA3dTz05gRZWTSD3lSApoDmog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6262.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:41c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 14:02:44 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 14:02:43 +0000
Date: Thu, 22 Jan 2026 23:02:42 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com, 
	kwilczynski@kernel.org, frank.li@nxp.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <tvaumsi4ahosz4herbxoc636fj3lhetjzqlwp5n4e34tthmn26@bld32k6xntmw>
References: <20260115084928.55701-1-den@valinux.co.jp>
 <x64g63zkz5t75vxxlzd7rhbvpus2mmhz2phyvxykuax5wm5cnh@zgpomauf75pv>
 <ugxohcm4tvtjwnhkkz7jw226upm7o5hihohzn2f4eoamhkd77v@mjefdgxneghm>
 <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>
 <aXHfUyd0EPFnoVBO@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXHfUyd0EPFnoVBO@ryzen>
X-ClientProxiedBy: TY4P286CA0120.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 116aa3a9-eda8-4fbf-6154-08de59beea02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+uJZYiO/h9IxfRlmYJ0mt0ObHFgXkiGyYtd8VZCAJATzEtPXBpKxwfsN0RWG?=
 =?us-ascii?Q?sqgELZ3YMIdXHsvK4gc+mMUoU2lhp0YYadI66SbWnLZOJQ8FKDKuiHm1vO+W?=
 =?us-ascii?Q?4i0HLFqhenz6G1ntt07HThj8cHHLzR/IDD6KdMDX97I4+ms8CEHLx6G0DgbG?=
 =?us-ascii?Q?mE7+4OYuJkUyd+R18dUMZjFf8rTAZgFay1AbXJ+VbIJqlFWv+p+rMD3qmgXR?=
 =?us-ascii?Q?9lJNovn2sa+nUnH2d2fA0kXbZh64+lgpJW2kY0WtxMgsCWxo+000hFVsOFyO?=
 =?us-ascii?Q?ahGKYD7nxVIc8A93oxzXYZTUQ4b2qNGf7Li3MUCRCWhHLmNmTaM7ErFn+ZmZ?=
 =?us-ascii?Q?L/tKolENTKwBGtPjSAkV5KanhHONsOrqJ7POPrJIwMsNm3HJxcN34SExjHhZ?=
 =?us-ascii?Q?2QHnyv5e3seZd/O9KsaOYFnHU4OYmVy0a/SaiVFMiVenjSolkPPB5AN4Q+mz?=
 =?us-ascii?Q?iBJIo0aRbuwOtKjEfoEsetH7nEOoU0NjbGVQTfO1BOc/bamMH3QizMisGkRD?=
 =?us-ascii?Q?y7GNFsjVG+jH0sDtKHPS4U71VpuDAjFDyjaYwArKDgGC8Ogb6/RRpi7Mia4h?=
 =?us-ascii?Q?JjdlA2bcMJDpVHjwqP+Ge4nh+QA3/CDHMnCps+zWngnWOTZFaYDxYvRBJgf1?=
 =?us-ascii?Q?MgXAbWw4mL472tqwtXr/NzSATt6UDLgO7xP/m7Y8P5g5yIgBw36mKf7KyayL?=
 =?us-ascii?Q?86F3RE9dd8pGpXGbCyNjuHv2nDEMJjouxVqXz7mIeVG5nlNjYPQ1RuSNb+KU?=
 =?us-ascii?Q?Hi4TjQ85p6iTyN+DQS6WNdHwlY9sMe/r8re0k20BlpubR448RO1oVz1Q+Bx4?=
 =?us-ascii?Q?m1nSuVXofhoNSnxmzoJc8Sgr7qCsSMfASWMlfMlTUOcicHxSt3m1xju8OnT/?=
 =?us-ascii?Q?4Ei5kllcCA/qZpagT5fPQK070GJMaMhvxWSSWX83awk/FYXFNYRlJjvLymwJ?=
 =?us-ascii?Q?ZGBiU8AtZXTl7th3ACw1H3PX/2fsRLTyUkqcdmhGu4B1l1A1QqzdT2dfUThl?=
 =?us-ascii?Q?5a2y+MqXzrl8UL+hwOE466qQlxIcKn//BMVoAnQZvc2Q3SspQwhNvPoEjXl1?=
 =?us-ascii?Q?rzRouxWR4Jb1cu0Vg8dl5HcGuUDqq3ELa5ZRRnSnFrXugqfBm87pS37C6MKD?=
 =?us-ascii?Q?Umx8iBuWHHwGJywDwFpgsVWns700CN3N015tSTEHRd40bOF6Ph2MQi1bf2bq?=
 =?us-ascii?Q?Q1poKSHWE5npR7SiltHa6DFsY6HwvcT7uNbrT5TkQ17wyPQHAKxY7htzN1l7?=
 =?us-ascii?Q?3fC9hBC+hjm5j0RvsCv/a4T98bsovXrEQj1Rw2xVfXYXhUsroU3s395piRMP?=
 =?us-ascii?Q?BWMGDCSXN5OdHndf07Rkzz0kdoJ+r1c9NUmtnhNl7KLquImMvVp61rZxUm2C?=
 =?us-ascii?Q?jSYqnztnIbUxG19jvKnqBeRTzgebzJ7WY6Ql25I3TCQaQLRDP44UQZci2MhR?=
 =?us-ascii?Q?n8mE+B0PC2n3UGjIj+zJJPfBjIMgRycNchoFniosxiN8aHc59cNSYeiobSR/?=
 =?us-ascii?Q?hdXP4edJz+kAMqBlW8Y6CVeThtKC33defLP5v4KitCfpyNyR5vo0gIu4rbdP?=
 =?us-ascii?Q?zWiYMhP+fKKgsejDL7I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XFTcJl4wU+hRafqxgIGRibFJp9X9tTOMtyAsKncCQ1HQ1CJ+HoFNLcVZGx6n?=
 =?us-ascii?Q?jHG9Jjo9kc+8ObDqYu+ebkaalseYcYu/mHjj1Y7+eiHv+jvLxI82jCSV4wRk?=
 =?us-ascii?Q?6I3msZABQCiz5trzdAFj1hXBNlGJjvkOfOe3jdyb3isQakUm45czXCumCEFF?=
 =?us-ascii?Q?QHJ3orfyOP06fJoI3KSU6eDeKXPsf/H6AOAfBbkERMbBLceRNZC/hfG2rQHA?=
 =?us-ascii?Q?D6i0RqUKKU087VcjofHelyGYjdjMD65j/UuyTRXKNYIPl0CuL39OmlChc7Hv?=
 =?us-ascii?Q?H4VZoNwu/sxFe3ugcfvvXMcCDfE9UTB4H74VA4rEbNE64GGVK1B8RjfwH7l8?=
 =?us-ascii?Q?Lltu1rIXz5Pfn9s0FWxfjxz041dfopa5zDHG3khe35Kf4LtzoDjfE8PA0CiT?=
 =?us-ascii?Q?KKN1SazR5whiT/eouCYBg5fBzL+iWBgruuX+f8T6TOWBGfWaekrf6IwR3jPO?=
 =?us-ascii?Q?IFBi0KeL72Yz7vMpaOJg28C77QXGuCNW9hsiUon1E/tqnfsvVAmM16HFs5Tb?=
 =?us-ascii?Q?kQSnQI5ILkaHB6GFdB2u+Nn+U6SqYdaGPALPbZ8gUJUkZGQ9R2UAD94LEqro?=
 =?us-ascii?Q?IllhvaGz0e9Dcm68TcoaOo6u+3Vnd8g18GDjm+gxEd2b/BxC48S+h5eFeBA4?=
 =?us-ascii?Q?bqYUsw10AREpTM32pLzNap4OKSmihC4pAdyAhsxObRL/WDpiMacimZsLMb7c?=
 =?us-ascii?Q?fJiMGrmcDP3y4qQUrHHOJhIuzSG9NVNgE2pINdkUXL6c9k0nn5ErvrzPUIqZ?=
 =?us-ascii?Q?i/t+vo4Vm0I4Gp469/y15XklNkHBSD2Fju6jQWWSrNoraXFuLSOE7TTIYNMo?=
 =?us-ascii?Q?Ha8hQ38tyvt4LJ3Iun9OFOtY3yjHM0lxb0mnqSpfHbSQM4gSYxDHsd+UR9jh?=
 =?us-ascii?Q?xwSJLVJTtPVo+y9R1/2Q2HDqwbyD01GAuNFzaw1QLpAmxNloqSjaLwMAWlqS?=
 =?us-ascii?Q?3u6KydhnH3ku0BUCqtETHlq9dxB2Slca3Z2/QK2sTa5TxSKfUT8VOFt7YiRq?=
 =?us-ascii?Q?T1YmZXRgd3gjEwxH5s5l6B/yuSy7kMfCwrYERcW9hJLYWqhqHSwNPaHJDuUm?=
 =?us-ascii?Q?VCZKk+5Zks7cU+zPGF6NsJ68aR5+qSMeO4h4vHpL6odFfxmPLtQM6QqvNz5l?=
 =?us-ascii?Q?q7k5V1FrHJ4P4hlv67tS9mxWX10d27O3Im4XM7585BNyCzM5xwBEYFFcpkp6?=
 =?us-ascii?Q?9P3BgaNsTI8zpBRjWyPHdlJbnwT407M7QETKPHUC6om+VIuaH+gpI3MEfOcr?=
 =?us-ascii?Q?7cq0ONjD3pPQaV1fxvzyCo3/tRJUsnHvwe6v4hVIdftDe1K6eVIrx2XVyBq4?=
 =?us-ascii?Q?+Vt25G8kTCaCcxBTi2qEE6LUPF6MAR8O7lYro2qOHo8PU0Z4/Ek72xUVveWg?=
 =?us-ascii?Q?FQFhPv6ouGdTzMwacVvoq57GoFkp9pOyXokrGKmTb9gRiVyKvjGkWA5/s5p5?=
 =?us-ascii?Q?qCCPP/ODEtkkhR5dv41lWjP8yRP1me4tFUSxZ68zP7ldbvyThGMQ4t8gltvD?=
 =?us-ascii?Q?HV+2GMdQ/jwgKyN9lVwUn8vAazSD5OSvkg2NRUNE2Neue7AlcAuf210xCvJi?=
 =?us-ascii?Q?l9GhBITFQoXTr8NKLVEYszKQfRB9fcD65qQqF4BG7/0gAK372x8Q6yBShtmF?=
 =?us-ascii?Q?KPFId4g85qZvD3wN5KObIvyHk9H1XJFe93mJijMZJIPCT+GGd93K6OS7E4pw?=
 =?us-ascii?Q?+TreDIVOQIuvVDIzOVQ4kDhsRF9gjnhK88djWdk9g05MMR4wLsuMg65fllm2?=
 =?us-ascii?Q?Grfjle90K4duzyDjeZHun68p/IEbRWzGDZDE1nT1SlIVjwEuwRP0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 116aa3a9-eda8-4fbf-6154-08de59beea02
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 14:02:43.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEAEugz9A81LIkAYXAiMs/3KFcVcXsr0tPv8FH5meTF9uzL9/u+bqmNhEunTS8lGlozoE0dZeoAPE2XlYYHxlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6262

On Thu, Jan 22, 2026 at 09:45:13AM +0100, Niklas Cassel wrote:
> Hello Koichiro,
> 
> On Thu, Jan 22, 2026 at 10:52:31AM +0900, Koichiro Den wrote:
> > > 
> > > In this series you didn't add a consumer of this subrange mapping, which I
> > > believe is the epf-vntb driver [1]. Even so I don't see a justification of why
> > > the BAR needs to be split into multiple subranges. Can you explain that?
> > 
> > Yes, the first consumer I have in mind is epf-vntb / remote eDMA-backed NTB
> > work referenced in [1].
> 
> Another consumer in your RFC series is pci-epf-test, specifically:
> [RFC PATCH v4 35/38] PCI: endpoint: pci-epf-test: Add pci_epf_test_next_free_bar() helper
> [RFC PATCH v4 36/38] PCI: endpoint: pci-epf-test: Add remote eDMA-backed mode
> [RFC PATCH v4 37/38] misc: pci_endpoint_test: Add remote eDMA transfer test mode
> [RFC PATCH v4 38/38] selftests: pci_endpoint: Add remote eDMA transfer coverage
> 
> where the pci-epf-test exports the eDMA registers (using subranges) over a
> BAR, and then in the host side driver, calls dw_edma_probe() on this subrange
> and uses the host side driver to control the eDMA residing in the endpoint.
> 
> Most of your patches in [RFC PATCH v4 35/38] have NTB prefix.
> 
> Would it not be possible to simply include patches 35-38 in this series,
> so we actually have a consumer, or do you need some other patches as well?

Sorry, I sent v9 just a few minutes after your email, without noticing it,
and then I was AFK for several hours.

> 
> E.g., perhaps
> [RFC PATCH v4 01/38] dmaengine: dw-edma: Export helper to get integrated register window
> 
> Would also be required?

Yes, please see the section "Patch layout" in:
https://lore.kernel.org/all/20260118135440.1958279-1-den@valinux.co.jp/

  [...]
  1. dw-edma / DesignWare EP helpers needed for remote embedded-DMA (export
     register/LL windows, IRQ routing control, etc.)

     Patch 01 : dmaengine: dw-edma: Export helper to get integrated register window
     Patch 02 : dmaengine: dw-edma: Add per-channel interrupt routing control
     Patch 03 : dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
     Patch 04 : dmaengine: dw-edma: Add notify-only channels support
     Patch 05 : dmaengine: dw-edma: Add a helper to query linked-list region

Patches [RFC PATCH v4 01/38] through [RFC PATCH v4 05/38] are prerequisites
for the PCI test update, in addition to this "PCI: endpoint: BAR subrange
mapping support" series. Note that this series is described in "Kernel
base / dependencies" section of the large RFC series cover letter.

For this reason, those test cases cannot be included in this series.

Kind regards,
Koichiro

> 
> 
> 
> Kind regards,
> Niklas
