Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD23321AA;
	Mon,  1 Jun 2026 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306108; cv=fail; b=UGbHKNYtI+5A3klLHqz8r7MGPzXoCPXAhm9atYOPCLJ23UDZ31Bcig4SgO6cF9fCxpotYRJ0mDPVmwHzRRSfKw0AkRsf6d/YUBPJd3Z9sJRnX54FUd5xwbNDrJG9F2HxUE7HQRhxjKKLowRa6J4ysvvJeb0tlagxZsZ8Tbz0TKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306108; c=relaxed/simple;
	bh=oLy24OGi1fYtIxIlq4QEnsB5z+fsqgNGpuAiRJWGa9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ad9umemidlJV6/AXESzpSP+Aa+TTch4IIcRKOWaJfTvH7zcBgke+E27EFm/p+jsHBrVXUkAVHhaBdSRX89Qy65mdECXDu+jsauf3+OpxOYUuQbhKEmo7v10xOMd68nUUxC+cS4VS+amC66kLPyVUFx39/neAMdN8B2caXf++D4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NIuIjXjL; arc=fail smtp.client-ip=52.101.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NIuIjXjL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kg9uQ88OVJ+1aU5ANeOsMdFLjIvt5I/iQT1BKb1Fms5ic2RL8ALMq++K2lr40ha6AOBsP7E9QHOPOBzNllpiXupYA33ENxDRTVsJyWCJCrWZXEgEddNAu3RcQnbeypfmr/8Evtlam/spphVlbZ8SOcX8U9ELCs54eading72wcABSqc5fhJ+tH3RV0gG6Fl0zX7HrYGZh/V5eT3mE9XelwEclQjt2zsZgsrszlOIXj6lMiI9U54fFJcDkj1ZiMVMe/VV5QG8PX5fUKl7zMKHCIOMbIMCWc0k/ewZtqNuFWYNveQ4vq5EjJd0Qcw4oQpfwVHwIpyjk+KnIrsWy0EEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5iLfSOXdTwYwTH3oUqnfKyenANT6QfUdPIYo8KX0n8=;
 b=OuwlIHTuqeLkXHRQ+/Ap6rtzFmnqg88vMTSt6CGBmhKHgUuBvsyhyPCPDwydjMu4Gje/UF/TxyxsUROnCEugKR3YpG0ycq5Cqh9mWAMyXlD6Eenme518O1AnWl1LWSVRYJjHwDExOZxxozXGQDv/YUr1YOCVDZtxZak+X/iM6/AtGXycyRMJIciqx6K8CAs4oWITMaeEC8rAmzMYQZeXpE/1ha+T9N0nL74qMRMN8OwvauGVg1gudWC9XC7wUV2UAEJHUDjS/N30a61dVlb6G1fh+YGvJSaTDekb8rSyLsJBcbpL4XCrxkabLMO+xqANp2E5g6gi7K6nhLZM+F3mEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5iLfSOXdTwYwTH3oUqnfKyenANT6QfUdPIYo8KX0n8=;
 b=NIuIjXjLMfHVkT0lxXJ/Lveahg1Y4u/6fw06mcE7XCg5suDjqbPI3sCeC5hlbv7R8EYYs58qY5DYg45cBMbp05R+W30jNyOZvwDkWC6fmwjgu9c5peH48g8QffhCrrPuqiMHZRPsHM4osUcOqaBw+wfV392jU4Rq+BSdeHHa2XQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7SPRMB0112.namprd12.prod.outlook.com (2603:10b6:510:27b::15)
 by SA1PR12MB7175.namprd12.prod.outlook.com (2603:10b6:806:2b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 09:28:22 +0000
Received: from PH7SPRMB0112.namprd12.prod.outlook.com
 ([fe80::f703:24e0:b20d:6333]) by PH7SPRMB0112.namprd12.prod.outlook.com
 ([fe80::f703:24e0:b20d:6333%5]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 09:28:21 +0000
Message-ID: <6086ebd5-4538-4b85-bbd3-84df9c6198d2@amd.com>
Date: Mon, 1 Jun 2026 14:58:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] iommu/amd: Fail probe on ATS configuration failure
To: Pranjal Shrivastava <praan@google.com>, Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 David Matlack <dmatlack@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Mostafa Saleh <smostafa@google.com>
References: <20260529111208.387412-1-praan@google.com>
 <20260529111208.387412-7-praan@google.com>
 <unqzyef2n26wdf6tmc6vvwvpsgv244uvz7cxji4scymqmoofyb@trkzr7ix5bog>
 <ah0kyi5asHpnrpgC@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ah0kyi5asHpnrpgC@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0073.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::9) To PH7SPRMB0112.namprd12.prod.outlook.com
 (2603:10b6:510:27b::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7SPRMB0112:EE_|SA1PR12MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f28fb05-f85f-4723-2ee4-08debfc01f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|6133799003|22082099003|18002099003|56012099006|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Xa72h98P9eN/EMYtyZkvjWWwmXPg2EmSVnJRLRU0jsi4dGV2ZsoV1cWY+Fc1zEa3epzc3beSr2y9N+5E6pB8cIFYgrb9KWeyI+6+E+04UFgY8TpvVUUtFqmirZNPqLqHDnLwBH1cMIvU1TQMItq0e98mP6PLng+Yz+JzwZqbj8xng9MFr1/1Gzjq3V4i+37o77qIlv38HfztXs1Q/GNKX07yxYI6WrCNphIbXJiz4g0YWzAp73stL1QpKN4hTPlMhLCqdVahw7S9lzZMGl6B8K2iaqms27jd3/UiNYAFKcoaJCs6ycgzqtZQtWhCSnQ3Y9hCJZBuduHmqyeznVWXfkIuxhWs2HPOqLn6lXSM2XOh4bsVFEBCwqPSzyyx+1tDCaSoH5o5Nc6cYb5Z3jnTd/q7LgJ/CU9y2A8IqdnhCgCz8rf4hiX6A4JjksIkEddkOPNNUujSP/IqKA81kmWFPnj/YMS7OhM4hFFcN/lI/pg69EJJsuBNFd2SJamyaqx3qsYKRoOHW0LtB/iO3FdrVYxx5dwGphshaIqK5i4Eoj7fzQMecx12XYLndfEzMzotYm5x0nhzq0x7tfppbMKG/2uWazIsuzZLJT6nDz9Za94EZiEeDSmT3fEzXnqSBjA8i5XzaKn+SNjPg2SttfvrDKqnj88n6hM6LLnmk7ZFUFNk52+J84/SJ949bBKOfNyH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0112.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REFsb1lCeWhsbEFjRU1uR2V4dFViMC83TnJ4ckZuYWNma3E4RWlLWnBlTkgz?=
 =?utf-8?B?Z1FvR1ZkNTAwSnBtUjh6NkZnZkpOZVE1R1V6a0tVV3JhTUx5RE1YdWdNelEx?=
 =?utf-8?B?Vm5FQkVyYkk2SExVY1lka0pFb3MzTHB5VWZuZmlVaUNlU1E3ZEVpaDhjdUxE?=
 =?utf-8?B?Q3Y2N3psb3ZRbmdjTklVQzA4QkFkZEppK3JlZngwMkVvS0I5TGtFcDZINFNN?=
 =?utf-8?B?QXlNdWhlVmRQWUtjdnZDVmhSempNMWc1NnNqQ25pY3NkSG81SXJpTC95amN3?=
 =?utf-8?B?eWx2VEJvLzVGWExkUS95WWd6QzlNYlV0eFJwZWNMWUMwK2FaNkZWNE5LMmpr?=
 =?utf-8?B?YXYxQ1BHSmRVbGdyWURFUU90ODNQN0RCcnpqRmJqZUxIcE9VSlc5TEphQmxH?=
 =?utf-8?B?VS9HWlk0UjJNRlVLNUNEZzdRREduMjRZWHkyd0VoVlVvRklNSzMyMWt6VkE4?=
 =?utf-8?B?cy9kODloakUxV3VvRzhLb0pyNkp3UHhIa2JJV3UrNTBnT2RLVjIzdVJobE9r?=
 =?utf-8?B?ampMbzNqdGNkRi9xWjVudjQ0djdCYUlYOFpsTjFZNUVLWkpoUko0T0pwMGpC?=
 =?utf-8?B?MFZDYjhiSkZkK1g0VWJZRlIyNjZPb1FPK1ZNb0svT2pIWUhUd1VzQ1BoMCtu?=
 =?utf-8?B?YmVVMG13R2ltcVJ5RTl4Zk5UVHlZL2JyZnBVaEpybTdYc3NSQWpjaGlHc3cx?=
 =?utf-8?B?T2RIS2NiNyswcnZEcWNFQVFDN0ZpcVZ2dWFoek13TUE5ZG1VNDFvT0JHYnJn?=
 =?utf-8?B?bTJrYXhRSjhzWkNZellGaWhxcEJxWXNRRXV5a1VmUlRxbFU3VkNvU3RpZGdI?=
 =?utf-8?B?QXpBU3hWZm10c0dWQlZaYkxVTmdybmRycDc0Ym03RjR5VzM0S2RmMmJrMDN0?=
 =?utf-8?B?Y0piU2JKT1RsR3ZKQUdPUENLOWFBVEN0c0IrZ2d3cnVEK2JFVEdnM2hUeVZh?=
 =?utf-8?B?SmNneUp5YU9HZGNhZ2tONGpkTDFaZXExR1F6KytFdXVGRGw1R2ZTY2VjbEhH?=
 =?utf-8?B?a0R4ZkR0b1F0L1lxSGM5Vm5DNWpSL1YvZi9zcVZtUXVaOCs0V3BFTHVzSDdx?=
 =?utf-8?B?dHMwMUQyNEtHeGEzVE9haVdUSENkTkxXWnpMdUhmMVVBVGUxTlI3NlFmZFFo?=
 =?utf-8?B?NEF4cUZSM3crU2kyVDUwYnM3TUJsSWVrcFgvSDRzVStaM0xaMDhYRjhrc0ZO?=
 =?utf-8?B?Z040QSs1K2xyS2R6MnRoVUVXOFdCRzFQM3dtTDBlVElTVUtiaWFDbnA1WmhT?=
 =?utf-8?B?d0EyVDRkT1VMenUvakN4TzhBU2pGMkMyRzVSbHV2NW10VUJJd0xndW1tRXpa?=
 =?utf-8?B?T0RYZ0k0d3hwODJXRXVCRENkUytleTJ6cFBQV3VtUnp0MXV5VHgxWGo4K2pp?=
 =?utf-8?B?V3lYc2kxbnJFZFV6UXBXUGhSbmpHeUhUMWtHSWxrQzdmWWlHQ0NrNklZUTJr?=
 =?utf-8?B?WStIYTFtaEZFSm84eGYxVGNCYXREL013alJkVjZEbmNNVVdrendvMEZxUVlT?=
 =?utf-8?B?UXJMNXk0NmRzRUxON2N3b2NuUkJDQzVjMllIOWo3TERNU2JIREhuN3JVQjFk?=
 =?utf-8?B?UUozbGx2UldMSXNRZnpmZVQwcFZ6bHZ2OXI3bEMrZ3hwRnZUTHpWSHhGTXNn?=
 =?utf-8?B?bmNEUFhvZjhhZU1lak1hVkxQWkNnbTFtWlBLNzY5M05nazNJMlRpSnVOeTdv?=
 =?utf-8?B?QUh5MDMwWStkUUpPSmdQdGo3d0JEVlFNOXhJdW83S0lURy9YMTBJbVo4eUhh?=
 =?utf-8?B?Y2FyQzdYQkNuZWh6Q3crc0QzMUpTYm54OEcybEk3M01tS1lnSklhYk1neTFD?=
 =?utf-8?B?eEluVWlyQ3VTUlFqWUNhemcrZXJlVGNGai9Ub2xTZHAyc2J5enIwU0ZSWG1q?=
 =?utf-8?B?cHVuUXJlbEpicmFsbFhXeW1ubnRvblltUUZCRlNYdk1hWC90cFhLS2JLbUZx?=
 =?utf-8?B?WEFpZ1VKNSs1cjYvakdHckxPcXFJNE5qaUV1MkhQNmo5TjJyL0d0dEY4V05O?=
 =?utf-8?B?U3A3eHhGU3pPMlRQOWppT3o0OFc5SDc1QWpIUGNudzdyQ0V3YjhHYTF0S0VO?=
 =?utf-8?B?Wm96ekFvSlgzaFIwN2VqcTdKNlZQNEZNNlpDWHl2aGVoV1JoeGhKTXBEMTlx?=
 =?utf-8?B?UmtONWI5b2ptYkF5eFBGclJ6dldmalhPNW1TMCtXaUx3ZFNScktoN1lXL1lp?=
 =?utf-8?B?YUxTNHdOb0toZndMN1hnZUZjU2o5WUlLQjlKN3FoenJrQmY1RkxRUzZuMnF6?=
 =?utf-8?B?MUpzbkRac2hDVFJvajNtekpETGNEa1NlOHIzd0s2Mk9Kdm85d3pnOWpCT1JT?=
 =?utf-8?B?OGIySm5GYjh0MndNUXNBejRNblF4UHBDdm1BVXN6V1BDN3pqN2pzUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f28fb05-f85f-4723-2ee4-08debfc01f88
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 09:28:21.8045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJHc7T/+xfxy98TuNpS3b1Hk0QgDWNrZVYQmDepx9Q9myTKA89TiLq7fDSJ+gQuf9BR1wdlHhmaCh+QF1Ef2gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7175

Hi Pranjal,

On 6/1/2026 11:50 AM, Pranjal Shrivastava wrote:
> On Mon, Jun 01, 2026 at 06:00:15AM +0000, Ankit Soni wrote:
>>> @@ -2502,10 +2508,22 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>>>  	else
>>>  		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
>>>  
>>> -	if (dev_is_pci(dev))
>>> -		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
>>> +	if (dev_is_pci(dev)) {
>>> +		struct pci_dev *pdev = to_pci_dev(dev);
>>> +
>>> +		if (pci_ats_supported(pdev)) {
>>> +			ret = pci_prepare_ats(pdev, PAGE_SHIFT);
>>> +			if (ret) {
>>> +				iommu_dev = ERR_PTR(ret);
>>> +				goto out_err;
>>> +			}
>>> +		}
>>> +	}
>>>  
>>>  out_err:
>>> +	if (IS_ERR(iommu_dev))
>>> +		iommu_ignore_device(iommu, dev);
>>> +
>>>  	return iommu_dev;
>>>  }
>>>  
>>
>> Hi,
>> This regresses IRQ remapping in the PD_MODE_NONE branch. By design
>> rlookup_table[devid] must stay valid for IR - init.c:2257 documents
>> this: "Do not return an error to enable IRQ remapping ...". Pre-patch
>> the PD_MODE_NONE branch returned ERR_PTR(-ENODEV) without nulling
>> rlookup, precisely so irq_remapping_alloc() / __rlookup_amd_iommu()
>> keep working; this unconditional cleanup violates that.
>> The new pci_prepare_ats() failure path has the same shape:
>> amd_iommu_set_pci_msi_domain() ran earlier and parented dev->msi_domain
>> on iommu->ir_domain, but on this new out_err that's not unwound. So
>> nulling rlookup_table[devid] makes irq_remapping_alloc() return -EINVAL
>> on the first MSI alloc for the device. Sashiko also flagged this in [1];
>>
>> Also if iommu_init_device() branch fails, iommu_ignore_device() will be
>> called twice.
>>
> 
> Hi Ankit,
> 
> Ack. Sashiko made me realize that this regresses IRQ mapping for AMD,
> and I agree that the call to iommu_ignore_device() is a bit too 
> aggressive as it  wipes the rlookup_table entry required for IRQ 
> remapping, particularly in PD_MODE_NONE.
> 
> I was thinkig to address this in the next version as follows:
> 
> 1. Split the probe error paths:
>    - Proper init failures (like iommu_init_device) will continue to call
>      iommu_ignore_device(). I will fix the double invocation here.
> 
>    - Config failures (like ATS mismatch or PD_MODE_NONE) will return an
>      an error but skip caling  iommu_ignore_device(), preserving the
>      rlookup_table entry for IRQ remapping.

I was reviewing v5 last Friday and decided to fix probe() code as its been long
time I wanted to cleanup this code.  I have a patch series which pretty much
does this.

I haven't fixed iommu_ignore_device() code, but should be simple to fix it.
we can use amd_iommu_make_clear_dte / amd_iommu_update_dte. It will set the
dte.tv=0 and essentially blocks all DMAs.

If you already have the patches then please go ahead, else I can post the series
this week.


> 
> 2. Resolve the Use-After-Free (UAF):
>    To prevent the UAF on the "DMA-only" failure path, I will ensure that
>    the hardware Device Table Entry (DTE) is set to a safe state (like
>    blocked or bypass) and the dev_data->dev pointer is cleared, as the
>    IOMMU core does not invoke release_device() after a probe failure.
> 
> 3. Fix iommu_ignore_device() infrastructure:
>    I will address the pre-existing bugs identified by Sashiko:
>    - Fix clearing order (calling setup_aliases before clearing the
>      rlookup_table).
>    - Replace the non-atomic memset() on the hardware dev_table with an
>      atomic DTE update.
> 
> That said, I'm investigating the safest way to revert the MSI domain
> assignment on probe failure to avoid the dangling domain issue pointed
> out by Sashiko. Maybe we can add an amd_iommu_restore_msi_domain() helper
> to revert the assignment made in amd_iommu_set_pci_msi_domain() on probe
> failure?
> 
> Please, let me know if that sounds okay?
> 
> Also, I'm wondering if I should send this as a separate series specific 
> to AMD which is unrelated to this one? Or maybe handle AMD IOMMU in a
> separate series altogether. Let me know if you (and Vasanth / Suravee) 
> would prefer that?

Lets separate out AMD fixes part as its not related to this series.

If you want to keep this patch then just the "iommu_ignore_device" part that
should be OK -OR- if you want to drop entirely and pick it up with AMD specific
series that's also works for me.

-Vasant

