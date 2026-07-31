Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7304B239E7F;
	Fri, 31 Jul 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515053; cv=fail; b=l02jasGqkpWTNzG1D9F6uZFNBeKqyVOtvr3f+GgkBaANSWVKA6LFoIFDTUVK2uVaLfnP+SdPs28W8IZp+xGZuwYLks2gx1KwBLE68uC6Z261xGTu1OtTs479i++nAZIRNYXQw6FW7z2fLph74gYKObHBcyD1/9A82PQybl/hMao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515053; c=relaxed/simple;
	bh=Q+tPewieBFe5tqDVLqIGJ+4YDpAQogfmGKbf21ngSxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rj9jJWL9e//9YO3rZlpqz2eDMxBzrwzXhEEtSLtohXldeMuZkKLmkTFSYYBoH/cvLAG7S9pTtga3RvDMkc585rHZJhgDNhKYHzaxSjXBDK7K0kXS9Bc+AcPZJ+pFiCEhbyrDtgVkqVxddQpYlV4phw6C/6mOys92+WQsTeZde/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TOfi8bA8; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TOfi8bA8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atNvdYmqt5psC82WDeAGfyKI6KjrvthFtPdFNrVn0ef8l5CsgWBjPurdDyS9ihQpSHsK/qQa/vPQyvS6Nm7fNp5K5eoj7xo7DNJsrEoQKgzHuUIXTWfFu9HREzWZJgs5HkSjmc7+3E/mQbynUIbH4WiYSVEeb+mfkOR2V+PoBlRF6PxF1aqcp4yKQmf/l3MEbRO6OiUQUP/K5dQm/da8cpg42PyL4ykisPD67ZMi519r1NEGXthe5DM1QqyJ9Rm89WFBQ5x7j7V/AjvW+VcobVq9knCeppJ//Q/mSxTo8maQroCbGD5PIHV3SvFrYpMykLAcPUxuNpoA1zCOM7FrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCpNpnBpDgI61YzOsPieX1EIHzgm05xIubpn+I3iOxA=;
 b=FvSImt5bZlibNJYxH4epH2ZMbzDWEeNiv3dZPurBj4WMtwhniwNM6nlA2qqvc1KUgxh++Ttv6keAYaI2ss6aNqWBZawTAPv7ZuLayKOMhIGUUZgPjWaUpUG4kk2p6+yzBbWjfdlJYvSRly3NAa8SEWSBLvvZT18E3dqNabTCcs2hcpaYHQZ1J6zeTr5BgT+I/A3OzHMoEgcjX1e9YHQGOzvNdE0K3ClWGERD8IeM2j/t32aEDitstgGOHVqxd0qdOp98+tpnX95jeSNUJd6n7PiAfvfU7Wcy6Laj96QXYsb9sYhD5SLQu4o4qPykjEY8egQ11S0OOssY5gzTl2E1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCpNpnBpDgI61YzOsPieX1EIHzgm05xIubpn+I3iOxA=;
 b=TOfi8bA8/zsb66tYt5ijKU6pD/cqn1z1wsBtamGveMG2SYtLXF3bD8UozmYWE646n7cJR8v+uZikpCGj/5XXF20q1bhrbzUCzmpOOdSdTGpK/W2yrvZ6Y987gB7JQCXFSzPvrKnpz9gHGatQlU22PB5ZXJGYD4N3DUdVek42AzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 16:24:09 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 16:24:08 +0000
Message-ID: <a80a43ce-a291-49f6-baf3-aa1340a3aca2@amd.com>
Date: Fri, 31 Jul 2026 21:54:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name
 Agnostic
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 den@valinux.co.jp, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com, devverma@amd.com
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-2-devverma@amd.com> <amjLTTa-OYtjiP1W@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <amjLTTa-OYtjiP1W@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0117.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::9) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: a7027620-f417-44fa-bc99-08deef2025b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|4143699003|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	oPUYYmxggaxLOWNMA9J5Z7rgMwdQYkzNZ/rQxCO9LuLMA1Jbp+pnuJciFsIkDC19fBi8PNJcqxGPh/sfaktOrPEW/INjwhI05plZ+AqPZGBvd9yEwRfwxjQkvnKv0fPmK08RYPIdPpRO7Ri2wFScwr49i7qab6rt0MlV0URHTT1hd3tsjJqwsG5jEXaiQRF12b8IEUffUgVzB/ayg8CPx4A+p6YFy+4A9H5yf7/cyDanGGNhFwUAGDefSp6SBryoIbg/iNE55h+COGvk+IkDjemD8lj3gEiPn1m+X2hQnVH+eqo3PNFChns9FFzpCWvoRawIWHGuk+ymhrWTrT3a+Cpxj34cGrtd011D1w1lMUBaPQRHJOKMXBfESK1i2nltdPZa9g+IavF0Ob/SC98J4Wowyjt/yhdt8fQ2vTqYtaQ9lTNGjayQkUbIDFhBJ7AezdDImull2FvuBhYv91HoRh7CuPOBmLOgOiZurbXIEkY1G4ruu0RLWtACMobC6lTu8TRTlgylGEkfA7Xk6HrRUmzcF1H1u/9tXEmHmdO3do5IilMzdNXOiqNvZeg/JImmKzTG/hqCyjBeZwaWNO2oVhdWBco+Q4ZU35uuQw/w1NRHUphDpHluURzKe9HuyF+pp1KjcjiaLYYjqldeQ7j1qZYfF6A2/o5N9R+oX7Sb6V0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czFLK3BCS1BmcEVRVHF0VlFxUEh6RXBkcWxDNXV2MlZzMlVlM2d2WW1BTnRC?=
 =?utf-8?B?cWExUzczNk8vVTFOSVJKeWYxSEd6RGFGUERUOWVTcy9FNVdpNVZGWVRpNk53?=
 =?utf-8?B?RytHSWhjWnE2UnhaUVk4SmNtZE1JZnhEUnZMekJlY0VkNmR3SGFPdGFiMXRO?=
 =?utf-8?B?dHVHb013cGF3Z284ZHNLVUNrK2hZY0w1TzYvNUFwU0RzTG1pNnoya2FBcHZT?=
 =?utf-8?B?cElxdjZySWo0SVEycXhwY1NyRDNlQ01YdFpianU3TEhmak9IdHVoTXFMbnhm?=
 =?utf-8?B?S05hdUowQ1BQVlY1QldYSUthNWZ6NmIwQ2g3eVJ6cnFQY1BqL0hGWExzNzZB?=
 =?utf-8?B?RWZkV002NndYdjlPL0xyTUhMaHlxWVRXQ2pxVWtGNWl4VlJ5ZzdGUVVWTDM3?=
 =?utf-8?B?SFYyRHRUV2JQc0JSbFFxZGZST1p4aDNxWUxsNUxoc2VFYUc4R1ZIUVIyOGNC?=
 =?utf-8?B?US9PbFVwc0ZYZXhCWHFxK3lnTFVINHhJMFpqcWQ5UnhQSktjUGMwSkN5Sm1r?=
 =?utf-8?B?WUtrWVB4K05OeGtnMDBVK1BwMVlkUUR2eVMvcDQ1SHlSbHBkYnRpcmN4Yk5a?=
 =?utf-8?B?V2Q3VzZTcmVlY2crU3Yxc3l0cmNhZFRBWXFDUExIWUdJQ1hVUklPd3FrSlJi?=
 =?utf-8?B?RE1wSEp4L2tRWkRvd2dmQWIxZUpFNDloaGVJcmpuKzFqTGNqeXlhTjd5YVph?=
 =?utf-8?B?N2hiakhZSUdncTM2S2s0bzl5UjFRVkg5dFpya0haKzhTUElBdG1aYldEVThT?=
 =?utf-8?B?aXFPNHhWNnBaVVU4NnVTY3EwdnNoOTZSODA1S25JS29nOTRxbWNlajFsTjF6?=
 =?utf-8?B?b1JhTFp5YW9MNnp5TW5xdzMzOUdNdWgwbDJ0azd6UW5GQkVMRTV2cTRTSTBy?=
 =?utf-8?B?T0J0VWQvODdWYitwL3J6Y0FOeTRHamxhbUpuRTV1NE8xc2lvZFJiMXdvdWJR?=
 =?utf-8?B?clNsY3hvdk9PR3pkWUJwUEtqOXowZHQyTjc2aUZLQnV6NlFFSldTZlNsa1ZQ?=
 =?utf-8?B?RVN0RUlJcDg1ZUZtNTNOMTFoZlZRb2ZaTzZWUzFHN0pSTUg1MzhZREtDNXZ5?=
 =?utf-8?B?UTFwNVN4TFNiMUZyK0xnamNHeVAxbyt1VUR4M3hzUE5jaEtTa25hVnVPQk92?=
 =?utf-8?B?Y1FrQm5zR3JuaVdhcnYxMlhkNFAyTkhtN0tmRXIxQ3BBQnhtMmJQd1pDbkRY?=
 =?utf-8?B?MjROZTg1cTFmMk5SdXQxejV4WUlBTkhHT1ZVMTJzY0ZUV3NnNkl5enQyTU9a?=
 =?utf-8?B?QUtJZXlETTlWeHhHVzMvRzdiVGpDZndtWXhreWZwOWNoRDdvZjVVQmp4MlVO?=
 =?utf-8?B?Y0wvUFZQWmNuUGFaOHk2L3l5dXlkUHFBcnIxZ2hUU05lVUs3V2tFZ0lwaVla?=
 =?utf-8?B?MC96ZFc3MFRwdzJRSVV4eGEzMmpCdnRkTmVSamNQcVZnaXdDMW9GYmFYVHFX?=
 =?utf-8?B?K0Y2NENrbGo1UGtHdlRTMG9tdUNjSmJWQkc2cUFrVlJyQ0Nna1FzblV5RDRB?=
 =?utf-8?B?TklGNUlzTVNPZm4zWHRLZHRjRHB4Yzl1KzdZTDRXc2NJWFpuaGF5QTRRRndj?=
 =?utf-8?B?UXp3QjhLVGp2S0VHRDE5aWROeGRSa1NKRTRrMDZBQS9KUGltOVdzLzkxZUlT?=
 =?utf-8?B?eFh5b29PaTF3MUtxeThFMUlKcWgxV2tpbUwxKzdhMFRzOC81aE1iQm4wT3A4?=
 =?utf-8?B?cmZGOEZqdlVIZGVHaW5leU1UN3MzUXkwcXpuZmtrSjByenhaTDZQcVROTmlU?=
 =?utf-8?B?Wnc3YmNPVXAzamZyK0Zucm5ycHhadStvWUhrdlNHTmM4SHZDZVFGRXU0NDBj?=
 =?utf-8?B?N282MFBlR0NBQ3BpT0d5N1dHeXBSQks2Ty9YMng2SFVLN0crbVU0aC9VVTNB?=
 =?utf-8?B?ZUt0d3VsVzh1NzhRbklqaGtxMThLS0xRL1JDTkFvWDQwZExVU1I3NVU3N3N3?=
 =?utf-8?B?THdZWjVlSG5ZZDdCeEdua01PbHM4YVgwbVZtN056bFJGSTljQWRYT2RWSXdH?=
 =?utf-8?B?Z1hldURwOFV5QkRqNk9sdVhTcmNwZkJpdGRzYTFxbkpIL1NzSWlsQjRuNTdQ?=
 =?utf-8?B?NWJYRWZpR3VUM3BJb2daU0tLWTBsR0dYZ1YyNVlnclZMRm5JdnRPa2NEMTE0?=
 =?utf-8?B?anZwSXhac0lTcjBxazIwVUc0bE1kcDlpb1hPUlMrTlpoMUMyTHpjUFh0dWxK?=
 =?utf-8?B?ZnFxSFdHazd2ZWN1NFEraEltSFA2ZGphNzYzV0JoTzBZUUJvbWl6dktjMWYr?=
 =?utf-8?B?YkNRdU9Ib3lBakprYU5ZdnRCN1I0THdaWWlDTmR2TUdtcTlaTU9lZ0JaUitE?=
 =?utf-8?B?dkxWWEVWdmJtWk9Iajh4d3VPOG1qaU5uaEJwbC9SNS9YMGg1NlUvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7027620-f417-44fa-bc99-08deef2025b9
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 16:24:08.7903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndP0jOvj9FdO59ZJIoU28UTRIBsZYsi7CMA6ekJ+IZRbFvmJn7ZdhJ6BGKNvifQr0cHVPE8OIOKnTNVC3nglTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021



On 28-Jul-26 21:01, Frank Li wrote:
> On Tue, Jul 28, 2026 at 02:47:42PM +0530, Devendra K Verma wrote:
>> Xilinx specific macros for MDB device can be reused for the
>> Xilinx supported other similar IP such as CPM6.
>> Renamed the Xilinx specific macros in a way that can be
>> reused for Xilinx supported upcoming IP, CPM6.
>> Naming is in accordance with the naming done for Synopsys macros.
>>
>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>> ---
>> Changes in v1:
>>     o No change
>> ---
>>   drivers/dma/dw-edma/dw-edma-pcie.c | 58 +++++++++++++++---------------
>>   1 file changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>> index 791c46e8ae4c..ec5e057a0f11 100644
>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>> @@ -29,21 +29,21 @@
>>   #define PCI_DEVICE_ID_XILINX_B054		0xb054
>>   #define PCI_DEVICE_ID_XILINX_B00F		0xb00f
>>
>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
>> -#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
>> -
>> -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
>> -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
>> -#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
>> -
>> -#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
>> -#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
>> -#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
>> -#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
>> +#define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
>> +#define DW_PCIE_XILINX_VSEC_ID			0x20
>> +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>> +#define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
>> +#define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
>> +#define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
> 
> v1, you agree keep use old MDB ?
> 
> Frank
> 

I followed the suggestion you provided at the given link at the end.
Talking of Xilinx based devices, the channel separation is fixed for MDB
but not for CPM6. So, I have have renamed the specific functionality
specific to CPM6 in 2/3 of the same patch series.

This one cleans up the MDB references and makes the functionality 
generic for all the Xilinx devices.

Suggestion: https://lore.kernel.org/all/amI09ZcfhX4SEPIH@SMW015318/

CPM6 specific declaration:
https://lore.kernel.org/all/20260728091744.1086942-3-devverma@amd.com/

- Devendra

> 
>> +
>> +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH	0xc
>> +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW	0x8
>> +#define DW_PCIE_XILINX_INVALID_ADDR		(~0ULL)
>> +
>> +#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
>> +#define DW_PCIE_XILINX_LL_SIZE			0x800
>> +#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
>> +#define DW_PCIE_XILINX_DT_SIZE			0x800
>>
>>   #define DW_BLOCK(a, b, c) \
>>   	{ \
>> @@ -258,10 +258,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>   	u16 vsec;
>>   	u64 off;
>>
>> -	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
>> +	pdata->devmem_phys_off = DW_PCIE_XILINX_INVALID_ADDR;
>>
>>   	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>> -					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
>> +					DW_PCIE_XILINX_VSEC_DMA_ID);
>>   	if (!vsec)
>>   		return;
>>
>> @@ -272,18 +272,18 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>
>>   	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
>>   	pci_read_config_dword(pdev, vsec + 0x8, &val);
>> -	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
>> +	map = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_MAP, val);
>>   	if (map != EDMA_MF_HDMA_NATIVE)
>>   		return;
>>
>>   	pdata->mf = map;
>> -	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
>> +	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
>>
>>   	pci_read_config_dword(pdev, vsec + 0xc, &val);
>>   	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>> -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
>> +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
>>   	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
>> -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
>> +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_RD_CH, val));
>>
>>   	pci_read_config_dword(pdev, vsec + 0x14, &val);
>>   	off = val;
>> @@ -293,16 +293,16 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>   	pdata->rg.off = off;
>>
>>   	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>> -					DW_PCIE_XILINX_MDB_VSEC_ID);
>> +					DW_PCIE_XILINX_VSEC_ID);
>>   	if (!vsec)
>>   		return;
>>
>>   	pci_read_config_dword(pdev,
>> -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
>> +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH,
>>   			      &val);
>>   	off = val;
>>   	pci_read_config_dword(pdev,
>> -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
>> +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW,
>>   			      &val);
>>   	off <<= 32;
>>   	off |= val;
>> @@ -360,7 +360,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>   		 * address use the non-LL mode or simple mode supported by
>>   		 * the HDMA IP.
>>   		 */
>> -		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
>> +		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_INVALID_ADDR)
>>   			non_ll = true;
>>
>>   		/*
>> @@ -370,10 +370,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>   		 */
>>   		if (!non_ll)
>>   			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
>> -						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
>> -						       DW_PCIE_XILINX_MDB_LL_SIZE,
>> -						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
>> -						       DW_PCIE_XILINX_MDB_DT_SIZE);
>> +						       DW_PCIE_XILINX_LL_OFF_GAP,
>> +						       DW_PCIE_XILINX_LL_SIZE,
>> +						       DW_PCIE_XILINX_DT_OFF_GAP,
>> +						       DW_PCIE_XILINX_DT_SIZE);
>>   	}
>>
>>   	/* Mapping PCI BAR regions */
>> --
>> 2.43.0
>>

