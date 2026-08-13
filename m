Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266E640D582;
	Thu, 13 Aug 2026 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613780; cv=fail; b=PiTmL4V3eaW75liLoJK8ni0dQsBxsBA+XeyERHDkairhc6zscg1PBmd0uFoE1zNidJou8A1Xjj47PXdNVMpESeCU/Udf3joMuY5vQ+67YkIK/0RY1te7nlXWSVZCUT/xdwAFFVbzdDWo8ec4fr9XNG/uaXFuFJzVQFPN7VdXFac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613780; c=relaxed/simple;
	bh=u1ZKbWLciE6W9dZh9mwTO0y41FsMXcf3qh7ShMFdzc0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GDt4o+jn/vWxXF/fVKnXCR45XyK/3RfZTfEOu1YvOOjwf5RyLrTCtCN0at3cNXKeProOuz8c7KXsaJjmt17kB4ZzFvoLCZS6I7pqfj0OGuT9ztV2wNkrKCbF+ElUghc5pqURrJ+qs++Uc/BcdLQPAV/T1GO/kdPBhR2YTBqg2Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I4mXBLmK; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I4mXBLmK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZlI8XJux06fORpzNOQdTp5yRerv/Uthp4XLt93L3f4gjyehBTfNJAKx2D/65WY6w61WrYd9WXdDemxQ1dO4Mx9qkB/6vFICo7ngKUdqtADLWjY3bPTPoorQSzpww+Io3BROsIkjiowYwGcAZcWXg/BFAp/2BpvnlLGpg05zDLXpKiOAUwUQv+x6axQorZZy4ygG2W1OdJG3bn1Q1ooyF5wBXnkKdix3P7FVewYYmX4rfASYdgPHW9Y4jnOkmYmnmlzu3D1He9qXRDREH0ZyviI7vo8nbIrhm1RVykV38Na5xgP3+c5tfb+394ZE4YjO+LdZ7W2iB3t8lxoHDFQ/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0a+t3lq42HPz95ciUnDvh6a981GV5pg5c7i6AqJmIOg=;
 b=oVs42QFR+naKKVj3phf/zIRiyRW1z+yUEhlOrV8Pq1/EHwAuLJE52fpl6R6WD7FnY+8vzCF8NAwcNSd6UPEWroEocNqszHxZtEG9PfRxvxZ2jJvuCEqvjxyQo6EPkfgl7Gz/pDd2D5VTT3amG8lO3ED2Nn1KZW045Mj7jaa4A25CTxYgzhcz404eKUo3Z1ukPK2ISWqaDs3agvsJeVcbNmeAn7LvcbKLrJ2uSdnhjL1Yvv5gAfKYTQgxWPznTpUCE+ufQiDYyI3esuPGEEZ2Qx4cqug/OBgM0C0dUVYrKIsXR8NWJhHtpSyIt01VLznmn0EbJmEICRUwnTUdzOrdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0a+t3lq42HPz95ciUnDvh6a981GV5pg5c7i6AqJmIOg=;
 b=I4mXBLmKOvN/QeSDzTo7uo8QYjI1wT683JDfDTRLQtFRFtKMKsmuxThykHTrn2CYjkV/ueb/BS5hMIw7+pDfqVasDUuwmFbL8SB/KRthgsZMWNBf9hgxEuSuBsbE6rc90wBLXta3Q/PB8kXXwqLpsCybGX+RfsdYU1jU2j2SUBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 09:36:08 +0000
Received: from SJ1PR12MB6244.namprd12.prod.outlook.com
 ([fe80::81da:c871:8181:9b62]) by SJ1PR12MB6244.namprd12.prod.outlook.com
 ([fe80::81da:c871:8181:9b62%5]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 09:36:08 +0000
Message-ID: <b7823e39-084e-4374-8b5e-09c7e4511559@amd.com>
Date: Thu, 13 Aug 2026 10:35:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/12] PCI/CXL: Add CXL reset support for Type 2
 devices
Content-Language: en-US
To: Srirangan Madhavan <smadhavan@nvidia.com>,
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
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
From: Alejandro Lucero Palau <alejandro.lucero-palau@amd.com>
In-Reply-To: <20260804192958.1823952-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0686.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::18) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6244:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b69545-e235-4274-6b02-08def91e4435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|921020|3023799007|6133799003|10067099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	VWfqEG3yDYGePs/bku4S8c0orID81SEHsXR4TUDN9zV9MNFUgTfsXzuiBWupyAXgJivcDjnZiEoGYMBIO+MHdlg2OQDZchspz3fgR9/B+y/VCO3iMIuXpW/5X2zdLHi2FoY4FDnHkja/PpLj+RwDZ4SH3up4PcsJJoIOgrZNMzpRs5Bnuhj/pgTZRNtFlfFB/zNvWMFpf2uZ0k6jpw3XS/8seyJ6awzPCO1Q290y2Y0sCBQq3rG+0sNXE2uSoNZfsiLyDSpQkyuEQA4eqIJ9dX27IylbotL8H6+kNRms7nAeAbjORS+jdDP0G0RePYZhnLrpOrui9NFFj53vd79rig2//RellitKtGtUK9VEbIQjDtrJlmxcWaAjVo0jZ1nbfFfj7zDqdQ4CUsDY5Grr4L0kuMYX8mqsF8sxO7TedGLKxDHPDqD+EQCqnr4XgpXjCvt1Yz+xDLM9qjfnlvVvq8BkouzmHWNiuW4Sgfzu0gSEZKZT4DohmRQHn+jddLX9Up6eMfBxuowKPbmonyMJnEleOZ3Fuqwx3wN9mBJGdV7vp3/Avzo23mXfGpvGHL39GPqANCAt8W7DytOGWXDvGJiqOh6SIbA2LxndyH6bl572+8do44xgd6MLCzLrMIWHdkq8ouy6biyFzVxP5iVzsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(921020)(3023799007)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzlMTWJmVVp3dXorYTlCdk9BcGpCVWk5RG12ekhEVkcwSDZtRDFySmRHWmth?=
 =?utf-8?B?eGJHWUF2QjVjU3RrRWFOTHF0ZW9jRHJVWGl1enVwd0g4RTlIOXY3bTAvdUVo?=
 =?utf-8?B?VFBzNndFajZFOXl3eWF2d3hVcVNnNjFNMnZZb2tmNlczdVpWM2xUK3hUdjBr?=
 =?utf-8?B?VzFPZjNxUTcwYzlkTmFnWVBoUkNjemxFbHdlVk9YVHhhc3JZM3grMytEeGxT?=
 =?utf-8?B?bnZlZG9PSFJ5MEwxL3RjV3FtdVIycHZ6QXMza2JvTDR2Y0V3UXFsYm9TdWta?=
 =?utf-8?B?bGQvWjRVd1NYOUNpejIyWkVBQUUzZlhqYVlSand2ZHNHd08vcGFjMnlDQXZu?=
 =?utf-8?B?MmJoYVNSa2gxVW12bGVSSDdBOHliaFA2MGw4Q1NkQjhPbU53T05peERpZWRF?=
 =?utf-8?B?Q00rWXZVU2pacjZoS1JXZ2FmWWgzTk9EMkdtS0krZmFYUk5pb1FMS0ZINVFh?=
 =?utf-8?B?Y1lSSTk4cXNxdUl0REtyTENLek04V3pLaFJsUkoxczZWY0pkZE5mQnpQV041?=
 =?utf-8?B?eThnYXpBeWdUMWgwRFlzQ3ArMEx0dHVoMWcxZmJoc2xlK2RPYmE2VEZ5S014?=
 =?utf-8?B?YStyblJESVh5ek1NRzJvYzIxUjBIeFBnQXpEenRMSVZpTjd1ak5QcG9GZjR5?=
 =?utf-8?B?K2ppTVptYVVpdkRlTlRQZ1dpanNDbzlMRzQ3MGd2OTh2UkFhZW11UEs0dUls?=
 =?utf-8?B?L2ZsTTBCSWg3Y1BPNWgybkpYWGFIMjhXUXZIY2hReDM0ZU1IcXJCNUhBeGg1?=
 =?utf-8?B?NHpQSDdpc0w2c2JkanQ0NENCdzJ2bW5XcGJpeTBpUXNqc0YxazFNdEs5TDVX?=
 =?utf-8?B?UXMwQjVOWHkxOFR6d0sybkdUb0pKdzBPejdIMFBKcmV6S3ArSUoyd2FpNGdm?=
 =?utf-8?B?SUZocHFKVWdxSHorbmQ2bnM2alBXTFZ1NWcwM3VrZzFCYUltYWZabHMrZldK?=
 =?utf-8?B?RG9iTVNhNTZzUTVYRklJaEJSRGY1V203SnZhaWNWY2dDT2lSNFJWUzQxeUZo?=
 =?utf-8?B?WkIxUEFWYlg4SG1xNGxhcXI5QWtXSVBDRURlK3lOZU4wOHZXWTFpQUhwZHBn?=
 =?utf-8?B?UjVqbncrOC9RZmRNTGJwZ25RVEhramtKZ2gyUjhENWEraUVmc3pHSFpRTFI4?=
 =?utf-8?B?aVh3N1dSWE94WG5BdGpTQzVNc0lSSmNzdUtXS1Y5b2R1d3RFM2dUVWxuQXJE?=
 =?utf-8?B?UHh0UTFnMFRIZ2FGeXlnSGJRbE1DMGE3dndCV0xUL015YlZuWVhmZHVpUFFu?=
 =?utf-8?B?UEFHUm95RTRqa0l0bkRMQ0RxUGhrK3BrdEdZUVZxR2toT0ZoZm4rbTVLSERC?=
 =?utf-8?B?QnJCN2hnZVp5UWMybmQzUFM1TjY3dWEwTy93Q1NHRFF2bHFCOTRGZGNpdXZl?=
 =?utf-8?B?RVBHS0hoZDVUTlJSaE5XWHczeE1TL3ZoSittT294aHhGcmZaaGdBZ2dlWCtI?=
 =?utf-8?B?dFFpVGc4b0VTZnRTUVlvWlp1MVJ2Yk1nSWozcGJpNUtrR1pIbUxsZDhqUWkr?=
 =?utf-8?B?NStDcmhZb0ZTUjM4MGVWOWhNc0lyODhpamRwUXF2MEhTbjJEbHk1bDNjSWZI?=
 =?utf-8?B?TkE2cXQ4dlU0ZThwYWUvOWZ0VkJrMjB2SXJCOWFZb1NSTDRvaUNraGlJSG9a?=
 =?utf-8?B?Yk40anRydjM0SnlGWnhrNTlucGREczEyTnZHbFllc3VBZTY1VGZzbFRqNFJp?=
 =?utf-8?B?RXdUSnFndUNZS2xDTmhnRVdhV3RiRksrMFVaN1IrOUR4Uy9IMjhRVVlSSHp4?=
 =?utf-8?B?T0ZVcEVhL2J6bFZUaEZjeGRGdi80VE9GMVNkSlRvTlh6bUUvaDRvRE5IMjZJ?=
 =?utf-8?B?MmpGZ3FabE9zMUsrbzFHOVhuSm1Ec1ZiOTU1aVlGai85YUVwWHFQWmdLQi9J?=
 =?utf-8?B?ZEtmTnFKU1F6NHBPRkVQVVlQUVdCS3lqdnlOZEtmeU9FN0IxZktQbGJtUFBC?=
 =?utf-8?B?RkYwdExKT1AvelovUE52SjRwbDZoVTFnNVlnamdDL3NjZWpYem9ZZnV3R3g0?=
 =?utf-8?B?ejBPcEwrbWIxQlJrZUNTQ3M0eTlaV0laeTM4cWJXaVAyNFQ0TUZveldPUzVS?=
 =?utf-8?B?NXFqeGQxOUl2ZTUxWFBOaDVZYUNXa1VnWkVZcEhZMVVRWVNVRlJpcjRxZ053?=
 =?utf-8?B?cnlrSlFXdy8zMUMyRXBCRTRDQkhWTG5qSkFJK1p6b0twUlNGRG9kek1GVlFy?=
 =?utf-8?B?TzhMQ05tZGIxczB6NWtLcENucnQrcE5sZ29XMEoyQzJpRHJJZ1hDNjV5ZGRx?=
 =?utf-8?B?RW9wT0lLVDlBdkpwV010Sk55ZnMzQVFKV2ozZU1GVm1jY3c4K1EvQmFJbWRX?=
 =?utf-8?B?YUh5cWppNTBpd3JMYmxSTUJGdTJQaTdYSDFYcTZqZ1NqYU5DK0ZyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b69545-e235-4274-6b02-08def91e4435
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:36:08.0291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+R1/GsY7C7PII+V0IX71dW+F1DIbKrrv5NDYdVc1aUDuxYbmjLW5QnM+nZheK/gyqDXiscQPQZly8S1+KCtbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322


On 8/4/26 20:29, Srirangan Madhavan wrote:
> Hi folks!
>
> This series adds CXL Reset support for CXL Type 2 devices through the
> existing PCI reset_method ABI. The reset sequence follows the CXL 4.0
> specification [1], including CXL.cache disable, optional cache
> writeback, CXL Reset initiation, ResetComplete polling, and ResetError
> reporting.
>
> The userspace ABI is the existing PCI reset interface:
>
>      /sys/bus/pci/devices/.../reset_method
>      /sys/bus/pci/devices/.../reset
>
> Userspace can select "cxl_reset" in reset_method and then trigger reset
> through the existing reset attribute.


I did comment on this in v9: CXL reset is different from PCI reset and 
therefore something should be there for user space seeing the 
difference. With multiPF devices, just PF0 should be the one having the 
CXL reset option, and the other PFs linked to that one.


I also said I'm about to send a multipf CXL Type2 support, and my 
concern is an user/admin trying to reset CXL in, for example, PF2, but 
nothing happens because the related memdev still in use by PF0 (and 
maybe other like PF1, PF3).


Not sure how to show this dependency but I think user space should 
receive further information about it somehow.


>
> Following Dan's v6 feedback, this replaces the proposed memdev sysfs ABI
> with the existing PCI reset_method interface.
>
> v10 changes from v9 [2]:
> - Address review comments deferred from v9.
> - Split HDM decoder helper refactoring into smaller reviewable patches.
> - Rename the built-in CXL helper file to resource.c and keep reset-specific
>    logic separate from the decoder programming refactor.
> - Add a helper to resolve a CXL port's upstream PCI device.
> - Fix tools/testing/cxl Kbuild coverage for resource.o.
> - Keep early HDM decoder parsing shared with normal CXL HDM enumeration.
> - Gate CXL Reset execution on cached HDM state and current CXL.cache/CXL.mem
>    enablement.
> - Reject CXL Reset on multifunction devices to avoid reset scope ambiguity.
> - Order CXL cache disable/writeback before PCI reset quiesce and IOMMU reset
>    preparation.
> - Restore cached HDM state without replaying transient commit/error/lock
>    control bits.
> - Update ABI documentation to match the implemented reset ordering and CPU
>    cache invalidation behavior.
>
> v9 changes from v8 [3]:
> - Rebase the series onto v7.2-rc2 so it applies cleanly on a Linus rc
>    tag.
> - Include the cxl_bus HDM restore add-on as patch 11/11 so b4 orders it
>    after the main CXL reset series.
> - Address only patch application issues in v9 to gather feedback on the
>    current direction. Other review comments, including Dave's code
>    structure/readability feedback, are deferred to v10.
>
> v8 changes from v7 [4]:
> - Drop the PCI helper export patch.
> - Drop the multi-function sibling coordination patch. cxl_reset is only
>    exposed as a function-scoped reset method when the CXL reset scope is
>    limited to the target function.
> - Keep the reset-scope discovery needed to reject non-function-scoped
>    CXL resets.
> - Cache HDM location as BAR-relative metadata instead of keeping an
>    enum-time MMIO mapping.
> - Restore HDM through a temporary mapping based on the current BAR
>    assignment after PCI config state is restored.
> - Cache raw HDM decoder register state so uncommitted decoders can be
>    restored as uncommitted, while committed decoders are recommitted
>    through the normal HDM commit flow.
> - Share HDM decoder decode and validation between normal CXL core
>    enumeration and early PCI HDM caching.
> - Put cxl_reset ahead of FLR in reset_method priority because FLR does
>    not reset CXL.cache or CXL.mem protocol state.
>
> Motivation:
> -----------
> - Type 2 devices need a CXL-specific reset mechanism beyond existing PCI
>    reset methods.
>
> - FLR does not reset CXL.cache or CXL.mem protocol state. CXL Reset is
>    the architectural reset mechanism for those protocols.
>
> - The PCI reset_method ABI lets userspace select this narrower CXL reset
>    before falling back to broader bus reset methods.
>
> Change Description:
> -------------------
>
> Patch 1: cxl: Move HDM decoder programming helpers
> - Move low-level HDM decoder programming helpers into resource.c.
> - Keep the movement mechanical so later patches can change the interface
>    separately.
>
> Patch 2: cxl: Pass decoder settings to HDM commit helpers
> - Introduce a decoder settings snapshot for HDM commit programming.
> - Route decoder commit through helpers that can be reused by reset restore.
>
> Patch 3: cxl: Share HDM decoder decode logic
> - Add a small helper to resolve a CXL port's upstream PCI device.
> - Share HDM decoder decode and validation between normal CXL core
>    enumeration and early PCI HDM cache setup.
>
> Patch 4: cxl: Cache decoder settings on PCI devices
> - Cache CXL core HDM decoder settings in pci_dev->hdm.
> - Refresh the cache as decoders are enumerated, committed, or reset.
>
> Patch 5: cxl: Cache endpoint decoder settings during PCI enumeration
> - Snapshot endpoint HDM state during PCI enumeration.
> - Cache the HDM register locator as BAR-relative metadata.
> - Cache raw decoder register state in addition to committed decoder
>    settings.
>
> Patch 6: cxl: Add CXL Device Reset helper
> - Add the internal DVSEC reset sequence.
> - Disable CXL.cache, perform cache writeback where supported, initiate
>    CXL Reset, and wait for completion.
>
> Patch 7: cxl: Validate HDM ranges before CXL reset
> - Collect enabled cached HDM ranges.
> - Reject reset if affected ranges are busy.
> - Invalidate CPU caches when runtime cache-invalidation support is
>    available, otherwise continue after warning.
>
> Patch 8: PCI/CXL: Reject CXL Reset on multifunction devices
> - Reject CXL Reset for multifunction devices to avoid reset scope ambiguity.
>
> Patch 9: cxl: Restore CXL HDM state after PCI reset
> - Restore cached global and per-decoder HDM state after reset.
> - Re-map HDM registers from the current BAR assignment during restore.
> - Replay raw decoder state for uncommitted decoders and recommit
>    decoders that were committed before reset.
>
> Patch 10: PCI/CXL: Expose CXL Reset as a PCI reset method
> - Add "cxl_reset" to the PCI reset-method table for Type 2 reset-capable
>    CXL devices.
> - Prioritize cxl_reset ahead of FLR.
>
> Patch 11: Documentation/ABI: Document CXL Reset PCI reset method
> - Document the new reset_method value and reset behavior.
>
> Patch 12: PCI/CXL: Restore HDM state after CXL bus reset
> - Restore cached CXL HDM decoder state after cxl_bus reset.
>
> The CPU cache invalidation step depends on
> cpu_cache_invalidate_memregion() support for the affected address ranges.
> If no runtime provider is available, the kernel emits a warning and
> continues after the affected HDM ranges have been reserved.
>
> Example:
>
>      echo cxl_reset > /sys/bus/pci/devices/0000:bb:dd.f/reset_method
>      echo 1 > /sys/bus/pci/devices/0000:bb:dd.f/reset
>
> Testing:
> - Ran 100 iterations of cxl_reset through the PCI reset sysfs ABI on a
>    CXL Type 2 device. All iterations completed successfully and
>    ResetComplete was observed.
> - Exercised cxl_bus reset separately with the HDM restore add-on patch.
> - Built drivers/cxl/core/resource.o and drivers/pci/pci.o during v10
>    preparation.
>
> References:
> [1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
> [2] https://lore.kernel.org/linux-cxl/20260709010304.680422-1-smadhavan@nvidia.com/
> [3] https://lore.kernel.org/linux-cxl/20260703220508.546528-1-smadhavan@nvidia.com/
> [4] https://lore.kernel.org/linux-cxl/20260623032453.3404772-1-smadhavan@nvidia.com/
>
> Srirangan Madhavan (12):
>    cxl: Move HDM decoder programming helpers
>    cxl: Pass decoder settings to HDM commit helpers
>    cxl: Share HDM decoder decode logic
>    cxl: Cache decoder settings on PCI devices
>    cxl: Cache endpoint decoder settings during PCI enumeration
>    cxl: Add CXL Device Reset helper
>    cxl: Validate HDM ranges before CXL reset
>    PCI/CXL: Reject CXL Reset on multifunction devices
>    cxl: Restore CXL HDM state after PCI reset
>    PCI/CXL: Expose CXL Reset as a PCI reset method
>    Documentation/ABI: Document CXL Reset PCI reset method
>    PCI/CXL: Restore HDM state after CXL bus reset
>
>   Documentation/ABI/testing/sysfs-bus-pci |   16 +
>   drivers/cxl/Kconfig                     |    4 +
>   drivers/cxl/core/Makefile               |    2 +-
>   drivers/cxl/core/core.h                 |    7 +
>   drivers/cxl/core/hdm.c                  |  351 +++---
>   drivers/cxl/core/port.c                 |   19 +
>   drivers/cxl/core/regs.c                 |    4 +
>   drivers/cxl/core/resource.c             | 1341 +++++++++++++++++++++++
>   drivers/cxl/cxl.h                       |   41 -
>   drivers/pci/bus.c                       |    2 +
>   drivers/pci/pci.c                       |    8 +
>   drivers/pci/probe.c                     |    2 +
>   include/cxl/cxl.h                       |  116 +-
>   include/linux/pci.h                     |    8 +-
>   include/uapi/linux/pci_regs.h           |   14 +
>   tools/testing/cxl/Kbuild                |    2 +-
>   16 files changed, 1727 insertions(+), 210 deletions(-)
>   create mode 100644 drivers/cxl/core/resource.c
>
>
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
