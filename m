Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F9C3DDDB0;
	Fri, 24 Apr 2026 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041361; cv=fail; b=Gh9hIh0PF9uTFc2NwVQnDoeYK+NFWqNMxI8TUhIPLAYFoyabhgy39kUFKvJH/vobbmXRYQOkxglv0nF+/s+dFvRDtbqwsAiC4t8f3HcATwFZ4LkC6CPzrSg8vjFug/Zs+9CgM3RE6zcEgDaWasyLxEZohZEv2VdiBcphe7i4UFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041361; c=relaxed/simple;
	bh=gfcJd4rPOdhQwZW5ODMTEPWgAW4Oj8HMstRG3f+BTsk=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=XDbuR7G+aEr0tTMbbtggAZMB2PQg6068u09Gft7OdNCOthnG8ree3/z6lgrJ+Azts5YlkXTRAEYbIofO8CRIZ3jnkb+9FIvewMI4GL5mW7WyjwEolZDTvUHGdca277viDy6luLNtUAMoz1zHApYw1lQQvGDezBPE4EjXcgOO/ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H6uQexgF; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H6uQexgF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxwAsEEI5NCcl2BB0KO/sZpd4SM4/Id/zZ3AP9+jMR17OUlBcHR3T9/02JwcAFOcETlfffVZQHTY9NIJgFdwAzN3Yl5aQGtR5D8nhKxfLPs3NLcKQS0pNvBrB/LeQ6VMMONAYuIJL0Uk47aTS/0JcyTjqhaYC4GfLm2lvIqXpjxi6l+OpSJZnGqUZ5lkz6Wng0Pm9vR8qT1kvYyz1YnL5tbM31982In/E9NfK6Y0G6sqQMB2Cppg8Um6ZeS1c7Eij8OD7kQ/yOJZq+RmpfZTdK6aCHY7eilxqXKU2P27zl7A25iXu0oOqmBC/zsjHoaIrwKCrDvNLjKSnWdAd8NFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGblsjNWDPiq0aCFoK8BCZoSIHt7lchoiKcbLbWh2wQ=;
 b=lv4q42QJKfD6sqxXcwfO8yY3OBN+1P2gZOWGktmE9OXLcUPoR1nRRfhEAW2SGNgNbtuiSHNXiihODgDPXQI5bNi0SbjpEUN1d2FHPKnCK5DsjE8ZJgO3pqUNdorKn6vaFKJTJN5CRr1FGA/byPMTFAZwwKEXLA+1oMoG44TGOtJE+OzbkyCp/5IGpXgdLTijfHUnv93aD9jFIk8e/jsxRKeKrM10c2VU/f+VzmXFcZyKRyj2DR14wmomeNzn1XIhgmIhWlZa22L9vTEzBZqUin6vH8iMICDt+odpF1OB/FWDeQOJG3ZgQhVJav57wV1/A6HdBwgKsX2f5yiU2Lf/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGblsjNWDPiq0aCFoK8BCZoSIHt7lchoiKcbLbWh2wQ=;
 b=H6uQexgFUNIvjK0Hd9r0fbPPCMAHkdUii6K09Lvc3eZbaqtNi6MbS/I1d3znwsOAZZYZS3DhMPjiZSqykFVR0ZqtsnWehOa8d+8ftl7BCNyRSzjbW+uV2EbPpi6AiGJA1AxHmWBX6eql/QmN+4CK/weAfuDM9CIFMqwFN/eTCgkFY5+SDazElY0pPZ47WhFwpE/KHzYN7kT89unVTuKx3R82lBqfO4IoLyY8NI7vWvIaQqstxzDABxopVpQPdq2NlT9sOmgRcLAjqXCtYm3G6xM0jyGTjwgBuje3iCYX6OKKpid5hFHKGAREVxolLzKQKKHE5sRp/xYnBBp/iHCCaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 14:35:53 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 14:35:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 23:35:48 +0900
Message-Id: <DI1GL1FIGHO1.12VSIIQQN365T@nvidia.com>
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
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
 <20260421-nova-unload-v2-1-2fe54963af8b@nvidia.com>
 <DI0I3TH8B8ZZ.2118S8MDUHG@garyguo.net>
In-Reply-To: <DI0I3TH8B8ZZ.2118S8MDUHG@garyguo.net>
X-ClientProxiedBy: OS7PR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:604:257::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: f723a6fd-9448-479a-ac57-08dea20ec934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JgetKVTKcsqKW0rFlOqBwKDSEQr4YYqi0J7NlEDQO+81Eh9WwC8nFCrGfYvQnq3ypxekH89JHp3nOxO/MwpzKP1hvsJez+SsLTtK8nlzlKGuSznVP8rVMo+6/SrrBIGHcUjiUxZ04gIboHGQb1Eypt58wpkUJS1AjMT12i1iuP7pCaKq8Cygrbw0u91HBNDi+xxma28X1Vvn2aYiCOJ/qDTBXC07JhbYxnWDjNMGsv4LyLjzYjl+abCWd6T0lnv5nogZGtxqL5SrnRq2fpmcRfIAUQvqLbbztxNkWywDjJoX2G3zGoGLbZ4qJxyNbWwoFuXCCbEaX4kEl4X5pV66uYj75GWyVuRrZsUaK2vw0XrNpr/afIc5K5U/hS+7iVsFXBekBHGtF3obiTnawqhPSpqTmnGjQewvAsn02fGzNsXPGc74orxXaalZMh2LuHAD1E/8iQz5XGb2BXfgQgmMLY/yP2JCJTYyST23gkwl6XFrX3uFCQL1NTM1drOJ52GnRqbqImkqmiNoGla5sGNGSa9rAeL+1pXEDU1Jpb9KUYRLFEkFV62q1XXAMdGo+IIKjwadfH6WazBR9LlWXY3Hm5fzGoD94h497dvglPuuHkL66lzyrpvmq8L/7s0ygv0DTNKIOR+NgfHZbmHfrwTEQQx+3MnXxlt3QDpPHlKwDOzeD3edDGq9WvhpXYBtCyVYStn49qIDIEjZpJNw00D7wWZ6pg0YiKNy4115Fsb4IE8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjBvdFdnZWZzUGg0ellrLytSZFprRkZWNWplaHNSV2hscnRqcGV5RWRqWHFU?=
 =?utf-8?B?T1NSTXNtY2wremxDQVI5dk1nc2V0MlNDYzJSalV0S0hNa3E1MWNNSjRGU0JG?=
 =?utf-8?B?MUZBakhrSDAyanJLRkNvVmtHZzNTUCtyWlVWUXcxTFpFTEVoWXk3VGx2Wjhs?=
 =?utf-8?B?ajZ6Rzd4c2FoODZ4bWUxWDVxNXdJQXk2aG0xK056TC80UjhJakpLandLU0Ft?=
 =?utf-8?B?SmRSS2N1VXlsQS93K0EwRUFmMDJpYUJ2aGhGeUZ3UEs5U2xHS3ZYVHVMdTFw?=
 =?utf-8?B?eUpQdmFKczEvUCtuV1dITHFCeEUzTmJ6bEU2TUxOZzdpZHNrWjNObDdtZnVG?=
 =?utf-8?B?Wi9DaVpDNDVCMGF4THlwUmRKZmJYejQvK2VOZ2g3K2dtYzhJUEM5cUEzR05O?=
 =?utf-8?B?Q1lrR1JxMUZIK3hwV2dHdERQajh3TDErbzMvYzhkVjdBS2V5UHM3NndPdFQy?=
 =?utf-8?B?VmVLQWN1SUVoZnRjbzh5Ym1MVUVNMklHaGZkaDBFYUdLeUxWcGJDbXJYVGU3?=
 =?utf-8?B?R2paS3VJVjVoeDR4ZGQ0NEtRaWZPK3E1QWdNTHovdkZ3Nnl3SnRTRmxYWFM0?=
 =?utf-8?B?cWdCNk1nTkdaS2pDamEvakpKaDhlaytuMGRyZlFUUWpFOVMybzVKd29qWEdD?=
 =?utf-8?B?ODUvQ2VCSTR5dEMwcnVVa2w5eWwwSk81UVlBakozL2x2RjV4TW1tRERmQjlJ?=
 =?utf-8?B?ckFyWDdmcTYyNDZBcjJ5UjhYeHNwS1VYY3cyck1aZmNhUWlOVGtFcUdBS0Fa?=
 =?utf-8?B?c21jaFowTy82eGJKelBxRGpSc3JKNDM0ZysyTmJISGtVRms4bVdhQVFZYWFO?=
 =?utf-8?B?VWZBdXZSUWtXVDc5aE5NWVErK2tUeWlQOS9MeE9rM01PZHEwQko2c05lbTRU?=
 =?utf-8?B?REMvUEt4ZHhOdHF2b0o5MVNpMFBnZ0xsL3N1ZWExYjV5OWFuTUFUNkszdCtH?=
 =?utf-8?B?bmVRQ1V6S3pFMkhua3RuRmZZeGFqNndZTGthbnlURUJtWitKT3dIZlp0SURn?=
 =?utf-8?B?d1lWS3ZqVXVZV2J2ZjRBTXFDd2g1VitodkQzV214NTRLT21wQVovL3NBTS8z?=
 =?utf-8?B?TDlia05KY2lKeXFlQzJLNDdtUGsycTc0VG9qazlIYzh1UXk4d0IvSVpyYmRS?=
 =?utf-8?B?VzBqZTNJVk9ka2ZYYjFXempTUWZRUnJqMHNBOXJSeXlhSWVFNGtSaGpLVkRC?=
 =?utf-8?B?emQ5OEdiTEllbHJFY3hESXNHWXBpSFlNOWttNWNlYUZjZVFlRlllNUcwWFBK?=
 =?utf-8?B?U0hlQXBrZ1oxdkJ5TTV5VStDL0h5Y3VKOThXMmNPY085NDhacFpiOFZHN2RI?=
 =?utf-8?B?TzJDcWk0UkFYdjdReG1IYytIZEVZVEZXcDhHR0NKZEVqZnNhSDZCVysxRWJj?=
 =?utf-8?B?cHFtVFRJNXRQaU5mM0NORVJpelN4bFh3b0NFOU5abFVIZmJNM2ZlL2Voemxo?=
 =?utf-8?B?dUEzNkVoeWNGQUZjM2x1aTFiNE1KMXpBUHJuNDVtQTFibENDTXd4OWZrNlps?=
 =?utf-8?B?SFJObzIzVy9GNzZ0N2JmMUtKbE00QnlYNDRNZEpoRTEzS3VnZUpUZGZDMU9a?=
 =?utf-8?B?WnlNUXlrZzRmVjZYa255cWxEYWg2ZkJITnV0Y1pjZjFCRGR6VFgrSU1HcUNx?=
 =?utf-8?B?Nk5ScTBMS0x2aHdMaC8rOWlRejRaam0xQkJYMkJvVm1GVmZjdEYvVkxxVVht?=
 =?utf-8?B?dnM4cnZyTnJmS2dOVUd4SWdwamxCdjE3WWVUVkltSDRIVTNwdFVacEZES2pu?=
 =?utf-8?B?Y283Y3NhcU80V0NHQWI3cEZlcHR2NitnOWYyOExPcVVTK1ZrbkVTeVNEUEJO?=
 =?utf-8?B?OGMxOWRSNGo0LzhYckxtbVpDZ1pJQjBOWXIvdnIvUjU1WitLWXMrKzhrd0Vu?=
 =?utf-8?B?aFBBVjZ0V3FzRHN3UU9uK1lweVhYbnNTQmkrMkd1Y2loYXRON3dwaTVnZy9Z?=
 =?utf-8?B?c1hXbDR0d1R3eW03cFNtQWNBWENEaXhOenlNSFNBd01FTGFGdGFySk5pMHZ1?=
 =?utf-8?B?ZTAzRTVUSXV4cmRJWnhpOTkyTXFaYUYwQkxocUtMOC9iaFZzamdUeG5kb3cy?=
 =?utf-8?B?OVFZWHF1cFNHcWJNTlkwTkF4bXhMZk45dFVnR1hIek0ydmFDWWl1Z0J4ZDhE?=
 =?utf-8?B?QkV1SHVNTHc4Wk1jZVB2QWFzZkMrUk5Td0V2ZzYyeTNmZURyOEpua0QyeWhu?=
 =?utf-8?B?bWxsYk54NzhSd2VCd3RMbnlTK1VHZVp1N2JxRno1NTFscDdXN1ZQR2JoMDdr?=
 =?utf-8?B?THQ1TU1xS1lUZlZXY0lYMmlpMS91ejRvUDZ4a3IvRCs4QWtQMEJUbG4yWjJN?=
 =?utf-8?B?Ynh6L29pZThkQWZEUlBWMlZiclI5WElKVU45WWJZazlDSWxiQ0k1UXRKZUlN?=
 =?utf-8?Q?G5iES0EzSDlAkwxn1Na3/+2nz6JDKRiJPEvvGlMgyqrZU?=
X-MS-Exchange-AntiSpam-MessageData-1: yLrsixex4+JIsA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f723a6fd-9448-479a-ac57-08dea20ec934
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 14:35:52.9265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5XzZTrF8yG4OO9Kt1HIlcmAF7m6j7hml2+9Grziw8MIe5MjONdTr+IaRAckdyz2aWNlHfkRbLTXB2gyd5B7AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491

On Thu Apr 23, 2026 at 8:34 PM JST, Gary Guo wrote:
> On Tue Apr 21, 2026 at 7:16 AM BST, Alexandre Courbot wrote:
>> While we already have the `warn_on` macro, a common usage pattern in
>> Rust is to check whether a `Result` is an error. Add a helper macro that
>> allows this.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  rust/kernel/bug.rs | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
>> index ed943960f851..2fefc0aeef81 100644
>> --- a/rust/kernel/bug.rs
>> +++ b/rust/kernel/bug.rs
>> @@ -130,3 +130,13 @@ macro_rules! warn_on {
>>          cond
>>      }};
>>  }
>> +
>> +/// Report a warning if `res` is an error and return it unmodified.
>> +#[macro_export]
>> +macro_rules! warn_on_err {
>> +    ($res:expr) =3D> {{
>> +        let res =3D $res;
>> +        let _ =3D $crate::warn_on!(res.is_err());
>> +        res
>> +    }};
>> +}
>
>
> I think `warn_on_err` could just be expressed as
>
>     res.inspect_err(|_| warn_on!(true))

This would turn the verbose error message into something like

  [true] module.rs

I.e. the expression passed as argument won't be printed.

That being said, my version has the exact same problem and I don't see
how we can fix this without splitting `warn_on` and making it more
complex.

Since this was done as a small convenience, I think I will just remove
this from this patchset and revisit later as a separate series.
