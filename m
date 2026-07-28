Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022074.outbound.protection.outlook.com [52.101.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0DB2F8EBC;
	Tue, 28 Jul 2026 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785234260; cv=fail; b=dciEGeoqkY6biYMxU/4HC04lYl76FFrLl7ECMBbFE7UhbwOTj5ScI5TNxODMbA/ge92V4xSU2zFJpHSprQpXw1yoaMFQHdqxuXbIWcWwNVL4rA21777LUFjfoZsSwhLuDP8zEWvH5Pturt323EVowSQEvJu09sA0YZdTLhBu0RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785234260; c=relaxed/simple;
	bh=9IFsaPOneclCrskgWjD38C+vddTOPBmwcA6Io2klX4Y=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=INsWnJpvEo712gytZ9tTY+QtSVMbb/WQn7tfSe3SKWKOExB3WVo8C7pN5OppNId1eDfcdg24m15k+BZyCXXiBnFUOBLHXQwO9/Zeptyu8va42tbpZBkDcQOTACiX9teTGVXzW7H76ZxJuBfaVHM5AdZO5MQEMSLsglbAGB7Uxjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=k2sWR89Z; arc=fail smtp.client-ip=52.101.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="k2sWR89Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yasptY5YNzpiu4x5w2MAIE9Er9j9wCtzhWrbPLM60FEIyVJTlgLMlWzT/TjV2fXM0dZl80BnsdTTaIae+ZQXtZALOo3f0AkhnJtjXM9eTGbw3D633Vbwsgspat42sKJF4pE84r2xIbJrvZyFztzXElOw1JLBAPb/UgUNqBogxTVj/HUGh8jrcYds3ApcuZf1MqknlcH/oHjUJv4p+mP7Sd+MsSwEdr8Pw6UT3NsXrTRSwT3aGfK4GiAIWqTZEO1bS8cvQWSarcq2vyjWofYVMDosfc1lP1riTxV4Zvx9KnzzsYmPYaEupyRNVfBzOGAur706fMdQFT8qpxH3Iya3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17JWjymosbOvB189m9F3qQAiCUNLQoRUACSrJfvhIE0=;
 b=Dw+oRaI4XxwA0mBQoGyM8qitZQuA5WWO8BsSf1WdPuz/9SsRJ2NN9Nq2QlUa0NuSAt9VcTwX6fzfaFmbjAifex7v5JisO9BbYqXyaKqkF1u9Gs14Yuu5gUDV9nCdRmiJjDVxMLzoZiddzz+xVfsQQX1C0uMh7qYca7dxv8dkQT5/flQFdx3dtAo3FvyWr7vCG9QPBpaWX+WmUIBL+cAAwwyLfBqZ+1pbngyay5+bXnh4b5Ql/tUDEksHoLs09JnLMK2U8dNp6AWYmm1kTOumQIu/kfqMQaU5RjlpP/Kh4hQzTnmjR1IC0SeCI+3UenIaUH3sU32lG5q+0h4Uw6Kqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17JWjymosbOvB189m9F3qQAiCUNLQoRUACSrJfvhIE0=;
 b=k2sWR89ZGxro3p6mOQ01nOY+ity6B0Miuei3C5oSR9BrvKoRaW7lT3NPRgXenz7iWpsav03awmlhKqVTyQ8LH7P4aLhTvLholnidmYpIGBRErTyMbzKLZxj3K3yVqpmT0juUzIe5odojdWpgyhgTWAK+iOHG2aqBFBqz73YTGeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3227.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:15c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 10:24:13 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 10:24:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 11:24:12 +0100
Message-Id: <DKA4Q5QUBUXM.1K6QS2QPXT12H@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
 <DKA02Y5RE1YJ.2FGI97Z60X96R@nvidia.com>
In-Reply-To: <DKA02Y5RE1YJ.2FGI97Z60X96R@nvidia.com>
X-ClientProxiedBy: LO4P123CA0122.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB3227:EE_
X-MS-Office365-Filtering-Correlation-Id: 929fb716-237f-416c-6c06-08deec925ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QJgCTfWQ5Rr/MH9TR6h9Kl0NNNgVFlI+PPPfKlOB51JQmD/Gle8HhmyTamHTX1OghwHV/3Cv5ko2kg/jJOheQlEUNGKeLtFBQ88zwsJn3SdzLWt/QKA9/t6o5cLHSpVPK6XGB2NodW4oeyTU33txkTp5LD0iC1KqzcYiZqx3uavbYjyUX6u2gyq6VWPaEF6yP8r81qHs7sxwOBWmCukk0tQ1PcuMvbriYkh9QGXRyENlYCRnwg/sdrVMjBV4kLbQo1Dh2/DMmGNsBT9TlBJtIT4ezw74Aa/Hzl8H0dBSgfTJ27ma1Z5yvPzWI32sZbjjjzuJdXajmKaM/U6iASvPRNke6K+9DYQZX2q+MIZFEoLzYWs/5FgFrPbeaOcnvFXJ1ZHu9qoTtrF8FT4QTC2gNk4mq+AsrnmCc4EL2rY+u/IH7eu5oR5QULpHmR8gdTILGY7m3j9zvvDMZZcVW4zTHZIgSYd2r9RZ56Bd6ouRj2Qiv6BmVqdl0JFVXZhmR3us43N40VQf0ieCeOMzgDmKzNIe1iyMG8Eq/T0RCiC9l7tlMq+Y4QDGEZkThvjlB8/hHP5U9Z0Y9TW1p/oSNQHzXAbUsdZLtuN+1AePwgWcpCwgofX1C2lRNZ3kZcDLPuoG129yoi4uYgwM59L9Mkzkyu4Jjtq6RsMB49ib6exBmiQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0pYMDh2WVZ4YVhEdUJjbkdqMUxEdDNyVHgwSThIdTg1bVRubkhMK2M4TkxD?=
 =?utf-8?B?SFpYOGxVWUIxcVlFeUNPZjYxVU5aSmVOK3RsV2ZmOXZUcFFjRW0zTkpZUDha?=
 =?utf-8?B?d0p1VTJuWE43ckVQZTFRaDJDMERaamptdXpkWUFGeEs4dEkvVmVlQXRla0Yz?=
 =?utf-8?B?dEh1Y21JOVJRcVVtMDZ4TDNUU2tpL3NkbkRBTUlVdWxKbldtcXU5NnNNNnMw?=
 =?utf-8?B?T1kyTXcxVkRBU2VTdDM2UFlkS1B2ZW1jT1BnN3g0N0llNG1xbFpBZHNMTWth?=
 =?utf-8?B?bHFteFF1bWJZR3V4R21lV0NWWWZXMFJQSWc4dXNBeHFWT0pVRVBKczNrQ3dF?=
 =?utf-8?B?Y0NLTFRNc2U4WEdkYTRxb2o4Q2JFWXROTXZaSGF1cy9kZUMrbGo2cSs2K1lj?=
 =?utf-8?B?bGpjYk1DeDdiNnFaVVI5cVNjbGorTlordXhvc3NCRy85blFXMzROc0w5Mkhj?=
 =?utf-8?B?dkZyeFZndk45Qm5zeWZYSzdFSFduRE1JZ0VFbGxLSWxrQ0N3TmROOWZ0SmZT?=
 =?utf-8?B?RkdXN1RoVTlyTWxnRDc3eStPTnhyYkw5eUFQNkVDZXVZUVFZa0ovSVVTajU0?=
 =?utf-8?B?SHVaRG1WYjdaSkRTYUhYT2I2dzdyU3VYMi9ZRkhEby9jeWdCMCs0RjFFYWUw?=
 =?utf-8?B?NVRKcDdPSDhicnhGemhoaWZBVDdxaDdhcmQ2RDF2dWVDWWI1YjZTTUZuWEJr?=
 =?utf-8?B?RzFDUm5PM0tKdFZiaGhoL0tGeFFMZGdYc3kwT1M1L3hYR1pQVGk4OWdQRVg2?=
 =?utf-8?B?SkFzeGZoQndwTVptZEE4U0VNdGNMNXBmdzFEd0JveTRiN2ZKN3FNRURJMGt0?=
 =?utf-8?B?a1pPNDVQQlpiSXJmZno1dm5UMUFFZzcwUGVnYWhXbGUvVkhWOU1renU0M1lZ?=
 =?utf-8?B?MlRJN1YzdTVaL21hNzVjK3pyOUZUWVRMKzRaR0pQeE56emIreHdKZHZEbWx4?=
 =?utf-8?B?dm1vMGNhTTRuVnoxVFNVbkFBblU1eElnczFtZEwwWXlsNlp6SnFMVUFHV0E5?=
 =?utf-8?B?MVZsYVl1RmJHVkRZS3JaRFh0cTkxOEUrbVpheklZa09WUE03aWJjaWlNS2ZD?=
 =?utf-8?B?bjZLcXE2STllRUtOUzZuUUxCemZ0YWw0NVZuMHBOYUcvRCtqZFRPMTZ0cUlO?=
 =?utf-8?B?SGF6QUdMREZGdGE4RTduakloNjdUY056UUVVdHlvZ2V2Mjd5TkdtZHFmUk0z?=
 =?utf-8?B?WkkxcVE5ZWxSZnp5MWg1cHJsOXQ2NlNSZDhiWG5KcStWc0NyYW93N3J1ZUF5?=
 =?utf-8?B?d1lnVHMwcm9NVzFSTGVLUG1xZjFQQjAxcngvbkNoaWlXamdRam5IZlVyZVpY?=
 =?utf-8?B?TGVhYXc1bEE0cURxN056Y0g3Y2cyZmJxWFFkWSszVHBYS2p2MEhpTDg0WVp5?=
 =?utf-8?B?SHh4NGdCbGpsaXowYmd3VFFYZnA2WjJwWVpFU0xXbE1MZFpNQ0xiTTZBeWNw?=
 =?utf-8?B?OVFPejg5V1M0UDAvaVlZdCs5cWJwVnFBd1V3cStnbmg3VHpnNFVZVmFobExi?=
 =?utf-8?B?MGlyeUFDUnp2a3lwQXNTVitDNVhES0g2M0lnN1U2amJjT3ZNdFdhSStMSXk4?=
 =?utf-8?B?VVV3cjQrQnBJQmR5UDFGYnJkcElIREwxbGZlMW1aTlgrcyswNWZhQnZESmcz?=
 =?utf-8?B?MEs5VlBaVEg5RDBGRzlRQzd3SDFSbmIvSXV0UStONGNHUXBNbGNsdE1MRWVY?=
 =?utf-8?B?cktudUJLN1RpQWhDenozUC8xSXd0SmRrNTRacmtWeG5icEpKT1JSQ1F0WXNP?=
 =?utf-8?B?Uk4vaGpKaGhIbklsT2ZMclBJalZjRStDM0hjbnJ2VmVNd1VkZjNmeEtoZGNU?=
 =?utf-8?B?R2hIdmcwSlI3eTgzK21USWd5NW5lbE83QkFsalRXQ2d5anRhbTVrZ2lneE1a?=
 =?utf-8?B?eCtYczQzSlFPck1TWjBackROaFZLWS81SGhOUmZleWhmeTFpVU9tZWVCb1dY?=
 =?utf-8?B?UjB0dEpDa2RkSlNlZjR2TUZEWjBRWnBmbitLWHlpK1FxNnJsSmp6Z1pFWkpo?=
 =?utf-8?B?QTVXZHVqRVBRWERMeXVrL2x3TS80QWxjQ0YxR1Mwczk2S3hqaFM3d2NRck8w?=
 =?utf-8?B?OVlUdElMY2dFVVk5aldsL0RjanRXaDZoVkw1c0Zjb0JFOU9rMkZWZG9yTXcw?=
 =?utf-8?B?eTFxVitneXFqcURYWVcxR01pbzhRWitxNEZHVlBCWDdUdVV3NG1YZ1NGNWd6?=
 =?utf-8?B?YWdYdmdWZUtscVRPeGhXWnBEcmx1bE81L29VbW42WnZhSGc4U21vWjhIellk?=
 =?utf-8?B?SXc2Q3dxQmd5aWJSQVF2RGZpNHhuandJbndRalAxemphamhvMEswODYrSFZD?=
 =?utf-8?Q?dHFLKmrxyYhiA/h8fi?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 929fb716-237f-416c-6c06-08deec925ed8
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:24:13.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hwXlBLE7Gvumw/obmGPxkt4l0/qQzkxw/Fts5Joxxq/oFyJZ5l8Oc4SPSBofP5x567S2YxaWGMgGVy9rBkDoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3227

On Tue Jul 28, 2026 at 7:45 AM BST, Alexandre Courbot wrote:
> On Wed Jul 22, 2026 at 1:54 AM JST, Gary Guo wrote:
>> Add fixed size region types for these and add projection methods that
>> project from `Bar0` into these. Update these registers to be registers o=
n
>> `PFalconRegisters` and `PFalcon2Registers` and not relative registers on
>> `NovaRegisters`.
>>
>> The use sites are updated mechanically; calls to the projection methods =
are
>> not extracted in this commit.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  drivers/gpu/nova-core/falcon.rs                    | 158 +++++++++-----=
-------
>>  drivers/gpu/nova-core/falcon/fsp.rs                |  53 +++----
>>  drivers/gpu/nova-core/falcon/gsp.rs                |  43 +++---
>>  drivers/gpu/nova-core/falcon/hal/ga102.rs          |  39 ++---
>>  drivers/gpu/nova-core/falcon/hal/tu102.rs          |   8 +-
>>  drivers/gpu/nova-core/falcon/sec2.rs               |  32 +++--
>>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  11 +-
>>  drivers/gpu/nova-core/regs.rs                      |  81 ++++++-----
>>  8 files changed, 193 insertions(+), 232 deletions(-)
>>
> We are calling these methods quite a bit throughout the code. I
> understand they are supposed to be optimized away, but that's still a
> lot of repetition.
>
> Since we now have HRTB and `Falcon` is already referencing the `Bar0`,
> how about storing the projected `Mmio` inside the `Falcon` instance?
>
>     pub(crate) struct Falcon<'a, E: FalconEngine> {
>         ...
>         pfalcon: Mmio<'a, PFalconRegisters>,
>         pfalcon2: Mmio<'a, PFalcon2Registers>,
>     }
>
>     pub(crate) fn new(...) -> Result<Self> {
>         Ok(Self {
>             ...
>             pfalcon: E::pfalcon(bar),
>             pfalcon2: E::pfalcon2(bar),
>         })
>     }
>
> That way all the
>
>     E::pfalcon(self.bar)...
>
> Can become simply
>
>     self.pfalcon

Right, this is the direction that I do think we should head to. As describe=
d in
commit message, this commit is intended as a mechanical conversion and refa=
ctors
are left to the future.

>
> And I suspect that once this is generalized, `Falcon` won't even need to
> store a reference to the `Bar0` (and potentially poke the I/O of other
> engines) anymore.
>
> Actually I would like to push that even further and replace the
> `pfalcon()` and `pfalcon2()` trait methods by associated constants used
> to construct the projected view in `Falcon::new`, since the projections
> are all constructed the same way, but doing so requires
> `generic_const_exprs`. :/
>
> We could make it work by moving the `OFFSET` generic argument of
> `subregion` into a regular argument and enforcing its invariants using
> `build_assert!`, but that would require `subregion` to be
> `#[inline(always)]`. I don't know if there is another trick we can use,
> if not otherwise I guess the trait methods are ok, especially if they
> are only called once in the constructor.

This was definitely one option that I have considered, however as `NEW_SIZE=
`
still needs to be generic so we're not entirely turbofish-free. But if maki=
ng
`offset` become an effective const parameter helps nova impl, it might make
sense to use `build_assert!` for this.

Best,
Gary



