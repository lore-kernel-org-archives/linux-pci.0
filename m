Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8E28D8F1
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 06:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769841749; cv=fail; b=D2nrumkgR15/MwqIMrU+HB+saSGkGR4ABZy18pSjn+5R65pSwe+3rj2ry2fueqjMgCMqDWnN2HUlhHt+q7/CJEQBdxizSoG7KFxm2wt8r5ZSHD6qydGP2vyXEzWW9Rlgdw4Q81hBO8yRoxeY5g1iBY6CkzFUZX/lx0ISOK5GXvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769841749; c=relaxed/simple;
	bh=+ZbZf4OZNPmJFC+xU7d870SESfaO7j1X+NtCkjkfRBA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=O0Vvkp+HLOoUtm7QXNzYcGKmOCWzHn5+11VQJOSt6+BpbkShNRpL+yd0DgfoeY1oQMAwouWsj2RMkld2nE2MHoLCGxnxnj1pjheJFohDW9O+BIZJtX7H9N7YlWQ/jF3A3+nFoSgjpUER9Oy8QoOhhWSu10pMeksUsiSVlNIA4Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSj3zuw7; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSj3zuw7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769841748; x=1801377748;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=+ZbZf4OZNPmJFC+xU7d870SESfaO7j1X+NtCkjkfRBA=;
  b=nSj3zuw7WCi+AX1CJuz+JMMZzoj0SDRmZXXY4WRmo+zFLUVTtoLgQdjx
   0ZPnexAswQBe8F8OGCn9zPmulGVDsQgG/Ne4lY9A/o+VUmlNvmZJqyBgC
   jqv0QJU8GQmAVmv7uNazT9FUWnRjYA/lPLGfGcFn+K6mkub997mZyekzV
   +dRUzid/lhF04uVyklT2TukIk3Gj35iwMC4CGkOY5zJYg5MiBsiw8OqP1
   U8NaZHRCwcNMtRkdkcM04IyOF4j8vUHm+gcMkuBKT6CB88Gzg0yYTx7Uf
   H0lDjmIL2xFoVNxQX9KDU1rGzisvOR+N3yyyAapEoJkrM5bgHv0XShzph
   Q==;
X-CSE-ConnectionGUID: 8rBkRW7BTSOgb5C/ihIr0A==
X-CSE-MsgGUID: y+i5cphlSHyuu/llByllzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="88660592"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="88660592"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 22:42:27 -0800
X-CSE-ConnectionGUID: pmq35Wn/TNGJPYpn7Rf5Yw==
X-CSE-MsgGUID: syAUi2Q3SdGYdvUTe2kjgQ==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 22:42:27 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 22:42:26 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 22:42:26 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.24)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 22:42:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBdl0wplmPvPjpye1iwnMdlDdjIBY8A5O/A7mu2IiFRV9sf9DlMuBWISVVNekWckdY0U3R75EQ8wW0g5kS0dHcfF60nFSNs+xTqF1g73//DXCwMg+ng5+9MlGDfmBZfKgUmlWFlnHttHFqr829Mb0jsRcn3UH+15Rgzo7s9pKuuEEF7nKCEFffWbZOGTzuVqdiZ6wI5BGRnAFQGGB4yebtq6Kj4T2MUDl6carwh4N+QLMC6aTvp8f/m0hC+wogfUjruAe81ms6J2wSqRd+jjPxCmoF57p/Q82CBNlOE+N6PKKrM+dxw5rMkHULIPg9HAqWRrP8BKXk4UpD+QfMYllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5wawKwRRrSUDPkBS5FxhBkKXl5qFUz1CcTifcmTdIE=;
 b=iqmFahso23DjdxA+bEMgGbsS3yT4RDANhHdfhY/dGYDq9fm2guSwyhviX6I4F28ZSZXrZ/N9/5rbBWlEHWfc8J8meLx9xj9/vO3euXZO8fFkZbCpQjNPFUy92SV18j11NIZK4x9QMTpbw22z12JiIdOUkyeE57KYdgRs/LXrjPsRvJqGOqNfLXEmB3uDgpIUTDQBt8olo6t3FabN6Q1QnvcB3rQIfX1g0yb0r/21EaFi6Pri4OzHYfYphNte9i2Q+G+b21Gw/2QayY5KSYt2RVEHdel3xk9DzGMhaKq9qVagAY1Erx7/QdbvEB9WUhCqu96GzA/MetEkJoLbrkoL1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7622.namprd11.prod.outlook.com (2603:10b6:8:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 06:42:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Sat, 31 Jan 2026
 06:42:24 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 30 Jan 2026 22:42:22 -0800
To: Keith Busch <kbusch@meta.com>, <linux-pci@vger.kernel.org>,
	<helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
	<guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>, Keith Busch
	<kbusch@kernel.org>
Message-ID: <697da44e6d895_1d3310085@dwillia2-mobl4.notmuch>
In-Reply-To: <20260130165953.751063-5-kbusch@meta.com>
References: <20260130165953.751063-1-kbusch@meta.com>
 <20260130165953.751063-5-kbusch@meta.com>
Subject: Re: [PATCHv2 4/4] pci: make reset_subordinate hotplug safe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff455a8-4244-4569-2222-08de6093e447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tlp5Um1JYUE0aFV3WlBhbmFBWGVaUWdLNytLc01Icm1IZG41a2dwS2huSHFz?=
 =?utf-8?B?cTRTcmxwdGVqQmU2NG9wbjJsaVgrWHZMTEJLWmhEVXRmNmFtMGN1YTkxNSsy?=
 =?utf-8?B?ZVg4c3E1ekZIdmp2N25TL2pVU3V2MHQ1eXV6OUpVQVh1UE9kMXJZK3BXV2xL?=
 =?utf-8?B?NlVOQzl5Nys1eGllQVRxY21vMTRBa3ViTy9GclN1Q1NLU3hhS1pJbDZFQkRj?=
 =?utf-8?B?eDA0RWhhZHppNkpFanZTS1UvS1pyWDJjNU5xY0RaaWpxVmQxRm5JL0RzMGsv?=
 =?utf-8?B?YUdldGxLaVlMYnpLSFhhbnpPSERYdnF2azVqbTJjc3NabTZxR1FYZ09DLzdZ?=
 =?utf-8?B?N1ZBN3B4NFRLZXkrUkVidUF2eEFRUmo3TTlKWlc2MHFqRXE0clBRb3ppa3Ay?=
 =?utf-8?B?WDNPTVhXRkc4NHgwMmVCSEsyN09mU2Y2UEtiVXljb3U0R1c0RjBEeVlkWmhq?=
 =?utf-8?B?TGtiK0x4WXpGaGlRSENITS9lN1B4Nkg0amhVNFZlTmZlYlJ3M21QTC9hS1pS?=
 =?utf-8?B?M0NjZFZ0Q2VCS0dWNkRwc1RTRGtFa0NJL0ZuSitOd3ZuelNGVWJ4RW53QnVM?=
 =?utf-8?B?VCtINTk0cXRZV3NLakFqMEZBSzRyZkhLNTdqSFFta21la0dsWnFldWdsbnB5?=
 =?utf-8?B?b2Q4NFNHdEw3OWM4Y1V6Wk5OdWNpT2lwQlExRW83aGRsVDR5RFFxbmREaTdv?=
 =?utf-8?B?aUxPbWZQbm5tZ0VwQ21xYlBObncyYytyK21SK2I5NnRKaEUwd01hcHNCaFFP?=
 =?utf-8?B?QmV4dnVBejV5N1JIUzc2c0RWNi9NTDMvRmJtcFNlVWd3alNlMnd4NHA3akg2?=
 =?utf-8?B?aFpLYjNNYjNxZjhNSExzWjJGNklrSGJUNlR1YXlyRW9KOUM4U2tJZk5iZWts?=
 =?utf-8?B?QjYrSFVvK1IwZ2djN1ZqdGJXQ3F3dzFmUElwRDZMNGpyelF1VWRLNEpReXBP?=
 =?utf-8?B?U3VJVCtHenFkY2xhTkNPcFdJekVFY2swSW5hOE42VXpvNDJUc3ZxRmtIV1k0?=
 =?utf-8?B?Ty9NSnIydmxsTVBDbHkrS1ZmTjJMa05kd2ZsS1hmWWwrWnh2U2FZNEJlRnAz?=
 =?utf-8?B?WVd6ZkVkZVlKTExES0JVUm5hZHF2Tk52MGVCUjFxM3ZlZ0ZoTXY5YkJHNElE?=
 =?utf-8?B?M0JyZW1UMnY2emJJc05JdFg5b0VTM2JYM0Y2NTlFYmJiWVdvY1QxaEJUU3RZ?=
 =?utf-8?B?clAzd0hsUDZUV3gxclY5d0NWQThtamJZRkVUYkNGZzJ2OGZROFcxbkJyaytL?=
 =?utf-8?B?TG9nZHA4UjlUeVpLbkpTeEdVOWpTYk44UTdic0ZVN0RtOTJ6R0lyaUlJM0N3?=
 =?utf-8?B?YS9IcWtMd3lGK3NsSnBVandDWmVqWDhaWk4vdTdhY0tZb0xISkcyOGlTK3k5?=
 =?utf-8?B?Sm9BUFM1UkVCRDlJUjZrOVFKUlhDcER2bWFBVFZDNFRxaVZ2am5menFkd2x3?=
 =?utf-8?B?RkJiU2tLWlZabE55OVNHT2xaMUZHRzZRdWlTNU5sREVsS25LS0Y0Q2xTbmFD?=
 =?utf-8?B?Y29tRC9UdHQzODJObFlVMUYvOFArUEtYd3F2cXd3T2IyaDlndlUrWmN1VVND?=
 =?utf-8?B?RWxkdlRoWDJvc1crbTMxY1pyV21FQlJMd25oM2xMa2tzc2NOc0hXR3o5TTBV?=
 =?utf-8?B?aDZ0OVpXTWU0dXhPSmVRNlFBZmZST3B6N2ppWnllUWVDMCtrRENrdkFiK3lt?=
 =?utf-8?B?RzJDNlgzRnNDN0FBbnRvd1ZTVnd2WkpMZlQ2YktCemp6R09GMWgrRjRCdi9G?=
 =?utf-8?B?YktNTnNma0hqc0VJSVMwYUFJbW5uWHd0MEdMQTBDSmNGcG1wZW1heUxIWmo4?=
 =?utf-8?B?Y0ZYaFRuOWZJTnZETmxWWU1BbFpFU29ydmNHdEsvd1hOek9USU85aHozZE5W?=
 =?utf-8?B?eXhVOHdIVWVuRjlTNGRLVktJVmQ2K3hCcG1naWJLcGZoWEZuUFJuYzhSWDRP?=
 =?utf-8?B?MGlKRWhTS1luV0c3cGIxWGhSV3BMVnFLSGhGdWk2KzRLYkNHUjhZT1dTS3A0?=
 =?utf-8?B?bFRzVjd5MkU0UmVhN1ozajg1bjVwS3V1S05Ydm02emVUTlRKc0ljSlZ2MkVL?=
 =?utf-8?B?cWpYL2F3UXdzMUpsWlZjM0l3bVFURVZLVTAyOU9wbmE0OENHbzdBejIxMERl?=
 =?utf-8?Q?bShc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEhDUW1GOXg4bUV2SVIvdmZMNis2d1FxY1lKbnBsU2ZwMGhKdjA4V1Y5anJ3?=
 =?utf-8?B?Y3FZbnVWaG1TVjZBVjdkU1RUVFRmYjFjbkI1eEVjY2tvUjg1b3M5bktxUUps?=
 =?utf-8?B?bnhYL1VkOThOZ3RFam4vVWtRWmhOSU9jV21JZjJhNDlpTU1RWkpzcXc4SHRY?=
 =?utf-8?B?UkZJSDZwVkZjUHdwcFYwaEt1aWVscFhobnVrNmFZVzlpRDlJekFmYTBDZXdu?=
 =?utf-8?B?bWp5LzhTaklUbXgvTDhjOE01dnAyYmR1bFJBejl0RkMvM1EvSURaOTBOWDJ0?=
 =?utf-8?B?ajZxbGdUOTVDSzRlUzdkSytPM1cwVE45OHdNcVRYWjVqU3dlbTJNTFQzQkRo?=
 =?utf-8?B?YlVvSkdYaDhIN24vbmFXcnlPNkx5R3hCdDltWm1hT21pZ3FveDBxbU9QcGNT?=
 =?utf-8?B?L0t4ZnhxNlBDNCttUlpaY21pSmNsTVBsR3AvbGNlYXFiY2k3YW00ZkVhZk1M?=
 =?utf-8?B?Q0ozbEUwS090bjBXa1pvdlprVmdLa0ZUSW5LRXdVV0FWUnZCaXgyd0ovS0F0?=
 =?utf-8?B?aERUai9tc0w4Vjd2SW5CZ2wzdU00RU5xSytxMkhUVGpOOEIzNXFyYjZLUkNC?=
 =?utf-8?B?QVhWWldnOGEwWWhrY1pOK0ZoV1lBZWpjV3A0WnU2WE1qWnVmUm9VZFNyNTF4?=
 =?utf-8?B?dkdhUGpRR09NRmhsZjdXUHRYYm83ZXlKNW1LL1JpL0FEakhZVjVKOXF4NDhy?=
 =?utf-8?B?b2ZUMWNnL00zajZ5SHBOaWNoS1hWdW1WTSt1bzVBU1JLOGdIVG1KZFR0RGMv?=
 =?utf-8?B?ZXhGSUd2Zm1kNGVmMzBuZHliVS9nTkdqaEtNZExFWnRzRWlpNHp6dVFjbUVL?=
 =?utf-8?B?dHpoN0J0RFRpbFpCMVZHK25raHBGaTQ1a29WUkJZdEpJVnhrVlA3cTFNRVlU?=
 =?utf-8?B?WmdTWFEyRHlkdXZkT21oZUNPWFE4OVI1akd5NVdqSCtJdUd3UGg4WW5DVmV0?=
 =?utf-8?B?THcvTEVQU0M2ZXlhUm1wa0xzZGgwcXc3R1FScnlhQnJpZnBwUStNMTRURXZ3?=
 =?utf-8?B?eTFuMDlPeTMyZEVkcm9ZMWNCUXY4MExtMCtOVi9pSS9xdzl1WmU4anYxL0hM?=
 =?utf-8?B?dVBJSW9xVlJFZzVTUDA5NE1qODdwZ2NJYlhiZG1FZ2hQUGdYY0hVU0NVMEFn?=
 =?utf-8?B?TEd3c3ZmakRXQ0pubE5GZlBKeDFMNkJOS2Raa1hVSjhFNk1VWVdJNWV6Mk50?=
 =?utf-8?B?aHA1NTNQcFRWaUU2T0J3Wmg0dDQ3a25CYjQ4T0FXQ0ErU0FYN0pBSkwwVHBF?=
 =?utf-8?B?V09DemJrWDhRZWkvVC8xL1pIUjZyZ1hCNys1VHNicVJPVkxkbUI0WlhhVDVz?=
 =?utf-8?B?VGo3RjM0MkZ4WUJrNXJ1T3lnRklxRU9YM0Znc3dhSWxDNHE1TmprUVRpMGpt?=
 =?utf-8?B?T3dBbDRDbVRic1lZSDArSHpNLzV1c2ZMQ0pUUkFoUUdlVThIcUY0cmJyOElO?=
 =?utf-8?B?MDRxNGNKOGJOUFdDRVpDQzU4UUwwbityc2QxN2xjR2xITWtxa0Y2U3hvRWd6?=
 =?utf-8?B?dXVNWWY5ZFJnMEFWcFMwMDdBZkRkY1VNOVljZnJqR0RSNG5DcTBraU9lQnJw?=
 =?utf-8?B?RDA4cElnN0ZrQTE0S2RwSVlnQVB5M0JlRU5GL0U4WUhORWtrMXNIc2VHekcy?=
 =?utf-8?B?UkR2QmJwZFNuQ0htbmlkeExtTjhuZEY3WGRQUm02bXExL2tPelJnTGVxMHoy?=
 =?utf-8?B?QnFFcG9jSjdYLzZkYkZhMHBzeEZVcmdvS05VRGkwK29WZTl2a0MxeVg0Mndm?=
 =?utf-8?B?NkRnUGI0RjhTSTlZUzRSOVRSaVY5cTRQcVk1TUxxVU9xczUzajl3djJwWHM1?=
 =?utf-8?B?enh0c3dsYXAvbUVkTTRYTldsN0R3QnlhZExhUDJJNkhUNmJDc0tYdXNYSEh6?=
 =?utf-8?B?WUdST1N5dkZoa1Rsd1g2T1VzN2JBaVh2cFAwTndPeWk0SjZxelNubW1aRFB4?=
 =?utf-8?B?R1VFUzU1WEZyYk12MzhESmVoaXVMTEdUdk9nR24wT2pXdmxuNk5RUjZhK09z?=
 =?utf-8?B?djZKQ1FWWE53T1hISzFDZWdscHNPWng0SWlncFpnVUpvOGpyRkZuQmozMDdL?=
 =?utf-8?B?Q0FUam1oNklQMFBuK3F0eGR0akVUUW9yZURRakt0OHVjSkNTSmIvNmZ0RzBD?=
 =?utf-8?B?OThiVnVLZ2dPUlNsMWdrQWV6Q2xZZk1Qd3ZhMS9zenZWYUdyMCtLNmdaSFFC?=
 =?utf-8?B?N3RYUzFxcUl6MExDbnhya3YrZW9jWWJMTTJqaEhlNFZ4QUhBVGc3Z29qNmtP?=
 =?utf-8?B?clloRGlqaVlicFFSZUVJbkNlSEdRemt4YU83aE8xVUZuQmxobGRvbHFuQlR1?=
 =?utf-8?B?LzRJV3M4M2phR0twTVBkYlBmLzhxaUJMVjFNaldiVDZGck1PR1pWVlFFOVox?=
 =?utf-8?Q?whujnfMOuorui4tw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff455a8-4244-4569-2222-08de6093e447
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 06:42:24.0638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4sQVc/ej7O+FySj/zuFsy7Cyvo2AqfHk9MNMUj0aWKPidAnINWYrz3rADUJXtd2/upMs9UPHtZ+3axHYouiMh6+iC0HJD+f+zNPUeBIrsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
X-OriginatorOrg: intel.com

Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Use the slot reset method when resetting the bridge if the bus contains

What about some renames to make this easier to read, because it is
ironic that this says "Use the slot reset method" when the functional
change is to now start using the __pci_reset_slot() method. If I am
reading this "slot reset vs reset slot" conversion correctly.

Something like:

s/__pci_reset_slot/pci_try_masked_slot_reset/

Since it is a conditional reset, and it is masking slot events.

...but pulling that string also means:

s/__pci_reset_bus/pci_try_reset_bus/

> hot plug slots. This fixes spurious hot plug events that are triggered
> by the secondary bus reset that bypasses the slot's detection disabling.
> 
> Resetting a bridge's subordinate bus can be done like this:
> 
>   # echo 1 > /sys/bus/pci/devices/0000:50:01.0/reset_subordinate
> 
> Prior to this patch, an example kernel message may show something like:
> 
>   pcieport 0000:50:01.0: pciehp: Slot(40): Link Down
> 
> With this change, the pciehp driver ignores the link event during the
> reset, so may show this message instead:
> 
>   pcieport 0000:50:01.0: pciehp: Slot(40): Link Down/Up ignored
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/pci-sysfs.c |  3 +-
>  drivers/pci/pci.c       | 70 +++++++++++++++++++++++++++--------------
>  drivers/pci/pci.h       |  2 +-
>  3 files changed, 48 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index c2df915ad2d29..0e1cef1c1c73b 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -553,7 +553,6 @@ static ssize_t reset_subordinate_store(struct device *dev,
>  				const char *buf, size_t count)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct pci_bus *bus = pdev->subordinate;
>  	unsigned long val;
>  
>  	if (!capable(CAP_SYS_ADMIN))
> @@ -563,7 +562,7 @@ static ssize_t reset_subordinate_store(struct device *dev,
>  		return -EINVAL;
>  
>  	if (val) {
> -		int ret = __pci_reset_bus(bus);
> +		int ret = pci_reset_bridge(pdev);
>  
>  		if (ret)
>  			return ret;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 36427fbf7a747..12cf61a9bbeb1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -50,6 +50,7 @@ EXPORT_SYMBOL(pci_pci_problems);
>  unsigned int pci_pm_d3hot_delay;
>  
>  static void pci_pme_list_scan(struct work_struct *work);
> +static int __pci_reset_bridge(struct pci_dev *bridge, bool save);
>  
>  static LIST_HEAD(pci_pme_list);
>  static DEFINE_MUTEX(pci_pme_list_mutex);
> @@ -5419,29 +5420,7 @@ static int pci_bus_reset(struct pci_bus *bus, bool probe)
>   */
>  int pci_bus_error_reset(struct pci_dev *bridge)
>  {
> -	struct pci_bus *bus = bridge->subordinate;
> -	struct pci_slot *slot;
> -
> -	if (!bus)
> -		return -ENOTTY;
> -
> -	mutex_lock(&pci_slot_mutex);
> -	if (list_empty(&bus->slots))
> -		goto bus_reset;
> -
> -	list_for_each_entry(slot, &bus->slots, list)
> -		if (pci_probe_reset_slot(slot))
> -			goto bus_reset;
> -
> -	list_for_each_entry(slot, &bus->slots, list)
> -		if (pci_slot_reset(slot, PCI_RESET_DO_RESET))
> -			goto bus_reset;
> -
> -	mutex_unlock(&pci_slot_mutex);
> -	return 0;
> -bus_reset:
> -	mutex_unlock(&pci_slot_mutex);
> -	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
> +	return __pci_reset_bridge(bridge, false);

Similar to how PCI_RESET_{DO_RESET,PROBE} makes the ambiguous
"true/false" readable, how about adding something like:

#define PCI_SLOT_RESET_MASKED true
#define PCI_SLOT_RESET_UNMASKED false

>  }
>  
>  /**
> @@ -5462,7 +5441,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
>   *
>   * Same as above except return -EAGAIN if the bus cannot be locked
>   */
> -int __pci_reset_bus(struct pci_bus *bus)
> +static int __pci_reset_bus(struct pci_bus *bus)
>  {
>  	int rc;
>  
> @@ -5482,6 +5461,49 @@ int __pci_reset_bus(struct pci_bus *bus)
>  	return rc;
>  }
>  
> +static int __pci_reset_bridge(struct pci_dev *bridge, bool save)
> +{
> +	struct pci_bus *bus = bridge->subordinate;
> +	struct pci_slot *slot;
> +
> +	if (!bus)
> +		return -ENOTTY;
> +
> +	mutex_lock(&pci_slot_mutex);
> +	if (list_empty(&bus->slots))
> +		goto bus_reset;
> +
> +	list_for_each_entry(slot, &bus->slots, list)
> +		if (pci_probe_reset_slot(slot))
> +			goto bus_reset;
> +
> +	list_for_each_entry(slot, &bus->slots, list) {
> +		int ret;
> +
> +		if (save)
> +			ret = __pci_reset_slot(slot);
> +		else
> +			ret = pci_slot_reset(slot, PCI_RESET_DO_RESET);
> +
> +		if (ret)
> +			goto bus_reset;
> +	}
> +
> +	mutex_unlock(&pci_slot_mutex);
> +	return 0;
> +bus_reset:
> +	mutex_unlock(&pci_slot_mutex);
> +
> +	if (save)
> +		return __pci_reset_bus(bus);
> +	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);

Logic looks equivalent in the PCI_SLOT_RESET_UNMASKED case, I think it
wants a comment that it turns into a "try_reset" when
PCI_SLOT_RESET_MASKED...

> +}
> +
> +int pci_reset_bridge(struct pci_dev *bridge)
> +{
> +	return __pci_reset_bridge(bridge, true);
> +}

...and maybe that comment is helped by naming this helper
pci_try_reset_bridge()?

I would want a second opinion on the renames before saying they are
absolutely required.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...note I did not look at anything beyond the claims in the changelog,
like potential unwanted knock-on effect from the new masking.
