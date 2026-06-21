Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454023EA83;
	Sun, 21 Jun 2026 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782062107; cv=fail; b=NFkzbZIqJ+spvdO9UKll5AXBwVGdvg5dezNfdeGpB4qSzilKuJjbDwKY+4wX9/p5iSzQNgc77tYq73aveXJsnkrw1zOztC3kzrfdcxuoyoAdJB+OCOa+bmEhEMoxKaSM89sXvyMaCxhSLiK6WkRx/Y6Jg5eGPIYYXs+UnmSsZ/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782062107; c=relaxed/simple;
	bh=MnAbC6Jt/Q1AMa7h7jIbYlsNyd3qB2V4RjzHcMSbjMc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rtV/kXBYmWR5wdtH9tyh/Twd9DzKZybSyhbrzETAZoGjRZnI6/JCeX8KYPiG7HAk1qI8ZN4xw6J+KsvBMNh6xYWqhxPdmXQcrBPAWEoQzO+ilOjNe9kAsXtKvy/XUpldiTDs63205TijL3qbfyl/o8AlfM8gy8IE9B+DnCUypmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j+De9EAE; arc=fail smtp.client-ip=52.101.85.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j+De9EAE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trYKvxb1RQ0VrmHUCj0NCTlrHHARSDgN3TJpWzbOCKEO4AXSaIYVG1r4T767duk3S5q/atl6dqsJr3JmPFz6v805h+rDnzibq4TWM1RLGS/aU0VuwQP4Mdzg52IQgJWkLTPY7Xb32g83m5YX+VSLb2NVJrm1U8gA8Omnxl6C83ySy8Is5sbftsyhgRMkwo4+G0DjGAgjTu0KaGGxCB52cxFOuTUaTk3lnMx7kPfYAlmBhd2e4la6ho45+ubUHnVfuFFQdJazghK4Y3EJBxApu0LkjvqOGoWfrVHWgaASNOVfIc96doE5dERbvSkIfqUUsyDxZeavAx+D4NCxbvxceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3B23MPId/boAd9XvUUsxDVDx4uZpHY+kwZSvBEC+7Q=;
 b=yXg0Wh2N4hEGYKysDiOVmPGuSeLOzAxu3ljAn0WtI3KjPRk3zZaK+YWfGZZV8r6xLhmn3l9AFx1zrGTGyKg1gBDWAlrLm7HfZghLCzgO2tk4ptMhOpb9UIFWsq2HM6pKtfPobj+LhsKjpm1z7F/fpU1Up4XynpxyPel4JvMaFDz9JHlz1+cVJ2Qb1j4wQ+HTa8tFTBDB5PyMP9oQttgif04pC8s7EQeKKsmkexf1TrCw86EHngf12GZfXXCuQ64qpxZQt+oSFmvsg3PHYIyYExB/dh7b5Ex7nPFdgfN1z1rJc8rrxfZ2w9/08TcUpFehrfj3nx+awyrgJci7Pgb5Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3B23MPId/boAd9XvUUsxDVDx4uZpHY+kwZSvBEC+7Q=;
 b=j+De9EAEzcDE8n5emcXnmf/7EJM8qFudnK48GWLaj2ycIYAj11mPv34cN86sU/Rx4iaIQs7/pr1o6CDwuqbJtNaTq64xQA3uAW7YtPYjxuLuMDwq4T/YkvbPi4lt4DxwtjgxVEMlQlYa7mpuXZr6pz6no0NQKpOzuUNnkM+TECM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Sun, 21 Jun
 2026 17:15:00 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 17:15:00 +0000
Message-ID: <c3c9df7b-20ae-41fe-8cae-ad7f9cabe823@amd.com>
Date: Sun, 21 Jun 2026 10:14:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: vgaarb: Include 0x0380 devices in default selection
To: Aaron Ma <aaron.ma@canonical.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260618081803.2790848-1-aaron.ma@canonical.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260618081803.2790848-1-aaron.ma@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::11) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0cd9b6-7dfa-4ad0-37e7-08decfb89ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	SLyUsaLV5QifZojdgjowjlEvH8soiFOi051c4rYmGMt9NMqTnLLJAVG4j6MYfG/11KURtjYLiK7unqTJgJczcpstcabDSdOFzWt9hPukvjjhBbMxod3mV4lEdVqL5Ran/Ok4MhY2YCNoHUkgZ+w93lnYBOcbegkX3uSspaniMnc5mbTQDp0HheXS8p9SmBW1kp1jHE/C1FyRS4DunNIJVpgeoPbkMrYrG0nhcahZFgClmg4W7SdwFZKa3FMyiV4kWuPc/YYYzHe/Wm4Ub+xYguih6iNznbZur2cL9u8P3xdoS+E5yvVgWShLu3+geJ0p9LqT2oXk+3J08CS4D1iLpzLJ+1Paw1Ol3fi3xxZhFQcwN/Ixu/jrcqabU0m4uOK0KI4msNdrtbRCC592IkPRanTBi29sOy+XDhzry4/n9k+dnkKyE6+FZbmN+1y6xbjtUKTAm90wTRBDyajUD5eu9hhEIuzp1s4K4Y8hYYMnCXdQNqHOjocsPSdslepaH1GvN+nn5bMePYt3zWBqXFQn56roe70853pEHetjyNngqVQcdEGKzykAtyHeunzZlD89OiKg3wg7Z2pPDgMVAzD7sl6uwZIMwoiC6xwVSA3rMJ3M5BDZsR8xNIFfVLbcjQonEwTGrjGWNZNTxOvoYRh4Svc0lBmlOM8wE8UJklG9Xbc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WS9QOWEyMXFSL2ZPaXdCK2pkeEtGTGRLQmNJN25kdXJqK1pnOWZzQmhqZEJR?=
 =?utf-8?B?Zm0rN1drc0szeXB5TElBTEJhVk90WDBWQlNuQTJYaUFjUjJVbXBRaVVady9w?=
 =?utf-8?B?SG82dEhUQ1hEeG9OUUpOUTU0c0UvK1JQazg2cC9PWjRldzUvc1lnODQ4M1Vl?=
 =?utf-8?B?ZHljS0hQVlNyZ2FRdlBlMHNJeVZEaml6bHlrejViMER1cnNnS3p2NVFZNnVW?=
 =?utf-8?B?SDJhRFhac1FLMEpYeU5YTHlFTFZSTXR1d0ZlaUhQSEVNNGpJUUswdDJXbnNJ?=
 =?utf-8?B?dm0wcmNYZGxvVzV3bjFIcVl6WE5Ub2w0U01QWGd4VHg5QjJINTRISFRUMlBr?=
 =?utf-8?B?OExXZVViMzMzMEY2VEU2ZHFrckNicWxIU1Roczk3ZW03VGYvOGRQR2JHcWNT?=
 =?utf-8?B?T0UrUTA1TVQ5bDlFRk9XcXpURmdvZTMzaVNRckdWWG5HRmNOSG90Mk9sRDBK?=
 =?utf-8?B?alFnR3ZLUjByQUpObWxHbUJmS2M1ZGMvVmhOSllhMHYyelhtOGZRemtNQUdL?=
 =?utf-8?B?ZGVSNkhGSElEbUFEVjdVYXcyTkFDN2QvR0p3RHpxYU5kR3k2eDNPMUxmaUdz?=
 =?utf-8?B?eVZiMEFPWWUwZ2RDRGlzU1JPOE00WUE5NkhZZDgxNldFSFpGV2drOUtPQkVT?=
 =?utf-8?B?b1dRaVduMldObU8zOWloRnp4bnF4Q2Q5V3R3SVVHeFlVYS83WENHRjlrdUk4?=
 =?utf-8?B?RjRXTkVZK3dLUmRtVVpHS1d0dlNhMEMwRXZzcmFwNXEza3hNUU41RnFjdlBO?=
 =?utf-8?B?ekl3ZlR2YWdjbHg5R3F3a3BBWHkxRHBOc0ZQbExrcUJIQS9DSkNTUXZUM2c5?=
 =?utf-8?B?VnRvb2xSMmRhc1FRRUJISVJVTFYzVzVJd041R29oa2lyU3hIM2VsZkQ1Ry83?=
 =?utf-8?B?WXJwZXhWdlpwTm9pVXEvS2hJUFZKWHJYeHAvblhScXFJODNNa29UY0FuQ2g3?=
 =?utf-8?B?aUZjM2RuS0hGcFpIdnNZTXQxcUxqMTlEOGhPM24za285b1h6bnpZM0ZKWlF0?=
 =?utf-8?B?QlFOejRwU3FIK0E3QjBzU1JBdjE4cDVISXp6QUx2VTNPb0RjTUxqL1c1dC9I?=
 =?utf-8?B?WkpIaXpIK2dJN1BUdDJJUEVyRGtsSXEwcDZZVHcyNE5ra2gvR3p3V0NGNmFl?=
 =?utf-8?B?RXRwOVVESmUra01jSGtVRzd2RHR3TE42Z0lBdlkvdW9GUlJRVnRTaGNpY0hp?=
 =?utf-8?B?S0VicHZlNzBrY2U1VUR1b0FwTERsejA5bVVoYjY4czljWXNLTlNaelpsRGM4?=
 =?utf-8?B?WjVtQzdPRk4zTmtURE1xMDM0c0pIaVRsSDZ3dVhOcmhlRm1MZTBsN1NEYkx4?=
 =?utf-8?B?eWZ4bldRaGpPbGQrYUZWcFo0TlZoSWQxYmRUS2ludU9YKzI5eCs2TDVPM2hr?=
 =?utf-8?B?NnhPd1dzVGVqMWxKUHFXTnZDZFFzdFpxcmFWa3luc20ydWppK1kyRFJWS2Nu?=
 =?utf-8?B?OUpHUGRXdkt4MHJpNGsrQW1CSjZad212UzRyVk5tWVFSR0wzS25FcllZN3oy?=
 =?utf-8?B?YWRYN0NBWEZnME9HUXpKYlp0WVM2ZklBaGlVZU1ud2k1bE1iUGxFd1J0Nkhq?=
 =?utf-8?B?b3dVQ3ZwRzJrKzZPYzZlNFJGakd2R280MUZYN0dZeXRrWUZCYkkvbGFnKyt5?=
 =?utf-8?B?b3ZTRGxOQ1Fud1hZRnFFbmM3N2dpd1JOMkVkWkFXaTRGVXB3Sk9WN01OZzBM?=
 =?utf-8?B?SnBDVDlYbi84L0h2Qkd3UGxsb1VRdlF5QWN0OGFSbmMySFN5Wmo0NXNDella?=
 =?utf-8?B?K2ZjZlU4Wk9Oa21hRjllUVczeDUycGl4ZlBzQnRObitBMis0YXBYK1gzMnht?=
 =?utf-8?B?cklLaEVuY0o3K01LaHJzOGw1cklvUUw2MnZXbm1XUUpuZDNjeTh1S0UxZURa?=
 =?utf-8?B?R3hvNnJUeGN4RzNrQm9OeVk5QzU3OXJMVkZjdmVLdHNoMWN0Q2dOaVZuZlpX?=
 =?utf-8?B?MXlOdUpZZXNrTHVvVUFtVml5VUV1ZWRhdXBmb1NrMVgwS3EzdlZFQmxqZGRh?=
 =?utf-8?B?S2lPQWFRYTJOaWdURlkxVDNOZmMwMVYrU3hHYllrSzVPYUJtUENDUDJXb1RX?=
 =?utf-8?B?MXM2OXFpWjlzdURvcE5idEZZV3U0dXBQS2VyOTBEeXlDczkzUEc5eVBSTVJr?=
 =?utf-8?B?NThNb3ExbEpkR1FCak9zMDVUZ09yM3NYT0pYMjAxRjJrYVV4Sm5say9wQ1pk?=
 =?utf-8?B?aUdQSU14aUtwU1AxTVdZekRHYk9IMld3aFRTdjNIWW44cXFmeGR5RkJHL3JW?=
 =?utf-8?B?WW03eFRXQ1c5NHBxOW9SRWZUbFFJdzlUUnZpemlGRFpaTVZ0bUliN3ZLcEE5?=
 =?utf-8?Q?a0F4HbYRHDKNUZrktx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0cd9b6-7dfa-4ad0-37e7-08decfb89ff4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 17:14:59.9268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0MgHdihOMugJikZSR1Wg0xcRiaSUDa++ziVO+8TZZCRONKuBUmUva6ftuKQbN6YNFblK5hfTz0zrtE2drjVEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159



On 6/18/26 01:18, Aaron Ma wrote:
> Some firmware boot GPUs report class 0x0380 (PCI_CLASS_DISPLAY_OTHER)
> instead of PCI_CLASS_DISPLAY_VGA. vgaarb only registers pci_is_vga()
> devices, so those GPUs are not considered by vga_is_firmware_default().
> 
> On these systems the AMD GPU matches the EFI framebuffer but is
> excluded from vgaarb because it is class 0x0380, while the NVIDIA GPU
> does not match the EFI framebuffer but becomes vga_default_device()
> through the vgaarb's enabled-device fallback.
> 
> Register legacy VGA and 0x0380 devices in vgaarb, and expose boot_vga
> for the same set of devices, so the firmware default device can be
> selected correctly.
> 
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>   drivers/pci/pci-sysfs.c |  3 ++-
>   drivers/pci/vgaarb.c    | 10 +++++-----
>   include/linux/pci.h     | 14 ++++++++++++++
>   3 files changed, 21 insertions(+), 6 deletions(-)
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
 >   >   	if (a == &dev_attr_serial_number.attr && pci_get_dsn(pdev))
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index c360eee11dd9e..0e0878189e3d8 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -796,7 +796,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>   	}
>   
>   	if (vga_is_boot_device(vgadev)) {
> -		vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
> +		vgaarb_info(&pdev->dev, "setting as boot display device%s\n",
>   			    vga_default_device() ?
>   			    " (overriding previous)" : "");
>   		vga_set_default_device(pdev);
> @@ -1483,8 +1483,8 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
>   
>   	vgaarb_dbg(dev, "%s\n", __func__);
>   
> -	/* Only deal with VGA class devices */
> -	if (!pci_is_vga(pdev))
> +	/* Only deal with legacy VGA and other display controller devices */
> +	if (!pci_is_vga_or_other_display(pdev)) >   		return 0;
>   
>   	/*
> @@ -1530,12 +1530,12 @@ static int __init vga_arb_device_init(void)
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


This patch doesn't seem correct to me.  It's overloading the purpose of 
boot_vga to cover non VGA devices.  We should be using boot_display.

Trying to hypothesize what's going on here - I guess you're seeing 
boot_display set for more than one device due to enumeration order.

Can you see if this helps instead?

╰─❯ git diff
diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
index 152789f00fcda..9440eb3a7b15d 100644
--- a/arch/x86/video/video-common.c
+++ b/arch/x86/video/video-common.c
@@ -43,9 +43,6 @@ bool video_is_primary_device(struct device *dev)
         if (!pci_is_display(pdev))
                 return false;

-       if (pdev == vga_default_device())
-               return true;
-
  #ifdef CONFIG_SCREEN_INFO
         numres = screen_info_resources(si, res, ARRAY_SIZE(res));
         for (i = 0; i < numres; ++i) {
