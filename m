Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022073.outbound.protection.outlook.com [52.101.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF30D436BCE;
	Wed, 12 Aug 2026 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558288; cv=fail; b=qh9qojaDxWgjdh9zdWRdtyYF4z5o+6uk73/qlQx8QmbFQ3lwqTYhcZVM1zhR+XmxVW5Nx9sh+uiZhn5qQncDXZW3x24aKgZpNcdtWaGcckDBD3Ya13stJAIJenf4FwMAAKeznyNc7gegL5Y+V7eu5uGr9kOQbSalMmAIkUH5hKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558288; c=relaxed/simple;
	bh=box6V9eJSdku+yVQJTLKnT8MgjxGuf/xSr1B8dhZWsA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Pyd9MTU9BEyP2sUFZgn/CcIk/0D7BIrTJBY78BtsX2lJD7l5If2yC8QU2VoMeXu3SGBoneVNkwk4gQTSysTn7n9XVTLx6NghGspKp5t1FU8WtUS8YCdpFFgmg+4XqQBJUYgVJ/QwZjRZTfo2FsLGTxPJB+U+jHZZKXGMkshDO7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=EgFzDu3C; arc=fail smtp.client-ip=52.101.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="EgFzDu3C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZmA5ii4cQfDWOuCeg3e3vqCHjDrxXxP1Dz+DmPUlDybMZmbCps1BYgYYRL2lJemsPNfQfAo8aLVdTfrQDKlAyq2rIRbH8dC0MNuyDPnaOCBhKc7Lp4sQNRUA7yRE/JUYG//BLpewc2hoYo5kIJB6Pyd6PZ6ahWqMpXkUqvgUkiUWGGAuacVgP4pCv58ucTd+0oMPpcWwxA7p3PD2oUdGZ7eD4Km3TDnlh/apJNHSmo22UZmLkS30JWzsvRlisPSw+gfF0MIJeA8je8ksnUuaDrJp92sSofCwDNW5FhHtTDmCw3eTYJOtLTt5HWtdIGUyOWda6Ropqh5ik7FoprDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdnIRKvA+4N1KmtJvAP2xlQFhqkjbsydwBkoCHRi7eM=;
 b=FCUBFWmJkzN89p5jPfdKbgg3II7aeOiJ8wcV+gsnWdqau0HcyyQlZu30usGd7AlYeIjAwrX1t2gDx+5uhALDqUYzSUZaR3hk6RBa/3daQpdb9q53cg+0Ib4Vji+3Bx5uMGlRtLw340uVO/B32YJbVuou5//j4h4dTHmd9kCxhbmM/+3L1tC4Hvxzb0FUh1ogh6a6JK5fBONrUQVHjvBaNhBdH6ctYri1m7p4zuKUmN2Xc0JkpWX9382q5tzV3kXny9vPOzzmVQzKPZZfNJWgVodEA7UR1PiFFKD4wgYZOTjQ/dUW/YH3eZZgeU994zZTR2BvGUM/bF3mLrQwy3/57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdnIRKvA+4N1KmtJvAP2xlQFhqkjbsydwBkoCHRi7eM=;
 b=EgFzDu3Csml/71LiPLKTum/hjvCAngxY/kRTQnm4nfBNBTuJUj6UBIfdvyxih6ntEGVbhuafpyuQCs4ay1KD3xzZIndbEVwk5BNlK9vcPCLaio2uEjbGzBTZJHvXmbjoZhDC6nP+eftS52bPTGpPNQXu79Q8qOXt8STKiAeJofo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB5570.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:287::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 18:11:22 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 18:11:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 19:11:21 +0100
Message-Id: <DKN6203R3WD1.1NLN19VVBZJO9@garyguo.net>
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <jhubbard@nvidia.com>, <ttabi@nvidia.com>,
 <apopple@nvidia.com>, <ecourtney@nvidia.com>, <shashanks@nvidia.com>,
 <zhiw@nvidia.com>, <driver-core@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] rust: pci: convert IrqVectorRegistration to a
 lifetime-managed owning type
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-2-dakr@kernel.org>
 <DKN3U000UGRL.2MOXT25O11UE0@garyguo.net>
 <DKN5C359PZP3.2BPH5HLM9H0HY@kernel.org>
In-Reply-To: <DKN5C359PZP3.2BPH5HLM9H0HY@kernel.org>
X-ClientProxiedBy: LO4P123CA0157.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edb79be-511c-4c93-832b-08def89d1d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|376014|7416014|366016|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	nwqwXkprtCM6OVWCn4cLFPVHLp35uvQyDcnLpcpwI1xha1fOG4Bcz+VLOwnEnKjCTkfc/ws99xddEIn0eNz2+gyYsGSVV9itB4IkGilhTp84tL6STst4wm6P5dRB8LtkKLlnWLooCmIbZBM915OGYazZCvj8v3AgnZtYmUSz2LoS7qK1rbhoI+pX7VjxG/EBDuZxIoVvmZTEWY/IA9A36sEzv2w5erlqi2FRgCzKsv9QCQfBdM2KRoxG9vb73vv31CaxRMl2TNqoF1pZIm5ZKXaxxZ3Ba9LUZDJtKnNRSYj1Scb9NvY56xhcw8uO4A8dZC2naJYmvxsXzbVcijGSMn8iBEaEFMdLvzY7NkKYDASa6zIgD+78aiDXfILlV0YkcxFH07ek6p7rZe9WTOivgTdc35hpBSHpZbN39LJVnB1wrEZ3p91lhjVlQ0jb0YeEU52XPtRhziY5d6wGSqV4rYJ36RFY63GQnV0V3NK+L76AD64TCi0M9oHPBfsaju1Xos2yr8apz8kW1Nw/HsercYe0gB1ghdlzd0B7bgZiufaCjCdsdDwXDmlmhpP9wKjrklVtPQKTOs3nqYgxMfWlBGQ+L1/+X3ggEvCl1Mck4qfQN0moY2l+0IlZtb4q+Gm//WO83xDswv7AI232rreuqYdDR9RDTCf6HZoq2ja8nVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(376014)(7416014)(366016)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm5ib3RmeWNqQlg0OXUvWkkyL1JZa3VMbGowVDgvSFFOeGI3bFlzZ3E5Yysv?=
 =?utf-8?B?bnpUY0QzN09abk5UeG5kdnVYc3JrZG1XSXd3YXdxbFhuTDByUGlQeXJEN29Z?=
 =?utf-8?B?SGZJbnpQcGYyZUcyN3dmNTNPS0xkN2FMNWJBWDZyeVp3eFhCSXV2NHhGVzVy?=
 =?utf-8?B?NFRBaG43TjFDT1BDRjJ6NS93dzY1dE9ta1FHbWlMTDZkUS9jY1hoTkJUUmZ1?=
 =?utf-8?B?K3NWd3l5Q2ZERWR0cDhPSGhvSEhlUHV3QlJXTFZRK1djM09YYjVhRkZ5bk9m?=
 =?utf-8?B?UGdKakZleXhCYXR5L0thVW1TRGpEVndGeUFjZ1N3TmRCeU5HT2VEb1JpUzlX?=
 =?utf-8?B?ZDRUT01rbjkvcVk1QWUwNExwMkg4UGNtK0xHNDNxOVFNTTRlK0pBY0dBa0kv?=
 =?utf-8?B?RE95Ky85UUdBc1pjSjMraW5yVDVFL0VJRUIxNEpubEZFeUx5aXdGbHRLd2wy?=
 =?utf-8?B?SnFOcldVK1ZFUU0ybFE5ZTJGdjIxR2tVbmhGSkhBMGNWOHhjY1NRZ3VOMWds?=
 =?utf-8?B?b2FWV09FSFVjQnl1L2JsVFYxcTJ4MmNzRDVHekVvdmlKV05wWGJqTnlnOXVj?=
 =?utf-8?B?QzJITHhsV2s2Z0xvcTY1dUdIREM0UjlMVUpSQTdINmVHWDFRalRkcnRsRE5E?=
 =?utf-8?B?S2xHYUNxSmlxSzlmenQrZlpldHNFRGpiYmZoUGtDMVcyVmR0bk1rL2p0RUhH?=
 =?utf-8?B?RVpHVjVoN3JQSEsxbkZlTFRiaS9lOHBOZ1ViekN1TFI1NkFvMHZSeXlqMlF3?=
 =?utf-8?B?L1d3ajkzcUNSODMySjlWT1AvdkFlM2hiYm13TVZPTmtNOFZpc2VRZzZYOGw4?=
 =?utf-8?B?bjh2TWdPVjdhOVl2cHJFTktMTjN5YVI4aDg4R1lhYkY1Um5yMkljQXFtRXI4?=
 =?utf-8?B?dE1TU2xMT29XUm50dGVUclloMy9oWVJWMUVQOWpyTVhJRDhRQk9CU0tvN3Fm?=
 =?utf-8?B?UlJCS1E3NDRjMU5GRWxwRVJIM0hkZHFCaG5oYTFFZEwzQmxIbXh1SlpGNnNy?=
 =?utf-8?B?dHkvekM2RWUwUkpIVWwreEJ4bGthdjFlTndyWG9EdFFjTkYzdVNSWWRpeUZC?=
 =?utf-8?B?eVpNYXB5T1NaOHpqSm9CdkNGY2IwT1hQbldRQXpGbHB5MjNpdFo1NDlmTXF0?=
 =?utf-8?B?bTRVY2tYTEEyNkJUc1U2c2RJRzZ3UkdhUHlILzROblFuUXJWWkIxQ3RrQWx5?=
 =?utf-8?B?WVFUTW1ZOFB4UnNlT2IyRkZtZkJGQTJkYTVXSVErTlE1c0dVRXprVW4yWmla?=
 =?utf-8?B?cUpMTjJrcEc3U05aU0JHMlluTVRnSnVvRUZlQTd1eUxUTmRyOVVlSkp4bGNG?=
 =?utf-8?B?bHUxenlOOHBVUS9ndC9rbmJvREZoeFh1ZEwvLzhYZ2VhakFsYmJOZHB5VHc3?=
 =?utf-8?B?Zkh5UWZNQ2w5QkxwdWduRjFDQlJuQTh3WDJvYllaN3l2WmVLTXF4RlZNRDZz?=
 =?utf-8?B?eEI3cE1xeVRuSWxrSXFnV00yN2pQeVEvSkNHWmlrRThlcld0WEVDTFZHeFN4?=
 =?utf-8?B?ZjdtTCtoU2gzbWh4RWhhcURITGthc0RWajk5S0pDSXhUczZ4eUtmRGRWOER1?=
 =?utf-8?B?aERHVlF3SXg3ZXAvSk9Ha01vejV2bTRNMndMemQyOE1CRkhOaFdldGNMaGxx?=
 =?utf-8?B?UE13eUp1YVdqWWNWMEREVDFCUk92QkM4OE96VmYwU1J1b0ZGYlExRWgxUWRn?=
 =?utf-8?B?UFdNd3cvSkVkMEpIdXdQTzJsbVBhd0ZUWDFtb0ZTODN2TEVQdWVNVTNQZ1cz?=
 =?utf-8?B?SkZCM0NZS2FhTDMyVHhmRnZ3eU42Z1JyWENvK29uR25MdnQyV0xLVzRNK2ZV?=
 =?utf-8?B?ZU9kOS9mazZWM2ZzVTZHRmlSaCtDczZaM20rZFF0cnF2WE1wNEpEQ3NUMGRS?=
 =?utf-8?B?aFVOS3VaL3JoME5rVGNydHMzZ0d5M3VWZWt5MUhRbFRVdno2ZTlMdTMvbklv?=
 =?utf-8?B?TVV4Z3ZINEIxeGZJNGplWWRSR2pnVldtTzBJZjY5WDJjTG5HWHFHbjVFY2VL?=
 =?utf-8?B?eW56TGZQd0ZKdkhhamV1MElSQW0vMStJNXFHajlPd0Nrc0NvYkRodUhpdFNX?=
 =?utf-8?B?dUY4bXFvNGMvZzh5VElEZE54WDlsWUZEcXhGL0UwWjVmR2V0MTRhQU9oMFhj?=
 =?utf-8?B?cngzSmtDUTRrY3cwaTNmRjVjbXZMQTAxMTRmTkE3ZzVZVlVjTzFSY05ITjVB?=
 =?utf-8?B?S3hrNldHQXN4L2FKWFZoVWtaVCtSajZSdVc3RFA1YUk1VENDVGRCN0t1V0R3?=
 =?utf-8?B?T0hpa0tRcTBqSWc0eXNVbE92SDVRRDhkNGR2eU1HZXNVUG83eC85bkdRUlAw?=
 =?utf-8?B?d0l2eDIrYTMyRHJGSk9FTUsxVTBJMFVLeE9vdHdZbWV0WWxqMnd3Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edb79be-511c-4c93-832b-08def89d1d70
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 18:11:22.1526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADwHht4eSGYiTZjqtqrfwexcLT7s292RU6++nNUPms6X5MfJddD1rKo5hwu5EnEeSn8DtHJGY+GMvk7N4Fnq8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5570

On Wed Aug 12, 2026 at 6:37 PM BST, Danilo Krummrich wrote:
> On Wed Aug 12, 2026 at 6:26 PM CEST, Gary Guo wrote:
>>>  /// IRQ type flags for PCI interrupt allocation.
>>>  #[derive(Debug, Clone, Copy)]
>>> @@ -78,6 +75,7 @@ const fn as_raw(self) -> u32 {
>>>  #[derive(Clone, Copy)]
>>>  pub struct IrqVector<'a> {
>>>      dev: &'a Device<Bound>,
>>> +    reg: &'a IrqVectorRegistration<'a>,
>>
>> The registration has a refence to the device so we don't need to keep bo=
th reg
>> and dev?
>
> In this patch dev is still needed for the TryInto impl, but a subsquent p=
atch
> does remove it in favor of IrqRequest.
>
>>> +pub struct IrqVectorRegistration<'a> {
>>> +    dev: &'a Device<Bound>,
>>> +    count: NonZero<usize>,
>>
>> I wonder if it should be called "len" as I view this as a collection of =
IRQ
>> vectors.
>
> Either sounds good to me.
>
>>> +    #[inline]
>>> +    pub fn vector(&self, index: usize) -> Result<IrqVector<'_>> {
>>> +        if index >=3D self.count.get() {
>>> +            return Err(EINVAL);
>>> +        }
>>
>> Given that the error is for out-of-bound access only, perhaps return `Op=
tion`
>> like `get()` function of various containers?
>
> It's not really a case a driver would handle other than just follow it up=
 with
> .ok_or(EINVAL)? anyways, so I'd like to keep that.

Well, I'd expect some drivers want to do `.vector(v).expect()` rather than =
just
propagating the error if `v` is a constant that is less than `min_vecs`..

Best,
Gary

>
> (Further consideration on a subsequent patch.)
>
>>> @@ -256,7 +249,21 @@ pub fn alloc_irq_vectors(
>>>          min_vecs: u32,
>>>          max_vecs: u32,
>>>          irq_types: IrqTypes,
>>> -    ) -> Result<RangeInclusive<IrqVector<'_>>> {
>>> -        IrqVectorRegistration::register(self, min_vecs, max_vecs, irq_=
types)
>>> +    ) -> Result<IrqVectorRegistration<'_>> {
>>> +        // SAFETY:
>>> +        // - `self.as_raw()` is guaranteed to be a valid pointer to a =
`struct pci_dev`
>>> +        //   by the type invariant of `Device`.
>>> +        // - `pci_alloc_irq_vectors` internally validates all other pa=
rameters
>>> +        //   and returns error codes.
>>> +        let ret =3D unsafe {
>>> +            bindings::pci_alloc_irq_vectors(self.as_raw(), min_vecs, m=
ax_vecs, irq_types.as_raw())
>>> +        };
>>> +
>>> +        to_result(ret)?;
>>> +
>>> +        let count =3D NonZero::new(ret as usize).ok_or(EINVAL)?;
>>
>> I don't think `ret` can ever be zero. `expect` or `new_unchecked()` perh=
aps?
>
> Correct, but I don't see a reason to BUG_ON() for this. A WARN_ON() makes=
 sense,
> but I see this to be the job of the C API making the promise.
>
> We could use new_unchecked(), but since this method is fallible already a=
nd not
> a hot path, I don't think it's worth.


