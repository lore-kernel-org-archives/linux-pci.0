Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5D3DCDBC;
	Fri,  9 Oct 2026 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526444; cv=fail; b=bcAa1qUoKmOwgwwgtAu7+JXVTJq3KXZlYxDjCVB3PmjEaLr8ZHZEXsZ5ajm7qUNQmIE9Qgf78cjYfAxmx4Z2I2circOrXc1p4RorQZy5cJpzEonegDHGMEUuFKsEsa9truotwZRf1O57Ye9lf99UYIXAwvZFce0iUAl50Kgb1eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526444; c=relaxed/simple;
	bh=jnCeObq6kJ6RfFUUBSNGBmHRK8TAYup1GS2LL/N2iCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vA2+jToheqdekEqW4i5bMMTxuOI7p3XMwoif/K4WTBHBbgoY8P6ccosaf290g7FKME8Fpj6k+fQc/ih6GVU1npoXX8K8aXDUxdWO5N6ZOG10JyIvIw+wgIQ45vvrnm/V52vvEN/B/27KvTw43eqjjqhNvEIeNpTU3Ek6ql2EIGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NtkX47+Y; arc=fail smtp.client-ip=52.101.52.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NtkX47+Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTv5uS80Lgx08W1OJfik1Hn+7sDOxXlpG2buTBc2mjQWP5XQdt0cP3GhpArVh3AZQosSJ//4LmvbcDdDrzOZzA9Vac2H5XcVMi41HsJHbM95y9sII9KL4OpBBXHgdROOp7C22MiNMGLRjQo8rp4jZULNtc64sqylzz0O9bH9ngWlTfPR33Tdxkfvd1D3z02PD7ftsprcqGcwQbBDBuHlIIT5dfvtlDduenE1qxAohi1XI3QtsfiU45K7whYSi6Xzv4NgvHCG08UfGSbJV6HkUyRvznmfickGIFgdnNfg/PKLOyxkBpCfaqLkUGTo4PPkh2up/QV7/61Ia5oOQfovag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inoOQxbG9I2B4H3hRLhJt9FOwUSyJRTKhGNyoqre4+A=;
 b=LQk+OM6JpqRfPsFb5rkA3/YXpQQLm4W2PN8ijKYm6CZ1OnsBW34h2IXhBvR6DQbJhXV9dZdTsWGOrTz2q6d4dGtOdsr9mN6pJwgIubNtu3G7JmP9RYG/Q8bV+3f9C3Ah6ijoA3LWG7xuil0G3KSkoECAjWKMw/iXYxNhxEI//+l056IbuX0nZ1IGyrodCIFcXKI9rD1ut/0EshdP7vTTevS4cXGaMYY0fHjw5wVy+wlRQbvFAUF/bOjhWQxFH8zFN4edDd5K6Xz/xV8559wGOdIxHAOfnsRIfowQGbdE3X8uezzfzvyUVbcm8wVaGnu70evD3VF6bM7R3HzeKnfFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inoOQxbG9I2B4H3hRLhJt9FOwUSyJRTKhGNyoqre4+A=;
 b=NtkX47+YEx1fWSczJj8s6vuYQjOiM461kdf3NxSKQ75SqD377zyCSoGWiuzUSJhu4cSyJSF/HuMevkpP64f8TWDn7J9q9XwGTNjBGojDK0WM35S6a+Jz6O2S+Pd8XjAcHWgSecT2wgDzzRJeKH8OxAq3BkedrN2rTvDMevHzDxxbCYjrRyOrT5PapzZCffG7iPpyIgpOHebCyLP5YwZGboSCyE/kyQN55sX4IGwBUQ/qJbZeOh18Vz54SUv4+75RAgU2uDxtM8S9mXQX9pnXGMFYmVBOItnuS6XnpDUBTp5i8Ll1lTcufNHgBsG9AwpDRCG6LRh7ICBlzHGvHMQMsQ==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:13:55 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:13:55 +0000
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
Subject: RE: [PATCH v5 02/27] cxl/regs: Let a BAR-owning driver own the
 component register block
Thread-Topic: [PATCH v5 02/27] cxl/regs: Let a BAR-owning driver own the
 component register block
Thread-Index: AQHdRgpbgu0n5Oq/vE6kVwOoySVb3bbZ2X+AgBrtx8A=
Date: Fri, 9 Oct 2026 06:13:55 +0000
Message-ID:
 <IA1PR12MB9030A2A75B4B9C6A0DCAE597BD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-3-mhonap@nvidia.com>
 <20260922023629.68336bd1@jic23-hlaptop>
In-Reply-To: <20260922023629.68336bd1@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: bd02bd0f-f4fe-4a1f-425a-08df25cc7fbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|18002099003|22082099003|10067099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 CnrB8JXwiOkMWT4L6aJrk91LcJb74oQe2s0+gTW1k8OcPVbZIZE2bp475A48PybZY0Ct7eNWKnAsm3n/cO3XCVvXPydDzUnKjED8LHYwOuspisa32QXyeCi1O1dZnPAlSTQJpNTlp21I/t+3jpSSzwbROaLFOOx415owp/NId5vRQvFx4705BnipqOaUvah/aC+YzY5wpJSkJemgcWEfBlaBOSdNr6/8yqDB/vsrGlCTDp/4J3spyIpuAt6szDcJM7yRwUTPhjp9R76FO38pAbS4/2BKy4Z7HbIvvD/XMJqF1kA40bXOt6nu4d7og8qm4I/b2Y1fFj0d0AWr0rxJ6qwUR/33I6bigC+Usfc1fqLwl9jNOzEVhkFeDJSEBFloS6J5O3tvyM1A4Ptnc49+jKuTFE/jJolIq9NXWMy0pj1mN6CUc9yw++0iY76cE5rgA7W+S7O2mVKZHQTuNaFS5kNRNprSdkkwhGYuo0VvcYFNVNGxmBm3jdBr4gF2/21G/AbRG9ghBquHPtATy/pkUWLH14t39YQQjcNugsw77ulcGcIdzuuirHPMDDAymtlMoi5YiQ8oGymVgiP4gGAeCUgxbWbUQTDO0lmkyRHjqbMujhRG77VHmsXkGdBvbwA/DXCB+6ImjMdFOs+F7wZGp+T7LKIOOiUb5G6729K2+D5DjzWg50kOQzx5D3dGtgYE2O9iPYj3xtGWWKIILj1bsE6BcgbiEAVM2Gl92Qcyums=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RoouvYwrUbAptFj+B1FnwtrUSjdFIkJwRkl/Yb5l9YSa1d7Ne+XxzUTlXy0A?=
 =?us-ascii?Q?pZ1c+7WJLjBtZx3Ub+A3dos1c7O4BUiNMp/x0EN9/0jGguNYt2SWc+C3rkvr?=
 =?us-ascii?Q?fdfHWm9Y1aKCAqoPlo42e3q9HR69hsoM4CD3jaMLBfNli0lhOU6X4g/DAQ1A?=
 =?us-ascii?Q?ouyAJ1wbbyOuU4pJYShiCz/dpCrS5nA1sp0FX4Hh5HnFgO8ISqMEE1jqwOmq?=
 =?us-ascii?Q?SIEfa/9jGYc4NcxCAKmiaQnG5Y9XbleDqcmlwY0oWQAJDo/9BnpKu+SCRedq?=
 =?us-ascii?Q?M7qYckHgyT0DrWgHGPSrm/kRgziDaP32kHEJ6WXhLom0z3F9o0KatA70VQw6?=
 =?us-ascii?Q?VxBIiYSAWl8tsYAz8+QBhns38gTM/m95/VYAvfrc1tiumpD4oIA1FP5FuW8i?=
 =?us-ascii?Q?Gs/TgMGwW3Xy5m5jzIvC+2NFdeRYO4niABSYOuskFFNsQBr2g+dDbuIeY7cK?=
 =?us-ascii?Q?KfMcAZ7llKgsiPKOEtK+hZ33iliX7Qxuly/1EMf27SZDK/NvpFxvm3PGQa/+?=
 =?us-ascii?Q?b32PlBlunCkWT8tuvMByeVVKTpco3O3jduJlvxZx0Lm8fsgOKt4nc21b4nqK?=
 =?us-ascii?Q?05dzaU97Siw2uQ+YHU73q9aEMK7umB+dfP0vEJK10FeUrY/mE+F0962ZBX39?=
 =?us-ascii?Q?5jG/TLjKUH/tjrPLBiYhA5w8HLFR5oLw+RNgghNYIlcWaad8A3b1ZjR0mJNO?=
 =?us-ascii?Q?yr6yUW8qWBA6Hf8G+VbSL3MjE2swxfsPidckxZOXOfwyB3mKNQ0QENm/Vw5z?=
 =?us-ascii?Q?ZepGSIx7hUJm20Q+sSIEIo4LT25vUvgnqMMDO8P7SoL40O1AP5HegGIe4LW3?=
 =?us-ascii?Q?hQzJtmpiYOMYAiD6vpiTzT69DtICYRPIDYljNMDz0trBDRiEC6UPqiB19ck1?=
 =?us-ascii?Q?EYIObwmXfFLtFciwlnV5d+eIjIKjVg4WQZHFy2AUAbdBMF8R/wuhDRXMfEv+?=
 =?us-ascii?Q?JnwkEvqMufDuykRY7Q1W2eA31pBf0P8h18CTS03ed5a+srWhRn3MSGKFwP+f?=
 =?us-ascii?Q?/s7ig64lV4GSACTAQ3/aefp6IjtmPmc9h8d7dcFZrHfR9vPAGL5OJstIaiKv?=
 =?us-ascii?Q?sjgNJPQXBKe3fhFtTlby5CG+XsaCGFV12F2jtQGcn3QNWTpU/4s8/kWrXDLF?=
 =?us-ascii?Q?CnvTKju9yLdr3ITt+uGjA/TdLirl8W2fFBZtQyRi9owkGSmmEFp8rfQD+wqB?=
 =?us-ascii?Q?z11d+A6cFRImm4DJWwsGJAo5AixxYDBAIAHSFMvULi8GJRLWFK5zhU70kA3F?=
 =?us-ascii?Q?HDdap4buh+HX7kw3MSnsUIeglcCgnxPO9arOxZJRFGq5criOGBz2fVqBLLcF?=
 =?us-ascii?Q?pM7VGp0FXvf/QCn+aK97tHOwrQzyFomweTgmKdNrVr7Slu22z4J6Boy+uyHA?=
 =?us-ascii?Q?tPPftQG97wY6Q1hwypLcn2bumEIvs4Bd56mFrRgz2QFqo/smhkTbeKhVhIct?=
 =?us-ascii?Q?2WBcMl4VsjFhl6ZWofTMsc9zlDrlAnINLBEagAzHWIB737A6RJt7QeymiR8y?=
 =?us-ascii?Q?m6rSLJzySqUIZZ63DcMkBnpzZGvsjNTVLr8j3b1bPVDlO82nkFb/9FqjreFE?=
 =?us-ascii?Q?VtwbUPpnyUTDWwr+FvmEBK2G3Uk2WnfttkBOeX6OE4w289aRvSypuvB9UaH1?=
 =?us-ascii?Q?/havLtfMeDFcUgeP7iC41rCUV83xXiG4dtyudHKrhXOymuZDTsQEYIlBrd5i?=
 =?us-ascii?Q?bsOk+mGmVmKD0hGIewIrRL4lxHkFjARWjfzwU42FB5TY/QwS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd02bd0f-f4fe-4a1f-425a-08df25cc7fbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:13:55.6468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKCcburMudlGNsarmEPe95+yX0ZAs7b8V/44JYcygpcN8u/DWo84UwJTLtWYP85GnSWdoseuXsMcf/M0nEPGcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912


> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Tuesday, September 22, 2026 7:06 AM
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
> Subject: Re: [PATCH v5 02/27] cxl/regs: Let a BAR-owning driver own the
> component register block
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:15 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > cxl_map_component_regs() claims each mapped sub-block with
> > devm_request_mem_region(). A driver that already requested the whole
> > component register BAR, such as vfio-cxl, would then collide with that
> > claim and fail to map the HDM decoder and RAS blocks.
> >
> > Add cxl_reg_map_add_owned_resource() so such a driver records the
> > resource it already owns on the register map, and skip the sub-block
> > request when the block falls within an owned resource.
>=20
> This seems a slightly odd intermediate point.
>=20
> The assumption is that if owned the whole bar is owned - hence only handl=
e
> one owned region (no check if there is already one set?) yet the code wil=
l try to
> map it if we get a request for something outside of the region mapped (wh=
ich
> can't exist).
>=20
> This all makes me a little nervous.
>=20

Agreed; current model is to have one owned resource - the whole component r=
egister
BAR and I will enforce this in v6.
1. Helper is going to be renamed to cxl_reg_map_set_owned_resource and it w=
ill
   return -EBUSY when resource is already set.
2. cxl_map_component_regs will fail with -ENXIO when a block of an owned ma=
p lies
  outside the owned resource.

> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/cxl/core/regs.c | 17 +++++++++++++++--
> >  include/cxl/cxl.h       |  2 ++
> >  include/cxl/pci.h       |  3 +++
> >  3 files changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c index
> > d79550dbb484..58a7c5cafb45 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -216,6 +216,13 @@ void __iomem *devm_cxl_iomap_block(struct
> device
> > *dev, resource_size_t addr,  }
> > EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
> >
> > +void cxl_reg_map_add_owned_resource(struct cxl_register_map *map,
> > +                                 struct resource *res) {
> > +     map->owned =3D res;
>=20
> As above, I think this needs a sanity check that a future driver author d=
oesn't
> think they can just add lots of these.
> Absolute minimum is add some Docs.

Yes, I will add the documentation.

>=20
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_reg_map_add_owned_resource, "CXL");
> > +
> >  int cxl_map_component_regs(const struct cxl_register_map *map,
> >                          struct cxl_component_regs *regs,
> >                          unsigned long map_mask) @@ -234,6 +241,7 @@
> > int cxl_map_component_regs(const struct cxl_register_map *map,
> >               struct mapinfo *mi =3D &mapinfo[i];
> >               resource_size_t addr;
> >               resource_size_t length;
> > +             struct resource res;
> >
> >               if (!mi->rmap->valid)
> >                       continue;
> > @@ -241,8 +249,13 @@ int cxl_map_component_regs(const struct
> cxl_register_map *map,
> >                       continue;
> >               addr =3D map->resource + mi->rmap->offset;
> >               length =3D mi->rmap->size;
> > -             *(mi->addr) =3D devm_cxl_iomap_block(host, addr, length);
> > -             if (!*(mi->addr))
> > +             res =3D DEFINE_RES_MEM(addr, length);
> > +
> > +             if (map->owned && resource_contains(map->owned, &res))
>=20
> If assumption is whole bar or none, should we just fail if map->owned is =
true
> but the resource contains fails?

Yes, agreed; I will also add this.

>=20
> > +                     *mi->addr =3D devm_cxl_ioremap_block(host, addr, =
length);
> > +             else
> > +                     *mi->addr =3D devm_cxl_iomap_block(host, addr, le=
ngth);
> > +             if (!*mi->addr)
> >                       return -ENOMEM;
> >       }
> >
