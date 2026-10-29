Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793244917;
	b=tA5fM/BA5FpZ2GtHjiuczG1BfNHvRl0aQd9bYuMiRSfJLrqV4Ui1soHapvYNst2uJOq1
	 3BYNQtqyJcF56JftB2bspY4CzwT47k8U1HW3XwkfoMRTSk+qEUPkbh+jMu8MXz5r2Zkrk
	 LtHf5+VTNlXHuaCni/JzYV7Zudd/3MrbQ1pa3tvzGkeDQbyo6xlgfqdzG1P8rfRbBq2ws
	 wuysMkilyEyik6KEj2kvd1PudPvUSL5Ko56nQpYhlBCPRELKUodPPW3gZsJIEnBvRtiGx
	 z8HGsP+qgVSm6OGY3wywKvVADBjdMciQ5wkSi2RI+L98Tpu3RZOPhAOF+AGtG5lGU4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793244917;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=kaeNGMR9ZLRaZqGXsoClbZCpVALD7CXmwwdiXOgPras=;
	b=RrnJL/OuLZHXA8A1DZq1eW5veIAXo+1aVtVFtzeO1yrYV8xuMHR2YmL8f3l4ZSMDCJZu
	 somMP57wd0EfC/a+q4wnHB5FgHC1lLcGuu3b5SdmV0veeldvWrc9DkuTr71ceaUv+Cb8c
	 tk7OZ/Jq3z13YZ5pYEM7kWORDOL4gi1YxERXq7TDKL+arlNjVMYEbN/a3J/gtMbAyr//e
	 8kpJSMtwRKwK0NY0nR54Ppm376b3pNrhHwgYC4yB7uAdt9OXu4P+yzShG6/W/3evZycaB
	 o7CLojcZtRAAHo1eP+klyvOhkjDUsRZ9vYVOU0wUwKHu38K0KCNWIrok/XGdR+DJ4Ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lzaNLgZD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.39
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44818606A31D;
	Thu, 29 Oct 2026 03:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44818606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lzaNLgZD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDvfNzdixTO6kL/H21uT3lG9Yd1gBcuqE+/aLbEFI1pV6wdJDLuv9ndv+L6aDmOZHIaP5Pzob428sYXlS3EbZ7wQihNNcMohlaMclad9is9QkM7o4IunWMvrF8JP9QcBpSB7KBQqTqo4GB+ZpyO49+8jO3l7CIUZtViIB7QcLBocTK+NTyteo3F7u6eCXNI2voq/1TecTkhyjKEcKkfvMZddAS1ZFwM5/vT6StW/N8qXwOYUKV6EBOFoldBNMx2OXjup1HrgtqcgXKqBwA1vcyI+zLl6ZSra8zeKq2CMS/hyult6dH254bLypCY37aNjic+nOE2t5sslNyla33ilcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaeNGMR9ZLRaZqGXsoClbZCpVALD7CXmwwdiXOgPras=;
 b=ErdnYB8PzuXXk04UZ4cTC74glmmZ+vxThBaa9d3foh2gCIKcoLIl3Sm+mkZGY+zn5LvS9abeQLslbMXgoXopOVYDIpClc7xLz12SiPZsVUixKaIfZGL9UuxjczsPuYwBNw25ChSufiJtPX+MZEnA8B4tIxLRHpwBRqrOw8Gs9pXR01Rkp7myQJLR3g0N+k13hOTBqOkUjKpvDhskzvlcsndNBADwyu1ip4z4g7rCUheaRRZn/W7ZWZYrnV69dGR2OVhJAwaxHXyKIN0ncDBW4+GN2oHkmpPlwn6EEKxGG2VHKAPBF38U/iwwkeRuGWhozkkuAqWBBwfMnrkTbzVJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaeNGMR9ZLRaZqGXsoClbZCpVALD7CXmwwdiXOgPras=;
 b=lzaNLgZDRRfWyOke6639yiYz+ze+ertJmnQuC0UKvx+6jV+vnXnXhzQhPTuZdjYhJZxIEwdLw7gK7eXcAwcxQxrnxRpx8uNdKni64NUT02+CV5puiisuDuZcu8AgQlmSezs2LM0ryJp8m/vjtC2FiNEX5K/3YAuIJffft7oaZuuQx9HmiaukfOk9kajNGGygVcovf+X1+UdzbIkcWfCcggCww73qNqtE1Q0sMAzBGlLyBWGPRyu14H3HGxsV8MFZJElvl2hqXm1GHVSrf0+IiqWuaDizE69JUGGUIJWVe3nQ9ljLjIFkFzmuKHljvJR4Z7LPZ3YDrXc7pBSkFlm9fg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 by DSVPR12MB922022.namprd12.prod.outlook.com (2603:10b6:8:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 03:35:13 +0000
Received: from LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350]) by LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 03:35:13 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 29 Oct 2026 12:32:08 +0900
Subject: [PATCH 6/6] arm64: tegra: Enable and mark the Tegra264 GPU PCIe
 controller as ATS supported
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-b4-t264-igpu-pci-v1-6-4d843dda0b02@nvidia.com>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0044.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::8) To LV3PR12MB9166.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 495355b6-8355-440b-31fa-08df356da47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10070799003|921020|11063799006|56012099006|261009223027099003|261021121427099003|261021123027099003|10067099003|22082099003|18002099003|10063799003;
X-Microsoft-Antispam-Message-Info:
	cQQfzRhFU0+zaf39U6T1ukHVVVdqRDHr/9QnHlLiRKZw37XNVTqEHcI4zjQRalNqrPpD+g8B/ZHSzGtWXqd23jjLZ+QTkZK4B3wF+TbDXQnhJNPXGWhFsMI2rlNJSPHyFyTlS8pWupQ6PiZ8kvcEgaG1YHHnDeikEnLdBQF5L8MEU7giOBcPkmqx0BHjVCqwUJ93AwSiKygDm+gJ8rT9AZvEuAexigpbdF8beki/xXx4XIBt6t4OZfdruPCgC+bqOKIJosrZ8tJuoF/EpZucqP698T2eSRVs0/rKD2+F6Rc0J8E6SO+KISw+Orpm7OxTwSUIenvBzAPKt6G1H8LfxgDbwD0lxxa2KLEC25mODQh3adWKpbE/NroUDEzL8lHfdiab1ZGTG1lClb2xj/DEPVpEbNVULmDspNgQl/9X1v9kggx+F4eXA/4CCISHjMYWS3XUjDoCfTyPUA7aLaO8kipiX/IZO/ZpbEoLv1wwIAdXa32bZP0chOksPYrf8yWrb2o3LDlXl3LKknFpPjgyoCc+QAZVf1DhjeZGH7MGIqK35iSD1OdMbHDTLs23WFHVdwfTEUFqNqKaWgNP55TCRObaizfW8+Q22VeMB2VUJYxm7VLTcy03osClZdMG2gjzfruuQ3j0fpKWaIJy19DnUtA7UIugvLlYuaWBdJXGefPKHC1PvGwB0goIGQk7NIv7CSkm5R338TevBFmJtqQ3rA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9166.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10070799003)(921020)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(10063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEs4VG12RkwzYkJzRitIaHJzUVBmMmhGYWcxUzBBZnpuclhjWGhyN3d4QkRt?=
 =?utf-8?B?dzk0OVBCY25LelliNXNGK3pEellhTm5ySU0rZVp5bW0yN1VxRWYyZ0hpcFVJ?=
 =?utf-8?B?bnFTSHBZbUVST0ppSFpCYWtpL1daKy9zT0dxeGV5NUZIOTJjbVBYMHB1a0sx?=
 =?utf-8?B?bTJQT2lqMFlpaXFhd2ZwUEFiYlBQL0htSGY5cW9iVk9LbDQ1b2xYTllEVUdM?=
 =?utf-8?B?Q0NlQTFPcXZNWUdkZmIvZlJ5WTBXd0pCK1VUZEZuVDRDcmY0UDZvbHptaE5j?=
 =?utf-8?B?bSsyQkt5RWVRZ2xSYUU5c1FLcDVLK1hVSy94YjVuVzU5WFd3TmliUUNJVEQz?=
 =?utf-8?B?ZkNDcEt6alFSbHA0dDZpNjlJL3hFeXB3TktlTVBadnh3ZTM3MnkyUnRrc1ZM?=
 =?utf-8?B?YUVCUkFldW81a1JYRDl6QTNySTQ4RVRFbzBsWGdJSDJUMjdqalpFaFNxcllQ?=
 =?utf-8?B?RHAxbzg3MTNWSnhzTHlNemhZK2FrcVFyNy8rZXFDWVlCNzBFUFlEY1BSemJj?=
 =?utf-8?B?THAreUVLY1laYWh2ZmdxMFdHRFphZXIzRXJSakFjaW8wQTlUU2hid1NQNE1U?=
 =?utf-8?B?eWIvYmRCR3ArQ2FVRUlFMUJJam9KbkNIaFVUQWpOeGtKQjJhQUx5UXV6cE5V?=
 =?utf-8?B?TzNvVU5sZkFnc3dGK2lGU204Zmp3M0UxcXZVOU9oWEtYQXR3UWhvNWVxTlkr?=
 =?utf-8?B?VWhHS08vMi9XcXpqeUZiVzgrYVdsTlVLVkw3YVhDdUQyOXhNNlpDMHVrNEpa?=
 =?utf-8?B?U3o2bzVBd1B6REQwa1czMUFUQjREV0dMbTArLzNkTmZ4WnYvdWdTWDZqbEtl?=
 =?utf-8?B?cnAraTQ5WHVTNUVUNjdNY2FVMHBPVmozUVh4Q1Exa1U0SWdadVZVZWJIL0N5?=
 =?utf-8?B?NmVkY0NNZmE0cDRad29LaS9YRHBiUGtoakVuTmlpd2pSRlh6RldsaThST1pY?=
 =?utf-8?B?b0dxcmxZaFgxOWZmTGR3YnV0eFNNNUNDb1QrSGZINkQxZ0VpUTNRUFR2ME0y?=
 =?utf-8?B?QlZrTDJ2alk3Z2drZ2NUMUNCMTJOZm9tdkhUeTExbStudEZEdGZ6T1YwNlZT?=
 =?utf-8?B?NkdtNVloZjRkUkFYZDdTREkzVmdJcHo4NzlmTTk2OEQzb3BYRlFiVUxhSmxF?=
 =?utf-8?B?cDRrOTZQbWdBR2pXdVJkbkYxM3BMTTgva0RFUDNDSmJmK3dOa21WdEt3TmJa?=
 =?utf-8?B?c0JlQ3V3bGZiSzRIeXI4bDNSdk42K2tPTVFxU0RSK1lNK1NpbTRidUdaK2Zi?=
 =?utf-8?B?ZWgzUVFhT3ZXUXZQai81K0RzZjM5MUNwSnJyc0NMNndvL3F3QjlPQ1RtN2J1?=
 =?utf-8?B?bnZNMmd5bXZKUTdGTUlOK3pZMlRVbGlWWUtBVXZTTHJTcVZ5V0hhbWRFTmJw?=
 =?utf-8?B?Tmlkd2huZ1hUSVQ3NW8vazhHd2FDUHMxQWVOL3JwNnU5cG5lMEhmYnRuM0xt?=
 =?utf-8?B?dzVWbHBGMFE1UC85WUVDcmNVQTZuSEpWL0NYdWlpRmlBVStsc2xUN0VKcU1j?=
 =?utf-8?B?b3ptczhPL04wVWNFME5RNGtlR3R3VnpsKzBoVFJCSkQ3dnFPRmNNZ1YyWk1a?=
 =?utf-8?B?ZW5BTmdTYXpaYTEwZU9hZlV0dzhKOTBBWkdQbExJZ296MmVQd1VEYUphczZN?=
 =?utf-8?B?L0dUQUZYUThEbERZSkZCSkxUeFo1YmVmaWZCVHVRUDk5SVJnQUdCQXBlVldx?=
 =?utf-8?B?VjA1dGhtRzY0QnB2L291MEYxcnFJSXVwSloyb3J4L3lZMVlmQllDSWpvLzM0?=
 =?utf-8?B?bE9pR1VISUpESmRGSXZYb3prd3owZTFVZ0p5YzhiUk9mS1IzNGM4WlVwMmk2?=
 =?utf-8?B?VDdxeWxZZnFYcUxCQnRqSGl5K1ZJUC8vZ3pVb2x5V3MxV0l5WVErcGEwVnl0?=
 =?utf-8?B?Q3hLa3pOd3NRMnpiQitiYTlmN2tqZGVDOHQxUG9nZ1NOZW83bndIbjFWVHNi?=
 =?utf-8?B?c3praXBBYlkrTHJKd0d4QU9lVTFIVDAvOHc5UTZWNk13dEdObmZna3VyR1hJ?=
 =?utf-8?B?b0Z3WE43ekkzNGRaVUJXcnkrcDR5NGlsMU5kZm5GRThIV2t2SEVVWWc1NCsz?=
 =?utf-8?B?c2c5dHdJaWJWVTBPcjFBdEU0MHpmY2VJdkFEZ0kzamFmVjBTOW5Hbm43Wlpa?=
 =?utf-8?B?WnVoNFhtTFRGK3lZR2NKdlFYK0ZhZnlWTU1JTjBKZlVia1RBQWlMT0N5enlW?=
 =?utf-8?B?N1o5cDhJQUUrRXZKK3VHb20ybGkxaU5aOHRIQkVBdUU1UUo3S2VLYTdtUDg5?=
 =?utf-8?B?SndGUGl5NTlmRWloOCtuM3UxdVBWb09GTi9NMURDTmlkTUMwRmRqZk1nU0hU?=
 =?utf-8?B?NWxRSzZQUDZjL3lTSWtoWWR5c3BNUThsTjNzU0J3UFQ2L3pGYkU3WXRNRW1L?=
 =?utf-8?Q?kHAN00DE7mSoD9y5YfG54gOgy4RM5egNyZ2RQUXYivKfZ?=
X-MS-Exchange-AntiSpam-MessageData-1: iAFfHL5ilO1ucw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495355b6-8355-440b-31fa-08df356da47a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9166.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 03:35:13.7944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8bVjZjhjCmeuaNmRHBHLiwmMPSltY1Q6Rs4DHKk0rSDaCaFaSXHakkbud0gpe5ZSInWhi7Dnyez4fFKsquofg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB922022

PCIe C0 connects to the integrated GPU and is internal to the SoC.
Therefore enable it directly in the SoC device tree file.

At the same time, mark it as ats-supported -- the GPU issues ATS
requests and this is required to enable their handling.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 4c8b320ecc40..9f39b5c52a01 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3580,6 +3580,7 @@ pci@c000000 {
 			iommu-map = <0x0 &smmu2 0x10000 0x10000>;
 			msi-map = <0x0 &its 0x210000 0x10000>;
 			dma-coherent;
+			ats-supported;
 
 			ranges = <0x81000000 0x00 0x84000000 0xd0 0x84000000 0x00 0x00200000>, /* I/O */
 				 <0x82000000 0x00 0x20000000 0x00 0x20000000 0x00 0x08000000>, /* non-prefetchable memory (128 MiB) */
@@ -3587,7 +3588,6 @@ pci@c000000 {
 			bus-range = <0x0 0xff>;
 
 			nvidia,bpmp = <&bpmp 0>;
-			status = "disabled";
 
 			pcie@0 {
 				device_type = "pci";

-- 
2.55.0

