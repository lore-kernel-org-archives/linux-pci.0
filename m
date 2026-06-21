Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022139.outbound.protection.outlook.com [52.101.101.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF43D994;
	Sun, 21 Jun 2026 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782059300; cv=fail; b=SedgESgeLoc+4w0n/65dxWTPLVa3evu0ZZ9iCkb53tyVuotfff8722LY+fFTyf/P4m5KM8igopziwgcvBNGVyc0zbozYBC0+8oOx3slGcDaOI7iwyvoRlpNgTDvXRvM3APIoncOalVwtV7yNZYmh+pOybsZz4Avp9XpYwO6pylo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782059300; c=relaxed/simple;
	bh=lXoLNL8cgWN847ieFe6VI3+FjsQXU0gcJZfEZmMyIs8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=UdXx9h5f9V0xkFe/xZHOHjs8BprYwrv5C0nzWqyOoc5/V7CkcspTP07Xc3KEcqx9BFOsIJqo2Cv1LE50bm9RXXM7TyhH3oK0qcL1THxuYoNow7Wm3FRYHJskbdfbbOWHvvtg5iMCisXD6RB51vfW3Qf/G2tVNl5qvK5S2AlTPg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=HQIL8gDw; arc=fail smtp.client-ip=52.101.101.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="HQIL8gDw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpzC6Sf7nFQm9/coCPrhRp52DZNUFMxLxPD74tML0zDRK4NUDoCn3XjQj2g7xrv74hL+Y6XqBuVR40aUIrB8YyTC+4Bhz2u76+h2/gnThDQ2Qacs2j4gexuCuGEDwy+f8/M7/R+FwsGxF8MvPZANHtAjWrA2529X1pyYy1bI00Exf9MMqRvAKxQ58NnyGtRJLzdjk5iGR+U9rrCN9gjbN4A3EaltqA71ouwlc5XT9dHtUZD3YZ6jgb6okmw8AyaCKMb7imOwwawsA5LCMyTDCdN/CFhm1yqKVnSJaIIEzBDFGjGkCYSpdUeSwKp7LICUEH6ZbXcvwtSoRH5yQ2aWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXoLNL8cgWN847ieFe6VI3+FjsQXU0gcJZfEZmMyIs8=;
 b=Z91suzH0awSDMRZIy4r9h0Qp/gcFhM4lj0IsM33enuw6oEOkuuRgU5aQ+TX+PzMAZfoMNOVOBeXKeLgzeqx8aTPJU/3bhd9SOfnY/F04p8/gO0cGlwDGYovqCTuNyEDx59M9ym06q9jSZjOLWPtGDUH8+jitvCcp+WiLVvUZSyWusbzE6wPzsbLEkUmlvn/k/82pbt4R/ocDC97+a/pDohqeVccThGjp16k5PErgE8NJTI987dXPzOw1Mm7h/bHjx31NUXhnecX85R3hB05H9TSxLQMy69Q4XmSSkn2BeCNzjPjeXx7py8isb8+JmVB3R7rPwEUoOv13NdgaOwJ1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXoLNL8cgWN847ieFe6VI3+FjsQXU0gcJZfEZmMyIs8=;
 b=HQIL8gDwXlga6pdPD4WLbxp4k54dEaNyY/0U4hcJgvMsfrJk+naHXeYln682NtjMjXcH81ZzTxmfYGcFU9RRGxAKe08HddABCoTq18/Q37R++E2UGmITRI88a8AYp/Rv1MTqVWn0zEnYCJfBlynBnrfcPlbR/r9GSN+mxCz5puc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB6178.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sun, 21 Jun
 2026 16:28:15 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 16:28:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Jun 2026 17:28:15 +0100
Message-Id: <DJEVAQBVC350.1TA0D5TFVU0U6@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 09/20] rust: io: use view types instead of addresses
 for `Io`
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-9-1f7224b02dcb@garyguo.net>
 <DJAJ51781EOF.1Q2VTH6CQVXYD@nvidia.com>
 <DJAK39S4J6EP.2VY3R7CIBAPOL@garyguo.net>
 <DJEM4MAO7RON.1EC4OJM72BCNB@nvidia.com>
 <DJEUAKFVCM0M.3VV7G8AQRXAGU@garyguo.net>
 <DJEV166T78O2.22Q1ANXGBZNU7@kernel.org>
In-Reply-To: <DJEV166T78O2.22Q1ANXGBZNU7@kernel.org>
X-ClientProxiedBy: LO0P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: ef91fc13-c7f3-4aa7-bfe1-08decfb2187c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|1800799024|7416014|376014|56012099006|6133799003|22082099003|3023799007|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	BHSG++NvHNloLkM/XS9DLlWqaGfiTaquqqtjpAmjYVvp8x8RKqGLJs3JVXh6kFFe79RWX2JSPBh2AVAet2vLmrUd38PaYI7lFTRzozaI4qg3hACC780evic+/FCDJuoJfjxQg4zlqD6Zx3UUFvJgj1/fLyfPFMcPJSGTo6pTYJcUzeMhG0NwTBIfywIq7IlROshBDwpg47Q0EV34sG8CtZTJktILiu+61NA2VRQL04eFXas8QViq48I2acr+DG4wBV3k+RmjyruThauoNs23uBKpwzdyj5yGY2lp/6CzlyxWM6bEIGtT380ZBI28R7/jRxa7ULKHOX66tBJb3GW2N97UrVBzExaJx7MD+3QAjSvfeuwDIhxwekmIL4RjE4EXzD7ZgFbZmwEpNAYxzKWHaMkWCLlZirmZQLMRrVJdO4YGUTwywADORHtVx5yiBkyNUJcoOaKReRTtPuwIWA+XEw2+O/L79EnutsUW6QVaiDKgbaGECY6GWDElJVKff5FABT08x944ICsqHmdn6VxLYAvjGiO/875hP5t7KuDvQ4B5xryXhPiLS6ouqMRYRCpcmCTf4DhWi74hwe/sGDs58bQAykYHBb5CsJYJZkC+CIkGUmRij+xyiOeX6Gp6RHF8rM47TkPayb3shC2rDt2wB/Do1w2b0qsDQQgZzRK6Rr8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(7416014)(376014)(56012099006)(6133799003)(22082099003)(3023799007)(18002099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2tQR0k4cUpwZUlPbEJBalRuaWxDc3pXeXpmd24yLyt1RTJhd2RvZCtPUVZZ?=
 =?utf-8?B?ekdEQVBKelNzTVZpZVJlMG5DS0h2Ni83c0xMcGNaTENOZ3A4T2lWQXhwcDVE?=
 =?utf-8?B?WFE5MlVMYTZ5NnIxM1ZNbSs3YmdxMllYT1lVbEhnRzJpNm8vaGk2UEtvZ01E?=
 =?utf-8?B?KzdvZy9MYWs0QmVkNkdYdnB4Sm5SNmtTVFpMM29zelJKdWxpNmpXOE5YQjNP?=
 =?utf-8?B?VldGL1FuME81NkoyTnREckNhcjdwYkRmY2RsZHBWTDViT1gxV1JhQ1QwVEo1?=
 =?utf-8?B?b3VXSmU0RWc1MjJmeUpXcElaVEJLYWRQRmdrREpmTjMyNDBMTGVuWi9JV0tw?=
 =?utf-8?B?VlFTUkRHZGtOcytqTHZYWU5vTSsyZ0xoT1BMNFNlZ3Q2UEJkYmsvVmRFT3dT?=
 =?utf-8?B?NDBYMXR3K1VhQ2pOYmhKZWo1cGNHMXQyZGVURXhIWURHNys1SENEVDN1dDdn?=
 =?utf-8?B?UWtDN0hVODh0SWppMFZ0dk1iNkF1KzgzOStNRFFiYlVFNHlwNGloVENEd1Bu?=
 =?utf-8?B?cTlHSzR3bTlXRlZPNWN1WkQ5aVRWMDZ2WFFKZE1EWDZ4VndPOUV6b1lleW9Q?=
 =?utf-8?B?QW1LYUdDaGpPckk2Tllhc0MyUTdUVmc5aDlybWZnc1Q0UDRGcHk5UHZ5NnAx?=
 =?utf-8?B?N20yRXkvRllhVGI1V1dMUmJNWTVyTnc2NDd3ckJXZExYeE01TDYyZXg3KzY0?=
 =?utf-8?B?Nk52OHNRV3loRmphdlk5WlNEdFQxMllQWUNxYzVSRFFoTlpFSWpETnY0Ti93?=
 =?utf-8?B?cnN5YkRhdlVXbmhpOWZsN0Vhck5NcjNZZVA1Qmg2emxNTDVZTURBQ0V1YXhR?=
 =?utf-8?B?WWN3N1FGUjZpL0s3UFZXcWNXSGg2M1liUEhUSGxZRnA5MUlPYjRrOVZ1ZDQ2?=
 =?utf-8?B?YXVrSkhmUWlqM2tMVVRPZkdrMGw0VTlpRXhaUlNxaWxuR3hraFZZclpBaEZL?=
 =?utf-8?B?R3JEZzAwdEN5ZVd1QWNDUHZDYkd3WnNBak5GR09GWDNKVW83Rjhvc0d1T2V0?=
 =?utf-8?B?RG5yQWt6djQ4cnVkTHVjaTV4R1BmaENvYUhBQnBtS1grUVk5TFFEVXY2NVh5?=
 =?utf-8?B?eG9ER3VhV29nNXR0MkxyVHZ2ZGhPcEFadnhrUjgzWjZqSDNKdUhPcUN3UVZi?=
 =?utf-8?B?emJ3SkFPTUlIUXU3SG1pWFJNVmtuUDRsTnVZaXJOWDBXWDlmalFFa2luOGRW?=
 =?utf-8?B?QytyMjBxMC9TWXpZU2p2dkFXdWdndjFnajAvcS8vendCc1RrUXlxTmxRUUls?=
 =?utf-8?B?OGkwR1hlMURUQm1hT2ZjQURTaURxd3ArUHBOaFVGMFZJZExwSEJMa2hYdm16?=
 =?utf-8?B?YUhjRVZBbjFtV2kxQUNpVGN2UzNuTzFaQUtwUGw3WmU4RW1VYUR6bUo5OTkr?=
 =?utf-8?B?Q29qTkROOUxvaU5VWVprZVBmT3d3ODh4UU5obFppSE1ORllTcjBoakdyOW16?=
 =?utf-8?B?eU1uZjhUODRyYmtkODBuU0FUR1ZpdWlNRW1NKzc1VTRoYklSZmtybDJsVFk0?=
 =?utf-8?B?bUpsTE5NM0syczYreWFmc013Zm1Tb1V5WEU2WjRvZmlLKy9BL2hER2RMbEwr?=
 =?utf-8?B?STk2ZVJyRTNQZXl5NmYwZmd6Q09tVUI4YWliMCtCVW1uR081WUkwa3VlOXRP?=
 =?utf-8?B?TmkrMVU3UFBSbHdvOUl0cW9jeEJibWF3UlBjNFVrUFFCUm05TXMvOTN0U1hY?=
 =?utf-8?B?L1YraTFYM3NCLzJVdlp3cHBydG5CYVdtVHN0M2VUcnVFME9LR0xBY2dMUnZI?=
 =?utf-8?B?aDZXOXZwaUtyWEVwWDUxOG12a0J6b0YvQUtWbGVGUW5CZzczanlIT0pIcjVr?=
 =?utf-8?B?ejhGak4xUzdlbWpZZVpzdEhrY3VqY1Zra3pxcnIrY3BRZlRXUnA3QzlUeEIx?=
 =?utf-8?B?bGVJSkovNFNpVlRETWl0ZnlYdEtiRE1IOGRCOXRGTjQ0TEMxcE5NeEtOOHJE?=
 =?utf-8?B?a2tZRE5LNUVDUWtxVmY0cEpsSlhmK3FIRThOM1BWTXZwYWpOcXdQSVd1YU9H?=
 =?utf-8?B?OGNsaVlPZFFEWmtYY282ZldDYk5Ia0ppQ0xOTEk4NGhZdUNZdU01R1FkVXFY?=
 =?utf-8?B?cURZSnVkdkxLc0VPN29zSFhkYVM2YU9sRHk1QnNaN0FFcU1lYm9xclhhRTZy?=
 =?utf-8?B?YUVRM2lheW5DR2JJNVMwc3U2cE1EZWhBcEJscEdPbkZpZnBxcWEzWUFEREpH?=
 =?utf-8?B?dGZJSi9lbHFPanpvdEtPUG96bVQ2RFVhSGg3UXlxam00TnlUbHdaSlVDcTlM?=
 =?utf-8?B?dWVldE9tbnFJYlg0S1owaXdJSWVHY2J2SzZ4Z2o0V2lNempySEtsUHVkTk5o?=
 =?utf-8?B?dlRhL0FBRk9RQSt6ekFSTk16NWRKbnV5aGlmWnUvNFd0bWtGR29JUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ef91fc13-c7f3-4aa7-bfe1-08decfb2187c
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 16:28:15.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyXeR1cGO4wUyq9+vEq1Q/tkHTVhE7OEnUEO9melc3nedeDqUd7UnHgY4dVjbhCAHMTLZFnJ6MViMMnc/5GPFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6178

On Sun Jun 21, 2026 at 5:15 PM BST, Danilo Krummrich wrote:
> On Sun Jun 21, 2026 at 5:41 PM CEST, Gary Guo wrote:
>> On Sun Jun 21, 2026 at 10:17 AM BST, Alexandre Courbot wrote:
>>> As you can see, this lets a 32-bit access be done on the upper half of =
a
>>> 64-bit register, which sounds like it should not be allowed? Similarly =
one
>>> could change register types, and so on. This might not be "unsafe" in t=
he
>>> sense that it is still aligned and in bounds, but it lets the structure=
 set
>>> by the type system be bypassed. It could also potentially be a violatio=
n of
>>> the hardware contract if the access width is relevant for this particul=
ar
>>> address.
>>
>> I see no reason to prevent any of the case, this can be done by `try_cas=
t()`
>> API as well. If we need to take access width restriction and other
>> restrictions into consideration, then a lot of API cannot be exposed at =
all.
>> E.g. it is not okay to add `copy_read`/`copy_write` like the patch 19, b=
ecause
>> it uses memcpy_from/toio which is possibility doing byte-width access.
>>
>> in my opinion think people should be able to type casting without reachi=
ng out
>> to `unsafe` if it's not UB. Similar to the logic on why we have `zerocop=
y`
>> that allows casting between to types, these are "bypassing the typesyste=
m" as
>> well!
>
> I think this is fine as-is. The natural, ergonomic path through the API
> (io_read!/io_write!/io_project! macros, IoLoc-based accessors, etc.) lead=
s users
> toward correct access widths.
>
> Whether through io_addr() or a custom IoLoc implementation, reinterpretin=
g the
> access type requires explicit, deliberate choices: picking a different ty=
pe and
> computing a byte offset. This is not something anyone would do by acciden=
t.
>
> So, as long as the API doesn't provide a subtle way to do the wrong thing=
 by
> accident, I don't think we need to add restrictions here.

I'm still going to make this a standalone function to be used from `IoLoc`
functions only, given these functions are not intended to be used by user
directly anyway. But I'll leave `IoLoc` and `try_cast` as-is.

Best,
Gary
