Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020107.outbound.protection.outlook.com [52.101.195.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB52C3256;
	Thu, 12 Feb 2026 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905483; cv=fail; b=YCmZZ0+cxiLMnciP1QiG1gjZl4EKQVx3hZbHOvvSoVflNgXTJ6qa3LcP0/t7JYH7G9eeZ59JoXmR0IT1BF1Q80zn5mycZbfCem99Jt5s/3kO+P/KUGO6cAIlLFGz2nYcc+PwznwNMdwDfDkghR03zb8qz6U5KKEbbZ3TzAuz/6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905483; c=relaxed/simple;
	bh=CQCvPnuwhUa8putpe2vDn8m4sFlar6AXpaiXI8Lt/io=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=gDc+3aDfXAMs4HvEwVBioaWZmJRrGxI32XRXQlLtrs/C+cTh0KKoKSK43YoO/ifDzd6hxcb8xDXFBhpPm2Sqxbdad9bVUbl2v4D3dRPFhNgtUqjJ2StvvGYDQXi+TcOtEF4y2rM0TUMDFIel1sFIvyjrmwSBaAFtAgGDF9V0FK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LPJ+1p7I; arc=fail smtp.client-ip=52.101.195.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LPJ+1p7I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OamOJgDmeRt+mRG6J7ofEO/mwXFIohe3oWu0wn0rhjT/JBsYsMr70t4aEKYdebTIbjFCHkOI8XJ0SOHNidjh7CVnFxkcPEDLGT4y8IJb0lnd/hwefY8AtpaFaaC4ApNFq3jhbAjnfXS4rvKeZOQGjg1CRC8MkPJCU4u757yWIAqmnh0rWEie8BZTO95h9W3kAWcKxcth7btyJrEuAwuAsiMoVGv65k0ZBbZlgy7SLppzeqAFsDMor427AXnOL0HjEVtRr4xihg9u+vldvlcFhHsCEoYyaRCrrP/nRni+PMIKdeh+a6pNo9BHJcdMSfB/1LdP+CT2+jT6bE5gu4/Cng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQCvPnuwhUa8putpe2vDn8m4sFlar6AXpaiXI8Lt/io=;
 b=sPMEKpLIR1JxS4EI7i55z6XgcVU6k9nXR9s1sJn69haeuIGt8OEq39EP0OfDuXUYt8z7ms3zMcs3shMQn8ff/QSdu9pNPUx/lfSfnaZWuVRpZrOhLozdtMIsmvm25hzlFNriwrLt3lCLbw7+pww1FcL8nh2Ehi7zfSuVz64NIfVYfvGxUGGKBlVC6IYVLUW2lbY/rQYMjxtMvWuBqYvsMso7N6AiAqrKVJ7zbDUKuuVnBuICSHvm/lH/nAlQdOcX3fEW4zFJBri2lzvFtMLMmdOnIUKfcyg+nKjA5FzaTMDakjV9WjTf1XDiJe6CpVJ/kqESK7cyLgElsIddZycQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQCvPnuwhUa8putpe2vDn8m4sFlar6AXpaiXI8Lt/io=;
 b=LPJ+1p7IPtbwnGNniF3nif4d+oXd22nktYmYuBcfnoNVrKkMIRthlTxi/lqjsUAoHT7OXhEb3aBgBryuYGiHCN8xjQ5kqCXfCfu1BU62YTRrbgZohR0tFog9cdhCzrlXr8zg37+xFySo6vVPIjhvKUMt8i68Jxx7rV5m41wxiE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO6P265MB6827.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 14:11:18 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.20.9587.017; Thu, 12 Feb 2026
 14:11:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 22:11:00 +0800
Message-Id: <DGD1LDCXJZR6.32S0Z7EHGYDUN@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, <lyude@redhat.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v2 1/6] rust: io: turn IoCapable into a functional trait
X-Mailer: aerc 0.21.0
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
 <20260206-io-v2-1-71dea20a06e6@nvidia.com>
 <97fc6c36933522eaf75f34f8fcd445715432fde4.camel@redhat.com>
 <DGCYWK1UF76I.A565AK23DZXS@nvidia.com>
In-Reply-To: <DGCYWK1UF76I.A565AK23DZXS@nvidia.com>
X-ClientProxiedBy: TY4P301CA0121.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::17) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO6P265MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: faa057f4-071d-44cb-3e58-08de6a40970f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjZwZDBQbzRtMWVTUW9MMjlIMDdsYmZWd1J3NEIwM2xmeTFNME1QK1AydkpT?=
 =?utf-8?B?QjU1ek0vWVJmcjlXL1I0VkU5SnR2bUZQRnJqQ2wwMkJiNW9XZXozTm1IcEli?=
 =?utf-8?B?N1BRejc3SkFKbEg1OWtmdHl2T2I0VGR2a1NVRFdMajFhMEZucExRMkpLak03?=
 =?utf-8?B?bkVQUWkzN2dIcVcwY2lSdTd2Q3NjbFFPLzU1VkpHVk9iQUhEUnFKeTBxT0dI?=
 =?utf-8?B?cXFTMVltVUMrRXpTeXVSWWlURDB2ZnNQanFKRUVJY3dMbHJ0dlkyMWZmcENQ?=
 =?utf-8?B?MFp4aGNYU0ZqUUkvaDRxWjlGblZZSjM5QUFqbG5DOEVzZlZPeVdENGQyRXFk?=
 =?utf-8?B?OE9mTlNPdnZpZ0RBTWQ4a3h6Skh1MWhQakhKSFFpNG9ablRRTVhOOTN2U1lO?=
 =?utf-8?B?RTFnZTUrbzErc2hqT2dBTEpvSXJ3SUhrUG5Cd2w1RjE5TXQ4cm9tSms1TEEw?=
 =?utf-8?B?RE5OOGJEZ0Z6dFJieDVPQjJCWUwzT1hDd3Nmd0VzV1JiMUpvQWYxMkVZVGts?=
 =?utf-8?B?UmtXQ29OQjdGMGRxZ2dVMWN0Y3JSaklzQ0hDZERYRm1NNmpwdXFlRHROOFd6?=
 =?utf-8?B?LzdNMTRrVGVrL09xaFIrS0VmUkZmT3ZMQW9rTGFOcVVCK3FKaXhpY3VtbWZl?=
 =?utf-8?B?MWcySm1Cc2g5N2R1dWxVUTgzdE1hakhZdVlRc1dOd0tUVGRIMUZoWHZTRTNu?=
 =?utf-8?B?eVpXNU5rQiswaEszSHYxRHB3UHcraWVFTnkrb0dvT3RmZVdWMFljOU1pS1dx?=
 =?utf-8?B?M09VNGFHQTM3eUwwdldNaWpUTjE3SHI3SklvK3gyOWEvSXQ0SUR1Ty9tRVI1?=
 =?utf-8?B?QVJ3TFN4aTcwaklxNTR0aUFFY0pXSTVVNUMzbGg5TGxJY282ZkpVRDZNM1o1?=
 =?utf-8?B?QkVucEpoRDExdUxkUm1JVHRQd3VUa0t0QXZWcFZaL3FrbTNQZnVkeTBudGhn?=
 =?utf-8?B?ZlNTdEdTNzdvSStQMXhoSWYrZmRMdmJWN0c2Z0crZU95dW40aFJKc0xiVGNW?=
 =?utf-8?B?d0dNREdaTjdqeEJ2YXBCSGlxUWlkRWlOcFJCL2ZiOWM0TUsrZUJYU1ZMOUtW?=
 =?utf-8?B?RVVxRFBYd21KVGVlS1NsN2lyU3hvMUZFN1NhZGxyWjdMNkE5WFhEWUJ2TlRQ?=
 =?utf-8?B?c3ZXTzhSbDFZQ0xwNFpJVkh1VHVtQ0ZrVVZtSFlHdzdrMlFwTzhGTUoyZVV6?=
 =?utf-8?B?czNBOW1xQldDRUg1SEJ5bFMyUzRFU0Z2S3VSQW9CV2lWT0g2RkxpK3kxcnIy?=
 =?utf-8?B?N1ZIZ2VHeGhWRE50VnRnZmRVZ3hOOWNHbkRHd1c5bWN2OGhlci9HMkxVY29C?=
 =?utf-8?B?SkdJTHUzSE9ibWtmOWJENFdxNytHaUphdkk5aGo2TXJsVm1rejRjMHdSbWxN?=
 =?utf-8?B?UTd4M25mOHJrOUlvMTgxZTMwemF1d3BQaXZlSGl1Q1NzTk5NY0ttcGxuVXhP?=
 =?utf-8?B?UEkxdUg5OC90cVN1djQ0eTB2RFF3SlpNVHhvc0hnL0dRQUtHSjJaRytMUkh0?=
 =?utf-8?B?UmhVOUo0UWo5cUpCTDhXYWJFUXduV3J0TS9FU1VDRjZMcFQ3aDlYSW85NWRQ?=
 =?utf-8?B?TldTMDFoZlBXRUJyWWZuMkpHLy94RkVhb1h4R0NCVm5YbHp5K3Z2R3g2aEx3?=
 =?utf-8?B?Rm9tQW93eUxid1E5dUtySG54SFgrd29GczhPbUE0bXMxQUNTbXJRVjRTdTg2?=
 =?utf-8?B?UEw4d1M4UXdsUW00UFdZaWhxRlMyWndXdmg1azgvWDVONisvOU5HU09PS3Bn?=
 =?utf-8?B?NVhIT2J0RTAyMG9Db0d2c1k4U0h0OUk2V01pZHhpSWhjRCtyUzN2Yzk2bElN?=
 =?utf-8?B?Wkd3MGhZeXA2dlpOcW1SRzh2MGFoRUZ3STFxZ0QvemZWeFJJenpsVi9iQXkv?=
 =?utf-8?B?eUc3ckllOG5NUmZkbXhtQmFQbDM4L2ZWY05GREFJNmFFS0xrYjJ2a0dGQk8w?=
 =?utf-8?B?ZFlDUTJmdjdDV1MyUC9SVUUvd0JoUS84WXRmTkxjdEV2ZzV2d1RRSmRLcnha?=
 =?utf-8?B?ZVZFWTJOTXJEK29acG16QnpVT05WWStZc2ZQZTloR2xreXk4c1ExNHJ4cnlh?=
 =?utf-8?B?Mk1PMnJRWC9hdVM3OGhZU0QweUF0MnZGaHEwMHIyVlJDYkxRVHlTMzJCUTZK?=
 =?utf-8?Q?2Nto=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHBvM2dnUmtXVXFMWjhzc1lCTnRmelN2a05LVGNzRXA5b25PZEVoMk4wVytx?=
 =?utf-8?B?ak5iQ1RDZXBKbmY2L0ZjNm9XRHBzQ1M1dHVSeWFUbXZaS0svcllyRnZLMW4r?=
 =?utf-8?B?bFZwc2tJb2xRdEhvOHNkaTE2UlV0VE9rL0Vobm0yeDJmR3VqOXBxcDJkeXlx?=
 =?utf-8?B?Tk9DR3VNQ3E4em5QeWFzT2hBSEswalNYMTQyRnNnTy9vTVBtNzRjakZyVCtv?=
 =?utf-8?B?WEtPQkNwTDdwK3BlUzRSV3YyRkpuQ0ZVd3VNR3pUK3VBVGVnejRYYjQ0Um9U?=
 =?utf-8?B?cko2MUFodHBubCtQNnJpbzkwbmY3QThGbkVwSjU0UEVSRlIrMkprMjdMbW9V?=
 =?utf-8?B?VVJoSExjZ2JIQWF1ZzIvOTZTOWV0MVB5cFkwRmxMeGV2bStERTJJRXBLRjJB?=
 =?utf-8?B?YmsrdDNjcVpqeW16T2M4a3NVN2FMT0E3Y1dGbFBxd3BLQ1FpNExDa1g5RDQv?=
 =?utf-8?B?Q1FvWDJFdERmV2NSdUE4SkZyY09oRk1vcWpzRXgvWXFMYUd5Z3hHbmJOVDM5?=
 =?utf-8?B?TGY1NDBsVW56V1JKRlEvQkhuY1VDTm9CYTNxdmt4c244MGthYTNOYkMzbU5W?=
 =?utf-8?B?OXpES0x5QnhFbFNDTjMyMGE4amZ6cUdMMnd0aTM2TGhSSDJiYStXYzR6dnY5?=
 =?utf-8?B?MjNRaTF3S1puaGRsVkdJZ0Y4MHNKK0JkcTY2ajliNERFYTNCMUxxNFB1VGQ2?=
 =?utf-8?B?WkJxcHV0VlliQ2FSVDRLdXBiRVpTalc3OTVrSGFFOGM2bERpbkMvZXVrOVZm?=
 =?utf-8?B?UE90ZzB4NWo1dG9nTXRjTk5FRjJqaHNKSGlETm43Z29PdkEweVFRTUt2d1Nn?=
 =?utf-8?B?bHVaOU9kczhJTkl4cUR1L2J2UWVDR0lzMksvTHVyUGxBUDlUM0ZFT0NhUzl0?=
 =?utf-8?B?enlzcXV4bXU4UHNHclkwbjFnZWF6Y3RjTW5CaG9WQUtGU1lRUTh1VTRTWEpi?=
 =?utf-8?B?dFp1YkJCeFVEYnBmeGc4MjdZMTArcmNqNXR0NHFZWVdlQy9hSmpXdHh3NVNW?=
 =?utf-8?B?YVBoWjZqRG5YRzJJUnJCaFZhMmxLTW14MlJPUjk3UE80SXdLNEgzY09tY2Js?=
 =?utf-8?B?WDB2VVFYcG4raFdpaUhZczM4azVKQ3pTdXE0b0dQVFRwVjU2L0tKeGhoZmVR?=
 =?utf-8?B?VGFOM0NQTCswOElWQ2ZXcUFNSUJWWHZpTjUzZFE4UTZYVC8ycDEyRUw3a2Nt?=
 =?utf-8?B?RHBaQjFNVG5EVjJNVEEzZUxWcDFQdy90OWczUk5YemhlamJHWm56ak5uLzU0?=
 =?utf-8?B?enFQZE1yT2tvNGdkVkQrRmpXNVRCb2NxZjRoOVZERFdkOWpNV3l0UlBkcVVp?=
 =?utf-8?B?RVR3ZlBVWmN4akdFOHFQQmVsWTY0SHdycDlwaDd1ODhkMFBpQ2pDUHI4TzR2?=
 =?utf-8?B?NUJ0SytwbzVSNjU2VEhWK0pvckhmOTNCMUhyZlVIQVA3S1JPTnc0TmRhY2ZG?=
 =?utf-8?B?WHBhVDYyV2JNWGdMb2l0UG5vR0QyaDJFWkZPSVAraFBSQmg3Mk42OExhZWtK?=
 =?utf-8?B?WFIxbGcxYXBNcHUremo4a0NxamJwaXVBSEtJN3o0VFdWbVBpbWR1Y3g1ZC95?=
 =?utf-8?B?NXNuYWV2NzdTeS9VVktFR1Z0NWRBTEVTYnN4SHNKSTVEMlpzYkpDTlpXemYx?=
 =?utf-8?B?amhEVEtrdHI0NXl5SmJaUCtXVE41Yk5RZTBUdGNHU0FmbkRzanNaUE1aempj?=
 =?utf-8?B?N3pDRkdvdVV2Yk5RRzdxaU1nQkl4ZHRzTjYvYlV3U2FZVGVwNHlLWG1QK1hT?=
 =?utf-8?B?ajBkMEY3amdVQ0V2MXlydTdzTVRGMmtDUUFDSjluSVdTeldhWVVpQm84SGtX?=
 =?utf-8?B?K2NEUHIyTkgrRk5KM0xRUUo0UXJxZVczNmZFRzdGNVpJUzNNdGVaUmdqUHB2?=
 =?utf-8?B?aUhtbkdkbTFtTXFvd2hnTklIbU5mNWd2SmF6MXVxOE14dldJRjRjTDRqSGlw?=
 =?utf-8?B?dW5DeU55M1FVblcxd0kyT1V5b1BVcWEyR2RlaDIxR1g4MWIvcDJ4bTBtVm9z?=
 =?utf-8?B?dkVobVJnSDJ3eDdIQktLQkJBUFladXdtRElMK2VzWmxlSE5NWXhVb1JoLzAw?=
 =?utf-8?B?QnFGUi9wNVpQUFd2di92UG55MjNuZERUbzdFdW5VTWFFUW50dElRbkc2RU1E?=
 =?utf-8?B?bUJOaVhyZXBQUEhwN29xbUFDVHlSZk02TkRLNnVUa3lNL0pudk9UeUYvUFNz?=
 =?utf-8?B?ZlRSc1NiMkloYVFWVlBHNzB1R3JOYXlGTGNwSnpGTkVSTDBUcjgrT2Z4RG1Q?=
 =?utf-8?B?OXBORDBmM01JVTR0Rk1OUzlYNWd1ZFl4N3VBZ29jQVM4Z0dpenNPTXhoNS9x?=
 =?utf-8?B?VDE2REpmUVViNzZWOGRtdTN2N3YrR1I0WmQ2RHl6OXZQbnNsa1hEYndyMlNZ?=
 =?utf-8?Q?EdjblWcpzsREs7cTZaIrstLkMZ27sB8h1D2A4?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: faa057f4-071d-44cb-3e58-08de6a40970f
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 14:11:17.9508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+kHVkjAgWHYSW7vb2351LjrKYXW9GwuKGDGAIgPoTjhDW5RtVRRUoNory0VZMghYcjnJe9P0WzPm3S0nX7Ngg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6827

On Thu Feb 12, 2026 at 8:04 PM CST, Alexandre Courbot wrote:
> Hi Lyude,
>
> On Sat Feb 7, 2026 at 5:29 AM JST, lyude wrote:
>> On Fri, 2026-02-06 at 15:00 +0900, Alexandre Courbot wrote:
>>> `IoCapable<T>` is currently used as a marker trait to signal that the
>>> methods of the `Io` trait corresponding to `T` have been overridden
>>> by
>>> the implementor (the default implementations triggering a build-time
>>> error).
>>>=20
>>> This goes against the DRY principle and separates the signaling of
>>> the
>>> capability from its implementation, making it possible to forget a
>>> step
>>> while implementing a new `Io`.
>>
>> I realized another thing that might be missing from this series while
>> porting the iosys_map code over: it seems like IoCapable is fine being
>> a safe trait, but Io and IoKnownSize both seem like they should
>> actually be unsafe traits. The main reason being that IoCapable doesn't
>> actually provide any methods that provide a guarantee of being able to
>> read/write from the IO space, but Io does - and IoKnownSize is making
>> the guarantee the IO space is at least of size IoKnownSize::MIN_SIZE.
>
> Mmm I think you are correct. For instance, nothing prevents someone from
> implementing `Io` with bogus `addr()` and `maxsize()` methods, which
> would trigger undefined behavior with purely safe code.

They can, but the `Io` trait just passes the wrong address to the `IoCapabl=
e`
trait, and nothing horrible can happen without doing things unsafely inside
`IoCapable` impl, which is controlled by the user who implements `Io`. It l=
ooks
to me that unsafe code is still needed to do bogus things.

Can you give a more detailed example on how safe code can cause issue with =
a
safe `Io` trait?

Best,
Gary

