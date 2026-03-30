Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4332A1BF;
	Mon, 30 Mar 2026 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774834887; cv=fail; b=bE4W6XuNikAT4u1ZDzeh3aL6XzXbDqxJuaLYhtgSlL55EU2CnjVPIn1HIMn18sjQ7S8PiDuyW3RUOE95KopjDF2m4DMq7gFOcLsEdAnROSzEnGcBaiAHnFZzcB2eR/kw64rftU5mAA6kRjSMy8aN4Pjq4RKBBo6dx8KfxIUfEX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774834887; c=relaxed/simple;
	bh=3aYzfKS+jHfhGKFPxQmdwyH6H/xych5fTRPdh2BqjIY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=PwLxrchyXIvLayOotabDkzJvL5pZH98fpK585jxa5esQS2+v/7cS5ZCtOEVp+WOLgKUfOuX5YpyS31eY9bMGeZxYnqk4/cf8GRQZfL3qoM0hWbCGKoTgXXDxH9i6KWn5HCr68BuQIRkBxA2Rfmk+GwyH0SbPhl2vb3uXIIuhKMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikdCgTT+; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikdCgTT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774834886; x=1806370886;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=3aYzfKS+jHfhGKFPxQmdwyH6H/xych5fTRPdh2BqjIY=;
  b=ikdCgTT+OFROmkSq3on41dKwXPjEi7XSx0K2qYkCmxfyMY6l0XNOjEgD
   3g+kfMVbxyp6MjYCSNdrAZf8Z42pqtqSLWd+6HjicBlCHvREJ5PeWLNHK
   z94TZqeLuPyVkURBdTkLqj3C+Cs41UKraFpcuKYFUz/0SYLeeCGzRdih0
   Vy3pSVYEFocaY4c97e21czpVO3EDv4twbTpi9ultQidoPuUCXzXxf65LG
   Ox09d4Mjao1vRInlyw7ZSWqV0tw0BPAPC6lZOUwpsAFsNF2bfL2Qrjf2V
   XcVkTMioKS3CjodXQ/ZfJiaNgdp41dCWoRidhDl9AUarmTExRWAJL8CvF
   g==;
X-CSE-ConnectionGUID: rSUi1ti/SrS28bTrFY3Lmg==
X-CSE-MsgGUID: xo7Rn6DNSvSo9jIuEjVubw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75792917"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="75792917"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 18:41:25 -0700
X-CSE-ConnectionGUID: mSb5euASStCkKQKG30OHUQ==
X-CSE-MsgGUID: Zl3OGPLuSLqRWLPOs0ROmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="230821257"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 18:41:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 18:41:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 18:41:23 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 18:41:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDQ9qkfznoCNZwLrqieM6Ve6lRewfpptmS54R7J/ovtS5oEsroQS/X8NdbrprngTc48IlYCyTGtxnqUI6mtKQk/QJlIHib7KJ3TLRw9SYUGFy/ljhtlf+Zu1p3gqEQBO2BtghfGcEaMZ6r+gZQLl4NPQlAZe2+His/XbMtH99Seu+0zxlluvGwR7DFpvdsY/4QtXZEomMFiqWLag0OAthc05uAGHCRjwzZC3jOugDoY+O1VGXUSmriAXRJj6FxD3BUge+VLjpUEH0DuklPhY2Ynh0M3QvuKc1fmHzIX2KCwsgmqCwoC2+Kjh4saj1iyaNRulHI0CAa4efOnwe2zMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUe9w2xvW2xfzLqc4lDaUNyUCAI3eUk37Q34GfztPlA=;
 b=BN0vZZOBfDwHQ1aELU2tz4NWDYpVYZhCo3M/Na43gvjETfecEEY8MuyI6rxnlFC7io0B9weZc1qaWwX4PiBZp5u9ln7sdS3O9J9jH4Nord6jPFp+Lo7YST/Ylv6xLnhC0qDIehRjxkeORrvS/63snewuUtc7h15HGybntemSzAkltk8uho8uaGLIySKN1s69CxQQKPsG3eVcJmuBrKIE/BcoxFhavCy0cQXOzMX0jdPo6GaICk3IB3tnZEDUN6xF+Pr1vGf6Qpf/p5z71UZI11XvkZrMn7RgO25UPh2Oy+2SJReG9nYRZlheNjLlaArY90/hLkDzph91+yTqZfyOFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7878.namprd11.prod.outlook.com (2603:10b6:8:f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 01:41:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 01:41:15 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 29 Mar 2026 18:41:12 -0700
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <69c9d4b8e08f1_17890410047@dwillia2-mobl4.notmuch>
In-Reply-To: <20260302203648.2886956-11-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-11-terry.bowman@amd.com>
Subject: Re: [PATCH v16 10/10] cxl: Enable CXL protocol error reporting
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:303:6a::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b0ff9b-f367-4a8e-a761-08de8dfd6e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: uXUZ61zDcfS7tWklcZqz9T2oYwjSecGtYodmyplkDT43ouIf9LeRZFWi8b+7KCA4+2fw90V0jz0JsjUVXBHWRgvNbe7HvsrDj1TrXHSxoA23uSkoBzaNLlG6s4hiTMPj0Qq8vhurTENm8s7ZdjuA0kkcNvki8S+v69CCeFWylOj/Vntn4kfjnO7ZwtaLJqkwlY7USfxfL0OxnKR4YENz0K37CFOz0VyMaHRc0FO4cEESmPjqXKZeaiF+FL/4bb/ieX9eE1xDsWQ2ZMgGUemiMLf+CcuThFTX9UQYERbdt7Vja9o7kgtbWjjr6sXHxv93TCoRKqbpSo9Hl3UxpxP+N3jynGGAJBR3XcR7f/zChd/C1lzfKDwRcI2UtlvPanxn8IFsYusw2UjPahco8j/URut6TiLHDLD94fCiZdpHFN5UTBnJxFV2bVZd7b/gOYS20AcGZjXWvJyzgdJL9FIcgKNtzkAtYEV4ceAu51ajL8GqhkIl3xC4C8f2CzI8PJ2yAz6arKfSn4zVmVK1odIS7AZ8CGxDc8+2yAu+8CUuOENtzj4ehZ7OhI2Zvk0py7qscYt9UfxCA4zd51DSGA9u46ONojthjcJU2/Q31MDpXvWTz5/5fvmqxJ0ceZJxT6NkiUSDrLZ1BsPVJ3ETd/YBqyUyi7xXMAZRoAXbfnIxEkpXK9U6cF26X4rl8m8HKT/iZbnzOAQTRBYdst9z7xrdLZpmABOjgpv244f/l70YMWP7Z3PK0Rx8ZXkYNYuaWdtmQ4flehNdhc+dMIaOT2gNRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkFjQ0R3bzd4UG9kVW4vOHJVUXRPY1FFK2RLK3ZtT2RsWWIxaS9jUzd5WHZy?=
 =?utf-8?B?WEtnSGJmNU0zSWRTUGN6cU0yNEU2MWVjR2hHUjFST3hhYTlCeFI5VlhiNUxQ?=
 =?utf-8?B?WSswZ3JJdkkxa2xQQzNYY0p6VW1ILy9mUmduemVWQWorZjZpWS9QUkRyc2Zn?=
 =?utf-8?B?bi9iNGU4aUhyWHowaXY0QzQzYWNqcVdGNXRwR1o4SzNWRlA4Uk43UWtMSVRp?=
 =?utf-8?B?Vmd6czVwNVlMZ2h5aHR5TzUxbE1OM1Ezc3RzTGFHN1VQSzhzeVZRbXpqL2Rm?=
 =?utf-8?B?TGpoekEwWGdXRjFBODBsSFJRMHJiUHFPU3ltT2VWTmk0WlQrWkZRTG03LzFs?=
 =?utf-8?B?VEwzUWx1V2hjczNRcU9rTWRaTE5ibUNydjJyR0NHOUNsaG5yNDdJSmhWMVg0?=
 =?utf-8?B?eERKT1p3K0RKT2pOYjZONDBZOU5PNXZ3cDFBQ3ZDM01JK1A1aVFReGFWaVZs?=
 =?utf-8?B?U1BaZUk1UllZZmIrbVIvc2xqWnl1Y05EeS96MWEzb0xEWmNWRGVkcktUZHBV?=
 =?utf-8?B?TUdIZDZveENaYU9WdTBFNHVaYTRlSHRzN2pHbHA0Q29WQjNlY3FielI5U0d3?=
 =?utf-8?B?Q0NBdDcwN2VtVlFOYkdZMG9BUW5sek5tMHZmZ0lRVHB6WkZ5SEU1MHVTbGRt?=
 =?utf-8?B?elQxOFBzRndyQ1A0cDA5RmVXOGF2TTF0eWRYSVlEVktINDl1OWRSOGpPZHl3?=
 =?utf-8?B?cjI1WXAwNHhrZXVraHMwVXBKaXpPU3Nqa2MyMlZwWkcrbzRKWXh3TllpZkVN?=
 =?utf-8?B?YUR1M25tMk1yVjlkNkdDeThJeEFEeUMwQVJQVVJTa2syM3NvcFJSOUN0Y29C?=
 =?utf-8?B?R2VFV1NHS1lVdUtXRVRsaWNyY0phakt1U3VyQTl3R2RNakVVS3NJSGNHaGhp?=
 =?utf-8?B?RDdwemVwUExST20wUG0yTUk4VlJlZjBuQ25ZaWtCR1RqTURhWGVFVm1nRzE3?=
 =?utf-8?B?VUZtNlJITGdkbUJPcnkzVnNFUHVicTE1U2YwRThnRDdpQ25GUWZLc3JOODI4?=
 =?utf-8?B?YnQxc2RaU09vWHZRWkk0S3VUWFc3VU9HV2M0QzBPR0hOYXoraitTM2pza2Fk?=
 =?utf-8?B?S21BaW9TalZ6K2wxbGxYdjJBd2hUTk45UHA2Tm1kbU5NU1Zkc25TdDlVaXN5?=
 =?utf-8?B?TVJySEJNWE5VeE1JVEdsanFwTDRNZ0ROcTNrRjBOTEpZbko1K1pCM1ZFVmk0?=
 =?utf-8?B?K2IrbERUWHVUME5yTTArbUwyRXlSb3dlWnYvMFBOTUhmbHhNUzN6b1F5Tm9j?=
 =?utf-8?B?c3RYdGZNck9DNVRWY0E4eEVUaTI3bFpOVVRsRzBqWHBBN0tFcnNxVmhqR0JW?=
 =?utf-8?B?Y2NORVlnNmhhVkV3TFFFRVoyVUNJdnhld3BIc1FlOXgySHE5SWhDclROcHZp?=
 =?utf-8?B?MkJuT2xCYk9rekFTRHV2ZittTzhMb0pBY2dWUEhYTXN0b0pwZ085dUFoREto?=
 =?utf-8?B?RVlxemZuakxUQWdiYVhPL25XSmQ3MzFPK3lOUlh2Tnh5M1JVY0xqWWg3NGFs?=
 =?utf-8?B?UnB0cGxHN0ZxWGVNNnhNMHN4UWlyQ29oTklEQk1mK0RkalAxRGRlNnA3YXMr?=
 =?utf-8?B?RCthbVd5S2VkMzdrZzFEU3hxN3FFNzdkeG43VlBqSVltTUJvV1VhZnpKTEE1?=
 =?utf-8?B?bktqb2J3aEtxQ1R3d0xFYlhiTElnSmZtT2lkSHdsOVFRMUxRY0FiU3RLQTJM?=
 =?utf-8?B?NFJQNW5TV213eHBYdGRGNzN6dHhOVFJWYjVuQ3gwYkdDRkJ0SzJPdXVSVDR3?=
 =?utf-8?B?b2JSQ0x5bGwvYUdhZUp5amZKbDIrdmxrZGRqZC90MFNZQXNpSXB6bnFBMHk0?=
 =?utf-8?B?d0lENFRnbjFObjNBWjk2UGhjWisrUTUzMmMvWkNUYjVyQ2h4dDdYenVzamhq?=
 =?utf-8?B?Q1hoa2dnK3FIMWk4YkRJbFUwYyt6T0pvSW9tZkcrbGRhYkVmM2t5eTF1Vm1Q?=
 =?utf-8?B?cGtaSlkzUFNrb2FMUWVXZEtyVUNUVEZBUFJXaEx2dVphTS80b3pncG1xaVo1?=
 =?utf-8?B?dnMyS0VScVBJMFhCSHBybEhZNEZSN0gzcm8rU1VOMGNOeWpLM1BubWpQRGVH?=
 =?utf-8?B?SFZ0UFRaZWg3akhXTG1JV2ZtUTFabk02UTAxZUE4ZUpxUDlJbFhqVkVkNW5M?=
 =?utf-8?B?dzNFZFRNS1dJa0d3dHJpTE8rbUFwUXZCMWVCNEtFN2pIc0hOc2J6VE40eFFH?=
 =?utf-8?B?SStweEFOeXNQUUFSYkV0OUtSNDg2bGF0eXhYdjlHT3J1a3o5ZGE2L2xaQUlS?=
 =?utf-8?B?T294Uk1rTyt6Rm41bU1DTUJzN3FRTXZxeDkrbVV0OUE1M1MzL3Q4WWgwZTNV?=
 =?utf-8?B?UjNGQ05JL0l5a2lSb1ZxY0VIZE9nZVBlYllwV2NYQ3h1TUdETnM2eWpRcmxx?=
 =?utf-8?Q?J3aqWUfmorMSpAUI=3D?=
X-Exchange-RoutingPolicyChecked: Nfr95/3GSoQ46uDXEZJeZik6Y2792mKboDnMR/UKbr9gjgXbfBskwheHo2URgj63lzJE8kCIkT7pRnVbWNuGcj9Rr9sjYkp8utZiOVJ1oTuOqF9wt6sYAXeF1IL7l0c46t76vsJjV4KCUQen7+5otYCJwYz5hFuUl5RcXRzzPvO0jKM5srRQ6SMeBNXJVXVzbAJRdUqpOWJuzLyFSAdNCA/aty1+tGzfCnWlYFwj/VvxhfYipX5pX3EDipIPBPWwb17xOPmEf8HeIuzMPJIiYXYcQ65kHUCbriKgohfbbCnrz1poe5y5g3Ds4UQDqH7/DeS73NLl9TcnHihdtF+4Pg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b0ff9b-f367-4a8e-a761-08de8dfd6e92
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 01:41:15.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQnFrhtoti5wEwtGCDFITQJ2wb0usgMxFniDHOJ8SvROh4+3HdLuC8HmpMaleGy7uo0Wo8fx1drEYSzbMwGGbqS0+VbXaoFy5JVzN56oNk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7878
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL protocol errors are not enabled for all CXL devices after boot. These
> must be enabled inorder to process CXL protocol errors.
> 
> Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
> pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
> But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
> Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
> correctable internal errors and uncorrectable internal errors for all CXL
> devices.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 
> ---
>  drivers/cxl/core/port.c |  2 ++
>  drivers/cxl/core/ras.c  | 22 ++++++++++++++++++++++
>  drivers/cxl/cxlpci.h    |  4 ++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 27271402915f..c33d58fb7264 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1852,6 +1852,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  
>  			rc = cxl_add_ep(dport, &cxlmd->dev);
>  
> +			cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
> +

Why here? devm_cxl_port_ras_setup() will just redo it, right?

>  			/*
>  			 * If the endpoint already exists in the port's list,
>  			 * that's ok, it was added on a previous pass.
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index d6112b812c82..bfe6cb35154e 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -119,6 +119,24 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> +void cxl_unmask_proto_interrupts(struct device *dev)
> +{
> +	if (!dev || !dev_is_pci(dev))
> +		return;
> +
> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(to_pci_dev(dev));

Why does this need to hold a reference for a simple to_pci_dev() conversion?

> +
> +	if (!pdev->aer_cap) {
> +		pdev->aer_cap = pci_find_ext_capability(pdev,
> +							PCI_EXT_CAP_ID_ERR);
> +		if (!pdev->aer_cap)
> +			return;
> +	}
> +
> +	pci_aer_unmask_internal_errors(pdev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_unmask_proto_interrupts, "CXL");

Why export? The only callers are internal to cxl_core.ko?

---
 drivers/cxl/cxlpci.h    | 4 ----
 drivers/cxl/core/port.c | 2 --
 drivers/cxl/core/ras.c  | 3 +--
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index b7cf9d6137b3..184a95e96ea9 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -82,7 +82,6 @@ void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
 pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 					pci_channel_state_t error);
 void devm_cxl_port_ras_setup(struct cxl_port *port);
-void cxl_unmask_proto_interrupts(struct device *dev);
 #else
 static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 						      pci_channel_state_t state)
@@ -97,9 +96,6 @@ static inline void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
 static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
 {
 }
-static inline void cxl_unmask_proto_interrupts(struct device *dev)
-{
-}
 #endif
 
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c33d58fb7264..27271402915f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1852,8 +1852,6 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 
 			rc = cxl_add_ep(dport, &cxlmd->dev);
 
-			cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
-
 			/*
 			 * If the endpoint already exists in the port's list,
 			 * that's ok, it was added on a previous pass.
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index bfe6cb35154e..1f688110f0f4 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -119,7 +119,7 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
-void cxl_unmask_proto_interrupts(struct device *dev)
+static void cxl_unmask_proto_interrupts(struct device *dev)
 {
 	if (!dev || !dev_is_pci(dev))
 		return;
@@ -135,7 +135,6 @@ void cxl_unmask_proto_interrupts(struct device *dev)
 
 	pci_aer_unmask_internal_errors(pdev);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_unmask_proto_interrupts, "CXL");
 
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
-- 
2.53.0
