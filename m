Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A73430CD87;
	Fri,  6 Feb 2026 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357645; cv=fail; b=lN53U5OTnXR+V1CMb+ztCSChwS/J8JDUMR94n+58aGo/mZmpPnAorlhqEQ1CTcGa99YxEc4aEbtFffvgksnUpSfotsSHQy+XJ21zCnoJiQgoR8rxseek5BcTBY5YgxwafD746354+Z81gCVOUtS56hXQDfXRvmWdkEzKyPw1OCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357645; c=relaxed/simple;
	bh=LP84xAZQYVyEs8gF3G8FkDaRnfcTgay9BieU0jGEFMk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=g4KGkwkPQua/0jn3F+SWZJKbhcvcm7dGxmquQp2MtFoaVLYz4NYPStFJjHziAR7gSpPlDs5C3n/ltVf8SRxeYTTUgZRsrpLHmt9GnenT5s9JKS4o8a1Do57ZM4Tr/uX1ZSd0zEE/uV/THd+jOLakbadK6kJWsv3zmqfR5tcQaC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kE80uuQp; arc=fail smtp.client-ip=52.101.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kE80uuQp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4rtBbqKT0HyoiqNgdJqqhI5zdg2NHt6amZVy+ULJJwqGHsrSK9ljCyEheL7ndI5Y0CvhsUEtteDesdxJm3siNk+RsGgBPfMKeig//WVsEHISXjzYoQ1K680HKe+LANJPRfpStfXdoDOzc0UDS0cno61mR/ScLnMvk3qVZonZN1At+8SWmAVbH9U7+ExhPRo/MlFwhzQipfgX9XUl6hDr66d5Ds23j7vXf6jPoPRcHMghcX/c54kKaKASMAtURmdX5VlJCTY1VKWguu1cufzhNgtUpMRVjPiv4ueBa7j+fDMCCcZa83Onw2kJeSrDeWJlbodrWBsj8YRBbB+5War5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sySmbAw+bO4tppt4IW8fnrs6cUYJ+2/nz035a95Qk7Q=;
 b=UqeM2SAcuz9J2Son89ggZ7RCTzjTa9WJ0qWwbBZqMbqro8IuJ2oMV5ZkFq9SNHo/v3if26uQSf5tIpUqZuRjSSIcfYXJv8vdfcvNiaSAgauz7Lsw2/Ww04jset07iRHyOQEaLALSvJjs2iKBvPar8liervUcnJ5hE8zsOfrpaur1bbNnxr6lnPbyloTWbKdIRbVf+FmxWd1B/DLW/M8s4w/8NQidNKxkBWPiwu4zfAc2U3PpE/Fd/usfhcRQ60+2et65QwlVxZnTRtihdC8P53kIMVmX3ZQQH4G0vBJ67t90KkcSbYdXWWcVnn5ONTSXOh7CU3TIH974qlUlLLqiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sySmbAw+bO4tppt4IW8fnrs6cUYJ+2/nz035a95Qk7Q=;
 b=kE80uuQpEaX0QszlWxCRiauzmCv5aqEtlUn3/uuCjW8wl7+llaE3j01bSQPUNkhPXkvllF7+DqkPJXLEAuu+KZ8ok0bHNGxSfgeoAC6QsjlbcCG1mCPcoQkTlYQEjYZqvs8JtBVP+A5vXFJNLcmNGkRUQT0V9QY2TvhC5wyyvkbE4+PyLz0ox4/ifEhHAk/y0ByBfjUVsh+bpEpSamP4NCIbsbJ0A4dVIRnXbZo644dMV3bKhcyQridkmUPyl/f33QawRZyYizu7fp4o8EFool8B9M8TIJz7iGzghr+/q582rRYN1weXXUXEtZdv3vl3I6IzoUG3balOShfjD4zuqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 06:00:41 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 06:00:41 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 06 Feb 2026 15:00:17 +0900
Subject: [PATCH v2 3/6] rust: io: provide Mmio relaxed ops through a
 wrapper type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-io-v2-3-71dea20a06e6@nvidia.com>
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
In-Reply-To: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Zhi Wang <zhiw@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: OS0P286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9f::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: 839073e2-6828-431f-605c-08de65450ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clVDcXVWUjBNQXM3WVRUSFB5VTZRMklNMGlOZHhRNldFK3picGlqdXhlU3hI?=
 =?utf-8?B?bXdYWGh4MllDMDZVUSt0RTNPK2prY3dJODFtT1RaWE9uMXB6M09jWG1hcDdF?=
 =?utf-8?B?aXR1aVJRNEZzY2dOZGpUbzlwQ25WMytKODZqTk11Y1VGdVJTbzBHQ2RwZFc4?=
 =?utf-8?B?L21zQStMNUVhMks1UGhmZ3lCY0tKa3FRZ0tiTElUc01tSzBmM2s3SUkxWk9Z?=
 =?utf-8?B?MzYrM0FIYS9scnNjbU5Tbmo0djNHMzkxZ1VkWDB2aXZ5RkpMSE9jbGZWMWM1?=
 =?utf-8?B?ZGxJVnRsZHBzRngvOVozTFRpeWtBWVNRK1ZSUDZaRzI0T3lNK0hDejN1MTRv?=
 =?utf-8?B?MjlaOWt5RXcxL3RyUlhqWDZTQjlLcno4cFFlaWVucXkyeXVKQUdsRC9DQW1L?=
 =?utf-8?B?ak13L2twZ01XUzZKRzVrQUpVb2pmQ3pOVEJmdVg5bGhNMzhDSDFnTVRMd2lN?=
 =?utf-8?B?dzBzejlqaXdQUHNWcmNwSHl2S1FEaHdBbW1KdEtxNklNV2MwbnhoS1gzb3dF?=
 =?utf-8?B?cEs3SjdyVWtXNWs4d1F6TVJXQWpiRTRwREJIOG9WWlh4VHVLTnNpcmlrNk83?=
 =?utf-8?B?enNRWHgxYUpBOEc3N3M3czVVYnRvR2N6eVVsZStlNXg0TjlSSk1xTkZXYzUv?=
 =?utf-8?B?anUxRzdleEVoeENXWS8wdFJOVkc3SFRGRk1WOU1kamF6Zjg4SGVjTzE4cjVT?=
 =?utf-8?B?MEQwTm9KNE1KbUJuZlYvc0w2OWxHZmg0OE0vTjJFM01nRnZiQ1htc2RvOXZY?=
 =?utf-8?B?azFxYWVlOC94SnRTS1ZLaUNKSlp1TWVqVEo5aHVueUFxL3ZCYUl3Q3BlM0xU?=
 =?utf-8?B?TVE4cmFmOURWeW5rcjJ6a1ZuSlZVS21yKzZOY1J5bDhuMzRBZ2k4ampvT3lm?=
 =?utf-8?B?RDdEMzhyY1BxSmJENTJvdnd5b211WjA2aUdiMU5nVVJzNzNJQ1BXeWttS3M1?=
 =?utf-8?B?N2V0YWY3akpNNytBckxZWUZlMmNWN2prT1BsNWNyUko4MW1keGwxTmpPRjF1?=
 =?utf-8?B?L2pLQ3VEMkJxZWp1VWxjeHFwVzIxT0RUK2F3cWNzeEErME5qb21IK0EvSTlx?=
 =?utf-8?B?NTRiOXJ0UWRhNGJUUE1nSkFJdUgvV3E4SmRCRk1zdTJkT2FmR2Y5bDNJQS9R?=
 =?utf-8?B?ZitCNUp5ZDBDZDZyd0VOV0k2VlVJM1RkdW1KM255SU56d2t6clIwNEIrdWtZ?=
 =?utf-8?B?U2dvOUo3NU81bXFqcklHRG05bHZFa21weGhuVEJOdk9vS0gxUXlSTkpFMlBZ?=
 =?utf-8?B?NUdPbzhYbFJHc0Vzb1JaWjVzT3ZxQ0h5WXQ2MnpvU1JaR0w2VjFOUEV2ZlZR?=
 =?utf-8?B?aWtRVVZSRFVpWkIxd05FeUJBc3JsVTdLVVIxY1dYdGlEaUlKbU5RR3A2VXhp?=
 =?utf-8?B?anFjKzFBcmx1VGZIbXhuK1M1b1YwdW00bVAzRGp4MWNJUitLa3lla0dqNzZO?=
 =?utf-8?B?L2piUkFJd2RiMm9OUGNLVGJ0T3NUMnU0QmZNQ1lLL0hpdEdUbjh0Y05FMG1h?=
 =?utf-8?B?QzJCQ2dyVlR4am02MXJqRGoxYzE1T0lIVzJuRG15UEROSW5uVkQzdzdZbWhV?=
 =?utf-8?B?cFpwRjZyNUdUSmFlTytERmZDdjF1L3Y3Yzgvc003ZkJybUNUUHlrQ0RXMStJ?=
 =?utf-8?B?QmJ6RVNDZWNDWlFuQ2R1a1FtbE5STXRrUFA4S1FXT21kNHZtZlpIUUZlSmRH?=
 =?utf-8?B?OVprcUd5Q0ZwRWVRRVRicVRmLzZpbHBld2tXQnF2eWUreU1aZ0l1ZWUwOUFt?=
 =?utf-8?B?Zis0TzNNQUluWElyVml6QWdodjVKT2RUM0EwdGpkUEtEbUh4VWtsa3NNUHJZ?=
 =?utf-8?B?MDluaGdYNXpHbmFseGVhWmVBY2MwV0NKUXM2WkV5RFAwc2EwRmFQUi9jSGV6?=
 =?utf-8?B?enZZcnUrcVF2QnpaU0dieEpyM2k2KyswbUtzU1ZNdGZYZjNhOUY2ZWd2S2xH?=
 =?utf-8?B?TEVzcHhQeWk3WnJqWmh1MnFUZVpxRC95VHBTWFlyalp1SzFLeFpIS2VKMlVu?=
 =?utf-8?B?MWZXSyt3dDRRTGxqR3RIVkVPejZ2ZDZCby93VHZsR0pzbFd5UU1ETjltc1FU?=
 =?utf-8?B?SDZ5ZFh3WmJGN1IvM21mODlXWUwvZGFEeTNyb2xyc0VLTlFlMExZcUFUZE9V?=
 =?utf-8?B?RDZtU3ZIUE1ucWZ2NnpCdm9zbUt0dDRZNGEyQUpDV2RFdEowTU41NVhIVlRy?=
 =?utf-8?B?L3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm1SY0tYM2lLM1pVb1BUczcxQWN3WGxid3dLNWJNS245ck5US0JydlRxeXVQ?=
 =?utf-8?B?eVdMaGFWWEVpQ3llb2dnemFJeHp1N2tJNVBZTk4wTjAzaE9yQ0RzdjNvRXZS?=
 =?utf-8?B?UkUwQzQ1M1JYT2szRzBqS0RkUjh0KytTZUFxR1RUK0pRdjRyYjh6OHhpRGkx?=
 =?utf-8?B?cEdtWEdCenJPanlUa2czenExU1ZwTVhTSDFScTEzVjFYT01NaTBRSnZscUlE?=
 =?utf-8?B?NWhmRW9sdGpjN1AxYkREMHNKQVNWMDEvR29pZWlBai9ocEltblJzdHNkT2E4?=
 =?utf-8?B?VGhJYzV4U3Y2L09LcUNDZWswVTRITk1vT25RcXN0WUxFTlpQUHdZUGg3MUZY?=
 =?utf-8?B?M3kyY2g4WnlZdmJTTHExSVdFQzBCSzZ5SCt4Z1VMMTV0UTdnbEJuWkxyS2FQ?=
 =?utf-8?B?d2NWdE9Nc25IYUhFZUJSVWdNNWl1SDFVTnpkbTIwREhMRmVyQS9Uc29wMTNw?=
 =?utf-8?B?MFdNOTZRc1Z3dEtnTmR5K3hqT2Mwb255M012bmRVTVZwa2tpNXdvMmpFcWZv?=
 =?utf-8?B?RFhBOVN1STdONnFGaHAwNlpDQVFzN1FoUHN1djBseHZUTGMvMzZybUFlT2pW?=
 =?utf-8?B?TGZjSUcrZ3g2bHZkZnc0S2JnZDl3TmJPR3ViQlVmL3MwQ2NJbGlGSzNGck5n?=
 =?utf-8?B?L2xzWmVtTEkyYzRmaVR0ZUVpT1B4U0NKRjFudWd1R1dEUmNVMldNVUVjeWxa?=
 =?utf-8?B?TVAwOE1BYlBjK3hvNlhCNy9ad3BiWGVFM0FIdWVaNllJblhkek9BMFRaQm9u?=
 =?utf-8?B?VTZkSHh1bTRXcldwdmkzUEFBSFVMS21xVWYweWw3YjBlend5ZGl6aU9QTGxy?=
 =?utf-8?B?Ym5TTlJWR2ZJcmlSNExyMDUwN3UzcWNLcFFnVlNIVXF5WmIrOWNFRGdYNVFG?=
 =?utf-8?B?M1NubHlyTVMrRUpvbS9CcnV4K0ZvVnhFcHR0anUrNlh4Q3JzSHF5M083bEpW?=
 =?utf-8?B?QXJxelQ1SkFqS1NXSUFha2hFWmtvQmRZSThiRWRvemxOVFFkNnB5cDE1WHQr?=
 =?utf-8?B?MVpNaU1BNVNQR3ZWbG9PdFQveTcwelhKa2RWakdhK0xONlVXMDdwNS80T3hi?=
 =?utf-8?B?TWlaR2txcFlYamlxYnVscnEzYTVmdnUybDh3OUNlU1FNMjc4d2lRQWd6Mnlt?=
 =?utf-8?B?Mi9BMVBKLzJlUkxYUC9kbkxCMGJuTmhOM0p2Z1BpRVpocjJ1VHlSbWxsQ1dZ?=
 =?utf-8?B?MFFhdlRDc0FaUlpYYXlNbmJmOGs1UnUyTVFZVFBHaXRjQUJlUEpCV0t2aEdB?=
 =?utf-8?B?b0ViMm12aVdkRkU1UEg2U3FMR3V4MXVNSmZFUmQrYlRmNUJhVjA3MnljWXpm?=
 =?utf-8?B?c1o5SVNwZURZT1Bjanlscklncmd2cU4wSWwwSU9iRlIremQrMC9kc3ZrMFNB?=
 =?utf-8?B?cFM4V09qZTIzdDNndlNhYk5QRGJLOVJoeVZCbTBQRDMxR043ZFNDKzJUNGVp?=
 =?utf-8?B?czNmZWpmZVJYQkEyNExITzR1aUNQbjdkZm15bEdPTlNpeDRRSU82R21JSjRF?=
 =?utf-8?B?K0k4WmxSN2ozRnErNG9IM09WendXeDdkMmxqa1JUY2sxNVp4d0RWYzZ0ZlN0?=
 =?utf-8?B?OEo4MnlOem91SzJEeWY1T1hNQXpJNjR3QWFwQXBPSVZnSDIvM0tYK1JtZ3Rp?=
 =?utf-8?B?c05LMnBaQ0d3TzR5Smh1ZEhDRi91VVZtTVNVeDdEdmNTQWE2R0t0SjNpa3Ey?=
 =?utf-8?B?SUFEc1VGNXFMTVJiZzdGdXQ2Wm1relF3b1Nuc0QzNXJjekdlMkRjY21oekRR?=
 =?utf-8?B?TzJReDFzZkpZbTg3cjFsdXVYVmJDaG81TXRhVnlsaU5CQXlNY0s5MzRVbDd3?=
 =?utf-8?B?U1JhcWxuK213eEd0MW1nVnZDdHQwelFHb21Xby8rVXYrZkJqTU1pbzJDcXpW?=
 =?utf-8?B?U2h5TTNIbkpaMU5yWW1kMk1nOVQxeU0yTWYrSndaMTM2NHhkRUQvSFMwcWg3?=
 =?utf-8?B?cHBCUTJsczFJZ0RVV1ZaN0lQd1AwN0QzSjF2L2VWRTRMQ1ZtWUE1V1ZraWlt?=
 =?utf-8?B?enVrSkxhcWJJUm1KNkNoc2hLWHJjMHAzam5OQVVaZFFGS3FmbVJIbTVSVVZt?=
 =?utf-8?B?d1hnVzhrSGZ6elgyZjNNY2loYnp0UWhhbVZqR2lXbkk5SUxVa0s4K0lZbXlV?=
 =?utf-8?B?dVRpQ0U3ZUVhMUlpRDdhQnpMWGVvNDhSVEhsSmNHNmZWRFcwQk1SYjhQMjRX?=
 =?utf-8?B?bytoZEMxUmtYNGgxcTBUaGwweXdUL0hmUDI5MUxEcC9iTGtmakVCdDcvY1RE?=
 =?utf-8?B?K3lxMEVpYlFwZi93bEpFOWFRV3k1cXlvT1A4WjUyOWl6aE9BR2kxYWtjNFZQ?=
 =?utf-8?B?bS9PVExYVlVmK29xdklRbjNaR3ZJQmNVclVBVHArZDNZNXpTbEF6MXpTakpw?=
 =?utf-8?Q?pHfhnBUzET/UFAWJr+ILwVo6QrmJntBpJOOtrInQZp2a3?=
X-MS-Exchange-AntiSpam-MessageData-1: CcVhbyzij2TVQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839073e2-6828-431f-605c-08de65450ece
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 06:00:41.0225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZX854tg+H9aanOPC4sQ9VvVBOHcQfzbU/NQj8niBWOkywXZD7bxZfKuiTBDH75NOQpO7d/b1U5S+VoSODQIag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9683

Relaxed I/O accessors for `Mmio` are currently implemented as an extra
set of methods that mirror the ones defined in `Io`, but with the
`_relaxed` suffix.

This makes these methods impossible to use with generic code, which is a
highly plausible proposition now that we have the `Io` trait.

Address this by adding a new `RelaxedMmio` wrapper type for `Mmio` that
provides its own `IoCapable` implementations relying on the relaxed C
accessors. This makes it possible to use relaxed operations on a `Mmio`
simply by wrapping it, and to use `RelaxedMmio` in code generic against
`Io`.

Acked-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io.rs | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index dc894a45bbcc..d5d6e9501453 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -695,3 +695,65 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         call_mmio_write(writeq_relaxed) <- u64
     );
 }
+
+/// [`Mmio`] wrapper using relaxed accessors.
+///
+/// This type provides an implementation of [`Io`] that uses relaxed I/O MMIO operands instead of
+/// the regular ones.
+///
+/// See [`Mmio::relaxed`] for a usage example.
+#[repr(transparent)]
+pub struct RelaxedMmio<const SIZE: usize = 0>(Mmio<SIZE>);
+
+impl<const SIZE: usize> Io for RelaxedMmio<SIZE> {
+    #[inline]
+    fn addr(&self) -> usize {
+        self.0.addr()
+    }
+
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.0.maxsize()
+    }
+}
+
+impl<const SIZE: usize> IoKnownSize for RelaxedMmio<SIZE> {
+    const MIN_SIZE: usize = SIZE;
+}
+
+impl<const SIZE: usize> Mmio<SIZE> {
+    /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
+    ///
+    /// Relaxed accessors do not provide ordering guarantees with respect to DMA or memory accesses
+    /// and can be used when such ordering is not required.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// use kernel::io::{Io, Mmio, RelaxedMmio};
+    ///
+    /// fn do_io(io: &Mmio<0x100>) {
+    ///     // The access is performed using `readl_relaxed` instead of `readl`.
+    ///     let v = io.relaxed().read32(0x10);
+    /// }
+    ///
+    /// ```
+    pub fn relaxed(&self) -> &RelaxedMmio<SIZE> {
+        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `Mmio`, so `Mmio<SIZE>` and
+        // `RelaxedMmio<SIZE>` have identical layout.
+        unsafe { core::mem::transmute(self) }
+    }
+}
+
+// MMIO regions support 8, 16, and 32-bit accesses.
+impl_mmio_io_capable!(RelaxedMmio, u8, readb_relaxed, writeb_relaxed);
+impl_mmio_io_capable!(RelaxedMmio, u16, readw_relaxed, writew_relaxed);
+impl_mmio_io_capable!(RelaxedMmio, u32, readl_relaxed, writel_relaxed);
+// MMIO regions on 64-bit systems also support 64-bit accesses.
+impl_mmio_io_capable!(
+    RelaxedMmio,
+    #[cfg(CONFIG_64BIT)]
+    u64,
+    readq_relaxed,
+    writeq_relaxed
+);

-- 
2.53.0

