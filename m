Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012036.outbound.protection.outlook.com [40.107.200.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17457455612;
	Thu,  1 Oct 2026 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894802; cv=fail; b=QbANDcGJPuOz8y/RPBQaec3RieiGgHd/apXNJ0Y26Lpj1fkgST5ADeUetmK/9baWXf+ifW4RGyreCaFpixb4TxdMpEaXRktI85eaC3K63Wtm0Da39jdpmgJpi3BzbQM7y8+sZR4VYScsWuykvtFoRLbgFhx601UnrIlKnrgUtig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894802; c=relaxed/simple;
	bh=jiBvmZa5++dGzcwZTNZ9IQzLfHn0kZQ8/VXqTSTtvKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gSUCEMAkg6IcxuZCzXpxe2A/D/JBN7XC8RMn8eEhP4RJcmt+rK3Tg8WvNRvKTvNt/vP0rlLWIfWDCP0xru7E6Lk8WR6L55tCWZk0BvvPO5FMW5PtlpAXqC8IG28yroRmTQfBMecTThYkZ8zGtPurSu8WrArrlnOEkz0SHya8Zsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=agiKVKGh; arc=fail smtp.client-ip=40.107.200.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="agiKVKGh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+7eidLFJnG2//Z944MoVsVZpr5iw1oNv9hrvI49bPD+LkCBvTUVEqvWXtg3QxC0ZoKlEXa2vjAr5K2amM9g+7Xi3F2JjyonXexbcGWnUT4ry6uNxGXJoVDQzHK/vUvQWcdyF/22xhtHHPYHwDdPqVHYfpOK7QCTH3wmITTrzA72o2ER8vtBMi3pLStJ3QRik4OicE9hkA9tky5n2JuaCNwR06taqMMoO+4p9BkAwYM3bX4DR1EfuT5w3xwEN3RhrScVtmt7FmqgR+g/IP+6EdcGAb4zMP4e5MG4JDRc9O0ELCNnIao3fT2I9Pvpnu4hHe/vTmjpgalh/XgU5GpbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aigiqBEHn1jMhclfyWU9m5d3Lo5gXCXJIHNZOUdIE2I=;
 b=eSmjjGnsoKJkN4dX4o1VryxrTBxYkge1QbBFXFZgrFiRvjQcz/v2UOVab5CKKvLe6OtXHbsSNR0dezj4lLd3hMnGBSE0dGx9+Ft9iC1QO4NGNWyXfA1IrcMwOu6Pq9HGNtBAcJRv5OWDugR81MQqHDoZkonZX0FWPzTCBVO80YNSkHKhtwFZbEjuZ9jH13MYwpA5yHzi1pul2jcgbONBFrgjeXPfG9tJRHTQfTAD4myc4kLpzms79KgIncmSNmathbq6WXpwetSV2kTdO3FrsgC1gNkb4u/fqgxhfW4Fs2/h1L5/mpFxgA7xDoIp8P3ogCMGyfPkIEyQFTJAuW0haA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aigiqBEHn1jMhclfyWU9m5d3Lo5gXCXJIHNZOUdIE2I=;
 b=agiKVKGhmrwF8jHXhAUaAUfDGekdTmdFoci32CbQUvIVl8I/u2bfxx63kMb/vYiALO/5ukwyU0v6w7ccFYTiRT9PTeg1j0ppeaW9KBARBUeWpdz5gjhejX85ORnrGaERvTxfCS+yI5qcs+PUpNjIvGjEkhYVUmQP+axfGJOPoZ31EjS40M5k5Zo2vOWyzxjITaVGsrnjKUGTAIeak7W22tIFsSjokBPch7lHDYpOuL2BIy/ti8WrqyqrzsiKAuWgWfGRCPgY6PD9LnbouB8YC1uJqSvwx5Eh+JX622lBgzCo1RUGj2Jk/EnAsXV2Cac6WGrKIl5oWhZVUJ77tcU/4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV8PR12MB9450.namprd12.prod.outlook.com
 (2603:10b6:408:202::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 22:46:37 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 22:46:37 +0000
Message-ID: <6148cc3a-edff-4693-89d1-92331cd7e78d@nvidia.com>
Date: Thu, 1 Oct 2026 15:46:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 06/15] cxl: Make HDM reset helpers available to
 built-in PCI code
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-7-smadhavan@nvidia.com>
 <6dc03976-faa8-49cb-9b74-680e957f2f9e@amd.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <6dc03976-faa8-49cb-9b74-680e957f2f9e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::29) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: bc01d5f6-5483-4e5f-ad4b-08df200dda09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|10067099003|4143699003|18002099003|56012099006|11063799006|921020|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IVlyajjh+t23jfFyHbtApYdsKgPHMz7qycTAGA0YsLvpJ7vTXmMCml3WErefw2V/50knnIy48bmM5b+2Z3u6uZoYXR63UKMVcrmpKhTiI0ncGU6OcFUI9HiJ5e9SaEp/nBvQhd11c56mjXcgSnCbbYqUlTUTlhbKmW+/EHv4ptCZSvwXvcSEQ8MA9t7slSuvs+Lx004Ephwzd1WIpIiirmvNv26al9ILePdc557xEAZ9daCry5HXvVf9awIkVVRigVCphGtWLsbtPjshrGQw646Rn2ooFGAONskJAXOQYsZ9zCL8UCaQfVJ+WLutu7qOn7DMbIR6Bq2DNKy04Mz1ylIzVa0DZ0iR9qq+naKeur5XDJqNpOJGQ6WixO4T21TeNsheUlD+G3SYVyS4Fde8Kkd5pQQAu7awwsBOHkQ1NjeRODZ9/rzBndMeSMYajecxR+yrca+PUDroO8nKu86FsgYS5PHxFc2+fsKzPiwrkKdtNmhCecLMWdL+giXHf3dSZcxHYft+T8+MaTJv5xnqVPuTrbTckhHSKsbRPpgUVZBuZzrKIg4dEgENOmhcJsWDMdPoJn7i3aehdaCcAb3VdJ6XvrxAUmVNqvROUnqEKsyvXdWZtG4ULknwaz5TadlCYQ7/xw7UfWEr3pb3SwdU73RhnCJUC9Q8McYFHNbnOuQMIckmuifm1HowY+6/cs0adXtyDBcGaIJum8rtL7uWQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(10067099003)(4143699003)(18002099003)(56012099006)(11063799006)(921020)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkljOFJHcTFuWWFTWXFBMjZ4NWxFanRjaFppcGdncEJBUnlSaW9qbmVOL0FP?=
 =?utf-8?B?bG9xUVJqV01IREF1SERRR3dJcUxiMmdZNnY2MklBY3Nud3QrK2R5WkczaEJH?=
 =?utf-8?B?bFVKeDdkZVNYTHZGMW1nVitKZTU4YTQxckVkMDdMb2cxNDF0ZjgvSnVsQS9P?=
 =?utf-8?B?T1NJRkQ4Q1pvT0JuVXcwY2V0VVUwTzhld1ZVS1hkSThjQVc3WXlGaTRjZktT?=
 =?utf-8?B?S1g1cE1rTllZS0dXSjhQbjR2V1J4aXBDSXJoVDB5OWtyalJ0RTV2NWQ2MEpu?=
 =?utf-8?B?b2VkZUgrYVlIbXFxWGlYcGlHeUtua0svOUZXSHZVQW96S3dJNnIxVXEybzhm?=
 =?utf-8?B?ZVA3TWRPcytqQXNkdngwcUZESjVnLzlCYnJ2Q3NWcXllaXZpWkpqaVNldnAw?=
 =?utf-8?B?NnJCanFNcUVXOFFCelhXcW9oaDZnVEJlV3laa3VBc1lndk1sbHB4aFNJZzBG?=
 =?utf-8?B?NnIzcEszTnFQUG40d2Z2QWlNVVJtZWlMK2VEcWtmUk5INXQyYU12d3E2VURm?=
 =?utf-8?B?Um1UeUl5U1Z0TDFXSDVTV1dwblVqTzVGK0JZVkhkRzdLWnJPT09vQjZLQnBn?=
 =?utf-8?B?M1M4bmNYREZ1Q1RsMnU4TWlpMHlMbWNEWHFUVmlENHRvVDRJczV5MWo5SFFh?=
 =?utf-8?B?RGxWZlNSMkwyN3FkNzVLd21FL04vaUdXTXl1Tll2eFN2RFp6eDNQcUkwQjNw?=
 =?utf-8?B?d1VPekpKOElWc3VEbHZ4ZEswRjV5ZkJtSVhRRUZ6ZFpWc0gzdGd1SzZWYWtP?=
 =?utf-8?B?dU15dTZsWTd1dHJDdTNHL1czeE95NzZCc1VxbVJXbkJFMWNDNHhINnVON05w?=
 =?utf-8?B?eUhIT21TLzVKUG9PajNWOVRQQjBibGNTdy9FSmFuSDd1cHUvc3NaV1A3OU9T?=
 =?utf-8?B?OEFtRnVKVVJsWGJITzhrTHpMd1B2Vjkzd2QrS2ptVW1qd3JVb0JSQW4xbnVI?=
 =?utf-8?B?TjMyNnZvL1UvcEpKeTdjZ0cvaTEzYnJjWkZvZ2JoSFAyOHJlNjRmUWNDUG9p?=
 =?utf-8?B?NEtDVnhNekM0UElIMzNTVm04d3NoMkRkZ2R3SmZCRGVMK29uQklRUHJPejFr?=
 =?utf-8?B?MDFSR0tSeGtxci9KL0F6MTBERVBJdU02ek5PRXVrNWhFbWNlVkZHUkRQNXdE?=
 =?utf-8?B?c21uZDMzUUpnWk9Yd1EweEJXUDNTYUw3d2YvMUVRWGN0aEdiZGZWNWRhRjU2?=
 =?utf-8?B?d3NxWVFnYUtFa0diRzU1TWxvUGpOVWVZbWFUNzhsdmwrdkRjMFpXSy84eGpR?=
 =?utf-8?B?Vzk1ODc3WVJIREJvNDBZdzU5U21PVCtkMmswNnFWVG9iZ2ltS0FWSTA0NU5k?=
 =?utf-8?B?MFBiUGFoU0FYSUhrcVA5UWVCbTJKbmZEOUxUb0UvbDltMXNmTE9VTDRpbm5U?=
 =?utf-8?B?bldaNzdFYTVCbXY2R3huZFN4R1E2Qk5INTRtcnFGaUNBYnMrRVlCQUFzR2l0?=
 =?utf-8?B?VGQ1NUhwbmhxOTZSSjhJR3RDT0c1YnNKMmd5d1hPbWdEbXRIT3pDWDlKUm1m?=
 =?utf-8?B?ckVGUTk2NzlldkxjU2tDN0diRkhWajZzdGpla0g1Vkx5Z2MzZi9kSXBaTytq?=
 =?utf-8?B?Q1h5M0RIV3RZeE5yNmFZS1lZRjlGRWFCZjhFVDJCVXVWaHhRUEMrQ2VFTmM4?=
 =?utf-8?B?RW5XTUYyZGl6YTZ2c2pidWlyM2F6MFBBWFkvYVZOb1kwcmJZb0FEd3U3MFBt?=
 =?utf-8?B?clNCV2FSVWRCMnBPbWlUQ2IrSTR2UWptUW1rUlZhRDlKYlFKR3h6N3ZIUG8x?=
 =?utf-8?B?bGlVU0plOHhwb1RXUlduNFRnNDlVbFdneTZrWFZxQi9YbFc0eTNyMGJXVWdB?=
 =?utf-8?B?YmxlUHpOWElGUUtXcm5iSDc3TThZM2FwTUl4OG90R0hXU0loNFFnMDFvSktk?=
 =?utf-8?B?R1lDUWI4bmJJWlhNVFMxQklpaDZndVNiTjhYbDZuQnRZYmMyeVdGb21tTGY4?=
 =?utf-8?B?eUlGb2NQZW9VeVZBL0lCVlVhRUpkNVVDNmU2Z2hQajlVN0FoOXBKUmZ1RWUx?=
 =?utf-8?B?QmNldnFjaks2M0JFeThuYlEzNm9LOGZXQ0xtTDlsS3d3aEI4VXVrNEtmOW9T?=
 =?utf-8?B?dWs4dmJmSnk1SUdWdGVjUUNRRDQ3ZXV2ZUNkeDBwYUdTMXh0eU80T0NkOFJT?=
 =?utf-8?B?a3k2N3hQbnA2VTN6dFlZZ1ZqRlRZRzVJTHFwL0Z0M1JCdm5HdFhHZXljMUdh?=
 =?utf-8?B?ejZNbHN2UEh4aDIvT0Y1N3RLc2pQKytGNVN3RTZDOStLelQ1RThoQkFNSURR?=
 =?utf-8?B?bTRsQ3JwYzQwY2FJbERMSWd3aWxiNmdlNDl2NkI3R1lONlJzWmI2YzhVZXlz?=
 =?utf-8?B?bzgra1ZFSFFCWkNwUXkvdWNJUmJhREhaSzdnbnhzT2xJK2hORHhtUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc01d5f6-5483-4e5f-ad4b-08df200dda09
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 22:46:37.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbb6XvFBOCv4ZzIH2oVhYzehK4QSohFFEFez/GD4Ucg2jgzFk0mo4Zfe9nPA7YgBhFMUde/dJgWoizH0ShRN2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450

On 9/23/26 2:40 PM, Cheatham, Benjamin wrote:
>> PCI can be built in while CXL_BUS is modular, so PCI reset code cannot
>> depend on helpers provided by the cxl_core module.
>>
>> Build the HDM resource helpers under CONFIG_CXL_RESET and restrict their
>> exports to cxl_core.
>>
> I think you should squash this patch into 3/15. Having this earlier does two things:
> 1) it makes it more clear why you're moving everything earlier in the set, and 2)
> bisects across the pass 3 patches will all result in the same configuration.
> 
> An alternative option would be to refactor the preceding 3 patches in-place and then
> move all of the helpers to this file in this patch, either would work.

I took your alternative in v14: patches 3–5 keep the helpers in hdm.c 
while refactoring them, and patch 6 moves them to resource.c together 
with the CONFIG_CXL_RESET build change. Also eliminated intermediate 
add/remove of resource.o from cxl_core-y.

-- 
Regards,
Srirangan
