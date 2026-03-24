Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A739A047
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 03:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774322799; cv=fail; b=kdZ1BmALZkRrJ66IdcrORzeTE2bShkRdX+Ub6qSpulx4bRUtlMwwjiGgWDgw9G6ks7dFlQ5c8z9mQNfEjSDH9+aKgsYptAT7Ctim3KG+Z3wRfH2JCpCT+dfWgL2AOKH/7ZL0ob7y8PPHYlzCFTNzpibll/ASouzZpsfqu3dalD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774322799; c=relaxed/simple;
	bh=iYvUoubUSEQOOD1r27RMXTzqUJFK5VV8qrb7KMF1ESI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=p2q1gGNHPJf/aN2YTDWu6cDTwoLeMrK0InQdttjG4onaI5BGDSylEpEYGMiQ00mYpw0zV6L3/jYkrnX1JCC6DR+YNwKaLSgluLkXdf9mGvh+UK5AiKyxOsuXUSgjgqXSptSXeVE4hFq2+8ayIhFiXaAegx5VlIpVe9ht8xbmDS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BpF2vD5S; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BpF2vD5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774322798; x=1805858798;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=iYvUoubUSEQOOD1r27RMXTzqUJFK5VV8qrb7KMF1ESI=;
  b=BpF2vD5SRvY+zjCEUVIiRquXNGNSf72dosDHC5T6MIkZM+cIhjapTTw6
   eeO+cp6FscJTiI289BRJfgRhE4NesUYKwFaMZ4DI0DRSv9HsPc3tcbobR
   BJYKY+o/duH2CV5HgUwngK6mXXXU6CYyaohq8PSNWfsAaoavt3jhQ2Nxk
   n2mkC7Jef+jvDpSQ03hLtwp4L5zj98loo0FhvZNxP+mdIJgFPW3UG11+N
   GQE6EDPgvxk8Mb3iPnSOaSPgC8E6MVE66sKi0fRcXDHeVuJIn0adcZV8S
   Hx0CfpzaYD1Mw93ToLY3bo3VF0TS5IcrgNhOet0qHR0mrcfal9WlVudPB
   A==;
X-CSE-ConnectionGUID: 9BIpmwz8SR+A0t4ZOirmeg==
X-CSE-MsgGUID: M+HM89tyRvuxInB1QjoP9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="78931558"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="78931558"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 20:26:37 -0700
X-CSE-ConnectionGUID: ZBlzhP9BRmWwOry4WwQJEQ==
X-CSE-MsgGUID: Oel4vbr5Rl6UIUnk0b9vcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="254706472"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 20:26:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 20:26:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 20:26:36 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 20:26:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMzDRMEc2dEgeqRzjYyu23RC78L75CpA8snzjZRTYM4NLegjdM8LrJQzOhaRIe1O0FcHnjGW0emd5IAnbnY+y59CP7xREr8HpmxoKQK0pZALPTE7Yqmd1ZY2ymEGc2C7lYeZyEXt4Y64DGOjIZnPzE1uUDq2wrGTDLMmiej/nQCedKGXbq0ZaQnF8jVeWxXnUboAFwcQctlslLVEOxbcAetauAmRxNoaQjeKxY7mOh5wSsmIzCOzBsNqF0Gq6GoxdSGHNUeYNdRkuA72kc4hmqvaRWc1dYq1AyaIj1IWv13l479lCcoeDP5Mh0C4NhK8pKIoH8IyyQChvY/LmwbIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42lWG4xKdW7J7Nq03YjWw5NQnwwXmelHrTHHzKEwKs8=;
 b=WihMIOPgD25BFgYLbJIi97/knUyMksuvfPDjdffElUYsXj7RQZ8dmTVohoqn1i8GVYCZ7ICfkjyZAKv0PfDWcRDbXvHFD0YtYaUmMJ12j51YepWpwO4/kUK2IZqZ6RLYJEu8tq/SfeZUl3F5XIC+EnU0Jz6JlGsAWQuhNko/PjWKpYYRyw54hQSbUpaHh437NMWjXTf3KmMLHXELZqSuXYATvEaN1kDovHUPPRbHMRXOAmSLwjk4wWiy43QUxrO5cNq8xXF/aokP40gsTamcYRsVx9HChwhUUs6lAqmCEGd4hMIu9oqHXcD3WyCwhd1jgdXo2RVqhNzGvAimnFqa7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPF67C992ECC.namprd11.prod.outlook.com (2603:10b6:518:1::d28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 24 Mar
 2026 03:26:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 03:26:28 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 23 Mar 2026 20:26:26 -0700
To: Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>, <aik@amd.com>,
	<bhelgaas@google.com>, <alistair23@gmail.com>, <lukas@wunner.de>, "Arnd
 Bergmann" <arnd@arndb.de>
Message-ID: <69c2046287d35_7ee3100ed@dwillia2-mobl4.notmuch>
In-Reply-To: <abji3A72ogqdRiGc@yilunxu-OptiPlex-7050>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org>
 <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
 <20260313133658.GD1586734@nvidia.com>
 <abji3A72ogqdRiGc@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:303:8f::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPF67C992ECC:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6a38a3-20f2-488c-3062-08de895522e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: iJKiurLI4cnalsgqFmV6XvHkzkAL1h57y9o/L44qbSlGGm5+yNa9w4mXBeIWo36Y0WH9QMqEuS9++A+Tubzvx2TN05WHp2ZSHuOQaq/m5ArQM8S8MN1bX9ilc99X73ml5S/H5YZ3k8AybE7uE/S23iFUT+lUCqEltkRz7L5AoOjpt5dkzjT/x8n9DKCSmZJdZmwRnFpuSZWe+nZMgI2w+Uz1xhO97T7Ctjkweur64uPw/Gmf0kidTIbcXySZITqefGbu2hvL1FtLOp618W7f52HelMIgRx74XosgnfDiZl9JYsNgyKPF2q4FGlrIlldQ1hK93SUgLNyX2HmzXZItrQg9VJh/2JxufV+a+xBX/vA/kmoepS+xfqKF6tBlZ+dfDvB8R17b/yFfjNZLH5SNDnjMC3+cl/DhoYVo1WIOvdg6XXe5u4vOWkPQ4DPW7c2g1DtSx+ufTS3reXj5p7Dis82RpYApccWtXU4JGcRe9tnZebx9aQ+CXsdBP12D0LmEMNjcorprYXLcjFSGXie5z4sDb6zMUBDwHxCUUhLcJhLG96VWjA6XRj7F2/7KDawj/2FWR+7QPhN5QQCUChOzEeKbdOXZSZhles9Zwc5sJU5dvi/Wl2ChmuCe1Wp25x+ttaI8hUwyo1MWAxlqvlhKN8mnoHCIuWCk0rAAp+QozohrWYg7T5G1xObfUthHAeBaQClIv/CHBi1vJWahfDJthEshO33aKJ621SP2viI/REU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0k2a1dGcVpBN09NeFI1czVJNDdXR3YzL0kzbkphWVJLWXdTbjRPSU1FL3R5?=
 =?utf-8?B?S3ovTXFJZWxGV0kyeTl6VnU0RzlRQytwTEFyNmRFU1hnU1RnM3o4eTZXamVR?=
 =?utf-8?B?cWVGdC9Obk5rS1VEYkFGQ2l6anlicERrMTI0MkJGZnZmVi9ZL0hjaUpmWWdN?=
 =?utf-8?B?SUY1QXpYTkl2Uk5XZjlGSkhGN1ZFWWxzeXE5c3RmYWp4N0JJSXJiMjNFRmVW?=
 =?utf-8?B?cENhRFVHcmt2d3RlRTlsTTlRbytqOUowUHJaSDJ3YVAwbEVrWXNJMU9IQXNa?=
 =?utf-8?B?cjkxUUUwVVhWWWE0WGFNTUZ6OHNoNVIzWnBXdllYd0h6M3FTakhjMkZQMWE3?=
 =?utf-8?B?RVZWZDhwY1k3TzBIN1pJNENuWUhJQjczZWNyWVBpNVQ4NnRRMUtjcEZxQVhh?=
 =?utf-8?B?TDFRaklYemhiZmM5a2NzMTBRZS9PRWp5eWxFb0RmN0dNWmpSTzhBc2JXUkZF?=
 =?utf-8?B?RUVqMG9OU2VYenoyVmR2NVM0RUVrM044NTJjbmxEbmE1RVpjQU1TTmhjMTdB?=
 =?utf-8?B?ampGVGpCVHBkYXZzcFNXQUN4bUkycG5VeGNnM1FVNGJOY3pSOU9oeHl5TVEw?=
 =?utf-8?B?NURaYis4TDVVcUwvN0d0cmxxUnhReVdPMmlEY1VrWU1WdjkrQ0tmSzNRelNN?=
 =?utf-8?B?WGlYZlk3WWtnVkdVYkNJMFl6OFNMN2h6TnpxZ05DclVBR1NJMFNSWVEzeC92?=
 =?utf-8?B?dFpYc3g4VWtsbGtJUFB0N1kvVjFGejJnVzYvMWNJdHl4QzJjVlB1bS9hYTBh?=
 =?utf-8?B?Sjh3aDJ6VVpvWjhGZU4rTFJxYU01Z3dkV1BlcDQ2cGphbWF6ZEZ5RkhZb1NX?=
 =?utf-8?B?L3JFa2taazcwODBjODk2SWxXeDBoU0NxN0thcWdjcFUvU2JhMVZwSGdQbHdH?=
 =?utf-8?B?b0QvYWw0MmJhQTQrTCtLSURZR2h4TWNLdmZTd0hhYmIwdjhyS1Fud3RkTVkw?=
 =?utf-8?B?Y0V6T0lpNUlGaUI1ZFpvVHdoNXhNQ0F4T0FqWkVYTVRYUDVOM2dTcnpFdFJY?=
 =?utf-8?B?SkFNc3JBK0FlTENoOFBqMi9GRmZYa1NUQmR6ZWRLUS9YTUY5cW1wMUVYUk85?=
 =?utf-8?B?VkpGa2prZnhPYS9vYVR3cjVobU9YNUxFUUFveUgxc1NYTEtpRTlxbFdLcWJi?=
 =?utf-8?B?Q3BOTk54ZUpRcGppTStUbnZrRWIycURwRU14S3RjSXVKNkVzTmRVY3NWaEln?=
 =?utf-8?B?YUdhV1g3YnFtQmk3bXBEaUhoa0FqU0U3QTBsZWl4TWFhczlyT3hSK3lMdTM5?=
 =?utf-8?B?UXBUaTZrYlNPTGtyUzljclVhVGh6RVdJbVY3SHVPYTBCMHAzUGhhNUdTL1ox?=
 =?utf-8?B?aTQwa3pxTVhyNm5kTWllOWxBQWtJRHducWNBeE51Y0NEWWg4UXRKVHVHd1Vm?=
 =?utf-8?B?SitwRjBhK0JaQ2diWlo1c0hHRVJhNUpYQVhXL0piWDNJeU15U05CUlA2MFIy?=
 =?utf-8?B?Y2R6ZXZKNGxOVGdnZ3FCVE1keXJPaTR6UUxjYzZUTDhOaGY3U0Y3aElHQi8v?=
 =?utf-8?B?bWhobUIwZXZodU9aUnlKcjcwOHpGNFNrRXZzN3Rrb0RoMnA3enlFTzZvUnBE?=
 =?utf-8?B?YzBoUHUzVG1qTXp1M0RoMHUrMTJ0aUpiWEFJN1RXSHU3MlB5RGpiMDFTMlVE?=
 =?utf-8?B?TGZZcnp6MVJtUC9HeVQ1T0VlcTEvbVFuYXdldVNxR3RGcDZDSndEdnVSVTdi?=
 =?utf-8?B?K2RmakFxUHc0NE5pVnkwMzNIWlJ6Q09ZaktpVHIrTWdzYnFUcVQzZVBRamN6?=
 =?utf-8?B?SFpFdXB2bUNSdERtdy9GeTJucXBnVGpzcHdjMnV5QysvampYcmVqcVJQcVkw?=
 =?utf-8?B?ZTBmK29nTTBPaW0rNjQ3aXBwU3JNclJYKzlZdENmSm1Wd3FiNHFHTndVcmVi?=
 =?utf-8?B?YWVDU2oyd0kvaFpkNjlqMFphazVDeDZGaHk5M2JRYVZjY1BRVmhYdzhUVGZC?=
 =?utf-8?B?ZTdPYzByUVdxcG16NldRV2ltM3JualhoaEJsbUd2YVArSGZWZzEwQ2orbEpS?=
 =?utf-8?B?N2g1YTUvbmdKMmpMUis3a3BZa0QxekNRRzdyeGtXTmhOZFpERkFQU3FrSlAx?=
 =?utf-8?B?YnRjUm9Ed0loTXZjTEd3cy8veEl1T080UUJqdVdRQkgzYWpzODlaVDJZaG1q?=
 =?utf-8?B?Y3ZHdWI1d0VSKzJ5bXJBZGNESERRcW5tRzJIL2JuOVpnMUFSOVpBTGw1ZEpS?=
 =?utf-8?B?MTE1eUNwL0RoWDdpbkw1VEs1ZFBubWdlOGovZnpkdWI2eEFDWXd4RWNrRm9U?=
 =?utf-8?B?MkFMeURDUjRqMDlFZEg1VTB0NmNSU2pITy9qbnJtWmx5eVplWjRVRWE5dUtB?=
 =?utf-8?B?Zy9lSTkvaHh6L0FWTG5iTTBtdm4yRnc5VjhCQ3lnR2ZJL1VXeThMSVFOeUs5?=
 =?utf-8?Q?zcrfwoiqe2FtZ1t4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6a38a3-20f2-488c-3062-08de895522e6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 03:26:28.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PulqlvpYK6sR9HEVp40BXEvQlNq3qCTG781A519IVyLQeBNN5BCQCY7KLOoDp/04S6JFgDppmTmYg8FrKcNkrwfvB56134yl47PCmB0A+qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF67C992ECC
X-OriginatorOrg: intel.com

Xu Yilun wrote:
[..] 
> And I've no idea why unlocked MSIX/PBA must be hidden? How about other
> non-TEE ranges, must be hidden or mustn't? Is there a possibility we
> enforce DSM to present all ranges, then the layout is clear to OS?

Just to close this question, this was discussed at the last device
security call. Indeed the expectation is that Linux will assume that all
ranges besides MSIX/PBA must be present in the report, and that offset
is always aligned. If / when an implementation violates that expectation
they can help write the Linux quirk for that case or otherwise fix their
implementation.
