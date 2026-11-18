Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029883;
	b=kJg0JCUPIHaGnyu4QJE68bAi1qynA3Ev7sOYYwkFmCgBkaoT7xuVqSaexBG2MPAZjXTY
	 Jfp4q/rOwKH6T0ncJWJFM1yETw+gILnxAHD+sLMlMdS1DSnruD2CG1OKEshAU/+0NKz/m
	 EqU8prqKfyY/3WpsEaznGCerjeXtUrpX5EDLpvxfAMO7BAGTCFac0jdCT65OsDS3Zw9r7
	 mv8navmr7/yTSFX941YjskZ7brYteCSlY+PY92iqFqB3RJBVZzMU0qx5mG+wX02YuXKNq
	 sPpqgBs7FxRHz8bkjzWaDoRzvjT3UU8I9Mx9CZsr1USykcoKjYmkLrtm0XbMLLwYI1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029883;
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
	bh=6DZxRiPAEa2WeZOew3gmVglaDM3DFLbX9Je9NfMAY5k=;
	b=SwC2TnmRlwiVH2D+jgk5nI5Qe5zYHJIuZaxCNpphuAAfKKOWV2HQf4BBOIEnBbJdtcSW
	 jLyHY+vlyWHoNuZlYdR79CdVEudd04AoIMQqVjwyqmbPL+7/jMHSFhiVZdqpNAs6GzFMb
	 unTh9bXqAixXY5xyUFxMRkCKS0lixj2RmtCg62i2YdOSp2T8jBYTBAkXmgYZZHJn2X/00
	 tMhYhkbzIYsHbL9PX2CbOow7y0lIiFvtfEUpK3aw8vVO9RyVAv0EcWqnWlz46ruSLyz4m
	 91vbOu8mMkemgrWITqj7isF2W+tVdibsm3vLR1uhz5RMQyf/7b+Oa2V3Wd3hYuh8bAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Qg4Xd6at;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.13
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E6606A335;
	Wed, 18 Nov 2026 19:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E11E6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Qg4Xd6at
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7zejPciQFJgUucYjUfB2OUpY1hxbCMlW4AjPNeJyfK5BjOGSAfek4DifOeDMJxVC5K52o3L64XSQkaJ5nNKll5iL7USJmmmJBy+/KD+azsWcBs47zem6lSz3R/SyBZGrq7aX71EIGoA/+qNUex0hTfPwwW8QemUaInfEzAzEsIPkMnL6pJsm1oxrABTU8hhaCD6WnPkJtt6BT9vf/OX+QPAzv3hrbD+lyb1/tf/NaxOXiP1uxNvN09pMzmDzxNiZPU5JujY54N2y5pEZdmCdnzzjr64WleULlTjins+m0x809L/Wal6Vn4H1QGKP3cHqPaBvVJ5qqGQgMve8jiyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DZxRiPAEa2WeZOew3gmVglaDM3DFLbX9Je9NfMAY5k=;
 b=ffcOJmiHG/pAQ/Valh0J3Nt50YaN+iyqy4CwnNluMaPwtF3E/UqqobGY4a4/pTAbTe3UjZRn7b2fX7+5z0nhOu9Brd0zfJWXMCes3mZovB8GrXZSooBPaGxkz7317M7Vs2NN1rHfLUEJ0HxAHAAiNBwkb/izEEiBMM2Feq6iMpPuhR7ULYEsjH5ht5lhrc+KiqsaaKERcF6l3tJ37ZhUbZtpKcOZLEKgZ53jyqEjJyocv6GumxoAzdb5Ekg20W9uHkyhKyFJFpGsBh19/X49+VW2bDk54sn6IZeVnk3gFDdMADyi84k74gmQUd2NmG2QwHdiiTROF5IzcJh6BeBdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DZxRiPAEa2WeZOew3gmVglaDM3DFLbX9Je9NfMAY5k=;
 b=Qg4Xd6atorldnDOWROwrb2CatBgdMIXFswjR2b8pyV1PifOoFq+qWnwmSZREwIvB8JqBYNyo5TwTlsR/UeySFmVg7Ogr0gInt0Gk1N7pb+HAQep/oeUOman9WN5RhsszJHbg6Lei7KpATYaNolXF3MLCLw41g+9oPDMgZ2ykc9qgVZvm+6J9WcIOKfhpwwe5btiEdq+ggdJiIQE6+qdTImfH5fTt/hkyGvhOCnsW7AROf/XIzT9OObwkHhxmHdp1U8Eft5pn+WynMAi58xCFt1mshtSNK92WM9//EaWm7YEUF49oZVSzJmUE72WGdu/2xUFSd9KneZaVxxu7omwJzA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:24:28 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:24:28 +0000
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
Subject: RE: [PATCH v6 12/31] vfio/pci: Call the CXL open and close hooks
 around device use
Thread-Topic: [PATCH v6 12/31] vfio/pci: Call the CXL open and close hooks
 around device use
Thread-Index: AQHdXYpoO41+ihyXSkWq8I+rmahgnrchx62AgBKFUvA=
Date: Wed, 18 Nov 2026 19:24:28 +0000
Message-ID:
 <IA1PR12MB90308CD40E46D7129B45ECBCBD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-13-mhonap@nvidia.com>
 <20261106155137.5fcf7259@shazbot.org>
In-Reply-To: <20261106155137.5fcf7259@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB9455:EE_
x-ms-office365-filtering-correlation-id: 54b71e06-bea5-4e24-13a6-08df45a99056
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|4143699003|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021135927099003|38070700021|261021123027099003|261022075727099003|10067099003;
x-microsoft-antispam-message-info:
 WnrB+LLV3vcqklBKvymiJxD71xiG4lQqZ6cphghgruNEEZCr5ZAoxpE4mS128TrCAPY3BfF8HAIJcxb9G83b+RMa2x/gYtNrID4PqOrLs4J1Xnnd3bU5NjeWyYPIuPKOfpSTCWT17xIhOLqiojECM1lVfnH/QIZvIwaWzfuqHTwwc5G2c40MKEGkMVZrHkt0ath0/k++r843dte+/u0lXFIudCY7KVjRrWnSIuAeoV+JekXOG2iaC/qnWKuLnEVzeIk2dkaMQGrtjt7/zwtqDZ2oZtmjaOmxqTllv9NtHDvK/4dkmDfXeBzEKBoXyanFc27M4arMn6qAwI4AQ7XURp2aCdKJCr4iOHXoZ17os3v8MUPvcVuTXr5fSyFJdXibiJRAAsuJc8uaAROn9Pt7wPTKpk4CqFe0shlB03VkLM5zzVn7mXK7rCnErBG9Xd1zL1OLHE+A4CHWeFp7JdvwQm4Kq6kfmw8lSQB7JtzeX7spWihyV26ZyAE769DhhGJB+VJaDd3ayE94JtkQ63//4V7rO3Bev1kCDpyzyZwzXoaXwiOVFz3RG79LrZwt0hpraHSXGDC6owMhcsJgZKhpvEluLNyYUMBzh8eqcqjUsyEPsR051SlTWhO9AozoEmNkvULFDb1RnSQ50yd/9IxygW1wAdl8fA9uDomgyzRvqhB0VGuBBjpEHedfDKePLo2FHyWg1b27B58H2dpvxT/5g/CrOJy9ZrP74u31Dl8Ya+c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021135927099003)(38070700021)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ky/bJW3CkwXEBv7+8zzjpM1xY+dee9mu/zY/vE6IN6lrD7wU+6HfzfLVgASV?=
 =?us-ascii?Q?tHPkK2mvRXZgtuPmpwTI8ZVuyG/LN9n/y2y+l/VXv9QRzwILlQNE8VDORLsU?=
 =?us-ascii?Q?/+5AKycmAzrLEcGV/7O7M0Ii6SlzOlqEr4rYUO/9P1juj/NKyNdkaM1K1VYv?=
 =?us-ascii?Q?25Zpc5O5JiokvGyujFhn+a4ln/8L9u0xa7SCHagB1IBT7n/EfZWbvAw2t4ls?=
 =?us-ascii?Q?kCTD0Cb6znpgzvcuQX0D0d25ZXJnLlnR3mG0E+xEGss+qOYLvfflnuZ87H6h?=
 =?us-ascii?Q?9CN7XJw9t4JWMejjDHTlprN3PILLZsn44qAgEj+mPqux98NFe5kFALw82p1X?=
 =?us-ascii?Q?uk5D+ppQS2d1pOh5R2wU1TD9zuo7FJEQNtEfRp3W3o1mhfgGOzcF/HAHM1te?=
 =?us-ascii?Q?j6cuLbKKmiCX/icPO/Ri1ppRKy8OAS33s9JrznmEw+DmkGwvEtGsC1c4KLHu?=
 =?us-ascii?Q?AAUZtoL+Wz3opUMcGxZN39CxIDor/5mROzzJ6qPhOpl7/8N51qGKV0T2UI72?=
 =?us-ascii?Q?tC7i4vGRmLRA1gOc4hDotvvQp7+fYZMiQyOIjQu2MYuCvCN1w4ww0QYtsLcd?=
 =?us-ascii?Q?RrO3J1R7GJSnK5HN2D8RXJj8nhzF0LNQHbYgRZgPA2jJBO6hx1kq0lDGsDio?=
 =?us-ascii?Q?q9CQ7grUtrfNZmXpiq/cyf0Cin7B+m1jllFTG73dwi8yrsUJ3hEiC0MfjN/2?=
 =?us-ascii?Q?UXNd2jgoPTIJNc4zKWhr1ZCxfj5cn7+phx/pSaLyjlshPcq6IeyDwQavEjrk?=
 =?us-ascii?Q?DJOC5EkfPQwz2DCItPIClHZ/HsVEp3nKsxYH81Or5mmsto5A4zhE26KYVBdh?=
 =?us-ascii?Q?lNniH1UAMeqFd2WBJBfGFLrYbdA6h3m3S7b7yM7zYxLyE9OAF8lSXXhH7WKO?=
 =?us-ascii?Q?31ZepNzguIjROjxhCPXD/llSj2EcvSngebvGeSor75V8W21VahK9MmwZQg54?=
 =?us-ascii?Q?jIia0Dv7LSIcVpSOEZdsv1Uq4xK7w2SFabDp9Q6+8bABQugHFiGOQTx798oW?=
 =?us-ascii?Q?v05UCFWWElcK5U1E5Bi75iEtxzn8Qh10JzELzWGZt5v2ILTlPKa3hKbZpwgV?=
 =?us-ascii?Q?xJubtCDn+D/44/UvF+ANHic87Nt8wvuEyEljVOC0XPswKV6vXeEFlHivuW1Q?=
 =?us-ascii?Q?IJ95ooSNl1Nq0mCP+flBYhUEX9392OwXwGQJ4CNENnuZGlivMUSh6geWCrp1?=
 =?us-ascii?Q?yxHO0yV99ov066q3wkv0vPITDjlYYeLkjU+LF3qAJIpNhidJRuf4gmj73hrp?=
 =?us-ascii?Q?1wUnflh0Z8DJ/BgDoVmJwPQEix/RvUcDI6IQkLjZrhOufi7FIq1hxfI4pQbf?=
 =?us-ascii?Q?Bcx5/jmyhz46prSb+WRRTCXzXcYygPVPH4pZh42JrksMTJKwtA5xJKhSv+CJ?=
 =?us-ascii?Q?MSN5bCKSZJnnP7SjP7/DeBrf6AACBtIrtR6w6qo3eWHk7RDM2h/6J/+kJhz8?=
 =?us-ascii?Q?4DuZnK59sqI0XPP6YLz6ZwUyOnKxlKyTjyWYfh/s+xNhgjzgETMkuDf6lUUl?=
 =?us-ascii?Q?GkSXWcCu8t6Pp+cmqCPSDsiAlsmvnntbHZP7ejQpHVUCg8AMVyI4TSIgXUDm?=
 =?us-ascii?Q?sDDwRHktmZKvVQVUU4IpNa9kkJ4n1g+KQT2aIVZIsYodfelpMfEK3r5SAfYi?=
 =?us-ascii?Q?rmPjxVIDAFuZamciNdkW8JFeGsyMktslUgq/rOTzqtdgS+BIOeHNOjZGnvSH?=
 =?us-ascii?Q?nNgrKTjaLh/8A7odPsq+9VqAahkP3QJg8bkLLbR2+ZShXTDw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b71e06-bea5-4e24-13a6-08df45a99056
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 19:24:28.2735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvbFXJuOGCWj/5h2EpgfoVQrcqC24bT92ZRvO2vUhdTunDxRSCqrtOwtpJ0JLUktG7c5PJv6F/Vey9q3v+bCyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Saturday, November 7, 2026 4:22 AM
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
> Subject: Re: [PATCH v6 12/31] vfio/pci: Call the CXL open and close hooks
> around device use
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 16 Oct 2026 21:48:19 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > vfio-pci-core frees device regions and excluded ranges on close and on
> > a failed open, so a CXL provider must set them up at each open.
> >
> > Add open and close to the CXL ops and call them from the common enable
> > and close paths. A failed open unwinds the enable in reverse order:
> > release the device regions, unmap the BARs, drop the excluded ranges,
> > then free the virtual config.
> >
> > Factor the device region release and the BAR unmap out of
> > vfio_pci_core_disable() into helpers so the enable failure path and
> > the disable path share them.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c | 57 +++++++++++++++++++++++---------
> >  include/linux/vfio_pci_core.h    |  2 ++
> >  2 files changed, 44 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 211fff6045e2..3d4e01eea7b1 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -590,6 +590,31 @@ static const struct dev_pm_ops
> > vfio_pci_core_pm_ops =3D {
> >
> >  static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device
> > *vdev);
> >
> > +static void vfio_pci_core_unmap_bars(struct vfio_pci_core_device
> > +*vdev) {
> > +     struct pci_dev *pdev =3D vdev->pdev;
> > +
> > +     for (int i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > +             int bar =3D i + PCI_STD_RESOURCES;
> > +
> > +             if (IS_ERR_OR_NULL(vdev->barmap[bar]))
> > +                     continue;
> > +             pci_iounmap(pdev, vdev->barmap[bar]);
> > +             pci_release_selected_regions(pdev, 1 << bar);
> > +             vdev->barmap[bar] =3D NULL;
> > +     }
> > +}
> > +
> > +static void vfio_pci_core_free_dev_regions(struct
> > +vfio_pci_core_device *vdev) {
> > +     for (int i =3D 0; i < vdev->num_regions; i++)
> > +             vdev->region[i].ops->release(vdev, &vdev->region[i]);
> > +
> > +     vdev->num_regions =3D 0;
> > +     kfree(vdev->region);
> > +     vdev->region =3D NULL; /* don't krealloc a freed pointer */ }
>=20
> Mechanical changes like this should be done in a separate patch.

Okay, I will split these out.

>=20
> > +
> >  int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)  {
> >       struct pci_dev *pdev =3D vdev->pdev; @@ -691,8 +716,20 @@ int
> > vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
> >
> >       vfio_pci_core_map_bars(vdev);
> >
> > +     if (vdev->cxl_ops) {
> > +             ret =3D vdev->cxl_ops->open_device(vdev);
> > +             if (ret)
> > +                     goto out_free_config;
> > +     }
> > +
> >       return 0;
> >
> > +out_free_config:
> > +     /* A failed first open never reaches vfio_pci_core_disable(). */
> > +     vfio_pci_core_free_dev_regions(vdev);
> > +     vfio_pci_core_unmap_bars(vdev);
> > +     vfio_pci_free_excluded_ranges(vdev);
> > +     vfio_config_free(vdev);
>=20
> Raising again that this doesn't account for the code previously added to =
this
> function that has its own unwind.
>=20
> There also remains the question of whether excluded range setup should be
> moved to init/release.
>=20

Yes, for v7, I will move the range setup to init/release.

> >  out_free_zdev:
> >       vfio_pci_zdev_close_device(vdev);
> >  out_free_state:
> > @@ -713,7 +750,6 @@ void vfio_pci_core_disable(struct
> vfio_pci_core_device *vdev)
> >       struct pci_dev *pdev =3D vdev->pdev;
> >       struct vfio_pci_dummy_resource *dummy_res, *tmp;
> >       struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
> > -     int i, bar;
> >
> >       /* For needs_reset */
> >       lockdep_assert_held(&vdev->vdev.dev_set->lock);
> > @@ -759,24 +795,12 @@ void vfio_pci_core_disable(struct
> > vfio_pci_core_device *vdev)
> >
> >       vdev->virq_disabled =3D false;
> >
> > -     for (i =3D 0; i < vdev->num_regions; i++)
> > -             vdev->region[i].ops->release(vdev, &vdev->region[i]);
> > -
> > -     vdev->num_regions =3D 0;
> > -     kfree(vdev->region);
> > -     vdev->region =3D NULL; /* don't krealloc a freed pointer */
> > +     vfio_pci_core_free_dev_regions(vdev);
> >
> >       vfio_config_free(vdev);
> >       vfio_pci_free_excluded_ranges(vdev);
> >
> > -     for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -             bar =3D i + PCI_STD_RESOURCES;
> > -             if (IS_ERR_OR_NULL(vdev->barmap[bar]))
> > -                     continue;
> > -             pci_iounmap(pdev, vdev->barmap[bar]);
> > -             pci_release_selected_regions(pdev, 1 << bar);
> > -             vdev->barmap[bar] =3D NULL;
> > -     }
> > +     vfio_pci_core_unmap_bars(vdev);
> >
> >       list_for_each_entry_safe(dummy_res, tmp,
> >                                &vdev->dummy_resources_list, res_next)
> > { @@ -859,6 +883,9 @@ void vfio_pci_core_close_device(struct
> > vfio_device *core_vdev)  #endif
> >       vfio_pci_dma_buf_cleanup(vdev);
> >
> > +     if (vdev->cxl_ops)
> > +             vdev->cxl_ops->close_device(vdev);
> > +
>=20
> Mismatched in both naming and conventions.
>=20
> vfio_pci_core_enable() -> cxl_ops->open_device()
>=20
> vfio_pci_core_close_device() -> cxl_ops->close_device()
>=20
> Some variant drivers unwind a failure after core_enable() with core_disab=
le(),
> so the placement in the close_device() path is not only inconsistent, it'=
s wrong.
> The hooks should also be consistently named relative to where they're cal=
led
> from the core.  Thanks,

Agreed. For v7, I will name them enable and disable and call them from
vfio_pci_core_enable() and vfio_pci_core_disable().

Thanks,
Manish

>=20
> Alex
>=20
> >       vfio_pci_core_disable(vdev);
> >
> >       mutex_lock(&vdev->igate);
> > diff --git a/include/linux/vfio_pci_core.h
> > b/include/linux/vfio_pci_core.h index fd1ad0baf470..6520a2dcfd4a
> > 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -70,6 +70,8 @@ struct vfio_pci_device_ops {  struct vfio_cxl_ops {
> >       int     (*init)(struct vfio_pci_core_device *vdev);
> >       void    (*release)(struct vfio_pci_core_device *vdev);
> > +     int     (*open_device)(struct vfio_pci_core_device *vdev);
> > +     void    (*close_device)(struct vfio_pci_core_device *vdev);
> >       /* Pinned per bound CXL device so vfio-cxl cannot unload under us=
age */
> >       struct module *owner;
> >  };

