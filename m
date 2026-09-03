Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020121.outbound.protection.outlook.com [52.101.228.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3A24CA78B;
	Thu,  3 Sep 2026 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448415; cv=fail; b=UfXYX2YtsJrMOOEeyWlZYLMotchKrCy7gOPNUzsqvGDWQ37rWZfaqv20k020COQdvH6CQY10B7RrurQANkI4d72oxnY+GzZaPxTXSfpWHdtEOKKd1KzA9Tc+W1QCbFma/+R1C3xXNG4/IKCjGeGm3vrGf21RPImn4vLWEzpQ/cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448415; c=relaxed/simple;
	bh=8G344F4k66XOltqVOhuwBmfpBM2ntNq1Fh1P/1Lc7qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bCNpLFLenJ7z/N8RsEUtwbDJB+5uX9Go62CFf1nxjbCU+GMWUsRbn/k5nqMXDJpr1Y67Cn/KjA24NPBlw3BHQqpB3Z3Q2QjP0OU14ObPpHZFXAFKmgNpyY3FIc76nNzjLNH2HzLtVl6TDSFDm5qI1bt+/hDV9s2nKCRELpsVWko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=H2n7I2FJ; arc=fail smtp.client-ip=52.101.228.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="H2n7I2FJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbeHf0r6FFFDcWZtoFMstQKcmcG0w0rkMAE9/3+qF8pM1z7T5Unip68djJRPD4BsssYze8YhmMngVB8njr6ZU0OL/hobKtWAlzMQIkpjRC8vuzWHf3yGjeaAjGTJuT/6zCYdVZcnuPzuJPi95twtQeQHOQPSvn0yLQpgqy6k3yT4uwnn9Lom/peMkRCXa+5D/CR/DhhfUmJlaCfC0q5RYVDolTCZbISX0+XfdgUIIM1t0kD0Rr8qpD9OfhQ0aJr3+pcPouuQJhPd+p7QgAx0wp4ofsVFs9oi+Bk9SFy53R3L6wp+2ptq7M9o2Jlnflecp7E0wW467P0lUmwUmsX3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP6B7v+tdQ+ru0KfgXzyT6jgBjssOPmQl3H5DiVqIqM=;
 b=c6rk2lqB0GEmNiCr6rd6kg/i8ZdtM0kRsVTwJ17DgnFNpeKwCICShFJxabiHw3Jri3ASpGjjj1STDd+p8FgpsR4qjMf5C4QIuRL9nxSmoh/1jdgj9YdDrvs82f02X342iK+81EgefliPm8UyJa/sbw8rFQ5Rq0kSeu1ksv8BMyHXhD4miUXquljfWrikXq2zad/Rvterq6AlGqy+cbZ14cIFV8b5yWqzNCtp3aqhKphLT5RkJs4TaO6UU9D6Uz6QHXQO9He4NbpPxd4M3GjCCaiKwumtUR3xjRfGnnnFUIH7ktRFhIguehN09SyAqRIOtvEB22x+j6EWUe06q0K/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP6B7v+tdQ+ru0KfgXzyT6jgBjssOPmQl3H5DiVqIqM=;
 b=H2n7I2FJLkjI2FXa/P4hWckwlYvHPztq0OCUf8+QXIoF4njwU6qocirsHOX6p4m6hUwaGQdF607UAVHDrKGjVOQsrn2INXfzJmbog1YazaLQVjvoIaGQW3VoxfYj5I0N/pRYYut1XVpcBAfURJWyII4h5QL8hKEzqEEou8DFTYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6797.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:33f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 15:13:29 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 15:13:29 +0000
Date: Fri, 4 Sep 2026 00:13:28 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v3 0/7] PCI: endpoint: Remote DMA support via vNTB
Message-ID: <gjvpfltamqvvgucmdz7scvslyuf65ditqpyuu6ktbqkctwcakc@5atq3vrxa6nb>
References: <20260831182657.329614-1-den@valinux.co.jp>
 <4k22ipcaw6hy3va2z6nd56zb35kbcx63tfgk4tyuz5jifd6a3v@absanor6e2vp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4k22ipcaw6hy3va2z6nd56zb35kbcx63tfgk4tyuz5jifd6a3v@absanor6e2vp>
X-ClientProxiedBy: TY4P286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b08dc6-68fa-4719-e374-08df09cde958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|376014|7416014|56012099006|22082099003|18002099003|6133799003|4143699003|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	S3aFB2bw73rvudGDiBfJ85otZmX5DhOHw/N+P9/Hby1JGkN3Wl0/dnNvR9kCoNPkqAdMbWjUNbuy7AzO+wKspf/s9zClKYe1mzgU3K6Uz9grR/uppH+juhl4Ssa34qIngi2WNg69hc6wvMNuCZOGRmkqS2doUkMmusWGWSpGd4QrEJfBpiWYPgLiwBQhFsHo7EY6LNNNceUZkWgi3Dt39lQoqYBEJI+Y2mfJjHrnd7mZu9M+KyiaavtjCK7p+wd9HZlws6HALXfrCjCijBA+F+lxTV2tpkKet6Ibnvrd2wW7at7y2VUPvPgTexg2TXsI19xb5/MMD5qovtNO8+jTxpCV6CLqh5ThclEuXoyU8Mz8HWAqD0JcDEeUb9VmlCsTqdywAILk3ofKH+FG2rU1FzOPXQ4ZQQWgsl9saLnozRq98Kmlq3P+B78GXWptFSKiEeDyJrQLOy/cZLBA2v4NsRZV/BLfz/DUsqBH9ETv193BLQhBepgjo4wxro2KYlg2fGnweaoZtmbQDrXxnK/3vGxe/BtzEF5URfQ+e5l8+fWsU+6JCFApIHy1em+Nz6xWTKyaXrEmW7MgKC8J97nHcYs4Whq9sM1uOwBWGCJagbbFGY4hlqIDFlngrkck7WYG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(22082099003)(18002099003)(6133799003)(4143699003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1hwTC9kakowNnNCeDZWbURlcGJ2RC9vT3V6SVloWkpJZGl2OXd6QUJGWkFK?=
 =?utf-8?B?YVJFRnpxN3lnSE5qcldsWHBPY2d1cDg4c0J1NWRFcE9yVkgvSStOMnJ3NjNl?=
 =?utf-8?B?SldiSUllNDhBdk9sVWk1VVhiMFNBSDJndXFWd0t5cG9OM2UxQjRQdk1mTGND?=
 =?utf-8?B?NVhhblU5N3FLWkVzbSsxV3N0NHp4Y0ptMmVsZWlMUEowbUVQOTlPNm8ySDVV?=
 =?utf-8?B?MHFzSU1hZHVtb2VKTjA0dG1MYU10QUw1Mlp3OXhERVlOTWZja0ZsbjdhNXdo?=
 =?utf-8?B?eVkrR0hLME1tN0pHdUV6MWVPMEVUWnh0Z0RjNzZnQjdlbG5aYzBsS2lSM1Y5?=
 =?utf-8?B?UG1oVlQvcEN1K0JYWk1NTTU3ZVREcmVEQjhYeVpwbmRrTC9CWERvN1Nsc1NK?=
 =?utf-8?B?RlJuSXROQkRiTUZTR25ISGZReFBGOGJrTzFmNjROZG5HYkJiZ3h4TE03b3ZD?=
 =?utf-8?B?MFJPTkhxTFlNZkY0WnllbUZvdGE3Y3VZWEhRSGpaSFBlSWtpRVJjR3IyUU9i?=
 =?utf-8?B?MTBKVTZhcDAwVUdJN3hqQThWbzZHRkg0Q09CdzRJcmJTc29VZDlVckVlcklD?=
 =?utf-8?B?amlNeW1nLzZSaVRLSEZ1Ylh4MUw4ZlFwTEFMRlIxaDFVOHpQRFRiQkRjMHdJ?=
 =?utf-8?B?d2xoZE1ORVlTMUZ1SHkrUGVTandrK0xoYlFOR3pLaFlBK3A0UDAxMzhQYzNm?=
 =?utf-8?B?bDBsK0N3SUtqeU02VXFhSE1Oa1JDaTBIYUh1OVRiRWMwMENGM1BlYlN3a1ZV?=
 =?utf-8?B?NjhIQXpuSjFtU0F1Rm10YU5OcjhueVJweitCMzhGVk5uNWkrZTgrQjNuOW50?=
 =?utf-8?B?N054N25CMXgvUGN5blEvaS9aTGoyOGx5TWs0K0xaVEUwZ3M5TVpONDFkNGo3?=
 =?utf-8?B?enN4RFZ1b2VZakNTNURXdWhTREVwZEx4ZGJ3ZnVVWCtWbERKeVVEZUhxMjVY?=
 =?utf-8?B?QUlCalBTdmp1OXBHY1ZRT2d4SWtIaXJpdVN6M0NlTlJWL3BnMUpWdVpURlEz?=
 =?utf-8?B?cHRRZnVyeU5pWE1YcjVodVRWUlF2SE5jWnV3RjN5UjBCaG04eitvRmJVZi9t?=
 =?utf-8?B?UzdnNnV5Rit6SGpRcVFyMmpIWWxQbFhKY2V4dHFFMHk2bTRqR3JiUmMwcWlE?=
 =?utf-8?B?aldISUg0QzJpa2JIOEpUZ2pRU2pPVFlvdzFjWDQ2clhXUEc1cFBsRnpRWTRh?=
 =?utf-8?B?cnNnT2ZFTzYrMFk5cE5leENIZ21WRDcxaWFYZWgveVlpalpxd0pPN1hxdGFQ?=
 =?utf-8?B?U2RCUGYyRTl4VHFYWGZ2MkhyYldVMGlaZ3ZIOTlaa0cvYjFXU1c0NERyQ1dK?=
 =?utf-8?B?REpzNmNkQi9HU25aeEVPNmx2UmE2empuOTZDOGlaZjdyMkZwSENVSGRvSTl6?=
 =?utf-8?B?NUd1R2c3TUgzQ3Q2VHQ5ZUxBWjB6YUdtMGFIbnV0OEdFSTFSZEdqckxqbGgv?=
 =?utf-8?B?YkpwbW8zOE13eGpLV3g3cTZTR0VRYmxzT1hPN25pMzBjUk9TWlpJUmsrSFhZ?=
 =?utf-8?B?cVhRUmJPdFVLV0pYdDNoQ3lFOHM1N0l0Zm5TQzljdCszazlhOVVzVXBwTk1Q?=
 =?utf-8?B?WThOR0QwQnJlYmllWExsWUlBK203VXR4NjQxQWsrTG9IOHpJUlNBNFQzZ2gz?=
 =?utf-8?B?SFZIVXI2LzJzby9QdEd0bnU5MFo4OU44RThvSkM4dXlJckQ2RmVvcjJJbk1r?=
 =?utf-8?B?MXlJbm5UVDhzREJUa285S1hoNXpqTlZ6OEY4RWVTVXdRTjF4V0U5NXAvRG1C?=
 =?utf-8?B?Y2hNaUx0VFdVVXZXUmtCVG11KzlQdXR5WHZkdkdGYWZjZFlFNFk1VWRqeUd6?=
 =?utf-8?B?TUlnVHBMWTVGOC81V1pUL1NidkRaUU5QeXV3UzFmRXU3aER5MG54WFlsQlBJ?=
 =?utf-8?B?TnNSMTFJanMyYTVFbHFueS9wck9MNnhERUVtQjc0YThLcFRrUUg1SE1qY0k3?=
 =?utf-8?B?L0tTTjB0bVhWVE1GTW1IMFlUS0NKMTdnSW1mZ045eFA0UDdJNks4OUVxcTdU?=
 =?utf-8?B?SnBuTjNxMjJ6c0twdmdJVkRmUVUxdllOKy9GV2g4Y2hnS0lYOGlMaU9RN2Iw?=
 =?utf-8?B?em5MK2E0L2pjOWo2WGhSVWlzb0xpMXBwWkFZcnZHRWVOKzBCYkZ2UDNzU2hC?=
 =?utf-8?B?NDRZbDBjY1pJU2VVWk54enhHS1pvbzNmK2o2YTBHRHhDNURDdjdUaS9KSy8w?=
 =?utf-8?B?eUFNT3JDUTFDU2p5Mkx6eEdpRitRUW50QmJ1R0QyNEN0VlNJbUJoeG1FS0hT?=
 =?utf-8?B?ZEx1Wmd1aTVvVVNDQldXKzZCWGJxMXBEdEdzVnpMWEY1OHd6N2xCdmdpYy9N?=
 =?utf-8?B?L0F4UEtEMnRUdDdaUXBhbldSc2tGNmFsTWZxTmxOZ1lqcWJKNGxZWUxxdW9V?=
 =?utf-8?Q?O4mcL2zEvg72h/7jVgY17J9Bc7NsJXKBYEWmF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b08dc6-68fa-4719-e374-08df09cde958
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 15:13:29.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PF0eBMbbJH4+KY9G5G/QhcbeROZVPJqKisvssxv2h9Zy+50vTyPHvTIBxRUUd960J6WNqkVcuE5kgZ9YQrBUpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6797

On Thu, Sep 03, 2026 at 01:43:45PM +0200, Manivannan Sadhasivam wrote:
> On Tue, Sep 01, 2026 at 03:26:50AM +0900, Koichiro Den wrote:
> > Hi,
> > 
> > This series lets an RC use endpoint-local DesignWare eDMA read channels
> > through vNTB. It keeps the export within pci-epf-vntb and ntb_hw_epf
> > rather than defining a generic remote-DMA ABI or using a separate PCI
> > DMA function.
> > 
> > On the endpoint, pci-epf-vntb reserves the complete eDMA read direction
> > and exposes those channels as a group. HDMA is not yet supported,
> > keeping the series minimal.
> > 
> > The DMA feature is opt-in through the pci-epf-vntb configfs attribute
> > 'dma_bar', which is -1 by default. Without it, no DMA extension is
> > exported. pci-epf-ntb is unchanged.
> > 
> > Base and dependency
> > ===================
> > 
> > This series is based on next-20260827 (3d83758432b5) plus:
> > 
> >   [PATCH v2 0/3] dmaengine: dw-edma: Prepare channels for remote use
> >   https://lore.kernel.org/r/20260828163611.2691264-1-den@valinux.co.jp/
> > 
> > The prerequisite is for the dmaengine tree and is not part of
> > pci/endpoint. linux-next provides a common buildable base for both
> > series. Once the prerequisite lands, this series can be rebased onto
> > pci/endpoint.
> > 
> 
> Just to make it clear. This series has to build time dependency with the above
> mentioned dmaengine series, right? The above statement is not very clear.

Yes, this series strictly depends on the prereq series, and as you pointed out,
it's a built-time dependency as well. Sorry for the ambiguity.

> 
> EPF patches LGTM! I'm waiting for an Ack from NTB maintainer for patch 6.

Thanks for taking a look. Note that I have already sent v4:
https://lore.kernel.org/r/20260903082327.2345602-1-den@valinux.co.jp/
(One more dependency is added as noted in v4 cover letter..)

Best regards,
Koichiro

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
