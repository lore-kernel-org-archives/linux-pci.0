Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94713769EC
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037869; cv=fail; b=c5xkRIro22/RoTHkGxtXPQiS1zrYaknQRaaORlUdh9slSKgVMGd3i6LIFqevMZ1p++tkkOoVuQGvYtYgwTCfohafOVjY4a+h1pzP4ejH3G4qiRPKC0anI10I7828Md8oQDvE1iqkDQ2895BfhXlwG+Y3wOAOGh3zvxU/AWL/Kgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037869; c=relaxed/simple;
	bh=3w+CpIt4FsWvsVC5NdjOMQgAc/nJr14jMHszgnNuTgE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dhykFjNHg5DsEndWBtAsbWPhCrkuM+9i1SWeYGoek0BTcZk/8GNUl5DR6rG2eqNr95HoOfGaPLu/UORN6xxl93Y+thZiH+hPzfbuIh9jWpiNMITUGU5OXhgxAlZG2FG9vMvPa2eQyI4xoMP7fQWhzNp21/VjlCNqxL0bfl45aSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMvoapoJ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMvoapoJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786037868; x=1817573868;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3w+CpIt4FsWvsVC5NdjOMQgAc/nJr14jMHszgnNuTgE=;
  b=YMvoapoJfwhBztTh1kBuD2/RnoByObJ1znUToxhOUzZXIIttdq4z17tJ
   g/FKfUcHpkX2oYDmrjev+vV6nKc5wSlLgMbU6XiVwvj8bR8LozQi14zXo
   GABsoEnJInchbYZODt6xuwXsXna8OIRi3F8v5xvTO1ONj9D6vpUfI2mo0
   OY+OTDGXOgUjwRcBjdxM+cFbp4jCj2nQ1ECZNHPZpxcwm6S77pnnP98QO
   8Vw4XBxlcVcqtWojJI4JvH5bqmiLje4WHg/9EjanBA+cNfUdpuudPNShr
   a++5cr0Ztjw/vI0HEtb7jgFwccGSR4QTdvVojwwEvC16LIetwQ1lnGWw1
   A==;
X-CSE-ConnectionGUID: YOeT3u6MSjiLkOeNCLbLeg==
X-CSE-MsgGUID: Aj7mB/ltTruvLaMpyj/l1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85612691"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="85612691"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 10:37:39 -0700
X-CSE-ConnectionGUID: PJKLn5VRSLaIffEe/KBdxw==
X-CSE-MsgGUID: 1yqsMok6Team+9inOo+gtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260401135"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 10:37:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 10:37:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 10:37:38 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 10:37:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeCNdN3+8rXkvEE1v0xa6LDpN3ufiDoCZ6oWHpyxb/DDIf7z3zmKSIiS6b66tna76jJmjDlVL9koUc837PJh0K/KJB5oSNLB2V2IOEAeIlTljbJHX+hHl8JcPBhA+du2x2o4IikMGjLaSzREmMl2E+bPopd0SoRq3XG4pIH7Fhq59Fm7ej/qVp9u2i40ETwbL/Ow4TqJSMlAewAHQrvrIiMebMlDM7Qndcqs/vcnLqKihQzOiGaNpiz3vZ5PGzdMCk9HDGFwRECrKO61/D+HtqNKV5l7H8vpv5jlgc+svN6L31T5eo6wBRdIIg5MSFnFvStaGjVkHW0xrpaVLjGwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4GKdnh74/5gYZ5hV0VUKl5hJ/mOUAWXPPWKAZJMO6o=;
 b=zJeGOQ6q118VjFiLdnynKNQgBktfe2lmxtJYRFhQcaaNLEMuU6xfE2HljUYio5PnVmy9ujnSLBkihx0MSxZSIXVkq20QLsr8acrWssHTQV63hoeATshfYsnFb+1msg/0u59Zh6RAHJdgQfnrywfPSCUUq1ETOjPGLA6xJmAvwLVPfLHvhWORKxUrEnO/2e4J3dclFfh4wQbyTTJck3fH4VU3kI8R8rvi36VHLV379+XJeL+ZtccUMWjPWukvnr7pfyiMe3/44E3bAEyKM0Es0tRL1AcPTD3bJ4lXjheNl1mBXazOao1ECdjtitSGgYYZy3DRYL+awc/e646hgU3new==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB5864.namprd11.prod.outlook.com (2603:10b6:510:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 17:37:32 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 17:37:32 +0000
Message-ID: <037b3a59-f012-4df4-a597-a34e72b27c0a@intel.com>
Date: Thu, 6 Aug 2026 20:37:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 14/14] i3c: mipi-i3c-hci: Advertise IBI wakeup
 capability
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-pci@vger.kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
	<Frank.Li@kernel.org>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-15-adrian.hunter@intel.com>
 <20260806135434.CF8591F000E9@smtp.kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260806135434.CF8591F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0008.eurprd04.prod.outlook.com
 (2603:10a6:10:110::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: b44350ef-5df9-4abc-7441-08def3e164d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|4143699003|10067099003|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: H5qPL9SnuXUZS/g3MBhPGRpl3WckYWXnWg8ahNPJ1Z7UnH6eqkcmzeko5HcL+1O35jjBWudi4zD1tNi2/Q0DG/Q9efRE0xWHPf7yLmGjU2mwXEKWtpnbJvC7DiSyH/qsqKk0q810exT8YtwTw4FFUwQ7lEI5KIvr8nKPR8CIT7ksr2i6tvWoI+8LYqJdlrptnegdGIjog1qIqHCE8xrD0kzFjiLw3mCB7GYekwMZOhM5f0R+PCzOo8x9CCaa0JYtNJRB/Z0najyFYvTSQbJOBOABZ6rdQYS7xy7CdkABa4du1vxr+DoFyTNmMEoC98XV47PbWtrsaDBtq/1uqXREQC356XYSBFqave/fXbubdWB98yPvvM1GFf0lfBxsQivMBcF96GVgiuHpwg7hXxk8yHIQJRTVd0xtVLUPjXmaX7Cpr9FZENrjZlIhs7dYFf5TnSI7nm2lig5rMQZnE61bdsgd3Dy0XRUmAXQW7hoa72/aObwA4t3nYV2Pvff+0cjox9rf2EC6RskJ/CxCxtxqQocNVuZP9wByqpMbijbZsXUEYTuPjWxf4oiuRYHoLyS5WITtNlsgG1Zg3tKVBijIAqzxG63BZZmnxM2gNhrQO4pODK8mGoKqatGIRzAajlWIffEwT/7PpoMkwTBTI43OL7sSGbYhoqNnX7QlURSs+/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFk1bzdCSWR4U2tEU0hZWXk4bUVzYjdQaUxrc1RlSFNjY1lVVWxyUnJyMVRp?=
 =?utf-8?B?N0xlN0xvMVNGTkNFbmZkVml6THJjWlVDZUJabytKZUROUWJhcDRHWWp4ckJ4?=
 =?utf-8?B?VlkzTzM2S0drZHAvLzh3UWF2U0RZejd5ZnN6QURyeEIvYlZJOTFVTGdhaTFL?=
 =?utf-8?B?eXlvcHAwdlBiYzJ3Sk45Q0RScmt4akE5SC9vaVpDUmtmUDI1UVNJZjZoS1o0?=
 =?utf-8?B?Q3d1dmdZZ0Fpckx2ZlpaQytaZjUwRkgzcFcyY0FGVlZIY0htWjQ4OTRVdG80?=
 =?utf-8?B?WUNvR3d3UVd2bS9KYytCU2dzRnZXN21tTWJWZ0FVV0RiTnhPM2JJdVJaOTBK?=
 =?utf-8?B?WUcrdllmT0srU2RkbDdaOXc2azhqU0ttRDJpK1ZJT3ZURHBWZjdDU3ZzRnZX?=
 =?utf-8?B?a1pBSklicWE3akUvaEZmamJwZjdOTEdHU1BUUDBqWVE0VVl1eVFGbEFFUGFZ?=
 =?utf-8?B?dERRcHo1bHhXdndWMU1VeFREWmFrMUw5K1loQm1mYytra1B3aWlxalkyWGk0?=
 =?utf-8?B?VlJQT3N6aFlJUjhoUkZMRS82ZDV4N1RNVWpsZ0FSaUUrdGNidVovTDlYVjNG?=
 =?utf-8?B?L0k1NEpZcnU1eTRsc1pPQU9yaTVab092SUhtVWVFeFNDY0Y3RzdodUhxVktR?=
 =?utf-8?B?OG4zOVltaEdFWS9IV0VRUHBFSFNGbXUrOEE2ZmpIeERWRTl1NVdURWo2dDdz?=
 =?utf-8?B?NkhMYUtaazg0T3RnQnlDMFFEQmE5YW10bzAvcWpBVUJlbm1qcnplZEFMNnM3?=
 =?utf-8?B?NmVnSDZYZ2p2WFFzcTR4ckphSzU3TkJhK2ZJeVpIK1NSTmNnc3p1ZjZEcENr?=
 =?utf-8?B?dVlGOTFrOVdLcDVoWUE1YU10LzFpTm9uNDE2QzNWWnZoWlhWZEtza3UzR29E?=
 =?utf-8?B?blFtR1NzbWV6NE5aWkt4dGNtOGRDdmxKRm16RzhLR0dXYnljN3VNRHVBb0hv?=
 =?utf-8?B?L3dveXJoUklTRlVqeWJta3ppSHpZTXhWRVFVV0xuaFgrcCtqa1ByRncxMllj?=
 =?utf-8?B?MVhWL3pJOVJDT2FDSVZ1RUhVSENFYUJhZ2tXLzVLd1EyTW9lbEhLNlhzcGpH?=
 =?utf-8?B?RVJEOXZjSW9nWDc2UDV4ZExsaTRVQzNKOGhQTVdIMGRER01tU3NkTFlGQzM2?=
 =?utf-8?B?UGtFSmlFUFBXQ1BodGo3Qzh6cUZkOVRyT0l3UlJkVFdidkk1YUFqQWNSUXJu?=
 =?utf-8?B?VldOcUVTZTRHeWpSWVh6UHVsMG5GU1JYYkZuN0xmcmRiaUdIVFNUQ3M1ZHlu?=
 =?utf-8?B?RlRHVU5hN3RkWk5EZ1M1WmpxUTluQXphVHpUVktmK2R0Z0xhbk5zV3hEcGRy?=
 =?utf-8?B?UXQ2Sm9rZVdFRDhNc2hGVHlUTVJiejFRMU9nMFUwQTFFZUowY3Z6R0xBSHVB?=
 =?utf-8?B?NjVrK2hveDdmT3dGYlR4ckxOMkZjaFN6NzlGSDRCdzZua0FIQ1U5THFlR1or?=
 =?utf-8?B?c2dlYUpic3dsVTV2U1lHVDNmZmZjWmYxNFlTZ1BKREJ2VU9xQ1R2V2RWMDlT?=
 =?utf-8?B?TGltZmo5WlJ0MnNvWkFWUFhVMUdEWVJtcDVpQThuWkVyenNUREZhcnYxRFJH?=
 =?utf-8?B?OUhoM01KUUtURDNHb2wyaUFOUFM0bythN3c5dEZ4QXdSekxmRW9PL29DVlZY?=
 =?utf-8?B?RUhIUHZsb3JYWTh3cjNJa0VONDFTU2Qrc3lqc0NxaFNmSm5vY0tKb1JrckZD?=
 =?utf-8?B?clpqdUZWaU91b003bkVaU3NvYldaZXZwYVE0aU03b3U4RHRDUTJTVUhnczFV?=
 =?utf-8?B?SHc0ZGF1WVF3RGdVcU5xcjhDWjA3ODU1SjdnTVRmS2NleGl2Zkc2ZnJJaEZu?=
 =?utf-8?B?K3FVZ001T1VZdDhCY1o5M29VUTRNRFJQdjhQL2wvVFVNaDV1WlJXZHI0R0sr?=
 =?utf-8?B?N2x2RHFmR1J3UzFwZ05QU1RRazVvMGoxd3JwRmtxNEtnd1ByUmxMZUM2V1oz?=
 =?utf-8?B?VzNaWmpTVUp4UWFEZnlVM0dCYTM3dDk4ckFsQWZiUXpmRm0xNlBuT3QxUS9G?=
 =?utf-8?B?bGR4cnlWWVVYdEsvd21RbUhuTW43a2kyZVFxdVk4NXpmaXZUSnZpSlpiSEZR?=
 =?utf-8?B?RmxNZnJPYVExeUxhNGFWSlAvNTVEVHdma0ZDcEdzdWtrZTZHNm1lYmFNVlRy?=
 =?utf-8?B?M2R5S3BNMkdNWGFUMlArQ2pnRW1YT3dpWXIwVjlRTGdXejdHZ0hPZXhkVzJD?=
 =?utf-8?B?cy9OWVV3YkM2Q1FrNXdNdDVxWGVYSFpOMjVlZDNxVlR0Ti8xdDh6b25XRVJZ?=
 =?utf-8?B?eTJnZitERHlOMDFNOXVra0NGa0hxMEM4Mm13MTBGMWR0TjFZOWhPMmFrb3B0?=
 =?utf-8?B?US9WNFJyc3VYU0QzVU50Snp3aklEaUYvNVNHOUJaYkY2bmlwVFI1anE3aU5V?=
 =?utf-8?Q?MZi+byytSeY1fdfo=3D?=
X-Exchange-RoutingPolicyChecked: sDLbVG81reGBXND8O5bZ5rAOLAUw7fvY8LyXhsk9YRAFUWN1Jhs3cV/fLYkC5Q5vse9GW4cujo7p5WJ346QK8APcyn2aalzA4DhoLOpx6S4t3/U/0taB0t0FA9kat+ubOWLp5NF5KT1Rp80zr+EaHdovRe3bA3EgLJQVwocBQyuVAimfEmMGsPq4ohPKTgdmtE+t+0tScHeAwKeoQziEvf9X/CXIYN/CwgD2Y9WUIDpmPiuDEjJdJ92qxZ3jv9nF5Af3E4AHCduqWKINrYoZtSdYLQCVXcTsk70az7Z35aNmxnFQrXcnSiOF4t1YMJD/tMs3vhDQhrmGOnJFKNgmqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b44350ef-5df9-4abc-7441-08def3e164d2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 17:37:32.0226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8B2x26G2aaEE5KMy+/rofuHrF0/nA2Ih5KLb7Dd3C1rVo6jgWeSvt4D3YQe1vXc9UbL47RwOVl853tYRUsDjfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5864
X-OriginatorOrg: intel.com

On 06/08/2026 16:54, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The platform driver sets the I3C master `ibi_wakeup` flag but fails to propagate the wakeup state during system suspend for non-PCI platform devices, breaking IBI wakeup functionality.
> --
> 
> --- Patch [14]: [PATCH V4 14/14] i3c: mipi-i3c-hci: Advertise IBI wakeup capability ---
> commit 443a5c0d5859df8fbad91b6e456865274a7f7ca9
> Author: Adrian Hunter <adrian.hunter@intel.com>
> 
> i3c: mipi-i3c-hci: Advertise IBI wakeup capability
> 
> This commit sets master->ibi_wakeup during probe when the associated system
> device advertises wakeup capability. This allows the I3C core to mark
> IBI-capable I3C devices as wakeup capable.
> 
>> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
>> index f95da427d7a9e..06acf6cf5a0db 100644
>> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
>> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> [ ... ]
>> @@ -1180,6 +1181,9 @@ static int i3c_hci_probe(struct platform_device *pdev)
>>  	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
>>  		hci->master.rpm_ibi_allowed = true;
>>  
>> +	if (device_can_wakeup(i3c_hci_sysdev(&pdev->dev)))
>> +		hci->master.ibi_wakeup = true;
>> +
> 
> [Severity: Medium]
> If we advertise ibi_wakeup here for non-PCI platform devices, how does the
> suspend path know to actually arm the system wakeup?
> 
> While the PCI glue driver aggregates wakeup states by checking
> i3c_master_has_wakeup_enabled_devs() during suspend, the native platform
> suspend routine i3c_hci_suspend() does not appear to check this or enable
> wakeups:
> 
> drivers/i3c/master/mipi-i3c-hci/core.c:i3c_hci_suspend() {
> 	struct i3c_hci *hci = dev_get_drvdata(dev);
> 
> 	if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
> 		return 0;
> 
> 	return pm_runtime_force_suspend(dev);
> }
> 
> Does this mean IBI wakeups will silently fail to wake the system for non-PCI
> platform devices, or is there another mechanism handling the wakeup
> propagation for them?

It is assumed that platform firmware will not be amended to advertise
controller wakeup capability before that is supported.

> 
>>  	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
>>  }
> 

