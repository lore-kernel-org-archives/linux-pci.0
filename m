Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012073.outbound.protection.outlook.com [52.103.11.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328F322C6D;
	Tue,  1 Sep 2026 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263281; cv=fail; b=s76uqSb0SzdgugIb/siANXIC6a6QsXEdcA2ELSddjcn977GROp6HEk/eDkYf11/Huz9phL/H54Vo6S0haMH2D4xy90XJksM7atG+ERLGvvn6TOZjdrXXCJwSeohcBGXa0iwZ9j3mUHGYzQb9j9PUhy8SgWwhfwzoZecnMkwI4nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263281; c=relaxed/simple;
	bh=hcFl1ppmdHB6ZipwOr+JUePQBKn6lxbSChOBlR/7yXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GjzglCvxqji0XeUvrv/vqz7qPNgB8KWYDkK0dhW7K18/0mDM/736Te1pByMhXwGXEyPqWp8sLtIghPxZOeJ3mJuCFNRwWg2OSccFLi2ZwlPY7KH4/5OhOfX91Z/YmRs/PQAVhLNrvyzHpJJlMJYOofwLHU/dRBOhvaBPuizJYvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=CFPy3ahq; arc=fail smtp.client-ip=52.103.11.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="CFPy3ahq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nphMP4rLo70p3T/t2bCF8boTIMzODA0Vxn11dJmnpkUkC6DZ047+2G5pg9H2f/1O+H+PNBaqfJZ1vye2UeTms/z5r3pVtwTwS010l4qzb7Kps95sgmbIvMIi4ldoV4SYs0y8XIN2rHjYM78skjyQrgxH1b6A7kHPXHyoM2WXrrZ+jwz++Ed4OZwHgKxvopoJ/y7cCbpGq6W0Hfr6QBVk+sdLidwf6a5jkFQ4tyrQrwpZTvomWQdQpaUP0TaofOLqHs6fC4JCupBXFWP6P+1rNln+PQ4PtKpDCFSkkjM+K4Emq+xi69pCuMwvaJmd/jdI+KbHy1z6Ftpimn3VNMpXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcFl1ppmdHB6ZipwOr+JUePQBKn6lxbSChOBlR/7yXk=;
 b=NO9fPcAiVFwzTFr6EVL+xhn1Qj+7lGI0c9k9JPFzov+1bpXW10EnitpaBLyUVaoxMQN110HMvyXjdDxVmnB7dwWBR0AmCfrZuFIOV2k8y6QbURi+gCnR1Mv44cXBM2XPwLCOLprDJh3Ld/RXk2/3l0PgWgD5D+aXvHIh+Ce1Ty/c057r7/hHQlV732tiUVHKTqDy5nh/Ck723/rwggkkJJv9NKLCokscyFN2hI0wgJcEnrZAHiOpwG2soN6F88nsHCqpVe8OvGqryQd7ObA+2ol/u6sHvQvy74awuL+6vzPiZlkQNFoikduuylOaCoEsx2RRF4vheMmpkwpeD6oMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcFl1ppmdHB6ZipwOr+JUePQBKn6lxbSChOBlR/7yXk=;
 b=CFPy3ahqv1OKhHbu09RxyAsAcW2oUwz7W4ewwMq3XGjHCDklK/Cr5Izj75rOKz8S2486AlIaUUXaPYUthpH4nhZshea5mN9NcI/9Gdfo6hi7DSM6tLPHRxJrDi69duHJdk0I4gZl70GKIOoAM8nsPlr4tY6+f3ointUA2g5IVHe935BjkwSMFEh/e+Mt0W8b4j35bEA2FUl1iDVI5vK+phIVEy8cBvwOVTqjxhCzfELcDvKVvqsAG9zqSOPtvibpT6s7r6o9ncBkU+1x9m5UKWLAuwb1Bb+49Uwbd8+0Tfh8ATvKg5xbAA7ArmU4eW/udUAviS8gHfg5tmgREswdCA==
Received: from SN7PR07MB9708.namprd07.prod.outlook.com (2603:10b6:806:32d::7)
 by MN2PR07MB7069.namprd07.prod.outlook.com (2603:10b6:208:1af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 11:47:57 +0000
Received: from SN7PR07MB9708.namprd07.prod.outlook.com
 ([fe80::b852:966d:a1c6:78c]) by SN7PR07MB9708.namprd07.prod.outlook.com
 ([fe80::b852:966d:a1c6:78c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 11:47:57 +0000
From: ai qubits <aiqubits@hotmail.com>
To: Alexandre Courbot <acourbot@nvidia.com>, Sophon Zhang via B4 Relay
	<devnull+aiqubits.hotmail.com@kernel.org>
CC: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
	<gary@garyguo.net>, =?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>, =?utf-8?B?T251ciDDlnprYW4=?=
	<work@onurozkan.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjRdIHJ1c3Q6IHBjaTogcmVqZWN0IElSUSB2ZWN0?=
 =?utf-8?Q?or_indices_that_do_not_fit_in_u32?=
Thread-Topic: [PATCH v4] rust: pci: reject IRQ vector indices that do not fit
 in u32
Thread-Index: AQHdOWxhfi2vd45HaEGtwvA0/upoIra5jr2AgAANj/k=
Date: Tue, 1 Sep 2026 11:47:56 +0000
Message-ID:
 <SN7PR07MB9708B6C36F40362265511D2ECFA82@SN7PR07MB9708.namprd07.prod.outlook.com>
References:
 <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com>
 <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com>
In-Reply-To: <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR07MB9708:EE_|MN2PR07MB7069:EE_
x-ms-office365-filtering-correlation-id: 99d7bd69-98a9-4111-82e3-08df081edd93
x-ms-exchange-slblob-mailprops:
 P1EfU6pZOd/ur0QDa6YmBjuOVf78JKoncpvHpeg6ddB7YluQqTyG6/MnfgJ0YXByIbxp83UCzOE17dU52CAcWOQdTfP2i8zGuSoq+6ON+Z4zW62x5sGW+wi9FlLAnq9PxvKUp0FMlXwl3IWqrQgzyMNGDeuE3WgwCN75jD07KKQjYx++HXYsk0l1HkP9x8HEpdSNsgzVKQMC9ybIXw8ylH5T7vGGlEBHjP1lGZUypsxBU0PEWbY/Dt6PxWDIWtwpGzwo4QHh1/tbGN+M1jormeBVp5YuJR33AN66ZqF37EuQetHGG6wf5ET4OyhwdDxwR4GU2C2JYc1zSDkLC7aM2kcLNIyKz/AHJupo8snfGjxjpSaF/1ekbR3J343BemziOMw/WqXOYFgas0k5ppW0U5ttaqxBdC9IL1ze5M6ukBcYZXCkpJGW6NhiyqsEyHgeEOyocfe9gDg1065HL5H0WB04vWfpqjSriF30LQ7SI5gNgd1+7b8QGPtIYMR6sf0AvMP5h/p0+26Ej+ggCDBRppbGmP2mmgGv5fW/Mx2cb3TV1NV6qmJxFfqUOMIQrClR5Nt5i5gXV/z5ZeiZHG1748MemT17nBHJ/VkhPQHtii9GWqgQ141/wvaIjEmw+kzEc2EYZFNSVaxCAXoqdfbgALJCljdQly+CXmtU6ukdvnU6MMq0VbpwSh/k8XWhOte2Z//b3E/yXBvBRKuyswXNAQFoWD83Wmo40tB4XI+zFqoV1KPsTtl/9oku1PAPIWGKgrziFaNnNL3q05Q1RPXrglGt+mC59jGkHBFAjxaUBgvjChkxkhpE3A==
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|24121999003|45011099003|22091999003|12121999013|7042599007|8062599012|15030799006|6072599003|8060799015|19110799012|51005399006|15080799012|31061999003|6140399003|40105399003|10035399007|26121999007|1602099012|2607281247196008|3430499035|102099032|4302099013|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHFNWlo0dVdrNjk3aU5iTlhkV1JtdlJkTHV3RUtlRVBhSTExYkJ0OStuRFAy?=
 =?utf-8?B?dU5ydDREdysyRmVHS2JhYUU4V1I0WkY0dGRRYWZlcW1SQ2VwQVo0Y013UmxO?=
 =?utf-8?B?M1ZRT0RaY2g1dXhuUWRpdVp1R2dsRlZaVDg0VUt4WExsV2NtTkg0WEJWWXdJ?=
 =?utf-8?B?TU1UVmZIMGxvZVA3Zm5RWTVXTWc5ZVJVaG02OEx1K2FFeU1iMFRnNnJ6RkJL?=
 =?utf-8?B?VEVvUWVzZ2hObjYvTUZUelRLTU9JbW5jd3kwbG0wc0hwWkR4cmFFSmw2MWkz?=
 =?utf-8?B?d0ExaDdQNThpZllaWFdTTUNzZ3BLTlVPTzJkT3VtNU5PWlc1MUpBZ3J2OEc0?=
 =?utf-8?B?WmNOWjc4NGk2NCthQ0c4U1lUMy9GUHNLMHd1OFJpVWFPenZIUDhLZEhIRXFT?=
 =?utf-8?B?SXovdnZOUUdsSkIwam9mbkRJRDhBU3hmbmp6ZWZybjJidnFSTUMzTTZacWNx?=
 =?utf-8?B?ZEVBVUgyRGZ5ZTJCeDhJZTRnWVRtcDVCY1JMclVoMG5ISlgwZnUwdElaeXBl?=
 =?utf-8?B?dkU4UUNtUG1TMVNYSFM2SHVPUjk2ZGJZT1VoRFppVlZLUnBJRHRIempiWU5X?=
 =?utf-8?B?bVNkbG9HbDRRMmZ6dks0N1BmTmp2SjJtcktHa3d6NzJJaVFWSlRTdE50S2cx?=
 =?utf-8?B?cVJMS2ViUkpTN2Q5Zy84aE5ONVg2ZVRzNHkzVy9MZmxpOStrRVV6NW5McmNF?=
 =?utf-8?B?bXBqdVVmL0V2VXhZWTkzUVJNYnhwblIrMG5pem1ZOGFSdUpwLzNCVnZCTHM5?=
 =?utf-8?B?V0JWUDlQRGhwY3FQUTRtM212TXBrRmlXN213akFCbysyK1U3V0hxSHBFVHJI?=
 =?utf-8?B?dVJxMXVYRjRHcmN2cXY3WkhISlBjY09FK1VidlBtQVlJMjBoc21aQy9uSExB?=
 =?utf-8?B?cWJTL24vTGo2NVE4ZGtlZUJkVEl4UVVOaHV1Z0xUdG5NYVd0d1UyUmVqYUV6?=
 =?utf-8?B?VVdyR0tucHZuNWV2MXhCdUxlalZFTG5reWE2VzJDbFVKemZmc0tzL3ZaN3py?=
 =?utf-8?B?bmd5K1VmL21GN2RkZzR0WTNlU1pvV0RaWHhWYm1XOUU2MnZmdzZFZVRwNGFr?=
 =?utf-8?B?Qi9SN0dPNGVVQWU5L3V1UmhRMzFuK3FsUXZjL3J5ZXFmQmdZTTh3KzBML1Bu?=
 =?utf-8?B?di9EWnZQd3ZZV0kzbjJRUDRhMTVKM2J6V2xpUU9SbEg3Z3orVGFDNnhJUUhr?=
 =?utf-8?B?SDBSVEJzclpWYmxpbHdRVjFhYUVTR3d2RklwaUlUY3B3cERyZjhFWjhIMTZ2?=
 =?utf-8?B?bkxyWVZXUXhYYW1hRk5HYzYrTHBNcmRsWU5lL2trM3dyWldYdE0yQXAxNXJt?=
 =?utf-8?B?d0d0WW9YOE1zU3ZVUGRsdmVtRUdKNmFBV2piUHNCVTdBVXNwZjRiOHMrQXE5?=
 =?utf-8?B?M3NnQzJjcjg1dkZublVyTVUzN2xZb1ZvaWNscm5vV1ZWdWQrdEJ0ZmpTS2Jv?=
 =?utf-8?B?TndQVDlCWHNYUTF4cHR2azNqT0lLcG8rUUJ2YTRaQTJoV1RwUDVNeExCWmtX?=
 =?utf-8?B?eDBEMjRnMEpQNHk2aXNzY2FzN29JTjJBUU9BbFNiZ0ttUXZ0Tys4dXhHNUQ1?=
 =?utf-8?B?SWJwWmgwRzVsTVJGUTFudmNPZDlPdDkzVlZxclhodlRFaW9Rb3lra2JnaTg1?=
 =?utf-8?Q?f5bFZgrJpBf6fFe9Z5UfumSYKjxnINc1mapT37BdWRVI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHUzbDI2ZU9MVlU1MGtrc1A1RzRyd1FLTWh4VlFMbTNCSTVXczRpb0NXWDRG?=
 =?utf-8?B?bXhFbnRUSWNNYWo0enVuby9YditYYStGdUtCcUt6TGs4d3dUQ3RtQ21wVGl2?=
 =?utf-8?B?eHpxb1BoWTRNa0YvSVkxN2FwZ1MwcG5WckU2ZzJ4WE1ueWNqRWhGcHdiZDI0?=
 =?utf-8?B?bnNQVDFpc0JvU1JGMWlQMEF6L1kvR0Y2OVd2M2d6cE0va1hxU1lyaFVrL1l6?=
 =?utf-8?B?RWdudmpoK0t1cUs4UDF2SUpJa1Z3SFZ1UU9PbjdHZmR6WGNFSC9nMkRsU25C?=
 =?utf-8?B?bG90THdpaDBuWFdCTGlGZk1GWkdpdkVMdkkrbHBkcjcvN1p6S2hKSDZpbzBY?=
 =?utf-8?B?WkU4SkdBbE5oSlBLK0pwSDRoTEtZVWVaVjh5WTJYa20wUU1HVStVb0xnOTBG?=
 =?utf-8?B?b2hFb3pqSUtCd3VodjFsSUl5eUFUcU03QXFuWHk5dk1jdVpUc3prV3RGOGNN?=
 =?utf-8?B?ajlzeUJjazlicXFMQndsbWFQYVlyTVpWVGVXNUlNZWRpQjF6bUVQR1NIdFNm?=
 =?utf-8?B?U1RwaGdQTnA3eUs0N3dmVE5ISzFaU2k2NlRKUUpRZHVxQkVCWGU5MVV1Sk9k?=
 =?utf-8?B?Q010REltVUF3KzZ0ZElLNjNyNDM1L2VDQ2F3NitjclNlR1NmUkp0Qk9UZXJ6?=
 =?utf-8?B?cjlZV0t6dG5tMnlEYzNTa0ZlWExtUmhKTkFLNWZLNjV3eXQ2OXZQdTBkMFI1?=
 =?utf-8?B?S0l6TnI3S2VLSE5MSFdyaWdjR2dEUXE4K0dDRGYvS2JqU0RzQkMwLzdub2ti?=
 =?utf-8?B?UmVEQkR4Z2NjcFA1eDhWVUJSaWtxSGZCRGYxWmVzWU02ZU1jbE42dG1Cam5i?=
 =?utf-8?B?cm5ma1RreUtsQmp1a3JmdndIbjhlY3JxTmUvcDVzNTFvaGVQRGw5M3pQM0ZF?=
 =?utf-8?B?UzhpQXF1bjZWR1ZWYllORjBDQTFlcVhRVUtwOHJNb1lpVERZZXJDNjVIOGFG?=
 =?utf-8?B?RFZFbDcrdS9XU1IzSnRNL0RjZDlCK0lRQlFhMFJJR1hySTBxSUdyQi84OGx5?=
 =?utf-8?B?N0JRdE5ta2tsbkg1bjVMWXd6M29oaE8vKzFjVkZVZCthb2FEKzd5MHJpaGJy?=
 =?utf-8?B?L051VytaNWxGNnIzZzZ3QW9mVzFINHRhYnZnTWcremNJeXAzQzJIR2pZSjEw?=
 =?utf-8?B?ZDF5clpNUlE0enN3TFBFeGxtTGpCbWROdGpmNzJoU3RKVHFQWGxFc01LNnB1?=
 =?utf-8?B?SFhlalk2M2NVQlh0YzhlSS9TN3RnblR3SzhseE9ueElzemNXdTQzN2FHTDhh?=
 =?utf-8?B?V0IvMzNuejk3aWZqTkl6VGhCYWtjbXY5a0ZNQzJZNXNha1d2azhlMitkYTl1?=
 =?utf-8?B?OFlQcUlnQ2FMNVJXcWdoYnlUUnBpeFNjcU4zL2c3MmxNQzdMQ2owZFdPamJs?=
 =?utf-8?B?U3ZxblNST2g3WnlTWDFvZVdnOElOSlZrTjR0VlFnZlpTY1g0UkVialFROHpV?=
 =?utf-8?B?N2s5Qm9BaHV3cmllSzZmYTc5QnhGYVpLWE9RUGFyelBwdktsU2hzcGU4ZUJC?=
 =?utf-8?B?NGdwTXNJTUROSUQvMG8zMTc0Z1BHQmpCeGFDRDg3YVpxVk1zMjZDYk0vUElt?=
 =?utf-8?B?eUVWQkN4L1h3c2kvL3NOOGUzWUE3MTRHRXk0MTJtSUEyckdYSzVhUUgrNHJV?=
 =?utf-8?B?MFl2anlqZVJYakFaN3JVNXZLVDVNMkFPbkYwY2k4UHM0UzdEZ3hJbUI0RlpM?=
 =?utf-8?B?VGM1RU1zSHplVDBmTVpiNklTTldCMTlRZ1M1VGhhaUN0ejl0WExQMzdlVlhk?=
 =?utf-8?B?Z0tNSXlWQkhMTFl2TWRXaEdPNHFmR1NjWkxsaXdqUEMzUUVhMXpxZm41NlNP?=
 =?utf-8?B?RXl0SytUdTErN1lYWm5zdWFQaVZaWWc0V3RuMW5VcVZpWWNHNWdxemZlbHNK?=
 =?utf-8?B?SEFlTzgvTFhGczVtcHQyWkR6MjFuOFRsY1FKQ0N1QklrZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-13ed7.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR07MB9708.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d7bd69-98a9-4111-82e3-08df081edd93
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 11:47:56.9329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7069

VGhhbmtzIGZvciB0aGUgcXVlc3Rpb24sIEFsZXhhbmRyZSwgYW5kIGZvciB0aGUgY2xhcmlmaWNh
dGlvbiwgRGFuaWxvLg0K77u/DQpJIGFncmVlIHRoYXQgdXNpemUgaXMgdGhlIG1vcmUgYXBwcm9w
cmlhdGUgdHlwZSBmb3IgYW4gaW5kZXgtb3JpZW50ZWQNClJ1c3QgQVBJLiBDYWxsZXJzIGFyZSBs
aWtlbHkgdG8gb2J0YWluIGluZGljZXMgZnJvbSByYW5nZXMsIGl0ZXJhdG9ycywgb3INCm90aGVy
IFJ1c3QgaW5kZXhpbmcgb3BlcmF0aW9ucywgd2hpY2ggbmF0dXJhbGx5IHVzZSB1c2l6ZS4NCu+7
vw0KVGhlIHVuc2lnbmVkIGludCBleHBlY3RlZCBieSBwY2lfaXJxX3ZlY3RvcigpIGlzIGFuIGlt
cGxlbWVudGF0aW9uIGRldGFpbA0Kb2YgdGhlIEMgaW50ZXJmYWNlLCBzbyB0aGUgbmVjZXNzYXJ5
IHZhbGlkYXRpb24gYW5kIGNvbnZlcnNpb24gc2hvdWxkDQpyZW1haW4gaW5zaWRlIHRoZSBSdXN0
IGFic3RyYWN0aW9uIHJhdGhlciB0aGFuIGJlaW5nIGV4cG9zZWQgdG8gY2FsbGVycy4NCu+7vw0K
SSB3aWxsIHRoZXJlZm9yZSBrZWVwIElycVZlY3RvclJlZ2lzdHJhdGlvbjo6aW5kZXgoKSBhY2Nl
cHRpbmcgdXNpemUgYW5kDQpoYW5kbGUgdGhlIEMgQVBJIGJvdW5kYXJ5IGludGVybmFsbHkuDQrv
u78NCkJlc3QgcmVnYXJkcywNClNvcGhvbg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQrlj5Hku7bkuro6IEFsZXhhbmRyZSBDb3VyYm90IDxhY291cmJvdEBudmlk
aWEuY29tPg0K5Y+R6YCB5pe26Ze0OiAyMDI25bm0OeaciDHml6UgMTg6NTgNCuaUtuS7tuS6ujog
U29waG9uIFpoYW5nIHZpYSBCNCBSZWxheQ0K5oqE6YCBOiBhaXF1Yml0c0Bob3RtYWlsLmNvbTsg
RGFuaWxvIEtydW1tcmljaDsgQmpvcm4gSGVsZ2FhczsgS3J6eXN6dG9mIFdpbGN6ecWEc2tpOyBN
aWd1ZWwgT2plZGE7IEJvcXVuIEZlbmc7IEdhcnkgR3VvOyBCasO2cm4gUm95IEJhcm9uOyBCZW5u
byBMb3NzaW47IEFuZHJlYXMgSGluZGJvcmc7IEFsaWNlIFJ5aGw7IFRyZXZvciBHcm9zczsgRGFu
aWVsIEFsbWVpZGE7IFRhbWlyIER1YmVyc3RlaW47IE9udXIgw5Z6a2FuOyBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOyBydXN0LWZvci1saW51eEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCuS4u+mimDogUmU6IFtQQVRDSCB2NF0gcnVzdDogcGNpOiByZWpl
Y3QgSVJRIHZlY3RvciBpbmRpY2VzIHRoYXQgZG8gbm90IGZpdCBpbiB1MzINCg0KT24gVHVlIFNl
cCAxLCAyMDI2IGF0IDI6MDkgQU0gSlNULCBTb3Bob24gWmhhbmcgdmlhIEI0IFJlbGF5IHdyb3Rl
Og0KPiBGcm9tOiBTb3Bob24gWmhhbmcgPGFpcXViaXRzQGhvdG1haWwuY29tPg0KPg0KPiBJcnFW
ZWN0b3JSZWdpc3RyYXRpb246OmluZGV4KCkgYWNjZXB0cyBhIHVzaXplLCBidXQgcGNpX2lycV92
ZWN0b3IoKQ0KPiB0YWtlcyBhbiB1bnNpZ25lZCBpbnQuIE9uIDY0LWJpdCBhcmNoaXRlY3R1cmVz
LCBjYXN0aW5nIGFuIGluZGV4IGxhcmdlcg0KPiB0aGFuIHUzMjo6TUFYIHdyYXBzIGl0IGJlZm9y
ZSB0aGUgUENJIGNvcmUgY2FuIHZhbGlkYXRlIGl0LiBJbg0KPiBwYXJ0aWN1bGFyLCB1MzI6Ok1B
WCArIDEgYmVjb21lcyB6ZXJvIGFuZCBjYW4gcmVzb2x2ZSB0byB0aGUgZmlyc3QNCj4gYWxsb2Nh
dGVkIHZlY3Rvci4NCj4NCj4gVXNlIGEgY2hlY2tlZCBjb252ZXJzaW9uIGFuZCByZXR1cm4gRUlO
VkFMIHdoZW4gdGhlIGluZGV4IGNhbm5vdCBiZQ0KPiByZXByZXNlbnRlZCBieSB0aGUgQyBBUEku
DQo+DQo+IEZpeGVzOiAyZmI3NzU1YjBhN2UgKCJydXN0OiBwY2k6IHJlc29sdmUgSVJRIGluIGlu
ZGV4KCkgYW5kIGVtYmVkIElycVJlcXVlc3QgaW4gSXJxVmVjdG9yIikNCj4gU2lnbmVkLW9mZi1i
eTogU29waG9uIFpoYW5nIDxhaXF1Yml0c0Bob3RtYWlsLmNvbT4NCj4gLS0tDQo+IFByZXZlbnQg
NjQtYml0IFJ1c3QgSVJRIHZlY3RvciBpbmRpY2VzIGZyb20gd3JhcHBpbmcgd2hlbiB0aGV5IGNy
b3NzIHRoZQ0KPiBQQ0kgQyBBUEkgYm91bmRhcnkuDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHY0Og0K
PiAtIERyb3AgdGhlIGV4cGxpY2l0IGxlbmd0aCBjaGVjayBpbiBmYXZvciBvZiBQQ0kgY29yZSBy
YW5nZSB2YWxpZGF0aW9uLg0KPiAtIFVzZSB0aGUgZXhpc3RpbmcgVHJ5RnJvbUludEVycm9yLXRv
LUVycm9yIGNvbnZlcnNpb24gZGlyZWN0bHkuDQo+IC0gS2VlcCBjb21taXQgdHJhaWxlcnMgYWRq
YWNlbnQgYW5kIG5hcnJvdyB0aGUgZGVzY3JpcHRpb24gdG8gdHJ1bmNhdGlvbi4NCj4gLSBMaW5r
IHRvIHYzOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjA4MzEtZml4LXBjaS1pcnEtdmVj
dG9yLWluZGV4LXRydW5jYXRpb24tdjMtMS1hMjEwMzA4NGQyMGVAaG90bWFpbC5jb20NCj4NCj4g
Q2hhbmdlcyBpbiB2MzoNCj4gLSBDaGVjayB0aGUgaW5kZXggYWdhaW5zdCB0aGUgYWxsb2NhdGVk
IHZlY3RvciBjb3VudCBiZWZvcmUgZW50ZXJpbmcgdGhlIEMgQVBJLg0KPiAtIEtlZXAgdGhlIGNo
ZWNrZWQgdXNpemUtdG8tdTMyIGNvbnZlcnNpb24gYW5kIGRvY3VtZW50IHRoZSBDLXNpZGUgd2Fy
bmluZy4NCj4gLSBMaW5rIHRvIHYyOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjA4MzEt
Zml4LXBjaS1pcnEtdmVjdG9yLWluZGV4LXRydW5jYXRpb24tdjItMS00MDMwZWE3NzQ2YTlAaG90
bWFpbC5jb20NCj4NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBObyBjb2RlIGNoYW5nZXMuDQo+IC0g
TGluayB0byB2MTogaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjYwODMxLWZpeC1wY2ktaXJx
LXZlY3Rvci1pbmRleC10cnVuY2F0aW9uLXYxLTEtZDYzMjE3ZDk5YjY3QGhvdG1haWwuY29tDQo+
DQo+IFRlc3Rpbmc6DQo+IC0gbWFrZSBydXN0Zm10Y2hlY2sNCj4gLSBOb3QgYnVpbGQtIG9yIGhh
cmR3YXJlLXRlc3RlZDsgYmluZGdlbiBpcyB1bmF2YWlsYWJsZSBpbiB0aGUgdGVzdCBlbnZpcm9u
bWVudC4NCj4gLS0tDQo+ICBydXN0L2tlcm5lbC9wY2kvaXJxLnJzIHwgNCArKystDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9ydXN0L2tlcm5lbC9wY2kvaXJxLnJzIGIvcnVzdC9rZXJuZWwvcGNpL2lycS5ycw0KPiBp
bmRleCA2NzQxMDQ2ZWMxYzAuLjIyZTJjZGY4MmEyMSAxMDA2NDQNCj4gLS0tIGEvcnVzdC9rZXJu
ZWwvcGNpL2lycS5ycw0KPiArKysgYi9ydXN0L2tlcm5lbC9wY2kvaXJxLnJzDQo+IEBAIC0xNTEs
OCArMTUxLDEwIEBAIHB1YiBmbiBpcnFfdHlwZSgmc2VsZikgLT4gSXJxVHlwZSB7DQo+ICAgICAg
Ly8vIFtgU2VsZjo6bGVuKClgXS4NCj4gICAgICAjW2lubGluZV0NCj4gICAgICBwdWIgZm4gaW5k
ZXgoJnNlbGYsIGluZGV4OiB1c2l6ZSkgLT4gUmVzdWx0PElycVZlY3RvcjwnXz4+IHsNCj4gKyAg
ICAgICAgbGV0IGluZGV4ID0gdTMyOjp0cnlfZnJvbShpbmRleCk/Ow0KPiArDQo+ICAgICAgICAg
IC8vIFNBRkVUWTogYHNlbGYuZGV2LmFzX3JhdygpYCBpcyBhIHZhbGlkIHBvaW50ZXIgdG8gYSBg
c3RydWN0IHBjaV9kZXZgLg0KPiAtICAgICAgICBsZXQgaXJxID0gdW5zYWZlIHsgYmluZGluZ3M6
OnBjaV9pcnFfdmVjdG9yKHNlbGYuZGV2LmFzX3JhdygpLCBpbmRleCBhcyB1MzIpIH07DQo+ICsg
ICAgICAgIGxldCBpcnEgPSB1bnNhZmUgeyBiaW5kaW5nczo6cGNpX2lycV92ZWN0b3Ioc2VsZi5k
ZXYuYXNfcmF3KCksIGluZGV4KSB9Ow0KPiAgICAgICAgICBpZiBpcnEgPCAwIHsNCj4gICAgICAg
ICAgICAgIHJldHVybiBFcnIoRXJyb3I6OmZyb21fZXJybm8oaXJxKSk7DQo+ICAgICAgICAgIH0N
Cg0KVGhhdCBtYWtlcyBtZSB3b25kZXIsIHNob3VsZG4ndCB3ZSBtYWtlIGBpbmRleGAgdGFrZSBh
IGB1MzJgIGRpcmVjdGx5Pw0KSWYgdGhhdCdzIHdoYXQgdGhlIEMgQVBJIGV4cGVjdHMsIGl0IGRv
ZXMgbWFrZSBzZW5zZSB0byBhbGlnbiB0byBpdA0KaW5zdGVhZCBvZiBmb3JjaW5nIHVzZXJzIHRv
IG1ha2UgYSBwb3RlbnRpYWwgdW5uZWVkZWQgY29udmVyc2lvbiBpZiB0aGV5DQphbHJlYWR5IGhh
dmUgYSB1MzIuDQo=
