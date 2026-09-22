Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55A83F3263;
	Tue, 22 Sep 2026 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098228; cv=fail; b=AiE8tYKTccf4SdD/9iY88HLqpjWJkk49kLojlOjPvw8rnBEvhABmVCp5fCZY76RdHR5aywZgf3mL7bv9vLsgNMK/2z/KU3OaYGtdFHMVVxd6+aiCiCa9wumJYVr6PILVilAWtpOcvrd1fhY8UJE7tS/O+AL4guf20pQY7MatnoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098228; c=relaxed/simple;
	bh=kLAKjJtGuvkQShwHOGkjeTjCHBWVr0slt3fbi7I//Co=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KijjkcWDEBvoo27TBxD+PdGRTYJciJpxy98I/r9nMkoWijRoSVVhkvTjaxeTmUs8QecThlLt20c0xg7HlTMe1S/gjWFPwYe5bFVm0VYsh/acF1tF0Lc7ef1yiP/uE5vYuLJpxG1FV9EiOIk+4/qiIBqH1gurEUKEDuc1kgxtJbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jA2/+3Ul; arc=fail smtp.client-ip=40.93.196.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jA2/+3Ul"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmfWzVsyU1N7gGiVAZVVeloTQu6g4KDJKdGg9oKqJyG++vIqmI8kVQeJSiTEwyGIvAtuCHyXk+OksUTFGLuOER7iVrekbXtikcv2vCN/920ukvIB6rWKHxLsyGkXIuR7PZoeZ0/rcM3nCEPNd/8FKmiY/Cpc2qVdTk8gr84GhK7Flc69MG0aNqH4pvXJel0WiI01bujYMee1IZBoNEL/wp1pWuKeg7wZKkHg9qql5ykqZ56HUboAWbl/9++zpnUEQwYxtx+ApFmjU3ncIpV811EZhhs1QmpCctqgmlaVF1WSll5pMWNu0m4aFz3/UB2f9r86WTEKAhlg/DYG4rJoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKbmCxpMb56bDC5cLFCdwtAPytFJbnZtbRqucg3dN5A=;
 b=HnMrk1rxbjNnmxPFzU5XBN/08b0TrK+wGKGJj3q+d2LBGFk06Ro39ZZ5dSWzzMjxJ42K+O/VtxjXLalo997XXYLgAvSkbBjRlqf8ECDfe1Hn+Arb9T3IRDlBcB7vu1wbR2PXgazv+macAz5HwzMsnZt/cOgalnzUz5pe1ulSng3JMufxFWEQPLs2e4Oo/XsKapGVVcwi/M5yw86GrzHx/7/LJg6fge8EA1SwS2lCsVHLuzo2XOufKjoA7zLTIMCb9jDfrcxUbeIh9wp/kXxAXFdr/CwDMwffNq2D6ky2+TR6FBpJiZ+obIQP18pBA9CON3bX9biOzmpULqkeWqOpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKbmCxpMb56bDC5cLFCdwtAPytFJbnZtbRqucg3dN5A=;
 b=jA2/+3UlFxmDDUvL+sSMgBvaHhqZPrb6MaGtu9/3GHdwTXtpUflqIeJzyyVWXSZSFQoY1B/BcUNkF1HR6d+nDP23VpkEUa77bmaqT0Da8JMPITFHiI41x8JG/tme5j1bSidNcwIaYTvcD/PDO2WTtMW9JpHDlFSk2hj9JumcrT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 17:30:20 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 17:30:17 +0000
Message-ID: <49dc9184-57f3-4532-83cb-d6ee3a5d90df@amd.com>
Date: Tue, 22 Sep 2026 12:30:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/5] PCI: Assume control of portdrv-related features
 only when portdrv enabled
To: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rafael J Wysocki <rafael@kernel.org>, Guixin Liu <kanie@linux.alibaba.com>,
 Olof Johansson <olof@lixom.net>
References: <20260921190125.GA1333298@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260921190125.GA1333298@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::14) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d51195-7f67-4277-7f54-08df18cf2b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	suTgG6NhjrIdUNQ+JWUY9km5r61V45m/wGVH+7c90a4QT84RCzHwT3DshU4xHar9VTZo2LriS/sCymEKWynNoTZ/IyEYyYTIEIjE/an7LNUHmRSNdr/gRt2Td7Wf293gGkv2ZZsIcK0HkddGe9ZlbmXfODMWlwRaIYm8Fx+Rixe2LnegdwrMIlzy0IM0jp6fhZCGZ2654B+VPd5qMjdpUszHn5nZcWipEpmf7V1KBLMIK5KXkrcnxU4q3kIalJI1Bx5DUsEMP2M8B5tbO4B1oYTZzEsMqpjRA97pxt4JTg5NdOoQalh/aNw1n0TJfUFg9joSVCz8yK8apajHvMw/Bv0vugDLBU3zJtU3JlQpEQuOIzoexZokbEx9xmhzFRwnIe1zs+HSO58arRWCGIp517Bjy89jahdTz0t4Qd2YyMevA4J2w1Q+FjtBnZlgyz8Eyk4QnqQrHaoIv9oxAb2lyXXHGPiFKvIQf8acGajYesWKXU3BravnA2IrcQOTssPYT+5OClpxZGKo/CcjtZfyhFNJjt+JxqhNgAY+sURMk4fanRmBaH5OPK2zeVYV2F81Kp7LUKM10X+Wh5FysIHWYTO4W+fJYjwS4aSN3rkToKi4G6w4+KOo/H23pZzvuuBIaQSKzPSrdTj/0MAYOR4k34cOGDij6Qdz27WmasO0tGI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGxmU2grc3Z4MXZGNzMzMTNkU1dhbFZONFhsd2dIclA4RTN1T3hqa3VmMmRi?=
 =?utf-8?B?c0V4Q2dPSytCK0VYd2RMRUY1enNobE5XbDZ5RXF6WGlNOS85aUlsYUh2TU9N?=
 =?utf-8?B?Z0xLT25DeFJ3a2NZR2lqdXV4RzFpUCtGZGJRQnByUUhoSkVodUJuS0xsYllV?=
 =?utf-8?B?NWhFQVdUNXpaVlhQYnI3ZHBIdjJhbTdCVEpPcnNKSmxpQWJpSmpoNmpUZnJC?=
 =?utf-8?B?dnUrdEtBY3ZNcnAzWURyNit6cTNGdmtxVlliMUtTSXZZdEg1WGx4L29OT09H?=
 =?utf-8?B?VnUzcFp4ci93SUM5dGhMOHF1TkhhNjY4K2RNVWZuSEhtRXM2U1k1TklSVVV0?=
 =?utf-8?B?Sks4aVNMaE9wQjRzZ0daWlo0Z2FXYzlPc3FvNW4zMWtsMm5EOHppbUR6blEr?=
 =?utf-8?B?ZHMzd2J1eUt1c2RxVHhDdGo5bDBBY3NBd3hoQWFiU0J5eURQcktESk5JSEF6?=
 =?utf-8?B?MFVDSVIrYlBNdlEySWE5THpXbEVDM2FCYVVHK0YxeThVUWQ3TFAyUVgzMFh6?=
 =?utf-8?B?SE5LT1Npam9UZXFNcjJuNzk4NG5qcTYzQk5oTE5NWTFDcmo3RzE5azJvZkY1?=
 =?utf-8?B?ZHRseTVmY09aZHBmSitKUDNsYjZRZm1udEdMRjgxYVBSQ0ppcmNnWHVFSHh0?=
 =?utf-8?B?NklKZnJhNDBuRlpxZnVWWENLZURYbmR6bkQwNlFCOWgyelVwN0RJYVovNDB5?=
 =?utf-8?B?L05xd0s3dFhIbHRDc3NnaFg5RkFHdEFCL3ZsWW53c0kwNG53TzgvNi9VUEdB?=
 =?utf-8?B?VXZCQ1paaEg4elplcnpXT3FyZzRrQVFDS1U1NnQ2Mk8rMmxoOFpBcHRKQTBt?=
 =?utf-8?B?UWN1djN6SDZob1pEdlBTZ2I4TDBKVjVFWjBHdlEwZURZMlhEem5vRlg2TGdm?=
 =?utf-8?B?OGxmREFvQ0ZxRTd0c29BVUw0bGs4VllBWlpRY0l2WWhqdmVBQXVDbG9YZWli?=
 =?utf-8?B?WE1PMktGbERHZTU4QXN3VW9adUNia3FBMExPdkxzZy81OGJnRFdNOGt3Y0Vw?=
 =?utf-8?B?VFU2ckd3R01GUS94VG0rOHcrLyt2Yk1RVUNqQjFMR1RpYis2TE5aR0pCQkZH?=
 =?utf-8?B?U3NzT3J5UDAwZ2FXTlFJWjhPajVvV0g3NzVpTmk3eTVHK2MxWjI5U2xyV05D?=
 =?utf-8?B?ZDZRRHhhREVVZTBPUWdLNnFjb0VIYUpkcGtScHFmVEVtRC9acU8vL0tkV3Fn?=
 =?utf-8?B?VDhxVmNWb2c2cW5Fa3dPWU42VDQ1NkkzRjRvS1lPa1lXWmZMcnpLMGxjNUxk?=
 =?utf-8?B?R2lvNjZ3M2l2MzN2MmpWb3FnUWtyalFJT2U0dWc5djVsRERobSsycTZRV3NV?=
 =?utf-8?B?elJvNFBMemNwcDhXM0lRTFREVkVsQTZmVnpyeml4RjV0L2R5K1crUmYxM2kw?=
 =?utf-8?B?czlST0tqaDhJUnpDMmdMREx4MDg2RENQaUIvU0ZDakdpSjBxRkFIMm5DTkJV?=
 =?utf-8?B?MC9pUjMxZ01RdlBSaDJVRVNmaVpGbnFmM0lpMUo5RVJIMFlsWm1odTVDUVNh?=
 =?utf-8?B?MElBVGlNVFFjSjJ1WEJyQTUrd2F5eFlsZ2Z2enRMVTJCelV6N0tCcnlyNDRY?=
 =?utf-8?B?Z1FrMHYzMlV1OHFteDBRcEtuUlQzRzJxOXFTemxGcDZWNyt0dS9mbjV3YWh6?=
 =?utf-8?B?eWE1YnN0Z1BxR3RZZldIS0tub0FJMDh5YnBTZkJOVzNoWEFiMkJLZFNiUlg0?=
 =?utf-8?B?TWtPeWxTM0d1TkxSdjBJNzM5WWZHSDhzM0k5a0pJaGEyditZYitVWVA4VTI3?=
 =?utf-8?B?c2xPOVVMeVVtVjVuaDJRbGFraTdvWm84VVVBdENXYVNreU92SzljOWVVbXdV?=
 =?utf-8?B?WlJGVGhXWTRiKzc1TXRSVDcxWDRUYkFGRStoZ2ozZDU0QURhbXlRekV6SGND?=
 =?utf-8?B?VDZVQlEwOHZXQkRHbnR2am5tNVlCVmd0Q1JGNGdPLzlGcWxuSjdJby9icE9l?=
 =?utf-8?B?L3lDRzZxc0dTOU9lSWxDazRFUUVvdGN4dWZwTlBTV2IwbHlDanU3NXNpMEZD?=
 =?utf-8?B?ck1BWVZxY0xsYUYyemtDeTVGbFRIa2V0Uk56bVpJMzY0SXBuSkFOREYwQWVR?=
 =?utf-8?B?ZjFJQ1JKT0VwU0J2SjZocER0eDJ5U0l5czU0YkFLZzZaNWxhMTZOa2k0c1p2?=
 =?utf-8?B?MktORkNmeFVBazhmbnI0Unh4SHdlczhiTWZnK3hrYURxcExxQmdEWW01c0NP?=
 =?utf-8?B?YmNobG9OYmcrV3dCbWVZSFNKbk9PdjNSVjMxQ3IwZFoyeGg5QmNJSjhUNGdT?=
 =?utf-8?B?UnZhc0hscTg0TWpkREVsZmdSaEpUVWUwK2dVZUdTMWRSNWhYVWU2UjJTZlhN?=
 =?utf-8?Q?2BmYlTF+Be5RCk9IhZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d51195-7f67-4277-7f54-08df18cf2b18
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 17:30:17.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyyDdLTHBIeCUM098MsRLCwKkBD9SMh0xA2B/mxwHBFL+5nGW4dUFCGT5G2S3xiZjd8ijKDOuk0M7eQfKGi6mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534

On 9/21/2026 2:01 PM, Bjorn Helgaas wrote:
> [+cc Terry, in case you have thoughts about native_cxl_error;
> beginning of thread:
> https://lore.kernel.org/all/20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com]
> 
> On Sun, Sep 20, 2026 at 08:17:21AM +0200, Lukas Wunner wrote:
>> On Sat, Sep 19, 2026 at 09:26:52AM -0700, Kuppuswamy Sathyanarayanan wrote:
>>> +++ b/drivers/pci/probe.c
>>> @@ -668,12 +668,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>>>  	 * may implement its own AER handling and use _OSC to prevent the
>>>  	 * OS from interfering.
>>>  	 */
>>> +#ifdef CONFIG_PCIEPORTBUS
>>>  	bridge->native_aer = 1;
>>>  	bridge->native_pcie_hotplug = 1;
>>> -	bridge->native_shpc_hotplug = 1;
>>>  	bridge->native_pme = 1;
>>> -	bridge->native_ltr = 1;
>>>  	bridge->native_dpc = 1;
>>> +#endif
>>> +	bridge->native_ltr = 1;
>>> +	bridge->native_shpc_hotplug = 1;
>>>  	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
>>
>> How about (e.g.)
>>
>>  	bridge->native_pcie_hotplug = IS_ENABLED(CONFIG_PCIEPORTBUS);
>>
>> instead of using #ifdef?  That's the preferred style according to
>> section 21 of Documentation/process/coding-style.rst
>>
>>>  	bridge->native_cxl_error = 1;
>>
>> Hm, this one depends on CONFIG_PCIEAER I believe.
>> (But Terry Bowman is the expert.)

native_cxl_error gates CXL device event record reporting, which is distinct from 
CXL protocol RAS errors. Its only consumer is cxl_event_config(). This should remain:
        bridge->native_cxl_error = 1;
This must be assigned outside of the #ifdef as the corresponding _OSC control is 
based on CONFIG_MEMORY_FAILURE and not CONFIG_PCIEAER.

CXL protocol errors are gated on AER (OSC_PCI_EXPRESS_AER_CONTROL).

-Terry
