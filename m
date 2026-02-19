Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013080.outbound.protection.outlook.com [52.103.43.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6033376A0;
	Thu, 19 Feb 2026 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512014; cv=fail; b=sD85U9otQCzhx4T//0aE4jTndbuOCmxGTS4C5AxgsxcwGoWeaXAyGuxvJAWKt1Cgqq2jyerU1bVhGZBTNToPnnkD4VPhvZdCr8d0ttFlxxacpBgvtDMI/yMo0TD7d5CMYqOr0uh8+0za+6euq4BIuRqJoTaaD98Qa7kK2W/NSQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512014; c=relaxed/simple;
	bh=ApZuOze0mEEAjBVumvk8hb+tzzYQW/K30wWCjuPCaEU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pHPxnqCkdkDeDprbJciJky6d9wTOT6vvMp/4wANQPQftCqUeAbvoAbdfd3wApByPpkDKodk8m0DgEhLD/A78/FZZgqtl89V4FsFzD1tjFunQKwQ52RNIfOktNQ930OGwByqs1zt0aavWsj09GzVMk9qfTMR/8RHzOQENG9GMC+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=OHFzYYIp; arc=fail smtp.client-ip=52.103.43.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="OHFzYYIp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3EutBM7xCdv4XMxjDxcWRkqUHOcqrtrlcTEiMf/8W5zen3PIAxhkrDgDNu2ELV2qNWZfI27eWbReEFysCsKP/xbm4MDLhSfX3uq5DoD/2LQCMwbRuj8zoKetMgBWybYhATvZsG0HC3LF8IAjB+/ATOtsDCTP9MAHo5dM9b1sidKrMHQZWuF0rrZwDNg0VD+vjALoRrd2QthAm3q7Yl5n6XoO41zqt2RDyYubvxMRq23lTkq5vpcFtsijVdy2x3sZR+UNF6ICR/FJGV+JMdkUGd8wMtgVJ3Aw18hkQ6XuddHZoAGC85EJCJa6ZrXZhGwBmjoH9rJs4EdVUNnY505nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7XXQyWrdVHyvISqz9yOzretT6LfkUj6Z9eq10u9BrQ=;
 b=NkOfca8ZrwaidJ9Rwmu3wooUjDiMX5UPUemix9VMe/Cf6L7zD3sX1e3M9jk2ilodDAFfjNSiLHMn4yHMy3QkFrF9GJRzwjfgc+RIrPiP7uSDLO7+RR3UEDiJCj47/xaxB3QKZDz1XTApFqLwE1Au24Gnn3PK0XauBfuT0YrWumqCtb0n3+aoWBMdGC1pZqJD9nK30iGe+Bjyk6LxECptzmlOV3Gwv6X503QO197gDjwUMeaSgpQyu49uwlBQMKiFDRHHUlZ2KEwEb0T05RB7sru+iyZq7AglxlrTXPQUHBJX5SRYWstSZEyuJXOF077bOErdIf6oAy4eW8rmDoX/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7XXQyWrdVHyvISqz9yOzretT6LfkUj6Z9eq10u9BrQ=;
 b=OHFzYYIp/sQ5dXFzPtUwiD21tQ8L0ibIPn5MoE+uf4VLUapBCIverzzMxndNqwnJfIsNiYNCR9f8M2EecqotpN40VrJxl3b4/DbHOWd0ApKOavuTjEb6RUA51BVfbYT4mvxDWUwYAzBk2Ej73kbMFR0uvWqggVebEH8WIL4UrPw+etbnnnVYgtQwgUwnQUTNqg1DypgDlSOOvKYV5vRteJiYRl229FK08hS6T6qC2g/V/LV3eliKn6fcyt6zhK0d/BmhJCuehye0TmicWWmdOK6uYgcO3qsPjU7RQNCiU0gv59eL1oE/o++3LDxhPm2XbpGtxxC1dn9q8ZOg/IbPbQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB5767.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1a2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 14:40:06 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 14:40:06 +0000
Message-ID:
 <SI2PR01MB4393076C1A538DBA3390ACE5DC6BA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Thu, 19 Feb 2026 22:39:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] PCI: Consolidate delimiter handling into
 pci_dev_str_match()
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 bhelgaas@google.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 akpm@linux-foundation.org, bp@alien8.de, rdunlap@infradead.org,
 alex@shazbot.org, kevin.tian@intel.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <202602161621.2nyGIEhM-lkp@intel.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <202602161621.2nyGIEhM-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0004.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::14) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <1dc096b9-2cfd-4db0-82a5-b5b35e426fcc@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: ad027c2c-f7b0-489d-f2d6-08de6fc4c5e9
X-MS-Exchange-SLBlob-MailProps:
	VFhsqcmgFg4CgpaPS+bwC1maR7GYCMJnfmWUmY+LXnwk+FcxvbdOTEbEkQT82vCJoZpdKnGAgVQE0M0pNF2o46F6dbn5BNOb2ohsnl5YVBrIkTlGJZS7o4TjRrGL4rFawXGy1J1JY2UQA6vR1yziI0ekcfbOuQFSTpURQnqPcTL4kNQf9DMkUc8RuHMRiSmyaM7+Vu7STwyxWT/8eJ/I0dSzwBJG4ADkAMKvGzWXOqddPd5iSZqilEt2fowq13I3R3Id/AlwJAf7OjqSHpgSmg6dsrJ+QhxqHGk+TOAMIzpo4Z85K1P4W5HoNrPWSWeB6ZxVbfJBODqwfb7ccxlagdtK2Ek4xraL7GaDL7X520daCdKjw3tNr/hectJ5+q1mRs22bK7DoVdEWnXMErjUnpSqmp5rrtWGd9oG9JdJL9H+UutQeIYl31IzHSAEzqEo5HRS7jvB3D8C8cP1c0BiRD17lEmt1kCZvGxRu991KLPFQAnfFoqd8FwrQsBPK9KAQG4KyGlhBPltD/TSwfoyliGQLMLF3HtSw1oi3qulSyNskNckbdcrXR77OxsD1th9JAJGfM7WKe4wQ/Vbz9A8ueEkQZc/UzL2ngBOjmtg7jp1yiN1U5iLh4puHvJTpI48uZwN0IoOp5STZg9K8rqhKAtbYPx+H/HdwUIegwRvcbUVl7T8Yru2w88RFHPwj2zPyu371CyNhFWGnhXmHFy6+ahBVNTBpAcBqGzLc+xge8Re/mxpv7izEmr34cLN1vRW5eclAQI0HN8Ipum8hI2IDseFCSAfd9WuOFoGns86i8s9R9ktxlmB9HJ6aEKW5QIeSAzLzpZOype2AUDB1XNjc8nBcG+Tid1G3QBOPkTs6v9dmq62z9c84CzIk8r7WSzkBTyOnmAb6rTcZ6x4poeenhXggT1/7Q9K/l4tukSe234=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|41001999006|37102599003|8060799015|19110799012|51005399006|12121999013|15080799012|23021999003|6090799003|5072599009|1602099012|40105399003|440099028|3412199025|4302099013|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDIwQzJjandWZEw2ZzFud2lxS0NMeE9Gb1d4UXgzUk9BQmg0SkI0UVNDTVdm?=
 =?utf-8?B?bERqMjJaZTNnSm9zUkc4SU82MzJxNHBXaVlwQUJJZFRkRGhZUHJaQlk1dnhm?=
 =?utf-8?B?UFVVQWRHUUQ5Ukt5ZXBPRTNEM3JIZGowSmQxVXB5aGVJSWhFQSsraThOWGVM?=
 =?utf-8?B?MGU5K2lNdm1NYzk2ZEpLSVRHVytQVWZCNHFhbHZqLzVWR2hwRnpPa0FWNlk4?=
 =?utf-8?B?YjJnMmc4NGJnZ20wN1d3TW9QUkxsWXJ0bzQ0eEFLUzRmN0FoblV6ZHYxaVNY?=
 =?utf-8?B?RDBhb1NrbFZTUlVaQzJ3OGpibmRmcXdoNzJkQUF3K041cUxWK3VQWDlwY1d4?=
 =?utf-8?B?M1ZDamxWYnRYSm5YZ0I3NmJZSHVJUENoeGFqaHRCdW0weGN6S3NjMVB5WnZY?=
 =?utf-8?B?RWxyc25kR28wYnJOUVlrMG5VNTQ1b21WYlF5ZVNpL3o3eEtidHZ4ak5nMTBs?=
 =?utf-8?B?ejJSNnNiNWVFYmg2SXplT0dBOUYrODhaMDBBR2hzQ1d2RFBnU2V1c0wxOVg5?=
 =?utf-8?B?RWwzcjhOYXdITTR6TzBFUk9sNUJUM2t2VjZqazd0RndmS3hMdytqb3Jlbm44?=
 =?utf-8?B?SWRwUGtUMFI3R3ZlUkxJYnZuaS9VbDJRZXI1MkRxMXp1SkhTczI2M1FWTUtD?=
 =?utf-8?B?UC9kNytPMFBYZXpVYWV5NlVlazZKclpValBPSk5RRDNGTW9pWFd6bTQ1c0hR?=
 =?utf-8?B?RmhPVnB0bmQ1K1NDSXhjdWV0YVFJdXNaT1VmWnRNRk5zRjhmUDVpYjRYTkNE?=
 =?utf-8?B?NTJ1QUZpTTZ5TTZkSnNWUmZSRWdOcEVrK0lkZS93ZmlVRHhtOFkvcmhSdUhy?=
 =?utf-8?B?YUtkalU5emM4QTY0M2Z3MVRvaTNHVTdBek1RMjRmblV2MEZZcTRhSXdEY0VJ?=
 =?utf-8?B?aStvRExpVTMrY1dBWXZab1hPdm5vT3lnd0tYMEVzaFpqdG5od2NTbHBIcTgz?=
 =?utf-8?B?ZnZFSG9nMTNtMDBmUEhsM0tQSFduamRNMFNueWtzdzVkdS9GVm4rWCs4S0x2?=
 =?utf-8?B?anVaMk1rYVJOVWkzZ3NValNvTGdFVU9jV2RyN1RhTUw4bnYyMU4xQy9IYWRz?=
 =?utf-8?B?K0t5K1F3bXFNL3ZFblhQcHUzcmlyRUJOamViVTVZME9kWDhkRUVHcjlXeUZJ?=
 =?utf-8?B?anVrU24yckhWN2sxTllUcUI5R2NRc094SXJ2N0NEaVpMOVN0WDFhMVc5U2RJ?=
 =?utf-8?B?d3RXbng4M21BYysxQnNNdmpvaGJhR1h2SHd3WHdKZHk2YmNMaWRtOGJFSGhH?=
 =?utf-8?B?WExLMzBwQXNzL2ZGK0w5UTBFVDFvM3FQYXN5SnR4YW5GaFVmWnl5Z1J0SXpW?=
 =?utf-8?B?WkZ5YkZObkVGb3Yyd2ZwemNFYnF3R3krL0V2TkluZ1BYVTdXYTRLZ3p6eDJy?=
 =?utf-8?B?Ti9DQlNjQ0x5bXJuVW4rak5tcUJvdlJqdkVTdk1nSngvMnNEN2pjeStvRnhp?=
 =?utf-8?B?c0NQS2NYNjRDamRLKzE4ZERlM3dCNGlSSGxGN0VqMHhvVk9YWXpMbjNseGpP?=
 =?utf-8?B?TGRRRm92R1hkSGUraC9rd3M5d1RGditMQS9MRjY4eVVjdGdvYjEyWHlZcUNB?=
 =?utf-8?B?cTR5WldXaGc4eS9KUHZ6Q2pxV3pqRTlUai9lN3A4cmFLY3F0VWV2SWdpMm5E?=
 =?utf-8?B?K3VjSWhicWNRV2d0eTUrcGdGOTJscTZpblRydjFlUStEUDE0dnhoMU9TcGd1?=
 =?utf-8?B?c2VqUTVkdGhYK0lRalUxR0taVGhJaklIbWE0U3Y5RHp2SzJha0d1KzZtSmVE?=
 =?utf-8?B?V25kcnV6bVpEcGJydDlmNDNuM2ZVWm4wd1ZaTk5PcU5CWXJxVXFHaklDajFT?=
 =?utf-8?B?RnU3WnBoS1RCWkJFRnJHbEk1QVZLSTNlZjAxNzRKN0FaREw0QUtGOVZmVHR3?=
 =?utf-8?Q?zh8vOlKxB1DaM?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkpuQW8wRlBlNkprcnc1L1dBQzVPUGhYc1FnREhhZFM3OU9mUGJjSXpuTENv?=
 =?utf-8?B?RnlLTmxsaEJXTFBnV3FpMXhta1Y0Nkh1bE5nRjZaNEFJcTlmOWwwcDlKMU1N?=
 =?utf-8?B?TE5OMTRXRDZpOTBOb20wWkRHL3RuWm9KSnFMZzRFTFdsWHdJUTl6VUdnbit3?=
 =?utf-8?B?d29iU2dZcjk1dkhaZ0U5V3hrUGYvWlA1cTFWbmh1NTdxUVVGSUxXKzBZKzht?=
 =?utf-8?B?VSthYnliWFVrMHRpSXVvSDhSVkhCaG1PVkhYTy82eFpMcFppN1N4UWN6WVVo?=
 =?utf-8?B?ZkV6eG5ISzY1TUdHZTNxbnlDUzJkS3N0R2hadU9BVm1hWmFMU0RiM3dkQ3RC?=
 =?utf-8?B?bWliTFZzOHV5NXE5RDhoTUh1YnJmc2czNkF6UnFhdldnK0o3Y1FqKzhsL1hD?=
 =?utf-8?B?eEZ4SnhaQmY2ZVcxWTZHM2hyeTRhTVlqeVhYcGJxMlRBbnZJVmYyclpoMlZ3?=
 =?utf-8?B?a09tcWljRU5naUJoYnY3bG93dXJPVklIN0E2ZEpTSkVnaFkzczRqdHphdlJI?=
 =?utf-8?B?TXlhalZCV0JFQVQyalhwSFhYTEw5Sng5ZHFUYmRVclVMNTVKbHBBYTBlMFds?=
 =?utf-8?B?ODh6eXBzTE5GM3VTNUpFVGpGZHdUZnFoeGtoc3RFbUxVN1IxcTZaMlVYNWJF?=
 =?utf-8?B?L2xBcDB3dWlBdHRMVGZPQmtHaGVEaXJJcE16U2F3WGZYd2l4N2duaUpYeWc0?=
 =?utf-8?B?MXJtT2owOWF2MHpOYzVaSktTQzlGQ2xMWnZRMXlDakpQWWVOYTRnN3dFMUI5?=
 =?utf-8?B?eFM2bXRJQmRCRCt2Mk1OVnVLanVOMmg5ZmJCYUl1dmpoSE5lb1MxSjc3K013?=
 =?utf-8?B?ODFPUUdVNTRkbmUwd3lWQlVTK2pEL21OVEZmSmxqRm4yU0NGVGFJVk42MmFs?=
 =?utf-8?B?SHVHS1dlRGRoRFN3dVVrVjNTeGVGcDdFV2VRZjB4bHFuZUlmekpvZHNBTEpQ?=
 =?utf-8?B?dmd0R3pOVGZhVkp4bTIwZ0FnYkhqaDhTZ3Y3ajVTcUxBWWNTYUYyclkvNkdQ?=
 =?utf-8?B?MmJqZDhHalk3MWRqbDV5amhaRDBaSmF3L0hGQWxzMmJsbEhoNjhYQU91ZEVS?=
 =?utf-8?B?eVF4QnQ5SnhmYmQ5cy9YNU5vZVZxUTVobWs0VVhxN2FlTGFxZDRVOThycDFU?=
 =?utf-8?B?V2RPMitCbmRsQWhqd0lZaHZFeG5NSlJlV2I0ZEFEQTlia3RFTkorVUo5R1hn?=
 =?utf-8?B?MTdlVHMxeWZJaEpVUWxDb01DRllkcjR2SEdwNitDQTBZN29YTitTSzZVOEZF?=
 =?utf-8?B?a0tha2JBTTZiUmtjQWxRemc1dGFwT0NTOFJjYWxZMSthdFlrMFg5NDBxa3Q5?=
 =?utf-8?B?Yk0rR3hMVWNiUHBmWkM5K3FoNjBMRklFc1cvR1BMSnROd2tDRnhlYzdBbkFW?=
 =?utf-8?B?b0hHSHhaRHRHcEhnNDdQb2N1dzBlWjNrOTZzd01zVERWKzBrQWh3alhrb3Fh?=
 =?utf-8?B?bDhNZmthc3BqdlNzMWpCT2FuczNtakRwQktYWWk2N3EyajZTbW1oZm82VGFN?=
 =?utf-8?B?ME9RSFc3bWJRSTFMS0lDRmNtcnl1MkxhM0kweC9SQ2FMRXk5VjJlYlZmSWty?=
 =?utf-8?B?cmwyOUdrTkRiZDZ0c0FnQ3dZbS9qNUlPQjBXK1NGZWhTWEQyTjFJY3Q2MU54?=
 =?utf-8?B?UjUvajRXdCs5Y2pjaFQ0QVlYV2VuNVBya1BPMjZuMnlCSWt1aE1PcjZKOStr?=
 =?utf-8?B?OXV3dTFaWDcvY3lERTluZnhZUEdnZlpxUFJNYW1sWXk0M29yOTd3SW5YYnlZ?=
 =?utf-8?B?TzMyUXBMNzF1ZWNsblBrcytabmhFRjM4YnJ0aytteDBJeHpiVnpWSTgzRTk1?=
 =?utf-8?B?TFVDb29PUS92RDBDVjR5bUJ1TWh2c1RyQ3crRVBTd21SYXRkTXN0dkpONmo2?=
 =?utf-8?Q?6BOfFYqnwFsQq?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ad027c2c-f7b0-489d-f2d6-08de6fc4c5e9
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 14:40:06.4628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5767

On 2/19/26 3:12 PM, Dan Carpenter wrote:
> Hi Wei,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Wang/PCI-Validate-ACS-enable-flags-against-device-specific-ACS-capabilities/20260216-103055
> base:   635c467cc14ebdffab3f77610217c1dacaf88e8c
> patch link:    https://lore.kernel.org/r/SI2PR01MB439352E0D54243099CAAA118DC6CA%40SI2PR01MB4393.apcprd01.prod.exchangelabs.com
> patch subject: [PATCH v5 3/6] PCI: Consolidate delimiter handling into pci_dev_str_match()
> config: x86_64-randconfig-r072-20260216 (https://download.01.org/0day-ci/archive/20260216/202602161621.2nyGIEhM-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> smatch version: v0.5.0-8994-gd50c5a4c
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202602161621.2nyGIEhM-lkp@intel.com/
> 
> smatch warnings:
> drivers/pci/pci.c:430 pci_dev_str_match() warn: sscanf doesn't return error codes
> 
> vim +430 drivers/pci/pci.c
> 
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  343  /**
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  344   * pci_dev_str_match - test if a string matches a device
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  345   * @dev: the PCI device to test
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  346   * @p: string to match the device against
> 40549484c434de Wei Wang         2026-02-16  347   * @endptr: pointer to the string after the match, with the delimiter skipped
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  348   *
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  349   * Test if a string (typically from a kernel parameter) matches a specified
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  350   * PCI device. The string may be of one of the following formats:
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  351   *
> 45db33709ccc73 Logan Gunthorpe  2018-07-30  352   *   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  353   *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  354   *
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  355   * The first format specifies a PCI bus/device/function address which
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  356   * may change if new hardware is inserted, if motherboard firmware changes,
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  357   * or due to changes caused in kernel parameters. If the domain is
> 45db33709ccc73 Logan Gunthorpe  2018-07-30  358   * left unspecified, it is taken to be 0.  In order to be robust against
> 45db33709ccc73 Logan Gunthorpe  2018-07-30  359   * bus renumbering issues, a path of PCI device/function numbers may be used
> 45db33709ccc73 Logan Gunthorpe  2018-07-30  360   * to address the specific device.  The path for a device can be determined
> 45db33709ccc73 Logan Gunthorpe  2018-07-30  361   * through the use of 'lspci -t'.
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  362   *
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  363   * The second format matches devices using IDs in the configuration
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  364   * space which may match multiple devices in the system. A value of 0
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  365   * for any field will match all devices. (Note: this differs from
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  366   * in-kernel code that uses PCI_ANY_ID which is ~0; this is for
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  367   * legacy reasons and convenience so users don't have to specify
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  368   * FFFFFFFFs on the command line.)
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  369   *
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  370   * Returns 1 if the string matches the device, 0 if it does not and
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  371   * a negative error code if the string cannot be parsed.
>                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  372   */
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  373  static int pci_dev_str_match(struct pci_dev *dev, const char *p,
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  374  			     const char **endptr)
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  375  {
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  376  	int ret;
> 45db33709ccc73 Logan Gunthorpe  2018-07-30  377  	int count;
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  378  	unsigned short vendor, device, subsystem_vendor, subsystem_device;
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  379
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  380  	if (strncmp(p, "pci:", 4) == 0) {
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  381  		/* PCI vendor/device (subvendor/subdevice) IDs are specified */
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  382  		p += 4;
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  383  		ret = sscanf(p, "%hx:%hx:%hx:%hx%n", &vendor, &device,
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  384  			     &subsystem_vendor, &subsystem_device, &count);
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  385  		if (ret != 4) {
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  386  			ret = sscanf(p, "%hx:%hx%n", &vendor, &device, &count);
> 40549484c434de Wei Wang         2026-02-16  387  			if (ret != 2) {
> 40549484c434de Wei Wang         2026-02-16  388  				ret = -EINVAL;
> 40549484c434de Wei Wang         2026-02-16  389  				goto not_found;
> 40549484c434de Wei Wang         2026-02-16  390  			}
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  391
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  392  			subsystem_vendor = 0;
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  393  			subsystem_device = 0;
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  394  		}
> 
> At this point ret is either 2 or 4.
> 
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  395
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  396  		p += count;
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  397
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  398  		if ((!vendor || vendor == dev->vendor) &&
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  399  		    (!device || device == dev->device) &&
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  400  		    (!subsystem_vendor ||
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  401  			    subsystem_vendor == dev->subsystem_vendor) &&
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  402  		    (!subsystem_device ||
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  403  			    subsystem_device == dev->subsystem_device))
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  404  			goto found;
> 
> No imagine that we don't goto found.

Thanks for catching this. This doesn’t cause a functional issue because 
current callers only check for ret == 1 or ret < 0, so values like 2 or 
4 are effectively treated as 0.

I think we can set "ret = 0" here, then..(see below)

> 
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  405  	} else {
> 45db33709ccc73 Logan Gunthorpe  2018-07-30  406  		/*
> 45db33709ccc73 Logan Gunthorpe  2018-07-30  407  		 * PCI Bus, Device, Function IDs are specified
> 45db33709ccc73 Logan Gunthorpe  2018-07-30  408  		 * (optionally, may include a path of devfns following it)
> 45db33709ccc73 Logan Gunthorpe  2018-07-30  409  		 */
> 45db33709ccc73 Logan Gunthorpe  2018-07-30  410  		ret = pci_dev_str_match_path(dev, p, &p);
> 45db33709ccc73 Logan Gunthorpe  2018-07-30  411  		if (ret < 0)
> 40549484c434de Wei Wang         2026-02-16  412  			goto not_found;
> 45db33709ccc73 Logan Gunthorpe  2018-07-30  413  		else if (ret)
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  414  			goto found;
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  415  	}
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  416
> 40549484c434de Wei Wang         2026-02-16  417  not_found:
> 40549484c434de Wei Wang         2026-02-16  418  	if (ret < 0)
> 40549484c434de Wei Wang         2026-02-16  419  		pr_err("PCI: Can't parse parameter: %s\n", p);
> 40549484c434de Wei Wang         2026-02-16  420
> 40549484c434de Wei Wang         2026-02-16  421  	if (*p != ';' && *p != ',') {
> 40549484c434de Wei Wang         2026-02-16  422  		/*
> 40549484c434de Wei Wang         2026-02-16  423  		 * End of param or invalid format. Return -ENODEV so the caller
> 40549484c434de Wei Wang         2026-02-16  424  		 * stops parsing.
> 40549484c434de Wei Wang         2026-02-16  425  		 */
> 40549484c434de Wei Wang         2026-02-16  426  		return -ENODEV;
> 40549484c434de Wei Wang         2026-02-16  427  	}
> 40549484c434de Wei Wang         2026-02-16  428
> 40549484c434de Wei Wang         2026-02-16  429  	*endptr = p + 1;
> 40549484c434de Wei Wang         2026-02-16 @430  	return ret;
> 
> It should return 0 here but instead it returns 2 or 4.

.."ret=0" will be returned.

I changed this to "return ret" because in the earlier branch we set
ret=-EINVAL and expect that value to be returned:

if (ret != 2) {
	ret = -EINVAL;
	goto not_found;
}

> 
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  431
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  432  found:
> 40549484c434de Wei Wang         2026-02-16  433  	*endptr = *p == '\0' ? p : p + 1;
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  434  	return 1;
> 07d8d7e57c28ca Logan Gunthorpe  2018-07-30  435  }
> 

