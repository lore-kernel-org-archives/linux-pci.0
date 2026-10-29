Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793244894;
	b=bYNvejaxqRXIuS3g4TWkdJnZY7t6L+sN7BKjw/tPL1KmccrbLtHeEqOGS/SW49wfCeoH
	 4OM06mM9dC+AAku4sJIYQVTL9Jsz/v2sUgHFdJTpxp7eSddQDUPAPJVzXVKsQhCf7jFsM
	 SfzFK7AgCrxXb+Q8dfqEfn6MAaBhzetdNgTXWu56QjfzXCnDNZRu/knUbAFUJxxqPCUMb
	 2spQd35ZeSK8KEA9ZsRwuHcqYPG+2jPHIBcvxws9CVe/l3h+cX1K2SyAogBGufcFiEC3s
	 hjomHvlWvRdDN6vvjlbQCeqJfRiP8qn6EI8MSCco80yyXLAj7OFNASTLXV2SrmQe9ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793244894;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=2D+LqbjF9aRuvOFzp9JzuMwROFN2wyUUxN4ndpHEhYQ=;
	b=SnLcAKyI/jidwr2z1PBD0eWI0XPehZxc4Rk6KKHu/EMXwAnsXEybeg1FU0nsGNRyM7Yn
	 BOJ1No3bMojLGZPy2s/7I7cp/W2fgmAhKl+jgw12cT9qsPR7f6uoycx6Moim2iEH1Tz5a
	 szDLtelbFFwYRrWL9ftO27OHShWXlHKa4XbKT4WxKN7OBk6z781+Uq2uapeHio9cO8BF+
	 8/QE9hpqIqGvsQbq8d2PIgUYH+5qAa6XfmnNPTyT7KkS+8Z6YfsaoGeS5v5hZVw0HoFKC
	 E1L8hLT4YQVHhC6t+s2e+miDdLV1yUCwnZfDxD9DTI0de3RagZ6bS7LvDoPGIS+JzhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q7EUc+jJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.32
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6806A606A31A;
	Thu, 29 Oct 2026 03:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6806A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q7EUc+jJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jM2IDUdDGt9nKe/0X+ImaH7dkEkOfaNCeJFIJc2cJZqWEBYkNtizJ7+nD1lW9195V437Z/2s7RY1ykYTysZ1WB69Wbq5HV21ahIyqtC3qmdfCkdbL1lDUUrDgQw5cY9Chl8P7CRi0EZBPBpKZBmItQDjDvCHg8tFFou+IXBDyh1f5wVpUEcNK6hWRagenRZO7jgVWo4/QR8Z/J7WzFQwE1O0reQX+aLWe+AZWH1Lg6Bk5NFgxM0+oXZ8sE37Ud2NZrTbAGGb991AQ0cR1sieNj6UMHPa28os54xtaSI4torqcdfjVJ5FAJMwszAcxafgr3U6ALYhU5S1seYmxClh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D+LqbjF9aRuvOFzp9JzuMwROFN2wyUUxN4ndpHEhYQ=;
 b=sPvkQNw0W4uy23EDMEvjrPmSOQ1z7SZTMZaiZaFaDQXX2yLVqjYakdSm5Qgh8wQ1F2NxsKn5AhhmHgQbc/Uuv9kCBazSsy4LSTAThB2es7624YERgcHPa08+r1emnK4Xy8JdzguOCAIYxnyTlYa/D07tm1zjTbxb26f62tkbpNKzWtCeS0AmOzMLkUf8sWK1MxHTcMfrtQqGlTsGjpt45rKQFY/gvzbnGy7NdhFDLi6Dlke+ufHljc/3ACR4ETFnzr6921i86SLdKT0SY+v5SP4w4CQVkuJ8Cc4y5tjUQ654Zt+DtgjLRoZ01/7gju+0XhFGDsuBXpbfBceT2bpU2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D+LqbjF9aRuvOFzp9JzuMwROFN2wyUUxN4ndpHEhYQ=;
 b=q7EUc+jJcl8S8/RADiSLHp5A+w3i2+TDA76vuouxDj6PcsAQWIfhp7BphWHJhxfhmrhehEBLl7Fu2PF7LAUG0b2LY/yXh5s0AtZIzzDwP0xXQe6uV1IX+UfR63NOSM9xN87CLesTprzlQUdgs/BDKH3wwhKh7t+UQ2zPQZxRjv9Q0PB/oTYNKd84Gh9phWVq9Q5nHdi41UeNPOX9Yhb0+Oyw5PDzamumz9J+bGAoKbTY1smzX3NSgdKtxa8LCdRR5A9vRD6xeg6SsEmIvqeelJldAsVL+2q9DhVb+M8wP+6eiOo9becwDl7fKd5gfFK56banM2zKb2qLqoLnWqnJ2Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 by DSVPR12MB922022.namprd12.prod.outlook.com (2603:10b6:8:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 03:34:49 +0000
Received: from LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350]) by LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 03:34:49 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 0/6] Tegra264 GB10B boards the bus
Date: Thu, 29 Oct 2026 12:32:02 +0900
Message-Id: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBBA0avErBtQkciuEi3SJpsWJVoRRHfPa
 vkW/1+QKDIlaIoLIh2ceF0yZFmAm/rFE/KQDUqoSgol0WrcVKWRfdgxOMbaGu1GYY0kgpyFSCO
 f37LtfqfdzuS29wP3/QCqkxCodAAAAA==
X-Change-ID: 20261021-b4-t264-igpu-pci-8b94cf0b91ee
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCPR01CA0178.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::19) To LV3PR12MB9166.namprd12.prod.outlook.com
 (2603:10b6:408:19c::13)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9166:EE_|DSVPR12MB922022:EE_
X-MS-Office365-Filtering-Correlation-Id: 931ec82c-f62c-4ebf-1f31-08df356d95d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10070799003|921020|11063799006|56012099006|261009223327099003|261009220027099003|261009221727099003|261009221227099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	B7o+kQHwbrJuq30y6Iq/DFunUh3dIk05eu9KsORg5O6KEHCQH6+5IYP9j7Mgg77dAtFgf77EqI//zQEME3bOIJx31zgOVcOlEDVMkX18CwgKpt4YsGzzeOgIycR2bKFPsz7SBwFoZ9wE4RLJoK8rxPLcDb9Sl0OpAGwMsN4NT+3cpEC201OCfT9kzCqEPV+YhtxXGWytRksRoZ0gpuzNfAhhUM84CGaljo/URQ+WJHyCUnDCPxnUAgW9hS8QkoL+qItWUcOJ90gJZ2c3OxOjB+u/09XIqKwgpsbn663BG4qziuMA6A9rHorEEn3xVIO2AAphZow9oPF8xIm+Xzxxe5ndvVjUZRFsEYfmby6y5hoYu0nQFb7h4xAPMRXnpCqRjLx6QmMWZ8efdmWthsRjHeSTeRWHLqGvlD1S0W7UQ3U63OqK8zagx835Qq6m/YTItJr7KxOTCMbGxvf1vWb6fN11RpaYt6h3i4d2YwH7W+/BYRi5u/OKOnfyTPjmaC18PfGRGRaiciWcGu2KERN8hkHq51XZYw2qjbkVS0ByIYDv5CcnAFTI8VQuyebNKzDUZ46+6yXdbgWAre0j4JhRUvT9LroDKmLwgwmuqOlTPCaBqHRDga/S+ipqTgbcJuAacwQEMh1L6LnIXx6SX45leezPl2FMriLbzFMDKxP7etYNbkdCmbj3Ta8fV9pW53RwM9yzB4LPPOV/DFgGSkuTQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9166.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10070799003)(921020)(11063799006)(56012099006)(261009223327099003)(261009220027099003)(261009221727099003)(261009221227099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHIya3hqT0ZxQU9GNWxleXAvRlVyNmhuQXFtd2puMTFSRGE0YTZYOGJMQ0sr?=
 =?utf-8?B?dWc3Umd3U21HLzRSY1UrVUx3VktOWTR5S3BXM0tBbzRSZU90eE5UWWR3MFUw?=
 =?utf-8?B?NlhjbXltNXdvdFRwaEhQbncyYWs5OU9GaEF3R2VGVlBpVGZxUmVRM1RTOURn?=
 =?utf-8?B?YU9lckVoWHQvdXVzWjh0cFFqYVMzVllmNldPWDByeFcrRDNXWkJ0bGpGejNz?=
 =?utf-8?B?VjM3NFM0MUt0YXFqbGxNK0MyYkg5Wk13TFIvcUM1WUJ3S2ZNaWR2VENwcnhW?=
 =?utf-8?B?dWpxdU14SWlkSEswYnA4dFlHdHR0cnhjSU1aSllMNG91ckgvTHVmdTk3L1F3?=
 =?utf-8?B?ZTVwdGdCNnhvUmlwaHh0T0RWU21uL3FEVGhwb0F0U01FQjV2UDY0TnliMnVz?=
 =?utf-8?B?YTdwTGtaOTkrd0dVOW5ORWlWNDhjTjhIejB4R0RQeEN1YzJDN3pVclA5UFpa?=
 =?utf-8?B?dEpQdENjb1E3akxremlnT1pCMjhncFFKR29nTUhTbnFTK09ScTV0YVpTcWYv?=
 =?utf-8?B?eHpIbjRINEJwSlA3LzAySUg3aXlPVC9XcUwxc2laYkhrU1ljcjAxZ3dsRXVW?=
 =?utf-8?B?T2dTYU1aK0xQb3NZTENXd05hcmFOU1RGVGpXTUp5NVlMMG1vdythZnVHT3Vk?=
 =?utf-8?B?bmtJVGdHUzFqOU5jWTJob2Iyb3JPWDdFR1kxaExzQTFoQmlSekR3bFZRaFp2?=
 =?utf-8?B?QzJBcCtTakJoQXBLSk9qZjgrVVNOWnpJOFZxT3hSMjZQN2dBMmxZbGt5QTBr?=
 =?utf-8?B?RjM3UzNEMmlJUi9xUzRGUFJxK25raWNWZ3FaV1dzQkI1MHFUS201RThRTUF3?=
 =?utf-8?B?bG12d2RyRVN4dkNEMlQ5R3hlQ3gxRHVKMEdnNWJENFRGbnBNSDVJclQ4Q21z?=
 =?utf-8?B?eHd5cDFacTRjRGtUU3pIQXVuZlZETE5JVEdtejJwOWdCcTZWZGFpQW96VVM0?=
 =?utf-8?B?eGd4cjBYVmtyYUR2TzRJR2dIb1piaUlZbndUL0RaOXBFR3FaeTBueTdVZUo4?=
 =?utf-8?B?YVNHWnQybmV4clE3YkNKaUNWajJ1UnpkazhWdzhPbWpaTVVTM2VOcW1Cd1ZI?=
 =?utf-8?B?a0ZOWHlwL0hHME1NWnZETGVJWU1qdkFtMWx1VWFjTXBtMHprVGVjWjJleWtu?=
 =?utf-8?B?SkRJTWdVbVlYWmd4RUpGLzB3ZnhrN3VsbEtrMmRBZkRHd2FDR0pTNDg5WUh5?=
 =?utf-8?B?V3NqSjBOdFl2KzdNN1M0RWJDVjdya0VDNHIxaG8yRkwzc21SRWJQZDc3Rml4?=
 =?utf-8?B?Nmhqc09KSytIZkhBaVhIa3RtYXNEU2xObUhJdDRzYUpGR0s3VS9scmhlbmUy?=
 =?utf-8?B?VlVWTTJLclQ0bDBtRGVZS1ZwcklEang0TTBBVmY1dXhGL2Z3Y3IvUzBHN25p?=
 =?utf-8?B?QlUzdWNGcG9JR011dThtMXZJZWhHSlFlckZtQlF2OUFKYkR5YWQ0aVMwVnFn?=
 =?utf-8?B?Q3hLeDZkUTNLaXA3RCtmNW8xMFhkaFJSOWMvK0ZJYjVVVTFPdU9JZW1zRFBR?=
 =?utf-8?B?RGtLVjNZcE9KY2l0MXFKbnpWa1pvZ1Jyc2tlVFJLbFVhc3FtamhIWGtHbXNw?=
 =?utf-8?B?MUFqUTM0M0sxZU9Xd3VlVnpBZ05LaG5MRVZOQlRNbCtBN08yQjNXNkhlWnlW?=
 =?utf-8?B?Ky9RMTU1TW1vRHByZGp0TVMwQS9NeHJWL05VblRhcS81ejdKcUV1THRLRHVv?=
 =?utf-8?B?YTVzT1ZGd1NFd0V3amVCckk4ZHFNNE1DZ2E1MEtBMW4rWU9yVXc1b2tBUVcr?=
 =?utf-8?B?S1I1cUZWRXlyam84VFJEY1BNMGJBcHQxYmhhckNLKzU1dElrS3Z5ZUI2MkNi?=
 =?utf-8?B?QWRwTFlDYzQ2bEZhSXFOYzdXSk1ReEJUTUpaT3BGOXhIY2x3bHJNamJ1L056?=
 =?utf-8?B?NFhGaXZQUFA2UDFOaFlQcTEvVzFYczJDcDdDNmluaTZQL1k3TFdjM0YzbmFp?=
 =?utf-8?B?bG1KTUtVa2xtZWl6VzE3cDNuc21mRDJZTDNjajJQVlhxeUwzc2FKeEhDWHVP?=
 =?utf-8?B?TFNwWjZSeEp1K0NmK1o3c2swR09acktadFgvNGVjN3AvMk1lZWIwVmdlclB5?=
 =?utf-8?B?WGZqcVdJeEhnSkw1RmJxYVRoajJOQkhMTGRjcVgxVlR5THhqZy9Nak5vbzI0?=
 =?utf-8?B?RnBLWnJwVnJHZWpybTNaNkhHNTNab21qTzQ3ejNyWUgwRjBrNU5FVHFQKzdI?=
 =?utf-8?B?MHoySWd3bmJSV3hiL1JWdnUySTZ3d29rNHAwNnRaZXN0N0pXOU9tQ0ZTT1Rl?=
 =?utf-8?B?ZlNkSnFqVTk2OUd4L255TjU3cVYzWU5iYjU1Ky9STURZVzVzcUFRVXgzd2V0?=
 =?utf-8?B?UDQrRHBnQkx6QkROcHRwSFZzeUQzblc0WEVqZ3dkVnJ1SEU4WUd1ZjNrTU5V?=
 =?utf-8?Q?lSJ/JdOJsAXCK+gjkwLP12ihZaozxKeuobhNTYOIFETq+?=
X-MS-Exchange-AntiSpam-MessageData-1: KpuXfJK9E+qxhw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931ec82c-f62c-4ebf-1f31-08df356d95d2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9166.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 03:34:49.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vOhbeupJP0OcoGt8q0zcwYOp6styg45QFocvBaG+kDIxZcGp5nQLSaNxvqjl8e1Vz3Xg28I9nQxyN7xGNQcig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB922022

The integrated GB10B GPU on the Tegra264 SoC is connected to an internal
PCIe bus. However, it won't enumerate on the bus unless its BPMP-managed
power domain is enabled.

This series uses the PCI pwrctrl framework to allow enabling the power
domain before enumerating the bus, and adds the device tree changes
necessary to make the GPU appear.

Patch 1 adds the ats-supported property to the Tegra264 PCI controller's
device tree bindings.

Patches 2 and 3 enable the pwrctrl framework to detect device tree nodes
with a power-domains property as needing a pwrctrl device, and add the
GB10B's PCI IDs to the match table.

Patch 4 updates the Tegra264 PCI controller driver to call into
pwrctrl to power up the endpoint devices.

Patches 5 and 6 describe the GB10B in the Tegra264 device tree and
enable the PCI controller (and ATS support) in the SoC device tree since
it is chip-internal.

All patches are independent of each other (apart from patch 6 causing
device tree warnings unless the binding patch is applied).

Thank you,
Mikko

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
Mikko Perttunen (6):
      dt-bindings: PCI: tegra264: Allow the ats-supported property
      PCI/pwrctrl: Enable pwrctrl for devices powered by a power domain
      PCI/pwrctrl: Add the Tegra264 iGPU to the generic match table
      PCI: tegra264: Power endpoint devices before enumeration
      arm64: tegra: Add node for the GB10B GPU on Tegra264
      arm64: tegra: Enable and mark the Tegra264 GPU PCIe controller as ATS supported

 .../bindings/pci/nvidia,tegra264-pcie.yaml         |  5 +++++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  8 +++++++-
 drivers/pci/controller/Kconfig                     |  1 +
 drivers/pci/controller/pcie-tegra264.c             | 22 ++++++++++++++++++++--
 drivers/pci/pwrctrl/core.c                         |  7 +++++--
 drivers/pci/pwrctrl/generic.c                      |  4 ++++
 6 files changed, 42 insertions(+), 5 deletions(-)
---
base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
change-id: 20261021-b4-t264-igpu-pci-8b94cf0b91ee

