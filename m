Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D17730C14A;
	Wed, 23 Sep 2026 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188637; cv=fail; b=iWuYx+6v3mvKerxqA8Wy7OX1GsQUapH7ePftjC56JjtHd7qw/Su/xE8gY+bh2izCBm8mPG3RrTvn6zgCGQwutzxcM21V/eoa3T47s1fRRW6+tTlu5PCbjGQuwb9bLoKSc5yckpCyC+ONWKKSC1oTG5mf1qiuTlQ4Sy9nkzyhczQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188637; c=relaxed/simple;
	bh=fLNkxWeAjPP7RXjcn1u28npz4aWeyBZDXb+DTU2BW7A=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=CNkIT9hhb4K/dj/qMaOy8pU2JYZ7doOBC73q2Q0xBbvFHvu3yEmdE2vpQ7IEcDYkomtAvoQyTqyJVWRLBEfpjHCan5qF1c27EiDWXVL8y43zklp2TDViM6POloIVSNteZDnncI2GzYGRmwoqNF/m59frPJOtlJ2NkOcyo4bg3Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d5lstglT; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d5lstglT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkeSEJD4TXFrSu2+p3nqATQesasvX3dow9CBnM0kYfMTpw0pPxSubX5feJG65S+wtR9c5KBpxaDNHsYBmCp/HRBYAUeuldFpj9JdEPel/M+LbgPDmO3p1YHy8ayLMPlK6UHcOP1J7tv3UXmxXO6xSbCUKPYGeEKD6olcJbKKK2ZStivQPsJeSZno+RjESKbJ89QgZaVZ68yvubnsab8ZBYsCKa/37YoE1ZEMGlEU0OBojEzHgfFDcNC2LZ40K+7ZVeLpd3I/VGhdpOboJOXJz9SyaJEOfhhPPJXW7G6/NUunOnWxv3pbfbo2DSirZXAA6ssPTxx9JkUu2ttyHlW76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2EnQyOyoUtNsUFRVqQDMucaRpo+62D/GjIFlzAhCvk=;
 b=Gxh8x2p5fCX4ba1D7Ran8JYfcGBJgJmZI9sbkWyfayEqFqedhUTxsY4h+TLZ8cg0SprK2xKuVjg4Wr+gpB2YymtS5eHKp5a53+A3jnjN/9yrwU7mUDJLx/jAYDy1HPbjcp1Ufn6buxXNcJ9SZjQ2H5rENC34Ya5vbQBl7/2zLw3emoheoIq8Koo2Pfsz9CQlqrDmK62xXrQCf4wF16ALuWj5a3ws+3x1eYqDmysp1zUY+qd0Itx9ZPKYtSUxzyxQH8zZOKNBNC1lOBh+mn+6aF2F9qF4wJOuz0VIthmBRToPjn6Qgwoo1eT6R0nBKU6/AdUjQttWbTwqjoiJHkou7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2EnQyOyoUtNsUFRVqQDMucaRpo+62D/GjIFlzAhCvk=;
 b=d5lstglTpiadA8oJDZ96qCwhywLtKNV/JUaj0U/rUrwXxQ74XAlk6bV6vjqNhVGGXPQZDjnpY8cBVzTULMKjH9biZhwUOCJmOQlwdJWEMWQc9Oac6CmY+slLmEBB7vYv3JI8gEDrNQu5Y+57cFviCqHHdlCRiKo/mZJkKw3tRH/yyIuUQRIosXQZx0CZzJyPTQRioWXRKJV2NVJxvj5WeQguuiNypktX5UwwInYqVjDvCQCXFJPfSambbcJXXMkamkD/h3QDKRHGCBCaxXSO/oBxVPUGZpAiC/k8/Gtw6IjNx7aSu364V1GOawj8H12y1Y0FxQJW7C1DcE8+EUcDPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by CH1PR12MB9646.namprd12.prod.outlook.com
 (2603:10b6:610:2af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:37:09 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:37:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 02/15] iommu/arm-smmu-v3: Add
 arm_smmu_attach_release()
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
In-Reply-To: <f74817bb45a4bfcda966d9b5ca366c649b6dfe46.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <f74817bb45a4bfcda966d9b5ca366c649b6dfe46.1789446520.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 15:37:05 -0300
Message-Id: <179018862537.3334538.787239103362232948.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN2PR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:208:23d::16) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: 28282a02-920e-4b6b-50a9-08df19a1ac90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pdpITn1tLt/TvIpUSdUaRMvABLvgU0qgP90uTkS03+j4mTWQoTop1mHTAs3g1T/ZhtWunl3MXo3eIWLghQ5dTc0sR49gWwaJHTdusQopOk7ykjzZsYqSOStEI4kxoQUy8AQ0UetjZEJL4LgUE+ELKTsEwnwVttD1G3MV9IlCeDZvxpqO2eXw638ZZrEHtidemjIVkLb9xpNviyLZwSRkiL5TWpA3WiL1LikQmgEu5Kd0KbiAvAxKUC8oUqi/s4sdNJiQevlBsD2km9k++F+aVrIlIajV5JAUUj9NkcS4BSwVE1f1aIVEbTvv48dVOHuVHA4/fXeOHClNPyYoGjDAbfwoMCwxghCmJTOw3JN8Eb+CsjFgsr1cLBUUNumuj2HmyoSiwWL+fwMYtaX4fp1ctwlPdC7bHGT8rD8iWGZGoAikucgchSLQXYV091lPPZx6A6zzD5ejKGL/3B/9Or0XmHk+mmQVKTnwNe+VM147FMObNp9IvHf5ZYMdA338H9pHM0sop8sDHUH6yPA9N6gzPGAuglCxDHBFzS48QZMG3A/VKcBAvklgwmd0/agPwRfqnWAP+06ZTZvKv2ABjZ5aNcqTPom7+sY91PRK0pj1S3rtoGcF/J7R/CpvKmRbsO/3UjWdiZpnXHi5J5a0w/yzKA3raQujQyzDdioQpxAilJU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEE5ellGb1FaZU0xK2RwcHF3QmtiZGJEM042MG0yL2FDTmxuTHZJVk1NYkVm?=
 =?utf-8?B?RjVXUnJvOGIySUY0RlZwYmZhM2p3ZjJ3bkNyUGVSOFAveHl1VGt6VnZvb29U?=
 =?utf-8?B?bFhZdit0R290cUorTnZ3RzVPeEVaeGl1WFpwZDRvSkUxRHBndVZzZ3lFejNV?=
 =?utf-8?B?UHhUTkMxUkJBNTlPQ1pQMHA2WmpmS2JEZWZiYy9GYjBEWFk3Mnh3eTdtZzFy?=
 =?utf-8?B?VVZkU2tIaWZFVWlYdThTRTNJckpNb2ttSVU0aDZVTVAzVWVHVThLMTY4NVRh?=
 =?utf-8?B?eVo4aFhvcEI0OGplMDdpM0toNTBCa2xHTEFxUnNiVVpBWTN2d0tqNHhaSS9w?=
 =?utf-8?B?VTZnam5NMjJZY2NsU3NKOWZaRUp1T05VOERybXBOdDlGTkZNTWhjSk9OL0lz?=
 =?utf-8?B?SWxVTGE4bXE5eDFmcEdKY2tQaTdVVm5NRmdMYWNPTTlDNG0reE10Wi9ZT2NN?=
 =?utf-8?B?RzdaaFRXMHRwWllkZVl6TklmY2hxQU4xQVhtQ1Y2YzA1aG1tRUVqbjdiY3g2?=
 =?utf-8?B?RTI3bW90d29PRDloQU1uNUxDeFRMbWJoZmY0NGFRcGwvcEMyd25wZm54dk85?=
 =?utf-8?B?bDVrZWNrK3g5TldoMlNzVk5hVlRhZ0tpYmFGS3pVeUpwNnJ1c2hsS2JIcisx?=
 =?utf-8?B?MTg0OTNxeU1BcTBMZVpiWmFUeHJFeWJjNzA0QU9iSStqMm9NQk9zb3dLb1pX?=
 =?utf-8?B?OFZ1VklDQTRKNEYraW4ySXo1OUhTQTRvSDA3alJqV1ZHcUNISkY2aE1DcjdY?=
 =?utf-8?B?cWg3U3VZTUUvcDZmVndCbEZVVGgzOUx5cGc5NTN4RXVzeDR5MUdwMU1mdU5Q?=
 =?utf-8?B?azBjQVdzMzl0QUFKOU53bGtnOWxZMHNUY3NsaEVnNzZVSk1UNWFseUo1b25x?=
 =?utf-8?B?L0JBaVM2U0xSdTFZTjBHMzFlMXJoNUlJQWd0RC9sVlJCVDBGaE9mSExZemwv?=
 =?utf-8?B?OGwxbmFFTzFnQzM1eW1XTFc2MERIdTI4UThhbXhGSWRLcExjZWdtZE1SRkpv?=
 =?utf-8?B?Y084L28zdWVhQVRXZXlTcmRiWG42M3RGdEkzdFAvVy9BcENVVkVOWnEwaEwz?=
 =?utf-8?B?L0FacndsVm9Gbm1zTGxLaTczKzhkSDBwTHFtRXRmdnFjbnhFclE3MGtGYTE5?=
 =?utf-8?B?UnJ6WStHWkZOWklPVVQxcWJENWZzMUVwSWlSWG44aWF3NFJ1dWNxWG5QYlRl?=
 =?utf-8?B?RkNURXY5d1dieEhwcGhYK0Q3VExISkhRMkFwdFU4UFE1ZzhnY3RDSGpRdFFi?=
 =?utf-8?B?Rld1eDJRNXRLYVZDL1h1V0J2VUFFdXB6cGVmS01FV05mNGFFUmloZStNODBJ?=
 =?utf-8?B?WWErQVVCMHM4RVAxMThKNHNmL2psQm5mWnh2RFZFbjU1UUV0ZDJJNGtQeW9h?=
 =?utf-8?B?RWtUaysyTGxkZE16NFRuOVZiNGFjbUhlbldJTDZobnlkZm9kaitTSnRNSnVP?=
 =?utf-8?B?Yit4L3BDLzhRcHA5UWFmZ3VrakpOelFMbytneXJIK2xOeHBhRlJON3NVcmtj?=
 =?utf-8?B?Q1BtU3NrSTg2NjNoNlN1M2t1T2gzeXM0elk4Yzk3R2swckxQbUNsVHUzK3Fs?=
 =?utf-8?B?T0V6ZEQrUlBmTGsxVTFMRWRJUXdVR25GU0xFNXFhMHVYb1FOK25ycGdqMDdG?=
 =?utf-8?B?alJNa1d3aXM0djhCS1BpeHdLQlUrMG5CMVM1RFN3U3o0dkJqS2NvVThDNXZm?=
 =?utf-8?B?M2ZnQWU2cDNmcHBlb3hlTVNISkJDU3h0RXZURlVyVlVFODVuOE50OGs3Zk90?=
 =?utf-8?B?enh3aDA1NGFRYjJoQkZVTW9tSjNLQXhnWFVBUXV6QWVLeWdjYkt3VzRYV0Rs?=
 =?utf-8?B?eDFMcWhvK04wekE0TVNRYU5Cc0k5V0t0ZHpRQnRIbTI5QnBzSXRLeFFha05k?=
 =?utf-8?B?UVcvcGFKVjhxUUx0WlpCUVQ0dWxmcVZ1TUNXQkZGS3RXU2pKQkp6cy9nUUtH?=
 =?utf-8?B?VWVvM3BQeEMzSlZEaUVZVlM4VmlFN09kbEdxVkt6VEZPV2lFRzluUkR2ZXVa?=
 =?utf-8?B?VXVBdmtUSDlmVU5vY21hMmZKRXJ3UDNWaHN2Sjg2MVkxUm9pWXh5ZmdaN01p?=
 =?utf-8?B?MTZpL3RobVMxQk5ocE1PUit4bXpRZUdPeEZhaVRTYWRZK1poMHZvU0N3MW5P?=
 =?utf-8?B?OXdwMzhQNHNHLzBvd0JBZWZmZ0dzWko0OTFQTjFWT08ySmN4SVMvR29LN1Nq?=
 =?utf-8?B?RWhQclRQWE9LRVNHMURzUmVYY0EzTUFDc08wZEpwNkxPTnE5eFBNV3Z4aitk?=
 =?utf-8?B?ZzNVRzgxb2hQamtackExTzkwRXg3bmZvTjRlYTJYNHNORlB5TzQ4Uy9RalF0?=
 =?utf-8?Q?jcC0XR8qO8kIDeCSFB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28282a02-920e-4b6b-50a9-08df19a1ac90
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:37:08.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDbWC1gYtLoIxm/9qn3avQykOtH9KCMP8p3MiBGG3HCB9jtPkxRYS1S16eSMNqAo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646

On Tue, 15 Sep 2026 09:38:14 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> The IOPF teardown is done in arm_smmu_remove_master_domain() when releasing
> the master_domain on detach, under the global arm_smmu_asid_lock mutex.
> 
> A later change will add an IOPF workqueue flush to that teardown, which can
> block on a user-faulting page-fault handler. Holding the arm_smmu_asid_lock
> across it would stall every unrelated attachment in the system.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
