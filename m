Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68332BF42;
	Thu,  9 Apr 2026 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719317; cv=fail; b=jtCVBYt+1o12xoKH9Mgs2B42Rs91E+EwMI03TeHwapv+PdmJdrWPw+BVhtNrEIyh2SNyy82KSgpiuKfq4jD2+hWVky85GsNrDvYQEPbJE2qMqGcUEkBLDmwRW2KQmXp+rP4as9swFM3JulkfCAphimPLugqbOKehoPh6oLrGxgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719317; c=relaxed/simple;
	bh=Q6ZkHqo4YPdnhy4Ks389cR3Pht5dSjmcuKxfjadVmoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GsmaYERsYZV8nb5RANqwrDnOyrWaYIAXzwBVgndQPUAEPSb5LehCAtXdKtzTkEhqvjmpxdpZk7EC3dBGrWSZ3EQkNa5970CNzKH7cZOvtzTofhRDXEbqikfSF4PsE9sLp+RkdeXlOUkt1c24SuwunZBy24YOsIXb+th9iJAOvxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPsUwTIk; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPsUwTIk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775719316; x=1807255316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q6ZkHqo4YPdnhy4Ks389cR3Pht5dSjmcuKxfjadVmoc=;
  b=KPsUwTIkn0ZNMEGFWNaX0K6mKNMJzLCA8WFVNDqsLIMQ80MBDsVRmGCh
   BcG6SSc6miBRu9xxXhCGdJ/HUzCyQ+szjoQ2fXOcpVTnVaIh51DIZ8q/V
   TFulczLe/LsC9kv2JEJzXPj1wq2AJDTFoDbgzU44dS/x3QKQBQ2rX5p4Z
   XNa3Ph/3LY8GejYdm6Lhzr9JJ1CPEwxC7Is95jXWMtclGzjWea0W77g88
   FLq1f/9Zm8SMz4SAptqOBuy9xReTnok4AjOD9qJPIfKFZHFZB0ZniXzFR
   NSj4jpy6qb2Dv07V3Mmy/L7B00sJ8TyL5f47fDXwQi5kalv9ft8z50ITy
   A==;
X-CSE-ConnectionGUID: AcwlQcsjRAOB3zhJt20URA==
X-CSE-MsgGUID: qo05r1PTSMaMpwYWeJCz9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76595177"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76595177"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:21:56 -0700
X-CSE-ConnectionGUID: JFLU8ft7Rv6keRqXYa7r/w==
X-CSE-MsgGUID: 23NDCps2SwK7FVhPGWU4ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="227835728"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:21:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:21:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 00:21:51 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:21:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYV/2EfSwZbynJeVPoG/uXdVH/XtX33S/vcENdEVWSlF/6Y0sWR8mKp5UDuFh1LUFCMTq4E5aWUuo7766CYAg8qlw6A7ECXZImn5XXJvfj4dIwM+s0plrGLSTEqqrHVolyEQtaA1hGt0K8a1H5iu+4gOJ8YIvKG5Ejzckp4hYu9SO/SUOboQQv1aSp7XGhXd4y4l46O9A9uWbgzbHL8ADY6Eb1l+8KwKhJzTlJKoje8JuCvwEVbVhH80k28AlknP+W2Hf+L1idViOSQTRWkROmxYrtY/lKGs8woMq4Yr3tP0suewocCWSF2guN/gfbzfofKwNKUC42kceysdh+RISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbhwbnLqt6NtlAYGv5F3iGLaqxVsSPCE+YmpBPJhf2I=;
 b=DyWiq1e8qnv1buai9XuEHkdAYSphfb/ODpETxMpG2QoKffmhv8WdjhoBoJ9xM9vJYvBfUju9NrLaHP20B6Yb+EwzCIQ98PqqwUnTwDvpSv7A75pJyWI4b/vDFqj4hE6dT+Sb3rwGH0ZMNfiLt6QZy6Jf9ZTvhMvxaB2S1fBZiqLNWnj9GMPAONtgyyExBF78FkQJqxB6iNyxE7lKyTYIck8I6Hw8aFzhWHBar8mUCAHv0gemHZgJC0qG3IRCfMMOPTfIpGx3H5WTVAU5lm0b/uAutUVs29uu8Sxvbrxy7QMH5mPq94D6cMZ/1RF905yqSOnU+HcOVPku2ZJVhejjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ5PPF6E07EBAE7.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::832) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 9 Apr
 2026 07:21:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 07:21:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 20/31] x86/virt/tdx: Add a helper to loop on
 TDX_INTERRUPTED_RESUMABLE
Thread-Topic: [PATCH v2 20/31] x86/virt/tdx: Add a helper to loop on
 TDX_INTERRUPTED_RESUMABLE
Thread-Index: AQHcvggzhGF6VQdglECApq8R1gSDzbXWZkBQ
Date: Thu, 9 Apr 2026 07:21:48 +0000
Message-ID: <BN9PR11MB52767E6C22CDF7DAD9D5FF1E8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-21-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-21-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ5PPF6E07EBAE7:EE_
x-ms-office365-filtering-correlation-id: e47b88cc-80b9-4ea2-6bfd-08de9608aa08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: gpRYo8yQwQSuLzYHCRztRmJRNJogYuPDz3cfHvayznLcl1+0Fk3fz3x+8hbZGR3kTsHy3vsUb6XoLjipdtN021FV38/JcG50z9uFK2CCKozKDFc3bAbEgEYXpggVavpWlA2EWU6CnaKnYKqoih7Vr2YsJ46T6wUU88v78rAdq08KXreHnC9FSfoMhWZeNk12CIye+qyzb7rNuBDQLIubyBq6Nk6BtYanbKAgHHQeAcOktEPhSW9/iXQvGD53FtTgWf4F2sWVRKmO1OkbZ6rXFwobIMNkdKBaKcfEHqrpWRmaeFKJXby3u7NK4tRPwnjYe1Tn7OOpMLYALBPnd9wwHy1rJ7ronFS9IkQ1q5MBgwza5a3bWtt+HfmwsgFmNDdrJISkpzbTzecY18N8IJSdJ0OHjkE1kFLK7Ma6L6mMfs3T33m/DAzP/C41zfsrL1ykCI4btVCXOUdDOMKxlAZjiusi6XLiY+U93E7f6KIQf/DOfJHDN3Jo/ct0aXYUvDBnWshKEwVxboG3jLzgyoLSkkjyR5dOK1EtpA0r5pyu2q8Nc6Kqp/SMA9myEnxPz6RamiLXkaY4gHI1o7D6KJyWi7mKp8K4tnp80pwG/I4SlzTxBIJZ3dvTJJxo+XZFI7sovQdULq1GlbilwJyh9EpNMTyISIwvL9JJCMhFiuIDasOoCOr9EaJBikIytgm/Q7oviTkMp9h9nYoobh15fUr6hoIwJ5zs2ykmIDCmA1eZ580kGewyHe7NUzilpzSdEGRJCLR9dafmlh28eg3Mrtv+7I3S+9y6IU3UYzI9MBUf9p4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EugczG74iA4/eUPxEfTygWiXZUJgnjYeZW20buBQRac23u+99VKpBRb5elus?=
 =?us-ascii?Q?zFx0xyWmCaiB5YfEKLZf5zYM6I3mgULmSMU9HXkNnxBb3Dkyfsl8UiiX45Lo?=
 =?us-ascii?Q?EWqdJ2PmaNvHys64NYecWaGRfNmg03kPgKzxikZVpzQSn8d8xZbTKq6sJlXU?=
 =?us-ascii?Q?6LP1yfIehhyOkdm1m1Yi6rZw6AlQfHzJoigPGigBB3sy1dnMNVHfTvddl8zF?=
 =?us-ascii?Q?4ByEn9+vX4jbEhKibJwriudbqvlIEuukHM3K7eEUisGGjDtvYyWQRxc6c5w7?=
 =?us-ascii?Q?T3dykF3LCt9RDUMWiMLB2iouOkZSQXm5BhJeLXIF3tZLs2p6Kw07JhjTv/4C?=
 =?us-ascii?Q?JCW/MkPbMsX1HwVF6Hgwg+vtf3G0iOuBk+3hlvGWFXE6fJg4kgyppeXQz2Dw?=
 =?us-ascii?Q?T9Fx0bSXGhnvkGRM03bBQEE+b1gT5TipyyVSpz01LSU266ow3h51c9kOh3zH?=
 =?us-ascii?Q?GiHOlYtTXH3rq90tjeZ1fmnJ9IL7DG4dISIvcY3yYXTDBEjkd1QZjg6T57BF?=
 =?us-ascii?Q?ugTyqQikBLarkv6kwozq4AG3gKyHCgaf1YBlpZg/kgWMVcFB6Ez8aUa+gCxY?=
 =?us-ascii?Q?o4dWXXSbo1oMkbvneiNlNIsOVK9439gWOAaAwa4Tk2gPFV8eA5/0qUG/jvVA?=
 =?us-ascii?Q?IVcfrXQ/a/XM6rWn3gOZzdDQRjKnSzYNL2AewxfFSR72+d3zs6iWfN4//y0F?=
 =?us-ascii?Q?HZMJxJfGYS8i3DhuJCiS1OIezTf8EjpN1paMXJmQVzEBtpYcP01FfwHyaPAg?=
 =?us-ascii?Q?qruRo6uwHdaZoyjXqkEw2KnkLNAV406yYQfj94stqk4Yf0EPS7AiwwqRLFRB?=
 =?us-ascii?Q?PkR7iQazwGjX13cfWqX78GRthoiBPkeXF7voI36nvMy8P/LM2PGt8mvGSSK6?=
 =?us-ascii?Q?wKm2G1fY01ZzWgblXy9ZestpoWGf9mmFY6TNHoEJfoevvvf5BV7yFfAf3FUE?=
 =?us-ascii?Q?dMASxBFel/FFzfmlAXWfMSyxm7OSThAJiK9rYOsril14m9DtE7yP71HZ08mj?=
 =?us-ascii?Q?LDtKd3Crh1w36POLhhj6ztKRAa4kT9zBuWBMRehbRL0owuxS52xROM4j8jCl?=
 =?us-ascii?Q?6QNWQMAN2qiJddANfGFITFfQHPLQ0oF0SGIX37hPPrJyR/pKPospMoSE620x?=
 =?us-ascii?Q?upmEIuqpqmpw517oIXl2rmxDnRAei14h+ExBVpcx4NK4hsNYv5lYz07aVpSg?=
 =?us-ascii?Q?eTs1IOsAAS4hago6iUeQlHTDYE2qZfFHCPJ44wSnVfsZ4E893G8k93vHm0Gy?=
 =?us-ascii?Q?SkXed+uy/FZmhYf8gbKe4zK7n/yGSWFw4kh+U8kPB69S/b7dgP/tpSJJm9Dk?=
 =?us-ascii?Q?QTwsyqwzy6bKSo4dC1qBb34yH8gBEoFe6NPunz0Qi3nxCSI5X/3Dqjx6BErl?=
 =?us-ascii?Q?81kWzsPx71T1a96C79l2oRXK2VFb3shjktxXyeDNWQyD6e9zJ1JHRVv5Be76?=
 =?us-ascii?Q?/lH0gtW+HXwSD7XAaKTEuoUE8PGJqld+s12ob4Nfnlz/olF3750VuR43MIaY?=
 =?us-ascii?Q?aTSLdXNMG2QhAtgFUy3hz8vEZMAmUctrn7J8FmRlhU2yBNaZct3FY3vbyIR6?=
 =?us-ascii?Q?MWUPaF8tRMj2lC8cIMGwTKLE8vYF7iYfRzAT5DBHTke0ugXEQcIaZIQ1Mzg3?=
 =?us-ascii?Q?swYrWPZ1J85qY8g5NwrHe/h706foSM/tELMfwo4q1eUztiWCQ/Y7mE8lRfIR?=
 =?us-ascii?Q?9gcakYMSni/G7c8xhMsAdcTuj7ZMYguprs7iJkhn0BQN/K5U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BXFh+tkkkTS45S9jH5lzU1xOxsWYn3+lW8gPaNUMNSNuauSYr+j9gg05jlfXXoymRgry4PUruWB0BLGt0oitZyTkRyaAwb7ritUWkqoyU9LX4DznQaQeP4PTP0TRc8FbRIXQl2FBySlKszcbIyvtCKRI1N+2I5Fjg8WCEAhxFmLSVIOrkw3hXNIA9C1z3gQfAjplH/MtMJ+oJF/m5xeqHUMQy2TwRYhmVetzogI6jttmUfQ6cGV+gE5GG8c5r4DqbUTYKuDTQVjhsx/uU9/mBrSWx7SVkKjpe+RpNHIaXTTUXI+bpXHDDIfGbvFauAgvAwd/pmIiOlUi0CJLzbFUUQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47b88cc-80b9-4ea2-6bfd-08de9608aa08
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 07:21:48.8623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BNT5mOvQv1cSqzRphpyCWgCoSPFvSo51mtiAKF0SJLNU02znINhD/IZYfZYhdsuvod//bSuxIFICdrQ+Nr2Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6E07EBAE7
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Saturday, March 28, 2026 12:01 AM
>=20
> +static u64 __maybe_unused __seamcall_ir_resched(sc_func_t sc_func, u64
> fn,
> +						struct tdx_module_args *args)
> +{

'ir' sounds redundant with the trailing 'resched'?

not big deal, just a bit confusing when seeing it in IOMMU side where
'ir' also refers to 'interrupt remapping' and is frequently used in=20
irq_remapping.c... :)
