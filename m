Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71154279FA;
	Wed, 21 Jan 2026 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768978386; cv=fail; b=fumY56zT2INDz/yVC0aCtsneRWa6QoYxIXYxU4z301VNP74jNYGBUb0XTsiuWqTItsLGHhp22mbaWM3OaKEJaC+dNG8LWuKrR52+7+/Rfi3UA6qu6GEVJHvrEvS1wQVGS0v0L04PBHkKfKJahcgILcEAIW7mKYIr3oBqzVrQc3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768978386; c=relaxed/simple;
	bh=N/nM+8bYXyMQyH17zjgjFbYrMNMmZqof6tWASiq6WJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kJ+CoZE4IMGVur6qWvmZPPT2W/iIugYW8S59eIujglwu/b7MazAPOkLZ8N/K6RaJDX8yfntJ2VotKxNQ7GKr0JIYnLAawFPGrsgEFBcLAt7Opi77Po+cjsUyuRHxleiACge3VIdvkaKaqWesAU5dUiPlzV1UIphLqfDWqDYJbZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=P6pT3fsF; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="P6pT3fsF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIJQXnAcIkRJpLab2vbywRMg12oD9/9yX861RFB1Bia41xQjUbHzm1egT4vMSD6sdSSc6D7jZQsYru1MOs7/r2Oedos09yQa1WPd08HdwcoHxcR9DwdiCu9kH0tyKMsfnibvYqGo1hIoT1NV9+2MTCmQu2z0GapJzvBXuh4v+ZDVimUPJf2Sg05QX7TVBi3NSOA8WEIQfivG7+oA6qlw+uZG2kY6Jvq5vH4h9HP10SzrE1s+APatSQaC50fqT7YZtT9J15kAfcAWVggeI64HjdkKZtstvEX8lVnZH9z3Xxus9xc5ggANJ0Y2jggfS7jTeURGzulM08Z17lVIAFqm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/ZGd5GsZoiJ3hfoEDVEdYWwfLuuTPgLPcocTnWrDBI=;
 b=y8D1voNC+GCEkHj+H4O87ktE3yJjqT2us+QtTkzVIFkXv0jZ/aEl61HLfZuEQ9F3PmzKVQwkqUwXgq61tWvUIrd6G3tLFGLhVHyHWObQ0k1RONtJzrVMFbyzRosYA1nsui8uHOTE7GlymLYMaiyf5u7DQuM6H7WD5LCQP3xeGsu9cxwwnG26ggS4isyMhX8MVjGZSPsz3WjZb048v04VySDFa6LS9TNYBnCkIKf9l2XDYsMPrC9WFFfu6FyCX+7VQX1aZZ3CtVXySs7O+8NEWUZ0pX52Nkv5rAeIE6yKP5z5o/f71N6E6BjyMwXRf++l2i9N2ERqfuVcA0IevPJhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=garyguo.net smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/ZGd5GsZoiJ3hfoEDVEdYWwfLuuTPgLPcocTnWrDBI=;
 b=P6pT3fsFDsqecFSvuIc2+2ejdrsaw1tXZ1dDlG+RcBSeiMi3kW7DePkcC9OIt5nrElzEyHvUehlMll3mieNVeD03hN4liFZjZc78Vab84lMwh3LhBQINxmF9mgF+4GZd7krdxBbV3zOfr/okcuxBbMqMzc66uSu7xolddRqIIsplvm7YN86Df/yMWaoGmbrde++nSOUcB9sknTXCENZGX5jnqxxjpSeLgeO+fooIo0EEvuXeEkYjKJPKPJ9x4QZ6uhbaXflvqOuMmr7HXitvFXW7I2zIYJbS740XYNWdHCDWSc2OObgzCXdL0yvZgwvlnMNXFxpD+9kQylKO7IWK/g==
Received: from CWLP265CA0360.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::36)
 by PAWPR10MB7792.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:369::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Wed, 21 Jan
 2026 06:52:56 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:401:5a:cafe::db) by CWLP265CA0360.outlook.office365.com
 (2603:10a6:401:5a::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 06:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 06:52:56 +0000
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 21 Jan
 2026 07:52:56 +0100
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 21 Jan
 2026 07:52:55 +0100
Message-ID: <82535e68-dde7-46b9-836f-cc6f2f8e7a78@de.bosch.com>
Date: Wed, 21 Jan 2026 07:52:48 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/4] rust: samples: remove redundant `.as_ref()` for
 `dev_*` print
To: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Danilo Krummrich" <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, Daniel Almeida
	<daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, "Dave
 Ertman" <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, Igor Korotin <igor.korotin.linux@gmail.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260120181152.3640314-1-gary@kernel.org>
 <20260120181152.3640314-2-gary@kernel.org>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20260120181152.3640314-2-gary@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|PAWPR10MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c058863-d4d8-4ed2-a81f-08de58b9b50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|7053199007|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1hEUnc0S2E3WG90VndIU0FLQmlwbHNJRnIycmNJWWl4MGhuQjI2eXZhdUlT?=
 =?utf-8?B?eUpiKzhCN3JzWTM1UnZFOXhxSk11alRUQ2VQZzlGSFNmeHJGZCtMejQwSk9E?=
 =?utf-8?B?T0dFY0tjQlViMFo4NnR5MG1rWXNMWktFSnhlR2NFdU9HOXVEbHl2akxCOWIx?=
 =?utf-8?B?c2U2dnkwaElpSEpzTCtGM1JtcmtKejFQL2NaSWRFbk5uVFJHTXU1OHk2WW5x?=
 =?utf-8?B?K3hJK1JLMVF5VDRnNmdvZ09mcjVUQjc0S0ZVWkZpSmRZcmdFeTNvMk9iWlZG?=
 =?utf-8?B?aHV4ZDFValZpaWQvN09uS3FqbVlpSmxYQWJsU0QzOGlmcVhJdFplSnI3WENo?=
 =?utf-8?B?SjAyRGxqNFpJRVZvRkpaRnhSRGVyNUp0VTFzOXNMNnFsWnJsZkZqeisrdmI1?=
 =?utf-8?B?Qys5eWdmZk5kaVVwVUJrMWFGZnFhN25hVzFWZ25xUFdJRkRDRGNmK01tR3NS?=
 =?utf-8?B?Y0VybWVGTDZEVVJoT05FQ0tUSnVhWjAzMEZlR0oya3I2OFVTZ2JFZTFXNHVp?=
 =?utf-8?B?NG9UUWhZUWVZRmloUVFNMWI5UGE2TVI3UW1TK0lZUTNpYURYMXF5b29YdFVB?=
 =?utf-8?B?WW9rb1F3b21Wa1YzOXMwNEhjTDkxbFVlSm5LWGtRa2NQcnQ2TzRNSnppMVdG?=
 =?utf-8?B?K203ZWs0TEk2Z1pHcS9MdjFreDdqY281N1lRVjlYZGpGZE1zaGNwRkRxN2tt?=
 =?utf-8?B?Q0xIOGpoeWdSbExndXpTTzQxaTJJYUU3SmZRdVYwWVFHbWQ0Rk5icXNPWG5V?=
 =?utf-8?B?bndUOFlNdmlsNEtjTjVxWUZnanNtR2RnS0JoM1BaU0NabEh1QnBkSDdyaHBF?=
 =?utf-8?B?L1dnbDNBb21tN3ViNjRCYmQxcllhdGtZaTVaaThTOHphWlNuZ29ZbVJmSGFP?=
 =?utf-8?B?dloxTVlTRzFCMWRtaHlETEdJOTNqK2oxSGJnVG5tRldaY2NSdkVkWFQwMDlu?=
 =?utf-8?B?MUFoY1JNRXF2ZndWZ2lBS2xiV0hITUVFcHZvU2FBeUhVYnFDeHJUeGhrVEo2?=
 =?utf-8?B?OXZKRFR0aDg3SUhqK2JKaWdQVzhlb3c1SW9nKzZqN3JaMENTdmxvRzcxQXlh?=
 =?utf-8?B?clF4NjIzRUFHM3NrV3ozbTZoWnBURmNlM0NTWk1hWUJnVEJQbEI0aXV1K3NO?=
 =?utf-8?B?N3JXczJXSGJZMisrZGNVY2FRNE5UcnFHM0d3d2NQSHlrUHJxWnFWS0JabzlU?=
 =?utf-8?B?YlMxL3QyUHdhQ0dOaUdMb2xPeXluMHZsa2sxSVJZV0NzaE1QWTRQdjRacElR?=
 =?utf-8?B?dkVmZlFoWlVPTUYvMnZaZGh6amZLVjUwdzk0L0J6cjVvYk9IQmZWUHRmRnE1?=
 =?utf-8?B?ejJNaEZSVEt4QTQ0eHMzTE1yS29hdm94STFkVS81a09VNEszSkI4YzlFSlZQ?=
 =?utf-8?B?Q3BkelpXNTYyU1crVWVKRENOMThiS1QzN1hCUThYMDgzTk5sTWRXQlVEYVFn?=
 =?utf-8?B?NC9kVGY3M1IwVVlRMHFlQW1hU2pEejZjQ3BDRGovV1ZLRURFbW11MjY1ZlV6?=
 =?utf-8?B?ajlCak9INWhicVJxUVdneGcxOWthMWEybWNEelhOUUs3aHZGOXJ2YWtZY1cz?=
 =?utf-8?B?MzRqakFvNVZBMmFaNlh5aG1GbVFGY1ZkVTh4MHhHbUR3MGwvekdlWEZQcnRh?=
 =?utf-8?B?Y1IxekEyVHk4RnNlWERZS1RJd0w2eDdobzlXTEtKZ0ljODVaNUdlSVVFaUxT?=
 =?utf-8?B?ZmVQZzNGM05VM0tjdGU3eU1EN1EycTZyalNaVkIyR3NQR2krcXpqeEpwNnJC?=
 =?utf-8?B?c1RMaVlXbkJ3Yk5vVXVhSEZUOHBEWnFIY2pIMUthdHJIa1JmT0J3a2llaURk?=
 =?utf-8?B?K3YvSEM3TlU5UHZYVDF6MEVQRjBUMGtJNmJGclRBUXdEWTN2VVcyaDNZNW4x?=
 =?utf-8?B?a1dIQlJxcFpLbUF2aksrRFFhZFBkb1dBOHliT3VZZmUvMHhmdDAwMkozWC9q?=
 =?utf-8?B?Uk54TWhhbHBHdlE2cVREQTdtejZmZG5hcXRKck5FK3dPUG5aN05hZ0FkNXBB?=
 =?utf-8?B?VDF6QXJSV3dlNVRWTjFVUjhzSVdPL2ozNUF6RDVNa2RiK2M5eWIvRDJub2lu?=
 =?utf-8?B?QmZpZ2FrNlJoQjQvM3pPSkFZUlRVNjg1d1FZMU5Id1UzaXhmWUwyeDB3OXlz?=
 =?utf-8?B?S200dEZ3SnE2NGxmaVVaR0ZFZk9GWGI3Y2RJMGVqT0JEMWJNODJqY0prVWw2?=
 =?utf-8?B?NUwrY2dCNFRPbFBoQTVLL2dFU0Vpa1M1SStEb1BEaUYzR2lFa05PMHpCamtD?=
 =?utf-8?Q?m+d5S3xpBBH3A6w53Qc2uvHlfBuQZ8xFpWCAqGVgEU=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(7053199007)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 06:52:56.2094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c058863-d4d8-4ed2-a81f-08de58b9b50c
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7792

Hi Gary

On 20/01/2026 19:11, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> This is now handled by the macro itself.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>   samples/rust/rust_dma.rs              |  2 +-
>   samples/rust/rust_driver_auxiliary.rs |  2 +-
>   samples/rust/rust_driver_faux.rs      |  2 +-
>   samples/rust/rust_driver_i2c.rs       |  4 ++--
>   samples/rust/rust_driver_pci.rs       |  6 +++---
>   samples/rust/rust_driver_platform.rs  |  2 +-
>   samples/rust/rust_i2c_client.rs       | 10 ++--------
>   7 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index f53bce2a73e3..a9ac7937ebaf 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -57,7 +57,7 @@ impl pci::Driver for DmaSampleDriver {
>   
>       fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
>           pin_init::pin_init_scope(move || {
> -            dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
> +            dev_info!(pdev, "Probe DMA test driver.\n");
>   
>               let mask = DmaMask::new::<64>();
>   
> diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
> index f148124fe81f..c20961f16835 100644
> --- a/samples/rust/rust_driver_auxiliary.rs
> +++ b/samples/rust/rust_driver_auxiliary.rs
> @@ -39,7 +39,7 @@ impl auxiliary::Driver for AuxiliaryDriver {
>   
>       fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
>           dev_info!(
> -            adev.as_ref(),
> +            adev,
>               "Probing auxiliary driver for auxiliary device with id={}\n",
>               adev.id()
>           );
> diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_faux.rs
> index 5330b77ea986..99876c8e3743 100644
> --- a/samples/rust/rust_driver_faux.rs
> +++ b/samples/rust/rust_driver_faux.rs
> @@ -26,7 +26,7 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
>   
>           let reg = faux::Registration::new(c"rust-faux-sample-device", None)?;
>   
> -        dev_info!(reg.as_ref(), "Hello from faux device!\n");
> +        dev_info!(reg, "Hello from faux device!\n");
>   
>           Ok(Self { _reg: reg })
>       }
> diff --git a/samples/rust/rust_driver_i2c.rs b/samples/rust/rust_driver_i2c.rs
> index 6be79f9e9fb5..e71b77196163 100644
> --- a/samples/rust/rust_driver_i2c.rs
> +++ b/samples/rust/rust_driver_i2c.rs
> @@ -56,11 +56,11 @@ fn probe(
>       }
>   
>       fn shutdown(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
> -        dev_info!(idev.as_ref(), "Shutdown Rust I2C driver sample.\n");
> +        dev_info!(idev, "Shutdown Rust I2C driver sample.\n");
>       }
>   
>       fn unbind(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
> -        dev_info!(idev.as_ref(), "Unbind Rust I2C driver sample.\n");
> +        dev_info!(idev, "Unbind Rust I2C driver sample.\n");
>       }
>   }
>   
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
> index ef04c6401e6a..d50828b642e5 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -75,7 +75,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
>           pin_init::pin_init_scope(move || {
>               let vendor = pdev.vendor_id();
>               dev_dbg!(
> -                pdev.as_ref(),
> +                pdev,
>                   "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
>                   vendor,
>                   pdev.device_id()
> @@ -91,7 +91,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
>                       let bar = bar.access(pdev.as_ref())?;
>   
>                       dev_info!(
> -                        pdev.as_ref(),
> +                        pdev,
>                           "pci-testdev data-match count: {}\n",
>                           Self::testdev(info, bar)?
>                       );
> @@ -112,7 +112,7 @@ fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>) {
>   #[pinned_drop]
>   impl PinnedDrop for SampleDriver {
>       fn drop(self: Pin<&mut Self>) {
> -        dev_dbg!(self.pdev.as_ref(), "Remove Rust PCI driver sample.\n");
> +        dev_dbg!(self.pdev, "Remove Rust PCI driver sample.\n");
>       }
>   }
>   
> diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> index 9537dc38c563..f2229d176fb9 100644
> --- a/samples/rust/rust_driver_platform.rs
> +++ b/samples/rust/rust_driver_platform.rs
> @@ -180,7 +180,7 @@ fn properties_parse(dev: &device::Device) -> Result {
>   
>   impl Drop for SampleDriver {
>       fn drop(&mut self) {
> -        dev_dbg!(self.pdev.as_ref(), "Remove Rust Platform driver sample.\n");
> +        dev_dbg!(self.pdev, "Remove Rust Platform driver sample.\n");
>       }
>   }
>   
> diff --git a/samples/rust/rust_i2c_client.rs b/samples/rust/rust_i2c_client.rs
> index 8d2c12e535b0..72da5499f150 100644
> --- a/samples/rust/rust_i2c_client.rs
> +++ b/samples/rust/rust_i2c_client.rs
> @@ -113,10 +113,7 @@ fn probe(
>           pdev: &platform::Device<device::Core>,
>           _info: Option<&Self::IdInfo>,
>       ) -> impl PinInit<Self, Error> {
> -        dev_info!(
> -            pdev.as_ref(),
> -            "Probe Rust I2C Client registration sample.\n"
> -        );
> +        dev_info!(pdev, "Probe Rust I2C Client registration sample.\n");
>   
>           kernel::try_pin_init!( Self {
>               parent_dev: pdev.into(),
> @@ -130,10 +127,7 @@ fn probe(
>       }
>   
>       fn unbind(pdev: &platform::Device<device::Core>, _this: Pin<&Self>) {
> -        dev_info!(
> -            pdev.as_ref(),
> -            "Unbind Rust I2C Client registration sample.\n"
> -        );
> +        dev_info!(pdev, "Unbind Rust I2C Client registration sample.\n");
>       }
>   }


At least in samples/rust we have several places where we added helper 
variables for `dev`. For example in rust_driver_platform.rs [1] we have

let dev = pdev.as_ref();
dev_dbg!(dev, "Probe Rust Platform driver sample.\n");

Do we want to keep this?

I think there are places where this `dev` helper variable is used for 
printing, only. And there are places, like in the `probe()` of 
rust_driver_platform.rs, where the `dev` helper is additionally used 
elsewhere:

... Self::properties_parse(dev)?;

Hmm, I'm somehow under the impression what to use when in the end 
becomes slightly confusing in sum?

Best regards

Dirk

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/rust/rust_driver_platform.rs#n106

