Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B8F3CAA2E;
	Thu, 10 Sep 2026 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024676; cv=fail; b=lv+sw+zsqUg3gDjix87Tum/kpOGeaffvIYcF7AwaJhxRo9U8iFBhmsWF2/vQuajxAsrgv0bRZR7Qgx3R3aznEqAXcUfWCZLQXT7bZzeDqD4S99sBHWtwUw47uKKSW8ocOccEcq7YD4Dehc3j9XnUkwZBjbW1poJbgK8lktrRry0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024676; c=relaxed/simple;
	bh=OaWHUmlHU9XPJ0vmyWiTlp7s+6cRks6/QoxtrQr04HA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lXvNqu8Xhr989oQePw6u6ykZTLPRnv+JID6HeDZxq9LI2xIBa9bNZg/UQ+yjlzjEm3NlbwvSZ85fK0btZ0fKGqTJ8HLMLkn1CKqh9eNATY8NK36OYn6FyA3YMoknM6FT//mUm4NgQesMrjBMTgzHyXaWQFiCk2XUa80Cf3GJBJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K1rpHiVD; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K1rpHiVD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6Q7/Ei8XT6xEY2g+fODt1e8KorfQ2noG4DzOpN/a3FKIlNdj8aZKzM+8miu3MAIfbVFmR81c8+5Z8qqJqMbMI7YeI0nun9CGaXqfh/dB3UqJffavxbxAwB/5I7v8nQ6WhsWUGVZJVyo88LZ5c5RAQhSzgqgSoiGyZWKkDtSaoJGnOhNymF+bvFkDt5BL8NeSa6FyEksW9ii6TyxNLTg95jDK3Tog6uJmVio+hYmNkJbDwIzm01MUF5PABK/GBjjoPLTKHoCEkrOrW/DedlzBnO35mkmGHXqglv5U2shYi1xof505ApNriVrXTBLsJhNzpxdh9fH2VY4hZ3BEhbH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ov5d6R8RZo7jXDbyq4Rj5LBg8132SAhKIyy7l/HUJDc=;
 b=CqKdbw9iR7WpQmRP8kxP5rARNT7UwJpDLujAU0AGl9ruzuDTtz7rlna0+1DLko8tALQuO2AHP3cSWwA21YK9os+I/NbgN3ZCArErYuQpzMWPdWDHkUeaRIf3JFhL1AtmIqjjKgtFXsiEuQzA7uXS9gmXwCN5nLjRgorvU01ktNoAX3NQy8PdD75XA3f7Dlh/yneoVRuHTQzux2Rvy0lswbXZFvszw8G4M9caEhD/UKfsEgYVydPmRWpWXb3z4gtJQV42+Z056LpifSC5OtTuCHggMXfyasbKjYhgxGMr+7Z7IV+lx5Rplhxy9LP4FARr8wAgKVN9bmZgYIjfmooEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ov5d6R8RZo7jXDbyq4Rj5LBg8132SAhKIyy7l/HUJDc=;
 b=K1rpHiVDpYTm9FvBF7noLgizXRWdGCkGYvu0sN7Tfi08LCMSn9fofZJT28RsTruXiIO4v+e6UOKopY5y3RuR9VxodjswmP8we+8cNSvaNA4+7iV1KJ6iAJK/nh71zpaVWth6hA6zg0s/gxmowzTIySL+ww3N8TtPbGQCRbji86RkbuScMbvU9by9sn5Ak1Uo04PGOkFO6dZl42qvizgZathWkRt0dK7CTdjEexqsXAz2Ds7oZomHQCb2qYB64Q4nNsEV5MqQEmR2AoWsXgEEzZRjcIHcrtB71lheQL8T07rMlcadkYQR5AsBgNNeveuD8b/Ji0sRIkOon5aI4uGYNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:17:50 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:17:49 +0000
Message-ID: <fb128492-aaab-4db6-98db-55c082865204@nvidia.com>
Date: Thu, 10 Sep 2026 00:17:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/12] cxl: Cache endpoint decoder settings during PCI
 enumeration
To: Li Ming <ming.li@zohomail.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-6-smadhavan@nvidia.com>
 <08d97766-d62d-4901-a413-705df0020d22@zohomail.com>
 <58a876a1-7569-49d9-94bb-d090c8acd439@nvidia.com>
 <d1eddf2d-43db-449b-976a-d70227210061@zohomail.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <d1eddf2d-43db-449b-976a-d70227210061@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::28) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: fe00e5f7-c725-4112-f0ac-08df0f0b9f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|11063799006|56012099006|4143699003|6133799003|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	PWycO9QRPGFXpmFomBMAw6CSf2CagAFP59oxqOK+YZDJHExWDOYLIBln49TuWC+TH0OF/VpAcFesosKKfvEZAqeXeIhAhLGd97qyaR3NeLapiJubvwmAjh/oz4OJaYxGlZc/NPWvynrcx/NXfBx3VMjBuvNYXozWP/mSDBaRTY/9Dc7dxgDsCEA7CYjDPTD9vkZN/oqaP5xMRvuP03Kec02NRoIwAidB1kWxE65k9VWaXu8JVN5eGFU5qG+Gbp7By9hpwVSGmanoH0uUkzf6oMdUuyi+3WgbKam2CXX2wED08OwRWg0BSjScz6rcdzfu1AhMTi6WrvBMk+JooJv0zmXLgVZzpswy7DQq81KNphmfZVuaFDFFNrHLIBcEuR0mDGpr+rv8WiKJVn2ZMP2yh8VhCjfi7C5vnlLeLe8OWiAO6sRtjQtBetFXqZXha97Gdre6IERjUwP6guyDCRzCzH/avtClp7gyaMBR21FP7qSCtnetOaIrE0cBeLRk6N0DrrCw1JpQjyH6B32X7cDLPVLQikIwPQUxqGkI9k75+4u1z84ZgqACuLNjrWGliwOQYaw72mpq0RB4S4XEwEaxVSTy/3UOxCMPz+V5RMZdjon+vCokkodDQ3i883d85MJWufv7EHNcmOIeML2vbB4VFT+ZuIv8NKrRwHtan13EEcm6qVOSRxjOEm4k8IublxNBlOdm6GRyFPoaoIn1fIaXYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(6133799003)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2Z1Wi9ib2tSMlI3SmlNNE9rUW5kdTlWWnFSMm41NkZndmxJdkVORzR4cjV5?=
 =?utf-8?B?OVMyQVdsUUlBdjNvMlV3czJvOVIwM1hzOTV0ZFFuWkpJem95T3BveEZnTk5L?=
 =?utf-8?B?V3RQTTBBdXRRcHZCeWUrckE2ZlYvMDAwQ2ExeWVCTUJ4enA0b1F1U29BQlpZ?=
 =?utf-8?B?aGRBNzczaGhYc04vZzdWeUtzVkpzbzZ0ejlPSlZhSTBUOHUyb291Q1FteFBN?=
 =?utf-8?B?aGg5RlJDaGZqaysyZlRoUFBqcHQra3NDSUs2ekM3dEk0cTZxTzMxak1iWkpS?=
 =?utf-8?B?azBJMVJrakozaXRhODlPT3hyamNQOE5uWlZ0dkl0SCtLVTBMYlo3Q29OSW5S?=
 =?utf-8?B?UUJ0STA1bVI0enFsRERTcnJTQ09qUTlxNUEyK2hER0FYVndYd1lEME0yeWNs?=
 =?utf-8?B?Y0Rqa0psRlpLMzRWZG1BVjBjTkpVRjZzdndYRE01bTk4dEZvN2hWUlBieVRx?=
 =?utf-8?B?M0R1a1NrTTNXTTlBaWVDU1puR00vWTJvNjFYWEZkNTRqT2lhWkdXTFF6TGN5?=
 =?utf-8?B?ZlN4NjlNWVBQVmFGaTdUMm1VQjZjSzkvbDFiRFVIalB0MlFGelJXY0NLNXdC?=
 =?utf-8?B?Qnh6ZDV1TE91YlBGOGxsR3JkRTB3QjZFbHFNQzJNSHQwaERTd29tNTlFbU5t?=
 =?utf-8?B?KzUyb1pCSDBPSHZubHNmZzBlcEttQmJNcFJoYXFoeW1WK3FtUjU5VE5icmlS?=
 =?utf-8?B?NkVTWkt4czRmR3V3aktGT1lvaVpxNGZuVkFRb2J6Z2dySzdNYXFZdkxqVXJ4?=
 =?utf-8?B?a2hUODBwZXhNa05JamVwZ3ozSytTWjNMUDYzYTlpb0ZEeXpyL2NqaEtQZ0k4?=
 =?utf-8?B?VytlK0RDRUg2Wkk5OC9ZU0VYbnhSSXAyam9lWVhKaml2aWFsSnRuNmtsN3Z5?=
 =?utf-8?B?WW1GNDh3Y3p0ODlER1FsUjh5TjQyanVtd21LcWtZeEVQcXJqb054YUd3WXMx?=
 =?utf-8?B?UzJ1TklVRE1IbmhSR2xxR2h6Z3Y1YTZWNmtBU3RzVHRFVVhNMkNnVDdDQStD?=
 =?utf-8?B?RHR5Y0krZFNqM3hWL2pMaVNmdXdQK2FSKzY3ZFlENVJKMUx3MXlsOVVtQ3Fw?=
 =?utf-8?B?azlGMG90eTU4dlBjWm1oUlR5YkI5YkVRYk9GZzBjckcwYTFzUkRQV3ZEWUUy?=
 =?utf-8?B?OFRzejRtakVHOHhoMGlVaVBraGNTUFFTZHBkNkhYYy96Z2xjbkgyTjVnd3A3?=
 =?utf-8?B?WXVpUnM3eEVPem5kd25WemNjNlBKS2pkdEd0eGlaV0ZZNnFMVUVxWFJ4a0lw?=
 =?utf-8?B?MlFGUW84YWhUQmFFRlMzYW5vL0E2V3hVa0o2dUVGaDZGSjJvdDVydG1UaWpM?=
 =?utf-8?B?eVJ6RWFPdWw0QXVhWXBTSFNCampKbzMxeHhmTHF5SCtkSVZ2UGYvUUlkckhl?=
 =?utf-8?B?bktycFdmN3dKUm8ybXJJZUVjYktnaVJ6VmVUMEcrZGdNWVpCYW9yaG1na1lL?=
 =?utf-8?B?VkJZdThnTjI4S1BwM1YzTWhSZ0JqMmhGUW9rU2wxVUxsUWttS2NNQWJ6R2ZD?=
 =?utf-8?B?c0dEdEpOemRCd2RsaWpmNjBsV3NPZFRxb3k3OHB6d1NNZ1Z2RlYzZmZsVXRH?=
 =?utf-8?B?b0FGTklTQnl1TVRGOUpPOXlKMi9hRCtLeTA5Y3d3SGNzak80bjZZc0tPV01z?=
 =?utf-8?B?VkxIZ3NvY29PYnNES25mUmlyWHlNUDJyYjczZmVGcG92c1psUGpuRzJwdUJY?=
 =?utf-8?B?Q05BNitEL0JvUkg2amtsNzgxRzNySFNlRndrTWwwb3RwSXVoVm54M1VYZzlC?=
 =?utf-8?B?MVczTkFXOU9Vb0dnN01jamVoVmFlV3FUbFB3VFJYYUg3Y2daaUZieFdpRE5R?=
 =?utf-8?B?bzBHU2JkNEJ5ditxTUpPTG1zdk9JaEI5REZkMUk2SHlNOHB1ZTFIdENvQTJW?=
 =?utf-8?B?djlCNnFsYlM5OFgya09lbmlpR2cyWnpJenVxZFErL1BndVhMNEVaVnZ1TG1j?=
 =?utf-8?B?MkREZkppVExtQnRuVWVQZVEvd0MvM2g0Y3BUMkEwMjQyYVhRZnFhM2ViUkly?=
 =?utf-8?B?SEk2ZDdCL3pUSjVtSGM2QkFVVmsxR295aXVLOU1BeG5nN0RRQnVUM3VCZWVR?=
 =?utf-8?B?cmZXWWkwckZBV2JUUlFrQUFGVVNkL2xNZ0NMM2JLN2lhY0RZVnZZTEZhNjBV?=
 =?utf-8?B?bTVseE13eGExaUZyUndJZStjTnRJMjFtUFdDN0Q2N3h3UVczdExGY28wSi9a?=
 =?utf-8?B?Q3Vrd05RMG9RTElwQnJCUnZiZ0lJdlMrUldNY1liMzlqeS9Pak1uSDlyVm1u?=
 =?utf-8?B?anJCT0g1dVRETHhteHBMcWhncVl4TXFLekdCU3lmUmgyMTJiVEJHUmZCcVJj?=
 =?utf-8?B?NG4xWWxoNktUSlMzaDl0bXBZdStRQ2dmVUZkRG5wanh6V3Y1YkZaZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe00e5f7-c725-4112-f0ac-08df0f0b9f13
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:17:49.9138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o77xDsaxtcIdiC27nA3xUrgnNOF43OKXuhb6Ejk9E8s7bbgwc0arxR/BQeTthiqRSHwEOMcR1adjX4WhGtG8KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

On 9/9/26 7:21 PM, Li Ming wrote:
> External email: Use caution opening links or attachments
> 
> 
> 在 2026/9/10 08:07, Srirangan Madhavan 写道:
>> On 9/2/26 7:03 AM, Li Ming wrote:
>>>> +             return true;
>>>> +
>>>> +     pci_cxl_hdm_init(pdev);
>>>
>>> I forgot to ask a question in v10, sorry about that.
>>>
>>> I am wondering why calling pci_cxl_hdm_init() in
>>> cxl_pci_hdm_decoder_count_match() is needed. pci_bus_add_device()
>>> already does pci_cxl_hdm_init(), so if my understanding is correct,
>>> pdev->hdm is not NULL here, so this pci_cxl_hdm_init() here will not do
>>> anything except checking if pdev->hdm is NULL. I am not sure if I miss
>>> some cases for that.
>>
>> Hi Li Ming!
>> Your question is valid. pci_bus_add_device() is the normal
>> initialization path. The later call is a retry for cases where that
>> attempt did not publish pdev->hdm, for example because allocation or
>> MMIO mapping failed at that point.
>> If initialization succeeded earlier, the existing cache is detected
>> and the retry returns without rebuilding it. I clarified this behavior
>> in the v12 commit message.
>>
> Hi Srirangan,
> 
> 
> Thanks for your explaination.
> 
> I think removing this retry should be better if it is only used for the
> case that allocation or MMIO mapping failure during
> pci_bus_add_device(). Because these failures are not expected to happen
> often, and removing it can make pci_cxl_hdm_init() implementation
> simpler. If only pci_bus_add_device() calls pci_cxl_hdm_init(), you
> won't have to hold cxl_rwsem.dpa and check whether pdev->hdm is NULL in
> __pci_cxl_hdm_init(). Besides, hold cxl_rwsem.dpa lock in
> pci_cxl_hdm_release() is not needed, because the function is called in
> pci_release_dev() where is at the end of this pci device's lifecycle.
> 
> 
> Ming

Hi Ming!

In v12 I removed the retry from the CXL core path and kept 
pci_cxl_hdm_init() only in pci_bus_add_device().
-- 
Regards,
Srirangan
