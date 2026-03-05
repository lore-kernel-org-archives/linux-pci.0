Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66B3093C3;
	Thu,  5 Mar 2026 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740175; cv=fail; b=DfbA9cX9WSEFaItRFaaGii0gnCVyL73bprJhPirr9Sv8qYIMEJrGpReQZh+DXE4imBhsPyRnoctvDbSiZe4TtysNiaUfZmT9qRNH6P12Q3/pacImfqAuzuuhpvCIjkSxxLnXHEhaR33bnZehVVuqNknpefoM/Lze5KEY9Io+GFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740175; c=relaxed/simple;
	bh=PcxQ3MPiRgu2N8I46bLDV2gIZTF0zY59PV6s5QTJqUY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=sIoDY7LD2IGB2KWYJmIn/2C5VqpyD4Ezh0nWYzIECc9kYMpEjHA9lI+OXEytHkWkkGXrqJEpRXY0PQhDz3yI0q8F1q1XnaTBDrlHpva117Xqsc741XdD1H6hSqC1dAvFND3NOR9nBXEUME4DyW08/4P4FlghZ9PbmsfOVTqxwJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVXQHNVd; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVXQHNVd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772740172; x=1804276172;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=PcxQ3MPiRgu2N8I46bLDV2gIZTF0zY59PV6s5QTJqUY=;
  b=fVXQHNVdWuvh3NZybxIhonrYzr9V4oI6qaXqc7e2QZXgmisLyOIzWu2X
   msOIy5Ep11cW2/CwbC0R26VhIhgwabJMGCe3tZ0LnlvsT/z/Z71ersxeh
   aOLaMEDT5wGH++sM7qq9JAN+cjY6mpg+tSDnzl5SeFz2A2somOtjTyKuX
   cXNbfn5nMG0uuJSR2Ak0aBBjn1eMCrlW484747/txDRi6mU/tp+C3j+E0
   1nfPWceepTlZOlkbvuGdszVh10J6CsUA8y+US2h78nkW4Uv/1RQC8br51
   Hw1W6S5Z8GmLvuXyz1aaAXFMO6gvqF650xy4mQaDBuzrud4UZTQhziqTq
   g==;
X-CSE-ConnectionGUID: PIBcNFuQRLqjJ05r0NdscA==
X-CSE-MsgGUID: +i042HZ6TneSfa3lMivVkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73713957"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="73713957"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 11:49:32 -0800
X-CSE-ConnectionGUID: i04oHGs+QWSS4TXjJUQRZg==
X-CSE-MsgGUID: w4AGdyLLRAyMgBpz36/uyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="216584678"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 11:49:31 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 11:49:30 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 11:49:30 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 11:49:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b63XSdyLCPqojO/6f+/exLtwIbGl910KNwigFJfRzEN1s8lNEVBO8qSzLbEq7S1J2cIG55iHcFkyRbK6V+y8R6Vbz2KX8tS44qbmH++cg5AT4WOyfRiKoSW4Lt/02VUA54ylHPek2+w1uRGeQ76GZjmCjDPFa0/flyNSlnZSganF4vdblOxPA5wYZ6jEMgQVQ9pHLzwD4yiKjPYEEBBy1i1XsPc1mbN3fZ/hDd4i0OlZucLQ2em24nymavePW+mTC+bz33XCNHxIm069FwtnvNTxKm4s5yDTz3CEDQT5CMyO9idp2kPNOiRMTpkP58aG0ybobSA8k/GHwYEF9H3aGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEXT6XlO117S98cq3vKTBeO/uqN1lDWsNh3pCkw4lfo=;
 b=JNXnh94VRGcpLow/4V948hrO/l/eQVSpa1ZpzSpwXBnQzvjG/xzcpCuwqWOTfHgAVCYIcGGm9dprewz1bFiPLRKiDHtNygaq0R2REEA4xMmQVo1RaLNyXWvlY68bbXCrtYGb4Mng6jeUoQAfIh75bDgfgGmBtJY1zqpKaGBP5gT/DMkj30Lrbv/z3iTWuniuZutFAsZkTzS5QToXlfyafk3XIMHhOk0jCUXGmDTDTltARzL/ra1pJfTrNwtXaMARCjVjuaB0IXUwvPYhcuSPi/M01hX3ioYuhlmq1yMAdT8lQKHFg4/VTMEXIFTAanY61qZ+KvsJm7qH4w95ASIAKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Thu, 5 Mar
 2026 19:49:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 19:49:28 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 5 Mar 2026 11:49:27 -0800
To: Jason Gunthorpe <jgg@nvidia.com>, <dan.j.williams@intel.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Lukas Wunner
	<lukas@wunner.de>, Alistair Francis <alistair23@gmail.com>,
	<bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
	<akpm@linux-foundation.org>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alex.gaynor@gmail.com>, <benno.lossin@proton.me>, <boqun.feng@gmail.com>,
	<a.hindborg@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<tmgross@umich.edu>, <ojeda@kernel.org>, <wilfred.mallawa@wdc.com>,
	<aliceryhl@google.com>, Alistair Francis <alistair.francis@wdc.com>,
	<aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>, <aik@amd.com>,
	"Mathieu Poirier" <mathieu.poirier@linaro.org>, Thomas Fossati
	<thomas.fossati@linaro.org>
Message-ID: <69a9de4791667_6423c1006c@dwillia2-mobl4.notmuch>
In-Reply-To: <20260305124837.GS972761@nvidia.com>
References: <20260219143129.GF723117@nvidia.com>
 <aZcnTnYJ61Kma0yd@wunner.de>
 <20260219173937.GH723117@nvidia.com>
 <aZgbukYiIxg44_e7@wunner.de>
 <20260220141057.GL723117@nvidia.com>
 <aZn9cfhv0YRxI1mw@wunner.de>
 <699a3ff3f019a_1cc5100e1@dwillia2-mobl4.notmuch>
 <20260223171527.000016ef@huawei.com>
 <699ca65b5ff9b_1cc510019@dwillia2-mobl4.notmuch>
 <69a903d4511e4_6423c1004d@dwillia2-mobl4.notmuch>
 <20260305124837.GS972761@nvidia.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:217::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 7111a7b3-2b99-49d6-bbd8-08de7af04fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|3122999024;
X-Microsoft-Antispam-Message-Info: l2gZyUM3ZBHhHLcd85AE1SdHYfw7+3D5Xzdmy1nlcpeXSwRyfyfP/gfVOmfQnhNH06f6QCbj0c6jsR+igsKpnWaZXPJ3nMWeXAK69SB7CTgAKzzzSSeSlITaHXX25M4lr5GeHMvSfTAoDiFOPB+4sOc+9PgPlaFxEcYA2Dd7akZd5uGFFR96yVEvCHUnpBC9s3ROI9JPjVsLu+N+ufG4YN1mEWFSMLmP//wAynDCMiwgTJpw/KRC0A376QNpxPLnl8zxS7NwfdiBL70nIdB5FLUVVKsUg5xI/tI1c8n4/GVI3ygtSB66AKsi++uvMXJmRMH0vXeagGmDO8m++jvm7wqAtYPUDaus2+r0CuVrY2KIlsk8iLg4dCgteo4izHIQx6oKok2EZWASqj0BLR91S0Kptriz79DYEoki670Pv/ks8kgt73V6Zf25jdy0MuMBLp2kcNSlw2VSsBU4XHnwkHlVfA1s6FQHZIkGNrt8SObpQNZKw7l3SMiBhRRjzaaU2+xIFJ9CMaoNfxxAAidWXHcyINGYAwUCsc89CajX+uQWeYRkkX5d7c84JX4RzPATFmIPHu1XG4OBTrW8/L+adl9zyecUI/Zs3oXbR2JusGdLyj7rDk9NpZrcMT8xuNr7Oi54fIZGNs3S7MebSt1+KK8J/ScI92CbZT3C+dOZ/icKDNQuL0qmW8DmA/KB04f+BUzYOBO2aGJtl17JaWJp/ucsIWQqmNpRpMDLW/99maQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(3122999024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnZDMmt3Yk1FQTBsUDVGZjZDTFlmMENvQW91T2t4Vmh5RUs3ZlczOXc3NlNx?=
 =?utf-8?B?bnhIVG51dC9yTmJMSXZPQlhqckFSdGh5YXhkeC9URitMcDVWdStsMlVJb0VO?=
 =?utf-8?B?N2xUNEJBOWhZNVFWZ3ZhWGN3WCtNVDdBSGVBcWwrSDZqVlUvcW94THVKZXc1?=
 =?utf-8?B?SXNyNENoQWZUOHBvL3hUNmUwbHA4eEhCS0FjUzZCeUx0bWJ5dWpON0NnaVZS?=
 =?utf-8?B?ajBVcnByWk5ZaWEzckt0ZXNxL2YrWm1JRUtVN0N3ZHlWR1RVWWIwY0FPUW1F?=
 =?utf-8?B?M1ozSkg3dUxHekdiMG5yVVlITEZTMEJHbWJTR2kyakRWbU1jRHp0SWgzZDVU?=
 =?utf-8?B?S3FWZHpDbzVNVHRLa3BkdkcrVmdVc2FyOVg0OTZJSjcwZklzWHNVMnVwNnNK?=
 =?utf-8?B?TGorVnA2M1dicFc2eGF4bTAyOHp4eUZUYVR1cTBNMkprR3RFQzMxUVNQMWt2?=
 =?utf-8?B?bHpFMkQvN3BzWWlWMC8zek9FS1Z2RDhlS3hieC8ySjhza3ZzY2p5MS9aZndj?=
 =?utf-8?B?TURETTVVRDBLVDA2MUE4T0hXaVdSWjdkUnhaMi9sVnhtcVd1c3NWMm1GdVB5?=
 =?utf-8?B?MDl2ZTRFbzVVcTRJQnBJT2p2T2tFN0dIQUxDMzc3NXNQcGFIS2MvMXhhV1pB?=
 =?utf-8?B?OGxXeHF5OXNlL1l0T2Q5VUo4ZVRkeE5YMnVBYVR1RnByQUR0N011QWJOWnRM?=
 =?utf-8?B?bTNXY05BQmFoSUZoSy8zdURyc0xlUGV0YWNydG8veU44dU9NeVZ3S3lWSTFB?=
 =?utf-8?B?SG8zT3RmQit6RWhDVHF5b0pJZncwdXVMZmhQamx6Q2Qvejg5cit2Nm9Qb001?=
 =?utf-8?B?WjFlT2IzMW1McnRIQzlnOUVlY3AxUHdKT0ZjbGkwOHNZenc5cHc5Z3JCcWZB?=
 =?utf-8?B?YW9jVDFMaGdGM2x3UHRablY3UHBIcG9DRERGazY5RlZVZ2NMTFJEWk9SczE5?=
 =?utf-8?B?WW8xcm84Q2ZVZ0Ftb0t2Y1RsSEdHY3hoQTVnWHEvdWxZN0RDOFhEUCtQUkdo?=
 =?utf-8?B?ZTNLNWZ0cmk4dkxtc1BNZkFKQnVMOFQ2eW83VTcrR1VtS0hsYWRYeml2YlJM?=
 =?utf-8?B?bDhGVXU5Mmd6R2pUZUg3NXNabCtla20yemd1VTJ0SW4va0xlWHJKa1d0VE9U?=
 =?utf-8?B?KzNGQWVmdFZ2OEMwSWRFT29mTzNMc2dHNDQ1WmdJaENWVUtQa2kvbXFsSjVP?=
 =?utf-8?B?VHRQdzFsTU9MN0NjTE4rOUJ4NDVZdFVUNlExS2p4a2ZZZThNb3JLRllIb3ZE?=
 =?utf-8?B?TmpadE1vallXbGc5REd4cXdmbUtjdEwwWnFHV0JySnNXaWI3bThQMDhXU2pR?=
 =?utf-8?B?U20rbEpFTFFiYWUzWHB2RHhWdCs3UUhqcFk4Q2xMS1BCeDlHdEFETFg4R1JF?=
 =?utf-8?B?Y2J5aW56Z0VvL2lHNUxJWGxLaFdXeU5LeXRQM245T2hwMDJVeVM5WlN2dFVm?=
 =?utf-8?B?Ni9ZQ2pvRnkzdjFrWHo1UnZWL1ppTUJrbW5KSjVxZnBKUGRLWWJyV3RXdVVV?=
 =?utf-8?B?blVEZ3VmSkZTbU1uT1UxdWF1czFRUnZ1SkV5WUVDSFZhR0Z1RzVha2VjT21S?=
 =?utf-8?B?c1o5blIvdGpjRVVMZnBTWFdHSFBVUHNKMHFac3lDMjE4RndLR05NUnpkS0Np?=
 =?utf-8?B?a29DdU9sdGI4TFk5ZlNEMkFadEJRTXhmNHQxSy9JVzVKdzVhZlNTTHpZVGFO?=
 =?utf-8?B?RUl1QzEyd0Z1MHc5OVduMVFUYmNjZVVjQTBsRzVFQUprTWFHaDRmaFZRN3JU?=
 =?utf-8?B?eEphWHJQemVEVFpiM0RESHpwNFMvN2JrK3VtRi8rTGljdWc3dWxSV1RmNXly?=
 =?utf-8?B?aUFFeUxpbjNLYkJjcjVLeEliUFUrbnNUbE5WSmdSZTlPTUNsbXlTQWg0UDhk?=
 =?utf-8?B?VXRVWm4wNlBWK01iYzVMd2kxckZ4TUZGVW4zVjdDK2loZnlMVUpsdzFDZjly?=
 =?utf-8?B?bGtncEpCd2ZaWFdnVm0rZnBsSUlMRFgyMFhMWUY0cVJsT0JiVjZvK21yRVpJ?=
 =?utf-8?B?Mm1HT3M4QlN2RXRxMVplQ2NjVXd1T05MdndFcWFvd3lvc2Vaa25XWGV6N1dZ?=
 =?utf-8?B?b2ZKZEJyVzNLUksrZk5RMDhrNlFyRmV4TG96SVM0dEd2SEJzS2gyclhNaXVm?=
 =?utf-8?B?UkJOT0RzSk45NytsMngvM0tpODA1L3haQWdOUk5iQnhPSTMvMk83dXhWdTZJ?=
 =?utf-8?B?OGtnUWlpUnhrd0VpbEtZY3JxY0dJbCsrak1PWUtUcFJIa0xGb0owbUEvcm41?=
 =?utf-8?B?eXR0b3JPSmZiZzFWUGtrWlEySnBScGtqOFNoWXB4K0dSQW9tclpSdGw5Qno1?=
 =?utf-8?B?TEJJKzVsdWx1Z0ZKVmdweHNjZzJpcyszd2RCU2RJU1MxUGppME9nd3FBaHpX?=
 =?utf-8?Q?LBS+gxMCQ+uUeMOk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7111a7b3-2b99-49d6-bbd8-08de7af04fa1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 19:49:28.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdBHSFxEqiWPP2Blict+SlNsJRmN0zb0g2WVtcBJwB/OrIlTBfXncl2LBiJ7lfxPbosTE8MEvanY8zfL1B0oGQUIQ4TX/uAnfUZ6q5jSv7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Wed, Mar 04, 2026 at 08:17:24PM -0800, dan.j.williams@intel.com wrote:
> 
> > So I ended up dropping this bit of the proposal because there is no need
> > for the kernel to be involved in any decision about the validity and
> > sufficiency of device evidence. Userspace has everything it needs to
> > make that initial determination. "Authenticated" simply means "evidence
> > ready".
> 
> Right, this caching was only for the automatic device recovery flow.
> 
> I think the kernel still probably needs to check the signed nonce
> against the device's public key as part of the SPDM handshake, but it
> doesn't need to do any validation of the public key.

Yes, and I think this is a subtle detail that I was failing to grok /
communicate previously. Of course the native SPDM implementation needs
to be able to perform a challenge response to establish the session. All
of the platform TSMs also internally carry out that protocol. The
difference with platform TSMs being that the kernel only sees the
resulting evidence.

So when / if the PCI/TSM evidence implementation grows kernel-internal
revalidate support it will be growing something like pdev->tsm->pubkey
that is installed / cached "after the fact" for platform TSMs. For the
native SPDM driver, pdev->tsm->pubkey can be installed at 'struct
pci_tsm_ops::connect()' time because it already has it parsed for its
own internal purposes.

> > Automatic device recovery into the TCB is a separate concern that needs
> > to be prepared to handle more than just "is this device able to generate
> > a fresh signature with the same cert chain that userspace saw before".
> > Yes, that is a minimal requirement but not sufficient for many cases.
> > For example cases that want to validate measurements, interface reports,
> > or opt-out of recovery because SPDM session loss is fatal.
> 
> Yeah, but it is a pretty good starting point :)
> 
> > Authenticate a device
> > =====================
> > Look in /sys/class/tsm to find a tsmN device which will be either an
> > instance associated with native kernel PCI CMA/SPDM or a platform tsm
> > like the one provided by AMD SEV-TIO, ARM CCA, Intel TDX, etc...
> > 
> > echo tsmN > /sys/bus/pci/devices/$device/tsm/connect
> > 
> > Once that succeeds the PCI/TSM evidence netlink interface is available
> > to dump any signatures created during that session establishment.
> > 
> > After userspace is happy with that evidence it can bind a driver.
> > 
> > If running in a confidential VM where the TSM driver is capable of
> > securing more than just an SPDM session the interface is:
> > 
> > echo tsmN > /sys/bus/pci/devices/$device/tsm/lock
> > 
> > Similar evidence can be collected, and when userspace is happy with it
> > it can accept the device:
> > 
> > echo 1 > /sys/bus/pci/devices/$device/tsm/accept
> > 
> > ...and bind a driver.
> 
> Makes sense to me, userspace can figure out what flow to use.
> 
> > Auto-recover device (future work)
> > =================================
> > By default, devices fall out of the TCB on recovery events for the TDISP
> > case and need userspace to rerun the lock and accept flow. For the
> > native SPDM CMA case the default is that the kernel continues to operate
> > the device post recovery and only userspace polling could detect device
> > replacement.
> 
> Even with SPDM the kernel should know if the SPDM session has to be
> restarted right? It could squirt out a netlink multicast message, or a
> uevent on these events, so the polling is not baked into the
> architecture?

Right, "SPDM session lost" is a reasonable notification to put into the
interface and "future work" bucket. The polling comment was with respect
to the near term limitation of this minimally viable first step.

> > To go beyond those defaults the kernel needs userpsace to tell it how to
> > re-validate the device. I think that can be as simple as a netlink
> > message to store hashes of cert chains or measurements and then use
> > those in a new challenge / response with the device with a kernel
> > decided nonce.
> 
> Yeah, I see several reasonable options:

+1 to these.

> 1) Above, kernel is informed of hashes and does an exact content
>    compare
> 
> 2) The driver operating the device has a built in same-device policy
>    and deep parses the evidence for equivilance after the private key
>    is validated, carefully avoiding volatile evidence bytes.

Yes, Lukas was also pointing out that the existing driver reset/resume
handlers could signal "revalidated" as well if the PCI layer had no
opinion.

...but the point is that it is a menu of options, not a static policy.

> 3) User provides a BPF program and it runs on the evidence
> 
> 4) Standards bodies define a generic "same device check" algorithm for
>    the evidence and core kernel just does this for compatible devices
> 
> > The equivalent behavior to what is present in this SPDM proposal is
> > extend drivers/pci/tsm/evidence.c to add a netlink operation that tells
> > the kernel to cache the public-key and challenge the device regenerate a
> > valid signature. Then plumb all the recovery paths to call a new
> > 'struct pci_tsm_ops::revalidate()' operation in all the same places
> > where this patch set wants to reauthenticate. Later when something more
> > sophisticated than "challenge the device to create a signature" comes
> > along it can reuse those revalidate() hooks.
> 
> That's a nice simple starting point.

Appreciate it. Still want to close the loop with Lukas to make sure
everything he wants to do for native SPDM can fit in this scheme, but I
am feeling increasingly confident.
