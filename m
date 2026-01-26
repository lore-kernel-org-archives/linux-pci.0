Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021098.outbound.protection.outlook.com [52.101.95.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737D3238C0D;
	Mon, 26 Jan 2026 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449696; cv=fail; b=Ov+RlU6Bct9ho8wyJ8KAu3MzXUAiQJ1DH18JLu+ItwvDOxF7E5cMPjMe3PtUTHtFTMzOMVgn+21SMX2DiDzqmRWzMV1L89rxsOqU1YyMmoDZJ7TOHlBCDyXtAAs/pNSmLyXIcuZ/V7Bvf5Ai2LIzmKUUlOGUW8QXo1IAvPGxlxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449696; c=relaxed/simple;
	bh=0y1Sule8I7ssy9c/2dm9x1b6rEfFWA8DCbc9C+aU27o=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=SZm8M/UPSO00NMBkV3R80BbBbN0p9e8GlTZ7dkvz+P4l/lAHyDNPAgxeSNeAhOpwB4kkIaIUTsEmv0K3+nqMs/Wl5b5JLy7YxGoIt0dtYQeGAoBTySGgT7UhFRvls5OcF7nkMlDKeBtCD8QjN4Rw0Zwxa1jqMnPQwu3bzl2OBNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=pphnbUDx; arc=fail smtp.client-ip=52.101.95.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="pphnbUDx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7YBBsYDFmAeZstBwOI86p9mu1G2UiFqxKmaO86umdj7hsgQnwXuhujjr1FE7jMrGQEAgRA+XNnyHu1jptpwbzDXQZ7SmVNvMp1ZW0b6nZMwo6detf2unC2hflLJ3qW2SiUvwRBwjnzMxRqEu80NyZmo8wRrlJmxRx7iUAlAZ/f7UaiLnOzqs7/qH/p32+CX+fe+aSvh/qcbJqz0gHaChgcfyFQJXCgVgnAumD3S65OCf+uvEkjtyaolsNESebCDYPM1RB68azIiw1i0jDP2BwHvOqdikkVpGgXA9W2oNB0ge7f5qBIBuL+jQOmhx4fSTFBoqkrxmllYE/TGd+nAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK0awZSmN5ROiTMdp4Fn5QwQLonQWf8UU9f29x+XNPs=;
 b=bQlHCXzt9NrDXPbA0GGHfjypUqXSAoDPqfPi8szwBf7LUEB2SOGRhPxmtFnMGkOU+GC8U0Ww7NtT/zjsAXD8aGGZ9NT4gQqowvuUSVJ38SASWlBCvwTaCc8MVOHx206fD7uHFFL4rFPetyjSPwJ+3I9ChZh+OBq/OimeedVXR2spoURaTh1z65mz8rZc3xtU2YDwmSKN/kd5vOXJBFLCGhuMt8dm+MV03RFOhN3XIPZsGFbhgKGFGAX7Vo0JWaXGmJqjLX9nbjPCTthakTGlLlcb7Fx9AhVM7e1dHjxC3+S91aJ5djo+vqoEhJOFKc4THJ67v9fC5rK1lR5WM4gsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK0awZSmN5ROiTMdp4Fn5QwQLonQWf8UU9f29x+XNPs=;
 b=pphnbUDxtaFMqSYhLjbeopgBxOM+dhuUQ2C7rHE8DMpEFKADTUaiv1zycimHqcrAugeqEO68JyKyCh2mJzjdhOuHfKlATdo5gILCCYSpdc6262MShYWyNQYWg/f7J9OPDDWC7u4jIcy6Qta9J8vnMe32HgBczoS1nhJonxcR8KU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB3029.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 17:48:11 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 17:48:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 17:48:09 +0000
Message-Id: <DFYPKDARUMSH.21DBL43XL21S2@garyguo.net>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>, "Jason Gunthorpe" <jgg@nvidia.com>
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctl
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260122204232.15988-1-zhiw@nvidia.com>
 <20260122204232.15988-2-zhiw@nvidia.com>
In-Reply-To: <20260122204232.15988-2-zhiw@nvidia.com>
X-ClientProxiedBy: LO2P123CA0104.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB3029:EE_
X-MS-Office365-Filtering-Correlation-Id: 982e142f-5403-4ce4-4137-08de5d0311bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFgwUkUyOVJKWHZJRGpuMXduWEovNjNwV1JDQXJXejVxeWExQmQzLy9jWmd2?=
 =?utf-8?B?MWpJN0hiUzYya09uNWlEMWtsblF0TndnM3JNSE1UUm5HNXlvV0VrMlZUczdF?=
 =?utf-8?B?Nmp3S0JBbkZUdU0zTElLYUVGOEVOdzJ1NVowSVJQZFRvM0hlVW1iWHg1NU9u?=
 =?utf-8?B?QU8yN08va0Uya015TFJWeUowalNtZTRZOG15NzBzd2d5WG1nQWw5RWVsRHJp?=
 =?utf-8?B?RFJpN0Vab1NoUTJKQmxzTExYK2M3VlJLU1JUUTA0N0ZJeC92S2Q3QkhPMXp0?=
 =?utf-8?B?N0VMYWd0VFhKRHA4dU9NNlk3R3E4R1pRaHNjL0wwOStQVzgzWGlVQjFZSDZj?=
 =?utf-8?B?SUkyQUttR1ZVc3pmMzR4TnB5ZU0wdFJvVVFmSVR0Ull0MVhmT2czTUlkYWlD?=
 =?utf-8?B?SEJEakJEQ3VHL1BnSDZPQkoyYmgvb1lYQUJjbzhWSlFJcGpZN05VZkRUdk1u?=
 =?utf-8?B?WnZtQXJjQStoK3hSSFlPWmZ1VjdhOWZqL3ZqSXQ2SkNYbjVBVGFxTGxVOGJU?=
 =?utf-8?B?MmtqVGRIamhNUlF1SHJCOTJsK1RTLyszT01vU2xOVzVhZWxQMWVGZjlDTU5j?=
 =?utf-8?B?TmVCUWxHcml0aXB0TFV4TG84VXArWGJSbFZIZWZJdHI4dnB5SHdTR3NYN2VW?=
 =?utf-8?B?MDM3SFVFS3hNZHZjcnVyZDZDSHhCVHQxZ3YwdkxNbllEdWJLMnRPc2dNNktF?=
 =?utf-8?B?dE1IYzZLeUhHVXFhaHJhMVNhMkh6ZVgyUVd2OEJpOHp0eCtud29wQWhxOVNz?=
 =?utf-8?B?dVhtbkdtdC9Qc05PWjVxbkg0U21QMDE1d25XVkRubWI0SThrdUZ1MGxhYmIw?=
 =?utf-8?B?M1BHZXZxalF2YkRLQ2R4aGVRVWl3ZkFlREJIWUx1TTFycG9JcGpQeFFTSGtX?=
 =?utf-8?B?WmhocnJueUZzZ0V3M2NuUEtubnNDSmd5UTFESjEvWXdvMm1wTXJ6RHM5QmQ3?=
 =?utf-8?B?bzhBbGtDeG44RjRPaW53Mk1RTVlvN002REdUbjU0bngvQWx2NUpncklUUXJs?=
 =?utf-8?B?bURPRUxETWl4eExIbjA1cS9DMlR6Qk9DWkJNZFNncG81cjVjSHZRUm52R3pK?=
 =?utf-8?B?bWpFQUhXSXhseFlnOE94RkpKVlplcWxIaWxTREFWZlNvdVFHcGFHMGhNaDNh?=
 =?utf-8?B?UVpTVnQ4S1RhZUdKWXhHaThta1hmeW1ud3l2T2p3V0E0V2hpYnVGSjMyL1Zn?=
 =?utf-8?B?Ti9wUG9WdFN0YjlsbVZxR1ovY0gybWRqeXBKUEUwVVQ5bGlna0ZZbHpRZGsr?=
 =?utf-8?B?YURrNGxIOFpBM1lHYUkyU0FGODhjRStVemNEbm1CYTI1cFdHYUlxSCs0UjAx?=
 =?utf-8?B?SW9UOHVGYm1DN0dqRzA4bnpVaHk3SXJTMmpSYVkwZVdUSTVVZUNQNTIzbytr?=
 =?utf-8?B?OUI2Yi9XTmVXTW1kVVk1eUFwbFdBWTFqUUhBZGVrMGw4WkRiVGJ2SzM2MGI2?=
 =?utf-8?B?dTNReEhNSFYwbW93WFVqNHUxbVluVytwajFmenRDdkVnNnVxKzloZkc1VEQ3?=
 =?utf-8?B?bkQrTjJ1cnh1RlNmS0FmV0NDK3pZOWFseUtxUFNPK0RUZ2NiTllBcUs0QTJS?=
 =?utf-8?B?UTQwaXpKSHY2T1B5d2RoaVovdEhSRFQ5QXdJZHJ1SjA5UW9KTzhoUlQyVTkx?=
 =?utf-8?B?ajQxUGZTZHRydXZpdHVDUWZNbldzeUFlVHBpaXRqQWl6eGswVlFwYU5JU3NS?=
 =?utf-8?B?QXVUUTc1MGVQU2MzKzBzYnpuRithMThGS3diKzJLU0FVeEtyNEZTb090eC8r?=
 =?utf-8?B?dllERTlkQXhqK08zUm16Y0hkVmFpY1JXaTdFUjdlcXpvZHQ4N01NOXUzQmI3?=
 =?utf-8?B?Skd5ampVTTNzNHEyQm5wRWEvV3BkTzcvR3RjSHZKZkN4cGUvYm1sTVNOYWta?=
 =?utf-8?B?OWE0eUUzNTlodzVhL0EzM0JTekpReGxYTXlGelVZVVVUc0hkc29NQnpIbks4?=
 =?utf-8?B?UWt6WUlwTTIzbE1qV1ZlZW15bi9YZzRiT1AvN1lFQjdMSlg3dkNOYkRueWl2?=
 =?utf-8?B?dVJPZWVjWEZ1SWwxazNoT1NSc0JXaGRjemNHUHNWLzJ0UjNuU3hEeE9IaWVu?=
 =?utf-8?B?VklDOTVOQ2RXeUpETTU0SW83Q1IrS0JUMWd1WXdyQjVlRXVsMkN5N1VaY2Jt?=
 =?utf-8?Q?R5gY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE52TDNpSmxCN20vZnU5eDdZb2NqaXJ4RXJzeGd6d0E0aUpWMTVXVmxCejFn?=
 =?utf-8?B?S3ljUG9vSXBCc01BS1ZjVklWMTlZTWtKanFtN2l1cDRqdUZNbDRHbVU2aXlz?=
 =?utf-8?B?a2U5VGhyVGxkZWFyazFnTDk2a2wzZ3hvSG1mNnJ3MlhEREQxR280bGJqck1W?=
 =?utf-8?B?NHVLaUhlZXBzaGVTbGZtb1FLeHdRQkVnNjRWbXhGb0FtS0Naa2syK1g3VDF5?=
 =?utf-8?B?T0pLWE9NUGl6WGVINTVhODVKQk5rY3hNN3VNTzZTL2ZGZk5yQk1BVmo2Ti90?=
 =?utf-8?B?cUNMbkVPd0hDa3RURDNoemJPbU0weWJOOFl0V0hVRFdzRE9VOTJCN2pWRnFH?=
 =?utf-8?B?QUNTSXRMUlppMmRyZlZmRCticW1mSzFPTFBSeW05NGVpMjRvUnlFMUpHTzBv?=
 =?utf-8?B?S0RGQTRQcDV4dEROQUF1a09leWNJREY2dzNFYjRtVW1URDdFcTNjbXN0S3Vq?=
 =?utf-8?B?elQ0ekxvMXdOaGdhYnBYc0orT2JESGlTWm1iVjZWTk1raVJqd2d6S0NhWnhk?=
 =?utf-8?B?SUZCaTlRRE5XRWNDK3htNStVQWxOUHhVaURoekxhZ0FzNDlDMEZTMHNJakdp?=
 =?utf-8?B?MzMyYXVVWkIzZzg2UUNGeXJGbzF2UjBBOEFNKzJ3S29RaFlFMzZsQ2VRMjNG?=
 =?utf-8?B?VENIRmV4dUJvRUo3Ryt4RFVvTjNoOTdUSEhjVXl1WHhqL2lYRWtYRjFWbkV1?=
 =?utf-8?B?b1hTbFJCQURJd2w2Sit6QUwyRWZPd24vNVRWenpzTjNjTnVlbE8zd0FPN2Jm?=
 =?utf-8?B?am1jL2lMTU9rdXlxZDdvMy9GeGFyYk5oSkRiVmdac09GaXRsRDFINGdreU1J?=
 =?utf-8?B?YmUzQTZPVEhSRWhrc0ttL1IvZmQ4ODFKcjB6WEV5dWhyZ2RZaE5MSUlNSjhz?=
 =?utf-8?B?OTlzbmE5MCsrWTdjSnMrVytkbHo3bFp6dHIwb0tWcnpySHZYWC90RXcyTFFi?=
 =?utf-8?B?VUhQd01Ed2pad0VhZVlFdVJiTmxKaWQ1VDBPbVduaG9PSFV1SG9naTdZb2NP?=
 =?utf-8?B?SmVlcDBKNEJ0dGNpQnVhblhCR2NqRUxvd2s5Znk2NVBqR09UaWoyZXN3NUlj?=
 =?utf-8?B?V1M1WDNMWTRPcU1oMSsyckpNc2d5SCtGUWprWmx4RjZ0eG9MVFhzYkdnMUd0?=
 =?utf-8?B?eGY2bUMwYWRFbkx2ZUdxTFJINEYwaVRCZXEya3lOYTBGaGlHejc1VlBoVG9T?=
 =?utf-8?B?ZFUrcFVMNkg4S0ZTaXdiQUtBN2Z6RDNqclYzMWp4bzNhQkovTTBybEhuRzl4?=
 =?utf-8?B?d1VVVlgwR0lHWEpXME1EM0wzaiswYi9hUVFzbWdLemVFUWt6TTJMbDhKRTZa?=
 =?utf-8?B?VDJ3VEk5NzdCSEtMRndFcG13RzhPWHRtUUtuU2Z2dlhieFFqYzBxWHl1QzRX?=
 =?utf-8?B?amRvb0Z3VVVnbnJQUFB1THMxakdHSHkrckFaeDFVR2x0RTRXdEtNVWJEcEwz?=
 =?utf-8?B?OGtxa1BJUlkxK3lnK1k2SWtQNTJWVURaSVQwWlFiNzVRTjVQOFBEdVYzaFZ6?=
 =?utf-8?B?c1Y3TjloeTA0MkFBZWcwOHlGd1JteWJXRWRGdGc2eWpPRWpEbjFnSW1lTU9M?=
 =?utf-8?B?VVJwb2RBV2VFMythcDJNUGFsSVBiWE10bUlQTTUzL2h0NlR5eVNDUDdObGk4?=
 =?utf-8?B?T3IxNCtDNHU3ci9mU1dQT2x0M3l2eUw4dUxLelMrTkJmVEE0cnlhVWtiTGIy?=
 =?utf-8?B?VzMvUC9qVjUwU2Ewb1Q5aUFtdzBYbHJlODBEbm5VcXdWN1BFdVlrZGVhUWRp?=
 =?utf-8?B?Ni9PYStYRzloOHMvRitDdW95N0FFYkZ2V1EvejA2aHk5YzhCMjczRWRJL3gv?=
 =?utf-8?B?eXFWcEFGeW1ueXJIUnk2YlFIOEpIbWZyQnpOdzRwb1hWa1NWQmdFYmdrd2N6?=
 =?utf-8?B?ZFM5NG1VNTQ5WGpjVFBTeU9uRTBiSzh3bHU3VUhvckJqK0JpM1RKSXFDSGhZ?=
 =?utf-8?B?OVlVU2FiZ3BMbU5WNEtUSTNBSUIvQU5yc3kvU0wrZEovUEpDTkx3ZFEvSHRF?=
 =?utf-8?B?MWFhaGovazF3OVhEaWFpS2tNcjNMOGR2akczclVoVGt4NEpSNVFQMkhtWSs0?=
 =?utf-8?B?OGJLcUJ3d3NtVWVxVGMzYkxzWFE3b2RPN0gyNEhaMEJrdzJ4a1lCM2dSSzNC?=
 =?utf-8?B?QVhRdGxEVnNoNzBTS21OM0l6eXJEdzhWTzhaWkNZS0tjYS9lZ3lxMUJEcXNY?=
 =?utf-8?B?aDRnNVZXMWJPT09hUG5OcklyUlZVdUhkN1VyaGtuRi9TWUNkQzh2eDFUS1BE?=
 =?utf-8?B?dEI3eDF5Zk1QMFZsRHNTM2xSbUFBd3hCMWtwSHVoVSs5bVk0MEJNOGN0MnFq?=
 =?utf-8?B?eFNGMmdWVGRKd1c1eXRMaVdZQmxTL0MyR2QxanBoSFlkcWR0dlhudz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 982e142f-5403-4ce4-4137-08de5d0311bd
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 17:48:09.8143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWRIoBX8OM//i1aUu+NDCEZddu5cXmDSB0G62UuZ8rw1ifPkuvHM2tWxY3YI2bcJ2qZB6aHfNtjlJgAy2poaTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3029

On Thu Jan 22, 2026 at 8:42 PM GMT, Zhi Wang wrote:
> Introduce safe wrappers around `struct fwctl_device` and
> `struct fwctl_uctx`, allowing rust drivers to register fwctl devices and
> implement their control and RPC logic in safe rust.
>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/fwctl/Kconfig           |  12 +
>  include/uapi/fwctl/fwctl.h      |   1 +
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/fwctl.c            |  17 ++
>  rust/helpers/helpers.c          |   3 +-
>  rust/kernel/fwctl.rs            | 456 ++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   2 +
>  7 files changed, 491 insertions(+), 1 deletion(-)
>  create mode 100644 rust/helpers/fwctl.c
>  create mode 100644 rust/kernel/fwctl.rs
>
> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> index b5583b12a011..d8538249f3ae 100644
> --- a/drivers/fwctl/Kconfig
> +++ b/drivers/fwctl/Kconfig
> @@ -8,6 +8,18 @@ menuconfig FWCTL
>  	  manipulating device FLASH, debugging, and other activities that don't
>  	  fit neatly into an existing subsystem.
> =20
> +config RUST_FWCTL_ABSTRACTIONS
> +	bool "Rust fwctl abstractions"
> +	depends on RUST
> +	select FWCTL
> +	help
> +	  This enables the Rust abstractions for the fwctl device firmware
> +	  access framework. It provides safe wrappers around struct fwctl_devic=
e
> +	  and struct fwctl_uctx, allowing Rust drivers to register fwctl device=
s
> +	  and implement their control and RPC logic in safe Rust.
> +
> +	  If unsure, say N.
> +
>  if FWCTL
>  config FWCTL_MLX5
>  	tristate "mlx5 ConnectX control fwctl driver"
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index 716ac0eee42d..eea1020ad180 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -45,6 +45,7 @@ enum fwctl_device_type {
>  	FWCTL_DEVICE_TYPE_MLX5 =3D 1,
>  	FWCTL_DEVICE_TYPE_CXL =3D 2,
>  	FWCTL_DEVICE_TYPE_PDS =3D 4,
> +	FWCTL_DEVICE_TYPE_RUST_FWCTL_TEST =3D 8,

This is UAPI, adding new device type just for testing is not ideal.

>  };
> =20
>  /**
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 9fdf76ca630e..2c50d5bab0cf 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -56,6 +56,7 @@
>  #include <linux/fdtable.h>
>  #include <linux/file.h>
>  #include <linux/firmware.h>
> +#include <linux/fwctl.h>
>  #include <linux/interrupt.h>
>  #include <linux/fs.h>
>  #include <linux/i2c.h>
> diff --git a/rust/helpers/fwctl.c b/rust/helpers/fwctl.c
> new file mode 100644
> index 000000000000..bb4a028e7afb
> --- /dev/null
> +++ b/rust/helpers/fwctl.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/fwctl.h>
> +
> +#if IS_ENABLED(CONFIG_RUST_FWCTL_ABSTRACTIONS)
> +
> +struct fwctl_device *rust_helper_fwctl_get(struct fwctl_device *fwctl)

Helpers need to have __rust_helper.

> +{
> +	return fwctl_get(fwctl);
> +}
> +
> +void rust_helper_fwctl_put(struct fwctl_device *fwctl)
> +{
> +	fwctl_put(fwctl);
> +}
> +
> +#endif
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 79c72762ad9c..19a505473bef 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -27,8 +27,9 @@
>  #include "dma.c"
>  #include "drm.c"
>  #include "err.c"
> -#include "irq.c"
>  #include "fs.c"
> +#include "fwctl.c"
> +#include "irq.c"
>  #include "io.c"
>  #include "jump_label.c"
>  #include "kunit.c"
> diff --git a/rust/kernel/fwctl.rs b/rust/kernel/fwctl.rs
> new file mode 100644
> index 000000000000..4065c948784d
> --- /dev/null
> +++ b/rust/kernel/fwctl.rs
> @@ -0,0 +1,456 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +//! Abstractions for the fwctl.
> +//!
> +//! This module provides bindings for working with fwctl devices in kern=
el modules.
> +//!
> +//! C header: [`include/linux/fwctl.h`]
> +
> +use crate::{
> +    bindings,
> +    container_of,
> +    device,
> +    devres::Devres,
> +    prelude::*,
> +    types::{
> +        ARef,
> +        Opaque, //
> +    }, //
> +};
> +use core::{
> +    marker::PhantomData,
> +    ptr::NonNull,
> +    slice, //
> +};
> +
> +/// Represents a fwctl device type.
> +///
> +/// This enum corresponds to the C `enum fwctl_device_type` and is used =
to identify
> +/// the specific firmware control interface implemented by a device.
> +#[repr(u32)]
> +#[derive(Copy, Clone, Debug, Eq, PartialEq)]
> +pub enum DeviceType {
> +    /// Error/invalid device type.
> +    Error =3D bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_ERROR,

Does this need to be present? I took a look at the C side, this isn't used =
at
all. It'll be a bug if `Operations` impl uses this value as their `DEVICE_T=
YPE`.

Best,
Gary

> +    /// MLX5 device type.
> +    Mlx5 =3D bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_MLX5,
> +    /// CXL device type.
> +    Cxl =3D bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_CXL,
> +    /// PDS device type.
> +    Pds =3D bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_PDS,
> +    /// Rust fwctl test device type.
> +    RustFwctlTest =3D bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_RUST=
_FWCTL_TEST,
> +}
> +
> +impl From<DeviceType> for u32 {
> +    fn from(device_type: DeviceType) -> Self {
> +        device_type as u32
> +    }
> +}
