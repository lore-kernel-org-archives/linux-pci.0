Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0836A02E;
	Wed, 18 Mar 2026 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819390; cv=fail; b=cIv5TtLKLld+qkdvnEVSqRtL4MyRcILfY5/JI886Soa44Oqt11/ARl8DkGAH/KGfQ6xd3JHTYipglKWcgVElejb5Cz87Z7T8eTir6aPxHBhEBa00qFSfI41ofcnxeldvvnRpPOwDquA9tjlP+aaoQ5UNFFiXKUFb4+c0HHBJzDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819390; c=relaxed/simple;
	bh=1tg/kpWGULxue/vrPBmbwFMxVmXCgzqMo7AlTXTBMqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f7ejLAEafHREQL+j5+/3m6njRnP/WgHQ/WkSvOYcnoQ7PAmBqXoR7uQlrwLFMpQ5DWdXheqof4HkXFlYqcsrMlPfkZ86L6i1ohYRDjKcUp4CHAkVNzdorCwwTf1zd9YGemKlMB6P70lheHpYfLhve78HmZyYhLEIRZW6bsnIEtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IurUgunX; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IurUgunX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773819388; x=1805355388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1tg/kpWGULxue/vrPBmbwFMxVmXCgzqMo7AlTXTBMqU=;
  b=IurUgunXVMhx7dpsp0i+NILWsWI6XW+/dCushcy8msQC/pOBxUt4hSwW
   p3Z07bRrtASHfTpgT/tH74FqlGHGTGiQVblf2a2ACoC/fszIA4TZtbFtE
   /27EcPq6PPqPHGnx4n0Tp2GfJ45UpZcuvXR2u0D5amiZO8xag+P2BosD1
   wczgXNXYKnGfhe7+6mK1RjO2mOANKkwqS2DyXyeCqECd+cSntHTIpkEwx
   5BiQe9oz26alByTmCSHJxFFH81NAL8BSR9HuCfhlRf+8A37V7IO/Owpqe
   jmVmnw+42uPdkHNGo5j4M8V1uskZT656o5ZGazSPNnvaBI+jL8AuhAN7z
   w==;
X-CSE-ConnectionGUID: aplfnsFnR3yi5cx2sQ6rWw==
X-CSE-MsgGUID: yfh1K1wLTue2mkrHIEaNaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74046971"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74046971"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:36:28 -0700
X-CSE-ConnectionGUID: hhLLWp1DSNGigtnXEJSJ2w==
X-CSE-MsgGUID: qG8gsaXgTBOkCLt0ECPVwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="253010269"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:36:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:36:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 00:36:27 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:36:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PquPDF6ZMi1Ds8YjWNTcrOlVFbAiivdizsr4xrJyjJIITAbJSJ+vZ3aQdMSI0S8SoDhZC8yj7QH6BsdX//dQe3SXlInfcHrnceqp++AR/sSfwfb/5x7NBDqO4dPIUWLlPdypI/Oc+OqCQ5/5rJ3Cp1GNwA0GGXdwGIHFUQX7Ppeq0NXIzHYTxDv23cr0iLz9CLtrRVCYpd7PjvH4uKp/yuWIBTYtTzOs3ont6VxP/9iyHAakMZxw3i14UCyvcKMN0ShdIGoiDRJtLDgyMUL/Gje1Ivik6qW7jpY8eTVdnz9Snjm0uXfNGmDudJXEo4rx59Q0hHtcESV4ZmmtUMnDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tg/kpWGULxue/vrPBmbwFMxVmXCgzqMo7AlTXTBMqU=;
 b=gV8BuwCxseBGcW37dz5jru/aUdEn1F8vZwsrURftFhTEKzSRzwl8pb6vtpQZpxvRJhKMEIs3V6RMyAQbT4DO/N1liCFOd6pkOoYGWg0ZvZOJh3QOLWuzKYhAEovf7JEA9rYU97F5VxgCR7SVFCJHkTf+oL5LrSN8Jy0fMMTQSRPmB6R6IBAJQjlwG220RnjxCDqOKZPHc1kcgvb5lwqZrwzQ/7NOwA/Dtdj+DNKAAjPOQ2pDLXRGQsXEg+xdEJOuj0ryHiJ9AOPyf77wd8riK6yecZTkpyOK7NJem3EXGL7Yi47UWbUjo0HiF9ZZX2aShV7DlTJwSy5kNMpPbmUffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7693.namprd11.prod.outlook.com (2603:10b6:208:401::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:36:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 07:36:20 +0000
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
Subject: RE: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Thread-Topic: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Thread-Index: AQHctkK1dv4ps/vKUE+CojHzX1Q1QrWz5inQ
Date: Wed, 18 Mar 2026 07:36:20 +0000
Message-ID: <BN9PR11MB52763AB181F5213FAAB4F4F08C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
In-Reply-To: <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7693:EE_
x-ms-office365-filtering-correlation-id: f3f37d0b-290e-4085-8794-08de84c10c3c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: pK6JDKgnyKI+wJ97yhGO0mVO52WKVgE9fpKI9sIWslp6wD/UcCewB2mD1neHzrXdwf7GioX/r+ktZsodtHSU26ioYmBiKgjxFNqPXQByZlYDskBbffeOeZByIqtjbQ11koTTdrPKmedKmkFnaGHZLakSOgMh5J4O85dpb9ULA8LW1QbAZK4qjEUI1RdxcKGoNkOE3kVcSzxydeV+x90u2CCAGNUpwDcOMD22x07Yiygjg8SIsKVFmc0t3XuY1Jr+VXkgXhhc007UiMyJqSfCo4DBlZLBtGiTsPiV5lLplox8LlYBI1ttNVs3q+hs6i+77vJz9ot+1t/ZVtKy33AbyNU4+bgmnvqb/qXDGeCAcBZIQhb/gfYafgyqeBUgyu2Y+ZKAsXbPqTrjUV99k+iDblAlu0cUAJkzGA1M6ccQIl2s+pEQuvyHk/iCWDMASYqP1SJF+JIBOJ8HSpGc/17J2422AnYcCyS023aoTWwXD0DQRiS8akmQvDmEdXO21uS08TPnbHV5SXRLMGj8uPac7l6GD6MJM3MEhBptHttYjC91+6x04ssFuQX1XvqAAfBrdx80h97gWqHfwIvJ1gyQra/2swOpHKoA9esm+NPe/DJoMEv78xBT0muPBEw9dQ+et7e3SXwXASw/jfzNB24UlbhZ3XeIVuKg49ovYFSW94JPVIIl+22SEgcvzXFLEMFKU2V42cpDe2/keOIvZ7rbGDpgqj5W4O09elLtGX5RurYCpZa7T4ej/LACxr1JEG8jJ7G5Mdv7sjSt3i6n4tQqMnO75gUtMWOPEtiwW0AjGB8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XVWJCE7oqqH5+w8dIb839fEdEvH+b7aOcOU4oxusH72YCOOgrlbp2npfp67P?=
 =?us-ascii?Q?GvpZTpFjIu6vqPUY9Yn9hhR9jlEUQR4VLzGx+Hmqvj5vduqXtqeIEwbd6THM?=
 =?us-ascii?Q?sgqcShTXVFXUH7W7fmeLPhv3OMIUdo2keXqkfefitIlyuW3D8qrgA4LcJMwl?=
 =?us-ascii?Q?5ktcjXDAH7hEIgko0smd69GY2fxnaD++mxxP3hA8z/euJ5lP8Quj72/IvOUB?=
 =?us-ascii?Q?RMoRZw5o8hlaVF72Ak0pvcHmKRCXkfc5Hdkqg747SDDAzYsXvqDawkOhqLzV?=
 =?us-ascii?Q?oCgFRvJTllbU7j9DEHVqvOswf0USl8OOHsquDd4ObFOQm3jeGCKItmAeLOAp?=
 =?us-ascii?Q?37YUcKRtBqFBoRqe6L91TjrQKRo9jyCuAvNuXX9x77M9fFFvvWE9WuU6dNUc?=
 =?us-ascii?Q?2CvFGg6Grju4EZTUKjWNbrvvXoDe0/Q4pkDlBB868xPuyWpL2Ok3g5WkcFuB?=
 =?us-ascii?Q?bWkb8RzEPhYsxMrAq5oHZU0nONHVL4784KYz7O1TNAHtfCSyUmwiZHpvIKHN?=
 =?us-ascii?Q?XBO3jIwlIeBqvCfVYc8qf+122/OTa4KO6IUw/gaAF+RZVVK3S1JC/wv5E+/4?=
 =?us-ascii?Q?me7wk+iRucjviovXFtMMURBQgKBNe1g7ZP292Cwn/6PJ7IDURMSahw3JGxyP?=
 =?us-ascii?Q?RFl3KvlAA/h/WhBE7Ef6fwvcNOB0f7mEtx2I81ioIZ+l7PpJd4jXEjWq1WTy?=
 =?us-ascii?Q?rHlTreTS39EcMgJcd/F+s71Rs0TEbj3+OLcBHquX9d9i5D0KTHQ/llUi5IPN?=
 =?us-ascii?Q?N5nnKp742zUzfQ1SSkwS/Xu7NO51h4j2wNdWW0Nr6HgWQLpBOrGxMzrCazsH?=
 =?us-ascii?Q?wPXjCtLPf/S6XUg5eSak4QumiwBIfmINy8CMVCdDq0kpd36JbNjOS6/V7tyP?=
 =?us-ascii?Q?2szhioad5pdWQ03SGvPT+pCFsQNmdLRqDmlr+t4Kg772x44FFP1Rh25x8XVs?=
 =?us-ascii?Q?qdf1OvIbickyqwUbVXq/kYKCfTgmEtBe1Uu/4fAeOCs5nTaKkJXXVakavR6V?=
 =?us-ascii?Q?Z7t/UkzmtVRlEv5TLn+q48GQpr0doGFuCi53F2wF721yLZWvFv7j4jhEuJ7C?=
 =?us-ascii?Q?q1Qn3on9KC/ue8PIbz+qfQCwfp+c5M7ff/ATnDK5wxbVNbti4z1XQEHS37P1?=
 =?us-ascii?Q?3RZPuDmx5Ho+UQtzeLZsKnNbMZQz73R4vn+grP982fkApowg3zxoXTmp9DM4?=
 =?us-ascii?Q?iQhVLWgqt+0g3W3zLr+bPrakQa/OZzqrhqy5R0X//+R8d1liHjAkoNyFd/Xk?=
 =?us-ascii?Q?FgAXD8HE7JDcHK+qM/7l1ZjsSVveeT0hxCYXuLT/ykhFWntKnlkAUeykgTvD?=
 =?us-ascii?Q?HJRfD/B0RNE7crUZNMVhLQREoKw4NJoiMc33QtJlMLMl5q9zZO1yO08P9m2R?=
 =?us-ascii?Q?YtPz/7mens33UfwrOmAOeE7X1gLcxewwbFMUmLso2NkCDDBVpqUVNEiGaDOF?=
 =?us-ascii?Q?Xr5UAZ1yrlFaV5LhL+WNhWqgUbsze2AyeOtC0DC7C9dYFhLQYB8SIpGswaqX?=
 =?us-ascii?Q?g/H6JKIES8koPX7T3+o9gCAsYLa6jf1+LP0716M9PUSGAty/a68Pe2RL9Ydd?=
 =?us-ascii?Q?PM0nAXVhdDOvUY5T0c7y5M8F9CfbBq03uNnkAYwVUTJX1R51yoA6jZXd7fOu?=
 =?us-ascii?Q?+ibufiffX34r29LYB4EW1lI2e+hHgsPk/x+HXNf15UPUfPSxce6ECAbdHrL3?=
 =?us-ascii?Q?eJzUJZeDlYwK3v3IaPeAJmpgJs10Z34zT0s5DMW3vYzT1P9c/V9SWu4/AQf2?=
 =?us-ascii?Q?QA9KRjeeWA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Gikbdj1r5S2V79MHwZkHpbKvl+XRVaCsFO+HTvoW9YkjR9gNh0Zp5GWobnXCy9etju63ADgcvxci5dMjgZ7TZgecmVUxy5E0tMIa235yhtHX9mcFB/mlS6cnW2goKomXC1Qbj29N8lWnXTDdlqlBomQctvCkKZ8DLzC150K4HbuNvNJMGKCq2lXVImOVocJdq7WHE5p0xj5eP5AzEl0C9Y21pAacwHI2d/LJE/hfU9MYRcfY3QEqVXkY+SEfHAdP4SCUgHFaTg27wwHwiEThIkbWkesbdNDGevLjvh6gM+KSwGcBeF0Rrnbhn0gykJiRD2bMTNquqzg8O85U7k5xXQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f37d0b-290e-4085-8794-08de84c10c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 07:36:20.1995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f56z9GxS3I7cEhSNDwZu4lH4D6mOAP4/z2CQnmcLGUKF6Er2dy9cKyKqM3ZAAl2O3saY3OTXo7EcoceLwoklqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7693
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, March 18, 2026 3:16 AM
>=20
> An ATC invalidation timeout is a fatal error. While the SMMUv3 hardware i=
s
> aware of the timeout via a GERROR interrupt, the driver thread issuing th=
e
> commands lacks a direct mechanism to verify whether its specific batch wa=
s
> the cause or not, as polling the CMD_SYNC status doesn't natively return =
a
> failure code, making it very difficult to coordinate per-device recovery.
>=20
> Introduce an atc_sync_timeouts bitmap in the cmdq structure to bridge thi=
s
> gap. When the ISR detects an ATC timeout, set the bit corresponding to th=
e
> physical CMDQ index of the faulting CMD_SYNC command.
>=20

It's nice to see the ability of allowing sw to identify the faulting sync c=
ommand
upon an ATC timeout! On VT-d it's not feasible when multiple wait descripto=
rs
(similar to CMD_SYNC) are in-fly... :/
