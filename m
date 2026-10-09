Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224F04F5E19;
	Fri,  9 Oct 2026 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570439; cv=fail; b=WxysunFziAyvvvlm0fXRlBHON3UP8TJFAqAZ4n158uEmI7jnLUuXlPiDDLipbM61LNGy8hCXlng/Y1sLufB06LY2JlVnhToHn/rei6/5nQvt0VKUplS/JgFSWxjJMju1xexCUvOihmcm3UHB2hz8uIGZrfDEzGqHXCHsVy1agX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570439; c=relaxed/simple;
	bh=m8rx9Fy1aA6ib18cwnG77bySzCL4JljkI68rIuv0ysk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B/DNx7OJuesUO3S3TeO6+fNvkfDQyDzPqlymmVAy7Um3h1vCUna5IzkyhcMmHEQ4cRWo53EzdE8BSoIMv6chmbEg6wTAWJ3+dluCzfhmClLJdoBdOEImKIYXZmSKeDGYedQCpgHwrNi9wSrCdM3nN9sQsHFujnTechB3WnQHxtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6KmyDoy; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6KmyDoy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791570436; x=1823106436;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m8rx9Fy1aA6ib18cwnG77bySzCL4JljkI68rIuv0ysk=;
  b=H6KmyDoywY9rO88FDsTxXckQVjue17D+Yz6CUgvXNV8EDPHGWricghDK
   X2Xl8/MGUWYg6hCwHr6MKsZbFfXX0EMD/pD/0zxIBC4QvvL3f0Qjatou1
   YZR3EwtE6nL9LDxZ1BT+EPYa7oWhjLK6SlV45iEyVnhn/dTe0fKCCCoE7
   h8XkZLBBMmlZA+HwnM0mJntOtY+2EjBElMSRehO1YiJ0A96gbLXhasZFW
   nZtnuVC+CNdTcnUaaNV17zWdM/AfLVx6gt+7SbJSV/zEuEEBbQSUTS2lS
   qpE8f/O2Fdcj2m0QjrRFErBRQPiZ/zrGdUuWujjAm7ApVZLLU+0RZx14g
   w==;
X-CSE-ConnectionGUID: 72eZh7xeT5iaDO7a5xyhCQ==
X-CSE-MsgGUID: a76HC4/dTy+H7dAaORHY9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="387375"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="387375"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 11:27:09 -0700
X-CSE-ConnectionGUID: p2a0mIlqT6aPsffN/xs9Ww==
X-CSE-MsgGUID: Wq5YeGmiQmy+UoB/P2XnXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="562338"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 11:27:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 11:27:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 11:27:08 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 11:27:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiGjVFYyFMefeJr3xd7oDk6mL9e8qxcagUK/1nhfcyRWiouBDU6PIbCB7sVbq6eECfNoON0tE+5XvRvDfJEIkhI0Mvt5M0srIBN+xI22StkTTyPnyMz11/xx8usVCFfy4VFlocZlmVOqbOn4l760wMTR2wHrN9g6QF847IK8yXt/4wEWe1pHJcbndC+jo8JV/puOeym3L3HIcM4xR06n653/ff7TEZofNeVS6ixaPBhCihvxy6fL05w2G7nmYm+n8Hhf+0LF99mPvSGJtoFxPWIrx64pR8/p47g0OsIjjjnmh/1UIZVoGVaSEESRdl2ol8uMRp98HezdvG7lYWE0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGOYtulhGElCPepbNdjUXHO/RvjrOPS8s0pGhV5YOW0=;
 b=Lq4xB2QnzFr5nbk6frjxisgDSHZhDg/cOCy1OvFxDQD695nwpvgJXwLv/NUkK9kDFXtkpclrgTjkwzfOT2hDqECuxvrHkEz7KPaOjPcIkODsbIYxQF1FZrIKGkbVuh8pscI86oCIFki+ESePcaO6zxFyw96/vhequ0Ufp3Y2Md7hh2AbLxyxZGoGNbareleqvMkL2NVKlyGADmA5J8dxWQWaFLbwcq32aoNPCYV6XM8HL1G5+q1pgHlvao611RognIgb9Mhv11hL0r4toRsJS0YcVVuK33HWIhUPzsVNGDDIUf4fyMvvNKUWrVNlMdybkqbTOv5uvCEcZdT1zvQG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 9 Oct
 2026 18:27:06 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:27:06 +0000
Date: Fri, 9 Oct 2026 11:27:02 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Koichiro Den <den@valinux.co.jp>
CC: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Ira
 Weiny" <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>, Terry Bowman <terry.bowman@amd.com>, Alejandro Lucero
	<alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/acpi: Convert QTG _DSM latencies to picoseconds
Message-ID: <askx9hKP0Bg-qzPl@aschofie-mobl2.lan>
References: <20261009045452.1107921-1-den@valinux.co.jp>
 <20261009045452.1107921-4-den@valinux.co.jp>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261009045452.1107921-4-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fde74ca-e495-48a2-4b45-08df2632ebfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: aTNuGrWpCUvl/AEh75Zhlq7pZazdpoW1JW/44Ah0Fv6hAZ9S9jIyxtASf1pplB19yRnp6L74zOkvaIIOEo3nvHszULid49VDQTYtP093shzVxvWpkGrKWaZe0OMJ0NgOErousEouf7j4td/pe3HKQLaT98ThexEJ/j29f4iivifzMq3OQmd5FbKvWZOlJ1oZbpkuFFLn60rKp18xVCuF5syXgd2XI6G+qb5xddld6W6KlnKDJ4LWF4FTesskSPisL00w/UZraQ9YWARVleSX6m692BlsUofcIN3LWV9W9ZlLnAD0GsUQqvDpZnvzAoisyJGbhTkpkwk5yaFfibhrUpz6FaTfE7vKx+nFu79LGgOq/V9SJFKqceEvzuPcJ1FtUNqX7c3nBE7+9LJZiickHY5lqJohrCH1w43O8N35dV985MTU2GgWqUfRi2DfGmMj/lGDWlFc+VAECrjy9z8phT5Twa/6uEZa6oRkhMKl6JNpXc/4VSaAHToBiJ2tpASYRcKlGEnnFB2qr5yHYO+OvfFkrEDjlrSFVMkUHxO8KX2JaVCVGvJko7pB/c1CnOuw9VFms24n7TOdPp0NB4vbhcm1vkJoWInRGz/5xkjTRa+/2sO542hfzX7MatoqGARwHnaRE4sEC43nCqqvF7j62CM04Na/JiPOcr0Gcfr+jgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sFoNSqrsvydHQBA+b8QUAhX9tO5ty2YpX4fjvE2wuBR20rPnq5gKiyeXLtDT?=
 =?us-ascii?Q?gPh1wITj+SnlaO96RlNjRI5Hji3IjQDQCQ9+9IiFrFxtBYq3+JkNMlwuM/4v?=
 =?us-ascii?Q?h+tLDgIPyijKUUtGpYi9wOXnxRRCtBhUNA2tJzzmmspfYDCIMBzpxIK7TMtM?=
 =?us-ascii?Q?bMJB4JyzsCT3LN0v6376UyJ9kEnPqGmaC+tIxJvvJm/KqkHHK7lqtFCV17n9?=
 =?us-ascii?Q?Ly01KdyyfPO3g9P4yQ7yufNwiVjyBbIV0mYCWMbDWZuw/LglzQHOHgoLb7LF?=
 =?us-ascii?Q?ra8SmmHMlufgISwRDL14rA2iQnXHn4mWK9ncAHoijy8aS8I1liLaBXraol/3?=
 =?us-ascii?Q?bAVxYg7z98C+8N80OSRLTQKB0PtQ82tII+llZslKXGbqNjPmu6wDfUr4sZeq?=
 =?us-ascii?Q?dofjWyoYy3TGCbr1LO0h7ku9HJxYBDTwplfy6MOXulhrNbbxOw1eSpzYeV+t?=
 =?us-ascii?Q?K6SSKpgLiornDvO/HouxuUUCuAhfUtXDBFciO9KZm0G2SIcsUY/up7ACKZpa?=
 =?us-ascii?Q?rmjOtMjRb+IiwZnkSzv2zlPNMiSmU2zZV705Ot/b2rDoNLaw/BuezgSvrorj?=
 =?us-ascii?Q?iF216i2xvuvxh8hhE1C0lpjvmxQuXz4f3nTKNp/oIO/JGBixYoHDxm67CZT9?=
 =?us-ascii?Q?D1cnurtTaXf35VNwAoiQDhZbPEnp0v6KHnpy+IF1xJwxnyswVYTjHJPyEWAO?=
 =?us-ascii?Q?xLOw1cPOlQt2AsE40Q9ImqFEdvm7anr/6T+YsIoBLRu6yUk1X+dTjWPD6uzk?=
 =?us-ascii?Q?OiBOCDrvh73EeWA2waRsbmdiLAxO5rQy3VCYxLtKq5VUA/vVbnMDmqKVtISV?=
 =?us-ascii?Q?zezxlh6P99R8y6GYemj7COU95Shpjd9qO9GjmamZaAIjQU40wG4Ah8WOew/a?=
 =?us-ascii?Q?fKKXy7yf5C5PJxIX+BM/wH424FMnxmSKCy29w6IMngtXwBpSyaIwtOB+Zu/N?=
 =?us-ascii?Q?0hziulHE7ANLvsauGE5F98bBxEq/jLsG6UtThQfRTFnnD61TM6/1zaMhwg2v?=
 =?us-ascii?Q?GeHLmH8kzGKkc0JqKWKOcmJM5TWCXlqIwWC0DvwSUjadvQj1VecPSfU/jy6V?=
 =?us-ascii?Q?dPvcE32fyigR323XdtwyzGZsX4ma/ZGs6ABlrLQGCdpyifW33YsWaVraaoZa?=
 =?us-ascii?Q?00aXtVZk+jZqXj7e5pcCYSpnPzscC4bonE37q+HYJxHwsPCx2VuYGGxz6Grc?=
 =?us-ascii?Q?ExbkHEMWqbY8av4UcsVWNpDdLy78Y35ygxTDnK6AwwyypCCuMpBHzoTrprik?=
 =?us-ascii?Q?Tgs5mYcfTt/4LL8q1GWmByO7qph3eTkt4xb4pLhMySfmmVEIMr/+xUyTIUj4?=
 =?us-ascii?Q?jeAj7jhkGQ8xcxgQpypDtWLh5NEEb2tBX8nC/Wxvt1xqN3DxoaUXxPHcHKpQ?=
 =?us-ascii?Q?Wi82gms7+b56ilX85ElvJdsFYaJTX0l75bgRJhwkfKGDo9yuV1eLS/fXtB3v?=
 =?us-ascii?Q?0qfqwx5prGzD+WDFDziOMo4Gk8LzHrcFpodJfln8jLlUN4gLrgJiaYLWAzFN?=
 =?us-ascii?Q?e3nodw8RPL47m/7fph9J2mMdZCUWGsW7yC9oVi7qXHuR8zaQ4bF+kFdx0BJs?=
 =?us-ascii?Q?8GiQx8Qgze7sGdPvZ0OFJ6Ei3p6cHSKUwhF7r/aCgphmKp/fDxwidt6/yarB?=
 =?us-ascii?Q?ePo55NGScV1u8Fh9UxUUZ8P8WvT1ecgsnw3a/OPEXrhIZ5oNN1CaFtruCiyV?=
 =?us-ascii?Q?qaJSPlAi6ks+xJVYHtiZY4UW1UEPHdlr05NF2lQ5kbClR1Ub4fSixfBd/1Vt?=
 =?us-ascii?Q?LbGT/d8sWJanQL6vD39FlEXKcf7GcGI=3D?=
X-Exchange-RoutingPolicyChecked: Ujzq50BjnYmEcBxfZv+RHVvkXZ7Y9SX43j9qiK/cPPTf3ZOkXkZIlAPiYvNOOAL5CzUggHnMA8snGoeeq4AharJs8UKuogno73otwWKau72sgh4lkZUBTAIEp+R01ZJmP+bXF+xG8fNYv6mExUTpMUdMCRazOkUZkvzuWFAo/IHZsJn3pK2xkqG4+dqDiuU+G01qmPs3PUkj7Cn6mDFfHeOft6SCOZC6JjvwF4lGx9Vs0PF9/QhRtJLHMUyXMi8zizAVkAd5jKNKIKwcdvTe4So1AfBI28lfpx69pxlZuXBc0DeKzUzHbk7HNji0FUR7313PJvehgqb+5A6yrwe4Fg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fde74ca-e495-48a2-4b45-08df2632ebfc
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 18:27:06.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzvbfZOIkrzJ+Si53zpewYt3fNmZXn2x0ehbqk6VKsuPDGvleU7ybiFBCSNYWlz8stn/XFJFetaUUKSvQnJIcYoyMR/1negozGZHRhmtIec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
X-OriginatorOrg: intel.com

On Fri, Oct 09, 2026 at 01:54:52PM +0900, Koichiro Den wrote:
> The QTG _DSM expects read and write latencies in picoseconds, as
> specified in CXL 3.0, Table 9-30.
> 
> The code base originally kept the latencies passed to the QTG _DSM in
> picoseconds in effect. Commit 51293c565cf4 ("cxl: Fix incorrect region
> perf data calculation") normalized CDAT and host bridge latencies to
> nanoseconds, but did not add a conversion back to picoseconds when
> constructing the _DSM input. Firmware can therefore select QTG IDs using
> understated latencies.
> 
> Convert the latencies to picoseconds when constructing the _DSM input
> package. Multiply in 64 bits and reject latencies that cannot fit in the
> DWORD inputs defined by the specification.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

