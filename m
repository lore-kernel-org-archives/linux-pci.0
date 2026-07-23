Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C6D484254
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824195; cv=fail; b=qBjc9MWRB4uSi4wXa6Xdy51PWvHlw3H2hcn9XGb3vGSuT9LbxHrbciGZ25q2x1ZveJYtqiyAMY/+1PbbHMNNLvIhQeF0DOWDsKHtoQFRFo3F9fokuNeriMQyEAc1M+o2kxot5TcKtJpyDLbiFPoY38IqbcyBbDQ3iTjF8TChvy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824195; c=relaxed/simple;
	bh=24ipt92hTjH/JC4/b63R/a1OOH+bl+AuEtvUKhbn7aM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a6UH7GYOKKXVL31DvAkOudhpSS5sOlm3sN7Zjs617z57fSbPHxhtqc3Rp1P87yUpsn+sMiU6FCjIR8yT9Lfsv+x34pNK/esL34twp5KjeGX3cjiYRm7MiREsxHAe/nfgJ6A9DEZdHXvS24XdWBnmidX9CGwF4Q2Rgvq+pYwLHDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eY4QEUWp; arc=fail smtp.client-ip=52.101.193.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eY4QEUWp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUwWX+Tuo169fmb0acVb0sP29JdpzXBx/mNjVfhv/x1sTEruxxz4NPp03RcqmjHXscS7WMONJ7LDaM56MsF/sG9wMBMHxPNRIWEaplttSwEx9gyShmSn6tBQluB7uPJeCjI3Mq53FOfmRRb+xdm55RAOhojwOS4wJJhcuiIcZjNx71+z2G1uS0gofOteL/0wmFid2Tv35PjKBZRghxU33NhH0bcciN1H4oDpVvuJ7OI48w7RxXoB5wiSb8aahyW7qgPhLAaOdQtRqLIwG2GVOE/CDivf98UwVw5wdYaJMMwLLyIKPzRMaaSYCT5fCLjhRtOmWK7M7JziqUT/BC9jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAMTH0vpdX+oUEANBhPmj3sBrasJNtrlSljDQfF5EYI=;
 b=geP2sbJtR+STduAc+d/TOu5NmNli3lvu87vjQaOv9r2YAMjD1PY8fIl9DhfO306nCVhbXXmjXVE3eyYHbDylpc3mBRwtfKqdce/uUcGSYgpV66r+jzJQOIRl++Kja0eHCKXi3ChvtgY0vZgbnbjha9uPAeoYg8eETCG2KcemZgB6WObDkLPhi7wS97+9ufJ1IGPRCB+WwJ90zhJ5eghodGgol3Bw93EpxC8MrNROiUG55LNSHY76J6uPp+EQucnYp8TwBJKkjnnCjxS0Kl2Ha3Ftrpgb8YeEiQIyV06R8raSvkSACA3REJTh46978UG9aKVfbR4AJjQcwIqVlXjUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAMTH0vpdX+oUEANBhPmj3sBrasJNtrlSljDQfF5EYI=;
 b=eY4QEUWpyFEUJwl+B2bA4xsr2UgVOTnWVXbIRVC57ADOH31ZQyaW6aNrQx9Dst9Ggy6Gmkpdf2C55B7sC8343L3AY6PvHVD/vGHZtjxZ/Wqfm/AtK7NjippnB2UfIsOH6tKLcIX4GaxbyYRl1Ivo4fiyzXkqBGLPLu2G8xnzV70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 16:29:38 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0223.013; Thu, 23 Jul 2026
 16:29:37 +0000
Message-ID: <80c85be2-e8bb-470e-ae7f-79e41ffe5164@amd.com>
Date: Thu, 23 Jul 2026 21:59:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-pci@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 bhelgaas@google.com, alexander.deucher@amd.com, mario.limonciello@amd.com,
 jgg@ziepe.ca, Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com>
 <e6uoop5wg2ajfn26ot4re3cjz4iz5lhgmoq5epigf6nyerp5br@avxnfnuhh2hn>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <e6uoop5wg2ajfn26ot4re3cjz4iz5lhgmoq5epigf6nyerp5br@avxnfnuhh2hn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::10) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 162253f5-a7f4-46ef-a9b5-08dee8d79620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|20046099003|56012099006|11063799006|4143699003|5023799004|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NnaZhMdvEOOw51b6ILey0MvDYoTNtGLu5bgqcjKwrFOpt/wpXDduJtCxeHCsHLGya7ipbX3vAlAY2jETVhE6LBsXU1l0xKVbncUAR9uzULW47rM8S7XbmhOmiBuOQ37RjlPyiWdL9pj5EfA7LpH12MlZ95KDgF+YYXyI4/et1/T1QX3zMwrOWkWc4xQfJAyVWSKdYdlQWxkgtxdOELuM+oAljKzSbuA64AAwfpissEfP+vJdBFe3jzFDq4T8+hWHHyPma7Y5VV8RVhgX95tNLXE25UOjVt97SxcnkV5enPMAtugqBn9vqA7t+MmcGiXjs8Wh8Kio/UdM38pZ1GC6JyKZi9/0YCwAB7q13w3bHOyTOlEDafpgQg/0hXfxgLpGTvF52rFzpa/kfTWmfFHa43rWY0u8we13Hu64FzuuJIz9NWYcbdBah1X45M4DsQzq0EyERSW/2FwYX2f/hgcDjIuWEKUhEor4eu6FeWmzIfWBVEotswgmaGKCf+MtLFupN43hu/6t9NGjfC9fOBwDAkHc2zhLn/Nl5YxHs0aCfQa6dJ4ckd2CcN1Wcpr2OS5jyZmX+fkkyx0L1atzKzALqLTJPblNXHzljrYn8aHdV7SD8Is7EnwsmBKoSZgzWuFQmAm0F8AHU6MF0qINP9KNSvRKesppXQ3QyzTnf6SK8Ro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(20046099003)(56012099006)(11063799006)(4143699003)(5023799004)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlp5REVxdnJ2NEUrRG43ZUkrVERVZ1ZWQzhUVWlQcFZJcTRiUDNsT0lkZTVp?=
 =?utf-8?B?QlVuZVBjQlIwVCt6M1NvbThub2JEV2xjYjdrRzBpVnlzUDJLNlE1SjdtdVps?=
 =?utf-8?B?N0NpMVhCRTNnQjEvOGRRam55aUZ5MExqNEgxQ1hDVXhQcEtBbW4zd0dzalVy?=
 =?utf-8?B?dUZMSXZkSjB2ZUl6cXJEUms0QS85eGdZdmZkMFNBUVkzell3RTUwdndlUC9j?=
 =?utf-8?B?YlNRWlpENUxTM1daUVlvWS9YSzc5cWJwbGZqdktXYW4ya1lZdFFjM0krYzY5?=
 =?utf-8?B?VVNFS1ArWUQ1c1B5RXJpVmE1UGRHZExOOTF1dkEvc3JjdlNNYXA2RFYzQ2tj?=
 =?utf-8?B?RlF0eDc0bGF0SFhLZHBnT2V6RUtWVEh0blZZRVV0MEcyTTFFZG5sdVB6NUhn?=
 =?utf-8?B?Qk5jNW5Gck1JUWdHNURwcjgxb0J5Yk9wWWZMZTFndXExSFlPNHphSm1ndEt5?=
 =?utf-8?B?VmN3WHk1K3FFQlZIRVhUaE1GSG40cTVZNGhxMitnUUhYWmdMN0JoZk9qbFNx?=
 =?utf-8?B?UlRoVlpObHFuNHpveFphallYN2xLUkNUTi9GSjlEWFd4RVJ2c1RpcHFITm5K?=
 =?utf-8?B?SXkzbDFnRzVaWTMyb05pcGxtZUlTaS9XZ0NncHo2MXhXd0E5YThnTzAwaGxP?=
 =?utf-8?B?T251b29hbmFZcmRoOWF2UTV2alppajdFWjE3NSsyZ1FpcmczbUZ6RmdNRlhS?=
 =?utf-8?B?UldHREF3OFFWSHpMK0NFeDZKQmJCc1BmdGVOclJPR1c4YmUzK0kyTGNBL3NB?=
 =?utf-8?B?dytTbFg3NnRHUml4a1E1T0k2eGtKNDVXYU1EQkE1bVREcGVWNXpEdmNFSzVm?=
 =?utf-8?B?SHlkcmlmelU4dHl6MXMxTU9kTHBIUllOckR3c1RUR0FNL2lDR0RxUHlVL1dj?=
 =?utf-8?B?Y0xMTTV0STZVQ2xEbHF6U2ZheG1CZjV1VmJIdUREdVVSNDR4K2t1Vk44UTNV?=
 =?utf-8?B?ZzZiSjBaN0NWMkY5RkVoa2I4RTVOSjZNem1Xc3RSYS90c1lkMWRPZUl2SjNm?=
 =?utf-8?B?MjR4V084QmNwSVdYcHpuREJwK0h2Q3dMeWtUbHlyR0xuNGcwSVBRbXlvYUd1?=
 =?utf-8?B?cVZiNjhMVlp1WStITUZCZjMwdUNTNjVZTk9STDFITENaTytyekVVaGs5Ry81?=
 =?utf-8?B?cjV1WlJMZmZoWGsyWmlVNXg1QmxXbXdhYlJ2YVB5clZTWFQxR1dBOGd2eGk4?=
 =?utf-8?B?SFRUcWxxR3dBTzJWbHBZZlB4RnVETnlNUzRDMXdRVGZ1WjVlU3VpdGtPWlYx?=
 =?utf-8?B?YksxMzFMWmoyN3h2UjJaWlVlem5BamRkb1AxVUVHek9Xd0lZUHRUbldIR3ZV?=
 =?utf-8?B?V3llL0ZFZklhNE5BcEc0TWpIMTVVLzFmN1gvNFJSdzVCaUIySzFQOVBPR0Q1?=
 =?utf-8?B?SnJWNmRacW5YQ2ZIRFk0SVplbzRhVTFLdUF3RUF4cUhGRlIrN1ZGRmJlVzVh?=
 =?utf-8?B?cis2R3FCNEJyZzFOQVNDclJDRWcvZlJVNWs0aWIvcUpYT3U1MHMrcU9sTTNj?=
 =?utf-8?B?aUQvL0JMa3RTNzFaMWRsbXJWNnFySnhZVUNESlY1NlU1ZTQxcUM5YU11cjYz?=
 =?utf-8?B?ZkdDVHU2SElLT3I4MzhwSDF4REs4TUJ0NmNaTlNvN29aMjNwTmFJazg2OW9B?=
 =?utf-8?B?MG51M3dBdlFRMlBEYnhFL0FwMXoweStRRnRNRURYN0ZNNlBWbldSK1oxc053?=
 =?utf-8?B?NGFsUXg4R3RkMkNSK0JNcWJGL2FXTTVRTSsxcXJXK2dkTHNtZmpRYWY3SUNI?=
 =?utf-8?B?MVlEVjh4Z3YxS3VuR0haYkQ4elozemNWdXVYaURISmpnZm1qNUszS1hSNlo2?=
 =?utf-8?B?V0QxT2hBZzE2ZUtoLy96TC94OW1FNldEM2dPOFBRSmI2aFVrSEhTb1RzcHhV?=
 =?utf-8?B?ZXhTd29GZW9Qa09ZeEdlZkl1cS8zeG8reEt4RUo5OEdpcDVOM1U2YWM5NWYy?=
 =?utf-8?B?dHZHRXRUc0VydmNFUzA2SENDTXg5enlhNnNMTXRXa0xRZHZycUtmZ2ZmcjRX?=
 =?utf-8?B?M082QkdFdHRUc0tnUkUxUmdOcndaR29JUWhzbnlpZlZaSkZ6a1JUaWVycytn?=
 =?utf-8?B?TmE0TVU5bDBIRXV3SEd4S2VFRmFFa0J3RXhjcnVYbjhhRTFTbnVpTkxseFo0?=
 =?utf-8?B?S2d3V2VnMDBSUDl5MnFUTStnWFFwUFNDVjhtcWg5MjhyUDV6L0VmeDVjdFVh?=
 =?utf-8?B?NTlVdVBFd0MxS2lZbkRWVnZrOTVUWFhncDVydTFoU25BSWdnRzNaN241MDZx?=
 =?utf-8?B?dkdsZkZnb1VrNmZ2RmpQYTN2M1Z0b205MWV4TWlPam5NUGZxdkozOWNncGk5?=
 =?utf-8?B?Qm0zaFdCdWprWUJNUFVCRkJpdldHc2hvTkhaUHk5R0wrTk8vekREZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162253f5-a7f4-46ef-a9b5-08dee8d79620
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:29:36.9430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSOR8dxpR0cfd7sLsgynZzuA+QjAdqm3UfHOcbNv7neky2xVw/OL8nXTcjqLxOwYuJVtEKrE2p7BbyTVUpKLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914

Ankit,


On 7/23/2026 9:23 PM, Ankit Soni wrote:
> On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
>> Certain AMD GPU's must always be in identity mode. Currently its enforced
>> using PASID check. It worked fine as most GPU's has PASID feature. But
>> this means, identity mode enforcement is done for all PASID capable devices.
>>
>> Previously it made sense as domain allocation API
>> (iommu_ops->domain_alloc()) was just passing domain type. So it couldn't
>> check device capability and decide best suited page table type (v1 or
>> v2). With recent enhancement to driver code, it uses
>> domain_alloc_paging_flags() ops for all paging mode domain allocation.
>> This can check device/flags and allocate best suited page table (v1 or v2).
>> Hence fix amd_iommu_def_domain_type() to force identity mapping for selected
>> GPUs only.
>>
>> With this change system booted with DMA translation mode will select:
>>  * Guest (v2) page table for PASID capable device
>>  * Host (v1) page table for non-PASID capable device
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> Tested-by: Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 56 +++++++++++++++++++++++++++++++--------
>>  1 file changed, 45 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 563f9c2672d5..fe642e33c87d 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -3112,6 +3112,32 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
>>  	return dev_data->defer_attach;
>>  }
>>  
>> +static bool quirks_force_identity_mapping(struct pci_dev *pdev)
>> +{
>> +	struct pci_dev *root_port;
>> +	int class = pdev->class >> 8;
>> +
>> +	/* AMD GPU vendor ID */
>> +	if (pdev->vendor != PCI_VENDOR_ID_ATI)
>> +		return false;
>> +
>> +	/* GPU class */
>> +	if (class != PCI_CLASS_DISPLAY_VGA &&
>> +	    class != PCI_CLASS_DISPLAY_OTHER)
>> +		return false;
>> +
>> +	root_port = pcie_find_root_port(pdev);
>> +	if (!root_port)
>> +		return false;
>> +
>> +	/* If bridge vendor is not ATI then its APU and force IDENTITY mode */
>> +	if (root_port->vendor != PCI_VENDOR_ID_ATI)
>> +		return true;
> 
> Hi Vasant,
> 
> For a discrete GPU, pcie_find_root_port() may walk up to the system root port. 
> On an AMD platform that root port is vendored PCI_VENDOR_ID_AMD, which is not ATI. 

We want to filter based on vendor as ATI only. As Mario pointed out, logic got
inverted. Will fix it in v2.

-Vasant

