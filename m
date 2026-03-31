Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9798438F633;
	Tue, 31 Mar 2026 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774985000; cv=fail; b=hOYHPsNaF51LqMEzg7iLNVbNBRwy4jruSUwzNN6XQNCrqE5AwcQHEULoFcVnlAsrEs3Uxltyo2egECTlLihJ2feReMnglmTlud9CQlX8cJsakJHfHErwBYtjIH8HqcENWHF4+YiYWJlnsjoxQc0MRyCRAJcs01zq7ve5SN9ujvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774985000; c=relaxed/simple;
	bh=dzVUbVEDokegYe3SJcAjn2cgucB85HQPpeN1+Y8KxFE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=bV+4iyO/6Aj7lmCbiLw3p2Ege6JF5NcRZz7X39krnuV5RMb0czQXzRZufKEKXbSuS2jL1atz0n1pizlpCXPQJVtRnd392DoOjLN0h7Q52FNM1skI/B1KYyteWOlP75LeUngQCZAoKCtV3l0Qo6CMqtNaqFVOzuKrg/3DxNvL4zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIjjK2qc; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIjjK2qc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774984998; x=1806520998;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=dzVUbVEDokegYe3SJcAjn2cgucB85HQPpeN1+Y8KxFE=;
  b=HIjjK2qcMa8wDufP7qIhs6MgjsUCuq8gQCEGpvOTsvknRymugbzwbGlU
   mvha8dFjYvLa/5Cp9rSN08mKsm72p5rvl0FdNJ59u8HhrXQ3gIwknPowf
   IXHFeTTG4uTdl/NpreIJuKp+K16Fzz5sNy7L9j+56+v7rVVtIftzb0/uu
   9ELTTchEh7Y4QjLTNDdrhNpoSR+hlKUAL1JLVFeQcmycYDxsI7U8ypTNV
   fR9CObsozIzrnWAlgtNKH2iU7R/FuIMnFU21LjJzXuiY7h41g06FQp6um
   L1CrMOMUEUqDefy0UJBG27qLjXlN4n0/hD2LuWmX8e+viMyuExMxd60AE
   Q==;
X-CSE-ConnectionGUID: Jx+zUEjRSpSfy7fVLGNnZA==
X-CSE-MsgGUID: 1s9pCJvuSt+rpKzqBFL+Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87085738"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="87085738"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 12:23:18 -0700
X-CSE-ConnectionGUID: /0dc5/QJRaGNa5gTbAf+iw==
X-CSE-MsgGUID: I0WjggKzTIKtli4uuJFN7A==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 12:23:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 12:23:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 12:23:17 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 12:23:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuzqU5cxW24cDaKTjJre0L53LOFUPpbRtAISksl7xa2qYmY1nhdrAX+UXejOoTL9fDCE7JOR7F+g7qxDU7k4oFRNtsYVD9mzybDLp73U3vi1YcTWmm9qQ9F7qFDBbRo8h6sH0e2E8J2ht8SrrdNI3833C1ax1Y1y/99J+yXFTzkij/BI7M0R6F1HZInPesezBZWWlnGani/iqDAroHJj9SMDmUPExuzzq9Otd01JgLXVl//0rDlm8akxQLENXZq/DQChlM7BEqOYMtb6+b9ebDL0c2sjw9sHa/9efWUHGBX+TMcmFwu8gb5BSaZ7e+wnMBG6cE0FszwkI12lG8qYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFyp3a0y09VMJDARyDpLqEfDZfjHfWFzIMnRkchSf04=;
 b=A2dRqSOr+DoDoYnrW5zwgD+qhBkow8MP0wv54lODsDrIFv7TJWITGz5uup9c171mcFyXTT6sBvw8WwMIu8EMMVqG/6QsNyKd1vTZzeEndP1DQ8XcwQnUZ9rUGMcXpaBF95/HC5LuWlYlz85ktLoEcsKWvhexexv7ArqxM42VONfjJ1avN6LJQjTtYAU4DRXVwKCIOTArK2eIZRmPMjYgw5iGgmJwbTmmcN59o9Qh8dpjlpXacFlYel4Oiy08xB5KGNHMeTszPMo03KRetkFORe7dnabJyQp1qc7W1MXUOhJi3jvzu5IlYzfLIbrhCcXUGFP4BIxHCZWNTPCD5zdGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:23:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 19:23:13 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2026 12:23:10 -0700
To: "Bowman, Terry" <terry.bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <69cc1f1e5c432_1b0cc61002e@dwillia2-mobl4.notmuch>
In-Reply-To: <678f2b92-8f7e-4a6c-a66e-c19434de19f4@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-9-terry.bowman@amd.com>
 <69c9d04baa431_178904100f1@dwillia2-mobl4.notmuch>
 <678f2b92-8f7e-4a6c-a66e-c19434de19f4@amd.com>
Subject: Re: [PATCH v16 08/10] cxl: Update Endpoint AER uncorrectable handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0317.namprd03.prod.outlook.com
 (2603:10b6:303:dd::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4650:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca4dd27-c343-4c6c-ad62-08de8f5af3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0yZvh/UmBsCtWiNGu7RaMfFjT2bXZqQ5ePzXJAQKq7kbQeD5bdNa68YwnBlpNtP0KiSGBmnrQxlNIHaNd6qj4Js8PsuOi6YeKtQwj8gcG5HDTbrOTplLCQTgPvXDSlJpHVHqe/HsaGxjz6dx4rZ63i1W0ByfSmcVD2Nl390+SwfmPeZfh+0lBwU+UBBg5/DmYF8hFR8RGPoiqWeYVAlmt0lqvU9Qud3A9X+nXHycfpxk4MlOGX4XyQsHvtpHVlgMbRhP7sNqn2seVbjw9FdhD4ef1dr9PVDEGW54aDTi0iBotv9Ro7KwzkSLPTm7+L681uZgR8bBPCgLQ/VwbbyAfpCFc8mwZ2qwumnYNCw9EXgVY1Tqmn4oYO0fzpVlnGPYZp5t7X1/dce0TqysqZ+oCHCHZQ2D43/ZqbWp1ZoyRhYb/0q+iQAMfuewDKhSi2iKYuT1pDOzrVMe+vOcCFmCgQktfPdlS711U5Nj5PlTYE788A9x6YI+mqN1h6w3rzT6JZ33sw/slNNejVqRGvXIBPLLxn7w33INZV5CycokGakdvGqEib/OWPjtqOKKXoo01y1B0a4nOWrVV48BzdzjxxV7Wsnshdz/oEs2mlBtJB/eX3avWI0zSzkMQBIP8+l9Wufi6bT/S3Un67EloKwbEoa6x6qBF4beJbE/dydp1Eu4MtN+D8vysc8+2rtWOYDLQn25Uzw2GHv5p71E+siLiY/2ua6A3fnFM4TADgo3/mUiGLEkU/aKVX9GisMF4X4dkvTZGUEVrAebu5aLPW7NNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGRzVlNRWVZoNXJ0cm1WVVNYQ1ZMM0I0dVM3Q3dOcFAzUlVtbW9NK29GWVU1?=
 =?utf-8?B?TEh3cWlGRVZ1SXVPU1grSUlDWDdGbncvNFFhTk9Xc1pUM3dDdURQMytmR09n?=
 =?utf-8?B?MW93UnRRTFdySlo4UGtYZStLelRGQmdPaWs2c01oUmRNUGhVODJ0SlpSTkRt?=
 =?utf-8?B?eXFmS3BjR1p5S3U2WDViSHVqbEh4UlJUQmFWMjM1c0tvM2pkTTNUUUJjSGha?=
 =?utf-8?B?a1d1ZXZscVh5THJmdXVXalljMnkwOElYNmQ2aVErR29wZkpVdENTd2tFVm11?=
 =?utf-8?B?MzNXR0NCYTNjNHRDckxoOXE4UkJLVUwyVlF6UkpVYks5QWI1QkozUVp6b2VM?=
 =?utf-8?B?QUVIdGEyR3ZWNFZyR0EwTmJGc1lJVng1WU5PTDNqSVRHWHBrenV6TXJHcHlm?=
 =?utf-8?B?Z1ZJL1M5QjArNzBOQzBXenZ0UHE1eXZSRUNMZ1hJOHA5WXFXUzk4QzhZbEpz?=
 =?utf-8?B?eldnODFOb2xKbzFiSWdPK0JnSFRvL1VvOVRYT1hkVXgrSHRFUlFiT0pHa2tZ?=
 =?utf-8?B?TnVWbWdYckRXY2I1VUNvbWRkYzdJSGtiVUZ6MmhRWkdZM09oeUJ3Z2pBRFZ4?=
 =?utf-8?B?RnJja1pGZGdtSnJab3dJbUh0clA3MTErZEdWNWRkck9KTlJuQlR4ZWQ1dmNC?=
 =?utf-8?B?alBSRzlQRXVMS2hUaFZCSExQU0w4Zm1TOVdRdHc0WER1akZORVZtaFFTaFlU?=
 =?utf-8?B?MEhGMWN0L0lBeEkxLzlJM1A2NG5nSmVIYkdhZkRaY0t5UFZmSVNNV2l2OExp?=
 =?utf-8?B?L0NRZmhURHZIclQ5MnJ5YUJRQlpWaUppMHU4bWd0L3ZLaCtWdjV3TnBZTHhU?=
 =?utf-8?B?ZktIUUV2YWY1Z2pqczZKZ1BGOWNNNGViSTR3QktEcE9QRXBSVE9GL3hPS016?=
 =?utf-8?B?eVF1c0hiQ1B2NmJoRjVKRlEvNUdnckJNdkY4b1lEbzNtYzFPZEI3WUhLeHda?=
 =?utf-8?B?aE0vbGdYWFpjYnVjdlBOUUZJZ0R5Rk52UTYxSUxTRi80QlJUMEhET2hId29t?=
 =?utf-8?B?QmdvdmtqeElPNGtGTEttSFNjTm4xKytGdis2R29uemFJa0lYOVRjTE5EUzZU?=
 =?utf-8?B?UnI2cDV6QXFyRU9TQjFRcFNBUzFUNmI3eFZQKzNUenErRXRVUlhxTUplUS81?=
 =?utf-8?B?US9paWFCY29CQWpPQktURm0rREdpZ3FMdUg5YThudlMwLzdwaUdNOFI3aGtK?=
 =?utf-8?B?MWlLYmZLZVFhT0x6NGRHbFFlU2YyaW9KcmphZEZnWERoRE50bnp6WjZaUGt5?=
 =?utf-8?B?ZXhOTDNnR21WdThja0ZYS0ZBSmZ6SjUrMFFpdldwU2s4cDUxV3BlZERvaWpV?=
 =?utf-8?B?TG00QWxmNzJZYlBCa3dXTUtXcUFSM2s1VVBPRjdQUFVPcXAvMGFmRFJhSFRq?=
 =?utf-8?B?M0RvY3JVN0R2Tm5MbmtKaVgyYXVZcTRDUnlZc2NPdDJuTHFudEt1WVRReUQv?=
 =?utf-8?B?bUUrMDRRSG8rbWJpQnFvZFFocnZVZTlKMFN2VDlzVGprMjQva1pVZkRKMVNL?=
 =?utf-8?B?NGZJM1hRdnVRbVp0dUtkVGozR1JGbElabmYzK0lxVGhOeVMxNEJqeEU0Zm1p?=
 =?utf-8?B?citWM2RWa3E2empWQjAwUkRjMlFjQ003N1VCTDY4VmhpRkdYZjdVWWsrNWFQ?=
 =?utf-8?B?a3ZNbnI3eHlTeDFkTkFDSDRjWUJYRVFvNk9SdW1PZzVUbVFGa3RiaUdCY0FJ?=
 =?utf-8?B?dUx1SUhHU0M3TXJyNXh4NmxOU1dHM2p2UjJ2R09hNEZKM20vaTFtQXJ3bkhK?=
 =?utf-8?B?WVNhWTZ6bnFLWTN3OUN3QURPUXMvQVFWZnFvemhiRVdQVlFlUWkwYS8ycDlh?=
 =?utf-8?B?TVNiQjhMVGlvQnFNNVc5VkgvSEwrblBIL3NHSDV4NGZBZlBGZE5UL2FHbjQz?=
 =?utf-8?B?MnlOamhlVENteHY0VmV6QWFvcExkU01DcDVkSXRHWUIybE9Lb1BsTGVqa0No?=
 =?utf-8?B?RW91anFqSlM5SjlBVmpzNmZqczdzajhEZ3Zqa2tzYkJ1OUxqcUkwWFdyczdR?=
 =?utf-8?B?ckVrWUUvUG12NjFCbk90Q0xyZE1sUjd6enM2VzdIVWpjaDRKaEJTbUxhTW92?=
 =?utf-8?B?SWxaQ01FSnJNOUFxOTdadkdUTEFmUVM2UUhuMVBMdUk0UEROd08raUNRYUN4?=
 =?utf-8?B?VU5KOHdnNHZFY2pjaHVCZjNIcFZneDdtVmZUQjRTSkVodFplczNQMkNCaVBI?=
 =?utf-8?B?SERKMVRoVkZMUlZ4ZDBtak9FYW9YaEMxWUdTakZ0UlpVUitwSlFNR2s1SGw1?=
 =?utf-8?B?WnhvMk4wVmw4V0dMOVJnNityeVZzRTRMSmRDajZqd2ZjM3lnRDZMdmhDMVRL?=
 =?utf-8?B?cFJ5RmpjSWtGSnpKQlJIeCtqc2hQSFFxcmo1VUpqRFlxVitsbVdEQkw5aGZC?=
 =?utf-8?Q?+qrT2rzeqj28YenU=3D?=
X-Exchange-RoutingPolicyChecked: ldp/Mo8a8DKBwWenHojbvT3r+RCpfxmOCjG6eANZ0knmoxhqw7t5UIXA7UqX1ik3YWQqTIMO/TXQ2TdvOHShTc7Sn/Lr2Z12dDyYb7DEWo1PPkrMh+05HLF6OfzbtkaqjJlY+wEMI+hN9qihx72VOnaTRGEAp8ueZM27S9H1C/9S2mtVpaR31BCITY6PJemLVaGRG3SmnWLKVp//mCPE2+6aO3Cux3+h8k0ia5Az41c1FeClbv4IS9RNTWKxdKEbqil3zGr/zErHeI2aKAwtZPfko1MrOh49Xj3681m2K4nsuhvenusJFI2VVI11z2OTF3gxuY5XiCUJA+lw1a0FEw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca4dd27-c343-4c6c-ad62-08de8f5af3c7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:23:13.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6dRtlvLzvh/HYcny/Q/acKWl38qURLjt4jMc2VIxXY81dWi5OoFvKYHQ7+3By/oUbQ/pSl4JMraZ+Wxmbr/hkNsvq5sD4r5sO+8JiUB3hM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> On 3/29/2026 8:22 PM, Dan Williams wrote:
> > Terry Bowman wrote:
> >> CXL drivers now implement protocol RAS support. PCI protocol errors,
> >> however, continue to be reported via the AER capability and must still be
> >> handled by a PCI error recovery callback.
> >>
> >> Replace the existing cxl_error_detected() callback in cxl/pci.c with a
> >> new cxl_pci_error_detected() implementation that handles uncorrectable
> >> AER PCI protocol errors. Changes for PCI Correctable protocol errors will
> >> be added in a future patch.
> >>
> >> Introduce function cxl_uncor_aer_present() to handle and log the CXL
> >> Endpoint's AER errors. Endpoint fatal AER errors are not currently logged by
> >> the AER driver and require logging here with a call to pci_print_aer().
> >>
> >> This cleanly separates CXL protocol error handling from PCI AER handling
> >> and ensures that each subsystem processes only the errors it is
> >> responsible.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> Assisted-by: Azure:gpt4.1-nano-key
> > 
> > This is not a human. If you want a tool to do some of the labor of the
> > patch I as a reviewer want to know what labor is performed. This tag in
> > this case tells me nothing actionable about what needs reviewing.
> > 
> > See: Documentation/process/generated-content.rst
> > 
> >> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> >> index 254144d19764..884e40c66638 100644
> >> --- a/drivers/cxl/core/ras.c
> >> +++ b/drivers/cxl/core/ras.c
> >> @@ -393,34 +393,41 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> >>  
> >> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> >> -				    pci_channel_state_t state)
> >> +static bool cxl_uncor_aer_present(struct pci_dev *pdev)
> >>  {
> >> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> >> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> >> -	struct device *dev = &cxlmd->dev;
> >> -	bool ue;
> >> -
> >> -	scoped_guard(device, dev) {
> >> -		if (!dev->driver) {
> >> -			dev_warn(&pdev->dev,
> >> -				 "%s: memdev disabled, abort error handling\n",
> >> -				 dev_name(dev));
> >> -			return PCI_ERS_RESULT_DISCONNECT;
> >> -		}
> >> +	struct aer_capability_regs aer_regs;
> >> +	u32 fatal, aer_cap = pdev->aer_cap;
> >>  
> >> -		if (cxlds->rcd)
> >> -			cxl_handle_rdport_errors(pdev);
> >> -		/*
> >> -		 * A frozen channel indicates an impending reset which is fatal to
> >> -		 * CXL.mem operation, and will likely crash the system. On the off
> >> -		 * chance the situation is recoverable dump the status of the RAS
> >> -		 * capability registers and bounce the active state of the memdev.
> >> -		 */
> >> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
> >> -				    cxlmd->endpoint->regs.ras);
> >> +	if (!aer_cap) {
> >> +		pr_warn_ratelimited("%s: AER capability isn't present\n",
> >> +				    pci_name(pdev));
> >> +		return false;
> > 
> > How did the PCI core generate the error if this capability is not
> > present?
> > 
> 
> This was taken from the AER driver likely for GHES support. The aer_cap check is not 
> needed here and an be removed.
> 
> >>  	}
> >>  
> >> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_STATUS,
> >> +			      &aer_regs.uncor_status);
> >> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_MASK,
> >> +			      &aer_regs.uncor_mask);
> >> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_SEVER,
> >> +			      &aer_regs.uncor_severity);
> >> +
> >> +	fatal = (aer_regs.uncor_severity & aer_regs.uncor_severity);
> >> +	pci_print_aer(pdev, fatal ? AER_FATAL : AER_NONFATAL, &aer_regs);
> >> +
> >> +	pci_aer_clear_nonfatal_status(pdev);
> >> +	pci_aer_clear_fatal_status(pdev);
> >> +
> >> +	return aer_regs.uncor_status & ~aer_regs.uncor_mask;
> > 
> > Is the above doing anything that pcie_do_recovery() is not doing?
> > 
> > For example, there are zero endpoint drivers in the kernel currently
> > calling pci_print_aer(), why is cxl_pci special?
> > 
> 
> Device AER status is typically logged in the AER driver but is not for Upstream 
> Switch Ports and Endpoints with UCE fatal errors. The call to pci_print_aer() 
> is added to provide details about the error. The logic behind the change is if the 
> AER status is already accessed here (to be cleared) it can be logged to the user. 
> pci_print_aer() is used to maintain consistency in logging.

But cxl_pci is only attached to generic CXL memory expander endpoints.
What about other CXL devices, what about other PCI devices that would
benefit from general AER core driver handling.

If the driver is not going to do anything be generally log the error
that feels like a PCI core responsibility.

What am I missing?

> >> @@ -441,7 +448,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> >>  	}
> > 
> > I am getting the sense none of this is required. When the device is
> > trained in CXL the bulk of errors will be CXL port errors, when the
> > device is not trained in CXL it will not be in use. For that remaining
> > case, why does the driver need error handlers?
> 
> Uncorrectable errors of CXL Endpoints and Upstream Switch Ports are handled as 
> PCIe AER and not CXL RAS. This is because the AER status is not read in the AER driver.
> This is not read in the AER driver because the links are assumed to be down.

Why does the cxl_pci driver not also assume that the links are down?

> The AER driver directs the error to be handled by the PCI path instead of CXL 
> handlers.

Right, becuase a CXL link is not found. At that point is just like any
other PCI device and unless it has some specific recovery action to take
it does not need to register a handler.
