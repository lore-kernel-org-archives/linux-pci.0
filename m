Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5D03C0607;
	Wed,  1 Apr 2026 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087615; cv=fail; b=bAc0gBrwgV8GVZtYZprQ1O3RtpNh6q17gnA4RkjJq1HT+PnAUB01kbJcKvt2kEELyYbe/4jOvWFX7ZpHj+65nSGjlGzruzMcHeS1iY+Hn8cTnxpvXgNmeNuAVcEeg1UgxGSjlSh+W9KaXlAEbG9xsPlkM3tWJBOySnZQFYEXxa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087615; c=relaxed/simple;
	bh=vyul+tfRCCPA+ACJKgwIcIklwVzCh/JGGkgbrWlLq8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MjrKenKJW9ngypUW5Nkn5+ukOLE054cH3g9h+VFGQy8gInaZ/x17y1u8lUv+V5XaJqXHU3LDAHJ8qE0/LlkzPiXf5b/LcSSgHEjc5SY6wRRc8c9SSwKfciQyqXZbZuL7cM154rkGGXnTuK671suAOiie71OLCqUS0ZpFrpY4tn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvtmNLAW; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvtmNLAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775087614; x=1806623614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vyul+tfRCCPA+ACJKgwIcIklwVzCh/JGGkgbrWlLq8I=;
  b=FvtmNLAWQfVkGyM8CAaX05FMWJLQDeqe+QxhGXZTBpbRCVIvfDCre4xi
   RCVu6IjbOKMVMzIg3Yd487l4xROIdf9Bt3iW068X2Cired4S6Z99zjU/T
   ly1vAQxuN1NTFqYXcajW+6Jk+kQYjPtsldB+ww71K4mReFsaEeAcwb5n0
   cyDQLL0ztf0I7EoDm7RuN2viuCmso9Yv5yeswIsgeMtJFQ1lPDuds0Zg1
   aHSetQL9kRqZNS0wkufpSl7F67K/HR9H8OF9XxP/u2Q9NDG2g8yUtBwB1
   Qet3hjCVbnIQi60D8s8tfWN+VukrzFjN8wTWB6vxd8zvMkN1E7ifgX2wh
   g==;
X-CSE-ConnectionGUID: iiojn5GyQuSgwHFqcmS6FA==
X-CSE-MsgGUID: bfhdjeQMTnuYH48VcCkA4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76328484"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76328484"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 16:53:34 -0700
X-CSE-ConnectionGUID: 9L1X259kT2upNzLjRvcSng==
X-CSE-MsgGUID: oNo9ku9SSLeuj//AH3Y/EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="223529553"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 16:53:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 16:53:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 16:53:32 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 16:53:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNBkHrmCXaeBJ0voNyw2H2sMtWT4XSiJh03+uO10O26m4NTGFYiHieGdyAbLKA1aKRmMFD2XziOLX7q6bAnaZgCIXrny431oAVQwA6ZID/6DBd+oZWO/N5mqwl2fLd3rBqMpWK46F6bP4S61OhDqBUqohz7XnhkPHIfclP+TPjyL8m6mnPCALN1L6phaYqNoV/YGHx1+qqdI6RlwTDirl+7W2HktNVkOiE/0sW/Q64zBcuxtKlizDifvfwlvhHqV6BXSw+1q9KCXeI79kUCn49qq01GkGWEs9e7op/F9WtaufQMryvTmiO04BLuFpWVp4nr2Gxx+4n3MSD5zaoPASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyul+tfRCCPA+ACJKgwIcIklwVzCh/JGGkgbrWlLq8I=;
 b=Fg0TcxBgF3b61tfEDsRUr8cNfMPm55IH+I9yHElSVgbcwuwYR+BwbJq7IiQZC8vstHAJcS24wjEriHXOEzXrfcO+fMdZXr58z/4E2QM5kJyJzOwGpNk/nHaTKfL9yuDeF2Wv1X7oWmSqBageM8g/sZgwt3Q1G01r8/8Hkt3ozU2RFEg3cQyXuJnAeP6cKF7CYlI2g5oNiH02GPSEcS8PWuB5oBevAJj2uI0FmHnuYI92bfXaxINhm2Rldch8sb4ySTsCJFaIgNeRRg0UXKWnS+cmwP8mit4tGf4LwKooBZLN2v2+ZFREzxnx9w4/YFxpdWe2HAISI0xqo7Jqtb2nvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB5875.namprd11.prod.outlook.com (2603:10b6:806:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 23:53:21 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 23:53:21 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with optional
 TDX Connect feature
Thread-Topic: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with
 optional TDX Connect feature
Thread-Index: AQHcvgYDw0pdCOoAOUmhZRy+5SxpkbXK5nYAgAAC7QA=
Date: Wed, 1 Apr 2026 23:53:21 +0000
Message-ID: <8c4dfadaf73ed175a959ab16335a8d90266453b5.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-9-yilun.xu@linux.intel.com>
	 <6a28710b65d1a291213d28a8297477bf0287df7d.camel@intel.com>
In-Reply-To: <6a28710b65d1a291213d28a8297477bf0287df7d.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB5875:EE_
x-ms-office365-filtering-correlation-id: 6efa7da4-3786-4cfe-4768-08de9049dad3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: CcGSHujSoUgU3RIquaj4OCDDktYGTQ15aVCDjCCk3ngJn7YR7FsrfLWBNnCKO8jwmHHxINVmCHee68oWPZ9hccFl5Unc3MtREBD38+EK+WOjwKvQovr2izxUx/URRMw33uoL6byqsTf04ltPQ+X5Y7ZP4EJxjcQGn0gMTUL0fHJ1StCrADnWjLIj9ms7DHzoWIDd3SQabJ/JBz9iZS76uBUGoG8maZe5ql7F6CLB7TYVrzUM/BYggULxw3NnqKYc3QvtcR/IHWQUYTQPrlYvHAQrm4lfo3njmbuZBBXQ50nUF8b2LCAOQoXENCtAgFSqjXl8UFsnpRBxJQX/hXH4ZUed0/qu6YYYOyV3Lg24h+uBYMp956dsLNcAovv6EUmMjXEFgu5B17bSs8TM9MOyVbOF3jF2u7zy+0qUmYh393oAif3eLGko99+ovUgwLs16zDg0dZM6AlFkq4sKxpbHv7+xYcUp0ndpmt7jFFk8p624Aj5Mq0lb/xGjM+OJi5ByToJmwDrycbrWSvee8UlSN2TFhDBOlzdsEm91btFXiApcDlgXXgkN/vHT0qSY9ZPts6Hw5MuZx9uEljyvv4qsHRa5YpA+IPci7PkkhuwHtB0wfbDhS5Nmv/1TtcMjuOxBY99NoRJqyveXKW9aoZxIQnKM402GI6XWITBPXHs9gCnOHAkvf6/QikDzBXxYLSTnLG6APQcaJ2Vy1clnDhlUexgqfLeFOTCx1bOm3DUf9fvznn/DQO1hgSm5zRlocLE2pjsERxgok4Ytd9wHPWbZGX31Iu8A9pycrbEMp0u2Gpc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEtITEIvRnJody9IZVBFNHpqc1NhN2dvcnFYeGZEd3o5N0d1S1JYWlF6VUJp?=
 =?utf-8?B?Nkl5RnVrY1Y5THRHaXh1L2l5STd0cm9kK2UxZnZXTXlOOHF6R1BOdUt0QUVq?=
 =?utf-8?B?RlZaYTcrUEZkdU1PSm1QOTJjLzFJNjFBcGR2VFYyYkNkSFZ0MEt4Sm11VGJr?=
 =?utf-8?B?OEhZVTNqQThDUGpQbGxSeVlncmlnemNSSnhuOFUySjMvMGRENmhFMVRDMy9P?=
 =?utf-8?B?aDFzejk5cnA0ZXdBcnhRVUMxMHoxVzAxYjd4aUlHRGcvOVE4Y0dEbUx0Z1N3?=
 =?utf-8?B?eFFtbWo1MURvNVRKdUJId0hDYU9EcXR5a1FkenU3SlBGK21uM2wwV2R5d1B5?=
 =?utf-8?B?VVk3ZG9qSjFnajVpQ1Q0bkViMHBHbXl3VHpiL2hOQmpkbmRUdzYydXlzUnpy?=
 =?utf-8?B?N3ZjRlJIR3R2dHFWckZBTnRheXdsRE1LaGRwazdRc2ZGM1ZXU2lhRlpINE82?=
 =?utf-8?B?b1JXWjZnaHA1WkgyOStLUVpaVmpqSFFzeko4MHZyK3JGa0JVSytQeEwzNFdL?=
 =?utf-8?B?QTROVzRRRzdXTVpsUHpKV2lmR1FSWkpkcEhINkViYmNNc2d4Y3h5bmRTaHhy?=
 =?utf-8?B?bWhEOWxYZ1huZ1F0QTRWejRTUHJ3djVYY0hTeHREclExd0dKay9OMFRoUnly?=
 =?utf-8?B?SDVNc1FoV1NWUzBUcStkSkhZMVBHSVpKV1hDaDZhMW5qbHhGb2VUSzdRem9l?=
 =?utf-8?B?Z3poRGQwRWloR2dHOFNoRmxMaGIyVWwwZmxKekx1QmptWS8xcVpPOFNZQ2tE?=
 =?utf-8?B?TERlQlY1amVhOUQ3c1FlSHYyckMzVDB1d1NXcFNxUTJhL0lBTkdVeVZ4QjU5?=
 =?utf-8?B?dks5SWVhWnN6OFdFYnBuRVBUNk5pVFRQWnRoZUhJT0MrRjh6V2sxTmRZczlN?=
 =?utf-8?B?dXhWdHdJQS8yalgyK0ZuTytMNzBoLzVWR3ZudmJSMkJEUFR6SW4rRVdOWHBp?=
 =?utf-8?B?MEIwWDZPSGFEWHZyWDNjQ2laRGV2VlVTWjlEcXhVbWxDbVRGTkwwUEd6eTMr?=
 =?utf-8?B?eVQ2MUxNcjMvTzNBNW9yVUJyYWdBaTdyUnFCYjIyUFdqUEtMUkpraU1iMVR4?=
 =?utf-8?B?K3JLNzBPZE9EWEU3WmUyUDhJTjRPdnhYNDRVTStKRXBVSzdTZmtRTVg5MnJp?=
 =?utf-8?B?dGFFZXVnVlR0YWJQWFdLdGdKRGpwdXA2YkV1Wk9lTEJxakJ5UGNtMWJEL1Fu?=
 =?utf-8?B?NmthK1NlNGZpVCtiU2dwbkZSS2xwS2F5L0FKLzFVdTE4bm5McXk4d3I1TStP?=
 =?utf-8?B?NlVub3pRcTVKS0NLYlg1N0tLck1wZCtjRVQ4Zml0K29DWkhMQS9HTjJBUmtm?=
 =?utf-8?B?TEE1TFdwN0g2R3hrRllRanpxd0g2T2JrZjRjbnJVZTlGcWoyS3ZpNkhqK0da?=
 =?utf-8?B?V01sbjB2aWNHQitXVmZBZmdrbHJBZkxyWmpPN0dqdkM4clJ1bHRyYWRLaFhm?=
 =?utf-8?B?RzhVaU4rTFJld0N5d1QxanJKZzFCS1pPZFMvMUs4QWVBV1dzRXg1NnNsdWtJ?=
 =?utf-8?B?eUExRzIwZDRNTjVrRzRSU3pDOG51c1V1UUtWZE5vUi84UW5yZy9rVVJJdFp0?=
 =?utf-8?B?NWlhQjVDYlVieW1XZ2huK0EvUlVQaXNyYjZqSnpuODIycnFJWnRSSlBPdm8r?=
 =?utf-8?B?SDhhSjJTbmJ6MVZSL3A4TEtHNkM0Rk1ld3hFQnFjT2dndytxb2wwcWxXdHAw?=
 =?utf-8?B?eS9seW5TSHRkdVo2Y2NENTFBQ3BNeVlKOWl5enVxMkhLTFJ0L0s0Qm53Z3Zo?=
 =?utf-8?B?a3JsTWFvS2FrTEU2aVFaNm12ZFV0c0NRMmlZZ0l5RG1BcUNSUVVNMjJQcFFy?=
 =?utf-8?B?WTIxS1FNOHk0cFAzMzhNVzB1bTNWbHJYYmY5L3dSSnlvUXNzWFZGLzN4bU5V?=
 =?utf-8?B?V1pCeEJ6S3BmdzFsNDdGd20wQmw0NHZvRXBJMWo4UFAwNmt6T0hES0Q3Uy8x?=
 =?utf-8?B?Wkc5dWpuNjU5YUhCUmdabWtrOE5ueXVnSUtyK2V6Yi9ESVZ6QzFNK3UvekJ0?=
 =?utf-8?B?WDRiZnZ5dHR0aTN1RzNQS2ZoSXo3ZktoV3FKTGRQL3BCdlZQNlpxazJRbTRj?=
 =?utf-8?B?RE5UMDhwQk9jNXpueDlGeEY0Z2E4b0YrT3B4OVFQR3B4dWJvQXpNWS9XRjVz?=
 =?utf-8?B?OEJjVGU5dGJwTjh1dUFCTWY5aldWcmkvVyt4RStxT1JoaHRmc1BDQ01EUkl6?=
 =?utf-8?B?Q0ZFSHJLSFczRzRWajhqRWxzL0ZURW52UkVabTJER1MzQXg3bmVpTkROTVJv?=
 =?utf-8?B?akVtQm83cWZtQlVNYng5cUVZaUxCeHFna0RSYXdhRkI1Z1grWDVGWnJMTGpS?=
 =?utf-8?B?VUVibVh0czVMN3p4RFpVeU1FR0wrdCtLSWYxTzM1cnduRkNGd0ZDYWF0U3dJ?=
 =?utf-8?Q?IQ3dvcQ4XJaS/rtk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44E408A32F2DED4489B106B1E9861398@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o5vM8OKsWzKbbmJYTTsxUnuID1SaYfpzZRMMXPSIVjfPtZECVpIL10iKtdWFip6Ow7CWJDzvJyww8NCY/JiG0PFGKF+1lsvBhTFRBx/Af/Z7aITy4uSMwzemtOTxqVzdFQYu8lr4sMoXKuueTzVBHFwVL4mdGmxU9s8krY4viwC3WeO2gC3i/pQvbccU/+iRWC/I74X1v6aihqdlZzWWacACUcJPDnLrpjh8fD2Te9fJ6cMLr67ngMwaKNCE31dM8Vwp69Akwe400emOzgqpO+MTKKylSVBQPRXYdhp8hnMioXe/keGxhTTkYMAO5w76rpkX/mm7U/ZutJEr9sjPHg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efa7da4-3786-4cfe-4768-08de9049dad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 23:53:21.1458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bv7gcqVSs31i+KdAWAy3NuxJ12wL31yTsPFyuI8MV4BU++zQUzkiQleY2aw3E/h3FzZgv2vEiXenpCi376+tSqHCpivqgbggYbXpAjyeqEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5875
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTAxIGF0IDIzOjQyICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBN
YXliZSBhIG1vcmUgZ2VuZXJpYyBjb21tZW50Og0KPiANCj4gSSBkb24ndCBxdWl0ZSBsaWtlIGhh
cmQtY29kaW5nIG9wdC1pbiBURFhfRkVBVFVSRVMwX1REWENPTk5FQ1QgaW5zaWRlDQo+IGNvbmZp
Z190ZHhfbW9kdWxlKCksIGVzcGVjaWFsbHkgY3VycmVudGx5IHdlIGp1c3QgdW5jb25kaXRpb25h
bGx5IG9wdCBpdCBpbg0KPiBpZiB0aGUgbW9kdWxlIHN1cHBvcnQgdGhpcyBmZWF0dXJlLg0KPiAN
Cj4gSW5pdGlhbGl6aW5nIFREWCBDb25uZWN0IChhbmQgb3RoZXIgZmVhdHVyZXMgdmlhIFREWCBN
b2R1bGUgRXh0ZW5zaW9ucykNCj4gY29uc3VtZXMgbW9yZSBtZW1vcnkuwqAgSXQgd291bGQgYmUg
YmV0dGVyIGlmIHdlIGNhbiBjaG9vc2UgdG8gb3B0LWluIHdoZW4NCj4gdGhlIGtlcm5lbCBoYXMg
ZW5hYmxlZCBURFggQ29ubmVjdCAob3IgYW55IG90aGVyIGZlYXR1cmUgdmlhIFREWCBtb2R1bGUN
Cj4gRXh0ZW5zaW9ucykgaW4gdGhlIEtjb25maWcuDQoNCkJldHRlciBob3c/IFREWCB1c2VzIGEg
bG90IG9mIG1lbW9yeS4gVGhlcmUgYXJlIG1hbnkgcG9zc2libGUgb3B0aW1pemF0aW9ucyB0bw0K
cmVkdWNlIHRoaXMuIFdoeSBmb2N1cyBvbiB0aGlzIG9uZT8gRG8gd2UgdGhpbmsgYW55IFREWCB1
c2VycyB3b3VsZCBhY3R1YWxseQ0KcmVjb25maWd1cmUgdGhlcmUga2VybmVsIGZvciB0aGlzIHJl
YXNvbj8NCg0KSSBtZWFuLCBJIGRvbid0IGFjdHVhbGx5IGtub3cgaG93IG11Y2ggbWVtb3J5IHRo
aXMgaXMsIGJ1dCB0byBtZSB0aGUgcmVhc29uaW5nDQpkb2Vzbid0IHNlZW0gaW4gYmFsYW5jZSB3
aXRoIHRoZSB3aWRlciBURFggc2l0dWF0aW9uLg0K
