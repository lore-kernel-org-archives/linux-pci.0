Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9CF2DCF57;
	Fri,  3 Apr 2026 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231064; cv=fail; b=aXfv6EYTOtlnXlUuCyQdlHoMb/5uXMH0oY9/5SkDiIWHjMJvvwTnZIdS5fAqTilUzkJxAiHHYWuGgKxQ6aCeTyxMPPPRJYzvT12OBih7/9I6uijA9EDhFW70TxItAwxYwkKDLr86pUuEiabtID9eQAuEmhXdfAjwDuAQq7xj0B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231064; c=relaxed/simple;
	bh=Q7ZTJWFNvdV1qVTBbObpjOQxn9Noh2bg2XbiqNTaSbM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VmqO3Vpw6Nem+UvDMnPqTWnvqhyPR5f4Bz24RcuNgiByOjdB7yfsyaA0Gald3Kc1SKvGnzyQs71D8nlu5VTqAgJyaycRZNvNkXBaj2++EU7FLcsbBMiTV3D5tyExci7DfdSQi94XTGHCI0AkHg41FdYk+xe9reIZWTbEBJmZFAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=InNKflm9; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InNKflm9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775231063; x=1806767063;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q7ZTJWFNvdV1qVTBbObpjOQxn9Noh2bg2XbiqNTaSbM=;
  b=InNKflm9KIQbVUhSFetQg7qgdgsosAq3qxE9sqmSr9BFNjsCXD3DaEbe
   JP3fDGuqSrNGy0ymL6RaPvP0WGDx1FbsthgPsLtusqEH0a+eGeCvC8RLc
   dqyqwD/Xx5ikA3BhU5V5SUumTVQpQGFTQec6u13SPF1ZiLwR4WSfss7La
   HiYFDcpEYTpfGDr3C+eS6QfeG5LMTVOUncvXuCjT6ewgyhR4yc6tM0n9p
   bHAVpdr86/H4L4L9Lngha0pR/0gN+mJqygh29Oi+aQlFRnJ3RiSJwBcOs
   1yDdadmDWbTW29GvKmY+cZ1iMa8cQH3EKJfDdQDHyYhy46c/xNyji+h2L
   Q==;
X-CSE-ConnectionGUID: EIlbla5DQyy1Y8rZQhtsUQ==
X-CSE-MsgGUID: arpKJE0dTX2vuJe4+0lGpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="63842641"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="63842641"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 08:44:22 -0700
X-CSE-ConnectionGUID: Ra14UrGqRnKkj6tbfM1vaA==
X-CSE-MsgGUID: Akpy2FwSQv2pF/ahM36enA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="231326008"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 08:44:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 08:44:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 08:44:21 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 08:44:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irpSrZyZQTK8yrll5aDb+1jQCKcvIrLphRcFmw7L3U/VlSaRfQ+/kWk8SgK49VtlsA/+GYtOCF/PMxyJSdcNaRH75KR1SvijxaPv8aLpQBrg/Mi3dO0ZgcvGp4vzV4XfzmXQPV30NpULYI4aBz2AiiH6dbuIbCMUiHtxtMsQ27FBx0t5Skc498JioLUer/Tp0cn5vj8wEtAfYMwizXrynOnnZcfSSTmjsiddDO1MK4krbfLrvX7UfalTor1xFYHIjJBuGDTSEFDs2EnLQvml/cu+2Y9PbcWUXHRPRnU+X6UaWGJDppTG4VuFWIh9uXiR2SQCeVZDj1WZRxP4+BbRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS9yGX8nyK6N0q3ZooclCYVjCtp7sZAJYa2ZYlYo8Dw=;
 b=FY+CP6ESnbduhS4gmYn948KOuiTcb1mjxwue0kQSUWYSA7HOtsvlxE96+jQ0tGPKAO5fifjs+tc9fUdVm6iQA56t6z4ZilSYCQgFT9VmHKjXn5wHjdTXvGLBewIyNAEC2U4qrgYs/AtqQEf42qAeNRaPzaYbVPRJAgtgdsRD1UiOe8r5S8MyVg/7wUNJ36xwFzbc2UNRSpxLzcuHC1Ma1AJW4D5O3mF+pOcspjJfktnjjKSZwJqFHoDoiQYorRjWcVz+pG73e1vKkBLtlOkjG3yOOK6s7emj9K/YvyFN0xsD3V5SBMvv7c6e08NrpvRxQiSjSsGA+LD6sTP7DOQ66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by DS4PPFE12D62847.namprd11.prod.outlook.com (2603:10b6:f:fc02::58) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 15:44:16 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 15:44:16 +0000
Message-ID: <d1227b6a-be90-4172-9f48-088037b262e6@intel.com>
Date: Fri, 3 Apr 2026 08:44:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,13/15] ice: add support for unmanaged DPLL on E830 NIC
To: Paolo Abeni <pabeni@redhat.com>
CC: <andriy.shevchenko@intel.com>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <mika.westerberg@linux.intel.com>,
	<mbloch@nvidia.com>, <saeedm@nvidia.com>, <piotr.kwapulinski@intel.com>,
	<sx.rinitha@intel.com>, <kuba@kernel.org>, <grzegorz.nitka@intel.com>,
	<netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <tariqt@nvidia.com>, <davem@davemloft.net>,
	<dima.ruinskiy@intel.com>, <bhelgaas@google.com>, <andrew+netdev@lunn.ch>,
	<lukas@wunner.de>, <jacob.e.keller@intel.com>, <richardcochran@gmail.com>,
	<takkozu@amazon.com>, <enjuk@amazon.com>, <maximilianpezzullo@gmail.com>,
	<joe@dama.to>, <przemyslaw.korba@intel.com>, <leon@kernel.org>,
	<vgrinber@redhat.com>, <linux-pci@vger.kernel.org>,
	<sunithax.d.mekala@intel.com>, <corbet@lwn.net>, <vinicius.gomes@intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <edumazet@google.com>,
	<linux-doc@vger.kernel.org>, <kohei.enju@gmail.com>, <kohei@enjuk.jp>,
	<horms@kernel.org>, <avigailx.dahan@intel.com>
References: <20260330230248.646900-14-anthony.l.nguyen@intel.com>
 <20260402102616.177883-1-pabeni@redhat.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260402102616.177883-1-pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::34) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|DS4PPFE12D62847:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b2ea01-9965-46f6-f217-08de9197dce4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4BYsX9jJH2X6SFacyCmFWp9D8bvOMZhqpzxJ4hbgsEqBEO17opn8GyfRbu/BpizZgcd5O52aCzA5k06FNfF5bLYzIpM8pBEK7SYePUKhLFa9USWCoHtv7l5xqR84zCHOdiR4yQ4VF0hZu9ttHV8sFbcB0lc/vLbpsx0isDf6COk2NxYatyTX1Ea6IAgkaY7RuvA7aWShnlMTspN+RMRf7+dzTPD/61BSNaMRz8RxVpv/NM7NxeCENWy6DY9N7KF5pYiwbA6QTXlwQZBhZ7GDaY6ZjeH7ERO5BjbSz42gf8hmrp2vAzE4gB9HClyCwVe0SrfJQ+RbpuijhWSm8anQTRmyOGzKBrk3Yc5A+ouoXwn/cWGR3UL2XAWy/ow7oL3lMmAoAPHenRosKFmQetLlbqLEMb3Lm0bCz9K52QO0UQFYQO2GzB2N2uqLa1z847+DtAWjjBKVh3bNFZYyjlomzyDLww+FKOvrA/5l/HJMh3XlLGZFB3bMquP5FX+ENSA+bimEN6ORkVT1ZSqmjlj7wHikv+8O5eN37YeSN7w/qkM4vEzysnzvqfOYAv/Q57wxZNoT7wb1sMIR0cYxO8lAyAEmAjzlX+VHDcmh0qLVW0YeVuSjjtm4MBjgRBD0WlktZMU+nDkIHO34vDSaCqx7VErtc+FH1Tfz78KXe+X7UWJdVzFP+rwrnTu6sMvFO5ns
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW9DNmlPMVF6R0N6VHorNFozVVEyWnJ6R0YxRU1HMVNpOEFZdlZXZVhrQWkv?=
 =?utf-8?B?TWszdFNmYlZ1UjhWOHdTeDhRUGJWeFU1eGpkalc0RmR5TWhnNUQ3ZWZWL0xM?=
 =?utf-8?B?REd5dmJjUzl1TmFFQWhYM1AvZkJyVVB5MUJpZmRYT3h2THE4WURlSnE2QlUz?=
 =?utf-8?B?dUpFZHdyRVh0UWs2YUhQYTlyektYanZwOXQ1aG9OeUVRZDNBVVdOOE9qUkM0?=
 =?utf-8?B?L256RXp3QlRjU1Z1bk5zdkpGOFJWbENCZVpJaGRraGNCd0R1WXAwS2lVeTNa?=
 =?utf-8?B?ZHZMUzBJM3EyK1VTTExhRlp3VjI1N2dtam1LYi9PK1BSWlVvM09ITTlzZ3d5?=
 =?utf-8?B?dnprSkRZRFBuM1dFdERlemNTc2tRdzV5N3dDbGFGdlR1RU5MK29yTHpiUVds?=
 =?utf-8?B?d1RlamV3bjAwY1Q0TXVTc2xva2tjOGY0TlowMi9sQ0tVOXV1RFF6RTIxQmYx?=
 =?utf-8?B?SXR6UWYwbElXdzNSSGhCb1dYeWFjbWczWnk0UWVOY1F2M2w0YjA4YmN4ZTV5?=
 =?utf-8?B?L2dFaFZlYXJyTGthQTZ6RExCVm1MY3FSOEFLeEo4WTd1NjVnUDRwS0pEdlhj?=
 =?utf-8?B?Y3FWNngvWU5walYvWjZtV25vQzJra1BBbXdQdWRaM0VFTERCbHdQM09XVVRu?=
 =?utf-8?B?QkFDekxrUVNyREZXdlBuK0RpOEVOSzFMUE5JV0xEejhYd3JWbUdMZ0lFWlQw?=
 =?utf-8?B?OTkxS1hDcDVqWDNmNjhrZmhqZnRBVlREdDJoRmJzUUVCbVVIU0NZRU9rWW1H?=
 =?utf-8?B?T1N2MUQ2OTFEMXlscHplcW5sRkFvRjNoc1ZBVzlLUTNUR0xwdFVlMjRCQkkw?=
 =?utf-8?B?STkxSW93ajFGcHY2LzNwK1dma0lpNHNnL1RkN0VUS2VzbDN2bjdXakptT1Va?=
 =?utf-8?B?VUJXZWRiaDcwazlieGQrOEcwaThTSTJVQjhDTDRhMXFyVVBrZlhtd3VqbTdn?=
 =?utf-8?B?NFdVSWFXb3N0anNyZFY1NWJIVjBSemRSOGo1UjhjaEgvZ3ROK1BiZmZPTlpW?=
 =?utf-8?B?ZDYzNDJ0Qko0T05ETVB0cVk3N1JqVkRBNlQvd2ZmenRZUGtsbFYwV2FKZUhR?=
 =?utf-8?B?bDlKU1M2cDRhdU1RT2dzRStUYStSVGxvekZsczg2YjBXWWprVjFpWVZ2Q1pu?=
 =?utf-8?B?alFYVlFuVUpRbWZuR3hNK09YU3VXUFl3V3hvYmNSZkcxdzUxSDlsOGhHZTJy?=
 =?utf-8?B?T3Jib3UzaXVwSUo5OThYR0J3NGVzWC9qNjJHTUh2aDRTQWk4RDUyTnpBOTJO?=
 =?utf-8?B?RFlPRjkrY1lYeVBRaENGWWJydmtvYnNCcHFhWXp3aW05d20yT2hoSHpna2Ex?=
 =?utf-8?B?UVpSMXJlbXlqTjk1T1hJY0p6YmlKbys1RllYeWJwcko2RFpPK00ySWQxNVNv?=
 =?utf-8?B?MlpvNlJodU1KbVlhS2RXRUFHdTA2L2FkS1dPRHo0QUhHWHNPTnN2VTNpOHpH?=
 =?utf-8?B?RWZoeGZrdGd1ZDVoY1hrUzhlMDNPV1AvQ0g0M0VvN3gvU1R5ZDk2UlJFRG9t?=
 =?utf-8?B?bGg0aWQrK1lGcnVpaVpyOVl6WUlMUG1TYzc1YjJnb0ZySGJnWFF6bEo2U2tF?=
 =?utf-8?B?dkdueGU5YlJDWWsram05NVJqTk1sZ3ZxazJrRHltK1M1NSs1OWJxOWZ2RzBT?=
 =?utf-8?B?WHJxU0NRbWpNa0lrUnYxbnJveTZtRThXblc0Nk1yWG9tZ05zNnQ5OEVVQmh0?=
 =?utf-8?B?czgrY0hGOEVoN2IwUEY4bFVOZTB1WjFvb2ZhVXUwaDIrWkgxZ2hwSnc1NjRo?=
 =?utf-8?B?S1lFOGsxaTRUWllLSXRQdGNoZVZ6eEMvbmx0WnBFMjI1ODV5QXU5bndxLzFm?=
 =?utf-8?B?b0dpK2R3ak94ZE5jN2ZBVEI5a0NLYmk4WmVLQWYyMjJIZEVzZWZvQnlPVmwv?=
 =?utf-8?B?RTJXUXpXcm0vN29xTVVDMUtmRHUybkVlejI4d1BCd2Vpa2pyRGk3ajZVanR1?=
 =?utf-8?B?elQ2TWNqQndPUC9NZ2hjS0JiSi9TZ0dhT0xhd0p0dkxtTlI1alZsWGVnV2sy?=
 =?utf-8?B?eFlYMnprdU4wckFEOGVzcFBmeFgrbVg5WC9QV3FtYzNaVkRKRHFKQmlmUlQ0?=
 =?utf-8?B?aXdla2lUWFp4WDFqY2YyaGYxQzdtd244akUxbGVrSklKZ2l4cWhZMnZBa29s?=
 =?utf-8?B?c1VWUW9XNXhxcEdtM0s2KytpQnlERkZQTURIdmE5cWVIV2NDazRWRmM5RGJq?=
 =?utf-8?B?bWZlUUtRWU9VbG9UVXZFd1R6RlRFeXNXY1ZYQ2RQaFlzNnRLRmx1VmNjaGxu?=
 =?utf-8?B?QzUzNWY2SXpabUpnditBUE5RTEZkZmwrZi84b1grNXZXRWR5UW05NHRBallz?=
 =?utf-8?B?VFJGVFovUGYzZVlHajQ3UVZOcUd0M3FjeWZFMnZCcitjL3hGaXNSR2tFNGx4?=
 =?utf-8?Q?+AI3btQvO9Boy5fE=3D?=
X-Exchange-RoutingPolicyChecked: MivdcffRwihvXm3SfzinKT1eXPkJ7DMHEx0yT+LoBaikNp03xP56pNgsW3eVd3CRk+E4/r1l5fKfXEpe5Ct10Odzzef3O1S/6xP+SyjWFIyicbmq7/Yr/PMWyoCkVwbrkRk5eGE17/jaGhvrZWSiSdhtcglbFm5J2K96heFmARTz/fILi7MHKNtWVeJoFIxZTKBh1jePFZWHr5fiAO7/gZoL2A4IA4EmXa6uIO8bK+KtsLsDeE5XKEY2TNl8nYxYuPLT8wJgIEbDN7q166Fbxsp34ePZ441dFb0MzkFFLjT2kwkxrDk5M0mvTDZkQHrYbpogwLCtXR+27nn03Y9p5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b2ea01-9965-46f6-f217-08de9197dce4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 15:44:16.6494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsJqRao50D4lNpccULDeWHuA8Hj8foPxgpUoLkdY/Ycwgwb0QOb2WQF8CxQvjqm3r7Is5wtB+L1NFrRuTXu+3ubBrgsC4Du648JXaa4OJU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE12D62847
X-OriginatorOrg: intel.com



On 4/2/2026 3:26 AM, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> ice: add support for unmanaged DPLL on E830 NIC
> 
> Hardware variants of E830 may support an unmanaged DPLL where the
> configuration is hardcoded within the hardware and firmware, meaning
> users cannot modify settings. However, users are able to check the DPLL
> lock status and obtain configuration information through the Linux DPLL
> and devlink health subsystem.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
>> index 62f75701d652..2a9eb233dbf4 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> 
> [ ... ]
> 
>> @@ -3148,12 +3176,15 @@ ice_dpll_init_direct_pins(struct ice_pf *pf, bool cgu,
>>   	int ret;
>>
>>   	ret = ice_dpll_get_pins(pf, pins, start_idx, count, pf->dplls.clock_id);
>> -	if (ret)
>> +	if (!cgu || ret)
>>   		return ret;
>> -	if (cgu) {
>> +
>> +	if (first) {
>>   		ret = ice_dpll_register_pins(first, pins, ops, count);
>>   		if (ret)
>>   			goto release_pins;
>> +	}
>> +	if (second) {
>>   		ret = ice_dpll_register_pins(second, pins, ops, count);
>>   		if (ret)
>>   			goto unregister_first;
>> @@ -3162,7 +3193,8 @@ ice_dpll_init_direct_pins(struct ice_pf *pf, bool cgu,
>>   	return 0;
>>
>>   unregister_first:
>> -	ice_dpll_unregister_pins(first, pins, ops, count);
>> +	if (first)
>> +		ice_dpll_unregister_pins(first, pins, ops, count);
>>   release_pins:
>>   	ice_dpll_release_pins(pins, count);
>>   	return ret;
> 
> NULL checks were added to ice_dpll_init_direct_pins for handling unmanaged
> DPLL initialization where only one DPLL device is active. However, is the
> corresponding cleanup function ice_dpll_deinit_direct_pins missing the same
> NULL checks?
> 
> In unmanaged mode, only pf->dplls.pps.dpll is initialized while
> pf->dplls.eec.dpll remains NULL. When ice_dpll_init_pins calls
> ice_dpll_init_direct_pins(pf, true, outputs, count, num_outputs,
> output_ops, eec.dpll, pps.dpll), if this second call (for output pins)
> fails, the error path calls ice_dpll_deinit_direct_pins(pf, true, ...,
> pps.dpll, eec.dpll).
> 
> Looking at ice_dpll_deinit_direct_pins:
> 
> static void ice_dpll_deinit_direct_pins(struct ice_pf *pf, bool cgu,
> 					struct ice_dpll_pin *pins, int count,
> 					const struct dpll_pin_ops *ops,
> 					struct dpll_device *first,
> 					struct dpll_device *second)
> {
> 	if (cgu) {
> 		ice_dpll_unregister_pins(first, pins, ops, count);
> 		ice_dpll_unregister_pins(second, pins, ops, count);
> 	}
> 	ice_dpll_release_pins(pins, count);
> }
> 
> When cgu=true and second=NULL, ice_dpll_unregister_pins is called with
> dpll=NULL. Then dpll_pin_unregister(dpll, pin) dereferences dpll with
> xa_empty(&dpll->pin_refs), causing a NULL pointer dereference.
> 
> Shouldn't ice_dpll_deinit_direct_pins add NULL checks for first and second,
> matching the guards you added in ice_dpll_init_direct_pins?
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
>> index ae42cdea0ee1..2c98b6c6deb0 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_dpll.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
> 
> [ ... ]
> 
>> @@ -173,3 +181,5 @@ static inline void ice_dpll_deinit(struct ice_pf *pf) { }
>>   #define ICE_CGU_R11_SYNCE_S_BYP_CLK		GENMASK(6, 1)
>>
>>   #define ICE_CGU_BYPASS_MUX_OFFSET_E825C		3
>> +#define ICE_DPLL_UNMANAGED_PIN_NUM		4
>> +#define ICE_DPLL_IN_ESYNC_ENABLED	ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN
> 
> This isn't a bug, but ICE_DPLL_UNMANAGED_PIN_NUM is defined but never
> used. Looking at the unmanaged pin descriptors, ice_e830_unmanaged_inputs
> has 1 entry and ice_e830_unmanaged_outputs has 2 entries (totaling 3 pins,
> not 4).

Hi Paolo,

We're working on changes to resolve these issues.

Thanks,
Tony

