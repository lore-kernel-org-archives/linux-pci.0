Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706131D5AD4;
	Fri,  3 Apr 2026 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775251710; cv=fail; b=uWxVg1in15RNv1+xOqbC/wzCKnwkdowjH682fQct66fPuyQk0SLReSXVVQxObcrIssjsmqTFz98qNQRM1EhX7cEDfWKz6dhM5iuws+q6WidJzimTKfuZYlJlK/OyD6xJ0/7CHiICrXgK0cvaZPNMC+mzfeuUc0fy91szk1F+a00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775251710; c=relaxed/simple;
	bh=JWPaJF/sHKKAkcffUgj39F8tDnS/sN/d3WAfJHThP0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bskttFoiv0OjAFq6i2DdRRa4FCdXJXJoX94/nvpk0DDmlVXdMWEBliMe9C+fx9brEQSnmdKl2HB+XKMHJWitNu5qVZa984zk0FSIC64rwmipfSSd1Cx/+aVenJ5hN2UmLSWMDhIPVxSXtXXIkOcMAi3jW9v74JWFB7BCO8yzYEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SuABkZg+; arc=fail smtp.client-ip=40.93.195.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SuABkZg+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsHNSHoKm+OojHiQIkzRrLr3/b9Y0ogx6z+HV+hOM6M1NU3tAdNGu2LW+qHBaiQkaplPd31XE3ZDkJcAXtvhK5oVAmEHRr4yfVNqWovvGxVDbwOpmH44pFBvdbcAIIOB+rFOQ6IKyGUzZ2iWAkBlqqK7aW0UXFIiziuyZ807BtBGSmTCEaWMmvwWwAr6xFsvHCoCXR6ZuT7F7C4dvuo0v0maNfeRfb/F+kn5QM410ozg6HcB3SjDW0WJOakcXqbXKLluMBDdBh0TJu17paCSoQBcybpWV7KEN/lqEvyS71G1yCyuX+CxlGqI0Z5U/tE0GIII1QuNXaxY2Z4xy5XAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TN1rBrKjCXTE2tkyjrvZAuYp1G/ZsCKA9XCbbH106q4=;
 b=LD+RhBEvPEccqjaMeqGeNDHfx4aAn9F1si3GL0WR5AbvmsVrRyd75D00P2bNpzGLLzk8Zzi98sxRAnwW5MZd0XY45/2pDuTkNGc8lZTNUwb8gpf/u3uAVflLf4oUThpbpDUaTd4+EsgRBHYjCkoWiGQUxMtvE2Jfa6YAhc8wQ9KzFTkdSjDfeSvJGwI+dzgGmW31gbDL0+A42x06SGQ4tQagd0m2XvDLJRz+3B4ZznXUmVzfdqdJoI6OYMQQVup0OP/Lg0I1ZsdEQJDj3K9tQGkpS9OLmZ/oddyrnpIdbSGnHfuy8S1XuV1inZpCFS5pl+QJhj4ZmNUm6NKaNgxPug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TN1rBrKjCXTE2tkyjrvZAuYp1G/ZsCKA9XCbbH106q4=;
 b=SuABkZg+kUtT3E5XiNtRCcSMuSkfEaCFhE1bFkobkJog7Uy07/9q7vVN35hoZ1laRx9QLETE+GzddkBF8lKrUZwpEpl4bPbiCCW2I3xm74nezSI/LJFTLWqGT1a2iH5VlQNar36NNXoZhyNYmSA4f5G6xmadi21d629eeW5NGFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 21:28:26 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 21:28:26 +0000
Message-ID: <adc13acd-4a2b-4b64-9dcc-c622d8b9f3cf@amd.com>
Date: Fri, 3 Apr 2026 16:28:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts AMD
 1022:150b root port, NVIDIA dGPU returns header type 7f
To: Joyful Lee <joy@joyfullee.me>
Cc: Bjorn Helgaas <helgaas@kernel.org>, platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede
 <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>
References: <84268751-a128-4cfc-94ae-588de5d98ec8@amd.com>
 <20260403180422.GA341023@bhelgaas>
 <CADj6jrg4YWx+iR0o=JSh23uP0Mb2Mvs-ngCJXGUAwCCUQGHM4A@mail.gmail.com>
 <d0994dad-4506-4b5a-b44d-3bb68aae4517@amd.com>
 <CADj6jrgEwySW_A=-0o947aGg+CmaZD+qR4NnopVFoQptdHz=bQ@mail.gmail.com>
 <024bce0e-5bc7-40ca-be01-278ef9935531@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <024bce0e-5bc7-40ca-be01-278ef9935531@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:610:74::22) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 826d02d1-9173-44de-08db-08de91c7f108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8kXbNQUukL6BHNMYQSTJgIm2lq675W+gqlRjbhXxbtl2GxrFqx5TxA/kFdC1xOYdErHztjZoZ9Q9WM/L+xQT1Q/G1riI+tKCRBBj3xIB3wLbC4ptwD2P145Iq2bCcND+LjI4WJjb30Oe6daFfjVTwTX2DbIcc5fqffpCtSJvPfvqlDTzjGO1kf4CMeHyt11lhFGGn3ODzLHWRzWDy3+WnwMlAJ0UuhgrpdHmkIdmrgak9uhtwMAV6o6iGk3WmEw+ntiVl4pTDyqmP1CIzDAauRrXF6YBdolqxFRPnNqmP+8uwUYu5i0CJ4NVGCiLl953PqagfZmUifBJukHY4KgDW6hN4q09Hftzha5Ec9X+dAw5RiDXXsR4FxaM/P82WxnvVXkSoRazYZEAF+9+TuO18gi4pMivk4RcYQYI3OmhMA0c9YLQDz7jG9pDh3Kh3eukZ4NXf5OhmZipXwhzuobD1l8P8pSRVLjpJRMlpDRPBa0Ru4E6JvA7EYXpmKeifkrjo1ijefJcSGzenMq7eZF8zVqU3vg8uyRciAXSwylZyRVvcC/Vlsmhq4fa9yhHmONYNttSijVWKW09KO7rsEYpZYYof1jG8+e19/8cVPVbYu97xu8UyfVxBAOjZXhM8yRx1sFi5bxFKbOqC3AWpvT3SWUkgtrnEDGDQ/VpFwLnv7MOzyJ8/e+5FgyL0h1RBxsteHX1tO7Tccryj1DgJjlGCudbpcR3ZGvAadVo7lVA9h0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDZDMmZETklsTC9vNEdzQVpBRXFuME5JcFBPUUo5LzA5b2VpaUliSDR5alFR?=
 =?utf-8?B?SkJxN1NkWkdENW1wZDhQN0JObHk5UDV0aE04bVl4TnBQNUw5UU9FdmQ1dEZL?=
 =?utf-8?B?Kzd1UVlFblVXYXViZVZUaDRmVWh4cmY3SFo1THFDSDRsTS96b25CZjV6YWFZ?=
 =?utf-8?B?ejlvK1NJVEFvU0N6SnhtcnFOQlN0WXg0YjdzUjZlUHdCWHM3UUt0MzFpQk5L?=
 =?utf-8?B?N2srUGh1RktDYW9KU2NiMlE2UWtZQWtYbGZSOXIwK21WdHdzTTk5eEVab2pm?=
 =?utf-8?B?VkVmYTlGOUhiZDU3VUR0azIxRFczUEtWR0IzVzNFSkZRaFVtdDVuaytYQWZh?=
 =?utf-8?B?TVdWTVc4M2dyYlpnOWVsbnd2N3lQVWhWWnprVzZDSGh1aVJiQ2owc2J4TUda?=
 =?utf-8?B?MWJDbVZVeHNRM09ORHovY0t0MVc0OS9zSGxTU0hwczFNcmR0MEh4cTBDalM4?=
 =?utf-8?B?QTRJSUlxcjE4a01OeUd5aXo2MzJ5b0Y0alpzdFoxeGZLQVBlVmFKQ1FhS3Ez?=
 =?utf-8?B?SUs4cjVVTCt5enBKVWxUSTFPc2krM3pGaFoyYXJ1cVduaWdtUk1aKy9NYjFk?=
 =?utf-8?B?UEd1QkNYeEJyeStXNlVaNGtFOUx1dHhOR3RSU1FZSzByT2dMQVhPZTdJalFS?=
 =?utf-8?B?UXFoMWlLTlV1N29zc2tTcFRLUVpuZ0F4OUY5dFEyUTBPbEtsbW0rMlZreity?=
 =?utf-8?B?RXNaM0ZOc0dBcVdlc2pNOTBJdVJOSjA1L2dzc0ppUmUxM1k2cytwYVM1VEJO?=
 =?utf-8?B?dFl0ZnhWWnJVM1AwOTUzNVBsdk1uVy9FY1lodFhIMGZSUVNBK2ZEN2dkNzdT?=
 =?utf-8?B?Q3ZrcXk0U3hWb1ZCS0h2UTh6SmZhVFhpQXVIclgxNHhHWUlSd2FkRUFXbE81?=
 =?utf-8?B?MEdkVTBmdVhKNFhRSWdIN0JhOFNhdk9HTnM1Ti9zdUVQdURCaTd1cjNDMDFO?=
 =?utf-8?B?dEpFSWpvd2s2dnUxZm5McFZOM1AvWVpCTWVQQ24wTWFHN3BVQWN6WVFXTUhW?=
 =?utf-8?B?Nm9sNGlHRnRJR0N5Tlp2WFJwVVlYUmVwbnRsOThNNCs2b0E4SHFyZHhoTDB6?=
 =?utf-8?B?V3lqbVR0OW9PV2s1dmdCMHY1YUxSemtDTjNiY3hQUUtYaTl5ZDBFK0JTQ1Ey?=
 =?utf-8?B?QzZVN21KU05JdFFnUHU1ZExZeEhRZzBnV0YzeDEyQUV1NnA4Y3AwYXVzYTJZ?=
 =?utf-8?B?alRMWVNlRFU0THl2dmdRLzNQSjIvMGRTY0w0WFU5K2tnRzE3dzJISTAzWXdC?=
 =?utf-8?B?MVIwc01veEk0RkdBUG9VZlNZMlFFSFZ0d3NvWEFnSWFXbmFCckttRjdab25C?=
 =?utf-8?B?aFJLTFRWYmFpa2EvczAzMVVVUnlWakxVZHpoTlZORURKYktXZnpGYTZOZlpV?=
 =?utf-8?B?amNBWE5yeXE4S3g4UytRdGx1bjN0S0Z2RUlOTS9yVnpSMnRRaGI3dkpKV0tn?=
 =?utf-8?B?QitHOHQ3eWRaZjdMbWV0bzJIOW8zTnRrb0xZVWJ2cmVJV3pQRmdhd2ZCd1hz?=
 =?utf-8?B?U1AwUnJ6RXZsQ213NDJ5b0NlanhsanFlVnpGbjNFY0xxY0pmVTFFdUJjeUNN?=
 =?utf-8?B?WEovLytNVS9PQzBBMHlXamJSYXo1eEQ3UUdaMHVxYVE2aThaVk8vV01UUGVh?=
 =?utf-8?B?bmVDRVJLMnR0V2I3ekdLS2l0M0lPb0VPV0MzWjVETmlxazkwMlZsb3JYbHZh?=
 =?utf-8?B?N1FYQmVwQXlNQjh0aEpxcVMrRkhVZGRYUWlUQUNLKysvR2ZmaWVDQ1pBSlE3?=
 =?utf-8?B?TUFTR0JkeU1QQUQ2d0Z4QzU2T205dUdKZnl4UXVBaExwQ2FzaEU2WkVwME8r?=
 =?utf-8?B?aWpYSDZSd0RsUDVlOEVwT1ZVWFBUR2Q3Qmo3NUxEVytvb0hVQWFqR2ViMzlO?=
 =?utf-8?B?ZDlya1hrOFdjZ05ZT2VwcW9pcDFjTlNvcmNXUDdXR0dPNEs5cEhHOXFPQ0JN?=
 =?utf-8?B?UzNDd1UzQksyNzNEZ01jV2VUTUV2NERFNTBHWEdybXZhdWh3QnNUemVZNGhr?=
 =?utf-8?B?ckpXUDJOK3l4OVRQNS9NOU9QZ2NrcnBCYXVjR0dTQmpVNCt3eENJN1h2NVFW?=
 =?utf-8?B?Z3dWY3RvSTk0aUhTQUJaelgzbnNoQ1oyWTdTelZZWG9oQmRLQVJaNVBFL212?=
 =?utf-8?B?bkFnKzU4Ym44YmtGMkRkMkNMRGl5b05XV01IVXloSWV0ODVMTDBoMEdldzF0?=
 =?utf-8?B?Ui9BcXhnSnFWeE0rQmsxNmVKa0F4M29wcHQzTCtTZDBGdkVkKzNTMHVUSGZU?=
 =?utf-8?B?V2RqSHJkMTNRbjNLZWc5WWhIUEViY3ZSR1UyTllEVFZwNzJobDhNTW1qdVNp?=
 =?utf-8?B?VndRMzcreUJpYUhSRnlvZXVCK1kxTnNGSWVsdCtLQWNITUFWQmF3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826d02d1-9173-44de-08db-08de91c7f108
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 21:28:26.2785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: og1Fhhm67fTof5KtyzuC8Ub7q5/lD92Z127gjH1KBN8/r3h8PswbOdUqlj7ALlBZpkUbY/Kl455BNnzD1RR/pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835

On 4/3/26 4:05 PM, Mario Limonciello wrote:
> On 4/3/26 3:47 PM, Joyful Lee wrote:
>> On Fri, Apr 3, 2026 at 4:03 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>> Can you do the exact same on the same branch/commit but without pciehp
>>> enabled?  It will make comparison of all the impacts (not just this root
>>> port) a lot easier.
>>
>> Here you go. Unfortunately it's not *exactly* the same because I had to
>> disable the nvidia driver to get a result.
> 
> Thanks - the most obvious observation is what you already noted - 
> without hotplug support the root port skips PM all together.
> 
> [24.575705] pcieport 0000:00:01.2: PCI PM: Suspend power state: D0
> [24.575707] pcieport 0000:00:01.2: PCI PM: Skipped
> [24.575709] pcieport 0000:00:01.1: PCI PM: Suspend power state: D0
> [24.575709] pcieport 0000:00:01.1: PCI PM: Skipped
> 
> vs
> 
> [29.279987] pcieport 0000:00:01.1: power state changed by ACPI to D3cold
> [29.279991] pcieport 0000:00:01.1: PCI PM: Suspend power state: D3cold
> [29.280214] pcieport 0000:00:01.2: power state changed by ACPI to D3cold
> [29.280219] pcieport 0000:00:01.2: PCI PM: Suspend power state: D3cold
> 
> The hotplug support seems to apply to 3 ports.
> 
>    0000:00:01.1 (Bus 01):
>    - Slot Capabilities: 0x00040060
>    - Flags: HotPlug+ Surprise+ LLActRep+
> 
>    0000:00:01.2 (Bus 61):
>    - Slot Capabilities: 0x00040060
>    - Flags: HotPlug+ Surprise+ LLActRep+
> 
>    0000:00:03.1 (Bus c4):
>    - Slot Capabilities: 0x000425e0
>    - Flags: HotPlug+ Surprise+ LLActRep+
>    - This port also has bandwidth control enabled: bwctrl: enabled with 
> IRQ 38
> 
> The port stays in D0 because the child (the GPU) stays in D0 for suspend.
> 
>    [24.599889] pcieport 0000:00:03.1: PCI PM: Suspend power state: D0
> 
> 
>    [24.599890] pcieport 0000:00:03.1: PCI PM: Skipped
> 
> So I would say we should look at what the GPU isn't going to D3 for 
> suspend for the next clue.

OK - so the issue comes from acpi_pci_bridge_d3() which is called from 
platform_pci_bridge_d3():

	if (acpi_pci_disabled || !dev->is_pciehp)
		return false;


