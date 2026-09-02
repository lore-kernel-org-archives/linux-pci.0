Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864F372B45;
	Wed,  2 Sep 2026 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788325876; cv=fail; b=RWve8TNOKBOWHcjvaxE1y76rVevxy6307drWM+iHxymJYVSuem6dLnTDTngjClWRwH+/vc9CVtOTs5mgrd+0reTl+EuU78yOANTWGuwMoyHW8ciDt/tedhZgY7Nu29Sr2vUJL7WNaKNpn2i6npxYRNJuClMqhceqWP5ZrRv8yRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788325876; c=relaxed/simple;
	bh=ugyEJuZF5dAxFaKL/5hop8H2GIaMDA4AwxLkfGPhZgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LgET1HWRdsKOMP3ghe0tgARIG2mAY665E93c1Rccqzw9rZuvheKpOwn6KroBfu1lQDbkAlxxGlQNsZG1XJRJez5raGxa9wMBrT+pLJOnkOS9fCKzP7OyipmI8hFMK+Jkm6gxvkZqN55yO4xOYAELvxxwNS8AKBXvU766ID+dgyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UZPDzg+3; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UZPDzg+3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+Gug7uzpYz6V/YsXkujHcEISkR9nP8wdMGlZ8zOq4fria3JnfHG6Mr28rnkdEi5xOtIjPwCyzfZ2y2RHogzKnYPs2xxdcqjRRQDuqYkgvog2hhIPwsK33F/XLe9e6bWSlqyTO2h3YgcKUpuEFyreIS2NrlDx2L0yO0daOUFXKuEiC0Vwt0sE1ywm9pV/VU/JhvoDFYlJ+Cw9aR1o2ZtF+OHr/WMjrBOc1d2DCn74v5DFYEcPQ0++FOBM4XAuxfAwNHFzEKoynZ+ZwROeJdLDQtgImqRztNzd9mxay7VbJO3Bmih6OQzwpBKwYBrGUxujz/LiI2WcmD9zyElbm6Jww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5dsQjkm6Sfc3iPlR4oSg28ClTtH97SgeFmA3AI+ug8=;
 b=GVyV0awp6Ev1MwtCO3yTcqz/N4sgsQTLHI4y9X9vOXC5Uj2jAZLBIJDNhMSOj6pHaMZ0wiOGAntqtQCmsGCHiKl+yXrBhjiPqnx1qDN5aY5V6NGPZ0r7GXvSEPL2xL2awC08+snjduolzF3pnlD6fkTLhWAPc0MUqGGXS+MlmSUkB9e0T66PHayvP8QV6v/SJ6wOLNnWCV/BwWJpzxLpXvpB/f8DI14aKx+uXJyx89wyDlsat0LISNCBQF+srnxeypRvrWvv0KtZbM9rPYjwQcagQTSc7cEg+jJR4H1lhf/WtQL8Uof2by1GV4SWf4jvk/zMj/UN4JfgnXcsxXN9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5dsQjkm6Sfc3iPlR4oSg28ClTtH97SgeFmA3AI+ug8=;
 b=UZPDzg+3Gu8pZhb5hlAmiJC4s4NvmuypIjsY3/vr7tZnkF7PwcKlKxpuVBWnbajX8+JmboJIwJoWlbHiuqxMKOvkvltZYYp4Q3EXdP8CkigtezX5vjy3L0dnImtaHlRH9BvPl6yYH+034/oH4M8pGaTC6JBk4KmM7v5BBLxN+H36s68MGTZtQ3XxoCGIao1eww8zOstpBtHW5UKr/piFLgiTxJyiLZWgiUzbCBTDhcJMsKYDj99N5O4xZDQcSwl62ibd2IQgNJtIj6Zb1ojO3H9leUk/GunV7WQewqXFMOZxYlvWYc4OkXUlsPMT/Ps7l4q37Duaj8qNBJi8sGtxVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:11:06 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:11:06 +0000
Message-ID: <093e50be-5a43-40c1-817f-bbcaadb3af76@nvidia.com>
Date: Tue, 1 Sep 2026 22:11:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/12] PCI/CXL: Add CXL reset support for Type 2
 devices
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <8eedb254-c942-4ee8-ab96-eb7c1ae577ad@intel.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <8eedb254-c942-4ee8-ab96-eb7c1ae577ad@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:217::16) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 56891a44-385b-4841-91e5-08df08b097c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|6133799003|10067099003|22082099003|18002099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	rQcHu1wwPZqz8ZOXQ0p5/2mudlCGrN3JZVhDuD10v6DuIUnzUVrHhD07IPKO4sIHrbrfVnOK/jczNPJKa9oMAuvTHQJlOGV5ly0KiJfebWKSn/E5g62MSsyHCICklhV8/izufWbInn9gfxQdln4fIBdRuRz/X7etCqeZt+MKjLycgBhFMR81l+Asf1NnTbXikNqI5IaaIBX/c0fBgUtUWozUZEKayh4+m5RhU8d58rJ/nHq9a7X+Yce7zGC0T6TpVxpbdbObmDfPZHhWoPhZdDZnO/rnmGLAAjfWF8X2wmUFxIOZdU48wqW0PaGpM0sVyR+knAZD3az09VQmHTAPb4QgFOZ0mXeld68li4Aua6XJESyiCnKPncBgsdFm4I4gh6CevMxs6hlhx/uSSyxPW/veZKGKEh0zmhMgq7effehuIT2C35QDTK2W/NurM7zUb5XqXeHhbMh8XeF26f1DS0NKgj5Owku4qfx8C//JyZNiX5Df5LYqm+4NA6fqJK1HKaFKr2P0JEhEf+Qyi3PpfyBuq7jkOiwuTk0uQo/sR8/cjouUoHb4OggDX4zBl6bVA7hWxuBdNJrd3TgzbFBPppZ5yDUS7wLuC6/0FCNZn5kg2l3OE+wP79sog0bAdRFEo5CA4wo2ybuBwZaYuDr7QxXTqm3bD4jiBmPX/IXMmqk5UwSgSTHTNHMlhGugj944XlNFmuB+WIBqSRo0pDk9fg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFp6akhiZ01vWkd6djIrdkxRY1dSYjZZWldKc0VEckNYZWRYcjgzS3doNzZE?=
 =?utf-8?B?bnR1UkFzOXlVMlAvZ1BIYmw0UkxWSk1PRUw0anBFbUNKY0VqVGxnZW9aUEZX?=
 =?utf-8?B?M1hNT3Z2SGJtYlkxUmtOUmNBYTNNUVQxZHpLRGpmU2dLYkVxUTBtRFdqZlBE?=
 =?utf-8?B?d1VzQjBnb2dTR2FXSUZJVE5PMHNRZkxQVnk3SWFoNE8zdGx4SWpkMnhHOEZ0?=
 =?utf-8?B?R0xSVE5tWUVNcnIyMElvUyszMGtuNzZkWm9MUVVHN2htMnR6dmhkd3VXaFhj?=
 =?utf-8?B?QUhOS3F6akRmWFNxUjI0MDZBNW9TK2xQMkEwNDV5b1l4Wmx0eTJ2UnB2THB2?=
 =?utf-8?B?RFNpei9rWTVuYkhPSXNKSGZQUEY3VWJYQTBTNVV5bW9UQS9RM3Izbm1HWXBW?=
 =?utf-8?B?K0ZKN3VsQjF1Q0RDSUJyWnNHQmhLQnZmSmljSVN4dndic2cvbkZGbFRrcEh5?=
 =?utf-8?B?UjZoRlg3V3lRM1JVQXlJMjcxT3dtQ2VCQXpzd3hvZEJEMFpZQkgyTXFwY3dS?=
 =?utf-8?B?TlB5MStZNGFvamd1eWtySVpFTHFwcWRzYmhucmVhQlU1VSt0LzNDNGpNb0ll?=
 =?utf-8?B?cHRINkxOMXo0cUd6aU0weDBXSFYrZHgzS1QrMEtjZk1yVmMyeS85OWVoZ0s2?=
 =?utf-8?B?eUFJK2NEMnh1Vk9ROW8wckc4WG1tSzFmblBFT1VTZm9uakJBU01iNWd5SjFr?=
 =?utf-8?B?MlBFckNMZzBUbG1QWUpFYVptbG5XYlpWWHJ2Wis2bGJ1ZDlDaXVWbDd3MW9T?=
 =?utf-8?B?akdxY1BvRGN6MFZFSE1wclVCZllPMmpOQVphazVnc296V2diSHE1c1hxTExI?=
 =?utf-8?B?eXUzR0RwVVJ2WVRWcWtQTjg2ckNpakFEN2liVmFvTUM2eEs1QXZmdm81eWMz?=
 =?utf-8?B?ak5NWDdyRkxHU3ZRem9pUUI1K2NXQVdmRlMvczJQSDlWUTB6dFJucUI1SEta?=
 =?utf-8?B?ZXhQdzFqL0RzejhZZThEZTZQckFpVU8vNUUwWndDbnZibThzQmZNRE51KzRu?=
 =?utf-8?B?eXF3bjZlRC9hSlp5Zld3MHNXV2xEWkU1WXQ1cENXWU96bkd4ZnhxN0QrSTBG?=
 =?utf-8?B?UCt2T0tzQkRkcHpXb25VYTRhNG9xMmMzOXFPMWljZXpOS1ZpTitqYURUZFJ5?=
 =?utf-8?B?aWUrMzgwTHJGdGZ0Tjhob2ZHblZLOFVETGl1ZUZ3T0F2L2Vod1JNa3crOFBp?=
 =?utf-8?B?b1c5eC90SHVpdTZCWVlOYWJSejRDVG5vak55U25WdkhFNDZSZ3FLVHZuWDI4?=
 =?utf-8?B?RFpzK3YvMWNYNndGMktyTVl5NVlCK1ArWE1kcmpVQkthNktnTktZSTRVRTJZ?=
 =?utf-8?B?U3R0Mis1QVMxNTlTVHAxZzIyMWs3WWM2RU5vL0R3dXJhM2Y2YVFHczdsTWRy?=
 =?utf-8?B?ZXQxcHF0STF5YXp3ZmxWLzVkZzhKaFJNK3dPM3YvODlXSks5VHFUTmExL3hL?=
 =?utf-8?B?MFBwbERuQTFKSUthQytHSDFJRThITisxL0d6MS92cGlRaWdsNTNxUWRmQWlC?=
 =?utf-8?B?SU5iTTk0aXJwalFuVWcrTjYvVmJsc1NUYVpuYmlweTYxV2ZldmlRTGI1KzRs?=
 =?utf-8?B?Rk9CdjhrOSs3emJQSmQzTlpEVkdJR0tRTXhaeEh5K1Y4YzNWWFJ4cnBTVGNm?=
 =?utf-8?B?RXJDbzl0bnF6eTlQelMwbGo1bUhqTEtmT1kzdW9seVg1M0pnRW1BdmwrcVpx?=
 =?utf-8?B?dDdvUFd5amlqZ05odzN1cWlpVFZYbytNZ2pzRC9EQzJNdXg2MVh5VUh5WXJH?=
 =?utf-8?B?c3hUcGxVNWdNWUVBenhPOXZjclFLOEQzWFdCV0lEeVBWNGNLZW9sdGo3ck90?=
 =?utf-8?B?WUVUYy83K0lWWGJ1Y2p6QVRlV1NTRFNkVFcyWXQwWm85bk04VGYvTXFocDUw?=
 =?utf-8?B?NDNSS3M2ZEMvYmErV2l6TkdHZDNrcUVLK3AxdVVWb1RJVlpNbnB5ZmdTYVZp?=
 =?utf-8?B?WmpRZUZJdjhJMXJYMlB3d2tPTE9teDlma3BsZ1NCUU5YRk9pWlZMUnBFbUM3?=
 =?utf-8?B?aE9WWEFvOEJ0S2RZUERWano5YitEOWd2ZTRqenhMS2RxR3E1eTdRdi92MTM4?=
 =?utf-8?B?ZkM5R3VQMVhFQmlpSFFWWkpmYVF2cXBXTzNBU2p1OElMditRaTRXOVJ2NXpI?=
 =?utf-8?B?a0VqUEhkT3ZQc3Z3Rk1wVkd1L2xJSCtwaVpFTVFmNE1QTVY2QlJPU1Joa2ND?=
 =?utf-8?B?T2ZrYVFZRmJqSzFrRVl3WVhYYklDK0o0VnhDUkU0aG9wQ0RoT01WemhPeGMx?=
 =?utf-8?B?MkVOUzNacFpkK1BiL3M4U2RpZTJXVTdTamV5cFZqeU1ZTWZLdXBjR0EzT3hN?=
 =?utf-8?B?anRrd05GVmh6cVBZWmxvc2dJRmxqUVdCdHg2dHF2cUJtQWxLdUdmZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56891a44-385b-4841-91e5-08df08b097c3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:11:06.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rog4dZCQXM93cgoX9lAm2/UOpEHIcHYBAGyeZWEydzh5sM4jImC+PWdHM4q8lWY9J1NGB0oeXBysDwVZKkCXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

On 8/25/26 2:13 PM, Dave Jiang wrote:
>> Userspace can select "cxl_reset" in reset_method and then trigger reset
>> through the existing reset attribute.
> Srirangan,
> Do we need to consider concurrent mailbox commands while reset is ongoing? Although rather than blocking them, maybe we just need to harden the mailbox path in CXL core so that when ~0s are read we return error and give up? and maybe a reset_prepare() to quiesce things. Just some random thoughts.
> 
> DJ

I agree that the PCI device lock does not serialize against the mailbox 
mutex, so a mailbox command could still be in progress during reset.

Since cxl_reset also needs to work without cxl_pci bound, 
reset_prepare() and reset_done() seem like a good place to add this.

I would prefer to do this as a follow-up along with hardening for ~0s 
read, if that is okay. I can send out a follow up RFC to discuss the 
specifics.

-- 
Regards,
Srirangan
