Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA577230BD5;
	Tue, 27 Jan 2026 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533349; cv=fail; b=K8Kt7Y0UP/aIxgj4KzcOBoW56Y4/kC9tOblYO6C82jYV8UAkUOsJ8+FvEgLpZq5bgl88ppshuKhIhqNccgPykDHHQq9RQvQLQEZ22/XUanIjJhcG4CXMPz0tw/3MPgfb8L43GZW6c0+XIlIfKZsGFct4o5p3Q7D0eSgLvpPOJkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533349; c=relaxed/simple;
	bh=7VFeJBkgVylTpU/m78PoN5BFyO+PxcXFxavCuXvFt7s=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=QwGCSnXXvsuUn4Co6jDQ13gwkERmQVtPcGFZ/alPAsY6o965sH40e1kqrxq8S4p38oETu4vEfLZ5lLL2OrhWqHUGL5e6Z5prSiJnVI99hfFrUYgdbR33cK2ixySDllCO0f5NtTL/8pSbU9YqFL1VWIq9b2eeDEyjJLtziCmAb0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l67gx8Id; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l67gx8Id"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769533348; x=1801069348;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=7VFeJBkgVylTpU/m78PoN5BFyO+PxcXFxavCuXvFt7s=;
  b=l67gx8IdujMJqtJ0AOKmX0CChLsgd0fuqK6AGNYO1EpNE0gq1FFOCh68
   TJeVpp11HPgAXJowYDBaStWDO9rzvN2cEBxmOXwkvur/DhCDoovExWrE4
   IAvQogWVziD04vgisJlNHXWEr15Z1CielZp1LSxi92aEdN0EXkWVW+0zN
   fDZeFMQ3SikOc9OjOO03K+PBdMOzuhKwrvRw09paoQnkd8zdokd6e+vZH
   XYpi+5Sqg/L229eurG/q4jZ0q3cq2T01GvHJI6J8sijYPSnMbXYqNhLzJ
   h9NBodUB6aIz2PXfCEZZh9702jfuh7Zdz6lK9ZfP/63jXeTQxqefpdhEM
   A==;
X-CSE-ConnectionGUID: bNnw7xFGTnicaRu+N3PErQ==
X-CSE-MsgGUID: dxBL0dKKTMyqZEVeSjnMcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81456874"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="81456874"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 09:02:26 -0800
X-CSE-ConnectionGUID: KST6UNVZRCm4rSBaKFAA3Q==
X-CSE-MsgGUID: v22Ah6/SRj6r7NoKhEOUSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207633439"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 09:02:26 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 09:02:25 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 09:02:25 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 09:02:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wy/sSTHVYJpx0Kd0aZP7YqFqv5CmgvXTGUxy+InsweN08GhmkLvgqmTim92AGW85hd9b7VUznYIvMMSX5hYUGITPYin4udhpTsjKxTUwPd+1kynUeEVMdfnQRECyuTUx+UTa5gkpspchlPEx4qfl4f6hJmAtE+YV5R7/asxXy0AjH+ETyLyJlxQRBxTzY/y25m2LDEwQ5qLp7WTYPvQogCNWbqNH91Z3gy4Tj2CHjDI9Em0JT7TJ7501CtP7NDSmBiVgplQqKeK2Fry3g09kNv4upfcbcEDPGtTiL7s544oZVSFcyoffB1MbrB031DfR7/f/KKg/kaHOe9pWUn6aoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MSqeT10D1o4DSiwGiAVwyCUtY3Wm9zCLSjxflzs2T8=;
 b=Vj6tUPCRYepHF737QXAfF2BkB1tIsjakRkpxL+UJo4RXKRCTnIh03CCkod33naCje2kXbKzhTXEr1j2P6TuT/pF/gg41TL6nJ4RSBcM1B1293/75hv3KIL3YQg2e9xiyKzMazeWXe7TzWqA6fB4+3U9KozuFe59ijnqftgC+Y3IIz3nU1okbGUYiah1AR/3mWdOJAruB1QuP+C2LJ9Ld1XQBBcKFrYq2kig9KT56NTRmdpFUBGP0vluCg5ZGe0OdcXarJHsJIs8lLYUIhm7BN3Ii/IMsrTht1oODChN6SgZRogcFba7inq4EC6ALHGCX9JQ1U0u2iwi6OaoP7VTrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 27 Jan
 2026 17:02:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 17:02:18 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 27 Jan 2026 09:02:17 -0800
To: Alex Williamson <alex@shazbot.org>, <smadhavan@nvidia.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Message-ID: <6978ef9919421_1d3310036@dwillia2-mobl4.notmuch>
In-Reply-To: <20260127093343.67715d5e@shazbot.org>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260127093343.67715d5e@shazbot.org>
Subject: Re: [PATCH v4 0/10] CXL Reset support for Type 2 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0193.namprd05.prod.outlook.com
 (2603:10b6:a03:330::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c01154-8815-4aa5-f6a6-08de5dc5d462
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkRmNWdkMktYWEx1dUI4bjlJMXA1U0dFSlpYWWpFRGRkUXVUT2VobkF6ckN2?=
 =?utf-8?B?K2FyczRSQ1R2SmhzTTFzY0ZrNU14QTllTTk3Vm1aSGtFZzYwbU9PeCt2ZWdj?=
 =?utf-8?B?TkNvNzhBOTI5WE5YNHZiZWlKV241aSt5a3h6NWtaMVlOUmFyaThKNXBROVJI?=
 =?utf-8?B?Y0FmYmVQVEhhdnZTOXBKZlRTRU9URDhzVkpJNmlDbFAzSyttRTFEczh6R21y?=
 =?utf-8?B?ZGpxWTFtOFR5THltSXJlU3RZSVNWMlFUbnFvYWs1cnF5blBNZWNKY3UxR2p1?=
 =?utf-8?B?K003azFZRkc4ZzAvRGQxNVBjSFN1Q2pJTzRBU3BCNGpyNnhOMXJHcmUrZStk?=
 =?utf-8?B?RHo2SjBPcnUrVjJhVkRScERKOW5QVW9zaWZWTENES2FuakQvLzgzMnRKN3V4?=
 =?utf-8?B?RDR3eG1ldUlWeGhBQ1FsWFBLdWxsM3E0d1diYkRuU0hlcTdsOGYzZ2VzdU4z?=
 =?utf-8?B?dnFYKzN3SE1DbHd4V2RpNEJhUm1CdkVDb0xuOTRYcmlXRzR2Zms2aHNJMWZU?=
 =?utf-8?B?N3VUTnlBbmZ5KzVUdGJleDhhU1ZKTE1nbzNJNTlvOHJDVmorVHJzb0V1SVpL?=
 =?utf-8?B?NkJWRHdZV0lhTmx0SzdUREk0ek52dGVzdTlHTGs5Y2pEWktIVk9tYXU0bXlQ?=
 =?utf-8?B?NXlMMFNHMFdvZ1hCcGpIa0tGQ3R0RUorV1hxWjBPMUg5cEp1K0RmWW56SlIx?=
 =?utf-8?B?L0NhSkppS1lrOUx3NVFJZXRud241aFZrd1dIdFNhUW0rYzZpZUtUTEFWUkFW?=
 =?utf-8?B?WWVOU1VOeVBpLzNRTFFvT0FqVUVna0VhQ2xycDlGeWRzeVhpVTM2S2IrYU02?=
 =?utf-8?B?Q3RXdENKTVRXMkVBNDQxcDZoMXpVRUpwR25PM0RkM2FvVHFKN1hhbVVmaWJu?=
 =?utf-8?B?YlpDYlY2Ti9WZ2Z3ZjhrbTRMTXBnWTdCankzTDZuMXYxeHhiYytSbEZ0MlZY?=
 =?utf-8?B?TU01MHVvSUZrMnFzbWh1NDZ6TFNLNnk2dTFIeVV5NXhXWXJWV0UwYnFTNWMy?=
 =?utf-8?B?K0JIczlWSmxrMm5YVjQ5S2hDTlB6RE9YcXByLzl2d2c2bWVYN2NrdXFtMmNC?=
 =?utf-8?B?Um1jR0JIclFWUFVJYndtVzFxTVM1c0YxVTZhQzEzVFdWY1NIVVV6dDE3cXNP?=
 =?utf-8?B?bHQ3ZTV6cWU4K0ZDNGpkRkdSc0hrbFBKMm4wNC9iejl3Rm53NTl2TWo0OU0w?=
 =?utf-8?B?cGR4SGtNemRBeE90aWE4eXc4emt0RnY2VGlYM1RaRXdGdzRZQ0dkZk1HalA4?=
 =?utf-8?B?elRSTnZsSWZMRG1nSTVUeHhDYXMxL0VFMnZKUWFVcHBUN3AyQTExWkl3Yll0?=
 =?utf-8?B?YXQ5NENsUG1SZytuanJBaCtjRUJuSGFxdmIreDc1bmhaSlV4bjUySUhHai93?=
 =?utf-8?B?dTVSTk4yZTRCV0ExTGxrWXp1SldIaG15RDJVdjNqcmdCS05yUGZuakxRM0pG?=
 =?utf-8?B?b0JDWTRybCtITHVqOTlmMUxaNmE3d2toZEVjSGlvcGJ1cGtiZTFaeTQwayt4?=
 =?utf-8?B?R1Zxc1p1WkNDMTNyZm8wdHJ0MTlSbHBsUkVTTHZyRERSMS9ZRWJnM2tCV3Ew?=
 =?utf-8?B?ZVNmVWZUUDZCNFBGOXBNNms2M2lDVG9jeWZYMHZ6TU5QckJoeUw5UzNTN09D?=
 =?utf-8?B?NzBZQXdRMURYZmtuczYrU014Uk9Ddi8rUzZUZmJvMCtPZi9aeFVtcFREa2NJ?=
 =?utf-8?B?SC84R1VEdXBHRGIwRzdCT083dmg5bE5BeTNQWC9QQlV6MlNWRExpWDJ0RCs1?=
 =?utf-8?B?RXgyU0VGYzgrbTNUNHRmbzJZQi91Sk8rNGxHeFBaZllxakxVMFJud0puZVdk?=
 =?utf-8?B?djNKc0JSdEUrNnlYQWJ3WlNhZVlKM0JNMUUxeWRZL1dsMFZpQ3RjalQxcFQz?=
 =?utf-8?B?TkNnWDk3Z2p6d1EzMWpwUUQ5WW14YWVSZ0x1bTQxcHNWMDRzb2IvMlFPSVVn?=
 =?utf-8?B?NmFkaHlvUXNpY3RQblhZVG9IQXNVRUwxaHZ3YTJoME5kRlR1OFpRVnF6UzNP?=
 =?utf-8?B?RnBUKzBJcThBVThJNnd2M2VnTjNCOEtMMzc1RWpIek5TRU1lN0JJU0ltNTBP?=
 =?utf-8?Q?FK4t9Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3FDMmdsZ0dFMTJmSGhCcDVEeFF3dXpUdjc2UG40Mm9idXF4ajhRL0RBa2ps?=
 =?utf-8?B?Vy9MSkpuRGFEbE5LQmE3YS9pMXBlWjhnOEVLM0x3TTlyVDN0R0RHdDNqVnZk?=
 =?utf-8?B?ZWExRldVaFdzSkszMzgxTWlFdFpMYXB2SEFxdk9mM1BJVDlMeTdkOHFjZm92?=
 =?utf-8?B?UWtwSnJSdjdrZkN1Q0VMTDh1TTJkbzZzclBnODRFTGd6VUdZbFNRazl1QWRL?=
 =?utf-8?B?MkdLSlF4TDJMLzFXZTZQRXBFUEJteTJUT1dieXh3Q0tRTTFhRm1pUVMyS3ZE?=
 =?utf-8?B?S3k1b1hNTDRQak93WjQrTk1Eb2RPN2hkZGxPZEtTRG04VElvanVYRk1CMmZs?=
 =?utf-8?B?Z2YxaWpJSW9YM3M3c0J1NWZEclhzS1JOMTRRZ3VseUFzWTZmTmRsODN2d2pY?=
 =?utf-8?B?dzU0aUg0UGl6VVpaVHZndVJwNDJYVTdRVXVIOGxheEQwYzd2N2dlYk9tRkxr?=
 =?utf-8?B?UkdkdXBkTCszcGhtZG4rL3BCTTA0ZGhHZlVja2NmanhHN0NPaE5nUmZFQXpM?=
 =?utf-8?B?dDBzR1FldTdjb2I5YnIwWFgvWkdEYTVMckdXd1dzL1BCYkhhbVdxajBEbndT?=
 =?utf-8?B?NXBROVVuOTdsd3hCVU1Xc3ZKcUxNNlFhR0trcUtNMzNWV2Y1L3pkdjc0NjhB?=
 =?utf-8?B?ZExsNTNvWXFiQS9wTkFGdlR2a1ZBNlQ3Wml6Qi94VnYrMXJIUVhNK05DNDlZ?=
 =?utf-8?B?REhyVkZDUG9RcnpVTnJEaW5ZeThmUzliMS9BQ3N6RHlZdXNFWWlZeE5kaE9z?=
 =?utf-8?B?SGl3SFhXNGtjUm85UkZTU0J4dTQ3dGZBQ3BMSzdGcVFVQ1JtQkdzSFdSREgx?=
 =?utf-8?B?bS9MM1gvdXk1TjNSdmNpT2FuTHRlamdQMVpiSWErNVNpbTh2dEdNTnFHaStn?=
 =?utf-8?B?Y2VMdnkwL3ZrQm4vYWN2N3B0NU5tNzNRQWNhbkZaRXZqTFdHOTR2TEptbVA1?=
 =?utf-8?B?ZXZXNk1lcUNzTC9PTDdrOTF4NXQ2clJ0T2VzSVFmZ1NWZ29aWWdvTjllUzln?=
 =?utf-8?B?OXpIN09tYUdkOGtGelp3WlZXWXdYVXdWRjNoYmdQZk9NcmpUWk85TmVHQkl5?=
 =?utf-8?B?QTVUN2syMU15cjFtYlE0VDJZYjhrV1Y3eGcxbWh0RkRPL0E2eFhJNXB6TVlO?=
 =?utf-8?B?K01ZeWtmY3JNK0g2K0I0eVc4aEoyamdadzEvTStOOU91NmQ5OWNKNmtiT29j?=
 =?utf-8?B?K0lnK2RFblNUbGtnbVhtbVhZeElFU3kvYURFNG5HVDRRVTRWUnNXc2N1TnRm?=
 =?utf-8?B?U3RWRWxRZkJoOGY2Z3QyVWVYa1BMNzhpTnFOejZhd2wxRHMzTjFsbVBiaTQ5?=
 =?utf-8?B?bCtCVSs5RHpLU2xwWGZiem9sY3M0dnNidWRKMWJpb2I4OFBoSmVaMHFpQjkv?=
 =?utf-8?B?aGtsbmFvV3JjcldlcUJTYVczQzdsZG52QXdiaUZKNUNkUkdBeGNJRE5WcDdW?=
 =?utf-8?B?U0kwb21saHk0OGZQSzg4MzE3a1IwMllMWFRUTTBRek5ndkdyZ21XSHA5bEdF?=
 =?utf-8?B?UXREdmdsMmcwWEZxS2dlc2RDT3d4UlpPcndCcEFiUWQ4TGVBMWFOZlJJQitY?=
 =?utf-8?B?Zkg4UTBYK0syWTVHWnZFUUJpcUhKak1oV0o4RHh5Z1dPUlJOMVZvM292WWRK?=
 =?utf-8?B?MmM5WWJyUGVqclNaRExUQnFvMVlOZ3FGemxDMGREV1VzblhudG85c3B1cHpw?=
 =?utf-8?B?U1Naam5mTXdrMWkzdHQyMWVTdUpkQ0xxNzVaeFR6TmhtNTBJN1JzTFgzaExa?=
 =?utf-8?B?WnpuUnozWEJqZmduQXBvT1RaYklWcUcwRUR3Wnc0NEFRU2hUc2V3cWx5SnNt?=
 =?utf-8?B?RjJqV2ZCeWtVaDdYVmN4c3lRbTJSbGw0a2YrdjZKdDZnaVhERWZVVVpQUno4?=
 =?utf-8?B?c0V1WSs1NXBMc25iRldDTFowanoxOU96bFJTMzB4WVFvN0N5Vmk3cE1lM0N2?=
 =?utf-8?B?VnNqN0YyZUxsbkVLbEUwV3FEa0lGWWEzWEdzOUw1OUN2V3piRUhiNUFxWG9a?=
 =?utf-8?B?S0k5UW5OV3FvVWhJLzZvSExRdVZJQVdKeU83eVZhSVRTZXd4VjFVVWpPQzE3?=
 =?utf-8?B?Um9rbHdicWVmajBuaDlJb1pUVWF0aE8ra0dQTHVZejFqM0lxcEJpR0x0Q0hv?=
 =?utf-8?B?SzFqSTRXS0JEQ2o4U0dMM20yS1ptd0pzbWROdXVZVWxJcXpINUlEbkl5dkVV?=
 =?utf-8?B?cFZETmk1NHF0blNuRGxlejRjMFhja3F5TjBKWGxSZURHOS9kNEY0SWhlTFFs?=
 =?utf-8?B?cmdQK1o1Z0w2ZldpVmlNU0JzU1J5bXg0VWxlT2lublYyaGIzRi9ad0h0ZDdL?=
 =?utf-8?B?bWRlYi9Eem01SWE2cDRxcy9GSjVwVkZYY2tKbFhjSlU2STJSVm5zZ1BVTWFV?=
 =?utf-8?Q?ZQNRTCNRvkr+V6wY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c01154-8815-4aa5-f6a6-08de5dc5d462
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 17:02:18.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLuoe4ASNpqoG9EZpB0IRcNy82FOhrhdtpQxqmkozjavq0I4PnGZmBsKBiltrdtKJ+VcnUNFV3KePdqidEGgy2JcAS53ubMtmPdrLkAENNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
X-OriginatorOrg: intel.com

Alex Williamson wrote:
[..]
> Is it really appropriate to consider cxl_reset as just another PCI reset
> method given the scope difference?  Does there need to be a way to
> specify the scope when calling pci_reset_function() for drivers aware
> of CXL.mem/cache?

Right, FWIW, I am of the opinion that trying to plumb CXL reset through
PCI reset is an awkward fit that will be an ongoing source of pain. For
the same reason that CXL protocol error handling is designed to have
little do with PCIe protocol error handling, CXL is not PCIe. For
example, the goal in the error handling case is to arrive at a point
where the PCIe error handling implementation can continue to evolve
without inflicting the maintenance burden load of "what about CXL?".
Notifications are simply shunted over to the CXL core early in the flow.
CXL reset does not need any PCI core entanglements as far as I can see.

Once the protocol error handling series has landed there is a potential
to extend that with CXL Reset recovery. However, that needs a clear
error model defined as to which resets have a chance of recovering
*system* operation when CXL.cache/mem fails. In Terry's series, panic /
reboot is the recovery, not reset.
