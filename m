Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F11F3B85;
	Tue,  4 Aug 2026 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809826; cv=fail; b=omyQ+GDSQ7exsBRSCfpJMogDb8xoCAVeXEwiRwfFCHeWE+YCuM3xT06n8FpzgH1zQWaX1cUyZIxg7d5VvkwzcmrhKUJ7Zoeiitlcl5IpXDMT5qWsDWCznO7NXBdWM2s3GoqWTQQ7s92hoPT+YhAj+gVUtc4ndh5BjRCfpwQhaoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809826; c=relaxed/simple;
	bh=vKdV3HmBcUZiEtkuMMTeJqpjwND7C8TuttwwiYJ2ycY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lpjiNiW/iikfqG/zkX7M1A7aA52QVJQX6lA37QX7sHNhLYMqnkqzSUX9drQSKsreaCebfKsUi9SUPQ2KXrsvw+0Q7SwFEo9JHXr7/R1WWF9knTxV7VgAbAJzJ6csrAsNswdpfBeFAD2ffY9tX/qvcK2aZwXiIzMiQHIBiY0fnpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXm3z7Zk; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXm3z7Zk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785809824; x=1817345824;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vKdV3HmBcUZiEtkuMMTeJqpjwND7C8TuttwwiYJ2ycY=;
  b=nXm3z7ZkDCz0XguAJ3N+mOjX5hMZnE08t0wn5WXVCquwjmwjuk0n0yyx
   HJc3JvBxqt9Ry8pA+v4ZVTu7jFOJqDCjBt/6C9ZOwh9l2nb04WHal/lyv
   12KAbTpnDQDbFfDFvBbVX+oXCELY4LYjscqxAbErBlqUhVwLdasdqIHwP
   mdjle7D4T3Mnn5LwMWRbCeJLY3oPDr5XryqXQd7V7VQ20DaKPgjhVx6TG
   BsMiTEbBJwGSh6ZVf4DT38CDVVOhI//+Y4qxHUeMjZ+bpOVUp9mNH/e28
   aBD9zkTRm7k1wdR6eE1il3/EU1PIfRsdeM1rav/3tccXpCnoqE4hc5Tne
   Q==;
X-CSE-ConnectionGUID: bxBwd6eHS7iigTRQQnBrcQ==
X-CSE-MsgGUID: DK7HMg04RUiis/grlnwnMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="97006320"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="97006320"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:17:03 -0700
X-CSE-ConnectionGUID: 8F0/zc2HSsWLrMpDjerDsw==
X-CSE-MsgGUID: b/jdn+ANT+mGTXhifZPaKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="261965223"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:17:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:17:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 19:17:02 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:17:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPkYS71ckTtYrSuYeDiBEgfq26paRB5Ew1ft7Sbw6O0dxmRrge+GcHNxmnkWH7crvaFLPwsNjlUKJFmQ2H85CRSFkQ1s+eYdScVdgBQtfyCHteAH2VA4tHdbnrJNgAieHx/J20z/spqy2K7HxbXVVGhhXtxx2m1YEV8htKqN8ObmVvRP+BLU1SVaXdp07qVTVjEyg3a9Vd/HYAfIqEzLqr/YayAkNwffDpw+lET1AZPvolU4HnrjEU1J8GY8LaGeSvvbQY2Vt138noBS9x+DwczF3hWVY/o5DfzJ01g07nLQluv0YX9ezdPLBofNk3eh2+Uhz3KkixvZzpz1JoQg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNigK69YfTxcXd71YNQ1nf+gdOagVjmYp0BKAyGvB+w=;
 b=QcBApYqjtQrMhMw5CAm1dsGGfn+qzAZeok9nwHuRyV5MnV8g+jfn9gKSR/8lHJLZYEr1DcvYVTBLz7BZXTNIK84THoMxns/HrizNLYWvcxRVP6nEjnRYR2mH2kp1MbmqIqoB3Vsw9EtjyfuYXjv8oqiYFKo3mNGzPQ7ZjVF/mSP4LRC6WkLtWWz/CBSxOai2c3T032fpJzNXKquPQxGq2nJpvRIbMYYhsDxd03NV8Qa2SSih2FWueBxWEaExYOxfKvOBlbP4U7XlBbDb1Kicu16Lv1clSG80gEYKelgfeCFhWGhawrRkL7UrcMi/vqloF1u4m+m+YC7LBEWE+mPEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB8173.namprd11.prod.outlook.com (2603:10b6:208:44e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 02:17:00 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 02:17:00 +0000
Date: Mon, 3 Aug 2026 19:16:55 -0700
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
Subject: Re: [PATCH v19 09/14] cxl/pci: Thread port and dport through RAS
 handling helpers
Message-ID: <anFLl_mjM86RSrgK@aschofie-mobl2.lan>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-10-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-10-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: a748f1a4-4e70-4485-521e-08def1ce7738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7NBlNWmMG5WaufTsPcyQxPkNr1fiXjE0202z/2hLq+D1lnhhq7Eu9/b6Y3drauKHpKxLeAgNSI8uKAkZk5CdsivRIGNkBsre45b+FzhKfFNAcUVzKlw4htnumjNJ48LBnUGD/5c0CGNA2md0mGeWas1Hh20Z2Z/g3ubAB5cmeFUt2eqoeoWgva38eGwlR+0foMXXoOWaGU3qaBfZ+uzoqivAOANH9phvzMJKCfDQ+t3SSyCalvkYyRnJyNyAlJOtFD0ahnZ0zv0sg+mObrfwvPzhM/TeG6CJUlIt4+4XFy6/9QqL2G+xD8H3TzMxPG7Ii2ljNw62JyfaLb9FrgdVWPWrZCBr2oajlRYNJtf8bbvun1v1xQmSWlHCN3nIv9X4Ktn63R+f3fk2ZqWvMzBqFocPCkWKVhFVVtFNKXMtslXE0Bbq73F84LIl6vVVjHJG0DQ0LIjBAz3v2ZYQkQHEgrJc88yHjavMMbSFSJCEM6yQ4PL8bX+W7JrpVoRPtAIJQpqSrhwxtCp7fFOoN5XI/eGu/6oGzJPnFcxIFj24B5SnkJoEhjxQ159Q9P+s4LNE1UkmuAUizi5Q9AV8fi+gxosNkuvv/VzYMXwIVR2tHoT1/hTCr3i3Rr0NiBgLTILHh/8AnH+uHSUJyZimYRjNnSsJEHwdCbX6FlopeM/TEJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OZFX7zdYhUt9jSdHWXmLD8mnojojyZQ8axH0bziptGvprZ7oFn4U0F7nC+PM?=
 =?us-ascii?Q?bITgSsCfyYCHSGYp8yU0aEhXsKv/1RXhwNgbKYiStzXo/h9LZ+3IU5Z8ravH?=
 =?us-ascii?Q?PDUEBirv4vb9yaWf8wPxRVW3YBpNl8F+JdxYQF12Qyf44a2hKfrtMSDQXFh3?=
 =?us-ascii?Q?CWR4GtprmjRaOLszd5YdNCYAJYecP9IPHxwnP/zhu0TvKggblaQd8t7SqBmz?=
 =?us-ascii?Q?9hOWjF8YixK/V2uARbQ6VcMusCwxR4dvlODcNr3YuQ7HwpmnGxyxqcqjjul1?=
 =?us-ascii?Q?d/C0DWv8OQdejGtfNErqSPcSp5x5V2/fDoGEy9mY7lGRfoWTBIwASGUDLAwd?=
 =?us-ascii?Q?YSiayHKbk5uOXmcEpc1IgD+AGdnBpKycpdlcedNlz8WQV++0dD6HOxk9LOgW?=
 =?us-ascii?Q?qOAFY2QnDIgom+tKcLv4WqZqi7TinyLfoka529z79L68HT+lFQytl0xVdN4m?=
 =?us-ascii?Q?JDXjx99RVuS24KYGzl16/HAXKOvonsO5qt4lX4GCm0sV2mNeC4cYYzCQsLm3?=
 =?us-ascii?Q?6pMR//L5dp1puUPaYzHT/Ex04Q08scrGCnPoQPhR70XZmTTZOUU6RjjS2KR/?=
 =?us-ascii?Q?J1aGFF+G8EP1ms5ZLmkmuQQdd62re4V7BrTLm88kpmgPfDCaS7nuTyyWoZ/T?=
 =?us-ascii?Q?V14ph8u3YwzHdjzil44ozgCdXxn9zbQKqnfvBk/PgCnE4TKnon5+7HLVpAFx?=
 =?us-ascii?Q?aQ2OUEXLhh9K5so0gXWr23MAbqsMyrWIUZorlUyE0jjmRY6xAQH6H+XIklaB?=
 =?us-ascii?Q?mamBRqpi76XqXrKdHbGxXfbzdP1kVAUd2xAZ5aARzP+RESQn+cGS6go9RXlG?=
 =?us-ascii?Q?4Br4Nik73HHYfgFUhHKfBGwaDzWbrtzjuYAWSHe+IHDCFMWVd3xx5afbx+LW?=
 =?us-ascii?Q?ax3mRMLuKB+gx4ay1Hs4IENsVNTVr9YJfKL9t9po7JPJPC83pONWJkA8EAuC?=
 =?us-ascii?Q?avkBH9arDtcePs+DTfG1u+Zcrm7d3jkDz2Oxl47vJML9c3PAYAlDGck9DXlk?=
 =?us-ascii?Q?jNeh+9AfqEVk9pe7hI/faFtcfT5yY/76X0x0nDFdo8ss6zlSBGMggDoeuzMw?=
 =?us-ascii?Q?zLtnAI7RCth6j6CtER9S2wN86u2Ty1AU7QkFpU4JoNIA9MVzUpkq5sUfVKNb?=
 =?us-ascii?Q?tERQtAdiRXgpK9kOKeI9EPC8i8vffZByr5KGh5YRLyKqFrZZvgHeLJzLIYM8?=
 =?us-ascii?Q?B88QYA6C3roLFLy2taDI/J3H31gFjlsKpCtBwqBFJv4fnm4c+gXJBXTycq1p?=
 =?us-ascii?Q?iR1FsYWu4IrHmS7/Dj7tYjYzhIlTUTyUbmv8iZqzf+X/Weqgti6Q8IitJ+lY?=
 =?us-ascii?Q?zv1PQJ8Ovb3W6/f+DgdozD3C6ecvJslAt+fUJvvzc4t/FwkkZ6EAt5gbADdV?=
 =?us-ascii?Q?5/13HVmL4MbTsPWB7QIpB1LJZoNKMIBmR3mgfzc2B7qXPH8sdFs8Qn0/bVbL?=
 =?us-ascii?Q?7WEaeOXBbre5vBYpvIrVxetWWNz/issfWn66PoZSo5PXoy4aZiUs0G0ysB1p?=
 =?us-ascii?Q?8ZN23vvTayCCKZVN0kYwrSS1YXekHxPe9cLJI+D1yC3302Y5jCFnqjEucpt8?=
 =?us-ascii?Q?PshAZI40vmlTRkZPFzLPFgd+VOPRn3j25dCfsM9eygtIVKNPaHTp49gEOzE+?=
 =?us-ascii?Q?uV0b29TELp07y4H3kyk/hQ7YqRw0yyguhAbAJxzZQFxmdNNt7VhpxLTCncDr?=
 =?us-ascii?Q?0k3ZDPqvn9EsSYFTYvLZ4g6yAqIAZqMOkON5EhcS+bj/J8KoGQQbkx0z1hWv?=
 =?us-ascii?Q?uYazFQ5fAg/gghO2Rr5QB9dspubwoJM=3D?=
X-Exchange-RoutingPolicyChecked: ZONZhhO3kpuVHm4ORO14gvy4NrfO9f19ZJVVHiAJHRqcMv7kYVxxDMIvdIc2yIUHMXHL9DsV4vH178bp2mv3qj49HwYINZyLPRmfzAk9hyd1ZcXw6g2pQfp5qkbcjoUilAnF0x4mrWaHcl00tYokYTEqqkZH069ZP1ESQLzG4T0n2wiyjoQP7TRVUy/YPEbAHZcYNu8KUW0Xxs8oCrOg81YlrF2ZXDUySKV2zUtpUAGNLpXdxWmpyxGsrsD8iS0pKSmD/uiaGnG//jtuBfRhru5jzlMNOdjI03EMUJKAYJxpZRJvU39mPTW5Rt6bdrpnSD5ywDp9X4JmN4sbyxJmnA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a748f1a4-4e70-4485-521e-08def1ce7738
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:17:00.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tR4PbflMrQcUU3++8VeIJ9lEtVXvGecirwtCsJG4oJqB3Kr2Cep6DpCsHU5uGrpRl1+plN0Xw3MmPQ37x9SBlpdCF9q7p6cqRpXyP3wm/bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8173
X-OriginatorOrg: intel.com

On Mon, Aug 03, 2026 at 05:18:05PM -0500, Terry Bowman wrote:
> From: Dan Williams <djbw@kernel.org>
> 
> The callers of cxl_handle_ras() and cxl_handle_cor_ras() already hold
> a struct cxl_port * and optionally a struct cxl_dport * for the device
> being handled. Passing a generic struct device * requires is_cxl_memdev()
> to distinguish Endpoints from Ports at trace emission time. Threading
> Port and Downstream Port directly enables is_cxl_endpoint() and explicit
> dport/port branching for cleaner trace dispatch.
> 
> Refactor cxl_handle_ras() and cxl_handle_cor_ras() to accept struct
> cxl_port * and struct cxl_dport * directly. The CXL RAS trace event
> emission logic is split into three branches: Endpoint events are
> identified via is_cxl_endpoint() and emit with the memdev, dport events
> emit with dport->dport_dev, and Upstream Port events fall back to
> port->uport_dev. This branching is transitional: the follow-on patch
> ("cxl: Add port and dport identifiers to CXL AER trace events") unifies
> the trace events on port/dport and removes it.
> 
> Update cxl_handle_rdport_errors() and cxl_handle_proto_error() to pass
> Port and Downstream Port to the refactored functions.
> 
> RCH Downstream Port correctable trace events now report the dport device
> (dport->dport_dev) as a consequence of threading Port and Downstream
> Port through the RAS helpers. The following trace event rework ("cxl: Add
> port and dport identifiers to CXL AER trace events") adds explicit memdev,
> Port, Downstream Port, and host fields that provide full context for all
> device types.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
