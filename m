Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C652E0413;
	Sun, 29 Mar 2026 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774819673; cv=fail; b=h0iQhngGvIQSPqK4lcHVySuiisKqipdPQuY0dcqIAPeL1i+wojPlYD5UtUhGQBM4xV8EZKaXr7Y2Dh7wManerujaLGdiHdoxUvZN+r4sTJwwO9Nh+NaKrw70c84AFGWkPxDPHsfsD+nIY6KbTeXLc/cjiROdcA2/HO/VxH4iloU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774819673; c=relaxed/simple;
	bh=Ydf8tORpFu6N256NngNK3mCS1fHzU6ZXbpRfCLScj4M=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Zi699ccUwgkmZmS8/AMvdIeS5rflDjk/67RF6u3miLDViEr3qwMEA8mZSbSMTjYq7/s6+1XYm2aRwiWjmmxe0+iiAZ7eiApya1rlh/n9EY3AGjG14RwsUO8A0D1n+UlTiIVNjSA9TLlMs9C9efpWTvIDoY/v1YNOARUSyVSvTuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqqhsMpf; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqqhsMpf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774819671; x=1806355671;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Ydf8tORpFu6N256NngNK3mCS1fHzU6ZXbpRfCLScj4M=;
  b=cqqhsMpfwjkI1jj1/UpnjhpqtZL9WPw9HO71rzDGevuAh21+IrLBlq0W
   btR24Gii7H+sihQUgR+JGuqiWqfljyOjckMxIb1vooThYR3pGN/6MYzRX
   EwD4PEc7FCaPyZvZxAbXY2MVI1CmGz02pOYH5RzLlrNz7SNr1PvXFa+lB
   y4ZfRE7HOZwl/gJgKRPRV1fZ51Vt0B9dxUwjEAhPL33toGfVLWA0C/Jug
   ebtarkmaBux1Cj/4A2++2kvIjo+PzYEpbVSnsUNDK5q70ndw2WCv6wbr8
   ihbs8J73nwkv9w5J7CnJSh7J9QHBX9E53tMSjeYh+ezpzWLf7siY+c9ZS
   A==;
X-CSE-ConnectionGUID: O/UheMD0TPCfKl5hEAM/UQ==
X-CSE-MsgGUID: SD7c7j5kRV6ZXpyvsb8G4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="63365752"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="63365752"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 14:27:50 -0700
X-CSE-ConnectionGUID: P0z3ZH7rRJeXbhNZB61Q4g==
X-CSE-MsgGUID: UDnHXbgaRlCifXhhbiPi7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="225872619"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 14:27:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 14:27:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 14:27:49 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 14:27:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aorcHbEPo2PooMJlYCsXl6L7goTa/WeCt+YWAnooEwMUc9ek+kN7kwb7AaRpMJ9Lq84kWGUmhKnX+BEsyT7aNdXRiJyeCgsJFy5v0jsyv7rPCBz5BxxtSnIr5FaijL8Jj1cZPwjqg1tI2NxwVAnJMMR31wykkUaIvpp9sVWiKDIyU7VmjFMqqYu3o6ObOLLLnqTvr4MBG9eTqyJrn72eC98nUiYDHe7PppMfk99GU2Ar874jbuJOFqF7kb/s1hqHdJmyqVWEcaDmGpVvugEeAEiQGmQFsxb5mFeygjkwIGgNoRzAmX7ShTO21h4JHzFVhuZQ34CO1qLrrCgunKxbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgKXDiYsbvF+fkdx/WhcqQMAK4uKmdH9JvLglPvpipc=;
 b=Sqb/lV/hLLbAx4jphgoXMn7CcyUMmXSa8PCg1rRe5YCdfJkycDgaU3ARKIMkEBm/9njcaT579l/P1KGEv6Z2p7s5GytCX0ClshzsjHRCp6XS1zfRHZafvR6c3KMget/7qMmg68A3OJAa+z3IXVIEraT3UWyroF4tjjhPaw7nqgdDl/oqWhcxyqRB17F/luRRnVIx9QLhjeXa5YzeIyfLpSBjEytH0y2x7JOc80vjiLO1qFb4Uijr6ZAz7NRwlFlAsI5rlkma1mAvKLpYGi3a5qlz/kbmAatzglt56sXmqq6Yg0RY6rxFQdRLzqeJESGbur3A+mNDVKSMPBq/tcW6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Sun, 29 Mar
 2026 21:27:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.006; Sun, 29 Mar 2026
 21:27:44 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 29 Mar 2026 14:27:41 -0700
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <69c9994dbae18_178904100f4@dwillia2-mobl4.notmuch>
In-Reply-To: <20260302203648.2886956-3-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-3-terry.bowman@amd.com>
Subject: Re: [PATCH v16 02/10] PCI/CXL: Update unregistration for AER-CXL and
 CPER-CXL kfifos
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0234.namprd04.prod.outlook.com
 (2603:10b6:303:87::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad9b918-8d60-41cd-f2a9-08de8dda03eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: IxSDGWOdggryjVvGv6/wPaKqG8d3YMn+TJmZFiOqfcuuxVfPy2jLE0mtD0IsOUMQpAO7oyOC9Qd93epMwVWGIAI+oJqVO/Ju+8+IkDqceLCAeBAUXAz+JKsvQf0TIYW9T43sMwBokK2ZIWshDv1BXBOF3cZx6e3rDwaoQ8hXeZk0uzBbirumNAnjZEFrQ5VNE/68Npn69Vdjm3gWm6l1nhuKTfhL0K8q1fODPl8Gkg88R3UqX7tGPvzN3zSyADmiRR9/P575qmnZjC09tBZrdKZoWZLcxwjozMs6AR2949qFkMd5qpZGjznsarvh11raU8Mt/mwkzqf3YfNegrLNCNe1whjiPpWm7CVQjZ2ICMqIFXKrXCWQtEyrKQfIcrWiFJ0jTFO2P+MS/cAr4pm83jA3jVALS0tBYRy6z6LKOwYJ9LHYPTZ8ee65K0DtLdx1fWnNiWv39UJhqYrvvtGBfs+MbvmerX/OH1Ffl8bGucbDyLJnlXaYPkQw7wXLmx4sLioxARE1RIUinUi6hR0Bixu8oSKqqMPgx9dmDJMGAJ7KUYevMloCjQfKvr382/4meJhb7TYEtI4aHcDtijcb94wZ/C/741x/Mo/9QB+FqzBDPMBaHE2QvuOQk9wxjK5aRT7qFRneeG/MYx6xWeEG3gjj4vnQIGQtqVKVa0KqAH9iciz9HkqJRTHuxYND0rpGvtEPV7x66IwqdTD1RjVmXyZqhV7kC9eiDTQ5a//VonQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cC9STUQyb1lkd0lmUUpGWlBOdFBicGtZWkJKZ2laMFhDYkZoRXRJWGtwcVcv?=
 =?utf-8?B?UE81b0h2YTJEN1l3Yy9hMjJJYmdiVTNWNGFvZlhPNGtGMmVvc2plVGYyWHlY?=
 =?utf-8?B?UFJqSTdFZytwZkhGMWpRSmxJK2FCaUREdU93a0YrZWlSdHM2dGhyWSt0dDI5?=
 =?utf-8?B?Y1ZUMVk2bWtCNTdaTVh2M01BNVRINzYvR3d5enhoYU1JL3d6MjBYdWJKbTlQ?=
 =?utf-8?B?QmdtSWhjbTJZVHNzb0VXUFF6N0YzTkFlaWVlQUIrNWlPYlArNkVtR2J3TzM0?=
 =?utf-8?B?MktTaXlIVjJpVHRKOEtoMXMxSzJybDIzVVd6SEtSWWV0b2tiS21lZTlFbmxo?=
 =?utf-8?B?UXU1YzdHVjl5anZxYk12UlpzWGFVOXhzTXNndjl2L1pMTnk5RSt5VEVtUWtC?=
 =?utf-8?B?eWpSRnRIYndPUkJaN0JHbVFjS3BISTRFSmxRNllFU3VEM0ZSQTVnQjROdHZB?=
 =?utf-8?B?dmkzSUo5Yk9NT3dTWjNjckpSbmZJcXhrNGJ3SXdBZy9xanpFZEZ0RmZySDVT?=
 =?utf-8?B?T1dkVVNKR2d4T05mR2NySVRFRkRGNlBlL3ExVkExbUVMZVRqZGlDOWgwbkJQ?=
 =?utf-8?B?eVI5YlJ5TTZPTTdFWHFWVEsyemw5TzhhWVZyRFZiZW5SaEhlMHdLWU9DaDB3?=
 =?utf-8?B?a3BENWVtV0tqMytKMElqaE5PSm1hSjNYTHRrdU5WUGdEaS8wQzBqeTFuSEdN?=
 =?utf-8?B?R1dPV1ZKTnFOOXVLVVpITEZvVSthOHovWnBwK1lheFY3TFRVcU5DQ0d0UGtm?=
 =?utf-8?B?TDRYZklkWTE3Tk9FY2FwUzVBTlJXSXllS0VuQzI0emFRR1JYaWdoYXptQXhw?=
 =?utf-8?B?YTdicXdvdWZnQUlhaFZadmc0VGdQVkVMQjJaVWtCNGQwUkgyOWRVay82L1JL?=
 =?utf-8?B?KzV3U3hDK1pKMjdwNWJEdWJkU0FnRjlJYzhkNWg1Sk43TTZTMzJhUVlLdDh1?=
 =?utf-8?B?VThwd1JHK2draVhHYXF2c053S3lZZVVmSkNHNDlzTlBwU2ZialFvekVuWXF4?=
 =?utf-8?B?YVNFbCs1dGdSUHg4bzBmVXJ0b2E2OC9sT2pwa0hHS0QvS2RKU2hzMzZIWlVZ?=
 =?utf-8?B?ckRERXpMbzA4WXpYb0ZCQUVCblZIRzFjSXJFelBrMm9qV3dHVHU3OFNRd2Vq?=
 =?utf-8?B?OS9UWnJjZmYvdGlsVk9oVkJmZHlWM2krWHlkUS8xdmRrWDNTV081Y3Z3TGhr?=
 =?utf-8?B?WjUwOFlmRElIZUlITklkK2RQMWVGSGt3QWNYK3h5Q1FPdTVtam83S252WFFz?=
 =?utf-8?B?d0J3OHRLZzNPbGVOc0xVZUFIVWV0dTVlNEFWM1ZWOFo3N1ZJRE8yUW93VFp1?=
 =?utf-8?B?K29PanA3ZzQwVTg4KzBsMncxQTRzVkk3U2phN3c5YzRYMTV4MW56YWVBN3lp?=
 =?utf-8?B?UUR1YmZTMzdHUlJGNG43QjkrWVY1V0lHZUplQkk4WjRDVTZOOTBkL2tFYVB0?=
 =?utf-8?B?R2s3bzIySEhyZ1MyQTFLZVJLRU5xeW1GUUxScEJqNmVTZGFZVTNrcFZzMi9B?=
 =?utf-8?B?RGRPZmVjdWFvRm9xNTJKTzV4U2VtdzFiMFFQUXVubDJOVlBaVWdtWnBSSmVW?=
 =?utf-8?B?ZTM5eXVkQmZYWjlVczZZOVk4QXNVRmdYUXlobXg5QUQ5b1ZKLzVYb3ZMYTAw?=
 =?utf-8?B?SForMXhVVTFWVGE4dVBpUCttSTVLUFRFN01GSmRTQ0FsdlVKcFhLR3l2eGk0?=
 =?utf-8?B?M055djZudGdGUVlCMlVYUERqK0FDRkpURmVEWlEreHBLYzFYV21ocklmb2Fa?=
 =?utf-8?B?QjhQVzJKZU1yMUVvVS92YzhlVFlJcHYvOXpyb1FPc2FhcU01VFlkclJBMEpE?=
 =?utf-8?B?b0JNYy9xdmZ2dG13dFg0RUVoMEgwQzFNcUkxUjZsVVdDSnk4WlV5MXgyUGJT?=
 =?utf-8?B?RGRHSVlrQTVRcG1UMFZGYUxydSsxTEtXNGQ1UWlraDUvUndaOVh5d1Y0VHpD?=
 =?utf-8?B?ZXBNOGxXRnRSV1NNR2VyWG0yTTJRYk1UcjlSTzF3NVptQWg2a1lEc0JrZFRk?=
 =?utf-8?B?MTNDbmxXWG1tK2hhbWYvdGd4REZ3R0orWnR3c1I3b1UxbGhiTWVTM3M3cTFo?=
 =?utf-8?B?SDRXS2Z3T1BhZE5uczhXOGJsMzA3d0lLWDcwOHRncTVrQmdaZXIvQU5UckRV?=
 =?utf-8?B?UUtlbnVFWFQyeWxGaGxsU2NJVjBGeEI0UFg5REUySG5FN0k5MHVESGxmKytn?=
 =?utf-8?B?SmFYK21RRnNiOGQ4bFQ0UkM5UVJnbWF0dGlTYmlKcFNkSVR0Qi9oMHJ4Zlcr?=
 =?utf-8?B?Z1RWTlRhY3dWenlXelllbDBuZmR1VGdBR3BUZWpiRldnMzd1OVFpWEZtWk9w?=
 =?utf-8?B?Q0Zwcks4QnVwNkhHNGd6ZW1CZTlGSmRocGZUM0tzNUZZeDJsKzQwc2FKUTNT?=
 =?utf-8?Q?nfPr+zyzBrXssK40=3D?=
X-Exchange-RoutingPolicyChecked: QLhe5hE8Os9BigVtbpPPpNIMJTp/6s3hJEMu7zS824IuYuWhsgDoxEOdStrMtF216Xe92RSlxzwxQUswqRKvekQNDVayWMxy6Z4dx4ODNxL+rlphweGKNhUZgo8W9PUGlES9k2GlCs0ncwjKjDa8K4oFbdOl1QuIUd5NtbKUhYQmBgpg2Ha4IQCwI8DsXv4n0J8hqdrq0N+9tW6hC+gnpzpMTHu8A2Vh036MSiCSreUvt4uUdRVBFTuK/sqx3iFxYRWYkk4Alr9H13GlMphiHpxlDZzjTE9bUa/8LfHVaMZtAAM4AViBFr3/Y3Sk/NGX8fCPw7N41pzJSUlJP8ScBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad9b918-8d60-41cd-f2a9-08de8dda03eb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 21:27:44.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zg0J+ors5kbw8m27VMGD7RjXmt2nG4loJm9/GJKDwnsOAw79YBACphQ8yUr3NDX586NdDMHUFO8Dd7DsuGWkeHDy2xSSZ79OHwJ9jnVytwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7572
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The current AER-CXL kfifo unregistration does not cancel pending work after
> clearing the work function pointer. In addition, cancel_work_sync() is
> called on behalf of the CPER-CXL kfifo in cxl_ras_exit() and should be
> moved into the kfifo deregistration function.
> 
> Add logic to cancel the AER-CXL kfifo's pending work in
> cxl_unregister_proto_err_work().
> 
> Move the CPER-CXL kfifo cancel call from cxl_ras_exit() to
> cxl_cper_unregister_prot_err_work(). Release the CPER-CXL spinlock
> before calling cancel_work_sync() to avoid deadlock.
> 
> In both kfifo unregistration cases, add the necessary synchronization
> to enforce proper lock ordering: protect pointer updates under the
> lock, and clear the work pointer, then cancel any outstanding work
> after the lock is released.
> 
> Link: https://lore.kernel.org/linux-cxl/6982ca54e094b_55fa1005@dwillia2-mobl4.notmuch/
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Assisted-by: Azure:gtp-4.1-nano-key
> 
> ----
> 
> Changes in v16:
> - New commit
> ---
>  drivers/acpi/apei/ghes.c      | 6 +++++-
>  drivers/cxl/core/ras.c        | 1 -
>  drivers/pci/pcie/aer_cxl_vh.c | 9 ++++++++-
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 8acd2742bb27..de935e0e1dcf 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -776,8 +776,12 @@ int cxl_cper_unregister_prot_err_work(struct work_struct *work)
>  	if (cxl_cper_prot_err_work != work)
>  		return -EINVAL;
>  
> -	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> +	spin_lock(&cxl_cper_prot_err_work_lock);
>  	cxl_cper_prot_err_work = NULL;
> +	spin_unlock(&cxl_cper_prot_err_work_lock);

In this case for a single statement getting re-indented a scoped_guard()
conversion is appropriate, but not significant enough to respin the
patch.

> +
> +	cancel_work_sync(work);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 006c6ffc2f56..949d8c8ecdfe 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -124,7 +124,6 @@ int cxl_ras_init(void)
>  void cxl_ras_exit(void)
>  {
>  	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> -	cancel_work_sync(&cxl_cper_prot_err_work);

Looks good.

>  }
>  
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> index 7e2bc1894395..ebca1112652a 100644
> --- a/drivers/pci/pcie/aer_cxl_vh.c
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -74,8 +74,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
>  
>  void cxl_unregister_proto_err_work(void)
>  {
> -	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsema);
> +	struct work_struct *work;
> +
> +	down_write(&cxl_proto_err_kfifo.rwsema);
> +	work = cxl_proto_err_kfifo.work;
>  	cxl_proto_err_kfifo.work = NULL;
> +	up_write(&cxl_proto_err_kfifo.rwsema);
> +
> +	if (work)
> +		cancel_work_sync(work);

This really should have been its own fix or folded, but at this point
given there are also reference counting issues to fix we can do that
work incrementally.
