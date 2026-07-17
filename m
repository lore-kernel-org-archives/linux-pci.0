Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B323D283;
	Fri, 17 Jul 2026 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275377; cv=fail; b=VY1BvpUTjU2XV1BFjLBLhVZTklF1dqKUTe3DfalKuEOIWVyvlNStLh6v1rpgxl/ysw6kJHrH+iPePfWcXVbi3cnFjedTrZ2rBWY6IOgskNZU7xUdU+fH4TBnZdq8wk4rXlgU1axmVZM4mZ8/Kmk7FfMgldtJEB5zpAN9ekveX0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275377; c=relaxed/simple;
	bh=6b4GaGDJPN7Ibzy5llPL7R67RG4KKq/jrBXYaZhAVc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X1IF+Mhx0r3VVZucwuZy/C8SglEJM0x53HUjss00KCQPLXPWV/2i3fVKlED34zm1wfy7U/s6Q0RsNWF1c05f0GW2Fc7F8gKcxKrJ6uUnFItnFRIFtNS/52y0ODAEY1xFTb5lVej9nVtx05X7iDzk8z1NGGD+PCz/3hdqafWrBHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vd6FVso3; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vd6FVso3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275377; x=1815811377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6b4GaGDJPN7Ibzy5llPL7R67RG4KKq/jrBXYaZhAVc4=;
  b=Vd6FVso3hGrCSOz5bWdMRx/wFxToev4KD0YhwddoZGX/pW/m+cRR7WY9
   0NoxYHbi/BJj8lBgW508B9n9Pdb59K6faTQQXdne+YAZhUEeaDxPeZxDG
   SylBZnXR/0r7OxKGmVixjhLsoYomRXIQ4WgbwyK+1PyLu8IOHFIHrz0nc
   s4loxvoLZME2s3qaYLvX/VYzBONWQpubJtkvtX4yNcG/jWUNoFregp9j2
   AvV6qtLFIMCcGXrLx+TbSzv6cWODeuOpWfqZyf87712ca4cbOtQwGy9z0
   8Mtx27oqvtuLHDnCj4fMqHw0/GAImi0TrMjrJbDqxMYz1xIWMaDAt4Ib5
   Q==;
X-CSE-ConnectionGUID: gNrMNOkmQhCRqw0/TKiIew==
X-CSE-MsgGUID: KuuikLcJT3SkmbtxgmbL2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="85036265"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="85036265"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:02:56 -0700
X-CSE-ConnectionGUID: x4IuHJIIRCiPdFR3jbXRGA==
X-CSE-MsgGUID: qTAq1LGARoqnWJnd5CivoA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:02:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:02:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 01:02:54 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efBfcjIwVa8Ixzo+nJuYXm1xNz+TBv98GPZN0XcjhP+kaWUcAMGnaVolOi1QANL/Qa7mp32XicLmNmwSc2P4RH0htfwNlB1SeegU1bNBdQ3VEM5kMitscn9V5VV83MrROUeYI5iAwOiNzO1ENmEAhmPpDPcNnKF/CjNF5vP4yL2z3XZI2jxP6ugCgdDti/5KgMS7Wtc9W6AiQGSYTmfXMXEUynloMGYToEnRqExJ8Ti56VcRhx1yeUhnBS1/vKLLzS4BcKem6DkMWSthfSIC7x3UPZT2Pvvsj9rMST1DhhtUBf49KCA4Qqcaob7tWELliOtazrnpHkBOdM2DN9l+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6b4GaGDJPN7Ibzy5llPL7R67RG4KKq/jrBXYaZhAVc4=;
 b=pZp5g8KyVdj0Ghf3Hf8Zqi73VpQT2QxWAwcaPlq4ruR4oI8sd5Y/dRkfdaIC5dVWHOZJs6A28fR9ztqrhgI4guXsGPeNcmH2UtLprMDMZcamkTTWBnUS7zzd6VvR5lk6tXJwVmiXWeTL5h76zsq0ALPbQuY+2cSCpiHXfitWYV6RNymUg16Dk4tEdHIv72ivwwY/xusHAwlkts16/dmseWWHxVeVuPRK92OY9/r6mF2nlW9SjpuezrNngctmy7Lc2XaSJI8jxJ1WIIKfHpzCnTALx/PeIrIOGkqJiSJoWt1yIRP89nRH7UWMDWUwvjQE9YUD9SC/QPu/rThWg/BvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 08:02:50 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb%4]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 08:02:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>, "Leon
 Romanovsky" <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro
	<amastro@fb.com>, =?iso-8859-1?Q?Christian_K=F6nig?=
	<christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, "Logan
 Gunthorpe" <logang@deltatee.com>, Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>
CC: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Sumit Semwal
	<sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, Alistair Popple
	<apopple@nvidia.com>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5 3/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Thread-Topic: [PATCH v5 3/9] vfio/pci: Add a helper to look up PFNs for
 DMABUFs
Thread-Index: AQHdFIIlGLKIeQuDPEikD8MeSNwBWrZxXCsg
Date: Fri, 17 Jul 2026 08:02:50 +0000
Message-ID: <SA2PR11MB484419C822A12DD27BCC836D8CC62@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-4-matt@ozlabs.org>
In-Reply-To: <20260715174737.15287-4-matt@ozlabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4844:EE_|BL1PR11MB5977:EE_
x-ms-office365-filtering-correlation-id: 3d1647ad-f4e0-402c-cead-08dee3d9cc3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|38070700021|10067099003|56012099006|11063799006|4143699003|921020|6133799003;
x-microsoft-antispam-message-info: Drcmlfs9HbEUU1jaTsDQyNmN/aXzGZ0+8/BOqqwRiNc8SWYJLzd6iQQdDFRRVu+t5kTJQGKL5xhsFGzLboBoAIRPSaBUPZd//3kpVom9DqwDZJlxJAqNK24PoL4SNizwLu7DEWYNHevEEVbzE7WRadas8ilXf/Ppq3amvMrBNq0nZ+P4+KspB1ogGaxR5GNSNgyMXiYoMCGrMnOExNvEPBZncuf9E+47VxPN3tppQqmIj2WUGMOCL6DDQXrBo8CeXXRnavc1OEIdxQhcfZkw4x3k3pNiVn01r9UQyRh+7vpU42irvEm9/Xs0U9Jd6ihp2xY7i1dyBqio8RrexPjBmwlzp7RXE1pjNbh0fgrNJiaX3zmoqm2Zjvsd/zqSMMqXg2qDFQzyDGQV2tHV1HLmFBRD4mijPhCf39t5sUdPLkaNDLHAmqeyxqgQzEx6gYK769U5U8kAsjvZrhsWFaWumnnFrrABBpjIKCzk0hcf8Bus9BjPuXCthJHRIV1Zq/9PpFxh8hzPe7s6d3bbmlaA+d/NQkBMwPdyxZn1/cWPc9MpvXyYoRPi218pwmxunEG2VAU/i6sdCvxZ7gPIN3GnsxqUbknG6+wVn5JkPfU7xb/BXSzivQZWAubrK+C5EM4wA30fxPKtL8gN+75Dc+829mhv4JPua35Z8CX30aJmC0aVpiD7fvZ+EBQo11h8uFSmKFofh1eNzS5Y1UKmDOzm3SfeFq8RYjYzhFyU79Cd8+1E8c3C/Z3NrXTTphobc9jY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(921020)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7AMTzr8hJvFMZmOfnOv5yJ9laiHwyQjD1rUDnmxBs3xo2ZzPW4GeGl4bv8?=
 =?iso-8859-1?Q?28pmFy2OrU8AgmLdtFjyzzIIThivx4MMPDJwJ7U7Jq/Gm9qsA6tsN7uRTe?=
 =?iso-8859-1?Q?MOtwaH+5NrVp/9dtU1H8ABbSrhxnQfzF4IK0wr3mqlrieORAnJQJ6561ob?=
 =?iso-8859-1?Q?A/uqA0NUHDZGRRIV0z498K7XBdU9aSEluhlr5rW8p1UF/OofRFMH3BUhAD?=
 =?iso-8859-1?Q?G04xJUoj0nYtuoEduqJHjhCdJed0Ra+zNURoP2r4wFLPOat9m6+vbbzTzC?=
 =?iso-8859-1?Q?RjscVt/9dL3IFzZJ9xJWISh4OexT0r7ZVK2EiweBIs8ShGFKiOTe2nJWqQ?=
 =?iso-8859-1?Q?g7Vxpv6D47tFjQsQBWKAFE18KgPt4w4QVIqxZ6JFPtl23p5ZeJCTGYzbpN?=
 =?iso-8859-1?Q?+ITC6/JvD8+8HnhMjm0dFyzGnw6egL2dBbiQ+8K7kyzDdfYpmCzWbW9q8P?=
 =?iso-8859-1?Q?8RgKHJlQtihBUh8UMuM/uS2H4oV6FmWYhv9IGAEGJWsKd+zuDV1sLrpcKH?=
 =?iso-8859-1?Q?5cIUMZasxrOE5JCv8MXcRuK/RSGB1V90LOsNk0E9o+EpNNUEXEaWtbmF/l?=
 =?iso-8859-1?Q?q7gwp5d3gZFUTJqYvgzOzAYVFCG6XXv3bc7NcPLRtIpC3tJgH7Uyr60KvE?=
 =?iso-8859-1?Q?9wsx1PG0Hg2gYrHtsG4Usz1U4tut2AAfURG2vRrfBcpq1ElAowPD59PlFW?=
 =?iso-8859-1?Q?/lUTVhZFQVrn6l7vKUPJDKmYTCgj+JxVVVImq90M+4X9YtZdu6zcMGpNRK?=
 =?iso-8859-1?Q?+/m7/KAjvnX2V0qzCDK70tlPmTW3ovFchShnnI4s5ZNiwnjh0hK2w9UQ/U?=
 =?iso-8859-1?Q?/miE/tWmvCVybq3KDZxgQn8z6mDRJ1GsiTgyDeFFjrcPOTOx63sRu6oPkA?=
 =?iso-8859-1?Q?AhiSap6kTCsxurpqtCw/aKL3ghx2Efjn0WzUrJbuTyeUIMto3ZWW1lbh+l?=
 =?iso-8859-1?Q?GnPQZEogmS1GsNXGiSjtusWiOqUYrWw3DAZR0RI+SlYaL7GpcFK5+I6Wvc?=
 =?iso-8859-1?Q?9BhbAwGtjJwX/NF6+U5PEFq4OQELCJ2rX/MLOYrioQKW/IHdUWI6HVI8ji?=
 =?iso-8859-1?Q?jm67PFo747PRJVjfNLoegZA0Ur9D6RBIAsYipRzQnXTyfmK42ANyc/mO/8?=
 =?iso-8859-1?Q?udGzF3+JjPgPUqDbmzJMeI656oeaGV2rPZhz16CYoLdiETCu9Ux/8FY1la?=
 =?iso-8859-1?Q?kZN3IzERG1mrksGZsrMRUGqFWXiVTN1XAeb3kNcIGgft0v1Odf5sX9CXrZ?=
 =?iso-8859-1?Q?s/uoq+kwYzYu1ljc1lETvWTSxknDZSRMNOJoCxKHPZzlQlIVABn+wyDU9/?=
 =?iso-8859-1?Q?mu0Q1TVwRu7u+DhBTgc3+a3+nr8uqmzAE7RD5UO2lhu1399FURJUMX9vR+?=
 =?iso-8859-1?Q?nDm3NYdv+/9LWnDu+r98IiUr3vIys8q9mUibS3Pobksz/GUPAHTSCrHM3W?=
 =?iso-8859-1?Q?6LO3iiVoADp/3jHUv6FOtPBMUygpxIMALr/y4tLI1cdFbS1+be4CUUKz1e?=
 =?iso-8859-1?Q?DO0B/+DOEx8F6MHiZP7jToN2HSUosCRfeFDn0+Sc3tk7QjC2fewUwY1oM3?=
 =?iso-8859-1?Q?AhKjx8ZbxtViPaMhRQsJ701W2CaO+DXp63KPVX/8MqHIOtIt75UHBXzfY5?=
 =?iso-8859-1?Q?0ARQCvRdPBn4+rjlcwqaNqZbhe5t4+SKcJjmHYtQUBOmBBzI+ZtnAdKCtx?=
 =?iso-8859-1?Q?kXPDwK8Ti5v0n63WiYGS7oG7/HLF+bYVbrFPJ513niRpUhsvN29oJWjKxS?=
 =?iso-8859-1?Q?rh7jWdnQy8NRdr4cpherIDs2TtsBDMhKujpNoHuj8QNV71?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rCAyp6U7FRZ3JL8ZZs68Ae9/Pqt4TEqgvSfgywvxDEb+NWJ2FKKGJvmufZQCiJXFCv9pQc/38oX+Px6bsbsKrT3jgfOc1e+zMPX/fcnmgZKFnJa68RfJErO5cNMzYoC5Ph8uERNH/68UW9n7+Z2TbE18RpiVU5XurEAOv4H4ot5oPxyby4wnfJzFkNfbVy1cmnZG8Q7wOVH401TN/BNOQc+E+vAc/ZgwRTbpRNL1Lzh3Wy5vBxoiCFuasTcVsh1VDZixqusjGz8HnO3nVXply/Sz2VXZIzLNNUS2gnHjRWLOlZ0xSFAeeE85GCPOmCKVSpAM4CSP1CxO4C3RPdwqUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1647ad-f4e0-402c-cead-08dee3d9cc3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:02:50.7167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PlToFZU3HQLvNGWk4t0C2hH2/0QWXPiT9nna3NuhH2tWcIeZFryUnDJxWWDltEnbgtcHYDzLM0HlWf3Gdv6bwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com

> From: Matt Evans <matt@ozlabs.org>
> Sent: Thursday, July 16, 2026 1:47 AM
>=20
> Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
> find a PFN.
>=20
> This supports multi-range DMABUFs, which typically would be used to
> represent scattered spans but might even represent overlapping or
> aliasing spans of PFNs.
>=20
> Because this is intended to be used in vfio_pci_core.c, we also need
> to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
