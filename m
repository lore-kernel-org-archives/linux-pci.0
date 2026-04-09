Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079B3603EE;
	Thu,  9 Apr 2026 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719837; cv=fail; b=Z8x8VcAXuhjy9DhDKs8GthmoSyUOHMEF8jr/4a0ocispcFuFQbT1dyA/FO8KPb0w8TegglzmuI8q0+I3k39nUXCcH1aEi5LX0SZaOSqaU50xuYNJ7Kh+XehpVx27oEezfs8QaNeSCrtyqPh9PDTRZy78P9MjzghBU8t4ZQeHnXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719837; c=relaxed/simple;
	bh=4mbHlVYmTL+oc+Lgoslhz1g5AmkWvPJRFIi2O3Vygb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EzX5RKD4EQiNYKfCQBGV8ojxWkRxxYRDOyx2xhH+NxeFcteY5PduuRHL4uchn9/RHWXxwuW8s1r00tdaYKTMYDoc5bPLj3yUQpiOfYsHgPOj/IG54emsP/00iKFT1u2FUdc1NaUHHvYq00grQq9M1B64rsBf0gf86/77/TVYuAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKYRpXLP; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKYRpXLP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775719836; x=1807255836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4mbHlVYmTL+oc+Lgoslhz1g5AmkWvPJRFIi2O3Vygb0=;
  b=UKYRpXLPGtxLs/+9cnqUDwU06xDCZFZZL0/kszuTJDcOGganVmx8rXlj
   ZTc6dSPuSFSdml3EWJUqa5s0sox8qF+KSLccp+59ePvSHDRXYoCFS7xzO
   Zba8JQjy6C4rtYx92sJ88vBbJ1kH52YB2IF2qMr+adk/nR3itgUI8RzbZ
   W3pVLXY7WEuknwiaNORnWDtHKlX4HJzDuVhvfInrMYBs8u657Ea/r08Sb
   PYR9CuFqy71vykLFD0npPRG2s88OA/xjW3LCUmqVXXTqPQWpllN4CGRCZ
   PCj7dXmetMB7vfOs99Op8KeQHbMXHIUmvWdH/GJ3A8H2n+Ah9cVzBwzdM
   Q==;
X-CSE-ConnectionGUID: 9wIwps+QST+zAP9zCryufQ==
X-CSE-MsgGUID: SrxuvtyhSvSFHT8wuAfXRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="99343976"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="99343976"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:30:36 -0700
X-CSE-ConnectionGUID: kcQ2+hINSfmvg/1yXsT7LQ==
X-CSE-MsgGUID: vXJldON9R4qIEtTbZgsDXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="227695907"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:30:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:30:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 00:30:34 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:30:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlY/VqJ5KolNbrp1MhMCEU5AsjONMCATeEMF2tLVVlXgNsskB1xDdrJnXNFgYY13/W5DquNbw14riXPeKK9WS7g7wJmcPzu7dzNY0eUYltWR5+QlRybdHLE2c4kdLVDUStpufhY6PcXXxya6WR582D96NOnyqLEqmqO5EMjRJkTQEncEL3XtzBpztUe/WzLAWA0uAn/nov48/McnxjrnqbwloqC3m3O/nx23fyrKAeS5BA+RL7mluef5rJSkdeQiPFHZWNqbCwojUF0IA2kdtjLJPWz3GZ9jRPwDVIFvL54LPbbGUIpwG3JKhku0HJJS5ltmyXYpwGX42x2HtOprPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mbHlVYmTL+oc+Lgoslhz1g5AmkWvPJRFIi2O3Vygb0=;
 b=lGz5TE9IJHlrgOot5b7cYyRP9f1dxnT25NdR0cVMeEny5N679FMfMW8t4wk3Im+DTmDNK6nERWC2RfYHZYCZQuslk6hTTd1MhnvhLnwdRjpaYUWM4Kwr0l09h/AvUzlk9T1bcLFjtvlI1H6KjBvhpLvjH8/Ka/0b+UCcg9xv/EoCwClHOXW+ld8JlYnj0x1AqESWxt+ljn9YQG0JCMF/6h2PW24rtdzw7ujG3KnZzsKYUpTTwSlj413rjbBfka3mO2otRMf066b2OMjJWkHYO8O5ffBOncpBMNR02N8Uu6lquNtCCN2U/J1F0Ow9odJ6R0eC3v/uX117lFAbP61jnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8739.namprd11.prod.outlook.com (2603:10b6:8:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 07:30:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 07:30:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 21/31] x86/virt/tdx: Add SEAMCALL wrappers for trusted
 IOMMU setup and clear
Thread-Topic: [PATCH v2 21/31] x86/virt/tdx: Add SEAMCALL wrappers for trusted
 IOMMU setup and clear
Thread-Index: AQHcvgg9v3vLgOhujkaPMrNDoIqGrrXWZweg
Date: Thu, 9 Apr 2026 07:30:32 +0000
Message-ID: <BN9PR11MB52765F4804B8E2223BBB0B1F8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-22-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-22-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8739:EE_
x-ms-office365-filtering-correlation-id: 71b74661-a1c7-4032-bb12-08de9609e20a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info: eObAxFnZOh0SY+jxfKx82lY8j5E67i2AoHkMHQKpWqTlTNC4cwvslSlyVjhyF9a1f+vM33xCUg/ft9ixvTpe/y/MkIn4BuuvUNyEwhWE2zjKstqxI5AbZedQcx5IwGlgemL7GGaen/vOQTM0flnI38DLQPgiihTrRSt8+6L4Bkb5KCjvwGQG+yejedhhHchaBNCtEMm8mh5c9KnNT3YbXq7hN6AOx0uMLIFJJ0KVRTT5R90VZqTHMn9IiwZJMH9dKMwV7iBQ/slVt5niqR8DdTCqZTuktY6XguYgGa6dAv6hsm+eYuauZp3cpZmWMkqsivm7QWtGEV7YH6i1rdsIBUiNzklKbRZXdE1iTS95vPQEU5tQuPTWRkX+rl39L+Fx/QRlYWCqlG2tY93EwUq5jKu5+uQahndZJVbXayzOm/myeOCx+zT5w05T4dv4uxSPlSko5GYbrwjYNc4Z8ZHhulSp8jly6fiwouqvVlSEltNLwPjbsuTDwEC7o2TsrXyHVNUlMs7O/ltC4gTj2lDTVw8/l05kEO52E+h3pqS6SRW8ukFdMvb8D41lBwOaD/bkWFLT1eKwtDqZ6xNbwYr2FPbblKePGjFofMztqSkkrAIo07zVhdhyQbofvR9OihtCrJWc8JP7YLeygcOb85hCi/lPvOGPviaxtW3AxEW6OYBTlRaTb+wShhpFAIIOcTMzBGHrthucDZz7lIszinpq50+UiJUEQPJEV1/RoJBV7+qDT/Tdxhvy2fivhQM8eeqlrKfXe4wTPYL5SG1dngCOQESd1zm7MOvfoaXxOJf+5RA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yXbcRgxhxmc/LA2ek/UzvPNFjGBnLIb4ofrOO0QQuCulAcertgb94belnQIE?=
 =?us-ascii?Q?potwSfc5F6phURPFWsJEtPIl4h9dIu+0ZW5mzsLOCrzBGzwdhW6KRIVeYDLp?=
 =?us-ascii?Q?RoNp23GNxweltTTDUnrDu/LZ6UrAcUWid/kMDOnz+djaa69vSPe4sYjG3qih?=
 =?us-ascii?Q?OU2FKf+7MmYobUH3phVBiUuCFra3hYT25APOz5p9MfFDrJcn775Ne9zsGkQZ?=
 =?us-ascii?Q?C/Lv1S7ewGOhqAzp/mQU6IvjvoaPaVsIVTzvVIas8NGoFEOORgFW6Cd9wOQ/?=
 =?us-ascii?Q?Eqbp7Nt4O9jlg1gU9+FADmkQyrh0TSYvgPDojC8hWkZfFn5qS37Kr100U8+T?=
 =?us-ascii?Q?yZc4Ao6nY07ka5+AqBB1GtYheYIjgFPTrPYh0u9vuFYRLxXieq9hfHoA5ArI?=
 =?us-ascii?Q?6YcddhUsJgdAkxNvwMF8MDKb67nFMpcfbl1QfZ1tPYnVDyrY6fFSFAjNyBKP?=
 =?us-ascii?Q?3uBxqMHn4ouNcYAYrU46fAmdqqdfVWAjGXtxxmRoQ1BsNCfYXPcxSRQ4FtkW?=
 =?us-ascii?Q?2ymoH06XsGcWg1qRysEqipdFJfSarWvDXNuna8jQOoghmbLuvaqrGffeayEF?=
 =?us-ascii?Q?Jtouo4TzOHArYf0u3EfTzodkIlYXd+mahvAC6s11Xky+84cRyR5Lwctk2wkz?=
 =?us-ascii?Q?plABWUhsUclnJPUU9RMAQUoIFLgIU0qffXieY6fIN+gA0OlBzrDyq0YR3FdK?=
 =?us-ascii?Q?eu+IuvfY2pten3zKL36Ys9sPRFqpq1YE+ywaRXp7cUTfvO44CZsLa9Uan6+9?=
 =?us-ascii?Q?78x/bHuWcIUdLRSSB4VAFe9uJSSwfw4RTTYgXd7mZEa9Lc1MYumO3fBq9NOU?=
 =?us-ascii?Q?/2eh3iZOV6ZXpP7kCUTGE5WWSLU3yH52exzVyT3GAOkxb9j0yb9hZb92Lsvb?=
 =?us-ascii?Q?ULFEbP7b0WVufVJZj8JiHkCBNiHnraO3C5q/rxzGmpocvHRqMf05KYWSk4PL?=
 =?us-ascii?Q?CnvfSYFpSk0dC8Gw4QjEum9Dtg5YTlrN5T5ceH7mK45IpwHtRy0ewX1M5EZb?=
 =?us-ascii?Q?2SfxWtgXy231SpIukVJzzXW4aeyAGp1Yi/gM4gIkko9TztD48oBNLXv+2/Xl?=
 =?us-ascii?Q?jmbpOxk/mKLohmGX5vxEuer8LcPeTiVFpOEZxp0dnCRMvm3KemGGDhKu/s/H?=
 =?us-ascii?Q?AjpL/felXm5vLLOpck4JULTpgDPSQs0/Lrf3vftfZQATt0Jv/Y4fm3vLD8yB?=
 =?us-ascii?Q?QUs5Pej0N59rs/4/Kq2FnrRTwxGgox5P9sz/xvq6ynD++Z6uEaomCJDoc0oT?=
 =?us-ascii?Q?N++GBlLJ3mhg3mKpzmcm6ejFg4k3sIV1cXGf3teQzz04wQXhUmscLrSvlTQs?=
 =?us-ascii?Q?HkRiKxESsb8k8LDNQqRtk5YpdhW1hSx4OZ1UcurYYDt8FFyyJy5vKyYNOIfp?=
 =?us-ascii?Q?YAHyapGFRuDmML1/ljMcf2FmWstjS6G0fy/ZDUbY9bB2g94G4oJg3vQpw7f7?=
 =?us-ascii?Q?VARPMZLL4cOPh4x63dR6FgEyy78k1E+Z33vTHYXp98PcGQxzSAKEwoWAmv9E?=
 =?us-ascii?Q?PPVbEXIfAk/mJf5hK2EgIc82k1xupjbZSAw4qKMlxPfG/CPLcdEYUJuaugMA?=
 =?us-ascii?Q?gzEH6DBhq5hxkmZDIJlWnvahx9Q9bMJ0D54js/9bUF8ND8LoFYClTep177AG?=
 =?us-ascii?Q?Ou9RkDLdHGcpJxqAXE4zdR9iHgTGGnPLZq1tcbu78/vBSDg3z6iYVq2O2smX?=
 =?us-ascii?Q?mfN3DigNhqtvjxgDWT42iY02mS3dF10WtsCAUpp8aHNXSm/bxYONKGXapUbo?=
 =?us-ascii?Q?QVjTkqYZEw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FrYS7JkgamkNOgOkO8LLU+qwaX2PDcGCHBDV6KJKgF85tlju4LejDSa+glvziZPQbp8m+FHQnP//wAlTvuxMYStgduLzOZgFmyydVPrRgn5q2292jD00MQ3wqrJL96sCRYDlqOOqIFNVJ1qhEO6Q2NQhoQ38lk7L6DsVmL+uJDOiTIEkC6ub7lAxsrjBA11aRqJi3XryM8ef8BtzJafXVMMnPiDzhXwLbsVc49/ANxCsBQue4tJqL/I2ifelXeFXLarvTxtjRlajtd42ri3vA6Daoou2T9rlzmV8ElyXlhNhsMM6X7G4xUdavl4JZQIyzD8FJIb5kVS6nIMKOEgvyA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b74661-a1c7-4032-bb12-08de9609e20a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 07:30:32.4006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqQTlSCJnwTjk0Df+o7tAQP6Y/eqSkKwcMS6DzFyeOsyMD3KvsB5iCG3Lfm71/6Ev7vonPOavfNrX9FoCWeKhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8739
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Saturday, March 28, 2026 12:01 AM
>=20
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
>=20
> Add SEAMCALLs to setup/clear trusted IOMMU for TDX Connect.

what is 'trusted IOMMU'? a new hardware, or some sensitive resource in
the IOMMU which is only visible to TDX module?

If the latter it's clearer to say "trusted configuration in IOMMU".

>=20
> Enable TEE I/O support for a target device requires to setup trusted IOMM=
U
> for the related IOMMU device first, even only for enabling physical secur=
e
> links like SPDM/IDE.

this series is just about SPDM/IDE. then the first part about TEE I/O is no=
t
really relevant.

>=20
> TDH.IOMMU.SETUP takes the register base address (VTBAR) to position an
> IOMMU device, and outputs an IOMMU_ID as the trusted IOMMU identifier.
> TDH.IOMMU.CLEAR takes the IOMMU_ID to reverse the setup.

Intel IOMMU is called VT-d. It has a register block but not a PCI device so
there is no BAR resource related.

let's just call it 'reg_base'

intel-iommu driver already has its own 'id' definition for each iommu devic=
e.
It's clearer to add a prefix to this new id, e.g. tdx_iommu_id?
