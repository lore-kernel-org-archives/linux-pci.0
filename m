Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBEC2BCF4C;
	Thu,  7 May 2026 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178425; cv=fail; b=MmhAYbA5hM1XUxKjketXd59cdkECZR/piZktManhSXIr2+dVMhaZPLxHQkSKPYudku4Iq5exwmpLnbjpNESn/ssfOTy4bOY1LlXC3sdpE+Ws7Ocke/dDjpfiYti1RPu+KqkOm/5+gHTEq5Np9GOcYuTggkq4SflHhfv3vBUcU7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178425; c=relaxed/simple;
	bh=i1NmIgRt7HaFegBrXbS2S21bxZZlAhAwgdqI75Za56c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NYqOL8MXy44+sTs/YN/6U8SvIp6Onozp7ePnKxaivX6+OtJtyD0Xr7hziJsYzS1v3IjeNctoCRB1QfBYqDeVUT7Jkkcnu5ctZVyBFKjiXQ1A/7KDaJzTW5WgxsuoWLiR4aElCkFw/vlYOAJG5GjzIuU6K6i7s6O8wbx8M9gmUmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FoDrb7w0; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FoDrb7w0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWjmaVXAatoYzoSGW5YZkedW1FGFW/3G6vjq/vig7lMLI8IBL7BGFRH9XTRShlTHzsfIOOHa0m6Fl2n7tT7iOyQEeCnDgWd6mm/dut8QWnqAg13W+K5lgJytxyyxMcl2mlVeJ0GQikTLHOAqlyfVJSMeH0ONC/TVBxZIjk1zd9tn+YLcU6u4J4S4IwTpqKPYe0R6IcfqsRIQve7bQFkyLCVXA299YboFUH2Cpt0jJxfWwFxYoqAEHK02beuHfz2g2y0R5+OjJgmAOZ0AfmDG5e7tzwWJc8UGXzEd2CPybnvSZoSy3flJV+vBC7ZIrv94Jj7spAJp5SixOR+6fdOpEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRmBVCLOs+K+mnmo43RlbcaCZistRe8Z8QmsV2oVYuM=;
 b=IegG/NffugDmcP9nQrqezNGp/lyuq+/Wm54PlsJRVTP8AMnx0YZXR5I4UJnPd6ueGMTipHxus5cCs/GIj/LqGwRJytavI9sxFBCXTgRE+xCV6DriyUkWDMtBlsEh/NTzFsIlf1zX5AdDlh+V1VP+9hL9QlhRl9r9ubx73xuGQa5tnqPRiiFS8U4RRgeJxYHPrOKywqukHMENsr822/38Nb5WQyFKNqMNYe5q4tLe03GEV+aRRSZAb9nBQNofEOy0eOtb+tWsjViQ63sL58TA2GNIKJP/mjh0fpR1XylmuaMpWvHPDFc1u+EzQ3YC/BMJJj26cqXM6J5eT7I8eCjKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRmBVCLOs+K+mnmo43RlbcaCZistRe8Z8QmsV2oVYuM=;
 b=FoDrb7w0SVXF9bzUQRuAWuYeQXeW33w7u+dPI4PGNyEdjFS2Q1ot5K+h1aqovyVLUJRQuGXVNUE3eAQHpQdp3fz8pM0mvJYCFftfuG1KMwOyiORwSWNutOFZvVx45022eT1g2kA0ief2Ndfgpi+AZTYDfdmnhlLO5yD4MZgQ3Yo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 18:26:56 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 18:26:55 +0000
Message-ID: <aa33879f-6ddb-41f3-ab8f-7896c71bcbde@amd.com>
Date: Thu, 7 May 2026 13:26:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 01/11] PCI/AER: Introduce AER-CXL Kfifo
To: Jonathan Cameron <jic23@kernel.org>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 djbw@kernel.org, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com,
 corbet@lwn.net, rafael@kernel.org, xueshuai@linux.alibaba.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260505173029.2718246-1-terry.bowman@amd.com>
 <20260505173029.2718246-2-terry.bowman@amd.com>
 <20260507185303.329cf964@jic23-huawei>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260507185303.329cf964@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0038.namprd18.prod.outlook.com
 (2603:10b6:610:55::18) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: c4eb36eb-27f9-4d90-0f69-08deac6637c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	T6CBZVHnu7jgHoyNKC1Supdg7PDkT+NAkE27bbnDliC3J+YNnXLlat/br582nQpqXj/vLc/zDtG3p8tFtyCRSSfbEucSgimPEZmEOqEhYeNyl7bxOBP3SBntzFbalK//+p8F+l8yYiAwRpHKmH5+OQsxx/rvr+zB4scye08SvicCCC+ynqSWBaf0vezAvyL5fQrP4jaQFzaowQBq23ldFvnxV/r+ZpdHLKPpT//FPrVCBdfB2MqMoH4czBnNvl20dZPJU0AmNQC5ss5e0SXIoqSRtR8EyrxYxA6JyUOcz1lKfv5+nQFcKtpY0jko32uoWpntoNIX62QHVW62LQB6l34pSmC0RMjEiHClAEYXNXsTq4HGmw3cKH2ewLVw+iyZ5h0wHaijnrzqQww/eHZCuyebKefWISRtAGQLymNE57gGdqJ+JLoWPXgIjulE2Jll9mFf7p1Yc1hitoWjvdmU6tWhsY43r0lRQ620hWOIn9QpFAxQ7UAHoZxgsaloQa6BBfRLwYgqeZbP7Sti1gM+LJw5FRX+JRCzZBXA6Y+DmYRLfnSLEq5+vjqJ/XZWJ82Qusa88NjAq/95rv7isMip1Ek84fH590xOwW2BFpsVImgFfujvkLPsIn98K4IKfExZmu8FPHofoWp6C8OUyHAJvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c25YWXhvemttMnZ2TkZXa24yem4vRzFJWkgvTU52MzJJdkhJeXQ1Y2U4c3pC?=
 =?utf-8?B?U21ZdmZtTXE5UzN6STIyS3hac0tVRHFHR3FlOC9RRWdvaVBMeG9GTG1iblN1?=
 =?utf-8?B?Q3dHYlZtcWt3NUQ3WjFLc0haQlBoamx4YjhHcVdzbkl0Mk9zZXE1aVR6bE1H?=
 =?utf-8?B?cmVTeEJiSXRuOG1tRUpkUk1yWmJxajhCUkIwQ2lvOFRaWHREaDE2Nm11bmcw?=
 =?utf-8?B?RlFHV0ZkZ1FPcE1tOGFDSnhKbER6RGZyNW9ldWJCRjJvN0trcVFiNE1hZEI4?=
 =?utf-8?B?SUhwZnZLYmNydis4N3hNd3plRkdRcXBqSGh0SHJYME42YTU3bENkRlI1S2RI?=
 =?utf-8?B?OCt3TE5mcFZXdnJrR2s0QmExbVFjR0t3c1FEendWTjNqa1h0ekRSbi9iTmtC?=
 =?utf-8?B?aFBBSGl6YnZad0JFK0tpZFZxVnVwWDRUaDRxalhaTHFmUW1SSDBDQ0pjRjhT?=
 =?utf-8?B?c3lRUjJFcTEwb0VGK0dpYm9HUFFHY1UvMjJ4b1hJNVdZYmpuVlFmczhQUTA5?=
 =?utf-8?B?TFF5ekZwcTAzV0Y3cGtTL2w2Nk1KL3lEbHh2TlNqTTV5SU9CWmlvZ3dCRys3?=
 =?utf-8?B?Z1QrQS9ickJpRHR1MkZGVjhQVmxLbnlDbUY4dEl4RE5vNDd1T3ZTYTZXRGdz?=
 =?utf-8?B?aHg0VEFzSWtySlVndFN0YTVIMjc2WE9OaHFNK05FM1l6Z1dIRWVVNXZNTFVm?=
 =?utf-8?B?RUw0c0VqNFJ0cmdhK2lkOU9xdnNtUnRmbjZGRGlpMGJReXE4Z2JiTW05NGdn?=
 =?utf-8?B?bnY4QUVzYlpDMHhINVhJWkxTd3lIQitHR3NrcUdubDMwcnpCVkw2dHRnRFNr?=
 =?utf-8?B?SFJweTlEdGsxcnMxcFRNMmx4SFRiV2JvOTFvdE4yTlpFMnBtaS8ya1UrV0Vi?=
 =?utf-8?B?WWlxVFVodDlsM2RaTHB3QU5CU2t0WWR0UktudngzLzd3UUhodWs5RldXMnFR?=
 =?utf-8?B?R096c3BRWkJoZUoxdm44bDMzZWNiaGNmblVRb3AwWGErWktaTXhnZkZPdytQ?=
 =?utf-8?B?M0ExODVHOUxRRm1SZGJUWnZOWDZCL0diblRaT3FQYW0rKy90Z0Y2M2VyS3A3?=
 =?utf-8?B?b2dMbWVBeDMzNDd6b25pT1hHVUZUdDVWNzU1aVNuUUdmcXE3cXErR1NDTkRJ?=
 =?utf-8?B?ZlhuUitvR29VWmtrUFB0UFp1bUxRQmRrWGdUaHdWVzNtNzhEOGNxSkliQ0xZ?=
 =?utf-8?B?c2wyclh0c0plekU0SnZiT3ZCNWFTK2F3UVFxWGFHWFNlZHdESm02QlZRQUlW?=
 =?utf-8?B?YU1XZ1ltanhVMVhZK0h0WTZjNkxhd1o0ejVxSjZtaGtDbmVEU2dhdThTbjI5?=
 =?utf-8?B?U3dJSnpOdmhRSDE4MWJWYmt4V1RHOC9qSDlYMENDdEZPTjBpVnFLRFZnb1Yx?=
 =?utf-8?B?MWhONW9qMHBhZTZSLzdhWE9PWE4xM2RNd3RUNHpEWGk4eXd6UkQ1T01JNTBq?=
 =?utf-8?B?R3Fib3NmNjc3WFdCSktSOTgvWGljK3haM1NnOEQwcEUwSTluZ3lDdFg3bSty?=
 =?utf-8?B?OXN6QmlVYy9vL0NCL2VhMm92TlQrTGlUaVdRRW9YaUNlZVdLUWVTRUh0ODRL?=
 =?utf-8?B?SCtjdEZPL1QwbVFmODNHMVYrQTRPOFF1YlBxd2FtVUlNQkU3SVZuWGF0NFc0?=
 =?utf-8?B?VVExZEh6Ni9zNVM5Q2FsWkpjUE9nVmpiR2h3SmZzTHJGRWo2ZTRUanRSdVF1?=
 =?utf-8?B?RllYUktwQkk4YjJ4d1k3c3AyZ1dpWjNPanI3OFFEWEFPWXJDWStsMytLYk11?=
 =?utf-8?B?U2NaMnpyUUVxSTlsc1UwcWJDcGRSY2dOY0ZCMU9uOHNzU2JsOUZ5KzVETXdW?=
 =?utf-8?B?YUQydDdicm1XTEU0bXR3ZXd4blNMd1o4bzIxZFlUK1RKZEEzZm1OS3lRUXNR?=
 =?utf-8?B?ZUJSMi8vMmpjdVFDOFp5enJNcnVLL1I4WFJnbFMwbHE4MDR0Y004SkxNdU9a?=
 =?utf-8?B?UEZBL0t4Q0hPU3F4QXNIc1B0Y1ZmKytaVTFFVnd5cnlQaUI1N1ZpaXM3Z2hO?=
 =?utf-8?B?aWlGT3dJZzJvKzB1eUdyWUo2YU94VWVBQzFmMUV3OStUdkFlQ25zQ3FUclM3?=
 =?utf-8?B?eHE3TURCNC9LZVBNTHdUak9rNkRHS0Vad2FYOStnQWtGTWw5SzM0SURuQVFP?=
 =?utf-8?B?RkJsNWthelZuMWNiS3VvUHk0RmdJY01xK1IvdnpnUm84NGtYT21kM0kxYWhU?=
 =?utf-8?B?YTYrb3RoVE03bXQvdm9kQ3FIQ1hNVkxFR1hreEJDcUsyYWQzVFEwcDdiblYv?=
 =?utf-8?B?bEo0R3lnVm8zSGpybzJUdXBLaWR1LzZ0Tk1HZXR0eC84OG1ISDYwZ0p5WDJ4?=
 =?utf-8?Q?rlymb+Q9DQPIHuexXV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4eb36eb-27f9-4d90-0f69-08deac6637c7
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:26:55.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aB0D1TI3p3yD/J0v2Ow6cogqwqwYBfvGzJZU8sfwvvVngkE4vvav/OQB5xaPRVF6114ZwSQHUQ/gl6FOcjTTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254

On 5/7/2026 12:53 PM, Jonathan Cameron wrote:
> On Tue, 5 May 2026 12:30:19 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> CXL virtual hierarchy (VH) native RAS handling for CXL Port devices will be
>> added soon. This requires a notification mechanism for the AER driver to
>> share the AER interrupt with the CXL driver. The CXL drivers use the
>> notification to handle and log the CXL RAS errors.
>>
>> Note, 'CXL protocol error' terminology refers to CXL VH and not CXL RCH
>> errors unless specifically noted going forward.
>>
>> Introduce a new file in the AER driver to handle the CXL protocol
>> errors: pci/pcie/aer_cxl_vh.c.
>>
>> Add a kfifo work queue to be used by the AER and CXL drivers. Multiple
>> AER IRQ worker threads can be running and enqueueing concurrently, so
>> include write path synchronization. Pack the kfifo, the spinlock, the
>> rwsem, and the work pointer into a single structure. Initialize the
>> kfifo with INIT_KFIFO() from a subsys_initcall so its mask, esize and
>> data fields are valid before any producer or consumer runs.
>>
>> Add CXL work queue handler registration functions in the AER driver.
>> Export them so the CXL driver can assign or clear the work handler.
>>
>> Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work
>> data. It contains a reference to the PCI error source device and the
>> error severity. The cxl_core driver uses this when dequeuing the work.
>>
>> Introduce cxl_forward_error() to add a given CXL protocol error to a
>> work structure and push it onto the AER-CXL kfifo. This function takes
>> a pci_dev_get() on the source device. The kfifo consumer is responsible
>> for the matching pci_dev_put() after dequeue. On enqueue failure
>> cxl_forward_error() does the put itself.
>>
>> Synchronize accesses to the work function pointer during registration,
>> deregistration, enqueue, and dequeue.
>>
>> handle_error_source() is intentionally not changed here. The is_cxl_error()
>> switch that routes errors to cxl_forward_error() is added in a later patch
>> together with the kfifo consumer registration. This way the producer and
>> consumer land in the same commit, so CXL errors are not silently dropped
>> during bisect.
>>
>> Also add MAINTAINERS entries for both drivers/pci/pcie/aer_cxl_vh.c
>> (new in this patch) and drivers/pci/pcie/aer_cxl_rch.c (already in tree
>> but previously unlisted) under the existing CXL entry. This way the CXL
>> maintainers are CC'd on changes to the AER-CXL bridging code.
>>
>> Co-developed-by: Dan Williams <djbw@kernel.org>
>> Signed-off-by: Dan Williams <djbw@kernel.org>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> Sashiko did have one comment on what happens if there are multiple things
> in the kfifo and fn fails.  At that point I think we are in the all
> bets are off corner and stranding a driver is fine, but open to other opinions!
> 
> https://sashiko.dev/#/patchset/20260505173029.2718246-1-terry.bowman%40amd.com
> 
> So with that in mind
> 
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> 

Hi Jonathan,

I resolved this for next series by changing __cxl_proto_err_work_fn() to return void 
as the error case was unnecessary and only added complexity. 



>> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
>> new file mode 100644
>> index 000000000000..c0fea2c2b9bc
>> --- /dev/null
>> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> 
> 
>> +int for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
>> +			   cxl_proto_err_fn_t fn)
>> +{
>> +	int rc;
>> +
>> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
>> +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, wd)) {
>> +		rc = fn(wd);
>> +		pci_dev_put(wd->pdev);
>> +		if (rc)
>> +			return rc;
> This is where Sashiko complains. Specifically:
> "If the consumer callback fn() returns an error, does this early return
> strand the remaining items in the kfifo?
> Because cxl_forward_error() takes a pci_dev reference for each enqueued
> item, it looks like these stranded items might leak their pci_dev references
> and prevent clean unbinding or hot-unplug until a new error triggers the
> queue again."
> 
> I'd go with indeed it does, but there is no right thing to do here. I guess
> we could flush the kfifo and call pci_dev_put() on each of them, but that's horrible.
> Would basically mean calling the same stuff you have for cancelling outstanding
> entrees on exit().
> 
> 

Yes, that is an idea. But, until error discriminator is needed this can return void.
Clearing will be necessary but I think that will fit within the call path.

-Terry


>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(for_each_cxl_proto_err, "cxl_core");

