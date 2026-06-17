Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9B39DBD4;
	Wed, 17 Jun 2026 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707020; cv=fail; b=q71h2cMMVtCoj1OCclYb1kEHYueqn5g6Lc/zHoV4brE4KT1eeQtQuIP7CrW2KE4wLEBc7bufHUB9KVeXoI4lYAaAoca+/qs2n+Xd1Xgv7kZusUVj/sT2vd8eUUNGWDVHCOBjhlmgLCpRpooMel/sOJCxDvn2yiHBjLQ6Th3oMbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707020; c=relaxed/simple;
	bh=IfTuwQtrvu6DlUY4YX5WWrpwTc5aSXr63e8DcxmjZnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gmRZ1/3eXY8qOdPRlpox+HT67nJmfmfWIhPVlMhAogxiPozUR3g7AGNmzq6UeecJD1VDiPUkCwDvRN1UeqtBMlG1GImcsaVNu6SuShsTSZAR+c1QmiJW0B0fqJBE4+wNORkvg2d1ZQN5JT676JDFuF2dy4xl/RG2qJZL0BjR+w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXTvcfXR; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXTvcfXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781707018; x=1813243018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IfTuwQtrvu6DlUY4YX5WWrpwTc5aSXr63e8DcxmjZnU=;
  b=iXTvcfXRsfBWT5uwbPZ0Q61ZuDZjfEJE5i1tvoPG5Pcz2Dfql1i2X1JS
   vvO0MrczLb2S5hiB+Q9fV+H+vXX9uqPahlS7SIFID6BTNuq8b0AIzLqMc
   Sq9ViJTSCgrYJ1lSspMxEMuJ9+c3DumTFmK1K/g75BjszwiCqhkTsjPg5
   VVwiV9IixTZjfmAthj5FTtyJa7bUgQ7d+e9lyHdNUrZG7mEMu2xoaAvbr
   aQSYG4nxt281vUhGFdkLOxvBlMHp7lWCKz6IKXrnR3Mg0G0JLFeM5wGSa
   60eIZf/xF1UghYDerexfDceHMLYV2Iji+u1zwhIrgbdO3XOWGykd2PUhp
   Q==;
X-CSE-ConnectionGUID: 2zBnXrIcTFSjn2LOwxgxvA==
X-CSE-MsgGUID: o+RypxXjQYeQjg9poL2dHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="99914033"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="99914033"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 07:36:53 -0700
X-CSE-ConnectionGUID: 5ly3y8C5TUSL0jbE2HEHqA==
X-CSE-MsgGUID: z9klPXHPQ2uK/Z/TOheFNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="241728315"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 07:36:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 07:36:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 07:36:52 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 07:36:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zx9jXmYjI1yjCOIdxgj44Yw9s6dUrDrwrO8UhVG0Q1kvilWD6YQbnzRRbYD8V9nRR0U2hFL5sUH9PHD6I2Y/aN/YoRCsSUXyhLLJ61E4G4bsRgr+uJcQELlWpzrA1GUzfgLYmB3cTAdJ4nsJRsXdWTmboXf9ae/aZeJjImJvUzbFNzUhWtwqVm4mnyR+jpcTGR8ONxlTL59TMyt7ewL3AfDQJZwozV3IWiEb3vMqEdym77k61+WMkzTu2YL4ekWVKZxVcxxCUMk0DkymsX3f3kb2GVM1xwIPIWCYYcfzPW2CR5SEzZp0g/gnm9P7WVjTjrcf5LRh1MoHNGEjGjOWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfTuwQtrvu6DlUY4YX5WWrpwTc5aSXr63e8DcxmjZnU=;
 b=jaIbt4AdDZ0xXfTjyxNDkNbAfw494y4n/Rp7LdErD/lM4uSCDxHF6z3ZYKy42MXoTZCb05ILocZpUM/qFCbn/ftuZ33wlLcvKAVUOY6ccUEymemvuTPvJgnUVIjM2dbM6C4ECYCtf2PqWtvniglABmUZ2sopz5uu5lQ+Flb8q0Z3vxgJdDEKs3frUpQ3+obbJm6nGRcUlsRofLZKulSoeFgTpZDFzinWxcAyOhL98+8/OB0Vz2irNB+KTnh+JRKA/Vsa6OP2lKB5lkvMEvV0MpL2awoSZfsglEmpAkGijhJupghSA2lFYh7ZLR9zoDpDKpcyhU4s4svs6mZtrODV8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16)
 by CH3PR11MB7723.namprd11.prod.outlook.com (2603:10b6:610:127::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 14:36:48 +0000
Received: from MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b]) by MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b%7]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 14:36:48 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: Implement PCI reset
 handler
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: Implement PCI reset
 handler
Thread-Index: AQHc/jVtv5IL+H7VikSB39F6YJ4mzLZCc+UAgABZxFA=
Date: Wed, 17 Jun 2026 14:36:48 +0000
Message-ID: <MW4PR11MB6864BC9CA84F060AF7E0248480E42@MW4PR11MB6864.namprd11.prod.outlook.com>
References: <20260617084329.199110-1-sergey.temerkhanov@intel.com>
 <bd5ab9e3-ab93-43ad-a2ce-03d56e2d2ecf@molgen.mpg.de>
In-Reply-To: <bd5ab9e3-ab93-43ad-a2ce-03d56e2d2ecf@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6864:EE_|CH3PR11MB7723:EE_
x-ms-office365-filtering-correlation-id: 5a490179-0a0d-4816-792c-08decc7ddd11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|18002099003|22082099003|56012099006|5023799004|11063799006|4143699003|6133799003;
x-microsoft-antispam-message-info: 0fENVNWK3XASQXZGyMJGWNBvktJmoIknmuRrhUvC9pLwSJU5mjcYBEzydXd+vsgW4o6+n7pEBSBQOTwvWfQs1RVmB9RTE9xhuvcBTAG6sCViWFJ2bsJq7LTpf7dH+nAv7oP7fKDNaE0vOxImOnI1vQOVRFN33YfZ/CWt7/OskcoYPE5NaBzyTParjLHDDK3JQ/DR5RGHx4H1BdQ42C/3EYxy99cVfu5w+BgOIu4Rti2JNkSIPs4b0Vc0VG2zw0/viReztkMCHOab5e8MJ2nh7qFD5WCsOptijdUT/mcvye6mPhBCEuiXJwGmL8kMR2Ay+4g20WI5/aGGzdGt1MJ8Kp17Mp9Ske9zOm3AXGboYNpeJSs11g8f2qcwKTbcU9nKBYXfEihD1udFlnEPXfU9TtZvMZ0gaC1o2RtjrFd66emrjlkKJwiqeqcn2RKSpiJMAu3rzHOJDzsbHYSVllpitTp1C+buT8GNLbDRvmnZWm3RBkRtYuC5pinOwSoNxwMWI6YB1o0y/70yIAhtpYQB/QQ8kPRIYETAZepZSRH7mABxJrarAoAccHiJdLIRiy2KY51d9H6/bGR233kP9H6pZTZsEKlm7dZinBWoIO+Gs+KrB7ZdbfvV0S6oJ38plqZR52Yw3SvCuWEUUQE5PGse1BYZKrBZKJu6nyx2FvLKfvnqqwIB2HMoXPCyNXKs5woJQz5U1SxZgf7OAPGzifcDR6OAr5qyHPYE1mUa41n1czxs7mRS26VuVzRZOzO38Ctx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6864.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTRnVFFDanY2L3AyWFVueFBKNTh2cXEyZGRya2xSQ3lYMGhwN0QrNDhaZ01N?=
 =?utf-8?B?WHU5emdCbkRIaVU5aE1Zb3VVMG1nMGVCQ3JYVWZ4Q0U5WFFtTGNyQ1g5Y1ow?=
 =?utf-8?B?SEpMbENQTVE2T0pUWGJXcW95VGE2N2pNWEh3K2o0Z2hhaDNraFExVERobzdl?=
 =?utf-8?B?ZlRVSjNXRTZoUTBuWk5JREYxSWVFTFBNbXEwS2UwK2l6c2daTk56NXllNTc4?=
 =?utf-8?B?NEw0UGNpYjRQVTE1QjRqcTUyVUJJc3BnOUV0YmE1NHZJTmVZNHBoR2ttSjM5?=
 =?utf-8?B?aFcwL2dMMXRrNFZQUGY2SGkyNkZIcFFRS05wWktQdGVUTy9rWmFuVUR1SkQ4?=
 =?utf-8?B?eDdpeW9wc2RHZEw5WmlOcng4NGpxNGw0dWhib2Z2Q2lmMm1QTmtxRlI0Z1Zl?=
 =?utf-8?B?Vy81bHp5OEc4WmNMTFNUTm1ZM0V6TkVLNDJFZCs2U2I4TW1naVk5TkRjVG9W?=
 =?utf-8?B?clIrOFVuNUNxUDRnSXR6V1pSZ1lLU1hMQnhxd0RFbzRZZ2Z5RFNWSkYrcHB2?=
 =?utf-8?B?VGFLME5Ta3FBZ0ZsS1hEdXVqNjdLVW9oWjJxQlRaVHRXSGp3ZWh3akJHY0M0?=
 =?utf-8?B?QU1uK3NYVDlMR1FQYXBidk1lNHZ5eXQzMVJlVXFzeUxBOGdkYzZpd2wyKysw?=
 =?utf-8?B?ZVRCMlZZQVJFVlRiNVp6bVVuZnAwY2xIcklBdXlWTzE1TDNmWUF6Y1NRYUo2?=
 =?utf-8?B?NTI4RUZ5UFBlMTZBekZaUTg4RVpuV3ZFdWxtYkpKQk1hTndHSlIrSnZuSjFV?=
 =?utf-8?B?bjVaWldseFpSRnh4ejhMckhCdDRsUUxuZ2tNZ0lhL2JKMzRCTUZRYmVGdzd3?=
 =?utf-8?B?RTZxMU5aWUtQYTQ4WEZ4Y2pEaVpwZ0hZYTdOWWlGUXYvVWY2MHdtTm91Unor?=
 =?utf-8?B?Wm9JYmxIS0xtMXc2ajAwRk5Id09ORmNyMU45cFVIUUJBNHE1Vm95U0UxWER0?=
 =?utf-8?B?dFprWXpqQ0hEL0psRTNNYnRtbGRHQ1U2OU5qbWtFaTA5U3h6ZGZTVmJtbFVY?=
 =?utf-8?B?ZU43YzFEcUNCM0xURy9EMXJ6a1pFMG13U1VaSzdnYkVrT0F6dGZPMWdDemMw?=
 =?utf-8?B?aEI3cUtlN1Y4UWVUNUxvY2dmSXhzZ0pGOFcrSU05WXRYZ2N6NTdUc0plK3dv?=
 =?utf-8?B?b1pNYzE5cmtDZzhBK0hnVmUxQm14WjBLNWdCU1Z6cHVRL2NrT3NvQ1ZTRjZQ?=
 =?utf-8?B?Y2hWSy9DRytDd2h3QjRQMHRYMkp1ODVJZkx1QkZheUR3cGZSb1V4RWVtWExY?=
 =?utf-8?B?QzBhaElFdVJNWE4rQXZSTk5xUDZibk0yWHRMQ24reWRTQmZOR3pXWWVjdUdy?=
 =?utf-8?B?R1RqMGxmVFpzOXhwNnpFVE1rQWxLblc1Q3dPZEowdU0wREFwUWZGd3NmcVVQ?=
 =?utf-8?B?alNyV3NYdm9QSFVDb2NhVVU5ODA1cEgvWmhGWGNCMzRWakFoT3ZJQURsV1hv?=
 =?utf-8?B?YWJCMWo2QUgyeEUxaXJlajlrQ0ZiOGZuUWRnalBRKzFuNVg3SkJwZVRpendV?=
 =?utf-8?B?MXFEeURXWnZVM3JBUFRpSXBRVVlMWERNL1o4cDdLRGpSYmlJMi9ad0hSaGRY?=
 =?utf-8?B?Wk1SV2RCSDF0ckFDTmIrV2FqTHcwQ2JEMUFyRmY2Y3g2UDAxcndjYWJFNFlz?=
 =?utf-8?B?YmZJN2hLWVJKK2N2UlpDWjNKbjVQNUFCbXNCckVZWjlFbVNMT0UveGNWK2Ix?=
 =?utf-8?B?RmIrL0phQ1JKOEhNU29LdEZrM21kcFF1ZThaSW9Hemx5REJVY3g2Z2tnT3dk?=
 =?utf-8?B?WmdxMG1DK1JuREwzRkd0cnFoVmZUWW5RVkd2MlY1bFB2TTBJMWFrUEdpbWRG?=
 =?utf-8?B?bDRWUUJVeDVhWmZxU3FjWCt0TTJmSXEwQklNY1B3Qk5xN29sYkdIRCtFeERB?=
 =?utf-8?B?WkNNZENnWUxTajNtdjBvdFFjcFU3UUdnQVk0T0NZTUtsSjZwQkNQU1VENFlC?=
 =?utf-8?B?S0o5bkJKbGlQZ2NSMlhyWkhvTjNXRkRaZG9iTk1VSGl3VG96TE1yYm5RVWxL?=
 =?utf-8?B?NmhmTFh2MngvaHgrZHYrTzBuc05oQnVDQ0JRK3F3UnRKdytNVGMzS0VVenhT?=
 =?utf-8?B?dUFJNks0QkFjZkhvUDRnNGI0NWxFc044anFjWkNxTkxKS3NnMnVzMVB5UFd2?=
 =?utf-8?B?QThrME10UWt0ZDRGTjZnTDJ2Q2E1UHNJY3UvZ2FqamxEczhnS3pBVEN5R0pW?=
 =?utf-8?B?M2tFMytwM1cwZE8wZTVnM0t2eFRFWHZEcC95eHpXa2d4MnhOckVjMHRXVHhS?=
 =?utf-8?B?amk4M01RYXF6akNvbmhOOFJaTVNkR01XNThrUDlCblBGUlN6THY5Q3cvekhj?=
 =?utf-8?B?V3J5Z3hpRTViKy9YVzdlQTgyRE9CMWF0ZGJKM1U0WEpMd3VUTnVPQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aVQ1uMk+0+w6ifJe0yJNkMvpYxKHaOhgWXKpKXzcYH0He9BFM9/EVq3nWkvDWz26IhcSNjqZe7ms7q6EDEykQe1Vnd9dqUaufepKhx6FXorbrCk3ho34M+QN7Z5LioeJSV33eiEqnGQ/tsbT4hqhebcnEWWNqcVDRFqT7GmiyRnVtmiO6qq0tKYF+zIAtOPrWXgX0GIOKX0uKSUkeFkHoPu2jo3ieEPKLryXAETS5rp4O0AxucLJ4kFD4GTQ/G+VAEDYeXMf2ZKHWWmeWzMzqOFrUnoXIb57GljsXc//SbPd0ZMgzUcCcyBJxaNnypxy4S7ICzIfmqcgzJYLP0tNfg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6864.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a490179-0a0d-4816-792c-08decc7ddd11
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 14:36:48.3591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uY893kzMxI37r4UmncNtFkw+gR8dpUeJL3NGuWfIRQHazkPcoHFEeUUD4vPFgKxUGfO76C/c26ceTGyI1Qytn4MQfLGjBUyJ4+73G5u5A+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7723
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNZW56ZWwgPHBt
ZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDE3LCAyMDI2IDEx
OjAzIEFNDQo+IFRvOiBUZW1lcmtoYW5vdiwgU2VyZ2V5IDxzZXJnZXkudGVtZXJraGFub3ZAaW50
ZWwuY29tPg0KPiBDYzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7IExva3Rpb25vdiwNCj4gQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlv
bm92QGludGVsLmNvbT47IEJqb3JuIEhlbGdhYXMNCj4gPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBs
aW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFu
XSBbUEFUQ0ggaXdsLW5leHQgdjFdIGl4Z2JlOiBJbXBsZW1lbnQgUENJIHJlc2V0DQo+IGhhbmRs
ZXINCj4gDQo+IFtDYzogK0FsZWtzYW5kciAoYXMgaW4gUmV2aWV3ZWQtYnk6KSwgK1BDSSBzdWJz
eXN0ZW1dDQo+IA0KPiBEZWFyIFNlcmdleSwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIg
cGF0Y2guDQo+IA0KPiBBbSAxNy4wNi4yNiB1bSAxMDo0MyBzY2hyaWViIFNlcmdleSBUZW1lcmto
YW5vdjoNCj4gPiBJbXBsZW1lbnQgUENJIGRldmljZSByZXNldCBoYW5kbGVyIHRvIGFsbG93IHRo
ZSBuZXR3b3JrIGRldmljZSB0byBnZXQNCj4gPiByZS1pbml0aWFsaXplZCBhbmQgZnVuY3Rpb24g
YWZ0ZXIgYSBQQ0ktbGV2ZWwgcmVzZXQuDQo+IA0KPiBQbGVhc2UgZGVzY3JpYmUgdGhlIHByb2Js
ZW0gaW4gbW9yZSBkZXRhaWwuIFdoZW4gZG9lcyBQQ0ktbGV2ZWwgcmVzZXQgb2NjdXIsDQo+IGFu
ZCB3aGF0IGlzIHRoZSBjdXJyZW50IHByb2JsZW1hdGljIHNpdHVhdGlvbj8NCg0KVGhlIGFjdHVh
bCBzY2VuYXJpbyBpcyB3aGVuIGEgcmVzZXQgaXMgaW52b2tlZCB2aWEgc3lzZnMgZHVyaW5nIHRo
ZSBvcGVyYXRpb24gYW5kIHRoZSBhZGFwdGVyIGlzIG5vdA0KcHJvcGVybHkgcmVzdG9yaW5nIGl0
cyBzdGF0ZSB0aGVyZWFmdGVyIHJlc3VsdGluZyBpbiBhIFRYIHF1ZXVlIHRpbWVvdXQuDQoNCj4g
DQo+IEFsc28sIHdoYXQgaXMgaXhnYmUgc3BlY2lmaWMgY29tcGFyZWQgdG8gYSBnZW5lcmFsIFBD
SWUgaW1wbGVtZW50YXRpb24/DQo+IA0KPiBQbGVhc2Ugc2hhcmUgZGV0YWlscyBob3cgdG8gdGVz
dCBpdCwgYW5kIGhvdyB5b3UgdGVzdGVkIGl0Lg0KDQpUaGUgdGVzdCBpcyBzaW1wbGU6DQotIFJ1
biB0cmFmZmljIG9uIHRoZSBhZGFwdGVyDQotIEluaXRpYXRlIHJlc2V0IHZpYSBzeXNmcw0KLSBP
YnNlcnZlIFRYIHF1ZXVlIFdEVCB0aW1lb3V0IHcvbyB0aGlzIGNoYW5nZQ0KDQo+ID4gKyNkZWZp
bmUgSVhHQkVfUENJRV9SRVNFVF9SRVRSSUVTIDEwMDANCj4gDQo+IFdoeSAxMDAwPyBJc27igJl0
IHRoZXJlIGEgZ2VuZXJpYyBQQ0llIG1hY3JvPyBQbGVhc2UgZXh0ZW5kIHRoZSBjb21taXQNCj4g
bWVzc2FnZS4NCg0KVGhpcyBpcyBnb2luZyB0byBiZSByZXBsYWNlZCBpbiB2Mg0KDQo+ID4gKwlp
ZiAodGVzdF9iaXQoX19JWEdCRV9TRVJWSUNFX0lOSVRFRCwgJmFkYXB0ZXItPnN0YXRlKSkgew0K
PiA+ICsJCXRpbWVyX2RlbGV0ZV9zeW5jKCZhZGFwdGVyLT5zZXJ2aWNlX3RpbWVyKTsNCj4gPiAr
CQkvKiBQcmV2ZW50IHRoZSBzZXJ2aWNlIHRhc2sgZnJvbSBydW5uaW5nIHdoaWxlIHdlJ3JlIHJl
c2V0dGluZy4NCj4gKi8NCj4gDQo+IE9uZSBvZiB0aGUgdHdvIGNvbW1lbnRzIHNlZW1zIHJlZHVu
ZGFudC4NCg0KSSBhbSBjbGFyaWZ5aW5nIHRoaXMgaW4gdjIuIEVzc2VudGlhbGx5LCB0aGUgdGlt
ZXIgY2FsbGJhY2sgbWF5IHF1ZXVlIGEgd29yaywgY2FuY2VsX3dvcmtfc3luYygpDQpjYW5jZWxz
IGFueSBpbnN0YW5jZSB0aGF0IG1heSBoYXZlIGJlZW4gYWxyZWFkeSBwZW5kaW5nLg0KDQo+IA0K
PiA+ICsJCWNhbmNlbF93b3JrX3N5bmMoJmFkYXB0ZXItPnNlcnZpY2VfdGFzayk7DQo+ID4gKwl9
DQo+IHByb2dyZXNzXG4iKTsNCj4gDQo+IEhvdyBjYW4gdGhpcyBoYXBwZW4/IFdoYXQgc2hvdWxk
IHRoZSB1c2VyIHJlYWRpbmcgdGhpcyBlcnJvciBkbz8NCg0KVW5kZXIgdGhlIG5vcm1hbCBjaXJj
dW1zdGFuY2VzIHdlIHNob3VsZCBuZXZlciBnZXQgaGVyZSwgSSBhbSBhZGRpbmcgYSBjb21tZW50
IGluIHYyDQoNCj4gPiAgIHN0YXRpYyBERUZJTkVfU0lNUExFX0RFVl9QTV9PUFMoaXhnYmVfcG1f
b3BzLCBpeGdiZV9zdXNwZW5kLA0KPiA+IGl4Z2JlX3Jlc3VtZSk7DQo+IA0KPiBLaW5kIHJlZ2Fy
ZHMsDQo+IA0KPiBQYXVsDQoNClJlZ2FyZHMsDQpTZXJnZXkNCg==
