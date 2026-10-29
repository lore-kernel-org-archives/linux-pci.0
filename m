Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793244913;
	b=PDT7ENPjmT+67KUvM976jQFTqSTwgU5hHKExyg7gyBii6NHVZCoJTuLi+qFog9G7DkS3
	 1dkJpsHtJqXmcNB5FgOZGSGnm/RXNSuEbNcFkZ/dEWRBUG+OzdhU4vwVfehGF/lvdmV2D
	 6zclDu/QRj2dkUhnlQ/7yUtgzoJEK0PopT04ZfInbNi18/jFhcHEEFIYhwxPvDFfaatQq
	 ByL0sy8ClNYFAIy4TaMGmmNLeB9ufFV3Tc8TViI+NP62ytlUUXM/ngsHX2nCejevWHmDL
	 u2fxM8n7TcwFipR8RjRPttbMAbf7JzMVZ2c/QtKr8tuYp6sDsXPjNJ5lzj6edkNm9cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793244913;
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
	bh=oc3EH21SwfuMhZ6X5Yp0lAcubL2bPdI9oIEnsYeV8/A=;
	b=4fo/I4g8WViJ/CTyenlNfepCS9x8wFc34qwRhmTVkrK+pJk8J3cz8zDWj7wzkFVt+Gdd
	 2vXTSp7+TDTdD9wg4/FKgQSvvARM/Oeezlrx/JAxApwZisV14QxqGQeUAemt5GcjRvkWO
	 Lhvhtj40u8YI5+B/ehBC4PV57Z+XeDr+pCj6ZmzwaiLIDCxliaDhSRGjQ0R0zrXgNWemQ
	 yIItD4snlAytq8AVZxfd/E3xv9ZrFQB+lx61IQva6+NMBULH/bdvMJyl7Ih5w3eSmgzY+
	 WfFCfc1usolpx5/lN0hjjKcTy0yWB8JL88LHmtWOf5pJMO+L0TPG02whGlFRQf6ii5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OXl9lQtR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.68
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A6D606A322;
	Thu, 29 Oct 2026 03:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21A6D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OXl9lQtR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkQMsCwJO3SyUO6NgC7u+cpE30boXbfsCWwJLEBzKNAamQOnHETxiUKIKpKuRTg3UMjf1Fgct5uc+i7KxkZim2ra7tIwB5mx8GBT+CoPfPH1JvDY1dez7EE+lyUcDJJ6pYahH8AFwHsHdHiMHdeH60G70yM+cf68LFG3+rSIzUHPxEH4G7KiedlAtKS8tqVD+rqnazbbce4OOQ9BxQDKbYZrKNYXOoQDTfwEapM+v2Ktjz7ZBFcCnFAxf3lCiURF7FmrAB4V4c1AdpKGF09MXB2sYwxMjg8976ihsrLy2A3EkA98O+tfAi+SI0YTJMC8AhKitW1ai4CuauuCiog6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oc3EH21SwfuMhZ6X5Yp0lAcubL2bPdI9oIEnsYeV8/A=;
 b=VPZVPIfetVZFT6vy68omJLsjFWws1pF+cIaerqtrykoCf2ldJm3hyWc2xyj5dN4wsnOAG2xC/a0XgMYw0lt03Gx6GqztxJdTj99oFHLkiKWrF3k02uUkkceh8OpSaCiHiyEFP8Vc5UcTFQRDypV4TMnh8kZLq3X1hjpA5KISx+Pn0sZNWS0jZnHZudYtDg3hxYDU7+MLW9VgZxSM/mZHI9g8nnLjjNNhWAOwyfAfxfNu9AxfcsmumHTBnNI0YBXgelYsVPAvb9/ZpNPWZiNPvlu+rbJRb10X2Tc0kNCKSQYSeIewtmEe+v/kwnxhQcMpZt0bOeFEf0z/bOxgCLz5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc3EH21SwfuMhZ6X5Yp0lAcubL2bPdI9oIEnsYeV8/A=;
 b=OXl9lQtR0jT9IuLKhoKid002hxIAbRh0wfaQDhhL8clqEsig0ThuQvmajnFFcX6iM+gcSA32OYv24QOIaBUI5DN1cJMDDS3/BBHoA2K9lHm+jeU6d4SGBpaUg0OkZVAoM5ws79upaRsstbf3+G/PHeEQOZlo630DuAww+kW4S3RNRIBCncpj3Tbwaqt9o9ZeSEV9Avxy/b3PCARfR1gOSVzKBss0z7NpcXCpH4SCFAL1ZYZSAWjiXerPiFxcnoFxXy+qYGXC8hiArz6/FMzu885UDXd6dN8iyGcDyRDOJv36qUMAsv9mgXEQpNDDRGHcCNnCBtM9TE4xRtxyTnv7Ig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 by DSVPR12MB922022.namprd12.prod.outlook.com (2603:10b6:8:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 03:35:09 +0000
Received: from LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350]) by LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 03:35:09 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 29 Oct 2026 12:32:07 +0900
Subject: [PATCH 5/6] arm64: tegra: Add node for the GB10B GPU on Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-b4-t264-igpu-pci-v1-5-4d843dda0b02@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0294.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::6) To LV3PR12MB9166.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: b55f4449-0582-454c-bf14-08df356da20f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10070799003|921020|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021121427099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	vm+YM22+nc22SiuI8wOnbPm+oy5fmQqCSe1DDNmaURcjbMqqCthA5Sr4inT1QBnd/EDIjZmGtG8gXpNmn1k5hCWyjOwjtTB/0X62lDfnlwrpXAFq1xjAJjFCCtHHppgBtX2BiEI+tFewFevy0F/8bsz2YMkFCsrtFBis1cLwZW3ZZ6iuKaZx3+cJC5tatKt63iumeEn5RKcWVIXzAYAtl+pHso26uO8JWTTtNpN8mhhHvrh2uYrOTMOE8DSGUcGjCmZI6d1rwqdrZ373q+eu4V/tux9bjZbzVN9DtNftqQowTpuv+ISvu/yjeOhFimRGue8h4DEgwTe0fniyRjtx5be5+Mhg+TiPMlr5IeT1ZuAM42LNK29F4HClbyfhkat7GIkyXkk9WRUsLullxHzFN837RhjRZYOLROw7w+X+QlmJ5w+ZU5OEAkah0Qi7tDiOnCmp6cacONR6oU1Dlaf5Y8cf/YO5ePAGLy6orFVgdFV2QP1Ft8Ux/N0n01qC3PDK3UDxrd0+mFUEKQqENftVqnX1VTARYbIW2YlqYgeGG8jA4B4XyyD4U9IPumL1/eqlf7tCFyXcEdXHmG6YpcxgUusNj+e7EwgYezKM8iLAa12/7OfC35bWtIIKORfdWInm3rcwM7vTQEwYnlgkQBWOuTKMxakrNqugpDySfiUjcLFcmeV+rs/uG77q+j4D44IpWoG2XClXgEfK3qKxlcH7yg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9166.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10070799003)(921020)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Si9mT1Y5NG5TeHhVUG8wQ1FBb1YxUDdyOS92K0ZTMS9LS0hkQ28wbHdGN0oy?=
 =?utf-8?B?T3hWQWhSWlR1dVQ2eVlwVXRCZmZVSjdCSlZmU2xacm9SRG5TZWRaNFN2RmRW?=
 =?utf-8?B?cElLZ2Z4b001eUxvREtyQm5FKzJPR3owcDFBRW4veklvc0xSVmtFUnN3K3FY?=
 =?utf-8?B?NHZNWHFHN0VUalNTdzExaHFXellnVW4vY1NkbHJ4S24yd2tMMDNDb3A0UGla?=
 =?utf-8?B?OGdMZ1VSeWw5N2lScGIyTUdVRmFibHNWLzZBK3EwTGZRLy9WdHlxUnp6VkYv?=
 =?utf-8?B?Qjl2bnMvVFYweHpac2hBU1h5dzhTT1hGMk5WaFdJUEc3S1gvUDVOekE4eVBz?=
 =?utf-8?B?bzB3cTQrdTBTMjYrYnlhUm5qQUxMVzBkYWM1b3VOaFduL0wxdVpkVWJiTGdl?=
 =?utf-8?B?cGlKQUU5SzVEbUYyOVhBOEwyamVueGwyMmxBcDZvd0ExZlkyanB0S2pJU1Bx?=
 =?utf-8?B?NnA3NVNxZEp2TXV5dVZYZzZJc1dKQ1RVTDdncXo1RVN3WitDLzVYL3VZYVFo?=
 =?utf-8?B?RFZ1ZWpuUzFvUitpWWdWNkxJaW5WSnp1SGNvcnFWMms3TFM1eXZyd2o2MFc1?=
 =?utf-8?B?UlpkQjZOcHZXWnNYK0Zpb3hKZWlERmZJNm1RQkhqMWxYQzVnYVNUWTJtNTRQ?=
 =?utf-8?B?Q3pEaTdsb0w2UG9LUG5BVzFMdHo2cjlBQUhFTzdKcS9mek92cGFZMVBnS3NW?=
 =?utf-8?B?d2NLdzd4R2NGUjJsYkxWdUNTbkNla00zbVBCVFBadzJ1UHpDVHVLK3AxK05G?=
 =?utf-8?B?MXJSQWthZko3SEdubno4TFhYZmpZbUd0VjVTU1FTZWhHSnFIWmdwWUlCY2F5?=
 =?utf-8?B?TGdTeUxxZWJ6UzdDSytsb01vK0FjYnlvSWRCSkpGUERQOGpUdGNPaUlaeStF?=
 =?utf-8?B?ZWJ4YTBQWWE1NHR3WkFtN2RlYm8zZjNWb2xpOG45UW9mQzFUM1RLYnRGUmQz?=
 =?utf-8?B?Y0Y2d05Dcmo0WldwcWpnY2d1UmcwSjNwNHdZM3Nxakoyb1FqY1BzS0hyUlVs?=
 =?utf-8?B?UVM5RkI0M0wxWGZrMmV0OU4rb2JuOFM5OEh4T2I3UTNrZ3FETmVKSG56NS9C?=
 =?utf-8?B?TTRRT0paTmhHdzluNFUwNzRhZnFYVnVkRElFaUl4aitvYXdhMDdyak04clZU?=
 =?utf-8?B?aXJ2U0FFd2tjc2NGd0p1WUJtRWNONWtob1AxQ3FwY3ZZYnpITDJwaEFvSitY?=
 =?utf-8?B?R1dPbHdQVTRrVFVwdGp2RGw3WWV6d0xwMWdjdmxqWkNTVU9iQVBma21wVEN1?=
 =?utf-8?B?WTQ5VGRLaDNhbmVSNzkva3lmVHpXWjFRVENvU3pFL2pQNFpVSEJoZVB6TUVo?=
 =?utf-8?B?SG43bXdxMmMwM1hadm9heW1QUU5uVWdPdTdSTzdHdGNrcHhsT0Z1UlFUZEdW?=
 =?utf-8?B?VWRrWTBoOTQvVm1mSE14NXh0NlV0SmswaDlnTFVPa3dtUHkvWjZjelorckhK?=
 =?utf-8?B?eVE0Q3pvcEt6K3R4bFZYZHVzNTUwY1ZGV2g4aWk0MmVWRlF5emRUM2JaRlpS?=
 =?utf-8?B?QzlCOTlXZzhLYks0RHhQSlUvSXhaQ3NucTJYc1QwWmVOVlk0UGQ3UEZXWnk3?=
 =?utf-8?B?ZGFXSCtlS2p1SVpPdDlBMlEyMDVhWTlRVTJmYUdXUlBaVEMrTlVCWlJJUTlD?=
 =?utf-8?B?T0dxWlRjeVQ2d3JKdjFLbDJlYmVURFFjVkZtM2ZSTmR2a0FYVTZ6K1BWbHM1?=
 =?utf-8?B?U0pvL3d1ckF2aDl1ODhwTUJ4UWxLSmdHNExHSEJ3WnZRa3NWUGgvNDFMNnp1?=
 =?utf-8?B?aFp6QmdMS3RjbVYrODM3akJSbmFMODBSZWllRnFrSGlJQ0JaQzBCelI5WCtI?=
 =?utf-8?B?L2J5UUdMNlZpaHdTd0h5WGlsMEwrZjFJd3owUGNrRVh0bUZJYUJtd1hScjBX?=
 =?utf-8?B?Q0RHYlpjQ3pnQkdBalZXNjBqQlhMdDdqeG9RZ0swSW5qWHp3UGU5NlJQdUZh?=
 =?utf-8?B?VEJDVHRRRDNnaDBQU1A2c0xHQXBTYXh0ZitxWUZIVytMVFpmN2dtaXNEb2ZM?=
 =?utf-8?B?ZStBYk95OU5ZbGhSR0hrbThKanBsM05SMkI0bDBBMVgrR2plM3M1TjFaL0ZK?=
 =?utf-8?B?NFhMaUsvcDFqeE1SQ2NCajZPUGNuSzdMN3hHU1huamd6Zy95RUk2Nlp4L2t0?=
 =?utf-8?B?NzE0VGFBd2NCclhuUTF2SnpqOVZ4eDJLK0dnbTd6cWlEdDVwNktDcXp5dVNo?=
 =?utf-8?B?cXhERnBQUjA4Y0N2MnZUeXo2cjVKTW1GQWlhb3phSURxMkE3M0g5SjhNdktB?=
 =?utf-8?B?NkRIMFRpZUUxODd5NnQvZ1J3ajFHTmpJZXJZZ2dDQjZXMnQ2bDhIY3J3YzU5?=
 =?utf-8?B?dzJLTFg4ci9MdkZqdWtVWkhRaGplaVhldFBtb0hJN3lHVkVSdUpmV0I2RExk?=
 =?utf-8?Q?Q5uT3/5BCaPUFIhJDnVnSRne8ZWm54XEjizeny8UNPITl?=
X-MS-Exchange-AntiSpam-MessageData-1: 3Q2pSJWaSx3OyA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55f4449-0582-454c-bf14-08df356da20f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9166.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 03:35:09.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdIiW+NDuZIy1neZwyfQFC0s60ZWMtJ7U0uHx+hVA8N0kat6cLIASFpFiV/wU1MCK5Kc8KqmwKE6IDmeeH77Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB922022

While the integrated GB10B GPU on Tegra264 is on the PCI bus, it
requires a BPMP power domain to be enabled or it won't enumerate on the
bus. Therefore, describe it and the power domain in the device tree to
allow the power domain to be enabled prior to enumeration.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 5ab34cd09a3d..4c8b320ecc40 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3597,6 +3597,12 @@ pcie@0 {
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
+
+				gpu@0 {
+					compatible = "pci10de,2b00";
+					reg = <0x00010000 0x0 0x0 0x0 0x0>;
+					power-domains = <&bpmp TEGRA264_POWER_DOMAIN_GPU>;
+				};
 			};
 		};
 

-- 
2.55.0

