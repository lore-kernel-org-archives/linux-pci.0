Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8493A9DA6;
	Wed,  1 Apr 2026 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031368; cv=fail; b=o0HhGYk38ynvkQlzeauhRJmvk2PsiPaAZ77pJzgSgNnG+vMJtpezXC+uutlHYm6tcqfJp23504WEtC9nbKLqAPx4Piy1e+jhiVmLWzxYW6xGbhH0aNTKJuvGGJPbvIdaDbfVBO9f/uNyZHOSRyYSTTzx3D5KI5K+VgXcijesGEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031368; c=relaxed/simple;
	bh=v5XsiiBFcNUubM0MbNxbvoIxAZ2UK/uaJrqQJxr4zSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LIgiZJbCyGYkN0nOAkDU6qr2sguJL6UdXd6JhzsOTqp+WLJhB3JN7ov+2n5Kaq6vUTWiancCBA/Y75jT92XldU/uNga68me+EEvF6599UK6qECaDEOEOJpieXl5zoHRNvsz6AFsV7pcwm2ilIuySEoZbc2iP8UUmsvNzlKuOxkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IsHQd5d2; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IsHQd5d2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775031367; x=1806567367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v5XsiiBFcNUubM0MbNxbvoIxAZ2UK/uaJrqQJxr4zSI=;
  b=IsHQd5d2Y/WyxL562bx0NxCGx+2kY57/PRaYzzsltxPWr7Jr9eLu0Y73
   YMRPnUXQFA62yIi5Ycc11QAgorKHwOvYDoUVYXAoHIKQ3KF+JMrPNGa+W
   q8atbnjMmo2rCyRoSt4G+8QQy0naRynVBBmPo3AqFhpfMiiqdLEG9l898
   vmkzyFMN0VSh++D+/hD2m9IUxakHjQH81Pn4HU754q7g306CHdyZd7bMo
   pZ7EShRqjqvs/OeJXwF5yfqMC6vLZLEKlDD0miVIQdQFr9tdjGYvpTbYL
   RylDs91/M3r3v+aO8GKItJQiSpJkLr2FbthO7a65bDsa3Zx4v7Ybf/1A2
   A==;
X-CSE-ConnectionGUID: MsxWsuZiRNOAMfFd8bqMOg==
X-CSE-MsgGUID: ws+dUn9ATWSeUYQWUk+/PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76022527"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76022527"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:16:06 -0700
X-CSE-ConnectionGUID: nAZil3gZR6+I67/Pcb78gw==
X-CSE-MsgGUID: NPTqQ3QBT5+pszsZILvY4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="249826180"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:16:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 01:16:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 01:16:04 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 01:16:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtWoN5IEkXmhjl5d1q4t2xcFEoXzNhYgMVxmyC0+U2OxL0kwZHXxab75GreO66PDyoBo611ZouFEgI4KL1QSQL85eyBejaxTlcGPf2p8s6D/oy1v/1nKO/+b0huqCBanK+SAPHwr+gOtS3kLr+rfYRdC03p8wJRmNKgNEj3KSMOerLZFZENjk1D0WD5awi1bzqckV4xpVAU5dn1w5L1RSiFuZPnPR81SE8g0e6bNF0n23aTE3X4DI8WnrhEiH2BpnkfU9YIPPuD6ItOaXIusYzNFFTpywiiCDqjQ1jQ4PXdfAdlK+6YkE8IEbO9M4cre+72HlKF+K0dqj0TOFVwteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eng+b4MEisxC7KfFmKnoc1d7b4eQ7kGZkzJHRajk4dg=;
 b=k057cNQCRaZAEjhG61Xmcd9Qkd92XvB7BBnP9a7qc0uML0o2Mm/Zts49ZQS1fezPHK+KSBtxiR6S9tSMSNsoWb5P5eiEw/uOBK5LhfMcticFnEX5ZUDWFfTIA3yo+YthB8RspJ0bVZB2OdC2+bZ1u7pcCjzvauQrkHm0BZvqG9LAljlcpaRNpNCZ0tDYEVqKgipb5M1FWmzKPSOwX46D+Tiachdy0OmhlpBQELy/J/tfHljylHaB7E0+TQTUcor37xRmdzptmM/MA2zs/+EH+JXIRuzUiW3SG/zzl/PSRCIZVPRUA78Qrxp0yN+7geV9boDKts1CzrjyB0xZDw5CEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6887.namprd11.prod.outlook.com (2603:10b6:303:225::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 08:15:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 08:15:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "miko.lenczewski@arm.com"
	<miko.lenczewski@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, Vikram Sethi
	<vsethi@nvidia.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Thread-Topic: [PATCH v3 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Thread-Index: AQHcrcLd1vjxmcKV5EWISjNWHzO55bXIeBZQgAA6gACAAVEWAA==
Date: Wed, 1 Apr 2026 08:15:54 +0000
Message-ID: <BN9PR11MB52760B3C240197C7BF6639FD8C50A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <0e8d1ee1557c54943dd15ff836576de4c3aa58b6.1772833963.git.nicolinc@nvidia.com>
 <BN9PR11MB52760A7F20A1CC2BC0DB018A8C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260331120816.GW310919@nvidia.com>
In-Reply-To: <20260331120816.GW310919@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6887:EE_
x-ms-office365-filtering-correlation-id: 2f781f4a-8614-4991-1462-08de8fc6e561
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: Odra544GXXjtKVJke3jz/kF/MuJXPf0cwQjxDtizW5Et7xaVf56YJrHPVBN0XX98H7y9DEm3X4SetjfL87a+36QCoF3b1olk9X8xYnrhSnDZTzsC2BqpsHbzWhfPvsyj5cVOwPNNWdtlJk3vMNPmLeTCpJ8mss/V+yu4Gq9c4AIthuFivmVSdD0KBh6cRKebq/SL+gCkPsvO52ukN1D2auOfH0T3yRvaJRflC4UOmbmEiV8ruMzpiNTXj7w/q5jUKxQQEe4V14R1ewFn8C7+8Nqwxtb8FWzhVtiKJ9b2i4LFCtVig5O1v4JSu+qPCiDaTZpB72SnD5i0wRHWhZqWkQY58OkI2Qwf7qLi2J6yV+VQUz9dUVe5pYkqKqcEXvw93/ZXLX7qS7hC24RYgL4WJ4C9cIRQ9+A7CVxWffiJQ0cjet9+JrY7/MakEZR8DoUJ2ViW0t5IMadbQVdFhOPkyrogS0E8J4DQh0Xbx9hB8B/avsLZ23ROtUpcwDGNGoj58aBldKmlbFQrQDl2tgVpqFJQRnDxNbifH+3u8tSO0LoA+yrUlOH4pYpX1VhO4IONDhHIfaCWBXQJZNrcxTbwhBNQ72y7Upa77iwAZ9p5UV6hyBaxSZaa260ThntkEeJqcn8RiZvj0JyoFUlaOO+UoGsVFx7XEI6ScfyteaFqvmFrnYoES3GTs4D18Ln50dKveADbhe93k0dUEYtpAlOVWbnqeH5HxzMlJjQ5sFVKkCoHzMq4Pi6uS678V5x0lsYwZDrHuRBmOq4HpdYPeD9+D1lTw7BBIjQ5eNt2u2Gf6tw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bk7jVa4Gxgc9s3D0LCYONmB8TXGztGLiE+rvGmlxdCloFOHWI2GEvaVUM2PG?=
 =?us-ascii?Q?HF7fQ5AlrJa47KFzgDBcuxgMnC4kvn0uS10nMdjbysmrRqDRL8kZwQWnhm3t?=
 =?us-ascii?Q?g/xTb99pGcODX7sTSdvFQaDg2A0c0nsYP5KJOtvkk/GPRxhhGXGS8OZ7suGS?=
 =?us-ascii?Q?HsrKSOOmQf6l3xfqinzLcvf+OiQOQ8sS/Vlr90WBXOlzfM1cv6UXlWfDMDl5?=
 =?us-ascii?Q?3LWtVAdFicFy3VDtahv9Kh2JGqJOBz+xZuzpaf2CjF7SF98wxQbBdBrJfX9Q?=
 =?us-ascii?Q?qu7HeWds+D5N2i4L1CYdxK3WP1g0xEFo6R9/xNYpswOReEnfwdN4aJnhmlm2?=
 =?us-ascii?Q?1fuUg/A522U/yeJNkVZvR6bZ/Hp9oSCa3gpeOyP8VMwXtuqFjIT4EKxT+0Ko?=
 =?us-ascii?Q?ZRSqC9yD958EwFwh7fT1fNturWcry6bXUFJ2N7DWroE7MxqdzIAvJvitJdDl?=
 =?us-ascii?Q?836v7XLxrlE2lEcjdjRnh+330kboXzMVP87T3TWOkcClTQsJ081XgB6gOOzX?=
 =?us-ascii?Q?KoBTMPPrQLff1qub7u4Nht3AfUgLEG5AMsuzWivO6DlQrbtI3R+5TreJCmfa?=
 =?us-ascii?Q?dbaNdn6nr5HWhme0vGeNIb+QpXvUHgHx+QGziAaczbgTHxq1/RwtY4bw9KSy?=
 =?us-ascii?Q?Y3aWtL/L0bkEDEFjwVo2pJ4YXes43Rft8oW9CvbTLgAY9aMzvYDusG3dzYQV?=
 =?us-ascii?Q?QUz0OelCNrEDbpHjR9Tcr+wVe0Bm3oKwujsGeXlfSkaL/WXozPVfYOukdjGE?=
 =?us-ascii?Q?Z+KNIXY8+VNels5WZpf4HbJhlQtJTsExRGoihNeamVEV35qWl1miOZSCjkYf?=
 =?us-ascii?Q?GNY+ZQhknU2KNR+fVD+sUHTDZERDnvvOlLs5HDuEaY3CxSiSKvO35PBzqZK6?=
 =?us-ascii?Q?ZgGdz9lvMpQcZoigPNfjgqBKU3E8dVa3j2GbyT+zwCEp2Swk+GuzDEBbIcbM?=
 =?us-ascii?Q?YI1qZ0O+Ncse49j6yLccqvm5Pj9EErDvbxrzwdQEPE+uWXuOXyzryUEDNpv3?=
 =?us-ascii?Q?EcK8iX7cgmNcEBQ2uiPFRfnjY7p82f1cS/daRcRYOatNm9KsZNhQVZmCb0Te?=
 =?us-ascii?Q?TwycZQyfvRrLJXYJ533urx/6HY4kMgfbLAKqgXm/gSxiKUA5Rxfjs9yWrBmP?=
 =?us-ascii?Q?W9NGhxLJiGgm9QRa2bfQaNlQbu/sVewBjMu7OdAG+q1zAPmUTQ+SXrsAnB9/?=
 =?us-ascii?Q?u/mXCZYdl80fAeIop2IWI2afh5cWerCbnt4ZNu1O2XiMOA8p7Bxou/SxgNCv?=
 =?us-ascii?Q?Lt1C0bJcR/q05JhkeLt16V5Ypn7iq53KoJxj3I31bMy2NI3+hVCLV7e6fFBX?=
 =?us-ascii?Q?5ZHP13hfeFZ9V65UPj22KxX/TDA3671Xf9D5SzoecT/fWgPFx/DelNsEu3hY?=
 =?us-ascii?Q?bXlfNCDcdnBf0NqD6gJCA8/rZ6znwmP952HqwZ9wpNkxwUxzf3ZTvNCSh2un?=
 =?us-ascii?Q?FVitNVKjSo2leE1OPeC4T8bUT6DPzcmvrxMfzdoB0OiCr1hUJXUEOLfYLNjq?=
 =?us-ascii?Q?zuMtTm8gQIxe87v/MlGPBZEj1qM7IaV2B7Lj4vE5ySsJ4YJYdOV7N/25/sC7?=
 =?us-ascii?Q?itewkHGmFK/Q5AXmfHPtrv+jdjIYY6SsJeJTK8fd4M/tN6Ml9Nnro1vKf8Ul?=
 =?us-ascii?Q?xelNPNODM8njrjWg0imGZhhm6/qyNyfQ2xMpVv54KF7rqZLwHe+tRLXqjejz?=
 =?us-ascii?Q?ICN/aRRd7fqe/Gn0BLAaGcrFolsiE08OIVxODuTA/KPpbXnQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tY3oUKVR6/RPMQ7jXIDnmRh6fGB+oEYZzUpTsiIbUd2nz8Fd3lA5ulADL75hNf66oHa/sCU015eH1JC+o+2FatKVm65U2u+UqMkXgr9to75Z8TpZpySYHWDXW7fIGMV4j0RgOeUONj8ISaaFIZ+9Ttol1QSMh1OUXtB1xxDbVz2FlkuWzpQ0Q09t3s+MYaS5s34X1zYHocZp4FtmgdIo09G8ficDw0oHiA9JiCfF4QoHR2y0nLti0izJChqXSXN06iFC+eLqckj/ocrCKSnBQVaAjdoDreo4nXDKZGNPGmHdUxUYMPgdBNLDQdlJkqV4FJscwgJ6GvtXB2sJud9nGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f781f4a-8614-4991-1462-08de8fc6e561
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 08:15:54.7252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vp6yMl5EVeowbM5gjBXkBg0f1aJjtR7qtgm0ri6RCY8+fSd6sTl3R42Ij6jllAntEN7Y3U2CZDvibktYfnQfaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6887
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 31, 2026 8:08 PM
>=20
> On Tue, Mar 31, 2026 at 08:40:17AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Saturday, March 7, 2026 7:41 AM
> > >
> > > +
> > > +	master->ats_always_on =3D true;
> > > +
> > > +	ret =3D arm_smmu_alloc_cd_tables(master);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +out_prepare:
> > > +	pci_prepare_ats(pdev, stu);
> > > +	return 0;
> >
> > is there a problem leaving ats_always_on being true while
> > allocating cd tables fails?
>=20
> I would expect this error flow unwinds back up to failing device
> probe?
>=20

yeah, I thought error was ignored.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
