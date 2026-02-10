Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69F165F16
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770761041; cv=fail; b=uLPUExB4eKrj+aLAOxfbXepCTlLDi6tWU+w/HK4S5tRxty56v+qczQ/BtJWizjtD/EK5E7Qbq7A1uktps8Nwaki+FplyJsEybOd++9uyGVxdRb8jJDbiERcu/Xux2Hr7Sxhnn6BqW3RKpE9rPxwaAP6H9XK3f5MQYTBW0lX424s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770761041; c=relaxed/simple;
	bh=HM1Gh5dgeDCztdNlsDNgGEqm8+eqqfk53TBEUGFAnmI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fucWXIOeA5hCQKvvA5qX4jqp2RMFrPBvC8Zdye5eQko90th7tQrVhUrsMz79w0kOn22WJBHD8XgPVh622ZzQFr09A2y73FxsSkFnrCwG+PnfLFjQuqku894kYhL8WuEplCfgM8YD/K2hBdRaoh96T7ZiA57Sn+/8w7/IlHXZf9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fd8jaOKn; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fd8jaOKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770761040; x=1802297040;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=HM1Gh5dgeDCztdNlsDNgGEqm8+eqqfk53TBEUGFAnmI=;
  b=Fd8jaOKnorLKiyRZLRxFMYL4ZgPKywB1fBw2keAKsaO/QnS/RNJWNqwN
   p4d1lXJ8BbPbd3QpPnFvbKVgK1Ey8WWD7b1GMSzoxI11Rj2eSog4E5SnF
   /UERLRWB1NkNVjdYAW+Ql4qmy371ve1u4zgIeuX6ai//H27pmuTGy2wV1
   zskbvyh/2N2/Lfv7rULOCcbUZ+3t8rIsAFTJGaLv3866eoMRMtcdGmHiH
   +XSyDh1hGMBiOgpt0v4zuKYxkJqhiDXt62fGMb3KpPS5gHksWk8CcZWhS
   Xb1+VPTw8KNJ1OrHoTBQhH5l6UpY5iBPQ31xPkimEo99uEpLt1j+R1k3h
   w==;
X-CSE-ConnectionGUID: pc0/50pXT0aIKjumB8LVMQ==
X-CSE-MsgGUID: 9pjjUQRgS7y1XeDHqgno7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71889597"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71889597"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 14:04:00 -0800
X-CSE-ConnectionGUID: fSIt9O2uQl2GfeSf2dEi0w==
X-CSE-MsgGUID: pmCxS3OURweQsxh3bD0jiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211497508"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 14:04:00 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 14:03:59 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 14:03:59 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 14:03:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Au/4pcrlK866DgoqoTYsQuOCujjvF3UBxIYNenYeMYHTHac9MsCgdepFwKZ6V8mIfWIf1QzKlZYlGK49hvLsVS1ESuBL707QEmLsMf9rvQatkojPLDNjkD93YeD+1x1XehZpdAO717XtZrIBL/0uiIg+D0NTQT45s31gkzFMa+UV0mxt0ylijGNDZJVCb4tYE9ntca4HgqF16KsGfPGOwx7PqwYiFM3KVtuc1x0CIruT5AzNALvtzBwiP/+UkLnWBoLT9yVRoYSFCwzwEZ3whAEgNj3gJdT3s5E19ArdzmPYMB8IJJ66hbb1mdjvhwtrFseDjH8hZT9NPj3IFSJfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tp9IBo0Fvcq62Zj1ge3yjsGrMIps7zGK2BG4iX+Y9cg=;
 b=JLk75sslt3nJMhLtnnGGUKKZCA2VzxwI3d/CCtN24NQWqKAwDDsUMxPY6ykZ2mfhI98Bcnl1V3eXXffNfYfEsJfn5fprm1CHwD7OYbQs75KkaqhcLZUenMF/Lqh5YamkW3JfpVfKZIuoM1T4f0g/xR5bPoodKslzIogVK10w0hIpWrhPL/1jVlHYIAm6uhVEXIIlQU7BOOgO8lIVZWxFjpz8UwiOUua/uyIUsursXsOz8S3RznI+Y0mH/xfxvH0ZRteFW3EcK0fwgz6AuQNL/tejRWAPfUMiiJmz7ol15jc4mtuYnHl1sQRmSPsh4bN2XdTQAlE2HoFHzoJbVAFFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BY1PR11MB8077.namprd11.prod.outlook.com (2603:10b6:a03:527::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 22:03:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 22:03:56 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 10 Feb 2026 14:03:54 -0800
To: Keith Busch <kbusch@meta.com>, <linux-pci@vger.kernel.org>,
	<helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
	<guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>, Keith Busch
	<kbusch@kernel.org>
Message-ID: <698bab4a7cf16_2e57100bc@dwillia2-mobl4.notmuch>
In-Reply-To: <20260205212533.1512153-4-kbusch@meta.com>
References: <20260205212533.1512153-1-kbusch@meta.com>
 <20260205212533.1512153-4-kbusch@meta.com>
Subject: Re: [PATCHv3 3/4] pci: remove slot specific lock/unlock and
 save/restore
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BY1PR11MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: ea24b51f-7a5c-495e-28fb-08de68f04975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nmk3TzlRZXRURW9JOG9kdU11ZndWQmN0c1U4ZVpVWWtJdzJ6RmJtTFBsdG9r?=
 =?utf-8?B?M25ucWw1bi9BdWdmaXY5RDRXUC93ZEprT0tpM0MxSWRPV0hOaGZqZVJyN0Zk?=
 =?utf-8?B?VTd3VndBRktXekhnZDBZbVJ6WksvZk9yd0xrMmpESlpGbWwybk43QmlFdHNo?=
 =?utf-8?B?Q1dicmJnYkRzQVhhaExqbW5kNXEreFA3bm9iS2JLS3lja09KY3pQTnFyYVEx?=
 =?utf-8?B?YjRzTGVVU1NhOGt5MFlLOVJsTzM3cHlpZ3A3N1JDVUZKdHQ2UWdMVDVUc2hs?=
 =?utf-8?B?MXlFTXE5RVZacUFtQ0xPSjB5eW05R0dQMVpnMElFNjVqNktrZ2FUK2QvdVZo?=
 =?utf-8?B?YWcvUkRKZ3dSN1BYZDQ3bUo0UFE4UWJmQm5YL1JEOHhGT3Ruejh4dmdGYlJG?=
 =?utf-8?B?anR3N21lZkx5UXN0b0s2UW1KY1diMzdkQVEraHdEcjBQR1RPdDFVUWtmRlds?=
 =?utf-8?B?UXBSM3pxL1Jzbmk3bXRWdE5Ic3VUWW1WZEgzdm80ZENERE4rZXdtcnp6N2lB?=
 =?utf-8?B?TUlUS2R2cExVektOb2dZTUs4dXcvVkQvSFBFTzBDWHdhSGE2UjJuYXRoakJC?=
 =?utf-8?B?VHB4ejJySkkrL1ZycU1hKy9vYWZRQnJFMXkyTndxb0R5NVJhUlFKZnRhNFFN?=
 =?utf-8?B?aHhUZE5IdHJsWGEzdTRaSEg0OEh6bXhqTnphNHBhaVJqblJUcnNrT1BLeWdX?=
 =?utf-8?B?T2U3eXFqdUlVZURVV2xwQk9DZDNobXowWDNMQm1uWVEwSUNwOS83bE8xSVRs?=
 =?utf-8?B?aTVhMUhja05HVTJ4dzIzajJBcStBakNSUHZEQWI3bExKK1RvczVPS3p3eE9V?=
 =?utf-8?B?eks1bFZndXR1NWwyOTVTaXBNdm1DMmlBbFZXREtMaEhScmlFakdKV2FBenZv?=
 =?utf-8?B?elI0SUE5USs5OGc4cE8yZ0ZMNFhJd2xCRWpKUzdCcUxlSDU1TldmSDUzN0lK?=
 =?utf-8?B?RGd2SWFhTnY2dGM1Z0JVMitMb0dLWVR3Q2VzUk16eFpPeG9uSlpjUHlzYVRX?=
 =?utf-8?B?K0JhQ2RSRjBJb0tGS1NTY3dSWXQ2WVNrRHZJaEV1Nmw4RnFQVFlyMUxNLzBT?=
 =?utf-8?B?eHg5S3lXZ3EyYkRiRXNRR0pvN3c3REhrSUkyWktGV1E0d044QmFxL0NCUWsx?=
 =?utf-8?B?eWNpK1FBSXNXQlgyYjc4Sk04K0ZzY29qdHhHTWV6SXpGOVdkM09KdTNpL0Mz?=
 =?utf-8?B?aGZodkUvZGpHMHE1TEYrbER0cDVnSkZ1eHdSRjJIVW9JZzh4N3FpN3Q2SmFK?=
 =?utf-8?B?SDhRM1lGdG5rRHBxU1pBNksyYzVlclNNZDl4OXQveEZRaXVzeE1xdlIwQ3hx?=
 =?utf-8?B?TFFETzgrS3FYVTJvMWlyQktxdUpPbGNBeUk1bmtHTkkveE4rTmdZdCt2Mkll?=
 =?utf-8?B?SUJvQzlDTG9Cam9ZRFhxNm1xMklsWnFYZE1tand4VzFDUmZDNTFEeGIwV2NG?=
 =?utf-8?B?b216ZVZ1UWdkU3JzdTdOWGJmUlhRK0o5dDg4YndpTGdVeDYzUVpwL295NXZj?=
 =?utf-8?B?elB3aVFLOUJ0QmdWd2p3WmV6Sk1aOWFqbTd0Y3dGdVNYRXNNalNhZUhjaE4z?=
 =?utf-8?B?eTRLdnRZSElib1VOdXhwcGE4djFDbjR4RDlrSndWRWR4VnVxMDNreXNQMnJM?=
 =?utf-8?B?N0ZqVWpBYkNEVmlQT1BPVFJwYXlyZ2Z5eHA1ZFJmRWR6R2JEd1hXQWUwbldm?=
 =?utf-8?B?TjlCTWJMc3NDbU5zS0xBbTFxSVQrWkFqYUxObnluMG1VamhQVkZvdDhWK3RN?=
 =?utf-8?B?VlZjUW4vbXJZaGNnK09EbXJIU005MVlXc3NTYytYWWtmSjh5VzI5SmsrZ3hS?=
 =?utf-8?B?WjJJSjJudUV2bEhtMVRpaGJvR0loUHBTc29FUytneDhoL2ordUNnZ0UyNXpN?=
 =?utf-8?B?TTVQYkhrZm8zK2ZMSVVPb1E2ZmYyMFFTbllsYmNmVjJqWmg3Y000bStwT29L?=
 =?utf-8?B?Umt1OG8zdmFhWFVOU0VnYXVhZ1MvTzhIek16LzRPNE0vanVCVSt1bTRobzVW?=
 =?utf-8?B?SlVRcHVxa3hjMkFoc1hXQU84UnhMeGpHNkdMQ3J2QUtRTWgvL2tkTFFscnJr?=
 =?utf-8?B?aC81NXBuK2pmQnBQZVNCVkhiTlAyMElpemRmaG1KaTNiY0xWM3BCZFRGb1BB?=
 =?utf-8?Q?Y9qU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTBiclN6UHc4UEx3d2ZWb3RjdzFnVTVsSGpQZmtTaVpRSEE3Q0xneUZWVUpv?=
 =?utf-8?B?OU9IcnV6NXNNMXdXcFRQZUhpeUV3am4xLzNRZVljamtzWHBuQUNabTlWcWl3?=
 =?utf-8?B?YjJEakNpNWIvWHcrTlhBaHdYK215ODgzODJpbEhDUEE1VGtSbkNsQ0c4OGpW?=
 =?utf-8?B?MzRhUW9JbmJVRGYxdThHS3BpOE1GRlVoRTF4ZFNyZ1hEbXFYNkFOTVhVb0xi?=
 =?utf-8?B?SXprdGU4VXFtb3Qxb3BaZVYrb3FMRkhtNis4eGtRVWltYVhLaWdFNzVVaWZh?=
 =?utf-8?B?aDE1SzVhdi9xUDNEU2U0NFc0bGpQT1NpOHNOeDdFWER2bE84dDgwVDlUZHRS?=
 =?utf-8?B?N2dnUkxuZnNUci9sK2pMNTJ1WTJmcTFiKzV2eHh1WnA5SWdLSHNlNU8xSXRJ?=
 =?utf-8?B?Q1NaUFYxSytnMUxTUFA5MjczeVZLa0d5U1Z1UE5raS9aNlkvYUxJeWlJQUdh?=
 =?utf-8?B?Qk9yL0ljSEFVbyt0Y2F4QWdjcGNrdUhacGVPWGRkMmJhNmdpdllkSVZkejdT?=
 =?utf-8?B?ckhScjlRY0F1TzlxWlduZFg4a3lid3F0bTZHNk1Xd2doRWthV3Vod2VSMWJt?=
 =?utf-8?B?bzB3eTNaNUxpQnhyWGtBczBSREJXeWd1Q1JYcVpGdVBSU3ZqQ2lKdWVQL1Er?=
 =?utf-8?B?UmNjOUFJOXZTcktWQVZFVENzT1Zpc0Y0di9PVklybEUzUWo3bE5pajhJcnVy?=
 =?utf-8?B?cDVBNnBBWitha0JPa1F2Z1ZTSnJJaEgyZHJZOU9lV1poWmZhTnQwRFlrTDRF?=
 =?utf-8?B?ZHJwaHRNYnF3L2gvY1FtTHJlV2NsUStHdW1DeTZNS2hzY0dwRy9tNi8wOXZU?=
 =?utf-8?B?V011OUxUVHJIL2MzMm1zQXJnZEhuWEpzME96MHJYM3AvOS9iTGU4UU9PRDVa?=
 =?utf-8?B?MjBJY2ZPYlAwVnBCeU1Hbi9qWmlVcEFPRnZtVzY1Q3UyS3pGZUZ2Qk5RTk9H?=
 =?utf-8?B?UC9UVGxpdmwyMmUwRWVFZU1DazA2cjVBUWJnOUNycGdXVGwwZXlaZGxIN3pE?=
 =?utf-8?B?WDVEOGtLeXFYTHJyRFVXZGkxMk94OTZEeEdra002QkMrYVdmeGd6ZDFaZ1Z6?=
 =?utf-8?B?bEJWTWg0ajhZeXk1OUdHSUlnS0xGd2c5M2JiTDRFRGhTUHYvQWFRT3ByTkVM?=
 =?utf-8?B?RUJGMkhqb0YrWlFPY0ZCaHM3aGVyUGNNQ0M3QVVsMkVEMkJTRE1GTjFXdEVs?=
 =?utf-8?B?SVdSQWlVWVNGOUJJK0RweHJNRkFEdjZ1VDd3cVJRSGNpbWNvOXVHKytOZ2NB?=
 =?utf-8?B?Y3dOaUhxVWV2aHRPZFdtbTRJdHJ6MG5iOVYzbzE0WENZZGdTam9OV1FGK1Jp?=
 =?utf-8?B?N21ENjYxNnJ0aUF5YmtQLzI2WDJ0eENhazUvRmwwbytWbUpKaWlWdHN4bGw1?=
 =?utf-8?B?Q1N3enFSbFYxZHlWdlVHcllva2VnNGlLWGhnaS85TDZSYkZZWEdJVGJXMS9U?=
 =?utf-8?B?STFlQ3Erci9rVSt1YzVxdmV2eGxiRUM2VU9QMDZaTm9GNHdRZWlIa0ZXOEQx?=
 =?utf-8?B?bXhzSUFtdHdSOWl2U1FzY2hTM3BLTGRaUmpLMERnZUFOTWgwTll2RENmK2Ns?=
 =?utf-8?B?VjhSeU1NaG9sblVvSnEwSncwVkM4WCtac1JkTEhiNDhyaEJrcWdiVWx5Mlpr?=
 =?utf-8?B?a1hDdnlmWDlmWk42TDZjZUE0TzR5a3MxWU1TS0ZWc2NYVnBlU0JyWmxvT2FX?=
 =?utf-8?B?RjVOblo0VWxCMUVwbW9od2Z0V0xvTDdEbDQ5blZWRGltYWJxaGRxRjdmQjMw?=
 =?utf-8?B?QzZSOFdGb3Vwdi8wTExtcS8yaERwRDgrc1ppVFNGY0M4Q2dyaGNwRk9uVHFy?=
 =?utf-8?B?U3h3bzYwNzhVSUdZZXh2ekQrZGRpdUhhYk0xSjMzRk8vMFhITXVVcWFrVm9j?=
 =?utf-8?B?UVJjQjdpTlZxUStZK1ZXSnNSbkpNRU4ySk4vcTBOdWM0QXdkSkRJaFNDMzVX?=
 =?utf-8?B?UXZGMzhEZUNIYU5XOHJ1eFFuT2oySjROU2NLN0pSSHpDTUFUdmhFd0tXRWNF?=
 =?utf-8?B?c2JTWjlQd0pDdEV4d2pkdmpabmlnSW13Q3FseVBXSGs0OEoyc0FYQmUzNTc3?=
 =?utf-8?B?TytyWktNbitmNzVNUG5tN2tiN0ttckp5anpka1NPMWhMc1kwRjY4UnNCUHZ6?=
 =?utf-8?B?eGlHMlloUWJRM0ZvUTVLbzdVanZ1RzhWOVB6blpUK3R6b0VOZDJoZm13MnFa?=
 =?utf-8?B?VE5kOGhxUUU0QU9pa2xXY0dKQ1dQT3dVc28rMlZ2NUZnMVdjK0xReXgreC93?=
 =?utf-8?B?U3J4ZHlHMzVPQ29iTWIrUFJsSEc1R2ZVK0tKdG43dG1CcnR1TGpHNlpkVnJr?=
 =?utf-8?B?WkE4QVlQMG9hMldMdkUyaW9jcXhHcmdZQjhLdU15MnZ0L0h6NTVJcjdDdWh2?=
 =?utf-8?Q?bXnKJ5pB8PYFPMSs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea24b51f-7a5c-495e-28fb-08de68f04975
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 22:03:56.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zNa3gbL7qcpmBSIrlr3zbIBBVUsyC49zsz0otBG/DIwKZYrSInJQhiTJ8WwqcPOqEozRZF2AQdxzC117TZmwxEzab5p+lJEaXx3hn9KD3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8077
X-OriginatorOrg: intel.com

Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The Linux pci driver resolves a "slot" to the "D" in the B:D.f (see
> PCI_SLOT()). A pcie "slot reset" is a secondary bus reset, which affects

Maybe change "pci" and "pcie" to "pciehp" above to make it clear this problem is
specific to the native PCIe hotplug driver?

> every function on every "D", not just the ones with a matching "slot".
> The slot lock/unlock and save/restore functions, however, are only
> handling a subset of the functions, breaking the rest.
> 
> ARI devices with more than 8 functions fail because their state is not
> properly handled, nor is the attached driver notified of the reset. In
> the best case, the device will appear unresponsive to the driver,
> resulting in unexpected errors. A worse possibility may panic the kernel
> if in flight transactions trigger hardware reported errors like this
> real observation:
> 
>   vfio-pci 0000:01:00.0: resetting
>   vfio-pci 0000:01:00.0: reset done
>   {1}[Hardware Error]:  Error 1, type: fatal
>   {1}[Hardware Error]:   section_type: PCIe error
>   {1}[Hardware Error]:   port_type: 0, PCIe end point
>   {1}[Hardware Error]:   version: 0.2
>   {1}[Hardware Error]:   command: 0x0140, status: 0x0010
>   {1}[Hardware Error]:   device_id: 0000:01:01.0
>   {1}[Hardware Error]:   slot: 0
>   {1}[Hardware Error]:   secondary_bus: 0x00
>   {1}[Hardware Error]:   vendor_id: 0x1d9b, device_id: 0x0207
>   {1}[Hardware Error]:   class_code: 020000
>   {1}[Hardware Error]:   bridge: secondary_status: 0x0000, control: 0x0000
>   {1}[Hardware Error]:   aer_cor_status: 0x00008000, aer_cor_mask: 0x00002000
>   {1}[Hardware Error]:   aer_uncor_status: 0x00010000, aer_uncor_mask: 0x00100000
>   {1}[Hardware Error]:   aer_uncor_severity: 0x006f6030
>   {1}[Hardware Error]:   TLP Header: 0a412800 00192080 60000004 00000004
>   GHES: Fatal hardware error but panic disabled
>   Kernel panic - not syncing: GHES: Fatal hardware error
> 
> Fix this by properly locking and notifying the entire affected bus
> topology, not just specific matching slots. For architectures that
> support "slot" specific resets, this patch potentially introduces an
> insignificant amount of overhead, but is otherwise harmless.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/pci.c | 147 ++++------------------------------------------
>  1 file changed, 11 insertions(+), 136 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e00af20ea7376..df9ed73dad416 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[..]
> @@ -5489,25 +5363,26 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
>   * wrap the bus reset to avoid spurious slot related events such as hotplug.
>   * Generally a slot reset should be attempted before a bus reset.  All of the
>   * function of the slot and any subordinate buses behind the slot are reset
> - * through this function.  PCI config space of all devices in the slot and
> - * behind the slot is saved before and restored after reset.
> + * through this function.  PCI config space of all devices below the slot bus
> + * are saved before and restored after reset.
>   *
>   * Same as above except return -EAGAIN if the slot cannot be locked
>   */
>  static int pci_try_reset_slot(struct pci_slot *slot)
>  {
> +	struct pci_bus *bus = slot->bus;

Might ->bus be NULL here?

With that clarified / handled you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
