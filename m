Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7AB367F26;
	Mon,  2 Feb 2026 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038857; cv=fail; b=j3NbmwV4PmxB1ObbQMQH2zpyCZwvCYsYV9UTeyvYfKXo6w0eIi/FaVC21vmMAXLHP5TEahnCHg8lYofUtaGn+GHgAPw3FpM44xRkUdBDdcjYCsyEwI1YuAPmE3+OBn9pVxHThp1Hr1Ays9BZ1llpEexZ0vcZEHbLccL4/vLwXWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038857; c=relaxed/simple;
	bh=eGjCWV6SMyHEnASU7Vntdi7CanWoooIU5FOYL+vCbwo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mm4GC+CtYxxsnCNqElX07r4jQaHP19dUyCCuYUjAx8o/LPjWV4noHoPlsQBiVFZ3KUVkQneMCGG5wOrDrP/IkqlhlAD1Y2CDOrdDuV3jQZK7MMxDtBdN05gmzj0XsZegoya6YR4WH4kx8pLiBLk5uYOsPvBJ4eBCyDxophX+gOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IDENmR28; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IDENmR28"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3zUHMQOIzJYmDXxd2YiW0ynuZ3dFeuJ2TNzIacwxnMe+/Cgi4J1DV8MGUd1w058Ckg+vwzrNMWeTQ/wyUv7HGS1O16ml2EaesaK9rluxTF6nWdjuqIGJPNztQKFuQH7aI01ecamhc7OmNNMVUoP+zN+XBwjBfdneULPb1HTp09mAfg8xqXWRpDF7IJU9+hWOGuBL2lRfB5cNLxsKJv/MVA/8eD9TE9mya/aDxSQD+TjKi3S1GTukm/EQe0DIonJmn2FgD18vnEpcVbrziBX2M1stgxiqVYAhT3+Ob+kfp8gQCPBpKsMihqMXiT8m/l9Dbjo+ekrFiz1xhpysEIUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3xOtURFp24IGPmA7sHDc4QpjSLLSfr4cP9IFrrvZPI=;
 b=I4x6lXVzr1hwwH+FLPw8uaP/wsc0dSjtQ/g7Uvp+fuGhq/XEX8u8QTxCJrH6qO7vsF1WU9TDXYpQ3JebKflqITjMPR0loJDe8xXdePiEPYrTZRXzUuudn7FzRmp/zbn2sJ4KUe8+zbcp62GUPotArPIzvsjWfan56nVlOhfdwpOf7S16p7f3FvQaHNDOFQPO72CzyIUDdc2xjziXiUIBAeCGBJLNSQAYvXkrsQ1mR4geURjrbu0jy5uakMxcQzwaBPqRzAqGvVlOECDHg+90Aj8jQE0gF9b80IWbv3z3bdp0lVJEjcOaluSze135BOZ0UZsIAVnTpt2+12OlNuUYCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3xOtURFp24IGPmA7sHDc4QpjSLLSfr4cP9IFrrvZPI=;
 b=IDENmR28VBEkHTN9r4toxLX7RxMmhiymEOHfWT6s+6RTh8nurpJEZ2zvY9r5HBAw9lWWIL3xMRl+LH8YtAZ2p+bI1UNHHOmCUdrjWwb7QptWCRBpfws3lF4zwWrYOxPLIgorP0XgpTKHIhEaBvBiB6kwq20GHrG/pQgJzYdVb6FhXEiDwVMgKjKddIrKY7gG0i2abOFLpWnxQtxyg6ksNVAZTuJkvyQAX0nVCYma+f9z5LwBr5AC1PVIvEgSyUkOSx0GdVLK4tyAeWvEQhY4opIaBe2/sqDHxIuWRbaN5KS1YeAjoNXYHSo15sK99u79puWSmUl+K+pgjXP/g69weQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by IA1PR12MB9739.namprd12.prod.outlook.com (2603:10b6:208:465::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Mon, 2 Feb
 2026 13:27:32 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 13:27:32 +0000
Message-ID: <60cf02d1-e6e7-4ca5-9616-d6438957d943@nvidia.com>
Date: Mon, 2 Feb 2026 13:27:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 15/22] PCI: tegra194: Don't force the device into the
 D0 state before L2
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
 <20260126074519.3426742-16-mmaddireddy@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260126074519.3426742-16-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0222.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::10) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|IA1PR12MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ebf1a0-e711-4309-bb71-08de625ed1ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emRYOWRWNitRNUR2SFJkMDI1c3IxQnlFTzh1STVEMG1mcTVRamJaMTU2bWRr?=
 =?utf-8?B?MCtSWndGVm5JVG1uVVNyUXgzZDBzUFVTVEpBM3h2RnFGK0dQWGVPcDY1UjVJ?=
 =?utf-8?B?YkNNcXhHc05uaDBzTDU1Y0NrT21peHd4c0tnZDM0WTNnYk1rMFU5aWgxeDRr?=
 =?utf-8?B?dEhMaDNCbG5yT0EvM2s3ekU5M3FMRVVoOGRCUm5mQk1TakxjazhIdzAxNi9j?=
 =?utf-8?B?cW1wdmxFL21ESGt3d0lwRElpbnd3ZXNFbE1oU2ZueWx5aFdaMDlPMU4xWUlO?=
 =?utf-8?B?b1kzbEVtbFNxN3VyaTRSVWtyMjdHbnZES0pMb1NKQkpzano4QjVncmxiOU5y?=
 =?utf-8?B?ZjF1T2Zjd09td1RHRW1vYlVOUGJLcE1US1BXRkptc2pBdzdmODIxN0FkWEk2?=
 =?utf-8?B?U1ZEY2V3SnZybnhaTldIY2hFM1ZnZDhwOFRCUFM1WTVVdmlYTHlmcVZDREQr?=
 =?utf-8?B?dnUwTU1WSGFLZkJiUGw0UHNEc1NpcERKY1FXVXlVMzBUb0FFSHlkd1h0a1I0?=
 =?utf-8?B?T213Z3dlM1RYOE1sYXRGN3QrckJEbnh0SkQxTnQwSVp2eVBVTi9JWEd1M1ZE?=
 =?utf-8?B?OGFqdStFSEJVNW52VE9TTVZaTGppWkNhQ0tOYSt2aUJVbm9DMXFyeUVvdGQ5?=
 =?utf-8?B?d0REa1VQM1FPYUtuV0dzdVRVb3czV3QwamFTdGZsM1Q5bVJ6MHdmYmtvUVIv?=
 =?utf-8?B?K0xHcitwM2kxNmh3NlQvVWtLSURDakkwZmhybTdZS05nSTVLVFZDOUNrYnhn?=
 =?utf-8?B?eThoMFYwOVZVT3g1SjgySGt0YklPandkNnUvVVB5UlB2TlFiUnBsaUtzQU9v?=
 =?utf-8?B?TW5wUzJKR2xUbThmOHV4aXhaaGs0aXUrSmwrMzZYYUxQL25vUFdWVGhYTkFZ?=
 =?utf-8?B?NVZoWitBdmxmUFRhdDlkejlWSk1wT05pdDl4SlRnZ3NPNEtsd00vZlc0b3d1?=
 =?utf-8?B?Ris2S1Nudit1blhoQVQySy8zZWorNlFXUTd5V09QVk9aeEVOVC90dFZLOWY4?=
 =?utf-8?B?MzNFZUs1WEk3WXJnY0ZlQkRoVGdLUnhtWGVvVzVJcE1NRENDUVR5anRIZHlw?=
 =?utf-8?B?Z3R3UUw2NnN1cWdVb2srUnN4SFNIVHhMQUduczRvcUc3M2M1ZlZXVFBsQ29I?=
 =?utf-8?B?MzVHcC9ESlJ3SGtWSlJwZW9tN3RXMXhBRTZDOWJYczZiRzlFemdKWHcrSDMw?=
 =?utf-8?B?R3FTa3hRZHNMd1BSTFhsdWtQeTFIeFcrMzVpeGkzaDVlZGNBdmZKdVBKWWN4?=
 =?utf-8?B?M29SV3FDRVlDNnhoekpGVS80cmI3NEo1ZjBhWHpIalAxZXZpdlBGOFNIQ3Nn?=
 =?utf-8?B?S2ppM2xVYUhRZ1k5YlNyeC83RXZ2K3lFc2JzQVJvZHFiYzQyWXZ2ZWpGRXht?=
 =?utf-8?B?QmFUU0M2NzhzM2JaVlkvWDNhS2dzc09iOUxVZE1YRGcrZkRpU0Y2cVNYV2hp?=
 =?utf-8?B?anlOcGI5Rit0WTZ2aTh0UlVmUjFiNXNMOGxuVG9jbTRHTERRTHhaeVBJOWFE?=
 =?utf-8?B?MlFUbUhnOUdrNU1uM0UzYW05ckl4Zkg5WXI5UzF4cnl5U3NRWVNuTzdTV3hX?=
 =?utf-8?B?VnpUNVl6eVdXcXJGRXdDajd0cXpWRHBNcENUZDA4UUlPenRCY0RyOGVTekVE?=
 =?utf-8?B?SWRya0lyMFNzVzYwWWtCak1laFU3d2pwS0txdEhqQzFyZ2VxeVhraWhJRis4?=
 =?utf-8?B?cnh1cmtQTTdGOXNmeHdiVERpMjFVUWxvTSt4Ky9hUmp4NkZVd3BIaFlPaWNV?=
 =?utf-8?B?TXh0S1N4bnFkUEhDdEpSZEk0T01DYTROTXNCQm1JSVdnUXpJdXdxM0lucGJ3?=
 =?utf-8?B?UHUvaUFNbVFoZnpLRk8zTlFLUW44eFlDZ0gycXd0dTNCM0R4THZkcXJhWGhT?=
 =?utf-8?B?dVRTM0ZhMlpaOXdTaFBCOVU1Q1NYaCtkV3Zrc2pWemRCNzBXSFBHYXZZaHF3?=
 =?utf-8?B?TUdqalJaWVJJSFhIRnNmWW5LWWwwOVFETjhBc3g3eDJiNDgrUTVWS2RLb1JF?=
 =?utf-8?B?TUNob29tUE93NUpSS2RhYlRtR3p2K0NtSzhNV3BYd29Pc2lSOWdubnY0V1BP?=
 =?utf-8?B?aXdXdU1uRWtULzhwbUVEczBWalB6NDdyeVUxMUdNUnFGZE0xWnVkLzZoT1JD?=
 =?utf-8?B?ZTN5MVdtRDE5eDRuOW9udHRFUEUrU2djbGdDNXQ1WXh1Q3kwQ0d1eE5SNVMw?=
 =?utf-8?B?Wnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUZ4UlNURmxlODRJQ01yWmo5UWgyZDhLQVZjb2VTZ3hLNEhIakhVWkFoT0h6?=
 =?utf-8?B?cC9temVVMmcwcTY2ZVc4OU1nSXhrMDZsRVFjdDFDVzJhTHN5akRTQzBLTlhv?=
 =?utf-8?B?Y0VudXhnNXlRMDFrb2MzcEJqa21qRWszR25MRnoyYVBMblNkckswQWc5blFw?=
 =?utf-8?B?aElJMHBjRFFLUWUrMWoyaWNkQ3pXUm1Ea051VnJPSEpSUVNzSHJObkp5bWFx?=
 =?utf-8?B?bDhmTjdNZ3NTU0E0Zlg0bjBjRXpPenpjSGd6cjByY2NkQVRIQ0RwejZkTENx?=
 =?utf-8?B?TytRV1NzcTFqdUFlMmVtNUw1Nm5uNnhiNDlRNzlTZVRCb3ROWE5PZ0ZTTFox?=
 =?utf-8?B?dHVRb3Y2UVF0WWYyWHd1Q2QyWkZINVZnelZDOW05bmQ3REtEUHI1MW5JRU43?=
 =?utf-8?B?Q3ZJSkhNbmV1V0lRRnZUSHJYd3pxWnpUYzdTb2lxS3NHc1J4V3gyRFZIQ2Rm?=
 =?utf-8?B?T042QjdvZllzSXFGUmp2UlFKbWJTc2VMdDRDTkVHYmh4VmxSek55SktUMGNK?=
 =?utf-8?B?clR1alFzbEZzMUZtM2ZuMHp6aDA2KzQ5bEVFZENPeUdmdEVJT3NwdGdodWpm?=
 =?utf-8?B?ZGl6VG9Oa2h2TmQ1MncwdmROWGRBSFZnbzhRK3VOWlhBNzdGT09JODZSa2ZU?=
 =?utf-8?B?RVRyZDg5dlRCK2RzSnJhb1lHQkdlRE12aTlUcytvaEFCU3kwNU5GSXpBeWNq?=
 =?utf-8?B?Y1E3Uklpd1JpMmR5NngyZkdkUUVsaUMzcEt1dW8yZVo5THFUdGZjN3I5YVpL?=
 =?utf-8?B?UGp1Q3VEWDlQVERsQUthS01NRkZrNEdvY0o1WVpwYW9jQmZIWjZ4VFl1Q2Jv?=
 =?utf-8?B?NGcxZHFvMnVKOWhubk93ZnNkZC82U2R3dVFPa05HQmtWRFdObDhLWm5NZ051?=
 =?utf-8?B?Ni9rTkJBTW41RkVudWhRZEZJM2dsa1A5bmN4blg4Yy9hazVqYUpYbGw3VE01?=
 =?utf-8?B?ZjhDTjNmK2tCSlhVbGsvM1FhYVV4ZGhVb0dIckJGVjEwRXk5dGVCNlkzcW9G?=
 =?utf-8?B?UmVwd25JVW9kUnhXQVhVY0RsT2JKWko3SnQxbU1jVitIbVNRSEJpcTJHSlhJ?=
 =?utf-8?B?U1cvNWc5YXFUQno2Mi9NMHVzQTFHNnpjYnlsdWtzYVZHUW1EZ0Vua0dncVpE?=
 =?utf-8?B?OFJuaFVjNVJNRTFEeDdkMDYrU1J6L2RGZnNlc2ZWQTQ4WjJrMFlwOE1TeU1a?=
 =?utf-8?B?SE9rejFON3h4OGNIcXV2RE1wQ25ISkRwMG1JQ204TEZEZTJZR2hRbU1ZWm4y?=
 =?utf-8?B?TEZ6eUdKV0VoUTRRZHVrZ1BlZnlwNGRYcTY5VzNaaVB1ZjdkeUFTY1JjdXoz?=
 =?utf-8?B?V2dlSjN5ZFlwSksxZzVkaHlYN0hFbitzTjZ6TXRrZXJremdUQW9jQUpDTWdi?=
 =?utf-8?B?V3o3bUlySW0yUThEaVF0cjhCMFV0Rkh3R1FCVnU4dFozRDlJMmoyMTlpS2N0?=
 =?utf-8?B?eHJ5dmFHV0F2bWpadGxiRXNUeVU4Q2hwRnpaWnlvRm9Wa3Qyd3VhWkV4d3B5?=
 =?utf-8?B?T3hQanBCMDRteENWSGxnSTJuYUZzUDM0THgybmR2Snh1cEVFbTJDODluU3Rl?=
 =?utf-8?B?K09TZXk3RkFUWWp0QnBia2dXMGN1Z21IWnk5U2ZabGpCMHlld0dmY1hFbmtw?=
 =?utf-8?B?KytNWGdRRkhjNnRUMnpIVWFqNjZUdVFnd3ZHUEFUVGg2YkFhQnR5ZzAxWFcx?=
 =?utf-8?B?RW1vSjE1L1RiNEdRSEp1RW53Z1J3Z1RxS0pXK0duekJxS09mTkNkMysxUDZh?=
 =?utf-8?B?dUlCWjQ5WStlbkp4MS9jNjVjUXhMT3B1NFZlOTlpUDdFVloreGhxMDcwRWFJ?=
 =?utf-8?B?dkhhYTNBQmV6cVJQWWdKZGVTeWtkWmxnUnRZbjhielpDaVc5bjFaUi9FaC9z?=
 =?utf-8?B?TW1TZjExZitkOXNmS003cHpXaThwVWEyOHRnNEdSejhaQ1BDK2czMG1YSmY5?=
 =?utf-8?B?aTFJTW5QcWJDR0lxajRhNk5zNlA0R2V4VVJDVEUzVGgvaVlETjFwcE1SbGd1?=
 =?utf-8?B?TzJVQzB0eFRWT3YyNDZiczNtTDJLbU91c2paQ0hTaCtiaTkxS3lkcDdIQnNu?=
 =?utf-8?B?SXlFRlBVbzNnenBrN1RNeG9pOHY4S1g2WmxuYU1XTk9nOFpRREZ0UUZXaWdK?=
 =?utf-8?B?b0xFdkJobFR5dS9mZXhrNHRVUUlmMHZJSXZxeG13L2ZTYmZhNDlwKzltcWt2?=
 =?utf-8?B?d3R0VDg1RllkdXJiSzloMlRNMGVVOE1JYytFQ1BSbFErdTZLSVN0UWVWZWdK?=
 =?utf-8?B?TXlud3RrbVJWZ0JKQjA2MFlUY2ROMFlqTU1YODRodXZ3c2wzTFV4Mk9tVWM1?=
 =?utf-8?B?bGtML3FQcU5JUzRoVDdoSVhtMitOSFpjZVBSeHVoM1RteG5kYW5UVFFUT3Z0?=
 =?utf-8?Q?ILzymy6c+rgcMrzOTi1fgCgorU0Y7kVWuHDUwwLf4szpd?=
X-MS-Exchange-AntiSpam-MessageData-1: C/KLKW3Ki79Exg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ebf1a0-e711-4309-bb71-08de625ed1ff
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 13:27:32.4974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWVOYvgt57fPUFQ/7Pu78qjsbx7If3boDw5XFIL+Kdwx4gRx3TAbPM/8IemZpvJ/fSha3ZZl9XE7wzCJ/pY1ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9739


On 26/01/2026 07:45, Manikanta Maddireddy wrote:
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
> 

Drop the extra line here between 'Fixes:' and Signed-off-by.

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V4:
> * None
> 
> V3:
> * This is a new patch in this series
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c | 41 ----------------------
>   1 file changed, 41 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 6fcfff93d4bc..1a269397150a 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1283,44 +1283,6 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
>   	return 0;
>   }
>   
> -static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
> -{
> -	struct dw_pcie_rp *pp = &pcie->pci.pp;
> -	struct pci_bus *child, *root_port_bus = NULL;
> -	struct pci_dev *pdev;
> -
> -	/*
> -	 * link doesn't go into L2 state with some of the endpoints with Tegra
> -	 * if they are not in D0 state. So, need to make sure that immediate
> -	 * downstream devices are in D0 state before sending PME_TurnOff to put
> -	 * link into L2 state.
> -	 * This is as per PCI Express Base r4.0 v1.0 September 27-2017,
> -	 * 5.2 Link State Power Management (Page #428).
> -	 */
> -
> -	list_for_each_entry(child, &pp->bridge->bus->children, node) {
> -		if (child->parent == pp->bridge->bus) {
> -			root_port_bus = child;
> -			break;
> -		}
> -	}
> -
> -	if (!root_port_bus) {
> -		dev_err(pcie->dev, "Failed to find downstream bus of Root Port\n");
> -		return;
> -	}
> -
> -	/* Bring downstream devices to D0 if they are not already in */
> -	list_for_each_entry(pdev, &root_port_bus->devices, bus_list) {
> -		if (PCI_SLOT(pdev->devfn) == 0) {
> -			if (pci_set_power_state(pdev, PCI_D0))
> -				dev_err(pcie->dev,
> -					"Failed to transition %s to D0 state\n",
> -					dev_name(&pdev->dev));
> -		}
> -	}
> -}
> -
>   static int tegra_pcie_get_slot_regulators(struct tegra_pcie_dw *pcie)
>   {
>   	pcie->slot_ctl_3v3 = devm_regulator_get_optional(pcie->dev, "vpcie3v3");
> @@ -1650,7 +1612,6 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
>   
>   static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
>   {
> -	tegra_pcie_downstream_dev_to_D0(pcie);
>   	dw_pcie_host_deinit(&pcie->pci.pp);
>   	tegra_pcie_dw_pme_turnoff(pcie);
>   	tegra_pcie_unconfig_controller(pcie);
> @@ -2402,7 +2363,6 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
>   	if (!pcie->link_state)
>   		return 0;
>   
> -	tegra_pcie_downstream_dev_to_D0(pcie);
>   	tegra_pcie_dw_pme_turnoff(pcie);
>   	tegra_pcie_unconfig_controller(pcie);
>   
> @@ -2479,7 +2439,6 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
>   			return;
>   
>   		debugfs_remove_recursive(pcie->debugfs);
> -		tegra_pcie_downstream_dev_to_D0(pcie);
>   
>   		disable_irq(pcie->pci.pp.irq);
>   		if (IS_ENABLED(CONFIG_PCI_MSI))

-- 
nvpublic

