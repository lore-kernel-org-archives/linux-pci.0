Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793607702;
	b=pcKYg9cIBBUP9WY0oP0XInOm2iJ8C9pBCm1nTxLG3Iqjoqi3+ozMB8mLykf6lkbyCAKT
	 yQ0aJLGkotb2k9TlrXOx5mWH7fPIU5OXLPqpFWr/9qDn1uMiRTV+B24xbRbyrThtRSLRP
	 aD1+psVGXhclUg9upQ+8lSdgsBMXHgJsqfztmyExZLP2MvJJdS9w9CobAOapP1DNYSo/w
	 npLe4PjTpBkkVhjep2JoePDuWOxU6QVbrQSyMx5Dw/+6/UEfcIqfzJU70sbUrsw5eCClB
	 P1dmYiMuXHC/TaPs42mDNyIHwu5BmJhb1V4MzLzc5xSbf1Q8yPXdsrjq/6nin2rBAMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607702;
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
	bh=D6B9t8IN/4IEsQ+QjNEHF57bBeOy1Jt+cV7v7rFoJt0=;
	b=1g5GwHGAWSwd9FR6dQPU1iQwbjw8Km2mC88jYMDLUEwcrBTQqgUHDH3ah0sKUcC1/F7A
	 dKYiwvOIgY3WRgrYZyx78TyQEMo7mTs7haTDbqewyIGmHG/gpv2XZ8U1ijD3Salgwv+7V
	 PPB/xXjam4we9UF1ANXlK3UxwvBtwZuJ0tyKNqazYDMty3KReWbH7O2UfqOVoVthxTst6
	 974Sg0wGs72NQvHQrJ21ARa/+joWoWW+WU+XNqBzNmRl73OqqjQa3MxuNt5vVoGeLgPja
	 NLm5laTXielJXEZ8q+vlq/VFy6NhkEB/gvBwvxsTpPNvDDf/67zLiWbyCVpK9owx9tQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tzbD3Pid;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.19
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9660A2609;
	Mon,  2 Nov 2026 08:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FC9660A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tzbD3Pid
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0Qk0BNA4KEHhxWkZMGUWM4qYaR36V47l+kpGgw+FYHCMZ87t9Mtsb49Ty9nlhtjMsqFMnRuRzjndpczNEDEwmGcJiw/N6wk/vFZTLnPOQjrCUz63ZWHoJg1GQ+2DW+Wff6vld2ljs6STQu6/1p44PzMLI/Mb4NOz5/ZMQWnwbZlAibt+ILHDY5Kub95Dx/0bSfTJKVjSARxtQSPOeeRnk/512qDdySANESV9oz9p6Ikkqg41L7WeY+jeyCcnp7OIMhpUTlQuCcytzYZql0IqYAvev5+sYR3/ZZrME7cBMt12SfKUQb/LuM7qrC0oPQT7dyUbjN6ES86ZCo/6iLXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6B9t8IN/4IEsQ+QjNEHF57bBeOy1Jt+cV7v7rFoJt0=;
 b=rmSRAbviOru/AAz4xR1/I5WdNATYbBHrtB6cQIgw0ln6gxBgwqTWyjJFbVrZWmNwwbck6B8FvWljO3Mz7KIHgtoBemmBQU0XCQa6RVe3KCXD5JAb7fUPZJS5r8Vb/d0xoroKqlla0GJTbQNeMAHZr5vM6pw7BwDcfOHopKYiE2HFm0phUbbBRtnrSRu1fewFWJGDrg+waLQgOjE5NuymOzy3vsts60p0vmosXUZPvyOnUcCiahL9l3ybBipQXgwPCOlI2r3BPLtFeHpP0CQPtXvydFNEqC6y15vnxBpzezuVmS4xNhC3qcaENI9yqpUcNFO5//ARwtZRWVAH+blPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6B9t8IN/4IEsQ+QjNEHF57bBeOy1Jt+cV7v7rFoJt0=;
 b=tzbD3PidHXWuJe/64wNlVdVvGVHXLN2jTTPHK4Zde/dYusSsOI4JWqiqKiqiF1ZWzIVzC/WnWOjMaioEbEACtu8wOrV8+X6qN5RL/en3T3dfZ9EUbv0LGBB9rwJzYH5PG1d7sw7m51SEddYYiBMC1HfheR0FxuACQLCmKfXD8EnbqBKlhJTpi5xo3nDUCiaUbtrUciYagS/RLk77P6vojla+mFnO3V4TTYkItTCvZj2wo23cK9YGgxjcHFAA7Yr8UJzUf8Z0WKBAwuwDPixMnE/5gvucxAKX6ldq6HnDw7F84l+X3JL2yYwuHkED5MbSluGwE5tGX1wWA5feG972VA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB257519.namprd12.prod.outlook.com
 (2603:10b6:404:22b::7) by PH7PR12MB8121.namprd12.prod.outlook.com
 (2603:10b6:510:2b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Mon, 2 Nov 2026
 08:21:36 +0000
Received: from LY0PR12MB257519.namprd12.prod.outlook.com
 ([fe80::89e:d21:20ab:ae5a]) by LY0PR12MB257519.namprd12.prod.outlook.com
 ([fe80::89e:d21:20ab:ae5a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 08:21:36 +0000
Message-ID: <bb434dd6-5c91-4216-8d29-3802cae7c657@nvidia.com>
Date: Mon, 2 Nov 2026 13:51:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PCI: dwc: Clean up RAS-DES and register field
 handling
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "mani@kernel.org" <mani@kernel.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "thierry.reding@kernel.org" <thierry.reding@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
 "cassel@kernel.org" <cassel@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20261016074026.564302-1-mmaddireddy@nvidia.com>
 <179334914849.5551.1603828369243192858.b4-reply@b4>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <179334914849.5551.1603828369243192858.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::6) To LY0PR12MB257519.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB257519:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: c48dec70-01ce-4746-d8c4-08df38ba4f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	uGTz4qxcWqLWz8Y6ig4jQUQJvSjON+yrWQMmUQDpvATh1dtJbQG0lj0Q1AuZyNgeqv0JlGqCaMBvSvUhyu76gr6sAiWstAY9k5aD/WIO0I0A6LlwcaZknGXGahyZOJZKe/RZb41+w3XTWpaFEA4JUZO7KxSyIpmOOl11zUY+oQfzJvdW/4h66jD5vZJXWfhmvaxKHx6Cv07JK6PHYbsGMKSL2SpyKExzYkkOxiqPHzJaKhUfXUnGop/lcjm6E2Fpw/J6XgOEGw2Hj+G6/JhrDamhYU9KUVUXH6/ZwEiKloqXLqDQCTAIoy+y2ExHkyA2LoEVPST9NDB9w2vH8k40+QcltNpoXpK3hQImpEBVHmz8bqGjjaafP/8r56UE27ZWeZCHB72o+j8C0v0NoSoUx4XBAHR3LH/KACjQrqw+pM77Z21/JZl7l18hdbh43Jfz+QHZ/0wyKS59zqbfuHOy3YMQz2ywLzfWungZXZTV1s2TFCKkFNx5VBPbtmuGGdkbCpoHaS7xDCm3aoJgowW+3wj/LjmoQ4mtAf8lUd/7qAUghK9g4mlRFrcjn3UPoO5tWnyiSmX+rigVXfQRg3O4KpBqvKY2NSvhUDAmQ5BOfYL5RLr94ITqSZpKuC3SijJhD1ubK5R/NnQG2M3hLlKn/9uNtUweAFL6Dcdc/zPs1ZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB257519.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QStoNURIcXpvakhnNEZaMUlVdkRsZ0l1VGhINnZXQ1FhY3RTNXN4dDBEL0xz?=
 =?utf-8?B?T0V5bDNrcmRQS0RDM0lFQ3pvMmdOVGZkV05jbllLckg0ZHl5TGhlcVNjd2sz?=
 =?utf-8?B?SGNsQUJNeDYxaHdsTEJKT1FoMFRLYWxjSGsrWDFQaUsxQndlNHc3TlJUbEk2?=
 =?utf-8?B?NW5KdWQzb2lYQmF6TC9XbGR1eDBZV3BsZ1lLcHFOK3krdEw1RFVzaWhvdjNZ?=
 =?utf-8?B?M042TFZUcERCSU94R2N1WG1ZRFJYbkpDRVVnN1FNQjJVMkI2eTlVV2QzL3Rw?=
 =?utf-8?B?bmZrM2x2S0lCcUcxV3JOWkFuTFFZdUtsOGpVUmhSeXZuUEM0VjdQMjlWNFpi?=
 =?utf-8?B?T3UzZ0xzbGM5S2VXclNkWnpGNXRnaGxxSE95OGhMMVd3Rm5VOVV3b2hUN09F?=
 =?utf-8?B?Ump6V0lhSkoyWGJEOEQvK0IzUEZXY0JOK1pFSDZTTkxSRkREa0VENkllTVBO?=
 =?utf-8?B?ME1RM1JvSFRycitsTmlVZ1puZ0xSajI3VUU3VFRJMFRwUUZSWURzRXFGdngz?=
 =?utf-8?B?ZW01YU1YYmFnNGNxNDdKNENWN3VlbGVjTjZxbXB4Mkx4bElZRGJ0MkdzWXVv?=
 =?utf-8?B?YUxNRVJQb094WnNqMDBEZ015ZDlyWThSRjdKdERqS2ZPTXUwdmJIb2d0SFdG?=
 =?utf-8?B?QzNTU1hWSGQ3ekcxY3JKaGhheFM2U3RjVHl1YnM5aFZpQzlyVzRUdHZUTU0x?=
 =?utf-8?B?bDZDTnkyaFU2R2pZU29KUWNUa01IbHRuRm93UmQwR3NPL280b2F4eWF0ZDVQ?=
 =?utf-8?B?TDdtVnpHdEIwcTMyaS8rd25DZ2hYbENyNGZHb3FKMFpsUU9ySmNFbDZhSkgx?=
 =?utf-8?B?Q2tIWWl0K3ZXa0xOSTEvQURBeTBnQnhyZHNHc0xBM2E3RGdKd01NL2diQUtu?=
 =?utf-8?B?WU8rRkhCN213L3BpYnlqYXlpSnlxZjQxVVJFUlJnQVJSUzQrblZJeTFUcm91?=
 =?utf-8?B?MnVIcTlhZVlMdzh5aU9MK04rU016WWFHUndJRlNPN1FCdHgvWUlOZ1pnbmI5?=
 =?utf-8?B?bWhxRUM3Y1g5cldQK3hiNzMxcWJTMlI2RHlINFBKcHM5c3NGd09SMXlkckhY?=
 =?utf-8?B?MXpOVnIrWVhyTWlzZUxrRnVxZUVWNUhCOTVKWlJkV0FDYnNFWXgxaS8wUzRt?=
 =?utf-8?B?UWhDQkgrc3ZHb29GdVJVNVBpemtrZng1UEdJTlJhNmpuWXU5dGRPNktINmcw?=
 =?utf-8?B?bElrYlUzOHczRGFWK0hNWC9Sdi9SMlNNOVBsek9TK2xHS213RGVkSXBmVEJt?=
 =?utf-8?B?NTdjUHpabmtCTVdRenhoa3RXSXB5bFhlVFZPSGw3UU5EVlhOU0thN01TcldN?=
 =?utf-8?B?b0R2ZW1mWm4zZmx3V29GamlsZmY4SVVyQ1IyMFNHMHZaQ3ZwOHB2ckhkaW03?=
 =?utf-8?B?dXprYmdyS0tKbEkxMmZGQTBHQ1lwbE5BcEdsbitLTzdROXZWWjQ1Tmc3b0lk?=
 =?utf-8?B?RUgzY0FjelVqS0ZkSjhNbFZGUW1nTXdtUkNIZ2tyaHE4MUpCalltVWgwMWlF?=
 =?utf-8?B?WkVNZ1dwQ3c2Qk5YZm44SGVyQnF6bmRMakR5R3NLR2dCRHFubXA1anAyem1n?=
 =?utf-8?B?YjNIVkU4Ym5TL1Bxb3Y5dmIxbTVzVWdHSS9kY3pwR2JjSkp1WDhIY0ZmZXFl?=
 =?utf-8?B?N0hFc2IzYjBhVUt2RFJMeUIrQkE1cTdJem50Tm9qTkVvcUR4MERvUFBNSDlN?=
 =?utf-8?B?WmxQSG9vWmYwd29ySmNrcmcvdnp0aUkxa1NXWHQzcGdDV25yaWthOTZlTDhj?=
 =?utf-8?B?MktyWEdNcFRSeklWVXpsSHluSHJNU3ZmUFpPL0k3a2MyZnVxRHRNWEZjencx?=
 =?utf-8?B?cGZoMi9PMSsyMnRvMEJIdGRIdWRYOVNIZnJUU2wzVGs3cXloQ1hZUWxpM2Ri?=
 =?utf-8?B?dzdPSTRlVUZuK0g5NHpKZUJhN3BzaGVBRzZNNG56QmlCNHJkdElkN0hPc3JI?=
 =?utf-8?B?bnpBV3RVakNENnE3UzRVbGl3WlJWK0dlaU1GUXBKUW9JSTdJZDBKaTdYUVJr?=
 =?utf-8?B?RmliNlBUc1V6SEQrUVBRQlJoSE80SVdJYXpYTEJ5SHRkV0hMWHUvelI2V3kz?=
 =?utf-8?B?dHA4R25kSEVJUTIxbklpQ1dKb0FTYlpJY1FySlBYNUpOaVZRS1drOXRqdTRx?=
 =?utf-8?B?ZElDazV0RmxZcmIxK1ZNOVFpMTRoMCtOLzd5ekFNUTRqV2xncHNCeG8zMUV4?=
 =?utf-8?B?VjVIZWdLczRyRGFzRnVXTWFCd0VvbWx3M2NyNFo0RmNiemlLRzl2em1zTm5l?=
 =?utf-8?B?aHcrdlpicW1RK2ZVNjkyMkFFQmRLTlFnbjdwRklaNFVaQzdjNmNHYjRmSkJM?=
 =?utf-8?B?TEN1S0hBbmREQVBBS003V1lpd094L2ZKUVlJYit2UlBkS3RBelo4UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48dec70-01ce-4746-d8c4-08df38ba4f95
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB257519.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:21:36.3041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9WMcge6FqGHDpzTQVkFlq4sjittkeXj+etOSAc2gbnqG+G/XSqLM37rogMcK3FR4DzZ+RFw871R1ljMb0GNKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121



On 30/10/26 2:02 pm, Manivannan Sadhasivam wrote:
> On 2026-10-16 13:10 +0530, Manikanta Maddireddy wrote:
>> This series addresses review feedback around register field handling in the
>> DWC PCIe code and the Tegra194 PCIe driver.
>>
>> The first patches add shared masks for the RAS-DES event counter fields,
>> convert Tegra194 register programming to FIELD_PREP()/FIELD_MODIFY(), and
>> drop shift macros that become unused after the conversion.  The final
>> patches make Tegra194 use the common RAS-DES selector definitions and
>> consolidate the event counter field definitions in the DWC header.
>>
>> There should be no functional change intended beyond making the
>> bitfield programming explicit and keeping the shared RAS-DES definitions in
>> one place.
>>
> 
> Series doesn't apply on top of pci/main. Please rebase and resend.
> 
> - Mani

Hi,

V2 is rebased on pci/controller/dwc, I will rebase on pci/main and send 
V3. I will add changelog in V3.

- Manikanta

-- 
nvpublic

