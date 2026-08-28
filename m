Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8FE250BF2;
	Fri, 28 Aug 2026 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787880284; cv=fail; b=grvwhg1AdUDWQWVH9ZPNzqy1/+CwNzduPW20m/0D554z4R/avtieV+nkYnvlv3Yu6DmfWWtajmwmJ+bkLKivm9obRstMo95QF1pIRyzqk3ZYGF2AO78x4jEXqu78U/wa665G/9kddgHD1Jje+3rXRyGacUOLNLgJSJGDyoSLpXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787880284; c=relaxed/simple;
	bh=+VjPYeMstS3yX2kn5hven9ofIsWznuhUrKgayl9v8io=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=IhIMlbG18dz1bqCPBYI+pAJEIDZO0dyDhMwR3CmtbtUMX09rCTbvujZJLDR95AJlRS99411l/kdhaigxazdYth4BIHvx4nKlMBm7r2PPNReSykFWoFdElB7SFZ0ST4MxKd3gOGlhj2qocOD/6diszHwL0w+3xSUoZdkmBn2sKUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pg4+nc/D; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pg4+nc/D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DU+p8PBBPGSaGIX3hXQdO9AA8LtXfeme8jF3iz6xicFl1nOZc1VLah4yufxUYTGVsL/T/NeWCB/wWQRzbPqMKPVAFwyTe10wHutMrpjqKbfVGoC5sZRmqfQ1Z/JBm/gHC/fC6dR7EnFHIiVFkEYdUSsZkp7yVoRqvRK3DxPajVACzf/VrlT6CD5d+sF5poZHjlqfIhNCboQ1h4KDDzskq+6xztJ+UA+MG3eTIKGjCTGjZPZiaqO2JMQIFeB4wFqG5I6NYsOGBOo8gfEk0AmbWJVwimV8W8M4GYylCz0wZf1BbW0/ifWV2WalYKtoTM3lIMygk7CE/ewqv3bFPV5teA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5ezPP9lEklnxhxCy09eLKQrvigLrH1u/1n1eshQzvM=;
 b=yPtV2ysy3JCAOz1DrrAOjMM7CwI+UyeEqSjTXXpxsZcZTWTwWYXjsLqoQyj4P12zNkHMnle+A2qsH9x2ZMYz2j98ZPKToUGRccQ+XW7EogvrrEi7aZ42Ol+OcpHeUZadiz29EU6x2G3cQsf0VS3EZa9NaZ7eYQ28BQIabCCqL+eMNP+fQ3UbD15p6KFH/LFKpqAgHXd4U0ZdXCodJYJS2RqxOQrU/MDEBh+m3V+ewnIDiSrcQwA4JEnKy2MIWUqPJiFtYr6xXsKymvA2ehG/u/yNpYcWqPdhhYarX3wSfi+FEKx9+4M2YaI5q9RqTFqc6llz6inKJD92WSyyUASFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5ezPP9lEklnxhxCy09eLKQrvigLrH1u/1n1eshQzvM=;
 b=pg4+nc/Dtsu9LCBzIl9vwb8pGorv9x4YAPDH5xx8B/oV763MnQQxxkg8LUrtbUDmdK2KJAn65pBMhqdtBdUxzHmXaSPgBu6QhpaFb5x1eTUjzdrttXTOektglC1MyeV2mOT3B8RlBDC43bb/y7lj7W2LMZ5aljkwARHOaJSFwy8wv+FFuAABStnB/Y6kS0hrtdCQXyEqD9IibWZuCz6ZZcPzz1Jxrb0Oy6Iu5OH7c9+s5M9LA+dPJWW9Op6138bXUW9B/BEh985ZvCVygObPUJ3WbqUQJ0+VpSeQhDmHEHrPK/KjUIzMm2mJ5GAyUvN7dEN4DGsLC5ZSuEYjA1QMhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Fri, 28 Aug
 2026 01:24:36 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 01:24:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 10:24:33 +0900
Message-Id: <DL06NUYLYW5K.1T755UK73WYHO@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 12/16] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-12-3699a75fadf1@garyguo.net>
 <DL068LFDXPM1.7A1482C1UJF@nvidia.com>
In-Reply-To: <DL068LFDXPM1.7A1482C1UJF@nvidia.com>
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: b49ae92d-e257-4927-647c-08df04a31f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|10070799003|1800799024|366016|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	3+4mk+sa0paKEHVes51MHeUhY8zKScI7IDuhAVb7KAjVbFH0dm5DRxKc6hZUmHHpdZgyDzSTg0x+MXOdWuM7MjojRVBI/PAfQfPFBzxQTkgB/R8kw8z0OHWS/kepaV7OFgFc78KNAXfKLc12dgdoxNfPyoqlQziTr6XvmBVUu4yKr/hgzyRXBx1KWehEyRV5wyhRtVEPubE/d4t0YRpuR9Hi7WYSMWjrclRLE6uQSQeVmW2kMwwQLGFCNQwI/1DurHO0TX8UQnbahzXrcGsO+Iq2Ib5fVvo6CY6YBJ1j0NCeZJQ7cQHgaFikfDSi8JQW1h3cJly6sMOhTWGdUmgfSn6/8Nd8IGWKhzBUWkeMG6Bq3EXO+x1c+M4TqRWug76XAhMs+2GWA3e2ozRP4pZ8jGEA/SNz8vkx4jM6JsaZkVJi4rn/LkK1sIpcoIYtybLwiE6goBAXJOxuWjDePzcRPu4PxnzlIwUazWRXy+07uJMKGnyDVtfkmRqRJo48iYRRWRboZkJ1wYHinK0/hod8N5LXlH0MGpwgN3zQxG2Mjg6W6LuSwFFlS9Iwrx6pLcD39Z4bwsBFqEHqyy7V+zCpN64Houj9AMpIaYiKhPQCjcfyST2TNH3gYJLRxAy3s04U4C+9q6pAUaV6PnYAHrSRviuja2sroNAk/vRAZzBXcGs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(10070799003)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzVYMUVPckZSWFh1QTBiR1lyTTVxd3NJZXk3ZnJRM2Iya01ManpBdmowQ3pV?=
 =?utf-8?B?NTdQV2kySExNVTlWSW56RzBoUzd2QmRUOEtjeE9BWGxjVGdWRjVvZG50NnhK?=
 =?utf-8?B?QTZHNGVPVHNhdmlYb0tpS3RrTUYrSHRvOW16V3FCbGhNOG15Rnd3QXJCWDdv?=
 =?utf-8?B?N29QaEx4ci9DV2hZa09mOWFaNytVcHh1bytSWktSelFqTjRSVmljZmxjQzFT?=
 =?utf-8?B?eWwvM0k0SEloQmhqeEMvVTBZc3YyTkxoQmZ6ckpjbEc4dWxlcXhNeFdEZ2Fq?=
 =?utf-8?B?VWV2dGRPSWpnNGVZeldXQnJCTVlRUC9XWUFtbDJHOEhYekNzQ295ZVpSTFI5?=
 =?utf-8?B?RC9TejRHNG03azQ5SHNHRHptV1dwMXhtSWRJcVJ4aGZnbzMydEZaenJRcmxa?=
 =?utf-8?B?aWpYUVpFYlpZbHNRVzhTQ0NCMHZRRlZnL0JNRWFjVm1GVW4yOHk1VkN5NjBZ?=
 =?utf-8?B?Lzh4Nk4yOUFRTkV3S25hTTdCblMzazFCUlpKRlpVaG9QUXFabTJ0UWc5VTB5?=
 =?utf-8?B?Z0VlakhISnJPY1c4OWFYcVRSbndpVFc2VWVQUDgwSkJOVXRUeEN4RkVkR3hl?=
 =?utf-8?B?Rm5ldkpJV0tMUlZMTTZIdTFGdEdUL25QNTJZc3Zsbk5Hb003clgydVNOME1J?=
 =?utf-8?B?K1VTNFJWcHhRWWY1SHU4MUlHWS83MzNhUmRLbi9ML3BNTUNwczdYZzNkZXJ0?=
 =?utf-8?B?d3djbjVjM1ZjY3JJeDhRSGkremgxSlBKSE4xbUp4LzNTUmltL2hHWVN4ZGJa?=
 =?utf-8?B?MXNmZ1Rlc1djSk55SzE1RzJ2SnZ0c1FIbTFJME9KMnlPbXpLM3Zaa0IveS9G?=
 =?utf-8?B?eG9saVRvU2FHSFVMOHZncHNyUHg0Rmh2WHU1Mmt0a2ZOSzJUUWNnQzVXekhI?=
 =?utf-8?B?TjZEcEcrbTVxa3JWL2lVL1BkdXdoZ2ZWb1JwM0FwZmt0aVUxZ2UzM0JlcnJV?=
 =?utf-8?B?RHZpYTNiSWtJM2pnSkpxZjRRMC9TVzZiMllKMFdKRnhyRWJFSk5rdFZkTnRm?=
 =?utf-8?B?UUtkWEVpZFEveFdsblhzblRsVVA4bUIyNUFRZnRmY1pjcWdZUm11VHk1b0JI?=
 =?utf-8?B?V2NLYTk2MzMrR2RjcjlYVHhtUWNWUzRHci9NbDNFMXFBV1FsQWRZUXZ3akZt?=
 =?utf-8?B?bDNuVUdhUG9vUUp2dndzY28rRVliZ0tmM3lMaGFVRHMxUXY0clVTdEVyaEtz?=
 =?utf-8?B?N3VkeHZ4TEJOUUN0SjJJbjJqN3lVcnBCMm1NQ0twVFJ0VWJyV1Q1UDRVOXNM?=
 =?utf-8?B?T3ByM3hvaG1YTW1HcGV4cWM3bGVXdjJBYWFRRkJlY1MxZDJObXF2YzM3WDdL?=
 =?utf-8?B?VHFSVGpVWmxHK0llMFFJSFpsZnR3RDJpNmRsZlhSSEZ0SU1PR2ZOOHQ5NjFN?=
 =?utf-8?B?TjlvWkxtQzQ2UnRSUUZNSHp2Vy9rY3VxWStuUXY0eHgzdzJrNmd1bVA4R2xh?=
 =?utf-8?B?YjB5L3NkRVZNSzNPNWhwbzVud1Jhb2d4cGNuT3JqNXlTc0FHQjRBZTRKaHhU?=
 =?utf-8?B?VCtXWjl2NktocVJjcVFnZUNKRlRSUUg1MmxVT1V0QU5sSG5yV2JpSHlqbGxa?=
 =?utf-8?B?OUhMcDVkRFRodFYwbnV1MVBHZFZsSEJVdE9ZTGhQNXBKNXFQdTc2WnM0QXFs?=
 =?utf-8?B?dFlMRzlxZSt2aWg3bWJLWXhSYXFBaXc3L2RaenRJMEozMzhWZGFydm5sTGty?=
 =?utf-8?B?aHZCc0p2ZHcrdmlMb3JrOWRiWWRtK1lscmszUzRoYnZmTUcrZ0hVMVVFMnYx?=
 =?utf-8?B?aWJQY2d0VVVmMGRJUUJtWnlYdUJXMnB5RFQzNHhqV3pkT2JQcVdqOFFkdmxF?=
 =?utf-8?B?ampHNndXK2ZISVNHeTBJY1M1QnpianNlcS9kU0F2elFOdjRpTlBwREltWHBY?=
 =?utf-8?B?WUovNWkxNFcyejVMRkhpZVM5ZWpzWVY0b1ZSUkVnUWVMZmtpNGpJazZqQUZy?=
 =?utf-8?B?eHRlQklYTVBGS1pEOVNneEh0b3l5WkZZemJFS1UvWmhnWE4weUYrN3o3by8x?=
 =?utf-8?B?dGhrb05QY2Y3eDFOOG1pUkgrRlViSkRvWEtwcm1GMTdSQWNLSXh4UEpJSmZF?=
 =?utf-8?B?Q0piMi9aWUFFN3RXMUN6RGozc3hDMUxrK2R1OERQVzhHK0wxNHJ3QkZqRmlq?=
 =?utf-8?B?cCtaUTdzbE5Pekk3OFVNa251TXk4OTJwUTZkZzJJSzBDdktvVEFBZzFXY3pz?=
 =?utf-8?B?UGtCYVRDVmdSQUpUMlNlOG9lZUZNTklhN0NJYU5BWmN5SERRa0lKS0twb01T?=
 =?utf-8?B?cjdGTDBXUHVORVFsdkZvOExOQ2Z2bGczZUpmSjBRTlpTZmdSYlNjQ05YU1oy?=
 =?utf-8?B?RGZKL2M2Y05LcVpVS0tFb0Jqc2MrTkcrR1RjSCtDOTgzazEyL2NjREdUSkNT?=
 =?utf-8?Q?bVGp9SwIr5DBc+ZjbhP2zVxucQB6gMC675iY3Jzt5BfBl?=
X-MS-Exchange-AntiSpam-MessageData-1: Dxn7w+7BnaUmcg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49ae92d-e257-4927-647c-08df04a31f02
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 01:24:35.7576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aR2c/jfo/apZWwRV1K8vQcplGhebxHjaw7wnkENw6x8ZFju2dwYC4l4yX/KdftlyNS+s839QKUj54B67ETZRpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359

On Fri Aug 28, 2026 at 10:04 AM JST, Alexandre Courbot wrote:
> On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
>> Add fixed size region types `PFalconRegisters` and `PFalcon2Registers` a=
nd
>> update PFALCON and PFALCON2 registers to be fixed register on them and n=
ot
>> relative registers on `NovaRegisters`.
>>
>> Update `Falcon` struct to store projected views when constructing and
>> access with `self.pfalcon` and `self.pfalcon2`.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>
>> ---
>>  drivers/gpu/nova-core/falcon.rs                    | 157 +++++++++-----=
-------
>>  drivers/gpu/nova-core/falcon/fsp.rs                |  63 +++++----
>>  drivers/gpu/nova-core/falcon/gsp.rs                |  51 ++++---
>>  drivers/gpu/nova-core/falcon/hal/ga102.rs          |  62 ++++----
>>  drivers/gpu/nova-core/falcon/hal/tu102.rs          |   9 +-
>>  drivers/gpu/nova-core/falcon/sec2.rs               |  37 +++--
>>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  18 +--
>>  drivers/gpu/nova-core/gsp/hal/tu102.rs             |   7 +-
>>  drivers/gpu/nova-core/regs.rs                      |  92 ++++++------
>>  9 files changed, 238 insertions(+), 258 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/fal=
con.rs
>> index 65cb12d26e2b..119d305e2ea3 100644
>> --- a/drivers/gpu/nova-core/falcon.rs
>> +++ b/drivers/gpu/nova-core/falcon.rs
>> @@ -14,13 +14,12 @@
>>      io::{
>>          io_project,
>>          poll::read_poll_timeout,
>> -        register::{
>> -            RegisterBase,
>> -            WithBase, //
>> -        },
>> +        register::Array,
>>          Io,
>> +        Mmio, //
>>      },
>>      prelude::*,
>> +    sizes::SZ_4K,
>>      time::Delta,
>>  };
>> =20
>> @@ -165,18 +164,22 @@ pub(crate) enum FalconFbifMemType with From<Bounde=
d<u32, 1>> {
>>      }
>>  }
>> =20
>> -/// Type used to represent the `PFALCON` registers address base for a g=
iven falcon engine.
>> -pub(crate) struct PFalconBase(());
>> +/// Type used to represent the `PFALCON` registers.
>> +#[repr(align(4))]
>> +#[derive(FromBytes, IntoBytes)]
>> +pub(crate) struct PFalconRegisters([u8; SZ_4K]);
>> =20
>> -/// Type used to represent the `PFALCON2` registers address base for a =
given falcon engine.
>> -pub(crate) struct PFalcon2Base(());
>> +/// Type used to represent the `PFALCON2` registers.
>> +#[repr(align(4))]
>> +#[derive(FromBytes, IntoBytes)]
>> +pub(crate) struct PFalcon2Registers([u8; SZ_4K]);

Actually one more nit: while `SZ_4K` is correct, these should ideally be
named constants instead of being hardcoded.
