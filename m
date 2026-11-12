Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794486360;
	b=uLSrlACFJJqPhD8iwA9pseLuUvWilY9iPgPyTifm3UuX1pkffjYcsJCnXXP2WCJai3C6
	 7axSLAqVpBoeMed3HgLqzr6tychgq80BC7+X23g06mSVgVHNI0BN8qKj28Wx+jmiIAfcV
	 wMQ+foLE/DYdQC90Z5/wBtju3bJkVdmcB5Wt98w8Q7QfJ6txB+FQ81oQ7L3ydZJoykPCs
	 mBsXqEzeu0bn1Px5IUjX1xc7Ku56wxFB88HXwlE4xaLalAqPcNZPF3L/M/CKyzEDkUFic
	 vAAI0mOE4T9smoxzVfEUaHc2udK6gHSANB4sEVLiVZ6QjWkAGvR2E8zWuzNhHsXp7rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486360;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
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
	bh=pO3YEKGxi+3qRd5rGZDqJBcroU+l4uX2l6hv38gngDE=;
	b=Olwwd0zzq2JCPnjT7y2e1WZdNzx++VNLNRETI+l0rQrDbuK8U/PN4mh5hM9xOLWZK/TH
	 jIogt4OYPMeUQq2HZ2jLpCOzVz7CjToC8ie8FrLKcSIJUmkxigWxrjGwXeYIJsB1/VXfj
	 9uIhJCnN6EDQp3iMBPAlGhapiW/xx7cbGVYH8qNR5TiVDrq9oNBCeQDlycVFXKDYa8UdY
	 VsLedc3dHEZblAGGCJJ/7V8vgDQGl99GFb6yE8al+ES3v/HQ2J1Gjg41eshYvUM6NSs99
	 TivJlih8QakANbUOAWwj8gDGYjHu8DrgPN9PIN4Twsyl5NohCMJVz5ChcxNKoZOHoGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Y5haXcI2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.52
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B7C606A31C;
	Thu, 12 Nov 2026 12:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8B7C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Y5haXcI2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQYUjLqUzQxSex2VvLS71snSDnnoEIqGSJ3iFFfonTLcdmpuny+xzjG3g/sYXtOmBGONFqH1IUo3GETEXVpHh8z5ce0TOZcOCnjeom1hKSwnDDDJbFJ2XmZa2btThCOjymdCtv99DYXpiIXK8mLBFB3qV6wJN1FEBp+C/H+idMBu4rn+KlNuvLSXutfbmsPw/NjLqfOB2SqjloDAu3LtFwHUDFeo3sysGfwhAuRHlAGQPzstkrB/dbECwSpJE2ToKnFSer7mScViejEEIJBbcf8Mr9ivCIetidqHxUFW9GCwMaedOCErbbUipTMiQ8EKBKgzdL2pCzYRwHG5IOsl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO3YEKGxi+3qRd5rGZDqJBcroU+l4uX2l6hv38gngDE=;
 b=QMFO7VN1Ra4wsj0SvpLSP25upAlJKYzXRlLVuBS35FsGiOBhC9oP+YKB88DP7k47iVGQKllgb+jhXJ7aUeua1/y47OfIoPaFF/SunRUPjRqjMlgGUNMckcdgOpNEC3EaJqhHVv5V1y3Jhx97T/qO1JwxKKjZ22x2QnVOAxY0SN4ULDSoTlNlq+NnQeIrGkCb2VXCROWp1IGhMsa2q/z6EZ2R0ELdw7Z6MhkD+o3lAJEg5BfJyFlN3JbG8Z5TLC0wkBo8xr4FIxBSXDa/rgmjIGSbnE/PkannWZYsUCOB6srv8HGp+VcYUkqyWrDCo/gMlkzxKdrQ07u+zt6/GjFe2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO3YEKGxi+3qRd5rGZDqJBcroU+l4uX2l6hv38gngDE=;
 b=Y5haXcI2zDd0kJRNnCxAGWUoMoZi7yjKcZe0pK9Ww0M8UdbUx9/QPNWUkFb3AeDZjXAQnVtf2fqkGaYryNqmQpwYG+bNmR8MCLdsMLBR/ggzhVu6Pdhdgmv7uN93tFk+m4cprEnguHn3WtYnuV4YSn6wAV3U8AfBZ4IhTByMUsU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 12:25:56 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%6]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 12:25:56 +0000
Message-ID: <97053bb6-c221-4ae0-972c-603b194ec25a@amd.com>
Date: Thu, 12 Nov 2026 23:25:46 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/15] iommufd/device: Hold a KVM file reference for
 the device lifetime
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Lukas Wunner <lukas@wunner.de>, Nicolin Chen <nicolinc@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Steven Price <steven.price@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-7-aneesh.kumar@kernel.org>
 <CO1PR11MB4835982DE81AFE060EEE01B88C762@CO1PR11MB4835.namprd11.prod.outlook.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <CO1PR11MB4835982DE81AFE060EEE01B88C762@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY8P282CA0017.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::24) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4d9e9e-6899-48c1-b747-08df40b8199d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|261009223027099003|18002099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|261026140227099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	SFbBhZmUBGbyU3KQ4BC2JUG6eOWvYIOdzuaLP+70mVGYditDrPPB+Sp27r0OX9m7rYsPjZpLl1dGhKwV6BwlM6P+escBaVeOyM5plMtBBXYEaAFqabS+Z0KrutRs/6yiVIVkmIL+kAGZM0iVqnkmCdpLPEm77/UU2KbDl2OuFW9Odh0qGK4Upq0bzlwKsfQLHKACIaTTSup0u4KrTlC6+iSZ2d3R8tF4N9sWCwpVdtcwyf+v/T3yOrEdJFOtbfGYNuRRZxSl4jV7Zph1XiCpGjJVqlnIsNyB7eZaASlYbgjsZZuO88/xrCV+bX0CKTk3ity42wOpX/k2Ff/vDq29DTuOF2uzBBzKtvnTK/cgGR7Cmt+w5S5GAQRg4m386SWq5+kGWF3P4Pv7kj1n9Jkf5PbYuNzDZtJFKKaILe2uxdU+uDj7eqSn7L9Q9jXG74kPkyin1+FyF2iG5r31PqpfjbcyNg5lcVIadDP7tIWMRCu9IRou1HFjYoCI9QDu8xgRvpI9efo9E6jEvTiWaOk4wyfYMdSsVsnyvDn1B1ntrX0zsEhpx1AmXYEhFcX664MzYtBnWABRnZ4IV+yYDqIhM2FiuRJXbJ6XcWTVLYaoEyz1x9lHZP9jAVMRu3n2nlCKCf20m6BzPsiHhZ80GHGhA4oJnF6+mZ3CMeUjeJ0XiIs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(261009223027099003)(18002099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261026140227099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0wwMTVIVHZPN1FpcFlsT0Z5Z1dDMlVDYXZEOVZ5MEcwY1ZZQXpzNm9rcUto?=
 =?utf-8?B?d0piZ2t0S1NVV0hMK2tEWXhBOGtzY2tscHZPbkR6Y0ViMm9wM3BmQ1ZmQjdQ?=
 =?utf-8?B?RmVTSHZDWkFQSlVvbTBkSjFjTmNpWUZlampzZ215RGdCQWgySFhZalA2ZEdY?=
 =?utf-8?B?NjZLT3RyUGdKZVQvRTdoNytuR2FmcFBNMndya1lvTGk2cGQ0SHlwTnpsZ3B1?=
 =?utf-8?B?bDF0anV1c2NxSzNqNEZlZWwvc2EzNmF6TVg5TGgwQ2Q1N2ZJRHBONExxRmxH?=
 =?utf-8?B?SkxlblhlTHRTeVovZ2VSdEY1Y1EycFAwdDcwNUJkUGxUVGJOZzZGS045cFJS?=
 =?utf-8?B?dllRaWdZM25JSTRObkQwekRZZXpEVk5DMXNsc0loeVFqQ3FiSjdvdUZDZHln?=
 =?utf-8?B?b1NKYjhoV1JHdmFwWElJL1pKeFczZUVja2N1TTJ2dnpGajBDYjc1emM3R0xn?=
 =?utf-8?B?N096UnJlYUVMWHFzcGJpSTNaMUtjTzN3V0dIcTJPZUFTeU5WZFVOajcxZWNX?=
 =?utf-8?B?K00vOUJDQWlVdWJJSUcySUJWNkxYdUJxOUNGanJYekMyd0V0dE5Ma3kwb0RU?=
 =?utf-8?B?OXhXNHBJZENReDR3SXVhTVloQzI2OENhOFE5ckhVQWhHRUFaZTFvQ3dhQ0NM?=
 =?utf-8?B?S0pHK09lTXIxUG9SUmZZelV6N25HUHdsTElCaHJlZi8vWXMvZGplbW9PeVor?=
 =?utf-8?B?TU9OVG56clZaZWJiMzNhR1FlelRxbmJJaXNoc0Zibko2b3dvcy8wWE5FdzVI?=
 =?utf-8?B?MmJzMDBlUXpJWWs1MmVOdE1BNlFuVWlRS3dZbkhjRTU0UnpPNEM0ZmEvVWI0?=
 =?utf-8?B?bVVWdWs0SkwvTkNmb1dDUUludDl0VDhDbXhXS3ZpdlVYRFpoM0ZoODdibTJn?=
 =?utf-8?B?Ulo4dncydFdpSUlkOVM0YzBvUEh5ejVlZXNVUkpNNzRIUjZsS3NWeERkZnNo?=
 =?utf-8?B?OXJoODNLOE9yRUExbC9GZDhUYkgzVkpYWFNXYTJpS0ZYZGFPNkt4dmZtZERr?=
 =?utf-8?B?UnA4blhqYStaVGErVGJZdTRkb0VwRThhbGZNL3JqV2MydHc1Q1pmUmJjeUdD?=
 =?utf-8?B?T2lMU0txNjZUZlhhT2V5QWQ4Mjl2cTZHUzE2RGVkd0RLck91cDBpRG5DclhC?=
 =?utf-8?B?QzRJZnJJMlloTVFGdlpsamdnc0gzbmw4K3lNMjMrazJ5TjJEZ3dGek1pd2dw?=
 =?utf-8?B?bG4yUTdXK2k2bnNaQ0F0aXRaMnAvcW1Uc2xmbjJmMzNPcmtnb3Y1WDhLMnVI?=
 =?utf-8?B?dmIxM1JFdy9VQlNLQWl4NG5Ua3A4WGRzU21qZDB3THF2Y3BwUjJaNkJuU0JX?=
 =?utf-8?B?aU5yZHRqM2ljNVhOWkM2VGppczdvdU4yd1ZocnEvUUFMUi9TWnVVZFAxaUpK?=
 =?utf-8?B?Q2JRNEV0anQ3RkNzY3Avai9ZYm43eUZ0QXhVNXFuajFhb29yNklnUTBycXQx?=
 =?utf-8?B?cEg0d3BGeHAzVDhTeXJkZHJ3ZmJkcm00UEY4Q1BmNTZLMmI2eXNGY1NzOE1q?=
 =?utf-8?B?YnFTcWtMWHd1U25mRldCZ3VOYmVrU3ZOZ1M3MjZBc3RhRE5hdFMyK1FONTBO?=
 =?utf-8?B?a1pNRkdOUGhUUmJZU204V0ZIMGUvY1RDOWo3aEhhUVczWVB5WGZtMGgzb3hW?=
 =?utf-8?B?YkdpbEg1N01oMnZFZFNoWHhnSXBWaGQ3eVZMekc1K2F1dko1ZWlsYkhhWFpH?=
 =?utf-8?B?VFM5MW13YUNqRzFNd3hWRzlqVnVWMG0vTEl2SGNxSkh5cnhwakdITUx2Y0dk?=
 =?utf-8?B?Vkg0M2l1U2FocGNWeXRZL3dMUmh2TnJ1V3YvWDAyV243aTZFeUI3RGpsODl3?=
 =?utf-8?B?bkY5RVF4dGpLL3ExM01EY0txc0U2dXZHWGF3T3JFSGVmZjU5SFk4di94dlh1?=
 =?utf-8?B?VStDTFJXYnJ1djU0bnc1VTFSbWE4SGdwRHowUEVpdlQ1WGtZWjdxeHV4MCta?=
 =?utf-8?B?aloyMmY5eDdyQkIrVERjbmJjdC9najRvZ3FpQTNPK0hjQUdBdTVIM1J3QXpO?=
 =?utf-8?B?dnRWZFQ4SkM2bXVnd2FkOWthajFmczVwUGhlYW1aSUttNkxRQXZod3I4ZTlI?=
 =?utf-8?B?Vis0Y0g1NVNYd2JqdjlHNWttMEZyZkNlZE90T0ExbG5LMGc0THVqeElvQVhL?=
 =?utf-8?B?QTUyWGxSNHBTa3dNYlhMeEE5MDNFenFvRVNnYm1Cc2lZUlIyODB2aWFFS0VV?=
 =?utf-8?B?VTlFWEJScWRHb2xUT21KTVhYMFpLRUpxU1VqTWloUFUwa3c5d3VURUU4bVRt?=
 =?utf-8?B?VU9Wb3JZbXQ2bHdyU1ZqNHJnenVkWGY4eEZiS3Q5WUttbEQxT0tUd3JDTEdm?=
 =?utf-8?Q?Wuq0kfl4CedOay8yfZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4d9e9e-6899-48c1-b747-08df40b8199d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:25:56.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWLaChzp0Ih1ZjEDmbKjZOp1XPZqIaUd7NUx5niTG48Kfy2qpLeh4u1rt/uzc1QR2QqD2IYC3NuZhIpCmz20Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320

On 6/11/26 18:16, Tian, Kevin wrote:
>> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> Sent: Thursday, November 5, 2026 12:16 AM
>>
>> The KVM file stored in an iommufd_device currently relies on the
>> reference held by VFIO while the device is open. Normally, unbind waits
>> for outstanding device references before VFIO drops its KVM reference.
>> However, REMOVE_WAIT only waits for 60 seconds. If that timeout expires,
>> the device object remains in the iommufd xarray.
>>
>> For example, an IOMMU_GET_HW_INFO ioctl can hold a device reference
>> while
>> blocked on a userspace buffer fault:
>>
>>    iommufd_fops_ioctl()
>>      iommufd_get_hw_info()
>>        iommufd_get_device()
>>          iommufd_get_object()
>>            iommufd_lock_obj()       /* takes users and wait_cnt refs */
>>        copy_to_user() / clear_user() /* may block before putting refs */
>>
>> A concurrent final release of the VFIO device file takes this path:
>>
>>    vfio_device_fops_release()
>>      vfio_df_unbind_iommufd()
>>        vfio_df_close()
>>          vfio_df_device_last_close()
>>            vfio_df_iommufd_unbind()
>>              vfio_iommufd_physical_unbind()
>>                iommufd_device_unbind()
>>                  iommufd_object_destroy_user()
>>                    iommufd_object_remove(..., REMOVE_WAIT)
>>                      iommufd_object_dec_wait() /* timeout: -EBUSY */
>>                    WARN_ON(ret)
>>        vfio_device_put_kvm()
>>          fput(device->kvm)
>>
>> iommufd_object_destroy_user() warns on -EBUSY but does not propagate it:
>> iommufd_device_unbind() returns void. Thus VFIO close effectively ignores
>> the unbind failure and proceeds to drop its KVM file reference even
>> though the iommufd_device is still alive and its ID remains usable.
>>
>> Once the remaining KVM file references are released, a later ioctl on
>> the still-open iommufd can access the stale pointer:
>>
>>    iommufd_fops_ioctl()
>>      iommufd_viommu_alloc_ioctl()
>>        iommufd_get_device()         /* finds the surviving device ID */
>>        get_file(idev->kvm_file)     /* accesses the freed KVM file */
>>
>> Take a KVM file reference when binding the device and release it when
>> the iommufd_device is actually destroyed. Release it before the igroup
>> check in the destructor so that bind failure cleanup is covered too.
>> Document the ownership in the bind API and device structure.
> 
> I don't think this needs to be fixed. There is already a WARN_ON()
> in iommufd_object_destroy_user() and many bad things could
> happen afterwards...

imho it is just a right thing to do - hold a reference to the pointer in a structure.

> If we really think an ioctl could take more than 60s in sane scenarios,

It is quite possible when some TSM operation involves (in)validation of hundreds GBs of MMIO.

> it's a more complex issue to be handled in iommufd core.
> 
>>
>> Fixes: d8bb80c8f0e5 ("iommufd/device: Associate KVM file pointer with
>> iommufd_device")
> 
> btw no fix tag for an issue introduced by an earlier patch in the
> same series.

+1. should be just squashed into 05/15. Thanks,


-- 
Alexey

