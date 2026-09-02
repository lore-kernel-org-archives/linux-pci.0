Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B033F8B2;
	Wed,  2 Sep 2026 02:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788315256; cv=fail; b=ZwnDFu7LIqD0hFTxeM3T7MTvSjrcCcvEg2egsSPowAqgG5KpGzRkPHx4EuJxez3687LtHcmprKDerOXv0lEY1pwB3YdWZuAdQ42nkAZ4jr0NNvLP4KUKei2wMDB81AC0CoSrX/ZWyuZTzo1k1Weim2GPGxho6DKdwtZGnonMc+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788315256; c=relaxed/simple;
	bh=rElRfm1TyCxTkpEIoCB+Qj68pvr7k8bbio0uJ7uddzU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TlfUo22spc+VN8bfCwovPGdxl5RRsGnmd0o9bnrKhubdL0low5xBm1VnJRHxEtDCkqcn99rXbaLbbCbHd++uUKDcXLKAhMhwxgjCL+/l9Vgm2kqPPtrZ8EYgQlNfyXEmrHULKzqhpI/TYKymxHiJ400wYuOCIOW0EY1XFkJITOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhc9uTMc; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhc9uTMc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOOw4cHGG4dadN9W+iqWZRIC4wsMwq28TEvoosRUwFL866gLoRseeuXnKjxzj2mE9SzDjZseu5MDiFtbMfz/0FVpvKr1o7dCRefx5RKLYapWqfXZLS49h8GBYJO1Va2OQD4nDpswNC8aAQyehxHKXn0VRNCp2lI4AFKuhhO7AsLd7zr/iLlGIKB6FcNYwYOJDeM2FDi79/vbtw2dUQ5MXSqqK+apFvePpqIUHdXaVIMJPZSDJQoxz0LbNdxI2I2yCGtqMqxiN3xxcOw7WPW/dqeNZb9O+CrXEtNcYjqnYBD31VLOqN2qyClKn716pVhBcIZUK3CGA4cW4jOgH/cxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8pFJuRNK2xTNopQn4MGkmDfH2QuetjLBiuz5so9+Y8=;
 b=vDl1QoTYk3hvvFLWgT3PDCXE4bpwCRQxoA1OB2ZiGxu9QdVY8ujR4bCw0h2/O2f4pUP8rRlkhhCgSmlBRxZDFlUjHXqTqreqlBhPnkbvLjXEKaYnfY7OVVrowTWF3MJr017/8VyRVDsJJi2OoZVg33wXdFF1VQwnw0XkJZyf3VWArBs3hpwqRgvOsi6GbEpHbClAafXdWUprpGF15qfdDAg/uNH2WtQGLxy+4VzVhLU06HJitCo+Vct4NuOTfZJOv3viHGWzikbQ91g+F1SUNzXLh9PnbKt9JQ5kkoRx2KEA0gC4JZjTQFXKpF+H7aNN5aRN7RgXOB1AzJ2wGmpJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8pFJuRNK2xTNopQn4MGkmDfH2QuetjLBiuz5so9+Y8=;
 b=qhc9uTMcIvYTeSU2EPJuKfTVyEgKPaP3aSmqqou0xb27Mez54HKgNRPHb03IrR0d20dDyh3Y5FIGMa6vQekezL3g5pJCGWkzqJ52i1QV/FuXLFwmDile9tCgqZQswJ7wgE95u6yPwzIwCcIAVsTgIKPOvfgrLrZ5cYiv+aeCfxQNPWErXRzQwsxDkEC9u+WtNexJNNp0TnH1DHfFcRNDmc2hjdZdaPVhmCHMn4HCCLD6Imddmr8c6V1pF7ywXXBwcS95YMdrsh1z9oz4PBUKwtPRHCc3pQFJ3kj/vIDJ+bAebA4CHkEuKSa3KlxGQgcijKXqxVGlaDDqQ1NDMG/r7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:14:10 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:14:10 +0000
Message-ID: <d064eedb-91be-4aa1-8212-c9b8faa27b72@nvidia.com>
Date: Tue, 1 Sep 2026 19:14:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/12] cxl: Cache endpoint decoder settings during PCI
 enumeration
To: Alison Schofield <alison.schofield@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-6-smadhavan@nvidia.com>
 <anKfz_QxEaTVNm1R@aschofie-mobl2.lan>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <anKfz_QxEaTVNm1R@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 405913c9-467f-4a28-cc5e-08df0897e006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|56012099006|6133799003|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	aX2leCJ4hxHqd9ySD5aHdG6I4BMGI+skirn6GWKRYq4j2idBwQxe10TR63AimcTey+Q3v3PYmGW4HEYN8NVF51PcJiJk+7AR73tLupoMelKlE5rPqZNIRT5mrMhu8JZ/mnKnazqZPQ6xAZeyFGcvQLvaGQLRHDqLbiFC9FjkpyXnI4YdOzHjorhl4Wt8T38PBcD8AHLVo2S9f6+H2jcQvpzwv/x3h7BVDvyq+9n0rwbnjMggI86kGpoI3qzoVJr65wEBDkIAVXJi98RiwGa8+4DrHuymp18Wn7RvMleDg/x6UkEPklm2xx84P7zfxcJIVNvU9NkIkzOH3KbzJ+HHJlMTFYadilrCnt7UI+MLwER0h0VYE37PysGMU7uSgaDPpvO6ge+1HV6DmP3zlupmIA92+SSYmqa9+veKF1HoSzGpAca48eMt9Ky1wEDBp4U35Sz7rSd8mHcO0Qvgwws2aK7tb5MNF8ja0YNDGf8f5Rq/ehxPvriZnQ3Ga5oMchPTz3/ix8rFbJGwopwifaRJX/MhEFK79i/Dj4YoS3GtQDARWVLffV2+2LY5XeQWlmmqqhVOqY2aiMiaaXDXt4v8tHCOcbi6idcyoYJO0T4xw8jJWQxR6G9bBnt5cv/U5iZTbaCr0j/LtaJfpdXfBZE4E33ysYYsaJjOVek8SbhFQSs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?andLNHdMUUp1QzMwZXA1MjB0T3psZ3ZrZjB0Z3piY2dxWE5uVkJHUFFISnVz?=
 =?utf-8?B?c2VKby9SNlFIc3YwUkQrOStSOW1NbFhLQzgwRm41bUhpbEFKM3R1ZHlrVCtE?=
 =?utf-8?B?NlhZU09sWkZJNktiSGFUL1RqaWFPamo1Z1pTaUd3S3FxUExpK0gvbGV4Kytl?=
 =?utf-8?B?TzlrdCttNnpSc2xSZWMyZFpKVmZ4cVlYQVlLeFJ4R3N0ZkwxQkVNSXlJZVZw?=
 =?utf-8?B?K2VKZnZ2Z0QyQjZ4Zy9VMG94d2dGQWVNTERJeGR2dUEzOXZRcXV1ZE51eHdW?=
 =?utf-8?B?VG5iT2Z0RlpHT0gzZ3JOelFWa01JSGk1SzQyZTdIOUxmR1ZXQjd1cHk3Ri9x?=
 =?utf-8?B?UFA2VWM1aU5mZmFZeEgwemo0bFpCMkEwNDdzRFJBa3lLdmtaV1pZdGhZdFFj?=
 =?utf-8?B?WkFuY1REbXZ0YnBqYVg0TFppYU5ocXl3a282enZxVlRYekxWbFdUQkdnT0gv?=
 =?utf-8?B?RlU0ZFhTcmw0WW5KcGdLRlJTdVVqR0FTa1V3UjN0YW5FcjBJQnZCWkdkTEhM?=
 =?utf-8?B?cWZsTDhJblUzSVJHQWRxZHBIL3VhZ3dOZnQ1ZDhrVVhBTkt3UElhdXRuZ3Y4?=
 =?utf-8?B?Zkp2Y2VkYllBZ1RSY2R4TUdOME9rSXVTM1RBdGdRZ1EzelVNRDEyUW1mWE15?=
 =?utf-8?B?ZTFBbkR1SGxuR0VJODR4SnBjYkUwcUxTU3UydXNnZm0vaTV5dU5XY0cxZWZp?=
 =?utf-8?B?MlN1dExJeDNEcU5JUEdkVG5qL3BLVXVaY2NUbEpQRjBiYWEreitScGFZQnpx?=
 =?utf-8?B?eXhFdCttOGhPNGdJaFpMdS96VXVtcHE5dkJnYmNjN3JkOWlsNEh2M0ZHdktO?=
 =?utf-8?B?NnhzQzdvMWpVYWdkbFRvS2N0U0FhWFowd3g0dmJKK2dNZDVKd3VubGRPdDhG?=
 =?utf-8?B?ZHRqc3RieHRGNDU3OXF4blJ2dVlXcGxVYUYvTGpZQkNTY1c1VXYxamhkYVlD?=
 =?utf-8?B?RmJkVG5HMGNmVWRaT0pBd2pmeFpQZ3J2Qnp0OVAwSGNuL2tOWkVLT0IzWDM4?=
 =?utf-8?B?OUxjRnhCQ1Q4S0MyL0RYOVdYckg3akNTQ1JJT0hVdW94MU1MSmcxc0ZLNWJx?=
 =?utf-8?B?Mnk1alg5Y2NSY0lDUmxZUUxGVHhZOVB3bjB3ZFpUd2VkTnN4WEhEWjliU3Ba?=
 =?utf-8?B?WHhKSGdSeUxEMjdUSy9QTmpaLzlZYkgyeHJkVVdVSjl5NldzS0ZGb3RZUEZQ?=
 =?utf-8?B?WTk2dEU1TU12Zk9PZERDYStETHljZHdieVVtQzZCcWJKYS9COTZEekdqL3JW?=
 =?utf-8?B?cmd4U0RGc2ZZWS85YWQyZ1lNbXZyTk5xUmU3Q2FDTXBEdWlTMDdmTmVTTis2?=
 =?utf-8?B?Tkk2WW00WUo1UnBCTDR0bWJxa0g4QXVvQ3YxcXZwZzFUeTVIYW9RN08xZCtt?=
 =?utf-8?B?c2FCdStHNGpDT0xqVGMxUmN1TlF1cUw0WE1jdSs1MUJacFdPZGlVN2lFb2k2?=
 =?utf-8?B?cnMyaEJPQ1JZVEkxSTVsb3B1UXhDNlczalBzZ3BIc2laL0ptRytubDc2OUxF?=
 =?utf-8?B?TEFudTBSYkl3cDZuU0pwdzBZaXd1dTBXeUpuZlFacTdGYzhINHFaYkVRZjVx?=
 =?utf-8?B?Wm1halBjZENQdDZwaEV0SHR4c1g0M2tHaFljTDJ3QUxvOE9iVHZOVUdlYitB?=
 =?utf-8?B?L1RBQSswSDhzK0pvN1lFa0lUR3N3WFUrcytLZXhQZ0k0bEpWa3NxYk1uYy9B?=
 =?utf-8?B?ckdpaUxxUWVza0ZIOGo2NWNhTW5sN0RvVG1tNWxwVnZCTDZjYlZSYzY3cGdy?=
 =?utf-8?B?ZGR2dWZNcklLd054OFdVbnhybm9TNEhZWTBycEcwRzhqWHNoOGw1di9acFEv?=
 =?utf-8?B?UXdMSzBjMzhjQUJYa1czcTdESFY4UFhGcWdMeVlCUmxCQkUzYy9mNUFuQjI3?=
 =?utf-8?B?eFhpczBMSk9aY0NyTGpEaUJjM1N0aHozU0RCaC95SXdadUJDUnd4MVJLWWxh?=
 =?utf-8?B?Z1NyVGFoSStsdFZPTjJ0UkduRk1VeXdJTE5tbzlSTnY3QWNSTHBDRGpSbnhH?=
 =?utf-8?B?dS85NWMzM0poNEtDL3pESFBKUGc2RndqcTR5ejdaV0N2dXk4b1E4MWFuTXA1?=
 =?utf-8?B?ek1sVkMrUG1LdmJMd1Nzc216NEhVVUthVkhoSk1VYUIxQTJaTzJpcE4rQldY?=
 =?utf-8?B?b0tNSXh5eFVTYUtYdjg5VkdVUGpnM0JOaCtrMVg5cTJlYmIvK0F4ZzFEQ0Fm?=
 =?utf-8?B?Y1ZIMkFERnlZNE4zRGNYNzRSbVhIY0V1R1pFL2o1S2RHaDBUdElqTnQxdnor?=
 =?utf-8?B?MU1TdWZrMXg5cXpwRlVJTVhEeEt2SWRaWHVieW5DWTgwTXNjTnR4VFhuM0sw?=
 =?utf-8?B?L010MGY3UHRkWDNGL24xNlVsNS9IWm1PY1g4N29xSDVObndCcEdSQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405913c9-467f-4a28-cc5e-08df0897e006
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:14:10.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLe0e21k6FvY9S3kXcWv5jicvSJAr53InT8cZ40f9/0/CBFBAMAoWnVffHzdUb80kjBE9eMi/MGFJ41xoitBjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017

On 8/4/26 7:28 PM, Alison Schofield wrote:
> snip
>> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> snip
>> +void pci_cxl_hdm_init(struct pci_dev *pdev)
>> +{
>> +     int rc;
>> +
>> +     rc = __pci_cxl_hdm_init(pdev);
>> +     if (rc && rc != -ENOTTY && rc != -ENODEV)
>> +             pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
>> +}
> Needs: EXPORT_SYMBOL_FOR_MODULES(pci_cxl_hdm_init, "cxl_core");
> 
> Without that the modular build fails, CONFIG_CXL_BUS=m
>          ERROR: modpost: "pci_cxl_hdm_init" [drivers/cxl/core/cxl_core.ko] undefined!
> 
> To catch this: build with CONFIG_CXL_BUS=m, not =y.
> With =y, hdm.o and resource.o both land in vmlinux so the reference
> resolves at link time and the missing export is invisible.
> 
> This failure masked the first one because modpost aborts before
> Module.symvers is written, reads a stale Module.symvers and
> make some erroneous complaints.
> 
> And, FWIW, with this and the mock Kbuild fixup in Patch 1, the
> series passes the CXL unit tests.
> 
> -- Alison

Thank you. Fixed this in v11 by exporting pci_cxl_hdm_init() for 
cxl_core. I also tested with CONFIG_CXL_BUS=m and verified both make 
vmlinux modules and make M=tools/testing/cxl/ pass.

-- 
Regards,
Srirangan
