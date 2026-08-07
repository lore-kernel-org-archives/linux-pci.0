Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3B33BBB9;
	Fri,  7 Aug 2026 05:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786079156; cv=fail; b=XbuOa2xnM+C3DnTgS8HVfCY04nhGNS2Z/6W+HMQyXV6tyzXZibUtWG9PJWPdNvQTF8wKW5zZIDt3oWSmMJAxPp1iSk5LvhpI3YsUqLPhGfIxb1VkRdijrEPBaHSvN4JC9vs3cK0JAAGiDV8vUCISMj3KttXAT+pBu3NMbKXfmSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786079156; c=relaxed/simple;
	bh=05awlTiwwIU0WYHxoKk4PiXou5Mh5WMYAAFQU+RVrtg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HzEscbnZKCXOgIW1W7ZnMokN/jhp1DwBpih5YA4MCdAhng9LcVz2IVwuGawdvLTDX592uGoipkED4QUsHG7FlZEjHPMXr2lccX6i+wqnIKoZPOI7/vl8HSR5NJys4n9Uu3lYvaP94GKy5JVbt3KNfNgFz6ZNfkH8cpb5yWMlIPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qmYxSwj6; arc=fail smtp.client-ip=52.101.85.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qmYxSwj6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHd7QtC9NLbGtsqnDlEbhdXYCu9J+sDPlcqIEz3V7AtnGsTn3zLAja6alTYMo5W55/JAStoX/amP/VFGrwvtkxy4fwGNeqhlDEBFwQ55gmTPBZavQdnEV1oGpNzw0C2jyBul3ob4bBHXoZEKmjmZIZegGEou8lO5ncMtuxr9GKJw3tj6RCckuiPlUhOj0UilWoayo0UYxiWt0gnR/hanekZ/SiJZ+G908RHgOuMR5KQWXU/eYWrUbOYxi1hDwhCtf5C+UTGXUzWjWLkPjw8+xSCBNl9a3yl7AVWrh04yvTd4QbNVlzEPvO1/FNhE86Qu/6+8+r1HSBYytSKFphLiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AR4znTdBFRR++Boh6IfuL07mvlMYJ3raLmK0T6iZO1c=;
 b=mXo40C4QawpFfO72maRDIKPK+ZKfwBXZQqK1Pj8EqzXVcctwlL48JVfhSHzKEx46UgrvWAp/O3BGAMXYjoYuE1qRebgc5hDg+NS6FZ5Hom1DdgiVLbvVwBh1ClBWQQHS2bCwnMudfLEqrPI2cqn2cFiEaB8zH8+369k8gv6rjc06HQsdhrv70AejC11UMVv83fbh5S97g2hZSfyGHjyuNhTmWbL0z7vaBtGOGgot15+IHQmzGasVonblgNTvz3mLJqOXGov5qMYO/ZJUg0uyDIECcj6obYSIex7onuOuDFMHHQVnDOM+71ztPnZMaxu/weM0DDOd3eks7IpdJthdog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR4znTdBFRR++Boh6IfuL07mvlMYJ3raLmK0T6iZO1c=;
 b=qmYxSwj6z0F4pyfZoOUczTrpmgWgMqjKl2ZQvlGbGrM6/mwCqCtkamUidRzmMuocwsqVKD9rtTL7AnoMBflAKa7P+IxpTNcd/CXHWW9y6kwzIYffhhlDhyVekaWHZ9HkB0Im2G9PaHNsW3lQH+jA3+VvZVtAht8uhC/PB+fduRUqiLyZ31EsxAozltGVyvG0yVOpO9UO5lTclzCtJcH0pCDqraT3eOZiVDiTG+EOyZx2++OSEgVKZeOyVeZBgKOSW6M+C1TVyP5LyEHg5i9etoQmNt6Q9wPH5n2rFr6LvKRjDIdSZuFYe7aBRaZ9fAi8Hx6WhXSagf1w7PFk2uvrHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.21; Fri, 7 Aug 2026 05:05:39 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 05:05:39 +0000
Message-ID: <9cc29a0b-6a9c-4b97-9cfd-f24ccad654fc@nvidia.com>
Date: Fri, 7 Aug 2026 10:35:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/5] PCI: tegra: Add Tegra264 support
To: Manivannan Sadhasivam <mani@kernel.org>, sashiko-reviews@lists.linux.dev,
 Thierry Reding <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
References: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
 <20260805-tegra264-pcie-v9-3-fa2ed7350ae1@nvidia.com>
 <20260805121039.A79921F00A3A@smtp.kernel.org>
 <sdpakcbeferzpxn6bf2acic4kfnfoaa6kgxmmi3asw7jqprekf@66cnwvuwk4ye>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <sdpakcbeferzpxn6bf2acic4kfnfoaa6kgxmmi3asw7jqprekf@66cnwvuwk4ye>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::10) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cec9d60-d245-4ffe-086d-08def44185c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|4143699003|6133799003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	wm0laconbgVzSpBFHxsSJ17g9IsSi2M76lRHIdbs/Isd9RdIcFzC0PPDUTgrJZk84ej8pcCbPNaRBaY1LEPqS6qyACob5txwcO4qkweoxd+xZHs8Q4Y7p+dch4nF4P4ACzqmhW7AovlPFRK9RUmN2WfcA6V1T5yJ8CN1/pT6pyDjahSMh96n/ZoQetWw0rpGpMiX0XeuvFVH7e2YcugUZBdF/OiO/AeMuNETEjiR5OcSqsX2c9Spn8jt3u2h1EjQd04T0lyv9gr9LSp7anhEyd0mHCBShGDm5w/Rknamp6AAxVDQrbEgzrxGE0SqFTlbJ5JJWaAJGVA0VjJAOZWGaH7MVT7IckYgIR+CBj/8lQ2hYPYbqcXIZfgI4ZOQIEr7Y68nPO0JwyFt+moOSlWudEOCWyXCZLNVk8/k+mYs8TNtD+vkEMeOtp2/wseeIiQkHW2yGliPAu771G9DoVcVAeiL4fGUodYL4ShL+a95A4bmHrRzd1AO3VCThfXsUKxTXvuuXd2rlW+V7lsv5yyMxSSQi4FQ8ULD53R3VoogOR4looA8sOE32z4ivxIUsI8atzbjZvzYae0xA/IWahwJ6ZlBgTeLzGmPapcwp7ZZNateZL9/l6+5MoKMl4Gte6qR7D2u1cFqR90hmOC8/xBR8ih0rP7LT3KKpbCYiiOYDQs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(6133799003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHhtc2hlMkJ5SW1UNXBLRi9jVHB6V0p6OGhkZkFuQzFENklQT2JuWUlva0F1?=
 =?utf-8?B?ZDROMEt2d3hYMlJlU0MyaU1wd0JNL0ZBd3JrS2lCSnR2Y0poU1EyUEM1T3cr?=
 =?utf-8?B?eDAwa1ZJNGpMRTVoNVMxZ0ZORVpuOXVrb054NktzQU42eUN5NVhvb1B3cnBm?=
 =?utf-8?B?bEdpTlZKZUhtNG43bzI5NVhoTVIrMHlKUmxTRXo0bTFlc3JQQkUvYjI3WDVX?=
 =?utf-8?B?Qmp0SGY3d1M4R1owL20vVjM0L1BMRWZtTFl2a3UwcWNlWGtOYVpubnJMaXhH?=
 =?utf-8?B?MXlETDNPazRjTXlmY3JIUk05eTFCblgwVzc3eXAxOVFsc3ZoTXNEOUsyVFZR?=
 =?utf-8?B?ZVBtNk40T3NJMFhWcXZrTTErYk5jckVSMElsVjA4L292WVMxSFh5VUJMV0tU?=
 =?utf-8?B?V0pST2dFTkFhQ1FTbiswbDkwcVZsQmZWSHNzc1lpTWl6UnVVdHVYejVDQ2Jv?=
 =?utf-8?B?b2g0WS92UHhuL2VZTDl2SXF5bE1IcHg2WVhKbUVRbStuY3JQM3NNTFN4cjFy?=
 =?utf-8?B?b1F2M0VaOE1aZlBTUW02R21OQVRCUUg0US9hQVNXb0RYbzVicklNTEp5UUJC?=
 =?utf-8?B?eVRDRjEwWktKNmFaMURuOTdkMzVreFFWTTFnbXFCZjgzemZMWjNPWElDTHV6?=
 =?utf-8?B?eUJaWGtCem9oR0F0VThuQ3NzQzlMaEdraVhJTCtYaXQwZVRZald3YXBCVkoy?=
 =?utf-8?B?U3VNY3A4aFNqNU00d2oyZjNlUFhTUG83dXJod1R0RVo0NEFpKzlhemdsVG9p?=
 =?utf-8?B?QWdpRE0yeEJwZkpsZGg0VmVScDdscjZWcmRkcFZkN3VhdG04eVpFakh3N2hN?=
 =?utf-8?B?SGg1YXVPK2gwZ1daUGg4ckZ4cDF1Q2xJWVlqRDVrcm1HV045aE0vKzRZVFJs?=
 =?utf-8?B?Ni93YnR3WCs3UGZKN2VRbVB2UWsrMDNBdmE3M2pzbzlFUWszMkFNZmt5Wmwx?=
 =?utf-8?B?V0lOZHFINHFvYWpZUkdsMTBmbXUvODlaOUlrSFZOUXNrNW4vTjl3NitpMkFz?=
 =?utf-8?B?R2VTb2RjMjdNeUprUU1qbG01RmFDd1M2NzFvVFM4WnMvc2Q3NStXWWpSY05y?=
 =?utf-8?B?am14L0lHUjFKazlOVkJiMFlHSzBtRk8wUGZvMGdtZUMvTGF4TXlYNmtKcWUr?=
 =?utf-8?B?Tjd0Y2dYUW80MUViaSttWk80ZEFyR2duSmxSOFhxSmN2T3lqN2VMcW12dHFM?=
 =?utf-8?B?YVMvUnk1bFpWTTJwMCtWZTVlVjVyTDdrKzZiM2dCSHBnNmNaWmtvaWoyUHJk?=
 =?utf-8?B?UGJweElBVE53UnNieUJRdzdYNS9rcDMxcUhoNXJvcWZqdjFjb1U2MjRDUVZP?=
 =?utf-8?B?Nks5OGdST1llalpjRS9xR21XdWhOU0RDUDZudGJDMTJqS0dVQ0Vwb240YWJE?=
 =?utf-8?B?REFYSHZrMXVqT0tEWWk4bnE3RnQ4WVR1bllSc1JkZDNJWXNndzF5SXJTRllz?=
 =?utf-8?B?VDNwOEsrZnplQWRDMDVLN0NtWFFRREl1TVBvcCtmRkQwU3Y5VFZuNXJMNGt3?=
 =?utf-8?B?NlkrbnFXTktpQmRFczlObi95bUp4NHBLWEI4R1BHZVpwcGF0Q0VXdmhDT21z?=
 =?utf-8?B?c1dCa2hqOGNOQ1ZCN0JaUHc3THljMUd6cWVRdFh6NlhQcmdIUFlsNDdRS2t6?=
 =?utf-8?B?Y2M2QnQ4S29XYTBUNHVNa3JtbU95ZWJaNTJBMDFPUzdqRmlTMUdEQXNsSDJ2?=
 =?utf-8?B?dUJURDVLWDdVWWpSL28vUVRQeXpkemo4YitIN2hhTU5CMmZ2cG9JemVyNU1r?=
 =?utf-8?B?bXgrb09TYUVhUGNFbWcwNXo1YnZRRkRla2ZYSG84K29neERXOW41R1BQTXpu?=
 =?utf-8?B?dkwrbzRQT21uZG42QkQ2dXpoblNBMkh6UDdTcjN6U0cwT0FQc21LR29HcHNE?=
 =?utf-8?B?OU95Q29ndU02dTVTdjcwamJIRWNvaFNQblluVTZXTU1NMzRCK3RwS1Nwd2Nr?=
 =?utf-8?B?d0djeTVKZDBqbWx4cGpMdmk3VDduT1RhMzM0dzRmVEpjQlJmeHg4MWlJa0xq?=
 =?utf-8?B?cXVkTnFFK2JxT3d5V2R3ZWFnYzlaNGhBcERmQldDbmliK2JrcmV5ME50VytE?=
 =?utf-8?B?OHA1RXB6eFoxZHdDUTNDaWpjbFRXOTRxM0VmcDI4V3lUS0tnaUVQL1ovSTZT?=
 =?utf-8?B?bXFRUHlsS0VTMEl5a1EwUkMxODBBQkN3K3lrSUtqZnpPMHNoS1RreWpyS1ZL?=
 =?utf-8?B?NFpFL1l5UjRHb3RDVjBxUVJNUmQraFNTSnRaZWNKY3dXc1FsaHFadUhFa2dr?=
 =?utf-8?B?YTROQmFMZnp5VEtHTDErTFFLMkF4Y1oxZ0ozSDB3WkJMRWFCU2g1MTZuQlpR?=
 =?utf-8?B?VlB4MEFwdG5aS3VCS0gxSit2UGZqWEdSQVUyV0pmak55RGREYU9KMHF4WlBL?=
 =?utf-8?Q?JDRlZBNBaPOWmrkc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cec9d60-d245-4ffe-086d-08def44185c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 05:05:39.1380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJefGhblODupHrsDXD1kOZtdHsC1LDRJ3qnhN5b9b0z4JTLwovhEIG0moEjlyIrpP8rLVXP6aPQqlmzmvA80bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247



On 05/08/26 9:21 pm, Manivannan Sadhasivam wrote:
> On Wed, Aug 05, 2026 at 12:10:38PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>> - [High] The driver incorrectly accesses the ECAM window via `pcie->cfg->win` to read the root port configuration space, causing an out-of-bounds heap read on 32-bit platforms.
>> - [High] The driver incorrectly uses the Negotiated Link Width (NLW) to set interconnect bandwidth for hotplug-capable ports when the link is down, permanently setting it to 0.
>> --
>>
>> --- Patch [3]: [PATCH v9 3/5] PCI: tegra: Add Tegra264 support ---
>> commit af63006f768e2991e49a48de9855ea58d20662ed
>> Author: Thierry Reding <treding@nvidia.com>
>>
>>      PCI: tegra: Add Tegra264 support
>>      
>>      Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
>>      driver is very small, with its main purpose being to set up the address
>>      translation registers and then creating a standard PCI host using ECAM.
>>
>>> diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
>>> new file mode 100644
>>> index 0000000000000..e0c5b9d0d20bf
>>> --- /dev/null
>>> +++ b/drivers/pci/controller/pcie-tegra264.c
>> [ ... ]
>>> +static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
>>> +{
>>> +	u32 value, speed, width;
>>> +	int err;
>>> +
>>> +	value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
>>> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
>>> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
>>> +
>>> +	value = Mbps_to_icc(width * PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]));
>>
>> [Severity: High]
>> Will this permanently set the interconnect bandwidth to 0 for hotplug-capable
>> ports if the link is initially down?
>>
>> When the link is down, the Negotiated Link Width (NLW) is 0, which means
>> the bandwidth value will be calculated as 0. Since the generic pciehp driver
>> handles hotplug but doesn't know about this driver's specific interconnect
>> bandwidth requirements, it appears there is no way to dynamically increase
>> the bandwidth later when a device is actually inserted.
>>
> 
> I think this is a valid concern. If the ICC BW is set to 0, then the hotplugged
> device won't work properly.
> 
>> Should this read the Maximum Link Width and Speed from PCI_EXP_LNKCAP
>> instead of PCI_EXP_LNKSTA to properly reserve bandwidth for a hotplug slot?
>>
> 
> If possible, BW should be updated once the device is added, but that requires
> detecting Link Up using some custom IRQ if available.
> 
> - Mani
> 

Custom IRQ support for link up and down events is not available in this 
IP. For now, we have two options:

1. Don’t set ICC BW for the hot-plug controller.

2. Set ICC BW according to the Link Cap settings when the link is down 
and it is a hot-plug controller. When the link is up, use the Link 
Status settings.

We can get changes in link speed/width from the BW notification status. 
IIRC, the BW notification port driver has been reverted. If it comes 
back, we can consider integrating the ICC BW set logic into it instead 
of implementing it in each controller driver.

-- 
nvpublic

