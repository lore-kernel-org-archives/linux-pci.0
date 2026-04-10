Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F462388E40;
	Fri, 10 Apr 2026 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828046; cv=fail; b=U/GKIdqPANf49yboC/vu6yfxJHmLXuWuR5mfrzDf8vH3kz8vhZ6Q4pcm6pn9c1AEtjoTAv+hLPIxD3rdtVUYF6oyq3wHPkCO+sJl8g14nbqzSUIT3tI64BZad6IblM0HKLzRqHIeej+1Zo4dwaqxblz1w5Z9AiTwnVRwOuyerRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828046; c=relaxed/simple;
	bh=mE43ofK6HggfgriO/t+KxM8B7Um/8gfIsueInr+0wOs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QFcEhBtZWBsT8aZSgIzI/OZTLwSBRy55gPP11wCfIH1yhVskYTZs9Gx9qwGzlozn39XddSBFo0RH1I2ru/vtchy0nxd1DAy3nUgeOS8UHKr0GTiHaSMs4S7c5G10au/eaUuH1mr28jt5IyX/JpRSRQinoVdXc2Ek+qD4gV3hg+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAPnBAgE; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAPnBAgE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775828045; x=1807364045;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mE43ofK6HggfgriO/t+KxM8B7Um/8gfIsueInr+0wOs=;
  b=YAPnBAgEICI0S0oma2JZ8GRNn9VFz7N06rZTPfp2hIa3F8Sz2UX9VAe/
   VVmlYMjfcKe6QTnnXfFno2hL5biyRP+juLd4uv4VOzQ5rlUFhS9iCtJfj
   Q5EOwOy6cl0tsULlUgWd8qP0Q6vQvjaxy1Tzg5eJeHkRq/hoMtA6Oq6q6
   2UXvG1tvA3Ox56H6co4wbIGzMpH/dOb6QSqQKyJVZu/PZ/QYbbndUarIW
   v14OEUWkIkPdRpwoyAB7pX7LddhEMrS5ldqR4pHplRmIwXzbuAzKQULug
   4czxLhfkBz4rIJC5k9P6PWEI7fxBiY9xoQGiGbsMUxs7Qg7xvNAY3byWq
   A==;
X-CSE-ConnectionGUID: w5/HyXU8R0KDaTqujbEixw==
X-CSE-MsgGUID: 0N09x+bwSHC87e1+/w3rQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87544408"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="87544408"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 06:34:04 -0700
X-CSE-ConnectionGUID: MsaVpUZkQoGGhYDaycyMMQ==
X-CSE-MsgGUID: xS+D//9iQdGFx6sOz21RvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="267053057"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 06:33:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 06:33:28 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 06:33:28 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 06:33:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1utUNUQJZtkG5r3x9YxxFLpOj4I1Zei2BnfhJcfCuZ7xh3b5p8sQkS2GB5ikjOI/vTGAN8jsdoGW+ldHmJ/Bqvrzf/5UzcxEeFFqkceq+7gyWBPNb7hH+8dh+AAaBfl5QdQnCgCK4ejQp1q6CkdceEPFm++C/LosT+48iJL69o3kzSNzxu+Vx8h2ap+ZzedYMg/9F/wVJqnYqdZ6RvXl2Y9lkiCTT8KEZik/5igOsGTnc3Oo0zumU4XfPPprFKb2jVkAZPDVZlq+O6GC9j3LblZYXvuNnnvoKKwT9KtdlgU0bUFGWES333j16NvTiBVvjBuGrGyG2/0v85Wlf7Lhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hTJXMjufOHjXSIaWgop9oZubPzN3uCenellTODUm7Q=;
 b=WBCC1H7kerNJ4+feg0rHP4I+v5q6O1HRFkW9nIoriVkEKZZoy0JXZ/NgC2mNMPcfHftRkke4rdgeVTkkqWkS7Sqy+6n9YoqIjjwiY9xKTJVbVIDrDNwPlGXSFFQaP9UO2TsuPj+zTf6ZCpRt9gRhN+O9Ves8Mkssxh4pm4FGMImUBPZSPHbf24FKObnoa0v7kAx2BHwbiJGao0k89OjVTGOX8pkUulqZ+MJbVMNe+tcHttEaeemM08JSe+cj/it98ToSgHb+yy+ujP7qazsmKIiacgfMuVkq8RtU7xhYWlZADlpAl/mPirypyabrU9xITQRyRZHcI5JpiQU4V6UY5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM6PR11MB4513.namprd11.prod.outlook.com (2603:10b6:5:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 13:33:23 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 13:33:23 +0000
Date: Fri, 10 Apr 2026 15:32:49 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, Phani R Burra <phani.r.burra@intel.com>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <anjali.singhai@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Bharath R
	<bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v2 02/14] libie: add PCI device initialization
 helpers to libie
Message-ID: <adj8AR6OuP-LneCY@soc-5CG4396X81.clients.intel.com>
References: <20260403194938.3577011-1-anthony.l.nguyen@intel.com>
 <20260403194938.3577011-3-anthony.l.nguyen@intel.com>
 <2e618260-2153-4c36-be61-d2329c9da13f@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2e618260-2153-4c36-be61-d2329c9da13f@redhat.com>
X-ClientProxiedBy: VIYP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::17) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM6PR11MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: e8474b02-8b83-4334-8b22-08de9705bca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: jOoXAnhER+0IB1PsyLrHLXoOkvImt9IBABOqXgswf9fnrFKCsGg6p9wZP+/IYb9YNZJih8vpTYNo6Yob57w+D1m/ab7Bj98YygoIrUXQzCh//n94WLbRYQMJcEoQR/JaPKa0PYj0nsWBJYkaHNjsFuTPWod+jVvZzw4mmuz9DVbTBqryYRTci6AP95oMh2qi2IouC71T5Ssbxh99HCLvjyEAp19BxRLf8r8mwqQQENE+qya3uMqRpt8Y6Wt83J0QVsTTGm8gfyDyZjUZSJrwqF91CUMl9Mhj5N1in5d6xF49cQTfzufobZk+ssur5v7jOGZgp51oIPCm58u0Ve37yByQxUWTWWV+Edd6zHVUSEBLJ7Ivw2hfugjLtTbqMHgKcYXaxwgTM5+emOG6rt8fPWPCgcfS0UnWQ1MGN8ASlH2pyiGxlMACS171ri+J8Q81DvwvQcc5gNVYxIv1n22ThUj3cpviW2F9PlW6kUm4Qma92CNUhWFx5yRsgRHiYxWHZFBJPibAOXLhvXn+6Ccw310bCC1wThzOnJ00eHwdPuJuKkvhuGPXwPvOL0vhld5rutzgafdvt0U/kSNjd6GOm+GG9jga/hXeeV5fjtuBwXWfUtabcdwe+opTnbo0Rz8NJJuTHaVY2gAZe2YyxRIp1OO1jNoxlJIaJUxgDOY/FmdWsfxC/Dp3tXSHYvgHRs1kb/5hybmYHXiz+2xUVqtFtPM34pCBJnLNhPMzHkqUOfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OC5uJpNV45noy9BWQL9Pr1DA8oz24wBR521oKpTJoEMYiSlgf/hzo5H+CV4P?=
 =?us-ascii?Q?37xOVuvJG4he+XOMlDmM/UmY6sDSmByPaMPnfKGEywkgWxoZ71rHj6U3SGXT?=
 =?us-ascii?Q?YdqiIET1O9nWeouLMXXq16KiTUU92XIV2fxM4uUHXaUCRfWWz/OfHn17su3E?=
 =?us-ascii?Q?d3VeW2ug/I2NUOtBxEK8Y87UctEEC+u3oTi6pfszzo3BUYqCJt6B3fNbbtsR?=
 =?us-ascii?Q?Sf9VR/vp6chJ8qiUuVlXkMsqeWztZ38eD12S5+QPSmjkBX6Wc1kiJ/mRAA+2?=
 =?us-ascii?Q?gBPztHhKPYx7dJvkvmpAJbXWqBfRxeZdqZIfxm1YmEf+d+KlVrKO8sQ+6Hgs?=
 =?us-ascii?Q?/MURemfK86wSLMQ7AWwzqJppQWao0L82Lu4/MUwc9wJhRMSucaCt13VKiWhJ?=
 =?us-ascii?Q?YCk3LYuLuErw9dvg87WdEbAFxLYxwfA4g5JyB0TM7ZN0TwESJp57p/dCXf2d?=
 =?us-ascii?Q?trGutwyrK/WU8PhTWbBQRKCZ20rt3NcnjzI9dayGS39AiasKUjZ6JrXa1qVl?=
 =?us-ascii?Q?0/SDJgMj3f3VUn78AWyhTn3Ohf5ZaInLydtPLW+SsmsoVQKzJlcKHxBIxlNY?=
 =?us-ascii?Q?Cn/cSJwYTFTnKZhr5iDr2hfjTc+ZhHZYsAZWBEiHQkntkjkfLZUoWFlJYeZT?=
 =?us-ascii?Q?RblxxO45csJfbVV6ze2Nd/el5c1z249wR5Z7ulIhBpLSduujeO5cH1NnFYKm?=
 =?us-ascii?Q?4MI0zbhvXXbsOE5PFkKIBbiciOwQWCk3KpZvRBsDztWeEIfaNMnOq2s5wuTV?=
 =?us-ascii?Q?69g1/5Obs9tEW/T6WH71rhhXG6pvlrOdMVaR9Vx7yyKZ9hqkISD71+Z9En8z?=
 =?us-ascii?Q?RejU/ZghcZSk4zLLQLdgsjU2YfrrWpKX0vG0IXmCRYQQ/VOkbQn6I3ot4vtm?=
 =?us-ascii?Q?EHWGBbuhiRA5nlUBJPO1NmhGI1DtuvyfAjt0B0nCxA7IJ6lG2trbUmurQbj4?=
 =?us-ascii?Q?3l1BwznmPDb63pkKuJjqoReOyN33BpBJ9JdIJOJX7+ieFLF08L9G1AWXXMFE?=
 =?us-ascii?Q?Nf9B7KenUMJnh8twdOHNg02obb7EpWht0VppJhtx3v6jjW5gx+p2ihGzmXB3?=
 =?us-ascii?Q?2Pc/f7XXYDrQ+h/0X5SaLOILnpFDIUAkE1Is795q0sVfp1FdqCxdFUqjQaL1?=
 =?us-ascii?Q?fUp6q94SLC9QqIY9gd7Rp7K30ClRDxa4Nobbn8TpGTaXcpnDi4fKbrOR2QBf?=
 =?us-ascii?Q?gAcGrlnHjDDK4gyqdVTRV9iba9ZbHvHTJnSaoZu2xSKRnjDb0b9CQbEr6S5D?=
 =?us-ascii?Q?trsgjTD3GMBb3CgStHi2hC57WzQmrEgM2075Q3yPjM8hYIVuE+GwbBJCpbSE?=
 =?us-ascii?Q?LWhDXiz3BLJVedhqDw4jxlgpp/lDIvORdyycxUtz5pLawOW9Vu30kRELBJYx?=
 =?us-ascii?Q?ox3h8WpT3CPB2YYFnN/qkZ3kRdhHI6qzuE/KjScgj0hwAdJ56B2tzRxi4Wda?=
 =?us-ascii?Q?+zgA6BFesqa9RG2MHIIJzq3si4lNyFMO2Q/FuQEHDXnHy9U2gJLeDeGJM6Xt?=
 =?us-ascii?Q?Lb5RXxEr0MuGjb3XRrYGwBWn7pi3OBSOK4SOFOgdsZhPhElgQ17AbkTKpTSH?=
 =?us-ascii?Q?XpO8KdVckZVbdc9LAKB2cqGhhALYMG8xYmlC392jN+MbWYI9F7ER9WcoG6vE?=
 =?us-ascii?Q?s0pXudIa3ICoh3Pca5qxkfjwhWe+crU3GvS4iIeocbDOS6zEtziOTg/O1Rm/?=
 =?us-ascii?Q?RfgGXny8HaKCY/HlZXeTEauwLqdcDLAaftDCa1XVmVrVzH9QMux1G5KxYyh5?=
 =?us-ascii?Q?B7Z/q2oo1pBwu3Mk5p/szp7ymgPynSWxmC9r2F7iugkYI3HFD/KnT45z4ZT8?=
X-MS-Exchange-AntiSpam-MessageData-1: EXF4VkLK8bzJHRkVbmrO+jKae7DvJ/z9qg8=
X-Exchange-RoutingPolicyChecked: Um1r8SZvbUwP2YaeYOZMkQyrjb1lwrL7qJlLSRWRffGtSs5fobcSUOeJQkMkw7frSbW4ueHv6b66A4LWul7Y0xw2efyd5PZ7TBl+QsW2QhcrI53ydwzn5QmL2fpT/0nWaUyZCGOyY+dh2dXLoWkolFBD7rJOlkr18r1sbUtO1AUeuKDZHETBD7DIjiaPKzK9ABUiRiaVF+945BNRxnVZHX5bSeWOh5tSAo9TVFhWX/nvk2qoVEUT+EF3sja0vGIyPIeEP5pT5OZot//ppu/HF7aRvmChanCvxkXIgbJdEP37J8ImwVp26IcDcap8gUbxdv7d9bils/5i9WcQFVFhMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e8474b02-8b83-4334-8b22-08de9705bca5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 13:33:23.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbOzw54v9SmseCmM3uu5FYDAXJekTFwM4v4tlQyCDfWjqGz1185vMk1+JJFloPJ6rWkH3XbblGCXe9IkZzG8v1wW4qhC5M/hySfY2tBx6nE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4513
X-OriginatorOrg: intel.com

On Thu, Apr 09, 2026 at 10:56:26AM +0200, Paolo Abeni wrote:
> On 4/3/26 9:49 PM, Tony Nguyen wrote:
> > +	mr = libie_find_mmio_region(&mmio_info->mmio_list, offset, size,
> > +				    bar_idx);
> > +	if (mr) {
> > +		pci_warn(pdev,
> > +			 "Mapping of BAR%u (offset=%llu, size=%llu) intersecting region (offset=%llu, size=%llu) already exists\n",
> > +			 bar_idx, (unsigned long long)mr->offset,
> > +			 (unsigned long long)mr->size,
> > +			 (unsigned long long)offset, (unsigned long long)size);
> > +		return mr->offset <= offset &&
> > +		       mr->offset + mr->size >= offset + size;
> 
> Sashiko says:
> 
> ---
> Does returning true here without creating a new tracking object leave
> the new mapping tied to the original mapping's lifetime?
> If the driver unmaps the original region, iounmap() is called and the
> tracking object is freed. Any cached virtual address pointers to the
> sub-region would then become a use-after-free, and subsequent queries
> for the sub-region would fail.
> ---

Current users map and unmap region groups in a 'map 1-2-3 and unmap 3-2-1' 
fashion, and this is not expected to change, so should be fine as-is.

> 
> /P
> 
