Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B934F49F;
	Wed, 26 Aug 2026 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749586; cv=fail; b=QNZ/TCVRGhOJoVWYlccxSP8BYLIM53brFF0nnEdItOAhDWDXnB5WhpK+0qlvVTlaE1C5sF47wSYqGCDCCsjxaQcn2fz6VEJeg7lf/125OjKBTkzBsp8pnFCdBGrvc9BGO/Sc/ML3x/ScVvvUc9eYyzvhD08gDzXnSttiFmQz+4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749586; c=relaxed/simple;
	bh=pdOlgsYXf9p9myNjCB7ChTzl0tsJzeilyXwhaKGZxrM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DYXHsRcM0wc3d2bqaF6Y3/Pq+3UnqUsGRLeyQfbfM/ecoy259d4ILM6A/4kRQthSDj1Gq5ckWeWdGL6sZv7+wOjSci4FobYFm9dmmFmB3Ko8xrnVataiWY75gQSfwEU9P1NmPwKMKAW4sRKx7XJvWXEfJgCxfqEzxJPls0Eleow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sbn+FDJf; arc=fail smtp.client-ip=52.101.57.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sbn+FDJf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x42XgTfZCxbCDM8VxtQjgHloC9Ti51+gxbSStoeCdJyISoeCXN4OgE9enNoABasut+4Z9QrE7/8/WSQomtS1H7AImQsw1HTf3Y40SSiP6q5IeKuteJTcW5mhZGKRbuTogl6BOvschc79W8hzIBlmigWtJ7/3VfU8kl4c4Uje94cxN2PAkzddQ+hHWJyiPGCOg2O6zKqL/C6TrRXb4B2pYX+QDEnd4prVsfLMF2Stw06aP4oIgt4l1PZfKPR90hx4QVMdg5zxh5I/ncnwNpyonb7SCVbNSnUlUWUcJoS8m2nq/HiLONbwRFnXjxmjsleeRIQZumyBhbytQU/mmZ+pZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CiDIPAscQJXANJ1mByZXeXQHma/xopfZkzD0pbLT2c=;
 b=zIykh1kfVDtvdgJi7ouI/okpU+DxxShikKnTrLIH6OgbNpL5bpibHuC4zgPObWLDp0Kfsbw8tEb5nddLXxUhBantts1gkI9Rs9o1HWJUnOZ3YnX6JhzLvurTYnjQ8UZisVdU6XUtOSqhZwtOz+skDFFbfbzKnNppPzIRQxxSa/XA8lGsEmRUVCAmgE1D7GBpzwAJIrpjydURfepyHPHl/TaPsbPKnAshtPxkqsRkgsfPfhHuaolD5wPJisKedV5RwYgQFLvrPL4v6aolGHW4wKtYJSj3PzbUo08vtp1RdMJp+PnDmIm4vmwSm+HC8crpq9Juq94aCNJEn0u13pG7Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CiDIPAscQJXANJ1mByZXeXQHma/xopfZkzD0pbLT2c=;
 b=Sbn+FDJf/8mAW4arg+tLfeUxcR25cFYSjfrqddxcwmK9UoWqdYRww/u4/XTvHdRm4Mp3AnJW40pfGL5atUrhrDalTZEc/nITbqVNUZRvwagbmd0BG+yo4xTTcB3Ba7nPDgpfuwLUK9D5D8gbTSoGUImxHdJ+3gbZyWM7DfHAV2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 13:06:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 26 Aug 2026
 13:06:09 +0000
Message-ID: <39dc2f46-08c8-4eff-aa22-a7c67b5c7040@amd.com>
Date: Wed, 26 Aug 2026 15:06:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma-buf: Document how exporters and importers agree
 on mapping lifetime
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe
 <logang@deltatee.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
 <2776f9b0-c299-45ff-bf82-89b95e73fd60@amd.com>
 <20260826124341.GD42790@unreal>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260826124341.GD42790@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: 742b891e-36db-4179-7864-08df0372cbfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|11063799006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HUgRAM+M0ewS3c4G7epsW90lphbcJKlSltWWsuvHu3rfg9qUTAe/KYhJH0KlrsceepNlFRVe37wPw+Gzdj+RK+5aIqlQSN0G8lGkycGr3qQuLd4jEAFwMYmOdHE661wRlxcUkZ2fn4bwCmupCw7CmHicYHc1t67Ru3WLQgaIlf0xJTlBZWtquBKNRMAc/mTPx9R6U+f3jNH4PyqyYhwR4TAMSkORBu0a/TiSCU7ZmYtTsWr2d1uR4uLJ/xNq8PF4b0TUzOU3UeuWvGVSAR2D1teVQ7wDDiws4c9PcXKJyh7fHm16ZU6rPzaGIRUbTa9yjV0Qg7w3lxLCU7kVnxYJpIqkk6yuRzvW/L3foZAn9jEY9A/UW4YaK2g3wjzHqGqWvcwktjMQwyTZiSw+SbOK0X5Z+Ls39qmAyGUBuVTa6tC49tc+S7QBXK1TadpKfLwGgJvr4rcaM8VBerJZ8TjLgVO0AOMUxg9OWPid14LNLzze5AKER5af4bByNzXfjvzgZMHSGwD9jc0n0MBbF2ajELGS8XpXCI3fQXGWCGMpUwltLg0jvTQvg4b2JoHKbE5HqsErK8SCtdqLejn64EJneCoZtbp2k/7iJ7MH23aXxLRdETwJXiHr0ZrtTSks9xnIuizWSC0TX+KmU0tIR2mPvoEzC3emomQSpZv2RMHm0l8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amlLZTlnSVJveGlUQUhyQ09tV3o1ZjQzL0duR2Z5NkF1V1dlNjlpZndYTWJT?=
 =?utf-8?B?R1hKS3lRQWtwQWtuVkh5VWwwck1KbEtSbDBNSkZWTFprRFNPNzErRmU5ZWRW?=
 =?utf-8?B?WXhSY0xQSDdWZEpQNHh3enBWVTg0dlExMDZJVW0vaEFLUE9qc0RjRCtydmRP?=
 =?utf-8?B?QnJ6dDlndGVMenVucXVFcTdiZmxwZ2kxN2d1bERzSmc4T29NOEFxd01hc1R5?=
 =?utf-8?B?ci8yYnYvN0VKcENla3B6KzN3ZkRUNUQ2QkI0ck95YXluQWszTnZtR2gyZWg3?=
 =?utf-8?B?N3ZGMncxQW4wWVNHSktkR3JCQk1IRWdUaE83cTlZZHFVQmpKMU1ZazRCL0lF?=
 =?utf-8?B?SXNMaXdOM1pEUDlvcHBjV2drRU9lZkJDcEhmRnpyL1UxUDJzU3pSclQ3ZTNN?=
 =?utf-8?B?SnFrU25hK0lvb0VRV2JtWk9qN29aWEViZWRRbDkwcnBoNmV2U3ZOYWpob3VX?=
 =?utf-8?B?ZjhERzViOFJCSC9yMSswZzl6RHBvaWtmSXZNMVViLzNMZHY0ZWN6eGJRMTVp?=
 =?utf-8?B?K2h4S0diaklVRG50Z3hsRDJSYW8xRENsNktPYlMvWkpwYlNoSklFN0ZSQVdk?=
 =?utf-8?B?UVM3cmhOVS9MbFJwWjRGa0lIM1BLN2toRFU5MnJ3UUtTZVM2bjBJbk45Z2hK?=
 =?utf-8?B?WGV6NW1SeGN6TitqZmcreUhKZ2ZpWDZaMTg2Um55OWZLKzlpUkJHdng1SVdW?=
 =?utf-8?B?RGY2dkFuOC83RWk0NitsV3AxOHJyZWxlUzNzT1orb09wQW0yNElHTTJ5eUJD?=
 =?utf-8?B?dmRWWjB6eDh0WS9zaFZDRVVSVHQrZ2Z3a1U1UitFNktnRVJiMWFhUkk3UlB1?=
 =?utf-8?B?RjJRZjFsMjQ3U2xwRzlPR3A4bWNkZUltaWEvcUtzejRhVHVNRGJIaDBJekE0?=
 =?utf-8?B?eDQzVmhLdHZOdUt1RTVma3BPYlZGL2hBUHFCU0lqK0VILzB0ZC9yQVJ3emw5?=
 =?utf-8?B?VmsvajRaakp4R3Nrd0t3UnVVeEVHbEpXMjlVMkpFaXRueGdwWm9lSStOUzgx?=
 =?utf-8?B?cUF2QjM1TUlTclcrRmdPdTZudytLb3p6RVlaWk44eEZtS2Z0VmVMd2J2L0JN?=
 =?utf-8?B?N3Y3OG9EZ0NWRVJTc01Da1UyTlFJOTVwYW5GSENpMnIrYm5QMk1vWUx5WlRt?=
 =?utf-8?B?c201TDYxWUVRVmUzb0tyK0NVQXdGZXU3MWVYSmVpYU9xbHlFcXBjdUVlREJM?=
 =?utf-8?B?alFDcEZUcTVJMWRoMWhJbHZXVDdaQzVlTlJvZE9QYmdIWDZXamRNd0dSMXFU?=
 =?utf-8?B?eCtBUnpYVFllSERaVVZqb1YyR2ZOaVlCY3g2WmEvSmljZkZNU0lQN04xNGx4?=
 =?utf-8?B?bUJpbDUrNW9MWTJuaExwNG9Fd2d2R0FQaHUwSUUydVl5UEl5OTBlTmlrUThk?=
 =?utf-8?B?Z2h3dGtLdWhCbXFZa0trNWNXdyszWUx0MlpRblNSM2ZDUjNoSkJRdGQ2eW5x?=
 =?utf-8?B?MnJwVjE2UlBVbzVVZjk5VFVmd05iWGxPdlNoN1pncU1OeVRxaEhJamJkS2tP?=
 =?utf-8?B?K3BwZkdlVDBqRXBQb3Zxb2d3bHdnT0tXdnBMTEhmZzlJb200ak45alh6Rlcr?=
 =?utf-8?B?Vkk5c0hqbitPNTFQRjVUVHZ5cGI0YlBzcEdUUUFuV1ZpNUg1Mkt6akFPcGFB?=
 =?utf-8?B?akcyYXRtOGQ1cWYrbVF2cE5CaVRpY01QZjB4a3E4RGw3MDQwQm90bnZld3dQ?=
 =?utf-8?B?akFhaFFjeFNUa3IzNm1JOHArQVlJcm1sUll1L3l6aW1HVG9hNFdQbndlK0Zz?=
 =?utf-8?B?N2NJbW5EQmwvZ01aQytGNnlxcW5sRWVFUGFrRndQVTNBeXBwUG1DQnFvZGFF?=
 =?utf-8?B?TkxnUVkxeWczSFA4MFlVZ1draUIwQ0k0UEsxVzZyc3diZkFGZmpPOXM4Tjh2?=
 =?utf-8?B?Zi9raXRYaTFuZVp4ZlJqUXlCRUZmMlM3V3pHVzhBY3RJNE1Oazkxa3JQSThD?=
 =?utf-8?B?NW9xS3RwQlJyZitiVzBMbmtCWnpLbEE0VlNiakRmOG9RSVhZM2NMWXVsQWF4?=
 =?utf-8?B?bkRnM0s3T2RsTTE4WWxPUnhVYzFKeTRKSEU5U3A3ZDlvMXoybzdtWkpkbWF4?=
 =?utf-8?B?ajk0czNTeWpQRk5sWXRITnNuTFRZOHRqbWN4Y3VLOUxjNUt3LzdnNStoWktT?=
 =?utf-8?B?VVZEckJpM3U3NTFoWDl6eHpLU0RmV2p0ei8wV2lRc1pmUlFhQ0R2MHRTeExr?=
 =?utf-8?B?WDNJTkhXRVVQZ0RjSmprN3IwSEg2aWxnK2FtaHI2ZVdGRXNjUTF2RXhiS0RR?=
 =?utf-8?B?a3poOTdWVEFRV0h2ZldlUnNJRVoxZkRmZFFnYzAyc0R6YTZab3NEazdRV2hP?=
 =?utf-8?Q?TEFYOsZNLQAemAczGD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742b891e-36db-4179-7864-08df0372cbfe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 13:06:09.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZSbZBFroCz9KPVWnVWm3EQNOiKDl2+J8JFGL8YPTg99xbvUhMjR7uMcT6k9b11t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6

On 8/26/26 14:43, Leon Romanovsky wrote:
> On Wed, Aug 26, 2026 at 01:41:51PM +0200, Christian König wrote:
>> On 8/25/26 08:28, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>
>>> Pinned, revoked and movable mappings are selected by which optional
>>> callbacks each side implements and by whether dma_buf_pin() succeeds,
>>> not by any flag or enum. Nothing in Documentation/ says so, and the
>>> rules are spread over the kdoc of dma_buf_ops.pin,
>>> dma_buf_attach_ops.invalidate_mappings and dma_buf_invalidate_mappings(),
>>> so a driver author has to know the symbol names before finding them.
>>>
>>> Name, per flow, the callbacks both sides have to implement to end up in
>>> it, describe dma_buf_pin() as the runtime negotiation, and record that
>>> the pin is what tells a revoke from a move.
>>>
>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>>> ---
>>>  Documentation/driver-api/dma-buf.rst |  6 +++
>>>  drivers/dma-buf/dma-buf.c            | 85 +++++++++++++++++++++++++++++++++++-
>>>  2 files changed, 90 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
>>> index 2f36c21d9948..39c201f38aa6 100644
>>> --- a/Documentation/driver-api/dma-buf.rst
>>> +++ b/Documentation/driver-api/dma-buf.rst
>>> @@ -113,6 +113,12 @@ Basic Operation and Device DMA Access
>>>  .. kernel-doc:: drivers/dma-buf/dma-buf.c
>>>     :doc: dma buf device access
>>>  
>>> +Mapping Lifetime Negotiation
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +.. kernel-doc:: drivers/dma-buf/dma-buf.c
>>> +   :doc: mapping lifetime negotiation
>>> +
>>>  CPU Access to DMA Buffer Objects
>>>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>  
>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>> index d504c636dc29..30afec7365bc 100644
>>> --- a/drivers/dma-buf/dma-buf.c
>>> +++ b/drivers/dma-buf/dma-buf.c
>>> @@ -684,7 +684,90 @@ static struct file *dma_buf_getfile(size_t size, int flags)
>>>   *    reference acquired with dma_buf_get() by calling dma_buf_put().
>>>   *
>>>   * For the detailed semantics exporters are expected to implement see
>>> - * &dma_buf_ops.
>>> + * &dma_buf_ops. Whether the exporter may still move or destroy the backing
>>> + * storage after step 3 depends on what exporter and importer implement, see
>>> + * the mapping lifetime negotiation section below.
>>> + */
>>> +
>>> +/**
>>> + * DOC: mapping lifetime negotiation
>>> + *
>>> + * No flag or enum says whether the exporter may move or take away the backing
>>> + * storage while an importer holds a mapping. Each side implements a set of
>>> + * optional callbacks, and dma_buf_pin() settles the result at runtime. Three
>>> + * flows come out of it:
>>> + *
>>> + * - Pinned: the storage never moves and is never taken away.
>>
>> That's not quite correct. The backing store can still disappear if the exporter is physically hot removed.
>>
>> In that case the exporter will still try to invalidate the mapping even if it is pinned. A NULL invalidate_mapping callback is of course still never called and so still optional.
> 
> But what does this mean for an importer that has no idea the exporter no
> longer exists? Will it crash? I think the revoke flow actually fixes this hot-remove case.

No, that used to work even before we had the invalidation callback.

What happens on a hot remove is that the exporter goes away but the driver stack keeps PCIe BARs or system memory resources allocated until all importers have destroyed their mappings.

See the invalidation callback is only optional, importers can implement it to speed thing up on teardown but they don't have to. A NULL invalidation callback is perfectly valid.

>>
>>> + * - Revoked: the storage never moves, but the exporter may take it away.
>>> + * - Movable: the exporter may relocate the storage at any time.
>>> + *
>>
>>> + * Every exporter implements &dma_buf_ops.map_dma_buf,
>>> + * &dma_buf_ops.unmap_dma_buf and &dma_buf_ops.release. dma_buf_export()
>>> + * rejects an exporter missing any of them.
>>
>> I think that this is superfluous, the check in dma_buf_export() should make sure that all exporters follow that.
> 
> Sure, will change.
> 
>>
>>> + *
>>> + * An importer reaches its flow like this:
>>> + *
>>> + * 1. Attach with dma_buf_dynamic_attach(). Leaving
>>> + *    &dma_buf_attach_ops.invalidate_mappings NULL rules out everything but the
>>> + *    pinned flow, because the importer can then never be told anything.
>>
>> I would rather write "Leaving out the optional dma_buf_attach_ops.invalidate_mappings callback pins the buffer while the attachment is present".
>>
>>> + * 2. Call dma_buf_pin() under the reservation lock.
>>> + * 3. On failure run the movable flow, or give up.
>>> + * 4. On success the storage stays put. Whether the exporter may still take it
>>> + *    away, which makes this the revoked flow instead of the pinned one, is the
>>> + *    exporter's choice and is not reported back.
>>
>> That sentence sounds not really readable.
> 
> I will try to rephrase in next version.
> 
>>
>>> + *
>>> + * dma_buf_attach() is the shorthand for an importer which only ever wants the
>>> + * pinned flow. It passes no &dma_buf_attach_ops, and DMA-buf then pins around
>>> + * every dma_buf_map_attachment() and waits for the DMA_RESV_USAGE_KERNEL
>>> + * fences on the importer's behalf. Peer to peer needs
>>> + * dma_buf_dynamic_attach(), because &dma_buf_attach_ops.allow_peer2peer lives
>>> + * in the attach ops.
>>
>> That's also superfluous.
> 
> Will change.
> 
>>
>>> + *
>>> + * Pinned flow:
>>> + *
>>> + * - Exporter: implement &dma_buf_ops.pin and &dma_buf_ops.unpin to hold the
>>> + *   storage still on request. An exporter whose storage never moves implements
>>> + *   neither, and dma_buf_pin() then succeeds on its own. An exporter which
>>> + *   refuses to be pinned implements &dma_buf_ops.pin and fails it.
>>> + * - Importer: nothing more. The mapping stays valid until it unmaps.
>>> + *
>>> + * Revoked flow:
>>> + *
>>> + * - Exporter: answer dma_buf_pin() as above. Call
>>> + *   dma_buf_invalidate_mappings() when the storage goes away and fail
>>> + *   &dma_buf_ops.map_dma_buf while it is gone. The two waits which complete a
>>> + *   revocation are described in dma_buf_invalidate_mappings().
>>> + * - Importer: &dma_buf_attach_ops.invalidate_mappings has to unmap within
>>> + *   bounded time and drop the pin.
>>> + *
>>> + * Movable flow:
>>> + *
>>> + * - Exporter: call dma_buf_invalidate_mappings() before each move, then wait
>>> + *   for the &dma_buf.resv fences. &dma_buf_ops.pin and &dma_buf_ops.unpin play
>>> + *   no part here.
>>> + * - Importer: hold no pin. &dma_buf_attach_ops.invalidate_mappings drops the
>>> + *   cached mapping and has to lead to dma_buf_unmap_attachment() within
>>> + *   bounded time. It need not stop the hardware, because access runs until the
>>> + *   importer's &dma_buf.resv fences retire. Map again before the next DMA.
>>
>> That is also not really correct. Those flows are not separated like this.
> 
> How will you split them?

Well you don't. Exporters and importers can have a much wider variety of use cases.

When the importer doesn't give an invalidation callback the framework will call pin/unpin when the attachment is mapped/unmapped. That is just a service of the framework to make importers simpler.

But it is perfectly possible that an importer which implements the invalidation callback calls pin/unpin manually later on. This for example happens on display scanout when an invalidation would cause garbage on the screen when the buffer is moved.

But even after an importer called pin it is possible that the invalidation callback is called in case of a hot remove. Using our example of display scanout once more it is probably better to stop displaying anything then keeping the resources allocated until userspace realizes that the export is not there any more.

The revoke flow is then basically just a special case of hot remove. The only difference is that userspace invokes it instead of an user pulling a cable.
>>
>>> + *
>>> + * The pin tells a revoke from a move.
>>> + * &dma_buf_attach_ops.invalidate_mappings carries no reason, and both flows
>>> + * ask for the same unmap. An importer holding a pin can only be seeing a
>>> + * revoke, because the exporter promised not to move. An importer without a pin
>>> + * treats every call as a move and maps again.
>>> + *
>>> + * A revoke need not be forever. An exporter revoking around a temporary loss
>>> + * of access takes mappings again afterwards. Giving up for good is the
>>> + * importer's own choice, so an exporter must not wait for one to come back.
>>> + *
>>
>>> + * &dma_buf_ops.attach is the only place where an exporter can turn an importer
>>> + * away. An exporter which revokes rejects the importers for which
>>> + * dma_buf_attach_revocable() returns false. An exporter of memory without
>>> + * struct page rejects the importers which left
>>> + * &dma_buf_attach_ops.allow_peer2peer clear.
>>
>> That is also not correct. A mapping can be rejected later on as well.
> 
> In API level yes, but I'm not sure that failure in map_dma_buf is equal
> logically to failure in attach. So, I won't call it "rejected later".

No, exactly that is wrong.

See failure on attachment means that the two device can't talk with each other at all. But that is relatively rare, the dma_buf_attach_revocable() case is the only use case which comes to my mind.

The more common case is that while mapping the attachment we find that the buffer location is not accessible (any more) by the attachment because of hot plug or simply resource contention.

IIRC -EBUSY is even documented as perfectly valid reason to fail a mapping.

Regards,
Christian.

> 
>>
>> Regards,
>> Christian.
>>
>>> + *
>>> + * Userspace sees none of this. The two drivers negotiate the flow between
>>> + * themselves, and the DMA-buf file descriptor shows no trace of the result.
>>>   */
>>>  
>>>  /**
>>>
>>

