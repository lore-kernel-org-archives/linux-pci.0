Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9042EEDA;
	Fri,  9 Oct 2026 06:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526465; cv=fail; b=ZphYdq1VRbAiTkWBMZgPpWO1xDhsSbqP9gDCdvfBuJEh+VjoR7rEsziOSaqRXRABEXG0IpNzxcFmhvsohMr0hJCVl4aPnlh+xDBv+fbPlsl6VGQ/tGsQNce/hhdXdfVOLS2+N3EA/rtAMoVA7mrlb5vixN45KAEM4gL1wWU72Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526465; c=relaxed/simple;
	bh=0UNADiDQ9XrbizL0xzwEB41mogsMtt+staCb5hS1Rag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=la9dAlEoAtSU3O1esgKKc2ArUFyQD+Jk3DSi5gI9sDCrF9Tt7PYoD9KJ6ait87zP3RxH9bbyV5yGbxqnLJmBcFlCCIiKD+3/sZjtfU3ixibGqcOBcSKsUg2cWSJIKujZ0jlEs8e2ZdlEqT1W4nfa98jkAdHbP2AW2tPM9Tz0Yas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qn9XLowh; arc=fail smtp.client-ip=52.101.53.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qn9XLowh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjHThXNrYo6rfqJE6HnTaT6EtEV5ZaIB/hSeHqhw7Hd8Dg6B8zE5p01WxhJi/MF8YUjlVgFWoJFwjY7L2E3VjTTKRA8JNUKzyqW/oMUKyz3hcwAcOdso3GNtibtC8Lmdz/BT+esTjIt2qwwPAcdu5G1LR5e1iKaUHA3kz2f7Fm4BD2lSyYCyst82HjFMSJW/uMA8va6OYE5wBnUYUhbE/usPQdtrZSBjlPTxzjqEIMK6VN4N3ryE69gg5h5TS0t65tGLBZO3ttpehBOMAQ/rmZGf3m6sRRLhSdnKNXtOm6VYf2dn6jSKdMiEu5m9eprw0y/vBMmBKpimRB/ADz14rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs54aFBIeAaEaBLGcKtrcd4IlWENL8TkVozh4TJYaYU=;
 b=eUpU9EwcktEI7muMXpEygFVjA/VP5mZvSFulHuCS4nnv7iFn1+U5NqwBpm1ThUyTSTZxyjCBDDPpTqS8t6d1gar7JrR2biyCIEkQaz6eQEVxGcA9QE5cJuQPYI4bEAt0v36DQ1DC9EQK3JUEQBBfymVXiyhJ0eBJHaosTkH6kcAtxT3bPRMdUX3B9lKBFD7xHL+jNRvIpL0R0MAgf3dnIN/KzeouKf/iSW5HLmYVgM9s94PL4qYE03jbBm3THe6whQ1qx7IhHBbLp8qAU8fNLsFLEy49pr+tE5sxbKKdkpnEAGo9TIbS+yQzuVl+dU7MxYMDuNvAryQI61dx/Cg/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs54aFBIeAaEaBLGcKtrcd4IlWENL8TkVozh4TJYaYU=;
 b=Qn9XLowhUUQbhf0AJ6/4cjiWqyqbor3gFt6sQM4qT+ZG6tPEwCtK3wJwq7N3N4JHTbo53Cl5SzXzHSmyGkaF89OAvWdeV5YRqpBy18kfkX1DFqMQHVaZ0cpqnsv3X2oRbQRnveB1YU2cGic9ZWzo5aaRdm8GFWTueLqMO9q//PQ83+7FaWMUotIy0AANi2UHUwnzg05OTGoy14aptq4tbxOg2x+FzGsQXQ7DU/g63GpyG9Ne48rSv1fGoY3bZBP11zYbFlPvdm1EH4BtQ8fPM0Gs8I9JX7AIZng8pqZHz1N9aa+QZpg8y3a9lA2iFa27eI1tzlaLqiVpULM0iiL3hw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:18 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:18 +0000
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
Subject: RE: [PATCH v5 08/27] vfio/pci: Fall back to plain vfio-pci when CXL
 init fails
Thread-Topic: [PATCH v5 08/27] vfio/pci: Fall back to plain vfio-pci when CXL
 init fails
Thread-Index: AQHdRgp9P5ywQhYQc0Kem8vSBssNdrbZ5EQAgBrm4yA=
Date: Fri, 9 Oct 2026 06:14:17 +0000
Message-ID:
 <IA1PR12MB90305F4ACBFC2094CE3EE8FBBD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-9-mhonap@nvidia.com>
 <20260921201502.0ed59b5a@shazbot.org>
In-Reply-To: <20260921201502.0ed59b5a@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 92fbb7a1-df8b-48c1-373a-08df25cc8d0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|18002099003|22082099003|10067099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 sFIS3cw6NMEbG0YFI0PuQkfao85LU0yHiXycW4rksSMJiAi+aysrJv0PmhuSu2HEP/NhWSvW/z8GTQN16LmTjPPsNrR7QPMv7nOwXiuUtL/lfme8B4PQfAjhf4S/l/2xZu6Ry8WYXnYp6SmwV+knr/bvIsbWZGk14S4Rfu3aAcwu3cTb9eCP3/Un1NQiGgQBzSS88/s9ew4YhlOxYWEPP8/r2LGlKvEsGxktTeuIc4krppGC30YN3XqUzdiFGfd+K4idb5KpMaMQJrKDgjWhcE/z2cRT6rjq9HBAJtI0MSX1OPF8DisvmhA4QdcsYyruy9lyVRAGUGBs3W7RNwiCq71Bt+YFlDb8ILjmi0h5vlVAwuUbEBvOSkyjS63sVwYxv2AC7UWYCQh1LiezSJ6ARyCeJy5msVxGCaqIG5Yqv3RiwTGMEQ+YTeerRiruXH4e8LmZVRQrxoy5dCe7kb9+m+tVWgu0u0TpfTloDJUo1PDDS9VxMaE6R0KR7OstUS8KklQt6152XL96KkbEEfeNd0sRR/Ykbe0ON5DsCLCbiVCZGHzk96RfCS2xCoYXqzfvHV+s6xzPnHfSaBhMdoSLCNss4UysMSA7gulz6NQ5xE/Xyfp9cfAUe3m40XBx5tauc7UKwbdbCHbf2vg2o7b2IG2mLVHweLx/avvtbGT6ifAMh0seTupxvDF/CuZTWRjkU21Y7GUVFuzq9n2sknjbSzT+h00dDC5eRC9NbycPZV4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WUpmf3DXw07DlDXc7vLKCfCi6vYFY5nC30sfl+Q+8/AppHeA0WaKCMQ+mja+?=
 =?us-ascii?Q?jVF9lIaZTIAZxuArXobsvpbGWoZH4cVctx2itD4EjtexLibvrLFt8YDb/ZSV?=
 =?us-ascii?Q?5wguhyndBxoLXTekKMbw0OL8p3SRTABnpJPOaqhAinYUI5IJ2BkSuGoCWrK7?=
 =?us-ascii?Q?uVwQLQF5XZN5sz57VRrb966sKz/13Se8lH28IpsygcfJmt6kPq6FPZevoF86?=
 =?us-ascii?Q?DV+aa0iG6oomJkfzj9/1XWSmxfNc/NS1Z5rFFjSTl9juRwe/Pk7/BRihl5lV?=
 =?us-ascii?Q?XHND1MpraORuYZCj5fRRKFOcuI7yaVydt7V+iX484ga15uj6TDdl49Hk+HZW?=
 =?us-ascii?Q?wC5NbeEOJM/J9dclOjwhrXoD+sclgHsRMpDm3mzNJ38G34kkWhk+lxaWAybe?=
 =?us-ascii?Q?iZTwPPzA8PkZnrLbPrQ7vnH46K7fC4eHFE6dTVDR+sz5M40/r5607RwgW6tn?=
 =?us-ascii?Q?Q3XBcwGnCQbeZw3BJeNmw40NicV4mCheKVuz5Qnjy+pU4okU1JnNsjWQlb8f?=
 =?us-ascii?Q?bKNEwPp4iIQqt2sH4it23Do+mbtkrEJFS4ibk0Mj5wsKqL2UucHBl+Xi4mgQ?=
 =?us-ascii?Q?miBeQyKc3MS+MXtvnkPQ4TuVRfvtzN+yOmEX7bUcpSsfpmAz+zPjoHCClyS4?=
 =?us-ascii?Q?U7EeaaxMIkn4MomXsuh1IhsvZY+lI51/qtFUHlBt/YvPYNde6oL+KUfZ1/tV?=
 =?us-ascii?Q?EWnLysLgmeXeunV7AkdEFlFWsjy2vjQtx6wcZSYcFbQZ1TGioBPnRoexpCSQ?=
 =?us-ascii?Q?b06M3hd5O1gz7HOmlw3GvzMlLwGHewUrrT5R9pBThfcpabghZwQqFTBKpp2X?=
 =?us-ascii?Q?w0yW725NPJP3bneGPRX9PA1fbFCwgiE84rD9SjighGPqG11DdtTQQV/6z+Lo?=
 =?us-ascii?Q?++wG2K2aD/ZwXyEpBRpCmRpDW4fWOumT7n1LgTLobMI2Lqtx2uNc1qC6Dxbi?=
 =?us-ascii?Q?cSk7Z84hdg+eEuuiI+0t9AFet6pIzcJN4KAfBpPsUvfm6OLhWD7zUVk07yyO?=
 =?us-ascii?Q?WAaaohXR2bSnpcWZwdKMSfxuWs0f+XMLVCRpCK9UfCJLwvX4bbpfjx9MXsah?=
 =?us-ascii?Q?HlSGJCsORwQJKn5EfSGqmmce1BZX/dYwD8LH9rZgKLpSi3MPDYuc0lozy/tB?=
 =?us-ascii?Q?FhfVtxE/5gTAsGrdJ4pBVisbVYdbbGawDYPOcRzyAqVtiDeudkvoIKNSaSz4?=
 =?us-ascii?Q?i/9Hfua1EHTyfgYDv1RFDa9nmBMGNLJJldVKmEJ4tqhMvF7sqJ7IIaZKVGSS?=
 =?us-ascii?Q?C9rOtvuPqLPnuscIWDzUyfRjAR+p5kTpL8ml/b09UYnpyImHkks3dPUVWbPj?=
 =?us-ascii?Q?9ZLZlcD5CMTxotQoL8X4ONbgRjctQMpThzUOL74NTrLToBgpzi9ZD2n2nS79?=
 =?us-ascii?Q?P7XJcooB6OIRE1kIZX5QC3wHX479yOfw7aFjHedusYQlyC/MII+bm0aE/D8x?=
 =?us-ascii?Q?skuhMXPAIE+M467zNBEVFS1iwa6n6rZRs/Lg27dHF35PeeuHWyNWopSngJP+?=
 =?us-ascii?Q?w9CTCqduscrNnbt+/HN2V7RLJyv9+0pCqVVlyOqwZWzsr1H2HBADZdfqtGpV?=
 =?us-ascii?Q?R0XBl2hVyKJUpyUm8WtsXDFNm8yhL/W2sdSlSlYdq2/u8nwqj3FDp2UPgu9w?=
 =?us-ascii?Q?GyPZdY+DVqGfmg9c8lBNWu+VklcHxTaOPjysFBKg/qdtAzwVoIgFGIC2EuaT?=
 =?us-ascii?Q?5wRNHElaMde1gZuo6b3D1mce5N3tz17zqDKclKcJsoeGthxB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fbb7a1-df8b-48c1-373a-08df25cc8d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:17.9742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oh0PwRJ8eOZzunQqQJm1/BoaSMJnAYeTLfA1gKO9jaxo5fex8sfZa3Hca3Ek1ZQB3Gv55ueYs43BEXhbSvbjyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912


> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Tuesday, September 22, 2026 7:45 AM
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
> Subject: Re: [PATCH v5 08/27] vfio/pci: Fall back to plain vfio-pci when =
CXL init
> fails
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:21 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A CXL Type-2 device is also a valid plain vfio-pci device. If the
> > vfio-cxl provider cannot bring it up as Type-2, failing the bind would
> > regress a device that previously worked as plain vfio-pci.
> >
> > Make a non-deferred CXL init failure non-fatal: log it, drop the
> > provider reference, leave cxl_ops NULL, and continue driving the
> > device as plain vfio-pci. The -EPROBE_DEFER path added earlier still
> > retries rather than falling back.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index a63a4f5228b8..9a75c30b67e2 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -2271,9 +2271,17 @@ static int vfio_pci_core_cxl_init(struct
> vfio_pci_core_device *vdev)
> >               vfio_pci_put_cxl_ops(ops);
> >               return ret;
> >       }
> > +     /*
> > +      * Any other failure is non-fatal: a CXL device that cannot be br=
ought
> > +      * up as Type-2 still works as plain vfio-pci, so log and continu=
e
> > +      * rather than failing the bind.
> > +      */
> >       if (ret) {
> > +             pci_warn(vdev->pdev,
> > +                      "CXL init failed (%d), continuing as plain vfio-=
pci\n",
> > +                      ret);
> >               vfio_pci_put_cxl_ops(ops);
> > -             return ret;
> > +             return 0;
> >       }
> >
> >       vdev->cxl_ops =3D ops;
>=20
> Why isn't this the initial implementation in patch 6?  I don't fully unde=
rstand
> why patches 7 and 8 are circling back to modify the broken behavior
> established in patch 6 rather than resolving it in the patch where it was
> introduced.
>=20
> Perhaps rephrasing the message, "... continuing without CXL support".  "p=
lain
> vfio-pci" doesn't mean anything to a user that only knows to use vfio-pci=
.
> Thanks,
>=20

Agreed. Sorry for this churn; In v6 I will fold 07 and 08 into 06, so the p=
rovider
hookup lands with its final error handling: -EPROBE_DEFER from the
provider defers the bind, and any other init error leaves the device
bound without the CXL extensions.

I will also update the error message to mention "continuing without CXL sup=
port"
and remove any references to "plain vfio-pci".

> Alex
