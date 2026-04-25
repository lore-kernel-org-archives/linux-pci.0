Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DFA33F8B1;
	Sat, 25 Apr 2026 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777086280; cv=fail; b=uBm7ksjtFFQAvnKsXL7dcFHjALy4HmHqbqrki4pFOdY8cTSWyit+sQ1vTwxYi6z/tZchNREKyPSnbtbzQ+s9nzdCVX94OS+2hWjlCkYvJtDVx8t+88fCjKhE+LaXi6GZVkgQTdg5EQRHW7EfeC1oZGcJaSlzy/O+c0NjvCW3Ev8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777086280; c=relaxed/simple;
	bh=rp9nxQb7Cj11xTYIuZVNqLWDfDHVJ1/cbtTSpglxnLk=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=K8ZcP+Hsr4THF2wskrByWW/hHD8TwXIg6/RSnER4Vx5E062kXXCdCQsENFGknyp+Q/ChpngPMytQZp3g75WDPmpqPiWfT4N+kXt0hIhH7RN2rAUZsg3Gjg2WXPYb8JhITOJtRgWpiIo7eKX4MYer+6nevPn4WDX18M+QiMOgxRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t0pgXml0; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t0pgXml0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWaBlWDHINybrRsVQ9uJgD3jDlc4SBRGA06Q/sJauLJaTRS/I9PdGGITYkTf9BEciEzEjuDzTrgwF9CBnNKAQBJbPOtcwRhQXO2lxoQBkP01XuQFR/qd6YORua/k5sn9KmlFTY1lYRmtV9LOuMwsrmF4vgmIcVW/pkqEAkSrpOtj2G+Wg90dEgQXWn3QY/0vhLt82KjaQX1r/ZPbNPCCb/NlV2SGJA0BWFWbxVQJ1ehyUsrHQU7Wp+vgVhofl/pHay192olfzHNs6YnN1AE7d1CoFMFwOvCscWHeDKVjYGM56tfE5/jmyEhAxw6wIUCRB9nlaL5/+1hANme6XPrlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/lK4OdSG94mynKu3rxlAnSioq1OI5QH3kyBbQe7Dbo=;
 b=iHikALCCcSY+/tqjBhjV8Yv70FAoQxlM1x/8owS2nrMDTZPmUjr+l4tDfzWUAXQw7yb1uKuBrYtgqlxf2CCaLlO9e8gGxYcXIve7orYuX7qxOj2LCoB+uXcOb1YJyFZ47cPYXyq9U8lLNxGrqxJg6d7Hk+2SPCQrz2sFi3B5LLkNdpF8mKh72ulYRj4nNRe8N9/HPFHNY73n0VDRUXQChImqqbKZnFiw33DjK4FWuCByGfH9/OIGvq5u0BKhMnA0Uzy5AAbGiJFa73TdnkvfkM3pNuj8tTEEWxm2Kz/zrxLj6GaR7X5rYs+5SVukvo1Fa6llpovSFZGGOq3hvw+W1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/lK4OdSG94mynKu3rxlAnSioq1OI5QH3kyBbQe7Dbo=;
 b=t0pgXml0vaeD0Rqd+CCxlhUijH2YwYBt6I6l3pPwlcSc3/Me2yF0hNr93xIhBRR7Lzta4w8Qdavm6XQDpG+J/DIVzZYy75CyULZg/UCvGJqeYMM7+7x3Rnk0W/kGfQm3Wb/W2rqgucSGyp7lFWNinqnSfPy/HEpImMBCSLR9ySkoF/eQ2AyOKhyIBPdUc6KOE0uGjmdRVPgK5HUSVzNz1n3vBcT+WkpurpPhl2e5Mi2a23LHh/aw6whB1jumqJjKoHWfuKkAiCdhjbtlAQ/hhKaztScPS5HYTMw1grHTrQz+vhcl0HV5UncsDR/FvtJPXyOHIaz1AE2yHAVvPGSBGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Sat, 25 Apr
 2026 03:04:35 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 03:04:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Apr 2026 12:04:31 +0900
Message-Id: <DI1WIAT4LTYW.2KJ4WWQTWTDJ2@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Boqun Feng" <boqun@kernel.org>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] rust: add warn_on_err macro
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
 <20260421-nova-unload-v2-1-2fe54963af8b@nvidia.com>
 <DI0I3TH8B8ZZ.2118S8MDUHG@garyguo.net>
 <DI1GL1FIGHO1.12VSIIQQN365T@nvidia.com>
 <DI1IQE7MDV4O.5B2DVIXMX2OT@garyguo.net>
In-Reply-To: <DI1IQE7MDV4O.5B2DVIXMX2OT@garyguo.net>
X-ClientProxiedBy: TYCP286CA0128.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: a00be8eb-c911-433a-c424-08dea277611c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+io/A7O1WDS0Xb3Ev4yIKSEQCOU7eo447/guzC2QhVMW6IG5MWer4Q6FcG2N7/wgDxz+XzNLSI4dqFjC9SqnGyMQWc4vxKQVWTWIWAVDRFMifR8/uyW+NwDJKc2iTscrhhdCNGZlu0lPFNqCHLDAU92EzfRgjzuodo2RD15h3FwacdQ9NRUjxz1s9peAAWlK7dzb7WXdctjKoaAnoDgPaIwxH6wOd7stlI5kWy+5ma9njeh7eHSIzKuMlqxDagMeWt6Qi9WOAffqWMqcA4ESLKa5CiEL7dGkxCjU3aj5GfvAHTFYSJY/Fie2Uj+fxks7ol7kfTZC/uAL0L8ejHItw/J/lGUVJMj9P2/lV6N3VA63ehufoLHNfRCp3Hz6SSBDQUMpgVaDr1W0IVH38DTqtEEMhVq+Rlw/7wTEALIugqPaPsKXRm3khK94RyjuYGOWaoQzGTC+cSFizbPnmNIcY8fcoOlRWVAFcYQaA5sPZ1CBuK+icFvDI47uxMEp5soaduAAg5c4Vg0G3/wlxewNmqjEqBWztBtMFtiggPymZ5CfvO8XfrLQCgsnWgg7vQj7Je1keyz+Q3+ehrRmNHSNBASpG+UG39vNvxYjwNkpvFzPD4mvtabHvD+A8wPQVFsTTQw5+AaV6r3uOhZcWFb2LL/sisnc9wF5gvpWI1FQ9hWuy/HdCEHH5zQ23R6EDWs4i6Mkm21uEi7SlT7EazjEHNFK1XFETYi4A9Tid/xXZrY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkxyTEpFWnpuSmJJcTFnUFBOQkFVSnlZb3dyYkZwMEJIbEJVOHl0ZyswS3pv?=
 =?utf-8?B?SmlkWjhHcjZ1ZXgyVE5IY05RKytDOWFCYTNjcFNaQU9YRW04aXdwNjF5eW0v?=
 =?utf-8?B?TjVadHZNM29QRlNoNWg1QmFGaHp1ckI5TU1qNG1FdGpxV0Fnb20zSkhGalpq?=
 =?utf-8?B?S2djRGRrc1JZZFEydUJLdXFGQzRyT2lnUUxkSmpsd2pFaVdwdmE5TGZFZklR?=
 =?utf-8?B?d3JCRkQ1WFlsVUFyQm45Y1pTRm5GS2ZBeFZkeGdYSGtQenNEUWxLV05Id1ph?=
 =?utf-8?B?cmxYVXk0VzdsTmQ3NGExSlhFcElkcHJ0MVNjVm5iNkM4dzNBZ3h3RkJHMGVS?=
 =?utf-8?B?c0ZOWURFNlZKbll6MHZLOTMxSlE3NDByamk0ZkNBb2xZeCtjdTFwTmw5MGk2?=
 =?utf-8?B?dFc1eG9rOWZwajlKc0ZadEdWMmZlV2prYzRITTMwOEFWbmluU1o5R1U4QzVn?=
 =?utf-8?B?b1huQW5DT3RpeUdiMUVqVWhJQWZFTnV3SzNLNFNPSlQyYldaVlovWmlUR1pB?=
 =?utf-8?B?YlRXMStuVVVQN3VRR2ovV0ptNDYySTZnOG5EVE1neGdFR2NlUDhUcmVJby9s?=
 =?utf-8?B?Z3dYS2lIV0ptOUFVZnBLbURkQmF2cHVxSHhudHNBbFhlVThvQWUwMHFSVUpG?=
 =?utf-8?B?QWgraEM1M0VNMEo1ZWRMSUpnZm55bkpiejZDaFc4WGdQQXJYUlNHUXdlSDZz?=
 =?utf-8?B?VW5aSCtxZWlkWnp1a1pjUnBINTlPaThOSlF0TnRUSWlldnYvaFF6VzZoRS9X?=
 =?utf-8?B?N2xPZmFUVzkxNm03WUN2UEpsY1hDcjYxdlM2L0NTQk5td1R3bDY3eG5JWE44?=
 =?utf-8?B?c1FlNGZhTkVWQXlVYUtEQXhydnFxU3N0Z0p3YUVocFFVL2FLQnJhdkdqaUR0?=
 =?utf-8?B?aVlWWUZaSFBkMk9tMzgrT0xUSGZyRENsckZYUnlJcDV3d1IydnFHdWZkMzhi?=
 =?utf-8?B?WjBOM1FMQ0Nkd1ZDYWdpaVg2cHc5V3JMcXBXN3Rtems2SlozZjdBQnIrY3Jo?=
 =?utf-8?B?YjFWVUF1aEZobmlYcCt2ZkFSbTRqYytNa2JieDlRRXllWDI2dzZHc1VPNzhq?=
 =?utf-8?B?Y1JYNVFIWGhsRFF5THMwV3JRN2FQdlZuL0Yvc2VuOVg3S0FqQi91bjFBTmVa?=
 =?utf-8?B?L0s3dXBQUjdKQ3VxUUFWUDc5ektzTkR3MlFkRUsxd3pFZERpVHFYTFQrNFJP?=
 =?utf-8?B?OXQ0RzJoRi9CREpWMFJDbjZzaG9oeXl4WFJXc0Y1TG4wZVUwdmtGdG43dDNX?=
 =?utf-8?B?TmxKWXgrbnB4MlBKT2libVpHVUducnQ2SnowalR0dGlVVkh3aVVYajVrQ3U1?=
 =?utf-8?B?WjRjTGQrSjRQVDRqWEs1WjhuR0FObUl1SVU4em9uUnVtczBMYW51cnByYy9z?=
 =?utf-8?B?cGRIRTBtUXVQeGVycGhFTnl2a3UrbHVzbldoNSs1eUhGSnMrZ3FYOUVYTnEy?=
 =?utf-8?B?U2s0aWhvbzVZd29Hc05JR0doWld1Y3kvTlJ4SW1yRTN3R3B6cGI3MytoRjBS?=
 =?utf-8?B?bjFyQnpuZDE4Wm02Y1dORGVQK0MwWTFNOGlubzNxam1iVXNCSUJCL1pCOVcw?=
 =?utf-8?B?Mkk5UXNpMnZjb2wwSlFsa29DSXAzYk5HVjR4SjB0UVRoVVl1TzJMWmEwUzcx?=
 =?utf-8?B?Y1loL0F3bFdZOEdwd1ZSRzRrWG5lbzhSb3QyQ0lhVDNLM2tGM25mL0ZRdHRN?=
 =?utf-8?B?SG1teGRhN3hJZTNwdEJoWHpCa2VqekdBelZZc1dhb0E5YmJZcWE2Ymx4NjR5?=
 =?utf-8?B?b25pbEM3T0hDemVWNmVwSkl6SHZvUjJ0Tzd1TGErenRpVjFMcWV1RnZaN29B?=
 =?utf-8?B?aUgvZFB5VUE2S0tMYkk3N25xWkpHcEQ2OHdENWRxWitlakdJaTlTdWtERG1W?=
 =?utf-8?B?c2JZMWFZK2hLRVFnMFBJdVVRNEh1bHpFZXJmSXhGTVU0Q0xESFM2cE9tejhX?=
 =?utf-8?B?NlRXMGNuR1NoLzFna2hGWDdpY3p1NE02SDhISVdVWk1iR3RrclhVSWlvREdm?=
 =?utf-8?B?S0VpMUg3RUVwWjdnTFNxSTZaeVlmWXhBRXBDMGNLc3o0Zi9kM2Yrb21Mekor?=
 =?utf-8?B?K0FnOHpxN0paRjd1MGhjYXVoU04vblpDUjNiL0M2SFJtWWZSbkd1dE4wUEZj?=
 =?utf-8?B?UDdKdkRkMGIrdGZJWk8vaHF5Z0RaVlNFaDVONCt5ZXZXMEl1RittM0ZkR2J6?=
 =?utf-8?B?a0U2U0FhTFhTM0pxaVlXYkhtWlpjZzlLUDJQYVRjcWVLZEp5dUJldnErYUVG?=
 =?utf-8?B?OUpzVStaNGdwMjZkVjB2MmVieGtVbDlNRVEzbHZpTTNxakMrSTV0ZXFlOHdL?=
 =?utf-8?B?d1BCODdUTjhxYzJFUkZqeE90Q1dyeW4vditTV0tKT2F4Wk1nZXFuK3hlMmVv?=
 =?utf-8?Q?pc8Ch/0CH9bkKknmtxm0xpFIgS513o4q1dqJmmjHYyJvb?=
X-MS-Exchange-AntiSpam-MessageData-1: Fa6krGHKJ1ZAww==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00be8eb-c911-433a-c424-08dea277611c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 03:04:35.2926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxoaGT+cYj7A+rCqT6u3Kv3eaDc9FLVIbbOHRvqUhY9TFjKTDNc7RGuzIiW75YYKhg+Vl166isFX4fRA1r/yQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868

On Sat Apr 25, 2026 at 1:16 AM JST, Gary Guo wrote:
> On Fri Apr 24, 2026 at 3:35 PM BST, Alexandre Courbot wrote:
>> On Thu Apr 23, 2026 at 8:34 PM JST, Gary Guo wrote:
>>> On Tue Apr 21, 2026 at 7:16 AM BST, Alexandre Courbot wrote:
>>>> While we already have the `warn_on` macro, a common usage pattern in
>>>> Rust is to check whether a `Result` is an error. Add a helper macro th=
at
>>>> allows this.
>>>>
>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>> ---
>>>>  rust/kernel/bug.rs | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
>>>> index ed943960f851..2fefc0aeef81 100644
>>>> --- a/rust/kernel/bug.rs
>>>> +++ b/rust/kernel/bug.rs
>>>> @@ -130,3 +130,13 @@ macro_rules! warn_on {
>>>>          cond
>>>>      }};
>>>>  }
>>>> +
>>>> +/// Report a warning if `res` is an error and return it unmodified.
>>>> +#[macro_export]
>>>> +macro_rules! warn_on_err {
>>>> +    ($res:expr) =3D> {{
>>>> +        let res =3D $res;
>>>> +        let _ =3D $crate::warn_on!(res.is_err());
>>>> +        res
>>>> +    }};
>>>> +}
>>>
>>>
>>> I think `warn_on_err` could just be expressed as
>>>
>>>     res.inspect_err(|_| warn_on!(true))
>>
>> This would turn the verbose error message into something like
>>
>>   [true] module.rs
>>
>> I.e. the expression passed as argument won't be printed.
>>
>> That being said, my version has the exact same problem and I don't see
>> how we can fix this without splitting `warn_on` and making it more
>> complex.
>>
>> Since this was done as a small convenience, I think I will just remove
>> this from this patchset and revisit later as a separate series.
>
> Something like this?
>
> #[macro_export]
> macro_rules! warn {
>     () =3D> {{
>         const WARN_ON_FLAGS: u32 =3D $crate::bug::bugflag_taint($crate::b=
indings::TAINT_WARN);
>
>         $crate::warn_flags!(file!(), WARN_ON_FLAGS);
>     }}
>     ($msg:expr) =3D> {{
>         #[cfg(CONFIG_DEBUG_BUGVERBOSE_DETAILED)]
>         const _COND_STR: &str =3D concat!("[", $msg, "] ", file!());
>         #[cfg(not(CONFIG_DEBUG_BUGVERBOSE_DETAILED))]
>         const _COND_STR: &str =3D file!();
>
>         const WARN_ON_FLAGS: u32 =3D $crate::bug::bugflag_taint($crate::b=
indings::TAINT_WARN);
>
>         $crate::warn_flags!(_COND_STR, WARN_ON_FLAGS);
>     }};
> }
>
> #[macro_export]
> macro_rules! warn_on {
>     ($cond:expr) =3D> {{
>         let cond =3D $cond;
>         if cond {
>             warn!(stringify!($cond));
>         }
>         cond
>     }};
> }
>
> Then you can just use a `warn!()` with custom message.

Exactly. But this is getting more involved than I initially thought and
will likely require more review, for a marginal improvement on the Nova
unload code - so let's do that as a separate series (that will also
allow us to merge it through the Rust tree).
