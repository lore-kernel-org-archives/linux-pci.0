Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515F2E7393;
	Tue, 25 Aug 2026 07:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787641315; cv=fail; b=rsEvT+m8aefamun/PLhiLltDOpj7q1MJDq9P06MnmEOWgBY3TMqUp8EL9gRvtntOXREt9HID9wNl6YwILDJAZiUY02Dn2ojLdjU0SIe2VOGBdDNUezZMST9CQdgfp/WqxRWMIiPS5MqqImLlfrjky5rm9MKFi79AX6rWrG/ZE4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787641315; c=relaxed/simple;
	bh=8RQDI4F9S6lJRH3wrtqY1Vx+N7ORPH7qQuZkKKZArQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lc25DDPvU6ZLczgrhKn5dBAoP8w9xBMzxSkNr/dOU42MHvdQPK8zH6LvIF7eQobkVVvKpAGHb3sJm4OVUa0xTjrJ+97qpF7GwOjrkrM5uvE/We2B1IJqJkHBSqoppdCNd5jRike1SIjoQk2VFiuAJ4tJWloX7/Oit54jXqCrr3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cuJ6DTob; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cuJ6DTob"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+/PSKPDjQOus0764jacA+xzvYkMcJI3Xr0DI74iofulzLhLxaX5LoezaZZ/emsD3IUEwmzEWfqBEKb1JM1Wqnxxgqpv6dMYb4or6ljewtoltSEJ4J55v5TQsRZhHlidbq1HitEN+YBhqK/51zZfEbMCIZ60xUBAffJP9kdEsMwFy1AF4XPuCDebz5FZdgwWl8quyd78VJkQyfjVDMP5yTzxZhiwO9lhwMFshugNF+upOZnGiNb6LvW2a47mT6tmaReTIi69cYV1nVqShBzp4CQZX6E8yRwDNlJw+bxZSrSYaQL1s9tm7gWt61FWIZ5KHPbYqCPCkCP8LgzDJmZ2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQavNUAkYOpKREbN9hxahzvxW+vKIGELW1TTVJ2L0EI=;
 b=KWRfIOa5AuQq53pDZVcU5Wx0pBd+LpO2LZ99AxsZGEyxIbe1om9F+CWNHfWTI1Hn9Knv5PbJWNA6RB8vp1coMSOJwPVhq7mAGO9lFrVA9HS+VbvXO8o0ZkPB7P76b8tr3RyjB9HeSiymxpdNa3C/dx5wXNNcLOBcsMvKd7vjfzQ07ffTy3iIZkvanOGi5BjjImnItug/r51PBYW7WxDnZYBnzl0ZfQ6QHkKdSEa1kLvQVbYNRplqjrtItieGPURj3yuCC2GsJRjcB7qvfE99R7QxPP5VCAK6ViIT+w8eMYA7SvlESiKEa3ewO/APvFgn4MOd1KmHDWsf0ZlVINChOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQavNUAkYOpKREbN9hxahzvxW+vKIGELW1TTVJ2L0EI=;
 b=cuJ6DTob42CIbPjwP0Ubt0FyvREQxPpQCv/xHzcWnoKhxON9vfgeTxGMad5GezqV2wxlXbU/BVK6HTZ1ha567o6jqb8yIruCCaSp27uAwA89k5sOkwQ+gMaP2G+x/rc20V2gENqNkI4HnGwZ1q2qp48HX+UXQwTW/lL0s3iHsr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 07:01:51 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 07:01:50 +0000
Message-ID: <ff0bc0a5-e657-486b-97f1-9af998209f8d@amd.com>
Date: Tue, 25 Aug 2026 12:31:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, sashiko-bot@kernel.org
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260824122347.1588592-3-praan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::14) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2ac795-6ff1-4a35-da6c-08df0276bcd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ysQQFPl5eCLEkbQTT6BNGu53gnWrQzlw85ghvU/a5HMF9dZI1dc575wmX+sre/dT2SY5Qdvfw5fKuUk/mGzCWSN2jsmlTZ4nHVn1KAmnDILcDfuuvO7WcJbImB+PBHGKcgtz7UBRj6uPcOYksnZm1+mc9XVUIXOkFzn0R3j1GqhgKyIEfcd7qrlSWhapoJ8MbRS6FVN+IFLc1DLc/XB7Sd8Z+LEWQ0rhXXq+dGtjEm57Q1dcRgZ6Lg+c33SiIE6M7GgNzR+0lqZEvZUpIdVT12fAwok0axylUz2OHqRslvcOd5hfzSDRbwcMxuKd97PUAT5FTj/kRsVAYaeS3lZ3LuRpvee3quTuyNVkQxHgQL/jB7SqDp79woLYUO7jeBJHO0Dp0u35fZFHqoPde3c9vP46O+HrzbRdVcnKupDIqL/VoENNiDM61tNjx8x5MYVb/A9LHC9ryFbZFW9WBMR2Gd2asJReGtK9NeJzHw2GKgDGMjFFkA292Whwziutnfe0y8mSjkW/yDKdp/UtlYRjkLQWBRxgBcCOXlfSx8Z4qNZQjrrpynLY2pgmrGmWfdCue2SNjS5mOK2+wiv3hzWJZKKpP3Yxigrc7Oc6soZKtp1qsjY+hpu6cBBJoYbWnhvtLky1hM5kBLND9tEGZeBSomzDZ55Znh1fHLaNwiGp+eM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW5oS2FjcEhNUXpkQ3VKaStMR3RmZWF0ejFROEFMU2c1a0N4VXZTanlJQjJU?=
 =?utf-8?B?TnFOOTJkM0k5NmRDcDhHUE0vbUR1U0FlMVNyS3gzMXExYVpQUHk4OWM1TkxP?=
 =?utf-8?B?bVdLNFlsd2tOQll3UURpbGdycE9XYW1uWHRnN0g0OXpKV1ZhcjZJOHRQUS9V?=
 =?utf-8?B?cktBeTQ1cEVRUGtFRWMwTWhwa3BhR1lxbWlyRUw0cTlhU0MvdzNuUWwyeGdO?=
 =?utf-8?B?eGJVMm5OdUZUamIvZ3NzbTFjWTQzUHR5WU1DVVNjVHZoRTBmL2J3amlvVG82?=
 =?utf-8?B?UG9DbkNKZFRMTjRjZU5iMnh5V3lQZ2RkQlFTbXJib1RJSGJwZ0FiakZuaXpW?=
 =?utf-8?B?dFh0anJEZWRFUExFUmZ0eDBjd0l4aGlaaEdGWjI1QTQyUDZHRXJZNzZiV2tU?=
 =?utf-8?B?MDVnQ0pLc3NVZU44ODRsWFBGRktSRzNBMmcwdU9EdFEwM3ZnQjQvdUo4WlBt?=
 =?utf-8?B?d2JmVzRnTzJtd2o0RDh4bmhKREcwQkVLakswb1hJb3c0OFpBNVByNERWYzdP?=
 =?utf-8?B?QnJwbDZxYlVFWkZyUVZMSWVaUXRlM0ZEeVZRbGhxdEtvS0dRQ1NlSFZMNlpu?=
 =?utf-8?B?dEJ5VEF0YlFSTWdkcGIzeVRpOEdLUnFaV0RWNDhZanRBTzUvN3JQVEpTT2lx?=
 =?utf-8?B?MHhUZ2hCN2lJZTJvakoxejNEUjJUWWdVbUFJTmpmS3oxSWxra29iMzcvQ2o1?=
 =?utf-8?B?NkdPUWhoekFSMmpvbGlRYmNhUTVma09RaDkrdWEyN1lVVHJJTzM4aEozRzJG?=
 =?utf-8?B?MzJSbTNhVWk3eEpScTNNZXlFTXVXcElOVzlmd3FiNkJ3b1czdno0eEJ5Ymwr?=
 =?utf-8?B?NG1wOCtRbFdJUE5HTHJFN2ZFcXFYWDBmc0V4U2swUXc3OHozeVZTaTgwQVk1?=
 =?utf-8?B?VnNUN25BWVpud1JWYUkvaDg3TThjZFZwNXI4UVVOUkJOMmVFZVRiREpUa1Fm?=
 =?utf-8?B?MXE1aFk3dk5aSHJvSThFWE1vN1Z4QWZOcUkzU3Y3VGdNcnpDVUFqcUM4MEFw?=
 =?utf-8?B?VEJCVTVCam1JSkg5ZHhJU0VBNG42YU1Oc28rOHZUZWp6WWZXVnB0dkVjUEhr?=
 =?utf-8?B?Vi90OVg3ckVaWnMzVllwN01adlVCeXJDVUNzTHZOdHNFd2l5YzVJUWx0SDRZ?=
 =?utf-8?B?KzNYMVliSkZuWFNlbzNNRHViaWNnRjFRdHVvMnF0b2ZpQ2dPQXZDclgrS2Ir?=
 =?utf-8?B?aTQ5WUViVmZXRmNUSDdBZWRXbjZXMUo0RXlaQUNjME1zN0VhNUM3T3lpOUtI?=
 =?utf-8?B?OFhBMWN2T1FLZnVBNWZ3QUJzTTdkWFpSQ0tpcHMzOStzancrSGRWYkZJenVN?=
 =?utf-8?B?RWdXREtvVi8vRGs0VVF4SnRJOVp0V1NWWWZUNk9tSjFheWRhQzU4Zm1jTUZJ?=
 =?utf-8?B?RjIzcnVEY2lDSlRaSUpnNTFMVWFaNVhlbHA1TmthUnV3d0d5MW1nRkJGUnpm?=
 =?utf-8?B?WnBpcmNpWklpclRMY1hqNkRSVGszMHVTdGlHTDUzbVZWdjRoSUxYWjhVUXVm?=
 =?utf-8?B?Um5GazhxRWVBMXE0VTgzc3l1b1NQNVZVeXhpL3N4WW9OV2I3cFcyMG1BTFRm?=
 =?utf-8?B?dUZNRUZWK29uTFdBTnFhRFhSZ25oV1ZHY2hiYWJEZDRmNE1FVnFFdzU0c0w3?=
 =?utf-8?B?Z0ppa2R0RllQOURLTDRQelNHQUdUQnA0UjFLWkpqTXg3RTBndnZGaSsyOFg2?=
 =?utf-8?B?ODJlZlFQc1B3NTdEMXE4YTlGa1pieHFZVVI1dnpnMTdocHRsSTNoaUxKSC9G?=
 =?utf-8?B?bGh5S2p4VjVXb0pwUGQ1bElBOUIrVGVZQnJWT2lSaGM2VTU2cTlka0tlSENC?=
 =?utf-8?B?d3AxK1dKMml4Q2FBRWR1b0d3UkY2ZXBHdUpvc0l6cU5ld3praVlubkl3WTdU?=
 =?utf-8?B?NXZNam9HcXdpeFNRMHhGa2tmVzBxa2JRNmhCU2VNUkJSV1JMRjBCSEwweXV5?=
 =?utf-8?B?V01IR0VJQWdKdG8yckF0Sm9WY21JT01Fd1JySWlrbGwweURQZUxMc0RXazVN?=
 =?utf-8?B?VzFkejRadk84TFRUZ0kwS3NOZXgxZXp0VnlNdnpDWWdubjZGbVVWMDJiYlow?=
 =?utf-8?B?R3czWHE1TkVZQTJOMHpML3psNGxvYThVODN4c3FjZjgvZmh6Qk1MY1hDdXov?=
 =?utf-8?B?N2Z3Y3g3VGhnZWQ4VEhLZVh6UDVzSWo2R2QxNUhqSk5IV3JJYmlvYVI4bW50?=
 =?utf-8?B?a1MrYkdQSjRPOGJlcE9lMTdSc3ZMNHVTZ0xUZTQ1SUJacTJFYVNQZkU0K1lZ?=
 =?utf-8?B?cjBLZDZXd2Y2SUJ3dDFveFVveU9SejlKOWdLbEFLVk1maXJtOEQxMHBaRzJm?=
 =?utf-8?B?OHk4WjlSdzg2SElPbHZndmJ6ekF5d0w0ZG5tTlVCVVUyNVJ1THcrdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2ac795-6ff1-4a35-da6c-08df0276bcd3
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:01:50.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vho0BdTd6kQW1UbmDMknQotQ/a1cN3nxqNN2B162iZWamrLTi9xI3i9i/5V1nReERsOYBJLzEhLDVW5vqH2RvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426



On 8/24/2026 5:53 PM, Pranjal Shrivastava wrote:
> The iommu_ignore_device() function currently uses memset() to manually
> clear the primary Device Table Entry (DTE), which risks torn writes as
> the hardware reads DTEs as atomic 256-bit qwords. Furthermore, clearing
> the primary devid in the lookup table before calling setup_aliases()
> causes rlookup_amd_iommu() to fail for aliases. This prevents clearing
> the DTEs for DMA aliases.
> 
> Fix this by replacing the manual memset with a dedicated helper that
> invalidates the DTE by clearing the lower 128 bits (having the Valid bit)
> first, followed by the upper 128 bits. The cleared state is then
> explicitly cloned to all aliases before the lookup tables are nullified.
> 
> Rename the function to iommu_disable_device() more accurately
> reflects its intent, as we still support IRQ remapping for these devices)
> 
> Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

