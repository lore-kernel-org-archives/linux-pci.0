Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022120.outbound.protection.outlook.com [52.101.101.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140E122259F;
	Wed, 21 Jan 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007263; cv=fail; b=ny+K9JMczeDDQ1LC7xMWzrMQAnQEC1DfkQVHNWNdMxBAcO1PHfe36baBFpVrKK/azSlVucpzWZQe1DHql/siOGTXsr+GvTlgEGh5f4HvQcKmuue6rzb3TwjPG2fMTSCz8k8Po7/s6N6bOm90CoXR6oBNmvNVaeCP+Lc02ZAhj9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007263; c=relaxed/simple;
	bh=Hw6tiTfMcrDRqx39VyTWd8o5JZKekB+C1roq7HxMT0w=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=V5on+qWhU0Gdl3UZ4Kj0HqgsYbbFMEnTM4eA0xdRz5h37Kd7MzKrYTl4csqYbArO66r60TmQHumOfckik4cOLWtBIc9ULeRpoLqg+Li+cwdRszYxdB5oNJgTsOcaKr3B3u3l1leVw/utLSgEmfX2iWRKy4xPIVB2H0lU+Yni7FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=yr6pCiFK; arc=fail smtp.client-ip=52.101.101.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="yr6pCiFK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQCwHAqMTF4rer7NYevaKOfqiv/9HV2UxgmbZWlsjZpntqV1h507BCpANP7LAzj+fcer3w9Yw4axM1MNBOEQHPzsMa0lG4+bw1/LnmoJctqOD4loLmLpFI04qXdw9RsPo1o1DJ7DlQV6P1w9kNdMQ9G7JsLDL+gevjnRGeQeCKmTduciEHfPUVX4IddcxbT/roVz/o7ooaXOmSrtaeGJEL6AudjcyLMWBZC9r5emPs04JV0pIyYf1ygCVJxvEWwNAo4MsMoMlmsPPQy7PI+YpeBG3BNhdRLPo1M+hcLXWnxV77Q4wZ8njVadQ0qEcHOWBf9NgeM995dlSxQxKIwvPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSF5tOBxjHNU1n5H6pUFUVIPM3hDEdCZDEIgepd/Ex4=;
 b=HTd9rhMO8yaXq09uqLWCZQ9ujXkLUY/g/2XigAH2kgYY5n6BnzmmX7hQKnUDDmzrOIKTytJvgN7kaCReyxOr9O00WRMFFHpitVOkEHisJg1/vOt2ENI+yrRC9iet4flhrEYkmbxOWVS6OrrccVAiqri9q3ZtV15x0SSyP6svfbcyw/KZyrSMgXoB40aNf9Hsjfr0LAq+JEH2WySRdLyLR3BW5cliQ04FQ8j+WhagtH79DjGwtUlLWqWH1FneH87HvMCG2m+D2+7F9l7roHejW5ttnl0sYzYonr9aNDlq0e1SDE05zK8ppegfR01Ez5a4jnklEVWQoomLJjKlAiSnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSF5tOBxjHNU1n5H6pUFUVIPM3hDEdCZDEIgepd/Ex4=;
 b=yr6pCiFKqbxUJvhSAm55iTcvCnuNwsZ8MrQEDgLhCJv8epGCkRcNNFTBFU6k54E9xP2l4FpUBvSHvZj3l8km01tVGXP3Q6ainWEzS5r0mSfanagmCJSdaBKYMINqTx9U6iBSOeU+kikC/FmHh2VCRk0FjRbCkwF9V05/o3zaMT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5912.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:54:17 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 14:54:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 14:54:16 +0000
Message-Id: <DFUCQIIRNEZ5.178Y62YSLB9RC@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v11 1/5] rust: devres: style for imports
X-Mailer: aerc 0.21.0
References: <20260121142355.4761-1-zhiw@nvidia.com>
 <20260121142355.4761-2-zhiw@nvidia.com>
In-Reply-To: <20260121142355.4761-2-zhiw@nvidia.com>
X-ClientProxiedBy: LO4P302CA0019.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: c106d210-91cb-41d9-8c44-08de58fcf35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SU5rZFpPcVJZclNRTEt1ai9WVG5MTG4xTGJRd3hLc20rMm1SbkY3cmxOWkdG?=
 =?utf-8?B?Zy9IOHZpdWhBcWoxUmpnMkp4OGhDZmpvMmFLNmgyNkZ3Ny93N21yZk8xb0Jy?=
 =?utf-8?B?R0FtdzUzV21LMm8wamUvUTl2NWxBYnNvRmNDdTM5WXJGN3pxV01qT0M0Qk1U?=
 =?utf-8?B?c1FIWVd5OXdFK2JnRHZlSHBvTlRWMUxuV0xtamtDaXFwTmpnb0VkRkQ3NEky?=
 =?utf-8?B?bHd2cDRPWWlJRlprN1Y4UEdLc3BuM08zcWNkT0Y1VmFjVlAxOEMwTVVVZnk1?=
 =?utf-8?B?bUJ6WEQ3R0ZsSktZbnE3V3VrYjlrTmNqUFpRd0kxU1pnS3Q2dlFrdEZvdjAz?=
 =?utf-8?B?TnBBaDRyMEkzSGhLWC9ma1VreW53WENwK0RhSUtQWGE5eW5nVStqR2tmamF3?=
 =?utf-8?B?ZHI3OFY0MjY3VnBJUHRTUDJXOVUrdzN6OFJrSWFyNkFWeGRqeElTVmorQ3ZQ?=
 =?utf-8?B?cFBneXEyUy9aRFJ0QWl2QUMxU3dMVTM2VENZV0xGUk92S01ma3pzTzZ2UE5n?=
 =?utf-8?B?eWdGeVdtbkRLZEw3bHVIMkJVOWtWcCtidWdNY1g5ajYyaFZBeFFWM1A5R3pK?=
 =?utf-8?B?MXNKdVNXalFJeXhpaDhrQzZhQnFzMFBWK3hSSnZieUREYzU0emlESUp6MVg2?=
 =?utf-8?B?dCtFNzd0d0MvdDhmWUlCNy9NOGFTRWpzTjhkeUlUN0NTWHNsSk9Wc1Jvc21S?=
 =?utf-8?B?TDBxbkQ2SU5ONTZTT3VsZDVEcjN6YXFJUVcwT0dDSGNMWDNWSXU1SWlUQW1r?=
 =?utf-8?B?VUs4b1l0NHhVNnV0NUxRYm53TFBpbi9sRlNlSm5YWG9wdDd2VHNUUXIzcGli?=
 =?utf-8?B?WFRmOWVVRzJoZ2hSMWY4UEFyTEFxdUNROVUwbUtOMElnUFc4QVNqbjZETVI2?=
 =?utf-8?B?bndQWkplU1lyVGNuQjlVRFNzYldhSFZsdldQWEhsRGhySWFxa1Z0alhhSGxD?=
 =?utf-8?B?SFVaeCtoVDR4dUpaQU5qSEEyUWdRK2paSzBqd3B4dUZPMjVsRkNadnJ6U042?=
 =?utf-8?B?cVN2RG5NamY2YTQ5cWFRclZKQ2lxakxTTlRQdmtwK0NVcUFlMlJnaFkrNHQ5?=
 =?utf-8?B?TlYvbTFXUk9adzl2cUdjSUxCcGtURHRPazF0amNoamJZOGhISVZiSkZUbERQ?=
 =?utf-8?B?bDRVYW5iQUdLYUVvQUc3VU94N21majE0RVRaZGR1Q2RHWlljbGRoMFpzdDl0?=
 =?utf-8?B?VWtsc09leGZlcEczQjVOQ29NRE40eGQ5VERHNzFxb2RDZG5UT3JZNzRuTklo?=
 =?utf-8?B?eG5OTTlsSnRWNjJwbjJvZ3RSTHRCZ2pVd1JEbnB0TjFWVE5Lb2RVMG9aYnRa?=
 =?utf-8?B?L3F0cEhlSzN4bGs4am1wZ3Y1ZHBkL0k3eHF1WWlYNUxXdWx6YzhRS2xwOVJy?=
 =?utf-8?B?QnZ6TFY3RTlKNjB4ZHQzSnNBSDY1THJMVS9VV01IZDJZYmlBcDFoWTNvY3Bl?=
 =?utf-8?B?VFdBQlRBYzFYSkpRbjRIMUpjSll3NjJUMTlDNy9lNC9FZVlkRVoxN1Nib210?=
 =?utf-8?B?UVAxWjBST3JNbVg5S2w5Z3hKaHlvRVJVUCtTc3VWNHVuVFJCb1lidDdac0FJ?=
 =?utf-8?B?WldtNWFQZUg0ejlvMGZUb01KVGt2NS9iMEZVaUM2ZlhJZmY2TWo0empCSUI2?=
 =?utf-8?B?dDNBbTZ2enpBRStkcFB2WllQeXlkQ1ZBUDF1Y2xyTXVuSlRISHVRbVptVWRs?=
 =?utf-8?B?aXlqMWlMOGg1eU9VdG9MRUhnWk5mVDZ3SndQM2RvRDluT0lJTjFBdGJVY1VB?=
 =?utf-8?B?NGNnaWRpWWROM05lRlo1dkE0QWVKdDd3MTRaOTVxbnYyMUQ1cWQ4ZUN4RzAy?=
 =?utf-8?B?SUhOQ09hRXNzTEZHbWFzd3k2Qk5PMlpkQkI4YnRURTJkMnVxWmZVUUMzNlYz?=
 =?utf-8?B?ekFhV1ZodjVRR3c0OFRpekNxYUljZmUyc3R3RDlyOEVPT0RYWlhmcldsTFln?=
 =?utf-8?B?RDlWdENlcVFZWUdkMGZNak9jb09FVmdpTlB3d0V2TDIxbGxXd1RWQkhJTFp1?=
 =?utf-8?B?UnB2ZitaN3VaczlTSThPRnlaYUpnRFVmalgrRzFzUVJSR3AvYkZkZnJJSExx?=
 =?utf-8?B?TnZ3bk9BRW1Fc21BeCtxRGtTdTVISkZNTStDTGFnYUlSSGMzRHFJMzZmZ3R4?=
 =?utf-8?Q?boMw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUFLYnRDZmdpLzFQdkR3dG9JQUoraGsvdURRcFNaRGdPd1ZEMjQ3MHRUd1ZN?=
 =?utf-8?B?eU5BUzYxOVllWTRBYmFDbnBIT0JZNmFDeU1QRksvMnN3M1A2Y2pJaGo5blZl?=
 =?utf-8?B?ZDRKNGlWSG53ZEM1eGxyZU9xdUY5dGkraHc5VlZ6NW1FN0kzYlZ1QzFrZFo0?=
 =?utf-8?B?RTR2c1p6VWxvbWF2ZlNIVFhqYnBxZTNOWFRodmwzc2RqWnhhVmVzM3hNakgy?=
 =?utf-8?B?Sm8xdjZjQUJKcldiS2dpejBHOWF2TGQyL0RXcm5WeXNRRkVHVkFYaVUzM1dT?=
 =?utf-8?B?TGE3SC8vOFNiVDl4RXJCUjA4clpVb25LSDQrTVFmbTl5Qm1GSHgwVVZhOHZI?=
 =?utf-8?B?U0lGYmNIVS95V1pLOWFEbWtueW1ZRiswejRCdjVheGphZzltdXFVbGUya1ZY?=
 =?utf-8?B?N2QyQmExSzQ3SmNxYlJMZFFEM3RzRXg5ZlIwZzI2VUltMloxK2NsRGFvTGZ4?=
 =?utf-8?B?MWs1MmlHZjBGbmdwdUdRSjhEYk5PU0ZPTEE2YS9KeHpwdzNxcnhycU9na3lT?=
 =?utf-8?B?SjlkV29FOFpYWXNKRWdiWTdtMUJyOGxOb1liellMVmo1bEo1TEJBclh0Q29m?=
 =?utf-8?B?Z2R2NnJIYU5VOHNTZUVwSHZ1czZMWUpuRUh4VzQzb2xhUWx3bkxrYXpreFVV?=
 =?utf-8?B?ZlJ1U1pCdVl2dVFBOE9aZk9acHAvK00zNlV6ckxOc3g5WitwV28xVEVFSW9S?=
 =?utf-8?B?MGRWazZSZU9XVjZNemtTeEZrVlFJcXRmK1hsLzdFTzJNQUtFV29TT0hNVUNa?=
 =?utf-8?B?QURwQ3paZTlpdFRDTzZhNXMzUmtiWEM4QitaU3J3eUp3eGNyQTFiclExNjRL?=
 =?utf-8?B?R1RZVFR3NHNNWGI4eW5UbElZeCtmT3hWZ2ROeCs2L3JpNWx3UitUWjFGMVZN?=
 =?utf-8?B?UkJRSFIxdWRSQ2FsWjdldThad092THdNOUVtZzdoSDhwMllIcnpxdlAvUHEv?=
 =?utf-8?B?K21SejVEN1hEa1Uvb1RyTUFpeGR3TUsvMWxBNmcwNDBrKzdqTEFHS29vV0hj?=
 =?utf-8?B?eXptYjEyV2E0VGVJKzQyOG5MTlFqWEFEek5UTTV2dC9reGZvdXNRZGdrSHRt?=
 =?utf-8?B?SWNyaFM2ZXJ4K21LTkgvaXFaZXErYVlQWkRkbXY2WHNRSGtackNXeXhHT3pL?=
 =?utf-8?B?bHh2TlRwMzJqT0pHSUxHUGh2SXcrNWIwQnRJZVJXRkZZV29OQzNSR0hncDln?=
 =?utf-8?B?MGRXZHR0MG1NRlBsRmw2bS80ZWkvNFFHdkJqZS9oWW9vZFYrSW1QVThlQ3RG?=
 =?utf-8?B?MWpjajlrVnU3Vi9VRHdGdXgzRi92VzdxZFZyUldWa2FlRGkrSUhrdkcwRFhn?=
 =?utf-8?B?aGxTUDhUazViK3JUM083dXp3anF3OGRNaS9hdjcvaUZwWmxDVjVHd21ubXF5?=
 =?utf-8?B?VDFkNHF5RUFLb2Z1K0t6dG5pYllqcWdmeHpyTWkvbE9zcStvVFQ2L2FvcVp2?=
 =?utf-8?B?U2NWQmp3dThWSnF0djJHcUJMb3RyR0dSZzFrVzFkSFFibUNUWC9CUUlhR2xP?=
 =?utf-8?B?OVRoek9hVEZGRlJPVnA0Q1dhcE5tY2V5aGlrL2xDcmIwRURUK01VcHFNQmVK?=
 =?utf-8?B?NTNkVG8ydDUzYUFodGtJd3FRMDFock54blJzdVJDMlNtL1ZOR1hTSFM0Q2xl?=
 =?utf-8?B?Uys5cjJzcGZUUURZWjg4K0xjK0FZdW41L05SVVVVdW5kNzloeW0wdlBWUUli?=
 =?utf-8?B?SytHT3BjTUtZRFhnQXM2SE5FMXZHNGpYQ0JMUlVySGdnbGZkOWJHSm02Q2N2?=
 =?utf-8?B?OVhUVERta2xKSXlIRnpyWjQrbDN6NHJsenYyMGc0WkxkTjcwZTVkSnBOZDFR?=
 =?utf-8?B?czJVRFB3QUR4eDhkYVBXWjQyUzNjTXI0SlduZ3R5aTNoT09ud05pdnRHa084?=
 =?utf-8?B?VUJnYThLYy95cXk2MWV5aUlzSEkvd1MxUkpxM0doQnVlL0xoV0NPQk02elNO?=
 =?utf-8?B?T3dFcWlWbDhnNU1ZVWptcFhCV05IdUlwZ0sxSmQ0Szczek1TTTBaandGdXdY?=
 =?utf-8?B?T1dXT1dwbWJXeGcxSnkyWEQ1VlBiSHJQY3E2VG1vd2RZcXIzTUpHNHp2c3ZJ?=
 =?utf-8?B?SE8rMFBqMU9GM2xwT1hVbkJ2VHlKaU1DSE1HL0dRd0d3b1V1TERlbVBDTmpE?=
 =?utf-8?B?VGdYMHduNzFKYlVmMC90SEVZMFNVMGNCY1NtTkRDcFNrNTlodzRwanMzMFE4?=
 =?utf-8?B?VTl5aGRxQ1lubitXbFllSWN4ZW1wdjEyY1M5NGpXbkp6d2FKTi9pMSt6U3Nr?=
 =?utf-8?B?T2wxSlZhbFdtSDJURUs1b254VjdVcEV4SEdWU0dYNDFqNjEwNlFhaXJXSWRt?=
 =?utf-8?B?Uk9ESkhqdHpob0p2NHIrMktNa25zTkJ4dGdzcXpPSjB1MWpLZWNIdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c106d210-91cb-41d9-8c44-08de58fcf35a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:54:17.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBXCSsdnJkNH85PlRtd3lu9SN5fGwiOHko0fGxlhtE2g3GICTQuXP2d0mVzOXduWm7x3YMi20UkISqwPLvk8Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5912

On Wed Jan 21, 2026 at 2:23 PM GMT, Zhi Wang wrote:
> Convert all imports in the devres to use "kernel vertical" style.
>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

It does not look like this patch has been changed but yet you didn't pick u=
p my
R-b tag.

Also this is still using the wrong email address for Miguel without using
the .mailmap.

Best,
Gary

> ---
>  rust/kernel/devres.rs | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index db02f8b1788d..43089511bf76 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -254,8 +254,12 @@ pub fn device(&self) -> &Device {
>      /// # Examples
>      ///
>      /// ```no_run
> -    /// # #![cfg(CONFIG_PCI)]
> -    /// # use kernel::{device::Core, devres::Devres, pci};
> +    /// #![cfg(CONFIG_PCI)]
> +    /// use kernel::{
> +    ///     device::Core,
> +    ///     devres::Devres,
> +    ///     pci, //
> +    /// };
>      ///
>      /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x=
4>>) -> Result {
>      ///     let bar =3D devres.access(dev.as_ref())?;
> @@ -358,7 +362,13 @@ fn register_foreign<P>(dev: &Device<Bound>, data: P)=
 -> Result
>  /// # Examples
>  ///
>  /// ```no_run
> -/// use kernel::{device::{Bound, Device}, devres};
> +/// use kernel::{
> +///     device::{
> +///         Bound,
> +///         Device, //
> +///     },
> +///     devres, //
> +/// };
>  ///
>  /// /// Registration of e.g. a class device, IRQ, etc.
>  /// struct Registration;

