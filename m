Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12292480357;
	Thu, 15 Oct 2026 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049430; cv=fail; b=rKeKweae6gVYnox4JpriCP7CjmDm2uYi/dgydrG7YzpcHOWifzBuubyeuvRG89qzRroGgRv46+ar5t8C4HGPcVicfeaPE7iewrtIg//uaL6SI866HAi19LoslOV+xqLwZuf/vv0yHwZFAWkL2xvZBSoyKZv1Ck2rEjqllz+VaQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049430; c=relaxed/simple;
	bh=WHFYA26PdBO4rxCLMX9ZPJ2GpyyrMXOYuP8NBacAlFI=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=SHP4ReMkzab9R3rrscYS1auAv7ohUG5NUQilnHKPeXdM4FWg4PGmyC/3dHnxknllIffYCjVjedQoRj+XvrSbbITkmt6lwlfRdBSFScph71LTJh+hfSjGpNr8AVipTfSlgtfyAqbyrkGr5vfF6LQmw5SEh5L7n90sIVtgp1DtiXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QuJwfzR9; arc=fail smtp.client-ip=52.101.61.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QuJwfzR9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcPVWQ2yTEQ9XCifH0b/wuz3tQjGB0qijlVWlg/LhCks6rMK+gTIsjWED6oojfpTJw10ncFzkMDqD64wWdO0OWBXUbYWSE9FbkpEQp7wyb5IuFGVPzuF24B/6S8jh9BLowyAh7dPAFCoiW7JSgLnviFcY71jO87MkYeK+WF0QmbLg/utVmkPXcYtNHwEIz1iZw4ztIAn72of4boKcOSpk/LAyHjNgeCFcpyVftacmoGLFK0iYLFcfuTdSAd8Myaty2piL4FTB8yF7/UtX8lIaUMSWf97OouK9Y9Fmu/JVY5hlbaEWo4BZXKwfETsFPHCcqQajOWfGcclJZ2uUGcjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgLy7FZ7WJYLJTgnNpR6bZfZHSS1LFJQbVTXmR5d8LI=;
 b=pWgTlYjbA1ZYh1YY1HeMbhS/NDBolrwxWvNz540mcFPFXjAe3QmKYRjx6o/hAPlmWwtLw/XZr3YfIIJRMh0cqDUsMxgulhlde/Y5MNOifZey4nFgtTrQQhJ9HW1BISqT7s1CqFuPRkUPQk0Xxgg2sr/lKX5RYi80M1Rz906qE8WPPn8gLD+8md44y1mHMjn3aDu+PL/T3ANkpCTmPVedvd0X39Qd0FGDVe9WfkPIb9dDHT0DTxIO9jGoJSqVIJw28Wz4yqwVZ8wClf3AxmjGJkNUyJF2spaFa9PNExqO5FlrAQCfUQ9KAz/KkcDDPizax9O35K/spQj8I+yR/5zGHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgLy7FZ7WJYLJTgnNpR6bZfZHSS1LFJQbVTXmR5d8LI=;
 b=QuJwfzR9H2ia0YB7SDW8pfeD//BTJ++jVgENJqNRUnmmWlU8CwrGiidfPOxpAT4zUNkHzV1ZfrH24Mgwg1lr8zzzAAp3hg2YWaT536yh7qFuJpmKzu4HI6rZQ5IaW+X7CsWsWYGq2QfI9FUJ6sWOeKPq7+U1U5o9trRWfL12tXR2rsDvlv0Ddu4CdiouBCRLJnNW2LQSm55l+8XZUq1/gew8TlH8mJ/ZupKwpEN3kix2B26CxmG7A0POHcrUFewZre0uulgvQOS3iwXjFuRplBHYgM4gI+7v2IdxiRQACQ7qzjGbkpdKgbzBUK4KweNO+/avawMt2m1m8Yr0hzpI5A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CHAPR12MB999225.namprd12.prod.outlook.com (2603:10b6:610:2fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 07:29:58 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 07:29:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 16:29:55 +0900
Message-Id: <DM58HRC3DHSS.1YC0E53ZXANT4@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alistair Francis" <alistair23@gmail.com>
Cc: <lukas@wunner.de>, <linux-cxl@vger.kernel.org>,
 <akpm@linux-foundation.org>, <Jonathan.Cameron@huawei.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <jic23@kernel.org>, <bhelgaas@google.com>, <alistair@alistair23.me>,
 <djbw@kernel.org>, <linux-pci@vger.kernel.org>, <wilfred.mallawa@wdc.com>,
 <a.hindborg@kernel.org>, <gregkh@linuxfoundation.org>,
 <alex.gaynor@gmail.com>, <aliceryhl@google.com>, <benno.lossin@proton.me>,
 <boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
 <gary@garyguo.net>, <ojeda@kernel.org>, "Jonathan Cameron"
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v4 10/22] lib: rspdm: Initial commit of Rust SPDM
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-11-alistair.francis@wdc.com>
 <DM4NT7TFX4X9.1GFI128LI5ZQ4@nvidia.com>
 <CAKmqyKNEup=x+bwmPD_8x0s4ssPkqFnQtSGqJ_82z9oDP=A6cA@mail.gmail.com>
In-Reply-To: <CAKmqyKNEup=x+bwmPD_8x0s4ssPkqFnQtSGqJ_82z9oDP=A6cA@mail.gmail.com>
X-ClientProxiedBy: TY6PR01CA0011.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CHAPR12MB999225:EE_
X-MS-Office365-Filtering-Correlation-Id: b1923a2d-c8cc-4e7a-27ea-08df2a8e1dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|10070799003|376014|6133799003|18002099003|10067099003|22082099003|5023799004|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/z0J1ntoJFxh83ayabCfBpBWzKnZdOcSGa4R76M4TWBvoXpLDnvAvjf8BIBBEq7Ea8H9riOqcZt1qgnUzFyo2rjkA2o/8HZcxo/ALNgRKSX9Mp0h3/45hgBrxjQpnm/N3H9EVavIBTPGtyJLWkT+KEivRigZ7GFU/127eOR6RGYWv2lI2wViTwMWQhfBr89W/NrNeWu6HyUn9djcBfp0EmEWsj+KvoYnkfGTpyX+zbjCA8wBCedyyn1D46RCL37d3hkl27uXVyPbQA/w7cWwauC04IxAtdPMU5e/Bh2w+2WfsG8hY4nDImb/KMyp+72DdJiSmOhuXCxfLEOwhZtqpDT6CB1oP1QGF4lBLCDwbnqTcDO7ZadNE4piLrNCKE35fi8mTMCHnIUy2vo72lHmSU/nM/z995B5Nqz0bwoi4gXWapZiXCNALU4cRFMXAc6MZ6t4mByXrFCRKUA/WQQz2PgPKL5Qggk8xLtztRFS+W+4k2K4NDrKaNlM51ZPXrqv7YZFZKb2xFDWg5RlSdgLBKQtdN2fLOPnm9k3AjkGTttuCt4HFpCpGTQ4xi1RLCeDm4EdkmpoQSPjNjtboT1fyRBbNCW3mVIO7cyK14WSygDvyfiGGWY0JRSm0Oo1n3aRqpyPN9kX7qLo9APhQphO4sHZjTf4LYS/llDaRTP4b0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(10070799003)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(5023799004)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3VaUHl3L2h1YllaTTBWREZPTENRVnVZQmRKNGZRY0h5UnhyWGF2S3RHSmFt?=
 =?utf-8?B?Y2s1VWRhTVlRNXJ4RTZndWNXbGdYOEozb2tUbHlNYjVWQUZiK1B0bHdRQkR3?=
 =?utf-8?B?UytKMDZvdXg1QUNMQ3VFamNZdFR1ampiSW5zT2s5eTZNUEw5R2tEWStWd1dp?=
 =?utf-8?B?aWdKeDlxOTBIYzRyeVArM2NKeWVDMUtKMFhzSFFRbm5xRDlnNVN2S0VhMVpu?=
 =?utf-8?B?NmRYODFOb2pFQ0hOeHFnSEx6cHpSbFdod2N2VG5qdjBXYW1WVjJJdHptazJQ?=
 =?utf-8?B?Rk1OS1RxT2h0RlRJQndMYUdpYnZ0b0xFMGdUbVdidk1JaXhPSzJtbndnL3Jx?=
 =?utf-8?B?Wkx0TlpnakJHYmtVem9WMCtCV3diQS8xZmtITjRwc3F0enN6K1pBb2dGaVJN?=
 =?utf-8?B?U256UXhQM2NxazlZeThtUndVaExGYUxVZGtobFkyK3B5UU92Z2xnNTJQOFNZ?=
 =?utf-8?B?dkMyazRPaUlPTzFBd0JZSUtWZ3pDWWlDM3VFai9YVGtuNGNiMURhUVNuLzF5?=
 =?utf-8?B?U3plYmZTcDZ0bWhyQnRTMHB3WG45MEw3YzJFL2liYlh0SW50d0krQzRNQmRr?=
 =?utf-8?B?N3JqSUJNWDRvTTJBRXluMUpNdlpVY21uRlRzYnp4OUtVdFdhU1R3dUhaSkhG?=
 =?utf-8?B?ZVJXRjQvY2N4bTFWZUVZTGJXTERNV0FVMWY1WTJWQ29NYzFibXkxVU1oQlY4?=
 =?utf-8?B?Zy9DeHFwTVJhVDhiNFBlYWVubENXNWVzWDZuL0QxT0QyR2xJS3c2ZUlHQ094?=
 =?utf-8?B?cGVsSUNDTk5yV01KY2IyQXcrYmpoUm01K3doc1o3RER2YmlIV1Uxd0R1YTZB?=
 =?utf-8?B?eTRaWjZMN2tTSEJJZ1ZWR0UvczlwMXU3ZTJtVVVMVlA2ejBldUlTU0dHZkpG?=
 =?utf-8?B?U1lRcFIzSVhQeXoyVzBTQXRUSFBkalJaNGZUQWljTXdPUHc5N3FsUmZaQi9a?=
 =?utf-8?B?SnVMUkV6Y3p5dThuMElsN1k1L01tajJxQ3gxZXpqK0NnVXRudktUSDlNQXNv?=
 =?utf-8?B?VEFSd1h0ai8xaTVhUlBoM3E1b3Rkb0c4RnB1NGQxb2NDQzZXd1Mzd085bEV2?=
 =?utf-8?B?UTA2bWdBdDNPK0V3QXBtS2RqV1N1R1U5TW14NUdXZDdjN01qUHRlRG1qN29M?=
 =?utf-8?B?KzlJbzQwRDh2aDhTZk9UVk8ySms5MTBtRlhhVkhQMEVZMzFJSVNwQjVBdHhD?=
 =?utf-8?B?Lyt2MW1saVpXdlRmQkNoZk45a0JOQmkxZUR6ZExMWUNrUzdZOGhHVFNqNGh4?=
 =?utf-8?B?SjlPTUhybTdRcHVCV0ovYWluOENTU0xpaytmNmJYVThPUGphSXF0dWFrUGRw?=
 =?utf-8?B?RlFOMWtzNVRTV01McTdtUU5UUUJOajY5UUtNQlAzV25EZm15N0Vnbm1Gemky?=
 =?utf-8?B?WjlnL203eHRiNzNzWGxWUDFWTUhSNkFhMXlLZ3dtaDN5V1M2ZHNnd2F6UnhP?=
 =?utf-8?B?OG9ZNVp0K0Z2QndCNDl6K3VSM29FNU9NLzFnVFo2UTBuY2wxVmdFZG0zeTdQ?=
 =?utf-8?B?cm9Xc2VCM1l0NFo1MnZEODI5S01BRmluUHhMZU5JOHovVWs2am94Q1BxY1Y2?=
 =?utf-8?B?bEtnS2R5UTEvWFo3ZEZVaFV4UUNHWW12S0VMREZaYVBkMlZhZC9XbkFsT3hI?=
 =?utf-8?B?QnM5aXlNbzhKdjYzMU1LMkx6d1RwZ1E3YzRLRU9QY1ZIeFBYS21HU2NEMW92?=
 =?utf-8?B?M01HMjFxeGhoeDlsa3ZRN1k1OGFtN1JNVG1jeW1qeWtpNHRqbFZmSWRscmk1?=
 =?utf-8?B?VHNDNHdoY2ltd3U2N0tYbDlmTWlVSUVyMGoya0JLeE1UbDVpc2t5bTJkbHZm?=
 =?utf-8?B?U0VsMFlUaDVWTmtVM1BuNnpjWUNma2RTWTRQYndPTGNtT2ZDemE1YnZLWUx6?=
 =?utf-8?B?UVY1WWZrTWlzTC9KMk0xWk1ISUJTelEwTFU2UHhVT0dGRldYUi9Oc210eDRQ?=
 =?utf-8?B?a0QwYjFjeTc5V0RudytkMXlzMzhsaEt5bzZhdllRQmFmZDRSa01weHNhK1lp?=
 =?utf-8?B?Qk1aUFJHUWo4OGNhNDU1Q2tnL0VtdlFmSkEzblkzUVlyK0QvN2JQMmNrZmVV?=
 =?utf-8?B?Ym1hVjhvVXBlSjlWNG1rQTczVFJqVjVWZVc5TElyckQvUENMRXZOanJBYnJn?=
 =?utf-8?B?cHE4SjNJNVYwN3RlZ1Y5TzBKckswUk05WS80cjE1N0RiWjJyOFpPb3dQL0pp?=
 =?utf-8?B?RmMwWmlOU2pLSWJyZE5EcmJ4WGhGNE04Ujlvd2FEMkdyNWhMVm5VU2RzaUEx?=
 =?utf-8?B?czY5aG9VQzJPSFJtSWw5Z01zQW0vRnhsUEVBUnNnSlhrckd5SGlodDZHOExn?=
 =?utf-8?B?bkx1RnpDWHBjZU1RNUhVM0w2cFJueDMyNy9QRjloTS9rVk9Zdm1oVEdKZzlw?=
 =?utf-8?Q?EUktAXRuNtnhV8Yoq7oAtIlPXpu2IlJHTIaukpOXl8xCR?=
X-MS-Exchange-AntiSpam-MessageData-1: cjbgwN6BjPBboA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1923a2d-c8cc-4e7a-27ea-08df2a8e1dd2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 07:29:58.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plz4JJos9oB4DEtRTH3ya4plMfIRhtSvKHaH4xaPnmdeVgrDWHy0Uiew82dNgPDqSuCdYNjsjt2UV/+ZpYAitw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999225

On Thu Oct 15, 2026 at 12:06 PM JST, Alistair Francis wrote:
<...>
>> > +/// The current SPDM session state for a device.
>> > +///
>> > +/// Concurrent access is serialised by wrapping the whole struct in a
>> > +/// `Mutex<SpdmState>` at the FFI boundary, so `spdm_authenticate()` =
callers
>> > +/// run one at a time and the locked `&mut SpdmState` is the only way=
 to
>> > +/// reach the inner fields.
>> > +///
>> > +/// `dev`: Responder device.  Used for error reporting and passed to =
@transport.
>> > +/// `transport`: Transport function to perform one message exchange.
>> > +/// `transport_priv`: Transport private data.
>> > +/// `transport_sz`: Maximum message size the transport is capable of =
(in bytes).
>> > +///  Used as DataTransferSize in GET_CAPABILITIES exchange.
>> > +/// `validate`: Function to validate additional leaf certificate requ=
irements.
>> > +///
>> > +/// `version`: Maximum common supported version of requester and resp=
onder.
>> > +///  Negotiated during GET_VERSION exchange.
>>
>> Field documentation should be their own doccomments before each
>> individual field (see [1] for an example and general good practices when
>> writing Rust doccomments).
>>
>> [1] https://doc.rust-lang.org/rust-by-example/meta/doc.html
>>
>> > +#[expect(dead_code)]
>> > +pub(crate) struct SpdmState {
>> > +    pub(crate) dev: *mut bindings::device,
>>
>> This makes me very nervous. I see this is passed to C callbacks. We need
>> to maintain the guarantee that the device still exists, so an
>> `ARef<Device>`, from which you obtain a pointer to pass to the C
>> callbacks, should be the minimum here. Does the device also need to be
>> bound? Looking at `drivers/pci/cma.c` it seems to be. Then this needs to
>> be a `&Device<Bound>`, with a lifetime to `SpdmState` so callers only
>> use it while the device is bound.
>
> Good point, I have converted this to use a `&Device<Bound>`

Another related point of feedback is that this code seems to be
designed to interact with C drivers exclusively - i.e. I don't see a
publicly exported Rust API.

That's probably what has guided the current design of storing pointers,
as that's what the C functions expect; and the C side is also
responsible for taking care of lifetime and bound device status, so in
that context using a `&Device<Bound>` will be of little help as it will
need to be forged by trusting that the calling C code knows what it is
doing.

I think it would be helpful on the contrary to design things around a
Rust API, on top of which the C FFI is built. That way you would have to
work with properly bound references, and have a proof that the model is
viable before exposing it to C. Also I guess Rust drivers will want to
use this at some point, so better design with that in mind from the
get-go.

Also related, what is the reason for having this code in `lib`? Why not
make this a regular kernel module?

>
>>
>> Just storing a C pointer and passing it whenever a function needs it
>> cancels the purpose of using Rust and make the safety requirements of
>> the callback you pass it to impossible to guarantee, as nothing enforces
>> that the device still exists or is in a valid state when they are
>> invoked.
>>
>> > +    pub(crate) transport: bindings::spdm_transport,
>> > +    pub(crate) transport_priv: *mut c_void,
>>
>> Here I also suspect we want to define some kind of ownership model for
>> the private data instead of hoping that the pointer is still valid when
>> we use it.
>
> Any ideas here? It's just a pointer that we pass back to C when
> calling the `transport_function()`, I'm not clear on what we could do
> to ensure it's still valid.

I suspect something close to what `fwctl` does? Basically `SpdmState`
would store a reference to a generic type, which outlives the SPDM
driver bound time. That's also why having the Rust API first is helpful,
as it will provide the lifetime that needs to be outlived.

Looking at the example in `cma.c`, the private data appears to be
`host.doe_mb`, which exists before `spdm_create` is called and is still
there after `spdm_destroy`, so that seems to be the correct model, i.e.
there should be no need to transfer full ownership of the private data
to the SPDM driver - a reference should be sufficient.

Actually thinking some more about it seems like the `fwctl` Rust
bindings could be a good model to follow. They are simple and adopt a
similar pattern of a sub-component of a larger driver that never
outlives its parent.

<...>
>>
>> > +impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for SpdmHeader {
>> > +    type Err =3D Error;
>> > +
>> > +    type Context =3D &'c SpdmState;
>> > +
>> > +    fn validate(unvalidated: &[u8], _context: &'c SpdmState) -> Resul=
t<Self, Self::Err> {
>> > +        Ok(SpdmHeader {
>> > +            version: *unvalidated.get(0).ok_or(EIO)?,
>> > +            code: *unvalidated.get(1).ok_or(EIO)?,
>> > +            param1: *unvalidated.get(2).ok_or(EIO)?,
>> > +            param2: *unvalidated.get(3).ok_or(EIO)?,
>> > +        })
>>
>> Here you will definitely want to leverage zerocopy's `FromBytes` trait.
>
> I was hoping not too actually.
>
> The SPDM responses are a bit complex. For example NegotiateAlgsRsp has
> multiple dynamically sized arrays, and the fields change based on the
> version.
>
> Using zerocopy means we need packed structs and even then I'm not
> clear on how we can handle the KVec<u32> or even the
> KVec<RespAlgStruct> nicley.
>
> The current approach has the obvious downside of copying the data, but
> as the data is pretty small in the scheme of things and not part of a
> hot path, I think the tradeoff of copying the data with much cleaner
> and easier to understand code is worth it.
>
> Maybe in the future zerocopy could be a performance improvement, but I
> think right now it's a large complexity overhead in this case.
>
> Note that obviously SpdmHeader is not complex, but I think they should
> all follow the same pattern.

For more complex structures sure, but in the case of `SpdmHeader`
zerocopy looks like it would work nicely? It also supports performing a
copy (see `read_from_bytes` and `read_from_prefix`).
