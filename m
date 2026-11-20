Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162691;
	b=mbKSzdT9IKGJcHHiiTh47MDaD5qbUiWC9/o+IObsO0OuUco5NyZkA74n0+5xqArDHhzw
	 1BKTDEyKOf/HGlP30IPVMZtX/ljzNkRY4hwT5DdJn+cZz+IKwiO6JrP7vsCYNKOUfCEtQ
	 k8PnF78WDtnJjWjfF9hTptEqTk3wf4U+nkXI+uJRWBFvDD+DkT9ncZ1uZqADqcq5fFzP7
	 +lt47Fg/G0TYnnCzgW5/fG/TcRKP1PKBaLPh3GKRk+xwHuH6vsE5WxgwgMzNkv0+2qDDR
	 LqY94jy5YRaoqLsJyw0YGc3+4UUsw6UDZJLmKC+0ZDUUwrQueg8Tqh+9pT+Y2pX1ecA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162691;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/E1YuOkzJw8KsnJcLuJFLnAZRdFZZWeU9Q0xjhw15RU=;
	b=APTsA3mjKckNUHTNuj6/4lmzTj57u4hwk6rOPRZsuV+SaIsBWV9fexdYeL+qRUIcE/GI
	 ZEJxpxVkTE16yAgH6d2ilAI9zinMA7tyUsVkYhZqhUbU9wvtR/OEPdd+GD+reoUcDhd8n
	 FG76xjDSEFgF/wHfdvbyM2X496AaE0HRV3PcKzeHESJ3xzVijMtBTLiloA9Moa7P+DFAe
	 AgaiBC7fZYZJZXrIWwLkWVsnw9C7s9iPSOuerALPq6xFl2gavWC08er2Cd4W4Ir6O7JZH
	 eyKFP1SRp/LwXZHHvEXIZd9/vxWKrzbfe5adcCvhcI/5aWo4VRYqpaUpYi4pGTKpSLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pJyha6AE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.2
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01832606A33D;
	Fri, 20 Nov 2026 08:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01832606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pJyha6AE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY0QkkuQcqfOic+Xfu6ljWKSC72oQJAqFTCQrdVui3AHT3um/R4Hq3+G8TjoTdYcSfgZFpqCX84r7xua6JdMeN5KauhGrv9Ox0zkaGDA9TKTBFCGjbwCqS1pJ2uUY6vQGzH+UBKjkvw0Ui/x/Nl8Yi/xHMQmaS1gy7C3p+fnL8RpM5GgYYKhrOnI4dYpinjzDDMHXNmX7a95YJa4wgBSJ7eHlw7k9NvW81T/AtPrZrNHw2RaX3qdw3FwKCPg3DpYVF3AEL/KTNoFcVoDMB3S/vuvwLglUDN8eKJQ+MVergMUi2f2kILh3c1iXKEokjw/jbNi4GwInTvpPUwqGxVY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E1YuOkzJw8KsnJcLuJFLnAZRdFZZWeU9Q0xjhw15RU=;
 b=tPkTMSBzSaqDG7FIK4gOPBgNNpFkc/X5ar2RNGzG0nK6pSrykPOAgxOnPyihagWvxp0nwwYA2wUGpl3asqDpPDzJOljO2r0pUY/0LmZOXk0+rwh2pft3/lhqd+5jfmFz/qKIM0PxzLFiqyr5ktReRhlpW3kAMLH6o1ZOL+sN40I1UPIDbTNCVO/aB/Y1qPkfRo1P/VevB/BsY81tHCkj5FCkWKuF+Jgv+6pN9KlvbgPQKi7Q8qP7c+n0++eg515Cammrh07eODLZdTvq+XFZuyEA6VU060AyBBA63oNwR8L7ZZJn+MOJlI6/2cz9tBBjh0be49DCjGqVswWjm/V/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E1YuOkzJw8KsnJcLuJFLnAZRdFZZWeU9Q0xjhw15RU=;
 b=pJyha6AEl7616lmmq5vmcP5JXndiWZLJVsjNJsjEWNJYsexP7VxOMrsbAf7L29nPxoyEk1uWcZxexJYBjycTqXKZeJ2XbAgrkKr4UDMUaSHeO7IN0kYbAmjgBKGrdWHPvz3MjbTEbWgj/ylgP0Lp5GVlPdU1EXUF1RSQgGm0mwl3ith8zodPgFPN4vshqU8wXWwVszdp9QC/LPe461H8MRfH+MJFkdDClHUqW7bDt4hiN7yQO3IOxi6uMLHxjTY4wqiPEqlmnlKS/ybvc7JubUCXw2jNQzo7ajqfmc+AdK2hUEKS6LFKDizx/cB+B+wV8ehzM5330KDSDZkxWXlwtQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MN0PR12MB5836.namprd12.prod.outlook.com
 (2603:10b6:208:37b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 08:18:04 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 08:18:04 +0000
Message-ID: <b1153a9b-05c5-4f72-b91a-83e8cc6dd113@nvidia.com>
Date: Fri, 20 Nov 2026 00:17:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 11/19] PCI/CXL: Cache endpoint HDM state during PCI
 enumeration
To: Alison Schofield <alison.schofield@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li Ming <ming.li@zohomail.com>, Joshua Machauer <machaujo@amazon.de>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-12-smadhavan@nvidia.com>
 <avyPB4YCEKUDtT19@aschofie-mobl2.lan>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <avyPB4YCEKUDtT19@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::20) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: ce238295-41a0-492b-7431-08df46decd0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|22082099003|18002099003|261009223027099003|56012099006|4143699003|11063799006|10067099003|261026121527099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	iV0Y0l+lV7HKhYoi+UihdvvsZrwZ2m5JyTsy18Ct0KxFxorN7nSg68kOJOOi9xJuyrKwLfm7GHJPVOexJ22KuBnt/ag17Nfj/kf0vEql0SauvNPZX+3dG7Js6kyBf4uebsoYnl5Z5a2313OeXkkkl/F3VmDsddlrqzTzgky55VnNJmcVZ/OQoE4txSKqJ1Ifo4mUi+j0gwlU+jSOMljIYAysONx+REA/Bpmfc5EO1SA7MAEXyPDEc8Hgh87vkdIgRLgmWM6BZepVH9oxYD+kfoJdoLW7PEOkpO19wU8as+KFLfTWiQ19ais0vnndn4B+HNz1+vLVBaME2JFsZ74FX9No+RHmjaQpFnXLVilmsXkd2Dcm+0CdIFgUt3v7ybaXEyZjgh6wpOw9zYvxQ3B7Gq/AbAsyvNzrKzplvIen8BxaTEcSLUWlOnv5pckmkzlALbzkXxAiXpUR60H/Ek+ZyY/jPaHDt3LGoaetg6e2vq44sneu4zmlyCAx+XSaLiakfJ5PyGl392R6Sx3RgoGfGY1zim6x+c1WcI8XJfdMtSSBLJ6YOeNOnG3RCuHJ4mmpW3zguVZFPhjzX7NdcL+oztzKky0cQNS4RmVF4QT+HaDB8WbumWoS276HemwH7wO/bejgOiT1/P7MG6M4ZQ7441ieP0pvE6chhoWJQEehSgw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(261009223027099003)(56012099006)(4143699003)(11063799006)(10067099003)(261026121527099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ni9GYWszV0RDeHNHT0ExNTJtZE1xUmxDTm9JVTh5QWFpTUZSekltWURzdHZF?=
 =?utf-8?B?N0dLdlpwTTJQK0Z4VHY4S2xUQm1Hb0pIWTE0eXJMREtiUzdnUjdxaFF4WUhE?=
 =?utf-8?B?dXptcDVMQ2JEbXB2RnVxNVBPRTJDVEFFYStlSWRSZENpZGFzOG13MVdteXM0?=
 =?utf-8?B?UmR0NkRYbkMrd0tRREpSdVZlckszcFlqajNvWXM4ZDFaUFgzY3J0STZ0YzN3?=
 =?utf-8?B?VStQUmVCRWNaWTh1N084TCt5YWhrR2xmajJ4azZhZ0dPUWxxcS9JMGU3SXE4?=
 =?utf-8?B?OFFNUHRQVXpiNlQvRnFUa1VSZDNHdzZQc3FYaFBRSzMxeEtaTmcvZGFzYm1N?=
 =?utf-8?B?V0NJSFhtWHVwRVlFL0Y5T0xZRlYrOUpYd1pMVytteDVBM3ZIUFF6N2dTM21S?=
 =?utf-8?B?VGZKT3ZjUzdEcjI3N0dpVlhBbk5BYk5iV1FOblZ5N3BTaXU4V215QUFrblQx?=
 =?utf-8?B?SUFSbWdJWmU1VTZGOWI0TDdYUThQVXBmU0I4V3djRzAzZkN3Y0xSQWJGWkYr?=
 =?utf-8?B?cFBhVWZOejBkS3Y4WTRQdm8vYlRnZHlRd1Y1S0pweS9xWVdKRHYydFRla2Q1?=
 =?utf-8?B?dlJnVkJJNGdJSjJtbkxPSXd5UEEwNGVPcFJnbVdDaHltMnJ1OWpmaW83Smd0?=
 =?utf-8?B?T1F0Tmp6N25jV0RObm5OWnRGWW5RRlZKWGpwWFQ4blBvWjV3RlFPS2c5QTJn?=
 =?utf-8?B?b0NVQ1BYOVpKN0tWZUovcUxQN1Jwck1XRHBrU0pzdkNZQitFbVdpVzBZc3oz?=
 =?utf-8?B?ZWlJOGV0ZmZkdkxYL05LY3RRelVwZ1A4dmhzM0V5K3Z0dDJzaWJHaURPT2tS?=
 =?utf-8?B?Mlo1bzJWckdqaWM0TTBpb0N4OGlWSGIzZHkrZDMrL0FhaUhMSUpnUUN6OFV1?=
 =?utf-8?B?ZGxOVmdmU25xYi93bThjRGtXK2g0YzVYRmcwMEQ1UzIyQmZDL0tpV3lFTlVK?=
 =?utf-8?B?TDFkcWg5dGdvTXZUQmFLMGt0RFdVZy9pemE2RGJKL0dNeTV4eE0wQnpXbDJF?=
 =?utf-8?B?cmVtbDJ4N0FyaEQrQXU5SHV0RGtvbU1WVDl0UWhZbzExdlU4M1k0dHlPWXVs?=
 =?utf-8?B?Y2VJS0VQWjRvZmdUVFVrTHRBSTRzSkRFU3NWaXNGUEJtMTQvV3NDS0U5alJB?=
 =?utf-8?B?TERoVS9EMW9VOWp6d25wSkNIU2hBNnRXUzNLY0pKcXlrUkdjZk5IeHoxTFli?=
 =?utf-8?B?K0Vua3VWaWNuNnZPWVhzQVJkdkhvRXFIUngwT2dJVWNsaVh5dFJmdTVpU3Iw?=
 =?utf-8?B?MzZVSXFpMkM1cityV2c3OWN2WjFoSDdwK1dSWGJ6aytMOWR4ZURMakZuNkdJ?=
 =?utf-8?B?eTlpakl3RVBpTDhTMHBzS0E4dTVjQkRTS1hRUDBnSmR3YjR2OU1wUlI4VnhH?=
 =?utf-8?B?aCt0b0drdW5mTEtVb3hWbUNlOXdML0hKQnpiaElTU2FESit2Tkp6RjltQlNr?=
 =?utf-8?B?Uy8vZ3NoN3ZqS3I0NVpvbHFoblpMQUhLL0lKS3d0TllCekNkSTA3REwyU0VN?=
 =?utf-8?B?R3RNVm5VblNCUytHdVJTT0VBQStKa3ZxUW5YSW14Ymk2VTJQanI1SG93dEhP?=
 =?utf-8?B?T0dPbkhsSHdXNlZPQ0Y1QjVyK1dmd0o5Vm9DbXdXSnkvZGJYdTJVbm9kVlVE?=
 =?utf-8?B?NTNsYnFFL2tWVTJXVVBsVmhxM3ZwakNHMkFHNHBFdlFycG4wbkxmdHlLekEz?=
 =?utf-8?B?S0t4emZmK3QzRGwxSSt5S2dSM1JMZlBIdm9KazNoOUtwN2VrczllQmZ4d0pz?=
 =?utf-8?B?WnJ1b1UvWTNleTRXRlQ0cWlnRlljKzZiRmhqVlg1TitHbml0c25YdXhCWjJ5?=
 =?utf-8?B?WEw2MmNzUDViRGJWd1RqeVE3NDFvVFN4K1ArN3RwTWQ0bGJjR0pQY2pnOVFK?=
 =?utf-8?B?VUJEQ2dGVStFMU1temJpbXphbjNNdWpISnBmK2tEQUdwd21mYWN3NmJzR1dr?=
 =?utf-8?B?TldVbFdlYVlLSloyMVdLYjRHYkt3SHZXUlJnZnlqZjZ1VFRWVUU1b2hrMTV2?=
 =?utf-8?B?QlB4UXBocUNUdURqbXBvODNLMmtTL1pFajlDT1NxbVN4Wk5VeStIWEVjWTBL?=
 =?utf-8?B?cUZobFNia2hjbHJBbWVtLytLOEV1OEFGR1NHTkhkdU9KcjdDWTlvRmFmbWph?=
 =?utf-8?B?UkQ5T2FXQmhGcU5RQm05b0Y1a0tkcTlsQUkxcjZxeG9EVG10RVg2djRnUXdZ?=
 =?utf-8?B?T1czQmMwZlZVVzFpeGZCSDRBWFVWaFdOMitrTTdQdkR2Q290ODl4TEJuaTFK?=
 =?utf-8?B?RllkZjg0bXJ3VU91SExneFh3K1FqNnpoWUVYOGJpVlM1WDNJeWZsWmhKSnBT?=
 =?utf-8?B?N25TSUNLcXhTYUU2L2xPQjh4MzllZmhFN2xwT0w3bWczWDdDb2ZCQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce238295-41a0-492b-7431-08df46decd0b
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:18:04.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tTpQJsj0158bqFLOSLn/4xAkuhB5veEufAxcgJlarYL9P0lr6DUVlNR5KR++ZXO7nz2oHXr8z8GqJP5uG3KVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

On 11/17/26 9:29 AM, Alison Schofield wrote:
>> Cache HDM state in pci_dev->hdm after BAR resource setup and before driver
>> binding, so reset can restore it without a bound CXL driver.
> Does having this cache make the device ready for reset before its CXL
> endpoint and region discovery have run?
> 
> I understand why restoration needs to work without a bound CXL driver,
> but what establishes that the cached state is sufficiently complete
> for reset at this point? Some information, such as normalized
> addressing in patch 13, is only recorded later during discovery.
> 
> -- Alison

The cache only holds the HDM register state read at enumeration, so it
doesn't make the device ready for reset on its own. I answered this in my
reply to the cover letter: 
https://lore.kernel.org/linux-cxl/20261105185917.2667656-1-smadhavan@nvidia.com/T/#m82b76ee0215d67d91f67ec6fa72036615f1adb4f

-- 
Regards,
Srirangan
