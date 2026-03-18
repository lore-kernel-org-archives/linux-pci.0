Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C4236C0C1;
	Wed, 18 Mar 2026 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820045; cv=fail; b=A+oozdHGxE26ugWLHkvfK3D//DT4kOIMOGPwHTnz99ZCJ0sKr6Qvrml3r1QX2qjsjbSDtVYYJa5V9A00yF9iCb2YmZHF4BaiwpbGZoRCBj+AMNQilBF5tLdE6SIRCGZxUfWtjrWzCmBV6JMhm76Cc1jjANV14lKLoPXdxQ7tZcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820045; c=relaxed/simple;
	bh=XEZgL7LMqTWzy7I0jtwOLq/FiHipXGN2cyR1cuTD4Jk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fRaifu+I6AboBvMcKZYi/wJOH4xFKo4aOnE+asZ+HKNWCB7vfJ8YI4hKADAzk4Vfyt6Fn/NKdcC6+Syaq09/ZuAI2tqZMGBkftHUcx1gnkJSOWd9EGwVexPUGnIUwgWYHZDFrSVCLNLFtC6+f8fHWXUIthurq5Y4jQYy9vjQcM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8n7XCWx; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8n7XCWx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773820044; x=1805356044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XEZgL7LMqTWzy7I0jtwOLq/FiHipXGN2cyR1cuTD4Jk=;
  b=K8n7XCWxucUscDmB1ZEN1q8WGuC/duQI5P6KV+17k3EkwgO+mk7+zW1s
   I508Rrss+abzeBKWP8O6ZkOAEkeUoPMzMV7PEk2vZgQOeSi1hWgmNUZZz
   o5k1kJfKwtE8GF6W55LrOeO7ZdY2V7PYeUvxM1wkD9Aid8L/K4daMAtBT
   1YKfzSJO4JWUPNvNEbOL+t8D62n1U+rHhb24Adpm2QLkiX+F22rwPfSjj
   r+6xGZn+P53CxQJZrSOsGXp5b/LTFR/iObLuJiIYDsFPI5Ns1vuS9+NP5
   37NpeHFbuhC8hXhJYsivJE+PJLhR7zhRXioJIhQOiZyljSfDAFwb11nHK
   g==;
X-CSE-ConnectionGUID: 4BhzAeJYRI2oRpRB9X2REA==
X-CSE-MsgGUID: Z7Ff8PF0S7iQ32npjzxWXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="62432020"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="62432020"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:47:23 -0700
X-CSE-ConnectionGUID: 1C9TM7UATI20D4xEVd7lSg==
X-CSE-MsgGUID: E4Smry3oR3iNyWbfC5L6oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="260435001"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:47:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:47:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 00:47:22 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:47:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRKzjTy/RUhSSNpc9GqwgH0qr4vnZwSsaLsf7b1/Ti0f7zMrSHrlBt9v/XVr1xnilF+RQFtYClTfj9L9POmYYNM7mc6wexv7Lyjb9Y8c+TUkyBIaAyC+qxJsEAy5r79hZl4JO0D63Smvj5oxr5xV6IPSvaeHZRN6wWpqx62V88ihzgjpbOWwAtJMv77RfruVIlv9lAZEqcf/mUbIr1XIWY9ZJ9TlvLQi6UJc9MI/LbmiFIREWUO9QAfNYaeZ5ZrxBUKJxYQv+VKqxECSau0Pl+YMcns38nbrkEpAe188tE2XhlnZFDPzASv2YSeX1YXPxU47qziQtnDQ3PQ+UWaiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEZgL7LMqTWzy7I0jtwOLq/FiHipXGN2cyR1cuTD4Jk=;
 b=BHF8ohIQfVu3sZIkRLEw9xEdnwFVd5ur6aHm9niDmk43ZC+cQy++pb/HPR1kvQqslb/z8AN06KgT6Ot9NNHgvg4bFWKLOUZoFwgk41m9EZ6DoeYXW8hCiIqrY6aylUsAJNhiLzATWoTt4Bs021Tf3AdQaK1mSOvoqYm3tEmQnHyWiZbYWIehCWFO6B1xLRWhpOkG6YontZ/rH92V8fY561hxeA/qeqMRUOCQ2I3Qdg9CvCfwMjkB0cXfORhXiSFjnKgWRhSEy2JLYYseE2sYepSvbnYIA7kl0pTjEKaosw679n9/ntaXs/nILL/1awyzRJlx0obMM3LsFKEWMDs7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7567.namprd11.prod.outlook.com (2603:10b6:806:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:47:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 07:47:18 +0000
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
Subject: RE: [PATCH v2 0/7] iommu/arm-smmu-v3: Quarantine device upon ATC
 invalidation timeout
Thread-Topic: [PATCH v2 0/7] iommu/arm-smmu-v3: Quarantine device upon ATC
 invalidation timeout
Thread-Index: AQHctkKXc5nudtokhUmd4/hiAhcpbbWz6cEA
Date: Wed, 18 Mar 2026 07:47:18 +0000
Message-ID: <BN9PR11MB52762F94146776026CA203248C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
In-Reply-To: <cover.1773774441.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7567:EE_
x-ms-office365-filtering-correlation-id: 03f15e1d-cf0f-4c3a-8973-08de84c29454
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 2uqN/k/oZ6H03waEiF76Nc7CFNbiiB0MHVwX8g64R0qIdr+wDnkLFXo3yTtxYj6g8QkZW9VYFVlIB40TvX/6WeNS/INQJw2HhQJ634lysUvLTqj42vCsvXgQVnBbZ1qRcEqjihYI02IpZx9AYo/885x4dUiLm9/jV+fnYgI88ebvTVfm5k2qrps7npkMKzgYz8H8lakXcRYG5rML17XlW2PK6ZD9LAcFzEz2YP2BuaKy3ZHDC59wSNuISif8SmxMF9s30nLGm1oYuY48CwPtZ7DIGzfD1ePPVXc2PC4NXepuydzIul0M4qdBD34l5jhHMDOhWW3HpOaGA39Lu2RGzGpRCS08EFyN3QCDH5Y+PvHkkUsFWcJgkT9XhV8U2/LG0hhRzUN+O52ijRtHtSZv+N0OXPDWIKtpr7TiXM7V0oVxkZCoYwUFbFhyd7JhnVegcu5rMMMcDIg2JoNx8/a9t5SobBeiKvtS0opZAqopd8tzGGBrWa3jdHPCpTMiqov8qqCGxjFJJA9L+gNzGJR7Et+Z8i+4MksFIyhN2Bhwvyw8bwH4RvF4HUNX8neDrw8wmoGhQG8vFIUQXZhz6tCpZRrhWvAhhiymAXMwQSekDI5V2wvZHKl/HNtv2/tWCglqR8FgtVg1ZZKCHr4LemxqVbTlxn+fEbIEpbnQVH5JXFfpeCEa78fuIs5vP9GNTigEOuCtdt6upKy2PsNH0O9Q0MFzGlK4GbKKm2OWCifx4x/i8mFZ++p4+TetSsOGQPqWT4xS2QrF+5ZYilcJu91aDhyqDoXU63JMneYAubMTRZc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qcs6uuDufSuR3YISUNYnU4wusS+0JujHh0EQ5wxarmVuOSxOnw0Hiip6Ya0r?=
 =?us-ascii?Q?m4lS1MLnewLxkXuhGZYJ+iApwQ4z9PkEcXKNKBKOYMxVh1dTbEL0cRVaa50y?=
 =?us-ascii?Q?kOvz9i/PfvonMv6fKSUhKVrBupXIzELw6wxcrxnAxXABBPcHxTUrqaFYhH6A?=
 =?us-ascii?Q?AI6bnfe2kfxlNB6nnUydUPf0/01fLU0HaWLO/ZIk6QNkvTo+OMTpp2kU2cZh?=
 =?us-ascii?Q?2g5xKsNLPy1xyFRHyBCXKr5I1YeuJqifdrgZ9/aBL/rNuWx9TH4+xD4CGhIu?=
 =?us-ascii?Q?HcfDIr+EId2kZsiJUxbP+DeJEvbr57uNng2GjGuVoh19YgmDHqudfA+tCeWJ?=
 =?us-ascii?Q?XP82TG+74JwpgkWbGB0N8VGdPuc/G4Ha+EsZvH52462m1bGjGO0KpRvmFXVa?=
 =?us-ascii?Q?m+pvOVzFXU22mLiKqUy1fbkUaYzYhJQoyZkSajR7N8T7Up383iex6wU+HUP7?=
 =?us-ascii?Q?Ch/vbXgr7Ac8r8dYQxtfHj53LiJauUqgQLMsTEnCc9ai2iI47CCC6slR3itm?=
 =?us-ascii?Q?gMxszvh9YU+jRzfk3mylzSFwGA10wPzHMTcomKs1UJwak7vL9LnUYWYgix+I?=
 =?us-ascii?Q?sc7aQun4VhEME570M6wfrjVhTVV46ATsTxQw2CstRqi6BvYg713D45C54Maf?=
 =?us-ascii?Q?SjxnpEWkUJgqBBPkZ1uKtA078JukkTlOCONZ/54caS73eQ7g0VfeIR2TCk+d?=
 =?us-ascii?Q?eY3+kNyf6R51DVkBm61UGKSICjNhw4YRUSOaxZcEvTaj3Fb+uObbClKrTThg?=
 =?us-ascii?Q?/EUGMIVmmGxa07KNo5nJyHnfF0PHDJxZUjrePzzumBuE+oZIPSgh9ZsObszi?=
 =?us-ascii?Q?KdVYVoy2XAhUbByt0zoB9HaYMOVgV4E77620GN6HKSkBlSeBaokGtgrKB/0B?=
 =?us-ascii?Q?uM2P5tTb2BrMsoD0DcKT/I6gVqx4WjO1VL+uLUYkyL+VXju08ASw/HNphfum?=
 =?us-ascii?Q?G1aH9vMI5hLEcTGJ4hSOBONOmyENdTJETL38W3ZXeGUEpJlFDkq3m+F3bqbb?=
 =?us-ascii?Q?mQF1T/jI7dvvFGMXevrUHjxJHL6QSfvvA4KUkobXF3347t5ikNNZZjzZV3IL?=
 =?us-ascii?Q?JNo7xCzLmmZNSuAYvUBnn8Px52972soWqLwG/LLNqjdSlb+V39NRnDM8GrLL?=
 =?us-ascii?Q?tgFBRsbCb1dgojf4PxQmnDzXpJKgN7Hu83uIhSW/1GaDdYKoa+c99O18cMUQ?=
 =?us-ascii?Q?ana0nx4vUYTv4DMOnDXy3f3oFY3FWOwy4bpPWwgZxuyAvGYb1Gr/w3p52cui?=
 =?us-ascii?Q?4zKSSIFkb1FQEqfQy/foi5KndLgyRqB6E7bV/TOoOShhR8NrfkuzBzI9Oex0?=
 =?us-ascii?Q?DwvG2Ey2XYlIAVid5oJ5442fbK2rlib3FfHfsv4oROILxJP1az4W+t3zIeTp?=
 =?us-ascii?Q?Tb9Y0tePFAquJ210wtSXWOfJxb8aPnyNbW7nXCRmpd+Fpu/4DuW+tbCvVLvd?=
 =?us-ascii?Q?HupChKdTlRfFPMaiga7XMwUzQUraApScn5DYLiYmeRkxvS5nGihWjDWie48i?=
 =?us-ascii?Q?yH28MJmk9bikg52iMVBAcBtfx9X6nnnGRFaCQ8zstq1bI85hMcCx5hqthuF4?=
 =?us-ascii?Q?r5xH5nwnCtzXhFmg4NnEHRw6F+USXwn0Io+uPeJ9T6NIgt+9GESDzHVuQxJh?=
 =?us-ascii?Q?DVCDx08W04LGc/0pY1SxtzDPDZVaCkeQf6POsMuYmSwVmty/pexFf498zN7j?=
 =?us-ascii?Q?bbq7YsHyyWV8OTgKH1NLKVwFbHLpZVKmp/THKIF2c5c16F69r3cJPPZkeHFa?=
 =?us-ascii?Q?D4pfIhJXWA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: u/23gLcd56ztXlb4vC/n50znYjKvMzJVvvWCBf6r5hJsA7KmBQsLlelJc3ds1ebyBccwFHvQL7/peQEy2phc8YMmZ5Pqkt/dWeOL/58SxMoRJxeTRt3UEc9IdGVm+81wVho4Gk7IeAdU146Z1GuaWqhnghRcFNBfV0LpsKGsjB/y4riLVXBXl6xlHumj4ctuhdjZ/H9bd11U4cU72LeYkEWKCxHDHgLarEv3bogHm3iWetTmP50RVTFOHGKqRw/1INlkZc7PLEQYVxFXVXEWiXJWY5el3+QjyMGegf8itgSSdyxqwZT8OIIOsW60G01twDYpi8Yuh+0/0KV7BVc4rQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f15e1d-cf0f-4c3a-8973-08de84c29454
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 07:47:18.0260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0aCA5jroxD7Omj5n8+hfPtFsNdoUCHfg1IpiS0nYHLZTG2GnB6btFn3vyNI52DOZFMn03778MYVnqOtfM1GnHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7567
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, March 18, 2026 3:16 AM
>=20
> Hi all,
>=20
> This series addresses a critical vulnerability and stability issue where =
an
> unresponsive PCIe device failing to process ATC (Address Translation Cach=
e)
> invalidation requests leads to silent data corruption and continuous SMMU
> CMDQ error spam.
>=20

None of the patches in this series contains a Fixed tag and cc stable.
