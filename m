Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085C367B74;
	Tue,  4 Aug 2026 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809600; cv=fail; b=bmI+AyYmwC2vtWVJ3rTFeLG5bbtMmtjI2jBoLuYxTIP7GuNrtRnT3rylskAFx439rvUrnk0bEErRwiNTT9edcDBCq3xiw5cjfWv2EUC7CykoMaBbtZwwwV48zUvdy1WWsQBcqm8aIRZsnp2BdMQaIwT5NFli+BpGbKyBkOtCq/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809600; c=relaxed/simple;
	bh=e7S148RlOGmKm0bS9F8vuTlzXLwJJU/xhlriq3U1rcI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MWAeUgb9oM2kPI/4+dKbILu2DsG6KQ2o4vbFuoTKp7CvWWx9vpyhOqYq9H+/uMqeMP/rW3+NYK4pWV4oXFxv+kcU4ySSuPMI/8h5vvR6F7N2l+Xt91heg8sjUws82QZu7wjVwor4j7/a9hNI8+Bx6mVR2Eohp6Dni+yHvnyjRAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+qcOaTz; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+qcOaTz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785809597; x=1817345597;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e7S148RlOGmKm0bS9F8vuTlzXLwJJU/xhlriq3U1rcI=;
  b=E+qcOaTzhMqoZERupY0heKTFn8Q75IWkeldBOuwKfBU2IuzWmVO8Cabq
   HSmKiPQlcdtG+FboGk+FLXS1UQbtgTmGrjSCh1vK6y1e2zwl1mlpd4opm
   RahowtZ1uIV2OVINNTTn118e7FVtJZSav7gEe2loz1AHHX2nyGgofyC1w
   0FwYvm/jfay7sN9+vo5bIgaqgSFM0ISum+1VFKp8Jj9YJGtWpGyjIPbGY
   tWJb14SZOCfjlQUmpo8pZbXm/srcbmXgxus7f8mYHrgZol0/ZOuJC9jBH
   /skbTeCXqajOInpwUuKXtnwJmYychAgrIxiyiagmUnkRw5FG10IND3xII
   A==;
X-CSE-ConnectionGUID: u20bgZ6nQxSX5XELGUV4qw==
X-CSE-MsgGUID: Pdal1Ts6Q4epkgcNjybhaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86385629"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86385629"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:13:15 -0700
X-CSE-ConnectionGUID: vptGEjKUTsqSSryM/DUXTA==
X-CSE-MsgGUID: HK9Pux2sRTG4wb24hseAfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="255087786"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:13:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:13:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 19:13:15 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:13:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZnyoU/w5PYupyv26LeFMPgTlIHp7r7YK5l/4c79cQAwFaMIK36AV/J6t5jnaJTthyHe4EVlu92W3GBhH9xx4Px3xgl0pZOU9tWTebVwAMyJrAv6y0PwCxkN88hUtqvozTS3OdqTmahfEi6U5tdCmpyqmy/dY1obukMXjEK+cSYQrBVDz2E01M1xWbsUp6Rz/eFNa3nFQEvwIH1MEGDChF9sg1AJk7Ll2hc3KqNubyYN6bFY5b4tuzCTqDh7mJok7G9EWnf2zwUqOoOnWiwZ/BUTXoSmyhva/k6Budyyq17F3+YYK5rQNhqUdbLLkHdpaaUFRJzsnzc115qnyMk3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fODUHYSS4kWNL1x5YcWgOiXdV/WLiFcIO96T353lOSQ=;
 b=LApQvnlHEyuwx4H3WQ1sQLMyV/7TBMNMqViWvBHYwRBvcYowEnsd7t072qMysjHO44DuteyYOG0gfQfhR/uuvRkIEm9kxats3+NyRL4lKifG/66ngpqE50rk9BxP1ZbI+xQYtEM1vNLDmOr3Q1OsgODK5STlcDJNuIpFO+H3gN2EH+55u6uuQO5Cg4o2ZVTBaplxd0xaFU4tar3djfEN+8KHrwfonp6lTZ1A9kJ3ZHyk+QlZmJF90w0gEXvnaCyfkZ/RG+egXtam9QLJex8PBSMuZEoH7QpRIC/41btxhgaKP+Z3VAywF76DjfpY9JlqLPj+sQJ1VC6ajvR8d0ydfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CYXPR11MB8731.namprd11.prod.outlook.com (2603:10b6:930:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 02:13:12 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 02:13:12 +0000
Date: Mon, 3 Aug 2026 19:13:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown
	<lenb@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Shuah Khan <skhan@linuxfoundation.org>, Ben Cheatham
	<Benjamin.Cheatham@amd.com>, Richard Cheng <icheng@nvidia.com>, "Robert
 Richter" <rrichter@amd.com>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v19 04/14] cxl: Tighten CPER kfifo registration API and
 symbol visibility
Message-ID: <anFKs3_MmMAZ1vSg@aschofie-mobl2.lan>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-5-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-5-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::7) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CYXPR11MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d34563-55d2-44a4-26ce-08def1cdef97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|3023799007|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 4bxd+i+La2J8Gxwxfo8CYJWVRt0+vElZkA0lnZ/NlPZ18R/3YgP/eM/gN9kJv4xa26gDPL2kw7XuFqMQwCuRGF7vgaVBIXmRq5hEia9jqjIXXKy2A6AX8+7F5UFy/JOpX8Z9Hzdsn3/BYxEs31CVEDb5ydlng32oqssBTSXiNsMYCb2vIpNjDDyw5wOF5vuHt/1MZLimLIP6pEUY4eEkShsdYrJU25IGgzG+JhCfsaZ4xH2a8VYr6iWdSDcLWsfpcGTVhRqsXBBseGEZuKtitNTOD5MxYsQQFSEpvVXqfUVSctOmMwLPqghs4fPH/10LYV9hIdF4KBbrBKoFb1P10YpmxxcSIlhfqdAW36bG46XT1wHCG+s/6kz/1SpR1qdp3BkgsYo4WGK+ivzp5ZtzWUehx+VpAxXXfujkVMKYCre4DnHUc6+7OsWWMy6IbHD+e1SDMwxJR7oiRBddEA28C50f79LlghoEMNVEiPet/tv7GAVpUiT9ld/A3NDToIM0o6ZkwwJImww5HHN1I/ra6OLG5+23haBffau7J0pWx8Wcz5BTCOKgwcAejpkQrvnYhfqWKVY10X7aA9dU4UQPetg/g/X55JqDsYTQbognCwX/Wly8bJwC6Pf2BQ6nctZKFkH7mKLrYqb4yliDOY3zUbvxp8vJJfW3cNFTq4/LPSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ohi/MWO3t6H9H7UKNe4F1G9RyDHwRTuxeZ3qgtmh06K4xD//F+YakQ1v+gfT?=
 =?us-ascii?Q?hB68w+D4ar1ll7LUvXDRuCkSTE1VMiCqt7uVuNSo2DNeXYpHpVgqprkfqq33?=
 =?us-ascii?Q?MtMEJepjQAUp+seU92x7GmrhCsn6KVad10QTCze6LzEdHTsh9VKQ8YOb1YhN?=
 =?us-ascii?Q?zb0CdrIatRT1mbZ2doFJaCLJioDoEDAi51cHyXEojfXgLeynwbdi02RfKeJB?=
 =?us-ascii?Q?Et7PiQsKHB8RQ0rdSAWM42N5B3hzJChNBzWh7XxRFohZ4bDjerzbb9dwjfqS?=
 =?us-ascii?Q?XAcgv9jF7O33ETOTwraYXweXIlk0wM7fW71tZpTMHSdqEduCZK0tfcPTICJi?=
 =?us-ascii?Q?bGIeOa1t/hIW8o1oW1XmbyRR4r+VKzB7hRHtjX4h0PZCedI18WIJf6ARot1A?=
 =?us-ascii?Q?Vu3qAmt3LcSecYn8RDU9uYeEIBmYEhSHqTH3nx/n02EOCqIrdDtLwyaGDAm9?=
 =?us-ascii?Q?Juw0qgtXmZXCUaVM8RcA+yoX9nbgyZw8xdZp5vMJNf2VNI4KokOCPebtBU0s?=
 =?us-ascii?Q?EasZccP7iSD+mvAqMjbCpNi97jE/fLscHEd3ShzZuIuVvkKQxORGYsLUFOIp?=
 =?us-ascii?Q?qkApnZtZelUP44OHIr5FGQQE0cxOIarHPQV8YXToUXsDg39muMcPCvnFH82y?=
 =?us-ascii?Q?G6QYc+bPMw/xQuLfsEAdVR7P/vX1t4zXY3AkhoAL7d6M0LUTPF0EeiXSAbLF?=
 =?us-ascii?Q?R69pkhnuvbPKaheDpwidxz8umNZQ06H5yZWx7OE/ncRb3w5sENZu+RGondGV?=
 =?us-ascii?Q?ONmYcS2/qCIm8ikvzLszQ81oAgUYaREGqb+dOES+mVw0AHdzKQ0GIS/tvHJK?=
 =?us-ascii?Q?Cvsklf0BGM4oeUa1RfrFk0N6LKfq2FciPkPfcE5y1Jw5XvhdKAf5tP1cq85y?=
 =?us-ascii?Q?DCU+A8wwZfC0EM6DkzvLtm7drK+3QCiVDoHvMfGXSA+0keQnHbOLphYYNFJZ?=
 =?us-ascii?Q?eqN/sLe6MIlDpe2qObiskh7OP3H8bX5j3FrWux5Ok8HYz8u1mw7E9rs9IQ4H?=
 =?us-ascii?Q?ILVuLEnmKjAW5gmWq+nRKf87PeSNTyqbkEEoYJyl9iSPSV8/tac/bhKuD94K?=
 =?us-ascii?Q?1Z2uiY/eJh1B8ScIoAJweT1bwJ8AQjp/3FQZ26Ei9zQX+0J+PBfR9MGC8E6a?=
 =?us-ascii?Q?GGzpKKZId3ixuh3wDUuL9mqacKSWtFEsUB1UdN5cd3PXkR9S8qbgpZLNzyuM?=
 =?us-ascii?Q?91nRx/x5FqMV4JxOdVyXRoi412V7ffKkKvfNuT0owrETr1qz8upSCu9R5eNk?=
 =?us-ascii?Q?ZfNAimJorTOgpVKhV3d8vSfxYWHhk6AQXuXe97/K6Jgg7pE/1auokO7cstLL?=
 =?us-ascii?Q?KWz35b4/NwglE5AECoMSykIYWU6kEP2AbA+WhDnZsqOOuZGsqisUSWbXRMKm?=
 =?us-ascii?Q?K2gUH4MUXoH+1sRaKHk3ZS/k2mMSLPOWmyaVgRN8nPpu3U6NLdtrE2cWWaN9?=
 =?us-ascii?Q?Jx1gjVmmFnWBq9xNBjVJsxL5W50AXjj60248EsSmt6IKBWsha1MH+6KPn/j4?=
 =?us-ascii?Q?3UuFxrpCgCrQv7hM8bxBk2Ql+kv//y7fM2X896+s10LkM5linFFPs/ZScE41?=
 =?us-ascii?Q?VU/AH/NJllYxzkduzf5UjlvJcT8I29leiw9GVK0XXoGPRqyD9sGrQaJWlIzo?=
 =?us-ascii?Q?IHcUYd/RxtUmMOGlIpTx6+Qj2V0GqeCQ8D7zlVkRjR6CSS928Apy7L8CGOgI?=
 =?us-ascii?Q?8CgnqsF8tvaoOuqGZpd8P+T+FS/SgUK1uagUS5V2C80eLxuIH149upX7av5k?=
 =?us-ascii?Q?wLD21NBlyMXJqqFNbQvqr9vJoxpJLpk=3D?=
X-Exchange-RoutingPolicyChecked: Wf0dDpDrJl4M25/95dU1BP6CYixKDkpEf/USD1NnYx7oxsmF67of6PNJW42pWjbg0jVsKQbUau4DU75NC1fYaEidghSyq311QAG0uMsWSgBDUPhNIwhO23BbjRfI8oVj+MRxjsqjH0skzdakNSfhez9i77mOrC/fJ+hb142/NqrjZR+FJKnVsOzibd+Uzjd0fpHPQY/jr0CaBF1xE0V+HPZAOYWodSRlgNNaJSF9TWTtoDKVkhJy5lwL/D36qUdyMYiZws6Ydt4N14fzE4X8E69QZRfVWLQPg6zbmlMC6+cX1fWgS4zn6IvpnFrbBiIuoaFXTIGOqRLsWq66t1cvjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d34563-55d2-44a4-26ce-08def1cdef97
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:13:12.4903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pw/gsf6Xzxwgmm3rjaI/9gmpkyJTwlJR6640SlcbngxzEDr72ARpI6g3eRUXerc6+E5ktG5bX8Q1hHi1UwlfSXAyCIlz5lEP8wvitLvCwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8731
X-OriginatorOrg: intel.com

On Mon, Aug 03, 2026 at 05:18:00PM -0500, Terry Bowman wrote:
> From: Dan Williams <djbw@kernel.org>
> 
> Tighten the CPER protocol error kfifo registration API and symbol
> visibility.
> 
> Use EXPORT_SYMBOL_FOR_MODULES() instead of EXPORT_SYMBOL_NS_GPL() for
> the CPER kfifo registration symbols. This names the consuming module
> explicitly and gives compile-time enforcement.
> 
> Drop the work_struct argument from the unregister path. Change the
> WARN_ONCE condition to a NULL check since there is no caller pointer
> to compare against anymore.
> 
> Return void from the registration helpers whose result callers ignore.
> cxl_cper_register_work() keeps its int return as the only one consumed by
> a caller. Flag double registration with WARN_ONCE() inside the lock
> instead of returning an error.
> 
> Change cxl_ras_init() to void because there is one consumer and one
> producer so the error return was unnecessary. Remove the now-dead error
> check in cxl_core_init().

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
