Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5C57C9F;
	Thu, 27 Aug 2026 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787862712; cv=fail; b=XJrgYFTKjq04RyJJUeQPafdLxMealw1d+iMWspct4L081WxlpJY8lF10P/h++YHl/OM3y7ayAqyyL1d07DkpDfrzpbUVLxOtBVmWJSBYh5JtoS7pz3Mhzn2MgCTBwi2xxneL/7EHrJTA9bUIvkOiAAEq1Qarxok8RKsSIbNiByA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787862712; c=relaxed/simple;
	bh=+01EsLCuDOmfR43yclJja9aty4cvYy0Erf3Qg8dQV0U=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=KJoiNiIpedZR2tx5V3raW/sLDUFb4y/qSim9zkYIPmmsj3N6A470gwiyPpTFbj/c6Ja1v0YaoAcDNsoKiAjHoqEcuWk7fI4dvT28w6fXrzp33w3UOC23v15qq94/g2KJuJdMyvGoM4xrxBnWl4oc7Gepd2xxWT+dvNhvKYaf+ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J8Ai5ruZ; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J8Ai5ruZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nH600IbS27q3Du37mMvwzMttMPgR9Hrtmq7H0GokXrf2V9COsVlJHErAtQJji1sA6sVjc0dqe1XncWOJ8muRPC88S66TbUVlXWWuejvUvlu83lnz9/IQt2FPCpO6cZhuEdVfQICfVFOWteJjxUoPOS9tOZOyLjA+7wc2JTNOyq02AwkcEC8MGg5uYE1uKF8BEIdHXXthJRlApn+rufxu0VeLwzfNPc5T4ZqkJAFtBpEaPaZNmnldzaZzJ+E+i6l4zxpAEZMVq6Zp6PXJDTqgF8GlkqOaymFxQ+cwWoxZEjVtH+xNHAX3ZZTfSPUmNr0GPtDCuqSHF8ApJo+51KqFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63aJYhtp/sCPXuE+IaFJCw2afa/vPx6sj1s0Xm3OpfU=;
 b=PXC2x/Tsc5aA+UTdId7Jnl7a19yjuCsU+Thzh3hemWF3pZj5AGYDcouE19UPC1gFDwz5HUWNgATebsENyiWuSPrma6zj/fBdNNOfHxc/QUKVrzf8GaeWkAwsKpewDgVRsfDh/DzE22NoXXtq8V1DREmMzZtA+eSI9/q4m2cWXBNAAMvxIsSjmAtbwYYJrYinDfoCPLS8kFeicBHyZSYRqeyDdjrXJwNM1Wkfz4h+Y9cjCAvQT5alGwc1MObySjfEfnaniuVvjWzKTt9+L6dPAJ8YRTJ0H5MEsH2ldxZmBvBhzGjOIapxHc+/FDARTEW7aLSpr508UJidLRU6nJedBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63aJYhtp/sCPXuE+IaFJCw2afa/vPx6sj1s0Xm3OpfU=;
 b=J8Ai5ruZjSYj+scFzxz4zGQv3rhPOAxwVi4ARwe1Okma268rOvV9nnEd5F7M6aZ0xaNZuWlghB8tBBY+/7jme16SxrcWEBgELwVXxvARImngoBBqPdy/BYekGCi02t3ppugtmPD20HS/0A1aj/t58iTjNRi5ZyiqxfC/g7fJ7VrnIFDu1tUujWLv9RVSUUOrxwbIKyMW+vTDulrTudshmDye1lMCSbYN5af/9dzRc0ZY4/31I61aui3jDJK93z8o2r0gMWRIxcUXfl0blmMeZvl3rjttWhG8D3xeKmDI8dwTsCoutqtsGlEcK5HDyHhc7x3NuruuBokK8MxumBQ1NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 27 Aug
 2026 20:31:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 20:31:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 02/18] PCI/CXL: Probe the underlying bus reset in
 cxl_reset_bus_function()
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
In-Reply-To: <eb77bc0422c77158f48f370c3f7c1b937c319894.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <eb77bc0422c77158f48f370c3f7c1b937c319894.1783044582.git.nicolinc@nvidia.com>
Date: Thu, 27 Aug 2026 17:31:31 -0300
Message-Id: <178786269177.3808739.5968833634148757858.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0315.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e10be46-c52e-41ce-c3fc-08df047a2ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|366016|10067099003|4143699003|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	4EsEVEZUVMVDMKVsNd1FhPmioq4kCU1DxITGNQdC8e6J4kXBx5848HYFSwJlHFF15lp69Oap62dtrZBtgze6H7cSIUgCH2xRAgGHHIY3+FiB5e3barOmZ5yEhmqEWHdGppL8W0c07/YKcNgCxH06svFfOFZ2ain5dgXjO+gJxoIngPn4Ovkx3hsAYpgSJ6YlaEmqfcVMXSu8aoirRpjUIxjTFFfcLdlF0lhTqbHDF70POTy4cmDcfCmYbaXW1zg/mGSKmXkKoXWTNCltoFbaCapO/5Fqf0J/UAVxmykxBt3BQY5qUky5iu1Wg8A33v8Rqyg9+hZG8G8YS59pnI676xHtFtEqq1KuT8Cz5c+twM1CMUAatX6HOXjYTdnlCxRkj9uNi66DgWv3DVwicQgEfXpkd/qaDmttKjQPycQgl/dIVREK9uvqvUdM2qENi0ZRr6Ic4vI1o/EX3vQOHD/60fPff6M2gxAD1Zf03AvGCV6KGKZc6KJLJWgHx+hgcbcNWQg89uCGQwMNd2f/r19KFmDQOOHNV420kW+aHpQd0EYReC5sxyxt+nphOHMiSy83YgzNoiNMstwzDzItgq7Bl0xWP6ktbHD4TGzUPnoG4ZEfn113oSCqCkMlQTxsk0BoNTebOMs++Ii4Gik6AJVCaVrRbSyu+avo58dJYiCvdkc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(366016)(10067099003)(4143699003)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0F6V1docFV0TFphVEM4N3dya3F4NG1VNlhrQXpieTlmN0NBQVp6Q3MvRzRL?=
 =?utf-8?B?NWpvRXc1dXNQWTBjeXhwbUhUZk81UU1ONE5MU3FHNXZHTTRJWk1qWjVjUFNl?=
 =?utf-8?B?bTRyanoxOUtCUG9kWjJoeXRCMTlVcE05N2tJUU4rQ3NVNVp1eVRLRG9QUjJZ?=
 =?utf-8?B?ZnJUczc3U2hlUHZpVDJ2VzBzdW0xeVVQdytPZjA3YUZkcGRsUzNQci9SY05i?=
 =?utf-8?B?OENGUGpPYUVlcDdGdnBLb0VXcEpBdWgrbkg4K2xPaWtvREtSbUpoRzdscmtj?=
 =?utf-8?B?YkEvbWFGbUsrTHlzSEthWENROFJrQ1JZb3FvMkkwM0p0TURaZ0l3Vy9BMzdB?=
 =?utf-8?B?eXFGNGMrN3M3T1UwYVlVZmJ6M3g3SWNJa3puZlJlSFZNQlJYVjcyQzR6MUxL?=
 =?utf-8?B?S3pwUXNuUStqYXdYdjUxT0lVVVFuaU50WEs3SEdBR1BjVzlqVDQvOWNyS3d2?=
 =?utf-8?B?dTlIY21scy9yK0J5OVozRjVUaDBBYkFQS1lmMTBpZTlJc0NJVEtoRUVSYVJJ?=
 =?utf-8?B?SUhSOGFIellWZXpOTXBaV3N1SE0rTkcyZ2tTTmpZckZDeUJzNG5QSVRYWlZn?=
 =?utf-8?B?M3pjVHVvQkEvSHR3K3hULzUrWFZNRkJQejdTMzU0Mm9hMk5Qd3drNEtSSWFT?=
 =?utf-8?B?Ti9xSDRZL2tQTk83VkhqQVFKUWJjS0JLNlB2cURIOVgzR1ZtWUhhd3Y4YW9I?=
 =?utf-8?B?VXQ1aE9oeTVzUnJWVWNFdnBSMkFSa1ByblZnbWtIaFhUREZNRGRFclpRNVpV?=
 =?utf-8?B?aGM1R1VVRW5rYjhOWFlGcEtkbnNJN3dVR2Z3NVI1OVdHeElJU2lYcHBkdm44?=
 =?utf-8?B?eG1wS0NqMFlpaTNqai9NdUZFejVWZGdlbEdrVXlqZkRQbGRvcGlwUVZpVXNE?=
 =?utf-8?B?citmdFQ1bzhxTlNOYnlLZ0hWQzZzVnkrT2RMS0t3dS9uSjFhRzB4VWdzTElR?=
 =?utf-8?B?cDc1Rkh2Q2l1MTgrRHAvZlVPaWJ1QTFUNFNlR3pkaXBHZHRoa2xRb0RaazJK?=
 =?utf-8?B?dXhjZkNFRWNaUmcvY0FZQ1pwQ3FyNjRNVlEwYXlpSHlsSGxNMEU4dG42TmNy?=
 =?utf-8?B?Q01qSGdwT0NReGlGN2VOSlRTRVNYYW42UWpoNDc0Tkk0c3BJZ0QzTDg4dzJO?=
 =?utf-8?B?WUVyWGpEMFFmZmdEdEdaNFNzeExCRnBlZ3NFRVN6UjlLbE1uUHQ4TENUa1ly?=
 =?utf-8?B?cEw2aXlmaWlOb255K0VzMU91OXdMRmc2L3Nocmt4eWlvRFF0L3dXaWt3K212?=
 =?utf-8?B?YlVDamRyTnovQ213NHY2Y2pUSFdlNjJBUnJESzZONWxCbnRNM1ZKZWFlWFQw?=
 =?utf-8?B?c1M4QUhnenQ4TDJFd3E3NUEvU2ptVk1DYkczWUJ3Z0Evb0hrbWk5RUR1Tzl3?=
 =?utf-8?B?SjFPL3JyWnYyaFp4a0FqZjhrb0NjcVFOVm5PK0RCSVE5b2RPaVhjWldBdU5m?=
 =?utf-8?B?L1pScjF1bXJSbzJKeUNEcnM5a1paaXI3Umd2Q3BDQXAxR1gwemZYdmZtOU4y?=
 =?utf-8?B?NDBZajRuR3lwT3dOOGNFa2cxMnJQOXFOeE1jZ3RLbVU5Qmc1Tko5eEt2L1JV?=
 =?utf-8?B?VGZTQ1NjdFYxaG5ieHFuL3hiWm9uc0xveG15MVJVeDMvcnFoZkJjdk0xKy9v?=
 =?utf-8?B?dE01eDI4eU81OExjMkFwbjZRYzVSc1owVGlNM3oreWNOOVNmRDY0ZG9sczdz?=
 =?utf-8?B?aGJITk93azE1VURWV1JmK3BYMG1hRkQxc3JpRjBQZ3JyK1NYVEJZN2lOd3hl?=
 =?utf-8?B?b3ZXTCtVcXYyb284ZUxpZXpxTWNYbzJrRmFra2tCYjB0VnVONldENWlFUHJq?=
 =?utf-8?B?NHgzMmd5OHVENS9FL2d3MUxyZ1czRDN6NDZReHdGbHAzbmwvbzBtS3BUcDdC?=
 =?utf-8?B?Y3hFai9SQUpCKytlTTBwWUdwdU9TdUtINHh0eitGekY1aUN2WFNrVG1hbW50?=
 =?utf-8?B?eHZpa0crYTFBVjV1VFFGeEFOb2NxaHI4a3QxVVE0cVp0KzJpejlpZDAzMDVH?=
 =?utf-8?B?dG1NOUdiM1NDQ2E3Rkw3Y2QvVDNkcmc4YTNxT3p2QkRKOTFkQUtBYTRKamxB?=
 =?utf-8?B?UlVlL2tyamJaV3psU0piNEhzUTVSUHF5OHRKS2w4QjFOVjJ0MUFwVEUvL2hr?=
 =?utf-8?B?R1pwaEtBbnAvcjZvcFBGNzAyNXFIYVdqS0F1NGlHcFh6cElUcEhpeFNxa2hE?=
 =?utf-8?B?ZlR3bnpXMjg1Qk5zblVZa2NJYjRZOGhvN21oeDlRd3Q2R2Z3VXM3NkhTVEFq?=
 =?utf-8?B?YXdIaHpKdGgvZURRbXhlZUFhYVJxOFlxNDZoYnJGOFdXYnI0eStFNWlNK1JU?=
 =?utf-8?Q?TQfnJh9eQyINNmmXBz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e10be46-c52e-41ce-c3fc-08df047a2ff1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:31:34.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwRoTG2CMkvTjySxQZ/O2YkMxszhaQ2j9cgVWXv5fjlOJqHugt8a8SR5Jogi2Afd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839

> [ ... 27 lines skipped ... ]
> @@ -4979,8 +4979,16 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (!dvsec)
>  		return -ENOTTY;
>  
> -	if (probe)
> -		return 0;
> +	/*
> +	 * Do not probe via pci_reset_bus_function(), which would reject a
> +	 * masked SBR that the do-reset path below unmasks before resetting.
> +	 */
> +	if (probe) {
> +		rc = pci_dev_reset_slot_function(dev, PCI_RESET_PROBE);
> +		if (rc != -ENOTTY)
> +			return rc;
> +		return pci_parent_bus_reset(dev, PCI_RESET_PROBE);
> +	}

Why not put this a little lower after the:

>
>  	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
>  	if (rc)

?

-- 
Jason
