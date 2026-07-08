Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AA23ED6F
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504194; cv=fail; b=jcPELEEx2O52lBZHXTD82kFzuHdMkQDZdPAGM02s9jraKrO4YAAt7OGCZuUlnDUKnuLpRBjF/VfVZ0M+WcaA+qZjqnL57ODjPhqKTqaSRC5sps9UeOAgDfMAn1ql5n9gky1XTFLdyjhBNyzyv8DPMPfARgBxJEa6qSMV9WS0sTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504194; c=relaxed/simple;
	bh=BM+b6di7vpv4p1NkntOWnBG3HcSNSvsO6OAs/3h38B8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TMd6Wq4WbCdj6PfwjDirv8eQKGoHS/KvOFhvfWzP42EkttibJl/Tj4q8SQ0VKX9Ky14lBdeNC14sSvr3o81+xKn5lc9O6MRHwsfMajqWJfuOiYxbIcvnrzYCouNS2sVOeTc9KR1nC7y4aujpZkKRS9/EymE6lwJdFLO+1FcWGBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jQwynM3O; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jQwynM3O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3wsH6ritdgIc8v7WthZjd34u1wCm+qQoBiu8nSP4xM/QIQrjgyhEDZo/Kg06XK4B+aQ21V2C6HSbYgf33ieMgN5zUpnInsQmEJmpH2vXEc5qe+RkPFbaYLtOEo35zsBNfXHX4K9NyHqV+IGCw5n0P0YjkuKFA0mceaAaeuD0exj2idSu/UoMe7bMQBd8a9I6B8Nge4nLxA6tRWt7ieUIsSK0E1hsx/Y9dEp0Xmp7hTNLbMsj8ajZQ6DYObJJbaWU86qgVCneSJOa77JiqJFNL1sA96nYIAkjbJRyixeLfpKwBb+Q7nNEcJM+QU2418/HsatPZlXxJ7QM9fuE2/F9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWi9jVdySQ4FPvzgUatHEWGfbvBnMMP+WLVM/EYN73A=;
 b=paAsNEBhZtY9tvERXUf6H/sufQZhDv3fhBl6k9r9/44qOe0x6jEYF/1cNy5ltHOQjbzRukhWwurbH/707Ln/svigaZJ0rYtTFPUWrGOJzht1CGX0F5+PQWKbdHSNZACEzcEYuH1VIKUbfoeV2PBx6TXbZdVi2dyGiE40MQNdq8ndbosXN3zoX7adX12+zl9yQeRlaZGy+scPWyVnEPrFsLCCxMcgAQD4n0CntnuOujuErZQ3xnV3Gq5jSJ0g6DpWyBBWjfaYq9dlfmHjz1VEMbBrYvTdLpjtNAlZ7S90scfLWvzsVvOVwJKN25I9PVuSPYefGjn/3ABjuVWJqjTkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWi9jVdySQ4FPvzgUatHEWGfbvBnMMP+WLVM/EYN73A=;
 b=jQwynM3OBnEE1PBK8w8AkLO5lbmJYErmPMq3fLvOCmFGL5uYTuWI6RJXs8SUvRw4jYxxes6MtNbdktH9N3iukbLRStXHb3/MJmdA7NQlsXnnA0hjJzbrGzR4TJNPR44cku2/23BCL7gBo3ydU+4UXDSWI6IJ3cyFEO7yLo3xWjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by CY8PR12MB7267.namprd12.prod.outlook.com
 (2603:10b6:930:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 09:49:48 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 09:49:48 +0000
Message-ID: <6ad2d32c-f759-4be9-b388-00fc1267da71@amd.com>
Date: Wed, 8 Jul 2026 19:49:42 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] PCI/TSM: Create MMIO descriptors via TDISP Report
To: Dan Williams <djbw@kernel.org>, linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
 ankita@nvidia.com, Arnd Bergmann <arnd@arndb.de>,
 Xu Yilun <yilun.xu@linux.intel.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-15-djbw@kernel.org>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260705220819.2472765-15-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0076.ausprd01.prod.outlook.com
 (2603:10c6:10:1f5::6) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b60562f-3d5d-4c24-ec20-08dedcd63f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|3023799007|4143699003|6133799003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	exS+SXu/KgpUrR5jaR3pRLC9AXi7EvsP3cv28kakgDTGZ3lzLpLJV76LpDbi+RbEwhX+U6COXmXFsezMvUGKTAUkHq8YzQvyUIFI1iehZaJN36svVyBhodCO/Rc+RW9N5PhWqjmjzZxnr2emLK5p5QsGRxaYg0P+4T5WH8H8AbyKlLClGFf0+VDbuNDuRYvYpDItFFb4TGyTUtOTjpHIa6Sy0q/3Mn3BptSQfj0h30B4Mtun/YSEhogPex0XyDV19YKjDaQi88On6FqVZ31VMMTM6KWoxa8bSWMVW5YpCfNNHQC38gh1aYW7lbsjmkwZQaDxEX8vH3pIpkV9xaiTVsFw3N3XBA2A73xcik1bxCkmUe5q4ty/C3rOgwvfmpAW7rsdEy5zJpAJV8TJ6VNiqCOOL6vnInfDUe7+nHgaHmxyOWJYD//zHfWfJ5vHTaX5lTa5CKaeIgB23wK7W2+iDyZFfteTnZtvNqvSlEEmsvwygjVtClyqBMOBwtYnVlayfOH3TcIMWc6s/XtjLjPwVeRdISGQsRNYPRSfsDRXz3e8O67g45gucs0vrRYSvPFBo7tQWtfi6jR49AqXXW8YNLXm+8qw9CMw6NJHml4U4t4ZdNI23zYo85msp2+WdiGOfszZmX7X9RPayTs96gAmNwbCzNB8pfp4S8bX+YJeDCc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(3023799007)(4143699003)(6133799003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjRQUFhITG9TY0xLQXNzWGFaMHBBc2U4UWJOYlFSblVwcmlXTHJ0bmJhcDdr?=
 =?utf-8?B?QjREanN1Q2gzbi92L1RZb3g2T1ZFTTFMUnBzMzlSd0ZvWWJMSW9jQXdudWc2?=
 =?utf-8?B?M2R6cTBKVUc0THJNdEtpN1ZPMkxJUDhrVVJQdFU5dEl4K3AwZ2hGT01rZTcw?=
 =?utf-8?B?eUFZbWZrSHVXdkhwSTBEcXBGZE55eWZyQ1lSTkdrYmlnQTgvV0dINyt5QkVT?=
 =?utf-8?B?N2k4QlcwRlBZM0Jtcm4raGpYSVVjOUQ2U1J1YWloVmEveEU3QkVTMks2ZUdv?=
 =?utf-8?B?L2Nnd0RvcWNSeWkwdTJsemlNVkJOc1BnMFRmWkszM1Vic1pOY21qWWFhUmp1?=
 =?utf-8?B?ZUhvaHptUlMwMHlxM0pTa0E2MXYxODdLOXhEdzBzZmZmdUF3S2dDVDMvNDNm?=
 =?utf-8?B?bVU4VUVOQVI1WFpPRDhEVXVTMjdBOGtuREJDOW5TdDBUZnl2c1JobDdJU1ZU?=
 =?utf-8?B?azlYSFNzK2dOTUM1ZGp3SVZGMGZBTHkzbkwxWWh6SndRSXZ2enI4U2wzYWhH?=
 =?utf-8?B?Y3h6dUZkZ3ptajJPdDJHMUFVUTB2dmVlUDBOVEJac0FuNlB3bXhHeDd0a08w?=
 =?utf-8?B?dUlCOU5panh0V1ZTSktOWXhTQVo2U29Rd3gzakpXSzRGOXIzSFlpSTJMSzdW?=
 =?utf-8?B?aXhTZ09oajgvVy9BWDBOUlRFVmFhUG5kZjRBeDQrWFZ1L3BhNEwrZGRwbXho?=
 =?utf-8?B?bzMwUlhnaWN2WGpoOGMxMEZpS25ydWMxa01UQ2N3cDc5NXErZjdrVEVxR1Rn?=
 =?utf-8?B?ZGc1ZjE1VXVxWUxVcCtuM3k2eUFaejBvZ3d3VmNLSE10NTdycVg4OHFkTTV1?=
 =?utf-8?B?RXhsRTBzMU5TcXRxc3VtVVhHV1NEUzlvU2cwWTFJYUgvOE16NndZRHRKRVFm?=
 =?utf-8?B?WVUrQWZNem82eThVVWEvUEhyNFMwMG1wSVg0TnI2T3cwNkdNaTVSeGpCckdj?=
 =?utf-8?B?cGZxU2RlWGpRQVFPcFBZbHNEV05ob1lqZ1lSaWJmTnNLZXBTZUoyRFJjNGpj?=
 =?utf-8?B?OG9LRW4zY3R2dWNneW5sL1dqeXVFOFVkaWwyUWJFbkFSR0oyZTFHeFFZU0tw?=
 =?utf-8?B?ZHdvVlVlaU5tSXdYNzBTelYycmg3WEx1NDNUbHRUbmdjcEpsVTJaUnZ0MXAw?=
 =?utf-8?B?d1g1SkR3NUF1R2h6Wk52NFMrVmFGelduTDd0U0tyNElaNXI1ZDNNZHczK1hS?=
 =?utf-8?B?SGtISG9hY1E5eTBCKzg3QjJiUDVPSXdxNkdSZTRmSm1taFBrQUFRK0EydEQy?=
 =?utf-8?B?MjE5SVFQTDRsa0ZEd1BGbFVHcENuWnpTSUQ4Z0dBNmR2VERzclRIZ0VKZW8w?=
 =?utf-8?B?WTEycUlQdWZuTTk5T0Y4aFZHVFJIS0ZHdERBOGZEMTIzSXo4S2NvZGducVgy?=
 =?utf-8?B?QjE5RkR4M2loKzVvQkZUK3dPaE9CV2oxM2U2RisrMys3MVkrTWswVEFFcE5P?=
 =?utf-8?B?ckJON3Fxa0NMdHpnZ2x5RExhUzg1M29kazRqQjJ2d2JQcHExTlYwZStJT1Bq?=
 =?utf-8?B?S29pNUpPSXRjVnJNQkhDbi9zY1FwOE16MVpGNVBmdG9QRHFhYkVFYmx2bGJ5?=
 =?utf-8?B?a3B1NlJ0Qk1UT3p3NHM2Ni95a00rZldGTHQzbDh3OS9Jdnh5ME5HZnp1S2xp?=
 =?utf-8?B?WUd3ZDBvRTJBZ2VYVlVicDBSU2d4OHh0S2MyVXcvYkV1OGkxdkV3VG1VdnNK?=
 =?utf-8?B?amp1MkpGeDNpUjdua3JQRWRGNDYxNkFsRFpDLzE2d2xadTdzUUpNTTFFTjc1?=
 =?utf-8?B?TFlOZEpXc09JWWVURmkvNVNYRTBnY3RnNXBzVTZIOERvU1N3M0JoazV4S3Nq?=
 =?utf-8?B?cmVXY2o4eXBGcm5meVZGc20yMmVjTXNVd3d5S0JlK1RibFkvMVFScjFrSzJW?=
 =?utf-8?B?bzRidXkzU2Z1ZUdjVFBLRWZnWXBnSUlDanE4dzNqOWRvb3hZTzQxdUJaaXZm?=
 =?utf-8?B?cXR5KytHcHBmcStlbDNpRzRNLzRQUGw2RDlrVnNuc0xTakpyVmtEamxqcVF3?=
 =?utf-8?B?RmNYNTFDeGpEWFNJbjdDSzFCR3FNNjdndStBUm5hdHZWVVIvWWxEZHBkZ0Rv?=
 =?utf-8?B?MGEwMENhTUtaMjRpNHYwYi9reWtUVXovdFA2WUlsZk1MZng5b1lqaEpQSHM2?=
 =?utf-8?B?Y2QzY3ZuVmE1alpXdUswenpqbWdLVHVnL3NzN2ZMbmx2TFE5cmZrOXhyU3Qw?=
 =?utf-8?B?MDJUSzN0WVdQYk0yRG9yVUR6d3N0V0h5aUloNU5mZjJwV3dwRDdyaUl4MG13?=
 =?utf-8?B?bUhRUUpLaXVIeWY1VzNrSFpGVm14MThLTVl2WTl0VXgrR3BXM0xTNk1WM3E1?=
 =?utf-8?B?V092elljSWxOcXhoSVYyVDdLdzdIQjVOVVdIOUhOdHVKb0JidXVNQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b60562f-3d5d-4c24-ec20-08dedcd63f7c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:49:48.1928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7o7KX007sueOl1as/CO0OSj+pKQU+qHB3K0cbjKmRMdZcOGey0RhS03nlsMSFZy8kXXMdLAEXqFdS2vYjMffQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267

On 6/7/26 08:08, Dan Williams wrote:
> After pci_tsm_bind() and pci_tsm_lock() the low level TSM driver is
> expected to populate PCI_TSM_EVIDENCE_TYPE_REPORT in its evidence store.
> This report is defined by the TDISP GET_DEVICE_INTERFACE_REPORT response
> payload.
> 
> Add a helper to create encrypted MMIO descriptors from that report
> data. With those descriptors the TSM driver can use pci_tsm_mmio_setup() to
> inform ioremap() how to map the device per the device's expectations. The
> VM is expected to validate the interface with the relying party before
> accepting the device for operation.
> 
> The helper also provides the obfuscated starting address for each encrypted
> MMIO range as the VM is never disclosed on the hpa that correlates to the
> gpa of the device's mmio. The obfuscated address is BAR aligned.
> 
> Based on an original patch by Aneesh [1]
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/linux-coco/20251117140007.122062-8-aneesh.kumar@kernel.org/ [1]
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> ---
>   include/linux/ioport.h  |   2 +
>   include/linux/pci-tsm.h |  35 +++++++
>   drivers/pci/tsm/core.c  | 224 ++++++++++++++++++++++++++++++++++++++++
>   kernel/resource.c       |   8 ++
>   4 files changed, 269 insertions(+)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index f7930b3dfd0a..122f1eefb4b9 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -144,6 +144,7 @@ enum {
>   	IORES_DESC_RESERVED			= 7,
>   	IORES_DESC_SOFT_RESERVED		= 8,
>   	IORES_DESC_CXL				= 9,
> +	IORES_DESC_ENCRYPTED			= 10,
>   };
>   
>   /*
> @@ -240,6 +241,7 @@ struct resource_constraint {
>   extern struct resource ioport_resource;
>   extern struct resource iomem_resource;
>   extern struct resource soft_reserve_resource;
> +extern struct resource encrypted_iomem_resource;
>   
>   extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
>   extern int request_resource(struct resource *root, struct resource *new);
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index 397e5d8459cb..6d5fadd79360 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -156,12 +156,42 @@ struct pci_tsm_pf0 {
>   	struct pci_doe_mb *doe_mb;
>   };
>   
> +/**
> + * struct pci_tsm_mmio_entry - an encrypted MMIO range
> + * @res: MMIO address range (typically Guest Physical Address, GPA)
> + * @tsm_offset: Host Physical Address, HPA obfuscation offset added by the TSM.
> + *		Translates report addresses to GPA.
> + */
> +struct pci_tsm_mmio_entry {
> +	struct resource res;
> +	u64 tsm_offset;
> +};
> +
> +struct pci_tsm_mmio {
> +	int nr;
> +	struct pci_tsm_mmio_entry mmio[];
> +};
> +
> +static inline struct pci_tsm_mmio_entry *
> +pci_tsm_mmio_entry(struct pci_tsm_mmio *mmio, int idx)
> +{
> +	return &mmio->mmio[idx];
> +}
> +
> +static inline struct resource *pci_tsm_mmio_resource(struct pci_tsm_mmio *mmio,
> +						     int idx)
> +{
> +	return &mmio->mmio[idx].res;
> +}
> +
>   /**
>    * struct pci_tsm_devsec - context for tracking private/accepted PCI resources
>    * @base_tsm: generic core "tsm" context
> + * @mmio: encrypted MMIO resources for this assigned device
>    */
>   struct pci_tsm_devsec {
>   	struct pci_tsm base_tsm;
> +	struct pci_tsm_mmio *mmio;
>   };
>   
>   /* physical function0 and capable of 'connect' */
> @@ -263,6 +293,11 @@ static inline const struct pci_tsm_ops *to_pci_tsm_ops(struct pci_tsm *tsm)
>   	return tsm->tsm_dev->pci_ops;
>   }
>   struct pci_tsm_devsec *to_pci_tsm_devsec(struct pci_tsm *tsm);
> +int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
> +void pci_tsm_mmio_teardown(struct pci_tsm_mmio *mmio);
> +
> +struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev);
> +int pci_tsm_mmio_free(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
>   #else
>   static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
>   {
> diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
> index 372363a39a44..9ac216ad896d 100644
> --- a/drivers/pci/tsm/core.c
> +++ b/drivers/pci/tsm/core.c
> @@ -15,6 +15,7 @@
>   #include <linux/pci-tsm.h>
>   #include <linux/sysfs.h>
>   #include <linux/tsm.h>
> +#include <linux/unaligned.h>
>   #include <linux/xarray.h>
>   #include "../pci.h"
>   
> @@ -552,6 +553,229 @@ static ssize_t dsm_show(struct device *dev, struct device_attribute *attr,
>   }
>   static DEVICE_ATTR_RO(dsm);
>   
> +static void mmio_teardown(struct pci_tsm_mmio *mmio, int nr)
> +{
> +	while (nr--)
> +		remove_resource(pci_tsm_mmio_resource(mmio, nr));
> +}
> +
> +/**
> + * pci_tsm_mmio_setup() - mark device MMIO as encrypted in iomem
> + * @pdev: device owner of MMIO resources
> + * @mmio: container of an array of resources to mark encrypted
> + */
> +int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
> +{
> +	int i;
> +
> +	device_lock_assert(&pdev->dev);
> +	if (pdev->dev.driver)
> +		return -EBUSY;
> +
> +	for (i = 0; i < mmio->nr; i++) {
> +		struct resource *res = pci_tsm_mmio_resource(mmio, i);
> +		int j;
> +
> +		if (resource_size(res) == 0 || !res->end)
> +			break;
> +
> +		/* Only require the caller to set the range, init remainder */
> +		*res = DEFINE_RES_NAMED_DESC(res->start, resource_size(res),
> +					     pci_name(pdev), IORESOURCE_MEM,
> +					     IORES_DESC_ENCRYPTED);
> +
> +		for (j = 0; j < PCI_NUM_RESOURCES; j++)
> +			if (resource_contains(pci_resource_n(pdev, j), res))
> +				break;
> +
> +		/* Request is outside of device MMIO */
> +		if (j >= PCI_NUM_RESOURCES)
> +			break;
> +
> +		if (insert_resource(&encrypted_iomem_resource, res) != 0)
> +			break;
> +	}
> +
> +	if (i >= mmio->nr)
> +		return 0;
> +
> +	mmio_teardown(mmio, i);
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_mmio_setup);
> +
> +void pci_tsm_mmio_teardown(struct pci_tsm_mmio *mmio)
> +{
> +	mmio_teardown(mmio, mmio->nr);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_mmio_teardown);
> +
> +/*
> + * PCIe ECN TEE Device Interface Security Protocol (TDISP)
> + *
> + * Device Interface Report data object layout as defined by PCIe r7.0 section
> + * 11.3.11
> + */
> +#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_TABLE BIT(0)
> +#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_PBA BIT(1)
> +#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE BIT(2)
> +#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_UPDATABLE BIT(3)
> +#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID GENMASK(31, 16)
> +
> +/* An interface report 'pfn' is 4K in size */
> +struct pci_tsm_devif_mmio {
> +	__le64 phys;
> +	__le32 nr_pfns;
> +	__le32 attributes;
> +};
> +
> +struct pci_tsm_devif_report {
> +	__le16 interface_info;
> +	__le16 reserved;
> +	__le16 msi_x_message_control;
> +	__le16 lnr_control;
> +	__le32 tph_control;
> +	__le32 mmio_range_count;
> +	struct pci_tsm_devif_mmio mmio[];
> +};
> +
> +/**
> + * pci_tsm_mmio_alloc() - allocate encrypted MMIO range descriptor
> + * @pdev: device owner of MMIO ranges
> + *
> + * Return: the encrypted MMIO range descriptor on success, NULL on failure
> + *
> + * Assumes that this is called within the live lifetime of a PCI device's
> + * association with a low level TSM.
> + */
> +struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev)
> +{
> +	struct device_evidence *evidence = pdev->tsm->evidence;
> +	u64 reporting_bar_base, last_reporting_end;
> +	struct device_evidence_object *report_obj;
> +	const struct pci_tsm_devif_report *report;
> +	u32 mmio_range_count;
> +	int last_bar = -1;
> +	int i;
> +
> +	if (!evidence)
> +		return NULL;
> +
> +	report_obj = &evidence->obj[DEVICE_EVIDENCE_TYPE_REPORT];
> +
> +	guard(rwsem_read)(&evidence->lock);
> +	if (report_obj->len < sizeof(struct pci_tsm_devif_report))
> +		return NULL;
> +
> +	report = report_obj->data;
> +	mmio_range_count = __le32_to_cpu(report->mmio_range_count);
> +
> +	/* check that the report object is self-consistent on mmio entries */
> +	if (report_obj->len < struct_size(report, mmio, mmio_range_count))
> +		return NULL;
> +
> +	/* create pci_tsm_mmio descriptors from the report data */
> +	struct pci_tsm_mmio *mmio __free(kfree) =
> +		kzalloc_flex(*mmio, mmio, mmio_range_count);
> +	if (!mmio)
> +		return NULL;
> +
> +	for (i = 0; i < mmio_range_count; i++) {
> +		u64 range_off;
> +		struct range range;
> +		const struct pci_tsm_devif_mmio *mmio_data = &report->mmio[i];
> +		struct pci_tsm_mmio_entry *entry =
> +			pci_tsm_mmio_entry(mmio, mmio->nr);
> +		u64 tsm_offset = __le64_to_cpu(mmio_data->phys);

* SZ_4K is missing.

> +		u64 size = __le32_to_cpu(mmio_data->nr_pfns) * SZ_4K;
> +		u32 attr = __le32_to_cpu(mmio_data->attributes);
> +		int bar = FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID,
> +				    attr);
> +
> +		if (bar >= PCI_STD_NUM_BARS ||
> +		    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
> +		    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
> +			pci_dbg(pdev, "Invalid reporting bar ID %d\n", bar);
> +			return NULL;
> +		}
> +
> +		if (last_bar > bar) {
> +			pci_dbg(pdev, "Reporting bar ID not in ascending order\n");
> +			return NULL;
> +		}
> +
> +		if (last_bar < bar) {
> +			unsigned long mask = pci_resource_len(pdev, bar) - 1;
> +
> +			/* Transition to a new bar */
> +			last_bar = bar;
> +
> +			/*
> +			 * Determine the obfuscated base of the BAR. BAR
> +			 * offsets are never obfuscated.
> +			 */
> +			reporting_bar_base = tsm_offset & ~mask;
> +		} else if (tsm_offset < last_reporting_end) {
> +			pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
> +			return NULL;
> +		}
> +
> +		/* Per spec the tsm_offset never results in overflow / underflow */
> +		last_reporting_end = tsm_offset + size;
> +		if (last_reporting_end < tsm_offset) {
> +			pci_dbg(pdev, "Reporting range overflow\n");
> +			return NULL;
> +		}
> +
> +		range_off = tsm_offset - reporting_bar_base;


If we all do the mmio_reporting_offset in the same way (use the bar size low bits), then this can be simplified and should be as it does not account for the non-locked (==not reported) MSIX anyway. Thanks,


> +		if (pci_resource_len(pdev, bar) < range_off + size) {
> +			pci_dbg(pdev, "Reporting range larger than BAR size\n");
> +			return NULL;
> +		}
> +
> +		range.start = pci_resource_start(pdev, bar) + range_off;
> +		range.end = range.start + size - 1;
> +
> +		/* Only record the TEE ranges for later consideration by ioremap() */
> +		if (FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE,
> +			      attr)) {
> +			pci_dbg(pdev, "Skipping non-TEE range, BAR%d %pra\n",
> +				 bar, &range);
> +			continue;
> +		}
> +
> +		entry->res.start = range.start;
> +		entry->res.end = range.end;
> +		entry->tsm_offset = tsm_offset;
> +		mmio->nr++;
> +	}
> +
> +	return_ptr(mmio);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_mmio_alloc);
> +
> +/**
> + * pci_tsm_mmio_free() - free a pci_tsm_mmio instance
> + * @pdev: device owner of MMIO ranges
> + * @mmio: instance to free
> + *
> + * Returns 0 if @mmio was idle on entry, -EBUSY otherwise
> + */
> +int pci_tsm_mmio_free(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
> +{
> +	for (int i = 0; i < mmio->nr; i++) {
> +		struct resource *res = pci_tsm_mmio_resource(mmio, i);
> +
> +		if (dev_WARN_ONCE(&pdev->dev, resource_assigned(res),
> +				  "MMIO resource still assigned %pr\n", res))
> +			return -EBUSY;
> +	}
> +	kfree(mmio);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_mmio_free);
> +
>   /**
>    * pci_tsm_accept() - accept a device for private MMIO operation
>    * @pdev: PCI device to accept
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 3d17e3196a3e..ba91ce43ff7a 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -56,6 +56,14 @@ struct resource soft_reserve_resource = {
>   	.flags	= IORESOURCE_MEM,
>   };
>   
> +struct resource encrypted_iomem_resource = {
> +	.name	= "Encrypted MMIO",
> +	.start	= 0,
> +	.end	= -1,
> +	.desc	= IORES_DESC_ENCRYPTED,
> +	.flags	= IORESOURCE_MEM,
> +};
> +
>   static DEFINE_RWLOCK(resource_lock);
>   
>   /*

-- 
Alexey

