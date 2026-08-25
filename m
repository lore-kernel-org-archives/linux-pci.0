Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5803351C13;
	Tue, 25 Aug 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787671570; cv=fail; b=rrDWL9CyjBVa9Qy/QuXun91t1NPDZl6A7WytUXouxHnrUfrTd3cQjZpPUSVqsRzWT6Of04Ln6nB8zWPW3XQQL7U/ATc4Osu7xH4k/HUjGsDIWxpXwbEt+HpoedxOoJvZLAl8WvDntnJlisMB+TKnrhpLPs8xpoDyMY4JJpXASp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787671570; c=relaxed/simple;
	bh=3WtCpNtb0OCw1Ui2duOywgVkhqmB97XF6AVqZhkqrQo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XaCpPedOa5wFpnj/7J+LBjPYJ+fvzkBfe9WjXbotNI0KmbJKcbtS2bM/ixwCrSUDgAQ1kipGCiCg0qQ0gbNOnBdRzcD0GSHPg4n9fcuy/dZtY4i3OX40LZgQmgSCyon14IfpAhnxk6Qnbdchk0UypzH3csNwE2c4F9G4zBJzrVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Slhjlqx2; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Slhjlqx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787671568; x=1819207568;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3WtCpNtb0OCw1Ui2duOywgVkhqmB97XF6AVqZhkqrQo=;
  b=Slhjlqx2kL8QJwlVclm1UG1t5o2EoJ0OmLWMbKySXKeaTrDsx6r9Dbwb
   ROJGRhunnvxlfjPxlpKaNcVorjKxZ+hcMHhCFLdvvRTte2bCScgtRhHwo
   q0KRZDkmVHbLzcikn7zeXUGr7mo/z9n9Vpg/CSAObXxMsS35NVD7Ss76b
   dUH9EQlqY4wKgCyNDW6ZCWBAXEabl7/ZHDHv12G4z/Uj3UjSgfvLltZZE
   9EYKMBzEPKYx86HxDsvMXvAz2XODU0tXxRDzCJ/l9z0RHddaU/6FmcfmD
   MIXiI4BqcF8GKnsgEb67OFDOEP6Glg4zrfbCZUEAHaeMD1D74KzHLkiNv
   g==;
X-CSE-ConnectionGUID: U1V3RYVORjqm6qgdDaogpQ==
X-CSE-MsgGUID: FvUjY8VwRkSR73IIcsk9yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="91956254"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="91956254"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 08:26:07 -0700
X-CSE-ConnectionGUID: q4aJLrZhSyiZ8Uf2UqPeCA==
X-CSE-MsgGUID: qXsFd5slRM+uEJjJqwF8+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="266747471"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 08:26:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 08:26:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 08:26:07 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 08:26:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zt5SqUFCqBfewoPgMIFYJzFhhaXtMwe3NvelyCtcBNscQfdA7xB9yTu1t63NKkBsd9kS24OiMIigLQpHrKB2ZsuFM69Wg8zIxhvEkfJ9u/ftBlp5IflIUEdeY4i+kGjRnDzHQK/AxZh7AIIFTkSys68k4GFSmUNwUppeVxtMoypp0MEakFa6uvmuV/NsJCObxrr2pL6KZO+CbbsqTthOZkeFuLCVToqW6D4xVil8caYXEnFtcnyvU9mPyrWukEpB7eKXuy45dgPKdvEisaSlMHOmoFbS+UOtl1mynZ3NERjwUgntV6QxWpzPIDBs6PbhX2B9mUC9eje0T19XhLSN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AZk2F5N7ewh1e+sXU6oHWIqPsSHn84J/H6gSXe9Bbo=;
 b=cdicH6WpTln2uEh/oA962TfApVl/zKH1ckVBgRiRCUFjeFeRKvC7xwGw/wcM3/qMWOlrI75FkB4aXJCZv4mwEXHovQpHAjvBmpzxJHMkZdCrGVpivHDcOBv3Fza8bRxEaf/GjTUTRvMEOzisDz+XK+n3X/0/O0MwDDYTbNtcfJLDlNZqMddeQFO10K4ySEgf7OkdFaBw0cHHFFCxD4xs7EG1PjCmw7F+OPSDKw1Kdl3Q7pjkp0FV2Tvqvpw9aF5YkjJIHvbyEEFnYEk3PngpI1nntcjrEhZga+n2r1Gn9E28Xzu/rO7uDQ5Qq9wGxCWlvR91po63TSQdCrMhIAqAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 15:26:04 +0000
Received: from IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce]) by IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce%7]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 15:26:04 +0000
Date: Tue, 25 Aug 2026 11:25:59 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Raag Jadav <raag.jadav@intel.com>, <dave@stgolabs.net>,
	<jic23@kernel.org>, <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<djbw@kernel.org>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<bhelgaas@google.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<intel-xe@lists.freedesktop.org>, <lukas@wunner.de>, <riana.tauro@intel.com>,
	<michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>
Subject: Re: [PATCH v2 1/2] PCI/AER: Export pcie_aer_is_native() to AER
 namespace
Message-ID: <ao20B1jwAre5A_h0@intel.com>
References: <20260825054312.1319951-1-raag.jadav@intel.com>
 <20260825054312.1319951-2-raag.jadav@intel.com>
 <ao2kIepOqKnJUgVq@intel.com>
 <37843d00-c9c7-439d-830a-33c6fb89f1b3@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <37843d00-c9c7-439d-830a-33c6fb89f1b3@intel.com>
X-ClientProxiedBy: SJ0PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::11) To IA0PR11MB7752.namprd11.prod.outlook.com
 (2603:10b6:208:442::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7752:EE_|SA0PR11MB4767:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a8c42d-a881-425f-b3b6-08df02bd2d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: Ar3st9ox+7aLjnvi6eyrb9g94pe1D8vysvR7bZ3MRdAxg1MqKnq1ObTOCAeCJEAZAv/98mEAhj7oxowt6BPc4X2vXCz8eJs9cAg0yo1pIcLlh33R5hHFeoyWks8Rqzw3KetrcNi2mteB38DrMYhXLolQhgVueiHaCgqtzQ5fLxExGDxNcVRaaIgEJCJs/l14bV8kA9zRPajLrVDf5OOOOvrR5ctE6eLxabYQhzmNfFF7gfsWTho0rKUoxGADTheUYuRVaVvTJ+XmOJx5KDeBfwzQ5gYFSVMZ470ruRqPkZHb9czqJFZiX8sgC77Sse4Y2MYOk4ROBG2r6GsqouS0rwBjRhlTDCO0bcKoI/f7Le/bgXWdEuFVWsu3RUAX21lr2Z5swt8bQdbw1FuUmDRfsYie7Xr37e3a33McGBEIHl/BYIfjD1ILvW4xRKL1RBeyICvX0EFYbly6HhY8SZCHjhGDEIE4hbbBJ2h1nNyBf4COdHT0opAn1ZsAGDQi5f0zKEc1911yEwAca7U5+gQQDC6aNlnuMH40qnFc42MfRUEoZ9HqE+EUzStS2MUH7FPYviXzutyliJCX89ZwO2pPxAerOxRo29Z6G75wk7WHVd68FMCeNBtg8RL/q8r6MXBkfqqUBdKuf+OXIagjWixmYovbsYF3+L9V6k7/2rT8zcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RhJL5AcumB+yc4o8ExBMZHrClXCq4QjdAngfZEPBBxUsAzr+oZHklkov6JT2?=
 =?us-ascii?Q?pzsr3FUm/XO7H3iwb7KEHnHww73VX58kAmY4qTlGi5SFvuNMuvq3RsF3to2Q?=
 =?us-ascii?Q?Xa6o7dQe+u5C9IrlKVAIk6UXe5b1UUbS04bZkTWDqxsl97miVHm4wc94mVdz?=
 =?us-ascii?Q?EqK/2ZbfI3yatJQLba524bkKM79NB85lAR9846tljj/A7S2i72nZ39MjikFr?=
 =?us-ascii?Q?JpT1KBdDHxxQUN0JvgPjytlG8yWDwuJJZ27kyzTCgt/C6VWsMKJnH8p0u68Q?=
 =?us-ascii?Q?5oLdr/DJa/7IehL9PIhbgDBE8lAyYzaVEeqI0CEqU9fUOZ+EzrKegC9U38Ka?=
 =?us-ascii?Q?l8/i5OwuCOCuXY5g2S0KhgG/u6OnxTRiJBbhCsQN9X6t5z64U3RHb9OtbwSI?=
 =?us-ascii?Q?CclpRKtVm+V4jnqAFs+nUg8tAO+DVDa0xnzA1oSl46K63A6lETma8TW/yVC9?=
 =?us-ascii?Q?PT6n/uoEtN/S4vQnGP75FiL9a8tl+VBVSKaBGyPP7ULP1R3zTe7rG9Khzb6M?=
 =?us-ascii?Q?c3nyfuu5zCz1GI3zW1SIG1cnQNWMlGRtYVNzsDHvrzy1VWcxJW6gHBdkC8J/?=
 =?us-ascii?Q?HPTKK+JRl33Zq9DAzyzD60USMYdC/7kE6/nGewUkHNTp6m47+JVZ8/C8rSTE?=
 =?us-ascii?Q?H+rqsDVDHtgvSljqP9kp9nn9DsvwbEs4vB5Ik18gKbNBHplhbxMhypFM6fJR?=
 =?us-ascii?Q?NSHmOO21f7EN0/nfKjdQg7J3xZTS4bjiDM8yW6y4O0wuISDiyYIqVVkWZZAN?=
 =?us-ascii?Q?NohZHXVvPuXF8eaN/hzmc2E0iMlJhU5qF4TeOfxYor8x80FPCbn51Ttp7o7z?=
 =?us-ascii?Q?87okR4jNJ9tgJsCK3z19oYSU+9l31g2cl0cpfLfUgugjr2KdQPAn3lVbpw2y?=
 =?us-ascii?Q?Mv/A0ciAYZtigt0+O5Ocv4yLAWvtLTIIV36GKewTdPclhXH9CmuG4YEsxL2v?=
 =?us-ascii?Q?kr8E9VvtOnmThnbvRtPyCjoYc0DHepi0dTgqiiQmm3DKMp0vGkndT5kybOTc?=
 =?us-ascii?Q?tYuDJR+4530MeF/Ep9COAmA5P/850P8KMvkvQTZSOLQm5srbMy873vp/3/E8?=
 =?us-ascii?Q?0myoGRGp7E4IBp0W11ec0cdI6QDLPMRo89V7M3Cp6G7NH/8hSZbuEYbQ+dNo?=
 =?us-ascii?Q?ArorDLpdiXlc453RFNsufGEvbQPk7pZk544yNV+9mLLmmy4QM+if+T9rdlSM?=
 =?us-ascii?Q?4RpnQVQ+9e4pcnYwndsbLVGoEAf4yqdfS+IaoXLl9PuMow7NyxgMBwAJMO5o?=
 =?us-ascii?Q?oQasK4ASHVppVLY0UFHgbhapDhcv1DhLrkSE0XXmUvrChog0VSKWkax1Hg9E?=
 =?us-ascii?Q?4NWlX+Yvw+3nWugU0m8W3thDVd0HE5QMQ8vfqZgZhOh2lWxyIy0oRAdGlEeM?=
 =?us-ascii?Q?sDYzMcX9bZXAalQtEziLlCwd49R1EIqhATp9R4TSUFeP+On9diQaMUy9Vv+e?=
 =?us-ascii?Q?uHmyYkjvGL7wb9k5wsvL/c5K2y4uUtlTYVticlbtDqHO6dp6QBt0IT/84pjt?=
 =?us-ascii?Q?G/Rh5zFtpmqbHxA4ncTYxk60vDQ2tFq9K5wUtmZ8WhkMywTaNdoWiQ9633X7?=
 =?us-ascii?Q?morf/3tlMO1yVhM07A7mePzZ7qXcJ8q3FEEQoqYJ8tYpqX8DSKxO1LBQ0WYk?=
 =?us-ascii?Q?BxGZKRDS0XUu6ns1ngv7dtXaceQknXXK70ksXSa0aUen2s6/P+AK/sCO2gUy?=
 =?us-ascii?Q?QTKmhJGIv5sFtsDarVYw+5IFT9TAfEhFftYugs6fkWjN5I4rAl/Z47gymlls?=
 =?us-ascii?Q?ug+Dt+d2Tw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 3YksCHNKtY/4/VEGb0O2OgQRrm9Ppyk/7ENaVC5o15bUlc5Zo76dNz1U/+G1eL6/aUsLzM3cae7kU0rCT6arOdWlC5JWfSqFAGsH+WnKhzEyNIQjwuFGkc5HDLMwmcBl3OPsaZbe5ruBAd/iwkubCbG0ktvFFAbSMrRT3m+38CpiNUZY3aUmFT07JkV6nwQNup6WsvLktXV2Tta+fHqhOXluHYW6KF0CchxGPZ+wQQALO2Pc7r9r+V/zS8UkCgXykA+0hc1CJr7IB4T+zclY3n5iz68hw7PATQPA+T7DFX+v+O3ErDUSUc0OIpFR2dV9PbAFPeW7F7QShTHLO68Bmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a8c42d-a881-425f-b3b6-08df02bd2d55
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:26:04.6031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zK30VG6H1Qagi4DQpCSY2u/pb9DjAtZnbIATfuBSV9Q7Sp4c6MjTwR9y4q5x2F2oFRwsX5MF9gBOGD9prnSWRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
X-OriginatorOrg: intel.com

On Tue, Aug 25, 2026 at 08:05:36AM -0700, Dave Jiang wrote:
> 
> 
> On 8/25/26 7:18 AM, Rodrigo Vivi wrote:
> > On Tue, Aug 25, 2026 at 11:12:50AM +0530, Raag Jadav wrote:
> >> pcie_aer_is_native() was originally exported to CXL namespace in commit
> >> 49f776724e64 ("PCI/AER: Export pcie_aer_is_native()"). This is a bit
> >> misleading as the symbol or its underlying implementation does not reflect
> >> any distinguishable CXL functionality.
> >>
> >> Change this and export pcie_aer_is_native() to AER namespace, which is
> >> cleaner and more suitable for its implementation.
> >>
> >> Suggested-by: Lukas Wunner <lukas@wunner.de>
> >> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> >> ---
> >>  drivers/cxl/port.c     | 1 +
> >>  drivers/pci/pcie/aer.c | 2 +-
> > 
> > PCI and CXL folks, ack to get this through drm-next branches towards 7.4?
> > Or any of you wanting to pull this through your trees for 7.3-rc1?
> 
> It's not really a fix and with no fixes tag. Also it's not a bug that popped up in the 7.3 merge window. It'll have to be 7.4. I can pull it through CXL when all the appropriate tags show up or you can take it through DRM. Probably more reasonable for the DRM tree given the second patch is what needs the change. Just make it clear to the maintainers how you want to do this.

Since it is 7.4 anyway I prefer to take already with drm-next.

CLX and PCI maintainers, ack on that?

> 
> DJ
> 
> > 
> > Thanks,
> > Rodrigo.
> > 
> > btw:
> > 
> > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > 
> >>  2 files changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> >> index 99cf77b6b699..00f675163b3d 100644
> >> --- a/drivers/cxl/port.c
> >> +++ b/drivers/cxl/port.c
> >> @@ -340,5 +340,6 @@ module_exit(cxl_port_exit);
> >>  
> >>  MODULE_DESCRIPTION("CXL: Port enumeration and services");
> >>  MODULE_LICENSE("GPL v2");
> >> +MODULE_IMPORT_NS("AER");
> >>  MODULE_IMPORT_NS("CXL");
> >>  MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> index c4fd9c0b2a54..8660b18bac8b 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -248,7 +248,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
> >>  
> >>  	return pcie_ports_native || host->native_aer;
> >>  }
> >> -EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
> >> +EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "AER");
> >>  
> >>  static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
> >>  {
> >> -- 
> >> 2.43.0
> >>
> 
