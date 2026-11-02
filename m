Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618490;
	b=xCi5Gcc3x/YxquRWniC9Mt9o4qesGUd5Z+3BLkbu5Mn0ZdtZHHveh2Rq0pHcpuhRauJk
	 nlF0H0/59snvsluFB4hy38/SOcPcSpUYYXr9cRpNwycZlgc7MDGMAcOUmqU+YYfQT/02S
	 pvCoKVbcok+WLK/fvOGbZpdUXscmlmWdLJ6aolEFB5UxfUhEypc9ZfKXU5cUvctuvnUhX
	 K/q0Fm+tSZE0shpsWqjCRJtWhIivUzpwOJAcZ5J6SuzB7onqmkD84ycfF3rOD/PD/1EpR
	 PbOOsIY6CYNDllYSTF0Bu19fCEiixUEXV4N5Nw1ydyU2XOkgEwTuT78HT2YI35B+/+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618490;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:
	 X-Nvconfidentiality:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=mh70a8hHfK3TwlYILdcOL6K6Oo6KcFcN57cHRZopafk=;
	b=4eeiZ0qOeSX+E0VGdFfj89+hQYwW4zwV72TYQJ0MEtDWcHYpuUuQzBfzL0ygo2BJ9wV5
	 PqkSbnSOKH0YHOb7T9ZMGm6lv5z3Z5jdcvHrZHPXURNBDN6AOipCFYx7SznuWVBb3KtuP
	 pBWygPxxxgOAg7GqYu9HJRbR+ao2+welyru8tOc0N8yPeAszqHdBDiuZNdVjMbYYTcCb3
	 ykG37egfSbaYz+v0GW6CFhFkUd9VHShPPwzTEq+uCkTpCIYUkf0JpVAetr/Zyy3hapCwn
	 kfYDyqpZqAlXua50m8lVJPnSrZBA6kRAW/QwU04SeeLHKo+MGz5o1AAHC+ErndGI5fA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="a1T/VCBN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.12
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E76606A334;
	Mon,  2 Nov 2026 11:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2E76606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a1T/VCBN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxFZ5q7nAAGQVf8hJVQJyk/uLkQX1C81Dq3ay5tvEXOGoLbC6BRoNrKS+3coIbnoc7efRnOS0YQrUnre9CSp3KpdlZFEB9dKhv4aHBIUOuTElBRWF1vySB3w1vGW10fQv/t+wCAaaXXomkWeOo8tW0f+7AS9kMQYwPeXoEOZt6aNU0YsZnvKHFDdpU+l+WKyO9CvLH8DynGHIAhOtvjcB9EitIhOT24Mz2+jTyp9hVnfq9gJY6qQhhzIBWyeHVgc20o0+ZfuQp/vzuTw/FQYHpLfXDP6q/hjR8SBXugSkp57/BjmfhpQCaH/4sohvnAH/hrB8X35AQ0eYf23onubjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mh70a8hHfK3TwlYILdcOL6K6Oo6KcFcN57cHRZopafk=;
 b=t/r1Mbx71nwJ9TGujcNypBDDgWIP1rSYB59mjfUBQuq8Pn4Mpqr33sjrfkztVTG7wpaRnvnnlxM37VfO6S2B7HiZfhgRQTz5Euk16N7u0EjH7t9/5VYL9Nr+OlLzuXbzeDKftePb+B2Emfc1anRGPB7x8cAlPqdWTZfhYha5rWgz7jiE3K5AAL62tiDbPJ78o3hBd4ghClAvZeFrzxI9b7uXrZRX4NUT7cQC1jJ0C4GmV2ATY7itgaifYg9NsGD6rgcwLu/qGbmZKLm3nMQvzcHAMvlMO611vQTHB4PFZdl/jLYr9fRVcevcgWOctZuQ8N1snkAGO6BIY+ur+kia3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh70a8hHfK3TwlYILdcOL6K6Oo6KcFcN57cHRZopafk=;
 b=a1T/VCBNTMlkXt4JsOhbxnjrP2RlO2h/+wKQmiVdt3uAonEib3CHF6CiMaZVewdTIzcppfgMIpfUFpx1XrgG4y4mdm4cTr3sZtWQWlRcHD1AmULSgO18P024Heo5BbNwIrylr/F7M2T9djIF9rGMIcyIHcZS3Q5fhCK6oZgGweOM69wwIpGaeK6NGZ4YhWYsu28EI44GoqV/0L98KzdEbBSCPCdYOecRw4MUKApQiYcaLUkKTFYGqc/cF+bMVYROgNcNZSA6eU4Eeeb3ZXdQ4iuhKJMeyiA0RAz4+aVmWvbgu2cOB/NWCMuiCL53Vub0kI9HDAZ/nxKeTnm764MIYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB257519.namprd12.prod.outlook.com
 (2603:10b6:404:22b::7) by DM4PR12MB5964.namprd12.prod.outlook.com
 (2603:10b6:8:6b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:21:25 +0000
Received: from LY0PR12MB257519.namprd12.prod.outlook.com
 ([fe80::89e:d21:20ab:ae5a]) by LY0PR12MB257519.namprd12.prod.outlook.com
 ([fe80::89e:d21:20ab:ae5a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 11:21:24 +0000
Message-ID: <1aec47c1-2b4b-4b39-b257-3f2500cef85b@nvidia.com>
Date: Mon, 2 Nov 2026 16:51:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] PCI: tegra194: Balance core monitor clock on
 failures
To: Frank Li <Frank.li@oss.nxp.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "thierry.reding@kernel.org" <thierry.reding@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>,
 "Frank.Li@kernel.org" <Frank.Li@kernel.org>, Vidya Sagar
 <vidyas@nvidia.com>, "cassel@kernel.org" <cassel@kernel.org>,
 "den@valinux.co.jp" <den@valinux.co.jp>,
 "marco.crivellari@suse.com" <marco.crivellari@suse.com>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
 <20261021061349.1265704-10-mmaddireddy@nvidia.com>
 <atjdmjX4-Hv2hGVq@SMW015318>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <atjdmjX4-Hv2hGVq@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::50) To LY0PR12MB257519.namprd12.prod.outlook.com
 (2603:10b6:404:22b::7)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB257519:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: de566a37-50a3-42ee-1bbb-08df38d36ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|10067099003|18002099003|22082099003|56012099006|4143699003|11063799006|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	tYsbO3fQrliqf0+G7HPN9E5OWawtYqaIUdadT+b/bjy2BZwxiEo0lhkg1bGounZBu8BjzmkIi+soovOgATY2ilhahTrEYB46fY2oEUToTo20U8Px4dToMLNmEpt8AgRUQyDkik2UWEHlN7Hv9QsOHFDNreCBF0mpfjDdWsgvBNXDI5WRUbFUR6fiTa1k4zT91PZ0aZumn4/gE1DuHYKSC5eEvxUmnVOXgSzeOkeQcEH585bpEphFt9tc4hVSg7Tdh4wHrV2VB+piOAkMBYcrYalnjpBHM1iHbtBXCLM7SQApHPcZwbPL3GapW3LkINmTlV01rEioFvEMr/x/XLVyG2R20u1YqjL7sj7Fmil95VJmWrqUoN0UlVhaY+lRir6xdTTcSeDAMeX6t11gVi7SZ5MJ4Dw17zifFoyyTRxIzt922gvFuIfLjB5sOo/ePVq2bZDhAgZqfAg2tHTuMYm03V7em/gMMyecew7yFvS5kIo1Qg2iJb8mvWlfJVNVxSPZ6pLGcJ8HjS8hBQUxeZfgyGdC+ssUiEqUQ9DcbQhVCPxt/4HZhJaOYpxRsF7vIrQ8MC5ZTzvlZw9VnS3Tv2xkVHiqGAHHsApMY2MG9X4JOxecvB/3mLq2WRfM/wZfyYxmDDJId8hIikGmKew6F6io84UcSRC0D2q+iSUf7GlqPQo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB257519.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUxER3V5Z01TOExGSjNaK2E5M2dJTlpxWHU3d2JSbUZxTGl2aGVTOFJNYStB?=
 =?utf-8?B?a2JKdU5Zb01vVGs4L3BjTHRLei9sa25sR2tMNjF1OUVma3FlM1UrSWJicFE3?=
 =?utf-8?B?UGlLYzB3ajJ5dU9EdE9pbzRhVEpITjBwd3B1RS9xcXRHSlFhZzJndm9rMUZG?=
 =?utf-8?B?cGs1S0FJK0hTZEF5Wk1UeTVWN1UzUExJNm5xWWFOblJaVXM0MzNtQlVuVUpr?=
 =?utf-8?B?NHgzSGdkZ3pqc0ZQSVM1MlBISGtLaWRJdGU0eEVGN2xDQ0c2dlltTGttb0Rn?=
 =?utf-8?B?ejVQNHBCWUJxNUxmcHZaeU9KanNtZ3p3aUtacTFRTkV6K2hIWVdyQ3BpaVly?=
 =?utf-8?B?eWg0WGV3bi9SUDRqeDVEMHNGaTJEQ2tHSktwaGVLMVBTMGQrb0dLRFhNUkRl?=
 =?utf-8?B?dWRmd1VnOXZodnBOZlgvV3Uybm9jNHdieGZPbkRCTnE5eUFjNEh4d0tvVkdW?=
 =?utf-8?B?MENKUGUwb0M5U2pkUHRac20vQUJEQjF2b01TMFJtV3FXQU54WnZXRHNqeGtC?=
 =?utf-8?B?VFZPaGwvRjA3cFZ5S2NZSmtIRm54ODdjZDMvbkV6WExLNCszeWRKQnRuWGx3?=
 =?utf-8?B?K1NjUXg4VDlSOWpZWFB3UVU1aXFqUHdXVTdIWE9zakZXNG9VM25FNjc5bkdh?=
 =?utf-8?B?YXlsMjJ4U01uT2VLOWVXc3BVTFptSnNHMHNCSEJVV3cyaDU4akJ5bklaTzFP?=
 =?utf-8?B?dG0zVzJQNy9tS1RGdW1NNStqbk91cjN5ZmN3a2c1aFU4MHlCVUE1WTBYNjhw?=
 =?utf-8?B?cm9FMUdhMlh0M0laVTc5cVRMblJYSjI5MFhGdTI2SFZXQ2RNcVZONktJV2l6?=
 =?utf-8?B?UWdNWGFYbGhKVTdlekZjd2Z4WkNEL1Y1cExTaWlOaVdWTEEyK0pUZzVaYkRl?=
 =?utf-8?B?QVZBM2xWNFhEdmY0SEVmUjAzR0lkZnA1SFY4U2hpNkhveXoyZDdtRkhxVU5n?=
 =?utf-8?B?UGcrWVVEZlBZbUdDd0dvcTlMc0pGdi9oSDg1STlXQ2NQc3E2SkF3dDFjZEVh?=
 =?utf-8?B?M2tJUDZuQnFoS3IwbHR2ZWhuRkJwbngrbTdXOTZBNlhGVDcwL1JwMDIvVlJU?=
 =?utf-8?B?Mk81amFwbGpmZk1PeXBwc01hTUdDVXhWMnEwT0ZNcS92ZUFJOG9iSW9JVVZu?=
 =?utf-8?B?b1lkaU9QWEdQK1VRZk4yZG80VUJ4U3ZuZGZnNFJSTTM5bXFPeVYxbkFBSnFC?=
 =?utf-8?B?c01zTVJXKy9YUzRwVWZUc0hsemxXL1Y0REd0UGdjMGQ2TGpoTWlNREpBeHB2?=
 =?utf-8?B?ZSswYndhcFNTQmhKT1BmN2QxNGw3ZFpqdzZGbmR6ZkxORFYwc29FUmRyY2Ew?=
 =?utf-8?B?dkQvWjlhQjRicVc0QnAxNC9HMmFzRXFZMjJKRkpLTkRuMVFZdzhtL0NJdjh3?=
 =?utf-8?B?NzdNTFNFald0QUJaZEN5WG1mdElZZTg5UGZkZ0E4Wit5NElJVzNWaUE4ajNJ?=
 =?utf-8?B?Y21NWDlDbGo0bDhPWVcwQ2hSOHFkQmdLTnMvUEh0QmdZWkZaV2gxcHBXcG5N?=
 =?utf-8?B?NCsxZ240SWsxdVZqaGUvWXlwQ2NmSjdpSmhMWTdYdHdCNGQ0anlOWlQ4bnV2?=
 =?utf-8?B?ZDZabHVPQ0dTWHhrRDV3Q3IwQUZ3djZ0MWQ5dXdZMGZnZGZDVFBWSjZvV0Fj?=
 =?utf-8?B?Njhpb0d2QUU5ZVg0SkZJdzI1UXl6blh3UEhjOVpBbzRkZWxmdTJwaWV5OHlx?=
 =?utf-8?B?Y09FWVdxZDc5cnlMUUtjZEVxUCtRblBkMWczblg5emMyeXpqVERsaFdPaDdO?=
 =?utf-8?B?ZTRJNWM5MDZLK2krUVY3QXcwT085dkx6U0xpQ2l3MFIvWnJTc0wzQTcrVHRO?=
 =?utf-8?B?b1pEK29DUU9HK3lBNlhFaFlxNnAzMVlNNjhmdGt3QWdhKzBxUW9DejdEWGFK?=
 =?utf-8?B?cVZBYWxJTVg4TlBZYUlNalJTTldMcEFxaGs5Y3B2YUc3bkhUSm40Q09oMjQ0?=
 =?utf-8?B?aFpOMEZINmszeFNjNjRob3NhVFBPMHF3THVIb3pIak5qT3ltTk1CN0dIc1RK?=
 =?utf-8?B?VzhPckJsK3k1dURxa3RVdHQ2UHpGTmVqMTExRTh2Q1BoLzhad3I3NnJ1VnVq?=
 =?utf-8?B?dW5pQ1hXUTdWeDEvWDh3MTZrTUFCZlFvNm9PdCtPdlBXUlozU3J2VTlBMzlz?=
 =?utf-8?B?ekV0cHk3ZnVaVkpORGFnRGQ0Mzl2ajI1OGp4Wmd2enc0N0VEOVhuUkUwSDRR?=
 =?utf-8?B?VExIUEtyaWN6UThLcm1MSFk4VXBvQnV4STVEdkd6clNEVzJ3TkJCd1k0SXU5?=
 =?utf-8?B?TWFXOU1YUjdPN0hhbTA4djdJKzdyR05XdnVkb2l3NHByQ0NLRjdDa2YvRkZr?=
 =?utf-8?B?c2VlaEVwYkZuSnRSdjI1eTR3UE9SUjdkYnRMVFp0V0VKR3NnR3FGZERnN3kv?=
 =?utf-8?Q?eE0x9YLkbfYdfs4k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de566a37-50a3-42ee-1bbb-08df38d36ddd
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB257519.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:21:24.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUbgxMVRUvxzWdAeiqy/v0o5F6g4jQJnpsDVYchSG5V9O84dDMrM9refMef4UCWe8Dt3W6barfz6aGrpQvQRBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964



On 21/10/26 9:13 pm, Frank Li wrote:
> On Wed, Oct 21, 2026 at 11:43:48AM +0530, Manikanta Maddireddy wrote:
>> tegra_pcie_dw_host_init() enables core_clk_m, but failure paths that leave
>> after the host init callback can unconfigure the controller without
>> disabling that clock. The enable error is also only logged, so later
>> cleanup can try to disable a clock that was never enabled.
>>
>> Track the monitor clock state, return enable failures, and use a common
>> helper on retry, remove, suspend, shutdown and host-init failure paths so
>> the clock is disabled exactly when it was enabled.
> 
> Feel like checking core_clk_m_enabled for clock is not good desgin. Do you
> disable clock when linkdown?
> 
> Frank

Hi Frank,

Link down is treated as error and monitor clock is not disabled during 
linkdown.

I created this patch to address the AI bot review comments. But, I 
checked our internal resources and identify the correct sequence of 
enabling monitor clock. I will send new patchset with details 
explanation in commit message and new fixed sequence for monitor clock.

- Manikanta

-- 
nvpublic

