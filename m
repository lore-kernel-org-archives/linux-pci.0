Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47B2D46DD;
	Tue, 10 Feb 2026 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743480; cv=fail; b=eK+W1l2P9YEuQt0fDFBpN27+t+7brjrFswV2cJXbhfbpfPq+rrBOqYMeLNC1cHgFeK/06Tc6BbgNZ6LNVGtadffNABctcZtdlcOZWzddqUKb/6Z232olNxMJKItZnqP6hYPj9Q2JiRy77ZRJaYWS8uQ06STquCIrhscFdFjFKVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743480; c=relaxed/simple;
	bh=VFNc+UtqX6Z8SPoBk8sZ8VWXH+VPFJ55q4/SktUapRY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hAwdcXXtbrRtNMtrlmOxZ5Uh5y4LkPt2O1KtWK8J1f5Gh1vQxm2MqmCVqYVYIW1FVTCr456ZxKfM8322EGbZVDPYWBpgV2CpgGQ7UfHAR3n/rzZP4A2Rg+lzfsW3zVBc4hy7XPOXfatujrBJw9QrEBZO4w5gOazQsEZLS6rHlVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bYZgUZxA; arc=fail smtp.client-ip=52.101.56.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bYZgUZxA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS8XQYBSv71K4mjrmZ+J9anOga85NJ2n4K7kTudUAlflfxDOMa8scbvSRGKGWGouQxogC3N7k/1LSdPLSoeWqPO/gJHZOS/4ArCWPnqhtHI+dUlM9VyCygug7Oegmn89vIGDH6kJZFX7umTiU9JX62g7sapPLPCRkn8s2qk+7QIfyTBQ/Svdj0x5OcZGShcFKD43hwvvEqjujYQ/Kd5B3MLkNjfGYDlJSk+74+0DCyaj91S/a3mMjthyiSI9HWlzdRWotLTXnqFSnsVD12OUFIF/LVNQufo9BVpa5ZocK3PGBl69FGftjn2W8DnED2NOC/vhEtpSdai0eTp4zkOpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPESW2kVwQlZRjYaJOpaNxRu8h6FQUXnEm9b3csg5SA=;
 b=wu6+1nmZcQE2w6QZpy/XfqkyLlJchjxkJmztSbmXys7PI+UyedLAlHwJpWPXZaKiBL3w384nz2gi7E17Ny/USaH+kntH9LMyAdw13wFr/TW912zC1Hwpyt5amJ49CFq2vdTlwKLg59TQn4lJGCo9TX8FTRUJvDk89z7cTD/PRuisJVwLtEaUyWPQpdBSFpU7K0swV4S/cWT9ysBfn6S4oSo7PYHdW2WxyMAzyOgnDWxqn5JAayUS1GECrSGcTE38v+D+4JcdecKJvxrEEQQNqEbF6sADAaFdKUXVPWfqCo8W4YBMCE0xYYwYkaEAkqAzkp7DgtwOCbSzVcSCNB5xrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPESW2kVwQlZRjYaJOpaNxRu8h6FQUXnEm9b3csg5SA=;
 b=bYZgUZxAnupSgwV6lyOzX90fhG6kueaqmFP08e28V/eg5smFOPGWBoJ40vnyYHLkNj0YX5WbGDJxJ3HIfam3EHEzjJY3SzacR8sDOxqy1bOJJ9BN1BY4vDDCgkc3do8j9dTf46sklWGajFbsQHNnvmViW2eijeXRM75B1vAmzhDAc9EWWbvXmQ8xg65u0OO2dBdY5nFGM6zuYUjvaRlRbs2HjTopJG8TscgJr6k4hv7PjRettVY/zZn9E5gzlrtkoos6o3N0phph+8n0KT8QsDCXk7FXV2WYiy+NcouA4YyRAxrH1sXe1go27ixqz0EnJgIUJiVRIeuZj6do8z7WhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 17:11:02 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 17:11:02 +0000
Message-ID: <ee886a80-0093-4c35-9701-427c2e166ca8@nvidia.com>
Date: Tue, 10 Feb 2026 17:10:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [V5,03/13] PCI: tegra194: Don't force the device into the D0
 state before L2
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
 <20260208180746.2024338-4-mmaddireddy@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260208180746.2024338-4-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0046.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::8) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6c2a0a-4bfe-43d2-b495-08de68c75dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGg1UkNBQTRoWDRKZm1KRGJiZWVWbWZqQ3dGa0ZPa09ZZDEwdHgvS2NYN0Rl?=
 =?utf-8?B?dE5Yd3hJUXQ0dFRLSFhRVFBiV0lITktIYUkrT3JPRTN1cXhlVzFaOGZlVGh3?=
 =?utf-8?B?L2l5YmJneEtiNzByWTlrbHc1ZGhTcjRqdkpPVWlwaTNTWlVkNEpvS2E1eU4y?=
 =?utf-8?B?eWdxQ0ZzVEN0ZjZXYytJTyt4UWRVQ3BHWHVBemJ2VzIvUUQ5cmJ0QjZrS2dQ?=
 =?utf-8?B?THlFTnBmMW5NNkJ2aWhLd1IvVElTZUlOTzkvZW1NYWtxWCthWTQ1UTdtYmY5?=
 =?utf-8?B?ZGtzMUF1bnE0bjJaVy9sazRjc0Nxc1FiRUJjek5mNXNFbEZ3RDlzRXJ0UkZ2?=
 =?utf-8?B?ay9nakdlaERqOXRVUUpHemV1OUJTNEFoWjZmb0JJS0NaSW5LTmUwNERsNXRh?=
 =?utf-8?B?SlVQeHN1enlGVFJTaXJXRDM1NjJ1WXZIZHQyQVpQUVA0bTR3K1FObjViZDly?=
 =?utf-8?B?M3RFNUtkNDlxWnpScktyNkJOVHF3emVOeTk1a0luNS9IUTN6SGlnWVpITDhX?=
 =?utf-8?B?amR4TU9NOStha25YWDNuc1RLeklKZGJxOHFSZjJIWjZsR3I3WTdpUXJOZ3oy?=
 =?utf-8?B?MFdSL1NFNzJab3YxL0NtOTNGYkpXWUFmN0NuOEoxb3ZYQWJlKzZPcmE4c295?=
 =?utf-8?B?TmNlcEp4YlJmeU1iNlJQWHc2ZmFqT2tVWlNRaHFtNytKM2dNZWdIc3ZQd0M2?=
 =?utf-8?B?NDVBbVZJUGViM3pzUEczOEtIc082QmI2MW8vYWpXR0VNZGg1a1VqZk9jaG9O?=
 =?utf-8?B?NHdlMk5vcXNzVFl5bGFqYm1YVS96WmUyQnF0d2hCODJrajlJZERlakFHYjJW?=
 =?utf-8?B?cDlNUTNsWUlQWU5oeFQ4Zks4cXFNNVJvZzltRjc1VG5BRUtrU09sUGFWOXRS?=
 =?utf-8?B?SXhKUjdVMVI1YmhUdW85bnh2K2RJSEJlWWZ4Mm5HWUw0Y1YxMFZuSG51REtw?=
 =?utf-8?B?cXY0bkh5K0F2MVgzeWlwWG5GNGJab2ZIQ1F2Vy94L2svZ204UlhzVi8vMUJN?=
 =?utf-8?B?RDdVRUc3bzNuWWJsNW4xclRsbFhOTFdlQ09TQnZvWEdqZ3JpSU9rYS9nYmhi?=
 =?utf-8?B?ZVV1Zmx0Z1FKb0lyRVcyaTdpcHkyQ050NXh5K21nbzdteEVKZlF6TWMyczM3?=
 =?utf-8?B?ZTRnVjg5ckJ6bHFpdktwVTVvMW8rNGRqRnJkQXZpc2E4Q3dQUWFVWUg5V1Nm?=
 =?utf-8?B?WGdxeHBndTZEZmVqTFp5UEJMZmlNUUZibGZrWEtHajkrYTVldmduYk94Um95?=
 =?utf-8?B?TXV3MmFOZWh4ZnFtYkxHV2trMDRnQmNtL2ZOZjFnaTRMYXVsUTlTOTVqcXZY?=
 =?utf-8?B?c29IV3Q2dEg5d3VmbXpRZGd5WDZQM3FQWWFVNFFRci9YNGJiZk80b1RhaHIy?=
 =?utf-8?B?NUNFcDMwWGdlUUNzWjdtWGYzRWhCMGVTclAxbS8zUnB2djRIMkNEbzF4SFV6?=
 =?utf-8?B?dG1RTHVRQVpXMHkreWVKdEs3M2gyRUlFamF2WlR4WCtLNVEya2RyU1pxZStX?=
 =?utf-8?B?S1NFMTFxRTFERmhjTXduSURURFFMOEJJcnhRbWpraHFtVzBya3ZWS2wraXJ6?=
 =?utf-8?B?d0lycDd5S2Z2ZXpVUkIvd25kU25rVGMxTU9PQUZKeHhBTm0wK2lqdzBtN1or?=
 =?utf-8?B?eHNKTkZEdWxQeEdaMkRMQk1xL2wrRVY5QjJUWWR5ZmRhSnR2dVhBb0lRd1Bi?=
 =?utf-8?B?dVhtcVdUbmNtMllhYU9RQWg3bWNmRE0zWklmK0t2cFFYM1RybVZ6M2lhaUpO?=
 =?utf-8?B?b2lBaTNIRTFCTXZaTUJRRGp2ZUh0ZG42VTJxRTlVOHIyUC9qR09YMWZyUTVW?=
 =?utf-8?B?dk1hSGNkNGVlOFZjaFl4bi8yNHdUbnZCVnVxamV1Y2NmdTVoYnRvUnl4UU5V?=
 =?utf-8?B?RlR3YlhzajhpYUFhMDNYcHpZVzZ1a0JtdHJlVVZ3QUtHZTZQNk9FL21JbVEr?=
 =?utf-8?B?NGFiVUZBUVZocjRVbVRCdlRiOTU3YnlIWUhXdFZuandXK1lLKzlmSVgrU3Zl?=
 =?utf-8?B?YStuRHQ3MUFuZ0duUnRqZ0FRZUxJd0xIbCtWeDRDUUx6d1Ezd2M0MnFMSjlu?=
 =?utf-8?B?QzFoZ29UNDM5UEZQNTFHMmZ4bEFZNjRhY0JVcEJmNklXOFA1MmFCQXRlQTcv?=
 =?utf-8?B?VktJL2x1UXYzRG04ZFk2L3JoV3VMSnFEd2hFWENoMXpaWFFydkVVWThJQnNK?=
 =?utf-8?B?Y3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFlVd2szQmVPZHkyUUVlOWN3T2pjUEZLQUdDQTJLbTl1aU5JSkN4UUdkeXFs?=
 =?utf-8?B?M1BOanExYTYvdkNwSUsrNkJ4TWp4UnBhakc5MFEvMVdrVG1VTlp3OCtqYkRY?=
 =?utf-8?B?SFNqZndXMmFyeGFnSXhLajV2NFVjaVBSZElJYXk2WGwzTXBTU0p4cVh5c2VJ?=
 =?utf-8?B?ZFNaenRmUVBWbjJHNGloTnVJRjhtTjVCQ1BkdUZRQ0szQzR3OGF6VjlXUFRT?=
 =?utf-8?B?TWF2cHl0Tk50Sk9Mc2RtTkNOdDhLRzcxcGtlNUVsb0NiaTMrT3R6SmZIZEMr?=
 =?utf-8?B?eE03VnUyRHBBVk9XdkhMRUhFY1FCcGZCUWo1bEx1SE1zYkIvME5rK2RMNkhu?=
 =?utf-8?B?U3NiTEQxdmQwalRBYURZaXdsd2phL1A5N1czRERjQmZNUjUwbWJyZVJyVGhl?=
 =?utf-8?B?UCtuK3BIYytHRFFSUDRCVkhFV1pKV3JuQnVpY1RJWVhiZHNTYVlVcSt3bzdR?=
 =?utf-8?B?enNzMUwwZXBER1dIcVgwTjB0WmRHV2JHZ215S1hXcmp4K0RscmV2d3JGbVFl?=
 =?utf-8?B?c2thTUh3cUhNbUFoRnR4a0prdzhxc3dWenpoSDNIM01zME9CRWZwc3IyWHoz?=
 =?utf-8?B?L3dXT2xERG44SEhqYUw4dXcveDB0SDk4d0VlOVB5a29WTHhVakNNb3BrdTJG?=
 =?utf-8?B?S2h1NjlvYWhPQ2NjNmUxOGxxbkJFZHlhdi94QWZvM3NxdU5ZdFowWi9mNTdW?=
 =?utf-8?B?ZnVuSDI0RGtMNTB5SHlXM2JHelR6aVVMVjFiMXJzdmQ1akI0WGZsTGZqTVRO?=
 =?utf-8?B?Q3dHOG44YzFmdFNxVlU4UFBxNk80YzhVYllIVkIwQjByY3BZalJSYVFSdzdM?=
 =?utf-8?B?RFhYcWhOcFdVMW9pR2RWSlFmOFpkWCtnMGFEd1hpeVgraUxaWnhjeEgxY2NR?=
 =?utf-8?B?RWIyVjdNL0tJcytTMEF5QWQ3K3lsK1J5N1dyOGJyNXh6RDdBOGN5aEprbFVQ?=
 =?utf-8?B?dHhBdzR3bVZuNjRaUzdBbmVaMFpFc3Npem1OQjRQSEJ5NDFGcU9zNFRTYnp5?=
 =?utf-8?B?bW1BRnJselNldWxjOTdvaXV4YTZla1pSKzZtOVI2TSszaUN3eG9LVmpnd1pp?=
 =?utf-8?B?cHZ1aFVFWThvQlVlN3E3cUxWd0x1aXlOQVRTVzhIQi8yd3hFd1FKQlh6RUpy?=
 =?utf-8?B?NzdWbEVkZWtheVpWQzlxYThVTEgva0ExNjBzalM1SWk2RmV3Z2xsa3N1K2Iw?=
 =?utf-8?B?MnVBS0N5ek56dUxmMmxSNEdjNHBjNnZlVGxGOGR3MTNVWXQrNmczNERLTDkv?=
 =?utf-8?B?eFlYTm01VU5MMVlkWkYwV3RPd0RkY3dMTjUvanZ5VWE2L0ZnTkZpdkFTUjY4?=
 =?utf-8?B?N2pCNlZTQjhvM09FY0NveklKQzV0UVB4ZENUZytYRXBUTmF5T3NvdG1Fc0ZQ?=
 =?utf-8?B?T2drTlo0bkE0eDRKTXE2ZThaeE9IZDZmYmk1ZUlrNmFJYi90NHdROGdxMjFn?=
 =?utf-8?B?NkcvQzJCcnpKWXc4WFdDd2kyaTgvTDk0bVhPV1hWUGlrc0dLZ0x3eHc3a1BN?=
 =?utf-8?B?ajJuYW5pS2tPRW1ibWtQclI1TGxoU1UwNlNybFhlWEJzcVcvYXNPUzBNSHRw?=
 =?utf-8?B?ZFBla0FyRUMxSXQ0Q2FjZ0s4WFpPMzBOT01Fc2N5TEoxVkZMWTJId1VSMS8v?=
 =?utf-8?B?c1BzSUdkdlhXNkxMQXF4SC93Vk5UQlpQeVhHdW5mUnBXWnh3UFZCbTBZWTdW?=
 =?utf-8?B?bm1EL0FKcTViT25jQTJRbGRQZHJmZ3dMVnpKdlBIMW1HRUtTeW92eldxQTdl?=
 =?utf-8?B?SWxVOG52QmFzK3lvODF1MXFtaUFnSHhZamtGdXR6Ry9HMjlkT09scTZ3ZnJC?=
 =?utf-8?B?R3hZVnhOQXJpOEQ1OG9jRENoWm9saE5GbStBUlRJTXJqQW1sSVR4aGxFdlBp?=
 =?utf-8?B?NnNQVmQ5Q250elNLOEhlQ0VHbHE4V0x1ZmM1REgrNGlYNFdwcnRjdEV2VUFR?=
 =?utf-8?B?S2V5czhsTzVwQ1RqSTFaemN5M0lsakdwNXVjMTNkWmZKOGVtNjd1QkJ2d3Y0?=
 =?utf-8?B?V1BaTlk3VWVadDZUako4UXdmalpqb2VoQlM1bk4wYk5FYnhXZnUrNnNMTmdj?=
 =?utf-8?B?SzZrWG02Y3lUMEpVTTZ3emZrMlY3M21Yd0o2bk5aS0pxMHRkRjJUL2dmeUpV?=
 =?utf-8?B?eDQ2UmN2dWVPRkp4OWpYWENoaUtvaitORExPOVZTZktWRTRiNVhMQm10Z201?=
 =?utf-8?B?bllTYnI0YStjVlBkamU0T2NjeFZNU0RKOVZQalVWak0yRFIxQWt3TnhoV1VJ?=
 =?utf-8?B?alc2NEtYTzBwQ0VOM28wZjBpdGVHb0NlODZNRkRsUWdtNGNzL0c3NWhGTCtH?=
 =?utf-8?B?dFA5anJUWEtTckdvc3pSOXNJbzdOM2RRK3dQaXJhU05IamlWY0JZdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6c2a0a-4bfe-43d2-b495-08de68c75dff
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 17:11:01.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXgShCxCY2o+sz/YtxCxFQCiH0+p88nWax+o5hGD5g/3dcolbMtEYMC5jMoDm0Y/nzN3voXqKi/gllQkxsXPfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037


On 08/02/2026 18:07, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> As per PCIe CEM spec rev 4.0 ver 1.0 sec 2.3, the PCIe endpoint device
> should be in D3 state to assert wake# pin. This takes precedence over PCI
> Express Base r4.0 v1.0 September 27-2017, 5.2 Link State Power Management
> which states that the device can be put into D0 state before taking the
> link to L2 state. So, to enable the wake functionality for endpoints, do
> not force the devices to D0 state before taking the link to L2 state.
> There is no functional issue with the endpoints where the link doesn't go
> into L2 state (the reason why the earlier change was made in the first
> place) as the root port proceeds with the usual flow post PME timeout.
> 
> Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V5:
> * None
> 
> V4:
> * None
> 
> V3:
> * None
> 
> V2:
> * None

For future reference, you can always just say ...

Changes V1 -> V5: None

Jon
