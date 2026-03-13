Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C4945039
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 04:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773375107; cv=fail; b=DXEGUdB/7z7Nq/GZgCb/WWHzewYC0AIWcljFWPT7jqkDQmbn+0+nsY+8ipuqv1X7WXb3Go0bUoO4OjcRXsKEuczZ7uD1NyZRuiSrXRQedLboNHNWsOgAPLVb0GnenqvQTBUkFpgHiGDVayujxBhMCEsEEhEhx2Kep8lAkwaCM64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773375107; c=relaxed/simple;
	bh=bR2/uYtNb2BaWIzF4gE9BbYA5Kh5T0uWD0+sk+ZlZr0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=scTqqQWKPZ/Heh2XxZsUfPS29S5gz6/F35FZCbn7DJoBYFZrglMmmvwqNRrTD7OKDWbh99fitMH4e9QI6JaQX5kqwR8g/JdOE+uzw4stpIajymUK+GmF6hJ2grtrrqoJHB3oFEQQzL7j0cVyk20ROlhXvA49dA3I7t5GT3XesgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtBOvbad; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtBOvbad"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773375104; x=1804911104;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=bR2/uYtNb2BaWIzF4gE9BbYA5Kh5T0uWD0+sk+ZlZr0=;
  b=JtBOvbadzxaN6uFbDc4Qvxu2wG53Lmr27m4gjcdyWfse7i86+Dqc2V8I
   AE20dSiDG0VNe9yXjYbJmDEFhBTQ0sXlwe/sMjMjzA92EzcLquhGd1cSL
   9DML+lJCBwAkdA1o+q2lcJfVKA63Vmgkg104RTyH1r2YemyBhtvTnXoBY
   NLQcvdB9W0nmweLsm3RHn2NiMcsqI18XEUrwCeaLvFHSdXBHD0H+fYnpu
   fS/EjfDHbOEYK/64ZwndO6khGSL6W7s5dHfyc2T+6jGWIU+0eZ8Ga3vWe
   X9H9g6+fdUIN8nLM2P1MhUT6sIRbqcCwILEMrNa1FNBD8DG6pGVt7LLFZ
   A==;
X-CSE-ConnectionGUID: e/SVJj66RCO0FZgDI4YRCw==
X-CSE-MsgGUID: y5Abgz53R1Sx8VIjg0eXSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="91862953"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="91862953"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 21:11:43 -0700
X-CSE-ConnectionGUID: TIiEOseMRQOW6K6ZL2R/bQ==
X-CSE-MsgGUID: CaXugDwlSCydMPhCiK9jSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="225737220"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 21:11:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 21:11:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 21:11:41 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.27)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 21:11:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFbRgCZ7sP9YwVdqdbK3Po9M+3bR7wTugmL3M8K/CKSlvjSr/Dx3gyHn2RvtplH4+KRu7yMd7CxOm73WoT2tTflY6r58uwpW349inHRjb4Tyxy2k7/ri3Dp1ySkgNNrsay+f4Z9c997RgqPPmu8bgtF3zhnaaj4uUYPPzu11Nzlm3+d4gPAL/YKYxysDznd10SYq7yNU4ezj6/KArwyakgs8B74Yg+4NfGnodNAp4eYIdovzF5OFWikRrwx3pxr7hR4JUzzM7x6qoIL3hmeN+1sY0ADos/0QzLc8rTqr5EDUDiVPK6DvXRZ9c6PCKIWaHZ2J0sFV596jQvbgq24/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeqNKp4YnBHxDRktv0Aa8+M5ZBwDR75adNe0CCE2KOk=;
 b=a7A7IE66J+800a+i5ERetUP+PvTzpO3BP0KvBuOyDGfmu+lcgIcq40gDdmVEu5CAZIeCBD1+uCHPB68QFTEBmAQeouLdc6VL6WuP7wT1th3UFnGP4EvFDk5oNBnBBRl8xvs+ET147wAXNVTGKV88AD3rWs1SZ5weXcnnstBXozfxMtpVK4pX6ELd/THQRcBc7nSxRhBAJBOMUKZqKsdfSC5sUhtBagzNi5LP5WnT3gO7ZuBpyPggLp9jFkWeHlKJdoiWryKqgmP+e70JiJ74AoPw6RGL17eNkZIlTjjygRqFWPMc57TZ6PVVulGYErSL42jvIUPD3wyd7HRPc58pLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7390.namprd11.prod.outlook.com (2603:10b6:610:14e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 04:11:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 04:11:33 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Mar 2026 21:11:32 -0700
To: Greg KH <gregkh@linuxfoundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>, <bhelgaas@google.com>,
	<alistair23@gmail.com>, <lukas@wunner.de>, <jgg@nvidia.com>, "Christoph
 Hellwig" <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Roman Kisel
	<romank@linux.microsoft.com>, Samuel Ortiz <sameo@rivosinc.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Message-ID: <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
In-Reply-To: <2026031230-mastiff-create-7593@gregkh>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-4-dan.j.williams@intel.com>
 <2026031230-mastiff-create-7593@gregkh>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cf925b-5bc8-4aa9-362d-08de80b69cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: PwaD1rHdGnu2ch5TIuej3Iq2hrlkCJaJLICiOS15GxBKAZ4DkeeS9eBcr23HvIwrG11THETWVBYQvubBeC9hRKTcT18dv0rZDDXFaLNxiyG72+u7+SiISeJYb4/KOM+nyK25X/HR50k9Loza6nxZE/rdmpBjyGR03S4OdsNRnAkSCmxqSKBK5Uqvk4qt5WXvMurW/xZ4WYfMJRTAHU8+oklLrWfrar7f4DglYm0+KuGM11hVWEfSCMRNirENsmU43pNYeqh0bs4GG8ohHBD8G+hcQcoGTXmfVC4XgsbEoweU3s4lv1obsg4aPgzRM/QT4xT9m5qdkAhkZ3sP5uSSXn544cRxEE11gVxIeQ/94M7y+GHjD7OflZpxvm2bbxuU/kX7Q7uCcGDiED3BMl5Myr4vylseZYQjjS67MbyH5Lf7POGw198oyhnEH0lrOKLIM/vMUF8jASLQz9RtUheRTg3R1iS9E8Y+LeECL8l7on9JfkA22PHpY4n/zytinvchHK3IpadDgwv/EClSqVZMzqhZHoq1dBAXL8djzZQdegJZOgHZxSb+zQed5O2t/C77WklKeXIif0mo8+vLk9NA09ymg6nowmsQpbO8a0lRlblqqGGFhKyKkNQ1/cSnUJj9Qo5SxwoMRRyfHGFrqY9FCNyZsBHYX5Uni4zULFVphyhg0sHNlyS5DY4XWmDnok3YTo2OYa8YIXBFOIzFDAYupJm8dTWCfqJ1ztuciNiFCoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUtkUktoSDdKOVFsRzlKSkJ2cUVjU2duNUg5cE14YUg3WDdONVJkTFNwalNn?=
 =?utf-8?B?b3JyMytSdFBzYnlNMDdDdWdyN091Q05pRlRodjNlM2RqK2xzV1hMOTdoMmxu?=
 =?utf-8?B?cVRqT216OStESnhGaW9nbW04a0NFUnIwT01IeVF1dkhqUlgyejFLcE5DTFNH?=
 =?utf-8?B?Z0libFF1Zk5wYlQzZFpaOUJ4YktTMlQ5M3BsaUVjVGNRcC9mWEkvQ3Fwd0Fx?=
 =?utf-8?B?NXpuVDZMOVpLNWVoMWRHZzZOSHpjcSt4SU92cytlUlpTcGVIalZjcFRSVUlC?=
 =?utf-8?B?eG1NQzJONXB1YmxTRFJqTVhSSytSZHJybmRrM0s1ODdRa1A4UXQzcWxmQ0F4?=
 =?utf-8?B?dWhIRHg3OGVkNVJxT2RWdkVZazROOVpqdHVmUjliZ2dBOEV0V21Ec25tY3pR?=
 =?utf-8?B?aUZvY1F1aVJ2MDBOS2s3akdBODZBK2V2REw1d1VheC83aHBxOVJiNVEvdXl5?=
 =?utf-8?B?QnJmcUtZQno3a04vNjdhMHVseVFlWWhodEMvWmZicUMxdkVEMU1tSE9vREFo?=
 =?utf-8?B?Y1NzYnJRT0V1UTJCeDZWSDBOMkhTOTY0NzNoTGRWMGFSUDNuS0QrS3VJTkFn?=
 =?utf-8?B?cExOL1FiUXYra3hjcHJHOHdmTVkwK1F5UzBCR0JyTklDV0VpNmV6cElTc2Fp?=
 =?utf-8?B?ckhGNHlhcDhHZFBXS3dpYlAwblpuSGZrQ3pzdFRTTEFNTU5OQmkwYXAwRFZZ?=
 =?utf-8?B?b3l5eUJoSDNwaXRtbXNYYmQ5RktJQW9SOUhOaUpnTEhMVXQwVDdjODdDTmIy?=
 =?utf-8?B?cUkrOExqdmQ3dEdTbm9jL2MrNzZOT3laeDY1UmVMUmtpdGM2T3F5S1RuM3Ri?=
 =?utf-8?B?TmJ0cXBRbnBVd1lkR3FHREV3RkVVWFlmWi9mbUJnSEUxTzdTbWVhVmR6Z2pm?=
 =?utf-8?B?UHROa1hISWlabERNUzl4WjBFMzR5L3E1TmNmQTIySm5oMmI4SUJLRjlnU0VW?=
 =?utf-8?B?dUFTSndEdUgvdEdTalYwZjdFVVEyY0hYM1Z0Mi9BbDg5aWdNbVQ2dGZ0dCtW?=
 =?utf-8?B?QmY0Z0x5WnRTMGJ5QnZ6cXl5K2xvUVlQNEFHVWlmdmUxTmEvQk00YUVJZVR6?=
 =?utf-8?B?bm1rVVNnQnQ3THRwQzNzK3F3RE1CRmxUclc3WFJZNFBzTkdTekhNSE0rYWs3?=
 =?utf-8?B?MGlUWGdXYmFvZ1l0aTNnR3VDcXhqQUVkMG81YzZWRkxydlk4c3lBcDdpNkI0?=
 =?utf-8?B?b1daVUFEQnZTcnRHRXZHc0VvYis0YkZIOW9KcU1QQlpVSEJHRzVUSUZTdklm?=
 =?utf-8?B?NFM2Z0dtdWoydWtVUkNvS3RENlBxcEJXbjRmeGVqNytPSGQ5MTNidVNrVzhB?=
 =?utf-8?B?MHhsMWMzMW82cFZOWUFYU1ozQnlNRTNpWTFkSnBIU3FxbFEwMFVxbHUwSmla?=
 =?utf-8?B?aUhVSG9oYUorSTl1VDllZ3ZnWGZkVmxBSzFwdWpyZlYvM1BOL0Vma3d1Z3d5?=
 =?utf-8?B?VlNNa2RPRDZLUGdzakdsNWFuZ0pvTncrWitjRkN2R2hoMy9VWTFPZmpwYnlO?=
 =?utf-8?B?NE5lejB4NDdlVUFEZFRuaDdlUTN2ZS9oZklFOFY4OU44ZUxPYVVXUUpBa3hq?=
 =?utf-8?B?b3lwSWJxRktQVG9iZWxpSTJJclQ5b0hQQjJicy9ObDFyWUtRSU10MUVMc1JW?=
 =?utf-8?B?ZFc4dHNTYnh4YWFGejFIaFhzKzA2WU5lSGJjTFVEYWJ3azE5MEhUMDR2czFP?=
 =?utf-8?B?S1ViU0x3cVRuUDkvdGE4SkNQbnl3Z3AwYzA1M0FZMEdZWEw3QWt5MkpwbUVt?=
 =?utf-8?B?am9IWkhpc0JVRGF4VGg5UFlTbWI5R0Uyd3ZQOHhwWjV1Ynd1WjFDbTVINUJM?=
 =?utf-8?B?RWZiSFkyQlY3OUNQeHJxMEl0bnpwb0k0K3JIOTcwTExHN1hmNVpjRGJGQlFz?=
 =?utf-8?B?S09CaSs4cEI5TklQdzNtOW9BNXpIWStMZFVGUlR6Wlp3cStzZlNQV1c4Q21S?=
 =?utf-8?B?L0JZQ0p1OG1BWGhVNjZEU3Y0d05uU0ZkT3RkcFVJZ2J2R1REMXY3NTlvU242?=
 =?utf-8?B?Q2lZL3BBRitTRFMzVVJxTWg2U1B1Z0V5REZDNFp6R3NvN3NSSWpEWGZzWHd6?=
 =?utf-8?B?S21JT0lZWWdXbFhoaVBoSHRYMDdrcmpqMGVyYW1jaXpYTXhORW9ONFVRWGc0?=
 =?utf-8?B?Q3cvZVh1d04zc25ZdC9WTW40WXZxODllQ2NpQWc5eHhicktIN1U3dC8rOXRX?=
 =?utf-8?B?bjF4K0lsM0h3NERRcXVaa0dEOEE4c3NwelQ3TFh2ZmFhWGY2M0Rsb0JGdXdx?=
 =?utf-8?B?VWRXN0xaRk5OQWZkVFBTQm00QklXTE1GUUwrcmZyeEdjaVdqbXBLRHNEOGxV?=
 =?utf-8?B?dTFDUXkwcENZK2FUeG9jWGZQUGxoRUlOT2ZmTVRhQWtzbFYwMFJWeEMvVW4w?=
 =?utf-8?Q?PIy/I7qIlRNBLoRk=3D?=
X-Exchange-RoutingPolicyChecked: dI5y0Qf49Yew02Ahcb/O+LfksJx7oNTqI41HXYNrrHXeh9i3KfvB1aXAMkEluOgWRip0GzkU6hJ9DOn8FCzQ3v4Y7ujqeCtPXNrDRd1OhbAz22YObD4XuL4VbcZilLoyq1wBeA7+jp+PVXHUeYFcndrq69zvlyt95biQcxttCSr+u4k90DBmuvonnTVLyn5Orb6eCuh2/YXGls5WTchT9LBZFGyVXeRJF+F9rF7gFF4QbCJmbMiFUzATHMQKTlxZgGJWpKCmxaTq0E/agDf9wB0ZVMWTaveV4G1Y1eQb+oBn1NF60f2/AJ5urZhiwktGfDle05lBhvD7jhGBJw6eQQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cf925b-5bc8-4aa9-362d-08de80b69cae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 04:11:33.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6A/UVWe5bG/nuenuEvNcaNe1BPYJ1fm13gEQA7++cNbsnOjzneIeNA7Mysmoo7sigvLVrvGdtgsR8vOlrAJ3N0MrAgEVMrxqHc09ZfO3ZpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7390
X-OriginatorOrg: intel.com

Greg KH wrote:
> On Mon, Mar 02, 2026 at 04:01:51PM -0800, Dan Williams wrote:
> > An "accepted" device is one that is allowed to access private memory within
> > a Trusted Computing Boundary (TCB). The concept of "acceptance" is distinct
> > from other device properties like usb_device::authorized, or
> > tb_switch::authorized. The entry to the accepted state is a violent
> > operation in which the device will reject MMIO requests that are not
> > encrypted, and the device enters a new IOMMU protection domain to allow it
> > to access addresses that were previously off-limits.
> 
> Trying to mix/match "acceptance" with "authorized" is going to be a
> nightmare, what's the combination that can happen here over time?

I do think Linux needs to mix/match these concepts. "Authorization" is a
kernel policy to operate a device at all. "Acceptance" is a mechanism
to operate a device within a hardware TCB boundary.

So, the truth table of combinations would be:

accepted	authorized	result
0		0		logically and physically disconnected device

0		1		connected device, DMA is bounce buffered
				and loses confidentiality, integrity,
				and performance

1		0		logically disconnected device, but a
				relying party trusts that the device is
				not spoofing authorization.

1		1		connected device, DMA is direct and gains
				confidentiality, integrity and performance

To say it another way, when the above distinguishes "logically" vs
"physically" disconnected it is whether the device interface can be
verified to not be under adversarial control. An unaccepted device can
do limited damage, but still can bounce buffer secrets out of the TCB if
so directed.

> We need to either "trust" or "not trust" the device, and the bus can
> decide what to do with that value (if anything).  The DMA layer can then
> use that value to do:

Trust is separate. For example, there are deployed use cases today where
the device is trusted, but unaccepted. Acceptance support for those
cases is mostly a performance optimization to be able to stop performing
software encryption on top of DMA bounce buffering.

> > Subsystems like the DMA mapping layer, that need to modify their behavior
> > based on the accept state, may only have access to the base 'struct
> > device'.
> 
> ^this.

The DMA layer is not operating on a trust concept it is effectively
being told to select an IOMMU.

> > It is also likely that the concept of TCB acceptance grows beyond
> > PCI devices over time. For these reasons, introduce the concept of
> > acceptance in 'struct device_private' which is device common, but only
> > suitable for buses and built-in infrastructure to consume.
> 
> Busses are what can control this, but please, let's not make this a
> cc-only type thing.  We have the idea of trust starting to propagate
> through a number of different busses, let's get it right here, so we
> don't have to have all of these different bus-specific hacks like we do
> today.

The conflation of "trust" and "acceptance" has been the main stumbling
block of past proposals. As you have said before "kernel drivers trust
their devices". That precedent is not being touched in this proposal.
Instead, give userspace all the tools it needs to deploy policy about
when to operate a device. When it does decide to operate the device give
it the mechanism to add confidentiality, integrity and performance to
that operation.

This is a "CC-only type thing" because only CC partitions the system
into two device domains. One where "trusted unaccepted" devices can
operate without CC protections and "trusted accepted" devices can
operate with CC protections and direct DMA.

> 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Roman Kisel <romank@linux.microsoft.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Xu Yilun <yilun.xu@linux.intel.com>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/base/Kconfig   |  4 +++
> >  drivers/base/Makefile  |  1 +
> >  drivers/base/base.h    |  9 +++++++
> >  include/linux/device.h | 22 ++++++++++++++++
> >  drivers/base/coco.c    | 58 ++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 94 insertions(+)
> >  create mode 100644 drivers/base/coco.c
> > 
> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > index 1786d87b29e2..d4743bf978ec 100644
> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -249,4 +249,8 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
> >  	  command line option on every system/board your kernel is expected to
> >  	  work on.
> >  
> > +config CONFIDENTIAL_DEVICES
> > +	depends on ARCH_HAS_CC_PLATFORM
> > +	bool
> > +
> >  endmenu
> > diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> > index 8074a10183dc..e11052cd5253 100644
> > --- a/drivers/base/Makefile
> > +++ b/drivers/base/Makefile
> > @@ -27,6 +27,7 @@ obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
> >  obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
> >  obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
> >  obj-$(CONFIG_ACPI) += physical_location.o
> > +obj-$(CONFIG_CONFIDENTIAL_DEVICES) += coco.o
> >  
> >  obj-y			+= test/
> >  
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index b68355f5d6e3..1ae9a1679504 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -119,8 +119,13 @@ struct driver_type {
> >   * @dead: This device is currently either in the process of or has been
> >   *	  removed from the system. Any asynchronous events scheduled for this
> >   *	  device should exit without taking any action.
> > + * @cc_accepted: track the TEE acceptance state of the device for deferred
> > + *		 probing, MMIO mapping type, and SWIOTLB bypass for private memory DMA.
> >   *
> >   * Nothing outside of the driver core should ever touch these fields.
> > + *
> > + * All bitfield flags are manipulated under device_lock() to avoid
> > + * read-modify-write collisions.
> >   */
> >  struct device_private {
> >  	struct klist klist_children;
> > @@ -136,6 +141,10 @@ struct device_private {
> >  	struct driver_type driver_type;
> >  #endif
> >  	u8 dead:1;
> > +#ifdef CONFIG_CONFIDENTIAL_DEVICES
> > +	u8 cc_accepted:1;
> > +#endif
> 
> Just make this:
> 	u8 trusted:1;
> 
> no need for an #ifdef.

Ok.

> 
> 
> > +
> >  };
> >  #define to_device_private_parent(obj)	\
> >  	container_of(obj, struct device_private, knode_parent)
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 0be95294b6e6..4470365d772b 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -1191,6 +1191,28 @@ static inline bool device_link_test(const struct device_link *link, u32 flags)
> >  	return !!(link->flags & flags);
> >  }
> >  
> > +/* Confidential Device state helpers */
> > +#ifdef CONFIG_CONFIDENTIAL_DEVICES
> > +int device_cc_accept(struct device *dev);
> > +int device_cc_reject(struct device *dev);
> > +bool device_cc_accepted(struct device *dev);
> > +#else
> > +static inline int device_cc_accept(struct device *dev)
> 
> No __must_hold() usage?  That's best to check this at build time, not
> just relying on:
> 
> > +{
> > +	lockdep_assert_held(&dev->mutex);
> 
> runtime checks.
> 
> Same for all the calls here.

Ok, will take a look and convert.

> > +/**
> > + * device_cc_accept(): Mark a device as able to access private memory
> > + * @dev: device to accept
> > + *
> > + * Confidential bus drivers use this helper to accept devices. For example, PCI
> > + * has a sysfs ABI to accept devices after relying party attestation.
> > + *
> > + * Given that moving a device into confidential / private operation implicates
> > + * changes to MMIO mapping attributes and DMA mappings, the transition must be
> > + * done while the device is idle (driver detached).
> > + */
> > +int device_cc_accept(struct device *dev)
> > +{
> > +	lockdep_assert_held(&dev->mutex);
> > +
> > +	if (dev->driver)
> > +		return -EBUSY;
> 
> So you are saying that once a driver is bound, it is "trusted"?  That's
> fine, but maybe you don't want to do that in the core, shouldn't that be
> a bus-specific thing?

No, per above this not about trust. This is about the fact that the
device can not switch between DMA/IOMMU and encrypted MMIO operational
models while it may have active DMA or MMIO mappings. So the check here
is to observe that the mechanism of toggling inside / outside TCB
operation is so violent as to not be something that can change while the
device is being operated by a driver.

> 
> this could then be:
> int device_trust(struct device *dev);
> int device_untrust(struct device *dev);  /* ugh, bad name, pick something else? */
> bool device_trusted(struct device *dev);
> 
> but note, do you ever want to move a device from trusted to untrusted?
> What would cause that?

Moving to unaccepted operation is when any detail that the relying party
used to make "accept" decision changed. For example, the device moves
to the ERROR security state from severe events like PCIe link encryption
loss, to modest events like the host VMM toggled the bus-master-enable
bit in the physical function's command register.

So error recovery takes the device from RUN to ERROR before it can be
transitioned back to LOCK then RUN (accepted). But also a coordinated
firmware update would need to take the device from RUN to UNLOCKED to
LOCKED (revalidate device evidence) back to RUN.
