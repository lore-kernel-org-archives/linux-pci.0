Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C81363C59;
	Wed, 18 Mar 2026 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819088; cv=fail; b=u1AgpW6m+rJ0ayHOzyJgqv7OgbjSYnDxlXm7nAvA+q8C/WL7bpopD1Mh/7tXm5Fun3pOpqwT1ksCiJoQLvOx0jLxAGHWVQQaG+ht09TGLSA4+83yFLKOFGme4GZ0KUDsMTGxfuOIdt6hktMghdHcA4cg7MHnCnXwXIiU4rLnfrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819088; c=relaxed/simple;
	bh=VlJqZ9NQ4KqO8dvZpFxedn7Ut0FbIk51E3izV8xKWUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=miqp4T6pXroV+Yh1a6Fv7A33sVENVbnLSF1+C0YAdFGFBrYv1wcve9PAU1baRdVqadHUxBe8KZxjfIVKDtbsZaKlb7LyDQsq9tVEMmXYprKn6hKUOm9NIeuU0o2ILNu8IEW66If8E0tAR+SCSw4jpvPSqa9VIiFomv3Y7TXAgac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWq2gtUf; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWq2gtUf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773819087; x=1805355087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VlJqZ9NQ4KqO8dvZpFxedn7Ut0FbIk51E3izV8xKWUA=;
  b=jWq2gtUfVLnWzbsdVsHOgPvFQsGQbZCyZs40FXCZpjwE8MsTubl9YNRL
   +CfGkpPMp2gVE1sXrwklM7qwlPMOctFhH+45IPr+v88L6eNw4Tsyh5H5/
   H5lSinEcl4lC9vX4bTFL8dvprpM2KJrocyo3mXPNI8REm9jVD50H/zmei
   GCU/atyZ+RMXOqF0H3K966bAqatw1FepkNjg4tF11V6l0LUYCXyxyTbKH
   Lm88WT5AVSUrJ9P42w5QFNrjJ0brdI795qHtAj/DRO118qvZ8x/8UQhYo
   oXPqV8FNcgTUJG92bs99+DjhN74o0Vv2wrmPOHVmuc1pHBkcwoooYqOUS
   Q==;
X-CSE-ConnectionGUID: izzZZYXoQtisuPG/8tmfug==
X-CSE-MsgGUID: X8baF9zhR0+dizXBG4pP7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85499174"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85499174"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:31:26 -0700
X-CSE-ConnectionGUID: KwewXAkKSl2QYdsI5KjgTw==
X-CSE-MsgGUID: NFPB/aBkTuu9SSe9jjkI0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="245558617"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:31:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:31:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 00:31:24 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:31:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPRoNy733A6a7MABvDXz8YSQpoATAmywqGvwlg6i9ODrVoJeWRGlg5oTJXHzsWPzpLIhYM9K1rWsk0U+uqs67hIvjBU5p1C517CWw2BaDW1y1VB1bOiePzlc5vCA76ulrnvAdAkm1ty4bNvp5ODjlZvjYsdai4u5DOln4OmlrBqtn6iNaG2fIN/CHi7FMHY3OzdFo0VXLqThnM+oh5/bRyvLw69qqv3yJW6fDM6goqBia5u6mP6pN6GlXkpDFSEC8ycZwqIm6KQn+sMz2LjARp+JCXwlZOZjjGzX1OAehKAZl11dHIfmbgMdgorAlIsevET+czUVX2F6wQ5KH4Rjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVZVzB33K5yiC0BcGN62phiWo70MzN1c1bTOaVSK/ag=;
 b=Flm5kHvEs1g9dgJfFf7ULhUAmPiEIFMBVzU00HUDf6Fz9dXyRIEhtOPvoCoNXbqclvcEM1F4UgbDuS585ZQZGJe8FjWbOdeh+yvCCyhxCNl3Oruuqs5Hd66Bg+3neNJIPcgKXe0wMmpyQxvwNA646h/cmQ2EvdlHhDBMWNQuw5WQIqTYGXPHpjqhgr2uif67rGwOXbyPblLQB1qHwFWHKx2o56sQNAeMf+/MKFxidIuaUU0NRxJj3meGn8pkAIhW0fIKtYXyVD38XQ+Gy+eZPP++3obPkJObYd3RQBOy7UJsOje92aA5hrSBqjX6xFscmJ+gnEmkTp4zL25EkxnVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7693.namprd11.prod.outlook.com (2603:10b6:208:401::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:31:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 07:31:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: RE: [PATCH v2 3/7] iommu: Add iommu_report_device_broken() to
 quarantine a broken device
Thread-Topic: [PATCH v2 3/7] iommu: Add iommu_report_device_broken() to
 quarantine a broken device
Thread-Index: AQHctkKaDHpYkQwrNkuYzmIjd4pgL7Wz49ag
Date: Wed, 18 Mar 2026 07:31:18 +0000
Message-ID: <BN9PR11MB52765AB4CF7B9966D545CD1F8C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <c5390aeaeccfa86a1c79f26d2c0ff5df380940a4.1773774441.git.nicolinc@nvidia.com>
In-Reply-To: <c5390aeaeccfa86a1c79f26d2c0ff5df380940a4.1773774441.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7693:EE_
x-ms-office365-filtering-correlation-id: ad95abd6-1551-4903-0c41-08de84c058ee
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 6YeM6GpEfUP1RMUAv5Sn2CetZWqeAk902YDAm9koWoSC2yV5l/iwrtYQpUzZh9+ipfBeejEfKfx6hFBZZT3gqC6nZ7JxKKL5dGBsA5PtuVZwDNB6oVjQFpc0aLBocDv1P9bcnWNq2BoD8zuXtAJsNJ5E3KspOXzHHDFqN9Kl3Wmns6altdwPdxtMquXL1nNqOkhaJoW8GGL/sMl7bSc3DFHCFAwb6UtJJPTv6iGP6T86jsF+0AV313/35HF1AwhEmPzYXFXMkPAX6I9x1YvC/Joz6C2T27OmOYpvKi31TeewqLkXusgH5MEL+pR3U/GnzwFc/dR0dvaBkOX/Mt8REhOGedn14Ypl4zAKmFM+gT3VKHsUqdAI6wI2K+KoVkTC7uFXbiikfDb56l1H4CEnbLT4XMowJgF0Ih1DeBWin4UMDhdoI02LgUsu/o/7zWE9swAJIJFyci+y1Tp4w/e2P0OIx1zNWZBtKsY4ycVZf0rz+xCCruXaApQSxmTP8PWw+hzJ737CEuWOlG73enDgdwfeWQid8KOEvACYXO9RDiPY60olKnHcbHgGdXK4LzJXsoObvDlP75Sjo4j8rlk0Miriwoy/4y9yGu6xSlVB00bVnefmA9/KxLbcs7DGDvrIQ+UCodEmwDb7Opep1jcW3vaCqD6HUZDXgJQM9QwIXKFgsZRN5s7B1MGX2HvvrqFb9kepkIs0cKOAgn5fU2NoWyEZwej+qSYCQa9r7UEASGNMHUz+1sVmCTh/eN76RkvIhtn4A5yZni45QbfEdY2ePKiW6C/yOsmr6zqk5SioVFk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nqTZhZDfxLNf3b67n20u/tsPFehExFvn7+6fJC5b7TN8UjslTCAv7ys49wCz?=
 =?us-ascii?Q?LkWgvRsoqweOrYNCe5fC1OtYdGQiVnsx+gZ6mGQOvl5GpINgADUbPvFMGnt2?=
 =?us-ascii?Q?qozWgN6V7nhQrZPg0QDuVkDsSjeLOtMIbE+7kxBSu7VE0mzpqJQ3gupzMirm?=
 =?us-ascii?Q?3U2TEu6lgun4xE8Nxmca8D9Z1fmjsRftKNsy1mEl7TbN/NUg8spaWv1YUZNb?=
 =?us-ascii?Q?Xh6h5oz/wL2Ae4Ho9SBDJ8A6iwIG1oTvhW97psJ+YhC5k+1oA+wYrBcWWemj?=
 =?us-ascii?Q?EBeiZOyxjCKrmyerOOA2Ng0Dt5hHJsvbZPu6fNIX8Y5bGqz37RAvJXN/3oxM?=
 =?us-ascii?Q?CJ/DyDYj6i+bmKIguQ6oiMl8wvVYovil4v2v+jd8mMqJf1NNURr//U7/mSFV?=
 =?us-ascii?Q?+gJ29ZLleaOtFvBK1jfkeAf9g+tIq4eAf4YU1t+aOJXjSTlYf3ZysxyP7SpW?=
 =?us-ascii?Q?/SXrAntFl9r/q815pElEtq/0FVgavhRydj5Mv9cZGBT0s9Avk92hi84l9wTE?=
 =?us-ascii?Q?lQGEJPFDIZs/q3dFJe7N8BTWWIvHRgabUNpp+BzK2bYJGcnZDbZe67W41Vue?=
 =?us-ascii?Q?ifqJ0ddxLRJD1h/JgHg7Un/NUL4MnGlYlZ9OYSQKC/lRb3uMXb5poD1Q81De?=
 =?us-ascii?Q?K5RRP38puAGZce15KhuFUwas2H/s4GR0Yi7r5Q7KXwoVKZKllUze01IXn8z8?=
 =?us-ascii?Q?N1AESECM10QKSX6249EKG/HmuZG2SxLffGhhQ3tTCUGOM2lrohWOnGm9HbUe?=
 =?us-ascii?Q?kpdLjleB7cTtI5sa0znK+RU3puBmbZhJsiOy9naY6QUt/sN1ObrdRFPvfdMo?=
 =?us-ascii?Q?3wrPyDgWrCMMHG8iBFYBBXv99fEFSvb/S4ltY8fiJoMnuk7w76iVW8Ay+P4u?=
 =?us-ascii?Q?IFyayDwzc3/kGHSvMW88l7iJLfXoev1kA+RuFrASNOAVQMBrSoiuyCaMHrDc?=
 =?us-ascii?Q?pcEP+zoIBWUMB/ZXnq4mKUKLcDs9cScqUGNK86hSwnySFohyZnz56ixYemx9?=
 =?us-ascii?Q?xXV9DX2f0P9+nzs+5dkKvFqWUN9Bvg+2fpTHiyiiudUxTWeXC3x6Z/wHxYL/?=
 =?us-ascii?Q?KLxaOJ2s8uB8RY7EI1HN2VBBmJbm65or6jF3Rzh1vXAoDDcTRqnihKbBsE3/?=
 =?us-ascii?Q?8cseDZYw+4iK2XmSAXOYwm7DxA+aKaXnPZcBotdEV1lgbkcb0/TPy/Ng59b5?=
 =?us-ascii?Q?h3dkGDPryt5LPpThtQMfByo9DHlvmepwHOcyB8c3Z7XM6hEzyVO2VDWOirFO?=
 =?us-ascii?Q?494vKmFIQnqnEhbq5A67k88iN4BWt+1rfkJ8q5Ve+Fcq8J2lKANIdCZZ645P?=
 =?us-ascii?Q?gCUmhHalDUuNdkVzhnxMqTwXOq84myBRk/ugn6ouKTTpDMPrRHOeL4CAorp3?=
 =?us-ascii?Q?mU0SiJA9g+Xqewhtf0sscwLZOoN28WvYfuDcPfCh8MGOPXSsrWLMuHfJqy8F?=
 =?us-ascii?Q?me9vseDlYIkfrDqnZkkyBqdZmXV66OKcskUmO6nJgNv2hZGQXQt8Qg8i1J2+?=
 =?us-ascii?Q?cEOy7spnyYNO1EFcmiBrXhqkdWFfxTZ8T5X5nCBdzcFe0tctQ0B/6xv4I6kd?=
 =?us-ascii?Q?pSvU8wNYv2w2wFnqm1ipfz84iiqcijXzONqsnsA1F4R56pxpqZCHs+AuHDCM?=
 =?us-ascii?Q?WsXEEyUuaYFR24o+z2A2gq//3wGETs/y8mfN58l3WHZejiwZY6cIHK/OX1EA?=
 =?us-ascii?Q?K3FurZhfbKXeVHsw22QEihH6O4lfFlFysEqWMX+w85qTRO4RSLFnUzEGwuve?=
 =?us-ascii?Q?sqNemstHOg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: quiJrbkOTb3p/Qrcc9In3i9XH2zLz9Y+dXjLbo3DOmLxGFjtFNlzRy98J3EvIzNfZv0DSRQSFXOGMolIkLVBvPQ/e66UXEpENt4s7mTDlaAHryjnBBHXdHwVwizV2KUkggce1K7/zo9j5OT9f/fob59yaSvR4o/abq9W1oeQm5LtVjEG7MvTf6F2JNDBHX2I8vTVzPhIKXVfbGTYcbQZ4ToEO549JFJGHidkcs+/DBO9a0e3qWR5AFn3TwwndkpyQJbztv1gDB9Ss2MlyBZz1P/Hy+nYHUHBdeCdQPGMSN+WFIO7mXAp6y1G9iW3FOIzyUWnuxe47zRAEHolCBLJ4Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad95abd6-1551-4903-0c41-08de84c058ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 07:31:19.0154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Echf7gTR23w0mqZP66U/dtYrcBHyMrKt6Pv1SxJJwhyhHw3it8xInZyRKAOyFmhedq23DcCjH+FakaNjtWyULQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7693
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, March 18, 2026 3:16 AM
>=20
> +static void iommu_group_broken_worker(struct work_struct *work)
> +{
> +	struct iommu_group *group =3D
> +		container_of(work, struct iommu_group, broken_work);
> +	struct pci_dev *pdev =3D NULL;
> +	struct device *dev;
> +
> +	scoped_guard(mutex, &group->mutex) {
> +		/* Do not block the device again if it has been recovered */
> +		if (!READ_ONCE(group->requires_reset))
> +			goto out_put;
> +		if (list_is_singular(&group->devices)) {
> +			/* Note: only support group with a single device */

this series is about fixing a vulnerability. Then it sounds incomplete to
leave certain configuration still under risk. Probably we should first=20
ensure ATS can be enabled only in singleton group, just like how we
did for pci_enable_pasid()?

> +			dev =3D iommu_group_first_dev(group);
> +			if (dev_is_pci(dev)) {
> +				pdev =3D to_pci_dev(dev);
> +				pci_dev_get(pdev);
> +			}
> +		}
> +	}
> +
> +	if (pdev) {
> +		/*
> +		 * Quarantine the device completely. This will be cleared
> upon
> +		 * a pci_dev_reset_iommu_done() call indicating the recovery.
> +		 */
> +		pci_dev_lock(pdev);
> +		pci_dev_reset_iommu_prepare(pdev);

let's rename it to iommu_quarantine_device() to be called here. then
have another wrapper pci_dev_reset_iommu_prepare() to call it too.

this path has nothing to do with reset.

> +		pci_dev_unlock(pdev);
> +		pci_dev_put(pdev);
> +	}
> +out_put:
> +	iommu_group_put(group);
> +}
> +
