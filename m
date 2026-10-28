Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793214453;
	b=ocbU6BQL2Rwj24zo+k+Y/Hv6ChFJzbKK+dz9CAQv5LpACp+oNxwpg+cK3Dz3ahnr/lw0
	 8Lh3cOWGYvnmme2aehZ7l1a3oZvS8ePKdFb5dHeeKVg2uT3uGbINtHG9sjsrnDI7Zq4ac
	 1D1MepHBpas+jHjWgunFd3ZmROB231vyrrbGmxftsS5otaDTDzBcEE4l6roj07EIe9G6C
	 LXi1WhEmyQ2p/1GOEkK9RRw5mQfDgD7JDCurx45Nj2kmfH9+TTPR6NKfpJL5HfJe+/4HM
	 DFYiH94RghJ9+XwR/iy6YfXFOIirI8uAhs8gQ6APWBS3RGUMdK0WUUc59rbm6NmIaTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214453;
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
	bh=KCQhjbUNYiGc+oxyQw2tELnjDGziXAz71hHGb/HH7KU=;
	b=bcQtZegtNRw5pGU+4emiqreOVGZw6/fvB8CLkdT4h0q/x9T4g7TAwtx0nYaWuTFSv3cq
	 ILYn00P3b61hBirFvd8yR6aQmprZ+oABuXLOOLingOSZB/AZd5Srz2Uqlws1Se7FLyKgH
	 43qYpecXdbutu829BukwAXY2AhiRsKfmJN81l5m2gx7bgQjfnsT80ke7+KJGUzXmSJU/f
	 pjN4VrHFzkqYoaGmNsPrgYs5DKdXu24QUjQr+2zbOtgokFOQO086fBj601doNzhSjrxon
	 /9JtntJJm/0+w+Xq9uQ+CZTN2ST448YrpzPeWZgMxmDL3fUYTbuBDo0hSgvOWmbw3dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iKn3Xsyx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.46
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7EE606BFBF;
	Wed, 28 Oct 2026 19:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE7EE606BFBF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iKn3Xsyx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVXGUBaGt7Op4H8wqPGUgaeeQw721efffdvPbfMoKpHZSgmfcrC+K8IlCKoH0Dwuf4SoCK0zuEXbIOwD7/qBQfGjmMGDXNN/o/4HJni2TTcKdTYjS+mW4r3B8atm7TbThmj6Xf/3QMQAHmJqA/dBpZdKes8xE8wyzrJ4Cd5BbCWLLzko+fxUoWqz3q4Bx9EPRpDDu2l2Ok6DVz1V6tcpknKVcP/eKxwZu0lvyyw8AMZJWhSQAgXDSDS/cjOQl3KMFgOkG/lOSzlWXab3Uq/jSp5errQHy6GoZIx08xKxemed9orE7THWa5OvPNT/dT4n8a/1bgebAJB4z0O7xprOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCQhjbUNYiGc+oxyQw2tELnjDGziXAz71hHGb/HH7KU=;
 b=FofG6BxrzCCEI5hPOL2sR7drUrnb2nrODN/SWqqC1w9n79sE94hpxtVWquuVfpJ8rB0gb8BH2xdujRIEmKGBXO5FDlVLf5YkeqGYP9N5JSS1Gc+v5hnXCqP7xXZM2EE5Y84r2+dbJpCd2qkSoS3W3eF0q7ohKAwwEwI93x4Q32TMZ7mIoehQjuVNALKW5mfWHkrfsEPF4zX7qDuagO0R3cMn+PnsYahPlmXR4hzCILRldqJqYordTQKpORrf36d5vF/MgmRvXEesHKxvedN9WwYQx4z9EvzPorngXw8oiWsa+I5SMTbU5Dvr0YJo+Mkvto3VTFcaTgKOPI7UzTV/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCQhjbUNYiGc+oxyQw2tELnjDGziXAz71hHGb/HH7KU=;
 b=iKn3Xsyxvuaa70YTgYhVB6TBJUiiTyioit9b0IGyQNjl7WUpTgJmElF01QDxqB1Du5Gjd/fDVGfLC0viHUpYK0hjjHEDGyB8z5zUYKy2Xw3Zwtzr46QF59+mHAjJZ94oEAirGdT6bSK9parIFmGYLS04yP2BNt0UwcxziGDZAvNeKgTKcAXnE8qP/cj6JtL5h85X2/H0dNb8Zuc8PhexcUD/iUMHymENh7Vaka9Buu4SVvrvbK9CTfDZu5PQj0/ysAyWyM613sjwOylfHwTCdcW/fxvPPFs0Ou7sI+tPz4gbJzCCtZfeEG+HbdVJwJa7cpInuh4IAoZIVD89vtmPBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CY3PR12MB9629.namprd12.prod.outlook.com
 (2603:10b6:930:101::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 19:07:26 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 19:07:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 09/16] tsm: Remove the device from lookup before PCI
 teardown
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
In-Reply-To: <20261008055955.4014342-10-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-10-aneesh.kumar@kernel.org>
Date: Wed, 28 Oct 2026 16:07:21 -0300
Message-Id: <179321444108.2412245.9613928294789740313.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::16) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CY3PR12MB9629:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5c860c-f9bf-4540-60ca-08df3526b2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|22082099003|6133799003|18002099003|261028144727099003|261026140227099003|56012099006|261022075727099003|4143699003|11063799006|10067099003|261021121427099003|261021123027099003|261022115727099003|261022105027099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	L3UM8BNy8CAhXc3IeEYXqy4RCAfWHg0dxGRY4XGCRlPfsPohvJvUNeSpzLuK5VUFWmFN/OW0FAxRXSn3kiiZi4wq7GR43mN3zZ0TI4aZm8jqR4a/kmsyDMgTwadKwu1hOht9zWKnlRzeG+1Gd9HF2ZbODo5TxnviDhz0BlDWdMzwN5/L7vbMSfRCS1ohk08o88oDb7fr1aZeGhaSFz/UG2JEsMCHX7hnOky7KWP2AjFa+rNsgLyFbi/XwllzF23LO9UBDOfI12FRG6hxAyyCvaVkTNFBanrynSneW9k+IJLGukm2SL3rewFy2iENGeDpAPyzVGOrWMrk2Af5GTd/gUEYEW4cJwQ0PGIpV7tn7LKfWddzLycRKnigog/ETnAvDUu0Aghiu39zRXFErHoov+wJ1x1IrKzGP5Y+5Fz3OCz/zoisFvt4NlgGBh980BqCH49N/kBFFWw4b1bv2sWfCchsQqiqnuKVVhf7mVTHct1S3zZIZEugr2mXORgoo2wBj1lzZQNEJgR1KbIhMlv5lrnI+50psfE561eLfkYAoNshXuKmcJZKUD6/fhUliNRCA4BGS5dwKHjgmdR3YYc+b0gOXG1MrvSwrCm4F22PRcq4MMST2MFg8fR18grkMhFThjlD0y43vEYuf9EF7AQyYrVr+VTNJhCnLjPqfhJOxAk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(6133799003)(18002099003)(261028144727099003)(261026140227099003)(56012099006)(261022075727099003)(4143699003)(11063799006)(10067099003)(261021121427099003)(261021123027099003)(261022115727099003)(261022105027099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0xLdllXSEhZdWRPMlZLNkVxMDZpbGd6cXhzOEFMM0tZOFpjL2w3VGFqTzd3?=
 =?utf-8?B?SDQ4aHEybE5GSXN6c0t2NURXWFlZVzdBbjB1dVhEK0cxUHpHU0V0a3hidXUz?=
 =?utf-8?B?d0tCVmllMERHOFNQb1pJWlhFM2E4LzNDeWFOZUlra0RBWnNWOHU5UG9YcHNR?=
 =?utf-8?B?U3JlejN5N2FvUkRybG96MkJ0ZXVSaVoyMXA5VjFxMGRCQURUNjN2TDdBdFpk?=
 =?utf-8?B?ZWpKTFhOMXhBdVUwTm8rbE5ReW1PUDJJS2t5aTNkV0s5cVkzSlhFeDdnRmpG?=
 =?utf-8?B?TUYxTjRLaER1K1Z0VGdpb2NUemNKZWRmQ2VYOEJSZ3U4YitrZkp3dDdYTE9E?=
 =?utf-8?B?ZEM5Z2NXcWlZeVI1K25hWWxkNzBsVHlCdWNPZlFMNU5idzh5RkZqay8xS2tI?=
 =?utf-8?B?V01OTVV0SlM2bmJIVUt6aXZ1Q2JlYTlYSEFBMmxRVHBlK2VUMVZyOVQrcWo2?=
 =?utf-8?B?UTdHNVlXRVU4UTFIMmdEWUhVTXorT1QzTEtjbVExSEdwYlF5UkM3aTI2b0k1?=
 =?utf-8?B?N24xU0kvVzYzWXJEYWMxSmx6RWJ4bFlpUkJSaXpRKzVsbytXOVJKL3VHZjVp?=
 =?utf-8?B?TUxiSGVINnpORE1LU1JXQ3VOcnhyNHJtbXdQNGtGMXhrQ0c2RjM2NUdjSjcv?=
 =?utf-8?B?MjVDejlYdy9XdHdxdlpvaGFTaHhWeEhiUmFEK2w1dm9NUGtJYUFtak44ZXRa?=
 =?utf-8?B?NUJlMUY2Q3BVUmNqc1A3VmlHby9aSjI0NXl0NUM1ZGhqejhWTld6a09VYjhs?=
 =?utf-8?B?Yi9Fd0d0ZVZJU2FWdGIzSXptNHk0R0EzUDdHTUlQR1RMYTk2eUkzNTdSL0VV?=
 =?utf-8?B?LzFST2k1UkUwM3cwRVcyb3ExYmJjeXQ2MUJpaEhlUTJDQnU5TldnT3pFbmNx?=
 =?utf-8?B?SmR3eUM5a1Rya3VneVkwK3hNK3RZTEt4eGw5UCtWdWFaY3UxYlo3cUFUcGdI?=
 =?utf-8?B?a0ZvT2hIanBIcm4xeGxBWFJYRlNadWdjY0trUEo3MVB1RHFncUh5Z3h6VkpQ?=
 =?utf-8?B?NzRQaWtDbnRDUEwvQjFwRlpKOWJEMjF5eU40eE9yZGl3Y0dUQWUrSnRRbTh3?=
 =?utf-8?B?SzBIQTl2RXhjdlpGblU0bWtLRnNTeVdUaExlbWUvZndURFFuSG1Ud0d2a0l6?=
 =?utf-8?B?TVRXTDdFQTA3VHYvZGp5Q0tLaTNKakZ3dlh3RlpXWWx4MFVQMzJmS2NuZEFu?=
 =?utf-8?B?UXArQmVGWTM3V0k2ZmZibUltYkFLdE9TVnRtbUlEMExSbXpRZ29HR2sxb3Zi?=
 =?utf-8?B?Y0p4Lzgremt4TUtnNGtVbTc4L0MxaVZiUys4TElRZ0c4SzF0M0FHTUVyMDFY?=
 =?utf-8?B?SW91MUlrNy9TS04rOTM2TnJHYlRIMFBNZ1lVNGRwQkZwVkl3SVJxL01pT29W?=
 =?utf-8?B?YXhteEpOQkh2a1VvQko0aW1qMFIyZk1lNmhqTUdsdVJ4emVEZVRIQW1QdmtL?=
 =?utf-8?B?TlJxMktMWDV6YVRWV1Bib2Y3QXBRU1RYNUVnRUlWcVlNMURnZ1FUZGxtemVy?=
 =?utf-8?B?TGJ3cklINGFJQ0NJc3VMNTRYYnZuRXpEN0FHaVVLNnN1YUVyQ3dua1J2VkZX?=
 =?utf-8?B?eVIyWWNYSlRFUzFVOWhWRmh5OElnVTBEY3NpbWpNelg3MmZqQmhzTTNqeUYy?=
 =?utf-8?B?c1BTSnBhVW4xQWtwVlo4WG1TRGFxb3BzOTRCa2Vlek9IMVFPSEVwWVBvQWo5?=
 =?utf-8?B?UDN2dXZZTi9YQ3ZWbTNKVXZScTM4aGdoSmlVWFBJaGIrM0ZkVWZabE1LRWN2?=
 =?utf-8?B?SmlhbDNPM3MyVU1hQ3FsMzVRcDZ0c3o3QTYrOHhPUmNrTVU2bDhPb1V5Mndj?=
 =?utf-8?B?eEdYK2FCSlArNGZtMVI2R1NFVGpDVlRHamxKQ0hCdmpiTTl5ajYrK1FRaEJK?=
 =?utf-8?B?QmdzQkJXam1pMFBFZmZnMnAzVkNFMzZCa0hVUE1KeENXdW4vZm9KZnlvWlJj?=
 =?utf-8?B?MldUazJsdXdiMlFlbGN1S0EwcWxCNkJzOXJmMUpJZ1JIaTFyQTFCY2o3cmQw?=
 =?utf-8?B?WkZ4QWM3bEhNMWVjN1p4OENJdkZuL2tXZ09nc0U2RTl3WHJzS3VZUkV2elQ0?=
 =?utf-8?B?ajdkVzBSc1cxRmhPN1daSHltdWdoNzNWZmFkTHQ0K29wMFd6ZS9lS1VyR3Y0?=
 =?utf-8?B?MWFHdFNhNFByb2NLQ0QxY3gzbWE3cFdocEdQWnBDYmd2VUdPdU8vRVVUdmZp?=
 =?utf-8?B?MHIyKzVHdUcxWUdKeEU1dWtGOVU0ZEdKRUlWekNkUzlqdVNuLzBBWThORS91?=
 =?utf-8?B?bmFJZ0RKbkJNQytLR016a1FJSS9ibUNDSVVkU2lQK3lsajgyYzBtc1RDc2tZ?=
 =?utf-8?Q?ShegG1aeXNFE0OQcZ8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5c860c-f9bf-4540-60ca-08df3526b2c2
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 19:07:23.5610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQ2pMv16PKkLhL57C5Gtxx3JWLzbXmC1dsLqd2WBUW3CUSB1hlw1BLQJN2dDVGmM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9629

> [ ... 22 lines skipped ... ]
> -static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
> -						 struct pci_tsm_ops *pci_ops)
> +static int tsm_register_pci(struct tsm_dev *tsm_dev, struct pci_tsm_ops *pci_ops)
>  {
>  	int rc;
>  
>  	if (!pci_ops)
> -		return tsm_dev;
> +		return 0;

Aside unrelated to this series: Do we need this NULL pci_ops stuff? I
don't know what it was imagined to do, but now that we have split
things up attestation subsystem I wonder if it would ever be useful?

It is quite a maze of unused layers in here..

>  
>  	tsm_dev->pci_ops = pci_ops;
>  	rc = pci_tsm_register(tsm_dev);
>  	if (rc) {
> +		tsm_dev->pci_ops = NULL;
 [Severity: Medium]
 Does this unprotected write to tsm_dev->pci_ops introduce a race condition?

And of course sashiko finds races in all this unused complexity...

> [ ... 14 lines skipped ... ]
> @@ -96,15 +95,22 @@ struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> -	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
> +	rc = tsm_register_pci(tsm_dev, pci_ops);
> +	if (rc) {
> +		device_del(dev);
 [Severity: Medium]
 Can this error path lead to a use-after-free if PCI registration fails?

 Since device_add() is called prior to tsm_register_pci() in tsm_register(), 
 the device is already exposed via class_find_device(). If a concurrent 
 connect_store() finds the device and proceeds to pci_tsm_connect() before 
 this error path cleans it up, it will attach the PCI context to tsm_dev.

Fun. Usually device_add should be the last thing in any driver flow,
not the first.  There should not be any device_del on error paths.

Because of races like this...

> [ ... 6 lines skipped ... ]
>  void tsm_unregister(struct tsm_dev *tsm_dev)
>  {
> +	/* Remove the class lookup first. */
> +	device_del(&tsm_dev->dev);
>  	if (tsm_dev->pci_ops)
>  		pci_tsm_unregister(tsm_dev);
> -	device_unregister(&tsm_dev->dev);
> +	put_device(&tsm_dev->dev);

This makes sense at least..

-- 
Jason
