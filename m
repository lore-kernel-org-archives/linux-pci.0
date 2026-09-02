Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EBC1B6D08;
	Wed,  2 Sep 2026 04:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788323952; cv=fail; b=s2JAoWuD554coPC6g+VpOCO4rcBczbZQJos4Mb20Z5xOSJkersCIfWRb+o/B7/swEwrewvoai+S8pcvL9U+23nd1mcmJtVLuQ/nIQkvSKExDs2HUwE+M6e2Y7+gp/JCb+utY7tUuJUpLseEvw64KXyRIAvC6vDdOCES6ga3FNzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788323952; c=relaxed/simple;
	bh=il+t2pkPPUktYxYHPGGzYI/qkLqmOVY3v3Ky3f7oyYg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PZhRdkQbeHGxEaZilbiTZOiOB1gQacCjVTBEz2VS7CK5QkN2P4MIMl5vzld4379FzG48/x3JaqsRhKDG+hBDd/c7Hi6MsTztdJQCP6g0WTS8bLtFsfpbMfLnNnbGo5lRneS6V8AiyIr/QP34Vz56OYGsttw2eheaVBhF5gYv460=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=afW5gdVR; arc=fail smtp.client-ip=52.101.48.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="afW5gdVR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMOICXM86u6PArFRP/v9suSKC6kmnid1jku8t9n0ursMAcTx5QzlcbgHOS591JTzQ7pAfIWSQNYLRWMhIC2gMVdhWgZDKDKupSvvaS2dfJn/XUaNlBZw5nz2uWoWruR48PBAB/dO0MBaOCECd08FDHcJp0e3kriH4t0YRRG9eTKNCd3hsObp61ECzkI2hr+u2t1TvDB4CjRyPBituwZ1/Tw9TvNuOigBWy2coQTMAMYsgKMNcBOtrMjjwlRgZ1giOzlZ709DKdyQRbANaPf9tZlb5VcfL2tgO3W+soPyuTJj3c+yzUv0VRbJKUUn5qqW0P97snaREmzcwYWcLaJhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1va3lBMVO1YPnDIJ7jw6qiuQm1pGwr9A+3+2vr6JKk=;
 b=irpA8/9oNBFEe0pD+/MH0oOP1hlbsJPPpnzukqbsMqeIP6x4WhUxbvKqqGiicilLkmnIQtRxX/g4A1zr4q9D5DTRwaHExRz1DyDgxXtRs/HBB83TjYfUMyyY/0WJO/bTkYRcjS8SQqiPpfQbbW2sMIDO/4kVLzBvMT/00r7NKy5KjK4b90qny93nSEaFhRm6YnEt+epbQNJkRuw0qHoFUOJe6j0Lu+t9ucwUmlNvlRRq6yuLoHZm5YFkEIXURwDfxTwIiQ6h6M4m5ipgtaIwgjUwPQNjy72UjKJRlfI48GFS2U82EkRfbJNNcZ4e7p1DAeXDq4+tEI3C10/ujwhJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1va3lBMVO1YPnDIJ7jw6qiuQm1pGwr9A+3+2vr6JKk=;
 b=afW5gdVRtNoF3IOsQqF65F74lrc25jRr+ukU1CFmgpcBvg0qJLq3NZ7Jpu23DYkl7ufapOrtZs5g0lUvvTQvjem6qMHoQy6KP93sAZ89bIHxKxP7OtSmRcZAdzzV0yAvZKAtiR5ED7eEr7Z20RUdgWJMkp+B/EuKlqZ5opQmsAipZHCjoLK2+wjC66rjz6vqeTUZ06Y4VWfvl+kC2ClbHd4b3oU3b+DGKlPagPsHJUPu/7PmH7AGpH21+3mFacTEbVHa/7CHfFvgPWJqlO/05sIV2HiPaNvBI5TAu32QOkpFdl3DtIAplxkDp4tmIbPzP/FWu0T92Q0hOoPlz6SecA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA5PR12MB999326.namprd12.prod.outlook.com (2603:10b6:208:608::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 04:39:07 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 04:39:07 +0000
Message-ID: <95385898-6e8b-4eef-9135-23605feea614@nvidia.com>
Date: Tue, 1 Sep 2026 21:39:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/12] cxl: Validate HDM ranges before CXL reset
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-8-smadhavan@nvidia.com>
 <2b6302e6-18e6-42de-9489-014c4beb25c4@intel.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <2b6302e6-18e6-42de-9489-014c4beb25c4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::19) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA5PR12MB999326:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1cbdde-1816-49d7-2ca3-08df08ac2020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	LOdvFNAPjXNAqmEtNNZC4kCyjYHwshGOwkOeKi1DzqYg809+Fzw9T23rlnAHPWqaEXcO+esY4SoOZ1KaGTEeeYoDscTa1Fb6Lm62iDBRLYj+IqrI+GBb7pM5YJjj9RqtABUvj+rbq83+FPkNPRa+ou9wlV+D9T6ml8vDJleD8chY1WGVhxaFyckw1lb2SLN6XRbgdVkQsuCVX01gLfzS3gXFFJl/jCzAY8BC9oNn7JQHBqzM6uQvomPw3Sh5Wj+2eshBXCR5FQaSwpY8mK9JkvnAHEFBe6AG8D0/xrwPCAV8mMEobgd3CRJWWELae03E3MvKpXDYd7VnBXo8ZDZpBEk1VtlZNpYgpBmFDrGGGq/WjVd+K5GdJHca1XoWl2KqtudaFIt07k4ufDsdvzYEynvK4njTiinddeDIkW2nkC4xD6uAqdamQ7kq5Ggdo5dmRvtZ1Eh7388jx2YO4jB6d2pU/xN/xIqb/6oOI/gBFoSMDnsc2+IVo9TKAU/TkOJFAHdx50wI7THeNcfYzXAPeyi2UispNOvY69m1Ka2JLoef8CkgC+453APBnDpfRXNT2mh+OJuI+7flmYuRsZF9HdZ7XhYvp1bepUnOx0/IV00lZ4M8XYbifDqgrfJprX+kU9lhH4D7u9sOoppI2c+me0rEFvzGLZZ1Y4HmYy1S4FwW3FOtrrRmMR5vJsxcVDKq1jkcDVQXxIt/IBkS5rG4VQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnY4OHgyamZlSW1vc2dIejhwRTlVQ0RDQlE2ZlIzSEcvZ0ZpVG5rY2NpNzdr?=
 =?utf-8?B?Q2FyRExyaHpFMmV0YzJWckNtZ2REcTFuTnI0S1RLRVNYSFpobzhaMUJoK2xr?=
 =?utf-8?B?Vml5UDAxY2FzVTFvTFliV3hDOENSUmJ6WTFjdHhTRkk5Qm9Kb2pVZFBSY2Vt?=
 =?utf-8?B?OGdicWR2YU9BL0dESmtzalYzMW9xYU9GbGoxb0g5V0pNcWpVRGtERVQ3UTQ1?=
 =?utf-8?B?ZnhaZUlLNDJCTVllUks0QnNMd2gzTHFuZXZDdGE3Vzd1eVdhQmZEYUU3WXNP?=
 =?utf-8?B?QVdaMXhxL0xaVUJ3STU3NEFsZTNHZVU1dVhBdVJkTmo5SERJaU50cFZYaW9t?=
 =?utf-8?B?ZVpZSi9DQW5iV1g0M0VZdnpnQmhGNldkZDNPMjY5OWxOT1hxMTVHYUtmTWhM?=
 =?utf-8?B?Z2lERTl2aTExcnBkWlltMnVHNzB2dm5nUFdQa2MrM3psQUFPVEgyMU1sV2k5?=
 =?utf-8?B?ZEJ5YU5KOU9ZVittdi95MUxlc2hxSjBiWG1rTFk1K1gvdmdMNG5kNnF3VnF5?=
 =?utf-8?B?dFIrRlVsSlZZeCtUTVZRWFhwVnlITXh2cDR5bzdZWnBmWE9ueXFPNnhkL0xE?=
 =?utf-8?B?VzU0a2xVZUh0OTdXWnpYZlFtT3NYR2M1WU1DditGNXpMcjYrYUxqWTVMZnll?=
 =?utf-8?B?KzFjbjUxaUVIV2t1aGQ5WE8vNFg4U1NEKzVYSjVOdC9ZWWJYbjE5RXFqTjZk?=
 =?utf-8?B?S01sY2ZFNW90cm5lWUxiT2I4NTRZSmZjS3FJcVRYenNUVkN0eEpjWldXZTRh?=
 =?utf-8?B?dVphNkd6YmorZmJ1clNLaUFGVGliSGFwMmxTTEg0QlpMeFZVUE9oOUlwSVNa?=
 =?utf-8?B?QWRIRk5JRDcwSlRnbjlvUW9wQ043dkk1NnNtTldXMi9sRm9vUnJTenNBcU5z?=
 =?utf-8?B?NmtnbXNUcUpiVFJuaVkrcGZRQlZqSFpHQUNsZzI5b2tNY0IxVEFDdE42MFBk?=
 =?utf-8?B?UnpobjU4cDQxM0RxejFqN2hJSGdqZk5ENlFSdzVYN3ZNb3JWcmZsQXZ5ZzEz?=
 =?utf-8?B?ZUJuZUQvL0xLOGdZaHB3T1UySFQvbUYvMXRqOVpkVFErZ2RyU3BnSmF6THJY?=
 =?utf-8?B?cTZ4R1JtdzBRSTlUblNrNnAzMXI2Z3hlZjFtTnhnVDM3YThBRHdGdWxrOW5E?=
 =?utf-8?B?N3FoOWMvY2VabkNKTmtoNlVmZWdDOFBFNndDK2MvUzYrYjJVaHI5cFBEUjF4?=
 =?utf-8?B?NnBpeWFiazVVVGZJN3RDVHF2TC9lUjdOK3pubExJQm53VTdONGZuc0k2ckhM?=
 =?utf-8?B?YkIzSFk1cVllcU40b1czalE4SnBmYTVHblk5TFBJNXpRUjVOZ0RjSDJkZWJm?=
 =?utf-8?B?WjdtdE4vT2E4SU5XVW1uZk4xck9xT3YveHhXWHh2TWowWlVwZGZEY2ovcVlr?=
 =?utf-8?B?NkRvWmg1aDNSQ3QwZnpyb0NsNmpRZU1PUm1VRmdPdDRZTmtrN2Z3eFM3ZHhp?=
 =?utf-8?B?V3ZXaGlCQkVSN3pLS3RUQVZDVDV5WThKdzJTSjMwTGVHQ3Q3UlV6cmg1NU16?=
 =?utf-8?B?QTVLaTVOMXc2aUZIM3JHQlArNHZoYzJpTVc5Qk15eVQyZTZFdDRjMHk1Uk9w?=
 =?utf-8?B?bGlqaFFWL2ZuUnRhNlhKenAxRFY4U2pWVXdZbVZnMW1OOWpRSm01dW9BUVdN?=
 =?utf-8?B?UFhoWWMxallmZGF3V1A3RFBTeGkvZnArTmYyb0VBamtlZFh3bjNmdDd4Nnor?=
 =?utf-8?B?Lys3aFFnT3kyLzIvNEtkaVY5akZOVFVTcnJsdU44clBqUHowdzA0c1I3ejNu?=
 =?utf-8?B?cGJEWFRSWjVJWUFYY2RpOWwwdE11QmhVS0NQYzgxR20wK0FkMkVNRUU1SXB0?=
 =?utf-8?B?VXRrMk5tM1d0NTlxY1lrWWtkSTFWV0YzODhIY0ozRkZRY1dWWHY5K1lEZXRv?=
 =?utf-8?B?ZzVxcjBWU2thNWl2RUxNbWhCc0FGbjBERmEzTXA1T2tBRzhUYWFQNGxjSEI0?=
 =?utf-8?B?blljYmgvYm9ERzRab0NBTG84NFhHdnFxcjdmSFBPR2lXbnFjeTF5OVU5cXUw?=
 =?utf-8?B?TDRtQVhJWVJjV1ArUFc4MjJDKzZ3dmkrcXJxd210RG12YlkrTzBYY0xDUlY0?=
 =?utf-8?B?YmZrQmQ2eUoxdk1wYUFkcWN1V0l3QlRNMXFwei9GREJ2MlEzNmhUVUNiL1Y0?=
 =?utf-8?B?Sm9iUXk1VjdPSS9tT0FIY1pwZk5BTHFnK21uS2MzcjFlRUpPZWpsQnhiUGpm?=
 =?utf-8?B?UXBBOHE4eE1LRVA2WVZvOWM4cTJ3VlFKWVQyWVdraGRrajM4aExaclFyeWtj?=
 =?utf-8?B?U25vdTBYd2dUNHVBZExuVXBqeFU0dTRtL1FzZld5ZEpQYUQ4NDhkVGt4TlpS?=
 =?utf-8?B?d2NtanRXUm83TGFqSE1qekRRbTAwM2E3dFF5cFZnaFh4TlpGWGpYZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1cbdde-1816-49d7-2ca3-08df08ac2020
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 04:39:07.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qrn45xLajgD3fz7V5Fe7jIh2oJ1FLjW6wasEHju1RFKLUWtIZmDLiwqcqzGBbpWLFYlMwsLHvQANVmGX4n1QmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999326

On 8/25/26 1:30 PM, Dave Jiang wrote:
>> +                 range->hpa_range.end == hpa_range->end)
> I think range_contains() would work here?

  Wouldn’t range_contains() also match a subrange? Is it okay to treat a 
contained but non-identical decoder range as a duplicate as well?

>> +                     return 0;
>> +
>> +     range = kzalloc_obj(*range);
>> +     if (!range)
>> +             return -ENOMEM;
>> +
>> +     range->pdev = pdev;
>> +     range->hpa_range = *hpa_range;
>> +     list_add_tail(&range->list, &ctx->ranges);
>> +
>> +     return 0;
>> +}
>> +
>> +static int cxl_hdm_ranges_collect(struct cxl_hdm_range_context *ctx,
>> +                               struct pci_dev *pdev)
>> +{
>> +     struct cxl_hdm_info *info;
>> +     int rc;
>> +
>> +     guard(rwsem_read)(&cxl_rwsem.dpa);
>> +     info = pdev->hdm;
>> +     if (!info) {
>> +             pci_err(pdev, "CXL HDM decoder state unavailable\n");
>> +             return -ENXIO;
>> +     }
>> +
>> +     for (int i = 0; i < info->decoder_count; i++) {
>> +             struct cxl_decoder_settings *settings = &info->settings[i];
>> +
>> +             if (!(settings->flags & CXL_DECODER_F_ENABLE))
>> +                     continue;
>> +
>> +             if (settings->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING) {
>> +                     pci_err(pdev,
>> +                             "CXL reset does not support normalized address decoders\n");
>> +                     return -EOPNOTSUPP;
>> +             }
>> +
>> +             rc = cxl_hdm_range_add(ctx, pdev, &settings->hpa_range);
>> +             if (rc)
>> +                     return rc;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int cxl_hdm_range_len(struct pci_dev *pdev,
>> +                          const struct range *hpa_range, u64 *len)
>> +{
>> +     if (hpa_range->end < hpa_range->start)
>> +             return -EINVAL;
>> +
>> +     if (hpa_range->start > RESOURCE_SIZE_MAX ||
>> +         hpa_range->end > RESOURCE_SIZE_MAX) {
> Given that above you established that (end >= start) couple lines above, you really only need to test end here.
> 
>> +             pci_err(pdev,
>> +                     "CXL reset range [%#llx-%#llx] exceeds resource address size\n",
>> +                     hpa_range->start, hpa_range->end);
>> +             return -EOVERFLOW;
>> +     }
>> +
>> +     *len = range_len(hpa_range);
>> +     if (!*len || *len > RESOURCE_SIZE_MAX) {
>> +             pci_err(pdev,
>> +                     "CXL reset range [%#llx-%#llx] exceeds resource size\n",
>> +                     hpa_range->start, hpa_range->end);
>> +             return -EOVERFLOW;
>> +     }
>> +
>> +     if (*len > SIZE_MAX) {
>> +             pci_err(pdev,
>> +                     "CXL reset range [%#llx-%#llx] exceeds cache flush size\n",
>> +                     hpa_range->start, hpa_range->end);
>> +             return -EOVERFLOW;
>> +     }
>> +
>> +     return 0;
>> +}
> This function is doing too much. I suggest you rename it cxl_hdm_range_validate() and drop the *len parameter. And just assign len from range_len(hpa_range) once it's validated. I'll paste a diff at the end as a suggestion.

  I applied this refactor in v11: the helper is now 
cxl_hdm_range_validate(), it no longer has a len output parameter, and 
the caller assigns range_len() after validation.

> 
>> +
>> +static int cxl_hdm_range_request(struct cxl_hdm_range *range)
>> +{
>> +     struct pci_dev *pdev = rang


-- 
Regards,
Srirangan
