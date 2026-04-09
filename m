Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC1234C815;
	Thu,  9 Apr 2026 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721760; cv=fail; b=H9xX/ywDjze98Fm9cPp/k2lhpklXEoc3AoW2rvi3Wq8yv/sMjiJKju4ZL9ELFlh9VXMmzODJyFlhMGSnzLcG2RIsQt/drw5iTksMI9CP4eRnnB8qi4Tc7I2W+/wyW1a0+I+m5qxdVxUvydLrNhKKE5slBlbizYsFmWWwUp9Hi70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721760; c=relaxed/simple;
	bh=WHf5GfXY/DecEV00k9XowZoMzY28r1ddUuw6J6/to/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Apgud6VUrIqqDkyOiKx064wRVfjHXy6R0d26PyjiPN2KLCU4I+xNUHvtnekxCMSC2VlmoATXD17/bIdfTbWuvyITX8yTimrCoOdw+WNHbHEC32xeB83xXV4Xa9ue15D1TmbrIp9QHGyb5P1Mp8xKjHbkemDIMF/5eUsZg8Ty0mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LI8fowA8; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LI8fowA8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775721759; x=1807257759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WHf5GfXY/DecEV00k9XowZoMzY28r1ddUuw6J6/to/c=;
  b=LI8fowA8K2uQQvhn6ZYC1cwu6LCz60tawVhArU60VSjISjOs+z8GGE4I
   jyVDTnmpzzSawIjk+4SGXFm5GoVWChsOssAj/gdaTgM8SjueIRt1evTub
   Upk5NuzmglDHet4tilompOOwf+SW15sBVGS9PJ3davXbwVSGYsmloDvj/
   48Poif0OPLJQtdZohXNqmYX/ISdI4HS8elmsPVQxatNnEH8kMFZpQkz0/
   AoUzGby0NIvQIZtYGrZ51JQ1GyDmqYV0wPKN5aPhPnlM416Sdtx5Mnxp6
   t5mPv7SgCIcqchk0DlP2RRibk5iwmmatQuC+GBJSSPdr2wMe0JwVbsVQc
   Q==;
X-CSE-ConnectionGUID: VHGqqoacTpecMex9/nvhZQ==
X-CSE-MsgGUID: PnuMMrIIQV6ZAIh0H+srTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75891868"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="75891868"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 01:02:38 -0700
X-CSE-ConnectionGUID: a6FKUOiQQiOiZ3bPJeFG8g==
X-CSE-MsgGUID: cTM6SbZVRCOuPDr9tYyIcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="233681326"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 01:02:38 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 01:02:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 01:02:37 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 01:02:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQ0FeNmGEpFBxxlWy+VP1QV8zZ9Yp+yGWobAtX9ItHE5nQhsIm1do39x1P/L+0FW/xJAJ5PKlA2++aVuJBGA2zoIUlnkoOTEGTuXSXrDaLRez8zp83DrDIymlrnn57MngLKzmeWJTcFuGlb2ZsSNpKd1iYkiqtseCukkAPtWC/Ry4krAtDdGlAd6kR7ggp8YMZ33Z95JQ1o6Xj/WMn543hzu8rpMgfAiMVuxPTowlldALCuiJBnPNOrl6LEEsaE3QiYhO0gQwMu+m3VNa8Bm4nGlKm35FYVnB50p0iHkAGE9ErKwWK6gBiSHg/6NCyNnutQJ23pK0ReHeMNKJbqwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHf5GfXY/DecEV00k9XowZoMzY28r1ddUuw6J6/to/c=;
 b=UeB6tmdlx6QEugKCZyEkvoycFoShsHAK4e2KTh0bvZWMZrWyj80Fvn2tlDCC05lcC8MoZ+Shv50Rh0sjpsP5BJWBW9eIDRNqIKkhzeCS/FQ4XOtDYcM/Lx7s10K6F5DpEvR8n4Lo/0EBVZ5jKmottGLBuv2jd8PN+WDaEZom87HLlAyh08rypWeqPAnpau1PyUD8bc54HI2qoI95rDM+3hAHoN0UT6jO+AIFriTscXJh7hfmpJSvNUFTva7+9yc70gYhuTrRikHZO/TTP6KSZrLqAZqpPl7zE232pTJb3f6TyzaLxg9dRtVO6mAGlPAPbdHpGkDZNJ5IdSn0zvJTqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB9526.namprd11.prod.outlook.com (2603:10b6:806:4c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.45; Thu, 9 Apr
 2026 08:02:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 08:02:33 +0000
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
Subject: RE: [PATCH v2 30/31] coco/tdx-host: Implement IDE stream
 setup/teardown
Thread-Topic: [PATCH v2 30/31] coco/tdx-host: Implement IDE stream
 setup/teardown
Thread-Index: AQHcvgjvogdHY05lsU6Z4jsx8YF/y7XWckKQ
Date: Thu, 9 Apr 2026 08:02:33 +0000
Message-ID: <BN9PR11MB5276BB48433E1AF97E5D27298C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-31-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-31-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB9526:EE_
x-ms-office365-filtering-correlation-id: 7944430d-1223-4dbc-b9ab-08de960e5b49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: o64JEsKOUq2uAl9vgkgQPtjLAB84Pzoe+EWxtZ8xufhkEBregDTssgBBU9W8YE161rlRYKJLTMJGR+f4FRi+cqMyrK28sDFcDwZNhKgz6Zz46G9BzcIwiIUS7OdUVNp8WfBe8xQIR7W+e2tguR8OilhpwCYBNM1HncnsDKtQrP+0SbzvJv47Y0RkeOEGFMa5ZtCElwlr8U3ZKdVw7+AK8Rqi0ScBeLDszPV0r6FFlBNui9cBKJ4tlwPj47IUKRaIHJSpdVXRSk5dCun+YfB4lL0/+QsWCuBC7GDaDfTC2mLJXDXqukllyM9jXlkj+/BD0BpA8ArvWrw9MVEvzFYiUppnh8lj1IRi9wQuxlB5fkebHUzqXzOWfvPnxRv7m0XRIMrxJ4NQ6ahI+h4frE/MaCtwvYDXtRGRN3saByGrhCQvGok8yR9l71bDQI0iCiPoM+GQC2KdhuwIaTiikLjKUSDwQ71HSzisvjUpU4CAfOalcjZRIzr2xqm0VUJJ2x8wf7hJLPQ9S74GU6Y0vpeEgdB7Sa9rnuHsfBQvi4QvgvEu2Wg8VvNn+CJZhBtUJMz1+6ztZBZN250x2Q9nty59BoZxYNjwc8mmvm5p9M/+YOwhCaQvnkXRUGjVfgSyPY7hmQb+r1Hjd+yu1oJeQAMj1z4EiqDj4xLp9Dz4VwTItv/g3tJY+5tDHh2eH9aT90jDYbOB3opdDfLHEBNlPtEqLH7LzRKpGEilPnDwzBRFPG6QU4qlc29KfF4bNAgHXNwZ2oqzwwhHOsxXAzs3tUBK+Wm30Zd2jEHv8sykFlT02iU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b7T6H2jGdrRNDNKk5CmliHpdvI/RhdO42oM6E0UZQbP87Q5dkLKJLOeXHrJ/?=
 =?us-ascii?Q?TwHhjlMKdi2k9nj0xvlC2F8K2wD8GnzKgHzIYuObS4+hcuKLcX+dj/YTuLMF?=
 =?us-ascii?Q?5/zudAKILxqkVsV0m3RAKQTCjzwe0OHTlrBnS/u6SzJ2rYHX3EWlH23EJPNd?=
 =?us-ascii?Q?LBDn0aCZN3PjlaG5e0ZvKVqTTATl8XIkFOFbuS/pTcrRzM7gZamDeOYGG48c?=
 =?us-ascii?Q?EQE6TuWyryHJfe4Bp0rYXQ71J19qNV5z8f0Vt64xUOY3FDRoZ7d9XevqOvm8?=
 =?us-ascii?Q?MeqTBQqMgGvRvEtDZOSGmBNwr/v9Wq2tLVAEoeqB3+MuM6mt58RpXS8B84rg?=
 =?us-ascii?Q?B690Ir/o/WyTXF9TARKcipz16lKBqkD/0vaqWwW0mgpMS6qhs+y52/Ee9zCG?=
 =?us-ascii?Q?yvxkrXlu6Mdmx+YxxVvaa7eW7+uX/1Y3twyBPnmnPmazGuG8M0EpaI2OAHdX?=
 =?us-ascii?Q?DyG4uScLCTnogoWUKZX+bthnAld5H5uQayhjLZMvwh7/h4y4gGF55TiI/Cim?=
 =?us-ascii?Q?Wh3ztpp2j1xJmfDhIqvCqSv1X9ycUSzWSjS9qA60NAZVkR5n+Xs2YwPO+TpC?=
 =?us-ascii?Q?xeRlX2Ao0qZ1vAp+ZHl6urBS6qj61Cm9AzDrhu1vDcsjLQcT1oqLs2mHqyzF?=
 =?us-ascii?Q?dN9uWBgabX2f1+Amigotwgn248fEE+GHKUCimdc+D8Fi+FZcryEFnDnPx8oN?=
 =?us-ascii?Q?lOWiZAVDZzqEx2XwgZd3UODauqrRUZvzCsczEnivIuWRbq8RdMLLM+Npn/Tk?=
 =?us-ascii?Q?U3OAUU2B0d4bh0Qgtcamcv1FH0FL3tqcwuGhXXGLKl3EruYH0ACHO8drQEq4?=
 =?us-ascii?Q?5OnEKJpKRabnPKdtKZqrC2wrDyMA0GDMuiiV0KgsBdIDEabZylwigsJMDyRW?=
 =?us-ascii?Q?Q4KbQ0Z39wlbkfYG+dFBKtdpF7GPPGHZXFvYMtJN3OGiCKcouKPWr6Lv/sRX?=
 =?us-ascii?Q?ziUDD5jB+XrDeWwid5qW6T2sBplvLR8jIZpeUr7WSqQYaLOdH6v8TBpkTO3y?=
 =?us-ascii?Q?SS4nAI6usd80ZAHS7PZnJj7NDXObv7fmW82+EsbpIK3oHC79cqaq50Gu1B3Q?=
 =?us-ascii?Q?94ZDWw/wT1ahVZHKuz557uaTe6083Q6L92MODxWl7WV6F3uC8q6j4cR4Q8hH?=
 =?us-ascii?Q?XTXdnkqZq799/tJ9d9AwPBL/XswmTI62FCCe+JHel3OdUfztPvaDY/LnAU34?=
 =?us-ascii?Q?Al22K6psT0hDHQyuCPAXk4f48CSVpqR178Dm5BI3VBOtexxyKaYq8CLNaqy8?=
 =?us-ascii?Q?7lGdgIDzwI4SJIS2oR16k/yCCO8XvzwK6ZfA3RwQmAOqSuc0Lov2VdSQGDK3?=
 =?us-ascii?Q?KodhPlHcyHFaQ5ekataUFeFSAqJOIQgNRuCgbFcpVvfU/SiiVp/JQo+eJ2PV?=
 =?us-ascii?Q?Qhxa/egUEgGzwB1NKVjIjyP43kovux/9bJGntK5TbyzHaQPTUgOPWxjbtx7f?=
 =?us-ascii?Q?Nf78422WxTvyO5MBnfkC0CosKkrqaeFCqTNfQv93Gidq8H+SO7zCPGa9o4CQ?=
 =?us-ascii?Q?jpTV83FNrrIU8teL7CFFttQNLazFzAzAuRlqIl+AI1IJMw08gfeuyH+8Xedq?=
 =?us-ascii?Q?cQCxN089Fgz3uwkzJSeotMHIEMpbeGFjrm8h04Lwbs9otM1vqHWs1L/CT3++?=
 =?us-ascii?Q?q6aR/0GYFOSdYEvYkmi1+7mU9U+bsla1kv+LsuGRV5uByb1lxIl91HD0vmS9?=
 =?us-ascii?Q?jZeVKARquqY3vu0M88sG3UGaSu/LpfzS8IEZKzyBAV3UKbdtfp1E5tf9Pf2k?=
 =?us-ascii?Q?NBT8vUACBg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CiCT8wwmzdO9xmCSpjGR2Xfz32PNMJPvX+Ky3cclybdiaNyQHflneAyMCD2bRenyjOqEKRVrL1AWSth4LkJ4UuqjhYsqjXT5ktQ6nYdPfY2JkknG31rLjVoG+KnHp1m5/RCAXv9JNkwcRZssl+eeF6Q/isSJXPHJkZRfes0ap1QcLmjYfS0MR+NNpvWkWqx5PsxEatYNSlDErfpnEs/a7+WwRH1ST4WKSB1jEs9vNvroXS8D0+LIrdcCIyide6iqBAOIjXg2OVQrtgaWD2thrIqyQ3kUZfTk87dPvnVUEd7R39qCBYhqWUG72XcRObGkipvdavcOKCpfJLA7+YQryA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7944430d-1223-4dbc-b9ab-08de960e5b49
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 08:02:33.8289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNksNbjOQMyteJnJoxy0SqwVFs2v7qp4dYtlrU6z2Jh+FneM6br3gLF1z6B7BoRZ0hjNHRE0gVIsKSPVs2rlpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9526
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Saturday, March 28, 2026 12:02 AM
>=20
> Implementation for a most straightforward Selective IDE stream setup.
> Hard code all parameters for Stream Control Register. And no IDE Key
> Refresh support.
>=20

'more straightforward', compared to what?
