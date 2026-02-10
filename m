Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A258A3815E1;
	Tue, 10 Feb 2026 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743892; cv=fail; b=J3C2BGdeAl7W+KE82Aplx/yp29LYZQ8jfcyl+YXUXKKOo8XsnjOgsegs4txgHzPV+9L6iHRaFCe50iZdV70TEIALZxVTgVCdUVetbnQ/xunAVeL+gpPPXEaEaDBnMc0Z/un+ADGm+kymUdI9KG/pCMl3BkNVV2sBFAG/Y2J493s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743892; c=relaxed/simple;
	bh=JkulP72032gxeqwjxs+rV3HPA5nFvNLCR7/uflCFOf8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZqYRrl5f55rNR9xl2gJX73unbrsnDLCDAGiou9CdIPGVADeljBzcJQaS2e3L2i55PXKtW3WpmXFj3DxTDJVdqc3FU0sZ9UxcxMpxQHbl5dTQUANTw26Yjb49w5eibpTZ792UPujvgdGRrYksM7H/CUJj3eOlClkHQDg+R47KffU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m84dX6SQ; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m84dX6SQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpGDJdMaTzXrJvEzQvh3dK5Y/36N7E93ShAesU03zUOyGl5rZncSxra2VUV53nMskaGcFmpDcayr5bL3R7vRO4wK/kyHxmNQO61zDX+jSdMKs3mxYwoaqtz2aE03MFv9T4Wyk/KEgs/Guc00sAqaslUD/vT1VFAxPGjgkFAbUz/npEH5Iw+pgoWpTKwylci/zkBszreMu9m0i73HczB0e79ycxRXJaIC2NMiQMCiXRlvvAbV6HIhK/PzkRub9vjYsNU/5vtY0v9wEcfWC8j5s6YqwVU1vwp3/u1SOBJ1hVkn6v6tapkIeIzYKOmb6dy6XiVuwLrz6uNq8ktjxSnzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtS4QlJJJXYh/UYzKjob8hgN04dKMlRmHTr7oIU/1ig=;
 b=cmKUy2KI3NvnnDoTbyAczPTsBr5/1k/FlMjrX6daDHUshsCLy6ylyo3g2Wo/pla+IOED0jwtVOYMbzWLzyCZxnIFp9pSczSAqf40304Jw/G463c6tyKFJVgsmZKfigQG7bFSEGrgPv3lRBu+u29KeiF0ahkbEfHkP53KDwaZLdH2hRdLBpf1PuWDTQbCIoLpx8ZvFVKFWzDuPdo9ChnwDA4cacZu7EqZGVLESBA45z2i464+366AD8opibNAphr8CqBpiuhIPZELdDv1MrrSCnlre79d4rjCLDRBlotakbCrOpUlnu/JZmuT0P0Z7/SGM9zBBP663zQGju7foNro/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtS4QlJJJXYh/UYzKjob8hgN04dKMlRmHTr7oIU/1ig=;
 b=m84dX6SQUO2vsNZZPVV8W74p8rxzCOm5uzpHOooRMXJn+gCz+NeLteYbD+v14pdDP7rxCKh2hpjp1dzEIiQffg/m3st/wVYcs4jGrv1g7lA5ElEEL2/J8hL7aztw1tbGBn3kBavtWBFvRgrAw4rJBwTWyQxENZ0TpO2ExGDLmwtMSPgi8cxsdJPbCFli8J/pHcnXT2QrVZIfMJfYtZfOR8aJ+AfpNw93zr7674hYMM5C0KIKw+H9C3T0q96tgxdVOiVVFVF3wR9d11ROzqiNzsCzdFUXvrtHZQboVIxgaltQplgVSs+o0nwQpmQ7j93GyHX0VQdAc3zyWBBKIbiw9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 17:18:07 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 17:18:06 +0000
Message-ID: <8ffc8978-878b-498a-ab6c-894fa607365c@nvidia.com>
Date: Tue, 10 Feb 2026 17:18:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [V5,00/13] Fixes to pcie-tegra194 driver
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::15) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: e5aece91-851f-406c-afa4-08de68c85b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlBuRTRsTVFjaVNFYVlFRWNXRW1Sc05mNzMvMXdzR0Q1K0QwcEtmMytKejg0?=
 =?utf-8?B?QlJHWnFrU0RmVWYreGRlZE9jVUNTOVEzeW5ZRUY5cURzSFJMcTNSQVpBdWI0?=
 =?utf-8?B?MjJBWHA0bWhQMTU2M0ZTcjE4WEs5dUR3M3QxOFBOR2VhOHcyb2p5L1JHV1Fl?=
 =?utf-8?B?c2FyeXBOK1hWenZNRjJZNEEzSm5kTHpza2R3L3d3dk5LZTlzbG96OE9ybHFZ?=
 =?utf-8?B?dW80Qm93V28zSisxbGlWN0FyOEVBeDNYUzRrQXFXR1JRcG9MLzVaUFNyamJh?=
 =?utf-8?B?Zk5KUitUN3NzcWNmVGgrWUwvamc3S3h0dFBzTFlkRGFXS2wrMTBYZGZvUUtz?=
 =?utf-8?B?SjlidERKakpKK3BPZnJMWGxjdFcyOThnN1EwYWN5SHRsNThXSWo2cnoyYnRi?=
 =?utf-8?B?KzVrdjV6cTJqYmE1TklMd1BaMWNPQ095RHUway9tY1RVNVJQQmpWRFNlOFhy?=
 =?utf-8?B?L01XcWxCRVNuVis2UFl0dm1RMWQ1dzVzTXE0QkNHdWdhTnlSQUpLQzc5ZTdF?=
 =?utf-8?B?WTBBckhnOWxXK1dHMmtFck1QeVNMeGRQc3lFRnAwb1prR1lhU1JXRFNoZnVr?=
 =?utf-8?B?dkVoZVg0NkNPelZmTEQ1elpTMFBuUXlkdVZvdWZpcUEvdEI1ZUk3aXRQQnQ1?=
 =?utf-8?B?ZDd5bFJzMHZ1RHd5bm00K09ZZ3lFSlRaN0M4M0RUQ3NoQmtOSG11Z2xmQ3l3?=
 =?utf-8?B?VWNOY3BPNGM5WitaeHAxcnJmemhUUi9sODc4eHZtVFVwbk82RmFWOUg1VldV?=
 =?utf-8?B?VlVzWDllbGErUlZoS2NvcHNveks1c3lJSXRuNGo4bFJSZFdQTW05L3VhSEsr?=
 =?utf-8?B?U1ZGa1c4R1NBMldEbW14V3RTRmxUbEU2YWtydERqTTFpUGx2YkphUlRrdzJx?=
 =?utf-8?B?dW16alMwNk9wbmdpRWFvMkFEVlF6bHNSZWV5Q09QeThPOU9UQUNkTS9vUnA0?=
 =?utf-8?B?Y0dzRU9NSWtXdDJEQnREeUhZWTEzSUsyNTdwRGJ1VDA4R3NiUlFZSU9Balcw?=
 =?utf-8?B?MkpjSEkxbVRnanpZYWVndGVWS245WjRqUG1XV0tMSlFFd3FKZmZsNlJWSVgy?=
 =?utf-8?B?UXdXaHN1Z0M5YmkycmJsdzNETjRwd2lnOVFVbEdtb2VVL24ycTJQTFB2M0h6?=
 =?utf-8?B?NXpqMjFWZUZHTE9wanRiYkh2aEF4U0tvWUZRT1ljUVNiTlRVZ29jYVpWL090?=
 =?utf-8?B?UXUrWmFONCtEOHdrYzU2NzBzclB4bXVpVnZxNGZjeUFLcHBycFRYYjZ4RjY1?=
 =?utf-8?B?WVZpSFkyUUhjN2xmd3piYkl5R3lmWHlLUFJLazl3enpjNEl6RlkwTm05SWdh?=
 =?utf-8?B?SW1rdzhQNmd3V3NtZE54YWk0ZWt6RHhna3U1cnlROGV6bnlLT2NpN3YwZjNo?=
 =?utf-8?B?OHV4VUtwc2plajJ5U0l6VmRGRFlXa1NQV25UcEZDYlp6OEZPRzdKRUpBUVhP?=
 =?utf-8?B?U2V4Vi9GSGxvUWVJM1lyNm45TGJ5NnJ6WEt6QkZVdUVQUW5BUGw0enE1S3Uz?=
 =?utf-8?B?SWdDN0xsMlJBNWg4ZHhjMHFiYW5YNmNkUEpTU2RDVjRSUDBsK1ZBR2UwbDBV?=
 =?utf-8?B?bVZVRFNNMmNCWmhvWEE4MER2L29EVlhqNnJ1SENmRE1YdW9tOUdnWjhUUGhv?=
 =?utf-8?B?UnVQdEppT3ltcGhrNWhqemJUSFE0WkFzRzNZa0NYM0E3enR5Z0RYQ3VVcjhK?=
 =?utf-8?B?VThwaGpKQUVFUFh0cUl0dDhnZnhIVEE2TERHUEVTN1hiZHFGcm9SUEpUNGRx?=
 =?utf-8?B?TG00N20zUEt6VDhYdXhteHdwU0pEM1pscGhWejRGanBqTGVSWXpNRkwzQllk?=
 =?utf-8?B?RktDb05hZnliWTZaYUNTajYram5kSVZmUGNJQ2MrRHJNSkdDdGQ0eTdTTngw?=
 =?utf-8?B?S3o2VURPcWltOEFUcXhKSDdrUlJPMUFDV1htaXhKUHkrZzlBV1lSbzBPMnVq?=
 =?utf-8?B?UTErNm5kajh6VnZoVUZ1dytjTEc2b2cxWnZzN3d5dnJQakM5a2gvaTVtNEcr?=
 =?utf-8?B?N3hhdVJ2ajVpbnZ6b0g4bEhWV1ZxUkRsaXBnWCsvNWRjU0hZV2h4elYvNWJs?=
 =?utf-8?B?RlFwR0FDeDBleWtJb2J3RU5RRmtPVDhaY0ZhVTRYaHRpaloyd0pkeXkrNEIy?=
 =?utf-8?B?TFpVU2hwL0U0dDFiRGtqMXhmSkhZTUwzeTVLeTQxL2p6QWZuYmpXS3Yra0I1?=
 =?utf-8?B?ZFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkEwUlZkUGJQaHRIZE9HdjlsOU1maVdTRlhFZFU5NVZVUW80WGRCVkdhbTlN?=
 =?utf-8?B?eEpaZzFQRVpIb2w2cVhZMEJac29oTGIxOFhPNDFXS2EyVVVwUmZodldUOHpu?=
 =?utf-8?B?WXJWR3Y1UjhzNWk0T053RUhROHg4K1FHTE50eTgyOUVndm84QWExaUxNSTdM?=
 =?utf-8?B?ZU8xUGRoZklCTVVhWWdYMmhUS3lyRjlHakl4YWdUNzh1YkZjd2c3RlcyOW1z?=
 =?utf-8?B?cGFpZStNOHBKaDlwTXZqVTJab0lWOUhHQUg3c1gzcm1rak1Jb1JEUEIrZlJ3?=
 =?utf-8?B?cGtIK2ZWZTYyM1hqLy8wOVJvN1lYUk1ia1JNR2Nhd3NWSWxGWlFhYWRiblNG?=
 =?utf-8?B?WXJ6VUF6TTV5WmVYL2R1dWFqcGwyNmw5UDk0QWFyYU5HNzcyQUhBYjVOOWpY?=
 =?utf-8?B?YXByZk1pU0V6Z1gzSFl4U3RpYjJhOW92aUtJMzdLeXFpVUQrZVUxRkVaMVFP?=
 =?utf-8?B?V1JrR1FQMnNsY2dDemMvVVFMeUhqRG1BaGpiN2MvN0MwRVhJMUo4dlNpWUJZ?=
 =?utf-8?B?Sk1EY3h5elE1bjEzVlpKc3hta0pURFFtOVgvV3RpWnB1ZU1FYys3d0VUcTBk?=
 =?utf-8?B?MjdEbmdtakcxaGZDbCs4S29ZVUozL3haOHk3akNUS0NVWTVkWGtOb0ptTHFV?=
 =?utf-8?B?am44dGhaRGFDNlduL1F3TFRERjV2MVpxTFpxV05Wd2FlM3Z0QzU5K29tSHlY?=
 =?utf-8?B?RzNJTmJYcWhJY2NiMzdhQ2gyNTBxTHErRlJVaFdLK3VaUGtzOGNrMm9xUzZY?=
 =?utf-8?B?bEJPcTZ0Mkt3OXhPakw1b0JsR3VldHRxbVAyQnh4cVlIeFFPVG1ibldxRFpG?=
 =?utf-8?B?cG1HRUI0VlBDa25WZmd6OGE0YmhVb1BnNk9xM1NVUmZQc1phQ0dLcTB4Q1Z5?=
 =?utf-8?B?YjB1bnBVZk9DcU9iR2Fac2pqZGFVYXhVNXBKamlCNVZoLzNPMlYwVFU0RjZ5?=
 =?utf-8?B?d2grcDg2Mjl3ZHFwSkU0SWMxZzRPM2pVdzhxNXRPME9kQlpBWXIrM2UyQ3Ft?=
 =?utf-8?B?NDdDa3RTZ2lWcVpkb3FnZ04yNy84N3dadERyMUZzbXdSbXd1ZlRkV0dnQkcy?=
 =?utf-8?B?UnIzSCtFM1FLNVFzWkR3dkI1a24zMURSNjVUNmxaNmxNNGdaVitxbUtMcCtx?=
 =?utf-8?B?U1BCREtvV3RoQzFRTDg4aXdJSndpdkhRa1UzejNMNXlhOUl3RjJObUZvNisr?=
 =?utf-8?B?OFpZZDViRVZWaGdIUkY5YTQvcG9UbStmWlY4RVFxTUFZVE41anZIZlRGeStl?=
 =?utf-8?B?cS9nV3FkSkZYZUJmNmU4dldya3pmVHR6aTRYWERwZW5hS1pZUkd4MCs2TXI3?=
 =?utf-8?B?Nm1PcFRYRWg3YndXSStIeFpFZE1aeXVoMTJWdm0wVGtXYzV5QVpzbmxMOWR1?=
 =?utf-8?B?V2trVEFVODljVkQ1UnRNQXRLUE56UzgxQ2lpSGtybERLYnVDb2FsTXMrRHpI?=
 =?utf-8?B?ODJMT25BVlpEOUUwTkU5UVJpMUxLZHdXeVczMEJHQWtmakRhS0dETU5VK3Fq?=
 =?utf-8?B?MS9oVzlScUpGVVYrR2dPUDRkdmZLckxJSng5cTdxd2dTRUE0MGF4eE5jMUt5?=
 =?utf-8?B?dVo3Ry9TTnJvUm5CV0VTakw0enFaL0poUmx0Wm53M1E0TWhrWXhFOGNFUG1o?=
 =?utf-8?B?eFBFUzBqWDZQWitPR1R0U0oyNlA5VHMyZm5EQldKbXBtUW9FNUtEQVlmUlJ1?=
 =?utf-8?B?ZDNXTml6b0Q5a3luUkl2RDd2N0d6ZlpZRmZqY0FtSlFnemJXa0tydVl1b2cv?=
 =?utf-8?B?TmUxVGZPVTVrRTVuc0dyUkpaaEE1NjZXdFlzY3RXeXdLcE1PSDhwbzdlTFVO?=
 =?utf-8?B?bDRFUCtpeHF3M3p2L2dEUjFZS0VrRTJCWE9Wa3hFSVZhVWMyalN3NlBqZHc5?=
 =?utf-8?B?QnJTZ0xObC9PbmRyTmJkTGJsN3pINkVyWTQ1UW56cVc1Tlh6SGdabGxZcFlQ?=
 =?utf-8?B?UnJBQmdtSXFnTnlGVGpuRlVSNmhkWjlmSWFpMGJJdnRNNGQzQzI5Z1hHMy9O?=
 =?utf-8?B?a04vZ3I4RFZQVE9yOFcrUFlFTFBtRlRqZWJpVUI1MHJnZ0NETGtZRlBtdDRu?=
 =?utf-8?B?bkx2N2ljc3JlaXMzMnlEckR4YkR5b2pLR0VkQ2hLeHRYQnpVZlRIaFA5MXd1?=
 =?utf-8?B?aHVHMzVWVkdWMHptQTIyd3YxSEVnOUhOUEI5d1NjZVRjZ08xRXBkNkhDV0FJ?=
 =?utf-8?B?anhGSXVsZFk3THVXL2tZTUZobzVNS0RNK21mWjB1Kytsbm5OWGNBR3FUZnBw?=
 =?utf-8?B?VGJmemg4bCs4ZUZPaVZPUm9NK3VTeVgvYVZWbkxvRXl4RldRd1Z0S3NPenVs?=
 =?utf-8?B?NlVjdy93MFg3R2hON3pzd21zT0lEN0NpUUpETXg2UkJYZ3piTmVPdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5aece91-851f-406c-afa4-08de68c85b2f
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 17:18:06.8395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZ05NtU7qPZACZQIh7maPscX38a++mGetUOcTki0FxMUxZaxvdnRsUuufCjrp1r1hWpSt8BrwuHSSJd/i6PB9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647


On 08/02/2026 18:07, Manikanta Maddireddy wrote:
> This series[1] was originally posted by Vidya Sagar, and I have rebased
> it onto 6.19.0-rc6-next. I addressed review comments and split this into
> two series, one for fixes(current) and the other is for enhancements.
> I verified these patches on Jetson AGX Orin(Tegra234 SoC).
> 
> I added below four new patches to fix bugs, commit message of each
> patch has the details on the bug and fix.
>   - PCI: tegra194: Use HW version number
>   - PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
>   - PCI: tegra194: Disable PERST IRQ only in Endpoint mode
> 
> Rest of the patches are same as the original V3 series, just rebased them on
> 6.19.0-rc6-next.

Thanks for splitting this. As Krzysztof mentioned we need to fix the 
subject prefix.

Otherwise, I would just make sure the fixes are ordered with regard to 
the fixes tag. In other words, fixes related 56e15a238d92 ("PCI: tegra: 
Add Tegra194 PCIe support") first, then fixes related to c57247f940e8 
("PCI: tegra: Add support for PCIe endpoint mode in Tegra194") next, 
etc. Given that this was the order the changes were originally merged.

Thanks
Jon

-- 
nvpublic

