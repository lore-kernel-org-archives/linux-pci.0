Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794849135;
	b=z2CeBDUgHxU3syc8BVaPugparnCxAgiMMLvznquUO7obLwwjUCVS7plIqiBUthV6Nuoh
	 OlI/fEN2mKzji7+W/P7ri/eehAppulPf1Y8r7MK7KEFwfXuEXi3CnJcoAmFwWuytUar01
	 iLTEQmIGvCCYPyZqtm1bBXma1TMG5T8onREqY8yT0qRb1iLLR/iF2lmRIdny1Ug2F26Q8
	 UMdjHDvAbpZgSxZkjTzVurGyIh274057kdDlN3so65wcADG9Qmq0LCil8NudZZgBF4fUn
	 3GlX4Z48RWguM8Slnfgv07aYR/NrmqUr3XCXIlawxwpHZzj+PPby4gkpd+zuhJi3xNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849135;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=qxLe+CjLvP++hSHM+qRvYgljtr1q3hi8B3H718OcCtE=;
	b=mmkuPeIsG5wPwY9rqZIsvYWAR6RBvAwkIKPtnMr+OboDzMv9Ati38xQlvwYaYmVnS6yF
	 H4MlJABB1eq+BimpjtK45enJH3tSr2L6rLI/N9Y06H9SLAtGkKsy+Yydy/Zldzx+5UPvl
	 Hh0sRIY14PsX0BIWvMiEBPoYNP8DMYf0vB3leDHne5vJcNpNtNz4ZsM33x2puwjl+8ahh
	 mdiTUJvI5PtKlcdfTYqJ/wOmF9G4auyKCZss7ElC8Kry11vttu4qP9X7X7LlyTB2Lu8SZ
	 i8aqAHHkkeMjQptDHdnR2G8OqNA2kxqqn7rTHp2TCgBK4cv1GL/asNW2K7nGj22e3Nw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Si7z5Q5d;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ERFFKVJH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35B1606A31C;
	Mon, 16 Nov 2026 17:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C35B1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Si7z5Q5d;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ERFFKVJH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794849134; x=1826385134;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qxLe+CjLvP++hSHM+qRvYgljtr1q3hi8B3H718OcCtE=;
  b=Si7z5Q5dRLSrU1fDLAsUV03YTclJHnWSKQi5Qd1HbgDGds+0GmWC7mPh
   UVg3SCuNqgYI0n5D33rpiFEDfHP3/NElJoT19nowp4MOs7jrnaBuAs+5F
   /McjeWA19UNPQtQFHm/0sNEmAM6UnwjiWP9xiZ7Wc1jpcOzecMMxaQcbq
   9Q3QPtoqSjU4EdIzPVh7owOgA3cb6tjzJYrowGh8e5tOV52ewhF8H+Lg0
   F/T98o/XA7JHtMQw81SMYhWBf2/RcvZz3LDBtzvpyOmNduCZZ+Sp3rm8f
   Lg53QLM9oaswLU25tXSkU63h5gRzOG0LEEcGTp5JAhf6YI80idtG2EcGB
   Q==;
X-CSE-ConnectionGUID: n6lpV2oGSiq/plesVZwhrQ==
X-CSE-MsgGUID: QtuIYp0mQL6+KLwe4Bc2wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3609546"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3609546"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 09:12:14 -0800
X-CSE-ConnectionGUID: qX4aes+STn+ujMAhwLYfyg==
X-CSE-MsgGUID: ScF23GQhTKKJJBIbgvOuBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9655430"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 09:12:13 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 09:12:12 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 09:12:12 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 09:12:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0LbevMLNaFo2zKRDeZvht+vXkQXhGRXZffBlGR1ZczXVOKqHHBdjQKyrDP7YBLTnnsRy9/X/MHyeIAyZbZVV5jQbQl6QKvNYnxuqz0ylIAKEKEhkPvDfZNg91Cp6gIfcx2v/+a0zbWsAddE7/AXfF6rsxyigT1o2+He9JiIJR2Sqf5YqLnQ5Rl5O9tAXq9UQqmFYDIhi9vP1vgEOLZmFBpDYhWrQs3/m66XIN6w1tpe/YFbkEeqSrCAJw+E9Ry1jqploVr8H/yem30uxvnVfOURvcAx2LbiMjpTsZOlrNAtD78A1AbaAllIs7vDUFOc65y0IgdsBjuxCqu8BXJ8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxLe+CjLvP++hSHM+qRvYgljtr1q3hi8B3H718OcCtE=;
 b=s5pSVoBPm47mmC/P4Bevhm99zAkF7Ftn1Iq0jD330famt19tAxmVK5zzXBcKxROrN3SHxq9UD4HoBsU72+wwbXEiySnqkKMRoyw5zMoQBFC7ZFsKM2H73GXDDs09nYEa8PpcYulsKpfqIGgpeQvqfgGK+7WEjHlbXHdWkhnZYgvV1u86n0O8f8A0K2I5daAzIYDxWAxsT6EQ2LwHjZvD/s2lnbLiWmhJPJdiiEXMnehoNY5TBedKx4jjXzVhusopNHFmAMEjh436xgmXEO6Mt+paMTnG/UDz7ObSzRu5EFQy9jndjKWXrJe4HCyJdULRLQhIHWbLfsc+6n7bYMK+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxLe+CjLvP++hSHM+qRvYgljtr1q3hi8B3H718OcCtE=;
 b=ERFFKVJHpss5gqynwecxJ15nOls+Uuu/koYgN1tlGgzBfe6h9j6nmmbusagHU6zGpQZI+6fWt6lc3fhsAmzPOCMzzAuWjsAbW/0vx/nB7Djd6Oyhh/Fl4s7vbIakMLLKgfR7umHpwOrMxN3xPQSnijxXVboK25aoQkU9By2K3jA=
Received: from CH8PR11MB403433.namprd11.prod.outlook.com
 (2603:10b6:610:32f::10) by MW3PR11MB4522.namprd11.prod.outlook.com
 (2603:10b6:303:2d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 17:11:10 +0000
Received: from CH8PR11MB403433.namprd11.prod.outlook.com
 ([fe80::b087:96e4:50ea:b5de]) by CH8PR11MB403433.namprd11.prod.outlook.com
 ([fe80::b087:96e4:50ea:b5de%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 17:11:10 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rob
 Herring" <robh@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kw@linux.com>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 06/13] i82875p_edac: Convert to
 pci_assign_unassigned_bus_resources()
Thread-Topic: [PATCH 06/13] i82875p_edac: Convert to
 pci_assign_unassigned_bus_resources()
Thread-Index: AQHddd61ATuwfIOwQEq5go6vW/VTGbcw1cOAgAAYbsA=
Date: Mon, 16 Nov 2026 17:11:09 +0000
Message-ID: <CH8PR11MB403433B2B6C13E8AA2A31130FAFC7C2@CH8PR11MB403433.namprd11.prod.outlook.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-7-ilpo.jarvinen@linux.intel.com>
 <20261116154005.GAavsj1a11BRgBVtSd@fat_crate.local>
In-Reply-To: <20261116154005.GAavsj1a11BRgBVtSd@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH8PR11MB403433:EE_|MW3PR11MB4522:EE_
x-ms-office365-filtering-correlation-id: 886649ae-e6cb-4de4-f96b-08df44049c1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|56012099006|11063799006|261102123227099003|261021121427099003|38070700021|10067099003;
x-microsoft-antispam-message-info: InZsNKkv08c4/Qy5FlHGAc6JQNuVwQsKFgui3C0SgCrZMxfj1JHO+HWq0DYmuUoG+pUbZlv2zVhrfcwsjZOU6znFCbZZWAIwqDqPehadKZUCMSRRVoFwibp5yuojR/JHhOGX0hW9idjeRYEPnlStw3LXAcJ75Mgyeo1CHIBTkdLmcM0GPZ+5A4twhLpUs1GtRRoWGsiLhc5vyKxIsLhinefXlMnocTgn3corOwfSGxeM8Q4ZbwOq60CmhcAt1iYz6+VxIPKMi+M9p9Iv67Osb+PwXbl/vQIVWe4FQ4gCgrebLgBv/40e5Svqk4eCVeztm7OR+An/gdKeaRu7C+iLxnGcoUs/ZeUG2KDTjxuhDvFMQV4ODIcoGLw2/PjI3IKonrV5JJgy9ChKQXgMKbC7MH3KWwCmtyvx0dqvilSOEHk1GSPfYLTobpCcffY/1KFP2XBob0x1KegFfFd+4xQvjIjpZ3/wxjckPQfbIhRpe/WQO9wZHaBa+xyoyEuTs/sCFPj1sHTMh0d8PS2mbn4UrVr6D+OiZ3ASh4Q+fkvr/dn+NNoxbAsrb120tyu+pNp9dvwp05gB+dtOFgIwnQfMW5pw7UaXa8JQzIj+g7hnXfZpOTJ1cKaiXPCdtySKjr1yBb1L9Psb0+iir5ISBj1nZqFHM9FmH5r8+CxXu6XYH5f9xuQKRp96Rm4x5miYqlMmnpWTQmPI+KrPAPd5vCdtNg/ZemR+l4kXO/t6Jn7uaQ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR11MB403433.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amlpb2VxNFN2enJBSjRwMUVzeC92RGJUZzJ4Ulc2MGhVWnh1N2Y4SDRpa2dm?=
 =?utf-8?B?VUd2dzQyaHFEYVZrWk5LTStwNEVoRE5yRCtJSFVyWmUzTFdNZ21lbE1uVlA4?=
 =?utf-8?B?WUhPOHpzMzVQM3VMMkpNSEVIT0hlMTBGanVDNTJMUDEweDl1dURwanFsODNp?=
 =?utf-8?B?dEdTa1F0UHBTckNib29FcDkvT3RtVE1Yd0hmV0htdytEeElyeVMwUEJjUHRF?=
 =?utf-8?B?VmlmZVIrckgxU3dqSXlKaGdTL2hWN3lRWDVvR0VVb2JZZGhzcDZhN2h2MURC?=
 =?utf-8?B?OWFlb3lvQWYwZ3NiUFN5eFBTK3RSVVhiZDcyQ0FHbllSTTFOV28vaXZOOVZI?=
 =?utf-8?B?dUh3ano5dDZ4aU1HK2NNUXpHakU0bUFyQ2VvTkJNcWFmOThsS1BOWjZwL2RX?=
 =?utf-8?B?ekdydDdGS28xM3YwL1k1T0s2clcxSFZQY0tqUDFQOXVvNEhKQkpoL0thYzFJ?=
 =?utf-8?B?MGZOOHhrSHdsUlZFOEhES1djQU9SLzUrWTV3UlhkS1hzWElMY1F6M3RHaFJV?=
 =?utf-8?B?U0xTbjlFZGtNaW1FdE5Pd0pSYi95V05UL1NvL05rKzhvTGtrY0ZYNzZzNmtS?=
 =?utf-8?B?cnhlUnlnNUYvVGg3Vm5xVEh5WGJYU3Q4eDlPZlpJbzNVSnZuSnBXcE9VVmls?=
 =?utf-8?B?Z3FPRmJFRHM2NSt4Ly9jUDlTWUJWaVpkWmc4NHVreHU2NmdrR0x6QytXRy84?=
 =?utf-8?B?bE50UUtSK3o2bnkrQ1VTMXBXVFVlNmN3R29DQXorV0llcHdIMjc2TFI4dnl5?=
 =?utf-8?B?YXMwaTJ0ZHhnWm5TYVVCeVpQM3R3ZWErR2ZiMmhjOEdSUXhIVWRPbW4xYXdB?=
 =?utf-8?B?cEh0T0xqdk82cVZ0WlVtN0xMZnNWekJuVWJub21MNk1jeDFYOFp3WTl1WmRy?=
 =?utf-8?B?UVNwaDk3M3ErQU01OUlYWWlmRWN2Y2pRUkFUYnZDSVVrOVErdDZVVFlXR0lk?=
 =?utf-8?B?OWJnZnlsbzQzNGZ0dzBqR3NRREhJcUx6eUs0YWtLZW1sRjc4ejFQSGVkeUJa?=
 =?utf-8?B?NDdLSi9KTjRDelJGZkU1dU9uTWd6d1FYb3k5eTBNa20xM1VtemRlNkV5NEc2?=
 =?utf-8?B?N25tbWswRjZrWGhheGdyeVZzaGlVWHY5VzZ5bFQ2S2djUjZWeTJ2cFBzVzln?=
 =?utf-8?B?bzh3RXdSTFNDZzdSaE5wYXMwR2lNWjJGL0pVZHdidUhNUkhXQ2k3MWhFNFhS?=
 =?utf-8?B?WVZnbWRHdVNWYVB6Z2l4ZDZHdkZTemY2MDc0WVBYdTdIRXpLQ3E3bDZFTE02?=
 =?utf-8?B?N0ZqSytzN0RwUVR1cCs4aTAza25wTksxQUk3Sm9iVTN5SHF5Sml3Z1pEUFE3?=
 =?utf-8?B?TWtjTUM1bDhyTTk1b2F4czEzZ0hSMkh6WlRSMnBRb2t0d055aWdwbXZWK1Bv?=
 =?utf-8?B?eXpKSjY2Z2xndzVMWDJranRvYUZCcFdxRzYzS1d4TXhreDBMTEphdk1PaVpW?=
 =?utf-8?B?bFFtQ3IySEhPVzVsbzVwQm1ISnJXKytwWnFDWEdwK0tiY2p3U1Ribklsa011?=
 =?utf-8?B?UXQydVAvZWgxb2d5bXJlZHlJejlXanFkbFBpdklwTmN4cHVQT3p0bGo0NXIw?=
 =?utf-8?B?WGl0b3VqRk5yemZPT2Q1ZkhYeUQvM2R3MlB2R2ZaaDh0eHVlMW5FdXVaTE15?=
 =?utf-8?B?bEpFbXpoKy83MDcrcFE3bW1td1Q4UUJqdVZNcm9KK29DQ2htc2c2dkJQT2NF?=
 =?utf-8?B?c1h1bUk3bHZITEM5emVmb0dtTHljQUNyYitOSUEydkhNYkRGR0RvUGFyMUlh?=
 =?utf-8?B?RUNVdUJwSElIWFYya000UGVnNmJCR0M3QlF3RnB0MHJQY1Vsbno0Sy80SDJX?=
 =?utf-8?B?WEZ5endtd3FhTUl1WEkyMnQwbWNSbEhudzhiOTgrZkNsL1p6eEJLaXllV3Mx?=
 =?utf-8?B?eGg0NVVzc1BGbVhSWlhEYW9LVHhMVlFacWxRZm1ZSFFiL20vUDZCMWhXTmYz?=
 =?utf-8?B?QUIrZ21OMm5RZVQ3Tngzd294Ris2cmxQNTh5aWwvTHdXZWFQS0MzM2lJdVNm?=
 =?utf-8?B?NHczWHFMR1l2QzN6aVRWTzMvVU5OM215SDAxWVhjd0d0U3lOams4eHFtVUMw?=
 =?utf-8?B?b3QzTHRqTCtOSG1hU0EzYWJtK0JNZHZJQ3JGNll2WVpML1ZCSDgrZlcvZHFU?=
 =?utf-8?B?ZHdSNHgwTmxPTERJL0FuUmtXem9Yc21hTHZZUDNNek1lRXBudjF4cFU2WWFB?=
 =?utf-8?B?RTJYREQyRmIrWWs5NkVIVldSZG1TclpMQ3MvZUFaNXplYXdYU3hncG0yT2Yw?=
 =?utf-8?B?V0YwSnNkVkgzelZJV2JyL0hQUWNESGt2VW5YYUx3ZVBONGtENE9mMURCMmxq?=
 =?utf-8?Q?fKNurRKAJRgDZEn7oi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KOY+/bkDudimpAx5cQpwvjeV7N90/a1K+Z5QkDEKzRpnCrq4K7qCARqg1SXcJwO9cLl60nzjOCxuuPLseAi4+jRulYqvZMZkDPoqgMY/JIq0m2KqcVRbQjobaPCrJPoAVK3cBdpXVcDYnzk2xHRy1IKB4w7dUqncwwW5o5f35wfl8RQrl/OVkB8AjgkyPI5yq59fHv1MmttjSpexVyBq4k8U8fAvVg+myKCao1rW/SVI1aqPF9Y0rBeoAdu5ezjHNIEPmWLPNviD9c6/VCri26OOizuuEsargqpnkGNBPovge+pcMGXm32P5/qHwkxsD0JUc1MW/JQvLry6IfHwTyA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH8PR11MB403433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886649ae-e6cb-4de4-f96b-08df44049c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 17:11:09.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpostiriuBcyqt9iQRtX43UhbIkC9LhpHjmERf3iEfawIur8MseXl9PvWg6D5M+PLe9QdZUQmnIvMW88hjRIvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-OriginatorOrg: intel.com

PiBJbiBhZGRpdGlvbiB0byB0aGlzLCBUb255LCBzaG91bGQgd2Ugb3JwaGFuIHRoaXMgb25lIHRv
bz8NCj4NCj4gSXQgaXMgYSBQNC1zb21ldGhpbmctY2hpcHNldC4uLg0KDQpMb29rcyBsaWtlIGl0
IHdhcyByZWxlYXNlIGluIDIwMDMgb3Igc28uIE9ubHkgc3VwcG9ydHMgNEdCIG9mIG1lbW9yeS4N
CkV2ZW4gaWYgc29tZW9uZSBzdGlsbCBoYXMgb25lIHBvd2VyZWQgdXAsIHVubGlrZWx5IHRoYXQg
dGhleSB3b3VsZCBydW4NCmFuIHVwc3RyZWFtIGtlcm5lbCBvbiBpdC4NCg0KSSdtIE9LIHdpdGgg
bWFya2luZyBpdCBhcyBvcnBoYW5lZC4NCg0KLVRvbnkNCg0KDQo=
