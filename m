Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C273394476;
	Fri, 23 Jan 2026 05:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769144887; cv=fail; b=TUWInAcel0tLm7Qh3uiyK6/yuuxlpHi+8GILSp0al8yu50PracIHnsGfGtMMWIqMG/Mpi0IctxJZ7fpiZ2aCyK97h3ko0bOQYPpnZIXAJkl0mf+r2GzgoI2X2QR/cWC19mTAnWFRZyTcxER6gKl3BK5c5ObxwX8TgJjndnGNm68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769144887; c=relaxed/simple;
	bh=X/Z3P0qtVWvkyaRqLf2cTMDtmqB9FOAX+9Sw7P7LTbc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ihztaeGwNgPUrIsRCXT3Qb7o1KMQItzxSDJd8VI+uH1ZGGsHMzk2PR70VdpKy8T+AFNTeuNp4s4Te1VzdiMXAUPCKTc8K1c+X6JXYl6rPyYNRjgRF3EqYZtEJrGDPiQEd9TKi9VqvfSsraiTzuq/tIEzm9O4zhKDW17TBD7Y17w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnClvWBd; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnClvWBd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769144884; x=1800680884;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=X/Z3P0qtVWvkyaRqLf2cTMDtmqB9FOAX+9Sw7P7LTbc=;
  b=YnClvWBdkUDmP2BUlT9lWFv72CdHXsmhhohAa9/e2Dyr8KFWamaw8E78
   cGyrpzgp3k/UYFJVYcT2Igj5Ta9Pjb3+A9kGppL+J167QjUBQnvmMGFEs
   mRRBwgNZt+g7rq/s8UDHjBjliMMC7sfLiaiAG5wcEMpNxrntI0f6MkgWh
   zMN1KU1cQh3LL5fnjIOTyJKHJMce+IiJCeBbBwXhB5iqs/ybAc74lx7Nn
   DeTpqGL208CMGX7oAjA9HhhA2d2kaxF3HymfjxUp2oEeXz1FEq+efS8ZS
   r1Aui9FaIUhFvySkVV+0OibH7loBXuwX1r3DiCQK+euxgrvRhyWilugXK
   A==;
X-CSE-ConnectionGUID: Vya0w8JZTGm8mvWiFEpAog==
X-CSE-MsgGUID: uE1W/SmtRO6PFgKh+/dksw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70370565"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="70370565"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 21:08:00 -0800
X-CSE-ConnectionGUID: l3cAYn0FSZ+AT8i4kRRCag==
X-CSE-MsgGUID: bQxuC7tiQY6qZGQgk1Dn8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="207273306"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 21:08:00 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 21:07:58 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 21:07:58 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 21:07:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFk3le0GTRDMnYUNHnjGHMUl0eMGRenUNPvcUIhwPVNmmQy8BMlDUuYcd/xxwrPakAYQ9sskvS2vp433YdMykMf8UF7ZSoWDFywAB4aEyBZ3uSaMcApn+NCV7G+t3q3dJy7/VH+DW48VmOY1ChI73eGNgvSw5nfjXKCF7lWwcd4P0RP1/j2WShfkj0no9O1Zx+6H/+Kxjxn5zRx52mXOvW8KaXVL/scJqC3p2NqXv4IjgBjQt2izFcw7yqm6R7LXH+eQYx8xvdUuNyVJUn4oR2aFazFcxo49g7aP7KrIUJKQA3MLgThvsdJ/hAIZT6MetUq/Vd5wXd/tqClaC6stzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfhylHGvfV0s+sB0yB5ggwuMk41dshRKBA6pxcLR404=;
 b=WMwiLS9QgkY47H7yOYqi34DoqVqPWM1AdDVGOwmtXs3MS1xT2AMXxei9BWzr7XfSdW8pZtBvBbE4YHzTu9XIt/zf0aWc/poPI4/6gzYobEp9cIT9j2MWDzr0eNgiOJaiDgITZA1Uu6uvKdXU68XfG++oZ04maomWt1VlNj+zo7y+qrq/8Un7T0/PqL6tJxJn2mSsXhXKlg+G5NTxYUvqfFvCs8lb0g7D9TIWXwEobk6aixr/bAyByfuWyUhRG1bdLMrHjH9XRRgLTcsPUPuIQGKrXbdDsJBy6t15VefVTRDhV3YzjYoCNaMZ7AfL0TXejI6hu8zS+PKN3/QaU2G+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6173.namprd11.prod.outlook.com (2603:10b6:8:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 05:07:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 05:07:51 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 21:07:49 -0800
To: Xu Yilun <yilun.xu@linux.intel.com>, <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<yilun.xu@intel.com>, <baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<linux-kernel@vger.kernel.org>, <yi1.lai@intel.com>, <helgaas@kernel.org>
Message-ID: <6973022580c68_309510049@dwillia2-mobl4.notmuch>
In-Reply-To: <aXLtILY85oMU5qlb@yilunxu-OptiPlex-7050>
References: <20260105093516.2645397-1-yilun.xu@linux.intel.com>
 <6972c872acbb9_1d3310035@dwillia2-mobl4.notmuch>
 <6972c9b522ef_1d3310053@dwillia2-mobl4.notmuch>
 <aXLtILY85oMU5qlb@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH v2] PCI/IDE: Fix duplicate stream symlink names for TSM
 class devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0155.namprd05.prod.outlook.com
 (2603:10b6:a03:339::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df30a0a-558a-4325-3977-08de5a3d5b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akY5bHFxeU5iNUN3cGNVK2poQ2N0eEpTM1NLbTRVSDJJdzNQazgyWTBLejNu?=
 =?utf-8?B?Uy93VlNSTU5JdkV3dzVKVldDZ3VYWkxsaTlmS0JWUUMyQ1dpelB0M0lRa2lW?=
 =?utf-8?B?eFkydjZSR0JIejJZQ2xGVHpUWFl5MWZibnM3Q3g2eWJ5QzgrSHR1akVUYjRG?=
 =?utf-8?B?NmlvVlVTcnFYTkRMWjM0R0R2YmpGNUlIWUF3VDFZMXhsaUh2dWNDTDJZQTZR?=
 =?utf-8?B?MGgxdFZ2MHVzNFBWMzNjVTE3UHVMUW1kL09mZktWSnpYMVlIK2lXWGF4TGkv?=
 =?utf-8?B?THRPSEFKaDhOR1J1cUdsLzVZWHpCWCtMMVVjaTZQUWg2UkdEajZvTzlOajdP?=
 =?utf-8?B?K0pkaHR5dEpVMTFHSmYyZTNNTlNKYXpVeHlJYnhFQW8xM0FTYlRKd3ZlMHEx?=
 =?utf-8?B?UE5IRGlLbjhnMTVtSE1BaVF5NHZPM1phektlSnZYUzBBSW52UmFGMFloSXgr?=
 =?utf-8?B?cEFBSDQ2dVZ3NmVPek1IOExjMm1IUGRGSUtUN09XNW5hUlA0OFN5eFIwRlB1?=
 =?utf-8?B?LzBLTHJUSG1GR2JhUStxd1JxZkFqTmNnRkg5aDQ0bEVmZXdTZFlYNmdPUW1G?=
 =?utf-8?B?ZzdJUXRjOVdnbG9pcTRiSm85cU5JQzRPMFBRYmRiRWZveXNZRWpabVpTUURy?=
 =?utf-8?B?WjZUd2w3UGU2ZGV5bnRORWNVNHBpbllYWSt4WDc5bi96akRZNlZmYk5LenJB?=
 =?utf-8?B?VTRhcjRHVkJTQzJJRVI3RU9LVFZhanExdi9PRGd4S3FWUXVvbDYzOFJCbkQz?=
 =?utf-8?B?cGZLSW1HdDZxdkNTK3JtZ3h2c0Z6R1VqQjVuWkxNcVZqb0xyeTNsWTRFYmtl?=
 =?utf-8?B?UmNpd2piNnFFV210aHRYVmJNY3NNTkVKTGJ2aWpxNnk4TGtMQXN3ZDNBbXpD?=
 =?utf-8?B?VVNwSUFaTlhFTXhRK2trUGFXT2tRQ3FFNHNVV1hIQ01ueDI5d3l1bzFnOG9k?=
 =?utf-8?B?RGwwZ29ZcHZUWDA4Z3VSMmU4enppc2hOL2FRQjR6bnlPd1N3QytpRUYvRkh0?=
 =?utf-8?B?bHNHT2xLY0FpUTV0bnhYUDVmQnB4bkZNZWhNMGsxRlJCRkwreXhVckpzd0hF?=
 =?utf-8?B?RGIzRFFmSFkxU0ZpM1J6L0JJZnZvdVoyaWxpVmJxQ3ZKTHY3U1MxcFpDT2Zt?=
 =?utf-8?B?R2lMWVhXNDJnbTNDOEw5T1EyS2NYRGl6bkhYaUdmRzBIdkJ1SnNObmRTS0Vs?=
 =?utf-8?B?WEUyYTliSWFhVXdmUngzOG9wTHFMNWY3ZTc0UHpBUWdwNCt5clR4QjQ0SDlJ?=
 =?utf-8?B?emNURmN3Qi9zaG5DejA1TEkvSzRTY3N0ZHFUV3lUMHRGVkgvK2R2d0FmMGpM?=
 =?utf-8?B?UEtsUnJkSFBycEJvTGZWQzhnSlFiVU9MY2RyUVpoeE1xTjZxb0I5Z3Fqb2V4?=
 =?utf-8?B?WWFwQ2FieHp3QjVBMUZOc0tMN0xWVDlqbC9xbmNBcmt2dHE3Wm02SG9wYUlT?=
 =?utf-8?B?R0d5ZHBET0FUcGNPS0Y0SjZtV3o4UTZZNTFyNm9SVExTRzhwMFluWTNMTkpY?=
 =?utf-8?B?ZTdJU0QvWlQydmxRSURLeTc5TEE1cTRVYzBBWjhSMGZ2UzFzWkxnU0NOTm9P?=
 =?utf-8?B?VndOY2NIZEx4NmIrRy9hOEZTMyswdHltTDhjK2tYS1JPd3FUNjl4Q0VXWTRp?=
 =?utf-8?B?NWVaN3h1RVA0ZWRrREx5VXhqc0Q5VlVYSXc2Z2NQN0c4MzlrOERwNHRPU0tG?=
 =?utf-8?B?K1pDeGNqYmVyZG9DZ05Fdnl2MGpqWGZJdXpLaFRvckZxY2NTV2dPQ2J6dWc4?=
 =?utf-8?B?eWc0SUpZcCt6azZUcUU2R1IvTmxNZmtzS2NCSUFNUThnc0s4eWlZOCsrMllO?=
 =?utf-8?B?Vmloa09GMGZLYTBHZTVlZGlUNy90ZkM0eGppcFdNV0FLZk91NTZYTXc4eHB1?=
 =?utf-8?B?dUp0dVRUYkVSSnNUNytXdlJrdlpXRUo2NmxRa3hPYTJxNFpHRlQ0U250N0lu?=
 =?utf-8?B?ZUdreWlyeU5TbU41MUQ0MW1Ud3l5alJUMWNhbjlPSllNOWlaaVIwMldSS2xF?=
 =?utf-8?B?QlZYU1VPaGFKY1RWR25ROWpsai9GdlNxcGh0NW5MOGllVGcxc1VXd0F5VVpL?=
 =?utf-8?B?UUlPeWQ3Q29EQWJpcFFRYUJTVk5nSkQ4eUtscWc0dCswRldGa1B1TUg4R1pz?=
 =?utf-8?Q?dKHs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elAySjNnTEM1TXVkUXNHb00weWRlWXFaS1o1b2VoeDduVWRQYk9zN3VqbU5Y?=
 =?utf-8?B?OHYzR21NSVk2M3lneWpMNmh3aFRyVTRaTi9MSW9vMVNQNXo2b1Y3Y29Zb1Ru?=
 =?utf-8?B?eDhSTGFVWWhEVjJ1Y1VhdzJ2T3U2a1hmMGtSZmloZll3L1ZGMVl3NXlZdGtK?=
 =?utf-8?B?R002ZmIrcEhvQ0FLYTJpcW81UGtKQzFqSmExUVErajFwZ2l2WEJESnA0S0FT?=
 =?utf-8?B?MWgxbk9uNEt4U0luUVYraE5iV1dNMnVFMVBxZkFPS2N1WnMxWVgxRVpxekM3?=
 =?utf-8?B?blFnNjJoa0lON1hSQ1pPU0dtcy9SamZDdmtHVGhnQy9iV3hkMGxNenBRc1pJ?=
 =?utf-8?B?V2dwVjBiYW8wUDMxOWJXaVk2VUVxYzFGZnFibXVJQy9KWllDRGRldXZ0WnFl?=
 =?utf-8?B?Z28zTkE0am04WWZFUUE2SXFUT2UvUCtyWWJ3VGU5aVJLalM1QmF3cFNVSTZK?=
 =?utf-8?B?dTBrS0ZkQnlKVFhIakFGTjlXUWVTM3pYRGorMEEvWEpySUNkWWRVaGJ2MFBB?=
 =?utf-8?B?QVRmMGc3dm5VRDVFQlc0czY0ODJRanFQTVBnVms1cUF0ZHZHRUtQYkkwRXdr?=
 =?utf-8?B?RGt0K2NSM2FRMDY0U0RjQTltZXZZV3k0WUpLeUxKdnZjQmtGSG9IMVF1V3dQ?=
 =?utf-8?B?Z0daWWNuWFJhUzdaVE9wM0JrYTR5ZkFUa2RLWCtMZ1YwN0F0UkhwbmpQZURI?=
 =?utf-8?B?YnRvNkEzbEd2ZzNBN1N5dG1pT2hPWTFmVFpqSEhtY1IxM2Y5aUtONjhmRlJH?=
 =?utf-8?B?bzlDTEZJVWpxTDFkL2NLTElKeHZhcEE4clR1VzduL3pWRFNRTUJSZzhlMTBB?=
 =?utf-8?B?QitKQWMrS25WNzVKQXBxUUtNMmRNNFdVMkRNa3JvSTc2M0pTbFlWYVhUWU1R?=
 =?utf-8?B?K3Y1eWZXQTNYWThBSyt6RlVxdTJxZUtoUzhIT2UzRXo1WE9vbVVmLzh0Zk9I?=
 =?utf-8?B?QmdDR3hlbFUvMDZ3UFplOURoKzg4RTN0WTN4ZU9BNVpDRjlpdFFjUU5ocWw1?=
 =?utf-8?B?dlpYZU1VaWZNbldMcUpQRW9tMkEwNjJVeHFoekdSVEtBY3BrTTNhcU15eWxG?=
 =?utf-8?B?YnVwUTdRVThIbDdNLzIySGRGM1NQMHJtWFJKbWUzNWZCUDBPb2g1Z3dISjBr?=
 =?utf-8?B?NFk3b25CUjUyQ1dwZGpZYUZBdURySGxYWjkwOWF2dE1zZEs1eDZPWmZueDND?=
 =?utf-8?B?WitrQlozemczWkZQQU1yekxidGhIT2k3ZVpVeUpZbU5uVDhzRy9WRnFWY0dK?=
 =?utf-8?B?WGNpc3JDVHlkZzQ1bXhzTVgwYU5mTFIvc0UrT254Z2FBd0k4b2pSTGhIS29I?=
 =?utf-8?B?RE8rTXRYTmtHRldwWTIvWVVzL1M0WmtWTEJpdHZhWjloQmNKVnFQK1Z2RUI5?=
 =?utf-8?B?TUJETE9HM3BTekk2SlZLdTE5eDhlZUtTVFpzbHYyMDB2d0hzRlljQ2ZkSXl1?=
 =?utf-8?B?eDNvcUdoVmlucDdDYWNodjUwdE4wQW54TTAxZVNsamx4SStiU0pDdnBxRlBV?=
 =?utf-8?B?SWYxUStVZWVHdC9MeG1saVhhUkxmYWl5dXBkRE9lR2N6Y0J3MnRjWi8vZXJu?=
 =?utf-8?B?bUNGdXRKQTRVcGhHMDcxTnVRaFYxRzE2MHpnR3JKZ0E0N0xGNEdXUERpWjZv?=
 =?utf-8?B?cVN4d24yZGxEUUROUjA1bFNjNmZPVi9mZmdXVG9Ma2puQUxGRk1EK1J4ZjAz?=
 =?utf-8?B?VGl4bElkS3ZRUXBac2ZMK1Bnd3VncHcxeXR3Wmd6VWxTTUR1WE9QakVmRjRN?=
 =?utf-8?B?Rmg3Q1dXc3ArVEhrdnNXbE8xbGhkRld3bXFDdXQ0SUNGT082aWJ1VFhSMkZS?=
 =?utf-8?B?TmVoSlpNWjU3UVlkMnJpV2FENkJNWEtYcSthUHlndTVaN09Xb0NiWkRyQ0RO?=
 =?utf-8?B?dEUyMU5TMWN3a0JEcWU0ZW1pTnkxeU1ZZXVvQXlkYW5wWC9xakVyaXBRTEJT?=
 =?utf-8?B?ZWFGOVFjcUJYYXV4S0M5UnhENFl5TUgyT2FYTDdPaXVLclJvaHhUR2M3VnJz?=
 =?utf-8?B?SUdRaTlCdzdvV0hhUjE3SHVweE1LUUpRQlF6a2N3UGx6SlFXU0JVNkVySXJ3?=
 =?utf-8?B?bXpKYzBzeHE5MEpkdHBMdGRUN2VHSGJDYjBnVm1YdDNKdjdVVjZqUzFkVXdk?=
 =?utf-8?B?UlJUa01HTCttNDdTN2piVHp6ZkIvb1daMHEwWmd2RlB2aUg1ZDY4RHRtOWZB?=
 =?utf-8?B?dTBhLzYxZTBsQWJkY09FOWxqbmFvOHYyRk1lNDMzRFQrU3V1MVBIcnRJOURK?=
 =?utf-8?B?Y3J6N21JNFdLdDlQZDB0RFBXdXNiZzhRWExDNDg3NFIrc1J6L3hsVklQYXN5?=
 =?utf-8?B?dTZ2RWFCVUE1R25oSmUvQ2hiOEVUaW1FZ2RnRkZ6ckNWeHhEZ2JxNm5SSGtq?=
 =?utf-8?Q?9RJ+0q+W8570Kyyw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df30a0a-558a-4325-3977-08de5a3d5b97
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 05:07:51.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dICrbFvMaw1OmzFZhatw77CZvhAfsDLMKkJCRNANfCVw5BHYFqXRUuigcmVnSF80ZDbGwxUeTyfcl7rjNm15WV1XF6zkc5y/p37NbZ7t6LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6173
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> On Thu, Jan 22, 2026 at 05:07:01PM -0800, dan.j.williams@intel.com wrote:
> > dan.j.williams@ wrote:
> > [..]
> > > However, after seeing Jonathan's feedback and noticing that he missed
> > > that 'H' 'R' and 'E' are documented in the host bridge ABI I think it
> > > would be better to simplify this to just a link back to the host bridge.
> > > 
> > >     /sys/class/tsm/tsmN/pciDDDD:BB => /sys/devices/pciDDDD:BB
> > > 
> > > That achieves the same result and is easier to document as "When a TSM
> > > has a established any IDE stream it links to the host bridge. When the
> > > last stream is removed the link is removed." It achieves the goal of
> > > letting an admin do "ls /sys/class/tsm/tsmN/*/stream*" to get a survey
> > > of all consumed stream resources in the system.
> > 
> > In fact it does not even need to be dynamic. At tsm_register() time when
> > @pci_ops is provided, link all host bridges. Unlink them at unregister
> 
> I'm sort of supporting dynamic. My DUT has 40 host bridges registered,
> most of them has nothing to do with TSM/IDE, so I'm afraid if it is
> overkill to list them all, and bury the real TSM capable bridge in the
> noise.
> 
> And if TSM always list all bridges then why we need these symlinks, we
> can just:
> 
>   ls -d /sys/devices/pci*\:*/stream*
> 
> 
> I assume the annoying part of dynamic is we need to refcount, which IMHO
> unnecessarily complex and you are trying to avoid, is it?

I am ok with a simple xarray of registered host bridges that gets
cleaned up when the last stream leaves.

The end goal is "ls /sys/class/tsm/tsmN/*/stream*" gives valuable signal to
the user, and yes 40 host bridges of noise should be avoided.
