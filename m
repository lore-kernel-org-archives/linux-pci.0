Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DACD30C608
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774488432; cv=fail; b=eDoMDL9h75/TRzwgP4PHkkb49Pmlex0GOvwW5LGLbcoyrxwCS/DYoz4ggY+lf+iMCkNmqASd5phhTuWjPE+z6uV+WZJj/CU2kgHA5n2Oet7ljELM16xsbc8YsjpzgRQvOu5Q2DWcEMXZgzT4Nt+OVxp6mwjLvRe+4DyghjdlFAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774488432; c=relaxed/simple;
	bh=U88LtSZf2jqtTluCHYP5CF5ZwCL401XQbuuq4edYRgg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=mfMBCk/llN9fi9ViFhn3x+yXrg/oKTib8+WnNO9VkPeo2i+czur7pse5oD6Ze3cVAAzIzsl/YW45msOZLmThRPKcblGg0xoLUp3ETYArfeEnWfvH8Oq3brsVC/yJv1RMpc+XI89+k3nBq1CJ4PiEFby4d48jK69rplNpuqoWe3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5WFPJUu; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5WFPJUu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774488431; x=1806024431;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=U88LtSZf2jqtTluCHYP5CF5ZwCL401XQbuuq4edYRgg=;
  b=m5WFPJUuu7d9/DrG6+72Ub2sdyKkJtR2759Umnlq3TzMaRRMwOwCpM8k
   zeBJ6UWvI5DSQjOQYmf7aJulo0SrTO1EoTsdTs4n+btVWl3ggixMiVv3S
   fQGPKcEnl94p/T2Ni1bHqIG5sadw1ZLDNGtRLZCmgpxD1B+vgt2xRGSAL
   xy9j5R2Chox374MZofak5qeed5yDiqJoIqXr8fKehCcLeCsUignUaAHiE
   LeVZl/Nn/35hEXfqWISl4EQ1VmAzziSF8IVhGpHRdVRvUw2fAuJ4P1oZM
   v+AH6T64kHTMKKxzUxNGqdV4F9PWOTJ1IRlr1w1wi8sHm0e1ro1icpWVp
   Q==;
X-CSE-ConnectionGUID: RlUP1iR9TTmaHh9wgrYnwg==
X-CSE-MsgGUID: Uv+MIhTeQ96ANMHLtEOROA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86157003"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86157003"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 18:27:11 -0700
X-CSE-ConnectionGUID: JC45qRS8SEe6VuFN+mZKBQ==
X-CSE-MsgGUID: b/rDJnNzTXSZx8mPyXmDPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="228917166"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 18:27:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 18:27:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 18:27:09 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.70)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 18:27:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVwswbb8bVKxdkE8N+q0pUNZdXZEwKoIcDZbyU+PhufbQxPEg9abSPqXKG+Od/c1lKyui4J07YxPsH7Mno8diDvQfzq03Isilf+7tpsIoa9p4RU6pDziKUAggVjcCpvORdMa+JkR0NDaH01uLOaEKd2/eEsfg+PQYaC1HaCBKcdCPCAORObNqWN8K39VmgKrKxhyno/FjmcL+myjgWSKoPEmiImbhoE3pqboYy38zgyZ32cTTR3WrnchKyydYu37sg4GscAq0GqrwbfMCl8eOR7R/LHbngjBCJl2dF3Aw26PBKhn7rjVF+RX4nUK+4OJHKz2Du3+PXFbdjz0Wmsn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN7toxTWZKrenDy8O2vKkCFVD6BGytICjVfthJID4rw=;
 b=KibjI7GUOgweeCbByhW/qvGDuer8PxnIlsJNNanRl91GPQfHYXTEDZvPufmPmf7+/BqKI4OytiNryvTxW89DLdCi9XIciNWM2Efh2AwLXUK4REMb5FK1nJAO6BtwBnbzUx1eEKGHmJ9Y+eEuvNO5hqgbDv5QLsBcjJLVwl8ZUwCfqzEjTNySelMdWWP7BzjSoS5S2qYWsO9YGBrVvmUvRmAta57ijJT79i2ubS3eTznqilCsIVAmG8fLccz1WSJlSgjehXUGcjbEMxmgWKs9mvYvws3OZx4J8/IxoxU/JEaly9BaS0iLBKebLaAcN/+ROMxkcsWX5tr70/W9QMxoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7149.namprd11.prod.outlook.com (2603:10b6:303:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 01:27:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 01:27:07 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 25 Mar 2026 18:27:04 -0700
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: Greg KH <gregkh@linuxfoundation.org>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<lukas@wunner.de>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Roman Kisel
	<romank@linux.microsoft.com>, Samuel Ortiz <sameo@rivosinc.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Message-ID: <69c48b682e6fe_7ee310068@dwillia2-mobl4.notmuch>
In-Reply-To: <20260325115607.GB67624@nvidia.com>
References: <2026031230-mastiff-create-7593@gregkh>
 <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
 <20260313133235.GC1586734@nvidia.com>
 <69b46bd7935d9_b2b6100b7@dwillia2-mobl4.notmuch>
 <20260313202421.GG1586734@nvidia.com>
 <69b4baab2b950_b2b610013@dwillia2-mobl4.notmuch>
 <20260323181413.GP7340@nvidia.com>
 <69c1f469f2814_51621100bc@dwillia2-mobl4.notmuch>
 <20260324123649.GY7340@nvidia.com>
 <69c360d2107ca_7ee310052@dwillia2-mobl4.notmuch>
 <20260325115607.GB67624@nvidia.com>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:303:b7::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1e60ea-7704-4506-1bbc-08de8ad6cb19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ll3w+nVCYv3YK9i6q4jbe3uI2qGuFF84Tjysght1OjRk9ujAhgXqdqjI8ItW9FNQufS6onjx27ZqnlGFTECQ2D3ndBIr6MJwPePlp3YhXCZN007OqtWNY++b2RDHB6NQsDzZ07u29p87H9nlDVEVDHi4j47mZkgLdqmdgbZtP7W+ynd8mKg3yOO2UAER6MINN2rhO/ikvwqgwQzqiMgaVJ3dMynGVhm+wLaaczonZ5cR/XLyjjrPN1UJh0d4gx8ubIoS9uhvHviEbVPPzDjZpGOsKZyybgV26tFu6WShAiCahb9NyV0fiNUTDAButC0bfhArVS9Nn3lTCA/tVcyB/cpnAH5GvCdTx4TkdFBZDPzlvqtKkmiARuHjl8Uva9xYh4iUNBRlTW2HZbwXidob8aNd0K70xejMwY+iU7K2+utrLwrn42lIF8xXXU2jDWII2sYRACsKfBdvh081PvSE0ZEzUKbc+Cksy1TgTix1fWJtA/H1DEtE41eJzbX9IBTAgM/vvZNDH85vtaNv6Xos6Z7kemPtIlW/ZlbuFvqcShe60P4YkuH733OYRN9n1wExa5lmyVT69pfoQoviB7ZOCTXh1ttAyDL2WH+mHSxNKqWvIm+aDDIIv1RoRzBLG5tJ2x6ydhsyQ3L5nCE7aBz8Y6kqV1UGyRh8QxglcYgs/gstqYmPla62Hl+XvHrPWBL62iixtSMIiwI29oTOqZQxxdirXc2qR74DNS2yb8pO0r8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWU4cU1qY1ZMZjkxSkhsbmRUZDFVNXNxSW1rN25WSVpYMzZ1cjVwVitIVlpm?=
 =?utf-8?B?U1k1V1dWelFyQmdCaXNjMjdSeWk5TWc3V3BOZFZLNlVrQ1lzSGlWMWhyeUpZ?=
 =?utf-8?B?Z2xtUm1SQm8yaWg2K085TlRYV3NNNmh5ZG1pWXRuVjIzREdFdE5lK2krOXRQ?=
 =?utf-8?B?ejZpUmxlR3ErS2Z1NlJRQWhwZ1JpSzArczFjbjlmQjR6ZFlMcDFXcE9wZEZn?=
 =?utf-8?B?MTVnbkZMc1dkOG5tQmVOcG02dWEwTDkxQ2NPUFdUYmtKRkFEWGRQMFU5TWhS?=
 =?utf-8?B?bXZUR00vZVYxbE40RkFJMVlwZkhWdXpOS3I1djRpOGo4T0hobHVXQ1ZSZEFh?=
 =?utf-8?B?RnM3UFpnYUJPWXdzeEJiSGtES0RYTkx5b1lXWXJNYVJRb1R0K1FPdXl0RVd1?=
 =?utf-8?B?Zk11NHNKR2dEMG5XS2ZmRFAzWnMyV1Y0VjF5V2dtWkI1b0xFZnlvcFFIU3p1?=
 =?utf-8?B?WHFQSmxBZHlKN3lMa2tEM2JOaXUwTEtwbnVBbldpYy92ZS9oOStncEhkT3V5?=
 =?utf-8?B?WFlINGFBTklmaHJpVUhtNUZRajNWcmhGU3ZPZnUzYmZGK3JpaS9TaXJIQmNh?=
 =?utf-8?B?d0hmQkF0djBEZzg3dmM2N0Qra1FBZFVMWFpPVjkwdEl4WFNIRGZyVkM5dWZK?=
 =?utf-8?B?WktNWHZhaXlCQU4vUjVycTJoMlUyR0haaUk1N29sZlJFMTQxWU4xa3RGd00r?=
 =?utf-8?B?VlUxUmg1MTlUclhSbWtFSDZOZ2JxRElzZW40clFzSFV5QWlxZ1hxMEdrUVlE?=
 =?utf-8?B?M0RhUFRlNDA5SzRjVWI0TWt5NmNFQUl6NVQ3SU5ManJZTkF4bXdvLzB4cnk3?=
 =?utf-8?B?bWlOU3M2bnpNR01maHFnRXgvU3NVbnlEUEQ0eVJJb1hFbDB4Zm9ZbjVlZXFK?=
 =?utf-8?B?Q3RvVTVITElpdHYxZjdnemQ2TlZWY0creDNhd1FJOUk5dUI1blFSc1RJSjhq?=
 =?utf-8?B?SzdDaVVJaXNwc3lJei9sUEFOcDRCWnlZY1BJcmhPZGw0bHFUMnhmb3B3S1Rk?=
 =?utf-8?B?YTdJSUhadUUvd2FNeUFrcnMzV29EUC9ZSFBLaWlES244b3NZdnRRMmk1Tkln?=
 =?utf-8?B?aFBCMExTRHg2V29ONER3WUpZSG1mQXpOeXFMRDdWN29lb0V3bXpoZW5BZEU2?=
 =?utf-8?B?cGFDaFFsZmExV2NOK0g1ZllIZU96N3M3WjJUU1pBQVpBZ1VRZDU1UGRyMTJO?=
 =?utf-8?B?aE9ZTjFJRTFTVElCczVFdEJ1OWNKWEFnblltaTBpUlEvb25VUTErZ0drV2Zq?=
 =?utf-8?B?Tk8zb09uUmtYd1A2WFkvRjRrUmsveS9KVGpsYkVoMm44bk5IbWFZbjRWdU1j?=
 =?utf-8?B?MG9heFFQTlI0V2dtR1BjQlMva1c3d3pnMWRVTjJnS2lNYlVva3Y3dDNKMXhl?=
 =?utf-8?B?WVVCbUM0UzRJV2U0ZThwWGFPM1N6bm1NMkE1anRZK2pQaC91RmxmQit2dkpj?=
 =?utf-8?B?WHg4d2V0TFB1SXVtRUpMblFmWHduZ0pQK3p6RldBRjh0bEhqVTcxSEU5Tnhx?=
 =?utf-8?B?YnNteTZjanBZeFVLMjVjRnNGcmpneHNxYVNzK0UzcWI0eGExQ2k1MEJieDRU?=
 =?utf-8?B?R1hiZXQwcEI0WWp6eXlEdU44dXpyeFphaTF0bnJhNGZIVEIwU0RoeWVoVkVo?=
 =?utf-8?B?QlZJUVV5V2J0VGZ6bE5FZ0hVeEpDUUlVMlZxaHlrRVdLTEJ0c1FrMC9BdHRU?=
 =?utf-8?B?a1VuNnlhMDdZZnhVOVZkeGMySUFSTDB3enRYaTJ2MkRnbG1LNzVYOEZUNm9u?=
 =?utf-8?B?SjI2SUZ3MjgzQjZvNE5sSEozNFN5bFF0STVacGFQNVZGRUM4aWJDUmZPK1Bw?=
 =?utf-8?B?eUs3VnZLV3ZQTEQydDc2NW5td09LZEgzNjQ0OU9nK0t5RlNaRTc3cU9BVHZj?=
 =?utf-8?B?aEY4ek43SnR6M1NtUGZ5MEQ4aytrMSt6SEVDMXpDY2JWWnV4QWZET2pLdzgr?=
 =?utf-8?B?d1NtRzNZdGErVlBTakV5VTY1NVBRMlo3OEVySFkrdjRRMlFnWnV1L2I0ZXpH?=
 =?utf-8?B?d2NDelhCTEFUUHRrRHRZbG1LNlp6Y2IwVkwxTlBtKzlaM3cwQ2hmaE5Bdlk2?=
 =?utf-8?B?a3pKK1Y0V3phZmFMakxZenFNRlF2eEsrdU5NZnpXUTlLdVVVSWhzNGgxanoz?=
 =?utf-8?B?a2pySkpMbEFKWFpQazVLdHU3cTZvUTZ2eXlJUzVwU1EyWFloVmQvbmd0R1cv?=
 =?utf-8?B?MXpoTGhBTkdoWGp3a08vWjcvd2loUE5Ld2FJaWRTamszQ0FGcHZxNDZkUzI3?=
 =?utf-8?B?VU5WUWViQnJ6Y2VkOWZncWpCYXRlcUJhblgybFdMcW9vbkU5ZzE0QWpaNVpu?=
 =?utf-8?B?M1FlbVEyd1VWa3FWckRreS9JNlBkZlZpb0ZMODFqMWNrbkNGUWZ1dHYzNUZi?=
 =?utf-8?Q?JHN8UX8H6sJW9rg4=3D?=
X-Exchange-RoutingPolicyChecked: v6rHazAxZ7Ho24s5uSyi7bu6KnfL9IAyqUsfc7KJsRaZsTe9HedZawN1Z6lhgoRC7XckhVa8+n20WReRaQWNtHYOlz4B2snOVs8Eagy+n1+gtMSP7iGNuGI3HPrQgcBY0fDCOOntA9d4qPGhwe+mxraiEi0XR9sW7bE8KmU2BBF+55W5q0M1uBYGPU+98G6ynhonKptZ4QaWuvcgSFlos4AlgiEpffXQRGEpwRvne1hVRqkQqI3uZ9NbuvKDauxsfdFLtmqtpO4mo3r7+ygns8DhdHa8TYRskv5DInxOAtlPoaoQToxp9ytqqgJL+yX1ctTOXOl9DYTF/moC8yjPLA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1e60ea-7704-4506-1bbc-08de8ad6cb19
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 01:27:07.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yc2FiRN6znLuBuNRw8Y31PUJ3Qc++8/9Pm1P0ILo0zApUkvxoU6Xewr5kKaA608N56Dsd2kCsA9/nb8BLTe6MSERzdMZ3MLagTYGGusvGnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7149
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
[..]
> > Right, the potential to see in-between states concerns me because TSM
> > uAPIs would have fully enabled the device to wreak havoc, meanwhile
> > dev->trust is still showing the device at some lower level of trust. So
> > I think trust modification needs to be synchronous with privileges
> > granted/revoked.
> 
> If an iommu is present then the device will still be blocked even
> though it is in RUN, I'm not sure this synchronicity is so important.

Oh, maybe we are just quibbling about where the mechanism lives. The
"unblock DMA" step in current preliminary patches is currently behind
the "struct pci_tsm_ops::accept()" op which also handles transitioning
the device to RUN / T=1. It is a bus callback.

However, if the IOMMU layer is enlightened to block/unblock DMA on trust
setting then the TDISP "unblock DMA" step can be factored out of this bus
callback and into the IOMMU trust responder.

So device could enter T=1 way in advance of the "unblock DMA" event.

I assume this would also expect that encrypted MMIO mappings are also
not established while trust is less than "TCB"? That would require some
additional enabling to catch attempts to establish an encrypted mapping
that the hardware is prepared for, but dev->trust is not, all without
needing to modify the driver to worry about this difference. Drivers
would just see ioremap() failure in this case.

A bit more work, but yes, that is a cleaner separation of concerns.
