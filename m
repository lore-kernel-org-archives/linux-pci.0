Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8933C18B;
	Thu, 19 Mar 2026 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889693; cv=fail; b=bG+2IEZH1NMOsXDSSTaQMw8RQyU6vTvn7tWFadG0IxPpiOyCYoDiNXuWGIywfgiJzUhpLw0wezvs7n+VdSk24X3up+65fnr0xiLWB2R6peibU9e0tjbxr+C/iQy3FsmfPOyChD4z3Ei44d63gYBRyvenvSYAsh3OpBfiCr28InA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889693; c=relaxed/simple;
	bh=EK7W7+TqyQBETJCihOkpi8WcVyVhsiLMUirSPuuVEWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GolrsnKIUe5cGXM5oKsmUKvtLPfeh1PhqJ1xe8hDuHCgiKYT7Om01G+2LL0FObkupglFJQxwQCzLrqfmvNVmTnpTKANO5aW/Q9UxKkLQ5JX0yY9wtYwWukY4KGgvV+XtK3qF6cDnQnUK8hvqyFH4gjq8TKSbSR+cbSi7Uv2Tg2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UaLfd9/I; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UaLfd9/I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773889692; x=1805425692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EK7W7+TqyQBETJCihOkpi8WcVyVhsiLMUirSPuuVEWY=;
  b=UaLfd9/IWIFwrXElp5N7Lk7HWq7tZIOjhl7DPg5ZIjhSTVAVLBn0emIs
   xuOiMfPHnCwT3QSr9SP2UWH0IXfTjQppuQ3Q+QvpafFCdsKg+BEP7tb/E
   rEkgHTu6uVdQsuHSmz94KK2YlJbPu/UTObJLExESfgVKkyT/jSB8GhFVS
   izB8T2b9/8NsQ58LwjdiXsLomB9sy8OlMFQfp1pQzJkI+s4qHjkW1Huik
   U0hj1QIETOWfiyFweY09Ge+watrsYeYTVLfiieD+aWEHiueLGZq3vLZ7t
   e9CMyWOSJdczg6Fd2rwT0rc0Jun7pKjKE5NbnCHlEQ55XN4s1i7NeYjke
   g==;
X-CSE-ConnectionGUID: 3Bpo2wPxT7aRKeiWfnNo2g==
X-CSE-MsgGUID: qbPtSd4JRVeLcDEDQZ8GZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74869402"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="74869402"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 20:08:11 -0700
X-CSE-ConnectionGUID: UFpH5/sERrCB378oo9S4wQ==
X-CSE-MsgGUID: IuCZqLrZSXK9H6r08n5w4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="220240294"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 20:08:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 20:08:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 20:08:10 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 20:08:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPOP4xwPmkJxQhPmzPVREuSlHAZkVswoaM1l//FdAk6b1un5QefMdPIv4bv/kKMwiqC3FJndXGj3FjQAFxOAnEedpuH6WoL/+Tm6BiZ/iv09Z85ueB21Nrj4Uzfq3ZZ4Ih/4CZRBbre2Aochv//aJLLWxSY75MeSNST7LVrA5BlZl5sgCXFbbRTz2EGtnTDqHzoH4KNGoeyZEjowmIkwksdhtE/bs1gJiq/YQqGTJnfD26sRaa7qHK422xIbDH4kxmNtCj49q7c6+qoU/mXeRP1euuWWPpqyTvXKGh9J2t6JBkaqq9kCIDdRPrSdFULyo019vjkx0OV0YW52K3Hc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EK7W7+TqyQBETJCihOkpi8WcVyVhsiLMUirSPuuVEWY=;
 b=aYPyo4/L4Py4Jaz8n2bDa1KgaQgbzxJMKPJSslWNRrqWkASe1kZuDifrHtLywLeGMbEnlOEYAEp62mlgEIUGqJjHaF9RlIAe+lHZ6muzEXifBKsWWWh5Vy7UcHy9019+/8qjeCCLUNPHHy5/kAZdb0walcjB9XmRsKQzHrpoEjg6z419ou1hEg9lWrUzgZ9cK0o2k6mnuPz9mStD/zWitIMtJ6xQ/k0NaSrJ9FTAd3w02vHC4AI5ilfcgK0o+5d3pHqZZ3IKxO4C0u55Lxu1rOu94Re9Mq+gFnbjfqK9vra+fLFKaGpPe5sc26rQ/uZ7vZJlDpH5TfBFkT5rjhYRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6909.namprd11.prod.outlook.com (2603:10b6:303:224::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 03:08:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 03:08:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Samiullah Khawaja <skhawaja@google.com>, Nicolin Chen
	<nicolinc@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: RE: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Thread-Topic: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Thread-Index: AQHctkK1dv4ps/vKUE+CojHzX1Q1QrWz5inQgADHk4CAACzGAIAAUyTQ
Date: Thu, 19 Mar 2026 03:08:05 +0000
Message-ID: <BN9PR11MB5276467C1933E19E98277D378C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB52763AB181F5213FAAB4F4F08C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abr8aS/MDU9aeKu9@Asurada-Nvidia> <absaKimeI_TXXxuu@google.com>
In-Reply-To: <absaKimeI_TXXxuu@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6909:EE_
x-ms-office365-filtering-correlation-id: 0b09bead-4946-459c-0b09-08de8564bd65
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: Kfan1Z7khLPe5YnOi7g565/OiezlDqBrezGBsxlvAc5Y6vzp+D5YFrVu8nYmAplBUGAqJqmFNGpXvJk66HStZqm2qBv5y7qz8M9CfrW90i72H/dZxCzzUkpSk4MkzQRRQpOU90B43PFdXCcViHNITauk2JvlPK09zwRkviIvZVyG4pvgsq6P2+wAaBgnud4JPFlmLqseRf/IQYNTLVjO4o8OvQhcwkLHI48SRbVHgGtYORdFXdWXlN4bmMEqY6TMhmdMQ2OY49G4SjjUwf7/LydVFNI+Y5NxW5FF5mZrc0j13Jt9tkzfuiMw8BDYBVkRd5+FPtWrKuvtGFEvSIkon5TaPGM59E3n78n8oOawlnlKbLbiu8jHGXy6BhLLCPaH9Aa4ejZeA6TPdismBn1rQbXBF15ejypdnWa0ixu4r4yWBsmkLd0xjEYPm6IGcRGyJRZQ52eoxfGjfDkbUOTP16D9XHot3khQx26qWE4HaGDTqrKFu13GdqxvI+WFodDfye25dZt8U/zoNowTe9aLKOPEZ/wLZdy2kF4ohk1pgAbKUwJhg20KKVfDCe1CPlc954Lx4aO/IBDn4ce6O2a+BHguJM5ZRxfSATYzZyfBJw633KVnZ3WZsy6+QT/ysB/7cgRhEi8GsvEfvB5MDwuzt3IcK8P8ST8e4faO55nJ+7+7wtZy9HzA5mqfwam8hUVn1y9wkXXnTAJhlbhHNs7QOxr17NfHm0uGYDpD7UoKm6ZxsLlGGYFqYGVT8/OzWn/3SE0rTTQgB5iVk1XL/czTSFtSePqHjZ3QDjA2+o354hE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fym0CglGhWEwFimmgpE6BBAt+zIegiwZVmgHD8qOtPEQnMk8+fCEDoJUeXH8?=
 =?us-ascii?Q?mfBaKmh8yNEWnq9N2AC1fIBNaii0BdiLHXADFrj9+aWiKp+alqDttxQ+BdSG?=
 =?us-ascii?Q?OFPv/aKWF2Wjwc7g8tV4S88B3oIDdleKupIGduwnrVTw443O9rescyLqW+By?=
 =?us-ascii?Q?RGwGJDc+TqABGmxJQRsQp7G9xONB2uSxqwN+8jmkj5o1Z4STSXJG+B4SYcvr?=
 =?us-ascii?Q?GAhsclZMl25QHwe8WSxx5KG774K8WDBDDC5Fx9OJi5s1mK/VTWnQLcelD/xY?=
 =?us-ascii?Q?jjr4yFwLqgLOxeODUTY/B0crhrUq8MKsjeOAd5PCHGfaku6JocLAoiz4KK7P?=
 =?us-ascii?Q?OchZ7ue/wt/FoFwTbzL0IyPUqVNnVEROX2xA2UP1fydEyCrku02RNjEAkGqo?=
 =?us-ascii?Q?vB5ow3ATtw2QiImGWBT1Jop0I1gQmIYoqnICGcLCpH3P6L04O4iWbKqOIvzo?=
 =?us-ascii?Q?Xp2FDcoMaDTwpBU0czHKfOsD3kRCPDJqxDGazK5/MWyDBCVrH5MOhw+ZDjEk?=
 =?us-ascii?Q?rLhSRy9CUVskEPL4W2vrMgzDaiVeMm97i+6gH0uCfSCQzf4+9mU7TRaHr7XS?=
 =?us-ascii?Q?6FUO3byCOKreoBZ7e1LnRfSeaG/UQqBZJNEjKvvUUKd0lbHCwi1YqvqvjzSF?=
 =?us-ascii?Q?5bf+5sxj+vqEbiOHVFFW44mAfi3Cuw3I6jvl51ChdoA9zq5TPWRPnR9DF1zR?=
 =?us-ascii?Q?/uB9/BsWU0FyajeKhbPXZ1p4BMZqLIAzekOj6kN64eBTdhLfT5BlU3+N69gU?=
 =?us-ascii?Q?VO3Axhl5WJoDmLPveIqK2mHjQM1JiiuDACRfIIDA94rUtk/dbGwOGRKCpez5?=
 =?us-ascii?Q?FUmlCjii7BDQmkuuKZ0uwbIrLMdsK353oQ5PmYigvzFD5KJpt6uVOtP3dYMq?=
 =?us-ascii?Q?VTsbYVtXfTbQO3XkYKsQDsJDyPjbb/OnLzc3cx88vHl9Kl9tPmgdzsdgfeYd?=
 =?us-ascii?Q?ks+CZGJH/he57YcIl+dEctwDUJf7FBZ2jvQLk6TjWIqVIp7W2X4N6uEyB1vk?=
 =?us-ascii?Q?jqaRgjwTTd2IEKP85ofBCJLORhKo0sOFPsBpSw3e7fuaJ4tCLCF0v+IY2oVu?=
 =?us-ascii?Q?iagfU8CN/kJMKd6WWCFfCLSmyobexR2tQ3fNVNEYspqOS9Zcu/bJxmZk/+iB?=
 =?us-ascii?Q?+AX8c+QiCvwo5RTV5Z5K7DODiURKiLAHVIjC73jAMEUd3fW7qn2XOOcBHvej?=
 =?us-ascii?Q?k85R11nBSMgSVnKhDygrepuWIbF5CcaLOCOcuNEl4OA3kG/mf5W1mEO3jBYm?=
 =?us-ascii?Q?Oo//e8ZA1Uxu2Q/Zpt5prNOsk98OlLNL/EXEm+41QebGpAHQxM4YP7fgkCzu?=
 =?us-ascii?Q?jo9coRclTOrYNIa5KXeU1wIA5iVF3sMHxwvzSR9wpIc4k85cCFOvfc0fgaF8?=
 =?us-ascii?Q?vExaV9zgaHafxX69hgJyGR13pu8W41aHm3p/tU1ej3WjfkkL/GNdjRRBveOz?=
 =?us-ascii?Q?Si82kE4wFTGvJKXzKqpLtVQ2Rm5QNkMBCjRq5ficDZpfuoxTDBx2pzNC5tL8?=
 =?us-ascii?Q?3BnAuEUJPr8UHi3rda11YahiwtcKUBJMsz1RGwgE9Q16j+8iOsSDb5JIv+H8?=
 =?us-ascii?Q?3FEK0wLuUjWKBMYHAZVUoIplmuaVbJ7EbfQOaDfSUvwmf+t9HZiXwGo0O88w?=
 =?us-ascii?Q?sfUd4lwe53rqduCy88t9USN3crqXCXXWf+AULz2L4uF6NB6V64PZeTkTlHi7?=
 =?us-ascii?Q?IAMmyH433BPRqctg5KG9XHPXEapB0QdOqhv+zKx9Dsh6DAYoTc1WVHNAbjw/?=
 =?us-ascii?Q?u1c/Jt4UXw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Fz8oZiUYUrLugto5KEDvGS+lIwjsj4KadU01HqESXUJFUKhQ7Ihlc9j3EKtQ7Yu/idbRghABQS3jbHlB8LzYVPBt4dWV/T6HQaR9Lz8DCGun4KG/NE8lutpzTS2Dd6HTaQRzr6dCCbp+40pC2vpag3ExmrE+m3tEm+4MpB+T1adYEQAPP/G9USQLipvNhMGT4Noz35q2kHulapiWzHlfQVPq+b97W7LWbk7yLAMSl7s6H9CjX5EOR2yx7URbqJkSBHxt2YuSeeiblZb+ieAJIxhlQT1AJgWTSA6XwdYSVlVHcIee3/lzLZpLBLscxi6GWNXSGhbRdWaF6b0sP7DnDg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b09bead-4946-459c-0b09-08de8564bd65
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 03:08:05.3423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZyCNZPeQ71z2axhbee6gEIjXlVb9L/1vC+fzwrE1miP1cI0yq6aRndo8eqB/nW1ZPCodc1oXjDbbEr16Qy3Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6909
X-OriginatorOrg: intel.com

> From: Samiullah Khawaja <skhawaja@google.com>
> Sent: Thursday, March 19, 2026 6:07 AM
>=20
> Hi Nicolin,
>=20
> On Wed, Mar 18, 2026 at 12:26:33PM -0700, Nicolin Chen wrote:
> >On Wed, Mar 18, 2026 at 07:36:20AM +0000, Tian, Kevin wrote:
> >> > From: Nicolin Chen <nicolinc@nvidia.com>
> >> > Sent: Wednesday, March 18, 2026 3:16 AM
> >> >
> >> > An ATC invalidation timeout is a fatal error. While the SMMUv3
> hardware is
> >> > aware of the timeout via a GERROR interrupt, the driver thread issui=
ng
> the
> >> > commands lacks a direct mechanism to verify whether its specific bat=
ch
> was
> >> > the cause or not, as polling the CMD_SYNC status doesn't natively re=
turn
> a
> >> > failure code, making it very difficult to coordinate per-device reco=
very.
> >> >
> >> > Introduce an atc_sync_timeouts bitmap in the cmdq structure to bridg=
e
> this
> >> > gap. When the ISR detects an ATC timeout, set the bit corresponding =
to
> the
> >> > physical CMDQ index of the faulting CMD_SYNC command.
> >> >
> >>
> >> It's nice to see the ability of allowing sw to identify the faulting s=
ync
> command
> >> upon an ATC timeout! On VT-d it's not feasible when multiple wait
> descriptors
> >> (similar to CMD_SYNC) are in-fly... :/
> >
> >Actually SMMU doesn't know which device is faulting when CMD_SYNC
>=20
> VT-d is able to find out the SID of the device for which the device TLB
> invalidation timed-out occured by using the SID reported in the
> "Invalidation Queue Error Record Register" (VT-d Specs 11.4.9.9).

yes. but when there are multiple submissions (each with a wait descriptor)
fetched/handled by the hw and then an invalidation timeout comes, all
pending wait descriptors will be aborted (not just the one corresponding
to the timeout). In this case all affected submitters need to re-try.
