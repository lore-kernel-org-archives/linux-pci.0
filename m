Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1580D3081BE;
	Thu,  9 Apr 2026 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775718166; cv=fail; b=AIxIt3+orcKo+qHZFORCl/5byFTNwBwSe1aOiQJaNYzY6UoGw4jrPsoX70OBzxR2a11nVYK6bgQB22js1YENnCNTW9yaFAgtbcj3YGO9j9OZ7UKv+CUf8fyx0njLyrPpXJA7nkzvP3IJaUMK4GqRLdGGmX7y7NI0nwB1uP6v33o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775718166; c=relaxed/simple;
	bh=1aPYnIhRJfQXrNPvEy84Zvl+5JpvwUarjVm8ITByUuo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q27qoKgtwndg8aEbC2xjrxoUy+JCooxcXoNqoaUrFEpvScPi3L+jNm6dLmSqJmBPC6nQS5PPR8NSPrPIDdTmMpMLsuEp3v5GXtjgEKIVqQhDB6txnnUkgs1XWpLsUQt5zNtn9caEMoWmOAuFJBe4jF9V8gFN6LgSCdapR7Qi17c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMP/6nU2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMP/6nU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775718165; x=1807254165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1aPYnIhRJfQXrNPvEy84Zvl+5JpvwUarjVm8ITByUuo=;
  b=nMP/6nU2AUe+L3X6+A0vjHqKMqymKK/BPbovm8URjS3a7VPWkYU9B3Gw
   Qkbq5vkbfw5NWqaa5LVDy1RANUgyTcwh92kf/ywIIopNkcdRovZM9mI5g
   KYAS0B8OhwkkAv0t/7+AXKWMQ8gwbPu32vHjhnkjiSWtMo+RyogyaqsP8
   p+cluIm8M3Ou10dIPKrKq5np7jzvUKua1G46AUfBa1T5IICOWjuGJYJV3
   Tk3rr6jwuxFOPrpB9hxzIfNb9N5f8QQ6nw5xUnud1edbVxn1el0GErdbK
   eAFDCdcnD8+VawoMi4aIK4xqkZmNi830Hjaiy5tg5wGPZnrYmDzFvj4c6
   g==;
X-CSE-ConnectionGUID: aFX0N2QaQli9CkHXPvaNjw==
X-CSE-MsgGUID: lNGZ3eJiQrSCxqpz4HonuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76593299"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76593299"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:02:45 -0700
X-CSE-ConnectionGUID: 3dQgLM0WR9K0Q5eKruCeFw==
X-CSE-MsgGUID: CHmJG5y2RJiliUqLEKCw3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="227830111"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:02:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:02:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 00:02:43 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:02:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9gDNN5fATYo9QtleRzdNrXthAAD1f/eapg8DhMBz/GAoFfi8fPiI0ADFWaO3l7aGeBPGBxnhpPX406XwH8hs/+cFMKsLhG6RjYGbpul02F890F8oSXa3HVWOpXnrrKB0rd+w2M5OQP+q5+1qGVnIF6bL7+oEtHKTUWFebiUkbFnX40KBx1A3+ngoO/6odvfH2t3MeXKikx6GeIVJkiOP10TADX6TTVz0h9fDokcj2R63M8k8LOYFbmlspHovUOTzczt7rOp6LEKhPrzyflzbjY5rolTEqeP5kNOhzBsHnR68xKgVcGj3lYzz7WD5Gou+KGEMG+VhxvwoVk1Olvrug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aPYnIhRJfQXrNPvEy84Zvl+5JpvwUarjVm8ITByUuo=;
 b=LBsSywz/WBHsyuqDRsDpCN+YkzJ16S6V0ZL/W2G7llkISS03uuTriYkcnzfb6q9ePHp9qU8Wds/LAbe+xMcljDTbu+YK2t4LLko7NvsTSKXUoXqIb09biPizyqoSRKUoHMRFJfGuH/8diigY3JrqMITiH6/V1qmq/8GNKicoFaBtP5QMr3bV9hiTGN/V97RKK49o416hNLanBmaU0evOkTgk0KM7Ckb7W09188fHznIsiC98PJXo9eqGfyGpFXNCPrL+7bs2GZJeSr3xcyL/1tiF33B2IAYX6dKOnd6GXrc+sWBwYmMBAtKIKw0AbQtq1dm+1wu9Mo+ziTvoIv4ruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7039.namprd11.prod.outlook.com (2603:10b6:806:2b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 9 Apr
 2026 07:02:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 07:02:39 +0000
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
Subject: RE: [PATCH v2 18/31] iommu/vt-d: Cache max domain ID to avoid
 redundant calculation
Thread-Topic: [PATCH v2 18/31] iommu/vt-d: Cache max domain ID to avoid
 redundant calculation
Thread-Index: AQHcvggJrhwxF5ilOkWVpyUD2oiua7XWYYjA
Date: Thu, 9 Apr 2026 07:02:38 +0000
Message-ID: <BN9PR11MB5276CFF11A1364457B36632D8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-19-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-19-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7039:EE_
x-ms-office365-filtering-correlation-id: d5ec0a48-40c4-4328-f649-08de9605fca1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: VadduTHMaBO8ofUUfKweZBap/0UaUbv2JVhUYhpicrxsadhFGjCPn8hBf9F9WsArF6pWvl3Qt3z2tMDHlwCTkusUbxjxa1xD/Ka9S1RFSQzqatCdcNyY1P0DG2o4z0ltKBVQPxHSFJZtHeI6xJ/6mMPCpq71S/WPL899HTq+8/gxJAxeve3OSLlAOouxFrVb0kKg515hsCXIjvpATQEPLuCgiGMgKu/0U4qpyjvonVi/A88CF/F0WVzqrl12+qd7Fz6dSoc7ayizKoHkCzwZwmbiLjkVE5uw55NQdk0vZ6LXcmBC71Dw9/dtZuX9DTJrOGjoRdyC2jk1dF6rFqdo5doFTtF4J4clNmqRcZBy9DyS9Hc3r4iPLwBftIu17YVKMEBdMGKTVIKyHgifR4Dbs6QMwSj8MIznLT0BEZoH8iTXHjDHdrJFWVO+IsGECgmWsjcrZD7TLwPnneL/sN4ihiXmRVdUsBlhkGJ5f/oxdWUHuwbme6gDNdt9K2iMycYM35WlnKrKNL7nAoQCvsQgKVRpmeVJ/U9pVcNhGYJsh62/Q7LmEKTodKJwfVQ/5eYX03EMgoOHGm4VETXyVuPy4byhSlTUKrN4MmNoYj7wimNbbYI6E+OoqV7UpACHTdGKiO5DmV9/lUq5CXkOO/0Q7FoFJYXzeI1oS01uaJpeFYsLDYDHcvUlQpLXJ+lmFFJBJ8+xuWwVZmwCPlyzLJQOdNPnQyI3xh7lfijebos0rIUZ9c/Wk7ZGaJkwQGhE/pYajlIwQkDZNdI+7MGmO48TLEHJPTIe34vHSceuR5vzGVw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ROUBvV+vwgzXmq7lUDlBySwf64HgkW6COfg1Ea75x/PH236BQxZXR4SNu3sn?=
 =?us-ascii?Q?u+owl7gTn8j7dsTv4aaT1G2wy9Jt0wKMKc6lw7LYXMgaJVqh1ug/58AjjlSS?=
 =?us-ascii?Q?6i49B5t6V6XtPouTr8GBY4Z4gu8xLFdpRoxXlwrpfoG8CEQthqW9hmsV1cPi?=
 =?us-ascii?Q?qiSzn0gJbc/tLcXNlBEJTD9cSElfGaRmrWfT5azKDDLWRXxZdh/VWDy8hn2k?=
 =?us-ascii?Q?NdDNkfpoUXbQ67n1ymjqZ6a4F1iB06oGQIot8apcjuYayV20O6QyvF+Vi0Es?=
 =?us-ascii?Q?qvg3ScxuT0OFOu/H6CqALcy5rG3mYIdmknY/xO25rsmcHJOnB4iSzz5i96oi?=
 =?us-ascii?Q?QI6yNG4n1XFuPCwH9YxQCfaBJRbfVf+P0YTHiDcJ8JCw3wp36rcIjDf50bN4?=
 =?us-ascii?Q?Uw2N8LEINWzjYhkll+dVZmnJpeytBNyMz2loHW8bsWHsIfGVxCoGR0ZNP8MV?=
 =?us-ascii?Q?oP0SBENvLTGjyzMGe4d8+vGGbZgEIgucRUWnedswQqz9Tqk/NDyZDAUeS54Z?=
 =?us-ascii?Q?4e1iF7CF1Cvk1fPKU4LindqDkjf4+4wKQ2s+sp8naG65j9wJXwdx21aj7tfW?=
 =?us-ascii?Q?poU0/528l52zJmx0IqCxjVqmPFG+b1L8QnMv3fmCt0NV0jIr5byTes242HnW?=
 =?us-ascii?Q?EPXVaaukUjGIe7qrH1lgOHRzpr4UEhx0GZ004mJf2ydn0zoh65gQl3GJO8Fg?=
 =?us-ascii?Q?le9ePv2NgaHqamPLUbtac7QOPda4/rxX3Nktv5g5n9XRQnSXhZf0MiqQ39IC?=
 =?us-ascii?Q?Mul6xh6Sz4LleEfyKBqWnsoN2vvwFQ6kabeHdkn4KA/o2eVCd4AZFs029sps?=
 =?us-ascii?Q?BVoXPEZpDDi4J2bENKjHoGkC6FfVUoJNhcr8B+eh01vqeN9paZ9caom5qx/L?=
 =?us-ascii?Q?SGarTGeMxFZvdvi4XEf5jtsZ/LRSnZia0Bfctlf8uArdSSw31SY6hPeqBB8N?=
 =?us-ascii?Q?HRoRxNRkb/z3uDGB+RZLsmMYpTaPpc2NHBIP/FMDVFZn158FFvtQMDMLTSfS?=
 =?us-ascii?Q?07kTPV2O1Qml5y0+HuJtpj285V5hqvVdYvHsU8ZgVQ8eYoW1VeAmQdqdPx0C?=
 =?us-ascii?Q?ATbJgmCttLkE90OUHrNXtqHGPRk4Jal+NVaQzQ7TmPWrFncRb5317kbSYHvn?=
 =?us-ascii?Q?6M8FP0flGq8E6pYpkyPc44MlpBGsMVDu7hlIcQEKXQVy04LvuomQtNRqRZii?=
 =?us-ascii?Q?Yw6RPJxMwUyC3zPP8bFMyqKMSDcecJuwf68oS+mTNU/wfuVQ6Pm+yv+cBkFr?=
 =?us-ascii?Q?SopF6KQLBF98IEBfh6OcPRbC3gKxRPkYiQ/nrrxTmVjy3fwIleofdysCrmbo?=
 =?us-ascii?Q?/kOu14PUDmsEtvSg7JthP0qNge2UqGkdg+WHJ9HFoVYSAxcfu5687jY2dlCs?=
 =?us-ascii?Q?YxN67AhLPFoAUX1OnkP2hjlKJZyrced163Xe8ABqd11mdxCWL93nnXVvakg2?=
 =?us-ascii?Q?ApSeT+jdJLNPCINlS38ZjONJaostv/cZmtaA0k/HhEdUiihrlFBp6PZIcyQD?=
 =?us-ascii?Q?KXwhIFgZGyPVQxsIkyNIeoqwE7XENxKJUod5dsqZ9gmGNkbmngPu3KCmQ/TT?=
 =?us-ascii?Q?SZYkMRMkb5iGAG5OtWvqltEVjBtVUZGzKwqNGINZlII5tt9PQgKoXcJ48IGP?=
 =?us-ascii?Q?4tsMVdn3AxNNbrAvai2xvKkJu0LEdR60Luyex49sLNLq+H3N+ft3eii4F/6W?=
 =?us-ascii?Q?jSaXk74NACuKpVntpsI0XTT/Si6+QA8UKdE2hFuHJHJ4kMMg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AET9d2A7SrpzIgR9U+X42OI8g5TmC68INGIV3iF464Wz1OiXWSItJDvJIk37BR2JrnXI8BQCk0cI+xfRTqku7D42qHBhtBgYgib2E+llmQ6XzhmNhJH/Ua2zdC1SOCPzMSqVuXd6bhrNZ6AIuKZYsCDVj+xC3j7n9PemeOG5aKMRS+4PQQOCOZtJhi67yqbxyG8gwu+l1l6/90W3rlnJzWm1bdr11/FxIRurn30jgIQClHPuUvMpklWYKNKcL1JZ4can07hnLmPYEPzpj2wJXdiyiBhi5VNV5Dw8x2ypiU9HUEESg4e+AWkEkk6vwhBzw1p+WK7mzHJQ1UfW8NNNGw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ec0a48-40c4-4328-f649-08de9605fca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 07:02:39.0322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idMRb4IqYMZlP8LWqoVzsgy143ihuIoetOKyKaReuZrATAtfLx6qZuxWSPC7tWOWxbG3cWpZ0OtnzT++Ut4kRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7039
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Saturday, March 28, 2026 12:01 AM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> The cap_ndoms() helper calculates the maximum available domain ID from
> the value of capability register, which can be inefficient if called
> repeatedly. Cache the maximum supported domain ID in max_domain_id
> field
> during initialization to avoid redundant calls to cap_ndoms() throughout
> the IOMMU driver.
>=20
> No functionality change.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
