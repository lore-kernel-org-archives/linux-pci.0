Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188F832FA18;
	Fri, 24 Apr 2026 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013859; cv=fail; b=n77rA/6kLYK2IiBw3COzYGNlV9MolNgBr8+KNhhj5chbSc7MYRgihLXY/H/soOI8mG0DPFYRQoywyOmY2+9zlC16vDo34O/BaSGZn/cTehlVc6LP279T/rxqxom/CxEDXlAiwMk3y/sFWU0QpzmTNFM0ZL5Cg5u7zdFwYZmlhSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013859; c=relaxed/simple;
	bh=I5qF/X+0uUMGjcHpIZsxPaPtYCpEYPc5XTE2wb3NAg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pY/UKlENgIySZ3sOFpPyBbagddrTCQ8fv64q175Q1Th2CjdPjN30/QASjEJW2AUCkuVQBEH41j++ETo3l2zoDL78SeEeSvVrbFnX1AjHxCvuVFk+NJSur1CLQdJNzgrb7Gph3rdKLV4IYdq+eASTECCJWXu1igOZ69PkLZBcSiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1GtClhF; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1GtClhF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777013857; x=1808549857;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I5qF/X+0uUMGjcHpIZsxPaPtYCpEYPc5XTE2wb3NAg0=;
  b=O1GtClhF4waCfKOLV2Tegn15wb4lhP9Owq4KXT4L1608wGFIdFeKwGn6
   7uwWY8ITVDKuLYoBhFaril699eka+QjL/iv2tDYWYyyDBw79iiEoM6fDB
   iuJGwXfBxPTAGqRdpADrmFcW/xDTFr8FMBbkfn9afXuSqyroQ//o0r0fO
   ZCv8Y8UQmhRoWwlDLj3MwH8oXu7XyQnPmg42T7zrcCPni32CLz3e0mD2d
   Pd7/HyF8jafwzMQeMVNdBNYqg7TEWLuYAeW1+4iNuJ9gw8S+1/1/dHseZ
   cUWPvbnDV4RA5iYlut1d14NyNht8WM62TSEWKbOywPDQAObp51ccLa+bv
   g==;
X-CSE-ConnectionGUID: Xb5Bb1j2QrWsLprMeYq1wA==
X-CSE-MsgGUID: 2CLcQcGGT3eWJvDjmnEi5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="81851919"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="81851919"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:57:34 -0700
X-CSE-ConnectionGUID: +g6rwUlLSoGZKhfBxa+gxw==
X-CSE-MsgGUID: u5we1ZfmQ124bwnSKxl3kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="228312083"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:57:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 23:57:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 23:57:33 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 23:57:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwENW948Q6D6tKd3Gy9LoNZwS866RePgwoWY1IOyIKq9dUgWiE5FAtcRAJzZPTF2SdWBPu7N/C43GZnluzo7ySoHEbymKSF2/l6XtPG+C+w5WGqA60vgZF6xF6NSMDrvdvgANTE0zu7WWfmBaTJkfEIcvaa5inaiOc0rkumgYBSVrkyQCxlXVRzOa5yreGJpjKghNJuszDgmvyMKxAEQNPphtZyjF5q8ZxXrOOxoQSTbFHH0UgHGYDfooUSKO5FKyfRL5BVYjzh7DUiSKYGjrkHMjaZxgTeK9tMIsxtme6wdM0HsdnVhkEo4ATFjETWxCzGmlAEExDYHCkp8yb4AJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cadR33d5XLEyTRgQSnlER4Y+O7UBsmFGmMesShUhDw=;
 b=jKCUswwVO9DatiN/5lOo3d/hs7cG5KGNdZlnvgD+8H3gGpY/achUcmxuXzKmXo9qLAagbhu9mIpDX5l72KZIsK+9Vb0h3yBWqiWxEZnUyaUTe0kmHvq1iPso4A657E5eW5HM49bKxNwxGOAfCAeq8Zi2HyNn6WxfsdijLiTFvM6DBlunnoi3TeG7CzsXGJEC+bHrNUS4UCjMcMxcgNyhzZTac8DK5vCNZjdBgb72EQt6ao1GBcd5mn+C6kLpYWTQ+/YgsYXHi4Yx/5oQTZbQCmsmGHQieq845HKDyZqDtePI/LqEGL5ZCiCe1BEDnAMfYaF1CeasoR/fHWZRtM8GZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8594.namprd11.prod.outlook.com (2603:10b6:806:3b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Fri, 24 Apr
 2026 06:57:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Fri, 24 Apr 2026
 06:57:25 +0000
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
Subject: RE: [PATCH v2 20/31] x86/virt/tdx: Add a helper to loop on
 TDX_INTERRUPTED_RESUMABLE
Thread-Topic: [PATCH v2 20/31] x86/virt/tdx: Add a helper to loop on
 TDX_INTERRUPTED_RESUMABLE
Thread-Index: AQHcvggzhGF6VQdglECApq8R1gSDzbXWZkBQgBRZh4CAAzNHgA==
Date: Fri, 24 Apr 2026 06:57:25 +0000
Message-ID: <BN9PR11MB5276D67081BA18A5CCE6E7D18C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-21-yilun.xu@linux.intel.com>
 <BN9PR11MB52767E6C22CDF7DAD9D5FF1E8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aehk/2DEizc1eG+e@yilunxu-OptiPlex-7050>
In-Reply-To: <aehk/2DEizc1eG+e@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8594:EE_
x-ms-office365-filtering-correlation-id: ec74ba29-95f2-49c5-8383-08dea1cebded
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: UqMKV72O6RstU+C737myzR+0pLiVrh8PbTXUktXE6CwuNZrLekxn3LaNl4rQXusSrBKw458j5r4JK6EndO6GgbyU+YwUt7T4vb3jZQF4RwbXeQuZSgVsDhmwZ3c0ZkpBzVeU8fsy6VrMdGoyU0A+HJeMV/EK4H8dFz/z3MF4HdAwE0CgB76cz3hdLx+zOWDS9d93Skt4ysixitN/sv7NaZ1K+v9sYZJcKIs/+ikeXtbyc4hcait9HzJt3ZIetOJzsxEoV6ZCh3ckJHYbyc2mO0Q+4WD6UgRk0lmdR38dhU8+e0bDvSfl/ijpKnsJr70DcfPT2x1VxXwkTB+jN3poVLMWxFbkTjVLkdo1DlepelbKSmrV+KdqG/9AuJCUUaRLpqZuHVH/FAchqaE5ol6sAUlYd96jQXz1L9A2ZhEBbA+tPrwAkGvN5/U8jwoOuZM0EAkuYocS+c8DwehrmXnVWkFOys2AnEPjiKf8febp9RMe+fJ++7oSvPTjs8SCfCUx2OTWFFsTNRwX4BqMJxXF+fXyEyGFey48Xe1ziLVjO6VEXA410EH5tvAok34kc0x08GbLeZSuadc06o4K8IefYGBR/6ZGn7rOc1u6RxUGMeDeo2OUcyezPPPtxZfA1/qMeXyBRs1oVQNNyfUIE4j5jy6inPNA9sSyKWTS6mQ1cq0mdcFY73We4ng0K5cZGJYh1J/m54j627QB6LPX5E8ut3JO8WfR9WhArzMxI+3MCPYxdt64c6rwMfDpNDgvP723w1pidZBz2Og5lgedbAcU2X4RWlpBNd8S6Ig9L8ov+w4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(38070700021)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?veJdp+OBs/5TkjLGb9/VcZ36a4KArK5rO6v0XlfE9AV6JGY7cmyEh5nqXh57?=
 =?us-ascii?Q?OoaBgVQaQuCqx0XN9yQbqpbS8kssrtAHJVPlRkJDTEbA/cnlOEng2RGUTAgp?=
 =?us-ascii?Q?iafU56tvMb/O6xNHrB9eQG+Bjaj1wdX4x8eWzOcLfiEsZwOlyP9y/3rB7YVW?=
 =?us-ascii?Q?fcdOuONv5HBdSRbjlp1JJTWDHaS5HrHvOsk8KTFewVQl32L2KZxs0UtplEZD?=
 =?us-ascii?Q?tr8jwUxZ4LJ4uCQSVVrBs5BL0XSjETN70mdHg9QBECs4+63bNA4+d1MZub7/?=
 =?us-ascii?Q?tEZsYeR0AiQO4vftAyJAnFC7uNF8md3omVezDe4S8b/7UGkpFYgA/0WHkpIh?=
 =?us-ascii?Q?C5aq+jEotkB1KLhmctXJOFIL5dhkTRovxBtBM9wxro8bqMP/QS/ZeGfK5ga8?=
 =?us-ascii?Q?jSOJWFeww8TMtnnd588N3464kXHGiRBE8LCNRfRAcUR4D2lrrxUitATYAfjS?=
 =?us-ascii?Q?NVMwKz7PiGQvWYVth6xtIe7RnC+8OXTLpZ+BjdwPQgs9/KhTNOObGMis34uO?=
 =?us-ascii?Q?a+b1EIpB+DV5BwHkQa8W9D9OshA55NxPCuxNwNQ6DSgmvT00LnY0SQMTC8jT?=
 =?us-ascii?Q?PW5iUShDwq8yyFyHMhJngb2+AkfuaulzphNldzvhqQ2LoU6zyR5djtSUwxQD?=
 =?us-ascii?Q?BI2HGFqADZoSr8cB0ScPG2zhIW/QSqlGbxT915wHnje4aEKtVkjNrV/qiY3B?=
 =?us-ascii?Q?l86B6YuuqrrUuF9b5TmZoeyA8I7e91KGBcfj9DH8c4HF+fozTfjnuVrnTwFj?=
 =?us-ascii?Q?0gj4i0Yln4HykWNdUusw11SkIb/4q8hFXAXOolBF1ORQaSv/xzOTkHOBu51I?=
 =?us-ascii?Q?F1ykYfKtxWPDjX8Ay4r4/cIK7gKNRsdCnMmGDQkKzZJmMj3CeFDya4zHIo0/?=
 =?us-ascii?Q?7Rr/8DU30F4SJ4NKtZMpbG7Hmbg5IZV2mJh1bbdr+Bi57Xd3dcRDLV20x73I?=
 =?us-ascii?Q?6IOlnidek4XH4pvfS6Ylq3TU5OqIC2wlz7GMAkboTQjhJvPPh0OiL50+uMag?=
 =?us-ascii?Q?oQLjXZtHtZcrhkdxnnvtMyr9EEGfZp/wm2fQw09GaZBrA9uSn8ZO+7YJeUgR?=
 =?us-ascii?Q?gleV/B06CoWGBwNWsTGVfeEfOWRdKlirFuOG127Blt0g5AgByz2sCUlK+nTA?=
 =?us-ascii?Q?5T40y99QWyvJwc9S23is0qLISGILcyHvyd8luW9lmQ5NAxD3rerWEH4lp7qT?=
 =?us-ascii?Q?58ZD+kS9ffwxnqRjVkWom8NVMzSxTtT4wI2WQAwvDpenNYnw7CvY23c2LUe2?=
 =?us-ascii?Q?U3JUThAnHxHc5KqTWmaf9uMLt5N1S8YvIO+Bh3A9P9RaUs7lc0/FSmASIvNL?=
 =?us-ascii?Q?Zwi/fZHpNAYGpsxW47JUDX47k4NDWyq4nbWGg9BvH0vjxtVfXiAZo+8HaCo6?=
 =?us-ascii?Q?HaEkNUynrCGzsDp49YkOMJuyqYKavGMBAq/bRP3LqFMnGhTyZALRVn0HrzcZ?=
 =?us-ascii?Q?z30g2oUBG+kTQK6ZtWrRi08qDw3mDxdeJciz0Q7rQlHrwVD5fELsPkylVpUH?=
 =?us-ascii?Q?wR1521CXYhvpNYGBOlsoLJquj3cxTnATW9pCxdA6Yr9U16Sk78AOoCO8tqMk?=
 =?us-ascii?Q?mTvWohNOD7Bs/0k7tUra14kd/eb9KQGq/rfdT45EQBnvlT2mabNdpkSTkwAg?=
 =?us-ascii?Q?743saGeqF4XufDYyERkpQTvOq3NG8AixkayM8KWehAnG2wYsegcaQ1iG+El/?=
 =?us-ascii?Q?7xrTl+o2jrpjZ4KqqU2rnT2sVB13D7x26itmG5mcET0cmv0R?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YIOpsOkvkHlfckv69Vv2NIIItRcYYUXUWhehzmP7vdydgoTGVdZuWjB0NqSNEXzJVTysxMA7Nt/RcWMOyWFexjSQ1KFpnxTQPkjAMSvkdcYHwbo1djbVaBiY+D6hv9pkQeJ/RmyOsa1e28iJSzYtsD2ooRCW8A0nAKQ1zOlaDOZ2ibCq5o5e7ZWPazb8COyN5EtiSNseUc23bO2WZwaXDDf6mTW0iD4p/aLLzOdOV8ZOR7k20GTe7YPyY70Ck0L7O6erhLzipoOrRznRcPoS5TsoZaFfsIU2gksHGo5vswVc2TvPGN/UyfgaxrG+oVkiSIGZAfX1dUzue5axaXHQNA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec74ba29-95f2-49c5-8383-08dea1cebded
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 06:57:25.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nS1dYXTxPpn7a4uoGmdnlBpEhqCGsF5aV4Z/oBDWLeuJRci5betXOvJ54tWk8DZoNLpS8FPDZJvp30fSSIRt0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8594
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, April 22, 2026 2:05 PM
>=20
> On Thu, Apr 09, 2026 at 07:21:48AM +0000, Tian, Kevin wrote:
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > Sent: Saturday, March 28, 2026 12:01 AM
> > >
> > > +static u64 __maybe_unused __seamcall_ir_resched(sc_func_t sc_func,
> u64
> > > fn,
> > > +						struct tdx_module_args *args)
> > > +{
> >
> > 'ir' sounds redundant with the trailing 'resched'?
>=20
> Mm.. I want to 'ir' to reflect the loop-retry is dedicated for
> INTERRUPTED_RESUMABLE in TDX context. When you say not big deal, I
> assume I can keep the naming?
>=20

that's ok
