Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6143BBFDA;
	Mon,  3 Aug 2026 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769278; cv=fail; b=lFoRvRnEdjoM3gkx5u4SNKHkJkkMh9KO3bvocK1yxNiyToPbSaBUS5JIV4wCKLi2m6bpmqK6tAavOrs6/LaBojNs0FsCGjlef7HTVomPPHyoQCKu5SomL+fzI0Iksr/l06ND5CInT626GTqdUIgIY7eVpka5uTUcPSpnlNdJZ2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769278; c=relaxed/simple;
	bh=9+hv4O1cSA/ZFMXlp9J4SaUkjO9EAoO4nnp9efpVKSs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W36BB3yjmNtYonrKJ1s7t8clyUHZ08P+sdtt2MgvXwTnAdeBzCrLEOaSzjeR3wFMlwNkjT4ss1MGfUZ+xZsnR3Ng/L4RrvqOdMvvHKWDRQ4es1Ya348wI0I2HTwzvdiicLslgLnsNtO5rFhVzX0LAzgA7mig9+jitN+7dE4JDPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKqZ70JD; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKqZ70JD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785769276; x=1817305276;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9+hv4O1cSA/ZFMXlp9J4SaUkjO9EAoO4nnp9efpVKSs=;
  b=IKqZ70JD+UehHYMituE/fRVZFWZ+zPB8xpNLiRx+wu/EZKucUNR2noey
   RbGWwJ+O1z8pfSPSbx1yAR2lRvM/f3qO+Kt5YLBGpJCupYKumGdRR7lGl
   zjqgnMqjzMFiHqRN2H0IR7Py7eM0fsN5hzhmFDlxWzNv6kMv1KCa2CF0y
   tJ2IYuiB0Jb0DlbLrsIKGCyufhE19g9jyEkNejHBZioE781TzaQylkyek
   /emAIKNdqphnaMmV6SDXhEU93O8xdVkCGRowVJV/XLloiLA+6KMAkJZYt
   vWcobxThbtI4ya+h8Bb8kl7fJbPDzmxs2lj9F75ainEkDJaNZ/eY7HKPa
   w==;
X-CSE-ConnectionGUID: KPDwPXucSJSefVLYpHWwJg==
X-CSE-MsgGUID: ZJHhfymrR6qy/VHuAZw9GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="73842058"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="73842058"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 08:01:16 -0700
X-CSE-ConnectionGUID: ja01mJZKTXOO56G0gafyUA==
X-CSE-MsgGUID: 5F3RWJpdSeyjj10xlXrj0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="284624358"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 07:49:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 07:49:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 07:49:09 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.68)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 07:49:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7hqYSpn5Ui7C7TDt7IXEabbCXzz/j6e5RtQbVXjmF3zNgIRAvd6a+Q4MPZV2Lo6pdQBwPGwrYGWcoCBzELYiKk2ulpHfAujxkF+QmbXItaFH1xjapLBE/WstRo0eFqd7P3rwL2Crhby7GzQQXK5K412C/kgxjlaM4uiteBkm12+fectRx/r/RQkvp0UBYCeD8VA54O1fKwMmdoSZ4cdXz44FFsSIbpAuSloeo0WWh98u2V2IHRhYbaTq8MRmGVIU6kz3PWsovzxjaVL8YI1pA+pc1YOQVs0wB+UDm0OvKmtz9q6ttUZGF3Lh2B8QKwUhwaXNoUxw29G5UiRnSxNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+qq1MWTDH2EmCpoco/7RCW2+6F/1Si0ytVOSvJShmY=;
 b=pmfIoHaG+UT5o0vv5VibE8+h76AgZ8DAf+vj4BUVmF74weDMd8V76SoYbuQz8u5sde96YfmgJt8lew3WlPTry0Q4l4mYtOIMTeUeZv/1Mt65KFEMz+w/hRcYjyw7Mubf5KmClzlwbuILSry995gqhTR5ARI59hoHVkchtpJT7BWIQYaFwicYIxJU6H+lTWMwxmb+mclYwLWYamlids847+aS0MHjhbq+7M48JEWDXdLSMG3j1XlJa7eOsM6ZfGKlksqDT0I82GbwIMSyXG/iu+bRWZVFholhMRFUE7Sc+JpVS4AOhZMS0L0eC9HwPWu+FSxF2rKORruSvK93yCZxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ5PPF3A51834D3.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::821) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:49:04 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 14:49:03 +0000
Message-ID: <e05e4092-a3b8-47f9-b083-e893729806c6@intel.com>
Date: Mon, 3 Aug 2026 17:48:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/8] i3c: master: Add helper to query bus wakeup
 requirements
To: Frank Li <Frank.li@oss.nxp.com>
CC: <alexandre.belloni@bootlin.com>, <Frank.Li@nxp.com>, <rafael@kernel.org>,
	<linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-5-adrian.hunter@intel.com>
 <amkLJ_sbc8AoflzR@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <amkLJ_sbc8AoflzR@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::26) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ5PPF3A51834D3:EE_
X-MS-Office365-Filtering-Correlation-Id: 244cf8bc-be38-4380-c6ae-08def16e5cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hxcL3tY/masWGo1tmDHI16fWynEAjcRkV0Eus2aD5GfgFmP3OGzVWvSNzCSBvcdG4He9rTfX70n7HUzwGTfgpmWv4m5U9UFGdyuzWG0AgOeQW+q2nY6+QknetAC02s1K6UwoyU9vt39NNzPKVi2SvBh3Wyqc9jGkIXP/teDzSEr51kNuZSzB2lAAqPgYBZu1ORKM0nEIdBJkHAQtUlOiH8qNLHoCtMFf2zwpsI+GcrDxKJf925V6Vnl6RuFLXjloT4g6s2/UFceDFm6HBx7kan+nALRqDYQaR8uqt1irhuA9imIDTwp4FEtkW1Vf2oL43qlrDPzI2TQH+iCCyZlIMUEAk2jJ8OuFqJd3Gp/MR+tcmGztV5e/7mgGIof3elVslKuXuRue9lrqYdtPc3hMSHNEvemARbfiJY9x3fRO+eXYoMYZhJlRyvHsqlwkUjLkCAr5Ylb39lPOsw6IHIPPw+RAQV4d/cj1WDPLmmTvbn/6EEsBoDcifWArN0HAHZiCC1T8lc09b2V1/8srD/B1Zs5TCJX040zCxpcB5XMRUt9a+Y7TuCDtVCFHoicaGyi/XgMFmT1VX5lpU++IZLVozyF2saMkL72QPpqBEP0P9ZM4pTHhUopKQCfd+3MgG6blUb9BmGbWN1Ub/DdO4BDEqqzVfQd38wWlgL5U2S999AA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUZQcjhtMWIzbDNJNVd3MTJZQkQxMzFwN1F3V2x0NU9yZGl6RTRqMlpoS2lt?=
 =?utf-8?B?WjJ2OFdWcitleUFHZjRJa05ldFR0QThXaVowNjErVnlxOFhQZnFWSWxlNW44?=
 =?utf-8?B?VDV5ditYS0dBeGFTMmMyNTQxV29Na01XblVxeldoMUxaSlY4TUgwTDhLQkNk?=
 =?utf-8?B?alNucURRY3N4akthYzdWS0pocWJQWGFGYnpUNkRuQmQ1RmRpa21nUmJlc3NN?=
 =?utf-8?B?QTNVVldKYkd1Yk5BZ2h6eGNDZ0hjVnl6TUlnMjY4WjFQdzdQT1dna01WaE96?=
 =?utf-8?B?OThiNTlYSlVLRnZPZ0ZCTFM1QS92NUFDYU1pNWsrVnR2UkxMMXhidG53N0ht?=
 =?utf-8?B?U01HSktTL1l6bGxrTy9uejVEdmdrMDF1SlpwRFNkaVhmbThVT0xhUkl5UThO?=
 =?utf-8?B?REVESzMyaEMySC9WVCtQMFpoZ2t4L3FYc2UwQTFSNnptNGUvM2xOTEJaU2Na?=
 =?utf-8?B?SVA0N3E2QmZ0UzBFL2hvSjZwcmMwek5GVkxYTHVlVndLQVpxNkM2WXVCMW43?=
 =?utf-8?B?OWh1S0NCVHpaekliVnI1Vzl1ZVBqMVk3dVhTL3MyajZWaUJ1NnpudjI2YjY0?=
 =?utf-8?B?M05nN0psUlovSkJJNXVUNk9GWUo1bEJXbWZQSHhId1cxdlBoZ2RmMzR4WE41?=
 =?utf-8?B?MFRidTk3U2tFUUFSWE93aS9jSnpDd2JFRGxnQVJ5elJzQjVlTWVKYU1vb1lJ?=
 =?utf-8?B?SldGQmIyQy9QaXhhdDVXV2xZZHZDZVNJdis0VWZVTWhFWXZvcWhFdUFQUVRs?=
 =?utf-8?B?UWg2WVdGNTF3d3NRS0JFazE1eDVnSTNaRGZaMXp1bzA2Z1o0Ylh2OTJib2xx?=
 =?utf-8?B?Wkh1c3gxVUVyb2dhcXJxd3RKVjFscW5oNVNnVlNSK2dWVWRFbmo3U3VUa3k4?=
 =?utf-8?B?dWtVVzJqQTBORjBJTTRURndzd3FOUTVuRy9BY1pldGRlaCtuZnZJNTg4c2FK?=
 =?utf-8?B?K2JIeWszS2ZDK1RQWSt5THI2eW5yWExCNWNwcXNMSnBjK0JCRlRyZFV0NFVE?=
 =?utf-8?B?NVBKVWJ4QWpGMXR1QWVwR2pqNmpQSytOSW1jWVl4ZTRmajhSNWh0TDEwK3dY?=
 =?utf-8?B?czVTLyt5L3RjWEluUGR2ZnIvMG5IWVErTmdSRGlDWWhtRlBSRTNQbDRwNnk5?=
 =?utf-8?B?dGh4TG8vMEVXd3h4REl1T050RCtIRHpKL1VTd3gvaGU1MENrZVFVUXJiSExZ?=
 =?utf-8?B?WTdoNDRlRUhxNlFuVkZ5OHZPUXV1MWpybGEvVSsrZjI0azFwVWE5Ris4TE1k?=
 =?utf-8?B?QUhVN1ErZVp3UFlyZW9Vb1g0QkZXUDEycHlZNmR6bUo1V3FJbGM1enVvRXl5?=
 =?utf-8?B?RVZFL01WbC8xZVdjZWNVZnJOZnJ5d1NRazViQjU0akNnRUY2cjVIUE5Ud3U3?=
 =?utf-8?B?Y2lSdXJUTFdGVy8reDBBNEZYVzJlT05xUm1NUnNlMXc0TkIrTXVtanY0Yk9r?=
 =?utf-8?B?dXRPWXpJcU1ESGlnOGdSYk4vdFQybnpoOTg4TFg0T3JITzVMM1RySXNWRUJM?=
 =?utf-8?B?WWVSVU1iS3pna0VjbzdodXpLOHhSVGdLVTJxY1RSMS9Hc2M4eG45UUo2MDBX?=
 =?utf-8?B?SFJJTXJqTDFOaGxNTW5EZ1B0bk9FbEE3VEw0dmVmb2ZoRDFibFIzcWx4TUJ0?=
 =?utf-8?B?T1M2bHNYMXRsWjRyZmNsOGRWRm1USnF3YlRYSDdrWXJKMHVQd09IVXpFdDly?=
 =?utf-8?B?MmdValBsb0lHRUFSL2V5ZVpqSzQvMGpaMXE5aGJxTUlONVMvSTZQNFRZanU4?=
 =?utf-8?B?OGJFdVVHZVM4L2I0YnJvWkFDS2htM2tpbHExR1ZhT3J4czRxK1hvSi8rVXRx?=
 =?utf-8?B?Tyt6YlBQUWJsUkErMlFiSUIzazNZTlZmM2ZpUklJdk5mNHhrRittTUJNRTFn?=
 =?utf-8?B?OUpPbU01cGFmOStJNWFUWnV2aldkS0NaeUk2Z3luY0ZoMUk4a1RncnZhdnZ0?=
 =?utf-8?B?MGx3VU50M0lLT0pxRUdHK2FFaE5jVU5EYTRjT2xMOXY3QU5La0c5aWVOTFho?=
 =?utf-8?B?YUJ2dDF2V2hqY2ExbTBVc1JQVlczZ3hBeWhpeHh4MkhncE1KNXhweHRxbWFs?=
 =?utf-8?B?RTdtTlBvZnV2L2JzTmI5bVZIdVZRRVhLaERCYUIyZ1pCSE82L0lHbDFVeDJC?=
 =?utf-8?B?TjZWSnhzVmo5U0J1SFlqeTMvSUtVdmdSeVU5cWhjeWpsYTBpT2JpZjB0K3JM?=
 =?utf-8?B?Yk9FMlV2aEZpM29zTnduSm9LK1AydmxGQzFBdC9LbWlQR3k2bWorMFFXd0pv?=
 =?utf-8?B?RS9vdmkxN0FZbnFlQk9XeTB2SE1SUWNyMzJYVmVpajhZN1p5RHovbGpYTzJu?=
 =?utf-8?B?L0pEejBzUzVlN0pjaXVZVW9GWUhxVHhJNjlLOFhpMnNqNWlXMWhEakhYWEsx?=
 =?utf-8?Q?M7Ezbc4dcT6rASlE=3D?=
X-Exchange-RoutingPolicyChecked: OMNL+nh1gsSvHW6b1ehu2l3c8JdsNAzJIY/h5VwIofBWdQ81DsXDmL9KRu85Da4ixkS2DteAxMdhQ2s18yKvGM5ZUeaRHplaIg1TC90yVPC/YhybT3/oExe7SV5WCaFibftNUAkdLoJ7U3oRnTFPZAben4pjBJEGlUZ0HfMNXwpKBZHO65ym0hmKxBxyNKbvHJ8WQZzqUVQYsDIXyzBa4yyt5o/p1cnShONAwPkbDmQ2FaO82ACoQs2+y138FmOMkEn6n4QKxCAGsHXH2ftMsG3WMFvY50y+AebcFiak9h4RC2lOeqcylrMqgaeS9gfqTocyhiWdUUvuJ/Xsv/8+yA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 244cf8bc-be38-4380-c6ae-08def16e5cb9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:49:03.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6r/IyZ+NIkdPFRgGsWqcFp5YK84WKIoFAULUX8T1Ikktg5TCTKKz0am5caCBWvqgZEJ1mOtdvSunVFdjK7ZoLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3A51834D3
X-OriginatorOrg: intel.com

On 28/07/2026 23:03, Frank Li wrote:
> On Tue, Jul 28, 2026 at 06:53:04PM +0300, Adrian Hunter wrote:
>> Add i3c_master_any_wakeup_enabled(), which iterates over the devices on
>> an I3C bus and reports whether any of them are enabled for system
>> wakeup and have IBI enabled.
>>
>> Controller drivers can use this helper to determine whether wakeup
>> support must remain available while the system is suspended.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>
>>
>> Changes in V2:
>>
>> 	i3c_master_any_wakeup_enabled() now also requires the device to
>> 	have IBI enabled, not just system wakeup enabled, so that a
>> 	device with no active IBI request does not keep PCI PME enabled.
>> 	desc->ibi_lock is taken while checking.  The commit message and
>> 	kernel-doc are updated to match.
>>
>>
>>  drivers/i3c/master.c       | 30 ++++++++++++++++++++++++++++++
>>  include/linux/i3c/master.h |  1 +
>>  2 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index 9d56ca08569a..dd49652425b4 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
>> @@ -2048,6 +2048,36 @@ static void i3c_master_reg_work_fn(struct work_struct *work)
>>  	i3c_master_register_new_i3c_devs(master);
>>  }
>>
>> +/**
>> + * i3c_master_any_wakeup_enabled() - check if any device can wake the system
>> + * @master: I3C master controller
>> + *
>> + * Iterate over devices on the bus and return true if any device has
>> + * system wakeup enabled and IBI enabled.
>> + *
>> + * Return: true if any device may wake the system via IBI, false otherwise.
>> + */
>> +bool i3c_master_any_wakeup_enabled(struct i3c_master_controller *master)
>> +{
> 
> This check most like introdouce rise condition.
> 
> if (i3c_master_any_wakeup_enabled())
> 	do_some_thing()
> 
> no lock protection, so between check i3c_master_any_wakeup_enabled() and
> do_some_thing(), condtion may be changed.

It should be called when the condition cannot change anymore.

It is being called on controller suspend path.  device_may_wakeup()
should not change after user space is frozen.  I3C device drivers have
already had their ->suspend() callbacks called, but should not really
be doing anything that alters the outcome of i3c_master_any_wakeup_enabled()
anyway.

> 
> Frank
> 
>> +	struct i3c_dev_desc *desc;
>> +	bool wakeup = false;
>> +
>> +	i3c_bus_normaluse_lock(&master->bus);
>> +	i3c_bus_for_each_i3cdev(&master->bus, desc) {
>> +		if (!desc->dev || !device_may_wakeup(&desc->dev->dev))
>> +			continue;
>> +		guard(mutex)(&desc->ibi_lock);
>> +		if (desc->ibi && desc->ibi->enabled) {
>> +			wakeup = true;
>> +			break;
>> +		}
>> +	}
>> +	i3c_bus_normaluse_unlock(&master->bus);
>> +
>> +	return wakeup;
>> +}
>> +EXPORT_SYMBOL_GPL(i3c_master_any_wakeup_enabled);
>> +
>>  /**
>>   * i3c_master_dma_map_single() - Map buffer for single DMA transfer
>>   * @dev: device object of a device doing DMA
>> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
>> index 99f89fef7653..d8cdc7ff2459 100644
>> --- a/include/linux/i3c/master.h
>> +++ b/include/linux/i3c/master.h
>> @@ -748,6 +748,7 @@ void i3c_generic_ibi_recycle_slot(struct i3c_generic_ibi_pool *pool,
>>  				  struct i3c_ibi_slot *slot);
>>
>>  void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot);
>> +bool i3c_master_any_wakeup_enabled(struct i3c_master_controller *master);
>>
>>  struct i3c_ibi_slot *i3c_master_get_free_ibi_slot(struct i3c_dev_desc *dev);
>>
>> --
>> 2.53.0
>>

