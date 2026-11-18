Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029887;
	b=1iphBxaO8lmBiUkU0eNDywTQ7wtmeSuv5FxSaSo/1lOaqEsieKc1tf5bbZRt+r9kH8Rg
	 Qa9ubjjUD1BtuetClOTwqQNCHZH4TzcNeIJFtS47WFL3zI1CH2+VMVJH0Kqojk06uqmOX
	 KYpPGGAo+hG6tf7NRgXPEb+rIK6fbwAl0yzjTsSRIWtOm/xAcs1+HiadD4uOb9MtuY+KQ
	 oNupPKtqhbvpYG13Wr7SRMX3gtuEdsBbI0ms+Yg6ItbvECfLwpP5zAKwlsN27MMU5aEy5
	 QT0sSQO1m6PrJQm30doiORVyKLF3fHIL0spRD/5yMAZBOsiT7SRcvxGqvn1/rBaF/dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029887;
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
	bh=FH2nzAeoTc86lW86qqTtrfBQwW8Aebk9+o5NKnKnDR0=;
	b=BsFMGE6tCNTHBywYvaFRxJ5hcHgIzmyx577YYg6ZXG29EqWmR4+KXL9P4yGTfP5hfXJ/
	 PiOS91JG29jnoymQdndHS/2pZeYh7qQIDZ60tA1N7TTCgW9mPZ9U0kve8wbH9uqMeXDYC
	 R788LmQPqzEdEHG5tjtzj3pKRXdHO7QzkEsRffKyYstnyA0S60gIZ7nL80WVo5HSkZeAR
	 012BPHHmAgSQFs/0HF+LJzif6Mb+hgUF8K7WiFy1oqXNAilY5ApC7CzoHnJbo1fZekwye
	 zmdspLoEURmOzto0AV7prsc5TM6N1ojSfCKR6vmx5WRsdqPosjHAG1JnX2OeYb9ThQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Bh9o2SIv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.30
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343E606A33F;
	Wed, 18 Nov 2026 19:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5343E606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Bh9o2SIv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjk0D4wWINTnlLLCMeU3Ep+7sQTHO9rj4bUWwCgjNDMBhtRoQBi0PpJmO5XOBaWE2OudAF1HWUUoM7GQ+JXqHuxAfiR4f1KxeIWT1UzCtl5vFP/SjUCI8/ekDkpaNhTXjwhLqr1FTWAgYU0t2wZpyTvJpYEdm06mfr4Rx/UvhO70Uu9OI5v9nxBe2WpK6vcasUk2Kb39XQnuSQTcCgfDZYDqLo8EgQu7xNd9aC5LbFNefCFJ74NgVR0MRKZPydNIgRomVi/adLch9pRfxaeWZcl2O4W09Uzt69jbFurl+VjgBUQQIPYA/fNoKhPaXqXKTKva1RM8gYAd3qBff5YY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH2nzAeoTc86lW86qqTtrfBQwW8Aebk9+o5NKnKnDR0=;
 b=T1vyCRZFIbgrDpO0XwsIO5zafw/6sVyrhCtIhmY+FUj1Ac0a/Vkc1sJRdegL3AawzxSxIS3+cf2YrjMwywYyESqT8RzcorSFIl5em59ur5N9PZvPNCedOJirUrca2njjl4uUN2Q0jdoN/To++Mfev0VFueWyrgQGqPfrlJknj3/TWXM+xuAOpiDAx4+AdxkhqK1hN9g51ocbggnqVpBXh7QtItTmiZw1Iyz2T98oUb5bCBa9s9+ynHAXIMOfnSuPjRyB2IlnINIsF9nE844EUiXvf5M6Cx7QPhp3PR2yGi+2SB6RdYRncMHNC8vVil4szFPecWJZFZqkE70YHIP+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH2nzAeoTc86lW86qqTtrfBQwW8Aebk9+o5NKnKnDR0=;
 b=Bh9o2SIvTQd/0uYfJSlmAQ+YhY1nvebgpvAnu9Q2ip/6S46EJ/Ll3ElsV8E81U0ZUqMlR/b85b8P7XSDhy+eVFKuTVmWAMFTO6CnC6R+u1poa0T7arOzAph+e4wVElcpkSkeg9L2hSL11nq8vAKccRPdJBjH2Vbkacfj75zgF3I2x11oQaXJc+PBUt4tv+kANXdSwaj15jVWvRFV3BStutjci0GmTNlZjrbc8akR3NgovLL+2/pN58UCOSJ/JQo+vvK3WCxIU0/75zYqJk3XWhGc0FWHvZBmcZ0AqN/3c6W9Nb+Uw+53oJw3o49uSPqUsbtqo0elCcW/iLbvf/nGTQ==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:24:32 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:24:32 +0000
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
Subject: RE: [PATCH v6 11/31] vfio/pci: Virtualize the CXL DVSEC in
 vfio_pci_config.c
Thread-Topic: [PATCH v6 11/31] vfio/pci: Virtualize the CXL DVSEC in
 vfio_pci_config.c
Thread-Index: AQHdXYpfLuvx+8gqS0SBVrJJRVDYxrchvD+AgBKOJqA=
Date: Wed, 18 Nov 2026 19:24:30 +0000
Message-ID:
 <IA1PR12MB9030929E3553E5B19895259ABD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-12-mhonap@nvidia.com>
 <20261106151043.4f47679f@shazbot.org>
In-Reply-To: <20261106151043.4f47679f@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB9455:EE_
x-ms-office365-filtering-correlation-id: a331a1eb-5872-46ef-2a1f-08df45a991ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|4143699003|56012099006|11063799006|261026121527099003|261102123227099003|261102124527099003|5023799004|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003|261022075727099003|10067099003;
x-microsoft-antispam-message-info:
 p09Od9SptCOUJNhBHKquohQIFwu23ZgSG+Uc3+PEedqjONFaQdv4u9lQtPTrSBYIZbwBLDIBsdYeq0jFYV1NupxuC/5276MlMrTN/THvzyuYuMxZr5vSIr8GPms8Bz++HKA3kKQAcfkrBcU2ToKDVwq0xX+IhRKAO3mi8pl7iXwqJf9ao/I9L5qzIriPlz2ltioNLr8usfIUiLfeqe1+OZYFEGNhy7XKr0ZUjz3KQ6sPook2J76nBR83DEVc2bYqfxs9W3Q0Gb6VljEON4apX1wcXlSCsCeKOij6SWsw0F//R1AU0EJh8qaX+mBgaxRFHRD0Aqly3Bn93ih+lMftHrzaJQkLy6aopp7QaGnmfhIeOqaJX1/9u+tA893Sgc4/NhkTvEHjgxiGz0eehBLqR2o0umNVNtNYDySa3xm+o5VxTIrMGt39zHP1N/Vq7P104YMq8OHjmXuEZGc7iZcbB86RPoYtXaeb0yDgvSV6e3NNPLI1S5SHOF8WAKJk1RaqPzAXUI6qqQKywr3TjlRlidMhwylcee26VDY22va+kMPbINrV+0Pl77Q21j3pTBd1bdkJRuXeNvqHNMvaI6rSabbrcQCEsIbk/YafyRl30AEklFieGr7cDcymYKeSVfIm56FM8L9MVcbSS22eLlLQLJ0J95DXIUFS1K9ZYwQmrcFC9G+wZSojGuxoNhoIag8+rHDZ3OlvMYwnckR3eNi/lKO6N7FvjYl6RFkWbjTKJ38=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261102124527099003)(5023799004)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zc1566l9+UjGeE0k5dEDo8l1vjrFeHSXJysPNQxZ8slmtIrQy1DN97ZJv4nR?=
 =?us-ascii?Q?KQh/JFMfB5ABv6b+6gP/x/AjvrZAyw9yWNDICwl/UNcI6mNv86KxyI47XpFv?=
 =?us-ascii?Q?ZF0HNxDNbPmrI8Z2LaStYEpKEYpa/fGsgGCjPFhcsL9ldFnpMmLhzq8v1jlT?=
 =?us-ascii?Q?Q8F9N67wJ9sgyWRdo0wN+/qcI4bzMFuqY0rlQTOqgRszGhMH/jUW5ro1zh1s?=
 =?us-ascii?Q?OYooVoEMtKOtmFyQ4g8qBHwQPkwL06aA2QkdUL01zUezO+WESi/tZZgp2kk3?=
 =?us-ascii?Q?llWP/If+k+gOg3ZZ5F5m6AV9XNvSGzBB8b6qkpx/BCjD03Earq+Ak0/c9FVB?=
 =?us-ascii?Q?KWHGuNblzH+GWdJV1dAJozRLt5ycR/twz2dS2wfVa0ubc3leeCebpbpdnC6t?=
 =?us-ascii?Q?4aDFKDg6D8NVy3h0/cJ8ZGs5wxvEhSOyYg27xPUiCNUrPI7ALFZ2KIJyTS3Q?=
 =?us-ascii?Q?U+fQCdZjP3z5upKZ/zvjxO6B15PdeUIn5/v5+R0EQt0PZiSyqfxBISiKDu9e?=
 =?us-ascii?Q?fvakWa3szvXGKRRFQ52m/HSc9CSJ2rYv65HRE0zBlXTM6jBa5WmdeP+70pFX?=
 =?us-ascii?Q?BT6EZrZwI48LbWvBPmf/pwcihaLMtlFJOBMUBmm+/dq1dYoL7aJGPJpf1VYo?=
 =?us-ascii?Q?zyjFHYHbZ41jT2+VyKl627wpMtODf7nnggdIkNZeRErQetJ10RUeeOOFby7j?=
 =?us-ascii?Q?4nrw/XE1tAUwenAvXW2EpaYorrhJd7VJYMu/4rYSH75KltwpE/tBIoss95em?=
 =?us-ascii?Q?uk8pUcZNivkoiFKoLIxtnlb0SZw08J9Cr1x2mvtiyxcnICOodSm/oB+6uzud?=
 =?us-ascii?Q?xu5L07CgPrVb+69UfFyhgfH7mIbCVzw50bYgvQj9jB9CSzsi39q2dCoC+HzM?=
 =?us-ascii?Q?z37nP4HA4/8ytZmPtDBWSy6dOB/Se2bqCBrm352iJ20tkpkFBRt33beAsnML?=
 =?us-ascii?Q?4Qv4UBGcO7OsTug9tcDSktjnYK/zfQGN3AoXGvj44x1UwIAyKjWFRDzzZPcJ?=
 =?us-ascii?Q?qIVfc28emT3iO+kvMlJwK5lXYeT3ndknchNZMRdTlBHTmNKurxQiRuKy5yLq?=
 =?us-ascii?Q?RAtsWwkZFv3hZcuctcgTKQ2H9fXcKMKvLS2iFVyLCBmc8YKw+zfEIq/M2gqd?=
 =?us-ascii?Q?wEjmAAVKDYNucO/Ci1mXIQOE309GngNnCP+V3ZOrGNbbRvYAZrd/Aw8dMz3i?=
 =?us-ascii?Q?f61jVet5M9LZ2jcgXADoaJh5pnF8R233Tikc20lQtG/n4qHlHbi4lb3Bmb7k?=
 =?us-ascii?Q?ZaTCeLKaYyP0k9NxS2VTfASxjBQ+PRh9zz6hSx15247P6+sJGkd1Qy/qTioO?=
 =?us-ascii?Q?Mnl4nMmNBqOx/6Xx0cm9qVTku4pwwAHsvcM5oyGj6X2hL2QUw4Q+r4JdGhsf?=
 =?us-ascii?Q?A2b57tLY2jIwyMFaMdZNnycofv4fddVaw3NOAfjGYIA/n2Ng1CLwE/oohTWr?=
 =?us-ascii?Q?EsqPD0+huzIBQOZWni5kX9q01OsLReJAd2OwE/HJso/k47Mswa0LpOz3ElWg?=
 =?us-ascii?Q?UlffTlhppqWvnkO4GRJVwa/CS63A0rpNsa6wgk+7d0iYc2KCn3SOXRgkf+Ah?=
 =?us-ascii?Q?ztx/FIH34Eq081NkBdwUj+Ht7x8TAGDltSdB9zf4ZNdchSJSMgzaASaaKPDL?=
 =?us-ascii?Q?KUsBrdJEQ+n1GR048bgmKdJ+stQD2tCzVws2ekovP0OhP/Pa6gWAu9KyS/nz?=
 =?us-ascii?Q?QwKxFvZjs7Ldfwfys+ft6cnVnsnqjaT+P1cPkDGD3f6xP/tZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a331a1eb-5872-46ef-2a1f-08df45a991ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 19:24:30.7400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e9RBeqVjS3+Q2fe9J4reUKt2BnNo/FOftFM7bZkbG25S4eRNIlYdmkhWySXqGTYSpk3ZXdSdCE7fj5RMJQ5N+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Saturday, November 7, 2026 3:41 AM
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
> Subject: Re: [PATCH v6 11/31] vfio/pci: Virtualize the CXL DVSEC in
> vfio_pci_config.c
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 16 Oct 2026 21:48:18 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A CXL Type-2 device is reprogrammable through its CXL DVSEC: a guest
> > could set Config Lock, toggle CXL.cache and CXL.mem enable, or rewrite
> > the HDM range registers that govern host memory decode. Virtualize the
> > DVSEC so the guest sees a shadow it cannot use to reprogram the hardwar=
e.
> >
> > Build a per-device cxl_perm permission map, modeled on msi_perm. When
> > the device is bound through the CXL provider (e.g. vfio-cxl), the
> > whole CXL DVSEC is served from the vconfig shadow; only Control and
> > Control2 are guest programmable, while Capability, Status, Lock and
> > the Range registers keep their firmware snapshot. A vendor DVSEC on
> > the same device is unaffected: the map is selected by the CXL DVSEC's
> > range, since every DVSEC has the same ID in the config map and two
> > DVSECs can be adjacent.
> >
> > A Type-2 function bound without the provider (the provider is absent,
> > its init failed, or the extensions are disabled) gets a guard map
> > instead. The DVSEC reads from hardware, Control and Control2 stay
> > writable and the RW1C status bits stay clearable, but writes to Lock
> > and the Range registers are dropped, since they outlive the user.
> > Initiate CXL Reset uses the same doorbell; a cache write-back goes to t=
he
> device.
>=20
> The guard map actually changes the device ABI.  This may be necessary, bu=
t if
> so, it should be pulled out into a Fixes: patch.  The device aspects that=
 change
> need to be well justified.  Access to CXL reset without coordination is c=
ertainly
> not good.  Config lock has side effects that we may not want to deal with=
.  Is
> there value in exposing the CXL DVSEC at all when we're operating in vfio=
-pci
> mode?  What do we expect a type-2 driver does with the guarded capability=
?
>=20
> Maybe the right answer is to drop it from the chain and make it read-only=
.
>=20

okay, for v7 I will drop the guard map and make the CXL DVSEC of a Type-2
function read-only when vfio-cxl is not bound, as a separate patch at
the front of the series with appropriate fixes: tag.

> > Control2 carries the CXL reset and cache write-back-invalidate
> > initiate bits as self-clearing doorbells. With the provider, vfio
> > never forwards them to hardware, so a custom writefn synthesizes their
> > completion in the shadow: the initiate bit self-clears and the
> > matching Status2 bit (Cache Invalid or Reset Done) is set, so a guest
> > that writes back its cache (CXL r4.0 sec 9.6) and then runs CXL Reset
> > (sec 9.7.2) progresses instead of timing out. Cache Invalid is
> > reported only while Disable Caching is set, as the spec requires. The
> > host performs the real cache write-back and reset at the vfio reset
> > points. Until a later patch in this series runs the real reset from
> > the doorbell, Initiate CXL Reset completes in the shadow only.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_config.c | 206 ++++++++++++++++++++++++++++-
> >  include/linux/vfio_pci_core.h      |   3 +
> >  2 files changed, 205 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_config.c
> > b/drivers/vfio/pci/vfio_pci_config.c
> > index 9914f3ac69ae..1fc463540211 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
> > @@ -1747,6 +1747,194 @@ static const struct pci_device_id
> known_bogus_vf_intx_pin[] =3D {
> >   * for each area requiring emulated bits, but the array of pointers
> >   * would be comparable in size (at least for standard config space).
> >   */
>=20
> This comment above used to be attached to vfio_config_init() and now it's
> miles away!
>=20

I will update this.

> > +static int vfio_cxl_dvsec_write(struct vfio_pci_core_device *vdev, int=
 pos,
> > +                             int count, struct perm_bits *perm,
> > +                             int offset, __le32 val) {
> > +     u16 start =3D vdev->cxl_dvsec;
> > +     __le16 *pctrl2, *pstatus2;
> > +     u16 ctrl2, status2;
> > +
> > +     count =3D vfio_default_config_write(vdev, pos, count, perm, offse=
t, val);
> > +     if (count < 0)
> > +             return count;
> > +
> > +     /* Only Control2 carries the self-clearing doorbells. */
> > +     if (offset > PCI_DVSEC_CXL_CTRL2 ||
> > +         offset + count <=3D PCI_DVSEC_CXL_CTRL2)
> > +             return count;
> > +
> > +     pctrl2 =3D (__le16 *)&vdev->vconfig[start + PCI_DVSEC_CXL_CTRL2];
> > +     pstatus2 =3D (__le16 *)&vdev->vconfig[start + PCI_DVSEC_CXL_STATU=
S2];
> > +     ctrl2 =3D le16_to_cpu(*pctrl2);
> > +     status2 =3D le16_to_cpu(*pstatus2);
> > +
> > +     /*
> > +      * INIT_CACHE_WBI and INIT_CXL_RST are self-clearing doorbells. W=
ith a
> > +      * provider neither reaches hardware: synthesize their completion=
 in the
> > +      * shadow so the guest poll finishes, clearing the initiate bit a=
nd
> > +      * setting the matching Status2 completion. Cache Invalid is set =
only
> > +      * while caching is disabled and reads 0 otherwise (CXL r4.0 sec =
8.1.3.5,
> > +      * Table 8-9). Under the guard map INIT_CACHE_WBI and Cache Inval=
id
> go to
> > +      * the device; only INIT_CXL_RST and its completion are virtualiz=
ed.
> > +      */
> > +     if (ctrl2 & PCI_DVSEC_CXL_INIT_CACHE_WBI) {
> > +             ctrl2 &=3D ~PCI_DVSEC_CXL_INIT_CACHE_WBI;
> > +             if (ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING)
> > +                     status2 |=3D PCI_DVSEC_CXL_CACHE_INV;
> > +     }
> > +     if (!(ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING))
> > +             status2 &=3D ~PCI_DVSEC_CXL_CACHE_INV;
> > +     if (ctrl2 & PCI_DVSEC_CXL_INIT_CXL_RST) {
> > +             ctrl2 &=3D ~PCI_DVSEC_CXL_INIT_CXL_RST;
> > +             status2 &=3D ~PCI_DVSEC_CXL_RST_ERR;
> > +             status2 |=3D PCI_DVSEC_CXL_RST_DONE;
> > +     }
> > +
> > +     *pctrl2 =3D cpu_to_le16(ctrl2);
> > +     *pstatus2 =3D cpu_to_le16(status2);
> > +
> > +     return count;
> > +}
> > +
> > +static int init_cxl_dvsec_perm(struct perm_bits *perm, int len) {
> > +     if (alloc_perm_bits(perm, len))
> > +             return -ENOMEM;
> > +
> > +     perm->writefn =3D vfio_cxl_dvsec_write;
> > +
> > +     /* Serve the whole CXL DVSEC from the shadow. */
> > +     for (int i =3D 0; i < len; i++)
> > +             p_setb(perm, i, (u8)ALL_VIRT, NO_WRITE);
> > +
> > +     /*
> > +      * Control and Control2 are guest programmable; Capability, Statu=
s,
> > +      * Lock and the Range registers keep their firmware snapshot, so =
the
> > +      * guest cannot set Config Lock or rewrite the capability and ran=
ges.
> > +      */
> > +     p_setw(perm, PCI_DVSEC_CXL_CTRL, (u16)ALL_VIRT, (u16)ALL_WRITE);
> > +     p_setw(perm, PCI_DVSEC_CXL_CTRL2, (u16)ALL_VIRT,
> > + (u16)ALL_WRITE);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Without a CXL provider the device is bound without the CXL
> > +extensions, so
> > + * the DVSEC is read from hardware, Control and Control2 stay
> > +writable, and
> > + * the RW1C status bits in Status and Status2 (for example
> > +Viral_Status) can
> > + * still be cleared. Drop the writes whose effect outlives the user:
> > +Config
> > + * Lock and the Range registers. Initiate CXL Reset goes through the
> > +same
> > + * doorbell as with a provider, so the reset runs at a vfio reset
> > +point under
> > + * memory_lock.
> > + */
> > +static int init_cxl_dvsec_guard_perm(struct perm_bits *perm, int len)
> > +{
> > +     if (alloc_perm_bits(perm, len))
> > +             return -ENOMEM;
> > +
> > +     perm->writefn =3D vfio_cxl_dvsec_write;
> > +
> > +     /* Extended capability header: ID and next pointer from vconfig. =
*/
> > +     p_setd(perm, 0, ALL_VIRT, NO_WRITE);
> > +
> > +     p_setw(perm, PCI_DVSEC_CXL_CTRL, NO_VIRT, (u16)ALL_WRITE);
> > +     p_setw(perm, PCI_DVSEC_CXL_CTRL2, PCI_DVSEC_CXL_INIT_CXL_RST,
> > +            (u16)ALL_WRITE);
> > +     /* Status (offset 0Eh, between Control and Control2): RW1C to the
> device. */
> > +     p_setw(perm, PCI_DVSEC_CXL_CTRL + 2, NO_VIRT, (u16)ALL_WRITE);
> > +     p_setw(perm, PCI_DVSEC_CXL_STATUS2,
> > +            PCI_DVSEC_CXL_RST_DONE | PCI_DVSEC_CXL_RST_ERR,
> > +            (u16)~(PCI_DVSEC_CXL_RST_DONE | PCI_DVSEC_CXL_RST_ERR));
> > +
> > +     return 0;
> > +}
> > +
> > +/* Virtualize the CXL DVSEC so a guest cannot reprogram the device
> > +through it. */ static int vfio_cxl_dvsec_init(struct
> > +vfio_pci_core_device *vdev) {
> > +     struct pci_dev *pdev =3D vdev->pdev;
> > +     u32 dword;
> > +     u16 dvsec, cap;
> > +     int len, ret;
> > +
> > +     dvsec =3D pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> > +                                       PCI_DVSEC_CXL_DEVICE);
> > +     if (!dvsec)
> > +             return 0;
> > +
> > +     ret =3D pci_read_config_dword(pdev, dvsec + PCI_DVSEC_HEADER1,
> &dword);
> > +     if (ret)
> > +             return pcibios_err_to_errno(ret);
> > +     len =3D PCI_DVSEC_HEADER1_LEN(dword);
> > +
> > +     /*
> > +      * The virtualization writes fixed DVSEC offsets up to Status2 (t=
he reset
> > +      * doorbell stamps it). A device that reports a shorter DVSEC is =
not a
> > +      * usable Type-2 function; leave its DVSEC unvirtualized rather t=
han
> > +      * index the device-length-sized perm allocation past its end.
> > +      */
> > +     if (len < PCI_DVSEC_CXL_STATUS2 + 2)
> > +             return 0;
> > +
> > +     /*
> > +      * Without a provider, guard only a CXL Type-2 function, with the=
 same
> > +      * test vfio-pci-core uses to load the provider.
> > +      */
>=20
> Cryptic comment.  Why don't we expose vfio_pci_is_cxl_type2() and use it
> here?

Okay, I will refactor this part.

>=20
> > +     if (!vdev->cxl_ops) {
> > +             if (!pcie_is_cxl(pdev))
> > +                     return 0;
> > +             ret =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_=
CAP,
> &cap);
> > +             if (ret)
> > +                     return pcibios_err_to_errno(ret);
> > +             if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> > +                 !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
> > +                     return 0;
> > +     }
> > +
> > +     vdev->cxl_perm =3D kmalloc_obj(*vdev->cxl_perm,
> GFP_KERNEL_ACCOUNT);
> > +     if (!vdev->cxl_perm)
> > +             return -ENOMEM;
> > +
> > +     if (vdev->cxl_ops)
> > +             ret =3D init_cxl_dvsec_perm(vdev->cxl_perm, len);
> > +     else
> > +             ret =3D init_cxl_dvsec_guard_perm(vdev->cxl_perm, len);
> > +     if (ret) {
> > +             kfree(vdev->cxl_perm);
> > +             vdev->cxl_perm =3D NULL;
> > +             return ret;
> > +     }
> > +
> > +     vdev->cxl_dvsec =3D dvsec;
> > +     vdev->cxl_dvsec_len =3D len;
> > +
> > +     return 0;
> > +}
> > +
> > +static void vfio_cxl_dvsec_exit(struct vfio_pci_core_device *vdev) {
> > +     if (!vdev->cxl_perm)
> > +             return;
> > +
> > +     free_perm_bits(vdev->cxl_perm);
> > +     kfree(vdev->cxl_perm);
> > +     vdev->cxl_perm =3D NULL;
> > +     vdev->cxl_dvsec =3D 0;
> > +     vdev->cxl_dvsec_len =3D 0;
> > +}
> > +
> > +/*
> > + * Every DVSEC carries the same ID in pci_config_map, so
> > +vfio_find_cap_start()
> > + * can walk from one DVSEC into an adjacent one. Match the CXL DVSEC b=
y
> range.
> > + */
>=20
> IMO, a comment is more relevant below.

Okay, I will update this.

>=20
> > +static bool vfio_cxl_dvsec_contains(struct vfio_pci_core_device *vdev,
> > +                                 loff_t pos) {
> > +     return vdev->cxl_perm && pos >=3D vdev->cxl_dvsec &&
> > +            pos < vdev->cxl_dvsec + vdev->cxl_dvsec_len; }
> > +
> >  int vfio_config_init(struct vfio_pci_core_device *vdev)  {
> >       struct pci_dev *pdev =3D vdev->pdev; @@ -1842,6 +2030,10 @@ int
> > vfio_config_init(struct vfio_pci_core_device *vdev)
> >       if (ret)
> >               goto out;
> >
> > +     ret =3D vfio_cxl_dvsec_init(vdev);
> > +     if (ret)
> > +             goto out;
> > +
> >       return 0;
> >
> >  out:
> > @@ -1863,6 +2055,7 @@ void vfio_config_free(struct vfio_pci_core_device
> *vdev)
> >               kfree(vdev->msi_perm);
> >               vdev->msi_perm =3D NULL;
> >       }
> > +     vfio_cxl_dvsec_exit(vdev);
>=20
> Teardown in opposite order of init.  Last initialized ~ first exit.

Yes, I will fix this and use the comment at the cap_start call.

Thanks,
Manish

>=20
> >  }
> >
> >  /*
> > @@ -1926,12 +2119,17 @@ ssize_t vfio_pci_config_rw_single(struct
> vfio_pci_core_device *vdev,
> >                        * of the extended capability list.  Use default,=
 ro
> >                        * access, which will virtualize the id and next =
values.
> >                        */
> > -                     if (cap_id > PCI_EXT_CAP_ID_MAX)
> > +                     cap_start =3D vfio_find_cap_start(vdev, *ppos);
> > +
> > +                     if (cap_id > PCI_EXT_CAP_ID_MAX) {
> >                               perm =3D &direct_ro_perms;
> > -                     else
> > +                     } else if (cap_id =3D=3D PCI_EXT_CAP_ID_DVSEC &&
> > +                                vfio_cxl_dvsec_contains(vdev, *ppos)) =
{
> > +                             perm =3D vdev->cxl_perm;
>=20
>                                 /*
>                                  * Multiple DVSECs may be back-to-back, r=
esulting
>                                  * in bogus cap_start.
>                                  */
>=20
> Thanks,
> Alex
>=20
> > +                             cap_start =3D vdev->cxl_dvsec;
> > +                     } else {
> >                               perm =3D &ecap_perms[cap_id];
> > -
> > -                     cap_start =3D vfio_find_cap_start(vdev, *ppos);
> > +                     }
> >               } else {
> >                       WARN_ON(cap_id > PCI_CAP_ID_MAX);
> >
> > diff --git a/include/linux/vfio_pci_core.h
> > b/include/linux/vfio_pci_core.h index 70acb03d466e..fd1ad0baf470
> > 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -120,6 +120,9 @@ struct vfio_pci_core_device {
> >       u8                      *pci_config_map;
> >       u8                      *vconfig;
> >       struct perm_bits        *msi_perm;
> > +     struct perm_bits        *cxl_perm;
> > +     u16                     cxl_dvsec;
> > +     u16                     cxl_dvsec_len;
> >       spinlock_t              irqlock;
> >       struct mutex            igate;
> >       struct xarray           ctx;

