Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0209533D6;
	Mon,  2 Feb 2026 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039368; cv=fail; b=Axl9QsYVtIMlw8YyGcXgTAnwdyuBO5tbjE45o8A22Mu9hupO14sjGdt0Swy7WEO5swfBSVm0IvxsgROutzVxBtA8e025/jlcxJxz2Sv0gFt4SfM2Mmspcu4wdwE+bWxQgssYExMxl7UgJxZ/e9+1wZ+Af9g3LNvSsYF/yClzVm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039368; c=relaxed/simple;
	bh=hcvu4nmUyxFvQ7ebNkXIfv3nxoN0j6d2yH+Pu/601ew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=swPMklyamvN6kHeysq6Z7hytkSDlqqyR94tvByw8iPTvVYn3hESD9ZP6sC6k8EQlqJjDHttfOKqVig2CmcyibQQfkuw/Y2roFr7IoWOlT9KamLu5VkAmlg1JOrqsow/k8Tx9EBB2S8AtGCgLlV4l7a8B9lWi4C7L38QyN9imu4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X0dU34JM; arc=fail smtp.client-ip=52.101.85.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X0dU34JM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fj1ay1D5A3+VnFebaV9vwHoFJh5PG9AwRdRjC7uRavdCXetO35shlCwQIVSLhwENsDudsTQVMhQd0s0VMV/if1688DEFxkVV/XJKlp6MxEP4rgindrGaOKVHQURwoLrZDQ7aoH2w13P6xU9WvaEzqX9KGujQ6U39/QsA5cGVIP7qDkS3WZQ41kDti85Pyg8Ryfws2+VI7Q9Bmoi6kmrup6fs60cJb84E0A39pTa4pnpnVGApL/T6Vs5LK1ZQKSi8J8xDj2TvJ0K9uNGNOluV3cR3uk8h2UxIp7Wahip5z5CN0OCrxAiApN6KNz+NfeZ1EpQcaQiJ6jTvaj71fqhdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcl+vbFLeJwQ2Iai85u+vJzznBamNxkLJUAoxVRyYIQ=;
 b=hRjDPGO+SD1GSL14G76zhhqBuoFxXOghKtUOHTJIJwNZgoePZMUsaSxqZMgQjKQwFcxMahFEf2SAJ40JyoSOOcMZ76Vv7trtKwxQR46jJ5BdNMEO0uZX4rV161hZ8l/9dKhTZk6owXB5uRg6b5z7r5QtTmrSTN/3wZgPcXUJ+HttppQ6Th5JEYD2En6uItfzSk9ubvQ2Ve27FoQNe7xO0nDqv/xMjYpubzUWBVpMW7BcswQaq+3jHxhFcoiXVBzi/bjwZVHJpu4p5f0C5VlfXqy7muP7F7CZ1ElE8sS5mZPIhAh4U0RM6F6cLa6wBfZjlXfvfdC6SI+Bk6gIGAzc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcl+vbFLeJwQ2Iai85u+vJzznBamNxkLJUAoxVRyYIQ=;
 b=X0dU34JMp4ulQBWuSIi+7SW39vO040OwuYr/aB3HHO61p2nNiGWMj2VY7hypi/lrw6HHBGgx05eYllhldCd+B6QYUvXrhx/1AedWBLeT5Hr59TCAzBRrxwRQpb+d2DUFiepHVvj2fBDaQz+LlLDZi6l8FXBJS1pTyQToEna++vFhaSXo20YUOSifx7zIPPm2AE8bU1mGZ4IGkx1E+YakSzmCftRwvWRrY26fbsZdCNwXF1+AsglQ57VfeFpYkLHaO6s3SE6hWOfZsp4onaVSi+lNaEc40xE+wENyob997D5TUqZwJNzs/sXh/pFdh3e57oYcdMrO68EoB8zx9x3tuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 2 Feb
 2026 13:36:01 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 13:36:01 +0000
Message-ID: <b44cbfc7-0f8f-41b6-b118-c32602504bcc@nvidia.com>
Date: Mon, 2 Feb 2026 13:35:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/22] Enhancements to pcie-tegra194 driver
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0067.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::17) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: f06cf21f-3834-4b48-966d-08de626001ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUVLNXJOdzFWSnhwTTJadFE5YlNTUHJnV1k4UmxjL0xDZEVYRk1Vb3hKZlZG?=
 =?utf-8?B?RVhSQUljZWJ5a3JvWEh0aVFaRUUxWHQwamh5VjRzWTRXWUZZT1l4MGRLMXpB?=
 =?utf-8?B?TS9VVnBtNkZhOFdURTJNaHdwdkg1L0EzR2EwRWIrR2Zpejg5b2lPMXNIY3B0?=
 =?utf-8?B?WExwekVoUjFreVI5SW1WUGtYcWYzN0k5dlpKbXNnbmpxQUVFcnlPa1BLRzdm?=
 =?utf-8?B?NnJjSnZMNlNmbDhycmR0WWtETTRlQ1dJQ0ROMjVFNnhtWnI4aDJYQnZuRzNQ?=
 =?utf-8?B?bDFHVEd2ZUlONDZGaUk4R2cyVVB6QXcvR3RnRFJsRzJMdEtsV0lKWlROa0JQ?=
 =?utf-8?B?OHlNN3J1SkpRb0lucTRUQ2lrcXc1ZVI3RW1xa3Qyb2V0WTFTWHdxMjRBREFj?=
 =?utf-8?B?dXVtUUF6eExBbE1qeWZJblpSaUoydEtTM2VaVVBjQ084Nm1CT2RCS0UySVhw?=
 =?utf-8?B?VDVxdmN0ME1PVGZyUW9JcExSd0xocVIyY0NTSFhUdUl5UFkzZkJRLzcwQVdn?=
 =?utf-8?B?ODM4MU5GOWo3dWhzZVRhZ2RFc1dQT3NmM3FpaGttaVNra0YxYTVSNEtONlQ1?=
 =?utf-8?B?RUhWRXdGVVJPM25Yd2dyWE92akREUGszNlBTbzROaENJM0tkMjBqeFBHcHY2?=
 =?utf-8?B?aGZtVFdCNy93a2picC9FYkxnSnpRWnE5aFMzcHg1aXIrVE5DcjVmR2FqV0NO?=
 =?utf-8?B?N1VRZkNWUlArWmNmQTJUcmppdnpWUEFOUmt1VjNERW5YemVkZUxOOUpiaFVa?=
 =?utf-8?B?V0NRK1FrMVFUeHhWcDl6ME1vZ0NOZjhYYzJvVys2aklzRzRHWkVjVzNLbWRM?=
 =?utf-8?B?UG84UVJOTGkwa0lrUFBodWVlOU5WWGpyTml3cmVtMUNNVTdXN0tjdExmMU1i?=
 =?utf-8?B?U2VBSXBkWVIzWTB0bWNkTEFUMngwWFBWYmRhcjB1Vlhla2hQSTNOVk9FYW5U?=
 =?utf-8?B?c0NiOGdvbE5KZEROWEJFVjcxVU1hM3NiaUtoK2cwdXRvd1dOVHovVDFzWGdl?=
 =?utf-8?B?TG8wcnV6emZnVmRlMGNSaEdhZ21LVkNyUlRtQllkemcwVUg5SmcyUlhkTlhK?=
 =?utf-8?B?UmQ4bVlZYjBXTlIza2NSYlYzUFhZanMwMXBuUEQ4SVkweWREbWZsbjczY2dl?=
 =?utf-8?B?QnVXNUplemdrN1QrZTJtZFQzTUhocUFFV3grcitLdzV2cnFBTmxyMmgrSnFs?=
 =?utf-8?B?UnY4U2JpQmxXQk1nSjBNWTlySVkxb2oxZUx1NTBDTmZSNnRxQ1Y3UXlWVEp5?=
 =?utf-8?B?NFFDQjR2MEw1SG5WbDJ0VG5XTzE5bjVBME1DWTNJTXViazZhZWdXVVViVTV5?=
 =?utf-8?B?d2cvUVk1bzVEKzhuUXhtblNRbGRTemNlaExIMlFKY3JoSW8zdExidXU2UTY2?=
 =?utf-8?B?V2UxYVBKSE1FemcwOGorMHRLZ01qNU9oaXRldDRPQVlpMGR5TXFuUnBpWjdU?=
 =?utf-8?B?bjQ0bktQMW9pZmZqZm1SVDg5NGpENXhuMUErR1RnRXRTSWovQ0orZVIwbVVM?=
 =?utf-8?B?NTBUL1pOUzZObWVzalZiK1VRU2dmM2FacC9LQzJPM0l1RWRvRjEwcDdvYnZE?=
 =?utf-8?B?TElzd083Yy9lTUR3WjIyM2YrRVg5aWFrcU5qUmxsbXZpVDluWmJrbWtxYTFy?=
 =?utf-8?B?TzllTzRqYnFrSHRwWW1HVnV1dktUT2szK0JOMmJXcnEvZ0dtR1YwUlU4UU05?=
 =?utf-8?B?S2M1TkVGY1hXbnlRUzFzTlc3TkxkaW94a0x0UlRQbmtWazl0WXVHNk9SbW02?=
 =?utf-8?B?UGxlVTVjZnNGVzFmYjlpcm9pNkNvcllMQUlUL2hYNGRlRXA3TzZEL2VoY0dt?=
 =?utf-8?B?WlVpNElYOTVvdXpkVDNnT3k0TkZBU1pMaFlCNU8wRUJpQ2hxQWcyQjVGcGt3?=
 =?utf-8?B?cU42NVBvK3FiSWVwY1lUN25CVEI1VDFLN1l2QXdMQzRrRkVZckVwS1BPdXhR?=
 =?utf-8?B?ekRCbXFCTXprOXFwTW5xdWQrSmljN2MwR1ZpQ1NCRlFOcDhwdHJiWTR5cW5y?=
 =?utf-8?B?TElLZWtqejBHRFdFOWltTnljT3RKb2J1MU42TGU1RTcrMjIxRUtKbFpVbXhB?=
 =?utf-8?B?RSsvRGhnYXRmRzF5OWpWK05VN2g2MWFGaHN0OXlPKzY1cmpzYWpyNTVIWG5W?=
 =?utf-8?B?cGpQOW9aY2NKUGhNTjI4VkE4WnA4cHU4a29ESUVmci9ITDRCQlR2OE5Yc1Jj?=
 =?utf-8?Q?SQA4nK8d/Keu8rvIkjZfj2k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkM0bVloVmVsY0J2d3pteXNvVGpiUENyK0tJQm9VVHd6eGlPWXFFVlNEUk9G?=
 =?utf-8?B?U2loeEVTZ0ZiM2NkTzJZd2hFVzJ6bUlnSTZneTYwREl0OVl5dnVmNkZ1OTU0?=
 =?utf-8?B?dFNSeWpMdG9JZHdZb25sRkZWc2M3T1NuSnhqLzBYSzZ6N1ZmblNVNVU1TUpK?=
 =?utf-8?B?c0NTYmVDRnF1Q0x3N1hPVk4wN1RqNnJ3aTV2ZS9HeUV5RVRaUExRRVhYVlpo?=
 =?utf-8?B?cTVnQjBFZGNEeE03MXRkQnpkQ2tUaEp4cHE5MzVYQWJCekZLZGMwMkRPN1Er?=
 =?utf-8?B?dUJIK29JMFdXQTNGNEtBc3YxMkxWQ2FPYW9HVitCdFUzQmhBNitDbTlTZmM1?=
 =?utf-8?B?TlZ2ZVRsSSsvMWkrNWJEK3hXU1ZYNEpCQVRPUm5ITWowQXFDVFM4MlF3bGov?=
 =?utf-8?B?YjMxbDNmaXV4a3dQTHZZbzRCbnFCUXBGYThQRSt3WmhIaUtaaUdMRUhRT29Z?=
 =?utf-8?B?aGg4RmMzNHN0cUNtRjh4YmZuVGZRSlRhTVJPR0NWbExZdnJCNGozTkRkVzN3?=
 =?utf-8?B?anpqeDBmZnAyTXgrUW5henlDSkpxK1VJMEF3ZTNSTXFyYXY0eFgyRzF4S2tu?=
 =?utf-8?B?b0lyam9QKytWdFF6TldJc085cGFsRFY3SWdaVGN3aENJWkJvVjFhSFg1UDg5?=
 =?utf-8?B?cjFyNkRwUUNkd3pCdVNVQ01adkZrZUhvRGtIS29PRGhVUDgxemxvMXJ5aHN1?=
 =?utf-8?B?TFQ3aHlBSFBjcHJVdUZuV3E3OWhzRDR2MjQ1NWs2cDlxSVVjTEs3TnE1RUlp?=
 =?utf-8?B?ZEF3ZmhUTTlubTJ6MFJ2Qno4TFY5aXRHYno4Vkt4L2lkWDB1dCtmRmNscHRL?=
 =?utf-8?B?ZlMwMVcwVG5UUHp6bDlsU2JtVTdVZ1M3QXg3K3A4amJ6dmkzalF3TnU2c2xi?=
 =?utf-8?B?UWxhaUJYc0Rla2FQMTgwWW9oeTlWT3pHTHBPWkQ5MTdCdTZRZEpUSmhJVFdO?=
 =?utf-8?B?TjdxWmh4NzNkNytvSTk0VXpHOW9Rc0lPL1VOQVRIU0N5WWFSYmM4WWFWaC9R?=
 =?utf-8?B?ZUkwR1pMN1ZKVmwrMkNzVDNtd1dvY3BDanFLTzZhU3cvaGM2UCtHZ1g1M0ZC?=
 =?utf-8?B?RjBDcGJTRGx5NFJjME5Takd1Vm4zN2NLMU1JZzIvSDVFd1MxcFlkbmcyZ0N1?=
 =?utf-8?B?N1pDdHZyUTVwNXNCenhkQ2thY28zTjVTNkFLeFR6TU00cU5DZysyQUJ6ZGlU?=
 =?utf-8?B?OCtDaUQ2b3dFaFZ6ZGxYUVZhYlRTbHQzY2dDZ2ZZQit3cWszL0VZUFR3akd1?=
 =?utf-8?B?UEcwbXRoN204MGEyNUUvV0lUOERpSXAzSkJqNXN1WFZ3bVoweUVKYjJSdUtz?=
 =?utf-8?B?SHZxNGE1M2REdUYyRlBuVFBrT3c1L2kxVkxUSFhqd3dpWnZBMjBuUDBhWEth?=
 =?utf-8?B?Yll2VTlvUUM0S09DMmd1ZWNxVUYyY0orRGViKzNlTTJsSlhnU2t0cUN5UXNy?=
 =?utf-8?B?L3h6b1hyNmZwN3I5VENNUWdpcGVBSXZLOHhoYjJYNk80YmliVUJLQ3puQ0J6?=
 =?utf-8?B?bjVMTlZ1RldDeGZKeXl5Vi9oQ2Fzdjdmd3huOThvc2FObkZ4ZlNOM2lPaTUx?=
 =?utf-8?B?SXdjdW9sek95d2t6ZUVVMzJXOC9TQmFiWWJhemswQWJTQWJSUDBabVlDbi9j?=
 =?utf-8?B?NlF1UTR0a09ldUkzVmRCYnVITmNLQ01NL1pKWGwydVh4OTJuUW9uRXNoNHZk?=
 =?utf-8?B?eWZFU0U4SWFUVFZaeVdCbVNOeVA0clRHUGVqVTBSQzdYOEhXVWlNZFlqaDVo?=
 =?utf-8?B?MHRQZ0hKeSs3SnlGZW9rZmcvRDUxNkhYWjVRU3FiMEo0RFNTSXRybGI3TTZP?=
 =?utf-8?B?ZkxjdlBnTEM0RlhWU0tob2hOUkNXTU9HMHNsZHowZERXWnk4TnJzcHZ2TnVS?=
 =?utf-8?B?eWJ5VVliZVk2RWJNbElYbkpXNXRVY0VJeGwwcDNQbDV1SUFaYXl3VzFZM0ZX?=
 =?utf-8?B?VTBBcFBzSkQ3cW1lTEJYUTFNaWRCUXZNenlaTDNYdTcybWVSeEowbFpla3Fv?=
 =?utf-8?B?N0wzQUxnTmZ3dVVTeHljTUF0dDVibHRheFlwVitVUnprSzk0RnlTSDlBcFQ4?=
 =?utf-8?B?WVFlZnRKZ3BTSDlHMjdFWmk3OHZhdkNTbjZibmwvTDhuUEJVdGFENlp2bmNO?=
 =?utf-8?B?cUlHMHcxL2pYVEwyOUEzeENST1J4ZXN5cnlMRksyWHV5SlNnVjl5K2NWQTBM?=
 =?utf-8?B?Zi9OcnZ6VkxMRGFpV3FFYm14RzBKdmZOa1NsSEJDSUhPNkpWcE5adk1OODIw?=
 =?utf-8?B?SlBYdGxWQlppakI3MVdFVVVRa2VaQWsvaGd4VGw5K2FRbWlTQ1JKbGRKdEtq?=
 =?utf-8?B?b0ZKOU9tMEZybklNRmJURitUZzlwWWtKeCtsMG41UDRLMGpCUlVDNDdLaW9r?=
 =?utf-8?Q?nTXDzVBhgs5agRVCInKVtFbCpM98wpMZzbFbaFvy2mkl6?=
X-MS-Exchange-AntiSpam-MessageData-1: L2iqYOLE0a93gA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06cf21f-3834-4b48-966d-08de626001ab
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 13:36:01.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MhQh3h/NrI2P+76oRuApm3NuVz7rtF8EqPNOUXAMD386tPScmjF9TlLs9LUkbeRnmJGihuUbDPN1AJ6BGEdIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194


On 26/01/2026 07:44, Manikanta Maddireddy wrote:
> This series[1] was originally posted by Vidya Sagar, and I have rebased
> it onto 6.19.0-rc6-next. I addressed review comments, reworked a patch
> and included four new patches. I verified these patches on Jetson AGX
> Orin(Tegra234 SoC).
> 
> Disabling L1SS capability based on support-clkreq device tree property
> is moved to common DWC driver, so I reworked below patch to disable
> just L1.2 capability on Tegra234 SoC.
>   - PCI: tegra194: Disable L1.2 capability of Tegra234 EP
> 
> I added below four new patches to fix bugs, commit message of each
> patch has the details on the bug and fix.
>   - PCI: tegra194: Add ASPM L1 entrance latency config
>   - PCI: tegra194: Use HW version number
>   - PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
>   - PCI: tegra194: Disable PERST IRQ only in Endpoint mode
> 
> I added more context in the commit message for below patch based on review
> comment in V3.
>   - PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration
> 
> Rest of the patches are same as the original V3 series, just rebased them on
> 6.19.0-rc6-next.
> 
> Verification details.
>   - I verified both Root port and Endpoint mode controllers on Tegra234 SoC.
>   - Basic sanity Link up, configuration space access and BAR access are verified.
>   - I verified that ASPM L1.2 capability is disabled for Endpoint mode.
>   - I verified suspend to RAM tests with Endpoint mode.
> 
> [1] https://patchwork.kernel.org/project/linux-pci/patch/20221013183854.21087-1-vidyas@nvidia.com/


Thanks for sending this out. It would be great to get all these merged. 
The series looks good to me, but I would say that if possible, move all 
the known fixes to the start of the series and adding or enabling new 
features after the fixes (such as 'Add monitor clock support').

Some of the fixes already have a 'Fixes:' tag but we should add the 
fixes tag for others that are also clear fixes.

Thanks
Jon

-- 
nvpublic

