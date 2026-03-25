Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964E119C540
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 04:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411995; cv=fail; b=Ig2Ek+PRwtjuWLEnHuOeICNXWxRjCtpKGDSUuFSxKzM5rt5UZMNX5Y4jdfWc0ToJZZR4nWLaDAkbxxswZf/NmIHC7Mkk35BSmT+ItRA6C5nk1M8ZJglX7Tz1wr3g+qZ2yBLBD0ILq4k7L4oB1ukj7RA0lrGX3VrItA1wr0MR7uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411995; c=relaxed/simple;
	bh=Urvl1YpbHhAkL/UBkLr3hvdBGD6nG0KqUsC7jLMAntk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=UtWjJmeRz4pYc4owO8msRAmZ60N1FmTuIUMKhtXjQMIoCW/q0Mttf3JtSaloTvhFacmz+zSC0FiXmafqjPHsHR+rHusj8CweS5xAxSeJQaPhIxiPKeg0pEZFrirUbQ3kIWNuWzJzMtrRgkE2fHIUa29csCiBmH+NR9Bbotd1qHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SuL7yqHU; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SuL7yqHU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774411991; x=1805947991;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Urvl1YpbHhAkL/UBkLr3hvdBGD6nG0KqUsC7jLMAntk=;
  b=SuL7yqHULJ8iDMiUFbPil0uDCNLdkXOrCvrE16Tc7m5Y/mJfECnenn87
   waJgJxiPRyuvu4BTBJkEWRZWr3iLRsY+NsBAeV59H6mClPszYDZOeE21s
   ZHgBasOlgR4aLet4H/Zde58ZUGFlOd+hLMqCIkbG9z/Vlr5i1RdmOVtHQ
   UYhR2edtGw71R/uJfOwGxqCg1iZlwEsMpAlnQtyPS0ul+Jwqe8wAN7EKj
   Kao3/a1P4r9A/PsWLtELtk7hq24ILGg5KBAyp3Axtd7jCSASrO8cZgLKd
   G9A9zrithbh2Wb/iUeWYfUK3xh72wOzc1d7euqOprzvd8M2meFVMHNVfi
   w==;
X-CSE-ConnectionGUID: XK3hZzVWRHKceSj2clrpOA==
X-CSE-MsgGUID: jSBkptSkRZGAjF2rtXRUQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79037875"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="79037875"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 21:13:10 -0700
X-CSE-ConnectionGUID: WAPQf9JqQBeLU3s5xNxYXg==
X-CSE-MsgGUID: X8weT9hnSnSYQoE6N/7czw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="228626849"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 21:13:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 21:13:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 21:13:11 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 21:13:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7FklJr468gH8Nk6vF8FvQLRade7GPU3heZ1FKswzCoast2HlhMohFCmRMVGcNs2Y1/0zlw1gIAFDd9hegrveIAtBlUsw3dDM+ZcT9KL8144xFhjnb72wKsiPLqpDn8VB6sW2KNkEUqV/dbOucxVm/PyUJAUUf9juxlqaFzMLrqmzqcVqAaNpwQ+10oqx2LGjH+1KjXOEPtifDe5HjuBEL55vWRjAa3cBASVodg4+sXFa3lzqqeitU/VjdNzm5daswRxppgoqbBA4bH0CNJYELfVts8kmufyI3fyW20hTbtGieqV7vIEzUmu/GJ2Efo2Kmdz5KCBQuN/DwKKtOU1Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkadEofsaUf8iyVfpIqMokKxLFIFWsEbF9JW8gRFZ8M=;
 b=bSPkdLsRAp93CelkIfGIK7vyzdR+X5Ah+f6Aob1ZHzebKBHEzo/fsBE36XWriScV5E/VVE2dSN7ad40vJMK+hccDU8VoLp217yNSoV7EJX03AhUQlmDDKVXmhsgcGEXcHXwT0a0j020pFcmFszjZHHkHAtnjCAGGa8M9r1DZpN58ls6WkLzL5AYNZEsGNQIFFmOdSYwzahbJRNqMPgKl1LZgZeDePgTj8LUerimPKo7xCaWuik4AZqapCIEqUcMGOaCXkH84uxcGEvgaoeOLz5D1dYnb0mw0aH33CUYT0NvuGIM/8oQWU4GJk7iXdJ7FbjAMrzAkCaVpQ704v/C/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7502.namprd11.prod.outlook.com (2603:10b6:a03:4d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 04:13:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 04:13:08 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 24 Mar 2026 21:13:06 -0700
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: Greg KH <gregkh@linuxfoundation.org>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<lukas@wunner.de>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Roman Kisel
	<romank@linux.microsoft.com>, Samuel Ortiz <sameo@rivosinc.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Message-ID: <69c360d2107ca_7ee310052@dwillia2-mobl4.notmuch>
In-Reply-To: <20260324123649.GY7340@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-4-dan.j.williams@intel.com>
 <2026031230-mastiff-create-7593@gregkh>
 <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
 <20260313133235.GC1586734@nvidia.com>
 <69b46bd7935d9_b2b6100b7@dwillia2-mobl4.notmuch>
 <20260313202421.GG1586734@nvidia.com>
 <69b4baab2b950_b2b610013@dwillia2-mobl4.notmuch>
 <20260323181413.GP7340@nvidia.com>
 <69c1f469f2814_51621100bc@dwillia2-mobl4.notmuch>
 <20260324123649.GY7340@nvidia.com>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0328.namprd04.prod.outlook.com
 (2603:10b6:303:82::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd1f55b-57dd-4e78-b1ce-08de8a24d1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: cEY6sfdJd4gg/auApqHmB+8gdComxmo+Op8vaJftb0RpQMOncFYI6qcEL7hvGJ/QVlhW+5qzgoFUC1vGAtq6rQ9iWzPIg54kDnkYB7nO3jjxgV/9QIeZNqcEX0+KYOP5lhwlkOTODcNRS+rBFNf97vObYAsR9sAgZMuu3QEVuVEP/U9wv1IUMv+itpv6RBDuXKA49jAxtmQDcY/9p38qPypwcX9clmHiaxq5OD6QgyeO1DGpFrjbCqXxYIIvLlCSkFb54WWBIpa5r9nGtl3joXtYzeauwMRG6FmKceSgzp6yux8wvXRMIgKNWK2QqMH992m251A7DcTKFUtTG+w/MJaKi8732Z8P9guJBr8HeSV5/DC1Jfmz/HU0VuelXJJrn4Rk1Yz3ujoy4ZhLztIrX67NA7XAwNmP9ZEhGpMCY3AW2e4fsbbky6OlLe+SP3cpBTTe493uUiAhJXluPzk9kyDedwet4d1cWR8cf3N7BKAOtLjYC7ZWF8+R5sBy1U02wkWAHerADq+bAC0LLVYzeSyNaaz8UiK5rctIZx+AIP1BaA9zMVaBJm/YwmhXlAgdiJtVmhph6Orsxbc7JVRS/5mHkirN89XrVaullqXyEKzskWsrhqcgzKDruta9ITemckQq4yRU7UV9TQ5wLFogUxUnfaf8IskOgFfoBQjuD9Jvxi/OAG+dgErpPmdO71rbREGOW0tQVK2M+TtPapQJ5jRR+DK1FNnvrTDz7WA8R2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0NDMHkrQzBwS3Jwdm9MSkdLMVVyRGRCVm9MUkpXSGVsSWVMSG9seitWNk5z?=
 =?utf-8?B?UTMxNEQ1bDc0c0FpNW01bTVnQkF1cURkUW9MTWgxa2N6Yi9mVGtmd2tLU3BC?=
 =?utf-8?B?SmFTY1JQZXJuSnlJN1c0UTVFaEZ4d3lMMTFtZWtpZHNockFGRWdtSHo0TE03?=
 =?utf-8?B?UjJlS2FKeWNVWUJHaTFXK3AwTFB3QUlFTG9EVHJlV2ZxYU5odmg4dk05OWxU?=
 =?utf-8?B?cnhxU2RMMThUT3FqVERNeC9xUm1YYVlXSTRTZzdrQXFxNDBtd29QOUtQZXU2?=
 =?utf-8?B?M1o4WCtRb0hub2ZFaEQyZzNLZ1ZoazFYTTBCaXkwZWMra2JYOGJTUjlBZG45?=
 =?utf-8?B?Y1ZwOFpZUDJ0YWZkOHlnem5XZE1hV3l4d2UySHMxN2lUTW90dE44dnpndE5y?=
 =?utf-8?B?OU1xREsvNjhxeHh2L3c2RlBtMmRoNkxudjFPT3c2TjZNWWdtL2VDN3dhVnpp?=
 =?utf-8?B?ZUxuUktwejVSQ24weitGWEtFend2ejZ2cGtkaHgxVEVKV3pqZFVXWk52d0hm?=
 =?utf-8?B?SUFJQ3lVUHNtQlFHUENjcVY3c0dJQU1ETkt4M21rNGY3eHRvakFvaHVQMjAy?=
 =?utf-8?B?NVdnYXllSk9JTDNsZzdPeVFMUUx4UTlhNzRMUkt1b2o2MjllTGtDaUFtVTVF?=
 =?utf-8?B?T3ViRnhza29UQlRiZUkyQUJPY1RuaXlPWTJnemZjZGdPZW5VZWNNYmlzMzlB?=
 =?utf-8?B?clp5ZWZjT0VKdWsyTENQM1hLQUJBSjhYdVFia2RmZVVQWTZXUUkyZjkvUmZz?=
 =?utf-8?B?REJRdWZFZ3lBNzNESUhZR0kzZmFqUGtlbzRNSHZTb1d6VEludUlRNitEUW1p?=
 =?utf-8?B?aWJ4VTlzOWpZZ2RiZzVaakg5L0xyeElnSFhoMUpIa2ZSVVlIYnFwS0VoMitF?=
 =?utf-8?B?U3lZdWwvd3hPOWxURkQwU3ZWS0NUcEQ5d0RwaDh3bHI3MStOaXlpYURaM0hW?=
 =?utf-8?B?ejJpNU5UWU1Qc3llUGpqd2g4N1BxRFkwcXUyeUJWbGNHRmpJRTBUcjBmNnRC?=
 =?utf-8?B?UjFRVkJWeFZZU3dzZFFGdmF5ajFmV3N0eVBGcTZmTVlRSXRJM21pbVZIaEdX?=
 =?utf-8?B?UHdNZFphd0xDZzBURThoaGFETG96N3U0TksvcHJLMk1mWEdyV3BCaEI2WmlG?=
 =?utf-8?B?dzJMRVFhNUVHUVZPVWkzYlVZZksyVm5pbVBDcE1HbW9RTHlKUjlpMXpRWU11?=
 =?utf-8?B?L25DcDJsZGUyanVKZ2JSNU5DNDk1Slk0aFF5V2Rsb1V4bExFaENwcGs5T3Z3?=
 =?utf-8?B?OFEzZ1Z5bjNUWnRUQVd5dmZEakQ2NFdBNDdObEhEQi9wcEJxV21BVWZZcW5V?=
 =?utf-8?B?dkhjajlRQXJhSEpCRG5lOU92QUZRdTBnOWY3RkZNTFhVSGFJU2lLMDNtS1Zh?=
 =?utf-8?B?K21sYjZlYmtPbmpKbExWcFRBQ3pobWxEWDJNQTRTTXJHN3VQSldBd25QTWZI?=
 =?utf-8?B?RFlZSitDN0MvZGJFT3VjRzc4c0lqVmwvVHdUdncybU9mS3BTeFFIN1NZRWhQ?=
 =?utf-8?B?c1BlSlFXV2dTdnYxY01tRmgzYjdJaG1mT2R0YXVWaVp0Z0dGa2xpVlNPYWps?=
 =?utf-8?B?MTVZNUtlbUNaT2tzRXZtaVM2TkFyblV2dGVzN0RwK3pjMGwvZzVPa05GQ2hX?=
 =?utf-8?B?cEpGemxuc1Y5Rlo3Vms4aWJpUnpMb0MvanJzaDV3cVVCVWhlaWpGTHZYa3BQ?=
 =?utf-8?B?QjQ3L0t5Ris5c2NYYVQvZWR4eFVhdzhJTjl5NmlUY09jZE9zWGorMTRIUW5r?=
 =?utf-8?B?NERXMDJBOFlxL3FRdXFOdUtnSHlUbXBpM3ordCt4cTdFaTJ2TzZBV0FJV1ZL?=
 =?utf-8?B?RG15VERGU0pjUk1IRDJPWTZ5V0VqUFJxSWgxRVgxbnY4UmRnKy9mUzFPbSs0?=
 =?utf-8?B?L1ZTRWlkS29nZXVnSWh3TVJtS09DaFJlYktqejg1cEtaS1E1cEhFY1dUQjRn?=
 =?utf-8?B?U1dueGpHWngyT0xzSTZXdFJrd3VERE5qOWpxNzREdVhKTDYvdlRkTkxDS0FF?=
 =?utf-8?B?NUFtaDdQQVZldDB6WHdmZFMwa3JqYklQdTJCUlh3K3JCYUdBRkZZTytTYkJ2?=
 =?utf-8?B?R3IxNXZJOEtYdEhFKzFnSkpjWEk3TmNXNEtXc0NSU0Jua2plQ05iWmtDRUll?=
 =?utf-8?B?OW9LMjUyeG9aRUhOS24vYlIxQWxnZVZRMzhZWGpTK0lZTjRRaXRpbmZLZ2tR?=
 =?utf-8?B?VGVHeDByM2p5Y0diMVR4bXRVZ0RRUEJwdlRnMHozaTVxNk5JdUFkeHB2YVE0?=
 =?utf-8?B?NmVNTmJFd3B0a1Z1QjdDamdyTThFN2VoVG9wclh3V3R6clFyczhKekdic1lt?=
 =?utf-8?B?SzJCVGVZSU9HVmt5MitVbDdBRlEyaFVIZ2VTZlB6UGZhUURPWUFrd09odXhH?=
 =?utf-8?Q?e/R3NGQLt7t9tahQ=3D?=
X-Exchange-RoutingPolicyChecked: OjMqcc3Ur2Otxejn2Hzb4gh2j6CzcX7uhed/4Lh3DuBK/sRxJrAi60RFZcD7AYN14L97G6gLi1mF4i22hRePHj/JMsUJTQYCXL+SJrGJAMgB6y4oonrOZ9vyPuI6bQoWjAdzOqO6VszjGCFVovk2woYF5g80x2UamkzC9HcmQ2nhhQ7h/XqlKh+hFKhTHa5RwSn/c96DGeSuxGyorztdb57bpHh+Bxdjy8WNwkG2tg8Q+AbEWMcoDhmjsOD/QcV68fXQ+qpJ9NyTWUce2xPCALBeM+cnc2ZC9zXDze96TWiDtrgpoVIuvnEVeuDrffeK12Gl3hgnwQnespoF8rV5eg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd1f55b-57dd-4e78-b1ce-08de8a24d1e8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 04:13:08.0536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Htq9Lv2iBPp906ztlP4mhTw9zXRlrAGoCv2m9zqN0w+7+obv7bzi9fOH0I3YoDgUw93cw5FXoqz42U1H3+lZFVW02/azU0BlOydP99hoLq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7502
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
[..] 
> I feel like starting with trust=0 is much cleaner than using
> autoprobe. Especially since it would be nice that when you do
> ultimately set trust!=0 then you do want the kernel to do the normal
> autoprobe flow.
> 
> Double so because I would like the iommu drivers to respond to trust 0
> by fully blocking the device 100% of the time without holes, so to
> make that work I would like to see the struct device report trust 0
> the moment the iommu framework attaches the iommu.
> 
> How you decide the starting trust value for device during system boot
> is definately something we need to discuss properly..
> 
> I liked your idea of using built in driver match, so if there is a
> simple command line paramater that says 'only built in is trusted'
> then we'd default all devices to untrusted and during device probe
> check if any built in driver is matching and auto-set trust to X based
> on the commandline parameter.

I do agree that forcing trust=0 at the beginning of time is attractive
and theoretically clean. I am concerned about subsystems that are not
prepared for driver attach failures. For example, I would not expect to
need to set trust for auxiliary bus devices if the host device is
trusted.

However, the work to set module autoprobe policy is on the same order as
adding a module scoped trust policy.

So something like "modprobe $module trust=X" automatically tries to set
the device trust level on attach to any drivers in that module. That
could allow a semantic of "attach iff device is able to go to level 4".

> With the idea that only devices required to get to the initrd are
> built in. Then the initrd userspace has the policy to bring more
> devices into trusted!=0 to get to the root file system, then the
> rootfs has more policy for further devices, and so on.
> 
> Probably this would ultimately escalate into annotations in the
> modinfo about default policies for various drivers.

Yes, escalate over time for subsystems to say "devices I create are
trusted, the responsibility to manage trust lies with clients of my
APIs".

> A kernel default policy of trusting everything without a "trust ops"
> (see below) may also be quite reasonable, however boot ordering the
> trust ops might be really tricky...

Given the optionality in selecting a trust ops provider I think it gets
extra messy quickly. Let me see how far I can get with built-in auto
trust + module trust policy.

> > > > > The DMA API just wants a flag in the struct device that says if the
> > > > > device can access encrypted memory or only decrypted.
> > > > 
> > > > You mean separate "trusted to access private" and "currently enabled to
> > > > access private" properties? I am trying to think of a situation where
> > > > "dev->trust >= 3" and a flag saying "disable bouncing for encrypted
> > > > memory" would ever disagree.
> > > 
> > > I'm steering the trust level toward more of an acceptance criteria.
> > > If the trust level is you have access to private memory but the device
> > > can't actually do that then fail the trust level change.
> > > 
> > > Same for the reverse, if the trust level says no private memory and the
> > > device is T=1 then fail the trust level change.
> > 
> > Ok, so the uapi for PCI/TDISP would be:
> > 
> > echo $tsm > $pdev/tsm/lock
> > <gather evidence, validate with relying party>
> > echo 3 > $pdev/trust
> > 
> > ...where that @trust attribute is a generic device semantic, but in the
> > case of PCI device connected to a given TSM it invokes the TSM hypercall
> > to transition the device to the RUN state and the TSM local call to
> > unblock DMA to private memory.
> 
> Maybe, but I was thinking the transition through run/locked would be
> done through TSM uAPIs too. trust setting in the kernel just confirms
> the device is in the right state.
> 
> But I haven't thought of a reason why the final switch to RUN couldn't
> happen like this either.

Right, the potential to see in-between states concerns me because TSM
uAPIs would have fully enabled the device to wreak havoc, meanwhile
dev->trust is still showing the device at some lower level of trust. So
I think trust modification needs to be synchronous with privileges
granted/revoked.

[..]
> > The complication vs benefit tradeoff is indeed not mathing, but wanted
> > to do justice to Aneesh's proposal and the suitability of the sysfs
> > uapi.
> 
> I think if you want something like this then it is better to target
> the root - remove the ability for concurrent userspace to wrongly
> operate the TSM entirely. Ie use a cdev, make it so going to LOCKED
> isolates access to only this cdev fd and require only this cdev fd to
> go to RUN. Then these kinds of bugs don't exist.

The netlink evidence proposal can handle this, it just needs a
'validate' command. 'Validate' records a device evidence generation
number. Require a stable generation number between entering LOCK and the
trust=4 event transitioning the device to RUN.

Yes, not as safe as fd-private LOCK-to-RUN, but I like semantic of
"modprobe $module trust=4" to say "transition to RUN and attach to all
validated devices".

[..]
> Basically the 'trust' generic framework sits on top of some "trust
> ops" that will be provided by the security module that is affiliated
> with the struct device (ie thunderbolt, TSM TDISP, TSM Link IDE, etc,
> etc)
> 
> Then it becomes a general synchronization point where on one side the
> "tust ops" can ack that the level is acceptable and consistent with
> the system when on the other side generic compoments like IOMMU,
> driver binding, etc can respond to it and change their behavior.

Something like this, yes.

> > For bare metal PCI device security the TSM 'connection' needs to be
> > established in order to enable device evidence collection.
> > 
> > echo $tsm > $pdev/tsm/connect
> > <validate device evidence>
> > echo 2 > $pdev/trust
> >
> > Now, I question whether 5 trust levels instead of 4. This would be to
> > explicitly only trust devices where the TSM has established physical
> > link encryption, or the TSM has asserted that the link is protected by
> > other means. So the trust levels are:
> 
> I probably wouldn't use an int for the uAPI,

Yes, but an int for now saves the bikeshed of the level names till a bit
later.

> ...but yes picking the initial levels is important. As above since
> this is a clearing point between two different worlds it needs to be
> defined in some way both sides can understand what it means for them.
> 
> > 0 disconnected: bus does not attach drivers
> > 1 limited: core code deploys hostile device mitigations like disable
> >            ATS, CC force shared memory bouncing.
> > 2 DMA: full DMA access, driver responsible for protecting against
> >        adverarial devices.
> > 3 Link: mitigations against physical integrity and snooping attacks
> >         deployed
> > 4 TCB: full device interface validation via a protocol like TDISP,
> >        CC private memory access granted.
> 
> This seems reasonable to me, the 3/4 distinction is not meaningful for
> the iommu&dev side, but it does provide a good check point for the
> "trust ops". If userspace ack's that it expects physical security and
> the kernel says it isn't physically secure (or becomes insecure later)
> then it should fail.
> 
> > Where the native Rust library based SPDM driver only offers trust level
> > 2, bare metal TSMs can support trust level 3, and the TSM interfaces in
> > CC VMs can support trust level 4.
> 
> I'm not sure that the SPDM driver even provides a "trust ops" right? I
> would guess that 0/1/2 are simply built in always available if trust ops are
> NULL and 3/4 require positive reply from the ops to accept it.

Right. Even though the SPDM driver allows device evidence to be
collected there is no event like LOCK-to-RUN that expects validated
evidence as a precondition.

> So #3 needs a "trust ops" linked to enabling link IDE.. If this is
> done in-kernel the link IDE module is providing the trust ops and just
> using SPDM as a library to establish the link IDE keys?

Yes, but note to date only Intel platforms allow for IDE establishment
without talking to the platform TSM.
