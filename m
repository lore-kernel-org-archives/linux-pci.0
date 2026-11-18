Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029906;
	b=hmxxdpTrLkF2iqjsCI+d9AeaVV37xxPuzEUWJzFscPNJmFMsN6HABSC34Yr+k5FBCEkE
	 0yjCCyCUWrENZkaYL/TF8bHWcjGSpUb2hV+Dj6HrXGrN2T2hni0LNgiJnrZBXJ8ByjnwN
	 BMNm/87QoLRcnUWwqXj9Q1/E5LEdusFA+t1MbzpdrDSiBvDlw636t+MJ99OhMWvhOdbe+
	 pdTAFultnmFou14MG40gUWnq5ShHOKY1QYHlY0iaYLHMa+z00yYVTqoCC0sevFoOymwDZ
	 2+S6EXvqXRbtwsxVl3fY96yDVBwdtNpFsiRnR6O5ooJGbUXGd4vhCTqvZyHYmidYdRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029906;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UMhpsHdWKunhw0UsBijG9n4BI7dOzBXZZGkLs9xLZfs=;
	b=kezE5rWAnbzlfpGXS3RwPaetoG+BzR5T57zryPbWq3H290iQbyVCLrGbuJgHPQIxB8To
	 TvcUKYYHRwAqzaHM00vDPdnQ7sfLZnbTlbWotmeqrhVSaaBDLKnqeBtzh6LWqXfRsnB+t
	 VwJn5P9AFyloNbO05+1hH8M91cvdKsx2g2XBZPpca1P0LbPo+gec3cgU0VIAPRqI2VbUg
	 T4jk7cQ0QlIt9xuSjQHgxMyCuDeB7vPoKyTGG6FUe8HF4g3TRHA5dHmsINq8I9Uh8b1tl
	 Ouw/2RVOScynj4SdiSDtUvE2qrKo5o5Um/cPLMcaEkZhwZdmuvNr1bAlH9MoWJeVJ8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WqchR0+n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E860A3824;
	Wed, 18 Nov 2026 19:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B9E860A3824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WqchR0+n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOz8cqiD9D0S9U1L9+a9KJGeic/Y9DXaTfQscAO/Zt8l9EM/EX1vN1nGD2fN99Se5o2tuURo2dLKCM50L6ylwV0P3dL+c3ipXNm6lAdSBCOW73mTZPhgi/eLa5dETKAfIiviMZm3NEPUF+uYTMhE/TXz1yv/d8lHJ9PJGCkTASbEYtj7AecaLJ6pP2vU6HPDZQHFISC/M7bWQolSW+PduUjn+kmN2mYsTMt/kfwEpxPhChCExg5K9cuAJtjrnLaxnsuiXG0e9tLE1qiFQPrwXK/25tpvNvHS6S4MQzOUtsoYfSBVRtf9erEGWsRfKt3qQYEnGBS4A2fSHOIKbVFCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMhpsHdWKunhw0UsBijG9n4BI7dOzBXZZGkLs9xLZfs=;
 b=gmuFaRxlUEOABhUvxXt7NlCBDOOpMLz+WNxpjMeE+SJSbDiJiyzuedSlVn0UtbjW4BvfD3n54PcZEDmIjTeJOtTCJG1zPMC6qoc/rGIz4QfwmcoN7bB4FNqpG05yHBp8GJ/k8HDGN7xJbNzuW61NGhKNGyottQCtOaIIACw0vw9RZqAcgrNVAqdPDtH8Z3FhosFPRroPyTMK+DZMH9sP0ISSSBSb5ABFXWuX6YyoYzefoIFhBVtcRVWqqvXnqrCyhQH5t2N7we8BL10gED92OuT8+BqayxfAAHLqBi0WL/1psdOSyfw3IhHoc5EwlSVz2r3MtMSQHKMHfHdMdkV0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMhpsHdWKunhw0UsBijG9n4BI7dOzBXZZGkLs9xLZfs=;
 b=WqchR0+n7bTA4/O3laMsVulyQ6p1H1AGedjXjNqo3pGm5Rl/c4LJrB++76BH6Bqtv4SilWDEdUXu+c1mbaxTsJTU/SHfth7fK1JgElzxZn24+odkNwqeHJzdrp0xzDU3Soo5h2Rk+CVW2VaQO5zkAn1QNayBZEaSx86Z/wjn9EDSl3UDbBUIXA9hlYpj2/xDhh1DtUCcBQzFL5x48pctj6aJleo2Q9xFk7FcmX0pgSXu1hx3IiYPlTXn1DD1Y/PZ5ll63iTrjh2JbAtgmJEnTccG2xk17Ar+Eb1j9esVTTibcq2XJZKH5e+e2DyXLkYyoLhk0aZZAVsUP6+RT+Ruzg==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:24:53 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:24:53 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	"jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "iweiny@kernel.org"
	<iweiny@kernel.org>, "ming.li@zohomail.com" <ming.li@zohomail.com>, Yishai
 Hadas <yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "dmatlack@google.com" <dmatlack@google.com>,
	"kees@kernel.org" <kees@kernel.org>, "gustavoars@kernel.org"
	<gustavoars@kernel.org>, Neo Jia <cjia@nvidia.com>, Krishnakant Jaju
	<kjaju@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Zhi Wang
	<zhiw@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v6 06/31] vfio/pci: Add the CXL provider ops registration
 interface
Thread-Topic: [PATCH v6 06/31] vfio/pci: Add the CXL provider ops registration
 interface
Thread-Index: AQHdXYpDRghZ2kxFb0WZj+wQqrSA07cetDgAgBWiusA=
Date: Wed, 18 Nov 2026 19:24:53 +0000
Message-ID:
 <IA1PR12MB90301C723295C9998EF74764BD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-7-mhonap@nvidia.com>
 <20261104165312.647d930e@shazbot.org>
In-Reply-To: <20261104165312.647d930e@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB9455:EE_
x-ms-office365-filtering-correlation-id: 4b28b8e0-f967-4d7e-169c-08df45a99f7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|4143699003|261102130727099003|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261022075727099003|10067099003;
x-microsoft-antispam-message-info:
 3IjHgx5Skmf814buL1fy6UGQ552os0Jqkz3VXsJ4DCgmRE8xaDhOmRQi1Bd1z7pXUsyGjPCmovU56ZbbaRXNgOerQzh3dgGVHy32z4Ud8CPkGGeZUOYRRaxNggWrjfoN1Lg+9QqTlErIArRhS4aqkZpuQ4IQ63kGvAcYYXA1B0spcFh7YxEi45au2z+5mofbxBY0K77AXiLmd5WdpksPJFORo+jVWDPC/9WTn5ZmxihHpuatPk4q3LBAEGtNwrK+ZSiwKkIUhstvP/2DL4bDyMBDvIV5xRH6N8F9XHaj/8ex5eEDu99ZIoE3Fu14ViKiBf8o6IksZ/p+JoXXLjIQPrxj/HfirvcPmIE7UKY3zLT2osKrWComNENcTTvFqQse+neFsB4H2zeThRXUjg+B+telh4etqwhb5G+Kcxy1q1g94BHIgojGlNoUBMACyHx9EAQcKggdWJP9+hV0mLXNZ6qrKXBnxkg5zufKUYjd39eG7CrOs/Rj9N3LfosEsjzaRYL8cGbjwBlaEvIWW6CJpENNQtO9tBLMMXtinamTFcZtSk1i+95rv+on47Qi0t5rx01i/qIyyCGTbv3/SWU2vvXOOeM2ZtssVSiViPIflt2Vl60NPMinLNZyg4I6UGrpuwQBwyHlrw6p5E4Pj9wPN/iq4ZaWeIIxViXUIn941GfympE5ltVrc9eOs12bPVMgZ1etMcSlvvOogwTcA6BABvFwqUbCQ+j0Sg1nrAs8Jnk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(4143699003)(261102130727099003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xwWu5cylPUTiBtqnInnHMRkqlxd0MvFUD7vr9KcabvItgY1wZkXkGWx0Efit?=
 =?us-ascii?Q?tcg+Xsjg1Q9BGvj73gcDsfNcpMgo3RvwTsJ8u0Z7XMDdrQwR9VFQRRP5Mpr0?=
 =?us-ascii?Q?Ij5IMeTMKk4P1a9lkSSWkMcyLLr4RUZxAOJCPmc3wIWas8l0n86/MQywSTjE?=
 =?us-ascii?Q?2Xsi/lmbmm+itScFX1JXoU0/4e0BfAVn5rmid0sEyeWERN8oX4Yb4Yvri/B4?=
 =?us-ascii?Q?/m5kfJsckaGudrWIfOi8ntGWuWWGsiiY8WOlrpQpk5KW0C3xayh6VDPgmI9C?=
 =?us-ascii?Q?dLBoaTnFKqJUE6AR+Nh3vVATWR/+kM3yNx6goL73Ev2TjJgpNHkFbDMwxTHJ?=
 =?us-ascii?Q?i8H9zz5SnjkLNEkSeyxpGCtuNTaSc6wuxvZR/XTeI+Ht+9t5jEfjEpJyW7fO?=
 =?us-ascii?Q?5RZI+Db6D5514nU4Wy32xc9KNowA0VH2An61V2qN10gzpB5aeUAKF9pPGKOn?=
 =?us-ascii?Q?c01IxpvlIieoia31/BtXM+BSpYK7s21vCpjFCBWorZ7l4V5KMuA/SmThC350?=
 =?us-ascii?Q?xs97yW+H56kTl6ZDtoPK5zLl2c2fU/FF+ywpeH2r62gqQXBt7UqXIOCnK4/G?=
 =?us-ascii?Q?15RFZLZPg0mMWWcYKpT3MercNpjZ8Aqje+UfxOqEqkf3Em+skjApgUJPo698?=
 =?us-ascii?Q?xbkF20AEwIuPXEBZpZWadFJwz2eoKW8Ve39KwdquJGijxtOrO/TJOvpFILTc?=
 =?us-ascii?Q?oHsvWLDdyj2qVIGFKy54U9TeLenDDEkXlppuUsWLnKDvvRKfEqH5Ia4CBPWP?=
 =?us-ascii?Q?F8RKDqMmwjHPUVZ2WkEnla9xGA9zvan7tHEIOAcX3ieyMNBn04+VJO/BrunA?=
 =?us-ascii?Q?o5JLXitDsN5l4rvDRCwRY6h24alw8Rla8BFleDdT0LxAbyyexR4JLkj2852Z?=
 =?us-ascii?Q?GOaubbwDLDkyIjXJdzhBDcwKPPAq9x89xfO4W4sbUk42oj6M+wPRTAqEpATA?=
 =?us-ascii?Q?uF5qfZdsqJa/0AAu0ISpSVtjo1apEAMrC09aaikuAYTEKjt3KnmcWUKceu3s?=
 =?us-ascii?Q?ZryRSbT8DPnwIGyblPqNTMBRfDPLeY2naQP9ItOKvzANF33CnFl5v0vJcqxC?=
 =?us-ascii?Q?5DMg8J0TPUp7hJXQF2m4V0S9Hmgww41V59A0gH8glmpcE99xuZIqkqX5+iVL?=
 =?us-ascii?Q?1XRAmosBRtToVyQ9OclsAmRmDjeydGhUmQhYeu9rptBKDaGvKuqgYAnR5jkl?=
 =?us-ascii?Q?uxxyTwBqOonSl/Ct19V60Emovynz6IuJwV0HUiRmeVADahLbUFLmspfAvQe0?=
 =?us-ascii?Q?WIyHfFz8KvzAj9E2vETXV9PBv7yaKhIv+geJTSldQ30dwXYgWR1TEK96liWO?=
 =?us-ascii?Q?26D4T4CQjvg8XJhPTS+87CR7omfxQ8nvans42y7APVbKPGsiMqLo97Il5H3V?=
 =?us-ascii?Q?nDjxajpZ9ibw253xJY2ZKGNm9XrdpHUL22fJl4IpLJOJUgzCmlSwzxSReDg0?=
 =?us-ascii?Q?oNuW5eR879X5uIVkbMM0yG84u4c9EKJFBcqZqneCFZuNeQH3kRKIJT6rXIXP?=
 =?us-ascii?Q?5UwAzdPxEfqyPSh7EiBlbRG9NfJ78wA6zF+DXaik8IJGyQ12uWsea6iKSHra?=
 =?us-ascii?Q?Ew59GOEuZi9csx9R2yFkZyzprELSUqPeb8l81jMYQHb9Q4UKWTCLtWz0j78Z?=
 =?us-ascii?Q?OPxI4dzOVBelJRjLns74/XyTsufKVmodnamhuYQrhPdnOeeJmMvqwbW3T5OU?=
 =?us-ascii?Q?/IgJu2R7qcgHTYkxJdMGyLjWPnccVWYZtVzlxnjpCsAuzPYi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b28b8e0-f967-4d7e-169c-08df45a99f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 19:24:53.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1B/Tm8G7YE8qvbMb2CgHa5gVz1nAXT0jMQU1dlzQam7qsLXfruZdi+21DxFrqqMO2BfbaXkLWf0cRbA4bwxyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Thursday, November 5, 2026 5:23 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan Madhavan
> <smadhavan@nvidia.com>; corbet@lwn.net; skhan@linuxfoundation.org;
> dave@stgolabs.net; alison.schofield@intel.com; vishal.l.verma@intel.com;
> iweiny@kernel.org; ming.li@zohomail.com; Yishai Hadas
> <yishaih@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org; alex@shazbot.=
org
> Subject: Re: [PATCH v6 06/31] vfio/pci: Add the CXL provider ops registra=
tion
> interface
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 16 Oct 2026 21:48:13 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > vfio-pci-core must stay free of any CXL header dependency, so CXL
> > Type-2 handling lives in a separate vfio-cxl module that plugs in a
> > set of callbacks.
> >
> > Add the registration interface:
> > - vfio-cxl registers a single struct vfio_cxl_ops at module_init
> > - vfio-pci-core stores it under an rwsem.
> >
> > A second registration is refused with -EBUSY.
> >
> > The owner field will be used to pin vfio-cxl for the lifetime of each
> > bound CXL device.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c | 24 ++++++++++++++++++++++++
> >  include/linux/vfio_pci_core.h    | 10 ++++++++++
> >  2 files changed, 34 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 6757054e9d87..2cc5dd20396c 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -2178,6 +2178,30 @@ static void vfio_pci_vga_uninit(struct
> vfio_pci_core_device *vdev)
> >                                             VGA_RSRC_LEGACY_MEM);  }
> >
> > +static const struct vfio_cxl_ops *vfio_pci_cxl_ops; static
> > +DECLARE_RWSEM(vfio_pci_cxl_ops_rwsem);
> > +
> > +int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops) {
> > +     guard(rwsem_write)(&vfio_pci_cxl_ops_rwsem);
> > +
> > +     if (vfio_pci_cxl_ops)
> > +             return -EBUSY;
> > +
> > +     vfio_pci_cxl_ops =3D ops;
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_register_cxl_ops);
> > +
> > +void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops)
> > +{
> > +     guard(rwsem_write)(&vfio_pci_cxl_ops_rwsem);
> > +
> > +     if (vfio_pci_cxl_ops =3D=3D ops)
> > +             vfio_pci_cxl_ops =3D NULL; }
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
> > +
> >  int vfio_pci_core_init_dev(struct vfio_device *core_vdev)  {
> >       struct vfio_pci_core_device *vdev =3D diff --git
> > a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h index
> > 9a1674c152aa..9fe0d1a3a370 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -66,6 +66,16 @@ struct vfio_pci_device_ops {
> >                              size_t nr_ranges);  };
> >
> > +struct vfio_cxl_ops {
> > +     int     (*init)(struct vfio_pci_core_device *vdev);
> > +     void    (*release)(struct vfio_pci_core_device *vdev);
> > +     /* Pinned per bound CXL device so vfio-cxl cannot unload under us=
age */
> > +     struct module *owner;
> > +};
>=20
> A forward declaration would be sufficient and cleaner here.  It doesn't b=
uy us
> anything to start defining the structure until we begin to use it.  Thank=
s,

Okay, Will do in v7. Each member is added in the patch that first uses it.

Thanks,
Manish

>=20
> Alex
>=20
> > +
> > +int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops);
> > +void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops
> > +*ops);
> > +
> >  #if IS_ENABLED(CONFIG_VFIO_PCI_DMABUF)
> >  int vfio_pci_core_fill_phys_vec(struct phys_vec *phys_vec,
> >                               struct vfio_region_dma_range
> > *dma_ranges,

