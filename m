Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794391951;
	b=NXMCVzDViWzmjh4c37194BtOuDnGu/r6x35VsUbuqKT8ie0C6An6f81/caI0E6r+K/Yh
	 mUQylGmza14rqnPJ/7VQ86Z6acafEXWRBoJJ+MJH7HZBxLpFW/yMI0peY1gvEQMAyjLQf
	 GdhJOz6yhz2/lpqZc+0Kd/Y4PeR7eyFGzJgZR9jidwVARfBIbKlR0ySpzgdFIgcCewsdo
	 w45oSTMBDf+kjpPL7YHY2bjuS42lkjLYAwRshXGqEIWx2TTwI60Ifb4762l+nco95Cwwz
	 CddL+NO/JxOghn1W4GRQo3Eo/ZopQ6b7y8hPSld9ySrt5+AUUQ38ToQd51tXoCGXh0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391951;
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
	bh=08z53+8yrbTGjIZvszG1gqicLmRIcvV8HxhxbsaCpO4=;
	b=FBzGi4WhriOZGYAiWWHmwgjOL/BT2qSDUkqPemNfn7ruzzWredoMtXAu2KVUr/+WmLFI
	 mNt78VN8njQ6jeKRcRHmPUk072jCcmhBIRwwLozAPSfPWfzrZNI9zZtbtyfl6dMvgWtd6
	 ojMLIb6CZtdY7SZW3Thm53ZRy1dk+HKzDjPPonEvbKflkNjK+d+TVC1kirdRKgyOY/u39
	 ZFc3I9NukkxImyzoUuB+2AcQIFomZ215yMELHPCdBeu1TcTPZe6y99MMkXvdQAhvSBMFz
	 frupTTAf2nEsvZt8WRIHCkMnaY7xvSSSUS3EVXQS+tsCT0oErJZCa/uNvtjd2O/bIpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y0QEcFsH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.28
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AA5606A331;
	Wed, 11 Nov 2026 10:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2AA5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y0QEcFsH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPbFIHRH3lFeMc8AID215+IsSpDmc2OYpu0/rYe9dSM9QX6OWnjGKjQh+zTPZt6Txea1ypba6uloh1qxa1OB7ZCDsykFxD9WSHB2uL0LuV4mGVwZUCPqvmvwKW74kYhq+X7+RCL+6s9nBYIAqizifURNKp3JeDVUtsyXEqcrsLgXWh/O2Amzz7wHQ8uIzuWOhhq2bftCRs7Dgy7shzrVliW+dF+Nl9QOBgk92147dRDscLsqtltxLQOimGuzoOBP14hSGUJGL3HboAEVTVvznqndmGq2ZBVj0BKeD0hXeEgUGydxiFeutQA68uaUJJgRyBuds7YnXST14qa4f65Gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08z53+8yrbTGjIZvszG1gqicLmRIcvV8HxhxbsaCpO4=;
 b=FzdBRtqhYuKmsRBZh1HV4alY9Fv51HJJlD6gwe4KvkBQdJtpJI32IhEmdQPvvU1O8q7rEKr7LjNhoiCDoAdIxN6iNX9oKh6K1uV7kLHDUQovMWf1LMP2DJ9pcd32xfDTuDfgTSUY0jfERtphbN9qvZhS7id+wsCoxoaburDtbnFWGOrQPJUcHy6E/0FEf4HN6lauQ61I6Ht+qEQhpfIiPcDZEnLEFwheiB8p2BQECEzQDWtspBeMJsvXbWdoso+zu59PROQVvVEJESk7NOU05uUQioqlgHacaVA+3OPfAK+LOuf0Dv8oqTRJf4IrVP1HctT2SqGgi6VnxE2bKb4fBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08z53+8yrbTGjIZvszG1gqicLmRIcvV8HxhxbsaCpO4=;
 b=y0QEcFsHsQUSx7pIM+k0V12d97+pyVWFJXgoRVs4LYL8MB+yk1nouk7D8zCQd+C4FG4JuXwl1JMYlToROagiGzeysHxL/HfOWUS8Q3MrQQXhHw5pf64/yJnbWyjZulFXRdGx057+xF9G0wuL2UmFqDIG9fYCut0qst4raB605Kc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.9; Wed, 11 Nov 2026 10:12:17 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 10:12:16 +0000
Message-ID: <f5fdc266-aed3-47e6-a10f-e8188b58c93f@amd.com>
Date: Wed, 11 Nov 2026 10:12:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 12/19] PCI/CXL: Add CXL Device Reset sequencing
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>, Joshua Machauer <machaujo@amazon.de>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-13-smadhavan@nvidia.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <20261105185917.2667656-13-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0152.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::14) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ace5aa4-1611-4092-5ba2-08df3fdc433b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|921020|10067099003|11063799006|4143699003|56012099006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	S5IMQ8KA2T47W+snnmc7bkoCIV5xVxXgKqurFgXsbjDsiFKKzpSn1RjBwcriHw6gdYmbW2exF9q86ccw2WeMQtWuF560zO1qVA/640gwiJN4cIFlPxf64oDwpVFcsqHjpeRz6X8WoSKoNQbrEZjuTbMpI4E+cZ87mjqyuagOpfVdsf7AeKSbuIgYVrgd3A3F+BDHExTgqXpSNCaaaMvZboLhmj9bTFNL4DLayTyi6Jw0g0AHFY7Rhek5vPtI9RGb3VcEi54XSsROiVIzgIt+aKhEu1SZ84TnYgfzXmRuHvp6Y4X+J3pfMEcMKsgzgCfSEEM94Ylpjyd9PuvuyFAmI5S1ILNrBtiwpqz0CsNVO0zdDG4VGm/Zz0AzjJBk53tLSkrJ1Mdws4Yin0fUhHH2wGXJmo4EojH6rCx4ePBnJqoqfYl6cIhSZICg1H3T5H1j/j2uL8AmsfyBz3JuukGbn/3HK9/rlYvY5jYjushVpjVJq3aj+hYnqgWTkQwDriwYBl5R7supXofmz67moXNakbWwxRV/bueYS4+1cGr7gYhN+JHEGkZuv573+F8fmxN7vaDbzn5KW02SR1Sq5Eyp0Jta67tjVqEvTGwk8BMvdjI9cp3RLYIbrHaCgxwBldHvMedinX8qE0wGEQEhdP52TW8Hr7y69sRPKbeAwE176X34nCevLuCS77WFos6iNoefBJUyLSJCYtpFOrN+ChB3JA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(921020)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cThWNDlETXIxUG5nRGVHemt1U1dPQm50c3BwVGhFTFRuUENHR2hKcjhFYk8z?=
 =?utf-8?B?VkpGV3ZvbDVaRmlZYitlSUlPRXhnb2xRd1ZvZHJvZnpJb0dRdm9ScVB3VDdz?=
 =?utf-8?B?U0tvWllMMXAxaCtKWGg2VzFLMjZrQ0tkdisydFFpY3RXWGtHanNjaDVvOWpn?=
 =?utf-8?B?Z2VSbTNTUjI0YTB3eFJUVVVJSlhUcGlPTExLZnZBT0VveUJMVTFGRTVibmNv?=
 =?utf-8?B?M082NDZYN2txV0V5Z3hONzVpb3BGMUJtOHMvMFBqclRDN20rSlR0SWtSUTdD?=
 =?utf-8?B?bXQ4SVFYeDdlMGFDWVZwMmFSNVBJWTkwLzdjQ20zazJMc2N4QmNwTW5hNkRR?=
 =?utf-8?B?WS9heFRNQkRqUy9jTzJzNFJGYW9PM0ttd1V2aitBcXdzQjRpY0lyUGFhS0Vy?=
 =?utf-8?B?N3RDcExmS1RlQ0xPT3h6TzA4VU9YbzNqS1p3UWs5aTNnLzR0UU1KYnljZkRh?=
 =?utf-8?B?SjdWMG9IOC9nb253TkFOOUZJR2lzZzUrZ0ZNSzRLWUpuTmg0YmNYdFZzdG9P?=
 =?utf-8?B?ZWc2QkoxWHVZV0V1cFBPanVrcU9ncGtRNHdGRDRzZW43QmY5ODlGb3JKbU9X?=
 =?utf-8?B?bTVoek5ib3ZIMzA3a0dydUNxay90SFdSSmZtMzByREtuZUlNVFlaVFJaWVNp?=
 =?utf-8?B?Ri9ySjE0S2VUU2ZIM1RST0E3K0preStsenc3WmVDYXl1ZVh2Y0FrTVRKaFlu?=
 =?utf-8?B?REJXZVhzSm93bHdsMmo3WUF1MkdGWWpoWFNwbkNWSlJFUG1EVVBUY2s3Wmcy?=
 =?utf-8?B?TXFKRGVsWEFCV2hUdEE3dWNxUC9DbkJqZFhjTDA0SU44cGNiNlY4azRCeHpW?=
 =?utf-8?B?RjhuL2FtZXQxUlNuZ3BWWjhPZGhZVTFrQjlpVitQTGxxZ2dsNFN2cHBBa3JP?=
 =?utf-8?B?VUJGOWE2Y0ZKMTRpWXJoVllxcGIwTDNaczFwUjd6d003RlhQU0hvakpjUHdS?=
 =?utf-8?B?NVEwUzUzTDk1U0FBUzRaRTdnQncxZzVYSUNpbjdoR3I3MUlzeUMrU3RuRTVn?=
 =?utf-8?B?Q2tvOEJFZUhNa09TZVhMLzl4dm9URmhKV2lOL201RFZPakRJbHRFYmxWaVha?=
 =?utf-8?B?aWN1bHA2VVg1SEpLbUF2eWFtbGxkc1pIZENIQkRDRTRGZFFlaGFUU2oyL2tQ?=
 =?utf-8?B?bGVLUGZ0ejd3TW95NGdCclNlcEozZUt1aWd0ZWc2RC90VE1xYzViemJ6cWJy?=
 =?utf-8?B?TjRWTmlNUnZvRUZYNnQ1RCt4dGRxUjA3WkZvdUtCNzBLUXh0bUJWNTlIQ2dk?=
 =?utf-8?B?ekhBTTRIRnkwUnN0OVR2RnVRcEhIUHE3NWZtSFNOUzVqSFFqc2FiRjgwU25s?=
 =?utf-8?B?NG9xWWdmeTFDd3RiRVZyTjVlZUpJTytUNHFaNG12K09sb3BKT25qbzhoODhI?=
 =?utf-8?B?SHZ4NnE0R3JIcTNqck1qR08xV3phZ0F3c0dLMjQrSVhvSU53SjAxU0FaZkhE?=
 =?utf-8?B?VGNaenI4WDMvcnZHVUF4TkJFamlIeFB2eG1Ea2lRY3doYU55YXg4YzEzZkx4?=
 =?utf-8?B?MkFNWmNvOXhtV2RRck83cHpGUzJGQ1U4aWcrV0dJYVc4NGlGcXpVckY4dW1N?=
 =?utf-8?B?Tnd1OXJpMVlhR2o4ZW5pWFBkbnNwVzJyNGZvUnpIcks4ZExibG16ZzhJYWZr?=
 =?utf-8?B?TWtidG1PbkxHdG4wR1ZUMDJEb3kyMSsxeEJGcEdTQldHNTc1ckN4SExNb3Qy?=
 =?utf-8?B?TE1paExyYWlNa1htOGYwVlJWWVBZNlh6dkRqZzVNQnE4djhHOWl3bDlDRFpl?=
 =?utf-8?B?SThLNWxmbk0yTjNhNjM2YnViZjB3b0dCTGVMb2JYZElvVmNnT0d6TjdTQ25U?=
 =?utf-8?B?MDFJRTN1MGpjTkcxbGR6dElFOVJKQkplUG9xL0VyamVvRTZuc1lwS0hNS3A2?=
 =?utf-8?B?M1VKYlRMUVpsRExSRUtBS2FtSVh1VjN4RXB0bnZPbzVsMU9BSjd3SEhmZ0dP?=
 =?utf-8?B?YzFSUUh2SU0ycHNVcWxNRjVQaTRaWmRWZFdTSmRRSUxad1lpN0RuYjhERGZr?=
 =?utf-8?B?M0JTb3NlaVhMUjFZVkdwdVlBVHAxUC9leTZBWEdobWtzVU4vVHk0MHozT0FJ?=
 =?utf-8?B?SDhuWXNNUk93MnRTbmVhUkpXUmY3SFBxTnFSbGY4ODFmTUlJdUtpblF6NHhZ?=
 =?utf-8?B?dURET1JkTHBLMTM1SXdQaXYvTHdtQjd0Y294OXpiL2ZpUk8rbjYxYzJGWkhl?=
 =?utf-8?B?aEI4WEZCSjRJL01kM1BIYVZUaG10V1U5d2hxQkMrZWFUQlZldzBlMXV2Sy9R?=
 =?utf-8?B?ZmxmOGhKa1kyU0o1K2tsRDhUcVZicGY5aXhIaUdRbFBmYS9QVUIxelN2V0pj?=
 =?utf-8?Q?MC30GxROBQXDJ5Gzav?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ace5aa4-1611-4092-5ba2-08df3fdc433b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:12:16.5360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSgj3F5hocGyy4C0tmQDRITyq6RKN0K9MrtOH4wes/TJQwo++VWRtubzaevTnuHyWeycWO6o8h63ShT+EjoCfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595

On 05/11/2026 18:59, Srirangan Madhavan wrote:
> Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
> perform supported writeback, drain transactions, prepare the IOMMU,
> initiate reset with Memory Clear enabled, and wait for completion.
>
> Observe the 100 ms post-reset quiet period before polling Status2, and
> treat an all-ones read as not ready. Wait for the timeout the device
> advertises, up to 100 seconds, and access only Status2 until reset
> completion, error or expiry, as CXL 4.0 section 9.7.3 requires. Control2
> cleanup runs only afterwards. Treat Control2 command bits as
> transient state, restore cache policy on exit, preserve the primary error,
> and abort when IOMMU preparation fails.
>
> Reuse Device DVSEC discovery from cache initialization and keep the
> reset entry point declaration private to PCI core.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>


Hi Srirangan,


A concern regarding IOMMU handling below. If it turns to be unfounded, 
you can add my review tag.


Thank you,

Alejandro


<snip>

> +static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int rc, rc2;
> +
> +	if (!pci_wait_for_pending_transaction(pdev)) {
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	rc = pci_dev_reset_iommu_prepare(pdev);


I'm not sure if this is safe enough. I can see a situation where a Type2 
device could not be using CXL.mem and CXL.cache but CXL.io. This would 
imply no CXL initialization from the Type2 driver but:


     1) Such a driver could be giving functionality without CXL

     2) The device belonging to an IOMMU domain which such functionality 
is using

     3) The HDM decoder range as a system resource is free.


If I am right, a CXL reset could happen, and although it should not be 
triggered by user space under these circumstances, the door is open ...


The solution would be, currently, to check for a  driver not bound to 
the device in an IOMMU enabled system. I say currently because CXL.cache 
will need extra work with IOMMU mapping which are not yet there.



