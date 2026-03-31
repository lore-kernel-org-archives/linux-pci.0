Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D603D647C;
	Tue, 31 Mar 2026 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945450; cv=fail; b=qwn82FNRifj7S3apjDxaFnh8rjcD9fjY03d8gWRPyT8ToBtXN45lJFaMBHh82B/U54GqSztRYdyZ3x+FymAybsHGdQ17GJiLLWxDwMV1lBq4UTNpoQC51hghR1xnwCM+1teoXrQt5eceDuBERnTwjAyLgmvCek/S86vDv7JZmmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945450; c=relaxed/simple;
	bh=KPCB93UXppSV++8KdKwB8C+BvgLSNB2DkBl/MqGXQLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ByWQN8pt4APMKjAFEnTI92cMQ9RNYzB/l8EG6ZKJEv7gUZBQhRnALEG753MFnX9rlE8Lb4yX6xOn1AScMrZ6yRC49Xu6rKP5HhSRejYL+ZxnTRBO3v6ks38aO7e2r7mNnfUpzraP/9VjrG07aFupuJONZ3dG96LhgbKgfe41wuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfPDYxUs; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfPDYxUs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774945449; x=1806481449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KPCB93UXppSV++8KdKwB8C+BvgLSNB2DkBl/MqGXQLc=;
  b=cfPDYxUsRoR0x9Mz7tkfw/NJBQSGFixtEk47KX8iXjDy7uP8GO8FWtxP
   ko7kOiouftKirGLCP8X9ZtwXrGT03vKIaHX9IUZt9fDgfaog33SwY3jjB
   AvzaAp146/zNPA3Hr8a5Z++V7tKRAgN8o8eAGMtslQp6J7lYLSGJo/ikV
   M6cmg3o6yf3VvOrhwq1i0DhF3wlRxYQNu6HZ3ojCsCnSxH83mM0MDb2uy
   Td/Djwy1LY4UMOrMSU0jUsmoKHaoNXUOLOhKyrJ8CVI+SoHhuy8Cre/Zj
   /vW7FdYWK7ooOl52YDuJGpJLQAOL0Ii1Kiv9PCDx1j981wZL0PPwukaXc
   w==;
X-CSE-ConnectionGUID: ETh9O+M+SNmkOdnzA/gGKQ==
X-CSE-MsgGUID: St74ycYmR72Bt/MZuwr+tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76060813"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76060813"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:24:08 -0700
X-CSE-ConnectionGUID: 1Y/v3o3LTc6ukkdrvk1lcg==
X-CSE-MsgGUID: bsz3g1dbR+SCl2Pu44HfHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="226266615"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:24:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 01:24:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 01:24:07 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 01:24:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9CcDfUXM+UnOqaGhxCZutcfAuAeVqqplK0SDPBrxCmdTsBCj01BXXdyvY9it2wKQNga9IKptKfEgNqZb86SBF4o5T8re5bPyt483wJShXIed/sLy4FUWTTWomA+dis/Zje0gA00O7kbI+ewBiZglINg/AJoBbiwSY/5DVFGqVwaeq0cbQMFzj2RTqv7I6+E7WOsKDcYb+2oHqSkfxH6crPPClssjmZ2XstRUXorR5tCrJED7Jv7wvCWVtOF7GkqkHXgDthKpqPp1dFBMTxQC3v4Ava/ZQYst0xJj0SHEBZkFLo9U+ap11stZZhgkj81ouFICopo95vMB53WJ7/Bsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPCB93UXppSV++8KdKwB8C+BvgLSNB2DkBl/MqGXQLc=;
 b=Qf+4nvDJSaCuQ4/G7AczrkkCWza5Rd0E8yTB8h5YPGrWRX850QHMl8hIln48CVdXPjxXq5X9H9JBTWx0YwRpuE83VXsR2JoeyLVhS3wSDyF63Sse+rv+LjfL01MHOBijf5LHQa9MFyMI+5yLxFE1qThBF2QZIdCUjosluMllWxhOziTnCueSf7aDT0hKuCsrp0qM7lMeIHn4ofkAqlxI22fD4nqWqeVJ9hP0MeDPJcr08lqueCyeC9Eqh6pFPArpPj+PeBmtccr57rdIuzglCFskINQZkn6EEWzFb5uF6eAgZ1rj9j3PrQWvNuuHdW4UjtJy46Q+9Ll6FIW0jq6FMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB7656.namprd11.prod.outlook.com (2603:10b6:806:320::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 08:24:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 08:24:04 +0000
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
Subject: RE: [PATCH v3 2/3] PCI: Allow ATS to be always on for pre-CXL devices
Thread-Topic: [PATCH v3 2/3] PCI: Allow ATS to be always on for pre-CXL
 devices
Thread-Index: AQHcrcLX65ghV9t5KkSM2KshXNxOMbXIc0uA
Date: Tue, 31 Mar 2026 08:24:04 +0000
Message-ID: <BN9PR11MB5276D646118E74735A0B15208C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <c715b10b49d50eea5429454108d4221c1a78efaf.1772833963.git.nicolinc@nvidia.com>
In-Reply-To: <c715b10b49d50eea5429454108d4221c1a78efaf.1772833963.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB7656:EE_
x-ms-office365-filtering-correlation-id: 9a0d306c-23c7-4fc2-b59c-08de8efedf16
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: Uc/xit0G4U2TNqCqXVTk/Drh7MMweySy1WWSVBucuMWOOlXPSLsNTDTK9ouHR7vS4y37qOAn4U1nljbR8YFtsZfJCJpRUp9QNqIuUIgUPphbYJXFHdw68wy84UYvADErThYRJV/qzrBLZ6jadNp5rlWw6m91IjRWBT+H+OjdV5r91f7s0FLhHZ7P0EoWwn21oQntua1TS8jpz3967pXOKaQgO9FlmsZoPIUXxjbfKlmpYQfPKJcZF5v1jDqyeXMUlq7u6yVQ9VMNvX5ocZ8J/xOiddz/56o/Ry5miCc47OaUGi6G+KLSNobuZkkuL14u1nprvTBaDh1YTNmcdcAuZbvDs8tNn1tZqmegW+rOmHvoWmeFb2F85nOGaGZz0oF0CS9pjI4GCqcC7CZZaXp9WJxztckrqBjgAZw7BFJ3WldOfkWIL1onjMlfBb6pNwsH8yY9G6oE+OJdRVyQ8I2Gf4JTzzpHV2IoDuGEkE7i2q8mo4WqGhIRBV1LEs/oALTHV5oB15z+xNHNr7w/puFYW236LPEXex+kgmS+iiVa/BhrtFoSMuaOaG2cdUT+773BCR0JukdDSXggM4foWaBd4wjCT7ypD4FelBwqJeVq+YEfY+ObdMM5gHtiZ0LhnsmcMKo91wS6sXpIXrtz0TZAjrSGwElBwIFCjGtfXao57FKlpByXg4kSsLbH+nmw2Kz5kidGpBky2m6JVJffgfN2Hd0i81ai1jhCTNNRmGsOiKdLS62T9XrYorsz8nxfwioQIkBDws9qYHZyEt0UpDYuEo9iVoenstafkGpn/0TkkvE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tty3rZPSo+KrV4C+NlcJ0CEPqG1XdB+RE3GOn/o3WDIKuUufQQmNpObDqdey?=
 =?us-ascii?Q?oWM9Tg89GFUPK4U+kIO2RTN6cNJKGY3M9ZSbAuiO1H0Tk934JvPAykQMcqJ3?=
 =?us-ascii?Q?mOH+5IN4nkhFnRWCmdyU/59SUvk6BI/6qsUiLv4mQccOrgn+QS1a9M5pWOPx?=
 =?us-ascii?Q?u6H885+NcGPQm8dJVhInjHuMCOljgetiivc8CeXOhhdyo6yIHBlqu/te1sim?=
 =?us-ascii?Q?EfkFqJMLwdYKgJfA0btIF+sKsMpc1EaBCOxaCeLydFZcAK6cjDPP49B08epm?=
 =?us-ascii?Q?bJ5hf8TwUydDXoxyq860QWB8nFFihK9e0vmWJfIMYPHsUE7EhB30M6T5BbBI?=
 =?us-ascii?Q?gl9YHMap5/YHXBJbvoLgP8O5ZufpvML7j/vmxnR7AggSTqy1T4c0Jqv9ECEG?=
 =?us-ascii?Q?RkDyjHeRFMpC7o/0yl9oEHNnFX93xgfvLoUAgh2q5tl8g1pPS+bUmNyeI3OH?=
 =?us-ascii?Q?dl0cGC95DzcGSA4Vgvx16ybXrbCWwarZMYjxXxBlg4cUW/NlGrmrFMKBbVph?=
 =?us-ascii?Q?s2gTzAM83rYOItJc6m9tmIJ58ri0jgVypynASE7IWN5c1SHD4waV2sEFDh12?=
 =?us-ascii?Q?1GzB+e25++2sZ80mREXB4K5OGhhNxGXqgqWdI3yYNh7mPJS6pVFxnJwek/HO?=
 =?us-ascii?Q?JpUqVUpo/x0QpPyZ4XxMft3nxroWjTQZMJ65vCOX0YYhaX0QWXrmw+Vu51TR?=
 =?us-ascii?Q?MHE129auadCXx8QRgs7oYHn195wamE2L+6Qd8KrmKCcp1ievMBBG2BjaGTCR?=
 =?us-ascii?Q?Ns8ndsjIcNcpCXk+SiBE6bACIsmj4NI+hFhhio2BBAEE/DmMBdUcJKToznq7?=
 =?us-ascii?Q?TrANHShbfM4WATFrEgIFpFKRBUJSl4iD5o+r6HLSPspiEJmC5D7i9tgF0CCF?=
 =?us-ascii?Q?61s8kSKpVN7Thh4hdn5Uik4VmXKE9+5PsZdGwzeDxTKqk3qQlKeu+KxPHPTv?=
 =?us-ascii?Q?Gs6HFssKR8K8BCBcwMHtf21ihpEqJKP8gxgEksw9p3teXBcz6GtufgjqlxRY?=
 =?us-ascii?Q?lGwcYES35gO0EyXlYOEVyttP5KJU/yyJtvWs1cMEIPQL0MlPH9R2pnYDIeC/?=
 =?us-ascii?Q?rn31kVsoMzRqgt3+sRWmT26vpNPeRTzKUmZecdIGLf16UNDyFlkYqUt1IiIz?=
 =?us-ascii?Q?iQBkAOkqhqx9vwp0QdQUHNSypnmd62hJkSoYmjejAOCSxTymrq0lv0T/rnlD?=
 =?us-ascii?Q?mh7n+2xJo+6p7l4Gn6NaDV+WPE4MwWyi2Zw1UATS12lmCqfspDF8tBLyr8o2?=
 =?us-ascii?Q?MQiQuLh1vyPndyneUci0TyuVaXzSqHpcQiKHBfU41MhCc8YFvBolmy4qBdbc?=
 =?us-ascii?Q?Z/vGOqHtHgEbGtz3xpQhZnmuqK0keVz1VUAcTIuvJcU00V3SNRGuZKNc0U6x?=
 =?us-ascii?Q?VFDuJOSepfFcx+8dx1sz8PvS/Ir1l9i4z/6HOmmoBHIC37UBz3i0bBYYPl1n?=
 =?us-ascii?Q?CMWkaNaBmkEOnMxtNILE+RUBX0dY3ixE77e6lkRIOqjEnRMruyibTIwqZM/P?=
 =?us-ascii?Q?LPl9jNlJAOyreG1zWp44rKZdZuiqtPDQ+fd5WSpccqIV/mpct2nmHAtgjg6T?=
 =?us-ascii?Q?noBIK3Wy1c9ISVkifK1AuKkpBa0yDp+2bJiO0IjghJNxTO/t5tm4VybttTRD?=
 =?us-ascii?Q?H9wq3zcBnKhRcjltGQUa51bkym7DOwJqzcpXC70h302DrfY5SUtMuPnkS49Y?=
 =?us-ascii?Q?qe41HKS+nPpCUSAanZGf8fn5Bff0qDdGrE0gSvW29e7jnrT1FxUeSi6WMbxE?=
 =?us-ascii?Q?owSq47lWwg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: grZ1Gfwz+eAw+1ewq3mNwZLlTshDW/lCvs1UxJCq/slKXHj31zT423VZ+6SEBN1Nbfl6/IPHxnkAIXvf0Xo00Z2DEPETjqsdpfopKNuTTIa2SV+JP5GV0DpvMvU0DsFFWZ1UJR4Onc+D0+qfy8I2ZwfBKPa+1ut2L/Q7zHqafo+QHutkcTCWp9gnNIDChKxgs4r3CL6v6kMHltOIhURlUhPrwAHtTZbDdU52ywrFx+3WGePXQpzPkh5XXVSEO8PV4FNQJzguStfXBDEEbUsYmDXQFZhAji2lJRjtSB9C6lumu7oVEet/Nnk+AizT7oRUG7xbxawR7pprRKs0sJfveQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0d306c-23c7-4fc2-b59c-08de8efedf16
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 08:24:04.8685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69oa5Bvc5H95A+UIM2FhTxy0E0Yjky+9M/rIFEeCkAyq+Hf2PbblICdS2OxdqQgTgUTWNbjgnljAF8AGQ9YPuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7656
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, March 7, 2026 7:41 AM
>=20
> Some NVIDIA GPU/NIC devices, although don't implement the CXL config
> space,
> they have many CXL-like properties. Call this kind "pre-CXL".
>=20
> Similar to CXL.cache capaiblity, these pre-CXL devices also require the A=
TS

s/capaiblity/capability/

> function even when their RIDs are IOMMU bypassed, i.e. keep ATS "always
> on"
> v.s. "on demand" when a non-zero PASID line gets enabled in SVA use cases=
.
>=20
> Introduce pci_dev_specific_ats_always_on() quirk function to scan a list =
of
> IDs for these device. Then, include it pci_ats_always_on().

"include it *in* pci_ats_always_on()"

> +
> +/* Some pre-CXL devices require ATS on the RID when it is IOMMU-
> bypassed */
> +bool pci_dev_specific_ats_always_on(struct pci_dev *pdev)

clearer to remove "on the RID ...".=20

"always on" implies no condition required. and adding IOMMU bypass
info there is confusing.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
