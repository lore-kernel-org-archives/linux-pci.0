Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C983EBF3C
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 04:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771820282; cv=fail; b=AUyj3v3QlaXuP2CAxC1wU3BrwFvo6oyopj5R3pABRpBtEkaupdn3QVyLrlU1BqSMkulgIRj5MyXtblcgdbPmj+NriRHkVCThx2P1ZKWwyP2mfylapNMEjb6iuPj5ILh+fpoOW4RsU9pGSKbzEX/pDnOi2Gp/VEx3T6NbK6tjLsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771820282; c=relaxed/simple;
	bh=+MB7DEVdIiKg2c8lmWk7Lr8XayGs8v5BzxqJFA9TB+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a00hrfPyPIDtWEtveJVE05eIumFJ7f1WDhgl4kyahf2QwTMh8+cMY/JlE7Thq+EqThwzaCCH1M2YCVyoJMzMEA+RZFYBhlzs7RmvS7NRTB6TQASzZlYmSgiW64lHLuUJhhS5jNeuwB37uZBhN1yQb6hF1v3x46HAXrEuNOyDg8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Leu1vLqM; arc=fail smtp.client-ip=52.101.85.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Leu1vLqM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVFrK+Y6pDfbxiYlaXdWbLR4uadfBY3wZIalCYOXCC6K4xomPKUgDo0y8aksugHQCkT/HAcuOMnQWbDwpRVAGwHZnqP1EQNzEsFEDHxSGwCUn5AVCcK9ijs1BFBGvh7hObZ9TFrOp89VfIcxRl+cngEtA/+/kI9HjARkCscsodNGDq11rnAhVrcLCKJ1hcB9S7fohqnTQ+1ad6SP4Hd1PPxNibAyULhbL88QX4sM74rwc34QSgFDbkb8RUrbHtpLm9mDfNIrWTOKf9gAzZ4A0RGxrvbwLfx/2pIIslJKoigZRdR886P7w/ss1Tq+tlx37Afe3ge4Jc1pyLLnVbT/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp2PGc0FARDbUDisV4MNZ8bVS5djrtgPkqMdRvjaZpY=;
 b=gDoej7g+AZXxSPtEEYH3e7YDRnMT6Q8uziVZ16bR/JQhAZkNljhgR8kHgPaaGHlNzhBnWHiAbNlqEMOH+mh08SCpiDgnXAyQl2gdXzplFFA6nkkEXNVd2mLHbPN27iuSUfTImHQhIqFJuDB6Gz90S+4C2cyyGB3FF+g5MM599A2hh61HZSFNjTn686baLo3/TfsvkrTaONcZPz4VzlQE6f8MnHqO7JWoAgwfLhuVx5sJHiN4Dy7oijy4g9JMMcuEtRgOeYdTg95AfR4q+HfwPQLIOYEiJvjicxljn6cLcgManpN1DGTMIPpD/8EOwJtf2XHs9JmXoHohA+FL4rvZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp2PGc0FARDbUDisV4MNZ8bVS5djrtgPkqMdRvjaZpY=;
 b=Leu1vLqMB9BfmKas0S5tB6d9jr4eZeG0CxPUyMjmg7sfKtQZ1TKXTjO/zBCFsGV/S4i8s2++WmF6vzmv0tQJxJyLYYpWaDrWryrGNbFkgQNNfB8K72RtRmzoK+I5B1ZCLrwxS/hZFrSYBrIOnCK0jJspB/ANdZpfWCJdQGcMQPqtHDh9/h+myOdxpl+MKYayv6vBTFN2tSI57vT6hjVH0oKPYNohQ92treXwMVOQY43f9Qd2zlg/rXAGyX1t5thVfAhurOtzLivHNaCnH4pJNy499MZHxPI1pympEYRf/EzukuvfobKnBjm2+p4rtEX1bwS1OyH6nKh0rBfUuNVOLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Mon, 23 Feb 2026 04:17:58 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 04:17:58 +0000
Message-ID: <99c36994-bec6-432b-9b8c-8a238db41960@nvidia.com>
Date: Mon, 23 Feb 2026 09:47:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] PCI: endpoint: Introduce pci_epc_bar_type
 BAR_DISABLED
To: Frank Li <Frank.li@nxp.com>, Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Koichiro Den <den@valinux.co.jp>,
 Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-15-cassel@kernel.org>
 <aZTlsQedwzvGtD7K@lizhi-Precision-Tower-5810>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <aZTlsQedwzvGtD7K@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::17) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff50021-2a65-4ce0-0db9-08de7292867f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVlOOW9pSGM2R2l6Tm13NzBGSFhXbDNPaHhtYTUzRVdsZUprUW55bW5ZOS9D?=
 =?utf-8?B?SlhWckt4RUpmbVIrYzdVbGx1azNIZ09vQnBScmVKN3pQS3FkZjdVTXdCM1hu?=
 =?utf-8?B?Zkh6VWtlOC9UTFJzdUhUTmZKWTE1RTdIRmtqU25xS2hsS2tscFFERExQZGcw?=
 =?utf-8?B?Q28wYzIrTm5wV0hwV0VRN0FyVnM3OE5FUkpoSUNwWmt2NUtPa21IVnNoRUZ0?=
 =?utf-8?B?REc4Vjg3R1BVNXgxUUFtRjNpLy80eFN4TXhnZng2T3R1UlJTOTVMZmJsek5q?=
 =?utf-8?B?b0RwQXlsbW5sU2pTNlJQUjVQZlVWUE5vaVZXY1hnQkVMNDdNbTZTamdHU3E1?=
 =?utf-8?B?Rk4wbnYyT2RpaEswSXBqbFNWdFRobDZUallZUXBmYTBqT08rNUFzRTlKQW1y?=
 =?utf-8?B?N0NSd3J1Vlc1cVk0Y3JRVVBlWmdQSUQ1cWNOMGhMU2JBZmYzQ2hKNVJFTENh?=
 =?utf-8?B?RW5XMnV5UHJaQjRqUmFJaUtjUUZZR1FwbURuakxQc0pMcnowUEF5WnhnQ21E?=
 =?utf-8?B?dm9Fa25TV3QzQUJFQk9RZU1lQWExc1pWM3JxbC8rL0lOWXU5M0VVcmovU3VW?=
 =?utf-8?B?REUvYmF1bnRablBmS045MCthcjlvNEpHaEdXakNkVEpjZGRlak5pbFVvOTBR?=
 =?utf-8?B?KzJZaHVVVlEyRno0UnJSWTFwSnZMbzM5aGxKR1JHRUtXVnhxZ29BVk50L3ZF?=
 =?utf-8?B?ZEYwZWVVelVpSUlqakEyOUNPK1I2OFhEQWdaU0E4QzhiYWxBMFA4NEJoT280?=
 =?utf-8?B?dTFtMjFNT2dtRVlDMWVSajRBejZIWVJRNE0wa1FHY0JtMnp5Q0FMYmxkRjRa?=
 =?utf-8?B?a2dkVk4rRW1laElCeFh2MzcwQkdGQU5UOEF6SCtlSmZ6L0x3b3lsRVlsSVJx?=
 =?utf-8?B?RjQ5dUg1Vi9nYzhPZEdpWnphWVlzQ0lPa2V1ODVQMndsdG50MXhpcVQ5Q2tU?=
 =?utf-8?B?TDhXcjgvN2d5aUJhN1RNcEZSek00T3dNem56d2hDL29qM0V3MHl2L204NzZT?=
 =?utf-8?B?V0tZYU85cWRyRTlSOXRvdzJISzdnZUF0QVREQURzMTNkWGFHa25MbUt5WDRI?=
 =?utf-8?B?eU1MZVFRY1FrWGpEeCs3bHkyREhoeXdyZFRpOStxeW1yRHJQL3hSbitEZzBu?=
 =?utf-8?B?K1c0RnBHbHJtZWJQbnlUaHFwWUJodGRJcXNIb29oYXByWUNtWlFiaG8wdWVn?=
 =?utf-8?B?WkNudkpiYWgrV2NXT3JnZHl4WDZueVBaZWs3YnBOUHJGRnhUNklZVGtQZ3Ay?=
 =?utf-8?B?S1cycEJpdzA5QTBWZ2VQRS9ZVWpPblpEL3dHTVovelF4RVZwcUFKZVQwcjIv?=
 =?utf-8?B?WWJaam9BaDBzT3Qrd1U4d20xTllNVExUQzRuSnl5cTl5OXNDVlJWQWdjdUEv?=
 =?utf-8?B?RUVFUTkvc0VkNXI2TnloQ1ZTY21ta2FIa1pwQ3hGdEFRYnVHNGNQRU1mL05R?=
 =?utf-8?B?YmVhQmxxUVZVSm1sdEYyRWc1S2JlTkpUVUZMdDJCdE5KTnFFQlBEM1loT0xt?=
 =?utf-8?B?VXp2QUxuOHBSZnFuRnJaaEFZbGlIcUlKUHB2K3VzWHMzOS8rTWtkMFc4Y2xr?=
 =?utf-8?B?VTMwb3hSWGVQdUdSZFRJWXQ0b0JJVzBQWGZ4SnA5MVpHR0F4azlraFpjZ3hE?=
 =?utf-8?B?cHd0OHdhVXBPQmJhaThNNTlTNDh0UXE2V3k3MTNaS3FxS2o1WkJlVjR4VzU4?=
 =?utf-8?B?WkNIbDVEUDk2NEh1RDVLMkZyNkMyVnQzODNzNGxmY0JqdktjWVozSGxLcEJS?=
 =?utf-8?B?alJxOFdaVmF4NGhTemJwN0p4SkFNdEZLN2szVlVlZ0hKVVR1cFVuVjB1b01Y?=
 =?utf-8?B?WUJsNDd2ZXJrRi9xT2lkK2todTNYTmUxdXFTeWNIT1B6d1pHeDZGaVlqQmFo?=
 =?utf-8?B?ckU1MnlPM0pkdmloVVd0NEdjSHFOMmZZdEh4WWxvVHdJRDdNS2ZkMkxMU3lu?=
 =?utf-8?B?RlhWS1phY3hlRkxHKzhkTHI2STdVME9TYVo3dk90TURCd1IyOHVOYTA3Zlln?=
 =?utf-8?B?OS91Sk14ZWNHc3loTkZKWUFBWmtKSmhKaURzVlhJUDlLVzRnRHZGSjN4azd6?=
 =?utf-8?B?d3dvdlNwb3hIV0dBWGlqeGR4cy9UdHlGa3o4NmNNeFhKV2ZMSW5DcjV1NXhY?=
 =?utf-8?Q?DtaY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWppWGV3aGd1bThKOWtSNGpOend3VjJQQWFJSXVOM1dOazRDQ2NacW90WTBT?=
 =?utf-8?B?S2ExdVJPaC9PWTRvcmZOanNsak9XKzVvQUJhNXZqdkQ4QlBvNHl0TjNhenh0?=
 =?utf-8?B?NEJMU25HOXh1UlBVc2dpazdMU2V2K04yU0E3TXBaQXU5RUJ2dUVoVmdPeUs0?=
 =?utf-8?B?dXNtbEdSR2V1NWdrU0RjNnhNT0YrU0hwY0EwRkVISHlDdVhYd1pnWDl3S0JS?=
 =?utf-8?B?VXVDM0FEZzVSa1BKQjY3SzRYci9mYmlTRlBzOWZWbThQVDRSSUNqY0pDVzlZ?=
 =?utf-8?B?aWFsemc4M2QxVTVTOGdOWFZkcG5Xc1dkcVdOSm5QeTVoa295eEZVbzgxRGs0?=
 =?utf-8?B?MDFRK1RvT2g2bUszU0p4S3J2OWV5R1dqWUsvMEM0dVp2YkVZSnZQaWZUNS9R?=
 =?utf-8?B?SW1Scnd4a3FNT1NUSVF5KzBVLzVyZ3FkcS9yQS9JNjg3NUxUSmdIQ1JxZ1Np?=
 =?utf-8?B?RXY1NnhUSGs0NytUTmZET2lvMWFVNVFZNzloU1BRVHNVQ09laHRTaHRzZUdj?=
 =?utf-8?B?a3FhRlM1OUlJSVdFQjNac3FGS09GeG9IMTZMY0czVXdjRlJGTXVVQjBuRzA3?=
 =?utf-8?B?Q3ZhTlFYeElNNWNlU2piaEtUaVE0NFA1bVdvNGcxZ1JYSFdqb2VrRFZ3M1Np?=
 =?utf-8?B?Nm1YOUorTUw4VkgzYlJsUkpIWE44aXdnZWxLYks0b05LeHU3bUY2by9wblVy?=
 =?utf-8?B?S0pFVHBsZCsxOGw1Vzg1YnNPODlIT3VoWGdLbVBybWZqRklWcHBBalVYcTJo?=
 =?utf-8?B?UjNMVTUrR2tVeEdZQnNabEJMYmFUeG4xYTZsWW9tNWdGbG9IcmwzaXZhYndM?=
 =?utf-8?B?YW44S08wdjF3Q1dDK2xONTU1ci9tdk13UG5iS0llUDJiWm5ET3luM1VQMWYz?=
 =?utf-8?B?a0VWTi8zZUZ0VERIQmdBMlY5NjcyakVtN1JxRHhoallTMnZBbHErdWM3NElC?=
 =?utf-8?B?RlZrT2FyeDE2QUdYRmRYMWYrU0tCc3czRkRPVWl4aHJ1aDNHakoyWDArQnBv?=
 =?utf-8?B?eVpkeGlyTEdIZUhleCtMWEVpZkNTTUVjNGE1OWxwQmd4YTNmMzMrbHM2a0N4?=
 =?utf-8?B?WmRYK2RNc3VpaU1Qa1pxNHE2bUVxY3dRbGhSVGR6dG5QY1NaV3lpNG5qRHhN?=
 =?utf-8?B?NU1xU3IwQ3NEM2xpSlpoQm1pOWtiUXQyZjREdlpvbXp3cWxlV3gzejZLR0Yy?=
 =?utf-8?B?c2pZbjluTzlIRzFxcHJ1Zm9vVEVKeUFOSEZCMzJIdGs1bnhPUEE4VndRemk1?=
 =?utf-8?B?elZBeG52eENqeDlMclp4dnEybThQSVV2ei9wbjFuSUQ3R2IrTzlmL3V5a2pJ?=
 =?utf-8?B?WGR5TU5VT2lhWlphMCtUN2RBcFFtNDdHVDF4U3MrZ0hBTnl1eXJkTXlsZXho?=
 =?utf-8?B?aGJEYk1Lcmt5L1VYQlk5NEt2cFlTc1NJWDdhL1lMUkxNRi9MMUhCVzhuVmJo?=
 =?utf-8?B?WGY5S3hXc0NoeTdCR3JBS2JoMzJxV1ZYV1NDRUJ1eE9vVzRwc1NrbTNrTXJF?=
 =?utf-8?B?SDhkMDdxV3NvcHlKcmhLZE5iVGd4akJkdy8vRGQ5cGFWNWhuS3VSQUlIWWhq?=
 =?utf-8?B?eUhhUkhSMGFLT3llNG9KR3c0WWl6NDc3aU9yK2NIWElOZUtmODFUQnQ0WCs5?=
 =?utf-8?B?Zm96QUFOYUdEWUYrWnFBdW5xZWM4NzJnWG9JRlFadUczVFk0Z3Nrc2daZmZk?=
 =?utf-8?B?Z0VWMXFQSGQwUENaNDhtZ0kyNGR4a2dsM0pOQ003V211UUFYUlNrUU1FUW8y?=
 =?utf-8?B?TS9zVk5DbHhORHBOYUhkaTFSZHJMZzd2bFlTZWRJalJMcEp1SGNKdjRDaDVL?=
 =?utf-8?B?OGM1ZlRvL25pa1VhSGVaVlh0M1JWZWRUSEJ2b1FvVTEzY3Fpek5lMkpqU3J2?=
 =?utf-8?B?R21rbkdpMWVyZWNkcUVYUnhVaWx0ZVhnMk96d1dnaFFTaUd3ZngzdVlweFV4?=
 =?utf-8?B?QnB1NTBvV2JjM0JtT2Y4L05JNHAzSU9JU3ZvbWhZSFJHallzdFVCN0xCc1dr?=
 =?utf-8?B?L2Q0Mk5zaldpd1dRdkNQVllIMzJqdVlsdzJVU2JkWjhpWmR4WVB3RTFydEJY?=
 =?utf-8?B?ajJOM2FQTndhQlBDSVRSMFMwaEFJbVRCL0RGeGlJMzJJeU9zRTNjc0JyWnFv?=
 =?utf-8?B?aFpEelFTb1JBYlhSMVpTLzRSYVVRd2xyZlcvWjNZOUxoNEtHSk1sM2xOYkpY?=
 =?utf-8?B?ZFlERVlGQjFaZEUrWU94NGZHTVVyaEp1L0hCZTVzWTNtakQvYnp2RXl0K09J?=
 =?utf-8?B?TWZWME5OMGJRUG5qdHBwejlOQTZNYXF4VkEzQlVQdTVKK0JaOTJ3ZHhaczds?=
 =?utf-8?B?S2ZhK2JXNGNsME1jUGRBMGtjUTFodFZkNHltTGJnc1VZeG04dlRpdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff50021-2a65-4ce0-0db9-08de7292867f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 04:17:58.3819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SK0SfvnfRlDnsuXXWmuwYHzZAtzLaHCIpiZygV5wtIPZwaJ9S/Smdl5IiKNF03Ttx3yB6UbRF+3MlrTLaUc+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290


On 18/02/26 3:33 am, Frank Li wrote:
> On Tue, Feb 17, 2026 at 10:27:10PM +0100, Niklas Cassel wrote:
>> Add a pci_epc_bar_type BAR_64BIT_UPPER to more clearly differentiate
> s/BAR_64BIT_UPPER/BAR_DISABLED/
>
>> BAR_DISABLED from BAR_RESERVED.
> from BAR_RESERVED.
>
>> This BAR type will only be used for a BAR that the EPC driver should
>> disable. (Unlike a BAR_RESERVED, which is still enabled.)
> confused. it looks, "this bar type will be never used by EPC drivers"
>
> Frank
>
>> Co-developed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
Tested by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
with the comment fixes
Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>   drivers/pci/endpoint/pci-epc-core.c |  5 +++--
>>   include/linux/pci-epc.h             | 12 ++++++++++--
>>   2 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index 8de321e1c342..5045e22367cf 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -103,9 +103,10 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
>>   		bar++;
>>
>>   	for (i = bar; i < PCI_STD_NUM_BARS; i++) {
>> -		/* If the BAR is not reserved, return it. */
>> +		/* If the BAR is not reserved or disabled, return it. */
>>   		if (epc_features->bar[i].type != BAR_RESERVED &&
>> -		    epc_features->bar[i].type != BAR_64BIT_UPPER)
>> +		    epc_features->bar[i].type != BAR_64BIT_UPPER &&
>> +		    epc_features->bar[i].type != BAR_DISABLED)
>>   			return i;
>>   	}
>>
>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>> index f7f48f43d370..8687b9c3462b 100644
>> --- a/include/linux/pci-epc.h
>> +++ b/include/linux/pci-epc.h
>> @@ -191,7 +191,14 @@ struct pci_epc {
>>    * @BAR_RESIZABLE: The BAR implements the PCI-SIG Resizable BAR Capability.
>>    *		   NOTE: An EPC driver can currently only set a single supported
>>    *		   size.
>> - * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
>> + * @BAR_RESERVED: Used for HW-backed BARs (e.g. MSI-X table, DMA regs). The BAR
>> + *		  should not be disabled an EPC driver. The BAR should not be

should not be disabled by an EPC driver. The BAR should not be
>> + *		  reprogrammed by an EPF driver. An EPF driver is allowed to
>> + *		  disable the BAR if absolutely necessary. (However, right now
>> + *		  there is no EPC operation to disable a BAR that has not been
>> + *		  programmed using pci_epc_set_bar().)
>> + * @BAR_DISABLED: The BAR should be disabled by an EPC driver. The BAR will be
>> + *		  unavailable to an EPF driver.
>>    * @BAR_64BIT_UPPER: Should only be set on a BAR if the preceding BAR is marked
>>    *		     as only_64bit.
>>    */
>> @@ -200,6 +207,7 @@ enum pci_epc_bar_type {
>>   	BAR_FIXED,
>>   	BAR_RESIZABLE,
>>   	BAR_RESERVED,
>> +	BAR_DISABLED,
>>   	BAR_64BIT_UPPER,
>>   };
>>
>> @@ -238,7 +246,7 @@ struct pci_epc_bar_rsvd_region {
>>    *
>>    *		only_64bit should not be set on a BAR of type BAR_RESERVED.
>>    *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
>> - *		touch, then both BARx and BARx+1 must be set to type
>> + *		reprogram, then both BARx and BARx+1 must be set to type
>>    *		BAR_RESERVED.)
>>    * @nr_rsvd_regions: number of fixed subregions described for BAR_RESERVED
>>    * @rsvd_regions: fixed subregions behind BAR_RESERVED
>> --
>> 2.53.0
>>
