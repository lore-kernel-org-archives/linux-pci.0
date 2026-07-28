Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021113.outbound.protection.outlook.com [52.101.100.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127C043A7E0;
	Tue, 28 Jul 2026 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785263173; cv=fail; b=pi6ZeNnpGXUcHv8pNB21Y1Nrd50x4Xf8Umvyu1wgLKm3QWc5KcERNPxmMzf9mWWyRCyYXCOg5Ycq239rpNIINrbNMp91zja7RpYCTJeq4RPO4R8nQ2oIpnK0uSXG9l8NQXftvS+sEDSfshaPQqFifn4NWWfGXbhEWlaCJTixXRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785263173; c=relaxed/simple;
	bh=hsVfmV0Q78LE3qHzuW166D7sGm5Zp3/Mv7Y3yepwBaM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=R5ROaKTsqz0DmwVn6GRpJFiRPVH3Hk5GzWwrUqkyZ4Zy19DIXuMucB+BauTjpsH42zYoXb6eTDQFF3Hyg5nfpGhYn6O1GXmf/zDftyrE2/E65JHpLt0FSkiQNK6UUpwmeWYIvGHXJBoLNtFdVN0FqC0bQs1uaSMfyjE7Es3eTLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=lPV47DpP; arc=fail smtp.client-ip=52.101.100.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="lPV47DpP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fy2fI387JgSAV6dRl7rURzybGUm2UQBAtcNjCGR4nXX+0Az+k2HBwN92QQsuT6x70/d5QpogGv+pe1Xdm9XkPdZ0Fu9P1RVxTiywr6a0q7dVrzRT4CcScz7z7+8w5YzYsvfm/bm7UdVo8EtME+Iq4jCi458Sub1bkddeUtoxBuhA/kSlvH9DSJTB/Ffu7AgbM8tdqmOuTiJwI6UmXLcX68JCG0atdl5HFNfomZsJXznPSXH6jdXaeMFfRaLykW21W/VJezgjnVAOI69DwVKaS9XvzOxYy7iI8wTf9/rnyze3d1ZSJzC1SWLOOKjOVxyXC/aeGaaMxDnXVknoMdpV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsVfmV0Q78LE3qHzuW166D7sGm5Zp3/Mv7Y3yepwBaM=;
 b=HNsnOYCptczOT1h0LQFvEhCwoOAhSH/1si//y91RFx7aj/puQjoXk4D83mnEwWrHUHxl9K3qYXbmRVxrs10msaawKWjqM9Ri+fS3GVOqNCyCv6nfBdiU/c/MEbSOEHWWYwYrSCMNK+HflSdhLC5Pr9LUlj9tUW7Wiz+cY5ihVgIaTPrqCOKCMsWsFCXaYUsCoEUOYBxA1eKAX8tqIgZKTFMhMBkRZirWIkv3Rw+9iNJY7UzvYumwUWc2e2sCVQpL4Oj+z86mkKNFbVf80F0K0KQU/DGDi8FSaFFzw51+P3Q+xrLdd7SJnYuZd5X8OS5hq3Scf7Y61Pxc9RPtCOgYZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsVfmV0Q78LE3qHzuW166D7sGm5Zp3/Mv7Y3yepwBaM=;
 b=lPV47DpPkI06n5jkLwj6i5X0NUd50DL0EsLbxRLtMNYxMTUs0NvB7Fnsz4seJxTablZRNIjw/1I/K3s15IPpjansESn9fZ2W3gr9PmPC2OFXZMSGUrQhF7Z/ofSzyMa7hPk6uJfZp5/ollTCWNtLS+RZ4PSmEadF4iUWGdN7v98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8942.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 28 Jul
 2026 18:26:08 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 18:26:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 19:26:06 +0100
Message-Id: <DKAEZ4LDA10F.1RFA9JKBGY2CF@garyguo.net>
Cc: "Gary Guo" <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
 <DKA02Y5RE1YJ.2FGI97Z60X96R@nvidia.com>
 <DKA4Q5QUBUXM.1K6QS2QPXT12H@garyguo.net>
 <DKAASRCK3M06.G9XODK0T5AAK@nvidia.com>
 <DKAD64Q7CEQD.Z15OS6MRHEKE@kernel.org>
In-Reply-To: <DKAD64Q7CEQD.Z15OS6MRHEKE@kernel.org>
X-ClientProxiedBy: LO4P265CA0314.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b29ae20-5db1-45d3-4504-08deecd5b161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|6133799003|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2aU25Y+r9KXnm5eToEir21ZSOiHck69ecCTpSVUENqwEIU/0Y97SV9sCNS9F62d4givDLjyepf0XhUtM+MbD/Np73L3Dc/aU2t8diIwVXyDtLW6E7otHjy7Kte7TPtwZGZ6TycWfG4FRezhP8HHzSMthJqwvMgfjut9PjE0JhE4qmW4/L4b/eONJgYtXCoxbmXe5ZXQ3UDQMA+/8RVJNRkbIoU0mIpUxiP0JiR70YJ6LPrqq5Px0MKqUXkWE79TWLYDl17Dgb2vhavaurwUP8npYZg7//3RG7PEosjSoKiE0X7bbhhifKhbGbXdTXymr5FiAa/AaPdc1P0pzP7T8CsYRfKCocyByc59i3MQyaVIfPCNjwwEs8dqzj07C+iz3RIdk/anjp3dUA6gB/sRrO18t9Z5UYyIrYZ/cWLIw7nCCbUCZPf3Lb5zC1eXBUo7IDJFlRfXUEfGZMBU2/87DrPcIFLpKwztcKbIMS3XJoCeQrk7yzPCHZ8/xLr1OYN5yZtvGyPEe80qhQc/BYy15552ctazYqPtLxtPs/9m1B6rP7Bgj/edDRm+OcKdlGPIY8iL/XVOd5SqWfTbiMdAQiqQuosfQ9Fqk44XMXoTObVzyXXIOeeHxTODuFZ5/6QRIyE8Dp5Djlknv/JCz8XHq1y5PqE1ZyM2EIgnQSBcWLNM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(6133799003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnVBSFVrdXBOV2pSYno0M2x3UXJPMDNXcVRJWklLUzhoaS9LakQyMEV3MHBj?=
 =?utf-8?B?YXgvMGhnWFhDRzBLVVVodHl0cTBKK013N3l6dGswZkE3OURCc2Q0bmhPUjVS?=
 =?utf-8?B?cUNQaUlKblFpTmhlSGdhRHJlVHFqOHVHWDB1Q1dpMWgyeFBiMTc2anI0aXJF?=
 =?utf-8?B?NVdmZlZSZXhiSHR5MjVUWDVYMmlrMi9HWU5iNEZPbUozVFpIM3NzTGpzZHFK?=
 =?utf-8?B?SmNCV2lGaHFnZGhhUTRQN3FUd1Z2bFJNUW1KcXdEWVAwcHEwS3JubEhaaUdX?=
 =?utf-8?B?cWxtV3lmRVZoZkJNTTYxYlZYVlVVK0d6dWVFa2QyZGhRWmFmd3VJNWM2YUhu?=
 =?utf-8?B?b2dWaHNYU2xrYVdKRU82TFBEYk5STG1JSk5zbzRXZEJpU013L3hSSVg5cWEv?=
 =?utf-8?B?aU9qbnVTSG83RWFzWnNjVWg4d1ZDSUptbkV6TCtMTG45bndXQkxIY2ZuclVS?=
 =?utf-8?B?RlJpOVh0WnM5K3NOOWdUTnl4dlMwRVBvdk05U2ZHbEVxQ3ZMU2gzRVR3azk4?=
 =?utf-8?B?clk3VWlCaXUwT1BSeCtBRmJBSndRc3NlMDlXV2h1YVlFNlgrWVdubC84Tm1U?=
 =?utf-8?B?Q2hqQ1dKQmdUOXo4OVhjcmFkNGhHc0dPNTZqdEpUckgrRHoxOE16Zjkwa2NN?=
 =?utf-8?B?Q3U5a1NPYVlnVkNBVUhrN000V25adnMrT28yTGYwVFEvQWxiNlM5MVpCb2sw?=
 =?utf-8?B?OWlVWGZ1bjc2SmhIaUllbUdxU1R0c0Z2b0x5b0FvNU5GL2xpczZRY2tLV2F3?=
 =?utf-8?B?VFN4Q29MdVhFQ04wRE90SWlNRU9vemFhR2pWQ1E3R3l1WHV0dmpyM2F2Q2pM?=
 =?utf-8?B?Nkp4U1JndHd2cmZWSEdMUmwxNWJ2bkpPOGhNRGtiSDJhSnc1QUxraTJJbWtC?=
 =?utf-8?B?V2ZKbms2YVdCeWFMWU5mdFAvM29mR3BBS3ZXRTgyb0hKQmNVNDFJZjUzY1JR?=
 =?utf-8?B?c1c5RENiemVXTnVZLzJvbk9DRTdaSStucjBOMzRIZGRJc2FaeHJibUxGZmN4?=
 =?utf-8?B?clNPeWpkNzBjdXVneXh0R3pNR2VYelVPR1l5dE1uMXl0RWx5dTNFbzNTNTFQ?=
 =?utf-8?B?UEZiL0NLekpYazQ4MGpiU0dsTzlBa3RWL05Qc2x6Sit4cS9VOVg3OWxqNmo3?=
 =?utf-8?B?SnNmaC91ZGhSbFJaREFZbkZHS2c0eHpxbkJpb1VuRnNFMXpWUTBmTVQ0eDls?=
 =?utf-8?B?NktySEZEd3Q1YWwwRTh1WUd0V0ZBckNNM0JFb0VvejJzdWdmREZnVWRLUDZD?=
 =?utf-8?B?OUNlNUFGRWFsZFBHaWNyaXlTRGdXeFpzQ0t5ZlN0d2kxajhJQzFQTUtZYm8y?=
 =?utf-8?B?Z3VtNTlFYjdQUTR4NEk5VnlDSEtteDE1OC91cFhNWm5uZ01udzZHbzJsb1ZV?=
 =?utf-8?B?Z0t6RlpNaUlseWNNMk9PL21GRGFpdzg4RVo3TENWejdHK1lNY3VjbmNmWXFa?=
 =?utf-8?B?aGY1c1FRWEJ3Vi9LYy93Y1BrVTM2Y0FxRDlXTm9mMmNiWlRHNE0yQVk0NFY2?=
 =?utf-8?B?dWhHWjJFaVUya0lhMjY1SlFwck5YbXh0Skx5VzVrR2QrZFBGSDBXN0R4L2Fs?=
 =?utf-8?B?aXM4eGRsQWhIMWIxRGtpWW9HRkltTFo5NU1EVENtalRaajgraXN0dmQvSGNp?=
 =?utf-8?B?Wk9TZXVLeEpCYlkyNEdOait3V1daRHVFZDJ6ejgrcjBJNFZaQmtIZG50OXhL?=
 =?utf-8?B?L3FtSDVZRnhLd2hFTndpL2FvMEJwTU0rdVF3SElpNmRzam0wNTBkbncwTmo0?=
 =?utf-8?B?K0FHMm5kazZSZ0IvY3RaRzJtdXNUcWFZNkxaSnlRV2N2c1dRMzlxbzFLMVMw?=
 =?utf-8?B?djJjMkJ3TURRNk9VQ3Y1NjFYaWNrVUJla2t5UnpUemNaZ0crWFU4cHNHNkNZ?=
 =?utf-8?B?V05HM0VmQzd0cmtiRnpUZXJiTUcrR2M0NHR3NE9rR0VlN0ZVZ1VJcjFZZEdY?=
 =?utf-8?B?YkwxVXNUS2w0cjk0WmJZWkJ6Z3M2MnFnSExWTWJ2bTFURTJveU5hNVdNNHdW?=
 =?utf-8?B?c01IazlGRFZxd1JWQ2w1cjBxLzlSZm1BTk1mMmsvRWJzV21zdVByN0NwZjhU?=
 =?utf-8?B?Tll3VDUzcFdFd2tTaFNKcWRCRG1iNDIyRFlIQzNYVHJvY1dub2Vjc09QOGR0?=
 =?utf-8?B?UUhRNU5lSTlnaWZ6azR3WUFiZzZPbExXZ2lReVlZWWgraXRsZktsWFpkamZx?=
 =?utf-8?B?aU8wR2FrNGJrZ2t4bHp2V3RKLzFZU2hMV1AzUUw3bitkbzMxdTZUb0FmOGM5?=
 =?utf-8?B?ZGxZVm1QSDZQMjdBblQ4RDdqRUdqY1g4L3UrR0R2YmZRcXF0TStDS0psWVha?=
 =?utf-8?Q?33+rhvkqghmeKDhIcq?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b29ae20-5db1-45d3-4504-08deecd5b161
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 18:26:08.2204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/M17ELU5rfcTK6tznzJghe08rYWIQQjQzVq70SlUtYzCkHagriwT9wp4qBp3enOcRU6BhUWxKdxBClEfeizng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8942

On Tue Jul 28, 2026 at 6:01 PM BST, Danilo Krummrich wrote:
> On Tue Jul 28, 2026 at 5:09 PM CEST, Alexandre Courbot wrote:
>> Great, keeping this commit purely mechanical sounds good to me if you
>> prefer it that way (although one can argue that the refactor itself is
>> also mostly mechanical as the end result shouldn't be more complex).
>
> I don't really see much value in this intermediate change; it's not reall=
y less
> invasive than to do the refactor I think, so let's do that.
>
>>>> And I suspect that once this is generalized, `Falcon` won't even need =
to
>>>> store a reference to the `Bar0` (and potentially poke the I/O of other
>>>> engines) anymore.
>>>>
>>>> Actually I would like to push that even further and replace the
>>>> `pfalcon()` and `pfalcon2()` trait methods by associated constants use=
d
>>>> to construct the projected view in `Falcon::new`, since the projection=
s
>>>> are all constructed the same way, but doing so requires
>>>> `generic_const_exprs`. :/
>
> Yes, that'd be best.
>
>>>> We could make it work by moving the `OFFSET` generic argument of
>>>> `subregion` into a regular argument and enforcing its invariants using
>>>> `build_assert!`, but that would require `subregion` to be
>>>> `#[inline(always)]`. I don't know if there is another trick we can use=
,
>>>> if not otherwise I guess the trait methods are ok, especially if they
>>>> are only called once in the constructor.
>
> I think this is fine if, as Alex says as well, we expose it as another va=
riant
> of subregion(). (In general, I'd like to avoid introducing more build_ass=
ert!()
> if there's not much value though.)
>
> In the nova-core case it would be a specific workaround for generic_const=
_exprs
> not being stable, so a separate subregion() variant that is specifically
> targeted at this seems fine.
>
>>> This was definitely one option that I have considered, however as `NEW_=
SIZE`
>>> still needs to be generic so we're not entirely turbofish-free. But if =
making
>>> `offset` become an effective const parameter helps nova impl, it might =
make
>>> sense to use `build_assert!` for this.
>
> As mentioned I'd like to avoid additional build_assert!() if not needed, =
the
> turbofish doesn't hurt too much here.
>
>> Maybe we can have another variant of `subregion` that operates that way,
>> but your call. I don't see any obvious flaw with the current
>> implementation, it's just that the `FalconEngine` methods should not be
>> useful outside of the constructor eventually, so it seems a bit
>> superfluous to have them visible to the whole crate.
>
> I may have a slight preference for a separate subregion() variant for the
> purpose of working around generic_const_exprs, as it probably is a bit cl=
oser to
> the final solution, but trait methods are fine with me too.

I am not sure that's the final solution that I want. I want arg-position
const-generics which would syntactically look more similar to `build_assert=
!`.

Personally I think most issues with `build_assert!` can be fixed by having
lints, which is on my radar.

Best,
Gary

