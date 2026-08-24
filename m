Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77567369D56;
	Mon, 24 Aug 2026 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584927; cv=fail; b=kumMkgd13EPBIbFczpWCLGDJ820jK7Pe7BpPZBX9UWAtfVl6YRBfBEp25VoEJn/yugPz7nXK89E91OAmzrw9iJ6avBB+k7VDYEnOkMQUPT5rh70HedkFTNX2o9+7c50P/PIS8KuyJnVRDKfAwDpC5pPX1ISwp9EwP6gUkx5i/wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584927; c=relaxed/simple;
	bh=jqG7kzuj8D5wpttjNqhfmTcNuSeQbbSv1NFZrqCmXQw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=VuAVCK2j4Cf6Bxiim+95ZgAW5P7MECvYF8Taxfn2GL77Y1OuEEPaLfIPs7XufC8KwECAYDdKWSNYwx0BbeOB4Z87yIny/OCQ1guq7bALtoKFWwgbd3/tR1OXXRqZ9BrYQacXf96NnIvCiCFtF17+saGP7lMmx6A2eJeAe+2lCmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rzoa+L5s; arc=fail smtp.client-ip=52.101.85.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rzoa+L5s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkSbTSPPgcBDJl+6AB4kTeq8SrPioNHI69V9Ahwsqa0FHUAEkRZ93SR7vO3ARoLZCanzr2uTE/SfjHO1ob9/VQDrAXmmYXESc6e1XeK3QFPqP/5HRud07FX6uSs25m7hRz299nxxjL0AfDDNB00cjro1SX2wYlhp8UXWXbz+BrLKLNaEe6KioiWJfRBtTWJ+T7+P+WIH5v2tqrs7lM25MK0B5/z1Lo9HymTf3C0QmCcqSVTpSpGKPrBDc7/NUtSBXvB7cv2jwIi4Az9R+fkpZIvM6a3RdZ9yqOcg+y8mIgBDwiZgmeVx4vUGgxcTbU/q2N+kn281lVt+Zt25IjYeww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BicOl1PpfYfLBz2rvuWmOcZR+UVbtN7QSXZayW4kzQ=;
 b=IqVIVyFH0UZUdDRQF3kkhZThHImAsy03aQ3Y3t9rrldBbGlYnpmQuRiNR4hyLJ+olVKOjdzKhWdkozs8zkecruc8k6pEM337IiDIejh1jXZixcp924PXwvhpv6k62HwnBpgpc/YgWPgg5hY7792Rf52YsK/39z7z7jgBphJ5ZS0+A2lpWFtK1mC33V2JiwCXB2dgGkyUAKqcb7/s1ND4/Pq1Y4UDic7/ENChpLN0LMRRhzUEN2CjZMIyVJ6Wr7lARgPiKISXkvxShnX9eJpyOLtSAafgCFn44/0Puv6St8kKdr0a4Ipiyf28wceHPAVK5FH6tn0y8gg4KMQOURGVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BicOl1PpfYfLBz2rvuWmOcZR+UVbtN7QSXZayW4kzQ=;
 b=Rzoa+L5stOL+01wSEQkzWvSRp2DQQCt4Fg2ioRkkhZWMp1KjuzMiKUUHNg1kcEm234+xCAHcYKyaKP61cW0KsB1uy3AWdiT0cxG692UT6nRGbXdRD5uRf2ZJvGoXRNH4kz0cDyLrQWjgyoVE2MRGK8P8s6jH4IgaRxMG2OOMRdB9NZKEqqvURzVaR1hT5B/JUKJHULXUxdMRXvHW9ZrbaomiQ1WnTq6RE2paIqNpZnDZ1fJO2Ho4z0KixdL6wFX3bfvrrzpxrXnAeuwwVFxNP9XK5D9dPZgNL/0VhnhC4GiNpMpbg8k0kmH8sWut2obwjEM1HOnpxlis6dK7RKmCyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:21:59 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Mon, 24 Aug 2026
 15:21:59 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 00:21:55 +0900
Message-Id: <DKX9YTDJLJMI.1RKDZ3S28MVQ0@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260818084633.1673214-1-zhiw@nvidia.com>
 <20260818084633.1673214-2-zhiw@nvidia.com>
 <DKX0TRYM9KB1.HMIDNZDWMIJJ@nvidia.com>
 <DKX45Q1J5M9O.27TM3TUTQH761@garyguo.net>
 <DKX4P05VHT0E.2O8M39SOVBVP2@nvidia.com>
 <DKX5NPH3DNJR.2MADBU37NMZB4@garyguo.net>
In-Reply-To: <DKX5NPH3DNJR.2MADBU37NMZB4@garyguo.net>
X-ClientProxiedBy: TYCP286CA0120.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 253ff9c0-3df8-4d98-8f3c-08df01f370b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10070799003|10067099003|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EJG1v7UVXH2keIkBOXa5LrnlyT0bovizWDasn0mzZRYjP4aETI9mT5nOwGLqEiolZybKVtj3dFi89+qsKbO6Birk0aupQdeoSHKBjgyo5rum7fQNUWjrObcugsKFTA9OdLnB+m4+Ek+d6IVhGAUn3KahJhm2aBeKULHwFWh0lf1NwnerBabbBRoT9GeX3lXhOfsFDDi0woQb0uJcq/UDtrGD2ltyz0RixgPcYuq+saFtT9OmPjEUzDPAAbp3jCeQnpVO9/i1CXiggYJbp1ynuuqZ8rfYpEHR+O0sTZtODnR8IonUl6EXx+0XEzRqoVSjDE94f4FOjY4qyHUdMGpcmqgVtFtk7lsMgZNmDLYuqz7eAQkp4+8YoWzcG1GXsrr8KDIsGm/eW1/RMs+9lzGkSedCJCLVMTG0cVf9vyBtMUJ1oe4PDNi0gngtVnvoBUlKahqwVjt6YMPcBp1et+H2f3p+yJMvMho5OfD240X5NGj+9oYDgFgkZz+Ocp3NLBUCiJcHTdub1vyokQodY6PgiN67BjcGqcVFAQzQuwj0peBUo/eRRiA7ottq1m3lmZeHPFljiMGhwG5LpqXW78Ecg6PnsSZRU9MCcR8gv3dEd9xjIjKWmrq2Pk9zyCP8ug8tij1R/gqFZXJcE6eCDpf7wTVz6NovAWKG1ZemOqfUk68=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10070799003)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGJmUVBIT2R0aGRzZmx1U3k0Z1o2aGNGdXRqOGxRRG54aUdmUXc3QTBpZitk?=
 =?utf-8?B?eFJiT1lTZG1wTnRXNkhEc2xObFl1T2RXKzlGNWRGREZKclliK1JpVUpId0hk?=
 =?utf-8?B?WWF3VVRMdnhvTmtTS3RzUys3Rm42SjZ4YUZ1RE10TjdjWG9BZnBrMTVnMVA1?=
 =?utf-8?B?RkFaZEpCNjFSSEhQV2Q4QWFDcWVJeTJuZG1qV2JxajlBamlWK1plVXJ5SXN4?=
 =?utf-8?B?ZEx4bnJZWlJycmRhT05lcHFPTGRmTVl5VWxDcWxEQTNoWUhSdnhUWk1WVWpz?=
 =?utf-8?B?ckdkRjcwNm54Rk1OUElycVNrMEoyYmlGUnBHMzl2cUZYeGJIYmE0d015aXo1?=
 =?utf-8?B?M1FleTc4NWtFRkRKMWFWQk5kT0pMSXc1MWJLVHg0TDdQY0Z2bGkyUWF5MlVK?=
 =?utf-8?B?bHVPVHJMZDdHLzVYUmtMeXQzSks1L3d3QnVOckFUZ0ozSURwQVIxd1VwTkhh?=
 =?utf-8?B?T0tBNFNmV0dSRnRobTlJRWJBMVpFQmRmVFFrZzMvekZQc21SdkplVDU2eWtK?=
 =?utf-8?B?dzRuT0tGT3BYZ1lIRDR3TDJEVTBrdm5oVjZkQzgvcE5QbUViQnBCOVM0RnNW?=
 =?utf-8?B?L2hQZXhENDloOE5aa01qWjlSUDVVM2ticktXckRoRHRPSkFnSndPNi9OQXBI?=
 =?utf-8?B?bjEzV1hIUVlYRkxMVWl5eXhLYWNXclEyelNmNVVJS2hvZWdJWUZmVDRFa3E3?=
 =?utf-8?B?TmhwMjZrMWpIc0s5R0dSdXNYQ3hkNlJmaDNLMGMzRWphNEJRdTR4Qldha2pw?=
 =?utf-8?B?NXcwNnQ2L1U3ZGdjUlEyaEliMmVscHRCS1JubUIwZENRNVh1S0hqRC9tbFMz?=
 =?utf-8?B?WmoyTm1zdWpRdVFHU1BWOG1wWGI0eE1vZFJadnZDS1VyWjhOYmFXSFlRQWxm?=
 =?utf-8?B?OVdQN3llVW9kb1dzUVhIdlVXMXFuM3hINEt6dWhjVFkrQ3B4SG5rUndLZE1F?=
 =?utf-8?B?V1dCbkpGMDBRanBPMkxYNmpEMmwyM0JUMjRWdkQ0U1hLd3pFM2x3N2g3cE9w?=
 =?utf-8?B?Rk96UVFSVVB0UlpZK2gzZDdwUnF1eGh5M3dOYUlRU1ptaUs4U2Nzd2cxeWFW?=
 =?utf-8?B?NlUxYmJqOXpYZFY0emNHZk1yVlpHeGRuZmN3QS90TGYxUUsxNWdvZUE1cTBO?=
 =?utf-8?B?TWw2U1BFU3ZjdmpMVXJhTjVqaWV3dUlNRWYvK1BqVk9vTkRUMlpnYUFzbWNI?=
 =?utf-8?B?Z3dwaVlwQzJLN1FxMVFxZERxYTZoaC94L1EwTEd4RGpjNGhld2lKTjhyYU9X?=
 =?utf-8?B?WVlsdE5MTUhYdnh4VXcrVmEyRE10UVRTcVJDWTRwY09zbTRnSHEyNUJzTXpk?=
 =?utf-8?B?L0dNT21ZQ2JkSFdqaWFYZWRjOVNEb2pnYmpQOVpqTkhMOWhPSlg4WjZOWGRT?=
 =?utf-8?B?ZWpKSEwra00rdGlpSVdMU2NGdkdoejN3UC8xZlI5OVdSQ29CT2tVZUg0L1Zu?=
 =?utf-8?B?TnBCT3AvcWk5SDRPQWJnN0ZSTktCUDdoSmMvNlhWQ1kyWU05N3FyY3YxV0VD?=
 =?utf-8?B?U0t6cVBFcjZvdDZEWXhrb1hnUEoyeWhaOHB2c3pGUW1LeExoREdBZnBEK05K?=
 =?utf-8?B?VDk1OUMweThPN1RZME1nbVFSYkZaRENNKzNOc2ZTSXJVZzM5WDR2RytBVXNP?=
 =?utf-8?B?cTZMN3hPamUyM0pBajd5L2RZSU5waUxaQjJqODZIMEN0RGNZMVdTeFNmdEJu?=
 =?utf-8?B?N0JRWHhhZ1pKa2o5WWRWNVpPY0VEalVYeS9WUTQ0T3Y3TkZRY3RQcjBNckVz?=
 =?utf-8?B?MWJkN2RGUFNQTGVMT0cvUFJ3MjEwU0ZWdCs2aW13Mk5JRlJscThQV0N3Y0x1?=
 =?utf-8?B?VW1tbHdyb25HKzJLQzAvWklKenRzc3pLSHlNT3UzVDZYaTk0M0REcVdFNlRu?=
 =?utf-8?B?NjB0UnQ5Mkd4OEd4YTZtaGFLbFZTMGFvTDZDb0RWK2s0a1Yyb1ZUQloxVnRr?=
 =?utf-8?B?NTRoNkp1NTBGVEYwazRzaE1zZnQ4RE13V3BuaUIxeU5wZVBTNUF1NVBJSmpC?=
 =?utf-8?B?amUwV2RIc0psdTFYR1dPZzRSRWZ0Vjg5ME1nREJNbFFOVGJmbGtvMmQzMm1R?=
 =?utf-8?B?WWplMXlJOFozYkFOMUJ2RDhNamxpS2ZtY0ZMZ2NyV3JGNm5BSHVYdEYxamxI?=
 =?utf-8?B?OWFvMG92SGc2d1NZVjJUQzhOTGs5cU9GSFE0Q3FueEhVYjdGTnovMVpiTVNu?=
 =?utf-8?B?V2NqdHJvV2taVTlubnNYVTY0eFExT1hmcVB2eGMvVVBmYVdqK2FlNm1EOEo0?=
 =?utf-8?B?R0dZdFN1VVVsTXgzOUVQVXBjVURzQ2ZXVkpYczVtY29Sam1PRzQrMXp5T1NK?=
 =?utf-8?B?R3I0WXlXUDB2a0NCbVlOOFhIYlNQQlhCUEJUTm92cEVjRGI0cHZ3TEZUc1Rk?=
 =?utf-8?Q?I+CPhEQwlImuMrUQypmDdVIUpoa6wlZ6JT5/K2Bl9XBV1?=
X-MS-Exchange-AntiSpam-MessageData-1: Eh37cJZH5FRnVA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253ff9c0-3df8-4d98-8f3c-08df01f370b8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:21:59.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VN23IeJzNWahJwA7K5O6QR+NaBqGpZ6EmALaeVSIQkXIQZ8EV9w7ANhpars9mk5kN4MHWztKF0gWY2Gv4WfOQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186

On Mon Aug 24, 2026 at 8:59 PM JST, Gary Guo wrote:
> On Mon Aug 24, 2026 at 12:14 PM BST, Alexandre Courbot wrote:
>> On Mon Aug 24, 2026 at 7:48 PM JST, Gary Guo wrote:
>>> On Mon Aug 24, 2026 at 9:12 AM BST, Alexandre Courbot wrote:
>>>> On Tue Aug 18, 2026 at 5:46 PM JST, Zhi Wang wrote:
>>>>> Rust PCI drivers have no typed interface for locating and accessing P=
CIe
>>>>> extended capabilities.
>>>>>
>>>>> The SR-IOV extended capability describes VF topology and VF BARs. Exp=
ose
>>>>> this information through the Rust PCI abstraction so drivers can use =
the
>>>>> existing typed configuration-space accessors instead of raw bindings.
>>>>>
>>>>> Define ExtCapability to associate a capability ID with a register lay=
out,
>>>>> and add ConfigSpace::find_ext_capability() to locate and project that
>>>>> layout. Bound the view at the next capability or the end of extended
>>>>> configuration space. Add ExtSriovRegs and a decoded VF BAR iterator t=
hat
>>>>> reads and validates all six VF BAR register slots up front, yields de=
coded
>>>>> BAR addresses and widths in logical order, and keeps the raw
>>>>> configuration-space slot advancement internal. Since PCI_EXT_CAP_NEXT=
() is
>>>>> a function-like macro, expose it through a Rust helper.
>>>>>
>>>>> Link: https://lore.kernel.org/rust-for-linux/20260804161612.776752-1-=
zhiw@nvidia.com/
>>>>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>>>>> Cc: Gary Guo <gary@garyguo.net>
>>>>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>>>>> ---
>>>>>  rust/helpers/pci.c     |   5 +
>>>>>  rust/kernel/pci.rs     |   8 +
>>>>>  rust/kernel/pci/cap.rs | 329 +++++++++++++++++++++++++++++++++++++++=
++
>>>>>  3 files changed, 342 insertions(+)
>>>>>  create mode 100644 rust/kernel/pci/cap.rs
>>>>>
>>>>> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
>>>>> index 4ebf256dff23..b946b14d79e4 100644
>>>>> --- a/rust/helpers/pci.c
>>>>> +++ b/rust/helpers/pci.c
>>>>> @@ -24,6 +24,11 @@ __rust_helper bool rust_helper_dev_is_pci(const st=
ruct device *dev)
>>>>>  	return dev_is_pci(dev);
>>>>>  }
>>>>> =20
>>>>> +__rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
>>>>> +{
>>>>> +	return PCI_EXT_CAP_NEXT(header);
>>>>> +}
>>>>> +
>>>>>  #ifndef CONFIG_PCI_IOV
>>>>>  __rust_helper unsigned int
>>>>>  rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
>>>>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>>>>> index 9f19ccd5905c..008c2770a3f3 100644
>>>>> --- a/rust/kernel/pci.rs
>>>>> +++ b/rust/kernel/pci.rs
>>>>> @@ -32,10 +32,18 @@
>>>>>      },
>>>>>  };
>>>>> =20
>>>>> +mod cap;
>>>>>  mod id;
>>>>>  mod io;
>>>>>  mod irq;
>>>>> =20
>>>>> +pub use self::cap::{
>>>>> +    ExtCapId,
>>>>> +    ExtCapability,
>>>>> +    ExtSriovCapability,
>>>>> +    ExtSriovRegs,
>>>>> +    ExtSriovVfBar, //
>>>>> +};
>>>>>  pub use self::id::{
>>>>>      Class,
>>>>>      ClassMask,
>>>>> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
>>>>> new file mode 100644
>>>>> index 000000000000..ddb3fd73e195
>>>>> --- /dev/null
>>>>> +++ b/rust/kernel/pci/cap.rs
>>>>> @@ -0,0 +1,329 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +
>>>>> +//! PCI extended capability support.
>>>>> +
>>>>> +use super::{
>>>>> +    io::ConfigSpaceBackend,
>>>>> +    ConfigSpace,
>>>>> +    Extended, //
>>>>> +};
>>>>
>>>> Let's merge this block with the one below, i.e. using `crate::pci`?
>>>>
>>>>> +use crate::{
>>>>> +    bindings,
>>>>> +    io::{
>>>>> +        Io,
>>>>> +        IoBackend,
>>>>> +        Region, //
>>>>> +    },
>>>>> +    num::Bounded,
>>>>> +    prelude::*,
>>>>> +};
>>>>> +
>>>>> +/// Number of VF BAR register slots in an SR-IOV capability.
>>>>> +// CAST: `PCI_SRIOV_NUM_BARS` is the PCIe-specified number of VF BAR=
 register slots and fits in
>>>>> +// `usize`.
>>>>> +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
>>>>
>>>> The infallible casts module is now available in `master`. If you impor=
t
>>>> `crate::num::casts` you can now turn this into
>>>>
>>>>     const NUM_VF_BARS: usize =3D casts::u32_as_usize(bindings::PCI_SRI=
OV_NUM_BARS);
>>>>
>>>> and remove the `CAST` comment.
>>>>
>>>>> +
>>>>> +/// PCI extended capability IDs.
>>>>> +#[repr(transparent)]
>>>>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>>>>> +pub struct ExtCapId(u16);
>>>>> +
>>>>> +impl ExtCapId {
>>>>> +    /// Single Root I/O Virtualization.
>>>>> +    // CAST: PCI extended capability IDs are 16-bit values defined b=
y the PCIe specification.
>>>>> +    pub const SRIOV: Self =3D Self(bindings::PCI_EXT_CAP_ID_SRIOV as=
 u16);
>>>>
>>>> Same here, the `CAST` comment can be removed if you turn this line int=
o
>>>>
>>>>     pub const SRIOV: Self =3D Self(casts::u32_into_u16::<{ bindings::P=
CI_EXT_CAP_ID_SRIOV }>());
>>>
>>> This looks horrible. I'd prefer `as`.
>>
>> Looks are subjective (or so I like to tell myself), so let's focus on
>> what isn't.
>>
>> What is not subjective is that you don't lose a single bit as long as
>> you use these functions, and can do your conversions without a `CAST`
>> comment.
>
> Aesthetic and ergnomics is a big part of code, and is what make people li=
ke
> Rust. In a world where less code is produced by human, I think it's espec=
ially
> important that code remains easily human readable.
>
> You can probably already tell that I have very strong opinion about this.

So do I, and the fact we both have opinions on the matter is irrelevant.
"It looks horrible" is not an argument.

Safety and correctness are the very reason for using Rust, not that it
looks better or is more ergonomic. It often does, it sometimes doesn't
(see the hoops we have to jump through to cast a pointer for instance),
and when it does, that is usually to improve correctness, not to
compromise it. The reason we go through these lengths is to remove
issues and footguns at build-time, and this is exactly what these
helpers do because `as` is one of the footguns.

They are just a temporary band-aid and won't be there forever anyway:
once we have const `TryFrom`, we can make a bonfire with them, and I'll
be happy to light the match myself.

Meanwhile, we can very well make things more sightly through the use of
a macro. `casts::u32_into_u16!(...)` would definitely look better if we
overlook the exclamation mark.

>
>>
>> These helpers were merged precisely for this use-case; if you want to
>> remove them and use `as` instead, that's of course open but also a
>> larger discussion than this patch.
>
> I was under impression that the series just provides safe cast from lower=
 width
> integer to higher width ones (mostly for u32 -> usize and usize -> u64). =
If I
> see the above snippet, I'd nacked it.
>
> This is not what const generics is designed for and I rather view this as=
 abuse
> of language feature.

I cannot say I am versed enough to know what the deep intent of a
language feature is. But if you are suggesting that I used such a
feature in a way that goes beyond its original intent, then I can only
take it as the highest form of compliment around here.
