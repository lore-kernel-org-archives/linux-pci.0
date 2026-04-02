Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A83563DD;
	Thu,  2 Apr 2026 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775101161; cv=fail; b=Nhd2zZN1PlTyGKBrpmUpI+vLusJ/mFLa9tJLSbYicjxsVRzb79J+Rcgwu26rlx8n6/9wroTz7IJ7Upgb01qr1ZeR3NBQWF1JLFrX8EBFbsjdq02yhZ6KSYRh0nAvjP+3VRYkYKp+fihd7OQM5J7c2XN9/m16RB5tJRKPWlwuRhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775101161; c=relaxed/simple;
	bh=tumPS1J3pFIdJolxbovTGP3KdLzdWxwCFSgX8Cjnf84=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=L1h0rfoteFPJyWjdxRHZQYQ8TKC/ds43L9nb2F1lCQ3hFWWv3gV/FItPhQuTUM2vdUcp3cbkupmgJIS2pRFBpY0eflLRvDFzZVXE+NdBx83Zvye2m8jFU+uIphNiek8F0q7RQv9HvMSloipkVRB1wND42EkB+2MqBq8a/bQutZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jk/VV66D; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jk/VV66D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775101159; x=1806637159;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=tumPS1J3pFIdJolxbovTGP3KdLzdWxwCFSgX8Cjnf84=;
  b=jk/VV66DfJgRVTyZyub4NA1Va0yuKBTxJDyBPKtQOWcRPGtn7qschqxK
   2qcAfcVyddx0rlBju5pXdSKQReNgD7fPeoJT989vmgqRREklwfkaL3VJW
   gHoP4DgXtw+jT/jzCkKLcKlBhvgcDSpKlAGXCrw9MArn/rgDPxS45hGb7
   s01CbBg6AwcfLDbNgA7Z72VXCuUK8mXTLqx+A39eUvbedXpqcHNYXq6la
   eE5ez0qY00U6/erNCfziyUAXDGlabfUEGk9BJwMIeUmBzjk1Cg374LGSG
   W2risvO7lId3siDFWX+NBM1xSQAoVYgTV0pRsm4JuJDADiQVgj/Z2tM7H
   Q==;
X-CSE-ConnectionGUID: dJ+3/ihwQQmPvmrDVol6gQ==
X-CSE-MsgGUID: OC/XTrjFQ3S6aEb3/aMG5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="80011242"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="80011242"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 20:39:19 -0700
X-CSE-ConnectionGUID: gOthEHATTZW6lXPye2IeoQ==
X-CSE-MsgGUID: raU/DsCLTZu5fujtSOUb/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="264797786"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 20:39:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 20:39:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 20:39:17 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 20:39:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIj1+6kSxlhZ2OIK8LFKWD+B/uiUq1EZpiKfiwtSK6jjZOROlFC49tGwbXSzNLDgqjwCINxiMQqPe3iuH38ppd42Uc9xuBeSNXb64qkyfACmmIituYz0Xo3N6344lPy+aaDfFDyfcCDX9nyydvKwxA6QiXjfiG6uz34Y1WzNcqD9kiDmYFHDW/QZ8Talg5da0UWzIXk4auJIEVI1K97vwqisa5L6EuGnpDnautN7MXwnh1dXgRD7LHydeyf9W7scswQiIsTnRljMyXCsFagLAMGTPzzuJdVXYiCw/eGT6fIvfTMFrUBrThdLnoZ7OTpxBAokMjaDlDTt3uK1O0d/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRqPOc3StiokOJ3FO8qlN115nRdIansfGo4nmQJtCjo=;
 b=DfJWH6XwvFBDlIufnNvzzwqnESFC/Zy5oc56TGgP4QfSJIobkKw9xFaPxHYRTvzm6aaBEhXM5rzr+OUcqxfV5hNuq1Zp7ojUkxe11ZZMRBlKK5ukewS8lrQXzhsnev8SA4Dl/dSNLpGSSHQ21kigu0wpc4BY22pyAK5eOmO2iZcELOt37J52R202QCB+PV4ndKfvxPkAb68EOlgkIsQ/xmlClhWmDF4Yn/gGfc1WU2F4qSG1X79ATdBh5RcI5ch1jIDyM+Go9p/X5waJoWff9L8iGzsg5dNgq5aOwznLERaVIOXpSevjyKqhz6Aa1JSG9wJByYCGf2RAhs3Vm3vyTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7479.namprd11.prod.outlook.com (2603:10b6:510:27f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 03:39:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 03:39:04 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2026 20:39:01 -0700
To: "Bowman, Terry" <terry.bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <69cde4d5eecf3_1789041003c@dwillia2-mobl4.notmuch>
In-Reply-To: <fc296cab-f983-4f01-a71b-3ecbb9efde1b@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-9-terry.bowman@amd.com>
 <69c9d04baa431_178904100f1@dwillia2-mobl4.notmuch>
 <678f2b92-8f7e-4a6c-a66e-c19434de19f4@amd.com>
 <69cc1f1e5c432_1b0cc61002e@dwillia2-mobl4.notmuch>
 <fc296cab-f983-4f01-a71b-3ecbb9efde1b@amd.com>
Subject: Re: [PATCH v16 08/10] cxl: Update Endpoint AER uncorrectable handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0353.namprd04.prod.outlook.com
 (2603:10b6:303:8a::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 25800d1c-7447-4320-caf6-08de906962e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: AWWKhax9YOz6NABp+Ntk0pRJhzTXIbIHkWzfX2qjIcF+JmJswg0ummtIbNGbnK8VaAWXEVuDA41Nah2GQhli0SpfE2oCupvTpQFHRpdJYsM7+oYH6kBZwcXUNYjmen0ZwxhECma1ah1erSBEkvR40z8JEgQjG2tWjT/dApebhSe7diVH1dIRi3KlngGU4d8sfGLN+vRVCbhd5Vx2yGJiv3rivTTSZD8AkBpM0UpXo6g328cveURUX/x5nXpRXNE0eAkOtEjs3sjJKb6hNcO79E5vh60i0sIGaAiKi8CvNBxQBLF7pRG/UWyaYV0GdASTxkMCMl/zYEowGTa+sf9AblHQ2H1bxMz4HGQxVXVNWMxOSEbe7xnHrFa+toH6bZDEX/G0YOJHrnqL0gwTqKIDs+T3RXWIsHsGTUyNrtinO++jecWGFJPO4H3mvsmkENwAyfm72CJFoioF5SNDBy8vOFCfg9IblGz29wcaFjFf0bgIlzsB5guDfo0aLaytms++mJSG12/QiQ/EfEDg/wfyzTTElyxn4xJ6qo8nM4qzwoz/kwnxSMT7K5xCT+92pSUPx1EHQfJly/mnbW7idFEeJXkPnCl557ki9H6rGzjd478DNYlr9R3v/jxseAtg8dDp6Mn4xXN2rA3i3J5EOuwwFQMcyO6yI954o3AxkF18U9GfFEd0UYcOkWpMDvd+htWNRgQzrUgvXzlD0fmuBinriGNAo6htLf7hVIJiPJp1ldc/bz1wHFmLz6mzuQT2603fqaVlqBGdFCZso8uTyOE1QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VER3WUl0R1FuTkFRWEJ1amNZeDNSN1NrdDJRTE43Z0g5YlFWVlB3TitLbDc3?=
 =?utf-8?B?ck52UXh3ODNiK214aytxaG5Qb2duREd4U1FsS1M1aTZhelhlNk5IMktJQ0ZP?=
 =?utf-8?B?RHI3dldqNDh1ZjB4TDFXUEdWUU1pWWx2M3E4MUYrKy84b3JnOW4xYVVMWDAz?=
 =?utf-8?B?MHZITnY2RHRBN29FR1NNZ1VabVlOREdsa1k0Y1VHT09OTlZIdnhJUDl5dURr?=
 =?utf-8?B?UmFzREtJNmFUdDRTS09nQU15b1kwdHh1L3hQZktFbjRrbWZDQnd0aEk2YjI4?=
 =?utf-8?B?NFdISWM3MTJSQVZsVFpOWUs3UWFDdHVKb013elFNNEJISmxtdzNvNHBlTzQ5?=
 =?utf-8?B?dmxZbWw5Y05aLzZBNkx0U0lSbjZLamNncmRpdW5aVEJmenF3M2FpTmVYR0N5?=
 =?utf-8?B?S0JpbVdSRWdORlVPRXdSVzJLYXJhWXFqdklwbDgvbkQ4QmJPKy91Skdpb3Vy?=
 =?utf-8?B?MVVBZW1GNmdRVk02UTBWTXMrVXJsS3c4SmtOVm45aVdMdWVNY2RSd1U3aFlW?=
 =?utf-8?B?Uk1QbWYrcjJ2TjRQU1Jvd1FkUW1GYmtzdlJ5MU1hclJXbmt4QTBpSUFaU1NO?=
 =?utf-8?B?dEEyVTE0b0tGZnM3OTNtVGFpOXNFUnJQTFRaYnZvOFRLMmUxZXFJc3k4VlVt?=
 =?utf-8?B?YVlYRVZpblliSllpZDd4V1NHNTB4TjZ6ejRudDVZSjFQQlY3VFN5U2djOEdY?=
 =?utf-8?B?cU5KWE1hU2NROXlyUytWeVN3Qi82cjlUY0p1QUNGVGE3cEh4V2FmM3RBY1ZP?=
 =?utf-8?B?bHNnaEl3WkNYRjNpSmhTSmZydUxUV1dkZ3RBb1drM2JESlIzVUxPV011NHBi?=
 =?utf-8?B?d29KUzhyY0FvRnZxaVk3N2ZqdElyaitHTUxxQTlicFdVVGdUN1R4QXBQTDcv?=
 =?utf-8?B?eEhuamUrS0VFS2FVVFpkVjdxeE9vM1RSSjRtVHp3bzNQUDVmc0w4RnJFSXMr?=
 =?utf-8?B?cWFHbmw5SVhSSHdnTXVmV3p0OHBMMnA3UkhHcjBpMkd1MXdubU4reWs0YlFs?=
 =?utf-8?B?SnQ2SGR2L0dyU2lPNDk2Y0FabkM4VlQzZjF1STVMOU9EcEFLcGwyWWdHWXVS?=
 =?utf-8?B?Ylh4eWh5OHIrZGVwK2dvQUZXeDA2MHZudHR5eEZhNGlaUzdZcnl3QnNhZ1dB?=
 =?utf-8?B?Y3VtaHZGYXVaSi9QWXc0UXJ3Rm9vOEVIaWlZZURDcmxUZnV1QjVNL2lQalBH?=
 =?utf-8?B?L3pTaHNaNGg5cG0xUGdWekFwekxrNHBVbGx6RjlVd1dRY2F1QU9XWjQweDNL?=
 =?utf-8?B?THJWOWhrMms4Q2QvbmJ0b3VsYlVOdDdoSEZDU3YyeWFCNVRVdzdLTXR5cG80?=
 =?utf-8?B?NUdFei9nK1IxMmZwcWpLdHZ1NDZ3NWxJSy9EQnJKT1pMUFk5TTdUaUptTVI5?=
 =?utf-8?B?Vi9LdzhVTWFraFRYR0pUWW5hSHhPcEs5RzFtRTFmdlRvZ3lRdE53Tld6YUJ2?=
 =?utf-8?B?NG9UdlFZNXNGTUhVMkNaZDhEcVJwVjA1OEU0WU4yTUl1UkZIeENrM2Q3dWJw?=
 =?utf-8?B?eFh5S0VoSFcxRHRPTUNoVTFOcG9CMmlkenFJalIxSjFzakk2ZkQvM2lyZEpo?=
 =?utf-8?B?TElzZ240czV1MGFjeWk0cUYxdHFGU3RPb3VqR0Q4ZjhVL3B6U0F6RlpNOEtJ?=
 =?utf-8?B?VkFMaS95WFA0NTJTVy83UmVCQWxNeC9KaWpCZmYzTlVyYUcwWXBEUTlQSk90?=
 =?utf-8?B?T1l2TytaMVd0ME1ISzRSWVFhS0FGVkpLRDlGRk8wcGJPNDQ1Q3czTVRyamNy?=
 =?utf-8?B?M0Q1dE1YSjRObTBMK2lEbkJYdFY0eXdkK0RyS0JsN2FJTi95eXlvRHluOXZM?=
 =?utf-8?B?MmM5SUxoMlV3Zk1MUGRUWm9VY0VVU3V2NjVUanAzMWtMRktrRjFoajFUOXpF?=
 =?utf-8?B?emJ0NkZnVFl5anVnNWhiL2FxU3QxamtEcjlnR3JvelFvV3lnK1ZIWVo0a2xo?=
 =?utf-8?B?L0pmMEZheFduejdCVE9pdXArRDNZNWpQSWFjQ21zcS9qdHp1ZFU4d2RWem9E?=
 =?utf-8?B?Mko2Y0pzT2xRRDVFSnZNVWh2ZlFvd0FQcWRKelFkWGwrS3Boa1NIMi9qdmtE?=
 =?utf-8?B?S2hUcUY1RFNhVVNEeW9NS3VmQlk5WkJEYVF3Rjl2TGhNM0JOVmo4YTNxQUlK?=
 =?utf-8?B?ZVl4VUh2NDJaVFpUM01jOXZxTXJ6NWZ0bXVSZ3NncWUvWlRQL1BPWE11Y0V4?=
 =?utf-8?B?cHU1b2ZYWmRuSXNsN2JQTmpDOTIwcjFjNHVqRFhzaGxVWnBXdU9xdTdHc1RH?=
 =?utf-8?B?V0o5U1UzbzRleDZIWDRoSU1mVXpSQzF4SFloTnhYZE52TWc1TmtkL3BtM3hD?=
 =?utf-8?B?OFd3MTRGVHJsUEFTUno5RHVxZVVnblhuNUlyR2VpZHJzU1lEWmJjMFdCTTZn?=
 =?utf-8?Q?nZ/z4/5+bQAqcGX0=3D?=
X-Exchange-RoutingPolicyChecked: VZydvoMLxr2jM05vQyXDKgQIxU0QcWpmvE5gegIQHM6jYU1zesyPGE80FKxpvXFnJJS5+nfGCYGY52LeWFqILrBpFdYxZ1r0tgkeszSiIAzQzDuAhYXEtF5YXhWU3eJpfccBVclOV8kpjMr20kr+/52O5HiYAXvbwGbdy9/szK3O9em9qmV37rLTWt/O6trvx5Uqcmdj5XZOJiNQIkSKR2WtbkcSUcx13eBrqEGksq7ukXsoM83mwMIXzKROj18fs3gKwoLuOLMe9IVPOAobGLquvNSMgA2UMCr6XyLaKhUn5B32pAw0yDmSJ7EMwykWabPFsxJ0eXhlMSVtF0sQ/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 25800d1c-7447-4320-caf6-08de906962e4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 03:39:04.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRK04hO6D7HyernG7q+uu2vEIp0+9dX+090JDY3eBc5sK7XMBAbyEB+H0fMW1rw/6AotbdWc3m7OouQybe4DtjNi7tz7/F/Yo8h87sB1hI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7479
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
[..]
> > What am I missing?
> > 
> 
> The USP case needs a PCIe UCE handler added.
> 
> CE are cleared by the AER driver. UCE are not cleared by the AER driver and is left to 
> the device drivers' handlers to clear.

At least for me this discussion is difficult without a test case. Can we
start with deleting this handler now that CXL errors are handled
elsewhere. Then identify an injection test that shows the missed
handling. Then the patch story becomes clear, something like:

---
cxl/pci: Handle PCI uncorrectable errors

The previous implementation of the error handlers in the cxl_pci driver
were removed after CXL port protocol error handling was moved to the
core. However, that causes uncorrectable error cases to not be handled.
That is unwanted because the default handling causes
$end_user_impact_reason. Here is the output of the
ndctl/test/contrib/$aer-inject script for before and after highlighting
the problem.
---

> > Why does the cxl_pci driver not also assume that the links are down?
> > 
> 
> I took a best effort during the fatal UCE. It is calling panic after this.

If CXL.cachemem is down, does it need to panic? Seems like in that case
the only concern is for mailbox and MMIO operations. The default
behavior of secondary bus recovery seems sufficient.

        if (status == PCI_ERS_RESULT_NEED_RESET ||
            state == pci_channel_io_frozen) {
                if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
                        pci_warn(bridge, "subordinate device reset failed\n");
                        goto failed;
                } 
        }


If that is not sufficient then the changelog should explain why.
