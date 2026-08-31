Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010025.outbound.protection.outlook.com [52.101.193.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678933D1716;
	Mon, 31 Aug 2026 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168154; cv=fail; b=uXekt0vR89q5b+yXe8IoSADNWvXvph11QB6dTUS+aumxkLXkJ3JvOd/M9XUcqc/GIUXHliNGlpFFLmq7vJCNs0Md0bTE/qB4IU4aUqXADJbBLcUBOI0xIRwuZuDE/VntGTKynPXj2BFSLUW4kqcjc/UyxWRfJYhQ6FOFU0mheOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168154; c=relaxed/simple;
	bh=JWRjDngJcNggYMT7GL8pSucInNKp13xWQb/dIUO/H+I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JXmdn34MiSnsimk+WeTUzdaGoSkYxhPtqShQQjqDp75D9lacdXPR5AzgKG1DmKBFQ3u/rFMLd1TZVqf10UWH0ER9XFZonabWY36R5VUSE2A96JopMuxeOXFxbIYBursq1jYlWmXyYlcvffKhANHYXZX7nOU5DVVj+MdG8ivHM/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V5ZbgAP2; arc=fail smtp.client-ip=52.101.193.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V5ZbgAP2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt/RbaBBj3z8iZSdUgceeL67JAN64/NFTAu4w9uiTT/vgKHEXrICVjq5iD6SJfM2cxSwEIUjHC4N5Ku/QMbe7ERrs6DnCt/zv0DFXeSACydASEk6QF8vu5mgvbRMGoumq6IzC2NjYcKD4csrD9nsnYQUcHyGeDkPIB4RQRbJzwmqty8y4OZ5Dop42nDxKygiPSnYqxk0sBkabRJDrZrNLLn/sGK4YN2hrbLlNeA/PewwCj9bvFNRqFxFC/feWfQsNDnltZmlzQTj2ElEekF5sSS2wK1A6n1cZpMjZSa4Un4lv5L9hf2P0A2Fj9AD/TKB1IOU7arMRH/YQvGnJirudA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OQIdWWPE3rXsHQHKv8eHh6tan+5YEF4PAinAfTPPME=;
 b=ipMYj+UgPWwNdRlEeVT2RqxG0CXidDc6QhejRMJyiIeTyp399evzTEcw516vuE02n25Zt+nQ+B1JEYYn82n0c/gKOAOIEJlku1ZxMWolGv6+DSI+9cKAMah1aI8XN0tAO5+6XarCbF9eJBWvq1D2QjqMO/f6IaDIw5/Rc7e2VZqkpt7uAg4V1sEnlc5RGQK4XwlIA1ul16OzG8q6IXhnl2SF7EKUtOvA4F/SyDcqRPcYli19U8duDws3kUTR6VxBeeLLsqx9ZZbWiz2tdEo7nLZUqCUo9mM+qkVILG73isrHAmavq5k6E5/WV3gX+5+jhecuyZL1/oCVVkZlDQ/4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OQIdWWPE3rXsHQHKv8eHh6tan+5YEF4PAinAfTPPME=;
 b=V5ZbgAP2IYenjqtQ8b4UdL0evtqyOPty0BZ8cfLxBEe77d7D9NCyD+pDHOX0av6sAieyO2GQ18lf4MNFwmJofs3zWV4pejY+Gyur+qnj9loM4vV/kSH8WYLsyj6eWqjI76HTnkjNRXLckKj1sEL37PfM5Qu2apNB9pWlmaO/O/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB9711.namprd12.prod.outlook.com (2603:10b6:8:275::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 09:22:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 31 Aug 2026
 09:22:29 +0000
Message-ID: <783c4c15-b8c6-4e9a-96fe-451d7c3ea302@amd.com>
Date: Mon, 31 Aug 2026 11:22:24 +0200
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
 <39dc2f46-08c8-4eff-aa22-a7c67b5c7040@amd.com>
 <20260826140234.GE42790@unreal>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260826140234.GE42790@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB9711:EE_
X-MS-Office365-Filtering-Correlation-Id: a329ecdc-faec-4caa-6636-08df07416126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|56012099006|6133799003|11063799006|4143699003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	aGRA1dm8QGwKdJSM6gq5+axDCEMo9V7oWQQWqlC6GSjEFsKl0XNfJINUPnxGPZYOB5SlTANzSpJ7RTK8LX/lvjM5VQlyN00qv9mD8+huJmB4BRrMYddUC9G+UOUt3icNOxbCH0iCs5PvGFcuCMAc2+sJs0ZpeLKv2L8OKn2rU+Glg2jdQhc0zWT9sCOZBL8ukbjH9Y41fY0NF3g+0l1nYhet1zcJ6O9RPyedRe31gWQzLDSr7k7XM+e7HR1xupEveT9HeM1qDXLBP4/Gyntm6C6NcIY8Rv73OWpMK7NY5Ku/sH3uqbnq3yKSSsKKaizFj+KeNKHj7dJh/BnwskMv95+U/Mly/A8euu4MJCJgFvB0u+gSbevPafX3JXnROxAeP1dzJP6o4aqRCyj53Sg62HGmiswO4pvFXjTGXT/gj+6qbWLioAHLtUFLGrtnjq3QCvcqtEUo8IkOX1ZnMS2Xmc0dq1jlkzUwhJR3v1SeAzBwJHKNNEgz2+D7h1Ht9hjfyvW7ckQrz5hZIPil0szuZz4iq8wD6WkIFM7NqCU3pybGV3ySA5pFfUhGoCjp6qOmLrJyAw8rW9eRAAhs50S13a16XIssJd2SNYBcgq96uZQvaAR30b9kW2lqN3rdc4y/NBFQcwVMOpz1V5FabRB4OMRJpOfvl8EdA+duxV3Kd2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(4143699003)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWMvaWVOa3BXSGhxeG8vdEwwSWdPVGYva0ptWGZ2SGtKV2RLUHV0MmhmdjhN?=
 =?utf-8?B?VFRYMHh4NUk2SzR2blpRSXpXay9FSzcrVG95a3h3czN5N1N1NW1OeDlEOXpQ?=
 =?utf-8?B?NENSZHhvdldXeXozNE45bWRPVDNIL0lKek85VU9ieG9tY282Qm5rS0oxdHB5?=
 =?utf-8?B?VVhGOEVRa3hxRmpxYjFWYmxVVmJUMFNnaHo3bWozSjUvTitLZDU5dUVTRmtV?=
 =?utf-8?B?c01YRHdjM0FhQXlyeU9sNmpQTG5qUUs3ZkZ3cE1tajMwYWRoMUp0eWxvbW0y?=
 =?utf-8?B?SSs5emdyN2xUSUNIcTNTb2pBWVcxcEgwN0NNQVRpRXR0NzZCdUZzTCs0aHpy?=
 =?utf-8?B?NE41QXBxQWhkR1RDNENKRWRycmUzUm1EL3hqY2tEaE5hV2IrZTIyMlBrd0Zj?=
 =?utf-8?B?L3VYTGxXZ0VuTUZtenROY1lMMXdFNWRlYXRkckhXbTdZL3lvZldzblExZlpG?=
 =?utf-8?B?c2drbXArSVpZMlRBeGg0VCt6WUt2cGVRc0xJSmt1YklPR3hpT2krUjIrMlBM?=
 =?utf-8?B?dUFKQzFpZXY2YUtheGcxbmpHT2Vmd08zTXhyWHNqVnNMQTV4SWdCdXpmK245?=
 =?utf-8?B?OGhlbUYvWmJNcWdrbitlZGNzc0FTU3loUnBUdnhsazNIdUNFTm9tMUJoaVVT?=
 =?utf-8?B?MkdxczZBYlNvM0pQa241Q3NOelVXaTFObmpveGExK3NvL3dqNUZsa054LzE2?=
 =?utf-8?B?SjJyeFNyUXlZWDBucUtVQXBmdTZzVGxpU0FpcjBad2grNXdFVVZQaXJRdUxj?=
 =?utf-8?B?WTFDbUlCVld2WmV6TDk3aFI4eFZ2RnN3RDROclY2M1QzL3RMcFVTYllOelY2?=
 =?utf-8?B?cGpUMHQrOVlmMFE2UHlGNFNtellicFRxSjNXVTBNUyttdzJOM1JmRzgvWGpO?=
 =?utf-8?B?ZjFBYVg1eXdtRVRJRHN3UGk1MjJYdmRNMmNVUmNjRDJhelVHcGo4SnBpUDMy?=
 =?utf-8?B?SERzc0duOENSTUlWYTAweW9JelZqTFJ6MUtRMmxRclpTMHlUQ3doS1RmaCtD?=
 =?utf-8?B?WnhKYzU3b3hHRzJPZjlKYjI3Mm9UaEZUa3o0WFZvUEJNOS90dG43ZkplbUZO?=
 =?utf-8?B?Tmh4QzFZNXpaSnVvYWltSGJldUxBamgxeXY3SEtlZkxMMDhoVGJQYXhZN0VV?=
 =?utf-8?B?VHZubExFMUJVTTlIbTJ3aTkwZVVaRVVMZUlabGJMVlNxeXFjbXRtSXcrOXRi?=
 =?utf-8?B?STljZEZQRFFxMjV3SER2V0xYRFNOMGNtcG1IOC80VXJTcHZEVE51OXh5SWs5?=
 =?utf-8?B?R0R5aCtTaXhVZWRzcWx1TTFocSs2RkZ2dHpSWjJ0bmNpbmpTTEZpMi9SV09t?=
 =?utf-8?B?VkZTRHlhMW9wVlIzT1loWVRCL0Z4VEY2a1p0NzJXc01sNkJHM3g4ZTRSRmIr?=
 =?utf-8?B?YlBUVkxyQWQ0SU5aOW02UXZhNVBOUlVxMnJMeW55Nk14K0YzK1pNUmp1RVVk?=
 =?utf-8?B?SjdqK1NBOVhEQ1JLeS9jeWpDUDZWRE9GN0tjQ3ZWei9nTnd6eWhTVUV3VWRC?=
 =?utf-8?B?K3RKUUxmMUtLL2hmODBUNEFvblphVFB2R0w3bHIvdkM2WFRvNVRpeDdJMU1p?=
 =?utf-8?B?dlE1aFJnT0ZPaHlpcWlmWks1aDFYM0hQNVR6MENsTEJ5bHk2OVY1Q285R0Vx?=
 =?utf-8?B?NzVNV3VMbDVDR2hzVXU4UC84UUNhVlhtWWRyWTgyM0FvcGY4R2svODd5Q3FL?=
 =?utf-8?B?Slg3ZllaeEFnUFA1ZnQwNjhjcGViSFNwbWZwa21Jc3BTRHZDTjlhTUdmL3RE?=
 =?utf-8?B?b1ZQSk5EbVY2dGp3Rk56b0t0ZldJSmVIQkJkZjgveE9NOU5GS0R6bnllRmpE?=
 =?utf-8?B?SnFDOWdsVzZDUHh6RmRCT0dESkpLYmthSmVvNFFVQ2NYbkQyS3N0enJ2eWRL?=
 =?utf-8?B?Q2djcS9Ma0VqRTBJRVhXRmdZSU43K3d1TTFpVzl2eWxpS2Y1NTBkOSswRU9k?=
 =?utf-8?B?VGlZM0NRbDFSMUdsaFI0dHJsOGU2S2k3STdzTFlzV3g5OHhFTGpkYVhzNFds?=
 =?utf-8?B?dTdoeWFoR1NBRk51c1d6ZE40UFhwclluK1dma0xmNTdkM0RMdTJDWk5tS0Nt?=
 =?utf-8?B?M3lzMW0xV2xxUjJtNWhXVGd2RXduU1MySW5wdzNwSkdHdTB6YlArL3lKWXBy?=
 =?utf-8?B?WXRFR2tWRXFtd2tMSzNaR3NodVFQMEJQZE8xRVpWKzdzZ2RFRmgvclFpTjZa?=
 =?utf-8?B?dGxoZTl1Mmx3OGVJVVB2NlMrczJ2eStTUkdNblZxRGV4UnQ5U1pPS25nYS9j?=
 =?utf-8?B?SjhGcEF5V1lSZ3A2dmM5eVYxOE1mRnpKTTl1bXp0NkRwNzM1WlBqZFNHZVBW?=
 =?utf-8?Q?qOqosOPDns6q22LmgP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a329ecdc-faec-4caa-6636-08df07416126
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 09:22:29.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cjjc/ltInddXFffwCir+hMuxjVag3hqq4pioyE+jHhDgkMZdJmzvlmEu0/Mj76tX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9711

On 8/26/26 16:02, Leon Romanovsky wrote:
...
>>>>> + *
>>>>> + * Pinned flow:
>>>>> + *
>>>>> + * - Exporter: implement &dma_buf_ops.pin and &dma_buf_ops.unpin to hold the
>>>>> + *   storage still on request. An exporter whose storage never moves implements
>>>>> + *   neither, and dma_buf_pin() then succeeds on its own. An exporter which
>>>>> + *   refuses to be pinned implements &dma_buf_ops.pin and fails it.
>>>>> + * - Importer: nothing more. The mapping stays valid until it unmaps.
>>>>> + *
>>>>> + * Revoked flow:
>>>>> + *
>>>>> + * - Exporter: answer dma_buf_pin() as above. Call
>>>>> + *   dma_buf_invalidate_mappings() when the storage goes away and fail
>>>>> + *   &dma_buf_ops.map_dma_buf while it is gone. The two waits which complete a
>>>>> + *   revocation are described in dma_buf_invalidate_mappings().
>>>>> + * - Importer: &dma_buf_attach_ops.invalidate_mappings has to unmap within
>>>>> + *   bounded time and drop the pin.
>>>>> + *
>>>>> + * Movable flow:
>>>>> + *
>>>>> + * - Exporter: call dma_buf_invalidate_mappings() before each move, then wait
>>>>> + *   for the &dma_buf.resv fences. &dma_buf_ops.pin and &dma_buf_ops.unpin play
>>>>> + *   no part here.
>>>>> + * - Importer: hold no pin. &dma_buf_attach_ops.invalidate_mappings drops the
>>>>> + *   cached mapping and has to lead to dma_buf_unmap_attachment() within
>>>>> + *   bounded time. It need not stop the hardware, because access runs until the
>>>>> + *   importer's &dma_buf.resv fences retire. Map again before the next DMA.
>>>>
>>>> That is also not really correct. Those flows are not separated like this.
>>>
>>> How will you split them?
>>
>> Well you don't. Exporters and importers can have a much wider variety of use cases.
>>
>> When the importer doesn't give an invalidation callback the framework will call pin/unpin when the attachment is mapped/unmapped. That is just a service of the framework to make importers simpler.
>>
>> But it is perfectly possible that an importer which implements the invalidation callback calls pin/unpin manually later on. This for example happens on display scanout when an invalidation would cause garbage on the screen when the buffer is moved.
>>
>> But even after an importer called pin it is possible that the invalidation callback is called in case of a hot remove. Using our example of display scanout once more it is probably better to stop displaying anything then keeping the resources allocated until userspace realizes that the export is not there any more.
>>
>> The revoke flow is then basically just a special case of hot remove. The only difference is that userspace invokes it instead of an user pulling a cable.
> 
> OK, let me add some context on how this split came about and why I am
> trying to document it.
> 
> Several people approached me offline because they need to implement an
> importer that supports both revoke and movable flows. These require
> completely different implementations in the driver internals.

Thanks, that at least helps me understand the goal.

> So, to answer the question, we need to document how these flows are
> identified and how they differ.

Mhm, that's the point I don't think they differ that much.

Completely revoking is just a special case of moving the backing store to an inaccessible place and not making it accessible again on the next map call.

> Naturally, they asked AI first, but all frontier LLMs gave them completely
> incorrect answers.
> 
> With that goal in mind, could you please help document the dma-buf
> lifetime model? "Everything is optional" sounds great, but is quite
> misleading.

Oh, good question I have no idea how to approach that.

Regards,
Christian.

> 
> Thanks
