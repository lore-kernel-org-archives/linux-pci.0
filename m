Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E2D480949;
	Tue,  4 Aug 2026 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862264; cv=fail; b=NlZLKnF+kxpt6Ssa4e+HHXUSehANuY8fd7AMZ4SdNqGGskI2ZBruiSJes9cVLjqDaVSWdP2W2dfumDYuXWx1m9G6AWjsVtYQq/c25dJG+Pspti/Jroc6lpdPdiqLjdsP1O1ZK5UEZpxw9NVaOvZnSI9LTjlhjHeucRZqFHYvMj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862264; c=relaxed/simple;
	bh=ZL7jAiTigAaAReaQxNOIuumzV4GUCQhHN4LFx39JAqk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ghhg9WC58yyU0MxZEKPFY9pip5xC+A6S89oZrex1piUuJ9jimHcvysKnzifiKNFtjwEgB8zDMVfBqjWe4HTXnTlQ5iJTzHwwZKBC7eOA2L4Y6RA9dtIUeaUEJpWvHK99JTzgkDtcWNTLXG0oNjZ22b09qxHfT4Xp0NKaG4Paja0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIpjvF+g; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIpjvF+g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785862254; x=1817398254;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZL7jAiTigAaAReaQxNOIuumzV4GUCQhHN4LFx39JAqk=;
  b=aIpjvF+gaa8ABq75dyDrPvj2HiXNwr39kgqs/U06do61qwuHE4cSt2nC
   bhEtq7zpFs6nDn1tyDTWQelnVbl8Xn4rvJrpwot+pEik+HOK40oT90Rgp
   DRnw1DSh5EaZI0gx/K+XRX1SbrctPKAxRtk8ftOJXs/cwcmjAd66X1l9w
   ho8kR9QVOfwcBGmUKPwP3ALX0lqBqYpzGCbCM2zcwt+pG+ggfM6NQYqqp
   S9HzJ25cwZdRDEq0HMu1zhYAR0DB/IZxFvTe+KBtWopignMm7C5PrLGhh
   r/QGU6GXVDV5cGIGQ0B/VQyyPxGVxKEdkAXrf6pccKM3YEQlQSPGCaFhf
   w==;
X-CSE-ConnectionGUID: Ad9lBYSUQAuc3FLI112nCQ==
X-CSE-MsgGUID: S0wqorcQR5iuq7W+e6bCSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86497526"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86497526"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 09:50:49 -0700
X-CSE-ConnectionGUID: fYU3N9uHRiOkuYTJQG63Ig==
X-CSE-MsgGUID: AqWYI8mZQ9iABCopLzaFkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="257236264"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 09:50:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 09:50:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 09:50:47 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.63)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 09:50:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYH5JCtz+qz9n7rLE6f67rkfxeNdOGlnQynULdRly2nIh817vmi3PwzOSWa3beEDLkwlPfXvZ6EhXQcxG0gEKD11BIm4JwSaDs2FoWpH7WESVd1H0feB6BqUDWy1YW34oUw6cVwpdQTM5xNBxGCgRkHNZLLIb24PyFMWCykY8qqod47zw3Axx5agV0hsdEpEwL/4Bp99/WYizKVNiY1+H2JF9mJ9msmUjwcC7ClSXzSQyxOmMBKnOdcsLs58FYnwNVxeT6Wu9KFm5KWmS6HqxCPpQFCEZ5TO4oXnMqRDRUqcUSPVjjF42fQiQehC9bAxAqlpR24MGFCRHntQ42T4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNzcbw+WCS/l45V/f4c80EqUCpFQKuRB7ml3Hz/QK2M=;
 b=k1lHyhVt+S3eWmAC99K1iSpl0KB/EwdjTfovGXvyrqZNm5i9HJ/HBkF600l7rNhC8jldXF/y/JxJw0dnxl/nibYpEdHhIU9KTmhapQ3MJG/vCv/MWOEaS1lQsX6UPdWdvMQ9r2WH4lTqTl8JPhari/bMcLEqukX+4MjmKqEPjGjzRppr9c9wJ2LePmaI1j8MJQu0O6trmSKjLtclmpZjHmcBj0ElvCS8xDF1LWIMwRWZv3LY1nu2poCIAhVITX9t9D89OjZo5QA2A3jnWX7xozEt7vmJ2CbAEO+z+9LjCRsSGHOTKundS30XD19Bao1BEpXT1Etiy8iS3okmpeVn/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB9752.namprd11.prod.outlook.com (2603:10b6:510:397::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 16:50:40 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 16:50:40 +0000
Message-ID: <5b0ed4bc-2f14-4d09-a099-9d69337fbba8@intel.com>
Date: Tue, 4 Aug 2026 19:50:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/14] i3c: master: Fix recursive locking during device
 registration
To: Frank Li <Frank.li@oss.nxp.com>
CC: <alexandre.belloni@bootlin.com>, <Frank.Li@nxp.com>,
	<akhilrajeev@nvidia.com>, <rafael@kernel.org>,
	<linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-2-adrian.hunter@intel.com>
 <anIXV7HvBxCtJLFD@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <anIXV7HvBxCtJLFD@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::27) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd5a012-6f7c-4e61-92d4-08def248845a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|11063799006|5023799004|4143699003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: K1kYN4LzdEsgMF+oQB2+CDViSuWIRPkAY41F+SZYq+l9zctqG1kc44d4fr0icGntAYqKTasrur7muy6JNfSSU6WV1Np134oXQrY4cnm/mnj1g4abvZv/BJvBYaegloVzU2slOhLDc7BHN2DApzalhy6Stv33EcU4+JSsgny7tV8t4sUWiYS203pqJEx3YXeMaeBYR1vZr7qqkvVvG6T5PN8HfZHtYFbKRjaW3omnnzoBmgbVhRHNQ+FQ+M1a+If7xQdLNlC1XKmXopRB/811omUlpWNkhVuu1oXqCwNqx1/LM2hkuLqUlGrlcAL/aL9c/+OJwvwHCgbjsylww7+/oSWWd6SgR0AQFAIZvM36ET1vxsakdQMds7onTIEysQo6FuxYifbSBwy5LI+33rAmXDb+Oe9MGxtrQCHo+/a4/JQXJL0mfnfvxTR4PtpDLKmDQ6lg7RwsRi/twpvWBmYJJ3hUdDt1VZCPx3VAv6xw5Gjv29Ynz1Sd0EjLWDOyMNIQaEEZNDmW6FzLFvwV2+fMxB+jbgFeSnOEZDJpAyylhRN/n1uFoW2GYpf7XokbE4eL8umUWNMMYRCvb+54nYgoaYrWy9MGsSKebSJH0hh/D+1dr7TXR1vi/V2ZOZHKUj9awjsqV6TEhCozOqPzrqbtQmTA5h4JhQVaxUYLVJvEj88=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czRIRFRmN0hUWWNHZnNYUkNuL2dkczZCcDd1WnZsNTJYSUxtTHBGVnYvN05P?=
 =?utf-8?B?OTNzSWJqNlhIK0szOS82OHBGOXB5THkrVXNMeWs1Vkl5d0d1VEJUMlA0emFi?=
 =?utf-8?B?WUUxanB3elVMZGliK1EzbXBsQk4zS082MWhNcDJiLytpemg4eGNQYTZWRVFW?=
 =?utf-8?B?cG53NEQ2Wk55ZHhFTTByby85aDAyK3RHQlZhSHkvRSt3cDloU1ZQRkg3WUFV?=
 =?utf-8?B?T20xOFZUK1pJVzZQODhVdUpOeEhzd1QrZEJacTJwMEVZSllJZFFBTExpTExG?=
 =?utf-8?B?UUF2MWNIekJtZzBXWXEyQ3ZXclEyenBnbVN0NHNieDdSclQzRHNDbXlzY0Mv?=
 =?utf-8?B?ZHFzQy9GZUt1TWV1aWpZNVRLQ0FqUlMyMDRLZjNwb2NNZXBxb0htYWdieHd5?=
 =?utf-8?B?amFIalZURHZlMUZERm5lZncrUkFWVUJ6eEgrN0JDbDVUSnB3bVVicmMvT2V2?=
 =?utf-8?B?RzNpaWNwdjhucmR1ODljQm1kcTdyZ0VwREVWVU9DYXBlKzBxVDRlcStGQlRN?=
 =?utf-8?B?bEJLcFhmWXI2RThSOFg5MGp4N2pFT1A1WXZCbTM5dHRqWGhVQ3BUbGZQNGhz?=
 =?utf-8?B?bUVlaVlxTWV4QjU1YytFY1paZmFISmhSQ3FRV0dLY21MQ1V5SW45bnBVaVo5?=
 =?utf-8?B?ckZLZUJpM1JmSEhkc3pwRnNJZEl5RU1hU3FqMHFKcDcrN2tZMUphMlFpVnFR?=
 =?utf-8?B?NEoyY0xkcGhwdjIxUjFwcmdTS3B6Z1hKZlR0N2xOMGhaNFlBWVZNZmY2VlVT?=
 =?utf-8?B?Zk02WmdJZTdJYVhGNDFFTHFsKzlzMmR0dXFGOC9VM2s5UXI4YTA1QlZUakdH?=
 =?utf-8?B?dWlaMlhlZmhjc2c5Rm8zNU9rQ3NwY3MyMnVYTTFiUFd5dHpPTlg2NDE5YVpY?=
 =?utf-8?B?WUxQNndOM2F6L1lqaStTS1k4eXdjSjNOcUNaanNBbkRIWFdmOERFYVQyaUl4?=
 =?utf-8?B?Q21HUHVHTWtBZFcrbk5COTNNZWhEQUFSakdHUmpmTzVVVlBSMU0zQ2p5K0Ev?=
 =?utf-8?B?Nk80bWllcS9mRTZKMElUZzVYdFRQZENXRHN0aDBBVnNuVklMNTFVbGJvdVpF?=
 =?utf-8?B?ZWpXOEd6T0Vjd0VzbkMzRTJZNDYrSE5yUUZSODZ6YkR4akpYdUtJRzhjVlc1?=
 =?utf-8?B?UzhheUhib3MxYVRMdFZ2OWErSHlaWWl2TEFITlNoaisvVTAzK2hjY0hJYU5E?=
 =?utf-8?B?NllTUUI2cW04TUV1NDAyeWx6ckNHNFZ6QzJQM3hScVEzcE5kMlY3VkVkWmdG?=
 =?utf-8?B?WmNWNXBKb3JpQjZFRytaMnNzOWY2UUYzN2YxclFydEtwVzZoaEVQS0dGT1pu?=
 =?utf-8?B?eWNYalJvOGduUTRyNDdXV1E0MndNTGI3YWIzYVZmV1dtdy9adEYwZmk1S0NS?=
 =?utf-8?B?Q0tBaVQzek5VeEMrUXY5bTRKVURoZVpNcU1qcHBpejR3SDd5R05mM3krRnIw?=
 =?utf-8?B?bklQeE5MMks0Q3NDUUpLZ0xaMklyUWpTNHRWMmdGWlk0ZWdZWWg0VTV1ejVv?=
 =?utf-8?B?N2lEU2ZkTmJSbXlGN0xUUCtzN1ZWRnVxeklnZGhoTFQvOEtyQ0dGR3Ewcjk3?=
 =?utf-8?B?NC9LVGZtYVVOeFJsSnRuSWVCSXdITHpySW1kamFkOEM1ZGxmNkxKcFlpRkNM?=
 =?utf-8?B?dGljaE5YcGJBalo0bU9sZzlLZlU4V3Vza2xjYVJzS2FDZ2tOdDV6QnZFYmds?=
 =?utf-8?B?K3FmRkpmTFN4RkNlMDZXcFpQd1ZHQmk0cDhpT25POUJsS3psb1U5OVJ1TlNm?=
 =?utf-8?B?cno1UXRNRDZ5REcwOG9jNGNwSXVnNU1DQjg0TU55NWZkL3JMSUxUWmtIVzgy?=
 =?utf-8?B?cy9FQy9pMzcwc0tDRG4yd2cvbDRyQXNHN0M2WnFacVRkdXN1NllTZVZHOG53?=
 =?utf-8?B?WGYzclQ2cThocGNIWTlYYk1qbWJsd0ZPWi9wY0tYZElEL0FBVXBNV04xeXVw?=
 =?utf-8?B?c1RuWUJPOEZiN3piOWljWDRuYXVKSVBaSllCVWdmTm9ITlRlSDIxc09HVEdZ?=
 =?utf-8?B?d3lFcVZtNnoxS3dMVk9LbTArZGcvczZ4a2NTaUhUM0NhdEJTVlZJQWNQRnh6?=
 =?utf-8?B?ZGVNaldTaXRSeWJiVkRhcUhQL3BEb2V6eXpzNTJHMEgrd2NzZGZTWGFCRFkz?=
 =?utf-8?B?MmxTRXcreDNVVkVFZXFTTU5DZVhYUHBJaFBRbnVFZG1yclVkR0NtRXlDaGVk?=
 =?utf-8?B?NVZyT2RBSk5HWnRsVFVNdUh1dWt0bTJ3d1lNQWh6VXBtejRZL1FJcjErVXBU?=
 =?utf-8?B?N3lhNGVBZ3lIMmd6Rk5RQy9FcExrSDdBVXJqVVBpM0hTdmJwb0tqNDV2RktB?=
 =?utf-8?B?aHU4U09jK3cwdkZhaFMrMlhOQytKaTlEMUgzQm1NNkc2WUEwUlJZSnp3eXl0?=
 =?utf-8?Q?FFIjst2Qt/TVj5Ls=3D?=
X-Exchange-RoutingPolicyChecked: dGTw3QHOu5Gqr0sbKqc24LrIUo1J5d9HXga8A+HOEbPGsdJv1+N0b3PGz+MvhxU1UmNKtBia3MeuNVPw9jYvFnCbaGHPVkLJZp5d/W5A4Xc0ML+qHGvLjldhlNFfG+nVCu5UEqSkTnddYPqpKZMUSETA/t7p3c44vHv0P0UFcHQnFQL/edeiF/XfdLNS/2updtpbPcNPCTZfTAK57W4iFofcMOWo3kWeGF91m2xocfoKmqLGzY1pqZfvwK2AIzXPVWQ3L082u2b2QbW0U0rL+4bLXrisRtpO9AA8yFQ3+gPY0CoQfTXl5l++SMq1BDD8Nxh8RdjOMPJFlL2mmP26oQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd5a012-6f7c-4e61-92d4-08def248845a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 16:50:40.7328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrcDBES0iJhokPw84EpSozWWM+1qFFhzlm49oaZfkhUUxzCPwzcpIdqCEBS4vzkz5VRjzW1Dd1llK3ovP1nDAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9752
X-OriginatorOrg: intel.com

On 04/08/2026 19:46, Frank Li wrote:
> On Tue, Aug 04, 2026 at 04:37:57PM +0300, Adrian Hunter wrote:
>> i3c_master_register_new_i3c_devs() registers newly discovered devices
>> while holding i3c_bus_normaluse_lock(), a down_read().  device_register()
>> can immediately probe the device, and probe callbacks typically invoke
>> I3C helpers that take i3c_bus_normaluse_lock() again, leading to a
>> recursive acquisition of the same rwsem.  rwsems do not support recursive
>> read locking and can deadlock when a writer is waiting.  See the
>> "Recursive read locks" section of Documentation/locking/lockdep-design.rst.
>>
>> For example, with Intel LPSS I3C, LOCKDEP generates a WARNING like:
>>   # echo intel-lpss-i3c.0 > /sys/bus/platform/drivers/mipi-i3c-hci/unbind
>>   # echo intel-lpss-i3c.0 > /sys/bus/platform/drivers/mipi-i3c-hci/bind
>>   WARNING: possible recursive locking detected
>>   kworker/5:1/94 is trying to acquire lock:
>>   ffff88811c810d78 (&i3cbus->lock){++++}-{4:4}, at: i3c_device_match_id+0x45/0x370
>>   but task is already holding lock:
>>   ffff88811c810d78 (&i3cbus->lock){++++}-{4:4}, at: i3c_master_reg_work_fn+0x21/0x5f0
>>
>> Fix this by separating device creation from device registration.
>> Populate desc->dev under the maintenance lock, collect the devices that
>> still need registration into a local list, then release the lock before
>> calling device_register().  Finally retake the lock and clean up any
>> devices that failed to register.
>>
>> Use the maintenance lock rather than the normal-use lock while adding
>> device objects.  A write-side maintenance lock prevents readers from
>> observing a partially initialized desc->dev during initial device
>> population, or desc->dev disappearing if registration fails.
>>
>> The local list requires a list node, so add a list node member to struct
>> i3c_device.
>>
>> Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>
>>
>> Changes in V3:
>>
>> 	Added Cc: stable@vger.kernel.org
>>
>> Changes in V2:
>>
>> 	New patch
>>
>>
>>  drivers/i3c/master.c       | 45 ++++++++++++++++++++++++++++----------
>>  include/linux/i3c/master.h |  2 ++
>>  2 files changed, 35 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index f485b98805cf..d2fb1a110521 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
>> @@ -2069,12 +2069,21 @@ static int i3c_master_early_i3c_dev_add(struct i3c_master_controller *master,
>>  static void
>>  i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
>>  {
>> +	struct i3c_device *i3cdev, *tmp;
>>  	struct i3c_dev_desc *desc;
>> +	LIST_HEAD(i3c_unreg_devs);
>>  	int ret;
>>
>>  	if (!master->init_done)
>>  		return;
>>
>> +	i3c_bus_maintenance_lock(&master->bus);
>> +
>> +	if (master->shutting_down) {
>> +		i3c_bus_maintenance_unlock(&master->bus);
>> +		return;
>> +	}
>> +
>>  	i3c_bus_for_each_i3cdev(&master->bus, desc) {
>>  		if (desc->dev || !desc->info.dyn_addr || desc == master->this)
>>  			continue;
>> @@ -2104,25 +2113,37 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
>>  		if (desc->boardinfo)
>>  			device_set_node(&desc->dev->dev, desc->boardinfo->fwnode);
>>
>> -		ret = device_register(&desc->dev->dev);
>> -		if (ret) {
>> -			dev_err(&master->dev,
>> -				"Failed to add I3C device (err = %d)\n", ret);
>> -			desc->dev->desc = NULL;
>> -			put_device(&desc->dev->dev);
>> -			desc->dev = NULL;
>> -		}
>> +		list_add_tail(&desc->dev->node, &i3c_unreg_devs);
>> +	}
>> +
>> +	i3c_bus_maintenance_unlock(&master->bus);
>> +
>> +	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
>> +		ret = device_register(&i3cdev->dev);
>> +		if (ret)
>> +			dev_err(&master->dev, "Failed to add I3C device (err = %d)\n", ret);
>> +		else
>> +			list_del_init(&i3cdev->node);
> 
> Is it risk del node without acquire lock?

The list head is local i3c_unreg_devs, and i3c_master_register_new_i3c_devs()
is not permitted to race with itself, by being called only from the work
function i3c_master_reg_work_fn()

> 
> Frank
> 
>> +	}
>> +
>> +	i3c_bus_maintenance_lock(&master->bus);
>> +
>> +	list_for_each_entry_safe(i3cdev, tmp, &i3c_unreg_devs, node) {
>> +		list_del(&i3cdev->node);
>> +		desc = i3cdev->desc;
>> +		i3cdev->desc = NULL;
>> +		put_device(&i3cdev->dev);
>> +		desc->dev = NULL;
>>  	}
>> +
>> +	i3c_bus_maintenance_unlock(&master->bus);
>>  }
>>
>>  static void i3c_master_reg_work_fn(struct work_struct *work)
>>  {
>>  	struct i3c_master_controller *master = container_of(work, typeof(*master), reg_work);
>>
>> -	i3c_bus_normaluse_lock(&master->bus);
>> -	if (!master->shutting_down)
>> -		i3c_master_register_new_i3c_devs(master);
>> -	i3c_bus_normaluse_unlock(&master->bus);
>> +	i3c_master_register_new_i3c_devs(master);
>>  }
>>
>>  /**
>> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
>> index 2dc139a217bf..2b96c4ea75fb 100644
>> --- a/include/linux/i3c/master.h
>> +++ b/include/linux/i3c/master.h
>> @@ -238,6 +238,7 @@ struct i3c_dev_desc {
>>   *	  every time the I3C device is rediscovered with a different dynamic
>>   *	  address assigned
>>   * @bus: I3C bus this device is attached to
>> + * @node: unregistered device list node
>>   *
>>   * I3C device object exposed to I3C device drivers. The takes care of linking
>>   * this object to the relevant &struct_i3c_dev_desc one.
>> @@ -248,6 +249,7 @@ struct i3c_device {
>>  	struct device dev;
>>  	struct i3c_dev_desc *desc;
>>  	struct i3c_bus *bus;
>> +	struct list_head node;
>>  };
>>
>>  /*
>> --
>> 2.53.0
>>

