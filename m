Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1362FD69A;
	Sun, 29 Mar 2026 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820709; cv=fail; b=IMJaPDTixJkWtjFLcOfOYgit+Uy42Yb9tiaj2SEoDNgkCPqGgtALnktU5XtCW8GMeHg58jY6xx2loePzwMpjycjuZN8NWA9A2YYtJCHvTy+bC83MygcikmNi4sMHgZhk9xCF0bbpQvZ/cXeTIcmOp9FCLCQEktQs/po63Bpha7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820709; c=relaxed/simple;
	bh=3Ox3Do9MQ5bCYfn4qA2uWOQmyQdAUuviQqs35MgSnMM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=mMRx2i9wD2yLsWiol4sy2IiKgAe4dKZl+FD8ORPgGtWGv/ytZKUHgwZHm/VseBbpS7ebC5pqNqHghx/w9vrzEG2cNkTI+mlXbrfOFs47yeV7jW/ao8ns/fB+15WMGCVodn02m7a2hZJ7NROYKvZWZT9J5bYjW9s/QEzrN4ULVz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/1qa/qs; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/1qa/qs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774820707; x=1806356707;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=3Ox3Do9MQ5bCYfn4qA2uWOQmyQdAUuviQqs35MgSnMM=;
  b=c/1qa/qsxCxKKa8CPeBvjb198hed+cQCybu7IHCIECGDq/m06LIMEoLQ
   Q5X2R+sR6ax5AvcIqf515Eq4mVLM0BSW+5lwIB8SqBalDcvJ7e6eLan27
   qZfC0RdpOq03+As3mqSzyrF4dk7Dh83cgc4nTz69i33gwKujtAqpfDlpS
   WX+2gkSmlxQB3l+aXPhrD4qRQKZypgKJQ5BvTDUXUsle9gD6QYdaS0wpH
   pPt9Az5mwY85e1++4DjB0zdvSmXRW4twncIMiTbCVK64GTtejce5kpI3I
   Sxhn7Ni/EvOzuqpREFw2p4GEXsrOiDvVEIvGuPl6W/mI1nfCwlp+2GgsN
   A==;
X-CSE-ConnectionGUID: 1P5hvupOQiig2Cr2G12qrg==
X-CSE-MsgGUID: /z8GstGQQsSwadshUgNK7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="101272035"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="101272035"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 14:45:06 -0700
X-CSE-ConnectionGUID: rEiMgrvdQMKUcvDZIYeiDg==
X-CSE-MsgGUID: 0F0Ogt+iSmS9qUbRXzu+vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="223010315"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 14:45:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 14:45:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 14:45:05 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 14:45:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCoCMqoel6wQXfR7zzpbTOTtiACJWLBv1TrKgy+F+cdil3pFgH0pNx5hisHy6UY2mEbW+XZhVd3cn/B3pcDndC0xfgRDlOrGUphVXtaM/BkEWxqqxUtg9hGSm2aNsOPhmo609On97gGS/84eZmBUpo/cOazZVv177+Dc4+Ge+C2oFoqwxjpQnmylrq+2nKyTQZArIn14oclkNHJsnKL6gtI6b0MZbdt+Z/dcorVE+KHV0updAVvnW1htbcqeZZ4OxpmCMToTEEsK0J5jj3BcJtwtTmxDNCEzl34LhvpfQWACXgpknzmDcq4RyWXJ10nmoLd/WJrdq5vPApeLbpGmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ox3Do9MQ5bCYfn4qA2uWOQmyQdAUuviQqs35MgSnMM=;
 b=Tc7Yjx0fuZ4FVFYxLJUGHYCEF43kOallDhE+09ltpQTSZ783hl8mX2+3tc6BI2hj5Ca4gw4jHJFw2BGSW/PuWRbKSeaIn2fSUSFeQNdPr0bExw1Jc1UJGPg4O15uCli92kLUaABl/aAoQVbTKj/rw0V+6WT4DMzIt2Hw1v84NIsoBm+hOpSqOte8o6bKwLRMoIAfY1SIbzm/oHuQx3ab6sH7TlbouD+sfXqVuDE2Nt4HcITQRJhM6ZHIEVibstPJod4Y5CBES2T6oh2S3Boy/rXEiz7QWji+633HCJmBn9PLyblzWf4zGr4zWHY1aNlbuU1GDs0W+t9IC+jSog1bnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7418.namprd11.prod.outlook.com (2603:10b6:806:344::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Sun, 29 Mar
 2026 21:44:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.006; Sun, 29 Mar 2026
 21:44:59 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 29 Mar 2026 14:44:56 -0700
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
Message-ID: <69c99d587a434_178904100cf@dwillia2-mobl4.notmuch>
In-Reply-To: <20260302203648.2886956-4-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-4-terry.bowman@amd.com>
Subject: Re: [PATCH v16 03/10] cxl: Update CXL Endpoint tracing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0382.namprd04.prod.outlook.com
 (2603:10b6:303:81::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: eddcfd27-0759-4cf5-c324-08de8ddc6cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: /T5pA7aiIE/qG/CM5JQb7RWEJxcaV1Se1OjNx5yO02iGtbstmka+LAQptscjnePh0+j61di5ycMRMh7LzEacZXA29WadzQnWg1w7pQQZPxqA3N88gmUVlcN43l3//lKa+t+Y37JF4RExBCUu7Lkm/uZFaAcltzK5tbCFdYL6HBIArf1CMUOliaD8BoEbhsDAhh9r0x44Gl/4gEa8xDiydFJMnj0w02Xfw1woUAfRclmAnhaNqz55QGf5vv4L3+/piJgAfYG5OddK0wkL59zYZh1dIDgjnntZaUDu9VNS4xjmpmGOh2hmGWqUa+ViV72uQgy3L8H7DMXOQsB+jGw7WR2l/9D2YfkW2S4uyqp9gmg3f2C4fVcoyn0nLcz5a41JiiwWV+UDcJczQ16RIvicRpDnKywLViUxfwNJ7gCB4XY8IY5Yutp7zwqJYwt+aGmgUAzQbEcowXEw1mo+e/Kcw5ApGX3pcM0Dl46E2BOqrzQWZlHTHdRMQIf3HnvaQtcJoYN9l8JMLyCC2WyEwhKrnGtS6PiGucSJZt/L+X5Pa1cll/0LsGH8q7cnW19XbOBIYSlH34D5iQPSHgveNJBzf0WB0cRX553T4BocGnazDA9Bfx9WUC7BaTOANCqindRsBbweOmAzZ0bTy/PijthxWzDQGrkjtG4Oz75eaqHZpOz1DoSZtcpvDJI9zP673lB1G+eEnWd3jDY++NuFPGqPz+e6C6EjcjfDG83L4UvYYvbzHNG19uJ47DQZiiaMR8QBiM/dK6SPubV+dZyGpwAL2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui8rT3hUcXgxZDNXck5xU3BvS0x5WDRjM1BzK2pwcmtyZ1MxWTJDellaZmhH?=
 =?utf-8?B?K3pqb2p4b2lXUlUzb3grRHdQdGNIL2lqZVZZR2NuMGczOGJwY3BKekxvK2RX?=
 =?utf-8?B?eHdCR1llMUtoeU5NbDR2bTZDZTlXeDlJY1dHaGlYUWJEcHB2a1hBQ2pkbEF5?=
 =?utf-8?B?ckhtTkMwWEk0aGNEbUVYZ1pDRGtFSTdBRGFWT2x5KzBsMlJTSE53MFdaMXp4?=
 =?utf-8?B?bXlyOWprZWtnWFFFL0JaUjY3UzdrSlZmc3Y1ZkdXWlRmL210NnhQZDhwRDZt?=
 =?utf-8?B?NmlkaHZmUFROdHpHSFp6amdKaTdBanhwb2ZqZGJlNml5MTNtbW05ZzFQZmZW?=
 =?utf-8?B?WWVJck53UitkV3psZHJIdUFqL3hsNENmWmx5TzM4bi9zSmxpcnQ1MkFCMnlt?=
 =?utf-8?B?R050cS83TWl0SXBELzNKVHFZSkpTUVlGWUhtWWErOFdDUC8xS2s4Rk0xcFpt?=
 =?utf-8?B?OVMxeVJmajQ0V2JHVktmeEkvUGxjcVBidFFsZE5nZUJjcEFUeEpIWEQxemVI?=
 =?utf-8?B?eHVIS2JQNW15SVYwNEtUNmYxT0Zaa1Q0SVFzR296TDFSYitHMkdTcXAwMlBM?=
 =?utf-8?B?SnlaSnpPcVZ2WElnZVpSZityOWo4VFQvSVZvZUdScUVHVmNTNW8yRFN5UUI2?=
 =?utf-8?B?NnAzWk5ITjBZUWc4RGE2Tm5pM2d1N0xsV21xSTRpS0o5dmRxTUpSaC8xWitu?=
 =?utf-8?B?THU5czdUUmdWQ21FakxtZ3VBNUl5ZlJaaVJrVUc1YXBHQkZ2VmxmdG9sSEZP?=
 =?utf-8?B?a2t5ZERXcTB3Ym1VTUxHN3hkZE1rZnFEemszTUdXQlNjZ1pkMERBRzRSWnc1?=
 =?utf-8?B?TDlqMTNuOEZEWkx3K0Vra2FRSURMcVZjS0hodGRMaG81NUxTSVhVbjRudjBo?=
 =?utf-8?B?SmNvbEdSNkUzTVlGL1h5MngvSVZScTAzNjBwMExoUHN1QXZiNHdsMHNTeTZI?=
 =?utf-8?B?Ky9OWC9mZWhWUEN5VUltVHBrR01nZ3dITlhlL2czekN4dnpRR2tnWitFZyt5?=
 =?utf-8?B?MW5HMFpnYldjUlpqOUJwZVEvcFEwZmFadFRTeTZmeDd1b25XUWdiNW01Z0VP?=
 =?utf-8?B?UDZyNkh2MndRTHVlbDB2VFNGTW0zRHZ0UzBOS3hEa2Y4VU5qSzRyc2hCdVJu?=
 =?utf-8?B?elptTFQzdWxMNmpIRU95eHplYk9MbEpCemRyUmVrR0xncFVZRnhkcENhd2Zm?=
 =?utf-8?B?d0FyL1pPalhmbnJlRm5GTkNUTEV4TkthMTk2a0xnb0hDaHR1ZUtJS2dMM1VW?=
 =?utf-8?B?Wm1zbmZBZ3pGZmpDYmYrS3hnY01vcFpjNW03SnZ2eXpwSEovalR2QmJldFl2?=
 =?utf-8?B?QTMzdkw4ZjhhUDMva3ZEVDU1RktYZlJjTXhxa3pMTFc1Z1ZnakJBMmpRSyti?=
 =?utf-8?B?TXpIZ0R6eDZGeXg1MUZHWVo5Qy9tZTJ3SFZPcno2ZEJnSUtIQnJ2L0NkcWtQ?=
 =?utf-8?B?UjYzUExRaGFEc3VycHhma1EyblYvNDZoMEFuWlV5aGNOcGpDamdnLzBsQlhl?=
 =?utf-8?B?bU9oNkRoNDBYYjBheS9ianhRN3crNFdkS3kvZi9kRWxCWkg0aU8wa3VsUFZp?=
 =?utf-8?B?bHdoSjQzRncwY1k2blNpZnRqNmJuTUJFYWIxSmNxZiszUzd6TGFGL1B5MnRH?=
 =?utf-8?B?bWs3RVJlNEpDOFEwRVVqSFErK0VlNHl1bU8xRVJFMUdEcTUxUDFOZTZFRGRa?=
 =?utf-8?B?SDhaZ1RYalllRVFyaEpNN0QvVW1CNW1hMVRmbmFjbkkvVFlWSi9LQ2xQKzlo?=
 =?utf-8?B?dXNlSUhMQnphZVIzcWV4NlBZek15dVQ2c1p0VmtybnZtb3ZqQ1RYaHcvMHhk?=
 =?utf-8?B?c1BxSmt0ZDltNmd3Ry9nNUd2UG1HRThpakJTcHFILzQ1SllpaGhSY1M4NjVE?=
 =?utf-8?B?MEdBb3VrY0FORnVNYWx3M0h6eE1xRnJEV1NlU2tMTWpBQ25WY1BlTG1iZXVY?=
 =?utf-8?B?UWlJS3A3bXdtalFJOGhsaVdGYkJUWmFLYnY2Y2hQeFRhUndBVU5FbmhPQnd3?=
 =?utf-8?B?UVo3RFJDdXoxVUUzdmRqdVVrQnpydDc2aXE1N3NlamY4azRTT08vTkJUVk9h?=
 =?utf-8?B?TlE3S1Y3TXB0Rm1wT01BOGVTdW9KVDVKT0lCK0czcUl6a09xcjJlY2J1QWU0?=
 =?utf-8?B?cTllSUo2Qkx6UWJWbGppNHFQekordmQxLzh5K0lyN2hTM3EzRXZMTWRselhr?=
 =?utf-8?B?TFlnMkRGZDRhOHpLNytZSHErVi9Ja3dUZk1URE94OTZjcXdPWTgvU1NPWlEx?=
 =?utf-8?B?MkwzdFhRY2svcUdqVlFIbFdoYzRxYlFXSGVRUlFXOTA3cndRYWRBOEo5UHlS?=
 =?utf-8?B?T0JwYkQ1WWI4SHpBQWp3ajc3T2liSk5ocEJlaW1EWlhXVHplMGhoMDdzZ1NK?=
 =?utf-8?Q?RDxYf3rdaQNCOmrQ=3D?=
X-Exchange-RoutingPolicyChecked: c/h38n8pN56TgdfthG2HpIGYS+CDdBWv4yjkJXgtJI1xPdxwBEIrC1SR8e5EroC41i0xDkEfRl2Ik9aIu5NGIsNvbjqo+fkN2ezlrVkB18yfm0qQaeXrRacaBsHH2F4Ae19rfAZSSZCjvaQhlUtCtM433ZkixK0cUrs+7mgifuhr9AN42QFWQem4dW0vRbn9JboR4ihQSI+unQbxiNesxGCEpydVdfy/A+SfIJZPCtC8haiGOmZmCYnZMjSLZqS5neFs8CA5MFlcRUoJBNsCX7xkUM/U65iOnEV6SGxYU+1IcJthMWWDJpmqVDn4/pKKd2A6BEVQs2SFUeH8mJNBeg==
X-MS-Exchange-CrossTenant-Network-Message-Id: eddcfd27-0759-4cf5-c324-08de8ddc6cb6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 21:44:59.0864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zG0Nd2QGMzlzhV9Nh/WKxfUrPohGOYLdrRVLHpnRf7vpmM//yC7fYNT5rhrfSlKB0Q2BmO2/A4toh99lu3yeaWlTzFBpjDePz8OMCQb5jzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7418
X-OriginatorOrg: intel.com

Hey Terry, comment below is with respect to future patches in this
space. No need to respin for this.

Terry Bowman wrote:
> CXL protocol error handling will be expanded to soon include CXL Port
> support along with existing Endpoint support. 2 updates are needed first:

When reading this patch years from now, "soon" will have no meaning.
That same reader years from now wanting to know if this patch is
interesting for their problem is not going to get much from "cxl: Update
CXL Endpoint tracing". For future patches try to get to the meat of the
story as succinctly as possible without requiring too much in the way of
needing context.

---
Subject: cxl: Prepare existing endpoint trace event for port reuse

The current endpoint trace events are some AER register values a device
name and a serial number. Switch port error reporting can reuse these
events if they stop requiring a 'struct cxl_memdev' and require the
caller to specify a serial number if available.
---
