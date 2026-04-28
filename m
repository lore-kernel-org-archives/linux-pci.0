Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021085.outbound.protection.outlook.com [52.101.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AE42E006;
	Tue, 28 Apr 2026 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380915; cv=fail; b=XxlxQopU7BbqD8ZhLoy6Kw0Jwa9XCnkuEu9g1NSgsapoHHwxYA6biA+w/ElxF2BAi/R0WKE0w6zq2sjs2fUPHtl1f0PtUSuL7o/zu4/Mcq22e7AajGPP74d7XKJnTu8kAoPlz7nn471YAghWg0HCLovjgegvnQg2f20v/+t7h+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380915; c=relaxed/simple;
	bh=/lOarKAQZ0B3zbiyrlRE8xG8n2UsnvRgzPpfcQN4jek=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=DX8n+747ryN9PPS80Sr/OY/5Cfb6Vp4ipr6j37bacEJjhSGPZ60xWbJB5+g2GhgSN4+lkbvxg/4++NRidx+ycUKmdewg3eZBYiO6lvw+lIcg2xfBQdkPgzgSv9IRccJzuHJCMrvAFAA+cS0l24nJHGtBWocAoq+OHdg4b6IcRd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vfXZq4WG; arc=fail smtp.client-ip=52.101.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="vfXZq4WG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmdVZ/7THt5+y9dNFIRAdm5h7naAR0j3+S6c45vvG4hP10YceOeQdyzr6xj/vGKf0jTjAcYCQitp2N/QHZ356zd3rK3KlEYeiygLIQOSczFhpMQ0WyQAAhwr0yLtfQqyw4v0OoqotJwrgdacvGZX9NQeBNOOH0kNphewTK19wN3+wxjzSBqqvgJeLaFjqOiEFhIAjP9IFi7NdTV4sy++UYG037z0w9anzKsHcnAm3hRuITC8naDHSX+Rxibul6HKeZLYLkvZllhCfmrjnoWUVIE5O7TSabVXjsiXzjiRyuMewcQ3uFP7s7NESfa/hv2hog3sjlR2dzHqxKxMXf4PLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUcRqAa9lbhVZMXo69nIEo85zdG1lw+Hn6b8QsUdB0I=;
 b=lZr5avVomgBJRh36G5DXhycetrJMnB4JAYzUvrWMuhj+9LzglEzNjzRx54zsXQ6E0WeS9aXcVkfJewpXB5Iev2iUh72ZpFlfdSlBaKrgad+AKDVMNO9kbW3a25iqHmzI7Ia0YMebI7PvbKgmQIK8A7uEW3iCwoK1tWF7EHGdOql3z6jyFIyQW7L6qm0QldoARotm2UbE4T+yOdgIGVoekTDu/eYtLD1Ya0dHim5pocdUHlM8vR6Yjr22u88q+Fy8XEggXeHwkRNLTJdvkAQTkugQi8Q+a2DMc4NXuHGqimHqcbEmUS5oFvEblCacJt/u1VgKBRiqR6acK+oJ+oOaSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUcRqAa9lbhVZMXo69nIEo85zdG1lw+Hn6b8QsUdB0I=;
 b=vfXZq4WG77uNnlekvwEvcYaf9cmDd56UsjWLEnwe6jRW3VeVPw2XAzDg3AWU4ShD1sXbPFQFEiao27JLrdO1jmYSfFiLC3vc1zLo4MlnAb2dY8WzpLWflLTeUHDyxpKqF+61ZGkPyrpedumGK87TIJO68rN7AXCRsSWVO8p3hs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8445.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 12:55:01 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 12:55:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 13:55:00 +0100
Message-Id: <DI4SY1NXU1XW.2VHPFEKIFBQVW@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 05/11] rust: io: restrict untyped IO access and
 `register!` to `Region`
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
X-Mailer: aerc 0.21.0
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-5-4c251c692ef4@garyguo.net>
 <874ikvqwyd.fsf@t14s.mail-host-address-is-not-set>
 <vYp32vOGPut322JQ-5jSBZQNd6eXvnOvg8b6YDhYcYzBqTBVUvSajCJng33oXSQ9wiMvb62VLERzLYSa4g2pJQ==@protonmail.internalid> <DI4QT2U1098S.3K9K7INQ86M0Q@garyguo.net> <87tssvp9sq.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87tssvp9sq.fsf@t14s.mail-host-address-is-not-set>
X-ClientProxiedBy: LO6P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4e3488-16a6-4989-dfba-08dea5255c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|18096099003|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	TH8KbM8leSi2CWJMl00Z4868l7RitFAf3XZ1F1oYCOBdHuDbgT1muaQYpF08wOG1MzHDum8uJnUZFGQoulgH/hG+qa8fJG0I+b/B6YPlVta0slumLJoFZvx2/qkVDKrUsE7QLhPaJZ1Hsf3+q0Dj6VYJPla0Q8ovFZ0OsY7v6s1vnUNQHF/3lIgnWOmpm2TnAUtsFAsKJDLzR34gzd9DZ4DX4WuzZgAONXSsZxfd32HYUXmO/tuzB9oLCCv4bfxvn00ht7UVWt/5ROjy2916LFEfQcgvMNA1cE5bYAdyvhvO3SMzfAxP05Ca8pGQiuEF4gjY+Oqr7t9b6Zm9zlpyeYjU6FExUpux9Aa9qHL16jMf21tc+kJXuKKtDhaMRW76aVLJ+Si9qkCysZP6Yw0mBJYYQdaSh74NehU3qI35AXY57hodARsRh34nVnuAhWUbrqc7nw/miGJ1Mlfz9kf+H5XMaR3RhLhDx9q39q3ISV1z/96IfXBWttFs/3Z3B3qWocnpSB/vbjNt0jXHau9JzSqEwyz0Hmfsuoh8iWdn9YU4hiu/Zy4Z/wSZfbQtQeKTnb3b6/JaUaodhslt+w5s6KEUSWYDayMtpBJV/m2IJcxpjn8xaYPLnJgHar8N/gnPN2+DH6BYPg2fFfTiHvKgWWyaZgPEq5H91xQQnd8qZhpkJ7N7/oWflk62y+HcufQ8fyBW+C82udxDt9QbScTK929rZhZXHvOjpY0zkEm7IkKjndaf603+G6wMmMle/gxOOFXEfGWHkKvOlVnnq1FHlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(18096099003)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkltRDlUbFFkekt0ZW5xS09GRUZzRmJISlhHdUNaaStrS3BDeXk4b2t3THY2?=
 =?utf-8?B?RU9hTi9oZU5lU0JCUHVPOGxHeDZpb284ajRweG1ZOXRkVUxuZXFiWXFUaitq?=
 =?utf-8?B?cDBuOHU0emMzdVZpWFJqckVqNExuN0dIOXVRSkV3TzV5WEg4RFU1Skt2cUhF?=
 =?utf-8?B?d2l1ZmV1SjlWdDNzTGFVV1hadEtCZkdRaVBDTlB3K1E2VXVvRHp5dXhJWWd0?=
 =?utf-8?B?c1FYa3NWNWp5S2lGZExYVUJpc1lzQlhEY3FGWStYdWtLRThhTkJySzhTVnQv?=
 =?utf-8?B?SmU2MVoyWU9BWE1EZG1nUnd5d0hFajZRMEQ2RjlCcWxpVlhlUFMyRjRyZjJ3?=
 =?utf-8?B?bEZzb3hMNVZBM2wyUUs5NFBWZndLWldhSlMvZDlrdFJqSVVsWE4vc0xHby9u?=
 =?utf-8?B?TjBzbnIvNzEzY3g1NG1GckxmREE4MVpzZUVsd0pteHNuang4bWlOL0xiNGpn?=
 =?utf-8?B?MUFRMU5EZkJCWVprVHdUUzZBb2pZRGQ2Y1ltbnQ2WHE2YmpDZnJLWFhTdVcz?=
 =?utf-8?B?YUdCQnorNmNwSHp1cnNXZjNzS091cStWKzc4WGZFM1dQU3RCbnpWT0ZoRnVV?=
 =?utf-8?B?SDRjVncxQXAxVUFrUitOZXhsQ3cvY3NvbEFzZVFDSmVtM1pPaWpuK0tWQlRK?=
 =?utf-8?B?MG8vMkFNcCtMOWdhdlV1N2RIM1VHMmlTUlJPYjJ3RVJTWU9Xb0MxN25VVmtt?=
 =?utf-8?B?ZTFtVlJrY25NVmNnaUR2cDBxcVVLNWdMN2xrN1hveEdDMWkxRlM2a0lub0Qv?=
 =?utf-8?B?MHVpaWp3WmcybUZJNWsvRllQcW51dzdaN1RuSnYyeTlMYW9iZzFKSEh6dDdj?=
 =?utf-8?B?VkxHSS9UR1NPK0xER3NMa0JFMEpiK0JHVUFkQlVvZ2dRRFVsSjM2ODNDQ2Fa?=
 =?utf-8?B?c3p4NUthYnN6d0VKeFZQdXhtelN3WEFqU3A0ejk5VjJvWE5OWW5hWVVJWjBW?=
 =?utf-8?B?TDR4UUhMbXFFSVVxa2pMSFhsYjhJRmVDN09wSHR0MENNdWU2emVFanlQNDFC?=
 =?utf-8?B?ZFh2Z2svUUlwQWxYUm83cHhPaVZkSHJGMTN6NXo0MGE2WnZ1WUhFL0llYmdR?=
 =?utf-8?B?U0JRaGxzazJlRHVKajFDVi9tKy9pb0hER09xNnNiV3lmdC9rWkxMVjZISGVX?=
 =?utf-8?B?OEFwN2s4NXpkY1RlazQxcWRvTlZ6T2xnVzgxdGtpQVFreFpaSi9TNnhXRGJs?=
 =?utf-8?B?ZlUzVGw4Qlh0aDZBYzMvZGRmYkd0U1NPUTNOb0xuM2lzNHRIR0lKMlRHYktJ?=
 =?utf-8?B?azUzdWh5b0hNL2xUTXV1Ny9EaDlzSyswQlA3dnFoRDlFcUZMZGxLOG9mSWVL?=
 =?utf-8?B?aTJsSnVvNFRDY2UvKytZTUU2SGwzaFJxQndSNUh2YW5GZzJaZmhISFZFRGpK?=
 =?utf-8?B?cEEvcFRXWG8rYWRVTWhPV2RvN3pBcUdjMlNwS0RlNU9OQXFvQ2Q1eHNoWGcy?=
 =?utf-8?B?dHFKN1o3a1VxaWhrT242RGV4M1VralZRcmJmS0tpKy9CeFMvY3kwUFpuUDNQ?=
 =?utf-8?B?TWV6cEtQN0J2NVNwYWlmbnhnWGdNMHJUaGVkMWt5WjdJZXBvVUNWK3JCRENI?=
 =?utf-8?B?RHJSckluZDVGbVphaFBUN2dnWWJqZXI0UHBrTklFSFA4N3g4NmRmZEx6R0xT?=
 =?utf-8?B?MnVUbnUzOWZ6ZU9hRzFRUDd4UHBQVlRUK3AzN2ZGMDE2YmltVmpvaWI4MXI1?=
 =?utf-8?B?dVlHZlBPTGVzSG1pRDJSU1U1SkVZbGlJQ25TT00yVkdKejdhREhORzNnRS92?=
 =?utf-8?B?QTZ0UTdjdEpvTVVlcUJxaU92VnZRTWV2ZDZJN3VKQmFoWVJodGgzWHRMNjIx?=
 =?utf-8?B?TUxZaEIwbTI4L2dYOG4yTlk1Z2JKWUJKYjlyNnB3TmNpb2k1bVdmdW1lR2Fl?=
 =?utf-8?B?Q2ZFS3JrVk14L21sNjhJNFVyWmpkYWJmL0hSUkZlRkxNd0VkZkNCdUpJd3FD?=
 =?utf-8?B?RVF1QkZ0dDVKa3pCV2MvNTNxaVhGcGNrNTc1N0s4WVliL01hWGJybUhEUEpF?=
 =?utf-8?B?eVk4amtEVGM0Uml6OVRtRnhsRytxWEtXTjJES0VraXhsSTFaZG1xWWR2TWlj?=
 =?utf-8?B?SzRRS1o2aUp1N3lQckR4a3JZSitzU2JPM0Z6UzVaUktzMlp6TElQYWtndzB4?=
 =?utf-8?B?KytLc2RvZFQ3dXRXQzlaMjBXNEtEclNpNGRvaWViRTVWbFIyNFdKQ2owK054?=
 =?utf-8?B?b2pCV2hobzJPbG1mSDhBQXpnQ0xicU1NZHBvSU5tWGpqVUJwZ2dxbit1dEFl?=
 =?utf-8?B?WUZhVzZtb0Y5Qm9VWGNvdEcxeWgwRFBsY1RNQjczYUhJU2RaenJRY2JtK2xn?=
 =?utf-8?B?OG5hS2ZpN0JYdTRpU3NZL05yZ1JndkhLZ2J0SHhxNkQ2djZ4SE1YUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4e3488-16a6-4989-dfba-08dea5255c4c
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 12:55:01.5058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhbyddpRr6WhXK0RGNfUtvKSJC1JLxQs/z9Dw7G6whijDf+RMANW6iv7qtGjUCE2tEkl+KHktHct3PhiX52wIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8445

On Tue Apr 28, 2026 at 1:08 PM BST, Andreas Hindborg wrote:
> "Gary Guo" <gary@garyguo.net> writes:
>
>> On Tue Apr 28, 2026 at 10:02 AM BST, Andreas Hindborg wrote:
>>> Gary Guo <gary@garyguo.net> writes:
>>>
>>>> Currently the `Io` trait exposes a bunch of untyped IO accesses, but i=
f the
>>>> `Io` region itself is typed, then it might be weird to have
>>>>
>>>>     let io: Mmio<u32> =3D /* ... */;
>>>>     io.read8(1);
>>>>
>>>> while not unsound, it is surely strange. Thus, restrict the untyped me=
thods
>>>> and also the register macro to `Region` type only.
>>>>
>>>> The way it is implemented is by adding a generic type to `IoLoc`. This=
 also
>>>> paves the way to add typed register blocks in the future; for example,=
 we
>>>> could use this mechanism to block driver A's `register!()` generated m=
acro
>>>> from being used on driver B's MMIO. The same mechanism could be used f=
or
>>>> relative IO registers. These are future opoortunities, and for this pa=
tch I
>>>> just restricted everything to require `IoLoc<Region<SIZE>, _>`.
>>>
>>> Does this not prevent `usize` from being used to index anything but
>>> `Mmio<Region<_>>`?
>>>
>>> It is my understanding that the following would work before this patch:
>>>
>>>    fn do_read(io: &Mmio<u32>) -> Result {
>>>        let v: u32 =3D io.try_read(8usize)?;
>>>        Ok(())
>>>    }
>>>
>>> But I think this will no longer work with this patch. Is that the inten=
tion?
>>
>> Your example would always fail, as you're reading 4 bytes from offset 4 =
from a
>> region that is only 4 bytes in size. I suppose you're trying to say
>>
>>     fn do_read(io: &Mmio<[u32]>) -> Result {
>>         let v: u32 =3D io.try_read(8usize)?;
>>         Ok(())
>>     }
>
> Yep, that was my intention, with the assumption that final offset
> becomes 8*4. I think that is also what would happen here as we would
> invoke `try_read::<u32, usize>(&Mmio<[u32]>, usize) -> Result<u32>` with
>
>   usize: IoLoc<u32>
>   Mmio<[u32]>: IoCapable<u32>

No, these methods behave the same as the old try_read32 macros, so these ar=
e
absolute byte offsets. I think the fact you're confused is a good indicatio=
n
that we probably want to remove these methods, or at least make them as
inaccessible as possible :)

>
>
>> ? In any case, it's intended to be unsupported. For types regions you ca=
n use
>> projection. So the same code can be written as
>>
>>     fn do_read(io: &Mmio<[u32]>) -> Result {
>>         let v: u32 =3D io_read!(io, [try: 2]);
>>         Ok(())
>>     }
>>
>> i.e. reading from index 2 instead of byte offset 8. If one cares about b=
yte
>> offset they would probably want to use the register macro instead or hav=
ing the
>> MMIO region untyped.
>
> Right, makes sense. Again, my thoughts were not around the byte-offset,
> but the `location` parameter being in count of elements of `T`.
>
> But why remove the ability to call `try_read::<u16, usize>(&Mmio<[u32]>,
> usize) -> Result<u16>`?

If you're doing that it sounds like you don't actually want typed access an=
d
again, would want to use register macro to allow mixed register sizes.

Best,
Gary
