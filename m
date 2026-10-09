Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5104252A0;
	Fri,  9 Oct 2026 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526480; cv=fail; b=Dp0CbRb8QUIfBfXHRXh7ijzh3Ur7UHsOSEcttYKrPtvkQiTqSE822dhzC1/kaoNVHnaPX2UWR88M5VLjSGG7CjE6YTuN0v1VFJ3meO7VNCKnhPzSQnxAhmn+2BWCfLfYZKSN/9rqWpRJUjCzFEkezH+5vdezNTzRkWUmytBBpFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526480; c=relaxed/simple;
	bh=Hl/jEIVe4JZbpFLemzXYxem3Uh3fBMjCHCrN3dImoB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CfyNNLZ+8P8JzJLtGJ952Kku5QTr+ahs69qoxZnAUZuy2K800ZzWZhNl3Xk85mxAurmjUS7Wt/dm8q614xu6ckj+rkgc9Y5CKrUwJa+xO5m0XyM+HTJqkxGET3lmHDgMFoyTvPzPaiS8196vGq+ropXM7hLL/4bryW0fVyRJVqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MrsniqK6; arc=fail smtp.client-ip=40.107.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MrsniqK6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvE9S7Ewj3ZqfqXC2wUeagMxkp9HtrjmUlRLp137s54kHVeC5qw1LpBTLVVqgUz6L1Lw22rrJSY4Akq7niOGfSSh2FRNfrH+o5+jkw26ZxyWK9DIUNqaFeNiaoCc+i9tblrfWFdDQsJcXcXorZ/AylWjKyqAKxBrnXiruEOijIFLS20ugeZwMLXf9fzhI4o4BVAraidLZYrOlDw75QajMCbaFffe2ZPh3SYMqhb1/1ZyRWfcKq20SmahzbQDTyBgJvTq6YVuOeA9zTpaiXumHZ/ItSo0nOFWxETbLEbmWTqXmJ35JXRtD4CzwGBDUR8ESXpgyoJBMx9+92huZGollw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/gcIdh7l/hi7TMLy0gwnw3WoY7M7bg636bc4CgQHv4=;
 b=TyFRxa1l/WxhRoUuakQhxL/Qp3SVya1DQ/8qqvNEWYZFkhG2oC45b6fH5svz+AvGG91HX5hbC6X/vsAxam9YWno4a5mvfWDT7JnlerqnE6izFk0DtuGiOP0JuAdKEh0WTsxngpSVBhgwU1ud/58GlDqA4kpahUgNqsFoCJSI/jRsG7aWpOuN2zdcLvoRN2q/pgKBQdl4U4J0DlqAV0oGU2Os1nmiHmhMyGa3x+WRIwGccuH94QM5rbdTOllkdCBR6s2rzq2wnyHwVFBPt/m6VM9iGNBl/BSsKzkN0RHdcsdIKqTl5RGtXJW368G1OgaZM1DKB+qL6KJo3igFez8BtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/gcIdh7l/hi7TMLy0gwnw3WoY7M7bg636bc4CgQHv4=;
 b=MrsniqK62kgeBxUs5kUnRoWx/qaaZd8/Tzs3qoBt2QiOh+xzTpaq3KbAMOmNgCeYcFJ9Il8NilHZKKU4XNRyorZ1adZnUlnfaJ6qm7jxKZgiDiLQDu0uxuaoYZ9unfRMEhKGQZIgbgH6joC8No5L9/3H9wGvw00fsWKo/GjWUJ99YFs4UnqLLjsYapNV1JrNudOpe1IoEEpyom50W3wvcysi4aC5UsSL6O3cFlIQTVu+Y42YWOWw+SMDVpoKi4/kpe3sgLGznl7bA6CoK+KcoxwUivflBW/BdFSBpFm02xG6zkurzCVQ03c5pMERIo2C1co6zlbYQUk7ViQIQEz5oQ==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:31 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:31 +0000
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
	<linux-hardening@vger.kernel.org>, "Simon Song (SW-GPU)"
	<xinmengs@nvidia.com>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v5 13/27] vfio/pci: Bracket PCI resets with the CXL reset
 hooks
Thread-Topic: [PATCH v5 13/27] vfio/pci: Bracket PCI resets with the CXL reset
 hooks
Thread-Index: AQHdRgqVhv3XcqXN2kS/Yq7ONFSKsbbZ5B4AgBrrGoA=
Date: Fri, 9 Oct 2026 06:14:31 +0000
Message-ID:
 <IA1PR12MB9030ADB60089A51AEC101BCBBD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-14-mhonap@nvidia.com>
 <20260921201430.451af68f@shazbot.org>
In-Reply-To: <20260921201430.451af68f@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 34ab3121-e88e-4c99-ce9b-08df25cc954e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|18002099003|22082099003|10067099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 RKC9qL4G06IvK6gb6xHtnFg1my+n4EsofC4CsMaLJd+4t1ybKq2hFcNw9xsgVLeTCsq5ZP7tu16XhBtKpL+O8jAgWPIAMikljlI+vu45CGXUlkPSkJ9yZjyyi5IBQGZoI3n8Axt/jLdt17UU5RxvSRgAdQf/PbF9TvwRs3dyNOrD0VHdBbOmvMQzY3qhfCffVXtOEtM6WxEX1bZWhA9KgPTY9CKDUxwb1L28qse9TaOAfRiLmiCTZQg39EBSOSDfwgLXZoeNA8QHUTq8dysg967TISkiZYn03nHLCb7dDKjZHOJiHDx8shIE0d3Zl5XrLfi5znd2Nf/7lSAB2Q317AnZ+PzScN9Fx/qmKPYM6zZZ8Ygm7QsZ4nNRmPpleZnuACMq2k4kUSpueniwsLWAWzEMmUmCpRizrSq8tQKGSbjfumgO0BLAzcz/u7bbQ2h7BQrDojolaNIsxMGz7dz873xCOzTY4YUAvtZpt6+zmJWdQfBXa4vvnMlP3Slx8Hxxw1Y17XCnWfJz57axnoAbhalo7hPfNELVvf7JHFkSC/ZzWH4I1P5yJ1Lu67fWqWX5fUsTzJ+pVU+pnzQg1c1Uvx4Xi2TBniQEHHXjfuhtcdubWvfrqPKuRtVmTKdkeLFuLGt1hpVtj/HsZ92vsCerJDJpZLJ4D7avyTWh7lDlhHiZ1XrC6ByTISRPHZ4PnujBsrvg4k+DJpqDW3KBJVO+Y47noPwm596r6k2G0TKREnU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fvUX33aApRWMN1K26q699zf6Dw+EkShIo7O0hAW396sqYoY3oQ6lNo8SEpbO?=
 =?us-ascii?Q?TagKgtQde5GhvwQT52QxVIAoYzee4nvOwj1FTBBbBVN/NoC3uamDJxt9uDve?=
 =?us-ascii?Q?dZOV96LHxGmGLkCvCLop6dgWU9kai53QIIqUyWOgKCyvVpTHUtC4kwp8YryC?=
 =?us-ascii?Q?4d5s60Jc43xhyJZuIDnd77tQCBIQTMoiuWLG/W3kELTIc/CR4/MZ/9pAgJkk?=
 =?us-ascii?Q?/AJ8K0J8OMk9fvC96fb15+IrfPLSCreKq9eMOtF7mPRzJRpUZ2ULQE7iZhKO?=
 =?us-ascii?Q?DFeCn57+BoqdiJdLELkyhQ/uRfd+WS0CfxeYucZYWZZ+LmkZfR1lv8JWCEG4?=
 =?us-ascii?Q?ATyNcJyCq7CZFRRr6Okz16tDjqpO8lqvZUOm3o7g7OdFAY1hEh2iFEeJKCQx?=
 =?us-ascii?Q?2Svw3SaNoHSSspexgPf9GyQdsf//VrMu3OrTSZkguw0zU0kZIdmNlKtBX56p?=
 =?us-ascii?Q?WAZPPb2vYWbEpGVMXkLCLVA1KVUayN8ehKCF9zj8kKR4SuA56D4qKcFUggA+?=
 =?us-ascii?Q?oChIVxFKiaVDeGy+VUu0GpJQVMJY80nTwd+HwQa8ffJs+2XNTpvvotgEVVTl?=
 =?us-ascii?Q?hXbWcgWPr5ECt+4g502Z9qB73jIxIBDNH3KS+4aXnzp/3twBJlKe3pUbFGpX?=
 =?us-ascii?Q?x3sgeCahfx4wKKTEgMdcOuTq1mJp1yD3xi/CEvRX9vykPCLKAUBm+13XdGSi?=
 =?us-ascii?Q?D9QlRrnZ0qxwih+hH1eL8JLwoKGWfW/DiNJ63WqRwYlDkQyxTK0ZB3C75a9n?=
 =?us-ascii?Q?tZQxWiOe/smoTU7WLGOq8YJ9Lyz4KHAgMSIYsEVsEaNzHTKqumf9HWpQeH+K?=
 =?us-ascii?Q?CphNyKZMWmFEQVXOlE4FE1YjECGMPXkMExJpZHtacmu/v52bPqq7V4kPK8zA?=
 =?us-ascii?Q?AriH8EGhVExONE14mdhRexb4JyBBvqX6OWvIceKbdhiPB7QEUWDwIXjd9HwB?=
 =?us-ascii?Q?ESauBZUCXyb3q3QXr0k34z9LbKcUqTMDphcTQ8BtpkcwxMJGdJ0VtaoT6Gdj?=
 =?us-ascii?Q?Nex4ht9G7hI6Pdh05eUbdnQxlwnF/hJZ4+Hl0g8kWPXn7t40o7Pk/IhVf3px?=
 =?us-ascii?Q?riIx6JXXvDJVPACP39dLGkNruzHGSDPn738ijiYUFq8ZM1Yt8oGNRZV98a27?=
 =?us-ascii?Q?p7Bdke+a/J6dfshCVy9rcmUN2mKx5q/ORvDVtJtDI1iG0EXlI5ABC29/G0uD?=
 =?us-ascii?Q?sUbl+lXxAd7qRabXNNzZEopG8F1+1yc7mqtP26m14UI0cGHNMiR3i8S8U6iA?=
 =?us-ascii?Q?ysFE/2tvLfAmru/Ak1VP61+sVOMhD8GSBzPALRs0fGOV18fPj10r2n4SXNVn?=
 =?us-ascii?Q?6ynS2I8NVVyKCyxD+kAQ/FkEGy4Fyo8YgzbncaSW17f1Vh+b/IQ2EOrIcj9e?=
 =?us-ascii?Q?EoGzBBAnJ6saqJ+I6/oXnSLsCrXezcLVQe1Wc7ZlU7kmh9DclFXrSUnNjbfk?=
 =?us-ascii?Q?w0LDYgSgmWQR2pV4krEK5m3fzoE3tH+NbyqLNwioljgIDiTqzvrP90MQlqWa?=
 =?us-ascii?Q?TztuF/CNk2sBvx8YftEYCLqyLPjdXSs6SN3wZhuWxYcaE4v7yUv20A55kZre?=
 =?us-ascii?Q?XHNoNYuhV/Y7Y4wDHzwM5Q8NekhVF8PprJmp5Cd551IaHAbPFfZxZKSSNjLh?=
 =?us-ascii?Q?zImOB+CxFzvpKOykQLbaOcHGcjIfp0lLnZdO37jVj8ETu5lis+iKOFYy1wVz?=
 =?us-ascii?Q?viHDllX0l1DRDtYOP3gqFWA/kClClQoT7++klhXQaGd05bZo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ab3121-e88e-4c99-ce9b-08df25cc954e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:31.8408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ToVqZIbkfU777jtD9yBYDNa9Imf+6xaiTRczCvJQ/i7ES8cKZojGR51/Mm7iglQVeYOT1zVmj1aJMCrMBL8ycA==
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
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org;
> alex@shazbot.org; Simon Song (SW-GPU) <xinmengs@nvidia.com>
> Subject: Re: [PATCH v5 13/27] vfio/pci: Bracket PCI resets with the CXL r=
eset
> hooks
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:26 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A CXL Type-2 device must quiesce its coherent link before any reset
> > and restore its HDM decoder state afterward, or a reset can leave the
> > device mastering the bus over decoders that are no longer valid. This
> > has to happen around every reset the PCI core drives for the device,
> > not only the ones VFIO issues directly.
> >
> > Add reset_prepare and reset_done to the CXL ops and register the
> > matching pci_error_handlers callbacks.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c | 18 ++++++++++++++++++
> >  include/linux/vfio_pci_core.h    |  2 ++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 2f593b2721a1..a91e07181847 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -2794,8 +2794,26 @@ int vfio_pci_core_sriov_configure(struct
> > vfio_pci_core_device *vdev,  }
> > EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
> >
> > +static void vfio_pci_core_reset_prepare(struct pci_dev *pdev) {
> > +     struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev)=
;
> > +
> > +     if (vdev->cxl_ops)
> > +             vdev->cxl_ops->reset_prepare(vdev);
> > +}
> > +
> > +static void vfio_pci_core_reset_done(struct pci_dev *pdev) {
> > +     struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev)=
;
> > +
> > +     if (vdev->cxl_ops)
> > +             vdev->cxl_ops->reset_done(vdev); }
>=20
> Flagging this because it's introducing one more vfio-pci-core use of the
> convention of storing the vfio_pci_core_device in drvdata that's a barrie=
r for a
> Rust-based variant driver.  Likely this needs to be added to the per-vari=
ant
> boilerplate or macro so variants provide the vfio_pci_core_device pointer
> rather than expecting it in drvdata.
> Thanks,
>=20
> Alex

Understood. In v6 the hooks will take the device:
vfio_pci_core_reset_prepare() and vfio_pci_core_reset_done() are
exported with a struct vfio_pci_core_device argument, and vfio-pci
calls them from its own pci_error_handlers in vfio_pci.c, which already
owns the drvdata.
vfio-pci-core will not add dev_get_drvdata() call, and a
variant that binds CXL devices will call the same two above mentioned helpe=
rs
from its own handlers. I am leaving vfio_pci_core_aer_err_detected() as it =
is in
this series.

>=20
> > +
> >  const struct pci_error_handlers vfio_pci_core_err_handlers =3D {
> >       .error_detected =3D vfio_pci_core_aer_err_detected,
> > +     .reset_prepare =3D vfio_pci_core_reset_prepare,
> > +     .reset_done =3D vfio_pci_core_reset_done,
> >  };
> >  EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
> >
> > diff --git a/include/linux/vfio_pci_core.h
> > b/include/linux/vfio_pci_core.h index 643f32c2141f..6ebf9a26275e
> > 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -72,6 +72,8 @@ struct vfio_cxl_ops {
> >       void    (*release)(struct vfio_pci_core_device *vdev);
> >       int     (*open_device)(struct vfio_pci_core_device *vdev);
> >       void    (*close_device)(struct vfio_pci_core_device *vdev);
> > +     void    (*reset_prepare)(struct vfio_pci_core_device *vdev);
> > +     void    (*reset_done)(struct vfio_pci_core_device *vdev);
> >       /* Pinned per bound CXL device so vfio-cxl cannot unload under us=
age */
> >       struct module *owner;
> >  };

