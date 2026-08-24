Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2335D381EB8;
	Mon, 24 Aug 2026 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595213; cv=fail; b=iRkcPIFS80XafhUv08juI95SMAB0idln1+ZvQ2AwTwVl9gUYhrlDMqVTeqEDFJsbcnxSAYADoot7nhu949M92vFWLkIAfyKUdrMrficwMZi7hWZ0l+rphxYpfosSbqK+mCYyEkrvB6LNySNDqt6vSB7VO3hphcz+cxgLuLqaV2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595213; c=relaxed/simple;
	bh=Fbl6HCppck12NvUCWv+3IMevL1G4pGzgIA10fJk3I/Q=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=hYWqLGELI4ZptaXEM9sFxV/VTlhtALM/mJ1pHPDkpsHTXv7Zpc8rBD8Db7ce5KLimK7moQDYwgHZhhdzox7gHh9xuKK4zCwJ04ZKu2IecsKqSc4ZYGRFBVz9aS24N4eo5v08Fz/KAupWi9HyRN89m3nlhvPaOiZwxZLLaWO4iic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ne2TTN+H; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ne2TTN+H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OenLEerX9/IP8VFEiXK1ykx4sz5jRoJ1YylA17n7VN5e3Z13m41KAAcnFvXkSoRaU027MKlQnv/h49ApRPPPo7tXY1GDWvEJph1tYjJe4X7+LHJVY/zGMgoO55SEWRKf8bk46xszUbh6h0qQvCxboXq35mKTBeTz4NTaztgEbUdSubrE2wObNx6WQNfYnjQyYMIRXpkhQuvPHIWfx6UMTOYpIyE4FiJMd7aFOg+unDEdeK2Xy1sAR8MMXVELBu17Qp6VfpxY78o3dwXlSFvsN8yUCZRtuX9hAQTvGhPgGIwxeoF+hXLIhe9VETIISGAjmKIvHHSI6AHM5sl1EuuXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3Gd6usxmE3vLqxvU/lBjKz99Hb3ayDuRo7cReBGjwI=;
 b=ZfcqC/QzpLqSb66ssQ+DAZUuaMN6O2YqoMhomaxsEW8mtdQPsvxeGHmYDAWJeOPSVNqlTguTSt2SJSlaHxrKV88ZKV1jjYvbwagvP4Vf3lqXyhyMlyT+0/dlHkPUX1wmGI11dX3XNQvuubaZelJKTWgMzaHV73/umlgZ+WVPGdJCP3XdSkqffj506mt3sEaEZ20Mj85CU9jKKQgjMzRZCEZkQwMbV9Gfd97x+lA/2jEELF9W6n1HcTmXXNr91Z27cpkhDARMidGL91DY1uLCjglYTJy3hUmvio/KvgrLW2cfDzdS416khuJ5l+jJguM0YMNHTEFiJ5KLU9HH+msU9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3Gd6usxmE3vLqxvU/lBjKz99Hb3ayDuRo7cReBGjwI=;
 b=Ne2TTN+HdlI5cVL5zrRklDGDfd56PrtF8bySuxBJ5/5v3YRsTOu82zlWkhqC2//h7F836mUJX0OSI7AiJ+mOqkVqPA33RhgNon2pIKGWulSE1K7X1RJo3uvJOjecg/OKhT1Ds30FUg3Q99Lg8lma4hHp3aSRNa/9OmJkPbQySKTifEd795/MwjBoxFbi6+05mSb9e/9Ph8a19qGXeRM7yl4ArZBg2xnHOG9NnSr40ZOUsWG3jmiMHBLWwgXa8FnesBNBX0UfTAic0nCQAERjRPO7KVt/UT0ZQkxnEbGxXa/1dyK6nbWZkfcygroR94jhachTfDdBNnW1xYJtblcn2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 18:13:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 18:13:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 3/5] iommu/amd: Split probe error paths to preserve
 IRQ remapping
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
In-Reply-To: <20260824122347.1588592-4-praan@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-4-praan@google.com>
Date: Mon, 24 Aug 2026 15:13:21 -0300
Message-Id: <178759520117.3131778.6953869487486713121.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT3PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fee357-39d0-4f7f-819d-08df020b62ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cm7uEk2Dv7b3a78wO/+TyA6Jgv4/VN+zthEcm8LncYC/k+UqFZQYX5X9oluMLMe/ZfPmU794mK0Ub8RdiRllxPrfR5erpTE8DWMsmOTgJ+ogVY/+yhf2JJSLkbkSX9q6QJZR01aIMJZFmoix4VmmHtGVnvd9G9tIKFTtXCe8HsOcMfAtQ5NWLlMRSDKWyNP61fsbeoSIJvd1GWHkBlEJZ6pVqibwCVdvAoHkvIgEuu5zb75F1j21n5pf+gB7eigrHFyZv4H52q4nA4dE57c25HzYUew7ff81uB9QyjMRxxF0psbcQ1MxsbuHqXuWj3v3MMynOpvbFwm+H+fJESLQ9Ff7zIvu0E/+dpAQYgvi+EQS7y8JTSuRE1pZumvgis9nQI3k2lzXeO5o+GDZVNdBtesBdb5K7RX2mifhxngPjGuyR9dYz42yP8aHt2UAQNuX6fu7ljDMveRQlfWUP2poWSXmPXVfJFZhJtpNquxdBIq5JyvhIOYzEdxUXLjb4JCJrH6hox+tKmZ7eU2vl5WWrAWYGale6qADbz15NcxJ+Hc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVhNRTFsZWNxNU4wRkxQYXRJTzNRbE1TdXNwK21sSTRFY21RbWZScHpYcTVq?=
 =?utf-8?B?M24vUm5peExWTnR0a01JOFFqaE95d0I2dDUyMzdsdUV3SzFBZTErVmNhV0hK?=
 =?utf-8?B?aWgwL0ZKUEgvLzQzZ1M4dEVIRHBmcFlSbFVrOWtJOE8zMXRoTWhMczVlc0VF?=
 =?utf-8?B?aGVIeVB2SlhvSTlVSC84TmZNVGVyQkkzM3BYZm9na29JNVo4b0QyanFpMUVl?=
 =?utf-8?B?M3poVXM3TjMwOFZnT3ZvTTZpQ1doN3pkSU15YkhYNXRtdlJZV0hpSGRqcUF1?=
 =?utf-8?B?OTAxMnNudFU0S1VzWWhwaFlWYlFhbU1iUnJEMW13SXUzZ0hueisxeWNkNTVF?=
 =?utf-8?B?V0F6SzZBc2l1aGxId2UzMnFPenVwbTNqZjByKzZ4WnU4M0VEWmdkMWdRYWN4?=
 =?utf-8?B?Z3hEZkVxZ3M0WnRqSkplckZWeGJxbXpMZFZEYStMaVpmakVHQmpzVEVjTE9O?=
 =?utf-8?B?UHhoOFFONmpSUjlqVHpXSHV0Z3JWU2pOR29FVXhoQUNhZloyS3VXdHREMEt5?=
 =?utf-8?B?S2hVUUpxWmJKZ3hiL3psQ01ldFhWNW5QRDYrem9pb1NwMzlNV2JSWFFiU1lC?=
 =?utf-8?B?NFEwUDlPdXJHMEVST3NQbGJ2K0Y3cFFIbVViUE9lZU9qbGdnMWQvaVBJYmhm?=
 =?utf-8?B?SHpOUW9zSjd1YnhLQmNJRU5IK2pqNFQ0djBJSmhUNUZRTWtpZXQvVFZtSTk4?=
 =?utf-8?B?bkZLRGsrM3huN2Q3ZjRxckIyY2NQb1FQOWluVzh4SlUxdHlYc0d6YWRKQ3hF?=
 =?utf-8?B?VmtMbGVINmEybG1NVm12V214QXVwTE5oYW5kWisxdCt3MEdFVE9aTXB0cW1r?=
 =?utf-8?B?TEpJOEhJQ2t5WXpIdGtTUStoRitvZm5CU1hVdnhTQjZZTmRwNS9XWkJxT2Vi?=
 =?utf-8?B?bjlaZWNPWi9pNEx5N2l1RGFxZTRsSkR1SXN2VVFSMHVIczM0WUQ0YWc3TTFT?=
 =?utf-8?B?bnplc1FYWHFFNnRqOGxLWCtoNFkxbCtTZEVTRFdnWWNBaWorYWpvazd5K0lu?=
 =?utf-8?B?eFRPVGhlQ243aVlxTnhhRzBlUmFEcFdhR2ZZVVc3NmYrMXF5aVg1eDEyTk01?=
 =?utf-8?B?RTFWN3VocmsreGFaQ3lnZ0xSbS9TckpYTC93SlVRUHlJWFloc2NzR1J4Q0FX?=
 =?utf-8?B?c1FHb3drcmRuVlY5a1IzU0ZKaXVjK2dTVC82V0hiT3lSaHNXOUEwSE1SQXNj?=
 =?utf-8?B?NEhZbFBFNjVXRGs5TkRybDEzR3I1VDNselBXMVRHc0s1bS9hcDYvRE55Y1VZ?=
 =?utf-8?B?VkU5K2hZK2NwbzhIazY1WVNEMXVsSDhFZWhOWHR1UlVpdWMwK0dkYWUvMkkw?=
 =?utf-8?B?VWNsRFBwbXpIZGVsamhiNFlCZ0pkaUZMMytKeUkzMFlUcUwvWEhpanMwVXpH?=
 =?utf-8?B?dmhmcld0ZCtaT2VwWitTNW5PZ3A5UWt4NFpMNkhLZlc0SllZRnNvSVh6aXFs?=
 =?utf-8?B?YkNPQmV1VHBGYUIwcWZ3OTV4STVPY2tUVkE0Q0JtcWFadzJ5c0NxckpNb0Ir?=
 =?utf-8?B?aDZ2SU5vdzRKMFBDdkwrT1lwOUNRWVdBdTJTVEI5bGhpdTVVbE9Sb1dGMEFw?=
 =?utf-8?B?Kzl5bzU2cWRXak83YkVnOWpvZms2aEFPaFBnV0gvQUFQZzJtMHVNVkM1V3NP?=
 =?utf-8?B?eUNrZXhsN2hFM1EzV1RDRTRaRkhDNEpLTWhwa05ITndDVW0rTUtJNTliVllB?=
 =?utf-8?B?YVNQWXRha2tVNVdra3lTSHZrTkJLbzYzWGhhdnZDc1hDVGxvZ2diQzQ1QTdR?=
 =?utf-8?B?OUl3RHV6MVBUVk5mQ0xNTENoZlJpeEEyMm54b0o5N3FyOTJoZWRscElrc2dh?=
 =?utf-8?B?UUplK2taQ0xQbnNHRVcyY1JGc0J2TE51RnpPMjRaVHgra3MrVlRqcUxBMGt0?=
 =?utf-8?B?KzIzWHcwQXNrT3k3UUwwVUFMbjZYdE9pa3Q0MkpyZVBsTldFZzZIYVpFM0lI?=
 =?utf-8?B?T2plSlZjaXFtTU9QU3l6ZmNWTlQ4MVFudWpHN0d2eUhtb092SzhyUUdXS1NQ?=
 =?utf-8?B?aFNnTTBudy9CQkVRVTlXVEY2RUw0emw1ZnpsMGthVEZybHQ1M3l3SWpNOEdP?=
 =?utf-8?B?V0F2d1hNSU5IMCs0ZkowQWIrK2pRbndSNmVBcFd3TUNpWG5vKzdJV2JNcnUv?=
 =?utf-8?B?c1haSC8vVUZGTkNYMlRLWnYrQ3N4SUhOb0h1M3krNW8yY1ZqQVMwT0hMOWVN?=
 =?utf-8?B?NXc3bjhPTFdkQlRRaFppSVNaNTZRUTlWVFRxbUM2MmZ6VnNDR0dZaWpWL2NU?=
 =?utf-8?B?dHhXMHN3MjB0U0t5TWlHWE5nNjRzbnd5Q1dxOHFaVTJqdVFvYjBNWTBGZ3VP?=
 =?utf-8?Q?F1+doeQVF3hIjZPrG7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fee357-39d0-4f7f-819d-08df020b62ed
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 18:13:24.1736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MttxbSbROHsTcO11BmrFE09oPo41mFPjpRsHmWP/ukPJK9ERloLqxL3NDppgaDWH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258

> [ ... 15 lines skipped ... ]
> @@ -2540,8 +2540,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>  		ret = PTR_ERR(dev_data);
>  		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
>  		iommu_dev = ERR_PTR(ret);

I would drop this line and fix the return to have the ERR_PTR

> +err_deinit:
> +	iommu_disable_device(iommu, dev);
>  out_err:
>  	return iommu_dev;

Otherwise this landmine is going to hurt someday since there is only
one flow that would have an err ptr in iommu_dev.

-- 
Jason
