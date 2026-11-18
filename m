Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029902;
	b=W+iXLMoG6NL7jqTOz5iKyRqvtF2Hu6cEek/L9waopWBh4lkLbGDcqVcN7nqNej85jQzJ
	 3lKYXEkqZUbWZlFw2OdeLcg/1zK+300DXj/J2+oneZnvJ4vdEFt9RA/u/96aLQygQDUny
	 1UeQu0NabCkZQ9MWweUZOj1Kc4MJmJPhWEMytGv/dOnL/4f+9cviNryh9GBZN8UNp61Os
	 +L3OIRDR7bQ1bRzw3hteFI6bDTQkoIHO/RkT+sGiPvliX1g9eJkiQpzTbTXzRLoBnOCXK
	 ClhyEmvwIdiivHmoTWxCdb+xDlXtotaiBdXJlfgWwEAwaK2OudtGKCL27310cEB5v7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029902;
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
	bh=b7MzQMfnqHTkyO5BjqD/p3qoUShkXGHwxbtDIvEsfMM=;
	b=dao40U8i4yF5Y5Wqm6f4eLo1Rt9nCzM8HSrm0uvpVb6XpJ8FIeJXtg3hVEBbTTfry1x1
	 lPMdfxg8hWfZLkA0DX4a+2unEQTgMJ0zshzf60gYa7qduSsY6ZhKKXzhqidwhoefeGdHZ
	 bqj2lzcVQrkz6dTdx5pNTfBLTd54zatgN/CuU9/r02w8skyQaQnurg+x00oieLzQLbCSY
	 v+6AWx5ZcXgOaeNvHCgBvc1r1IKy8tdayZW/L7bUVHi8NK9VfqOmvJoTATfcSjzJBjj+s
	 fd0GxCpMZluittB5wg1IkmkVdcPzacOy5O39PefdU6ApGVA0Bwm4LWPsETo2K5K9OQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="d/8fiuj+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FE9606A325;
	Wed, 18 Nov 2026 19:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21FE9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d/8fiuj+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGEOyeWQAu92VWztEibyOHsAw8p1aOMk0tZmvpthwYV9Ycuu8Fa47QR3EjOsMUFtFyi9Ld39I2SqAIgESfyvdtWdeRp7MAzHvAbjUUKmnbUpene84n70TK91+HpC0bGWXO8Xckg6ZELzFAUSPpNTedEUNPxDSii1tWhhyLlOey/pRmS/pTFWDWMCQQnhRmp71T1G0L7MhLVIhGrCEOYMZqk2DWkHk0cGNGnlcz4Rq/olx4CzV2H16DL2Ibb88uWlufwWF0eOj24KKadACagyEvH3aqJdsSFxkPz4mwHSumuFeNNm9tYvNirugCEdoSFRZKrbZHI9npAMxx3rNkEv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7MzQMfnqHTkyO5BjqD/p3qoUShkXGHwxbtDIvEsfMM=;
 b=hxPyT2W3LKwk3x1aUI7ARkBPmWW13c5O/2Lu/MmhxOHh4mgZuchETKjj4c9AYgViakDMW9y5THMCbMqeAvbz2PQfcsO7IghYNEqM2oAd2lVLLn44lY+4/d1+72dXBnLdBn1x0xWNVp+RNfSOgAe3s5hKnM3htJwCselK37g9awwHdgZdy6cvsiQzs0EOEkY02kFUcHD7UMb0V7+ffPj2/sfRci90gLsmHMXtlYIum+eGaXAay847pSTX4hCJAu/w9XhI3WNyw9+XkbgJdanhzmMm0rd3ccn2PCL9InkxNVjyDBSfXm10IHDtNQqqOndUo/Mxp5cV44s552R0YvW3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7MzQMfnqHTkyO5BjqD/p3qoUShkXGHwxbtDIvEsfMM=;
 b=d/8fiuj+fuw1bLykGzpi0r0gY9Yow22f/hvvWz8Sr+QYyMtz/wLKJ2YUPTBCdjY07QPOBtqlR3cPSn1CwVKxDwSyxl/IFeKRwjVIiXYfJoj4Sz9KBu9fnzaHn18ZaNIxwP3y6hsHVtrRI0/P4p9O/xm/rJsAcsWjAo1KYGCZXc25RRwVtJ+5qUiSdS96Tc/fB+QUsNZeS62M4nPTi/MfKc0edYY1cLSH9pohs/GeSv/WhG5suzb9msBXAx8svJnQ7YOXn5WvdJ5FBaVQDBD7hVq6tvkgs1AAhB8xqix7OvMgBkGrkrNSyOePROJOmuzOSPN5V6G2iHT3YtZ3oXVghA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:24:38 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:24:38 +0000
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
Subject: RE: [PATCH v6 08/31] vfio/pci: Add a generic excluded-range list
Thread-Topic: [PATCH v6 08/31] vfio/pci: Add a generic excluded-range list
Thread-Index: AQHdXYpNK/PLI2S8VUu9BLKNtGt9GLchVJOAgBD1QHA=
Date: Wed, 18 Nov 2026 19:24:38 +0000
Message-ID:
 <IA1PR12MB9030C28092AE48135D896F63BD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
 <20261016161839.2765592-9-mhonap@nvidia.com>
 <20261106085939.764b6dde@shazbot.org>
In-Reply-To: <20261106085939.764b6dde@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB9455:EE_
x-ms-office365-filtering-correlation-id: 38af0f0c-017b-44f4-a98e-08df45a99699
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|4143699003|261102130727099003|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003|261022075727099003|10067099003;
x-microsoft-antispam-message-info:
 tHFMm6nOwdrnUilIaNawvjMpmNhP77xP12/Hdulb86f5jCD0+TleT//PUjRPlUm34WbkWyxyZbaxdmo4P5pK46u2GzGJBHVLvo7dWfb0C2VDubx0xKQ90tWQGUMZnptMP+y2d9gTitTx2IJVzuQ6kFsW81HHJgnh5pFFSnwLSwcEFIoPA/mqV+8j5ScDiM1qGV/nxr+KkT4VRiBlOeLdmUhGVlONjOj9s9X9YlJZ/AYlW73H/yW3K8jUmCvNoOUnKaG/NqgCpVR6h3LYBlAKtvVlU62W7bRR+9fx7KZk62/f1K0hClrsDLpNMPsNhFhQraiMf06cL+lSbuOBWnpT+tUf9RontOiKiW0x19SDUwPKpN7dgvJBO9QkyQAZEW5uHworGYGK0G4aymqvZV0F4496kV7vzXv9T4vwpMbxLu5XEUD+aa8nNyVG1mzBrZ2NLS/99LciWxilKl3cyRTw2RcoEVIvjH76JrMJuvL7idZ5QaEhVkNPbeq+qjA9b055gHOejxjNWmZGxXVljOQHDgwae5Es19IvX8Ca4c8PbVDNThwk3UMV6PYwpwKN4svdwTrUsmavsvpWFV7hU8LfURiHHKTs16l6qGZXEh//Wid6mzsFd8Zx29eaYtMouuUWgHOPSI6ej5Onbw5BY3H2BCda9eeQhj3B7vnomygLuw4ujyqMOS9GJxRQyGBYz70gU5WwmD9djtU6f0Gy4wK/TYglpBAKRL+fVOa24yPv1hs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(4143699003)(261102130727099003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JO+jfvipWWghacuiuzPbFt+fqx9MDEt1kbtLGlV5cFtzHdYh79baJCoFIIlS?=
 =?us-ascii?Q?FDQ1VzDscOFq45CAHoZ8lFR+v2840hp8bE1j/yGDPjnbwQFsupf1Ziw9znQI?=
 =?us-ascii?Q?6OVnzvzChbAsOIXnwE0Wtof99zP5fR/ftr0fsNA1O0bPXyRAohNpGBDbV0Qi?=
 =?us-ascii?Q?4BQRCOctmL4UDBnBtQ9K7dZuWMOhggTfAot2ZySfpY6v7eur1qo+s6cFFWXa?=
 =?us-ascii?Q?9tkhPd8LNlpUaV1b4/dHcith6+CGha8MtmKam53fp4YYi7b5MSwCqd/HkFSV?=
 =?us-ascii?Q?ZowiWWjo3XQNOSK6sa3yV5dYV83w84zY/wLOObyxsYCsyQU8fMGaDPizigTE?=
 =?us-ascii?Q?wYpEAE6WWbg5Tlzd2+X+d7JA3AGQu2qPLGd90VGnvB+rCtAAd2OJbMlADSxS?=
 =?us-ascii?Q?vPSTxGXuCfMRG8CNI0m6QD5Sdym6oabLrNR6S8oW5nxGK/7e5/k7ax0MKhbS?=
 =?us-ascii?Q?6n5wsQG9Me0I6C4q0SvGLhcsgay3dLtD1m2P6enlSnaUyAfDYg/IXIZz19+t?=
 =?us-ascii?Q?NVqKwqvek9LbAiOlRu3ec/OrGRajBjPZ13vzUk/0cgF9GvJ6ot4NPN0N1Flt?=
 =?us-ascii?Q?e/S3VNzWnrOLJRDerXywnsHPObBTK8iiPhVrZdBK6a2DzVYailO/4IgO6Cna?=
 =?us-ascii?Q?v2CpHBwrQ+IL8qKtY9qfYgSlMSluhip9MMjn5kJpeMuwOyP1LA1m4U7PRPYE?=
 =?us-ascii?Q?NQqtH+BiJbf6h4oXDWqHqQeCYtNvqRdWrXMEFlgrsIu7ReCeWH9RnqnvrqV/?=
 =?us-ascii?Q?K9NF1nTPTlJMCz4DofMv+dlSUNnvVplxbzXKZ9RFC/LKz3mint/R+kzIG/yI?=
 =?us-ascii?Q?e4bYDfxhvH2mTCJgK4kXTVL7loO6/nqisFt+MRqHAEjtZtvQItJH0dm68Cun?=
 =?us-ascii?Q?Oz7LuhD83h50sQjSwx4zcb/Ac4u2f+qmYGNnPf4DHoL7wKlw5rqDOrEOHgL/?=
 =?us-ascii?Q?WF8LkrjpnT3UkKx3b0J/wWfB9C8OtlEtBzfTnj/coBLQw39tH0hcsG9WS/at?=
 =?us-ascii?Q?gQyJiW3xZMYtAI8VbPi6r2dc/a4lpSIiyjQdhbsjvvFK0E6J0szzgmYCRbhT?=
 =?us-ascii?Q?54tLS0NEj3OQVNg3mTRCqql8azNWlFyBqWYYbvJlzgx5J4+iMn422UN3g4od?=
 =?us-ascii?Q?I/grLtpTCO9RAj8/bp8jjH8fpFCTrrOfZqRQp9Y3iaTZ5+ekp26BTKzgQucK?=
 =?us-ascii?Q?72Jc4K6Y59FZgjueIASguSHk7ToEkYtBzhPqvM8AQ4N2T4gA4z7ajCIRVF61?=
 =?us-ascii?Q?3X4f3ZWJFVYvXg/WwI3mG9bCFd1QG1ZljENYO3PSyI/V6Us5n+6YtzbnTuQA?=
 =?us-ascii?Q?YP7XTHJy1Rw2Q5/NxV0SgPXf1K2CejDsC1axS48B57SnQR7VXc7nBkpUzIyu?=
 =?us-ascii?Q?9Je5vYj8L94QbsMyxILHICswTq1WvaBZStvByCol/Vy720ObJk2SqzHQpPHX?=
 =?us-ascii?Q?IuHvEIKD66vZHgBeSWTj+vxFBKqZkxzM2tQnzFs4F+0GcNChwna1g1A2Uvu1?=
 =?us-ascii?Q?JjyJG4/z6bAuWTi+IMNWx6Jur3SeM+7fyykKhpUEyVgP9AtJLgWtnHHzSjTc?=
 =?us-ascii?Q?zV6mGvvMtx3w28RyA1NMpLAAPFWBg7rWcg01ve+GYaJA0eX8aKm9d6B4BbXb?=
 =?us-ascii?Q?5p2UhkeYtCiRGQfl+YZoTWonUSbRzMWSp4PrHvAvxNR1WT4Uym7WLlZDRcBa?=
 =?us-ascii?Q?6NQAU/dPVvIEgxaJpfWZ0PF3/T8lw5cxKrj8LAuTpG3rnm4/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38af0f0c-017b-44f4-a98e-08df45a99699
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 19:24:38.8074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UEIwJTBkhrFLVtD5fa553Wpl4Dvw8pNpn2lAyex6K61wRhElguxTx8eeZqavNmVyUmtAHoAX+FPEfOVL3pqeZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455

> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Friday, November 6, 2026 9:30 PM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan
> Madhavan <smadhavan@nvidia.com>; corbet@lwn.net;
> skhan@linuxfoundation.org; dave@stgolabs.net; alison.schofield@intel.com;
> vishal.l.verma@intel.com; iweiny@kernel.org; ming.li@zohomail.com; Yishai
> Hadas <yishaih@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org; alex@shazbot.=
org
> Subject: Re: [PATCH v6 08/31] vfio/pci: Add a generic excluded-range list
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 16 Oct 2026 21:48:15 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A provider such as vfio-cxl needs to keep sub-ranges of a BAR off the
> > direct guest path and serve them through its own trap. vfio-pci-core
> > already has one such window, the MSI-X table, open-coded in
> > vfio_pci_bar_rw().
> >
> > Add vfio_pci_core_add_excluded_range(). Each BAR has its own list,
> > sorted by start, and an insert that overlaps a range on the same BAR
> > or ends past the BAR fails with -EINVAL. Ranges are added only while
> > the device is being opened and are freed in vfio_pci_core_disable(),
> > so readers on an open device take no lock.
> >
> > The MSI-X table is virtualized in vfio_pci_bar_rw() by an open-coded
> > x_start/x_end window that fills reads with -1 and drops writes.
> > Register the MSI-X table as a read and write excluded range when the
> > MSI-X capability is parsed in vfio_pci_core_enable(), and walk the
> > BAR's ranges in order in vfio_pci_bar_rw(), so an access that spans
> > several ranges is handled in one pass. Only the part of the table
> > inside its BAR is registered, so a device whose MSI-X capability
> > points outside the BAR still opens, as before. The ROM BAR keeps its
> > trailing -1 window, outside the list.
> >
> > No behavioral change for an MSI-X table in a standard BAR: an access
> > to it still reads -1 and drops writes.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c | 97
> > ++++++++++++++++++++++++++++++++  drivers/vfio/pci/vfio_pci_priv.h |
> > 8 +++  drivers/vfio/pci/vfio_pci_rdwr.c | 67 +++++++++++++++++++---
> >  include/linux/vfio_pci_core.h    | 20 +++++++
> >  4 files changed, 185 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index e50b36751d9a..bee3d1b4d8d2 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -588,6 +588,8 @@ static const struct dev_pm_ops
> vfio_pci_core_pm_ops =3D {
> >                          NULL)
> >  };
> >
> > +static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device
> > +*vdev);
> > +
> >  int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)  {
> >       struct pci_dev *pdev =3D vdev->pdev; @@ -644,6 +646,7 @@ int
> > vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
> >
> >       msix_pos =3D pdev->msix_cap;
> >       if (msix_pos) {
> > +             u64 bar_len =3D 0;
> >               u16 flags;
> >               u32 table;
> >
> > @@ -654,6 +657,30 @@ int vfio_pci_core_enable(struct
> vfio_pci_core_device *vdev)
> >               vdev->msix_offset =3D table & PCI_MSIX_TABLE_OFFSET;
> >               vdev->msix_size =3D ((flags & PCI_MSIX_FLAGS_QSIZE) + 1) =
* 16;
> >               vdev->has_dyn_msix =3D pci_msix_can_alloc_dyn(pdev);
> > +
> > +             /*
> > +              * Virtualize the MSI-X table through the excluded-range =
list:
> > +              * reads fill -1 and writes are dropped so the guest neve=
r
> > +              * reaches the hardware table directly. BAR access never =
goes
> > +              * past the BAR, so only the part of the table inside the=
 BAR
> > +              * needs a range; a table placed outside its BAR needs no=
ne.
> > +              */
>=20
> AI comments.
>=20
> > +             if (vdev->msix_bar < PCI_STD_NUM_BARS)
> > +                     bar_len =3D pci_resource_len(pdev, vdev->msix_bar=
);
> > +             if (vdev->msix_offset < bar_len) {
> > +                     u64 len =3D min_t(u64, vdev->msix_size,
> > +                                     bar_len - vdev->msix_offset);
> > +
> > +                     ret =3D vfio_pci_core_add_excluded_range(vdev, vd=
ev->msix_bar,
> > +                                                            vdev->msix=
_offset, len,
> > +                                                            VFIO_PCI_E=
XCLUDE_READ |
> > +
> > + VFIO_PCI_EXCLUDE_WRITE);
>=20
> This is not a terribly elegant flow and I think the AI comment above miss=
es the
> main point of what the apparently redundant BAR range and size cap test a=
re
> trying to accomplish, compatibility.
>=20
> In the current code, it doesn't matter if BIR is bogus or the offset does=
n't land
> in the BAR length or size overflows, those just generate non-matches when
> we read or write.
>=20
> I think this would be cleaner as a separate function that wraps the new
> function, returning success (perhaps even with a pci_warn_once) for an ou=
t of
> range BIR or offset, and performs silent cleanup on a range that exceeds =
the
> BAR, with a human generated comment explaining the compatibility
> argument.

Okay, Agreed. For v7 I will add the MSI-X range in its own helper: a bad BI=
R
or offset will not add and provide a warning. A table that runs past the BA=
R
is clipped. I will also update the comment correctly removing the AI-slop.

>=20
> > +                     if (ret) {
> > +                             vfio_pci_free_excluded_ranges(vdev);
> > +                             vfio_config_free(vdev);
> > +                             goto out_free_zdev;
>=20
> This is mixing local cleanup with an unwind goto and it bites us later in=
 the
> series when we end up leaving this in place and adding:

Okay, I will add a separate label in unwind for this.

>=20
> out_free_config:
>         /* A failed first open never reaches vfio_pci_core_disable(). */
>         vfio_pci_core_free_dev_regions(vdev);
>         vfio_pci_core_unmap_bars(vdev);
>         vfio_pci_free_excluded_ranges(vdev);
>         vfio_config_free(vdev);
>=20
> after the cxl open.
>=20
> > +                     }
> > +             }
> >       } else {
> >               vdev->msix_bar =3D 0xFF;
> >               vdev->has_dyn_msix =3D false; @@ -740,6 +767,7 @@ void
> > vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
> >       vdev->region =3D NULL; /* don't krealloc a freed pointer */
> >
> >       vfio_config_free(vdev);
> > +     vfio_pci_free_excluded_ranges(vdev);
>=20
> Order is wrong, should be reverse of setup order.  Also doesn't match the
> correct ordering used in the error unwind above.

I will fix this in v7.

>=20
> >
> >       for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> >               bar =3D i + PCI_STD_RESOURCES; @@ -1012,6 +1040,72 @@
> > static int msix_mmappable_cap(struct vfio_pci_core_device *vdev,
> >       return vfio_info_add_capability(caps, &header, sizeof(header));
> > }
> >
> > +/**
> > + * vfio_pci_core_add_excluded_range() - keep a BAR sub-range off
> > +direct access
>=20
> "Exclude a BAR sub-range from user access"

Okay, I will update wording.

>=20
> > + * @vdev: vfio PCI device being opened
> > + * @bar: BAR index, below PCI_STD_NUM_BARS
> > + * @start: offset of the range in @bar
> > + * @size: length of the range in bytes
> > + * @flags: VFIO_PCI_EXCLUDE_* paths the range is excluded from
> > + *
> > + * Call only while the device is being opened, from
> > + vfio_pci_core_enable() or
> > + * a provider's open hook; vfio_pci_core_disable() frees the ranges.
> > + Ranges on
> > + * one BAR must not overlap and must lie inside the BAR.
>=20
> Are we pushing an overly complicated model just to align with MSI-X?
>=20
> I think MSI-X is configured on open_device because it's trivial.  Just a =
couple
> config reads and extract the info.  Now it's becoming more complicated wi=
th
> allocations and lists, and I'm not sure why it doesn't at the same time m=
ove to
> the .init and .release callbacks instead.
>=20
> The AI comment also skips the important note reminding us that the exclud=
e
> list is lockless and must be immutable while the device is opened, wherev=
er we
> decide that boundary should be.
>=20

vfio-cxl knows its ranges at bind and the MSI-X table does not move.
So, for v7, I will build the list in .init and free it in .release.
The list then does not change while the device exists. I will update the co=
mment
accordingly.

> > + *
> > + * Return: 0 on success, -EINVAL for an invalid or overlapping range
> > +or one
> > + * that ends past the BAR, or -ENOMEM.
> > + */
> > +int vfio_pci_core_add_excluded_range(struct vfio_pci_core_device *vdev=
,
> int bar,
> > +                                  u64 start, u64 size, u32 flags) {
> > +     const u32 valid =3D VFIO_PCI_EXCLUDE_MMAP |
> VFIO_PCI_EXCLUDE_READ |
> > +                       VFIO_PCI_EXCLUDE_WRITE;
> > +     struct vfio_pci_excluded_range *range, *pos;
> > +     struct list_head *head;
> > +
> > +     if (bar < 0 || bar >=3D PCI_STD_NUM_BARS || !size ||
> > +         start + size < start || !flags || (flags & ~valid))
> > +             return -EINVAL;
> > +     if (start + size > pci_resource_len(vdev->pdev, bar))
> > +             return -EINVAL;
> > +
> > +     /* Keep the list sorted by start; find the first range after @sta=
rt. */
> > +     head =3D &vdev->excluded_ranges[bar];
> > +     list_for_each_entry(pos, head, entry) {
> > +             if (start < pos->start + pos->size && start + size > pos-=
>start)
> > +                     return -EINVAL;
> > +             if (pos->start > start)
> > +                     break;
> > +     }
> > +
> > +     range =3D kmalloc_obj(*range);
> > +     if (!range)
> > +             return -ENOMEM;
> > +
> > +     *range =3D (struct vfio_pci_excluded_range) {
> > +             .start =3D start,
> > +             .size =3D size,
> > +             .flags =3D flags,
> > +     };
> > +     list_add_tail(&range->entry, &pos->entry);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_add_excluded_range);
> > +
> > +static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device
> > +*vdev) {
> > +     struct vfio_pci_excluded_range *range, *tmp;
> > +
> > +     for (int bar =3D 0; bar < PCI_STD_NUM_BARS; bar++) {
> > +             list_for_each_entry_safe(range, tmp, &vdev->excluded_rang=
es[bar],
> > +                                      entry) {
> > +                     list_del(&range->entry);
> > +                     kfree(range);
> > +             }
> > +     }
> > +}
> > +
> >  int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vde=
v,
> >                                     unsigned int type, unsigned int sub=
type,
> >                                     const struct vfio_pci_regops *ops,
> > @@ -2317,6 +2411,8 @@ int vfio_pci_core_init_dev(struct vfio_device
> *core_vdev)
> >       INIT_LIST_HEAD(&vdev->dmabufs);
> >       init_rwsem(&vdev->memory_lock);
> >       xa_init(&vdev->ctx);
> > +     for (int bar =3D 0; bar < PCI_STD_NUM_BARS; bar++)
> > +             INIT_LIST_HEAD(&vdev->excluded_ranges[bar]);
> >
> >       ret =3D vfio_pci_core_cxl_init(vdev);
> >       if (ret)
> > @@ -2332,6 +2428,7 @@ void vfio_pci_core_release_dev(struct
> vfio_device *core_vdev)
> >               container_of(core_vdev, struct vfio_pci_core_device,
> > vdev);
> >
> >       vfio_pci_core_cxl_release(vdev);
> > +     vfio_pci_free_excluded_ranges(vdev);
> >
> >       mutex_destroy(&vdev->igate);
> >       mutex_destroy(&vdev->ioeventfds_lock);
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h
> > b/drivers/vfio/pci/vfio_pci_priv.h
> > index 4e7162234a2e..53544e0cbedf 100644
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -44,6 +44,14 @@ ssize_t vfio_pci_config_rw_single(struct
> > vfio_pci_core_device *vdev,  ssize_t vfio_pci_bar_rw(struct
> vfio_pci_core_device *vdev, char __user *buf,
> >                       size_t count, loff_t *ppos, bool iswrite);
> >
> > +/* A BAR sub-range kept off direct access; see
> > +vfio_pci_core_add_excluded_range() */ struct vfio_pci_excluded_range {
> > +     struct list_head        entry;
> > +     u64                     start;
> > +     u64                     size;
> > +     u32                     flags;
> > +};
>=20
> If we used struct range as a member here we could use range_contains() an=
d
> range_overlaps(), for finding a matching range below and avoiding conflic=
ts
> above (mind the inclusive end).

Noted. I will update this.

>=20
> > +
> >  #ifdef CONFIG_VFIO_PCI_VGA
> >  ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user=
 *buf,
> >                       size_t count, loff_t *ppos, bool iswrite); diff
> > --git a/drivers/vfio/pci/vfio_pci_rdwr.c
> > b/drivers/vfio/pci/vfio_pci_rdwr.c
> > index 7f14dd46de17..93823c6391f6 100644
> > --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> > +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> > @@ -198,6 +198,57 @@ ssize_t vfio_pci_core_do_io_rw(struct
> > vfio_pci_core_device *vdev, bool test_mem,  }
> > EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
> >
> > +/*
> > + * Access @count bytes of @bar at @pos, walking the BAR's excluded
> > +ranges in
> > + * order: a range excluded for this direction reads as -1 and drops
> > +writes,
> > + * and the bytes around it reach the device. The MSI-X table is one
> > +such
> > + * range, and a BAR can hold several, for example the MSI-X table and
> > +a CXL
> > + * HDM decoder block.
> > + */
> > +static ssize_t vfio_pci_bar_do_io_rw(struct vfio_pci_core_device *vdev=
,
> > +                                  int bar, bool test_mem, void __iomem=
 *io,
> > +                                  char __user *buf, loff_t pos,
> > +                                  size_t count, bool iswrite,
> > +                                  enum vfio_pci_io_width max_width) {
> > +     u32 want =3D iswrite ? VFIO_PCI_EXCLUDE_WRITE :
> VFIO_PCI_EXCLUDE_READ;
> > +     struct vfio_pci_excluded_range *range;
> > +     ssize_t done =3D 0;
> > +     ssize_t ret;
> > +
> > +     list_for_each_entry(range, &vdev->excluded_ranges[bar], entry) {
> > +             u64 end =3D range->start + range->size;
> > +             size_t chunk;
> > +
> > +             if (!(range->flags & want) || end <=3D pos)
> > +                     continue;
> > +             if (range->start >=3D pos + count)
> > +                     break;
> > +
> > +             /* Up to the end of this range; do_io_rw() fills it. */
> > +             chunk =3D min_t(u64, count, end - pos);
> > +             ret =3D vfio_pci_core_do_io_rw(vdev, test_mem, io, buf, p=
os, chunk,
> > +                                          range->start, end, iswrite,
> > +                                          max_width);
> > +             if (ret < 0)
> > +                     return done ?: ret;
> > +
> > +             done +=3D ret;
> > +             pos +=3D ret;
> > +             buf +=3D ret;
> > +             count -=3D ret;
> > +             if (!count)
> > +                     return done;
> > +     }
> > +
> > +     ret =3D vfio_pci_core_do_io_rw(vdev, test_mem, io, buf, pos, coun=
t, 0, 0,
> > +                                  iswrite, max_width);
> > +     if (ret < 0)
> > +             return done ?: ret;
> > +
> > +     return done + ret;
> > +}
>=20
> This is mixing fault semantics.  Currently on fault we return the errno,
> regardless of work that's been done.  With this, we potentially return a =
short
> read/write on fault if later errors occur.  That short return is not nece=
ssarily
> representative of the length of the actual operation, a partial operation=
 in the
> last call to core_do_io_rw is discarded.
>=20
> Therefore, I think both of the above (ret < 0) return branches should jus=
t
> return ret, not the potentially incorrect done value.
>=20

Okay, I will update this.

>=20
> > +
> >  ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user=
 *buf,
> >                       size_t count, loff_t *ppos, bool iswrite)  { @@
> > -256,13 +307,15 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device
> *vdev, char __user *buf,
> >               }
> >       }
> >
> > -     if (bar =3D=3D vdev->msix_bar) {
> > -             x_start =3D vdev->msix_offset;
> > -             x_end =3D vdev->msix_offset + vdev->msix_size;
> > -     }
> > -
> > -     done =3D vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM=
,
> io, buf, pos,
> > -                                   count, x_start, x_end, iswrite, max=
_width);
> > +     if (bar =3D=3D PCI_ROM_RESOURCE)
> > +             done =3D vfio_pci_core_do_io_rw(vdev, res->flags &
> IORESOURCE_MEM,
> > +                                           io, buf, pos, count, x_star=
t,
> > +                                           x_end, iswrite, max_width);
> > +     else
> > +             done =3D vfio_pci_bar_do_io_rw(vdev, bar,
> > +                                          res->flags & IORESOURCE_MEM,=
 io,
> > +                                          buf, pos, count, iswrite,
> > +                                          max_width);
>=20
> Seems like the wrong refactor to add a ROM specific branch, we should
> probably instead precede the excluded range loop by a test for a standard=
 BAR
> and non-empty excluded range list.  That might mean the new function is
> reduced to only the excluded range handling and all non-excluded range
> handling falls through to a common call to the core function.

Okay, for v7, only a standard BAR with ranges walks the list; everything
else falls through to the one vfio_pci_core_do_io_rw() call.

>=20
> >
> >       if (done >=3D 0)
> >               *ppos +=3D done;
> > diff --git a/include/linux/vfio_pci_core.h
> > b/include/linux/vfio_pci_core.h index 7f3a2bcb5830..70acb03d466e
> > 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -162,6 +162,13 @@ struct vfio_pci_core_device {
> >       struct notifier_block   nb;
> >       struct rw_semaphore     memory_lock;
> >       struct list_head        dmabufs;
> > +     /*
> > +      * Excluded BAR sub-ranges, one list per BAR, sorted by start and=
 not
> > +      * overlapping. The lists are filled only while the device is bei=
ng
> > +      * opened and emptied in vfio_pci_core_disable(); every reader ru=
ns on
> > +      * an open device in between, so readers take no lock.
> > +      */
>=20
> I'll stop noting these, but I expect all gratuitous AI comments to be rem=
oved
> by default and evaluated as a human whether a comment is warranted.  AI
> assistance doesn't relieve authors of the responsibility to perform a tho=
rough
> human self review.  /dismount-soapbox Thanks,

Agreed. Sorry for this churn. For v7, I will recheck all the comments in th=
e patches
before posting.

Thanks,
Manish

>=20
> Alex
>=20
> > +     struct list_head        excluded_ranges[PCI_STD_NUM_BARS];
> >  };
> >
> >  enum vfio_pci_io_width {
> > @@ -172,6 +179,19 @@ enum vfio_pci_io_width {  };
> >
> >  /* Will be exported for vfio pci drivers usage */
> > +/*
> > + * A provider can keep a BAR sub-range off the direct guest path,
> > +reached only
> > + * through its own trap. The flags select which paths are excluded:
> > +mmap, and
> > + * region read and write (an excluded read fills -1, an excluded
> > +write is
> > + * dropped).
> > + */
> > +#define VFIO_PCI_EXCLUDE_MMAP        BIT(0)
> > +#define VFIO_PCI_EXCLUDE_READ        BIT(1)
> > +#define VFIO_PCI_EXCLUDE_WRITE       BIT(2)
> > +
> > +int vfio_pci_core_add_excluded_range(struct vfio_pci_core_device *vdev=
,
> int bar,
> > +                                  u64 start, u64 size, u32 flags);
> > +
> >  int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vde=
v,
> >                                     unsigned int type, unsigned int sub=
type,
> >                                     const struct vfio_pci_regops *ops,

