Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C220EEBB;
	Sat, 28 Mar 2026 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774660592; cv=fail; b=rWoKxX1waZluteU/9nmx8i7KnA6sM6lemBMUkfpgVlRujrCMBaRd9MCRE4F8xHPzVob7iyF8sYzkCH6lad99bJCT3CZn6y8SnNYQMRhT5ERFGSipzX56sNUKI2HhrcJvDtdRCGd16ssLiI82j6IBmDs/7zi6YAZv+VxvKbuAwjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774660592; c=relaxed/simple;
	bh=/cuV+UqhPnKzx0PMf+1r9zKpoRu26RSR0OdqUr91pKU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=KhT9Iq3cNNLClNe1mPmH6yPr9SuKpRvTuD+7c7CnC4Vk0zjZTnTdf/6NpNH/wgIScOIMop+3hyhrSoZ1MZ/BkIqjYjyABdChGLCv0Rhm2TBtfHSAti7HKe7AoKqXcdRdxx/XWOijdD7Rf9AdTCdLbQ4xYHgaKkrgpproL5qhKRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+CeM414; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+CeM414"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774660590; x=1806196590;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=/cuV+UqhPnKzx0PMf+1r9zKpoRu26RSR0OdqUr91pKU=;
  b=J+CeM414avd/cwpcq6ytrxrWtQCOm0ojOB6NuBQRDQnN9QgzTEAtGYGA
   Kv4lomnMtYHvI2lWTfOUp9tbN2LwkgoMzDUY/psW4Ma17c6S84s9l9iNX
   DC3XqdVju1aKiTKXNmgTc88dVGWyHPbibwU2lXbcvqhD2Qp5urUX5923B
   Kj18QgXMIpVm4HR79yPLumaVTUsbloynlJ/OurJ7ssQnrr5f3kRiHFl3V
   mls3Bk3Q8/g0C4GZcbuxj7aFRmEz8Yg/2w8w4OhsMuBQxpctzOwE2yNYa
   Lt4NF71oskRHMNQHRJ52BhKaHRO2T6kJzcYZOjGE3xBs6m8Qgbs3XOX+e
   Q==;
X-CSE-ConnectionGUID: CNZPFfD1R0qcTFBuL1ghiA==
X-CSE-MsgGUID: ZFdg3N5PQ0mB6SJqonF+rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75853313"
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="75853313"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 18:16:30 -0700
X-CSE-ConnectionGUID: lVKrZP4gSaGEu1nQhbHn3Q==
X-CSE-MsgGUID: 65ADVGi4SQigAMKb3UDVzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="225722614"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 18:16:30 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 18:16:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 18:16:28 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 18:16:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0FD7hCkCtlxK6M8ieZFWJ4M6Ora82jNRoFurdKujQH9lgEAD4v5yLowsB96qwrH4mZ1v4zwvPSA6o3vUaFVWpTZ4EX0M1AvWXVaVU7Z6ylBaWUI8iPHJofgSN5BOhez/mLQQlKTcJEbcOFvnNKA20fNB+hUK3ae506IX3kIIWc/jjNHqwxrFQkF226k5/j71uBGg12SvZJ3J7do4LlqPu6jo+lGlfGQS3Qnm94tI+kIAic2Ln6jkjwvb1CW9AUrBysNwIV+/frm6DwG++yl0HbDL8rBRvHsgwDXO4EniiABt4pTv4GulF8bV43+UyyYLAantKv5Ale2ladLHRqLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cuV+UqhPnKzx0PMf+1r9zKpoRu26RSR0OdqUr91pKU=;
 b=neWEXxexDAqGA3aqcng1SGS2qpuRuGoZuYdvNlDJDQ9iEDUzEExlGoGLGpsucXaKBAsbiBrZbgc6nc7YvWuIJu61deKIEebI6iBlkSrO6Z/1yaX/pBkltQh5HNwcwk8btbcKpS1QIgIQV/fizV4oWibscL7oc5H8ZIgStLYNSPhhLr7kCFjyiICwSJLxNQ+IQEpkndWSRstovq7XIrU4Zz35Jgl3G7T48E/ZwHliFMzmNs6shPZ7tYK1AYFaMd2UepVMXbwlvnyjw27PDXIz8El5jhZm3U29ZWVL59fehQEv2GX9yXjqhSqOTIiAixD/ufWA2T9amuYc5lnuIo3h9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Sat, 28 Mar
 2026 01:16:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.006; Sat, 28 Mar 2026
 01:16:19 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 27 Mar 2026 18:16:14 -0700
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <69c72bdec3ce8_178904100bf@dwillia2-mobl4.notmuch>
In-Reply-To: <a78f0ac35b137eed6306dd7ad8db37dd9d930aac.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-2-yilun.xu@linux.intel.com>
 <a78f0ac35b137eed6306dd7ad8db37dd9d930aac.camel@intel.com>
Subject: Re: [PATCH v2 01/31] x86/tdx: Move all TDX error defines into
 <asm/shared/tdx_errno.h>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: 2164db1d-063d-4c10-5d3e-08de8c679dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PBlUPGpDSHzkUvz8LkGLjSonFhW9V0HtsPlUwgzkj5qCbBo/NGyKOxUm5XFOQRqxEUNOK21b7DR3l61R8LK5OK9UXdSgZQKhD+s/KjZMC4/Ca3bljXhfwwapijsWZH+GPbDpVHUNSNcHXwFq7GHdK6NmUNR8m+k5EYCDFeatXZGXB49kYXHgjSAc9vpLPahZKIsk0PF+X+rNRYegVFUeD3HiFMngkgd73yDzbJ51Z85ZM22zE8UlCGOsKamZa4bG0+tF5ia67R3MnICTIeMbUrBCt7NtIJwFtf9QVElfLQNubYMPYBu/acPI4JYnRBcuVGGn6fvCe1i3Bik8tmaw1qL3xPr6fEWUsqbpYs7OKRalnyp2SUt3xbKsncwswtMoBCSVoIqBMLCuHvJHhVnlK/VY53VhrPZEursVx5uqoCxxY82kijNPcAl5UMPSrhb8kDYK93GoAO4qTotw2NvyYRNT5NXx+irelCxu5Z1X9OU7vaXKmo8O62AzBOWZwoGkusIFwSoh/YfaAYZIEd4oI+uqqg5xT5QQQvEz9pEFQX9ceSdq/kX20F5t+pa0TVzSSw5VEZNuYiCvyaYayWML8nqRvgP7PyhYvI43tJngBlEA+lWgJpYALrmbXi0tO4bh71QCxLFz8eJGCyUbELdCZdu6xljFHwMEsePaWQ1uVyGnVza8JodbAyaeUMIaeIYu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjhqdUd1anE2TFh3aEQ0bFh6WVovUkJjQ0NQOUlWK2FrWHFaRUVvbEwvT3lx?=
 =?utf-8?B?MmFlRVpqRVRnWXVkRmx1a0J3S0t6cU1tZ0hsZzdzL29QQXd2WSt5d2owT0Fw?=
 =?utf-8?B?ZlcrbGdCZStNelUzbDUrVXp1Y3Rja3ZaM0g5OG9JNkFDellkM1lSV2plZlUv?=
 =?utf-8?B?K3ZFRklqYnlMRURTaGxIRHpvcFl1SnlIRllKMDV2MHptSnpSS2lYejFVazIv?=
 =?utf-8?B?WklEdlNieC9sWFhHNWdIenhuMXQvVGhCM1FHQmMrd09oQ0g3VmRDRGhWQkVw?=
 =?utf-8?B?Uk13SHJsVlh0QVJwV0VVVVA0NGlLQ1VJSVRxVDYwSTNXRVpFc21KMVZPT3RC?=
 =?utf-8?B?TFExQU51cUtDM2hGRm4veG5jallVK2xrWVNOcGI3WnVTYS9zTUxLeHhENHIw?=
 =?utf-8?B?QXpnU0xsOExyaVBUaXJWc0NoOHlXa0tLekNlTFM3d0FPbTFDazhFTDREeWJO?=
 =?utf-8?B?bzFWSFJlZnAvVXNva040LytSOXNWWlVmT0tUckdaeEU3TWgySlVjS1J6ejFi?=
 =?utf-8?B?RUxKSWhVbzc2V293dUtIb0xYVW1teWQ5c3R2eXRocVlMbW1RS1JYQUNjdWs1?=
 =?utf-8?B?V29GQnZPeTVQTzQwdGkzSlNNcFE2TlJwUXdLSXFlLzVsRHNna3pMZ3lvSDk4?=
 =?utf-8?B?SUl1dmxRVXZwdE1xcnpHbjhVUXI4a3N0OTRjUlZ3VUd4NXBLZFlxWU45VjB3?=
 =?utf-8?B?OTVNZWRxYW1OWVIwTlo0bFNoOThJenE0Y09mZXJaSHVZOUdYTXZlTW4rcW52?=
 =?utf-8?B?QkVQbWpRNmJaV0Jrck93OFgvMktxdkRQSEZVai9xdjRTL2REb0IyMVFHam5O?=
 =?utf-8?B?RFJjYmwrcnZJNlpyVVE5NUZNbXc0dnh4MSs5aE5MbVBFUGdIaEJDNmgwVG0v?=
 =?utf-8?B?R1ppcHJRZUFRTC9KL3JUd2VNUHh2dTBwdG5TOFVXZGhUVWh4cEVvdFl1cUxn?=
 =?utf-8?B?NWlxTFJiSlJZV05GSHNSNmhMbWtKODVPTFRBZXZpeEJia2xWbHB0S1NWYkMy?=
 =?utf-8?B?WVp2MGtqeXBFbCt6S3U5TGtkQk1GeURMcHBWTVZZSDZES3dlOVFyMGtiUzJL?=
 =?utf-8?B?ekJSb3YzYjlSRVJaUjZ1aXM0SVZqeHNDKzNHTkFveDF2TTVtZTVlU1RUVk9x?=
 =?utf-8?B?KzlYbHphTitUM25xbEs3Nm1Oc1dlQmcyN28ydDJ1Z2NoR2V2c3l0NGVtMUtJ?=
 =?utf-8?B?b2cvMURORGR4RnUwSkpoZ2czNzVaWEVacXZZNXBpbzNzTU9yeWZVY0kyUzdz?=
 =?utf-8?B?WGk1Mno5cjdwd0ttNnJ3dVFqNnVZalV5NlloY0NZano3UGVpRUVUSHROZTFE?=
 =?utf-8?B?Vjl6ZTY0b3JXYWRDMkY5VFoxRWVVU0ZnUndQWHlYRm4rSmZrZzBVTjZJelJ1?=
 =?utf-8?B?eEpuQUg1QlpBR09ncm1UN0Q3QzlMOVEvNnd4Z3ZGb2F2N3BoTmpQS1E5UFdt?=
 =?utf-8?B?cFlXRjdLdmNZMzNqL0NuNzk2cmxQVldwam5ZUjlXS3hUMHUvU01obnFid2Uy?=
 =?utf-8?B?SHdVTUZOcCtPYWZPMmdyNlpRS2VzSVluYVF1N3RHTXFsSU03TE1rTSs4STgy?=
 =?utf-8?B?eW1FUmg2UVRZUmdXd0RCWnF0QU0xZEZrb2FDa1lUM3ppVHNhaWlWNWJSVVlB?=
 =?utf-8?B?dnFuZWVMaTFVNmxOeGQ4Y3JsS1d3UkJyelFjV0NhV2F6cjVmdEdNMkthVmIz?=
 =?utf-8?B?Zk84dG5xUnBsNlhxeHVPWTRmMGJQZjREcitBV2lFSXQ1bUFjbGxmU0E3UkNx?=
 =?utf-8?B?ajZZdVRGNHV1blR2ZjNLUUdTdFZ6NXJLaHFoSmZkb2EvUVRhOFRiR091ak9N?=
 =?utf-8?B?cEIvaUdobHdpMmVpN2pob0VsaDF3d1gyQkZvSzQ4bWhnV1d0SjJrbVFhbFNO?=
 =?utf-8?B?R3lGZkNmQzRsdWZPc1kzVktHekxCN0I2ZHdyRWRoY09zbmhIWlV2dTZnd2g4?=
 =?utf-8?B?L3R6R0xEVVc3ckhvOXhMQ2dLRzcrKyswSTNxRDRsWit3UEhHUmx0cXpHNmxs?=
 =?utf-8?B?c0h1WDFuTmFpaXI3Q1htUXdYL0Z0blJRQWQzUTFYSGN1eTlCZFdCWDZzWGJy?=
 =?utf-8?B?VklDcmtlNTczT1NoS1VZVlBUWGszL3lkRkd3NXJqNmJEcThKeFJMeGhjdkFP?=
 =?utf-8?B?b0ZBNjZIaGpKb2I4YVJyUmEzZHdKbEl5eGJDZWdpcU9MTGtIRmNUM2EvMWxY?=
 =?utf-8?B?WVFESkFXMUtTWWRJcVNzbTdrcVFpekMrUFA1REJwR042T2xmb0JIaWF2UGhJ?=
 =?utf-8?B?ZXBsWTZEVzJnc202MFhoRzB0NCt1em9nV3IvQStRdnVhRFFqYUlyYlRBbVN1?=
 =?utf-8?B?M2JianlZa2JZVDBlQUxuOFJCMFQ1MWJPUjBOTURESmRoVGhKV1RLRUpITGtG?=
 =?utf-8?Q?Xm7lsaF7e7m/oI2w=3D?=
X-Exchange-RoutingPolicyChecked: nrFwPr2ztmVn9UVzpv/QBv7iuvKWUJYOAfRFI48KMuU9ns9BU1w7etZljhZHNHB7AW4eR55DtOE/DLA2fQ7lgnhT0MO3k7zDkXi8qIxhX7nwPKwpPPQnscn507nhhIkQ3iX6rZkVeSesa5qub56V5dopqfyhbJ1/TilGKq7ThjUTOotbNRKAKtSsj0Ra9D3VVWLQyoF/WiJ/vJsKkW8Il2Kn8vASegqelcLkHv1dIcANSSRgyBPgSH14Y4FKJqn2/svSdtwqva+Xmb3VBQzaba9+zxwgm8/eaCe/4KA0b5KrGOAJKv+UFlKrmiT/d272dy3P2cZhqqTxPUMj2Dit5w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2164db1d-063d-4c10-5d3e-08de8c679dd3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2026 01:16:19.5002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vnbs5F5Hx2WZ3S1N6iUlRpGGTDVH55c/6yw8xkyAE5BzF3Q765i+3dmUcLi9cnazrNBGJqYq641luMDCIM1Q1LXO8K4GYXz0084+b9O3NJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-OriginatorOrg: intel.com

Edgecombe, Rick P wrote:
> On Sat, 2026-03-28 at 00:01 +0800, Xu Yilun wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >=20
> > Today there are two separate locations where TDX error codes are define=
d:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch/x86/include/asm/t=
dx.h
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch/x86/kvm/vmx/tdx_e=
rrno.h
> >=20
> > They have some overlap that is already defined similarly. Reduce the
> > duplication and prepare to introduce some helpers for these error codes=
 in
> > the central place by unifying them. Join them at:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm/shared/tdx_errno.h
> > ...and update the headers that contained the duplicated definitions to
> > include the new unified header.
> >=20
> > "asm/shared" is used for sharing TDX code between the early compressed
> > code and the normal kernel code. While the compressed code for the gues=
t
> > doesn't use these error code header definitions today, it does make the
> > types of calls that return the values they define. So place the defines=
 in
> > "shared" location so that it can, but leave such cleanups for future
> > changes.
> >=20
> > Also, adjust BITUL() -> _BITULL() to address 32 bit build errors after =
the
> > move.
> >=20
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > [enhance log]
> > Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > Reviewed-by: Chao Gao <chao.gao@intel.com>
>=20
> I think it is missing Kai's RB from sys disable v1, and your sign off.
>=20
> This patch is in three series now, hence the long SOB chain. And I think =
it is
> also the only KVM touch point in the series. If sys disable gets merged a=
head of
> time it can be dropped. But if there is any lag there we should see if Da=
ve will
> just take it instead of trying to keep it in sync.

Thanks for the heads up.

I think if we are committed to the idea that some TDX related sets may
go through different upstreams and some of those sets have a small
handful of common infrastructure patches then there are a few options.
Either have someone keep an eye for these and publish stable-commits for
folks to share, accept that duplication collisions will happen and
rebase when they do, or accept that duplication collisions be ok with
that small bit of mess showing up in the history.

In this case, for the tsm.git#staging branch, I will replace this with a
fresh application of this:

https://lore.kernel.org/all/20260323-fuller_tdx_kexec_support-v2-1-87a36409=
e051@intel.com/

Yilun, going forward, if you borrow a patch from another set, be sure to
both add your own signed-off-by, but also a:

Link: https://patch.msgid.link/20260323-fuller_tdx_kexec_support-v2-1-87a36=
409e051@intel.com

...to make it extra clear you are including a patch that is already on
the list in another set.

I suspect that by the time this set is ready to move from
tsm.git#staging to tsm.git#next a stable commit-id may be available for
a rebase.=
