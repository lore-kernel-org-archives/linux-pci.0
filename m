Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EEC2505AA;
	Wed, 22 Apr 2026 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837696; cv=fail; b=NMjrepi030VX3EW1L/9bqjatVgoPqx89ZGosvaODbM4DkNILbxo+XtO+mrqEh1BcUqe/D5iyi+nv6rdDqdjFF2IHUTq6CB6U4qAmtd9m2yIErR8s8XkTrKZqdMLgueV7uW4L8/RyVsgO9M6Z1k9m9lv1eCmD4+d3pAIoC54MJNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837696; c=relaxed/simple;
	bh=o78YrVNq12n2sdXyz2lrH0fO6Ov2V/eaxVEJGEdEhyQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=VDuGmipTlFJ+SBIfNI/xGoHMVojjc1FEonTsoGQFW7aCBHtzrld5IecxtQxn9dymq78+06ai9wNtFGIWFru+qRRAPqL4Y5AOxqisZx+TPRr/0Ky509PoZVkiU6j4l1/yUXRr8TCKIfN7TN/72V/fPHWY9NtRaJQ4hAHlUVyP+iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X9mm7mqv; arc=fail smtp.client-ip=40.93.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X9mm7mqv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bV0FvVIARNT9zkvm0X2Zfv6pGjH9Hic70oBNl6a98G9Sx5UmzC8QPdUXUStuuv91t6QYuPJex/q0HyWzfDFAUenHPLiXAOlDayfFrkZu6x8LHsnPgf0yHeZnjcmn8KPCjdNAJnNkR1/b7brNPFwpIne33q5pPK4uAbG79OIRfKEn60oItkJADNdt9DUddE5KanFQUfB6ojU5mQpO6NvV06ZBjYL2k5GEGISOgHesyZ/J4yOrSp/XfC2rWyRg9cH2zO8J7TUOdSXqfGXu4wkX8gvakN9rUTIMeV+w2syhp0t657YRIJfxr/gwnh8vlXgzE+UDP0/ajwKebGfyHM1Lvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8PJZBvzIQB5fmT8SJT1BSG/TgjTM6uErsrY+GygjEE=;
 b=bTHBOjt25g7XVF9g4n1Th2KeusrKtgp2byWNYCLgTnIKDKOsgOXq0cc4w/QG0zSuZWun/8nTaeoAeIZYJv4H2yPWmFIQLg3qYaoWne8guTWq8Wcvb/62rOabSDathRDphADv8s51Es/BuSTxXQEDdQhcQaUsBMW/H+DHP+lqpXtrBYsiVSsQFOSCRWbIaMFAXT+NwN6bYSzFvTEzKHptVqRGM8RrNeoRhfZnHWnNlC+W9pePxuJI02AJ/W7D1SH6CLAkdQr6vEKRXJXHJIT+iJ9RzYRWrj+uaNMPrmWyROHnXo21pc/5yEUBvl462v937pO2vGlibDyNXgR1PHPtqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8PJZBvzIQB5fmT8SJT1BSG/TgjTM6uErsrY+GygjEE=;
 b=X9mm7mqv1Io2QUJX3Secj221ytq8rDDuq0aR0+6TIiQxw28QNt+NpiBfMJo959c2UfFKlMG6MSTwW2TF2SD0vUYMc0jSBYI8n4U+PUjE6HpzkWGu6iWvaqRT7Eg0a98L/Leg8Qt3MuTrFmtPNCjeGMxqSxIYzFvtW4Aq83io7sCW6zJS8z53tQJvXEhVHXiGzvmVlbpC71T9XcDkAWTHKkoZ20o9uCv9/qsLrajTduLfw+h9VA/pFxKuDZSOGxc+LXw+PCWKp/A5yYF6glRhum80fE5C9rlrzGOj1aUMPU39fR0I4J3sWByzVezBnYXWUEO8kMJHikiNyYqJnaRwqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Wed, 22 Apr
 2026 06:01:26 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 06:01:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 15:01:22 +0900
Message-Id: <DHZGE2KGUBJB.3LDRIKUMDMSRN@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Boqun Feng" <boqun@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
 <20260421-nova-unload-v2-5-2fe54963af8b@nvidia.com>
In-Reply-To: <20260421-nova-unload-v2-5-2fe54963af8b@nvidia.com>
X-ClientProxiedBy: TY4P286CA0136.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e2027c-e740-409a-b96d-08dea03496c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|56012099003|18002099003|921020|22082099003;
X-Microsoft-Antispam-Message-Info:
	NeJQ419T566Zk9+Gdae+N54j2fgsuSzFhSSBoRrTfrxjN2J4w4BTYVWSuU8ZHho4aExuXkZcn4JY/Jg161dB+gtxLEMSHmdtpTHosUMsZEQpDmKTpjMrLidukzWQ/t1e2dL8XAp/kWp7/1GLtVIuBjlisFAn6vptTsAp5eAznw/fJiTt0pT2RGTmy3WgFBD7Uk2/txuXR/qxVqj8W/E64cXwq/UqgJxMaa7TnTDPrcHtn+QHCKjXOhTWQQb6d2kiMmiN2BsBAMGXr8Tdw21kp8A+k11+m3F+hkd2jXZRkNlJGMaSSshEc35wBojORdXeKZ7p8cRRWpq/29cORfUX5Tr9Ew2TrSq76Vq/mTw5+5J6p10RqCGPTYXUs9P4LKFHbRQy6os1IM/d6biAgJJQKGn2Pftg+0n1YbvYORuBnGjdy9SUs/QWuRm4Y8qUVz59oZKY5rQkc9jpWBjT8FLeEawMi7U9mIG8zog5qm2ZG0Pz/+Pxhy6uEVd1EiYTJrnkPRr55pOmU0a2mO2Cf8AsJedNPrhjimSXRDxm/Aug4WyCK6PNH3onQ8W9efm6c+PH5tCnDNnZYTWAyueFynzcBj/l4dfYkip1UaGNMJg4wq5cZNCZ64tHFaOy13PpUGE/o14lz+OcyZuRoHbIZ8LbUIXItdW6bZc2/EI/iCYTJNO65qjNX2Ub73glbGQWGjzzIxsY7FVE2KpVUZLWPl00cxPUfa47RqOnnn9v3vvyB8wHfZh6YL71rVWvM4dvZQDtEbItL5djiYPFXIvQ0MdQ4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(56012099003)(18002099003)(921020)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2VGekIzYU9MVUhUdmI2WGtSQkdDQ0RNWlRHSFZJOWU1QmJhcitXYUhZTmNE?=
 =?utf-8?B?NU0ySjBINTBwU25KNXJBNUdwN2RRZ1pQZGVta0ZsNHJKd1M3N1Fmc1M2VmVW?=
 =?utf-8?B?VktTcWh5bkZoc1pEYnoxR2Q5d0FXcnZOR0JETkNOeGRvcldDM3o4S2hZUnVn?=
 =?utf-8?B?dFdnRnErSmc1cnF2VHArenNYQjhMZ2VLNS9KNGs0REF6YXJKbEc0KysrYi9J?=
 =?utf-8?B?VkNJdUxjVFBrS2toR29KTlNrQzVrb3hzOHM0WHJQSWQzRTI0WFR4SjdoTHg1?=
 =?utf-8?B?UTRtMjlibmJXNmxuYTZrKzNOdVdSRkw2K3AxbXhsZTRCbzZ3bGFLYllHWkdC?=
 =?utf-8?B?VEhMcXp1dGVSa3JDalNObWtnbU53bnNvOXV1YWRDcEdEcjV4TnVNR0RqTUFK?=
 =?utf-8?B?bmZaaU9tNkJqV0hWbHRtdVhBRFRDcnJVZE9uYzB5bDhlU1U4TWxXc25OMWEv?=
 =?utf-8?B?ay9CL2FrK1BjdkthZGNxVUVyR2VjR3RDZmhyNGF6bzZsbjdtamQydFFCblIr?=
 =?utf-8?B?a1Nqck9hMHVpckgrWVE4SnJURjBsQ3pLRzlyakxNaHZ5anVBampYQVRoZlpm?=
 =?utf-8?B?azEwc0N6OUkxVHJQakZSbjc1SGRIcmZOOUt2cW1MMnduZHhGSUpDK2VaZFFh?=
 =?utf-8?B?MG1kbjcwVVNuMDNEQVcwc0JFNnhxZ2lDUUtBdUkyZkZkZURWc0wrRitqM2tL?=
 =?utf-8?B?RHllRlY3SW8xbXFaUkFRZmVEbnlydUFGeDFxWWx1VTNqbDFWSFhROXl4UmlK?=
 =?utf-8?B?MUZsMEpWTXYzTTVJYXdIcCsrUi84ZXdBRkljUGVMeG1tNU83MmhMdEZZTis1?=
 =?utf-8?B?UEE3R1NUYzJGTHZLS3Y2TUNoaEIrNkVOdGFuNWlvWXZhNEtUdEhOSnFxc0dP?=
 =?utf-8?B?bURsZ3d0QW82d0x5YkNyV3BPQW8rVDhFRC9MalBDRGNTeXF1aUtTTndXdEJW?=
 =?utf-8?B?UXRkN1FVMzU5UzhvWnVxK3NEZnAwbTRTb2tzcVJ0V1ZGYTZYVVR2bHBiWDh6?=
 =?utf-8?B?QlI4RkZvcmtuSy9KLzhJVlhFeHg5eFFWOGZqQUM1c0NvOFpaTjlMSG9NSjVm?=
 =?utf-8?B?MC9FWWJDZG9JMnpvckJJbEszaEV4VjFncW8zQTJEWW5wUGJIMzU1TWRwaGhM?=
 =?utf-8?B?dGhGV2R6YWV6bHIvNkF1QklQdG1nMmh6MjZzTW4wbTdYODBob3BTNzROTVd1?=
 =?utf-8?B?UlZMWjJ5VmZJYkZMMkpLK1duZEN3ZHpBRlBrdlV3b25wdnFDdWZJcEJSTmk5?=
 =?utf-8?B?bGkvdkRLdVVWWWJtVlNsN0V5S0cwYWt1K1pXUlBwUzF4Y2JPRzVNVjUvQldu?=
 =?utf-8?B?ZEpiQmdRdldQRE0zTHpCcmJDaE83TTdLS05mUlZRdnBGVGt2cWRqZFJRV05O?=
 =?utf-8?B?TitrUkZHVHYyUXNhbUg0WThqNklJZ1FuQm84Zjk2TWJqUUFJeEtXWUVYb1l4?=
 =?utf-8?B?RHZnNmEydjB1V3k3bC8vSG1qaS9HZ0J3QjZob0UvRVduRkRuMHVmSlJxUGR6?=
 =?utf-8?B?UGgzc0xreHVGVDdSbFdzS21kcHBnOEcrNks2SnpHNjlHd20xajUrbnpSMmFh?=
 =?utf-8?B?WElPNHpTbXVxNlYrWmxuNXhkdkdFZ1JITGRibnlUbmxCaVkxb0toWEJjbEx5?=
 =?utf-8?B?ZHl6SHJVWm4rdmdCNEJJTU93U1Q2K3I5VDlaWTdCOTdPU091d1JzZFdINVJR?=
 =?utf-8?B?Y05KS1plU2R5Zk5CVE9iSVZNQmdlRHk5V1dwQWR2V2VLWmFNamlFbERFNVFE?=
 =?utf-8?B?SWcwdVNTUjQ5cERIa0JHNFRPSjBvU1dvZjlpL1ZLTi9FNzBaT1BCNmtDaENq?=
 =?utf-8?B?enpEL051UTJKUjFqaUNlcE9jZ21XTUFoSkFFOTB1bXpNZk1HWmE1Rm1aWU9V?=
 =?utf-8?B?YnJ1eUNTRGgyM1kyTXpxcU5ncFVkV0dBVU8xR1B6OWZ0Y3hJQSszUFdidVh3?=
 =?utf-8?B?eXRHeVpCUy96SDYzYkt6b2VTcXBNbjRJa094c29uek9HUjV0eEpNbHNWYTJQ?=
 =?utf-8?B?Z3JQRlZ3eFRvbTlObnhoU1VtRHdMNU9KLzZTUGVXb2RnSGJXdVhKaEc1b2Y2?=
 =?utf-8?B?Nm5tb1BPNkp5OFRNR3BUSGZESFBVNnJTTzhTd1EyOW9ERm15ZTU5TFMrRXJ2?=
 =?utf-8?B?L2Y2SDN2TU0yYmwrRHlSR1Z4ajcyZCtmTWtFSlRBUGJ0SVBxdTZMeEM0aXNH?=
 =?utf-8?B?Y3htYllRV3lwdFJWV0h5akVqOWd5VmJPRGtBdVBZZnpaZ0lYb21ucHJnYmNr?=
 =?utf-8?B?dDJyRmtrZ0Zjclh6bC9pQXFGS2R0OWlMMmQwYVNLcXh0aVhqQlRzUlVpU2JS?=
 =?utf-8?B?V1V6TEQydkx5MWxOWUxwejVocUpId3hDc0pFaW1MWGs0cU1TRU5RelFOZUpx?=
 =?utf-8?Q?Fkos+rw80aiE5S9T5RCOq8m3LQ/VybSHfNC5ulKH/LKKz?=
X-MS-Exchange-AntiSpam-MessageData-1: NIBT9HO49Hm7Vg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e2027c-e740-409a-b96d-08dea03496c3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 06:01:26.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMb0v1W/TyOln7U80Jq9ZYXLhfKgCQFWc9/wo0/RQrJcgc6GZ1d5mBype+EI0qouSCKgU+A6srJhWjaD8w/Ijg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720

On Tue Apr 21, 2026 at 3:16 PM JST, Alexandre Courbot wrote:
> When probing the driver, the FWSEC-FRTS firmware creates a WPR2 secure
> memory region to store the GSP firmware, and the Booter Loader loads and
> starts that firmware into the GSP, making it run in RISC-V mode.
>
> These operations need to be reverted upon unloading, particularly the
> WPR2 secure region creation, as its presence prevents the driver from
> subsequently probing.
>
> Thus, load and run the Booter Unloader and FWSEC-SB firmwares at unbind
> time to put the GPU into a state where it can be probed again.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/firmware/booter.rs |  1 -
>  drivers/gpu/nova-core/firmware/fwsec.rs  |  1 -
>  drivers/gpu/nova-core/gpu.rs             |  8 +++++-
>  drivers/gpu/nova-core/gsp/boot.rs        | 43 ++++++++++++++++++++++++++=
++++++
>  drivers/gpu/nova-core/regs.rs            |  5 ++++
>  5 files changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-=
core/firmware/booter.rs
> index de2a4536b532..771b018ba580 100644
> --- a/drivers/gpu/nova-core/firmware/booter.rs
> +++ b/drivers/gpu/nova-core/firmware/booter.rs
> @@ -280,7 +280,6 @@ fn new_booter(data: &[u8]) -> Result<Self> {
>  #[derive(Copy, Clone, Debug, PartialEq)]
>  pub(crate) enum BooterKind {
>      Loader,
> -    #[expect(unused)]
>      Unloader,
>  }
> =20
> diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-c=
ore/firmware/fwsec.rs
> index 8810cb49db67..4108f28cd338 100644
> --- a/drivers/gpu/nova-core/firmware/fwsec.rs
> +++ b/drivers/gpu/nova-core/firmware/fwsec.rs
> @@ -144,7 +144,6 @@ pub(crate) enum FwsecCommand {
>      /// image into it.
>      Frts { frts_addr: u64, frts_size: u64 },
>      /// Asks [`FwsecFirmware`] to load pre-OS apps on the PMU.
> -    #[expect(dead_code)]
>      Sb,
>  }
> =20
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 8f2ae9e8a519..37d0e4587ed3 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -286,7 +286,13 @@ pub(crate) fn unbind(&self, dev: &device::Device<dev=
ice::Core>) {
>              return;
>          };
> =20
> -        let _ =3D kernel::warn_on_err!(self.gsp.unload(dev, bar, &self.g=
sp_falcon));
> +        let _ =3D kernel::warn_on_err!(self.gsp.unload(
> +            dev,
> +            bar,
> +            self.spec.chipset,
> +            &self.gsp_falcon,
> +            &self.sec2_falcon,
> +        ));
> =20
>          self.sysmem_flush.unregister(bar);
>      }
> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gs=
p/boot.rs
> index 3f4e99b2497b..e00cfebe5d11 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
> @@ -267,7 +267,9 @@ pub(crate) fn unload(
>          &self,
>          dev: &device::Device<device::Bound>,
>          bar: &Bar0,
> +        chipset: Chipset,
>          gsp_falcon: &Falcon<Gsp>,
> +        sec2_falcon: &Falcon<Sec2>,
>      ) -> Result {
>          // Shut down the GSP.
> =20
> @@ -275,6 +277,47 @@ pub(crate) fn unload(
>              .inspect_err(|e| dev_err!(dev, "unload guest driver failed: =
{:?}", e))?;
>          dev_dbg!(dev, "GSP shut down\n");
> =20
> +        // Run FWSEC-SB to reset the GSP falcon to its pre-libos state.
> +
> +        let bios =3D Vbios::new(dev, bar)?;
> +        let fwsec_sb =3D FwsecFirmware::new(dev, gsp_falcon, bar, &bios,=
 FwsecCommand::Sb)?;
> +
> +        if chipset.needs_fwsec_bootloader() {
> +            let fwsec_sb_bl =3D FwsecFirmwareWithBl::new(fwsec_sb, dev, =
chipset)?;
> +            // Load and run the bootloader, which will load FWSEC-SB and=
 run it.
> +            fwsec_sb_bl.run(dev, gsp_falcon, bar)?;
> +        } else {
> +            // Load and run FWSEC-SB directly.
> +            fwsec_sb.run(dev, gsp_falcon, bar)?;
> +        }
> +        dev_dbg!(dev, "FWSEC SB completed\n");
> +
> +        // Remove WPR2 region if set.
> +
> +        let wpr2_hi =3D bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
> +        if wpr2_hi.is_wpr2_set() {
> +            let booter_unloader =3D BooterFirmware::new(
> +                dev,
> +                BooterKind::Unloader,
> +                chipset,
> +                FIRMWARE_VERSION,
> +                sec2_falcon,
> +                bar,
> +            )?;
> +
> +            sec2_falcon.reset(bar)?;
> +            sec2_falcon.load(dev, bar, &booter_unloader)?;
> +            let _ =3D sec2_falcon.boot(bar, Some(0xff), Some(0xff))?;

What about a named constant if you can think of a good name for 0xff or
a comment explaining why we need to write 0xff into the two mailboxes?
Presumably we don't care about the return value here since we check
success using the register read below.

Thanks for working on this, this will be a great help for avoiding
reboots during development (since pcie reset sometimes has issues).

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

> +
> +            let wpr2_hi =3D bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
> +            if wpr2_hi.is_wpr2_set() {
> +                dev_err!(dev, "WPR2 region still set after Booter Unload=
er ran\n");
> +                return Err(EBUSY);
> +            }
> +        }
> +
> +        dev_info!(dev, "successfully unloaded\n");
> +
>          Ok(())
>      }
>  }
> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.r=
s
> index 2f171a4ff9ba..21ff5d15f648 100644
> --- a/drivers/gpu/nova-core/regs.rs
> +++ b/drivers/gpu/nova-core/regs.rs
> @@ -176,6 +176,11 @@ impl NV_PFB_PRI_MMU_WPR2_ADDR_HI {
>      pub(crate) fn higher_bound(self) -> u64 {
>          u64::from(self.hi_val()) << 12
>      }
> +
> +    /// Returns whether the WPR2 region is currently set.
> +    pub(crate) fn is_wpr2_set(self) -> bool {
> +        self.hi_val() !=3D 0
> +    }
>  }
> =20
>  // PGSP

