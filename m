Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684130CDAE;
	Fri, 24 Apr 2026 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014131; cv=fail; b=eDpNDchB1+iab6bulaO5cp9UdREmFG5g9/aaMf/rDQtdI/D7OO3GJ4ZUk51d9pyH7IUfyQUzPQSJflKh69tRoD60SidOuSD2ZBZQLn/WdhRo1dYgerAhhGAjfOSj7Zeh2lBMZtnYOrYxjJh9ioIVazskdbELNFFM3mUInX7qc3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014131; c=relaxed/simple;
	bh=Cm6TX1B5+XHlLe6EPO9l+lijgMGjMjDNfW8sIECcq1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FMkPrdV2oQK3a5n5o0uwgkOc2kUv6zrhhOhJGXDZU3xPAhEUsJRsHuTuEoXaQ1oQ7l27/N1bsEO8GeZKxtMXnrEdM6M23oXHNSbMp/2yLnJoFutYfD3zzr1+Id/z+3+uHC9TUicGEKJbF/dUa0TxFDb/+//r38o0WwsBoRInwj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2RXjFz/; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2RXjFz/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777014130; x=1808550130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cm6TX1B5+XHlLe6EPO9l+lijgMGjMjDNfW8sIECcq1k=;
  b=U2RXjFz/IzqHbPJtSX+XdSSYDPvek13+L2zNinNbhg8bAl9F9auTEhxG
   Pv9oomKyq7W4lKA0zZQSDSMMxYmI2ObRXeuKV8naLoCdpDXXx3NC9AVOF
   WDJs1y4xuSY5LAvFOlzcYd5C1iWSjO7t4J379ZqJYopCKBho/yBI4Q2Pw
   1waKLcGwVsrsFeyQmiQ3o2CKpuVMQ+ZfXuswJYfHBcHzlIALbl7m/5Aca
   3RK81+rcATaTidttG8B6R3izwBicegZEYxs1XxPVqcNQHE73QX6GtG67z
   e0vqGrZZKw8OULyxqIuzxb3l8a8OxjijH3rLJAmGktQS/BsRQiIbGOBtX
   Q==;
X-CSE-ConnectionGUID: k28EpCXFRYGg/uHZGOtPXw==
X-CSE-MsgGUID: L1WPukM6S1aFUk9aByQKZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="78011960"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="78011960"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 00:02:07 -0700
X-CSE-ConnectionGUID: ocwgcbyfSoeUvyT0g6ivYw==
X-CSE-MsgGUID: ccfiGSrfS66Gy/VKuwPf6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="237878150"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 00:01:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 00:01:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 00:01:37 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 00:01:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLVYVWfc4m499byL9nnPa/9SE2U/aDY5+4TBUZZSS97XRK50KVYXsPr9jSQPsHFSprMilpgaTyI9yDLKjTcG3wjn/neYH3W6hFsmxrI3Vod61W5U5zOlNdGm0PQVL+puBzy7/t1N6GuH7eg+XiX2fl6D9mZJWOVeFZJR7N3Tf8u9WwP1V5KWE7UjEH9ea+Zm+0mePTFXTowIukEzB9YhE6iOf48bPYZYdKboknAY2oCCOHg/FdGpsozWiutJat3bbD9kCCB0q+KXFxrOgFulun/8bmIB5XCo14ehJ4MPiSiDsTACLwdRQxwaDKtJGuTH30vdNZ8Oqw5IyrqLQywqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBWV2Ay46WwP+Ot618uqIdMxeEaSUeQjuTg/wMgbrCk=;
 b=eD0LfpN4F7P94TgVKSXng0qB3POX0KuYOUv2n7NVS95HUkbI4drb7KwlftPgMCsxejwD8LPfwU+vlctKQNFdpxCZdo6xJd7xY4DQgNi/BN5dE/WrRnvzz/0XUHJXDnWB05Nr4Os1FZBwi+4x3DPQWqB2giM/ElseVXqFoJreC4cXAtjId0NWCeevayu5jn1GVooEta25OiKHayYVCx4OQeUul0qceD/Z3EpTaWGr4gwZyzRBgKlGBZoAXhZBYnmu+mHz+y/hF6OmzqVt6cE/i/p+ddI+xcY2j7IGvz7DGirLAaLbD+4c/tzSnwYtemk8Pf2OOlAvZkLEZ63aZ3GS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS4PPFE12D62847.namprd11.prod.outlook.com (2603:10b6:f:fc02::58) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 07:01:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9846.016; Fri, 24 Apr 2026
 07:01:33 +0000
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
Subject: RE: [PATCH v2 24/31] coco/tdx-host: Add a helper to exchange SPDM
 messages through DOE
Thread-Topic: [PATCH v2 24/31] coco/tdx-host: Add a helper to exchange SPDM
 messages through DOE
Thread-Index: AQHcvgg6M3chqW9amE6XRdboCxGklLXWb/VQgBSMTACAAvcOQA==
Date: Fri, 24 Apr 2026 07:01:32 +0000
Message-ID: <BN9PR11MB52767B17432AF4A2622091608C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-25-yilun.xu@linux.intel.com>
 <BN9PR11MB5276E1C73BFF4EF6A806F69D8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aeiXuludvkZedOg5@yilunxu-OptiPlex-7050>
In-Reply-To: <aeiXuludvkZedOg5@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS4PPFE12D62847:EE_
x-ms-office365-filtering-correlation-id: a98175ab-1ff7-4dc2-ae09-08dea1cf5179
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: gAC688GO/D2TUmiU28iP5rUNXCbcAMxqdJcWBoCHZvnOFfL6p7lxaVJqoZYVQR0X+K8Cjl5exFU2SE4QUT5UbyECTA2i+Hbo6ZVXIKoeqhibYvbtVycXHBI+LiLBM+OvDM7KJqudCWx9ryhKQlZvN+0gM/AEWEKmJEvlUu9Hc1vm78EC8uXdF4UJDbpJ5gl3RQkbyR3K+SB76ce/eU80+ARyi26wrp77m4EJ8izlWlZljoGSNkNfimTUsRiq7ghvSmHAUiKYnRM/n86Ke1pcIewzmvkmUznsqsCSGeosgxeqH6X/xVO3zfaXYiCK5tw4/2HU7AlLIO3JA5hMzBravFF4KplowAp2uDtrasyUIfi4StHQdzlP+MfWoagiZqip4CotCB7DSF/LmnhHcFma5hF8n9W6ZtjZFHLnefQnP04dEG11mqXndCWGeCy/jwlw6Y34d5pJuiKuVpAcd15iGxagnULuF0Hcg+Iq1tmQpei3+eVIL7hmzpWPN9EPoHk5ucTD/BwFds+aO5/pYIkEDSaJeYcxsdhrmc+5RMObgfXw+5HMfHNT2xhjdVAP2HkKGM5kujF7Ya/L2HOCrJmtPx7XpRzDuyIKMLWt6JmlZ6hYU1eSmsphxXMJyY7wkfUqNzAHUxG3el1yLUW1ZYtXe8YGQi9M8Ed8hWyhi8/JYe6d/RiEwP2S3duWtzwrLIhMVlaXkqARyv2831GzGPevPCbRxJ2huqk1faQs+d2FAE5CJs2RekDVVm9zoJ9n6w3fIk5maBrHZrzZYwAzmN2dCNnFi5SwtOJA5XAna/n3Kv0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ObvuA8Ut0A8lH7l4U+1QPAk2U9F0w1yeUFikgISuxyadhi5w0T/CrYMxhmVn?=
 =?us-ascii?Q?2fGPQ6UucKuwxncpPwFTAqIVSbE2iARUjWSpKHpotZ9ehWq7BVvXl4HXeSyX?=
 =?us-ascii?Q?Ksd32e9XI+/ce7/hyNC9YiaGERaUVvFhjub+pM7XnVfWUzYDPNNi1MVcfuas?=
 =?us-ascii?Q?Psa9cK8yv6+1gPBD6xEsZRnU9ySNtYL9E40pzwWNuHzL+fwOZoX6B13arRMa?=
 =?us-ascii?Q?ntmGWnifaoKZ0Elr+jFCTRDelAtLltzbWupwNq5PZOwDGPXVlp7vmOXYa2zY?=
 =?us-ascii?Q?ASDsJE/BcHgvxs6+ALafmITD2cif5t47Bo/xoWdo3UeJPh7SnxgA7i8ZqKKg?=
 =?us-ascii?Q?pFJXNxOshZwLx3MF/SxKaoTetrZvyOXD2p6+yLVPMjVjpjVxp4jEeopvbNwg?=
 =?us-ascii?Q?oPr/AGCa6iYbYDjwBAqT/PnzYeVN1g5Wq7+4SE35yX9yrYfOj3w5BL0bW8Vh?=
 =?us-ascii?Q?t08NBjTronGnz3S+OXJ2mFIFKuNoZCJRI2j6GkqBdg8OmW3Zr0CiyAhsdtdG?=
 =?us-ascii?Q?xG48FNL2+lNYSQZD5bnb5AejzAnzqM2NVVt2eocQVCUqiAn6RVwWreVfFDaD?=
 =?us-ascii?Q?LKQiew2LOQyA1zcTU3wH9ouMDXTSxnsLd1sx3pWtYunC5qFhJhbEbtA4/zkO?=
 =?us-ascii?Q?KNlKccqL4LgQKxkPLS4+6JGecGm9gbBXy6Mc9qiDZWx79rnRdx1ABEXgujp0?=
 =?us-ascii?Q?/Q3xycJ5NxNf5St8+n7aq856MC5Zua9f7AQcWhJTMX0wNZfxdII3nk8FgAvo?=
 =?us-ascii?Q?EM32/CHwvqyLJO/82fetsVUlqA09R6ak+HCkM+uNk8awIJuOxkci9ymCP3f7?=
 =?us-ascii?Q?xdOswUXeNduhGKI/ALilFQDK/5s0mAev+tRaO8y0g3ikKSw8VpsIuEKx9vbE?=
 =?us-ascii?Q?V/jikyH35fHsVF3NUXK6ernGGza+W94hF3vnSU3GmpagAqZxBP042W7tbIMQ?=
 =?us-ascii?Q?BZJQ08sd38kcPBfLx8x/UMqhlhenTQuWdg9ykt53m5nplbLbdEsRdvD5U1r6?=
 =?us-ascii?Q?ZZUbXHVE3vxmBeO+o2u9YZdTSK0cJrJXb2Qgm1oh1aT6HHW65v4q98DxAJ5E?=
 =?us-ascii?Q?6nDwiSwciFZNDSj2hRVsL/G5Zr8nizLc13z2z5Ar2DBVaDdHtPFywPY2cMNA?=
 =?us-ascii?Q?g/HBdKFWuVh0tKxM43uhUmqhPBfIEV8mxoDr+vRGUU1Nn0EOjTzswkglxnh9?=
 =?us-ascii?Q?81IvNdMpZYTQXeoEK2qDrNVaJS3WL9d7NUw+5xzs/X8qMUdY43VogfdA9LUe?=
 =?us-ascii?Q?sHA/Q+gNx5HaSBghR6Gb/BtLcN8IJiQkx0vUKubZ2m3ZhbwWhpoVbfgt0qFr?=
 =?us-ascii?Q?41hoJ0LBujpUmNWQSJXKxQBj4rxFc3rMK17Kd0DCneNHjIe5ExDQ3dqmML59?=
 =?us-ascii?Q?IZdkSYv1PPkw2CLIoZ7M5f2SChpZRNlop6gU+P7oT1rsLHoIECpyKhzNkYYB?=
 =?us-ascii?Q?0rVH5Xh73k5kMmwbqqeVRNLL/zCql4kwCqzjzeYW39pCg2MdluqYVtAV+7sP?=
 =?us-ascii?Q?6dLR5jg3/VjxObbPD6XHPp4XRxnwBY4Sz7OQx0ge1VVNEnK7Pi/VhN1MoTDR?=
 =?us-ascii?Q?9Knc9mBcGzD3H7Y6bEVoSTvRKMhwOWSqKhVd0hEeCGD/MjpjzPLhDpRn7Klw?=
 =?us-ascii?Q?Bii/+rvMzta9cLqo56PFMqxG/byvGQgIOL5wvlaAw9VBtzoe/WwjGoHG8nNP?=
 =?us-ascii?Q?Y+87HvQgtws9rzNRmOjAoUNSEd836bpT+i114KkVtu/jjlJH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AqbjNDChE/AOUIguGk8t6K1+O4FvPZBmDhT4W4aCNg/ISgvCiXhf+wXMujaNH6qdHoTwXAKeeotXkjFd0xGEZtAr2mrfdCOaLy1+/lKzOgaGbbAsez9RWMWIkZxVGll1VSJkk4NuQ9K9qcEB/jY/RJbqtmrSKQ4tWXKbgMaFFtNmJKSczTD50vO4pvSaNsDGzW+Kn8VGa8FjNEMcs5+dtlCm0g0A9mEQfVHTlLwCbO9iTqwdA5Iq3j3jj5DkTdsan2mys58YiKY5RtNUILJ8CdTjcxU6IgBEn1i+a/unrqjmJmpQhxq/BobkXnLvUPrLuCKvl/7OayyvyXedUJiDoA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98175ab-1ff7-4dc2-ae09-08dea1cf5179
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 07:01:32.9878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXvEeWRofDev4x3tVmjuAAnM3fFGTfbZB2rEowQaGwCf9Gw6RRvtmo2ny7UtPFWDwBbZJnbyo4aJuLOcO8oaXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE12D62847
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, April 22, 2026 5:41 PM
>=20
> On Thu, Apr 09, 2026 at 07:56:06AM +0000, Tian, Kevin wrote:
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > Sent: Saturday, March 28, 2026 12:01 AM
> > > +
> > > +static int __maybe_unused tdx_spdm_msg_exchange(struct
> tdx_tsm_link
> > > *tlink,
> > > +						void *request, size_t
> > > request_sz,
> > > +						void *response, size_t
> > > response_sz)
> > > +{
> > > +	struct pci_dev *pdev =3D tlink->pci.base_tsm.pdev;
> >
> > call it pci_spdm_msg_exchange() and pass in struct pci_dev directly.
>=20
> I don't think so. There is kernel managed spdm transfer support WIP,
> which is another topic.  We don't want to mix the namespace with that
> one.

pci_spdm_raw_msg_exchange() then, since you said currently only
one user i.e. tdx?

If the kernel managed spdm doesn't support the raw format, then there
won't be conflict.

if it supports (i.e. the 2nd user), then this should be moved to pci core.

>=20
> And we also don't name it tsm_spdm_msg_exchange, cause TSM firmwares
> output different blobs for vendor TSM drivers to transfer. E.g. TDX
> Module outputs buffers with DOE header & SPDM header, other vendors
> (AMD IIRC) outputs buffers with only SPDM header. So this function is
> TDX specific.
>=20

TDX is just an user of that. All the logic here is about handling the
raw format, nothing specific to tdx.
