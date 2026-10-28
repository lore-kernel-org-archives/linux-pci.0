Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793172331;
	b=qS4wXCdU/5xEroh1j13eqqFqlA4aBecdGG9YyzuufAgTcibJLX8DgcmaJtJTDUb3NaCo
	 STBhuTbtesLewWjfycYwmiJLXBi+B7YJhXFCa4lWOsyUtDYyO7kLjmmhP+4uYDKNCtK14
	 7wNCHwAE9GWk4l08N8rygWi0q0ONuIwAxS6kpvN4pMHZTTzqlktoAc2U3GQQsQ5Zm9JZK
	 VSiD6uqAzOpOAnODTTAmOMzZu/WbckG3ABAXIHXvh8dWlchPoXEzR7PkRdbXh6+8+zxZZ
	 KBQn54NNcC18T8ZJPhoGKpIze55mEYCxPaM5cQ5UjYhdic9FA5g79QO6kd/0fF9VQdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172331;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=x9QF9bXkunMMpy2xTQMj77a2oNeaPR6EWpzaJ3r6J3Y=;
	b=nJshviYWsPtO8yN1PlyMQdj7ykpMbiOTyGE63mRdgV6AHI5GmTBjUtvNoeXhr9VEyH4O
	 EEo/K61pyTKzltfXBwaF/Fb2Wa9orzsmIqhFyNuH7+kWYnj8SQaW796R+hGV+a+QsEYUi
	 ZxcsW7zCGpD5CeHuh15pEsDVmXgB992ZRClAUVKiZ17n5zx1SSfMPlrEss6N61tXs2hzR
	 k1V1D9hFsMMbf6MqSn1NCgQtG4NfFIu8uQOkBCfj3/EEOwkhyTbhqbsJlJBhiBR9/C3V/
	 y9Yu7lCFeI0GkCJIHg7JIcWtbpsTeqZtRwGefxalo4igmgdVCfy+9Uu68Yps9wEiZRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="gcXK5/MX";
	arc=fail smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DFD606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 07:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8DFD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gcXK5/MX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793172330; x=1824708330;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rvtZXrJXPNS+elhYQwtUQGpOS7ugtUt9tH0vvcB3HoA=;
  b=gcXK5/MXvby2h5Mb/f6wjDyqbD+DLgf73cHGD42Xn246FWVk6Wl6MVxH
   dWArzhejZCBOwipSRY/A6qbQjjIttK07HAy8gQndP9asWRL3SaOcWf4pN
   9OMxnHFhyN5pQGhmWQ1ei70llB0HZO123sI41+vBjKX9io5f9GkwDjRl8
   NRZezgxfD/qWTxpz0UjlsrVbTR0fv316qZQMyAbUu/VWLvpnEhsqm55Jx
   6WIyRhdOy9eroC6wx3j2GQ4lOu5EIDe7ebEUHBFA5Qhwj4Z2NAzdm8F11
   AsOSf8GOdmiqWpLgSY8cfQRoku94WP01+3QsZIVphfGabCd0DiEdsDho1
   A==;
X-CSE-ConnectionGUID: KaGcmYXpSVOLe/R4DqKmvA==
X-CSE-MsgGUID: ESPgLhOgSLCU+KdDu5PYZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1900630"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1900630"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:25:30 -0700
X-CSE-ConnectionGUID: 6L4t0k7QTl6rI8pZ7s0sSw==
X-CSE-MsgGUID: BD93W0/yRE6uWfJW4vy7Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4629121"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:25:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 00:25:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 28 Oct 2026 00:25:28 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.49) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 00:25:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FigwWiJZNR2/IG+ij7mSvozsQcwu21/5V+6FPoZn+ACLSHf2B6nH6zzyq0preMKy9GZaAI0+k2Ef3jKmCChIkwayxUKuRZKfzMuJwJ0+iAdAI//IoSiojwXQ9WJ+1tMPmZZ7F9vFQRfogjKBNiXdxyfSPcHw7oCWccbnB5/F+3WoUO05aAppj1/gnIZqRnFxTeV2XmNo5b12b/CoOGdKnMuh61PClqHycDYjqHcUst3DAz27LrodjMN5sUdVI2tJBQMjFK7PizdoL+a0qforma3gjZd+lJRxyM0iUOI6/M69+/Tpmd5O1cOst3W6yMXEjzkRTDRgoWnkR2vhy+S1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9QF9bXkunMMpy2xTQMj77a2oNeaPR6EWpzaJ3r6J3Y=;
 b=QIBZ3mXmDNqsUagv5we5ue9/5MigY8FUS+jDkEk4JT95r6WNYgIugteAvyfLam8rkUHAMGppN0qWqKoyHfgOxZWM/Hvo9068YkV6efz0NQtKeKzKKL65n8iHXgrxRep0WqWVKoJXHsl9CGYHEuVsfhrMWGcTXgoS84FZewSYYWd6p/cIlplgNSu3Bv/f/jMiR7LCN7GUJo7KGc3cbbI//3aHP49b7OxLqsOyfleS7ifWgRYJ346gJN9B5o/8bsCfkWOJh9Nie8BC4MgmYa8330jGdOKr3FML+dQh8OxbK35Gny4ejSA6WR2kIW1a7mMhU5dWptDgDkMJhFsJhalizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6195.namprd11.prod.outlook.com (2603:10b6:208:3e9::8)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 07:25:18 +0000
Received: from IA1PR11MB6195.namprd11.prod.outlook.com
 ([fe80::9ca6:19ac:7036:d391]) by IA1PR11MB6195.namprd11.prod.outlook.com
 ([fe80::9ca6:19ac:7036:d391%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 07:25:18 +0000
Message-ID: <ed92cceb-798a-4c13-8079-8288d43b94b2@intel.com>
Date: Wed, 28 Oct 2026 08:25:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] PCI/TSM: Use generic VF iterators
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<michal.winiarski@intel.com>, <djbw@kernel.org>, <brett.creeley@amd.com>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>
References: <20261027200818.GA482873@bhelgaas>
Content-Language: en-US
From: "Laguna, Lukasz" <lukasz.laguna@intel.com>
In-Reply-To: <20261027200818.GA482873@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::8) To IA1PR11MB6195.namprd11.prod.outlook.com
 (2603:10b6:208:3e9::8)
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB6195:EE_|PH8PR11MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb4a7be-a4d1-404c-8958-08df34c49def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|261026140227099003|11063799006|261009223027099003|261021123027099003|261021135927099003|261022105027099003|261022075727099003|261021121427099003|10067099003|56012099006|22082099003|261026121527099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: +am+x880XbQePWjhcKHDP/ybZIgnBhbSZq4qYrZCSKLbKWCLcnfAwSBzSJN2CjM5Bxvef1OfA7soGiOfJh18iO/0HBxC7UIJ7ccutN+8IJ0/xKXCNfmeub2RdINOEHhZSMbLVKLNCIxF0syOPBhcWHQP1HpoyKTHWKmxcLH0nVO7U2w0N2rCFC8g63QsvKSgF/qSoe5Xf+ZL6hcjOtqkYk3AgLooBVVOpSiZvF2MScEE8dtmharFHxIguC0hpECIXB3GPdm3jdClwqAdoFTUBPLKDt/PZEvsFlONOHNRIT3zts61AhYX3r+1Wdk2zrAtqS9bhwSlzKMx/Z68dp8ZUDI72lniE3nWnX5h/kqOh1mwwKitPB27fC7Im+U38hXYfMvSV/6y3GBOaCbSXyU2PV/Oj7LHRn+8L9pW5mEiIazTMAQdkUl4ZF5HBxTJvYzRAdDajkuw3cwIib9qZdvz6fOJFbakHDSh/ghN+ddDiH/o3RWBlVDBMLLYRMKzmVdKJXKIAtbqPP3Hdn2kW9GlGM/jUrAzlmPLp97RYBI8j/2jJySED9FPPaHCYRiEhV8EiYQ4ZzOPFxcAqJwv+TjGb5MXJ87wB59u5zbjz/vvVpHlc03/qPjcEWat1r3xtTgYZmGvwLtl4b+41FDw+MykhLD1pde5o5B3RFk/f+SWUV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6195.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(261026140227099003)(11063799006)(261009223027099003)(261021123027099003)(261021135927099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(22082099003)(261026121527099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVFUVkg5MEMzUEYzZHhFbW5YQnAwWGFYd3UrblpvMnE5eWRYN2lHUitIT0pS?=
 =?utf-8?B?NGxBZU9VMXU0bkpmTEZMcEkycjQ4Y3hWY3lwRFhYK2diZENETElMU0xCQ2ZE?=
 =?utf-8?B?RmNMdjVGU1Q1UWhmaEh0YXRRWktpZWI5Q2hzSE10SDJmOGJYLzA1ODlzdm9P?=
 =?utf-8?B?ZDNJakZuTzVPMXR6ZjBENU43QnZuQ2ZkNW9oTTBHVkZtTVRMUHd1c1NSRUJV?=
 =?utf-8?B?bEdEd2RqM1FRSjRxUHA3Mzc4UHRnNWVlamZqMERveVlWZFU5MUE4U0tTRDZO?=
 =?utf-8?B?aXUrS3dsNmQ2OGxhUjdhdFIybUFpNlV6NlUxTlBPdXhRWXB5dThZTWt5cjRB?=
 =?utf-8?B?UEtYTE15Nnp3WXdoVzFTb2djWUZmMW5jdiswN1MrUks0M0lkVGRLSHdwS2tJ?=
 =?utf-8?B?SHl5WWF0ZEU2a0xCdVRrRlVQZWdlQ1lyMkxkK2FaMGgyaDVnaUlRa1VtaUkv?=
 =?utf-8?B?eVhFbG44T2RTOHh4NzczU2RPQWdub3MreU13ZGoyRVpwb0xDWk03bktjSFJi?=
 =?utf-8?B?bUpHKzJPTGJmREQ4T00xeHNiVEw4czZjbzJ0UVRvY294NVFMM0NxSi9Ydm52?=
 =?utf-8?B?NkpUcjc5MldSWW00YXFOQkEwV1d5QU1FMUJ1TnJZVXZpa2FTbkRtQkFhdGZh?=
 =?utf-8?B?RVc0dGZOQTFqNi9VUkRWclJDcEtja0hxYTMyMndPWkhmSjNwTStrcTF6Q09s?=
 =?utf-8?B?YjhjNUt0cDRKc0VscVBPOTJjbEpLRkxBVUV5QWc3Ym83UkdzQnpnTlp4UzZB?=
 =?utf-8?B?SXdDdHl1V21xVkFCdVI1TzM4VlJyazYybUt3Z1Fobi9jSm05NjNjQjFNNDV5?=
 =?utf-8?B?ZW51UnRkNFREMFMzaXJkNi9EbEJsUDFQZit1MWN5UlVHMFVFSWNFTUlVdjl6?=
 =?utf-8?B?d3dRaTdYQ3lCVG1nTlRkZW8vMWpKbVEwdDl2WFc1RU9WNFhWWkM1NXlIOHE1?=
 =?utf-8?B?VXlKMEpmRGM4NDd5TUQ1ajZsajhyT2xPS2NocjZQeVAvZzdLU0kzbWplcEdE?=
 =?utf-8?B?dkdZTkwzRFFtMXRudEpIek83NU1JcVRxdi9qd1pXdTFKdTkvYVM5Ly80c3N1?=
 =?utf-8?B?SUxDbEh0TGdWRGxtSk03SHRLU0pjdWtjRll6SzFwdkFvRjAvMnk1b1BWM1Na?=
 =?utf-8?B?U2RYWEsxQVMvTVJadSt3MHAxNWRFMEUySGVzUkd5N0FCbVZqYTJVSGlFeEVv?=
 =?utf-8?B?d0FWRHlxYnRzOGhpQ3BLeVUyZUhhdFRKYWQvbGxJNEhwMzFpSkp5QWNwN3Ez?=
 =?utf-8?B?NEF0MkY2b1BMS3R3bnRVazZzYVpHZHpEdXZIMnNkTXNTeDd1Qk5Qd0FaeU9U?=
 =?utf-8?B?TFBaMkpYaHpsY04yZUcxZWlzWkdEaGNyWWdkRFVIVkVUYTdHN2pma1pqT0NM?=
 =?utf-8?B?TDI1VjNDS2FCZ3oxVndjN3VXOGphTkh0R04wS3BTMjZnVktISVB1dzBSa0Ra?=
 =?utf-8?B?TkkvNlRTWHJhVXhsOElBUE9zdEhlT0pHY1FNeWI0eCtrZXRBeTVCNGR1eUVN?=
 =?utf-8?B?U0p3NVAwOU05cmRKdUlqbHRVR3pOUVR3TFo0S05PNlBja1lCclFwOGF0Y2dN?=
 =?utf-8?B?ZGpGc05HSWozdFJIUGxUYUZMcGpScUxydXdkdithaFQvNStaK0pINE1acGQ3?=
 =?utf-8?B?WEJQWlBkQkk5YTZBNHRpa3dmbGdYekduT0hKcnluaFhpcDUwaVhwS1IrV1RB?=
 =?utf-8?B?NnZvN3pDM1BLKzlvUEFoKzdObzRlRVlFay9mTWhTQ2VmV3BMLzBDaWduY3NX?=
 =?utf-8?B?TTk5bDhIcStNUlhOejNoVUljWUVCMVdrR0M0cTh4a2RHa2JZSnVGdnlTTmxU?=
 =?utf-8?B?eHZaM0NOK0daMlEyVEZLVS93eU9QT0ErRGVERVRhMmRsOEJlN3NkeXB4ZDRq?=
 =?utf-8?B?TFBPQVROd0U4MTc5WGZFa1c5N2pTZnNRbVlkMWdRM1lYNG9rZDBMYUY5cHBX?=
 =?utf-8?B?Mi9wZUlhQnhKU1oxWDEzY3hTSmhoSGM1OWFaQTdnL25SSHNZdEYzbkJoVTVy?=
 =?utf-8?B?dlkvWGdLMkc4bWlyZVZiaDVFTDlHa1lJVzhYdzNCYjlLL1d6ODNmUHlpdW9k?=
 =?utf-8?B?MVhaZk5jd05zZWhOMEVheloreGJDNHB1dnlTWmk2ZmYwVFpvOUJlZVhmc21L?=
 =?utf-8?B?a0s0UW9xUklLYnJhYzNtcFRLQ2srZ3lvR2V6MVdaTjMrNnBFUDNibExFNnhn?=
 =?utf-8?B?aDkyNU9Gd3k3c0JVOXpTVTR1SHVFZmsrdFk0U0kvV0NYS2Q5VWJNNVJvUDBG?=
 =?utf-8?B?ZC9RT3d5d3ZHVmJ1eGxTZFdDWWx2SGhBdTVIQTZjVURBbHQ1ZTczdmNCdUt1?=
 =?utf-8?B?NHJQZ29PNFlXbXEwTTdGQzlWaUZ5RVA1UUprR2o5TGRZMHBWaEpiUT09?=
X-Exchange-RoutingPolicyChecked: kBePqAqlpW0cXVLDydylXt8HJzU5Kt6/MqEV8UresO3dMgJqqkpXXWxo/Ks3nNGxo08YQjrZrLcl2TK85xBoSyGZXNrU0Vb0LEzeyx1rINi5B1drQ7xW842oCZxjkiK3rYkulKy96AsK/4odu0coxI1VRDjY6vJN5mckt5PqCrQKkZ1zJ4f9SQpD4Vn65o4yn5FtfwwDfjGSz96ApjAaKKhMdof7Hfj2NOSbqxVgyhDcvvrjlV0GlTB2xmUmkxoFevtlvCk208+5C1Ns3EKyd6i5z0d6z+KcPAHLvhvWHcwLbm3xI7Mge2QIOzEDXGjGeDpAe0S7j3szqEMfTaGeiQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb4a7be-a4d1-404c-8958-08df34c49def
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6195.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 07:25:18.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M94EnBtSZEzpyjGVqR6J2J52mgFdhFZaHNZbmmEhqFSrw2IklFYnzptzXTVfeIa/DdpjEmFu2Odh070/9E3Rpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com


On 10/27/2026 21:08, Bjorn Helgaas wrote:
> On Tue, Oct 27, 2026 at 05:04:42PM +0100, Lukasz Laguna wrote:
>> pci_tsm_walk_fns() and pci_tsm_walk_fns_reverse() implement their own VF
>> iteration logic. Replace it with for_each_pci_vf() and
>> for_each_pci_vf_reverse().
> This and the rest of the series seems like nice, relatively simple
> cleanup that could be done earlier, e.g., after [02/13] "PCI/IOV:
> Introduce VF iterators".  Those look fairly straightforward and maybe
> could be merged earlier to get them out of the way.

Sounds good. Is reordering enough, or would it be better to send 01/13, 
02/13 and the cleanups (09-13) as a separate series?

>
>> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
>> ---
>>   drivers/pci/tsm.c | 25 ++++---------------------
>>   1 file changed, 4 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
>> index 5fdcd7f2e820..01fa6149e481 100644
>> --- a/drivers/pci/tsm.c
>> +++ b/drivers/pci/tsm.c
>> @@ -84,6 +84,7 @@ static void pci_tsm_walk_fns(struct pci_dev *pdev,
>>   	for (int i = 0; i < 8; i++) {
>>   		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
>>   			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
>> +		struct pci_dev *vf;
>>   
>>   		if (!pf)
>>   			continue;
>> @@ -93,18 +94,8 @@ static void pci_tsm_walk_fns(struct pci_dev *pdev,
>>   			cb(pf, data);
>>   
>>   		/* walk virtual functions of each pf */
>> -		for (int j = 0; j < pci_num_vf(pf); j++) {
>> -			struct pci_dev *vf __free(pci_dev_put) =
>> -				pci_get_domain_bus_and_slot(
>> -					pci_domain_nr(pf->bus),
>> -					pci_iov_virtfn_bus(pf, j),
>> -					pci_iov_virtfn_devfn(pf, j));
>> -
>> -			if (!vf)
>> -				continue;
>> -
>> +		for_each_pci_vf(pf, vf)
>>   			cb(vf, data);
>> -		}
>>   	}
>>   
>>   	/*
>> @@ -128,22 +119,14 @@ static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
>>   	for (int i = 7; i >= 0; i--) {
>>   		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
>>   			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
>> +		struct pci_dev *vf;
>>   
>>   		if (!pf)
>>   			continue;
>>   
>>   		/* reverse walk virtual functions */
>> -		for (int j = pci_num_vf(pf) - 1; j >= 0; j--) {
>> -			struct pci_dev *vf __free(pci_dev_put) =
>> -				pci_get_domain_bus_and_slot(
>> -					pci_domain_nr(pf->bus),
>> -					pci_iov_virtfn_bus(pf, j),
>> -					pci_iov_virtfn_devfn(pf, j));
>> -
>> -			if (!vf)
>> -				continue;
>> +		for_each_pci_vf_reverse(pf, vf)
>>   			cb(vf, data);
>> -		}
>>   
>>   		/* on exit, caller will run @cb on function 0 */
>>   		if (i > 0)
>> -- 
>> 2.43.0
>>
