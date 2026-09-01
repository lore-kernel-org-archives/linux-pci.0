Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2A40DFDE;
	Tue,  1 Sep 2026 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271749; cv=fail; b=qqrVDOo79SlZ/6VsoZdf+yp9eL5eFEUoY/S7/0ijHQnUspbspOjKlezWJazvWekiLO+wfHYAERA6gQm26ItWvbNEajJXMpCQG2QmmMqfp5OR6LQ5GratPTa+z3DVGGAl1Kvjh3CzPoSeHw6Ix9PDUPH0kEG02fFwYf2m7cwtsns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271749; c=relaxed/simple;
	bh=LSB3TsMcAxMm4FcTwp44waVtTALbaUZkC7k9aZSOzb0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=A4MHmfRnjkbmu5B4p5MDXA4rtRRbE7IT+ETTROAaZby/xz2zsVRYyOhnY8rIeopT9w4YMkCUepbCGMgbo+FySVcb6MN4qiKJRBuY6jTIGh7hlLkGJGhThgWGXI8vY8GnPoaa7rKknBgUOGLgl3Sf2B4dF6kyd9G8t/7p7V8Opu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ROzEF0ym; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ROzEF0ym"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swErAnAjjdXMBQCqe2+slhpLGfvHIxjOYf2axPqeQOP0Wnlsc+BFCNTlFufz95osFEunhQCRwY57pNYjQ/prtGIMU2MDLQRWMp7jH12EBuE1UExmlzmx1dIusIH5JEQpInxoUg5lsvDYOr+R3YpxeiNRdn5hlA90FFgu8iFrEwkCvDcTyGAlNe0Ih/PlhfheOS3srmuqoV+oap8CVWsX8/O7joMo5YEzX4q2bBVuKUtHeIwbL8WS4jK06ihc5oit24fyDF2KdIDrb0ODS07nsGNvjlgnJ+0dfagO3srYeUQW/zdw4E07tImoawyIGiSRj9MS8PKcR6f66z1yeWMM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P66j6KJgrrDRJau5uQaHdtlb6BYaI4i4LxL/fjbpaHk=;
 b=hTwDfMFq8PCESAozUPte+MwbGoIZ4opy4AcS5cvGBOrCOr3y4SDvV7CF0nX9CT0cmOJh9a4az7ZOw8HjkxIBDyC2rRVmfyjCzq7Ukp7BFxWbGmulPqU4eIfTnnMc28zsCou5ruYP7uyztvakc93Rojmq30jQqn3HTGC5P+sVArDkoAj3mCsmitEqSHiq8UJm2LF7KcoApz48luWCRKZLSPrYKHTrug/HDiEszY+5U1hixrgs98DugliqjV6JESoCG0MP+NJttkqFMKaTOoZBC4PfNDOFwVkPuakn1poDTF6+l1Go7yvJD6Dzn6BxyssZhofETvVlv9SPyu8hHk2Qzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P66j6KJgrrDRJau5uQaHdtlb6BYaI4i4LxL/fjbpaHk=;
 b=ROzEF0ymximqW887AEYkOhSaj8jveqjRwdWHH9FPKeS/nA/Me3qV+PqAKFNLHgpu+qG8WomIfDpQ8OrTXiIHlCs4BZv50mPNGE311dHGJrn/ppJ2UOJVzqPG3piRNxeyYK6s+EfV5Aa6i/TP8mpiFxI9b56ln/8rj1umgN2Jngg7yHfTg3VilrnMNUO/Gf37m4xkD3XcrTQeo1Xyd9fcmwkI52sjuTaQUMuJGBEA630uJhbW2ox5wrgkTkGYiKOhmcUXf+kDlsnieFdhmPdPyhob2UD0g5f7907eCS+4USgvEt7i/DmZFay7qr/z4t9X3Tv0ijEJYecnv5KLj09xbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ5PPF4C62B9E70.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::991) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:08:43 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 14:08:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 23:08:37 +0900
Message-Id: <DL41F1VLHKH1.2KME3J6V7CZH1@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Sophon Zhang via B4 Relay"
 <devnull+aiqubits.hotmail.com@kernel.org>, <aiqubits@hotmail.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] rust: pci: reject IRQ vector indices that do not fit
 in u32
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com> <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com> <DL3XLHXS647M.1LMHQUVX5RTI@kernel.org> <DL40NH1AX8WN.2ZPY7GDL0FSEW@nvidia.com> <DL40ZHH4H6B8.284J2WKIMKRDM@garyguo.net>
In-Reply-To: <DL40ZHH4H6B8.284J2WKIMKRDM@garyguo.net>
X-ClientProxiedBy: TYCP286CA0259.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a0f429-c353-42ef-86fb-08df08328631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|1800799024|366016|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C4AazgNKIgTGNwXFGcO51N4Q1sNZ3E4i8lkdGZZ7oJmk/v4NYvZfRmwH/Trwh9X06k1vc9swd/zzuaTq7tjKc7d49LefINnFgWIMRfuzJ7imfLHu6IjPTV/ClYE0SHVIr+3xyM4k5C8ul0zFH8gKp46vV+RuM6Td3Bcydy66TjW4U1HwuZHkYGuxMcI6MeEOJPkPMycsww/qMYcse8wRDDmB8rVs26VlyGcQROr5k32B9BlIaWuIselq7PQrY5d7BMHifmwzd7GoD/WYr+7mA9DBEYUWtQ5/UUmEBwQ+oLoHjCyzwn42JALoZ1AX9yGiNhuFJGNZGTsaMMoDg6/+D5UVlYlgybqr/D40jF12Ndc9bqsihPZBq8t/Mg15Zra3jCzTnKNl8nnHw1o4m7N1pgghu15vKsuEuFHL/rf79zQGzDryKdH1/oVMTPdkrcEYTTKfUeOJ4SSgMKX+4+LSE5oB/tIRqnCe2vhB+kR/R/wCG+ikFzWN31dRfLmj9IrCrpQAxk8bhw0WErzfwQVWOpcjGJIeZdkSC7pSeqSGup/80tEmpf0FSLdpJsat21XvAz2RVXdjO2G95V7LuXrU/FYITqxYCE7omnlX5/YITSRS7Sfa4SckL5I93khYc6mecLvsR02GiwbjI6bTj/r59zIAokeRScQdX8C/6vbjNJo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkppSlBGL0QybmtkakJIa0d0YkJMdURobjRqOGhKSmRWS2VZZ0JoWTN6MlVR?=
 =?utf-8?B?ZFF4OGJScnhTM0hyUU8wbXl2RUl4ZVNmZ1haamZBdXlIK0s2NzdBcUZ0Z01k?=
 =?utf-8?B?Q0o1MVdmbHU0WTFpNU5Va3ZvM3Q5ZDlGeC9SR0VUa0pRVEhyUENaN2J2TThM?=
 =?utf-8?B?dGwxckhNSmhxK2YvS0x4bEVGSVQrU3lvWjRKaVoyTGtiYUh5OUZvUG9KbEc4?=
 =?utf-8?B?UVpLT2x0MWtiVFI3OEF2clVjL092akp1TG9aTVJaNnkyQngzRmJRVmJLbW5k?=
 =?utf-8?B?NUI1eXlkaHZnaWFZU0lzNHN4elZBbjllaEJzTjdERFREcC8vVmthQlg2Rjc3?=
 =?utf-8?B?VHMzMUJuSFBuUzFOcS84Rkh5OFlULzNpaFFYSW03OTdVeHZkVEtYZUtwOGZx?=
 =?utf-8?B?eXFBQXpEcXRoUjdkeE13NDlYM0JVNkk2cG1UOWRUUnJGa2ZWVTJDQ0czNTQx?=
 =?utf-8?B?dk1xT0p0RERINGp2SUVHY21RYTVJalgrRDVmT2gyeGhuZm9QamorT3pJcnYr?=
 =?utf-8?B?QWJRaFlTYThDdW9BUFYyYzc1UGVpVi8vVXc2Q2szZTFxa2NjWjFURFYxK2x6?=
 =?utf-8?B?eWo5RmE2ODN2MTVYWE9xeFd4MnMrSHpYMkNBQ0luLy9qVnlaVnNtWlB3WjNC?=
 =?utf-8?B?dWZPeit4Q1YwUVVIUXJWM1N4ekhkOCtrM1paY3NaVzVQaFRqbWltODZ0Sitz?=
 =?utf-8?B?ZGNodFVtaUZiY0hMTy93MiszbG1oa3A0Yi8rb0FzcG9EY2tnWEtNT3kxRXZY?=
 =?utf-8?B?amMwSWI1c29WK1dSS3lmemxLUlRlTXN4V2NLK3ppL0FGWEN4clgxNFNpVzlP?=
 =?utf-8?B?RnkzOXdTY1dTYklNeHhYNWlqalBtMzNSUE9UNndiblVkVFczRU1kWXJFVEJt?=
 =?utf-8?B?SGxBdW01NjhJV084YUk0V1IwM1BGSXNLR0RHakhjMnEvdjlCcTAxNWFFNGVl?=
 =?utf-8?B?cUtVQkk3R1h3ZjNoaXBTK3FFSGVjdnlkNmNaTzRXZ3FoUU1sWWRDQ1pEUUFh?=
 =?utf-8?B?QlFoaW8wdFlLK1owRVhJSGtIZ1JHcnJRNUtPdzhGcWhBU2V3ZVhwUmdKVWxq?=
 =?utf-8?B?bXpOd04yMUx5WjlUQWtNanA0WFhYejhCaWppTzNZUG1wdDJqTEdjc3BJdTBp?=
 =?utf-8?B?dWVpYnFweU9GeWY1MlJXd1VFMzEwRmVvYTVUbFMzTytsdnRRSnZDeUJOMy94?=
 =?utf-8?B?MTFjcHlKSDdpcXU0bzQ5OFk5T3ZoUzFqWmdGcFk2TU5GMjJqTnBCSmtwRXhN?=
 =?utf-8?B?ZU1hSnZwSzZrMVZVY25VYkQrcTdxTDBtRVhNbWJ0MkJ1UkNQVWNYbFRDVHcz?=
 =?utf-8?B?dzcvOWlmc2NJaDBUY1FLa0NvelpZWDcwVTkvVXdSSW5sUmhGQktJSUdCWE10?=
 =?utf-8?B?cHR3QzdzL1QxVFplTHRCdUZQU21qMWRzVjdnOGgrTlBjVnR6SDIrVC82RERs?=
 =?utf-8?B?RFU3MGN6dzMzRFpUQ0RoNUtRdEkvMm43dk0wNi93TkVXMTN2NnNvWE02UjhQ?=
 =?utf-8?B?NTA3Vzdrd3lKV05STmY1M3hTNWk3bVVtRHhHcGIwaVM0TmI5di9MQ2h1MUFs?=
 =?utf-8?B?ZEZjN3N5TlBTY2JxekcrVllaK1ZKcG4wRlliRjZzZkdIVWw5U0ZlcVFHRG4v?=
 =?utf-8?B?VE9UZ2V1ZVpIdDhoTGlXTWxPcVdUN0YwZ1Q3SSsrSlZibEFWVlM4U3dQa3M0?=
 =?utf-8?B?OEFibVpIRjlnREpoaC9ZQkcycS9XaFRib3hBdzlFZ0tTSi9ZeXllYyt3NWxn?=
 =?utf-8?B?MjFXUFlSSTdrb3YvR2Zha21EeXdmdFByc3hKVVFRaGJqbjFXOGZ2R0JZTHIx?=
 =?utf-8?B?aC9FanI3T3R6cTA5SDF1QkI1Q1plQUxvVGZhT09YcWxaa1ptSU1GdmJTMWxs?=
 =?utf-8?B?QzJ1aUVOR3o2T2RBc3BQYzRDbWxKWWU0WVlIU2VZeVpKb2R6OUFoNk1RcVhx?=
 =?utf-8?B?REFheE12UERockVTQm1IWXMybUh5OU9iWVlON2Y0RXY4WjJ1Y2g0Q3FaZFYw?=
 =?utf-8?B?WlJsdDNCMkR1aVJyVkRWWU96V1QxNDZ1eUt3VjZDMFFBaG9vUVdWN043eklH?=
 =?utf-8?B?NHFySVRZUThaNktWUWFHNk0xSzNEbFlVd0NsN0RRbXhCUE52azFzNDE0SjhP?=
 =?utf-8?B?SEZscjJLc2tobWV4a3JqcEhiY3d0ZHBLREgvZnAvOHo3QTNsUjBkb3NhWVNp?=
 =?utf-8?B?dTduL0J1TGEwSE02R1BQcFJXU203ek9VcXkxYVRVb0hETTRqbXRrdnFWdmJu?=
 =?utf-8?B?dDl0V0lUK3c4SWk1bHFPMDAreER5N2xaOUxJL1QzYnZpa01XWUZWL1JsZm5Y?=
 =?utf-8?B?UHd4cHpWUndIS0laOFdUdFdrQmtZaWtpVEU3NGFndXorTnk5Y3VsOUMvTW51?=
 =?utf-8?Q?UoS8JtmFg9iJVomzGx71SbS0K8iReqKNBtAggSQT1TJvD?=
X-MS-Exchange-AntiSpam-MessageData-1: 0tSFdab2WK1dxg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a0f429-c353-42ef-86fb-08df08328631
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:08:40.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtXKCqFPOgO/1eQnjeDHvSd4cFWGdUUv2RbGA4kCTx6cHYAAxIaBxU58F1Az76+dUlVUonuu3FiRwTo7gdBGpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70

On Tue Sep 1, 2026 at 10:48 PM JST, Gary Guo wrote:
> On Tue Sep 1, 2026 at 2:32 PM BST, Alexandre Courbot wrote:
>> On Tue Sep 1, 2026 at 8:08 PM JST, Danilo Krummrich wrote:
>>> On Tue Sep 1, 2026 at 12:58 PM CEST, Alexandre Courbot wrote:
>>>> That makes me wonder, shouldn't we make `index` take a `u32` directly?
>>>> If that's what the C API expects, it does make sense to align to it
>>>> instead of forcing users to make a potential unneeded conversion if th=
ey
>>>> already have a u32.
>>>
>>> I intentionally did not do this, as the common type for an index is usi=
ze. Thus,
>>> I do not expect anyone to already have a u32, but to already have a usi=
ze, e.g.
>>> from some iterator.
>>>
>>> The fact that the C API did pick unsigned int as index type is an imple=
mentation
>>> detail the abstraction should bother with.
>>
>> Thanks for the clarification (and Miguel for elaborating - I wasn't
>> completely aware of it!). In that case this patch looks correct to me.
>>
>> Note that there is another `as` right after, in the same method:
>>
>>   if irq < 0 {
>>       return Err(Error::from_errno(irq));
>>   }
>>
>>   // SAFETY: `irq` is a valid IRQ number for `self.dev`, resolved from t=
his registration.
>>   Ok(unsafe { IrqVector::new(IrqRequest::new(self.dev.as_ref(), irq as u=
32), self) })
>>
>>
>> We could get rid of it by replacing the `if irq < 0` test with:
>>
>>   let irq =3D u32::try_from(irq).map_err(|_| Error::from_errno(irq))?;
>
> I wonder if we can just change kernel::error::to_result to return `Result=
<u32>`
> instead and have the cast there?

Looks like our messages crossed [1]. :)

Converting `to_result` would require quite a bit of work to update all
the callers, but maybe we can introduce a new variant indeed.

But this makes me think of another step we can take to harden
`to_result`: it should probably warn if the non-error value if not `0`,
as that would indicate the caller needs to consider it.

[1] https://lore.kernel.org/all/DL412XWBP4Y2.K1TH9NELBKPR@nvidia.com/
