Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B66313B7AE;
	Mon,  6 Jul 2026 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783299757; cv=fail; b=CSKXP4Yw1+PqqraUIkKA+b7o9EKyvIRUyX0IiGr3qXQCXH21hM0XRnc/OClLy7oliK83OL0YNHy6Gv2StIpYnKZvpq9pGPniD53rqza3s4QlporgW3gighgn59yDNL6YcCNzv+5q/DjaIFWlAly7BQ6ddsnU3IyN2qokJ0v5ft8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783299757; c=relaxed/simple;
	bh=HHDwR2nyxZ4rcVLGVAO/afZ+vZY6+3KGUqaSdSw8Rh8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=hzdR/quunFzD4wbzAcyTsic2R0iennRtkG4W7ie3eb+NzhKLJTuvG3MpisNJdWKl6v+5oZzcZ1wAxS4DtcHhiiEJ+QPVzcnsHEWiVXnmdZyvsttR4xq+W64/nFqp3xagOZL3JPGdPI50oL11nOENppHtbE0bxnCJe1YpafRejc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ttFvF73F; arc=fail smtp.client-ip=52.101.46.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ttFvF73F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCTd1jNB0VkDePaytJHagQIWG6Y8IBPYPg7GqkR7JaXbmqtX6XNdUTKGGtGW/6nhE/g/vGehUuJXjAHMxPeUEYG12X6JIx3p2C2kqujes//jDxHY14R9IhTmlNX3HopGiF8Ww7bSdlfDLbab/lD7Ivx4iR5oT9XiFmiOKuzP8U57eb39A8ICYArKHsBgQyjIxRLOyJ2YYx99wbGDpdoJMc86IIdE01VgmTmwoJIedbrBQA3T5VMv4fXb7k1TWfMXsY8bpDFpdC22opmjSZkSC6pX6fj7zbnOvVebmWS26+iap5b7rDAa9goYj3tUQrb0Yij+CaBIT9MXKSQW1jJLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHDwR2nyxZ4rcVLGVAO/afZ+vZY6+3KGUqaSdSw8Rh8=;
 b=p9t8XQwWB8d1k/5LeaZ6intUuhldoAZ5OV0Ztxbs+PqGpOMxrrt5wPNEQXFR4d2sLzbqtU4sCP4QNFwMYhet21+DxayLp/vkSpmB1Zn/JQkZ0+MEUA7mOTIMvtYaa6vWrUr6eMmgCPmC2ELyQQW+qB2HArc8fNrpy5zgBU9yysvbzJDJtkwgXvf+HM7zoRPB0rgHBgrZfJnVPkc7DptaUBcil09aLkDmlGu9ClLuq5kgdZgTaYhVY9PxGSIMCswnq9WmPxD+HN6Uio2V4hBi4OQnTnq82zGdeVLgQfbAbIJ1a1IPuPsYktJmSaCZ2fdpNN+Bw80rzqQZGa88cPxejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHDwR2nyxZ4rcVLGVAO/afZ+vZY6+3KGUqaSdSw8Rh8=;
 b=ttFvF73FjPZmd7R048a6cWfZRaNgd2wuaa+CqpE02hNkNN3d8UNenGE6GQXWHQeGLxbaYbVXMeYuwmjKGO6/WJagaxrDU1xp3tPrrHCG7XrsU84CJvGpfuhGgdnmxqyLPJBR69DTF1YOs8sK26kdo3wAZ2qmvXgNzjL3ulSsm2wrVpXkQTgotJnBfGPGww+AAD14JAZQ+MBw7H+0W2NftBYc1Z92VmpVys32GBOPEqxHkUv8c+BlwKBGCiLbg3wVqtFqErpjLLeMiDHAwmxAmahKNPoaynx68ZvSCXW8Zz+4oh9vp9UP4AY5WZkCC1W8/YuINvT0CYKOV6ASE4M96A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 01:02:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 01:02:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 10:02:27 +0900
Message-Id: <DJR3027LIR8A.1DEP2QGUASM2W@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 20/20] rust: io: implement `IoSysMap`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-20-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-20-d0961471ae50@garyguo.net>
X-ClientProxiedBy: TY6P301CA0012.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: c71249c6-a2f3-485b-9d53-08dedafa4225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/gcDTHFJiyVlBHk6BCmbljrk7Om0n4ig6JiiP+6zAv/2WXOyhdlv3XawAPPGwroIJXEycGErzWOo0324kVU4TMbTZGCU353zRZHZusLQiz5A4ru8XbFBtyJgVt1rbjpxkwyidUx++MeYhaRigM9jnoKQfCJuxknGXZ5R7cD2QQBnCE6XYYho7cGHJb4ckK5luoFc/pwmJb2TRcXoNRtGgC7E8FrTTVdvI7h2Ehn4WjYNlhi+RKXBvP5UYiJvDmkclGzh9hRW35g3v79AHx8oWw4sLHqbEljnAz3euZUveTVQTOsLtd2IMmFQ2RTz8esURAP0X5BOZxe6v64lzA4NwwvUgJLKMmksFFs1wAWswso7qKxDiJaQfvEwH5yM4IIfklRhfxiFlb0YkfG4xbEHoVn6Lahxf8/PjQnK9efkeItlKr/a0F2gze9+6NhFVEasJm1EAov+g5s1xBdbPia2ahMsTnmGv3mUQFSJE2Lar17ZMyAOfoddmIbUnrJpg7ORvb6oFluLjHlONzFlmJJldUFW3Jg7gUiaGAvGrH9NVGGvCdmQjkj93oEnssUCyrn8gMs2gMBbWy1Va4wAOunTtmI2FeemsvcCz95tnQnz1aHh7gIvo01bLEGjQ95Al1J3Y3JkLsr556npGzYBQT4BhWJtz2VQ2ZLz9gV4/I17ffM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0I0MEc1dU9Wd2hab0o4bk5SMlFCbG1BUzRqMUg1cDAyL3ppVlZGSTIwclpO?=
 =?utf-8?B?UUMyUTkrYUMwSzNYeTJOcjhmNTk5QUpHd1BLZVF1UVljY1lvR25WQm9xL2l4?=
 =?utf-8?B?UnhSbE4veEhvQytJdUx4R3A3R2dtbmJ0YjY3aUJuWU5qYUgxSXdkcXpYY0Q4?=
 =?utf-8?B?c0FTUXBSaWlVQ1NDODRCSXFueC9IaTBmb2xzMjExVm8wMGVpUlRYaXZNdlpK?=
 =?utf-8?B?TVp3ckFadjZITmVOOXRXRmJtOEhCc1NZTmJEcFB0L0VFSFUwNjdFbWNVN0JC?=
 =?utf-8?B?UkZxejR0b2h5QmI3OE1yQXlOS0owNFN2dWNMR1NtdkxwTDNnekY5NFkwWEN1?=
 =?utf-8?B?NW5WM0RoRjFGY01kaU9jdktVR3RHZ1hrOFQ4T3ROakJkWnY4RUxpdFh4ZEsw?=
 =?utf-8?B?Vms0ZTlVcTdYUHh0alptOW5wZ3VJN1RjSWloQ2JMN1M0bWhpUnFFN3J2ekhj?=
 =?utf-8?B?eXhRdkpBcVZIbDNST0F0NEd1dW5qeS9GZ3Zia2VvUmJPUmphWTA0UzEzMnBx?=
 =?utf-8?B?TUFMRHpuN3duNWxpR2h5N0tTdklLSTZBSm0wMmk5UERJWVQrdEhrbUw4bmhv?=
 =?utf-8?B?R2NKUHYzTUJEYm5iL3Y1RkVVK1VpR3ZBckZCWng2TmtTQmFva2FRQlU3WTNj?=
 =?utf-8?B?TE91d0x2RDVuVGhpV0VMS1RzdTJRR3hIVTgvakpmSnlFSmFnV3dUU3pQVEMz?=
 =?utf-8?B?c2MwaEdUemIrWlhDU1JvbVVPdjB1T2lHTENsNG5lSnhUOXU5eXZCRWhYRjBN?=
 =?utf-8?B?MnZsVUM0cXMvSkd1R2RmYWpqbEdOc2h2WjRTVDVjdkp4NTB2aXBDTXgyZUJ2?=
 =?utf-8?B?S1ZVQW00UTBpdTBaUHFoU0l4Z0diL25PZitmZVowaWgxYWgrZ204bGFMeGNN?=
 =?utf-8?B?bW1aV2k2WkJFQ3lFTDM4Y3NiaE1xQXVVRHpXcGhxQ3NjSHh1ZzArZXRpVHY3?=
 =?utf-8?B?SkpVZTBRb1RVdUJyZmt3am8vWTZSMlpVVTZ5QkZlN2JUNVNXN3FwejY3aEVh?=
 =?utf-8?B?MHQ0cXJ4dnVVUkJYYXk3SFAzRXBmMmtSdzhyRnVTdXFaOGh2YTVveDcrejlj?=
 =?utf-8?B?T1VoQklNNmFJZWZCdzZRWWpuUDl0ZE1mTG03cG9mTmNBYi9DMUdhSlRwdUhy?=
 =?utf-8?B?ajVLUXN6clVvNDZ0K3dkY3ptdzBuZlpwb0dqMkdLaW5EbU5rNnEwd0Y4QVhU?=
 =?utf-8?B?elZYbHJVcVFOemZDRGorRU04djA5cUJOL0JpNGYxdDJBM3djTGJCQjhMR1dN?=
 =?utf-8?B?UGxOUllhQ1A0NWh1ZWh3T0R3WUFkVnJVang4T2kyRDZ6K3dqSUs1OGdJOFBE?=
 =?utf-8?B?U2JDMWNBUkRxclhid2NSaDF3Skh3ZmxjRlRzbU9WNzBYa05tWkFUaWljNVUx?=
 =?utf-8?B?OFZzL2xnS2E2c0lsby9VMFc4QmF0VzhJTEV4RFJKUjlxaFFMOTFvQmZpQmVI?=
 =?utf-8?B?eEEvaFVSZmNXQ3JpbFo2c1pwRkJyQ3RyZEUxU0RLQ2krRUNSaTQ1cUR3K1Fn?=
 =?utf-8?B?cGNkT3h2M0J0aDloMzhuUGhvdjNZTVJNSVQ0K1VpZUFZSmtnbzBuS3pIUy9y?=
 =?utf-8?B?TFQzcEcrSVJhSTk3WjZqNC9RWWFsUHk0Tld1ZmpLZjdrdXdYeUNwMVhPRm9n?=
 =?utf-8?B?K290cm5KOENEMWYvNUdsT3drQm1nTE5NT20rMUxzZFU1R1RMYzNycUIwTmFW?=
 =?utf-8?B?cFBzSTJBOU5UTzdqT3dsU2c4aDdZLzI3K1RKL3NtSVVGN2t0MWk5UG9KUyts?=
 =?utf-8?B?N1RnV3FSRHpYcFpjMXRKSUtmRXk0Z05hWTZGVUYyellyL2ExSEJWbDVmZG8z?=
 =?utf-8?B?M0FmdW5XNGgvQUpPSWpyL21IdEdaTTUzZnc2MkNDd2ROTEdHRGZmQVRERHJ0?=
 =?utf-8?B?aG5nZVBBN2lHOHYzNUdRSHNtWG50L3doT2FGUmJTNCtINEw0LzVoOFo4L2NV?=
 =?utf-8?B?Uld1TnJ1RWZtamUrQzlWMU5iVyt4NTltY0hGNG9Ib3J6NnBrd05qcHdGbHZw?=
 =?utf-8?B?ZmlVN21HdnlCU2R6YzNjOHhub1l1Q0RDZ0REMytBWWNDS2FGNk9vejhuTFZJ?=
 =?utf-8?B?YWxueEVpNkdKcGlJazJaQVlmT2loZmhVK2t0TVcxbWxFRUxZWnpaRlh2bnhH?=
 =?utf-8?B?RnhLZitlMDRaQVlVdWlHUHlaaTQyNWdaSUxrNStMZnllN05MMy9mTC9IMHlj?=
 =?utf-8?B?WTVUTDZnWllLcFFvSmltTDdQQWY2R1E3QzZ3NlFnekhHZTBFZHhhcGtwMnYv?=
 =?utf-8?B?M1NoK3RBSC8wcXRjRzNjWlMyNDdnMHRUZStwY0ZqTmdJRVhsVHVTQzhBS1p4?=
 =?utf-8?B?d0VDNjRvTEhDZ1NaUUJSQXh2cENrRXlBSFdBNElYRU9oRThuNTZ6Q1pNZ0pW?=
 =?utf-8?Q?9JIpk7ZpxFHf2riqgdAyVcittMEOFxXJxKl5fLDWHiZrK?=
X-MS-Exchange-AntiSpam-MessageData-1: umGzy2RrFz6j2Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71249c6-a2f3-485b-9d53-08dedafa4225
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 01:02:32.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilNCXGMhXryJXIlFq0++JTUb5hvvc03rLaw0nTjazKpjAsaayLY+5456FLMilhO5EmIrdIHi5tkyNGayQL/WGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> Add an enum as sum type for `Mmio` and `SysMem`. This serves similar
> purpose of `iosys_map`. Thanks to Rust's type system, all of projection a=
nd
> struct read/write can be handled by the generic I/O projection mechanism
> (i.e. `io_project!`, `io_read!, `io_write!`) for free, and there is no ne=
ed
> to provide things like `iosys_map_rd_field` or `iosys_map_wr_field`. An
> enum type also makes it very easy to construct or destruct.
>
> This could be made more generic by implementing on a general purpose sum
> type like `Either`; however this is kept specific unless a need arises th=
at
> warrants this to be generic over other I/O backends.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
