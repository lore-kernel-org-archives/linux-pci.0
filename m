Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C236606D;
	Tue, 31 Mar 2026 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923112; cv=fail; b=l/RRMYCYMG3Ln1fKB+EJOBrQlOk5nbv9sBtei8fcfFgihCAH6nTbwJ2WANlrYlu1JBdMMmxQaGVkFQErh22fxM/CS7sM8qwY8056X+0M6LYaCbsYQbzaoAmHZZSkLtRmwIpUOk3kzb6LO7WC7m9BPpDxYSXTIB3H3qEa2yO+jkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923112; c=relaxed/simple;
	bh=CwSsDXjFhyewk9/CF7dlDS0ImY9t2QnFQWQLFEd1R3s=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=YvFjHkIMPkR3w0i8qjgJ2euSut4yBi2aFUjI8F5F9TRZQTNsVQO2M088cthgnnTDGiDOL+0d/LnnVldw+g3Qfb5rtXL3CEA23kTu9d9Bb/Kqs7YOthfzk7W+84E3ZRApvf0t9xfa8AOsXr+EURSXRoYrR8hd/slwp71mOLuTzb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NsT4AnIt; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsT4AnIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774923110; x=1806459110;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=CwSsDXjFhyewk9/CF7dlDS0ImY9t2QnFQWQLFEd1R3s=;
  b=NsT4AnIt0F6a4lsvsaubSXCGfT24aevh/rUO1ENzk0esreXXE2vGlB8I
   1TPZju/Ba8HewR97QS7CUw2/UOuzhrdyzndayZ74vDe6/kZBRCZUYVwhY
   cMP5Ue/tuTV5eaJGQxLrTPYFY1HdZoGr5xdqzFXxTTgHbq+/pR2TAmie1
   hZVrJPZG8DRCdX/wkyATlZU8WkqPJhD3m3mYBcJ9XX38ttMR1lRflKjjC
   1hZApd2WVa761xibvxRqb+KBGN3tlLpSrGbwUAGg1zkssv7H+U72qkuOH
   akJNZ9h2or4EWZub1YEN1kP/JyDFCCqpP1q8s09hZM/p7lNKTb5ev9Qzx
   g==;
X-CSE-ConnectionGUID: C4kBkho0RjeoJGvy+D4Cvg==
X-CSE-MsgGUID: JNURfvSvSjSkU4eAVJKNFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75642463"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75642463"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 19:11:50 -0700
X-CSE-ConnectionGUID: DjHBBIFGSAKFddBr3C7sOw==
X-CSE-MsgGUID: rgIp4PkqRmmTex5Dg8X2qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="230687272"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 19:11:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 19:11:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 19:11:49 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 19:11:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iyify6awCLKjR8QUIl3d4SPtDNI0Esu3E/O29gyrFOnC2+dNPxI35IlOlAaq45AVVL19GjB3HXKKN9V3iGUf/onn9QWBtER2oGaIwzYkqgQ7VC76N0sH+BkHbiHn3rmArgvtK3U4X3qLHWWSxmO/s0EX2/TX0TSQeUFAoq+fsB6gcMZ/aKKv1MarE+eMst+szQs7pZ0gk5YrIBsKUqFHGcIXZWLvYehFHDdYL7xCuq4sn5EzKCwEZsQyPyKKTZmjJCc/39mhpUAYF0JY1om/obP/HbqTzXVbZAfXPvp7owAjiC2UVr1fLhZq1Q2hVRD20bXxmrY7uJxNGX69Y2cQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF/FmTQVr/k78qVy8aWef0qDRFv8/CCeK0aXzA8FqlM=;
 b=KRoN1RNfMpkA6cgwJozjlnghYvqt7YctgPwhhn0SQiyNpatG/3Yd9xDrC7Ze3rGCgSL+4V292hrm7bJ9UlT98jjwxNu+eiN99gc5Jn3WgGen/MpYgRhylv2xgb3WANRFjAb2BRalfnpMABLMC2TgQ9O9U2Ud1llIXMkSp98akPYCaP2D/nKBtwtH18jvZ8z9HLxrePs7UrH2AJMair9D86XRPqv87u4WvKO/5MYWKRr+ChK9KBdwiu2OUJ5gxT5VgvnkTuaSFfbkbPO0tIrbW5hAwoy8jjVLhaJOlc9fbUH3xM1iexFGd9INY/1fV5myNwTZTGIHWN0pdIMpWOiu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB9633.namprd11.prod.outlook.com (2603:10b6:806:4dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 02:11:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 02:11:41 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 30 Mar 2026 19:11:39 -0700
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
Message-ID: <69cb2d5ba3111_178904100b7@dwillia2-mobl4.notmuch>
In-Reply-To: <e840b60f-2fec-4645-95d5-27c14ae33853@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-8-terry.bowman@amd.com>
 <69c9ccbc3d1cb_178904100cf@dwillia2-mobl4.notmuch>
 <e840b60f-2fec-4645-95d5-27c14ae33853@amd.com>
Subject: Re: [PATCH v16 07/10] cxl: Update error handlers to support CXL Port
 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0279.namprd03.prod.outlook.com
 (2603:10b6:303:b5::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB9633:EE_
X-MS-Office365-Filtering-Correlation-Id: 953193e5-90da-4243-3e8c-08de8ecad978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7QFFJNKdb2n3XLtrFUcI1qODU9RWnxVpmf/PT/4BkN/1YFDxZP6vHErOp8PUtsy+9bu/zlGYB0hMUplwuLChaBX3w3l/0yXgzgvjNOr/s1yL2sj3+mq0osFFafGkPOnV519tACyyIm/X1Ey3D1h80xwpVh/dQ6BIL+FQJxNd9Oj102aqsaPPrPn1fWGf91Re6YkdrRjZ/0AGMlqQFuf+pjVtehDtAzYxPBpB6zNGDhIbzNyDCVUvabD9Ikpt2s35pN6YzYk6mrvFT2jwQWdmETT3upUhJZlISs80QQMaAmPNbmmDBhWyPHe3TBs6xEG0CPgvlxFz7XQpbPLtrPRp08lzwEz9/Urc7Yd9ZDgU3hGE6c2IG5yqIB/kz3qi1xnT0nRxl5gXwoiUxE2czhfJVLg1NHiJTs/bapgQNd6sfj1QuXARIH6n2WOWnzFFVXpmlrP0zA9hhwVXf+iZMfU45M295MBbmiHneMM/OiktDwyHfTYg8rrPDklTf29bnDmedtRFmsJpurYygcl7GoTuaIExYSlOoM3T07myJcMPx9fFsMSxzC+zeEF11jP0uAoYE62/++rnByngg3kzGgZ+7Z/u28cXDAnXniZRUVXgAN+vOj54lq+jG/U+jc2MCrhehgNzHwEYQYhkwNpEwJkphUGKlo07/EFlkkZI4EScPV07MO75Ri2byEeuXg/o7geVGUPzcYkavNOGPK8bEkObjFLP20XTKBuPnpSL5Rm1Nl8m9QF75dtCSML/VXJAr8GsHqmI7SzTD6iikq4wk1I44A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3pFbUJBUVhLNkMxMEg0eUxEa2QzQ3NkTE51RXVMTE9jU3djLzlTdmV3dHpN?=
 =?utf-8?B?U1NKckpnU1lpMnZCSHFYaXkwTVlyQktKbEV2N21hTmtHVnc0aWRxTlBGdUQv?=
 =?utf-8?B?L1lrU2h4cXA1ZmFNY09Kb3FRZnFwcTRuZ0piUnZveFhnVTVzbyt2SWVyVzlS?=
 =?utf-8?B?NS9EUHBqMEU3YlpMVEpRSWNOeUlmc3l0SmhGQWlISmY2RlMrMWIwYkhKQnRu?=
 =?utf-8?B?T3NQd3NlVHB4Zzd6cEhQU1BLcVJTQ0FCaHF3UDlndDg3a0VWYU84dElrbENY?=
 =?utf-8?B?N2VTTXJ0d3lqNDFrbkJZYjhPd2R5Ti9OTDVvVmc4V01aOWRvOVd3cUU0dDlE?=
 =?utf-8?B?QWt1bS81WGpJTEErd2hGZFdaLzM1Tlh1cHZqS05vSEl0cno4MGhzUTBseVRj?=
 =?utf-8?B?MUpGenpWZ0x0TVlGaklQcDJPREoxcmFHVHl0TkRhTkIwa051WFFERjZnejI5?=
 =?utf-8?B?OW9vUnB5eS9NYzdpeEZ1YjFBT0t3QldSTzM3QXV5M1dkdXNGOVJPU2Rwck1l?=
 =?utf-8?B?cHo0TWR4MmpoSlMzK05halZLbzlwKy93N1VyTVN4SkkvNTh5QSs0Q0NFczZ3?=
 =?utf-8?B?L0J3TmtGc0YwcW5UT3h3L2VHcUE1V1dzdktyOFlZdElnaitLbXZ0am10c0hn?=
 =?utf-8?B?U1NXbTZEeDEvZ2VGaVpJRXI5Q2lwVzEwMFp6N1k0amVoRXA1UTJrZ1FzVmdB?=
 =?utf-8?B?QWlwcnJuL0xpaTN2ZndJbUtlNW1ydTg4TC9WZWhJMGJBVUJLQWdXZm84c3FV?=
 =?utf-8?B?TmVlV1ZDWmF5Y29VMzdKaVRIOWdhMktZQmgrWlRsSUE3dDNObmFYRUQ3em9X?=
 =?utf-8?B?Ui9HTkwzS2VPYm45aWdsdGt2M21UdDNjN3ZRSHd2VzBtdFRWY3BUUlYyT3FN?=
 =?utf-8?B?YTZENmltZ25MTEVJdjN4eUEyZDNOUFhyQzdUUnREbnB0SFM4Y1U3THNGeENW?=
 =?utf-8?B?ZFhqcXk4UDVLT1BPK3d5MWZic242aW40SHNyM0JLT29WUWpHWkVWLy95QzJp?=
 =?utf-8?B?UTFRK29wak5KQlgvdWtkVzRiUHd6VDR6bWVBS2dQbUgwZ1M0VGRheTM2dkcz?=
 =?utf-8?B?OEVFSUM2dnJtRFpOeHJqZTNOZTAxMGZQdDNnYmMrblN5eGplWnVyWUpUTTdE?=
 =?utf-8?B?bEtYNFJmakZ0UXVwN011OWpjSjZjTytZSlBPT0dGdkhSa0xmQVFZYWlFWkJ4?=
 =?utf-8?B?S1lnVmJNaE5MalphUytqZlZQTENvVVE0TUdmWHdOWk5xN09la25YZUcvbjRl?=
 =?utf-8?B?c3REaDMvNFR3K2htaGJodHpGSVA3d2NVc3ltRTExQ0VXOFpqUkpjV3VpUFAx?=
 =?utf-8?B?cFF1amdzSktNT2Q1d1cvczR6aHZUVTRVbWk4MFdkQVdnSmMxSnNGRXJFQXg1?=
 =?utf-8?B?Z2xvYk45MjVCb3dOenptS0s2ZzVjTElxdURjUTBpV1pnS2dDcERqRDVyc2RF?=
 =?utf-8?B?Q2hvaEUzeCtpbjhhaGkvY3RYUkswbEhUYjMreXNXUFZ1UFJHQytlQ3g4ZW42?=
 =?utf-8?B?Qm4wYkFPMDVLckZIei8zb1J1Z1lneFhsYndaSHc4NkRPMVhOZjBjblFqNlh0?=
 =?utf-8?B?a2tRU0w1aWJIYTBoOWN6UCtRQ0VKcDZnOEhncTNqVlNUaWpRcEdxeGI5MHpz?=
 =?utf-8?B?OU9oSmloVEJYWllzMW1ZOUFjbE1HZzJXckwwSmR2cHoyMHFCY2taWWhYMlgy?=
 =?utf-8?B?S0gyT3dPZXNqNWRTMEVkaWhaL2U0d3FyaEVhRzZ2RjlUcHB0dFRoR3I1TUtU?=
 =?utf-8?B?N3RNVnNaNzA1c3lWQnlpS3pRN2Y2UEc4OHVLc2Npd1ZoUjNHZjdLUHBIRWUw?=
 =?utf-8?B?dGUzRzhvL1lsMUYyV0pTeGdWWTVFRFBWZkY4OVNNb1FoY1lNb0ZHeFMycUQy?=
 =?utf-8?B?MzNPZmlXZjhYaHRydmNxVjVFVlVoenB4dklJekIwaTVIRFdBOGI4UHcwWXg4?=
 =?utf-8?B?VDViU2ZRTjdLWEVZZVhoZE9wTWFJdFhkcmw0UzJTcTFWV0dyUU1WMWVUSG03?=
 =?utf-8?B?ZWhSa0hJQmlRRVgzUGFqNWVaa3I4NTVCNEtKNnJCTVlXWkhSK1hPTnZ1bzJ2?=
 =?utf-8?B?akNJVzMrL3Y4bXJpZnAvUklPNXF6UzhoeVZUeDB0NS9Nb1dtc3NNRUtpN21s?=
 =?utf-8?B?SjZoNkNrWmZYbk9tREQxY0s2SDhxWTFtTmRJcjk1MnQrK2tYUUtKVUdKeWxZ?=
 =?utf-8?B?bmdIaWNmY1IvNjM1S2FCVGkvVDJ0aE5yVGErY0hxdktRd3BpTzVMN0F3ZzNt?=
 =?utf-8?B?cm9uWjQzMGwxZldQQzJsZ3NqWVl4OFEyQ1V4SjdHb2lyWitDR3pkQjl0MlRZ?=
 =?utf-8?B?MFJxb2p1dldOMjN0cjVGY2w5QUkyVkE5NUpkMGttUWRZYTZlcXdPTCtxSkpK?=
 =?utf-8?Q?DHhnUzOUTPQCQiKc=3D?=
X-Exchange-RoutingPolicyChecked: ZukBkl+KLbMM/V+AEB3MlnBLBS/UvkQUyEp0gfnUxBc9abNS7XCc2AUbqBqjEDIQffNXCst2AiQPcq4kbDNaZT7JXgkRAMD40Vs8L7Nlx2Az/dPZR69pAH08ynWeU8uli0cOnC/ARs9ZZw5zssGK2Pch37WTS61Sc7CtMt6oodpgBDQOJeUR7UE7/EKc40ql9OWHgWn9kiYEDi/VIsz6AHEeaJKO8w5xxGofqJog06F8L45bL1jG5ZVeFu9Oo3elhdywNZsilupOiEtWnZw4eDJbACyD6OIl+eBvQT4ZXNq8kgHemk0frHGoYikXNXSMWu9MC/96PH0g8uwcCOI+uw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 953193e5-90da-4243-3e8c-08de8ecad978
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:11:41.7925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CF+1y4qvhLV4V4OGrqk1wIGCChIQo5TA2BkEZjfkDtyPE+TBLMyndz2i9Y5fbTe4OWlYRrPNJLoYKT+FofL1wYvSPZG6KHWFUCPUV5foPBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9633
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> On 3/29/2026 8:07 PM, Dan Williams wrote:
> > Terry Bowman wrote:
> >> CXL Protocol trace logging is called for Endpoints in cxl_handle_ras() and
> >> cxl_handle_cor_ras(). Trace logging support for CXL Port devices is missing.
> >>
> >> CXL Endpoint trace logging utilizes a separate trace routine than CXL Port
> >> device handling. Using is_cxl_memdev(), determine if the device is a CXL EP
> >> or one of the CXL Port devices.
> >>
> >> Update cxl_handle_ras() and cxl_handle_cor_ras() to call the CXL Port trace
> >> logging function. Change cxl_handle_ras() return values to be pci_ers_result_t
> >> type.
> >>
> >> Check for invalid ras_base and add log messages if NULL.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >>
> >> ---
> >>
> >> Changes in v15 -> v16:
> >> - New commit
> >> ---
> >>  drivers/cxl/core/core.h | 10 ++++++----
> >>  drivers/cxl/core/ras.c  | 36 +++++++++++++++++++++++++-----------
> >>  2 files changed, 31 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> >> index 76d2593e68c6..984cc37be186 100644
> >> --- a/drivers/cxl/core/core.h
> >> +++ b/drivers/cxl/core/core.h
> >> @@ -6,6 +6,7 @@
> >>  
> >>  #include <cxl/mailbox.h>
> >>  #include <linux/rwsem.h>
> >> +#include <linux/pci.h>
> >>  
> >>  extern const struct device_type cxl_nvdimm_bridge_type;
> >>  extern const struct device_type cxl_nvdimm_type;
> >> @@ -181,7 +182,8 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
> >>  #ifdef CONFIG_CXL_RAS
> >>  int cxl_ras_init(void);
> >>  void cxl_ras_exit(void);
> >> -bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
> >> +pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
> >> +				void __iomem *ras_base);
> > 
> > This change is unrelated to the conversion to call different tracepoint
> > handlers.
> > 
> >>  void cxl_handle_cor_ras(struct device *dev, u64 serial,
> >>  			void __iomem *ras_base);
> >>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
> >> @@ -195,10 +197,10 @@ static inline int cxl_ras_init(void)
> >>  	return 0;
> >>  }
> >>  static inline void cxl_ras_exit(void) { }
> >> -static inline bool cxl_handle_ras(struct device *dev, u64 serial,
> >> -				  void __iomem *ras_base)
> >> +static inline pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
> >> +					      void __iomem *ras_base)
> >>  {
> >> -	return false;
> >> +	return PCI_ERS_RESULT_NONE;
> >>  }
> >>  static inline void cxl_handle_cor_ras(struct device *dev, u64 serial,
> >>  				      void __iomem *ras_base) { }
> >> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> >> index 48d3ef7cbb92..254144d19764 100644
> >> --- a/drivers/cxl/core/ras.c
> >> +++ b/drivers/cxl/core/ras.c
> >> @@ -291,15 +291,22 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
> >>  	void __iomem *addr;
> >>  	u32 status;
> >>  
> >> -	if (!ras_base)
> >> +	if (!ras_base) {
> >> +		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
> >> +				   dev_name(dev));
> > 
> > What does this new error print have to do with trace logging?
> 
> The error print will be logged when the trace is absent. This is an indication 
> to the user why the expected trace is missing and will help in debugging where
> there is no other details otherwise.

Imagine you have a device that does not support the RAS capbality. How
do we even get to this far into the code without that detail having
already been reported? For something discovered statically at init time
why does the kernel need to warn over and over again?

So no, I am not seeing a need to spam the log for this, especially since
cxl_handle_cor_ras() has never needed this in the past.

> >>  		return;
> >> +	}
> >>  
> >>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> >>  	status = readl(addr);
> >> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> >> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> >> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> >> +		return;
> > 
> > No need for this thrash if the tracepoint is kept unified... more below.
> > 
> >> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> >> +	if (is_cxl_memdev(dev))
> > 
> > Wait, the whole point of patch 3 was to make this tracepoint generic.
> > 
> > The format string in tracepoints are not supposed to be ABI. Incremental
> > fixup below. Now, there is a difference between "not supposed to be ABI"
> > and "whoops someone had a dependency". We can always come back and
> > restore the old format string if someone screams. It would also be nice
> > to delete trace_cxl_port_aer_correctable_error(). That one might be more
> > dicey from an ABI regression standpoint, but worth it if you only need
> > one tracepoint for all CXL protocol errors regardless of source.
> > 
> 
> Would you like that logic moved to the trace routine? The trace routine would 
> require additional changes to determine if the device is a PCI device. This is
> required inorder to format the displayed strings. The Endpoint displays 'memdev'
> which doesn't apply to non-Endpoint devices.

No, as I showed below, just change the format string to drop the
assumption that the device is a 'struct cxl_memdev'.

I will wrap this diff I pasted earlier into a fixup patch.

> > -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
> > -		  __get_str(memdev), __get_str(host), __entry->serial,
> > +	TP_printk("device=%s host=%s serial=%lld: status: '%s'",
> > +		  __get_str(dev), __get_str(host), __entry->serial,
> >  		  show_ce_errs(__entry->status)
> >  	)
> >  );
