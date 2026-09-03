Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACFE47988A;
	Thu,  3 Sep 2026 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430293; cv=fail; b=poOSEtYZ/iEorD+whyS7YfKRogS+XEctp/6SlyvqC1zzvoetP6GEOe1r1l4bVNeLUlxg6+j+SkpfTR2D7gVHqjCzcvFK+5dQP69BTXVVKCHRaWruAcIRTew+q3BFcfQ3XAY+H0RxnbMdc5KbJ2OPbBN83hL0BieRiX+bpouPnuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430293; c=relaxed/simple;
	bh=Xu/OHEBJPsW4O1LmOq0FAPoTcaPzGLgIQrEkZp7QUVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q3p1/AjWWW4PDN5/p/yzrEfTG5oLq0RrmdRA/lViYtOkdJqlDUrn0gyj6xRb+8E01/shKVlhvP2rLBck6waWIbwAXnbLxBHg+ehSy7l3bASVWGDWM12CU970Y5QCWo0I1GcUkkhH6ZZxEgyjikEdsFBg+4BBflD8k+FohZ8EjQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cj1srA8E; arc=fail smtp.client-ip=52.101.43.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cj1srA8E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6L/EzYUr5pP4oWlZVYYoTihIhHWAfWaEavWe1zAkJ5FRc+9q18guVI+4EPfwO3rizFg43z+U9rGf6dpa/70GR+e4f+79lKW7c8PzAyfnhy9MlOowSeNxRswMmn2bWnpdbrkGzVC5a56eK1HWcdJS3NQIYOmMuhR9ofvadH82a1zAN4eAOUa2x8HICDcSta0YKdzdk6Uym1hbqpEDy7OvIkYxfUHTPTKMSVI8rXohvC0B5XFOWwirCVf+vbAEv3xe1CvuBz2ipiSgcgVDB6QhzyZIW6obVD9N3+rvvuzwm6xkSPckDTcwIhhWneLHz1l+TdNDdIvij972DdbH+iacA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WuJDyThjU7wh1QzpCnj2iQiV0no7y7a7XYPaVDZCQY=;
 b=Fq1jiEpxAUPWaQ/ILy+QFOuiwlIEyOGBvwgT+FbGA6rmWN93FzOG7Rjz0NVXPMmIbHEisuN6lwESbl0oefsxqgzMD/mjhXItIb6Z87vMhYZIfq6sF8cbArpJ6QGKy/o706LDhFIMl5MM8oSUPhUC9PvPfSHRboHTnE8kli1AndzKpm2k28S9h0ES+yV3JY5iQsJb+qVP1tlYSAP5kLZDC/J4BCHjdawSJqsUt7XbFUTyUO6Yg+9KXHmc0aS7AJ9anjhyhTXAReLaFbMuxt93iz5wRLRwd2Jgc7KsYw1Me7IS0Bdz2ArlrM8I+RQbFrdLJ6X5sRX8EFTNyA9fDFVTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WuJDyThjU7wh1QzpCnj2iQiV0no7y7a7XYPaVDZCQY=;
 b=cj1srA8Eld+G7g74Y8KX3FNhB3CpecBlyhFIjiU1Aw8ww7+qqnYc37OdsdDVhAV1evVJTmYmdJB3qoGeMxyL8hE/5Yavx9rzcFaAuHz9y9642hhGXkvCvjfT4EQa4DdBbTRKM44h+ynV7ogISIAQdD36JmRI4YMFDjgCBnFPceMxIUT9HaFaI3kArwZ7woD5sPDDqP9v8Y3TzUMuxIN7Z7+RtdX56BWcRKEW3ZYY9yRFvoaqExZGlFtbFtudUD0P+Kh8pmr395nDC31NhD7y/CgfZy7VcJ6TmJFozCvgpQhvMlyI6p7vaFfashso9Td4RUWFCZFo9wugDNshDLSYxA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 10:11:25 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:11:24 +0000
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
Subject: RE: [PATCH v4 09/27] vfio/cxl: Create the CXL memory device at bind
Thread-Topic: [PATCH v4 09/27] vfio/cxl: Create the CXL memory device at bind
Thread-Index: AQHdKweRTogn5Y3GpUO7lne11pDH+rayc2SAgAoaA2A=
Date: Thu, 3 Sep 2026 10:11:24 +0000
Message-ID:
 <IA1PR12MB9030780203F41AC64FB29A29BDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-10-mhonap@nvidia.com>
 <20260827144333.222fe7fb@shazbot.org>
In-Reply-To: <20260827144333.222fe7fb@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH2PR12MB4326:EE_
x-ms-office365-filtering-correlation-id: 801f3509-6cea-4bbb-2fbe-08df09a3b613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|4143699003|10067099003|56012099006|11063799006|3023799007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 qR2Qt6wbPbY98ShB4pUg0l23L447INCqEUbBjd4qLc1XxBkHKaaz8+hyWwwcXUo1+qe2YVohLDP7MfQSJFBxAVJoakeOIZBpjl7Hj5Bbx/VIUxA/odhyr8HFs6Z158eZjuLu1Bgx6nIX5Cn2bmlfMG6h1WiNyJ73XuTBeJzRFgJ0j2yoAHjNSh+BOmr8Dib/MOu6sc3xXypPrzLs6/SUnyQ4/Na+gnFgEqnTgQiOifdxcbaeAPxjhWbyYsB6GVjQh6c29UPIsOvOlAfWBTlBClGAR7uO0L6eLdfp/0wL0aLU1JHb9NPR9YJOCCUwPF8YQoTgAwQlcGwx27B1d68Y88lojeP84ogQgrA5+QMmyQJVWCtv+m39L+UOtzOJNWRTayfsXmaqk1Pltci41Tj/TOsXtVWUs7WkNL4zPhmeczDgmtWBIT7orReUdEVbNgxhXo20embd7QZIlWUrPQYTkinf0t7z9nAGdPnv65/NHZXoVr4Mt9CVLzwtaRRsH7ib+QpKfOJAR1Sm0/YFrukSCDfq0xk2bz4oj+5ezo51NbO2dj2JSyUkXG+ZXPIiJqyZcwOlwRGxCYfxjS8v9XSuZ5JahswRqP5ien13AkgLr11Jflpvks6t91f10w0SDJMdHsjL9pDsrn/GIW1kEea8A99/wEj3I66e61QoFxowfJcLnkiITSPYMfDmdGOP8QV6zKmHiEWvve7+RAWIjynrnMte6RIqGij7nAhnPTEaI30=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(4143699003)(10067099003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1WKZZfHuKu1K0mxDz9nHVOmRyz9lsgPlMAtlLDfCDMHkk+j/0TPlM7IJSmvM?=
 =?us-ascii?Q?aFhAEbXVlgyjWRrLjCQ0uLB3kx27CmI7dTyfpbK7jgO7hNc+mRZrPOpi2+yN?=
 =?us-ascii?Q?Xb6lHHJ2752eztQivvjv+VKiWzwYq7DJsJmTkvGBHm0AsfLow5pH/u15P45S?=
 =?us-ascii?Q?qEGx01D/Jf9124I5Jyk9CgbVazBqaLKuDJzXtJv0XRo8CAOU+je/vdBm2qPi?=
 =?us-ascii?Q?rTlEBgB1B+iYZn+Q7x1WOMiZe1ecv40klC/ZpMUwETNd78Ck0P/oZ+9m5cER?=
 =?us-ascii?Q?oSfv9k9LrsoAlFRcSAAKNe+lnoZtCmLMdFYuZXGCWldt8gckHS8ctspIY8v1?=
 =?us-ascii?Q?1CYPdqzV4VCmY7tfIl68hiyxQhKbPN2PoNTvve1u4/Gf6v3EeocfdULIWS1u?=
 =?us-ascii?Q?VxVIcQyOwgW3/YorHkBTt3NPVWf/C0VouRCjACQH74ar5VDAsZHqajl8cRJC?=
 =?us-ascii?Q?BAC4jwoI7RZv+PVwOaId0OX2zuG5UsunmovPQWFI/NkAOqNrmLbhWdM/OFNf?=
 =?us-ascii?Q?Hp5E6ePtsjd7r18/i6mJhy9w3Isw5xZmrWxIXrwV2mhiFpky4L2WLxpfMOJe?=
 =?us-ascii?Q?vNDixV49fp3v94ynhkc9FGHe87lxjm/rRU/dJz9mRgTwTR72YatQlLYUWZ5c?=
 =?us-ascii?Q?F4VjY/FX/saKpCNpmeZtOr8Z/X/xaWekSHT9WlODfXTCyktPIab4XP0AZX3I?=
 =?us-ascii?Q?QdmykHUK8Jweed6pyIfltqNsrOFini7YDetC32nJZ+oDSVwkXYafY9l6E/1G?=
 =?us-ascii?Q?g9AcQOHV87GT0cnCli/AgbBnahcoqUCWJvakjgCg16r3d3S7BVONE7u/f20S?=
 =?us-ascii?Q?sxZMtbfmOZ3AvswDvzzmHamyYCcuX1/uZ18vK7mlayNtPy/tUKWC44hNmyLO?=
 =?us-ascii?Q?tKWuiAOh5SwEmKVdE9RB4FFpVryHUv8CHkflvms7QNz6cIfUPmKtbZE7F1gT?=
 =?us-ascii?Q?K4fBkcYFSuyc9fvzosL/ZAk5WLWswM9E4Jm/Z1ANVGyO1iikyt2UpZv1rxIw?=
 =?us-ascii?Q?D8+7tb0tbRaxByz7t77ZyeHQ0BZP/57lF8m3uMTofIryPvLM2ZLHmIAnKcT3?=
 =?us-ascii?Q?qcDps+ixbhICaOBZ3IP3QZtlYikiCU/pe1cWkeBy3YpVFyh9vetTUXyMP8oS?=
 =?us-ascii?Q?0GikI8Pa+eT2dsekW5ZDud34p6DKOiBl+tmzqpW8TmRU5cbTEQG9nRSiaVFM?=
 =?us-ascii?Q?3bxC5JY8QOhWZPJ+Nm8cch+cehydnq9+ylylJVyts9BEh32l350goewVriRv?=
 =?us-ascii?Q?DRQo05YZvp10JtnYELkPoWOvK/HCjc/oPqCy0R4Ngg+2FvzL5Y1FuNyjQgTt?=
 =?us-ascii?Q?v0cFoL7/r1u5kBP35ZAjCDyUZQ3SivlICFBpJ85yPTF01DU6ErVaPqWytzpY?=
 =?us-ascii?Q?bLd13Mlmz1jOmtdNW5W5/cEPZo0UTdv+0G3qr7gFX/94pzxLXLO67sTVsupG?=
 =?us-ascii?Q?D76ro5wFlSxzQvsf0L9IlggGehn+eRI5iyKZ0EQDd9Q/cYURiMkuzOJc6YUA?=
 =?us-ascii?Q?QAGNTpYVZkh0Ha7dRjFD+Z0LBybuBl4tXVtOxKch0F5mDuIZQa23XF//4joP?=
 =?us-ascii?Q?OeUrCwsUXLA/mfPKPz/FnxH5jxQgxofVTbSV9eJxfEYvPm7uw00pKzj2OFow?=
 =?us-ascii?Q?dMWyvY3BAQfsJH9ZPRugcyu5/H8k0nH0Ba6hM192iH/rrYCSf5FqQET6AAhd?=
 =?us-ascii?Q?lhWV2oBtPrO57PszGvQTqkgOmwibhiTA3FxucEgJePfu9wD6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 801f3509-6cea-4bbb-2fbe-08df09a3b613
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:11:24.8585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sj5KegpkSM7IpIVIIcEG7mFZyoHtrF4+PTDWfpSrXtX5RLcNaxfk/XyVZmMC2EdBn1HLL7YIGzbDZ89x8eRIjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Friday, August 28, 2026 2:14 AM
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
> Subject: Re: [PATCH v4 09/27] vfio/cxl: Create the CXL memory device at b=
ind
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:13 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > Read the HDM region size from decoder 0, cached in pdev->hdm at
> > enumeration, and use it to size the accelerator device state. A Type-2
> > accelerator has no mailbox, so cxl_set_capacity() establishes the
> > capacity that devm_cxl_probe_mem() then uses to join the device to the
> > CXL topology and resolve the host physical range.
> >
> > Everything here is devm-scoped to the PCI device, so it is unwound
> > when vfio-pci unbinds. If pdev->hdm is not populated yet, defer the bin=
d.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 53
> > ++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index cbec7319452c..125e11354a46 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -6,15 +6,67 @@
> >   */
> >
> >  #include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/range.h>
> >  #include <linux/vfio_pci_core.h>
> > +#include <cxl/cxl.h>
> > +
> > +/**
> > + * struct vfio_cxl_state - per-device state for a vfio-cxl device
> > + * @cxlds: CXL device state; kept first for
> > +devm_cxl_dev_state_create()
> > + * @cxlmd: memory device joined to the CXL topology at bind
> > + * @hpa_range: host physical range of the HDM region  */ struct
> > +vfio_cxl_state {
> > +     struct cxl_dev_state cxlds;
> > +     struct cxl_memdev *cxlmd;
> > +     struct range hpa_range;
> > +};
> >
> >  static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)  {
> > +     struct pci_dev *pdev =3D vdev->pdev;
> > +     struct vfio_cxl_state *cxl;
> > +     struct cxl_memdev *cxlmd;
> > +     u64 hdm_size, serial;
> > +     u16 dvsec;
> > +     int ret;
> > +
> > +     /* pdev->hdm is populated at PCI enumeration; defer until it is. =
*/
> > +     if (!pdev->hdm)
> > +             return -EPROBE_DEFER;
>=20
> How would a device get to a PCI driver probe function without being
> enumerated by the PCI core?  This also looks like an infinite loop; if th=
ere's an
> error setting the hdm pointer, this is forever deferred.

Sorry for this confusion; I will drop this.

>=20
> > +
> > +     hdm_size =3D range_len(&pdev->hdm->settings[0].hpa_range);
>=20
> We don't validate the number of hdm ranges until the next patch.
>=20
> > +     if (!hdm_size)
> > +             return -ENXIO;
> > +
> > +     dvsec =3D pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> > +                                       PCI_DVSEC_CXL_DEVICE);
> > +     serial =3D pci_get_dsn(pdev);
> > +
> > +     cxl =3D devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM,
> serial,
> > +                                     dvsec, struct vfio_cxl_state, cxl=
ds,
> > +                                     false);
> > +     if (!cxl)
> > +             return -ENOMEM;
> > +
> > +     ret =3D cxl_set_capacity(&cxl->cxlds, hdm_size);
> > +     if (ret)
> > +             return ret;
> > +
> > +     cxlmd =3D devm_cxl_probe_mem(&cxl->cxlds, &cxl->hpa_range);
> > +     if (IS_ERR(cxlmd))
> > +             return PTR_ERR(cxlmd);
> > +
> > +     cxl->cxlmd =3D cxlmd;
> > +     vdev->cxl =3D cxl;
> > +
> >       return 0;
> >  }
> >
> >  static void vfio_cxl_release_device(struct vfio_pci_core_device
> > *vdev)  {
> > +     vdev->cxl =3D NULL;
> >  }
> >
> >  static const struct vfio_cxl_ops vfio_cxl_ops =3D { @@ -39,3 +91,4 @@
> > module_exit(vfio_cxl_exit);  MODULE_LICENSE("GPL");
> > MODULE_DESCRIPTION("VFIO support for CXL Type-2 devices");
> > MODULE_ALIAS("vfio-cxl");
>=20
> I missed commenting on this in the previous patch, but why do we need to
> declare an alias to the name the module already has?  AIUI this is for pr=
oviding
> an alternate name for the actual name of the module.  Thanks,

Okay, I will remove this redundant code.

Manish

>=20
> Alex
>=20
> > +MODULE_IMPORT_NS("CXL");

