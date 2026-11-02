Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793608089;
	b=HTaSihEo8L/ksuWfLw/Ww3wz1yYgp4Pr05BLIUMjMDMBFNX9l9MR+ogHDD2B1f12Py0a
	 WVTfAwsavCzq7wGHrYyT9mX603sWYN9khAycOL1kp05j4bJ2cExvO5K4fI9FpDwl9ULzs
	 3/xe0aABWLJxpr6UjXlBuTUV2niVv/3mic9tvM3XQQzzGV9gmCRI2DZSWP5LF28/hMRHT
	 Kje04kw7ZpC7XEAlT+tBiRHTvj29TE3UgcgZqj2lD/V4T4xOotyZ4lAZ321l0GQMTwjJu
	 2g2Z1jcs/OUwE2p5YzGPqRoxhKz/4IIGWgPVxhGtGHfJJuzyr/XjhC8Nii9hqnyHLaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608089;
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
	bh=FpgHAhuLdIM2r06mtntvqTRgR0mACEplwu6BgkazjtY=;
	b=aWyCJgUImUsDrJ3L1xPF/dwATJIgO7gMDfJQlWqb7dMASQEpunOfpv90DAueTNMrWXPP
	 vJSjsxForfGjXW8nk4tCyRrhSzAUkDnxJO/qlF8Wpo/zU8eJtzuk0l+pssZ15FStNtAZ4
	 VlVuXLvZ9zzi9+lPSmnTOTa2UPDER2veiNL4l6jsCaZqNUzqwCJij02e5P1EgEXA7rLjV
	 2lTGJQneTXDHkfLTZ/bugOlBJYCo8bVGR3jLV2xXEuvjjSox/0jrFEQc4/sNOAzxwqpal
	 5GbS6rf1RSMCoLu+E7tavrcChK5w2sexGXCopchQpDEuJz6L8B79M2xDrcrUXM3O/yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PApHj999;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.60
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8A606A324;
	Mon,  2 Nov 2026 08:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2A8A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PApHj999
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hISBr83v6uNwt6K6P41rRZUAHABjKFMbuA4e806GbJ6V0GEGuNc/GOyEhsMjmthff8z753HERPNZgiB9PEucfmjhPlEbKpGd6n09YAp43ZT3Dd+29/QQdfgsTwqfvHZc0t15qVTiR8vj/b84o8xONRI+lfdX3o1qDLGSsXQsFE0x3P6QEcAgaxHG69ZLFKOl9eQlkPdloFUM2Itvy6luvvdy8kzFm4fVQdXL0ElWldm+A4SGy8rzRI0S7RCr3k7HK4fvvXUIdeBPFK/pMF06g4YXCUuHH2H7lWl/aUCW6SZYvQJ9P2LmygR0PpheMuP0LzB4PYZF6dvxz1JmC92RJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpgHAhuLdIM2r06mtntvqTRgR0mACEplwu6BgkazjtY=;
 b=QD/H4SOgwO9Pw/N+jr5TGqVAgt+apBUgR6NNf0HQrHwFh+MDBQiNq/pWIC/qy3ju6VOdxqP3J1fbwJGYnedHKLwCDMPg1fl/CqfLkuoP2jX+rUwk70lzP1uotW/OIGyG163MVc2yGDFkH+FdOKdLpcqFJYHaFwLf01ig/16fR7lllwtHQfZ/0bh91yAzdgJ5pJZh8j6rQRbbjXVCCm8rA6BFDfrZ4wG2v28D7CLpH5UfWLjzYrKsjw6JJQ7zGvuGoseyIPDt0HNnvIfBeDYNgk1l3gC/gg9AYdANwIOLEgIDoyY5i7mrlTadjx96+VYAaihwWslhBuOw4YnAnl/66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpgHAhuLdIM2r06mtntvqTRgR0mACEplwu6BgkazjtY=;
 b=PApHj999paIGaMWTBt3N5VydHZ5+GfV8GXYFXARY5uokhnu06UICaXQ9naohs/muDgftdmmTN8R8K4Dhs3Th4IPXEq+woNEkF35HpGQ99IKX5qQWp9jr7faX1kiHj0ugmQvSUu3l/haXaABpvHFOaSj7EYpTLF/IIQM/68Yf84giXtMo8lgRTw0T1tERQjOFKe8/RzAdrM99Rvi2AFg6q4Wa9jdfSricYskNG+kDAdq/0vU4pN5cEpigfeGTh5AKhDGhDoxCf4T2Dwg5a7rugmI54QIB85VWy1DbvXju+vd4fCoKq4htrCoTQP44ru+JGMCgmLuPHvjqFOYPgHsn9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB257519.namprd12.prod.outlook.com
 (2603:10b6:404:22b::7) by MN0PR12MB6054.namprd12.prod.outlook.com
 (2603:10b6:208:3ce::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 08:28:05 +0000
Received: from LY0PR12MB257519.namprd12.prod.outlook.com
 ([fe80::89e:d21:20ab:ae5a]) by LY0PR12MB257519.namprd12.prod.outlook.com
 ([fe80::89e:d21:20ab:ae5a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 08:28:05 +0000
Message-ID: <25a2dbfe-20df-4fef-86c6-d3d52d66b51b@nvidia.com>
Date: Mon, 2 Nov 2026 13:57:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: endpoint: Skip upper halves of 64-bit BARs during
 search
To: Niklas Cassel <cassel@kernel.org>
Cc: "mani@kernel.org" <mani@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "kishon@kernel.org" <kishon@kernel.org>,
 "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "den@valinux.co.jp" <den@valinux.co.jp>,
 "thierry.reding@kernel.org" <thierry.reding@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261021080644.1346549-1-mmaddireddy@nvidia.com>
 <atiX5UoJ0qgV0wGN@ryzen> <atjLXvkc-XZNF0oi@ryzen>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <atjLXvkc-XZNF0oi@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::14) To LY0PR12MB257519.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB257519:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da0aed6-8134-487f-5e5a-08df38bb37d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|3023799007|6133799003|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|261021121427099003|261026140227099003|261022105027099003|261026121527099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	SeG8WYL5By/UIhD8bsfbomjnisw/iiS2siyl0//TEgZuLXKHNQ2dVDBSpuNfEnaG+101lXgRa16OctfsliwEu9HnWlQJVTdiFqWihHvt1asd8BNi/fLmkGHEHs+v57ZD3xn9wAxY11GGDzoH4QxXXhayt9BR/zuz6hVc7SVR8R+ZNj+ODO2jrmssp6EUbH+dLmkxE5gkYBXv4NwQR9J/QCauEpnogyiMSW9iMA7WlPVoqEs4ESwwG28hdR5a5FurS/x5SF/htQ2kFrXQ/pSEoax9OUUWE8wA3NxqjNygmvpLk0vrQ2PTmgdDQkeida2EOXiHLtDbJVTwIkaNy4uKisoF2Qmt2TViCWtfS8XYIIc6HUdBFcuFl4haPbZt4PR/8mJtzXqFF9KJNW6GmlcAVfTpEhJA6QMPd1LpGEyhHl9Sf+bO6TzYZ7ougxHuSTK3nmB3UIsVxIutZNWvY0FAvPjAEZMt6Ww/Y/fdz6F7+pZuqQYgEiHlUFl3IoxLrCkGjwcl5+ES0XR2Q92nOpjSV9+HhlFM6QfPfL0a0RA0KtHLcpa+mi2OhSMhvN5FCJ+Lb6DOtbW3pQ9vGUhWnUsBvDDmv3TVbixF9uldTd/FzE/emfetWfSjSVCf3EyyxyOvcTpKCBsxW71gLPxFS9vsibizbxW5Mr7Pf+SRhgfa2Dg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB257519.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261021121427099003)(261026140227099003)(261022105027099003)(261026121527099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDhma1JDc1RoWWcveGJWWXlaelc3QmU1N2wydnM2dWI2R3p6NUJheFpJUGpP?=
 =?utf-8?B?eitXUXkzZ255N0FMWkdCVUd3WTRxVmVRNXFTaFplSjkvUlJOWXVMWjdKT2hH?=
 =?utf-8?B?ZUdIWjhMUGJCNnBkN3hrY0FXWnFkb3hqbGpzd3p0MnkxdG9PTGR1RVU2dCsv?=
 =?utf-8?B?MlJxTjhaUGhsUlNxb0wxQUJqZE1ESnJxNm4rdzA1bWV4ZG9XZnRIc0huNUVj?=
 =?utf-8?B?VTFkaURXc0VlbjRmc0EzNlpuTjNvZHh2ZFFJS1YxZUNGM3NFSHdIdDBrTGNr?=
 =?utf-8?B?Smppa3NvaGNibE5uYlF0NWZhMzh1MEZ2OFV0N0o1S1ZXeTFoV1VISTZyQ3p3?=
 =?utf-8?B?YTBwL3lOVjl4VFlZK1VjaXQvVEExVzBuTVpDL2k1VXNSdisrOXZNempUd3hO?=
 =?utf-8?B?c2NveG16NE1CTCtNdVE2TmUrT2o0T2tldGwrY1BleE5pa25yZE5TUDFXakda?=
 =?utf-8?B?aEhKTWxzd2s3dHVkaTRERldnVk5PUlpzMTZaMEdFTHgvalFzOVFxWmtTbTJz?=
 =?utf-8?B?Z3hXaEFvWjFIWVBPa2xzQkdxU29Cd1hsTVFSN2x0bDF3Z3FlY2VrRS9kTWlV?=
 =?utf-8?B?MCt3aEwwNXlIWU0wM0RkRmsyMDJXU3RjMFFkR3J1aFd4aXg4YTdvU0ZrV0pu?=
 =?utf-8?B?QktxRTlQRDE0cm4zb0NWL3FUL3RhQVgxN2FLVjVpSHVrRjRKNVRJdUE3MWZ5?=
 =?utf-8?B?ZG5vWjJWbWRKVFhqb0VTRlNkQnlKVHhOeVdMUE1hUHdXbEdWRnhiZFVhRGFQ?=
 =?utf-8?B?TmpHVEtCcGJFeE5xaFlXZlNOVExPcnNtdVY3N09PVEtxQU0vS2hJSE9HU3Y3?=
 =?utf-8?B?d3plZ3RBNHNkYjFZTUNLZm5qWWd4QmZJZXExTW5oZURqb0FYV1hndUtXUE5C?=
 =?utf-8?B?WUo1QTNoNnRSNnNzWXhvTGdpckxYNzIvTUJlOXFBd0oxQmovS1M3YjVGd2VZ?=
 =?utf-8?B?NEc3bmNLbnphTzNzOHZLbTVhcHJCcjJDWDY5bEt2eVFSNXV1REJXcVRUSkR6?=
 =?utf-8?B?ZFZPcHVtbjRXTWNmek1FUTI0aDRzdkorT3RjTmFYQTFFNlg4bVVmTkdyaE85?=
 =?utf-8?B?S0JuekM2aEFVRjBnS3VObTA1NmpCR21yaE5nZElvVU5IRVlEOHkvYVZYUzMv?=
 =?utf-8?B?ME9SVksvV3JLN1VlRDdJaXJzZlQyUngzVUllelhkeTl5QnBTY3NLb2JmcE9t?=
 =?utf-8?B?UEswSHBYdW51OXgzTXBtVHZLR0FNSmVmemdQYVQycjlPWUl2ZHNIMlFpeVhp?=
 =?utf-8?B?Y0M3WDlJUFhEdlY4UkVzbmZjK0VPNGwxbHdSTitjcElYYWkvWFRDSUhxM1M1?=
 =?utf-8?B?UnUzZUVGVXpVYzVqOUx0UjNhdEQwWk55ckNKWDRndmczeUFMdktZUUU2U1hP?=
 =?utf-8?B?eW1aREN5TVpTVXBOTHpHR090dlVwdHJiSytadGlOZFdoY1NZY0E0bS9LeEI3?=
 =?utf-8?B?d0F6QXZBRVp4TkdTajBjSDU1b2hPNmhlRENldkhVamFLSHNaRTZkL1lCdFgx?=
 =?utf-8?B?SStEbkdMUWN3SnZYQjczY0kxOFNYdy8xUklDbE05NUFCOERPRFBYclRidS9H?=
 =?utf-8?B?UHlwVkhDM2pGV2hYMy9QdnRobHE3RTlWU0V6V2xCMGpzWUtOTkFOclZGWXN3?=
 =?utf-8?B?Z09aVituRGQwMkdIQmdrYjZWbTFYOFJSMTBmQ2lTNDhLQVhVSlA0anNkNFo1?=
 =?utf-8?B?NW5Pd01rR1Z0c2dZYVk5ZXl3N0xBR0MrWUxBakVhbUthYkNRSWVlaHJ4MUxY?=
 =?utf-8?B?NllldkQwSTlZMWdDWjhxd3NmZzdDL1lzQWJQeUhTMUU3ZHVtV25TQjFQbEVB?=
 =?utf-8?B?RVJpNWNlSmtHdms3c254VUZZeVJJczNESXc0QU91VEt2VVFJaHhzYTd3Z2pq?=
 =?utf-8?B?YkxoTzUwYjlqVTVrWWhoSWdiOVg0NllnSEZkZkxLRDNuTGR2M1AyZlkwQmc1?=
 =?utf-8?B?TkNBbTlGN21DaUZQVW5UY1dJR1JWSjhxYkZHbFJyY2tncVUvbnZuYkhLYWVI?=
 =?utf-8?B?c3AyZS9HM3MzQm1QWGRxNkZ4aUdnSjR5QkNaVmFHaWRWUFBQaDBKMUFlVDM3?=
 =?utf-8?B?ZldXNGtUNURvZWZmYVZwU3pVMFlvdnNIY3pNTXYzcTJmTGljbzBDVjNLSHF6?=
 =?utf-8?B?cUtod1VpSmxINzBucFJkTXhTbVk3SlAwUW44SEZ3SWpSM3ZnT1o5Y0kvL2xh?=
 =?utf-8?B?cm1USmI1WTkyenlYNk92SmJwQ1RtZUIwTzYvNTFlckJ3VVhNclFZNWV4Ykl3?=
 =?utf-8?B?M1BBZ0Z6ZUh4bU1qMEFGM0JkWHM5V2p6THh2YmVabFhKSGcvcEUzVFZvbE5T?=
 =?utf-8?B?d3RUcFN5ZFBRTHQ1ck0wWjJ3bmMvSFZXL0U1bzFHSG9naEdIQWJLZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da0aed6-8134-487f-5e5a-08df38bb37d3
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB257519.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:28:05.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBjJY0jJ5qB4r/DY5Ra4JwhHmrdokZ4jGuB25OKDgCV071haFuPHjaFQfgn0RxWKRcwI2+YvlVTUTcEDiZT5WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054



On 21/10/26 7:55 pm, Niklas Cassel wrote:
> On Wed, Oct 21, 2026 at 12:46:03PM +0200, Niklas Cassel wrote:
>> On Wed, Oct 21, 2026 at 01:36:44PM +0530, Manikanta Maddireddy wrote:
>>> pci_epc_get_next_free_bar() skips the upper half of a 64-bit BAR only
>>> when it is the starting BAR. If the search subsequently passes a
>>> reserved or disabled 64-bit BAR, it can return its upper half as an
>>> independent BAR because that slot has a default programmable descriptor.
>>>
>>> For example, Tegra exposes a programmable 64-bit BAR0 and reserved
>>> 64-bit BAR2 and BAR4. A search starting at BAR1 skips BAR1 and BAR2,
>>> then incorrectly returns BAR3. The next search can similarly return
>>> BAR5, causing the EPF test driver to allocate and program BARs that
>>> belong to the reserved hardware windows.
>>
> 
>> 12a22fb38cbb ("PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as
>> 64-bit BAR_RESERVED").
>>
>>
>> I'm fine with this patch, but I think you need to rephrase the kdoc
>> to reflect this new reality, because currently the kdoc is confusing/
>> not in line with the 'new' meaning of BAR_RESERVED, which can contain
>> MSI-X table etc.
> 
> To clarify, I can see that you updated the definition in:
> 27ce1d8ecb9b ("PCI: endpoint: Allow only_64bit on BAR_RESERVED")
> 
> 
> But, IMO it is still not super clear.
> 
> Perhaps we should have mentioned explicitly that only_64bit is
> also allowed on a BAR_RESERVED, if that reserved BAR is 64-bit.
> (Since that use case is different from what the kdoc currently
> says.)
> 
> 
> I also think that this patch needs a Fixes tag with either:
> 27ce1d8ecb9b ("PCI: endpoint: Allow only_64bit on BAR_RESERVED")
> or
> 12a22fb38cbb ("PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as
> 64-bit BAR_RESERVED")
> 
> 
> Kind regards,
> Niklas

Hi,

I will send V2 with kdoc update and Fixes tag.

- Manikanta

-- 
nvpublic

