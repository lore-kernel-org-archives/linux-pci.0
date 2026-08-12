Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6A439F191;
	Wed, 12 Aug 2026 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567495; cv=fail; b=pS2pvlCifGlZZY5lQY1BQFFJRsihiwMsvyNbMAM3wFxB0eiAZ3o3F1GNbnSjDolp0HWy393Ucc011Ym+Xhoi/tMrtujkBSMI23rfEI9Zz0ICNZ3z65CEiK67Pms7t7rt9ZOER8I8JAm5cR1u6jmbdOyMZVkpZ4v2Vw9at6VsuuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567495; c=relaxed/simple;
	bh=csH25mOOIlk5Iri4pA/b1fV/z95gpbLX89STP2qV3dE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l+XBKdwjrLhO7SD8a665ZOLPo10xQ2O1KtSjIHM9yr0ki5m99jXpNgC96HjetQUPjRXuUc49W/RKw1lfl9ORLbgd8xvnpp2N2UlYSyFqjm+PS3H1PXp6TGxUkiAhf5Xod1AHqovJcCORdqWGdVHKaVsi1Fww6O5Bz4/UuFK5Z3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aHliJiY4; arc=fail smtp.client-ip=40.93.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aHliJiY4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnMo8PnYIAsfbhZHEPNlXgVfT1TiQsZHRGXgi/IlgkKq2RMMvzyia7oUTMV4pvzmBFXjR6vljiHDxlisRZ358ZFXuXQ9FYXQMXaqd6XF7k994xB7RRmmZ7oqXFVE4DjdvijhCXmoPyy1bwDjA2ALM8lCu3I7Cxgikvp//6oCG5c4niPvNl8w41YQxHMPGPXbweTGHMHJjmT3m4ZUoPwfYbwskCDqKI9jw9DQxw2mPeBkZ2GgkHu82c3+0H0CeP5wygtYIpBkMDgrDjOE4VsspR8RdK0XEgh3XJOehMGXj+7H0whPiJN7sMcX9rdPNi/bxOotVn8Iu7OWFqUX1EU1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzKFaOHACCB3mYf9jkXGdJpB3GCdn/BqovK7cQJqFN0=;
 b=DWEn4EL7hZMpYtgc0X5NZzKvk3ywYq3kEzdpyGVZpq+B3i31XGLDCSVWwkgc4+7LvtjupTv4qQqvM0UjckXowR/J5NBB2NmVFI77zUu/O2KZLW/lsWcA/22f33R5Cl4GHB/h4O1F9P2BuAQ0YKj8UYOqMVoqtFeswTxA26w4mAcsT6gJLHAzpStDKuPJm+fR1ArqBHr9f4qYljSZAEz45B57l4TE+U8TODSQCUycF3tV3D9eMzGEcvhUHl1ngArfq8sKXjWexMJDQDvmGale4BZW+DpZ4OZkfv7nLMjnCEPCBro2fom5KYBEZNj4CKq3NZoYWB7+uA1/DKq/FpgS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzKFaOHACCB3mYf9jkXGdJpB3GCdn/BqovK7cQJqFN0=;
 b=aHliJiY4DUKyGX+PBjiE3V6I50agQRydgNG1K14QkqNTcpxKpt7j/ryoP8oGSkD9GYmT3isKAuZFuMZ0LWOYLJI4k1iVmwBK+0pT8W6jnm2ZfBHCCVN06B4AnICwhppZV4nQ/S57q84gi8svOxSyDSb4L+ZFWu9BdHxfiKViVFIb2RMtu78iKva9Kic6e/uecW/B8SH/y4/WltCDMIXqGK+08/DQpLp7VfKZBD3PPJaiK81Wpn69MmOPfpJvzbMqvgrwxM8mG+ybF+P1mLE9afeaE5Rfo8dd7Lw5sIMs8hieP61s71YmyaW2Wmby5kGgugnKcCQZXAKKXtl11R5iMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 20:44:49 +0000
Received: from LV3PR12MB9412.namprd12.prod.outlook.com
 ([fe80::c319:33b5:293:6ec4]) by LV3PR12MB9412.namprd12.prod.outlook.com
 ([fe80::c319:33b5:293:6ec4%4]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 20:44:49 +0000
Message-ID: <280ce62b-fe17-4f70-b438-987417a28208@nvidia.com>
Date: Wed, 12 Aug 2026 13:44:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
To: Alexandre Courbot <acourbot@nvidia.com>, Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-12-c3ca142220a0@garyguo.net>
 <DKN1QEH1HWD1.1ZV0LWLNCZJTH@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DKN1QEH1HWD1.1ZV0LWLNCZJTH@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:a03:338::12) To LV3PR12MB9412.namprd12.prod.outlook.com
 (2603:10b6:408:211::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9412:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6e6f31-f8de-423d-7b86-08def8b28d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|11063799006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	hD6i6pAIc7TkMEZzX8/jlnqqO/diC6W+9mCofBraaKYP/HjRWbDQwe+0Hdv0ODbpIrPKTLfKqp9l6ol/U3X2S2DDIlsQYiGUIrwpcPve1jnO8/GOXYcH/0JaGYZdD5GWlGDJNOp4NHzbjGN4NGYEKuMPpEsDJONxN1+NXa8vCGV7W4mvoTWA0K5/kNkxEOFMQYr6sj9d+EU7xfTjciZ6Re5Ub1E9LlU/V1w3hAQHzTxQVifppp41RbWXavNCwnwPmhB5xHOol4/zLbXs95tGLewanl4ck8pAnBqVGmYWPi72P82aiu0oWmY0ndMNDkPQtS9r7b+jrRwTyv5rmC6iJDnY0ylXAbxzv1U6v//ePuj5wdaCHgEAAtlL+YP182SWEXr2/CTW/T7qHIS/tQzZhJexuWFNA2I+mHi8OAyKaIRcEWpxu3FZoqn3pvCXeucIsCTaVc4p/YCFHCpRF4NEZ9rPyuxwJiOTSXb6vu8GF5qmn4IWZHHFGvYmRvTOZwjr/WLLTdfuRhBwNTbanxfYlUd2f2FhdtGXd6EmOgLE3nIa19gLJFi6F9cGYawyfOqQKaD7LpkwOo7NsRyWNMjeUcrNiYYCpv5G1ZAh8QYe37flkFfgkeYnOPJDloEfZcWSFdtm8QMp93hi0gyNRzO3KWscMKOsNkIsMq9m6jUH7tg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9412.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clQ3ME05NEF5K0dEenlxRmI2OWpWMW9ERUE4TjlPck55OVNPRlFMYTA2SW5j?=
 =?utf-8?B?dWZsTmFORW9CbXBQaFFNUlFPOW5ub01zclhQak5OZ2Jldm42aCtYMlhrenJ5?=
 =?utf-8?B?bXIrMVNQek45Wm12SWlSbFFwY3VwemdHRGpaNHpWWWV3dXExdWhicm1XYzZz?=
 =?utf-8?B?SGJpQzBSSzdEalI2bVlnRFlZMzNabEpUVnVnWjFxM05GQU5BTC9jRE12RUlm?=
 =?utf-8?B?ZHVzTmxNaGRHbXloTEpQMDA3MlNqRFVBNG9zMTg3WGM3Uzl2RStvYkM2UGZU?=
 =?utf-8?B?U0N5Y1dKd2NBZVl6dnJJSmhmclhSajlBQjRaN21iVjZLS2FacUpCd28vU3RP?=
 =?utf-8?B?aWJEa0JkaFpiQkJYWm52VWtSNXZRaVBwa2drVkU4ZmRMME1FM1N0dzhFSWdK?=
 =?utf-8?B?eFRTL0UxQjNUcC84T1ZGaGJPKy9YWDN6SFNmdjd6cmhWVE85akkyZnZ4WUt2?=
 =?utf-8?B?d3lheiszVlJRTmdVdEtOTnpSdFliY1Q1M054YnFHYWwyL0QwVE12R2ZEVS9M?=
 =?utf-8?B?K1hDNDBxaDBhc3lkWmkveW01SXo5MndWY0FzM1V1U1ZoZkVqU1A5L3c5MSsx?=
 =?utf-8?B?WVZrY0hsR2FsaFozZm5Wb1FZVGVKby9DazRhT2V4VG93UmR2TUxlUGhLVHFH?=
 =?utf-8?B?YmdDVGszSE96WmJSYkg0VzJReEhEd2lyMXdDY2c3UEcxdVlzUHhVc2hkdjFC?=
 =?utf-8?B?ejVqWjZSMS84eXZZbDFMLy9BN0JSSGNCWkU4Z0ZLYWIzdkJxZEQrbzBMa2l5?=
 =?utf-8?B?OTdwRmJrRjJ3aThLcW5kTnlPcnpVVks0aVF1bWZabzhJVFJJOFp1TzlTRFZZ?=
 =?utf-8?B?djltbnIxMUZKZWo1S3lJTU9PRWlmWGJuSXJuZTkzOVg2bGFwZUtBQlNMZ3Nq?=
 =?utf-8?B?UGRxR2dLK1lFRzdzdms3QjMvUmFQWFhhbU9LbWJ2MlUxbVBjQUxMU0o4cnUx?=
 =?utf-8?B?ZnN2MGpjVUQ3cEFPL2ppeFdQTDFWaWNYV2VEM05vSlcvd0wyRnJlKzZadmQw?=
 =?utf-8?B?NDNITDhWR05jeHRzYXg2Y3JXMi8rY1hpM3ZIbEsxaDNjOW1mRlNGTVExL2Ix?=
 =?utf-8?B?Mmpya1YyTksvQkpEc282ZUNvSmxxSE9xdVRjZmpudTVIVU9IZHFUTlNKdjVs?=
 =?utf-8?B?S0Q0VXZzL1pSbXd0VGhzdTdkVGdPRlBkVVRaSXpDSU5HeFBTNDVUelh4ck5w?=
 =?utf-8?B?aVJZR05ZZnFKMnc4NW0xUW8vRkNpUHM4ME5HU0VXQTZVK2p4VEM4b0xFSUtj?=
 =?utf-8?B?eVZuSlBqbnVoWFlyM0orUWRjemxRVnpZWFdYZjlNYXdWS0VHN04wZGd3OXVu?=
 =?utf-8?B?LzdpV1UycEplTTVzekgrNWxyMzJTMXkrZmwxdDlHcVZxVlMvTzcxeXBlZkVr?=
 =?utf-8?B?YXNkRGx2a1FEdkI5RVFhNWd4ZFhBRHpvUnhTakFwaXRKMExjSVFFOHIrakdX?=
 =?utf-8?B?azNvTjJraXJtZmhPVG1zQi9FeExPaDZOeUowTk8ralhMWm8vZDF1T0lVa2hO?=
 =?utf-8?B?Z2xXTWJSQXVSK1piUHloRUhJdWhSbzloajc0ZzVqOUtEWUtqTmFIM29nSWdv?=
 =?utf-8?B?WU5SbEdYb0Z0TmtGTS9CQ1BrVFpVSTlrbUd0WWtENUZHV0k1RFI1RmtXR1ZL?=
 =?utf-8?B?cy94WmpMSklGaG9iMTc5UUxFc29ucWVZNi81aFVJM3NIZldWbkF5NW80QXBu?=
 =?utf-8?B?ZEtoVjlKVU0zblpsUUF5SklpYW45OXpSVythcWtvR0gybkxIRXM0SHVrTWhl?=
 =?utf-8?B?cUl5cVZvcmNKcjRyajQxbll2NFEyckw0V1ppMEhVWTl4YnFHUmd6RGd6UHRt?=
 =?utf-8?B?bmx6UGljYU9MWHNMRjFiZUZCL28yVG54UWNDbmx5dThLMXE5dExlb21YdGc3?=
 =?utf-8?B?cExoS0F5THQvUXNyRFVVbWxBYzFNaWNyOGtXeTd5bjlidXlHa3kxYmlIcS9o?=
 =?utf-8?B?dGtTZGxpNkRYQlAzQVk0UGhRM2JWdnBjYTBsZmxQT1BrQ0xZVXpxZHZ4OVJF?=
 =?utf-8?B?bTBmeVNkQXBGcC9OaEdCQVZ3a3dyb3VQNUtsUVVXTlFOT0ovbkZ0aVpjUEpq?=
 =?utf-8?B?UUdINW1oZ1Y1Y2pROUpDNzh5cC9WUGNabDJnT0pLekQ4M2V3amtBMVNaTEx3?=
 =?utf-8?B?dGRaMnVMYkZuYXR5WDVjMmZwVEcwM0o4VW0zcDBSMXErbnd1ai9FSXpkMFhX?=
 =?utf-8?B?aU45NUZ5TUc2SUlVQzd1ZnpkWjV0bU4rV2hIbVVublA2OElzOWtxa2RmQmVR?=
 =?utf-8?B?bHdqNG52L21iMy9jWkR2dWlVak90Z2F4YzlSeTJXOGV1RDRTbzdwTjd6UzZ6?=
 =?utf-8?B?NXJxTHoxMy9idmEwajYwejc2Q3JEdVJYWWQyTWJTMkFBY25RdkVwQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6e6f31-f8de-423d-7b86-08def8b28d19
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:44:49.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hy72bOfsYP7Dmmee3MP4rs2n3j/Vv5IlHnrtd1iXexibiZFlscZA54KUvnsFKc6y2776jIsR5/5Oz+lKgbhVbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830

On 8/12/26 7:48 AM, Alexandre Courbot wrote:
> On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
...
>>       /// Resets DMA-related registers.
>>       pub(crate) fn dma_reset(&self) {
>> -        self.bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
>> +        self.pfalcon.update(regs::NV_PFALCON_FBIF_CTL, |v| {
>>               v.with_allow_phys_no_ctx(true)
>>           });
>>   
>> -        self.bar.write(
>> -            WithBase::of::<E>(),
>> -            regs::NV_PFALCON_FALCON_DMACTL::zeroed(),
>> -        );
>> +        self.pfalcon
>> +            .write_reg(regs::NV_PFALCON_FALCON_DMACTL::zeroed());
> 
> Remembering the debates we had over how to address relative registers
> when we ported registers to the new I/O scheme, I guess this new syntax
> which should make everyone happy! :)
> 

What a huge improvement in readability! Yes, very happy
with this.

the "::of::" and the bare "<E>" were always something that
I had to look up. Now they're gone, wooohoo!

thanks,
-- 
John Hubbard

