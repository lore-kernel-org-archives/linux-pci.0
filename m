Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B329405;
	Thu,  9 Jul 2026 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783558127; cv=fail; b=rNvZJRcjCRSFtAVkupvssCw4pfkbLJS+fFeh4zwJ8Ct6oU6Bh3raEBwNAL7HnHR7uE85qRKaC1yugT37QsCuedUim1gx7YGvHSg205QpzbXob4tIPFCRZmq4e/f1FNcSRlgdZrZJTWjvM0M6fkrg071N70nPceCTDRIYmP5GSds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783558127; c=relaxed/simple;
	bh=qLjolRpVYlxajorhbehHixLAYAqPixDpz15/E2zmz7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s7RiVn9VyLx/moiBCIwqeIqQV5PDlWzn9/phMvg7PHFHj9Ed/ImRdXO4gbDFqQ0fQmSEDTDb4lm/a8fGaYUsxjLUEj8YG2HAHKWWRj51gYly3VYSLcqByyjFccEN0CHKz2hZmpAgSbCRQbIQ1KHSTOIEvRqwQ+vzzHYB6Z01EXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=drZhuwkF; arc=fail smtp.client-ip=40.93.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="drZhuwkF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfFDcZR0nCTSuyW53gJZIsa6hcbPuFb6MrL1Pi5nTNn0qWJKM6n+t1iNtk4Y7ZosFi7lXemZonysMmkpHYnvvV1GntdDOERMdnEoSPsmP5vYaEtjdDIADtfGbSKh4yfTHSVKBHNA5KbV3DsNTWjHS4g3kdBRrvA/sRxo/0qthRHNjNgDM+uqIAHOSyDJ9qzCj4eRTh6fv53S9onLAjKsFSGwzExIDmbkkGGZBsRTXvXz7dcwCxhDaBVuce5k384wHrFOZG8stJgevFo6krB+pqfemK0Yw9azaKa/IyR46hGdmQk8wU5gZI29sCIJiYdlLu1FGGDC4+dnN/rTyc5jXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIib3e9MdBuSYL1RbrWyhDv+7yymrHt8pZ3JNou4/RI=;
 b=bRNVaK8ahpaN/oQW0R5/sgRwai/RONwNv+jmSasX/7gGk2YzGV7ZvHvTzJRNp6v8HQB5lHg7P8GUHtbv7LJPMOj4F+/buL98FucxXSD/g6yFkR1LMJlApizq1HTtCZcIZaSW14K5eIby1A9WzeI3OTZlxHBXqT05mP32tTq3uIu0JpTiG5VNsOeb5judLBFN8fIavqp54YWBuHKoOTNymXX9wRYKG88rAvp7k6J/M4V3U02JgXo3nMSzvOYlTnvdOzKOhfK0EVxHSWPgVl8MN0nhTWcvU9znQRRWNkTWji6ehsP0ieZf8AscLhq1AXBnPvFT7AwicbXRDvcg2lgyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIib3e9MdBuSYL1RbrWyhDv+7yymrHt8pZ3JNou4/RI=;
 b=drZhuwkF0Db+C04bztxgPUBslYQiiV6xIxsCxDPdjuDnpmG71cL/olf2Lg/p+COQ34iko0nBC4AFN9hIw4ahgPAqI84xiG1E+Tg4tgKff3u9T8ODnq7TdVAE0bDWwT/tabwyw1QB8GegpvosbBIOKHFT1//9EmdCh7oGlGtXz5GhnCEVj7B9EuK4S8uN9VgbS7KNqw/eZIVJ7iwBiWHKpOdVkiPg+LBv2z0IdBq8jg/oFZ1wDzzRSIQ9zGfToVf1so1azOEJA2hWQ6NENPNiE7Vl7k6B4BeLbiCiw7fRTM/Sr9OkhPKP/Pl3tu+O8iSFIIU8QSAUzuM96CQ/50VPVg==
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 00:48:38 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 00:48:37 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Dan
 Williams <djbw@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny
	<ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Vikram Sethi
	<vsethi@nvidia.com>, Alex Williamson <alwilliamson@nvidia.com>, Dan Williams
	<danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v8 01/10] cxl: Split decoder programming into a reusable
 helper
Thread-Topic: [PATCH v8 01/10] cxl: Split decoder programming into a reusable
 helper
Thread-Index: AQHdCzgGyGml2nudTUSSRIWiu6VIc7ZhNuqAgAMrP18=
Date: Thu, 9 Jul 2026 00:48:37 +0000
Message-ID:
 <DS7PR12MB947497C2280C5ECD79F01790C3FE2@DS7PR12MB9474.namprd12.prod.outlook.com>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
 <20260703220508.546528-2-smadhavan@nvidia.com>
 <b7e43392-acdb-47d6-a4ba-45f319551b15@intel.com>
In-Reply-To: <b7e43392-acdb-47d6-a4ba-45f319551b15@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9474:EE_|DS0PR12MB8017:EE_
x-ms-office365-filtering-correlation-id: bfdcd370-3b57-42cc-824a-08dedd53d036
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|4143699003|11063799006|6133799003|56012099006|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info:
 JBwT2bkwhRmJsvj+PNiTj7KETobXlpbsiyfBYyOS+VA01pXwcYssV0afwxaOMiVE7z/CzLhijcjjquPg6Q/xM2LXJ4BZ7c1KlWWXtBrceZ0jRxJN51f9ysNLGj5dQgPv9frtNmZta2Iug0mXH4n/kxcdAj5PvneohzHF6gAdYRBT/VzV2li/GIE2i5mAul2T0+vgFjhapHLTOqh5SFC01cg0dnn8uPYYbHQTi+SWSbUAj5KbGKDjw4uWkUgsmpOk9/nuSZ65n97wrpRZkw46STmOgblmr6IS8mMDjMaRcQODwW2ZaFaxAf7Cwgzmd/7NcyAyDMnhk6Ag//zo+K5F69x4S1Hi48iI/KrvcUQFE2xQcxXUBNuCbMkCxToV21TJwxh+Qo26z8yDCj55xLlbrGIWr4TePsx/S/4Z/c89un9oU18EsMbXISxJJBxuwH5JQzcUcjzAh8/CHl8ZoeNmCv/4sjzgb1oVHZdhuOIzkY0kvjj7n6dmdaeR0KZO1GbF7WUXY5olSgkP/Ommtr/Q3jYRQ81dc9bZmlB+IOzXQRSOYxI/ptB9cShshPVKsz24CoXLSaVzs1AR3r7j6JOLjQxOx1/D2ynAbYefBBCjIgMB5WA1pzRJ5TzI+0PTgHXNugZgqA4thlZztGO2EmCWYDPJapzSdjgqiwM11biDCs4cDbGlktyFg8JACEnbzlQTHcWKFs0nG+sM0sCPZCyPRHyDXKzCx0fnH99w2McRGRRWoqFG6zFt/HeHQ4k2gfdY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(4143699003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7xZZl4ftkxEEZC5xA0uvaoNdUeGG23z+Tmmpv51vppSBfACJMg2dY3DD+5DL?=
 =?us-ascii?Q?u7Q44Y/BuV8tBoYgqdktIvG6kujbFU2mE5xQGJRruxNhEb+KQpS0daLcU7xC?=
 =?us-ascii?Q?9ELXjALHygs6lszMlblxvLDYayXvaw8e60I00RSvanrhl207tudqwpSQHqJk?=
 =?us-ascii?Q?XQPK+FDbttzK+6gcaHBsusx96SPFb13qxwuvdCwraXbBjwUJH6asPFv0CNjH?=
 =?us-ascii?Q?OKU+GqpcgHSRkCiThsE+aDWKGO4ARf/8Hlr45MELNGXa6E0fxrily2cCobfk?=
 =?us-ascii?Q?Ki9a51ySfU7H/PJh+1XkgtDRABUFCKlMgON0JVQGYOFV2bYnr/wa4YjuFkKA?=
 =?us-ascii?Q?uKbTzyp1f1jF/N5KupEMxM3uduyPw2LKtJVfmca28p3f9okveJ6bGQT7mBcU?=
 =?us-ascii?Q?wpJ9Yr7jwzyhIHy2SpFqlRthkfEQnzfTp5x5G26QhLAoZ+GSuaPJKitGEp44?=
 =?us-ascii?Q?Yw9ajkN4Rtv2oV3cWELkfhxSQdHGedGuftix9PQuW6xcPGK/x9SNhyqf0nB2?=
 =?us-ascii?Q?AAbId7gbmOvDSCQl/D6J667+G9bwNVB3ecX9zhFVAyvo6MPc3TwD+idBfuty?=
 =?us-ascii?Q?2F+cxMz1e5EBD3keQSUft2W3KWoA/x50UnrJSDDdXtacu3UI4mAjwSFSVXCW?=
 =?us-ascii?Q?O0YOzjAwkc8gXf+Zrd6F3ZUvoBtEVE3EJY97I4GsXsX34CACTZg2NGxBJy3j?=
 =?us-ascii?Q?zl0SCMK4y4Z8O5zgJHJ7aj/qRhnIFFyNvF6h8F731wqkQzHrFk+ec9cl2i6F?=
 =?us-ascii?Q?mPrL9WGRFEpTqChJ5LHzJM2CuRTLiGmTuoLii76eTJ0tiot8XElkgeLNN3Wl?=
 =?us-ascii?Q?S3q7xgd5U5xGgQu4kRFfsYcCc3z1CyPbyaHLIyxxtKSMKEsMGVy8KXNn6ODd?=
 =?us-ascii?Q?1LF0NOUeo9wERKKjMer3EX/B+V8KTrSrNbj/enEW/vbRnWN/IPlGEn8XCUnm?=
 =?us-ascii?Q?4RiZjiQAe/xkB8Kz8v9tvmoXSYQ2pC1CKyJ+Ijen57DWyhoy/pp8LdmaNRBL?=
 =?us-ascii?Q?UO8P/W2RDD+6y3ooP/PRSsnptMmUqV5AmesZJXwHaTyxws6yMbIspeHMjYOF?=
 =?us-ascii?Q?5dbRysHVfYffiAQkxryy92Xm2YIpN8scDLmDIEcdU+TausZPTVprKSFxzHcU?=
 =?us-ascii?Q?a5Vrcgk2ZstCFitZrkg2XJpx+QP35ctt4MFtm0WWBU1rQiL8oinwvSIu6yxx?=
 =?us-ascii?Q?aSLcWIAfrrkL4UOEw9XWtTLmlt8B5KspTWQo+4g61pwcEwlcNNUXVLCu6Mgb?=
 =?us-ascii?Q?hVngcarHWkFta1YbrR4bTtN2q1XmJpi10pvpekINt+hp5E5xANLp68xnoSQ3?=
 =?us-ascii?Q?MfDXhGONwBvjPEM9b0u/ql2DuiXPN0DgAsvfDRfXDG1HsDSsGBL0j7Ty3ZSE?=
 =?us-ascii?Q?QgWqyhyCsRahgA6YXhApadA3cMetPOBC4h6ZNRiGYiIASk3Qck0fyfwhvsZK?=
 =?us-ascii?Q?Gr8xXr+wl6lnxNh614zUlOrWJZN9rdK8WVohMFzym89fiK4aF0FnNEkw0NE9?=
 =?us-ascii?Q?OXeACr1TY+4C+Q6TXk336mDdZ8KILx9lt1xhV80rUuW1GknRYUdsH4aOM4f9?=
 =?us-ascii?Q?biRLzB9HFU1faPnIK53NZNup077gXCz8qsSl/PmRLnRTe1MIB443BQalOXsP?=
 =?us-ascii?Q?tlkTq9sEcZD5X/SyHifwwvSEvLe/jFxDhwevhS4oi2/PuS2O3QvzyaI/Tq+T?=
 =?us-ascii?Q?bUbI7MEs6aX7LyErKnKE073rllcyqLUxnbtycueMpxgVg9xH?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdcd370-3b57-42cc-824a-08dedd53d036
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 00:48:37.7828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhFQw8qtxCU2giSjTuCXuaf/ifIK+oPEscDq3jOWea/PrKDs6Be5V9Nd0bMIRQVIAgRpZ+GOT9qzThJlHoYRFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017

> Maybe this patch would be cleaner to review if there's a prep patch that =
move things that needs to be moved without the additional
> changes as well.

Agreed. I am keeping v9 focused on fixing the patch application/threading i=
ssue, but I
will split the movement/prep from the behavior changes in v10 to make
this easier to review. That way I can gather other comments along with sash=
iko issues and address them.

________________________________________
From: Dave Jiang <dave.jiang@intel.com>
Sent: Monday, July 6, 2026 5:22 PM
To: Srirangan Madhavan; Alison Schofield; Bjorn Helgaas; Dan Williams; Davi=
dlohr Bueso; Ira Weiny; Jonathan Cameron; Vishal Verma; linux-cxl@vger.kern=
el.org; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
Cc: Alex Williamson; Vikram Sethi; Alex Williamson; Dan Williams; Sai Yashw=
anth Reddy Kancherla; Vishal Aslot; Manish Honap; Jiandi An; Richard Cheng;=
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v8 01/10] cxl: Split decoder programming into a reusabl=
e helper

External email: Use caution opening links or attachments


On 7/3/26 3:04 PM, Srirangan Madhavan wrote:
> Move common HDM decoder settings to include/cxl/cxl.h and route the
> register programming sequence through cxl_commit(). This lets reset code
> restore cached HDM state without depending on private cxl_core types whil=
e
> keeping hdm.c in charge of the existing commit policy checks.
>
> Build the low-level HDM helper under CONFIG_CXL_HDM so it is available ev=
en
> when cxl_core is modular.

Maybe this patch would be cleaner to review if there's a prep patch that mo=
ve things that needs to be moved without the additional changes as well.

>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/Kconfig          |   4 ++
>  drivers/cxl/core/Makefile    |   1 +
>  drivers/cxl/core/hdm.c       | 122 ++++-------------------------------
>  drivers/cxl/core/region.c    |   6 +-
>  drivers/cxl/core/reset.c     | 118 +++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h            |  43 ------------
>  include/cxl/cxl.h            |  55 +++++++++++++++-
>  tools/testing/cxl/test/cxl.c |  10 +--
>  8 files changed, 197 insertions(+), 162 deletions(-)
>  create mode 100644 drivers/cxl/core/reset.c
>
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 80aeb0d556bd..87d719ea1e14 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -6,6 +6,7 @@ menuconfig CXL_BUS
>       select FW_UPLOAD
>       select PCI_DOE
>       select FIRMWARE_TABLE
> +     select CXL_HDM
>       select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
>       select FWCTL if CXL_FEATURES
>       help
> @@ -243,4 +244,7 @@ config CXL_ATL
>       depends on CXL_REGION
>       depends on ACPI_PRMT && AMD_NB
>
> +config CXL_HDM
> +     bool
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ce7213818d3c..dc075cee0450 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) +=3D cxl_core.o
> +obj-$(CONFIG_CXL_HDM) +=3D reset.o
>  obj-$(CONFIG_CXL_SUSPEND) +=3D suspend.o
>
>  ccflags-y +=3D -I$(srctree)/drivers/cxl
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..fa978c297546 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -16,11 +16,6 @@
>   * for enumerating these registers and capabilities.
>   */
>
> -struct cxl_rwsem cxl_rwsem =3D {
> -     .region =3D __RWSEM_INITIALIZER(cxl_rwsem.region),
> -     .dpa =3D __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> -};
> -
>  static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cx=
ld)
>  {
>       int rc;
> @@ -255,11 +250,11 @@ static void __cxl_dpa_release(struct cxl_endpoint_d=
ecoder *cxled)
>       lockdep_assert_held_write(&cxl_rwsem.dpa);
>
>       /* save @skip_start, before @res is released */
> -     skip_start =3D res->start - cxled->skip;
> +     skip_start =3D res->start - cxled->cxld.skip;
>       __release_region(&cxlds->dpa_res, res->start, resource_size(res));
> -     if (cxled->skip)
> -             release_skip(cxlds, skip_start, cxled->skip);
> -     cxled->skip =3D 0;
> +     if (cxled->cxld.skip)
> +             release_skip(cxlds, skip_start, cxled->cxld.skip);
> +     cxled->cxld.skip =3D 0;
>       cxled->dpa_res =3D NULL;
>       put_device(&cxled->cxld.dev);
>       port->hdm_end--;
> @@ -388,7 +383,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_deco=
der *cxled,
>               return -EBUSY;
>       }
>       cxled->dpa_res =3D res;
> -     cxled->skip =3D skipped;
> +     cxled->cxld.skip =3D skipped;
>
>       /*
>        * When allocating new capacity, ->part is already set, when
> @@ -679,35 +674,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled=
, u64 size)
>       return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled)=
;
>  }
>
> -static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> -{
> -     u16 eig;
> -     u8 eiw;
> -
> -     /*
> -      * Input validation ensures these warns never fire, but otherwise
> -      * suppress unititalized variable usage warnings.
> -      */
> -     if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
> -                   "invalid interleave_ways: %d\n", cxld->interleave_way=
s))
> -             return;
> -     if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig=
),
> -                   "invalid interleave_granularity: %d\n",
> -                   cxld->interleave_granularity))
> -             return;
> -
> -     u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> -     u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> -     *ctrl |=3D CXL_HDM_DECODER0_CTRL_COMMIT;
> -}
> -
> -static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
> -{
> -     u32p_replace_bits(ctrl,
> -                       !!(cxld->target_type =3D=3D CXL_DECODER_HOSTONLYM=
EM),
> -                       CXL_HDM_DECODER0_CTRL_HOSTONLY);
> -}
> -
>  static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt=
)
>  {
>       struct cxl_dport **t =3D &cxlsd->target[0];
> @@ -730,73 +696,6 @@ static void cxlsd_set_targets(struct cxl_switch_deco=
der *cxlsd, u64 *tgt)
>               *tgt |=3D FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
>  }
>
> -/*
> - * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must=
 set
> - * committed or error within 10ms, but just be generous with 20ms to acc=
ount for
> - * clock skew and other marginal behavior
> - */
> -#define COMMIT_TIMEOUT_MS 20
> -static int cxld_await_commit(void __iomem *hdm, int id)
> -{
> -     u32 ctrl;
> -     int i;
> -
> -     for (i =3D 0; i < COMMIT_TIMEOUT_MS; i++) {
> -             ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -             if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
> -                     ctrl &=3D ~CXL_HDM_DECODER0_CTRL_COMMIT;
> -                     writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id)=
);
> -                     return -EIO;
> -             }
> -             if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> -                     return 0;
> -             fsleep(1000);
> -     }
> -
> -     return -ETIMEDOUT;
> -}
> -
> -static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm=
)
> -{
> -     int id =3D cxld->id;
> -     u64 base, size;
> -     u32 ctrl;
> -
> -     /* common decoder settings */
> -     ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> -     cxld_set_interleave(cxld, &ctrl);
> -     cxld_set_type(cxld, &ctrl);
> -     base =3D cxld->hpa_range.start;
> -     size =3D range_len(&cxld->hpa_range);
> -
> -     writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET=
(id));
> -     writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(=
id));
> -     writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET=
(id));
> -     writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(=
id));
> -
> -     if (is_switch_decoder(&cxld->dev)) {
> -             struct cxl_switch_decoder *cxlsd =3D
> -                     to_cxl_switch_decoder(&cxld->dev);
> -             void __iomem *tl_hi =3D hdm + CXL_HDM_DECODER0_TL_HIGH(id);
> -             void __iomem *tl_lo =3D hdm + CXL_HDM_DECODER0_TL_LOW(id);
> -             u64 targets;
> -
> -             cxlsd_set_targets(cxlsd, &targets);
> -             writel(upper_32_bits(targets), tl_hi);
> -             writel(lower_32_bits(targets), tl_lo);
> -     } else {
> -             struct cxl_endpoint_decoder *cxled =3D
> -                     to_cxl_endpoint_decoder(&cxld->dev);
> -             void __iomem *sk_hi =3D hdm + CXL_HDM_DECODER0_SKIP_HIGH(id=
);
> -             void __iomem *sk_lo =3D hdm + CXL_HDM_DECODER0_SKIP_LOW(id)=
;
> -
> -             writel(upper_32_bits(cxled->skip), sk_hi);
> -             writel(lower_32_bits(cxled->skip), sk_lo);
> -     }
> -
> -     writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -}
> -
>  static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  {
>       struct cxl_port *port =3D to_cxl_port(cxld->dev.parent);
> @@ -834,17 +733,20 @@ static int cxl_decoder_commit(struct cxl_decoder *c=
xld)
>               }
>       }
>
> -     scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> -             setup_hw_decoder(cxld, hdm);
> +     if (is_switch_decoder(&cxld->dev)) {
> +             struct cxl_switch_decoder *cxlsd =3D
> +                     to_cxl_switch_decoder(&cxld->dev);
> +
> +             cxlsd_set_targets(cxlsd, &cxld->targets);
> +     }
>
> -     rc =3D cxld_await_commit(hdm, cxld->id);
> +     rc =3D cxl_commit(&cxld->settings, hdm);
>       if (rc) {
>               dev_dbg(&port->dev, "%s: error %d committing decoder\n",
>                       dev_name(&cxld->dev), rc);
>               return rc;
>       }
>       port->commit_end++;
> -     cxld->flags |=3D CXL_DECODER_F_ENABLE;
>
>       return 0;
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ce99f0650764..00f79b4862cb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2954,9 +2954,9 @@ static int poison_by_decoder(struct device *dev, vo=
id *arg)
>       cxlds =3D cxlmd->cxlds;
>       mode =3D cxlds->part[cxled->part].mode;
>
> -     if (cxled->skip) {
> -             offset =3D cxled->dpa_res->start - cxled->skip;
> -             length =3D cxled->skip;
> +     if (cxled->cxld.skip) {
> +             offset =3D cxled->dpa_res->start - cxled->cxld.skip;
> +             length =3D cxled->cxld.skip;
>               rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
>               if (rc =3D=3D -EFAULT && mode =3D=3D CXL_PARTMODE_RAM)
>                       rc =3D 0;
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> new file mode 100644
> index 000000000000..14f024098e82
> --- /dev/null
> +++ b/drivers/cxl/core/reset.c

While I can't come up with a better name for this file, putting decoder bit=
s in reset.c just doesn't seem right. There has to be a better name to repr=
esent what's in this file. Especially against CONFIG_CXL_HDM. Maybe hdm_lib=
.c and CONFIG_CXL_HDM_LIB? idk....

> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2026 NVIDIA Corporation. All rights reserved. */
> +#include <linux/delay.h>
> +#include <linux/bug.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +
> +#include "cxl.h"
> +#include "core.h"
> +
> +struct cxl_rwsem cxl_rwsem =3D {
> +     .region =3D __RWSEM_INITIALIZER(cxl_rwsem.region),
> +     .dpa =3D __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> +};
> +EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
> +
> +static void cxld_set_interleave(struct cxl_decoder_settings *settings, u=
32 *ctrl)
> +{
> +     u16 eig;
> +     u8 eiw;
> +
> +     /*
> +      * Input validation ensures these warns never fire, but otherwise
> +      * suppress uninitialized variable usage warnings.
> +      */
> +     if (WARN_ONCE(ways_to_eiw(settings->interleave_ways, &eiw),
> +                   "invalid interleave_ways: %d\n",
> +                   settings->interleave_ways))
> +             return;
> +     if (WARN_ONCE(granularity_to_eig(settings->interleave_granularity, =
&eig),
> +                   "invalid interleave_granularity: %d\n",
> +                   settings->interleave_granularity))
> +             return;
> +
> +     u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> +     u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> +     *ctrl |=3D CXL_HDM_DECODER0_CTRL_COMMIT;
> +}
> +
> +static void cxld_set_type(struct cxl_decoder_settings *settings, u32 *ct=
rl)
> +{
> +     u32p_replace_bits(ctrl,
> +                       !!(settings->target_type =3D=3D CXL_DECODER_HOSTO=
NLYMEM),
> +                       CXL_HDM_DECODER0_CTRL_HOSTONLY);
> +}
> +
> +/*
> + * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must=
 set
> + * committed or error within 10ms, but just be generous with 20ms to acc=
ount for
> + * clock skew and other marginal behavior.
> + */
> +#define COMMIT_TIMEOUT_MS 20
> +static int cxld_await_commit(void __iomem *hdm, int id)
> +{
> +     u32 ctrl;
> +     int i;
> +
> +     for (i =3D 0; i < COMMIT_TIMEOUT_MS; i++) {
> +             ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +             if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
> +                     ctrl &=3D ~CXL_HDM_DECODER0_CTRL_COMMIT;
> +                     writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id)=
);
> +                     return -EIO;
> +             }
> +             if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +                     return 0;
> +             fsleep(1000);
> +     }
> +
> +     return -ETIMEDOUT;
> +}
> +
> +static void setup_hw_decoder(struct cxl_decoder_settings *settings,
> +                          void __iomem *hdm)
> +{
> +     int id =3D settings->id;
> +     u64 target_or_skip;
> +     u64 base, size;
> +     u32 ctrl;
> +
> +     ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +     cxld_set_interleave(settings, &ctrl);
> +     cxld_set_type(settings, &ctrl);
> +     base =3D settings->hpa_range.start;
> +     size =3D range_len(&settings->hpa_range);
> +     target_or_skip =3D settings->targets;
> +
> +     writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET=
(id));
> +     writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(=
id));
> +     writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET=
(id));
> +     writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(=
id));
> +     /* Target-list and endpoint-skip registers alias the same slot. */
> +     writel(upper_32_bits(target_or_skip),
> +            hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +     writel(lower_32_bits(target_or_skip),
> +            hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +
> +     writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +
> +int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm)
> +{
> +     int rc;
> +
> +     scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +             setup_hw_decoder(settings, hdm);
> +     }
> +
> +     rc =3D cxld_await_commit(hdm, settings->id);
> +     if (rc)
> +             return rc;
> +
> +     settings->flags |=3D CXL_DECODER_F_ENABLE;
> +
> +     return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_commit, "cxl_core");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f43abd1903ce..b433262ab256 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -252,49 +252,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, =
struct cxl_dport *dport);
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
>  #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_L=
OCK)
>
> -enum cxl_decoder_type {
> -     CXL_DECODER_DEVMEM =3D 2,
> -     CXL_DECODER_HOSTONLYMEM =3D 3,
> -};
> -
> -/*
> - * Current specification goes up to 8, double that seems a reasonable
> - * software max for the foreseeable future
> - */
> -#define CXL_DECODER_MAX_INTERLEAVE 16
> -
>  #define CXL_QOS_CLASS_INVALID -1
>
> -/**
> - * struct cxl_decoder - Common CXL HDM Decoder Attributes
> - * @dev: this decoder's device
> - * @id: kernel device name id
> - * @hpa_range: Host physical address range mapped by this decoder
> - * @interleave_ways: number of cxl_dports in this decode
> - * @interleave_granularity: data stride per dport
> - * @target_type: accelerator vs expander (type2 vs type3) selector
> - * @region: currently assigned region for this decoder
> - * @flags: memory type capabilities and locking
> - * @target_map: cached copy of hardware port-id list, available at init
> - *              before all @dport objects have been instantiated. While
> - *              dport id is 8bit, CFMWS interleave targets are 32bits.
> - * @commit: device/decoder-type specific callback to commit settings to =
hw
> - * @reset: device/decoder-type specific callback to reset hw settings
> -*/
> -struct cxl_decoder {
> -     struct device dev;
> -     int id;
> -     struct range hpa_range;
> -     int interleave_ways;
> -     int interleave_granularity;
> -     enum cxl_decoder_type target_type;
> -     struct cxl_region *region;
> -     unsigned long flags;
> -     u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
> -     int (*commit)(struct cxl_decoder *cxld);
> -     void (*reset)(struct cxl_decoder *cxld);
> -};
> -
>  /*
>   * Track whether this decoder is free for userspace provisioning, reserv=
ed for
>   * region autodiscovery, whether it is started connecting (awaiting othe=
r
> @@ -310,7 +269,6 @@ enum cxl_decoder_state {
>   * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
>   * @cxld: base cxl_decoder_object
>   * @dpa_res: actively claimed DPA span of this decoder
> - * @skip: offset into @dpa_res where @cxld.hpa_range maps
>   * @state: autodiscovery state
>   * @part: partition index this decoder maps
>   * @pos: interleave position in @cxld.region
> @@ -318,7 +276,6 @@ enum cxl_decoder_state {
>  struct cxl_endpoint_decoder {
>       struct cxl_decoder cxld;
>       struct resource *dpa_res;
> -     resource_size_t skip;
>       enum cxl_decoder_state state;
>       int part;
>       int pos;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 016c74fb747c..757d916a6330 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -5,8 +5,10 @@
>  #ifndef __CXL_CXL_H__
>  #define __CXL_CXL_H__
>
> +#include <linux/device.h>
>  #include <linux/node.h>
>  #include <linux/ioport.h>
> +#include <linux/range.h>
>  #include <cxl/mailbox.h>
>
>  /**
> @@ -23,7 +25,56 @@ enum cxl_devtype {
>       CXL_DEVTYPE_CLASSMEM,
>  };
>
> -struct device;
> +struct cxl_region;
> +
> +enum cxl_decoder_type {
> +     CXL_DECODER_DEVMEM =3D 2,
> +     CXL_DECODER_HOSTONLYMEM =3D 3,
> +};
> +
> +/*
> + * Current specification goes up to 8, double that seems a reasonable
> + * software max for the foreseeable future
> + */
> +#define CXL_DECODER_MAX_INTERLEAVE 16
> +
> +/**
> + * struct cxl_decoder - Common CXL HDM Decoder Attributes
> + * @dev: this decoder's device
> + * @id: kernel device name id
> + * @hpa_range: Host physical address range mapped by this decoder
> + * @skip: offset into @dpa_res where @cxld.hpa_range maps (endpoint)
> + * @targets: interleave position to dport mapping (switch)
> + * @interleave_ways: number of cxl_dports in this decode
> + * @interleave_granularity: data stride per dport
> + * @target_type: accelerator vs expander (type2 vs type3) selector
> + * @flags: memory type capabilities and locking
> + * @region: currently assigned region for this decoder
> + * @target_map: cached copy of hardware port-id list, available at init
> + *              before all @dport objects have been instantiated. While
> + *              dport id is 8bit, CFMWS interleave targets are 32bits.
> + * @commit: device/decoder-type specific callback to commit settings to =
hw
> + * @reset: device/decoder-type specific callback to reset hw settings
> + */
> +struct cxl_decoder {
> +     struct device dev;
> +
> +     struct_group_tagged(cxl_decoder_settings, settings, int id;
> +             struct range hpa_range;
> +             union {
> +                     u64 skip;
> +                     u64 targets;
> +             };

I don't like the moving of 'skip' from cxled to cxld just for convenience. =
It takes away of using skip intentionally with an endpoint decoder. Not onl=
y that, the type is changed. Same with targets.

DJ

> +             int interleave_ways;
> +             int interleave_granularity;
> +             enum cxl_decoder_type target_type;
> +             unsigned long flags;
> +     );
> +     struct cxl_region *region;
> +     u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
> +     int (*commit)(struct cxl_decoder *cxld);
> +     void (*reset)(struct cxl_decoder *cxld);
> +};
>
>  /*
>   * Using struct_group() allows for per register-block-type helper routin=
es,
> @@ -70,6 +121,8 @@ struct cxl_regs {
>       );
>  };
>
> +int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm)=
;
> +
>  struct cxl_reg_map {
>       bool valid;
>       int id;
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 296516eecfd6..4db5071aa25a 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -840,11 +840,11 @@ static int cxld_registry_restore(struct cxl_decoder=
 *cxld,
>               dbg_cxld(port, "restore", &td->cxled.cxld);
>               cxld_copy(cxld, &td->cxled.cxld);
>               cxled->state =3D td->cxled.state;
> -             cxled->skip =3D td->cxled.skip;
> +             cxld->skip =3D td->cxled.cxld.skip;
>               if (range_len(&td->dpa_range)) {
>                       rc =3D devm_cxl_dpa_reserve(cxled, td->dpa_range.st=
art,
>                                                 range_len(&td->dpa_range)=
,
> -                                               td->cxled.skip);
> +                                               td->cxled.cxld.skip);
>                       if (rc) {
>                               init_disabled_mock_decoder(cxld);
>                               return rc;
> @@ -882,7 +882,7 @@ static void __cxld_registry_save(struct cxl_test_deco=
der *td,
>
>               cxld_copy(&td->cxled.cxld, cxld);
>               td->cxled.state =3D cxled->state;
> -             td->cxled.skip =3D cxled->skip;
> +             td->cxled.cxld.skip =3D cxled->cxld.skip;
>
>               if (!(cxld->flags & CXL_DECODER_F_ENABLE)) {
>                       td->dpa_range.start =3D 0;
> @@ -970,7 +970,7 @@ static void mock_decoder_reset(struct cxl_decoder *cx=
ld)
>                       to_cxl_endpoint_decoder(&cxld->dev);
>
>               cxled->state =3D CXL_DECODER_STATE_MANUAL;
> -             cxled->skip =3D 0;
> +             cxled->cxld.skip =3D 0;
>       }
>       if (decoder_reset_preserve_registry)
>               dev_dbg(port->uport_dev, "decoder%d: skip registry update\n=
",
> @@ -1021,7 +1021,7 @@ static void init_disabled_mock_decoder(struct cxl_d=
ecoder *cxld)
>                       to_cxl_endpoint_decoder(&cxld->dev);
>
>               cxled->state =3D CXL_DECODER_STATE_MANUAL;
> -             cxled->skip =3D 0;
> +             cxled->cxld.skip =3D 0;
>       }
>  }
>

