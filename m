Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4B4568FA3;
	Wed,  9 Sep 2026 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968345; cv=fail; b=QhjichjVYCIwwxKom4a3Lg4B9fey/HrrVr8hZ4DVj+Da95lLin85Nglr8inRLF6CEjcbH08d3cXNwQLrZXZB7i2S+dC5msj8f4SVkenqQ780zSlmjFAe+to/X8ZCtjd8BIvXR45K/qARjkoma77bMKrxpzc5O2br8SNrmPLQL0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968345; c=relaxed/simple;
	bh=5YcnGfphvgJ3mzagu41orK6gLqArfbOf6ZfwiYR/WZE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cWNWckLC7Vsis5PMsxV/okOpRNCFFCVhlYZr4nIr4t8AtlYx4DbeTEeS1d1WaGmJaKEBc8ZfL03L9thFtSPxN2wr0wQbs9M5Q6rfrNRbY2m+Qejs4pxd2vJlrW8aBiBhmt/9sor8Mf89vUCB1aPJKFE4yhijWmB2t1lUMohO9K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O1YgP52a; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O1YgP52a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIDS79XUVoK41l64C2uQkUzsCNlY6U6RVg6AFOZozKpbFhZ+5lAsXUUGvd0flreysNVteDx3+8Fq/0KdH2GnT9V5bA65zhrPwp9d/S+p9j9+qzEOpYC93JnG2MTwh2M7rt3jDCsD5zf7X9w3GgHEHVM0YHsaj/iMTK07iLl1iuC8zYKRSrQWYX5odAnFPKfVAPIK8Q7dK01p78VoTsphMJOjB4fUA3Nsf87ev7zi07PGqPIAz50PdH8WPlM9lk46NdyjGcy/O5bCamCFg9TK5Q6zgSv8Y0ehEoWU8LhqefRtGjGoWHyD2HkSH/xnNXOwFtFqvsRsGknH5lv7lJy6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BesFlDqcxgYgt81wwI2Ve8vjSy02cgj3lChN5lpQ8Z8=;
 b=xaupU3EVRTUZnyfVYbwOybS6SiinnzX0XhZeRd6wNtsGZQ2TqpzL42lHi4pKD/+VafBkbglOQ5xNWHXa/a5bpZDS4Gy9pyQjyS1IwskyVh+8EP1aFSf8/+6NsIqwvA2VqUMMzQ1d64wanzqwxTl4YIx8I8x47Cg/p27aD9GQz/uJM7bATNqKaStukK+UGfNwmkLeJ0LuCAcGSk3sesN1mqOCMiX2viGSryqkJBqFNATdWmwAAx5vD0JnKWCi/srr7mGHkcmCumKd5xpjwqygk8aavoo7ub6RxGwuL8y4qWSAFMpAjsEf1dNZClAK5/Lf49VEwmtQtyAxROCGEx05NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BesFlDqcxgYgt81wwI2Ve8vjSy02cgj3lChN5lpQ8Z8=;
 b=O1YgP52a2INxGIE9JKHaL3gLSkp2T+7W/iAAin7iKa9lfVzsZGgBjw4gmdzD+p5HNaL4tyYwD0MVYm3QSwg/JoRDmKmACQpFLvIEWEH610Rrh3ZF7mJ+qmH9qhMSMFHBIxGWma5dEbRAJJsN0v+wZbggaDEL1shlajguwZnOtXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SJ2PR12MB7919.namprd12.prod.outlook.com (2603:10b6:a03:4cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 15:38:56 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 15:38:56 +0000
Message-ID: <bb5a6b0a-c30b-4475-8be6-f3e3686c93be@amd.com>
Date: Wed, 9 Sep 2026 10:38:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 1/9] PCI/AER: Introduce AER-CXL protocol error kfifo
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Richard Cheng <icheng@nvidia.com>,
 Robert Richter <rrichter@amd.com>, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-2-terry.bowman@amd.com>
 <20260908015144.62ee9c1c@jic23-huawei>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260908015144.62ee9c1c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:8:2f::10) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SJ2PR12MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 0081f200-f4da-4b35-243c-08df0e887579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|4143699003|6133799003|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nvQPreHfzY/oXzJe4Ied+GifjC0xtUuV5x4dru0E5U0nTcMirj/m6JmqrS250y6RXnPv1stddujUWoTag4mETkujxOiyODADqQ6Q4tWbMG0EvRMRGmTygN62TmrcHRKpGgECvYSiYb6kwSV4FWGKp1ADPckSiLDOFaWe1x4hrk51md/SvZusvc5cbGXw3BK6I3U9SwWoyb8tdUXnsagotQdtdzqPbY13o1dYtx11BD4oUDtaZ7NIZezYhj8zxNeI0kte05GViDAlV/MY4xD5LCYGp2PjalIfNzLzWsRyBC6KD+u+pM/CBWOw/eTXyZ9rKuvIrfamji3s/kbP7Npz5BnjE87F0uk64hp5Gex7EYkPIXLPjfi0LVXNyG8oeLtlEd9TWS0zsSlvyOrRcY2vyKr98jXV7cmsbfJ3aXrbMdRwDD55U5CFZTAPA2DUy40ZPYOA4knloOHB4WDZgmPvYceL9VeLKglrH+wP4rg9xi12TqYw9/QldQlhjk1VxSUGe3Fr6ie2dJxJjPTSzCx3tc1qIz7ALJYcM2JFt6+hnNw6oQaO8OID4vZYRmpciyzEInmYkUrn810kQzwNiwWbHxoreQJ1TCKwVavJXH/YvUqgMC++w4OqohpqtP9eyLs1tih/nrnOUJwZys7qqh7tF+JtGsKIxT0vTxNNFl37UJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXdjS1JGRktlWFRyWUNkYTlHUHk4NzdpMWpvRFNvYWFPaHpsMkZkd1F2Y0t0?=
 =?utf-8?B?NzFvODNqZDllVlVjSVlFbitkcUVJS0F1VlB6YVRWVGl2OVl0K0tmaUFoYVls?=
 =?utf-8?B?aFlvTHM3VWZFZ0xZdnArd3ErQWxQd0lEeTRRRjZLajN6SE4vZnlocE5vVUh3?=
 =?utf-8?B?ZDFURTg3djczVU5XR0pqRml5N1hMNWZnaVJxWEE0c0l2eThSbzMvUzFBeSt3?=
 =?utf-8?B?RGUzRFkyQjd4d2oxOWs0YS85R0xIbTFhaEthd2xUUWNteURYSnBUbDVCY0N6?=
 =?utf-8?B?aDJpc0xWcGp5MnpMdDRkWm8wdDBCanRBNWlpUnUxYXhzS3lKcWFkRUpKSG05?=
 =?utf-8?B?SlArUGZVT0ZNczNUZDRHQzZ0UlJBMHErTFlpcS8rMTM0YXVSOFpPTUxXYkFR?=
 =?utf-8?B?c21kV0FmeHlyVGVTRWRrcnBCdGI0QW1TNk5tbEpUNmI3S0hkbVRUZk4vR0w3?=
 =?utf-8?B?aVo0L0t5N1ZEVTB0MDRDdFp1QXJiRjlQaTRzRFJMejdST2hHRHd1QmpVemE1?=
 =?utf-8?B?T1ZXSEMyOEJKdGYzL0xJUmMyeGxRSDRZeG8zRjdJSEdpcGZBNjVkdTJsMmhK?=
 =?utf-8?B?bVJFS29UQXJXalYxRXFlNUdZMm9JNDhiWkk4V2d5akVtUnRMRXpEcXNBTW0w?=
 =?utf-8?B?Um5oY1pzRGJTOUcyNGFwdmJEQlY1a0VFRXArL0d6ZVVoY2l3bGIxbWR2cEk5?=
 =?utf-8?B?K29KMkpaWCtJQnArN3dIT3E5VjJ5RDJQTU9ydlFuT2xuVFB0bnBqbjhldEgw?=
 =?utf-8?B?MFo5TGgzRkJWOVYzUllJS0diVHVycjBiNHdETzVmdmVDbCtCTWVFdkNqWWRH?=
 =?utf-8?B?YXhiZGhmTU54UllBMUFSMngxZnJjeU81TGZVbFFsMFdQODNKTGtzSVV0azhP?=
 =?utf-8?B?SHppZGY1NDU2VWkvMURxU3cybGZRVXdNL2VpRHlTVi9palFMQjl1b3RiSmxv?=
 =?utf-8?B?TWRTV2xIT2RJQ2hzbktCeC9VWDAySlM3NE1SdWpGV3cwQTIxK1JHU2NyVnJZ?=
 =?utf-8?B?aU5IVjZQMVVIcHdWNDdwcXpuWFNxcklYZEVSOHJVN09sS1dua04zZWl5dlFM?=
 =?utf-8?B?bHBtSmkzcjNvZlJsVDFDN2RmK2RoWEw2d0lCelpIOHN2aWFjTTlCYSs5WDEx?=
 =?utf-8?B?NlFPWlVKWG1KUldyZElYZ1J0TW9iOURBQ1Y2TUNMaWYxdWVJYnJMdWFZU001?=
 =?utf-8?B?cEp6bmkzRnc5WXZXc205bHphYTFZamMzRW00dHcwUVUyNUhKL0laV3R6SWda?=
 =?utf-8?B?UGpqaWJDaStlZWpnSU1pbS9XR216Q29FejcwU0RPZzYyK3pDV21WRnJoSml2?=
 =?utf-8?B?MGVIVDltY1VibFZPMDNib1VmeXJvd2cvQ3FsQlRzelh6VVJJVzNSWXh4T1My?=
 =?utf-8?B?bEtwS1JxMGUxRU9Ga1hsVG5zUHN0dzY1bWI0d1ZpUUx5RzF2S1BTU05EQkh1?=
 =?utf-8?B?RWpxRklTSWw2b3RVYU1FRmZDMXJrOHM5KzRuVTBUZlB0K2h5blRwc09VYW9z?=
 =?utf-8?B?MTFYa0FOd1dSdlA5N1Y2ZnpUd1dEd1Z1UmVVRVBpMlBldlhpTEdPelhoUVVK?=
 =?utf-8?B?VXl1OHR5UlZzaWZVdEdySllNcTJQcnRQVzNYTEY0b0plQS8yVGVDeGZNdm5E?=
 =?utf-8?B?a2xBTVc4aGpQUFQ2dWVxVVlrL2pnVWxxVXhkdDZXWDN1ZGs2ZThoNk0ybFlt?=
 =?utf-8?B?Z3lWaFZJQ0NONmN0N0I2U092YitNcnROTnh5U1RjK3RNVVpnSVBuUVNZbWtm?=
 =?utf-8?B?d1Fac2UzUGdheUgwaUVIZ1FSTit5azlZcTU3NGNMM3pmVmc1QzFqRHlkVEV4?=
 =?utf-8?B?V3lGK0JPMXp5bDE1Z0xQM1N5eTFkd0Erd2pFSlExenAxRXN2aFp5OWpHaUF5?=
 =?utf-8?B?cC9KSmxjQU5Zb055b2xSZUpmd1psNncxbit1cE1hN0VFbVJZcm1VNGN0ajNp?=
 =?utf-8?B?dTFac281RGtIT2g0dlpyOHdZTlFWSERkcU0xTnZPbkI3eXJ3RGtiTXBKc0Rz?=
 =?utf-8?B?cm1NN2ZMd3pPeTB1ckw1RG05UE1MT3E4REk1UXIwV3pVRm1lbElHcXlJcVc4?=
 =?utf-8?B?cEtCZ0xSNTBhWFBxWHdsZ3dxckpWa0NXeUlFdDFmUGlCZ09IVDV6Vk1hVW9F?=
 =?utf-8?B?OGtBRE5JNXNBU0ZLR2t0WU8vSjJBRzlsMnlrRTZtYjdpTjNqU0Z6NUdCR1pl?=
 =?utf-8?B?VDJmN2ZIUDZMWDVhM2lKSFZKSXhoSnpwMFdnVlpYVTJ0TVFFNGk5UVF1YXNq?=
 =?utf-8?B?QkM2dW9INGFSdkU3T1BrVk1RQ3FmaVE1RTg3WkVJY2NmejZIc3ArZ3ZEWkN0?=
 =?utf-8?Q?qSNrTR93aFktEroTp0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0081f200-f4da-4b35-243c-08df0e887579
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 15:38:56.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJUxZ1St3eem9psbLKlzfn+rr22kWQ5a1kRb91ESxdJ5aUHa1LOnSYsf3bV3MeJ/BA8/mhd5lNHnlHpD/W2yHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7919

On 9/7/2026 7:51 PM, Jonathan Cameron wrote:
> On Wed, 2 Sep 2026 08:39:25 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> CXL VH RAS handling requires the AER driver to hand off CXL protocol
>> errors to cxl_core for logging and recovery before PCIe AER recovery
>> tears down the device. Introduce pci/pcie/aer_cxl_vh.c to implement
>> this handoff via a kfifo-backed work item.
>>
>> The producer, cxl_forward_error(), is gated by is_cxl_error() and
>> enqueues the error source PCI device and severity. cxl_core registers a
>> consumer via cxl_register_proto_err_work(); the consumer drains the
>> kfifo with for_each_cxl_proto_err(). For uncorrectable errors,
>> cxl_proto_err_wait_for_empty() lets the AER path block until the CXL
>> plane has finished so recovery does not race device teardown.
> 
> Do we need most of this last paragraph?
> Maybe the bit about letting AER block but the rest smells like implementation
> details to me with no info on 'why' or anything unexpected.


It is implementation centric. This can be reduced.

>>
>> A rwsem serializes registration, deregistration, enqueue, and dequeue
>> against concurrent AER IRQ threads; a spinlock serializes concurrent
>> kfifo writers. is_aer_internal_error() moves into this file and now
>> evaluates info->status & ~info->mask rather than the raw info->status,
>> so a masked internal-error bit is treated as not-set. For the RCH RCEC
>> path this is equivalent because cxl_rch_enable_rcec() first calls
>> pci_aer_unmask_internal_errors(), which clears those mask bits in
>> hardware before the AER status is read back.
>>
>> A subsequent patch wires cxl_forward_error() into handle_error_source().
>>
>> Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under the CXL
>> entry.
> 
> I couldn't immediately find any discussion about switching away from panic
> on a kfifo overflow.  Was there a reply to an earlier version with a
> discussion of that?  I'm not against the change but a 'why' 
> here would be good to have.
> 

The driver panics on kfifo full error during UCE enqueue. This was recommended by you and
Richard. Changes are at the link below in cxl_forward_error():
https://lore.kernel.org/linux-cxl/20260902133933.2992457-2-terry.bowman@amd.com/

>>
>> Co-developed-by: Dan Williams <djbw@kernel.org>
>> Signed-off-by: Dan Williams <djbw@kernel.org>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> One trivial thing inline to add to Ben's nits.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
>> +/**
>> + * Callback for processing a CXL protocol error from the AER-CXL kfifo.
>> + */
>> +typedef void (*cxl_proto_err_fn_t)(struct cxl_proto_err_work_data *wd);
>> +
>> +void cxl_register_proto_err_work(struct work_struct *work,
>> +				void (*flush)(void));
> 
> Align to after the ( Looks to be 1 space short. If this is a local
> style thing ignore me ;)
> 

Ok.

-Terry

>> +void for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
>> +			    cxl_proto_err_fn_t fn);
>> +void cxl_unregister_proto_err_work(void);
>> +#endif
>> +
>>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  		    struct aer_capability_regs *aer);
>>  int cper_severity_to_aer(int cper_severity);
>>
>> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> 

