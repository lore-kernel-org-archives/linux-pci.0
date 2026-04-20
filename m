Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021134.outbound.protection.outlook.com [52.101.95.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A331A575;
	Mon, 20 Apr 2026 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776680698; cv=fail; b=jAGtiMMD+UplTmURzIEyy5Q4C6JHXIMrXFjFkW3UgU8E27sU5EO2+Q9PJwzq0YBSCWh17WH5xYsGrZIYHihPZAzJECjjBIKTH1IAvtptu3oDfmavF1BrZTuARq3LGg74TuiDNR6eEhrBwGcXryQ28Zo2eWmh6BpNtGq/ut0DWw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776680698; c=relaxed/simple;
	bh=Kx0YpiAYOxI39bwY9XXm5I0imKDzKOKDldrH0uXo9Zg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=LqebEidWi9oVhZI9NWZorN3otzsel4s/y/zflpO4o7Jce4FSR9ZfbFKJxOcHd8J+JkUs8vXwtkKnEP81p3c3w4iV0gtPKwo950lFue7XRBBn3jk4htcK0x5kgvicfbIGUkhpG2B5AVvlwxJPAFb/Vg2eGrJHbsMrl8lCq2lLYsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=TO+eo1EP; arc=fail smtp.client-ip=52.101.95.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="TO+eo1EP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+e3VgqPYj/8ZJexKXByx4/YN7AP9W5bf7KRcOU1TUSxze/cPTseSucOqSt9Wx3xD6lWxQ0a/0UhzAjl56rxaeP8Cj1w1p/IUMcmIOCdT9bt+OTd1mdUZLmjvcooQjdoGOuNgAipmoUH0dvzfVkivlvP4eVjyJpDpuszrwLTzoyoPKIbcPbscc+S6LRJzqYicFtef71WbD6uRumDVNQrSw6hcbkrd80u0av/4q1yAzK/Kn4OTjBT7xKRfR862m7IO1Dr5e1arF5RBl8AbXayClVNuBG2nkwvWU9tfMkFwkp93628xC1+kpzqUB8opE0DVyuIGUJM/bIxvloeWh6Ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y7sXIF41nzVVgMCFA6Jn90z/YF2G6uLiBg1wUl89BE=;
 b=Aiv3mvUWs/oTkVFneYG4tANBbTMK7sI5Zbz1X7N7moKyB1IGcjdf5+Y0nQQOeItIw6/GYVFebAUiiLFNFzrZfruDOr2+7PN7u343UZxiFGmRGwSaoSMwCoxuWy9Ge0nb9N8ScAfGt0FOOiCMeAbQyCz0Wxns0rqhnL7+FGBtSV4hh5t5xROLs0e/ftILYZZ4DNq/9Wk31iWY4kHc6oZTZx3jTwyWxjO1NNiNvoeLYgyS8V3efjIyMWq3ot0wNRhhP+/gMj+Z+cj2E3zp7xSxyzJmwoX8hd8Bz2Uw3LA/SkaHZcwL1kzvjrgmjCQme0TY1yU69bh31XUwaSjsbkUGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y7sXIF41nzVVgMCFA6Jn90z/YF2G6uLiBg1wUl89BE=;
 b=TO+eo1EPQiErcbarcrQsaZEIjIv4mWCWwx3+fUSv6ylAWpvxUTPSlTviipUJu4z30jSD7S7a1IBNQBWPSXexwmdOg7Q9SseOcu8Iix33x5Ll3ZIxhw+bvKncBHWEafOaJB6bSX4wG9/2aemuKnXMZDQzItKfDEW9vIkbCFNvbbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB7043.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 10:24:53 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 10:24:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 11:24:52 +0100
Message-Id: <DHXWQQCC1T7P.31L43LB99DEOX@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <kjaju@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v3 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260409185254.3869808-1-zhiw@nvidia.com>
 <20260409185254.3869808-2-zhiw@nvidia.com>
 <DHRTUAF52GNI.1J98TSAG1LS6Q@nvidia.com> <20260420131356.189e7209@inno-dell>
In-Reply-To: <20260420131356.189e7209@inno-dell>
X-ClientProxiedBy: LO4P123CA0172.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: e12e9f60-aa69-43e4-3ba8-08de9ec70f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6QdDwMT6zzv4Uc8otmWHaNq8zlSWD5kK9jxLINHyLJcNMOrplm3MCw69+MfbuL9YS36Dqo3pw6dLKnRm/yFkCV6ftEA1f0JanHyX9n88U/zovc1wb+SJGsMff9YGjftke/CBUfNbbIbN7glJEBkdLlKXj/WTAK/u/9urkpnsCprarECitV6BEO5gaxerZawwayJvnb7+TdjIiocamXnVXbFVoy6DNEbQfGO/p4rxAfsIKpMTZjG9U2I8VUldp9X1poa9YZMPEWK9G7By+ySQos/+oayRP+S+H85hguiH1/dVgm47shuEzo9DlZhD80R7tGeZBzAKZKCAPBgqIzFbdiaWB6beHXLeN0LuKJMFWPv5jwE2BT5Zc1xycv84szN6aJsgmnIkYMKW8VN1f/7Ox+hF7gsmIVVmhVK4hKQge+DMhNzeJDmswGDos8n2mixowNox4RMVmcviBCGAexDoDoC/N++4trtFwsCrAGPvhSbQrKrv1xXawiloALsND6GNytD3pk6BgHikJi+8ljk3PXOGa5qP3jAeLY8MQWU7xbS6caJTqsLfaJPYlZOHNFM4vXDaOYTIVeRqR2ETzi/2MwlmgzO5td3N1Ufoh43AD+h938EikaTKO1kTMkrgvuuvrmS9EJHT9Vwa74rhDM/3a5eWo/hPGiP8ptdPw/+no+GIFrOiMWmtzJxhiaKvxm7Cw9B+rTuSdTfIvOyIaVp+mxfihSMV7vsV0GzCO1AgH/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEhlZ2VOOWdaaUFLN1ZmVUlGa1dSVHE2eW4xbVRrZEFLL090TGdFNVZGc2N2?=
 =?utf-8?B?RGR3UGcwblhjcEJ1V0VaTmJ0bjR6dTFQUHE3aERhcEhjRXQ1bzRaVEhOTWN1?=
 =?utf-8?B?NXlBTllFMC9oam5KNm84Y3ZCWTRBQ0l6VDg3YkpJSzY4KzA4MTlXQmlWS0Ns?=
 =?utf-8?B?bmVoeEJ0OXQzRTZiRHRsOUdMSnZJOHplcVpNL0FjaFhPbEhkcnFEa2p1ZHJU?=
 =?utf-8?B?WkVUVFNaaFA4QUs2Q2NlVjUyYlZodjZOaGRoZkwwY3Q4NWprMTdVQVlESm52?=
 =?utf-8?B?SU4wQ3h2Z0ZESXZEZU5BZWF6Y01nU1N0SHhCZjdHdWhyTjFzZnU1cWJSd01J?=
 =?utf-8?B?dDZnOWRNRDlDUmZ2dzBGZTljc1c2VUFIOGVQNFBzZW53Y05naVhEWFQ5c2xw?=
 =?utf-8?B?eThPbjBta3lkZ3dwL2hBdzdYWE5NVFc5VlJ6SXlYVkdycCtwdThPdU9PTHNw?=
 =?utf-8?B?R3Q0TWpqV1hCZkFKVTBIazh2ZzRTSE91VFFPZk9LZ3lGQllBL250TmJyb2px?=
 =?utf-8?B?SDN0UWdTSnE4bTFlSldQMkNBdG8ySk5NTkxNNSt5VW5EMm1uQlZIdkJCNlJZ?=
 =?utf-8?B?VnoyTFZYZFkrNS83SGs5b1BSK1ZQOStobG9nZmFSUHg1bjF2S1hvS01KZ1pt?=
 =?utf-8?B?Z01NWmw4K3VZeVBlVVVlQnJyT2s2c0pQTUdGM2ZhVkZoNXpMek8rYXllcWZx?=
 =?utf-8?B?YUN6d0Q3ak92ZHh1bFNMY0x0cmwxUExaMTBkZEhJN0RwblZCQ1Bwc29yY1hy?=
 =?utf-8?B?Z3lWMml0S2RRQmY1OXY0NnBBeG5pOWZRR0FCRlo1a3JvRkNxOWNCTXJBb3ky?=
 =?utf-8?B?ZGd4N0l5RFc4alYvMXNMd2krbmNYWFUwRWUrS1JkQW9tQmwwdVJFMGZteU5N?=
 =?utf-8?B?aElJbkxFZG4wMVF6Rk90Zkluc1ZQRWxaVTRpdzI4YUUzWkdUSGdxYjFBZlM5?=
 =?utf-8?B?VzRqVXJiOGlrazlyRklQR1Iyd2VzSmF0YStHYUJra3h6cGRzK1dpSGdXRjRk?=
 =?utf-8?B?dExvejdHdzdqZTBEMXR4R3FGcExzOWVBSEhVemthZHo5NTViM0YwOWlDZ2Jz?=
 =?utf-8?B?K0FpMGs3bUJvZkNYOFpQTS9DVXJjY2xyYjZJNXZQbVV3cmhvc29qNktYcURM?=
 =?utf-8?B?SGJVelVaRFhDbnZER1Q4dVlwL0NqRzJORCtiaGszR0U2WGY4K0hBVWFrMWpv?=
 =?utf-8?B?YWFjejErMmtXbFBSMzc2RlhkeGN1c3RFSzZXNzJySmtSZ2dVWXZzcTdVVCtC?=
 =?utf-8?B?N3NHY05kUXVrTlo0cVpJalFUbk5FU1RTVnBTR2xCSndOdExFdWZYQmdOT3hI?=
 =?utf-8?B?ZkdJbzBoR0pJaVlEUi80UHo1RHVUZDJpSFA1QitqcWMyZDhTZXR0WGI1SWVQ?=
 =?utf-8?B?VWtlYkNZWG0vV1JJREJSTWVTUXdpVU5aN1ZmZVU3clp5NGgvOXlTeGt6QUR1?=
 =?utf-8?B?OXBWbzg4Y3lUdmVUNlY2VUQ2NXVzSE13SEZhM2tXai9yRjVsZ3BDZXhOSUtX?=
 =?utf-8?B?M1JCTnhkZjdzT0JvbGppYlpKa2FLRWs4NFZVdzNwTnBWbmdncTExUThhdGJH?=
 =?utf-8?B?TzdEbUkrU3lkdGdRWGQveVFHLzBrV2ZRdWJsdjRIdy9jVGpmY09JYmViRTh5?=
 =?utf-8?B?bEtrMEx4SEMxNXR3c3NhN1lWVzRsc2kwOGFjZ1JOWlpLNWFCOUxha3NMeStU?=
 =?utf-8?B?ckZmVUpwaGJWZHExeTg4RHI1ZVl1Unowc25sY1h4K1ZzSDFGYm5XbFlzUkdZ?=
 =?utf-8?B?S0FmeUhyS2treFVNeUdoampSOHdTYnFIaFF5eTVaOXZheko1MVAzaDlsK3N1?=
 =?utf-8?B?dzlrRExTYTNvdjFSSGJ6cUY2Y2dPTHEzTTB0dU5LYWIxdk9GQi8yU0M0S24w?=
 =?utf-8?B?ejRUSkRrYm9GVk1qWWo1bFduZ2Z1NE1JYmJPOTJkK1grQVJjYmJxd3pjUGVo?=
 =?utf-8?B?UjhobnpoNE9HZXl4N0lVcW54VDEwd3BWOHdsZzN4WW5MbVRua21UZTc5eHNh?=
 =?utf-8?B?T0FpUGRNVU9Ta2VhcDA1eXE3M3QybGwxL2Y0VDA0a1BkcXIrN29MdUg4K1Fa?=
 =?utf-8?B?TkJWeWhWTi9MMmk0Z1lDc2dwZ2RzT2xWUS9veHcyY2pnWjlWTVlYMUxUU0pk?=
 =?utf-8?B?eE1UVFJVNDRBRFl2ZmFSMmdTQW5PTVJ2RnFZSWNRRStSRUhtU0RCSDVkVEpZ?=
 =?utf-8?B?Zi96MmM2blN3MDBFWlNoVTlsSnpHN3FuY1o5OFA2VGkzWURBQVExNkRuM2xY?=
 =?utf-8?B?bGRTemlYSDRDZEpKOHd2QkxDL0VYWWhMQ01YeVQvdnRvSW5MSkRnYlBSWENl?=
 =?utf-8?B?NDB0czF1ZjB2SHpnakE5S2FMMUJGUkk1NDRNcFE5NEJKaDMwYXdxdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e12e9f60-aa69-43e4-3ba8-08de9ec70f71
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 10:24:52.8735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4a/9RW/xBGG8icX6kfGo0BmFOzd3Anv1NRXUibFdky22zTFEDAtH7frs+g1SURPHzTUFGd0dmvG76Mg/BMcEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7043

On Mon Apr 20, 2026 at 11:13 AM BST, Zhi Wang wrote:
> On Mon, 13 Apr 2026 15:52:28 +0900
> "Alexandre Courbot" <acourbot@nvidia.com> wrote:
>
>> Hi Zhi,
>>=20
>> On Fri Apr 10, 2026 at 3:52 AM JST, Zhi Wang wrote:
>> <snip>
>> > +/// An extended PCI capability that implements [`Io`].
>> > +///
>> > +/// # Examples
>> > +///
>> > +/// ```no_run
>> > +/// use kernel::pci::{
>> > +///     self,
>> > +///     ExtSriovCapability, //
>> > +/// };
>> > +/// use kernel::io::Io;
>> > +///
>> > +/// fn probe_sriov(pdev: &pci::Device<kernel::device::Core>) ->
>> > Result<(), kernel::error::Error> { +///     let config =3D
>> > pdev.config_space_extended()?; +///     let sriov =3D
>> > ExtSriovCapability::find(&config)?; +///
>> > +///     let total_vfs =3D kernel::io_read!(&sriov, .total_vfs);
>> > +///     let vf_offset =3D kernel::io_read!(&sriov, .vf_offset);
>> > +///     let bar0 =3D kernel::io_read!(&sriov, .vf_bar[0]);
>> > +///     kernel::io_write!(&sriov, .num_vfs, 4u16);
>> > +///     let bar0_64 =3D sriov.read_vf_bar64(0)?;
>> > +///
>> > +///     Ok(())
>> > +/// }
>> > +/// ```
>> > +///
>> > +/// # Invariants
>> > +///
>> > +/// `ptr` is within the device's extended configuration space at a
>> > valid +/// capability. For sized `T`, the region is at least
>> > `size_of::<T>()` bytes. +pub struct ExtCapability<'a, T: ?Sized +
>> > KnownSize =3D Region<0>> {
>> > +    config: &'a ConfigSpace<'a, Extended>,
>> > +    ptr: *mut T,
>> > +} =20
>>=20
>> This strongly looks like this is reinventing `io::View`. :) Even the
>> internals look similar. Can you check whether `io::View` can replace
>> this type? This would remove all the macro business and impl blocks
>> and simplify this patch considerably.
>>=20
>
> Thanks for catching this. This should be updated with Gary's patches
> posted in the mailing list. Will address this in V4.

I'll rebase my series and resend this week.

Best,
Gary

