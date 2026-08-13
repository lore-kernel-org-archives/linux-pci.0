Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020114.outbound.protection.outlook.com [52.101.229.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B7D2F3C3D;
	Thu, 13 Aug 2026 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630538; cv=fail; b=QzQ+29sGcN5OFAUxwGfmAVxxryJjMO9CtKAf75pTp1DzY9DB4v+8QMMxySh0124WEDLXnEWUtKjtgTLfGxNMx9bFdgU3ruEpyC+0gHv4X2qsyi31urwB1cDcIwHJuSkdeGDJ5x8owrI9UP/ubWYCS98TFtSvIklVuCU0AnbLBzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630538; c=relaxed/simple;
	bh=kJzrtjhk0BNdtLX46lbO1yLceKLpFLOrJ5wZzCkyd+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IFNHJg9bHXd/V0FtbBTshwMC15NzOLpd29YYmtS+3TmDhcQhd0VZF9YglXH9eU8kkzhwBRKLH69auwPYzPOawmnz0wT+m78274toUlNLG+cnB0wtodnzmwy305ijlbKboj9gVZrbONdf9TRWa9rbJfoJKjvQbAhRSC/SUU11bNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aodubm4Y; arc=fail smtp.client-ip=52.101.229.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aodubm4Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pkz+fjNb5Lmry22sa0sSNWzXquCmPOw1aqtDdmi07Sxcjw9KWmBmRPmzmQWXXiIz23Eoh1ovywev4y+eXIjuSvdlnku7EETHwzKpMWpeujzdeyI+VqXgYhZKFPylJI/76aDaoTd06V/LqbuyUxNOZwmKxyDBCK98BtCL4FxuBh/Yz9F74DhCgkgLgAgg+tpOR+j7jsIwsMr4Jxs1D/ULYV+klwcHQHQ6ZPqV3kQuZbOSpvYK1QZRCOr8CjbsCn1SDQ+47spHM4nKov/yHqi9XGKZoInRnkQsjlpjrgip4asAnUN8xuPslCRcKo7fTsOimAxZfh7+n24yxYwLVAK3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jw5Zc6m/rOeR2ef0N+JkcSXJjcmQoRYjovaww8Eqwpo=;
 b=bFUHyyIXSEwbhAw9l1veh3hpXyDr2jJvc2bONC5/P8G7D8NkrLx5ot8Y5d2xPGbkgh5VbdS1IiKiQ7Ma50Pl0ZKmYYoTSA0PCWA8OyFHrqBMLRQP0OjcLI6s3+PLeuYYKgzuzWAV7vEa2nI9YI36lb81hY/0hkEIWNYDmIS6gixalCU6sEqbm6FZopJRe/AMk+RbWo4hxpIasxba3MOxAHC6I1RljrbIqTJJpRpShFzh+61HBudKZksPTYQib45cXy8k6vRX/TsnNmFm1sYBsqGre/8+BZUViiULzzqzzZ6EadWubA0uMz3wK2v0lgmcPyFkxDncTcpKstlEbUZYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jw5Zc6m/rOeR2ef0N+JkcSXJjcmQoRYjovaww8Eqwpo=;
 b=aodubm4YWJaeg1qWODMgLTReRnrXZn12VQ7U/4GrxNGs1ZeGVUWhOg6J8TwsR0uPZds26Nqv3biwvEUcrMXdQEHP5dynKHcYQrdUVfE0MOQ0sGkYuvf61tVy99bNfzy6Ioo+kYqOyy9l3CanfmifMTYVMBA0t7KQ80QyBd/a4CA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6979.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:31f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 14:15:32 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 14:15:32 +0000
Date: Thu, 13 Aug 2026 23:15:31 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Vinod Koul <vkoul@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 00/10] PCI: endpoint: Add PCI DMA endpoint function
Message-ID: <ztn47y23ctbjrbkmgyyhc6d5x3i2lzz5txotpgtbjtcsvbsvf4@fzadsvt5fl4d>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <an2uf5mXzGq1Q7cj@ryzen>
 <zoed4wtc4oxiyni4o5qpj3li3cmlyy5kfutp4r5g4d63u52625@j6rvbbehjgov>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zoed4wtc4oxiyni4o5qpj3li3cmlyy5kfutp4r5g4d63u52625@j6rvbbehjgov>
X-ClientProxiedBy: TYCPR01CA0160.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 8669fa7f-ade5-4b8a-8b10-08def9455617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10070799003|22082099003|18002099003|56012099006|6133799003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	DC0QTesECH22sddSSfNKPoeZg8K77L/7BBZwBa4Rrm07nfTNttMfMxzwOdGXJdVBLJRLRfCRXU22J3Ol3iP1KVR7hYELvC5FnngV7Ot8DK6D5ZIKjfp8Ha2XpJyuCctWDbs70rs9Oj5cDcN9/FQ5MzO9m0m8++FLTukARrSHcHeef0r6RdY6GkrCJBNpwelYxMMDNeFzHlMlMcWav0/Ln0XMtiYpZzyzAybQUED0apsG+//BdYznerR8tgajaUOx7jqHlHsQTzj0DVYdNTPrFyGcxKQhseFackPfCh7CR+Wc7AaL+df3j32Hi0LY+uf2Jqbs7Gk/IirCG55d5YPIDdxPvEJTTwOaa+CaJJbpjOi0ckxvi3NAR04nNHbtqjdf8klwCRrvowLqsiRAaLnB6z3MzjzEv+SrF+++Llt4mKDINNbghZis2//pva+NXyDMFkO5gXHdJ3pAJr26H34ESIaxe/wg8QHy+Y1ucMnLF214LnOJL2lLboAthWiwUTIG8TUcD3ZJPGXJTu17yqF20RJBOyw0zJbVWCiFz6LnjyLcCcy/NpdGkettGpLe/XYWKUHIv4VbhrYwqumVIyLSWWknl9Y40KGGmpUnMIQEf3VC2tDygFzeSRww2uazMSiTWsvH/mHbPdTSe2hzjYT6pJqNZhhW7/IMxUGA3J2BDdA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10070799003)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1JOcUtrYWZnUzgwMHV3dWYzVlZlL2xoRlcwZSs3djVCK1dkaDBBcUt1b0Rj?=
 =?utf-8?B?aExYYndoNXdYbGhwRE5waytwWFUrc2p6QVo1VjcxeFhhNmRzWGxUK200Zi9Y?=
 =?utf-8?B?Y0tsT3NPSXp4OGcvdzV5N0NTZ0k1RmdUcXlNSmdhcTJYMDlBSmlVV0l1eVkw?=
 =?utf-8?B?a2JwR0ZFcnRUUU9sZlF4K2ZhUjdiUVB2ZjBYUEw0eTFlUG1iMHFhTUxqNWlV?=
 =?utf-8?B?NlhobWF2OE1hYjAxWTRTcU9BUVJsR2FqOUFyNDIwamhsT09QbE5DWmFOUzBU?=
 =?utf-8?B?TTlKdjMyYk1DTG5NRlcwMFFwWFIvYUZ3bmhQaW1WaWpocVJGckNVZVhDb0Vy?=
 =?utf-8?B?QzRuNm04WFRBMCt2VmF4anl3SW1mMWNCektqNi9OZW9FYThyZFQ4SldlekZI?=
 =?utf-8?B?eEF4amR4YmhobVpKd21UN09RdWFuVkt6VVlnelRiZ3cwdEpZU1g1Qk11aGtN?=
 =?utf-8?B?S3Yvb240Wm43N2xYL3kzK09GVW5aUFRVdzB3U1RFQnRYWHJNYVZUOHB0c251?=
 =?utf-8?B?ZTltemZqUGRIUm5XVzArQnF0T2tEOFgrbEFyTEZVc01OenlGdENaOWVaVGhF?=
 =?utf-8?B?eDgwZDNxcWJwZDBMYnFRMGdmZUJleVcwMnpjOVV4MERld0hhTVVBdVBpSEY5?=
 =?utf-8?B?K0J4ajFFNGxwZTZXRkxadjdDeG1QWGl2bzlkWkZQUVptU0NmQ2FxemZjTUcz?=
 =?utf-8?B?MTdsZC82dHlaeTNQOGFNWWRlOHJEV0RDNm1qd2tTWHBkUlF4b2JxQWlxbStn?=
 =?utf-8?B?SS9kWHZTNHlTZldMZU1MVTZsSitza2UxMnpUK1FjRFpqQWpjV1NlRWdQVC91?=
 =?utf-8?B?STVCRE9seW9WUHRxR2hIMVBidVpac2x4TXczQ2F1SVlRMHM1VTY5c3pmbFFh?=
 =?utf-8?B?SFRFb3pmY21kaFc0QUtJZ3dJUnAxbllvSmUxK2Zyd1dCZmxKYXpiU2JDNnNx?=
 =?utf-8?B?bmFoY3AwL3Z4MzNRSzN5ekJRYWVWNGU1bThsZUdlWWM2UTN0Y2V1YkhlK1F0?=
 =?utf-8?B?cGhZVzZZU1NCY0JNNE4rTkFTaVFvUEx4QnVWZDVuVHpkNVdPYmZzVTNvcy9Z?=
 =?utf-8?B?UVJ0cXdRc1E2WkY2Zy9YeElYczUrelBQeWs1dFRSQVYyaDQ5Z2QxUjMyM2oy?=
 =?utf-8?B?MC9Jd1VzM0x4OGtJODRxd2UwTXVhMmRDN08rQjA2ZTUzeXVpblNndXErcGty?=
 =?utf-8?B?cXRFZkNZaStKQ2tRRGNOaHpyNjFrVDhIRk5icGZDK1pOY2QxaEVmOGVOdjFi?=
 =?utf-8?B?M3lGR09CRGJ0NnJYZWlVMUZPeG5CNHFxRTNDYTc2UmRIb045TzFUbjV1eTdJ?=
 =?utf-8?B?UENUWmZySjUwQlo5SUZ0cWlheEhUVnkzNXFhZm9aNHFnNTFsMXdLNVZ4a3BX?=
 =?utf-8?B?Wm9uZkhRWTV2REF1K1NGZmZHcGYvc3JqdHdzTzRuWmhDUGMxOGJ5TjNmaTNE?=
 =?utf-8?B?T1JGY3o1aEthMFNWZk5ocE4vM01LdkZmaUZkRzFBTWNCOGJFSmlHN1JuUTZT?=
 =?utf-8?B?T1dzLzVqMEFlRlBoTzQ4Mk50OHZsb1VPUURzenN2aHpvUFg0RVlUZ0N5ZGlt?=
 =?utf-8?B?TzYzUitjS1hVT2tsdmlEOE8yTjVIeENlSXNZTzV5azFEc1R2WncvN0lSc0lj?=
 =?utf-8?B?NnkzRDc5a1lOSzNoNmxDdWlOc2I4VUJCNXZ2Y2FwcGh3Vk43RjliSHNzUzg3?=
 =?utf-8?B?cXhScFB0ZHJKRC9NdGNDZytDNmJralV0NytaOGNsdk05dlFKSjcrQWlvN2NX?=
 =?utf-8?B?bXpYZ2JDSDRkK0JVZU1ydVZMNnhNSjM2TGFjU2pXMXovREExVERJazgvQ3Fy?=
 =?utf-8?B?MkZoQnZaRE8xY1pSZ3oxQXFhNFI0UTFFQ0hjZjBjdjVtUnFjWE1qMFFETVJC?=
 =?utf-8?B?bHV5andPckc1WlhPVjJIQWRLa3FnLzB2R1dJemZTdE05YlVYR2hJSkswcldp?=
 =?utf-8?B?ZzMwdXBvS1J3Z0lHc0E4TCtQVk5idngxQ2RjbWowNmp3Sm9xUmJzbysyMUUv?=
 =?utf-8?B?VUNmQ2VrWTM3UENRZm40cTRPUWlOdEFSSDEvWTRNT3E1TlBlR09sL0pYN0o4?=
 =?utf-8?B?RlNGNHAyMjdDNVVUMHEwOU1JVlRJVGNXY2lrRHROWVJhZGs4QmtMeFUyazNy?=
 =?utf-8?B?cFJsaEdzSy9nd1hTUTg2ejNYbkVUNkNJNW5qV3dNZHE2QnQrc2wzd0l1TnFI?=
 =?utf-8?B?TDQyQU1CZStYSHBUcllMeDgydXVSWU16OVZzRlQ5ZGtzbFlkeE42OVovU0lX?=
 =?utf-8?B?VHkrUDBRZ1JGb1lDYXEwSUNXMjNPWm9JZlRkbzJmbVFxNit2SEFyb0FBeXlX?=
 =?utf-8?B?Ymo0YXdldDR2Q2YrN01hcEkwSklXODZnd244UnJJT3p6NUZyR2JVcWhXWmVt?=
 =?utf-8?Q?QwhJAHUKW0GjpsdsZ+fOML666T7N8mvkQUEzr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8669fa7f-ade5-4b8a-8b10-08def9455617
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 14:15:32.6562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrXaZ+AwsgEMvseDCULVpLRxnV8xR/xhvtG2f4Y8SS/v63MflV20l7HjML32jPZ0qjgZMV0S7hl8E4SapfERpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6979

On Thu, Aug 13, 2026 at 02:50:59PM +0200, Manivannan Sadhasivam wrote:
> On Thu, Aug 13, 2026 at 01:46:07PM +0200, Niklas Cassel wrote:
> > Hello Koichiro,
> > 
> > On Thu, Aug 13, 2026 at 03:37:47PM +0900, Koichiro Den wrote:
> > > This is v7, the remaining patch set for PCI endpoint DMA.
> > > Parts 2 and 3 were merged per Frank's suggestion.
> > 
> > (snip)
> > 
> > > One open question is how to support endpoint controllers with only one
> > > PF. Keeping DMA in a separate EPF requires multi-function endpoint
> > > support. Folding it into vNTB would work on single-function
> > > controllers, but would also couple the two implementations. This series
> > > keeps the separate EPF model.
> > 
> > I see all the work you are putting in and I admire the effort.
> > 
> > This is now v7. I think it is time that we close the open question by
> > waiting for a reply from the PCI endpoint maintainers' opinion on the
> > design before continuing. (I am not a PCI endpoint maintainer.)
> > 
> > I understand that you want a common DMA abstraction, that can represent
> > different (embedded) DMA controllers on the endpoint side.
> > 
> > But if vNTB is the only consumer of this, then why not simply embed this
> > DMA abstraction in some BAR exposed by the vNTB EPF?
> > 
> > Looking at the host side driver that goes with the (v)NTB driver:
> > drivers/ntb/hw/epf/ntb_hw_epf.c
> > 
> > The BAR layouts are hard coded, and it only supports three different
> > layouts. Would it not be possible to add a fourth layout that has the
> > DMA abstraction somewhere in one of the BARs? ('BAR_DMA' ?)
> > 
> > 
> > Right now, I wonder if it is not a bit premature optimization to create a
> > DMA EPF, if vNTB will be the only (ever?) user.
> > 
> 
> Yeah, I feel the same. I haven't seen an usecase to program the DMA controller
> from the host outside of vNTB. This feature is supported mostly because it
> exists in hardware and someone wants to tick the checkbox.
> 
> Though, I'm not against doing it within vNTB as Niklas suggested, but
> generalising it in the form of a new EPF driver just for the sake of a single
> driver sounds like an overkill and maintenance burden.
> 
> Sorry for saying this in v7. I've been meaning to say it, but somehow ended up
> procrastinating too much.

No bother. Since Frank has given a lot of feedback on this series, I'd also like
to hear his view.

I'm fine with either direction, and can revisit the earlier vNTB-embedded
approach:
https://lore.kernel.org/r/sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4/

Best regards,
Koichiro

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
