Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792828293;
	b=GFUHHV1wtryx4R8KiCAyt78g+gF8kOVE3mKzGnQaRm1/yu29FuYC8k77V0lagiyJFMUT
	 Cjx8FoXWF9PjIsmM+ZlA6RPZTR41SSRtdh3xcjXQLBY8Sctfjpm6y1u/UtGk5LpjpvaCX
	 9EFOw/PoD3ybbCRQuuKJRug57frDWfNYkwCOcLVbUgA+t8x+BvzFZW/CAeHpT0rgH1aoP
	 w8fE6+Yf+S3X2HxutZh8XOxm/DZHtdSduwU91F88PHgZDWRTBFY3oY4N+kquXagvQoTV9
	 uqQuyVroo/o/xBE98V4jDffGGmCuXSoGDu77bzJZjz5Hv1CxRPI5yzPtRI2PEHzF4YQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792828293;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=0wO4TfyyuhjMlaVUlMbS59xyRaaHgcMte8HcGuTejlc=;
	b=1h5i9LVTbBcsh5nCdJwGQ6LqYbFFBs7WD2lITGNouObgOrfJu3vmG3RNdGC42ItWNB0+
	 U8mfRajJmoJV7ROJ/KZ3tXNJxRZIytA4xE1zEYH2v0IBvVkjK1i2fkG+OSRzkkgOfAocy
	 IvU+ZemsdGvMv63090zBw5Htz0KGdehA+oXBktaUk1LpCNix1FECTetJXYs8sy8KRij5J
	 tPSxxw8ApLGT8SpEjjyRPEj3IiFBrfZc8wdlMNKXPlSNyd7Zf9dKBx96XL8c+YUYaZFaL
	 2B099Qvyv5Ik/eGYQybshNTeDuauxq0WbZzNnXQhl6wLESzxV+9R6r7uDqauZ0PjLGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jnWGPjqI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.41
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B7D606A31A;
	Sat, 24 Oct 2026 07:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12B7D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jnWGPjqI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQjPy/RZyvhuxRFF510TsAwfOpwhoEsIB8pz4Cqyk4VCCXnps7C1crpfYKFNQGj6ZniGDzpxEg0DE1+Qr7M+VYKir0DpSVvCnlIx0lYLkJmsGnnCzOn0Zbk9ygX0lzA7QZNzedXs503ygvgI+BYjLBHPLr0mbeD7JNvuTcVYlZlfGZPV2WebXWIHhzWQen3Zqesy/4626fxg2NR/erEtPwxF+V8oevuOq/0/wZ6FO9oW5x4YKFlA07ROO8vnvYmgpJl85MEHIrpmnm/FcKRBq3Qm9m1J057p7l8vhXUPcPx2Y5D1XqVbgBXmvo8x0jSsuRfGWk7kLVTm5oCssg93YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wO4TfyyuhjMlaVUlMbS59xyRaaHgcMte8HcGuTejlc=;
 b=ink2HQF0BH5+6/BR5e3Wgkwj5tsEPiGv5dheybObLU9OTUds8wvsb/Ja29wgXHfxITVhKr/OzYVXm6I7jHv/wW93hhD6vLOL9Rfa4y877njc64j6OCqBxdttqZX1B7o7rE35U5YkX5f63lnf4zY+yeXMvvNWwaPrzYhU1iMI3KsW45IuYPmsK/HVOn9kxzWFYT2P7qimeSTkOySO4MXkY/s1Xzvi5n7d7U8j6Cu9Mfyvc911w+V/liueRsXJGcaKCk1kEtH0izN8x8GSDDTNtp+XqY7JrQnaFC/o8uOOJBzG/HxKG4azDvwoEiwQYmDWrxq/HoeABFO2oXV7xEw6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wO4TfyyuhjMlaVUlMbS59xyRaaHgcMte8HcGuTejlc=;
 b=jnWGPjqITp50pkWCqt9xQfYeICT72mVTY67uKodODVb+cpIUlw5lo+SUJ9q3zdZQM7C+IbRMzPtzJfPCozI1s7BQ9x1jucjszDy++781+qaa5VWs8H6IoOo/vbBh+zIG9CQuzaAv008zitDHY4PjxuqokWNEfWTCOyK7sIuiyULGUmChbDKh09R1xtxz3Dco4PEpfGc4hOCRw4g/2LIxG3jbM0hgqSjLd80l27hgphxGczU+O09U3gIy0jKhTdEJr74sfoaQuz/yOCbm+zrIbP5Oww7cPpTB2pfWJyNxd85HBn+7X7qu/ABEPoyZIL4BYLDtrVbnpqzAV5GLV4dO1w==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by PH7PR12MB7844.namprd12.prod.outlook.com
 (2603:10b6:510:27b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Sat, 24 Oct
 2026 07:51:28 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0546.017; Sat, 24 Oct 2026
 07:51:27 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jic23@kernel.org"
	<jic23@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"aik@amd.com" <aik@amd.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "iweiny@kernel.org" <iweiny@kernel.org>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>, "bhelgaas@google.com" <bhelgaas@google.com>, Srirangan
 Madhavan <smadhavan@nvidia.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 2/4] PCI/CXL: Populate and insert/remove
 pdev->coh_resource[]
Thread-Topic: [RFC PATCH 2/4] PCI/CXL: Populate and insert/remove
 pdev->coh_resource[]
Thread-Index: AQHdVJenWGflQInJnUi4i9OPVn0EsbbyensAgBO2Ah6AA+2lgIACT7Ni
Date: Sat, 24 Oct 2026 07:51:27 +0000
Message-ID:
 <SAWPR12MB999267AEE0F2548D21B71D30AAB0632@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-3-ankita@nvidia.com>
 <bf41f28d-5fb0-4b10-b2f2-3c7dcefdda57@amd.com>
 <SAWPR12MB999267EF0CA5F3E284C1BC8A89B0672@SAWPR12MB999267.namprd12.prod.outlook.com>
 <a51baa2d-1a2e-45f6-a862-d82b4b5a3f3e@amd.com>
In-Reply-To: <a51baa2d-1a2e-45f6-a862-d82b4b5a3f3e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|PH7PR12MB7844:EE_
x-ms-office365-filtering-correlation-id: 4099056d-09a4-47a2-d5a1-08df31a39c19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|261009223027099003|261022105027099003|261021121427099003|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 IljQI6yy1+PG7drd40RqJq9zm+c/vZY4YkWdtgSkLBGacuJ5xtZgjxYQ9A5zbZa/wzZ7RLsDe8BzYfChHxccX8XycTeTofxaRoxl7ckTCl7Np/Z561WKnWxHu6fZQANCdwG6aZ9Mlsde/kotacHEQnmgftgAWy3IaFB8U1vcGiBq0hlJ6MRa4JLAuOIXx0VrPqmC9ROTp9u9d3qlW4szjl49UTDrZ+tsXldG1NKEiVIa9jzF6x090l7Xo8ssy+QPs9/3I9eJmQggOI31fDdOhv2KG47LOhuJDAmP9QJQxeZ2Rtbt6Di6hvkws+aY/gnfNaxDeDKxG5EugZdl+NIfqWw4+JbHkFcZsn1Mi5zsAoH+Cnui1fxCPThfQFcpJT6+mEx5ygl3aoGlLD7yvsUDSQU5Bs1EPm1FuWrW21fDELDavnzpZRKwUgAWA1EGkjKBsj3VtNw8yfl4GbZYPkxsSUQ1CxztY07yRL3okHf1ihCHQWBDtLYKKW3ZG54ib4MGjrXbFiH+gXyd8T4np4YYJFh37IqKvvoghDdlIp2lQvbz0zukGEg9j/R3M1d4TemIYsBlIh1P7ZYOtHZ4O24a0anWI548j1vJ95nFsyy17/qLO5/GPpMhZ2BoQMd3j2hBeB7wGaMiqqzyjtpc/8k/pF4Nl0LmPSy7e8eFes4PV9RLuQVLjxX6HMstiG87F1YAafNpHdxI4i+/2Q5A+5jJ9W3jGFST7RxCnd78VsuGL8Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CEzSi76RYF85ny1RKft78bTjMllC5KfM1zqdCIfOWAf8zMrypyz0amn6yW?=
 =?iso-8859-1?Q?mERPWpHFnLs6ht/25etsZqBYiWnvpLqe9EI1EhaWgMPJ1P1euukf463pia?=
 =?iso-8859-1?Q?mKf9U7FPtMpP2X45xKsggNXTfV0yodAC7TqDOx3DG816OjNT5QwOFOGvBl?=
 =?iso-8859-1?Q?OwIENtcUXzlyD1CgvSwLfhDSsdL7QkGzj5+d4fqgsLr4oXUZXm98Zr5rtF?=
 =?iso-8859-1?Q?QNQXsz4P2HjUuwT3XDqvUpuGOP2+KuAvUA5h5cRjbyp0FAfUiHzjhVBota?=
 =?iso-8859-1?Q?4hQR7KjWhQb8f7D1KFgDIe4FvXGR7+EBiMAxGKsqbf5AHwXP9RbJCgVbTT?=
 =?iso-8859-1?Q?MWhQhfyLL01t0CYPsZWYJzvp4zhbyw0KVIbkRxTxDggowic9F1Etx7FJNn?=
 =?iso-8859-1?Q?YBeHJsWtsmgS02gfikPn6FpKpLFCEiWMdT4Bq/gInoR+AHZ7DQ/x3FIi6p?=
 =?iso-8859-1?Q?HB5IGT1y/5FslTA1Vyu0vErhYTscsVoIAkjV0CDGQqQg+cbaEr8yNedqXT?=
 =?iso-8859-1?Q?YXRTcMSFV2qKN6MPSqLuGTBc5Lg031gRYHdGBpOBktwXKGwmXuJGnvMt5G?=
 =?iso-8859-1?Q?zUEzWavuGKKVKNCrAoMLzW7AI+DU/e2E4B8XszCilLCLItlV04dcnntBcf?=
 =?iso-8859-1?Q?tKjcVYhb/852st8aJKsSvaJKRY+zgl1IDNqgjqVno+r4KfogDp3EYoSnyW?=
 =?iso-8859-1?Q?wkZP1ctrNT9c2Dm6JiIKLnzNZSq9DYpDPh4NwEjsJ4vEQDE82JrGvNbynF?=
 =?iso-8859-1?Q?h/hFHHFL1ypfpuGHdj+uLHwP1Uf5aQ1EOcg94wykBRM3/9xtzfcV8QC5aa?=
 =?iso-8859-1?Q?orTO4vVQY642Pj3EDvZd63zpdN4+oqJ4+QCUtZXjSR7pDfCTsh2Ik9Ntbl?=
 =?iso-8859-1?Q?ym5n+e3gIjrle0jFYiUH4yGZYG1jCvi4l+QmBd7j4G7LlmSKK4x86cKEvY?=
 =?iso-8859-1?Q?pG6V/JU3zRZSxwSd7/zerN5o/lOE7JWqUBf1SSY6PDSzVDZ2rO3h4EVGyU?=
 =?iso-8859-1?Q?LHqpmoiLrcKJwkCs5L2Ky/tN7eFd2fbNwpGmHZ40z8notDyORJw4mi6FTT?=
 =?iso-8859-1?Q?90Zwn0GU0krGuK5D5GOgU/OadsiDUPf7KTSDhPlnMKQMy16IZecjZGcErw?=
 =?iso-8859-1?Q?9LnNBJQNYXhVu0TTB+3HY6/TqN1Q3TB/JQyeJanbAxNZhgm/rfZImmUS8l?=
 =?iso-8859-1?Q?fxZ1nB+iYASmB1J5hDZEP25VMf8K5za/yyQBahKa68A64lKPIAplXJ53tG?=
 =?iso-8859-1?Q?W2rzGsZgOAbJaU4oGVoOgcl3P1rsCxBmoUN7/jr2IRqm7GRKGRn2GT6mur?=
 =?iso-8859-1?Q?6BxRelELk/AVUFW1COd23yAwX+0dQI758b+nw4Qw+xUuKZBjWptPuTXudj?=
 =?iso-8859-1?Q?9Wxsz/PAUEHxA1VpdesyhfKMxeaUcozliUvT9hqSfPpdXqcvPgxK8ZGsq1?=
 =?iso-8859-1?Q?dC9bgrxmvrD3iX3b01T8Hra6ocPCVaFeu5Uho5LGxLmNW5QqezsGxKFvmr?=
 =?iso-8859-1?Q?T8d4kaFVoNgiwA2BV5are+FYj9grD1dbZHBLSfbz9exBhoEDvCjWEYNNHv?=
 =?iso-8859-1?Q?zUkkI4BeL2V3Rb76v7B28v+dwTWZAIxLz2gAVFoyH/Ika+4J671OfjL0Zx?=
 =?iso-8859-1?Q?5BaA4lg7nsdoG3t+iFZ6pm8h7y/1oQ9gaswlGN7fJsx5AcKFlmd7DeuwdZ?=
 =?iso-8859-1?Q?A+PgdkxbMDOI5z78OaBrRZ7vHR9nrGVqZ6Pyw0SbECQ1G4hYLBtkAUadK9?=
 =?iso-8859-1?Q?DSTzToGdlXgMWHdhtbltev6Vl4JrRTKfOSfoXzVjizGqSd?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4099056d-09a4-47a2-d5a1-08df31a39c19
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2026 07:51:27.7621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUZhqe54bYULwS0q+y8g0iLOoK6l9itfvjeyw76FQ2EE0S9/l2XnkcjsJeUUUXJADBzIeA9hi0BazsCGzqrBLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844

>>>> +=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *res =3D DEFINE_RES_NAMED_DESC(c=
onfig->hpa_range.start,=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 range_len(&config->h=
pa_range),=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "CXL coherent memory=
",=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IORESOURCE_MEM, IORE=
S_DESC_NONE);=0A=
>>>> +=0A=
>>>=0A=
>>> On platforms using Normalized Addressing the Endpoint decoders contain =
DPA ranges. This =0A=
>>> patch will then record DPA ranges as a result. Translating this require=
s call to prm_cxl_dpa_spa() ?=0A=
>>> The challenge is the PRM in drivers/cxl/core/atl.c may not be initializ=
ed this early.=0A=
>>>=0A=
>> =0A=
>> Yeah, good point. On the platforms that I used, the HDM are precommitted=
=0A=
>> and have HPA. But I agree, the snapshot must not silently record a DPA.=
=0A=
>> =0A=
>> Is there an existing way to tell at this point that the endpoint decoder=
 is=0A=
>> DPA-based? If yes, I intend to fail close with coh_resource[] left unpop=
ulated=0A=
>> Or would you prefer populating lazily until translations are available?=
=0A=
>> =0A=
>=0A=
> Hi Ankit,=0A=
>=0A=
> For an example, normalized decoding is detected in core/atl.c:cxl_prm_set=
up_root(). Of course=0A=
> this runs much later after cxl_core is loaded. Normalized decoder targets=
 have the following at =0A=
> the Endpoint HDM target entries:=0A=
> (hpa_range.start =3D=3D cxled->dpa_res->start)=0A=
=0A=
Thanks Terry for the suggestion. Should we be using=0A=
CXL_DECODER_F_NORMALIZED_ADDRESSING (set in the cxl_prm_setup_root)=0A=
instead of the hpa_range.start =3D=3D cxled->dpa_res->start check?=0A=
=0A=
>-Terry=0A=
=0A=
=0A=
