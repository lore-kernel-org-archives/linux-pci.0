Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3BCA52;
	Mon, 23 Feb 2026 03:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771817310; cv=fail; b=FQa+RKmeh08ASPIeaCdQRuhepCeOWx5iuOmvW7dJxhoxqU8z1uwR2+RqZvlDixUCrrmzg4oc1pSiAWNB6fry/pUByJP/uyvVwTc7lH+znDqnuIqudTyVIZHLPmWRoSw45m2ZN0CPD8DK4sT3gSsgoOYTgoja9P+jfFtRThM4ScU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771817310; c=relaxed/simple;
	bh=sF+amo4qw26Bf42CSLM7MkMhwPABzPHVa8KzuTr/FiM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MiSlM8kuz/uHdCcYGMDqE0KPAzCRQe2H77fkU1bvBhoUYF7JehKRfAFViruS9pzfr+lDdLyevfq9Y8XnrBbgFMwjLaOHYlpTB3yaIPDjplCbsm1sZc3uhym2CXEY22nW0Gk4OIm64pygom8qk8cgW7ClPxywxl5Okj1eMhs7ZP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZyqUrt+m; arc=fail smtp.client-ip=52.101.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZyqUrt+m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+A7KVh2oTs8VneBTwXEJlo2InFVdQU+ya6T5nEZuUhblMV6HArRKuiVbP2hKuaSZ/4a4FAO3vHvh4lAczt09BFbtEFJDo6GimtM/XAQKqTnv43ePIDZgCBGfRDzlzYPbFJdoZ5l4CL1J/1xkWBakfOBY2J6UVBfcv6XuXDzKrnyU+rG6l+A5wSd1zG1U1nXNBHPHN6gWDJ9lVDfcevqRBvPDkHLr88m5DDXNbmlpXvhWG90gT4j+eiouSteUxkV6q+z2IdzNzgLjvysEOUR84xP9aY1YutEb04K0knbcyV0gXDsf7GvowI7UxRRP8ABomzSQ8aJAa7JpDggens6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfMl0h8ObcF47xhaW5zds8l4UxFQAY4eOICC9E2Hf+s=;
 b=zJ8GgAfZoNrFGCM4AQ82Y/EL4iwb6vN4k2WUXlaJOTLsffnY1UGzUxEqtPrYUIH6v8fQXlM1JP+pMBaCP4HyMF1S3pVBhydzgRkBmj0YNOe16CtC6xyOo58DspurcSIn0OA8h7GqwaYSP7goCXa5SXRb6jlNWsMkLdcS4VUDMn/Y83mCLUmGDUbFO87rmaLRxO1xf4e1Gub+syroz+P/RVFpZZx6y5nHemgwYYL+M1FdZzgXZR/pCGjJru55RILkOYb0ZIObln8LYZoJmOUIupn5y9aoI49D/XjHpiW61OsMKkmkODnatTXR5TWZULPfIiS76vX/2WwOupD8oCH5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfMl0h8ObcF47xhaW5zds8l4UxFQAY4eOICC9E2Hf+s=;
 b=ZyqUrt+mN7dWtRA/1rbKEuTFspX3up0xC8rcfMBqLdR/hVYlTP/2/4KfJL9+Ma+WPBarZIZXdKqW8CXMYwLJRjFP598b2Vlo3qM9ONUbzZsAZyp0YTfgcQik2NGmamZnv34T44QQnCr1DM3mlCbACVx9eCUHhF7jSRQ5AHUfa9shTkIBHYinGe1vqIz0euz3slZOJLmnZZC0+FMjGTuug9IpvK2XEGqk3kT4z92iRlyGZB6d5XMpv8ZCg2ME5xxfZSGzxxPuUtzvWmTG7aV0Moc53j+VFyrXKTjvy5F4+oZCy+nsoKH1aNgpOzXZDHuQ1LLl74raUwFwUEfTUKt7wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 03:28:26 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 03:28:26 +0000
Message-ID: <71e796d9-f0b1-4f5d-8eae-e90ab78e9538@nvidia.com>
Date: Mon, 23 Feb 2026 08:58:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] PCI: endpoint: Add BAR_DISABLED support to PCI
 endpoint framework
To: Niklas Cassel <cassel@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Koichiro Den <den@valinux.co.jp>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20260217-master-v1-0-727e26cdfaf5@nvidia.com>
 <aZTf1K4p7QS8-R9k@ryzen>
Content-Language: en-US
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <aZTf1K4p7QS8-R9k@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::6) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ac05f7-cf23-421a-2f30-08de728b9aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0JPRDhoVUp4aExuSElRSkZiVHh6djVhT1ltajlGWUZtVDYxdWt0VzJCbWRL?=
 =?utf-8?B?cDRmUFBPeW9lcTIyYWIwMmNsamN3a2dmRENsVGdtUDBhNXduTDA3anZleXEy?=
 =?utf-8?B?Nmhqc3dNdEI2OGNMVmhzRUVyaUg5WWVXaExjS0ZkVGJsRmxJWVNvM3Z1dDlB?=
 =?utf-8?B?N2VKcmVNcHEzcTNtWHlMK0U0bldkK201c1JraEs0ajBoTXlCcFZXVHMwU0la?=
 =?utf-8?B?a25Yb1lSNS9iS3lYenhKZWsrdE9ISGFXb0ZIbFlBb0F3ditnSXFFNmRQWVZS?=
 =?utf-8?B?cVMwZFpiYWpVN0VTN3JldE90WDZaSHJic1UzeWxxKytMRkxZakdGRlhZSm9z?=
 =?utf-8?B?TDRndmYyR0xXMjB3UTNIeWNSaXhCNmw4eFgrOW1LcVcxMVczeEdob2VxK3c1?=
 =?utf-8?B?dllrUHlKZTZvWXV5d2ZnV3BuMVMrZkVJbjBLUjVtOWlFM0p6Zzg5M1o4aVN6?=
 =?utf-8?B?MEpqUzZvUW41Q3JSZGtHK1ZJeXhaN2RBWjlEOHNJSTJTaVhNTElseWt4Rmdk?=
 =?utf-8?B?dCtnVFpQbjd2M1NFOVFQS0xEZFZMdHB1Z3RYSytpWlF2R0JyS1RwTWJ5c05i?=
 =?utf-8?B?RmJaSFBVaDljaXNycUtkRDg5WmxPK0ZJb2FxNGFXNlBCSEt6NUFxK0YxWkw5?=
 =?utf-8?B?OFF2QlVibXZ3M0F1QW9FQ1ZucVhwQU5GODgxUVJlUm5kS1VLMVlmYW5JalA4?=
 =?utf-8?B?aG5LaU1kTlpvNGdSclE1ZW1mWEpQdTZFUy9NRzhsVCtpWldzaDFQUTdNNFk3?=
 =?utf-8?B?V3VmKzAvcFlVdDA0YmlLWHFvd2JzdFVqbE02VU5Kb2RuVFFMU0MwMCtsSVZy?=
 =?utf-8?B?V25uSnNZWXdLcFc0anIyOXdiUTVkV2p6NHBNOGxHTjBVZVF5Ym4yam8weHJ5?=
 =?utf-8?B?VXBCTVM0NElMSTVaQncrSThnSm5vZTI0eDV3aDJLVlRJVkptZGM1bTF4bmVp?=
 =?utf-8?B?NDZGLy9KNEg4dEtjTzhrMlIwc0RBRDhaUnpnVUxjNTVadytWcVNvK1JtQUN6?=
 =?utf-8?B?L0g1Rzl0YWcyTHJBQm1SN3FHaU9BakxtTkpHV3ZUUjV6STN2bys4c2RaOWEx?=
 =?utf-8?B?OHdJUzdMcGlNYmVrVEFGOVdObVhkSlNkN2VPRkp1K3FYYjBLMk1lYkFielUz?=
 =?utf-8?B?c0lmRTArY1FoeWx6NGFPbEQxVEFCK1FQVVR2WVRwa0VSeFRqN09rYTQzZWhV?=
 =?utf-8?B?SUtQb0N0MVBYQzVGZm9TampNdkE0a1lHSWhSRk1iQ0tNYWVLWG81Z1FneEJD?=
 =?utf-8?B?U295TFRwRTlXM2tvVFV0dkdFSFdQRVRjVE5qcWtRcG5zTWxWSnI4anlVWjg2?=
 =?utf-8?B?dXA4dWVFYTRIMGRZazBTMUliUGJzVk16dDZqampGK01pMFN6cDlLMGFadURn?=
 =?utf-8?B?SVAxMmF1bHRVeXFuUStSRjBxM3p5OURZdkZrcGlpL1lBNTFkdzg0amlhZkM3?=
 =?utf-8?B?NERXSW9FM3BQd084a3NTSFVQZ2NBSzVwdzNXaEt2dnJJOFVPQjREekdXZWx2?=
 =?utf-8?B?ajQwRWJvSXdsbzVwZ3hMR0xFSHJldldPeDh6TllKbFJGSkhTaHV6dXJ1VDZ6?=
 =?utf-8?B?cmZaZWx3M2xhOS9OTXhlaUV6VWpReEc5ZVBmY2xOTzlUUGFwZWIzbWxkWWxi?=
 =?utf-8?B?TVcwazcyUHF3ajdJbGxlZGMvK0JVNHZqdjcrVURSc3dzc0ZxQTRuTGtYT2ZK?=
 =?utf-8?B?REYxaVFnbUlNZUdYVGhKbjYxaDhOR1dsKzc2UG85S3RNUzlydUlLUzV1RS84?=
 =?utf-8?B?S1QyMUQ1MU1FTDFLTHk5NGdHWGJXK25NclRlL3FqZDd5MDhLcUlxZDh0RXFs?=
 =?utf-8?B?VS9Wd1FLTVh4ZTlKUjIrM0pwNHFveTBGTmdEZ3ZFQzlnR0ZsQVAweWdIdlRo?=
 =?utf-8?B?Skp3TVRlTFpDaVAxdjEvdW5LQ0lhN2dBK3VVdEM5THhjaEdJdzlSc2ZxbzF1?=
 =?utf-8?B?bElFQ05zQ25xcWIxc3EvNU8yRGZkekIxa1NMRDJaN1hDMUM0cEppd3k4bXdS?=
 =?utf-8?B?RnhkNEhvZjUzbk42anZaSG5HMXhlV0s1bVlvQVhKbldEMGxpYjZtZVdZdVNO?=
 =?utf-8?B?RUt2bSsyWUVGUjNvajN2bEZtTUFTaHV6RjJXa2xFL2xybWRrVGZIQU9jblpm?=
 =?utf-8?Q?7CLc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUtwTmYvTUhDbzNXM0ovaXFSNENBNkhMY05hQUxrUkcyTFR4VTZVZnM3a09E?=
 =?utf-8?B?OS80SEQwSEtJRVp2SlNsS3VaQmQ1b1RYTnVGbjZJeExpVXZxSjN6UkNtd051?=
 =?utf-8?B?OXRUS3lyYW1hRVR1U0tIU3lkLzZPR3g5a2toaUwxTzRLRFBtY0tvZ3Q5b3k2?=
 =?utf-8?B?RHlhWmZra1JkMTNtWWNBYzk5MUZJdFJocWRWQXlIM3FNdFR0a3hVdEZ6cElK?=
 =?utf-8?B?S0NObWhsbnRvdHNvZGkwb1A3UWNneXdsYlFqYmFGOTdGTVV4LzRuTXlBdHBt?=
 =?utf-8?B?U1d3djBVWUt0VnFKVDN0cUFhMHMwSFlWVUxZb2RFRjRZbU4vYXBTRzkwMG0w?=
 =?utf-8?B?cmRjQ3NUY0FxTGs5M2MveVVEaHFqbXM2bENGZThxanFHbzZudFFieFJsM0VN?=
 =?utf-8?B?NmhhSDgvRDdTVU51aWhLU2MyY3ltOTFYclBTcFkrRVZMMm15RVNvQ2pqT09a?=
 =?utf-8?B?Vlh4VnJvTzJhRitKVWtxaXRhcDUzeitPVTJBR3VzZVJ6bE1QMlFSd05SQlhT?=
 =?utf-8?B?eG4vbHJFSjlsSG82blZnZWR1cDhzR3czUDBRRmZta2tmcGVaN0FmN2hTMmNX?=
 =?utf-8?B?RlRSODlITUlaVENxbmNoOGVEekJ6UmVzcnRBZ3laejhJQk9qSnRtSHBBdStm?=
 =?utf-8?B?YzlIV3pQRnBsMStnSWd4cU5iWHdQN3NlbldOYjJPVzB2eXVXS21hTjVyQXc3?=
 =?utf-8?B?QzdmRWhQL0Z2dktjVGVIT1pNTzRSdWVMbkVuaUFxS3ZBcVo4YXdtZEFaQk4z?=
 =?utf-8?B?b2dOdThra293dGwyVmx6V1pQWVZtRWw3WUxLUTlubWJBT3NyRjUrTU5sMllD?=
 =?utf-8?B?a0p5ZGVFNTkvUGhST2daTjBSOUhGWlJXSVZCRzI1S3k0WmI0b2diU3hRODB1?=
 =?utf-8?B?dFB3Ym5CcTBpSlJGYWtDblZhaEZ3b1pQeFBWUVo2S2JnNVVxNVE3K1lJZDFZ?=
 =?utf-8?B?eTNRbUI3dlRqOXZmRmltcnlOTmNOZFJXNW82VzRsbklvWmdNT1ZJd0dmbitX?=
 =?utf-8?B?dlExNGdqd1gwVlNLY3A3N0pKRjgrR3J1cEF1OC9zOHZFY2xwSDhnaUxKK2cv?=
 =?utf-8?B?cC9WNmZqcE9zVmphYlpuTEx0SlhOTHd3ZzIvQUVDeTh5YlhVZUlBUjNCaW9Z?=
 =?utf-8?B?WTVsU2VTb3l1NTZkMVR4RE9FZ3NSTHFWeWpCZUZ3bHBvT0diMVpJRWl4R3NP?=
 =?utf-8?B?S3hjU3RqWmJJbDJZaDUvUHlVOWtCaWNXZlRKMm5MWG9xQXk2a0ZJdzQrSjNv?=
 =?utf-8?B?N3NoK2wrdmtXelBhTVk0ejVWaWNobzdpWVhRNjNOVUQ0Wk04R0QwYmV6RGNh?=
 =?utf-8?B?VnlNRHB5aE9jTDRKNkplNDBWNHRIMlhHTkh1NkNvUHByMzFmK0YxTWZRUVJ3?=
 =?utf-8?B?T2grMy9yZ2pWbmhxVjB4ekQzZGlTM2c5K3JJSElSZlo3SnUrbnZrTEhhajBF?=
 =?utf-8?B?RU95K0Exb2orK2U2UHkzSkt0QXpPemlOOFN3OGY3UmdGeHdKWUMwV2VwVTd5?=
 =?utf-8?B?WHIzTk4ycFdXYXl0OTFjYmxLL1dBbU5rWGY3SmFwZTNKdFhtWjkwNm4ycmJ2?=
 =?utf-8?B?dWRqTXkzWThNYTFTSk8zNXlGd2hmeGpmc29kNkt0MDhHT0sxdXVNZXNKS2ZK?=
 =?utf-8?B?TG0rVjlBOUpCekpDT0duS1B6MXhMQjNwZ1ZPSExSbHo2bTR3ZTRoY2VkMVhN?=
 =?utf-8?B?Sk5salVveGVhVVo4QVBlUm1QeTM1TWh1Zmx0Y0hkTHJWbGtpQXcxYWRBS3Nm?=
 =?utf-8?B?WWxHMVI0UmdzSlhpaEJPQ05adGZpTDlwM0tsc3Z1RHpnL1VodmwzMTFJRkN4?=
 =?utf-8?B?T3hqOVFzN25yMUFqQjJWak9sQitsNGp3WnNGWHV6b1dDVEZ0b0RHV0VOc1A5?=
 =?utf-8?B?QkNGTmlpNnkrRzBWM0F4eGZBWlRYYkFjZjhUVmpMczlXYnNDVFVkdllINmk5?=
 =?utf-8?B?YVNBQ0hwSXhOczg4cTdTb1hWK2VSbjZqZzdUWE9TdFo1b3hwUXZPNUw5U2lQ?=
 =?utf-8?B?OE4zajBvVzMzenY2NE05RVBIeWd5WlpXZ1BBVU5sd1VhY3paTXJYQ2tVb2VY?=
 =?utf-8?B?OWd2QTl2ejVOQ0dnNnRrZ3VYNDZ2dzRlZldtTk8rYkM1MVpjL2pLWGc4N2lJ?=
 =?utf-8?B?SC9ZZURMRzB2bG83ZHJOaGtwSTBCUlNBY1prb3B4TjJPekt0VTg4SHBid0Yx?=
 =?utf-8?B?ZkpWWTRnUkNOM2hmOEdZRk5CVXpZU2RmcWJML1FvTTFGOFVOZTJXQmZkMkJk?=
 =?utf-8?B?ZFVuc3ZoZDdJUUU0V2tFVFVHdzEyMnhobHFqbk1xMXZsNloyY1FTOG5HUTBt?=
 =?utf-8?B?MHlYR21RVTk0N0lPZnRYK21tcDdmTFRkdDQwaTN1aXpzWUNRUXZxN1VHaFhn?=
 =?utf-8?Q?7VZAM61ejzD5rJqI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ac05f7-cf23-421a-2f30-08de728b9aca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 03:28:26.0063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpnC0FfLFywVptSNpVBqpO7IzJ7aK/bJAQUy6a2Ln0FU2Jz0PYDUMTIlw3J2RqynhQZFY23H/c+LF5Koffp1JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694

On 18/02/26 3:08 am, Niklas Cassel wrote:

> On Tue, Feb 17, 2026 at 11:24:40AM +0530, Manikanta Maddireddy wrote:
>> When Tegra194 runs in PCIe endpoint mode, BAR1–BAR5 are marked BAR_RESERVED so the
>> EPF does not allocate backing memory. The host-side pci_endpoint_test driver
>> still ioremaps all enabled BARs and runs BAR read/write tests on them. Writing to
>> BAR2 (MSI-X table) or BAR4 (DMA registers) corrupts controller state and breaks
>> CONSECUTIVE_BAR_TEST. A prior fix reset all BARs in the EPC .init(), so only
>> BAR0 was visible to the host—tests passed but 64-bit BAR 2 and BAR 4 were no
>> longer available for real use (e.g. host DMA via BAR4).
>>
>> This series addresses that by:
>>
>> 1) Adding BAR_DISABLED and clarifying BAR_RESERVED in the PCI endpoint core.
>>     BAR_RESERVED is used for (a) HW-backed BARs (MSI-X, DMA) that the EPC may
>>     leave enabled, and (b) the second register of a 64-bit BAR. BAR_DISABLED is
>>     for unused BARs that the EPC must disable in .init() and the EPF must not
>>     use. pci_epc_get_next_free_bar() treats both as not free.
>>
>> 2) Updating Tegra194 endpoint to use three 64-bit BARs at indices 0, 2, and 4:
>>     BAR0+BAR1 for EPF test/data, BAR2+BAR3 for MSI-X table, BAR4+BAR5 for DMA.
>>     Only BAR0 and BAR1 are reset in .init(); BAR2/BAR3 and BAR4/BAR5 stay
>>     enabled so the host can use MSI-X and DMA.
>>
>> 3) Adding a BAR skip mask to pci_endpoint_test so endpoints can skip the
>>     destructive BAR test on HW-backed BARs. Tegra EP test data skips BAR1–BAR5
>>     (test only BAR0). Adding NVIDIA Tegra194 EP (0x1AD4) and Tegra234 EP (0x229B)
>>     to the pci_endpoint_test_tbl so the host driver can bind and run tests
>>     without corrupting MSI-X or DMA registers.
>>
>> 4) Converting unused BAR_RESERVED to BAR_DISABLED in the Uniphier Pro5 endpoint
>>     (BAR4 and BAR5); BAR1 and BAR3 remain BAR_RESERVED as the high halves of
>>     64-bit BAR0 and BAR2.
>>
>> With this, CONSECUTIVE_BAR_TEST and DMA tests pass while Tegra194 keeps 64-bit
>> BAR 2 (MSI-X) and BAR 4 (DMA) enabled for host use.
>>
> Hello Manikanta,
>
> There are quite a few things that I think we should implement differently,
> please see:
> https://lore.kernel.org/linux-pci/20260217212707.2450423-11-cassel@kernel.org/T/#u
>
> I'm not trying to take credit from you, for all I care, feel free to take
> over the series and add you Co-developed-by on all the patches.
>
> I just though that it would be easier to explain with code rather than a
> lot of back and forth.
>
> Hopefully we can send a V2 that includes more detailed BAR_RESERVED
> descriptions, that includes what are behind each BAR_RESERVED (including
> sizes of each backing MSI-X table/ATU regs/eDMA regs/whatever) in
> pcie-tegra194.c.
>
> I also have a Nvidia Jetson Orin Nano board that I can run in EP mode,
> so hopefully we can collaborate to get something merged for v7.1.
>
>
> Kind regards,
> Niklas

Hi Niklas,


I marked my series "Handled Elsewhere".
I sent new series to define HW reserved BARs.
https://lore.kernel.org/linux-pci/20260222193456.2460963-1-mmaddireddy@nvidia.com/T/#t

Thanks,
Manikanta
