Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0F3DBD6B;
	Tue, 31 Mar 2026 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945174; cv=fail; b=HLNCyhR4OBSi6hAqMqrzCU6+HqeVRtVOUcIDMFYV6rk/Xflf2I9H39/FZHCdi0f6D31q0MyZu538kpPDIBatHUogLwtPMYkq2Y5dRXHCQPcp1kz6FGDmzTVXou11A4MBYQNWKOyBCStGhrh4hUYXvHC33LrRECzt8WuNeHdnxbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945174; c=relaxed/simple;
	bh=lkwSrrHeaTy0NZEu7oXPfH9QyLMTyoNiK6/SMFIi1jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d1B2lF+YtU2jsAbXfcmSajBCp2gQzmVetE3nEJQRjD7w/mqdBZDZPkJXNNNJhsU3Agv+FvpGIr1Vtwqb3vVmq9F5I0Jy1sO+AvHhERr8JpBG5+VRQ8ZnulhvVqtLsTyAr0En1m9sNVuJMoXp86ecJa6G9aZr6IKM30WU4/K1VWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDJWLFA3; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDJWLFA3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774945173; x=1806481173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lkwSrrHeaTy0NZEu7oXPfH9QyLMTyoNiK6/SMFIi1jc=;
  b=IDJWLFA332dCPckZBTmqusma5esT6d4ayl7dAaQQOo1OaWjQ7vhXwFnQ
   pvslRKa5ggutE32JCFjhqzilHw/lbRy5HrJh535lPi7CYnm+wxjzdHLS+
   ojoutGI6LKrZbW/x7Mu5zgHBiF1ANO58bCA+MsdNjvw6Qs6J83He6tx3C
   on/fgiVpQ8rmi726FRUNmelxYtJ15EoBWtu7uiPw1iOO6bAONoXIBSeIi
   SuUROkatBiyBlf0Ft3qQfLyPK8wQ6QCUKX7lebrY4ABVja535Sc2NWeS2
   9bPuDP+oL0AG+aS0PEUNWkG/LOtEypDWR+2cDcURD9e0XCCCMQzoF5qud
   A==;
X-CSE-ConnectionGUID: 3veX7B9pSTSHKxtsVbMAEg==
X-CSE-MsgGUID: DZkyLLcKTYCuOe8xGbCMow==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76140300"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76140300"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:19:25 -0700
X-CSE-ConnectionGUID: rXxFvflZQqmcddiNlFh8FA==
X-CSE-MsgGUID: rjcav9qSQ6az2DPLZTztQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221894366"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:19:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 01:19:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 01:19:24 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 01:19:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+w0dN6LAOH60VxXY3IXgmSE0tIuWR++iBnW6BrC/vbJlSw5kacguD3xrUsHLTt6M10eMVOr/9FeDl1AMEzrB+lHpIJrUec0teNbEwGOlt+Q0+cH1+5EuSipZY8K22hODZ4WTN9Vld7Gm2DFsSwYwAjM6PbXUzi1dlZR+HDmKOmzlHHL7odXsqsTYGK3JlSMnaf1spF80u/Hdu/yoKoe7fvSvjWacZYAoi+5qfZfno+YbTdGu4YtyXQALvil26iPI189hFEAgHnfC5HMacvY5HyqaPn5SeJ/8EiHsM2/Vq6+mIETQDB73dd9dat/gIkzIu9hWnyZA4uWyCe33l9y1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkwSrrHeaTy0NZEu7oXPfH9QyLMTyoNiK6/SMFIi1jc=;
 b=REHvWzvUkBZ92HiVYZ1KHFnDBafPeLZGhuLUVLI4j6N6hEtmDWigA0U/luUHHaktyYDa3jqcYxUEd7XjUERLyPilIEQfpngxQzkj+2xD/6lNVdO5M1qtZJR4PvTpkhWldVqsVYeZbrf4/L+SARlFNwFHoiZlPMjqYVHZFxZ8W5zLPVNNkYbOZ/aQ7QYHdZSwfrigvMw+WKq2dmIJjrmGd9iz97j+CcsR9YxhymkayCAxph51hKJUD01Sqw8DVGXL5hKSYi9yRuLqQwRokKCdNc9zoHR5rzWG2mVuY6HGnDuyE/5yvVL0X3d97/gOF2HnquvY48dt6Hieb3PmMkBmuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6191.namprd11.prod.outlook.com (2603:10b6:8:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 08:19:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 08:19:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "praan@google.com"
	<praan@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, Vikram Sethi
	<vsethi@nvidia.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v3 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Thread-Topic: [PATCH v3 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Thread-Index: AQHcrcLZlsPpC1aSZEGOkgr6dEwpTbXIca9Q
Date: Tue, 31 Mar 2026 08:19:19 +0000
Message-ID: <BN9PR11MB5276A6B1B103C4B0201458348C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <a0dd3e4cc5260f55bbec5b3ed6791def33028735.1772833963.git.nicolinc@nvidia.com>
In-Reply-To: <a0dd3e4cc5260f55bbec5b3ed6791def33028735.1772833963.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6191:EE_
x-ms-office365-filtering-correlation-id: 8bc76981-b911-40bc-3c96-08de8efe34e5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: K9WYwXPvyZ17fEuP2BGm2teDw2v0UmdLlL0+7Mf169TZYnl1hQp0dZnZb5R51+GHNDB/sq2CWRv5kskXSz6DvHuEZEkZ3yOBfYQ4sdbpr7m8glGD9eh+tCsf/zptwuqxel8+ys7DgMRNGqO43Hs9TA5FI964I1TatEojp/HX7tCUpG8C3K1bBi73o9kb2MlCg9+6CQzqM64jqNI+8Q+bKkcHVxdaV0Z+u37yqNchZhw6zqikvHqo+m08pWhsWc2tGXjWHiMdjwK9W5SPRp9qkpied02UrFfGa1tZNs2ei4pqAGP7A9hrY4bNVYyOeyUgHFpOUxYA4m23KhEktnng0V97f1CLusLK917DLc1EP0cYCzVt2Hdi0lTICKg1IGHyVNQ8s5HEZNZJ3cdiWWm99GrhxeWDax+dr/LuKdKlUt/m94QVB4PKpvJqJKj3rOPP9jTcJOira9rQs233F2mTa4+hIlAJ3znxJllcEhwSNwbuDxUH3Vdn4cXOVx3KOTOy4UtxNrWIblnWryaYTqhvlPLJJXDuhtWOUeZWI1gWAPfzGTVebFKzeKcGf1LrvvyF13Wv6d3MO8ZllCT0kx+tdWq0XlLhlmoYGKhQxiRhh2/ccjDlqgD6DI/Jc2ChesAPOW0wlme4mqfb/UQMbaJNAAvJtDh2tgrZZphZ8lDjCDLLyaIrjiDorLYpMbPq1h9o4EQoAUWYH2dZzp63JbxWtW2MFWOaS6Oj7+9jIT0kYXurv98f/hM2mSq0UIoOkGsISdPH+qqX6lX6M9Y1t99tI+lsbz1HFXrvJ/yXzFr6dFQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GMrrEQoDhIcBkWJ7Qzm+VNBb3KHnTxYMXf7eM7wbN1D0X7DlJZ6GIOKWQvkh?=
 =?us-ascii?Q?Zf/4TRc8VwLumQ5KEim0CHxzjLej5NRVapr5vkQBcITM4ggk+HXoP+TGaTcF?=
 =?us-ascii?Q?Jgi3gGX125iIsYCRM8mQ7zGlcpShc7BxuHIZEH6483spBtMQSmJDXrI2izEM?=
 =?us-ascii?Q?KPZ728iN1cu0cJsu3ZXWngHhtpirf2PSWyIWy8nTm9bVAREdMQQVD9/+X/di?=
 =?us-ascii?Q?rs+Zc6BGT78bcIUlof3bzv0DvQI0YU3DiA/lIGxdTSsVgriq8MXgGJ4pzVFj?=
 =?us-ascii?Q?uzJdwDxNWqdkvPtJh5z0WjqmO6VvVRgg2a7f0oqEcz3tj7nKB+iiFoulrfzN?=
 =?us-ascii?Q?zanFbPp4bGbSpyg7V/eLxTPt+b8E3rt+J9lBFsSRBCPTk3RYmPXIK+5nvFuZ?=
 =?us-ascii?Q?ntcovjPVFtjI4hPLF2XTY3SZ7ZObDjwnNq1FkXyguAIFxSsaoI1fg0q09Y3O?=
 =?us-ascii?Q?pmaV7FvsAoO/ld9SKCv7U2tGEqAVbSAGnvlftbUZr1cXLRMLxwrGDHQXpcOR?=
 =?us-ascii?Q?44/QLFEkm6KzEdNDFBF3Ru/AXiuGm6Ey1iwVS4SVX+HS2L4bAghVQo+djP5x?=
 =?us-ascii?Q?ls3j/adWjl0oxFvqdEySZJtCTO9m4c6Xj1JjteRUfkOkKpcJ/6c0Y2PgzcXB?=
 =?us-ascii?Q?V/uAHcSPz6C3qxCo5PCGpbAjwRt/RLfQZITpNlUOFWLnaDPMhnbO07oeHi8k?=
 =?us-ascii?Q?QehSygF2lXflNHOLlAfi0OrFKuKP7s5sEVeGvZ3ItieWUAEOp3230zRc22ni?=
 =?us-ascii?Q?HknZo9djCXKBUeUoJwwbxxQzwPyo28IgGwHHfRyhZ0WR1GogFfWDzO6uUQlI?=
 =?us-ascii?Q?v301QDknR9AINtBqVgl2sRVGvR+/q4x+JMx3ykFv3YCZDtoN2r9N76Bd9xgX?=
 =?us-ascii?Q?xj9uJjLFysjNwOOtmWvz3vsX5Ki3uO408DeC4q1ISTTHu8Jz8IkZKfdKVtgT?=
 =?us-ascii?Q?y3hyZP9uc9QaCGn2vf0wPMZX8imY0KcvcBbS5/9zOX7cVX13wCRzQs/BKkQY?=
 =?us-ascii?Q?zTX8jU48C7gJ26KU2P+XL1Dv5QcAbsTDGDG7IEVS11BOO1IIkTEDK6Dm9H5q?=
 =?us-ascii?Q?luQqcvx5kblUC+Yi511aQHgNpiSyF4SVcu0Trp4xGypQsDVkOGcFwHlCphdJ?=
 =?us-ascii?Q?VKSiF9wKnpeldg+ZN43d2D1KMYsCuW5dHduK235Ro24ZFaphsl6+D6S0qeJg?=
 =?us-ascii?Q?EhajoS/dIoERVPK+Heq7gWXkKiTBdqEZpgrt2ivYIP2aWNq4YGj5eLTvUANc?=
 =?us-ascii?Q?r460DJ9ZSE7uuS9hq277sRzxWqsNqdbWbJB+XLCe/U/ktvDUY6U8HiSJzir5?=
 =?us-ascii?Q?6/jrLrvGjZnNbnkhGqnJti/3xUVEFA7S3CkYRfpj5yqYDUMnvYJPOyFFkHpf?=
 =?us-ascii?Q?4RUN+Xwm1hSQ7H8VIt7B1LfhTPxZOLECu4FM8foAQF3W4lsY+rE+KmHz0LNE?=
 =?us-ascii?Q?HYY67lBWHjG3Pg7UxvMhU5gppFqEaB3PLZBVZZ4Eirdwz43Rrp/2ud3vUgv+?=
 =?us-ascii?Q?nJ6i53Use6/dN9ds9g5rBRah+Esw0QZ/dJDT0M52sRz79ZRHtl3pAyBdF33L?=
 =?us-ascii?Q?2x6lg4LLaOSEvUUhN8N+UU10RaX3Fn01fben+dVjOcVq3CYBNDRrQP20xdsO?=
 =?us-ascii?Q?8GQ/JaI/zrgld/1KUmZSelnp5khXWYWibVrU2pXbczMQMY7plsfs6jhCaiNW?=
 =?us-ascii?Q?dxzXlt8FFxkd24L10vlKSNzWiADcojnaCENlolR1vbT07+RxoApWS7NcZWx/?=
 =?us-ascii?Q?7VVAy5rRKw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: drr/bBQQJXOmzM1kjDOzlcWnonI84f3LqH0z6A/xKQID0tAmv2rCDnADT89pPRI1BZJvOcTeieCwnV76ka65f1KQgQuTA2qdpjZjM6avZhj4rKpJ5wVQRoUeZXuZdtwhqXKvJvAZkrgkEmaaP5gnfVKfXwPAXmDSIUl4wCUH0YFvwoqg8Ex9miFEuEE9itWdgZPxJXJDvuDTmmrBEvuhRM9IvmFVOmIY7UoJBe48xtDiQjsFD+PvtiyEhcnrzsN373xIMGxd8/hMIOVDMf8OglxniDPsQsAIc4gX+P2EUn04WJ3lv+V2MIdsXutpDNdlW3Fl8RiqJWw4t8xEapO3fA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc76981-b911-40bc-3c96-08de8efe34e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 08:19:19.3101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wacubI2SU04eau/0TpfmvdbwELG3T2V4unPB/6PuoXHGtHUuYPNvnY/2bTP+cxIG9/Mdi5pt/POxBUmNLlY+5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6191
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, March 7, 2026 7:41 AM
>=20
> Controlled by the IOMMU driver, ATS is usually enabled "on demand" when
> a
> device requests a translation service from its associated IOMMU HW runnin=
g
> on the channel of a given PASID. This is working even when a device has n=
o
> translation on its RID (i.e., the RID is IOMMU bypassed).

ATS is usually enabled "on demand" when a given PASID on the device
is attached to an I/O page table. Above sounds like there will be a softwar=
e
action to enable ATS upon a device translation request.

>=20
> However, certain PCIe devices require non-PASID ATS on their RID even
> when
> the RID is IOMMU bypassed. Call this "always on".
>=20
> For instance, the CXL spec notes in "3.2.5.13 Memory Type on CXL.cache":
> "To source requests on CXL.cache, devices need to get the Host Physical
> Address (HPA) from the Host by means of an ATS request on CXL.io."
>=20
> In other words, the CXL.cache capability requires ATS; otherwise, it can'=
t
> access host physical memory.
>=20
> Introduce a new pci_ats_always_on() helper for the IOMMU driver to scan a
> PCI device and shift ATS policies between "on demand" and "always on".
>=20
> Add the support for CXL.cache devices first. Pre-CXL devices will be adde=
d
> in quirks.c file.
>=20
> Note that pci_ats_always_on() validates against pci_ats_supported(), so w=
e
> ensure that untrusted devices (e.g. external ports) will not be always on=
.
> This maintains the existing ATS security policy regarding potential side-
> channel attacks via ATS.
>=20
> Cc: linux-cxl@vger.kernel.org
> Suggested-by: Vikram Sethi <vsethi@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

with a nit:

> +/*
> + * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source
> requests on
> + * CXL.cache, devices need to get the Host Physical Address (HPA) from t=
he
> Host
> + * by means of an ATS request on CXL.io.
> + *
> + * In other world, CXL.cache devices cannot access host physical memory
> without
> + * ATS.
> + */

s/world/words/
