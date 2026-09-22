Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013020.outbound.protection.outlook.com [40.93.196.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A9B3E9C11;
	Tue, 22 Sep 2026 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121157; cv=fail; b=D/JqgSKuyzHFq5HD7CQkO9hxt9gbhI9ppynSX2qXayNsnbBSfaByio24VnA5uqh+5K6YhMISF2aWVGigHF//OZFRnHCFw3Xx0rLEhHlJqeHgQauRUPYy4EJaOTOf0uYNgETt7/RduB553NOtbc7XLqcIvcp5a39hR0cnwprxDDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121157; c=relaxed/simple;
	bh=L3LKV+wfMoAC5arGGqaKMxOmPNzWAX6iYG0A1nrdRHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hQQV6wbBVID1Rwf1S8T2BmDP467KypFLME426JzBdg8kfU2yGlDeI2gwrR0zcBcWVLSVVbfQlqCpz406n8IIRLlxldBjbYW1Rs13WRIKgqXJc+2cTXvS2hhcxnv1Xj+dUCpp4yOiendw1b/FED7lhns+9SdnxMwmSwANdH9HCVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JwCfr8DI; arc=fail smtp.client-ip=40.93.196.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JwCfr8DI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnluuamceSGDiVrWX8s+MRt2bbsjXC19NuFTCArENYjjEdEg+fAMbFxnNsnnfudQpsu6jPO0XFMzrQYhHfBFnT7xTDrrBeSCrBVSffv8a+GwUTrOKfnklAtKXwN7uC0fL2i7CZnRMaN9uGhKmbfJWdi7547a03EgIbCiw/0zV4V5axxloE0evqcnk4v9IkIMoFnieTCPJkD3nGK3UXiaqGL3PBd8U3ZSteQAf+y5n53CDSslMT3eQqi5oRzfd9PgAmwzHtCHMxD2uq09C37Z1P4m4dY7gc06qLjFmeKkJZC3zrxAm6upr44S35gP4ixhY1WRW8XcargvawCeMXmHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0MYAda03UsQWVtj86YuPMMTLJLlcRmaV19xAq03nuo=;
 b=qy6k5woINfVnXV07jRunH4len8SP9QUGOv8V7Z9m1l+KBMh3dV2EHDyhmQ0Jd9NXhXF9ZpnS8eNp6JMraWPaumd+412nQz0Kd/Xu+qGJQnj/NvS6lkraKehnzYWu8LKPvjLk7PYz0FbBT/MgcJKhIgE1DQCfcqev7jTCTh0ZzTzyQmZz5GC8E+WJmFJVwn19+sKyWYt47vSc4HRXMQuxKI7iPB/IYxGUgFcPRp5pPNqz71mjBH7DuYQAK2tCV/NsabpXlaKy6quzqdI3HNvj7WA9n4gruPx51stmDlfl+vveP4ZBgNcpwfZUZgkjuwvWoG0nodXbkR5oEgnLAoaPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0MYAda03UsQWVtj86YuPMMTLJLlcRmaV19xAq03nuo=;
 b=JwCfr8DIFp3C986eD5qHm60lfDa6S2P1KzukatGjMvLXRW+fMu8TLaV5TE3S1Ron7xtaJmVMtJKB2F74XTEsEt+T8kD2axvftcmGP3fdhohSj+w2KPRjrN3Uhy2CdAFjnB3L8HwM9p5fEiAXpxkRZfGjewm+35Lf9xdfN3Pi8tTVSvVy0oQJl6j8KuCxxh7UJQsb5wxvV8RmAWmsXn8c05h0OPXspQVvR7TbfogvtgiTCNq2U7wHEsjT7jz5I1Xa04GrZRmvJQQkWGKQQ6dmX3m5b02/eCuMtuOZEwysR1RbzQ2K3bx9JEYYVBJMheYeYmZ5HA3zBaO68cgBdlwZUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DSVPR12MB827618.namprd12.prod.outlook.com (2603:10b6:8:3e5::24)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 23:52:23 +0000
Received: from DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f]) by DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f%5]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 23:52:23 +0000
Message-ID: <a40d803a-7054-42df-ba81-6a2e14a31c3e@nvidia.com>
Date: Tue, 22 Sep 2026 16:52:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 03/12] cxl: Share HDM decoder decode logic
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-4-smadhavan@nvidia.com>
 <20260912010700.43844d3b@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260912010700.43844d3b@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::35) To DSVPR12MB827618.namprd12.prod.outlook.com
 (2603:10b6:8:3e5::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB827618:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: e1104e22-ce36-4705-0aef-08df19048c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|11063799006|3023799007|6133799003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	kTgfxdH9ZrBF9yY39wrQzTvM4I1KLkONjT2cQdCtcHOaC67iZ1E9RJRpXbh/lQM4/hLxt7C0BcQDYLgzeMhsNraeKtTFgBW9mC4kAunTc+KJ5A7Ik6h0IxpQgKRFuZdNcu7bV90GV8nW45+vAvi8Ry46LLonupb1xXEc4WrT9uDfCoFcCwAFgv5dpMoPNamV4iuc8iDQtLh9EgQaKXAYDKOOTVvTwVIyEvEX8tJGg220FuDAZjsC+b4mkyIuDgNRBv2vLcjm8hughrHgdh5imltq1KovNhg6hjAEpHsmNU1lzVUzrSfzNGa2o92T2JE4H5IMh8gROYrSUDxEZ2SvEIdjodA7Q7l2mWJMiY6n+wEIrG8NGF+yBMFUZVY78nKtaXBypaNT1/hYL0JYGWMY5aHF5xhPygWJcv7GOQ0IWWIYVBKoCpvVgXAdvTnEvFb8Px+sDYeUE5YOGHGaIQFiyBUtW3TQdkrRKH23q0J+rIp8bTXWcEkCIo53UqLvDAW5ueXWYAN+oAZahjoUtxNkcuCuCJRlPhGtkDmrYZS0bDGFllD/HjOZIcgqy+JRS/qksotlCKKebBfXTGYavQNr3LnGpsOm6OcQHX5Av0wwSd/W+5NScT9FCMyReEpzNXM04bHCtOdIfgGJf9Z9T33fLpaHBvNhV4ztTFIWAwcoDqE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB827618.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTBZa2JqcHl0TmtNbTlPaUkrMmV3SmJVZUxOZ1p6Yy8zcVI1MHJkWFdPQnZU?=
 =?utf-8?B?TlFNNUIzWFdEV1cwTkRwcWZ5RU1sQS9jSzJlQlZYRkVZdytiekRUQVBpWVBu?=
 =?utf-8?B?T1M1clYrOHVLNFN5TFFWTm16MjNObUYrS2FCUE1VcnBXUWVXL1kxRjBiZE94?=
 =?utf-8?B?dDFxS1VrTytxUWMyUktENVA1bTFrRk5YU3g1bk9Rb2E4dnljdEhqWUsxT3Fq?=
 =?utf-8?B?NzZtRnQ2K1hGa3NvY1MxdW9zSWt6UytsV0pGWGhCRE5JT2NqWlJwNExrUkRE?=
 =?utf-8?B?TDBTNUZTY01YQzlzeHY4a2Y4NFZiZzA1ekxkOEhRbkF6M0VMS243cVhqQmVT?=
 =?utf-8?B?b3NQWFRaTHVsc0k0eWJxdVBUaHlxSGMwdE1VUjZOUFV3eVZWajhWTFhJSDNC?=
 =?utf-8?B?Lzlva3RpUzlpM2lzYVNDVjgrMXJKd2YxRnl2S1dMUWlVMHg1dldweGh5eVBR?=
 =?utf-8?B?MFFiY09CdEM2cEtiU0tzdDBTZ1lZR2ZkWlU3UzI2UTE0SjBnYlZxL2NTRjNY?=
 =?utf-8?B?UG1laVNsNm04VUZJdFBJMjZQTlNMc0tjUnpGblFQYWJPWUdSemJhKzVkSmRT?=
 =?utf-8?B?bldXM2JkdGtHV2FhVXVIZ2xNaG8yUitybVNEdkV3ZUQrN2pxNzc1Vm1XN2pC?=
 =?utf-8?B?SzhQVGlVQ0JrMVE5ZmpTdk4xYkFWa0pMTlJGZVAxdU5oT3JOVHZydTZLT1BX?=
 =?utf-8?B?Rml0R2xYQ1pkSm4vK280MjZOWW1GTkdTblZZYTBqNmRrV2pRZjJMV1Zhd1pi?=
 =?utf-8?B?UFZTS1Q2a0duRVhtZERtd0sxcnVqU3BlZkkxK1NEdmdTM0N0RUxLOCs0Ui82?=
 =?utf-8?B?dVdpaDRoSnRwUnlVci9pRU94YWZiUE02TW0xVEM0aG9WWW5FVzlKejZlNlN1?=
 =?utf-8?B?cHJtZmZJTGVOMWJQZ0RWSkJzd2M5SlNGc045dW9DcWJmWEJuME5vQzU3MDY1?=
 =?utf-8?B?djNleFYrMXNqb0g5UHd2eDZvK2R6TEVwYXFja2p3dmsrWURYdDloR1Viai9M?=
 =?utf-8?B?MytNZTlBazFBUHZDQklPUGdtdEwxWjA2R1FzbVhBSHBZaDRuQkkzZlZyRVcw?=
 =?utf-8?B?QVZqeVdQMmR6Rng1dXRER0gvOVhaYXNxQjJ6OExsT2xBcGpuL280TmpFVGxQ?=
 =?utf-8?B?NE00L0twaXppOHRsamxEdlpwSCs0SUJiQmlncGxQWFFYVm55VHdkbG9QQXhR?=
 =?utf-8?B?dmNjSnpScWRrcXlLQTdSRUppR1BIYTBzTStHT1Y5U3hSdEJ0aVl0Z0p1V1Q2?=
 =?utf-8?B?eGt1dFhPMUNWenNabExldjNoaWZhUzRKN3dyNnhlcVZOVThxV3A2dlV2aVd2?=
 =?utf-8?B?bXNsblN3NHc4UlhSMUVFdXN0RUR5Lzk2MThVcWk4ZEYvZEVFMnpMRGYzVnkw?=
 =?utf-8?B?ZERWQ2JtcWJFRncwUThIenJWdXgvRmFFVmhpd3RvOVRzaWkwbGp5N2dHMHMy?=
 =?utf-8?B?ZnRiUjNYZDE0S05YdU5pY0pORnJCNU9JZWZDN3lJbGtCNDRkaDJDN3lReHJx?=
 =?utf-8?B?QTNZcDJ4ajlvckdsZEFBR29sRU1Ld1d3djhGbFU1bzdpUjVNMDZBa2luYzJO?=
 =?utf-8?B?Z2p3VW5vb29FSis3WVBDZFNMWjlTaEM5d3U5VStVWEV2SE5RcllCa3VnblNi?=
 =?utf-8?B?ZHVvd2FKUDdrcGRlWm5iZ3JoTjVwT2EvRU1yV2tHVHZCZTNKZkl0WEptdzR6?=
 =?utf-8?B?cmhKV3R5ZGhqQllxbC9tV1hxK0lDV01Mb2g1QWxSNlFKaUU5a2FJcTFVeHZF?=
 =?utf-8?B?WXdNWnIrZGFqZ0pTS0FEYXQ2MnAvSzJhY0pWN1cvOXlRS0g1alhkMnZoSHAr?=
 =?utf-8?B?ZFU5b29HSTlyTEdwdE4wMTNoYUJTRm1yL2g3aVFZRVJ6ZnVKemt5UVpzOStq?=
 =?utf-8?B?MTlhVm50RFk4dXhRb1pvSjBVWEcva0RpODRyamFWbnM3WHJjcmR3WGk4TERk?=
 =?utf-8?B?SE1KMWtKdzd1OTJwMXp3ckh1Qk84bmNpNnFyK3ZEM2pIaFNhQU5nUkhNQTNV?=
 =?utf-8?B?cCtvbGoxSmR0UjdEeGZ2QVdkNE9vblR6Wk05Tnp1YWJEMUZTT0svVElWMnda?=
 =?utf-8?B?ZDBKbFpWTkVhNlpJRlFMMDVDbjN6ZFpncDFtY0pPMlhzQmRvMkVVSjVCajFK?=
 =?utf-8?B?TFhjYk1kWDNROEQ3aHJicUh2WnN5MXVFNjF4NloyYXo3RzBaK0VaTG1aMG10?=
 =?utf-8?B?b0V3bXkwR3VIL2E5K3FuNDVjOFl1TlBqbEtzb2NIK3RjcGpzTDB0eFB3WEg3?=
 =?utf-8?B?L3dBNEdLclFjcHdJT1Rzek5xM1dsU1c5NHJmRm01OFFBaWt0c3BMQXI5NVB4?=
 =?utf-8?B?WFBsQWFza3NkVVM0QkE2dENOY3dFYllCS3UzSWlQNUQxRW84Und1QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1104e22-ce36-4705-0aef-08df19048c63
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB827618.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 23:52:23.7509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAoTMpPtRBZ5RBqomdtSRZFvexHi/dNC0pVuK9p/UU/IiksHMStHxHNmd9uqi9csdS5iiJno0L2JntgaV12FzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

On 9/11/26 5:07 PM, Jonathan Cameron wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, 10 Sep 2026 07:07:59 +0000
> Srirangan Madhavan <smadhavan@nvidia.com> wrote:
> 
>> Move HDM decoder register decoding into a helper shared by normal CXL
>> core enumeration and early PCI HDM cache setup. This keeps validation of
>> base, range overflow, interleave, target type, and enable state in one
>> place before adding another HDM parser.
>>
> Hi Srirangan,
> 
> 
>> Keep caller-owned policy out of the decode helper. A committed zero-size
>> decoder now decodes successfully, while init_hdm_decoder() retains its
> 
> I'd not use decodes for that second bit given it's a decoder.  Choose
> another word - it definitely isn't doing any decoding.
> 
>> existing zero-size rejection.
>>
>> Preserve endpoint DPA state ownership by using the decoded skip value as
>> a local input to devm_cxl_dpa_reserve(). The reservation helper updates
>> cxled->skip under cxl_rwsem.dpa.
>>
>> Reported-by: Fenghua Yu <fenghua.yu@intel.com>
> 
> Add a of Closes tag for the report so we can see exactly what it is
> referring to. I'm guessing the zero length decoders?
> 
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Quite a bit of feedback on how this is done.  Maybe I'll get
> convinced in later patches but as it stands this is making the
> code less readable.  If it is useable in the cxl_decoder
> and we can lose the local structure than it becomes more
> convincing.
> 
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 70ffebd3e213..d621d827f59f 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -907,14 +907,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>   {
>>        struct cxl_endpoint_decoder *cxled = NULL;
>>        u64 size, base, skip, dpa_size, lo, hi;
>> +     struct cxl_decoder_settings settings;
>>        bool committed;
>>        u32 remainder;
>>        int i, rc;
>> -     u32 ctrl;
>> -     union {
>> -             u64 value;
>> -             unsigned char target_id[8];
>> -     } target_list;
>> +     u32 ctrl, tl_low, tl_high;
>>
>>        if (should_emulate_decoders(info))
>>                return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
>> @@ -927,35 +924,33 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>        lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
>>        hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
>>        size = (hi << 32) + lo;
>> -     committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
>> +     tl_low = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>> +     tl_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> 
> Be consistent on either combining these into local variables or not. Right now
> this is the only one handled in the parameters for the next call.
> 
>> +     rc = cxl_hdm_decode_decoder(&settings, which, ctrl, base, size,
>> +                                 ((u64)tl_high << 32) | tl_low, &committed);
>> +     if (rc) {
>> +             dev_warn(&port->dev,
>> +                      "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
>> +                      port->id, cxld->id, ctrl, rc);
>> +             return rc;
>> +     }
>> +
>>        cxld->commit = cxl_decoder_commit;
>>        cxld->reset = cxl_decoder_reset;
>> -
>> -     if (!committed)
>> -             size = 0;
>> -     if (base == U64_MAX || size == U64_MAX) {
>> -             dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
>> -                      port->id, cxld->id);
>> -             return -ENXIO;
>> -     }
>> +     cxld->hpa_range = settings.hpa_range;
>> +     cxld->interleave_ways = settings.interleave_ways;
>> +     cxld->interleave_granularity = settings.interleave_granularity;
>> +     cxld->target_type = settings.target_type;
>> +     cxld->flags = settings.flags;
>> +     size = range_len(&cxld->hpa_range);
> 
> If this settings field matches cxld fields so well, why not embed one in
> there and write to that directly?  Without that I'm seeing little benefit
> in using the settings structure in here.  It is complicating the
> code and the only deduplication is a tiny number of checks.
> 
> 
>>
>>        if (info)
>>                cxled = to_cxl_endpoint_decoder(&cxld->dev);
>> -     cxld->hpa_range = (struct range) {
>> -             .start = base,
>> -             .end = base + size - 1,
>> -     };
>> +     if (!cxled && cxld->interleave_ways > 8)
>> +             return -ENXIO;
>>
>>        /* decoders are enabled if committed */
>>        if (committed) {
>> -             cxld->flags |= CXL_DECODER_F_ENABLE;
>> -             if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>> -                     cxld->flags |= CXL_DECODER_F_LOCK;
>> -             if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
>> -                     cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>> -             else
>> -                     cxld->target_type = CXL_DECODER_DEVMEM;
>> -
>>                guard(rwsem_write)(&cxl_rwsem.region);
>>                if (cxld->id != cxl_num_decoders_committed(port)) {
>>                        dev_warn(&port->dev,
>> @@ -995,33 +990,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>                        writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>>                }
>>        }
>> -     rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
>> -                       &cxld->interleave_ways);
>> -     if (rc) {
>> -             dev_warn(&port->dev,
>> -                      "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
>> -                      port->id, cxld->id, ctrl);
>> -             return rc;
>> -     }
>> -     rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
>> -                              &cxld->interleave_granularity);
>> -     if (rc) {
>> -             dev_warn(&port->dev,
>> -                      "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
>> -                      port->id, cxld->id, ctrl);
>> -             return rc;
>> -     }
>> -
>>        dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
>>                port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
>>                cxld->interleave_ways, cxld->interleave_granularity);
>>
>>        if (!cxled) {
>> -             lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>> -             hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>> -             target_list.value = (hi << 32) + lo;
>>                for (i = 0; i < cxld->interleave_ways; i++)
>> -                     cxld->target_map[i] = target_list.target_id[i];
>> +                     cxld->target_map[i] = i < 4 ?
>> +                             (tl_low >> (i * 8)) & 0xff :
>> +                             (tl_high >> ((i - 4) * 8)) & 0xff;
> 
> Can't we keep the type punning and readability it brings?
> Also why is the one thing that is still using the non settings path
> to get to values?  I'm not that convinced it makes sense to do any
> of this with your new settings structure but it needs to be consistent
> at least (like skip is below).
> 
> 
>>
>>                return 0;
>>        }
>> @@ -1036,9 +1013,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>                        port->id, cxld->id, size, cxld->interleave_ways);
>>                return -ENXIO;
>>        }
>> -     lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
>> -     hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
>> -     skip = (hi << 32) + lo;
>> +     skip = settings.target_or_skip;
>>        rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
>>        if (rc) {
>>                dev_err(&port->dev,
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 625e4aa427db..5085574521c6 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -34,6 +34,25 @@
>>   static DEFINE_IDA(cxl_port_ida);
>>   static DEFINE_XARRAY(cxl_root_buses);
>>
>> +struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port)
>> +{
>> +     struct device *uport = port->uport_dev;
>> +     struct device *host;
>> +
>> +     if (is_cxl_memdev(uport)) {
>> +             struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
>> +
>> +             host = cxlmd->dev.parent;
>> +     } else {
>> +             host = uport;
>> +     }
>> +
>> +     if (!host || !dev_is_pci(host))
>> +             return NULL;
>> +
>> +     return pci_dev_get(to_pci_dev(host));
> 
> Very nearly same code in read_cdata_data()
> 
> If you want this helper here, then introduce if first refactoring that code
> to show the helper is useful then use it here as well.  So basically
> put that as a precursor with a note that it will get reuse in this patch.
> 
> 
>> +}
>> +
>>   /*
>>    * The terminal device in PCI is NULL and @platform_bus
>>    * for platform devices (for cxl_test)
>> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
>> index 8d3f43640199..e6aa55079c76 100644
>> --- a/drivers/cxl/core/resource.c
>> +++ b/drivers/cxl/core/resource.c
>> @@ -113,3 +113,46 @@ int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings)
>>        return cxld_await_commit(hdm, settings->id);
>>   }
>>   EXPORT_SYMBOL_FOR_MODULES(cxl_commit_wait, "cxl_core");
>> +
>> +int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
> 
> As in the description, this is too many decode given unrelated things
> they are talking about.  cxl_hdm_parse_decoder() maybe or cxl_hdm_unpack_decoder()
> or cxl_hdm_decoder_fill_settings() though then you'd need to put committed in there.
> 
> 
> 
>> +                        u32 ctrl, u64 base, u64 size, u64 target_or_skip,
>> +                        bool *committed)
>> +{
>> +     bool enabled = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
>> +     int rc;
>> +
>> +     *settings = (struct cxl_decoder_settings) {
>> +             .id = id,
>> +             .target_or_skip = target_or_skip,
>> +             .target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
>> +                            CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM,
> 
> Do we have paths where an early exit needs the partly filled in structure?
> I'm assuming not. In which case I'd shunt this down a bit to where you can fill
> in more in one go.
> 
> 
>> +     };
>> +
>> +     if (committed)
>> +             *committed = enabled;
> 
> I'm not sure why committed is special and doesn't go in the settings.
> 
>> +     if (!enabled)
>> +             size = 0;
>> +     if (base == U64_MAX || size == U64_MAX ||
>> +         (size && base > U64_MAX - (size - 1)))
>> +             return -ENXIO;
>> +
>> +     settings->hpa_range = (struct range) {
>> +             .start = base,
>> +             .end = base + size - 1,
>> +     };
> 
> With a bit of reorg, this can be filled in along with the stuff above
> reducing the zeroing then overwriting that is going on currently.
> 
>> +     if (enabled) {
>> +             settings->flags = CXL_DECODER_F_ENABLE;
>> +             if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>> +                     settings->flags |= CXL_DECODER_F_LOCK;
>> +     }
> If you used a local for building flags, this could also be rolled
> in.
>> +
>> +     rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
>> +                      &settings->interleave_ways);
>> +     if (rc)
>> +             return rc;
>> +
>> +     return eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK,
>> +                                 ctrl),
> Go long for readability.
> 
>> +                               &settings->interleave_granularity);
> Locals for these as well and it becomes
> ...
>          rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl), &ig);
>          if (rc)
>                  return rc;
> 
>          *settings = (struct cxl_decoder_settings) {
>                  .id = id,
>                  .hpa_range = {
>                          .start = base,
>                          .end = base + size - 1,
>                  },
>                  .target_or_skip = target_or_skip,
>                  .interleave_ways = iw,
>                  .interleave_granularity = ig,
>                  .target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
>                                 CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM,
> 
>                  .flags = flags,
>          };
> 
>          return 0;
> }
>> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");
> 

   I reworked this across v13 patches 2 and 7 based on the comments in 
this review. The shared PCI-device lookup is now a separate precursor, 
and the decoder helper is now cxl_hdm_unpack_decoder().

   The unpack helper validates locals before publishing the settings in 
one assignment, represents committed state in the settings flags, reads 
the target registers consistently, and retains the target-list union.


  
https://lore.kernel.org/linux-cxl/20260922083924.2451158-3-smadhavan@nvidia.com/
  
https://lore.kernel.org/linux-cxl/20260922083924.2451158-8-smadhavan@nvidia.com/

-- 
Regards,
Srirangan
