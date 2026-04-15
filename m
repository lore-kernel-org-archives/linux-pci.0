Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A66F391E5C;
	Wed, 15 Apr 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243205; cv=fail; b=baESiIbd/L9Ewd8L+VH/WISogrK/VDLCa71rJXgjBtnm3um4xmWXufxSHJDGkGM3DFgHkq0jCJsOqR14PqmUfGZ7i9KvEzF/7GppCW2y6y6HfT69yItD0q1wPgsc6egQIpycQV81GoRV2L51fiW2z8gwVgXzGrLfqzO+C4m6BRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243205; c=relaxed/simple;
	bh=VHYKvxI/mkY2TA56KZa8EwFQKhmnZPn1DWOtaKxVp+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N+m8k7GRahcCpLu2SmZl2HYQpuEOpyCSIgNh/PntzLYqlTGWxEZsyYacQry3hB8Z9u6WnqsFZ9ty95BJ9YEkJ1sH/7eQ+jIVVVLnAP9xVww4/Ex7wQUDWiWo+WIWQ3IcGBw2WomyOq4Bi2ESzTjQyXKZznt88hr9Mbnh2Ch3AbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNFo26ya; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNFo26ya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776243203; x=1807779203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VHYKvxI/mkY2TA56KZa8EwFQKhmnZPn1DWOtaKxVp+0=;
  b=lNFo26yauboxEYZQpTCaoXXf8aQBEqXVCQ8akvEdfQUuzgh6wVDk1vav
   PWhN1M7yYNhanjncLpAg1oM0N/H6ZKgn+3/UQYm/cPxLv3VjMnFHYr4dh
   JHIWiUd2HCv1E0tAH7TTmN0XF9ljkD3xKiRUEfxd9wjGgX2Hxj5xeOcE8
   YxPTa6U0zHstIAr68cAEkl/JvabedQlNKIe6MRP628iUuvvxEyi3RJ/XQ
   hVlSuOSdcWXHONM0rLZf4LBv/npvGROOdD7QfrTFLb9x4YVqe5PG1iEVT
   lYIbgQvh9R1u7JCjs73NAug3dHCAI8XqcJuAn/xrEWS9vmQaRsFadBe92
   g==;
X-CSE-ConnectionGUID: gs6xLB7+Qh+SMRKtnnIPaA==
X-CSE-MsgGUID: l7uP0R4QQMObuWzJVq+KKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="94785212"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="94785212"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 01:53:22 -0700
X-CSE-ConnectionGUID: ocYksTlwR76+Xqk6Ex30/g==
X-CSE-MsgGUID: ABaZNoKKSnWnrj0SlYVTzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230583252"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 01:53:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 01:53:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 01:53:21 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 01:53:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeLGJkrT8SUyaOCe1fa1Wr+M/CTTevfsHBtY8i5fv9F+1F0ZNZd/AFXwAF55PAerjFOhLC0GSEzviGEfYtMEBu8jAB12qo9G53FwDVudYl6I3o4f2WV50nqCv9Dhsxw8ZDsEW1aBUxNNspBaU5tJpaclF+d20WZO/Fs5O4xdgmuNFqhN8AjQ+CLZbyICZEtWcQo8q3j63onvKglk453jTf/ULaQ6hWrlXgBPJi1jEv6Q+qFvFVtDkG+i9S8mR1YAkW6kE4FUlluTUTbscMASVFqzL09cTsilbFupcqVixbVtm7w2hsSH9ddQ0c3fB6LcszNaxQricVrjVjyRFz91uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHYKvxI/mkY2TA56KZa8EwFQKhmnZPn1DWOtaKxVp+0=;
 b=mdCokVmzJiEFq3klHfiL1TGTX0KHicGTdt4nyjfx9+5c6WL+cbkBylbIiAuRXi5uM9+Lh9yABU07vP9d+GGGsrsa2W0qQAA8hpvTYjlZQ1kNM9QzSbz5UmmIDHqWDTdHdrMiGdAOIV7REWbqYtYEIzdbivw1ptY43nD6tUyOV2dlUQKvaHaGgy2OHXK+G2OD2+CPqWMXof3vPZ8QcwWVboOnuPe6xg8QPt+yGbgANtbR9Xhsn+ITcxDi40IUkDlwg7yy+uUmAkuQB74deTUlMvcrvOWfYQmAohtXc78O5LUZCsSRHeWxAiz0pDJGvJmY6VoVnPCoGUbktlTQ3lm5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 (2603:10b6:518:1::d32) by DM3PPFEF920636F.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f5d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Wed, 15 Apr
 2026 08:53:17 +0000
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::6512:7c98:831d:3b0d]) by PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::6512:7c98:831d:3b0d%8]) with mapi id 15.20.9745.044; Wed, 15 Apr 2026
 08:53:17 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Bhat, Jay" <jay.bhat@intel.com>, "Barrera,
 Ivan D" <ivan.d.barrera@intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, "decot@google.com" <decot@google.com>,
	"willemb@google.com" <willemb@google.com>, "sheenamo@google.com"
	<sheenamo@google.com>, "lukas@wunner.de" <lukas@wunner.de>
Subject: RE: [PATCH iwl-next v2 2/2] idpf: implement pci error handlers
Thread-Topic: [PATCH iwl-next v2 2/2] idpf: implement pci error handlers
Thread-Index: AQHcy70clylJ6BBLYkyAicYeVjavabXeZlxggABBMQCAAStAcA==
Date: Wed, 15 Apr 2026 08:53:17 +0000
Message-ID: <PH3PPF7A88A980AAF619A7C8EAC3550269BE5222@PH3PPF7A88A980A.namprd11.prod.outlook.com>
References: <20260414031631.2107-1-emil.s.tantilov@intel.com>
 <20260414031631.2107-3-emil.s.tantilov@intel.com>
 <IA3PR11MB8986C6EC840268F14C44B28CE5252@IA3PR11MB8986.namprd11.prod.outlook.com>
 <eb07b21f-0133-40c3-ae86-338572e2a64a@intel.com>
In-Reply-To: <eb07b21f-0133-40c3-ae86-338572e2a64a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF7A88A980A:EE_|DM3PPFEF920636F:EE_
x-ms-office365-filtering-correlation-id: 7500d222-4f85-4392-7165-08de9acc7007
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003|18096099003;
x-microsoft-antispam-message-info: TEHKyQahGg5zM40y9AM6KQivZqB8MjbsTlBHiTrp5Ih/TfdoHLNb6u827yzSscSsr6MVOOVKlJTsmuL6jPOLbq2mG2ViRvDhDQp5vd3AHZPyjCG0TBzU63cAAXxseLd040qOwP1NIaxyqlb1pTuUivfwMLTkMr9JhyceOUL/ZeWsyHK0HN2dGgeroIQNMDuJEf4Pmbki+rJL/+uAI9sYRJAGQ8t8oN07rcM94yBhz+uRvnacehti3MOK+Lr51jpwYbqxn5FwvxJwuRgHxR79CS5B01ej5n7RcolBgdjS6EHxiTQJro8w1Lo1A57XH+wkgFYyWxI6zGY7KVtwy3ItLIlfD/Qj9Hs4ZGQNlezQowYOrdlhgCqDmlDB/MHPYYQXV4vEOcOxM0qpkSPUZec3v+b8ZxKdz3qKRabVLORe85pLnXlgfzcGmuebBI6ZzZtLUvWFIthbdKsFeYw6aDiOijecoy6sYHVB3HCChH1MyXmIRPr/ele96FHY+dnJlBjmGheQHH7cCoX7W3puvVPGuz293QA4DIGyvMNAeLCkwse/5qE9DDIoDYa/I3HKPjT+sUh8uSElqqquT8qhfIHc6cVeZKzWHgRddux6fWDrw6//EoSo6qU+cXRcWq72vL7c32eSWO+VHSBLeDX+7hIpIa4TkUuIVfqIJlWZ/NU65NL83+EP6H6vYA5qK62uu47eMN67CdnkJtiejJ+/EqCWvUZk9DliFNSpiAvLPbIPgJBRiXDnoTqt6nJYifJ/NcLzaMBZR/KsKj2ta6tacqpH5kK2rtRPeKMGF8II2C6a5IY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF7A88A980A.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003)(18096099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHBZbXdXZGM1bHNycVNvN01RTXdGbllrV0s0QWZDTzZVWllCRWlJZTgrZzc3?=
 =?utf-8?B?M3ZhcXhWWDNMR01nd0xaeGgzTGFKdm5PVFpYSEcyT2tDRXMydmYrcVVDWFdV?=
 =?utf-8?B?TFVhWUZ1UStXczVSNkFYVE00MnNMZEJjN3lyOEdHYmErS3JaTTBGeWVxUWc5?=
 =?utf-8?B?UkJITXpaWDZTemp3U1hBZUVDdGxXQVBGTUlZK1ZzVnFQZnIzOHEvWGJPUjdF?=
 =?utf-8?B?Y3FTTHMxbVAzOEM2eFd0eWh2VzZscjR2SUxnY0tpa3pKbnE5YTJBcmwyUGFv?=
 =?utf-8?B?Ry91ZHdGeHpQZS80VkFMWkhkTVJSMGZjN3ZWYkZvNHBWelpzR2U2UXFKV3Zt?=
 =?utf-8?B?MU8wcFM2cGVTODFkNFVOVlNOVmhxL2lkbzViSC9FZ0RUYXVFc3llNnJGRE1T?=
 =?utf-8?B?SHpaYUpGbkxkNG5vUVY2T2pMTC9zNmRyM2ZBdjVOdHA4cWF6bWF2MmthcnJZ?=
 =?utf-8?B?clVLVUZ0VlVJS0RjdFRaV2ZpcDZzWjNJTXRaUTdXQ1dsVXc1cnlrb2txQUFo?=
 =?utf-8?B?WkFQc3J0M042MXljeVBDdXIxR090b0JzOERYU1VWVkpQdzBhYldIQ25EOTJz?=
 =?utf-8?B?NVRoNEdEYW44MC8yKzRFYStLN1E3YWJBbWkxbXRQY3c5aFlFVjNSZS9yOWRF?=
 =?utf-8?B?QkZsYzZ3VW9Gc29KQnlqLzhZc29IRDNPUjNjUXhhSDMvZmtuWE1aSWNOaDJl?=
 =?utf-8?B?MHNyN1FaZFN6dzRwcGdTRUF3L1dtVTJvSVY3TkozNUt0bWwrSmRsSmFQdHRO?=
 =?utf-8?B?c2FUclVsUzVOVUZTWkZJekJZeHI2M2s1cTVIZEdxQ0s0NTBPMGU0aVFhTVpG?=
 =?utf-8?B?aVVHVld4RnFsZWVyNUJzRTFoRlIrc05xcUNuNGdVbjRLQlVmMHlNM1RtdVk1?=
 =?utf-8?B?YXNXVFZkMkFNUEZDMWpXYTVSM3U3VG5iNk9SSEFXWXdOZ2lvbzBHcFl5aXU3?=
 =?utf-8?B?WlBiYlh3alJIYjdEQ1QwS3V4TXV5K0NrN2h3ZlpBbzNUR3dLdWRPRWtKc0pU?=
 =?utf-8?B?TDVRbXlQWEdMdnpCdUhvV3RmSDdKdGVIZ3MzUGZINFdqRk40anNxb2dZbytK?=
 =?utf-8?B?a1VGaTRvTTQ3bm81TlM4TXNGYlVpSTNpeVJrOEgvV3hlRTV3ZWVaQ2dOSTRW?=
 =?utf-8?B?R25mZzFzY2FJdURWbCs3VHJGUHZCZEk1dmxyeVMvVmdQZEhPK0V4MDZ3UjRS?=
 =?utf-8?B?SmxNcElhRVowaW80dFczRXhkRHU2VndTcDlDcFpIY2EvVlFnc0tpZUk4VkFF?=
 =?utf-8?B?YTl2T3lqZnJwWVZXWUp1WmxCUlhTczZLaUQybnNRWnVNOXhEWDRQZGZyS2tO?=
 =?utf-8?B?SFBhSTlWSjlBb3hqdHNVZk0zakRud25XbU56WEk0VE00dnJaRndKL3U4S2tu?=
 =?utf-8?B?dFp2NjlmMEpxR1NmcW9tSnBIS012M2laRzduQ3QvT2lnNEhicDFkbmRzdEVp?=
 =?utf-8?B?UlFYbmRzTkRORE90ZTZXZmgzcXRKRTJXaGRKL3orQVRFNkUrWCtnN2ZrRVVS?=
 =?utf-8?B?WGVWWU8zN2NMblJuZHcrOGk2VnU3RVFwTEhyQ1dLTGdTSk5KcWpKOGpvK1Q4?=
 =?utf-8?B?Ny9lL2pvc0s1cldoazh2SlVlVTVjcllJNDBvMEQ0UWw0UXJ2RGxvUFU3TzVw?=
 =?utf-8?B?R3dHVEZLQ2dkdUlaS2FVc25ocjFKMEtpVG9BNEFnZmhQYzRuREppdTlRWmRG?=
 =?utf-8?B?NHVLQlVxQStmSzlhMWhpemFwcGs2T2h6cmk2SVdWSGxSUmpGelhSUFhuTHUr?=
 =?utf-8?B?V3pueGZRckJBV0ZPRGgyL2xwZ2txVUFMVXJmbW4zOE84SlBlQXRqOWhWcktS?=
 =?utf-8?B?MEtyd05DMFFwRUxRd3l4Zk9NaUNWNWtyd2FKK1IvbEtoRTJ4RXhMNnM4eTZD?=
 =?utf-8?B?eWJYaWhlZG5kckYzTVNJZThiY1BscSsxdUZTV0hYaENtdHRvcC8vVUhRQm0y?=
 =?utf-8?B?WXBNYXdDanlOTUxnbTRkZ3llc1BndCtCSVhGQnZJR3l0ai9jaXJORTdCeXUy?=
 =?utf-8?B?S0dQY1VISkJSVlN6S25sM0pDTUFOUVNVK2ZxbE1nUE5qRFpYdmhkRHRzUDJ6?=
 =?utf-8?B?RlJnZVF4QlIzOGxrK0szemNlTHRHTEpINzFtenRSUkVhQ24zQTczVUtDNDA1?=
 =?utf-8?B?NXRnRFZ3dnNKSVAzTHdtbWk5NUdEQWtOLzVuS0Q1NlZUOEhBNXpWR3NRV1Er?=
 =?utf-8?B?eFBJekxKSjJZSjFmaS92Tnk1eUM2eWZSR2FCUE4rSjFyYlFaZ0VRUU1Jd0I5?=
 =?utf-8?B?RWQxeHRoaWdMLy83Smx1d3RRS1BPckZHVm9hd1o0Q05razBIeUV2ZEJHOEZX?=
 =?utf-8?B?YjBydFR0TVdXVGZCeE5uOFgrakxwcU5ZUXhEVWlaM2VEdlhqYWQzOGN5bkpH?=
 =?utf-8?Q?08VoIJEAaujWjCww=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EqdhrMhlpO+QUX9dO3ala5ir2zpSSSBq7leqsUKge+Gv04QvRiSgYdu5Bjo1nK+pqI9d2X7ZnA/h5vuqjf0bJul3C4Y+vHz2TL1+Sei6OudoshDH+YkqzdzCRJCPUcj5gXs6GLFepNYN5X3lCtCYV606fcv91Odd6gWDPSq5WlGeWTtmjzElo/lMBHNAimlnXloEp59Z4FRWW14fHR2YiwfhvXVodC/oBoCaqshAmgdwQM9mNeHzDYsr7Zcqf7gcUx9LiMfdwG5QIRpfNkb/KlY0faRB80y0qllUmUFTJwl7heRckQ/v2zOqU+PqrkFS48mcGqJeY2w3zknGGHW+7A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF7A88A980A.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7500d222-4f85-4392-7165-08de9acc7007
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 08:53:17.6102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKfwjr9xVFqzSTJq+re5DQuFe2/y33FqFBSvbLULWEdwBmbb0KQd1wB4Rz7L44ZMzgcZ2KGurzxHCOl5dK+mCsyn3SMMHLcfhdgGsHqk2ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEF920636F
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGFudGlsb3YsIEVtaWwg
UyA8ZW1pbC5zLnRhbnRpbG92QGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTQs
IDIwMjYgNTowMSBQTQ0KPiBUbzogTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0
aW9ub3ZAaW50ZWwuY29tPjsgaW50ZWwtd2lyZWQtDQo+IGxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+
IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnpl
bXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgQmhhdCwgSmF5IDxqYXkuYmhhdEBpbnRlbC5jb20+
Ow0KPiBCYXJyZXJhLCBJdmFuIEQgPGl2YW4uZC5iYXJyZXJhQGludGVsLmNvbT47IFphcmVtYmEs
IExhcnlzYQ0KPiA8bGFyeXNhLnphcmVtYmFAaW50ZWwuY29tPjsgTmd1eWVuLCBBbnRob255IEwN
Cj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgYW5kcmV3K25ldGRldkBsdW5uLmNoOw0K
PiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5v
cmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyBMb2Jha2luLCBBbGVrc2FuZGVyIDxhbGVrc2FuZGVy
LmxvYmFraW5AaW50ZWwuY29tPjsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgQ2hpdHRp
bSwgTWFkaHUgPG1hZGh1LmNoaXR0aW1AaW50ZWwuY29tPjsNCj4gZGVjb3RAZ29vZ2xlLmNvbTsg
d2lsbGVtYkBnb29nbGUuY29tOyBzaGVlbmFtb0Bnb29nbGUuY29tOw0KPiBsdWthc0B3dW5uZXIu
ZGUNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBpd2wtbmV4dCB2MiAyLzJdIGlkcGY6IGltcGxlbWVu
dCBwY2kgZXJyb3INCj4gaGFuZGxlcnMNCj4gDQo+IA0KPiANCj4gT24gNC8xNC8yMDI2IDQ6MDkg
QU0sIExva3Rpb25vdiwgQWxla3NhbmRyIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogVGFudGlsb3YsIEVtaWwgUyA8ZW1pbC5zLnRh
bnRpbG92QGludGVsLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgQXByaWwgMTQsIDIwMjYgNTox
NyBBTQ0KPiA+PiBUbzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gPj4gQ2M6
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPj4gPHByemVt
eXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBCaGF0LCBKYXkgPGpheS5iaGF0QGludGVsLmNvbT47
DQo+ID4+IEJhcnJlcmEsIEl2YW4gRCA8aXZhbi5kLmJhcnJlcmFAaW50ZWwuY29tPjsgTG9rdGlv
bm92LCBBbGVrc2FuZHINCj4gPj4gPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPjsgWmFy
ZW1iYSwgTGFyeXNhDQo+ID4+IDxsYXJ5c2EuemFyZW1iYUBpbnRlbC5jb20+OyBOZ3V5ZW4sIEFu
dGhvbnkgTA0KPiA+PiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBhbmRyZXcrbmV0ZGV2
QGx1bm4uY2g7DQo+ID4+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207
IGt1YmFAa2VybmVsLm9yZzsNCj4gPj4gcGFiZW5pQHJlZGhhdC5jb207IExvYmFraW4sIEFsZWtz
YW5kZXINCj4gPj4gPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+OyBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOyBDaGl0dGltLA0KPiA+PiBNYWRodSA8bWFkaHUuY2hpdHRpbUBpbnRlbC5j
b20+OyBkZWNvdEBnb29nbGUuY29tOw0KPiA+PiB3aWxsZW1iQGdvb2dsZS5jb207IHNoZWVuYW1v
QGdvb2dsZS5jb207IGx1a2FzQHd1bm5lci5kZQ0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggaXdsLW5l
eHQgdjIgMi8yXSBpZHBmOiBpbXBsZW1lbnQgcGNpIGVycm9yIGhhbmRsZXJzDQo+ID4+DQo+ID4+
IEFkZCBjYWxsYmFja3MgdG8gaGFuZGxlIFBDSSBlcnJvcnMgYW5kIEZMUiByZXNldC4gV2hlbiBw
cmVwYXJpbmcgdG8NCj4gPj4gaGFuZGxlIHJlc2V0IG9uIHRoZSBidXMsIHRoZSBkcml2ZXIgbXVz
dCBzdG9wIGFsbCBvcGVyYXRpb25zIHRoYXQNCj4gY2FuDQo+ID4+IGxlYWQgdG8gTU1JTyBhY2Nl
c3MgaW4gb3JkZXIgdG8gcHJldmVudCBIVyBlcnJvcnMuIFRvIGFjY29tcGxpc2gNCj4gdGhpcw0K
PiA+PiBpbnRyb2R1Y2UgaGVscGVyDQo+ID4+IGlkcGZfcmVzZXRfcHJlcGFyZSgpIHRoYXQgZ2V0
cyBjYWxsZWQgcHJpb3IgdG8gRkxSIG9yIHdoZW4gUENJDQo+IGVycm9yDQo+ID4+IGlzIGRldGVj
dGVkLiBVcG9uIHJlc3VtZSB0aGUgcmVjb3ZlcnkgaXMgZG9uZSB0aHJvdWdoIHRoZSBleGlzdGlu
Zw0KPiA+PiByZXNldCBwYXRoIGJ5IHN0YXJ0aW5nIHRoZSBldmVudCB0YXNrLg0KPiA+Pg0KPiA+
PiBUaGUgZm9sbG93aW5nIGNhbGxiYWNrcyBhcmUgaW1wbGVtZW50ZWQ6DQo+ID4+IC5yZXNldF9w
cmVwYXJlIHJ1bnMgdGhlIGZpcnN0IHBvcnRpb24gb2YgdGhlIGdlbmVyaWMgcmVzZXQgcGF0aA0K
PiA+PiBsZWFkaW5nIHVwIHRvIHRoZSBwYXJ0IHdoZXJlIHdlIHdhaXQgZm9yIHRoZSByZXNldCB0
byBjb21wbGV0ZS4NCj4gPj4gLnJlc2V0X2RvbmUvcmVzdW1lIHJ1bnMgdGhlIHJlY292ZXJ5IHBh
cnQgb2YgdGhlIHJlc2V0IGhhbmRsaW5nLg0KPiA+PiAuZXJyb3JfZGV0ZWN0ZWQgaXMgdGhlIGNh
bGxiYWNrIGRlYWxpbmcgd2l0aCBQQ0kgZXJyb3JzLCBzaW1pbGFyIHRvDQo+ID4+IHRoZSBwcmVw
YXJlIGNhbGwsIHdlIHN0b3AgYWxsIG9wZXJhdGlvbnMsIHByaW9yIHRvIGF0dGVtcHRpbmcgYQ0K
PiA+PiByZWNvdmVyeS4NCj4gPj4gLnNsb3RfcmVzZXQgaXMgdGhlIGNhbGxiYWNrIGF0dGVtcHRp
bmcgdG8gcmVzdG9yZSB0aGUgZGV2aWNlLA0KPiA+PiBwcm92aWRlZCBhIFBDSSByZXNldCB3YXMg
aW5pdGlhdGVkIGJ5IHRoZSBBRVIgZHJpdmVyLg0KPiA+Pg0KPiA+PiBXaGVyZWFzIHByZXZpb3Vz
bHkgdGhlIGluaXQgbG9naWMgZ3VhcmFudGVlZCBuZXRkZXZzIGR1cmluZyByZXNldCwNCj4gPj4g
dGhlIGFkZGl0aW9uIG9mIGlkcGZfZGV0YWNoX2FuZF9jbG9zZSgpIHRvIHRoZSBQQ0kgY2FsbGJh
Y2tzIGZsb3cNCj4gPj4gbWFrZXMgaXQgcG9zc2libGUgZm9yIHRoZSBmdW5jdGlvbiB0byBiZSBj
YWxsZWQgd2l0aG91dCBuZXRkZXZzLg0KPiBBZGQNCj4gPj4gY2hlY2sgdG8gYXZvaWQgTlVMTCBw
b2ludGVyIGRlcmVmZXJlbmNlIGluIHRoYXQgY2FzZS4NCj4gPj4NCj4gPj4gQ28tZGV2ZWxvcGVk
LWJ5OiBBbGFuIEJyYWR5IDxhbGFuLmJyYWR5QGludGVsLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1i
eTogQWxhbiBCcmFkeSA8YWxhbi5icmFkeUBpbnRlbC5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6
IEVtaWwgVGFudGlsb3YgPGVtaWwucy50YW50aWxvdkBpbnRlbC5jb20+DQo+ID4+IFJldmlld2Vk
LWJ5OiBKYXkgQmhhdCA8amF5LmJoYXRAaW50ZWwuY29tPg0KPiA+PiBSZXZpZXdlZC1ieTogTWFk
aHUgQ2hpdHRpbSA8bWFkaHUuY2hpdHRpbUBpbnRlbC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZi5oICAgICAgfCAgIDMgKw0KPiA+PiAg
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl9saWIuYyAgfCAgMTMgKystDQo+
ID4+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl9tYWluLmMgfCAxMTINCj4g
KysrKysrKysrKysrKysrKysrKysNCj4gPj4gICAzIGZpbGVzIGNoYW5nZWQsIDEyNiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmLmgNCj4gPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pZHBmL2lkcGYuaA0KPiA+PiBpbmRleCAxZDBlMzJlNDdlODcuLjE2NGQyZjNlMjMz
YSAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBm
LmgNCj4gPj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmLmgNCj4g
Pj4gQEAgLTg4LDYgKzg4LDcgQEAgZW51bSBpZHBmX3N0YXRlIHsNCj4gPj4gICAgKiBASURQRl9S
RU1PVkVfSU5fUFJPRzogRHJpdmVyIHJlbW92ZSBpbiBwcm9ncmVzcw0KPiA+PiAgICAqIEBJRFBG
X01CX0lOVFJfTU9ERTogTWFpbGJveCBpbiBpbnRlcnJ1cHQgbW9kZQ0KPiA+PiAgICAqIEBJRFBG
X1ZDX0NPUkVfSU5JVDogdmlydGNobmwgY29yZSBoYXMgYmVlbiBpbml0DQo+ID4+ICsgKiBASURQ
Rl9QQ0lfQ0JfUkVTRVQ6IFJlc2V0IHZpYSB0aGUgUENJIGNhbGxiYWNrcw0KPiA+PiAgICAqIEBJ
RFBGX0ZMQUdTX05CSVRTOiBNdXN0IGJlIGxhc3QNCj4gPj4gICAgKi8NCj4gPj4gICBlbnVtIGlk
cGZfZmxhZ3Mgew0KPiA+PiBAQCAtOTcsNiArOTgsNyBAQCBlbnVtIGlkcGZfZmxhZ3Mgew0KPiA+
PiAgIAlJRFBGX1JFTU9WRV9JTl9QUk9HLA0KPiA+PiAgIAlJRFBGX01CX0lOVFJfTU9ERSwNCj4g
Pj4gICAJSURQRl9WQ19DT1JFX0lOSVQsDQo+ID4NCj4gPiAuLi4NCj4gPg0KPiA+PiArLyoqDQo+
ID4+ICsgKiBpZHBmX3BjaV9lcnJfcmVzdW1lIC0gUmVzdW1lIG9wZXJhdGlvbnMgYWZ0ZXIgUENJ
IGVycm9yDQo+IHJlY292ZXJ5DQo+ID4+ICsgKiBAcGRldjogUENJIGRldmljZSBzdHJ1Y3QNCj4g
Pj4gKyAqLw0KPiA+PiArc3RhdGljIHZvaWQgaWRwZl9wY2lfZXJyX3Jlc3VtZShzdHJ1Y3QgcGNp
X2RldiAqcGRldikgew0KPiA+PiArCXN0cnVjdCBpZHBmX2FkYXB0ZXIgKmFkYXB0ZXIgPSBwY2lf
Z2V0X2RydmRhdGEocGRldik7DQo+ID4+ICsNCj4gPj4gKwkvKiBGb3JjZSBhIFBGUiB3aGVuIHJl
c3VtaW5nIGZyb20gUENJIGVycm9yLiAqLw0KPiA+PiArCWlmICh0ZXN0X2FuZF9zZXRfYml0KElE
UEZfUENJX0NCX1JFU0VULCBhZGFwdGVyLT5mbGFncykpDQo+ID4+ICsJCWFkYXB0ZXItPmRldl9v
cHMucmVnX29wcy50cmlnZ2VyX3Jlc2V0KGFkYXB0ZXIsDQo+ID4+IElEUEZfSFJfRlVOQ19SRVNF
VCk7DQo+ID4gWW91IHNheSAiRm9yY2UgYSBQRlIiLCBidXQgUEZSIGlzIG9ubHkgdHJpZ2dlcmVk
IG9uIHRoZSBBRVIgcGF0aCwNCj4gbm90IG9uIHRoZSBGTFIgcGF0aC4NCj4gDQo+IEhlbmNlIHRo
ZSAiZm9yY2UiIC0gdGhlIGNhbGwgdG8gYHRyaWdnZXJfcmVzZXRgIHJlc3VsdHMgaW4gYSBQRlIg
YW5kDQo+IGlzIG9ubHkgbmVlZGVkIGluIHRoZSBjYXNlIG9mIGEgUENJIGVycm9yLiBJZiB0aGlz
IGZ1bmN0aW9uIHdhcyBjYWxsZWQNCj4gYmVjYXVzZSBhIHVzZXIgaXNzdWVkIGFuIEZMUiwgdGhl
IGtlcm5lbCB3aWxsIHRyaWdnZXIgaXQgZm9yIHVzLiBUaGlzDQo+IHdheSB3ZSBjYW4gcmV1c2Ug
dGhlIHJlc2V0IGhhbmRsaW5nIHBhdGggdG8gcmVzdG9yZSB0aGUgb3BlcmF0aW9uIG9mDQo+IHRo
ZSBuZXRkZXZzLg0KPiANCj4gVGhvdWdoIEkgbWF5IGJlIG1pc3VuZGVyc3RhbmRpbmcgLSBhcmUg
eW91IHJlZmVycmluZyB0byB0aGUgd29yZGluZyBvcg0KPiB0aGUgbG9naWM/DQpGcm9tIHRoZSBm
aXJzdCBnbGFuY2UgdGhlIGNvbW1lbnQgbG9va3MgbWlzbGVhZGluZyBmcm9tIG15IHBvaW50IG9m
IHZpZXcuDQpQbGVhc2UgY29uc2lkZXIgcmV3b3JkaW5nLiANCg0KPiANCj4gVGhhbmtzLA0KPiBF
bWlsDQo+IA0KPiA+DQo+ID4gRXZlcnl0aGluZyBlbHNlIGxvb2tzIGZpbmUNCj4gPiBSZXZpZXdl
ZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+
DQo+ID4NCj4gPj4gKw0KPiA+PiArCXF1ZXVlX2RlbGF5ZWRfd29yayhhZGFwdGVyLT52Y19ldmVu
dF93cSwNCj4gPj4gKwkJCSAgICZhZGFwdGVyLT52Y19ldmVudF90YXNrLA0KPiA+PiArCQkJICAg
bXNlY3NfdG9famlmZmllcygzMDApKTsNCj4gPj4gK30NCj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4+
ICAgfTsNCj4gPj4gICBtb2R1bGVfcGNpX2RyaXZlcihpZHBmX2RyaXZlcik7DQo+ID4+IC0tDQo+
ID4+IDIuMzcuMw0KPiA+DQoNCg==
