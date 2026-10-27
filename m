Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793073406;
	b=496cSMOlYmgT1A6haLiGdM8PBQ5A2g+9ovW8pSQ3aocVlqLH/UZ0EuGxsmhWFjx2uvUQ
	 P/CCXg2tvnMEVFbSnIuDzBXUHZna0ScqXSe0VteXYgZy7Cb1veaP5QCSE2ulRUke2O0dV
	 ncm4uIpMDKFEpgSp6LLHNc9MC8vol2V5TfphJIkiIWlVLeLs9ehyPS6/n16RrbdXU51mj
	 LwC0HeP30nX2G7mxXrAsghhvoBKt6inXcjKY+uwF0oIC1Ig9ZSMZom+QUO9/uzmmCEb/G
	 zeWB8tvZLrgMM7Fx4grdrSi6SJDr5gf8C7Xu+9mUq5qvAB7X2qIjy3heFyVfghOl9DA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793073406;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=yi/ZmHjFHOZGBrMMJhKpNV+HOhEPZKanQqBgflRIZTs=;
	b=BqVGnZZlPakNYP9ewN7BIIV5446gHKRcarJppRdSHF/VsZwjinbMd7mvGDNIMC6OpRWe
	 mJtzFCOgojk9LRBpEp8LxPNvUpY2lYN54YE04IXWVPNlPIaIAmd+p2NzLrz4yQL+71jA/
	 E+Wbv25+WQyrMHytl5EfW/aqTLDxloakhgEVh5qXvyyd6zwL8x/CHwC3UXTfdeUvTjYXy
	 fDdRlitCzCwNEMeCYiYpxgdUD8+cyx9y4OAgO6T/gQPyi4P/1yDvK8UYjQDvGFowTkhhj
	 /SIJU/cTaL3QR9nqQkmzBESW8fYwanmkL9Gd6QgwwpE8j0CPJDEu/NxaE6SnDFELwyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="E/nbtoWq";
	arc=fail smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50005606A31A;
	Tue, 27 Oct 2026 03:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50005606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E/nbtoWq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793073406; x=1824609406;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SI/3t3sySFse9ga75mf14JZiKtIcAiNhQAjJuBx0lAI=;
  b=E/nbtoWqLZghsc/sYAA4R7fxomjM03Zz91AXTUXuT+jozOizgqhAony7
   YdUfFu3C3JVx2g7C8v9e2dO7s/pxy2V1TaQIJYWQWMkxdbFHtrH1mZp6S
   iitKSyKOT9elW4hFBOPa015lXdJnPtqEJon1ViDKJhuKK9xypvUJBiH0J
   LCXmio2Zh27NTcLIv4zfjHv5WwI7R+FdVszqgD0znOcQ2/m6oi6Tdys2j
   pMH2seBGUrO/cwhAbLws7O6n2/PnCouWPhB9Dx+wLQXM9cUlBlJqQPC0p
   ETFtktBTldqZJON05JhSluJHjBViLXenQoli7XkGvWIaWNBWuRZq32R33
   g==;
X-CSE-ConnectionGUID: Nask/xXyRROcH48cv+MEaQ==
X-CSE-MsgGUID: rfdyVVL2QAafjMQGliy4Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1757412"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1757412"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 20:56:45 -0700
X-CSE-ConnectionGUID: l0CVfcq9QZ2cdBwb/X1oCw==
X-CSE-MsgGUID: SG9dMJ/PQSWb9AzyrVfn2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6270950"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 20:56:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 20:56:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 20:56:44 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 20:56:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWMmwgLxX0QB32eRsDUsj6ALDXyR8QKqOrmhJN+o4+N3b9fxVwf8eC7pX0Y0/8WfnT5BcI6egwMU4HDHKMe6GU8AHpQ9prEKLI8xIPy6VQa7VH5Cy1NvX/YqwfqenrsTFx6eE5HVRZkP4btpXZANOadNz1JmLmd20uDKJJFBpElDbdDOWrxnfGvMNuWRhniHF+a7KkpFur6dsk2zpWt8lD5NekBIgGjKlrNwqWnL1svB6EiqZWl73Ub/YOLETlLmmffzf2iCM7z4eOy2YfJAwkQ2r38ogVzaMeh6q/nwAkYreUpangmuJy1fJdGAztwPFM11PCBYStO2FbgcwpZa4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yi/ZmHjFHOZGBrMMJhKpNV+HOhEPZKanQqBgflRIZTs=;
 b=go5zAqkwXtW95XSBgI3yijeOZhwdEaszrpzEXvF9KvEwVU2VWNoyLaVWWhEAMrQVlE0IjNTn/hUNrAx0GzHA8eyySI8H2kOtPdsqhkocRJIUQlHAmptSGcWFniN0eu2H3/MyTBNlUj5IqlP2O98YMkFtNXzR3jcgBDOzvyrhqe/SEbITPRnTFLD5Yuatk9rHyoG55fMyI+jl/+MibB6kzkTJz/nacrNt4Fb8mwMRSZduKWmpUaYMm1U7csu0T/zSAfoLDKsZ7ncCapRkOv47U5MJ0gPpcbdsrlFftsMGyVYUuYoFKfVZfR2qmvAN9BmuwB3g2I7LVjiVlc+KgtTyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB6291.namprd11.prod.outlook.com (2603:10b6:208:3e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 03:56:36 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 03:56:35 +0000
Date: Mon, 26 Oct 2026 20:56:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
	<vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v15 13/16] PCI/CXL: Restore CXL state after PCI reset
Message-ID: <auAg6MFDGyVQvQxM@aschofie-mobl2.lan>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-14-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261011021422.3428136-14-smadhavan@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:303:8d::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c199d6-639f-4c0e-4865-08df33de4baf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|6133799003|261026121527099003|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003|261021123027099003|261009223027099003|261021121427099003|261022105027099003|261022075727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: W9PrWmiexa0k+K9clHzvK07cfVpgrAykcGUgN/8+qChbO+E/qYQBxvx0q8fJy14/8Q6PlBodA/D1Uo4DUXlYKkpaxfrUlsinGdCme5I9l4sq2/qdZUWPmEaVosDzYreA0Q1bzXM4wypKlpSb7j0leC6M69VvlCfdfgnv0UXDPUTaaPF9+D3t/imO9I1T5Kp/J5qzw+SP2QWLX4STDE5y26PYExJJ43g6Zn629+TssyLFDpcD6LZX2Fa1bYljOUvDKmD4DPP7jdn3p63guyj28oQhls6fzBbcVsbgHDbX6lxhJFtycFcWTzADLPJ9DMtBQTOe4X9P7Kea/Q2OtsbkVBegBhQHrsFAcMcmK0p1bdE2TTxPPAYKqMqwF+iYMt7cZM1bGi+1EFE8JyBcphQ12y0n3pDjAMmOHuwLUAF8LraT7EtIFvRvErpNmQ4k09INyADyVhsNv+POUjRiGZMk6O48tkN+XNaqrfkK2Egjvr5FtFjnI9oX6OGGVYMK+awNGJ2kHL3XcGGOA9ZAdfB709b8MQiis9x4nZHsvK1rpEzTsp8yjsWqCNx9GQIEAryKueh8+qPQ31FaMIIuFCbSlLwLxnKkU8PTf+ogzxJzl2A6ktVAfsDTi/BaUpXiGzusuzNsnLcodT93uceAuMozLr1YODaFM6d4IQ95fbiaT0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(6133799003)(261026121527099003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003)(261021123027099003)(261009223027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?905N/XuPRCmQIpK3g2CUJ/UPgMdcRSaZ90lib9jw1p1G+iTBROxJ7Nq5iP9B?=
 =?us-ascii?Q?OLtKwz/30pgkNGgFLBFbQp8Y8XiUFAgE6V98qALz751MYOt7H6W902a5AGj7?=
 =?us-ascii?Q?aic96sK5gxnMBgdLYnFJyEU4FSUg76WDFyU0QzQL1htlyo3sp8dAUyK/Rgrs?=
 =?us-ascii?Q?HvGo9+5JkQS8hrOLXl9XPBb1d4NMK44lg3Bu2nBsIuoVw6UIS0QU3iE1culG?=
 =?us-ascii?Q?x3rSf/3KcApIfD7092sCqvZZmdrABuSFYFZS8XZfFSThs0Aj+3rrXxcqaZeB?=
 =?us-ascii?Q?7VAWlachHyBCpzHZbf6mVVs9+yiw37khLTbT7Br3dUuhCgipR1KREEGoooMP?=
 =?us-ascii?Q?j3BYlyZiDzZ5hS76GLq+gawa64YmcidqQW8HPnN0prSw8fLFmgGIXNyKgsYo?=
 =?us-ascii?Q?3LXLa0A4A7CMfaiZGhtARcEJyj2b7dc30Vsi9jpmZ72TJgZ3FBZ3Qmr55H9k?=
 =?us-ascii?Q?PMheL7hi2x9JzXYsnQInUHT1aso2molww+8rTnAu/lM3cIm0RA+MvusPiO20?=
 =?us-ascii?Q?sbRsM9ivR0iu/4wnEnUdhlQcJE7KzA8bq+FZtjDeQWzZGOFdESpl9+N/ozqM?=
 =?us-ascii?Q?HN+bncUfP9VxtaOqEYY7g9++fO7GG4UEbuRmkhAhXv80oLm5UWe1JplfWWat?=
 =?us-ascii?Q?FBluLrac8r75Oxik70qZ3497fXR6EiwdBSI0K9M9AQK0zsqVPw0uBNIrAjnt?=
 =?us-ascii?Q?SuRH8/dtsIyAgw1ymfi8nyDFM3NZDiCTgL6WH1YgekVW/nstZGr8UVAQookr?=
 =?us-ascii?Q?ab5L0RANr+9asGrqyWRhkZTLp85HCDnrfLaAJSeyZKVCGJRHdDT0KIDRzKdk?=
 =?us-ascii?Q?+HFYOAaMOEs2dQ+k5GurkuXgGDs8Wm3dYb3Fr9/u0NKDeYHgbjecwB8rXK/m?=
 =?us-ascii?Q?oZX2KcBN5qVN1W2g3tUMndLQGSUULm/q7fD6Nb+JVeTqoYAbyYdtKe01eIyL?=
 =?us-ascii?Q?/+Je+Sm15REmOeGobifQfM2+Zw1awErzwPr5yBdb7YGFZiTGWVN7hZG6nqmf?=
 =?us-ascii?Q?ZUrZYKlDU9+UCEkMCS+AeFi87pMAAe7PJbFPd6yRQ+yZOqFbuxunNbM7/rpu?=
 =?us-ascii?Q?46AD0K+brz5jNVeXshD+OYtezx+UQxNfR0tige5HMFnotjWERD4FECu4wcp8?=
 =?us-ascii?Q?kmz6LVf0EW7vf43OQeSLEEHDYnopCcibfAzf5Mw4LRMSOzfvgOTOurTQ92aq?=
 =?us-ascii?Q?m//l+Cip0Gxk2c37bKwEqBjwNkpnBLqCFuPV3O/BjvaGLkRRHRPyH613mKZu?=
 =?us-ascii?Q?1VIRVgk3lLIMIT6P1jn5j21skz/6AhdSUuhfjQRhgNVVI6TDzZbF8FwVrIMM?=
 =?us-ascii?Q?VThEU41IL6TMYesxHQ4sLufvxvQNSkioWPd09S2a6JjO6IY4RcLPXD3Ou+Sm?=
 =?us-ascii?Q?o/MASjTHYiXA8aShmNl+UkssnUAahwQIGFPI3OJ5DukWLMRzPMA328BpTe1N?=
 =?us-ascii?Q?RLO5PohXpaQEsTUGTSbgA3SM4T8ehMy9icgqSVljilwkI0pfrVl4Oulk1+Rn?=
 =?us-ascii?Q?aXvo5WfXSdn1P0oOHmjiPt8BhNOCLMYSXRLiVIBNUVG4zhSUIgUjzvzpXj4g?=
 =?us-ascii?Q?o/G4QsJTVyq4ff9ymAU3RTWRx93A9wegerXijK0O1eloX9wuFzIvZAyv/xy9?=
 =?us-ascii?Q?hBcIXfkWCyEAaDaCocQlsPPMJOOCjHm1WBqflwy1N0md3NEayEHbZbfZc8mx?=
 =?us-ascii?Q?Ln/h3Y/cYRiqLvuYS+CAmT5WgWjWdyJY5A6RJLBpGY/rSkf1stLcidnPaec6?=
 =?us-ascii?Q?6EmB8o9Q68deczWRlMm9pBlVTKtc9AI=3D?=
X-Exchange-RoutingPolicyChecked: Kivz4dzvgSXn7yMof9PYYhZmOlZ3vHUSvFqNOEfTM8CdE38zppoWNWM4m8/5s/ZqZEJ6R2oIMmYGWQ9TQd/VmyPvtInVdKawZm0Jg16RZQJY9bqfzrk40KnUSRUUdBDi9ZrqBPXtq7EucLoe6aiXIPzfMQzyZZ1pCw9bTKD5a1leU85vhAJXRFFWHu0oBCtD5ix2MSPIVgb7JdXKc/9wGuel3IPHDOkERAkH+3qcoCSa1oxHvUbRlQ4syrGkTcyDj07qfdIYfBaZIRiPZEfWZQ5iH9EeBo0nhlj6Vs1Gt44XS88Wy0FzVnPYOugQ/I3qPv9emgjimmVPpLZhSb1VHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c199d6-639f-4c0e-4865-08df33de4baf
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 03:56:35.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqgpTWKrn3+NTP/cR9dcRtI6rjsCoWFd6uQFM/qI4Vkzt8qfbRJM1XAeLD8/pYkgjIpQVMFOHqhN8XhhTLjmQaAGp5HQ2/KMgWAtArOwcbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6291
X-OriginatorOrg: intel.com

On Sun, Oct 11, 2026 at 02:14:19AM +0000, Srirangan Madhavan wrote:
> Restore the PCI configuration needed for HDM access, followed by cached
> HDM decoder and CXL Device DVSEC state. Recommit a cleared locked decoder
> before restoring its lock, but leave surviving locked state unchanged.
> 
> Stop at the first restoration failure and preserve a disabled PCI command
> snapshot. Keep IOMMU exclusion active through restoration and post-reset
> cache invalidation.
> 
> Program the decoders from built-in CXL code that takes only a mapped
> register block, and keep PCI state handling in drivers/pci/cxl.c.
> 
> The restore helper structure and diagnostics follow Dave Jiang's
> reference implementation on his cxl-type2-reset branch.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=81fff5893a3140361cac625b09ada798afb92e03
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM
> ---
>  drivers/cxl/core/hdm_regs.c | 180 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/cxl.c           | 176 +++++++++++++++++++++++++++++++++--
>  include/cxl/hdm.h           |   2 +
>  3 files changed, 351 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
> index f0b360867655..cef5e9949d2c 100644
> --- a/drivers/cxl/core/hdm_regs.c
> +++ b/drivers/cxl/core/hdm_regs.c
> @@ -73,6 +73,26 @@ int cxld_await_commit(void __iomem *hdm, int id)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxld_await_commit, "cxl_core");
>  
> +static int cxld_await_uncommit(void __iomem *hdm, int id)
> +{
> +	u32 ctrl;
> +	int i;
> +
> +	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
> +			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> +			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +			return -EIO;
> +		}
> +		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +			return 0;
> +		fsleep(1000);
> +	}
> +
> +	return -ETIMEDOUT;
> +}

Hi Srirangan,

This looks like a copy of cxld_await_commit() w the final test flipped.
Could cxld_await_commit() take the Committed state to wait for, instead
of copying it here?

> +
>  static u32 cxl_hdm_write_range(void __iomem *hdm,
>  			       const struct cxl_decoder_config *config)
>  {
> @@ -273,3 +293,163 @@ int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
>  
>  	return 0;
>  }
> +
> +static int cxl_hdm_decoder_uncommit(struct device *dev, void __iomem *hdm,
> +				    int id, bool *retained)

Same ask as on v14.
Can the restore helpers return the error and let cxl_restore_state()
report it? v15 swaps struct pci_dev for struct device, but it still
runs through cxl_hdm_restore_state(), cxl_hdm_restore_decoder(),
this function and cxl_hdm_read_decoder_settings(), only for dev_err().

snip

> +cxl_hdm_restore_decoder(struct device *dev, void __iomem *hdm,
> +			const struct cxl_endpoint_decoder_settings *settings)
> +{
> +	const struct cxl_decoder_config *config = &settings->config;
> +	bool retained;
> +	u32 ctrl;
> +	int rc;
> +
> +	rc = cxl_hdm_decoder_uncommit(dev, hdm, config->id, &retained);
> +	if (rc)
> +		return rc;
> +
> +	if (retained) {
> +		struct cxl_endpoint_decoder_settings active;
> +
> +		rc = cxl_hdm_read_decoder_settings(dev, &active, hdm, config->id);
> +		if (rc) {
> +			dev_err(dev,
> +				"CXL HDM decoder %d has invalid configuration: %d\n",
> +				config->id, rc);


cxl_hdm_read_decoder_settings() already logs this same message, so it
gets logged twice. That goes away with the reporting change above.

snip
> +			config->id, rc);
> +		return rc;
> +	}
> +
> +	if (!(config->flags & CXL_DECODER_F_LOCK))
> +		return 0;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
> +	if (ctrl == U32_MAX)
> +		return -EIO;
> +	ctrl |= CXL_HDM_DECODER0_CTRL_LOCK;
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));

This reads like we commit the decoder first and set Lock On Commit next.
The spec seems to say the lock only takes effect at the moment the 
decoder commits, making this too late. Looking at spec 8.2.4.20.17.

-- Alison

> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(config->id));
> +	if (ctrl == U32_MAX ||
> +	    !(ctrl & CXL_HDM_DECODER0_CTRL_LOCK)) {
> +		dev_err(dev, "CXL HDM decoder %d failed to restore lock\n",
> +			config->id);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
