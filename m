Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021083.outbound.protection.outlook.com [52.101.125.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145E1D0DEE;
	Mon, 23 Mar 2026 01:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230514; cv=fail; b=dLkm7MXDJ9zmNZ+6/MzJwEIasUcUhVogZXnh/vkCjTlzbrG8NR7niLGTj7brUQyhvjNAl6Os4cA1V85bnaI7v5RXAskq6GIHaqs5WkmloJKQwod5+Jr87OSMNfsEgg5fTt7btJZ/cBsFofJf+dv0dES7aKFq0JczkwgMH/hTwno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230514; c=relaxed/simple;
	bh=FB13JirE2CV2h4JwX2sOcsuX8CzduqgQalk5qitTOSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y66v0PaDTlu0W0czukCEX/AfhH0dpjFHQZVibfGE0yTqe96csLqS+3f9yAcvHXfRk1FF+XXwU0NUcGCYpJVSpxjzKWM3trO4G4oqpHr3RlBQip+bm/P7slJ1B+tJL12d9Fkf20XVeR9lZel7FyvRyiq9g1KbH8E8z5jzOSiWkHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Hw7UxF/Q; arc=fail smtp.client-ip=52.101.125.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Hw7UxF/Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzoqn4xJBlfnCupmWExs8OPTq338bRKRYItqTwE3cbGMZz2titfykMoWg0QGtSKV+3McMYiQgoAyx971abR0ctiEnXMjTAtc9wqJ7+C/pV6QMuCn+a3IdD28u9hk6QFKG2kR5wtldTD0VL+RP/EIaqZHawqu5PNq9yOlLuksw1DHizPdax1pF/0lYoOt9hTIdMCeayAjlxc8vO4GHpt8S8uwMl30ZigWJXW+OzonIvnE+w4PHF0UEZw4joX4LwNKxsGCHGvdoYhMUX3c0D8Ka9wKzSHbnMc7r/4MSiW13xptgVnNWvlgtvtZj6CpZOZs7T99KLsPOfJGdyDCi3lV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcgROGQWjcExOolSxNsadI92fUSg41ind7/GTMAHUy4=;
 b=MtyFSyBZKT3OkShEvaOYaud0mLfMTRXMr+BNSlxGChz7ONv+GivGAOPbuHWRffm7mjt5KC2bdLmhtmLkZJjUhJcc4yo9icraLJz60Sye8nYFJ2i285RLZwS8eYGzXKp3RSUv/I3fIJz9jiwZ5Ev6T0WBNlzigLiHKBhiMk639DeKS5oRViIuSZ2vN/vzn8Y1x6TJruH8VYI3315a8RThe8q+EaMFr4AG22UyW60PR3xJoXTc7ZQh5jhZDZx02Q85JIzd+hGW1K3P/e1M/xfqvDoprXK++VZIPEQJZL7iFstd4dVJNlKFTN64VJm5aV0DFynxRb0iDO9qruI9usKsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcgROGQWjcExOolSxNsadI92fUSg41ind7/GTMAHUy4=;
 b=Hw7UxF/QiylfSEuRjDnkMy5n0PnovY8RuzNl1N0R6FsTun06ifnquVuReO7F0MBDQdZ9DXMN2rWumfTYpM4xEtgs9KV2raqFboEzbMrGVMqGw+upaV668r2lJg3ZKxBxuIGTLv6KoywRGzcoz+bg9uxaKnmxZNbbMpThrjc+N0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TY4P286MB5730.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 01:48:29 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 01:48:29 +0000
Date: Mon, 23 Mar 2026 10:48:28 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, 
	Frank.Li@nxp.com, kishon@kernel.org, allenbh@gmail.com, kwilczynski@kernel.org, 
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org, 
	linux-pci@vger.kernel.org, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] PCI: endpoint: pci-epf-vntb: Document legacy
 MSI doorbell offset
Message-ID: <ao3e4stqnfhg2mrewqlye557sc6z65ruyphonc6nisgx3ciajg@ughfgyc4htzw>
References: <20260227084955.3184017-1-den@valinux.co.jp>
 <jne6ovpgukznu36lopk7aydv7rmcp3tl4pstn2fo46r6rt5jom@zxz27fgjom65>
 <e44ccisq4hnmy3lu3lroxc7ou6ssbr25bawbhr4tiud4pztxbw@spzprrgonwq7>
 <rnzsnp5de4qf5w7smebkmqekpuaqckltx73rj6ha3q2nrby5yp@7hsgvdzvjkp6>
 <zpy7kokrwom566chj5oulejwmxkwkp4udoh3qea3j65yzb4qev@zsexhjlm7qnk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zpy7kokrwom566chj5oulejwmxkwkp4udoh3qea3j65yzb4qev@zsexhjlm7qnk>
X-ClientProxiedBy: TY4PR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:405:372::11) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TY4P286MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4888c0-d42f-4558-895d-08de887e4874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	D7FgDQpbuAWRhm/zYXCdGySfA6GvSKABdkWf+PynmpYED3Zf1rDDQ5uSqTFRlNZ0BKqpMDHpn75qxNBYHLbSkcbJD4mhNra926QQ7HPg7ADbaEiYOTTh3hkwQABHjdFugi36DsuJ8F5fQk+nAazcHb1+fJdxBXJZfSq5wBLc5rE5D3S8A8pLFmic1QdAZwWnnvJVI0tSCqGS8HoScWtalb+p7S6WKwT5zfec7hLP/qAbjMpiHgNgETJieLyIGYubwpYy0za+8JOMdPaP2MOlQoH417b1wT7/8rvG1fiEtwpAIBDoiSheSffKQC6gzRvj8lTwxkGDVamPfQ4C8APRsoN1zn84X2M5AR6dtmQBvUMGXi3fARctvOtBs5J+a1010slqd1rN6nm5ZlO/IL6/ghvflP2oGNwg3F3x3u/LXIxeZmabU6+fbWzCsrDE4f24VP6dbh+VB8lpb9KowG1wVSJT6lTtI33pQQ6CkZXzWQoKYN6RMM9wrVDOIIg+Kkn5GT4qHzq5H++6GftdQTpZh1wl6z+VSt/OCxryn2nYBs/x6alvAQUJnXt8h7TGLCl6LBEzsHwXrgRzDvLODr7an5xVfWFvNaod/AVWvff6t0tMBe6IfovNrOc0/hUrYn9SvsUF/lZeSJqgQ28V8SIPOxIhTBgDNtg7ylTbhDS+3uzHxUK4dXqoUsDOEUMfI27zYel+U3xPMgf+pJ/yP0ye6MJItLilYGklTLF1Is31AJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDdMaUNWZTV5M1d4OHEyWXV4RHRvZWVBLzEzV3U3aWFLSFJkSUlVSlYwdjl4?=
 =?utf-8?B?YkQ2VnZISjdtcU1zUW5pWk5DTHI0UWlLWEhzMGwyVk9NU1gvR3FJcXNQUC9F?=
 =?utf-8?B?NkV6NG05VGVybWF2L1IrOGlhRG5ZYmh6VGdndzY4MzZZTzVzWGxhblJweWtK?=
 =?utf-8?B?Z09LT3pnLzFPUGhRUzBnczViT3BiOGV5VGkwcXNqZXF1U2lqNTZxWXhXV0Ft?=
 =?utf-8?B?Y3lBUmFIRm50TzdUalN2K3ZPOWFVcFFERG9uNjBaY2lUSG4yQlM1U1F4SDlw?=
 =?utf-8?B?eWM0VFhiMm0vekFFMlRJSUppbitwdkdDc2Y4YVFCZ05nY1dmZVBqeWVLNUMz?=
 =?utf-8?B?bnJrWnhhbm90bWdkSHZzWDJQZ2pZR25BVisxNm43M053WjRqaXJpRzlndGEz?=
 =?utf-8?B?OXZHMmxtZmpBT21XQVJxZWc4S0RqQ3BBM0hvdVE3cmNPS2VMcXNRK0ZHcFZQ?=
 =?utf-8?B?bXZBRklQcVNLQjA4dEV2eTVweW9WVGpRZ2NnN3J2MkRsZzkyUEZZSlo4L3pQ?=
 =?utf-8?B?ZXVid1lXYTV4dFhDeU1oU25EY0I4OHY5bXBYRTRTT0FHS09LYkRUclZsMVB0?=
 =?utf-8?B?R2hCVFlqWmJaMFNqUkVXZFo4YWgweVorSUdZc0tUTENobW1iYXhHZnpoQkti?=
 =?utf-8?B?dllodGZCWUhtbEsvcktvN3JHR1RabDJzQnhHMVJLUEdOMUEzWjNMRVA2Q3l0?=
 =?utf-8?B?M25qckpVaVhCWlJDRXQxdjE3YVlIRTk4OVViWFZQOE9pRVlId0cwRjVtQmtZ?=
 =?utf-8?B?QWtsYWZRKzJjMXMwaEV5WWRNdnhiSStMdWpWRDNnOGNqTGp5aUt5Y2dmSVVX?=
 =?utf-8?B?MlZuWm1aTmJtTWFOUko2QUVMeDV4c1pFU24vUlBmVXltREkwVFhud1BNMVMx?=
 =?utf-8?B?dEtQV2V1aURuOXBoOE5iVjNCcmttWnJma29pMnV4WHczYlB1VWdVdG85aUJF?=
 =?utf-8?B?ZzlXQmpjd3lFUS9NaCt4ejkxOU1jWXFjRG1tTUdhS2o4RGtTMzE4MTlIYkcr?=
 =?utf-8?B?cSt4aGozU1A2TVFGaGIyY2dNTjExdEJHZE5oc3k0c0pNWW9lQWhtalN1WFVz?=
 =?utf-8?B?a2NTZXlZMHVTZGFQMWtCcHlWeml5MEovRnB5Y0ZZM0hVUTZLZngweGRZMTFn?=
 =?utf-8?B?MUgwZUxpREFNL21VZFg3VG10WWRnTllvRzNRNmdNZlpveXJvWlNIcnVPK2VN?=
 =?utf-8?B?enNpRkVjV0JjYWVIVmxHMlRnNmlRbHpBRGpHaVV3eDQreUZveUVWeXBuT1Bh?=
 =?utf-8?B?Y0Z3T2JhOS92Qm50czZkRTBybUE0NHBaSjZ5VmVFeWxSd0V6UjBkRlRUUis5?=
 =?utf-8?B?YWI4MXlMbVFuajIwMWc5T1dKMVdpT0k4RzlYeGhEVTFnTWJ4Y0laSFBNZ1ZD?=
 =?utf-8?B?dG92LzRPNmZuYkljSEhVOUxFVTVmR1gwb0dhbXFrZW1MVktLdEw4emUzUURu?=
 =?utf-8?B?NUtiTFBBM3IwTCtBRnlDakdNVE5henJLaWpWRUgvNVdFbklHVGc3RmFqY0d4?=
 =?utf-8?B?aTZ1TFh5SWhLYUQ0VlJUZzZwc1lrNWtJM0xWTFlHNlJmcVMvVDlsODZhUGQ5?=
 =?utf-8?B?S1dBOXFnZE1GdElyRC8zdUxKRDBrS0VhMDExNE5HT0wrWnArbjlGampROE1W?=
 =?utf-8?B?Tm5maXJ1SHB1LzVHTFNUTXhCYmUyb1ZSUG5FZWpLNUpUZkpUamtrYTNVWG9s?=
 =?utf-8?B?SGFySTl0WWlGdUUwWmxpdjVSUUQrNk5XeW9BOE42Q0VqTUYwdktQVWxDUm8x?=
 =?utf-8?B?cWJkMU5ZVG5KaFF1MkZMUWMwbnF5ZlV4eGlGYUVhL2VuNEpRSWRkOTFvS1Z2?=
 =?utf-8?B?bmxHREJJaFJSaDJONkduNG5nSE1tN3dQTmI5NFB3ZVhEYWlPUXlER1o1ZFJB?=
 =?utf-8?B?WWlXeVFDd1ZZQjVZVEF5V3FhMGpSZmwrQ28yMmJ5bkdtTElwMjUwTUJpUnM3?=
 =?utf-8?B?UnArc3lEMk9pZGFuR1p1Ym9XbkxHYkpXVlF2ODBKKzNHdGlCVXVML0pBRFo1?=
 =?utf-8?B?M0F4QWFjZlNUYmRwN1J2TnpYNHVmbitnL1JvSm4zODF1RjF0RXRKemovQlYv?=
 =?utf-8?B?SU5qbGhtQ2hrWXRoc1haaW5wRUVqeVVWN29MZkNzQlBCeEI5THNEQzJEeW9t?=
 =?utf-8?B?TXZ3ZU5oaDVYakFvRTlIdUgwcFpSbHExM1MzQWhTSFlyT0g3bDQ2ZjM2M004?=
 =?utf-8?B?RmRkRXJUTzJBdXBxU2lIblNWVHYxOTlzbEJXTW00TFV6ZFNtVDdIUFZPTjRK?=
 =?utf-8?B?d0pQdEJQRnVnSWkwNUlpcTdDMGJkWGRKYjBud1EzWWxzRnpoUHdlb1gyQXlx?=
 =?utf-8?B?UTVwV3kwRlk4RDBXdjl2QTFWUzdKUWpta1AxL3BVYUJzMnI5aW16MWFLWFVR?=
 =?utf-8?Q?/RzI6/in4I+G9ChFad3gmuPJNIhwKcAPx+waf?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4888c0-d42f-4558-895d-08de887e4874
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:48:29.6793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/M9Sy6Kf7OoirZ3mSDPvF7UFdOcpFhkZpSXFJlyUhskgJ4gwCk4ui9ZgvH2YxJxmq2HpddOOkx4sHACMk52Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5730

On Mon, Mar 23, 2026 at 10:29:00AM +0900, Koichiro Den wrote:
> On Sat, Mar 21, 2026 at 07:08:36PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Mar 20, 2026 at 11:55:23PM +0900, Koichiro Den wrote:
> > > On Fri, Feb 27, 2026 at 05:57:40PM +0900, Koichiro Den wrote:
> > > > On Fri, Feb 27, 2026 at 05:49:45PM +0900, Koichiro Den wrote:
> > > > > This series fixes doorbell bit/vector handling for the EPF-based NTB
> > > > > pair (ntb_hw_epf <-> pci-epf-*ntb). Its primary goal is to enable safe
> > > > > per-db-vector handling in the NTB core and clients (e.g. ntb_transport),
> > > > > without changing the on-the-wire doorbell mapping.
> > > > > 
> > > > > 
> > > > > Background / problem
> > > > > ====================
> > > > > 
> > > > > ntb_hw_epf historically applies an extra offset when ringing peer
> > > > > doorbells: the link event uses the first interrupt slot, and doorbells
> > > > > start from the third slot (i.e. a second slot is effectively unused).
> > > > > pci-epf-vntb carries the matching offset on the EP side as well.
> > > > > 
> > > > > As long as db_vector_count()/db_vector_mask() are not implemented, this
> > > > > mismatch is mostly masked. Doorbell events are effectively treated as
> > > > > "can hit any QP" and the off-by-one vector numbering does not surface
> > > > > clearly.
> > > > > 
> > > > > However, once per-vector handling is enabled, the current state becomes
> > > > > problematic:
> > > > > 
> > > > >   - db_valid_mask exposes bits that do not correspond to real doorbells
> > > > >     (link/unused slots leak into the mask).
> > > > >   - ntb_db_event() is fed with 1-based/shifted vectors, while NTB core
> > > > >     expects a 0-based db_vector for doorbells.
> > > > >   - On pci-epf-vntb, .peer_db_set() may be called in atomic context, but
> > > > >     it directly calls pci_epc_raise_irq(), which can sleep.
> > > > > 
> > > > > 
> > > > > Why NOT fix the root offset?
> > > > > ============================
> > > > > 
> > > > > The natural "root" fix would be to remove the historical extra offset in
> > > > > the peer_db_set() doorbell paths for ntb_hw_epf and pci-epf-vntb.
> > > > > Unfortunately this would lead to interoperability issues when mixing old
> > > > > and new kernel versions (old/new peers). A new side would ring a
> > > > > different interrupt slot than what an old peer expects, leading to
> > > > > missed or misrouted doorbells, once db_vector_count()/db_vector_mask()
> > > > > are implemented.
> > > > > 
> > > > > Therefore this series intentionally keeps the legacy offset, and instead
> > > > > fixes the surrounding pieces so the mapping is documented and handled
> > > > > consistently in masks, vector numbering, and per-vector reporting.
> > > > > 
> > > > > 
> > > > > What this series does
> > > > > =====================
> > > > > 
> > > > > - pci-epf-vntb:
> > > > > 
> > > > >   - Document the legacy offset.
> > > > >   - Defer MSI doorbell raises to process context to avoid sleeping in
> > > > >     atomic context. This becomes relevant once multiple doorbells are
> > > > >     raised concurrently at a high rate.
> > > > >   - Report doorbell vectors as 0-based to ntb_db_event().
> > > > >   - Fix db_valid_mask and implement db_vector_count()/db_vector_mask().
> > > > > 
> > > > > - ntb_hw_epf:
> > > > > 
> > > > >   - Document the legacy offset in ntb_epf_peer_db_set().
> > > > >   - Fix db_valid_mask to cover only real doorbell bits.
> > > > >   - Report 0-based db_vector to ntb_db_event() (accounting for the
> > > > >     unused slot).
> > > > >   - Keep db_val as a bitmask and fix db_read/db_clear semantics
> > > > >     accordingly.
> > > > >   - Implement db_vector_count()/db_vector_mask().
> > > > > 
> > > > > 
> > > > > Compatibility
> > > > > =============
> > > > > 
> > > > > By keeping the legacy offset intact, this series aims to remain
> > > > > compatible across mixed kernel versions. The observable changes are
> > > > > limited to correct mask/vector reporting and safer execution context
> > > > > handling.
> > > > > 
> > > > > Patches 1-5 (PCI Endpoint) and 6-10 (NTB) are independent and can be
> > > > > applied separately for each tree. I am sending them together in this
> > > > > series to provide the full context and to make the cross-subsystem
> > > > > compatibility constraints explicit. Ideally the whole series would be
> > > > > applied in a single tree, but each subset is safe to merge on its own.
> > > > > 
> > > > > - Patch 1-5 can apply cleanly onto pci/endpoint latest:
> > > > >   f6797680fe31 ("PCI: epf-mhi: Return 0 on success instead of positive
> > > > >                  jiffies from pci_epf_mhi_edma_{read/write}")
> > > > > 
> > > > > - Patch 6-10 can apply cleanly onto ntb-next latest:
> > > > >   7b3302c687ca ("ntb_hw_amd: Fix incorrect debug message in link disable
> > > > >                  path")
> > > > > 
> > > > > Note: I don't have a suitable hardware to test ntb_hw_epf + pci-epf-ntb
> > > > > (not vNTB) bridge scenario, but I believe no changes are needed in
> > > > > pci-epf-ntb.c.
> > > > > 
> > > > > 
> > > > > Changelog
> > > > > =========
> > > > > 
> > > > > Changes since v1:
> > > > >   - Addressed feedback from Dave (add a source code comment, introduce
> > > > >     enum to eliminate magic numbers)
> > > > >   - Updated source code comment in Patch 2.
> > > > >   - No functional changes, so retained Reviewed-by tags by Frank and Dave.
> > > > >     Thank you both for the review.
> > > > 
> > > > Sorry, I accidentally used an incorrect series title.
> > > > The correct subject should be:
> > > > 
> > > >   [PATCH v2 00/10] NTB: epf: Enable per-doorbell bit handling while keeping legacy offset
> > > > 
> > > > For reference, v1 is:
> > > > https://lore.kernel.org/linux-pci/20260224133459.1741537-1-den@valinux.co.jp/
> > > > 
> > > > Best regards,
> > > > Koichiro
> > > 
> > > Hi Mani (cc: Jon, Dave),
> > > 
> > > This series has been sitting for a while, so I'd like to check how to proceed.
> > > 
> > > I'm thinking of the following approach:
> > > 
> > >   - get the remaining acks from the NTB side
> > >     (Dave already gave Reviewed-by for Patch 6/10)
> > >   - then route the whole series via the PCI EP tree
> > > 
> > > Does that sound reasonable?
> > > 
> > > If so, I can prepare a v3 rebased onto the latest pci/endpoint.
> > > 
> > 
> > Yes please. We have queued a lot of endpoint patches for v7.1, so it makes sense
> > to route this series as a whole through PCI tree.
> 
> Sounds good, I'll send the next revision (v11) with that in mind.

Sorry, typo (v11 -> v3).

Koichiro

> 
> > 
> > Also as you noted, all the NTB patches need an Ack from Dave.
> 
> I'll reach out to Dave once I send v11.
> 
> Best regards,
> Koichiro
> 
> > 
> > - Mani
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
