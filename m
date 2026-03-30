Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A981FF5E3;
	Mon, 30 Mar 2026 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913150; cv=fail; b=ebWz5lekctwJX+79ftNT6+A8Yz7ydJ4BSQkoMg8APL8o/ppVKK9Z8+EZDKVtvaPCWqy797ort/XjvHMmIYJDcPgHDRk3GerPWuNtZBRDoUhPaNLWYSIxw9x8j3hO0eUSftCfcVur7Go1f+xUJyIYIjOF6KALXSoeL3hg4ZuIEmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913150; c=relaxed/simple;
	bh=6QzJ6tOhM7BJgB99ZBZPmdg9aSkjz4PlhMg3ZblyScg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KjMduKTC8OA61M7fLhno45pO/vH3uW9Fbk7Y0TS0YabjbXrzB98Ftu//xEhxc35+3Wotwf0P0vefgE4NrRFAr4kZ3iRw70SHYL+5Md9wLu5uDd3AAwR7NlKH9kPhqKMBwhZDRu0HilOnFHHmqaeYB3CmZ6A9k4LvqyVCVB2sOx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4imMkfA; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4imMkfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774913149; x=1806449149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6QzJ6tOhM7BJgB99ZBZPmdg9aSkjz4PlhMg3ZblyScg=;
  b=b4imMkfAT2gmu4Bm13lpBn8GoD7P89ELaHQ2qBsinkkDS5ecalKxwS5C
   zTJ97xK1SjZQIqx3FxHwvewn8uAgdFpeovJyEl8HvqRRKLHCd+LnpBLeV
   tWOogJf8nfCuaCEFs/ree16RLGhg4GOi9HX0ru0HLE1acuuxmamVC6ncQ
   9hQgmXxA2onFSrvAtWSflyX61cQEHfYE0uwg8uYGpJdAQixNo3vVMHACg
   zJwxdrdLkDFsYWCMr7hhodhgdN6REaVHj98Dju69mNuvbM7qLM10t/bcA
   w2w/pBQqmjbBOVKEYcI9hZt0OEV2SsO4f5xsB0dXKnTdZZ4yyiJncY453
   A==;
X-CSE-ConnectionGUID: KaTMKK5OTDyQ43ja7xqKuw==
X-CSE-MsgGUID: sADpZUTRQT2PGv5qSAC3pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75804159"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="75804159"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:25:46 -0700
X-CSE-ConnectionGUID: TUyUSNw/RM6LMJd6R1TLrA==
X-CSE-MsgGUID: og8g5le9SSWKxRNZT/LMAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="226071751"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:25:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 16:25:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 16:25:43 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 16:25:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+XAHjR9m1YrjvFat0K9IRUvX2lBmdxz1nqf/qJ9YJ6DzGSMo1ijqfx8p0MIisARR3xJyBtft+SH50lGmwKEgjqun3ZmTwAL3M15E7CgMVg4qtHLjq29Ovf4JfbkCSBVf8jgIbxiH4gThlCvEUBBteHuY4lSIzsBbsBlV6DSS5Cdtn+prsDl2ShQ1TA8Tkv6ntr8bo9fWOZkdpZ2yTGT25ENBfVNSAVaMGdxU5WNWpe6kIugRqoehDelOxX5vSGWyoWufhbu8pU5rWIvc95hXdBNHqucJQlf6crxKSAgtzpXbbYH7Zm0FN/zonoJZU0zON0JDF83/mR/CRlru5t7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QzJ6tOhM7BJgB99ZBZPmdg9aSkjz4PlhMg3ZblyScg=;
 b=n0EXVyT6cKBbaWGbc25mQEqblI6EN8sI34jRAO2CXskJCtiH2d4RopwaZMa7NTM9ovskhrCW74V2W4o4gl2jS8/qwS/YdE9A9W20ZkJDJbNSJkAi7WjmL/EGHKTCLXDFhjkLiP7DBnMB6u3JzRnTHvjqUYabdibiDV1Ns5Qhw6upzkje3dYp4JZBQtzRftYsOfDAmaCdfbuCiaRr+nkeLQaLr0nN5PUYhvWfBNJyx/H9RG0NKyYmWrhDQL/uXl4wUaCnsxH1+rnLz8JUK+EOmVliQFRkwEpJ4b5LOprC4tFdGzIphqilGIw/632+Oh1dLxrz4w4OOgLYVDuWYQD+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7358.namprd11.prod.outlook.com (2603:10b6:8:135::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 23:25:34 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 23:25:33 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-pci@vger.kernel.org"
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
Subject: Re: [PATCH v2 11/31] x86/virt/tdx: Make TDX Module initialize
 Extensions
Thread-Topic: [PATCH v2 11/31] x86/virt/tdx: Make TDX Module initialize
 Extensions
Thread-Index: AQHcvgYM0hzom+MtakSW2JbAkZWfSbXHvPUA
Date: Mon, 30 Mar 2026 23:25:33 +0000
Message-ID: <5cbed31cdfcc7e43f283abc275848370239a3d40.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-12-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-12-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7358:EE_
x-ms-office365-filtering-correlation-id: 2ed00551-ff78-4b99-8d51-08de8eb3a437
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: MngNcdr11L6JDC6dpxUKxg/mL4KiUXoz3SzSMzSPQFiD+hms92UyykW3WASOyLDhUm13kqd2ncNlXVdSYoJ1gxJAyM2wyiA1cW02j2g61XuvfU0aDG1o72tCxoMGIqDR581/FEAMyzxQ4nN6eETXB2P0qcXtgp2vXQBPCGj0rpzvooXICPMy4kjqxV8kBOzoy0Cld/WhIZWpzco5gfrlmNGgVDjvoPG7kAOZcgswd8MV9/ewXITIQAmYrhXkZQRd2y7fv/cKHdJcWP078q48khgQEZj7RQI1M8+JNdWaIVzaBulGYG8rP7VnPyf7anoe1ndo3uaCLaaoadQRdrtQ84G88FGMeui5cwalcc3dgmvpKzTH8DtPO8O3Zn+YHAjum5+O0j92H1SzOavJ0N5w6v/NbeskGcCJjWnHVgyKAJbkCmd06TmUWod8TtjTWcPVU7GxW/rimQ1JDrlkII/vzi9JThO/jlhrqMRv1fcMZz2SeKtpG3DOUuCDAqVNRDE6SCLGD8d2iR1R5pAN21rb6w+x5kdsURecZLMZidhXCLGthB4lqRaIJjNq7Y31DbasRdJx7hBrBVG+y3Thecntllc3FXom8atVaqacTgA3qrYQ/gm9izmGnyEPbKAtn2hXrXdktmig74jSl/s7vlfNt3Y5zrOFT/FMuXXkbOLuKAOGGprStkWyArNC49nxBReuLaMCV9nqZCHnq21Rn0iOBHWebVEDn/Q4qjGRVeiDN7cDqiNR5+fspTz75e0b2qboP8Njp67uy0s5due91/pfUf2IUVPkAxknJdFq5vF+Aqs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW8ybjNLRnBMbFFSMlNOR0RvMHRXaHJzbjBuUWwwVEc1emVqNCtGSGI1bEcy?=
 =?utf-8?B?V2RnczBvL3UxOUhHelVNK2FrVWhjSExDY2VtdjNkeTRNODdHa0RHc0c5dkt5?=
 =?utf-8?B?VHZuTk5jVitDdTh0R3VXenNFWHZNZTVJRTZJSXBCQUFBb0FwemNrcmdOR0JU?=
 =?utf-8?B?dUxaVWVMSktSN3JKMjhta0gvdXU1bmk1NDNOTjlUUlQyTWxNQU9Jalk5ZGdT?=
 =?utf-8?B?c2dUR2E5TXBveGZwN3pudjltRXRFcWNpZzA2UjZPRlN4S2YzM0Z6RzV1QTlU?=
 =?utf-8?B?M2tuL3gzMEVITDRuMjY0cC81U2wxLzhOaHFJWTVnWVFDU3ZZZ2J1ZFRXeVht?=
 =?utf-8?B?eU9QMm1Ec3QxUXNMb01sNW02eHhYY0xGa25hSlh0STRuZDJOdXVUemlXbmIy?=
 =?utf-8?B?NUV5TVBwTUVGcXFaSUlFVXN1dHdQc0VhcEVrTmc3R1hQcDd6TWxwWG9GcmZK?=
 =?utf-8?B?QXJGNXRNQm42Z00xK1FZTjVwNjhWU1pEb1ZBRXJFL1l5Q2JBUE0xTXI0NTN4?=
 =?utf-8?B?Mm1TRWhEWXlGUXdVdS9jdUlCVFlWM3RGaVV5dTRjaHhtVWIwaFYzQTBVcDBW?=
 =?utf-8?B?Ny9PZWlZVGI4cldRak1pZGY1dWlsUmx4UlF5M0FtYjkydlZiRUw5VDc2ajhJ?=
 =?utf-8?B?bUdjenFpUC9iKy9RYjNzSStGMEY4LzBJeC9UNGlubW1STjFjdmFpd3Vhd1Jl?=
 =?utf-8?B?dHNXdG95SnVHWW9ZZGVvelJPUTVJQjdYdG9CejlyUDB2YjlJUnVmWjdTb2hM?=
 =?utf-8?B?SjJ0THQ0bnd2Vm5aRzJJRk9iUlVZUzJjSEFsQlRTUUpUS1hEQWJDMStoVHcy?=
 =?utf-8?B?N1ZCa3N3M2JJRXVLM1pPN1RDUlhueXczd3lJbXM3Wkw0WHR3MTcrbUJhU0JP?=
 =?utf-8?B?VUZvdVh0QkFVV0NpSE9DY1cyWWNuSW9nd0EzUjQyZGxROGxYeVdDNEZ3VnE3?=
 =?utf-8?B?Z2lRTE5rZkU3czdyb1B2Y0JQVUlQTVg4NTdyekQyRm9hYURMT0RGSlFZSGc5?=
 =?utf-8?B?R0JhK0RBb1Z2QTYzQkFXQkI4bWZ0bVlLNjk2ZGxvclhuNzF2S0JVcGpQQThj?=
 =?utf-8?B?WjNFcXROYnNrYWorWmV0VTZ1SW8rOVZnRnoyVnd6TTVYYytjVm4zU2E0NUdY?=
 =?utf-8?B?UWl5cnpmT1F5cjVnUjhSSXJRN2xlWXRZanZtcTFQQlpxMEZXczNyZTZQYk9J?=
 =?utf-8?B?UGdWSmMvUnozUytuaHNMa1ZSRzZRcDBiR1oxbEk1V0FJc1E2SjZ0dHE0VDVJ?=
 =?utf-8?B?R0EwN0Y0OEhZV3VwTnU5QnB5R29mcWd2cCtEckIwRlkySWg3dE1OcFBJMUxR?=
 =?utf-8?B?Qklhd2VzQVlvcmNYTkhPdVF6Um1zMDN3Vmc2RDZrVmdzSEVXeEs4S3ZOMzN0?=
 =?utf-8?B?cXNYNzJzTVAvY2dkdXp1Y3JpSWRhbU5idHRMa3VQNGc5d1BhSGczMlYzS1dy?=
 =?utf-8?B?L1BaT20rRlYxU2pXYXRpVTVTM3BwMkVoSUZCbWxuMFFZQVhtaWc3UTBrc3JK?=
 =?utf-8?B?bm5MQWlLdGZaZU12SXg5ZktNam1aL3IvbDlsU0FMUUdLTStWMUdEZisvRFVZ?=
 =?utf-8?B?Q3FScHZVMmRvd25lelJtQjhFdzc0cnFxTDBMNkZMdFdyMlZpUGg2MEQ5K09x?=
 =?utf-8?B?SThJbTFqcTEvOUVkekxZZFpTNzYvazNidHBOLzRWdjNaaE5UejJSQmJ1WlJF?=
 =?utf-8?B?T3N2KzFzSXlNL3gxUzBrc2UzN3d3ZnF3WGRNdmViZ3J3WWovbENTelJCT1k5?=
 =?utf-8?B?cEVUeG1lMzZMeXRlV20ycS9ZQVlmL0NhM3FPOXVnUXN3YUcwZG96bkc4Nnph?=
 =?utf-8?B?cjNCN01TWWZvZVREaWZ3VnJsWCtjdlhOMUtHKzZFL3o0RjkxSnFkcjFTamZG?=
 =?utf-8?B?MzRjR3A5bXJ1ODlhRnByRkxnMXowaVlraXlWQUUyWEFBZVBOQUV6bGFKRzNJ?=
 =?utf-8?B?QTNmZmFYbk5UM2J1Y1F2anR5QzFxK0NwSGJxa3owcVV1dXorMmNBUXRlZ0Z1?=
 =?utf-8?B?YVlwUjdkM0NQKzZCSmFSckxTajByMnhyZWdJaGZvSkRZa0J1c2gxeVp6Sko2?=
 =?utf-8?B?S0lOTS85VytIVTZsd2pCakJzeTA3Wk9XL3hQOHl2TnlxRllnRnBIQWVpRnNP?=
 =?utf-8?B?enNQRVBldEV5cjczMlR0M3oxUjlocTc0ZHh2ZE5sZTNsT29QTU5TQXNBaUdJ?=
 =?utf-8?B?VVlOWVhmMjVhc1VsY3p0TFYySXpnSDdremE1L3hhbVdPLzdETzNITjk5Yjdv?=
 =?utf-8?B?cFFaaDNPWkZpWjdSZFFuM1NnSXMyOG9mTlBSbGVaSlNrSE0xZnhnT29vbjFB?=
 =?utf-8?B?M3FaM2F2cWJrZmhDNEhCaUpxS0pHbWxKK3Vua3hpS1JYN3dlTko0cjl5YlR4?=
 =?utf-8?Q?fJTYxvr5iNu/Gg/0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F52F7B3EBC9E3D4A84717502BFF01534@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YiHXBsylj9vJoewcdbIj6V31o2ebgM/F/b7lZUwFlnVZLcVoZgbXBzGV0qnw7cJjzREv/8/xkLjvgVkLgTceX5d3nMvzqlT6a+tbObk0k7H/tj+6cgayaO1Ybe9aKMAptexe5k2hx10QJkVimCrd4MZO9vYQeH/4kS0dJ3fHBIaY3nEoI0MjRsm/Q0QRCjKxg51+OQJei/KZQrdmf4dnKPzjMA4XWWONFpYll390INdJd3CyNv55TbapDuWc8f0Z61B1wtt8znBccXKbHkqbDaJsiF8oRBBwERmmv1kv1fz20toDKLWO8mHaYwsaACqpT7Q8ae1iW1qR6gaVNEKeCA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed00551-ff78-4b99-8d51-08de8eb3a437
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 23:25:33.8530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BajMRgV0/NPcBzJpa/3wWnYdwj3QRc8N0qPGJMwq0SEHukz7ykbOjOyzuOoJLeTBceFDwqQsnt7D45M5zA06hA1vW4YUFVvNeiO5lqbErBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7358
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTAzLTI4IGF0IDAwOjAxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gQWZ0
ZXIgcHJvdmlkaW5nIGFsbCByZXF1aXJlZCBtZW1vcnkgdG8gVERYIE1vZHVsZSwgaW5pdGlhbGl6
ZSB0aGUNCj4gRXh0ZW5zaW9ucyB2aWEgVERILkVYVC5JTklULCBhbmQgdGhlbiBFeHRlbnNpb24t
U0VBTUNBTExzIGNhbiBiZSB1c2VkLg0KPiANCj4gVGhlIGluaXRpYWxpemF0aW9uIG9mIEV4dGVu
c2lvbnMgdG91Y2hlcyB0aGUgcmVxdWlyZWQgbWVtb3J5IChwcmV2aW91c2x5DQo+IHByb3ZpZGVk
IGJ5IFRESC5FWFQuTUVNLkFERCkgaW4gcHJpdmF0ZSBtYW5uZXIuIElmIGZhaWxlZCwgZmx1c2gg
Y2FjaGUNCj4gYmVmb3JlIGZyZWVpbmcgdGhlc2UgbWVtb3J5LCB0byBhdm9pZCBwcml2YXRlIGNh
Y2hlIHdyaXRlIGJhY2sgZGFtYWdlcw0KPiB0aGUgc2hhcmVkIHBhZ2VzLg0KPiANCj4gVERYIHNo
b3VsZCB1c2UgbW92ZGlyNjRiIHRvIGNsZWFyIHByaXZhdGUgcGFnZXMgd2hlbiByZWNsYWltaW5n
IHRoZW0gb24NCj4gb2xkZXIgcGxhdGZvcm1zIHdpdGggdGhlIFg4Nl9CVUdfVERYX1BXX01DRSBl
cnJhdHVtLiBGb3Igc2ltcGxpY2l0eSwNCj4gZG9uJ3QgZXhwZWN0IHRoaXMgZXJyYXRhIG9uIGFu
eSBURFggRXh0ZW5zaW9ucyBzdXBwb3J0ZWQgcGxhdGZvcm0uIFNvDQo+IFREWCBFeHRlbnNpb25z
ICYgYWxsIGZlYXR1cmVzIHRoYXQgcmVxdWlyZSBURFggRXh0ZW5zaW9ucyAoZS5nLiBURFgNCj4g
Q29ubmVjdCkgd2lsbCBub3QgY2FsbCB0aGUgY2xlYXJpbmcgaGVscGVycy4NCj4gDQo+IE5vdGUg
dGhlICJleHRfcmVxdWlyZWQiIGdsb2JhbCBtZXRhZGF0YSBzcGVjaWZpZXMgaWYgVERILkVYVC5J
TklUIGNhbGwNCj4gaXMgbmVlZGVkLiBJZiAwLCB0aGUgRXh0ZW5zaW9ucyBhcmUgYWxyZWFkeSB3
b3JraW5nLCBzbyBza2lwIHRoZSBTRUFNQ0FMTC4NCj4gDQo+IENvLWRldmVsb3BlZC1ieTogWmhl
bnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
Wmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogWHUgWWlsdW4gPHlpbHVuLnh1QGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3g4
Ni92aXJ0L3ZteC90ZHgvdGR4LmggfCAgMSArDQo+ICBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4
LmMgfCA0NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92
aXJ0L3ZteC90ZHgvdGR4LmggYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmgNCj4gaW5kZXgg
MzFjY2RmY2Y1MThjLi5hMjZmZTk0YzA3ZmYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3ZpcnQv
dm14L3RkeC90ZHguaA0KPiArKysgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmgNCj4gQEAg
LTYwLDYgKzYwLDcgQEANCj4gICNkZWZpbmUgVERIX1ZQX1dSCQkJNDMNCj4gICNkZWZpbmUgVERI
X1NZU19DT05GSUdfVjAJCTQ1DQo+ICAjZGVmaW5lIFRESF9TWVNfQ09ORklHCQkJU0VBTUNBTExf
TEVBRl9WRVIoVERIX1NZU19DT05GSUdfVjAsIDEpDQo+ICsjZGVmaW5lIFRESF9FWFRfSU5JVAkJ
CTYwDQo+ICAjZGVmaW5lIFRESF9FWFRfTUVNX0FERAkJCTYxDQo+ICANCj4gIC8qIFREWCBwYWdl
IHR5cGVzICovDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgYi9h
cmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gaW5kZXggNWZhZTE3YzEzMTkxLi40MTM0Zjky
NDI1ZGEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiArKysg
Yi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gQEAgLTE1MTksNiArMTUxOSwyMyBAQCBz
dGF0aWMgdm9pZCB0ZHhfY2xmbHVzaF9wYWdlX2FycmF5KHN0cnVjdCB0ZHhfcGFnZV9hcnJheSAq
YXJyYXkpDQo+ICAJCXRkeF9jbGZsdXNoX3BhZ2UoYXJyYXktPnBhZ2VzW2FycmF5LT5vZmZzZXQg
KyBpXSk7DQo+ICB9DQo+ICANCj4gKy8qIEluaXRpYWxpemUgdGhlIFREWCBNb2R1bGUgRXh0ZW5z
aW9ucyB0aGVuIEV4dGVuc2lvbi1TRUFNQ0FMTHMgY2FuIGJlIHVzZWQgKi8NCj4gK3N0YXRpYyBp
bnQgdGR4X2V4dF9pbml0KHZvaWQpDQo+ICt7DQo+ICsJc3RydWN0IHRkeF9tb2R1bGVfYXJncyBh
cmdzID0ge307DQo+ICsJdTY0IHI7DQo+ICsNCj4gKwlkbyB7DQo+ICsJCXIgPSBzZWFtY2FsbChU
REhfRVhUX0lOSVQsICZhcmdzKTsNCj4gKwkJY29uZF9yZXNjaGVkKCk7DQo+ICsJfSB3aGlsZSAo
ciA9PSBURFhfSU5URVJSVVBURURfUkVTVU1BQkxFKTsNCj4gKw0KPiArCWlmIChyICE9IFREWF9T
VUNDRVNTKQ0KPiArCQlyZXR1cm4gLUVGQVVMVDsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0K
PiArDQo+ICBzdGF0aWMgaW50IHRkeF9leHRfbWVtX2FkZChzdHJ1Y3QgdGR4X3BhZ2VfYXJyYXkg
KmV4dF9tZW0pDQo+ICB7DQo+ICAJc3RydWN0IHRkeF9tb2R1bGVfYXJncyBhcmdzID0gew0KPiBA
QCAtMTU3Miw2ICsxNTg5LDE3IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgaW5pdF90ZHhf
ZXh0KHZvaWQpDQo+ICAJaWYgKCEodGR4X3N5c2luZm8uZmVhdHVyZXMudGR4X2ZlYXR1cmVzMCAm
IFREWF9GRUFUVVJFUzBfRVhUKSkNCj4gIAkJcmV0dXJuIDA7DQo+ICANCj4gKwkvKg0KPiArCSAq
IFdpdGggdGhpcyBlcnJhdGEsIFREWCBzaG91bGQgdXNlIG1vdmRpcjY0YiB0byBjbGVhciBwcml2
YXRlIHBhZ2VzDQo+ICsJICogd2hlbiByZWNsYWltaW5nIHRoZW0uIFNlZSB0ZHhfcXVpcmtfcmVz
ZXRfcGFkZHIoKS4NCj4gKwkgKg0KPiArCSAqIERvbid0IGV4cGVjdCB0aGlzIGVycmF0YSBvbiBh
bnkgVERYIEV4dGVuc2lvbnMgc3VwcG9ydGVkIHBsYXRmb3JtLg0KPiArCSAqIEFsbCBmZWF0dXJl
cyByZXF1aXJlIFREWCBFeHRlbnNpb25zIChpbmNsdWRpbmcgVERYIEV4dGVuc2lvbnMNCj4gKwkg
KiBpdHNlbGYpIHdpbGwgbmV2ZXIgY2FsbCB0ZHhfcXVpcmtfcmVzZXRfcGFkZHIoKS4NCj4gKwkg
Ki8NCj4gKwlpZiAoYm9vdF9jcHVfaGFzX2J1ZyhYODZfQlVHX1REWF9QV19NQ0UpKQ0KPiArCQly
ZXR1cm4gLUVOWElPOw0KDQpJIGRvbid0IGtub3cgaWYgd2UgYXJlIGdvaW5nIHRvIHdhbnQgdG8g
c3ByaW5rbGUgdGhlc2Ugb3ZlciBldmVyeSBuZXcgZmVhdHVyZQ0KdW50aWwgdGhlIGVuZCBvZiB0
aW1lLiBJZiB0aGlzIGZlYXR1cmUgd2lsbCBvbmx5IHNob3cgdXAgb24gdGhlIHBsYXRmb3JtcyB3
aXRoDQp0aGlzIGVycmF0dW0sIHRoZW4gSSBzYXkgd2UganVzdCBkcm9wIHRoZSBjaGVjay4NCg0K
PiArDQo+ICAJbnJfcGFnZXMgPSB0ZHhfc3lzaW5mby5leHQubWVtb3J5X3Bvb2xfcmVxdWlyZWRf
cGFnZXM7DQo+ICAJLyoNCj4gIAkgKiBtZW1vcnlfcG9vbF9yZXF1aXJlZF9wYWdlcyA9PSAwIG1l
YW5zIG5vIG5lZWQgdG8gYWRkIG1vcmUgcGFnZXMsDQo+IEBAIC0xNTg3LDYgKzE2MTUsMjAgQEAg
c3RhdGljIGludCBfX21heWJlX3VudXNlZCBpbml0X3RkeF9leHQodm9pZCkNCj4gIAkJCWdvdG8g
b3V0X2V4dF9tZW07DQo+ICAJfQ0KPiAgDQo+ICsJLyoNCj4gKwkgKiBleHRfcmVxdWlyZWQgPT0g
MCBtZWFucyBubyBuZWVkIHRvIGNhbGwgVERILkVYVC5JTklULCB0aGUgRXh0ZW5zaW9ucw0KPiAr
CSAqIGFyZSBhbHJlYWR5IHdvcmtpbmcuDQoNCkhvdyBkb2VzIHRoaXMgc2NlbmFyaW8gaGFwcGVu
IGV4YWN0bHk/IEFuZCB3aHkgbm90IGNoZWNrIGl0IGFib3ZlIGF0IHRoZQ0KYmVnaW5uaW5nPyBC
ZWZvcmUgdGhlIGFsbG9jYXRpb24sIHNvIGl0IGRvZXNuJ3QgbmVlZCB0byBmcmVlLg0KDQpJcyB0
aGVyZSBhIHNjZW5hcmlvIHdoZXJlIHRoZSBtZW1vcnkgbmVlZHMgdG8gYmUgZ2l2ZW4sIGJ1dCB0
aGUgZXh0ZW5zaW9uIGlzDQphbHJlYWR5IGluaXRlZD8NCg0KPiArCSAqLw0KPiArCWlmICh0ZHhf
c3lzaW5mby5leHQuZXh0X3JlcXVpcmVkKSB7DQo+ICsJCXJldCA9IHRkeF9leHRfaW5pdCgpOw0K
PiArCQkvKg0KPiArCQkgKiBTb21lIHBhZ2VzIG1heSBoYXZlIGJlZW4gdG91Y2hlZCBieSB0aGUg
VERYIG1vZHVsZS4NCj4gKwkJICogRmx1c2ggY2FjaGUgYmVmb3JlIHJldHVybmluZyB0aGVzZSBw
YWdlcyB0byBrZXJuZWwuDQo+ICsJCSAqLw0KPiArCQlpZiAocmV0KQ0KPiArCQkJZ290byBvdXRf
Zmx1c2g7DQo+ICsJfQ0KPiArDQo+ICAJLyogRXh0ZW5zaW9uIG1lbW9yeSBpcyBuZXZlciByZWNs
YWltZWQgb25jZSBhc3NpZ25lZCAqLw0KPiAgCXRkeF9wYWdlX2FycmF5X2N0cmxfbGVhayhleHRf
bWVtKTsNCj4gIA0KPiBAQCAtMTU5NSw2ICsxNjM3LDkgQEAgc3RhdGljIGludCBfX21heWJlX3Vu
dXNlZCBpbml0X3RkeF9leHQodm9pZCkNCj4gIA0KPiAgCXJldHVybiAwOw0KPiAgDQo+ICtvdXRf
Zmx1c2g6DQo+ICsJaWYgKGV4dF9tZW0pDQoNCkZvciB0aGUgZXJyb3IgcGF0aCB3ZSBkb24ndCBu
ZWVkIHRvIGJlIGVmZmljaWVudC4gQnV0IGFsc28gd2h5IGRvZXMgaXQgYXNzdW1lDQp0ZHhfZXh0
X2luaXQoKSBjYW4gdG91Y2ggdGhlIHBhZ2VzLCBidXQgdGR4X2V4dF9tZW1fYWRkKCkgY2FuJ3Q/
DQoNCg0KPiArCQl3YmludmRfb25fYWxsX2NwdXMoKTsNCj4gIG91dF9leHRfbWVtOg0KPiAgCXRk
eF9wYWdlX2FycmF5X2ZyZWUoZXh0X21lbSk7DQo+ICANCg0K
