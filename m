Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C1D4FD78A;
	Fri,  9 Oct 2026 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570380; cv=fail; b=IZ/80XGaAhFpjv1wsrawP2Zr7MH+C/qTB+KpYPMpyKMrDWPo5E0IoTPnCFYk4nyBjdhXldOzivsSDoaizG1uVAaFWCiln7pouNxWnFx/KZYSIDOZZnGt4TQTjcF2FicNDsyyr6wiNWwSsaFiNGNYvVeFQ+9ia7YDWiQ/psR7Sjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570380; c=relaxed/simple;
	bh=WYmqi9GSffJ+PKIYbGFqgcHC7uw7rCvNwGBMHjPej40=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UfvRfcM6+wvOVpbGp4gBDEykwKnkwyAVTDhq209cUarBR77PenhO/UVsaQV17vGpXbI4aUSvDDpMhcCWGFSmI4Xx+Ddl/RVb2PVoTy+i3HI4rBE9h+w5kpkxH1Wl2JfiPoUDeN+t1mhbjrMS+OmCuRq13WsKWCvQlx6d1I16Nv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aT6UB/S8; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aT6UB/S8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791570378; x=1823106378;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WYmqi9GSffJ+PKIYbGFqgcHC7uw7rCvNwGBMHjPej40=;
  b=aT6UB/S8ii2wrtPd6yfmNWnJOcXwpTqYgnc6K4u0B1eKhzwkPtQKTCdj
   h33e2iIe0Ej1EvoWq7HuTAF3rYlCwz616Ml48qCurZ88J5e0QuKCgIu94
   dNh1r11icSOc+LssLMLCIvHeY0uUtfwVTLq0TqRm1ftU2mc8U0ayLnKiW
   hXNYy6abZSLLUTavHUt3uguAVeOzT679rjVFuiHqgc0mpic1nBXhsaTPL
   O/iOOkZ0QAJAotOeAg508zRXoRl6cvwBxvwSxs5jzbd7wKCnOqhb9yuVX
   DyBrbwMV2I2nsBj40yCtKrPl5jYOjzS+fCwN//X5QhIH8Rs9gGIJnWhsY
   w==;
X-CSE-ConnectionGUID: 4Z6NN3DqQnu2LkkBedcITQ==
X-CSE-MsgGUID: hCKU7ejbSQqVwMHb57DBAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="387293"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="387293"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 11:26:17 -0700
X-CSE-ConnectionGUID: XH1QRhSPS2uRl9g4xw9t6g==
X-CSE-MsgGUID: YQ/ILaEfRtOXy75JqIyZQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="562267"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 11:26:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 11:26:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 11:26:16 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 11:26:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEtHzPGhjILqurlfa5j13m0bDpY9tnulz+Dj/0+XjzWiwLZDt+ojLJoBku5ew99zL+wFeeo1SQJMuao2TQVibH/iJP6YWlkGEWF140KxWOxZnP9OBPfG0fcuUjBuposvsilfhLC7v2O4L6H8YkBSI67MwH3LaXZBGiF5Lh9ibo7OjnXdCXvdqL1mL2yi0CButuO/gHEWu98YobA+4MGwksfSaQTuMLU5gEv1roLJB1acWqpHgmw2rdZtiQyuNOEIq+wfYMbF3b8BdUDP+gGLSPZ1UNiSMb6s8VgLcaoV/xtv1l8pBn99BFa6IfnJ+RhJZR0w0knfgbLZJzwkkzQw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvuR1GUfLKhPcJE/b/QbGlj5uPh41phl0fB19l4PAUM=;
 b=t7uqiJWRFS/vbyorEHwtYEpLNiDZH1sZYXhwK3zD7tCDFWa+UAb+G3HSmIw1S339fqk5zscOs/RqDVA1db9zrPVnE+C6XnyBcxBRZgvfe64keynXX1sSZ0FFpVCHiL8NmXvCtwJcbFxT0NQ6Hh0mZp2TV4lM8c+XYn2OQTsnqznLvJIfTtkXcV1gWdYHU7waVyz+2gQeTdO9lQjwRMDlcAA2g2ThGW20Ofys9q0cAbGaIBjzjlU5c+6C1wUTu8xC+ZqH49PbC8eKRvvsbGeQ2gYKRinVNlYkIDAd9pNN2sZdaUFPUMnfmD3QWPm2Rr5Blqi0HbgKs/b9F0RZHLOSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 9 Oct
 2026 18:26:13 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:26:13 +0000
Date: Fri, 9 Oct 2026 11:26:09 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Koichiro Den <den@valinux.co.jp>
CC: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Ira
 Weiny" <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>, Terry Bowman <terry.bowman@amd.com>, Alejandro Lucero
	<alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl: Account for link width in latency calculation
Message-ID: <askxwXq0chgJepD_@aschofie-mobl2.lan>
References: <20261009045452.1107921-1-den@valinux.co.jp>
 <20261009045452.1107921-3-den@valinux.co.jp>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261009045452.1107921-3-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:332::18) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 6228573a-a3ed-4404-59b4-08df2632cca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: gwGbaIrYy7hnTzpjsopuWRGNsFLIr6T2Gb94EGbJM/+pDHuDlrWex1UzqabLoIdXLGqOsdnD9WifmiWM98ZDeAcUGTrEQxFld+UYhK4XNcQ1clCd/Fu0JtbMUL8M2Z50p5ZZp0khqKVTSPexlqLPpXd5gY781kvEmV6GUIa1wjBAnW5/1v9xj7GhoCsVm67R63jJPSa4uZMKoSR49zha0UqmtKbt6NGz8nTyw1J8DNIUmkfXrnWmuzfiIdJaU/MYBSu/+LTMaVjGZ1X7c1scErAP9GqXT2sSZn6+c3PdswN2uAMKgGC8ipfl8lnx3254IgpgdVvh9TIJKv9vbJK7Z1/TWgA8K/vGIDRwqscLTU+Ym5T+FZvqzNAiNhD83e4KBIazHzzx/TM7D6J1ZM8S3/ejNeU0GUJfWQXlP62fRZWbEGr+EKmimk4tAqg9hkbakmvWSu3N0EPu+uZQkgjq9NOfrxXG20HO6FXmGHxJOHnTkRB7skFNNg0vC7B02FjzeS+yGK/66GyxArHzeWXHHrIXCzsLCZtKjhq2iHHQeOy0Nm+3uVUAP/BQJBX+kVqe4K81/S+XaiC6u8UaKoYFKhgxDfxJQi+6KRFCrim9rcXVseDxo2Q6xQMif8sdDm9ipkEkW0Uru72CKgrAKl0JsQS32g3MjYGbFpyIExG55cA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1dvA4TuObtIsJ8jgm/Uz2kXj65r+FzCMTD2LxHOfWPi/3GovxJbSUlvrV/hc?=
 =?us-ascii?Q?eI26fmSJWDu7Hx29a1pnsw1gRPFmC4U5E5meXNyasbZX79ybrMo4BAOgY5Wh?=
 =?us-ascii?Q?IO6p4LEQd4Ux7GrXBsIGDIkrI80VhAJhiL8lQocGwsGLqjUcGNFR+wpPxMCU?=
 =?us-ascii?Q?c3AYtOnZO1p9gf34i1naNyhMpBdfOdHsDtw76uyIgXBUczKQo7y7oTmNTVhc?=
 =?us-ascii?Q?v81bhxCpn/5dbM6lYcBX8VEF+asbqPQPhNCKh7+dNjiSzZRz4AmtQJESU0X1?=
 =?us-ascii?Q?0VZPV/IwdyyaHX3dCjcaeMurJz5X9vlkhjYKFRlbG9E38eLB+dCltoo5iLdC?=
 =?us-ascii?Q?P0BGqXt+eHgPAB5esBsOU92Hj6fN3DOssFTdrH93LcXkNe46ECshARbFkbuW?=
 =?us-ascii?Q?qG+Nghkx+5B6vtqU1S+VojsvyltKEUgbKvEXDWBCsTQgeGXKX8BwMtCtCblj?=
 =?us-ascii?Q?2flROhY1Bx7MOl4jV6LypCgT2WRItT1l/+I3aajgvGdFzlJe6eermiicGd4p?=
 =?us-ascii?Q?SIUzfWrJwgMnWQ2UH8FE+6hA7BYQE6J4hug3Nz/vD3dTSuKfaa1FV+u+FfTh?=
 =?us-ascii?Q?oIn87OMTRYZPGGznItUbkGQH0D99WivT1t9Z0Eg3lr5iM1qTXWUKXR9wBX75?=
 =?us-ascii?Q?AZ40x6W6VZaPDvkhnifAkmzZl8X/thwlv//vxWHoOivqcU9yXGvChijN34Xd?=
 =?us-ascii?Q?nL8blNXEf/ePURAwbj7oHhnddVkFqqnVYeKapKoXxXvCGZTPDrTapfhVXiqB?=
 =?us-ascii?Q?UkitniBT+cd8emVZBWqA5OdEMDJstImA3KoQPDlOGyWHPd3YWVJuttH1S+uy?=
 =?us-ascii?Q?xLq4QgO+TCWFiliETdXccKSolYTAXg8m5OM2msdU487a0+Z45obvDWCqm6oF?=
 =?us-ascii?Q?FO9Q8VCbTDnpPqr3Z8YOjITkqWwC+1lDxakDDhN4OkSsYF61pYwWnjTAUkln?=
 =?us-ascii?Q?BVzr2S3Wu7zBVIeUt9YqEtXww9oRon+jhwbexFa+D0UQW4wRG6fDntKIFH3s?=
 =?us-ascii?Q?oVA5AmCfdlXokNTixJZkm+n8XY0+Vmt63GrSFdoEvlc9ugah5QZR7zZ+7I6c?=
 =?us-ascii?Q?iOa9MqLemNtCWWUJyqi5UaZKmB4g76NQwlrdLbNypaagjmajS2hGuM5dTrwU?=
 =?us-ascii?Q?t/73dlC4hCf7nu3AB8++gUJPteOPbQpjtfpN0HfktaiIxgzrM+9pEQw9WSfC?=
 =?us-ascii?Q?ePfDQOmuRw6RHr7cGiJd3RV5eHebg2/RCdh9tMqXF/f51KhkC1fHibnloY32?=
 =?us-ascii?Q?wmDBw5gu7h8o7/Ts7npJAafx4DuceqkRmH6pe8zYIo1ZqJejGYcvOnUhQCJy?=
 =?us-ascii?Q?OVhB+WLu44M3+cXcRvV3KkWJWAjlbStWBt+no4dSSOAIH/9Fce3ATAea6x6R?=
 =?us-ascii?Q?Z5qgk/20VwsCWXOUCd0+zeJMPv8moXh9XBqWRwFE05TuGu3zNREIQAR8JUTl?=
 =?us-ascii?Q?3eTLTw8f/fPVb2p4NN/IoCboHjJRVqFMk4aMTMU69pCvvtcl2oDl3UQhMfRa?=
 =?us-ascii?Q?6GtgMkswM2cdZl+3BL85ThDdBFL9JNdzrsI7JmgYptl8JbRKSNy3sRnIKDhQ?=
 =?us-ascii?Q?l0smhm7X+ku6ymGu2M/lrmdkOOOtv7Dec/IWudBz+wrHZJfoSSYchzl3ZeBh?=
 =?us-ascii?Q?YJylngwK7GL2M5j9CBmD2rP0VsYlww3DGU3GRKZV8gUXQVx/klNA5KcRdOa6?=
 =?us-ascii?Q?2vGTvxf5oYHAdyMQe1JFD9rcmrABb2frI0R/WV4iD/WbiNVFjsbNqUexKpKF?=
 =?us-ascii?Q?d3XHTVsOo2h1L+bB8/rAVnoCdNwviwc=3D?=
X-Exchange-RoutingPolicyChecked: 49Q/YwbijW/CjENwAWe7E/xSyB/RPO4c8VuwLFccBGFyTaugxKCgnTkIqwrfy3ZyJXOFu2fy8llJDqBmXTLHkhIRhsbN3mZEgEXCJaT7l96eitzSoRgAOJclXUUEuVL00HhT4V7S7BhJiTqCfu9YVhBswfoOVE42pU087nVNKxO3pXBTGl98X3ayI+n02CSeo6aDGtVWHmsb7Gp4g+Yha4wypw/msuUXsiqrrAB8PBCPPRsoiBIEbzexK4rtF5LXMwE0RaoCDetO5Vx7oxLErciAZUGaTtT+R3Q8gS6nbm9YPfKY1N+WcWxTmUa5whZkZOVDNb5uJBVdaQIWy0mt2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6228573a-a3ed-4404-59b4-08df2632cca3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 18:26:13.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WofSGwd1WO/DEIYMJ9m64rjxrmp0lBOOGOsP+PIPcUpf7bG75mLKpCQpMRlzONG0HvxZ/lMO8ROwAGo/d2TPXo6hpBdwIM+R6HRtNaLt1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
X-OriginatorOrg: intel.com

On Fri, Oct 09, 2026 at 01:54:51PM +0900, Koichiro Den wrote:
> cxl_pci_get_latency() derives bandwidth from the per-lane speed returned
> by pcie_link_speed_mbps(), ignoring the negotiated link width. This
> overestimates the FlitLatency contribution for multi-lane links.
> Sections 2.11.3 and 2.11.4 of the Intel CXL Memory Device Software Guide
> describe the link bandwidth as the product of the negotiated speed and
> width.
> 
> Replace pcie_link_speed_mbps() with pcie_link_bandwidth_mbps() and
> migrate both CXL callers (the only users of the API). The new helper
> obtains speed and width from a single Link Status read. The CXL
> bandwidth calculation no longer needs a separate width read and
> multiplication.
> 
> While at it, make error handling more robust by converting PCI config
> read errors to negative errno values and checking for zero bandwidth
> before calculating latency.

It would be nice to include the link here to the mentioned guide:
[1] https://www.intel.com/content/www/us/en/content-details/643805/cxl-memory-device-software-guide.html

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

