Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDFB387588;
	Thu,  9 Apr 2026 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721121; cv=fail; b=fbSmxLAMEMBUGM918R/uO8yO2okvxm6RET0429wuwZ0BvhMux279+0FCtv0ymx9YQPDnusxK6FpAlVGKLFikZTUzEktwCdYgu+tBOQ2GaUWn4V82LwizUyeFMJavchDLRnACQy99ALlOloZHjyYfLUBFrVzig/3emqU457NnGwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721121; c=relaxed/simple;
	bh=AlMmBqKEVhIBJYxvHPyDfajyya15kA74Ikja1e9SzvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QLTvbmEt2m1rWD/xXd7cHu3T0rqGZlLRe/tLr89N9d25d8jXXtuFILUxOdrXAEoH+iu4XNOfbj1ENpWM1EKF9eoZhREgbqoRpFOMe2fH3lfjfMMmiJ2f8ayInYa+ziXfO0REoH/2fgHaBNYFs4y5wj0UOeFnCBpVElqHjTNUvkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRik76UT; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRik76UT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775721120; x=1807257120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AlMmBqKEVhIBJYxvHPyDfajyya15kA74Ikja1e9SzvU=;
  b=VRik76UTq1mI8V6gNk8DgUNQnZsGc6SXSU3oKwk9MnSekf6zvqOD5VGp
   pjbjCsM688E+wJsaRBPeg9RcTHCAOFKQ6zNxeyzLCwwC6Atl+s9fGXvoP
   esfYqHV6uM/kK3pBpFrVnWwdxxDTiwbKIHCnYnylvLQ2CIa45WIGXhvrO
   j7BTr6CihucpZd9Jta7cLy5Kxl98oUv3RQrV2vxktgjxhE4B+/jyVNRgz
   lkQVTCG49+hQpGu2vrvWT1fIJdoDDwd3FNg8KAWH3eEs4ZhPGqcVtWcOV
   LXQUvcTNjZXnmKSi1BXPFMgUqXsALnl7ADoyj/lVpsHu00mmkzC4D6u6W
   A==;
X-CSE-ConnectionGUID: NkYWPJX5SDSCDJFM1wiPyA==
X-CSE-MsgGUID: P1heQyyDS3q5oIM+ZtJUYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76840011"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76840011"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:52:00 -0700
X-CSE-ConnectionGUID: d5cqx/BWTIuFpUkPvY/QAA==
X-CSE-MsgGUID: nJIWhRXJSlW0+VLRUgXcKg==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:52:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:51:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 00:51:58 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:51:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2u6f6PU5TDUKIdJW5Ispgi0MWLG0OFisTWMDG2qtjnxVMgsw/vCpglv9Yt9m5e7ctTjLgjAdUA73aC8tFGw8JzkRXIfiCFPNRf8GYGOTRgogyA8OSsTHsMcNpFVtsKtf75nlP+CEkzUalgsonJcBjRWT3oDv5LZ0BW8MUu26nLXQ2KG+W8F4LjpkMNYlo4FnIKU0I/VqxLuK41+rwKAgq8J8qqbEZPHWB9eqxsu1yv9UcQm0bxeQoMoYkKPD6+siDlKOE5BSn9yFqJi6gY1LkX0uezrfmw+8Ivnob4RYXJ14qS0fOwude1cDYpdTRlpKhnCv9mxQk3fDT/KIMnj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlMmBqKEVhIBJYxvHPyDfajyya15kA74Ikja1e9SzvU=;
 b=McJaJ+vsYEdq/FdCw67CPI6/XSBeIg7NKmAksIhLXV16CBOAz4sJVchmwMjqnN6aGJQS9xPoMjSvsCsdtG7ypmn41XZURBgWqjEbN8ygkoW2gJuqTFIsFLt31UEWmSb9NcZhm9n8jG1nROqSxXPqiswFJXeiRhmv3rir2szP5zV3nNkRqib7jdYOA53Jjkr6SEDBfwaj2pRx0OZfjUwyT/knwCHXi8RrOpqovi2Np/RBE546fw+hHBLmSaJcEfioXoTYBIWVAKmfbX2KggXi2VVfWm1bZ0AQOiHNvtGW4LvxTlxYV5xOdLCLLQrd709EtNRocEpEdfMM9YKQyJUFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 07:51:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 07:51:56 +0000
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
Subject: RE: [PATCH v2 23/31] coco/tdx-host: Setup all trusted IOMMUs on TDX
 Connect init
Thread-Topic: [PATCH v2 23/31] coco/tdx-host: Setup all trusted IOMMUs on TDX
 Connect init
Thread-Index: AQHcvgi+gONkkSAccEKfTKJuTlAsIrXWbxDA
Date: Thu, 9 Apr 2026 07:51:56 +0000
Message-ID: <BN9PR11MB527640A3D76B66DCE5FFA58C8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-24-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-24-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6541:EE_
x-ms-office365-filtering-correlation-id: e7acefce-fb14-411a-0b5b-08de960cdfa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: /gD6mmBV4SnZ9tEyqlNQVmoB3z6XYrtjSf1KcPXEuV5FKNOsuendZwX/Jp8I+Dhf0iQkt3cpTFfHe6LwGnM7gjZAIRvOwpF4dvcfiYU5gqXkyOdMCpl3SVgunyKtLnyEdRpLla7s10cqP100uo5FcYYBSSzID7zfR9w2KUEh7ib7FaH0hWqv25Ot9FcltHVqz0nfM1loLFSsz0GQOLkbvFNmKzAP40c7El54jqMO5npgDREVcj1CqKDsPApPnfLvtIY4M0I3drT6oU1rVJXvO1kIkPhBbLgsLEuX/rwJ3/Qf9kQqzddesX6LJKx0FHt5kLc6Lwp0hwW/9wE4UTAPVYp/L6gWAXmHmaN4WlWjjYGlcnxVBPQ3+WuynN0dv/9OaccM5bkiTIroif0jb5iH7aQZjRxPNHH4TqzpwkJ2MmEaUFKJ41CnQ1vssLtMzBN2iYAVTk0q1JXYXMLmf4pWdTsWWmGxKbZvTd4Pi24P3SMwoWh9p0uW8i/6mp4aRgZkVRc6jZZWjvkkCkNvnkJwgGx6v8ef2ETbBa7aT6Y2YxPxJxNIfND+0eS9ifl9VNbK6NOm9SvJ0MF9o5AdEumH1ppjCoDzY/YKPcWHsr3qXOdZNN1hGx5YB1AajnqceVPbhPEGfCnrWM1oNoxP4lutU0lUXv8F8a55VpYLfJF9kxHiet0WUn1HwDm8dsAnam+H8+ykrrEshSqPtRMzfG4hCKcrlVzi4OFaZrperREnPVLbGX6Y6EMoB0MhmqUekNlSbrRSAadMt+EuGSGCjcNjFSWIpViWExRKy2aJS1uRc0U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zaTr/XKzCFk4lX48g/1lVnDGN+vn8XuO6O6EitBAKODHmsAI7Ej47bx9NXxd?=
 =?us-ascii?Q?vsCAObQgJjbPwoNpIJhsHCW4C0wwbR1kOWMWVyluWzC+w7xsiLcTql1FYCB/?=
 =?us-ascii?Q?Szia2MQOmw7FrdbdjUEKhRC/p6Q4nG0A/2StE7nXHJJLl0OUQIKlYAMHw21M?=
 =?us-ascii?Q?IUlTMr4dDLGU4VMbcFVnWwEL/nkeeoStnsl1Orce5y3PCqORw5MVZOZTZTp/?=
 =?us-ascii?Q?ETo+eBpSAmG8M2CQ4Ja19bSwnTmkO67WNjKwAFrOqvs/spxw9IHs+Tn6eRYQ?=
 =?us-ascii?Q?xiM/U/XyyCAe2QrcnBrG2hvg9/3oxGpVaongJUcizOLyv1XOf0xoW2ukhwY9?=
 =?us-ascii?Q?iHBUiBV1C8wj8s9nfyX9oppnsFxCJGVYoZTeZTt6NyxOdMNGnPyfHmKPb6Vk?=
 =?us-ascii?Q?J2qqsZpfo08dwe8qxjMj1f2DEozS8+r8XtLf+nrnH9M2cIwhrCPccgsNxOZZ?=
 =?us-ascii?Q?p2ppn/KT5CCKs3zYe2VzsjGmZdBXy9kFfg93P0x0NoMRCZqee72F94Xav7T/?=
 =?us-ascii?Q?ClRGsvVZJ8R8nSxWeJO3UrJtasV0AIoKwUm+ld4uZVlP/vyhbY1eKTjnqdKy?=
 =?us-ascii?Q?oZRq2uQsEC8KRtUm686rgriHZDWAvOdnmuzbcKKcGxb2UV+bpzudiN3zkfqP?=
 =?us-ascii?Q?z/Vm0D6Iy2WbtSJCfXudtznd3S4BinMy3Oaru3ZLuxN3DIrUNYU55xwbpXeG?=
 =?us-ascii?Q?C71QXVz4Wd7ooincYvPg3OWMiHgYugM0RFmRAQewgmpJhT9HoVewvAMu7Vae?=
 =?us-ascii?Q?np69q2NiF/k+AkJWJotMwt9sFfXOhBPhFbBVbu/xtJIZEdwOMlAz8p+EQ1Ki?=
 =?us-ascii?Q?1NBAOI6YM2df8e0u5gil6H4HOs50cvlxxIPG8A67ChkjLtLL9gSh8lux03Z6?=
 =?us-ascii?Q?lmrGV2Fx5jvmhtHd5Mju+y0f5l1Lczl+4SzSasTAfHWPA5O+rMUT3AUNYIXN?=
 =?us-ascii?Q?bbNsg7yNpMfqZ49YMau4Wcy20vYcPhgUECAbIwJhTccdeQE7rzZPHMJWdrzx?=
 =?us-ascii?Q?nkxDuTrj0dIq/T+WPz0/E/feDsHLaF+Vm3CKZxD7oKj/bP8RdRaoAOGh5mD1?=
 =?us-ascii?Q?6B5uvLaqOwnamK3AdQ8pNKB5rVOLsCoNYkv3jGu5PDDeC+gU8LAgX/dOA5Kv?=
 =?us-ascii?Q?2ryClGb/7tBEhQolCvn73slaCObCPOS98srcfsnIiK8Ir69Pg7wIKIj0fe3A?=
 =?us-ascii?Q?rYpn52wojKSkTAKvQRwFyXAT9U7SM2mkVqgiDBJBkJmb1Rrc3SlOwwVWosul?=
 =?us-ascii?Q?6xAgRmmmSoSS9PMWzTxGI2Yus4mUH391nedaomIgyJwwmIVpcMZLOG+WVghf?=
 =?us-ascii?Q?Xzl2uDxWHBY76Y0yJ5xULN82jyPTXVpBBKnTPOBejHBHi8TJCjPFMW5IN710?=
 =?us-ascii?Q?do+291wmFNnQfJ8qW3lvSobstzYNuIRzRUvbywrn0IgRPtqBsgvWjq5/8LtW?=
 =?us-ascii?Q?WaWdW7PgfxBo9ejAJVRB96SgEukA0PAY86Sq68I5Gmz6HG1eLtk+eqrYLWLh?=
 =?us-ascii?Q?y317syW/avpD2NPqdwpSrmWCvk1I/5jeKzpD/kiUGgAUy/DJf78YVS5GY55X?=
 =?us-ascii?Q?BPclTWEGFdyv+996gZnEN63BtFxCZJsCY4MI9A03BJVazrMD0GozMYIBOboJ?=
 =?us-ascii?Q?lcwTmnOaLWOXTtNwLlow2TE4uV1kY9+jUUy41hJovz5E+VB1+VpqXYyFAswl?=
 =?us-ascii?Q?75KFp/G46jDDoev2QAGMxciX7dinPU+pWtEy5NsPofOoQDq/N3DiEOLtOZPI?=
 =?us-ascii?Q?gdBmyGVTZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CMrmwgvKvLjrtJbFKQbTgBrzNbbVp0JP1SLZa1EMvyzn8+Ofx1NofHjtY4sIUZt7yDZO3csjlew93NUKVt2XasEZ4YMTvW5RcQC8TrAlnVAa12iw0oznlwRl6LJ5bcgvOp8gsXPBHN/aUY6F/c2jVNg6Kd/T3Eiifltl/JR82dLbx3nDEQFHZnAH2L9XIAXJeOutpqKrcmSMKnPuenvTgKOC5M7auEsudaux1+KF4xpVd/qnJBtWDBrpDIp8aoWFf9Gk4XOorFKfQQ3FmTwFHgmfTQVZ7CJuBvMMTE0BoKWEaviiXlnPu6OWA1QLV+cGCjynPZuQ92pcyXlPUzqJ/w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7acefce-fb14-411a-0b5b-08de960cdfa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 07:51:56.8976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4qQz7sygaleNu4lGAF64k6rTlFnOsbwI2vanB4fm3lmo/TVJ742E2FXjBxQd20bbGkvlcmf8uc7AbCww+xTwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Saturday, March 28, 2026 12:01 AM
>=20
> Setup all trusted IOMMUs on TDX Connect initialization and clear all on
> TDX Connect removal.
>=20
> Trusted IOMMU setup is the pre-condition for all following TDX Connect
> operations such as SPDM/IDE setup. It is more of a platform
> configuration than a standalone IOMMU configuration, so put the
> implementation in tdx-host driver.
>=20

not sure what above tries to tell. why is it a platform configuration
when you have seamcalls on each IOMMU?
