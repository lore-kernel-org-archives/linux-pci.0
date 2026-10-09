Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B63B42FCAC;
	Fri,  9 Oct 2026 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526460; cv=fail; b=b7ryHwDLt1+epr0IU8NOqPLAPBNbiGvTTENf/P7zKhcIcn27OkB94xM51JfqrkK8beM2cwup+bl/rotQFXatwjUiipSvENcN3C+frmNoGnUYnaZjtLQhRSR/jdFPptN19CsDPrCPqpPwXfkvzSLW0x/agkwIQVyklJqZQUd1a3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526460; c=relaxed/simple;
	bh=KhVvw92lfTWcu3OIrwPDkw89PCKWhRHE5a/t0G25HUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a6sJBw72YLohxM6J3k4zItqtCj9wYH8KQ4qvZWVIu5JRSqVYIEbQInfVSVE4UXLICgMtHd0MwthwA10O4IRz2LgmB9uu7S3EFOCQZJfMqYmZhHPau+uzOG5trbodG6+jB8jAyENym5K+31BZgAXPSNY7xJ+6K4d/7v8hnABxVpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RWzeXlsM; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RWzeXlsM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THq4sDDaDSVNCwWxOcqlU2I0R5gNvjAz0PuhvzRQ5IDC7WkOUiOf5OA3NlLw7j79qywh7uBfPCCNH0r/MttPJkgXN1CKlj+z3A5gqkOXUhOHy+uKpPLqYiLK9UU6AZ9WA21S5xeAqbuc/IOk+WcDlU8dLDpYdHxguNEQNnsxpKysKAKhGAQn9oUvoKY7ofTGmT/ovasswHbE/I8lT6Kps9bqFzNQRzs9fc6CY745yqVGkGQ3/ZTRH/f/FVrJa4C8EGjLklp3aaz+23qdz3sVWrqWzFnJPVaDS4lQuw+6To6fmVkYKiQ33rLo2J6v8Sg26ntyaKpG96pCBA2DROOVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/P/zeYDHwa9RTZTYmvEwI4dP12GBGe5TacUhClRbog=;
 b=nzb4PxzZihkVCf92B9jC8RDoMdmukOT+Zayq/c82E3FP/t56XGqArNZB9WUHUiPNuQuVJ5LEcNhlhBe+pUCxjbLxACDamd5gCNcWErP7TrK9L9i2TTKMTXg2rm2a6ZKkmnN7OUO6piSN4J2W1vDs8Ipp7uH2yaVKT81npFK2ViCV98p2CABRNsVoY8ZNohLs4z4Epbf33BgSyK3T0g7HkvfUNmf/2JM899GCR+bKKuA8d5W9mpxDKle1S5c1bE32Ci8OF2hbptU/YpJhP4dwumPUkAGoy9MM6QpdmXVVVmG1DCodkJ1DiiLAIAGEjYhu+n/QeEFeZbDHSQODIPj8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/P/zeYDHwa9RTZTYmvEwI4dP12GBGe5TacUhClRbog=;
 b=RWzeXlsMUlKKjsShSWf5/3NsfIFGweSYpHajMaQhyoUzu03LwN5yNy9AYmj6mWNTMJoKDn+dAbLqAwH4liKe4xgu7/fItpT1KjBR43wHE9FE8TU1oHogH46BxrXZ094wO27HhTPYE0wB66LY40vdDmLlynYBzvGdGujxdLmOKi7mQlUdN1CJ016iu3OOOkcMPbfBenF3IhCSM1NVU19XsiyZbgXOrKgeIW/QsgOxT3j9oaIUCd2SwI0D8c0GWaMWKQgl7E79j0CTPSKcTvnjIHDe9tEXihiXGv3acSqfoGeK8H/fsW2IFmX44OxlYASla4/z0frwirPxVda4rYPawg==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:13 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:13 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	Ankit Agrawal <ankita@nvidia.com>, "dave.jiang@intel.com"
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
Subject: RE: [PATCH v5 04/27] cxl: Add cxl_reset_dvsec_sequence() for vfio-pci
Thread-Topic: [PATCH v5 04/27] cxl: Add cxl_reset_dvsec_sequence() for
 vfio-pci
Thread-Index: AQHdRgpnsSg99gwAk024FSuHR5YUsLbf0E8AgBT5ZTA=
Date: Fri, 9 Oct 2026 06:14:13 +0000
Message-ID:
 <IA1PR12MB903010A1C894291966A38CBBBD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-5-mhonap@nvidia.com>
 <20260925214110.3500b4d9@jic23-hlaptop>
In-Reply-To: <20260925214110.3500b4d9@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 8aa4cdeb-41eb-4bcf-2cd7-08df25cc8a6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|18002099003|22082099003|10067099003|38070700021|11063799006|4143699003|5023799004|56012099006;
x-microsoft-antispam-message-info:
 r6jN2VFYmjyMDKPvJe8nZTDiGTIojTu+0tvZ2wdeAg6kgLEBIw9Pxu6BM3JFtbdK7VinijIw/8uhNV0tHiqTvUKe3Rv69gKVrrpnELkMIjYuRvvb+qIlQe+RpM4HneJlm2WUBqi4erM8FuXJMN01TmrzDaufvZUWKeiFxPQUbQ5RFqdPRiNyUbb9N3/jhiynVz99YsopSMx4NWxbevoIl62ZV2oiVgPLp56O3y10ahvyy7xbhvWy8bF6KSPhyS8cdzU/pcizbldwJdIhPw9EP5l6oz69bYEP+dmToI2TemJdXKAeht8vbLBWYzyKD7mkN0jyAqSZreayNLJji8eAd6/e9mBAl2ghopV97BEWftLsH7wnR9aghgI0bKaN4eh9lwwujlqAzT5wZqsyM7RUa0D7e8a5LF31Fj/GOAs/0TeNPOC8KvR1GokOXYXQMCDlIrukrTc/ouy5EOhfOk70uVvu6Ilj7jRT4lwcw0ci7XkchFAFVoQwRmyGiTNSwgIfKprcJMsbuafcCcsUrPXRbpL08BjKJlRvqo9Y5vBDBooeF26fzR8ek7pvR8twq6fBkD19o8PoN2k28kKNSetSiZqYucFmfrQSEygU1rGYNpEZPKQLpdgLUmfDRMBd9lSNfstyy3oUPwS5j/Fw8+LaZVrytOHJN1edMTFJRVuPdh0NwWNA082uXqXbWJlA4v0E3DFBuTKRH+5I80YqNY5IVJF0U5Q7aJsLS6CtBoIzn6Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vah/gO35Fllk+ihNmYpurfvqsoWBcgZWVuxcbhPkmuisYUw1VLTMN1su7uNr?=
 =?us-ascii?Q?J7GqCtB0B7Kd1fUhtyIXox5mnAwHv08qio4jxsAoX9FBsLJ6qsuwGzl3+8eZ?=
 =?us-ascii?Q?5G7woJapJ6jZhcVyi8kff8EGVsEQZ20MRbeymWGyseujqVA/GSNWCnSult5H?=
 =?us-ascii?Q?p+ruMWp9Su6gSX5QB/uxQNhLydMqgw5IgnnqI8m1vXvhmIR0Jpi8ios793+q?=
 =?us-ascii?Q?qEG/lCbUQL0miTgyzsPbyvEImKWwJBL0xx/ErLePibRa+8gcRAEIHga379sw?=
 =?us-ascii?Q?v7uMaecc5gnK8bdjKuJGy+27zFhN7jBj1Fk8LsNi1KpNb8diG4386kJzzPCH?=
 =?us-ascii?Q?pbCqqJebULs6r8s19NePHdjEkAcnUepzfQ/QJKNlbapzMxiWga/wBnipHbeW?=
 =?us-ascii?Q?wiTioWnmqo3dC1m6ubdhcLsYoaN7CeFjSiRYRHRypQKNdyj89qbR6AVbZf8E?=
 =?us-ascii?Q?5Bmb9UE7njMadFy8IsNKRLU/0w6HmlmpJjYAnp6EuJuXMY24JcPCbEBsO1an?=
 =?us-ascii?Q?ZfWFSdz0Ie3LCsakNrZvOE8o10KTLE4WXnjCpU4TxcC7JiCHAwsLtbSsD6IA?=
 =?us-ascii?Q?eTrvCkJoqLmn6DBRejzgfXZzbDaR6P19oLsO4oFU4aO2YdwYCNEiLZWltZ4d?=
 =?us-ascii?Q?G+k1Qz436lIdHwylRBdh4IehSu87Vg4DB/41ls0VKSqd9pSDv+ldIch0cYc2?=
 =?us-ascii?Q?V8hahwLt/5nsrGTWsVMub+tPuX4IqZFitm2+VQoH77pd09/4ynsBtsft7y+O?=
 =?us-ascii?Q?rBiFCYxkJezLVLEIBDEUNTH49sS4H2BMONTwlv2WD4O0xQfUl6PtOTNfMBca?=
 =?us-ascii?Q?ZZG8cbDsJS+/YlBlicU9oVIqg0g3dR7Glc9VC0rsJ8Sc66mqY1/xRw7pzIZJ?=
 =?us-ascii?Q?c+3NvR5HWhuwB0gjCfAdaobeRb/65cAF0KiyFpPkxA8VfJlu0/LwvBAVhSG0?=
 =?us-ascii?Q?HedU9msOPHb2SeSpgaT8Wg2nDx5r2SqlIqnCBWhr/iVHP+P4Acy/KxqsUEyC?=
 =?us-ascii?Q?40dJOWmayBhE3BUkcPmVzV6DDSrQs/SrT0pudefcmH/KnTJ73bBK47gKv95e?=
 =?us-ascii?Q?8a/3d+o5tZ2l/9NB8HsdCyHcjhDNF5+0Jkud9XDe8L5hwQX1ghznXoFv5gpi?=
 =?us-ascii?Q?/uJDRr5jrgGb/mkv0bo1NSs+KKckT9zvEhLUlCybDR7gEj0Z9qoRWbZwA88O?=
 =?us-ascii?Q?n2rxQm3obTeq0/w808rbvdL2ep7mSRx4hOFO5AbUKOFARcrOw2W/VBGvW8Ot?=
 =?us-ascii?Q?md7fCxt+P+kzapdsGMwIOossFLHn7Ndk1XVallFyfccHFFxWCTpfl6JNRTsg?=
 =?us-ascii?Q?xLVGDOC8H+yfThvsYeKd4GTWpqQ7W3t2dTdwVe8EtkYhi8R51TMJatONCkrD?=
 =?us-ascii?Q?ySKL5abHiHvHzsM6zBOVnEEYoGcLSraU1x2sn4FxBp+Uf5+wgG4z3DIbCMTr?=
 =?us-ascii?Q?t4PeDrYwzoDyhx4Lt5C9/NKWD0qOcVQw1N59bCHR0F72xV4owyJjQ9f+8UHY?=
 =?us-ascii?Q?wYu2mFGBbd2VeClUJhcnPdxsIGAr7Ly54cPkqwmHDjMc0vRoVnliUrNjBDMx?=
 =?us-ascii?Q?ZUWVokHBls+tc7dUhg/TqemEefqSH7M5+n7Ggt+gzVg6uV67QUmrREhnhJIT?=
 =?us-ascii?Q?zvvZNFTcT+aANMIrwuKgd8aI4klKYzHs0BCE6cZUlyrMk4rK/+lgOZ1x1yGa?=
 =?us-ascii?Q?t7ps3xGw8zZu3bFNvPzEu6rWYV7b6sisRGHNqX+3yo2YI/Qk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa4cdeb-41eb-4bcf-2cd7-08df25cc8a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:13.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcQEGwEKxj2Sikf6qy18bCcAB1T8l7teBuRZPRiBprakb+H1aWJWuNGgH0VTHsE20gYPj64fGUM7l1VYrwxoDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912


> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, September 26, 2026 2:11 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>;
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
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org
> Subject: Re: [PATCH v5 04/27] cxl: Add cxl_reset_dvsec_sequence() for vfi=
o-pci
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:17 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > vfio-pci needs to run a CXL reset on a passed-through Type-2 device
> > without the host-memory handling in cxl_reset_function(): the memory
> > behind the decoder belongs to the guest, so the HDM range collection
> > and host CPU cache flush that the host path performs must be skipped.
>=20
> Hi Manish,
>=20
> This cache flush being skipped bit concerns me.  Who is issuing the neces=
sary
> flushes in the vfio case? That is there to ensure we don't end up with ra=
ndom
> lines cached by PA (as well as VA if relevant), so they affect a guest ju=
st as
> much as the host.
> I'm not sure why it makes any difference who the memory belongs to.

Yes, you are right. I feel the reasoning in the commit message is wrong.
cxl_reset v14 already makes the invalidation mandatory on the host
path: it invalidates before the reset and again after the restore, and
refuses the reset when cpu_cache_has_invalidate_memregion() is false.
For v6, I will run the same sequence in vfio reset entry.

On a host where no cache maintenance driver has registered, invalidate
memregion check fails and CXL reset can't be run. vfio-cxl checks the same
condition at bind and continues without CXL support, so it never gives a gu=
est
HDM memory it could not clear and invalidate on the next reset.

>=20
> >
> > Add cxl_reset_dvsec_sequence(), which runs the DVSEC reset under the
> > device lock and restores HDM state through
> > cxl_restore_state_after_pci_reset(), and cxl_reset_capable() to gate
> > it on a function-scoped reset. Both are exported to the vfio-cxl
> > module so vfio-pci core does not import the CXL namespace.
> >
> > CXL Reset always clears memory, so there is no caller Memory Clear choi=
ce.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
