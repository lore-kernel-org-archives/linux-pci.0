Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA6B3DDAF3;
	Fri, 17 Jul 2026 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275346; cv=fail; b=lUAIG7Lvo/wZUlsBuoZVO/2iGyC80k13ChMlPdq+lw0gIPaRnmHEJynIBMot4VOMITT9jI1xBohC/3kiIf9pHrZ08ZQ/dEBc6e4JLKE8TpG4rwXm8NvDDMoyx73gYn8tD/Js+CChOFdIZBL5mdCONh4YYubIJlqbdX65T0eGLR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275346; c=relaxed/simple;
	bh=KMkG6Nksjbv2hTggUou2RHgQeFvgNZa4kGLL/N4yFVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NEt7OL5f5B5SoeoHktXJFYdbcG+awtdUHI+pJsxwbI9KO/LWVsWja2wfbLMBvsXa0FY6ZvwwK8tmDeqtY1GRIPEakKxHpXuiyo01MpkEd/XtJQOHoD62CvxmSBgX+We44FP3Bafdcpw1l3QmDEYdUrlOfvlOGP8bfmu6Lr58foE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViVNNDPv; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViVNNDPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275345; x=1815811345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KMkG6Nksjbv2hTggUou2RHgQeFvgNZa4kGLL/N4yFVo=;
  b=ViVNNDPvDtzThaCFdytvgyAhr/q3FcRd351V0GctvGAyWXVEpfKWyGHZ
   jz1d7jhv94jFsFBKwSHV97/1Ys22AApMkpLep5huKi+4pqsi0Vp/RoV9l
   5jal++scsce398s3S6qHi10WU/YLZoHyRHWDVR2p5BF/QwjM6a35LvKpS
   Th2jifPkXaoCGqjxgMy3w4bHzPoBaZWT6fjqY6Ix9otV2YcU3MAJ2uZQZ
   IuPzxSiunIsgfH1rQHtIWWa6+ZDS4kp+57F94KtrcHcibUAQG0NWCOXNi
   4zVwjdPjsFejt8550/UqI7Y489xd6+8S6N4J+Z2QzQjbEX91d98AqJMOa
   A==;
X-CSE-ConnectionGUID: vLla4j0SRDiA+Cmuvb+NpQ==
X-CSE-MsgGUID: fxgFSMCgQyCT+7QGZ/RNUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="85036186"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="85036186"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:02:24 -0700
X-CSE-ConnectionGUID: s7QMQ860Tkai+JmE8SImHw==
X-CSE-MsgGUID: am32056yTYaGrVgUMUupxQ==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:02:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:02:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 01:02:22 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:02:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRDLjDVJoJmmP4J/OgqhyVhCh201BTl8oRoavCHutxUuHBApZOYYJgt8Cb9tNFGHCnpYrbol4bZ3UHm3tpBXN3AMgA/LNNa1t/W4w7PZbSqom2K2TJOyrx/cv6ppCBd9y4OVULb2/7zJypG4gij7B5SHDquVV4HI5AuCEXbGimkBv5LqvXZau3eEWnbhAtCpqtVfKmFVcRFYZC/lck+KyK6a/CV4NT3rbFbUbCOyZDAQTAIiMJrYHU4z+LCxeYbyARAvo859MO717iwXMyCyMNVgSpJcWJJWPFnyS00OxEswmQphxlLEGlMIk5VtYib/9xv1apdo0HTAxTISV9q3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ib/0IRvlLxgdYdve8hBKZRbYe41VhRUVB6QRv4Tu69o=;
 b=lcWloghZkhHWo3fnqhvOu9qCeZRfFzlY5gIuhMdtjgZXFVNqRUS+9uGp+ob2ePf5qeE9lkwIhhVR+D1q1fRs5El72yKHfsF+KXT2GIKkDbs5SFobiBr2/WCgMYK91vZ+DB5IXRewscuyRO8n0YUur6AH9fJMmULBzMsw9rvQSc1Ypa6JIaw7CBV5fDvB9MZYhkDkE5v3j1FcxiQBh8Rd+jW/w6ajufj9y4D52YFEBivXoM+02VNmYSNDv3wS2qiK5jGyAKHMfO6BUtyO+8P/5cevuR6pDORNL+rkyR+T47S4S0DCoXyqshSrU9kI4wEN0nYqFNILxXxQE7knnIhV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 08:02:17 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb%4]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 08:02:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>, "Leon
 Romanovsky" <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro
	<amastro@fb.com>, =?iso-8859-1?Q?Christian_K=F6nig?=
	<christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, "Logan
 Gunthorpe" <logang@deltatee.com>, Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>
CC: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Sumit Semwal
	<sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, Alistair Popple
	<apopple@nvidia.com>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Thread-Topic: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Thread-Index: AQHdFIIi9XsUA/jZa0iRwXjYcH4nkbZxXBnw
Date: Fri, 17 Jul 2026 08:02:17 +0000
Message-ID: <SA2PR11MB48441458FC0DC1EC346873428CC62@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-3-matt@ozlabs.org>
In-Reply-To: <20260715174737.15287-3-matt@ozlabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4844:EE_|BL1PR11MB5977:EE_
x-ms-office365-filtering-correlation-id: 45f06be3-a56a-4125-921e-08dee3d9b868
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|38070700021|10067099003|56012099006|11063799006|4143699003|921020;
x-microsoft-antispam-message-info: GZjLLWQQQtOSsLeCuyjH8c+15d2a/PQynECptC6DC00iQ120D9c8Gaba9AXZwFRe/N2UN4zDVTS5r2kwnt0SJz7xOJ5obgDEXmI+z5P5+idzWQw+3CpcXKwwBIbdJ+yAXXodmSw2NCKnNpySNGsIQPa9i2m7F6VUTf3/wAutzvIDXO9QP8yprBq1YjegFp5B4IloIqICOM15J6Q+JlC8/+7FtWP93gd9oHuOjsdH9x6jTB7KlrttbsCrAR4Kh043v9JNkk9oR6ezQwCKJ9yw7iBknahe5eLSuelqsjUbBWEHDg3+lACAFbHAAiQ5GZVq12NKfebI1w6aWTp+JHKAM9Mvid87I8uw3ij2PY+k+E1/G/DPoeLYuhxcQZO74nBz+KOkXiMDAHeVb3CKSP93qltYwOgsP7scuzrcya+fytKKmYjTOhgjhxolBAu2lT4AKTK4TL0w0XYnSJkFNc0HoCgCQUcrnIgju8qJPWvYi12mBg1naKr6lAsJMu65oxuEXmym3rwrGh/5V5KbsYscv5M7bx6JwN5lBHUcw7u80rbxQE2IZlWhdWHuBB3Xt2IyoDANZiTQ0QUhuqqAIyucmx+lr3c0zbbVoJiQU6TSvUtFCTzU5+D27OxmKL02UKOVxk3E/YyItc0rUliXMiOsVtZKIC3SGTwcrHS2XGvUS7V1g4EFeYYApBUXh3oEH8IeURA4pOdxW8b5ARpa58lf8cTWTIWsJunwsplxnM2S7xNbjB9goqIX0w2BjcJBgIVM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PqdFkEvZv59Xfaa9JT2VgGeElAiySAttliUvow563AEeerszT9hMX194MA?=
 =?iso-8859-1?Q?WIjWJxyCAU0HI2x0f+L3U1T/4Uy1FptnKEw39kTnwWGbLu2ua7AP+G5ofL?=
 =?iso-8859-1?Q?PajnHpdaGr7QJPs5h9GGImtJNvYJ96XCRmojN9DFrCp5bInfCxOgTj5qof?=
 =?iso-8859-1?Q?DEqbzdHeOtmPV72xUKj7KoaED71KVZEh9+zx3bSdmgYLgP8fwt2+IJHlwa?=
 =?iso-8859-1?Q?VQqYAkhzyxGVKOQttZ0N1H8GxwrDL/pg8dCYOiYFZvHxYvMaF7O0sZRstB?=
 =?iso-8859-1?Q?Ifig25r7VyyMEl87QnjbWerBdhMTWxoWGG3YunsxYFd8k6yqcmS/nMZpwF?=
 =?iso-8859-1?Q?oqVnO08j0ILubFQ1CPsaj/IgoQ2gVF1jpIVeTu1aLQEGJGk2gbMRGB+Fto?=
 =?iso-8859-1?Q?1+s8juyRJwU1BDim64+vVccvkdqPn1up7hoYnvZQx/M++zO6BYi5o+RMUx?=
 =?iso-8859-1?Q?stDeD0EV2spayBPSMWKALURnxTX+BF5yFDZ2NhfHafAyk4KfYWn/aoYijM?=
 =?iso-8859-1?Q?UAgjLgEl9n6Gdyr13ng+qa9GWU4GumibeElyFHQ4/wYWpAidpu34vCK1TH?=
 =?iso-8859-1?Q?uJKADdNV3CgskOpjrpHC6c5iJoBQ+M4Bzp538JHHH7FTycMmKbV4nlqYuj?=
 =?iso-8859-1?Q?1d0LZkm8soJ5ooLak8k7znSaUuMIR5hmV9/WKGsHru8i9Oy2OuIGg9BZei?=
 =?iso-8859-1?Q?k88iCPCdUCn+aqblXtxZvG598zc/ornvmBgB7n89ietDWMmy9tNwZMB+cn?=
 =?iso-8859-1?Q?CVuWOIVJrLYTCVp67n+ZzEstIw1rFP/2ph07MPxO4xit5f+dul3i/6U9S1?=
 =?iso-8859-1?Q?bPXiYjYjc13r0rm50Wg2svl/NnCXKVNkilnnjgFMeb3k/3eopVhLnTodbj?=
 =?iso-8859-1?Q?sWJbBK1IxUv+Y/7qMzDBSox9kPM6GtWaISOoU4zescMB4L0+j6wH6c1OIA?=
 =?iso-8859-1?Q?qzxU1nTSTN4h+m8v0Tg5CrmqDsQLPxh97R26dOIodzTKVzRcNl1xLeBH9i?=
 =?iso-8859-1?Q?S5FQhHcVZFa77MZ3eGdiCKbi8HHE7bm3gCMU4Fndtjubh+RO2gY1SDf9nn?=
 =?iso-8859-1?Q?hDxLw6ZzNJnXov0p0b90Jj98AtryTtRiWaloEsiCxgTnuI4+/m7RXKitUA?=
 =?iso-8859-1?Q?pDMCBWjkbj9yxVkXXCMZaCuQbx6a9FBlYDmzziOig2P441JzGrKH7uRlPB?=
 =?iso-8859-1?Q?NNRON5WVWieE8e5YSoMlRqVwUJ4869h+zder6c1RuDGWRzW1v/IhgEq2cG?=
 =?iso-8859-1?Q?lVSEiOjqbyLlrehgRPL++7ckhsxt6QxQQGmE/8wPg9y/A2IU6E4Qjo38Fp?=
 =?iso-8859-1?Q?V5Bk9ZPj1waSgS2DclfBPPOq/CPz5KN5euesHde/7Gk/nqVK87HkfOTZaf?=
 =?iso-8859-1?Q?CW1djNVjFbcmQx9+PeGWELNFBTUIkKKmhOjRdvN6mFJEorecJfALll4MqB?=
 =?iso-8859-1?Q?jRAqqMQfsXv1121VDJZIhLuPwyt1RV2YxDMZcsTF0KsK38rFm1K7FTxgN3?=
 =?iso-8859-1?Q?q3fUBMlximb5w1v2/ir/WBzd+ABj2U91/vZwXCX1+WeEDTWgxwRqp5Qpta?=
 =?iso-8859-1?Q?S87QWYQ69tB48D7cUQ6pH2M/ZZE2tFvfMIi6XvDh8SDmces5jS0DsDH1Ol?=
 =?iso-8859-1?Q?jTMAu/TxXm/ut4FyKl3Pf+7KVKGgRwNMh0lMZ47FYPrHshsaAqzZsouxMO?=
 =?iso-8859-1?Q?+aarZY3WXlniYnhKX/bjMza+x8xVdLkeEaDT4Ck4ZJV7ufYusIyGI+k4T7?=
 =?iso-8859-1?Q?vG1BJ5VhLdlX8GgJVeIQuCmzKq3py8BmwzZxULUEyple87?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kdPjP39OJnFuqXY1Ttw2Cd7mKlEtR176Ozf6jetg2MvfdteEXdXfnDDTVFAHZWXM2Ya0a6xiH60fDriKjPZuE4lRLmGShuPbwBCURcesYuob/RWlXy2Yl0Taa/dyTcX94SJ9YRwP0tuoeNl9P+IWKSfeLoI30CDz3Ulm+zO+H87eFrW8vxVLzqo7Nf3OF/Ne4G1JoqpkPbtk3FU1s4mU4vDafVz7bZCLERP7C3Nz6S6f3kSrkTt0rxQOVwJddf0irHz3U7UfpTTzaYQYGhLmZF9uzveHd1vm7dCObCqL5yxwOtMllgcdn2SJgYNL6dTBOQDCMlY/PczDAD+qNoYmyQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f06be3-a56a-4125-921e-08dee3d9b868
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:02:17.4336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAiWA+5b1OjUVIMiby/FGVbrH5W3OB+4idGAztu2aSXKlL+yEpkqxSkyW6f58c1AbhbiQtp2aL9U50GlmlYZQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com

> From: Matt Evans <matt@ozlabs.org>
> Sent: Thursday, July 16, 2026 1:47 AM
>=20
> The P2PDMA code currently provides two features under the same
> CONFIG_PCI_P2PDMA option:
>=20
>  1.  Locate providers via pcim_p2pdma_provider()
>  2.  Manage actual P2P DMA
>=20
> Some drivers (such as vfio-pci) depend on (1), without having a hard
> dependency on (2).
>=20
> A future vfio-pci commit will rely on pcim_p2pdma_provider() always
> being present.  If that depended on CONFIG_PCI_P2PDMA, it would make
> vfio-pci only available if CONFIG_ZONE_DEVICE is present (e.g. 64-bit
> systems), even when P2P is not needed.
>=20
> To resolve this, introduce CONFIG_PCI_P2PDMA_CORE and refactor the
> basic provider functionality into a new p2pdma_core.c file.  This is
> available even if the CONFIG_PCI_P2PDMA feature is disabled (or
> unavailable due to !CONFIG_ZONE_DEVICE), satisfying (1).
>=20
> Then, when the original CONFIG_PCI_P2PDMA is set, drivers have access
> to the additional P2P features of (2).  This still depends on
> CONFIG_ZONE_DEVICE.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
