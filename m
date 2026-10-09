Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E17449EA4;
	Fri,  9 Oct 2026 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526477; cv=fail; b=U57LHicvkmCxn0hmg5WVx9M5H+v2MF/phCuL3G0y/jd9oaJ+iEtZuFJIyFBPLdIC2KsoXD/GmlgN4GqWbaZyO8iXvc6/BxCMV/hRZR7Lyjv4cWgMLBcB/ZR+xrPAwILQJebTmlJqijQGrmqukdCj5kRsc6te00v6PNM9HP2zifo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526477; c=relaxed/simple;
	bh=5cQ1ig/FPbVzMrwBtR83pK0+fzqiPmhlKobQXWXb4aY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=glKEg/XteDjyOfoGtqEH05EZdDGC/QbPUTWYRatpss7d7LMGddyyOTOMk2fl/LUNbmdOIC+QOy+VPh7JXEIYNtNSfhwF2tCASpdmD92FewF7MRdrSkb/YU2wHpy1yfI5FdIYdyaKr4R+vkwTp6JdZOe5SIRvTQGenHKWlPTf/7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kO/zWmv0; arc=fail smtp.client-ip=40.107.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kO/zWmv0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X56qvID/WU0WLyku/xEBCSExeze5rv0f6Z00c+763qnOvdAtdEj1f2vWy5RcOWPnLTF+6Zmi4lv2uX/APgiQDzhfuYrgyD4BdTwZWDzW4Yxw8bY9Wu3JMA25cTLEDh7nutcQHh5EtZd1UirM21RTZFN2Kdm09tBvq7o8EbFhpJxJMpDxsPjHvC8klFCMuu652LVKRhNlyN5cgROmWzpyJI1lgO+RmQMOSSu6XI078LNDDtq4aiWQWrIReHcMsRcT8FEvWFw/DB8kaqvzNIBxQ9H3Ln2LI8Uf/sDqA/fxSG57Qgr7F7+2KO/bSfOrZzPcOAhtgpE33l9Im4Nb+WQ6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz3DZI/9aK6VXdlTaZm/F9DEQ7ABKAh9Nv088YNs5GI=;
 b=Hb4EfmMljTrT1OgmyfrtDFIXWGNReAme715ju7LZp6loAmTYEhArUmWo6rAJ1z5zqF2nkf0p1BWFhFCCHDNkFHmkWd2vTyMhxfX6P9hMPe65EMIEsxgGcHxgj90DNM68ukgioLWpyt8wm648EE2QPxa0Fp6TxK36LDJyNAsVF4K0QewcqMrLkxxlJcYAzrm50Yz3Ha66lFCzyviRTiSYX1ncBSg4TqQqGboYufhcJobZNqZ3bijoDzbOBJKXdfTipxTTtkBVwaY8XnLM+eZGZf6+rEuakKgS/hr3OCEp+V/y4drEyDU86IyLNr0SMY82DPdVy93Y03fDoG+5lzCYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz3DZI/9aK6VXdlTaZm/F9DEQ7ABKAh9Nv088YNs5GI=;
 b=kO/zWmv0P7z6lbOik0Up9YEogDzHhgOUpRdfLlM9b+ktUjC+mqluOG+895z23k5FODc4s8MJEPpZbjDTSoFg3QwRa7kEAG0d2relVoEgk4hWTT9L5d2X2rmMT+elm3PfcFgx+fiO5xDbq9G+uNq9llyylyPCGki121rrmUKjFbjjzX1TPBxy3vXj8kvkg/ODcKxWpxlvRVV8C9v9h31qnoqeEkWq/MPZ1OoZTg/TzUt77MeYLpQnD05aG5pxnf0knfvcNrb05mbJNOk79jhqlMgY4dhl4yvXlkCfooBaLdgJy4PpT6OHNDI0yiJRICx/iXPPOD2UhziMh++bj8BKHg==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:29 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:29 +0000
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
Subject: RE: [PATCH v5 12/27] vfio/pci: Call the CXL open and close hooks
 around device use
Thread-Topic: [PATCH v5 12/27] vfio/pci: Call the CXL open and close hooks
 around device use
Thread-Index: AQHdRgqTa762hfUKZU6tbHNkisYC07bf6zkAgBTjxoA=
Date: Fri, 9 Oct 2026 06:14:29 +0000
Message-ID:
 <IA1PR12MB903054A06F8DCD3C0850C374BD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-13-mhonap@nvidia.com>
 <20260925231730.45933ca7@jic23-hlaptop>
In-Reply-To: <20260925231730.45933ca7@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 9d0a0d79-e117-4a34-c041-08df25cc93c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|18002099003|22082099003|10067099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 r+t8LuBdM1KjcKawk25vZdrdrwBOmKsRTb5yxiMbgBoHJJ1XzM90pREi+zUdXB5ATbHhKXLQpjZ5+whkp+gB/nAbVD7xeNtN73ebZ/Il6NlcDd5Z7/kLOSfS2rH7ZBMZHyJXJ6rixIU405aDJq/IEa7ffH6LqxIuYJxhLRpEdVeV2ySVoHwf0BtOiTn9nFktzzYH9UH0F9R2ThmWso33nsxBzf2F3RCaQ0QUSsALclZEziCp5E8M86dgl6cScypmvzYUNZHO/BjYbsgEz4NjyuGPJIAyj7S5bpBGZz4UkckbS7h8tob2PYKrC1yRKJYGdvrCmiln0iUhmXsf1XUSWvKuqHIjItEXmUGwSYYSTa6E2qRV47Zw+YCRs8zWniEz7ffyk8ibsFssoE/R5fWZAmc8AGVM2Hq9O3CKFZtnZlxaffciq20a6f9YCLJHCawrA6taAqOgyDkt1sWmZxP6loY2HSwtd/gRHjbC66dKKWLJDXSuWGg7R6vtinOkzqsIaYQXGlJrnZ4U5IWPV3DGubdQVmpMz0PcmQ2yghVZmTCduvOaiAB8/uX0UB5qdXT2DE3NnzMIvWfcMQo3htn4LxFwU5l8NgYR65xpR6VoNm8vKvBtHWveqD66R6u37L1G3DQD8dWMzAPPnNVELGKAUSiPXnitUdAbJfwXdwXrgVH+gsaql4g4NxAuRwNgDKFW7bjfoiGSWXXqoRRg784oX5cbIdfy2WLBeGM01ylzOTQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dAVaDI6KFVEVI27JUqgJmxGXZtEOrq7TznhEm5xY26BYW5esJdibemybjJKH?=
 =?us-ascii?Q?1bG1F2itCbUEXQr1CIYWzF3MXc7fCZWxC/nhXQTvkEJcQC2MGcHQQUKsWJ+f?=
 =?us-ascii?Q?/eso3V2pMxFUnMul6XeVOaV2MyxkxxCcUGzy9cr4U6wQqBEsdRUfTLpu6hav?=
 =?us-ascii?Q?ydCrogcn8gTwkv/+btHduoAEWF5MuBHqS+jLYdY9rZDeVl7Io3PTSaaYd8Rm?=
 =?us-ascii?Q?7tQnD3sMzd0wqs5z88fWrT9+SQu5TZWp/2f7l+sPYLrSDfxh33pt3oHVg/ge?=
 =?us-ascii?Q?ievIeqffGbxkDwKTX65FgSbJYXwedoY60EkkbjlAJ6qAN047wylpNLZlBarb?=
 =?us-ascii?Q?IGP8FrOB/YnGVLb2D2VLfjYZKOHsbTQncyyeyqezqGSueIjTBH//7mYNiYP+?=
 =?us-ascii?Q?DpuIHBU9Wl7Qd8qUcgBotq6PSwa/3u2plrO2ZaQXeEO1r7l0GjdWTgMAXW9S?=
 =?us-ascii?Q?1UNMg9XqfzjqnHs+eiEYDS3TlYo/CPywnvNPliLiyd7QTSWCKnI7bxy2hWb9?=
 =?us-ascii?Q?ndtn0ok05vgI6s3xToKO2eriubovilbCfkn8pSTEw3tqXAQsiQDM7LE7b4W+?=
 =?us-ascii?Q?/uct1k5W10+uVmm+ACNINkSrgXdibJXIhnsY4X51wcasqBwDyItOuBeVrNZa?=
 =?us-ascii?Q?Kvm86EDRTVtFi8zgDCHfwGxe3TslziX63BzG9/uMonH8SF8ZJhTT67igiNLd?=
 =?us-ascii?Q?WPnI2fzNHGja9l3bn5754CskYpBMd+ZCdm2wU0AxnLIHms3IrMIyLckDy3mH?=
 =?us-ascii?Q?lWhQp8bd2sOBROAzLVw4WjFxcmsZ5tKcxiV+JxlW6DfA2qnYMm+py38VVgB2?=
 =?us-ascii?Q?ZswWYTcnQ2o/9pfgfa3pzSQYmWAStHOzmw/5dEYCvIWAHufuaOKsl5OwMsPf?=
 =?us-ascii?Q?pum7qcmQLMxPz0mMJPBg/5wyztJLB6JkcRgwRxPdPrsRnNQUVaPuqqbi724S?=
 =?us-ascii?Q?CWAw3SR6h5Lb7yyz1OmNTisZXkovGc/QtJntPb17bbxHQ2cepWZC86vSkgji?=
 =?us-ascii?Q?EIkI+3cBc5aFFs/fnMErPZENymFIcdZv6oPlgapc57+oJmF7oUhwTAJ1aqQW?=
 =?us-ascii?Q?bcFTl8xt4kV1y4UtO86vjMLIeIAVbsvROy2qLAUYeQ5rPWYzyr0NkH7wQarD?=
 =?us-ascii?Q?SIE+t8g3KM7Ri9ZLDPZp0s3M/QoXQbwOhxtDVzGCwD40lpTDhRghl1dTBUDu?=
 =?us-ascii?Q?r+Q+UQWhYCmlct0tappPEbW6KR+amK694TiyX+55zazKrBAboZm2n8hXhYVB?=
 =?us-ascii?Q?WEINX1HD7genD2UBCAx73GfWddhD8wRl/c6iZ3u5X5ME1Z7pJJk+OP8R+z3l?=
 =?us-ascii?Q?2OTqljIyO31PSO8RRssjGzaZJP9EfGzGk6gKgjOYXFS0yJGxdd/WqBcvqrss?=
 =?us-ascii?Q?5OlNlGArOrUDaO16xkz6cM7XchasH+zVpvyF4SWpjVm/xiJKd9JkjIIOfwDf?=
 =?us-ascii?Q?gNuXHTQerQ9hI+6sWdCMkS7J9lQ5Xl8NwGYsEaOmTzCI0YQdYy6veJmNaWR+?=
 =?us-ascii?Q?X+wNkCFACtCAGuHV9Vjs4cyAMRE95lZxJctw3uj8uEY4eJQ5V35ORhUzaMXP?=
 =?us-ascii?Q?NUW5MIZ7S7nhTZjTj/n9N/2Wtpq7YJgPoiH3CAxzQ4Fg3wS0uAhDjzBXmcFF?=
 =?us-ascii?Q?AfLkl/XP8z0xfE5FLuq16VW24Z6dQIn/HfLDQNT0FBx8MCtmT+rmADgPkGaf?=
 =?us-ascii?Q?gqQyeaYuSt4tg31NoIFXwLH/iRZafdktYtdt196LU12+voTH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0a0d79-e117-4a34-c041-08df25cc93c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:29.1558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IET7KLACrD3ZdQo/deKrTPmms7KYpemlnB4TcUPLatwXMSvFnoF4nKUN5Z3fzlvVZ/wEJGek9Tae/j/gXfQnsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, September 26, 2026 3:48 AM
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
> Subject: Re: [PATCH v5 12/27] vfio/pci: Call the CXL open and close hooks
> around device use
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:25 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > Volatile CXL register state must be sampled from live hardware when
> > the guest opens the device, not at bind, because a low-power
> > transition between bind and open can leave the bind-time values stale.
> >
> > Add open and close to the CXL ops and call them from the common enable
> > and close paths. A failed open unwinds the enable in reverse order:
> > unmap the BARs, drop the excluded ranges, then free the virtual config.
> >
> > Factor the BAR unmap out of vfio_pci_core_disable() into a helper so
> > the enable failure path and the disable path share it.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c | 40 +++++++++++++++++++++++++-------
> >  include/linux/vfio_pci_core.h    |  2 ++
> >  2 files changed, 33 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index c5b7a59a4548..2f593b2721a1 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -591,6 +591,21 @@ static const struct dev_pm_ops
> > vfio_pci_core_pm_ops =3D {
> >
> >  static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device
> > *vdev);
> >
> > +static void vfio_pci_core_unmap_bars(struct vfio_pci_core_device
> > +*vdev) {
> > +     struct pci_dev *pdev =3D vdev->pdev;
> > +     int i, bar;
> > +
> > +     for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
>         for (int i =3D 0; i < PCI_STD_NUM_BARS; i++)
>                 int bar =3D i + PCI_STD_RESOURCES;
>=20
> Nice to keep things tightly scoped where we can.

Agreed; I will change this in v6.

>=20
> > +             bar =3D i + PCI_STD_RESOURCES;
> > +             if (IS_ERR_OR_NULL(vdev->barmap[bar]))
> > +                     continue;
> > +             pci_iounmap(pdev, vdev->barmap[bar]);
> > +             pci_release_selected_regions(pdev, 1 << bar);
> > +             vdev->barmap[bar] =3D NULL;
> > +     }
> > +}
>=20

