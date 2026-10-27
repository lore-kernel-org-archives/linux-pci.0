Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793068896;
	b=POVfjGfVI8NY6jnyg/thibbCEQTYE1VNBBqhsHU5N1DGDbq3Ey+9Rtbuq5fL7pO2dXLZ
	 pdgl+oIIef4YfdMkWsw++MX2zr4TBfHUzHGo932AehOiFmhlqCGtbp0MrrcSwzGmPNYTs
	 RvOpu36emNOJGa3yM9Kog3t056XODcFors+K9hCZrbdkPWl56aq6faL/O3Rb7sJV/AXbD
	 aKd6g6Cdz1QeKoJSRyGUb+/VlLNQE1OKgV8cQD/02QbcSP5muFuWwCEhWOZkRPUF/8Pev
	 9WSMsS1ktv34MkNvnrUGKLVQT+rlra8rkTcflrD2MaUIgOw1Fs5uk0csW7uSf7/P5Wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068896;
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
	bh=pCoffFVWdZYqvFYgzJS+awfZ0W6yQs/CeqgueIv4AUA=;
	b=kiu7HY/Yp3IqV50UMR0sfSgBeMzjsYaiUW22l/ThHGx7gsMGycvIjoedttqcWNDWYTEd
	 sD1GCM9UdhvB3onUxxjFBCSZ/vHIa46LFbtRpmu87XlF5ynJTZpWjg+K8EZZ6yhNdS1Z6
	 kCcJuloeH5SgJgMgaIFCDaCsrZUWjdHakc+aJu38C1TK9ickZuqS64nH7IPO4wjlxYI/Z
	 u3eHq4UeCKN/rwWnxa3z8LyQLDlrqMYER9qjRETNGqVFN9GlrVlnYHtxOYM3JMoQB43xs
	 XviHcV9d60IPYfsMIjf7M2pxW7l9/HoD6/IaVoPhGpR/siFDTl+Vor6GPP5sooA8avw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GyYczoqK;
	arc=fail smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD35A606A31A;
	Tue, 27 Oct 2026 02:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD35A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GyYczoqK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793068893; x=1824604893;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VqhJlv9/KupJuuduGf2IhAx3sHzkfT5O/7B4j9iMBEs=;
  b=GyYczoqKL+Q9nR601rwuTVfyhjElaLsRkfHjn+Cma+UL3Qgzw9+hFw+J
   PfdbRTZrw015uBgACnmGrB5f6daG+J6yj70P2AsY5FfD91Cyi7RWnOYf+
   5SVnnH2odpXyd0Be52qpYrturQOPPdeL7G8UmqIdZimSCANNcQQ9yCCpC
   aIhXioApGJ04sf+Un3Ww+w72vPqZ3wgeFLWJ7dn4uijeQFfnv4N5fDDku
   +23uaoRpOGfnlNrd4AVdXO38XH84h3iZJQn2lBpKvKrlR09BDfK8RbdSi
   2zLf0quZ5tznE0eytNOiLv/3gorNvy/oTLPCmq3yGQb98joMpaN2kk7qk
   Q==;
X-CSE-ConnectionGUID: rGXZjPiTTF6tbc9yoOZIdg==
X-CSE-MsgGUID: JxhTwTtkTui0dFK7AowHcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1773363"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1773363"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 19:41:32 -0700
X-CSE-ConnectionGUID: YvTu3g6jRUesKIihKLSRxA==
X-CSE-MsgGUID: Qyqpul63R2eJ1JnP29toCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4453782"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 19:41:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 19:41:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 19:41:31 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 19:41:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLbRUs7GgTtvp2p/ETbHz3dzxpblTAaNZcAOY882RN0MknLl2OlWk7rjCPypZyGTdx65qSVZNoUUbHG95jR/8CIIi63PtMQjqKizmYmaycn3gHqTqrndU5L8NiraotoeHBXAGfR4kciFMyUdCERhuK1RyiNW68kZZB/3B2H9deFJV29Ezhoja+q15aZatcEN0f0NxQx5CWJlYAUuZaC0j0hcL5Ch77RngjzU51GTWcSTO7FKLgvNQrRviCL4/7JIs0Ux/QzNPP5qBuvkvviAQv4siejJYT7DKLGPDEdMYs+6euJr2+VnEg7Ui7ZfMobE9O5YIMQqsvv3V3L/+xzQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCoffFVWdZYqvFYgzJS+awfZ0W6yQs/CeqgueIv4AUA=;
 b=P75YiujiVMfF9Buoext0x05Zgfkaw+z5fnyZWwppEprLZaI1kx6G9F/74SaC0t52ZkuNtTQuBKPeIgTVB9GZ8MUJnJSmsA+7TiWCjzgWlEk8V2Ro6EKR5T0jyCUjJt05Hebu4gDa2VIPv+nACt80tmvH4CIFh3wjqvAnWvjMNdrIijrcTl5D3Fp16G+8g9DnvKxf68LWG2dnC8Ep+6LUTrhsfmYx32RnCXaQCAJ0YDG4OxVdMH6SqBhGd20/BtqM/+MkXVnxhNqXUASBlbyiBsWV/qjShxn0SoR5evcHg/zSDkn4yU2Yx44JBQ84D23RZoxAVw4PsMpn+0PeCHXsaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB9681.namprd11.prod.outlook.com (2603:10b6:806:4df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 02:41:30 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 02:41:30 +0000
Date: Mon, 26 Oct 2026 19:41:18 -0700
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
Subject: Re: [PATCH v15 16/16] tools/testing/cxl: Add HDM decoder range checks
Message-ID: <auAPTn-iZCFGqDfV@aschofie-mobl2.lan>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-17-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261011021422.3428136-17-smadhavan@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0213.namprd04.prod.outlook.com
 (2603:10b6:303:87::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: 50625c03-843f-480c-a0fe-08df33d3ce05
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|261026121527099003|56012099006|11063799006|4143699003|10067099003|261021121427099003|261009223027099003|261022113327099003|261022105027099003|261021135927099003|261022075727099003|261026140227099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: hN5UfFfuWdDEuIRVZ9WjGQ9Dn0RQOYQWR4BVRZkTDf4P6an85OGbD4r0yPKy+npoGS7dvIvdEbiDmAGqpuySn3b66oT3zmvl5Gjf2adNwoS+Q5AEZshNrZekwSb/nWxo+YPiXe2e//yNaFhGMh2hOynhGrRCrFTdS+kmmw7DLukyXiQ0yWjKV/tyJ7pfd3cwx1BmKgqQWibi3EP6xpKiy657IxezlubG85JkjxAgMtjN1PpyE1ad8xMC4SgkQ2nG4RHQhIO54HXbK3ELrnfbgNsmIJ9bPJdd4eCW+/rqQI/X7x7Ah1283RUAdMj4+Z/D/YMAmn5xlNTCv75p6p16Bd+IN/ShFv06mENzg7lKHTPqZVNyt0WqNo9rJfQxQIMhbbme8SUnsoOTg+HMFnwJGjJGLOeLsb0gNi4xh5hDIAOI4wunfjMhUoQaoNvviVWPPuITKNOgLuiVTR8vH+VaM7nJJy95b95Xtpi0EMOKJzR49H5A4oX2KNCwj3r8nMmany68caQ7nkdgIqv6iFRUOhqxHybusbE09ZmTDWHxRSOXJV0Wig7KK+AiihlqJ+VeM4eHzFjPLeI9oSzifWrm/aLZ26jCKZRqQUEJBIjrs/m4uJBJ3r57w+QeG2i1pADX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261026121527099003)(56012099006)(11063799006)(4143699003)(10067099003)(261021121427099003)(261009223027099003)(261022113327099003)(261022105027099003)(261021135927099003)(261022075727099003)(261026140227099003)(260925021311599003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+z41oazlTQCTJzbD4ELOFaZPIYMIkyoPp0aIdUuuktMB09inR87MYXtsAm2c?=
 =?us-ascii?Q?LQnAm4uwhoUd5nAPYodXAEJzq2RCRK/Q2mAa+ciRCM+Rd+lqQ0IDzeiE5/vO?=
 =?us-ascii?Q?acSEh6oVnHl6TQ+01GVjVOw1u1JWLaaTGDJXeCNRFJfvWOvop/djUPeYLOOH?=
 =?us-ascii?Q?HCu1FhIgz2QNDGbT3TSLB8JE/rtvFuhSRzefjOLONb6oRoyEJtvZ4ExcUPkX?=
 =?us-ascii?Q?ffXhig/t8Tv+y4gjeNvVL/Kczt568utvJ2iWs3eLA4QQ4NSxgpmo0ij1N/yT?=
 =?us-ascii?Q?TaqkWlsenpXal4F/dr5izQHuGdxOnR+dKn1xHuART3hFmZemm+HF6UcOJABX?=
 =?us-ascii?Q?fgnSKyLSa151BrrszxYCR4gqUnZe3DTqAbadlP6xINZBjwoGrzyCZfz72s6t?=
 =?us-ascii?Q?A9KU3NGuBUPxbHhiyFi+ZpHLZXzY5Wh+lu7RzyKkNCiUDbMseCQJ5HlDYdTZ?=
 =?us-ascii?Q?r719ZEFIh8K3PsIkODGkvjAzJeuf2BroSKAQerZu7XQwsDsh91TuKqibTAhF?=
 =?us-ascii?Q?XpmEGub4gXywjxVoMBS2AalYjUz1Mx/oo4gpjShWk0Qa9OvA9Qh3EW22ouAZ?=
 =?us-ascii?Q?INliLrUsifFmyA5ITCCHB9Px1vNe64tlJvsk2Ok2Fg1hnGpPvWDeYxSK0SOZ?=
 =?us-ascii?Q?TE1uM62PRMpk2HR52y4eTL72MvKo/MYG9OZOs9flLqgH8DMXcWJu9f4JSyMq?=
 =?us-ascii?Q?QKtQoVDkap/pcGDVUOl3jAn9yMWR6rAtQ7COLnkYSxVMTDVoCB8z3fCvilaV?=
 =?us-ascii?Q?cbyQdNvUyYdSU1nl4J0mfhatIB+sq7OafIfNq+dvd8xiZz+B2Sb6K2C6tkcB?=
 =?us-ascii?Q?fUBnLGafAhW3NVf8lWaDWObRz/gsRDc61EFugQhVio7lva8tRzz1V+i/7XdL?=
 =?us-ascii?Q?BPNNdCbaRfDLyDSOhzaDOtNalLQ+jfTGxbjJz6NFfKvjlpEb9jYKWXbIbKt3?=
 =?us-ascii?Q?V8G7BackpPAdIufKgtl9DlJI2cdqAYse5HhVEl+0bkpVsc9JwO6ePaqe1mzi?=
 =?us-ascii?Q?MM2KnU7qXSpnK+boQR2sqmEI+8Upp3JsrfFrjOGx7s9bdXMUWjBgBfCJVFlM?=
 =?us-ascii?Q?qNA0A/hKMBl5js9PbY/pZuxKTyhx79D4EVyx86D1hMzuGHvQlYyd2ZmF25QD?=
 =?us-ascii?Q?8Pw2nM6ke4a9qpnkVncD8UkM+AzeQ25voOnYSLnviZ2j2R5VCm6nw4K8WiMW?=
 =?us-ascii?Q?MTFtcl9+PqKujc4XIU1fUbth9h0cDtMqkVIJjO68thqjNb5G+fZbdlOMvkpA?=
 =?us-ascii?Q?jZukky3/12b+FvclQn+QGhG1fxKqUcM41d5FEP/tug89lmQuAKZuTJxQjmo9?=
 =?us-ascii?Q?Bh6Rrrp2udTXp2tixrhVajlciJmFMLNriHi2ENxnolKn4XAFlg6QjEmQtpV7?=
 =?us-ascii?Q?L6wPEpvbXx0CKzohRUEZofuXFvxaIYGPJ5u43HmMPxVcku7bpZn/ztX2c67l?=
 =?us-ascii?Q?kyD9GfhzYPL1g5FEbHP8duliFVeDJuYi90z5O7+ElyhWXoslG59e1Xn956Gx?=
 =?us-ascii?Q?3l4PlfD98cQAq/RKOxtIJhic5mpK/YKl8cxdj22EXDn5ZewXNs7Zcv805OO3?=
 =?us-ascii?Q?sueA68DXWx8qjuznAdYVP5zj1524SCzMpP61cCB9gyoG1PPOK1UJLYm97Xn9?=
 =?us-ascii?Q?Owe4GGQSU5UsCBA2aDNRVMZtIhTjaryWvqXWv0mfkIHFdhQthRYn9A1/RV7m?=
 =?us-ascii?Q?DB/wdJcpivvyJFEYSbQmWKX3U4KdErD83SQP3rTLOU45P5/j63Pv62kWAmnn?=
 =?us-ascii?Q?o3S7nFQDONtJJT20eVNuO5VC3iTFD8U=3D?=
X-Exchange-RoutingPolicyChecked: 5dMqTiR7sbMKwaRWt5cPdwvKoL0pZydhQdwJNWyp/Z4pYJ14tWL+GZtbaW4UENb0UJIqNAPyTLKdIr82uKfgluZmKLVGtbM0Tk5xi3zLelS6Aqv5mVRfu7DZgEVsx7d6JDFUmeHb9WiNopvgUUOXTk3nvQxxpSoI58yFwHWT19r6+JSjLhggqP8mhR1V3VbyMi0tBb9rbpDv+WURByQ7u1oKqo7r3irTEcr9QUVWVixXgyk9ifo6caUl+DqmobTm1L+F+Jvfltw1w6ky7cbwH+RomkYr/Ql8Z/73mXHOE4M4qq03sedOqESk/bQcEFDcFJ5xyqLdnmV7IEJT8JtZBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 50625c03-843f-480c-a0fe-08df33d3ce05
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 02:41:29.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcHzVdaDOkUrboG1VLq/JrrLKUeQQU10I+EtPSrrkeF1UtOopEvraxCQnLjg5IgET2Ye2Q5PQjfHNdpEJBtVq7AP/HVASTbLCECsC9fQoyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9681
X-OriginatorOrg: intel.com

On Sun, Oct 11, 2026 at 02:14:22AM +0000, Srirangan Madhavan wrote:
> Test cxl_hdm_unpack_decoder() when cxl_test loads, failing module loading
> if a check fails. Cover range boundaries and overflow, an all-ones base,
> zero-size and uncommitted decoders, and a locked host-only decoder with
> 12-way interleave. Verify the decoded fields for valid inputs.
> 
> Run the checks separately from the watermark hooks, using a helper
> exported only by mock cxl_core. No PCI device or MMIO is needed.

Hi Srirangan,

Thanks for adding these tests. The boundary and overflow cases provide
valuable coverage for cxl_hdm_unpack_decoder().

However, the fact that these tests don't require the mock CXL topology
suggests that they belong in KUnit rather than cxl_test.

BTW, but pointless once this moves to KUNIT, as written a failure in
any one of these checks prevents the cxl_test module from loading,
meaning all cxl unit tests would skip or fail.

Please take a look at the recently posted CXL KUnit tests. I think
this would fit nicely there. 
https://lore.kernel.org/all/cover.1791949910.git.alison.schofield@intel.com/

one bit inline below -

> 
> Cache refresh, retained-state comparison, and reset restoration need
> follow-up tests with additional mock support. These checks do not cover
> reset sequencing or hardware cache invalidation.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  tools/testing/cxl/cxl_core_test.c | 78 +++++++++++++++++++++++++++++++
>  tools/testing/cxl/cxl_core_test.h |  8 ++++
>  tools/testing/cxl/test/cxl.c      |  5 ++
>  3 files changed, 91 insertions(+)
>  create mode 100644 tools/testing/cxl/cxl_core_test.h
> 
> diff --git a/tools/testing/cxl/cxl_core_test.c b/tools/testing/cxl/cxl_core_test.c
> index 464a9255e4d6..8072146643bd 100644
> --- a/tools/testing/cxl/cxl_core_test.c
> +++ b/tools/testing/cxl/cxl_core_test.c
> @@ -1,6 +1,84 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>  
> +#include <linux/bitfield.h>
> +#include <linux/sizes.h>
> +#include "cxl.h"
> +#include "core.h"
> +#include "cxl_core_test.h"
>  #include "watermark.h"
>  
>  cxl_test_watermark(cxl_core);
> +
> +/* Exercise the shared unpacker without HDM MMIO or a PCI device. */
> +int cxl_test_hdm_ranges(void)
> +{
> +	static const struct {
> +		const char *name;
> +		u32 ctrl;
> +		u64 base;
> +		u64 size;
> +		int rc;
> +		unsigned long flags;
> +		int ways;
> +		int granularity;
> +		enum cxl_decoder_type target_type;
> +	} cases[] = {
> +		{ "valid", CXL_HDM_DECODER0_CTRL_COMMITTED,
> +		  SZ_1G, SZ_256M, 0, CXL_DECODER_F_ENABLE,
> +		  1, 256, CXL_DECODER_DEVMEM },
> +		{ "overflow", CXL_HDM_DECODER0_CTRL_COMMITTED,
> +		  U64_MAX - 127, 256, -ENXIO },
> +		{ "all-ones base", CXL_HDM_DECODER0_CTRL_COMMITTED,
> +		  U64_MAX, SZ_256M, -ENXIO },
> +		{ "last address", CXL_HDM_DECODER0_CTRL_COMMITTED,
> +		  U64_MAX - 255, 256, 0, CXL_DECODER_F_ENABLE,
> +		  1, 256, CXL_DECODER_DEVMEM },
> +		{ "zero size", CXL_HDM_DECODER0_CTRL_COMMITTED,
> +		  SZ_1G, 0, 0, CXL_DECODER_F_ENABLE,
> +		  1, 256, CXL_DECODER_DEVMEM },
> +		{ "uncommitted stale size", 0,
> +		  SZ_1G, SZ_256M, 0, 0, 1, 256, 0 },

Above cases expects target___type 0 and IIUC that is not a valid
enum cxl_decoder_type value.

-- Alison

snip
