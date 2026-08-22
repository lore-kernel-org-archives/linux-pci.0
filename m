Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FAA1C75F9;
	Sat, 22 Aug 2026 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787361743; cv=fail; b=doDGMnRxIrxixLs/mJ3HGG7N3KU5Q/YuKZ2tnXXwEcvp8tJgUYmr8zWku+N2lAmI9rHMUeS5BMKdmR8/5Iof/7ylvpAp5z83acZ8eQ5o4I1CeDU8AqPU3bNWiw7xkqqglcXilnyt70rnDdOFFfzoMMpa6H9occJgmV7Jeei43Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787361743; c=relaxed/simple;
	bh=MxjlgoZXN49PBfIkGgxosirQ2dkVbVl5Bl0Vb+FJgQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OMrEIMW6haYSobaBJX5ODYAwNqIsmqtK27eriJqdvWmFNMtMkSTN0Zuo46lmb4lP7Um+ijD2m77C8V2zopdr203Xq/0rPzx/1duznSm/QYcSZz909hWTprW3fLXRbGaBS/t8q1Tbh51VeC1Uv7YzXjGYYtm5YmzSTKeXVkLpgQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oudMrmkQ; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oudMrmkQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeFGc56WUxTI3nS9VvzI0J9S3idLxKxHOXmsq+14KvHolWga2PRahOLfBmSABs+2Xibt9rHwDft728ELU6JqbYmDSdUUhRFapzmIeFSdoZqWDLsNShqzT4vnyzSyArLrglTFhobNQSxJolPY4m1S2e9dUbI4v6wcbzJCFupxVt2ksFwIr0vxbV2IfkAxKeYIblpyBDyX2lQ0T6rmsOB3rPUleep9hO1X9xkP2iUeTSRSz0uxqIWhfaK9lGuQVw/WoT3bwUr530nJ6GtySVjoau5/OqZd+EEjcwqhCOCeMhT3bs4cZ2nQmrfVbQMBwZGxQrDWTMAD9UdE1aNYnQ9lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4EK0df8tl7enDX3G9pC49SGU+ZH/UtLv4DYLfGFwC4=;
 b=JNjJ+XXUwL/t4NEUTGEumFlREiFxA5Wbj9j+bYzpFSmz5GF221UipFvZ7MB4tyGeFwEIuAQ/qSbyvEzks+yiGvXQwILrLMDKwYVS8xMt78jTGCsKcauHsPqRmFByRyVtNc9kcK05JNAxLDtXWD/rorQ6dK35uYZ94W+ESXgoace8souq/K4Id8UBxeQi7/7DOjolrTOmgGVz1YCwz66LDKmDkcwQ/i74yYoqfu0v+KEk39jF6vtqUSSFS8WHfS+z4vKi4TlLVuOVFrPGSy9cyHSvLEQAYXSagjkPXhF16VKSa4oy8cIOe/2t3dZqLQsdityyAjOKhvQf5wDIBFI4GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4EK0df8tl7enDX3G9pC49SGU+ZH/UtLv4DYLfGFwC4=;
 b=oudMrmkQbE/s0/j38eEgSB2g0TPukfSP51X3WeifVM3wSSd6LGHoefjsdq4y8U+b66sW6CCzW9u81s9CmjP5mLiUa1IGCcyJM2d/yOs7OjHq3R0pBg4nXbs8YJWX43d4J1ktg/8urc2mgJcnKLpKKkMDVCWAhKGt6Mbhg0bmaSvMO+FyvYGYjxEDgMN/UFLpDXhDvMG5BIbKHQXOP7+ffse+s7twdP4ZDAMA6xqAgqmDar4SM3GH9Qhkoa5IQAdl1Fyt306R3oHiEa8W3LkgTpdNtECWad19D9IWbk9KJS57hcQpfutBlgqSUl/eTcsUOZ7ZqCoM8zV1rpUQ9NRpdQ==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Sat, 22 Aug
 2026 01:22:13 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 01:22:13 +0000
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
Subject: RE: [PATCH v4 01/27] cxl: Fix resource.c include path and export
 cxl_restore_hdm_after_pci_reset
Thread-Topic: [PATCH v4 01/27] cxl: Fix resource.c include path and export
 cxl_restore_hdm_after_pci_reset
Thread-Index: AQHdKwdkZtSAYgnzrkys1MolqR67xrapKXoAgAAoXpA=
Date: Sat, 22 Aug 2026 01:22:13 +0000
Message-ID:
 <IA1PR12MB9030AE4B775F69B27AED4350BDA22@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-2-mhonap@nvidia.com>
 <20260821235240.7926351d@jic23-huawei>
In-Reply-To: <20260821235240.7926351d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|DS0PR12MB6630:EE_
x-ms-office365-filtering-correlation-id: dea78357-0706-4e5e-c6fa-08deffebcbe8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 pQfm/lxdVeWxdxcY+Jj65FOhzyvABlL8s+zhY2MQAjveCUbdoqSQGVFxRi93wwSfAMD77EczQN64YN8GD7Kyezo74GCNRajA8YiNojrl64EQWeVNGsQjmTqqIK65H+CIJe+z2GKhpRoxTV4/6RvS3rowu3u7La4qmOrQ+/uIDbS2/Ky6ykWVuVzyRFNFBikovbpHaakZtxLT4Azk4TLB4QNnUaJ6i7BAneJlcLlsIGCoyUmmAMRu5QfBaobngVdlYSnO4bxMB0ZmIIlIUD/qJJnwtk7EF+9NDiqmC0rSQlvNsgDlCNT2UYXwQsrQj3L0uC9dj1V71QKtq0VhTce6KHVKo0uIGDg12Yqbv+Mc/7SqqL2vGbJ24pfpcg5gwcb0+l7+zYqE6PK+qqXhZoHNoJwOkJ7Lb37zM+A2vKQTPManlwslXFRgkaNVIZw5apiVyIqsK3OQC+CDEy5ZFHvqYrTbpSYe1quISgmjKFDnd/QnwSHjxx4zg0OtAGLF4hdY2tV1w9Sk7Q6ba78YkawKr8QWzxjX0f7pB6ibpPHNktLxS2+8aHvurJcRDV+5zyzGijzyculcWgb5ZtIhIuTywIvhEA/k4Ana12ARa5qCbzDaFscRj0nBPsGFCsZj+sQNt0/PI9CEMRvZFd2YwbmvrOVyovyst2OnesiOsqsxPT/jbMuoW5FCsVLa8FE22KOqEzuGhyysTeStr7xtRrtTBgpykgSMfDXYF6hLcy0iMJo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BCTPsPgx/VPzKjykmN+V8Eu+xT/8AdmtzHkyFU9cdhSc+pyysTTWl879sd8J?=
 =?us-ascii?Q?nQQgSDfEpo1dsTg610BPQhmdc8YbsgojtZGYglkpmPn30hWb+5eQ6lbpfouP?=
 =?us-ascii?Q?7Brd+9gFYmAdISnoY/067A/BTEqV20EG9ae60AFFD8OjGSLwMd727bSEMJit?=
 =?us-ascii?Q?59o/81bAHN7cB9QFkiNhrjeIkiJlvcr9YAhEdyVdNeJAxuaaSZixfTn6AuYv?=
 =?us-ascii?Q?wQUH2THWtcXsolbvkl3Y6N+UEy6RqyzrNWjf163LBM94QX5F4GgNBSF+hscR?=
 =?us-ascii?Q?W77nWuwBAnQdpF3W9OYKWzvU1h7+uXgx1cc5Kw4Nvz4l9feyz+5nTfhA1tDG?=
 =?us-ascii?Q?2TQqBLxuFGy4twt6gAKO5AN+bbPmwwtlnYOAfLPsAi/y0GIFNNb8q6/6RO/d?=
 =?us-ascii?Q?516G7OyTki926bxP5RpFkAXzNJrqpzn787Lzs1EscRNYRbrV3PuocGes4HGE?=
 =?us-ascii?Q?Q2Yxnv0H4HAzmiLwXP/z6W5WDAFUapzxNVi/jXB6u7kc5S3B7G6f2Ra+rLlB?=
 =?us-ascii?Q?T1YlRCxWjeengGxo8V16mrBAOJIzuyVVWYo4MUCxQSMnVcLPYBUJKPRt7nLR?=
 =?us-ascii?Q?/4qD7xfhz2xtEbvaEicuLe9Ylu4ibYrn5ocFqzc7I+/hqH06aVka0iieS1RV?=
 =?us-ascii?Q?+cUzLz2WMnVD8a7j1r0CSqxBs88b0uD0ObKKv6DqkutZRTYIfDYNLwhEyDVV?=
 =?us-ascii?Q?mUXELZ1bIXU1YKU4LgjqKYnJ0DITVoo991oDh5Y0X4xRUhXWTkX1YI/6LrQ8?=
 =?us-ascii?Q?N/OQGXQQMj7rxnGDCUzBVQSA5P3c9GWL8IsxUsLnTnj7tTVCzqAg+wijDx6V?=
 =?us-ascii?Q?5UqeOfMhlmrYrarQoJGiFbPpxBQddpOWiS/BRuPaVC3bE5J8vdLz25lfyJjf?=
 =?us-ascii?Q?D5wLBQVio5VgIb+t6SaXZ6lVx827U8dMivML+D4DsIPMzM6xHeEf6cpOv5xw?=
 =?us-ascii?Q?Uw7Wrv6ZzbRSBDrqTnsqnmDlod/LHoo3ExDtjbsuUmWB/E/kkCHYaVSPx4+f?=
 =?us-ascii?Q?yrN1Zm6kBAByfvM+XbxyRBrgW+t/TOIuXX7SuIB8Pnx5nlicxhcYLs71k+9t?=
 =?us-ascii?Q?fzgiKXJjvz47x8aDu77T814F9Sht58/7Wm1wlVD2PMT8RER4MKs4zQNqSfR3?=
 =?us-ascii?Q?c1ue/sf/eDTc73Jxr5E7A5YV28oqKgipRCgQStrbfnkU0ozCQ1rBm6z6KM4G?=
 =?us-ascii?Q?Bc2SUafUmkwMbK9PSS/BynAO8cprHDPCPn/bUj2qfkYFWZ57ihExRaNp8gAF?=
 =?us-ascii?Q?zba/s+edehTkDRTzy811jNVeheLx0iBa7s9iYMjinRKFfzvvKXB21MYrCHPA?=
 =?us-ascii?Q?edAEAP37NhnpGAWMTKHMmGz4mSpI4L5YAid9qhIiJx0i55nkCYSNMFSDoDW4?=
 =?us-ascii?Q?ESYJhsXCMZ0gLeuDEa0lBPc2BDMp++7pSuLArPlmlj5ixpE58bOihD1Kip6g?=
 =?us-ascii?Q?QQi25hjUxeOYDVrkwgf6xUUDe70ZT7AqjyOYDM81qdr3T3IKZFL+Bmh6Bevo?=
 =?us-ascii?Q?TSV9OhvcIje6c3Cs/LlwXh6GljVQeOB8xlmgGC2BULbXtKdCIgdugrrV6k0s?=
 =?us-ascii?Q?1T1cDTeDYw3R8BP9Xpdl2+djrRMDMKV9mzCZnVcg64v+U24wZ0MUU0vzHzC1?=
 =?us-ascii?Q?WaoIUipVLFv11Fol/VD0eKm4n5Vg9uWRp3+BjzPbown4bCkp/WrF6Usxcynz?=
 =?us-ascii?Q?Q/RYJSOzt0K+6zM5iYJ5k8/sF8nAip/4wYNrf65CBACXcss4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dea78357-0706-4e5e-c6fa-08deffebcbe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 01:22:13.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOqQXgxSNiBFtNbsMnx5nToUMDEHBppnBuM4c0fQOZu9jQ+EOEu6pflxTSrpmiMzgsAy80EXOaPFqIevlQRJAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630


> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: 22 August 2026 04:23
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan Madhavan
> <smadhavan@nvidia.com>; corbet@lwn.net; skhan@linuxfoundation.org;
> dave@stgolabs.net; alison.schofield@intel.com; vishal.l.verma@intel.com;
> iweiny@kernel.org; ming.li@zohomail.com; Yishai Hadas
> <yishaih@nvidia.com>; Shameer Kolothum Thodi <skolothumtho@nvidia.com>;
> kevin.tian@intel.com; bhelgaas@google.com; dmatlack@google.com;
> kees@kernel.org; gustavoars@kernel.org; Neo Jia <cjia@nvidia.com>;
> Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>;
> Zhi Wang <zhiw@nvidia.com>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; kvm@vger.kernel.org; linux-cxl@vger.kernel.org;
> linux-pci@vger.kernel.org; linux-kselftest@vger.kernel.org; linux-
> hardening@vger.kernel.org
> Subject: Re: [PATCH v4 01/27] cxl: Fix resource.c include path and
> export cxl_restore_hdm_after_pci_reset
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:05 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > The vfio-cxl Type-2 driver restores the endpoint HDM decoder after a
> > D3hot->D0 soft reset by calling cxl_restore_hdm_after_pci_reset(), so
> > export it to the CXL namespace. While here, correct the resource.c
> > include of the CXL PCI definitions from <cxlpci.h> to <cxl/pci.h>.
>=20
> Why?  + if this makes sense (I haven't checked) please make that a
> separate patch (for now) + make sure to call it out in review of
> Srirangan Madhavan series where this file comes from and which hasn't
> merged yet. I think it is in patch 5.
>=20
> Jonathan

Hello Jonathan,

My patch series is dependent on Alejandro's v30 "type2-device-basic-support=
" which
moves the CXL_REGLOC_RBI_COMPONENT from cxlpci.h to cxl/pci.h; this series =
is accepted
but not yet available on the commit I tested/sent current series.

This should get resolved when Srirangan rebases his code to kernel latest.
I will drop this patch once Srirangan updates this in CXL-Reset series.

I will also update on Srirangan's series regarding the export symbol.

>=20
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/cxl/core/resource.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> > index daa5e7fa2509..492ffe8e3576 100644
> > --- a/drivers/cxl/core/resource.c
> > +++ b/drivers/cxl/core/resource.c
> > @@ -16,7 +16,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/slab.h>
> >
> > -#include <cxlpci.h>
> > +#include <cxl/pci.h>
> >
> >  #include "cxl.h"
> >  #include "core.h"
> > @@ -850,6 +850,7 @@ int cxl_restore_hdm_after_pci_reset(struct pci_dev
> > *pdev)
> >
> >       return cxl_reset_save_restored_state(pdev, command);  }
> > +EXPORT_SYMBOL_NS_GPL(cxl_restore_hdm_after_pci_reset, "CXL");
> >
> >  static void cxl_hdm_range_context_init(struct cxl_hdm_range_context
> *ctx)
> >  {
>=20

