Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047244F7CC2;
	Wed, 23 Sep 2026 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188637; cv=fail; b=HnFwueRxCPJXDqB1WuzwUmc2YHeG0epDbdrLIa3cl3N7dAuQzCSNzwIdrNcJHz6YVTKijiHeyQCw+VZaW0lOb0/rpVqWc3/ylC3GnRqXoriJyJKiqv/ecOkV9e5z3RnfgJ5tD3f2oS44fuSVObLNPdxDfDjqSZW5PI7Ssp9j4aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188637; c=relaxed/simple;
	bh=ONMBD2JLgw5ENhnh/OtHQs1Czds3IfZpJngjsvcMAEA=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=BfWBrBjG0oQURBHzpTqlXdsZ9jPx0hV+xht/nAfwIClquBip5d4AbITv3ONBdXu9hmKvq+oVsMQdkA59MMXCHl0C5QXj4pFwbOa1UVD+NT6qo8LwMaQRRraGpQcfZSyXI0H+4rM3s/HkhdmUEogtnW14TnhFeb+QHDXzef1BAUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oq+hRIzh; arc=fail smtp.client-ip=40.93.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oq+hRIzh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrZwmabceLu5B4yETKcXW/K/2ScM5uYzLT9r58szoVUYlOdJP5WPMmvXQgwSuzjR1Gj1NtQvbzu2W5ypF4lbvIPAXHimrB88qQmvzXwjuhSIZZrB3cL+XoQ/L1Hbo9h+hbXjHt+648XKYmdvZljfHpCUj2mato+X+WIiz8AhDbdocWRcgEkue82RGLtSQTvZK7QU07dWLWVcRppxm7fNmDKe5/QTiJi36IO1x5DdVzm0p6sqsUHYHljEtqRMZyIyAxigxOXB5GaOWR4CfzrRbXR8GPHQ31gX2n2lVOq5S8l3NUfpDd8qHuL9r1KdjCQUghVbjelGtQJA7yrozNT9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeE7m+akdaIjKrGQ/IxQD2RPkIzWo+SUDvTiYZScQ1k=;
 b=JG0HQJV8VE6ntxNSMw+DYqdnORQU/YBxL1IV3K58NPR5+KB1JwRTnE/Dm3TK233Nk4Je6HDb1k9wmKg6H+6T9+ZZyS5vC7MgpRENrj2FbZ5htqfjg/0L+JogNvJUNRP3ro9GUfnfql8cvYe+h2mZ9w5mA51cH+s40Hmv+qiNu8dFDiacpX6RuWmL169CgjgqKhVnuwSNwraa0jqIH+uwRyHjAJAxd7tFEukLbxJDG7SjKH3yfPNJ6/eS/mVXUg8JPyj1QEAN+BuUrfHPF9SDW11LWzvXGhZQ0MxiPCfxf8+eVz8Qs6+MuPar36h0LX3eZxzSijprjO2uGEL+JBxzTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeE7m+akdaIjKrGQ/IxQD2RPkIzWo+SUDvTiYZScQ1k=;
 b=oq+hRIzhDMqDmjXKvs6xKRK+2F94apcko96eMdUnDamAHQEYUo2TnRGzmeCVKZInNn2oGGeccl5hFKv7fJFKaNzvrQRneFrAtnTUgDDU6RC6M86WnxRCP3LIeZypfqn4QkWG2B5Y+pMBro9Xk4VzKQEW7Lr6OBUrVxOQ/UeKLQlTFx+SXDEjligYwEW8LB4sIA+VdSDzzREQMnre61qOjQ0UmmaIkrRSLFEKlCeU6C5CCA0wRy7W8JlCPde2qfr278ft80cjcPRvauqUANjTY/HESMf+bukVd8xlXTWPyMMwOghRK7ljPZ/ZFgau1lkIDdq7mys9vc/AvWoLBblGoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by CY8PR12MB7730.namprd12.prod.outlook.com
 (2603:10b6:930:85::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 18:37:09 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:37:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 06/15] iommu/arm-smmu-v3: Allocate IOPF queue
 without FEAT_SVA
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, joro@8bytes.org, 
 bhelgaas@google.com, praan@google.com, kevin.tian@intel.com, 
 kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com, 
 Jean-Philippe Brucker <jpb@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com, 
 bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <04fab7d8ebfc7e5d365f42569928d015d9c8b781.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <04fab7d8ebfc7e5d365f42569928d015d9c8b781.1789446520.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 15:37:05 -0300
Message-Id: <179018862538.3334538.15733403727515448373.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN2PR15CA0040.namprd15.prod.outlook.com
 (2603:10b6:208:237::9) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: e19f192f-84a0-4595-a0b3-08df19a1ac8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	83S+yQAEW7NpKxVq6mSj969wobcIXn1vP4r3XgJRai1YLo6PoQspW0zE2MHWTtfP/ZgxyC5VQsthZZfBQvP+bisGCe+cAboKrvOnj2Hpi7YXY0Vu5csUFNtvyAmJypToT1hhmaMCktho1kT+Vf5mxlOaLaNDo/wMZxLXdnZEwBa7nKcvTFvOKyVBSvNQ3atEs1XrpY6di7qFiET+4ux/L2N5Mr/5Fmf3H7J0hFjyGOP/wBM7X1dGNj5jghM2SgJ75iHCfvcNSepmG3E/HZl9k+pYbKTButMUhxM/hUUp5WUt1bbdiYgIenXcpkEOSTwSb24v9ufiy+CC+sORCd53sSeFeuwvx3f7QiWJjlocYNqlOFaCEkFYDmlhOL9lNMAF/yiixRUIsfpzhkE5RrxIO1yF435IuDlpSXIujMLiFkHyyIm+PCAqRH5d3WIvKzyV8+qQLy9L8rzfdioj3mr6sZ+DgG+XIngrPHHtrYMM9v8mFo6u8uJ4U92cl47y+0iWxsX0Bk+M2Cni3D/UvcLmeio6xUAf+utvONf5ntHt6F+pWVnpq6nNixXb+ZyNsY7/+RlINU1XjLxjqXdPHrJKtUJnSYDwo0CL/AxrVBi+Ct2nqFeyB5yvv48zeVdOKVi88XA2PO3riGZjYiOVigxjV2yeUo5Xfac+J1P3oCH7N5k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWd6ZDNQa1lzOWNLK1VYNnR0OHdhLzQ4NDRZK3NUV2pMOVlyNkVDemRJWmU3?=
 =?utf-8?B?bmM1R09LTzlIY3Q0aWNKRGJkUTV0TEdsS0RxUm1kWkpjWkwxZlFkSWR2L09R?=
 =?utf-8?B?TnVrczI5UjkxMjFsUEZ5cTNvUmo1T0RiRlE2S1RWMXJqUFlaS1FmUGo2RjlM?=
 =?utf-8?B?SWxGZi8wRC8yaWJWcndhLzA4Y1NDODY4Y0wvekVLNnIzNHhoaURONkRlK3pr?=
 =?utf-8?B?VThpbmJ3Mjlkd0dKMVM4amNsTmFUek5hS3B2Q0FRb2VXWm0rRU1UdlUrVjEr?=
 =?utf-8?B?b0pjVzd0UVp0UlZRRGtzMTI3Z2d6MzAwYW9wdGdKSTFXMjJGckJHblRvc2Vh?=
 =?utf-8?B?VExiekxlRHNuMWQzcDdNUW9xZkxNVWhkZ0FYYnJ0UEljeHRGd21iaExBS0ov?=
 =?utf-8?B?RUpPckJNN3NINDZEV2o1eWNVZGRKMmd1aE0xd0xxYU5MYjVOSDFDTHBBMmEz?=
 =?utf-8?B?aTJFNzZzd1Vzd2pjejMzVGtsWlJLQmFNQmNRWmhIVmlURU10N0dlWEwwRk96?=
 =?utf-8?B?V0hWMHpmS1VqOXJUaHlUTTdUWEx0QkVZZ3NPSWxFWE9iRjFJR25UdzdYYzBH?=
 =?utf-8?B?Z1pXV2dRMTFDZWZtMk5PY01QS1Nib2J4Snk1aVVlQ2NLRy9WS2JPOEpkVm1r?=
 =?utf-8?B?Wld1OGVLemdEZnVDcFFlU2llbTl5NldQUWdSZzVuYTZnVmN4RjUwbzU3MDRP?=
 =?utf-8?B?dlJ5QkEzZmlvdEJZbHc4bkVuVS9VTTNGUHJNeUFPRkRGZ0dMQ3ZOUW9XYWlY?=
 =?utf-8?B?NnBGSzQxZ3A3cHBzTi9QQjNlbzFlVVVQS2plNHoybmUya2wycHBNcGlVRlNs?=
 =?utf-8?B?MHFRbGtkYXp1ZjZjNUZJRTFLeXhiSVNOTXQrTzJIZFMrdUxLalhpSFppTGlV?=
 =?utf-8?B?ekFxRmNOREtFaFB2L2JoOE1lbTNjOUVPSWM3OGxJam0yYnVURGc4Rlk0Mk1O?=
 =?utf-8?B?ZWlZbzB0K0k2RjE1MTJxZnYrcFdhZnk5bWxOU1p0S0ZWNzYyRU94UFRkaTIv?=
 =?utf-8?B?MUdBdlQxTlpILy93cHNLMENPaVJ1aVpyVnhqSnlQY3ZoYVRFdmN4VkFrMVZR?=
 =?utf-8?B?ZlNnSlM0eitQbnY3NjF6UEVlZnI1dUVIR2Z6VmtZeHA0VVJKRUVtak9ITTBO?=
 =?utf-8?B?bElDZTdOOFo3Z2wxc3NxRFB2NC9QR1BOQVFNaWFadnQzTTFESytZb3hVQlFp?=
 =?utf-8?B?TUMwUmZwaDB0SWphUXo0ODBEL1VtTW5qNXBIcjg0QjhUZWhPMmx5Y203QmNx?=
 =?utf-8?B?S293b01BU0FCZVFqcmlZV2JiRjZZTzExLy9ZWXZ3bDlMaEtGRmc3MEJqYkxs?=
 =?utf-8?B?L2F0aTFNUk82bXlmTlVNZ2tSU3VwL05UOVRuRFhPczYvd3ZwTkdVZ3dGRzBn?=
 =?utf-8?B?c0l4ZHlmN09oQ2VTZEpiSWRKYWZ3Rnc1R2dXTWgyU2lLNHhmc09vQndmZElx?=
 =?utf-8?B?YjBOcjZFZ1RENFBKeGhZZytEU2ljc2lkaUw3QnVERHhHdkg2bXpLUmEwbkFt?=
 =?utf-8?B?RGtjNWxURFFsb3dzYjRvOE9QdTNmK0VqVFo0M1Y1Qm4wTVVwanYrNUwyUmlO?=
 =?utf-8?B?M1Iva0hneGJwcWVWNFphaFgwb3JlZDRMMXNXbDNYb0JXeCt5OVNwbXFSVllq?=
 =?utf-8?B?QTBuWVZMbHg5N1dQSkdxNFJvV1A5WUJtRUhMa2NXMlZSTHFpcForODNGcWNp?=
 =?utf-8?B?YXY4SnhMWVZzendPYjFDWDU1RXY2T0o3VjhzWUVweGZ6UG1UVmxzT3dKWVov?=
 =?utf-8?B?SFpTakc3ZUpoQWIzQ05MbnhnS1FXR3lzMEttTTFyOGxENUpMZTdEclQxcllm?=
 =?utf-8?B?WDdOT01lTExYOTNEL3FrbWRpUnE3cktFczh3Y2lmZmRpeGk0NXBLbzd6YjJt?=
 =?utf-8?B?em9IcnpIejEvdWJBL3dqdjZNTUp0Tmk3ai9KYzdUQXF0d1dDc0tveWZnNUM1?=
 =?utf-8?B?dnU2b0JIWlJxYWdncmw4dENKV280YXEzdWFDYTYrN0MySndRWUZvclJYSVgw?=
 =?utf-8?B?b09qek5Gd3IxZFhJSlRDN1k4bzJjeEhuRFBnYkE4akxrcDdwcmpyYVlLQXdE?=
 =?utf-8?B?YVEybmVISStVVW0ycUNIWFdTUU8xRW9Qd01OYlFDdW0xSURpVE9JNXFFWGdF?=
 =?utf-8?B?NWZJc0xuMnduS20wZ1VqRml1Mk1hZlhEd0MvU29KQUJ5dzBNWlZ5TUh2WnRt?=
 =?utf-8?B?dUM1RUZYQ0J0S1AvbHFSdmx2NVZadVM0TEJXeC9saHVLT2RQQ1VGRkM3K1FM?=
 =?utf-8?B?SnN4R2hyRWJQSHIzMS92SGpQckY5YVBGSzlHTmNpaC9FUG43NWY2bzhaVkFj?=
 =?utf-8?Q?xPftS9C+Wwv1O7/qD0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19f192f-84a0-4595-a0b3-08df19a1ac8a
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:37:08.6009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQlrAN+Z3xtXEut9gokk8+TdXGxQXJ+8auN8jCXX30tgkmprTUR5p3GLhzZ/sXhQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730

> arm_smmu_init_queues() allocates the IOPF queue only for FEAT_SVA together
> with FEAT_STALLS. This queue has no SVA dependency, and FEAT_STALLS alone
> can produce events that need IOPF.

Until iommufd there was no other way to create faults in the first
place. Doesn't matter if the HW supports it.

> 
> On HW with FEAT_STALLS but no FEAT_SVA, a master with the "dma-can-stall"
> device-tree property has master->stall_enabled set at probe. Then also with
> CONFIG_ARM_SMMU_V3_SVA=y, arm_smmu_enable_iopf() sees stall_enabled, calls
> iopf_queue_add_device(NULL, ...) at fault-handling domain attach, which can
> oops on mutex_lock(&queue->lock).

Yeah the guards got mismatched. There should have been a

arm_smmu_iopf_enabled(smmu)
	if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA)) return false
        if (!(smmu->features & ARM_SMMU_FEAT_SVA)) return false

And that is used everywhere. The fact one place used the feat and the
other used the CONFIG is the cause of this crash.

> [ ... 32 lines skipped ... ]
> @@ -3215,9 +3215,6 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
>  
>  	iommu_group_mutex_assert(master->dev);
>  
> -	if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
> -		return -EOPNOTSUPP;
> -
>  	/*
>  	 * Drivers for devices supporting PRI or stall require iopf others have
>  	 * device-specific fault handlers and don't need IOPF, so this is not a
> @@ -3249,9 +3246,6 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
>  {
>  	iommu_group_mutex_assert(master->dev);
>  
> -	if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
> -		return;
> -
>  	if (!master_domain || !master_domain->using_iopf)
>  		return;
>

I think this is fine

> @@ -4667,8 +4661,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  	if (ret)
>  		return ret;
>  
> -	if ((smmu->features & ARM_SMMU_FEAT_SVA) &&
> -	    (smmu->features & ARM_SMMU_FEAT_STALLS)) {
> +	if (smmu->features & ARM_SMMU_FEAT_STALLS) {
>  		smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
>  		if (!smmu->evtq.iopf)
>  			return -ENOMEM;

But here it would still be nice to support the non-SVA optimization..

I'd change the kconfig to move the select IOMMU_IOPF down to the
iommufd and SVA blocks

Then guard this with an IS_ENABLED(CONFIG_IOMMU_IOPF)

That way you can choose to compile out IOPF if you don't want to use
any SMMU features that rely on it.

-- 
Jason
