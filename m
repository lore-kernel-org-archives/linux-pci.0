Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793214470;
	b=cMKgdmLAsy3Vbpd9Z7eVQjidyYJwHb/K6sakdFli5A549JzG8VcAMRxIeGTIimKZ19rj
	 MF+a3cCs1AeSaMKPdknIeS7MH3NGF/PBSLvBij45DTiByCvE7rgl8AbW5qsd4w1WfTG+Q
	 m4RZ4vkLXtKS0JrNB6Hnav1xGvD8vrcnjQkUWGZFRuoTF8188XCdZAj6P8D8iZ/ZFLJnF
	 sAU1ZjB95no9RPmBhB+WKn90pGZ2PDoPbzVID0aWgTT5IpdxcQ0TGKF9ENaBPed8U8fP8
	 00ZMYf05vW94CQD7qAJOlBogOMJXiiZZbDcd2jlD5J0ko4bkxuY6tW+uiJ3kdbfbtag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214470;
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
	bh=BbsuULhLgLNDs6wVHHbOCiNvNdYG1N5sUZ4Bj6umS3k=;
	b=20dTbCWXdxamaGpHZvwdoJp6wS96UPLiacWnahppUQuH47Ba/cogsPUicItIaAglRx9a
	 UO9BioJ0GwF00UjDQf5oOgCaMKiJMh649eyGh248ROwTB+bdykAyNzb96spGEE6HaxEy+
	 BHjMB1qI5x4YZeI6Xg1h2rzFXHa9Qt5WJaA4jpxl6OrU/2ytCc91CDCdzmLqW8eH3GGMy
	 yGCpjR486KXBg6f0tE+7rjy0zcC5Xoty1p+NUUNBpqN+QXK3egSuNsYVGFWr4nOw7sOdb
	 LVjhYIoMqg1AuG5X55QTOl7R8c2OMx/yNCN9/rRWUtl9zzgncL6FTDS+yqeTYyCveYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=alurMyl8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.3
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71228606AB18;
	Wed, 28 Oct 2026 19:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71228606AB18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=alurMyl8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sL5j4AnnOvokDV20XoW6DEWIIn+bXlyw/sC8zt6lO8FmlaRTWOZaC7EQsbS5mVOTs/iT39dyp6Paolix7EFfRfBLNWQyWTRuB+l2779GiQwSQN6ZonIgi6bidlBg5G5Tz7MfWIQ0mls7VmI68CCbWiV79t5XcLTw5UwV2bc6rkRA/53qsA7g0gwgiZEfVkXXvySYINYUYnVe6miY29Tnt1qr9v5bde7OdVIErMKbMQPl9FauhbabrE+wqw6rjlBlUq7CumFOTMNvB3nmuIoCm4NfQl6c4SH9QmMMTLBPerOyQ2NX9RpcdHoG4npqlw8ka4kgQa/Rd6JpWNjzy+hVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbsuULhLgLNDs6wVHHbOCiNvNdYG1N5sUZ4Bj6umS3k=;
 b=VArFZXpdTE0y7roFxcb1wNjLV38bY/y0LM7/A5f+ey20covJj6xRNbjaYbWjIYdENEgv9e8YKj+aDh2bdqH1YZbw0SecoNlN7lVSKE8RBpkK5aOB+uaQFR2dYaf/cnQoFL/wpwP0Yjfwjbz9HAAH/GgXSQGCq2KH7qRcZMoBsavGtdORRCM4ps2mR9DX10BIxmf2ffBfc9lVaT/tRHqCx5lR7Zva8wz8RJyb6SnLJa7Psc4lJOS3uddZAuYlC/LVuZ4uRg0w6ipk0ZwXF/EgjQ/mcfkQqyiYiEmq0TNFW3IImkGCE6xfwIcszExWFO53OdOeRGfgz+3bXrJ6hD1q/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbsuULhLgLNDs6wVHHbOCiNvNdYG1N5sUZ4Bj6umS3k=;
 b=alurMyl8OPIOtEYRZUr0LZI8Ayoc+4wJuZ5IGEv1VzDqDhDhQ566UgdtZa6pxpCxhezyd8gRw7f50C3x+rfo7mQc4QD2IrV5MBbve73RZPOcIFirZ1o4JdudKicgOSBqG65d5ufgJMCcIJM9tIMC1TTmKJeD5UMxeii4TQK84A4FQx9wmty9H1vRUYLMLjEok5MR4IfL/scjgD6PICmYVljOe7nRxy6mdFPa1bwDVdU0+B6SOLmFsafUicmJryw3mNVw/LpeyKat8rNGNLCLkXttYhizLgtMfzM1hnVCctFgUBVncDj35EkfdRgYsRFM0I7KMFmR+dB6bVwLSKuv6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS7PR12MB8203.namprd12.prod.outlook.com
 (2603:10b6:8:e1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 19:07:31 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 19:07:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 10/16] iommufd: Add the vdevice TSM request ioctl
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
In-Reply-To: <20261008055955.4014342-11-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-11-aneesh.kumar@kernel.org>
Date: Wed, 28 Oct 2026 16:07:21 -0300
Message-Id: <179321444123.2412245.6955528563980811144.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::19) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 86bbe26a-fbd9-4341-ce4f-08df3526b35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|261026140227099003|261026130827099003|11063799006|261028144727099003|4143699003|56012099006|261026121527099003|261022113327099003|261021123027099003|261021135927099003|261021121427099003|261009221227099003|261022105027099003|261022115727099003|261009223027099003|10067099003|261022075727099003|261021130227099003|22082099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	72UTa8SEA9ie2upA0SRFExIUMV7CuFnkCesX9HoqRuAkmhXeODuG129M9nC6KUVQoK6jbGcAwl453qv3TDeodzkygTpkOZpy3GtmyAh4z8d2MbmLPE61duPog3dDp630m72fx4LNu+sRVJNNXSytCpoFXyCm/37wvtF3PVcyqRjcwXxC6zwRow8dj/SGLy8UGzIv4tAfpYgdbvRDa1wOtn80q5Ka0o6in5r7CHTNipFUfFq99ldIrW8ooWgU+zJrS8ukcTqpR0oRfBs1bImheWTnHhYli7QSv3yQAEGwJ0r6m+Nk+EuGC43Sjm85/DQ2/1bsvgqdJkRoj9BQxKIanhjkMe+HX/w2BEZ9phSJcoAyZu5vpd6csAvBCby3HLNPumOg9lr9nd5vvDVB+fawHDL/fZQ1qIU3kRy0REG3mQerajH+0uEqQjOcSa+IORO75Q25UUOgb72eUynk0acj5n0kNRsMv08tPdEg8oljwqH7IFfd1mjsunXEdKHIarVN3NS+Nqscs5tuBgiKYq9ZGHw1lHDRGEHkjzDCPkHNHdhIGPWGcOk0z1sInIFpHWo9v/3HU8aE9YKzSJYx79vNxWnc/A1NmIFZ13ZuL8QYhR9+QITtAyAvNlpKADXUda43ozTnOjiXGA8SMThaEpOyLYJIlYOUw9KcYJ2tW4IxozU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(261026140227099003)(261026130827099003)(11063799006)(261028144727099003)(4143699003)(56012099006)(261026121527099003)(261022113327099003)(261021123027099003)(261021135927099003)(261021121427099003)(261009221227099003)(261022105027099003)(261022115727099003)(261009223027099003)(10067099003)(261022075727099003)(261021130227099003)(22082099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnJ3YnltbC91bDdreFpHU01sR3FoL1FDUkZpeG9DdmR5eTVhUHc4WXh1Q283?=
 =?utf-8?B?N0kzYlhQYVBMWVZiOE96cHl2LytaTnczZHl6NDI4ZUQ0NkVWVmFxV0JCMGVJ?=
 =?utf-8?B?ZEE5eC9saDloaEVRa21VK0c2Yy85RWxjMDVzZkRlTW5jMnpJVzRuT3NiQVQr?=
 =?utf-8?B?dkYveWZrL1RodHJjdXYvM3BObDJYeTdIZTlKODB5UFkwbzg4U3MrbUdRL1Zl?=
 =?utf-8?B?L3VRUEtLYmhLRXlBaHhIc2QvNjNCam9SVTd5MlR4UVRBY0VyQk4vSFpXYkpy?=
 =?utf-8?B?RWJ0bGJWb3ZxWks0eG9Lcjh1a2ZGdVFqZTNJdWgxUlNMR05hK29GbG9wSmcy?=
 =?utf-8?B?bGxhNHNxVHlRVTZaTGk5NUR0bWtoQ3ZFVlNDRjlFd0VHY0VQWjlKVzdVR3FZ?=
 =?utf-8?B?TUp5M0FKMVBScHBMUWdQYnBnNHZFRUZSR3dXaFpobTVtTXUrc0tJUFB4eUJ1?=
 =?utf-8?B?LzBINThTK2hUOFQvMUNnZDUyZmQ1ZEZsOGpxcHIvWHl1VHhRcUZFdmtmNmhw?=
 =?utf-8?B?RUhuM3ljeWFvNU14WFhLOWR5d0E2ZFJYQVNtRjcxbks4RnZJNnp6NDlQQnNY?=
 =?utf-8?B?RXJicmpKL3NxeHVwdzVGcjRSTU1yT1NQV0NHSzQyVldwcFNqSi91L2ZiSUxR?=
 =?utf-8?B?WG0wRk41ZVBPTGtndGJSZFE3Y000ZWs0Y3JVS3FVVzR4M3g4dUJzY3doN1lr?=
 =?utf-8?B?MlNNUTdCclcwelNZVktkdlBKN21oNlFFeFV6ZkVHZFF5c3ZYM0tmbHpRdUVV?=
 =?utf-8?B?bmlCYm4rMzB5Y2VtLzVmemVJUkRVZlkxZjBlUHlWbWY3YXIxWGxQUCtBVFdY?=
 =?utf-8?B?bmhwSEdmRmVWSjNmTCtVZk5jenZWQW9YZng5S2xsRWpNUzVtZlJuYnVLMlRw?=
 =?utf-8?B?bkxTRDFBbHNGK0hreDBUekcyaU4xZnlaZWp4U0czaEJ3MlE0ZHNSTk14RFVJ?=
 =?utf-8?B?cHBmWDRjOC84Rmt3MDFNM2d6azdBUzg4VDdCNVY3T0FlTWhKWHlhbys3Mm45?=
 =?utf-8?B?bCtTM1FtdEVmS2RtVHpRSUg0RWZvaDhZTVlkNEViTWJZYjJGLzdObFVyOVUy?=
 =?utf-8?B?cWxWOWYySDNaMGFObnBXRTAybXhSa1pNaUpWc1VrUTJnTkZNSTlxSFlVS1FO?=
 =?utf-8?B?Znd0NGg2SjBmeHl2dmhUbVo0Wjg5WE1IRjdoM3prNDF6cW5sZkxJMHdJcVRl?=
 =?utf-8?B?SEJZaklWYnB5V1A5QWhzVzdublBGT1dHZENZcHRLbjlNT2RiOHA2anBUdm9u?=
 =?utf-8?B?azh5SE9NOU4rUmx2ZGhCWHhXL0R1UjhDN2I0cjkyOVJ6TVdQSUxrUXlzTGsy?=
 =?utf-8?B?NDdYNnozSUpZdGhWZXk3VlVvSUk4RGVtTjBTMjRmYkQrNEZ4NDRLNTYrSExH?=
 =?utf-8?B?aW5Ib0tmcTRHZGJ0bUZWZWlPYi8vNGtyVDFsNFhRckhpb0VGdmFsRGx0dDZQ?=
 =?utf-8?B?d3FzYnZmRSt1NndUcU0vWWFNMXBsMERwNkNHL2F5U0wzUDJuUmY1bEVGZDlJ?=
 =?utf-8?B?ak92N1ZYMmtyb1dqQU5jdkI1ak9TcjcwOTRjQjJ0a3B0Z2krMmVZYlFLQjcx?=
 =?utf-8?B?c3Q5ZUFQdmVvRldrNDdkcW5sU0tQZEFJUEhnSEdNUHZ6dzhLSlFma2xxSG5x?=
 =?utf-8?B?Sm14SlRZemR4WXBSeW03SUdSaWFEaHlQZFhVYXU5Tjk1WkJXcVlkOVNVUTdM?=
 =?utf-8?B?b0RJK2x3bEovN2xTeGFZZElhdDlCMXY4bWpFTmZOWi9ueEY0bUZkVm9GMGZS?=
 =?utf-8?B?elcrWXI3VnFpZW1YNk4rdVlrVjdjdmRieG1nMGQySmY2Q2hSSnF3TnJiWjJW?=
 =?utf-8?B?UGx5QnkvdWV5MlVyQnV6MzZaWGJYZGhXaVlvYitYL0pNTjRuaHgrWktUNkxn?=
 =?utf-8?B?MWRucWdCMVpDdmFqcS9oaDlWT2w0cFN4L0V4QmFiaXpuNHh1Zlo5M1lYaVpC?=
 =?utf-8?B?ZDVEa1llVS9pbEE1OE9JUEhEZERTNUZSS2RGblVTNXgyaUx0SWwzSGpPUUpy?=
 =?utf-8?B?VFZyRUNLWDlrRDFsRG1tbzVtS0pBZm5wS3ZETHBMT0xMSXhSTjVFMkRvVHFD?=
 =?utf-8?B?bm5xc2JMb3QvL1VMSmlFTlRoNHdXWnVBVjhZTndjR1JjZHFxdjBUODhnanhB?=
 =?utf-8?B?SkI3R212SjkvUGF0YS9KNWdxbGYxa01GaVdWM29DVUpJRVcxYWVRNmNrTHVs?=
 =?utf-8?B?UkMxc3hnSVFCUlhEbXp5OHhjZW9lRGU4c1Iva0NSUllzTERJN2NGeE5NZ3B5?=
 =?utf-8?B?ODZPYmhLRTN1QVRnZXRpVmpyVFp2K1NRVCsvRDVoYVBzRDg5OEUzUnUvSkJN?=
 =?utf-8?Q?BqOnVWSytJ9EPImw7a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bbe26a-fbd9-4341-ce4f-08df3526b35f
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 19:07:24.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th3263+OrHEYG0HvX/0ODp+ItNeaFKVjpqNLxe+dnPcCl5Bk0n+rZEsRDpr5IXwq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203

> [ ... 300 lines skipped ... ]
> +/**
> + * enum iommu_vdevice_tsm_guest_req_op - Guest TSM request operations
> + * @TSM_REQ_VALIDATE_MMIO: Validate and map a guest MMIO range for the trusted
> + *                         device.
> + * @TSM_REQ_SET_TDI_STATE: Transition the trusted device to the unlocked,
> + *                         locked, or running state.
> + * @TSM_REQ_SEV_ENABLE_DMA: Enable DMA for an SEV device.
> + * @TSM_REQ_SEV_DISABLE_DMA: Disable DMA for an SEV device.
> + * @TSM_REQ_READ_OBJECT: Read bytes from a device object, such as a certificate,
> + *                       measurement, or interface report.
> + * @TSM_REQ_REGEN_OBJECT: Regenerate a device object, such as a measurement or
> + *                        interface report.
> + * @TSM_REQ_OBJECT_INFO: Query the size of a device object.
> + * @TSM_REQ_MAX: One past the last request operation; not a command.
> + *
> + * The request payload and response format depend on the TVM architecture.
> + */
> +enum iommu_vdevice_tsm_guest_req_op {
> +	TSM_REQ_VALIDATE_MMIO = 1,
> +	TSM_REQ_SET_TDI_STATE,
> +	TSM_REQ_SEV_ENABLE_DMA,
> +	TSM_REQ_SEV_DISABLE_DMA,
> +	TSM_REQ_READ_OBJECT,
> +	TSM_REQ_REGEN_OBJECT,
> +	TSM_REQ_OBJECT_INFO,
> +	TSM_REQ_MAX,
> +};

This is still no where close to being well defined enough.

Everything here must tie back to defined spec references, listed in
the comments.

I cannot guess what data is passed over any of these APIs, how things
like "REGEN_OBJECT" select which object to regen, or what the format
of those objects even is. The formats of req/resp are never specified.

The comment for this should probably be *enormous*. Every arch should
explain what they do on every one of these ops, and it should be
identical if it is structured like this.

I have a strong guess almost none of this is actually general, but
lets find out.

You can also put enum kdocs directly before each enum which helps alot
when they get as big as this stuff has to get.

My guesses with no information
1) VALIDATE_MMIO why would the hypervisor ever need this? Guest
   validates MMIO through secure communication to the secure world.
2) TDI_STATE I thought at least RMM did this with an RSI?
3) ENABLE/DISABLE DMA, see #1, must not be done by hypervisor
   See my reply to Alexey:
   https://lore.kernel.org/linux-iommu/20261022123058.GC3008132@nvidia.com/
4) READ/REGEN/INFO, what are the objects? What format are they in? How
   do you select them?
   Does this overlap with attestation subsystem? Should attestation
   subsystem be used to access the SPDM related data?

Update the comment to explain all this, don't need to answer here.

We really need to do these defines along with implementations, that
probably will settle alot of the questions above.

> +
> +/**
> + * struct iommu_vdevice_tsm_req - ioctl(IOMMU_VDEVICE_TSM_REQ)
> + * @size: sizeof(struct iommu_vdevice_tsm_req)
> + * @vdevice_id: vDevice ID the guest request is for
> + * @op: One of enum iommu_vdevice_tsm_guest_req_op, excluding TSM_REQ_MAX
> + * @tvm_arch: One of enum iommu_vdevice_tsm_guest_tvm_arch
> + * @req_len: Size in bytes of the input payload at @req_uptr, at most INT_MAX
> + * @resp_len: Size in bytes of the output buffer at @resp_uptr, at most INT_MAX
> + * @req_uptr: Userspace pointer to the guest-provided request payload
> + * @resp_uptr: Userspace pointer to the guest response buffer
> + * @out_tsm_code: TSM-specific result code returned by the TSM implementation
> + *
> + * Forward a TSM request to the TSM bound vDevice. This is intended for
> + * guest TSM/TDISP message transport where the host kernel only marshals
> + * bytes between userspace and the TSM implementation.
> + *
> + * The request operation is guest initiated. The vDEVICE implementation
> + * declares the TVM architecture and operations it accepts; iommufd checks
> + * both before forwarding the request.
> + *
> + * The request payload is read from @req_uptr/@req_len. If a response is
> + * expected, userspace provides @resp_uptr/@resp_len as writable storage for
> + * response bytes returned by the TSM path.
> + *
> + * The ioctl is only suitable for commands and results that the host kernel
> + * has no use, the host is only facilitating guest to TSM communication.
> + */
> +struct iommu_vdevice_tsm_req {
> +	__u32 size;
> +	__u32 vdevice_id;
> +	__u32 op;
> +	__u32 tvm_arch;
> +	__u32 req_len;
> +	__u32 resp_len;
> +	__aligned_u64 req_uptr;
> +	__aligned_u64 resp_uptr;
> +	__aligned_u64 out_tsm_code;
> +};

Should the viommu_id be passed in as well, or we know it implicitly
from the vdevice_id?

I think this is probably a fine generic API, it should probably not be
"TSM request" so that the other viommu people can reuse the transport.

I would probably try to stick to exactly like the other APIs do with a
single enum. Two enums for op/arch is saying already that the ops are
not well defined.

So maybe strip this patch out to have no tsm stuff, define no ops and
just give a command transport into the viommu driver?

-- 
Jason
