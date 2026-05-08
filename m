Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA4D2FFDD6;
	Fri,  8 May 2026 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259082; cv=fail; b=alswKFAP/MSQ67fOvXwzrZOK83D1nXdXZmpKQtztqeQtyYxjhDrU9nR4ykmWHNLSZMXT+nuxHwkK4JOaHl8YNW4xU21MIoGUblLfouiqTgKA+9YaCaIjwr1YXsziTvpc9iC0Ino4BKOI2+ZVYSVSrPs/zPIDpNvchFfTrYIRcYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259082; c=relaxed/simple;
	bh=qICeR3Q0eN2AwdCzvX7D80uBR24qB7rMVX2PFe+nkkc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CXHNegH9Mo/ndK3RIEzvgL8N0Y8OdP4O8Y8akIs8UcnzsWPAps/IQURh42v+3BSGmelIjXAW1JtYwVAiF2LqOJY2BUhMpoQSHWCMu/1XQQ0XiUvCG7BpAoMDjQx7dlJ/TqK03bbw4fBJxuXUqw5u7h+0e8S/xKZkZXv++PTBs3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cv3wfrk/; arc=fail smtp.client-ip=40.93.195.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cv3wfrk/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kilOTU3HP6A6F+gdX3++60soninc2sGkqtyS4jDmrO4Ksbw7ShAyJy/cIAxKz441FtkT6pD+MIKPHybkWBUjo/pT/8jegAA8Qi6CgipPPYImvvY05XHFyv4ydL5fuSPhUgTv515MEfWc4l/gM7/wYfCSrjXzAfsN2nLtlYm+qjyXmie58gSS3x6SNEljdAUJ+0dd7KQpW8dqokpYAND86xurw+WP/fb9nbimLa6Y5zgZLhEyxUd47HUNNSJV3hL/L6tsTkjzqSH+ces+weZM4kNZk+/OuCOkMI7zHC2mYssWSJooHWSoZhRfj9YX9BUHzj2JsRIa7ixGZF1sdgk/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls1r+y/BWYVSqiYddwZNOIr31lWZTx0kC8r04wweDxQ=;
 b=wobRZJY4KuUwj4rfCAE0sZbYRLmFMaVzVvaomK9/A0Rk2fv2t8AWZPwNdAIrinkTBvP7/z2BoC9M0s7sKGpojVIxOKO0HnMj/rsdbgRg3IZ2d9YAARaBBvmYTjR/T9+n0fnekLHEoG68WN+wPd2jJbNqZbE5gUvEXPPjhCUQidhHqcq6zVDeA0fHjTsF3uV6DCYmd/hTC8UWSgqPYtfrs1a8PVtnvLeXW2/PlxlMLtmi/ERJYH1zCsmCssVeixBsPYbV0DZOhPBbvzBO8pA0h9oCKUlRMvd1btSlNUqQp0P3/hXj+x9nk4soOLA+b3OSBv4yGIgTitvVDS3NyJqYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls1r+y/BWYVSqiYddwZNOIr31lWZTx0kC8r04wweDxQ=;
 b=Cv3wfrk/csKZcdRJ88g5VOf+CXTy9PFno0KCdfHU15aa3rXpkF+tuq3xyb5gnYrKC5iop6359FKvghz6GeyonLsxxva8cuv6phAfqeOt3H3rR6qrPFPukQ4mm5KRv5aHf40+FI4/KNpM9/DsK4ZUOo+MGszb5f5m3MfR78h+2Pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 16:51:16 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 16:51:16 +0000
Message-ID: <f682afbb-e816-44e6-9b18-fc7e2335706e@amd.com>
Date: Fri, 8 May 2026 11:51:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hwmon: add AMD Promontory 21 xHCI temperature
 sensor support
Content-Language: en-US
To: Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508143910.14673-1-hurryman2212@gmail.com>
 <20260508143910.14673-3-hurryman2212@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260508143910.14673-3-hurryman2212@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0413.namprd03.prod.outlook.com
 (2603:10b6:610:11b::11) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY8PR12MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: b7945aae-6b28-402b-e27d-08dead22053b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gkFZUhb8d5pTwuoBD30MD89nXgfOL3LAiTXkVh01Itx0FACm5u34hbGe2dfsPskaukntHIeQAURQ8mG1AQC1j64vtupB3WntZt5b1NyeA+aFllXuQXLN5kuOQDZWZLujrrUSrPim9IaCTt0Ortyh49gUxVrib0QNfswR6tItDrv3du+4m97fMGFXhHq/fh9zoPux4/L7IwEKgXyULPqDgE5oT+xV21vK6OQvQ7iL+5gQdE/46y8Oo/zmyyEG0hk4ZxKiCzI9ZNncWzLZGlNMHPH5m1WW96PyQVSu9QMFvboIHU/GuI7NTarEgXrAfIf946W6YIKc+xwYPS3RmOQgbm5yVhdKvreRSD9qfK6YGKl8k0DSf27ITbc5ozbvrtma/HtIYXHUFZn4yxlLAq26BVWe/sBNg5wcF0g3mywo55w+YtJATa7oMC0yBIhUY/LzxsnINygxx7vkXZkQ+RXgnu0FWDdPjVuPGNJg3EbC70CLqroMEIHzHdOi+ZFiSc5WC2qVr48kw/2TXltI0IxvhT6yv+ehL+qOJy0jh7LnZdvPDRI3PHrY/d3HPt7NfKGY64g5/XYLS+N+AvWHbAOQN5BMiJY4JPvEEWm5BwQSGSNuHZauIgu4JB7xt2EzTRY1ap541nuANtOX0Gw8S7rCLx+5hwhccMgbE4Lum9np6hPXagSRCg8Vk39B/lhhGHbZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkdKSDdQbDNmajVJbVV6UlBJNmlqN1NSeGtIWWlDa0ZuYkljdTBZdzVmQTF5?=
 =?utf-8?B?b2RyMXlRVDdIZkNQdHYxa01QM25qcXJtY2twamtXbEFhQmNGWERjWmdoMVBR?=
 =?utf-8?B?SWVUUXd2ZXRrOVM5MzRRQ0tPTEJpMGd2OHRBekJyd1hlRmpvamlXM3J0VXQx?=
 =?utf-8?B?YnYwVVZUOUNDR2crRHczS3JyT2cvY0wxbWU2L252b3FLc1dlUWNwcDQrK3hU?=
 =?utf-8?B?Z0RBZjNzSkxsam4vZWo5TEtRaXdTY3VYMVZLVkplbjBwR3Z5bWg5eHpMMFBC?=
 =?utf-8?B?TUJBZkJLRUFnS1gzZDVYNGhHS0I4cFNPQmpCZ1p4UkU4Z0VZOXBaR3hmRlFN?=
 =?utf-8?B?ejZaRWU0aVVrRUE2ME9HWVlrZi9SS3VHY0YxWWFrYm1kNnhFTVJsU1NKclBQ?=
 =?utf-8?B?cUJERk9wMFBCVkZ6MUxmblY5UWFQNHk1Q2xOWHUrQmpQUlBHU0FNOU1BbG5j?=
 =?utf-8?B?WXRiYmhGN3F2LzdRdHZ5YitHeHlMZU1oaFNScUNsQ1VlR0lyMytzQ2tJVWJL?=
 =?utf-8?B?bVBTKy85WlhIS1B5R3kzK3BSUWdlYWFhY3pXdDgzVGJhMDNJV0lwa2YvUVQ1?=
 =?utf-8?B?VUpPcFROcm0reEp2aUJsN01Hdk04RmZsRk1WM1htbms0blBDOGZMcWkvbVln?=
 =?utf-8?B?TGgyeTN0WkRTTWN6VUR2VG9vd2o2WkFIY1BNMDgzUGpUSmlQVHkreVdPdytq?=
 =?utf-8?B?aWN1UUhRdHhSQitSWFY1SDhZU1VzZ3lpZnlwaUJSMG1tZzF0T2t3MGJwOTVG?=
 =?utf-8?B?Y25KU3QzRmpHekNPdmVpQk5ZQ2Z6bklObXJLbE0yN3NqMEowWmc3YmhDY0Nk?=
 =?utf-8?B?Vkp6K1F0Q0tUNy9DMFZoNnhpMlJ2c1QrUGZrRUpDMCtmajVqWHJEM0ZENU9Y?=
 =?utf-8?B?SW9BSlo5TmtZdldpZHlmQU9OTEUwK2laUXA2dDRRaTdMSHdaRmRtbUdNNWIz?=
 =?utf-8?B?TzRmNjNJUm56MUZDMVF0ZjBwcVlpZzYyNDFsUU9XQ2w0eWlyc1dSVVhqRFU0?=
 =?utf-8?B?MFlxT3VRd0ZyUWF6V2RZbEFlU3hQTEkxalR4UTBrbXlMV1dOT1kxSzlmUVNQ?=
 =?utf-8?B?S3VtS3BvTEVWaU1KbG5KOE1yZDUreEtKeFMyYnprc3owZ1FCbUZpUmFYdjZz?=
 =?utf-8?B?aEZlSmdPVUdZVVBKYWlWVGQ1VGtDTU9KZ0ZNeDZJem94d2w0YnZRcnFaZzY2?=
 =?utf-8?B?NGhpSGk3ek1paUwreEJSQ2s5UnVyN25jVXo5V3I5ZlVPUHQ0SEMwQys0MWV0?=
 =?utf-8?B?S3Y5SEVLdmd0UTllbkNadDNvTlErQkp1cDlnU1hEVWNyRjQvVkRjejVYamxN?=
 =?utf-8?B?eFVRcHp3L0pMc3FiNmVySlZHTDN2YVNjS3JHeHJOYzJCMGI3ODFwVkxmK2kx?=
 =?utf-8?B?VjI5YWU1TXRlMHFSZUJuRHdSeUc3RnRCUjlCTFJ2dnFDVnMyWjREOEZZeW4z?=
 =?utf-8?B?NzE4aFRKLy9RcUxOQTNDWTBERmJOUm9YYklWazlzMm1OeE1NTUQwMFQyeHlu?=
 =?utf-8?B?akQ4aWR3aHcxV1BIWFloclppU3JnRWkzTGJ3bHN0c0x2VUxSMmcrTitmOEFm?=
 =?utf-8?B?U2pUZlhEZC9YRlluWWJyQVMwUmhrNlNGeWRMNmZxNEl3NjBRYWgwSUZ3REhX?=
 =?utf-8?B?Mkg0NitsVHRQQ1V3V2VRSjl2Ui9tV2Z1SDI4a1lOcm1iZVlBS1VaR05WdHd0?=
 =?utf-8?B?MDF5SDQ5SmQ2U3JXajFvS2NZS1E4djFKTm1zdWFvVWY5SjcwSXRIaUhUR1dL?=
 =?utf-8?B?b2pDVU9MSXM5enZ6Q1lOZ20yeVNWVklyL05MVEdEaTRSeENVYTdpMHNsa0dQ?=
 =?utf-8?B?WDNmLzRIVzRQbEFyNm5hbUtVYy9RODNOeHFDNkRBcURZRXNwc1hGWWVCQ3pP?=
 =?utf-8?B?a0RoU1N2clcrNTBWckVXdi91Q2NGdlpVR3hoM3ZQMm44OFFyUWpvZ2RTUEx3?=
 =?utf-8?B?SVI5M2FLeXZLZ0FYaDdYSXZxN29ZUEppUnhnQUhXcXVMdjhsZUVscjVYc2xi?=
 =?utf-8?B?Y1lGRm9DRnp1S3lOdSsxUFh1UmlYelFmczdYWnk2NXVsQVRINzFFNVJGYldI?=
 =?utf-8?B?eGtUV0lUTGQ2ZE15NmpnSjhJTUpXYjVCQ1lBYWFWaEVTL2IzL080UjVJdzg3?=
 =?utf-8?B?d2Rva1BjSDNydHlPNGFCYXB1Unh6ZllRQk1UY29pYkQ1Y0QwSXgxWFRkZDJh?=
 =?utf-8?B?cUU0TTJ4WjYwNW1tamZ5Zjk2MFFQTGFSRWtZdHlkeEQzVFQ3NXBpbTcraWxn?=
 =?utf-8?B?Qk9WL2MyYXl2YTJFdmVqclNxSnZ2d0tFcWNRMUtpRzFwMGsvTVZCVmFSQ0tT?=
 =?utf-8?B?dnYzNGdwSkVVRE94MEIxaXRrMmVPNEZDQVRnblpmZkxBU0h3OWFQZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7945aae-6b28-402b-e27d-08dead22053b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 16:51:16.2713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9W/3CgTJpRm6Iwq6MphHs6I/895RV4elg/IE1t8N1wmBATAKTD1gOfhZle7mAMwqEhS0cpLUJCZyR+20f08AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490



On 5/8/26 09:39, Jihong Min wrote:
> Add an auxiliary-bus hwmon driver for the temperature sensor exposed by
> AMD Promontory 21 (PROM21) xHCI PCI functions. The driver binds to the
> "hwmon" auxiliary device published by the PROM21 xHCI PCI glue and
> exposes the sensor as temp1_input under the prom21_xhci hwmon device.
> 
> The sensor is accessed through a PROM21 vendor index/data register pair
> in the xHCI PCI MMIO BAR. The read path restores the previous vendor
> index value after sampling and does not runtime-resume the parent PCI
> device; reads from a suspended parent return -ENODATA.
> 
> Document the supported device, register access, runtime PM behavior, and
> sysfs lookup method. The documentation also records the observation
> method used to identify the register pair and derive the conversion
> formula.
> 
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
> ---
>   Documentation/hwmon/index.rst       |   1 +
>   Documentation/hwmon/prom21-xhci.rst |  99 +++++++++++
>   drivers/hwmon/Kconfig               |  10 ++
>   drivers/hwmon/Makefile              |   1 +
>   drivers/hwmon/prom21-xhci.c         | 250 ++++++++++++++++++++++++++++
>   5 files changed, 361 insertions(+)
>   create mode 100644 Documentation/hwmon/prom21-xhci.rst
>   create mode 100644 drivers/hwmon/prom21-xhci.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 8b655e5d6b68..324208f1faa2 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -216,6 +216,7 @@ Hardware Monitoring Kernel Drivers
>      pmbus
>      powerz
>      powr1220
> +   prom21-xhci
>      pt5161l
>      pxe1610
>      pwm-fan
> diff --git a/Documentation/hwmon/prom21-xhci.rst b/Documentation/hwmon/prom21-xhci.rst
> new file mode 100644
> index 000000000000..10d03c4476c3
> --- /dev/null
> +++ b/Documentation/hwmon/prom21-xhci.rst
> @@ -0,0 +1,99 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver prom21-xhci
> +=========================
> +
> +Supported chips:
> +
> +  * AMD Promontory 21 (PROM21) xHCI
> +
> +    Prefix: 'prom21_xhci'
> +
> +    PCI ID: 1022:43fd
> +
> +Author:
> +
> +  - Jihong Min <hurryman2212@gmail.com>
> +
> +Description
> +-----------
> +
> +This driver exposes the temperature sensor in AMD PROM21 xHCI controllers.
> +
> +The driver binds to an auxiliary device created by the xHCI PCI driver for
> +supported controllers. The sensor value is accessed through a vendor-specific
> +index/data register pair in the controller's PCI MMIO BAR.
> +The auxiliary device is created by the ``xhci-pci-prom21`` PCI glue driver.
> +USB host operation is otherwise delegated to the common ``xhci-pci`` code.
> +
> +PROM21 is an AMD chipset IP used in single-chip or daisy-chained configurations
> +to build AMD 6xx/8xx series chipsets. Since the xHCI controllers are
> +integrated in PROM21, this temperature can also be used as a monitor for a
> +temperature close to the AMD chipset temperature.
> +
> +Register access
> +---------------
> +
> +The temperature value is read through a vendor-specific index/data register
> +pair in the xHCI PCI MMIO BAR. The driver uses the following byte offsets from
> +the MMIO BAR base:
> +
> +======================= =====================================================
> +0x3000			Vendor index register
> +0x3008			Vendor data register
> +======================= =====================================================
> +
> +The driver saves the current vendor index register value, writes the
> +temperature selector ``0x0001e520`` to the vendor index register, reads the
> +vendor data register, and restores the previous vendor index value before
> +returning. The raw temperature value is the low 8 bits of the vendor data
> +register value.
> +
> +No public AMD reference is available for the register pair or the raw value.
> +The register pair was identified on an X870E system with two PROM21 xHCI
> +controllers. One controller was passed through to a Windows VM, and the same
> +controller's PCI MMIO BAR was observed from the Linux host while HWiNFO64 was
> +reporting the PROM21 xHCI temperature. In the test environment, the reported
> +temperature was very stable at idle and the displayed sensor resolution was
> +low, which made it possible to look for a consistently repeating MMIO response
> +for the same reported temperature. During observation, offset 0x3000 repeatedly
> +contained selector ``0x0001e520``. Writing the same selector to offset 0x3000
> +from Linux and then reading offset 0x3008 reproduced the same raw value, so the
> +offsets are treated as a vendor index/data register pair.
> +
> +The conversion formula was empirically inferred by matching observed raw
> +8-bit values against HWiNFO64's reported PROM21 xHCI temperature for the same
> +controller. The observed mapping is:
> +
> +  temp[C] = raw * 0.9066 - 78.624
> +
> +Runtime PM
> +----------
> +
> +The driver does not wake the xHCI PCI device for hwmon reads. It reads the
> +temperature only when the parent device is already active. A read from a
> +suspended device returns ``-ENODATA``. Sensor reads do not mark the xHCI PCI
> +device as busy or schedule autosuspend, so polling the sensor does not delay
> +runtime suspend.
> +
> +Sysfs entries
> +-------------
> +
> +======================= =====================================================
> +temp1_input		Temperature in millidegrees Celsius
> +======================= =====================================================
> +
> +The hwmon device name is ``prom21_xhci``. The sysfs path depends on the hwmon
> +device number assigned by the kernel. Userspace can locate the device by
> +matching the ``name`` attribute:
> +
> +.. code-block:: sh
> +
> +   for hwmon in /sys/class/hwmon/hwmon*; do
> +           [ "$(cat "$hwmon/name")" = "prom21_xhci" ] || continue
> +           cat "$hwmon/temp1_input"
> +   done
> +
> +``temp1_input`` reports millidegrees Celsius, so a value of ``50113`` means
> +50.113 degrees Celsius. If the raw register value is invalid, ``temp1_input``
> +returns ``-ENODATA``.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 14e4cea48acc..fe0f14e247b5 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -951,6 +951,16 @@ config SENSORS_POWR1220
>   	  This driver can also be built as a module. If so, the module
>   	  will be called powr1220.
>   
> +config SENSORS_PROM21_XHCI
> +	tristate "AMD Promontory 21 xHCI temperature sensor"
> +	depends on USB_XHCI_PCI_PROM21
> +	help
> +	  If you say yes here you get support for the AMD Promontory 21
> +	  (PROM21) xHCI temperature sensor.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called prom21-xhci.
> +
>   config SENSORS_LAN966X
>   	tristate "Microchip LAN966x Hardware Monitoring"
>   	depends on SOC_LAN966 || COMPILE_TEST
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 4788996aa137..0bda542e8e2b 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -196,6 +196,7 @@ obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>   obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
>   obj-$(CONFIG_SENSORS_POWERZ)	+= powerz.o
>   obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
> +obj-$(CONFIG_SENSORS_PROM21_XHCI)	+= prom21-xhci.o
>   obj-$(CONFIG_SENSORS_PT5161L)	+= pt5161l.o
>   obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
>   obj-$(CONFIG_SENSORS_QNAP_MCU_HWMON)	+= qnap-mcu-hwmon.o
> diff --git a/drivers/hwmon/prom21-xhci.c b/drivers/hwmon/prom21-xhci.c
> new file mode 100644
> index 000000000000..f91303ce3428
> --- /dev/null
> +++ b/drivers/hwmon/prom21-xhci.c
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD Promontory 21 xHCI Hwmon Implementation
> + * (only temperature monitoring is supported)
> + *
> + * This can be effectively used as the alternative chipset temperature monitor.
> + *
> + * Copyright (C) 2026 Jihong Min <hurryman2212@gmail.com>
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/hwmon.h>
> +#include <linux/io.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +
> +#define PROM21_INDEX 0x3000
> +#define PROM21_DATA 0x3008
> +#define PROM21_TEMP_REG 0x0001e520
> +
> +struct prom21_xhci {
> +	struct pci_dev *pdev;
> +	struct device *hwmon_dev;
> +	void __iomem *regs;
> +	struct mutex lock; /* serializes index/data register access */
> +};
> +
> +static int prom21_xhci_pm_get(struct prom21_xhci *hwmon, bool *pm_ref)
> +{
> +	struct device *dev = &hwmon->pdev->dev;
> +	int ret;
> +
> +	*pm_ref = false;
> +
> +	/*
> +	 * PROM21 temperature register access does not return a valid value while
> +	 * the parent xHCI PCI function is suspended. Do not wake the device from
> +	 * a hwmon read; only read when runtime PM reports the device as active,
> +	 * or when runtime PM is disabled and the device is not marked as
> +	 * suspended.
> +	 */
> +	ret = pm_runtime_get_if_active(dev);
> +	if (ret > 0) {
> +		*pm_ref = true;
> +		return 0;
> +	}
> +
> +	if (ret == -EINVAL && !pm_runtime_status_suspended(dev))
> +		return 0;
> +
> +	if (!ret || pm_runtime_status_suspended(dev))
> +		return -ENODATA;
> +
> +	return ret;
> +}
> +
> +/*
> + * This is not a pure MMIO read. The PROM21 vendor data register is selected
> + * by temporarily writing PROM21_TEMP_REG to the vendor index register.
> + * Serialize the sequence, keep it short, and restore the previous index before
> + * returning so this driver does not leave the vendor index/data register pair
> + * in a different state for other possible users.
> + */
> +static int prom21_xhci_read_temp_raw_restore_index(struct prom21_xhci *hwmon,
> +						   u8 *raw)
> +{
> +	struct device *dev = &hwmon->pdev->dev;
> +	bool pm_ref;
> +	u32 index;
> +	u32 data;
> +	int ret;
> +
> +	ret = prom21_xhci_pm_get(hwmon, &pm_ref);
> +	if (ret)
> +		return ret;

Rather than using pm_ref as an output variable to indicate whether you 
took a ref - how about you instead always take a ref on success and 
return an error on fail?  This would feel more logical to me.

> +
> +	mutex_lock(&hwmon->lock);
guard(mutex) perhaps?

> +	index = readl(hwmon->regs + PROM21_INDEX);
> +	/* Select the PROM21 temperature register through the vendor index. */
> +	writel(PROM21_TEMP_REG, hwmon->regs + PROM21_INDEX);
> +	data = readl(hwmon->regs + PROM21_DATA);

You only care about the first byte, right?  Just use readb() and make 
data a u8.

> +	/* Restore the previous vendor index register value. */
> +	writel(index, hwmon->regs + PROM21_INDEX);
> +	readl(hwmon->regs + PROM21_INDEX);
> +	mutex_unlock(&hwmon->lock);
> +
> +	if (pm_ref) {
> +		/*
> +		 * Drop only the reference taken by pm_runtime_get_if_active().
> +		 * Do not mark the device busy or schedule autosuspend from the
> +		 * hwmon path; sensor polling must not keep the xHCI PCI device
> +		 * active.
> +		 */
> +		pm_runtime_put_noidle(dev);
> +	}
> +
> +	*raw = data & 0xff;

I personally don't really like changing the pointer when there is 
potentially an error case with it for -ENODATA.

> +	if (!*raw || *raw == 0xff)

Does 0xff actually happen with your runtime PM handling? Between my 
suggestion above to use readb() this can turn into:

if (!data)
	return -ENODDATA;
*raw = data;

return 0;

> +		return -ENODATA;
> +
> +	return 0;
> +}
> +
> +static long prom21_xhci_raw_to_millicelsius(u8 raw)
> +{
> +	/*
> +	 * No public AMD reference is available for this value.
> +	 * The scale was derived from observed PROM21 xHCI temperature readings:
> +	 *  temp[C] = raw * 0.9066 - 78.624
> +	 */
> +	return DIV_ROUND_CLOSEST(raw * 9066, 10) - 78624;
> +}
> +
> +static umode_t prom21_xhci_is_visible(const void *drvdata,
> +				      enum hwmon_sensor_types type, u32 attr,
> +				      int channel)
> +{
> +	if (type != hwmon_temp || channel)
> +		return 0;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int prom21_xhci_read(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long *val)
> +{
> +	struct prom21_xhci *hwmon = dev_get_drvdata(dev);
> +	u8 raw;
> +	int ret;
> +
> +	if (type != hwmon_temp || attr != hwmon_temp_input || channel)
> +		return -EOPNOTSUPP;
> +
> +	ret = prom21_xhci_read_temp_raw_restore_index(hwmon, &raw);
> +	if (ret)
> +		return ret;
> +
> +	*val = prom21_xhci_raw_to_millicelsius(raw);
> +	return 0;
> +}
> +
> +static const struct hwmon_ops prom21_xhci_ops = {
> +	.is_visible = prom21_xhci_is_visible,
> +	.read = prom21_xhci_read,
> +};
> +
> +static const struct hwmon_channel_info *const prom21_xhci_info[] = {
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	NULL,
> +};
> +
> +static const struct hwmon_chip_info prom21_xhci_chip_info = {
> +	.ops = &prom21_xhci_ops,
> +	.info = prom21_xhci_info,
> +};
> +
> +static int prom21_xhci_probe(struct auxiliary_device *auxdev,
> +			     const struct auxiliary_device_id *id)
> +{
> +	struct device *dev = &auxdev->dev;
> +	struct device *parent = dev->parent;
> +	struct prom21_xhci *hwmon;
> +	struct pci_dev *pdev;
> +	struct usb_hcd *hcd;
> +	int ret;
> +
> +	if (!parent || !dev_is_pci(parent))
> +		return -ENODEV;
> +
> +	pdev = to_pci_dev(parent);
> +	hcd = pci_get_drvdata(pdev);
> +	if (!hcd)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "xHCI HCD data unavailable\n");
> +
> +	if (!hcd->regs || hcd->rsrc_len < PROM21_DATA + sizeof(u32))
> +		return dev_err_probe(dev, -ENODEV, "invalid MMIO resource\n");
> +
> +	hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
> +	if (!hwmon)
> +		return -ENOMEM;
> +
> +	ret = devm_mutex_init(dev, &hwmon->lock);
> +	if (ret)
> +		return ret;
> +
> +	hwmon->pdev = pdev;
> +	hwmon->regs = hcd->regs;
> +	auxiliary_set_drvdata(auxdev, hwmon);
> +
> +	/*
> +	 * Use the PCI function as the hwmon parent so user space reports it as
> +	 * a PCI adapter. Lifetime is still owned by this auxiliary driver;
> +	 * remove() unregisters the hwmon device before xhci-pci tears down the
> +	 * HCD.
> +	 */
> +	hwmon->hwmon_dev =
> +		hwmon_device_register_with_info(&pdev->dev, "prom21_xhci",
> +						hwmon, &prom21_xhci_chip_info,
> +						NULL);
> +	if (IS_ERR(hwmon->hwmon_dev))
> +		return PTR_ERR(hwmon->hwmon_dev);
> +
> +	return 0;
> +}
> +
> +static void prom21_xhci_remove(struct auxiliary_device *auxdev)
> +{
> +	struct prom21_xhci *hwmon = auxiliary_get_drvdata(auxdev);
> +
> +	/*
> +	 * The PROM21 PCI glue destroys the auxiliary device before HCD teardown.
> +	 * Unregister the hwmon device here so sysfs removes the attributes,
> +	 * stops new reads, and drains active hwmon callbacks before the xHCI
> +	 * MMIO mapping is released.
> +	 */
> +	hwmon_device_unregister(hwmon->hwmon_dev);
> +}
> +
> +static const struct auxiliary_device_id prom21_xhci_id_table[] = {
> +	{ .name = "xhci_pci_prom21.hwmon" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, prom21_xhci_id_table);
> +
> +static struct auxiliary_driver prom21_xhci_driver = {
> +	.name = "prom21-xhci",
> +	.probe = prom21_xhci_probe,
> +	.remove = prom21_xhci_remove,
> +	.id_table = prom21_xhci_id_table,
> +};
> +module_auxiliary_driver(prom21_xhci_driver);
> +
> +MODULE_AUTHOR("Jihong Min <hurryman2212@gmail.com>");
> +MODULE_DESCRIPTION("AMD Promontory 21 xHCI temperature sensor driver");
> +MODULE_LICENSE("GPL");

