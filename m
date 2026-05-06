Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012050.outbound.protection.outlook.com [40.107.200.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F7A33A9CF;
	Wed,  6 May 2026 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100801; cv=fail; b=FypS2qyGDGLc9lFtZuN2Je2nYMTpeWCkWirnfln0tNUfl0Md83MlQYwcdLn3t6bkbZ6xYWBb/uxnZK0WOyiAGiVkAjTpkSdHgd3Ji7oX+4PIogqZD2dPBZFD8ezcA6phK6jVj5uNs5+R8Am5N2Hs5stBAJtauAp3v+zpgY3a3Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100801; c=relaxed/simple;
	bh=Xril5mDpCnOe80KcRCG6lo9LGV8WUiKtho4ZXI1WsaQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jmYUIxrixG70x7WnyjwQgtrY2Ou9idyQkf56/Hbiw6dvpCNKrcjgVYVmEU/Yio67d+FDOWb6XRhjEPCE9YPcjSl2WB5iCVAhIkeaGxABSZsSAr/5elFMg3S+PUEPbFzRG6ALe9PfYEeBjBVuE7kPX3BqBsRKEPCGKO3AyR//0Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DHmT8flk; arc=fail smtp.client-ip=40.107.200.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DHmT8flk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8d23d9TWHRdA9H6ov3GvYlpQloIsnlOxaLGFSCOhdt80lQwKAYAXAwcbiIwWK++4w3lswD7CvcVm4iZdkT8W6qIa98/XbB1Lvoku1wUVN7JS/ELJoATKG01ah4YJGZdZBClaLUiUwW4sMgyjOSfnYqAt9zLtFrSTQfIbWf9dHZc0rI2L8fQNess7K7NjBQNr47iiG9IYPV2S5eqgIairfyEWPUJ9R9QuW5rbkJhbf3gR1HWmMJPQYxfmX88hBgdcDnWUCpCU47q5CnHyHxFLVZTLQfgbYe0PxOYVHzPzpdDylBOZprvO6wiSl9T/O6aQKrKvXVWIYBED+ZP7cnA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxotyDfdVYd54Ch4Ez0sz/iofYcg557WNCwfBySVKJ0=;
 b=lgtEHMfOtIgtsmcDx39oV+fKRkz8lss+T4IAOSRpsO1Ba1f5uSjn2WrP70xNRVVySJEJ0qVgUkwPoGYrW4/7puAThv9dd2H3bdIEF/0mEYi+LWdUlJeM7b7QCBJ3Xrp5B7k0CSrkDl9rFL87prjR3m8M1MfkFplgjQnMAmmppYy+QZmy0uf0zxtcw1djihO74Jf6E9q6vSlcKgza57YesJ2ZRGey7dZNaC3E5Iai/VAF9n5hyJ4W44Ws+aE7oRestTNjC1VLdIb91glMOxtvRcX+c+6aC2Cf6FaKsvrxGYZ48XK2dIKBt7EtZJwPg8kpeQCzkJ2byIykb9saFWcxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxotyDfdVYd54Ch4Ez0sz/iofYcg557WNCwfBySVKJ0=;
 b=DHmT8flkafMcowpmf4/dsqMD8BfSFJmm7WqAViOgw8U7dK2N8D6Inb2x+YqoZihZI4vDrjGOscHkQhoWJY3qDa8/LzH+pVEIYJ6k5uWOoT0PyqMcPXffTiDNTb/1Ev0jIwMGuSm/DIO+WsAhU0tJ/mcmsX4/aUinb1RJRijNfK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:53:15 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:53:15 +0000
Message-ID: <bb047320-594d-46de-9522-1098e784ebc1@amd.com>
Date: Wed, 6 May 2026 15:53:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] usb: xhci-pci: add generic auxiliary device
 interface
Content-Language: en-US
To: Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506032939.92351-1-hurryman2212@gmail.com>
 <cover.1778099627.git.hurryman2212@gmail.com>
 <3f26994ebb5f0e4e653a8108a9626bc793148679.1778099627.git.hurryman2212@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3f26994ebb5f0e4e653a8108a9626bc793148679.1778099627.git.hurryman2212@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::20) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: e689a10f-c00f-486b-8da0-08deabb17e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	CZCAmMJhKMJtFR/eERTnA0R6AXrPfhuKjEqPAHtTDWFgXotT18dyX0Lp0c8Z9GeKnkB4xWkM/zMuMdXq5SgvlgOt8rJhnl3ISIB76TuyUTkPuXfmCT7zlIuiM1f8rpSFgcJgYP71cqANTpWqK6zmHGBdcNIX5S+d3HTNzMjreZOZWmVOvSfmwA/j0AGi8+mWrNsD+iS/orv9YErSu8XPIj/mdo9i1feq9d4Fm4svpZ63wAK7EEB7LTgZF5novxw9nxzbWk6VWDPv5Zd/wOjksg/7+VmnwWRhQxPC8Q5wlR4seQ0N6Zyxgl2vNZuPbdj7duvtqgpDVZl2r46IwBJd5qXN/bMU7LetMkN1m5dYplN0VX1TTt8OlPVz/Kpd1Z/9iKdvIlsSsu5yRv+KX+zDdLw8EGxuwMnHPuLLqPxZgwRSm34oqdXDOVVuB3QGNwEJswJ94ijtu6oK/9E/EcRfy9A837BlUNftwUfOVePITdG/E7AyhR/Yik1gebvDfdhq7hzzrPaWSqc2BHRsH5Y9xT0wPWXCZ6U26aAvAKe7qy6Occicn7ekdq5eH/VXJkD8Cu2cwr8Ar15PUQGDGIaNAREqpxL3gwwnNXuB07WOq3f6YE90tRQX2AlpYVQstuMivGSIzxcbgB/F8EKnFRLJ27wYx2knRQ5HOeyPHg2Ae3oJBul4Jj2Oow1ZNdLkXZYM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(18002099003)(22082099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2xEMDNHSGg5Y1BvbEY5eVVKa29mdFphbXhOQ2FGN2pyMGtUWXRlTHBCTlVO?=
 =?utf-8?B?dzlxTW9lenVSRWZScVd4VXRORS9GdUJTQ2NnTUlJZUYxNnVFNUZTanpPMnlz?=
 =?utf-8?B?WUg5WmRuaWwweEdSZXVUWEllTWM0c0E4SkQ0MTJWNXF4UXVkamJvUTluMVYv?=
 =?utf-8?B?d0duWGIzT0NNbjFjT2dQMjF6ZzRtREFHYjQrTWFJT1FYSHRRTndCaVQvTHhw?=
 =?utf-8?B?QlZIWFFMVll5WXJBcUppZVc0c0c1R1hFZktkSmlEczV5YVRsbUpVSXdPWHp5?=
 =?utf-8?B?UURxRG9TNi91Q0l0SG5nd05tdkJEcTBDL0JqbXhiMEVCTU1Wd2pFR0RITlBW?=
 =?utf-8?B?TzkrWlJ0dG5MTEtnM1RNcEJ4TWxtbzBxMUo0M0Q0d0ZhTmQzNTJTTWZ2VlJU?=
 =?utf-8?B?VnJ0VFhKTDNEcEdXV3JFSkdMUGFlZ2RKL1R0T0tBYjBVbVAyR0N0cm5BeW1O?=
 =?utf-8?B?YVVZS0UrTXBmaE1pUXVRQXFOWWg5YlVoUng2ZmFKaTV2Ukp0ZmpmWTdPUjBy?=
 =?utf-8?B?Rm83ZUFFKzgxaFdGNkJOaElEbmVqNDJBSjFrMVFnMnRCTFpuaGpEWWdacXlS?=
 =?utf-8?B?aTF3MnFWWGY0Zmg4TnlXaG10VGNXdUczZEFrcGhlVFNFMmtVRG04S3lSSU4v?=
 =?utf-8?B?dkpRUUl0eWdvOGVsekJwbUJlRzhxZEFxNmR0TEtlMlBxL0g0Wk1wdHFDcjZv?=
 =?utf-8?B?OHVhY2ZnVUwrdkxaYXpiOEErd2VBMzhyVEJINDIzTEt2ZmFoNkVJY09BVS9L?=
 =?utf-8?B?K1NJKysvNlNSN3BoNXFDcjVGMkR2WUM1cXl0QmNsTHFGMDlnZXEzZnlJRGFF?=
 =?utf-8?B?K29PS3ljMHdtV2wycFh6ZllRL3Q2cXY3eDVkZ1p3Mzdsc0FqdkJ2aWVsS3Vs?=
 =?utf-8?B?c2hCSmYvZWZhVG5tRzNXVmhGemRtOHhoZ3hUS0hid0g0SklubmJtWHdmTlRX?=
 =?utf-8?B?bW80T0xyQUMxWVFXUG9xNS9qeU5TSWxlWDE0Wm9pc3Q0bDJwQWhzdzJ0Zngr?=
 =?utf-8?B?U1JYeWxzRENGblJxZ29LenUxUHRTd2R3UFpLUG1BK1lqV3diZkFtd05hd0ox?=
 =?utf-8?B?YUdGODE3dk9QVGhmcXdjcTBKU0xXRFYrNys5amw5VUFteTRnbCttNU1vbk93?=
 =?utf-8?B?Znpza082dU9WeHpic0tFdjFvbkhiNWxYVXg5bnFXRFFPUFM4U3BZcWtnUUlE?=
 =?utf-8?B?SzJaWGVUNGlYSzUrcTZVSmQ1ODdRdW9Qdy9xaEh2dXdjZTZBUFRINmVmVU5V?=
 =?utf-8?B?eG9CRGVVRWUxTElGS2gxRHBuMjk0QWQ5MWdyN1A2bTd3clBHMHFDM2V3Tnhw?=
 =?utf-8?B?SDM3Q0VuMEk1UU02S1ZmWnNIVFlvV2IzMmowbHo2bjJXSTBQVGVTM21JT0N3?=
 =?utf-8?B?Qll2RWRPb2tvT05LRzZyZCs3VFJCRlRCQUd0Wi9EQU1pem1uVHFDZGZTd1hz?=
 =?utf-8?B?Rm8rQVlsV0RXb1Q4RzJiMnprb3pVbFRBNW5kcFY0cGxYamM2SUt0UFRWRURN?=
 =?utf-8?B?S3VNVGZ0WS9LYUcxL3R5Q0ttMnVZRE12ZGhHM0poOStrNUo0MmdiYnJNQ3lp?=
 =?utf-8?B?djBsb0p6VW9WV2VObFRldGRoS1R3SktLU0xHK0RUVjVMZU4yL1hhUmZ3QnN1?=
 =?utf-8?B?NkpMU0M4ZTZ6dEZ3Z0cvM1dGcnd4S3ROK09KRDlvRFEyZkVPSnVuUDIvTlhq?=
 =?utf-8?B?c2ErLzJvbWpnVm1NTDZPZlpFK2d4MXB1S0tJVU9PS0RRUmxQeU5xUUx5Smoz?=
 =?utf-8?B?b3pYa0NZdXVuVnhxQytBaVJKRnh2MkxJcXlnTGFjVzQvbFNYVFRQL2hoTlVi?=
 =?utf-8?B?MUx0dVlHdXhobU9qRU13SWpCdVlPNWdsLzB6eGFZVkVyY1ErT3BaV0RMT2Qw?=
 =?utf-8?B?eTMzZlpkc2t0ZDhpWkF5ZEN5WHp6ZkR4MjV0K2FmRXkrVHpKMm8rWUtUSDFz?=
 =?utf-8?B?OXVWTW9iOWFiaWlpK0lXeFJyS01kRzJGd0Z6dFdwaHpnQ3FVeDlXOTNaZGVV?=
 =?utf-8?B?TmJQL1JpczlFMnZ6SFFlU3RDVXdKa3ViUG1ObG03azF4VUNnOHdJeGYybWJI?=
 =?utf-8?B?ZWFwQzVSV0hNaFFCaWlZa2JIcVBnUXVLRXlzU2lLWHE3NlZXempZUXNzanZv?=
 =?utf-8?B?am8wUzAvSDlRSFgvT1VHL1ZrL1kvNlJOMkFWNWFvSXJxMi9CeVZqYVJuK1FM?=
 =?utf-8?B?a0FNdC9iTW40NTRXZkl0Y2lJUjIyWnlLL3VjSEZjV2N3SVA2TVFXU2l6TjE5?=
 =?utf-8?B?NW1GcTBiMnpyTUo5R0xINzAxVEt6MTRGQXppaUFYVEVlOGRteG9IV0NDejhU?=
 =?utf-8?B?T3FLd0JicTRqcXpDNTA4c2VxWld2Wi9Wc3pZUkRkNi95bTJsYjQ2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e689a10f-c00f-486b-8da0-08deabb17e4e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:53:15.2858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGZbwIM5w34Pqa5f7OX41LZN2ETzjRlQe1VQl0C0kaxvqYHCibdCUpOds0nSupCg55iqjcu7uZtxuNlFANg/Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991



On 5/6/26 15:40, Jihong Min wrote:
> [You don't often get email from hurryman2212@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Some xHCI PCI controllers expose controller-specific functionality that is
> not part of generic xHCI operation and is better handled by optional child
> drivers in other subsystems. Add a small auxiliary device registration path
> for selected xHCI PCI controllers.
> 
> The initial table creates an xhci_pci.hwmon auxiliary device for AMD
> 1022:43fd controllers. Store the created auxiliary device in devres so the
> xhci-pci remove path destroys it before HCD teardown. Use a
> PCI-domain-qualified id so auxiliary device names remain unique across PCI
> domains.
> 
> This keeps xhci-pci responsible only for publishing selected controller
> functions while allowing subsystem-specific drivers to bind through the
> auxiliary bus.
> 
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
> ---
>   drivers/usb/host/Kconfig    |  10 ++++
>   drivers/usb/host/xhci-pci.c | 114 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 124 insertions(+)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 0a277a07cf70..e0c2c7ac5c97 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -42,6 +42,16 @@ config USB_XHCI_PCI
>          depends on USB_PCI
>          default y
> 
> +config USB_XHCI_PCI_AUXDEV
> +       bool "xHCI PCI auxiliary device support"
> +       depends on USB_XHCI_PCI
> +       select AUXILIARY_BUS
> +       help
> +         This enables xHCI PCI support for registering auxiliary devices
> +         for selected controllers. It is used by optional child drivers
> +         that bind to xHCI PCI controller-specific functionality through
> +         the auxiliary bus.
> +
>   config USB_XHCI_PCI_RENESAS
>          tristate "Support for additional Renesas xHCI controller with firmware"
>          depends on USB_XHCI_PCI
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 585b2f3117b0..1ab27d2182eb 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -8,6 +8,8 @@
>    * Some code borrowed from the Linux EHCI driver.
>    */
> 
> +#include <linux/auxiliary_bus.h>
> +#include <linux/device/devres.h>
>   #include <linux/pci.h>
>   #include <linux/slab.h>
>   #include <linux/module.h>
> @@ -103,6 +105,114 @@ static int xhci_pci_run(struct usb_hcd *hcd);
>   static int xhci_pci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
>                                        struct usb_tt *tt, gfp_t mem_flags);
> 
> +#if IS_ENABLED(CONFIG_USB_XHCI_PCI_AUXDEV)
> +static const struct {
> +       struct pci_device_id id;
> +       const char *aux_dev_name;
> +} pci_ids_have_aux[] = {
> +       {
> +               .id = { PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x43fd) }, /* PROM21 xHCI */
> +               .aux_dev_name = "hwmon",
> +       },
> +       { /* end: all zeroes */ }
> +};
> +
> +struct xhci_pci_aux_devres {
> +       struct auxiliary_device *auxdev;
> +};
> +
> +static bool xhci_pci_aux_match_id(const struct pci_device_id *id,
> +                                 const struct pci_dev *pdev)
> +{
> +       if (id->vendor != PCI_ANY_ID && id->vendor != pdev->vendor)
> +               return false;
> +       if (id->device != PCI_ANY_ID && id->device != pdev->device)
> +               return false;
> +       if (id->subvendor != PCI_ANY_ID &&
> +           id->subvendor != pdev->subsystem_vendor)
> +               return false;
> +       if (id->subdevice != PCI_ANY_ID &&
> +           id->subdevice != pdev->subsystem_device)
> +               return false;
> +
> +       return !((id->class ^ pdev->class) & id->class_mask);

What's wrong with pci_match_id()?

> +}
> +
> +static const char *xhci_pci_aux_dev_name(struct pci_dev *pdev)
> +{
> +       int i;
> +
> +       for (i = 0; pci_ids_have_aux[i].aux_dev_name; i++) {
> +               if (xhci_pci_aux_match_id(&pci_ids_have_aux[i].id, pdev))
> +                       return pci_ids_have_aux[i].aux_dev_name;
> +       }
> +
> +       return NULL;
> +}
> +
> +static void xhci_pci_aux_devres_release(struct device *dev, void *res)
> +{
> +       struct xhci_pci_aux_devres *devres = res;
> +
> +       if (devres->auxdev)
> +               auxiliary_device_destroy(devres->auxdev);
> +}
> +
> +static void xhci_pci_try_add_aux_device(struct pci_dev *pdev)
> +{
> +       struct xhci_pci_aux_devres *devres;
> +       struct auxiliary_device *auxdev;
> +       const char *aux_dev_name;
> +
> +       aux_dev_name = xhci_pci_aux_dev_name(pdev);
> +       if (!aux_dev_name)
> +               return;
> +
> +       devres = devres_alloc(xhci_pci_aux_devres_release, sizeof(*devres),
> +                             GFP_KERNEL);
> +       if (!devres) {
> +               dev_warn(&pdev->dev,
> +                        "failed to allocate auxiliary device state\n");
> +               return;
> +       }
> +
> +       auxdev = auxiliary_device_create(&pdev->dev, KBUILD_MODNAME,
> +                                        aux_dev_name, NULL,
> +                                        (pci_domain_nr(pdev->bus) << 16) |
> +                                                pci_dev_id(pdev));
> +       if (!auxdev) {
> +               devres_free(devres);
> +               dev_warn(&pdev->dev, "failed to add %s auxiliary device\n",
> +                        aux_dev_name);
> +               return;
> +       }
> +
> +       devres->auxdev = auxdev;
> +       devres_add(&pdev->dev, devres);
> +}
> +
> +static void xhci_pci_try_remove_aux_device(struct pci_dev *pdev)
> +{
> +       struct xhci_pci_aux_devres *devres;
> +
> +       devres = devres_find(&pdev->dev, xhci_pci_aux_devres_release, NULL,
> +                            NULL);
> +       if (!devres || !devres->auxdev)
> +               return;
> +
> +       auxiliary_device_destroy(devres->auxdev);
> +       devres->auxdev = NULL;
> +}
> +#else
> +static inline void xhci_pci_try_add_aux_device(struct pci_dev *pdev)
> +{
> +}
> +
> +static inline void xhci_pci_try_remove_aux_device(struct pci_dev *pdev)
> +{
> +}
> +#endif
> +
>   static const struct xhci_driver_overrides xhci_pci_overrides __initconst = {
>          .reset = xhci_pci_setup,
>          .start = xhci_pci_run,
> @@ -677,6 +787,8 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
>          if (device_property_read_bool(&dev->dev, "ti,pwron-active-high"))
>                  pci_clear_and_set_config_dword(dev, 0xE0, 0, 1 << 22);
> 
> +       xhci_pci_try_add_aux_device(dev);
> +
>          return 0;
> 
>   put_usb3_hcd:
> @@ -713,6 +825,8 @@ void xhci_pci_remove(struct pci_dev *dev)
>          xhci = hcd_to_xhci(pci_get_drvdata(dev));
>          set_power_d3 = xhci->quirks & XHCI_SPURIOUS_WAKEUP;
> 
> +       xhci_pci_try_remove_aux_device(dev);
> +
>          xhci->xhc_state |= XHCI_STATE_REMOVING;
> 
>          if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
> --
> 2.53.0
> 

