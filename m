Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020130.outbound.protection.outlook.com [52.101.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74240223708;
	Thu, 26 Mar 2026 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535920; cv=fail; b=YXI3ZCKJCw2Q9IussQN0sUaxlsH+KqMyIxjPuoXdlkEhUy0JUx19e9VAI6m1W0fhfOs756/RZ0sUbN4klNe53wMkZLaief3Bvuwelx1y4uNAIEG1q3mzRy5IrZxU//HfmdIkByhfBE3oxBGD+05jMiGoWqNh+rOyGH5VebRYjXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535920; c=relaxed/simple;
	bh=sTWIRuJDtAUDDu/uIM/7CCg/eB89PIq8uOoXvS5QmGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mBX9Sgbo27me/AyMdtXbR2dDSnIG130/LV7WVdg3a0vFJi0MXOGHBP8T3m9hU09giG9++1BhoWrlsjtuVqJY4Z4235zuX0750ihNrlSeeY+QIbTJGIYAIkxKQufaSPcym80ZWacJI7L2bmxo450E0r97c8QabaAhA+K3W+nbAs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uIY+BLX9; arc=fail smtp.client-ip=52.101.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uIY+BLX9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSWh1RVkmi476uYVdN1vOh6CM6wWH2PLM1hE8RgPeVFK0lrKbQj5KA3sA0PLPJsojf9Vfk7iKZmOeiUZZMTes6+0Pmn5GwPCOjC98E25UNJv3CdM/4gCXHWS8Y7MiqYnOxihlc7mJALdmgdiwEKJ6Sduh4jbRUfhshN6HiVYSg0QgCUDBPxRPNYnY4LMkHyMSARkxY22JR9SKSuKYUbTxQvRMZq8JwuFQKFQq2Q8qO56YrO3ajEyeohmd6TuhWihZwt4FXvP2BJHGdPtPWFv4A3nyZTeBBEazH2MfAwx/c/o4mhhVvUgpCIKOC3WSnfr1KKk10sHrYU8aehI+QS0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXcg/6P4MZUC+EviSTQ8eE/Pmck1oEhaRBW/TDLxx7k=;
 b=W+u0XX7ywVD2PViyKimNwEIoRRcUxhgXKVSPOhyQeh7noUzNtIszmzqk9GDVFs1sAIqeuS8krLthYFclcHeZDfCGsJp2wpuNkE6DHWNOnrfSwz4u3aNF4VJ+wEUmkO6VWkHkJPxvlaon5UwDRgUp7aftu3lBSjGxumzPubGXVYPj35ULV7gK/rVf8wszTlfImIrcauh/WMtaLiQzb+trSNhNxoqyG1nlJHEzxqWo21wGzPRLsAh2Pc/+oKhqL54d0tmDwGXJM/ZqC/VnXgFmc2Uq+cW0GuV6st/vuKL15is+jQ8e7KCxvCxFVFPWpMYZZ0h59Ku0ctsTN+l3fRJmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXcg/6P4MZUC+EviSTQ8eE/Pmck1oEhaRBW/TDLxx7k=;
 b=uIY+BLX9aW4BBe1AmUmPUwZj4d2iF3mBMEwkJuJiZmdzPMerlf1whuGpQ/YbT+/FEa+d6pFYzpwiCqUCnV3uuvEHTVv3r69wZDx1WXMUwikEuaNGqCsrv5EKG6t3C0uwcmpkt6xiGVjTv0LRD9vFIdOD7+fbTDVdUASDFHqgsDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2077.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:185::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 14:38:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 14:38:35 +0000
Date: Thu, 26 Mar 2026 23:38:34 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Frank Li <Frank.li@nxp.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, 
	Marco Crivellari <marco.crivellari@suse.com>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev, iommu@lists.linux.dev
Subject: Re: [PATCH v10 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <zhosjtggiphtcv32ikjrfyn7bvv66fdh6aiiknecbgebvtj4pf@7xhrgo4xaxyg>
References: <20260302071427.534158-8-den@valinux.co.jp>
 <acGK6rUIyuJP6gF7@lizhi-Precision-Tower-5810>
 <ksr6hlcwmrkrgrql5jqhtpkaihsugtsztfhxxjbq3au6kz3ksu@mk7hhmwabgsi>
 <acOJcMt7E8PLHAD6@ryzen>
 <ec62kljt36zh2autlth5jivdqlojbpdo2gbs43ayob7hobcpre@bpos6hqyuwkv>
 <acQTxJ75lq4tkszi@ryzen>
 <i4jgdqzliz2mae6jnl5pycasjy4h5x27negpxdxabhu7so7vcs@mvk6qbkw3j7r>
 <acUDdigoIj_uusgI@ryzen>
 <acUJgChL1hypb6ei@ryzen>
 <ee49dea1-96f6-4991-8095-6920ed88585e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee49dea1-96f6-4991-8095-6920ed88585e@arm.com>
X-ClientProxiedBy: TY4PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2077:EE_
X-MS-Office365-Filtering-Correlation-Id: f2774105-da42-426a-c4fd-08de8b455c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BlTGIHh3rR3GEIdBBuM10o7/rs3RfHNYC1Ihsd2NA6R4jSFT99UGerdFxpT6DD3koqBxMgaT3p4kDy0duhQPLWrHy6pVpSEFbc3B+xrLrkQO9x+kFH2KQgSwyAmdbibwEsqmr0Kpl0c1HqLopr0rb1N8g5qs29MIqG2ufBut+K+E3KnUqMleXrtoN+G755gXEJhtqSBZTEYl5oFRpUk5BkP+2WX2UwRrHoq67Q2XxC1IkeXL4bt1u85O1FxbdeJ7a2y4PLgmbs10Ox/pWECh80zGikmKmubm2ZjZi+mQjATh9hMHI3LwWTfK0KmR3DugbA2ftYBwIQZgbwCfF0Aj4xVDO+ZLHIsl5tz7ustJyAvu++1ZT25oYJW5JCHJ4pwql+3CC+koLoLfjf/Zf7kelMi5H+HdwDBdMu1YVzKReZq1mfK4z22cPDa28H0bqrIrHmqRc3oqaJarZ5C80kkkaTRiX4GHs8YEAYfOoti59OJP99CYcw1zx7faj1+mJw85p2gTErFaMZNcNwcIsiV8DX1QOzaefz0qzD4oLC4Uv9mMvs/qXXwS9nNMPAtbC3rqM0gV+z2y9dLfIWzMA+vFrGwFPEfQdRjLFvbRNFQhKAcXoiag28SHUc2okDFL2tjYwakmXuaSakE9PNSG8sQcxw0UtKxuKUl42Fx2Tys8zoI0fvdHB5Qom9iKDBUGunTATKUidIu+SmPOpS2SGf9e2rU/dhdjA64lQTd36svIeDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGNacVgwNm90bHRqc0owQUwvdzJDY0ZUMnZIU3laRHpnbVljazE1azB3VlJw?=
 =?utf-8?B?Umt6c2hKL2hQbVBSZWdLSGlER01QVE84ZU9DaEtIUldHaXJHOUlxQ25pSHFp?=
 =?utf-8?B?REhPNEtCVThXd2ludEpQNXJadjdvU3FjNzF2VXNFMnhSNEhNVmtoQzg5dms3?=
 =?utf-8?B?Z2FaU1diWE9nSUk0M3hRV2Yxd2ExaDJQM3pEQ1B1U1YyaXlDczBHVW9taEpy?=
 =?utf-8?B?amdUeTc4dS9VME02ZDRrRTZwVVhhdkYwSGU4OWpjSlJOSTVGNk9zelVmS1py?=
 =?utf-8?B?R0wzQ2dDdkpucnF6TFVtcG9FSjc4eTcvWWhPUVJVMUdNd1drOGdUcU1mcElm?=
 =?utf-8?B?N2VEcjVvS1R1ck5NT1RCUy94MVVjOGEyWFVtTG9XSkZGWXhDdVZSajhUOVA1?=
 =?utf-8?B?Q2x0bSs1dm5EUFJZZHdPUGFIcy92SGtIMnJQdmlDRW5aay9obGZRSG9seUhQ?=
 =?utf-8?B?eFVFclNXWHk0Yzg5dFI2YkRHd3BycUNFLzRjdm1ZRlRvb2FnTEk2R0tlZnl3?=
 =?utf-8?B?QkFmU2x6Qzl0NDlxNnIxMmFuYzJ3am9jUzl0NDFCMEpVTnFBaEVxT2FBZnBH?=
 =?utf-8?B?OUhHbTdubzJjTnAxTTQyaG0vcHU0RDBObXNlRU0wM29RVjZkTjUzdmhlNEsr?=
 =?utf-8?B?OUxlYXJLNEEwR0llb3I0N2t1VkNYM0x0NW11Vy9MNGhXQUNtY0dab2xMMG9N?=
 =?utf-8?B?TzVQWEIvUDdXd0p6Z2s5QmJuZ0grdkRLb1lrSDB4NHQ2d1hnVDdYUzUwQ25D?=
 =?utf-8?B?Rk9jRzl2b2pOaWQ1NUhweDhlbE1mWkE5a0pnUk81YlpGTGJ3RDlMRVdRWnhm?=
 =?utf-8?B?U1l6eDlPeTVsRG1ranZXbTd1N1VDZit2SWxmc0hiUXU4TXRlckEvMkI1ZlNE?=
 =?utf-8?B?dGR6dFVMZzFlakd0UFA2bDc1WXJjUHNQWHNTSFhDaGY4NGlYQzhFYlNCOU5Y?=
 =?utf-8?B?cWh6aThKa3Y2SWh2NWxxMzl6THlJb1hLNVVkSHpIbk05MVpMTEhZbStRWTdq?=
 =?utf-8?B?bVJMR3dHNE1TYlZZeldqUXZLZ2RMUDRIWTVMUHpvREtrNTh1RlN0eXArb0ho?=
 =?utf-8?B?UnA1N1dQdFpUOUMvZisrS2h0L1IxcmVuM2l2SUhIOS9ncEVvMERhdXlwL3BK?=
 =?utf-8?B?ZGhpU0RYZXphSmYwSkRoTXlydDd4TENEb3ozRUNFcUdBTGpGZzQ3Ujd1b0g5?=
 =?utf-8?B?Y2hRSlpHQXViUlJGMnpzVEZJdGhXcXZvMGwzaFFGTzhvQjVNOUxVVlJoZUlZ?=
 =?utf-8?B?dWpPY29tODV4cTcvcVo5cGpiUDRxVlVDV3lRY1JPaXlxWGdtRlNGd2xpb24v?=
 =?utf-8?B?WVNLL1p3a2JzWGNiOC9XL0pDQkl4Y3RoWVVKSkE1czRKS3czdlRoUmtsUnVH?=
 =?utf-8?B?NEJ6QVdpeS9aNlBVaTk5NlNmaXRmVTBJZmViTmJYdmtMbmxXcVhkVDJRZ3hH?=
 =?utf-8?B?ekxjcW1vM0hUMERoQm5xblh6VDRDRzQvc2Y5K0tyZk5oQkh0MnYrcTdCNFZs?=
 =?utf-8?B?MkRvRTQwZGsvOXNnRWpaL0llTDg1OUhNMmEzQVZKaEFLQjBGQ3grUGhoUGxs?=
 =?utf-8?B?SHVBOTBQNm45SFpMT2RRMkcrSlN1eFRkeE5NR3d3OSt6akdiSk5mVERURXp4?=
 =?utf-8?B?dWM3VDZTbGEwa29FM0pwTGFNUVpOVld5SWc5Y2dUTFEvYU5LMEI0akxpRlB1?=
 =?utf-8?B?R3hRa1Z4N1RnS1pkYVZaOHA3L2dnMElwNTkyanlzTUZ6ZnZGUk5OMjF1VlN3?=
 =?utf-8?B?Z21BWExSbVc5M2tBWC90UlZvd295SmU3UmdTZnFDeVphN2k4UmpMUWlveGs2?=
 =?utf-8?B?ZU5jNjMzY3c0ZkQ0TXBZL0RtaExtc3c4c1ZhUHhGRzgrN25GNm9sWGNBbzNQ?=
 =?utf-8?B?QWxQVXBjNjlGYzBZV0p5TURkY1ZyNGF2cTFHZDNMbmh4MTgvVHRVMjVxaU5P?=
 =?utf-8?B?ckhnUzQ2b3FBRUdPMEM4N3RHbEFNT2tqem5kL2ZaR0xHSEdCcUplRERxS1Jl?=
 =?utf-8?B?SGM0YlhMa2I1SFFnQU9UYXNpN1gwWk9ZMGs5aWlobmZXb255RVd4cEVpVlJm?=
 =?utf-8?B?UmJFZFFSTzB0ZG5xL3hzOFN6ZVpBaW5hSHNRU01Jbmt0SUNPNlBYYnlyMXBn?=
 =?utf-8?B?TXFFZmZkempsd3NiTWljdVhFdnpvSEt1NXkvY1pLZHg4cWxoZTA0RWNpQmZ0?=
 =?utf-8?B?d2FWWG0rM3pWc1FSaW5Ib29ONEJNK3hUSTErTEZuRXlTM0VNQW84Vjc1dmg3?=
 =?utf-8?B?eTMxWnNZREt4dXlvdE9rTjNVUXNlNjErWTdqS0l0eFJ1cG9DWVdVd1Q0bENT?=
 =?utf-8?B?MU82czAweXhIWEs2SCs0dzh6SFBHSHY2T1BvQ3JhekxzZlkzZ1RPVGhDb0k3?=
 =?utf-8?Q?Gk5FqyOVoTV1pDQiBDOwmg4ca6t2M5YvyIqDb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f2774105-da42-426a-c4fd-08de8b455c8b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 14:38:35.6464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QYw+lZPADqqesC8BCSPb1fmySzuRkn5cRci3NNZZrJoNfJz+GvkBV+k7iVNbM5Dkqjgli5XHgaj4S66iL4l7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2077

On Thu, Mar 26, 2026 at 12:12:25PM +0000, Robin Murphy wrote:
> On 2026-03-26 10:25 am, Niklas Cassel wrote:
> > On Thu, Mar 26, 2026 at 10:59:26AM +0100, Niklas Cassel wrote:
> > > On Thu, Mar 26, 2026 at 05:49:13PM +0900, Koichiro Den wrote:
> > > > > 
> > > > > The transaction is a write from
> > > > > PCIe bus -> PCIe controller iATU -> internal bus -> IOMMU -> PCIe controller
> > > > > (the same controller as initiated the transaction).
> > > > 
> > > > Yes, I think we're on the same page about this path itself.
> > > > 
> > > > On my R-Car S4 setup, changing this to DMA_TO_DEVICE consistently triggers an
> > > > IOMMU fault, so at least on this platform the local path used for the doorbell
> > > > mapping is IOMMU-visible. That is the case this dma_map_resource() is intended
> > > > to cover.
> > > > 
> > > > For that path, my understanding is that the doorbell access ends up as a local
> > > > write on the EP side, so it needs write permission, hence DMA_FROM_DEVICE.
> > > > 
> > > > > Would be interesting why this is not working like normal (when using buffers):
> > > > > "For Networking drivers, it’s a rather simple affair.
> > > > > For transmit packets, map/unmap them with the DMA_TO_DEVICE direction specifier.
> > > > > For receive packets, just the opposite, map/unmap them with the DMA_FROM_DEVICE
> > > > > direction specifier."
> > > > 
> > > > I think the closer analogy is RX: the data comes from outside, but the device
> > > > writes to the target, so it needs write permission.
> > > 
> > > I think it is from the PoV from the IOMMU, is the transaction a Read by a device
> > > or a Write by a device?
> > > 
> > > For a NIC driver:
> > > For a RX packet, the data is coming from the device to the memory.
> > > device is doing a transaction to memory.
> > > For a TX packet, the data is going from the memory to the device.
> > > 
> > > In our case, the data is coming from the device, to a device.
> > > 
> > > Almost like a P2P DMA, but in our case, both devices are the same, so
> > > using the P2P DMA API like pci_p2pdma_add_resource() seems unnecessary.
> > > 
> > > So should it be DMA_BIDIRECTIONAL ? :)
> > > 
> > > I understand that for the R-Car S4 Spider IOMMU, it is sufficient to map
> > > it as DMA_FROM_DEVICE. I just want to be sure that on some other IOMMU,
> > > they might consider it sufficient to map this as DMA_TO_DEVICE (because
> > > it is also a transaction going to a device).
> > > 
> > > I just want to make sure that the code works on more than one IOMMU.
> > > 
> > > Perhaps some IOMMU experts could help chime in.
> > > 
> > > 
> > > Note that I am happy to merge the code as is, as it obviously works on the
> > > only platform that this has been tested on (R-Car S4 Spider), and if other
> > > platform tries to run this test case, if their IOMMU works differently, it
> > > will scream and they will report it to the list. So all good.
> > > 
> > > I'm mostly want to know how the DMA-API is supposed to be used in this
> > > specific scenario (device doing a write transaction to the same device).
> > 
> > I guess if a device will be reading or writing from this IOVA that is
> > created by IOMMU by the dma_map() call...
> > 
> > The device will only be writing to this IOVA.
> > The device will never be reading from the IOVA (since the physical address
> > is a register in the device itself, we will never supply this IOVA for the
> > device to read from).
> > 
> > DMA_FROM_DEVICE seems correct in all cases. DMA_BIDIRECTIONAL seems wrong
> > since the device will never read from this IOVA. Sorry for the noise.
> 
> DMA_FROM_DEVICE means the device will be sending write requests to the
> address; DMA_TO_DEVICE means the device will be sending read requests to the
> address; DMA_BIDIRECTIONAL means the device might send either or both. Never
> does the *address* try to pull or push data anywhere of its own accord,
> regardless of whether it's RAM or MMIO or whatever. Hence why we don't have
> or need DMA_{TO,FROM}_MEMORY either ;)
> 
> Indeed if the endpoint controller could somehow recognise that an incoming
> write was a "doorbell" write based on the incoming BAR offset and internally
> short-circuit that to directly raise its own interrupt *without* propagating
> a transaction into the rest of the system, then it wouldn't need the DMA
> mapping. However, if it's just set up to forward ranges of BAR address to
> ranges of system addresses, and there's an IOMMU in that path (such that the
> iATU's "system addresses" at that point are actually IOVAs), then all that
> really matters is what requests the IOMMU is going to see coming out of the
> iATU, irrespective of whether a particular system address after translation
> happens to be an MSI controller, and that MSI controller coincidentally
> happens to live right next to the iATU itself.

Thanks for the follow-up comment.

One reason I added dma_map_resource() for the embedded fallback in v10 was to
keep it aligned with the (pre-existing) pure MSI doorbell case under
CONFIG_IRQ_MSI_IOMMU=y. The fallback to the embedded doorbell occurs behind
pci_epf_alloc_doorbell(), so the API caller can expect IOVA when appropriate
regardless of whether it's pure MSI or the fallback.

iommu_dma_get_msi_page() maps with IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO, so
using dma_map_resource(..., DMA_FROM_DEVICE) for the embedded doorbell case
also follows the same write-permission model when the forwarding path is
IOMMU-visible.

Best regards,
Koichiro

> 
> (Of course the DMA API itself does also care about the general distinction
> of the target address being "memory" or "not memory", as implied by
> dma_map_page/single/sg() vs. dma_map_resource(), but that's mostly just for
> the software aspects of knowing not to attempt cache maintenance etc. on the
> "not memory" where it wouldn't be meaningful or valid.)
> 
> Thanks,
> Robin.
> 
> > 
> > 
> > Kind regards,
> > Niklas
> 
