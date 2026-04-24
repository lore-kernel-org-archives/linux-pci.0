Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4023E35CB67;
	Fri, 24 Apr 2026 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013479; cv=fail; b=KaRQYYV21ep8/DYxS1x7tfn32t0FPh6saPQzyc438h1014hVFFnpIhjbAy9jQQ8U14Sa3KU7x+15AjrlRRJjkUWRvf5M/4u+U8uk7OkmKATQZwYmbPWsUkftUc4EZXTNJfOpptlU4ptW5egcRgMtdV4EmsS3vOjUrU7QpNYsoNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013479; c=relaxed/simple;
	bh=/AkbaYYasOyiW/zBXx//1Ccu4D+5yjFxjoZSWaIP9Qg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pw5lBRN5bCJKlec6TVBQZMSvYyS0V9jUZ4PHL1NionJbYfF3W33KLkUBoMdY3LYyK75dCXrSye5rTw/MT9ORns9wHh4Tlk08lZ17gkrYbGRQ9VOUMGbZvJZYnC0fmh/T9pnlRYIp1c7MN5rS50q8m80F1yIEVsSK2SIw8efUbeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvgNJpm5; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvgNJpm5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777013477; x=1808549477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/AkbaYYasOyiW/zBXx//1Ccu4D+5yjFxjoZSWaIP9Qg=;
  b=EvgNJpm5dNEZ0hVa3elrHGWfmSTADxvxH9EZvc/oglT1ULdsPwTcCJ+g
   KFkfpi3BnoJLnJu3S81x4OI7y3STi/BsQzjcYswPU5kM+8mI8yzJbXMfm
   OlFkVyiTVbYNwjH877fHB+e4qSSL57y4lTrvpZYdKgbwytJ9GJIijVi5s
   D/OHlu4ETO51le2U2Qmd8rzcgLoyPJjKyBsbgVB/Md+r8ufAGY9CBDED7
   LlfGpmCoEQKr2KpnmZcIiWJjDD6Zj3pdOjmcDMfojfmCj2dZ302bS3/5D
   omgXSv8TsBtz5b6VS5nYRL3HvZx2EtR1UOUymjMMPUunQ8FKj5xrw+MMp
   A==;
X-CSE-ConnectionGUID: ypCBt49fQviWAbYj5aaO3w==
X-CSE-MsgGUID: JsBdL7NfTrWXyeP+eeC7Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="81848247"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="81848247"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:51:06 -0700
X-CSE-ConnectionGUID: 1jYNTeLTQQC+isZmkaOObw==
X-CSE-MsgGUID: FU2ncA33QoW2oNfUCj7Ahg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="236855124"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:51:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 23:51:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 23:51:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 23:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMoSKrtm4gsFRYs/aGhu/q2e0DqralMG/Pwaio8Gm7LD+yg24C69QWVca3XkEa3ZjRYPLtHNV1laxr9Ta5ilsQBJRAVE4Hwbiy/a6OcPLyCc2dLIeYyAyyCbyPK6DhZ3IuQVtYKM3XRbh695N4nWox7DI2kQgpxQl4elj0NgqZHqTSHhAL/Uh0ASjecV4uQHYwJSAPLI4QXv1km0lkVAnUzJK1D6EY/1ezCIwyUV+MIKw08ACFApyCu86tMu3FWylJ0oqYYgvG/S8U+6c3spFzrONYgEg/QiRMjBQgPF9g2tLTNAVB7sRBinQu3pD13c4e8EGSmkmwdriqAMyZuekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqP462ju6+9j0tAQRXadr0iUODy3nVOFoXIlD5rqkjg=;
 b=CwbAoos0KtPZg/5tcomO8Qim0qcwQdjrqaEbWW2qOvOUItAT9CRiejDpFM4ljfF6EcmZxGQHvTHBA6xqDf0Dt0xb4LbWBijdN9UBtZ3INitKnxNdR30BBnBSpcIWp2ofiUTNjsCSa/8JPNaMntXVTOW8Y8E/cpE92YxnpbzRIeeKmyVSaTdCbfs63zeNQNqWwSc0g86b8vHtdxKV362nXvPU79PKSV6EexDdDYDI7AKxA/e+KtKDzNkOQir9vkJBvKAovtB3rZQBUAw0XIUkBZguik1kWsbiaRR7xo0r1fGiIFTF+OTkblOML3TbH/Di9VTMwwodDYtkgCy4Hc+chA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8594.namprd11.prod.outlook.com (2603:10b6:806:3b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Fri, 24 Apr
 2026 06:50:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Fri, 24 Apr 2026
 06:50:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>, "Gao, Chao"
	<chao.gao@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 22/31] iommu/vt-d: Export a helper to do function for
 each dmar_drhd_unit
Thread-Topic: [PATCH v2 22/31] iommu/vt-d: Export a helper to do function for
 each dmar_drhd_unit
Thread-Index: AQHcvggs09uKit4yCEiNnCeya4YOCrXWaZFggBRePACAAyksAA==
Date: Fri, 24 Apr 2026 06:50:53 +0000
Message-ID: <BN9PR11MB527684A7692692D092F360818C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-23-yilun.xu@linux.intel.com>
 <BN9PR11MB527698CD6C350B371C47540F8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aehrup2/IWdq62mm@yilunxu-OptiPlex-7050>
In-Reply-To: <aehrup2/IWdq62mm@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8594:EE_
x-ms-office365-filtering-correlation-id: 93a13bf3-62ed-4d6e-11f6-08dea1cdd435
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: CUgItnxKectjzIQ/haYfkVRH4wXYpugtuS2MyURrNBwIHr+6VjEmXaxxTVoPPiucRUzeaz6k3jfdUE8Evy5WW6LwZ6/SVwnYEguIBO98cSKl+2zsjGltPs/ZhnQQH8f+5aEEWSTExCXGoOG3kdepwqPTmT2tMUcCpApfVREoW/VBYddh8gutoSO9tK9mxb7Pw5JJXRAtlVCAR3YAZec+5NlTy7Dc6pMsxrk1DXmwY2HzsoepNkwrvMqz4R84bShyGH1wHC7btXGv+CxRtC8atCoLN605ug7Ce9r8ZIyCnALeZTi+xtliUwK5B4GuODoqnFdj0g3k9Ieq63++dQ4UqMj91yamuvH1cPXee8OAYJhPk7aOT8i8hNJLgo8tpcp2Ams5NlVASMWxZ7YI3tcy4hXWoVe5DPshpSym5c8qr7dXWBzlGLepfWOCzrkhY7uOUf3TQedtW+LxEq4WZ8aazyDgaZPR8Wtu9qc1BbW/vRunl9iRM6pM01mX0qopv8LKwq82ZPZbmPtZKKy8JJrsmi94C9mZIIprj6T4p4b6jRT7un/P74NLkufRhN+86OZWVI51Y9L8RYRyDdUIQo9HdvcSOxwqGllkP/IaA80da7c0vLBRZVX/3SoPYgSj0jt6GkOpYeKDf/rM9wBZ8zBUZPCMhnwR4a98uxhzJOhiBsmUTrqD9d/ItEsboEWeEorjmyi48Pb6cywDPYfc1VX6fjUy6kfcVJygNHwsHbpyLx4OtTAvt/QvkGdiBY1s309vINmYJCHAHvgA6nzaxbztXU9uEIWSXGGLCDXfp/Y0hGU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(38070700021)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DNwiRYDmL9PuJHM+ZUNcBjQp36Kj209xktppC1+MJRcaJorpou7G36xyC7Vx?=
 =?us-ascii?Q?W+IBoFylr66oeLRBMHRBVwlhhG4weVeQfoDMcCtWzuXnEF9owZG0a5sII87w?=
 =?us-ascii?Q?fnKv5u/ZZcOaYvXgVEa4g8Y9iW/gBsOnN5T2Ua3QWs9t/VFt4Q6xW1MdMq/g?=
 =?us-ascii?Q?55Bov5yU00F/fwmM2klgr5QxYqxfAMzeVV57Qfm9iJSaOgGCWjtu9Jc3iDcz?=
 =?us-ascii?Q?2GUH7UmPLiMwQJeCLEzsaKuu1JMzIpVCUD5uOw36KqDwCVLe7TClwGfQ+0LY?=
 =?us-ascii?Q?CNbw3ELaESej6xTZsMdN+3g1oyo4fY4KFgbklWVvg0uA4YK43eYxhPRQ6E03?=
 =?us-ascii?Q?FXYGNJRmcZwGWJVJ2K/3B8Ls3dHefnSrFD/BvX/mjGMmHE9qsnb41QW03G6y?=
 =?us-ascii?Q?cWW9LpWyza/dSKii59O5lBdWPu0eea3WKibGyvM+S20BGbU+otvEHbij66FT?=
 =?us-ascii?Q?EJfQy22I1ldwkfT3Z1f9xOEE///Lv9M2DZD4lDeVR2yWUxMMAht7v0W4hXFr?=
 =?us-ascii?Q?DYlSgWHsPpCPr2vXHNdPKlOh5aZf9j3BQy9KAm8IogbE9Zv2wNw/6KKVlUkV?=
 =?us-ascii?Q?VsYiyHHb2XDS4vi9PHsOiojPZZ57t7136CMUxoNVpfJkNSj9YXdMMa4QY5K7?=
 =?us-ascii?Q?rtV99ylY1mNFNjp9uVQ6sITryzDsUXMqDanORDTjG859QSQPQj0JbMdf9Nyb?=
 =?us-ascii?Q?F0zwQjr0zPxaXKtaq5llz4590/NktRo5ZKvO6ODL2efQTnQhs91tcZZPpJhP?=
 =?us-ascii?Q?AmBsgJmJRA5qitwMB+PdACk5nk63ZZbGF35RH3PvnesF67JyyHqH35NUqMzk?=
 =?us-ascii?Q?QMZl39tO+qG9fYlxi72W7fniskccjta+3O1egvEEsFQ03jDlEULSThT4aE/n?=
 =?us-ascii?Q?o7kgDuuF2txH5kV8qDT8pYQRUs4jjxGr8L+4YnZzkJxjDjwgKI7wGbhXFz9C?=
 =?us-ascii?Q?p+WxHJszzWt20dXH+yOLkBLeuAmmISNgy4HboXC4gllP9nn/gJJa3EgZOtuS?=
 =?us-ascii?Q?VaoWN/MLWGCTFRPWJkfWLeAgdDAc/BM0hQcgjy+ZHgaVF7pGDJlapYXAmIHL?=
 =?us-ascii?Q?iRyf18vzbEqRktXJqXETeCpkgKNiS+v1KS/uj8CbAVSFkJAr7TLLPZQ+cb3c?=
 =?us-ascii?Q?ZOcvi64/mLCubMByn9ETGCfH+OhZO0qzz2gL+NVfyqtd7QDQ6FKcY8gURlw2?=
 =?us-ascii?Q?3XVX/WzGpMseSgRfA9vOgP55+qY/eA0dH80iutXiYPtcGnVGZuOFJ0ykwBqr?=
 =?us-ascii?Q?gM7mLpa5yq8HyaiX0R9/Dk69U6ChCqKN9pYr4Tw0arxoTNTbpD5cjTWSp5Fc?=
 =?us-ascii?Q?+wIe4M561cPSc5fKKJCnFfsPd+DvbHiAGcTSm1YC1DhbvjiMKeYXds+0XcDm?=
 =?us-ascii?Q?8A58QmVfMgCPW2r663xyAWD569xnYy6WmOMFUV+0NBWhkI8UHxsaOmerRtpJ?=
 =?us-ascii?Q?FfHNR+1nf8r0jtj3dzqFgo1e35o140yrbUXe18EBX+x2tc2g71PqLUi3jUHw?=
 =?us-ascii?Q?sJaBCh+AyhJe9LYzKiPPAWsZg2btbgOQxFkZE8WKNrPKuGogje8fbYii6ypu?=
 =?us-ascii?Q?g09fP99oSX09a7YFhkZUj22RQosnrZ9LsIwWr0Y5Q25Frbu7Yo86MxDAF4Be?=
 =?us-ascii?Q?0TFG4jlff4GSt21SAPb9DJWnWDMiZ6LdQI1yMDoNLuEf/Wsjr/HAaK5PMGDQ?=
 =?us-ascii?Q?UuVWiWhaqUKe0keyCVKHUO/crkTxcwkxrtm2eFhEmthZMD3M?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: E1pOa+SfSLmirkaL/q86Fwx50Gmcry126BS+EP4Kbs8co40QM6Oooh+3A8cgw8Mzh8r4LROYbyp7T7dkFhvQbMRS2GahuUnYWB9xD9IwDdv7eHl6N/rL95Qb8tmwlsd0TFWXL8w64lQAOCf1F7i38JeslS7L+17wiEMhbCLaOetDdwCB+bjUtKnD6iQY/ilsIIhGGfBn4kEYhvEWnHASzQxrZgKLE+R2miVIl6+E4CyWjUZzSVIpVZei5LtEve7NYVK9+c/lXttBB4uhqXlwulPMJjk5Nj/38mX9Rao4CIUZMtPTXfa0jcH8an5rq26cgwWR8UUSzKPlreoBMQCwvQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a13bf3-62ed-4d6e-11f6-08dea1cdd435
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 06:50:53.3588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdQGY66Ifvn+6IVzdmIotavwFfm2f+F0CwsHFqkHkv+OoCKmxkTUyH3ffwb0wXAKtFUJPBIJt2lsVWowtxJTpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8594
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, April 22, 2026 2:34 PM
>=20
> On Thu, Apr 09, 2026 at 07:49:46AM +0000, Tian, Kevin wrote:
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > Sent: Saturday, March 28, 2026 12:01 AM
> > >
> > > @@ -86,6 +86,8 @@ extern struct list_head dmar_drhd_units;
> > >  				dmar_rcu_check())			\
> > >  		if (i=3Ddrhd->iommu, 0) {} else
> > >
> > > +int do_for_each_drhd_unit(int (*fn)(struct dmar_drhd_unit *));
> > > +
> > >  static inline bool dmar_rcu_check(void)
> >
> > It's a bit weird to insert it here. Move it to follow for_each_iommu().
>=20
> Sorry, it is following for_each_iommu(), is it?
>=20

yeah, I misread it.=20
