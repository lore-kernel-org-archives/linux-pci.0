Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10134137BC
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766985; cv=fail; b=kB3DAoksePVjl5IwU0b+IeOO8Q9rDBEMv0DzxieyK/evM35fD3HFckzHvYsk5dm73CDsXHAjAeOV4CaujoMrUkT2Xa/hwDAPi2aTJbRSPMm5qXDKa6Txc78iMt7wh73iWHprgCsWJePelhRmPoseOg0XHNkBXXh9pcxB+ccQAm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766985; c=relaxed/simple;
	bh=wszbTVHAVMf8lbwm+ns3KXELS20+77ZHwblq+h1032M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ky4h4onbnKbu9P18ojlm1yUx5mpYnL1Phofjgix+JZlex8JBfxkSSzLGnlrOBpCLFAoO8zR7wLvnr+f8mzcuJr2GRXFt+9QJRtue4I1JeNveXIMxqQtdvwPVxcJHsGjuCuELFaPCesSOS/3N4ajhECYDl1S/O1On1SRBWTxzjUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyPav5Go; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyPav5Go"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785766982; x=1817302982;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wszbTVHAVMf8lbwm+ns3KXELS20+77ZHwblq+h1032M=;
  b=AyPav5GoY41OtcTJv+S7M5Xj7B78ScG4gcHAnMQoEMBesDGpsi8hRh3W
   cZgFYUz6y4R/ff+ytAJcXpoAnNuORLb+cmKKxYqPZTjH71LKVpBP8Ufxk
   C+/E9AJRnIl6a2kwxbPEXiizgeSDqyyO2+PKp8H33xETLKKl4DSNqY1Lz
   lhkg0GxRvdpwRHJ7rILJDVKrgxrrMK4hxcw4a+/gE5ePM8ZTDiXjM7Flk
   X1CUmapOeNqo7X55GCbLUMGMSJmIjn5ivJ1FRX9pzi6pL/AsnRp4nqWq2
   A9fpLC6SppP3Pe62BSg3V8SEFjS2AniHznONzfcRLje4mCHCQLjX0y3TD
   A==;
X-CSE-ConnectionGUID: U6VPeU4WTeq1JT6PTO/m3Q==
X-CSE-MsgGUID: UsUBstrORJmYNO2jr3MWvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86252277"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="86252277"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 07:23:01 -0700
X-CSE-ConnectionGUID: i5ByOJrFTiqfSvVG5KjBQw==
X-CSE-MsgGUID: uHJigYjmT963zMH/F6oOrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="261285963"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 07:23:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 07:23:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 07:23:00 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 07:23:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kp56B3hLlzv43N4hTyx14OLizZbxdL01X3158S+grCeDZA/0j1At/+bJCH444PqxqGduPPbe1yN2isMl7HDOJovAZa07cUuhzode2dN3d8qtlgTbVM11BGIxKUPfD2JPIYHrQfZAqVLjqX7PPjcgOkNs9vbzpE9ZMPlk5+f4G4rQFq6zikHYb3Z3qm/8zaqMW4CgyFqP5D6xJvDA2CKDAug4vqmotzMm+lmbeOSrYfr60xE1f3mLJbT96OC2+O3i824xiOkkCEgSQpB4pgnz9eXt+7OYpmMDpxYmiDcHH79bEcHt+EY3wRTwhTRd29x5st/9U/W4ejBKgilZATV+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYqnyv36mb7q0/wBEETDzfTAHz5Nbx+EKoN1B4pXXW4=;
 b=E8ufHyYUAWv6PdORAJqkyHOSeZrXYVLZdDMqihyAw7obJ6wkbLqNObQT6CZCinmeFoH08Jbll0UZbnmbb6zZyaHkLeE+xztiLrmWl0GW7UOryV1sLsEr72FWTT0KB/bshsvvdyN1URRNID8QH7ArLUY/fKvHmCDWQ9/Gz/mEKnjGO2gKDmQZJq1t/XxdRLGdrQge+b2omR4idvAPsKlDWvRk1wSevYndlnTMhD+FctZkZNn7iw8oE6A6t54GL+QQmg0xnpUP1iPuYkkIfGCAVH1NQTZLOBdNKq/m53xWU5DOlCe3AycVenEId53XUa9Sza5DVOPtPNkkpvCogQeg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MW4PR11MB6960.namprd11.prod.outlook.com (2603:10b6:303:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:22:57 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 14:22:57 +0000
Message-ID: <dfc39896-7e0e-418f-b557-cc403856bdfb@intel.com>
Date: Mon, 3 Aug 2026 17:22:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/8] i3c: master: Report wakeup events for IBIs
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-pci@vger.kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
	<Frank.Li@kernel.org>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-4-adrian.hunter@intel.com>
 <20260728164710.860FB1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260728164710.860FB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0021.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::26) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MW4PR11MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 00cd2681-538e-42a6-3dc4-08def16ab6c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 4T7o0qEwWOQfEGXU2NiMtM5P0iXPcktE+GzIi4LRyXjcwT4kRo+MDtavBD91TlGe+uwFB+b6j/X2ka/tPnB9O7PZOq6iErMcoBxHT48B6w20y5b/Q0A7Wsrrf/KGYbfdm8siVh9n5etixbctKX6IH7H5c6Uc0ulPgbH7AiRODJDUVDJOwbPdIrn9UF5ukTC8Ik694lkj/K82T3GPLn98YLxpqJhDwqEXwgqNGD/ArWcduM/mGwcU9P2Itr44YS47gVGbNKsxyTWjhOfxXQZ8oKJxP+C+27jmvz8cRevAO/u4U089kLEDeqipysAVulImjhmwy7L6bWU3YOib+LLUTT/+gPoaAXWbNGLVworoWWhtOn+ORBxmhHBhICVUSAk06DT6toZGUTHUaegkPcxpNUKDbTaxZNoy4hagOX/7sirwCcJdS66IqhKutRwRxVKQatqAR0XV8bHpgUA2Q/6U3FdBprEphxg1HvRchI76i1AQDQ2QE6y+SvzCGuiLTyIm+UpqPSF1bkwmIG7JPXwLT4XbVoo3qEMwJY1l83vPdTzAWF6VSq/boPBQLdRUyyU0zCZUtdrMbV1erd77pjHQyX0Cs4lhS2oAdSzx5Ws15Gogvgk4YJ4r9k+CFEgkvJhquQcVhUTvrsvLTYC+47XXecSoHd8ukABwTl+3WESoR10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1hnT0VDOW5pU0JWQ1BUVnBYWjV3cW9MUkJJRXpHbzhuQ1IyelFnbTdzTXFI?=
 =?utf-8?B?K2lzcGtocndmWXF2eGpITERxZnkveTRUaDRBaDFUSzJld3VmVmRtamduQ0xS?=
 =?utf-8?B?bDJCQ0JvaVFoZlV6NjNnMi9HOTVSTTc1eGVGVFl4NEVMWjhTUU1VcUEyUEda?=
 =?utf-8?B?TnQvckkxN0NRVFhGcGxXV3FPMEhRaE9JaHVWYnB5QW40RkR4OXZHZUtVSUdy?=
 =?utf-8?B?enZVTlpNQW5YUUxiZHRQOU1kWGtkVmpxci9icVZ2Szc1UTlNSnc4VStXcGxU?=
 =?utf-8?B?aVRTUlVyOEJwRFhvN1lkWUwwZHFOUURDaEl1ZVd5aGh0dytPdStPVnZBMU9B?=
 =?utf-8?B?ZmhmQXZXTVYybU9MYStOTlFVRm9XSktVcjZHSXBkV0ptdFF6SExnR2dIWVNZ?=
 =?utf-8?B?bnREaHovNDBwb2ZFbTdhZUtDb2Myd25JeTR1TlhRUkV5RSs0L0M2UUNpbDdT?=
 =?utf-8?B?MlNaVHFOR0RUZzRISkZXcnNXNVM3RHBtVU0vNlZSWDU5a0tzKzkzV1IxYlJW?=
 =?utf-8?B?RjFvOURHUEF4NmQyQXVSNU9XWHNGT3ptcjYwNzBLLzFLbUhoTFZKS1A1RCtr?=
 =?utf-8?B?TDUyaW5XTnFYL2dPQ3dpa1VGcDlJWm9ML2ZjWFhXOUovczArcWpHUk12dld2?=
 =?utf-8?B?VmVzbWhyRGloRjRtZjdseEFyRTAzT2RDUzBEbmxJTnZUdUExMll1Nyt0b09u?=
 =?utf-8?B?VVZxcHBJYWdESkdXaTBjSlJxYXlKcGkvVGIrdWNXQk1LZk5XSzFnZTZvc2o4?=
 =?utf-8?B?ZjAwK2lub01CcVQyblc4Z1BRTWxnNE9UWHBwZE44MngxWFpwN0VoYjlONmhI?=
 =?utf-8?B?Nmt5UjV1aWd4cFFCUDdKeXZJR0k5MDhRcjJPRXBqcTY4Vm42bENQOWtnYUdp?=
 =?utf-8?B?REMxUGM1em1TcDlYMzRWZnl4b0Z0VklzRTlsN3B2cWtXaHIvQ2t5djltc3VY?=
 =?utf-8?B?ODg2ajRPdTZFbUl1TWdBK0JUanhmcS9WNXk0cld6UlhpcmhiTHlBSUttNEZt?=
 =?utf-8?B?TUc5OXgzamxKaHBvNis3c1lwSzBSb2lvckdFUmJ5Y1FaVVpITzh1U0RMWWFW?=
 =?utf-8?B?R1pzLzRwQlE5Nmhma2hlSHdLaFhKQitTTFEwM0FwWEJad2pWWlhQU20xY3cx?=
 =?utf-8?B?QllOb0JQR0wxNC9ZdFR4SnQ5K0tPd2xNNkVsc1ZRWUlHb3B4QmNyZmtBNGtZ?=
 =?utf-8?B?SXllYnFJSnZ2QWNaR0tqUi8xYVJ2b3hkTElxY3RWMTJmZDlOUkpYV3pYNk1z?=
 =?utf-8?B?bEhxZmEwNEZrYk0xb0h5cjFOM29FRmVMMW1SMmhLQldYWEJUcFZNYVJKTThK?=
 =?utf-8?B?dG1vQ2RUR0hydlJQbUpVOGl2ZHVDZkJGcWZWWEdMbFczQjlXUHQxWjZ6VHk5?=
 =?utf-8?B?M2ZySUJaQngzYTg0WmQzdUlEdCtzSVQ4ZnhlbzJNai8vMGpMdGNuVzhLYVls?=
 =?utf-8?B?K1E0R2lha0NKaUxiRXpqMmRlSzBNc2tlMjN4UVBtWEpuK0dMejdTQWViVStH?=
 =?utf-8?B?dFNzaURZQ21NM3VRcHR1RTNnUjFRUHNPcU9JMTV1eVlnb1k5Y0d1aWhTS2M2?=
 =?utf-8?B?UDQ4VDI5enEyMU53Q2dEZzVINm5LRVpkd1pJSXVwRlRscTJrSmsvcWd2S1hE?=
 =?utf-8?B?ZldoaHgrTDJrZDBsUzNYeERsczJOSDhXU2dmSjR1ZXhOM3BWRDAxVlpER0JN?=
 =?utf-8?B?NUJnSG9oZGdJRzJRcERPK3FvRDZtMklSMWNTUUZGWlRiVmJZN05CZlV1L3V3?=
 =?utf-8?B?SlVmeU9nSEF5bThTSTZ4UkV0YkRHOVEvdDI1b2VhaktTZUF1NUo2VlNKSS9I?=
 =?utf-8?B?elA5aTltQjBZYnJqb1FaRlYrcitHWmZBK0c0QmdtSTVMOStiSHB0NFNlWU1x?=
 =?utf-8?B?ck5MY0ZmaFhqUXJyLzVZdzY1TjI5TjQ4dE9hZmxZQktjeHZjRE0rWUxNSUpy?=
 =?utf-8?B?a0RjNmtUajhoT29TU1RSUEZiUm1QQnpWREVGUWFSZzNYZEV3dHhzeHdYdlpK?=
 =?utf-8?B?VE9ETmtGc3FNQjFvcUN6TDFndUsrMCtOVzcrRDBKRmJ1N0s4S0JzUGtWKzZa?=
 =?utf-8?B?bGliSVFEcnY2WHMzKzJRR1pZN2NybTBFcXV3UnBzS0h6dEYrNVBUZmZXemlU?=
 =?utf-8?B?NUR5VDVmOWIvWmRndjVzcUplSUdva0ZBOE83UjVUbEE0MFl2bW9pNnFRQWZx?=
 =?utf-8?B?clNWcEcyYk1uVzB4Z0JtREFJbkEzVjZZUVhjKzJtSEdoODNoekduejB1d1Fl?=
 =?utf-8?B?TTBZMEJyck5iRWRraTZnY1FvQ1JkOGhlQ1hKdldTRjV4Z2FkT0dJVUo4UWJq?=
 =?utf-8?B?dVBEL3BZcy90cDhaZFFmMDZBelBZQ2ZpdUJ6MjhpL3M0MzdTdGdDTnZQdENT?=
 =?utf-8?Q?BqzjhtdZlI+ph+GA=3D?=
X-Exchange-RoutingPolicyChecked: IpVIWGwJJBaUBDamCdNSoz1NH6jjeBYSdTlAE9WsvKh69zzkz3lS5rC+/ue4LdHLnBDpyiEtV+pFZDskPypLLKAB96DZAgPeGP+n9l4H6AbLbKCskjD+CwuB8KquN7yyPkaLJgdGdHSVqe3iIM8/7zyzMOnq/d8qpTwXP9NPX7rnmxWAFrrPVIdCSuKaaMvKRkE16dku6/XFCMdCGs7RIE1JUUukyybIv0jI+Bb7deRrUV8YyaIXGPdsl86CWMhvAzByg6ec64nBrD+T9xasOIWmPds2KgG7I4/DCX7PAJOFNf4dqESKn1qxY3AlTSqe88JahL/cPRW1o43mk2KiwQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cd2681-538e-42a6-3dc4-08def16ab6c8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:22:57.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZPzXFPbOOf1blDEbq/tIs8eQwFilaVh5VHISEfq3Q21iFaK02FIq+CMl5mZOLVnxE+IYWm+qjNORQTKn/ncJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6960
X-OriginatorOrg: intel.com

On 28/07/2026 19:47, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Concurrent execution of `i3c_master_queue_ibi()` and device unregistration leads to a NULL pointer dereference or Use-After-Free on `dev->dev`.

Already fixed by "i3c: master: Fix info leak and UAF in device unregister path"

	https://lore.kernel.org/all/20260723075747.34049-1-adrian.hunter@intel.com/

> 
> Pre-existing issues:
> - [High] Concurrently accessing `dev->ibi` and its workqueue without synchronization leads to Use-After-Free.
> --
> 
> --- Patch [3]: [PATCH V2 3/8] i3c: master: Report wakeup events for IBIs ---
> commit 1c61ec6aa53c785eceea38530075c6fa6b7794f2
> Author: Adrian Hunter <adrian.hunter@intel.com>
> 
> i3c: master: Report wakeup events for IBIs
> 
> This commit records a wakeup event using pm_wakeup_event() when an
> In-Band Interrupt (IBI) is queued for processing and the device has
> wakeup enabled. It uses a 100 ms processing interval.
> 
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index cf3345265ac0b..9d56ca08569a1 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
> 
> [ ... ]
> 
>> @@ -3098,6 +3101,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
>>  	if (!dev->ibi || !slot)
>>  		return;
>>  
>> +	if (device_may_wakeup(&dev->dev->dev))
>> +		pm_wakeup_event(&dev->dev->dev, I3C_WAKEUP_PROCESSING_TIME_MS);
>> +
> 
> [Severity: High]
> Does this introduce a regression where a race condition with device
> unregistration could lead to a NULL pointer dereference or use-after-free
> on dev->dev?
> 
> If an IBI fires and i3c_master_queue_ibi() executes concurrently with
> device unregistration (for example, during driver module removal or
> hot-unplug), i3c_master_unregister_i3c_devs() can free dev->dev and set it
> to NULL:
> 
> drivers/i3c/master.c:i3c_master_unregister_i3c_devs() {
> 	...
> 		if (device_is_registered(&i3cdev->dev->dev))
> 			device_unregister(&i3cdev->dev->dev);
> 		else
> 			put_device(&i3cdev->dev->dev);
> 		i3cdev->dev = NULL;
> 	...
> }
> 
> If i3c_master_queue_ibi() passes the lockless if (!dev->ibi) check just
> before the unregistration runs, could the subsequent call to
> device_may_wakeup() dereference a freed or NULL pointer?
> 
> 
>>  	atomic_inc(&dev->ibi->pending_ibis);
>>  	queue_work(dev->ibi->wq, &slot->work);
>>  }
> 
> [Severity: High]
> This is a pre-existing issue, but can accessing dev->ibi and its workqueue
> here race with IBI teardown and cause a use-after-free?
> 
> If i3c_master_queue_ibi() passes the if (!dev->ibi) check, and concurrently
> the driver is unbound, i3c_dev_free_ibi_locked() will destroy the workqueue
> and free dev->ibi:
> 
> drivers/i3c/master.c:i3c_dev_free_ibi_locked() {
> 	...
> 	if (dev->ibi->wq) {
> 		destroy_workqueue(dev->ibi->wq);
> 		dev->ibi->wq = NULL;
> 	}
> 
> 	kfree(dev->ibi);
> 	dev->ibi = NULL;
> 	...
> }
> 
> Could the interrupt handler then continue execution and call atomic_inc()
> and queue_work() using the recently freed dev->ibi struct and destroyed
> workqueue?
> 

