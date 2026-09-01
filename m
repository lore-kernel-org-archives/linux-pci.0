Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09246D2AF;
	Tue,  1 Sep 2026 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268474; cv=fail; b=CHOIyLnVYstUmcLtGgTRNDN0RzY1HLGazGuqXG+jMOFJxuHol0TZIRJKRNH7p1Y+TKMLfPTAnsyj1ymVFrezMAlOibxYfSf2Gia+0A9Z2EtqArgAkVuip6A/MF8+z9y5lz7F5H3GB1KscYAPzi+pNxHT4mpvPKW4+N4VNtS5ahg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268474; c=relaxed/simple;
	bh=NfsiiXk+0H97DXOEsNmyxAxSudDhmRMECjEa5xgG4AE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b1sIO4zkDLM3n94h9OS94uOoqjw0cflX9FZodq/5Mz9+bjonR+IuQLRoIymAkt5CMcDBaRP1MSqSxLi1ldtzfPuxHAm1stee7En0lKeyxEMHcIDslcW33yHGoYhOtAisEsgBoTNTPioLjX+Izv2YEZ4W0lOCIRhScuwHWtQ7e58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B69UBSMw; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B69UBSMw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788268472; x=1819804472;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NfsiiXk+0H97DXOEsNmyxAxSudDhmRMECjEa5xgG4AE=;
  b=B69UBSMwyJ82YQVKpwh+GGFvUNAaWQTuwEoPAxMxQ3WmubutmyPj7MtG
   NnGdg9dNfjzHaZ57B1A4y+nQrPdSdiaE50q4DouFi1CmMMZRMcrpRTq0h
   HTfs2wx73klQVFwiKp95jStnwYGPqMDRITmhxCh83TMxqUCqEMVkkahvG
   l0HBVOn/rQBQxpAYak/71Gi0uV0gzuylT87VcEp+k/Xb4ZIF5JlykvNkk
   hg00kRuWiJRkweOAvfuJCLZe2gx9gFu4ZvJjDNPR5UQ5tWCi5Jt7vJZSc
   jLlkNklY8Udx1yJIld3rZhanXWF8PU/g6LEzzBlLCtbxd2k+/4QrMgHAh
   A==;
X-CSE-ConnectionGUID: FDLQ0SS4TxmSerEkdMsYgg==
X-CSE-MsgGUID: Yoy4471IRaKDfaeE4TuQ4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92564249"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="92564249"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 06:14:31 -0700
X-CSE-ConnectionGUID: N8O7M3g6QZWSI1DvFjXXOQ==
X-CSE-MsgGUID: 68p2b+1fTKOSuq0dw9O0SA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 06:14:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 06:14:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 06:14:30 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 06:14:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uy3L96KFNiHbyZbkEDeOjW8PwGx5lcmqHl4aVV9KZIqep0caUaHp9qo/rcfy0bfRH2xQ8Yf/tBvAGlZ82CvyuehfwE4VspAGLkMdLSff5UzJT1BHanxyaAfLYdoF/5WKOwDtFlC1QigfivIw9xUbKWMFqUJQJ24V3TBMiry6jTjmJxZMU5OqCpFP6JSbcaEcJs4lnSM6OOU+SmBcbC7rBy1ySrLxqbyocmWJlQhECDQKm5Flxa0X0sxHEyrmxdY5ZKdut7YP5wvEHFlHQJa2jtaC1EjQhe7wWj39OMboDIAxoER+feBxxta+xyTlADhwMJ8BKA8p8K/7BRNqhRnMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydS4EudxzmhVB/0knOb4CD+ZPOji8gKIbW/eUKm1r6g=;
 b=CH2nl74QkSqXHU57Y++86gw4EeVgWQ4zmmxbuK59TZJD+SeNltfvliprrBZbndYITjNSPjjaHAHJ8TWdjRCMcuiSn3+UUiISLqlWE4KffD73qQy4uw+Ae7mM1x9Mv5jWrYRltXqf9BqK1C0I/qcB+oHvUzwuu+CSq8n+36WY4MpQRDetVnnSRI70wvhWn4j34E4c+9AjIBgkPMdlaWWze6Ek/yEqRmze66nkSBF/L6T7EQIznjjBVn1xucrLNKBMADGV0Y0+PVGWv6GxvBsVc2WJNxrA8nxoUN5i6sk+xWET/6rWUFHi2fGVop+U+Cg0+vtvO1JTRbHiRguymzdAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15)
 by DS0PR11MB7334.namprd11.prod.outlook.com (2603:10b6:8:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 13:14:25 +0000
Received: from LV3PR11MB8695.namprd11.prod.outlook.com
 ([fe80::ccc3:3fd6:58f5:927]) by LV3PR11MB8695.namprd11.prod.outlook.com
 ([fe80::ccc3:3fd6:58f5:927%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 13:14:25 +0000
Message-ID: <562f64cd-1c85-45bc-99da-89e8ec168b11@intel.com>
Date: Tue, 1 Sep 2026 18:44:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/19] vfio/pci: Serialize generic device lifetime
 with recovery
To: Shameer Kolothum <skolothumtho@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>, <sonangp@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-3-skolothumtho@nvidia.com>
Content-Language: en-US
From: "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>
In-Reply-To: <20260901093217.8539-3-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0062.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::15) To LV3PR11MB8695.namprd11.prod.outlook.com
 (2603:10b6:408:211::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8695:EE_|DS0PR11MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d55af5d-e15e-4c03-60c5-08df082af1e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|4143699003|11063799006|10067099003|5023799004|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: Ep7+X0wQw5A0ukAUTQlKTLP2bYIfFf0SErtYVik5j2fQK4D2bKGHRLk/Jr6Nz3FVC6gprHQa0jQ3/sld0MSjSkDRR8V//HMOTzCdvGjrLfaW2LoskZqcdrQ38ujTJ/WU/Qoh1at0E/9b4FHOMMNSlBA8Veh7D/IaVj9Zu15AUn3c29DU6aGdVJx905wrK0FaB87Yd8t/iMMI18E15cxstQnTA0avB9qwzpmFhUM2alNwxMEv5AQXaI9dRsD/PeSjly+QEksSRBPewoElsJlpQqTslfrKYOOMmI81oaf3ni9lAwY6I8vJEUDWlcU3viFeQEA2aleB2z2RZDWAlLAt/wrnq/hnKrgq3yjeL7MZ+tcLTA7PCApd69pQBnuYoraYo1G3bjTZ5H9/PiwYVt5bqLtvRzn8BDiDVt+gDKxUX3kn5Jti7jd/Vfba8fm594db0IxVe1/nXkl8yVYWUSYQnJyI8t1A55xn7p/zu3Bmx4o+rrB4WG1bRxV0ixPsohIZ7eimNAs/5i5p5RAOgSq3afD2FsG8inj7dZuuhKQb587YobOoSqTsXdX4UwRkI8pfZ2vr1JP4af7hZDahcY6WZCWZx2vVy3zSY27aRurnQFyEXpuKRZVW1TVaZ1Z6jMiqztUqgraICu0xdTitlM+RFSBkRXdHDAvElllKaBkp4js=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8695.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(4143699003)(11063799006)(10067099003)(5023799004)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDUyQTBsMGU5WkJaQmpaYjRpZmVKRnRwSEJRS1Z6NnFDaExoblpzOUl2aXpU?=
 =?utf-8?B?ejB5ZFBZSjZGSk5yc0lVVTY3Z1hZUjN1OVllamZpZnRNcXFzN1Q5a2h1cnZ5?=
 =?utf-8?B?MzdlVDBZRmV2a0Z4VUY3Qnh0SDhOd2VVUE51a0RWSGFCdldWWU1pb2tPdlZp?=
 =?utf-8?B?MFdFcStLMHZaRHFoaEIzY3Y3aG41L0xHOXpmbEYrNDUwd2cyeHFzb2x6alFw?=
 =?utf-8?B?ekVMbW5rOGlCSEtaQ3lDK0lBQVY1cU1oZHJ1U2xuMkMxUkpRaEFXYXZsZmNM?=
 =?utf-8?B?cWNHY0lhWTBjZ2VJWFBOaEd6OUpVbUM0dFpBcnBCdUJ0WjRGNmhBbmlKbWFk?=
 =?utf-8?B?d1oyWWpCVytNajhHK2U2dm1vTUFzZG1xS2xxSHFjenMwK3kwb3l1RytnL1NJ?=
 =?utf-8?B?WWxhMXRtZkpHNVpTYUxiNlFPemhlaDhsc0tTU2Z2cHl3ZUg5VUtacDdEZDFW?=
 =?utf-8?B?QTZZNHpGaEw1K242SytPWDV5Y3hYbjJzSktxUldxVWJhbFVzMzQ3anVIWi8x?=
 =?utf-8?B?VUZNUDlsZHJXMm5yenJSb2NqTWMzUWJVbCs0WVl0cUhrOXBFNmRldW14bGVE?=
 =?utf-8?B?bFdmZFk3c1FwSlNSL3AzR0VNNkVOaEdnSHVENUxmUElPZEpMaTdIVUlRWUVK?=
 =?utf-8?B?blNTWm1sWXVTektSU0M0QnhnK0hibVIwS3poZms2YkFOc0pHWm9qek5jcyt0?=
 =?utf-8?B?ZEM4QmRUUy9hUXBIN3dTVmFKcWJpeTZxZzFKYjh2dnY1WEJBalJDNDA4V0lV?=
 =?utf-8?B?TXdYRHVjU2dJVXhxUlRrajFvSC9zTml3TEt3MXBIdUZXUm9kYWxhdUQ2Y2RO?=
 =?utf-8?B?Tk92OHB5RDgzTlZZRFRCR0hsZ0ppNndWTDZDUFhEUE9iNFgwMUhHc1djQ3ZI?=
 =?utf-8?B?RjBwUm4ydUtPM3QzVVpGK21TcUxvUnFYTDBSc1FoTDZrdlJTQStvV0U5OStY?=
 =?utf-8?B?RTIvbmFBZHJJeW1HT0lDLzJtUnFQUkRuWnVZOENrZ0ZYbXNXbHV4bEVSaDQ1?=
 =?utf-8?B?d1NEdS9KalU4WXdSbzRPL3E5aXVmSCtETFdNeWFYTmNjTjJyR2NKcExXR0t6?=
 =?utf-8?B?bzVnKzBnbHZjR1lqbHdVazBvNDFzTU5NVFZ0NUR5VjhvdVY2TjJNWm5uTmdE?=
 =?utf-8?B?dTFSYUFHRnRLbDdjdTZidGdLb3o0MERQWnY2OE4zN0djM2hQMVRybnUrbm9E?=
 =?utf-8?B?TXJ1eFZQT3J0YlhxTEkyNzNIWjZNeW5VbE1QZ3lJT2tRMHRsOFJXMk43c2V3?=
 =?utf-8?B?bFFYTTFkdFhDOEExa21ic3AxYzBVTFUreWl1RVlMeEVPQ3JQZ1dycW9uemV2?=
 =?utf-8?B?Qy9KZ1M5QlpqMFJYR3NsMytsVm5vZFVsZVJ3Y3lRdk94bGhzNVNqamtoYlh6?=
 =?utf-8?B?eVppQlFBZndwZTFEdk9mTHo2OWdEWHVyMnl6K2ZJamRhN1VIQU5VVlZSSTc3?=
 =?utf-8?B?QzYvMWd6WG1mS3NWNUUxYUplQUV0aXY1OEhLMXRSRFA3WUVYVUN0dTZsSGZx?=
 =?utf-8?B?RFFLdmVML20waUNOYk83aDkxOTJJTXNKTmRtaW54VkVSZUlDMmpldUJOMHdt?=
 =?utf-8?B?S08xVTdZY2trbVoxSGhLUFR5RVczTkdjanhydjlmM2tkUUdCaXREbU9HTzFW?=
 =?utf-8?B?TWRUK0VKcEJpeFo4SlRQdzJiR2dGS3ovMWlyWUpaejhDZ3lacFNIWWV1SlVw?=
 =?utf-8?B?WEJqdm8yR2NDREc5UEI0MkFwMXVHL0Z5TE5Ia2wyN0pTMitFZzVzOExhNFM5?=
 =?utf-8?B?NGxIcFdSaEYvT2lwUVNRaHN6R0JicGllY0pyYVFyNkZWdW5HaWNaWS9Lbk9w?=
 =?utf-8?B?ejR3dFZ2emw5c081cklNZGJMczk4N1lNbmFpK2I5czJlV1VCOW45a3k3ZnlR?=
 =?utf-8?B?R0RqMmdIcEFnSUt4TmJxRlNoRCtIZXF6SWxxUFNiamViR0RPS2RocWRhaWlk?=
 =?utf-8?B?MjMrUEpXbDZRaG1rMmM1TjcxcEdWYXRVUjFWdjIwUUx3cmtnQjNIRStlUURR?=
 =?utf-8?B?Y01HdmZDYTZ2M2VlZzlWWTB6NkZxMWdRL05zSzNoMXVvYWdSeUtKVWpzdTVm?=
 =?utf-8?B?ZHN1dlVjdFc4Mnp2aDlOOTJodm91b3grUHZrdzVlWU0raVRSS0lPS3duNTl5?=
 =?utf-8?B?aUtOY1Q0V0FwRlVJQllJeHFYZVN0VG5tQjhjWDV5dGFvYXNrUnViVjNNUWdk?=
 =?utf-8?B?MVc1b3BxcUhIdVdIVDZ5Q2JPdlVWdEh0ajNtWWNMV0RBRWdOQkhRN3NOM3FE?=
 =?utf-8?B?cVlaK1d0a2E3REVpQm9YcDRpZUFpL2thOER4ek5XbnBrVkcwa0ExY28xUFhl?=
 =?utf-8?B?ZUs0elhvT1hXakErSWNDVXRCR3E3bytoQU1PTEFTSmhpelhRbnpJUDRSaXNx?=
 =?utf-8?Q?lHrIOWqgq0ZOU8w8=3D?=
X-Exchange-RoutingPolicyChecked: UQL4yY1GXh1YmuTEHAc3yQxkn88xrPrFkzYgUa/ZA3ppLWx4V2oqFPI1k+HVBSNKhzGsi6WMDzCOWno0Z2UiPjYaxt1lfv/VgmJAnno4GpMfLgwTkwdei/tBdkZ8C/S6HySz561FUHXGWGJ86Sgx92A3jgkRkE6JSmoscAQ8XkzYbLyRFoki3QIo2XCLOnySLQWg2HciMCM1nKijP11Y+hDW2fJq22y8YDvwXHvFBQJ2IUkYAP04/XlRy8zLETDHng9XI4GgaFKtvVuymMu4RwSRYw/CTMq2MRw+TBOah8OuUDvvgWMnWAojjU7XMsxjs76sMyy9KM6rD6iTrslR8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d55af5d-e15e-4c03-60c5-08df082af1e3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8695.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 13:14:25.3894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbQ+xJJDZkYbTQgOQFEbccL6yWCHZbwd1jEA+dQnZ1CHPG7lzH35+VI7GUM9oAFcih6yJroQIH9VmfTuHrUP9vhcpoEuAm5EiDp8SVD7b3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7334
X-OriginatorOrg: intel.com


On 01-Sep-26 3:02 PM, Shameer Kolothum wrote:
> vfio_pci_core_disable() frees vconfig while holding only the vfio
> device_set mutex. The PCI error callbacks never take that one. They run
> under the PCI device_lock instead, and vfio's close path does not hold
> that. So a callback still running when close starts can walk into state
> which is being freed.
>
> Publish a device_open flag under recovery_lock. enable() clears it before
> it touches the device, finish_enable() sets it once vfio_config_init()
> has allocated vconfig, and prepare_close() clears it again before the
> teardown frees vconfig. All three take recovery_lock for writing, so a
> callback either gets there first and close waits for it, or it finds the
> flag clear and does nothing. The access guards added later test the same
> flag.
>
> recovery_lock is not held across vfio_pci_core_disable(). A later patch
> has error_detected() take it from under pci_bus_sem, and disable() gets
> to pci_reset_bus(), which takes pci_bus_sem the other way round.
>
> access_blocked is only ever set while device_open is set. Nothing sets it
> without testing device_open first, and close clears access_blocked before
> it clears device_open. If close left it set, nothing could clear it
> afterwards.
> The transaction which set it cannot clear it once device_open is gone,
> and every path which refuses work on a blocked device would go on
> refusing. Clear it before device_open so a lock-free reader never sees
> it set on a device which is closed.
>
> open() now refuses a disconnected device with -ENODEV. That is new.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   drivers/vfio/pci/vfio_pci_core.c | 69 +++++++++++++++++++++++++++++++-
>   1 file changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index e0be5ddf7039..8de586e4bb73 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -591,10 +591,23 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
>   int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>   {
>   	struct pci_dev *pdev = vdev->pdev;
> +	bool supported = vdev->pci_recovery_supported;
>   	int ret;
>   	u16 cmd;
>   	u8 msix_pos;
>   
> +	if (supported) {
> +		down_write(&vdev->recovery_lock);
> +		if (pci_dev_is_disconnected(pdev)) {
> +			up_write(&vdev->recovery_lock);
> +			return -ENODEV;
> +		}
> +
> +		vdev->pci_recovery_command_valid = false;
> +		WRITE_ONCE(vdev->pci_recovery_device_open, false);
> +		up_write(&vdev->recovery_lock);
> +	}
> +

Can we use scoped_guard()/guard() instead of down_write()/up_write()? 
The same comment applies across all similar sections.

- Satya.

>   	if (!vdev->disable_idle_d3) {
>   		ret = pm_runtime_resume_and_get(&pdev->dev);
>   		if (ret < 0)
> @@ -815,7 +828,40 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>   }
>   EXPORT_SYMBOL_GPL(vfio_pci_core_disable);
>   
> -void vfio_pci_core_close_device(struct vfio_device *core_vdev)
> +static void vfio_pci_core_prepare_close(struct vfio_pci_core_device *vdev)
> +{
> +	if (!vdev->pci_recovery_supported)
> +		return;
> +
> +	down_write(&vdev->recovery_lock);
> +	WRITE_ONCE(vdev->pci_recovery_enabled, false);
> +	vdev->pci_recovery_command_valid = false;
> +	/*
> +	 * Clear access_blocked before device_open, so a lock-free reader
> +	 * never sees it set on a device which is no longer open. A
> +	 * transaction which is still running cannot clear it once
> +	 * device_open is gone, and paths which refuse work on a blocked
> +	 * device would then refuse it for good.
> +	 */
> +	WRITE_ONCE(vdev->pci_recovery_access_blocked, false);
> +	WRITE_ONCE(vdev->pci_recovery_device_open, false);
> +	WRITE_ONCE(vdev->pci_recovery_flags, 0);
> +
> +	/*
> +	 * Publish the closing state and drop recovery_lock before any
> +	 * teardown. Recovery is disabled and its state cleared, so
> +	 * slot_reset() and resume() become no-ops and a later
> +	 * error_detected() only follows the legacy notification path.
> +	 * Holding the lock across vfio_pci_core_disable() protects nothing
> +	 * and inverts the lock order. disable() reaches pci_reset_bus(),
> +	 * which takes pci_bus_sem, while error_detected() takes
> +	 * recovery_lock from under pci_bus_sem.
> +	 */
> +	up_write(&vdev->recovery_lock);
> +	wake_up_all(&vdev->pci_recovery_wait);
> +}
> +
> +static void vfio_pci_core_finish_close(struct vfio_device *core_vdev)
>   {
>   	struct vfio_pci_core_device *vdev =
>   		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> @@ -838,6 +884,15 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>   	vfio_pci_eventfd_replace_locked(vdev, &vdev->req_trigger, NULL);
>   	mutex_unlock(&vdev->igate);
>   }
> +
> +void vfio_pci_core_close_device(struct vfio_device *core_vdev)
> +{
> +	struct vfio_pci_core_device *vdev =
> +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +
> +	vfio_pci_core_prepare_close(vdev);
> +	vfio_pci_core_finish_close(core_vdev);
> +}
>   EXPORT_SYMBOL_GPL(vfio_pci_core_close_device);
>   
>   void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev)
> @@ -852,6 +907,18 @@ void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev)
>   		vdev->sriov_pf_core_dev->vf_token->users++;
>   		mutex_unlock(&vdev->sriov_pf_core_dev->vf_token->lock);
>   	}
> +
> +	if (vdev->pci_recovery_supported) {
> +		down_write(&vdev->recovery_lock);
> +		WRITE_ONCE(vdev->pci_recovery_flags, 0);
> +		vdev->pci_recovery_sequence = 0;
> +		WRITE_ONCE(vdev->pci_recovery_enabled, false);
> +		/* Close clears this too. Start unblocked either way. */
> +		WRITE_ONCE(vdev->pci_recovery_access_blocked, false);
> +		WRITE_ONCE(vdev->pci_recovery_device_open, true);
> +		WRITE_ONCE(vdev->pci_recovery_rom_disable, false);
> +		up_write(&vdev->recovery_lock);
> +	}
>   }
>   EXPORT_SYMBOL_GPL(vfio_pci_core_finish_enable);
>   
