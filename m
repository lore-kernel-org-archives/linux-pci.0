Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4DA3F7E8E;
	Wed, 25 Mar 2026 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450285; cv=fail; b=MUgq4j+FI46ibMexLoP53RoJAkfdqw/y+kuzTAh3quNzec6l9Qz5AX+N/IkR0vzgpCuc1GghCf/vrEk9qtFYWfKkoRsN17aVIiaweehU6fOuuIFujEWyTj8YcwKkdxXsB5lWIYSujPfHUcilOufJGgdAA1nQUqHBJ1ASQ9RzYSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450285; c=relaxed/simple;
	bh=DRB8d1zqD9Kbtp/4yvYAJ1tpSD0pUknTYdUe9vG42y8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CejJYtsaiy5shOBzfDBnSYXqeefPKHGZ1dBAO144P9KIRh+3Kt4HIQl2DMVRZYlTMT41qXr3pfz5j6oweCiTbEZwY9EYsAL63hmCJwI6OzS/ML+qFgQrPSsJGFT3PZCFE8WVF6WrE2Ygdpdw7jM+dRzt7+q744qH2KPFFv5HoVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nue+UeWK; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nue+UeWK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774450274; x=1805986274;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=DRB8d1zqD9Kbtp/4yvYAJ1tpSD0pUknTYdUe9vG42y8=;
  b=nue+UeWKvNjqs7GH5lolH7K17FeoZB9G668QBeqfV98u8fDVAVhmvG1n
   Bexm4F7OPD+TXl7Xz5FulZcDOyRQamPDvUpNE1DYSsJroVNhIoT4INvIp
   6ZQowgB41Z3SB0U/uAKtrX2OBNgKpF0HQKkO+tQKCmnaikm8xQsGUP7uW
   cOrpf3OlT7WQBYYPwfkmIC3Mh6AfPRZC4prUOGqC4iEYqPM90EhF5n02K
   xqmtnJRTPIRjD9YJAIgt/uas7vqukomyg6B3kxaTWiJbXyptwCcqX5pLy
   rTP/EvmnTatdJ37O+UFGToj/SP4ZOjN8nSa9N1oOJxzN+D/H09Vz1c2rz
   A==;
X-CSE-ConnectionGUID: jTxyVbz1SYyF3Ksq+X2fvw==
X-CSE-MsgGUID: dUPULJY6TE21gRsBqknf+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75204402"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75204402"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 07:51:11 -0700
X-CSE-ConnectionGUID: btMJq9JgS8Gj6dayz5f6Mw==
X-CSE-MsgGUID: m3HtEYDOQXyW3M1FSb9IoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="221382287"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 07:51:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 07:51:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 07:51:09 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 07:51:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3+wC5C+fkc7ZuOMQp7AEQv7O2fQ77TLVsU8VdIiSD5uFy6kOEI4yI87AtvB5bTsTaKrSeHOpeULKiW0cYcOxq2Ek4ynVZpZZcu7cf+8vugPfhVZKumqh3ATy0yzmNhki8l7xkMKh3kaHit1qUDvxp84ptuNtxySg7g1zYOWJweIh3De4ktceACCzQoUg8Tfz9EjC0aCi4iAcp731YH1lSgZMw4Zjv5dY39BWV572PsTBl7guKVFAZlao3A1jfnK2imQV8OyjszdV52pokNlEM1Rh74DsfBUV0qMelx6dAnyNwQ3xFXc/RegdiNDHpuTNT3SWoWAMyUh5sVWookzfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Vnj2pUknbesnjE//mYIh4xBElXiTpkwVva95swmlOQ=;
 b=NWEZ5XlXDL79J1b57Jr4NBIABBNnjnmHivAp9jNgvqLffF/3wmDXdlu1EtRCMRQQVWnLk1FKNE0eGt4giy87sC7LguYIysv+wpFapMchNNvY6xWC2X0RfJx641tZ41y4qv+H63EWMXmIUqT/x1vJCwBClqY2MFc57MX5eBXImd1PubJ+AczUScBfAnyG1vI6p0AZVuuA7sBRLpTssmFc7xXeYG0dja7I67IiEtDnQPFXsOzhY1oQeR/B7FxwD6NsfQDo6KGIBgiwtwPM57FkgTNyEB/STQrqNFO+TDLmGgqdyKQIGbd39PT1vmRc9rGrFGmFR3A2jtwCVriT2JOlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by PH3PPFC067E5C7D.namprd11.prod.outlook.com (2603:10b6:518:1::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 14:51:00 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 14:51:00 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>, "Graf, Alexander"
	<graf@amazon.com>, Alex Mastro <amastro@fb.com>, Andrew Morton
	<akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann
	<arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, Borislav Petkov
	<bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, David Rientjes <rientjes@google.com>, Feng Tang
	<feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Jonathan
 Corbet" <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kees Cook
	<kees@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Leon Romanovsky
	<leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Li RongQing <lirongqing@baidu.com>, Lukas Wunner
	<lukas@wunner.de>, Elver Marco <elver@google.com>, "Winiarski, Michal"
	<michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit
	<parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>, Randy Dunlap
	<rdunlap@infradead.org>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah
 Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>,
	Yanjun Zhu <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3 03/24] PCI: Require Live Update preserved devices are
 in singleton iommu_groups
Thread-Topic: [PATCH v3 03/24] PCI: Require Live Update preserved devices are
 in singleton iommu_groups
Thread-Index: AQHcvGbLhACgv/fpyUGZl+i4j6P07Q==
Date: Wed, 25 Mar 2026 14:51:00 +0000
Message-ID: <4F9426C5-68B7-47DC-9DC3-2F420FC71F63@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8509:EE_|PH3PPFC067E5C7D:EE_
x-ms-office365-filtering-correlation-id: f150e614-2ec1-49ee-51fd-08de8a7dee0b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: XJNdGkHTxM0//hqXP9MAEdg7k8Zg3NKUwQvfnfZff1K4M+aCuW3sI64KiAvvsNBlLKLCVJXOd5Y8/4Vx5GiIYFEZr8hvqBLbAEG07XJW68+G3X+ATQEd1tVj+suraub9HR5tOLWdnhyXGj/K32kaDMX5ivLOeVNqF+DzBk/LrJxCYiFgT46GflG7HAaR4MEIcIKnXNBhYBMfzXU+Zw4Nspy2mFxMo3M7Zv2W9D2DGbl/olgnmTuIanFMnP3HfCzXtKQ/Kd2eEGKvEb48K4mAs+oQ8k1mjQ+ibo6EbqTIntx11CbyD93WHiagZuaupSoRw1IuFuPlbNnQ4Q/WB9UqL8Xve9l2deEWA9vOiedD2I6A/FQ8tTVAskXRmw2MbUfAQg6RpvPcJeqy9GbC9nmnxhnIhqsaZ9Nc4JOaaUD8yFyZXDRCO6pfGIajezVq0YGP+o/fAIGzuLwyMvM4zFln05cABGHeBecU5VdPUadxy2WmNEzTAlMLgW7F82wvRiHZMzIU8tEHLORb+J+bWofPQIKFKmC3y7JxFKIugFmMmfvB+Z+tg6XxMb6JPXsrbmOTs5K8qu13KEO8feRu9HInXU6Tk/cIqN5x0Pw5sCrkkADj8GrzBpQlrHXUcff1V4ALIiKq9Yej0/H0p6b6VeBJcGgbRo6sf76+KZFr/AsGA7laJTPvlxwOlyQdDQENpwq4oUeHM7BFEXaA0IeeYs2eqyuNhMluR3sqzAPaPSVPOL2djKM2JO3cCu9RiCUohnJ4dqgGHh1CWASnzf8QTY88ifTEr8/SL/kcD7pTNNGvvYc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b7h2wDIQpUl/kdhHA7Ejri7wTxEZRa5zMv9BYJXQv21oICASlEFxoMinoHUM?=
 =?us-ascii?Q?ZjVk8wd51kIb5Wn4vuMqg58d/9zayLdCBYzeS5CwoY8wKGGYHXndOgU0yEsI?=
 =?us-ascii?Q?NfUe3Z39kkpYpZyA1sIzzyRnFOMKuMdNOXeug6dIWVjye4FF9q1enRTpP04u?=
 =?us-ascii?Q?80Hqkw3IvwJlcybp4A3S/KYWJkwBnuflnDfV0Hc3F6jpJSvZMaAi0kXC5XA5?=
 =?us-ascii?Q?EOEhUcbF8w1PZcUug55jyYw0nJtBZL2bEPuzwwRiKGRVxcTyOT7ArrzgHPOb?=
 =?us-ascii?Q?SMV0xYoFEleMsRjsjzIfgnveEIwIwP6p1buY8c27pHj9YG7xEaenhy2yME1d?=
 =?us-ascii?Q?MIW4o29dPixbAjVNMMxdWoIJTGjcJAq28aLFEHG78jtjcOlA5cDEJiOI9uon?=
 =?us-ascii?Q?5atyAub5YUK51jLlF/rDXzEJhKBHHNEHo3SXph9dYFmt3lCIJuPZ9N8yaMc2?=
 =?us-ascii?Q?4Ao5POGsvmzeJqSAxSDnp0iJembpQ1lj0NcsnDSeeQ1UmCDcp5N/sdn2dCem?=
 =?us-ascii?Q?scX0RbcXA7tl7kqRliqjNsxIcKJRSIsjD1NwyfGFQ3dCWo9yABagSM/1Stxa?=
 =?us-ascii?Q?Hq2a2n7Os6rxOsX5HcOd03KZSVLW0NWIGrQd8XcoU/CUQyz5ahNEWbI4KEjf?=
 =?us-ascii?Q?oXOLg9F7t4ph5a0lSirVokaeM0TmySqgyBolzm/cR8ySU0NFf1Dqmx0oMiJ9?=
 =?us-ascii?Q?Mf191XNZehW98shyE/AtajfGopSJt9qUuQu6hhmbjL3rKtlbBghyf5Bqz72x?=
 =?us-ascii?Q?eQdwJEglAqV9FQrWm+/ish10aEGlWVsp1LlOJPbRhAn4fmCPG8uKMITUzjYU?=
 =?us-ascii?Q?TDfQH6kHBECxvuUF0Kuw064wKCkmNZzUuBFeeXRTe2x/aO8shbg0Iinyt8S0?=
 =?us-ascii?Q?lBOfsq8YLsBJ2GW0MY5SlYfMhv7H4PekMgKeuJh5hbwiyvb2kYuw5/ytx/0/?=
 =?us-ascii?Q?6f+0YWilGG7xosq8StgQ8TmsodyX7Qy25qsdaqoJK95Vxg1JslvFHOo6TZau?=
 =?us-ascii?Q?JHr1Mg9LGZBSzLAt+qLrRc066OXhdF799xj/0zmF93iMDMale4+9m3WqsRVr?=
 =?us-ascii?Q?4xHfTpIHYdqnzjzZ78eYRFlzNAD50oFr2+XETTlj5nxJGufoqifiJg3Omnlp?=
 =?us-ascii?Q?hiOCplh+InGukyKTKSYev/k9hM+zbXZDyOuK6dC2EqrcbY4VNWQXf//EGzKb?=
 =?us-ascii?Q?LuHKOFya81RC7ofUw3SdJaVjjhD+B8a7hHDDCJfWPKqKsteyIexrNW39x8xv?=
 =?us-ascii?Q?Oa7Z1Ya8/YrTIwzEoO6fYPr93P4scjxa5juMPTYiUl3uQydHDTTnioAeytFC?=
 =?us-ascii?Q?FjALSJgt8Bgtv5oMrPy0ajJXch7dY9cmyMhTwy0VYrdGdxMG4RRiz21BB78g?=
 =?us-ascii?Q?ZGrExEZRLZ7hG39sYgtrCvaaKfRWxLU6ArbWa/pur8eikrvWk2wa4KGzcnIW?=
 =?us-ascii?Q?bUs5FxLmA6P1Jt5dP+dJRecI0YNG6Qm6NxdMRNCRykH/ZKW9nrbHmUplM6Mf?=
 =?us-ascii?Q?fhJ3AmxbaYjSTPEOYKIa4S2tRsJr5m//iTpZv4mP9+IcrEg6N8JmIlxqvG+l?=
 =?us-ascii?Q?axsuiaDgFT96mumQXzA+mTn2oOsrIxrtD3FPrElp0m4yZxeXbsktix7DI9Qn?=
 =?us-ascii?Q?f4KSBs2XsPj8YqxVUheJdfSqcc29AKvNiIZrgGnli2VrFafpl+qomBWamGsO?=
 =?us-ascii?Q?WA36MOLlEntM6GXWnNID/KFX2wKF7Ds2k3b/BqHoPf5OG6Y5XzgRuFpfX1Wb?=
 =?us-ascii?Q?2O0edsUamg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD75F3C252782E4ABDCD7E248240E47A@intel.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Mj2ewsnGq9q5TYqZWzXwypSXlAExiylQQqoLS+f8LAsMQ40/90BIyWU4bQGpgGK54uTvVCGJMUgvtDQ9bN8JpRO50prmwTEJ3ewWYuQCp7FuB7QwGHFVOw8yRrqNiwELn46uK86TU5lKloSxdjUI5Q1Tpd32apvZGEun2Dkz1JJU1lijKSIYbKiRHtDhTsijQ69SYq4zDWWb+YQ6PIMvddcEJRrGdR4Ct7/tma2WovEenYIDhMInSEjmeIF3xfUD7XuHthiNv5ScbGKhf4LjBI2RQGl7nU/D619xZgbczt8thtWqTgmPiDuePI/UtSY8/Cxoqobi8EDefhJ0ix8nQw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f150e614-2ec1-49ee-51fd-08de8a7dee0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 14:51:00.2233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e92cDs9nADvIS5GLBVRpkWtxd9kyRJvSPecXdahYMDxTYvTHaBTLC+SefP6yJ0jKHQywJFzz+MrtTK/pZExzQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFC067E5C7D
X-OriginatorOrg: intel.com



On 3/25/26 02:00, David Matlack wrote:
> On 2026-03-24 09:07 PM, Yi Liu wrote:
>> On 3/24/26 07:57, David Matlack wrote:
>>> Require that Live Update preserved devices are in singleton iommu_group=
s
>>> during preservation (outgoing kernel) and retrieval (incoming kernel).
>>> PCI devices preserved across Live Update will be allowed to perform
>>> memory transactions throughout the Live Update. Thus IOMMU groups for
>>> preserved devices must remain fixed. Since all current use cases for
>>> Live Update are for PCI devices in singleton iommu_groups, require that
>>> as a starting point. This avoids the complexity of needing to enforce
>>> arbitrary iommu_group topologies while still allowing all current use
>>> cases.
>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Signed-off-by: David Matlack <dmatlack@google.com>
>>> ---
>>>  drivers/pci/liveupdate.c | 34 +++++++++++++++++++++++++++++++++-
>>>  1 file changed, 33 insertions(+), 1 deletion(-)
>>> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
>>> index bec7b3500057..a3dbe06650ff 100644
>>> --- a/drivers/pci/liveupdate.c
>>> +++ b/drivers/pci/liveupdate.c
>>> @@ -75,6 +75,8 @@
>>>   *
>>>   *  * The device must not be a Physical Function (PF).
>>>   *
>>> + *  * The device must be the only device in its IOMMU group.
>>> + *
>>>   * Preservation Behavior
>>>   * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>   *
>>> @@ -105,6 +107,7 @@
>>>  #include <linux/bsearch.h>
>>>  #include <linux/io.h>
>>> +#include <linux/iommu.h>
>>>  #include <linux/kexec_handover.h>
>>>  #include <linux/kho/abi/pci.h>
>>>  #include <linux/liveupdate.h>
>>> @@ -222,6 +225,31 @@ static void pci_ser_delete(struct pci_ser *ser, st=
ruct pci_dev *dev)
>>>      ser->nr_devices--;
>>>  }
>>> +static int count_devices(struct device *dev, void *__nr_devices)
>>> +{
>>> +    (*(int *)__nr_devices)++;
>>> +    return 0;
>>> +}
>>> +
>> there was a related discussion on the singleton group check. have you
>> considered the device_group_immutable_singleton() in below link?
>> https://lore.kernel.org/linux-iommu/20220421052121.3464100-4-baolu.lu@li=
nux.intel.com/
> Thanks for the link.
> Based on the discussion in the follow-up threads, I think the only check
> in that function that is needed on top of what is in this patch to
> ensure group immutability is this one:
>   /*
>    * The device could be considered to be fully isolated if
>    * all devices on the path from the device to the host-PCI
>    * bridge are protected from peer-to-peer DMA by ACS.
>    */
>   if (!pci_acs_path_enabled(pdev, NULL, REQ_ACS_FLAGS))
>       return false;
> However, this would restrict Live Update support to only device
> topologies that have these flags enabled. I am not yet sure if this
> would be overly restrictive for the scenarios we care about supporting.

yes. It's a bit different from that thread in which not only require
singleton group but also need to be immutable.

> An alternative way to ensure immutability would be to block adding
> devices at probe time. i.e. Fail pci_device_group() if the device being
> added has liveupdate_incoming=3DTrue, or if the group already contains a
> device with liveupdate_{incoming,outgoing}=3DTrue. We would still need th=
e
> check in pci_liveupdate_preserve() to pretect against setting
> liveupdate_outgoing=3DTrue on a device in a multi-device group.

this looks good to me. But you'll disallow hotplug-in during liveupdate.
not sure about if any decision w.r.t. hotplug. is it acceptable?

BTW. A question not specific to this patch. If failure happens after
executing kexec, is there any chance to fallback to the prior kernel?

Regards,
Yi Liu
