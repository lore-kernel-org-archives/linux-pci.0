Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE313D891;
	Tue, 14 Apr 2026 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776178590; cv=fail; b=GryG1FAoJv5sp/U6aBEf0TIzZOu8fP7kmYTYOxK1WBi07JNntmWAs4f4huRl1dS8NUboPQ3X8OTfYTuYeIoN7vOvuBlv8e3VIgcAHdpmFiKG4/ZJ+nVHCblRjBvtB+R8kblGXIvqmes8UizA3W/SUeu6COQkHDEOOkQOC1rXlYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776178590; c=relaxed/simple;
	bh=g0PUrYrPtSh9+5HqkNPD1iQzAwJTlv2IF9Sg95wdRL4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ki5uZ0gTct7OpNCjfiKyRKOFE6dVcY57zn0dL0xbsvOUeF+ByBQ2rtr5kvZge7IU6+tNpKapJciYKkxrec5naMokn6r/+nXg3Ztw8R465Oye8pzyO35h6uiEUgXTP+1Mi3ZXwhc5x4CXDxNK93ARGtQFoS3ltewAQaGSgXpr5A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdtAKfSE; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdtAKfSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776178588; x=1807714588;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g0PUrYrPtSh9+5HqkNPD1iQzAwJTlv2IF9Sg95wdRL4=;
  b=FdtAKfSE5F73/lhA71J2Szr3Fh5j1tHaJarP1hqKAmEML5Jglp1X3grT
   kY6hDlFPkWye9DUHi+6sFDUnQMbuxP29N6EkMcOoBbgqHbpEW4sXYQ0dg
   JTD2Hb8ks1LHWsUoOGYFcS5FmjfBt2hDDLOdqlhw+qWUtl7/S/ZIAFhNB
   4eyEiq8o3zyBetcZp2/ZitEG5uBbpdTV1FaopQuOfhxenM/M8UVAPH3/M
   0PLMNhBsdG8JKejJYSlplI+2EFfrZR5CTjlZJ98C3kA4rrS3z9Z7WqIsd
   IDfTsrr20HhTiDF8R+4Slr4jrQgYow12SQ3gQb44gKNA82AwcXGv7T2Ja
   g==;
X-CSE-ConnectionGUID: ei4twuUmScuqdD8T9FR2zQ==
X-CSE-MsgGUID: 9XNkDFGPRmCFPMW/22lCUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77247046"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77247046"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 07:56:27 -0700
X-CSE-ConnectionGUID: X9wTH4t/QE6liS2/V9a7PQ==
X-CSE-MsgGUID: Y6MAw/X0RNOUpYlJwQK5iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227468960"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 07:56:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 07:56:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 07:56:26 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.14)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 07:56:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgQ50fUoR/ZRmbDr8S97QgFQhr7nvsDR9BxdR1CuDwzrLCOQ1r4za+auX5LP8SPMtKUecGjqikTHIJs8aMQh9P8mpZcNXfgbkavRzmqsCLeVurAIrtor6ivYY05/v4kATLMFxzZDPnlwPNXyc5LSv53hZ+DGFK4j13XQIXvjGt4gQarryA/hvSKedsuy+RwqimpmLRPeUAIH5NAsz3xS1LDIWgr9ez2dKzYeLWYKLJNZkz9kO5IP9f2vMBloxmWgQ/xYFIobqUDRV85hhnxyuvO7PoVU8RozEJqC/QNQjIpC8pUo5+b/XV+v/nBeGEopFUkItg+pblyAgE0si8zQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7+Vr/CdjqIWM6DtexltGbXIRNJIyTHEyrto1WXk7H4=;
 b=oPckhMyyfy9s5MAPUywPbeYN8OICgKWSe9tSXsQWu9A84NWcYzGXE6IcsCscLXuPnH8f8PVX4AjtLm5yiQincQK5O3/PZ3tiH4vWjzFZcwHfEC8tyV77Q3gKUD4XU7w574khCnsFPD76CTjqkX4+htwdWkoPowQ0sf3Y4KpV+75Wn26a8Ep4F0sh2b7kId+WnNyReub3cnjcYwBf+XDQvIt0nzzgeHumnQEF4zay+4sWyefvo7inMLBMZ1769cYSIk2q1qN3oQ6PLz6KsBunJyT7nxkE+SERKxB8bg+jIrV2iU9R5u+RUjn4A/l4le229VbVsLP7rsyt+kSscUr/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20)
 by PH7PR11MB5767.namprd11.prod.outlook.com (2603:10b6:510:13a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 14:56:23 +0000
Received: from CH0PR11MB8168.namprd11.prod.outlook.com
 ([fe80::9549:c8e9:6748:12ee]) by CH0PR11MB8168.namprd11.prod.outlook.com
 ([fe80::9549:c8e9:6748:12ee%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 14:56:23 +0000
Message-ID: <0316ef03-fe70-44af-8d2d-cf119c4c04ed@intel.com>
Date: Tue, 14 Apr 2026 07:56:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 1/2] idpf: remove conditonal MBX deinit from
 idpf_vc_core_deinit()
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Bhat, Jay" <jay.bhat@intel.com>, "Barrera,
 Ivan D" <ivan.d.barrera@intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, "decot@google.com" <decot@google.com>,
	"willemb@google.com" <willemb@google.com>, "sheenamo@google.com"
	<sheenamo@google.com>, "lukas@wunner.de" <lukas@wunner.de>
References: <20260414031631.2107-1-emil.s.tantilov@intel.com>
 <20260414031631.2107-2-emil.s.tantilov@intel.com>
 <IA3PR11MB8986EDBC27D4267AA0F48BFBE5252@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <IA3PR11MB8986EDBC27D4267AA0F48BFBE5252@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:303:dd::26) To CH0PR11MB8168.namprd11.prod.outlook.com
 (2603:10b6:610:186::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8168:EE_|PH7PR11MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: fd61b68a-38f6-4bfb-b698-08de9a35fea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|18096099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: sA6Fm1AcllmQtKx+mepM4EE9+3nJOrZUjHJZ7r8kfsy8qWLHIy9dPXSdjH7hvCCWdHyDGoIH8PUBpbS0ihN1P6rPNNynGFRCQ8JNFeJF6wNLqVCmJLJ5tL+BFPMFpbmpfdGguRGV6pcHBnhRLXQjJVZvw48XWL//HHkGAz3Ffo2j+byjMbaWAuBQqMRr0bVY8BGC4yLg/2z1JQhWym4rL41EmT8mHpeu2Q27t05DTVLKG/8WpboQABkLdEVzJUpRkzLDCO0Y4YC+XAcvSE/utNiqZNTB9haqOM5Qb1GzEw8EJd6/6X8tpi8kifUVi5zCoYhbZ9cA3e30qFOWGWV6fcl3mi6K447SgWq3rCzo+1jBaV+YQmI2OgeNsMmBLGniH5ER32zLgllDi+fRqNgNEP3Kc9mhyqxErli/Spz3B1Bp7hXXqOtabtOCBpjAFbBessmMMesXZBzuNLq+KKyyhydXMR+/jjVZx9RK1y93108BPoQI1fqW9VZBTv90chpvGZDOcYu+p/sExt9RKsQ3Va8SIIp9BEIHNjdzseOgeByeygnjPeF0znEFVVwhYHwzkavrKRudwfq6/cuSm09oD90iR/I73XgchYPwGfeg/1QDF7OIDrnS2sAgCkRJUkxatmdTKB7oKt5ZutKX5N5fhvjbL2xVI9Ab59gLY9F7MNh0aoFMSPn01Oa1XJtvQGwbyKgLZ7YRCslJ6YUE3TN7dwTlLmMQxFG0hAZSYek7Y2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8168.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(18096099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVlMlBoaUI2S2pwVXpHSm9QbzJ6WSs5ZlYvUFUxRmgxb1pEWStkSFJHZDR2?=
 =?utf-8?B?ejJpN3BxVEVLL2JjMGNIWUxkRGJLM1ZSOU5zRmxvTE5JazdrdHBpajM0SVc4?=
 =?utf-8?B?eENVbERKWDdhYjJaKzFicVU4dWFRV2dtcjloa0JDTnlEcnVQK0RwSjQ3NDFm?=
 =?utf-8?B?eVdpRVN0TitLS0cvS3RYRDRnYjZUM0pmSmNZZGIwbllWMlJkVEg2N0thbnlV?=
 =?utf-8?B?eEJDVHNqRlNGamZmWjR5anNTcHROV05RU0liSnl0QjlqVHVIMVQ4UzQ3bVZ0?=
 =?utf-8?B?ZWdQUkFyYnpyeHlnTkZMTW9DTU1DdXRkT0lMTDE4RkltQ2pHRUxFMDV4bnEv?=
 =?utf-8?B?UU5haGozRDdhVjFYSTRBcjBXNkNvR0JPcUQ5cExobGdDRUV2N3IvSWgzekpu?=
 =?utf-8?B?bDNqWFlMTVFTTGM1RmM0blpsVnJ3WEpNbldvb0dTK0p6enFlNndBdE04cUd6?=
 =?utf-8?B?WENKeU1lclhXNVV6T2s5dVp4VjFqYjRlMmowRk5PVzA1cjk0U1cxbFE5bnNw?=
 =?utf-8?B?NTc4bjlLcHoyeWM5MjlOYzJxNkxod0lZM2kxVWdTT3NXZEIvaW55aVhYc3h0?=
 =?utf-8?B?alhiWSt4SksvcGt6MDg4U0cydHJ2dnpEajl2dkdnWDdhQWo3cU15UlNaa2w2?=
 =?utf-8?B?V1JYQzBrWWhnOUdqODRBOG14aXpNRUFXenNBNXo3b2lFei96TTdzaGVIQjc1?=
 =?utf-8?B?NW0vZ3VjUW9aanZTNjBxZTRIbEQrTWFCOXNZcEx3S1VGZ0dDeDY0RUJkQ1Mw?=
 =?utf-8?B?eTcyQVFQb2JwY0djWm5rbFJlV0k5elBleXYwNUxIanlVRVdwaStGVHZvZ1RZ?=
 =?utf-8?B?ZGZqT3NSTjVBaDJBeG5vV3FaODhWbmd6azVwMm5RVFF1VzdUNG5hRTBtVHM4?=
 =?utf-8?B?K1ZMVk9rQlpqRU5lRW40U2xGc3NQMTQ5OUJKNjYzd0R0VmsyRWhmaFpGUCt1?=
 =?utf-8?B?R2phbFF0ZG9VdzdwbWlXYnI2RUVqTk1jaEd6dE9CUU9jY0FZaGZyblYxL3F2?=
 =?utf-8?B?d2prL0Z3dzZmSjNJY3loZ2gwcWlYY2QzcTUzZzlMWG5JdUgyRFREdFFuUHU5?=
 =?utf-8?B?RHlrc2tMMnVKWEF4SVBpMnp5b010cW91M1QwMnNnUlRvTlEzN01sRzFIakJX?=
 =?utf-8?B?TGJscGZabGhBUGl3NjlHQngxUHVnalo4SE1YK1lFT0VlSVNScDVTL20vajcz?=
 =?utf-8?B?QXFmMVp1Ykk5WEJra2c2UDZ0QnVhMTBNRHpkcXF0MDhIZ3lXbDFYSXJFQVBi?=
 =?utf-8?B?VlI1dG9EVHM4ZlorTGFsRmZlK3pGYUtLMS9ZckRyYks2REdwcGk5Q3YxdjJL?=
 =?utf-8?B?cWs3azQyNmdHVDJ2WWh2N3I5K2Jha01LcGROSDdPYk44b1llUm1WbVZnTFhL?=
 =?utf-8?B?U3JEeVFpcE56eGxlMTNDcU9QMjNJcFRMbGdEMGJIVlVCd3J4UXFnVVpYaFd5?=
 =?utf-8?B?ZHlMQlpwQjJSRU5nY2Qzdzl5SW1Sa3drbmh2YUlsNnJ1RWxKNER1bklNanZr?=
 =?utf-8?B?eTh4YjBibWs3bDk5aWkzNkVNaGQzMFpRUXBDcS9LR3FRVytsTGtWTTRuSkw1?=
 =?utf-8?B?Q09mSlY0c25qSmpROFpTSTNBWUtIL0N6UXJkLzZBaDd4c3E0UFY5bmE1Qmoz?=
 =?utf-8?B?R1JqUGhRRktoUkc5QytweGFjYmh6ajNEZzJWSVg3cDQvSjQ0Yi9YMTFUNjh4?=
 =?utf-8?B?SFQwb0Nzb1plcjl0TUd2YUdyWmo2QmZIa2ZWeWZSUkJTQW40UWJzZ1RhYnh0?=
 =?utf-8?B?VkJHejBwamNJUWt1VG5oZFRDZjdQYUh2dUVMb1hKdjlldXhJT0lZVFRpQ1hn?=
 =?utf-8?B?OUlVc0N5NlZxV0dPOVBsOWIrSEFRUzdMMEZHVXpTNXlMWVlOeEFSYWpwWlNu?=
 =?utf-8?B?QTZyV1d6R0NkK3dscWlVSnZoMVBXdHhjdTZOL1Fmd2dQSmFjeDJtbk1HWWJk?=
 =?utf-8?B?UWRqdlVURzJJam81aDZxbjRURFhZM05ucjJQV3VFU2ZnR1pTMG5PR2lFdnIx?=
 =?utf-8?B?bUd4anhTY1ljaktIOFJCb2JmZU1VSGxWaXBDVmJvUm40VTRXbjVxc2xJT09X?=
 =?utf-8?B?eTJnTkg3YXM5QmJ6MVhvWHhvQlVxL3dDVWVodHU4ZE8zR3Z4dW9SUC9ReEhD?=
 =?utf-8?B?Qi9UNlMzSHhTclhWMXEyTDBSMXR2WDJ2VStkRSsyUlVlWkUrbkhHeVNmV0pR?=
 =?utf-8?B?WEFEVWM0eEhRY3J2Z3ZOMTJtK084QXU2aGNrT0FiUllEY0F0RlZGWjdyYldN?=
 =?utf-8?B?UUJ6Ylp6dmZrWlVETmF2cEE2RXFNcGNlcS9MKzkrUFFERk01dHhXRHNFWStn?=
 =?utf-8?B?bnFPOG9jRmVYN2NaNDUrNGYzckxKcExoY1JqU2RPdkpSVk5tdXl5RGhTUGRk?=
 =?utf-8?Q?cm5GSWMwBkuKr+Sc=3D?=
X-Exchange-RoutingPolicyChecked: OSjwR8SGvnQXd+O9KfHlcG07iekGKhUIOXr38d5tcTXNBP5Rpb7hM/2OFQ5wP9895UW4mRmRPgpbevtWCYv+WSvcuDKlGrqt7cQVYOWMyKoT546ADi8k0OEkXVUWGWFKsTjXqwTxtwAl9+tWCx99pWt5EpRojPXbh9NFCQ6y6KOkp3auerDRDIM7K1yv1WDCcz7BsO7BBZrrwBKbU5TzV63aerUcp5JSYbDIpU7R+rKNX54pvGAob6x2JrJ6JYEo66H/p2qo25fCBIusbWEyimDJu5bTUfk70QdTYYBC0Rq8QeFc5Hyu7e0yv966GzqPTEKY/jbtgLUd1UTrAVPoRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fd61b68a-38f6-4bfb-b698-08de9a35fea7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8168.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 14:56:23.2367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9OUMPAvHr4G1K7UMsEovBR6QRfDRWJ5oQA2MVjXESwunUu2OWR/3bSA67BkhCy1/bcVEFq95sP0o1ULDbTumSTr23lUf35vVt29oZGz/rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5767
X-OriginatorOrg: intel.com



On 4/14/2026 4:07 AM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Tantilov, Emil S <emil.s.tantilov@intel.com>
>> Sent: Tuesday, April 14, 2026 5:17 AM
>> To: intel-wired-lan@lists.osuosl.org
>> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Bhat, Jay <jay.bhat@intel.com>;
>> Barrera, Ivan D <ivan.d.barrera@intel.com>; Loktionov, Aleksandr
>> <aleksandr.loktionov@intel.com>; Zaremba, Larysa
>> <larysa.zaremba@intel.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; andrew+netdev@lunn.ch;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com; Lobakin, Aleksander <aleksander.lobakin@intel.com>;
>> linux-pci@vger.kernel.org; Chittim, Madhu <madhu.chittim@intel.com>;
>> decot@google.com; willemb@google.com; sheenamo@google.com;
>> lukas@wunner.de
>> Subject: [PATCH iwl-next v2 1/2] idpf: remove conditonal MBX deinit
>> from idpf_vc_core_deinit()
> "conditional" -> "conditional"

Doh. I will make sure it is corrected.

> 
> Everything else looks fine
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thanks,
Emil

> 
>>
>> Previously it was assumed that idpf_vc_core_deinit() is always being
>> called during reset handling, with remove being an exception. Ideally
>> the driver needs to communicate the changes to FW in all instances
>> where the MBX is not already disabled. Remove the remove_in_prog check
>> from
>> idpf_vc_core_deinit() as the MBX was already disabled while handling
>> the reset via libie_ctlq_xn_shutdown() by the service task. This is
>> also needed by the following patch, introducing PCI callbacks support.
>>
>> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
>> Reviewed-by: Jay Bhat <jay.bhat@intel.com>
>> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
>> ---
>>   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 11 +----------
>>   1 file changed, 1 insertion(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
>> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
>> index 129c8f6b0faa..fceaf3ec1cd4 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
>> @@ -3229,24 +3229,15 @@ int idpf_vc_core_init(struct idpf_adapter
>> *adapter)
>>    */
>>   void idpf_vc_core_deinit(struct idpf_adapter *adapter)  {
>> -	bool remove_in_prog;
>> -
>>   	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
>>   		return;
>>
>> -	/* Avoid transaction timeouts when called during reset */
>> -	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
>> -	if (!remove_in_prog)
>> -		idpf_deinit_dflt_mbx(adapter);
>> -
>>   	idpf_ptp_release(adapter);
>>   	idpf_deinit_task(adapter);
>>   	idpf_idc_deinit_core_aux_device(adapter);
>>   	idpf_rel_rx_pt_lkup(adapter);
>>   	idpf_intr_rel(adapter);
>> -
>> -	if (remove_in_prog)
>> -		idpf_deinit_dflt_mbx(adapter);
>> +	idpf_deinit_dflt_mbx(adapter);
>>
>>   	cancel_delayed_work_sync(&adapter->serv_task);
>>
>> --
>> 2.37.3
> 

