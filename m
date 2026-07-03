Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022138.outbound.protection.outlook.com [52.101.101.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6833F483F;
	Fri,  3 Jul 2026 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089892; cv=fail; b=ZRlUsSiVXxYMe5eI1+rWsdIDR6v1G4VPOvgvjd5P3asL1/VSV8dQe8rUrocXJnMWpMhiYitm2Rzv4L6VBRyaHsbDJBO1mBmnOZVANY4QyL5TJ4ttPYvobh0SOmmCJfeD6F2pN6bzFDsJ+dn0jPdWRUcFkZ7aFy03NARicSrE1dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089892; c=relaxed/simple;
	bh=amPji4+ztihT96ibU2wdyRLivjt2X+GwqZ0dn1EeiGA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=b4/nHkAs9rxx3myprXVr2lDskjMZXRfj3noT4V8ISuoleJQ376wCb10b1nuIN91FuykZhPCNGhwqv2MA3qIaA/+vmhuSFC/tdXl6xnpjOPAHZrZJCqoEt2wRZjfOCS+EST4Ks8OzNkpbI8hSGabRhD9paGaq8Mp30mxTeV1gyQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=eDrw3tqR; arc=fail smtp.client-ip=52.101.101.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="eDrw3tqR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwVsoOuaET2ev0RRJQ8qYFq2AZeRV4t+jtcOoFupBMrtn8+dOu6vQGSbYMRBrnAmp6riWRT9HVnfGd1zvNEyQbEG9/b5VL6gKkVqk7Sp4RleCsCdVoKPCKHSk02DssV6nk64UAU8ywnXshOUmRIsjTM53BZMS5AL1tOqgAn+ERMiq983+9KpbFmODTdiF2izfUrTZ/isJ/bfEsBi8w/shZzFkX3pFY2d0RipAPMtvaNBYCbUw3HE1F9IxpYszrdd5JN4FmfEtKJrRK/V1SgWTzAJT1w37AC1vworKztFnyGHhvuU/Yd28iBrcKoO0dKIYiqiO8fPU4P8EWY9j+N1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amPji4+ztihT96ibU2wdyRLivjt2X+GwqZ0dn1EeiGA=;
 b=yStyfQOsqQNZr66JbiFXIxGrare03bqrb7g+qt+UjxD3Ug7hZ1ixWhmVWf7DFPsUDg/4LDFGKbJkTfjLMHyoD9ye0rjQmvssLoz0BIPkxqdZIkUKWI4zKk1R/jaK0dPvClqRzZdQZpOsIOChtfZj2eo0ZruPIkviiq8YwXWT5xV8L7r3rJyVe95k64xF1z/98JOfIQOmoYyBuHlvxA5FLSxrVTQZ6XT+kcwXB3Gt1WbYasdRtgrWMM1dWBB5+UGfpe+hTt5KcVcaQz5mYa3ruzfk91E0e0addT5vlCQ6TLcYcL1RRRJvMA1myUEkZA/P6J5UTCuATvUOmaPDr77Jag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amPji4+ztihT96ibU2wdyRLivjt2X+GwqZ0dn1EeiGA=;
 b=eDrw3tqRl6PQG5BzD7UTiLIFAisuQ0l7/0RqqCHiMy8z7vUma27ii8dJE+mciIQ81Yrhvcnfb03V1OC1slWDk6m7qWj+un3yygOmjXaGPFwMQefTAh5JdCQY5+A3K0SarTeayQe6B1fcS0K9Y34wFtTgMUMRz2BrDfcMshpr8iI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB7426.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:217::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 14:44:44 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 14:44:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 15:44:43 +0100
Message-Id: <DJP0M002OONF.339KTDC0UHHVC@garyguo.net>
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
Subject: Re: [PATCH v5 15/20] rust: io: implement a view type for `Coherent`
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-15-d0961471ae50@garyguo.net>
 <DJOYP821KAZF.IZZ0ZOF10AG1@nvidia.com>
 <DJOZGKUDZ3GT.1FU4BOO0NII2E@garyguo.net>
 <DJP0HZL8L40B.31WVDKAEC4G38@nvidia.com>
In-Reply-To: <DJP0HZL8L40B.31WVDKAEC4G38@nvidia.com>
X-ClientProxiedBy: LO4P123CA0689.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fca7b3e-59bd-4356-b315-08ded9119ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|10070799003|376014|1800799024|366016|6133799003|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PlV7zjxmASEasflHRAKpanaANq9vEzHDlJm50Wb0hATq5i3yHekbRM7PHfh3zo83/uMGRtj+45kfUOHbIIm/T/A+9oetKG+LI3/P9nVDfXehU1Hg70v1nYOVdxS2n89gMq/qv0pfQXK9dAYiPimfkccM0teZJp8TxltqPcdunMC9D6jqpiTHFTuyanj8/jyLR1VZPbIR0VKtIsb42/Z7bm1g62l9Fb97AeHX+MKCND9fGgtb3yPcFbtO3MizGtDEyM48gUkAgvyhCQPDCec0uXNNbd9vRyMl8q88KPg8xR+ForGTyabr3YvmnMjptuXNJ1dg4rx2JgZnB0yL7v1AQb/taB761g/lqogqbPP5oHoA74LzufSpB5x0IKxJDtG7mF4GakKS/leVt0r81FpTqZX7oVH5x96MfrBtfoDFoPcuOMSrw0cVxPIgzHW5jKl+IkxmzOZic9TxFCSfwaTnjjuGEmvw2pP7t69ZY92Eshh62KOLNH/FJKVcePX7MjGebBzYAx5sSTIrG3Q+smsgGmJCJb7p/KPqPUR+Dl9TH65K5Lb5bjT7iflZfcx0acdMaTH3t+ISM7LPqWix93I9CCTW6euJePXbs1egPmkOgc74Skf9Zldi7f2+jMsFus179RG7bkpG7Y7Iit7u7DPDJeZ7IjnAe52VN2aS0+mmvxM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(10070799003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmN0NWdhZEhkcHpaWDFld2lvaHNPQ1JoZFphZU1qK3dVUi9NQ3FpV3NFM2R0?=
 =?utf-8?B?MFYyOXFFTGRXZk9sT0NTd1ZoWHZrdXc2UktPQTl1clVVTU5wOFBFeE9uVzBO?=
 =?utf-8?B?YVJTZCtnK3E4eGZ2VFhJOEs5RUxKUnZtc2dwQnM1RFdscW9KSzF0VkpPVlF3?=
 =?utf-8?B?MFZQdjJPbk90K0EvRGN4aTVUbzdWNW1VK01iK2s4VHNuVEVWZU9Za0hrcHBq?=
 =?utf-8?B?UkdtTis5djMwb1FXaHVnOW1UaVMwVFR0UlZ0T0t0a2pzdnUrdnltMmFMR2VX?=
 =?utf-8?B?eEZXQk1qMzdndHlOaUNFOTZrVFk2Vk1wTWFGYnFuWW1NRVZOQWJGTlhaU05x?=
 =?utf-8?B?SytEMTI0Q2ZaalYrVWtwTGxkOVpmcVU1WkdxR2NPRmNSNjRYM2xpckw4bWI2?=
 =?utf-8?B?akFWdHNkZTBDL05hVjVGU3Y1dUVQMnBVZ0IyMWVseWowNVIveHNEdjZSWVZU?=
 =?utf-8?B?QTlQMDcyQ21oQnVzTkNqZE5YWUgrMEFhdmpWMXVxYklrbjdDODdzR1dZZXVL?=
 =?utf-8?B?U3h0TlM0K2hUcUZ3ek1oMGpTdjBLVzBnTk9mOFowTWhlMCtDK0hIdzVYK1Y0?=
 =?utf-8?B?bjA3cVpjMVdZYjdTZ1E5c2RQZldNWnk2YmZJVXRLMCtaTk16Z0VpbDhPek9x?=
 =?utf-8?B?dHRNelFaSUw0Tm9TUXQxUU5ZZ0pVUmRLcER2V3JwMlhtV1NOK3IraDUwN1RW?=
 =?utf-8?B?elZyeXFJNFV1WXlJZ2RaMmZDWVFDTHNBdDhSZWlsOENYNVpyOGRxc2tCNjg4?=
 =?utf-8?B?Ym5Xa1dBa3drWDYvMTk4blFIUEZXYXdVY3NwcWdOTVZESjMyM3B6bzRzR3pL?=
 =?utf-8?B?VW1NSUgrMUtuSnFSS21SbGo2NEZWNHRGUEpqK2p3a3NuRU45aEc1Qm5wakJ1?=
 =?utf-8?B?Zk5IaVNmUTN2OXRNcTZIVWhlQkcwR2hKeDNieWhUSFM2bTdzRlJTTWc1TVcz?=
 =?utf-8?B?TG0xN09Vc1ZIZVBlTHVWc3RyeWlOUVdLK2tIWXZyRGhRVHFZS09TUEZUQmMv?=
 =?utf-8?B?KzVQbmRjSDFrNkhPbnVMN29uNzNnamovc3BBeWFrRmVaT3dWTHVTa2JQdkhH?=
 =?utf-8?B?MHFVbVJLRnVGRDY1RTZjMzVPbWVrTUtQWVBGN2tyZVduYkxOeEdVcDgvUFhk?=
 =?utf-8?B?TEF0eTMzZHR3NnlzejRHalJrZHUyR013enRjSkJWcGlOQzMwVCtmLzVFMWk1?=
 =?utf-8?B?eHBkbitqclB1bWs1bHhoZE83UFdXMWdWLzBlOXMzcXoyRHVSdlFkS0ZUcDZx?=
 =?utf-8?B?MktMS0czdHR6eXJzZnhHNGd6NmRiR3oxc0xlYnhKK3Z4MGFjSGEyY1NTbnd1?=
 =?utf-8?B?eGtSSkJmMTlQZmxCOFhDWkZWc2kzcnhsK1QvaWVHZzJUNTVJV00vaTgwQjE5?=
 =?utf-8?B?MEZYM3dVQ2ppbE0xQmMrWW9JMUlDTnhFZjJEall6RjlUTUlDN2hRWnpoNHRG?=
 =?utf-8?B?SlNHeEZGR2J3bkNNb04vTU9NTVZ4bGNZenIwMmxaNVNBemN2NytMUEtYdmFj?=
 =?utf-8?B?dzVVWWFIZ1duemdyZzNuZDlUS0M0M3BRM1o5aUlMNkoxWE9CT214U0FmRXoy?=
 =?utf-8?B?Vm40eU5Ic0RGLzIwMjRFT0kxdEwrZ2tDV0dVTWpPVjZsZzRhWjJiTytyNzZG?=
 =?utf-8?B?WVQ2T0t4aE5hL3M5TFRvL3hQeXFIWkFmL2lHaDZTUmJURnlSTUFLQmdGR2R6?=
 =?utf-8?B?akt0czZVYjNta09MdjZKaUNFTUxHRUZnUTBSaWZnUVdidStXUUpmWjJDM0Zo?=
 =?utf-8?B?OEtXVVJQVFZjd0ZobUcwM1BpUUdwNk5RbDFHc05JZ045UjRiRlNJank4YSt3?=
 =?utf-8?B?LzlhTzVEUnI3SENyNithMFpNZXRiMC9iREdPUFo3OU1TQmJhOS83ZjhjUktx?=
 =?utf-8?B?T2Nqdm8wemo1UmNZSFRYcnAxQ2VyTE1CbDdDWFhBMFJVQkFLOW85cUZ0L3Bz?=
 =?utf-8?B?OWsxbThGZ1ZQak9ZbEVOVmlWUjlWLy92dWszZG1QcUtkcGVHaTRwT0VZY1U0?=
 =?utf-8?B?c1daTEZVd2VMNlJFMUdyNHNBektyLzNBMGRPcFQxclJtbnJjejI3M0R5UHd5?=
 =?utf-8?B?SFJtVWZDRGduL3F4alIwOTc0MGs3WW0xWkhlazg4R1RVdGdyb3QrUUkwb1Zi?=
 =?utf-8?B?QWhFSU9Ud0NLVEVwY1ptdDVHQUZneExsNTloTWlKTk1va1pjbUtlV01xbmdh?=
 =?utf-8?B?NWlxQjNpdzVlMkN3d3ppQk5aNzZ5NlU0V3M2UElNOW83Z2ZGNkR3SFR4WmdZ?=
 =?utf-8?B?aWUvYUI5VUxaZHAvdkxHVFVyeGgxQWpyci9sN3NqSUpIcmpEaEN5eWhPSUho?=
 =?utf-8?B?eU0wVU5GVUpjR1VkUk1KU0xtMEw2YVVOZVB3bVhpVGxpN09lWVhQZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fca7b3e-59bd-4356-b315-08ded9119ef9
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:44:43.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFqK+KkZjYdohrfL3lbN/AUaeGaQC7DeepLqFAqkJHvGqnk/BkoCqSDjF6yEQ/cSUplVXVnvIhmbSHlMnIBDXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7426

On Fri Jul 3, 2026 at 3:39 PM BST, Alexandre Courbot wrote:
> On Fri Jul 3, 2026 at 10:50 PM JST, Gary Guo wrote:
>> On Fri Jul 3, 2026 at 2:14 PM BST, Alexandre Courbot wrote:
>>> On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
>>>> Implement a `CoherentView` type which is a view of `Coherent`. To be a=
ble
>>>> to give out DMA handles, the view type contains both CPU and DMA point=
ers,
>>>> and the projection method projects both at once.
>>>>
>>>> Delegate most of the `Io` implementation to `SysMemBackend`. Provide a
>>>> method to erase the DMA handle and give out a `SysMem` view, if the us=
er
>>>> does not need the `dma_handle`.
>>>>
>>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>>
>>> Of the Sashiko comments, the second one (adding exclusivity requirement
>>> to the safety comment) looks actionable; with that:
>>
>> Most of the text is taken from existing `as_mut` method on the full `Coh=
erent`.
>> I think these can be addressed, but I'd prefer to leave it to a further =
patch
>> (perhaps as a good first issue).
>
> For this an acceptable fix would be to add a sentence to the safety
> comment of `as_mut` saying that the caller is responsible for ensuring
> there is no concurrent access - I suspect you are talking about
> something different for a good first issue.

I was referring to the existing `Coherent::as_mut`.
https://rust.docs.kernel.org/next/kernel/dma/struct.Coherent.html#method.as=
_mut

Best,
Gary
