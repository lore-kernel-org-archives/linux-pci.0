Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5E39E6EB;
	Thu,  3 Sep 2026 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430253; cv=fail; b=k+HAtE5pGASERfqLEhMLTEbIYjSYf0Dqbf8QHpoUR1gzl9UMH6ugFG03mnUD7gk+vzhP94QgP4AIpoz+IYbYd7J3FM8yv/0puU3CfnhI5MI+K/krw+pztnMvLlKZ1kYc9d3oU1L89pinbbwBQA6TuOLhsIhd/NaXAayCge08LRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430253; c=relaxed/simple;
	bh=EvtOT042pgiAe6XflLDMFSMen5PcTZExtB1M4Wf58Q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i37PiBOW6VYMvsPb1w4yIVtq4j2pbtKfs88//Mbat4EN0MX9gi2oIy4UAT3cS+LlWmHFmBnCP1/ppfIgCXgDDpw57LQ0tDwKFhuIM8wvcpRqkWuSEMIEQUKD9yck5B56fgil0/mzT942mM9wezGo5G+T1R2ilsiX7OcCWmYbD5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eOYrnaoT; arc=fail smtp.client-ip=52.101.52.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eOYrnaoT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEtzgD2F8/c9zZ7L1dStKIWdjEGw0VB2CZUxrZG3gHLA3p8x1TZmWT3/DNfhpJSm1SC0YpCKwQBIJyf/5Bit03WpJdt0B2wgH26kdNKCh1rFcmttUY5zzJBAoFLd57jJ0FP2CElTyqihCSrk6T0AYKb5nc7T5afxwfbf9Rugav1nP9WT72NUHsD5h02YotrIsp7H+82TbKBKGnSpKmZ8SpIyxjDw8edvkXU/sl18v+d/1Q9Ig9nfVUEdHdyzRkfd+xUnRRYfmQVqi4sFE2DRdU4jr3+nXtfBLXCrSLFJirTzTw/vG/uQLPHgUuqC5V2TJBviVSo63Uj6zD+Q3jmaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60kMFti0eX0uouPa5kSu5W+HsWO4flmJgDyui6I//q0=;
 b=haPBSEDkTBEubNXsjIbSOd7s8xdoQKObw6b0um/go51BiKGvdVpjSD0hB4tZ2BGMXEwgdNEnMR0Q/TKkayaLl1QYdabmbLx3TdXq17t1GbcMbL4hf593hpAvKi/s0neDXMqco/s/42qcHD8JTa9F61NoDjzcL4E7Ic691JyXdFDHYwQ+HeneqfERu9b0Y1xCP+9w2FPzzcPZT01ZTlEytha8OvnPr4AJtNqQirfOMPed9N1iP3IPzO7M8C8CDXh1ifsGJjbtUfRUJCm/7Ny/03Im0mK/+IKBzBG6eaJu6snTGG0JK24K6596AmSXrq1BbQYB9ZQ75ctXfraI+31/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60kMFti0eX0uouPa5kSu5W+HsWO4flmJgDyui6I//q0=;
 b=eOYrnaoTUgx4lwKNHKVMguHPh8aJzJNW1NCiiLCHLWNQrOt3noT0w8C94PTUXe+2uFTJBx7r3mCe4/1fo2r+6/v7I9cp823OdCph43SSfRpYSCbWsPsELptdfjq4s8gZKmJRGDNKnxNTWb4rYNFV2hcI+PNJsKJqwxanXyRMMkonLi82iiHJPQE8jDka9VZjZEPgdf38/PmfrPa079LFQHAGXO0L6GrKGPXr2AA/sxsHLymKBWV6gHn9iTpTMzxV2Er6LP4/UqyJ+CoK599X1ozdccoCqTbZUiQ/EjebG6rBMspsbFiH/IcRJoQhMgJ1N7OPDJsm/47LHvQ8JB6VWQ==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 10:10:43 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:10:43 +0000
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
Subject: RE: [PATCH v4 07/27] vfio/pci: Detect CXL devices and load vfio-cxl
 on demand
Thread-Topic: [PATCH v4 07/27] vfio/pci: Detect CXL devices and load vfio-cxl
 on demand
Thread-Index: AQHdKweD5rlPhM9CfEqZkYrCyYKTJraw+0mAgAuO7EA=
Date: Thu, 3 Sep 2026 10:10:43 +0000
Message-ID:
 <IA1PR12MB9030FF204E3BEB289A326484BDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-8-mhonap@nvidia.com>
 <20260826161725.7af1915b@shazbot.org>
In-Reply-To: <20260826161725.7af1915b@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH2PR12MB4326:EE_
x-ms-office365-filtering-correlation-id: 52a4fe53-04f5-4b87-eeff-08df09a39d90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|4143699003|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003|38070700021|6133799003;
x-microsoft-antispam-message-info:
 7hAxlr5bcuQ3EaXyROJOmo5LjqBma3kmlcbpRHO/6BrnlX+hc/h3Ft/aE/fwEBaIgBvO99BGuYyo9KM3CtMtOG4CPQGmZaDJ51LNSV5a4OdrQDlasjtmxaifnaJ1JYZ2Z+/PFYrck/NGIPUDCI9Oe9RXUmqPAsYdQeawAFln41vNUxATPvvG016R2ko/f2YSlGscQmcQeyNVzHBGs16gRekbWYthth6JBPyllGruaSqYkF9JyBh7OAdCUcFLOfpaO5mirlXAnuWzHGHX7HF5qb4bLEI0gLls9uQ6mRHlKgZkTbrBJ+BRww/lGLOKiCfEMuJSL7UXd6wEcRa2CchTEKoGodP23xB9Z1Nb2/0kVF9Db/neTDIZ0Zvocyn14NgnIIgGvVUuQKjZGULdKuw0oFko+pg6ix3/FALK7YBMm0izW9lG/xKVFuv/VjMz5FkEP7vLMuDP9PotY0kGw4skez1pM2GR08dMoiJcHNMYjBq53rD7kuwU+41cpuyR0niiX5NIaC64xtaqBjW7aGHJgrQ+K+j/KEKmLFW2/NuWvCaBhosO3/KvWTU0cMAB5df4iFKY50Ww8HViDg+aLX6AJJkNzAFhMbs1Rcml/nmUWGJshx9oXxGmZGjebrEQGetMiB5KDTVmYAwEG3D3RyIUDptf2chcvai0rEm37WJv0nK4T4qhAVH8lZFJU9DM/74qwjl12R+nmzeTVOwOuSLemLktFpEe7x/gRxjqn8VRohY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(38070700021)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T9tsqlHwiYANaYSz2ZfPEEwNTmhV6uoBlqJX13H5MkheYeZZIVE/++k0XqsC?=
 =?us-ascii?Q?e2bE5dAEF9E3Jdrjy9YUFlPsXcTseYPZLjci9+7siB/u++C/dkswYDX70T/K?=
 =?us-ascii?Q?CQlFKn64nLwytfhn5g30/oAmlMeUXG2WXDqRIB5NlMtwABlB37KkIbHcT75r?=
 =?us-ascii?Q?SeoW/6bP4RfWQUxbMQTeoiZ17d2+62BBOemc6XZCDf+2Mba2AKyaJndzXu9Z?=
 =?us-ascii?Q?XBKkYvf7ZVKgXhjPa0mcyHdHGxDmY9f/fMLDcxOZ2adt1r9CMDKVcRkRis+S?=
 =?us-ascii?Q?MN0QV7JPbOZX1pykOXHniX1bWe8f+wCAxpRrUIOoodx67/ZTuKZJuIh8V36u?=
 =?us-ascii?Q?A0L68mFurySJMa5X9TE3agiD3Ne93hrL8+FQgFFJDn1Gcj8P3FO3RDDOW9Pb?=
 =?us-ascii?Q?hQ46XPxNXsdr46i92jTEdpJ5Ivk8cgZ72c+eQHWxVKLkYNkJX3U5Q83qjT3K?=
 =?us-ascii?Q?41TPgeEG4PJRvQIkm4xHAGqtVmV3znsKFEnhI6Z6IoabHW8PVKEEm2bhzXao?=
 =?us-ascii?Q?jI+1qrfnHxYNqRx+FH3ZOD96JhOiw1dYoVPCCAhE1gMagrVP+buiPyBPp8GT?=
 =?us-ascii?Q?9/BCLDI1E7a/Z7rjQP3gpsKIcW5eme8xS7Nei9rpPQLMInnKTlDqfm/2W1+i?=
 =?us-ascii?Q?VhKf7kDllbEFZGt6aI298kwX+jl2incKkp4BI7YkOrDnGCHR+ESaFmcxjKsO?=
 =?us-ascii?Q?UROEQp3dAnDrRoMGAi1+qGRC/ZEgBjS9sT8uCU9d4AMG6P83NCi5GD9v1WKq?=
 =?us-ascii?Q?rAD+srSWIrnxqIdIg1Z3EDgRqJOoTF2dw8MpOOaKSKm8vJvoc0BPTEDMPSwp?=
 =?us-ascii?Q?2gDmA1Tkg1FSXvHQ0Mq0Eb1xVLgPkpEYjgBlJGflrMDP6OPmGqcmtUlzKfIg?=
 =?us-ascii?Q?uJc+iXlq7jKmubkfPFqBF36YvIWTTg3VmUWBTwUiUWjrZ+dNfHzl+M+G46fD?=
 =?us-ascii?Q?lceRnfOt+9e+EG99OakboN+10fiLy90UueQzrJGutlZ3ny3j3T0FT9i2VFGl?=
 =?us-ascii?Q?xMm6rZ+J9ggtZdi2lp4nJpqQ4BU5oFi8Me+JzsVjlIaBM26+4tDwLKtF1Obl?=
 =?us-ascii?Q?ofQrefjMj7gqDNwKoN6h0XlNMdiPMXBC8r4nVV/SDR8JXnDyQEe42gbXPqjD?=
 =?us-ascii?Q?voewLUK7rW7SZyfRu37CWVvVRzLIDqM6RQ3U2K+eNfMqV90NU2KgKJwvNTfd?=
 =?us-ascii?Q?4tfole32jYB3uk7eXDtZyp4fgffuSPEuPU+iWQXEsxhntAM5lkO0FF6jeYWs?=
 =?us-ascii?Q?zmCvqBirLo7gpHOi6ziQs5TX9TjrU8xhlCY0WAXJ1gxVJKDtEEIMmS6hExxR?=
 =?us-ascii?Q?qB4dCnFVmpRzGbJSNM/74WznqyLc7pBNZR/Maa+hrNPZKBSAttP7ilPUI+da?=
 =?us-ascii?Q?aaf+VBUeMT35X5aJdH46JiS6Xh95PBK5daHm/DF6RcshVF7pQxSaLL6spKZd?=
 =?us-ascii?Q?sdFqwv7aWoJV7G1OmPfwb9pcW0G38M+I9BjXA44Awuxi1k2pTOcK3wacbO65?=
 =?us-ascii?Q?l2Urd7jeskbLJxGv7iKb59eJJHRiXnONpqLRfqY0uLl9y5n9nxHTUSb7gfxS?=
 =?us-ascii?Q?40/soxVsqWvOze0RqqX3siFGIgzgYlz99xSaBAY5ULd30eCRPhkPOwbV7Opl?=
 =?us-ascii?Q?ihre4seLr/7tYTyq2FgXpFJ6ha5ts6lfYtGHwCDl3FYkHxLhbHrwNQ1KV9qL?=
 =?us-ascii?Q?0S+9/UFTzgk1YWu9UCFjD5yPcst/qsXIgy3CWIm5Pw2Gs//B?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a4fe53-04f5-4b87-eeff-08df09a39d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:10:43.7332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PwqYKxmQc7l/1L8ZKpC9XUXkHkmsoznfnZ/RTzkBlWhw3lLjR1cI1MgeSeZ2ZydcNhe7zLByn+p+Wvq8dsmBLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Thursday, August 27, 2026 3:47 AM
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
> Subject: Re: [PATCH v4 07/27] vfio/pci: Detect CXL devices and load vfio-=
cxl on
> demand
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:11 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A CXL device needs the vfio-cxl callbacks, but pulling vfio-cxl and
> > the CXL core in unconditionally would bloat every vfio-pci setup. At
> > bind, detect a CXL device with pcie_is_cxl() and
> > request_module("vfio-cxl") only then, and hand the device to the regist=
ered
> ops.
> >
> > Each bound CXL device pins vfio-cxl through try_module_get() and drops
> > the reference at release, so vfio-cxl can unload once no CXL device is
> > bound. If vfio-cxl is absent the device is driven as plain vfio-pci.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c | 81 ++++++++++++++++++++++++++++++--
> >  include/linux/vfio_pci_core.h    |  3 ++
> >  2 files changed, 81 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 88e68d43af9a..0f9b5dfeea66 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -2176,6 +2176,44 @@ static void vfio_pci_vga_uninit(struct
> vfio_pci_core_device *vdev)
> >                                             VGA_RSRC_LEGACY_MEM);  }
> >
> > +static const struct vfio_cxl_ops *vfio_pci_cxl_ops; static
> > +DEFINE_MUTEX(vfio_pci_cxl_ops_lock);
> > +
> > +static const struct vfio_cxl_ops *vfio_pci_get_cxl_ops(void) {
> > +     const struct vfio_cxl_ops *ops;
> > +
> > +     mutex_lock(&vfio_pci_cxl_ops_lock);
> > +     ops =3D vfio_pci_cxl_ops;
> > +     if (ops && !try_module_get(ops->owner))
> > +             ops =3D NULL;
> > +     mutex_unlock(&vfio_pci_cxl_ops_lock);
> > +
> > +     return ops;
> > +}
>=20
> Awkward flow, resolved with guards:
>=20
>         guard(rwsem_read)(&vfio_pci_cxl_ops_lock);
>         ops =3D vfio_pci_cxl_ops;
>         if (!ops || !try_module_get(ops->owner))
>                 return NULL;
>=20
>         return ops;
>=20

Okay, I will update this.

> > +
> > +/*
> > + * A CXL Type-2 device advertises both CXL.cache and CXL.mem in its CX=
L
> DVSEC.
> > + * pcie_is_cxl() is also true for Type-1 (cache only) and Type-3 (mem
> > +only)
> > + * devices, which the vfio-cxl provider does not handle, so confirm
> > +the Type-2
> > + * identity before engaging it.
> > + */
> > +static bool vfio_pci_is_cxl_type2(struct pci_dev *pdev) {
> > +     u16 dvsec, cap;
> > +
> > +     dvsec =3D pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> > +                                       PCI_DVSEC_CXL_DEVICE);
> > +     if (!dvsec)
> > +             return false;
> > +
> > +     if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> > +             return false;
> > +
> > +     return (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) &&
> > +            (cap & PCI_DVSEC_CXL_MEM_CAPABLE); }
> > +
> >  int vfio_pci_core_init_dev(struct vfio_device *core_vdev)  {
> >       struct vfio_pci_core_device *vdev =3D @@ -2197,6 +2235,41 @@ int
> > vfio_pci_core_init_dev(struct vfio_device *core_vdev)
> >       init_rwsem(&vdev->memory_lock);
> >       xa_init(&vdev->ctx);
> >
> > +     /*
> > +      * Load vfio-cxl on demand for a CXL device. If it is absent, dri=
ve the
> > +      * device as plain vfio-pci rather than failing the bind.
> > +      */
> > +     if (pcie_is_cxl(vdev->pdev) &&
> > + vfio_pci_is_cxl_type2(vdev->pdev)) {
>=20
> Nit, embed the pcie_is_cxl() test in vfio_pci_is_cxl_type2().

Okay, I will fold pcie_is_cxl() into vfio_pci_is_cxl_type2().

>=20
> > +             const struct vfio_cxl_ops *ops;
> > +
> > +             request_module("vfio-cxl");
> > +             ops =3D vfio_pci_get_cxl_ops();
> > +             if (ops) {
> > +                     ret =3D ops->init_device(vdev);
> > +                     if (ret) {
> > +                             module_put(ops->owner);
>=20
> Create a trivial vfio_pci_put_cxl_ops() for consistency.

Okay.

>=20
> > +                             return ret;
>=20
> This looks like a regression, a device that previously worked with vfio-p=
ci now
> fails if vfio-cxl .init returns an error.  It should continue with a log =
message.

Agreed. I will modify this so that the CXL init failure becomes non-fatal
I will log the failure, drop module ref and continue as plain vfio-pci in t=
his case)

>=20
> The disable_cxl option that comes later is a global opt-out, not an opt-i=
n.  Users
> can opt-in to a feature that might fail previous behavior but they should=
 not be
> required to opt-out to retain existing functionality, especially with onl=
y global
> granularity.

Okay, I will make sure the opt-out no longer gates the fallback.

>=20
> > +                     }
> > +                     vdev->cxl_ops =3D ops;
> > +                     /*
> > +                      * Pin the device in D0 while bound rather than l=
et
> > +                      * the host power it down between opens.
> > +                      */
> > +                     vdev->disable_idle_d3 =3D true;
>=20
> Why?  Letting the host power down the device between opens is exactly wha=
t
> we want for non-cxl devices.  If we're trying to do something around pres=
erving
> the coherent memory configuration, it needs to be justified as such, and =
should
> happen at the point where it's relevant, ie. in the vfio-cxl .init path.
>=20
> However, this alone doesn't prevent the user from using low power states,=
 so it
> also seems insufficient by itself.

I will Move disable_idle_d3 into the CXL .init path with the justification =
added there and
for this series, add the full guest-D3 block in the cover-letter as a follo=
w-up item.

>=20
> > +             } else if (IS_BUILTIN(CONFIG_VFIO_CXL)) {
> > +                     /*
> > +                      * Only DEFER for a built-in provider so the bind
> > +                      * retries once vfio-cxl registers its ops.
> > +                      * A modular provider was already loaded synchron=
ously
> > +                      * by request_module() above, so if it is still a=
bsent
> > +                      * it is missing, blocked, or failed to init; dri=
ve the
> > +                      * device as plain vfio-pci then rather than defe=
r the
> > +                      * bind forever.
> > +                      */
> > +                     return -EPROBE_DEFER;
>=20
> LLM asks if the registration function should call
> driver_deferred_probe_trigger() to make the retry explicit?

Okay, I will add a call to driver_deferred_probe_trigger() from register.

>=20
> > +             }
> > +     }
> > +
> >       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
> > @@ -2206,6 +2279,11 @@ void vfio_pci_core_release_dev(struct
> vfio_device *core_vdev)
> >       struct vfio_pci_core_device *vdev =3D
> >               container_of(core_vdev, struct vfio_pci_core_device,
> > vdev);
> >
> > +     if (vdev->cxl_ops) {
> > +             vdev->cxl_ops->release_device(vdev);
> > +             module_put(vdev->cxl_ops->owner);
> > +     }
>=20
> Turn both of these into helpers:
>=20
> static int vfio_pci_core_cxl_init(struct vfio_device *core_vdev); static =
void
> vfio_pci_core_cxl_release(struct vfio_device *core_vdev);
>=20
> Include the tests is-cxl/cxl_ops tests in the helpers to compartmentalize=
 cxl
> init/release.  Thanks,

Okay.

Manish

>=20
> Alex
>=20
> > +
> >       mutex_destroy(&vdev->igate);
> >       mutex_destroy(&vdev->ioeventfds_lock);
> >       kfree(vdev->region);
> > @@ -2670,9 +2748,6 @@ static void vfio_pci_dev_set_try_reset(struct
> vfio_device_set *dev_set)
> >       }
> >  }
> >
> > -static const struct vfio_cxl_ops *vfio_pci_cxl_ops; -static
> > DEFINE_MUTEX(vfio_pci_cxl_ops_lock);
> > -
> >  int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops)  {
> >       int ret =3D 0;
> > diff --git a/include/linux/vfio_pci_core.h
> > b/include/linux/vfio_pci_core.h index 14753972e714..117cd67995d8
> > 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -29,6 +29,7 @@ struct vfio_pci_core_device;  struct
> > vfio_pci_region;  struct p2pdma_provider;  struct dma_buf_attachment;
> > +struct vfio_cxl_state;
> >
> >  struct vfio_pci_eventfd {
> >       struct eventfd_ctx      *ctx;
> > @@ -109,6 +110,8 @@ struct vfio_pci_core_device {
> >       struct vfio_device      vdev;
> >       struct pci_dev          *pdev;
> >       const struct vfio_pci_device_ops *pci_ops;
> > +     const struct vfio_cxl_ops *cxl_ops;
> > +     struct vfio_cxl_state   *cxl;
> >       void __iomem            *barmap[PCI_STD_NUM_BARS];
> >       bool                    bar_mmap_supported[PCI_STD_NUM_BARS];
> >       /* Flags modified at runtime - dedicated storage unit */

