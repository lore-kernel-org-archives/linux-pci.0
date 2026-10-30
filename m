Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793321169;
	b=BtqTDfhwioh3znJZhc9yj8Mh6DbdugeuZbyTLz64hW8AzCb6XS8LdDjnEsEIu02syk33
	 GoM2Z+1egd8sfo+rrMb3I4+NywRUxjK4VHPPCu53uQJ14Lk1H7Jc6dXgdRWSg7roe2WVy
	 KP1GEeAG3hSSA95hydnX6PHI9XHCxD3MWLhQpzIu2B2NxEj2Cn56/uMf/KgFT/fGDilC4
	 dnnbq7snL/19bYhgLJiguyZGfbWxblHU6XxDvlBYq2hyBZBF2dP5RTZU9UJpE3MJ97l9z
	 EjD0gsiB0oeGqcN3u5ZC80qACMugmYeD+2aPODXrIoBoKqsb9uCvLkMEX7VOMT+YZzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793321169;
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
	bh=Y8Dhp1jsDItJ264jXci9htLcKRhrHGktT31ioNc2l+Q=;
	b=GSxycWaKE5rBahYNuXxcTd418M9VoEvEfa7wp16gGIYgEXxoZFr6CW6VZmsQkZihs7Qx
	 DBmlShLT/OYcRhf8WTBEiys3as8Pem2LKne85IqRKp621mL0UeoaEE7erKps5o4+rMFcr
	 Htse1ADD32BvCD9mqKpuHwVI32oclFw5hulvdjkwNErFQlwoKNU994myewYsJ/MaMyJ8J
	 11k12RpcW+9HanWnS0V7W+FTjL3mKI0IkCwZeNj928QCYu42H4dxe1seh8wGy2u0GRaVz
	 T2nOkDcTbuPbPgxK3StXIpMayAjGPmaDnsQ2TVec2R+KTf6jw4OGwRcw9FEMGPnryZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=e1dKAT6D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.58
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5154606A31A;
	Fri, 30 Oct 2026 00:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5154606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=e1dKAT6D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJ/RowesHaXpS6nlVwinMqQ/ha06aoqPOfR6mUTC4s1bIV/0wtQJhsbv2yLo2miCPwHTdiIPesJvfCR1AGmDQ9Q69dKn6Vr6Uu+gRmB9YboqwSq59pFJz+U3MgfEx8YYInNDVigBvHizSkkwbUsl5o9Ov8or/wiHbZYvyDxlECYbIjzPtEBPJig7Wmfsx8RP06YIQhniDuKWj1dt265RXvQUb3vNDKPHJy4RiYlc833WyK/v/Ij9kL1F4pN5XWf7easgHoRKzlltoUzTYPJ3W0EvHAb1vKwwZ2uPHbc7CrVJKJcjNDwIDoTyCL+ZdMC1i3k5+rUrnyYeRKZVzGSlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8Dhp1jsDItJ264jXci9htLcKRhrHGktT31ioNc2l+Q=;
 b=JTiTkUVENdLRG3O0nPXGuRWSTGMXQZtv3Ebuz8TyIxBmFiMp1F0B8mm2YIKfRz2t1QiuXz+qniFjGf363PTkqTeRfxc1WSZZZzgGbH5NFcEP2oSHcKD46CWy3IhrnD5Z7Zf4ZsVLrO3p/gAbbYhpfdW2eRQ3QC09uDIYNdY7H+SK5XUvnkApfOvsuX7zcKBQ68ZUvQ0IrIAmy6NFN1N5eBAG1JI2Adh3Jvj4yZoV9/O52yKfL9jFGr5WwPC+XOXbDemJlniubvifFq6A7BOwTVujNplHKxkwuiIruTAmkE5594qpTLJOyE/YPlg9eRE+4KTP8rtoxCKQujBA7qNOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8Dhp1jsDItJ264jXci9htLcKRhrHGktT31ioNc2l+Q=;
 b=e1dKAT6D2vB9fLKOOZ0dqlRdUWOI1QdxyAL6UPLd/X5ce1BpBeS1QbkLcDDL3JqBKhMBf1YCyBdD2rfteqdxEV6eTl+N9SlotsI++ZTsPwNUvG6XYSDxoto5wz1A8oajxvDJv5nKcEIvdOJYi1iqRHQ4yABPqnKD7cn4K2XDjrKznX29tZHtljy6MRCh9qJT8YeS5D74H10MN3sXJ470HFP2f2XCaz/b9XDH/xmm6mU8xMM7VybeW/MVrHMnnf56+mPiag+GZuHVPmF61IKhsm8uLxLauzfO/WMdS5zDmUtiFobJOanWCjTUjy8IFSk204J+lwBDKVudmQaO/cIugw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 00:46:06 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 00:46:05 +0000
Message-ID: <4d3155b4-126e-4adb-a88a-a543783812ff@nvidia.com>
Date: Thu, 29 Oct 2026 17:46:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 13/16] PCI/CXL: Restore CXL state after PCI reset
To: Alison Schofield <alison.schofield@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-14-smadhavan@nvidia.com>
 <auAg6MFDGyVQvQxM@aschofie-mobl2.lan>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <auAg6MFDGyVQvQxM@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SA3PR12MB598757:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cfcdb56-b1f6-4952-8b67-08df361f2e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006|261022075727099003|261028144727099003|10067099003|261021121427099003|261009223027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	rN5fgdtIMjiWzCgvMrZMdFL1AW0KBxOleO/nhr3mvl0Fs46UhpK3LOfqY02AyCDRK0EaxH/fpqUXKBcJCM6/VsAeTOoXwSRSoxfuGAPzrkkfPGT5bvWPPAnKWFYeyL02WeskAJkHVmLiv5spidMTX+pxSeUJQQ6O1O/D9uGHyMaJcsURZzrLMvRdDTgNm61LzNmrBarOKa+DG8MXv2IR2Fcnmj+tbBIHIfZbcUohRw9ZuEFzXolbdYDpm+LYMAqiebgConZdukaymHsdzKnj17BqrgVWTL/bJIPtdupClxew8ba4OZV+SbOQ6zX0uAznoGA8ssVTx4QHIAoOSXkZzeW/ZdOtsryvB3+1ZfdJ00zVgVaSnHdDNKa5nZ+G/XYr9jecUlegUg8YRppp/PRJ4gMYs+Z0K3ylDx5nroK9uwdbvoFeuwDMyGXfGYj3aazHbHeQ2b2B5x8KCbOKo24biyBa3q/7sMMg2ni21U3K7iZDC6F9i5WXxjc7sI9M55Lpa9lKUZzHrLOunVPpArrvsWWBzW0+pXIw6DsDvw1UmoQlR8ohv+sHMDA5HyqETLKSSL3S3DMh2qADfAnFtgdW9SLRooKc7csx3ZYGU2hmnWY5V4jKgcpwf1kV8VQQryZTLXWQ3vWfRAQ5aSMrXkfzdmJry3D5ZCRBcaK9psS0d4Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261022075727099003)(261028144727099003)(10067099003)(261021121427099003)(261009223027099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WU5IVVE0YlF5ZUs1WXk3Z3M5bVVWUHVDajdQMnhvd20wcllUdmMxVGZCSE9w?=
 =?utf-8?B?dlpuQWxuU29OWXZPVklqRFVTRVlUeit4cUFqY3JabEJuQWVxKy9zY2wwQVhy?=
 =?utf-8?B?QWJwbHIzMmtMV2RPRTBOWXR0bnRwL1IzK1BMUW5yTFh4c29PSGUyRHFUN1pP?=
 =?utf-8?B?R1RUWmtyNXBLTmhlenBSTnJuWkhDR3R3eEg5dVRHc2RSMjMwS2g5cTFqek1D?=
 =?utf-8?B?WmZtdUM0dXdPcUVjTE1wSXZaVGdGbWtKdThDWk5vQVBvQ2RWeUhqK29EWXVi?=
 =?utf-8?B?MU94elNyRWw0Z2NFS0RRdFgwdVNkSkdEZ2hYZzFTcGo3RTI3M3JIRi9JVDk1?=
 =?utf-8?B?RVkreHZIdjNNaHlydUNqeWZhM2VycTFuWmZmNnlMWk5nQmowYW1md2VyR29h?=
 =?utf-8?B?OHZ6VzJuQVgreFhuT0R1a3M2aWYwRm1NbjlxWnh5RGliM3RrbHBnZ2pKa05k?=
 =?utf-8?B?TkVvV1ZrUWQ2UXVQc0dNRjZSZ20xeDJqaFZHSk5kRlVxKzk2MUQ0djVDU0JK?=
 =?utf-8?B?bDlMZytQTVZxSzQ3a1NMdHJEaFpEVVNsSXZwUW1RdFJrZExzM0xjbVlCNVhx?=
 =?utf-8?B?eDVjbGQ5NjY2MDV6NlBsYTg3aTVyZWlyQXVwOVRUbVp2VnhzSnJENExIQmY5?=
 =?utf-8?B?RVlBZ1Q1RzZ4U0NoVk8xY3l4eGhZOWdVVXh6UG8yb0dXTFJDWDR0aGdLWWtC?=
 =?utf-8?B?RVkvMHNTUHIrQXM0V3FBdE8rek1oNDd4M3J0QWl4MkVGT2Nlc25KNUVwUUFw?=
 =?utf-8?B?c2ZVVUNsV2JwMWJQTnM1TlBJNFdMZXZTcVdCTnhadzdUSk0wWXRJYWtuWFo3?=
 =?utf-8?B?cm5pbVA4SnVRK3NjZTd0VDFpTFN5RkNOcm12VG44c3JPNkhBSkkvT1ZoeFVN?=
 =?utf-8?B?TWpOZEphb0R3ZjU2MElpbGkyZHN4akFMMkJ4UDlFN1hGWWh5YWNHbW1qMUpK?=
 =?utf-8?B?V1djUTFhc1RnYzBYbys3TE1qazVMTkpmNHZYU2wyK1RuQnFrSmtMRkNHS21Z?=
 =?utf-8?B?cTc5TW44NUR0alB4WjhkKzU5U3E2K1czUzlVK1B3VFFVQUcrSWZjTkMyYnNN?=
 =?utf-8?B?d2xIUGxpTkZobjZpYzhtbkFOZXI4b0ErK2FHK2RKT3Z2V255am45OXQ2TlF3?=
 =?utf-8?B?aE5NZUhPTmR6SXpNbnFacklmSnJhZjJ5QzBENDRWTE9lMDhyaHBZc1BObWw0?=
 =?utf-8?B?enI0YjNrSVBpTWZyVUhrdDFWNk1FelFhcjFZL2hCR1gyTkhsaTNYUGdsckpm?=
 =?utf-8?B?YkVSS2ZBMWRGRUVlTi9xdlhGakU4eHhCaGtFb2tSVERBd1dhNjZhTGM4T01r?=
 =?utf-8?B?Q1lvcmE1Tk5yaFlLbks5anoyaEhJMEh3REVPQWpGK0VJOHBLUTFES0w0L0ta?=
 =?utf-8?B?K0NBMm9QM1pKaVd4WHhUdmxUNk93L1hsaXdNVE1TVnRISDVlRXBoK0xHZ0JP?=
 =?utf-8?B?S0hqQ0VDT3RWdFRzMWtjdnQ4cXpLckkxeWN6QTBLd2NoRFpmL0NyNTFjNkJT?=
 =?utf-8?B?NjJlSElKTkxjeDdzcUI0UkpGTGJBK045V0tBbHJ2Z3VqMEpBaGhXNU1CTU53?=
 =?utf-8?B?ZG0zUWswQWRscGo1YjlNUE5XZ3M1T2gwMU83UXg2VlJYRERtdVQxNlZmOHFk?=
 =?utf-8?B?R203QkUxbWxWdUhBK2lDNDI5dURnWTB5ZzlCbzBJSXdmQWpSN1NpWU1sZ2th?=
 =?utf-8?B?SUZYSkJucjFZNlc2OWFyUVNoeVAvWUdCbnBVTkRmVUFHVHJ6T2ltY3hTazR6?=
 =?utf-8?B?M09BTEFwSzB5SUdMVVJhUDF4ZGV0WGhWeFpjTE03NDVnNzlzbUtEamZtRW90?=
 =?utf-8?B?Y1JtTTAxM1RvRkVDTncvTUFvOWM5LytFZERMRXNCQkwvcGVjTkVTRkdWMnBk?=
 =?utf-8?B?dUxqYmxNZFJsL1ArYXdtUGUxL2pZSjFkdGlHL3BObWgyd3dydlRGOEhtcHNo?=
 =?utf-8?B?eWtleDA4VElteUNGbFlqQlFVTzVqcW45VGV2REc4eW94SDhjdHJsTEFtTEVm?=
 =?utf-8?B?aU56cGpvVUppdWF0QWphU2tLSmxqUHd0b0s2OTNoK2NCdHFwRWc2R010NHZw?=
 =?utf-8?B?WnY4TUlDeUMvdGIzS29EUTN0U3MyTklib212NVVld0hPTlIwU0p3cU1uMkRv?=
 =?utf-8?B?R0pFakdJb3VYQXpmeVBQNEtCY2s2Nk5tRzlsTWs5bTFMd2llUGY0eituWjlP?=
 =?utf-8?B?VXBQeUZ4L0NBL1dJb1gzZ0wvU2RPTG9hSFhZMEVlK3hqNDIrUlJxOUpwbmM2?=
 =?utf-8?B?WmxCZFAwWExhVWx6SlgyS1NSTjVqbUMyN2VNVXZ1WXdFbWlqK2ZNNWUvbGx6?=
 =?utf-8?B?ZGk0dVhQMXJwTXFZZm5KVWVtS09uYTNMMUhMa1dMRzU1eTJyc1RnZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfcdb56-b1f6-4952-8b67-08df361f2e3c
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 00:46:05.8968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Qz6YANjY+zXnaUfA4l/E/fZ0yO37M6iXD4cwJdEnIucIIsQUfkXtNvy/2gRlUZbHKy4fJ8b6qHLph+0y78C5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB598757

On 10/26/26 8:56 PM, Alison Schofield wrote:
> Hi Srirangan,
> 
> This looks like a copy of cxld_await_commit() w the final test flipped.
> Could cxld_await_commit() take the Committed state to wait for, instead
> of copying it here?
> 
>> +
>>   static u32 cxl_hdm_write_range(void __iomem *hdm,
>>                               const struct cxl_decoder_config *config)
>>   {
>> @@ -273,3 +293,163 @@ int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
>>
>>        return 0;
>>   }
>> +
>> +static int cxl_hdm_decoder_uncommit(struct device *dev, void __iomem *hdm,
>> +                                 int id, bool *retained)
> Same ask as on v14.
> Can the restore helpers return the error and let cxl_restore_state()
> report it? v15 swaps struct pci_dev for struct device, but it still
> runs through cxl_hdm_restore_state(), cxl_hdm_restore_decoder(),
> this function and cxl_hdm_read_decoder_settings(), only for dev_err().
> 
> snip
> 
>> +cxl_hdm_restore_decoder(struct device *dev, void __iomem *hdm,
>> +                     const struct cxl_endpoint_decoder_settings *settings)
>> +{
>> +     const struct cxl_decoder_config *config = &settings->config;
>> +     bool retained;
>> +     u32 ctrl;
>> +     int rc;
>> +
>> +     rc = cxl_hdm_decoder_uncommit(dev, hdm, config->id, &retained);
>> +     if (rc)
>> +             return rc;
>> +
>> +     if (retained) {
>> +             struct cxl_endpoint_decoder_settings active;
>> +
>> +             rc = cxl_hdm_read_decoder_settings(dev, &active, hdm, config->id);
>> +             if (rc) {
>> +                     dev_err(dev,
>> +                             "CXL HDM decoder %d has invalid configuration: %d\n",
>> +                             config->id, rc);
> 
> cxl_hdm_read_decoder_settings() already logs this same message, so it
> gets logged twice. That goes away with the reporting change above.
> 
> snip
>> +                     config->id, rc);
>> +             return rc;
>> +     }
>> +
>> +     if (!(config->flags & CXL_DECODER_F_LOCK))
>> +             return 0;
>> +
>> +     ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
>> +     if (ctrl == U32_MAX)
>> +             return -EIO;
>> +     ctrl |= CXL_HDM_DECODER0_CTRL_LOCK;
>> +     writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
> This reads like we commit the decoder first and set Lock On Commit next.
> The spec seems to say the lock only takes effect at the moment the
> decoder commits, making this too late. Looking at spec 8.2.4.20.17.
> 
> -- Alison

Hi Alison,

In v16, I changed cxld_await_commit() to handle both commit and 
uncommit, and moved restore error reporting to cxl_restore_state().

I also changed the restore sequence to set Lock On Commit before 
recommitting a cleared locked decoder. Retained locked decoder state is 
still checked and left unchanged.

-- 
Regards,
Srirangan
