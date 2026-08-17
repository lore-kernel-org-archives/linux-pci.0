Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB535838E;
	Mon, 17 Aug 2026 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998198; cv=fail; b=n+Axo9NTCoxedZC4Fl5OqHyWfrTxD40YgdGamj8ljDNUi58C7eCbH7ztAHiDcqDkpGJDQVr4oa+59NKNz7BThIzT7mPsYjHm98WtPp2zrjifKuSiLVirUhRs4kDdIe71ghMkt1cVAxreHtrr5QlW8nvl+Y8vxcW+NLOn2u80PGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998198; c=relaxed/simple;
	bh=jyYmeEDCq6RJQLE/KxES+Couxz3+y2Lf8aROeXuLR9E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jl6c0wo72P9hGAQfabtaPKiVrzB+sV9l4mZ4NJVhBz0EwmbPJWR36h0nmUot+U+Q02/KbtrOEoT1gcQShKGGgzKBK1x+LbndATFyH4eL58mM4nbtfkpHThbDV5o0oa/pC0rQ7QUPGbqmQwweqYXm2w1bg2n/ELE4XIsyGvUpZqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNYPHnLq; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNYPHnLq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786998196; x=1818534196;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jyYmeEDCq6RJQLE/KxES+Couxz3+y2Lf8aROeXuLR9E=;
  b=QNYPHnLqfpsPfHI2Xk69rjUteBNVx0WV0c7orVbX5Pi6DbAbFAcBKnAX
   /2lKLFiaa+yIYD4yTa0WHV4jIURxKMjMe6v3JeYTkmhcK+IywsSv10kep
   YxDx+rm/NeoqGzqbVu+WDQHDwdHsrFSWv68gB8qH2EOIx4aR8KhptxYZD
   tpXeSExapR80bXkKJB50+qo07fR1zGiiRNQM35Ap46T2+jNZdvPVfUKnu
   0HgHhitgvCQyz3OLV5GtGytgEbUP4VyXjgN+/ETUkkoKmK+UhH8J5P0j9
   ZuhY6uorLiWacY+03ShE8N1a+jc2AyC7bx92Ez1ZY6W4lQxuh8vS4pTUt
   w==;
X-CSE-ConnectionGUID: z+2Ict0ZSaSCiTN2R0ANpQ==
X-CSE-MsgGUID: HGBWr6XOTk2hi4tA894mlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91355102"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="91355102"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 13:23:16 -0700
X-CSE-ConnectionGUID: sGyn76SKRKaS5Fl112byXw==
X-CSE-MsgGUID: AOjEViIvT2uv8pbB81UGLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="261742278"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 13:23:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 13:23:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 13:23:14 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 13:23:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ST6bKdJoaLR9SF8zvLankTK8W9y0ACiHLNaBMTwONK0PAWiBfBKit3JxGN5vw1pB9I2/E2c7sAalvUu8ViFUUEkJsJJbrNw1RTTmUstjFwvlOqU9HHBdyWRUoTXLfuZIDEfxP9+JATzT1VQozgG6LggMsNvqf55sSl21WPBcsmXv91GIXbFmTj152LtZ1uAm9+aUv+kx6v96kbmitpO672ElnBiEndvWBYui/vhkT8leFmWo1+3UpnUCS8ffXGUVjcVDuwFjTxk/A6YZtpa5OcdXnsoNwo5iEZCnGXXiJ6Fi1b0MsycdyRZiXJg4ciH55UFDoiq5jgv44ToX838r5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfCoTGmzF0Khje8ZVwcvICP7z6bgvxk49CYib0j5DyE=;
 b=MLPrW8dCJCiNSp94z1XBS9zLwtCtN2VZHvPNPBaAJLZ/uRcDEVRsefRF+j4g7a9nmYSz+UejY1KT6cbJSOhH6f+euO4Oz/nHKC9HsqyEP3sDDSlvozvRGxnHnnsxrpOuRg/I+JRDNu245lAQcFHsGgTaWrfI/akpjQt0hh7gsYaHXzWc85HlD82Kw2D4g6X1naUgsy+Pr6BMuBIeYVor1FTmQb7X/C84yqI4mdIR+LCTpDHZ36+8OshiaTDUpTTejRczwp0HVoX/HZwUvlfx6vyTpbHTgwjwX2xkY9KINV2aXlsXp4Db+lXoWguHw0Y75g2lsGROeehnWRBTCaajVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by IA1PR11MB8174.namprd11.prod.outlook.com (2603:10b6:208:450::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 20:23:11 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 20:23:11 +0000
Message-ID: <3cce8c2d-3cab-462e-b437-da4edede6077@intel.com>
Date: Mon, 17 Aug 2026 13:23:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] PCI/vfio-pci: Guard resets against active SR-IOV
 VFs
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Williamson
	<alex.williamson@nvidia.com>
CC: kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>,
	<skhawaja@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas
	<bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
	"Andrii Staikov" <andrii.staikov@intel.com>, Mitch Williams
	<mitch.a.williams@intel.com>, Nick Nunley <nicholas.d.nunley@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Czapnik, Lukasz"
	<lukasz.czapnik@intel.com>, Konrad Knitter <konrad.knitter@intel.com>,
	"Pepiak, Leszek" <leszek.pepiak@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>
References: <20260812214554.GA1067593@bhelgaas>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260812214554.GA1067593@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:303:dd::20) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|IA1PR11MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 2668f51a-2e9f-4bfa-d407-08defc9d5b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: zjHqbx16svwTNLmpIm3/Qr7o8VXGt6OoeIwsving1vDMpyUf8SEqXzKFl99RZjefOEpF96+bTh0aEBRV15ygUZi7g1qypn6LC5TwefNTCLeKYJwccqHyvYBhzXjs2sRFSpv+COiVv1HnW3APwHzZbqOpe058NhjRY9SRW4HDXvIj7WdDdYW/1P6LQ6A5hwLf3+HOOjsFh3ck032ff7XA67ZsmZ1letninU4depWgIQmUQ9gsImzH+sfIdpM6gLQR18kOc/2yXd8A1hbwjpdmPdfGR4lgFWnnoszrkOIM06Id5Z/zGRxvPDGvx7DPpZ6EwZlqrhXHpHgcqikKhoh6Nd/Xt7CdPiOxbjrlbuFalkNOD5lezP5FcRhnCUCer/rIPhpFsYI75rrKX3BHGfbggJF3ARJMSpOE87kY7xnCPOniMv2HKBAkIT873VvRZHP0VSz5ALAKXIipOebsx3OK9yr/62JDzWcoMYSJcTXy8UhT1jTa79F+dEXVNfup4K9TNfXCz8vLxt/ustdXayVYQfE3lTToymfsLMpLTfVeT4NkDFN8VPW83PgALj2zc7xuOwpWka99IdZVIUhnY4lXmEXkxebvRtI7bXn9+YqSLdKxOhl1QZqe2RbgCM+iiOQlA3fZ11WKIz11mEq3zRUz7MQnhNydkV4fDy08T9zHGbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWpOenBMR0hTdGJZa0Q5S3p5Z1VtQ2dza3lBSldQWmxOQkdxQ2tZUGVZZDhm?=
 =?utf-8?B?SmZGMUFZdmNLVGloMFBqV1BsWEtYWHB3cXQrZGltUmFka2FQVk9yRjhOZnJV?=
 =?utf-8?B?UjgzMFkvUGRNSk1oNTRBRzdJYVlaWDRSN0lzSUlVWklGR3NheWZ5STBpL3JN?=
 =?utf-8?B?UXhNNFQwSHJjaXBjQmhzR1BpUWlrOU9ITDhpbGVEcGZVM1JnV1BidUVWMHA1?=
 =?utf-8?B?SFV6RGJnT3pCRnB3cWVDQlVVV0pRUHlya01tbmc1dnlVQ055R05US0RmMUlT?=
 =?utf-8?B?SHk2QWNVUDBSK0ZOR3JJbFV5UlpUZWhIb3VSTkpsNU5FUVFrMFFjYXA1R0E1?=
 =?utf-8?B?amFHRkRBUjE1MG9JTUdOOHlXbS9aa3lkOG1FZms2aUpzR1hzNlZmVDlKVk40?=
 =?utf-8?B?Z3p3L25SejZSZ3pBcWEyTEl5Q3EwVGlkVVdPSGxtcVg4bnhtK1F5dU5WWXhJ?=
 =?utf-8?B?bnlxeEhTRnZhb0RqYkpIM3M0R1JVYUxLdk5MM1dMMXZoN05rSm5xSStxNnRV?=
 =?utf-8?B?SGgxV016U1BmbWxDRmNybUhKTGtCdnNpQnE1ckZsZHZMZ2lHTnhsc0ZJcTVn?=
 =?utf-8?B?U0FPaXhNclZDYmovMm5aMDduWkNKUWxnUTN6SkQ0clJEeVYzOHhhUTYvWlRR?=
 =?utf-8?B?RUlycHlaRndIdy9VVHNyTjN5OHZmbXhxNnJjRVJSYkZUNDVuYWNpSTN2K0xC?=
 =?utf-8?B?bkVvVUNERUhaOHVMNmZBc2psc2duNXZMS3Bkb3JYeEZlR3phRUZXYmk3c0lX?=
 =?utf-8?B?Ykg0THA4MGhSbzYrT2JqSEdNalY0dFZKVjg5eDI1enBybk1rSDhyU0VuSFZC?=
 =?utf-8?B?MWExdVd3dWQ5UkE4OFNFWDYybDh2ZEpJZ29rUzZQc2FrOVJXbWZaUUI0a21Z?=
 =?utf-8?B?ZW1DODdqUXdSVXlQOXFpM254eXJpcWhPbmNMMmcwRjlxYXNuUVUzU2RoRU1w?=
 =?utf-8?B?NGxIUUxsTXhHYmI5R3RiR1pZVmUyM0VrejVWVXNBTmdybnQrc3psWnBYcy9C?=
 =?utf-8?B?VlBiaG16eHA1U05idkFScU9pTlJVMTRXYnAyU0YweVdXUHJKQ0tJcGZqS0lN?=
 =?utf-8?B?aThLQ0JOZWNsRVhPVHVGYWlFZUJVbkU1REtQbUlYeVRBcDVrREJPd1V4cUlO?=
 =?utf-8?B?TTdVdUtKRW5SOStkRFZTNGxOWnVDSGc2STA2L3NOd1dsK01acUY4ekcyM01T?=
 =?utf-8?B?N0ZRN2k3VGVhQ1dOQzRCcHJ2K2VJRFdTRFdsSmJrRllsKzJjWnZRNnBxRUc2?=
 =?utf-8?B?VDVSZEtCTWJwcmthUCt5TnBzQnAyZGpOdGgwM3Rwbm5CTmp0eWtlQXFKV3Zt?=
 =?utf-8?B?VGlQWWdTVkg1QzcxakVlVk0va1l3dWFqRmhpMGlpYWh2Zi9uZTJMa3VHdlJs?=
 =?utf-8?B?a3lZdTFaUUF1bGJMUzBlQzhRa2c5M2E3cnFSNk50Z1FMa3FUL2owWDRIeW5T?=
 =?utf-8?B?YW14ZlAyMlh1SmJBK0s3MUpwU0VpNnpvZ211VEpWUkdqczJzSk0zV2tsSlor?=
 =?utf-8?B?T25rTWpBYkhUMnY4Ri9KWmV0a3RtZEJhUit1b25yMTFBaTh6VEhTN1V1a0ZC?=
 =?utf-8?B?VXAxajRWWitqbGxuRDRYbC9xVDBENFJxTUJBUWkxUmdzeFdoU2plSExSbVBX?=
 =?utf-8?B?VHhhMHJVbUVIZit2SFlGQTlOaWliNytTNXYyTUcrdjl0MWgrMFQ1OG9mTlND?=
 =?utf-8?B?d0FiMUxmVFRtc3JyOElMcUhoNUJuUU50NllycjhJY3p5TGkvQVhsNTRMKzNX?=
 =?utf-8?B?Ym5CVnNrOG9SRWpiVkkwaUwxZE9uWE1QT1c0MkRYYW9XTU41bUNtdnk5TWxs?=
 =?utf-8?B?VVVxREgxdTQ5ZjRwQTR6SGlNUGQ0K0o1QXFkdFR0UlRvcTJpYkhFZy9HNkFB?=
 =?utf-8?B?VXhmZmFqTUFpWjFRT1ltaGNjZy9YVmliTTNObGFIOFEzL1JydVBUQ2lxTVkv?=
 =?utf-8?B?aGFVVTczTDZ2Z08wWThBVTJRSk1QaHJOSVpnd3ROTGNjZlFSVUpUQ0prT3VH?=
 =?utf-8?B?SUl4RyswVE4rTGlKSE5Tb3llaGcxSWFDQWZUV3F1bEFYNXRVY2xIZzBJVDAz?=
 =?utf-8?B?bHpXUzRrSUZnUGFSeXdNUUI2RVQ0d09IdGM4VFNtNHVyUUpXTHowMERsWWpS?=
 =?utf-8?B?RGN0ejN0c0RwUHJncU5ubXBPQnovNi9pUG9OdTcwZXJldUdTLzBoM1FGMDdm?=
 =?utf-8?B?Y3N4MHV1enRvUVFhUWFvMWFpMGZJWlJ3VDJkVWo3S0xJR29YRkovTW13SkJt?=
 =?utf-8?B?VTVaTnZxRXJvMTBqclVnckFTak5sUzdUMEprMHVZdzJXR0h5dm1GanNDZy8y?=
 =?utf-8?B?MW9hVG9aaXNnNUpEa3NTdzZkcmwzZG1nTHlqOFhtQjVUZ3JFUXhBRC82blBu?=
 =?utf-8?Q?LtXWKMb7Gb+CE3Fw=3D?=
X-Exchange-RoutingPolicyChecked: Usvt3cX6qPAZGwZnrL+kWVGBdva/ANv/2re2u4JZVR5S06Yv/ClJmLaGanuDn8BCJVamBpSID6/AhHWxPBk+++t9Yyd2NuAaSl3zcPJL2CEToghl4+mm7ZzeJJcgUxkDR6AV8eYNEsh2pKPNPEuk0iEZQ2FlZsHG6FwlwYOb1GDP/eIVZUG7O1CnwWoUC+bSNK9PK1FL/x2Sy8riBB4ysaTwxidQpcUeMB/A9MHdRiSgGSPmT4cMOwsz9jEG5FYAiCpzF3UOyapnt71RwGf4D2XkqanBlirHN5jgHHUs80A7y82w1e1FtbAoSLkrjh15mgIRD12dnqAe5qGmpmV4pQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2668f51a-2e9f-4bfa-d407-08defc9d5b95
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 20:23:11.2876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDQJ5HS0KfDqmummxzyZPYiTBBeq3mu0pZGpo5bpYEVnGlXBReXEo3+xe4m2p5b0oMiuK6JediVEF7FK7eTJW2J9QyPshi8QZWnC1jd7Xwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8174
X-OriginatorOrg: intel.com



On 8/12/2026 2:45 PM, Bjorn Helgaas wrote:
> [+cc Andrii, Mitch, Nick, Tony, Przemek]
> 
> On Tue, Aug 11, 2026 at 10:53:18PM -0600, Alex Williamson wrote:
>> It's recently been found[1] that vfio-pci doesn't restrict resets on PFs
>> while SR-IOV is enabled.  This can not only result in an uncoordinated
>> disruption of the use of the associated VFs, but the ongoing use of and
>> access to the VF has the potential to result in machine checks.
> 
> I suspect this might also be related to the somewhat weird usage of
> pci_restore_msi_state() to restore VF MSI state in several network
> drivers:
> 
>    https://git.kernel.org/linus/371e576ff3e8 ("i40e: Restore VF MSI-X state during PCI reset")
>    https://git.kernel.org/linus/7e4dcc13965c ("iavf: restore MSI state on reset")
>    https://git.kernel.org/linus/a54a0b24f4f5 ("ice: restore VF MSI-X state during PCI reset")
> 
> I think these are a little weird because they only run on a PF but
> call pci_restore_msi_state() on all the VFs.
> 
> I guess these paths are recovery after FLR of the PF destroys the VFs,
> and after the FLR, pci_restore_state() on the PF re-enables the VFs
> but leaves them uninitialized.  It seems kind of ad hoc to restore VF
> MSI state but not the rest of VF config space.  This all seems kind of
> messy and makes me dubious about exporting pci_restore_msi_state()
> directly to drivers.

Yea, this is situation we were trying to address; it seemed better for 
the user to try and recover functionality rather than leave the VFs 
non-operational. I like the idea of not allowing the call, when SR-IOV 
is enabled, to stop it from occurring in the first place though.

Thanks,
Tony

>> This series proposes that this gap is largely an oversight of
>> pci_reset_function() to recognize that a PF reset affecting SR-IOV VFs
>> violates the scope boundary of the pci_reset_function() API.
>>
>> Patch 1 introduces guards in the common wrappers where we can hold
>> device_lock to prevent .sriov_configure races.  This covers locking
>> conformant use cases.  __pci_reset_function_locked() can't be gated in
>> PCI-core; it runs after the potentially destructive .reset_prepare.
>> Therefore its callers must provide the gating, along with the locking
>> and state manipulation the interface already demands.  The vfio-pci
>> change is included as an example and known use case here.
>>
>> Patch 2 introduces a callback to pci_reset_bus() which allows a lock
>> dependent callback to be evaluated after locking the physical hierarchy
>> and before initiating the actual reset.  This allows use cases such as
>> in the following patch to evaluate the SR-IOV PF configuration without
>> racing.
>>
>> Patch 3 implements exactly that test in vfio-pci-core, such that the
>> hot-reset ioctl can be blocked when SR-IOV VFs are present on a bus/slot
>> affected PF.  This completes the lockdown of resets induced on behalf of
>> the vfio-pci in-kernel or userspace drivers.
>>
>> Patch 4 exports pci_reset_supported, which allows patch 5 to remove the
>> latched reset_works flag, which already had the potential to become
>> stale due to reset_method manipulation through sysfs, but now may also
>> become stale due to the SR-IOV state of the PF.
>>
>> This is RFC to capture the discussion of [1] while it's active but
>> requires testing before formal proposal.  This effectively side-steps
>> the feasibility and security question of the operating model in use by
>> the referenced thread by generically gating resets affecting PFs with
>> active SR-IOV.  Please review and comment.  Thanks,
>>
>> Alex
>>
>>
>> [1]https://lore.kernel.org/all/20260805003355.728299-1-skhawaja@google.com/
>>
>> Alex Williamson (5):
>>    PCI: Refuse function reset of an SR-IOV PF with enabled VFs
>>    PCI: Add pci_reset_bus_cond() for a caller-gated slot or bus reset
>>    vfio/pci: Refuse to reset an SR-IOV PF with enabled VFs
>>    PCI: Export pci_reset_supported()
>>    vfio/pci: Use pci_reset_supported() in place of reset_works
>>
>>   drivers/pci/pci.c                | 117 +++++++++++++++++++++++++++----
>>   drivers/pci/pci.h                |   1 -
>>   drivers/vfio/pci/vfio_pci_core.c |  28 +++++---
>>   include/linux/pci.h              |   4 ++
>>   include/linux/vfio_pci_core.h    |   1 -
>>   include/uapi/linux/vfio.h        |   3 +
>>   6 files changed, 129 insertions(+), 25 deletions(-)
>>
>> -- 
>> 2.53.0
>>

