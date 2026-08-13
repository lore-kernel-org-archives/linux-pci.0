Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18412E266C;
	Thu, 13 Aug 2026 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786584056; cv=fail; b=tx/+m3NNVaVGchGCHVzBRg32zA7rmJRk1aDltAF9vY8Cg5A3mobtS/g7EqfnqJBQdeO/kvG5VWBLtx9tBZOyHMYoGuLDNty4Dwpn6mY29Zt9ABfsbW91mqzXWiBG5NPa/U0cMIf3pxZw5ZB/H5yHKfVvjKACnlL6EvjmUjOSid0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786584056; c=relaxed/simple;
	bh=gtShPwcbG9ELqCInAWTF6qm/B2IdBqpf/xidZ4pMoxY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E8FVcLdirmWFVeGEL149ZUie6IUKvGJO8GX8WXCUavlQ9e7Pnqs2+XqYpQTw4eb7n9gAkkUH+yw//XugubqLRENYIi6++DfmsvKjL6vJfphGJ/kOTHf6OkYCoWV3nL7TcWYYXh5Nw4+qKUe8GY2h7xe0F6yktS3MgnFmmwKQTV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ap73XyBS; arc=fail smtp.client-ip=52.101.43.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ap73XyBS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtQbLNmhPKXrkuOoNoUuCMHNQJQks+4OQ6rF7birjg05TNisFDjWPGw3QDjx8AtQJ6+1ri1VB6Tk0MkEvnJql+poEzUipLbRgRfKiNSTQMzA8YnCvw7QZHYUpW2GNv3TioOhKAB7w4sFwawgHN3P3583GNVGyCJdze/fbjsC0fxLOFOK8JAeLB1MPxjJb00u3L20hE2WO1iat0MgtXxq5GubUHbA8PwcNdwAboy5p3JlFXjRC841R/ZRcI/9XlgjpdUZoTasSNY6j2ZGS2kzAsV2BpJ67dt58soNzZ/dTX3HsNpvn1p39HrMT0Hc40Ho598KMdojCJgWSqZqDhYWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIMJTlmiVGx32QvfcwObAiTrxJTMASt8QFuS/lrWUis=;
 b=SD5jHjoZeoDRM+SmamEeLwm5O1Lq0GgU0Imx9Z9PkntT1jRAGp6T9NtWaUON0sdkjRztZBZQ/R/EvE5XDiq/SI9r2cXhAo/OVOTtIAUNdJhws5nCH1WaT9EJq8jlUgSpKqvimTfhMJfS+KLc6ncHebqUzNxGo2nTFVB5tyYyMhUeayqRT70SWJQK/UJbm5uYvDVgZrbo6RYDmETpTCYHfcOO9w+jf7uueTNYlFj2Fz+uCMJcEpqojIq4L82Qc+lX3ivMbBKsRDUPqjMOl1PxSqoF/zL6fjbduLczDrtW1a64Q4ewLkl6kfrGOOKNNoSkpiNs5ZSfxQ0kBjDbK1zubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIMJTlmiVGx32QvfcwObAiTrxJTMASt8QFuS/lrWUis=;
 b=ap73XyBSfPe+99AmmuyPSj5e+XMAPIGkmNCwl81VgvfLS/WQSH6O0eKw8BFX94K1Rfr4v3Abdz8KtbUN9nLaD0Rr3IVDOUToVKTG2+6dPyGczrJNJUTUhXbl84b/pE5SX+vIpgkavLUN23xoNonPcHMm8oy7aen4A83uWzHqH97BtaNLt4bU9U9WzKrqTF+CgWESwOuMA0jOT0LDu9WrZ9Fvh2HPNTj6DdRe0q/ePEN0wDxDo9jEGZeLe0dxhiUXInYYs8h5tZ/nTL1XSag3nphzV5s1TAsbmKqh3GPxNSWC5L/PDxC6UnPMp657SK69O9T+FKh/LI5kvRtt++vBfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.11; Thu, 13 Aug 2026 01:20:48 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 01:20:48 +0000
Message-ID: <4048251d-7989-4818-9e66-21d06188570d@nvidia.com>
Date: Wed, 12 Aug 2026 18:20:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Rework PCI IRQ vector code
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com,
 kwilczynski@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, tamird@kernel.org, acourbot@nvidia.com,
 work@onurozkan.dev, ttabi@nvidia.com, apopple@nvidia.com,
 ecourtney@nvidia.com, shashanks@nvidia.com, zhiw@nvidia.com
Cc: driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260811233952.3000968-1-dakr@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260811233952.3000968-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 90aca93e-87dd-4cad-c195-08def8d91afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|10067099003|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	FuajjDb3mOPBL9xgSo/hxhEYwKcO18t99whjYVI7xP5x2Ggy+HVTuXIXVJsR9yNARl68mVDYLVh8VKyNQ8ng1BLxFUHAuGH2bsCFzS/5IRCV36mPwv/kFdN3Qp/ePXMKmRCsl9UU8UdFCtGxXukenlYVGvjGuHF753Gf7cXF0R7oJn8JaWAI8A6gwf3GEuYSVCL6K/KOJIJWCT5ETJ3nBC/vzXmuQ2T9aRF8tMHqAvaiK5pPOVQzIPSXP7xye+lzAIVKPqOLPFayvm1H9pMDa0WhZ2X9Od9+rYiVVGG08H3ksUMRy7lM/nCSm+I/weuQ+9n4Brp1BufM3g0T7gy42lcRA1c/nSxViYSF/X6Ug1/WlyWIKJMtYaI2RDlhiCf0BfNdXAtWYTJTifLBVZAZacVUf/2/fmNrQuRvz0fCPhKcMQBeHbT/K45i1I+dk+E4gVh5KMvBeglnChI/Su8/rpAkxm/1BBshf0Z2UaIPI5NXhm5DKPsJ29GoTAfjf6su2AKf3cMwzCrNlaxuPsC6uZS3Pd7mNHd3keEbwOdt/83XpA4GK/UGOQbXT5BFvtOfbTCYDJt7s8gVVB+WLBGFf6yHNY2tF7UWiggtxqa8pdupy/edFwKvftTg/XHTC+I3fpCCNvFWN6VOPQDBS+4kUngMLz70sCMcUsEIHp/aKDqmHxQC/9IN0OHDE8DB1gSjWecpUX06irUWfA0FrScSzw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckZXNVVqbFFTOVd6MXV2UGVzbnVNNmJVL0RxMVVMYmpsM1NrQzRWMWZKYy9H?=
 =?utf-8?B?TEFoTEgrL3hwZ2FQUmN4S216dkVQOEtXNitQNnNERVhZeFhHOG5qaXdXb29X?=
 =?utf-8?B?VnAvRi9CektkcVlwSXVjalF5RmFpNCthSDZoWGZhZW16YXZ4TElEdFIwVlAv?=
 =?utf-8?B?Q0FQRHQyZFF1OERRcFpFRG9tZlZNUG1nMGlvRlZ5Q01HejdxeEhTenNVMFJt?=
 =?utf-8?B?eVpwU2Jia0QySHd6elk0TlhaQkNqQ1gyRVhnanJvRStuK3NLbjc4NnVSRDJY?=
 =?utf-8?B?UUlnb3E4LzVOUWl0bFFHc1BNclR6azhUUHJPZTA0b0RodFFEeDdJU3UyTHND?=
 =?utf-8?B?eFg2bTJMM0Evb01FNVA4bHVTK1F3V2x3aW9WU0h2TjJubzBkRHROQ1RXZjUv?=
 =?utf-8?B?bGdWZFljcExYbWJXazNPdytMMXl3d3UvRm1NODVsVUtYK21HUWoxN1dFYUlk?=
 =?utf-8?B?QUJHazJxUGpUTE9XN2ZLdXQ2MGtqOFNEZ3RJcjdxMm0xdmVHbitCYXVIZWl3?=
 =?utf-8?B?WDJ4NHVUd1JMSXcybXZGL1MyUDZDMjRsWmJoQ1dneVBNRjhsT1VZalBWWFFI?=
 =?utf-8?B?eGN4c0hVTitYWERyZDZQZjBWWVN6R0Fhd1ZhV0wwbmwxMHdJVHREZGtoRTZw?=
 =?utf-8?B?REdXOHUzRmlrZk9pZGk1WERYZlBzTVFIazFtWjJEeXpyVzljQnp1WEJxRmVt?=
 =?utf-8?B?U3c2UlJ0VlR0Nm1Tc0o5OWg1L3pJR3daSzZubUV5YkhpSy9rb0hVUjdwYnJ1?=
 =?utf-8?B?UFFPVHpaa25pMHE1VXBhRFMvZHdsN0ltU2pzWjhEd29Od3FESTl2dUptenl1?=
 =?utf-8?B?cWQ3N0M2cnA0UEltc3ZNZ1JuQ2U5MGNjTFFDb1BETUd0Vlk3NjFQZjNkOUFF?=
 =?utf-8?B?UFArSjNKWERvcldoYVhRTXlES003dThsV0x3SWs4L0pHQmJmbVZmaEFXYTht?=
 =?utf-8?B?TGNIaGN4Y0VLUWpuR3RQaTZQdFBmMkVyVjJEVG5DUGoydTZwSEhOUFJkVG1y?=
 =?utf-8?B?MG9XNmIrNFM4bnVIaHJrZVhyQVlSekhnekZDWWdub2V2WWVaMDVjUjVlSzVX?=
 =?utf-8?B?QlRQOVVIOFlya1pOTnRDQmcwNHpScXpVRkFwZW15RjFza2NrdFh1bzVoVllm?=
 =?utf-8?B?SlJZTDEzbVQvOFBSc1ZVL1R6YUZIZFdwR2VCandQb1dEQ05kMTNaOFZ2azgv?=
 =?utf-8?B?aDdxWUJrOWtjWTJ2eFJnNGp1aGl5cG1PS2I2Q3VnaXNBcitZYjJ0amlud2Y0?=
 =?utf-8?B?cFd3am5HTWVvazd2MFphV3BXTzN4YUl0N0NsQTFWRVhFVVNxc2QrbEZYNyt1?=
 =?utf-8?B?MUJreWh3WUltbVBISVkyeHhMNUpqWFFaYlJMdUZIWnRIdnVnQkpmUE90Y3dk?=
 =?utf-8?B?VGVzMzN5TitTdTNZT3d4VTY4RVlsOWUweHJweEtmVjE3SUY4UmZTZlYxTHNm?=
 =?utf-8?B?ZjJsLzdibTB1cWM0UzhVYVFIbiswbUZROFNBWGJuVVE3VkdPd3hhaEtDbWZE?=
 =?utf-8?B?VkJ4YS8xd3h4UWpGWnR0TDBuVnhuUEVvTStPYkNnZXFScTFUVXBnSXNCdnM3?=
 =?utf-8?B?MW9tMlYvQVBJR202NkhLWCt5eE01bUNKSE4rRmFnVEFYOXZsMTE5VW9zYkFh?=
 =?utf-8?B?SW5OQ1ZMVmdpTGwzY0hGQ1BGTGRabWZ2ZW10VFZTV25xTXhOUlkvNXdrUUs4?=
 =?utf-8?B?S3FqZkZTUEhKdGdFaHAxQi82dkJjYjRMTlhuTlJYdVNPampJK1BwK1NPTjVo?=
 =?utf-8?B?MnZDZTFtdUNTYVN1OXNHMEx4amlQTEIyTUh4L1pBaGRHNm45ak9yb0dWVEYy?=
 =?utf-8?B?SHFiZVpQMlZ5NndTZnhnQ1pmVVdyOVc2T1AwaDJtWko4RitPZzZpOFNSNTNn?=
 =?utf-8?B?UUg0T2pjS3NPdmF6NGRtL2JNRm9uZmY0L1BqdStjazRJL3lHdEVDc25EUWdo?=
 =?utf-8?B?ZFhmOUcydTFaOEhnRTZFREdlRTNxbkFzajNycTVvL0ZaUTBnSlBKVHlma1Rm?=
 =?utf-8?B?Rllqb2VaUzR1WUJXYzJqclJzVmJYczR3WFdzU2ZnSk9GczArcVluTUFiT1JL?=
 =?utf-8?B?TUVwZk5HR082UlVmVHVpSlVrZ01Ha256N1crU3JtYm5CMUYrNmdSM1EvSGpY?=
 =?utf-8?B?akVNamRwODFlR1cvMzNTSWp0RUZUNVM4VGVuSU91NUZuSVR6ZUsxRmdxTkw3?=
 =?utf-8?B?Q0pQZ251dUZnMExlb2FEUjJvSlVIcjE2ZWpOVFZxZEpZbDJub3dJL1BheHc1?=
 =?utf-8?B?bllWTFg5UGFyT1NDcGRBVlFiNFIxZi9uOS9DOUxuc1hCSTFzdkxDTUZsY1Ru?=
 =?utf-8?B?RU5UQ213Vm9zQU1tM0JDOVFMZ2x6ckgxdUJpcnlmMERlVldNaEF3dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90aca93e-87dd-4cad-c195-08def8d91afa
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 01:20:47.9267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrmLCLZFyCU+5dSPIe9RJBGmkvRvmdqVds/hRdtrqHrm95hMdt4RWua//sXPpCp7338bY2p6kkfPnYeg8dJ2SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118

On 8/11/26 4:39 PM, Danilo Krummrich wrote:
> This series reworks the Rust PCI interrupt vector abstractions, motivated by
> review feedback on the nova-core interrupt support series [1].
> 
> Convert IrqVectorRegistration to a lifetime-managed owning type, replacing the
> devres-based approach. Since vector() borrows the registration, the returned
> IrqVector inherits that lifetime, preventing the allocation from being dropped
> while any handler is live.
> 
> IrqVector embeds a resolved IrqRequest, making the conversion infallible. The
> request_irq()/request_threaded_irq() wrappers on Device are removed since their
> &self receiver could refer to an unrelated device.
> 
> Add pci_irq_type() as a C function in include/linux/pci.h, replacing open-coded
> checks across drivers [2], and wrap it for Rust.
> 
> [1] https://lore.kernel.org/all/20260808031120.363869-1-jhubbard@nvidia.com/
> [2] https://elixir.bootlin.com/linux/v7.1/source/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c#L196
> 
> Changes in v2:
>   - Drop the IrqRequestAnchor approach and keep IrqVector as a new type over
>     IrqRequest.
> 

I've integrated this version into my work-in-progress v2 patchset for interrupt
support for nova[1], and it still passes tests on some real GPU hardware.

For example:

$ dmesg -t | grep -B1 'interrupt self-test'
nova-core 0000:c1:00.0: NVIDIA (Chipset: TU117, Architecture: Turing, Revision: a.1)
nova-core 0000:c1:00.0: interrupt self-test: starting on vector 129, subtree 2, with Msi
nova-core 0000:c1:00.0: interrupt self-test: passed, subtree 2, 2 deliveries
--
nova-core 0000:c2:00.0: NVIDIA (Chipset: GB202, Architecture: BlackwellGB20x, Revision: a.1)
nova-core 0000:c2:00.0: interrupt self-test: starting on vector 129, subtree 2, with Msi
nova-core 0000:c2:00.0: interrupt self-test: passed, subtree 2, 2 deliveries
--
nova-core 0000:01:00.0: NVIDIA (Chipset: GA104, Architecture: Ampere, Revision: a.1)
nova-core 0000:01:00.0: interrupt self-test: starting on vector 129, subtree 2, with Msi
nova-core 0000:01:00.0: interrupt self-test: passed, subtree 2, 2 deliveries

So for the series, please feel free to add:

Tested-by: John Hubbard <jhubbard@nvidia.com>


[1] https://github.com/johnhubbard/linux/tree/nova-core-gin-interrupt-tree-v2

thanks,
-- 
John Hubbard

