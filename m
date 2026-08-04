Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5739FCC8;
	Tue,  4 Aug 2026 02:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809530; cv=fail; b=YcQdywtjNHMHYX0QgPOSijZ0/dSu72qpXAh5QBOJNJoM4rCEusBDQCHTnoDwTDVUkJmwHc+BcwhTK/QoSAI7yC3n+6MQg3o8q7FlmMOhJy2/SCrNixtzXD5I5x+4o/vVE3t1nKiBiC+K+EU8aUL5MZb70uIZ/kKecXfhhzNPGtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809530; c=relaxed/simple;
	bh=j9nKAJjFQIGr/PtRUhlQRPcGUmeCrxpW7MSoTY2rQaI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VkPL6ex6kc/WzTHTk2cLN+MjTEADKWf4sc56YjFYFgcIxsw67CkEl8VpCxd0JmFDR2c8bXCHmLrAAiPUwCNwTZmDrsIvt2Uhg8Clq2/VWEQegZHrJdHWDh9Tbw6kUZ4ipm43LD2L8IYPg7CipDJhVu3B28UCoPwFfJ5ETeGe0UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNB+RPM3; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNB+RPM3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785809527; x=1817345527;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=j9nKAJjFQIGr/PtRUhlQRPcGUmeCrxpW7MSoTY2rQaI=;
  b=HNB+RPM3ac65Q3EZ1cprt25RNjlmVceYifkMXBckmcFuG3DMkt6QDELa
   ZAOT0zbrlJ4SEQwuD5qyg3Twq2MpfTLPgtHTnTM6ahkHI5931njgZykh0
   HtBlSuDhwoBv2zG62zzTx6tUxgkBhF8Z+LwMajkFn5EJNBIk2i1p0akrB
   5A26hM9GGTr2o3DqdGLCVnXZJVlWmykAtbhPJ3mKRBamTOewQJIC0Rkkm
   bI8PhmkgCo7ERJHP/NA7IynfrKN1Qn4a/Sj8wenbRNiRLEislmXmasek4
   6jjUD8maUAzj9T5OaCz46W4YmPm7O2QitNBQlDjnNrjTKLcLVg70LNBxk
   w==;
X-CSE-ConnectionGUID: /WnZpioSSF2EpK5hrob0vw==
X-CSE-MsgGUID: rarV29lCRlK46uSJNwpWQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="73889419"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="73889419"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:12:05 -0700
X-CSE-ConnectionGUID: N6d4x03ASvKnd8ywoudxEQ==
X-CSE-MsgGUID: /HLxv1H2QQia/YjcPM36iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="257489400"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:12:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:12:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 19:12:05 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:12:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vc53DI6777iqOkNOJ29wutFBZ5hBcr+PpBMt280gyBK4+HM3+G1/F2Zf9k/VXE+zdVbwWyU/y2nHNrhm/y52bQB2XGDe5Lvurizo3WtYKyEQBAHLZLAKGxKIN1aZGuPxrZa1TnNHV4eaWk973A0sUCPwbNOdZphkgQF8Gt01ApLtcOryLIKwLtLfLj52AuEO7IzdUgcG5dpzuRKY7sKZisIwbT5QgL2n/xccXnRHndPkGkZOvADnRQy2UQ+w+V2rrdpG+XZxVH867weQV1DgvdrDnqXcr8ti5G+l/c+L6zZPlBOFfObrOkKCJhQrG96b+ya2bZSmxj9WqcFyncpZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSQXFuPAkxe7S49ZG7i9KRTkcrZkehCH/hxxOBBdDBU=;
 b=hI1q4SjtzSqwmveAFjaexlUfUsGXDxTm0QfTghbI4xSak+iInmiZqChBixhOLfjbpkh7bN8l9r7rN3SEFrReTEyLPxUm+QkQ0tivEA5B9lzzjFbsntjMpvtmZ+93gTSYVA+FCQoSNdahz34ydCOqmL+O08jlXY2FlcDLxGqhS8O2Tw5PE/pmi9BrxpX01EPuxomgDXUqKRef5J2Av3XZq4VACOSwy+igMPIopjYdqeA3JaiLxG47gTekcYZXzDwP9f0HTyP6ZetrFzVBzW02il4/nVzgtY8GMt2yhk9ySGXWBB1kEsLVzvMsYdjCsxuAtiwdZdFrL/5/VbJdiOOolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CYXPR11MB8731.namprd11.prod.outlook.com (2603:10b6:930:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 02:11:55 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 02:11:55 +0000
Date: Mon, 3 Aug 2026 19:11:49 -0700
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
Subject: Re: [PATCH v19 02/14] cxl/ras: Fix cxl_rch_get_aer_severity() wrong
 severity register
Message-ID: <anFKZQJSCgDWIKQp@aschofie-mobl2.lan>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-3-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-3-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::35) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CYXPR11MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: cd579f46-4342-4f2e-1391-08def1cdc164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: oqDhNa2RWx/FZCDIFv3SxMEDDlzYtZ7SGlVfV+sPEqW7ZW02T6tMkTEA+SquoqV6d8xfjFJrWCdSfTZON761iwaOS93T8PUWhFgWrU4zbwoPGolEJIUkgfYkykwuG8xOR5gHLdv8u9o0wVWZ9vALChGDr1pGCqkiwUmC9tFVRm9oJXdsGZ0J7mhCjjfP/NhcHYbSy32prKatHca+m4KL/2+dC5+s2Q9hjxjAVm2kBpHjh/MeQe4Nvf2D0yktNiuDoPC8LZdFSJq9d7g0RBSVVxPeMFpEKzmWbGavP6S2kkyUL4Nba5iIHkKjiifI0CYNh6I2ow5Mmpo2Q6FwkWTHysFINEaqr4PBKtGrrhz8hwZT6ckaqwgTMEzPUygOibO8CIiwOzY4W45g8nePAuGvN4nAloQnmD4BAAbyJ1dhMVXrKDeBxy47CcGI5RMf1qPudcf8y98LN3CoudeaKGe8dRP14dXinNPzvhw3ayRyZbuM2vnUlO/R574lJtInhB31GQYuhrJ3sIToYyOSRY5+olykHMcr1LnIceq8G7ltWzREoeiodKvFHccrIdGFlmQM44Jko6U5sD6etz06azSMyv99n/Iq9klmYng6YOPIXSys5mmTvuJGSjUEpaT8kZ9hTx3d0V7zoRSIrTr64+iEG60yM5Ofz0AzxeA2zNcBaDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fDwJAHW1r1wlBTOoG3jM14LEbYy0kddhxRhBb5mAoVH/UEGEDisF4BMrcnrI?=
 =?us-ascii?Q?qKneXqPXJgK8AHGyBqupXOB0izaSSByfg4AoKrjN7HrwPTQTwGFHSJm183ld?=
 =?us-ascii?Q?ogYJeKf6fBY763jdDgEU7m+apse3TsjKGZb0w4fI9SoSF0neVzix40oK2ON1?=
 =?us-ascii?Q?lsC/uADK+UL1pU2XRxASR2BFO2aBAxNZiJJvxk9kw9Nj4G40rfx1zI/fO/YX?=
 =?us-ascii?Q?FfuwaK7dv+ZeO2/Mt/KjccKPd6mQO94zj5sGGVvpHaZTE1sNzcRTA9kwGUKy?=
 =?us-ascii?Q?3iSOANBy8k6ucLYkxKa1H66yBCJwChPWTYEjraq9Qy9JC63Fp8+CDflu9iSp?=
 =?us-ascii?Q?L/oMZF2sErH147KRedN0nu3y5+a9PazTsCbzB4/msP+KELXlSywbxVe6PuEf?=
 =?us-ascii?Q?O+/pOmbxnUlbdOXe1HPowf6U+Goza+89Ouop9jSS/VSypUNG3KIBa7APMXtI?=
 =?us-ascii?Q?O49U4tFx3kyqiQ02fnitCfkYCeLaguAb3N22K6ma6cvWJ9vMCAjUzwKFzEwR?=
 =?us-ascii?Q?fl7N3+tSW/mDSBMBNTzxfgoHk2IJ8Xbk6M391++MT8DdCoFf7jn4+flFpoKI?=
 =?us-ascii?Q?UzSM+seEPbKu3eK5FurCrLwNuhIYxxNfem88RL++JjDDl+i2maR5rrWitZvJ?=
 =?us-ascii?Q?y11PO3LQCjfG+ArtfgxQ38ETGyoBUxLtUtkg7+RwYCNrBkq8PiB+Tqwg19wF?=
 =?us-ascii?Q?BilhaWZ8H6U1IMQlaLlg+FVa7Wa6p1x1xPXqlikVSqAp5Q7oqR9E5rWZmFgT?=
 =?us-ascii?Q?ey/HHlMEdj63YpgJ2b8evGpHbdrcMquY/KQ3RpFwWrllaeQT7nqWU8/f9HfF?=
 =?us-ascii?Q?IZmb3GkUQt5h0byrNgYd8Tu2X23YULulU/i+hOlwokkCokK+vgbwx4dHTVmA?=
 =?us-ascii?Q?kym2HtxaSGLOY60DEhH6+xtvNcVsieEy6wwp0vxr5YOcBvdNZUZSHBcPJCWf?=
 =?us-ascii?Q?QoqiEOxiJdRXv5o1cQHMPQuz97xVxw0u0Yhn9+WAC2yBG4itcwlZk2HL6U72?=
 =?us-ascii?Q?IgkJVBnm3vvpY6rgV0bCDPxZDBbciBoaK1FbEECf3xEfdJ9e6TomGAO0Qlrg?=
 =?us-ascii?Q?qyNvghJT66HKIAu+mYHGdZS0CZ/XiT9e3mP/ohyy8MCPOwiuBhFBYpY0010O?=
 =?us-ascii?Q?oFHGRKmzaRJFW4RJXO946ofnNe6G3wPV+00r5dDeBI9PY65jINYeUt/06+GS?=
 =?us-ascii?Q?YamgJoe31jZQQHZDHBYofz4jQtNm64TP5u66gAFPpoHeca4VSDjdO8xFKLEX?=
 =?us-ascii?Q?M5YcPbSVgDG6WO++m0MWH4D/W1IDbE8LpM0h8bL2TJkR6EVfhDR8PSgl4YMR?=
 =?us-ascii?Q?M6o6nZIzxV0ZV4EBoNoWXSDmoCMh0V218q43oOif6UjwItWgeXHTaclemFd3?=
 =?us-ascii?Q?oFHpXHz4exoXJMQHlBqKR2N8XedAKIHMK4/fUaLBPHFuU4mFYJIJl1D9ILL3?=
 =?us-ascii?Q?xHv6fON79LZp9I+UrAeuZnPuED9Bd/wIX47inpf5G3rs1ZOGgT/OVdYMRdCf?=
 =?us-ascii?Q?AG6sDPyJVcsDjX1DyZ7/MA4IU7DZZyxubG47n1ZRbs5KEyVoOdI1pZsYQ+NW?=
 =?us-ascii?Q?Swy8Z9VgUQIQT5QIaJnq1SwxqJxuGha8FoQqerNXHYATLMz2Ur/Ozm3dX1MO?=
 =?us-ascii?Q?BJbkv+BO39vL7mAqK/ar+PwksXxSL3VcLwtNUob9I7BM2u7lZ0rEekOzwl7/?=
 =?us-ascii?Q?WTsjCjkK9rWjRoX0oHbllRcB4LmmSSkDfHudUotC3f8rlzI4wNXvTPeJvr6M?=
 =?us-ascii?Q?lkNdF1SVSFXADho1cl5cgOZhYSD2x6Y=3D?=
X-Exchange-RoutingPolicyChecked: V5eXR5alicK0imHo3gC1Crr+54xTRAaJFTzJe9mCT5heic8dR0yPmrLrxW8JY+JeKi2chnmWO+GrPaMITVsTQNiYyNEywe0rud/ncYmVFopbAinuJjsXRmVNLoLQ78kzI9IkgC0VxkVIzh6bhkpYplp8xTGmFpGeitjSgrhMiewk9gcOdj9J8zUoGG4Uv+ZXMMVw/FeMkLLsWoQTb05ubcfnZwT/xwSvpsG6A5Uoi/N5XhpaS2twpoC2k8HpJ29KuYiKcLyjd5U6L7YvmsQsgSfos6/j8LGX3CYGGEDRknoayxu0uFecSjeOvbP0gPiHvn0nyU4dQvq8m/zfEMxKrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cd579f46-4342-4f2e-1391-08def1cdc164
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:11:54.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jv1wdvNv68FoxImV12xS5RLZjykYftxKA6aYYfLTupy0IemEoc/BHmfYKKPLzvWLtV01S2WMm4fIOQSB8kiHvBrfwTJTkW5+aZywdGsSSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8731
X-OriginatorOrg: intel.com

On Mon, Aug 03, 2026 at 05:17:58PM -0500, Terry Bowman wrote:
> cxl_rch_get_aer_severity() classifies RCH Downstream Port uncorrectable
> errors as fatal or non-fatal by ANDing uncorrectable status with
> PCI_ERR_ROOT_FATAL_RCV. This is wrong because PCI_ERR_ROOT_FATAL_RCV is a
> Root Error Status register bit (bit 6), not a severity bit. ANDing it
> against uncorrectable status tests a reserved bit and produces incorrect
> severity classification.
> 
> Fix by ANDing the unmasked uncor_status against uncor_severity. Per
> PCIe Base Spec r6.0 Section 7.8.4.4, each bit in the Uncorrectable
> Error Severity register indicates whether the corresponding error is
> fatal (1) or non-fatal (0).

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
