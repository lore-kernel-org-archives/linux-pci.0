Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2A47AF61;
	Thu, 15 Oct 2026 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051369; cv=fail; b=Ve9wpyaRRwFiJU40UjB6LtdEJJtJrDmUq9ZGHKu7OC0dsIPkH4wSgMfvf85//eAB2JT4U422xXc0bjCg53Q6x3fpd6lSRpWUypLERRA9ScswNYkMexy4anaK6VdaaCI8DyFjms9U9P4pPrdjztDjfHvOkEBkiXXwScuhBCIkqQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051369; c=relaxed/simple;
	bh=8minJOdYvsS1PIpF5/bEHOulAkh6vtCN2uHIshhZDI8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=GVVt/ZhFRxydkFGyhvflTrwn1bpqvq+ecdXjVDF2yRVRsseLY5aO9oOcn5JMjcnktYGHqJLoLsPmvzVosNRANK2kV6dMPqU8T/r0sTGgKPHjCNAXU3fNqPRvUeTawDnWbo8sp9r03ffCPduIZYhtSw3Nv2htBC/GMvKLVAOaQrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G94AkJY4; arc=fail smtp.client-ip=52.101.57.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G94AkJY4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWXBKYyELH5SWKsigdbxcsyN6oIV5qXTOtiD5vZLSV0fHQIXREGKTIGsSq/Wgmb+ZmJ+HrjwDy5YEUkx/wppCxLpTuNnxqnZu0D0ccc8UkVDSMUZ0U6Fqlstwa+vvC9tcGOM06RYpFHmQSvOKy44XVeVC6VHE+xRHOpy/+IDBGwtgn15LgVDmH30iy+54VbBlHRrkhMzPGgWd3bpB77Lao6cTd/6w5CipmWt1mBnCNkopQpX6fL3d8Sqwcfz0q7HvqMvgj6eV9t3SW5yCOGIYHTaWje8h+9HF+BPZ2P3e6cWSK4f8wcdmz8vrOdeSOfIEoOb6yhj3jg4XxfhoL+Ifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8minJOdYvsS1PIpF5/bEHOulAkh6vtCN2uHIshhZDI8=;
 b=hh+jmDCx5P2VhQIaL11oGAWdfX90zAmOrBzNkqhVREaxTDtihX5aJYFXrWeghRmVbDjZfaBZ9UONZ5psVNSuEJNNazn5chHVI5CcgMvdH7VtYOFxCVWSS5t2JVFTRYKiwMq7emXKfYJhs0rYE1pBe7jPfBwWfxwgNtepnmRxfdeBI5seTmQpUuB51w9HTroVq12Ij6R2RI4ArnoVCh+JFrDG/gvlxpTcfche+Jo5yiv1TGjBCpgSfji6PXK2sSvNjSlFR4wetF+1fs7f9oygxTDad/vdpvHhUgyUo9PGC7zNWJ2AC3VzRH54+HCmSeZW2/ZWVsmeO4LVojvdqm2YWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8minJOdYvsS1PIpF5/bEHOulAkh6vtCN2uHIshhZDI8=;
 b=G94AkJY4QTeiUMNqGtNKg+pAvDdUMYW7CBrh/fyhXgZdl4lHr6ahEPYV11POPrQ0IpjOLRx5C8j+AaJNV1KJr2ByNr8LD+jaMAbqvxTp4hBzymxztmkcViBcR/YoyDih7MYca/eLuQ3NPUEJwPwjlXeBCMjrnqY2zg2vb7SD3L26fp9UUhnfp7C3xFZkwwsBY1lqOkmMSE4OGkvaVjTD0mAKJHr6Z5487s+K31VjGIWP9TZixusiL0NrFqDwOrnxLZHHQ2piA01S/hsrWIdgUrbrKG7TjAObl01FULd5cOkkAjP70KayOy4HB1VnVClfjSoAYaM5nXjU+JN8FcwEJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 15 Oct
 2026 08:02:43 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 08:02:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 17:02:40 +0900
Message-Id: <DM596TT7E841.1U05OKY9N6I6C@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, <lukas@wunner.de>,
 <linux-cxl@vger.kernel.org>, <akpm@linux-foundation.org>,
 <Jonathan.Cameron@huawei.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <jic23@kernel.org>, <bhelgaas@google.com>,
 <alistair@alistair23.me>, <djbw@kernel.org>, <linux-pci@vger.kernel.org>,
 <wilfred.mallawa@wdc.com>, <a.hindborg@kernel.org>,
 <gregkh@linuxfoundation.org>, <alex.gaynor@gmail.com>,
 <benno.lossin@proton.me>, <boqun.feng@gmail.com>,
 <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>, <gary@garyguo.net>,
 <ojeda@kernel.org>, "Alistair Francis" <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 00/22] lib: Rust implementation of SPDM
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alistair Francis" <alistair23@gmail.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <as_r8n7p_wdbChuQ@google.com>
 <CAKmqyKOkmwompJqaP2k-oJicmXmqHY4E0wuLcrvkHLx+oauQ2Q@mail.gmail.com>
In-Reply-To: <CAKmqyKOkmwompJqaP2k-oJicmXmqHY4E0wuLcrvkHLx+oauQ2Q@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: e47b8bab-94cf-40b4-ab50-08df2a92b0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|6133799003|22082099003|3023799007|10067099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xuRrFT6CIRfPU7mW1l7j3Y9sbhBklN5WdzJSsdvkD/EYr0mkPrTrrBWML+kLzzqu9CVQj64OCUH4aofCq3rWFovikriIbiDmDEfc7vi0A+ZZ/gelB2vDTeASdY9k+2jaZpTLtxEucD98x5dvUW9sDVWHyqRAVkoCpD/w9EKJchV0kcoF1pGKWFaHgYNPXakjNwDyUXRdTFfQGPNH3cSPs4XJlg6KHJQif8ZU/WXw5Hof4N5NivwaZyQd0/nKAbyqO0IpFjky1QcYl/CM50DdNMzt4FFCfAZJtS7yTX0GoupBW4dBfZozUjHqGTfShGl4hhzXzYq2d0CF0/LxRbv6Hu05AeNqVTiQkC7t/x6eGnJoxS/qfUhTpMfPysizYkuDEJcS7GIMJNl5gvOuIa8D255ufgFMSe72xtAm4M3s7fh9hng4Nuxva75VcbPoaMYnwXDVxzQrCjmt2RQOfJ2+RHjYFTUwRg1P6bcoCQeFKHAOvmB9PyMfVWNBSW6BQZ48h+d1kvOe0m8UJuNEyUTyWu++1suFCk5YIYzv9McmmbVRlSYOvSY0vVsDfG25VN4Yq4Jh1kiEtt8AkfyaKkojrbRAMPNygkV2nFPIyCHmPmOmkRBrGX4U60bm2zMhTaWhZb6V8vE92r/535GemLpdNb9VvMsgFQdUYo2vsoiuzWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(6133799003)(22082099003)(3023799007)(10067099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUxOdEJ3NFBHK24vcnQzU3BDV2NsMXVhZFdScUJJbTlVQ1NsRE5nK2Z4czR3?=
 =?utf-8?B?SkZxSWRjZ2lIMFpnaThtSUlFby94Nm1VS3RWRXlzZVFnK1QrN1dzZVJJWFdx?=
 =?utf-8?B?MjB1bzU5MjlCUVFKZ0JVbTIwUURIaUlMdFRTNFZkYVdwcXJDZUQrdnhGT1JD?=
 =?utf-8?B?NUlYYmlLSnBud2JvRmdtYTRTK01JTldpMEhCaURRZVcxUVAzYWRSQTAyTlBk?=
 =?utf-8?B?Z2kzbUhaWGVJZitkNHU0U056S29SVUpSSTJGQ0N2Z2oxSVN5ejNrbHFKdFZP?=
 =?utf-8?B?WjJYQ001Z1VUTTNHSlNyU055cFg1V2hEQWc3bmF6c09hQkRxV2hVTU1ueklO?=
 =?utf-8?B?dkV6QXpLQVFaQU15c1h3MkFwcHZXYTVxYUE2eUtoUHhSb01pOGdYRVQ1ZGxL?=
 =?utf-8?B?WSsvNGRhMjhTYVhlRmt3RjJmOVhTdndnanpuSUZpSHBvZWJIU3BrbmxGSVlP?=
 =?utf-8?B?MUdxbXJYZGhRV0V2K1ZyZFEzZU1wbUVEbzc4Vml6Mmt1MDhXUUdIdmcydTRh?=
 =?utf-8?B?azY1UVRFSHBzWjJ3ZFp0TG8zR2xMMTAzKzY2OXpUUkt5V2dNUkZlcC9mN1I0?=
 =?utf-8?B?eEN1ZkMzaGJwZkdkdU5qc3ZlRmhVSkJrdFdMbmNGVGRHQXlFVWFjNjBVQVh0?=
 =?utf-8?B?N3ZnOXZkdmoydXIxRGFXYzRJd3V6VWlHWWlYR3o2MjZKV25sa0FQZENOVHdK?=
 =?utf-8?B?SFJ0NjFLREtBQkZEZUE2U1BzdGNpdTRqRW9EamkwUHdPczNhcGRzdE4zVkI0?=
 =?utf-8?B?TnFhRUx5allXVkNEMEMxNHRvMGlyakk0UGZmQkJpL0NGenE3c0d6bXoycmta?=
 =?utf-8?B?di9BTzYwU1c0ZG1QVENiM3JaSXgyVmRab2NaNDBtNXVkWWxPOGFmYUp0Qmtu?=
 =?utf-8?B?RzBMVFhaKzB2VU9pcnpzcWJsTWpjRnJ1Q0lDaDZhRUhCbnpCM3FFY0RVb0xI?=
 =?utf-8?B?T1hDbDdHYzBFTksramxwbnlGSHlRd3hER3ExRlMyYjlXajcwZ3hhTUREN2hr?=
 =?utf-8?B?SFpaTnRqRTNQRGQyMEpIVElNaVFKUzF5alR5Q0w3MkhqOVZYZ1lJa290dkJi?=
 =?utf-8?B?cSs0SlpsMGhBTXdIRnZpUS9DTHA3UnYwQ0Q1aXpkNGw0TG81OWthTTg2MmFy?=
 =?utf-8?B?cStoMjVLMXNBV21qRW1saTAwTlo4bGNmNVk4NHFFMjRFck9jUzJXSWFRSzEw?=
 =?utf-8?B?ZzR4Q0RVbXdjZVdNeHRRMjhlWGhWRFlEV2JsYUFTRGdPMWl5ZnhxRlFmWWdY?=
 =?utf-8?B?cU40NE5nRjNKS1g2c1g2UFFBblNSM3lDaElpRGlwcS9EelljWjZESm5oMU1R?=
 =?utf-8?B?RzhOTGZlM3ljdU9lckhTQVlIYUJxNDQyOG1BZU45QzYzTFJCWTZXVDdHZkFt?=
 =?utf-8?B?NUR3bmpVbDBBRGowbU5VdHVrdmw1TnhueW5pOFJJVkVQNVdoajdwaE5TT1Ba?=
 =?utf-8?B?U1l2RE9pUHp2NVY4ZDF5NmFORVVOYmx4dXNmUGZOeVFCL25ESE5oSDIrRHZZ?=
 =?utf-8?B?cU5weTJkY0M0ckdSOXNudDRzZUIvWERya1ZnT2VkWVNBRFVROUx4aGdNVlRP?=
 =?utf-8?B?d1k1MURUdzY3SjkzSTNxU0ZtTkp1Y1BvbFMzMi9ORE5qM0IwZU0wSGhCR1RW?=
 =?utf-8?B?cElsRjNhY0N2Tm1GM1lvZUNwdG44czhoOThLcjNrRWhmNEg1QjNJaHVxUHNO?=
 =?utf-8?B?eFc0Ulk4UktUNkU5QjBocUpCUlFtbFlJV1hUVjdLRWd5b3dmMVB0WWVrOVBY?=
 =?utf-8?B?enpMRVB1NXRBOUk4NkMwNTBrdGF6VmQ4ZlI2U04rcXE0QVpXeXdIcCt4SE5k?=
 =?utf-8?B?Y2h4aGcrYUZ0a0NKSVM4WmhVTVFNMDFBNFkrOW5Kc2VVUllXYS82eE5nMEVx?=
 =?utf-8?B?NEwwb2F4STFPclM3bk5XaTZtMVdweUx6aWl0V1puNHVjTFphK3V5cVk0d3N0?=
 =?utf-8?B?SjU5ekFQN0M3SWJPWkc2T29ralRXUjBvUGtGSVRVU2JaUHovZSszSURzc2Zk?=
 =?utf-8?B?SEFUL1BPNlRDSE03Smdkc0RpR0diVElzWXJ1QU0vNHBhVS9pS0JrUHJEdk1h?=
 =?utf-8?B?UVRTdUhpY3JNWG5DUjVad2Nrd3dsV1Y5NjNJU1drUEZndWZaZ3ZCYlRQVEpM?=
 =?utf-8?B?Rk43Yy9TcUN5eHhsTC9XQURVS2dXbWNHeHFOQmQ2NXdZeXlSTUltQk84WHYz?=
 =?utf-8?B?MWd5V1piRGsvOC9JSEdnT1V6WTd4Y0F2L285eFdlSTVqU1JYVDFoMG4xam4z?=
 =?utf-8?B?WmxVd3ViV3N2S2d5TElWR2Q3bDd2azlQL1BoN25qbE54MEw1d01PWERVRC9q?=
 =?utf-8?B?K2xvcXhwbExIZlRDSzBSeHQ3UG1UNFhoUU83ZjA3N3p4UUwvVmhJZTdqODkz?=
 =?utf-8?Q?/qhMAkbAs88dIYrEgJdOsYQhf39HLWc+51vPnosWHZ15/?=
X-MS-Exchange-AntiSpam-MessageData-1: ovZRbiyw6EgBng==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47b8bab-94cf-40b4-ab50-08df2a92b0dd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:02:43.2450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6A1c93L/hRAanpANKDUVvitWCw0Mo7FxPmLheUhxFgQr+2sLZmZT6QatHGOBhlCVuqOFD2Z0VHLzqFDyYpIQAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870

On Thu Oct 15, 2026 at 2:23 PM JST, Alistair Francis wrote:
> On Thu, Oct 15, 2026 at 6:54=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
>>
>> On Mon, Sep 28, 2026 at 11:11:01AM +1000, alistair23@gmail.com wrote:
>> > From: Alistair Francis <alistair.francis@wdc.com>
>> >
>> > Security Protocols and Data Models (SPDM) [1] is used for authenticati=
on,
>> > attestation and key exchange. SPDM is generally used over a range of
>> > transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
>> >
>> > From the kernels perspective SPDM is used to authenticate and attest d=
evices.
>> > In this threat model a device is considered untrusted until it can be =
verified
>> > by the kernel and userspace using SPDM. As such SPDM data is untrusted=
 data
>> > that can be mallicious.
>> >
>> > The SPDM specification is also complex, with the 1.2.1 spec being almo=
st 200
>> > pages and the 1.3.0 spec being almost 250 pages long.
>> >
>> > As such we have the kernel parsing untrusted responses from a complex
>> > specification, which sounds like a possible exploit vector. This is th=
e type
>> > of place where Rust excels!
>> >
>> > This series implements a SPDM requester in Rust.
>>
>> So I looked a bit at this, and here are some comments. I will not repeat
>> what Alexandre has already said.
>>
>> First, I'd like to say that it's good to see that all wire-format
>> parsing in lib/rspdm/validator.rs is written in completely safe Rust.
>> That's exactly what we want to see for parsing in Rust. We want the code
>> to have basically no unsafe code whatsoever so that we really get to
>> rely on the bullet-proof guarantees about bugs being caught at compile
>> time, or at least at runtime.
>>
>> Unfortunately it looks like the same cannot be said for the state
>> machine in lib/rspdm/state.rs, which has way too much unsafe code in its
>> interaction with the rest of the kernel. There needs to be more
>> intermediate Rust abstractions here. This file should not have *any*
>> unsafe code, except maybe 1-2 blocks for using the C transport and
>> validate function pointers.
>
> Yeah, it's the crypto functions. There are currently no bindings, so
> it's just directly calling the C functions.
>
> Without the crypto functions it's just a single unsafe call to
> `transport_function()` in `state.rs` and a few in `lib.rs` to handl
> the C <-> FFI boundy.
>
> I was trying to avoid adding crypto and X.509 bindings in this series,
> as that's a few more subsystems this ends up touching. We need to add
> PQC as well, so crypto bindings are next on the todo list once this is
> merged.
>
> Is this going to stall on adding crypto bindings?

So without going all the way to fully-fledged crypto bindings, you will
spare yourself and your reviewers quite a bit of pain if you at least
implement a safe and lightweight crypto wrapper that is local to SPDM
and could eventually grow into official crypto bindings as a future
effort. As it is the code is very hard to review: for instance
`crypto_free_shash` is always called after `free_desc`, and looks like
it could/should be part of it, but that's hard to assess as the crypto
code is mixed with the rest and called here and there. I just cannot
tell whether all these unsafe blocks are safe of not, which is a problem
since the goal of writing this in Rust is to prevent exploits.

A self-contained crypto module exposing a safe interface would remove
that burden, reduce the number of `unsafe` blocks, and make the series
easier to review globally while not necessarily resulting in more code.
You just need to store the relevant pointers into a new data structure,
enforce the required invariants at construction time, and codify the
actions that SPDM is already doing in the form of methods.
