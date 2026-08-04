Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C4035966;
	Tue,  4 Aug 2026 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810654; cv=fail; b=aK5v81PNKrYP8zrDLd/fpoq14lSf1sBOJK+E4EtPD5ShOrD59sHkU6O5QmeUBX6qgElNqaah0xorwEQcIUdgv/YEt3Wnd1hrelR64I37nMpGBPe0oWdJq1kgHaL8DjrEfAJ+JvN2wLpU/TgUFJCB5S0e5TLKRTYcxaAj549GKWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810654; c=relaxed/simple;
	bh=w9uo3LIu2vWlzO0sLJVNxMkMqX6LO2zRgYKSFAAo5Zc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UqKtDbyXmH9om9/heRuOVY6ssa/UtZjl3GKKnmX3hK2VFe5KHETnvDZawPwGMV6GN0loBwGRppCSX2Onnu9y63SRbeqGBbADy0+l8N7McQUe137z3a9Op8p8syXsnoS3ZcjbL9SxZWiXg5OlnXO6BlCIW1fZZj3WxyJDyQc5Hkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4GtfVAx; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4GtfVAx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785810652; x=1817346652;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w9uo3LIu2vWlzO0sLJVNxMkMqX6LO2zRgYKSFAAo5Zc=;
  b=Q4GtfVAxMAKzYxR6eG0A/xvbjozw2BF0JoulNY+eO2UqnHcfHMMA02Mu
   F2hEoS7F+EHxyR2NjlBEp4xwxMy2yk7PSfay2hQW7f/vZyRfg/+MkYo9T
   BAzYKdib/a9pmvb0jYnXZJSJMIeH/+ijOJk8wOTEmR9eANRcSBfgpaV9M
   PgYaod+nbfr93+wwy580aQXB/J9SZjm4fK+hs51Fem4NYq3W73K9i/BTn
   sKsz3SBd5MEEwkAkmPU0zdn5LBURClDF63kQev7u7ciwl6cwVxuT6qR62
   gLVVDcmdw2rviQ569CtxUlDLWRdVqJywOP/slOkF2CxrCxf3gH0oyo5T5
   w==;
X-CSE-ConnectionGUID: yMFSzOw7QsCxKwmgZCieLg==
X-CSE-MsgGUID: Tj23Vws6QjOnOLT2DV5mDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86386900"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86386900"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:30:51 -0700
X-CSE-ConnectionGUID: /NhB0+P0SnSmMpNeBQZaMg==
X-CSE-MsgGUID: 8NFNb7OCSzau/HQ5ZxQ5KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="299604678"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:30:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:30:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 19:30:50 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 19:30:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQUAMYAhSgdCp4BnD2Ep4eiKIOBUKdDYgTgg9I9WO1RRKDATVx/PU5W50PG87IennteI7hG1cHXVDS6OuLDjts6gPRZqAh5UnoGzsv7zb54AH0IcQJMUEkHDEosh0z7a6QVewNNBzMNnz013wPbYGJ56swtBVByMha6+ezdsgxnknuUKsM3ZZ4XwmjUUyoXTsJhH8x/6nNyMArVBNOUo05tho1ktxXgHl9iZdUGUiDKIn4sVaQ56wSm2hXT1vgaWBhg6AaCOxyGOyq8Rxu6T44ZZwRHRtBc0sRd6/9oZI4SEqMqUKrq0tQpNH4ihP5kSnvP7/G+srJsMQJajlxGC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SEDsuQqHJh7i1OsCfXjcJdOfswp8S3xLqfqsbkLjHU=;
 b=OkRGCKQeBQ1qDTBWr/IJhHk4VBx4yaYkrSu3YlxlL0p0im9XCC4OuHDzkPmOvTLeBISWMkS6V3Fe1iD4orJaMUej00rsmo8Mu/4szOPPaTgjpzWcen4ur3ukioHEqF3rmsygLbQtcxMfzvW8fulm3CKbUS3pKohWc7zvpr4eY8wm9t4GNqF78DzR2kgdUke7jG6woej1+OUwXx5u8AkYXIXCELXeI0Bd4CGjpEq38xTOLh0UVZtf6WC2CDe5HaQWvj99O1hHnMsLzbt8nJQV/jX14CukTTBpQTwXQxEBrWUAyyNZxSCIb3pqm9k3AWQ4jjWQekG0acp9v68pXoyONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ5PPFA0B9CD929.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::84a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 02:30:43 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 02:30:43 +0000
Date: Mon, 3 Aug 2026 19:30:38 -0700
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
Subject: Re: [PATCH v19 14/14] Documentation: cxl: Document CXL protocol
 error handling
Message-ID: <anFOzvK_PHcZnv3S@aschofie-mobl2.lan>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-15-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-15-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ5PPFA0B9CD929:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f6ea0e-0f4f-4ec1-64ec-08def1d06204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|10067099003|4143699003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YDcKmbJeJ9z+dlmrQmK4SgZiTR2h31OtG/kkuEVmkxXAFGeTuYpkshQySS8shYxNMntvLCY7JK28wwSZGVEzJTKABGfVZ/ZgZdDe7QAuMBISBnsDPvE2GZvJJuNF5A+RrqoRPko16S4b8eE+2Xgt5IEkFCQzOciLPyg4YHxq3Vs0Vdx9Ww9ZQUJ9qLXijwJXj0Mz9UqLwAzhH4B992YJUi33wOfEQoxN1SJjiH0K6D2oZIfDTR/MJYw6tfumLOtZeEGSWCCy9nXDikweyZn7Glzs1EtvZDvIFhljjyI5CszOwDxLbGn2074nUP4Xk6MwLt7no1u3uGWEt8kx9RGDBq9LYxvgZA+OcyICJiuPtrAxRC5LoCiGGTZZI5ejmPNqt/OpqK8XycRcRdntels8G2qoPgL7kwDVEZ9u3EsTAsSF90kfM+nHUwk9QuqNmfF6NWTAyoYodDehNr2gA91/oN4YoJwlunJ5IYjagnHdS354JqdtYvjL9j9CDvhCl8JAWzWGA7oHqIwFuFWm6YHmDAkcvYISHTtuqH+z5y9Ops+DgJO96N+EWeh9DEhO+I2bWsqL+H7gpzuYnFyUcypIWW8T78lH+L+hSVoGbTnDJJuXKHiglVgbo09gd8e5qljb0Ki7SpYCjmLB6/RHUc+s9q3UMP1T6W/yo+cgZTuSt0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(10067099003)(4143699003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p83QMMvxBYU2LbF5KZqh793QqBWGNmal6agYFH4cXmE8xztwNIRq7Hh1gYXR?=
 =?us-ascii?Q?DrfTG33aIA2m1+olXWp/sERsf+poEUByQRBU56p9sbhJDFl29UTEurjeMi/8?=
 =?us-ascii?Q?wK9EmTRFEGB7lqQ1k1ARzPAq6X6YaFJpMcX4TKSlzR/tW/aROxidC6PeOxZU?=
 =?us-ascii?Q?C6b2o0SdbDewHmQXrNx52pBNkFfVEAeWbduYEd3TGB8n3cMIXwvw5ZuddAwW?=
 =?us-ascii?Q?lU6uKBmi0ULuiU/eAeIeZJ0g7YjKKkMU2GVjZYe2igsnKAf6WNLBOrQeeeWx?=
 =?us-ascii?Q?7Z6o23EiLrbYKIhS4UX+aPfdAq/4NtUJ0sOW55bBVsBU6YO5keQ5E6HDlfLC?=
 =?us-ascii?Q?9AdLayiCJRGmsGlbuUEFRd2XRIhuyO1sejahGEKALjDxsfj+7YxneSiknan5?=
 =?us-ascii?Q?n2vGjdZCdEMYiVkAJKWkyR0uPi6dppKufXS3UwJf92/6eeiVwTQb0nqE61Hg?=
 =?us-ascii?Q?JPc8Ahc+SVtIbWR27vPFnI73kndaS7sS4H9uwVDfQaMgXlSRf0kyLlj65uEW?=
 =?us-ascii?Q?ud6rxVwRRazvlRPZol45hdYcF/f2WbdXmvJdA9KQepAN1zcky549MlibObX0?=
 =?us-ascii?Q?uMi+JceSBrsJ/cF7dNyPzQoHKZEq+roOoq9p+tvgsC8a8GOapmUXIIKDcy44?=
 =?us-ascii?Q?BBthdMKz30nhL8916VqhUtsoSRRcfm0nwn8OpTEgXz4h0thnM2ysZumHk5qL?=
 =?us-ascii?Q?yZqBP6VHU36ApAT2PleUWVjrpOESOYtR3Es7ZZ9+1zs/N8lhwMzqL0CsWVWH?=
 =?us-ascii?Q?oxO5CI/vqd2oFyeJ0k6aeFaTaWqYVn8ufTjm5YSXGVdAcvwaEDH1kPbvVrBq?=
 =?us-ascii?Q?lrJsfbvEcU3e62G/gevqKATaFNlmc8Mr1xHmqiyLOTXAlpEuNv7RRtRn3mPp?=
 =?us-ascii?Q?XdIFaxmBrKgA57uQgpDDpH4BkCiKAIgwZZFMc1DS815bgcCB6GDdFfIZyQ7U?=
 =?us-ascii?Q?hKsbUY/8qAE3nx0bQBBKrxG8pKrWx0QvaxDtnjJnSS3tjY/V00bfkQAul4YS?=
 =?us-ascii?Q?UaP7G2KxegLVVM5yWg7Dbo0MpV/GuHnePI+vjgu5Z5HnS9QTUoeIRRralI1b?=
 =?us-ascii?Q?KBC47qNhUXb79Hy3SM7ZPxAbP0oTrdiSFE1ir//mKIa3hDapQUWqFHqzO3i6?=
 =?us-ascii?Q?esEFAVlrEky+j5dTfqLinhv9wbAxLvQHyhUVuki+h7Z0qawVMnV5byV5vN4E?=
 =?us-ascii?Q?6dXjZRtP9GJsTCWJRiPyYvIup1/M/roBDnkT4srCFDA7GFdfyyDAKAQwYkjZ?=
 =?us-ascii?Q?WdTDO3K+k9TqKYXCuEGkznXoKUjouUQhdYaGfSXvgrBsENFUmXoK3lTN2qKH?=
 =?us-ascii?Q?wrgo25T9QKtEeCSsV8fMHr/zj9kBf1Gyn+xI20B6tpK+ryb/jPkXjVDBngi/?=
 =?us-ascii?Q?0N5wipET1LLOmFo4TtC9Y09MOzgarO1vtdnlxcHvdEL3yy5AYyHC9wZVh3CA?=
 =?us-ascii?Q?95GloOdgqN7rkHwytOwcNKW2yJLA8i50zrSqGgQbqHCI2xa6uDZgTp70LdUT?=
 =?us-ascii?Q?aE5viBNdhFQe/Tlu4d3cClX3V3SlW9iqoTvOgBJ+P3/WiMwfrzzp8T4O5CLu?=
 =?us-ascii?Q?c0+aH6AiErCycZPPNwk/vGrI3M3VPMd3GzmYi9sgL2JKB6ySIFOo2gfQa21t?=
 =?us-ascii?Q?1tg9zkusRomCbSicBFKCOj1KNWqTdUcMhAzv38UQVhytQtX8YPdLH8tQqLge?=
 =?us-ascii?Q?cb4ClsNgC69Mtn0NMmtrai9/jK7ET/ZuzxjEsDCgorjB49nHkQ9BcOpJlujW?=
 =?us-ascii?Q?+ToXFq/jwRgZo8WoVGjJem8DcinvdFg=3D?=
X-Exchange-RoutingPolicyChecked: M4vFm8Pe+bkTG74qkJW/fgXhd6+wgvGq/M2A7u4Ljr8qd1lczWpmhhRluCGdVg6lpm0BWfzVIXMt8QtG70bhS1n76AN5wV0lXudLHeSzqHbEhC/7HpbKLHv4jZ/JBVCYMOHXP+10CcEthcxy/Kbk1DBNFUjcpY/aCDfjSQIN5crmvbTftlldlV25TMd+waYBnsRC4qkTpchPA340ib3bP9O7L21orPWKv6yF3FN1feNr785TQvELhDF58aKD9mSsHOYgj617FqK5ic6UqpiuUj9Yc3hHEMhDctEf0e9Bx3zkLSh15d9AhiAObNXGNQto7KaW3vMx+yytktCOu9F9JQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f6ea0e-0f4f-4ec1-64ec-08def1d06204
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:30:43.4825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaO93wazd9BktNkKxZRSvrgNZIueFpeKfeB4HVw8oBnC2698p+VhmKUGiFp1XOuwJSrI0ngyZY2EFF73+/iCJBDgR+q1aH6wuI8ZzOq2lHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA0B9CD929
X-OriginatorOrg: intel.com

On Mon, Aug 03, 2026 at 05:18:10PM -0500, Terry Bowman wrote:
> Add Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> describing the end-to-end CXL protocol error path: AER ingress, the
> AER-CXL kfifo handoff, the cxl_core consumer worker, RCD/RCH special
> cases, severity policy, trace events, and a source code map.
> 
> This documents the architecture introduced by the preceding patches in
> this series.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
