Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795500316;
	b=KlvkRlJSBSK1TzAr59BfANSofFMiUg+eMGJ2aNMNjtIH27b49AwTxjWMZXLV8YlaCUVj
	 /v43VR9GeANAaO5NCw/xwWXHVq5a6I7TTD0/v9bSDh40jA+FcOMr7c/ZkBkXr15cqyRED
	 X33TG6CX+TjhH41YqcK+we41JFL96713IeZpTOZQu3j/SrsCRjaBP2v4u5DWHJGIPH//2
	 SE44JWkQ8JMZhnXx24L5IJmDxbekz0Qn9AZC1pJn1uwd2B7bj3Ju9AEm4sfyMS1VxsNvs
	 3/u1eRkl9EmdLB4+fgBHaljk6lb+uGrcEjfbwpugFR0+JFhYNFSGcPoT3i+Bl9xRzDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500316;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ne0UN9ZyeZTt4zx/pRpgHeckezgLo+HnVPZhBw0BfIY=;
	b=QdqYhuCBI4S6MAazb/W8qz75ZhXtoiXMYoWt35yFc1Nb1pbELRyfd6sWGlyd1mjKuloh
	 KQxCM/AI52OZrdbNoTOE7QwPPowMjD5KwGk/dM3EMHn3vwJzCNjmhzsbXVJTb68jaLoVY
	 CBWz1ozKGOM1Oc/+Eu9hcy5CLfoxvWeb/KFpdSiSyMPfN1ivvWKPdhegFpMW2HZHArbXP
	 e59uyoZE2MFIpeO88uyrefd1qZHj80CsyshwvmdZp9cAAE5/3bwqa78ozBi1IB39Q/mxM
	 DdEdzngJQYhffYVeunLxrwv1/MERPKFHlCtvwTScHad49JUM8cP7IbXbmcJW+twlUKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YA8qdDrc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.70
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10A6606A31E;
	Tue, 24 Nov 2026 06:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C10A6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YA8qdDrc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+tOz2ZM+htqXNWJssKbhCyYAOK7X7Adb2Dib788kIQLiR4AFESOfWtDDDv9xVe74DhabXeWFYmZf9ZDlJa5YMOs/ud6ZipzA158rjshOelCtmczbAXE+n4wLxBUdhQZcKk4WXE/MQP7PGiof/UKUBHj/SNNxRi9Xj72P3vzLwn5PXXx56Dz7M0/4rZUcDK590zW0FDKMU5Shezf9K9/84U2KvRcZD8fkW1x7pkpyUJgeJUlHAwJ5c5WpH43c6Oqob9avU3PphrLfoF/cxiZ+h7+oSA5QNaKIPQqP/zTZ5iqARbZUXr/uuXUidq7KJmbDQXRXPcA1ci5f12DioOqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ne0UN9ZyeZTt4zx/pRpgHeckezgLo+HnVPZhBw0BfIY=;
 b=Qc131kQXaVI+K0mARPhVYr1KYhN2Obzp2BGFQX5zXItu/bMGDKlrNNN0eWQUpIqqcOAeg2hA0I8fCBiJRyxutKPzihodrPVt+UpEvtCy3JnULQYHBDmMP2hua8i84eqXvKwg0/LIz9F9UyhYotQLuvQPfn5jCNTtrvbcZHd5XonxOiPsjAnpQLHuqGmKZlQ2GTaADWpDLecDSWgcgAJZvL4Kqg8+rs9KF0BVrj8vjIiBvKqz6qjimuBOAsRIvW28Mad9vl/9iuwu+B61qEV99r3PaM55FmQJm8ynoayfYIdmDdRxl+VItXymJLgQ6AwkyukCQsc2swiqhaC8ehFXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ne0UN9ZyeZTt4zx/pRpgHeckezgLo+HnVPZhBw0BfIY=;
 b=YA8qdDrcpkD8RK+HWUrgYFHBWasjq1ilyROuM53jWdwjBHwDvyB/I8bBhK8E+PupjP3iueES89uFdd+oF/Dv39XtxehVPVPk75Iic3dzWXgcr8jaaFcx4XTNiLLAv2vv72CX53ICUg069Aqnqwuk+tv2b35DH/Kb69xdi1kzvec65egQpOEd152q+vfNH9havGol4n2Ad7O6JNPr8QnA9O1s/zh/P/CwVMVM9NKsgdnWSAK2IoLSvcu6bTcauWt65ScYlRUeNMLqc/6Fw1IUfx1S6lRJGF81uDsf9T+jh0y9rRew7IwsW0Ov3PsEvUopaWwNEIa61Hb05ndC096mXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.14; Tue, 24 Nov 2026 06:05:11 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 06:05:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 15:05:08 +0900
Message-Id: <DN37QMMBUBXX.B7K5PHRZ7OTL@nvidia.com>
Cc: "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "LKML"
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 1/9] rust: pci: add domain_nr() accessor
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261120044704.165223-1-jhubbard@nvidia.com>
 <20261120044704.165223-2-jhubbard@nvidia.com>
In-Reply-To: <20261120044704.165223-2-jhubbard@nvidia.com>
X-ClientProxiedBy: TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef48d7f-1947-4a34-b0d2-08df49f0e622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|10070799003|18002099003|22082099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	/A73T4WC8sqd7VPXTZuwPULfdankzOGvNqICx8nJsJbEbShb4UEvIzI+JzS9Yee72HenE/nvJWMz/JyRcv5QxfuOQI0JfP1+crBxh1FuocmvoV88/+OqQJTJU85cBZB7uKLgvXZsC/PBBld9xsb40SO1HMYs5CVQnMg9TVeb8akJJb0BoYCGaghEXohd0qpdaZPvw2bHWBhF4d0WhJUMbUByb8SjYg8t2Su8D6qLSM8EMAYekDd4qswCmWToDy+zXKbqIKQiDJeGpqYwQIrc1B33zSijVdq26Dx3Ypc7O8dVYk8bdX2oym+UfvHHQ926XQHwkJaRK4KPBwQauH87tCPBlKvKuzWciBXrVeJGm+Yl3k6beRbKEj0/XWR8IxUHUgtdXmEM/CHmrzlWOz2oW6ubiy3vYFnTXEhmrU/CBwWTHEgLm4yqqcyJb7wuCa3uN1Bpk67jXgbDPJJ4dh23Dos8cfTNERx87jRzIDHfr3GEvOgg/vNP6WA9UOyoIGlAOaXKH6b2FRAixjK6+7p1j9vB04eiRouG+6nVIG3h9N0mnWuOKFBWpnOSvsawmGOX3uzaArGeQVYdEpHxQcXUjIJ68qZ77IIVvwmEZNXGHYfltSwOPLPnNZGSgzDQy/P4fct/OzlBSsJNluiUJ1399MbTfjNCJf4+DXQuTb8mpBc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(10070799003)(18002099003)(22082099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0hWWTU4cGpra1ZpQ0FsVW9tako1MTZGcCtlR2RLNjl1RlFpOVBQQzVGTndv?=
 =?utf-8?B?VU1qSk9mU3hsK29YV29IZS9aTWN6VXg0YkRBVzBXUjFRMkFjSlFuNDdyamJU?=
 =?utf-8?B?cEZEbDY1eUdQTjNoK2NtZXRVUHIzaGVBdDYxSmlkNkYvNkJNTEpYdE9jbThz?=
 =?utf-8?B?Y2ZJRldoRkRQQk1FQTRCV3ovMTBXcWMwTjBRNFN5NnJBMGVQdHYxNGdRVnUv?=
 =?utf-8?B?SlpWSnlNNWFHNUN5WFR4bzd4c3Fkd2VEMGdjOGNabkZwSVllT1RxNHdJazNy?=
 =?utf-8?B?WHNtblpRcFAyaDdKSDR3Z3Vwd2c4QW5majcyWTIxa21ON0dtd1VkMVJ5STdt?=
 =?utf-8?B?cmZieW12cEphbUM5VVlzSlZmSGFDV2xQbjFPTkN6bHlWRVk5c09rdFhra1lx?=
 =?utf-8?B?NHdraGpqZVVEVFZuKzdKcFROVTRIR1JoYTFhSjhXUHZDSGh2R3BYQllMblRz?=
 =?utf-8?B?UFUyWkMzVUt0dUVXaHNIOWR5ODJ6b0dHbWFkRWdDWWZ0ekRQUVF5VHNlSmxX?=
 =?utf-8?B?TWsxV3hLM3JSWmU1UEZkOFhtUWNLZmdWM3ZLYWFYTUFOY0FCMTdFTkl5OVpj?=
 =?utf-8?B?SDc0Zm82ekgzeGRkRWpHS2thN08waXduclhMelh6YjhIRm9lZ0taSC9WVVdw?=
 =?utf-8?B?WFg4RjBBSUEraGptNitqN0hqYk1zTGNYN0VDM1ZDS2t1MFowdHBzVitTODNU?=
 =?utf-8?B?bDg3LzN5TnJaSjFMcUUyaXg1UTJmaW9admxDVzh1eTJYVU5SbWtkcnBrMXk4?=
 =?utf-8?B?WWFRbnIzeHFIeWdld1lKSFpINCtZRFBYOS9jckNqUGR5T3pLWG42Z3NUR3dk?=
 =?utf-8?B?cVFaaUYxM1VnYlZTL2IwZ3VXNUY3dkxINks5dEJheHA0SlpQV2tZc0NheEJD?=
 =?utf-8?B?NzZUcDlaZjRVT1NyNHZLaGFJUDVVeTdzdzE0UWFQeFprd1p2RHBMaVV3eDE3?=
 =?utf-8?B?OGduMDZtMzhZL1c3ZHgxUDJudGR3QjNFVG9uTFl6UUJ6OGZjenh3N0h5SDNW?=
 =?utf-8?B?blc1NFg0RUxhRWFid3VyUFg1WTdNR0VWT0VzOEwyaFpQaWpBbGtOajRKV3l3?=
 =?utf-8?B?aHllWUpkZUhvNXNoeE9rK0lCK2pUaHZaRHhyaUV0dUwzSUJCZW5QN0JjOUpp?=
 =?utf-8?B?Y2hWNnpWMXJ1YTFFMHcwdTNwNVo5WlVLRkpheEZDclNHNERsVFJJMUhUbjhW?=
 =?utf-8?B?Wjc1MW1ZM09GUW82WDVFME9aUWd3NmNKeFBjd3Z4ZkdXVUdyN1JEeGlKZnEz?=
 =?utf-8?B?aXVyVUlUWTNlcGFJemF3NlBMR0gvdGFKTjA4VkduTDRtUENTTEZHUHlwektr?=
 =?utf-8?B?dUErWXdHbm1FcHpIODRsd2VxQm50QmdsaGlEUEFYUE84U3c4T0Z2L3oxL3NS?=
 =?utf-8?B?ZlNsTG40M3NWaFdTRmU1VjMwd1ZPdlRkaGR2ZWFTWGR6SjZuNlVxL1hVeUF0?=
 =?utf-8?B?dVNnbWJ6d0R1SUgvQ1kvSGdoZzRCSHFadkoyRGRSQ2I1YWcwNjZ4eGRzTmVy?=
 =?utf-8?B?NWRrQXlYOS8zbFF3c1ozS2EydUFQdndFTmZ2YzRUVGI5Ry9kUGlhUGFac2My?=
 =?utf-8?B?emJEOE9uRTlpWWNQV2lPODRaeUg1VkRzWjZ1aUxvdkVwTTNMQkNBV3FQZ0xI?=
 =?utf-8?B?K1U0ZmorcXFpT0JqN3NKNTZQditOTU4rWXYzNW90bjlJS2NFRzJrUkRMeDRS?=
 =?utf-8?B?Znh6d1A4QWM5Z3YrT2hTRXJGSytyVVVJZVdCSHIwNy9CcktYNzVMRnNFYlR4?=
 =?utf-8?B?RWtlaWErT2YvWmVNZEtHY3psRld3d0p1bnI3a0lKMEc0QjlQclJCOE1LSU14?=
 =?utf-8?B?djI1U3Q5TlZpbXBEKy8zalkwcGxxbE54U0JmZmVXcXlkQkIrOEtHZ3BMTWVa?=
 =?utf-8?B?T2cwTlZLZGsva3lKNVY5R3l2Rk50dk5MdG00ZUtmbTFUOHRwZnc5UlRhaUZW?=
 =?utf-8?B?WXBJL2tUY2VTcjZuUDFZenVuckh5RVNTVlBubVJFcS9rQXU4cmpPTmlwSnVD?=
 =?utf-8?B?VVhhcFZ5YjgvcXhxZC9BZy9za0pjZXVEMUFNUFFHS25xYXY3bVJ3Slc2N2xl?=
 =?utf-8?B?OUs2Q1EvUW1XY014anFpbDBwaVBSNUFoQ213d0lTbFM2NkZRM0pMM2JYT2hW?=
 =?utf-8?B?RjhlRm12aklCR2NQNjZIVGl4SWppRHZQYnJ0M1BybjZCd2pZcnc5N09DTXVi?=
 =?utf-8?B?ekt4cnZrNW9YaUNiMVlkNklxQ1pCaUVPemJtZzhsUTlMRjlld1JzT1lnM01l?=
 =?utf-8?B?YzBRazRsV21IQUJYS1ROOUN2N3E4NWhzSXYyMEo4aktpNFlGaHhiMWdLMXFp?=
 =?utf-8?B?QjBxZTBySXhKREVGcU5wd1l3RVRFdDlrYW5FZnNQQ1hVdlVMbEhPbEdYZDNW?=
 =?utf-8?Q?1OpydSMwffQ/6nye0CtlUPcbH3q5uEPi61eQh2BjahCXV?=
X-MS-Exchange-AntiSpam-MessageData-1: DesPcZXDdjDbYg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef48d7f-1947-4a34-b0d2-08df49f0e622
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:05:11.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fysk7M+U41d9CWyXSjzB7Osoq3OYhUy2/TxB4VcBp3xdeML18BLpHf5txGTybq6ItdWw0sDu0/70BHPQ1QxyVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633

On Fri Nov 20, 2026 at 1:46 PM JST, John Hubbard wrote:
> The nova-core driver has to send the GPU's PCI location to the GPU's
> firmware as one word that holds the domain, the bus and the device
> number.
>
> The PCI abstraction has dev_id(), which packs the bus, the device and
> the function into one value. It has no accessor that reports the domain.
>
> Add an accessor for the domain number.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
