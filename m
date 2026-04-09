Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0A3859FE;
	Thu,  9 Apr 2026 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720993; cv=fail; b=lixHO1NDkmgWWnpoFm82+vchcKgvQ3m/aChgg8NcIrh3qWOoL3OYK3XHO8v2kXjud+RhPMGBYYnGQ9B3tjJCSWGW0YRJXn3p+oaYDLG7eBjkYZarhUYiuAiLeb0MNdyD2YzgSnQt5tlwHlRWKstfKONfxn29E+pXwpAs0okg3aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720993; c=relaxed/simple;
	bh=8hfgOhcvXQTenW4N8xF4rukXdcUrbtpbf3FihZQGCsM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ap//vQsyPuXwejTCZhsrnptWftpqVaQH/Lxdy6FMMFeEXkEPTDeYJbX1cUrswUz4bkyrsprH7veWfyBiP4gJACUQQ1npOzClJRd3QBBIuwyrgXrs48mA1lgIA0h3UqF9JnBTllwWiWHDsf6qmkaoZOQD8lmndGjSJ2geIAy17Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwA6nmnr; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwA6nmnr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775720993; x=1807256993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8hfgOhcvXQTenW4N8xF4rukXdcUrbtpbf3FihZQGCsM=;
  b=JwA6nmnr5lixm3Zg4a2zbBZPqCjZs3oRnsfAJ8vp4h67tEsSDiQEkePE
   h4VBfs377uQlBSVWmNp/kCYNzsSgrRj5FP4Se/JNjWSySiyoChayKFcYd
   spOZSM6bvx0Ky2oz79KSrvJS4FteTrsy4dqPnD5cx8i98I8BTrDuAi5Sf
   zkQ4xkBUjHUIhU3W/5dD9YBqI14oS4lCjISTyTj32JRf4gvUtQU4vyM91
   mNx2pOZuw6KLVNDiDWA3y7ybJrB8fDaJvf1vNdRy+2vUByOS/RXsXqSzJ
   0BjzaAo25AXWL0W2APH10uris2cG5PItz8LyMmktCxtUkPz4Aq2kMSKEY
   A==;
X-CSE-ConnectionGUID: YmC38q7aQMu4+UW1dPuECg==
X-CSE-MsgGUID: JXl5tL6ZQ3KdAT/1zZb8/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="99345626"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="99345626"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:49:51 -0700
X-CSE-ConnectionGUID: z+mXfX2jRSSV6u37Efk8/A==
X-CSE-MsgGUID: Mf5Re69eSpmYpoOPg5qtSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="227702178"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:49:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:49:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 00:49:50 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:49:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJ9EYPqfPjbhoNrPZO80mAkauNbtfMmYyoxMQwPz8kQDWorMsJrm1R/0DS9p1sRWGY7C+6U/fXjHNi9z12MlpIc2vJ1Y+7GnMkDJaadqFmLZw7yzIiFigH46iOnijd5ZqqAkITR1vZv8zIjOCz6b4uyNI0lmFWh4d40cQBimi05D8syibqLEqqH3KLzHm0xXmxySOPP7u7ROoh/KkvAiFZXap+sYk0TkbXGUErSLctSHwsUEMJzuHCGBV9fztar4UwbqCYR/ClhFUeM1eI3Vb+CLXOlq9JnAu69meSH4pi/arsCpDtuQMm8DaSXoesIlytgtk1F6gWQA2OPcFPjnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZ4SgQf2+SSPZrqrFrpQVzIZhxYdWjhVuROJyzgman0=;
 b=Ci+KLVTWuJyD7ldsBx3skt1yG/sR1VnPVPP7uN56fJCFnmiY3QLeLO6DhxAg/ZmaKrUovoWBwIRkBnKz+25dQZ4XyNRXlDWuFIIUc2ywd45mQ8eCQwZk3vTkz9+puXLP7LR61LkhQdhuYXmEHiyLtdFPffGcJUVXlHzsbx5Lpza5xoo3khPrZczAlmgvohQngGoxdTbjRN/ry8mNevCxICqtHinRRAJotBbXJfOCqmjTLKmiTdN++mGMnh+aHAkSzIMQkX3tt8woKs7+d1k3lH4N2NO4BnyPSNkls849sDz1IaQOOIfnbnKiJILeHXBY5dlXHPF1qCbJQIp9K94fOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 07:49:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 07:49:46 +0000
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
Subject: RE: [PATCH v2 22/31] iommu/vt-d: Export a helper to do function for
 each dmar_drhd_unit
Thread-Topic: [PATCH v2 22/31] iommu/vt-d: Export a helper to do function for
 each dmar_drhd_unit
Thread-Index: AQHcvggs09uKit4yCEiNnCeya4YOCrXWaZFg
Date: Thu, 9 Apr 2026 07:49:46 +0000
Message-ID: <BN9PR11MB527698CD6C350B371C47540F8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-23-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-23-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6541:EE_
x-ms-office365-filtering-correlation-id: 8c6a1121-ad38-4bd8-e54e-08de960c9212
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: EAqXVWQlFvTy0hn1oA08DRbEF0w4+2+UiVGEVM+F5gQJu+0n6r/Zwc+EM+Cp90efD4KDdWEwRwquBFa9si/p5ViXfr67yJcihzQmywdaNsZGj9/KvM8cEt0xqOEwNcZ4RIWL2e+2KFL/r3Gf/W5jkqq8ZeJUzzjk5FEUDzzJpOcQ+oNfZPULA/qoeYLjcjPsbdBt0j6OGsxWIEeR3L8fbVfeGlzD7ECCGEevImF4egBtljTcW4FaEMOQa90QzKqhFKjiDMGTzb8Ev2OslzRpElWJinSNn4EgsyODAQ7BzphCOxsm8tUXxZzn/0vL2pJR/b2phD6cGWWokz3ZTE2OPlG/6rguRfrtdm4yd5YUC3HuTCLgS0wckrmvxHVNs5wtOWNcrr2OwHbDSRuw9K0Ggi2QcXAoP4hxTPDrusm88NDg0d4yboi3ZC62Ros9D07+2JpXTqRnYR0QyLjUWoop8FMKk6YUMWhNnmdnK5GRiLDs1eUDDVt9vVh/z7FJAuVydykY9kM1YWNpDGaLUmsM8KFgnGsw7MnLwtPYsbcCuLEm9U10fxYxem2/OlRS9CtdZycBEdlZCvTfL/2PvO9O4BluxAG+jOg5VV7E6EH6MLh82z4osYj7quWLvVQQxt0TjwDou1xGe7mfa1y7wjAV7CgLRI17d752Pa/NovyXvq1MFwHHISL+Y+AZOoAN18Odca+uqF2T0jm2+WP6fkw1rWf0NuG4B6GeDILOA8iyqhuh3+AAtjpGs/wTcmOSd2DJUAssGkJ/HLR3QyWCAZvKaPgcWRXI1GSc/zIod6lY1t8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PSs7N2THvjBfN6sSinjxxHxZ+QrHsWKXjPn4twT/dBgk7QSD7qZEkaFDr/Re?=
 =?us-ascii?Q?E55Y5m/dU1rx/5bBp1/5D7nmoYoQ2XqF9y4EMH88awvCfC5aiS9p8nRyaNV3?=
 =?us-ascii?Q?rQ+A68YR+4PqV9zmXvRhSFOTgztrbaZ67ABHxztDKUtPGEKk8mMFo/tLPydj?=
 =?us-ascii?Q?iK8cGWhBE95sV2zOpwHkjGLbzTbs5LYfH9UrUrxdc6F6AYK0v2+937K6Wscv?=
 =?us-ascii?Q?OuKEZMtFbUKIPoCbWiYHrM1feuaJeOO2xnQ4JlaBNgd0fafGC/h3odlvdF1p?=
 =?us-ascii?Q?dUXx5ogOcpcPBw/2PfUBAQwIHkcDhLORBA98Irdf0ugh4LV2IdChH24kLLhE?=
 =?us-ascii?Q?cF+yRqMtOKvHX9gjfJftz0MM8PAsYens98YlzV6DGgIg91gQBc/AiKl12LWo?=
 =?us-ascii?Q?88XlrujNd9elu/N2mOG//ysOi1NbhZU52JGpXn7rV5oC1oWKD7QNVTaY8ULt?=
 =?us-ascii?Q?WPPBUO9d+SPPS+p1hUTL0s8dTSFkk4mg8Eg6v41M+wHCgC46fgY8zjlmkIeH?=
 =?us-ascii?Q?Hf/UiwWtD73D4sbMf/nAVlyhE86akZDbVqVUFFdMQd9jJYlRv1aPHddGX3sM?=
 =?us-ascii?Q?JM0S0nQ0Bwnady3vef5LXIyNzt3J6dAEL+lIxPNiSd9zbyQBjFBe3jI46ZsS?=
 =?us-ascii?Q?GpEeH3IIef5AnPxOrdd5g9Gq1rxOxHCTeSKU4PQWohaMpcOHTHDXxq1bEQEm?=
 =?us-ascii?Q?Lk5QhLmw6Wshnxjj3eHqGlTSEPYk/1ZhjT5zK5SxHS13LjGlTGJzASdk8rLW?=
 =?us-ascii?Q?SSKaWhPmwBKoF3dLuPmUtTehtwC0ylJRYvhGZfwXdu+SSzRIJnwl8EbxvlSb?=
 =?us-ascii?Q?eDCOVLumyGCxitJv08AVmRWf2qbVw7W2O4L9etJiZqnq7KbncLrFPmAoWHyn?=
 =?us-ascii?Q?KQMfi98WVJAc2ndGYUfSX5KU5NwA2+ZrlgbhP8iOKFLFZey58LakVUfFdnIE?=
 =?us-ascii?Q?/oC1/wiyys9mmxQcgrRkmLfbZUYZG0nrCReWRbSSciRN2uJUJw6BzLIwQej0?=
 =?us-ascii?Q?E4QXYBC0LS7HnhfX/LlSyeRZxd1fIVSLl9/XxhuodpyzgKs0REstfXQ2WPNC?=
 =?us-ascii?Q?VCIe2oIj6ItU9OUDPUGHk/uhl+9B1VuSREH/tMgqAlsDGMs2rmlF9MADBmzC?=
 =?us-ascii?Q?BFssUf4LPJ0vXGbCgfqUXyRCivEFNpK31RPetnKzTnKHlMKR/6AddPipp8XX?=
 =?us-ascii?Q?p+h0QP3U4qpgb8ujJ3QUI5TzMUW7yXnDr/jw7QlsvYl1l75mGlqOI2PnTjis?=
 =?us-ascii?Q?ejHGGJUBe7rjQPYWV+XnNCqwoWskKw6sq2fXYze4YwvYDR3OBhvUmepsS3gw?=
 =?us-ascii?Q?OnysVYnWb1Mc6gEaInJo72bZvFKSh6Ap1eZbzDZrX/qipzF+LwyS6yauor0n?=
 =?us-ascii?Q?I743ZE52rms02QPyIk8DMmZ9KW+oRFi2WJ/BGjW26teWhPnbKPRjd3uS5cHo?=
 =?us-ascii?Q?TUV5Io/AyupLIubvueyP8jEn70YgUD+zAIZ06Swedh8D7MsLXqy1UETtGbGu?=
 =?us-ascii?Q?pKxmgZfvCczx27fypMFrFOki3gzw+ppYA0vaOL2nhDfWf2Adfh7Ac4nYQWwo?=
 =?us-ascii?Q?djisHTr6wbHh6M5Znv3Sc0vbsu8xO6ldkrYg5rvrpuhA+cYJCKg3kqyrXDd0?=
 =?us-ascii?Q?MpAQbUfIqIK4e7BZ4M4yFuuuvmG2d3lvYDIU03maJjk2YLyajokWj90IkIoK?=
 =?us-ascii?Q?WQBsUyQ6Z3g1Xj4tE5lFrog1BTCJymk9ec1rmUPqcA0nuGiz8CP459wGYbE7?=
 =?us-ascii?Q?Mk9+02fRnw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KaUzNwzYBtFuCxlSqpysnPTxv6VMtOHnrWRz06wEtuSRuA/1a+WBuRZd8yagVvMJCziFtxS4N8AQXZ8tNs30SL5Ey575duYjJfXwRTSOOB2g/VlvmbRnvLG15L0LIjtxKwh+VwR83kyUXyr3wf4iNqY1nKF6Bgnhshvmu6YqG8gswPxIPJCshILrdgz5tokoz5cvY8LomXGRY9s4PNfx2Pa2/v0xGdzjmdBcowUxi1ymPoPoeXQhk+Sl4L+NHtPtCxe5HEil+odkWg/2au5vaAEtMiiO4/8g8LaXwyVONMZ9nyXTQcNki153+qZ+hAsBqNOY7aIRExvtFc2xDexopg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6a1121-ad38-4bd8-e54e-08de960c9212
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 07:49:46.7516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDmRzjPQNsDUnwLazQgjn9+IzN/LwY5DkfXa7Dyd6JO2MZZsSGFr3bIirrMpvzg/sbOmUI4W650yZXwi2BHPwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Saturday, March 28, 2026 12:01 AM
>=20
> @@ -86,6 +86,8 @@ extern struct list_head dmar_drhd_units;
>  				dmar_rcu_check())			\
>  		if (i=3Ddrhd->iommu, 0) {} else
>=20
> +int do_for_each_drhd_unit(int (*fn)(struct dmar_drhd_unit *));
> +
>  static inline bool dmar_rcu_check(void)

It's a bit weird to insert it here. Move it to follow for_each_iommu().

> +
> +int do_for_each_drhd_unit(int (*fn)(struct dmar_drhd_unit *))
> +{
> +	struct dmar_drhd_unit *drhd;
> +	int ret;
> +
> +	guard(rwsem_read)(&dmar_global_lock);
> +
> +	for_each_drhd_unit(drhd) {
> +		ret =3D fn(drhd);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}

use for_each_active_drhd_unit(). or is there need to setup the trusted
configuration even on ignored iommu?
