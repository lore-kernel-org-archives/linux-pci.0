Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793214454;
	b=qJ9bQHilRLJXGo1C0bbgsfWKLq9fR6cvK0s8uE/wMDOdYv4OcN4iUjhkBv410W3aQ38l
	 yFpx2zJoaHw/a1dp286Hf2PvgJDLPPbLLarAVEkQvBDq66wvt1nP1O5l7Cdzyt7iHYznZ
	 pHb0E0WgrtWk5mZ57COpggkUrJ71Z8ZASy+mL29ySgHYnb3fJFPmYd28cvjjJzMc82Dgl
	 2r1nJ7ORVPGSVdWoZGt85R7qHfQN0KR4E1+dKSZAmaspDaFQ8sKjlIyKUqkGLW632QKpY
	 fjEggLGO6yY2EeW9dTG4C7mJE3uwJlgamNbf0zAP2MOc8wAXBTZ60gSlPWe72w42FWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214454;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=FqBQkBZiJc3aZ5EVHjBRh5eH41HNN+IF0XQW9DpJTrI=;
	b=nY8BdKFhNgsY6gVC2r06+w2MVbUA9yZWYehUGjf8NLiJxkN8tJRHmGuFThYbC34HbPXC
	 4njIUIqGy2BA4XVByAg3vmP5m54Vqq8vizxte/74F5Ge9n+oHJnfj4tOTX4inXYb05Dfl
	 RLds6gnepD3vT9goILPR/rdexSzVY0H0ttmERG+EQQe7F4G8wPzzXTHBrWt1STA9Ahah1
	 ki5wXKwNJ2pjOhuoN5QHXsACsiAvffcXZ2ti/0fh+MyV/5mVTlP9YTe2s/I9XXKRxOScb
	 4HPBaYcf1F1DmdUciatAtNn+hYx74Zvh6jyv26l16UwnwQ43E1z8nJyIzfa4Xt9EpMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IDPEBLeY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.70
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C6260A2610;
	Wed, 28 Oct 2026 19:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79C6260A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IDPEBLeY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhorE+zAQN/HbaEijQ5sYY3F1WcY0ft3hGrW+/UUfaEDYEVLLwIZnH7gu2SsmVCN/DG3+bnXpcWRC9mY7ZKfS1i70IrXLzG2vi827OTailoPLPpp9thGFuCUx8rVSOhHrcpFFEiLhpwIvQ1hQSaKvjNoAy7ouLhnaizsfvKvz2M8nR5tVHt8LZ6PibXfx8GFHZyBK7iflRZ0D2D7oZaZgN82mj1j16JO9oDCPC3u/6MAdVDGjt3aTibXhqH/H6h1GBUVAIv+9eUuIR0l3w/6gChmFvkZmYps0penrjjhNzF/cv5V2oiZ/xJzSUx+cLB44AqWOlQOVRHjt+6Y6/CUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqBQkBZiJc3aZ5EVHjBRh5eH41HNN+IF0XQW9DpJTrI=;
 b=ZOhExJlUAJnZzxXYhrw4X2EWs6s5kG1VcCZ2yIelcd5rAcX2dAwfAvPC1KBdRm6aZrx8g4QgUvypiAcoxF5oyMuvuGaoNKoEvJnZARJIZzFeJD9s2vH4o9yPH8O7k3pWyY1A5uBUASSwpysuYffmH/b7wF92kOTSOoiAyhGtvkqVGOTmD4pWmYjE5BlJCUtV2A9sM2JEqu5fxuYMtJoT+OWtmUyNShe91paqL6NUrU5SaFFVgUhxh9If+XTdTq4YvNEMpkpPFG3qDl73Ropq/DFnwzJLPE2atkftfZjwQMqQqvcEYj8JIpusSW2tf5Qd7j8cRNa9rFsDtungIh9wMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqBQkBZiJc3aZ5EVHjBRh5eH41HNN+IF0XQW9DpJTrI=;
 b=IDPEBLeYAmwmfdNE+4ze7PjVpXyFcOaChNnzjVV2KjjhYVLyg+QNUdCL8uftMSdEfJSs7w1ESt97cX1e6SodLy77SduQ3shKPu8U/YFQOaanNPS7KUCn5OORzQrC5wFVf/8d9/tFqw4VYT8L8syIi/QPu73xkMyJWSQnBjgPKBWGtR3hs0W/TVVrzOAhjRu5u3mSVTWPvSdIxd55KAEIXKQ1tqd2XODSijH2WiIwCtShAx2xpxp90tG37rvpiyP8rsHVj8UolDcqAntdoAqADNIXV27jFYAQb6TSnKAUewzUoLLGObyRpuO2vy5i58soz9qANSBSuyNFzyzNsig0gA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SA0PR12MB4365.namprd12.prod.outlook.com
 (2603:10b6:806:96::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 19:07:30 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 19:07:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 13/16] iommufd/viommu: Select vIOMMU operations
 before allocation
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>, 
 Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
 Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, 
 Samuel Ortiz <sameo@rivosinc.com>, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
 Steven Price <steven.price@arm.com>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-tegra@vger.kernel.org
In-Reply-To: <20261008055955.4014342-14-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-14-aneesh.kumar@kernel.org>
Date: Wed, 28 Oct 2026 16:07:21 -0300
Message-Id: <179321444125.2412245.13201160469751061592.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT3PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::26) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2d5bfc-d3f6-4839-93ec-08df3526b2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|261028144727099003|11063799006|4143699003|56012099006|261009223027099003|261026140227099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Go9Odh75RZew6lZHFfJ9GbSImHzAr66HhvhtoFZl5B5+sAHnEhflDrhSN02agIx214DILWw+iNzEOp+xCGy5ie5HHcvpGP107cugoeAyMxFeyHwoEeHX7ifNxbbqQ4jhWZuyerbxjIDQTghEP0vlS2gtq9uo0ZLg37/NlQNV/vQqnNdc80VL/CSmJXW4DPAhAD1QcdKIwla64dIoiQWd78QBuRLuU2W982fZ+ufg0pcgOUw4JZZEhgIIHv9QEV+SrjafNO+Djebz5+ypB/iWu6N8OuYWIbvhNY0tc6RRbF5/HGaxI/ODwKRjnYXRlQX3k31hICcpWmjvZrd/HBAXFjslWIUkjuiuMSwlmtCXHdetF8pL7TUAu0T/lsutvpjl3UQ6CKTmtbzsP1A5F7ppW+cn/pHLlNOmkvynKVBd+Ra/OkzrtLF/9N7PAHJ66nwgV9FsmIzuRKTk1kfx9hsHUHQRhS5qVKJiwkoezP5fLkogpkYvArlxe/rdNjaB7zXvs6NVy3M+rfwFtR5bdUqHVyLLelMNFsFR0JSCVWZy/GtvYaZB2eFqhPQ+Q6kG9PDHgZcrl3gWWLfHxflA2v1UGvhsATgxLiUpHze0ixz3PnfimuAsMIUX5Zc6tlsjipdTGLqOtklBVQWKRSAPsUiDk45YLNa81HWGGgffX2tFnoQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(261028144727099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026140227099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTUyS3dYV3NaUlBONndYYWwvZmovSWxJc3RRYVdVN1VLSUNZVmFOMWtacmYv?=
 =?utf-8?B?dkJ6OUdCQWV0OHdUWlM0MkxuUEM0U29Lem1BekFrUThTRDBDb2x1MEZPNVZ2?=
 =?utf-8?B?cTR1Uk8rSFVxeDQxbzUrTndnZW95aDVqeGoyMVFtRkU0V3N0RXpvYTB4QXVJ?=
 =?utf-8?B?THZ2V1Z3TTJULzlwSmZJZVh3Q1EvY1A2eUo0Rmx3Tk94MW1jMW13ZnZ0VmRP?=
 =?utf-8?B?dzFlY000dEJ6R3AvbUd2dmhTeDlUblQ0TUtjZ3dLZUtPZnVPYmFSNjdaZkpG?=
 =?utf-8?B?NGVwb3Z1dHZldVFUeFZMcmt6Nlc1aWhlSEp0OEpCclpiOXc4enVzQkdSRkNE?=
 =?utf-8?B?eHVkMTRMelpKYlNxTkFicHNKMU1VbTZMREF6V3FLN2tnOUliZTZOYWdaUzhO?=
 =?utf-8?B?L1JrbzNMOFRDWmJLNks0M285UnpRK1lucXpPVzlHSFBEUG9NMEtuTjd6b1Uy?=
 =?utf-8?B?N2h6VVZzZHlHK0FCWEFRdTBtSldzSm94aEhwaW1CVGxmRVhrS1FHZWZ4ZE1T?=
 =?utf-8?B?YkE1cjJRV3VUdHNLRHcycHRPNE8xTXV6REIzbWx1VlB3RENIUVprZ0RMSlBo?=
 =?utf-8?B?K2NuYzJMaGFSNVJrdy80RjdmSXorMWRWUkF2WXZYK0Y3MGdrYmNDOElhUmJ5?=
 =?utf-8?B?SWY2bklWdzJOQnZ2RnVHVEhFcE1JWVdPMFZOK0xEcXR4VHVKSkdtd0c1R2V3?=
 =?utf-8?B?NldkRmwwci9XUEdXaTR3d1ZjUExZK04rOFREU0RxNW5heG1PTkE5QnA1RlBX?=
 =?utf-8?B?eno3QXNhanlab21ETWtydFNKaTVWc2l0UXdSOHd3amxnVi9oRjYzYWN0SHhZ?=
 =?utf-8?B?czIxVEJNSkhEeWJjaGNsUysvYVZKT0hFeE5KNVl6RGQzWFZoQ0JlbXVTZ09C?=
 =?utf-8?B?Y0MzR21uZVdKNmZBbkErRVd6Qy9pMWZJa3U0TENkUmN5UTgzV3NPUytSNEJm?=
 =?utf-8?B?SW1yR3B1ZjdzaFpicFF5M09MaVBmc25SaC9JUGdPc3l2ZFdJK2RXa1RmUFNS?=
 =?utf-8?B?SDU5ZXBZN2RtTjJiaWlhUUtDVk1NRE5IbFdVcFNjREJ6R3ozU2ZZOWNiNlc4?=
 =?utf-8?B?akdnNEJvYWlpUnRTMEd0bENyU1Q4NDFpTk44b2lMTjNyZGllVXBCOHhhS2Ro?=
 =?utf-8?B?ZnJQOTdVTHlPREFNVlFPV0EyckhETk8yYTlFZ2dtYjUwTE1XTEp3LzFxcEhM?=
 =?utf-8?B?TVJ1UmZRdnZYZmhtYTlwOFpiQWtPeFMzMkhNWVVtUHc1UFQ4N2s2K2NYdFFD?=
 =?utf-8?B?eDFxRHc5TVpDVzBlOXRmd0JzVXkwdVJrd0E0Q1VtaVFMMmtENzNSY1c4OERJ?=
 =?utf-8?B?QVVySHlRWVhmWHJUcE0xZ21LVWRCN0hDUVFqSlBaMTFPdWtPb091RXlmU3JT?=
 =?utf-8?B?MTJ4UVdXTE1MSnFUMzdvVW5tVmNxR3ZhZXBUb3FLNkU4QU9pRGV6RXRTNUh4?=
 =?utf-8?B?cjdHWE1JdFZObU52bHdZa0N0WUVIcGl5L3djV0JLM3NzbTlESmNjOC9MVU9M?=
 =?utf-8?B?WjcxYmhqb0ErV1U2QlR2UlEvaHpDWmFTOHQ5bjNXM1dMaHZWTHZwR2daZzZn?=
 =?utf-8?B?eGlLM05qUUoxNHhFdHpQN0NDajJuOSthcnk0Z3c5NjNwNllGS1dIR1ZIbm81?=
 =?utf-8?B?RGFmcVVhR2V4NFgyRGtMOGdNd0l5TjQvS0U5OW5lMWpMdnAwQmRENG0vU09J?=
 =?utf-8?B?R0ExY0N5Yjl0SDVZemZsMWpGbVRGdU1mTndXOUdPeXBNR2NMZzhUN3JWWi8v?=
 =?utf-8?B?alowK0JNV2huUWFGTnRrTkVkbkFIZjVaQzdmalFDbG8xb2JZbG00TG03TmQv?=
 =?utf-8?B?UkVhOUxYMmNtWmZGM0FjR3BDd2kyLzlTNjhNaHl5QWNwUzZTallNdS9jbWVF?=
 =?utf-8?B?KzRUOXNNWVYrQytDdjNrUHdFaWFOUnJPc2lUZW9HL0duVUI3b1l1MEFTb3pH?=
 =?utf-8?B?RW9uY1NJbFhqWlBCeXFZUmNyZGFTSTlCblcvMFdkbWNwYWdlWlNzN3VCKzJ1?=
 =?utf-8?B?aTNCcFpiZTJkQVMyZldZaFN4ejFYNGdIWWp1Y0I4M3dmcG9HTzNEVDVpTFMx?=
 =?utf-8?B?K0ZYL21Sekh2UStyckdOWTA3ZE5sZVo3emRyTjNFcThQSVQxUWlYMHZDaC9D?=
 =?utf-8?B?UFpHcUxVYWdIcVplYno5QmJvZTlITEEyTjVlNFRUWGlTSFhNUkpZZmhPcDlS?=
 =?utf-8?B?Tm5FWkxrOG84OW9mWlBZM1dXa1J3YWNBbXIzOGtJVE8xMVkrQ3hUZFlFYzE1?=
 =?utf-8?B?MndXN3QvVk51Q1NCRTFFc3VaRWJJSzk3TEk4Sk9PNlAvWFROdFVEbVdWY2xv?=
 =?utf-8?Q?hwZchVS8hfSgutpG4p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2d5bfc-d3f6-4839-93ec-08df3526b2f4
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 19:07:23.9096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtiuzqUD5TuTLxsf2f187PoDslDdfxtBWyI4JQgmxwKPawNgVhu51bYHedzeryLl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365

> [ ... 62 lines skipped ... ]
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -32,13 +32,21 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *length, enum iommu_hw_info_ty
>  	return hwinfo;
>  }
>  
> -size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type)
> +static size_t amd_iommufd_get_viommu_size(struct device *dev,
> +		enum iommu_viommu_type viommu_type)
>  {
>  	return VIOMMU_STRUCT_SIZE(struct amd_iommu_viommu, core);
>  }
>  
> -int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
> -			    const struct iommu_user_data *user_data)
> +const struct iommufd_viommu_ops *
> +amd_iommufd_get_viommu_ops(struct device *dev, enum iommu_viommu_type viommu_type)
> +{
> +	return &amd_viommu_ops;
> +}

This needs to fail not retain the broken behavior if this is getting
touched..

The rest looks OK and makes sense to me

-- 
Jason
