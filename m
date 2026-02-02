Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D9C19E819;
	Mon,  2 Feb 2026 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039058; cv=fail; b=sOk4X37QvW9sl1e9hbJG9JRoMbTXuS6cPGbsjKRqD23mtsILENaZ6DXEAOouRQ4+Oy+eeu7hELmUdXhJWcHJvnnH8XoYPfpfLEPATCS4XQX+c5R9HLpe955e0mLbMqYOtsguxss6/N3XMMk3gBQICBI0K8PKNJ/u29CWo6aDXRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039058; c=relaxed/simple;
	bh=CcD8zbXtqfN1iQOVPTyyYHBWGwB02obCFyw1mgiK3DY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UoyeKEJQliBAAcA85+tdCNDwwvgOuVyIe2NWPLpohAMM3WZ7kNOlYrzci2gbKY+89eLzvBuXI1ggK4vusrhoufYcVxj8A0wfrXwRZXNa90rTi2n+1YmFZ6YUDUzbLzbRWLATVYDwjEWPA/mdfYbkPmBwJQ0EVIlBZMMManSexHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gjwGA21v; arc=fail smtp.client-ip=40.107.208.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gjwGA21v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fuuww+vhXM7ttAWh06KiqB6nEIL2Np7URJcPOD7tj5RrwcRkudodcIBEDBEdtNI8/o355XGT1raAqBZGTG9q0pBzlCy1uXBbT/FXPfpBRH/Jdx9vEqKOfGFnAR899yOy7m2GYSXbHkZx93RorNHB0axICuXsqLhb9yUt7zSFJTZY8hR9UcusZdANWu8e0/x5PsvGz9NKm3QuY6X9EmaVOjFsztHyWyxalOtziL/Ma48ZnEERiLXsxtymNGnC0oqMaSBBTQI+PPbwZIEBrtt4S79G4NdPgHBZHEEs+EuZZHN/4tQS8RP0UJAY+L2Moe5Hnlj7OW7S25YxvoZv4IROJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rHkwhyDFWjQ1gLIlTvKXP2AJw1j5NERu6GVjP3exmk=;
 b=PqqTJdTSSKZH8mZbTnT2ltA7bLQDbxadZZMtj0BLG3D6AtiBsHwXOFhQaujipW8xDZbWqUnV137caQ/lBq3O+c1RybWzJX4KgYsApMCZUoOdncfemSGuqDUNbTSCiShAockS8gShlQrjp0PuixVwQjDgEilIxX77EkdimD+O9kKV3BRVd2hj4xNooJ7ghJYR6n3T2BRC70DQjSY0HiKGo10qCNQGMsbiYofV6y8HdMXqTFfH2Wh8vEBUC9NT+AGB8mBxADcdUNuhpesonC7+2uEb8k47vh8UcxSvvganKJNMQMeBr5oJ3d/lJd4yf0FsxZebXcVyRLi7WBWmcX8ubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rHkwhyDFWjQ1gLIlTvKXP2AJw1j5NERu6GVjP3exmk=;
 b=gjwGA21v1rl+KUYsxQmqTDFQhicCvl/T4kmqSKXT5qiRGoMTLGy7uiBsJaDYU//RaOB025uAHxsQh13to3LhMP6d9tqhEBqSEswNSr2Anb1+2WY6p/XtB9gHh9rklJB1xRbeG8UTMV4L1Df/Yg/Ry15YokF2F1BULvG0+p2AQ5xbfjqDbxZ0Oh+jch1XqF1cA1rwJlKTSHIlLyq7ZRHELPoxA7agGRnhARLS6EyIR3q6f3+63SrzXpJXo9UkU69wVaGhBXu0M1JX4+F48pqNS5YTsCaAFfCoq7sPjJ+2jcUM5v2prXhTvXeARj2Cm8wENSv0x6Keir9ktiCkG7HftA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by IA1PR12MB9739.namprd12.prod.outlook.com (2603:10b6:208:465::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Mon, 2 Feb
 2026 13:30:52 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 13:30:52 +0000
Message-ID: <7f81902d-a1c5-408b-b178-229d8ba0809c@nvidia.com>
Date: Mon, 2 Feb 2026 13:30:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 20/22] PCI: tegra194: Use HW version number
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
 <20260126074519.3426742-21-mmaddireddy@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260126074519.3426742-21-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0323.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::22) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|IA1PR12MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5471ed-6883-4500-1fdd-08de625f495f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWNLZlB3MCthZ0NabFh5aTYzMFhIWSs0L29hNERER1ZORkNwYUFNdFJXSGll?=
 =?utf-8?B?N2Y3SXprSHlLYUdGcHhJaFFjajdrVDZ0YTBOZ0tEdlFUdFA3MnI2eU92SGxT?=
 =?utf-8?B?bzA1UGord2tidHhxNHlTN2RnVnoyUkMyaGxGdnZaYXY2U0dLWHk4YjBlYUhp?=
 =?utf-8?B?TGJKRGRScWN5RVQ2VTlBRDUvL25mK3VuMmlqeGhZNHVOUzhtWEg4T3BCcjhv?=
 =?utf-8?B?RUU1NFM4VUZpWUwxR2dYeHJtNlZoTnNQYkFQeU9RaXNnelhqZ3hFc2Ezak9T?=
 =?utf-8?B?TkxxY3ZPTkFVZXA3VmhaRTNhOWYvZzllYzZkU2pvb2ExVWMrWWROZElhQVJ2?=
 =?utf-8?B?d3RUVy9wejJVc003cmFxRE01b014TVdsNERGUitvT0pmMUJEc2xDNmdWREpk?=
 =?utf-8?B?TzdIRVE3MnJGbU5EMmRwVlAyNkFVemlOQWF0K084NUlibURZMWlTQWROSVhU?=
 =?utf-8?B?TjFqVFkwUyt0b0MxRzdWV2V1TDJ3SmZ2dStnaTVzSlhtRkthZzhDbEFoSGNr?=
 =?utf-8?B?OWkyWFhWNzd2T09FTjFwVzRlSDJFWUVtUC9jVXVFeVBaSy9JTGo4SE1lSHpq?=
 =?utf-8?B?UFhHd0lsQ3liUlZNQ0kwMFVMQnFuM1phdmNMV1Eva3F5S2xrdzZnZjU0dFVQ?=
 =?utf-8?B?RnhSZTlYYUdkTEtXWEx1cjl4QnlpRVJZSTFrZFlScnlqNVRzVDNZOEVwck9q?=
 =?utf-8?B?aGtObEFoUkg5ZG03dGwxY2twWHpSa3IybG83RFNWUlFHdnh2eGVkcXEwaGlL?=
 =?utf-8?B?dTBTT2padEs0SE12K0xqV0o1SmZmR3NXMWRyMFpTYkxmaTZzUks0OGNmTmdo?=
 =?utf-8?B?OFVBVUZIMUpCRUNWcG9JcnZ6UHg4b2dOU2RnWkE3MWp6bEpkcUNSN2VTMkp2?=
 =?utf-8?B?Z0NnY0dWdHJaTWNHZmR4cDNYL0toUE9LcU9MWDRDVkhUSDJnYjhrNjUrMy9H?=
 =?utf-8?B?NnNZYkhkNVpIbVRaUGNGREFocHB4NWNpNVRYclR6ZS9NSUgxUzBEMTVxZUJ4?=
 =?utf-8?B?anU4VmR3R3JaRlcrcXVaREh6MEVEam41L3ZndW9HUU1nN1lhbFlpbUVCYlZE?=
 =?utf-8?B?Qm5Lc3lwTHpFOEtvUWNKa1FLaTVVbWZDWkpLb2pZYWhhajBOeEp3SFk1amR3?=
 =?utf-8?B?SjhwdWVrckhvV3J0UnpqbzhOVlpzTThCSC8zRytpd3Y0SWN4aHBzQjFDcXFV?=
 =?utf-8?B?eEI5bVdScHNUYWRjZDNvcHd4akR2aitibElkaTNQNWNnQmhxeDhPWVc4S1RS?=
 =?utf-8?B?RnVXbTlQZk9DNDNKUWFIeHBndUZuWksrbW9YcjRCQUV4RS9STG9ZUkNhWDBn?=
 =?utf-8?B?WjJXVCs2MHBxcE9yRzdDYS8xKzBUMkdQcnRETjRnVUl2b0lyWlRNMi9hVHhs?=
 =?utf-8?B?ak1uKy9vcGIwU2VEcFpHRjROMlB0dlNRbFhkdkZFR3Jtc05qd2dGNXBBVkp4?=
 =?utf-8?B?Q1Jhb1VEWndlOVE2RitwdXBBQlRHSjJvN0JKTmlLOXJVMVZUVXJxMy9VSDU5?=
 =?utf-8?B?eWgxZHRTaWpwVUp4elQ5ZVcyc2xYeFVFZ0p3SnVCN0N0Ri9ycE5QK0IvS3VS?=
 =?utf-8?B?K1QxU0NNbGUyK2JreWVTRWJCL2VwaFJvYnY0NStXd3pPN2MvQ2VuM2lzWnJi?=
 =?utf-8?B?bUxaanBiUklDUGRRVkJaL2VtNGRlY0JKVEg5U2JKWDJmbjVpYUR2eEIyUVd5?=
 =?utf-8?B?YkJqamdzanVPZHR3bERRbUZEL1d4L0EyQWNhY2dTZTF5MllHY0I2U0YrTlNM?=
 =?utf-8?B?bDdraVI5MmM2VGhMR0J1VXRzV0hiaGlvQTV1NUNJVHhDYko4clJtWHYwZGZ3?=
 =?utf-8?B?cDNzd3E0eHM2RHltNys2cXJXcmx3UzFmcHdrNDRCY1pQZ25QeEJNRThXSnBC?=
 =?utf-8?B?U3AySFhic2dFSWRuTEY4YmpoMVZHMWdYUWRUaGFIM0VKYmdFaE84MGVDNG1z?=
 =?utf-8?B?Ykx4OGdaRzFZYVBqUnEzNUZMRXpCbnFtOWl2RHE5dFlDTWFoaStFUUZZZTN1?=
 =?utf-8?B?NTY2TFNiRnlrdjJSellocjFQMG9rd2pGSi8raElXek5iT1pDa0pkVVJwTk1o?=
 =?utf-8?B?TkI1TFF4R0RNMzExMTBxYkVaYjAyTXAwbkhJTTNTOHNDWFhWZk81RTRCRXRj?=
 =?utf-8?B?K2taclMvSXFrZ3p2RS9XVElWSFRIRXVXR3d1VGVrTDRpRHp0TTZNN0NDSEcv?=
 =?utf-8?B?MWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUt0Z1dZbTM3TTdyQkFwZWtRa0dWWEtKN1dOUDZlMUhibE5ZWWRTUFJmZWZW?=
 =?utf-8?B?bzkydHp3djllaXlBYUk0MlErTE1naDY2ejBVeGZtRXNnT0pJNWp6enEvdlVj?=
 =?utf-8?B?bG94SktGNlhTcVlNODdyUHZmTXQ2OHpsWis4NjRocGp6bjhtUklZeUNBN3dm?=
 =?utf-8?B?UVYxMitVcFFQME1PdlVQN3B6eC9QWUtrQmw2VEpBZWU4a21KeCtQczIxREJM?=
 =?utf-8?B?czRBOVErbUtLWlkveW5TQzdvNFZ6TDZqekNZVVFYZjZGVGpoTXNZUWFYY2hT?=
 =?utf-8?B?OHZ5TjhoRUVqazFOUnpCV08rZlk2SjBDTC96cGRJT0dxOEVjTmtzWW5DUGlT?=
 =?utf-8?B?eVZZT0dwWUIybzJEOGhzQnlFemVHWFpucEdRQWY3STNMVkw4aGk4ekpXRm5u?=
 =?utf-8?B?eGdMc2V2Vm1Fd3RIU1IyL28wMFNWSFZSQUhFRFNEY05zSnk0M3FtNkVIMlZY?=
 =?utf-8?B?VmcydGVlQ1JIYTlqakJLT01jMzdNRzJXY25ENjNPY3BuT3Jnd09xdXVVaUNW?=
 =?utf-8?B?WGJ5c3FzNmkvN3lmckdKRkE3aTNBVmlpTjZEcFc4YnZLMU5BQXVJZTdEUkRN?=
 =?utf-8?B?dzZoQkhBRFhhOWJmdCtYZ1k5dmNDc2NSUGJERUg3OS9ZNWFCaXhWUVV2QkdV?=
 =?utf-8?B?dGdoOC9MRml4ZTZpQVNIcElTMDE2WDdheSt5ZW9NZ3pZajhBMjBqR01ZWk9t?=
 =?utf-8?B?U0dPMkZkZ2szM2pDZ1BDaHBJQUNrTXlNSWJPSzdzNjMrSzZtMnVBQUdOT1l2?=
 =?utf-8?B?cTlYOGVYWkI0V3hrWjlsdU0xNjkrZDRkRGNtUXdBeVBaYWVqZmlEZzkrMU5K?=
 =?utf-8?B?MkFBTWJZZml1ZmpzMGRPQkRVUHlyczJzRGt3N1BPNWJEcFMrUVpmdEVTanZq?=
 =?utf-8?B?TG16Sm1NbkphRFNETXpFN0xqQUhrS1VuV3lLWXVzcjZOaUYrbkhGNnFldk5T?=
 =?utf-8?B?eFZqTmVDRGJlUVRoNzIwODVzZWY2c2xJUFBEcXQ1ckZCNXdMN1VRajNyb2Uz?=
 =?utf-8?B?cCsyUFIwZnBWclI0eXg4cDE2S2t4dHVCeGIvditaYXlpM1AwMnVJNDZQczF4?=
 =?utf-8?B?b0Z3TDlwZWdlRzF0ZHZhZ2lsNjFobm5jNjBzblhXRXA0TVFiNllnSjI1SlN1?=
 =?utf-8?B?Rkd2c0ZOM1lLUWZDTW5CYjN0UytDNnJQT0hITkVMRW92N1RoRXgzQnREQVha?=
 =?utf-8?B?eU5hcDRGSzRxZG9sUG1LV1k4bjlhVnlwdVFKS2JCc3JQTXVMRUFwaU43V0ZL?=
 =?utf-8?B?ekNWYTliRVlMU1NTdnVrdXVHbzRqK0hhMzNON25xbjNwdDVJSWxweUcyYTA0?=
 =?utf-8?B?VGppVDdwODRyMVNaT3ZoZWNXLzFMMWsyNFhPanJqc0JDalpRWStnUWNqSHBu?=
 =?utf-8?B?TlJ0bWszdUtVWU14Zk9pYzhoSHFhWjlCNXVpUDFwMEV1VTM2VG5mZUZiaEo3?=
 =?utf-8?B?aDN3R2pDSmhCZGxveHZsV2gvcW1FOGh5THFqU3NoYTFlMEg4QnkwVEhoWWZp?=
 =?utf-8?B?QXgwcCtIbjNaRTVZTEtMaEdiOHVScWg4UlpHNkdVd3V5TEt6Ry9CUUN3VHBV?=
 =?utf-8?B?U01Qck4xRER3LyttWUpIbmdKSVNkbXhWMUFmRUpHYlIxMlBVdXlaaEJPZVJl?=
 =?utf-8?B?RW5SUUxQNFUvTWwyUG5PbkZNQVpwSVBMdnRhMHdXamdLZFRlZ0h3cUlLU01P?=
 =?utf-8?B?b0xJUHM2d1pNUW91bjkycUJ0OGNudnFpN1pDdUp4Qy9OcnFaUlh3bytLVEoy?=
 =?utf-8?B?Nm9KY2dyTC9yaS93SnlKQVNjZUdqK0ZqQW1OT1FvQU14Z3FLbVF6WnpUWUZN?=
 =?utf-8?B?T3RQc0hndXVTQit2MS9FQU1nUHhsOTdZS2ZsRDRqS3ZsRU5PaXZFNW5zdkxS?=
 =?utf-8?B?ZllQdy9qcVBra1NUdVBoTHh0LzBEaGFOMEpzR0hEUFdSWi9ZTWlUOHlDak9p?=
 =?utf-8?B?Vk5oVkNHekZnemFoMDRMMmlXdHN5cndRZlpscm9nVEFhNldORjQ2aWJDK0t0?=
 =?utf-8?B?S2NvY0gxczlPaUZFaWxuWXRubUFtVXgzby9ZeU5uMU5BaTUvTkJOVlBzRjlR?=
 =?utf-8?B?VlFiNWViWThQVWNFZGFJY2JNNm9EUGx3N0VzWTNObVFEWmxtYjh6Wk90Q3RI?=
 =?utf-8?B?Z1BPeGNnUWNKUEVTN0tSdFVONmZDQmtzTE1aTFEvQ1RiU0RmcmJLd2t6QS9h?=
 =?utf-8?B?VWJLR1h5WWxGU3A2V2srS1AxdnhEUEVrUHh2N3VzcFprMjhRN3hmd1M3SGlX?=
 =?utf-8?B?bkQwMEU4SG1UOHdESGZRV0pUUEkwR2ZUMzJIRDVCQ1ZWVm1OVVVYZ0JwZ0or?=
 =?utf-8?B?aGVOWFZkQU5ndUNHb0VRcVgyNXpmQ3lFM0JxeEsvUTNnTnU3cm0vR0hjeHc4?=
 =?utf-8?Q?vBfE77fyLXcSaM66mIiAALsEv59RRtIDl/rVICtkm2qIJ?=
X-MS-Exchange-AntiSpam-MessageData-1: XXd4cgQdLCQQSQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5471ed-6883-4500-1fdd-08de625f495f
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 13:30:52.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZ28t0ul+RTQUphu8s6qSqZBsbGp9bDICdu5qKl3L3XjAS1zzOGp2kZr5v08+RZf1OxxwHUtiKZaaUq+s7XW3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9739



On 26/01/2026 07:45, Manikanta Maddireddy wrote:
> Tegra194 PCIe driver uses custom version number to detect Tegra194 and
> Tegra234 IPs. With version detect logic added, version check results
> in mismatch warnings.
> 
> Use HW version numbers in Tegra194 driver to avoid this kernel warnings.
> 
> Fixed version check to enable ecrc for Tegra194.
> Existing 490A check is left intact in case any HW relying on existing check.
> 

Fixes tag?

> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V4:
> * This is a new patch in this series
> 
>   drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>   drivers/pci/controller/dwc/pcie-designware.h | 2 ++
>   drivers/pci/controller/dwc/pcie-tegra194.c   | 4 ++--
>   3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 345365ea97c7..0dac5d2f5a83 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -559,7 +559,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>   	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
>   	    dw_pcie_ver_is_ge(pci, 460A))
>   		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> -	if (dw_pcie_ver_is(pci, 490A))
> +	if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
>   		val = dw_pcie_enable_ecrc(val);
>   	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>   
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index f4cf1602cc99..5bceadbd2c9f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -34,8 +34,10 @@
>   #define DW_PCIE_VER_470A		0x3437302a
>   #define DW_PCIE_VER_480A		0x3438302a
>   #define DW_PCIE_VER_490A		0x3439302a
> +#define DW_PCIE_VER_500A		0x3530302a
>   #define DW_PCIE_VER_520A		0x3532302a
>   #define DW_PCIE_VER_540A		0x3534302a
> +#define DW_PCIE_VER_562A		0x3536322a
>   
>   #define __dw_pcie_ver_cmp(_pci, _ver, _op) \
>   	((_pci)->version _op DW_PCIE_VER_ ## _ver)
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 6543c6d49fc8..156918ba5ab4 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -35,8 +35,8 @@
>   #include <soc/tegra/bpmp-abi.h>
>   #include "../../pci.h"
>   
> -#define TEGRA194_DWC_IP_VER			0x490A
> -#define TEGRA234_DWC_IP_VER			0x562A
> +#define TEGRA194_DWC_IP_VER			DW_PCIE_VER_500A
> +#define TEGRA234_DWC_IP_VER			DW_PCIE_VER_562A
>   
>   #define APPL_PINMUX				0x0
>   #define APPL_PINMUX_PEX_RST			BIT(0)

-- 
nvpublic

