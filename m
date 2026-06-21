Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022085.outbound.protection.outlook.com [52.101.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269740D592;
	Sun, 21 Jun 2026 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782056468; cv=fail; b=MYcvJMh+7gt+Cg7jmhWGBcRm/gdMNCjv69H1pVl+KPtqv/wHagWEykKKqFAYOwPeYBrNDysLl+bEHwf/rOnnvwToqrdXnhehZ4epYl1wE3Asb2fhgDn3HKbqMpkf7HAXxshCerTsU3qLvgE7fTOV6IXYfeA7DXCa+SQoxAXtvuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782056468; c=relaxed/simple;
	bh=fDa9I3AvGVn5+Dz/y0OsnB4QM2YaVixcLrML/WGgyNY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Rl9AKRfAKCTHFeaT6noJS7GggIt1jKgFWHDdqy9skfApizSk9tAxLAVqqyRXdVqsdQB8gBxIVXs46i883TnrIrxovqly/G9HVL77YZ9dV61jnaqcELjkNbSMaEyNeveyOjbFAM9/D4ML/ksuSXw4i5RRjnQiKm4qG9kw+BDs7Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Z4oJrWnL; arc=fail smtp.client-ip=52.101.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Z4oJrWnL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1mN+g0hiFaDVM1ES+Ue6LagH0yZvDo/mBDhsWd+c5t2Chw/+KRQ6HFHWk6pwlwg/gmQUpd5i7kaiR4KbHLTWOiAHqJvaaRuoZ9O9GcPexJRIRZkU1kRoZM06uOLb8rboLkJfuNx56L0Hu/T2JsLgLtX6Flq3lTHqJxpnnnKZXbdUGglRvhTt5H8NZ1vi6uSYaXiXwLi9TNUORPu3fzCbRN9dOlRE582Z2f+Dp98i6HPMSAoD47H+i46ChIPFbpMQt7Vvle6B4OPmtOrUrzuwFDYOyEpuBMktBmsBTu+Hiv6XFxn/5WqdAlv8WrFXrQHttsd7OXPTgInZz8YqFpAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rv5QEelSDNEALgj3Xulxbd6C6miVkprSQEluiuVgeI=;
 b=hNa07N3I/wDghpVZKOwOpEsKCmkKCdOTCxuqE19A/Xx3feUW906aHVacs1zqK4IzVDbQKKAccOK/pFwJGaSsv6R6VNPeTMOeoPBOXtYvFeFuyt8ECG3kjPVtNRckHHNU7n033OVAQ9IjJmU7r/F82rtvUq03N8QsvEl78+Ct7psAHpNPgupZFpz6bXB4k5ahiM4tnMIKAjjmSvDhpKh4oMqSqwpqSanElXmrJiP5mxcKmdM9GK4Jyo/fNVdie6zwHnuo1Eju0FQuHLrgMNB+JmF4l0UYrqZXPwP88rQPIXusPRHz8gnWKbEvCK9E/d65QXziKCRZ0wTA+7zXDzwWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rv5QEelSDNEALgj3Xulxbd6C6miVkprSQEluiuVgeI=;
 b=Z4oJrWnLQZbR5TIX9+6xtVDq0x9CnKJ7JFofxY7PJpEgsodEfaiVjOM8cUGMI28qghIAewsZndeDGjrcPNua6UkPTJ3J7s1KGhhVK4K57Rx8DO50iWYnXb5lmvJgp1glpVgTmqmQSxMI5Tfc+KcCB23RDQDNWY1qUUiqvZuN6Do=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB2018.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:6a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Sun, 21 Jun
 2026 15:41:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 15:41:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Jun 2026 16:41:01 +0100
Message-Id: <DJEUAKFVCM0M.3VV7G8AQRXAGU@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 09/20] rust: io: use view types instead of addresses
 for `Io`
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-9-1f7224b02dcb@garyguo.net>
 <DJAJ51781EOF.1Q2VTH6CQVXYD@nvidia.com>
 <DJAK39S4J6EP.2VY3R7CIBAPOL@garyguo.net>
 <DJEM4MAO7RON.1EC4OJM72BCNB@nvidia.com>
In-Reply-To: <DJEM4MAO7RON.1EC4OJM72BCNB@nvidia.com>
X-ClientProxiedBy: LO4P123CA0232.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f24049-75c7-4349-120e-08decfab7f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|3023799007|6133799003|18002099003|22082099003|56012099006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	W7dhY8CMladZlStTMCq2jygIU8xAP5QI+LJWhwxq9GGcNPkm8khiCbu4MHkldy0ICAOQHfRj73A+Xn7LpSMHQQAvuj+s8ffF22FU1iP5P+jiIJxz0pcMFfQJ3aUpPWd6U4TUF+kLyVmqbfa21YDdTdoySO4k2WwyO6LDCSh6Dw6+/xlgOKDSCwKkWSA02rMK5EPhlOy56WA6TppR295VpboAHq2z6w7Wi91Go12jZAqdhlvtvx4bdKs4RIFC5RCblTOkuWSJ6Sadtoovt4I3Cxpe6qZgs2nLb24PDZ1dyo4mbjjNzkScd9ZlTQTdqtKFfuCtBHBRgqR/tyDs570kjKi5Rtz9JTzdfu8fVojn2P8Wc4bOed7N3XU4Iv+p1jLqSUSCZxSN/kDDejWy6C9Tc8TXblzD32ehM0C3XoxlqAF3+hi7pSy0wayjrlk6p8oEUcE9Fb7Gr3HNSohpZjbSZhlMpdXOm9km+qb+LuDLJCIVLtymxWH8l/2U0WLHrIZMVF7dpGHCV0b+sRNsTefBfWB2gQf+cg2/DRIe2k+nWOY10UdF50BsDTxD0Rr4u3mthnFs645MLZ79jlQAW30fNcpQGkUqp9NY4qGWoSjYklsYQrKFAAtAy/PWkmPDCMKeYbqFkfpBKsgcAhETIrrT8PKOd4KBp+6CgCb0e2UTUtg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUJMU2RuVm9EY1gzcyt5S1dNNGI0Z1BzaGJ1U1g5eDk0SlFMVVg3Mlk1N3ZD?=
 =?utf-8?B?Q01PSWhMMVRMNWZjRTI5NG9xOEg4RUhSM3U2TXlOaU01cFZYcTZkTjVRVW1t?=
 =?utf-8?B?SEJpQkUyK2puQWlpOFFVRzVUbXlQQkRvRW15V1ZzVHBtcXhBVklPS2c5ZWpt?=
 =?utf-8?B?UHlSblNmNkNmNGkyWFU3NjBVdDNjM2tCWUsxNlNTandwckgzSzVyM0xoQWZZ?=
 =?utf-8?B?ZFBWSkVmdkphMm1oRFZGNkE3akRiZENtK2l6OHlHMVVQcWFsQXE4Zm1WcmlL?=
 =?utf-8?B?ZlZ0dCtGMHN6ck1QZnJONko1UFRZTjhnb2dvTG45QVJMMEhjMmhjU3hlS1kz?=
 =?utf-8?B?UmJWYmtXQTFRV0hiNnNJQVk3cXEzNFhhY05sWUxOMDd0dk9JL2RzSUJIaWxp?=
 =?utf-8?B?RkI3SWY4QjBLeWZqOVh5R0tSR016T3JwSjJxMGpqWnlHVk1LaWhoRFlkaEhJ?=
 =?utf-8?B?Y3lSRURNNnJCaGJQTXVCNFkyWjcxc21uY1VGWTRuSHE4OW0vbzJYamhJQ1FB?=
 =?utf-8?B?Nng1eHJST3YvbVdyTkV1MUo3NHNDS2dSM3crd3JYbkpCZE5FbUN6cXRnaEo4?=
 =?utf-8?B?R051NUV6Q0pLcmwzNXdEMk04M2ZtZmkxUkdRQzNFM0pqelRrcERveGlUZFMw?=
 =?utf-8?B?dmpDZFhreGFEd2VxTlhFVDBrREhyTEEzeG1XYktHa2xLK2htenI0ZGh3NVZu?=
 =?utf-8?B?ZEdJM0ZKV2Y2V29ZZktHejhreEE1U1hoa3VSazNzZFdJQVlMUE5ZbWtBelhj?=
 =?utf-8?B?RkdHOXZtd3ZmNEpiZ1g2a2tDS3Q5anNCN3BzTHVhbTlBRHNPMmZwY1hPcmlH?=
 =?utf-8?B?YUxXR2sySnhYM0psYk1STHF4cXNNaTlpSEsyaWFkaFBMOFVZbTVxeUpUc2dT?=
 =?utf-8?B?THUzOURkMlNEZ2pyRTdmQVpTVFFjNEx6aEM5TUt5bXdaOTlnTU1VdkpCckVw?=
 =?utf-8?B?czlNeGNsN3QzU2tHZjZaVXBYUTZKOUh6MXpXYUFES1RBSVRYZTAyMkJWRzZx?=
 =?utf-8?B?VnUxR2p5QWtXTWpkaUpra1pPdEtBbjkxYWRPME1WbThuRGEwY0ZZWUhGOStR?=
 =?utf-8?B?NElrVVJKMFpCQjJvTlE4ZExLQTJXSW1VaElaeDBkQnk4TEF6Y0JPa3pEWXN1?=
 =?utf-8?B?MS81Z1ljSVpqVXJKbWF3SlBtU2JGVFQ0N0pJajZkbkQzM0RVTElXUFN2YXNv?=
 =?utf-8?B?R2FzK01UeFBTNEZnQ0V2WVZFVVhmbDd4YkZCN3Z2RmVqUnV6VHUxMmRVbm1J?=
 =?utf-8?B?c04yMDJTSk1vYVIwS01NOXhVWkdxcXJXY3lNWXdHejMwYUg1aXFMMkIwdzMr?=
 =?utf-8?B?c0gxdFpBWTY2bk1uTk5SUjBHbHVncGZSbGF5Vm5LUjBHMjYyNGNjcE12VUt3?=
 =?utf-8?B?WWtja0NRY21vV0pSei9WWjFieEg2RFl4MmY5S3BHa3premxpOUdGTTNpZm9r?=
 =?utf-8?B?Zm9HVEo2VTlRQW54eEh1aTJEazZBbWQ4bG1pUWpYQzFIanVKS3V0NDhrcmZ5?=
 =?utf-8?B?NVp5dWFzbFZaTWNEb1orS0ptSXRrNDU4VlFva1JzV0x6MVNBazc5c211czIv?=
 =?utf-8?B?dnFNV1g0d1ZzL2tzRGJETmxHT3gzQmV1QnQ4RHN2N3JrS1hIMGllY1YwenZr?=
 =?utf-8?B?ZWREV2FEbEdvOVYwaUZNWGc5RkpVdCtuMm5DOFZaUGhhQ3dvWDliaVlPYkVU?=
 =?utf-8?B?clhyZHFyVE5OWGlaQi9tbHJqL1RaU1hCMHZtZ1VhdlZQNzdxVlpLaXJZVDlN?=
 =?utf-8?B?aXQ3cWpDbkpVZUJ5Zk5wSC9xYkE4MUJJV1dKdkFNamJMbVB1ajVyQ0pmMmlX?=
 =?utf-8?B?MlRlUkhpSndNaWMzYWdiZE1lek11MWRiMloxMFRXNkZXZWZJdG0yK2IzbFlq?=
 =?utf-8?B?QTFSdWVWN3FJT2RXSVF5S1pOZWF1ei8zZ1Zwa3pVRVRlVHdFUFBQbGhpTk9v?=
 =?utf-8?B?YS9mY1BwcGlpMWdlYnpjVjBXRG0zWHJqS0tYYUdnV1lCNUxweksvajAwdWtu?=
 =?utf-8?B?K1FKb3RZVGhnczkwdmZBdlN1bXMrU0lEdERUVmFld1hPcEVxU0kvdnYzekpP?=
 =?utf-8?B?NHNkMk4rYnRlN080NHEzZU8zSXF5NG9tc2RMZUZJS292aDhEV2dRRVd4dnpt?=
 =?utf-8?B?Q1lOcEQ1R3JlbWdRa0k2QzNOaCtBZUJNeUV5Uzd1dWpyTFk1L0lDcHhML1Y2?=
 =?utf-8?B?Sm5UZ3R1Ylora09lNHFjZWhXRHBsRzlpWmt2eDNxSXB4M2k5aCtUNGdEczhh?=
 =?utf-8?B?TklYNEFkb0VOb0dmSzVnZ0JnY1FqUTJPYzRqR0hERVZhUTI3SUNRVFA0R3p5?=
 =?utf-8?B?M2kyblp1bTVjTkdYWTVvRHF5SDIvWTFYbGJvWmpyREd5QzdXRkJtQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f24049-75c7-4349-120e-08decfab7f59
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 15:41:01.7406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9sp3dk3F75mDGsL/ZvtYkkBi/Qb2tIkbotoeheyDjpul6KDPFt3PF2gJwOyzhmA1pgx6TYh0jjGMBmjstCmIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2018

On Sun Jun 21, 2026 at 10:17 AM BST, Alexandre Courbot wrote:
> On Tue Jun 16, 2026 at 11:50 PM JST, Gary Guo wrote:
>> I think this could be solved by adding `U: FromBytes + IntoBytes`? We're=
 only
>> using it form primitives anyway.
>>
>> Technically, even without the bound, nothing can cause any breakage anyw=
ay,
>> given even after the full series to do things with the view you'd need t=
o use
>> `copy_read`/`copy_write` which themselves carry the `FromBytes`/`IntoByt=
es`
>> bound.
>
> I should have provided an example - here is a minimal one showing the
> issue. I have put this module into nova-core and it builds just fine:
>
>     #[allow(dead_code)]
>     mod foo {
>         use kernel::io::{Io, IoLoc, Mmio};
>         use kernel::prelude::*;
>
>         #[repr(C)]
>         struct Regs {
>             status: u64,
>         }
>
>         fn io_addr_abuse(regs: Mmio<'_, Regs>) -> Result<u32> {
>             let high_half: Mmio<'_, u32> =3D regs.io_addr::<u32>(4)?;
>
>             Ok(high_half.read_val())
>         }
>     }
>
> As you can see, this lets a 32-bit access be done on the upper half of a
> 64-bit register, which sounds like it should not be allowed? Similarly
> one could change register types, and so on. This might not be "unsafe"
> in the sense that it is still aligned and in bounds, but it lets the
> structure set by the type system be bypassed. It could also potentially
> be a violation of the hardware contract if the access width is relevant
> for this particular address.

I see no reason to prevent any of the case, this can be done by `try_cast()=
` API
as well. If we need to take access width restriction and other restrictions=
 into
consideration, then a lot of API cannot be exposed at all. E.g. it is not o=
kay
to add `copy_read`/`copy_write` like the patch 19, because it uses
memcpy_from/toio which is possibility doing byte-width access.

in my opinion think people should be able to type casting without reaching =
out
to `unsafe` if it's not UB. Similar to the logic on why we have `zerocopy` =
that
allows casting between to types, these are "bypassing the typesystem" as we=
ll!

>
> The same thing can be achieved using `IoLoc`:
>
>     struct HighHalfOfStatus;
>
>     impl IoLoc<Regs, u32> for HighHalfOfStatus {
>         type IoType =3D u32;
>
>         fn offset(self) -> usize {
>             4
>         }
>     }
>
>     fn ioloc_abuse(regs: Mmio<'_, Regs>) -> Result<u32> {
>         Ok(regs.read(HighHalfOfStatus))
>     }

This can also be done just by adding another `register!()`.

Given that `Io` is currently completely untyped, I think we shouldn't attem=
pt to
immediately make `Io` super restrictive in one go. We can revisit if it tur=
ns
out to be a problem.

Best,
Gary
