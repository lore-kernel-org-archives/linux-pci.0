Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066E1AF0BB;
	Mon,  2 Feb 2026 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038945; cv=fail; b=BaJpGoVVFKyeT0DdFdMhwoZZSpoPBY4nGgf3+32EX9HQHDUFvpPdBDgDvkmtnENJOY71IY8aphwj99Vmri5uM9B8SFO7HA5o2QxzdZwmJOc8dgWziBE+l7lXva0gl+qRWtFsRKDDK/jLi1axZfWMOwgl7Cy8HOj1xQ/GPAmTC7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038945; c=relaxed/simple;
	bh=3+cyskHAfBG46Yd3ZxumY7YDfG0D/s45K7Xpme4RbaQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TXWxvsGa68sWt68tZ3xYJ039+TMrfX7TrLvjOd1p2GzMlWO/Ig+dIiGgJeWgWNwMywBjBj+rRdwnWSccbshjUVhuXKut2vbpdbh1izWnuTiqlFaOmPU4Ud50PgtpwYq/ca0D7B3XqAW6fThDDqhP8P1cibEht5Nk1k84G4wLnnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NCr8Usv2; arc=fail smtp.client-ip=52.101.56.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NCr8Usv2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ng7bkp1skbXxOiIRekzMhnLsKvYudVzvLGe4kjJaMSHbRqjwpwwgkKwPr/bhmHQnVtDCYdssx6LRaSF8jwV2nA8OOMlB2tU1Dnq57MMV+l2I6NhKvkbdY9jGaYyQtb3dPWL5QeYSgHPpZD3FvEOph1/fIcTZml7VetwTlTW9C6g4tKcbSbWc8/+pVY1jcWQYLvedcr3lUsLg88pt3CxsChj9ZBEsbfyDciIGsCFrBnnIUcy7ezFqHnzHscUszAJ9lEfTxIcYYs30AqX1M1wED7btlPDFiK+E4FN2me3vAylH8H0mscy6LmxODM9kgF1OuhIgeBB86roKNOLEZkRzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRDWpC2GaalElkPhwuNCKBAaMOskp0FhFE8QUIYuW8M=;
 b=q/387L+lX4yJYNEU/JQIE3VZKnGe6dCkpl3Cb9Y+dQEbMnaaymHxiuSHOTKasAVaqFCJInvTi6hHtXIHmtVD9Y1a/OmISjNHtcPoUoiFf38tVSFA4XoJDxbSxCEI3WII9nZqBlDVL4h4IQdqKrGWjVTsi2LFWEKwfwj7IYOIQ1IJ5DzfqPBuNXmEMoCOVK0QOg7rmRsyBzmwGXc5Ybtqjn9/+k//GFedTup66WofMhdTOcnpnRcluOe1Z3Nne5HJT/5C7vDCo7+0tJ+oDrYDUTh+O7+HdZi8/ki86dEPDQsvXGZ5h27pDSk7mPP6hZ7e7pBFCYDhBVl0kNYpptoqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRDWpC2GaalElkPhwuNCKBAaMOskp0FhFE8QUIYuW8M=;
 b=NCr8Usv2jc0utSoB3plQ0sBi4/5hsziV+VBaGxU8gleP3XVoOz4EozOxkXJrOcfspINzAqj35V/vO4sn3/SS+JryXPQ4yijQWhlHDaOuPTxerQrAG7oppfTdZCYJU9Y2V5z2uybU+ugj0pCA6oVlHP9jWv6lrEzRUmoD0VDt2rzp4O3erTLMQRKQN6VcurLRkt21GQZYjIzYns4aj5IaKjVmC7i1dHspYoZu087SZ8TnUkyWhyCwSMqnrQq7USWbwrJ6KnZ5yQa2KHn4J+V0TT7PNNXPsVd9JXJ83zvzL3YeuwjW9zcMWOVz+VeylqyWR6L22dvbpcTQFn7i7caHDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by IA1PR12MB9739.namprd12.prod.outlook.com (2603:10b6:208:465::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Mon, 2 Feb
 2026 13:29:01 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 13:29:01 +0000
Message-ID: <668981a1-05a6-4cb1-a1f5-e8f09c25caea@nvidia.com>
Date: Mon, 2 Feb 2026 13:28:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 19/22] PCI: tegra194: Add ASPM L1 entrance latency
 config
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
 <20260126074519.3426742-20-mmaddireddy@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260126074519.3426742-20-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0216.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::8) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|IA1PR12MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 643d1b8f-02f6-4282-17a2-08de625f070e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VW40SkRoT0RhcW5vS21xQnROWXo0ZGV3MVlYTVlub0lQekU3cnh3djRuaUp6?=
 =?utf-8?B?WnhxRVJ6NGJNc040b08vVkxLdCttK1BjaEFaWHJNMFNTRUpaYU5ndEdhVCtn?=
 =?utf-8?B?ZHlJVGhTR0hCanJpNWh5elA3a1grUTV2L294aHhKRjlFTm5kNEs2QkJTUVhq?=
 =?utf-8?B?ckltQ1I0Z0MwWmZnRklySnNJVXYvT2xPMDR6YVZsaThrckpuN00remRzV3Ry?=
 =?utf-8?B?Y1QwMlJUQTc2MG5hc2M0ZlNjQUZMKzFnTW9CU29pQTROR0d5cGJPRlIyWFBp?=
 =?utf-8?B?UEVzd3RlekNTdnpCcTRPc0Y0LzVvQ3p5aHFGc1FIMXpoOC92YSttUnZ1bnE1?=
 =?utf-8?B?ekphTm5SUDluUlV1WE56VmxWZnVrWGdUaHFsbWhBU0l2Yys4Yys0U0N1TjJS?=
 =?utf-8?B?ckd4N0ltcnppdG5WUFl2OWIxSWluY05FaVRXZmg0ZUxHRDllNWNnMjFvQXB6?=
 =?utf-8?B?aGEzcXJhMmswUy9mOHRNQ1ZtQTcrK1lMeHU3bS9HWUVHOWJzQ2lnOWxkSm1j?=
 =?utf-8?B?U095R25JTGNwVVZVaEpFWGlDWWpxQzJ2WU84bHF6c04zdDVYYmxDMVJHTXhN?=
 =?utf-8?B?d2FIckI1dGhHQ0FjRHAra2g4c0RQcFgrZ25qRStzcWt6dmhmUGliOXNyYUhy?=
 =?utf-8?B?UHZ5M3BvNExWRTJFcTU0VHE1UVFJeWQxZlc1TGlJTEdBVG1YbnIyaVZ3SmlW?=
 =?utf-8?B?Zll1bUxyNXAvNWRFeUNMK1lSaEpvY3FicklZYVNIQzAvWmFCVTNHYmRwK2lR?=
 =?utf-8?B?aGQzNEtCVkRGejVONXAyZkdGZ0VTamd2SkZxelZLMjVQZ2srY1RURUttL09z?=
 =?utf-8?B?dkhNaVRPOUpSalZaVDREcllDeHRwTEIrdUhqekF5ZEhHSzQ3eS8vTUNqT3Yr?=
 =?utf-8?B?MjhyNCtUR1EreDRjc1pZZ2JDNENuTnFTUVVHeTVsMUVXbEFtaUVqNHQreWJN?=
 =?utf-8?B?K0ZJcXM4Vm5jOFJ4ejIrUE5PeXhUeGY3ZUhPZ0tpbnNyc2VGQ3cxWEhQRnJF?=
 =?utf-8?B?aGlCT29JeUJsNFZXVXNsUVV0alVjOVhsbGxaQ1pSYTNKUStOM0s2MFlaZWEz?=
 =?utf-8?B?UWN5NG5qUWFrTy96T2dlWEcvZ3JVN0NhNDRiaDY1ZkpaQnBwS1NvRks0Wits?=
 =?utf-8?B?MzVwOGVRNlA4bzBhRjNYdmR2cldmWmhGTXJ5MkhMK093VU94ZFM4RW55YUJr?=
 =?utf-8?B?azVXbFNPcDBwMW9Ydm5Oc3VvdnR1K2VhaE1BQWpaVm5FYVpwTmNyRmNmcGFJ?=
 =?utf-8?B?M1QrWVdobEcvMlh1SE11L21ra1pwbkc3OVN4V2VDL3NkTjQyK0phZ09BdnR6?=
 =?utf-8?B?dDE5amZXNVFLWFZ0YUdxdDVYL0x6ZFRCQ1ZjS25qdFVHTFNEdlM2YVlwYXlu?=
 =?utf-8?B?MEVidUxqNVpnUnNtWmt6dVRJZzBtRTJLQy9KeDlCWGt0NG43NjZKb25HUHUy?=
 =?utf-8?B?eFlPZ0szY0VZdEFqS0NlWFlyTSsrLzdERWErK0lCVkd1TVVoQlBLUEFkYk4x?=
 =?utf-8?B?Q1pvLzZScy9NeGU0Yld5MDlURGtSWVY1ZjRucHdVcGhZUS8rUGxhYk5Va2Z5?=
 =?utf-8?B?QmxHZy9laVBoUk9rdkZXZTh4Yy8zZCt5dHBHbFAreDRZdGppVmdjQkM2UDFm?=
 =?utf-8?B?ajdJU3JROS9xdFhoWm5ESUNYZjNpM2VOSS9pSlhHa2p6eVN3Mk9UaDlsdDFo?=
 =?utf-8?B?VmhnNW82NWlHaGpTQWQvdENpNXc5TTBMaHEvMTcvUzEyOXpIMFBBcnppZUVo?=
 =?utf-8?B?MmRjZHozVmF3bUNseTM5dThCOHRUeENyRGRObVN2OUI1OGNQeDk5WEMvK1lP?=
 =?utf-8?B?WkNuNXFCVEVqYmVUcFVRRi9kYncvc2YwR1NaWFZUdlVWU1FVcHYzZm85UEVy?=
 =?utf-8?B?eUdZZzNQV2k2UHhiZ3ZsL3Erd2pMQmNmQ2dSZHlsclJHejV4SGNFb0tHNXov?=
 =?utf-8?B?SWI1UUt0MHZ3RUNOdGkvbTZVNlRZWkl4NTVFeFdyZnNLNmVXQzlnVHNhamc1?=
 =?utf-8?B?QmdlVkdQaU5wazRCUUlvNEk5U0lFNXpxTGlDMS9IOUVLa0doelNZWjNoL2ZC?=
 =?utf-8?B?UXFrd1cwSnlwNEs2QlplR2k4QjY2Nm4wR3ZIZUZNaS9nYTYrNmZKNllJMDZt?=
 =?utf-8?B?ZVBpc0lWbmNveDdoRU1NbEJ5UmxVRzNtcFRnQ3RQdzhrbzlDc09HSGVEVFJk?=
 =?utf-8?B?WEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG9aU1BwbW9YOEFPVndTdmF4ang4MVByYVhzWHdSN0Q1RnNVMzY0S3E5emVz?=
 =?utf-8?B?ZWZZYXM0N1ZJQlJ3dWNkMnJXUDBRUk1ic3BORmR4RGJJeWhKenEzdFJ5VjFt?=
 =?utf-8?B?bm5TODFCekx2a1FCODgrNFY3YTdmcWtjOGs5djZmUnVBNUtuZWpRVCtFdUoy?=
 =?utf-8?B?SEMrRHRvaHRDK2ROSXhkUnZlMTJDZDlqVk1adE5GUkJxR2VJM0NyUjFPWVly?=
 =?utf-8?B?UWNUb0RTRzBJNkN2VU4zZTZ6ME9XbUVENkFMT0l1alZ1VDhSWkFubXpOZWZ6?=
 =?utf-8?B?Y2pvT1hBM2lRTHhmbk9tVEozbVR6UGZ6UUNGYWU4Mmw5Nk1UZzh4NXRwQXpU?=
 =?utf-8?B?T2d0aXhTUm53cE8zbmIyY09iYzJzQTJ6d3NweTA4M0FQVUE5bnhOWXJ3OVJO?=
 =?utf-8?B?WGpid2VtNnZUanJKZFhuWVcvZWRuNEgrdnpFeXU0ZTZubGQwZ1M4Z2Q0dWlM?=
 =?utf-8?B?SDE5MTRyU3ZTS1E3Tm1tNkFtdmNFbVp6bWtmcXZIYWhzVWNnTThvMGNybVhU?=
 =?utf-8?B?UWtJWDV3UVZOR1pGL1lxQ3QwZWpKaVkrdityNmFrZUpNVU5QYWJaMHJLRTlO?=
 =?utf-8?B?cHovNTJnYTlFbEV5Rk0rMmFqYURUckFTTEtxOFZBWUM2VVNMNFp0VXI1TnpT?=
 =?utf-8?B?OFdFWXFxL0ZTT1QvQmIzNy9hNzdka0l0MFBRbmsxUEp3V2pySlI5Um5hR1dG?=
 =?utf-8?B?Z3FLZ2M2aHhaOEorTjhCQ1c2Z1AyblVTRG1OekpBWnUvaDRxdlN2YjlBVVRD?=
 =?utf-8?B?QmMrNXM3cll5bHN2cVFkUzJ5VDd5UHBQSGtDWUdUdlRNSzB3eTk0azErUDBp?=
 =?utf-8?B?VCtiTUxZQmZRSlZMaE5sakNVcDl5eTJpZlAyMVdwWmw0OGpFN3NTK2tOdGN6?=
 =?utf-8?B?WExqTzI2aHMzL0RiRElETlE1M2pOWXM0cHdwYzRxM25jUGxnU2RhakZRMnFr?=
 =?utf-8?B?OGNJa0ZTRm9DTDlDeGZHYnNaMFp4TG9KTkVaNWo5cjdZdjFVZlo2TVBYaVd1?=
 =?utf-8?B?WEVINkpzRGhlUDB1bC85QTNUdkx6bVR4OW11ODR4ZzBIOEFLL3A0MWpnOW1K?=
 =?utf-8?B?WTVNN2REUnNuYUJZOVF1akxaREJRVUtoMS9rK0JBVWlubld3L1NmSGxMaEd5?=
 =?utf-8?B?NzIxejNBQlJ2VjN0L0h2VXFESXUxRkhodUpZRDRmbDBxdStDbG1TZTVTMHBQ?=
 =?utf-8?B?Vmd5ZFluK0lWdFZZaE1qN1Y5L1hUVWF5NkFjdGtXM0FvaTFjZFpRNnZ3bG03?=
 =?utf-8?B?M3JNaEo5Sjd5YlNKZXMwUUZDVWw5RFozZVQwVk1uak9sWTRRSUhHM1I5SGsv?=
 =?utf-8?B?dWRocnVBMldWV2lNR04wb2lkeTNlYkJQR3MrVjFrNURFRXBXZzBob2s4MURs?=
 =?utf-8?B?RmlldmhWN3ZuR2FhN1hYVU1CM290dmljbDBaVWlQbDJSU1lPZTQ4d1dHUUhG?=
 =?utf-8?B?TlZuZVpxOU5PbXh2azdmNzQwRGZQUnNzemF4ekIxd1U1blBRWENlR05LQWUz?=
 =?utf-8?B?WEpMQ1lZNlp2M1NDdlZ6TVlKU2FaMzhKdElGcGpHdlNveFpBOHpsU0JlWmlL?=
 =?utf-8?B?bjNkOFNGRGplMHpNcHZCM2svRzVyTmZwN3VLSVBWSkNlaFE2WlpianAzS1Ro?=
 =?utf-8?B?ZFlPajM2R3BuS29ld1Z4OGxucjQ3Qmt5Wm1tNHUrWkdLc1hPcUlLbk9YV1JD?=
 =?utf-8?B?M3hxY0RPUzN2cVRSMnFPREFLUGhSQjJ2UlJmaDY0N3VZMFhRWUlXTkQrc0xO?=
 =?utf-8?B?N0lEejV3UVhwSjFZUVVTZ09TaTNKUzNlaHdaUlVpbnZBejZhS1Y4ZzJxUStD?=
 =?utf-8?B?OFBGUTkxM25EOVUwcWJRWTRlVWdkaHpJcjdTcTFDZDkwR205RnhlMXJ6ZG01?=
 =?utf-8?B?Nng2Z0tzcUhwclVUUXlub2czM3pOK3VwWENMNkJTWjdXakNHWE15bk5paGhS?=
 =?utf-8?B?ZmFiM3N3bThLWEMrMmo2ekE5WmlpVlV6bFZVZEJjdlp6bTd1WklsemowcStk?=
 =?utf-8?B?YUcxYUZnWk04ZTJFSnBOM0tQZzlrQy8yZXc1dVpTOGVwUVlXb0R3dDkxRmVm?=
 =?utf-8?B?S0t4S0ZWQXIxc0hLUFpkS0NYYzU3KzNxVks4ZDBuVXZ1UUhWRU0vMlJDSGJX?=
 =?utf-8?B?NWdyT2h1cDdFN2dhOXBlcWg2ZDdldHc0eEg1TXVRTjdRMm9odDN3ZCtLdVdU?=
 =?utf-8?B?dFhsakI4TldmTWJvTkRjallQNG90NWwxTGhla0FSSWlpSHM0Zkpta0E2RGk5?=
 =?utf-8?B?a1h4VkFOWjQ3SDFnK1ZISXVRTVMzbEN4Y1BNa1dCT25QSDQvc0xhd3ArNDRO?=
 =?utf-8?B?VVN0elE4R3NKYlZ2RHU5aVVRaUJrcEFacUZDQWRuR08vcGxmQzZpQTJFVFQr?=
 =?utf-8?Q?09JhxQpn28/gL8hOUbL6l7anCaBAc7t1TEJ9ti6Ye7+g4?=
X-MS-Exchange-AntiSpam-MessageData-1: IEYl019ukqKf4A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643d1b8f-02f6-4282-17a2-08de625f070e
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 13:29:01.3942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/IUdO3eWLM50NF18H9xjEHGyEAzMpVsmhFiIbUTkAODjSUCi5cZ5FIGwXTdCdJPS4vU+tTrumOV6k1MFbBN7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9739


On 26/01/2026 07:45, Manikanta Maddireddy wrote:
> For Tegra234, the HW PHY team conducted experiments and determined the
> optimal ASPM L1 entrance latency values: 8 us for Root Port mode and
> 16 us for Endpoint mode. Update the default ASPM L1 entrance latency
> configuration accordingly.
> 

Fixes tag?

> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V4:
> * This is a new patch in this series
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index b5604b879a58..6543c6d49fc8 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -244,6 +244,8 @@ struct tegra_pcie_dw_of_data {
>   	u32 cdm_chk_int_en_bit;
>   	u32 gen4_preset_vec;
>   	u8 n_fts[2];
> +	/* L1 Latency entrance values(Rest/Prod) */
> +	u32 aspm_l1_enter_lat;
>   };
>   
>   struct tegra_pcie_dw {
> @@ -714,6 +716,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>   	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
>   	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
>   	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
> +	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
> +	val |= (pcie->of_data->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
>   	val |= PORT_AFR_ENTER_ASPM;
>   	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
>   }
> @@ -2480,6 +2484,7 @@ static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_rc_of_data = {
>   	/* Gen4 - 5, 6, 8 and 9 presets enabled */
>   	.gen4_preset_vec = 0x360,
>   	.n_fts = { 52, 52 },
> +	.aspm_l1_enter_lat = 3,
>   };
>   
>   static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_ep_of_data = {
> @@ -2489,6 +2494,7 @@ static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_ep_of_data = {
>   	/* Gen4 - 5, 6, 8 and 9 presets enabled */
>   	.gen4_preset_vec = 0x360,
>   	.n_fts = { 52, 52 },
> +	.aspm_l1_enter_lat = 3,
>   };
>   
>   static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_rc_of_data = {
> @@ -2501,6 +2507,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_rc_of_data = {
>   	/* Gen4 - 6, 8 and 9 presets enabled */
>   	.gen4_preset_vec = 0x340,
>   	.n_fts = { 52, 80 },
> +	.aspm_l1_enter_lat = 4,
>   };
>   
>   static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
> @@ -2513,6 +2520,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
>   	/* Gen4 - 6, 8 and 9 presets enabled */
>   	.gen4_preset_vec = 0x340,
>   	.n_fts = { 52, 80 },
> +	.aspm_l1_enter_lat = 5,
>   };
>   
>   static const struct of_device_id tegra_pcie_dw_of_match[] = {

-- 
nvpublic

