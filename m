Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022081.outbound.protection.outlook.com [52.101.96.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4256328635;
	Thu, 22 Jan 2026 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092002; cv=fail; b=LDwIxsOF/lVdTpqPzkc09PWXCflWrmRxFB1MNGD8Kx2pnZrLKJ/hJMjOTDz9Jr353vu/iI0bs8RaAP4kOtV2hVMasvim+mJLnZq+dnSHqTNMNypE6v5yFZU6rjhW+BG1r0O71MA5IZXkV6G4iFxgV3GkAuZ+tVfJzA2jF48tb1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092002; c=relaxed/simple;
	bh=IkjI1xRRIq8ftEr+Hm9cWcmH53PaXQd6CznthbAenXM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Jf9hIcCTkTv+rLBjzsx6bmxSNQlXuexbMdlWEh8Cp3si0vZ3W4DYGQF13qvYBuWojovWjiFcbwzeCtvzzCU49paqRp5Bfb/wkspDvT69xgkqAkOP4yB4ODDFwgAY59sKYVe/AFtgNQ/dBo17Z+g1zvNK8xUd/U9Kx7MwDq52huY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=sbPqMv/z; arc=fail smtp.client-ip=52.101.96.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="sbPqMv/z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E676dgDDCxnU+aRhtrbnrMZpa176lPM+ixhBWuEfKyPOJ9fHy0KfjwcFT3z/m3drkJRON3afLejZBChhgmo8XsakPtCm2fKOoycjGgp4IHtAEYllFt6Aph3No4BWNGoDzjudG6PftcVRPJ90N4w2Brq1334VcDp/0RB2nfmrseLjUd8FyOm7/fxK9BMhQ2gLsvOtaqa5URbpZlvGNLn/gB6r3rlSMZOaZIISo6hP3wQJtgBU2p0BQlj6AqHbRJDa7k4CbK39QZT4xMm4LkABY5vighn+3EbX5YPFEi/pgRHT8D2tVL5WpHgXpDaWiMOQO4+9+5hTKEFmjKMPYs4P7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zyn8ZvNFL6Sf5p+NTAdUORAxdFo8J/pq6V5iqeFrgM=;
 b=JYn4NA6OAfiIMZsiiif8XGb24SPqEv+c7bPpai1tqwe3LOlR0d/ic6kv9yk9FduQ+2+oCFAFyj1fxurlCjZraMs65Hl1FAOGWRq2aUbSoDKXMrdlhWNIOrBEniJ8LS0DQq1O9AZDm3KDdLuXob8ce7VapVO4aBjf1BxzUnhnK99Hj/e9aKLk/h9hcgSEpJq8UsHdQMUzqRGwfTqa7rqrqKuvEv7SLIzn2+YEld1LiTrkG7FZeJjvUkGcylDJvtPT1oWVD4JUNzn7NEZ3oT7a/+F+hz9OovE9hwLLp34F90wYfW1NmbuD5kLZtEza5jwItqILLHj/WmbFlGigyfvJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zyn8ZvNFL6Sf5p+NTAdUORAxdFo8J/pq6V5iqeFrgM=;
 b=sbPqMv/zdGLHvODqcki6LpiXLMGjg4bBbz15tudr2daBC7tj+iCr2rhhEwIFi0mkb5y5umN9ws90Jmvns4zSJTX+DCOE3Vue0i9a8F7mMvFfCJRzLKmUbvWFyuL5BC2YEQyjfklE0Bkph2VxoYZ3SwNw1Vkl3WyvSl4Z4ocOkhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6382.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 14:26:36 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 14:26:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 14:26:35 +0000
Message-Id: <DFV6RV4QOS48.25MHV8QDDCHNV@garyguo.net>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
Subject: Re: [PATCH v12 4/5] rust: pci: add config space read/write support
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260121202212.4438-1-zhiw@nvidia.com>
 <20260121202212.4438-5-zhiw@nvidia.com>
 <DFV3N1SHS8SK.338Z25H89HINU@garyguo.net>
 <DFV4IJDQC2J6.1Q91JOAL6CJSG@kernel.org>
In-Reply-To: <DFV4IJDQC2J6.1Q91JOAL6CJSG@kernel.org>
X-ClientProxiedBy: LO6P123CA0052.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 831ed104-ec60-44a0-bbbc-08de59c23fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnhlMlEvcXA0UW9BMjRYSVF0RTNteXYvcFl2SkN3R3F0SlJMWVZDNjlqVzd5?=
 =?utf-8?B?Wm1rcEw5STRKRkRJNFpkdnBocVVSYWZEdHIwQUdxbW1HWFdkbUppaStJdWNk?=
 =?utf-8?B?dWh1YUF5UmFBMUFLcnRJN1ZiL3RrM3NGbHI2bW10ajRGZGNnc3BwVkF1TUtj?=
 =?utf-8?B?cHdZZ09UQlpacUMvcHpBYWVtc2RSU1I5QTlIOHp2RTJGR3pLTTVOdnNNVWcw?=
 =?utf-8?B?ZGhtTjZRaVR6ZmNOUkVxUENGUS9FVkhVczFNUDNOellMaWJwZ0hIZXRYT3Vl?=
 =?utf-8?B?TCtLdDVOZW44NUhWaHhsZ2R5WmNqRTFYSWZnUUQrNVdKRmIzNndITzFqY2tn?=
 =?utf-8?B?bmM0eUlKME1WRG1vS3Q5ZW0xMktsV3c2OG9TOC9ZU25iTGlIc2t0ajNsdkdp?=
 =?utf-8?B?V0RaTzZPMjlsT3VsZ1ZHdGpaSzdieVlkaEptZjJJN1pOdktib2Nza0JyUmQ5?=
 =?utf-8?B?VjluWEJyTWhMaVpadUdYTncyK0huVXc3bHQ4K1dzMzhlc0d6c0JtZWwzSXdU?=
 =?utf-8?B?aHhXbVczeUJMVUlWeVlFY2dPbmkzVlpQTUpWQ3pDbTVKVHdPUElzSG5rQ28w?=
 =?utf-8?B?bmpMdWZwMmt3a203OUxjZnpndkJpQUozcllwaElJenBhN3JJR3VGRURONXFS?=
 =?utf-8?B?T0h1bG9mLytia29mVm10VmFlbUdtelJxNW5kVkdNaDRsKzI4QzBVenA5dVl4?=
 =?utf-8?B?RVRyUFRKc2xobGJpVHUvaXNHZjRsOGtQT01NMVphYmp2SHQzdi9mWldyU3hl?=
 =?utf-8?B?dXlCQzJ0ekpaejA4K2RyZWtyOW9UY3JFVjc2OG4yeDJqMnpHTmZ0SXA4VEFD?=
 =?utf-8?B?WE50VGRSN0tTMzdwMlZTSGhQOXEyMFVMRWFSM1d4YUprb2pEMHB5bGREMG5O?=
 =?utf-8?B?Y2lWaEpwNnZVZzkrdVJMQVZGSTZNaUIxaWt1Nk5uWHRIZGRraUxZUS9sR3hh?=
 =?utf-8?B?VWZvVThyWXFTcm1mTERRME1Menk2bEhRUjBRN1NZYTlHc0NvYjZMREtnZzht?=
 =?utf-8?B?dEliVFhFczRWMEEyOEZ6TEtzejR3a0dVNzM0UllibklRN0JnMEVkb2tQR0F4?=
 =?utf-8?B?U090d1R5Szl0Q3JOY2M4MnVsSmVwczlYTEhhT3ZvK0owRnpuNlEyR3YxYnpX?=
 =?utf-8?B?eVhJYjIydEQvZ0d1U0JhUHkxb0FDNkYwWDFtSmdWVTI3cEkzbDh2d0djVHd5?=
 =?utf-8?B?S3FGY1JkcUJ3b1dJS1JXR2ZGYlQ2V2NDRjlZSEF2dzZtNktIQUM5QjUrWjhD?=
 =?utf-8?B?K3VmZ1NyRFY0Z0FBbXJVYVNhZ3B2K3dBRkFiWlY1dFZsN0EzYndyMEEyUTdo?=
 =?utf-8?B?ZU0wMWFzREJpWTFxUHJudGVWcUZxeG9nYm1ubFNtem5TdXdXaDFnbGt6WVBl?=
 =?utf-8?B?Qklwc05xbllndEUrWVI0SzZReERyVWZkVFBRdEJsM0kwRWpsVGhWeWlRWUxU?=
 =?utf-8?B?N2tiYmZHV3RoNFpxbk5QUk5SZDJEYmZJengrNzZFaDVyM0QwRFgva0hJeGJi?=
 =?utf-8?B?RGl3L2oyTHZqSWdFMkNUenh1cXpaUUdvQnRuK2pJWElQYTJkc0FCZlhicXow?=
 =?utf-8?B?SHV5MjFDZVNRRjMrbTUxRXFvdzB1aWpUKzExN1J1bCtCLytxZzdiV1hMcHJt?=
 =?utf-8?B?YWVPM0ZWWnliR05pTjUvOHJHMmdFNTREOEM0K3o4Z3UyeDhMaEQ4NnVzdXJl?=
 =?utf-8?B?SlhRalJNbmJ5Rk9Bb0ROQTJESTBHMWh0b3c5Rndkck0zLzViZjgySlVPZUZo?=
 =?utf-8?B?dytnSDNKTmllOStHYWZpajVYbnA4V3VISEU0bkhqT2I4WG0yM0xCdUd3QXFE?=
 =?utf-8?B?R1ZqZ1hzSG5HTHMwaE90TlhFcFBzYjFhencyOGdJQlFtUVphTmJ0c0N1WW5x?=
 =?utf-8?B?b3VTK056a0JBUUVjTkpqVUFUSVdIWGxYdFV5bzJqSCtuVjFtc2tuRFlDQjBi?=
 =?utf-8?B?QmtJWXgweGpTa2RCUjRuZFZIZTRPd0Frb2VuRUs3NFI1bGRReTA5UU5TSDZ3?=
 =?utf-8?B?dTdHOE5EeEtsZFR5WmxENm5ZeGYvV0paazNwQVprQ3BWME1rNFNZZFVXMWlR?=
 =?utf-8?B?TE1PSjJKVnA3ZVdmaXNmZ0VxcUxhZFNNNmQ5bmJlNnNHOG1kVW14dHNsd0tt?=
 =?utf-8?Q?B/Zk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmpWVzh2SzVWK0xIU202d3dLeDRZdk5tckZhMzZwazQvMFJ4OGxzRTI0d1Nv?=
 =?utf-8?B?Q3JUempZelJvbnJiNGk5SlJFOGp0SEpqWnp2QWlXNURoM0o4REVNYkxuUkRV?=
 =?utf-8?B?OVRlWWIvUnUyTFhVcnd1UnBzaGpOWGVSSWx5bmg4ZEY3RlZlQUdmQ0FGbWww?=
 =?utf-8?B?S3NjanRRUjZHTXRXOFhJcEJFa0JIM3duc043alQxS3gvbzExTWhkWW5KQmVp?=
 =?utf-8?B?K2NETHhmU1ZTMlp6b0lPaHE1a2FaZWs0YzlidTlNbWk0c3RTSHRkUmZlWFgy?=
 =?utf-8?B?VnBzSzYzRHgxL3FUVFQ3dGN1VkNFdEdmSXVvM1NFNE1QZXlJR0p2cVR0Ykg4?=
 =?utf-8?B?ekNoc1dwSmFObENQOW5PQVpPYm9CcHFpeWUvbjJCcW9XczEvcHRJY0xMV1Q3?=
 =?utf-8?B?dWRhbEtCSlhORjc3S0MwbEN5dXU2REROUGhzUC96cnQxRFB6SkFna3pEeWlj?=
 =?utf-8?B?U29DSDl5SS9La21uRkdsc090Q3JqdFNxd2dUK1RiZXc2cE9vRVpBWlJFQXVt?=
 =?utf-8?B?c3hkZEZ5MU9uZkx3bWd0MHJKSklmK3NScjR5L1Zkc0ZZM2NjRlhNRThQcGJo?=
 =?utf-8?B?M2dYb1Y4cjVKaW9mNGhIZ0hPUXVLb25PdzRjNm1jOEVNTWNHOC9TbjZ3Zi9s?=
 =?utf-8?B?LzNXRDJtWkdrRGs3elE0RlF5NWRtKzdUR2tDMEFsdEFvcTNOTGVYZWlHeUha?=
 =?utf-8?B?VjJvVm5BNEI3b2J0UUZCTUUrVFpnUkIzVjZBRjY4QktqWDlhY1ZKdHpaRGFI?=
 =?utf-8?B?UVRBamJEYXVlSGdrakRBUG4rYzc2eS8wM1hINzFrRlp4RkFIN1FmdHNyRDZM?=
 =?utf-8?B?Y0tVTnAzNkNBZEFleEtpSDN6QmNvL1FaUnh3OXBBaGp6OU51eXppc1BJVlVP?=
 =?utf-8?B?RzBlOW5paUZjMndyd002WStPRzFqb2x3N05XeEtYSjIzL2FhNm5uNDhqanlN?=
 =?utf-8?B?bFpFMkJxVkRwaUFyUnJ6b0xlbmg2Wi9YckIwRGZ0amFDVDJtMWdUL2tvenNC?=
 =?utf-8?B?NjVNcFdBa3ViaFdWMWV2MnN3aTZUL1pTZkR2UStPekNQQjAxanhQcjlINFI4?=
 =?utf-8?B?RXZUNXQwaVcxNXJxZHJ2Rm5VMDlnUXI1WVZmVUh3ZlhMSzgyNmpOUjByZVY5?=
 =?utf-8?B?N09VK3hDVXk5NmUxQ043eWEyQkg3Z1BqTDF1ZW1UMzNhTXFoamVNakJrczc1?=
 =?utf-8?B?RzhxdkJISUV4UHNiQ1M3Uzk0MGw4bEpLY0hocytYRWg3WFVXTWRPcWNiK1Rs?=
 =?utf-8?B?L1FoVkN5M0R2VmxNY3FoZzFlb3B0ODdJTW9nSXIzRUluNlhJa1VIeWZQQ2h3?=
 =?utf-8?B?eGdyN0NMbVZzcFNPL2xVZ2FVYURqZ3l6bG9IaVhaZzM5YlNxaTFHZ1JoN2JB?=
 =?utf-8?B?S2kxdWFraDBGNXFhdUQvcnRUTEcvY2RDaVlVUkVTVzVFTkw2OWdYUnhRQUQz?=
 =?utf-8?B?U01mME1hTFRIQjJPVXBoeUU4eERWWm1nUUdJemJFZG8xcDFnUnh6cXBjV3I0?=
 =?utf-8?B?Z05MTExtdzBGVUZnblVCMXM2WkFGWE15QXpBS0ZXanUydWxFbU80Tmd5d3Ru?=
 =?utf-8?B?czNvbFlSMEwyUTRtSUNFOXJGVmRaQ2JwRnl1c1hHd2lMbWVIOGtBbUdVYmhT?=
 =?utf-8?B?YkxmVVRuQXRCNk9HWXc3aWgwZmNub3pHQnVsYlpPbFdkTTlrbFJsQUtTalJ4?=
 =?utf-8?B?QWpxTUZnbVEyNjZlcG4zaXNNSDQxZWNjL2R5TDNkTEJiL0dpWHFPdmovUm5T?=
 =?utf-8?B?czk3TVZaL0JmdlR6TUh2aE9LbGJPdmlITVhOMGlMdzl5bjdwQUZvSmE1QTFO?=
 =?utf-8?B?K1RvMWJhbS9UTUREY09TUVIyYnArN0dvS0RRZmxOMHpWQ2l4ZkhJVklDL1Rk?=
 =?utf-8?B?emRsU1ovajZvV0hvUFNzRHk1L3BoQ1hBQ0trQjBuSWRrRjRjOVlOVnlzdmh1?=
 =?utf-8?B?TVNmTlQ0dWdESmtwVDBXY0xYaEVKTUJzQUlHTWZJZVI3azBjMjNTWDQ4MEZT?=
 =?utf-8?B?eWFmM2x3RmdZSWZIS0piY1hUWjJJVXJ2dTZCUEVpS29nUW1JNHBJS1pDL1Zp?=
 =?utf-8?B?WkxGa0tDYWZQcmJ1R3FnQURBM2ExTTZiK1BQTmJCQmIxMmhUVkFQU253Umcr?=
 =?utf-8?B?Q0NPR1BIRnVQN0NHei9vakxzZEVpUkdPcFZoYmR3Q2IxRFRrTnlUa0lMRVQw?=
 =?utf-8?B?QVVDUXh0bmN3NVk0UHFiWHZKcmZCOEFOa25QMEl2a28yRDZZVTJMN2F2S09y?=
 =?utf-8?B?d1phWjFsckFCUzZjaTNCNnZrOVUrcGJtWGd0QnNadkVoZG1hVnVXOFhCMU02?=
 =?utf-8?B?WFVScytFRk9SS1JvR1Q5T2lFb2szaUV3YndPa3dZUWx2UzZCcldVdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 831ed104-ec60-44a0-bbbc-08de59c23fac
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 14:26:36.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFmyISDt9PQYpKWJJZ8C2cE6IZZ9Y9VyRu2s9DNMeIRhtZUVdiQ6cZqygPGfF409+HL9Dh1lTecOa9njKFvTyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6382

On Thu Jan 22, 2026 at 12:40 PM GMT, Danilo Krummrich wrote:
> On Thu Jan 22, 2026 at 12:59 PM CET, Gary Guo wrote:
>> On Wed Jan 21, 2026 at 8:22 PM GMT, Zhi Wang wrote:
>>> +    /// Returns the size of configuration space in bytes.
>>> +    fn cfg_size(&self) -> Result<usize> {
>>> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_d=
ev`.
>>> +        let size =3D unsafe { (*self.as_raw()).cfg_size };
>>> +        match size {
>>> +            256 | 4096 =3D> Ok(size as usize),
>>> +            _ =3D> {
>>> +                debug_assert!(false);
>>> +                Err(EINVAL)
>>> +            }
>>> +        }
>>> +    }
>>
>> This method is only invoked from maxsize, which turns error into `0`. Do=
 apart
>> from the debug assertion, the error code is pointless. I think this func=
tion
>> should just return `usize` as it's specified in the device (we should tr=
ust the
>> C side that the value is sensible).
>
> That seems reasonable, but I also think we should keep the enum ConfigSpa=
ceSize
> we had before and call the new trait ConfigSpaceKind instead, such that t=
his
> method becomes:
>
> 	fn cfg_size(&self) -> ConfigSpaceSize;
>
>> The check, as Alex mentioned, need to be done when ConfigSpace is create=
d in
>> the first place and is too late when you already hand out `Ok(ConfigSpac=
e)`.
>
> We need the check for config_space_extended(), but not for config_space()=
, as it
> represents the minimum size, i.e. it's always valid.
>
> Here's a diff of what I think this should look like on top of this series=
.

The proposal looks good to me. Some comments below.

Reviewed-by: Gary Guo <gary@garyguo.net>

>
> (@Zhi: If we all agree on the diff and nothing else comes up you don't ne=
ed to
> resend. :)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 9020959ce0c7..1d1a253e5d5d 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -42,6 +42,7 @@
>  };
>  pub use self::io::{
>      Bar,
> +    ConfigSpaceKind,
>      ConfigSpaceSize,
>      Extended,
>      Normal, //
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 39df41d0eaab..5dbdfe516418 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -24,6 +24,31 @@
>      ops::Deref, //
>  };
>
> +/// Represents the size of a PCI configuration space.
> +///
> +/// PCI devices can have either a *normal* (legacy) configuration space =
of 256 bytes,
> +/// or an *extended* configuration space of 4096 bytes as defined in the=
 PCI Express
> +/// specification.
> +#[repr(usize)]
> +#[derive(PartialEq)]

When `PartialEq` is derived, I would also derive `Eq` unless there's no
reflexivity in comparison.

> +pub enum ConfigSpaceSize {
> +    /// 256-byte legacy PCI configuration space.
> +    Normal =3D 256,
> +
> +    /// 4096-byte PCIe extended configuration space.
> +    Extended =3D 4096,
> +}
> +
> +impl ConfigSpaceSize {
> +    /// Get the raw value of this enum.
> +    #[inline(always)]
> +    pub const fn into_raw(self) -> usize {
> +        // CAST: PCI configuration space size is at most 4096 bytes, so =
the value always fits
> +        // within `usize` without truncation or sign change.
> +        self as usize
> +    }
> +}
> +
>  /// Marker type for normal (256-byte) PCI configuration space.
>  pub struct Normal;
>
> @@ -34,16 +59,16 @@
>  ///
>  /// This trait is implemented by [`Normal`] and [`Extended`] to provide
>  /// compile-time knowledge of the configuration space size.
> -pub trait ConfigSpaceSize {
> +pub trait ConfigSpaceKind {
>      /// The size of this configuration space in bytes.
>      const SIZE: usize;
>  }
>
> -impl ConfigSpaceSize for Normal {
> +impl ConfigSpaceKind for Normal {
>      const SIZE: usize =3D 256;
>  }
>
> -impl ConfigSpaceSize for Extended {
> +impl ConfigSpaceKind for Extended {
>      const SIZE: usize =3D 4096;
>  }
>
> @@ -55,7 +80,7 @@ impl ConfigSpaceSize for Extended {
>  /// The generic parameter `S` indicates the maximum size of the configur=
ation space.
>  /// Use [`Normal`] for 256-byte legacy configuration space or [`Extended=
`] for
>  /// 4096-byte PCIe extended configuration space (default).
> -pub struct ConfigSpace<'a, S: ConfigSpaceSize =3D Extended> {
> +pub struct ConfigSpace<'a, S: ConfigSpaceKind =3D Extended> {
>      pub(crate) pdev: &'a Device<device::Bound>,
>      _marker: PhantomData<S>,
>  }
> @@ -118,11 +143,11 @@ macro_rules! call_config_write {
>  }
>
>  // PCI configuration space supports 8, 16, and 32-bit accesses.
> -impl<'a, S: ConfigSpaceSize> IoCapable<u8> for ConfigSpace<'a, S> {}
> -impl<'a, S: ConfigSpaceSize> IoCapable<u16> for ConfigSpace<'a, S> {}
> -impl<'a, S: ConfigSpaceSize> IoCapable<u32> for ConfigSpace<'a, S> {}
> +impl<'a, S: ConfigSpaceKind> IoCapable<u8> for ConfigSpace<'a, S> {}
> +impl<'a, S: ConfigSpaceKind> IoCapable<u16> for ConfigSpace<'a, S> {}
> +impl<'a, S: ConfigSpaceKind> IoCapable<u32> for ConfigSpace<'a, S> {}
>
> -impl<'a, S: ConfigSpaceSize> Io for ConfigSpace<'a, S> {
> +impl<'a, S: ConfigSpaceKind> Io for ConfigSpace<'a, S> {
>      const MIN_SIZE: usize =3D S::SIZE;
>
>      /// Returns the base address of the I/O region. It is always 0 for c=
onfiguration space.
> @@ -134,7 +159,7 @@ fn addr(&self) -> usize {
>      /// Returns the maximum size of the configuration space.
>      #[inline]
>      fn maxsize(&self) -> usize {
> -        self.pdev.cfg_size().map_or(0, |v| v)
> +        self.pdev.cfg_size().into_raw()
>      }
>
>      // PCI configuration space does not support fallible operations.
> @@ -150,7 +175,7 @@ fn maxsize(&self) -> usize {
>  }
>
>  /// Marker trait indicating ConfigSpace has a known size at compile time=
.
> -impl<'a, S: ConfigSpaceSize> IoKnownSize for ConfigSpace<'a, S> {}
> +impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {}
>
>  /// A PCI BAR to perform I/O-Operations on.
>  ///
> @@ -281,29 +306,35 @@ pub fn iomap_region<'a>(
>          self.iomap_region_sized::<0>(bar, name)
>      }
>
> -    /// Returns the size of configuration space in bytes.
> -    fn cfg_size(&self) -> Result<usize> {
> +    /// Returns the size of configuration space.
> +    fn cfg_size(&self) -> ConfigSpaceSize {

If you keep this `fn` instead of `pub fn`, then the `ConfigSpaceSize` type =
being
`pub` is not very useful as it cannot be invoked by the user.

>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          let size =3D unsafe { (*self.as_raw()).cfg_size };
>          match size {
> -            256 | 4096 =3D> Ok(size as usize),
> +            256 =3D> ConfigSpaceSize::Normal,
> +            4096 =3D> ConfigSpaceSize::Extended,
>              _ =3D> {
> -                debug_assert!(false);
> -                Err(EINVAL)
> +                // PANIC: The PCI subsystem only ever reports the config=
uration space size as either
> +                // `ConfigSpaceSize::Normal` or `ConfigSpaceSize::Extend=
ed`.
> +                unreachable!();
>              }
>          }
>      }
>
>      /// Return an initialized normal (256-byte) config space object.
> -    pub fn config_space<'a>(&'a self) -> Result<ConfigSpace<'a, Normal>>=
 {
> -        Ok(ConfigSpace {
> +    pub fn config_space<'a>(&'a self) -> ConfigSpace<'a, Normal> {

Nice. Less failing path =3D good.

> +        ConfigSpace {
>              pdev: self,
>              _marker: PhantomData,
> -        })
> +        }
>      }
>
>      /// Return an initialized extended (4096-byte) config space object.
>      pub fn config_space_extended<'a>(&'a self) -> Result<ConfigSpace<'a,=
 Extended>> {
> +        if self.cfg_size() !=3D ConfigSpaceSize::Extended {
> +            return Err(EINVAL);
> +        }
> +
>          Ok(ConfigSpace {
>              pdev: self,
>              _marker: PhantomData,
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_p=
ci.rs
> index 1bc5bd1a8df5..8eea79e858a2 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -67,8 +67,8 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32=
> {
>          Ok(bar.read32(Regs::COUNT))
>      }
>
> -    fn config_space(pdev: &pci::Device<Bound>) -> Result {
> -        let config =3D pdev.config_space()?;
> +    fn config_space(pdev: &pci::Device<Bound>) {
> +        let config =3D pdev.config_space();
>
>          // TODO: use the register!() macro for defining PCI configuratio=
n space registers once it
>          // has been move out of nova-core.
> @@ -89,8 +89,6 @@ fn config_space(pdev: &pci::Device<Bound>) -> Result {
>              "pci-testdev config space read32 BAR 0: {:x}\n",
>              config.read32(0x10)
>          );
> -
> -        Ok(())
>      }
>  }
>
> @@ -123,7 +121,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInf=
o) -> impl PinInit<Self, Er
>                          "pci-testdev data-match count: {}\n",
>                          Self::testdev(info, bar)?
>                      );
> -                    Self::config_space(pdev)?;
> +                    Self::config_space(pdev);
>                  },
>                  pdev: pdev.into(),
>              }))

