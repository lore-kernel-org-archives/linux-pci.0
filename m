Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B87D37CD54;
	Fri,  8 May 2026 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258428; cv=fail; b=YBlB4Git7n7FkcH19AMSDt5LKywBtZC+ykKBdw8flzrFxRdZhV6wdrCwJC+8vS5cuMIMRDW1kdVN2hco9dA8VGU/f4mhqWQL6svvjiVUN8RBvEvRdrArjYoiPUxM8aV7rjCYPXsNNK13MEVcqrZTuYP34xWVezdqJg8NExTAeVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258428; c=relaxed/simple;
	bh=uhjpmrm/AXSuqMTylyILM9uSP5fptSAzRiHksGu26Ww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E3q302WNWuD7A9IiiLPMCCMjEM9Mtu1VNYFekGgG3t4DsE1edQthmnZmINRDsRJdH+pfelGsb+2YMwAib5teKXjNKjbcgRRn4/yB8hUUC02ngtD4+kSPygjq2WGKCEcRhNC8HELfzP6PpEwxNkuj7ksuDgrI6K0FgtcxQMBi0Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HqdSthh5; arc=fail smtp.client-ip=52.101.48.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HqdSthh5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mnw3M4b/N5w7ysrqmTfdIEqwwd8l1UptKGCHRXub8kuZVj17ErCgi9qQ68vVDxNgl0PMCiDn4d3FKiyMRD7hDO5oHaGWwqjCibfjH7vtbHijSyC0gBkrtwKUDo5xhVZe49vn5GYDRZST9kGE/vFXC9ptfm1d0PhFkVxsqfDmZSf/qC7GJPIDt3ohrzNI4o5iyQx0R5oucFWC25F8Sz3n5M4zwOTtJZdZs0HO8C77fGbtD3MoK98wV9bszWgzi77RUTed4OI/CHgzyIHfFa8TgymQ3HFSBNist7oUn3JI2vEZH7lfLefIXW5AOlHygniGblRgsRSs+yCbgjrdiupw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OngtIOU6H/deE3m3Z5jZ12ZrgqnqDjKRABLBQPiMV8Q=;
 b=LHvZYQlpnMgtVovnRVfaW4dLNwihwGoKIOwHXCnU+ofi8r4E61v1237e7X/A5vR7Io9Wv9qR56z4ElCyuLYTsY9YNAuCyYRZhN3S6+PSZZkIwjINr0GwZ5eCJ+VjtaZmkdNbs0jfvjyFgrFe0moAETSlmNR42U3CNFV5lzqHy4xkDlvPzmEOvpQA/V87uKHNi64MMPryEgeQxeOSnbVZLQZCLV/8Zgpqmm7bDgAReX45def1ni6sJiOOsxfIzmk74rvoiir9Kq3OxnuwG/E5EHMLmKOyLRvFi/1AqxU/LvCWrIedXEF1ec8kiLbXOS6i4UtrIHZPbMrTdfy2YqVjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OngtIOU6H/deE3m3Z5jZ12ZrgqnqDjKRABLBQPiMV8Q=;
 b=HqdSthh5NnJnCJHaMchxyRZDvg4eBeaKCfYQR8CdwpgdBuP+sWMvlKoqt4Yqw+Zpa01U/LXINVlXEmnhNqUJhKweic9hLU3GxYclOTvEORZPKq7RAJX8coUhowQmBp1uGWu+mwkvayppmu8WLEy52r4ALL9Zbr1/2muTfic7djk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 16:40:23 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 16:40:23 +0000
Message-ID: <ad41d70b-e9c0-446e-8bd0-4528de75b592@amd.com>
Date: Fri, 8 May 2026 11:40:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
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
 <20260508143910.14673-2-hurryman2212@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260508143910.14673-2-hurryman2212@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SA1PR12MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: 376a5f8f-ee62-4c6d-dce4-08dead20803f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LY7qWFoqBJaZ5uaDSTIs8pLckjGx7qObYYUZsdCEl+tg0gmBsT9Q9qKQa4CmxSPE3iQ2xyMXV8ifcgclvYqOChg7T1rzE+uYeGbXB/ZcGVryc/PIb0ADEWetyysYOzy2XTrXAr0aQS6FAc6TiFzNhOr0sDlMgzT1fWUg168QTO8xnMRNG3lgvssnWLmN2xIuzOVKTzjbqf9Sy+JFVG3Ge7eUCvKdN//RG3xEIOIJ1Us2hKkd1GT/8/LuSwV4lGGYIdj0SuBvTB8zDFwQOIcP5pIgKhT2GdZkd9T9Lk/TME6AJk1vILJErh8Oanhu8qamAWhvpeVnegP+5YzwxZ7ll9DsrEGDBNIox5Ar1wC6H29a8AFXZgiCcZwHSj9//depiAXnGFIODwYeYwWLqyzUKq9TDgvURFRhj5cWn/uYWh1jWmUuM5bUZvVDENDSE6lTprguNqKmMHC8Ab7D4VQqMpc9dM/nYqJc3q4pOFlWFIb1R49TqzUqnLVPAv3zH/lEwa4WUkwW7AF8Mf/VarXkutGWWVptFbFc8p93C6saMXCLLbw9okYVQsJU53pCJpqv1mhgU5DAwln9q9eVRJDBFzTpZHhqR9kiooR1zX7vtOSPplW7KeqW5U/07imMmvCzI+r2hbRlBUEeqVRapb9z0qSomFHwopBqk9cyE/WeUyGs+i1YfLD2NDSEiXCcaOV9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTdVcisyRW5QUllhU2NpNDlLNHUyT3JZZzdFTldDaUw1SWI4KzErVGdUelBN?=
 =?utf-8?B?ZmFweFRsZzZLd3pUTGQ3a3ZpWUhOVXRXQUwxeUQ0bWljNVhrNmg3cStwVWQ5?=
 =?utf-8?B?U3JxL2ZwRlVmaXQwaGxiL0IvUlNJNEtKcHRSbXRZanBqeVB2MjVRTENqSzN1?=
 =?utf-8?B?NmNUTVBQeUtSbjE2T3RBOXN0UjFhSUxoSnZBemIxelVSbENJOEk0Y1JQdGh0?=
 =?utf-8?B?Vm1tS2E0NWYwUWhjUEJvb0FrTmZLa0c4QnlqWUJEcEZvaTU0VFJNOWJ4cmpD?=
 =?utf-8?B?dEI0aHFNc01tRUVtNTk0S2FDYThPVjE0TFhEMk5Fbis5cWRyN00rMS9HbTF3?=
 =?utf-8?B?Y2dCVlp0ejBuU2ZpMTFqckdFSWJuakFTMytnNzg5dzdicWFXT3c4b0Y0ZHhr?=
 =?utf-8?B?czBoNlVXYzdwdFF2ZFpqaWJpengrOWRCTkNjb1RMSlNISDF1SVF3aGRVcVJV?=
 =?utf-8?B?cTVMT2Rha0tSRlBWZFRKSUphM2NOMUtPTlJCQVA5S1YxaEd0aGg4V0R5N1dh?=
 =?utf-8?B?bnAwOEsrNFZPdVJDdVgvQ0pkTmZJdHU5eEZIMXl1QWt5cHpCc3J4QkpqRHNv?=
 =?utf-8?B?bGl6a0R6R2o2c3dRRXplOWMwK0NDSVpGbGF3T2U1aEduTGJ1a2dLK0NkVWFH?=
 =?utf-8?B?ZVIzVzdxTVJCQ3NhYUtYbXVkWi80dDVyV1llVEU2Q1R1NkxCK1dDRDJQZ2dY?=
 =?utf-8?B?anVXQ1ExU3FvbzFhVGh4R0dLU3QyRnNybjNyQzg0RHBFc2l2SjdpRTBpSk9G?=
 =?utf-8?B?MVlDWmp2cVU4WURLTmNua2Z5V1BIV1NuaWkwV1pLYUlyRWpDQmNNd2ZGNEw5?=
 =?utf-8?B?N1JTMEExQ0NxM3A3bHIzOUlXQnNTb3pwN2RxVm52ZnNoRGtwOCtBVnNOREhF?=
 =?utf-8?B?MkpVNTh6YlNJem9jc203R3pWTkxnbUlqaWtUVVdscE9JUmNJWGQyZnNiMnJk?=
 =?utf-8?B?ejFIaTUrbGxBWmRYNE4xMGJkeHVzVVNmcEdUSFVhV0ZBNW1vNmRhK1lQNnZ4?=
 =?utf-8?B?SzJadERHdyt0b3ZuZENKMWEraWlLVWo4eDloYzZJcVJQTUo5UnMyT1RBTkJs?=
 =?utf-8?B?MmJXdHBNRkE5VlRLNVBTUWIwdTcrN3ExSzBlUjdVR1I4SE5oWFhtRTJrbE9O?=
 =?utf-8?B?WnBLUU1uYnJVa3dmYUFNb3RYclE3My9wQWNmcTBEZ3BseVdGdVRaSUVzOVk2?=
 =?utf-8?B?dWtnZHlGQUk2RTBzSndZZlZHVGxkaVdKVHl1NGUrVm9CdHRxV3dMUFNHRXZQ?=
 =?utf-8?B?RWFkb09TVzE3dUY2akY2V25uZXRXcFRRQTF2dlFwbENibmdoWnhxbWhxSG1E?=
 =?utf-8?B?NXBVOWhzd0x6MWtNenJoRW53ZWVBZ25jZkQrQTB3OW9CUDNhNEVCM2lkM0RJ?=
 =?utf-8?B?VTRQQk9CcW04bVlVMlIxZFdveEplUzFhOVhlZVlqcmo3NCtYeCtnZzFrSURZ?=
 =?utf-8?B?MXZ2REt1R2FCM0FKdHNKVzdVQ0RudmRVTW1IWU5RZFBnSURFZ3ZXSXB3TG5G?=
 =?utf-8?B?NnJROTNzT0JEWmlSRWlONzlIUDlKZVlESnlVcEFhaFFySFVkdTJPZldYZXZW?=
 =?utf-8?B?NWYyd1lrem9KNUNhdTlCRkdXRzQvU2FISXQvcDkraXpOMmM3aVJyODRSWTR1?=
 =?utf-8?B?ZndtTHBUc0I2cHVXenROanlrSHNtQWVwcE9qa093T3pzWnV1cTNWU2paSVNY?=
 =?utf-8?B?ZENrK0RwMzhtU3ZGbWdEL21PSW55c1o1a3VuTFlRMkQ3cDZDcmlzUEFVS3Ir?=
 =?utf-8?B?M2d1Z1ZheVZoQ0lXbEhLWVYreG5OSHJXL3lta0J6UUdGanJGeis0OVBnWEgw?=
 =?utf-8?B?c28zMlIwbjBiQkovQUxCZUpiVVNXWncxUWZPVktrUDF3QXQ4bE1od3gvbldC?=
 =?utf-8?B?ZEd2YnhIMWsyb3hybmx1VUEwaVBNNXpOQUc0ekZabGRnd3N0UU1MT2loWXRZ?=
 =?utf-8?B?MjJQYjFTRXN6Z3Juc3QrRDJCTlR4bFQrNnNta0RvbUxwN2xyTFI3TlJqY1Fi?=
 =?utf-8?B?WVJvZCs0OTZ4ZVR5SFRBeVlEUFV4N2t6Mzd3MDRML1dkck9EQlQ5NGdNd3li?=
 =?utf-8?B?bnB0eFg0RlFqUEc3QlZjZ2RuMG8rNHBjVS9TdDZqSUhHc2ZjSEtjVzI5QTBh?=
 =?utf-8?B?QlhGeGVZNk16aDJ3Z2dZOTJNNWtyK3ZsazBUR0hhTUFVSkprSEk5TlhTZ3ZO?=
 =?utf-8?B?RjZ2bEtBUm5Oa09JRzJmTk0wTkxpRmRQbWh2bzdtYXJDQ0pFWUJTaDdoSWJ0?=
 =?utf-8?B?VHRJSittSGdSTnR4KzhycVdaNFErN2w3cWhYc3BESWdPa1o0L1htQjBrN2FM?=
 =?utf-8?B?SC9BaU4vSWpsdDJLaXhKTThmS1ZvUlI0NVVZZFdBbEM4QVcyMEw5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376a5f8f-ee62-4c6d-dce4-08dead20803f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 16:40:23.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4FkqLh8ul7NCtohIf+qwAw6fIm6r6slInVk8J762SvSYKW7icGXEXmfpBDuekU2G3P9ItiOeqTwgTC9ej9N5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8697



On 5/8/26 09:39, Jihong Min wrote:
> AMD Promontory 21 (PROM21) xHCI controllers use generic xHCI
> operation, but the PCI function also exposes optional
> controller-specific sensor functionality. Add a small PROM21 PCI glue
> driver for AMD 1022:43fd controllers.
> 
> The driver delegates USB host operation to the common xhci-pci core and
> creates a "hwmon" auxiliary device for optional child drivers. Failure
> to create the auxiliary device is logged but does not fail the xHCI
> probe, since the auxiliary device is only needed for sensor support.
> 
> Keep the PROM21 PCI glue built-in only when enabled because it owns the
> PCI binding for PROM21 xHCI controllers and must be available whenever
> the common built-in xhci-pci driver hands those controllers off. This
> avoids an early boot case where generic xhci-pci rejects a PROM21
> controller but a modular xhci-pci-prom21 driver is not available in the
> initramfs, leaving USB devices behind that controller unavailable.
> 
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
> ---
>   drivers/usb/host/Kconfig           |  18 +++++
>   drivers/usb/host/Makefile          |   1 +
>   drivers/usb/host/xhci-pci-prom21.c | 111 +++++++++++++++++++++++++++++
>   drivers/usb/host/xhci-pci.c        |  11 +++
>   4 files changed, 141 insertions(+)
>   create mode 100644 drivers/usb/host/xhci-pci-prom21.c
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 0a277a07cf70..74eedef1440d 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -42,6 +42,24 @@ config USB_XHCI_PCI
>   	depends on USB_PCI
>   	default y
>   
> +config USB_XHCI_PCI_PROM21
> +	bool "AMD Promontory 21 xHCI PCI support"
> +	depends on USB_XHCI_PCI=y
> +	select AUXILIARY_BUS
> +	help
> +	  Say 'Y' to enable support for the AMD Promontory 21 xHCI PCI
> +	  controller with optional sensor support. This driver does not add
> +	  PROM21-specific USB or xHCI operation. It binds PROM21 xHCI PCI
> +	  functions, delegates USB host operation to the common xHCI PCI core,
> +	  and creates auxiliary devices for optional sensor drivers.
> +
> +	  This driver is built-in only because it owns the PCI binding for
> +	  PROM21 xHCI controllers when enabled and must be available whenever
> +	  the common xHCI PCI driver is available. The optional sensor driver
> +	  can still be built as a module.
> +
> +	  If unsure, say 'N'.
> +
>   config USB_XHCI_PCI_RENESAS
>   	tristate "Support for additional Renesas xHCI controller with firmware"
>   	depends on USB_XHCI_PCI
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index a07e7ba9cd53..174580c1281a 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
>   obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
>   obj-$(CONFIG_USB_XHCI_HCD)	+= xhci-hcd.o
>   obj-$(CONFIG_USB_XHCI_PCI)	+= xhci-pci.o
> +obj-$(CONFIG_USB_XHCI_PCI_PROM21)	+= xhci-pci-prom21.o
>   obj-$(CONFIG_USB_XHCI_PCI_RENESAS)	+= xhci-pci-renesas.o
>   obj-$(CONFIG_USB_XHCI_PLATFORM) += xhci-plat-hcd.o
>   obj-$(CONFIG_USB_XHCI_HISTB)	+= xhci-histb.o
> diff --git a/drivers/usb/host/xhci-pci-prom21.c b/drivers/usb/host/xhci-pci-prom21.c
> new file mode 100644
> index 000000000000..7354a898732e
> --- /dev/null
> +++ b/drivers/usb/host/xhci-pci-prom21.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD Promontory 21 xHCI host controller PCI Bus Glue.
> + *
> + * This does not add any PROM21-specific USB or xHCI operation. It exists only
> + * to publish an auxiliary device for integrated temperature sensor support.
> + *
> + * Copyright (C) 2026 Jihong Min <hurryman2212@gmail.com>
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/device/devres.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +
> +#include "xhci-pci.h"
> +
> +struct prom21_xhci_auxdev {
> +	struct auxiliary_device *auxdev;
> +};
> +
> +static void prom21_xhci_auxdev_release(struct device *dev, void *res)
> +{
> +	struct prom21_xhci_auxdev *prom21_auxdev = res;
> +
> +	auxiliary_device_destroy(prom21_auxdev->auxdev);
> +}
> +
> +static int prom21_xhci_create_auxdev(struct pci_dev *pdev)
> +{
> +	struct prom21_xhci_auxdev *prom21_auxdev;
> +
> +	prom21_auxdev = devres_alloc(prom21_xhci_auxdev_release,
> +				     sizeof(*prom21_auxdev), GFP_KERNEL);
> +	if (!prom21_auxdev)
> +		return -ENOMEM;
> +
> +	prom21_auxdev->auxdev =
> +		auxiliary_device_create(&pdev->dev, KBUILD_MODNAME, "hwmon",
> +					NULL, (pci_domain_nr(pdev->bus) << 16) |
> +						      pci_dev_id(pdev));
> +	if (!prom21_auxdev->auxdev) {
> +		devres_free(prom21_auxdev);
> +		return -ENOMEM;
> +	}
> +
> +	devres_add(&pdev->dev, prom21_auxdev);
> +	return 0;
> +}
> +
> +static void prom21_xhci_destroy_auxdev(struct pci_dev *pdev)
> +{
> +	devres_release(&pdev->dev, prom21_xhci_auxdev_release, NULL, NULL);
> +}
> +
> +static int prom21_xhci_probe(struct pci_dev *dev,
> +			     const struct pci_device_id *id)
> +{
> +	int retval;
> +
> +	retval = xhci_pci_common_probe(dev, id);
> +	if (retval)
> +		return retval;
> +
> +	retval = prom21_xhci_create_auxdev(dev);
> +	if (retval) {
> +		/*
> +		 * The auxiliary device only provides optional temperature sensor
> +		 * support. Keep the xHCI controller usable if it fails.
> +		 */
> +		dev_err(&dev->dev,
> +			"failed to create PROM21 hwmon auxiliary device: %d\n",
> +			retval);
> +	}
> +
> +	return 0;
> +}
> +
> +static void prom21_xhci_remove(struct pci_dev *dev)
> +{
> +	prom21_xhci_destroy_auxdev(dev);
> +	xhci_pci_remove(dev);
> +}
> +
> +static const struct pci_device_id pci_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x43fd) }, /* PROM21 xHCI */
> +	{ /* end: all zeroes */ }
> +};
> +MODULE_DEVICE_TABLE(pci, pci_ids);
> +
> +static struct pci_driver prom21_xhci_driver = {
> +	.name = "xhci-pci-prom21",
> +	.id_table = pci_ids,
> +
> +	.probe = prom21_xhci_probe,
> +	.remove = prom21_xhci_remove,
> +
> +	.shutdown = usb_hcd_pci_shutdown,
> +	.driver = {
> +		.pm = pm_ptr(&usb_hcd_pci_pm_ops),
> +	},
> +};
> +module_pci_driver(prom21_xhci_driver);
> +
> +MODULE_DESCRIPTION("AMD Promontory 21 xHCI PCI Host Controller Driver");
> +MODULE_IMPORT_NS("xhci");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 585b2f3117b0..5db427ad0422 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -84,6 +84,7 @@
>   #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
>   #define PCI_DEVICE_ID_AMD_PROMONTORYA_2			0x43bb
>   #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
> +#define PCI_DEVICE_ID_AMD_PROM21_XHCI			0x43fd

This define should be in a common header used by xhci-pci.c and 
xhci-pci-prom21.c both.

>   
>   #define PCI_DEVICE_ID_ATI_NAVI10_7316_XHCI		0x7316
>   
> @@ -696,12 +697,22 @@ static const struct pci_device_id pci_ids_renesas[] = {
>   	{ /* end: all zeroes */ }
>   };
>   
> +/* handled by xhci-pci-prom21 if enabled */
> +static const struct pci_device_id pci_ids_prom21[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI) },
> +	{ /* end: all zeroes */ }
> +};
> +
>   static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   {
>   	if (IS_ENABLED(CONFIG_USB_XHCI_PCI_RENESAS) &&
>   			pci_match_id(pci_ids_renesas, dev))
>   		return -ENODEV;
>   
> +	if (IS_ENABLED(CONFIG_USB_XHCI_PCI_PROM21) &&
> +	    pci_match_id(pci_ids_prom21, dev))
> +		return -ENODEV;
> +
>   	return xhci_pci_common_probe(dev, id);
>   }
>   

