Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482087;
	b=kdChEefOSM6IZStXzQov2boMgx09CQa2W5kVzKWIbk0T7jpqi04G1RsdpW6JXjUZ27ks
	 3CoJFA3JslsA0BAT3jyA3J3lAjUgm4tQesMukRorei+QKgSgrpiunGDAoAnVHejo5hMgH
	 cQcspmcaxkclCvbWMskgLGPQQ+FOzewpbxt7Y9W+rf2b8fOStaQyVyNCyHj65NlFb1kKT
	 9L3teg5i98QfHmzkuqB/nSA2gNpE7PAuxWVow4zrj+Cpp0Hj+smiyNoxAQ9WE3FRpQqeb
	 KuOtXGjxebICd3qDV1ioh0UMPbw9Bl02r/F550e39Yho64yCdkQSChR6PmSCuohmuBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482087;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
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
	bh=fIN5eRiK/uQwMsbCgu3VuKnu+Rj+wC0ixDxfqMueLaI=;
	b=Ut1nYMiep4tdk2LAEHMj6J+w5SGOxFVf1Cn+H8TR12u6eH2n/wPyFO/A/+9PZrdb8bsg
	 4j3W4quY0aPE33QuNB5UaNGeu1en5fargFG+iKeJwdTAXsFIZeFzTxfwCzRsf1TvWmK/R
	 1+X9cuI3n6PvV2PUnHAfTE21oBJh66BXt0ElHya/QV5a0ul3gezxFBy+ys2oaXfRX4//I
	 vy41p9TQTctXh9xoHCLrnOQw6ghuXkt45qqbRgPLunTJ2IakjlhupHHlZX7NzNVO3aslg
	 GZnA5ApWDWyfhLtvN1ALCyxJQSqmb3Win6OZcMLQ+41m1heXiJf5Zy6TZvaPkL3TYug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xw7ekuAU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.68
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73546606A332;
	Thu, 12 Nov 2026 11:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73546606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xw7ekuAU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7hBqeM5M2aTNoF1b1EmQOGBR1Wpm29RXLiDeerDHXJeLL9AWBM8RjijyCP4LZ3JPsgAJST3Te5d8khcsHY7R2B7vDnxTlATAlBHGC2tMg81Olv+y+6V8f3FPZZXkcO7zFAwDZfF7RexKtFvlb4F3u0DMSY0R1ism7Xj+lKX2S2kjTJE5GaOZfQnzjIPBxa9B9meEzJ+iuFfnjzJzfwClEjGuFNE9jUtmBYgbh3cEWC2nEUZPbVsSv5cr+D+ZEBnuzslOTRyU42jqefvl1Ime4b3zrBnGw+DSnZ32p20g3PIUVweW8zwjNbpKUWXHkc/2U3zQOvmhZsVgXVVrTwhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIN5eRiK/uQwMsbCgu3VuKnu+Rj+wC0ixDxfqMueLaI=;
 b=wK95E+utOKqCoypCBFFTESLG4y0PyzBYXfSiT32mU6kX6zYVE5asok70SVaMVl0QfTdAdFhoVkQPFve6IZFIq1tz1x8HW2zFZrJmyJNFJNaUdsiN2m8NNN+0stuaFqVEAEVD0geyOcfXMJmBQxts+utGt8JeJeTd36guFjXg7Fs0HPIngxjodhSjcMV89SosALTO0Q3ikdqrXHW/TCOqctCq1cpOZX8PisVBabo7P3lZCYkobxdLZNlnJcZUZLayzPNzE+4KGYAzPZzlrCRSIaA4J0ayjhogA9j5t1kioRR9ULDCOMGaeOVQFhxaEJuiF4FZn9pqotP0Z9XgPuhj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIN5eRiK/uQwMsbCgu3VuKnu+Rj+wC0ixDxfqMueLaI=;
 b=xw7ekuAUeW34VH67m3gt5k6wz42XBeERV8arFwPNl21fqpO8FgUjcdQBFLHAExr4EMQ1WczLNgkxe1YwJTj4ywsMzaO0ya7duj2OTmPPeh0wkHS1Yyz+ZGsRIeZL5TxrLaZ3+pd9CNTvXiyYb023e2OT9i9F34VtoBBBRG/BF2I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by IA0PR12MB7601.namprd12.prod.outlook.com
 (2603:10b6:208:43b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 11:14:41 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%6]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 11:14:41 +0000
Message-ID: <9eb572d7-fa3a-4734-9773-44a3fb465b6a@amd.com>
Date: Thu, 12 Nov 2026 22:14:31 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/15] virt: coco: tsm: Remove the device from lookup
 before PCI teardown
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
 Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Samuel Ortiz <sameo@rivosinc.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Steven Price <steven.price@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-3-aneesh.kumar@kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20261104161632.3547423-3-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0057.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::7) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: e147d1bb-4c4a-4c76-ea3b-08df40ae25a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102130727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mNXGq2KMZc7as7THM31BnJhXTFmMqfYBkIu5CW+6XrWsgLuq8SGG41bp41nxHRamZoHHQCEkkksU0AWEIjxWld/SeDZEqHFMxTIdUqVrHLolTmGJEJSiHdnN+sTsguUiF4afPxKLqvQoLAquJ6lqMHI8A4XR2/EtEfuZjMZn3Oes9GUJZGj8dkmVHj1NRcU9UsV4/tpyqjCRgJIISnr4zVy4Tkrw5kuV67f2zlKVKPwZgMTqVG+Tu/iLAPY7noEONkfjNtc34OxuMUP7q2IxqKISIquAP3SzPQjmq+R9RruZgTqiqZE2p02kfSxq2ytmzwzhwAfe2jMTEjC1jnwijnjD6+4rWr0BLy9tyzlezz8gvYqEpAXZ3nqb8Bhone5o+fDateqUTtTupRQiQCr+/V/cSsy66QZRm1S6fOP4cI/3I+pGYlKFJ4NqTDxYbeus2h4Y5ASqE7ujlY+7/Gyt64jBSBgWVHnwjPS2gvFj0mbJvWwNOAZHdiTeXfMQiiLM93TUPD7slMoEVLN/vIFHLmUR67UB+pw9WAAEHrQ4M34ShE3EjOjJIsQEygvncHvU8AJu1fWXatdmhyufYKcdWSZXKjF8jEMrBz7VOTEpH/M40AuWXmcMCo/3+bgBbcSMaJS8vyZSo/LOyIGu8u6762mj7cKudmHgrGIwKil7Izo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFhrVUU1TE5YL0NtRWpnSXNKSkd6c3ZHR1VaUjR0ZGw0MzdNMkkySzY4d0Z5?=
 =?utf-8?B?Vy9NZkR0N2hDQldlM09DdVgrRUg0THZJYXcyUVhLL2dpSko1bHJLSkMzd3Q3?=
 =?utf-8?B?WDdPU21CODBKN3ZMdXB1S1BHQjBBZ3ljZGRTaXRmNGJkaHl2OW9wV3haS21D?=
 =?utf-8?B?Zm1VbTk4M1QrQWt2NlJLdmdGbU1wWnJMaUwyVEE5NUJuai9Dc1l5VVpvQWk0?=
 =?utf-8?B?RTRpRlZDUTkxcWt2cFdsV1Izelg1VnEwL3FKS3MvdlVMdXFRQi9lN0tvYWdD?=
 =?utf-8?B?Q3doZ3NIalg5WlBycm9aL0VnejZvdFZPMFdTc3dHWTNMWXlVT2dFczVlQlRh?=
 =?utf-8?B?d0F4a1JaZ3VYZzF0ejhoblF6S3RhYVpadnpiY05vRE5HcDJZaGxidXM3amcw?=
 =?utf-8?B?dHY2NDNza1dWRTBuTWEzaUxSdm9ETXViSU1YbWFjVjBtRjBtTkd5Nnc1OVJn?=
 =?utf-8?B?clpURHZyNUJaMkNlRzNkSWYwY01iNXZWaE1HdmJ3Y1F2L1BJT0xNMGU0ckU2?=
 =?utf-8?B?cDZoS1RuNC82MityTmpHcFRUWVpxN2xKRkVLM3VlRHYvYmpkWW1KYWtRMkhL?=
 =?utf-8?B?ZkF0V01LTjRTL2pyOFhwK21kQXVUVFZ2UVZONHppUStwYm5Ic092Vk5sZHA5?=
 =?utf-8?B?S2F3UTAxcS9sTWVJbEZPcEk1azAyakhuT3JpcGdkWUg1T0RFYnAreksxZHpw?=
 =?utf-8?B?cVRHNS9FTVRkVzV1d0pCZHVidzlZMlZTT3RVa0ZjblB3UHAvQXBuQi8yRitN?=
 =?utf-8?B?SnVNVWcxTnlueVdzN3VjbU1HYlN6VHBkdEZXWW1zUyt6KzZCeXp6SFBNeWVz?=
 =?utf-8?B?T0FHMkJnRW1EVnlxSGtNdGtEeSt3cEUwV0d3UFdFcDZEU1k3QWowT1pLVE5S?=
 =?utf-8?B?SG9odzc2ejNrTWxkOVZJcGFFUitWTitZUHhSUExlT2J3Z09zVGVlcTR6Rnp4?=
 =?utf-8?B?NFVKYUMzclZhNWxtRGNudlFiNUdDUWkwdDczcjlsZU1sUlRYMWY3TjZMd1V5?=
 =?utf-8?B?R1dlTFE3VlB4N1FSdDVkeWNHbkJVaGxzUHZJNXA1RFRFOHMyOXhCclA2SHhI?=
 =?utf-8?B?cmdLUDlTU1h2c2RIR1R4eklNWDhmM3l5TndVYWw4RjFhSDJ4UjVuT3U1T0VP?=
 =?utf-8?B?bDBjei9HbGxla1BSeHZKNWNLNTZBWE1McXpOUC9PQWpuTmhXd3FxbStuMVNy?=
 =?utf-8?B?OXVzUC82dVFwOU9ERUJOcnVVZ0pLdDQrdlVseEZmaThPZExNcnM2OWV1QUZT?=
 =?utf-8?B?YW1LOWlWMHY4aEF2bE1rb3JZeVlzdzduaGt6alVZQi9NbjgwVmRkRzZ1ZGdk?=
 =?utf-8?B?UzdvZzhxQmNISUlqTzNvVU9DVFVZOXlBbEZRMHZmSlp6cWhaMTkvZzhtZDV1?=
 =?utf-8?B?dkhhUURZQTF5VkRlOHR0SERxYVhEQnJRVkNVQUQ4L2lrcEZyeUZYcWJYdnZh?=
 =?utf-8?B?ZWJWMkJ5K3llSzZ5Y1hkVzNXdk1nQURheUdmc256MUYwb3R0WWd1aTVIbFVU?=
 =?utf-8?B?cldJZWlONGFEWStpMXZweXF5S3NzQmc4VWlhR2JuLzRFcmRWd1RxNWxqSGpZ?=
 =?utf-8?B?cURYMzJWcDlTdnRNclpCRVhQbWNnUVpqdHQ2ZzJ1YXFwOUp6cC84YmoxNm5C?=
 =?utf-8?B?ZTg5STdQWkloNmZKMWt2QzJjR3F5bHNVcW92MGtER1M3bUUwWks3djk2S2da?=
 =?utf-8?B?QUFuTFpnUU5hajhWUzR3TlJoNitTbUthbnRkNURIUElSdVF6K1FMK2Rod3Vl?=
 =?utf-8?B?cWhHRWtHRDNLWi9qak02RnJTYmk0bkkrSXNXMlZlKzFYRjBIQTRYUzVPaXJI?=
 =?utf-8?B?d2QzODY3dUFGODFaU21NaEpwcmk2ZEp2ZjNnTVRMTGZBcXR0MW1CUjZvOTFi?=
 =?utf-8?B?MysxdFNBdWNwd0o1ZFZkdllQbWRCTlBnOC9qbEpGMWdKZVhDdmk2enlkYTFP?=
 =?utf-8?B?MjNDZVdBUWYxMEg4Sy9PZnMveWtvQ1RDa2RVUlE3WG9Rd0lFbzVuMUIrUjBE?=
 =?utf-8?B?SGVhUnF2WEk5a2R1MHNqZThFaHdKKzZmQS9nWUtKeWZMUG53UGExNnJ2U3Yy?=
 =?utf-8?B?dmhITnZrWXlQbEJFZDROS2gzeW5WUDBFcytDb0lLQ0ZnZlllVGd5NndIMFNW?=
 =?utf-8?B?RGZFZWlMU3lYeGdaa0hMSWZQMk9SUEp0V3l2clBaYXlnMldDUzllUWl2eTJ4?=
 =?utf-8?B?SDZYcS84MVdqNTZocG1ibnRLbXYycXJSTXRPRFdIVUdnQ3c0dnhjRzJFUVdK?=
 =?utf-8?B?RGp5R3M2eXRCRTJlM1o2WWhkWkNUMWdHcGtmQndwekUyUlNTUlRDdTZycVVy?=
 =?utf-8?Q?svsp56JUtRJyDM2rDd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e147d1bb-4c4a-4c76-ea3b-08df40ae25a0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 11:14:41.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OE2d+KuUC+k+8peSIaknhR0dPi0NiDA8P/m3T07YF1289tJQKey3gaZPTogDJpUsIuXEd9kDGuxg+p7qG/blg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601

On 5/11/26 03:16, Aneesh Kumar K.V (Arm) wrote:
> PCI connect looks up a TSM by ID under pci_tsm_rwsem. Previously,
> tsm_unregister() released that lock after tearing down PCI state while
> the TSM was still in the class lookup. 

tsm_unregister() is not touching that lock, what do I miss?

> A racing connect could then
> attach a new PCI context that the teardown would never see.
> 
> Remove the device from the class lookup first, then take the PCI write
> lock to drain in-flight operations and destroy their contexts. Drop the
> device reference only after PCI teardown completes.
> 
> Fixes: 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link Encryption")
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   drivers/virt/coco/tsm-core.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index e784993353d8..f79135986102 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -56,26 +56,25 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
>   	return no_free_ptr(tsm_dev);
>   }
>   
> -static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
> -						 struct pci_tsm_ops *pci_ops)
> +static int tsm_register_pci(struct tsm_dev *tsm_dev, struct pci_tsm_ops *pci_ops)

Why changing a pointer to an int here as later tsm_register() converts it back to a pointer?

And I never understood what is _reset for here (so +1 for that) but now we have tsm_register_pci() and pci_tsm_register() which is weird. May be just open code it? Thanks,


>   {
>   	int rc;
>   
>   	if (!pci_ops)
> -		return tsm_dev;
> +		return 0;
>   
>   	tsm_dev->pci_ops = pci_ops;
>   	rc = pci_tsm_register(tsm_dev);
>   	if (rc) {
> +		tsm_dev->pci_ops = NULL;
>   		dev_err(tsm_dev->dev.parent,
>   			"PCI/TSM registration failure: %d\n", rc);
> -		device_unregister(&tsm_dev->dev);
> -		return ERR_PTR(rc);
> +		return rc;
>   	}
>   
>   	/* Notify TSM userspace that PCI/TSM operations are now possible */
>   	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
> -	return tsm_dev;
> +	return 0;
>   }
>   
>   struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
> @@ -96,15 +95,22 @@ struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
>   	if (rc)
>   		return ERR_PTR(rc);
>   
> -	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
> +	rc = tsm_register_pci(tsm_dev, pci_ops);
> +	if (rc) {
> +		device_del(dev);
> +		return ERR_PTR(rc);
> +	}
> +	return no_free_ptr(tsm_dev);
>   }
>   EXPORT_SYMBOL_GPL(tsm_register);
>   
>   void tsm_unregister(struct tsm_dev *tsm_dev)
>   {
> +	/* Remove the class lookup first. */
> +	device_del(&tsm_dev->dev);
>   	if (tsm_dev->pci_ops)
>   		pci_tsm_unregister(tsm_dev);
> -	device_unregister(&tsm_dev->dev);
> +	put_device(&tsm_dev->dev);
>   }
>   EXPORT_SYMBOL_GPL(tsm_unregister);
>   

-- 
Alexey

