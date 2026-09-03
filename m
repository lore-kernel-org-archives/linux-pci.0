Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283474749E1;
	Thu,  3 Sep 2026 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430088; cv=fail; b=gwgUE+y71YswsSHvIvEvobXhaUprK8vPHC8VUdM20dJjKA21f+Y1TFgUIgtdhsvfYpRPd/uG8RRUy8X5dRtIn39FhUh8qpY5oOJaeco+1kw+4ZOIVU0IIju7COOy83//BEYLdquOn5eslDErOsOn7ungNmPV5NjgNBtNefl+2+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430088; c=relaxed/simple;
	bh=ccdDR678teJFTsXf3grrqQIxxRDGkHP1sa8d5ufhOyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cG/i8C76jtpK2szSJceb9sISaLo/fK660vEnJwuBHOS+Qt6AYvmtBMmcnsQ3L/QiVI8K7rFNzVtmglUlmOSV8Ag7EBohqLzczkrHSATKS4fZMWleBaRCh8ATJwPs4UiecOaUzbUxkHUnR310wVEDshAxFq4s9RY11aiPc0UezYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TY66KslK; arc=fail smtp.client-ip=52.101.61.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TY66KslK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1Qqly+cGAwgmOCgTETOJt4vg4KLUj5nN2FLxWCqwRcJ4ym9XK69EzaYaAn9evRDoy7v8P1Tnfug6WaRgy/1ZgUZb5srIjN3mIglTbjXfH19dr25R7eVjqyVC0u2xn9+aWdKJf1731r3jRo9xQsscTvqk00PVewsLQEwXLBfKLWEprp4qsa/OUKxmRtK8SBR/4V06N5bmvOa31sKgoQNzbYN4kfGqvIJLWNqavTCpVeWjW5EqoFY26UHPrHB05dPk6vJ58a6rumA4IEIW5LJfdad0VCZ8YM5BWKX9BqUMQ24yEL96sSKHmNnUXuwAF3JtzZAaw+o1jFBXwiCrbAd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQKZtvIH2Mpy+7mVxvGPlbPJxzDLJQ8rZgXQJpdwG90=;
 b=GDSMPRF86TCtdv2QjAsQAcT96Nb8XYrksVhQjXSltOwXxZ0ABzDKjqx9yCsH7fXhT+ohYudwyaKTUO8zXpIqNfTfJC1r08xivJx4LT8lTN/LcF/VArQ7jid0psbwaNGXqgPGC7vimcCM2T8JEE5JaYAZ9vd19ewswiGvvZ8dqfprJ4ZxR07xAWvpBB5CU++udzUWmswsNCW9gphiMv1MolgCM0N6Shvt42KRAEPBoqmUJ+tiZ9rs2oVIx63/ZEvZ79OQWYqVEIZJzcg6I2PxLZ+qycdibh9qMhqkSPleL9fS9UvOegpWKLcVz0JjiuFC22vneJ2sTFltAPYx9KlYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQKZtvIH2Mpy+7mVxvGPlbPJxzDLJQ8rZgXQJpdwG90=;
 b=TY66KslKOvbtB+Epyc7gIAj3v9dBHanrQgOYXC07/dNMTIEPlAhaN/HaYKI9CyK7Ns/g7KItOAV+WeKQjVAPVCWGKKm7IcbliEoNKRncPP4l6HitdZ/Z0CmW+m2M1rwK5AEIoG3SF/0kBRgsycNVXq2WHOTLr366mjGdwYeyFn8vM5mY81WDK5ugATIlpdih467blWMB10mkEBEW/wmR0OgrTC0aptSsgcje9/3MjO6kvZX8ZGpnnefldR4amj+s+lx9hOwBDmzXyPhrSusZpBemWc3/fM2b5O6MC+HRO1I0PDvz4M3dyWoOYSX/2zoJvq0B/I/4+qWTPniYmJhjNg==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 10:07:54 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:07:54 +0000
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
Subject: RE: [PATCH v4 02/27] cxl/regs: Skip sub-block region request for
 BAR-owning drivers
Thread-Topic: [PATCH v4 02/27] cxl/regs: Skip sub-block region request for
 BAR-owning drivers
Thread-Index: AQHdKwdrhS1xkNf5MUiXJTzJp0+k07avWqUAgA0YoSA=
Date: Thu, 3 Sep 2026 10:07:54 +0000
Message-ID:
 <IA1PR12MB9030F988D6D13E14946E2792BDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-3-mhonap@nvidia.com>
 <20260825152612.5b8452f7@shazbot.org>
In-Reply-To: <20260825152612.5b8452f7@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH2PR12MB4326:EE_
x-ms-office365-filtering-correlation-id: 29e6eea7-3a42-4434-64fc-08df09a3389d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 5Z4EGHoL+tb0PYz2EKrVyaByXjKGPpPiqt3/LxaNeE7+SjRdjf/Ya0tbGM6uS9uX53iLNzrHFuhvGcYDqu7IjHWTgNpzDnT47WM9qRWqQMmrnzZ3ttYSCPGNH9d95Hhyv1HHk0GvrrO+gEOY+H03ubMP/qbewrAMsuBO/4a2G3a1JlMc+16vY0xC0UAvbNz1Heq2lUs2EO1Ip1jTn9+w1NRAG+qBIPbgzCqnNhKajDDhTZhN0mNyS3zcXmFl7RRqbNzbAzVtxQynnNn2cteYwm8WCwKGL0+ee2A7OzI74bTicqy9Ciac0W5cYPIkUcIW7VFA90640cui7+wsbKQsGWKk20vXoKFQuinASb5+dRiVeDojlbzqwlqMe1eRdTCD3E7Lx2Mbc0IBT21e3inv+8f4+guJFCJIAGesZnGHoSmiN7l0fRsMeG3n0cD5NY3mboAgcyoEiNOaaTm2kBhowMW+40TTrnrUysi3hchuQcB5B0M4A1aUKio3BuwdEGiedTPxFs9h+pe+nkDY7oUwAWIEk30Lk5CaEd2gTNnkwX3KFh2X9Jl7dWHXcyxZ2m26g1O0ptqBKO5g35RJWu/SAd2OoQZxCUaeKzO1+WFwN98uNdxgZRVHMLbQ7CUKtjjOOfxNbFWPAptGsQ4p3t+uIQ82gzXRiFZWTgEHt2J27CnlqhzyOOv3JZTg22NzHWTFnsBgfvxWNHnR9q4j9GdViWoMsL9Wcn7XAKtAyKT9Nm8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?L8IgevdoVU91NTM+qUaKbk7uj5t063TXVnbvgTsWKtJfnLfQQ8Cw4iuaDZUs?=
 =?us-ascii?Q?+9jXKLl1QDdjLGtpE4AyU5UfG0Mh2XCv6qth+aJdvuEGLcUEAYxcq6qQ5FSw?=
 =?us-ascii?Q?qcYHjpelOhLG+dMy4j4kRVg+HM2PrcY9vnwcnhVjIQrL+LBglncnXafMKelb?=
 =?us-ascii?Q?PU4DT7k2PLf1dETXbGPaNqan00jdb+1uv/AuWyN0Dg0QXEKR6VmgL4ZGhbf1?=
 =?us-ascii?Q?jqEsN6FVqvGLTaXf7WnXrs5z8y6rHuLYD0HPUhZqt8QWvOokKirF3owTRk/Y?=
 =?us-ascii?Q?SkpvGxoaGXuHyQfdrzdTcUVowwNa6mZ7n114McivfYRFxB+SoXjAYK+79dc7?=
 =?us-ascii?Q?Sv2ooggg4AeTLY4IVN/yJRNny1EaVRhm/p1Nxadctcbd1n1sVKBT3aXUBrvT?=
 =?us-ascii?Q?NHLxQV/Zjp+YEKQvxCi/CVjLLOGCBIE5f3hXiRtdB6xCodRo5KnBJqXWWFrc?=
 =?us-ascii?Q?g7UGsiElc7PLQhjkb7Lnvl6LpPRevk4nWDhIIBnwVpBKAeOXSxMbuxETVNFz?=
 =?us-ascii?Q?kLNf/AfwknB1IFkK6RXLOZ7wp0dknQVjg/AMlk7vzRDUpUUB0UdbBm2g3fqm?=
 =?us-ascii?Q?JTNR3Qr+SoqWKpX82/vgbSTxo80jeCY4zgMQsUu6qMLzaSqrJTi1n0U22nUm?=
 =?us-ascii?Q?CZ4gJsUniuHjNdFtcNEkliJ6gE1/DdtM1K8SYTlOJUh0Pxucm1RMFUs4yl/O?=
 =?us-ascii?Q?TQULhyxMZM171t4bMWHU1TexIuDQTAU/nqhd/RJTo16Wk0sijLmNDzCGj9Yf?=
 =?us-ascii?Q?PYw9xzw1/VC87O8myjBgLvNa+oT9m12NJkkuujn6tSUHqdHfQsvcWG5sSQdZ?=
 =?us-ascii?Q?vEPjvAehug4t9OeoZSyLe+nAzh3YZCkrxzG6jlhurvIRIkYotq/5S/LbhF6X?=
 =?us-ascii?Q?yZD5JGKl6O9JXKMaYvWJ+plEliq6glmsR8X5Erft8KrEaVpmRzgPx/eSNAFb?=
 =?us-ascii?Q?02L6+2bk28Zak0jOpz4S3r45ojQny5tvK+aGdIzrIWrqqYS+8mIFKIaFvqN9?=
 =?us-ascii?Q?gCMxfV3fbhTVld2Cmh/ZSB/h12t5LtIyfnGgelemJqQwXjs9YH29HaBwLqFQ?=
 =?us-ascii?Q?lgVcW+trbs6E0CNgpT+YCLH1L+siBw7zseXghihUL+xLYpJnKLRr5q0rV84I?=
 =?us-ascii?Q?VWI3hVeJgJgARh/hEcJG6c84iKLlmw9JWdhejavmWS9procBnOA9DJn2Jxnz?=
 =?us-ascii?Q?OCoCp1HhnNIdkpxTMDFM3w+5UXyvg3ND1GYNQ88nI6nSRYQa4tL5V5WHMh3Z?=
 =?us-ascii?Q?6kwqfG8e1b5Kpsw4Zrz4Avfz1dQzZQjNX+Y5WCtbXURlk8A7QDD82qeEhto7?=
 =?us-ascii?Q?BZhZEs2ULX/SecbDl1pc0JQ+XokkwRexzRFOVp4IgxnfsoJJ1lfpha2wlfpW?=
 =?us-ascii?Q?SHYJ1lEFbdINpdYUkBPWsaYmyvRebWNrAtB5bTe83MmKiEPnBjZgaSaUEQYu?=
 =?us-ascii?Q?FN1MP91PSgefcrd0/E42JOEGGdI3m5GtCGrpJt9Z9m0lgO3bxB5PKItKrytB?=
 =?us-ascii?Q?lWxfrV4sza52jk+m+yYF6591WVpkhhix3v3X36WJs1M3uqIX2QQ1dRU3O/j8?=
 =?us-ascii?Q?wLI0TJe1v+Bb4dJ+4lcovVNsemJDiFrGGK6dA8PdXAB7InEewEpmtTXzJh6l?=
 =?us-ascii?Q?9+Zoptt6XyMMFDRZ04i/bMt+84jBZPHdNle479BeLgX8exOQb9czcYTDLigC?=
 =?us-ascii?Q?QjDwQsChRcaFrWo9jMkpKQJfjFKoQOhZ1bteT4vCbVICUgKO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e6eea7-3a42-4434-64fc-08df09a3389d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:07:54.3455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gNdFJtEc6Io8DwZKurRMnF6FEBq9Gvug1TWk4Ko1Lr3WlEJr08+oA9nr74Wl2e6R92cNTGqBLIWQA7DOyKEDzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Wednesday, August 26, 2026 2:56 AM
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
> Subject: Re: [PATCH v4 02/27] cxl/regs: Skip sub-block region request for=
 BAR-
> owning drivers
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:06 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > cxl_map_component_regs() claims each mapped sub-block with
> > devm_request_mem_region(). A driver that owns the whole component
> > register BAR, such as vfio-cxl, has already claimed the full BAR, so
> > the per-sub-block claim collides and the mapping fails.
> >
> > Add a bar_owned parameter to cxl_pci_setup_regs() and record it in
> > skip_sub_bar_request on the register map. When set, cxl-core maps the
> > sub-block without requesting the region and leaves ownership with the
> > upper driver. cxl_pci passes false and keeps its existing claim,
> > preserving /dev/mem tooling access to the rest of the component space.
>=20
> The bool arg itself is an undesirable shape, but then threading it throug=
h
> @bar_owned to @skip_sub_bar_request to @request is difficult to follow wi=
th
> limited utility.
>=20
> What if instead cxl allowed drivers to register the resources they've alr=
eady
> requested into the reg_map, ex:
>=20
> int cxl_reg_map_add_owned_resource(struct cxl_register_map *reg_map,
>                                    struct resource *res)
>=20
> Then before cxl does any devm_request_mem_region() calls it creates a
> temporary struct resource for the range it wants to request and compares =
it to
> the resources the driver already reported as owned via resource_contains(=
)?
>=20
> I'm picking reg_map vs cxlds because it seems easier to thread through to
> where we need it.  In this flow, devm_cxl_iomap_block() could be split in=
to
> devm_cxl_request_block() and devm_cxl_ioremap_block(), where
> cxl_map_component_regs() would conditionally call the former when
> resource_contains() finds no matches for driver owned resources, and the
> latter is called unconditionally.  devm_cxl_iomap_block() could remain as=
 the
> unconditional user of both.  Thanks,
>=20
> Alex

Thanks, agreed on both counts; I will switch to the registered-resource
cxl_reg_map_add_owned_resource approach you described.

Manish
