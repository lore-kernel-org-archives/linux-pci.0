Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9203DDDD0;
	Wed, 11 Mar 2026 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243464; cv=fail; b=uH65O+5RZ7WCLaUK+tGe5Sku6SPH+lQYoqsJPxstaZQPn2OlKk5rooIPxGW+Y/0aQnPKmL1ybMaIgkD7fpF0wbdllDvktL14EgOeVJoU5fWzOO6RwocgBebQRi3v+uVgWkwvKomcuJi++vk9elAEos91knk8v6eUvIkcQFQW7is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243464; c=relaxed/simple;
	bh=VpnNu0FMlueDVsX2qG6h0V+zqSvOIEUusOhbdaifIDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Im+BZj9Vrt7L6cjtQZeU5vVWxZx0ShmN4ZFU7jJvos6nwiSlIxLSpf9kdZTLZoxwI3vHNDF++x6LXnoeYlz/o1FQJhCM/mgZXPKGNluaE1EUqPQ6rtnF+vCdN8u7oqU5rjSoXPZELW0urlpezJI8H/9u/Hhj0YN4L3TbP4Evj2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rs9Iewn/; arc=fail smtp.client-ip=40.107.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rs9Iewn/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5BgG6JnUziGPWxY/f9z4CPbdYapBzBTtITihjo3WLA4Znd7h1EKtiQ7/cLvIBqLvLmo19o4BdqhnMvsKgeQKGMXgFqe455uQ4BZoKDqIrqIg4w58tjNJ6SbUzG13Jc90/s0Zpyk7UL8ioYTWELgzbo7Do+/e3CJ9bRptJzjgvaN23cW9n30WWQ2hu9mlUimas56wxwfdK5L56HYx+E2wRNMHJCys9ttMNRgNvuz6gUUkzd6GeGQJXH4UAJ/pDglD1BnX4L371rGYsT3FOsk2I4lrbPfWcJOnnxOAkAKyZqmTqFDFL7nTGKxKvu2YkK+r+Jcb1D9uzXkUCh3zx7SHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxE4dNfFEF15Gp/QCm7MyrDstXIfosE8crpKqgmkvuY=;
 b=FnrB3kPu+zUK4qQ4zt2eWlbpPCQbIHEjuwk3WY63HdoCcUykQDk84LjsCvGVlTIzfT1+MDkuffa2SVkdeFvVvLtqBkDkQ8WDhCQqyJh0W+F+LeCSHyQOkURi6HSIlmBHq7+lM+9CUXTSrcWTSXJYlIipAqEf3TR1BIT3xQmXhz13HwcDtrICk+Okh3pFWFPCbAy7oR9DLtXnlFLMm1phNUn5J7Vm8Arz82C/hIChBq7GBa8J3d8gX2b66Nf2CdonpqGlbvY0wndXqpYkEk+cQlEJ3aJHcgM0nDOOkalgFW1NtUxTZERZhF2gRoRkFZzTmA5FhP2iMeimp/lxAh0ofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxE4dNfFEF15Gp/QCm7MyrDstXIfosE8crpKqgmkvuY=;
 b=Rs9Iewn/AKxelUojggrIqnLYbO9NrvpujMKiMCzTkxRd4/pMTdjB1NOfH6hB/2xGrJ5ZyR7Fu82Hfovpq5UxiG5Xs2LDqsMfKk5N/FpmxpUT7BZEc9iKpxiLmQBMJ14aUsDwzECyJmzM6qLfrPY7gijHOLY91t8hNV6pXWIVGxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 15:37:38 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%4]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 15:37:38 +0000
Message-ID: <d225ba1f-c574-45dc-ab9b-18c3bf45f217@amd.com>
Date: Wed, 11 Mar 2026 10:37:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 07/10] cxl: Update error handlers to support CXL Port
 devices
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-8-terry.bowman@amd.com>
 <20260309140518.000009e2@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260309140518.000009e2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c42583-0ddf-4fee-6c52-08de7f842029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Fm9py7shDkB0a0emdyOMvY0X28zD0EQAlLBzRezHt/tdb2/eqrKw7kpcgMcwCOrvcGkhU8lNWySO3/kl3ZDhr+VyuQehpVePuixjj5svKad3qs0XlfuFpIniX3OilU0tLOw52NZNUgVEUUboKu9cZGJgg1+Rpe19YdBytkcBRWJ8XaZYNsxUNwWel9oh+68aqR6iBkW02GX9hSCfde6YkN+GQzCUZ0Rvte7D5JZYWsRAK08BXgh9tqIj4WNm2Uts1xh3HByRcj8N0t4M6rHcPbZhXZ75yilA4x00PD/lGn+QpwBhDyeMoaw8mWKR2d16Gi8vQyd0gNOh6Hl6An3cuQvVCBMPqP0qM7hLWg5gZi/TMsMu9URmlV/0TL7UlFf2UIXGwWGUgHZYE4FEVcwGAMcM1GmED9cShotXcqAQZVmc1gbif4lZ+PJ83YhatT1UcxzTTS4X0fqPhTVjIg1TkmPnBg/3HZbOdpuPmqs6WkaapI7sRSvHuejZgqBTamjY2FAMzB6Zy3drQdGeCpwpM6uz12Ci7KF5Tzp8zC5ju5QYG4e4Ly+AloLljZGxaILYhCCF2udwIuuGztTfbUJ2KCq1mOjzzKRrdQoQmyAcxquMPWVv4BsAasWENUYxDOn7xJFEVKK2NStMYiAAfEldIq8cqBO0I9IO51ELQTEvmlUjhqGZ9loA7xRyJEd2jN/1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zmk1amszWDU0V3grUDRORE5CaHRKQjZuYXhTVy9IZEVKYk5tWW1JRmFBT3hN?=
 =?utf-8?B?cGtGamxMcjdhK0x4WS8zOS9WWUFXVGxsZVFlaGhOV0NzTnBEc05xMC9MUXRE?=
 =?utf-8?B?UEVLaUVQZFAyY1hDbDdMODBicWV2VEFZOHZLaFZhVmFIaHVnSzY5UXVWNUU1?=
 =?utf-8?B?R0ExKzVObGt6WDhKbkRDYW9mc0dxY09HRDR5TXFnWUpSVm1nbzhVMEtoMXhI?=
 =?utf-8?B?SVNQeXQ3cXFqWTJvNzNwOTRJZWpzbHZVNlZWd1BzalV6N0N6V3J2OSs0Skc2?=
 =?utf-8?B?UkFRenM2SStHVVlUWjZIbzhteXQ0YzlYMEtWN0VPM2ZBcEsyOFJDczNaeVZC?=
 =?utf-8?B?eVBPdWVCRmRXY3NmbzRmM2pIOVlBZnlGYmVTL2QreUJVSmltUHBOc1FubUh6?=
 =?utf-8?B?RUlhd0I5ZTNjM090bVFrdkRJTXFVNnR3SWRIbjRISXByMnF2RTRoK0prTjlM?=
 =?utf-8?B?VDFFcXJrVXJRdFN4MUVMZVMxVzgvdmRLWVpnNkYyRmV0ZG95K3Y5UmlJeHlx?=
 =?utf-8?B?NjlVMGNjR2xwQmN4ZTBtYVJXNGZPS1hjV3FHd1pGMmJ3bGVmYitaMnlHUWUr?=
 =?utf-8?B?THR4ZERnS2RENEt2R3hmYzgxeHBrNi85L2ZOWXk2RUpmZTJyUXpsUi8xcjh0?=
 =?utf-8?B?aVZIOStPQ21OZmlxZWxiUzlJbVcwbkRTbHpyRk9NWUllUlhRR0FPeHQwMjZi?=
 =?utf-8?B?blRpd3krQVdQTnN6S3FqNy9qVnpKMmt3eVdSblFXY0RuVzZId2t1cml3ODgv?=
 =?utf-8?B?Zy9FNklaNGFMQW9sa3g4eFk0SmxLYkRiQXNVOVdRVHZ6QmpHUzdIa1lKcERn?=
 =?utf-8?B?OTZWOVJIV0R6UkRCV0tHT1MzZ3Z4ZTRCVzRndWlrVEdaaTIzV1hWQk9jOUhq?=
 =?utf-8?B?YVBvblJ0enF6Ylh0TXlZRDJXWHJXWXFwTzZZRzZXRFNPT01GanBKRVR1eUdr?=
 =?utf-8?B?RDBUS20zMmVNMVZZTjBlbHJjOXpiR09YUzd3Zm9GdEZMTDhkS05KcC9iaXRB?=
 =?utf-8?B?UnR0ZDdUTVpPVFNyMCt3Ty9YR3JJUzkxbkUrR3J2RWNYd3JmWDB0dm11Ui9s?=
 =?utf-8?B?M0o1aXhJQ25iUDcwdlVTcFVrNENseFZGRFV0SUFPSUJOK2tDazRVQ0UyWkRX?=
 =?utf-8?B?WmJlVDNjNkN0Y0ppZGxzdWhWSFJ2b3ZQanVrUUIzc1dsZFhsZXlWRVRTdUc4?=
 =?utf-8?B?Z2IyUG9FaE1zTjZ1MVRlSE9YTXc4Q2NZb3dPUG9zWmtKampEaCsrdkQ2dmcv?=
 =?utf-8?B?SFZzd1NxQUVYa2Q3YTdUcWlPeXhpenNaaE9IZjZON1pEYnRKL3ZXWi9ZcHh4?=
 =?utf-8?B?NkZ4akcvK3dQUDN1M0UxclV4WUY2NXBDVk9UM0xWVjBISzJ1Y01jM3NZcGN2?=
 =?utf-8?B?NFVVMDhmYW9wVDcrbTZPRXExUXhJQ2haSk9ueVBha2FXSzdxZnM0dGhXT28v?=
 =?utf-8?B?UlE1cExCQ1VLQzNWWStncUNrRjg5V3JJS3o1MkY1eCtWR1FobTVKcnBMc2Nl?=
 =?utf-8?B?T3lEbUZBMlkybnllUGp6UWlUZksyVE16aEdLMGUwOVNyYUdGVzhNT0pacHJa?=
 =?utf-8?B?NCtZRnA0VE1FRE51WEZJL1hrU2IzRzF5S3oxcWdhVmQ3NlVCRTZyNkxEWVNp?=
 =?utf-8?B?TG53YUo1NVBxVHZzUjZQSExma1NpbEJaTWZMczdDdjNJcXE4elFDUWdFV0Y1?=
 =?utf-8?B?Mmw2NjFWUFdZd09VR3JxaWZzK0NBWDdIckU5MTNybUVRYldETXdYZzVtQnIr?=
 =?utf-8?B?MkRGSVRKZ3krRUhIL3hxOFVtRlpISmdVdWNXSzZpOGo3R0xzRzI3czVpTmdy?=
 =?utf-8?B?dzc1Zm42L1Fta01KTWRXNGxoQytiTWhEZk1NZ2Jwc1RVSVlwVytzZHEyZTMr?=
 =?utf-8?B?aUJKSHJsS1VJS3dsRjhzMGtBVkhpQ2U2NVJoTTVGeWU3UXhGb0xjWGtaWWM0?=
 =?utf-8?B?ZVZNSUsvNTJ1L1NNaE9yYTFqSzJ5UXh0di91azgyNmhRQWpkc3RvUk11UTIx?=
 =?utf-8?B?YldjeFdJU0Y1V0VvN0FjQm9ESFFaNXlVK3Mwa3Vrak5zWjhKclpRQkJGTk5h?=
 =?utf-8?B?MURiUG5PMStjSmhwL09CZ0dNTXJwT0lSVU5RUXQ3VXl5Ty9ldjlsbjZoTFB2?=
 =?utf-8?B?bnZ5L1BsTmMwdC83a21GR1kvNEFhdUJ2bDlRR3d1d21CalQxdmY1VndleWlT?=
 =?utf-8?B?aVpBbkc1UFRsY2xKZzJSekZQY2dMS2JSeGlSOWx0YXAwUFh5cGg1YnVGbUFZ?=
 =?utf-8?B?Rjdod084NUdMVXNyd2o4RTgyMGsyZEdWRzZXUW82UnY0YnJHM2NIR2ptTFk5?=
 =?utf-8?B?Z2x0VzVMcno3cnl5VVR6MXl4amlpOTFjbkxoOUxBNDJVM2Q1emd3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c42583-0ddf-4fee-6c52-08de7f842029
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:37:38.6855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZI0ytAQS2qm51aLQgeUtSGF9kSubg94SrukjNcilxsjtJQ+AJAda0bjZ9tQ8+gyql8BiotVMmCN9mI+ACCqAnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433

On 3/9/2026 9:05 AM, Jonathan Cameron wrote:
> On Mon, 2 Mar 2026 14:36:45 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> CXL Protocol trace logging is called for Endpoints in cxl_handle_ras() and
>> cxl_handle_cor_ras(). Trace logging support for CXL Port devices is missing.
>>
>> CXL Endpoint trace logging utilizes a separate trace routine than CXL Port
>> device handling. Using is_cxl_memdev(), determine if the device is a CXL EP
>> or one of the CXL Port devices.
>>
>> Update cxl_handle_ras() and cxl_handle_cor_ras() to call the CXL Port trace
>> logging function. Change cxl_handle_ras() return values to be pci_ers_result_t
>> type.
> 
> Why this last bit?
> 

You requested in previous review this should return a value more meaningful than bool.
I changed to return pci_ers_result_t.

https://lore.kernel.org/linux-cxl/20260205171346.00001e6b@huawei.com/


>>
>> Check for invalid ras_base and add log messages if NULL.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> A few comments inline.
> 
> Thanks,
> 
> Jonathan
> 
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 48d3ef7cbb92..254144d19764 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -291,15 +291,22 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  	void __iomem *addr;
>>  	u32 status;
>>  
>> -	if (!ras_base)
>> +	if (!ras_base) {
>> +		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
>> +				   dev_name(dev));
> 
> This print isn't mentioned in the commit message. Probably needs some comment
> on why all paths that get here are error paths.
> 

Good idea. I'll update with those details.

-Terry

>>  		return;
>> +	}
>>  
>>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>> +		return;
>> +
>> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +	if (is_cxl_memdev(dev))
>>  		trace_cxl_aer_correctable_error(dev, status, serial);
>> -	}
>> +	else
>> +		trace_cxl_port_aer_correctable_error(dev, status);
>>  }
>>  
>>  /* CXL spec rev3.0 8.2.4.16.1 */
>> @@ -321,22 +328,26 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>>  
>>  /*
>>   * Log the state of the RAS status registers and prepare them to log the
>> - * next error status. Return 1 if reset needed.
>> + * next error status. Return PCI_ERS_RESULT_PANIC if reset needed.
> 
> This seems odd as normally PANIC implies more than reset.  I guess system reset,
> kind of...
> 
>>   */
>> -bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>> +pci_ers_result_t
>> +cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  {
>>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>>  	void __iomem *addr;
>>  	u32 status;
>>  	u32 fe;
>>  
>> -	if (!ras_base)
>> -		return false;
>> +	if (!ras_base) {
>> +		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
>> +				   dev_name(dev));
>> +		return PCI_ERS_RESULT_NONE;
>> +	}
>>  
>>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>>  	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
>> -		return false;
>> +		return PCI_ERS_RESULT_NONE;
>>  
>>  	/* If multiple errors, log header points to first error from ctrl reg */
>>  	if (hweight32(status) > 1) {
>> @@ -350,10 +361,13 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  	}
>>  
>>  	header_log_copy(ras_base, hl);
>> -	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
>> +	if (is_cxl_memdev(dev))
>> +		trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
>> +	else
>> +		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>> -	return true;
>> +	return PCI_ERS_RESULT_PANIC;
>>  }
>>  
>>  void cxl_cor_error_detected(struct pci_dev *pdev)
> 

