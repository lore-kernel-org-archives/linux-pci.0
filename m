Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794370828;
	b=zts+uRfuYe14TGNTrLdhhhiUqXSBkqin+wSaNzejtysDeu5030SAU2h90n/9sPgJ9OfS
	 U0TFhs6qbofbLozXXUswfrbOh3a6nOBzJ1V+1jBuRjSjDv6OpZ+/fiWfk+c/V9MirFaEL
	 On7zRk0MNjyLtP8oktvA6Dse4Jo6KtKqCfY969PCdOOJgZg6tXfWbkY33lqz1iZoxpSNk
	 /j/IKEHiLA87ezkcxdWym/3HyJsmnk6rBVqZ0wq4g7/i4BnfjEtucovGgXlOoobEFrY9u
	 jZUBG6Lbc8UAIR7FQ7vF10c9RMh95rLStkJgw1lnmv941/YjPLk93BWVdd3yFtAflBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370828;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QV+aCD/LHC0BGrpk9paZXaXAzPXOXz02MEElQI8GOl8=;
	b=Ys7q2ZIpdH5k2mbWmlgSblhVqw7F6yzwjCKolvBZMGxH4UexogWH4FvOoeu0TOTEGSLq
	 HUP5sp7jgKZF0H1h03ePwqCJLJ0B/tG1KuzXmyG/xvmusq3ZZ5ElVAxbtuYaKd2GQlqd5
	 WAbPBU1Z69vvm4ECan9B26uD+MTz7mcfCOQNcwpgiFu+xWxPqvWthq0ZMEF5JNyxEXMg2
	 maeOn7FEWPYXhMfpdseSV95WeLAXCcn+ZbFuPSsBVYPPULA43ZURwOczszuftgbbS3ViD
	 +ZSjOPcLzxGz+skeW6YfLkl4uTzna1Kg0w/eIwvUrOd9uQV+5M9MzYz47tTVy1slyDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="cv4/MArh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.2
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC5606A338;
	Wed, 11 Nov 2026 04:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CEC5606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cv4/MArh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSFCpegRxDSWBLxqRs3smwgLGCujU0m3n2/WdtE2ZTZ+915j2KlpS2yvGkCT5uru+/CMcP55VdtyEvTPgue8pkdCp6RwNYoWlLdDz70lKzcZ65S5x8nykefraRf4E8c3nGHVe3hAr9MGf0qVFoCIp8vP95InQA2rIOOSp5b5p9WhJLMPy3lJ7KDp9CvIUojiX61zsnu3d+hzv2yIq1YYVp/ycPDdEKTPOrqcXk/4cdYiryDw4dsi0z1qd9NBEFh0uCOVQF5FNtbuQ0baNx0KVJV/UZGWSF7u2EFH23ffo/EKcfjGPk6gaU9bm4lrs7Ni+DDo0J4Qy7jxFKKHRT7tEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QV+aCD/LHC0BGrpk9paZXaXAzPXOXz02MEElQI8GOl8=;
 b=fyPMJubMWIClCEVNSfYNS41mensskVD193F6JP2ycR6MrpykL4MyCAqMq7Yb/g+z1pRAI18HI0f2fGfpQwe8mOytt6wRUNzM320o8oEr1tzAIPcFgu8CSKv6TvOgkcfg++jqr7OmdoONz5BNZq2oeyhtWqscedEjqbCgDw1VeK/xIlWaZT+TPl8x3fe/Q+9tI7CdMgta/N3/u1Isa37lDPuR+4N90//yGWzO1YlIo6aFE/VIru8colXaTXpy8bVZJdj/tfpimg7nZWxcx0XlTczpydomqZMUdRY4ttEBHDvZCvaDfkuduSacbShvFeXCF2ripWaZzUB4zT4nTsaAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QV+aCD/LHC0BGrpk9paZXaXAzPXOXz02MEElQI8GOl8=;
 b=cv4/MArhqfm94nnuiJtHvosUrxnaphO9aZHADpEroeojnC1No0v8Alh4HB72uutJQIpfw6WcgDdiND00OSmXvwlRscgvmWHF6qBKt78gaHXLMOz4nzMLmkoqq2KuPMQ7r9aJK9Xpq/Yx3qf1bvALjRGVftPMx87mSeQb9X1QUYH401z75v4fyhIPb1VZhUwd7r/WwzMVpRh1wiUrOKVmSjme44KaNjym4DpDLlX/s6KwUl+JVP6ENYpDjqAAbi0OcBCNoi0lyd/1nzYZWdIazXjzS7TAUJVhQUS3owBBFcCgFh8bHkeyvxAYfv4Qp3O9rLbdfnhjiruw7M9IblMGtg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.8; Wed, 11 Nov 2026 04:20:22 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 04:20:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 13:20:19 +0900
Message-Id: <DMS3DAERLCR2.3RDSDAQXQYSQC@nvidia.com>
Cc: "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "LKML"
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] gpu: nova-core: factor out and expose
 Falcon::is_processor_suspended()
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261110033655.148487-1-jhubbard@nvidia.com>
 <20261110033655.148487-3-jhubbard@nvidia.com>
In-Reply-To: <20261110033655.148487-3-jhubbard@nvidia.com>
X-ClientProxiedBy: TY4P301CA0049.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 358f9ec4-c6d5-4e3a-1f6d-08df3fab1a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|1800799024|366016|6133799003|10067099003|3023799007|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rRj3Av3o/GfujWCrJVS14x7bu7lmeFS/92fNEBfWVp37vXbK8ZIM+QRlKr+o0eFy9At6yEUDn5urMXBaGq0s1m5XH2+4GAedvzRKP/Rez2GSBbDFPTFkempY9VT8tu98yWQe3HD0VMF8H9iW9iE61Y6iKYKnpTLjyTOczjzT3Yjlru/owxZ84oLj9545LZflzuDXwtTKkLKZkfeXyWJ/T2ecKmyD7YO6It8VqSmg4XIQitCksJ+8Mjz5zlLZc+KSYWKYmJfDYzoJxN2IxR7T7itNsYHaehdlB3qYZdLoKCuyo3HD6offqWqYF/wtNAl+0liytHsgO5spQ1+nvRwMa5gaj75E0bm4HpDdwJL0Gf313t8+1WgGs5JAms5rWJC6W7dWcDf002wBHoIwXvFEyqC91wLhGCCvtGcIQeqNxKlriue9Ich/k1fquro3J3QLbBQR9T5YTMT2elya0xSEspLMoeVBL844Abt8Kz8VFobnj14feMaB817e0vnvptW2tPA+7pzmspepN/FEFdiMMxEuHfgAAl+Ln4zdSUfGOtZv7dQD2ycDWoBqrz2RiOX13KDgJqIx3VlF5QkhbCKSXdIi7FqXsaYb7jlCx6I0I6FOH5PQPt2KyBXOZAWtMf2R8SjY7x9/LTzWtz/etV5TuDDjsi4/EncZMnfQnCMyOSE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVU2Y3ppY3QzK2VSTy9QbDMwdllVdC9tT1ZaM3ArVm02YldWeXZUcGorNGtQ?=
 =?utf-8?B?cmMybkVkK2UrRldOSTR6bTBnS05iOFRlZnBDQ0EzeFFBcWY1eG9nSkNsNFZX?=
 =?utf-8?B?bkJVVldpb3dSVzNRK3pvbnd4SitGczJFRUZQMVFNY3J4R1JVdlI2a2pnaUJn?=
 =?utf-8?B?NldmRE16M1BYdWczVGZ6T2RGVlJ5bTIxZVJUd1p3Vk52N0pPQWVGN1BnbytV?=
 =?utf-8?B?cjNJZUs2VkdOM0FobTk1Mk1qaGJ5MXQ0cEVkdWRGK1I2SUl0QmlBUW9kQVhP?=
 =?utf-8?B?NWp1QVVlODN4OGdxMU1EcjhoVjhzOCtuQWJzRDkrRHRGcTFNeFRLSVNxcjNa?=
 =?utf-8?B?S3U0R2d2dzFFV2NnblJaK29kOEJLcEY1QkdHTE5SUkhiUDFVNlY0eklsZjVC?=
 =?utf-8?B?b2IvWmx5dTlRU2VnWldKK3pOVjIwZ01RK0RQb2lRU0gyMGEvcW9pRVJ5NjVZ?=
 =?utf-8?B?S0Vxd05raUtrTk55YlRjd1cycmh1cVlNcVZRKyt2TGZvNXV0cGlUVUVROGZQ?=
 =?utf-8?B?QlFKYVU5MXhRUm5GdXhLQVNoWFNWK0MzWnZZTktlSjNwcHY4OWpBR2toSmVH?=
 =?utf-8?B?MWRnd01WUEdXWFRrb0JOQThuam5Ic1NGOVp5djBGN0hYOUNGWFFjYjkzekhQ?=
 =?utf-8?B?MG4wRkhEeVU0RWszU0hXWVBvajRDYy90VXViUHI4TkZqTjk0cS9hTnBRUld0?=
 =?utf-8?B?VzRZczZhMURMQlFsUVhWTUhRaERBS3Q4VXcwemNObzhBTmJtTkgwRTdwdXZa?=
 =?utf-8?B?VUl3VDVSMlZGMDlMdmtIWUFCMjlhSitJWjNxd2VIdzArVXo0ZlZ5M2tZcXNn?=
 =?utf-8?B?WmN6RkhqaXIvK0J4Z25nSFNMbnE1UlV0a2VZSU1KR0FIbzhzL0FVVWVBY3ds?=
 =?utf-8?B?L3UxZXJyMWRwcmpwcW9QVm5jQUp2VTFubk9CQ1ZtbE5QeGFwTlZLSS8yanVr?=
 =?utf-8?B?WG4zZnltS09jaFZXcmFpcnNna3V5b0tjOUhYTCtPSmVLOVBTU1RUVUdhMlA2?=
 =?utf-8?B?L1diMDdhYnR1aXJIdnRBT1JTSWYxeFYyT0JWYUwwci8vUHhoMWxHUnRZRXor?=
 =?utf-8?B?KzhqNzdqNDZtdVpHTTU1WmhnUlpIbHZNaEppdnI5azAzaFFNMEIyUnh6YWRi?=
 =?utf-8?B?WjI4aFRObUVaZEk0MTliV1pFZHpWN3hUdWhqSTBJRE5IckNBTkZOb09FNmsw?=
 =?utf-8?B?UGVUS1FwVzRCVVdyUk1kbjhXQ0hiT0lXSnlYbXI0MnVSWE9RM2pPYWtFWFk5?=
 =?utf-8?B?OVdRdThSdlZFNE8rWjVmQ1crbThqN0VrMUdzc3htT1NCRUdtVnF0RThZbi9C?=
 =?utf-8?B?aWFkMzlMRXNCWDQyT0xuakdhZHZGd3dqTzJzTldwV1psQ1FFWVBZditWcmJJ?=
 =?utf-8?B?cm9JWVAwVTRYcUI3NmZsMnpOc21QeWs5SjFjWHBySEpaSisyYzJnN2FkS3pt?=
 =?utf-8?B?akxMRW5JU3JiNDBPYUhPS2ptWFJpQ2E5Q1lQNVQrWkhIR25weGRrbXdRTUpm?=
 =?utf-8?B?RWs2UHJneXRsSnR0YWk2QVdKWTVLb0tkeXFhN21abXExeENlcy8wNzNMTFB0?=
 =?utf-8?B?NjhCbmQrUk03VHpOMUFlNWFZb25hYmZ1TGhoRzduUG5tYjNQM0ZjcHFOcm5Q?=
 =?utf-8?B?c3Z6VWVXTmF2ZjhTRW5hbDBwWUtBTnBYelB0dVV0d3A5c21jVHdIaFZNN3pn?=
 =?utf-8?B?OWJ4ZzhpZG5pZ1RxUUNpaTA5WWhVRGRpTjRMcXY2b1RLeDlrd243NEpOT2Fn?=
 =?utf-8?B?V1daR0ZDSEU5bmFqa21FTldEd2VPYWtCS0d4ZmhhVmdMN3VuaWxQcmFYaHVo?=
 =?utf-8?B?MllySkFUMDFxQi92d3psaGdsZk5KK0U0M3pMOWQ0Z2xHRGxtdlRHeWluZjQ2?=
 =?utf-8?B?MzZhby9qdnpJMVVzU0p6bWxBVDI3RHdtRW14YnUwd1RvTkhraGxGOTNNdVE2?=
 =?utf-8?B?UmEyeG9ndzhDczVjNVlRcFNSSitiSXlMd2c5cjFaM2E5azczMVhZOVI4bG1M?=
 =?utf-8?B?aXd0TldwLzdoa0l4SFFpQTh3T3ZOMmllNUQxdXU2V210clFBWG5UTWQzVWVn?=
 =?utf-8?B?eG84V2JRQUM1bVRhT3I2bG5BUGNnckFPRWFEcFJEMEpWSVBsY1J5c05UanBP?=
 =?utf-8?B?V2NldzRCNnZ1Qzk2R2ZwT1F4cFZnMCs2VGo0M1VsWEpWYkp1YStSL0xST0Rx?=
 =?utf-8?B?dEltRUZzWnJDUzc2K2pucW1zTzhFRU82YWloMVNKL05kN3FPUEZGaS9MVi9L?=
 =?utf-8?B?RVJZKzVlb0E0M0k2WVBlQmNjV3RWZUoyWnJ0ZERUSGgzS2NsclBOdXVjUzh0?=
 =?utf-8?B?VmQzWEZvL3V1SHRzZzB4TzczcjhlaFEwZE1HYjlVdUxTaHVMVUZianM2Vngr?=
 =?utf-8?Q?IHCCy/SwZmO1ViFWAjT4he2sg9jZBjMzt4e2R/fGAAkxj?=
X-MS-Exchange-AntiSpam-MessageData-1: RQgbTqn5mMfHXg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358f9ec4-c6d5-4e3a-1f6d-08df3fab1a61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 04:20:22.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DN8UHhw4ZxskpyW9DpkSFQKJYQqrzKrJzayV+ADriQgLiDeTvV+dirSLv6m1F+1ADnZl16+pElSJvz2MnZkcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455

On Tue Nov 10, 2026 at 12:36 PM JST, John Hubbard wrote:
> The r000 boot protocol requires the driver to wait for the GSP suspend
> bit after each load-and-execute event. The shutdown path already does
> this.
>
> The boot sequence will soon need this same functionality, so factor it
> out into a method, and put it in it's logical location as well, as a new
> method of Falcon<Gsp>.
>
> Also, use register!() for this, instead of manually masking off bit 31.
> As usual, that results in much more readable code.
>
> No functional changes.
>
> Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
