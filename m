Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F7392C46;
	Fri,  9 Oct 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564607; cv=fail; b=C7un6HY1NAafCCKZK6957lt9k4QxIDdEL5QyrMcMbR5l/WAQFZnw9kZipQ4UtpKjG+icXmuaN59NAeLr3gGfEzqWsik5PArPftNkQrDIZRgi+yDGBvm9QBrfaZDBAHQgm5I3KKEEbyQLI6C+9ajy6DK0Htx3bnM+IwqeayHzCGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564607; c=relaxed/simple;
	bh=g15IqstgtkIxprpknYR/RhxXhd49C69FCQxpXqNA4Hg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lq1LlBfxHxComqGP6xni3IP9KxxU8GHAIxwgfaLZp9o6WnywAO88tIn8pUzgXTO/W1+QEIbK9k0PQSenGusS6N0DEdrPQLe/3lUHte9naH2GfutJ5AFjtxJEj/6OHflF78dMUTdSEPhLe66EQxUGVIFpy7S2ebcSbiy3cean7EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1QIIEeg; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1QIIEeg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791564606; x=1823100606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g15IqstgtkIxprpknYR/RhxXhd49C69FCQxpXqNA4Hg=;
  b=e1QIIEeg58gH9hbJcGNGIJq31gxCqvIz9RUEZR3cR03Hv83s5tBNDX6j
   6x5zy93pzhpfEf86EMtea87Kk0G3xd9mdamsoJnRDruzWw7fezw7tbB8W
   xzi0e7ucpU1uAVSPyzz6grTnUxV9CTevQwYHfuu1bPYvV6XpZ3i2iK54s
   DUrbQdMKvsrnrieTL6VybpihKod2MXeosZg2KTE3nFoZcXThG0ML1HuV1
   JvfGTalMicGCcQmTzFWgWLyLZaxsJwPDhfKCOWTgdEhlMBWTdm5JOz+dD
   1jyd9pir/zVT7f34EgZTDSRaF3l7elQdrADyOp5t16cPHC7MBtwqJ9yvx
   w==;
X-CSE-ConnectionGUID: D/9+CeVOQouwj4n0xLJd+g==
X-CSE-MsgGUID: zpYWtzz9SG6qmDBsurx5nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="268570"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="268570"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 09:50:05 -0700
X-CSE-ConnectionGUID: 486lrmGlT2yfk/TQMJXcGg==
X-CSE-MsgGUID: kgw1Yy4GSmGTGJ5q3Tgo6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="318390"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 09:50:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:50:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 09:50:04 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:50:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttEiobKMTfNfAqO5jRe0rItydAVKN9qsotZHlDbyBHjOoN6p8iUJHBuGJI3txsOmiWsibYT8GhZD/bOpgvXao21Lkwkhya770ecmCUsdr3Y37ndG52zRyLADB+nQosKsMdzzNjmZ5VTaZZ5l6yNeybAY1p913wrM97LhJhZ7MImy/8v81XxR1/qKkgxE+Y5aN5K6JIe98PuDQw1YVYFVu6R0U2zknH3z3twehnic5DCzuV9F7z+3Xgdz7EwYcW28nrc1V/UhMJeym1iwapweb4kuz06UJcG1HYXJ6MBFr4DF6XanniokT/+a1yxSFYWO1OuU+8CWBHfBrjJaPnvZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g15IqstgtkIxprpknYR/RhxXhd49C69FCQxpXqNA4Hg=;
 b=sBVGyAo9YacC7/IIGXJRUchFoaYE+DXlH0dWitGNptlQaqf9egqEkzu9Rl0r0rmR9ebM/1LoaC7g0s5zczZARdE0vNfnWzqJULawrD6Ia6zaFtj/LuRSc0isk8JKKUSsyaZSPPcSEC9NBXoh6LDPmg4GwChs1d64rTnL3v2phJvkRfpOTnEKecIHQCXLju0GNIhftdE5RKyZilZgqNiGh0Vs1RXSVRUmJuMom2j+U+I0JQ30C4pQ7d22b87oynoSROFbyiYB/y7xv1I8KySJ+4TWHqhy8lmgu0DCwXw8mKj+8yenpXF+qtvfFAT0OANHGZzGQ8BZyzD4MfkpCB2RHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22)
 by PH7PR11MB7025.namprd11.prod.outlook.com (2603:10b6:510:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 16:49:58 +0000
Received: from LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9]) by LV2PR11MB6070.namprd11.prod.outlook.com
 ([fe80::4c84:af62:dc60:fd9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 16:49:58 +0000
From: "Popov, Pavel E" <pavel.e.popov@intel.com>
To: Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: Jim Chow <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel
 hosts
Thread-Topic: [PATCH 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel
 hosts
Thread-Index: AQHdWASb0EIL+J0ZIUasS7OKh5t0E7b1aRgAgAAC8VA=
Date: Fri, 9 Oct 2026 16:49:58 +0000
Message-ID: <LV2PR11MB6070C7674957111187A8D68AB2922@LV2PR11MB6070.namprd11.prod.outlook.com>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009154034.82321-2-pavel.e.popov@intel.com>
 <91b08b3e-49dd-434e-a439-b3453c5ec3f3@deltatee.com>
In-Reply-To: <91b08b3e-49dd-434e-a439-b3453c5ec3f3@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6070:EE_|PH7PR11MB7025:EE_
x-ms-office365-filtering-correlation-id: 9e13fa2e-e606-4dd5-9887-08df26255a5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|4143699003|56012099006|11063799006|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: QDmVeoSTbS8qhGPJxQkC40lVpLlQzrs9FytjMoT5YGGfr9lw+PqXk5Nmn0hk8KXOgPPLN/U6gu4qAuFwvroYgIakfK1a6SB0e2MzMAQncgG38/izUYirOx4yTfgc2Z9MdU3M5dHgBclITFOObXu6NSiaaNEKjnkOOY4nTvMc18q758c26DeEgUFUc1G1SggYliiXXveJScFY/SJPuDZ/y1A03RJnA9j37Z/TnRjyhR10yevp2SKTXR8nQnmflBpuVD19JtHXURBpWXuXiZZsnCZ7VyxqGPrDQ/WSNQqVmfck2Qu8JbGSetY3Mrep+zOfEDLN7qBDYi2T/wv2IQzFKIQISCm2Dgz6WdRBevWklp7BhwCZVJy4CLLpeaWnqJFlm9lj7kqqJC2JDzDYa/Pl/mvQ4m5K32hVhgXXAlV8gua1p+nkjzydA+sH4SN64IXHMRp/F50Ea22S2DIgWV4ssjlGX5aRRqgXtEIgzG0uD0upWQfL6XJanT1VEcSUuXpYwbHl1w3rVTPY20Mh9azrWDBJ0bt2SQfWzUZ17YRa43T/Cfx+c6nNHs25/k8SrJDQOq/X6XUvwlz0WVsOe5TwtsVyDw8WAA0FxGZOJC9PAVP05AEhYf6BYBFvy/0kbk7SUN3eJJkjt/J1rncyRsS9Izox/kj0fowfiBB/GwX31m6qEH+f0Dmiu8ecO/YESJjf8mgl56NxUd7T11MoD00I4VAUvQXY/4ruyheEVwVX56c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6070.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFp1UjFvWHpzRkJra1RtRUNLS20wWUxlbXVYYlQ0MzNNaWlsdyt5aTFScFFT?=
 =?utf-8?B?YTlrSzU0VGxydnhxRWpUeS9XalpvNGgrZEo5RytKN3JralhhdGVjaEV0ZVR2?=
 =?utf-8?B?WFB3SVlwQUZNREw5M1hPYUtwMUxUZ1h2S1VkTWtNeTFFUi8vRG5ieHB0c2RI?=
 =?utf-8?B?RlEvdzRHRzJodTFyM3dKTDMrSXZVZTlSU3JKbXF2L0hzRGVGZW96Mmx6Zk5i?=
 =?utf-8?B?L252anpxaVNnQ3Nldkltd1MvL0VjM2FhM1hSMnpySEJnblFZUVNlVmVBMkR3?=
 =?utf-8?B?c1UreldZSFlzS084TTZEbjQyWG1WbENqbkpXMlFMMUVaN1ZyaUQ5QXlYMjBW?=
 =?utf-8?B?MXVrbjRWSWt0UGp4Y0drZFpGQytrRDdZZ05EMVFmRmI0RTV5OGJQVUpNK2c4?=
 =?utf-8?B?T24yNGpKbGc0VWFCRmJFMjRYMVAxM0lTZCtXYXdlRDlvd2FJVG9jY0xTZkM1?=
 =?utf-8?B?RUJXV0liZjIwZDc4UkI4WjVqdWVvQlVPL0VXWHhBc1QwNjlUMkJiY3lKZ1NL?=
 =?utf-8?B?M0IrS3JkRkVuQ09KWjdGbHlkVlpvSVdWaFJxVFMrcWdnTC9ob1o5WUN3VWEw?=
 =?utf-8?B?Z1R6TnZtaHpRa3pLYjYzc0w2R1ZTZ2d5bStqbVg2bDhueXl0VmpLSDB6bUFx?=
 =?utf-8?B?SHNqRHRrWm12RnpoNHJVK3k5dEpqUmdTT2IyVm9aY1RMdm5xa2ZUMVZtZ1c2?=
 =?utf-8?B?ZlIyQnFXSkNLRnNOdmNmQ1hNczBwTXloUnFZblM1clJrcytXZmFjVG01K0NX?=
 =?utf-8?B?VEdPSmY5VEdqUWF3emhmeXJDN1FBQVpwZHVtd0hYVVlIYlRjd2lkT0EyMUI1?=
 =?utf-8?B?OUNLeGJRWXdVR2w2Vmhzdjhmak9aRHc1aDFFWkNZdnFBRFFXbEFKVXY3U09F?=
 =?utf-8?B?YlpNV0cyK0FZMHJhUTIyVmtRcWVFeWUrRU5wd0M4RVYwV0xmZk1JVFdxOVFG?=
 =?utf-8?B?eDNJVEJmd21uclVjWkZMQW5Jck9wSE5yQnlYV0hTYVRKWktHdnhnRGRtRHdX?=
 =?utf-8?B?SlEvMWprUjVvNFFBek5Jd1VTZkJrd1A0T09iMnRLeTBHNm9VNG55b2c3dkwv?=
 =?utf-8?B?QzVaUnZKR2JUdDVsOUxGdXZNendsV0lRemp3dkNHTmVLZjIvcWdiaXh5dUpL?=
 =?utf-8?B?MVJ3QWszQkdnalNvdlQrZHpzcDluR3dpb1Y0TjJrOFhHams4OTFVTy82cmhL?=
 =?utf-8?B?VVFxSnBOUUhPajAxMk1hZXZIcjNncU53Tzg5V2hReXVpZHQ3U0xqQVhPN2x1?=
 =?utf-8?B?THg1VlpiMVFpYko0RkptUzU0ZzVzWnNBRlhVWnBXVWVIemFtaGtzUjZqYjVM?=
 =?utf-8?B?eHlsQy90TTVWUUxUVm15amdGRytlZWhPaUdsTDRkUWZjQk9vRnY3RnQzZ1c2?=
 =?utf-8?B?NWtRWnJZcDZxUy9jL1hTMENYeWFLc2dXWE8wWjA5Y2lwbzF2S3FtSDR3TEdl?=
 =?utf-8?B?VDZQSFBnQ1pJOEttbUtvUFlRTDQ3b1lud3AxdjBJNi9hU0E4NlVTUVZqM3Ew?=
 =?utf-8?B?TGViSi83Vm84MnU3WWVkV3NiUjVOK3c0ZVlCUG5sblY3c1JmbENGeFIwbHRE?=
 =?utf-8?B?Sm42TFpTU0IweG1VQWh2UXpSOGJ4ODI1QWw0a2tyc2dWNTRkUVhiWm5MYVFG?=
 =?utf-8?B?dFlsZ3dOVFJpWDhjbFBxMGFQandiOXBSYS94QXlIWitwYkp3b1pDZCtsM0Zp?=
 =?utf-8?B?L1F1RmV6SjFFdGZjc1JmbFc2aVpDOXhZYUVmY2pCUnRabE9UVlpnbEZlT3pI?=
 =?utf-8?B?QktuODBhenQ4RlR6VFFHMFZGRkFaUjhhU3BuSE9sM3dZSVF6WXZXbGxISnlZ?=
 =?utf-8?B?VDlLUFdsU08vaFQ5d3QwWURMeDk2di8vbGdvbjJjM09wdG5xM3hYMUxRYm5V?=
 =?utf-8?B?dXd5L0JHQXlaeGYyMjAxWnhDWUhuUU4xN1dDTkV1bUVTNnJrcnF4TGtEWEVW?=
 =?utf-8?B?cHpaajM4di96V2Z6eW8xZmVmYkI3YXJ1dDZ4YTVQWnE2Ym4rTUVyR3ZSNHZj?=
 =?utf-8?B?M3RBM0Q2SEphczhLK1NQRkMvbmNEaWdqaTFuREd4NnF5aTdvQ283MDdabGF6?=
 =?utf-8?B?VTRocmF4Si9udk1odFFvRzlVTTBQd0tFeWpCTUpsZ3VCait4aEQyK1M5OFVz?=
 =?utf-8?B?L2I5aGY4dVRNMTlNR04wQXJndmplRFZneG9GS0IwVWFSZ3BQcGJXUEVoRGdm?=
 =?utf-8?B?OUw3dUYyc09vZGdFU05KU2dPTkZpZTFLM0xSSlh4NmdQTFdkNWtkMU1INUEz?=
 =?utf-8?B?NEpzbmp1b3hYVWxxY0d3T0ZaZHI3OWs5ZUFvLyswWk40Rm9PdDR0MTRwYUQ4?=
 =?utf-8?B?Wm4xdVVISFJzVXdzcWl3NmlYQlR5M0pVcEliSk5LeHViMS94ZnNWdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rni5u6AE6Vyj29sQ/Y9MGYREPngJM7P9KUZFHBtkripNLR5/4Ac5lBygPKHONYc65mxXIXKn7a7B6C/xk0p885FUueXFN2NfFun5cYovDWy8vCO4IGX5MJaZxVtlEVX7TUzvCV2ABONyeStZPmBHbdO18nvt4+R7I2Y8IZ40gnFFiia7gQqlN5rYTVfMGPLEpPrU21UP4e8geLrtAqQZPSfOduJKLFSxNmZO7WJ14yTRq9vz70i98G8GEF1OD+ct+ug+7gQTqAl/xwY0UfgJKD0zqrYQZ2G8XTu9NWnmfnsqv/IEzZ2pwS8ShLEqnivt7S2AixNSdUWMZKJm5wgpPQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6070.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e13fa2e-e606-4dd5-9887-08df26255a5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 16:49:58.0903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40ZVRzvb738xqcQo0Iv7qH7JCBA02wFyU2a1OPEVRxLhKZLp8QapHaZyVmICzsHOo/Kb+vskhMfRt1C/4/4nUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7025
X-OriginatorOrg: intel.com

PiBUaGUgY2hhbmdlcyBzZWVtIGZpbmUsIGJ1dCBvbmUgbWlub3Igbml0IGZyb20gbWUuIENhbiB3
ZSBhdm9pZCBwdXR0aW5nDQo+IHRoZSAjaWZkZWZzIGluc2lkZSB0aGUgZnVuY3Rpb24/DQoNClN1
cmUsIHdpbGwgZG8gaW4gdjIuIFRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg==
