Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38079274FFD;
	Sat, 31 Jan 2026 04:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769835486; cv=fail; b=KDFTZvheYMeRnXsqBEZa21u/rXPwG1w8omfaCOMPYughc7PjcsuFUWKRrmnlQb1yqSqkwmkHKSjke8DnbdOLtT2Ems8qynS+rcE4sDxEwmi5NjVkiFMbAQUryTB0aMc9n5pd7z0TR9qthJfn9RJwbvSCU9pTmoIZppStJaZRi7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769835486; c=relaxed/simple;
	bh=e0PHKJiR+j0hvOwwfWOqI3j5ZCgtzz5ZCHbBXBL9nag=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=r8v5wZjfM7UqmznPqASV5eeioE8OAOqR188YFdepzGLEYP05YI0qXZQZ8aqwLOMdZ57RBvFq8HVej7O87nqrpE5evi/xjB4D+bAGDOBc+FwPybXZqcVUI8TI22MC+zfu33z1AcyteVGgKfuDSep5a4R0p7VDbGWmmXNfln1r37Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ee/GNoF0; arc=fail smtp.client-ip=52.101.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ee/GNoF0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odLwPXBw8w5PH2qdEg0dsSQrU49cULNBwPqfKFAcEss0FFyJm0XD935hxtEIdLR9phEogGddx9zUdlNpgaCwCXkGeh6S4rNdYOyzRcrYVOmwN4xlRRM0yxTyeArYJAIizcLT9a7SPugiJ+7eMwt3Jz6hRWD5kOqa6C0qyJabk+kO9R60c5aV5oqmoTVeBxeefSUyZ20iZPmyk8s/uFS3JHOXcEBy7WqELC3bc4BrvQTPKY05m0FrqM0287fWxQOR+DQUrGvj2Y2fVqBvTyc7MTFTO5Bp30+frEa9j2e4egQYlSaYKUyPC3pxl9kuqI4KwpZTZ33bmJ+L/1B7UO9d2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0PHKJiR+j0hvOwwfWOqI3j5ZCgtzz5ZCHbBXBL9nag=;
 b=jiI5QtaJSvTO5cxBmjpYpf8bpWckW6anMUGq0LOGQlyZMHchn2h0l4r1+6wmfPE301kG3ufwAY1EKXJLM/95BXJmBCVn0OL6u6Syy6yhJ7vOPUXsySrCqcrZ+ZdVRtojNlGkW0+/75eFKP3ZSStVT+feP704B9OYucHgClVh13ops/EvtC/krmoBz9C1DM3dbzwaGhu+72+FJ4DKh9UnpQLuytkUcMifECknfrIlI2QAzGGbLFX/oS4T+Uy/twsrNkvQzxioqNhQ6VC+noWd8VksYfLDlAU5dSleX/LbHl++tlwcbD9KQcGAP4cKo1hROErSmaLUzm+7DCh9hBtY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0PHKJiR+j0hvOwwfWOqI3j5ZCgtzz5ZCHbBXBL9nag=;
 b=ee/GNoF0NyptMQWHCkAhwQuabpfeN5rBHiCakLLlAOKp527wzU0c/oMlHOolRuvIWELe+JwuOyjVWxPYwP4CbCTreApa+//SFr54h51fQIPlNsVXnDk3lw0G7SJupb3P460NyqRU0moPkF+KmU2ircpt5Y6gqyV17Jcm5KyN+a0p3W0JRMXzVBJ73voEi1jgw2StmQa4P63PZZIbg26lE/zJMHonccd8RROxznbLq7ezQuIhMXQBodRpn9GdFWyE3krTyzfb/ptn04aUt4ifm68hifMTW08CxnaCWthOyd798coJ128pmbhX4AAh2vSwl0cfAm29vHk8CIimhnfN9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sat, 31 Jan
 2026 04:58:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9564.010; Sat, 31 Jan 2026
 04:58:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Jan 2026 13:57:58 +0900
Message-Id: <DG2IBEN3R835.2IWAZ44EOS8F7@nvidia.com>
To: "Zijing Zhang" <zijing.zhang@ry.rs>
Cc: <dakr@kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: pci: export ConfigSpace
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260131040232.1243049-1-zijing.zhang@ry.rs>
In-Reply-To: <20260131040232.1243049-1-zijing.zhang@ry.rs>
X-ClientProxiedBy: TYCP286CA0180.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: df96713c-0e5d-468a-8f9b-08de60854ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWs1OFZjcmYrVGs1QzZQZEQyWWF4anA0aGREWllZZFFjVzFiU2l6b3pjWFBo?=
 =?utf-8?B?RHdTT2FFQ24xSk8za1BBQUp1QlpTMGFoRkJWaDlISW1OSGJjdzdydGcxUVlN?=
 =?utf-8?B?b0pvR0hDamtkdnAxcWdvRW1JcWQ0WVQ3SzVPK21ITnFKOG90Y3RIeWd5OXQ0?=
 =?utf-8?B?dm1vWWxFMUVhTTVEa09rZ1RLVk5PeFM4NWkzVmxlRmFra21rMlFqZTNLZWZj?=
 =?utf-8?B?MUh5NEk1em8yVCsrcjBOVmg1eHlvSnlDMTQ1VE5IS1dIU055dE5TNXhFNWhu?=
 =?utf-8?B?Uzgzd0x0Mjh0QTYyNDhLSTI4OGp3cGhzVFBBTmdvakFBY0wzYURXYnpPKzNG?=
 =?utf-8?B?K1hETHNYS0xEejNnbGZ1Q2g4aldCbEZKS29JSFM0V1RWTk9tMVNVTkVZcjFU?=
 =?utf-8?B?MWlRdG9BWVJUcnhHbWxBSEhhbkVJY1NoRHBuOTFZb0E1U0hZZ0cyTnhOM1BB?=
 =?utf-8?B?cmhYbWNKQjRSd0RLT0VtSllCZU1ZZ0NJOVJZZzBIV3JkRno1R1dseXhlTkNG?=
 =?utf-8?B?RGQvQjA0U2lWOEhEcXMzbkRHRXBydEVOWHI3STdlZmdrV1kzWWJob0w0ZWg0?=
 =?utf-8?B?TnQxb092SXZGOTJPWDlnNkxPaHA1Q1UzYmtwWkNDTGF6SXVNZEJodXpyelFr?=
 =?utf-8?B?TkdUTzRzMnRPQUk5Q2R0SUtuZkY1UW1nRktsbzhLaFNiSm5ycjM4ZCtLczVz?=
 =?utf-8?B?U3lickVhRjRyTEpCcFkrRmlUdDhtellSNE1lOTZsKzNMQ2FjQlloeitvd2xp?=
 =?utf-8?B?Z2tPVWF6dFBQdGhuMW9vQVVBcDEwYzJqbkg5UFY4R2ptR0RKSlg3U3RteTJt?=
 =?utf-8?B?Tko5ZUQ2K2ZHWStlZnFzOHoxanlSdzJOOUl5emtKQWttZVJ5NmNCNFowOWNk?=
 =?utf-8?B?UXZlMHpleWJxeUMzcnNseHNsQnRmLzFOUzQrNEU0Nk81blZQRG5TR2dKRytL?=
 =?utf-8?B?TDFVeHdiMDVaZnJmUmhsQUJxbEJ3eUIzTE05dnRGV0RiaVE0NVVJQWtNcit3?=
 =?utf-8?B?bHBJQzRKMnRmWnJ4SDRhbU1rRStQN2oyUEhpcVVGQkRhdW9nQU5TK0JLdXp3?=
 =?utf-8?B?THlBdWNPb0ZrRVpHVWloOEtGMEFuZjEzUWw1Y0NnKzlBSVF2bW5iOHlxNVpv?=
 =?utf-8?B?NDN5YUE3Y3VEdUs4bmpXRG0vWHRHV0ErUnAwS0dIKytyNEhINVcxU2RRTDJp?=
 =?utf-8?B?L0h4UmRDL3Jid1NuQkJ5SUlDeHk4Z1dReG9idEJsWDIyV1puc0JCR2xQd0hW?=
 =?utf-8?B?K041bHlvcFVtVGYrNmk5UE9WY2VKVmNEMEk0NGprTVRtSW90alhiRS90UDFF?=
 =?utf-8?B?NjcxVGNZWkJWUXNUV1laL0t3M2ExY053eGZ3Z0l1a3ZSTnVLN0RoaVE5SDJw?=
 =?utf-8?B?d1Bscm1rQlBmOVFCVUszSVVocTA5SlJXTFpuanRGQmowdnRVYlQyblNPb1Fy?=
 =?utf-8?B?Sjc2K1VWVlpmWlBhTUpUNmljNktHTjFBL1BoYVFEUU1jOWRxZEpqcFkreWV3?=
 =?utf-8?B?YVZmeWk3dmY4YVRrb3hpNWtyZy93MGJPcEw3OGkxeDNFV0hxUVRtd3lhdjJB?=
 =?utf-8?B?TDVvOWVrZVM1OEg0UmVVcjM2VE1LNEQvNFlLdEdlWnUwUW8yRWNIcFY0RG54?=
 =?utf-8?B?Nm1hVlhMOE5BbTBEOFVLdllsMTQwNW1ML1BHRVZtR1M3WXN0QmRtN1FMMzRC?=
 =?utf-8?B?V0d5enFscGdhODJGREt1OHZCMUpvYWl4RzFHSzk1Y0MvcVpQcmd4ZWhCamVj?=
 =?utf-8?B?MGFSOUhueHNaMG92emtjY1lIVGxOZ3dZdHNpTXpuSkFxWFdBRGQzaFU2aEtC?=
 =?utf-8?B?SFpPVDR2RFlqUmZJUHNHYm9tV2tCbzFoM24zRG9ONm1BOXZwQThHVUEvOERJ?=
 =?utf-8?B?cUNES0JvME12MWdlY1ljd3I2K1FTY3RXVFRNN3N6dnNrZXpxNGxOUFNHWXlW?=
 =?utf-8?B?UlJ0ZXlYbWorZnQxNFVKWEZvVEdPdThwN2REeWVWWE9hV0JrRHByTEcranY2?=
 =?utf-8?B?U0REZ1M1RjZvY0NRaldhQnBaVXhUN2NGZVJLbWRKM3ZNYkhyVnlrUWRIRkEy?=
 =?utf-8?B?TjZYbjdyY2dxMHYxdStjaW5sT1hreEd2bWthZ3hMWWcyRzhIRUc3N1lmSXVy?=
 =?utf-8?Q?433I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm1KSlJKMi91OGRFMHRyZERVeUF2cXNsWWFaaW51cnpvMkdsNWN6S3hWNSts?=
 =?utf-8?B?RUcwR09SRXNKS0NOT2ZuczVxOVlWQ3FobzRTWWhlaDhyY1p4N3N2TXRieFRC?=
 =?utf-8?B?ODNkYWFCYzFrYW9TMWFnbm9RZ00vdXlJNW5FY0F6SkNlTks0ekdMTUVLanpr?=
 =?utf-8?B?dG1rMUU2SHVEa0xjUFJ0eWU5SnZDME81TGp2Y1pGTjlUVHlVOFNpcnhRb2RG?=
 =?utf-8?B?Q0U5ZFZEWFluMkZRakYrQWo5bHdvZUpnUnBYWkxVVGNoM1ZHVVJUN29kNUNa?=
 =?utf-8?B?YWNXamFqM0lmTWJhOEh6eGFBcUVwMXluK0xTSytDclhtV1VzRjk0eHBOVWY0?=
 =?utf-8?B?OURmWnkxcWd6UExMMSs1MkdGaW1jV2J0TkdOR2VIeHYrWVpTMlZ0bkYzeHI2?=
 =?utf-8?B?Z3NHblRLdEhrblZGbk5ZNzg2TllWOUhMUXFKQUFwMDBPWnMzOVYyUCt2clVT?=
 =?utf-8?B?cnRQSHMrbXJPbk96cWRFNGtmdGU1MlNaSFFNUjFoQ1VMQS9lMTlrUXRlazds?=
 =?utf-8?B?NnZ1dlZNaGFsUUFZTUNVQ2g5NkVrTHFCeDAwSjFvL3V4SWFwSkJDUnc2QTZy?=
 =?utf-8?B?REM3NDk3a2dzZk1TSCtmQyttU2hLZXlrWUxURERXZnhHNk9TeDJ5UlZqNU5S?=
 =?utf-8?B?WndrSk4rUGs3U204QVg3ckZobERRMXZPNzN5ajJPQy9pUjVFSkpZS1c4dllV?=
 =?utf-8?B?cU1qSFdmZmw2VFRibUpacDZrWE05aUoyWkphQ01aalozeGh5NG5ST2FPTkFn?=
 =?utf-8?B?REp1MnoxeUUzVmg4WitEMnRlNHlqaGRITjh2TFI1OXg0NnAza3ZoYjBIWEZW?=
 =?utf-8?B?OG5lMUxuaXE1c09kNUFZT3EweEpsVzJKMEtxUEpRZ1lpN0NlazkyMHQvanpX?=
 =?utf-8?B?TGdqTVRWazBycy9YUDI5UDhhUFdNSGtZYTltbDlEei9kSUcxZjhXQVc0VHRG?=
 =?utf-8?B?Y0hXNU5wcmxvanRXKzcyUmdOVFN0Z3N3QVZTemJobkhzMU1hOU5KTVBIWlA5?=
 =?utf-8?B?R21wTitZYVY1TDZ4Umkxdis4RlJ5WjMrSjJOT3padi95U1BrckZiNURrT2J4?=
 =?utf-8?B?UWJWbkZoUS9GNG5Wd1VQUENPZ0NEVTFHSk5SUk91aWZIUEZyd2srV1R6NXJ2?=
 =?utf-8?B?TWdOOFZxL1AvOHkzbmVmd2czclJORCt1dkJYMFU2Si9GMzk3bm9jL3hzeDVl?=
 =?utf-8?B?TnZpVjlXYWlZWmdJNmtQYXV4c1lOZEdJOGxVK2VYUjl5NFJUa0trOHZrb0Vu?=
 =?utf-8?B?QkErUVRrVDVyUkNYNzFGQ0ZhdzR5RC9kYXZzbWRtK2xWNzhZWnlkemJFUzIy?=
 =?utf-8?B?WjEvaHQ5MDAxeXhWL0tQVUZSaHhDNGN0ajZKZVMvMVJraDhlUSs3OXpzNmU0?=
 =?utf-8?B?VEZkVGVmRkthaEozcTZGbnpoRjFWTlFZK2FieUZNYy8rL1E2QlUxN0Z0TzVQ?=
 =?utf-8?B?bDd6OFMzcVlod1JnUGhlc3RIR3l5OWl0YVZoL1hybzFlVkpVTnl3S2ZPS1Fu?=
 =?utf-8?B?c1BRUFVrS1owbURtQ0lqdWZrYkkrODJlK3YzQnVVN0plY000WEE2eHBWMTRp?=
 =?utf-8?B?YUpNbVdxWjJ5RUFScGh3eVFsbWk1N2lqNzA3MzAwV1hCbVJaejA1djZSUkpn?=
 =?utf-8?B?cmRVNGhrK2l0UCtVaVU5ejV3UENCRWphTWJYU3FQaUJCWlI0VVkvM29BUU01?=
 =?utf-8?B?Ukx5KzlmQk9lYm5xdHhpcUxkNUFyQmU5VmZTUzFFeDY5ZFBBdmZ0V2xoVnZH?=
 =?utf-8?B?V1Q1L3lzNFpBNU5HYVRKV1JsWVZmWHM1VzdnUTBXakdRSEQyK0V6Z0ZMWWow?=
 =?utf-8?B?b0xxT2JyNm02NDFNRjBuMmRXNjhvSVpWYVVlc3VML1dybk5xVnZrKzNLM0U4?=
 =?utf-8?B?eEF4c0tsdmtVRVF1QlNrMWl0dGUrajBIKzVDUUFFaDM1M2RpNFZFYS9ENEJ4?=
 =?utf-8?B?djUrdU9RdU5vV1VQUnk3UXVRMnFCUVlsRExQMFU0Q1RHdzlWWmM3cWlHTEdK?=
 =?utf-8?B?UWpWeUVMQXFraERrZDhkekdxUnNuT0N3M1NTQzkyNDBoV2VWamJkN3pEakVx?=
 =?utf-8?B?QlNvTGRnei8zMUpCeWNwS3R6aE5lVGl5REo0NWtLOC9RTWxnRk5lN1J2ZzdI?=
 =?utf-8?B?bEd6eCt2YnN4WUV0V3MrdU9QeEJabGt4UFZ4WUFYSU16c2M4UHc4YzRGTFFF?=
 =?utf-8?B?cUg1L3oxbi8wZ1Z3aUU2RzZBK0hGd0xJK203SHFqUk5HMEo3NklRVWgzdHN5?=
 =?utf-8?B?cmpWdUFMeVdHcWd5eVJCajBxUThIMWFmWmxEK3NCZk5DY2dSc2VKaG1YcVky?=
 =?utf-8?B?OTFya2VvQ3JUZ1BEU1VUQjhxVUlkQjJudlhiN0FBTlZEdm0ybm56MjZvTTZX?=
 =?utf-8?Q?x8nuJsNFuc7Fr21Ll/mJ3Uqu9PBTB9yam0QrDP2Ht8WGT?=
X-MS-Exchange-AntiSpam-MessageData-1: 6gj3Doo9M1JKmQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df96713c-0e5d-468a-8f9b-08de60854ff3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 04:58:02.3440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iltte/cqwqLC03eiupowrs/+S25ZQd8JHPaD1AjnOw8niIxZq7ONeeYd8d9PgQU1MsZGvVT1RoSKafhSRGIiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346

On Sat Jan 31, 2026 at 1:02 PM JST, Zijing Zhang wrote:
> Re-export ConfigSpace from kernel::pci so users can name the returned
> type from Device::config_space*().
>
> Fixes: 4dc0bacb1d3c ("rust: pci: add config space read/write support")
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>

There was probably no need to resend, but since you did, the title
should have contained "[PATCH v2]".

No need to resend again. :)
