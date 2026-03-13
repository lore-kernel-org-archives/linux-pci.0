Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B85E1FECBA
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773431781; cv=fail; b=p1PwnhbJx0yli0yN3Tj32gVEnDc0QERjUI2Q4oqqR9dxOXv1ocHHiDszacdbJ2K46NclKV5HueUbThJY/fAyS1B0+0c1ufPAs5U9ASEjp0D1LP3826ukqrbqHnMJQdSJ1yaADNEn+1/ldDBKS68kZLHOr/Frs67QmcK9mdd0p6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773431781; c=relaxed/simple;
	bh=IOgpaUisqVDzelU6dpR9O3mjtZNU/U8CwzrDsqZ4r4E=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=RiAalQPG2LcUgvvntkwRcZLwN5G6p8Xq7N3ORIGAPs8ABJN29cxbDqUlfau0la+E4uZ5TtmOLD+Wf7w43TWzy+WfHUNz8aniuAvmNrZduz9PRzulYZgUWOiRTqNB2mZ9kULsZj5kFn4FcKnKgJWKfRdMr3BqJyk9jygdBvG3gtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVH1dUvS; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVH1dUvS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773431779; x=1804967779;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=IOgpaUisqVDzelU6dpR9O3mjtZNU/U8CwzrDsqZ4r4E=;
  b=jVH1dUvSyM0B3QzXWYcuZjF2GTiJclTE16PR2kV4Jhmsc/Xc4LXIVPCP
   BFrE4iQhKYknUafL6IahujPLh8ZoxRO+ZxHjl/KiwkpxyQQ6PubWEJqb+
   VQDG6U5gJi/IB9fOxfyutS/eZw2NFZ82mxoKlnIKI5rWMuTCZ7g9tpo1M
   CWpD32w+3AjJczLXeKCsrQg01LX6gRueEGrtBJLGiBdQ4syQJmXrmpDIE
   MNp01gR4aP6BPVeezvZE2Y/kviHAZTPRLMT8njoC1UzFWcY6/hvDFVRhi
   uUdJEzGlbMXREXD21Geo477qvuBtGGyVO3lqoAMIUhFZ3mD0HivL2JVto
   w==;
X-CSE-ConnectionGUID: uHE5smd1QvqF7J9WIGL5nQ==
X-CSE-MsgGUID: u6xcqnQrS4iiLr1dHf7FPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74247074"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74247074"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 12:56:19 -0700
X-CSE-ConnectionGUID: Hgmg3dVRR4anGiHm5TTW+w==
X-CSE-MsgGUID: xvmvqWPNRYqd6NibVp/SDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="226256812"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 12:56:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 12:56:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 12:56:17 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 12:56:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHxqyX6ur9VJsadSCUVOBB6gLDTS3k3BMDCBW6oL60NUgH3W7pozvf11GLgyfme+M6MoI6AwATjPKANH2kylwWCYAqfBJKmie+xdrsV/9JCAXqowE4UGl9g+a7mD4jsWX95qRf2KbkV5OvAw5e4huRhP4cH24599/rhOLfGX7No5nK5gHGtZYDFrj6F8IMVzbgaPBu4eZzGkV2r1WpOOBmsMUTY1lk4pXuakvdAmxPG+KBwu78WQ2sXgcm7TRKYgorkotRV3Wudin+H+kaJaAWBbEvLWVeYh/DVgfDetxc0zD/NYTucjjhG4W7WPG1SP+Em+duzAUgmQT2wwQkP9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vmK29WaSpKbOZyvdjF7Ten4lxBsTZZxtvIZGN+ZGlA=;
 b=KTanguXEIdtSaITu414ESXKrzWvQJhlZh7J7thyg28Ar3hfyG+/IVXWfzbS70wnNzSSBC4ot3uv5V7yqrpqnGEbzjwSdcV7TcvNmI0mHlVzIujadW/3Ym7lg05QoRZd6XkDuykUldTe2Yexv/9zaXAgU9LJuiByYjIAF3sDHsnrEj5RKMVwzzyQbbM/2mO2oUx7Qqwwff6EuY71ZOh708QIX/PpqDGAy9/aD5jKvjezUy4zF0gs9jY9VqpCI0Y0uBvk74Hy0nNzRxxprGqqlXtl48Zwg0mPx69CmvywMCqBkCkf46nG8NUqNKxkADRFczEkwk9/qpKfjOIgNJ8nnqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8345.namprd11.prod.outlook.com (2603:10b6:a03:53c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 19:56:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 19:56:09 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 13 Mar 2026 12:56:07 -0700
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: Greg KH <gregkh@linuxfoundation.org>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<lukas@wunner.de>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Roman Kisel
	<romank@linux.microsoft.com>, Samuel Ortiz <sameo@rivosinc.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Message-ID: <69b46bd7935d9_b2b6100b7@dwillia2-mobl4.notmuch>
In-Reply-To: <20260313133235.GC1586734@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-4-dan.j.williams@intel.com>
 <2026031230-mastiff-create-7593@gregkh>
 <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
 <20260313133235.GC1586734@nvidia.com>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: f4238377-08bd-4946-66fe-08de813a91f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: J4VpSpyh9Tj9H3UwID9bnlon2EyRXxCsEyYvSvnI53zBVn5MLawDEK7krDuGrGc/icsz0RGKBs4j9TKXc2Df6j2jRqCd+4v99jRZJsMXUqVQnZWDB/vTlsW5Q6v4zcNsqlvOjVbS1v0/CeuvKaWyxuHJ45XdK54MbBr2zc/NUctUEznEBoEqrM4GxvMWfs7gM3ez+DqwT9Gr+3qkeF7DIWVrChVVrd9O0VkVUXfBqiRIV/VYetufK3PhBp21qgwNTd/P+Kgey3mU0GbwI02+ohMB9aZUauh2RvgoPXb+ZTDNNrNFtQ3Yl3XKVMVGksswGwcqC7Ddlp+66/Bkbe5f64U3ntrKI1lkYqxgltFtJk7fQVgX+MwqiyBXefTc9L1Cbg8o+EKtT0f+RTNNP+kgXkTdI0WV45ARc3pYh2PcTDOwZ8g3YCJ/dppejroEvqAkAud5vv+N8hri58/HZXr22Iqr6/BO6urtc3nJ9Z0DkM4nYH/sYE5gAY8/UwPDH2Inc7h5gZTP40ey45hnN8ZEXIWdsebgvGmhHIxRgyOpe+lkecX3eDUKAGlH7zhx/ZwAvLQptH1LzlytzEGUP/bndoI3BEPJ6v3UFvSgEF/lrjmPZCeLJ2bw1cJ/JuBWTIns8lV8IQAgE9c0lnCN31pWReWNz/Rai4sNkKCy8bThB34x30VVcIQxI0p+D+4SspUZB+KS8EzC2S7bWYlc1Dh3sW9j4B2t+yz4UzK3NcElCP/JL7o0CN2sNUYM0RgbQ47e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akZRV0FjU0taZGtrNnVxMTl5UVBnNHM5d01PK3Fud1IxME9BYW5Qa2htZU1T?=
 =?utf-8?B?MHVNRjRMQ1oxSEdQdGN5bmdHdk1RMjEzTlF3RTl6S01HRzFCY2QvLytwYllM?=
 =?utf-8?B?a2d4ZlBZMU4zbWpxT0U3YlpmY1RkZ2Fla2Rrd2FHZlJoS2NwMlhFbEttUHlR?=
 =?utf-8?B?dGhHVzhrQm1Qd0dNSlpWRWEwRk1DeW9nWHgrK3FTTCszamY4ZU40aU5sM3ll?=
 =?utf-8?B?cVV2SUFwK1NaR0ZHZVZwcXlnWkhlcHpHNVpwWEJVdHJycjU5QmJzRjFWaXNu?=
 =?utf-8?B?VWZSaFl5eGRUaVFENDJPOXZkempYK0duVzRYcCtGclFpcDB3cEkwQk9mNUU4?=
 =?utf-8?B?MjVLZ1hrc3F2dnloWUxyUGx2a3BkT2Z6aXFwNTZVeFVxRUNWZ3dFUTFVK2lQ?=
 =?utf-8?B?M1VvUHozT21IMG90cnpHSGlGV3U0cG5sdndZSmhMVUxYUVNwNFllOUYwKzYv?=
 =?utf-8?B?ZURkSyt1NUNqU0J4TVNCQ1pzZk42Q3VPVDNCS1lmUFB6NkUxOE9nRGNOK21a?=
 =?utf-8?B?T3I0UkFhNVZjV0FKaS9NNERPRFdGaUhMNnBBaW0waDVBT0VaRW5EQnRqaEZR?=
 =?utf-8?B?V0pXaUMxdUxtb2JsaUVxNWp6c2JRUVFLVGdpZ2JOa1JtUlFzTVo2aWs4bnFX?=
 =?utf-8?B?M0cydHFoaTRZcjVmZ2h3YmNXbWNFckZmcU0vV1VUVWpMREd3NGhzdkJZSDNR?=
 =?utf-8?B?QlBQeGR5N0pYT3RsVURoelZKYmh5YmV0YUYzQ25zOGllcHpXMTl4NlM2cFlz?=
 =?utf-8?B?ampTMnRKK1ZTeWNGRVlTenlaZGw5Tm5ubVZZdE1sYWNJTGxHOCtYYTZjL09T?=
 =?utf-8?B?VVIrU2dYdkJacWJvQWRQVXZTRlFqalJTajBBN3J5OU9haGNwNnFLckpNT2F1?=
 =?utf-8?B?NS9JeGg4aFVNdXY0ZERFLzgzYTI1OUYwODhLeUxVWllpNWF3NFFNYTY5TlJO?=
 =?utf-8?B?T3M3ZEY1Zi8rSURzeENRcGM5bGtHb1NaSEJTcS96ek5yeGg4TFpJNFhLOWtm?=
 =?utf-8?B?Z1A2ZVk4TVcyaHpFVFFkT1pxRTl1QzF6ZGtXVHFJSjc4dzVUZG8zMEVJNVN2?=
 =?utf-8?B?bUZCN2ZDRHA1NjVzbHpVRW0reU1KTnlHQUUrOWxLclhTaFpycGZRQWpDSjZV?=
 =?utf-8?B?NHN6MHk4YnFNRG9PRWtjQjE2UXhTNWd1dmJKRjkvVm5UV0V5RzNXMVhoMW0r?=
 =?utf-8?B?Sjk1ekYvTjNpc3lJL2xkUnZSYUxIT2ViSHh2eTNDOG15N1FRd0hKWGdBbUZp?=
 =?utf-8?B?bUk5SDFVVzVGREFKL3BzTlBweURRWVJEQlkyNEs5OUlQVktjYnh4SkdBRFpK?=
 =?utf-8?B?TXZlejB6VnlzTUVYZ29ZMnJNMWhHQjh0WVdaK3BCb1VEN1dKQ1YvYnpUQXU2?=
 =?utf-8?B?bG1sOUFCOHp0Vm5FTzRiQ2ZsMG8vV3NCWU9weGNUa01YSFRMc2p0WVhURlZn?=
 =?utf-8?B?RmhWTVR1Y0NlMEhVL1l2dTdmbkM4aDArU0F4NGhUQjFOZzVKRkhKZlkreDRW?=
 =?utf-8?B?YnZCeTNYakFWZFRaQ0VQWDVFRTlUNDh6clhGQVI2VDBFZ0tRTFVrNnY4Z0FD?=
 =?utf-8?B?RXlZWWRiWFZoVkQ0eHlTaXE0U3luelRXZGxCdFlKYk9OQ0p3THBzQytYdER2?=
 =?utf-8?B?QmltRnZQanh4bi85S29CZ1JSbGUweWc1OUEyNUozZTlxUUxCUkVvalhFZGZK?=
 =?utf-8?B?L0N4Z09sWnREK09ic3JiOXFsSEhmMjlqZVNLL2V1bmdGWmY5UGNoUjRnb2xz?=
 =?utf-8?B?czNkNXd4UWw0c21LdHBoN0hjVHFzU1ZRamNYektreml2eEgyUm83Wjh0Qmox?=
 =?utf-8?B?QUxTV3ZkY1JuMHNiajNQeUJ2VzlUOXlOUUJLWkUvNXdpSVRabHljbEkreit3?=
 =?utf-8?B?L0VUdC9YRVlCVzBaS1VCa0FIWnFwL1RUbXBrMzAzaHcxWnhaYk9DdkMvcXE1?=
 =?utf-8?B?NUQ1eGRMcGVveUM1Z0VVV1dVSzdzQ0hYeFZyME90Ui9iWk52TlNuZVdoUHZo?=
 =?utf-8?B?L0QvcGxYSG1ocng4cmVRRm9kYVBieUF2U3paa3AxRVZpRlp6MElFWHBRaTYv?=
 =?utf-8?B?Y2lPZitBczNHLy91dCttdUFSSVk3eEVjQ3N2RWpmT0syLzZ5N2ROb3I4L0J3?=
 =?utf-8?B?aGZmZkJ3NUt1UXhoSnZQNVZORTdQVitsUWFKMlhzUkV1QS9IN09raFUwQlBq?=
 =?utf-8?B?ZjdKZUhUc0lSSFpTSkNEckpMUE9SZDVUV1VOWmVubTJ2b1drbGovby9BWGMr?=
 =?utf-8?B?KytBenN4eElzK0pkZ2N5b3Vvb1hKcC9pSDhZeStPaUtPRDIrNFRadEg2MDlt?=
 =?utf-8?B?TEo2b1oxZmVHNjRncUFCZWVqcVdOWHpKRUd4S1U3Tk16aUhXWHcwd0Q4MGdQ?=
 =?utf-8?Q?/dCvNLsheQjXen6s=3D?=
X-Exchange-RoutingPolicyChecked: vJJNqGeWPQla5Fi8MJ/6/HWlssPJYfjaZJTgI3xcREwKWw9I129Hz//ur5xiCqqmAj1LThw4pcCm9NwOCAgJfqlgjoi80kc+riqxcYCPakXWOmlaOJ0m8P4BT66ApxmNBJQtQmj3iAomVnbMlXY/5ia2lHldfbNfG4FC3UXmbM89Yv/dwkuPS4r2RlO5Gal5ZzDN3VK8/26cc2+iKZsZQmqow5UqU3ZIMGT9+KR25fPscclpPcoha7YpeIleJTLvtVTuhgGivpQPyy6ZwkZHMptfxQcaDY19PM0sywrN/PYNUPny+mMH45vFrFupV3nwbx8Qrm6CenM7B8TYQceo3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: f4238377-08bd-4946-66fe-08de813a91f5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 19:56:09.1672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1nkhA4TEV3On5piJ3SvXNDfC8gXsDoc9tL32UqH0lV6GbEso7c2UAoViLbIqkZEqrQfOEy9GodeI6F8bkH67frrux/4rM9ILmqYwbKpn6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8345
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Thu, Mar 12, 2026 at 09:11:32PM -0700, Dan Williams wrote:
> > Greg KH wrote:
> > > On Mon, Mar 02, 2026 at 04:01:51PM -0800, Dan Williams wrote:
> > > > An "accepted" device is one that is allowed to access private memory within
> > > > a Trusted Computing Boundary (TCB). The concept of "acceptance" is distinct
> > > > from other device properties like usb_device::authorized, or
> > > > tb_switch::authorized. The entry to the accepted state is a violent
> > > > operation in which the device will reject MMIO requests that are not
> > > > encrypted, and the device enters a new IOMMU protection domain to allow it
> > > > to access addresses that were previously off-limits.
> > > 
> > > Trying to mix/match "acceptance" with "authorized" is going to be a
> > > nightmare, what's the combination that can happen here over time?
> > 
> > I do think Linux needs to mix/match these concepts. "Authorization" is a
> > kernel policy to operate a device at all. "Acceptance" is a mechanism
> > to operate a device within a hardware TCB boundary.
> 
> I'm not sure about these words either, I would revise your table to be
> more OS centric, the device can be in one of four security levels:

I like this framing.

> 0 Blocked and disabled
>   The device cannot attack the system, enforced by the OS not loading a
>   driver or mapping the MMIO and IOMMU fully blocking everything from it.

In terms of details I am trying to think through whether the device
actually changes its ->trust level in reaction to a driver attaching, or
whether the block and disabled state is implicit in not being driver
bound.

It does strike me that this value could be used to convey whether a
given arch's IOMMU driver indeed arranges for devices to be IOMMU
blocked while driver detached. In that case you could see, "oh, devices
are not DMA blocked by default" as we talked about in the ATS-always-on
thread [1].

[1]: http://lore.kernel.org/20260128130520.GV1134360@nvidia.com

> 1 In use, attacks from a hostile device are possible
>   A driver can operate the device and is expected to defend against
>   attacks from the device itself. The IOMMU restricts the device to only
>   access driver approved data (no ATS, DMA strict only, CC shared
>   only, interrupt remapping security, bounce partial DMA mappings, etc)

This is a better way to convey the current "force_swiotlb" settings that
TVMs deploy in their arch code.

> 2 In use, no attacks from the device
>   The device does what the driver says and is not hostile. The driver
>   does not have to defend itself, the IOMMU can run in faster & lower
>   security modes (ATS on, DMA-FQ, Identity, still CC shared only)
>    * Basically our default security level today
> 
> 3 In use, no attacks, and access to CC private memory
>   Like #2 and now the IOMMU allows access to CC private memory too.

I am assuming that each bus implementation may have a different way to
get the device to the various trust levels.

For example, the uAPI for PCI TDISP requires associating a device with a
TSM and asking the TSM to push the device to trust level 3. Another bus
like thunderbolt may want to imply that "authorized" that uses challenge
response (tb_domain_challenge_switch_key) enables trust level 2, but
otherwise only enables trust level 1.

> [*] I'm inclunding all attacks with "hostile device", including MIM on
> the PCIe link, compromised/fake device, attacks from a VMM through a
> virtual device, etc.
> 
> From a CC VM perspective 0 is at boot, 1 is an out of TCB device, 2
> doesn't exist (without TDISP there is no way to keep the
> hypervisor from attacking?),

Yes, no mitigations against spoofing the device interface without TDISP.
However, I would also assume that level 2 is the ATS-on trust level
outside of TDISP cases.

> and 3 is a full accepted TDSIP device.
> 
> #2 can happen in bare metal where a OS may activate link encryption
> and attest the device, but doesn't have CC private/shared memory.

Bare metal would still need to figure out how to send T=1 MMIO cycles
and check with some boot attestation that it can trust its MMIO mappings
are indeed targeting the device. So let's say trust level 2 is
everything but private MMIO and private DMA.

> From a uAPI perspective I'm not sold on having two bools, I think a
> level string would be more flexible. TSM and CC properties are
> orthogonal, except you can't select #3 without the TSM saying it is in
> RUN.

Perhaps the concern is less 2 bools in the uAPI and more the concern
that 'struct pci_dev::untrusted', 'struct tb_switch::authorized',
'struct usb_dev::authorized' and this new 'struct
device_private::cc_accepted' are getting convoluted.

> Internally we'd probably turn that dev->trusted thing into an
> enum and teach the iommu layer to treat it more dynamically.

I will take a stab at some patches in this direction and at least
demonstrate how 'struct pci_dev::untrusted' can be merged with what CC
wants to add on top.
