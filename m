Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CAB51C07A;
	Wed, 23 Sep 2026 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166954; cv=fail; b=pjM7YMeBqHoDw4lXV1qxvXlzIgdobA5pLQlXDardGAX7iqrKMA4G5e1lnQ0zNhrSLC+muiJ3uUc/8vBVXvXJ3ycLWRJN2gAA0tcjxvG72X3rdBmZ4n3OLzFGifTnL+4GkAo29vVg/zkabRo0q7/rfQf0oyeW9x13iM071VV2Uws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166954; c=relaxed/simple;
	bh=UnOVvX8gX2ChzYuZC7+CKSxC4LEqv/L14OHarHTLV3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ltztMnwuiJLWIGwcBl2mqHPbwUB/iRpGHmrv1vLpGPfollWpXBZFsE3ehEpx3nSMfu5jljNGA79CaYU5QA9GTPstUZIHUfQoT9lxMh3kTuiGQox2Ld9U0/3gExJ0qIhSltZYa16ItHSsI3nLNZl6BXm1tH0ebgYTqkJBt071NWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aoKTbnex; arc=fail smtp.client-ip=40.93.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aoKTbnex"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQTYOvQhiZLOHmlhP33KdiUoXRJCUm6KU4Ec/16KUpNu3UnLAlTBw9HNPqJ7PdvdGlgGMrSocOW047yLyTWxeUye1ecLPPHh8WBEtiP7HYb7tNsOThCtq9iY3CxyCrYHcI/rfDBuOF5uZoguVvbbnI4EvfQDJLdhiygUuNxqv32SxCXvYp8LjJ5nG+pGx0b9bAayfPEkWR/gyz4N+A8hqDF7IW0AJcs4SaCDfiynw4KSkdHVYG8v1fntXRbkrx511VuJ/pTV0a32UB3qpCRK21gQyieiGwUTzz5HfBZM55z2LmmVtlS3zvzWeAa1DfQqEHSy46t5k+H6aftCcuLa2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76yWAq/my5cc5uLb5M3sLfdK3YJLoJXZ5qdagZIHBP8=;
 b=xQXpCrPtEa/EXOOwWCCROMxwWOi6OGRb6P98lxcVzWvU7WZwmqNbPKduy7UPtpe4Rg2ZQTjKUegoMtWQFjsAGFQ2zVmV2EjGp+VbQzbBoaL0e1U/vFIEh+c5swBxespRL1f6g9YObVDCsi1zH3LMLuwDmbAfVNa2le8E5JGSxYkNsk0QtbNku+1zebofZOvkhsZPYv3TJPf5Hx8n+Ogwp6KlCoSvCjUDEII19dsY1AW8sM0Nykq1rBa2frfIUviZ5sVhD6y83rjaDaGt5CvW62g6m39OZi48HFplFUN0gyBrLyVVL3nI2EX3WGt99Y9EY7/enqyFXs5oup+y9yoAkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76yWAq/my5cc5uLb5M3sLfdK3YJLoJXZ5qdagZIHBP8=;
 b=aoKTbnexcVykX6UemMzycFciuiZinY6ZbOTLVbh7rH150jS/URNk3DYuYCgpIe+fgNwgVxQle0XiXyP7peqbjMVYzXPFla8IE1LrlcUthGFaWQTZRVFaeD7+BfRNFdUdB3ZuQLYGMrywLKTIwScLW/GmnWzkwRMtLmP1gb8GbDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 12:35:39 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 12:35:39 +0000
Message-ID: <dc3fb786-f472-4e71-875d-8228b67fd89e@amd.com>
Date: Wed, 23 Sep 2026 07:35:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Content-Language: en-US
To: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>,
 Freeman Z <SHD-ISAC@outlook.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "westeri@kernel.org" <westeri@kernel.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 "YehezkelShB@gmail.com" <yehezkelshb@gmail.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "S, Sanath" <Sanath.S@amd.com>,
 "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
 "Martinez, Juan" <Juan.Martinez@amd.com>
References: <TYCPR01MB1092795BE7AB51121BBAB292496862@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260921050450.GM106095@black.igk.intel.com>
 <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533BF5ABF7035E6DF151C0A9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
 <eaaf891b-7b0b-4eea-b104-de2c0db7cb42@amd.com>
 <TYCPR01MB1092762E3E179C4A43874BBE696822@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550448CDBB308D04842601B9C822@DS7PR12MB9550.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <DS7PR12MB9550448CDBB308D04842601B9C822@DS7PR12MB9550.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::26) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: c89726a9-39a4-4f47-f1d8-08df196f2ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|3023799007|6133799003|10067099003|56012099006|11063799006|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	43WMyxBOrOEayKvq2jAXik6g3JkG6cXn8+mTrLtWgfAd5Oh+ok1WfDoEQY79uEVQl1g5h7iIHm2hxt+dOBN3GRi5f3nJhGsaFSDWSqWWvF6qbV1QWBeL7pbfn4bV0kiGdQmcSoS7pdWQnrCVQmdLDw/vIwmCpkmJktc4xTHgMuhG5bNgNZBmaHz74T9a+lTbFGbrlFrhrXWF2MByUaHnZeg+51jt+IJ+qS0q+RxZlst/0ME3KYGpjK2WTeuita1L+M8rULvVaiGbwyekM/dBnUX39EwLtfXof8364EIAQrpD6y8EE4+hAa1ZijKxxoT+NNjIZgQh8SZWGzwos9onOoXbwHOh2S5uCSOiegrH9hiD7CT6rQL7694U8Sfp+GDiI20ynaxmwvgY0J+S51woSmNBil5bYehK7VQBzlA/DBgKd1YnHDxUn7POfoTx0cQYeRTGCn3atJ8DeA/cSDsXj3ZC18GmexCFVoqFlrjkdychD5PgqMaxelOynyAxjFg38g/Dpws/c2pVNYgjVKw4802l6ha+cQCSFoEpt1cCUHhBYQNSXZsWr0Irfnfg6kL76wV78GpMZRLdVCpY/fCuI6bpoTvejYKiOWnVtrT3eUk0KT/9s/5j71G2qcLlPH8HdsQjCkZpOsOQhSSMPu6jY4LEgxMHSJ0KrVXWW116C5I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXZRTlprdnBiV29rY0tYeWl5SFpCOE5Ta1VJUnQwVnMyK2REcmhESWsza1c3?=
 =?utf-8?B?Yzk2MlkxSVZFRXlaQmI3ck9XRzlzazVpUjBycDk2RmxlZHB0UmVJZkdGbmFT?=
 =?utf-8?B?RHIyamR3YjIvZ2tDQzZiTEhQMmJ0d3VGc0hFYTNSMFNyZThsT3F1dC9adEpn?=
 =?utf-8?B?NDRJV3MzYXU3Y3QyWlJUR1ltRW8zNUVudGtDNGhIcyswZWVteHI2dDczaFJ1?=
 =?utf-8?B?NTBKbE1LMDVUYmhNdStVU2FHRGR4Y0dQSGs1ZEkyZUFVU3FIUS9sU2dpOE5U?=
 =?utf-8?B?Mm1hbHJkNGltS2c1d0gzVXBETDA2OWpsa2lOZnZ4L3ZraktkTmdnVm9pbDNJ?=
 =?utf-8?B?aTFkWm5VTjVUdjNoUGIwMzVIbzNXUXRVYmRmSVR4QkxUUzJDQ0tHdzRJS05M?=
 =?utf-8?B?VjN6cHFTU2ZpK0FiNHZ0czVkV0t0TnZzdDdaRlNwa0NNR05HNE5GdDhzeThn?=
 =?utf-8?B?QVZURzRsaTAxcHlNWHFlQ0tSUzBnMHRhRy9TNzRLMk9yZzVxQllIbDBhcWxr?=
 =?utf-8?B?ZVdFQ2RWcGxuVXZhcllUVkdnNDJHTzVCRDRDeEY5aUlkNS9jUjZaN1hLS1Iv?=
 =?utf-8?B?Q28xa1NEU2lncXBZL25BRGZkQms2ODVxTHdvN1d4RWQ0Mm9hYnVvai9IaVV4?=
 =?utf-8?B?cW5Vb2VmdzlrbE5MTUZFaVhQb2Z6Q0Rxcmdlb2FLOWJlODJHRXJjTDFadk96?=
 =?utf-8?B?elpZMkdWc3BiQ0Nlckl4WlFicEo1cGZhOS9xakt3UUdSazVLMC9Lei9wanZx?=
 =?utf-8?B?UDBjekN6NFY1Q3ZJYjV1M0FTQjQyVWZtRUtUa2t6WUhKNDJodThteWNBb1R3?=
 =?utf-8?B?b1NVNXJsZGJzUzEwNmV2YzI5NlZHTXVFMkk2eTRkcmMvK2RjRWVqaUJTdURx?=
 =?utf-8?B?dkV3cjJyMHcyNXBDMmtWT3JIVXJsUDhuTzMyWldUT1hoYUxEOEVRVjByaEk0?=
 =?utf-8?B?ZUF0bXYybno2MWl4T3JQdGd3NDZGZEFoVVhzUHRFcG9LU2djUXRKaGdpTFRZ?=
 =?utf-8?B?SEJjcU1ZS20rbm5MQVpzU2xzalZGS2ZSSzNJTjIvdXdxbmhld0k4eGk0Z1h0?=
 =?utf-8?B?MExMOVJJOXlXWjZSNktmQzEzb0hqeWpTUFlmQytJNjlVdmNVcUZyQmZkVURF?=
 =?utf-8?B?eDM5bjk2ejQ0eXZycWNoZGpLeGI5MHhWcmxTVXU2eUM1WG9Qa0pGZ0h2RW9l?=
 =?utf-8?B?SUtldnhJSmtOc0FtMjFYcm1xMkhkbFV4ZXlrMU5RbWlYa0JtQUhycGpIb1Fz?=
 =?utf-8?B?WlhMK1NvRkNibmNVYVhtOWVUSjJ4eThpcHVXVVh3bHhYTFUyR0lYNVRzemV4?=
 =?utf-8?B?NEYzcDAwenNpV09Ba3lraGhFdnNXUlhCTHJYK1Fmc0hMdlFZYjhCcFNVekdu?=
 =?utf-8?B?M3c0QmQ5YktVTWV4aG9QaVpGVENvRW9aK1kzeEt5RE1xdDV3YUExMkRUeUxk?=
 =?utf-8?B?VGRadnpNNjJvZkVNQmV6R1p5YnFNSUtNR3BsZFF1SGRENG1kRytyRUV3dWh0?=
 =?utf-8?B?N25IUWNLbVMrM1pPZWRELzhXck8rdURlbzRIbUhIVUhPbTZsZUJtb3l0eERT?=
 =?utf-8?B?QjhDY090YlpLRWdObU80YytPcVJqeEszNG13UTlwQmtaTW9jWWxJcWV3VDVH?=
 =?utf-8?B?RnNjOWFjZk4yMVlBZGx6MEN4eTVIMC81ZjFhaVBmTWdOTW5ZejQ0K0RycEJp?=
 =?utf-8?B?R3NQc1JSV2YvVHZsWW5maFY5a2xLalcxNkM1Z0FIbDJzY0NCZDdCMGcwS3px?=
 =?utf-8?B?bGk4MmN5Rm1DWkZDWUpQdzRuWkpyNWFoZ2lGTkE5dG9pZXpTNVFqYzhSeHdk?=
 =?utf-8?B?RjZDaWtyR3ZXc2RGYjJrZjRONEFvME5PbmdvVzRxUDBRdndxVldodEYwMi83?=
 =?utf-8?B?cDVyMkpsMndaMUY4M3NIZEdRVEhJTm9zRXBpTGFORC90ZjdYcWhRTzh5SUJ5?=
 =?utf-8?B?dGk1aU9nVS9JSzJFcXR0UmxGa2cxaXNrRkpHZlJXQVRiUkIyajN0M2liVVBj?=
 =?utf-8?B?bktRSUhyTVd3WmRiVkxlLzJ4dGVGc1BKNEFtSE5jNjhXOHJCVURLSDNlNEMx?=
 =?utf-8?B?ZkN2dGV2TmJ3NEFMSVk4eUpnK0M1ZFdLdVlHRThCcGUyNk83cGJlczJMdGIv?=
 =?utf-8?B?WVovaWRmbS9MMlRIVTZWSjVWUDYwOE9IQURxTmQraVZ0RFkrWEFoYXpBUDd4?=
 =?utf-8?B?U0tZRk5GcnFTdVZFTG4zdmRScXhibVVPbXhodGUxZ3FpbWtWbmdqazBTSU1x?=
 =?utf-8?B?RndwUFpOdjdyMU4rOS9EYmdXeDR1M05jYVBsTzQrbEkyS1Iwb3pybzMxTUtU?=
 =?utf-8?B?Z040eTZubk1CZTV5THA5Mlo0emY0dGFYZHN5WStrb21zZzJPUHhzZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89726a9-39a4-4f47-f1d8-08df196f2ccb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 12:35:39.6427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmPpIr9duvmFGGP7U1br7qljZdbaAlinjMYQHjzAnxzUOg97aEJVVmrUdacrUwRl1N7uR+q12qOGs9Mu8DyfWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402



On 9/23/26 07:26, Kovacs, Alexander wrote:
> AMD General
> 
> Freeman Z,
> 
> And this same setup still exhibits the failed behavior with a mainline 7.2 kernel?
> 
> Replied or Forwarded By:
> Alex Kovacs
> 845-625-4422
> akovacs@amd.com
> 
> -----Original Message-----
> From: Freeman Z <SHD-ISAC@outlook.com>
> Sent: Wednesday, September 23, 2026 6:52 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Kovacs, Alexander <Alexander.Kovacs@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.com; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; rafael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>
> Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents JHL9480 downstream enumeration
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Hi Mario, Mika and Alex,
> 
> I tested the Kensington SD5000T5 dock again by using Ubuntu 26.04.1 Live with kernel 7.0.0-30-generic and thunderbolt.dyndbg=+p. The dock was disconnected at boot, and I did not run lspci before the hotplug log and power states had been saved.
> 
> In this Ubuntu run the PCIe/USB enumeration worked without any workaround:
> 
>    426.716: USB4 dock connection detected (host port 0:2, link up)
>    426.753: Kensington SD5000T5 discovered
>    428.410: PCIe Down path activation complete
>    428.411: PCIe Up path activation complete
>    429.025: pcieport 0000:00:04.1 reports Card present / Link Up
>    429.026: downstream 0000:09:00.0 (8086:5786) enumerated
> 
> After the dock had connected, but *before* running lspci, the sysfs states were:
> 
>    0000:00:04.1  power/control=auto; runtime_status=active; power_state=D0
>    0000:09:00.0  present
>    0000:6b:00.6  runtime_status=active; power_state=D0
> 
> The downstream USB devices and dock Ethernet also enumerated. I then ran lspci once: 0000:00:04.1 remained active/D0, 0000:09:00.0 remained present. Thus this run cannot show an lspci-triggered wakeup or a resulting PME event: it was already working.
> In my previous failing CachyOS runs, invoking lspci could wake 00:04.1 and make 09:00.0 appear. I do not see an explicit PME delivery message at hotplug in the Ubuntu dmesg.
> 
> The external display did still flicker. The Ubuntu log includes one DP tunnel DPRX read timeout at ~431.188s, followed by a completed capability read at ~431.239s, I do not know if it's related.
> 
> Attached are the full Ubuntu dmesg after/before hotplug and the state files.
> Unrelated USB serial numbers and network interface MAC addresses are redacted.
> 
> Thanks,
> Freeman
> 
OK, so IMV either:

A) We Have a regression from mainline 7.0 to mainline 7.2.
B) Cachy OS has a patch that is causing the issue.
C) There is a patch Ubuntu's distro kernel that is helping.

I think we need to narrow down which of those is the case.

Can you please check out and build a mainline 7.0 tag on your Cachy and 
see if you can reproduce?

If you can't reproduce; check out a mainline 7.2 tag and see if you can.
