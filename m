Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795707935;
	b=bpnkeLhSvJgfWfMFsojHbHgZGRDtxQrlOJvQLidyAup6PBF7fbejEKAL9ST5EdvDFnVh
	 yerRaY21eIkH/h8pECc7h1lS7fmosVvRxA5E+YEHKvjYpaasmX8dFdW0VlE0VzbBh6IiP
	 1+xZ2d7dMkDec3SZe5UlwdsqoFI4fZxbDbh6JlfHBxvb4x3DvxGWAsT6tlluhePOOy7iY
	 ngN9QLZRpf+4F5Ff8hYOXGpGNaxdOOuDG/91UGhrsSw4IUcURp/eE46MynbfE5Kn7I/Rw
	 oQck0pmV4LrSDIrx1CVVM/TNfgiz4T2TZibAbWb3/Vwex+FdJK+puOvcFwRMzm9c+qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707935;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=IufAF86n6xwPYGFUCMhtngkCdgGyBvw8kdMobxsnOQk=;
	b=FaSvoxs3cYjuw2Th0NJdfs5g7+FT9cU7UibptDTQ6hkxG9OYcJvnY2rfnehVKPySRK5o
	 3x7HSdxTQcVqM6tddpxg5zHR8r5FMB0d90duTUcTcW/gxtA0S4KZZhI2OTXqxj3wrsImw
	 z62zJzQ/MByNjvwfMmDLzlDOk5UoKvNE7zv/L5Dmje/8x8snZ1vTYOzNuv+/t7WSHuSrk
	 6E7OA43xsG7NjG2XWFOgRX5nK3RExN324BrflY8ACPY5kndl2M4VnGqel3Q6I7vMcj+8o
	 hB2BT+m/V+qjFW46dlslTM8pxq9fhuzpnA1DZ+MGRyxxlvwAxMu3CE0ExTX30yZ1WYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K0W81e0v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.10
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694F606A329;
	Thu, 26 Nov 2026 15:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6694F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K0W81e0v
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkUBjfgp8AUjxoxc8pa2hgITqLv1GGdhsMWcC7dhYBRt12mUbIx7Ojvevc6EA2M2vKxY+f4vhci55iv7vfC8ArFamOU7FXZ9bIhHXJTJJhrvoFPoPy4EHeQT0hIREAMX3ID5LkWLCGNA99QH+FC01QTafoEPsTTbCD0wnHT9CtBTBbnB+NsTtNmXmdTXuEZs43FB1VAdPpUQOdKBx7wQCu3wQY7cRiEiIKq4Q1SlqmI+lDHPDqIyzpszfvNkSCmGSxppGYk6VLT489sByTjHluAT0H8CRkUG9QzGEmaTqKao1Pu7JjuMQ53EmpDQhiLPAvyOiXTDFB+JyAQQATwckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IufAF86n6xwPYGFUCMhtngkCdgGyBvw8kdMobxsnOQk=;
 b=VkOOxwqhGp33m55mYuVqTTVawYYKl1Isg6m0tGulUJFobb/tPF9LtniSEz7Tknq3b2YHIiDvmtcN7tPomnptg8jKXyMguwf9q3uTj3kE4jNn+jcpRyWorCZT+p/pTB4wb09TavXrYnP+PSWm5qdIRJe/wjE9D52TCT6/t2YFkkk4f5ckmS0YILHFZMAUqlVF2MnPMNASFH6aVkiz5t/mtUR8iqWB5bZfX/efwmZ2fNfu0nmdPN8pNhVYwgUwLLPiIHbrmjppdEn9GZ6RayPrZygpDGBjKP6ncITRro4il32gfSYAbkNxcs8a79jLr5R9xHfkLZ1bwkZV5K1+tIuXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IufAF86n6xwPYGFUCMhtngkCdgGyBvw8kdMobxsnOQk=;
 b=K0W81e0vuiKEG/gINGAr/C94gJKsudTo60zdzGHkgVp19GpPDPAbLqjI6pQdPCWoWdGcnRG7xdaCkQH0ppUly8gvTxh/L7tSoQW/dHeqCpNoYGpDp8lZhki2qzGVNfIGPH8sS7KZPhStGKXCakPflkx8FuC1P9MUc+KgdfearI5JPKCwH9pYMNDCSTnYeh39sMocYjXA8qbEwwBOq+lJt4MFIL035d1fD7+8YeX5nD29C6rcqWqYiNlChpmYVU2JEB+GmJBgNIWCZKTEWQiTV+Vv5bDlSf17BOd5FZ9kZdLiwZbRtGZ61in2IjuBhqLu8zIsEcX+fJDvG2KvjFIsZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8)
 by CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 15:45:25 +0000
Received: from BL3PR12MB6548.namprd12.prod.outlook.com
 ([fe80::e916:d870:8994:46c0]) by BL3PR12MB6548.namprd12.prod.outlook.com
 ([fe80::e916:d870:8994:46c0%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:45:23 +0000
Message-ID: <227509f2-834f-44fa-926f-110c735b30bd@nvidia.com>
Date: Thu, 26 Nov 2026 10:45:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] rust: vfio: add common VFIO device handling
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, kvm@vger.kernel.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, linux-pci@vger.kernel.org,
 Zhi Wang <zhiw@nvidia.com>, alex@shazbot.org, jgg@nvidia.com,
 yishaih@nvidia.com, skolothumtho@nvidia.com, kevin.tian@intel.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, jhubbard@nvidia.com, ecourtney@nvidia.com,
 cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com,
 ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, linux-kernel@vger.kernel.org, zhiwang@kernel.org,
 boqun@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
 work@onurozkan.dev, jgg@ziepe.ca, bhelgaas@google.com,
 kwilczynski@kernel.org, dri-devel@lists.freedesktop.org, peter@colberg.org
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
 <20261119215046.2892839-7-xinmengs@nvidia.com>
 <DN4HIQ5VPWEI.FFVR53SNX54Y@kernel.org>
Content-Language: en-US
From: Simon Song <xinmengs@nvidia.com>
In-Reply-To: <DN4HIQ5VPWEI.FFVR53SNX54Y@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::35) To BL3PR12MB6548.namprd12.prod.outlook.com
 (2603:10b6:208:38f::8)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6548:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: e23959c2-29a3-491c-3901-08df4bd44853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|6133799003|32116099003|18002099003|22082099003|5023799004|11063799006|56012099006|4143699003|261026140227099003|261102123227099003|261021121427099003|261022105027099003|261028144727099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	1wS1lR33B/5e5P2CkRZWccOaZ8A9demL0ZbfTSWbGwodUK2O5GLiXoBVEBRMdrFpZEj3ZgpyiZrN0j5ZUVeQcf6z1BXTsbTOEPdijAjxIpBC8qC8tFb6EUYVKxmmdxgtxiMwEjuc8apCXsZRKB+iP5FBZrRQf5Xsl/6SRgXH9FTcHDltpkFAIzrfRbiF927ylTWNzqzRRMcj4uKzT0ThfKvdvc2bWqUTTTWfqDSS+FwQg1oKJLR26u5OVVBfFGsKp9z1mWyobVPT7N1vejMBVn5FfP3IFDQhEPFu3/wjc38VkAitilIXOc9QBUePN0CtlMn9f4acgCE2kEnx7y89pue7MoXvXeJPBlE7odrNLnIsM4cTCSqL/PZaRf9j8MSsnWKmgnxemUFC77jtvxI3z2WmoQVuUNfJCKiIVAfHLBIgaCRZSbaaHUbaIXOnl5ex+k+xsIL0/H/ro4rGBm1LeMaKPNwDPVHcjr9a69ebKiJtdUuyIo0fCahZKWV7p0Cd4PkKfYIfmOVfiE4aSPy5Ov/Iri4WBbaVneXrGkb7fMSN6/TS+AhnJH5JBQKqWsKtClPaqyMomYkLXcntPaz4C8XQozejqjJvFLf8FhVqR73SnRCOQeXaIC1fM3lG8envzQqrUm2qax+t930lO3dYkHBbxCLoEw0PjldJHOEOd8Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(6133799003)(32116099003)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(4143699003)(261026140227099003)(261102123227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEZoSW5PcXA2c2Z6MzNyL0QxV0ZoYk42T3QycmhPMzVVZXpiQkQ5M0t5dDhG?=
 =?utf-8?B?VlVndEpXTkxJbzVvblhaWUZaeWwwVlRNeW1SSkZXajBYYUljWGlqU2ZoR2JN?=
 =?utf-8?B?bXFCbzhaKzNhekZWZ0pMNEh0ZjZpektjU1Fqc2R5RHNVVUhxRGFINElaQytl?=
 =?utf-8?B?NHpBS3NEeXFPQlRQeDFPUkVJdmR1QlN0WVZ3K3VQWEc1QVMrQjBjWUNsMXh1?=
 =?utf-8?B?bXhHd2xVbThJeGdhMmx5YzdJTWZHZCtQRjFkb2pNMWVabU8xcGtTNEs5S1Vt?=
 =?utf-8?B?VFNXRTdqK0ZiZDMxTHRNSE9SMklEbktJdGtLa2ZENFo2cU9XbGlmQlVLa2Vx?=
 =?utf-8?B?QTFORmhwQTYwL3FpYWZNQm9qbkVDaTlISWFkY0h4ZFI1T3BYQTBDeWtQSGRU?=
 =?utf-8?B?YXdXSDVPeHYwbkhMdllsTFNsWS9QeWMyemswZzlCWUI1UEtuZ1JFWm1Hakhp?=
 =?utf-8?B?NG5wVmozcjF6MHo2Wno1eGNCN1g0UFNMNVhnUTJTR0wvUjdZU2Z2TndQM0Ni?=
 =?utf-8?B?Z3VxU1VSeU96OExNa0x6cEFCQzcwTnVvWGUyVkFwNDBWbDk5K2QwNnVTZlcw?=
 =?utf-8?B?MXZUeTlJMnF5RFF3R21BcEczSmFobVlDQUt5U2hmSFlWK25OZ1Z3RWNOU0ZU?=
 =?utf-8?B?eFdjV3MwWkRSWHBYUHRaRkUvMzJLNmx4aGloTjhWNklYYXlzRTlzTGN3YVkz?=
 =?utf-8?B?c3l6U2R2Z2FpMEF0QUp5VXp2VHkzbjBJdVFxS1dXTlpBR3YrUHpkcmRWVkM4?=
 =?utf-8?B?eTRMcjZsWk9sbHpPdUpXZzFqaXE1bU1QeDhsU0ExZHJQSDVPK21xaG5udUcx?=
 =?utf-8?B?TjNLZzZkTnpzRmZJaUg3L3NreXRBZytOZ2ZvOHcyU2lMK2Z5eXIrYy90bDJ3?=
 =?utf-8?B?eHdPNklMakJ4M2RiU0xyVkZOL05mRXozOGtCT3FGWnpaaVA4ZXN6eW9nZUZK?=
 =?utf-8?B?cU12alk4Z0Q2cjZDZmFBRXVlaS9LNDFKbTZkbXQyZGphelVFbjZpam9HOXRu?=
 =?utf-8?B?ajZUdzY2RENkRjdOajVZOTRWbkE5NnJGQWJTWS9CV3Z1TEtza21PYm1UcjB2?=
 =?utf-8?B?ZlV6K09mWE80MmZFSWxnR041L0paNUJWdnlFZXNsUlQ2alUwSjM5ZXBNVVJk?=
 =?utf-8?B?MURlYUREMDRiaXk5QVZmdFVqUU1mNnI1YjY0b2JPT1RMU2wzOTJJalFmRHlp?=
 =?utf-8?B?YzhianJzamxGU0x0eWg3L1dVbVlka3BuQTRMSTVBcFRhcjZkNGxGRFY3MkNJ?=
 =?utf-8?B?Q21DRDNOM2VrZldpQ0U0TU9jc2xseE42bkNicTdjNEc4d0loYTB1NlZnU2pQ?=
 =?utf-8?B?Q1c5ekZ1Q2hTWG9DL1N6VUNwMHRYMTlQVGRySlpiT0tJR3ptVis0VHh3YnJM?=
 =?utf-8?B?VGNBNStNRllldThWYXZtNVFna2tXS0JXWXYvNzBGbmpBbk1JTUZyQXJONDlW?=
 =?utf-8?B?Y2NpNHZaeHhKRGNCUTdmUmdlYi9uSm5BTFJKQlhoQldQUStHZW45NWFLanRE?=
 =?utf-8?B?WHFJNjBLaGdEdFRhdm4rZHdtOW9FZ0ppdURDUnNXNHZBZ04rc3BJbHpVNEFr?=
 =?utf-8?B?Z0tLY0lhcGRyU1ZkbjdRYU9aMmtMUE5SOXFWZC9XNVhxd1FyWndUMWdJVm5k?=
 =?utf-8?B?Ny9aSkxZdGRIaU9zem12SkFRQjdjU04rOWMwK0Zhc0EvSy9zTlFaZkFqUUpx?=
 =?utf-8?B?NVZ6djlQcWduMTNrbHhwUXhTVXQ4U0t6bHpyNXJKY3Vta3V2Tk0wb1VJK3lQ?=
 =?utf-8?B?M2c2YThLeHMzclNsYytkYkVUV2p5L3pTeTdZdEdrSlEwcVgxMGFhU1lnOXQ4?=
 =?utf-8?B?QTRISUx5MmcrQnpZU2QrTGpwd2paR0NzL2hHdmdmU2tuakhMWUNkbUVidHFz?=
 =?utf-8?B?djdWUnA3UFhTdUdCT1MzcjlDU2FoMjVreFBTT0FTWFVmN0dlcjBsajdWSCtp?=
 =?utf-8?B?MjJPRFYrcXBIMTlCaUU2YkRaRjkzbXFaU05taWlCZGNsSDNFOHlBZENJbDVo?=
 =?utf-8?B?YWwzK3hDb2NoS3BkeEZpZE9aaFBYbXkwK3hDcUE3QlhrNUg2d1VwdFMyZUhm?=
 =?utf-8?B?TE96T2hXRXoyMlRjYjhndWZxUGIzMzRaYk11ZnM5NSt0ckl1SmltK0hRbUtz?=
 =?utf-8?B?SmFGUDJ6TlBjeXB2YnYvbnNteUhEdzRvbmthMkMvS3dLTnhxaDNsYU4rYUpZ?=
 =?utf-8?B?MUFFcVljZnhJTVBDYndpaWJOOGRkL2ttY3l2KzRadlRMMnZUREg0a2p2Y005?=
 =?utf-8?B?TnIxcUFJbmV6WjVEbGlQeTgvT2FvdUQzY0h4WldycTlTWWJucVZBc2I2M05u?=
 =?utf-8?B?bjhwUXBVelpYTEhnbTJNQjMzL3BTUnJHSTZzbnVzSlNwdURvRHcwZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23959c2-29a3-491c-3901-08df4bd44853
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:45:23.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4ZkHV7S7/sMkcJQ8oWaiTZhh0dGG0wuJ4u684hKrCE7mc0mxiI2dj5ZQaUH3kWbS+Qkv4vTi0pwMelBUVZzVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170

On 11/25/2026 9:57 AM, Danilo Krummrich wrote:
> On Thu Nov 19, 2026 at 10:50 PM CET, Simon Song wrote:
>> +/// Maps a C device structure to its embedded VFIO device.
>> +///
>> +/// # Safety
>> +///
>> +/// Implementations must return the address of the `vfio_device` at the beginning of `Self`,
> 
> I think "at the beginning of `Self`" is not a safety requirement for this trait,
> it's an implementation detail of the current implementation on the C side, that
> could be a type invariant of DeviceBase.
> 
> Besides that, I think the abstraction we currently need with DeviceBase and
> RawDevice (which I proposed to deal with the current implementation) could be
> simplified if the C code would be more flexible regarding the layout of a struct
> subclassing a struct vfio_device.
> 
> However, this could be a subsequent consideration and nothing that needs to be
> tackled now; it is mostly an implementation detail of this abstraction.

Agreed, we will leave the C side change as is for this series.

>> +#[expect(dead_code)]
>> +impl<Raw: RawDevice, R, O, T, Ctx: DeviceContext> DeviceBase<Raw, R, O, T, Ctx> {
>> +    /// Initializes the Rust fields of a newly allocated device.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `this` must point to an allocation with the size and alignment of `Self`, whose `raw`
>> +    /// has been initialized. Nothing else may access the allocation during this call.
>> +    unsafe fn init(this: *mut Self) {
>> +        // SAFETY: The caller provides exclusive access to a suitable allocation.
>> +        unsafe {
>> +            (&raw mut (*this).data).write(CallbackData {
>> +                reg_data: UnsafeCell::new(None),
>> +                open_data: UnsafeCell::new(core::ptr::null_mut()),
>> +            });
>> +            (&raw mut (*this)._context).write(PhantomData);
>> +        }
>> +    }
>> +
>> +    /// Recovers `&Self` from the `vfio_device` VFIO passes to a callback.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `vdev` must point to the `vfio_device` at the beginning of a `Self` that remains alive
>> +    /// for `'a`. The caller must provide the guarantees of `Ctx` throughout the borrow.
>> +    unsafe fn from_raw_vfio<'a>(vdev: *mut bindings::vfio_device) -> &'a Self {
>> +        // SAFETY: `Raw` begins with its `vfio_device` and is the first field of `Self`. The
>> +        // caller guarantees validity and the context.
>> +        unsafe { &*vdev.cast() }
> 
> If we rely on this layout guarantee here, there's no point to have the RawDevice
> trait dealing with the layout.
> 
> Either we add from_raw_vfio() to RawDevice, or we just remove RawDevice and make
> the layout guarantee a type invariant.
> 
> Either is fine with me, but maybe the RawDevice trait is a bit overengineered
> and a type invaraint is sufficient.

I will remove RawDevice, then DeviceBase gets the Raw which is the C struct that always begins
with its struct vfio_device. 

Then as_raw_vfio() function can use the same .cast() like from_raw_vfio()
