Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029906;
	b=anClFNhxolKpqfwRVQ9Xa+Io1xiGIyPcHnwSGzYmsXFOUHjeSkVhqhvvSiJsXnA3jwja
	 RVDeSCRRZEv+5zpvr08v9TA8qO8y7W7s/Lob295NiAUcqWJHpKp6U/eizYM3zfE1aD7fn
	 HiySU/84cac0T4JlHQFTZ7fl6XBhxBKqg1S3iJMmP0cSFpducDVnLdm8hn0xPtCUEpdaZ
	 EUXNGFvGVnaylqrR8AaiLXeFX0QIXTqZjWdDL/aQEpHmjSkv2/rVTMir7h7laBeSJOIcz
	 SoeOHx00PYpAnTsnGqy94YtekorjW7FrjxM5mkmHlzh/I6fZVVlOlI0Uq4zW97f06xg==
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
	bh=2BzbAsYz+1phIzDaDbPExg3PSdnb22dxRRo57D2su/Y=;
	b=LHPzrXVszdDz3BRuOQr31X7Iixu3bCMnSYgQnDqKmiClzHOXnAYRMVUJHedANvxi6zZW
	 3ohgSKPFIwqSnm57q/8XWeBxo8O+IlPeUD9rUiPNOn7oEWLxXoCJqBKpEO1wr7i4VmW1R
	 b5KoSYvf4OSgzsISm84F/p9tZRyQv4blyM6dpD+OB/sN8zU6jhW6gKIQSeyHcgV03liOm
	 hp5YCM0fxcW3py9UPiWeZ0QZpPxhlq1apFkLtwHIb9oikv/Y2osudoY+1sIMGh3pxrGt9
	 o0P/wcTbf+PQ4tFdBTOzAQsl3RaT7TNyv/JyhZT+0r4oD9x5Z+tsguFpxmCkk5t3yZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ei5beVMD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4060A3812;
	Wed, 18 Nov 2026 19:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75D4060A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ei5beVMD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgDyAYwdhLf9bYSiNfgp7EyEhn2kuQEmcnhnjgUUeRU8T7abF39/+djouzawXVB1PqzOP9PdzLNQwUtl0FkfVBXWDpejKwHfv2JjKZpNX8vKPmyG5RL22cBge3wou/Q4v+j0ZzBluQbtUuVWdkPAkPICL3pR/QAXLl3LNuh06mslIJIEwb/9FOqflXoFBJU8h6fVLjoPL5pnp50EsolJn7iB7OQHFsmErQgA0zFxKXPhNYocxYBW6xox770b+eO8Rh8vt+89gk2tdKeMiLJokNDzq2SU+RJJy9T7qqxB6aWVTmcgoPtrCRz2tZD5sD2FTHRpYRAO1YpKMTcL12dWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BzbAsYz+1phIzDaDbPExg3PSdnb22dxRRo57D2su/Y=;
 b=CiEMMfkR2uGxtCpDbMVriOOY3ZDLTEvFLh1h1TtIxXvvnH03Tbhz8Cg81LMbccDbqxHLehSu55zEipjDyfkcesOAWHdceUT7NauwdQT/XP0rAXHeT/3uCaZANWuKAD4/wj0jCP7TvycSDPv0cVQ+3sBxDgn72k8bTb+sFFUYJDpwqoFJA853oGSFnvwOmkvD3ihQ4eIaFPeozyPer7quSTmkuQrpYU2KmLcvSRG/sJS9pfwImJxr8ELwZlQe8RSdc2uK92jPSrd7S+pEUDlJ5fskkPZabIdsdDunKxpZvaLBj78CHxlTNQhyGFqyD0hIBlCc7rfRMNBmaxHatGlBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BzbAsYz+1phIzDaDbPExg3PSdnb22dxRRo57D2su/Y=;
 b=Ei5beVMDhEj9wn4iyOMNxjyWfSfAi3HOJulxStUi6I+yD6D31O3PeXx8ke6YY1UPgzHyo0PX1hhm1Qi4xhwRw7k9xKUVTKNGTHgK0JNua50oY6kGjAsihWKXAA+fbPQdECN9hWP5kR2bnNqf7kITmXvBUaDk+g4YUpAf7LGgfHQ+Oa3HAgZOgDTXKWP03bC3t5YT5bq1pJCCkAn5j6gynAgwtJ3GVIB+K6fR9qSLSEqpGLNGUjpGrBjkFJzlriKiJJvFgf81RYuo9wfMNvCS8EDpk7yPozKt1fkwwlgm7AYCBOITDZKiSf4tZrybUoos3lW/Yc0MJpcJ6wb1GPiCOA==
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
Subject: RE: [PATCH v6 04/31] PCI/CXL: Let the driver that owns the HDM range
 run CXL Reset
Thread-Topic: [PATCH v6 04/31] PCI/CXL: Let the driver that owns the HDM range
 run CXL Reset
Thread-Index: AQHdXYo6EYOyUViGoEmnsQ2E8jNbwbcetIwAgBWimtA=
Date: Wed, 18 Nov 2026 19:24:51 +0000
Message-ID:
 <IA1PR12MB9030AD0B8D9E0BF860A29C0DBD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-5-mhonap@nvidia.com>
 <20261104165422.64b53bc4@shazbot.org>
In-Reply-To: <20261104165422.64b53bc4@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB9455:EE_
x-ms-office365-filtering-correlation-id: 9479d767-20b5-4103-0f77-08df45a99f17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|4143699003|261102130727099003|56012099006|11063799006|261026121527099003|261102123227099003|5023799004|261028144727099003|261022115727099003|261026140227099003|261021121427099003|261022105027099003|261026130827099003|261021130227099003|261021135927099003|261022113327099003|38070700021|261021123027099003|261022075727099003|10067099003;
x-microsoft-antispam-message-info:
 LWtE/h2hq/G+aBWsPBSJk58ZgSzyBE+eK56uFsvhbXTFsyzRO53vJNmL1icuv3Z1DDLxZE2MjE5oZAMpHJQphR2gyPYKJANb2bz+cP61xoqHsyAHJDk3VwbKfdMyUM74sA93+yaFNlxgm3AQHUdkoO0kbrur74HY03P6Z0sEXG05XGo6ljK/SN8BWam4727/8W2hSl94Lm6uZ0Y+mOhkpWf06qFfWjZ2UGKcoiUax59XsdDFJC0QdfRRTyvDbEyI4iGEYyraAlR+784Cp6l0kYvME1VXgHVq3BoN2XIZKNu8fBO5vp2J2rMRKCVN/27JT+8nWsdrPqzSmAc9ZufAkezcCckGO8mWVKPVJTJ1ejEt5iE6N4aZoIZz2SogTL4+vjXngYHhwWXJtUvFIrq6X6ZUUzvInDgNZTXERC4UCgonSw3k6vhIt93+APJ95FdiOvq0RXi4ss5ORoTf1Y4yN7hT+d2x41bIXirWs+fwJbZDJWKJbPSHikDp+vGz0uoicCweS4UwPpCoI/K4Apa8tKMQ9cya4dWQoZyl1ZPQ4++dDLebCWfdvCBsdbRo8jlW1Chq/32IXae/P/B82Erge93v2emM5c6COGGyhRNuv2Iflu3WRuGqqRNwpB3Qc0mIrlwJC3doY8oLl/Gj5XGhMuYp2OB2i8oAhfo14sP28ZswI7JyK8bo61SlcnsEl/3JN5LDY30DeAe64keQ6fS6WFwfmDmvZt5KCrfdGOVgLlk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(4143699003)(261102130727099003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(5023799004)(261028144727099003)(261022115727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261026130827099003)(261021130227099003)(261021135927099003)(261022113327099003)(38070700021)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KivBtYzmCJHvijsaJ4ePewCoLXesu4ZBAeW9lpjkjRc3UFu0SiG/+LxGW9Yd?=
 =?us-ascii?Q?jdqraEt976zgAate4SxaWZl/1Za+frPdsDWAE53/rJsh4b2W8EEAOSZtjb6G?=
 =?us-ascii?Q?XY/Xm4+ZLATQ90/EHQdX4AMvpUXaZx6vJQH1h97IzSjhhwWus4YZz0De0BLj?=
 =?us-ascii?Q?U/iDmBVD3i0ytetDzj8//MgZb1vUny/o4kAaO70x8RmMaCUsJ8uYz9LngZgN?=
 =?us-ascii?Q?RIIFe0t5OK3qBMf95Tc/YPCdldoLHQRacvu19qT4dV2X/mVYgSWsVx57UUcy?=
 =?us-ascii?Q?6GHmJvLTve/sXwhkx5R9si2Z6eC3oVEebWtE6hOHJFreu+PQaZQHuIIfKN1i?=
 =?us-ascii?Q?4lICsh0WNGT/6WIB+jHtGziGjFsH7RrDEVpTd9I3i+7elE/F6NyBqn+/biwZ?=
 =?us-ascii?Q?Hs10yw7dcLnbPy85bZtD3wSNDS66wflS/5rHH0CMdXG6YMzxQ6rlgZj9C4nK?=
 =?us-ascii?Q?5amTbvlkLlBRLO1NXlbZdCLojuSSE7+9wQFdp0n3z0zJwUmedOMkPpiOZkeM?=
 =?us-ascii?Q?2FIIA8Oluh2pIMs+A62nW0R8cuJ2wa0LMvP4DqGjFchaUHG1CJ6m+trx098z?=
 =?us-ascii?Q?7OI7H/vRp8OCqXcNZm1+Oth9vD7z3ToixtEC5Z5EdXO5ZWQFfBKGhW60/+lH?=
 =?us-ascii?Q?QhDH/kZGFNNpHdgPP1Z4/p0I2uXwkn/g2qyYnIA3mSG0OYsaFEomOxp6ZvGo?=
 =?us-ascii?Q?i8A8loOnRGQLhZe+a3rN4Xk108E4P7nG2Yv/VF0azMpTJqtPyds56BVDwhyL?=
 =?us-ascii?Q?ICcHWEjc51guSX/WPgbinlloWPZFKH5SQ4Q09XHPnQNyD5qCC5ihseVJFROh?=
 =?us-ascii?Q?moxGNoQfEiO0qsHE15+AQ3tw88MgpnLx1K8SjlE7ULz+/n6cEM2rwEMCxK8v?=
 =?us-ascii?Q?usJlMZ8O+sIjkA4V1BfRb0XKnTmHhqIkemqgENWTapuK74sCmjZjDrR2YOmF?=
 =?us-ascii?Q?4EK1et58zIJZHXnbku+mU7yIEC43KUU9adbOy+Kw6vfcTnWC6qH4dBtEfC4+?=
 =?us-ascii?Q?J6kBVsarRI3aA5AAX+ivetAbAqKBj/gXUySufZ0K7KECBi78mFnXdCjMDwLS?=
 =?us-ascii?Q?9doQJG1Jvw1pcQiVlFZXH7uAAGN2svFRIMgyn9zG7H4QZh/+gw8mh3nao5bu?=
 =?us-ascii?Q?JgNROhvRXrp1MtKpfJ0/h6+PudSbxwVQ1lI+961h9mg7/sXjjC3QKEqF/hiX?=
 =?us-ascii?Q?YdgMIkeg8yQ+dixQ4udCWlbsGxg9bSUFEcRj44kurpyCjrgIq0GVRWNPEgfF?=
 =?us-ascii?Q?U8xaS133LhexFYhZn+0D+CH9eBi7itgSXlfvU51j1VwiJlt1tVHFeOngfYz7?=
 =?us-ascii?Q?99/jFuET/Oftak2yPD5Vu05dZHw3KU8OFbxaUy7+UmnpXXWiPlZ+9Rfu4Kuu?=
 =?us-ascii?Q?ht7N14KOZe808SGK9gUq3xH0piF6SljP2A4szv6sUmTJfkshyan9YtzvFEU2?=
 =?us-ascii?Q?UYdlmyvpbq9jMiWLzYU8qStFJWWvrIwAsWNnuegvIbVm3OgMih9FJ3J6kWJz?=
 =?us-ascii?Q?gdt5Z0IY4tZCve3T9E91nYrQ+QcQ3CnuGdPtxMNTKJYQNKCszHhh9BJhQt6K?=
 =?us-ascii?Q?4G6p1V7qRFeXZFFkEFqAO4dZeL/UlU4xrR6+LMFgDZXdh/hQDRYPwLy3CDkF?=
 =?us-ascii?Q?TapC5E9OUrM2I6OC7QC2Y38kHECQ2gDGk3qpMe9fMn9Hy04gCQEHY2mbTXOg?=
 =?us-ascii?Q?MvqumFKtYNaZC2ake89aptiVLx7EgGWlciHKpLARfVJgT255?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9479d767-20b5-4103-0f77-08df45a99f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 19:24:51.5096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83+HOjDku0RgRbNXJyC9mPUeUKPJiM6R4xN41AouIBIi1FC0hRRLBsjug7D9pbBh9tFDBzD9jFKoWS3y/3lQvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Thursday, November 5, 2026 5:24 AM
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
> Subject: Re: [PATCH v6 04/31] PCI/CXL: Let the driver that owns the HDM r=
ange
> run CXL Reset
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 16 Oct 2026 21:48:11 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > vfio-cxl passes a CXL Type-2 device to a guest and must run CXL Reset
> > at the vfio reset points. The cxl_reset PCI reset method does not fit
> > that
> > caller:
> >
> > - It requests every HPA range the device decodes. vfio-cxl holds that
> >   range with request_mem_region_exclusive() while it exposes the memory=
,
> >   so the request fails with -EBUSY.
> > - When the reset cannot run, the method returns -ENOTTY and the PCI cor=
e
> >   moves on to the next method. That is FLR, which leaves device memory
> >   intact for the next user.
> > - The snapshot and restore helpers that vfio-cxl needs after a bus rese=
t
> >   and on return from low power are not exported.
> >
> > Let cxl_hdm_quiesce_prepare() take the resource the caller already
> > holds and skip the request for ranges inside it. pci_cxl_reset_owned()
> > accepts only a resource marked busy and exclusive, as
> > request_mem_region_exclusive() leaves it. The CPU caches are still
> > written back and invalidated for every range before and after the
> > reset, as the reset method does.
> >
> > Add:
> > - pci_cxl_reset_owned(): runs the reset method's sequence for a caller =
that
> >   holds the device lock and returns any failure to that caller
> >
> > - pci_cxl_reset_capable(): checks the cached HDM state and the CPU cach=
e
> >   invalidation that the reset-method probe skips.
> >
> > - pci_cxl_hdm_snapshot(): copies the HDM state cached at enumeration
> >   without requiring the device lock. A driver needs this copy in probe,
> >   which the PCI core may run in a worker on the device's NUMA node, whe=
re
> >   device_lock_assert() would warn although the binding task holds the
> >   lock. pci_cxl_reset_prepare() becomes that copy plus the lock asserti=
on.
> >
> > Export:
> > - pci_cxl_reset_owned()
> > - pci_cxl_reset_capable()
> > - pci_cxl_hdm_snapshot()
> > - cxl_restore_state_after_pci_reset()
> >
> > to the vfio-cxl module only, and declare them in include/cxl/pci.h.
> >
> > CXL Reset always clears memory, so there is no caller Memory Clear choi=
ce.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/cxl/core/hdm_state.c |  22 ++++--
> >  drivers/pci/cxl.c            | 136 ++++++++++++++++++++++++++++-------
> >  drivers/pci/pci.h            |  18 +----
> >  include/cxl/hdm.h            |   3 +-
> >  include/cxl/pci.h            |  39 ++++++++++
> >  5 files changed, 171 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/cxl/core/hdm_state.c
> > b/drivers/cxl/core/hdm_state.c index 95daeda0ef80..9452047e3b97 100644
> > --- a/drivers/cxl/core/hdm_state.c
> > +++ b/drivers/cxl/core/hdm_state.c
> > @@ -267,7 +267,8 @@ static int cxl_hdm_ranges_collect(struct
> cxl_hdm_quiesce *q, struct device *dev,
> >       return 0;
> >  }
> >
> > -static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q)
> > +static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q,
> > +                               const struct resource *owned)
> >  {
> >       struct cxl_hdm_range *range;
> >
> > @@ -275,6 +276,12 @@ static int cxl_hdm_ranges_request(struct
> > cxl_hdm_quiesce *q)
> >
> >       list_for_each_entry(range, &q->ranges, list) {
> >               const struct range *hpa_range =3D &range->hpa_range;
> > +             struct resource res =3D DEFINE_RES_MEM(hpa_range->start,
> > +                                                  range->len);
> > +
> > +             /* The caller already holds this range exclusively. */
> > +             if (owned && resource_contains(owned, &res))
> > +                     continue;
> >
> >               range->res =3D request_mem_region(hpa_range->start, range=
->len,
> >                                               "cxl_reset"); @@ -316,15
> > +323,20 @@ static int cxl_hdm_ranges_invalidate(struct cxl_hdm_quiesce
> *q)
> >   * @dev: device for error messages
> >   * @q: quiesce state to initialize
> >   * @snapshot: HDM state from cxl_hdm_cache_snapshot()
> > + * @owned: resource the caller holds exclusively over the ranges, or
> > + NULL
> >   *
> >   * Reserve every enabled system-physical range in @snapshot
> > exclusively, then
> > - * write back and invalidate CPU caches for them. Call
> > - * cxl_hdm_quiesce_destroy() afterwards whether or not this succeeds.
> > + * write back and invalidate CPU caches for them. A range inside
> > + @owned is
> > + * not requested again; the caller's reservation already excludes
> > + other
> > + * users.
> > + *
> > + * Call cxl_hdm_quiesce_destroy() afterwards whether or not this succe=
eds.
> >   *
> >   * Return: 0 on success, or a negative errno.
> >   */
> >  int cxl_hdm_quiesce_prepare(struct device *dev, struct cxl_hdm_quiesce=
 *q,
> > -                         const struct cxl_hdm_info *snapshot)
> > +                         const struct cxl_hdm_info *snapshot,
> > +                         const struct resource *owned)
> >  {
> >       int rc;
> >
> > @@ -340,7 +352,7 @@ int cxl_hdm_quiesce_prepare(struct device *dev,
> struct cxl_hdm_quiesce *q,
> >       if (rc)
> >               return rc;
> >
> > -     rc =3D cxl_hdm_ranges_request(q);
> > +     rc =3D cxl_hdm_ranges_request(q, owned);
> >       if (rc)
> >               return rc;
> >
> > diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c index
> > ed0b6f619c70..b4d467506c54 100644
> > --- a/drivers/pci/cxl.c
> > +++ b/drivers/pci/cxl.c
> > @@ -372,9 +372,32 @@ static int cxl_reset_save_restored_state(struct
> pci_dev *pdev, u16 command)
> >       return rc;
> >  }
> >
> > +/**
> > + * pci_cxl_hdm_snapshot() - copy the HDM state cached at enumeration
> > + * @pdev: CXL device
> > + *
> > + * The cache is read under cxl_rwsem.dpa, so the caller needs no
> > +device
> > + * lock. A driver can call this from probe, which the PCI core may
> > +run in a
> > + * worker on the device's NUMA node while the binding task holds the l=
ock.
> > + *
> > + * Return: a copy to free with kfree(); NULL when @pdev has no cached
> > +HDM
> > + * state; or an ERR_PTR() on failure.
> > + */
> > +struct cxl_hdm_info *pci_cxl_hdm_snapshot(struct pci_dev *pdev) {
> > +     struct cxl_hdm_info *snapshot;
> > +
> > +     snapshot =3D cxl_hdm_cache_snapshot(&pdev->hdm);
> > +     if (IS_ERR(snapshot) && PTR_ERR(snapshot) =3D=3D -ENXIO)
> > +             return NULL;
> > +
> > +     return snapshot;
> > +}
> > +EXPORT_SYMBOL_FOR_MODULES(pci_cxl_hdm_snapshot, "vfio-cxl");
>=20
> Why are any of these module locked?  What great risk do they expose that =
only
> vfio-cxl should have access to versus just a NS export?
>=20
> We shouldn't set a precedent for vfio specific APIs and I certainly don't=
 want to
> be defending such a thing down the road.

Hmm; let me reassess this in v7. I will try to model the reset code through=
 PCI core.
This will result in owner-aware reset and its exports to be removed.

>=20
> It's unfortunate that we're intermixing "snapshot" from CXL but using it =
like a
> "save state" from PCI.  Maybe we could bridge the gap at the PCI API?
>=20

For v7, I will drop the save state use. Vfio-cxl restores nothing itself. T=
he only
restore is the one cxl_reset method does inside its own reset.

> > +
> >  /**
> >   * pci_cxl_reset_prepare() - allocate HDM state storage ahead of a
> > bus reset
> > - * @pdev: device about to be reset
> > + * @pdev: device about to be reset, with its device lock held
> >   *
> >   * Copy the cached HDM state before the reset, so that restoring canno=
t fail
> >   * for lack of memory. The decoder settings are refreshed when the
> > state is @@ -386,14 +409,8 @@ static int
> cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
> >   */
> >  struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)  {
> > -     struct cxl_hdm_info *snapshot;
> > -
> >       device_lock_assert(&pdev->dev);
> > -     snapshot =3D cxl_hdm_cache_snapshot(&pdev->hdm);
> > -     if (IS_ERR(snapshot) && PTR_ERR(snapshot) =3D=3D -ENXIO)
> > -             return NULL;
> > -
> > -     return snapshot;
> > +     return pci_cxl_hdm_snapshot(pdev);
> >  }
> >
> >  /**
> > @@ -433,6 +450,7 @@ int cxl_restore_state_after_pci_reset(struct pci_de=
v
> *pdev,
> >       cxl_region_quiesce_unlock();
> >       return rc;
> >  }
> > +EXPORT_SYMBOL_FOR_MODULES(cxl_restore_state_after_pci_reset,
> > +"vfio-cxl");
> >
> >  /*
> >   * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
> > @@ -642,7 +660,8 @@ static int __cxl_reset_execute(struct pci_dev *pdev=
,
> int dvsec, u16 cap,
> >       return rc;
> >  }
> >
> > -static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16
> > cap)
> > +static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap=
,
> > +                           const struct resource *owned)
> >       __must_hold(cxl_region_quiesce)
> >  {
> >       struct cxl_hdm_info *snapshot __free(kfree) =3D NULL; @@ -663,7
> > +682,7 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec=
, u16
> cap)
> >               return PTR_ERR(snapshot);
> >       }
> >
> > -     rc =3D cxl_hdm_quiesce_prepare(&pdev->dev, &q, snapshot);
> > +     rc =3D cxl_hdm_quiesce_prepare(&pdev->dev, &q, snapshot, owned);
> >       if (rc) {
> >               cxl_hdm_quiesce_destroy(&q);
> >               return rc;
> > @@ -686,32 +705,40 @@ static int cxl_reset_quiesced(struct pci_dev *pde=
v,
> int dvsec, u16 cap)
> >       return cxl_reset_save_restored_state(pdev, command);  }
> >
> > -static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16
> > cap)
> > +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
> > +                          const struct resource *owned)
> >  {
> >       int rc;
> >
> > +     /* Raw reset callers may not have saved the PCI state needed for =
restore.
> */
> > +     if (!pdev->state_saved) {
> > +             pci_err(pdev, "CXL reset requires saved PCI state\n");
> > +             return -EINVAL;
> > +     }
> > +
> >       cxl_region_quiesce_lock();
> > -     rc =3D cxl_reset_quiesced(pdev, dvsec, cap);
> > +     rc =3D cxl_reset_quiesced(pdev, dvsec, cap, owned);
> >       cxl_region_quiesce_unlock();
> >
> >       return rc;
> >  }
> >
> > -int cxl_reset_function(struct pci_dev *pdev, bool probe)
> > +static int cxl_reset_check(struct pci_dev *pdev, bool probe, u16 *dvse=
c,
> > +                        u16 *cap)
> >  {
> > -     u16 dvsec, cap, ctrl;
> > +     u16 ctrl;
> >       int rc;
> >
> > -     rc =3D cxl_pci_device_dvsec(pdev, &dvsec, &cap);
> > +     rc =3D cxl_pci_device_dvsec(pdev, dvsec, cap);
> >       if (rc)
> >               return probe ? -ENOTTY : rc;
> > -     if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> > -         !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
> > -         !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
> > -         !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
> > +     if (!(*cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> > +         !(*cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
> > +         !(*cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
> > +         !(*cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
> >               return -ENOTTY;
> >
> > -     rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ct=
rl);
> > +     rc =3D pci_read_config_word(pdev, *dvsec + PCI_DVSEC_CXL_CTRL,
> > + &ctrl);
> >       if (rc)
> >               return probe ? -ENOTTY : pcibios_err_to_errno(rc);
> >       if (PCI_POSSIBLE_ERROR(ctrl))
> > @@ -737,11 +764,70 @@ int cxl_reset_function(struct pci_dev *pdev, bool
> probe)
> >       if (!cpu_cache_has_invalidate_memregion())
> >               return -ENOTTY;
> >
> > -     /* Raw reset callers may not have saved the PCI state needed for =
restore.
> */
> > -     if (!pdev->state_saved) {
> > -             pci_err(pdev, "CXL reset requires saved PCI state\n");
> > +     return 0;
> > +}
> > +
> > +int cxl_reset_function(struct pci_dev *pdev, bool probe) {
> > +     u16 dvsec, cap;
> > +     int rc;
> > +
> > +     rc =3D cxl_reset_check(pdev, probe, &dvsec, &cap);
> > +     if (rc || probe)
> > +             return rc;
> > +
> > +     return cxl_reset_execute(pdev, dvsec, cap, NULL); }
> > +
> > +/**
> > + * pci_cxl_reset_capable() - check whether CXL Reset can run on a
> > +device now
> > + * @pdev: CXL device
> > + *
> > + * Unlike the reset-method probe, this also checks the cached HDM
> > +state and
> > + * the CPU cache invalidation that the reset needs.
> > + *
> > + * Return: true when pci_cxl_reset_owned() can attempt the reset.
> > + */
> > +bool pci_cxl_reset_capable(struct pci_dev *pdev) {
> > +     u16 dvsec, cap;
> > +
> > +     return !cxl_reset_check(pdev, false, &dvsec, &cap); }
> > +EXPORT_SYMBOL_FOR_MODULES(pci_cxl_reset_capable, "vfio-cxl");
> > +
> > +/**
> > + * pci_cxl_reset_owned() - CXL Reset for the driver that owns the HDM
> > +range
> > + * @pdev: CXL device, with its device lock held and PCI state saved
> > + * @owned: resource the caller reserved over the device's HPA range wi=
th
> > + *      request_mem_region_exclusive(), or NULL
> > + *
> > + * Run the same sequence as the cxl_reset method. Ranges inside
> > +@owned are not
> > + * requested again, so a driver that keeps the HPA range reserved
> > +while it
> > + * exposes the memory can reset the device. The CPU caches are still
> > + * invalidated for every range before and after the reset.
> > + *
> > + * Return: 0 on success, or a negative errno. Unlike the reset
> > +method, a
> > + * device that cannot be reset returns an error to the caller instead
> > +of
> > + * falling through to another reset method. -EINVAL if @owned is not
> > +a busy,
> > + * exclusive reservation.
> > + */
> > +int pci_cxl_reset_owned(struct pci_dev *pdev, const struct resource
> > +*owned) {
> > +     const unsigned long held =3D IORESOURCE_BUSY |
> IORESOURCE_EXCLUSIVE;
> > +     u16 dvsec, cap;
> > +     int rc;
> > +
> > +     device_lock_assert(&pdev->dev);
> > +
> > +     /* Only a busy, exclusive reservation keeps other users off the r=
ange. */
> > +     if (owned && WARN_ON_ONCE((owned->flags & held) !=3D held))
> >               return -EINVAL;
> > -     }
> >
> > -     return cxl_reset_execute(pdev, dvsec, cap);
> > +     rc =3D cxl_reset_check(pdev, false, &dvsec, &cap);
> > +     if (rc)
> > +             return rc;
> > +
> > +     return cxl_reset_execute(pdev, dvsec, cap, owned);
> >  }
>=20
> There's a lot of asymmetric sketchiness through this path.
> pdev->state_saved is required to be set by the caller, but the state
> gets restored and state_saved invalided deep inside
> cxl_restore_pci_state_for_hdm_restore() on this path. That's not at all
> symmetric to the PCI conventions and the split ownership model is poor.
> Even worse, it's vfio-pci-core doing the pci_save_state() on behalf of th=
e
> cxl_ops.reset callback.
>=20
> Where does bus-master get cleared?  Seems we've only got half of
> pci_dev_save_and_disable() implemented here and the save has become the
> caller's responsibility.  Thanks,
>=20

It is not getting cleared on this path. I think this a bug in this patch an=
d needs
some more time from me. For v7, I will make sure every reset goes through t=
he
PCI core as vfio already does for other cases.

Thanks,
Manish

> Alex
