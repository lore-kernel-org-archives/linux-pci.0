Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F91A275;
	Thu,  2 Apr 2026 00:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775088348; cv=fail; b=R6iQDn6sg3WI4WTyrnL+viLDxpU5/jA4AKBCnkP2d+NLNf3F9gwcL3JJ/Lslr4Mk4ta0jk4v0vQjtplnjt/d6adPqsYuOKT05OFECfHV2k+kZS0qmvQrKUh5SHfNPFtrUKQ09DwUYkSrmGxLth2MRdbrIH2jX9VGJd46FFqlG5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775088348; c=relaxed/simple;
	bh=89l9M7WYoBXdyVbdxoR/g2VU5SHCPA44ifW895+5Ph8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uIsoaQ2EXbyMCQk80OKDAZYXaOz1SBcWmCjDkhPBOUMB5eFbLrDIBl/ufztS2o99P2BSfvLT9kbZvyBP2v8jO+jzj6prcUSaIK8bV9/JDlaA3VwfMY+JY+3OUrxoOZ+1WYVr7oPmFVh2+ABo1CgwiW5urKbM/5S+MZ1klLVxZ3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DStlNtFZ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DStlNtFZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775088348; x=1806624348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=89l9M7WYoBXdyVbdxoR/g2VU5SHCPA44ifW895+5Ph8=;
  b=DStlNtFZ5O64YcWFOWhbUo2hDyvXvdy7vjevHMp3qqPjgc+VORzVoSia
   3SWzkI3abaQydLFpuP2WWokJKCo4MxdvnK7xzjP8KaVq2ukZe+vILay37
   00+r4Yw1tVpArUcimAk1Ik9OwEqswVqU8xufJe/OIxhES5sQ9TxSMjMXx
   8kQ/nmdbZ93Yoq4rC3UpgIGl1QLYYnIhK4M3ftL1s67l7Ps0WXJeDMRWs
   dzIHcd1PgvQNg6orDtwEROHft+Y5u5M1uVXbTuNH+00XmfjMxcYtGMQ9e
   loDqz5IrpjsJ+GLjxU2WlXgf1C4xk3W+Z3YMcHvuILc48m9vXyUamGMNV
   w==;
X-CSE-ConnectionGUID: N3dUdHdGS/WY8Pz5O8JLhw==
X-CSE-MsgGUID: uf5WHGWwQdGEqVOyXYxCfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="79750375"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="79750375"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 17:05:47 -0700
X-CSE-ConnectionGUID: g5rrldYSTsWZcPYMMIemOA==
X-CSE-MsgGUID: DBxTKi1zRUCpSgCmpXj+Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="220171188"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 17:05:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 17:05:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 17:05:46 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 17:05:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8/fxWjK6fWgqdfLRYUTWLIGB3479ftT5QqAfvoKsMud+2cN7eGZw5wHj9XqG0a7SDheK0ZoYHRInKdx+jJbMQTXWhLho0NpuMDB+YpUNGXaAhMomH1xcaGlD545/RcJ50Yd6KuOmQtZfQuAyCs1kOM+5ldL4SdwyUPqIiylhgxG1FSs4mpam9OZpWwKzZ+NuM01wjqv2+RsYR6Gmhq2EAnsaV72qVM1B26cimZIMPIpfyB9iOSI7pBvQCgU2lBmp7c1nhQ3jylWE+ldEJEK1pRRClJ3sl7wvM5QT9JlpBkFwqo9zGndgsJcMwGvcXCDgmheOHH6iQTwMYiFL6d70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89l9M7WYoBXdyVbdxoR/g2VU5SHCPA44ifW895+5Ph8=;
 b=g6sQDkB4omQsn4qfXMGrHYMEFQwl+TMu22b5VOIgllx8Th1lQs5fw0Y4shd2Vs44n3LwyVCeGb3BqG4dEBYhhWXYhfsGySVMylONy96+e7TZUjTA8xdQFTBwE4kzgCYckFAYIhu2iMPT5lDdGmTs/xEBATGOZFly6GLU0stA9QNnucWPtJDS7hE0QpUDzUgxIdE0y172M8vLPmBTHrnvwMYn7RV31PQJ48dcuKwO2qzZhEA5PpL7sToWWg5WJJe40fV6FKjZLQilBmqz1x6C1XyL8CEaBDW8EN1wG/tPNd2AMM+z6Qoh5h/tAFDlU0cvhCRODVmJQgmwgDhJfpe6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 IA0PR11MB7353.namprd11.prod.outlook.com (2603:10b6:208:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 00:05:43 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Thu, 2 Apr 2026
 00:05:43 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/31] x86/virt/tdx: Extend tdx_page_array to support
 IOMMU_MT
Thread-Topic: [PATCH v2 05/31] x86/virt/tdx: Extend tdx_page_array to support
 IOMMU_MT
Thread-Index: AQHcvgcoMUYcVIHmNUGxBq+EJ9WZqLXK7NGA
Date: Thu, 2 Apr 2026 00:05:43 +0000
Message-ID: <e290bd999c5cec93bf0b611f5506ba1e8a23c81e.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-6-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-6-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|IA0PR11MB7353:EE_
x-ms-office365-filtering-correlation-id: 280f400d-4b6e-4d6c-05a4-08de904b9575
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: zX0d6AiJIOj8WF1b77kwZQGWduVymXJl0UfW84G+LfSP8zO/NiATps51QU8qrgakR/Tf1twSy7i9Nv5Em41ZSBBn1QeQP/9PNdsmmwkAzfEsXB27q7yPOKKSbfqP7rQoxR+kTADEMZFUAaqVNSskIchOlnvqVXnWTgJonJNbhhdshuszmrh0RnNgLe0OL6qQrhd6/In8GhVAMqM0u1ML28haj9LTxdv8hUxhnBy5w1+KsAM3qIA25epHpB2gdfyWPGBf5mJ1cHUBaMnZF35efvWgXCPXJFGz1RB4aFzOTA+vK4u8qb2bBt49CUSrHgUUeESWts17xaiaJpALpdp5I4iBhasRONeROSMyfRTi/DqBsL722cOMLl4jzT2KE05S0f2WjDiDRzshNYdwwL5Qul0UEM0tioR0Mubgf6TUsLqf69cvPL6JuAV1MaEHHzLfwB3iu1AAAV7Jk9H/XwWP7QWGldSOicVXEYXrCOctM/SJLac6EiFEcLb8dxjodhvMXIg0iSneZp+UPOrZeXj7jOXveRu45iPY/iZ3HpzYi5LVnqr1rmgLPqL4v4dEdEy65a1m59lMQgd4pB002xNdNnEw15IebGzg3p6hdojQ0AC9wcjlsVCzGNWMKCzKK7otwnqRS1HMZmOEK2bysZaHW9bzDcROfa9fOn6E4gxbpvKuC1SlKeaRg1zucSLj7e7OlBD8B+WWRHxBEGR1X8iNZjLH4ihj6NtV9RWoCNU/ntQ32zVmGQ0P74GLBjiAJn8naDJ87yMCwTWjGA+0DiB6DKGYkGJvC+byvWPqs7FoyGs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3FkWHZwekNjNWxIZkZpc3UraENaaUphS2V5MVNMdmxMSU9KeVZXMldiTitu?=
 =?utf-8?B?NGNFLzF4Wis1M3lnNFNJc1hEbkJkTmJkc0dXMDNySjZKYjFmT2J5cisxSmQz?=
 =?utf-8?B?K29yL2lOY3ZlTUxwREZWNjU2T09td2ZmbFhKZUVHUERrVzY4bXUvQjg0MXlJ?=
 =?utf-8?B?MUJXY0tyOVZoTjZaTzArbEpCT0FzdGZFelAzSk9RZmpNQXkwYTNhZDRONlhN?=
 =?utf-8?B?dGNadkNmcHZuUkJ4ODNuN0MzOU1GaFRKYk56bTRsUUYzMXhKcUYvZkJZK0Yy?=
 =?utf-8?B?MGtzM1ZlYWpXN3c5ay9ib3ZMbzU1ZmdoUmxBUkRxd0tpK1dVTjJaUkR3bUIy?=
 =?utf-8?B?bHZDVEEzdkZhdDk2SEw3UWluQkUrajlsNlhjdjlRejlsd2pSZ2NKSThEM1Z6?=
 =?utf-8?B?elM1Z1lZd2pLUDBkVVRXYlpnejVOZUVCcTdmajVRbTd0emk2ZTJxZmx2dnZv?=
 =?utf-8?B?aHZzMnJWSnRlaEFzV3JZQlQ0Z0VCTTl5OWxIMVFjcWhOYS9CckhSRy9rVDJl?=
 =?utf-8?B?VmI1Ym10dEFINitVQVJwN3lHZXJCRm9oaUtucSswQzFUeEdhQVZaR0NYMDVN?=
 =?utf-8?B?TVo4YS9JYUJyMHVodHFuVm5uZ0RPZ2NWVFMwcllmNDZNZ1QwRU9relJYaUFU?=
 =?utf-8?B?NjNVYkFMUFNtaGxpMndQVC9Ha20vcG1UVkpvVll4ZXFNcVFtUVNlS1daRjdP?=
 =?utf-8?B?WEVpR2ZKbHJyUHhMS1grY1AxQzFrMWxuWVBDZ29YZnVyS2sxUFJtK2s3d1Nu?=
 =?utf-8?B?Tis5cUZjeG5CVUcxVVlmQjVmS0UrTHRvQ2dVcmRHR2pPeVRFWmpBanZUWnZE?=
 =?utf-8?B?UmFHQVp0ck9WS2ZadWd3UHZlZy9Mc3UwUWtFQW9tNUhkVWFhMjhtNlZKSEd4?=
 =?utf-8?B?aE1ia0MwVkExMW5GVU5VaTZoUHlNR2xhcUJUSFZJZVRENWNsOTlrT1JYYStv?=
 =?utf-8?B?Mi9SY1RkZ25xRnVPNHFiUHFPNERVUkoxUWpicWYxTmZ1YmhNWElpN1BVZkdU?=
 =?utf-8?B?RXZVY0FzUE5FUXdxVytJa1dxMkpEN0VTdG1FYmwxYlJIaVFmbHdPY3ZPN0pF?=
 =?utf-8?B?UCtZRUEvbWZkdUgvWnJlTDNEWEpDTktQZEZ0REZCcWpjSk93TTg0WHhxc3RB?=
 =?utf-8?B?ZHFzQ0xyT1d3WldpSE43U2hlNnBqSFBQeVdObUxtYnhQV1Y0ZTVrVW9ieVFz?=
 =?utf-8?B?ZzdrN2hUemlMNlg5d3MrU0tGelJQVFlMTDIyR0JVWGJ2UStaS0tCWjZoUUdk?=
 =?utf-8?B?NXovY0tXTU8xbURyYitENndDTTdQVTZCaXZPYnpYNklPN3hRM2dROWdPaTZy?=
 =?utf-8?B?WnhsMTZ6bEhlNmVtTERMNXk1Z1llQyt3SldzNUMxUWlIdUYyekFUYzM3ZWRs?=
 =?utf-8?B?ZkV6SElqQzJ1bnEvY2x4cE02ODZvTDlpWUhPMVJNbllYRUhYVnlGeEgzRHRh?=
 =?utf-8?B?Y2dFV1QyRDNMeUdjcE9HQkgrSW5KMlBmUzJGSXZ5UzNzOE44SE9IUUdHcThx?=
 =?utf-8?B?S1lORG1SRzhFaHJxMXpTZDdFRW8zQm9GcXhXcGUzRHpWMzgzb05nV1p4Y0FQ?=
 =?utf-8?B?RkhhVlF4NUk0MmxlS3piSndFYTZQNEZkRFN0NmtqekdTZnJlbWJDaUViSDNE?=
 =?utf-8?B?czN0VVNCTmNSYmFkTFU1a254c01NRTFYVFJkNGRYSU5iU1RPbFI4cTJBZGx4?=
 =?utf-8?B?QkhkVklZRmNTdUx3S0tvZ1pFL2FicGhXaDFmYk8zSTJuNzhSU2Z2bTRMVUow?=
 =?utf-8?B?bVIxa0xGc3ZQUFJXb3Fwekd0a0Z2V0dYNi9mWnFtRU9xMGt1VW1SRVk4RGZo?=
 =?utf-8?B?QmMyNVFwaGkxMDNtMHZvSkg0YjVyOVZMNkdrMW5JTlQ4SEppVzhrekI4SjBI?=
 =?utf-8?B?MUsrZWhkWUQ0S0hDQ0FMTUVrVkk5SFZGeEhXL3Uwblp6QTJya1R1ZXlVN2x4?=
 =?utf-8?B?OThpdEIrclNJNnZydlpsUXpIczQrTEtjcFZzbmV1LzYzdFhzM2NpNERZTHBn?=
 =?utf-8?B?bU1XYVdBOEpFVkFFSFNJd0tZWXhiQm1RK1hKdFpNeUh6ME5GZVBvQ3ltRndv?=
 =?utf-8?B?ZUJKYnBHL3hvMmNvVWZPSW1VSDV6Q1RPZ05yaGRNZ04zZGRlTlpONy9EZ0Nt?=
 =?utf-8?B?QS90OHVPdGZPZTl4V29HSTJVbzV1UlJEV2RVWjVKc2ZVTW15OFprMFBRbWF1?=
 =?utf-8?B?aGJnRU1YbkZLM2pxY1pSeFFoRXZyckhVTlNIVWNnUmR0Tm5pTEFob05lMkVS?=
 =?utf-8?B?QjBUdDNETGVZOG0zM2ROemtPd2MwVk1sdURMbmFlbXlZVmdGU2QrT1J1RkpB?=
 =?utf-8?B?QmJsR0NjNEtRdmxyMW5XbzBLMkVWZVEzMGM1YWNna1haRVNXTEVVZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0B557055494E84D81BF6E843CAD5CC2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l1DugRb+Jn2hhMSbUXOO4b8lRqGHzh3jMVICaC2kBKzHSjHtG9xkfYhkd3GWp9pT6Cr2YQz73m8+6Q9PcYryZOeq5os18NKLuq/KY9fMywzocVALFkDewa32RJmB6LwT+pwtDRP5A/hmIlHAbtjdPDNoD/m4VU3NY+zWfJ69u0K1C2S5dkBD4vCRLFh8RuTCPBt7tb++oua2zisry8rg7AYQNkT36fYYJ8Uk9o/hgh6mJKid9QUnHvByfFhMoGnKGNYg9LKEgbm7ND/0vsjM5GRL9WTZLK0MZzjglFt0GpDM84hv+0jNnx4aoJrBsQF1cp2ZSr33win5hr0w1LWVjg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280f400d-4b6e-4d6c-05a4-08de904b9575
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 00:05:43.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNsfXK1TeQQwon8lDk1hSXKi+/zULlo22miquJW0u+x/IatEFCGGQiCZX5oFtkh3oypm6hIxOTWn6AggA1TQKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7353
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTAzLTI4IGF0IDAwOjAxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gSU9N
TVVfTVQgaXMgYW5vdGhlciBURFggTW9kdWxlIGRlZmluZWQgc3RydWN0dXJlIHNpbWlsYXIgdG8g
SFBBX0FSUkFZX1QNCj4gYW5kIEhQQV9MSVNUX0lORk8uIFRoZSBkaWZmZXJlbmNlIGlzIGl0IHJl
cXVpcmVzIG11bHRpLW9yZGVyIGNvbnRpZ3VvdXMNCj4gcGFnZXMgZm9yIHNvbWUgZW50cmllcy4g
SXQgYWRkcyBhbiBhZGRpdGlvbmFsIE5VTV9QQUdFUyBmaWVsZCBmb3IgZXZlcnkNCj4gbXVsdGkt
b3JkZXIgcGFnZSBlbnRyeS4NCj4gDQo+IEFkZCBhIGRlZGljYXRlZCBhbGxvY2F0aW9uIGhlbHBl
ciBmb3IgSU9NTVVfTVQuIEZvcnR1bmF0ZWx5IHB1dF9wYWdlKCkNCj4gd29ya3Mgd2VsbCBmb3Ig
Ym90aCBzaW5nbGUgcGFnZXMgYW5kIG11bHRpLW9yZGVyIGZvbGlvcywgc2ltcGxpZnlpbmcgdGhl
DQo+IGNsZWFudXAgbG9naWMgZm9yIGFsbCBhbGxvY2F0aW9uIG1ldGhvZHMuDQoNCldlbGwgSSBn
dWVzcyB5b3UgY2FuIGhhdmUgYSAnZnJlZV9mbicgdG8gZnJlZSB0aGUgcGFnZXMgeW91IGFsbG9j
YXRlZCB2aWENCidhbGxvY19mbic/ICBXaWxsIHRoaXMgc2ltcGxpZnkgdGhlIGNvZGUgYW5kIGF0
IGxlYXN0IGtlZXAgdGR4X3BhZ2VfYXJyYXkNCmltcGxlbWVudGF0aW9uIGNsZWFuZXI/DQoNCkl0
J3Mgc3RyYW5nZSB0aGF0IHlvdSBvbmx5IGhhdmUgYSAnYWxsb2NfZm4nIGJ1dCBkb2Vzbid0IGhh
dmUgYSAnZnJlZV9mbicNCmFueXdheS4NCg==
