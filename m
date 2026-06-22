Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75653CCFD4;
	Mon, 22 Jun 2026 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144569; cv=fail; b=c2VbvpE5xN7sEyIUU87lkMH3e1A2Z0FnTtW9czccWEUx2sBQhA2QoFOO/TZBjgf2PSZKgPw8xL5BA94wpLAznCMU3r4DridWeleTuT1xYr6vQARYo2CIjbSXH5T0iYd9N9cD8iDSKVGlXwwb5Tw4LO1HPZz+qu5GpMJXtK+Z028=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144569; c=relaxed/simple;
	bh=jhiuNXJPOZSkMdriZfqmd6FRygAVuAixfaHi5gY+cVk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RXeAsaY5AGbVfx7ANz/bFxvF+jlzkrH0hDGe6bcW7cmCx7H5Hc7K8wgqNT61nhMnXdFqF5ESafkHbVD+TJpGH6mUNXgcGlXvROWy31qBp9/6UiCvn+IfpkLEVzrlZ3EtyiNM5tTGgbeVrzxOdKfq8lbKb4elu7EeCmUnZXKE9fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UhHkXdFb; arc=fail smtp.client-ip=40.107.208.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UhHkXdFb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhfKfnIuIw/3Wb78DfZWlUo+5nJj2UYYZlI7YxIjTy2x3pgI6lqT3kCIsvRsiovIiY5IPdLOC8vGXw+BX9NyM8n/TsAQ570azI+pmXsDe3T1VS5BQ93ymjcuUMRdHie38OyljvGoL8qvxSABhTfaSJLrXJdxOLEQeJI4uD9h3DvohTSHWLEDK7R0rVN/I3GXU8deCzlo5FQqsEXiOoY8JnchY2hSQVQGwWi2ovHCBX5b0SJ+3AMFmVVl+GIIdPM+ZN1ItmRw2pN4MBYxgF+RXBna+kU4j+JK6ZbIUqoD9Uutg3bm6wpyUk5apYm6C3e26nkBMgqp2xnVXeTcUKFwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utSrvD9CZjb9N5vj2GcDjxkTnwtY0MGJkvk/mn27HOY=;
 b=dYKYX1/Zj4NUTAqX//5ZIn5sITP/co/18WrKbRv7ABp+xgaeqaV4HHIHXrtJ58J2gZVSBy13xGl4gI1NDGmNWWyZkKeAzlvAfDPSn5b248AC7PYtNyDzW4Yq6cYpQGOUThGtuRF5qYDWKxn1GXOI59J109OC+/+0b9asQrbuU5QGSc85xOR9Dbo2QBlvQvUtbxQBRSZygAJlA20WHl60yiIGJYl63xQHf/3ON2TTb97yTGviH919zeeez2PErKT2PZ5RBvy+nCWGopivAsyMysCUaaPN2nBvROt5K4N1GyBNvWU+W7ybGpXqzzwmy5GspWLZYR/0VyaVVQhiAQGxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utSrvD9CZjb9N5vj2GcDjxkTnwtY0MGJkvk/mn27HOY=;
 b=UhHkXdFbid/ERs2BsMSE2HB/3UJGL31mXOHkAt7r8nNSWJ4fz9ckjvmHyYVy/HJy92W2iD28JXO7OgQ+EWYJnEEvSWBbGwKplpPADJ+NW/XXp6IqNV/bUh+huYA4d3OLlpgSMoSvuF+WomY8HZqz5tNFhSrXlO517abJesTl6yM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 16:09:23 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 16:09:23 +0000
Message-ID: <686c79f1-f4d5-4c76-a57d-fd124c0c1af6@amd.com>
Date: Mon, 22 Jun 2026 09:09:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: vgaarb: Include 0x0380 devices in boot VGA
 selection
Content-Language: en-US
To: Aaron Ma <aaron.ma@canonical.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20260622061339.3306046-1-aaron.ma@canonical.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260622061339.3306046-1-aaron.ma@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0179.namprd05.prod.outlook.com
 (2603:10b6:a03:339::34) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab0012f-4d10-4b01-12f4-08ded0789f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|5023799004|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Co+hxS0cof1Fc7nK+8G577x13Emjt4H7vyyPudXCl/T1ikBZ0u0qa9Dl2DTsarW5plw7QPAReJg3ZAhN32YivK2Y2Bs3UzFC61OWL863VOHbgg5SWhZ8MSnedg8pYHWuCDs6i2hpu/2bZx9wSYQU9sWD2rx6UkflulHfp9aoW1rfLqaFppch4FTobDrfkcVCZHEQC+5AgYTmVlSPWmNZLx/DFvu/2EhS4vSa4amWmBi/pV5yROc9WFsWZzeK5nUDMH79XFTPrYt6JsowJgCCyxHzrl86KQ2VqgDQ8qy1BDxtBS2mQRzpZ28qRS+ZMqMPQdfSbfqv5HJ5y7/G4jOve/C4zeIt3yLnBFP8qj4MXqldo7xSCqSb5QOhD2OepoovLwbpHPr+y56aosoREg3QsBRGv2rhYj8JekirnYL+xtqo4w+0EqkIGqUOc+WzWR0+ahUA1ZGY8hxk512v4SuaEsZojfnBcXvWaf5ZWWIIRsXGidI5volFgLcu92MjARM6wIZ3Xjd3ttMQsHhmlFzxucveWAfcAenVR6rq+lP6S36pAq1jdT1aJDMxaS5eW2cbD/V2eRMbDtV9Qd+QseGxcxbhunUEknPXODCOWJq4n1jG+SRNyIDfAi7Re7pcib9c5zJ0H6RafzePJ7eOZzuwsAEUDQLUaGKCPnVGkQwsvic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YStyak1ZcElqZ0NpNURtOGNBSkhOOGRvYU1Ua1RJTndPRDk5clNrZFQ4OE05?=
 =?utf-8?B?TktvcEVVaktIMlZpT2hFQThsTnhvYmpzekM4MFgzN0t0ZUMyL2x1VFNoRU84?=
 =?utf-8?B?WldJVkFGTUcvVElTenZrRXhNVWRsVml1QVNpZXJUdWN1MS9qOXhkLy9SMTh2?=
 =?utf-8?B?SGF1eGxsQzJjZVhwVUNwZFBiMW1rMGc5K0hwaUVVSDVoUzFkUTdPL0pFYkk4?=
 =?utf-8?B?dmtWSld1MHp0R0JxSUh6NFpkVHRuTlo5NHdtOTRwUmwxTGtqOCtZcERzVTg1?=
 =?utf-8?B?aDlPVXBzK0JGTmtPL0E0cmdLdGJMQUdSZHl2WmJ2TE04K0JpdXR3d2xockND?=
 =?utf-8?B?T2o2L0tUc2RTS3pJeGU2ZXNJQUdERXdNM2JTT2lyUDgyWXBtdGIwZm53ZERN?=
 =?utf-8?B?dnpVZERKTCt1UUNSdnhWVDF2SjV4WVlDaXZVWFpjcXltVnUzRktkcWhHanpZ?=
 =?utf-8?B?YmxrUXNkUmJzSi9Mei9abUE1Y1VJc1ZVYlAvaVVXQldvc1ZDNERDa2cxVHFn?=
 =?utf-8?B?VDRXdTRBUkdvTE1UbldpajlGR2lmZS9LRFQ3cm1WQUhDakZQenRGVnFJZkJu?=
 =?utf-8?B?R3lEWFlRNkNGd1VaVUtOdS9nY2xrc0lxTzMxeWxWTExNaW4xZFEvN3NldGFs?=
 =?utf-8?B?Z0VJbm11amxGOEFOSWtMQVdxUEZqQStBNGZuV1FxenNpVTc2dHF2YkVscHRV?=
 =?utf-8?B?eXBDMFloNXNoOTVlYnFNNTFJYnc1clljSGxjNWZsbTNiWEpsMEVBcHhsR2Fx?=
 =?utf-8?B?c1JlSXdjc1BGeS9Ua243K1hUTjhMcXdsMmxKMzNTOHBIbmtPV1REeURUOG9J?=
 =?utf-8?B?dlgzYTdHcjdvQndITlVINDk1TC9MeE1OOUlIS3ZsdTY4aSsxMExaRnZXVzJ5?=
 =?utf-8?B?MCtDd2d6SmsxZjIreXE1TGxDblJDdXBUQzViVGQrZHJmNVlwenhSNFQ4Y3VC?=
 =?utf-8?B?c0lvZDR6OElsVkNvLzh2MEcvZGlmWGNKYVpKZU9SejVIZWNwMTFJdFhscHls?=
 =?utf-8?B?VC9CTlhrbGt1L3hWRitDMmU1emlqQ0syK3RqNittc1czUkEvTGRQWWFCdUhs?=
 =?utf-8?B?ZnRHekZkMDQrL1B0aGg2cFgxT05ISkxEVEJqcnJsTndLYk9adVVPeXZxSVB0?=
 =?utf-8?B?Ym1SbHNTVnRWODB0V2U5Q2JUcmxTNjM1N3AzZmdMNmtFNno4eDNlVkN0RHhl?=
 =?utf-8?B?WHRVNlZYQkxDYkFyK083MWNOMWpBUGJqYzJLTWsxUHkxSlhZdlZ2L3Fvc3lQ?=
 =?utf-8?B?dmVsV3RpZzRUUG4xUEIwdTJHOExud0J2WEh2bjlmdlAyME53MTFYWlExYnp6?=
 =?utf-8?B?NXVoWFlWbG1JKzJvMStRdnE5eHpycVlDRVd0ZFVWWlJZUDNMV3lFNllHV3B0?=
 =?utf-8?B?bWZzeDU1OFBVU2U3ZWRHRXZiRXYyREZFZnNFb0RUZXBaSmhZTTR3TDZKRWFS?=
 =?utf-8?B?VGxRUWMvc21OanVzWlNxSEdxc3pmR0hBd0N6NVFOR0EzMytSaW5LVFVDOVNM?=
 =?utf-8?B?YVUzRTlVZ0tiblNwVnZ0YjVEVlVMbnlCYVB2MytwUzRTZU10Z011UU9Za01k?=
 =?utf-8?B?cWgvSCtrR1pLeDE1cEcvZVROZzVnQTdqUS9KaGk0U3YzL0UrWDJpZmpFOE55?=
 =?utf-8?B?MUdpSmxyVU5Cbkt3TlkyYXkxTnJrWWExMzB6VXp2clVHVnFXeDVsc2lVVmh0?=
 =?utf-8?B?RkcySU1JdGNydklROEZINm9hQ2hUU004QVpNQVNpSElXNnBBUE9XSXNjY2tW?=
 =?utf-8?B?clpKLzVIRnBrL3c2RUs1bnRBN1UzeERlanAwa2IzZXhiWVVvUkc2RFN6di81?=
 =?utf-8?B?UmJmMUQ1VFNQalRnZzRWakY2dGNwUHdXRzJlTUdSbG10WXRWdUM0enpoLytl?=
 =?utf-8?B?d2VCUzBBQjBORXNWNnNFaGF0N1grZVczRnpXdkJHNEsvTmlMNDJCQTEzcDdx?=
 =?utf-8?B?cHFncnFjbW01WkxnRisxcXBoNC9WbGxVbW8rdXRsaGFWS3laMVJDakljNnpo?=
 =?utf-8?B?VENRc3ZDb0tZZ01TL3hUMi9ic2EvTk9HRUg0WUc1YlVvQ3pLV2lkSUNMOEQ5?=
 =?utf-8?B?YTVKVFFmZnYrQ21GaXhPS3E1MUtZdHIzU2FJMndCbWh4Y0syY3lBVkR2RG53?=
 =?utf-8?B?L3F5c1Mxa0NBRXJvZTlTaEU2QlhGS3VWRUptaUtGNmNpYWNnWHRxa0t1dEdi?=
 =?utf-8?B?NExzdWRNcTRSa2RhbzhGQWJlVnF5OTNYMmZ1aG4wL3lvT2taRUwrUnNmRkRE?=
 =?utf-8?B?aUhNbGN4eHZoNHNtMVB0Y2s4MHlWQXVkMDhhV2RzRUd5K1J1ZXl6Z1BsOVJz?=
 =?utf-8?Q?rsxtx8902F60SVVoSS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab0012f-4d10-4b01-12f4-08ded0789f91
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 16:09:22.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhnK/ArqkyI2q41Uqi/NJNXJxHnYsacdF9EfhGClNwNJpnHE937pijaCLvvsdN8IKp9a0j7cMLfUyLSiOHvvow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128

+Thomas Zimmermann

Here is the lore link for you for full context.

Aaron's v1: 
https://lore.kernel.org/linux-pci/20260618081803.2790848-1-aaron.ma@canonical.com/
My proposal: 
https://lore.kernel.org/linux-pci/20260621175230.1453114-1-mario.limonciello@amd.com/
Aaron's v2: 
https://lore.kernel.org/linux-pci/20260622061339.3306046-1-aaron.ma@canonical.com/

On 6/21/26 23:13, Aaron Ma wrote:
> Some firmware boot displays use PCI class 0x0380
> (PCI_CLASS_DISPLAY_OTHER). vgaarb only registers pci_is_vga()
> devices, so those devices are skipped by vga_is_firmware_default()
> and cannot become vga_default_device().
> 
> On hybrid systems this can leave a discrete VGA GPU as
> vga_default_device() even when the firmware framebuffer is on the
> 0x0380 device. That makes boot_vga point at the wrong GPU and can
> make boot_display report multiple devices through different paths.
> 
> Register legacy VGA and 0x0380 display devices for default selection
> and boot_vga visibility. Keep legacy VGA decode ownership limited to
> pci_is_vga() devices so 0x0380 devices are not treated as legacy VGA
> decoders.
> 
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> Changes in v2:
> - Keep legacy VGA decodes and owns limited to pci_is_vga() devices.
> - Keep 0x0380 devices eligible for firmware/default selection and
>    boot_vga visibility without treating them as legacy VGA decoders.
> - Update the commit message to describe the boot_vga compatibility goal.

I really think dropping the fallback path (we found nothing, so this VGA 
thing must be it) is the right direction.

I'd like Thomas' comments about that though.

If we must keep that path, how about instead modify how 
vga_is_firmware_default() works.  We could instead have 
vga_has_firmware_default() and vga_is_firmware_default() both.

If the system vga_has_firmware_default() then no longer activate the 
fallback path.

> 
>   drivers/pci/pci-sysfs.c |  3 ++-
>   drivers/pci/vgaarb.c    | 27 +++++++++++++++------------
>   include/linux/pci.h     | 14 ++++++++++++++
>   3 files changed, 31 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index d37860841260c..843d83ec9550a 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1717,7 +1717,8 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   
> -	if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
> +	if (a == &dev_attr_boot_vga.attr &&
> +	    pci_is_vga_or_other_display(pdev))
>   		return a->mode;
>   

I really don't think we want boot_vga exported on a non-VGA device.
Even if the rest of the PR hangs around, this hunk I think should go.

>   	if (a == &dev_attr_serial_number.attr && pci_get_dsn(pdev))
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index c360eee11dd9e..56a86779e6d28 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -741,6 +741,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>   	unsigned long flags;
>   	struct pci_bus *bus;
>   	struct pci_dev *bridge;
> +	bool legacy_vga = pci_is_vga(pdev);
>   	u16 cmd;
>   
>   	/* Allocate structure */
> @@ -762,21 +763,23 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>   	}
>   	vgadev->pdev = pdev;
>   
> -	/* By default, assume we decode everything */
> -	vgadev->decodes = VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
> -			  VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
> +	/* By default, assume VGA devices decode everything */
> +	vgadev->decodes = VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
> +	if (legacy_vga)
> +		vgadev->decodes |= VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM;
>   
> -	/* By default, mark it as decoding */
> -	vga_decode_count++;
> +	/* By default, mark legacy VGA devices as decoding */
> +	if (vgadev->decodes & VGA_RSRC_LEGACY_MASK)
> +		vga_decode_count++;
>   
>   	/*
>   	 * Mark that we "own" resources based on our enables, we will
>   	 * clear that below if the bridge isn't forwarding.
>   	 */
>   	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> -	if (cmd & PCI_COMMAND_IO)
> +	if (legacy_vga && (cmd & PCI_COMMAND_IO))
>   		vgadev->owns |= VGA_RSRC_LEGACY_IO;
> -	if (cmd & PCI_COMMAND_MEMORY)
> +	if (legacy_vga && (cmd & PCI_COMMAND_MEMORY))
>   		vgadev->owns |= VGA_RSRC_LEGACY_MEM;
>   
>   	/* Check if VGA cycles can get down to us */
> @@ -796,7 +799,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>   	}
>   
>   	if (vga_is_boot_device(vgadev)) {
> -		vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
> +		vgaarb_info(&pdev->dev, "setting as boot display device%s\n",
>   			    vga_default_device() ?
>   			    " (overriding previous)" : "");
>   		vga_set_default_device(pdev);
> @@ -1483,8 +1486,8 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
>   
>   	vgaarb_dbg(dev, "%s\n", __func__);
>   
> -	/* Only deal with VGA class devices */
> -	if (!pci_is_vga(pdev))
> +	/* Only deal with legacy VGA and other display controller devices */
> +	if (!pci_is_vga_or_other_display(pdev))
>   		return 0;
>   
>   	/*
> @@ -1530,12 +1533,12 @@ static int __init vga_arb_device_init(void)
>   
>   	bus_register_notifier(&pci_bus_type, &pci_notifier);
>   
> -	/* Add all VGA class PCI devices by default */
> +	/* Add legacy VGA and other display controller PCI devices by default */
>   	pdev = NULL;
>   	while ((pdev =
>   		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>   			       PCI_ANY_ID, pdev)) != NULL) {
> -		if (pci_is_vga(pdev))
> +		if (pci_is_vga_or_other_display(pdev))
>   			vga_arbiter_add_pci_device(pdev);
>   	}
>   
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2c4454583c115..195ec1bdac863 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -792,6 +792,20 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>   	return false;
>   }
>   
> +/**
> + * pci_is_vga_or_other_display - check if the PCI device is VGA or 0x0380
> + * @pdev: PCI device
> + *
> + * Return true for legacy VGA-compatible devices and for "other display
> + * controller" devices.  Some firmware-selected boot display devices expose
> + * class 0x0380 instead of PCI_CLASS_DISPLAY_VGA.
> + */
> +static inline bool pci_is_vga_or_other_display(struct pci_dev *pdev)
> +{
> +	return pci_is_vga(pdev) ||
> +		(pdev->class >> 8) == PCI_CLASS_DISPLAY_OTHER;
> +}
> +
>   /**
>    * pci_is_display - check if the PCI device is a display controller
>    * @pdev: PCI device

