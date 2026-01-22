Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F225737882E;
	Thu, 22 Jan 2026 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100540; cv=fail; b=Y6J5vRjzELvVUGhOBc1rklKKqViYT67jemvGEl9txm5pwZTm/YlynFAp5OEpKV2UYGBCzKId8ALkgmutkF10euhbl72ryvfyuTS/Q99ygirxvL2imJzUd6yDBsx3j/aemnOWusCBRz9DdKvO7gSWvsqvSfc34BFAFIzxClOqEwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100540; c=relaxed/simple;
	bh=L/5HR6TYpQcS+FHfzOzMNMQnTc9iQooVmr2KcV4gMi4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=h/VG+n45JIoQGE95tg5epq7EX3A8PO4zNXnXRU4FyaLMc6bvjTxC3aN7V2eWoWsGvRLzhe/+Eufi4C00GAi16YuP2NEWNK/05lVDPG8S49ecBTJO7Tr17UFr6B/zemqRrVsjejPI+LAgm4MsEk0qYg5gwrl83c4Enr5MlOzhnbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzAwt98J; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzAwt98J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769100530; x=1800636530;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=L/5HR6TYpQcS+FHfzOzMNMQnTc9iQooVmr2KcV4gMi4=;
  b=SzAwt98JWcFTqX79DYyJMSVG2dVztFWDdjLFPvIQNDj/F8QLIOrOK6Rz
   m8nKRgHEh92DjlAOgZtp5UuQEJ+Dv5XQZcGhGeMpjnHd+O+rkntekFVtB
   WKWf9EdMC1GRburTnNU8Ralxsxjntoebx5GpjU2MABDdbnaeCbQgGHSnj
   11XLemUxrI4f7XXOH/bdwm5cYk52ZcZU5bujRrBh8q4wz52/GS04dOH7z
   sGKRBDOv/Y23lnSEH/msgJj7FSR2H/ms971fMe9ckcqqti4n/Mdf83kIn
   jOM8KNcm4aj3wNVxLYqqJkg54IymB+wYPOi3DudbpR1wySNe7/U97LgNZ
   A==;
X-CSE-ConnectionGUID: 8gliwnLVT2mBI3MY6fUL2Q==
X-CSE-MsgGUID: +Fn74V4LSm2sUi7DEWOh0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81719491"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="81719491"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 08:48:43 -0800
X-CSE-ConnectionGUID: HxOb0ZkUQdOzWz1ujV8UNw==
X-CSE-MsgGUID: Dl9cbn07QDGMZAVcDByeVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="205898736"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 08:48:43 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 08:48:42 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 08:48:42 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 08:48:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0aU3ba4v+RRI3FgmWLO5cTHm4CywEPivUowlDQNstSaJNsMtPeWT4iMLWQWGqGDECos8iJjK/PmMl0pLduHnXp91s0mwVTKNRRk5juWcQW0rrjfslFgCMLsKS4Mvhwndr2IDxQq/6tHOX3mEqxdSPaT9DvTjQuTiPhOEUIPkBFn6Mh1w66jJ2j67Hp86AUFP2Ch0+aQNzoui/sd9gR3stboEDtf70CeO1q6gFFGFD/b4YR9GOwo0CVXz3iZd4YIfyiomO7mDPmKiJrBtnub5l0JlfSTLM9WqsBBXMM8yLb+c3OHCXppzlqPWrGJ5CQMF7UXJiiiSWQLAWsTfJMjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dx9M7oJkpjaOWwjJyszeT+JaxVTQVNxwgcOpEGpkRb0=;
 b=qUJqVZ6Ieo7jsZZv1YT96wP0S1fDR+I2uF5gPLZ4HDH+wc/5w7DrXyzlg20g3eckQRnKOH4UmWIhCF31EgzixCF8W8Cc7swxd10b+74jm0Y6/FautfIlbNQQX+gU/rNgb4DL7fEOOM8IBXH4LHmUXICioJOBqs9W44xU4dzbaBKBLxHGIK1oy2GZPkcuOghpSjlnqTL0x0ZCXbLtKDP72YrmKl/5FSuNesu82c+R5mZNDHtG+f8Dt77vvy15/lcwh/oGvbTQ6lgQDDjQEEL6AbG3WefZWIWLm7jPoS94LZ2RBeN1XR0BJusO4pwjjsw7SmTwuaUPHwh0tMoDG6XY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5960.namprd11.prod.outlook.com (2603:10b6:510:1e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 16:48:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 16:48:39 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 08:48:36 -0800
To: Lukas Wunner <lukas@wunner.de>, <dan.j.williams@intel.com>
CC: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <697254e4efe61_3095100a3@dwillia2-mobl4.notmuch>
In-Reply-To: <aXH8gMf3zcaw8FF4@wunner.de>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-10-terry.bowman@amd.com>
 <696ee3e34f2d9_875d1004f@dwillia2-mobl4.notmuch>
 <aXH8gMf3zcaw8FF4@wunner.de>
Subject: Re: [PATCH v14 09/34] PCI/AER: Export
 pci_aer_unmask_internal_errors()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 451a0afd-8faf-416c-bab2-08de59d6178c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUIzRTJaOTRtU0VVQWZUTXMyRmxHc2NBYkdML21yWlFhcHdXV0VrS244dzJF?=
 =?utf-8?B?dXRKTjVlUWpKbDBWSXcrbk5la2J2Qk5ya2dIZHNpek5wRU9Uc2Y3aDBLQ3ZG?=
 =?utf-8?B?RUFoOC9xSUYrcjhJZGtCSmxVSHZoWU1XeWEySHFlNEh3Z3dZdGFXb2xuN1Y3?=
 =?utf-8?B?akp5WjlKUnpmSDdJK096VkRobnFPcUViVWg5MForUldWODl0a1lhQy94ZnZP?=
 =?utf-8?B?VnBRb2tOZjVBSm5lRXk5UktlK21GaU9JSzM1bHcvOERrMjdIQlBZZllMRDNv?=
 =?utf-8?B?eWlQWDFjWTB2anJFdXBXMGkweFNRSHQ4MWlxUlBSTFFKcG04SWlVQXNnanVi?=
 =?utf-8?B?TXU0eTd6bHBtMGx2RDgxdDVvYXVYUFlaKzhHK2FkNjFJMVJuME9OY1M2UGxq?=
 =?utf-8?B?Y1lPc0FIME5HaTkxc1F1YjhZZ28yUEk5QU40Mkd4Nk9JbXc1aEdNR2s4Rnd2?=
 =?utf-8?B?OVJOREhKeTdnODdwVG05c3hCdUlGeElrNGtLaUU1VXRIaXRIMTNQT3I1SWh0?=
 =?utf-8?B?NDJDUVptQnZlYkdCN3A1NUkvT3dqLytkdUQ4VVJCOHl4b2FYTkdMNFo3WVBV?=
 =?utf-8?B?NGR0ZUtJelVUN0lCdkEyN3VQcUdReC80NG1PQ3REUHQ0bmFZOTlmVVVJM2JV?=
 =?utf-8?B?Y0xhemk4NGRkaDlZaGZROW1Pdy8rbU5MUUNvaDVYT1pyd0F5MGxOL3psQmZy?=
 =?utf-8?B?VDJic1A5U3VXb1dDNlVaYnkxcmw0UTV6ZTdIZVFIZmJ1dndqOWUvakkvdlA5?=
 =?utf-8?B?TnhFYkpvR3ZLSytFTEc4K2VnV0lnbkhPR1lNbWhxb0tJZGlSdWlKNmlMdTAy?=
 =?utf-8?B?NHg5SFZsS09GNnYyazhZaUl6N1Y3a1pGWmoyMkxxS2pXNWNDRGoxT3FQLzI2?=
 =?utf-8?B?RzRhczR3bmVqRDE0WHhnTHk2SG5pYmRaSGNOaWI2OS9icDZyZkNuNVUzNTlW?=
 =?utf-8?B?SVZOOXZ6VWhlbmtCV2NLM2VGZllaWUg3d0QrUEQrQkFMK0oxOTZCOVlCQysx?=
 =?utf-8?B?bmNtS1hvQ3ZoaHFkbnU5aGMxbHdPTzN2TUE2MnBEQk9oSTY2ZlRVWUJla3JC?=
 =?utf-8?B?M3NBd283UkpXMUVkMU5pckk1QXNxOHVTQkdYZlpIVXZ6TWE1bkR4SFhiTUVk?=
 =?utf-8?B?UGRja2MzVUhCOWF6NHFtc0ZjcGpPQ1kwc2kwQWdrdkZuL3ZDV2NKbmZWak5h?=
 =?utf-8?B?QXZ1Q0Q4S1h1TkVsVXR0emg4azBjWGR0eVl4N0ZoOEhSaEsxUUFIQXZvZzho?=
 =?utf-8?B?bjRiR201clFVbXpMRU9NY0lmU1Y3OXRDY3pjeGRBMHRIUkFRbDQzdE4rOTJI?=
 =?utf-8?B?T0NCd1J2Mmx2VkRxYzluUW5mUU1kWERqVHEzRzc5YWR5WkhjUGpKNjZ3Qmtq?=
 =?utf-8?B?YUN2dThWbUdSbWNqeVYyTlpnN05FYVFMQzlCU2R1Q0ZncUdaMjJVZktmY3Fz?=
 =?utf-8?B?bnZNY1JPYk8xOXMvbTlkQkVaaFNrUkFTSDFlR1VPSHd1L01palhVWnNNTDAy?=
 =?utf-8?B?Q2lob3RwUERJOTNoN29TQW5FbG52WWRMMnZ4Z3JKS0Zkc2gxcmxURVJOalVZ?=
 =?utf-8?B?RlphamtwTE5QaVpGd3VxV0dKYjIxVllEV01EZHdsbXVKcGRKcUlZa3p0eExD?=
 =?utf-8?B?R3paUXk4bm5VbEtZYXVEMFN6M0tiUEMzeGtDQ0ovNnluSWNnamszaFM5ZlJQ?=
 =?utf-8?B?Wm92UUNWSWlzVmk2UjUzdVVFZDdFVTYvazFPamlHN2ZZaHEwS2l0ZlZKMElJ?=
 =?utf-8?B?OFczNklBL2VXc0hOSGxReEJSUUNJbW9Dd3Nsa1pXK0JSeFhJa0xMZjkwcTVW?=
 =?utf-8?B?cUNTa2t0L2lnNVlDTWhPNzlHKy94eGZQaVZKQmhtYXhOTFJocHNKaFdRdmYw?=
 =?utf-8?B?RkxtYm5peEhTY2RFdWNlYUdQOS95L0RseTREa2VlQnZhYnBJcExYYy8zWTky?=
 =?utf-8?B?by85QzFoSDdFQ0VzTGVPSDlNRDdvQ2duWGxlVEw1Vi9Ja2lPWmhGYk9aR2VM?=
 =?utf-8?B?VVdaYTRrZW1lc0g3aE5mVG82cFR5ZGpQMEJzeHhhbHVRaVpPc2dURWJabmh5?=
 =?utf-8?B?UzZGYTMvZVpYbjFLQUdYcitzZlUxeFJBeUJnWkU3QklZS1lhWlF6SllNTlZp?=
 =?utf-8?Q?rYQE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STR4NHlUUnI0OWlyL2F4OHk1cG15VXpUR1RjN0ZCcTk5bTV4QWMzNDZMQnlu?=
 =?utf-8?B?ZGdOZmlSRkg5dFpmWUVZSTM2SWpDRXRKb2JabCt5dUo4YW9DaXhXM2JsZDR1?=
 =?utf-8?B?Z0tKTUZ2REhyeE10UjVvVjRqVTF3eFFLMEdrY1RUUHF1Nks2bFNWcXl6OEZw?=
 =?utf-8?B?UFRML0I2c3FmbUFkTFZHN2gzeGQwZ0YvUE51S1ZaNFltYlJadWJlZUxmZ3ZC?=
 =?utf-8?B?RkgzRXRXc1N4NTlVcDhHWXh4eC9IZ2FyMWllaVlCMEJqc2tGZGRGMGJYTHd0?=
 =?utf-8?B?UWtyZnlRRzViOHY5VE1Xa1hQUXdIa2UrTHJUdmlKaGNHVnd2cEFoNm92VkxR?=
 =?utf-8?B?QjlVY3Z6T2laYmw4RmFMUFlFMUJYZEE3N0E0V2lrd1o3OFI3WEQydmlFcWpQ?=
 =?utf-8?B?NG5UY3pWMkZPeGxwYUhTOHU2Vmdyc2k4MFo3ZHh4emVFOHdxcDhnRUxaMmRT?=
 =?utf-8?B?TkUrRmYxd003RW9SYm5DNlZrMzkxOVNhdDdSRGNMNW9mTTBjeUlKcTRVOGta?=
 =?utf-8?B?Z3JkQ0ZKTWQxV2kyL25oUlhRNnk5UmhVQWNQaG1LVnVmTEsxcTZzRThMdDFS?=
 =?utf-8?B?NDVaaVd5YW0wYTNMUmlUQkdNeE85VjdLSUlWTzE4UnhXSU8zem9wYjMrMFhx?=
 =?utf-8?B?d0xmRmJ5KzMwRkZXMktiRHFpeWpMVUJ6dVI4d0szK1lZcGo1MDBsd0VaRk5n?=
 =?utf-8?B?b2ZKWjRuUWlubVBYaFU1SVRPNzBQR0FtQUdvR24yeXR1c09SQXM0Ri9nS2ha?=
 =?utf-8?B?QUpabFFYdlpGdjAvQk9BNlZ2Y3FEOVc4RTkrcXoxV0VhcFdhTUV4VEVSWVNI?=
 =?utf-8?B?U1VJN0NwNGVoL3NGeGErQ0E3VE5MRVgrQ3lPMjIrMUl1YkVSaGdzRDRsMWJI?=
 =?utf-8?B?QWF2Rzk3elVyQkVFM00wWVM2OGtGWWVCNEpkZ3BrRFFwN1FPYkpUQkt2cHB6?=
 =?utf-8?B?c1pid3FSMFV3OHRwb0xINVFaaXV1YUxFWFd1b3JXeVd0TS9vRyt6eUtoVEIy?=
 =?utf-8?B?QUxIRnpabHBGaDFRTTlZRlNNS1lNQS9obmtaV09ocXpQUkgyZW96Y3Vpa2JO?=
 =?utf-8?B?VUJ3Rmd3bE9SSUExNk1EZXlKb2VuVUI3QkFPNEJvUzZuZ3lZaGd5eEpjU1VT?=
 =?utf-8?B?NEh1eE1xYW9UcEc5d0NpcVBHRGh4RGVUSFhVQTY3d1BoaU5UMjh6K3RWSGVr?=
 =?utf-8?B?U2NiSnR5a0RiSS9peWRvNkdML0JnWmFPVldLSkRXL3RWSXJkT2VwZW0vVEl4?=
 =?utf-8?B?d2ErZk1XRVZNLzdqaENpQUU2WkIzcFRvOVFvLzNQY3hWVW4wanViM1hhSklX?=
 =?utf-8?B?T2dBUGNJd2VvcFZUMEtMVVdkNzB3cVJGVzRNTmtqZ3R0S0hTSE5kRE8vYy9n?=
 =?utf-8?B?UmplL1hxUU90RXZFaXBhcW8vQnd2YUdtdE42VTNJRlBxQUZuMjRJbTIwQ2lW?=
 =?utf-8?B?aGhhWHIzU0VPa2ZwSUNFdkcyYXJYUVN5VGhyc3NmNjRGZnFmVmtMRExMc0Nl?=
 =?utf-8?B?cW5mUit2OTVvb2Jpd2ppNnlEL25kYmNoSm1PTHM4RHQ4ZlAvTElBTTNGZDZT?=
 =?utf-8?B?QTA2akdkSjBLSUZiM0piQ1Jidm5qOGpvbGZCYUl0OGliQnFMZW52Y2ViMXNS?=
 =?utf-8?B?TStVcFdqSXJjMzVpWnVhSnpaYlJDSWtDUGRDelN5dmY0OVo5WTk0emR1L3pB?=
 =?utf-8?B?QTFveEFxeWdIVXl1SUtSQ2cxYWRwSWIvY0V6eDgwTzRsVjNNaGN3QkZtSXBj?=
 =?utf-8?B?dEpjVVR5bTR2TVZ6MnJ3T0lLYnIvYjBwY1BMMy9ZVDVkNUdQaUlKVFI3UmNJ?=
 =?utf-8?B?MWxhU0RxUDFmLzdxUmFUd0xvYWQ1ZnU0YmE2VHBDUlVaS1U4VGlmQjhYYzlR?=
 =?utf-8?B?MFJnRTZnRTUrZXdiVVpjbmJVNEh6R2ExajVtaDNpQ0VIRFZYYUVJT2swNnRD?=
 =?utf-8?B?dDRVaUNGWm4vYy9FZWhqUWIwdkk3MjRRRUxUZEd2dHkwT0dMTk1lZjJ5UFhE?=
 =?utf-8?B?ZjdNOEgxMWxTWE1BcnhTb0xWUHlHUVV0ZEtVYWhxZ3NiWGx2Z2Z1QVRYaG9q?=
 =?utf-8?B?Ym1NS0tvUnFEZENjYzVnbGdqZ3JSZHMxZ3NJaEU4QXF1cUVrVFBXK2NEc0Vw?=
 =?utf-8?B?c0lTbXBwMEZLRFdlbWp1UnA3eDl1NkNGUmFLck5ZWnI0cDhuUmpFOThaMjNI?=
 =?utf-8?B?TUgrUEVNd1Q3MHE0eXdReHRHZlRsMmFsWTlrTnduczF3K0lITkQ5cWRpRFU2?=
 =?utf-8?B?dlhpRzdXVldpdDEvc1pTelRNWGVqRThlOXZZeDg5Mzd4MEdJUkpzeUNXMW5o?=
 =?utf-8?B?VWFQeHhvN3VqWFoySlJjQXhxOVF3OTZzTzhGaSs0TVdZeWZKRkZQTXpXS0pk?=
 =?utf-8?Q?+fMTdHgJNM/YFp1g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 451a0afd-8faf-416c-bab2-08de59d6178c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:48:38.9578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pX61vgg95Hxtn1flBBjOwJRaFQe9AU0XPjy4Xmrx5WUN5Am3cBypk/nOgQ2ZlcIx6eSTHIeSeuMtiiBCMbpuPF3JBRhb4da745EbKS6IxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5960
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Mon, Jan 19, 2026 at 06:09:39PM -0800, dan.j.williams@intel.com wrote:
> > Terry Bowman wrote:
> > > Internal PCIe errors are not enabled by default during initialization=
. This
> > > creates a problem for CXL drivers, which rely on PCIe Correctable and
> > > Uncorrectable Internal Errors to receive CXL protocol error notificat=
ions.
> > >=20
> > > Export pci_aer_unmask_internal_errors() so CXL and other drivers can
> > > enable internal PCIe errors.
> >=20
> > I folded in the following to this patch because opening up internal
> > errors for PCIe drivers in general is not a goal.
>=20
> As said, the "xe" driver needs to unmask Internal Errors and could
> take advantage of this helper, so I'd call opening this up for PCI
> drivers if not a goal then at least a "desirable side effect". ;)
>=20
> https://lore.kernel.org/all/aR1_M_i3yIygd8v-@wunner.de/

I missed that earlier. How did xe manage to be the only device in the histo=
ry
of Linux that needs internal errors unmasked?

What happens if Linux says "no, that error model has never been supported a=
nd
it creates in ongoing mental / maintenance load of internal errors do not
matter for PCIe, only CXL, (except xe)."

> >     +    Internal PCIe errors are not enabled by default during initial=
ization
> >     +    because their behavior is too device-specific and there is no =
standard way
> >     +    to reason about them.
>=20
> Well, they're not enabled by default because per the spec they're
> masked in the Uncorrectable Error Mask and Correctable Error Mask
> Registers.  It's up to drivers to unmask them if they know the
> hardware signals them.  CXL just happens be one of those drivers.
>=20
> >      @@ drivers/pci/pcie/aer.c: static void pci_aer_unmask_internal_err=
ors(struct pci_dev *dev)
> >     -   mask &=3D ~PCI_ERR_COR_INTERNAL;
> >         pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> >       }
>=20
> Unexplained change vis-=C3=A0-vis Terry's submission.  It seems you're
> reading the Correctable Error Mask Register and writing the same
> value back.  That's doesn't seem to make sense.

No, sorry, this an interdiff so that change was just a change in context.

It also caused me to do a double-take until I realized it was a pure hunk
context change.

>=20
> >     -+EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
> >      =20
> >     ++/*
> >     ++ * Internal errors are too device-specific to enable generally, h=
owever for CXL
> >     ++ * their behavior is standardized for conveying CXL protocol erro=
rs.
> >     ++ */
> >     ++EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_co=
re");
> >     ++
>=20
> This change will require touching aer.c every time a driver
> (such as xe) has the need to unmask Internal Errors.
> Not sure if that's such a good idea...

The xe driver can always come back and change this to plain EXPORT_SYMBOL_G=
PL()
once the clear the hurdle above of, "please reconsider your error model to =
not
require this never needed before feature of AER".=
