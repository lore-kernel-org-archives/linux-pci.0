Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF362DC359;
	Fri, 27 Mar 2026 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654683; cv=fail; b=P3ubY8Zroi3OgMopbm2HdMzErKFU2VE7YuVd2E8lL+ykCme4bB20zR+lPVrsKKI9nhLVwLm8AZNK+w5JsFZAi9KEGZiQ3wPbXnODayBG0VED3327cMJe/CZiUPKPHKMV195IypuMNbz1NW7dnAFXRpwil6qhQ0ZGdIzlwD+iw/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654683; c=relaxed/simple;
	bh=zmS5o4E6HjJ4YMeivd7JlCUWfe1/nM83D2mXyWsF6lM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=APKsOonwXKzIf+yyXcXh1232l1x6YZ8qlFo2Nn1Z/ISnOjov1v6nNapvZg257TG8iavrMRZWE9sVFoESoAzSiOthACkqjcpgdAgC2/pbO/VQ8sFtg5pLxlpoxxui8bIaCcPoDkhGaoDi5vJf4CxtZgpD/T1us/AWhMqZ9Mjiqqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZNIolNT; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZNIolNT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774654681; x=1806190681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zmS5o4E6HjJ4YMeivd7JlCUWfe1/nM83D2mXyWsF6lM=;
  b=eZNIolNTsvgoCSP5d7In/9l+b8/BHPTDWthU4AQcAlvVkD1fpqkBM0pd
   d0sN867na4jjKPz3GP+ME43UlktjAmZ7MDgJh3rJl+O5WaqOTnDZrIUn0
   3BU6DvLG9AldUrTIhc5E2PhumqgKybGyu2k60JvIKqE737aTwxFqjByij
   2rOlqf4cPwlu9zd3UR4d+t5yvDtBgC/C0ZBniEQD8za8FBOviaCfp3oPJ
   dp2M+Qq1o0uGZuHjKmC71tXjDvRX3V4PQolHnINDaXQu8GfNuZ8T4vsx9
   drDekR9jUCtmLDZEjOONIOeH9IT2e6w6HyIge9hrHaoTfW6mXd9Rc77Ke
   w==;
X-CSE-ConnectionGUID: 5qaTT1sRSAKzQUqS5Vqz/Q==
X-CSE-MsgGUID: RvKEK2wZRSiKnktjSnTeHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="93315814"
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="93315814"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 16:37:57 -0700
X-CSE-ConnectionGUID: A4zjCVWMT+uEM8AvRr/f2g==
X-CSE-MsgGUID: tj8gnpgoQJSQn+WefrwLPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="248490628"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 16:37:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 16:37:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 16:37:53 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.15) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 16:37:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeivzKhE5szUBTsn9xgpTGridAxklwPmaZ2WLXLO/gwP0brnnHcW2H/rVtATRhYDiROlHql6wYZuFvMYejWgjwToeikKj6d7Qu8HS1H/W74EUlmYwv5NsY4/niMDofDLAKVvvxFn95sFWZx43Yiqd3oRofGDq5kVOYMQF8qaCIRwb9h3S43k7TBdreRD2K+itbknNJbm1dn5DyY8OP/Q0DCqlKQXl+C7wMoIAP1o6rgGCS5IBdjdNIBl7HiXHwIQ7j2VWPX1jfiml29C7yYmdXTCkWra1dqlque+khdO6Sy050Z+7xPcijZMLCT5oRJCPFY5pMbbg25dcbsoeKL1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmS5o4E6HjJ4YMeivd7JlCUWfe1/nM83D2mXyWsF6lM=;
 b=W3fn6Zm1sSJ+iXzWA8/PoLoDhiraNiMkyF53F4Yk9JkeGH4QiQcpZDPOBlyUHUV7PBwdFyJhXhF2HUFNWnCKpuHnE0IMLDCgMvOF+qfMlrm0iZ16857gLtUvyjgGJqiyQt4/C4OTt6JU9Th7fX1G2/vCeuV9A+dsgB2HmXDlaLsC8K3WbKYtyTy7rkRM7D0fbpVbM/relZ75TcuDYi63MG9979mAJtSZ21CZ+SVZN8woWNIaub3kWEKWiTQOSyQDqByGt/yjYUmYX9eM3ZQXdr2PbdH5XUCeSLz+CtV1nDFWE1OqyvzqB/MXP6LceygUJKH5ZplTgi3aYClo0+5bBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS4PPF706C623D2.namprd11.prod.outlook.com (2603:10b6:f:fc02::2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 23:37:47 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 23:37:46 +0000
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
Subject: Re: [PATCH v2 01/31] x86/tdx: Move all TDX error defines into
 <asm/shared/tdx_errno.h>
Thread-Topic: [PATCH v2 01/31] x86/tdx: Move all TDX error defines into
 <asm/shared/tdx_errno.h>
Thread-Index: AQHcvgX0w/S6vxBaxEmEzCP4M43qRbXDCWCA
Date: Fri, 27 Mar 2026 23:37:46 +0000
Message-ID: <a78f0ac35b137eed6306dd7ad8db37dd9d930aac.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-2-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-2-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS4PPF706C623D2:EE_
x-ms-office365-filtering-correlation-id: 8e7b5335-5a3c-4ee7-7beb-08de8c59d977
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: kn0IphW4WxHBzcukWlh1ar8kRL69CHSCFJHYT5IC/pmYhI+Ly4qiV5MzQjtSciT8OQyTarAd4FarL+DyPvlNtYPALXA8QMUT2untEvRweySYxNFtImbXyhbtYyj/Me1rJUGsCSqvs2PFJELrLVxPO6g2mBkogF31bj173iJg2XxDrAd5IoQKIbyrWup+FeWGORYkb0O1ZEGRyefSyTzC/Q0VFfSaLugunbWVR1BXjiCAabL+7SjytB9yHfNSW1Ft+xwMdTLjRdYMXQdy283mi7iYIiu8Rl1Qrlrwry01bGB1iPCrgoRc+rN0+39yzvnShn1ArHKmBdv3iFylg+IxcISSxR+xfyTduNBexGxA+nHIivSWj+8UzIQ9tWuqeJSUXtNobmy4S3UyI0DXL5Xnl9kTUur1L0EVBk/6De7MnQeDspux8kLWd9tb/tYe37VQrOWN7RentqK06/WoZeoPggmMZpYGUYfiir4xK8c6V01l6VAnG9EVJ8oVbLKWZ3sHUPqK41fVrgqe3+rT3K6VrDt48qy5GAwtvzT2v0zhlsHEMapZLGykZJxtRxjzreLI4C/il6DPt/UqqUTALkZG6WUZRdhvGIufoKZkAJWHfAySWdRfKUfEEaCHIT078i10B04meJKz8PUkyE/hM9aGqWScrqRLqDKMEqNHKX+17PjV79pdTJ/lyOMPOVX+T2YUgZUOhVl4q1pqpOr6PHpQXEZ2jWRsXXwvZgFUyzU72H+YnVKdFLsD4nqNMtcsgClLGOqGU2/qh60xZYCLC+dAcu6jCL3XlIs6Jc1H84bnoWE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk9ndEoyeDNqanNOVWIyRVNqdU1LbjB6ZzdSc1NhU3ZiaDNMcWxYR0ZtQmV1?=
 =?utf-8?B?ZkZvVVZjY1JHbUFsMzBFOE00c0FDVnZoNktyb3drcFFGQUd0MWt5dFdldVZ2?=
 =?utf-8?B?dzZxbDZNaTZwN1FIbGZia21oYWxZaGp6d3h2QkZadnB2QUdRSXBldDA3U0cr?=
 =?utf-8?B?TGVvVjNTbVVCelFHUExkUmQwZTFHNGtWdDNqNUFHcDNqSEZpalI4cGM1dnQr?=
 =?utf-8?B?dUJzVld5bXM3aVhEQWRBVS93MVQ4TXI3TGpoalNYRjRnMXF1WUhKOG1RTzBa?=
 =?utf-8?B?cG9HM2c0NzRwWVBBOWxrR3l5WVdOa3h2NXUrRzBrSGJBbUV6a0xONE9EQzY4?=
 =?utf-8?B?aHRMbTFKNEtBVUxNamZ1VWRiY1hjUTZ4RGg5TlNkdklxVWFNd1RONUtuMlo5?=
 =?utf-8?B?N3U3ZEwwSHFCL0xMcENzdHRsS2h3L3hJdWdWeDhUVE1NenFsa3VmcTlHbWJW?=
 =?utf-8?B?c08rS1FNOWcwNFJ5NU8wVnUvMk9ZMEdCKzY5WFN1L2hrMlUwMWE3RGpnRDc0?=
 =?utf-8?B?WTJFeGxoUXMzMmpMdlZYNzZHYXBYK29HcXFXTFNtQ2E4QS96bVRVNU9XSk9N?=
 =?utf-8?B?NDRjQzZNdXZTU3Q5Rm1GS3JPcXNjUEtyRVFubUFTdWxxMDZuUmlkKzZKZ25R?=
 =?utf-8?B?MlhUOGViaDAza0JyNllNYTJIRnRCUzhkWVV5Y3Y1dm5rUGFWejYrRDcrditD?=
 =?utf-8?B?eW5KVklGejBzYjh3bHE0MHpGNnpVUEx5VlprY1pHRXJRSUVvc1NZMTdqV2lY?=
 =?utf-8?B?OGtkWUJmdzIwL21YSW9RMExKQkppK3NQc1N4eTBNVmpmU1JuOXM2dG55UDE1?=
 =?utf-8?B?SVY1VnhQNzFxQm9tUFpIV3VCa3N1c2swM21WOVJSMUt6Z3g2a09xWFhLQ0I2?=
 =?utf-8?B?d1FFRE9jMnc4MVhDR09pTVhQYXVUeU1wSVhsOVlYQUJkRVpUVXBTNVkwWUZz?=
 =?utf-8?B?TXM0eHhVQXRKclpheXE3dVdiVkRyOC9zTTVQcktwb1lJU2p3Qm9OclAvTFNY?=
 =?utf-8?B?U0hSWG0wS3RzSTVqU05zUmkyZ0l1YysvRU9jY3hLMm1zQzRGbzlpYThoOWN0?=
 =?utf-8?B?a29PdXhsRThSSmRPT3gyajdzRkxrYXBwZDNRbEdSQW9DSXNxeXFyZ2NYdk5W?=
 =?utf-8?B?L283Ymp1WSs1ZVQxUzhjWFpVWHJUR0JheEV2QitlM2dCYngrc2o2RnFGdFUx?=
 =?utf-8?B?UldIbHlUems2SzlzNzY3WWFGYmRIaHVXVFhQZmI4MlNCL1g1OU1NVEd3WTQz?=
 =?utf-8?B?RTRjUnFEdzdMYS9xc0c5T3NxeW5RVENNeWRNbVlSdmI4QmlxODR6Ri9KUzFh?=
 =?utf-8?B?KzV2Vk1FZ2tObXlMN2JtVExvNWRZSkQvRVN4U1I0NnZvaVcvYVdHR1NhTEI5?=
 =?utf-8?B?c1N5Yk9LaW5zVkJpZlZGOTc0U0FTOStFTkVZN01FeS9rYU00WFdtYUo0UExJ?=
 =?utf-8?B?OHRGdGl0dHRWRGFYaW5TR2JvcWprNDlBWWtTUy9HM1J4SDBhaU5aY0RjVk1W?=
 =?utf-8?B?K3F4d3ZvN3VMRnVnMlZUdTh2ckFtQmFzL2dob0F0WHEyNmthMnU2ZSsvb0dh?=
 =?utf-8?B?QlRCZERzZ1hQTVNkNFFtSXRORW9QZmdQejRjZjhVcUMwYldzdUt1Z2t3UUZl?=
 =?utf-8?B?TXNUT2sxdnE0enNETHdPZWEwZWF4d0RMejhTZjl3Qk15T3RnZTArelVOaEYw?=
 =?utf-8?B?VE1ZYktNTnBrT0RvUExNTVFoOUxQdElTRlJTWDdvQ0NBd29xcGpKd0VyUzNl?=
 =?utf-8?B?YzZmMEcwRXJERnJUbk5KNWxLQmJJMGF3eWhuRTF0Mlhqakd3NDJHL1VzVWpQ?=
 =?utf-8?B?Qk1rTmIxQkpxZmJIR25uMmZHRGdNZWhuaTJodUpnVmhZU3dnWHFxVEVxNkFK?=
 =?utf-8?B?ZTVCKzBUMlBuMjQ3Szk5TzVKbDNwcUh4Z085Z0JkT0ZSNkVadTJWUjNUMnNQ?=
 =?utf-8?B?MTFSUTlEeWZ1VS9zWjgxZjlHVTVpd3ptdTBtcllrVkIxN0VuZGpwamhPamZX?=
 =?utf-8?B?cDYyOHAxYTJaZW9TcHVTN05RMFVGQkRtSHFBUjZtaWxraWEzZGlySmRLekRp?=
 =?utf-8?B?aWFvYlMzSmJFZWtEaWd5Y216WTNFOVF5VTVIZDkvWDZoWjV3SU9RZk5NZXlS?=
 =?utf-8?B?RU81bzlFMkljN3o3K3A5Rms4bG1mWmY4elROaFo3eEU0NVZ1ZXM5Z3F0T2lI?=
 =?utf-8?B?eXRuUy9jUi80b2lUZmF0ZmYrUUVKMWVNVUlJSDh1ZDBlMGxoNUZjcjd2MjRN?=
 =?utf-8?B?RzIvam4vL1VoZ1BSSGVUYU81RDJwZ1ZPUnMyR3pZMEVYWU0vY0NHdXd2NFRX?=
 =?utf-8?B?cVJ2c2F5R3RZb0w2dXhBa2VyK1gyTXVWSlBSY2xHcFhHUjlKUEJEVjRpNTRy?=
 =?utf-8?Q?5WejbHhaxJtbysIA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51E141A9114A714C8AB93F303A1DE1A3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P6mTkLTQiszBIbDxcSeC8o4EeqCYvS8LE1AdOHruCl1ruUJGwyDhl+RU1+etibfCL/ZDx6qJkXqBFXXijgCvDle8Yg3LlhQQCLZg5Go1r86VYM7K6L971II6WESI8Eietypzb0FZoGoS+sQQ3jvzg5+YeOl0VE223gpW9ZZfm7GcI6tR5807k/39X83u+/Wm//i/lod9JWBVdi7dupF6NAUNPgfIYM/qT1QW5vod4J2AqG2oE0nSyFGsycqWCwCl+chDSoTubQgSPIpnlMcyNSG/aoWl7j/lFUb6OJbVzr6jzegBfYDRuZjG4V5yz4qDCPYDPQFXZstLG9kqOiE2iQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7b5335-5a3c-4ee7-7beb-08de8c59d977
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 23:37:46.1522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXQG0pT1M1m6K+Jgb+jEa/QjF/6UZdMjWtMW8VvNF+6dXmr4QiqTT8JOmU8cEF5PSiajpqWHm1A1j/lmC1uHvF64byG0MNlG05gMgUHLsag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF706C623D2
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTAzLTI4IGF0IDAwOjAxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gRnJv
bTogIktpcmlsbCBBLiBTaHV0ZW1vdiIgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+
DQo+IA0KPiBUb2RheSB0aGVyZSBhcmUgdHdvIHNlcGFyYXRlIGxvY2F0aW9ucyB3aGVyZSBURFgg
ZXJyb3IgY29kZXMgYXJlIGRlZmluZWQ6DQo+IMKgwqDCoMKgwqDCoMKgwqAgYXJjaC94ODYvaW5j
bHVkZS9hc20vdGR4LmgNCj4gwqDCoMKgwqDCoMKgwqDCoCBhcmNoL3g4Ni9rdm0vdm14L3RkeF9l
cnJuby5oDQo+IA0KPiBUaGV5IGhhdmUgc29tZSBvdmVybGFwIHRoYXQgaXMgYWxyZWFkeSBkZWZp
bmVkIHNpbWlsYXJseS4gUmVkdWNlIHRoZQ0KPiBkdXBsaWNhdGlvbiBhbmQgcHJlcGFyZSB0byBp
bnRyb2R1Y2Ugc29tZSBoZWxwZXJzIGZvciB0aGVzZSBlcnJvciBjb2RlcyBpbg0KPiB0aGUgY2Vu
dHJhbCBwbGFjZSBieSB1bmlmeWluZyB0aGVtLiBKb2luIHRoZW0gYXQ6DQo+IMKgwqDCoMKgwqDC
oMKgIGFzbS9zaGFyZWQvdGR4X2Vycm5vLmgNCj4gLi4uYW5kIHVwZGF0ZSB0aGUgaGVhZGVycyB0
aGF0IGNvbnRhaW5lZCB0aGUgZHVwbGljYXRlZCBkZWZpbml0aW9ucyB0bw0KPiBpbmNsdWRlIHRo
ZSBuZXcgdW5pZmllZCBoZWFkZXIuDQo+IA0KPiAiYXNtL3NoYXJlZCIgaXMgdXNlZCBmb3Igc2hh
cmluZyBURFggY29kZSBiZXR3ZWVuIHRoZSBlYXJseSBjb21wcmVzc2VkDQo+IGNvZGUgYW5kIHRo
ZSBub3JtYWwga2VybmVsIGNvZGUuIFdoaWxlIHRoZSBjb21wcmVzc2VkIGNvZGUgZm9yIHRoZSBn
dWVzdA0KPiBkb2Vzbid0IHVzZSB0aGVzZSBlcnJvciBjb2RlIGhlYWRlciBkZWZpbml0aW9ucyB0
b2RheSwgaXQgZG9lcyBtYWtlIHRoZQ0KPiB0eXBlcyBvZiBjYWxscyB0aGF0IHJldHVybiB0aGUg
dmFsdWVzIHRoZXkgZGVmaW5lLiBTbyBwbGFjZSB0aGUgZGVmaW5lcyBpbg0KPiAic2hhcmVkIiBs
b2NhdGlvbiBzbyB0aGF0IGl0IGNhbiwgYnV0IGxlYXZlIHN1Y2ggY2xlYW51cHMgZm9yIGZ1dHVy
ZQ0KPiBjaGFuZ2VzLg0KPiANCj4gQWxzbywgYWRqdXN0IEJJVFVMKCkgLT4gX0JJVFVMTCgpIHRv
IGFkZHJlc3MgMzIgYml0IGJ1aWxkIGVycm9ycyBhZnRlciB0aGUNCj4gbW92ZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4Lmlu
dGVsLmNvbT4NCj4gW2VuaGFuY2UgbG9nXQ0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21i
ZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBW
ZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogQ2hhbyBHYW8g
PGNoYW8uZ2FvQGludGVsLmNvbT4NCg0KSSB0aGluayBpdCBpcyBtaXNzaW5nIEthaSdzIFJCIGZy
b20gc3lzIGRpc2FibGUgdjEsIGFuZCB5b3VyIHNpZ24gb2ZmLg0KDQpUaGlzIHBhdGNoIGlzIGlu
IHRocmVlIHNlcmllcyBub3csIGhlbmNlIHRoZSBsb25nIFNPQiBjaGFpbi4gQW5kIEkgdGhpbmsg
aXQgaXMNCmFsc28gdGhlIG9ubHkgS1ZNIHRvdWNoIHBvaW50IGluIHRoZSBzZXJpZXMuIElmIHN5
cyBkaXNhYmxlIGdldHMgbWVyZ2VkIGFoZWFkIG9mDQp0aW1lIGl0IGNhbiBiZSBkcm9wcGVkLiBC
dXQgaWYgdGhlcmUgaXMgYW55IGxhZyB0aGVyZSB3ZSBzaG91bGQgc2VlIGlmIERhdmUgd2lsbA0K
anVzdCB0YWtlIGl0IGluc3RlYWQgb2YgdHJ5aW5nIHRvIGtlZXAgaXQgaW4gc3luYy4NCg0KDQo=
