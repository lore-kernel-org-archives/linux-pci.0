Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFEC1547C0;
	Mon, 30 Mar 2026 01:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774832838; cv=fail; b=lHZmMe//bhn1Rl+S13sl4rrr/irzlU3PUYXczgpuc5qpRxMuxvB/OWAq2ZJw8MSZJK5uqEMJprD04tPI+mkZT7nMcl/UFaE5nN8v+AjYqFN2KZ+3d2Wli8N9CQQEbvl2ql8g+eQF1nLRi6/zYNv+jdBaLgOtRVZqwx4m+SKDScI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774832838; c=relaxed/simple;
	bh=Ij3y8K0iXr17i1cDkiQuIYkqzyN+mUJAOpgA6ocN5xA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=uIMmMF03GDi4gNuSkMQMyVYRHrPUaSqM/dR4G585hxAtfZjaKwfjShno3FP9YcIQ86MXAdokGmNANCXefn5IjKZF26GOn9touNJuCRvJqO7iYFXDCfth6bphM32IIR6ucKsIQHPSE79RCrb6834zU0kOoVxFPhMLWUwn5FMmepw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVm/qUv6; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVm/qUv6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774832836; x=1806368836;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Ij3y8K0iXr17i1cDkiQuIYkqzyN+mUJAOpgA6ocN5xA=;
  b=WVm/qUv6jf4zM0YtlpzQRBJ28lmUH3S9Wz5iGQhyE1n2dPJC2JSSJ6a6
   cMCPSh/Ihj63asNm38PAQb8JXn6Rp7XBMR3hbxWpvkwz5AWDJc7EcQCB4
   FFObVSbE82ZD4fr4pGm3REjD2J/EiBM/U+UDnYb+X0pGDVrmYYBx26dKO
   vTZPY9I/B8a+ngpDZb0fe3nJm6YTsnH10d6ZB7urp6La+Si9jfblXjFg9
   N/BODJ6S0sG4qVJ3p7Gbm+YZDhZ1ZxURXhCxolCxvgk6eymNaqKphAQzn
   xX+pfEQo2eXsm9gCZB8LTgwYQQbPL61N1nzYwEHJjiRsJp+ifPq4F5uQH
   w==;
X-CSE-ConnectionGUID: Qle+ZgE0SVif48xGqZxFTQ==
X-CSE-MsgGUID: mIhZQCN0SOO/o4ZKyKTwcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="63371508"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="63371508"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 18:07:14 -0700
X-CSE-ConnectionGUID: mxNjbaOgS1ust95dDsDECw==
X-CSE-MsgGUID: Azc5PkeUSaOKsz/09aPJJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="221501447"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 18:07:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 18:07:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 18:07:13 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 18:07:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V77NBaII0c3ALJvQpeIdlV6qXO/B13kSvxgDgI+v3aLCC/UW81ivym2bJOR0IZnLJ/YknzH9bIPrY5EhirslKq1xDa2PIVrRtflj+Kb2v4PJT2gANjgs54gA3JBIIbyYFCgk0xYIOD+ktjPWuf3DsEjS1Ei6b1oN+wkkoVqra6/DgGq7XZr6bCfOkeSxYu9Loa8N+F5pHL5BSWuRq0rFaOTaLEYt52KjrVFsqe7OEGfZQJdB35rmREpLIe86WwJY1LjFeC73ZTcnWl6rJvD8Rj3bS77UR/btwHhD3VC8g7j5Lr+Vs3czOgrbAwX4l2OGRvVMWGfBT+3D6dC3dBfenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYAe/RNYvkq5QiOwXzRyddn/OmqEr7apj9j9fByjcQ4=;
 b=EL2sWV8cmABmLAIar398TQetTrISeIX2NVD6xrsUi3bLEZF3+MTi3+oOYRxMtjLXjWtbmuYroq2uLs0QRi6tKCOT5Jkzoc6m2xlHZtZEeuvVSRB6pypmzgUDz9wJfbyeSE3xbjqvDA9axFticZJN0tQY6QXYGanHjm55gXl9DaAN33ZjWw+rrUGv7rcKDS3tcIpPtfBObGWd4CVC4RF01BDCt1ILIdIHKfKk9IiQppWx0OcqLaSIRG5BDKzCQm5G1Bif1rFAWoCtpBE9kaLrHYjX9tJq/WP4DDgPlPhTgJ4WdLt7upF1syZINgXLaP5Rs70tqGRYsyurEyUmxj62gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPF1A34EE115.namprd11.prod.outlook.com (2603:10b6:f:fc00::f0e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Mon, 30 Mar
 2026 01:07:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 01:07:10 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 29 Mar 2026 18:07:08 -0700
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
Message-ID: <69c9ccbc3d1cb_178904100cf@dwillia2-mobl4.notmuch>
In-Reply-To: <20260302203648.2886956-8-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-8-terry.bowman@amd.com>
Subject: Re: [PATCH v16 07/10] cxl: Update error handlers to support CXL Port
 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0243.namprd04.prod.outlook.com
 (2603:10b6:303:88::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPF1A34EE115:EE_
X-MS-Office365-Filtering-Correlation-Id: 008c5bdf-3465-4eaf-0d6e-08de8df8abd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: o3AT7tpzjEGmMWBuXOtClcfNdAKqPCs3LDVTN/sMYLmaDzuDrL6nYhaSwhXfuEUq7YfZrS7dWa0Iy4FXYySGr88ZPDDikmc+YAywnd66iaL0Fisj2+UTmbmtmL8sr6og4YOJ1iy6LSgIXC8PhTyHKN79K4QpjtDLzZe3jHEB089bUE2dwkYS2s0CFOxpE3yMie7IPIzIFHTC/aL/oIySSaWrD4VL7hISrcXSZNth/8NJy96HzoAR1qFpAef9kAupp0VDkZQXcQrPZDBONmP7zMM/KPafK3R3oWy9voyiwZ+qgsBj9iZP6WNKnmUx/C63kxykGOoh2ybHntlWOUvnneHKODsq+YN5v/SNV8soXnsYnIuDNTqZ/SqSKW+fzQjF85Xpq6FijWzRU4h9w6n8wVaGKU8Zg7XFwbeUa4ntxWXmQQyqb3MKAE8o4jxCgIwoX5OviQTtFSay1G0JoM84wBcrVr9qHIFpPahgeyClx3fAqgYS2d669f1Pp0d+zkZ27+R0ldOEn+qyrQGYjeYbU0ezMim4Qihgw/uUxxJIQkahHaF8Y1AHH2QLpMgpnUbeQ6NEmMs5f4pECbA6mfj7FXCwJTx/RIVl60IQexf1koDM+jU0cwXuHLrLLLhRwC1VhiHI08IS14PkBZkKXDlje28WSGmMrIHjAbf/rWAbdkw40PFYHRq7l8+laJflHfQKMzfCiAIUf3U9jJfQeWIhPQpe/l5ZDoNnZvpRfeTCV0ZgW8peEy33RKEqipM1Ge0aRRoiBTYjXDaqx8BAV5WHjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmVJVjNvSGMvSXh1VkdOT1g1T3dudTdjUW9jdnF6Qm50NzJ0VlkrMFUwUG9o?=
 =?utf-8?B?UTlSTW9xeGtHTVJkd3YxbzUrbVNsU2xiU1RPVUxHempNVWZRdzRMMHVIRlpx?=
 =?utf-8?B?M29BNDErV0h1M3plWVVLY0RYUFFJVlB4K0wybGMxMUxGczJiQ3lsUjk4TEZ5?=
 =?utf-8?B?Zmc2Vmdtb1VJTFlEVFQwUDk4UTBMZUlvc3Q2MWpNY0dVRDlVWE80RHp6V0Ew?=
 =?utf-8?B?YUtmMVl4VGtaNjNuTnF5ZmtsTUNLWmxaUCs4T0dleVo4eGY0YlBPb0xLRFo2?=
 =?utf-8?B?NWJUS3NmMUhHS2JtcXJHTXRGRTlPL3ozZ1Fia1U2VTJURTNkN2piS0pVMHgr?=
 =?utf-8?B?RzBPd2hsTXdaajhEYTFPM0JJODF6RVVCcHcyTFpET2ozYm9odXkyb2NmOENh?=
 =?utf-8?B?NnJITm5MU015OEU3U1RoMHprRE9QamJwL3phcFNjL0RlSXJmR2tWRmtrV1Fv?=
 =?utf-8?B?azFmWVJ3cEVnaHEvUmlnSVNvUEp3YTREVk9YQzgrOUhXVUpQWjNERXlpOHZI?=
 =?utf-8?B?NzFoWCt4aHRCWUZ0K2g3akZ1NjhqRDlRcVlzVk1lcHd2b3hLeUltVUFGMW9N?=
 =?utf-8?B?cEw0VnJIQlM1ZHY3Q3NUQ2U1MVVyTzZPNkxWSlY4VnNKUnAyMTlvZ0hUb3Iy?=
 =?utf-8?B?WXZJdHprbFNqOFlEUnNrNm94UGZja1hYVkF4M0lrUllCeFQxNDlxNElqVTFJ?=
 =?utf-8?B?RisvWXBiUnNxVHNsVWFpTzNUVEoxZVJXT2RJUE5iYkhaamowREQwN0lPb3gz?=
 =?utf-8?B?bGlVOHRZU0JocmxPYXdzMFpoeHRiRXk0RzZwREtaNjBQVTBjVDF5RVdRb2RC?=
 =?utf-8?B?NjVMQ2hRUFJRS2FjVXNGVVRaU0t0NmVnajhaTlN1NEtxT25kc0hnRzhzSlh4?=
 =?utf-8?B?Q0dINEZqSkxDVmtNaGtXeDF1eVFEZ09yUDVVdGx6YVhjVmpyWWFpVm4zdU96?=
 =?utf-8?B?ajV0SUNGREpZWll3UThTck9BTGZ2Zm1jNTY4QkZUQ1pSc0RVelRONmRUMWFM?=
 =?utf-8?B?NWtxaGZXTlhveEZVM0I0OGhyekdLRGNKVyt6dXVNZGZZeUl4ZmNhRkdGTDJn?=
 =?utf-8?B?ZllUZDZOMll5T3BwOElqdHhtMEN1Q0ZIWVVVcEZQZU51QkZEMmc5K1IrYzZl?=
 =?utf-8?B?enQybUNSTXJjaGFwdUZITFpGeWJQSGZKaVhVV2hYMVhDUm4zdmNiL2o3Ylo0?=
 =?utf-8?B?dU8xbk9ZdldqMGpRY0RkYnl3bmRaeXVReFlvMmQzMGhBcFZQekFFNFNON1Jz?=
 =?utf-8?B?SDd0RFEzemxWMkYxRXFnYzN6M3d2aFdRaFFCMlJhSDlmYm53WC81U1NpLytr?=
 =?utf-8?B?eEg4Rjc3ckJXYk9OM0VhWlVxY0dobFlnaFA4MXdJNC9kRHJGMXlXcytkV1Ey?=
 =?utf-8?B?V1RUQnB6ZGg4amI0anl6WVVzT2Jjbi9TYko4dE92UHRVd2tsbW5rM2JqMTJC?=
 =?utf-8?B?RkordjFIbE5rQjZ6NGVIV1lXNFdXY0psZ25wSWIvaERWc1B1ZWVTS3BsNDNY?=
 =?utf-8?B?Ym1uQ1RqRmVobDJnVndPQXJraVRhL0JQL1Frb0RMcmxmazhoNk1hR1cwRE9O?=
 =?utf-8?B?dnkrSHFtendtQnBnN0U5dXdEMjFaVk9vaDY1SDRpNnJtVXhtNGhnaGdoSXgv?=
 =?utf-8?B?WGRiUjg2TnloZzV1eXVNa3kvUnpBRGRCelQ5VXgyN1BhQzRIcDZUNTJTdzhL?=
 =?utf-8?B?UTlEZ1N5VHVLZk9pWDBvZVpHZHRtT1JveUpyUktFUmRqekxQK3RYamgyVTg1?=
 =?utf-8?B?QkJldlp6N3YrOEV2T0Q4NmFVbWh5NG9ZczBJZGplR0NuUkRuc0VwbW4vL05F?=
 =?utf-8?B?MUJQVUJEMDJsSXBJVmErQXY5RXk1VmJtOUtsRmxnbVRIS1lsTkk4SXhxMHZU?=
 =?utf-8?B?ZVZpUUJCNkhCRVMxTjZ6cnVWbnpiMGVnVVd0REJJU2lhSmNqNWxmN2sxekpZ?=
 =?utf-8?B?OE5YQ0RUdjdNZmJMMDI3b2hYRE1KYm1OSFkvWVQ5cnpMOEM5K2h6eHNBc3M0?=
 =?utf-8?B?YnVkSW9qT2FtZTdXQnNyeTVUUGg1dFAraHprOU10a2dtY1lGYTUxOEpIekFF?=
 =?utf-8?B?SEdpTitHbHdCeEs2OVlQN2FIYUgzS1pkOU5ubTl6ZTFMUEZPUXYwUWRFUUsr?=
 =?utf-8?B?SEZwSGNXWTMya2FjckdrUHU1cGxGT3dzRUszTzUwbTdRNFpqZFJpcUVvTFhL?=
 =?utf-8?B?QVdiMEl5SXZsUFVPNFNrWWg2QUpXNUw0d2NlS2xQZm1tUkdGZUlncGdSYUFD?=
 =?utf-8?B?dWJhY1VPQ2Jibk0zV00zMDFPVkpkM21XczdTRXlOWVVPaE9IakRNaklGMWhq?=
 =?utf-8?B?WmMreHBBeGhRTTlxWWtlOWZUUXRESmNBZDRJRlZ0YVVCMkVMSVV4eDIyK3pD?=
 =?utf-8?Q?v1LG/JsuDbsg++Rs=3D?=
X-Exchange-RoutingPolicyChecked: t3tgWrEsj2qswX6TECwDPG3cz2L4Yf/StJvir8OEG3CPhI+k9lMd8/l2WDrzHNaxTWcAzG2MerL9ymOfATpSyYU3TaGKZPBcv2uNx+qCpoO6YIPpY7TvwCR8YgU3F/5AkmH7SaBlvk6A3IvGSiPmYrDvnSMJ6u8Kz2r/qJTguVKvaeEMVZpoYweLJZ1QZHHjDvizA/44S5sdGUMe04DcNRqhLrBEYyFicOl5rt+KKXPfdTvCuXoK1xtVPxSsXRt6TJcV/jPb1UF4RbnY/HTKGy1cvn/fVZWZx/HWS3eTo87ZzBlbuK07T14N4ylpT7vYzBMgFHXX+Uimf2UAR4YG1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 008c5bdf-3465-4eaf-0d6e-08de8df8abd2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 01:07:10.8872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/qvBulX+8uT9oLWlupKauVEQRJ74miiteof428GCPPoneRAvOT+Zx4TDIoR2IPL3HK4IZMT5ZbaLQN35lzevOtECLWhBocIKirSnWFBlEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1A34EE115
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL Protocol trace logging is called for Endpoints in cxl_handle_ras() and
> cxl_handle_cor_ras(). Trace logging support for CXL Port devices is missing.
> 
> CXL Endpoint trace logging utilizes a separate trace routine than CXL Port
> device handling. Using is_cxl_memdev(), determine if the device is a CXL EP
> or one of the CXL Port devices.
> 
> Update cxl_handle_ras() and cxl_handle_cor_ras() to call the CXL Port trace
> logging function. Change cxl_handle_ras() return values to be pci_ers_result_t
> type.
> 
> Check for invalid ras_base and add log messages if NULL.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v15 -> v16:
> - New commit
> ---
>  drivers/cxl/core/core.h | 10 ++++++----
>  drivers/cxl/core/ras.c  | 36 +++++++++++++++++++++++++-----------
>  2 files changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 76d2593e68c6..984cc37be186 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -6,6 +6,7 @@
>  
>  #include <cxl/mailbox.h>
>  #include <linux/rwsem.h>
> +#include <linux/pci.h>
>  
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
> @@ -181,7 +182,8 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>  #ifdef CONFIG_CXL_RAS
>  int cxl_ras_init(void);
>  void cxl_ras_exit(void);
> -bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
> +pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
> +				void __iomem *ras_base);

This change is unrelated to the conversion to call different tracepoint
handlers.

>  void cxl_handle_cor_ras(struct device *dev, u64 serial,
>  			void __iomem *ras_base);
>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
> @@ -195,10 +197,10 @@ static inline int cxl_ras_init(void)
>  	return 0;
>  }
>  static inline void cxl_ras_exit(void) { }
> -static inline bool cxl_handle_ras(struct device *dev, u64 serial,
> -				  void __iomem *ras_base)
> +static inline pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
> +					      void __iomem *ras_base)
>  {
> -	return false;
> +	return PCI_ERS_RESULT_NONE;
>  }
>  static inline void cxl_handle_cor_ras(struct device *dev, u64 serial,
>  				      void __iomem *ras_base) { }
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 48d3ef7cbb92..254144d19764 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -291,15 +291,22 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  	void __iomem *addr;
>  	u32 status;
>  
> -	if (!ras_base)
> +	if (!ras_base) {
> +		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
> +				   dev_name(dev));

What does this new error print have to do with trace logging?

>  		return;
> +	}
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +		return;

No need for this thrash if the tracepoint is kept unified... more below.

> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +	if (is_cxl_memdev(dev))

Wait, the whole point of patch 3 was to make this tracepoint generic.

The format string in tracepoints are not supposed to be ABI. Incremental
fixup below. Now, there is a difference between "not supposed to be ABI"
and "whoops someone had a dependency". We can always come back and
restore the old format string if someone screams. It would also be nice
to delete trace_cxl_port_aer_correctable_error(). That one might be more
dicey from an ABI regression standpoint, but worth it if you only need
one tracepoint for all CXL protocol errors regardless of source.

---
 drivers/cxl/core/trace.h | 14 +++++++-------
 drivers/cxl/core/ras.c   | 25 ++++++-------------------
 2 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 5f630543b720..70c9e65bfa08 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -145,22 +145,22 @@ TRACE_EVENT(cxl_port_aer_correctable_error,
 );
 
 TRACE_EVENT(cxl_aer_correctable_error,
-	TP_PROTO(const struct device *cxlmd, u32 status, u64 serial),
-	TP_ARGS(cxlmd, status, serial),
+	TP_PROTO(const struct device *dev, u32 status, u64 serial),
+	TP_ARGS(dev, status, serial),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(cxlmd))
-		__string(host, dev_name(cxlmd->parent))
+		__string(dev, dev_name(dev))
+		__string(host, dev_name(dev->parent))
 		__field(u64, serial)
 		__field(u32, status)
 	),
 	TP_fast_assign(
-		__assign_str(memdev);
+		__assign_str(dev);
 		__assign_str(host);
 		__entry->serial = serial;
 		__entry->status = status;
 	),
-	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
-		  __get_str(memdev), __get_str(host), __entry->serial,
+	TP_printk("device=%s host=%s serial=%lld: status: '%s'",
+		  __get_str(dev), __get_str(host), __entry->serial,
 		  show_ce_errs(__entry->status)
 	)
 );
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 254144d19764..7a1319ce0f84 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -291,22 +291,15 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 	void __iomem *addr;
 	u32 status;
 
-	if (!ras_base) {
-		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
-				   dev_name(dev));
+	if (!ras_base)
 		return;
-	}
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
-		return;
-
-	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-	if (is_cxl_memdev(dev))
+	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
+		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
 		trace_cxl_aer_correctable_error(dev, status, serial);
-	else
-		trace_cxl_port_aer_correctable_error(dev, status);
+	}
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
@@ -338,11 +331,8 @@ cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 	u32 status;
 	u32 fe;
 
-	if (!ras_base) {
-		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
-				   dev_name(dev));
+	if (!ras_base)
 		return PCI_ERS_RESULT_NONE;
-	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
@@ -361,10 +351,7 @@ cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	if (is_cxl_memdev(dev))
-		trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
-	else
-		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return PCI_ERS_RESULT_PANIC;
-- 
2.53.0
