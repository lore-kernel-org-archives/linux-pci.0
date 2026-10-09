Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26A43FD3F;
	Fri,  9 Oct 2026 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526500; cv=fail; b=fL/qPhuyGC+aKU5kFAMWm1v47yvxtNFlAi7ckomRkTM180egcNJj/GFgDYkPPV2wyy3r/LhdiwZ8asRJidJPW6R1ELqUvcSYib34p2RTO87I/r7VlAMR0rU82+H7f06ASuvC1CFLpAQ5vsnZTnRCSSuU1rYjHWn3fwQ1nTOsvz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526500; c=relaxed/simple;
	bh=xAYeNwkap59FzbKzFKlJKWRkjHHKb4c0jDVgwJh129Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ezn6lD4JC2A27oXJLTTabMQbZ8RhQ5dQAhmKWQagMW0zJSAQ/c5oGEOJYwiFjOq5LV4rJd4w4eDVJ5IiQa0OvXQwN/bzbhjqkmdYE22rCMicqkQot+H1vq8zVCahwYjo9akJlTWs4ePZ136zsHYnMbxA0GW5blKv9ic3FmIVPB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rjsmw1fE; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rjsmw1fE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoEI/uA9DcdpEe9+ULX0L1+xOwEOkCYlpqkn8dsTxbdM1+JOAU3WUAwPkM6CGfDxzaOA2jrHAujgFf8MxzImStdZaswJck/Ess9Ou0SK953w4QboZ8kvuZ46Rl25fmxZKcHZ4NGDFBo/r0uEYpBPgiSWJy19CduiwPR5kfe/0vhJOCExHxCkbqktSaUZTRpbKs3sKDkJbUcpov/66yI8B9XxyNyqJYbISjK3wI0ZcPHee93+N7JxvanzdTpr33om1liADzVe0wBc3Sh3BEZdcjVSvUfBmN85Lz0PkqkfbNyeSQ8ElJmYS2WGyB3CVfqJ6yDUFiahSPr92BoXDhINUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NcdvU3DABDEAvR0EHCRG/kdTdNeoj/Ivn2lyOHvpDE=;
 b=HBpzbBbjWfKp23Y/wKW+yQk9rZ0yaTlO1AMoRd47CGr96xRFv2ImpEIe6aiW+YUqxhiM2pSQE1r79xEA2Vnqt9o4ckLXt3UddfwUnDReg1Q0d8N8NyuGJFBjbIUbty7Cmq7WpeagqFzG4SJtv5OdoCl/H2lBG0HmVIbhvWp7w/ETXBiukTeB9J1dTTidFyN2k4BB0FVgqm1CLj0L8Saiy4ClTbvcf356YfX9t+4egDO13P9Q18GOBBhJMmHqIioAHpTER010p8iyNPPLetMCWAoYudYamyW2ZtvAIu3ZaggkPD8lhnfWw6l1oUkxMLVR+CyIL/wzo4PpSYNiGoAo8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NcdvU3DABDEAvR0EHCRG/kdTdNeoj/Ivn2lyOHvpDE=;
 b=Rjsmw1fEh7aEgZxwBFcdDMj59c4H/qixPqRwt/zl/pyrab9dxs1qsFKWb61Zjeu0mjeoSJ1TXMULRQc0y1Qni/qLUkkAMfrLnK2j5xSNUH60c3bAWr9YIpPKDdFQ7M8digprXsc7Xa65s87vCI2Q0wphXEvvCh+RIg299p3mKfccYSsN6N4odG3QQKNq9FLb7QR2jI1FKaYjhNP49vyP/CULGPoJdD3ZxIZUPe8dZTFGf/xC6CMy2tTjLsiv85Gjq7hsWmhmJ2LUB1W4MWY8UNwX+MX6c4l8EboAi2+Ww7C+LxnoAZ74FC0XM6KRiLzOXU7tD8kTVLv4WT2F93HCNw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:50 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:50 +0000
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
Subject: RE: [PATCH v5 20/27] vfio/cxl: Expose the HDM decoder registers
 read-only to the guest
Thread-Topic: [PATCH v5 20/27] vfio/cxl: Expose the HDM decoder registers
 read-only to the guest
Thread-Index: AQHdRgq+nP/qPuDjJk6TDKrCL3qGmbbZ4/IAgBrxPSA=
Date: Fri, 9 Oct 2026 06:14:50 +0000
Message-ID:
 <IA1PR12MB9030572CA935EA06491F675ABD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-21-mhonap@nvidia.com>
 <20260921201354.05da09af@shazbot.org>
In-Reply-To: <20260921201354.05da09af@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 13cf471d-4809-4b04-5f24-08df25cca094
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|18002099003|22082099003|10067099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 GIiUFZXxIINCHCkP1Ck1Tm4q0M+DLaOaw54A1ffWLPzKFmTr9LN1c7OUTKX3qv+mnF931H72968qgbB1OhsYO2WY7I54+yXAeGghAwgwufbR8TYC3XTjyuDfByFl7+Bc5AzxMtHMDn1u93aQJm0ljTcVzfK5iE5bcbHBrmv50v3lI1LJJA+l1i8EV3MYmbjuazL+Y84ltrccfJMa4V1owkC0dckGyhH16OmOYm7KcAM9y9aPG9RAWKzSPFMmP3gF3w7LihCsqqW/JVLIJtAkeqT1bvtufB+B85OkIogkNuYFbxy4Gx+6ftzAwKIPR9K3FY+/BdMNayQJi/MDqsN8R04MUNO8uY5Vf7fnIij0krBTvH7f3ViOvvtMmQ/so7eOJB1E4vYGUjfWQxIWK7FqW7XU/EyMXwwaL3XPqFHGN04NPfjoeLAKVuIB8uPsRJy5MR5yDcMgXNACtjlH+lOxPeTHncRDr/YqlAdQjVWuIs8lhgR1UmkU7EwmImyQO4/9QX8zvGB0MT2bVutlHJjMT7q/FjQgPv4pYwjt2iFn5EI/oiLARUhfEd0FV/vy5KeEjkoNb1QiOlFywrvJ3AIuChr8P6E8VEHKdROrqvtWrIhAbg2aPDx3PiDF20dS8bTaKA8jdiaAQBOr++wbrEsjszp7uRll1N1aBGvfJ22mu6TVao3x2Q3RyLDsKUJar4mW3z1Zyff/XZDWrUy6JM7KRirZ2hlv2ovAqbs7/HJvWKg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?B35Xy1IL+5rse3xTIF42cdPesQuV/oqpoPPkKBL4v0fCdYmeHnvDqaV4/fki?=
 =?us-ascii?Q?PCt66i/DUiXSr3pe7zBuuD398nmlqOe+e5ogxDzegeOuPI3PLrtcdklWfIhA?=
 =?us-ascii?Q?x35igB1FSA8+WDaYdfGNn032UgD/JDLSx9GyyjSA3zG6vBHvdy1cz9pOlrqS?=
 =?us-ascii?Q?Rn5QGgCc7ACWDPhpQSyUJ160btLHjUxVjEt7qtcqZ71FpXl3wT1CKEai6tW6?=
 =?us-ascii?Q?e26cWJzvnwWxod5rMRFjQi+9dsJbyzym7/we0OqzqkXtHnEO1oaXQR7rX7RH?=
 =?us-ascii?Q?kFt0+twUyR+aSZkJ6Mwhuo/t9GJ8SU2QYyYgL2TT8ZchVVrcHbc/fC0ayS5j?=
 =?us-ascii?Q?AwsGSRMZgv9YX+uzqbDDdlTrk692a8NnuMRGnJ4ReBcP2Kh0O/ByrRdXH/mo?=
 =?us-ascii?Q?EChgDlr5MB5adDeuHc8TFL5QSsLz+StyBmGVQF0hD3uXA2FnSoydPJzOiBvK?=
 =?us-ascii?Q?sGzr7wrlLiQUdbDiiEgqP1l/TEkYdcLzbnSmuGTs30y2vM3Yr/kCTS3QnTN4?=
 =?us-ascii?Q?o97ZE9acLUDIpEAn9baQdj57bBmmPV/NfqaKx62jqUU2duuVtTk8RO/oRxBg?=
 =?us-ascii?Q?v0F/S3co3kYOi4aRu2gcLjcS9E/5e6VebouhIsMrNy6hzoEr2c+zE1S/aRuE?=
 =?us-ascii?Q?lPLZpt2cgMSs0LpmnypC2+sSXOARjOMZ1feCLQUJ43aWLPEbxcbazEADlrCd?=
 =?us-ascii?Q?OH34n5SrrqdxFywt8bG6xy4BJ3G0MeCTq1KpRH2gmpL9Hgl4K9SbcGeS2c3w?=
 =?us-ascii?Q?MHSIpa196w7TvpE7gN6/Xfp8BqFSYUgjQdLX+ry1FXsvNFOCPqJutJ19gFfs?=
 =?us-ascii?Q?7XB9NFODaTyiXdjsbNF8GhqBjq0dBT3vqXkiuTWhcRQpPhxrnb99/zB+sRWl?=
 =?us-ascii?Q?UZC+SUTL2gTHfp+pM5PRR/TfBWUdBdjgIh3OeFRRadJGKsftMggrYypKbZ6S?=
 =?us-ascii?Q?ljlci+BD+53xxm5Ysv+9jcG2EItoK5P80ixEZ0OYJUXc0FrZAyWlfA3sgSwO?=
 =?us-ascii?Q?5m1NEB/uBVGVo02dm2LAKqM85pvH9/vopAPxv/eIvDyxU5fTPT2Ktm4bYfbm?=
 =?us-ascii?Q?09xct/GJI+RLOBs2wFbHIPUBQT4yHVrfivRa7VHpNLvVkxYfNZcgOOeMy0GK?=
 =?us-ascii?Q?OoFLDuicLf2Vwkq3NEw63UMDCbRF29YeMA1DmGnEK/EpQRKvV72IYUV33C6o?=
 =?us-ascii?Q?sN0uKKhxhWnfwZ59/rcOl6NqjrhVnkpfR2amLRzy5CM/nBdsavIrHkgKc0gW?=
 =?us-ascii?Q?Un6DBpoIEy4rhG1OCk1O3pfSSvv+YoE5leA5jZd8mdSFA5XPyJ5nFOPafyTj?=
 =?us-ascii?Q?ZeQLu3boAutK+nLIQQU6V0Z0klXUDasYmxW8gT1cF6xFranPnacN4wyomLw8?=
 =?us-ascii?Q?jJ0QODi6FgJiD1XQzU0fbgTm2BMBAdR/DKMkkPVpIOuVaARihGCqGzdH8jKi?=
 =?us-ascii?Q?ID0t+IoiSvGJIC/WMp95eJ/tdz9aSW0fJzm/pgRot6OTsAT/BgEH6UFWD1+X?=
 =?us-ascii?Q?EmTgcxY5nW6589JK8ZkNSM3ZzLtpkS2bAyzIVR2cGeY6S56kPEydKJiuar3Q?=
 =?us-ascii?Q?SFm6XIWxgfmQIgYA8IaIV3DrRlTSNBEvT8AF7BEzCXvdwQZRlkK1SPL9AvPz?=
 =?us-ascii?Q?DUq7sOVDSrSkU5me3S67/MotfXhVpIPQmasyfpFxMoAU7VXCCe2yyuJbiFqR?=
 =?us-ascii?Q?YzXD1vR5ZU2Z1TsU3xR5YDmx+h//9KuUmRXuWdkg/jlDBXHf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cf471d-4809-4b04-5f24-08df25cca094
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:50.7029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HuNoiFqLRGt+qkkcW8xwG31G0Aok5fq77zYv1xLER0GGK+DvX6IpYVpbZnm5hFRMq2GsCXMMKM6o0emfkGp1og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912


> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Tuesday, September 22, 2026 7:44 AM
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
> Subject: Re: [PATCH v5 20/27] vfio/cxl: Expose the HDM decoder registers
> read-only to the guest
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:33 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A CXL Type-2 guest reads the HDM decoder registers to learn the HDM
> > region it was handed. Those registers live in the component BAR that
> > vfio-pci owns.
> >
> > Map the decoder block at bind: its location comes from the pdev->hdm
> > enumeration cache, and vfio-pci owns the BAR, so map it without
> > claiming the block and expose it as a second, read-only region under
> > VFIO_REGION_TYPE_PCI_VENDOR_TYPE with the CXL vendor id, registered
> > per open like the HDM memory region.
> >
> > Serve reads live from the mapped block and absorb writes without
> > forwarding them to hardware.
> >
> > Registering a second region is the first point at which an open-time
> > failure must unwind an already-registered region, so add
> > vfio_pci_core_unregister_dev_region() to drop the most recently
> > registered region, and use it to unwind the HDM memory region if the
> > decoder region fails to register.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 81
> +++++++++++++++++++++++++++-
> >  include/uapi/linux/vfio.h            |  2 +
> >  2 files changed, 82 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index e099e9a70a5a..da04776356e4 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -24,6 +24,8 @@
> >   * @cxlmd: memory device joined to the CXL topology at bind
> >   * @hpa_range: host physical range of the HDM region
> >   * @hdm_pfn_space: HDM-region pfn range registered with
> > memory_failure()
> > + * @hdm_regs: mapped HDM decoder registers, read live by the decoder
> > + region
> > + * @hdm_len: length of the HDM decoder register block
> >   * @hdm_valid: true when host CPU access to the HDM range is safe; und=
er
> memory_lock
> >   */
> >  struct vfio_cxl_state {
> > @@ -31,6 +33,8 @@ struct vfio_cxl_state {
> >       struct cxl_memdev *cxlmd;
> >       struct range hpa_range;
> >       struct pfn_address_space hdm_pfn_space;
> > +     void __iomem *hdm_regs;
> > +     u32 hdm_len;
> >       bool hdm_valid;
> >  };
> >
> > @@ -212,6 +216,56 @@ static int vfio_cxl_register_pfn_space(struct
> vfio_pci_core_device *vdev)
> >       return register_pfn_address_space(&cxl->hdm_pfn_space);
> >  }
> >
> > +static ssize_t vfio_cxl_comp_rw(struct vfio_pci_core_device *vdev,
> > +                             char __user *buf, size_t count, loff_t *p=
pos,
> > +                             bool iswrite) {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     loff_t pos =3D *ppos & VFIO_PCI_OFFSET_MASK;
> > +     void *tmp;
> > +
> > +     if (pos >=3D cxl->hdm_len)
> > +             return -EINVAL;
> > +
> > +     /* The decoder registers take only aligned dword accesses. */
> > +     if (pos % sizeof(u32) || count % sizeof(u32))
> > +             return -EINVAL;
> > +
> > +     count =3D min_t(size_t, count, cxl->hdm_len - pos);
> > +
> > +     /*
> > +      * The host committed and locked the physical decoder before the =
guest
> > +      * saw the device, so the guest never drives it: absorb writes wi=
thout
> > +      * forwarding them to hardware. The guest programs a GPA that the
> VMM
> > +      * virtualizes; reads return the live registers, which already re=
port the
> > +      * decoder committed. BASE_LOW and BASE_HIGH carry the host HPA,
> visible
> > +      * only to the trusted VMM that virtualizes it away from the gues=
t.
> > +      */
> > +     if (iswrite) {
> > +             *ppos +=3D count;
> > +             return count;
> > +     }
> > +
> > +     tmp =3D kmalloc(count, GFP_KERNEL);
> > +     if (!tmp)
> > +             return -ENOMEM;
> > +
> > +     memcpy_fromio(tmp, cxl->hdm_regs + pos, count);
>=20
> There's no memory-enabled gate on this access to mapped BAR space.

Right. In v6, the read will take a memory_lock and return -EIO while memory=
 is
Disabled.

>=20
> > +     if (copy_to_user(buf, tmp, count)) {
> > +             kfree(tmp);
> > +             return -EFAULT;
> > +     }
> > +     kfree(tmp);
> > +
> > +     *ppos +=3D count;
> > +     return count;
> > +}
> > +
> > +static const struct vfio_pci_regops vfio_cxl_comp_regops =3D {
> > +     .rw =3D vfio_cxl_comp_rw,
> > +     .release =3D vfio_cxl_region_release, };
> > +
> >  static void vfio_cxl_release_hpa(void *data)  {
> >       struct vfio_cxl_state *cxl =3D data; @@ -299,6 +353,21 @@ static
> > int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
> >               goto err;
> >       }
> >
> > +     /*
> > +      * Map the HDM decoder registers so the decoder region can read t=
hem
> > +      * live. The block location comes from the enumeration cache in
> > +      * pdev->hdm; vfio-pci owns the BAR, so map without claiming the =
block.
> > +      */
> > +     cxl->hdm_regs =3D devm_ioremap(&pdev->dev,
> > +                                  pci_resource_start(pdev, pdev->hdm->=
hdm_bar) +
> > +                                  pdev->hdm->hdm_offset, pdev->hdm->hd=
m_size);
> > +     if (!cxl->hdm_regs) {
> > +             ret =3D -ENOMEM;
> > +             goto err;
> > +     }
> > +
> > +     cxl->hdm_len =3D pdev->hdm->hdm_size;
> > +
> >       /*
> >        * A Type-2 accelerator has no mailbox and no media-ready registe=
r, so
> >        * set media ready directly.
> > @@ -381,6 +450,13 @@ static int vfio_cxl_open_device(struct
> vfio_pci_core_device *vdev)
> >       if (ret)
> >               return ret;
> >
> > +     ret =3D vfio_cxl_add_region(vdev,
> VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
> > +                               &vfio_cxl_comp_regops, cxl->hdm_len,
> > +                               VFIO_REGION_INFO_FLAG_READ |
> > +                               VFIO_REGION_INFO_FLAG_WRITE);
> > +     if (ret)
> > +             goto err_unregister_mem;
> > +
> >       /*
> >        * The HDM region is advertised mmap-able, so a fd holder can fau=
lt its
> >        * struct-page-less device memory in from the host CPU. Register
> > it with @@ -389,7 +465,7 @@ static int vfio_cxl_open_device(struct
> vfio_pci_core_device *vdev)
> >        */
> >       ret =3D vfio_cxl_register_pfn_space(vdev);
> >       if (ret && ret !=3D -EOPNOTSUPP)
> > -             goto err_unregister_mem;
> > +             goto err_unregister_comp;
> >
> >       /*
> >        * The decoder is firmware-committed, so host access to the HDM
> > range is @@ -400,6 +476,9 @@ static int vfio_cxl_open_device(struct
> > vfio_pci_core_device *vdev)
> >
> >       return 0;
> >
> > +err_unregister_comp:
> > +     vfio_pci_core_unregister_dev_region(vdev);
> > +
> >  err_unregister_mem:
> >       vfio_pci_core_unregister_dev_region(vdev);
>=20
> As noted previously, this is a bad interface, this is why.  Thanks,

Understood; These calls go away with the patch 18 change.

>=20
> Alex
>=20
> >
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 1bf86763c0f7..8927a7a4e8e4 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -373,6 +373,8 @@ struct vfio_region_info_cap_type {
> >  /* CXL Type-2 device (0x1e98) sub-types for
> > VFIO_REGION_TYPE_PCI_VENDOR_TYPE */
> >  /* CXL.mem HDM region of a Type-2 device, mmap-able */
> >  #define VFIO_REGION_SUBTYPE_CXL_MEM          (1)
> > +/* CXL HDM decoder registers: read live, guest writes are absorbed */
> > +#define VFIO_REGION_SUBTYPE_CXL_COMP_REGS    (2)
> >
> >  /* sub-types for VFIO_REGION_TYPE_GFX */
> >  #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)

