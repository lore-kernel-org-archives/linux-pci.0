Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793214454;
	b=jkxsTgCKMMCi9WibFxECUGhPcwM+I2jdCVKQOkps20Dg/6VB0F3tf7MGdA+FPNFb5AAk
	 KiB/IcbutC4BBXm0HxmqFVT6q8prPuS6FhRde5WR43/7oXQqhNleaky7yNaqJhKI/0BBm
	 anBUHx4QzEUC5rtlVY0W93QeOQG5N0x4w2JRGqqHwg/j/iaoSEbje1BCi6YkNvQ5fj34q
	 fOBp12cfqytHVypc/PvFh7kcopZWOW4bCcj03BNCbjFswCHSIgSOA5if8VCg87Ikqx/W8
	 pfkhrzqol9jG+73mqkfHhztXn1CFNpWPyKBM+51BW3cnjqQ5MVDTo4xb5d3qzYKa6IQ==
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
	bh=6zksAGDY9gANj61Y3pDAXZD3wa7FdDHzfCi5gLTBwDU=;
	b=Agm7XW33vIeAKeacWnkqKN7Od/b1QeFPyKUfgUUAyBLcbJGdzTRsEu/7HrKLrQcbh39C
	 ZGxeNVsz9N2DQGLzdw1KOCjEDX4A7aMho71eB9oqlpxU0fYcj5+q6mewlyQGp9tRQ5Lgq
	 fXJyGUbK5zhqz22okPVf1stSGmFUcQ78KFCxYVHL8wycJh5EqxgBy8rnzlB+6UXLTwofI
	 RDz5Ou3LVhzXJH2RQ0/BSYhiphDwpD8OchdDFjwupy4O/+GEQFMmrmYcokIBjtgNYhFp/
	 4jn7muuuI9ITASC2Cc2VFAqt2FKruoG9t2xWVJ4uiCny+NZCQTgCA6oNi00Yb0CTcxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r8TkXm9W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.3
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647F60A2616;
	Wed, 28 Oct 2026 19:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8647F60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r8TkXm9W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydEy8sisvkJy7eQgSBzZV0NpgaUuSzwHYOj7i7vWgs8RDZEN0vYhZlDcbOi18EdQcC4+piN1RNNX52ZBHj6WJec3tkgBuzbG7RB8JioFNf9VuVWk1TWmjp5jt/YXhMPXysAhH+FgsjXDMf8Q1zjILJzm1FX2beBZB9zIweI++LRqLY/X4jFJCq7TQ/dh7r0wHsMWypQPtViIxGz8mtqm2etzeZp00u7oG6ZdV6spDrdRSln6ZxtZ9VMpepZ7UJ9UifI/jy2k6xSCOpcyeSftizKo5VoKIdZydngLRB0SnLVV/NfH1K8x2IHdfsLM+foCAYOB4/JDI1Eag4w+WERh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zksAGDY9gANj61Y3pDAXZD3wa7FdDHzfCi5gLTBwDU=;
 b=p0C93s+iwWeXx0oI8OxIwZoCbw4RtGfCgKbmQOiKuzdC1jsKCawa8dgO+I0NIadc/9PbS6MVzC7bPEGBB/pZqBKLDYIxzYGi4SMxz9ueldu3MYVOr30vOrWEy/OICmsP6BhASUamIGPleC24YWLgpvTKuAQ3Py6gKY/4QGlRNBmdmF57FrrranDv2PKhRNydLXcewXi2EQfsgXBHokUmnY3J8qI9ontEx0hfQBZKkd919dGyGaKQmgN27q/4MlQ5yHZJ4OHfoLJmmFO8sx5bH82LJeJ9f1wH8BmJdhJ5VCCW3LXF1bpqPhBe5PDFUDKXju4ASMPApFSFUPXHIOC7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zksAGDY9gANj61Y3pDAXZD3wa7FdDHzfCi5gLTBwDU=;
 b=r8TkXm9W9EWSu0K5GJZ0jR2YRGfK8mOKfdat0F2x6ddFV62f3wFTN1pJqJVUhFAwA8Fl/kbEChOYqBa7EXidiw1TzcEx4Fj49BDrTe/i6zKhFQGbxjmjdUurQxI4tDnTmmEV+B8CkRBSMT1qqnoMpl8JfZTC3D9IFppvygzzhQq++vJm10YWW8YMVtYieX9+xHdJ+HCKZm7I6cvzXsgrAVwQB0m0g2unMSdN6SaUHyjqAOy90+efQQ10CL2IWUWbdbrOJOSjP3im0LtnugpnHDNjMaV0hU5afE/0LtXvkt8IPcGjjrh6XAjxZbboPMLmZxOqHrjcMnJtlf2SwovSlg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by FT1PR12MB777854.namprd12.prod.outlook.com
 (2603:10b6:170:24::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 19:07:28 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 19:07:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 16/16] PCI/TSM: wait for vdevice contexts before
 removing a DSM
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
 linux-tegra@vger.kernel.org, Jonathan Cameron <jonathan.cameron@huawei.com>
In-Reply-To: <20261008055955.4014342-17-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-17-aneesh.kumar@kernel.org>
Date: Wed, 28 Oct 2026 16:07:21 -0300
Message-Id: <179321444126.2412245.10255027974983957698.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT1PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::30) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|FT1PR12MB777854:EE_
X-MS-Office365-Filtering-Correlation-Id: de4a512e-149f-4336-fdf2-08df3526b2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261028144727099003|4143699003|11063799006|56012099006|261022105027099003|261009223027099003|261026121527099003|261021121427099003|261026140227099003|261021123027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	XY8kQ6+gBYFMEkYv0YOFEO+jagiEfOqfNenubpyGaoiFa0mepXCW/GbmwTtEmy4gEEYv93NVsq7eAIKeMZiulVRm6YdVFpR41eUKl0iIi7RGdfjOIZd8/b+MsMpr3qiWNEHRdq4HqNuPfdLGHhwP85PqFC6fnLsvnPfs9asLsCDBy40+F3Y0hvRF5IF+oVtucvaGu/Xb0cUTf6Vst+U+sFQhyrMyJ1fXMhOQwE/pQMW7JPbs9ChLgbylSh2MvlBjAyBC9x0xLdVdJM0ALixz4Gsp1vlwmpUNNeNfQOY9oPFFvM7a0i5/wVfIH4aWzArAyVqqcITEkPyBLki1lktJVrOlkMGlUuX78I21K1BvY3cUAbK0sDrQK8KJIBzv+CP8uDA5xI0wWLlysr9MxZ8ijbO4432A7vGWZZrG7jDEDaKz+XgidGmxqNoXSsJm7m9Qa4n+6eFF93u3iPEY+0C2PERtZq/upPyX6f8XTD0V/Otnt/LFtDEK5bZRGajpEPQ83AdRfkj4FS/M5nQh6bTMjvpRTFGTxoqqj1oIl1QvBv2vPQqQfun/YPLEkADzfaqe9WpQeYYxR0Vzy/zXcX2zKZEyitQOW+EaVifzyXR0fCSb/wCLyM0nVK9McTyf2LGRhbFYQYHs70zyIv96GvOBuf7ovraIG7KU1helH2SQJpU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261028144727099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261026121527099003)(261021121427099003)(261026140227099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWJCem5TSkhiZlRobTVEaGw5bUdiWUplbVpjK2htUkdFN3Bqc3ZWNVhYUGFI?=
 =?utf-8?B?dElUSCs2NXBNMVJoWEdHbXRVMW5RZGVpbjFnM1YrbTN3alhOSG4rRXNZSkNw?=
 =?utf-8?B?MmduQ09KODdabTlrQTNRSll2aG02RnlSSUFoNHZmbmtUMzY1VDlMNVlwa1U5?=
 =?utf-8?B?bXdXaVlINkZ3U0d4bERCKyt6TEg3SlNvbEl6bzVCOUQ1RVpHRHlTMU44N1Fr?=
 =?utf-8?B?VnJHa0NpUW1Da3kyem5YRDJxT0tCaldaWlArWmpYRWQ4OGRMQTdXVmFFTU4w?=
 =?utf-8?B?UEZXTDY3eWVqTThKZ3BaWWs3UG03MjBTY2Mwb2UvZXQ5Um1nTUtKb1RqWFFV?=
 =?utf-8?B?YmpJM0J2U1pCcWFVcnc0cVpFN0VwNUN1WmxpQnI1eTZ3c0t1VGJYajhWZUNY?=
 =?utf-8?B?ZDNDOSttTUl5RDVNY2xid0lyK0lwYkNRNkp0NWhQQlV4OFJWOWM5SVl1d0I4?=
 =?utf-8?B?Y1JBK3htaGhiUHU0bEZYSHdZeTZkTitaY21ScGUzUWcrTjA1ZWR2RzVXRWlK?=
 =?utf-8?B?bXBubXBtSjdBRGcvT3c2QlRVOGNueExiV2Zic3dhQmRWWHpWTGFqdGg4U0Z2?=
 =?utf-8?B?Q1lpMkEzQklQeURtbVhQcWE1UXpzWGNxR3IzOUJGNm13NkM3YzJacUxsdGVJ?=
 =?utf-8?B?eU9QS21lZ3paNTZ0K2JuOVdBMEFvYkVYdHh5bU5DN3NiYms1Q1AzaGxWS3o4?=
 =?utf-8?B?aytKSW1Sb3dicUErQ29HOERIUHc3WWViYW12RjJnazR6d0FCeDMySVUyYmk5?=
 =?utf-8?B?SWkydWJyZFQ0bmZoa041bElsVDAwUHc2TkpZSjVOUFYxSFo0Y1BDdWxzVHRo?=
 =?utf-8?B?Q1hZbVdjWG8yeUNEczNRWHoyQk1JQWhmTHl0bUFZajdDWWk0bWZRb2NDWHNn?=
 =?utf-8?B?ako0TGpLSW41THVWMUExWVA2T0FkZG0xQ0hrMlhXelVoOGdTSWNPalRWV1hF?=
 =?utf-8?B?R2NPTjZ1N2pibWd0M1lvdE5lVUdSYmJucS96Yi9uZVZpb2cyWTd2K0k2cW5M?=
 =?utf-8?B?QUlNSlRKRGtVVGRacERmWU5jZXFHWnY5Y2toQXVpLzZXdkdRclhTVjM5SlFs?=
 =?utf-8?B?dVJ3RWNSTlhkWU82bWtlc0Job29HSGZkUXo4VFJMRE9UU2NTREVJM3gwaE83?=
 =?utf-8?B?clJVcm5jaUNXVVVFK1RXeGYzYmd4M2puU2NBc3kreUk2SlZMUW5lV0ZaalZ6?=
 =?utf-8?B?U1RyeURZa2h0WG4wNkpiaXpKYThsQndzMEhENHJOZERrN1oycnJoSzNPbHhK?=
 =?utf-8?B?ejFaVEJ1TFp1bWZhUTRFeFdTVUd5SzRaenF6YWlseHRZZHFCSVBjdFg4SnNw?=
 =?utf-8?B?cUFHeDRDVHdNL2tlLzZrVk1rQ3I0WVdPQ1B4OFFQVmx0RDVNbFF4L2p0dURY?=
 =?utf-8?B?NWNQaHEwalgrVmM4TDZhVm84SzhQbWc0ZjZrMlBZcGtuWmorY2RlN2owTWVC?=
 =?utf-8?B?SmhpS3JjcUd5R3FzbGhaSE9yTUhsRTRmZFlqczh2M3laaW1yOHF4cFh3THRN?=
 =?utf-8?B?UnhjcVQvTERLRTVyU3N4N2xLSHBoVFM2d0llUVI5dmRLU0lDcVRVcXBsMklB?=
 =?utf-8?B?OWRCN0JabUcvVDI3Uzk3SjFxK3JLQ1NFMzA5RlV2VXBKTUxwSDUvNElRalFE?=
 =?utf-8?B?VDZOODFzYUIvckkzOGdSR0RmN3V0UWYvQXd3aGZ2WDhidU84QWZwSDVpVEo2?=
 =?utf-8?B?S0sxMVlXNzROenNlZ29MeGREYlJwdWpyZlZyMlZkMk85amhFQXhNQ25vRlRN?=
 =?utf-8?B?QnZaZHpGK01TMDFpZGt2QlA3WlREODNJQzBEY1lTQ3QwR2VwRUdFYW8xOXFk?=
 =?utf-8?B?bUNGTUtIVlhhY3Q1b3d3azZpZ3A1ZTh4WTVqRXpIanp1T1IyM0taNEdCUnc0?=
 =?utf-8?B?ZHdzblNyb3RDYldONlVXdjdVUHl4ZnR0Y1VRZ1dINm9EOTF6amw0QjFGSlh4?=
 =?utf-8?B?K1d0M0w2Z0FGL1RRcllFQ1p1WGhweUo1QXZ5ME9PTUZUUEFCbm0rdjBtUTBs?=
 =?utf-8?B?Rm54WU9OamNvTkR4QllESUpjb0ttQVVtcGFXeWJDaU1NT0hwQU5tUEQwUStL?=
 =?utf-8?B?eXNoV3lGMlRDYWFmZEs0KzBXTEwrU0RFSGlhYVNjOVFreTJPK01KTXA2NDJV?=
 =?utf-8?B?eEU0cGdJRzRWSXQ2VFgrR0cxWlBxVjlPZnRkMkdSS0lmR2pRV1U2RmNHSFQ5?=
 =?utf-8?B?UTRqeUsvdHA1RGgyOCt1a04xMTlYdWZCZ2RRaGNVdWZYeG5OWEdqdEhUTGZl?=
 =?utf-8?B?Wlo2MysyY3dqUStXcVF1UjYxejB3OERCTnBUV2ptRFY4S0FmY01VR2lzcW5x?=
 =?utf-8?Q?rFWI35OoLMWyUM+1NV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4a512e-149f-4336-fdf2-08df3526b2f7
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 19:07:23.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laBcxIQyHtuWNXZktAK++zBLl3VtgkWfV1CV8Mk3EfkHrp31YpUPp50RMYgzZvSZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB777854

> A PF0 DSM can be removed while a sibling function still has a vdevice.
> The context pins both the pci dev, but those references do not keep the
> PF0 DOE mailbox alive. Ignoring -EBUSY from link disconnect lets PCI
> continue to pci_doe_destroy(), leaving the vdevice with a stale mailbox
> pointer.

Everytime PCI SIG puts something on PF0 that effects the entire MFD I
think it is a mistake. This time is not an exception...

> 
> This follows the VFIO PCI removal model: vfio_unregister_group_dev()
> prevents new userspace opens and waits for existing users to release the
> device before teardown proceeds. Likewise, DSM removal rejects new
> contexts and waits for existing vdevice contexts to drain before
> destroying the DOE mailbox.

I probably wouldn't focus on the vdevice so much here, it is really
any user of the tsm framework in the kernel.

> Mark the DSM as removing so no new contexts or subfunctions can attach.
> Wait for the last context to be released before disconnecting the link,
> 
> VFIO PCI also uses an eventfd to notify userspace that the device should
> be released. This patch does not add an equivalent notification for
> vdevice contexts; DSM removal waits for userspace to release them. Such
> a notification can be added later if required.

I ran out of time to read this closely, but the explanation make sense

Fix the sashiko things and lets see a v8 after the merge window opens
and the first patches are picked up..

-- 
Jason
