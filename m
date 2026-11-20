Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795137139;
	b=U9mHJ9InMv3WYcfwqwxs3KMHEEQSrWdbYZLhnzXW5A1K2MLF2yTUOlMIyqKj0hQ6vqYy
	 pDQwQvmb4mG0n7LvYCh7OtOEy2LPbMMFejk3LJusRs2YsWhnPdap+IoPzOkpPTDVFU+iA
	 dvI/2t48cPRdFW9um5Mg2TayAMu5N9QW4YGOP05cZVcAKEYBU140i8q838Ar4jXBMvqLl
	 g8DuifnAlQQctoNOYBmsHkz1mIEG+FdF50H2yngsjO48bev5fe5mBu6ivVUD2kQ6N3mGU
	 AnerH+M2eAB2Pe8CxdO1wh+EZ08hETsPi46wamnEJ5+5bAad4VIotAiysNInWbMJvMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137139;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=xVx3hIjIcHwRhFBJMZn8HkYUmAf+3bgBPmnSkOWAKpg=;
	b=f/9FsH1jj8hQsNeVBP3LME/p+B8I2K78zn02/LXgv5hd+0Pox7b/b5Z0Cq8aD4/gfl9H
	 cYtnCrVErb+qWBtg2422je9G9XekOaAiY1K/0D2OcdJ9RIAjErB9gU4Zqeb2vvvKfTS2L
	 dp7YCFe8druEsVHllKyDI9hYrLLcR9H7Mp7Xwed0gG5VJDuAKQ63VdGLZUiPFjPp+3Uv5
	 wApwXunEeuLJ+9mqL8fupzb4iR7WD/ySm1s4MWiIdUAtlkgUdMZo6+OcAzlwIQuLMjzUa
	 40fyMnv204cPA6/vY9bGwBh28JLhf4UOF749qJrc3+dcPallB64/kd5j3VrcwM6G5xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aKmfg2wd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.34
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5479606A331;
	Fri, 20 Nov 2026 01:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5479606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aKmfg2wd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpocCNVSa9fy1l/m5gGMm2TrBvkoZypeazcn/i937ttzi14ytKicMr6fk1xEXVFfO8O2OYk0rX0uvrVxDoyTVutwRFmsUFFym5mL2/HPaJivwqFpg3o09UCXD8YvmDsWdzsVJ0xWQwxhI9qRBti0wm8lDehk0EhDiQrDuYTkC3mOf0VHnSEsDPhTJmqlSwxS0WtCPjfBNRm+HNk4piyDZ7xzgGjwVWhkciaz9nhMAfNTfjYNS1t96ibUEXZa8AZUKlqGHGjqPUp2E4ujLmIslReDuRBCEkajijAeHvjL0otYQxt0LMiNUNly2ks/q7fkHJT1EtspNd1zjiLmfPrm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVx3hIjIcHwRhFBJMZn8HkYUmAf+3bgBPmnSkOWAKpg=;
 b=y2SWBxH7g7amSW61KSdodsSwaY+G6WnqeEF+Uf+E5M6gqbPtZij7ZvayXBufHhh/Qra15BKeiDWfBT123avhtrUgKIl3k8yFpMQLJsUKFSz2Kj/p2ekR6/kgLF+PaKfVP43I2p2fO7J9H7B1dT9EGnmyX/YbadmBZDkkiQFDxUrH8mzv8gnK7dKgJE0xc2iLBKkhKG/vWtjIRqmLwW/MjLnqrjYIGR6M4L07E1Y3UUqn5b6n+2fMAY5GfgmjLMe94pPLmBWgPPm9zbYiLNF3De2Y3lHpJQnhGalY1JgjqrTNdkz4BBuYcx3Uc4c/l69Z49nqzX3uoNTgZkWKvQFZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVx3hIjIcHwRhFBJMZn8HkYUmAf+3bgBPmnSkOWAKpg=;
 b=aKmfg2wdakjJDPFWqspiPRwe0Ak5EFdduCeMHwdOFohw9bPW5m7F0xufgbFBDsapNTruGSGRDInA/r4zXBozXi/2kHtODrNt4FUBNnhsZfFL/sM9DuudpK2Vtypv7jABzAocrl0ePgg4QOujDfVSnc17rwopZ4hkLImnwaGCegbWlzbjWLiJifmUjpTEHRNaIloIqbUBbjg9cRCZYa0Y+iAcyA8j4KRSrpkYzV1ps1qO5TIDWCm9eZsSqBBoy4uMUWnuP6tHmjIBtcVoClusfJMMxx9KVaG45RcASQljSLgYnLbEscA6lcC4sqhInvVrkj2rlLqGMuT+tdYpHZVxOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 01:12:15 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 01:12:14 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: devicetree@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>
Subject:
 Re: [PATCH 1/6] dt-bindings: PCI: tegra264: Allow the ats-supported property
Date: Fri, 20 Nov 2026 10:12:11 +0900
Message-ID: <meFC-rbZSSu9SGIB4wyt6A@nvidia.com>
In-Reply-To: <20261119201817.GA119016-robh@kernel.org>
References:
 <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
 <20261029-b4-t264-igpu-pci-v1-1-4d843dda0b02@nvidia.com>
 <20261119201817.GA119016-robh@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P301CA0117.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ2PR12MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a93f589-b61f-432f-6b50-08df46a34fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261028144727099003|261102123227099003|4143699003|11063799006|56012099006|10067099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	QHz+fJV0LFrNsDcDQtkahKk4zdgk0B79XP8KGajQQgTi8mKeNNCKl7jCTpkQYufwLpPnkUA8Tgqn6UAU+MuzQIljejx807BgJAvR6tRtVB/7xLkREmpR6cvDRdg54huZxwvEC5pszyJtonWN3amNpDxFxM2dnisSRakuqjv3cZBe+WM6UbzuXyl0SO4n4RaTi+6qn6QEcIw5ChVTfcqDdm7M9SNkc5rpDUgfRdHNvSDaWk8oUUtymPBwIWtS3rx4RBpGKINIs4Gr2jHWdWr/YxUpD0xv16AbpWjixOWAAZooTdo4O5e3ENLjrURAT8cySD34aBOvkizvpYHJR8ubx9FZHBSeRY448fhoVCGH36+LY4WtHc0UeWTE0f99uoZmzKGLf6nOVMbPFoepRoFhfSNSaS6NU6ksFlJdXvkeEyZv2vIKRJkPei3hAd39EwJYXvyy8miFXfGvP3HD6G/kqxWcSfFldyeJUFL5/FxDEofFTSFwK9gHWQe8X8ZzFSFakoW/6W7BM+T6NDzkN4581vVGRPKg9yET+CTE+V5j/zX9neFj0GqxVztkL0J0ZZg+yIjSsMOk6+82gc/hgsKbc01p8cw82T6JzBjukC2itdpk+r0PG/JC9z9ewmTE8aaMj5LalQWLZZw1wEtluBIr2gYnnNx9wDgBAml1a1LV1QU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261102123227099003)(4143699003)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlFjeVdQNm5aVy9HOUtJSUw0dHNyeG9NV21zUEMyMnI5cEx3Vk9uTTNMMEQz?=
 =?utf-8?B?Yk5ka084bWFFZWRtVXlPSDBkV01nTkRqSVE0UVNDNXNlNTFoN09PRVc1dnVP?=
 =?utf-8?B?ZjEvSnR0UmprcElCbE10QS80NHl6b084Q1daSUI2QW94MlNDa0hWcGZnS0VU?=
 =?utf-8?B?M2xjNEtVR1lEODNSQlFkbHJLeWV3VGJxTlFaYVh2ZElzTVBSOVFqWXJRSyt1?=
 =?utf-8?B?RFg3ZGJBaFdsU3I1bnJBK21sK1hsanlwMXJCSVBpUjNvbldiMXFHM3dRZnpm?=
 =?utf-8?B?cTRtZHQ4bHJnR245bkpmQ2NIOWhxS1hWSlhjdUtSejk4M0dReGNmL0d4R3JT?=
 =?utf-8?B?YlhlV2NUY3pOQy9VSmFlN0VQVnA5cVVTcFBzZlRYcmFCbU9vNkoxZUJkcldm?=
 =?utf-8?B?RUd0TmZvd3NPSExyZlNRV3haNXBtN2ROTzlOVlNBVFFQYk9Qb2R3L1dxVU5F?=
 =?utf-8?B?akRnVlVtb29SbU1DaVV3SHVJVk55T2ZiSm5ONEFFMUZqRm9BUUw5VzYvekwz?=
 =?utf-8?B?dWRpK3NpVWNGRGJGVFRLN0IzM0c3QUFnWmp5bnNqM0d2bkFBV3pmUEwxRklX?=
 =?utf-8?B?VUMyaDdCbDZvMVcvZFh1c0JJeHE3QlZsSzluRG4xQnZxSkQ4VkYxdjlUM3FT?=
 =?utf-8?B?QllNZmF2M0pzTTAzN0lqQjR6VGdxODhoZjZIbnU1TWJ1ejgzTzd0cG0zK0tZ?=
 =?utf-8?B?bThoRzhzRWN4Z2dUU0NxTmpkNFBQZW00TGJtaEtJKzNuYU9Fek5XY2VKWk94?=
 =?utf-8?B?b0h2cmMvSXY4aHJTcE9YQXZHMkg2anBGVDgvZk1SYnQ1RHdaNnl3RkR6Tno5?=
 =?utf-8?B?S2ROdmZTZmpPdmRHbFpQTFdqQm13d3NMNTZUR1JiZzRYZnlGaE01WjRwdGY1?=
 =?utf-8?B?ZXpZbVZQY09VNXo0UzhqL05pM1lTNW1FMDQ3WTY4aHdsL21ETE40eUdwU0ZT?=
 =?utf-8?B?aHBCNm56ek4yVC9NUHVVbGtqNnNNTWJPSFVBWTQ5MDAzODhoYWZFbWhlYWhN?=
 =?utf-8?B?NmgvSTdNemh1bXNsQzlyNVZocENkWUlLRUpjakNhSVNGMTl2SS95am0vTU16?=
 =?utf-8?B?dFV3bXFXL3dOSVRYRit5R0ZtMkhwWU5pa2crRnpnZ1FNUEtLQjhmZjJOQkdT?=
 =?utf-8?B?bzRwNjk2cVpHekRGa2tIS3dCd3VUUHRFc1ZSc1hiUkFTQ0wzZkIwdjg5R0Nt?=
 =?utf-8?B?alpWQlhCMzVlQkZpYUFNcjRSdit4d0dzQ2ZIRmdjVjdzTVJycnBUZ04zRFEv?=
 =?utf-8?B?VDZiOUVoTmFXT0xJQlhXanB6YXg5YXdRQlJnTURGajhCWnU2V01MRzBHRmxN?=
 =?utf-8?B?MWhjTUdENFVyY2xNZG5rYzR6YjBFMTFBcWVQRHdpeUJNTnhjOHFYU05IV1Yy?=
 =?utf-8?B?TlRaWTRGa2U0aGkrZkp3bWNpTWJTZlFOYWQ0WXV2UXdzVStlL1RXNlE4MnhH?=
 =?utf-8?B?bW1kMS9YVHlRWVVDdnMzV3ZhOFN1dzVWaGI4b1FvQUM5T2lGbVNoYmVycUkr?=
 =?utf-8?B?bkxLRzQxTTFZTUhqUUlkUUJmbzJ5N3I3dEtsYTBCY21yVmZ1b2lnRmdMOWRz?=
 =?utf-8?B?UEk1a2VuLytGcmp3TmI1ekhzNERyS2ladHU1U2RES1pMbHhEZHRycWtsT3hR?=
 =?utf-8?B?VS9lTlB5VmwyS29LVTl4NGxiSEhEVFM5SGxXVnlaV3Y5TlN4Y0xXVkJVWDdR?=
 =?utf-8?B?Rytqdjl2UU01NE83RVJpY2xDYVl2ZDF0aFREZVdyZFJWNEhrSE4ydzBYK1hj?=
 =?utf-8?B?VjlBSXNTRDVKc0NBd2J0Rmo2OHBCQzN2TWp6ZjA4aS9zZXJ6VndkL2dWNXFW?=
 =?utf-8?B?VTVFWFpUelo4UjQ2cklBWVFSd3UybDVIMzdGTkxMODRpMTFXTjY1K2lFUE9B?=
 =?utf-8?B?QTkzVkl4TXA2VWk0VU9qR2tibXU2bVkvaExnampWUEVlclNwRGlEOWZMcmtT?=
 =?utf-8?B?aFpIeC9Pd3ZiQ05ya0R4M1VFTElmbUtKcncwakRjb3pIeW54QVZUbGhmY0hu?=
 =?utf-8?B?OWdzS1BzNk9SY0VQZmF4WDd2L3plR25pTVBrSWtFVXJUcWN3Vk1yTlp6VXhN?=
 =?utf-8?B?TmRSRjJHbWtSbjF0SktYR1cyUXdlTm01ZTJ3c2VNUWR5cWR6cFlGVWV6aFBR?=
 =?utf-8?B?VXhqbzJWZCtNRGRyN29nemtoeXUwQWhUalhSVU03YXpSbFBtdEtWK2VkLzNI?=
 =?utf-8?B?T2JzNmxZTTFqZU52SFdMUWJqc3cvZXRVQ0xhdUY2c0xqQUYwaDE4Q2l2OSth?=
 =?utf-8?B?RG15RC9UMnpud1pkdHhSSFJxZWdQTEdDM1VhNEtqOXRtMHBMOVVxbXErRGhH?=
 =?utf-8?B?cXNhdHFESHorS2xQL0FOcE5DRGRnZDRGdmFJZDZISUtRTDJTR2lrbnlNOEF3?=
 =?utf-8?Q?D1xgE526pCntyyztav2thJeKHtJE0gS0/GAQVlPJDOKib?=
X-MS-Exchange-AntiSpam-MessageData-1: 8erKwj98OI6jww==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a93f589-b61f-432f-6b50-08df46a34fd8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 01:12:14.5768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYnoqgUkhTnLuK/Wf11pigiLkJt3r/+fAtQKmD6l1v8A+ry1qs3VNkrmKMtiCMoxjhr/eUMT6Wx3HwNLBo4u0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061

On Friday, November 20, 2026 5:18=E2=80=AFAM Rob Herring wrote:
> On Thu, Oct 29, 2026 at 12:32:03PM +0900, Mikko Perttunen wrote:
> > The C0 controller on Tegra264 is connected to the integrated GPU, which
> > issues ATS requests. Add the ats-supported property to allow marking
> > ATS as supported on the controller.
> >=20
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >  Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml | 5 ++=
+++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie=
.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
> > index f0114defc04e..3b4f31a4a4c2 100644
> > --- a/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
> > @@ -34,6 +34,11 @@ properties:
> > =20
> >    dma-coherent: true
> > =20
> > +  ats-supported:
> > +    description:
> > +      Indicates that the controller supports ATS.
> > +    type: boolean
>=20
> 2 users of this now. This needs to be moved into pci-host-bridge.yaml.

I have opened a pull request:

	https://github.com/devicetree-org/dt-schema/pull/215

Any other changes required on the kernel side?

If we need to wait for a dt-schema release cycle before the definition=20
is considered available, can we merge this patch for now and revert=20
later along with the definition in host-generic-pci? In any case, I can=20
send a patch to remove the host-generic-pci definition later.

Thanks
Mikko

>=20
> > +
> >    nvidia,bpmp:
> >      $ref: /schemas/types.yaml#/definitions/phandle-array
> >      description: |
> >=20
> > --=20
> > 2.55.0
> >=20
>=20




