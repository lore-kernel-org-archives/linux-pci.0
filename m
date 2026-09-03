Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7D486E7D;
	Thu,  3 Sep 2026 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430505; cv=fail; b=gJExCCmaD5XUc2flK7GPhNyudi+BNmDk4JwxaWkBHk4QxOlao5s93oKk81KnCVkuDq1gbtUYd3UHklBpejhik5/M5XUaVcvy7ostNTYFqd26F0O4AcvgudAUSD1O6WKvFaY7Guc0bB8vzjIQp2O8/bv7k/14FC9WEanFs/meqfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430505; c=relaxed/simple;
	bh=CWxY2x7/gz+v0QLT+kaFpiouHwyNEQ3bZGZv2fpNeDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cGshsReC+ukgTLp3p31EqGPz7JsKiVYKa+GBXwUOF78zHpnf/8oCkFKs23LwJi0hJ3G/v1y3FDCjjfObXc+CULcK0lPr7ROfaUmXw5OIZucVgKIgIyKbUJTyWRXcm01VKhYHOSa0hYcHx6ISYuFcsYqHMqvyF7yLzEyxAvtUCEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PNF5cXaU; arc=fail smtp.client-ip=40.107.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PNF5cXaU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bknCRSFxM/XCa1PC7tSU5uapJlVsLqhTadq4B7N6AjuJnFPZfE4y0iRmGv2T0vhpkGag9TMOK0Bq7NytT0cIIAwoDSfaxnbqWi5kS19KJuV04NW5vilO8JuNdU8eW8xts4wqZfXl8CkS43AK+AFHfMQDcrAAi4CN/fJLwHJ0DHKlCzhdI2QDsB8VQZFPHgKVZ6KkD53KTytDQ+wfDNeJ/G77si9aS+Ct+g2vUTtWaiaPD7z701MLgJ9b2DDf8OwCc4rzCtuZBXDeRUk+wtgL0Lo0VE7mDQWSEwf2ejWEjGb9mmJurMb0e3VbQ6VLL5ID7CHqgZh3nnuOMzCe6Wk1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mw2J0uI8oyrke08bQfmNP3gDCg4OTGBanQrrFqsyO44=;
 b=QjyoV/Vlk8/eTxg+DqpkfgHt5Kj3CnhUC9I9HJ+FRLswlBBCbUzrz1PY2fA4wAj7JzWrg6+4SCh+aM5Y1KIJ+vjj3VZEfqtTUNPK2xYkxqNxX8rIOKAuoGsDuf3pVm31BiGHUj3KRHR/oODBJNBk/wNgSKnY5dsnAjUwIjwDkHvshvnPeqqKFyYQN7OVv+Q7WnowBQXFA691o0sS/6jvJ9uOeFpHO+NgSg7ZEauvbJ2M5fbjArm+izYonGO51d4HjKJRcOVQCIITZRgu80kTLoIFylzHvMB+gFYa8iTBtyKzzTd1EzS+ABURKWTMykF8Lie2GBoq/yGQYv4gxET27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw2J0uI8oyrke08bQfmNP3gDCg4OTGBanQrrFqsyO44=;
 b=PNF5cXaUvwm0BYPqW9x7WOem/6vvM5/1+01Qg2m7d3HNn2CdAnI+izOJC8/eJ/BbLIGhE4GskkxW23dBz4rWmkkh3v05WtHwqC3RQm+tj3sjtra3r28olqN/p2UzCUGduk4iOpCPen54Bx6ys1EjarXlHQf1I19RVujg3JRT0JDm7riV9TOQMjdq8jjUAssemjZyk9fgt0/mD52ycurVzm6ZpuRPrvpHR/zzbCAuBc709zaSd+7eRmmlmrTvxBBGUjoU/tEy1ku/ohFWdWmPoFOZoNMMZG22cI7h4KDF/1czHrKTw9Uav8M8tl4WyVEBEE/kHpvDuOA+PpdV/8CMPg==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:14:47 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:14:47 +0000
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
Subject: RE: [PATCH v4 18/27] vfio/cxl: Expose the HDM memory and trap the
 decoder registers
Thread-Topic: [PATCH v4 18/27] vfio/cxl: Expose the HDM memory and trap the
 decoder registers
Thread-Index: AQHdKwfGFEYET3U/sUKPm5veAjolMba0CJmAgAilPeA=
Date: Thu, 3 Sep 2026 10:14:46 +0000
Message-ID:
 <IA1PR12MB9030A278CC1576F61F944181BDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-19-mhonap@nvidia.com>
 <20260828145351.56f74a1d@shazbot.org>
In-Reply-To: <20260828145351.56f74a1d@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|LV8PR12MB9405:EE_
x-ms-office365-filtering-correlation-id: bddd3271-7a76-45e2-c47c-08df09a42e84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|3023799007|6133799003|11063799006|56012099006|4143699003|5023799004|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 AK66oSFJP15NV0kk9BxNAV5+E0nLub0qQizBXyLuluqQTtowp6OiFy6byocImma3+yz8Bh4s6F1gDvF3cB3n1yE8Vg54gyyQiVVGA3kKPbzPCuxTm+sWc135Ih0NVjUhQVN8DDJ2jLpKk9r6m/xcGOhMS35MztdPJr/juI+4EN4lWqfFNMpHKvKj44aKrFViOq3lnLQzHMZGbJ0h9VTG+VlPWyd55SncM4wn87NQ3NzDz/EodUXvMtabWmc41Lurr5jp1rri7V3Kjo1phq9KeAtLCIhMGDekvn+BnoqcalPkT13gCZnrqYMoDX2OLVb7SrAjRPkIaV0yIyTOm78nGkIAXNyIqa4nDXowdFLUa3lvO85SdgqdUi2OO4CEVLzWfj24Zle+KGySfpNm2nTg8GyUdcEEu1W4MvsXvkx7vuGXONcSvmiHVwV8eFAcueX1YsDAXxsGFCjnJGODqh3TLMxt4ckKU44IAHJWOuKrWZAbpQMJR/1GMidosBdoxKbz1/0cras09ZHKtoAIs0UplqWBsp+7p/iif8OiCLysebtQF10Y/OxhQpV48j5lEC5jZkgm8BRUedcHvaFJFMZ+DgpgOEPQf2HWZMZKJICG0j+CMtSXmbs8O/9dW43gBgS1OmkkQhLlHLg0YAQlzYF98oVo3ozPqgJlw6VRwViTHRCxEzcQeRJoRJ5hjbCmgSFofFBXA5YQu2OYWQQ3bSZppTlMtSxk46t1QzT8qmYkOmw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(3023799007)(6133799003)(11063799006)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pkeK3o1D42UlO8WUoajcpJ/gm6b4s3Ss1j0BAIFCo0bFFOKSWMU5t8MrBml/?=
 =?us-ascii?Q?P/KOGfViXekc8poJ96NMj8Tzm7h5CmoTadIilL1uRf9VOXGzUyFxJ3gLy8zO?=
 =?us-ascii?Q?S2MeuCRU/OQHUPbFfw2RgH1qwX/AVUZkqN2rQRl+kO6Jjm3e/eP+9L3U0eKY?=
 =?us-ascii?Q?BuREvKKf1U2x+fwCkh2Cin35oFcIXxZGAc79SoRtngAAlchcP8PMj/pyBBSc?=
 =?us-ascii?Q?/8sBo8Kluwst63QzvvMnxmpdNvL2Z5RzYOZiK71gZfNu14btX+wmTMus0RPA?=
 =?us-ascii?Q?MEfuKUmEOOBYbG2CdZLD6c8xHCZgVUYfGR64VOK8Cu1RMePS8Hu0uHt0kKzN?=
 =?us-ascii?Q?lsH6E+lK4ZzpC+7oJ9Yeb2TBokFMC5eObpe3BnNJ/mYD+hTTKBlSE/SVI7Qe?=
 =?us-ascii?Q?lIDvjCSzCGAHT1eE8Qf9gSAtLeS2Cf56tRItxNJnCLyqNLIpW6ezwrWmc8Sd?=
 =?us-ascii?Q?EnL29ihz+Ub+MJbgbRhSjlkgzJEER7toyn+xJJ6JToZqjQHIXbxrHk8BcReF?=
 =?us-ascii?Q?NsPizcjtGanYqcfifXVxBDqvvgHSxz/ClPABd2KoZhmisIRKm5Z6foDnPuWn?=
 =?us-ascii?Q?EFr/AF790k9OO29u27mon6L9D/sD37U9F/+T7UXwHO8qEQiuLbRqp+w6tqLD?=
 =?us-ascii?Q?TlfU2bjCZo1i+3L7XSjRfS3wFqypDGiE63WZtJxj3UhtT21bCN/7m3rZTodA?=
 =?us-ascii?Q?U4M3Zkc+4PWHXVo6lOmd8vk7H6u7SuCUcXFUoyrhrNlXCxjobgqk00/Qye+3?=
 =?us-ascii?Q?FZ2UfCvSXA1CdZbD8vM58wMrdh32TrbhKk7euRKBIE2TP777wj0mhJjwL/hx?=
 =?us-ascii?Q?dl+aC7KrvSmJ7HhH+bCSJeghdnmPuUDEVJbOmnJdSBQw7fNU3+m7WXb1YAMp?=
 =?us-ascii?Q?5JFcv5c0aRSy+9C4xpxWUwVzLv4B/4YkyDiLy1vW4dhIqcOqK/y54H3hph7/?=
 =?us-ascii?Q?ahmF2vXQ0isz5JpXNUnlUFzLSFH7Jj05G6FdQD8jA5YWgOXDo2R41Yz3Z5ha?=
 =?us-ascii?Q?xpBSi/HzbWbh1To/PratlHpoJprVnAjRAmsiU6cWDkff4YUF6YprjIDbm+JG?=
 =?us-ascii?Q?5xvBjOsOyhiBelK79BgmAWkjqgMXrg6NPOqT/60koVqfU9mC6iTmsn8xk3cB?=
 =?us-ascii?Q?THpeI0p7Ep7f6T/U6fCgJ5ocYCsAPE/3ew+2Irjv2AVojsXvyr1U4HQitcu9?=
 =?us-ascii?Q?mGwMsw+TCOEW/lgbnSUrikNlgQGvdxE2EV7nmtuKiv0KJ5ViWooCfymOaeFF?=
 =?us-ascii?Q?GqZCo9dIW72QlYNPH1oJvNz+PKmexQ9KRZuiWhjTn/6V2eU4J6MXkwLRUoI9?=
 =?us-ascii?Q?NemOM8tn3mRnY2u0BZaMlsFCRX2kZHNBcOvgt+cd5gjcWy8ZbRfV7UROLNeq?=
 =?us-ascii?Q?yhLRa87bLMUEokwTzOd+WX5DS4sPjQPnQkVB7O5qYmD+n5aeqAlmjP6er26g?=
 =?us-ascii?Q?geoKkqkw6In4Fe+H7WiVM7GuhFERFgi2MO+FQk3pdn6/updruAYfQq8yz+Ck?=
 =?us-ascii?Q?j19oVtVXpWkPvGe/A5HA+jp6KwxjUxg27iex5stYE/QUeeqE/V0ByiXnnas1?=
 =?us-ascii?Q?hYNKxwW4p4W/XWD4ne3byFfuCmQZNPX1FXctlQBOmDtKAltjLCKHETmSL8Or?=
 =?us-ascii?Q?nBywsfU3dgW8LXY/EcGCJZXPJSWURH+89L2T6Me9Q+29mNzPeQ34EFKqFJec?=
 =?us-ascii?Q?kHc3eAxBxBezlXh2LLZ5LJiLiluzQKvtR7jNT5mFQW4FuPNR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bddd3271-7a76-45e2-c47c-08df09a42e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:14:46.9583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ox3MELHtfbAzTc1Lmk/smjy7WfgC/k/Nd4fSmGBNQUJYJcW4NcdXZy/SxeNOtLCkDRrmaZh8slj4w0qg1UImQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Saturday, August 29, 2026 2:24 AM
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
> Subject: Re: [PATCH v4 18/27] vfio/cxl: Expose the HDM memory and trap th=
e
> decoder registers
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:22 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > Register the HDM region as a CXL VFIO region so the guest can map the
> > device memory.
>=20
> s/VFIO region/VFIO device specific region/
>=20
> > CXL.mem is coherent memory, so the guest and KVM need a write-back
> > mapping. Claim the host physical range exclusively at bind so a
> > firmware-owned cacheable alias cannot fault the host once the range is
> > mapped write-back.
>=20
> I'm not fully following this, claiming it exclusively means no other driv=
er can
> claim it, but is a "firmware-owned cacheable alias"
> generated via another driver or via a side-channel?
>=20
> > The region is advertised mmap-able, so a fd holder can fault its
> > struct-page-less device memory in from the host CPU. A memory error on
> > that range would otherwise escalate to a host SError. Register the
> > range with memory_failure() via register_pfn_address_space() so such
> > an error is contained to unmapping the range and a SIGBUS to the fd hol=
der.
> > register_pfn_address_space() returns -EOPNOTSUPP when
> > CONFIG_MEMORY_FAILURE is off, in which case the region is exposed
> > without containment.
>=20
> The error containment looks like it could be compartmentalized into anoth=
er
> patch in the series.
>=20
> > A CXL Type-2 guest also reads the HDM decoder registers to learn the
> > HDM region it was handed. Those registers live in the component BAR
> > that vfio-pci owns, so map the decoder block at bind and copy it into
> > a per-open shadow, then expose a read-only region backed by that shadow=
.
> > The block location comes from the pdev->hdm enumeration cache rather
> > than the CXL core register map.
>=20
> This also looks like a separate patch.  Why do we need a static copy of i=
t rather
> than just providing read-only access to the live copy (avoid the later re=
fresh,
> gate on device state)?  Why does it need to be a separate device specific=
 region
> rather than a read-only section of the BAR?  Is it just that we don't hav=
e a way
> to express that through the vfio uAPI? Could it support read-only mmap?
>=20
> > The guest programs a GPA into the decoder while the host resolves the
> > HPA, so it must never reach the physical registers. Serving reads from
> > the shadow keeps the two apart; write emulation follows in a later
> > change.
>=20
> This seems to be talking about some virtualization implemented in the VMM=
,
> nothing here virtualizes decoder programming.  The comp-regs region is re=
ad-
> only.
>=20
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 347 ++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_core.c     |  17 ++
> >  include/linux/vfio_pci_core.h        |   1 +
> >  include/uapi/linux/vfio.h            |   3 +
> >  4 files changed, 367 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index 9fed909cb9d3..07047646edde 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -5,10 +5,14 @@
> >   * Copyright (c) 2026 NVIDIA Corporation & Affiliates
> >   */
> >
> > +#include <linux/cleanup.h>
> > +#include <linux/memory-failure.h>
> > +#include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include <linux/range.h>
> >  #include <linux/slab.h>
> > +#include <linux/uaccess.h>
> >  #include <linux/vfio_pci_core.h>
> >  #include <cxl/cxl.h>
> >  #include <cxl/pci.h>
> > @@ -18,21 +22,250 @@
> >   * @cxlds: CXL device state; kept first for devm_cxl_dev_state_create(=
)
> >   * @cxlmd: memory device joined to the CXL topology at bind
> >   * @hpa_range: host physical range of the HDM region
> > + * @dpa_pfn_space: HDM-region pfn range registered with
> > + memory_failure()
> >   * @dvsec: CXL device DVSEC config-space offset
> >   * @dvsec_len: length of the DVSEC body
> >   * @dvsec_dwords: dword count of @dvsec_shadow
> >   * @dvsec_shadow: guest view of the CXL DVSEC body, sampled at open
> > + * @hdm_regs: mapped HDM decoder registers, source for the open-time
> > + snapshot
> > + * @hdm_len: length of the HDM decoder register block
> > + * @hdm_shadow: guest view of the HDM decoder registers, sampled at
> > + open
> > + * @hdm_region_idx: vdev->region[] index of the HDM region
> > + * @hdm_valid: true when the decoder is in a known-good restored state
> and host
> > + *          CPU access to the HDM range is safe; gated under memory_lo=
ck
> >   */
> >  struct vfio_cxl_state {
> >       struct cxl_dev_state cxlds;
> >       struct cxl_memdev *cxlmd;
> >       struct range hpa_range;
> > +     struct pfn_address_space dpa_pfn_space;
> >       u16 dvsec;
> >       u32 dvsec_len;
> >       u32 dvsec_dwords;
> > +
> >       u32 *dvsec_shadow __counted_by_ptr(dvsec_dwords);
> > +     void __iomem *hdm_regs;
> > +     u32 hdm_len;
> > +     u32 hdm_dwords;
> > +
> > +     __le32 *hdm_shadow __counted_by_ptr(hdm_dwords);
> > +     int hdm_region_idx;
> > +     bool hdm_valid;
> > +};
> > +
> > +static unsigned long vfio_cxl_mem_pgoff(struct vm_area_struct *vma,
> > +                                     unsigned long addr) {
> > +     unsigned long mask =3D (1U << (VFIO_PCI_OFFSET_SHIFT -
> > +PAGE_SHIFT)) - 1;
> > +
> > +     return (vma->vm_pgoff & mask) + ((addr - vma->vm_start) >>
> > +PAGE_SHIFT); }
> > +
> > +static vm_fault_t vfio_cxl_mem_huge_fault(struct vm_fault *vmf,
> > +                                       unsigned int order) {
> > +     struct vm_area_struct *vma =3D vmf->vma;
> > +     struct vfio_pci_core_device *vdev =3D vma->vm_private_data;
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     unsigned long addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << orde=
r);
> > +     unsigned long pfn =3D PHYS_PFN(cxl->hpa_range.start) +
> > +                         vfio_cxl_mem_pgoff(vma, addr);
> > +     vm_fault_t ret =3D VM_FAULT_FALLBACK;
> > +
> > +     if (is_aligned_for_order(vma, addr, pfn, order)) {
> > +             scoped_guard(rwsem_read, &vdev->memory_lock) {
> > +                     /*
> > +                      * A reset or D3 transition takes memory_lock for=
 write,
> > +                      * revokes this mapping and clears the decoder. D=
o not
> > +                      * insert a PFN for a decoder that is not in a kn=
own-good
> > +                      * state, or the host CPU could reach a disabled =
decoder.
> > +                      * vfio_pci_vmf_insert_pfn() adds the Memory-Spac=
e gate:
> > +                      * an HDM access while the device has Memory-Spac=
e disabled
> > +                      * aborts on the fabric as a fatal host SError, s=
o it must
> > +                      * not be faulted in until the guest re-enables i=
t.
> > +                      */
> > +                     if (cxl->hdm_valid)
> > +                             ret =3D vfio_pci_vmf_insert_pfn(vdev, vmf=
, pfn,
> > +                                                           order);
> > +                     else
> > +                             ret =3D VM_FAULT_SIGBUS;
> > +             }
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static vm_fault_t vfio_cxl_mem_fault(struct vm_fault *vmf) {
> > +     return vfio_cxl_mem_huge_fault(vmf, 0); }
> > +
> > +static const struct vm_operations_struct vfio_cxl_mem_vm_ops =3D {
> > +     .fault =3D vfio_cxl_mem_fault,
> > +#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
> > +     .huge_fault =3D vfio_cxl_mem_huge_fault, #endif };
> > +
> > +static int vfio_cxl_mem_mmap(struct vfio_pci_core_device *vdev,
> > +                          struct vfio_pci_region *region,
> > +                          struct vm_area_struct *vma) {
> > +     unsigned long mask =3D (1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT=
)) -
> 1;
> > +     u64 req_start =3D (vma->vm_pgoff & mask) << PAGE_SHIFT;
> > +     u64 req_len =3D vma->vm_end - vma->vm_start;
> > +
> > +     if (req_start + req_len > region->size)
> > +             return -EINVAL;
> > +
> > +     /*
> > +      * CXL.mem is coherent memory, so leave the mapping write-back
> cacheable;
> > +      * a device or non-cached mapping would break the coherence the g=
uest
> and
> > +      * KVM depend on. The host physical range is claimed exclusively =
at bind,
> > +      * so no conflicting cacheable alias remains.
> > +      */
> > +     vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND |
> VM_DONTDUMP);
> > +     vma->vm_ops =3D &vfio_cxl_mem_vm_ops;
> > +     vma->vm_private_data =3D vdev;
> > +
> > +     return 0;
> > +}
> > +
> > +static ssize_t vfio_cxl_mem_rw(struct vfio_pci_core_device *vdev,
> > +                            char __user *buf, size_t count, loff_t *pp=
os,
> > +                            bool iswrite) {
> > +     /*
> > +      * The HDM region advertises READ and WRITE so a VMM can derive a=
n
> > +      * accessible mmap protection for it, but fd read/write is not su=
pported.
> > +      * The only host-side way to reach the range for a copy is a kern=
el
> > +      * mapping of the CXL.mem host physical address (memremap, which
> reuses
> > +      * the linear map for this RAM-backed range), and a CPU access th=
rough
> > +      * that mapping aborts on the fabric as a fatal host SError, unli=
ke the
> > +      * guest-facing mmap fault path which maps the pfn directly. Reje=
ct the
> > +      * transfer rather than fault the host; a consumer mmaps the regi=
on and
> > +      * accesses it that way.
> > +      */
> > +     return -EIO;
> > +}
>=20
> This would be unprecedented in vfio and we don't actually have a means to
> express that read/write access is not available.  Can you describe furthe=
r how
> it's possible that we cannot create a host mapping to access the HDM memo=
ry
> without risking a host SError fault?  If there's a device state issue her=
e, we have
> mechanisms to guard such accesses.

I will re-assess this part. The HDM memory read/write restriction needs a
proper justification rather than a new uAPI expression. I feel this is a
device-state issue but I will need to gather some more details on this.

If the hardware error reflects a device-state window I will add a guard on
device state as you suggested and drop the -EIO entirely.

>=20
> > +
> > +/*
> > + * The CXL regions carry no per-region state (region->data is the
> > +shared,
> > + * devm-managed vfio_cxl_state), so releasing a region is a no-op.
> > +The hook is
> > + * still required: vfio_pci_core_disable() calls
> > +region->ops->release() for
> > + * every region without a NULL check.
> > + */
> > +static void vfio_cxl_region_release(struct vfio_pci_core_device *vdev,
> > +                                 struct vfio_pci_region *region) { }
> > +
> > +static const struct vfio_pci_regops vfio_cxl_mem_regops =3D {
> > +     .rw =3D vfio_cxl_mem_rw,
> > +     .mmap =3D vfio_cxl_mem_mmap,
> > +     .release =3D vfio_cxl_region_release, };
> > +
> > +/*
> > + * Map a poisoned HDM-region pfn back to the file offset of each user
> > +mapping so
> > + * memory_failure() can unmap it and signal the fd holder. The region
> > +is a
> > + * single linear range at hpa_range.start; recover the per-vma file
> > +offset the
> > + * same way the fault handler derived the pfn.
> > + */
> > +static int vfio_cxl_pfn_to_vma_pgoff(struct vm_area_struct *vma,
> > +                                  unsigned long pfn, pgoff_t *pgoff)
> > +{
> > +     struct vfio_pci_core_device *vdev;
> > +     struct vfio_cxl_state *cxl;
> > +     pgoff_t vma_off, pfn_off;
> > +     unsigned long start_pfn;
> > +
> > +     if (vma->vm_ops !=3D &vfio_cxl_mem_vm_ops)
> > +             return -ENOENT;
> > +
> > +     vdev =3D vma->vm_private_data;
> > +     cxl =3D vdev->cxl;
> > +
> > +     start_pfn =3D PHYS_PFN(cxl->hpa_range.start);
> > +     if (pfn < start_pfn ||
> > +         pfn >=3D start_pfn + (range_len(&cxl->hpa_range) >> PAGE_SHIF=
T))
> > +             return -EFAULT;
> > +
> > +     pfn_off =3D pfn - start_pfn;
> > +     vma_off =3D vma->vm_pgoff &
> > +               ((1UL << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
> > +     /* Skip VMAs that do not map the pfn, e.g. a partial mmap of the =
region.
> */
> > +     if (pfn_off < vma_off || pfn_off - vma_off >=3D vma_pages(vma))
> > +             return -EFAULT;
> > +
> > +     *pgoff =3D vma->vm_pgoff + (pfn_off - vma_off);
> > +     return 0;
> > +}
> > +
> > +/*
> > + * The HDM region is struct-page-less device memory, so a memory
> > +error on it
> > + * cannot be routed through the normal page path. Register the range
> > +with
> > + * memory_failure() so such an error is contained to unmapping the
> > +range and a
> > + * SIGBUS to the fd holder instead of escalating to a host SError.
> > + */
> > +static int vfio_cxl_register_pfn_space(struct vfio_pci_core_device
> > +*vdev) {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     unsigned long start_pfn =3D PHYS_PFN(cxl->hpa_range.start);
> > +
> > +     cxl->dpa_pfn_space.node.start =3D start_pfn;
> > +     cxl->dpa_pfn_space.node.last =3D
> > +             start_pfn + (range_len(&cxl->hpa_range) >> PAGE_SHIFT) - =
1;
> > +     cxl->dpa_pfn_space.mapping =3D vdev->vdev.inode->i_mapping;
> > +     cxl->dpa_pfn_space.pfn_to_vma_pgoff =3D vfio_cxl_pfn_to_vma_pgoff=
;
> > +
> > +     return register_pfn_address_space(&cxl->dpa_pfn_space);
> > +}
> > +
> > +static ssize_t vfio_cxl_comp_rw(struct vfio_pci_core_device *vdev,
> > +                             char __user *buf, size_t count, loff_t *p=
pos,
> > +                             bool iswrite) {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     loff_t pos =3D *ppos & VFIO_PCI_OFFSET_MASK;
> > +
> > +     /*
> > +      * The guest programs a GPA into this decoder and the host resolv=
es the
> > +      * HPA, so the guest never drives the physical decoder. Reads com=
e from
> > +      * the open-time snapshot; write emulation lands in a later chang=
e.
> > +      */
>=20
> Is write emulation necessary?  Maybe that's an advantage of exposing this=
 as a
> separate device specific region, userspace can be responsible for the wri=
te
> virtualization.
>=20
> > +     if (iswrite)
> > +             return -EINVAL;
> > +
> > +     if (pos >=3D cxl->hdm_len)
> > +             return -EINVAL;
>=20
> hdm_shadow is allocated as hdm_len/sizeof(u32).  Something should make
> sure hdm_len based restrictions don't overreach the shadow.
>=20
> > +
> > +     count =3D min_t(size_t, count, cxl->hdm_len - pos);
> > +     /*
> > +      * The shadow mirrors the physical decoder, so BASE_LOW/HIGH carr=
y
> the
> > +      * host HPA. That is visible only to the trusted VMM holding the =
fd; the
> > +      * VMM virtualizes the base so the guest sees its own GPA and nev=
er the
> > +      * host address.
> > +      */
> > +     if (copy_to_user(buf, (u8 *)cxl->hdm_shadow + pos, count))
> > +             return -EFAULT;
> > +
> > +     *ppos +=3D count;
> > +     return count;
> > +}
> > +
> > +static const struct vfio_pci_regops vfio_cxl_comp_regops =3D {
> > +     .rw =3D vfio_cxl_comp_rw,
> > +     .release =3D vfio_cxl_region_release,
> >  };
> >
> > +static void vfio_cxl_release_hpa(void *data) {
> > +     struct vfio_cxl_state *cxl =3D data;
> > +
> > +     release_mem_region(cxl->hpa_range.start,
> > +range_len(&cxl->hpa_range)); }
> > +
> >  static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)  {
> >       struct pci_dev *pdev =3D vdev->pdev; @@ -92,6 +325,20 @@ static
> > int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
> >       if (ret)
> >               return ret;
> >
> > +     /*
> > +      * Map the HDM decoder registers to sample their programming at o=
pen.
> > +      * The block location comes from the enumeration cache in pdev->h=
dm,
> so
> > +      * this does not reach into the CXL core register map. vfio-pci o=
wns the
> > +      * BAR, so map without claiming the sub-block.
> > +      */
> > +     cxl->hdm_regs =3D devm_ioremap(&pdev->dev,
> > +                                  pci_resource_start(pdev, pdev->hdm->=
hdm_bar) +
> > +                                  pdev->hdm->hdm_offset, pdev->hdm->hd=
m_size);
> > +     if (!cxl->hdm_regs)
> > +             return -ENOMEM;
> > +
> > +     cxl->hdm_len =3D pdev->hdm->hdm_size;
> > +
> >       ret =3D cxl_set_capacity(&cxl->cxlds, hdm_size);
> >       if (ret)
> >               return ret;
> > @@ -100,9 +347,30 @@ static int vfio_cxl_init_device(struct
> vfio_pci_core_device *vdev)
> >       if (IS_ERR(cxlmd))
> >               return PTR_ERR(cxlmd);
> >
> > +     /*
> > +      * Own the resolved host physical range outright, and exclusively=
: mark
> > +      * it IORESOURCE_EXCLUSIVE so /dev/mem cannot map a conflicting
> alias even
> > +      * on an IO_STRICT_DEVMEM=3Dn kernel. Firmware that left it as Sy=
stem
> RAM
> > +      * would otherwise keep a cacheable alias that faults the host on=
ce the
> > +      * guest maps the range write-back. There is no devm form of the
> exclusive
> > +      * request, so pair it with a devm release action.
> > +      */
>=20
> Firmware isn't governed by OS resource structures.  It's useful, but I do=
n't think
> it has the full stated scope.
>=20
> > +     if (!request_mem_region_exclusive(cxl->hpa_range.start,
> > +                                       range_len(&cxl->hpa_range),
> > +                                       "vfio-cxl-hdm"))
> > +             return -EBUSY;
> > +     ret =3D devm_add_action_or_reset(&pdev->dev, vfio_cxl_release_hpa=
, cxl);
> > +     if (ret)
> > +             return ret;
> > +
> >       cxl->cxlmd =3D cxlmd;
> >       vdev->cxl =3D cxl;
> >
> > +     /*
> > +      * The VFIO regions and the poison-containment pfn space are set =
up in
> > +      * open_device(): vfio_pci_core_disable() tears down all dynamic =
regions
> on
> > +      * close, so they must be created per open rather than once at bi=
nd.
> > +      */
> >       return 0;
> >  }
> >
> > @@ -114,9 +382,11 @@ static void vfio_cxl_release_device(struct
> > vfio_pci_core_device *vdev)  static int vfio_cxl_open_device(struct
> > vfio_pci_core_device *vdev)  {
> >       struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     void __iomem *hdm =3D cxl->hdm_regs;
> >       struct pci_dev *pdev =3D vdev->pdev;
> > +     __le32 *hdm_shadow;
> >       u32 hdr, *shadow;
> > -     int i, dwords;
> > +     int i, dwords, ret;
> >
> >       /*
> >        * Sample the DVSEC body now rather than at bind: a low-power @@
> > -137,13 +407,88 @@ static int vfio_cxl_open_device(struct
> vfio_pci_core_device *vdev)
> >       cxl->dvsec_dwords =3D dwords;
> >       cxl->dvsec_shadow =3D shadow;
> >
> > +     dwords =3D cxl->hdm_len / sizeof(u32);
> > +     hdm_shadow =3D kcalloc(dwords, sizeof(__le32), GFP_KERNEL);
> > +     if (!hdm_shadow) {
> > +             kfree(shadow);
> > +             cxl->dvsec_shadow =3D NULL;
> > +             return -ENOMEM;
> > +     }
> > +
> > +     for (i =3D 0; i < dwords; i++)
> > +             hdm_shadow[i] =3D cpu_to_le32(readl(hdm + i *
> > + sizeof(u32)));
> > +
> > +     cxl->hdm_dwords =3D dwords;
> > +     cxl->hdm_shadow =3D hdm_shadow;
> > +
> > +     /*
> > +      * vfio_pci_core_disable() frees all dynamic regions on close, so=
 register
> > +      * them here (per open) rather than at bind. A failed first-open =
never
> > +      * reaches close_device(), so unwind on error.
> > +      *
> > +      * Advertise READ and WRITE alongside MMAP: a VMM derives the
> mmap
> > +      * protection from these flags, so without them the HDM memory is
> mapped
> > +      * PROT_NONE and a guest access faults (KVM cannot back the mappi=
ng).
> The
> > +      * flags describe the mmap protection only; fd read/write returns=
 -EIO,
> > +      * because a host CPU read through a kernel mapping of the cohere=
nt
> > +      * CXL.mem range aborts on the fabric (see vfio_cxl_mem_rw()).
> > +      */
> > +     ret =3D vfio_pci_core_register_dev_region(vdev, VFIO_REGION_TYPE_=
CXL,
> > +                                             VFIO_REGION_SUBTYPE_CXL_M=
EM,
> > +                                             &vfio_cxl_mem_regops,
> > +                                             range_len(&cxl->hpa_range=
),
> > +                                             VFIO_REGION_INFO_FLAG_REA=
D |
> > +                                             VFIO_REGION_INFO_FLAG_WRI=
TE |
> > +                                             VFIO_REGION_INFO_FLAG_MMA=
P, cxl);
> > +     if (ret)
> > +             goto err_free_shadows;
> > +
> > +     ret =3D vfio_pci_core_register_dev_region(vdev, VFIO_REGION_TYPE_=
CXL,
> > +                                             VFIO_REGION_SUBTYPE_CXL_C=
OMP_REGS,
> > +                                             &vfio_cxl_comp_regops, cx=
l->hdm_len,
> > +                                             VFIO_REGION_INFO_FLAG_REA=
D, cxl);
> > +     if (ret)
> > +             goto err_unregister_hdm;
> > +
> > +     /*
> > +      * The HDM region is advertised mmap-able, so a fd holder can fau=
lt its
> > +      * struct-page-less device memory in from the host CPU. Register =
it with
> > +      * memory_failure() to contain a memory error. -EOPNOTSUPP means
> > +      * CONFIG_MEMORY_FAILURE is off, so run without containment.
> > +      */
> > +     ret =3D vfio_cxl_register_pfn_space(vdev);
> > +     if (ret && ret !=3D -EOPNOTSUPP)
> > +             goto err_unregister_comp;
> > +
> > +     /*
> > +      * The decoder is firmware-committed and the shadow now mirrors i=
t, so
> > +      * host access to the HDM range is safe. Open the access gate; re=
set and
> > +      * power transitions clear it until the decoder is restored.
> > +      */
> > +     cxl->hdm_valid =3D true;
> > +
> >       return 0;
> > +
> > +err_unregister_comp:
> > +     vfio_pci_core_unregister_dev_region(vdev);
> > +err_unregister_hdm:
> > +     vfio_pci_core_unregister_dev_region(vdev);
> > +err_free_shadows:
> > +     kfree(cxl->hdm_shadow);
> > +     cxl->hdm_shadow =3D NULL;
> > +     kfree(cxl->dvsec_shadow);
> > +     cxl->dvsec_shadow =3D NULL;
> > +     return ret;
> >  }
> >
> >  static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
> > {
> >       struct vfio_cxl_state *cxl =3D vdev->cxl;
> >
> > +     cxl->hdm_valid =3D false;
> > +     unregister_pfn_address_space(&cxl->dpa_pfn_space);
> > +     kfree(cxl->hdm_shadow);
> > +     cxl->hdm_shadow =3D NULL;
>=20
> counted_by_ptr needs to be updated as well.  Thanks,
>=20
> Alex

I will expose the decoder block as a live read-only view gated on device st=
ate
rather than a static shadow, and model it as a PCI vendor-type region (CXL
vendor ID). That removes the snapshot and makes patch 23 (refresh-after-res=
et)
unnecessary. I will also fix the hdm_len/shadow bounds and split the
error-containment into its own patch as you suggest.      =20

Manish

>=20
> >       kfree(cxl->dvsec_shadow);
> >       cxl->dvsec_shadow =3D NULL;
> >  }
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 470730cdc88b..6f6ebcce86a1 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1123,6 +1123,23 @@ int vfio_pci_core_register_dev_region(struct
> > vfio_pci_core_device *vdev,  }
> > EXPORT_SYMBOL_GPL(vfio_pci_core_register_dev_region);
> >
> > +/*
> > + * Unregister the most recently registered dynamic region. Used to
> > +unwind a
> > + * partially built region set on an open-time error; regions are
> > +otherwise
> > + * released together in vfio_pci_core_disable().
> > + */
> > +void vfio_pci_core_unregister_dev_region(struct vfio_pci_core_device
> > +*vdev) {
> > +     struct vfio_pci_region *region;
> > +
> > +     if (WARN_ON(!vdev->num_regions))
> > +             return;
> > +
> > +     region =3D &vdev->region[--vdev->num_regions];
> > +     region->ops->release(vdev, region); }
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_dev_region);
> > +
> >  static int vfio_pci_info_atomic_cap(struct vfio_pci_core_device *vdev,
> >                                   struct vfio_info_cap *caps)  { diff
> > --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> > index b9202cb29d96..294e95b5e881 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -187,6 +187,7 @@ int vfio_pci_core_register_dev_region(struct
> vfio_pci_core_device *vdev,
> >                                     unsigned int type, unsigned int sub=
type,
> >                                     const struct vfio_pci_regops *ops,
> >                                     size_t size, u32 flags, void
> > *data);
> > +void vfio_pci_core_unregister_dev_region(struct vfio_pci_core_device
> > +*vdev);
> >  void vfio_pci_core_set_mmap_exclude(struct vfio_pci_core_device *vdev,
> int bar,
> >                                   u64 start, u64 len);  void
> > vfio_pci_core_close_device(struct vfio_device *core_vdev); diff --git
> > a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h index
> > 540e62312671..d5b8106625bf 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -377,6 +377,9 @@ struct vfio_region_info_cap_type {
> >  /* sub-types for VFIO_REGION_TYPE_CXL */
> >  /* CXL.mem HDM region of a Type-2 device, mmap-able */
> >  #define VFIO_REGION_SUBTYPE_CXL_MEM          (1)
> > +/* CXL HDM decoder registers, trapped so the guest programs a GPA it n=
ever
> owns */
> > +#define VFIO_REGION_SUBTYPE_CXL_COMP_REGS    (2)
> > +/* Subtypes 3+ are reserved for future trapped CXL surfaces, e.g.
> > +RAS. */
> >
> >  /**
> >   * struct vfio_region_gfx_edid - EDID region layout.

