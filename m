Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE8319615;
	Wed,  4 Feb 2026 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225126; cv=fail; b=XUP9CjGWHelgLDZDyDcIoElClvCLD/sa6DD4ke6x8kF2IzXpvXQLKHIuJvGo1Qc0yEWGvMOpN2SYhUSwFDvXmB8k12Dj50IF6xWONu/Yuli4OFGd7I+rjlBZnmycetT45Ku3fW224/zX/YLsN3ucy2t7ZKGNMMQY+OJnXjNiCqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225126; c=relaxed/simple;
	bh=Orn1prjYWJkVxBUXjbekzPgWVleT9PaBssTj0vqfnNI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cy0euVr7FfqySj+/XWZMMdBPPCNaGD/Q6HHL3l7B7YboeMmAdhisxbWGfg69NQHTqn0Pz+Bd1Nvoi2Tb6UK6hesRc+VXvJb9K3kCbsU7SSxXhiSfcMhp0YTEwiIKRcgTDXNyWoxLFZYb8TbUbj0tdusmhok4veggBCt1Xzmd/SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dYNtDShq; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dYNtDShq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlsF+BeTM/NqIQcHuvhTmflG7KDl6KmuIpDixRsnAJl4Go1wbOrH7F3/VBHw1/IdB9/AE9Lfy2mQOByfdwrLByomn+W4I23blqdLpAkkIx+sh6I39/GeJzMQoG88/5uaRqUf9Ll2xYhHbr3/MWFixtFIUR3AYfuzROpShy8H5TOHYwYVlr2jdL8bA8GDRYuLCzC17sLFDkJWkHXW8rDIhaJDD4cdlcvZ98jIwQH8sOxjntxN7ZPmYjTVbJ6jnj3HLLJq7JMeueIATKevvcNBt2ruufFhJYmTEVRNWlDeeDjacMtLuvtTPNSFrnnZT/HSoqkCxjsRirs6RQiyHuVvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOVZ/2vTLaZIZajbMO+a3mgS3iCRkGCXxbwXCV+eK9I=;
 b=R3UaI68qTWBWZ9NXAp1Vj7sIeVIRfgdcYuo3+PXdxARZsWoe38/Nx/qkhb6HphZuEapJV8Cp3fPJbcdAbbLuJMpxti+KsZEQPcEeffk+7O5lwxWuewqdNgLbeqY+sQ7ZHOuzMh+9uzbhsRebREie9rZo7ghc2Z9YqbVfbqABbF4O5eUfuHvOTITyQSdRMqeJ7TNnrErUDW2Zw8+cqLlQhe0+HaYl3pTyS4qIk/VhQoghA0GVgA0iUFTMcV7elmmB47mEoU4nGj8QEr/cQAZMig97iC919Vs/kw6Ikorvp9IEskR8sAIeD30nt5Eg/Y7Z1ZYqf/+EvGqIvMIIiXvTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOVZ/2vTLaZIZajbMO+a3mgS3iCRkGCXxbwXCV+eK9I=;
 b=dYNtDShq2ejEwsVRvZnLnzJ9TyiUsPJa+S02vN8noLf6h/5oXoh7L+fwzT27AG9Jy9rRY+MxHbFn7tRg3gncN4rAPf8212FhmWf8O2nMFL4VOgRqBX2bOBuaEFLLCQzFncqxmQkxTOhJXHT0EaY9MxBhHPy15u3s/WmQ73tIlV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 17:12:02 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 17:12:02 +0000
Message-ID: <e6de891c-e1e0-40de-978b-15f60acea92d@amd.com>
Date: Wed, 4 Feb 2026 11:11:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] PCI: Establish common CXL Port protocol error
 flow
To: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260203025244.3093805-1-terry.bowman@amd.com>
 <20260203025244.3093805-6-terry.bowman@amd.com>
 <6982d468e42eb_55fa1002b@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6982d468e42eb_55fa1002b@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:806:27::34) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: f2af948e-a0a5-4750-f79a-08de64108392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmpQRFgyRXA3Qi9KbXFIWjFxalNEOW5JczJ1NXhGVTJTSkhWS2p3ZlNtU2tX?=
 =?utf-8?B?VVhwNDNQK1U5U01Qb3BScVU4R2hZcjliZTNydUpqRWRpa0tRUnREenQ2WVRo?=
 =?utf-8?B?cm9zTEtXQnlKS2RIVldOdEo3dTdDcURzR3RYRzVsTDlxbUNDZjJJYUM4NWVZ?=
 =?utf-8?B?RWdOeldlais4OXNhNEo1YWRxaWZ2WHBKNWU2ZzRuUjE1UGJYL3ZqOStyNkFw?=
 =?utf-8?B?QjdHZE1GZnNQcUVHbmZMb3MwZkhYVERqK2dsTktDZWxWcDJCLzM3ZDdYRWlJ?=
 =?utf-8?B?dXFUN0hKa1AzajZiNUJrcUhtYUtjL2NEY3JQeWhKZkswNFIzZmw0WmdqTm5i?=
 =?utf-8?B?SVpmWTUrYnBXS2F1NXo4RVZtbzcxVHdoWlBWY29ybS9uZHVkSUlKb1hhRHly?=
 =?utf-8?B?TXhSK3h0MEt6aTFwZVFLcUtDSmZmR2Q1bkRhU0hqUVY2ek9GL3grdWR6Nnh2?=
 =?utf-8?B?c1ZnT3Jld1hValJ2MmtFb0pDVS8zMVlxTUpDR1hmVVIyT1h1RXRzTW56NTVs?=
 =?utf-8?B?bXo5L052R0hDMmdBOWNWR29za3BPVDRuMXNPajgvWEc5Z2tpVVRYa3ZZTWNz?=
 =?utf-8?B?VWVlVHZTMmNnYUhQQTUvTG5rbTA3ZndycDJKcUFOMWZVM0JFRTdTU1F2Q0d6?=
 =?utf-8?B?V3FBUzhnUHZreWltQnU5bWNLSGNrOE5GTTdFU0pqaWlCZDJLcXE5cEQxanlj?=
 =?utf-8?B?KzdleFhXRWQzamRUTzB3dWFhY1Q4dmxGTVFvR3lMZTlkSkxtOWNpaHJaWjVY?=
 =?utf-8?B?bnpkVGFSc2dtVFRtOURIV2lLaVZwa000SG1lSDZDcHArcmg3RStBeThJcWRy?=
 =?utf-8?B?NnRrdCtNYi90UmpjMm56dHhBbWZITUtGMHE3cUhDMHpGWGhFcUJUaU9lQmdD?=
 =?utf-8?B?WnY4VXUwcHZPVDBrNENwRzA3b21GS2VaNjdpdUFuemUxV00wUHRGRVBMYll3?=
 =?utf-8?B?RE4ycS9zTWtWUVd3OWRGQ1VIcGpEMVdrc3FlV2w0bFhJTXlXK3F4YlFDZGti?=
 =?utf-8?B?UFBpc2hSNmN4TmErYVJEMXoyazBGNkcrVWV0cnVpSWdlRUFZRnRzd0p5ODRF?=
 =?utf-8?B?U3N0cFp3WnZxQmZ1UnV2TEZLUTNFbTk2eER0MnFpMXU2dk9lUTdBZFY4MEsy?=
 =?utf-8?B?Snlnd1NjV0ZsYndnRWkyeFFSVERMTDkrUnhBQzBOK3JPOGQ3UDBHbHM0ekQv?=
 =?utf-8?B?bUpkaDBUTDZONi80eTR0eldZNC9udjMvZ0JEM3VHUjJOUUFKQy90TmxhMS9U?=
 =?utf-8?B?RnJyQTB0eEJiOWlLcjZRUFA4SVA3eU1EVkE0ZnVHRng1U3gvbXpjOXBCM3E1?=
 =?utf-8?B?dHFSaVVhbW9Id0JxL05LNVhIaVdlb0tKYTBEUDdIa2ZuUGZqV1F6VUlueGtJ?=
 =?utf-8?B?cGNVM2lJNHdVV2ovcEJHWi9HUDBKWXFJWWlWYU5jQXZRTngrQ0FYUlZqbVNs?=
 =?utf-8?B?R3p1Yk1vdVVTZUM0V2lZcG9WZldFWnBHS3hLcUY2dmg4VkVvTFMwYVpFdDlw?=
 =?utf-8?B?OGtWVVNKY0lNTERqK3htcjBtcEp5aXlKalByanpaQWgyVnR4c05VZUxXUWdX?=
 =?utf-8?B?RHEvNlBRKzFTMHcxRTJRaUViVllMTG1LUjNzNjRFMXlkSVBsQk15cEJZNHh2?=
 =?utf-8?B?Sm9NbEJDckhtTU43aWxCOCtNa2poVkovUXVGRWlGanVmVzB1OGQydy9kaW03?=
 =?utf-8?B?YlYvK0VJMDc5bkd4QytSekxmaGloQUFGMi9sczZVanZJaTloSmt0ajI2RVJL?=
 =?utf-8?B?RnVIb1NybjYxT0UyaXpzWlE2ck5ITUU5bUQyY0ZPd0tTc1NmbkNSSHlTa1dP?=
 =?utf-8?B?SVJ2aHZNYXpvYXljdjVFOFoxL3ZpQWxtbGZUbEt0VTBUNUJhWnJxczZ6aFRO?=
 =?utf-8?B?U1YzRFpXOGlkbjlRWVlNWTRwUmlYRXFvQ1VwdVI4T2tYRzVRR0ZMMkpWR3U0?=
 =?utf-8?B?b01RZ2pFeHZYbGo5cHlqbGxySFN3S0FHSTYxeG00NnZId2RhSy9TQWlIaGhU?=
 =?utf-8?B?cXJ4enJiNEdFUURWYU12SVpOdFExNVBTR2tESGRiVllxU1NmY1VBM3FLdlF3?=
 =?utf-8?B?d3ozY1lEZlp3Q2lHNldlM2JjR05VUW4xTGhjM1lkVWZ6aWhiK3hvaG1ObnJB?=
 =?utf-8?B?bUhLa3FHaW1VdXRCNHBjU0dXejg4WUV0RFk0aVphZ0FiR2l1M3d2VEFrTHRO?=
 =?utf-8?B?U3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzU1M0d5UDFmemQ1eEMvcFZGS1ZvSEtEWFZaaDlteit4R2F3SFg0dTFRWjRB?=
 =?utf-8?B?enpJOHZVOFgxWFpvZ0xTYVN0enNzS3d5bVJMaUFhVUp5QncyOHNlU3VrYS9o?=
 =?utf-8?B?MDlCcUIrdW9BdDJyZmVKMmxzeGdQNnhYSGFDMExIMUlBcDhBQnhRUXpBOWNp?=
 =?utf-8?B?cGszNWRmVlVqL3U4YlFSNFI4Z0d6Z2ZSTS9NVFM2WU44SmVVUnhqOXc0SWkx?=
 =?utf-8?B?aEZlcllxL3RnbjhlellRTzJsYXYvZ0JhSUVrZkU2RVhWdVdvS2xJYnV4ak1M?=
 =?utf-8?B?UHBPWUdRL1ZRTWczbGxualBUSzhtRFVCaDdQNllDaHM2SU9PM05pY3o3YStu?=
 =?utf-8?B?RW5KQXpMVkZQR0F4VTgzS0tobGhKSm1kZllMMUFqbDBxYVRUZXZrNnZLeTlk?=
 =?utf-8?B?SFlLT3daWGdzeVdiVitFZEpXZU04VzBiVmtkTWNJemlMY1JCZ01EK2hjNDVY?=
 =?utf-8?B?S29yYXlxbnpLWGNOczdOcDYyRnM2OExROW1JbEJsSmE4T3Z3WVIrak9YWlhQ?=
 =?utf-8?B?cGdqb1F3a25vdURYSXVSWTNUYTI5d2x5RW1abDRoZnFxbWZ5MmI3Vm9DbHNE?=
 =?utf-8?B?aVdWSFBPMmtBZFNPczRTRHZPTWM5VlFLRk1aNFVIWDhUYXNrQWVnc3RyQVBv?=
 =?utf-8?B?d1lMeHRqdUJUTlNuWm12SXAzY2w3QmQ4Z0hkcktnM1Z4MDJDcGl1aXVWSkVH?=
 =?utf-8?B?VHRTOCs0V09wVFlYTDR6b1R0RC9aU0hsZ2NGTkJPd2s1Um9OTVJ1UkdYbFZh?=
 =?utf-8?B?ZFdqbSs2RkFXeFRzNHV1YUt0R0NBNngxcnFYV3E0bEVoeS9oU2tLNEpUaDNx?=
 =?utf-8?B?a2dYRkdpZ1V4UDRzN1BMM2YxdUhXUy9zeFlnSGxFSzBGTmYyeGRSdWczTnBT?=
 =?utf-8?B?eExrRUFFcGRrWDBKR2RpMTY1VEYvaWJEMW9zNVh4NGNRUk8xSTlDNGFQQ1dX?=
 =?utf-8?B?cjRiLzIvQkRiMVlrQXN5ZGI3WHArQWRRNzgzYkhSY0R3dlVleStraFZLWlpV?=
 =?utf-8?B?dXFZMjErL0RoajJnTnhES2cralIwVUJtRnhQSWJhY1JVWE5ENEV4Yzl1bHp0?=
 =?utf-8?B?czlCNUlJNmpuQk91WnRkaStkalM1QzhzSFVWdmgza2hiOHpEcFpORFR0NC9w?=
 =?utf-8?B?c1llMnhTczFQNVl1TWxoclp6RlQzczJqY3g5bGM2MzVzMWI4a2kzaVNkR1hw?=
 =?utf-8?B?UW1kSUZYRnZoY0oyV3QzV1RwdlZ0RkJTUHpCTWRPdS8rSXk3dmVwRTVhdWRF?=
 =?utf-8?B?UGlaRUsycGlIL2g2UnVhaC9zSTdxb0ZaZXhld0V1R0szYTFKa0VyOTBQbEU4?=
 =?utf-8?B?RmpmTE5Ndm4yNzJBUE5vRWh4NmMxelpiU2grWTVOaDR4aUsvZ3pDVk1HaVFM?=
 =?utf-8?B?UHgyL0E1SkVPZjhnRG5lUFluQjZZaXpLUjdqM3ByVE5MbGtzdkFhcVowaHBV?=
 =?utf-8?B?azZqQlV0S2x3dHRWOWRuWG1xRlhaVnNqRVlCZTlZbDg1ZzR1N1F4bHNQZmtw?=
 =?utf-8?B?MjdCUmYyZE5hazlMTGVDSnJVeUZTcXR6eENrb2xHWUZIZkVPWStneXVqUWxj?=
 =?utf-8?B?OSt1ZVN1UVA3L0E5eFVTbUNyUitHcGhIWkhMcEpuR21VOHJ5QTdlRXZoNVp1?=
 =?utf-8?B?Z1ErTXJqYWUyRCtlSi95TWdqNUJSN01MK2kxdjA0RlBNcHhqa21KWXR5L1Ez?=
 =?utf-8?B?V2R4K3o2S08xeWl3SFJsZXNCQmJjbmU4U05ra3lKOU5NcExObnFCOVVaOTZm?=
 =?utf-8?B?VmlVVDlBRUNoTzNDNVc2Y1hscURjcXdpOCtnR1BnOVdVeThQWWxrb2pzVjl4?=
 =?utf-8?B?bG82SkluVUFIV1hXdjJUdUQ2ek51ZXpWazZlRWwyMERzcW81aE43SCs2bEJy?=
 =?utf-8?B?WW1rWUszYTM0bStBemx6a0ZZU2hqVmdOUmFScVJLcnFzOWs3cEp6dHp2NU92?=
 =?utf-8?B?OEw5WkxSMmdjcnZKTFUvR3VjRlM4a3FQUUtyckJVMU0wU281ZHpGVmJUSzRH?=
 =?utf-8?B?eDNEcWphYWUrVWdQRitCbHdya0tiWkZyTEoyZVd3MzNJbDlWdXE5UE1rY1Y2?=
 =?utf-8?B?WnZMR3FUM05QOWhZcnpSTEd5WXpYb0dXby9NQjhBYjRMSENLNmdiUWxNZnVs?=
 =?utf-8?B?M0ZnMU1pZ25xS0VpdHllYlhMV3QwcTZhcUxjWkpBa2lXY252OXVnNkxEaUQ5?=
 =?utf-8?B?RXhmdEQzenJ5a3djaXRoSVNjNGl2WlhEaTJtaC9aMnptb2taajIzN1VOOUdi?=
 =?utf-8?B?U3VUZHFwRXlPVkdPN1hSR1ZnSFJLS3o0TnVLUk82VmhsZWEzVWtwYkRXYzVH?=
 =?utf-8?B?aUF4cnhRUkdBTytMcGF2YzRtWGM1MFgrKzJGNFVhcW1WWjRSekVrdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2af948e-a0a5-4750-f79a-08de64108392
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:12:02.4415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMRIDAs9Gabr2gIzb2OYvZ4cyl9UL6cO7COzwIWspd5qZUW4gb0A6Cxnu+oRqh1gBuCHypM168P6GTejpdEmIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923

On 2/3/2026 11:08 PM, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
>> Introduce CXL Port protocol error handling callbacks to unify detection,
>> logging, and recovery across CXL Ports and Endpoints, including RCH
>> downstream ports. Establish a consistent flow for correctable and
>> uncorrectable CXL protocol errors.
>>
>> Provide the solution by adding cxl_port_cor_error_detected() and
>> cxl_port_error_detected() to handle correctable and uncorrectable handling
>> through CXL RAS helpers, coordinating uncorrectable recovery in
>> cxl_do_recovery(), and panicking when the handler returns PCI_ERS_RESULT_PANIC
>> to preserve fatal cachemem behavior. Gate endpoint handling on the endpoint
>> driver being bound to avoid processing errors on disabled devices.
>>
>> Centralize the RAS base lookup in cxl_get_ras_base(), selecting the
>> downstream-port dport->regs.ras for Root/Downstream Ports and port->regs.ras
>> for Upstream Ports/Endpoints.
>>
>> Export pcie_clear_device_status() and pci_aer_clear_fatal_status() to enable
>> cxl_core to clear PCIe/AER state in these flows.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Dave Jiang dave.jiang@intel.com
>>
>> ---
>>
>> Changes in v14->v15:
>> - Update commit message and title. Added Bjorn's ack.
>> - Move CE and UCE handling logic here
>>
>> Changes in v13->v14:
>> - Add Dave Jiang's review-by
>> - Update commit message & headline (Bjorn)
>> - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
>>   one line (Jonathan)
>> - Remove cxl_walk_port() (Dan)
>> - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
>>   sufficient (Dan)
>> - Remove device_lock_if()
>> - Combined CE and UCE here (Terry)
>>
>> Changes in v12->v13:
>> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>>   patch (Terry)
>> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
>> - Remove check for dport->dport_dev (Dave)
>> - Remove whitespace (Terry)
>>
>> Changes in v11->v12:
>> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>>   pci_to_cxl_dev()
>> - Change cxl_error_detected() -> cxl_cor_error_detected()
>> - Remove NULL variable assignments
>> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>>   port searches.
>>
>> Changes in v10->v11:
>> - None
>> ---
>>  drivers/cxl/core/ras.c | 134 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/pci.c      |   1 +
>>  drivers/pci/pci.h      |   2 -
>>  drivers/pci/pcie/aer.c |   1 +
>>  include/linux/aer.h    |   2 +
>>  include/linux/pci.h    |   2 +
>>  6 files changed, 140 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index a6c0bc6d7203..0216dafa6118 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -218,6 +218,68 @@ static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
>>  	return NULL;
>>  }
>>  
>> +static void __iomem *cxl_get_ras_base(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +	switch (pci_pcie_type(pdev)) {
>> +	case PCI_EXP_TYPE_ROOT_PORT:
>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>> +	{
> 
> Nit, clang-format puts that { on the same line because coding style says
> only functions get newlines for open brackets.
> 

Hi Dan,

Thanks for the note. Would you like every switch-case to be upodated to match the clang 
recommended format?

>> +		struct cxl_dport *dport;
>> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
>> +
>> +		if (!dport) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +		return dport->regs.ras;
>> +	}
>> +	case PCI_EXP_TYPE_UPSTREAM:
>> +	case PCI_EXP_TYPE_ENDPOINT:
>> +	{
>> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
>> +
>> +		if (!port) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +		return port->regs.ras;
>> +	}
>> +	}
>> +	dev_warn_once(dev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
>> +	return NULL;
>> +}
>> +
>> +static pci_ers_result_t cxl_port_error_detected(struct device *dev);
>> +
>> +static void cxl_do_recovery(struct pci_dev *pdev)
>> +{
>> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
>> +	pci_ers_result_t status;
>> +
>> +	if (!port) {
>> +		pci_err(pdev, "Failed to find the CXL device\n");
>> +		return;
>> +	}
>> +
>> +	status = cxl_port_error_detected(&pdev->dev);
>> +	if (status == PCI_ERS_RESULT_PANIC)
>> +		panic("CXL cachemem error.");
>> +
>> +	/*
>> +	 * If we have native control of AER, clear error status in the device
>> +	 * that detected the error.  If the platform retained control of AER,
>> +	 * it is responsible for clearing this status.  In that case, the
>> +	 * signaling device may not even be visible to the OS.
>> +	 */
> 
> This comment feels more appropriate as documentation for
> pcie_aer_is_native(). CXL is just using for the same purpose as all the
> other callers. You can maybe reference "See pcie_aer_is_native() for
> expecations on clearing errors", but I otherwise would not expect CXL to
> carry its own paragraph.
> 

Agreed. I’ll drop the local comment and rely on pcie_aer_is_native() semantics,
with a brief reference if needed.


>> +	if (pcie_aer_is_native(pdev)) {
>> +		pcie_clear_device_status(pdev);
>> +		pci_aer_clear_nonfatal_status(pdev);
>> +		pci_aer_clear_fatal_status(pdev);
>> +	}
>> +}
>> +
>>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  {
>>  	void __iomem *addr;
>> @@ -288,6 +350,60 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  	return true;
>>  }
>>  
>> +static void cxl_port_cor_error_detected(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
>> +
>> +	if (is_cxl_endpoint(port)) {
>> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +
>> +		guard(device)(&cxlmd->dev);
>> +
>> +		if (!dev->driver) {
>> +			dev_warn(&pdev->dev,
>> +				 "%s: memdev disabled, abort error handling\n",
>> +				 dev_name(dev));
>> +			return;
>> +		}
>> +
>> +		if (cxlds->rcd)
>> +			cxl_handle_rdport_errors(cxlds);
> 
> Isn't this dead code? Only VH topologies will ever get a forwarded CXL
> error, right? I realize it gets deleted in a future patch, but then why
> leave dead code in the git history?
> 
                            
Yes, agreed - I'll remove. Correct, only VH is forwarded. My understanding is the 
cxl_memdev guard and driver check are no longer required here. The memdev is only 
used to source the serial number, so I’ll refactor accordingly. Please correct
me if Im wrong.

I see an additional fix needed: cxl_rch_handle_error_iter() in pci/pcie/aer.c
also needs its callbacks updated. The RCH/RCD path previously invoked the EP
PCIe handlers, but with RAS now handled at the port level, those callbacks no
longer reach the correct logic.

I had a coupled ideas. One options is for the CXL logic to make a callback into a 
cxl_core exported function such as cxl_handle_rdport_errors(). BTW, the CXL logic in 
AER and the CXL driver's RAS are both built with the CONFIG_CXL_RAS config.

Another option is updating the CXL PCIe callbacks. The cxl_pci PCI error callbacks 
currently support only AER and could be updated to also support RCH/RCD (no VH) with 
something along the lines of below?

static bool cxl_pci_detected(struct pci_dev *pdev)                                                                                                      
{                                                                                                                                                     
 ...
     if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC &&
            is_aer_internal_error(info))
		cxl_handle_rdport_errors();

In this case we would also need a cxl_pci_cor_detected(). 


>> +
>> +		cxl_handle_cor_ras(dev, cxlds->serial, cxl_get_ras_base(dev));
>> +	} else {
>> +		cxl_handle_cor_ras(dev, 0, cxl_get_ras_base(dev));
>> +	}
>> +}
>> +
>> +static pci_ers_result_t cxl_port_error_detected(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
>> +
>> +	if (is_cxl_endpoint(port)) {
>> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +
>> +		guard(device)(&cxlmd->dev);
>> +
>> +		if (!dev->driver) {
>> +			dev_warn(&pdev->dev,
>> +				 "%s: memdev disabled, abort error handling\n",
>> +				 dev_name(dev));
>> +			return PCI_ERS_RESULT_NONE;
>> +		}
>> +
>> +		if (cxlds->rcd)
>> +			cxl_handle_rdport_errors(cxlds);
>> +
>> +		return cxl_handle_ras(dev, cxlds->serial, cxl_get_ras_base(dev));
>> +	} else {
>> +		return cxl_handle_ras(dev, 0, cxl_get_ras_base(dev));
>> +	}
>> +}
>> +
>>  void cxl_cor_error_detected(struct pci_dev *pdev)
>>  {
>>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> @@ -363,6 +479,24 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>>  
>>  static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
>>  {
>> +	struct pci_dev *pdev = err_info->pdev;
>> +
>> +	if (err_info->severity == AER_CORRECTABLE) {
>> +
>> +		if (!pcie_aer_is_native(pdev))
>> +			return;
>> +
>> +		if (pdev->aer_cap)
>> +			pci_clear_and_set_config_dword(pdev,
>> +						       pdev->aer_cap + PCI_ERR_COR_STATUS,
>> +						       0, PCI_ERR_COR_INTERNAL);
>> +
>> +		cxl_port_cor_error_detected(&pdev->dev);
>> +
>> +		pcie_clear_device_status(pdev);
>> +	} else {
>> +		cxl_do_recovery(pdev);
>> +	}
>>  }
>>  
>>  static void cxl_proto_err_work_fn(struct work_struct *work)
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 13dbb405dc31..b7bfefdaf990 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2248,6 +2248,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>>  }
>> +EXPORT_SYMBOL_GPL(pcie_clear_device_status);
> 
> No reason to open up this symbol to the world. Only cxl_core.ko needs
> this exported, and hopefully we never see another bus that abuses PCI
> like CXL does ever again.
> 
> [..]

Understood. I’ll switch this to a CXL‑scoped export.

>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 7af10a74da34..4fc9de4c78f8 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -298,6 +298,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>>  	if (status)
>>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>>  }
>> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
> 
> ditto, too wide of an export.
OK

-Terry
