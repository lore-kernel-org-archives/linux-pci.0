Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021123.outbound.protection.outlook.com [40.107.74.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1179238C0D;
	Thu, 26 Mar 2026 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514960; cv=fail; b=oFhhyPsOF1tGkjmabhaP5WuablhtxkvOKflg46zjlaM5VkJEdz11+jJEsX629OBFE1nlGLpv6Kt8yKQ+/YZ16RrvmhdW8rIVuh0eXREAoZGTPGT97XHCwgv3zpEwue1ggEQsfk6pqESyJz/QYcx1T6p4KloCSc8mId/4z9BgMOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514960; c=relaxed/simple;
	bh=cBZeqq2KQAR9bB/vRbUaeSGglwfSbQ+dIdoSzcGsH74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=egjcPwRs5lxFJAfii2D75yU8Ei08CQElJR8795yqZ36mL4XhEk5IdZjrWnVFSJSvmx8yCQrFrosKqFfQ8dU1PT0oD7jAF5rudAEg423rCbK2soohB8i+tTMoF0evJce2jOxNao6zwzXi7XcUXHHYalVshUY7n1yPZROeH+859Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=l4PINXoU; arc=fail smtp.client-ip=40.107.74.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="l4PINXoU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvmKRvrLRsGK13DsFWdmB2GVLV0f38EfQKsF07wdlmzoj5bPvEwD27W86PMSmWoNVhQpoDovkUpzuM8xTVFurAuRtn/VwGTQEPjUvxOApjFGJLGG/KZ1ZNxIDp3iF1v5XfOE1S7G9zqw/xRTjlBUcMyw77aPzEAMJvlOkaXzFn7X1UNjlpFlfewfKBhxeUVFQgFH4s/sESx5cCyYMtGFFLp9pZrVU+bfgm2Hypq2MB7B9JM9TXXyLKvsVmdmxcb8BZwJLRPq5WD7SSukV/oppNCFtcMqv2w9ZUboI2tBLyTv59fxV9FbT2tWTKcnZfdCzaRaBDTRAh3PmHigvfYJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bNseueBU1Qwie3AxHJj4ev0TJH+G4MI9JSJqFMrqM8=;
 b=w7YLVOFlm4LKzQ7SFE3iViQcrMTeNgKuQdf1cqIzZEBE8XbUhZSNJIYyb6zKXufjelqj8Gj+ySBx1Qa7yiuUt8Pkgebe5Ov4aEBxa/wE57vW51lomb/WPbr32FKSHhAv5oGd4MsvtxN67tBdcuVpMUuQn3sBqC+9NwOHWJ0+PINz57OPymFSOzD2qr0ykH1vhI4xzGgSNSkN7kVF41b6I0qSwdOj/qRdQzfoCwRSOuXCYPzD43tx7sjqc+iT4/7uHJ7g2tblW8KFOZWl3S2ksvjX5iPfLieoEMzT2E2UshcKeM1A2t7ixESfQQpuqfOa4CAqs8fbNwqiqjXCpW2CJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bNseueBU1Qwie3AxHJj4ev0TJH+G4MI9JSJqFMrqM8=;
 b=l4PINXoUqkVllfJBtgk2oQqFw+w6KEylxpXKOvFYGDzNxxvL6nRrlvrsaPIJUdR7klpkyeVqvtDuffcilP6Wy72T2lGIHZF20G65d35Z87iqijidNxnlYKfEH7uXglbnbZOmiq2mEtheOxJhXRwH82XlV0Tlgb601rMaZTByWJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB4778.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:13b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 08:49:15 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 08:49:14 +0000
Date: Thu, 26 Mar 2026 17:49:13 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, 
	Marco Crivellari <marco.crivellari@suse.com>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev, robin.murphy@arm.com
Subject: Re: [PATCH v10 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <i4jgdqzliz2mae6jnl5pycasjy4h5x27negpxdxabhu7so7vcs@mvk6qbkw3j7r>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-8-den@valinux.co.jp>
 <acGK6rUIyuJP6gF7@lizhi-Precision-Tower-5810>
 <ksr6hlcwmrkrgrql5jqhtpkaihsugtsztfhxxjbq3au6kz3ksu@mk7hhmwabgsi>
 <acOJcMt7E8PLHAD6@ryzen>
 <ec62kljt36zh2autlth5jivdqlojbpdo2gbs43ayob7hobcpre@bpos6hqyuwkv>
 <acQTxJ75lq4tkszi@ryzen>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acQTxJ75lq4tkszi@ryzen>
X-ClientProxiedBy: TY4P301CA0052.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB4778:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba840a7-b391-4828-3c7f-08de8b148ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kZFpkkSzlFgzUceQd5HalfofSUvV3q6BzQr2qzLGW7+xssB7wTjGTWjDPlDSmvi8jztqdF2NE53/Sp//FAj4H1Vj57h2V2i7aV3HS1RexhClgwRpMMUznQRWYesxxR6I6wsUzB0ytQegcVwsWzBLWZBrarjnKk3XNTXxz7jBpWbSxP29pLpmzaLQDEd6ob718fecufjTh/Ami+N7H1xIFqoBg/CfAKjBJvMRw1x370QRHvqf1nKWVDIH57HHZth8AHEmHDJaE2K9GckkzL1wQ1PcFSM00G519Ivewcy9YMV+I9VoUxy27TZD/RCo6CEwjNaYGiVavWXD5PnLvWqXpqLT0mC+XpP0Ra3omLXGaY5LnELRu5B6AT9LKjQypFfTWM2UDwHRZvWh1Y3eFnr3UZj/URwOGm0nELuuLAtac2fPOBgd0E4+kFlgZRfvyzYP1Xy4WYrY+zUYyUn6k12lYtIRf+p5tgo45uct2kCPop7kIZRRkADf9/zO1vk1BNrcJ2W5bMKIovTfavd0H4Sc1QOVFQb/tFUBdW1nNnwdnv6x/CFSLUPCBkIzuRe+jBPlgPcNywpz/CDbMdEdk7yXjI+jQMwZN/tgezlBThgFSrA1SFUxhgS3IbqqxEdeqHWF0R8WazPCAw+oHHKzaI3V1uyMVnNjHEn3nK0m3Q7JNmBKSrKsGytoFfCyq+jfzXRlJAudoMNekyrXrfI9l+/ajs8sB5cUbgJYGmbY6J2Z5U4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TENDTUdGODdMOXk4TmNsM0VQRm5Jb1JpVythUTZ1cHlPVE02ZXNMZFdtMUI4?=
 =?utf-8?B?ZHdENlpNQUhIemZRNHpTbzF0R21OY1Q5bEgxYTJwVjFSK1VKRDB2NVFDc1hk?=
 =?utf-8?B?SE1pVk1VeUVoTURVUHhGbExmTGdWR1UyQlZvdFRyeWwwekdNVlR6WlBHSnBl?=
 =?utf-8?B?c2pSaDVlVlFwd1BlR1RIekI0VU5MZ3BoVllOdCtqaEtjSTFuMHo1bmgzcjhB?=
 =?utf-8?B?cE95VHJWUkdqTXh3dXhPY2EvU3lCREsreHRyNlFhcEVqZWthUjNubkhja1U1?=
 =?utf-8?B?bURQRnJsaHlEWGk3TDdGb0pNQjZ4WmYyd2xnMkVLbWxPU2Y5NHk2TmRMSHRB?=
 =?utf-8?B?bVluK1lkVFBDVnVwa3V0WVhWK1FQb0J5MGtuMEdHQlJyK2F1aTdrSjlOczRx?=
 =?utf-8?B?OHpCUFgvbHRTb2VIOTNhL244bUI4MWZ6dGptUFVtYi9la3BzcmVNcnZxRVI3?=
 =?utf-8?B?WHVSVjZYQ3J6Q0lrOSt6MWZkZG1Mc2hqMVFVemVKT3c4R3N3ZVU1blYvdXhi?=
 =?utf-8?B?cnJqRDVmTi9XYy9GNXRzdGlrQ2hSUmdTR1lmZkVkb096Um1wSEdLQ1l3NitK?=
 =?utf-8?B?WGlhRzFGZzRpdTBkZEViZGY5S05OT2szekRXSG96aTY0MTVPVEQ0bUE1OGho?=
 =?utf-8?B?alZVL084dzlBUnhRNTNLMlAwTUxRNmpwVC8vRHdYaVpmazhNWGxodWZSWUps?=
 =?utf-8?B?RTlPUHdwUWEyZGE2S3FHZFZBVlEvdyt5TDVTaE9zYWFoVFhwQnpnNllWalUz?=
 =?utf-8?B?czR5YXBHK3NHSU9hcWd1UjZxUkdRbVQ2dEJHb01JWEs0R09UcXUyeU9Hc25n?=
 =?utf-8?B?blVoQUJIRkE5SDVsRTNpTHJpcVRYSk1QUUNNRGdpMEFmbGRVc0FkM20rTmU2?=
 =?utf-8?B?eldRQlRFZFc5eTA3Tm0xeHFHQXkxLytvWEJsdVhIYmFRRHpmWUJuWERnVmxy?=
 =?utf-8?B?Y0RSRFNJODJDSDRwb29pNjBZWDV1dVBoY0I5cFdqa2FTM1RPeDdpanhxa1RY?=
 =?utf-8?B?b1JsZkp2ZGRaTUlZa1Uxc2RjR2JhL0lVZHJxV1lieTFhNkpsK1lDSDd0dDZW?=
 =?utf-8?B?czg1d0Z5ZEIxaU10U2gvMnRubWZGRHVYbE95YTVWcmJBZXEydXUyUDV6VGcv?=
 =?utf-8?B?Ukh2QmZsckJOcXJ4NGtIY3ZZZUNjdzBGOE9oYVY0QkM4enkwWlRha2UyOVBS?=
 =?utf-8?B?MzVCVHozcnhqYUZMQkZGZHRud3k3U2VldFJiR1p4WFNEd2Q2RjY0WVRPSWxB?=
 =?utf-8?B?QkFDejZjMGJBVzhMR2tnSTl4Qk9VQzZ4Z1QvbElOdFpwTlNqeTIxNFE4eWtu?=
 =?utf-8?B?aGNhQmtrRHVjMm5yZ3gxSjFNYnJxb0NoKzlhT3V2YWQ5VHVlSTdCMytyQ3BE?=
 =?utf-8?B?WHJ4bzROQ2ZQYllzYnRjdENaQThoVzAwS1U0eDNvSHpGaDRXaWUyOFQ2dFdu?=
 =?utf-8?B?L0FOVkR1WHVYWGUwWE51aGRKbUpjNk5PY1dORi9HZWRBejliQTdwKzZZZXlI?=
 =?utf-8?B?MUJnWVhKOHNBV1dPdU13VnZNR0s2MDczV2hqV3ZhQ3FmWUNiTDBmU3FFb2Zo?=
 =?utf-8?B?bFVwcGQzckZ1TDI0aERtYXptTUh0Z05nbXRIVUQ2WDI2V3hqdkNna3Y5T2hE?=
 =?utf-8?B?NklaOUxRZzh1Q09HSk9xVTdaaVlPeEk3ck0zZnU4MTZ5VVNEano3bTVKSSto?=
 =?utf-8?B?cXV3TVNLbXc3T0dubW5HR0dnd0M4L3gyazE3QUtrV2lTQUNrZUNDbkpQZWtE?=
 =?utf-8?B?NzJTRWovaGJuVjA0eVRiQkNVdW5WTU9EeXAwYkk3ZkdnTVlMaUQ3cklSSVEy?=
 =?utf-8?B?alJoQUhjemhFb3p2KzFpWS9TQ1JWcTAyN3AyeDJPOXQzT1R5cEpoRHlNWEIv?=
 =?utf-8?B?QVpXbHJYbEYwQS9MTDZvRWZtbHdqK2I1VnFrNWs5ZGV4Yy9qd0lodWNoUTlE?=
 =?utf-8?B?SWk1TzByNkNYSlhNTENrOCtOQ0Y5RkRpR1Ntc0MxZW1jSHE2Y25GWVFoSFlP?=
 =?utf-8?B?UzIzbFJaUzltdytGdFRmaFJ4TU10RmdKYUllaW1TM1YybzBJZzc1MTE0ZFhF?=
 =?utf-8?B?eGJkODBxUmFXUC9EVlBpQUkxTkw3OGFKNHJMM2NFVjlUNkc3SW1PSXZKRWlS?=
 =?utf-8?B?aXk3TldpaDJMZFVkTWRZemRUZVVQd2pGZkVvaW1pUW02QkJhZU5kaUVTSmF1?=
 =?utf-8?B?VEtsb2d5OGFZS2tocW9EdHlnRWMyK2tTZ3NncFg3WWhVMFJpczAvWjFnTXBZ?=
 =?utf-8?B?VVZSMG9vM1lvV3JIWElkSWg1WUwzWTVlS2pyTHR4eHIwdDFRRDNCMHM2Tzht?=
 =?utf-8?B?RW5rMW5YSHVhVzczQnc2OUFGN2NKQXptZDllbU9ldDVIZHRZWGFkQmt4NUFB?=
 =?utf-8?Q?axoOlPIZsDMUjyOc5EBhqTRrdzG4Ax5IgdKAB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba840a7-b391-4828-3c7f-08de8b148ee0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:49:14.7289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM5rFZiCkTKJ39uQv91LoV6nK5QpDdN+QX+P5Wf0xpx8CECbI1pvDrWCeVVghBWNScX09x+wKU/S7vojbUgk/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4778

On Wed, Mar 25, 2026 at 05:56:36PM +0100, Niklas Cassel wrote:
> On Wed, Mar 25, 2026 at 05:43:58PM +0900, Koichiro Den wrote:
> > > > > ...
> > > > > > +	 */
> > > > > > +	if (doorbell->bar == NO_BAR) {
> > > > > > +		phys_base = addr & PAGE_MASK;
> > > > > > +		off = addr - phys_base;
> > > > > > +		map_size = PAGE_ALIGN(off + sizeof(u32));
> > > > > > +
> > > > > > +		iova_base = dma_map_resource(epc->dev.parent, phys_base,
> > > > > > +					     map_size, DMA_FROM_DEVICE, 0);
> > > > > 
> > > > > DB should write. Is it DMA_TO_DEVICE?
> > > > 
> > > > Thanks for reviewing.
> > > > 
> > > > The write is initiated by the peer (RC) and lands in this EP-side doorbell
> > > > target, so from the EP side this is a DMA_FROM_DEVICE mapping.
> > > 
> > > I don't understand.
> > > 
> > > If the RC side does a PCI TLP write, the iATU on the EP side should translate
> > > that to an AXI write, no?
> > 
> > Yes.
> > 
> > > 
> > > If the target address (doorbell register in this case) is only mapped as a
> > > DMA_FROM_DEVICE (read), I would have expected that AXI write to result in an
> > > IOMMU fault.
> > 
> > My understanding is that the inbound MWr becomes a local write on the EP side.
> > Here, the EP controller needs write permission to the doorbell target, so
> > DMA_FROM_DEVICE is intentional.
> > 
> > As noted in the cover letter, IOMMU coverage was tested.
> > 
> > > 
> > > Is the IOMMU really running in strict mode and not in passthrough mode on
> > > your platform?
> > > 
> > > Do you get an IOMMU fault if you change this code to DMA_TO_DEVICE ?
> > 
> > Yes, changing it to DMA_TO_DEVICE triggers an IOMMU fault. I've confirmed this
> > experimentally. This also indicates that it's not passthrough for this mapping
> > on my setup.
> 
> I still think it sounds wrong as per:
> https://docs.kernel.org/core-api/dma-api-howto.html#dma-direction
> 
> The transaction is a write from
> PCIe bus -> PCIe controller iATU -> internal bus -> IOMMU -> PCIe controller
> (the same controller as initiated the transaction).

Yes, I think we're on the same page about this path itself.

On my R-Car S4 setup, changing this to DMA_TO_DEVICE consistently triggers an
IOMMU fault, so at least on this platform the local path used for the doorbell
mapping is IOMMU-visible. That is the case this dma_map_resource() is intended
to cover.

For that path, my understanding is that the doorbell access ends up as a local
write on the EP side, so it needs write permission, hence DMA_FROM_DEVICE.

> Would be interesting why this is not working like normal (when using buffers):
> "For Networking drivers, it’s a rather simple affair.
> For transmit packets, map/unmap them with the DMA_TO_DEVICE direction specifier.
> For receive packets, just the opposite, map/unmap them with the DMA_FROM_DEVICE
> direction specifier."

I think the closer analogy is RX: the data comes from outside, but the device
writes to the target, so it needs write permission.

> 
> Pehaps it is because it is the same device that does a write, that ends up
> writing to it a self? so source an destination is the same?

I'm not sure that "same device" aspect matters here.

(Separately, for the DWC case, I'm also re-checking whether the embedded doorbell
write should ideally stay on the native TRGT0->LBC->CDM path instead, which
would be IOMMU-invisible. I don't want to overstate that point yet, though.)

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
