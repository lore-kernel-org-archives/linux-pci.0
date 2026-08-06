Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F8385D87
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036870; cv=fail; b=BfPOC+1MEPYnP78+NCqrU0PpgetRHzRO3yzsBqN3nQw+SEC9VC+r3R7aSx3Ec2NQ65P/KfvESysF/RGE6Kjho9oI94DHjRRqJ/5obiRU2m9TF66lNpQRKa/O9shLGjGXoXe17cjTlBA+1vOSEOQJbaXeFaeqhduqietWiaGRHks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036870; c=relaxed/simple;
	bh=WluQ6cuWoQ2UMw5T9tGJS1YFyjmZl8luY+nY3vCi9lY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dtji/He2WqCix0i/ewnDz0qyFaMNl/Pfp6PLKomWXc60zIcPP3lgeEP4IIxvrairGdtUSfwsmBarUvNuk1vqpI4D98E42aqjEpxpHo4/IQX21p0eBVt/OIJOxwLk9dchdZAhBU2ozjpt7ljmkkxFJG43m6ce1XDzCdsx87vgVOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0HHpn4P; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0HHpn4P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786036869; x=1817572869;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WluQ6cuWoQ2UMw5T9tGJS1YFyjmZl8luY+nY3vCi9lY=;
  b=l0HHpn4Pji6EtZEHW1t3vwcVYvs+D6618b8txEHTLCxfkUJ7z5i39wmi
   2W9yb7N4Qvpc1b7jcYg+XtSiGvAkGAeCgxo21JzVlUV7hD/XtrDLlke3Y
   O2wtIfNUA6b9vF01TKQH3IK4+CtDCDsfrMHSTRbtAGnENz9LHO2n/XrOL
   S1mZFrReJoiFbHtIxYmQbTrM+JQgzQiwkNF0+b8eSW/0oPmCorulw0WsR
   Ol67wfVod/PJmdjrF15t3uMVDsxhd6Y9uAnh8XZ5fWW0PH9VnYe+lQWCF
   NIigriLMgfz409/uL2GyjWv73CG1g/DXccttFd6LxpHENnw0E+GKF0I+v
   w==;
X-CSE-ConnectionGUID: SG3WwxBPTcm8bxL7oEYN1Q==
X-CSE-MsgGUID: yznzRSLyRE2zuNRmenthwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="90458209"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="90458209"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 10:21:08 -0700
X-CSE-ConnectionGUID: NphKpiTPQ9WsRXxanTs8Jw==
X-CSE-MsgGUID: VQngvYiQTjus1f2rJAzvoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="258295529"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 10:21:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 10:21:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 10:21:06 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 10:21:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoWR6oIfc8VdBJaOkiJ9bHg1ccOCfkzThjEOzvfepObEpA0Eq2xjmTNb1JvYi5rL2TIaCbNCWVRKsVkKMy17iAwNtWNUOXAcR/HIWKaujiVmf7qtfoiHiwD9X7jtrxcN2rrQmwBjCHW6EnE99+1dZQaFvf3ioKB4Rvo9sMF/8XTvOM/0Kw5FchFtWISVrrJhvG6CgyQpzmlwlSlAlXPRY+o9FiG4FNpP4s0y9mBVyLMg+xogOuhePQBJ1W/ixJ5XymWZZ5HfIEVCeEg5hoK7YkrCDES+j04fA9eIH3ovNukyWJfVmmZXxuc0Cw/KoK1Z0JqUY8+fOxrZQZ/OdNnTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hh2+TGg/LW0SKkc18Jm4vG/UpXUpRTX+hBJqy9pGPk=;
 b=C6zDSQ+oMxcY5OqqQypsGErfxVsmg3Tr01SJKNdLgVP4seTx1N6QPTIPWvSop09LRZQXtjx/hi+dLkEX65RMGzwMBHv3Jf+AeCRzWV6WXgq6TIt7xJcYHaWHaA74NuRIRXHGPhK7uosYO7tZ9rgSbZvQ69+NfHSpZoJHuj6da7ZK5DBm1MfePDt6q7mVpDoHr4Z8CNYcWPomEF78Xzi/RihUSx9TpGzfDO08jqQmBT/KfgiOPbSsjsM98iSqrbC3E84oQo3MqF1+w7zmGEae5rCQsdMNoCSsboYSOTiC5GkM3X6DZ5Epb9e7IHwzKsZ8I3R291UyH07AskSRmYSOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH9PR11MB683264.namprd11.prod.outlook.com (2603:10b6:510:3e4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 17:21:04 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 17:21:04 +0000
Message-ID: <fac1460c-c3cb-4d54-a681-ab4c94853c61@intel.com>
Date: Thu, 6 Aug 2026 20:20:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 12/14] i3c: mipi-i3c-hci-pci: Propagate I3C wakeup
 requirements to PCI
To: <sashiko-reviews@lists.linux.dev>
CC: <Frank.Li@kernel.org>, <linux-pci@vger.kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-13-adrian.hunter@intel.com>
 <20260806135634.825E81F000E9@smtp.kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260806135634.825E81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0252.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::22) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH9PR11MB683264:EE_
X-MS-Office365-Filtering-Correlation-Id: e4447e37-96fd-421a-e8e0-08def3df17e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NQF+WuZuNrQb0QyhuF1rjPn4eHRNW2aI7+pNznAInYS3vq7AP27iW1Dti9DZ12VoxrcJXN4AlOcasJXTu+ffviQ8Dd5g63CfgwEAjPcM/4liE/BBncYyFBREaDTUCqivkg7sYEC97kVIjPNcgS68TAybGsvLcuArOvCmZTBj3dqbGz80C13kMngOl3pT09/wCy6spr2iLYUMtuPxHYgpKMw1TSagAfPFh9pXXDNbMbVTFStJ0AkB/9tp0+XKubLZespehbps9kNXrMZzZkxy1Nh7xxmjkU3fNHLzcR0Gwbb0tUC1NjdweDmNP8oy7DGZQCcc+dOj4FzG1r4diVEUEsub7bpPICG47R83X5MTXKDJ8TTvyo0oLOcj/fP+KumBtlQpTeFGFaZOoWaOfaAB9oZ2Mfz/ZwXK1ggAQRhENPvYgygmypafAXKk+SmAgG8ImsBdoELTvuwToy3WQbrAmQ+fFjQ09W38KzfRCHc2GRQ7kxZP3kL80T7HvY6FAckOMke098cvC7lxI8+RcfXy/K/zaMC0UL1LP9S5ZaKHe53JWsr+5aAitMfKqcGk0qQDkooWIMTlJqkcwF5zcLZ3R1CJ3XwaOuKe7blXmHjtPh5zxEWRI6TU+sDBozeUuTSFzU9fEUn/46iWxBt635EzYWU0JGARZak68WPGNxXqBOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkFqZHJxYkt6cytvMzRTcnNGUDRiQmlkMk9mcnBRMHQzV1VrdW1pQkJ3empx?=
 =?utf-8?B?RmFkZVd2MnVHbWhFNzZNcDRuUXNuMTFqdFpWNFNRL1ZDcjRvbGRaOVpUdlVy?=
 =?utf-8?B?bGtGdkROUzR2c1JhK0NaZFRsbmd1d1VXUHYwVmlwcDdkbHA4WHIxbHBJa3Rr?=
 =?utf-8?B?NmQ1NkwrZW9VRU0xeVZqOVdPMXc4M0RHV0RpK2lvTjlkZnRSVzYvV0NZV1pp?=
 =?utf-8?B?bDFNTkxYWm9hUURid2VkWTFSaVVXcmJCUW9MQ2VTcjBreVI4OUlnYzdZcWJj?=
 =?utf-8?B?NjNMT1FiMUQ1Ky9qVEtSaGlnQ0RIbDdHMUFyTUlOMkFPdnY4OFJQU1pDb1V4?=
 =?utf-8?B?SG1LMklCSndVamYzWVdYMVQ2dUc0MXIxNWUxdVpZUWVjVWJNblNkN0ZKVzhX?=
 =?utf-8?B?eTVVYkx6ZEtwRDhkYURaMUlIYXRTTEdwVkJaQWdaLzdPazVnK2dldkpFbzg1?=
 =?utf-8?B?TVEwaGE2SkIxc1VoN01YQUxPSkVSa044YzdhVFo5OTFLWHprQlJwcGNnOXhT?=
 =?utf-8?B?MElwRXdwckE2UFprOFhHWXdoQXFiRFY3WHdHVVFIWDJyNVQ3L1JjY3NpakVp?=
 =?utf-8?B?YTUwdEQ4QlRydkw4aElXRmFpd2hVd0NubGlBQVorb05iWnhqeUNYRFo2MGV2?=
 =?utf-8?B?My9GaWxZWlh1eUV1NnZVSDI5R3NwT2dGM0plYkMxRStveGw4R1RFdUlvei9Q?=
 =?utf-8?B?TVZ3cVhZUE5MOVZnaUNlL3U2d0k5VUJpN0N5M1N2b1Y4WjNXd0orZ0VFUjZt?=
 =?utf-8?B?Y3VkdWxBTnFmcXB2dWU1bGxHenVLeEoycVpMbWNvdFp4SitQUFRxOGF0M0Nh?=
 =?utf-8?B?TmJEdlErUnluN2h0WHMxZmRub0pLSVFLYzQwdHkwU3VtL2c1aVJiRGNVeU1L?=
 =?utf-8?B?TXhpMVpxMFFIaUhnZTMxb0dhb0Znem04VXJuTmFLei9QQlF4WjhybzZKR0xj?=
 =?utf-8?B?eFZGR2FOYlBFanA2QnFreGd2TmtPTFVoMGM4cUYvOGJsWkJFa0pHUllhNytU?=
 =?utf-8?B?Vmk5L0lSZldqaHcyeDd0cG1zK01BT2ZEaG1XRTM0MEl6ZW4xN2xsZW9xMzBC?=
 =?utf-8?B?ZU54Q0YwTXBwWHQ4Q284OXYyV0oxT1dIa0xYOTJxSFcxTmNaTEFydGdtb0Ez?=
 =?utf-8?B?V3dzdmpzWWVLbmczQUx4Y1hSRmpYN2pEYUtLTFgvZEx6SVdOM04raDJLMytD?=
 =?utf-8?B?QWtiZmhZZFVkVE1XYkVNMzNCbVZmT1lHRDh3U2t2UHR2U09tOFdnb1p5cFdK?=
 =?utf-8?B?dVczQld3U242ekFzbGx2eUlseVpXSUJNM3R2QWdpU2Fta3ZqZ0wyU1MzS2dL?=
 =?utf-8?B?cTJwTEZlSUoxakRiakgyZHlDOHMrMW55SDVxZllVMkxPaVlsNi9idWpySUxN?=
 =?utf-8?B?bzZKMG1TUHhHdWhua2VNT3NYUjB5Wll1bGtEN0RjRzA3MnJoYXFTVy9jUFRF?=
 =?utf-8?B?SlI3UCtRT3BwSStVWHI1VnFiWlNucXpPS3A3ZCtQVU9HaDhKSXNtdlhBZzc0?=
 =?utf-8?B?UjdRQm1mM1BkR3VWREhBQktHUXFibUFDOHVNOTRDZnhzTkVIYnppWnBSU2tH?=
 =?utf-8?B?by94WDM2VE9wYitTN05WSjM1SUhlM1hTU2hxNklRVHlKMjlKZWx3VllhZ1dP?=
 =?utf-8?B?QVJOSjZBd09VWm5RME9qQ0l5bmRXclpJOWFnNEEzZzd3NmRtR0l1d3oyelVC?=
 =?utf-8?B?SmpRZnorOVR1b083bDFMc1FMSzJZejM5ZzEvb1ZQZkFNYk9pU09pWDl6cTEv?=
 =?utf-8?B?Q2p3UkdzSVN3UXVMR1pYaXpDODh1K0w4azZ5SWVLbVlxRmwvQldOMVBiMDhD?=
 =?utf-8?B?OFhxUDhUdFJCbUE4R1B6VkRKbUVXbHhoeVgxd2E1VGpjWmJ2dk92ZExRMHk3?=
 =?utf-8?B?YUpKMk5oOE9aMTJia3J2VVdXcTJNaThkbEtaRzhFbjZJRXZ3Z3JWSHZpMzNL?=
 =?utf-8?B?dTFNalBLSTBLYmtIL3pMSXYraEExcXR4U0MrRmh1UDdiYloyc2RMOTVON1Fh?=
 =?utf-8?B?a1RwR2FyYWo1aDQzNWd2cDlIR3U5dmRnMFFPYm5kWGlYYU9UWm9RVi8xVzA5?=
 =?utf-8?B?QTlNUFQwK2w4Rm9sQmk0Y24ra3dxOEx3ZFZLRVBUSUt0UW9BRGFpc1NIWjV1?=
 =?utf-8?B?TWpheCtQVjhETWRNWndkWDZhNkQveEFjUDY5TitKY09JQ01RUnNob29maVVh?=
 =?utf-8?B?NjZxSjlYbkhKeENiWHpid0dwZ3BPblhyaGhaaDFJcXY1cVBWRFBaRlQzaXAw?=
 =?utf-8?B?SnlIdGtQdVFYRFFGbHk5VlVCK3k0Und0WmgvN003Z0x4eEt1SzNBaGZHcTgz?=
 =?utf-8?B?dGZZVm9RRDN1dUVJLzRySElnWWZvYUxnTEpqQWw2ZHpRbTFzeHZ4SWlCUjlQ?=
 =?utf-8?Q?ORFlDSq3FoWVDk2U=3D?=
X-Exchange-RoutingPolicyChecked: rMrd4Hbym9bLvN18ilX0QFGksWpOyG/I2gLj7WFCkVHEA0HDAX2iQplUGL9TBa+GvL9wYv3sLgEt7uCli26psaKU6aGDKBlILyjq+cH3Tmprytk8IbVf6wYjs+VYU37FficrJOdCRDOd7dJjeKT4zspoHMwgrKlHlcNfUH0Y0Z0wCBTHF+H9NUl5FeKNX12LsENcaE4i7Fwae9YChZV6xyNA7u/3aQW3iG82KohKszP4fxE1TVkbR+ZALFSZk69PY4+NsVZefewQZXAZDQ8bfQKEdnyY2T95Lcj5FQqkYn/qYaKAhr/8gzzMYFsxRwuLEOF1jbP16jx+xlo8E6/6ow==
X-MS-Exchange-CrossTenant-Network-Message-Id: e4447e37-96fd-421a-e8e0-08def3df17e6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 17:21:03.9888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmb97PjWCSvAq5f7fAX3XA/IE7AG6BtoYJ+swUm4P+ubbsE/d76ScB2TnPjnMg7bnP4mKOl/OpxfipSd0UG6Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR11MB683264
X-OriginatorOrg: intel.com

On 06/08/2026 16:56, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The driver dynamically overwrites the user-controlled `dev->power.should_wakeup` policy during suspend.
> --
> 
> --- Patch [12]: [PATCH V4 12/14] i3c: mipi-i3c-hci-pci: Propagate I3C wakeup requirements to PCI ---
> commit 317489fcad21bddef17def19e22782f047f99dc7
> Author: Adrian Hunter <adrian.hunter@intel.com>
> 
> i3c: mipi-i3c-hci-pci: Propagate I3C wakeup requirements to PCI
> 
> This commit updates the driver to keep the PCI wakeup state aligned with
> the wakeup requirements of the attached I3C devices. During suspend, it
> checks whether any HCI instance has a wakeup-enabled device and alters the
> PCI function wakeup state accordingly.
> 
>> diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
>> index 5a9e2a43eff8d..42c172e82622f 100644
>> --- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
>> +++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> 
> [ ... ]
> 
>> @@ -317,12 +329,19 @@ static int mipi_i3c_hci_pci_suspend(struct device *dev)
>>  	if (!hci->info->control_instance_pm)
>>  		return 0;
>>  
>> +	pm_data.can_wakeup = device_can_wakeup(dev);
>> +
>>  	ret = device_for_each_child_reverse(dev, &pm_data, mipi_i3c_hci_pci_suspend_instance);
>> -	if (ret)
>> +	if (ret) {
>>  		for (int i = 0; i < pm_data.dev_cnt; i++)
>>  			i3c_hci_rpm_resume(pm_data.dev[i]);
>> +		return ret;
>> +	}
>>  
>> -	return ret;
>> +	if (device_may_wakeup(dev) != pm_data.may_wakeup)
>> +		device_set_wakeup_enable(dev, pm_data.may_wakeup);
> 
> [Severity: Medium]
> The commit message notes that the PCI device power/wakeup sysfs attribute no
> longer provides independent wakeup control. However, does this approach
> conflict with the PM core architecture expectation that the should_wakeup
> state and device_set_wakeup_enable() belong strictly to userspace?

Not really.  The user sets policy via I3C devices' wakeup attributes not the
bus controller's wakeup attribute.

> 
> By dynamically altering the core device PM state here in
> mipi_i3c_hci_pci_suspend(), the driver clobbers any user-configured wakeup
> policy on every system or runtime suspend. Is there an alternative way to
> handle the I3C wakeup propagation without overriding the sysfs UAPI contract?

Not really overriding, and no alternative.

> 
>> +
>> +	return 0;
>>  }
> 

