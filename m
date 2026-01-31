Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707BF944F
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 05:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769839127; cv=fail; b=Znl3oHvKpGGR1eEokyIhlTYHZtjbRK79YSptqZdFxN0096LQrf210e8hctzSCUb/RJ1emnu5kp3Uz8FLeYTNrVvrRTJAI9GRJuIH+kaYe2XhOU4TrL/99KdAjpwDQfzaewiJJPDBDOkWS4M4YofG/PojhFsU8K2le3nBBsjbLaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769839127; c=relaxed/simple;
	bh=z5yayG+CZJx29U5XGVle92wv59obd3kIJiSkAbiPM9o=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=o63v6DL31pXwZe043RsSoxT8Zu4BqSIHDx/P1JMrRiamHX5g/bAoy7q3q2lEeugyLAh8DM9qmZsj9g1sunQRZcu0ZiOCebFCBRWCd33E6IsPEwW8/DZnR/eQfIU41/ko9sRVSFneXTN1FRng6yL7UOnmt0wSmRTkm77sK/EuCnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=is4U27jS; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="is4U27jS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769839125; x=1801375125;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=z5yayG+CZJx29U5XGVle92wv59obd3kIJiSkAbiPM9o=;
  b=is4U27jSRxE1gm9gpI7h/IGF8u7sO1w060zfc6Xo4fsi7zzhQoptazHu
   xU5yGCZCgpXMFdzdmlC0sYfDaD5j94+IrCFEO0ojkmKVIhP/QcIZQSrEt
   okt1Mqc7ysHhHLRqNG73l2LQnHGI2VAlvjEoWzJ9IebI1t/FhxHd5tVoP
   UOF/ogA2PQt6u+Rs3GRXU3sEgwMNhki3qTcXt0Wt1Hf7l0F6wSHi+twM5
   NqSnerKWjaUmsV8pcIOeFsjVBsCoTjlED5Rlw66OmRvzCjszpsj4fM1ch
   pUXnjvCCqUKzsXaEZGMs5WTTVq+D8MImpvO6FrBaG+EBsgsP4JSwc9fvH
   g==;
X-CSE-ConnectionGUID: 51hSZHjlSMaKNGVQEUDXvw==
X-CSE-MsgGUID: D8nlgcGGQ+yY6ibRwd7ywg==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="74707178"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="74707178"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 21:58:44 -0800
X-CSE-ConnectionGUID: PC4QMOPXRjKBBRXEIW/PGQ==
X-CSE-MsgGUID: e6j7ubK8Q3O5rRPS8CzZOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="209015197"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 21:58:44 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 21:58:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 21:58:43 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 21:58:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rn7JpQ7BAbh7yJoNlLAjER8RI/PavanFahhjcVnTUP0NuWxSs5xkbIYoGq8WoGtmxEB4HyZwV24HRLn5sFvLY8UtqXltCc44KfskGBLQ9viI90zwYY5ZjJRAU1PNH3HcFB86qMe1sNvlyyNvsSQJZVE9goviCYAtglcQutQ1RSUyOtPFxmRGR0CPjBizml7cjGS3Kojer/+hXQQXdEQC1RAuumg2j0C8XzWar7Hp0KzUgKbQfkw/sAiw1CT9z9bw4g2XvsCmQ6iISslvkWFdznARss6e0gAl8v54WJvwj0wBrlpMlBgAHUvoDANwm2UVZDFEsjQYZx7nPCeptdQ6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIm5CK5PRyhD/jCsEWO4A2mc09fx7B29pt6dEMwgvCs=;
 b=MzeS4kK0RtsEdu7Z3Q1dIE4qTFmgK1UooTvi1WqL5Wg6qy3V8LTenjDlmcn3200UvSWSFCvL3RG+73aQzY9jfbLgwnzsPGj5xWlxdQzqNwJ4VoBXB1HhLds71azcwrTlii0Its+ZAgP4kkmFLsEqzFYueyB3JKuEifcyWLrobNZYXE1OY7I2miCLxaB52aSeG4M2LNFlcrfHMei2ONoDoQpllYOKV6lPjGv9XvMaBRLP+/PjUtBqpkVm9tc0BHXxK4U0yIcyu2kNJtJR+fmMKlQcXbmgCaATmf/QxhQVyll/joxMiN+CoOEa7Y7cKqqelYA/IbuxQy2pNjdLwg9rDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Sat, 31 Jan
 2026 05:58:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Sat, 31 Jan 2026
 05:58:41 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 30 Jan 2026 21:58:39 -0800
To: Keith Busch <kbusch@meta.com>, <linux-pci@vger.kernel.org>,
	<helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
	<guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>, Keith Busch
	<kbusch@kernel.org>
Message-ID: <697d9a0fa0427_1d3310063@dwillia2-mobl4.notmuch>
In-Reply-To: <20260130165953.751063-4-kbusch@meta.com>
References: <20260130165953.751063-1-kbusch@meta.com>
 <20260130165953.751063-4-kbusch@meta.com>
Subject: Re: [PATCHv2 3/4] pci: remove slot specific lock/unlock and
 save/restore
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 94085ca5-531c-4e78-fe08-08de608dc91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlZxN3czRnpSYlFrWWp3ZEs3RDFvb2VPR2dOZW5sM0N5OTdtNkdmcGtmNkdD?=
 =?utf-8?B?d1Uxb1hFVnZzNGtDb2pKU2RUMWhhTDVFV2J5RDkycURkSy8xTkFNamVGYnpv?=
 =?utf-8?B?bXV3c3Q5ck9kWVdNL3JsVHVJcVdZN0xoMnFKbmpUZE5oUEVScUhkL1NxU2JR?=
 =?utf-8?B?ckVBOVBXcmhXSU05Q0I1ZlhrYmxJR25lVUpOMnl2eHhYcE84TERraW5OUkhS?=
 =?utf-8?B?MEZNOG9lM29MYmdSMmZ5Tk5LUEtNVUExb0M0WW5ic2lmM082cFFIVUxUTVhz?=
 =?utf-8?B?LzhxZ2R2SW5YVUxQTnp0czUxZkVkZ3hWVWJIWjUvS2t1aDBRWlRTWnFORkkx?=
 =?utf-8?B?VC9BREJQTm0wNDU5V0J5dCt4REZEVlZxOWZDS09xWm8zZnRVQXRveXJZZGJ5?=
 =?utf-8?B?TXVCNHJnb0l5eFR2MDI0aVpTZ21UTWFHSndDVDh4S0ovSlA1YWVEdmZmbkxX?=
 =?utf-8?B?NTVSeitmVVpsV25lM0ZEdWJZVDdUQ25wTnUyc0FTMDVpNThRNUpLQUJjZjJU?=
 =?utf-8?B?aXh3bDViK2pySWFkSkJBbUthelRySHpHeDlsTUlMQy80VkVjTlN1SEE0RU9a?=
 =?utf-8?B?UGQzZ1I3UDZRaUY2VnEreGd2Y1h5ZnVrR1Vmdml3Vkd5ckhIQ1NkTmI0TCtl?=
 =?utf-8?B?cEU1MkhhQ2UzK1diRnpBSEd5TUpXZnR6TWFwUUJUbkJXMmRXTzV6Z2lBT0JR?=
 =?utf-8?B?b25qVjByL0FOR0h0YjdYWWFPUytUWnRRd2JVKzBqQTFjN04wVXY4bWlYbVVB?=
 =?utf-8?B?eGxidU5iN0haUzN4N2w1Vi84SE1YbXNLejVrOG5CZ25MY0RmZjRBWkh0cCs1?=
 =?utf-8?B?aTM3RURranJsUjV5VWpaUlc0TEtaQ1pRUmdJWTRxOWxnQ0FzNzR6NXlDWEYr?=
 =?utf-8?B?Q0xpU2xjMVdYWTZzTkdCZ0crc2J3b0pYd3l2RmZ3eXZPMTRlR1c4UFBGQk91?=
 =?utf-8?B?NVlsZTV0UWpSME5URXU5RU5pdW9hYVVsYzdXV1czbm9ySkNFMGljdWRHa3NV?=
 =?utf-8?B?TTE2cnBxbXIxcXVhcTFMWGgyRXFEdWI5NU5QaUdGR1Evd0c4Z1VKWnRrYnQ1?=
 =?utf-8?B?QVhvN0pLWlExQzR0RXl1bjJLZ293NFpRdGpNdTdKYTdlbTRuVmRQRXh3OS9I?=
 =?utf-8?B?UDRZWXBlenFMUG5OZmV1Y0NEb01LaGxyVldRR0loUkkzSWZkNzM0bmIyRUE1?=
 =?utf-8?B?V0Nka2NvaEVLUCtNcnNINzdYOWQyY2pYN1RxSUtPRmZ0Umg4VStXUXV2c3Nx?=
 =?utf-8?B?Kzh5aUhuWTZTWjQ5VnZ0TlhDSXEzdjJKcjFkWk1XQStLTEFaTnJNbnFCeElC?=
 =?utf-8?B?d2NmcU1OSFFTQXUzY3V0R0kzRStsbjV2UVplWXZ1aWFYZFRUQktpbWxPaEVP?=
 =?utf-8?B?Z3VFekIranJaZnVRS3M3NFJnUUkxamoyRDYyUDBRUTc0eWNYbVRvZjg0Sk1T?=
 =?utf-8?B?QUJ3M0ZPNEpubm1TR1R1QkhXRjJCYlFQRE1PK0E1U3g3ZGg0VzNoMVlOZE5u?=
 =?utf-8?B?bXk2TzRNa0tvbnRUcTc2Y1RnaWcrM0R3TjQ3Ry8vNXZvR3JXNjFpTW5Bd0kw?=
 =?utf-8?B?Y0NwMU9SODRzbUswYmtsd1Q3UzllNXlNWm51K3Y5QnRLcVBzTGNrNVA2aVVO?=
 =?utf-8?B?ZmViSHdkeEdZU296NGFmZ29NMCtCUVk4WXFBbHJIQ0lSSzk0enp0Rmc4VlR6?=
 =?utf-8?B?N0F2UXZkVk84OWJLck5EcVpIemxYYW92cHc0ditwaWZGRDJTdklHTEk1cVNW?=
 =?utf-8?B?b3kySVcwZmhUQ09wanIrSWdWOE9wQVVUcFMwSVd0cldVSEZZKzFvZkE2SllY?=
 =?utf-8?B?UUVDMFNWdWN4YnB3YnBDdTlQZlN0THFpMlYvMm9ic1V1Q3ExcG9hK0V4NUNo?=
 =?utf-8?B?YXIzQzhIaHdPOER3OVl3NUNJc2Z1S0tuVFZxWWg3WFFWcFlWOTNGSjF3NVdX?=
 =?utf-8?B?Uy9KUmNsNmtRd3dHNExhWGNUNFNoRVltYkxOK1BVQzVqdzM1UVpTQXBzVUFD?=
 =?utf-8?B?NnB4SlRRL0JOekNadjlJeWZ2Y3J5YlEzT1JMVXFQLzRVMmozNEtEUGNLQ3Rq?=
 =?utf-8?B?MDBXdFJzQ2U3Nm1hSUhtRXJ2QTF3aGlETExvdWwyUi9uQlBsblR4b1BVUnF0?=
 =?utf-8?Q?BkvA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW9ZdkJobTJPejdnYlFNcFpxRVFybFhRMEc5WFlQcW5uZFdGSW9lUTJrbXB6?=
 =?utf-8?B?TXZ0WndJRVVDTGwrTnh2U3ArUTVJSXJranZwNG04L1JKTmlGbXd4R0cySFB3?=
 =?utf-8?B?YkZWbS8rQzVFOFBjOEx2QTlIb1AyTGdlN2wwcGZJQnFMYXN5TXh4Q0tyOVN4?=
 =?utf-8?B?Wit2cWFwWCtCMTUyU1ZXZitQK2ZSbmEvQWs4OG9PNVhveEt4QTZxRGlva1ly?=
 =?utf-8?B?T3k5MkpyeDFUMkFOd2tGVVBFL2gwM3lUdE4rRFFnTS96S3pvckQ3dGNzK3F3?=
 =?utf-8?B?R3EwVkhhbUo3OXJJSGk4dnVHSkZnZ3MrYnZtUUE5N0NDRENWRlNEMEFJS2gy?=
 =?utf-8?B?K1dkTWtuS0pmRG9PQjErMFBOajhnK2xMT3RXcWlPVUpINUFnZmo3bCtSVWdw?=
 =?utf-8?B?cHI2Q0JONlBzVWRVdkZsY041OXdiS3Y3eTdONmppeXdXbDBreXBnckJJSkpT?=
 =?utf-8?B?cXJveFpNS0o5Y0MvT2RkQ3ptU3RHTm90cXhCeDVlRVppSXlKaTlrWWdmY1Vj?=
 =?utf-8?B?dEJyVWpWbjZFQnlYSExJUC90b0R2SS91UFdra09IMERZWDA1NktIRlN5SzV2?=
 =?utf-8?B?cG1jQVZhN3h6dlI0WkJKcEp4azE1anRPaXBTekdJVEc2SDlkUXBJYWZ3dkVD?=
 =?utf-8?B?Ry9jMzBZSFMrSU5pZ2lWenA4TW5pRTh3M0syWkRzSnhRT2xDSWJmSDhxNVN2?=
 =?utf-8?B?SFU2Rjh3bWlhNnp0QUpqNkErSFlQc2F3dE1aNHVBL20wOTRsSzNqNkZIV2J6?=
 =?utf-8?B?UjVoTExZeDNTRTVWOTZ2bHNnY01Relp1T0djb094QlVlS1hpYmlTRzM3T2ZZ?=
 =?utf-8?B?Zk5rOWY0Q2Z0TWJMNHp6V3UzalBmL3o5MHprR09PLzZHeWlSQjRUUTJCbisw?=
 =?utf-8?B?aDZkVCtZeVVqMjFtazdQS1N4WVE5QTR3VUYwL3grUmI3TDAxakl1YjFyMS9N?=
 =?utf-8?B?MmhQNUI3NUdYMzcyRDI3bEk4Vm9sWkx3YnBLUnVUeW1Kd0xLd21xM2pVMnVT?=
 =?utf-8?B?aVhaT1I5cDN3OW5RZEF3M1B4SEo4WkxHemN6SHcxaGQ5ZS9QVFM4a3BpUitz?=
 =?utf-8?B?QTM4WnZTazdEbzRHcU5hT3B5Z05LRFVyeEQwNWdHdldjL3dvTUJ3MWJEbVA1?=
 =?utf-8?B?VlJ2b3k0em5BZkR3cm9UWFllNDdwRHRucmVrelAwVmtjR3J3aFRDa1ZkYVRa?=
 =?utf-8?B?bmJHY0twTGZiNkVQeWtUS3QrTDhCWlNWVW9MMk12VWxIc0dCL25HQ1lRczB4?=
 =?utf-8?B?dDBuZTN2U2xFaWZYL20rWkg3aXN0b0NMeXlHcEVQcmw1MnRLMytmcEgrSnJi?=
 =?utf-8?B?K0pjaDNOc2ZIcmdHckdPc01ZelI1dGxPeklackt2eGpsSWtGaitHOWtadk9V?=
 =?utf-8?B?M2E2azBQdTJWVmxuVWROZERLcmtFWit1dm9JVmRmb0wwMTF4dXYzL1JVdnF1?=
 =?utf-8?B?dFhtWmxNVTNNUHhYdE5hTTNDNnlwa3JVM1RyWG54RVZpQmNIRGZGREh3S2tS?=
 =?utf-8?B?SDhNaVBaam5mc1dzbzhFMHloWTg4c1ZwYjJmZmJOVXpseUs5WGFFakxFU20x?=
 =?utf-8?B?aFZKQTdKVHpwS2ZDelRhTWxuNGVEOVd2Sm1vRi9rQ2FocHdnMm1PTkZPK3N6?=
 =?utf-8?B?RDYwL1UzM3NhRDQ2a1V4UVJrdktiSFdNVTR3ak9Rbmg0a0QxWXJlZUhhNGVS?=
 =?utf-8?B?QmFFNndWdjNtaXFKV0hIdVIxMVphN056RDVlMnhRWjg4ZEdBMGx2eEh0ZG92?=
 =?utf-8?B?bjZlamxRK0o2QXVURHVtRHBUT0VmL2VYTHpUaG1mdkRvdVNZWjNHaFNraGMv?=
 =?utf-8?B?UFZXY0haSXZ5emkweTUyN01ranpsQ01rcmZJWFNaOWFVMjEzK0MwSWp4SW1r?=
 =?utf-8?B?cGhRdVMrSW91QVd5S2NVcHhLWThBQjQvb2QzckQrb1paL1gxeDVzWWVTWnho?=
 =?utf-8?B?ZzdaVEV3Q0ZNa2tmN0UrWUpINWxyckF6anlVWmZXd1Y1UU51N3dJNHdhMmJw?=
 =?utf-8?B?SjUxS2tSRGhSeThFaG4rci9KM0lzZlFEd0RzbzVma2h1blp2c0VpdWZsWGQz?=
 =?utf-8?B?aEdMUVpsaHBQejhDakpmNThjdlMyd0svR3VmZGx1UFlYSnJCOW81TUZ2bnYz?=
 =?utf-8?B?U2JBNWdFRUpTeU5uU2tSMzBVakhqR2RQVks1TGJtL1ZYSFlaQnF4WGF2YXEw?=
 =?utf-8?B?amR1ZGZKUmNpZTBuVWY0M0piQkRZczlxTUNjbHRISUJXSW1qWE9GQWRWTUZS?=
 =?utf-8?B?ekszdHR1VjBiU084SVFxQ1hQSnFobVEyMkg3LzdYZGRlSXB4bWxybWhOQk9z?=
 =?utf-8?B?Z3VUdW8yamlDSVR3elE2aHpIY3VhVlZnTnFjSFJWcGIzTlJzS0dqTTc1UHlI?=
 =?utf-8?Q?Ib2MEOOp4p/6BEOw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94085ca5-531c-4e78-fe08-08de608dc91a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 05:58:41.6626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vy4rpcf00eHdgyXPYj5ckTMI0o5FNS1NR23KArBntRHeSKWMQ9uumqMluwIjPGv6VfPu9Pgu8pjSpR3FzepBz25E6PjWKQKY+5NvKhkuoso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7141
X-OriginatorOrg: intel.com

Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The Linux pci driver resolves a "slot" to the "D" in the B:D.f (see
> PCI_SLOT()). A pcie "slot reset" is a secondary bus reset, which affects
> every function on every "D", not just the ones with a matching "slot".
> The slot lock/unlock and save/restore functions, however, are only
> handling a subset of the functions, breaking the rest.
> 
> ARI devices with more than 8 functions fail because their state is not
> properly handled, nor is the attached driver notified of the reset. In
> the best case, the device will appear unresponsive to the driver,
> resulting in unexpected errors. A worse possibility may panic the kernel
> if in flight transactions trigger hardware reported errors like this
> real observation:
> 
>   vfio-pci 0000:01:00.0: resetting
>   vfio-pci 0000:01:00.0: reset done
>   {1}[Hardware Error]:  Error 1, type: fatal
>   {1}[Hardware Error]:   section_type: PCIe error
>   {1}[Hardware Error]:   port_type: 0, PCIe end point
>   {1}[Hardware Error]:   version: 0.2
>   {1}[Hardware Error]:   command: 0x0140, status: 0x0010
>   {1}[Hardware Error]:   device_id: 0000:01:01.0
>   {1}[Hardware Error]:   slot: 0
>   {1}[Hardware Error]:   secondary_bus: 0x00
>   {1}[Hardware Error]:   vendor_id: 0x1d9b, device_id: 0x0207
>   {1}[Hardware Error]:   class_code: 020000
>   {1}[Hardware Error]:   bridge: secondary_status: 0x0000, control: 0x0000
>   {1}[Hardware Error]:   aer_cor_status: 0x00008000, aer_cor_mask: 0x00002000
>   {1}[Hardware Error]:   aer_uncor_status: 0x00010000, aer_uncor_mask: 0x00100000
>   {1}[Hardware Error]:   aer_uncor_severity: 0x006f6030
>   {1}[Hardware Error]:   TLP Header: 0a412800 00192080 60000004 00000004
>   GHES: Fatal hardware error but panic disabled
>   Kernel panic - not syncing: GHES: Fatal hardware error
> 
> Fix this by properly locking and notifying the entire affected bus
> topology, not just specific matching slots. For architectures that
> support "slot" specific resets, this patch potentially introduces an
> insignificant amount of overhead, but is otherwise harmless.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/pci.c | 152 ++++------------------------------------------
>  1 file changed, 13 insertions(+), 139 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 57a5b205175f1..36427fbf7a747 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5218,7 +5218,6 @@ static bool pci_bus_resettable(struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
>  
> -
>  	if (bus->self && (bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
>  		return false;
>  
> @@ -5287,96 +5286,6 @@ static int pci_bus_trylock(struct pci_bus *bus)
>  	return 0;
>  }
>  
> -/* Do any devices on or below this slot prevent a bus reset? */
> -static bool pci_slot_resettable(struct pci_slot *slot)
> -{
> -	struct pci_dev *dev, *bridge = slot->bus->self;
> -
> -	if (bridge && (bridge->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
> -		return false;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
> -		    (dev->subordinate && !pci_bus_resettable(dev->subordinate)))
> -			return false;
> -	}
> -
> -	return true;
> -}
> -
> -/* Lock devices from the top of the tree down */
> -static void pci_slot_lock(struct pci_slot *slot)
> -{
> -	struct pci_dev *dev, *bridge = slot->bus->self;
> -
> -	if (bridge)
> -		pci_dev_lock(bridge);
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->subordinate)
> -			pci_bus_lock(dev->subordinate);
> -		else
> -			pci_dev_lock(dev);
> -	}
> -}
> -
> -/* Unlock devices from the bottom of the tree up */
> -static void pci_slot_unlock(struct pci_slot *slot)
> -{
> -	struct pci_dev *dev, *bridge = slot->bus->self;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->subordinate)
> -			pci_bus_unlock(dev->subordinate);
> -		else
> -			pci_dev_unlock(dev);
> -	}
> -
> -	if (bridge)
> -		pci_dev_unlock(bridge);
> -}
> -
> -/* Return 1 on successful lock, 0 on contention */
> -static int pci_slot_trylock(struct pci_slot *slot)
> -{
> -	struct pci_dev *dev, *bridge = slot->bus->self;
> -
> -	if (bridge && !pci_dev_trylock(bridge))
> -		return 0;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->subordinate) {
> -			if (!pci_bus_trylock(dev->subordinate))
> -				goto unlock;
> -		} else if (!pci_dev_trylock(dev))
> -			goto unlock;
> -	}
> -	return 1;
> -
> -unlock:
> -	list_for_each_entry_continue_reverse(dev,
> -					     &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->subordinate)
> -			pci_bus_unlock(dev->subordinate);
> -		else
> -			pci_dev_unlock(dev);
> -	}
> -
> -	if (bridge)
> -		pci_dev_unlock(bridge);
> -	return 0;
> -}
> -
>  /*
>   * Save and disable devices from the top of the tree down while holding
>   * the @dev mutex lock for the entire tree.
> @@ -5410,59 +5319,23 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
>  	}
>  }
>  
> -/*
> - * Save and disable devices from the top of the tree down while holding
> - * the @dev mutex lock for the entire tree.
> - */
> -static void pci_slot_save_and_disable_locked(struct pci_slot *slot)
> -{
> -	struct pci_dev *dev;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		pci_dev_save_and_disable(dev);
> -		if (dev->subordinate)
> -			pci_bus_save_and_disable_locked(dev->subordinate);
> -	}
> -}
> -
> -/*
> - * Restore devices from top of the tree down while holding @dev mutex lock
> - * for the entire tree.  Parent bridges need to be restored before we can
> - * get to subordinate devices.
> - */
> -static void pci_slot_restore_locked(struct pci_slot *slot)
> -{
> -	struct pci_dev *dev;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		pci_dev_restore(dev);
> -		if (dev->subordinate) {
> -			pci_bridge_wait_for_secondary_bus(dev, "slot reset");
> -			pci_bus_restore_locked(dev->subordinate);
> -		}
> -	}
> -}
> -
>  static int pci_slot_reset(struct pci_slot *slot, bool probe)
>  {
> +	struct pci_bus *bus = slot->bus;

Should this be:

    bus = slot ? slot->bus : NULL;

?

Looks like at least pci_reset_bus() could pass a NULL @slot.

>  	int rc;
>  
> -	if (!slot || !pci_slot_resettable(slot))
> +	if (!slot || (bus && !pci_bus_resettable(bus)))

With above and something like this:

@@ -5219,6 +5219,8 @@ static bool pci_bus_resettable(struct pci_bus *bus)
 {
        struct pci_dev *dev;
 
+       if (!bus)
+               return false;
 
        if (bus->self && (bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
                return false;

Can just make that:

	if (pci_bus_resettable(bus))


>  		return -ENOTTY;
>  
> -	if (!probe)
> -		pci_slot_lock(slot);
> +	if (!probe && bus)
> +		pci_bus_lock(bus);

Similar preference for pci_bus_lock() and pci_bus_unlock() to nop
themselves if @bus is NULL. That might want its own lead-in patch... but
only if Bjorn is on board with the making the conditional locking
implicit.

>  
>  	might_sleep();
>  
>  	rc = pci_reset_hotplug_slot(slot->hotplug, probe);
>  
> -	if (!probe)
> -		pci_slot_unlock(slot);
> +	if (!probe && bus)
> +		pci_bus_unlock(bus);
>  
>  	return rc;
>  }
> @@ -5489,25 +5362,26 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
>   * wrap the bus reset to avoid spurious slot related events such as hotplug.
>   * Generally a slot reset should be attempted before a bus reset.  All of the
>   * function of the slot and any subordinate buses behind the slot are reset
> - * through this function.  PCI config space of all devices in the slot and
> - * behind the slot is saved before and restored after reset.
> + * through this function.  PCI config space of all devices below the slot bus
> + * are saved before and restored after reset.
>   *
>   * Same as above except return -EAGAIN if the slot cannot be locked
>   */
>  static int __pci_reset_slot(struct pci_slot *slot)
>  {
> +	struct pci_bus *bus = slot->bus;
>  	int rc;
>  
>  	rc = pci_slot_reset(slot, PCI_RESET_PROBE);
>  	if (rc)
>  		return rc;
>  
> -	if (pci_slot_trylock(slot)) {
> -		pci_slot_save_and_disable_locked(slot);
> +	if (pci_bus_trylock(bus)) {
> +		pci_bus_save_and_disable_locked(bus);
>  		might_sleep();
>  		rc = pci_reset_hotplug_slot(slot->hotplug, PCI_RESET_DO_RESET);
> -		pci_slot_restore_locked(slot);
> -		pci_slot_unlock(slot);
> +		pci_bus_restore_locked(bus);
> +		pci_bus_unlock(bus);

With at least the @bus initialization fixup above and with or without
the other suggested cleanups you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
