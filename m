Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CCE399356;
	Mon, 24 Aug 2026 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613789; cv=fail; b=MTG6B8LprDKAHOavI6SKg+MG5Pzop9cmFUah5Dn8gWVTKcqfClBImz1lhS++Bak0eI7rZPmrKBb3yVdxfXiQ13+8ce+QlJhVe3Ih1YpRqXzJoYRFxIYKE9e4+RoowTsVzDJdhLDUAxSF7MDuTfGyco4U1AUUHZV3CsTqW7Mfhlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613789; c=relaxed/simple;
	bh=Rdi2pEnE6E9iRn/knfuoFhQWBSx5xRRuttOsgqnR/o0=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=tJaTOWTKiIPeaQ+D36zoPF0sJKOmv+gpGhHMZETjmaDVpBV9Doqaw4TmdMtdGSbctGh73RF8O3q2ab0s0RNruYMTMsY5Qk+ClLit5HqrIh9Mb3syovT92PIIhO16psAHKMflG0oN/zjJq0l2Wb9TmemeZwppzRt0GupR94VKs+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N7p1UEuI; arc=fail smtp.client-ip=52.101.57.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N7p1UEuI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbsQ9jh+0vekOv8zSTHM2MsAw4mt9zfec796Np99rLvL226xwrzj8W67GGj5zzBjfHQk3WMcHD8eKu0gOESAvb+WFuwfkvr3SVBfr1ulhFkkejnXgFL8gPOHyYF5NUbHfNkJAKwqR7a5Y8+3aH3z8unCJuQQZTlOtfgZBIVYjrkXcW7/6veFQP7p+QFdVOeauXyTl/6EPc6jVccSXAmmFU2FqLVgkc1SvmyGibpi03PeGJAofMsKOHW0qDN5fs8dAeiH9VrsKJr/CSDp7C8G1/yBkhzzdvJjomUcBJIWEJiQ/cQi6Z87pAYvXF1zTwzaID5x7AtFHzeMShqaoEyFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+FsaevOaVN4D3jhluZ+nHg0lYFlGujHE9X9R1bDEW0=;
 b=iShZBpaKZ4uYQuk2w1MlD5RZyxlyKsetv2JHnW6FWna51Lc17tZvVPwBWD9EZcAZlXZioPqc6omcdCWxp0AOm6Hj6uFT65U3ehzOfUDnc1du2wJwJ+bJxc3jgNBeH6v/X9M8LDpR6kXNj2ZHyT7hulsoj21aLcEIKxKukP0mftUnG+pqyoYfc7DHdK8tK9+AgMwIUhDABbNSQII8ZFb7DR44jaVuW40h1gBRo5q7Kapq4Qv0OcafnEL4xp5rUck9ncZUA5QoP5/yptN3CQTKouh3RzpdqrObV4JwRO+kgkt2N2TEGxqi7zotZnje2Ezb54f88OjH2K3CzlYu3zV4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+FsaevOaVN4D3jhluZ+nHg0lYFlGujHE9X9R1bDEW0=;
 b=N7p1UEuIduK0CZ9VXnJlx3QTngGjjybYvJtNcYMbW0yRE4RWcPTzFjkWvhfYlZ25pFCaDvGJJx2PmL+WibGCy+dqe1zsQvLB2kkgy+MzMM4BKVhSqysh1INV2FR0fTUQFKu9oBFPrIQFfyk82ibIPqPZruk70bwMABw1imSzKEiPx3xtPSKxqW2BfHpJ20QqcCd0HY/yIKFIZvWDdJWk2rYdFgeSoNYthJcvX87nRNqzcJEn5LguC3mkO4+JMupT3dJGajbJnekYdULikeN9BCuxkcBY7CMxkVaUP8wEifAHEegiBtMBvxFtRB/hGPYQPs1VwA1xnDbjebJyg9/cwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 23:22:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 23:22:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 04/18] PCI/P2PDMA: Safely terminate ACS redirect
 lists
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>, 
 Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 iommu@lists.linux.dev, Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-4-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-4-94426b96de73@nvidia.com>
Date: Mon, 24 Aug 2026 20:22:50 -0300
Message-Id: <178761377054.3197084.2344294728647079321.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4P288CA0063.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2cfb53-7388-48b2-2ab1-08df02369fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|56012099006|10067099003|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xSf7E3nlueAXbbxhSkFcrzrp5p4drkFJAMqt/f64bGsKvIQ+NoTizWjIWwh6+x97XcBSSfiCRmAAJVbh6YZ9en222gt0SlbPP4bddd1DYTluP9KBboyZ22iis8qfVMXsD4+wEDNdrRHBS5kEiXiX3YZtIKxOaqvEVnEYw3KSZJm+2qj8knq8gLKUEnWIZuY743qk+T7X2fvDhbreIw0TIyyHTAxrjFUbQwLPdFybzvY1eIZQDWzrYut2y66929LxI65cIig4bgwfuf4KqTuxXFAByDVJU/UGbwHpRnDOEVoeJ5rKEeyfwAgMcINPI3V09RyozowEW3wf1QizX9C41KNy6qRoO40Jcbju3DDKFnVq1eB5aorRUY3mcdBnwLTyGmBApa0wXhYTTbYmTuSGQ+9wgF9jMUgZoVU/Jd+5m3e7fgqc0A2yg5W4Bmrn6FZqiImLVHxZnfcsVE/7I9D7EEl86Oz+w+qq2pWixBwGxpyHfFmeQIGSmbE7+DFaHFKhPEuEEf2N2/rz021jddEoO2YEAB9U3mPWvaN/UFNMWIvhkgBRLCgETUPKvsP+6e5sBy3FGKBJP6mkIB41gzzxHKOZjfikbqE1YscGdPFw+EtVYnfMhJcBS4ckaZ2Mi1UX9h1u/BDxvnNDNr7G7slUUe0FgdxHO+8NOnCd/3pBxlQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnBPWXdXUmVEeW94TEpFK3IrcEpZMDlFUi9aY25PZlFDblpteVNHSFpzNTFr?=
 =?utf-8?B?TWd3YmU2d2hoSktWQ0xmSmc2L1lEb3Nqd3dsbUxUWDJNcjdDcnpDeWlja0Fk?=
 =?utf-8?B?eDJBdVdqbXhxVEYrNnFGdCs4R1ZGS1RqRHc4MWpXL3dyUmg5YnNxUVF3R3Rk?=
 =?utf-8?B?ZlNEeFpIR1Frdml2ZHVweGFHUktnNzBxMEJYZWRabCs3bkZ2VHE4TGlHbjU1?=
 =?utf-8?B?OWtIcU5BekYrd3RtM3NPTG9qSkdXdEdSUTlJU3d6Wk05bnkveGNTVURrT00w?=
 =?utf-8?B?Y2R1Uytvemt6TmNoTzZhbU5BOG1JV1hjSFp6QlVxYmFGWVZGS1RrRHVTTnpF?=
 =?utf-8?B?NXVBeFZHalRBNy9PbUZKaFFpU3hTQ3Q4MU1NblROMXlQamVnMGlaVkxFZ2hs?=
 =?utf-8?B?NCtwRmpBRTNuak5KN2lFMGlhMlE4VGFvcURZa2IrNm54eDY2VUF6NUY5L2dW?=
 =?utf-8?B?T3R4dmg4eVVNOFF3aWFIRlhNTTdPYmltUXVZc0I0Zld1YnJIeXhYTDE2Nmd4?=
 =?utf-8?B?QURwd1h6eTBVaXBPdUlKb0E2N280ZGx4YXFobEVZV1NqMTJwQU1IdTd5K2M1?=
 =?utf-8?B?TWVsbis4YmNmYnVPcnB0bXRPTzlocnc2MUJOeUt4RWFPMVRVNHZ2ck5ZK3hM?=
 =?utf-8?B?U2JiS016SEx4eldvSjduTDFrcUpLNCt0eTVYd0FRNmk1dTB2OWx0cExtY1Bz?=
 =?utf-8?B?OVYrN0hucW01dDBXd2VxTjh4elBjS0VMditERHRrVmNGczQxTkFKajk2Z0or?=
 =?utf-8?B?QWVrUVU3aGRHeTBuNm5sWS91Wnd1aitsL3RieWVDRkUvUnIwVmlVSHJoWStG?=
 =?utf-8?B?L0FqdCtQV1AvcDdxWGw3am93ZXhxT20rVjRyTzBHdzQvVk9uem1SdmpreEl5?=
 =?utf-8?B?RC80Z1p3Q05zZXJpSHpKRy9SNVM5VFN3UmZIbEIzM2ptWGFvMDdHMmVsMjZS?=
 =?utf-8?B?U25PYmVLQkRqaXFBVUpseFBmWk5zMWNncW9ybjBrYkt6TDR2ZUJVcXVDM3oy?=
 =?utf-8?B?UldxYTlRNHBHRXUyaUw2UGd2UWx5MjZxTW00ajh5ek5oVERUbHpNaTNEUVdV?=
 =?utf-8?B?OEZQUE1xSXhPS3RpOWlQbnBnUTZWU2JvNzZMQnNtQzNWcDcxSzNSQzdHSEo2?=
 =?utf-8?B?a3hoc3V5U1ArKzlVQVRMQWZTTitQMG9xTEx6VlNIbWVPcE83ek8xRFNTVVBP?=
 =?utf-8?B?VHdpL1B0VHNEQ3dsSkY5QktKM2JwYlRqOEtvYzJtbGJTekJNOGJib3FuTWtM?=
 =?utf-8?B?cXVLMEZncThVWmdYNGhBeU9VWmp0Q3hIZVJKUTRXeUVmUEZnMlgybDhVZXZV?=
 =?utf-8?B?RTEwdDZWSGh2SmpnSnN1R0tzWGVxNkVaYTdQaU9nVTErNk02dnpqZ0hoOUln?=
 =?utf-8?B?MGVFYkZ2WXBHcG5pVFhDdkNPSHViS1hxd3VtaHV0YnJLNWp6NzhOSmtzOUtz?=
 =?utf-8?B?bXUzVUJtWFhpVnhZb1lTUjNiTisvSGprVnhmZlVsVVozQmM5dU1xWmtpQlZl?=
 =?utf-8?B?eU9FVWgwaDZ0b0lRcG9WaGtaNFRFRS9OYmFYbVVHN25mZzh4QmFmWGFDRmV4?=
 =?utf-8?B?bVNqaTVZdHBnSmdkSWNIWVoydzlFOTJzTHlKaFFkTmsybDh4MEtKMWo1UUNR?=
 =?utf-8?B?RTFXN2d1Nlp1V1d4TnBOczBRRzBZbjJ0NDZUWXlMNVl2L2VTcXF0QTd4cnVj?=
 =?utf-8?B?WVl0RFdMMlN4eFZkUm5Vdyt0VWZSSFJxNVJ3alR6TU9hWDdWUU9BelI0eWhl?=
 =?utf-8?B?aXpRTlE4bEpienRrTS93OXFQL3B3Q1IxekFrbjRKU0swQWhDa0ljcjRreUFD?=
 =?utf-8?B?SzRIU1hXRVZZOGR0YlZPcnR5VlFncHhsUytiTlJMaC9leExnYTJtK3pYYXFo?=
 =?utf-8?B?dXhhOStwRXYxaFlDL0doVWQ2VmU1M2xKWmlJR0ZvUWlOekdnMk1ncjVON1Fl?=
 =?utf-8?B?YmphLzBGN3pGc3lxUStsUHhiN2pmaEN2YkZ2UVZ4ZFhkbC8raEl3L1l0NzIx?=
 =?utf-8?B?S2c4NzJ2cGFTVGFGQytEUlRnY0VVOUFwWW03Z2F0NVNZZ2lyU3N3d1kzbWIw?=
 =?utf-8?B?S2lZNkRTamF3aW04UFViQXBpWDlvbDQ1aG9nWnltTENDaGFxc1FyVmNlTUxW?=
 =?utf-8?B?N3BOM3E2MmhJRGVoZ1kvamhXbXU0Q3pBc0xVR3ZlY084VUVwNmpWcWthYUY2?=
 =?utf-8?B?TW9wekxPV3RVVFVIRUM4RzlOdE9peEZWUFdUWkphbEh6MlRuV1NyTWp0UHFJ?=
 =?utf-8?B?VE0wMnFndVZVY1o1MlpTa2QvSVZBQngwaHAwc3VtQllaWW45Z3huOHJaa1pz?=
 =?utf-8?Q?2nWnPlaPASYy+drzpD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2cfb53-7388-48b2-2ab1-08df02369fdf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 23:22:54.5699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCIrueQd8jrQcS5Q3uTmoytNx1TQ+vBNAZkyChl3Wdr0nmjMC2tE8BhfAjIQMR0+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386

On Fri, 21 Aug 2026 22:38:35 +0300, Leon Romanovsky <leon@kernel.org> wrote:
> seq_buf marks an overflow by setting len to size + 1. The ACS diagnostic
> path unconditionally writes a terminator to buffer[len - 1], so a path
> with enough ACS ports to fill the 128-byte buffer writes one byte beyond
> the buffer when verbose diagnostics are requested.
> 
> Use seq_buf_str() to terminate truncated output safely and remove the final
> semicolon only when the buffer did not overflow.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
