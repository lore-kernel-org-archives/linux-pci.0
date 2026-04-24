Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4D35B642;
	Fri, 24 Apr 2026 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014393; cv=fail; b=iWzV7UznZa3+x/t5Gm4wUKX1SnbUUEH79rHe/Gqxd5HAVUPf03sqXa1kXHXvM1ImOacqCYwdHvmyTKGM3/XV8SqrAcMtSzwLRnam3QIGFZtepr44vRDLm2iCZfJQq+zNUMfZ3ChQE8lVn9zkMaTsqT2VI26h/HjUrQgt75A7bGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014393; c=relaxed/simple;
	bh=WMaECpNiO82twepEMoLvTDvUKr89aIE/odrj8LyhE2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ll9BQ783GMPDiTlXHXp2+zfEIPjTECj5NQuM9ibHgBVkQJwlhwGEFKIyehRox5GsBLsCOr0hPkMnyrho53KzX6MFm8Uf1SadZM0Xx3G7+DMRO6xGvAUte5JFhzFmzyg6ZiO9pZSMzj8QASPRgPNIEQf+pvYxcDolErLI0C69/Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kexag+IN; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kexag+IN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777014392; x=1808550392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WMaECpNiO82twepEMoLvTDvUKr89aIE/odrj8LyhE2o=;
  b=kexag+INu8iAf6TNna1zZFpUrze266L0UZwQvSRS+tGl3qyChMonQgwo
   ZLkM8h5fHCytON9IwEQ6vGl9ItsArb1OlaMunv0Ce37yhQHnlOHjlWwJJ
   l6Y5Ajrti3q4CvU3mudCdnvjkxtQV6IzlCJorjIDInZsk+kgsXHpCYzQv
   pwCNC1rv2tZrGcjEq/6P3FLipXooQoQX/+s5HnTMCthaYdHdnpz/rd9EZ
   4MwnPSABw4p+4BGggp/J/ctL+OiC1i0DJY0U2LxlgbAukhwT9TCJYkRka
   CGGF4+yPAjQaWSfwU+DZis/LinozOnvyOnarGAJH6LjtU6XkxB++vPCoW
   g==;
X-CSE-ConnectionGUID: deF/wO5DSRmuO6Awz6kFRA==
X-CSE-MsgGUID: EFe6wALZQ9GPlZBwXw9YGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="100643938"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="100643938"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 00:06:15 -0700
X-CSE-ConnectionGUID: Jo+ZGRUOQBy+M+xpO/PLnw==
X-CSE-MsgGUID: ig5h6BiaTkGhEA1waXMHNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="232021977"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 00:05:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 00:05:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 00:05:35 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 00:05:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeah0Hr47HpRm6TsiNXyjIP2qIIf+zfg9fd2E4IjngqGnxCOxlEeG2N1Wm/I+MG0bJziZr78B2BVhhdOlIonYreYphYsiYK2wtU+Ge+OckesrouX1tbTybIUFyakKgVtTJs+wGbYG96ZoqwJI6fE/mDwQETiWR745qg/8f5QwgdooaACUtQxgrmx2By7dbB6NcRqoejtWeTp/dOxS4ad/p+FWB8Zjl+SKrlA8lzA7G3jhW9UDfux27oRaEkvTKTlL41fCRlNhapQm8/yW5Td4U4TtTBCVp5vHaN9q+E4/0ey9/ZCMSWrs+fI7lGKuHlDJ/+/el2nxpM2/0SS8yjiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMaECpNiO82twepEMoLvTDvUKr89aIE/odrj8LyhE2o=;
 b=iayuZTFEtRW15zC72W9O7lnwA2lsKUhq0H+Qq/zpUcNsugCVf52u+vec//TTlN0cmYdjvleCbtl1W0GpuMQDVSMUMvOfmv8DjR6P22rtBTu5bBjlKhVVOOYL9b25b9D+JCEOEWyX6d7sq1eUt6TTZ+BxQ/zP+YpaE7Pk4QDI1iVJZePdI02CEHm+PBLoLVNaS4E3AOyyy9lrx3s564wDmM3S0Mn8+ZlsM/KnrCOGmFzFcKLnmYua0EYua4i7H/d+pdZ175D42Y2xONbnkFzkB1MdRQrTEJn7rEqecOz/0jzOoqIBcdnw06gH8ngcoo+QLHynWvwN94d4n8UqjYuFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS4PPFE12D62847.namprd11.prod.outlook.com (2603:10b6:f:fc02::58) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 07:05:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Fri, 24 Apr 2026
 07:05:32 +0000
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
Subject: RE: [PATCH v2 30/31] coco/tdx-host: Implement IDE stream
 setup/teardown
Thread-Topic: [PATCH v2 30/31] coco/tdx-host: Implement IDE stream
 setup/teardown
Thread-Index: AQHcvgjvogdHY05lsU6Z4jsx8YF/y7XWckKQgBSOioCAAvQAoA==
Date: Fri, 24 Apr 2026 07:05:32 +0000
Message-ID: <BN9PR11MB5276DBD859A8122620EB86CE8C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-31-yilun.xu@linux.intel.com>
 <BN9PR11MB5276BB48433E1AF97E5D27298C582@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aeibi7JzfZ2Kx0NU@yilunxu-OptiPlex-7050>
In-Reply-To: <aeibi7JzfZ2Kx0NU@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS4PPFE12D62847:EE_
x-ms-office365-filtering-correlation-id: 3a32da02-24db-4ce5-b5f3-08dea1cfe02b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: gwHZ6pcPlZh+z7SrcJNBnYTdsw3sceNUO1tPhlYGQBNuSA//T6/zgZijPERPa4AMazRjx5mo6aK6ZoGWyPcT1vm2mRECib4I2qfVcNLT4AMl2PjROwt227y6pGwRmOLfIbdFtQHzzKLQZs/CnevLgPGZQiwcR/V3+8TB8YbQN4Xbe1NzC8ssHNiamjQhSrQ/wgt6Y7qKAAYAz0NzMxwXpquRYNsPWWWbC32xLdByBHCrYnQ2w6bX4VPs8jcioobY3iw1N7g4hMJWRAAihuJ1E5v6ZneVlTXRlpmqZm0HrUlScIBrIR0+QzzqtpRklZi95ML1FEPvX0kLYXGaHMhQB7ILGmBaByGY00bEnx9rlhZxcYASsG0YCvpwIMaWdhUaLNZ7bHjjFMrXT9niUtT5vyJGBUjoz1U9M8jXT6Hjf0Cjtgh4kwcJvAt33qieNK+N1ZemPf3kGQ6wKf66UtMKvW1QlQipNjg+CWi7+omgZJqScAcHDu3OgvI+Bm1C+QYQjSxSLWgu0gWYQDzMaUEwvekLvH+Fkjq8mDkuVtIkQrSiVd5OQFL7TVGdweQbc9O8IBzrQJI/hiJVz/OalySPSZFx12p4pd6LwpdEivm/pa3XlcUXS8bvfcyvqPuIjTvggVotFPaYge9yQwcRBV3oYVqLEF1JYjOqhzDSvCrDO/XEbHTq9GnIfnyEUl72DDZtGuIiRCk45DOAbmkZNc4mlJY2h84RtMvHfrBOLQyW5A7LH6dPo7OR8n827JhnNsJg8NMhNo+AOcyMMW8yc3EuEo/RmD9fJfyR4EAqnG9kJ78=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GPa5Y1x+J5Pke3WaboqbeHpTgqFnQDpgUmwsC+TfWBZgjalaDT3ul3zX3C0m?=
 =?us-ascii?Q?p2lPOhY/g8aJRimFtDRWZfZfW/TNvZe4ynEV1T1jMsEnXeKkWmYnW0U1qw4D?=
 =?us-ascii?Q?am8Q9yBvRM2oLfyNZ7BXRoDcEIGXMJUU9sOT7Jvaq9+MeoPy3hC2qWXtJr1K?=
 =?us-ascii?Q?ochGxBlf1NbaP6EKtN0n6yA9oqY9wBdm77RUtl+p6P0nEMB8BiHSM6EpR8B5?=
 =?us-ascii?Q?CullA3n5GfrBDARnWsAqtRPIJy56H0H4DFqm75hWb51d3Pd7UQM2hnBqRI2v?=
 =?us-ascii?Q?6xJMSHWRQ3QtEvv+JtYz0rwnIAQHnF7AKp3CATp0o6QkORO0CC7Trj+UNGtC?=
 =?us-ascii?Q?IdQBKL0rabbPPGhLnjz/WO01HBxF4gTzYCe7eu8wGFor0qoglVc2W69s42Ru?=
 =?us-ascii?Q?9e0ZSh5mjXX9T/9jxl4k7LjoHMRTMgueeKod5OIN+sLfHy8lVi/gcZd1lzKT?=
 =?us-ascii?Q?AHojqk6oRdYoRxZ6wZTj43DQJuS4feAv16cMNlV+DxXwZ3shjRq+wDz/0c2i?=
 =?us-ascii?Q?o/HO/VYT+XYqX8Zh00YONHvQuHEZlycvnvZdBMm1o6FGAInEYHnrnM8IoAV+?=
 =?us-ascii?Q?cbHz9X8QcCxwBQXHMvwpfEGG0zdb+3TENl1LgNnKRDweKB1QNmmp2A8MlhWZ?=
 =?us-ascii?Q?7MI6PYBMFT2/gQ9kCFZwZb/vBLWXOnUGR/TzVakIXf7BQ9/ke+lIhKm1EG71?=
 =?us-ascii?Q?cYH5+HOlW4I0VAYz4CWf/ouJk3cId0JnPtBvz+/kn+AoP8DNzJwXBICqPUxF?=
 =?us-ascii?Q?12Xs2+OgmnDp/IRyVB+RY1LwLNY0WS2jbWYqK23FhlRVQ2/VRM2It5dmKooY?=
 =?us-ascii?Q?iFs2uPeAUWG5DgT6Ux+3QJCA6hTf3kdDsle3QGjQakdk2Ppg5IXwXqlwRRAe?=
 =?us-ascii?Q?piHPu5S9M6+SW2dlNTkL6du2qHXQ/zxKelPeSiw6Zr16gxs64E6BQbaKQP93?=
 =?us-ascii?Q?0rei9kKr9Qx+QdEp7KqvYyN5wHrtQm5WkXCFEJ2coqjPKWbhExKCTf5aORXk?=
 =?us-ascii?Q?snAtkfL2imvyFKjRGRlHjq9w4XEyShRhiquCQdSmhYAEAro8moMvT13xEkuD?=
 =?us-ascii?Q?h+r5B7tTZ3S44QjpDoM6ejr7YZu2AphjShkLenriHUx8P2iI4q7zDAODOjmY?=
 =?us-ascii?Q?8Gcgw474AqfRXh7ymKth4Hl1pttWCnXkrbhmvSdLoFHak5H9aWoCASp+4/ra?=
 =?us-ascii?Q?GnlRNHZxTsCc6AzzsAi5S7DJ6Hs+NlVv53b0jGv+ClN/GJ4YmQUXfC8m+qtS?=
 =?us-ascii?Q?csaXYpclpVceRcfckBxfppKeuesaWIRyN3S4TVw1X9YiBVIVg00OaHem+pkk?=
 =?us-ascii?Q?ChSnbL+hi17kRkDANCicvv53zq7Xx+DAv1ZDMSKxA2qbSUVpLhyS39+S74sg?=
 =?us-ascii?Q?y/J6x4QUDI6FD2l66MOdw1rUIPcUAqgYoleaae5JF9okicKSbBIRAgfHyBCQ?=
 =?us-ascii?Q?DajKa6Ue5qRD7CqpUBOZye2kLcSuxWSlQ+/xcE6xavtwe7QTK5SAhXW9hEHQ?=
 =?us-ascii?Q?jac7e3HagLuiKWR6KQSZc2ybvAe0KV1kCwF7DufcK5T0f52Uy7UYm/nvVL6y?=
 =?us-ascii?Q?RFfU8tGUS0lnoAban2heL9uL3Zanae5uFuJce5VsMehxKRD0fR3NaR2fGurz?=
 =?us-ascii?Q?QZj47t3A+tsUcDmsMrP/zNMjqrVwoxR8N7y+TEW91zsRTcDKs6l00QZEyjKB?=
 =?us-ascii?Q?I/cgPXLE29B5K5OXg+ZrC4FEnZ0q8rRizXjEp86KUvgk92jk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: whgvOYdj0JOoXl1JjMa9hbHTmx96t1jBLLTZt0TmqdkNkvRkV7XQUYZllAIzLk2oS8GDJs4PM98Jhjd3sssy6EG9C4swQSkK5KYDgy75xK8k1eTHt/WEqGEbVQD0wO+FG59gNUmKMkMsZZ5sBPKsbm38ZZNCGQfCOqh/lMSnIhjjTDb8jq4A5ASUtlrpwgvQ0oM9Zk/VLDTHn04xOj5LSBEYuUwWXQ9Z2wZaNowQ/rHIP7M5hbJb0awccjxogqWRVWARyzSgkmQHAKOW3l67N+x8syH4g7SDmVzetF8CfgWqrk6NELb2dxROHkgyyj2x+yog5mAZFdxsEkivxcxaFw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a32da02-24db-4ce5-b5f3-08dea1cfe02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 07:05:32.3963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSTm0VT40X1/EL9hCWJ6zC9vX0u8xcf4l1d05BSFYEvIC1j1C/sF+1o8CcSf3D46E0eEPI/5gLAQfzbbk5wzRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE12D62847
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, April 22, 2026 5:58 PM
>=20
> On Thu, Apr 09, 2026 at 08:02:33AM +0000, Tian, Kevin wrote:
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > Sent: Saturday, March 28, 2026 12:02 AM
> > >
> > > Implementation for a most straightforward Selective IDE stream setup.
> > > Hard code all parameters for Stream Control Register. And no IDE Key
> > > Refresh support.
> > >
> >
> > 'more straightforward', compared to what?

a typo.

>=20
> Actually it is " *most* straightforward", I just mean "very".

When you say "most straightforward", then I want to know what are
other options to compare. If you think that the thought practice
leading to the 'most' definition is important, then please elaborate.

otherwise I'd just remove that sentence.

