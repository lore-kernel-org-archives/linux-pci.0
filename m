Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8BECA4E;
	Wed, 23 Sep 2026 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121924; cv=fail; b=SXJ0Pvi2buVrH8qLJTUD/aMi14Z/bmdkkBhY48yEYSNwW2ZqhCENuShg1KxqsMCccDON514uolJgNl8vlR+EUxDwW01/gv7YGOUOHrjmTQeUA9jhcc7FzStxZCQFd6vD7/f0fMlJfK95nT8EnPnGdxFNc8TJXJ5+25eVs9AqrbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121924; c=relaxed/simple;
	bh=Uq3hRFpYBVeTaRAZ/XGPd4A0twXiK6E0qDEuDwaqkBU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iLEO8a9pKwER/y2r+TZTwmloqr6QE8TfiLxdXor/GlsV4VXkb0zF5zWpGzGR/nb+R9pSsRysmRRcL44/UPBpZiHul7SUXBYEy8UXpfttyqAA7G5IEHRGO9uMlzLkSJK4wiDd7ySITDh4OBFYCTxRgJl81wAfcS+T9G5kaM41h4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HViHJ6zR; arc=fail smtp.client-ip=52.101.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HViHJ6zR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFP+e/brQhS6t/rLhQKJJ4SKwLZWF8cl+C/NnDAqRKMxRFRzYjiqZXdW6Kj1CV6rlGnj/VACi8ZP9C47rlTvpRXeLw1MQtz8PPH9J4LSyaAIhUovbczN62UTGwIHW00nZm0/roHyuIIRXxH8eCHMad6vijptRnUf8x8kj0ImmsdVlOQW8sESx2+lvr4LLZFp8K7E0u+tNExmBf8mE4m008mXD8xIYjhnOZ6y1MSiIRoqBE0gTz9KI2dfmTxn5uBZkiAK9qNtWQ9PPvC8Mh/YtpCFhMQpMCesKi1b9pvml89WepuW0jx4eW2qbWmfgpagXWMuaKsdSOaF41HGi2lf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjN7e6myJwyWTG3+oog5DZ+zQn1GlGsUhHwD9UHKrzM=;
 b=AOLFF6aT/Y6KZraZAFvUqsEMUkbhj7DVY81CaZVeGPbDl54h3e+GZmX8fylDj4hRQaW7TeQlemA+hYEfHoHHdz5gq+wkKyrQMmhjttHhJ8aunLqMo6nlE3N++EDCYxnWwN8qEybFAMRU61dtdHXIgZvzBAooQuUmSlvhljpAqyCn681SBvOlPvDnWHU5w5oksPnBlKD7bSTqjf6qM9xe+OEa1SQ0xLmRjV0EPbiwMy7eONcpUKFWQFIfYdfKT7I8uA1e4NKs5yEBk/PQ/hwov/xDZaS4Fnm5p7vKAlJWuXRIdsFxLSD0K1lis1QZws5tAjN5qYZzUkvvQ8Fm5aQgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjN7e6myJwyWTG3+oog5DZ+zQn1GlGsUhHwD9UHKrzM=;
 b=HViHJ6zRhw0wnuQnKy8qMbt40MKILpHNyC+TGjCGhUCg+Ku0uaNc2Lkfl1p1Fp7ifi/9UEwQx76eR4gCvwVF1okxe7tQQOhZcprEZ6tmw/EpPOv3dQXHVICvir6ujfen65Giu32D1uVDyFcA0/rrOYwHS6vZkt5QfIo25Z1LDWlEghi67c018O3X2L0cDhtVfjaXdvZndL4+BbLChsXaUNpktOQl26XQIvsVIJbwRdOJgHwkncJEuDzI8GjJhTtmUvgIhO1154dyt8x3UKO3j3WRjaIW8MLO7gFtCZRCoWsfa+cOJWjBZe5QEom7E9fwyjb/H3Udvh21GvXd+wc/qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DSVPR12MB827618.namprd12.prod.outlook.com (2603:10b6:8:3e5::24)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Wed, 23 Sep
 2026 00:05:16 +0000
Received: from DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f]) by DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 00:05:15 +0000
Message-ID: <db24cd72-e504-4246-8225-aa455aceac61@nvidia.com>
Date: Tue, 22 Sep 2026 17:05:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/12] cxl: Add CXL Device Reset helper
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
 linux-tegra@vger.kernel.org
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-7-smadhavan@nvidia.com>
 <20260912022617.47860862@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260912022617.47860862@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0233.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::28) To DSVPR12MB827618.namprd12.prod.outlook.com
 (2603:10b6:8:3e5::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB827618:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b60478-e508-4710-6be1-08df19065830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|4143699003|5023799004|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	f57zwZET2O1QSyp0458qOZ2yrVkLk4e7988CirvG8Ks7SufSrseH7Db/7NH3CnM7IrwOkAl+t3BvkT72fjgFFWK9d7PFstFcX4dIhm3/ANU6EkkUiy9eKXF6XIWpYXOTJDdu5g0zDp8JjBM281z9xwqmlIjxdN2Ek6ChhyiMWkBIfIf6wZdxlLCyAp/ZoQT3Hw8z5LwD013c11OFlMFEeItr6A6RyeycYw04MGuA0CHeTfhu8GtNLfed4tw4HIiRzEPehibgWbe6MRPWHAioWbN0NVzDS/5rur6K61Lcx3v8yT1zq1i6Ap1h93vyeelL+NDNsbHbgIyBpi0jWS+q/v5xeHSzJmEX2iB5wr7YKWWBTx/6cReKNXyIM/i7q6yE8xqVqh2lANqQSHgfSgbzqh/SKB1sapTTbPLkPlScZtmMbcR3vDVW7YcA6Xehn05LhMCsB90gfWV6XXFWH8HSuXxQOgL4BOC3uDJ9AZcm+qsi42t7Ce5v2DoFXXDgFQ+0w5AsMjK1oZ+4JdQFxhu74GjSxvwaoV1H3P+4R/CQRxTbg2ZvemxH9yItRUdyrwvSF/Ig8snJuKiv8uU99dJwVpr4u1gYg/k84w9YDs8YuMzO8GIByy2lBVfh5O/ENxqJvND1bozeEVOAAzeLMGchJpnG7XagbX0aNIJaQfduD0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB827618.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(4143699003)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QThUNXI4QldqTDU0QjhsZU9JK1gzdHRaa3gzNTluZnRTZC9mSFhHTnF3V2pR?=
 =?utf-8?B?ay92ci95cU9XQzhUM0NsVVgrUys0dWtHSFB4MkVGQ1Zqc2RuTzE5aEhPbEwx?=
 =?utf-8?B?TkdlSzFmNnZRYlpwZmhnSktDQ0Y4U2NUU240WGRoM0k5VXRkODNwUXhiSTAr?=
 =?utf-8?B?anV5ZGw0M3FYR2hwdlJhbGx4b3pTMFpIYkp1a0l5V2J5R2hLU0VtUUxUd080?=
 =?utf-8?B?SlNMd2FocDJxS1dlYktTTERIMVE1cHlIbDNwbHh2ek5YQm1XalhKamNHTzVj?=
 =?utf-8?B?elBrUzNDZ1hvbTVBeSthQmk0eDVtN2dUdmdhaWN5aU1CSkg2SjBmcFZyKy9x?=
 =?utf-8?B?ZktUakhoaHp4SE9hWlp1RmJoZUlIRkhXT2xYR0orVjNDNTZ6dTFXQkd6VGlP?=
 =?utf-8?B?aWl2NnhnblZ4V1BFbUF5K2VnZGdiRG5tWVVIdHdOYi8xeXVNVUhzdk1HM3E5?=
 =?utf-8?B?cWcrejRMRlp0czM1QnJudHBTcGJZMUFRSmlhNDk0aUJHaVhSbW00Sy94L0xh?=
 =?utf-8?B?UEZhVU1FbFlSajg2clRDYVNZcUlJaXMwVDFRbkE4ejVta1d2ME01VWg5NVpo?=
 =?utf-8?B?bXVmNjRSdy9rd3h0eU4yOFhOZjN6SnFOK1dTUENCRXVNNHdLOGFzeGRBdG1Z?=
 =?utf-8?B?VHdUZCtzUmU1VGV6UC9jMDUzd0ZTYnlld3Q5TjVmMWxGUnNsQ1IrdFNSUjhT?=
 =?utf-8?B?VUhuOHhlVkxCMVZGcEo3SERkclpFMFVIY3pjemtrMWNXWityS3Q0TmZzaHl2?=
 =?utf-8?B?KzlUT2YrSjI3Qm5Vay9sNjhXWWNtOUZuRkNCekV2dUFKWE1EVjB5T0NjeDYx?=
 =?utf-8?B?ZWlVMHNtcTVwV2tVOTJYaXVWRUlhdmNNNUlVTGMyZWdtQWdCVFFJeE9RQlA0?=
 =?utf-8?B?SG8wOWlxMU11anRObFRTQjQ5SWkwTmhrZ3Y5Qk10M3dwSjNXdVR6WXE2L01R?=
 =?utf-8?B?V1RiUmRuYmNQcUUzblN0eEcwNjFSNGtJcnp2S1lidTM5Y01vMFVOTlU2Wm1B?=
 =?utf-8?B?emVtazQyTWRBY3NIS01JamVTQ2ZnSlY3TDY3Zy9rR2IzZTFlQk5GbzZLU3Zo?=
 =?utf-8?B?NnFrcVEraHM4c3dkQmhtNkYxU1owckVLQW14d04yZUdMRDJjVW9meDk5Um5n?=
 =?utf-8?B?MXRVYjBjcXpqWERSOHNnTG9GTU5nekcreUdwKzNiWWNjYnlXVVF3U0VES1Jz?=
 =?utf-8?B?OGxJZ0RCd0V5czNtSk96V0FGV2loTENxUks2azRWQ2RZUTBCbFNidUdVL3dQ?=
 =?utf-8?B?ZUEwdnhYL1ovR1RwQkhUZG04bEoyc3hMM1Vxd25HUUhaMWx0SlN2T3Z6dEdM?=
 =?utf-8?B?N1kwWTNpV3ZlN3UzN3MzS0dYb05qRjRkWmJBeHdyTUxZTnhmcDFmQnB2VmVV?=
 =?utf-8?B?emovbEdoakRZYnE2cnNEdUxOa1ZEK1J6cjlTVXlsSmdWcW5VUUhvYXFna0tX?=
 =?utf-8?B?VHY0MXdQa2FRUFZOVnZldEpnZzRkay81STE0aWZzUjRpUXJ4bnFJeFNvYVR2?=
 =?utf-8?B?T3hhZ3lFcEJGRjg3Z29DT1BGQU1MZnVTcm1ld0RWWmlreERHQVZBSUk3Nktr?=
 =?utf-8?B?dkZmSE9kbUNnYy9nMXNmcmFTMUhsUGlKTDE3MkN6RjNkRUJzdjZ5T2JLQis3?=
 =?utf-8?B?UHphSkZIOEcwR0l1NWtrOTZ5VmcrZEdEaGxXanFhaGIyZVhWZTFjN3oxaDYv?=
 =?utf-8?B?SjdRRDNqQVlqV3FLRFVQbENMcFk4Z1NwZ1FISHBBclZCMlVGbE0raHNhV3VS?=
 =?utf-8?B?R00yL2ZVSkZla3A1TkNTSWRvSWdCL3NRV1NKajZxaEsvdElGa3VLQlRXNm90?=
 =?utf-8?B?QWUrcWRtdUJRWGZRVW9QRTEzUDVyd2d1OUpCb1ZBelVQTVFUQWdGS1FRN0ls?=
 =?utf-8?B?N2luS3ZYOXVHVXpFNlJTVEs0K3FGOWpqUXlLQmx2UVozMFNydGNPRnJHbFpV?=
 =?utf-8?B?RVhNLzdSekFuS0IzN0s0RG9kY3hBS1B4dTlxWjd1bUlCN0Y1UisvK2VZQWxq?=
 =?utf-8?B?YWpjLzRBNHpTczNNVW1vbDJlWkdMOGcyNzRMYUtKMTB3R2krYTQ5bk8wbHU0?=
 =?utf-8?B?WHgxQng5aC9ZSktxamx2Qy9lVW5hclpxRTV3TVhhbUtjb1NjcE9yMzl0d0sr?=
 =?utf-8?B?MDdkTE1JSGdJaWh2QnlaUE1zczV3dVV6aGZPdjZMZHR1ZkVVUnhqeGtZamxt?=
 =?utf-8?B?TllUTTJDcmxKMUxVTzBnTXhGMWJ5MmM2dXRPdFRLaHVmQk14bE5Wb0FHSldV?=
 =?utf-8?B?cWx1KzFSeU15WjZqRzFWeGVQOEk2c05ycE5PcWdoTzYvZ3lYd1NYdGx4Q0d5?=
 =?utf-8?B?ZzhxM3p4dmpQTURVbGtab2ZmTjZSeG1DL3pBSVNra0FiK0h2NFNLdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b60478-e508-4710-6be1-08df19065830
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB827618.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 00:05:15.1260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJco+xJzJvXuW8X6+J4or2rcEPl/waPW7Ol34V1aXjv040cWzMihUrrOrZfKkusV5CGHXIG+8TEEVKqq5u2jTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781

On 9/11/26 6:26 PM, Jonathan Cameron wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, 10 Sep 2026 07:08:02 +0000
> Srirangan Madhavan <smadhavan@nvidia.com> wrote:
> 
>> Add an internal CXL Device Reset helper for Type 2 functions that
>> advertise CXL Reset and CXL Reset Memory Clear in the CXL Device DVSEC.
>> The helper disables CXL.cache, performs cache writeback when supported,
>> initiates reset with Memory Clear enabled, waits for completion, and
>> re-enables CXL.cache on exit.
>>
>> Leave the helper unregistered until range validation and reset-scope
>> validation are in place.
>>
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> A few things inline.
>> ---
>>   drivers/cxl/core/resource.c   | 251 ++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h             |   7 +
>>   include/uapi/linux/pci_regs.h |  14 ++
>>   3 files changed, 272 insertions(+)
>>
>> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
>> index 6d9f8fe14b16..9c1aa0800521 100644
>> --- a/drivers/cxl/core/resource.c
>> +++ b/drivers/cxl/core/resource.c
>> @@ -8,6 +8,8 @@
>>   #include <linux/export.h>
>>   #include <linux/io.h>
>>   #include <linux/ioport.h>
>> +#include <linux/iommu.h>
>> +#include <linux/jiffies.h>
>>   #include <linux/kernel.h>
>>   #include <linux/pci.h>
>>   #include <linux/slab.h>
>> @@ -492,3 +494,252 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
>>        if (rc && rc != -ENOTTY && rc != -ENODEV)
>>                pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
>>   }
>> +/*
>> + * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
>> + * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
>> + * initiating CXL Reset, then limits software to CXL Status2 access until
>> + * reset completion, timeout, or error.
>> + */
>> +#define CXL_RESET_RRS_WAIT_MS 100
>> +#define CXL_RESET_STATUS_POLL_MS 20
>> +static const u32 cxl_reset_timeout_ms[] = {
>> +     10, 100, 1000, 10000, 100000,
>> +};
>> +
>> +#define CXL_CACHE_WBI_TIMEOUT_US 100000
>> +#define CXL_CACHE_WBI_POLL_US 100
>> +
>> +static int cxl_reset_get_dvsec(struct pci_dev *pdev, u16 *cap_out)
>> +{
>> +     int dvsec, rc;
>> +     u16 cap, ctrl;
>> +
>> +     dvsec = cxl_pci_get_device_dvsec_cap(pdev, 0, &cap);
> 
> That is an odd function given the control read is separate - why
> should we wrap up the cap read?
> 
> I'd just drop this helper and open code the search for the extended
> cap at the few callsites.  A little more code, but less odd and all
> standard PCI stuff not needing an extra helper.
> 
> Probably a bit of code evolution caused this given you are up at v12!
> 
>> +     if (dvsec < 0)
>> +             return dvsec;
>> +
>> +     if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
>> +         !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
> 
> Why do we need them both? Sure that's type 2, but a non
> class code matching type3 would I think need the same infrastructure
> you are building here. That would have cxl.mem but not cxl.cache
> - I think some of the CXL SSD prototypes fit in this category.
> 
>> +             return -ENOTTY;
>> +
>> +     if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
>> +             return -ENOTTY;
>> +     if (!(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
>> +             return -ENOTTY;
>> +
>> +     rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
>> +     if (rc)
>> +             return pcibios_err_to_errno(rc);
>> +
>> +     if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
>> +         !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
>> +             return -ENOTTY;
>> +
>> +     *cap_out = cap;
>> +     return dvsec;
>> +}
>> +
>> +#define CXL_RESET_CTRL2_CMD_MASK \
>> +     (PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
>> +
>> +static int cxl_reset_read_ctrl2(struct pci_dev *pdev, int dvsec, u16 *ctrl2)
>> +{
>> +     int rc;
>> +
>> +     rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
>> +     if (rc)
>> +             return pcibios_err_to_errno(rc);
>> +
>> +     *ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
> I'd rename this. It is doing more than reading crl2.  Or push the code
> inline and avoid need for any name bikeshedding.
> 
>> +     return 0;
>> +}
>> +
>> +static int cxl_reset_write_ctrl2(struct pci_dev *pdev, int dvsec, u16 ctrl2)
>> +{
>> +     int rc;
>> +
>> +     rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
>> +     if (rc)
>> +             return pcibios_err_to_errno(rc);
> This helper is also providing little value
>> +
>> +     return 0;
>> +}
>> +
>> +static int cxl_reset_modify_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
>> +                               u16 clear)
> 
> This needs a rename because it has that subtle mask of previous
> state. What is it actually allowing you to modify?
> 
>> +{
>> +     u16 ctrl2;
>> +     int rc;
>> +
>> +     rc = cxl_reset_read_ctrl2(pdev, dvsec, &ctrl2);
>> +     if (rc)
>> +             return rc;
>> +
>> +     ctrl2 &= ~clear;
>> +     ctrl2 |= set;
>> +     return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
> 
> So with them squashed inline this would just be
> {
>          u16 ctrl2;
>          int rc;
> 
>          rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
>          if (rc)
>                  return pcibios_err_to_errno(rc);
> 
>          /* Comment on why this is masked */
>          ctrl2 &= ~(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST);
>          ctrl2 &= ~clear;
>          ctrl2 |= set;
> 
>          rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
>          if (rc)
>                  return pcibios_err_to_errno(rc);
> 
>          return 0;
> }
> 
> which is if anything easier to read.
> 
>> +}
>> +
>> +static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec)
>> +{
>> +     return cxl_reset_modify_ctrl2(pdev, dvsec, 0,
>> +                                   PCI_DVSEC_CXL_DISABLE_CACHING);
>> +}
>> +
>> +static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec)
>> +{
>> +     return cxl_reset_modify_ctrl2(pdev, dvsec,
>> +                                   PCI_DVSEC_CXL_INIT_CXL_RST |
>> +                                   PCI_DVSEC_CXL_RST_MEM_CLR_EN, 0);
>> +}
> 
> 
> 
>> +
>> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>> +{
>> +     bool target_prepared = false;
>> +     int rc, rc2;
>> +
>> +     rc = cxl_reset_disable_cache(pdev, dvsec, cap);
>> +     if (rc)
>> +             return rc;
>> +
>> +     if (!pci_wait_for_pending_transaction(pdev))
>> +             pci_err(pdev, "timed out waiting for pending transactions\n");
>> +
>> +     rc = pci_dev_reset_iommu_prepare(pdev);
>> +     if (rc)
>> +             pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> 
> Maybe a comment on whether this is even remotely safe to continue.
> My gut feeling is this sort of thing happens, just give up...
> 
> 
>> +     else
>> +             target_prepared = true;
>> +
>> +     if (!rc)
>> +             rc = cxl_reset_initiate(pdev, dvsec);
>> +     if (!rc)
>> +             rc = cxl_reset_wait_done(pdev, dvsec, cap);
>> +
>> +     rc2 = cxl_reset_enable_cache(pdev, dvsec);
> Can't we delay this until after the iommu is told things are back?
> I'm not keen on the sequence not being a clean tear down then a clean setup
> in the other order. I may well be missing some subtleties. This maybe
> needs some documentation.
> 
>> +     if (rc2 && rc)
>> +             pci_warn(pdev, "failed to re-enable CXL caching: %d\n", rc2);
> 
> What is logic about not printing if we have another failure sat in rc?
> Is it not true anyway?
> 
>> +     else if (rc2)
>> +             rc = rc2;
> 
> This code flow is less than ideal I'd use some gotos rather than that if (!rc)
> dance.
> 
>> +
>> +     if (target_prepared)
>> +             pci_dev_reset_iommu_done(pdev);
>> +     return rc;
> 
>          return rc ? rc : rc2; and some of the complexity above goes away.
> 
>> +}
>> +
>> +int cxl_reset_function(struct pci_dev *pdev, bool probe)
>> +{
>> +     int dvsec;
>> +     u16 cap;
>> +
>> +     dvsec = cxl_reset_get_dvsec(pdev, &cap);
>> +     if (dvsec < 0)
>> +             return dvsec;
>> +
>> +     if (probe)
>> +             return 0;
>> +
>> +     return cxl_reset_execute(pdev, dvsec, cap);
>> +}
> 

The fixes for these now are in v13 patch 10:
   - removed cxl_reset_get_dvsec() and open-coded the standard DVSEC lookup;
   - removed the separate Control2 read and write wrappers;
   - renamed the remaining update helper to 
cxl_reset_update_ctrl2_no_replay() and documented why command bits are 
masked;
   - abort reset when IOMMU preparation fails;
   - moved cache-policy restoration until after IOMMU exclusion is released
   - replaced the if (!rc) flow with explicit unwind paths while 
preserving the primary error.

https://lore.kernel.org/linux-cxl/20260922083924.2451158-11-smadhavan@nvidia.com/

-- 
Regards,
Srirangan
