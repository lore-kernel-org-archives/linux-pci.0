Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427C1C4A20;
	Tue, 17 Feb 2026 06:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771308526; cv=fail; b=ZPYYfPLTjokloWELW5lD6YxPR/DfBFufhK3DZq5cOtwwvBUpw4Cz1qRKgQ/zIsU6vz/VxoEIFk1Hz+S6+dK+DC7s/8nWTSzQTvmUkriVwzcDRo8/5nuabYTw7ZvNHzby6r3Jiv3RvchQppFTSS0Ez5dEZ76OJG+VA3NFFbbaQp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771308526; c=relaxed/simple;
	bh=X1CcA0p8i4pBANwGcSrMc3ivmi0L9w/dwBXNYdb2n0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=utpb3r5lkBM+0i+qFdJ0e4jkG3NZ+8xw/opHlDeVh6JqaDU4Xr5P0qcHCTuKVCk2jyxjtp7pOd27316zx3fKdVjSFlLQyFS1WWCsxI0FWNAj80xPzExrAYmm8Nzr/JV+RSI7lK25P1CWLUMIuNSkb3UcdbQiO6wJdLmgHpY7aKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mXB7iPUH; arc=fail smtp.client-ip=40.107.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mXB7iPUH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Txj4DtoqDeteCMV+DglVrgZd1yjT/YjISG6GROqXhhAdrfmUcBWte8eCdtG05FSPqGLW6AjiL5qAVPTz/ODlwtk+J1UzJTfIaUK9E1VrGcJ9QsElGj3UBlAX+zukrUMRHdEJy8iuuQJkAQXFOij8JvqVXGNShEDC/GezvcjNu3yT1gnUIEWp9Fc6i6J/5qAGW6U+1IueVVrfA/cqq7w0HDV+07S9MJ18+xf6eHTbSTBXnlntNWIKa/dX2mkKINeQSRznpW/HHC8fB1XU/YSFZbejdzSyvSRfK95Gab19XqMPTsMfpjdqiwlHVoo40n5ktLnx09zPAXtMMEcZEpCG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22BZAaAXtjs4tnrP7Th0cxomDG5K7VqGOYrIp0kXfN0=;
 b=yNg1E0xr32ulapDbYTUOgwkEwYxibi2QFYrCGZcCgiuVfwInVqlQEZm8vErsm2XrpoFJHkrP6Xc9eb6g2ai8w2NiBqj+m4TfVcL918zA19kZM0NJQhVE5vNK93FFKkRmJmxkxChCGdHZjP+yWpZ6sr/AWd+mqLNvAW67aDqrQzKQBJUyiR+RU65obK3vC5R99FJ24m6RqA2hzEjXjg/+b5Tlt2b87fFKRuh9anhc30zZdN6gHfSeOAeolNM0EG2uZq8dHjAVYZEfZtMyNh2941T8gDD2ptjBMjtu3K4Z2J6pIOw68jZ39X9CclGaJRugFRoqauTRUAu15Ctr6c6imw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22BZAaAXtjs4tnrP7Th0cxomDG5K7VqGOYrIp0kXfN0=;
 b=mXB7iPUHHlLzWPFIZ2hp7gXoQ6QslPQo2dst70Q+PH9Z1rSaGdpnmouuQ3nHXuOxvtJRYoF3QUIMVbkXYl9F3bKM3lGBvk8QeD0exYDQsNUBV/QPJF6vXrscQ/++kJd4r+W//+0BpUdvEFcDmpWTFClfxIm9RYXfc6x42eKlgBPj1ZVPN/nQHjfchAvbETZl18VC8ECr9KtqKbI5JKhLw3O0lefpdP3zZCk0ZjKb+3Jh0maFFEv9XvN7enBkidnrw44Hke6wrIwIYLjuEyFUD97WplXJg+cL2nPyoLW0dTorqqd3lXyQs8+21tb5A3xhMrUqql6FTXrQKZB6hGsXpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 SA1PR12MB8919.namprd12.prod.outlook.com (2603:10b6:806:38e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.16; Tue, 17 Feb 2026 06:08:40 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 06:08:40 +0000
Message-ID: <291dab65-3fa6-4fc8-90a2-4ad608ca015c@nvidia.com>
Date: Tue, 17 Feb 2026 11:38:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] PCI: endpoint: Add BAR_DISABLED support to PCI
 endpoint framework
To: Niklas Cassel <cassel@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260217-master-v1-0-727e26cdfaf5@nvidia.com>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260217-master-v1-0-727e26cdfaf5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::9) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|SA1PR12MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 338a2a34-4a4b-439e-e4ab-08de6deaff0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3FZa2VhcHZHMm1CUHlrZFlaeTlKcmxFQzdaeUZHWTlQY0o1dmhOWnhHWkhp?=
 =?utf-8?B?dUQzdG9Kc1NmWDdBSEtweGtZaEhDM25GYldlMVNXS2VVNVFVNEtnTUZVWEg3?=
 =?utf-8?B?eGczTHlxM285b3UvK1ZITENzcmphcURSb0hEeEFNOCs4citvUzVpc2VTUUR2?=
 =?utf-8?B?d0VLb1M3ZzZTNWtFNUxpcE9xU21XZnBwZWNPcFd1aEVXNTFpbjNMV0ZyZ2xD?=
 =?utf-8?B?RzMxcm4vNE13RWpoSlh1RDIvVWRkT2cvTndrUGd4d2RybG42ZWNaS00rM1F4?=
 =?utf-8?B?cTF3a1kxZnRIb25RRE9yb1AzTFZid09PWlN6OHZDUlpKbWc4WkhuaUI2NGNm?=
 =?utf-8?B?a2wzTC9vVXVrY1ZIRzlBMnN4U29CRXNMMWlBUzhWTnlQeU9RK24xWFNrWFFj?=
 =?utf-8?B?dGRadTlIVmRyVzZVMGc5alRPcWJtRzlMYTBGZTFtaWZpTmlEM2VycUxFUWV3?=
 =?utf-8?B?Q0dGWktSNEFjVStPdEh6WDZmZHlzQXZ4U21kUEJvbytWODhFMHkzVnJCb285?=
 =?utf-8?B?ODU2bnh1SUVTdjRtdWJIQUZ5VGZwZndvRysvWmM0TTNBUmlWM2RpYW1KSmJM?=
 =?utf-8?B?c3h5ZWFDN1J5MFltbUNwOHdlSk1aVkc1elZCS2JMY1FVYmY4eG5zNkNDdjdO?=
 =?utf-8?B?ZXJsUlJWam05YzJVZjNjalIxcG91SmhoSXAxSURzWU51SlUzRVNJTVRjYUxV?=
 =?utf-8?B?VEZwT3FuTUM0d1VnWG1NcXhGdWVUb2liSzFLbWN0K1pQTktISWlBTXpsa1pJ?=
 =?utf-8?B?V2F4THRvZStTVDN0MFZRamhleVZCbjNlNEUvc3dwOTZuQUdYbXpBNU5GZG0y?=
 =?utf-8?B?Nm5RRWZRWHR6cjZ2ZUNEY3RkR0hkQ1I2YVFQdGJ0L0FZMzNJc21oMHRlNzBH?=
 =?utf-8?B?N0JUMXlnMG40ZXpYbEMwbFl2WXhRRVdZMzhDNlJ0dmFBZERZYlNjWThHaytZ?=
 =?utf-8?B?NGN4VzBFZUE2RXA3NVd6aHlQVVg0dmw4cW1rVVBLZytOaXk5eENFbG9uNjBp?=
 =?utf-8?B?VUNtbkJ1VlFHeTl5REYzYlAycEhVbjFRUjl6U1g1WXRVMEVVWlk2T2dEZFJn?=
 =?utf-8?B?TnpRelcyZjlpYVR0d1RYMWdsZGxENWZNYXhvQWZkOVVaOS9YL0tjL2dqLzVO?=
 =?utf-8?B?RnJHVDk5ZnB4cklDRFcyYktxMng4TXZtWlZpdXAybTdoaEpraUxjNnBBOFlr?=
 =?utf-8?B?SSt1RnJmWFRMcVhyemx6U0FzUG1Sa0xHRzhaUnFtQmZXaDF0dHhVL3grTUVF?=
 =?utf-8?B?QWlBV3lvVGI0WElsekVhZ2tJM3VmUHVnVGJmMUF2M0c2djBnMndlUGlmeXBp?=
 =?utf-8?B?dkhwWDVRT3o4YS9HOVdwNDhGRVJUSmdIR2FiMjU3RUhpZkNrbFA2UTJ3NE4r?=
 =?utf-8?B?NC83M25xS3VIRTdSVDNzT2F6OHVwY3hPNjNMM29oMmUrVGQxNXRCR3Noa2J6?=
 =?utf-8?B?c1BCeDFnbmg1b3lGcy9HSTVudGlwbmRQSWNmQTlPTTFHVW80cjhNRnMxeWpy?=
 =?utf-8?B?blU3dWlDSEN0Y3JQNTc1T3lPR1ZRTWhTTkNhYTRNc3AwTGxWZ2d0MjI1QjZS?=
 =?utf-8?B?TWM1ZVEyeFNkYW1RVFZkMmxhcEZTa1RHdkpQcjFsMUpOL0xYM0NYdDh5Nzda?=
 =?utf-8?B?QlZMcmFwOXJnbzl0TGQ3U01pWHVBeWlhcjAvWmtlNXgxa1JKR0ZFM05PSmVt?=
 =?utf-8?B?d202cDBZNVhrUVlXSTl5dkVUS1RtWDFBaUYvRS9WbzA3UmtxVjBJUEdLLzVU?=
 =?utf-8?B?ZkFHRmVnZ2Q4Q1hhRGRlQjVBL3VKR2phT0dsSkdLYm52OWJYNXNESUZReVlV?=
 =?utf-8?B?MXRsY0JVOWJiUWx6T0RPclY1cFoyelB1eGJtUWZaZ1JWVEErTkxOYTd4UlhE?=
 =?utf-8?B?QVJyclhLcjdIcXZwSUNidkhGZ2c1czZTMTFWWUpRVjFEV0hYRG1XYXZJUHZn?=
 =?utf-8?B?VWwyTXZsQjlaQ3lDL2VJa3hmOEFNeFJzNzBsQWpmTmFCckR2cGFpeXFqWHZ0?=
 =?utf-8?B?RWx5M0loSURRMGVMUVhweTJjYkFVWSt1M1hQUGk5VEd2Y0wvakpvUSt0UEV6?=
 =?utf-8?B?Q1JQbWxDUFp3UGpKZ29MdFR6RU05TkQ2aGZKYmNRc0hPdWVObC9KeGVIdHMr?=
 =?utf-8?B?RnlUaUk3enhnbmxQbEtQR0UwMFVZdmIvK2J2QjFJeVdVUVNnY01NNytDQWNE?=
 =?utf-8?B?MWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L215RFhSMmNuUWRqSnR6KytVTmxvM0RtNVV3dGdTNFM5K2drYXJydkxVSThp?=
 =?utf-8?B?MlhnQ29MSVd3RzNWVGJGQ25wQmtyMHdMdFRPbVhiVFFlaU52RExBZU0xQkpw?=
 =?utf-8?B?eVNHOThicC9lQndEQmExMWUvcGFHZzE0SlZpMHZHakRpNDNzdkxzUW9qVnNF?=
 =?utf-8?B?eDJJdnlMTnd5MVZUdWt3dFMyVjd0T2ZsOG1NaDl1UVlMREtkamdEcFp5RGsz?=
 =?utf-8?B?N0c5RXZ4OHZ5dzF3aUJBL01IY0xoRHJBSHp5MlBXUTE0aG1uK3YzdVpBMzhT?=
 =?utf-8?B?Tlc1Vk56a0RIOGtoUWhhTFJUQmdkS2hod2NHN3Z1MGxLMk45ZDhxbVBNTG15?=
 =?utf-8?B?Wkk4TGU5NVQzR2Npa2JicExGek1mMndDUEd4TTBNWjZBUFhDUnhuZGRqVU95?=
 =?utf-8?B?Q0wyWnBNMCtwQSt0OGU5Y2wzTGN3T1plSUMwS0N5TTlJNlQ3bDZQMGlWbHJz?=
 =?utf-8?B?bGlyMzlVQkt4UmhRTCsyZGpxbXN3WUNITks4MURObVZsVUFNaVVQYjlHaVd1?=
 =?utf-8?B?NEZoR0FhMThDVEJ2K1ZKMndZTmNxV3NBK2NnQ2RTbW02ZGk5Nkd0SGhQSWxw?=
 =?utf-8?B?M3NrYjhQaVNpOHErQXZEbXdRaUpYaFlUTWRnMUhHcUF4N28wSG5QNitJaVJQ?=
 =?utf-8?B?SlA5d0ozNUszZTdaRUxueHdaR2cvQ3lYUVF0V0pBeUVoVHJVVitxQWwwVHA2?=
 =?utf-8?B?QXM3Zy9TUy9TS1ZDQTBmRmRNYndra240QTFUK0FzVHVvZjYvOGc3ZzFWUWpM?=
 =?utf-8?B?SkY1QTJKV2JmM2NieXhJWGxZOURWTkdYY3k5RW9WLzVQNVFsc3JjZmhSNXhu?=
 =?utf-8?B?SW82UHpaZkxYYWdQam5ram42cFh6VElMcXEzd2I1YStFWmgzZmczREpYbDZm?=
 =?utf-8?B?aEoxZ2IzcG84NzVSeVlPalFRS2UzRE5rRU9YZVl2YTRFWmVxYU1zN29GVjBK?=
 =?utf-8?B?WE1vdEZVU0ZnUjBBQWsrcllocmFZUysxMkZEZDVUS2c1NU91cFdiKzYvc3RE?=
 =?utf-8?B?YkZhRnpkRWF3MjJON0grNDBCS0ZKeGZnQWtPYzZqb3h4S1BXMVNPWjU5S2l4?=
 =?utf-8?B?ekZwYUNPY0hqMlE1d280aW9LMDl1bnVJUC8yL29BQ240NzBUTk10OTZZM3ox?=
 =?utf-8?B?UWhIWHNmQ2hncVl2S3pGOVhlZmlaWkh0eGJpdVkxaEV1K0lyQU9tOVc4SVhz?=
 =?utf-8?B?ZDRqaEFmZktPU3IzN0NEVTlBbWluMkxWV0N3bll6Ris2RTlFTGxkT3NVdlBm?=
 =?utf-8?B?UEJ5ZThnZ0hPV1V6TDR5cy8zZ0JwekFoMisxRDJ1VlpOV09WT3VHK0VIQ29C?=
 =?utf-8?B?YlQ4MHlDb3RkTmNpSy9MRmtIaUwrZm1CVm9WSFAxUXBGbUVGQmJKOEl0NUpY?=
 =?utf-8?B?elNZNG5Da2dpMmJpSm9tT0kvNmtYN0t1dnBEdm1SdDJqRTJvbWRnSE9tQ3hE?=
 =?utf-8?B?OUxhWFRmYWF6NUdJZnMybHp2RTI1SUtEL3Q1Vlp2VTc5WktjMlhpTnBiZWdt?=
 =?utf-8?B?Rm5tSXVNdmxSVFQyMnNRWDJ5T0tyeXRMbVNqd0VuaXd1bUExekZOUzlFa0RJ?=
 =?utf-8?B?eU8yVHFOSmZLbkNUa2kraG9SQlEzbUlrQWkxQXJyaVdRcW95Ym1BdTY2dDZp?=
 =?utf-8?B?QzZoSlBJc285Qk42ZWRBb1pFbUk5d1lvKzhIWGdUMVRxSSs3QUhMb2gvL0xJ?=
 =?utf-8?B?RFFqd1dtZVNLbEVDNGpBRVlTa0JXdUl4aDZQVnVXcGxtOUhUb0IyZnZDbUox?=
 =?utf-8?B?bUphK2FqSHByTWpRMUFFUnViTE0xT2xvL0JIZ1k5cDJxZ2l0VjFGWDJ1OVQ1?=
 =?utf-8?B?WnpVNzY5WDlTck1TNzlreDY0ZUwyTFpvWmVGZE56OUQ3TTQ5dk02bDREOHZ2?=
 =?utf-8?B?c29CYW1jVnBRUTlvWU9sc2l6T0tidWZhOUlTSTNRc3dDNWpuUS9ZMERXQksx?=
 =?utf-8?B?NnlXT1QxUkE2anBHN3JBbWJod3B5VDgvbThvaVdDaXh3TzgrdDRIVTNCTmdO?=
 =?utf-8?B?bk9GL3gwcnhqdlNISkhXM0tzUXovL2I0c2JEWC94VyswSVRwV093bXpyMWhG?=
 =?utf-8?B?OGVQQ3VjcmhWd0VERnhySVlSV3Fack1sZ3dHYy9MZzJqSWJsSzkwSTlNSnJ1?=
 =?utf-8?B?dXdhaFg2ZmtYdHpwaHRmNlZydk5pd202SGkvRUZGakZTR0E2NFpycXRzdXg2?=
 =?utf-8?B?aUlpM2V5T0FQSGN2YXNxRlJ5cml4TzA3VFhKTE9CaDdtYm1CTkxxT3FTY1Fm?=
 =?utf-8?B?djNOVGZ6ZmMrNWV2VnZaOGJuSHc3a3NEeHAvTzJVRUJvOTNuOVdvSkMxWkNZ?=
 =?utf-8?B?Q0lySjNRV2pRK1BMZjMxSDVCdHVZb3V4TUtaeU4rVk1jMEQ5ZDJ2QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338a2a34-4a4b-439e-e4ab-08de6deaff0a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 06:08:40.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+UaEUMHslZvg6rxKbegkDsP4xh9zkNpsSqh6/t2xPKMRZ+wNPG059x1mX9WAyW35oRsdHK118cmyYFhWCq/+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8919

Apologies for sending the email twice. The mailing lists in CC were 
missing in the
first email. I’ve added them and resent it.


Thanks,
Manikanta


On 17/02/26 11:24 am, Manikanta Maddireddy wrote:
> When Tegra194 runs in PCIe endpoint mode, BAR1–BAR5 are marked BAR_RESERVED so the
> EPF does not allocate backing memory. The host-side pci_endpoint_test driver
> still ioremaps all enabled BARs and runs BAR read/write tests on them. Writing to
> BAR2 (MSI-X table) or BAR4 (DMA registers) corrupts controller state and breaks
> CONSECUTIVE_BAR_TEST. A prior fix reset all BARs in the EPC .init(), so only
> BAR0 was visible to the host—tests passed but 64-bit BAR 2 and BAR 4 were no
> longer available for real use (e.g. host DMA via BAR4).
>
> This series addresses that by:
>
> 1) Adding BAR_DISABLED and clarifying BAR_RESERVED in the PCI endpoint core.
>     BAR_RESERVED is used for (a) HW-backed BARs (MSI-X, DMA) that the EPC may
>     leave enabled, and (b) the second register of a 64-bit BAR. BAR_DISABLED is
>     for unused BARs that the EPC must disable in .init() and the EPF must not
>     use. pci_epc_get_next_free_bar() treats both as not free.
>
> 2) Updating Tegra194 endpoint to use three 64-bit BARs at indices 0, 2, and 4:
>     BAR0+BAR1 for EPF test/data, BAR2+BAR3 for MSI-X table, BAR4+BAR5 for DMA.
>     Only BAR0 and BAR1 are reset in .init(); BAR2/BAR3 and BAR4/BAR5 stay
>     enabled so the host can use MSI-X and DMA.
>
> 3) Adding a BAR skip mask to pci_endpoint_test so endpoints can skip the
>     destructive BAR test on HW-backed BARs. Tegra EP test data skips BAR1–BAR5
>     (test only BAR0). Adding NVIDIA Tegra194 EP (0x1AD4) and Tegra234 EP (0x229B)
>     to the pci_endpoint_test_tbl so the host driver can bind and run tests
>     without corrupting MSI-X or DMA registers.
>
> 4) Converting unused BAR_RESERVED to BAR_DISABLED in the Uniphier Pro5 endpoint
>     (BAR4 and BAR5); BAR1 and BAR3 remain BAR_RESERVED as the high halves of
>     64-bit BAR0 and BAR2.
>
> With this, CONSECUTIVE_BAR_TEST and DMA tests pass while Tegra194 keeps 64-bit
> BAR 2 (MSI-X) and BAR 4 (DMA) enabled for host use.
>
> pci_endpoint_test results on Tegra234 SoC,
>
> $ ./pci_endpoint_test -f pci_ep_bar -f pci_ep_basic -v memcpy -T COPY_TEST -V dma
> TAP version 13
> 1..13
>   Starting 13 tests from 8 test cases.
>    RUN           pci_ep_bar.BAR0.BAR_TEST ...
>              OK  pci_ep_bar.BAR0.BAR_TEST
> ok 1 pci_ep_bar.BAR0.BAR_TEST
>    RUN           pci_ep_bar.BAR1.BAR_TEST ...
>              OK  pci_ep_bar.BAR1.BAR_TEST
> ok 2 pci_ep_bar.BAR1.BAR_TEST
>    RUN           pci_ep_bar.BAR2.BAR_TEST ...
>              OK  pci_ep_bar.BAR2.BAR_TEST
> ok 3 pci_ep_bar.BAR2.BAR_TEST
>    RUN           pci_ep_bar.BAR3.BAR_TEST ...
>              OK  pci_ep_bar.BAR3.BAR_TEST
> ok 4 pci_ep_bar.BAR3.BAR_TEST
>    RUN           pci_ep_bar.BAR4.BAR_TEST ...
>              OK  pci_ep_bar.BAR4.BAR_TEST
> ok 5 pci_ep_bar.BAR4.BAR_TEST
>    RUN           pci_ep_bar.BAR5.BAR_TEST ...
>              OK  pci_ep_bar.BAR5.BAR_TEST
> ok 6 pci_ep_bar.BAR5.BAR_TEST
>    RUN           pci_ep_basic.CONSECUTIVE_BAR_TEST ...
>              OK  pci_ep_basic.CONSECUTIVE_BAR_TEST
> ok 7 pci_ep_basic.CONSECUTIVE_BAR_TEST
>    RUN           pci_ep_basic.LEGACY_IRQ_TEST ...
>              OK  pci_ep_basic.LEGACY_IRQ_TEST
> ok 8 pci_ep_basic.LEGACY_IRQ_TEST
>    RUN           pci_ep_basic.MSI_TEST ...
>        SKIP      MSI17 is disabled
>              OK  pci_ep_basic.MSI_TEST
> ok 9 pci_ep_basic.MSI_TEST # SKIP MSI17 is disabled
>    RUN           pci_ep_basic.MSIX_TEST ...
>   pci_endpoint_test.c:144:MSIX_TEST:Expected 0 (0) == ret (-5)
>   pci_endpoint_test.c:144:MSIX_TEST:Test failed for MSI-X1
>   pci_endpoint_test.c:144:MSIX_TEST:Expected 0 (0) == ret (-5)
>   pci_endpoint_test.c:144:MSIX_TEST:Test failed for MSI-X2
>   pci_endpoint_test.c:144:MSIX_TEST:Expected 0 (0) == ret (-5)
>   pci_endpoint_test.c:144:MSIX_TEST:Test failed for MSI-X3
>   pci_endpoint_test.c:144:MSIX_TEST:Expected 0 (0) == ret (-5)
>   pci_endpoint_test.c:144:MSIX_TEST:Test failed for MSI-X4
>   pci_endpoint_test.c:144:MSIX_TEST:Expected 0 (0) == ret (-5)
>   pci_endpoint_test.c:144:MSIX_TEST:Test failed for MSI-X5
>   pci_endpoint_test.c:144:MSIX_TEST:Expected 0 (0) == ret (-5)
>   pci_endpoint_test.c:144:MSIX_TEST:Test failed for MSI-X6
>   pci_endpoint_test.c:144:MSIX_TEST:Expected 0 (0) == ret (-5)
>   pci_endpoint_test.c:144:MSIX_TEST:Test failed for MSI-X7
>   pci_endpoint_test.c:144:MSIX_TEST:Expected 0 (0) == ret (-5)
>   pci_endpoint_test.c:144:MSIX_TEST:Test failed for MSI-X8
>        SKIP      MSI-X9 is disabled
>              OK  pci_ep_basic.MSIX_TEST
> ok 10 pci_ep_basic.MSIX_TEST # SKIP MSI-X9 is disabled
>    RUN           pci_ep_data_transfer.memcpy.READ_TEST ...
>              OK  pci_ep_data_transfer.memcpy.READ_TEST
> ok 11 pci_ep_data_transfer.memcpy.READ_TEST
>    RUN           pci_ep_data_transfer.memcpy.WRITE_TEST ...
>              OK  pci_ep_data_transfer.memcpy.WRITE_TEST
> ok 12 pci_ep_data_transfer.memcpy.WRITE_TEST
>    RUN           pci_ep_data_transfer.memcpy.COPY_TEST ...
>              OK  pci_ep_data_transfer.memcpy.COPY_TEST
> ok 13 pci_ep_data_transfer.memcpy.COPY_TEST
>   PASSED: 13 / 13 tests passed.
>   2 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
>   Totals: pass:11 fail:0 xfail:0 xpass:0 skip:2 error:0
>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Manikanta Maddireddy (4):
>        PCI: endpoint: Add BAR_DISABLED and document BAR_RESERVED semantics
>        PCI: tegra194: Use 64-bit BAR layout and reset only first BAR in EP mode
>        misc: pci_endpoint_test: Add BAR skip mask and NVIDIA Tegra EP device IDs
>        PCI: uniphier-ep: Convert unused BAR_RESERVED to BAR_DISABLED for Pro5
>
>   drivers/misc/pci_endpoint_test.c              | 34 ++++++++++++++++++++++++---
>   drivers/pci/controller/dwc/pcie-tegra194.c    | 26 +++++++++++---------
>   drivers/pci/controller/dwc/pcie-uniphier-ep.c |  8 +++----
>   drivers/pci/endpoint/pci-epc-core.c           |  5 ++--
>   include/linux/pci-epc.h                       | 13 ++++++++--
>   5 files changed, 64 insertions(+), 22 deletions(-)
> ---
> base-commit: 6f54fb70124423ec417b5efe81f8ced5b9891d62
> change-id: 20260217-master-27db95eb02bd
>
> Best regards,
