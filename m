Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945C2FD69A;
	Tue, 14 Jul 2026 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050409; cv=fail; b=Av5SqZopTbuL9PgQCK/Bi5TenxKldbprnZELGuABYdvzQrwWL8kRgLNJtB/Y/zXMT20FiuI8YJvGGJBlkrndDT692j42vOuE9PaAUJRYVswob7AJizmFWz44kWAEjlD+i3uOkFO/caA6Aw9h8mjkSBELc6IPQChoHyr5LzmX2tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050409; c=relaxed/simple;
	bh=6N75w8KslXg94doSw+tUujYMSRh8zi5MTtvDHND0Pqs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ix1ep4ydc7xPWTUmk5bZrnd7Heaxo8aQUFpeSoTVRnpStLiRKGL7Jt+jCa7e0WrpZ/vUawsbVSjFYMYqHeBXmhLQR+3CumkpoxecK2iYcpCOJMqFNHGPPjPuBKzrjdVDf+Rn6vUS8QK+poloG8nP/wuKEgDoUBh8GdiuSJn29QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDl1pzGJ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDl1pzGJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784050408; x=1815586408;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6N75w8KslXg94doSw+tUujYMSRh8zi5MTtvDHND0Pqs=;
  b=nDl1pzGJ2ipKZU47OfsEwa1PhXwdpcuaDrBku+AT849AdHBV6mbr0mHk
   fvppfrhuqmkKGNdXva89vgZu7MAaZzn1M3n6aejbnyPPfodNPS9T06vX9
   hgftbR34S1sALL0ogXiJyDh7LBbTSXQo6/i7bwgaW74a53DZwuyZ2m53x
   NJsYLM97JqL7VgiV1V4CpP+bASnsqs0sFJ2dWx+2hpAR05LLwHcqlRGAz
   bsl4yOacva58Mr/rvCpeKEUWCCztmGOvKaOkza+H29RaCroKm5LS3Fy39
   2LM+J4g8aJ+8lIL0bnQ0DXP7leYqlpXJhOVjjrVXMdJ8ZLmlKk3uohhsU
   A==;
X-CSE-ConnectionGUID: FX7dTWP1RaC3gdPAI78oMQ==
X-CSE-MsgGUID: HUNwbmExQFmtguG2FtX+oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="110226486"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="110226486"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 10:33:27 -0700
X-CSE-ConnectionGUID: SRE9yiMtQNODCySXu1wKQg==
X-CSE-MsgGUID: SJigcQYDSJuWpQOpqimcbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="280346283"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 10:33:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 10:33:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 10:33:26 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 10:33:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9OH7hePkpZEJnDeJrRkNm1L4vEfPFHd8C0/5QmNle6INIgvA1opsPGcZxTIcdvAhLoKEv56aMNO5UYCUJBOfcia8/Rxv2rP0PWhiLYZhzbZQw9NVHAGGdNopDQ1rFtPjU/8q8P0/FMhOXxCFawfhIpc6hFhBh4xaj75egDciOK0UqP9joDg4xJFQll9CFARtL4jllEl0luFIOm0hz/wdlqAPAQ+qQ9jGunzRNEF5iLpQTfGLNz9R1nmiK2XIazoRPqHZrJJ7tRKmzOpkXqVK8V/UTjoEWV29LmHMYpdeCpGg8d53Ecu27xg03A4Zj0EFrgbKmtWQpwAejnv57j9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyFjH9pbj4qEw5r84X6oHo9fGBQXHkz39hJhqEHpYb0=;
 b=kS+TeeROxK/f5wtATbs2eEwLiga1KSK3Js9GEZzcq/eej1ga315yPxuxg5Fnzu6VuhHX81n1IAiWp/GGQSPWJUKn6X/QLQSMaBfZvsRFJqmLdoVi11POIxwFwib5QV1x0hhsOOugAfDDQxqgZApP5/WnpHXQ4dteKJjH4YJeOrd5fGQzSU80stDtaBm7/PTn0ll3l7bJ7Ew74EOK09XKL1XH54MDu7yfUqTR2YzkP7NBM/x89TExdwWWUipWuKrlHFBdvj9gVBT0kEiY+DXCrJkMH9VNXUmgRNplof/giKfOcYCc2DrodXl0av7/qqQoIZzzT/tGrRHPQEhcCIo2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB6842.namprd11.prod.outlook.com (2603:10b6:930:61::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 17:33:19 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 17:33:19 +0000
Date: Tue, 14 Jul 2026 10:33:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Saket Dumbre
	<saket.dumbre@intel.com>, "Davidlohr Bueso" <dave@stgolabs.net>, Jonathan
 Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
	<iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, Bjorn Helgaas
	<bhelgaas@google.com>, "Rob Herring" <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <Dmitry.Lamerov@arm.com>
Subject: Re: [PATCH v7 06/10] ACPI: APEI: GHES: move CXL CPER helpers
Message-ID: <alZy0nxgM1kekZiG@aschofie-mobl2.lan>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-6-8b3a85216cef@arm.com>
 <alWi5hvXYT0-ZPyV@aschofie-mobl2.lan>
 <e77d0367-ab24-4b6d-beaa-034dd793cef6@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e77d0367-ab24-4b6d-beaa-034dd793cef6@arm.com>
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e765b7-76e3-4a25-bd0e-08dee1cdfeaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|56012099006|18002099003|22082099003|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: fZ/owh1fLzkB3u9aGe/4Cw0WklFdr7uhOgIle2aT1nnC3/R8IhuMKoC5j4vrBe7PzeVAPZb2A3C/xqP0o1g0ESt+zuYYa5QMnbYHFW4AEgb9+0ShOqKgjLOQ4HxvmADIbnbUjilkbtwwCM2KRmmiQ8Cbr1ETjFvUl0XNm7aCI9w2q18yG9O4bVvijv/ixNHqA3xDUXl6ovzjftwYtP9GCsic4XW+/S8COzPKT9QSMNlsiH5CyRc6ycBlb1OOJkU0sjuTh2g5RYTIDzECxdWM/Dhw2HtFYtevleMsMsQ0BDxTBDXCHKYvVvTed9XZgnFce1AoWZRU/QmhY1EsWdRr4XTXIGSBRk7jd0HJJs3keAMbqEucNhgtpRkj5XdNTQkPtCUZSIwmEDYo6BqNtan88SWr/HCGUHlMplFlH6yrXWS+MU//fTOUSbqkuxWfLil9mETGdkY4wBycwXmV9Wi491jpc2h4BTbJgBVXw7Z/YbXilOgcOlHf+jIB3164YquyL0A5I0fqpQ50f1yosz21H79dVIiq73bIBiMWvxQii1exlqZr9oDMqrRLEy89TnbiQRuAFBgA5PqeTlm4xXAXtgGhkeuaA6FpGFTEnWT00/rwwYoMrjp6dLEfePbpJr7aHT8kh/6SAMTkBQFouIrD1pLIYJ6qAm06+o+Ni+Xn14M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(56012099006)(18002099003)(22082099003)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Qax60OOdABYTSGDJy86EfJdZiB76qcRBIR2tIBGr2yLCG9L1/4pcr7bt0dk?=
 =?us-ascii?Q?/RmOan5JBpWedFTGStlbCwmxdCxisls5a0e1oDJcKJ2+iCC7mo7IOpSLwORD?=
 =?us-ascii?Q?MVwn4hj8zYeNb7SNpFLpdDmiaTv1ZhlrvySyhhMRsS8ZRtvICxC3g8iAH0CS?=
 =?us-ascii?Q?EwGLg6GxMDqGLkDwG7cdquuiyAgQTbNQMxrTdWqv0UQlsajGESc+S1UL/sVJ?=
 =?us-ascii?Q?6hnKKhWZwua7/S9ZUZalS1yFNTIcxwDE6V+fJrKImHi5VAyFybxLOzvco3FU?=
 =?us-ascii?Q?0A5NZsctg8JJqHztQjyWBdjARheL8NvvOvZQm92ziZ+ZilfYnySAy2aOYKOP?=
 =?us-ascii?Q?ZlixHbGwU76Jo99pmwD0AoRefWF6JyMf93oVAF7Fd8D5nwxVNMRROqydQia8?=
 =?us-ascii?Q?L7mYg/lnHpBjkO442Z6pEAr7QuuncATqvBGB5RTScYMqCwcrt3utX7/x0+/P?=
 =?us-ascii?Q?ZcN1rWNgFjcULmlAAWmUS1qW/lXKfHerciSiZQ5urBHm+NXBD7HMzaZUQWSn?=
 =?us-ascii?Q?kqrA+vrOoPDNDisJ89CIa1oi3kSy2zfzNEMDr7hOLOkQo1RSRzBQXV1nEAFl?=
 =?us-ascii?Q?GYx86uY0CGZSMmFj30e7zs3QndMPo1uLlbWm/i3xzZaiWaesISdnZg/0+7iH?=
 =?us-ascii?Q?EBQjDveUTgaE/dz89ssoB7fcmljN/Vn+BwW03r/wSw+I2gmJzVxMZZd2hVw1?=
 =?us-ascii?Q?9yLtTAEnVD/N0gtXdFl8ja9N5TLrsDtKG6PWRVOsjGnq3oGZS0Mo61Mg4BBv?=
 =?us-ascii?Q?IraDJkul3KTZ+2e3CAhLIX6J1I1gipHHxPelRBabZSRYdO/PHnzjW1VDQuQF?=
 =?us-ascii?Q?P3vwrbOqrVk6mlzqOsdd10/j80ShKlBRrKow2GLj/7dCu6meOdOg6gVRTqQM?=
 =?us-ascii?Q?eol/aT2P2BHrtYR0B4+Z9gZMKA1JD9kTdUUzbQ0B6gAVe+ifoSC/pY/9YLOK?=
 =?us-ascii?Q?X0MTu14hzk0V/FehFvW6p2x9rSWPdC+lpN7u3jK/qhT8cn4L36hNB5WO4LZZ?=
 =?us-ascii?Q?nMRNybbaOzRtpgXyTpmwgLF33vwokaFib7uER29TbCafIGSkbulJjRDXQRw/?=
 =?us-ascii?Q?qbcc1wUBt3CiOKzgdJOxLdDlS5GRZGJdjxAI518YPS3/Iv7xeTb4UaFBaAbr?=
 =?us-ascii?Q?9BuNAMw3ySBSfqp9WA7sgo1FrdIUgLGan2bFYwQiSURkbo9bg6/kUrzEHVpc?=
 =?us-ascii?Q?jvcVgJQhO/Ew93xBRwiHuqwtO7O/y+6jwx/FGzBZNgitA/n0uIT0JXNkzSIM?=
 =?us-ascii?Q?9tY9wdbdcc2Oqgv6b3jxgIq/iRTuVvaH75O9NLb4DO2LFOy+I7KDv562E2Ja?=
 =?us-ascii?Q?oQzvO+MTB+oEKHxnNfpJsgKrK7r4MkS0R0Ucatn5Mbf6E2zPRBBVdAfujWH8?=
 =?us-ascii?Q?ZrwzaM9mfyf+486H2OlZa9rpwS1WMz+yL0WTUQkJRAkjqHHVMXvKcpvS4NQ8?=
 =?us-ascii?Q?blhRXK1yXIB7IWP19p1CZFWplXdb2DBVgpKCuLtRaoMLXquYGjWz6dogwXoX?=
 =?us-ascii?Q?ynQE3+KW+YFl9SXvE3M64EKXH+/gXNcWCdic1K2PFuWtja0RSu5nQ0YBrXQK?=
 =?us-ascii?Q?ytSMQ7/C5jgPBQH2U1Xzpeo9g2C0pPh3WuxsACUDR2hNF+kxWoUREcjTg54p?=
 =?us-ascii?Q?zpUR9LqH1gognt0y2FcrNcZ66NfDOJTaOq/SKTbAmLlfvD3KgjriU+cwsq3L?=
 =?us-ascii?Q?HMJqsWB7aleXl8Le+3vn5MUBZOUE3eHsk37wKl7U+OwDha8foEbeXFcThqCR?=
 =?us-ascii?Q?Oi+6dqbZIJuMAwq9sAAq96FOXNThB+E=3D?=
X-Exchange-RoutingPolicyChecked: os+fQqIL1vu+vPaCMaqEiSv+fhCdQCiumRKNKhCfDx8FLfy13YQoMViG/hvlAhsFPimqYyBa44kFUU3bXCS+C1n2yeEwxkXyhN4TKjaqz54/ckFv3Ptx0wHV4CwTEamZgyORZICKQEvyd8dZzI6rsdoSbGQ1DwTR3w3RzPXWZlbYQ7u14NmbU/wHcLNthW8ddqPLOG5DUCha5uu4rlFuug0+6mOxNvWFM1AAD24HD0Kqk+Uzr+zCw8kvIOSqiKwsd3GAMQ1c9+HfMnV5U31G6yeirsL6XaVAzpNdj4A73usse2zNZDt4BGpAlML67f/Q3+LKSFkFJZvJChZXe9G+og==
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e765b7-76e3-4a25-bd0e-08dee1cdfeaf
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 17:33:19.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7m3YrmM5CsXlLCHcgr8Z1fghFkBP9H1g6BEonJxcnPPYaH2exyUo2cB+V2kBczZVuT1QtRwcncZm71ryBbKwEonYd4AttEX2V32PSXs0Z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6842
X-OriginatorOrg: intel.com

On Tue, Jul 14, 2026 at 10:27:01AM +0100, Ahmed Tiba wrote:
> On 14/07/2026 03:45, Alison Schofield wrote:
> > On Wed, Jul 08, 2026 at 02:59:05PM +0100, Ahmed Tiba wrote:
> > > Move the CXL CPER handling paths out of ghes.c and into ghes_cper.c so the
> > > helpers can be reused. The code is moved as-is, with the public
> > > prototypes updated so GHES keeps calling into the new translation unit.
> > > 
> > > While moving this code, also add CXL CPER section length checks and use
> > > spinlock_irqsave() in CXL register/unregister paths for locking
> > > consistency.
> > 
> > NAK on moving and changing in the same patch, and esp in a patch
> > whose subject only says MOVE.
> Hi Alison,
> 
> I understand the concern.
> 
> I kept those changes in 06/10 because they address pre-existing issues
> reported specifically against this patch by Sashiko, and I wanted to avoid
> carrying known defects forward in the series. I did this following Boris'
> feedback to address review-reported issues in-series rather than carry them
> forward unchanged.
> 
> I can also add a dedicated "Sashiko findings addressed" section and update
> the commit description to state clearly that this patch is not pure move.
> 
> Please advise your preferred way to address Sashiko findings per patch in
> this series.

I think you can address the Sashiko pre-exists in series without
them being hidden in a move patch.

To be strictly like Boris seems to be asking (fixes first), do:

	add CXL CPER section length checks
	use spinlock_irqsave() in CXL (un-)register paths
	move CXL CPER helpers

-- Alison


> 
> Thanks,
> Ahmed
