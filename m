Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794985761;
	b=FQ7ejipGop31XDxTrYd2lgvJ0cDRdPMETIKpay8cjP8U1E0DmLaEhbpQ9tza9izrd994
	 gcOdhCPKh2/ycvCnpSnWrus0BNCpBsDan4Dux9B1KthbyKD5ty37b3dd2tD8/3MgFqbKO
	 BZN0AF4Agl8j/3ajiulMbE46zfhQDWYIW0/I38sm155Y4ORwdKE6RuYY6gRIS4JOgP6Vg
	 7+AwupydX9tKO437mmZ/iMN9naPVSqQBhL2xRlEomniCzn7knDBmOLqKclwF7VMoZDvv2
	 pFd85IUjN+wpG2tXLY5kpJhNg1X/dH491NYVpQ4b9HIp10gMRK6CEZcIWQE37+ilLtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985761;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=FuGSYKm1Psl1WqdDEw5xSkaBkWGUAITFOLJFmGFywCc=;
	b=Oc0iwMgF3kB9z887EgBnhP6ai6cuDvVIMxWOyMcFwJBPUl8Xoz8FntDzfpsHiXVoSP2A
	 5ani2aISbetspa4IXINle+S6vR/2+ICEllPbWDh+Ufe9Ys5rPMYQaA+tkHNf3nM3C57hG
	 N3XFNBXEhbbCR3meDI6iMQV2e4O8vNGNXJaEARJBAH7U8tKoRx5ksJQwD6hCHP3zoWACF
	 tsYGMIEvTbvpgY8W5kxy6C97h78NGezzm4CgMwem8mlEkXYzKLwMYZtJp3GDway8yHGFR
	 tXCqXtciWslnAuPTTnzIUi3ETVovWc9D+oa4ckMSLqmlzYt/ThBTwzGsUwK289MNElQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eSFWv2ec;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=cKN+HBUT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2395606A333;
	Wed, 18 Nov 2026 07:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2395606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eSFWv2ec;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=cKN+HBUT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794985761; x=1826521761;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jwVd7zw2PQi7SdX+5GWqBWIbGFKF/6YuR/M17Rrk8k8=;
  b=eSFWv2eca0+RWgk/THW2NfJOoiJ+JGZwZ2w16RATihTlhS6IPEAuzqBZ
   /hLF+IkB3/Iq4c9b5jFwgjrxFTDhF5Aqkmpql+PxAY2XwT7KVsrOuC+wS
   jdJVTKAtA4FVufpoEVzi6m0BiRvtyigVV8hEwkzlt41++m/LCF46qzF9S
   YK+XHfW7GShsz6R4lid4udIUupbnYOXlSbZ2RLiB+VRQbEXULj/PbQj9v
   I952W6Xu+gJMWBHGB4/EKmSLolWob0Mglsp6UDiQEkAERfYqf9RIstLLa
   7kCrqRSlzISN67v2mn271y0I5vxZ/9NAXVeubS3pkyIJtmTpeRW2PIE2L
   A==;
X-CSE-ConnectionGUID: NHJ4qg8iS9CIgfYBvh7dZA==
X-CSE-MsgGUID: 77oJjoR6R9mnl1qxGxWudw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3808300"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3808300"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:09:20 -0800
X-CSE-ConnectionGUID: Uc2wL9pSSz6q1aLearV0jg==
X-CSE-MsgGUID: Hx6a/UbpTFOreEk8ozO/sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10450479"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 23:09:20 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 23:09:19 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 23:09:19 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 23:09:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHq8CBVEngFRjX/ykdaO82JhAaF8UZ4S7eB0LTqrs4Gn4stBc0Fbmf/scvFrv+gTvw0OQ1c/MUpnqY+Xxa3w2pq1eTDox5CgrWydBLKfagMwQIjY2Vsd1qSypJqVhPd1BFz/AZq3IEfjgheir2e0ROqXccP1iXENNfhn8iH+40bdKWpNXYPwLuAVetZ+3NcK6MN4O82iII80OwFXMgPKPSZid6Z2LLgt7bzI6FLAdMthE7VNkNlsy/G1NkmqZkbDnoa96Zp7b9y6J49CDSH8YEErWj+yIyED7L8hya1ECa5KZpDLbs3TPcF4U5DL2yKStwWoqjTIYrHodFVjCt/Y3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuGSYKm1Psl1WqdDEw5xSkaBkWGUAITFOLJFmGFywCc=;
 b=xiZW6mzaBSNq8H7R0jnJL2rQl0ampWeovi3zWvWCsL7j/4yrO8dDTOMUPUN/FUpA0Q3fERf/FAMgUcq+3CG/UtymD8djODWqG/OGm6UGormA0uKZoBUkh+RN1GPTDVcYBLje/frEhv07IrIqO8LDqLMxf1tLAEPvsqvr4OodaHjLyeSUS39GR8zWFNccg7cry6nz/+Mhejj3EeovYG9+kobWtzB5CgZFEYXySGQ08Qwb2yyeG0E1MiYSzIzHVdEryCnUwtCK20k4WW48kFG+dPdd2+28dNXszeAlqvytzNUbBmySyaM4FhcYfh292NAiN00jAdBkINrXkNsZnctQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuGSYKm1Psl1WqdDEw5xSkaBkWGUAITFOLJFmGFywCc=;
 b=cKN+HBUTIUKm6vwGQHZG0Y0yYG2+xTS3PjgnIxENp14NH0ZoKnytHOybHh5Ho0jJra5OkSu69ZCfpopTsPV4+6qvAiLHopnwIfWTJrFKVBrVz/dQazuq9ESsMOaD8AG9r6zoC2iFhDwpiPtbXY/NxHrZUSd8OUhr4eBblkQjeCY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by PH7PR11MB6675.namprd11.prod.outlook.com (2603:10b6:510:1ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 07:09:16 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 07:09:16 +0000
Message-ID: <a2284c4d-8c30-4d98-8886-9d9f90bb9b97@intel.com>
Date: Wed, 18 Nov 2026 09:09:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/2] igc: treat I226-LMvP as an I226 device
To: =?UTF-8?Q?Daniel_Via=C3=B1o?= <danividanivi@gmail.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20261111093035.513635-1-danividanivi@gmail.com>
 <20261111093035.513635-3-danividanivi@gmail.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20261111093035.513635-3-danividanivi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To SJ0PR11MB5630.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::6)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5630:EE_|PH7PR11MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 863e8d2a-a5f4-4418-a15c-08df4542db32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0Ru+zrUrsm9INQFyjyUHIK9BgvaAkG+SN2ebXghWDB5Sbb437sWEMfOJ6bJQcpDTXoC4xfAPiPXeb0CIhuZGFMe9J6VaQJqxiK/E1X3lMt0wMmY18l/9TCRRiKlXGgpPhzsw4DJPNKv24p8iCcZI4pbh9g+XcAWS3a5o5bMpmH6Hbs0jfY+C8Kan24zD31kJUeAmegJhVyEEV0VCVX4+HdB63yOpYXR3XgiMo5t7V53HQXKFAheixAwybjsfCz19QJL1q2lJI38qBiW8JB6tSR4Ca993Jcp2lmQecHWW6+Dl+ZtgX1j0ONq6rpZ9r1RpduIo9S0Qwgg/rHSOKO4W7WtU7nE6H+kh5t8u/3r/Bncbhv2lWJWEOdR1d3aAatg7n6UPXNSnA19dzkjzlifXdNVamOVuR1XiCZag5Df6UunuyXmByd/nlwM0HR+H3QLiZhtpIi81SkxdojiTYLXmLp9hzGuisgF+VoEBjXUEGIdS/LxhlM/gWlSiqgq7Eu599ihbJNVxk0jea9TN79eSBstYbCEHrwT8OTFAXhyRhmFLp36oQEVdkZ7ijjDdnPNBeUe6aXtoQXCowX/k1Sfw7IvIg0nK7NOUIPL79UcxZo4/j3x9ywalBseCSunYdOPI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5630.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmExNDNPWURyV256Y3hkMUFBRjk1T2VYYzF6R3JRR21PYlJ1cXc3MXBXeWFm?=
 =?utf-8?B?cVBaWWtCem1rSVBqT3o5VWlwak5vTVhxcGsraGdmVDY3b1FLN3k4R2FoejNL?=
 =?utf-8?B?NU1PbkljeVdvU0NnRSs2WXRBVXh0UkRWcElMb2VpcnJtQmIxODhrckNoNVFU?=
 =?utf-8?B?UndoUk5lZnp6dzFkRW9CcUJ3TXV5b2k0T3p0RzFBS2RMOTlHdCt2YWhrbzdY?=
 =?utf-8?B?SGc5SDNmYmFaZ3hET3JjL3NBbTBlUkFTZURTM3FhSUVZMUhZNkpEeHk1Mytw?=
 =?utf-8?B?TWkyYzUxZDBjOHl4bG5rTU1TcCtZVVBIWW9WRzFQekF6VVJiTmFuTnJjSVBI?=
 =?utf-8?B?TEp6aHRKWEZad0NXbnk1VHZkR2psZG8wL1JmeEJRbEZtZjQ3M25RVWY5dFk3?=
 =?utf-8?B?eDVIajM0ZUpwOStFMDE5UklWd0t0cTNOK2tpMEI3WGNiNDA4cENBSTd1RUtI?=
 =?utf-8?B?d25PZXpLL2k5TjRZaEpaNG5HejdJejBYYXNKQnB2TFlhaUR3SVVTT3pzeUtZ?=
 =?utf-8?B?UmczTHpJNUxIT0FRNTMxblBHRTJ2ZWk2Y0NGcUlGL0xhaEQyNTJxWlozeHVX?=
 =?utf-8?B?NGxEbm5yaG9wTHpwUE9Xbys5cjk2blRjSmsxRjJVblprcGxHcE02RFZ1Y2Rw?=
 =?utf-8?B?WCtsN3ZpWTdwUlp4bVdkYW4rNkNyVUwwbnBPcTJ5akpLZ2g4VFVyb3p1R3F0?=
 =?utf-8?B?OWhpMmYwNE9tdnEya3pZMEhyZHE1SWNYRW1zeSswQjMxRllEQ2M3RWY3aDRt?=
 =?utf-8?B?OFYyd29GMTRHdXNIMTNDajhnT1h1NDJaYzZDV09iQnM3YVg5WWFPZXlwS09u?=
 =?utf-8?B?dU5XN3BGYkU1ZzlRZ2ZndXRkV1krbW12ajZLWDBBRFdNQy80Vzl6dm9RaEUw?=
 =?utf-8?B?NmtibmJ4SmFKa05vZTFiYXd3QXJKN053QWNaQTBRaVlNeDNTS2I1Q1E5L1VQ?=
 =?utf-8?B?eHllMWJzNTNOYWN2RThIalpqMHhMS0RvZUxFcjV1d3Q4aXhNUVphMDNMeGRX?=
 =?utf-8?B?UmdUTGxqaXBmck1ReFFhQXpDQi9kK1VRWGwzbCs5cExvdG5YRUQzNG9xMFFy?=
 =?utf-8?B?akpTd2JrellUbUdjTXZ1Q3NNaW1ZZE03MURJK09DSkg4TEl3TThZbjRrQ0Ix?=
 =?utf-8?B?U2tKZnJscFhvLzU3clV1VHM1WmtDM3hvV3VaTW5KdDdweE5EelZRYUQwVGd0?=
 =?utf-8?B?Z1FxV3g2NjZYYjVVcEFEVGMxMDZvN3IraVEwZVlDc3lFYWtUSEVKQWpNZFV5?=
 =?utf-8?B?cDdpUTc2MjBjbjJKZjV4ZW9BOWtRVFRvb0pKTWdSWUdFaTdTcExKTzVaMmhu?=
 =?utf-8?B?N0NRVjR2N1FGUWFXdkJYR1J0angvYVVYVUN0WW92OTJiblNqZjFCeS8rTFU4?=
 =?utf-8?B?OFpoVVo2VTc0N2RmS0N4WTB3RG9yQkUxT1ZjbWxGSVpIMWl0VnFibE9vU1BX?=
 =?utf-8?B?cnZJTVJqa2tCak8xbTZiMnBzakNmejM2WTJwNUpZaDhVUFFtMmJySUdMMVZo?=
 =?utf-8?B?bndVdzYva2hZTlIwT2dQU3hXdUJ2ZUowMGQ4UHZvcXNjV3NhUzN1bTZXalY1?=
 =?utf-8?B?MDRqc1BZOHJINml3M0IxM3pWZDNUSXliYTkzWXNhSzlOVldmV3lsYnFXY3Mw?=
 =?utf-8?B?Ty9jTjB4V1pLQnM2cXNzd2xuMm55S244UzYzVFZ1c3NMV1I4cnhZMzRoVmFp?=
 =?utf-8?B?aHREKzdzMjI0WVNSUHg3TjhPVzc2S05mNGEwY1VJbDYxb3djVzMxV0RiR21l?=
 =?utf-8?B?NWVMdDlmU3NUMHNDTEJGZ0FndjJmT3lyZjBzYlFjRU9YdklPNXRQVHo2YVdJ?=
 =?utf-8?B?RW9mdHYwZUVVV3p6VDB0TmE5eDVLbitVdXkvVXpzT3M3cmE0V3hWK0tERGlJ?=
 =?utf-8?B?Y0Y3dmpkRnNRaGVmdyt5M280NDVodGl4bjBQSEo3NURrUDVEYUdxYUU0di83?=
 =?utf-8?B?S2JWWlZmSFVSbzRGdGRTZ0VaN0J4Q04rdkVKL3RURmVyNlptZnVTRHljZjFx?=
 =?utf-8?B?QzFtL3ZoWmcvUmRZdmF1L1F1a2VYTDJDTU9LT2tETFBHUlQ2czdGUEdLdDRa?=
 =?utf-8?B?NjViemV5aVduWW9ZMVowZmw0RVNaQ1BkdUJTcHE5RzBhMVpnVmRXd1lZQ0lN?=
 =?utf-8?B?VUZJYXIzL2lyQ3NFRkpBM0IrTkhzR2ZqeXo3RDVoOFVYaUZpVXRCaGJtVjg2?=
 =?utf-8?B?YWJyRmVDZWw2dU5zZTVZRDRyL1BMa25VVWRoYlpLMjRuMmhOOWI1WXR5VUVE?=
 =?utf-8?B?VXNkUjRYdnBwSVhTNkEveGVUVUIwellucXlGNW9YZVlNVjlQdWxIaVkwOEZ1?=
 =?utf-8?B?UmxwejhoTEdxY3Q2QTBMWG5RZzlrQ0tYNnF0TEZ3WExobE15Y09zZz09?=
X-Exchange-RoutingPolicyChecked: pouRMW25okF8GhmivxTeU++euZZSgh0f8ni+NnmG7VBu/zPVGJWrj7ycqwYcBmPQWfjAF5gBIHD5ptev/EYTzfuWZO+TfbjI1Tt8Y9RqHuQy09SPCMdmIRg10jtiCKNXcNlmpNgVRY0tXJ9GQ9HFnbzVN6HgPPwg1JHBz5vD1n0fc8AQmSHRyS9BQehShkulBs9Eo7Y9GHMOXbx4YAAiE//KkJr9RA8UKO4zeSqkYpJiOMPoQLWoJGH+jDEwbfb4TlAFtX7sjNE5yBqmaFAuiRuF5vZGxnWJkhZIqmDN7lj0Gl3DmZ0XHijQuOXY8Qp9WAwxxI8Oy6E5azi8es7rfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 863e8d2a-a5f4-4418-a15c-08df4542db32
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 07:09:16.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tLpM3tk9YAzTU6PY1RYovopn5m5OWUNjCX7oYNLh72TXJAkZ8AAq/XyLHn7IwDIuXHEVQiBgD/HKb9OrGbtww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6675
X-OriginatorOrg: intel.com

On 11/11/2026 11:30, Daniel Viaño wrote:
> The I226-LMvP device ID (0x5503) was added by commit 8f20571db527
> ("igc: Add new device ID"), but when commit b8897dc54e3b ("igc: remove
> I226 Qbv BaseTime restriction") introduced igc_is_device_id_i226(), it
> was left out. As a result I226-LMvP is currently treated as neither an
> I225 nor an I226 part.
> 
> Add IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226(). This changes the
> behaviour for I226-LMvP in the following places, all of which now
> match the other I226 parts:
> 
>   - igc_probe() and igc_io_slot_reset() disable ASPM L1.2, as done for
>     I226 since commit 0325143b59c6 ("igc: disable L1.2 PCI-E link
>     substate to avoid performance issue").
>   - igc_tsn_enable_offload() and igc_tsn_disable_offload() set and
>     restore the I226-specific RETX (Qbv full) thresholds.
>   - igc_tsn_enable_offload() handles the FutScdDis bit and the base
>     time as on I226.
> 
> Intel confirmed that the I226 TSN functionality introduced by commit
> b8897dc54e3b also applies to I226-LMvP.
> 
> Fixes: b8897dc54e3b ("igc: remove I226 Qbv BaseTime restriction")
> Link: https://lore.kernel.org/all/5d45a583-198c-467d-afbe-8f19398e82f3@intel.com/
> Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_base.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
> index ab9120a31..6865fef40 100644
> --- a/drivers/net/ethernet/intel/igc/igc_base.c
> +++ b/drivers/net/ethernet/intel/igc/igc_base.c
> @@ -447,6 +447,7 @@ bool igc_is_device_id_i226(struct igc_hw *hw)
>   	case IGC_DEV_ID_I226_V:
>   	case IGC_DEV_ID_I226_K:
>   	case IGC_DEV_ID_I226_IT:
> +	case IGC_DEV_ID_I226_LMVP:
>   		return true;
>   	default:
>   		return false;

Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
