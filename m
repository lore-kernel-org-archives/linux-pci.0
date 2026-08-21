Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA36C4DB553;
	Fri, 21 Aug 2026 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322330; cv=fail; b=AD4yzgUNMoO+VpUUq06MBEn3FqeeaRhwcNKjlIl4vT4uERYghJf6yZelJmSbTt6ZWrSLj1cyx8bkAfpqZO+J4VLS27dA0u068WEfQs/pS1qg1kO4LVZpmmw5L+VSNcTWk2KfrdztLV9b4AoYTMi9Hvim7CZWKLK802fv/5dVuGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322330; c=relaxed/simple;
	bh=AwUBALy9T5Aa7cczsCx0s38r6b0GBmKowSKnaY2xvBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tmbtye1mNjMTLgV8/TO4Pq5Z2zNEYOaWQqU2SQYFh6rfIWbEXvbdrKzlnmWdXYHADR/U1hyU1ohY6UQNIRLIDsVusba5tw8ZqzqD0VWX3m6gff389i6s+LWGWzFkc17HS93eePVKeMqijRasaHEie/PCNVbTBSqA5QZd7Fac7GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pA0yD5LD; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pA0yD5LD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tItOFo9F3AxZ1+qI+PhtsBrW4zGEGmf0dDueI4pI1xsgpYhqB2EusKVNrJaI01UYQzV4Kk/ma6Gqkd3itaxJnjU4qneJAGzZPGtXR3/n/q7reaw/3YZRx1IP90MKjZFAkRkOeIpfZ/pGSToXzxxzp+ZTH5rHMI66zpe7/9j/oII/QVjKX3zfPXJsS3pm5V72rSUFIdXKNYLHyYlHfAlt5iVKZPuXQzIJGZ6V8R74tV9EBnkE4XTqxTPvcLaweXLc/E8FgHHNVoj6O6hlDBkCUAnntOcSYSNwr7s1eZHqrvkzGp75XqVQN0W4/ZKoWNpZNEXvageg/O7TNxlkkXyNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URx3ipeZbULmREiyVtTW/ebfjpF79iAhujrx6EJTalU=;
 b=G7haV4yuvI4TJYOou/9Q3R1MFLw6sbWj8ExOiuvP/DnlTkPZ4eHEneyF+EfIsYNUbssBMo8gnA48Q6SyAQ/CktPM/NUBzZG3A99h6P7z2ikGmmK1TaKUqlszf5vdhARnoMQDicjmcscdoGK+16sHX+r9F77mO2AMmf8Sp3pgsoRxLzPWDKQsgX+xehXqn26lwuzjzKQEjzgRjSgJRj43+bIpvaFSlel5h07KunN2olMmKda86p866qJQLWgMsxpxQWZD+vqUdxPUmRU6OmeedC2j/iUFD7SP5i3+AH2ZbT0GkaqpLm0JGqtlKNNcEXwLwmNeNb1egiiiW/UFS891aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URx3ipeZbULmREiyVtTW/ebfjpF79iAhujrx6EJTalU=;
 b=pA0yD5LDBbpnAPNXuSPPqJN+QV9q/NstiI2W/dheraSwlew0VkCSSkvRwfiT/0ooAHfrktK33+sCfgI4u+YFzuWd1O+tluH6Jz+w+N4rVR+dW9hD9QHtKw9Mipii5RBFrsFT3z37U9JCvoJ5pjXAK0lhp0YxrP+11gQRn6kZDds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 14:25:25 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 14:25:25 +0000
Message-ID: <19c825ac-4db9-4b09-9ab7-3d9cb51c3cc5@amd.com>
Date: Fri, 21 Aug 2026 19:55:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] dmaengine: dw-edma: Add changes to support Channel
 Separation
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 den@valinux.co.jp, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com
References: <20260820091025.683506-1-devverma@amd.com>
 <20260820091025.683506-3-devverma@amd.com> <aocbq7S3sCBoqXBb@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <aocbq7S3sCBoqXBb@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0364.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::14) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: feb7712a-d8ea-40c0-918c-08deff900ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	/z8LaXMhhNxLe88VFeLYN2xoRZbD/G4dk+moRdeeMCo/cm0tFCaBJUJEXQAaliwjCwC2OA4JxO9HVA1iSr4rdZt33Ngm7vksISYlhx12tO4B6x6W07rnWMkkmGR/qxEgpHEisQb3MGdhcDAM+TkZR7Iwz983kG7p+Z53HBRWS7FjyS7fTmJCTozHkBh6uV3BGd9xdbKEdfPgZfivhCFT0GFtLqxhzuc1KrjBdt3iwNUeM8RBM6ZoB73GtheZeM76X/CwtrWE703MQ4O0ZtEn9FzGItW8dtPAKBEhw/iVe7pcIRNOFMUSee3suefP/kAe9XukQ/CUomy71o6lSfwdIBexM14/Y/UQdmeiaBjg01h7cE+9p1L2pc7i1sKPtvNxZde6KSbQq6vNmSStzak/OO3VPbuHtl2HvOQ8WoRYGFiozeBDKEimfx/4KOxnDDAtKdHWs6b93u0YVy405jDOwCB2DixojAzJc1FslzvdPAWP8+0CiSmpMu90RODQr/Xy+lLzxRYXC9beqdUqVN9RamcuNgkZkaREqse4ngyZQ2mDzvyWFYUUSOgx7bJq3ZUWOuBYMvgZqX/nKSt8lOce62lSQBvaWbcsmQAVNNLgE1I9U+6f5GE6ijLIm8A9hVsHxlS2kpp/+/il1gHFXVu9IB5qOnD8TyG72XbkXS0s3Jk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1JTZ0xYTHgxbC9QcWhaeWl1VXpuVGU3Q3N2RjZPVGZSM0MrbHpVYWpNMW8r?=
 =?utf-8?B?RVUyZWx4a2t1WUt6ZUdXRHJoeTk1cUttcnlGdUdJdUErTnZZSVBQd2RTckxS?=
 =?utf-8?B?RUpINm5TK2tsL2R5ZWZCaFhwRURUbHJuQWlEQWFmaERMYTl1S2UvV1owbGxy?=
 =?utf-8?B?TnFZdkxEZ29IR0Z0QzZUWlVLL2FoU21HTHpkd2RCQ3UzU1FyVHBzUGNtS1Nm?=
 =?utf-8?B?YndzTjMySTZSeDd5TitJZ0V5WVJhNm9ORU9hQW1LVU1mRDg3YnVnUmdPaEJB?=
 =?utf-8?B?QVhPNEZLR1loOW8rNFM0WGFFanA0SWIyanBkNFF6UzJMNVBvOWN2WlorOUNU?=
 =?utf-8?B?RGJud3o4Ym9oc0tvNktpd2VwZ2hrYjFWcjUyL0xHbzdBZ2dBdGJzU1VweWpM?=
 =?utf-8?B?TEFtcS82TlBTQ3pJc2U1KzhqOXJIZ0pWaWJ5djFmK08wV1lyZWg2ZkVncXlq?=
 =?utf-8?B?YVZXYUVNZ2dKMmNQRXdzdlovT3QvTTZSdWwxdG1YNnc5TkJHMGd3VHpYQlls?=
 =?utf-8?B?QUtvMWYreS9TSTBjcWIzN1REY3NHelVXT2dLOFJ1MHRKZ2Q3NEpQNjN2QVVy?=
 =?utf-8?B?NmN3bWc0RDV4RWxYYkw4MWRrNkJ0NmdIcVhZWlpBVkd6SXpGZE03NFNDZEJV?=
 =?utf-8?B?aHZrTmRndlRDVk9jUW5mUVR3NDB3WkpLQ0ZOclJqdVllWGtlTGU1MkIvWTVD?=
 =?utf-8?B?MW0zK2N3aWZ6QXZ0OEpkdGgxcmVXM0lWRzFsTGhZOTVmVE01bjJIWVpoMEpr?=
 =?utf-8?B?eG9XR3I2aGxWZ0dvNEg2MHhaaEgxSG10dmN0M29JTFA3dU1pOEp3L1pVVUIr?=
 =?utf-8?B?NjE1aDVsMWtYdUsvSlZUdlYzUjhsbkd6LzZHNHBDak96bWpiUzVSSDhLS09K?=
 =?utf-8?B?MzUyRkhsSFlrZGc5RzlVd1RSdkhCK0ZQMjBZR1JYK1orcmpTVUZhR2FhS3c4?=
 =?utf-8?B?elptcTFtMnl3RHJwSmQ4TEo2dE91WGZHcHNNRXlac2dSd2FHSmhOUjdJcnU2?=
 =?utf-8?B?WThaU0RsR1JMV1hhUjBCZFl4NGc1bGFvUGgrbTA2U3BUMjNETUd0dHNhK1Ew?=
 =?utf-8?B?YTBZc2hoZGp2NGE5dW5tVUVtb3ZNSzh6OXM2YXNlV0dLOUtCN0crZU5JUkxB?=
 =?utf-8?B?aUZycmJvQnlaUmtaYmh5aTBSUGpjOVo4SUlHZTFmR1ExRVB1MzdwT1lZTEdX?=
 =?utf-8?B?NFJWZElTQm9jNG5qUG9qNDdjU3Y4TFpPM2lDZVNDRmpBOW5KeHFFYkxVTnY4?=
 =?utf-8?B?YlY0cU5LL0J4TFljQ1BSbGpEZ25PY0V6YW5hK25NNmZ2VHc3eitOaGZOclZy?=
 =?utf-8?B?U0lkZEhQYitKZ05EZms1ZmZWWGV0RjZaLzV2MzZ1S2xzQjF6REZBbENSSUEy?=
 =?utf-8?B?LzdWeVQxZlRYL1NLSjE0Ry9CZG1LdHlINnpTcjB4ZUpVYkx6QVNOODF2SnRq?=
 =?utf-8?B?eEhyM0R2aXNQOHZjVE1YeGtoK1lVV3RMWldQUTVrR1NLVjdlaHZTYjJlclQ1?=
 =?utf-8?B?MVBsUzZmcFUyRERDajUvL1ZLSjU1cWtqc2c4c3V3L2ZQbXM5TjdteGtzTkhD?=
 =?utf-8?B?VXVpUGVUZG1ITDZKUnY5VzFLdGdNRGJhSlFQNjJJRFl1bGc5MFVFNjI5cnNr?=
 =?utf-8?B?MHpjZStIbFFGYTFJQTVQRlpnL2xjM0VNeUp6SitOMlpFdmd4MWlOKzZ5TUlz?=
 =?utf-8?B?TEpiTXJJLzdxSmU2UHhMZWJ4aEQrMHRvd3NmUmx3R0VUUjUyODVaWHVMc1cz?=
 =?utf-8?B?T2YwSWVYTlpGZVB1THNMVldackFVSVJjSng2WTcvWDBjRm5PNy85M0pxMTlp?=
 =?utf-8?B?V0J6V0lLL1FHVmt3eFZURWt5aGxtM3hTNFRjb0xKS2JpUjJCd1NQUGVObzhM?=
 =?utf-8?B?aHZiUmFjRWM3ZzhoNUFBVnltcHptUGNQV1BwbXNGUFFWeWhVZ2ZkTjRJWXhM?=
 =?utf-8?B?WHpPZmpSeUxqa1dIanJHOHIva3dXV0ZMR1ZIbXhJRFRYWlFDbFNqTW11V2hz?=
 =?utf-8?B?TTVTZG0xRU5XbE14MHZ0YzZXYXlEaG5kVkJxVGliOWlTaGozd21RYnZOaXBq?=
 =?utf-8?B?T2luTXhtUWF2eGQwZjFhYko1WDRnRU1QZzlVMHRsVGZNNEtMc3g4NTdTQTYz?=
 =?utf-8?B?ekw3bW1KSGhnMzBXZFNrNzdyYVFPNllCcmxOQUJFblNlSGpYczlPb2RLaFZu?=
 =?utf-8?B?Z3QvdXpjdG9SMWNCMTBXSWhaSktkQ1F3VU9RdS9kMk00U21wVWc0aGhFNVI1?=
 =?utf-8?B?MmtDbVZ5QmJOUWt4OU40WlJIMjBkelRxZGpWeE1iMU1KS1d2djEyakFianZk?=
 =?utf-8?B?aWxaSVYzSUNjM0g5MTlMUlFNZWR4NFlIU2ZTMzMyNXZsekFNeVZOZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb7712a-d8ea-40c0-918c-08deff900ac6
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 14:25:25.7444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NO1EfgDbSEvZPXbZ3GgAMdJdLZJf0gp1K8XWSnVufJUcG95CAa/BbKsfKBo7zVB+TqVlv7IHgPyPx6dP4UAmCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178

On 20-Aug-26 20:52, Frank Li wrote:
> On Thu, Aug 20, 2026 at 02:40:25PM +0530, Devendra K Verma wrote:
>> HDMA supports configurable DMA channel register space
>> separation which ranges from 256B to 32KB. Current implementation
>> supports 256B as default for DMA channel register space.
>> CPM6 supports the selection of channel register space via VSEC.
>> The default value for channel register space for CPM6 is 512B.
>>
>> Updated the functions and methods to calculate the DMA channel
>> registers base address as per the selected channel separation
>> available as part of 'ch_space_sz'. Removed the unused function
>> __dw_regs() and structs, namely dw_hdma_v0_ch and dw_hdma_v0_regs.
>>
>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> ---
> 
> If only add my review-by, needn't post it new version. b4 will auto
> collect tags. I have to mark patch work status twices.
> 
> Frank
> 

Thank you for the suggestion.

-Devendra

>> Changes in v4:
>>     o No change.
>>
>> Changes in v3:
>>     o No change.
>>
>> Changes in v2:
>>     o Replace 'ch_sep_sz' with 'ch_space_sz' as per review
>>       recommendations.
>>     o As patch 1/3 of previous series dropped after review,
>>       this patch becomes 2/2 of the current series.
>>
>> Changes in v1:
>>     o Updated the description as per the review comment
>>     o Updated ch_sep_sz for EPC driver.
>> ---
>>   drivers/dma/dw-edma/dw-edma-pcie.c           |  4 ++++
>>   drivers/dma/dw-edma/dw-hdma-v0-core.c        | 23 ++++++++++++--------
>>   drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 17 +++++----------
>>   drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 10 ---------
>>   drivers/pci/controller/dwc/pcie-designware.c |  1 +
>>   include/linux/dma/edma.h                     |  1 +
>>   6 files changed, 26 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>> index f287879b2cb9..2eb8293b87b4 100644
>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>> @@ -114,6 +114,7 @@ static const struct dw_edma_pcie_data snps_edda_data = {
>>   	.irqs				= 1,
>>   	.wr_ch_cnt			= 2,
>>   	.rd_ch_cnt			= 2,
>> +	.ch_space_sz			= 256,
>>   };
>>
>>   static const struct dw_edma_pcie_data xilinx_mdb_data = {
>> @@ -127,6 +128,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>>   	.irqs				= 1,
>>   	.wr_ch_cnt			= 8,
>>   	.rd_ch_cnt			= 8,
>> +	.ch_space_sz			= 256,
>>   };
>>
>>   static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>> @@ -140,6 +142,7 @@ static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>>   	.irqs				= 1,
>>   	.wr_ch_cnt			= 8,
>>   	.rd_ch_cnt			= 8,
>> +	.ch_space_sz			= 512,
>>   };
>>
>>   static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
>> @@ -436,6 +439,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>   	chip->nr_irqs = nr_irqs;
>>   	chip->ops = &dw_edma_pcie_plat_ops;
>>   	chip->cfg_non_ll = non_ll;
>> +	chip->ch_space_sz = vsec_data->ch_space_sz;
>>
>>   	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
>>   	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> index 632abb8b481c..f8b2383b294a 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> @@ -23,18 +23,23 @@ enum dw_hdma_control {
>>   	DW_HDMA_V0_LLE					= BIT(9),
>>   };
>>
>> -static inline struct dw_hdma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
>> -{
>> -	return dw->chip->reg_base;
>> -}
>> -
>>   static inline struct dw_hdma_v0_ch_regs __iomem *
>>   __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
>>   {
>> -	if (dir == EDMA_DIR_WRITE)
>> -		return &(__dw_regs(dw)->ch[ch].wr);
>> -	else
>> -		return &(__dw_regs(dw)->ch[ch].rd);
>> +	u32 ch_base;
>> +
>> +	/*
>> +	 * For Write, the channel register index starts at
>> +	 * wr_base(ch_idx) = (2 * ch_idx) * ch_space_sz
>> +	 *
>> +	 * For Read channel,
>> +	 * rd_base(ch_idx) = (2 * ch_idx + 1) * ch_space_sz
>> +	 */
>> +	ch_base = 2 * ch;
>> +	if (dir == EDMA_DIR_READ)
>> +		ch_base += 1;
>> +
>> +	return dw->chip->reg_base + (ch_base * dw->chip->ch_space_sz);
>>   }
>>
>>   #define SET_CH_32(dw, dir, ch, name, value) \
>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>> index dcdc57fe976c..3fa16e045a58 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>> @@ -13,22 +13,17 @@
>>   #include "dw-hdma-v0-regs.h"
>>   #include "dw-edma-core.h"
>>
>> -#define REGS_ADDR(dw, name)						       \
>> -	({								       \
>> -		struct dw_hdma_v0_regs __iomem *__regs = (dw)->chip->reg_base; \
>> -									       \
>> -		(void __iomem *)&__regs->name;				       \
>> -	})
>> -
>>   #define REGS_CH_ADDR(dw, name, _dir, _ch)				       \
>>   	({								       \
>> -		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;		       \
>> +		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;                  \
>> +		off_t __off = (dw)->chip->ch_space_sz;			       \
>>   									       \
>> -		if (_dir == EDMA_DIR_READ)				       \
>> -			__ch_regs = REGS_ADDR(dw, ch[_ch].rd);		       \
>> +		if ((_dir) == EDMA_DIR_READ)				       \
>> +			__off *= (2 * (_ch) + 1);			       \
>>   		else							       \
>> -			__ch_regs = REGS_ADDR(dw, ch[_ch].wr);		       \
>> +			__off *= (2 * (_ch));				       \
>>   									       \
>> +		__ch_regs = ((dw)->chip->reg_base + __off);		       \
>>   		(void __iomem *)&__ch_regs->name;			       \
>>   	})
>>
>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> index 7759ba9b4850..2475b8d96133 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> @@ -84,16 +84,6 @@ struct dw_hdma_v0_ch_regs {
>>   		};
>>   	} msi_abort;
>>   	u32 msi_msgdata;			/* 0x00a8 */
>> -	u32 padding_2[21];			/* 0x00ac..0x00fc */
>> -} __packed;
>> -
>> -struct dw_hdma_v0_ch {
>> -	struct dw_hdma_v0_ch_regs wr;		/* 0x0000 */
>> -	struct dw_hdma_v0_ch_regs rd;		/* 0x0100 */
>> -} __packed;
>> -
>> -struct dw_hdma_v0_regs {
>> -	struct dw_hdma_v0_ch ch[HDMA_V0_MAX_NR_CH];	/* 0x0000..0x0fa8 */
>>   } __packed;
>>
>>   struct dw_hdma_v0_lli {
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index ec4722ed9303..dfb7deaff751 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -1049,6 +1049,7 @@ static void dw_pcie_edma_init_data(struct dw_pcie *pci)
>>   		pci->edma.ops = &dw_pcie_edma_ops;
>>
>>   	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
>> +	pci->edma.ch_space_sz = 256;
>>   }
>>
>>   static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
>> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
>> index 1fafd5b0e315..182d4eeae22a 100644
>> --- a/include/linux/dma/edma.h
>> +++ b/include/linux/dma/edma.h
>> @@ -104,6 +104,7 @@ struct dw_edma_chip {
>>
>>   	struct dw_edma		*dw;
>>   	bool			cfg_non_ll;
>> +	u32			ch_space_sz;
>>   };
>>
>>   /* Export to the platform drivers */
>> --
>> 2.43.0
>>

