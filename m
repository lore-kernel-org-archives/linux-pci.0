Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A27367F33;
	Mon,  2 Feb 2026 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038893; cv=fail; b=Y8kC/MBe57yqSG8lkPZ2MixMZ7aQp/H6SSipsgcKk6xr0shdXTF66eFlBS08XPGjKGgEzp71QEMmyfVx7oEUakTpHNup2ZXqijqk069vcZpAWcAfDVYSrHmKc1WyjAgWyd6KAT76X7r3xJ8kPZliFPbun1uii0UQDnKC6L6Gjj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038893; c=relaxed/simple;
	bh=z6+NENzv/pSejZBqkpXzlfOJIktjqHjc3r9oUMiPsqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dZpBxGmC4LT2ANp/nRXehD9g3DaaifK7nI3jXuvFiKOubdgTDkBv0t9HYKJ9lULpehzS1K4ruVLwsBSsvL/RDVj/X1y6A5wqlFeeCq0GOZ0ko8dLAouy1FJrUDvbzwNez5dILpvep/njudZsTs/WrfQqTb52TmlRrfUDX7q2a/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YjePYNpI; arc=fail smtp.client-ip=40.107.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YjePYNpI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+aXBKtJkd0fICXhNZydDzMwiDD9SVoaJAKkBcE1xpbl6C/L2mEIdCMuiUiJWcIU2eoXwDZbIy3oqtojD1teS7Kucb2c+d3SOnqygKE1vb5jAigmFpQjuKRbKO0xMvH6T47Oi7l7vC78VnP4rUddhiPdSqeeYWjbzbgaZnkn0r9QklV//P4VzyPmyJV823g7xkr8eoi+kc1WvxlxSdZ18LO0iCJIy1frHe010OzoTRuReLxNb4DkoUaagGcmJYIuvwBJa5xUV3zhGtw4YR444HjyDawKD5/Qo/PYSWP1IOIieSTKaWW3iTIOsync/GAH//hXKeYNcixuicuKSKGjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCHPmeaY0ARAfHFvozmgxo/luFkb847sc892Pnet9CA=;
 b=cW78fyDfzZ8HQXckyXKws4q9ZEpN43B0K3T/Y8BjyFxWLZ/KECuAb8RAAFle1LeJbD1H5zKOWJ+PbWZnMnkChl+0RTJ67Rqq4dHJqwfS7Xf87xSkZQ3/gb/ZavXpOvc+efeoKgQlqFDBmdUfkyOxo/5+zlmQRB4auPOeq42s/IxqI2etWbA6w0mP1RB+h3Tvh/khfWV04m1fFnxLpyqa+YKo0mwjiL17Z/QTarbcHiu8U82OVb+JDxL6Q1Z2s89kiFPmfkSu60AhOiHQXBvXj5ivVtyl3gv3Kf+F/bQHp+5FDyX5FVdGDVWsnx7uVyTZWA152IHQ0QK/HHbWeQ8G6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCHPmeaY0ARAfHFvozmgxo/luFkb847sc892Pnet9CA=;
 b=YjePYNpIUr6KDbgrQFwyPBmEOvLarFxQCywOm+uFxX95Cbl/Z2P7iQ67dYNZP2mntB5Jvk7JEbLzcPMTEpy4D5aZBhv/o9NitdlRVO6V1xNxg2HAkGmF33VWeQXyBzjhtbbkvBIRlgqIQ8ACVVeJ2NjhjfCLYaOxMOuKe7lwVOHmhmfdS1sOUwP6V3qnBkxbtQ02gXXiMmCtq9fpxHURoG/3QyYFZgk6OYqxtP/JA0I61W4x6Xw+392TDuEFcYLvPvQDVFw/PGs9sOHwoL9MUza+xZ8sE6q/DPlN+ngavN0S1PLG7f7/15Hgl0PMInE2nxxfDP3UnlRN8vAFklRrog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by IA1PR12MB9739.namprd12.prod.outlook.com (2603:10b6:208:465::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Mon, 2 Feb
 2026 13:28:09 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 13:28:09 +0000
Message-ID: <3bf3b2b8-1fe9-415a-9e4e-659f9101347f@nvidia.com>
Date: Mon, 2 Feb 2026 13:28:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 16/22] PCI: tegra194: Free up EP resources during
 remove()
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
 <20260126074519.3426742-17-mmaddireddy@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260126074519.3426742-17-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0210.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::13) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|IA1PR12MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: e4125de5-237f-49c1-034f-08de625ee800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVI0YmNSZ3JjeXFwOU95L2RQUU80aHVDejBpL3p3SW9rNHYrUnJ2NVdPYyt1?=
 =?utf-8?B?QzhiZ0wxcU1VS1Z0eVdEcHcvN0w1WmxYd0NqUzlkVGptclNRTm1iZTd5YWFR?=
 =?utf-8?B?MzZjSlFyL3BJZUZLOW90bzFiUUQ1eFQ0N2tWRm0xZ0NobnE5SWhyanIxTzJz?=
 =?utf-8?B?emR5Nkc1TDRaUHkwR2VYeWNqalpiUmhRWkhVZk9keGhaSEFTRTQzK2pqeWdG?=
 =?utf-8?B?MDlGUFdheGpWWmtWZ0NrV0tOdmRxc3JSRExYczFsTytvT2t1bm05a1ozUDFV?=
 =?utf-8?B?b09rVERIeWJseHZpc0hrSFZTWGxSdVFtMXA4dGpYenhZVzBsQ2hIU2tJa1hV?=
 =?utf-8?B?TlhGT21jdVUwYWl6V2FYeGVRV0tJT1ZQaUdvbTl3L2YvVS9kM3lqcFhPTnVZ?=
 =?utf-8?B?K0EwTXpqeWFwQW1BS1U4MWNGaC9tcERETm1GTDZzL0dNT2txQXFZd3A5Mm9R?=
 =?utf-8?B?NG4vVVJRR2ZhVWRCWEhzaWV4Vkx4bGdHK2c1emsxb1JTR0NHQkxieWdISjFq?=
 =?utf-8?B?aXJpYVZoaXBwUHlYQUlMNW9ramZSeTREdGtCMGtoa1UyODdrZ3hrZ1lhNk9M?=
 =?utf-8?B?ZHpJUG9NWFRPK3ZWVmkrU2R6UlVjQXgwb0pkUXJ4K3N3NW9sMlFHbC9GZGsw?=
 =?utf-8?B?a0FrelJ0YWVUaVFUTzR6bS9BVithcDBkVmFHbkJ3MVBXamFDS1VYVi9ZK3JC?=
 =?utf-8?B?NXdsQU9VZE4vY1pOZ0pEZTRQMkxVNStxWFJVZkV6czFsSm1WNFlTc0UwY0ZJ?=
 =?utf-8?B?b2FpcVRxOUlYc1hyeTJnZUMwM1FTN2JaYXNBaFZJUjhLMC90amx5VEpmQUx1?=
 =?utf-8?B?WkI5dVBQMTF0SE1hei83YU9INXhIMnRkaGEwYnRGMHpoRUhkLzM3UU8yMzFF?=
 =?utf-8?B?STczZmRuTzhCa0tEdThRejAvamdzdkRGRmJHVjZUbmo4WEhVOWFCRlFLSUZr?=
 =?utf-8?B?bHhPSGhxZmhBSmR0Ty96VjN3MzVDVXo3WlpzcU5IdSs1YUl2YmxnWHp4bHJl?=
 =?utf-8?B?SHZzbkN3eGdtUGgvL0F0VDRxRkwwakZGclZPdUtkVUVUQjhpQlNOU1k4cDlo?=
 =?utf-8?B?RTFvdUV5MXhaWW9Rby9KMjg2ZlhKcjFkRE5WMm5GZzAwUm5FNDNTNE5TWGN4?=
 =?utf-8?B?Y1NiT0JFaEFPT2V2QU94T1ZrenNVTTVFckgxMFdrbGFIUnZPdmwxUGh1WlJ4?=
 =?utf-8?B?dDVjTWVFTU94NFlzUnd2aW93SHYzUzMwd0lJMzU5YUQrbWZkQTRaV05vN1Rv?=
 =?utf-8?B?d3RUV3NqSzVWanhEWUNidDNSa1kxOG9rMjZYanFiUjVVTTNENGdVdkNlQWNx?=
 =?utf-8?B?UVYxRDhsMTBTWnJ6ODdNekdPamFzVUJ0UzNjd2h4eHA1TFZ1YzhUeUtUM2l6?=
 =?utf-8?B?eFV0OUdPUm5SbXBhNjRRRWJZZUVTdm9ZRmpEOEZ5Mm9TQUJnbUJ2TWtJWnZs?=
 =?utf-8?B?OEQ3REtNNUVpdHR0a3ZXMmVHTU9CVHEybWdxdXBXM0xPYWJwcStpb2FIemVt?=
 =?utf-8?B?dEVNR1ljV0xMZWphUzY5Y0M0Qk05RGNMb1dnTW96bGhIaFhZd2FPSlhKenNS?=
 =?utf-8?B?eHNvamdYNmhkUFVzZkpMYVJkNTlTRU5UNXNLQlRqa2dJVFZFTUZ1NGFLbjRn?=
 =?utf-8?B?NTN6eFNSNTlYcHROWkw2MDIrN1A2dmxWaWFhazl3MzNxY3kvZWszckJSenhj?=
 =?utf-8?B?ZGtzS21sOUNKVzlxajlLUFlPdE5WNVo0ZXhSL29LSEFKOXRsQnJlNi9TbjU3?=
 =?utf-8?B?YUFoK2Fra0pjMkVPRk9MbnljWmh1cGI5cDg4cG5TNzVqOVhnTFhhcmtiVWhv?=
 =?utf-8?B?ODNHdlFQNlMxenRLeU9ydmEwOTlZUDhDZnpoa0lFRjM0bnJ6WnNxNjVhdEpB?=
 =?utf-8?B?RWhRMW9ZeXJYS1o1RjZhWUNXcUR0UEh3eVBMT1YvNDF1eGxuWHBDbE1KZnNQ?=
 =?utf-8?B?Qkt3VHh2SERRT3dlSGJJbmdFS0R6RUx0VW1zaE8rdFZNa3AxZzY3bjRrMmNq?=
 =?utf-8?B?Y3RIdUV0MWYvZ2ExUnNzUlVNNytPa0F5QkRQQXFhNXZRaHQ1K2d0MGJVSW9r?=
 =?utf-8?B?d044TWJ2UnpmSE9lS3BXMWJpdkU1T3Z1bDNEQS9yZC9idlBDMzlHYyt6RFpw?=
 =?utf-8?B?cXR0cG83ZzFWT0FQTi9QVGxFYlg5enFxOGtrTHJnYlVZYnJLck1reXpsaXpQ?=
 =?utf-8?B?ZVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0ZXelBBU3EycmFnS0lJc2xPekNGcnBKM3VuQWh0RThzQTlmOWFqYzhpSG5w?=
 =?utf-8?B?MlF6YUNyUGlUbWtMc1FwVS90Uk1sY1ZreitJaUl5T3BvOVF1MzJzSHRqSW1F?=
 =?utf-8?B?RnZXckdOWWdDRm5SMkpZaXRkNkNkcVVnQmNoK3pySk5ESGt4SmRFUndieTNn?=
 =?utf-8?B?M0x1eVNWMCthRDU4K3dJK3BZMEFQRzdvczRDOStSRTNIc1lyK282em1vV1ZU?=
 =?utf-8?B?YnBjSGRrUU82OVliOVFxZVJuekM5djVpaDF4WEJsSVk0ajBKMGNoTnBUOHRm?=
 =?utf-8?B?VGNrWkc1YlEyN3JuNmlDdXNoZTZUdWw2dHpIS0VEMVkrd3FOak5EMjNCcW92?=
 =?utf-8?B?bmVobzY5dGs0eEdrdmtveWM3WCs2Ujk5azNTV2grdjIzcGFhQ0tHODNpUGE3?=
 =?utf-8?B?N2N0NXkyTVNlNVhONHVsTWQ2WmFHNmpWUWFPV2V0czFBaFlCa1FmUnB5WFJ0?=
 =?utf-8?B?YW02UnRBMU5ZMm4yZWZzOTZyVlBSUU1GRUxvYUZPY21tYjZIbHdkNzhDUWlO?=
 =?utf-8?B?MytkSGdBcFFKZ3dPS05ocHJCMHZBMmJQK2hzZnpjdzVFUjdDVkI5THZGb0tv?=
 =?utf-8?B?bEtEVjBNUGZqamplVDF0eFR3YkF1ajVPMGdoN2pMVFlaL0Y3VC9aSDZkdzBv?=
 =?utf-8?B?MjBGMGVnYTRNNjgxZUVkZWgwaFRIYjF4N3ZsU2F2c0pISThMY0VzZGwzNUlw?=
 =?utf-8?B?dkZUMDZPZmJPZG1kWm42cFRBTWhoKzEvQktwQWl1VFdncDZ3VitqRWg4ZlJ1?=
 =?utf-8?B?MlpxN1dKam4ybjhiME5rQkx4NEFDVk9maFFjU3BCSnpicTcxVm42VVNnMVBZ?=
 =?utf-8?B?OXhiaWdUWG8yUy82UUdIUUNHRVNvY2hYakIxVzVBb0NJMkZULzZYbU1CNFpJ?=
 =?utf-8?B?Wlh3alVNWk9hOHpEcTdlcFFCaTU2bjExd3YvZ1g4ZVV5N1NraENQclh4UlZm?=
 =?utf-8?B?KzNoQ3RCRmVBRDdyY2VaRXlxNXl5b2JzdkRlZGtxNytvVWhBMEZxSEE1djly?=
 =?utf-8?B?WFZCQStRR0NHajdUTFBlY1EzK1NiRUtueXo0bHo2cERWRkxmaThFU1JwWnpF?=
 =?utf-8?B?NVhkdWZmY0VBMm91MlhUa1lBVXgrRzBvYlFDQ3duMzNvUTI4d0pBQWZrRlFY?=
 =?utf-8?B?ZHJnMjdYL09NdUlqYUkySm1EeTlGU1lzTWVrT1dERmNpb0dRYWRSaTJkVDhG?=
 =?utf-8?B?MUczbmVRVTZyMzFHRWNCTkMvTUIxbGtqTkJlbnVtUTg3ZytVZkJtS3pzWkF6?=
 =?utf-8?B?emdJMzNsNy9hRTE4c3RzVFJJZ2NGbXQvNGRZOTYxc0wrcEN5ek5GbzlzbGJZ?=
 =?utf-8?B?VWxuYStMTkVEN2lxbmtPQ01HSXgwUzJxTENBbTBvOW81VVI1Snl2ZFFTRmhm?=
 =?utf-8?B?QjhTSjZ0dmtaZzhWUXdwcmgzVk4rVm1ObjRzR3BCeUx4RytRQmxzeEN1Y0Rp?=
 =?utf-8?B?SnRvUHpRNWFMNmlhcnNPcEk3SzFTemswNmc3SFBJTHBPU2RnWEgwSmRBSXox?=
 =?utf-8?B?cDF3QWFJL1hNSXRuMlJLczB6RDNlZ0IvRXVpWW80ektZSnVNTFEzOU9kcmdi?=
 =?utf-8?B?RFlaVlZlMHJLYTJncmE2M1UxajlTR0dTTk9GU00vMGxXbEFIMGE1eXl4V1ZP?=
 =?utf-8?B?dGJPUVczM1dBdU1jaVRURU85bU1nck9ZR0JMYkMzZDgza3pGTXQwUFI5aVVt?=
 =?utf-8?B?RUhSQ2hOeU9XcUJyaTlOd3N2T2Y0NEVuMXRhd2hPL3VOWU1HNktSelcxQlFt?=
 =?utf-8?B?MWE5MUxQd3ZteStoemE0aGZGYVVPZ3c1cDNSSWZ4ODE3bDFJZFZvZ2ZZSVVh?=
 =?utf-8?B?VE5OKyszNlBxeE4yRHQ2UDVHa0FoMXpWSmZpLzRIUDRGblFYTFl4NWZQNUNL?=
 =?utf-8?B?WDNnMEUxc0h6YmJycU9hbFB2OTd4RGl0OTg3Rm5VbkpTVHd2Z09kVEt1Yjlj?=
 =?utf-8?B?YTlmRXRNaFk2UVM4bDU0Mjh3MFBFRUc1d3lCMVZ3Qld1OU9HeVVZVEtrbWV2?=
 =?utf-8?B?b1l4cDVwSUtJd0hjTWdIeXVwKzlCS1BiQnkzZWI0UU5haWprWDYzZTZ6cEsw?=
 =?utf-8?B?TmpUR3hkNHhSaWNCdWI1RmpRYklIZXJhYXBWVmkwWitOVHBLTWZDa2hMdHNE?=
 =?utf-8?B?eU9Wd0VCZDVNSWsxS1d0K1hpM3ZmcEQ3RzRHdHhTcDRwVmh0WFYrT2NHV212?=
 =?utf-8?B?dldUQzJNU0xnSGxjdEt3TCthZjlsQ3RmZUFldUdLRXgvOXg5bHJXdGxRYVB5?=
 =?utf-8?B?Q0pLU2JvNkJpcFA0UnRDaVVTWXZrNXl2T1gvNnp1VjMzeUFuek4yaHFvTE9n?=
 =?utf-8?B?RkVUcEFuTVlhRHRqRlBtRmVFOU95N09ZYXJxRzNtUkZPZFF4Umx2Q2UwaTlP?=
 =?utf-8?Q?GQziUOWPN+bAEF3DlZsyTlvAsfuoD3LvSgL6iQg2gNQvk?=
X-MS-Exchange-AntiSpam-MessageData-1: 6iCQWpqV7FYG5Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4125de5-237f-49c1-034f-08de625ee800
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 13:28:09.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NcxBbWxyDiRqpp4lwZ29wVfslJqgUy+ZFrjraVtFa4t8BajokY/B2ABeUDBLcVLfgHHT/X8+qvzwZPZb5BxFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9739


On 26/01/2026 07:45, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> Free up the resources during remove() that were acquired by the DesignWare
> driver for the endpoint mode during probe().
> 

We are missing a Fixes tag here.

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V4:
> * None
> 
> V3:
> * This is a new patch in this series
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 1a269397150a..d490dcebf960 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2297,6 +2297,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>   static void tegra_pcie_dw_remove(struct platform_device *pdev)
>   {
>   	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
> +	struct dw_pcie_ep *ep = &pcie->pci.ep;
>   
>   	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
>   		if (!pcie->link_state)
> @@ -2308,6 +2309,7 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
>   	} else {
>   		disable_irq(pcie->pex_rst_irq);
>   		pex_ep_event_pex_rst_assert(pcie);
> +		dw_pcie_ep_deinit(ep);
>   	}
>   
>   	pm_runtime_disable(pcie->dev);

-- 
nvpublic

