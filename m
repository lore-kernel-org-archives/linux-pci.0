Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F222A80D;
	Thu, 19 Mar 2026 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773887740; cv=fail; b=jFmKoSGQ3MIl7U9TXlEK/E2ohargBDKfJqAfUZRi4XOCbbL5u+ntkKZvtscPH0EZ6oC1IN1geiel0nQ+EbcYQ9ACGMMejIRSbx0igOd/u1HPxJGxC59lDmWahNIaixGbA+Uam7K7tH9lMrm1fgcxL4bPnlZfddyTyUSmE60J8Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773887740; c=relaxed/simple;
	bh=L2tRfgYXjv9HV0rosZskDbYYZiobIi0Jho+gsAKe238=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NUJmOO4FiNFFAtmhYUHd57Tt8UuB4gk86vfTC7G36RJ5NvzYII09W23umxKCFZ6BgiBoC0iJoFqNuVSGKChkdXeWPxMnf3D+LermnpCDZbOUpiXNc6ST4E8vTBsE1OHG9FVthX7PWVHjn16ppQgUsA9stJiV0BlruhxDOW89St8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eld9mlSJ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eld9mlSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773887739; x=1805423739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L2tRfgYXjv9HV0rosZskDbYYZiobIi0Jho+gsAKe238=;
  b=Eld9mlSJxJvixjGi7+Zx8Ic7w7ksmoeofCxFcwIXrauBO4YNpQyxHUin
   +3p4a9U0QPyt40D3yj27TfRryNkrKgh6fgcrCR+0eqRyCZYkGDIVlXXtR
   HVfpwDZ1HjVvhuijdIxzgXSd7NMWY66qWfG+rrrOaI6PmpzXcTFvw+vS8
   VrPws4KP3lEnXKtFTouYBPZc3hh9+vsTmPFZ2g8tNuptjDw8uEnWqwJ4y
   pJULLwDAtifaohcT2FeQ1hbigFPMe4hB+lIWR4PNoAQxKVwJPNmcQ83cz
   gvn8G667kGYKaYd/80psxXZLhIqbN+5o3pODGisqvRT0Rt+9bXz+paT6r
   A==;
X-CSE-ConnectionGUID: LIU/rAZeQN6sivC5CubiZA==
X-CSE-MsgGUID: D3fOwnyYTV6J6YbdPqjk7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="92528215"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="92528215"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 19:35:38 -0700
X-CSE-ConnectionGUID: 7OS4SACMSIWfhOue1iFBqQ==
X-CSE-MsgGUID: Fyz5gVPSSlWq9+CmUJHmZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="221931186"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 19:35:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 19:35:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 19:35:36 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 19:35:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jk8P+RPRapIlnpXyjvVWznKIXozlz8qH0AvXYSiKAWZhjG673ZSSIff68peu/O4UPmNqJDbcxgJ4Qtv9a8QIUOxufQXs5NfIgW4i6X3vZXup2HQC17CrRlEYQkB4L8XOu4bB8MeaYHeTEA4vW9mq96jPUj+vH4CDDgc7gmEXMQSvTeDAXfTch73/K4Z01/1ouvBE1EsJjd3LxLKC1IlmIuuyGyA370s7tuQOP3rxfsRrX0tnNiSCyvaHaHdxuAIxBF7NuAR2ebk8oA2Z6Tuk7pvB3yRpT1tx3otfStzJ7RDV6M9XosDomhx92nOyRzkJpWCetvvj4RZgTeJYpwxMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPovKVC4jhNnWu3YeSHVBqR2+F9C6yol1dlCBCi/Ad4=;
 b=KFyyDDi8+R5YkN32XlP3+3M+LQeOBsvinxXiRR1tGk1tadKqbOO+li+Eo3thQ8A78ppeXsrFdXoqGTxFVj+TafpyY8DA1pYpIBefXFCOB+ildmVA/jX08rHjtaAVUeAGSeuxpe/CXN7w+cjdXGE6tZ5WHTrNZdNzjc/RkJVjWV6XSMzyI9K8DmHJNyzdoWQ+p7NZl462XZLCuRZZbh+/Zkdw/AMvgM43hT5Zcnw1ZFkqE3pZNxN8rDwjqBsbKvY5OOZ7IUgr54McmtndXzHd6lmSMgJNomBXIBHvO9Yhr6xLKNSIt6T7UDtdl2ru4KET8u6onkUdwYXEk0r7TM1lcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7273.namprd11.prod.outlook.com (2603:10b6:610:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 02:35:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 02:35:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
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
Thread-Index: AQHctkKaDHpYkQwrNkuYzmIjd4pgL7Wz49aggAEvoACAABEKcA==
Date: Thu, 19 Mar 2026 02:35:33 +0000
Message-ID: <BN9PR11MB5276BA7E5C9D2F84C81383358C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <c5390aeaeccfa86a1c79f26d2c0ff5df380940a4.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB52765AB4CF7B9966D545CD1F8C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abtRvoEessOlRzn/@Asurada-Nvidia>
In-Reply-To: <abtRvoEessOlRzn/@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7273:EE_
x-ms-office365-filtering-correlation-id: a187aa4c-6cc1-437f-da1d-08de856031c8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: SR193Vuz0fX5ADAk4LuE/bDtPfDXGkI724bd8OD3kauWeiHQwUtnFGqRYP30V1J0QFOPUXejsuLjY8yo9hfcJMRhG7ChHE3ichmm+xYY/uMym053tG9Lt7WM6cGW7w1AG7cq0+HeTpR61MJfh0FT0D/em/xXs1BZOgZr/Qyv30wzm44gs61wh103mlaL7xW8hXEmt+GOicmgyt/Hz/i6LKdU2BB1pNJrjZXTGJHpTH+PtZPtefuU/aQ6p3MhKFJ/WNOzdBARg8JrSS1jNa6a4u0RPHWT80WB8MdrS2V+WD0zwDi9E+73mUfvh+RNB7rwRHqGdQ4k0qWBimzG3C+mcvuLZbgRwC0W972lEdDZVFgChpQlQSj4AdTCXgwx1GSaPMIdg57rqr/8eD+bXZDcRNDDGezBNHBLImo/7+1fT1C3L3gHsaTNiAlua1BzYRmbGC2+kBR9njCAoPzTwv4mpwag2PgmAvotfAiIkuQO7Aaptk5ejw39KIEu0Hj06/0hDs3r/xyny1JGHXNNtlH19yfs5CfELYwYS6XaJ8roAwh/DJlWFx1XhijN9NJLvofBFoTI6dGR5PnlU8uiMw55E4vPeh6sgW9/efQaMQo0SLARd6LZ7dL5gTRu5e3CedoYaddvb4xe/fPPD9nD12SU62oHEp4btA0lXxT2vDiA3fOFlI+mRlAz03xPyIccfBk7NS/sgwEZfgW4Rtp1ZSw3aL7KEWV/Q1mICugj6nNTTlaaQ30U2amqsZBbdcq/knt0OszUcpq9yjIG6vteb/SqyOtnMSIyMsixM7bz9pf2f38=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oGdXiExJDFRG+x4/Qg1QzvoGPvrZrBAx3XrqhGf98KgQfGXgplhHJSbFFTR8?=
 =?us-ascii?Q?8HgPeQFUImUHGsex4OeMfvtiuszrhAwIMcQGmQVYWnOLVvkO44/y/+499Pff?=
 =?us-ascii?Q?R49zJgDFYJoUv5LMOVtbCNVr/8JchiJNaiaLUFPHKLif9Usmr/S+cL/TiBuh?=
 =?us-ascii?Q?JgL4YkCL2D2e70ZL9E+uKWsqZySCn+UxkgJIebx54z1CUFt3TFMrvTwyqjv6?=
 =?us-ascii?Q?Ibb1BXEPRdtEaGTsQbJ275/uGowC5/0o3adFCwjrJNU4nGRvBnF+AHR9extk?=
 =?us-ascii?Q?JhLMvHYwnRZ1edA/Z0gRyidp7bieQYzJwIdz0mo/lVbZRHK4FCmh8rRv8wh3?=
 =?us-ascii?Q?dAtp6aM1z3/uBYj5lF2aIrKZPy0WvA0X/GGBIR4j4H4zEm/SEV3whSR1Hl+e?=
 =?us-ascii?Q?fURyS27AjDldZWMReuYoBKyH8IYywICEbdCzqoBfbB9/l+7Djmv8OWOx36ct?=
 =?us-ascii?Q?iz9ZRpFvn2sguDaolTlsOSW9zutWedhQUyFlPAk7bIkpzz2lIrwpDnuGEHRL?=
 =?us-ascii?Q?8fkzXntzFV1xZSoTj4SQnABf1F1zYwj80kJkbGDC9/osnIAP0liMYuhjAn3p?=
 =?us-ascii?Q?CFOPZ1weyjKNqzVYBPJV/p0mAGazZCCtL1ChMZfI4+c/GUt6FIRylzvejI7u?=
 =?us-ascii?Q?ruEIOZG4EP3Q05ZS7FvhYV1Bg9Kbrh0z4aUMI81QKT9UYnnijAR1AksFGiXm?=
 =?us-ascii?Q?bJN3bJOEWe0LEQ5nNtmZ5I3BIh3TjaOiVIsS4fFWQNdmzAeazmnLFeaZfxvu?=
 =?us-ascii?Q?o07/iXitfU9LY/gBVbPOpgLfqpcvLPwJnO6wXkzwZQfGANaLd7M16jbleA+4?=
 =?us-ascii?Q?yStaW0I1iowA0YFisXO4plMiWpgpsbfKRjns1Ea4RrGXdsMoHZMayPOnFzoB?=
 =?us-ascii?Q?ZegqdQkbKDTO5gfXNnqF7XsPZbWWPhOGI1FIKouE/O22varj5ne29cHGkVZz?=
 =?us-ascii?Q?0RYVXq77KFKcJR/lTBZ3jasXL8ZDkuYi3ZEEKbzRB1CK31RKjyFnZjtfWMVs?=
 =?us-ascii?Q?kuvgIJNI+tzf1c0oRRiV3+9pLC+galS15hyzUseUkydP9AGZLEWL8xdUo28i?=
 =?us-ascii?Q?QWAnu/ww4LzUmQDRppV6MV/KCMKUO7MUNhcMPwxpxU2wbrRUNBEmy2X6+5d/?=
 =?us-ascii?Q?Yrj4YPVW4jzcOM42LhqS9fT+VK7sk9w8Qy1zChX5Wz1My4/fJ9GXebUFFyVY?=
 =?us-ascii?Q?Vmu/6eXpBQ+1rgFpjC4qKubRJweRX4hl5bj01tzt2zrP8MTCQL9uRohVaLCW?=
 =?us-ascii?Q?vb5JbjvadchkLh2NX8ad+CixhoKrSAMADJQpi8FNK1KAU8xCjT9uAEUxuPsc?=
 =?us-ascii?Q?iiYUGHi/i97QZ9Gj5Ca6YcbBqmwI3U/aoAV26UyzqxzzWjQ6GNhrIhB+vvL7?=
 =?us-ascii?Q?7pt6Uhqza/xaV2883h1qFIWo4No4PAyxacsQCZClJZxs8TUiPh9VapiX48u/?=
 =?us-ascii?Q?NCPa63DJh6JoUufFOLdkMIasrWfWUW46gwOAjyoOZVZ48Jp3Pbmaduy1CPsY?=
 =?us-ascii?Q?fUFF7b+a/6tO4DVH3rb5Gukgj1lH4lzSsgDYSWn6r1pFM9E9u8XtA1w2fn8K?=
 =?us-ascii?Q?KscnJcIHndODGLw+QtmFdLkwALavzChUMpRBxtBipXqg4LIeyaxtCcf8bfwK?=
 =?us-ascii?Q?IVS5O9V7Txx8/tvXjnRO5/zGKaXvR4PZ10uc/jT1XaoW12ZKelNsCe4dJjoK?=
 =?us-ascii?Q?uh4R7UhgcEtN25RLrAFxS+m1rHZmK67M/SliwutvGBMf3rd3hH0dAjy3+3jY?=
 =?us-ascii?Q?HSRIpKq/Dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: intMQN05C/ugrIqQLlBLlnShn6Sv1yTdWgPCMlLsrdmw28l1ELbdfmfAsfGAKeU7i9EYjM3sh6wGRSSgzcW3ygSDyll7W3TOvuEkuXQAMKLEJaUHHB+bd0j+aQIcdG6r5OMLTRo8y/DvYcV5+Pu97S7O1HREEd7u8eBH3Xak6pgi8mAz5Ak0H/cnGPPdNp5oIbFlx4J5ZVngd7MYEgcdRZoeF/PZ7sidAddgOdmUun8CwAkInMctWU5D0pKB4nGBMe671UYet4st4sf06YaCUxGLarlbDVz44Kzfd0s8Cimi57ZK/osWZK66nLe2uAqQPrAGo+7coWC5PCpQJmKDeA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a187aa4c-6cc1-437f-da1d-08de856031c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 02:35:33.0647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zyoIW6vouQDop1Zr3txv01/hb3S/POlNmK9h5rYtRv+wcc7Yszk3kkQCPw7EVb0/pkpk8JKPpi7oEVQa2aIthg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7273
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, March 19, 2026 9:31 AM
>=20
> On Wed, Mar 18, 2026 at 07:31:18AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, March 18, 2026 3:16 AM
> > >
> > > +static void iommu_group_broken_worker(struct work_struct *work)
> > > +{
> > > +	struct iommu_group *group =3D
> > > +		container_of(work, struct iommu_group, broken_work);
> > > +	struct pci_dev *pdev =3D NULL;
> > > +	struct device *dev;
> > > +
> > > +	scoped_guard(mutex, &group->mutex) {
> > > +		/* Do not block the device again if it has been recovered */
> > > +		if (!READ_ONCE(group->requires_reset))
> > > +			goto out_put;
> > > +		if (list_is_singular(&group->devices)) {
> > > +			/* Note: only support group with a single device */
> >
> > this series is about fixing a vulnerability. Then it sounds incomplete =
to
> > leave certain configuration still under risk. Probably we should first
> > ensure ATS can be enabled only in singleton group, just like how we
> > did for pci_enable_pasid()?
>=20
> I understand your concern. But I am not very sure about applying
> limitation to ATS support. Would this block some existing cases?

what about just throwing out a message to warn that enabling ATS
in a non-singleton iommu group may suffer from unquarantined
situation if any device in the group triggers a ATC invalidation timeout?

>=20
> > > +			dev =3D iommu_group_first_dev(group);
> > > +			if (dev_is_pci(dev)) {
> > > +				pdev =3D to_pci_dev(dev);
> > > +				pci_dev_get(pdev);
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	if (pdev) {
> > > +		/*
> > > +		 * Quarantine the device completely. This will be cleared
> > > upon
> > > +		 * a pci_dev_reset_iommu_done() call indicating the recovery.
> > > +		 */
> > > +		pci_dev_lock(pdev);
> > > +		pci_dev_reset_iommu_prepare(pdev);
> >
> > let's rename it to iommu_quarantine_device() to be called here. then
> > have another wrapper pci_dev_reset_iommu_prepare() to call it too.
> >
> > this path has nothing to do with reset.
>=20
> But the implementation of that iommu_quarantine_device would be
> still to shift to resetting_domain. Perhaps, we can rename that
> to quarantine_domain or so.
>=20

yes let's rename that too. the purpose of this function is clearly about
quarantine. reset is just one user of it.
