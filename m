Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9E2367294;
	Thu, 27 Aug 2026 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787862733; cv=fail; b=lieoXXjAWh/xSaSLcIse3WS8CeHwmdvPp4yNATfLzlIu2eqzeCjdc42lnhQnIohXcc/pAwGLHXAzZSAPUx5m2aMhh3lFGgeRECXFGB5kHWD4Z8kxNDKug9yiMwLAThXq7ZwwJN+J8ToUn6l1CkQKgfzJyPWl00b0hoCqtb0FCdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787862733; c=relaxed/simple;
	bh=7NGnNRa5obwtUPQJ8GqqsYhUCXRvremPR62XVn1de80=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=qopajTgdnal4/5KnTJSoXaYnXQCWyU8DKO+xoTfXNqLlKa+E0bguu4s2wKb+ZExUuIICC0oWdn9uMAWqSs/FaVX55d7jq8x8kqOAi9lprm8pQxjI01pZj1bTd4WgCfKQqHDeGiBP814AOXoFTdmOr2L0nKhSX4h0YNuWm4yHTrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RGEAIRDM; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RGEAIRDM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eO27QzxUS4lgiHG/JWnCDC2dFqiq84uLxwuA1Gn57YTXCa5EVkfXwtOCrFO4yPlrLLYwDw6s9TYso2yrVDNbXhlG0GOtWt0VzuvqnUC3o5/fOPEGHn+45tib4FooJf32pLcgWx5WvKe/Gn633tpH00GirPbZkwYM0LhSVoz/hjE+HTi+dN5Q2xPo1d3z5VmKXTysEsci3NzNHHrZM1SIadr8UUOsCA9qxUqbPP2z+QPVB+DaRAFnMz5jDAQoKnfB0R+2wrkspdTQQ1bmXxZDFWH3LgENbUzdHp5DazJ1LOOX5ymCLsGtolWxQEjnmBVOg6hT8NdYSQuab4d6REmodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cCPFh/zfu1Etj1KWHhIlBfN/zJwgr/1LOaRF6VtRFI=;
 b=cZ6SYw8Tvi8rqGbwHNbbdaicbWE7ruR7JCl3rqjK2Gv2FjvMfzBhRNJMnsf4ao62fJ71eGcG7vubE/j1ayf7NnYhrl+jcv9SbORFRaEqUZJCn+ZZxKIb86JOHtm9La8NRaiMpXVi4XtIz+/wwBF5YY0B5lviYE4n0ZvZX3buDhDee7WtYYRqsAzHw5HhM9TZ7i2UJCrIqCbgi4eh0GUjLeLRGqn02B5/dzQsjuGUeUMKDbHUGesVomBtiRjJ0so4yq3yfTpFg01uKG7Rd8nr0HO9W4/6+M4j49NrPv84L1mx0m/fb1pLgrUn5Wl9fNqOUayU+Rb3p90nOPsUZfD96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cCPFh/zfu1Etj1KWHhIlBfN/zJwgr/1LOaRF6VtRFI=;
 b=RGEAIRDMGw+RTqb0iProAtbQo3IRnacuK0SLB5fBnJhdxif2qpnYQyLqo6A9eSkzvj90Pd8ryclIxbxla74p9Gw+Cv6Y//UCIJH20PfKUUp6B+TmIz+jxbLcSWfthrR0eHQspTH0XonTGB7UERgjPAgK8znHreQg4ov37pwFlo4KdFcynhtJzQmrzf6e9FME7fSrN4Md2Nm5llG0OHHBC12wLRSxz5f83Vsb/LtBGb3uB6pKe2FDYKSZuv+fzXMOyiSu3tcWCepklSp6ScTxESBFjInXy1RdYJ8/gr/1L3v1zxVwaqeqNC9J9++dU8GXWQ88EPyqTmiBIOr3jAf55g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 27 Aug
 2026 20:31:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 20:31:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 01/18] PCI: Don't suspend IOMMU when probing reset
 capability
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
 Mostafa Saleh <smostafa@google.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
 Kevin Tian <kevin.tian@intel.com>, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com, 
 Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <6dbbbbe30cdc08a467de893fb9ecdc07d9cc1fec.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <6dbbbbe30cdc08a467de893fb9ecdc07d9cc1fec.1783044582.git.nicolinc@nvidia.com>
Date: Thu, 27 Aug 2026 17:31:31 -0300
Message-Id: <178786269177.3808739.6471040051117543556.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b24b5c-9ce0-4be4-5ca2-08df047a30aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|366016|10067099003|4143699003|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	sDrI6yMIava4YisZfIxHNuM4yxeo7Rw9dShdQe/CqZvsXBy5NSZQBU4NkHyhTih0cPIpIvng/cOV0TA3sdGdwtFqnSKnw6gSVyTajQ+yQMx5PKx9P7xHUP+nROJvSQA/JIcJx/ssbWbwOZTcDv8iEE4kl0OiiFoFf4paCJ3yr1gmjs+UrymfhVvwejyUfrUZqNcGHCN9NvMTnpc164tcpXtzGSG7sDuBk8PcEAZtdBenb3vUzp4HeC4A+oa2AwSs6YXVvmqcS0s/E0I2lHYr7Z40AjZ/c2u3ZpZ4I/4UXPSD3yGPYitQfgoCPSY647c+RJcZpMiPXJ4RTr49IdRe+q2SUko85LF9LylAmKm3J8c4zySYLLXw1svLild10nEU6+0p9V067J5cVZ1o9CeMcYFp8fmprugjfJIt1dauDyYoKTocX5U+uT/oorJN2jA+MU3h3Z5tqNtCuWP2nfSptZbm6C+lRyvUsKdrO9M1lB3GDcefVNt0bFZhvmFgBDeA6h9xF7G+4YJFZ5QWw3glgUZMZ2Y3c7Si+oJmRoQxBj34cu74N16Q37UoWua6p/WjCE245K5PhxCCgXFrSl8Z+8f/lHuMk9NG2Bf3o3jDD8JZYRj9VXdo6szJS76uGDvoGX7+0SYlRThVyTnmdBpEG+w+mpM60TW1gpQauFlDX1g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(366016)(10067099003)(4143699003)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEVLZE1FcXc0bDVGR3pYbkMzdGNzMDRLK3NFK1A0NDRnN0hYcEJRNDlTYTdx?=
 =?utf-8?B?cnJOSmxGZGhYemRSYlNyNUVWZTE1WGpLMFJDOTQwamdLUTc1SDZBRVN5dGRG?=
 =?utf-8?B?d2QrVy9MY3JVSHRpczgvNmlaRmpqMU1vS0RZenpsR011SkVzSjR0TFFjK0lY?=
 =?utf-8?B?UEQzclErNTB3Um5mMllUekNYSTFDVGdFaEt5L2M5VzZCV0o2cjlDMXh4SDBP?=
 =?utf-8?B?L0syTml6QVBKak9WY256NkxSZ21KWUJ3ZjUxcERLQk9CZU42THBmTDIrN0Yx?=
 =?utf-8?B?OHVhTjcrZWFUUWU3TS9EMG5vS25DeXA4T3hVSXRUQ0F6bU5KMFVyMC9HWmJJ?=
 =?utf-8?B?cVljT3JJYS9aUTMyckRmNUU2NzczRTl2bTA1NzJvVTVXZjBRdndobDd2Wisw?=
 =?utf-8?B?YjdCSzNMS0JNbHhlSWpHT3h2bEt3REpaak5iWkJwRjU2Qnp4N3J6TjMyZ3NH?=
 =?utf-8?B?WjM3S0NEWVlSR25rZkNzT3Fod2srUEFXYzlNNkR6RVZYM1NvUEtBUTJwWTRt?=
 =?utf-8?B?YjIzblZqTHd4Nm9xQUpDOERBRXVPYVlCWDFpTVFPejRaT3Y2eG9wQzVjYXIx?=
 =?utf-8?B?OVZxa24rbThMUmlDR09DQjViTWhwNUw2WTFMaW04QlBydjNnam1qQmxYaUVG?=
 =?utf-8?B?Vm9IOGowS2NZczFKRm9OanNRempLd21YeU5HS2hhdVVsSmNLc0luOWdtdTBZ?=
 =?utf-8?B?S25xRWF2MC94aVZZU2tMM0ZqcjI4ZFcrd25PUndCUWVvSjVQcXlnOW92ekdt?=
 =?utf-8?B?MDZ0REl0bEtQVmJPRFlPV0o4MWxoazF3b0VxVm0wNXcrelpITER0YkJBVmRp?=
 =?utf-8?B?OFdWT1hXdEFKSzdaMGdMQ011N2tGV3dlMTBZSGxTOWdUcTBucmJmS2Z0SDlM?=
 =?utf-8?B?eUNxS3A2d3IrS3ZrdHF0b2owUnJLaW9LUlJ6K1lTSENseFd2RWZHL2F3cHZ5?=
 =?utf-8?B?MXY1cXcyOVlQdlpWa3NNMCtMTDMySkNEMG9oOWI0cWthYUdkakJMOXJZWWhL?=
 =?utf-8?B?ZW10RktwQUNtaCtCOE55U3FLaGhDeXEzNXFzYUpLWXBvY3hFNFRwT1VhME1G?=
 =?utf-8?B?SjFkb2VpYy9oeGxPSzBvekxjSitPckxUbE8rYi9mR2ZBSDkvN0M3V0xUOFlq?=
 =?utf-8?B?ZStkQ2V3OXN0Mk92QVZkRWI0TGliNHg5WnVmc1AyQ1piR0RKR3puM204Z3NP?=
 =?utf-8?B?SU1WSkhOa1VQbUtrdlNwamRIUHE3WmFhUEpENEpOcnNrdFpiMUNxOTg2Z3J6?=
 =?utf-8?B?UjhsQnd6QUFSMWlTcnpWR2k2MmE0TXVqSGwwb1FHak1Jb2FzNU0zSGNQNWVW?=
 =?utf-8?B?ZDNpUDAzbDlYdXR6WFN2Uk1QMGQ3ZGJ5NWJtcjVoWjR1dlBYZ2MraXdJTHNa?=
 =?utf-8?B?THF6NkUzUnpIelZWWHkvczAxd0hLRnJaaEc5bFp4V3NsUHpmcTA3cEZKam8w?=
 =?utf-8?B?NWhYS1pndXNpZTAzY2pjT1k2emFUWFREOG1pY3cwc1pVUFQzUlBITW5qSDVu?=
 =?utf-8?B?TXdlMGVpOGlmYmNXOXJ6VFdTWFF0NjVOMnByQU5SZDM4bFAyY0NtWW93T1pU?=
 =?utf-8?B?YjJaMkltYW9DYUQvWHRKZ3dSWmZwOGxVSWg1V0RsaVdXTFlMK3JDNnpYeEEz?=
 =?utf-8?B?NG1TR1FZZGFuS3NPTUxqQTB2UUJnb1VBTU9leDdWeDhxMG13dS82enZSanpn?=
 =?utf-8?B?Nk9oenZyTis4NXJ1U3gwTVhuemJLaERxYlRHalpScHM5WFdnR0FOMkVYWkNR?=
 =?utf-8?B?cm1YSmxmZ0d4OWtYa2NaTWZUZk1vZ2t1bG9aRTlTWEx0bFpHTEk5ZnhxMkVH?=
 =?utf-8?B?U2I3Ry82U09RcnljSzRra0FHd1o5dHU3WjJTMEVlSWVpSVdhQ1NHZXRDTVp3?=
 =?utf-8?B?NDYvOUNUelZHejhnNlF1elNtdlpLb1VkOVJUQ0xoS3RlQmtJaStxRWdXL0Ux?=
 =?utf-8?B?VEUrcisyb1dPUW5ES1NzNHdhMTJBbmtyWjU2MTlrQkFzWDlBamVXa09sY2Ja?=
 =?utf-8?B?RndaN3kzUUx1bE5NalJmMjNXSk1wWCtMbk1CME5yWVU3SHpTcDVlVVc3SlpS?=
 =?utf-8?B?RGNNRmZZR2tCeUR5OEJXUXJHbzVLZFlVM1lRaUhzSkM1MVN4VTR5anE1MW9D?=
 =?utf-8?B?TDVNbC9jWWVsYkgzQWx2RDB4YWNteldiNHJCQ2NFWW5uUWlpRm5Da0xsakFO?=
 =?utf-8?B?bVhzMzlpSmN6Q093aDRNN3ozUVJZbUVTY3VxcWxyS0ZQYzBBVjJRbkNIYTJB?=
 =?utf-8?B?OGNRa2llT29VWkUwQmd6emR0akVVZUVLL0JyZU5iVXI4T1Raa1JZcjlzMnFM?=
 =?utf-8?Q?TZx9/LkjIYX26WDHPO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b24b5c-9ce0-4be4-5ca2-08df047a30aa
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:31:36.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+vPdUSI4O1n1z5S8m2IsIs/cT6PUrx7dw+sFmtKGxR5bFDEt8hk1SIpPb/GLR7g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839

> reset_method_store() in drivers/pci/pci-sysfs.c discovers supported reset
> methods by calling reset_fn(pdev, PCI_RESET_PROBE, ...) without holding a
> device_lock, since the probe path is expected to query the device's reset
> capability without changing device state.
> 
> However, pci_reset_bus_function() and __pci_dev_specific_reset() violate
> that contract after pci_dev_reset_iommu_prepare/done() were added, which
> moves the device into a blocking domain and abruptly aborts any in-flight
> DMA. Doing this for a probe -- a state-query call that does not even hold
> device_lock -- can cause driver timeouts and data loss on a DMAing device.
> 
> The peer reset helpers all handle this correctly: they short-circuit on a
> probe input before touching the IOMMU.
> 
> Skip pci_dev_reset_iommu_prepare()/_done() entirely when probe is set. The
> inner reset routines already implement their own probe semantics, and they
> perform the capability checks and return without changing device state.
> 
> Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a device")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee6154..01cf3105405614 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4946,10 +4946,12 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (bridge && pcie_is_cxl(bridge) && cxl_sbr_masked(bridge))
>  		return -ENOTTY;
>  
> -	rc = pci_dev_reset_iommu_prepare(dev);
> -	if (rc) {
> -		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
> -		return rc;
> +	if (!probe) {

Given this is using this funny enum:

 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false

Was the intention to also use it to sample probe? Bit confusing

The actual change looks fine:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
