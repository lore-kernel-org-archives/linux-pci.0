Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DD46D559;
	Mon, 21 Sep 2026 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984338; cv=fail; b=SRiaBbbCWSfoQNl7TJRgdpSl6JorI7ig5Y4z4ZHbC/mqNRTCNEJANk3Bb8R7TjZYbl0MookOlLLLwLbyU8t064NGYTj81GEkVGAdx8Sg9DUlmHy/sq55F8Ef9XoqmHcirgaUvxkUOLeB3bGv4afbHGdTbacpoviOnU4QANA3EvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984338; c=relaxed/simple;
	bh=ogVYGygaDXLXvSGAVi3tmTp+/fYNxNNHFOk0SyQXlIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hZJdOv5DkHxvCRWhdpazsjoS/n5T/+hoLiHuCm6Bt9AF2USuLbute6ci28fMzqAhgFiJnTZKX12N7u+eyf+wTzYp1kIfUnEp/+MY8B2eF4meObZrNwAid0v2NLmyP7wn6lPeqqPkwHAZ0h4T7hpOI3cWeS8gSFFbrj7h2hT4klc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oI5XISVQ; arc=fail smtp.client-ip=52.101.46.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oI5XISVQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+uyqNwprQ7PkL+AP5/1cmQXshD+PrGRGpAsPdKUeruCFSqL21zsEsL2A2SaEdO88JpNltOQRVOjWS7sY+QyzJuO26STSslRfjYwwiYtKdLe6XaQqkdWjnJwTJSIHJ1mGRrBjYhOZp8P6Exp5ivbiF8nud+2bccEgwD3GXRcPebVAFfo1gTJpt0qGTkclLhI/AYnk7CGzr6YwbCvKHhOzS/GjrnYOYUN4kxVgFyfT2sw8aCdeAFg7mRt14Nn1ZqePO3nOzxVBb6D5hAP6JCwWuh3QD6apwLIyWAAuAcfycxb5wCHSLgafV5HS0SsAMmwSUOLpSb+nOegXYt8cJdZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCrLem1ctcpKsq/AknOhYb/GXtQSTA+YS0dV+9XL25Y=;
 b=AJVzLrxE5LVTA5bBzmf6AvDCeHOZiCFIHQwdTp7QB/nEHdtQJvoJK6i/JMDoxe7e1DVOMEpTNgh/Ubv/+IIRZji1Iet1KwoBsPhJ2Vd3MQvL3ri3ZeWV2sEkifkL89B3/yQ2fQar+RmDkQK09B4NZmkuV58dsFcYhw0OW6bXHPxhB2DO20nGYDRTppKPoDhN2PCLGauf9Kvam6khtEGM8WVGROTlg0AN8JeoJjU/AGlwCnd8vJ4/TbbK4aG9c6+IXx+Ouxkvzze722ibEGxegj6D4fSutzdXaYuzhv7brU8QpLKRL5PmLztOP8N0nGa0TJrOXP/fjkGaBR/1eAPvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCrLem1ctcpKsq/AknOhYb/GXtQSTA+YS0dV+9XL25Y=;
 b=oI5XISVQoaJVf62dVUB2PzIWhVtoieRBQWqqO1hnmCpzWdlnd80IVNyGxIvKf/XbzYzKcxXxLQsqCvq0gcgqvXtiAF+FqlnBhKaIfg71iWwu2nGqKgQ1Fqs9Jx7v0CHodmcac1NRTqsVeiqJB6m5RAXQ4NKXpoeO+DVAcApQimt32tgU6hbFgtjvxNhM0eORFuIpKqS3VD2cAsi5uzNU3NGqGcWA6IH3mXfQudQoq2/G0DJimkOla7oiWsJUevb+pTnQrmv8oMA5gM+Im7U7M8eJzvkaU+ebCHG98wnb1PkVr2TaSTfnPT3TWe5LU3s6SGTErsSE5j7qZuNXUA66lw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by BL4PR12MB9534.namprd12.prod.outlook.com (2603:10b6:208:58f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 09:52:13 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 09:52:13 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Richard Cheng <icheng@nvidia.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	Ankit Agrawal <ankita@nvidia.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>, Srirangan
 Madhavan <smadhavan@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "iweiny@kernel.org" <iweiny@kernel.org>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>, Yishai Hadas
	<yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
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
Subject: RE: [PATCH v5 21/27] vfio/cxl: Exclude the HDM decoder registers from
 direct BAR access
Thread-Topic: [PATCH v5 21/27] vfio/cxl: Exclude the HDM decoder registers
 from direct BAR access
Thread-Index: AQHdRgrHAuorG+bHmkC7koIg0uVN17bSYEEAgAZvnmA=
Date: Mon, 21 Sep 2026 09:52:13 +0000
Message-ID:
 <IA1PR12MB90302789C230A974B8922D9FBD842@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
 <20260916183540.3813685-22-mhonap@nvidia.com> <aquVEF7pLCpQxYwa@MWDK4CY14F>
In-Reply-To: <aquVEF7pLCpQxYwa@MWDK4CY14F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|BL4PR12MB9534:EE_
x-ms-office365-filtering-correlation-id: 3ef57673-b392-4614-7617-08df17c6035d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|11063799006|56012099006|4143699003|38070700021|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 c1JD/bsTMIeB1EeP8er7a+0PsznC2NIJjKTrqUf+1vTz8HdzFsx91TYHaSVbGtv0FcaL0Pf8HmIv46bfa/gRYz1Akz61/b0yqz7IdUVCsSSqy0HxLzjIHaAgSMdhN0daeMdIs4Uqwqd9ac+UTTunDpqepZDYhzdFqYhbEyxwJgsrbaE6zxjuY6VxQRRPGIlWaAm4g5Jn6eziJ0IUeUpdMSNq7iqcv6xj2N7m4Gb0vSp4BuWDh4p+mb5JnRgFJSGpGY08aJszNPKeaV7cAmZNGUwCR/v8zIl4CONooE5ShdYxYxQfd7U+0qyFXas3/9jJuTJMAU8s+SuXgml3L70yaQDvl9CqxvaEy0AbBp1RLUjNdBNqr9Ek50Jz6uRqIsl+OXqNEvEcmTQja25hSWjczJtCI8xCizAI6cCenLzcw6BQtfYigMYywW0AHRPben9CFrqxS3LTBTAMh7LZG/56Gvo7mWog+JKz8Q0orT6exyE5DdhngQHEfLWp0mQEXb22r7iN/7OQ7JHdW4fB5Nl73VVlKZVRUy0o6VDH9J6kYh5ADDpOQdOED9ZA8BrC4UQRJuR3ETOK6cXM2Ci2mu2cq13K/A172Ahma/3lJyR+ES+nr3O+c4qj80ts+N+KTFy0Ja90swTw1NjWxijhPj/OoNV4LcOPb3LDGS8xns0xRjVjtOkSB3YdIU85GTQgEfyXCVJTDsQxIBu271kbKoexlqoCX5lUWQDZiGRPiYYSUqM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(11063799006)(56012099006)(4143699003)(38070700021)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vq2cX+jtix8238Vvw/T+KYdFyNe7d4gDR/kWGcsil77Qg4FsQAGfXFjPobfX?=
 =?us-ascii?Q?eXSPWa8caxNHLP72IZu1/2ZyFe+peF/5DlAq7joUeVg8SCxzFzQRDXf/SPte?=
 =?us-ascii?Q?tmSfn+io7D3JxGXrPcNColMcTt2NMfOJTAFGdG26bXLL+qHK0iPIIGu7P85z?=
 =?us-ascii?Q?0KRJmSjdcRLHVoDDxFKBO4VQWzh5bKO0ZjQ172SEzv8bwCFQcM6Vl8kYKtLR?=
 =?us-ascii?Q?PJM7dpXttdKDVg/p17Dh0p9PRgyxwpXOk93IG7gvVsKzpmVM3iz5FOOlD2X/?=
 =?us-ascii?Q?JcVYvRpDBMxD1plkTv2kXeh41VMbgpdm60xGvfZwg9Zw4yRodhp7jw69f0j8?=
 =?us-ascii?Q?G4ExeC4qUgGbmL24KXSXHvNbOu9y4KHRt+Z1P4Dmjzv003f7UOK/vua5As80?=
 =?us-ascii?Q?5uCQMjTHIVJIgDuC+F1CVxMuQPItfFzdXvxvmAxQh4WttNjUt7teXz6DTnts?=
 =?us-ascii?Q?UDrF9p6ldZ1oXsARWe8F1qCZlWVKiIrudlD3vCGUrYdxbr5q80QMsbR2Pq7d?=
 =?us-ascii?Q?TQttDBTueKTCLzXGwmN9ivIOqRVpBfRUr1bSFIDYzVTexzCsUC+e68FGwrMv?=
 =?us-ascii?Q?4+irFgJx+R5mZZ50tXhN4TJ5Y2NRFeQqBBsAzYJ8VbyN0mXPZvmDsBOnsGrS?=
 =?us-ascii?Q?50NEkZ6RYuWHZuK2g+EvpuVCEdJJ3ib/Dx63ZUNEPau+rhMse1reNbanC4rH?=
 =?us-ascii?Q?qYLGRxCKKtAJj7ZVJkqj+uxXUaKeRu6dZz2u+4TvvbaQ0iSOzz+hxothxw5E?=
 =?us-ascii?Q?CoFa9aCRiixLe9pAuMxVcoR7yTS+q6gvOwfN1556i0o87/hB1WsHsNVa6Vz9?=
 =?us-ascii?Q?XtNIYzYTHl7FL5IqP6Q3gqVL93jHBndjUiW/foEPG8nIzxaAWdRutsqge5UT?=
 =?us-ascii?Q?1tt1W2QlNyRB/AEMwOYwuo6YrMDR8II4hxpl028/fYdK44I+eswNJUcEe5su?=
 =?us-ascii?Q?ByM7Dk7Etstu0x1YvM57X3KpsdUpk5Fp6D/qQx35vfTBJZqN/JUPpYga6fUu?=
 =?us-ascii?Q?drNPsCUfBBo/sy3+/wwJcABQnlNy8acHFEDIfDvmpsXIDBpqWUG0mJagRVyE?=
 =?us-ascii?Q?Yy3J9LKdSvob4EdZDCw5Zra37gZiFwygSuq+ChxfBovyjbk2sPsVumb/UKFz?=
 =?us-ascii?Q?palNuxbopD33JD/5/1hc/y6wntq1J1/2a+lC+mspmf6Dit5IRomgurISSIhM?=
 =?us-ascii?Q?mjTknpFWSWjF6oRem89p/046arvjk/Gj2D95cYVfjZKh19d2J2OnjdgCOOBo?=
 =?us-ascii?Q?ks360fVNNjgTclC61WZrdYwZddYFZfaM7K8wSkkJeR0ghEyjkOVp236PYvJ3?=
 =?us-ascii?Q?DNv/AJgJEiitrMhNY34UCz/Zh3aAacAGm21+IDvns4TMH1kj1bU5dHd1r9fw?=
 =?us-ascii?Q?LFDjkhzDDao4im+DYUtbT4Vw2Wp9MZ5doLLge3A/+LCOvEaHbUXWQXer1CCV?=
 =?us-ascii?Q?V0BuYBXoEqQAV/E7/NRKcBK3tIbNkGRvxp4nfv+V8KTudpE5PJBlYFKFkZy5?=
 =?us-ascii?Q?K/lyHPCyujxerTMiE1+EkcrpIxVfy5rtM2mhS179q7MWKGjHF6jSlOXfXHZ5?=
 =?us-ascii?Q?+nhPXvtI861OFssFJeYVJ0Ir9jx7KG3VD+915J88082mPq8dF1MQEM0Kr1ew?=
 =?us-ascii?Q?VnKeaxvIPHq497JTR5SvG8WvCiWKusT9CQel01TFSdnJnW8PkUEaLi+8NVIY?=
 =?us-ascii?Q?RyMHP1+QeQMzof7mpMkHdK3Pduf4qyyk8wrWRQAGe1IPydxm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef57673-b392-4614-7617-08df17c6035d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 09:52:13.7085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 910dmZLrQJNLBjkTak1NTjUVZqgffiTF2fQxHGHeNvxFzqnE2NJurVKnvv6iZsk3K9DWZXOsBM5yPXrNiG1vaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9534



> -----Original Message-----
> From: Richard Cheng <icheng@nvidia.com>
> Sent: Thursday, September 17, 2026 12:59 PM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>;
> jic23@kernel.org; dave.jiang@intel.com; alejandro.lucero-palau@amd.com;
> Srirangan Madhavan <smadhavan@nvidia.com>; corbet@lwn.net;
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
> Subject: Re: [PATCH v5 21/27] vfio/cxl: Exclude the HDM decoder registers
> from direct BAR access
>=20
> On Thu, Sep 17, 2026 at 12:05:34AM +0800, mhonap@nvidia.com wrote:
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > The HDM decoder register block lives in the component BAR that
> > vfio-pci owns. The guest reads the decoder only through the trapped,
> > read-only decoder region; it must not reach the physical registers
> > through the BAR directly, and a host read of the range through a
> > kernel mapping could abort as a fatal host SError.
> >
> > Add the block to the generic excluded-range list with
> > VFIO_PCI_EXCLUDE_MMAP | VFIO_PCI_EXCLUDE_READ |
> VFIO_PCI_EXCLUDE_WRITE
> > similar to the MSI-X exclusion.
> >
>=20
> Hi Manish,
>=20
> I think we need to block eventfd write and BAR DMA as well ?
>=20
> Have some comments below.
>=20
>=20
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index da04776356e4..37e8a3b54cfb 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -435,8 +435,25 @@ static int vfio_cxl_add_region(struct
> > vfio_pci_core_device *vdev, u32 subtype,  static int
> > vfio_cxl_open_device(struct vfio_pci_core_device *vdev)  {
> >  	struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +	struct pci_dev *pdev =3D vdev->pdev;
> >  	int ret;
> >
> > +	/*
> > +	 * Keep the HDM decoder block out of the guest's direct BAR access:
> the
> > +	 * guest reaches it only through the trapped decoder region, and a
> host
> > +	 * read of the range through a kernel mapping could abort as an SErro=
r.
> > +	 * Exclude it from mmap, fill reads with -1 and drop writes. The list=
 is
> > +	 * cleared on close, so re-add it per open.
> > +	 */
> > +	ret =3D vfio_pci_core_add_excluded_range(vdev, pdev->hdm->hdm_bar,
> > +					       pdev->hdm->hdm_offset,
> > +					       cxl->hdm_len,
> > +					       VFIO_PCI_EXCLUDE_MMAP |
> > +					       VFIO_PCI_EXCLUDE_READ |
> > +					       VFIO_PCI_EXCLUDE_WRITE);
>=20
> This adds the HDM reg to the exclusion list, but the eventfd and BAR DMA
> path doesn't check that.
>=20
> Maybe we need to block those 2 path as well ?
>=20

Thanks, yes, I Agree on both. The excluded-range list was only consulted on
the fd read/write and mmap paths, so, I think, the decoder block is still
reachable two other ways suggested above.

For ioeventfd: I will add a guard in vfio_pci_ioeventfd() to reject a
registration whose [pos, pos + count) overlaps a write-excluded range, righ=
t
next to the existing MSI-X guard.

For BAR DMA. I will add a check in vfio_pci_core_feature_dma_buf() to rejec=
t
an export whose ranges overlap an excluded range on that BAR.

Thanks,
Manish

> Best regards,
> Richard Cheng.
>=20
>=20
> > +	if (ret)
> > +		return ret;
> > +
> >  	/*
> >  	 * vfio_pci_core_disable() frees all dynamic regions on close, so
> register
> >  	 * them here per open rather than at bind. A failed first open never
> > --
> > 2.25.1
> >
> >
