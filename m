Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3E47FAF5;
	Thu,  3 Sep 2026 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430557; cv=fail; b=ZoJs5FriTJw+wzRGtcvX4PAJBW9gseI0Z8P/RCyR+hy1xRKtceoMjoo2D24QmUNUZbg/aZxMNlmpcMaWbpH9WMtE8xQAgqNrIAgMMIk4X6tK1iCamvFS26Ywg/3ljt9GpccbjKf+kPdeIgH8LPp8q2GJ+9jg4wpdfmWPNucAC7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430557; c=relaxed/simple;
	bh=3ufSMn0KsMdhnibdUiII4cbNvQ5jU3fnyCXsevF9jb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l5LwCM/Ce8Z7lJTQVQG3TFQC1IlGvSc/O6U9v7om4yZt9AP+cuvanLr+VwnSymjJksnx4suef7XIV2SfxG9FFnYt40sBB7H6Ycar+i4MPzPQjbAuQwf7L19e73aE7sCwpZPGHbA1ZnxQwd2zdtJnsxl5NoeVew2yTA5N3ss1WP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kE0PuAVt; arc=fail smtp.client-ip=52.101.57.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kE0PuAVt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOTBFvJlIRaEfMf+SmXtfTGj0vPXfZE3ge4aoV03UOhJzjTpXaq/N5fYYDgLm7J+Xxa4uWlk3FZd0lRtNRbHkpJXUXuHoZZqhYmnPukaRc+nSjbECjYmMR/WJP1SD0yrZcKenhIlje2zcN/4u88Qlsy4Irwg1wCOTLO5rP/o3VgylOa+K4huBoEsWj81FC9llSUNveJWHPxujy2UoQTFEjopj15+XXi2I14MwFvkQLA7S0HpicOnSbURXOm4GajL02U4TbwpNi2sqYO8hSrshZZhkAE6UiBIeOZxbZxxU9N0BdcB8EXezCJEV9ipIphqwE0EYqY90vK7fQJk8YGC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vw8yqjiB5CimIBwONdW3Ajc5M056/eiPucYY48vPU3I=;
 b=hUchfxKaLY/eV14mwllbH0GFgQG2j4FeqDoMYomGOsJ7U5vxjVXJ6HMk99MOSD2XugU/gxU7xbgzSv8OdcCOtkjglJRhPULlzdHL2y+FZamKNYs6pXmAki9LKhRV+EsMu4Ypg5AU0jIY5g5cj/3Kr7ou8/70AvAc4kJ/FEYPGs7KoT0B0fGZ1griSmaNjbU6hE//jhglbHHpHfxNXTLtKB9TS4syxRLklYqkq5G3ITCIZIiqsgloAGsM50p5FJnVjfCbGml5cyIEp258rJsUYe7dEkTGjklXn3mW24iFOOHc/yJ+8/3TfW3Enk1srdmmRgewOhrsLIP8ze7D/cCMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw8yqjiB5CimIBwONdW3Ajc5M056/eiPucYY48vPU3I=;
 b=kE0PuAVtgWzwFIfwOUoM+HW/l2uAcBr0JujxW5vLf/1Kk3kaVIHkZOEzZS4M+QRSF5VW8Ky3JdWvOSmGI1TcTF8ZzeS/z3rU/v7bNceox/3yJ21spiY3hPk7qqx2LHQPbopi04gW8j1WsGJre3/skXVzJZhxm0LJaZfoY45jdA+ibe1QatlcdHxk5RMm9m2k4wFAKmO9gu+KJruIZM3SDL94gSjFgzPjeUGWb+yNAGCENr86BdCPdoKhr3XIsS6uBAVQeAbMTdFV3SiwIDYt+l8GIFRbH+CzXrJ9tK/pIajvRm//VYRYiaysWTt0OHj404DIfyQQptekM/ikjCsWAw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:15:31 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:15:31 +0000
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
Subject: RE: [PATCH v4 23/27] vfio/cxl: Refresh the decoder snapshot after a
 device reset
Thread-Topic: [PATCH v4 23/27] vfio/cxl: Refresh the decoder snapshot after a
 device reset
Thread-Index: AQHdKwfjnwuTAzJ2fEezVwkeqdGgcLa0JGkAgAiOP0A=
Date: Thu, 3 Sep 2026 10:15:31 +0000
Message-ID:
 <IA1PR12MB903046CEF5BC3E7DC50E5250BDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-24-mhonap@nvidia.com>
 <20260828163324.72a685d1@shazbot.org>
In-Reply-To: <20260828163324.72a685d1@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|LV8PR12MB9405:EE_
x-ms-office365-filtering-correlation-id: 7415aa8d-8629-484f-3b98-08df09a44900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 0mt+R7d8DU5C7HiGcl94E1Z4q2IikYyHttak223Dj1BSOuFf5eUSroRsTLhwZy7OCMAWj+CqnxKFqv8VbV8cX6j6uzQ30D+jxf+1KbhjsEegeSXfbOVSYciKqKngkbVwcSnk4sSITPPtmVFPLdtJVaw5jxs3s6ci6B2QH/pmjjAHgpMbCVbavwa9v/7Z4W4AbHzzgll/DKIyG2wql02nR3PcQTubMIXv0qII5J7QJKNdil6BJxe0xBR9HJKIrf6cuhSmNxGJG6lwrxMlgcaLdM4iqCchLj7YVtTDfpi/rm3boIcgGkrtFRPqR3hlz9TePFZGoN4xEDZJ5nmpQL2aR5RQ+SEKcD1C84Q9EMvnZz3Sp4SCR+3m8RqUfRcyHf7z86DPSm1enbPWy9W+x5vGXD3eUyb83FKoLz4uMGaDeg4CzSb31OzdQQeoDQtQMRY3/G5p/r5sWvYTKGrGC8Ox5z0uat9oIPn7K54GivPHTTQeB+jn/U58CAUg37j2BttgoJWwFrk0ircRlbt7vWfXBoI9h5UT8ssZDlK+VWRJMAtlCivSU8Ura//G6QRwpaEjCynfUjdJMdGaA1um3YvliNiLz87H3NS+W1bUWk90e08si8FIRpTmgw+Hc/A0/VGVlGjk+Foac5bbHfZGT6P011kL8vNSb6hZPkQq8ZPlhB0H64MN3Lr78G5QCY8sg58IRdkqITMyvxUftE88xkv4z9AHhgqf2Nkfos+YgJJ+fk4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jVizOSc6Tv7oEpLKKC5/YYNrE2tE/OO6STCkatHsO1qVRnCb2sQvWeTw0YQk?=
 =?us-ascii?Q?VWLqq4s/qkCK90+D1U3w2IhN9gnkXTUIYLKiO4+Z/vsv4OYOcRnX8uDVXpUC?=
 =?us-ascii?Q?q2gBaJS3L1qS33i/PaT9b1DEmLVEFBgy9N9Rhkr1rCSoJ6b2GA4OLP3L0m0e?=
 =?us-ascii?Q?PhUO2t9uuw+ZF5qJahTCKLSWuK2BiOEcf+ANlL8tnfXROG9V7yOXo8wZJW2v?=
 =?us-ascii?Q?KXOpvF1/kXlQb5UnboBrotc30BvKVUs15WKSNATyshxNBAcrKBoUJRVtgs0J?=
 =?us-ascii?Q?W8GrC4p/gbQg7KTPEaRE6owKxGGLkh2ih3UbVOazeCNhl/E6eCSdY46xMac9?=
 =?us-ascii?Q?svPupu1Z9klaJhkCxEw4TBc6ldTSOkbOdd8YiEPpSw4e4J0tT/u/JyGTysAQ?=
 =?us-ascii?Q?R6SjNYDWzhiswpgnNmwXGN+4SHwYwb6JVKfVGLtlrIXTQc97fvx8LCMitygr?=
 =?us-ascii?Q?v8hY0qG9v8qqyDUj31prEqHh0FLKjoF/K6x+m2JXWuesXx6XacN+ItyzbVLt?=
 =?us-ascii?Q?pBTBE8GXJWFogZuOZtgXIt4TnWg+jZIM8ynwwJdgCFpHshcljFAr3LovLAgX?=
 =?us-ascii?Q?GwqJX5aedvt0Er3z0xj8ICbov2bxX9tSjoIwG0zPTu9IvJJn6VYSZqpW5/GI?=
 =?us-ascii?Q?ekeV+mMIqJvOzRi2PigF/doppSv2buE7rpWt47AobtG3ix1GjoU/7d1KhZnN?=
 =?us-ascii?Q?L4IjMUFDjUtxk9lUMaXrI3yVnAgXt2NOahUzYh1Nn7Jv4pv5enywToc56g1/?=
 =?us-ascii?Q?IfWeZ83sG39DHtYrO1/sftN0nd/zw/Re0rRB2rQxVvR7kY/NIoDxo80lUEmN?=
 =?us-ascii?Q?zqfH5T6IRrgInw2d9XmwhSCtS4YmfijWV3uQQUCBagKttMbWHxyAmYtVuqHf?=
 =?us-ascii?Q?NUSw2oMgFU3+XdrIA8FKFr9wxAhdTSMQf43/HyYtyszyMnd9iHhdbO5ZV9q+?=
 =?us-ascii?Q?EaPaxUnwYpNhrm0JElLUwlVbjEdPS/olCq0MTe4xrWtTsuAVRVuwNL++ID69?=
 =?us-ascii?Q?u3cdKFgkAZAyznbrj84SMH5Sf4XiHQwzS2UZWysYfkooZc3rwMV1ivPHEi6Q?=
 =?us-ascii?Q?TCicp1jDys1TapS4xID0V46c4U+8y8UvSYodGMQzS8H+XQB+t3ue3ayUuqIC?=
 =?us-ascii?Q?+4yG4hW8NDjTY0eXb/S30jgAeWvOT4y9RpJRrJPjsA+uEeX4wPAO6hrdwgtT?=
 =?us-ascii?Q?XiGqmZbg9dL+lw3tTKqdZf5GjNpji0U/XzWVC4l+1AmcGUxuWhxCyZe/CzKZ?=
 =?us-ascii?Q?vnlEorANp6Ke4BNu1a5poo43H//OAHAeifwf1irOr25cNGyyZ+31uIqEpAR1?=
 =?us-ascii?Q?rjVGA0hEWzW+uDznFXc+qwB+aNz3J9ACfOzrNXDXyJ0yxXyQ95k4xh5oJUOq?=
 =?us-ascii?Q?0QZJsmRT8BWvHF06Xe7wKkuaBkXrOeFK0mK273M/Ksk7A8l4H7UmGQv7yEc3?=
 =?us-ascii?Q?WBgVdyfTr+wAe4K3tgkbDAzSmQEWNpTybTaE/4JwW4DAqZ6axioaiqPZztdF?=
 =?us-ascii?Q?eaCWeRZwtlOOJKZXzxuElp58ZfI5h7ZROK8aW5VkGsDsDQ/bpeqzH4fbC87P?=
 =?us-ascii?Q?/jW6wfDKJPuqTN91858iYTBlR4wdpa1p/NpoDoysr90Tg5Haq05UJFX+VoQZ?=
 =?us-ascii?Q?+cfKI4AXc7PzdzK1Q1dXYPGwIqBDTgu88V9odMe6D/oKN2IjS3VP3n+AZcsj?=
 =?us-ascii?Q?Tc4eDLYGTjRg1X/y5Fsf34wbrObvXVAFQAhEyO3zeJ8f/LBY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7415aa8d-8629-484f-3b98-08df09a44900
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:15:31.3743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNeV/vS7D3DSPtRDAhcp+WsN0SjjQvN3KXuBkE9k9nXdPNJk8GqKTSKwsqEsQhoAISdCVT/AjdUgQCcVmur6mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Saturday, August 29, 2026 4:03 AM
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
> Subject: Re: [PATCH v4 23/27] vfio/cxl: Refresh the decoder snapshot afte=
r a
> device reset
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:27 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A reset clears the HDM decoder registers, so the guest snapshot has to
> > be resampled once the reset settles, on every path that can reset the
> > function: the reset ioctl, an FLR driven through config space, and a
> > bus hot reset. Re-enable Memory Space first, since a config restore
> > can leave it off and the component-BAR read would then take an
> Unsupported Request.
> >
> > The bus hot reset zaps BARs directly rather than through
> > vfio_pci_zap_and_down_write_memory_lock(), so it also needs the HDM
> > window zapped by hand; route both zap sites through a common helper.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 82 ++++++++++++++++++++++++++++
> >  drivers/vfio/pci/vfio_pci_config.c   |  2 +
> >  drivers/vfio/pci/vfio_pci_core.c     | 25 ++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h     | 20 +++++++
> >  include/linux/vfio_pci_core.h        |  4 ++
> >  5 files changed, 131 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index f1c6bf06c408..f45eaa60bad2 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -555,6 +555,86 @@ static void vfio_cxl_zap(struct vfio_pci_core_devi=
ce
> *vdev)
> >                           range_len(&cxl->hpa_range), true);  }
> >
> > +static void vfio_cxl_post_reset(struct vfio_pci_core_device *vdev) {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     struct pci_dev *pdev =3D vdev->pdev;
> > +     bool re_enabled =3D false;
> > +     int i, dwords;
> > +     u16 cmd;
> > +
> > +     lockdep_assert_held_write(&vdev->memory_lock);
> > +
> > +     if (!cxl || !cxl->hdm_shadow)
> > +             return;
> > +
> > +     /*
> > +      * The decoder registers are read through the component BAR. A co=
nfig
> > +      * restore can leave Memory Space disabled, and the read would th=
en
> > +      * return an Unsupported Request, so re-enable it before sampling=
.
> > +      */
> > +     pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > +     if (!(cmd & PCI_COMMAND_MEMORY)) {
> > +             pci_write_config_word(pdev, PCI_COMMAND,
> > +                                   cmd | PCI_COMMAND_MEMORY);
> > +             re_enabled =3D true;
> > +     }
> > +
> > +     dwords =3D cxl->hdm_len / sizeof(u32);
> > +     for (i =3D 0; i < dwords; i++)
> > +             cxl->hdm_shadow[i] =3D cpu_to_le32(readl(cxl->hdm_regs +
> > +                                                    i * sizeof(u32)));
> > +     /*
> > +      * Leave Memory Space as it was found. The guest owns Memory Spac=
e
> > +      * through vconfig, so a physical enable done only to sample must=
 not
> > +      * outlive the sampling or the function would decode while vconfi=
g
> > +      * reports it off.
> > +      */
> > +     if (re_enabled)
> > +             pci_write_config_word(pdev, PCI_COMMAND, cmd);
>=20
> This is usually done by just saving the original and re-writing it, but t=
his whole
> patch is really just ammunition for why it should be read live rather tha=
n
> shadowed.
>=20
> See also the reset_done callback in pci_error_handlers, we shouldn't be o=
pen
> coding calls to this everywhere, but of course this goes away if we expos=
e it live
> rather than shadow it.  Thanks,
>=20
> Alex

I will drop this patch as per suggestion on patch 18.

Manish

>=20
> > +}
> > +
> > +static int vfio_cxl_pm_restore(struct vfio_pci_core_device *vdev) {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +     struct pci_dev *pdev =3D vdev->pdev;
> > +     int rc;
> > +
> > +     lockdep_assert_held_write(&vdev->memory_lock);
> > +
> > +     if (!cxl || !cxl->hdm_shadow) {
> > +             pci_dbg(pdev, "vfio-cxl: pm_restore: no shadow (device no=
t open),
> skipping\n");
> > +             return 0;
> > +     }
> > +
> > +     /*
> > +      * A D3hot->D0 transition can soft-reset the function and clear t=
he HDM
> > +      * decoder. Restore the physical decoder before the fault gate re=
-inserts
> > +      * the mapping. The restore needs the device lock, taken here aft=
er
> > +      * memory_lock to match the reset path ordering. On failure the d=
ecoder
> is
> > +      * left unrestored, so close the access gate (zap no longer clear=
s it) and
> > +      * return the error so the caller keeps the HDM range inaccessibl=
e.
> > +      */
> > +     if (!pci_dev_trylock(pdev)) {
> > +             pci_warn(pdev, "vfio-cxl: pm_restore: could not lock devi=
ce, HDM
> not restored\n");
> > +             cxl->hdm_valid =3D false;
> > +             return -EBUSY;
> > +     }
> > +
> > +     rc =3D cxl_restore_hdm_after_pci_reset(pdev);
> > +     pci_dev_unlock(pdev);
> > +     if (rc) {
> > +             pci_err(pdev, "vfio-cxl: pm_restore: HDM restore failed: =
%d\n", rc);
> > +             cxl->hdm_valid =3D false;
> > +             return rc;
> > +     }
> > +
> > +     vfio_cxl_post_reset(vdev);
> > +     /* The decoder is restored and re-sampled, so reopen the access g=
ate. */
> > +     cxl->hdm_valid =3D true;
> > +     return 0;
> > +}
> > +
> >  static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)  {
> >       struct vfio_cxl_state *cxl =3D vdev->cxl; @@ -767,6 +847,8 @@
> > static const struct vfio_cxl_ops vfio_cxl_ops =3D {
> >       .config_read    =3D vfio_cxl_config_read,
> >       .config_write   =3D vfio_cxl_config_write,
> >       .zap            =3D vfio_cxl_zap,
> > +     .post_reset     =3D vfio_cxl_post_reset,
> > +     .pm_restore     =3D vfio_cxl_pm_restore,
> >       .owner          =3D THIS_MODULE,
> >  };
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_config.c
> > b/drivers/vfio/pci/vfio_pci_config.c
> > index f088e4ce5e07..01d808546a4c 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
> > @@ -911,6 +911,7 @@ static int vfio_exp_config_write(struct
> vfio_pci_core_device *vdev, int pos,
> >                       vfio_pci_zap_and_down_write_memory_lock(vdev);
> >                       vfio_pci_dma_buf_move(vdev, true);
> >                       pci_try_reset_function(vdev->pdev);
> > +                     vfio_pci_cxl_post_reset(vdev);
> >                       if (__vfio_pci_memory_enabled(vdev))
> >                               vfio_pci_dma_buf_move(vdev, false);
> >                       up_write(&vdev->memory_lock); @@ -996,6 +997,7
> > @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, i=
nt
> pos,
> >                       vfio_pci_zap_and_down_write_memory_lock(vdev);
> >                       vfio_pci_dma_buf_move(vdev, true);
> >                       pci_try_reset_function(vdev->pdev);
> > +                     vfio_pci_cxl_post_reset(vdev);
> >                       if (__vfio_pci_memory_enabled(vdev))
> >                               vfio_pci_dma_buf_move(vdev, false);
> >                       up_write(&vdev->memory_lock); diff --git
> > a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index 1a54f15d1c2c..fc8235c8b4fc 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -362,6 +362,14 @@ int vfio_pci_set_power_state(struct
> vfio_pci_core_device *vdev, pci_power_t stat
> >               } else if (needs_restore) {
> >                       pci_load_and_free_saved_state(pdev, &vdev->pm_sav=
e);
> >                       pci_restore_state(pdev);
> > +                     /*
> > +                      * A NoSoftRst- device soft-resets on D3hot->D0, =
which can
> > +                      * clear a CXL HDM decoder. Restore it before the=
 fault
> > +                      * gate re-inserts the HDM mapping. memory_lock i=
s held on
> > +                      * this path (the PM config write and runtime PM =
entry both
> > +                      * take it before the D0 transition).
> > +                      */
> > +                     vfio_pci_cxl_pm_restore(vdev);
> >               }
> >       }
> >
> > @@ -529,6 +537,13 @@ static int vfio_pci_core_runtime_resume(struct
> device *dev)
> >               eventfd_signal(vdev->pm_wake_eventfd_ctx);
> >               __vfio_pci_runtime_pm_exit(vdev);
> >       }
> > +     /*
> > +      * A NoSoftRst- function can soft-reset on the runtime D3hot->D0
> > +      * transition and clear a CXL HDM decoder. Restore it while memor=
y_lock
> > +      * is held, before the fault gate can re-insert the HDM mapping. =
PCI
> > +      * config restore alone does not restore the component decoder re=
gisters.
> > +      */
> > +     vfio_pci_cxl_pm_restore(vdev);
> >       up_write(&vdev->memory_lock);
> >
> >       if (vdev->pm_intx_masked)
> > @@ -1449,6 +1464,7 @@ static int vfio_pci_ioctl_reset(struct
> > vfio_pci_core_device *vdev,
> >
> >       vfio_pci_dma_buf_move(vdev, true);
> >       ret =3D pci_try_reset_function(vdev->pdev);
> > +     vfio_pci_cxl_post_reset(vdev);
> >       if (__vfio_pci_memory_enabled(vdev))
> >               vfio_pci_dma_buf_move(vdev, false);
> >       up_write(&vdev->memory_lock);
> > @@ -1838,8 +1854,7 @@ void
> vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device
> *vdev)
> >        * a runtime-PM entry, D3 transition, or reset would leave the gu=
est
> >        * with live mappings into a quiesced device.
> >        */
> > -     if (vdev->cxl_ops && vdev->cxl_ops->zap)
> > -             vdev->cxl_ops->zap(vdev);
> > +     vfio_pci_cxl_zap(vdev);
> >  }
> >
> >  u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device
> > *vdev) @@ -2780,6 +2795,8 @@ static int
> > vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
> >
> >               vfio_pci_dma_buf_move(vdev, true);
> >               vfio_pci_zap_bars(vdev);
> > +             /* zap_bars misses the HDM window; bus reset needs it too=
 */
> > +             vfio_pci_cxl_zap(vdev);
> >       }
> >
> >       if (!list_entry_is_head(vdev,
> > @@ -2802,6 +2819,10 @@ static int vfio_pci_dev_set_hot_reset(struct
> > vfio_device_set *dev_set,
> >
> >       ret =3D pci_reset_bus(pdev);
> >
> > +     /* Re-sample decoder state for any CXL device the bus reset touch=
ed. */
> > +     list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_lis=
t)
> > +             vfio_pci_cxl_post_reset(vdev);
> > +
> >       vdev =3D list_last_entry(&dev_set->device_list,
> >                              struct vfio_pci_core_device,
> > vdev.dev_set_list);
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h
> > b/drivers/vfio/pci/vfio_pci_priv.h
> > index 902d17815ab6..46e67573d264 100644
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -82,6 +82,26 @@ int vfio_pci_set_power_state(struct
> vfio_pci_core_device *vdev,
> >                            pci_power_t state);
> >
> >  void vfio_pci_zap_and_down_write_memory_lock(struct
> > vfio_pci_core_device *vdev);
> > +
> > +static inline void vfio_pci_cxl_zap(struct vfio_pci_core_device
> > +*vdev) {
> > +     if (vdev->cxl_ops && vdev->cxl_ops->zap)
> > +             vdev->cxl_ops->zap(vdev); }
> > +
> > +static inline void vfio_pci_cxl_post_reset(struct
> > +vfio_pci_core_device *vdev) {
> > +     if (vdev->cxl_ops && vdev->cxl_ops->post_reset)
> > +             vdev->cxl_ops->post_reset(vdev); }
> > +
> > +static inline int vfio_pci_cxl_pm_restore(struct vfio_pci_core_device
> > +*vdev) {
> > +     if (vdev->cxl_ops && vdev->cxl_ops->pm_restore)
> > +             return vdev->cxl_ops->pm_restore(vdev);
> > +     return 0;
> > +}
> > +
> >  u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device
> > *vdev);  void vfio_pci_memory_unlock_and_restore(struct
> vfio_pci_core_device *vdev,
> >                                       u16 cmd); diff --git
> > a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h index
> > 8b93949d4484..c438d968dc59 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -78,6 +78,10 @@ struct vfio_cxl_ops {
> >                               int count, __le32 val);
> >       /* Revoke the HDM mapping; paired with the BAR zap */
> >       void    (*zap)(struct vfio_pci_core_device *vdev);
> > +     /* Re-sample the decoder state once a reset has settled */
> > +     void    (*post_reset)(struct vfio_pci_core_device *vdev);
> > +     /* Restore the HDM decoder after a D3hot->D0 soft reset */
> > +     int     (*pm_restore)(struct vfio_pci_core_device *vdev);
> >
> >       /* Pinned per bound CXL device so vfio-cxl cannot unload under us=
age */
> >       struct module *owner;

