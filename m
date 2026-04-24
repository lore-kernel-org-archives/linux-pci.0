Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC336165D;
	Fri, 24 Apr 2026 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018165; cv=fail; b=pOwI20QccZnNmx2WLh/4B6+I5EzvFRTOcgKJXQoSwyJd+oxuWp9PdobtjRYghTNRNcCaPXwwuyZkKkt2ijU3bgnBc7NVk6PH5RFzhm/+cYTlO43yhnGjPAUOssaSLKFXNYdVCSx1FhkkM6xlgwQzvom86R+kQgE48D2xNZDOq2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018165; c=relaxed/simple;
	bh=wxdXAvd/Kcc+WgJrt8WOxS55NPMvXeWTqpMBZ/NhxVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NGtAsoN+F75bO+257Y5NItHeRxi5tTzUWW/J8ruLXPr4xQ1FAQ/daXum1AtFSxVVlUmvm6m86lAI4NegCuIXPTOQ//mH3wDWe92D/0z395ywDhwmsO0mFuB3+EP6B3zcB3sxSHkyfIRqe6fwXHdFuGrh7LG6nOaXxrM1HiOyy+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EE4gKGeP; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EE4gKGeP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777018164; x=1808554164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wxdXAvd/Kcc+WgJrt8WOxS55NPMvXeWTqpMBZ/NhxVQ=;
  b=EE4gKGePJ6wJU1rEpYrg58Io4NRkkXmPOabAfCDQqLRpTNTfE1g2+0jd
   p5+h+h1pxHWPGgMVBAOeVYmNHik4NC2aLN3SiIMbIyRmK1PCagKDtG28j
   VgYM+y/dHqpLKefta0l9gvM6KNhk82PSpFY0gy70yi51X5WaFaPLS2Y3H
   XVFV6JzdCROJNiXeVW5I/tiWXZmb5vBRckCLX0jxDvQVVsNqa68V3Bl56
   Vd81eM4DEIsde5fLh+mhGmnQvfK0oNh+FtsjzTpz2tHtLUDpeWlNSUpRO
   Vo5pJdsQk1qIIKB/WHs3PG8lWaA70gWyut5U1zoDB/sJwy7mmQndpkgT6
   A==;
X-CSE-ConnectionGUID: tuX1OW8sQwSXzchYVBNytA==
X-CSE-MsgGUID: ppwcQFPyRR67birZC7phaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77881310"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="77881310"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 01:09:24 -0700
X-CSE-ConnectionGUID: GrYixwEDSye1ZTevrzCkxA==
X-CSE-MsgGUID: h6IjvlDrS0mQ4DlGPEA8pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="236867403"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 01:09:23 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 01:09:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 01:09:22 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.21) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 01:09:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIbb5Yr8xtt/tn4OOaltB4Chgl5jgmrROgr0lFmoAPRwkKO7RgzRdHF/7yiv6PtMb8uPuzwAmiWgGFa578Mchti8Drz3dpVF/yCbO2u42PPKfRa0Mv+qMqgbAsZpTv20nZZaOrRPRJI3IJ/SZj9sz+e+/LOq7PtHuPphs9rf3iL+2nTEpuL6uSQR6aLgDl05vZ7Y6x67BH5Q9eOKUccDMYZH5r6Ha1wuFsMf7IaLdmXWYdQaDXtnOudiQ++NplZ8mVq2yy0+ZKyCfI+YO2MJQtZ4g113OH11DEIShzghIdLZ/D3Z5rklLbCTm8gcXodGFDyKS8hak8qHrr9jj026/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxdXAvd/Kcc+WgJrt8WOxS55NPMvXeWTqpMBZ/NhxVQ=;
 b=LslSnl8UGbFNwlljhtTsQN1reCCmyLOGYFAwJsHfh2BU7B1Sm9CyiONbUCEKkOyeS83AzctLLd+deY0Z0pyPL+SXIHVVpkzh9mP3//nTXMsXdv4O9u8j+kFJ8s8ET9t+OijMnwhewIZ1X3OV3E14K2lCA9esO+Y9L9mzXxnb+HqLAz3+P5xQ4OiClMihgG93/wpgaz2IxuH8gnwhi5Azvw026zFuXEUtfgZOuza+tEdViM3+Y/Q81mzRMbAE+H9B7f77iIUvCFJBCAv+rZKbz0SWhZQOwOEUixkr2zOkHrM+5BYrqpgrwchG9BVxhBsgAQyPEQkzHxwEqyCmTKBEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB2647.namprd11.prod.outlook.com (2603:10b6:a02:be::12)
 by MW5PR11MB5858.namprd11.prod.outlook.com (2603:10b6:303:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 24 Apr
 2026 08:09:16 +0000
Received: from BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::32d7:4779:29d3:a1ee]) by BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::32d7:4779:29d3:a1ee%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:09:16 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>, "Verma,
 Vishal L" <vishal.l.verma@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Gao, Chao"
	<chao.gao@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
Thread-Topic: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module
 for Extensions
Thread-Index: AQHcvgcsp3iEtTEG/UOFY+bW5PCg8LXr/O0AgAENtYCAAFqbgIAATY2AgABUbgA=
Date: Fri, 24 Apr 2026 08:09:16 +0000
Message-ID: <668a903ba2dccff2d641ac15b74deacc95ef19a6.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-11-yilun.xu@linux.intel.com>
	 <89bccca9a409e02667278fd83f0b7b9064557dab.camel@intel.com>
	 <3b0bc0dea544b10bd2fb0304a96d2671f263829b.camel@intel.com>
	 <48171f4ab772da546beccec3c7a95fe442524b42.camel@intel.com>
	 <aereVy8zVb2be2hh@yilunxu-OptiPlex-7050>
In-Reply-To: <aereVy8zVb2be2hh@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2647:EE_|MW5PR11MB5858:EE_
x-ms-office365-filtering-correlation-id: d00d2ef2-8756-4c41-dab7-08dea1d8c790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: Bdhf9Q4aY8/lmwZ16h3iF0+zL6XK3TiuX3EWJc5vcMw+rdCHjd0meIPpQRkPIpU9VxVXBjo4tnvwsClvk8LN6D6aCTz0bXu4AXfuedRgYhi8d/rGNmI71oj7KQ7lmNAd2BNSVHyX5SbG8RmjSJcVJ/m/W9BFyYJHD2Yk5QxsDM1gaAGKYMOKIxrOoM9VNVle4tvzDXVI4f+8SjMmtpzrKcvTXVh6O5lnG1Ypp/lU5GE8C9jOWh4Z+74XnAmW/Mi8Y7Je6teUewGcnLgsJkuZNAF4ZYO8ZT8Bti0yI/x6dgNLp9y8qipJyOGk2rMXdRIM3xOWoJC8Weh1egOTTH/d9fy3O56/GlquRKv+0XSX+KUY3YA08VkyLkkZ/9YG7igrl0FWDwVjSVx3f54vGGfD06CX957+AUTQI2euHkBhgAOl+5SKoP7Xa/9QRVd33m3LmPdcT0Jdxcfzo6BKRLyM2a/ftdyW/tSMbUlZvqw5m2jSMhiBcY2Kkhw6EKfyMrx+PEHTs36D/YIAXtX0QiLea7WMBHGFAcHMzWu0p02Yy6PW/Ez7InD2A+ZiUd0dbHJzWAWlfT3GqyM5Pjt4uL4yf9qrTMVhrIrt3b12UGJSvI5jPurH104W8cHasDbwMrKiRtXfMTxXaFRA9MbzKWLW/qjQ24nCKuHQmkBDSkkxRVHk8XtxuVON7zwwonkXoP8blhWk0S/oBKqpnKulvXEQCM8cbG9lKqVGGmya9rWNMOacEWOWW1bs5sQWYKTXdTaX4M4+J/z00IPEDsZPWQWyJ9Izhr93gWDQCICO3t8Zg98=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2647.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ei80UitHU1dSQ0ZseWlUVWxkYzBmdkpaWUFNcnRzLy9aMFh5WWZXamozdHA1?=
 =?utf-8?B?QTkxYmwxOTBHV29ja3BwekJhSm9lSWJHeDBhSjdjbEVPZG5uclVnM2tydUtL?=
 =?utf-8?B?eTRjZWljc3AvWEFqamNHQVVCWGhxZEpWYkp1aUdEY3NGb3Z3Z3pWWkRNVkdV?=
 =?utf-8?B?VUpObjgvY1ZjSnhTUW5qS0gzdVViVkc0LzNEOVU5UmVkRmNjOTZENmlBejJT?=
 =?utf-8?B?ODV1NGQ3cm0zSW9aRWtuemRmbWU2WCt1Tk1BSFc0OXBkR3diSVpPcXpGRExU?=
 =?utf-8?B?UTJVdk5tM1NaSVJkRHQyWEhjQUFXSWoyL0dQMlBwRUg0c2RsUWNhTVMxcWlr?=
 =?utf-8?B?WDhLcEFIdnE1SU9tcmZmQmdaSFZDVVQ0M3FWckp6MFR5OGd2V0RKUi80NXc3?=
 =?utf-8?B?MGpKMkhERk95VWE5UCtvS0JZYmtNL3RCTnVHT3kyc202dDBKeWxIai9WenU5?=
 =?utf-8?B?MDNxeU0vYTZYUHB3ZHVQM3U0QXRvamlQaHprc3hVN24zc3FZZ25KOFlEbHM0?=
 =?utf-8?B?WVdMQ3R6SzJPZUVaSFkvdk00b1ZEbytFYmdFYlNWZktlN0dCcGp6K0RKOVkw?=
 =?utf-8?B?NUVycms2MWcxZkxzNlc3eVo0d2cxbEFYblpOaHNoUTI1N3lsVW9uWTNUYnJ3?=
 =?utf-8?B?ajR1bisraGJEL21lNUpnMFpzajdCNXJ0KytEYWNITUtlTW9od0hWMG0rUFNk?=
 =?utf-8?B?Z1ZsZkY1MENkVElkU2ZhN0FrSFJBWXNsQ2hubkIxS09SOFFXQ09RYU8xUkgr?=
 =?utf-8?B?dEdJNWI5L2dXR2xzeWhBeDBNcC9MTWlLd2RmNUlob29KYkwwRnRLNVZWc3VJ?=
 =?utf-8?B?L0F1Y0xHUUd2cFlqT3BWMlFna0Urci9VanovekRjNGpGMC9haFNQbmZIKzhN?=
 =?utf-8?B?Q21GY0FTb2hXRzZmRWJhb0JkeGx1ekdSYW9RSnEwejF1OHNNWHlMOGpZbnQr?=
 =?utf-8?B?QnBMa01QUE9TR2F3Tldobll6Y1oxMURyYnBOSHNHZFJpcWdzRXZ1ZUxpRmlj?=
 =?utf-8?B?WlNNdVlXbmZNa01weXhzS24rSS82K2J3N0NadlhTa3JSdlFQY2s2UStkZUZG?=
 =?utf-8?B?NHI4cGdXRG4xcmtxRHBVc2p6eHNaOTZWMFZSRW4zVHdCblVBYk0vbzQ0Y0tO?=
 =?utf-8?B?NmVmRmRjaWJQeGpMalp0NXlERURLaWR2WUFJTUE4c0FJZGY4UU5VYzU5b3RJ?=
 =?utf-8?B?Qkowa1hqOUpTMnp6V0lVbkNKb1JQc0Zic0hnSmNteEUwbStMdzV6aElNRzVu?=
 =?utf-8?B?N1c3UFBlcVFhckZOVDdnMSsrcStra3YyT0lkbzFDWkR0NFBwVDJMM2lHS0NH?=
 =?utf-8?B?bFYrTG4wdjVUYTdXY2VNSVNRTWtJbUZMbHIzM1dYNVhwU013Myt3bENBc1gw?=
 =?utf-8?B?REZ3Q0pWeHplbnlIdW80MjRhQjRUWjRoeUg5WGdyMjVwRmZuTG11SUpRTGU0?=
 =?utf-8?B?dmdLNzJyaHIwMVltU0U0dFdhWURXVVhlZGJldmZrRXZIVEQ1b0E1c1d5NlhF?=
 =?utf-8?B?aVVoVmFyUmV2K2ZzYmQwRHoyZzNKOExmRUo4SW1Ka0FGaUNrbUNvaFgyQk5O?=
 =?utf-8?B?NlVBNWMxZDdjOXFneE5hNkpBaDRlQnpnYlUyVFlQMkwzcjBKNS9EOXZjaVk3?=
 =?utf-8?B?eDFEcXpFNGxRYWRSQVZYa1FvLzJCdCt5aFpwWS9nSHFLUTA2a2ZBMWl0Vlk5?=
 =?utf-8?B?cTBCazlWWFA4ck90OWNCZDJHOFpPY1VzdmZXdEZGdHBRWEtoT0R0ak1lcGlP?=
 =?utf-8?B?c0tHOG5jcCtXenVGNzlvVjV6RDRLakQ4M2dPSGxtbERYdkplM0RUeG9XZHph?=
 =?utf-8?B?S1QzV2FOZnh5UFpOWDV5NGZzK0hERnhHZ3FSWENqQ080cS9Vcmt5U1RSNEtD?=
 =?utf-8?B?c2JjYmtEODRNYXFrM05XODlwd3c2bUdhRlQ0OHlDdk96NGlEMDFZOWh4cTFq?=
 =?utf-8?B?YmJQbjFTR2JFeE9YamY3QnlyM2h4Q1d5d3hXOFVCQU01NjVOVERpSzQxZ3Nt?=
 =?utf-8?B?TGV3OFNWYzY1YlNIbDdPNXFteVo5Y3p0Q2o0UkV2QnNmaW9zUks4KzdPMTl0?=
 =?utf-8?B?TkNPTER5MW51L0ZzcktHcy9GOFJiLy8waGpzK0RXV2x4NXZXWjZOWTFTRU9s?=
 =?utf-8?B?TWt2dUhQTSs1b0wxcWtWTWk3WEFjY0thNHdIYTVCMWI5NXZSbmFjRXo3VmJN?=
 =?utf-8?B?b2lhNHVDZ2E3ZmxYOHVma2dkV2R3SSsvTzBidWdOakNPTVFBdUlJemtQYVcx?=
 =?utf-8?B?QWE5N3BWWW1DaEtmRVZTMjJtSnpNRzlFYkd2Mi9QMnNiZVdkWCsyWmR6eXhT?=
 =?utf-8?B?bEptSjhXVnMrL0NDejFWYndQUlM2VGdrRm5wUTVhMzlBejNtTFNzZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF546A6A5FBA344D9C4267351D1127D2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: COih0XMd6zvs/xmO+x0/0BmSkt3+Q7vDZh5g5l4T5R/OFmqcSL2JL2LwLBhW3cx5ThC8HlPN5/Ye3iJvlqxixn/30nrxYi7I89ZhmThymHzWdGQtOlZSphmmFALAEWyW3teRcT3usWimVPT1GmFgrIGMrUlYZ7YNosOPOxP6Jwggffr8hngLSfl9bOx8hSUDfxZL07zs9b2tNaHxDuCne9b9MrkLmqae0alhrpIut8Fh+pHXvMZmPNiq8ef65fn3yuynzdZl6K33+udOmeOjFc1jAw2xJXSCr/EZt+oYJq/HuU6xG0gHRYwJeuA4M+jl2L+y6P48Iby076wA5OXMgg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2647.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00d2ef2-8756-4c41-dab7-08dea1d8c790
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:09:16.6325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2luOvMruImKVOBIvt/QSm0HOEsxDFbKEpvEHX5oHfTTVHEduPjaxvVsaVUMotKWudo1jG1IWQZyuJKuH7L/9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5858
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA0LTI0IGF0IDExOjA3ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VGh1LCBBcHIgMjMsIDIwMjYgYXQgMTA6Mjk6MzFQTSArMDAwMCwgSHVhbmcsIEthaSB3cm90ZToN
Cj4gPiBPbiBUaHUsIDIwMjYtMDQtMjMgYXQgMTc6MDUgKzAwMDAsIEVkZ2Vjb21iZSwgUmljayBQ
IHdyb3RlOg0KPiA+ID4gT24gVGh1LCAyMDI2LTA0LTIzIGF0IDAwOjU5ICswMDAwLCBIdWFuZywg
S2FpIHdyb3RlOg0KPiA+ID4gPiBEaXR0byBoZXJlLsKgIEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxk
IGludHJvZHVjZSBhbnkgbW9yZSBjb25kX3Jlc2NoZWQoKS4NCj4gPiA+ID4gDQo+ID4gPiA+IEJ0
dywgSSB0aGluayB0ZWNobmljYWxseSB3ZSBjYW4gcmV1c2UgdGhlIHNlYW1jYWxsX2lyX3Jlc2No
ZWQoKSB5b3UgaW50cm9kdWNlZA0KPiA+ID4gPiBsYXRlciwgYWxiZWl0IGluIHdoaWNoIGEgbG9j
YWwgJ19hcmdzJyBpcyB1c2VkIGFzIGEgY29weSBvZiB0aGUgb3JpZ2luYWwgJ2FyZ3MnLA0KPiA+
ID4gPiBidXQgdGhhdCBoYXMgbm8gaGFybSBmb3IgdGhlIGNhc2Ugd2hlcmUgd2UgY2FuIGp1c3Qg
dXNlIHRoZSAnYXJncycgdG8gbG9vcC4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgYW0gd29uZGVyaW5n
IHdoZXRoZXIgd2UgY2FuIGp1c3QgdXNlIHRoYXQgaGVyZSwgb3Igd2UganVzdCBnZXQgcmlkIG9m
IHRoYXQNCj4gPiA+ID4gaGVscGVyICh0aGVuIG9wZW4gcmV0cnkgYnkgdGhlIGNhbGxlcnMgb2Yg
dGhlc2UgU0VBTUNBTEwgd3JhcHBlcnMpLCBzaW5jZSB0aGVyZQ0KPiA+ID4gPiB3aWxsIGJlIG1v
cmUgY2FzZXMgd2hlcmUgd2UgbmVlZCB0byBtYW51YWxseSBzZXQgJ3Jlc3VtZT0xJyBpbiB0aGUg
U0VBTUNBTEwNCj4gPiA+ID4gaW5wdXQgJ2FyZ3MnIHdoZW4gcmV0cnlpbmcgVERYX0lOVEVSUlVQ
VEVEX1JFU1VNQUJMRS4NCj4gPiA+IA0KPiA+ID4gSSBraW5kIG9mIGxpa2UgdGhlIGxhdHRlciBv
cHRpb24gdG8gb3BlbiBjb2RlIG1vcmUgb2YgdGhpcyBzdHVmZi4gVGhlIHN0YWNrcyBvZg0KPiA+
ID4gc2VhbWNhbGwgd3JhcHBlciBtYWNyb3MgaXMgYWxyZWFkeSB0b28gbXVjaC4gDQo+ID4gDQo+
ID4gQWdyZWVkLg0KPiA+IA0KPiA+IEFuZCBTRUFNQ0FMTCAqdXNlcnMqIGNhbiBhY3R1YWxseSBj
b21lIHVwIHdpdGggdGhlaXIgb3duIHZlcnNpb24gb2Ygd3JhcHBlcihzKQ0KPiA+IHRvIGRvIHRo
ZSByZXRyeS4gIEUuZy4sIGN1cnJlbnRseSBzZWFtY2FsbF9pcl9yZXNjaGVkKCkgaXMgb25seSB1
c2VkIGZvciBJT01NVQ0KPiA+IFNFQU1DQUxMcywgYW5kIHdlIGNhbiBwdXQgdGhpcyB3cmFwcGVy
IGluIHRoZSBJT01NVSBjb2RlIG9yIGNvY28vdGR4LWhvc3QuDQo+IA0KPiBBZnRlciB3ZSBoYXZl
IGludHJvZHVjZWQgVERYIE1vZHVsZSBFeHRlbnNpb24sIGlycSBwcmVlbXB0YWJsZQ0KPiBFWFQt
U0VBTUNBTExzIGJlY29tZSBhIGNvbW1vbiBjb25jZXB0LsKgDQo+IA0KDQpJdCBoYXMgYmVlbiBh
IGNvbmNlcHQgc2luY2UgYmVmb3JlIHRoZSBFWFQtU0VBTUNBTExzIGFjdHVhbGx5LiAgRm9yIGlu
c3RhbmNlLA0KVERYIGxpdmUgbWlncmF0aW9uIHVzaW5nIGJsb2NraW5nIGV4cG9ydCBkb2Vzbid0
IG5lZWQgYW55IG9wdC1pbiB2aWEgbW9kdWxlDQpleHRlbnNpb24gKG9ubHkgdGhlIG5vbi1ibG9j
a2luZyB3YXkgbmVlZHMpLCBidXQgdGhlIFNFQU1DQUxMcyB0byBleHBvcnQvaW1wb3J0DQpURC92
Q1BVL21lbW9yeSBhcmUgYWxsIGludGVycnVwdGlibGUuDQoNCkluIGZhY3QsIHRoZXkgaGFkIHRo
ZSAibGF0ZW5jeSByZXF1aXJlbWVudCIgYmVoaW5kIHRoZSBJTlRFUlJVUFRfUkVTVU1BQkxFIGlu
DQptaW5kIGF0IHRoZSB2ZXJ5IGJlZ2lubmluZy4gIEl0J3MganVzdCBhdCB0aGF0IHBvaW50IGFs
bCBTRUFNQ0FMTHMgd2VyZSBub3QgdGhhdA0KaGVhdnkuDQoNCj4gSXQgaXMgaXJxIHByZWVtcHRh
YmxlIHNvIHRoYXQgdGhlDQo+IHNlY3VyZSB3b3JsZCByZW1lbWJlcnMgYW5kIHJlc3VtZXMgdGhl
IGNvbnRleHQsIG5vIG5lZWQgZm9yIGhvc3QgdG8NCj4gcmVtaW5kIHZpYSByZXN1bWUgbGFnLg0K
DQpUaGUgZmFjdCBpcyB0aGUgYWZvcmVtZW50aW9uZWQgbGl2ZSBtaWdyYXRpb24gcmVsYXRlZCBl
eHBvcnQvaW1wb3J0IFNFQU1DQUxMcyANCih0aGVyZSBhcmUgOCBhdCBsZWFzdCwgYnV0IG1heWJl
IG1vcmUpIGFsbCByZXF1aXJlcyB0aGUgZXhwbGljaXQgc2V0dGluZyBvZg0KJ3Jlc3VtZT0xJyAo
cGx1cyB1c2luZyB0aGUgU0VBTUNBTEwgb3V0cHV0IGFzIGlucHV0IGZvciByZXRyeSkuICBJIGRv
bid0IGtub3cNCnRoZSBzdG9yeSBiZWhpbmQgdGhpcywgdGhvdWdoLiAgVGhlcmUgbWlnaHQgYmUg
c29tZSB0cmlja3kgdGhpbmcgaGVyZSBmb3IgdGhlDQptb2R1bGUgdG8gcmVtZW1iZXIgYW5kIG1h
bmFnZSAoZS5nLiwgbWlncmF0aW9uIGhhcyBhIGNvbmNlcHQgb2YgIm1pZ3JhdGlvbg0Kc3RyZWFt
IiwgYW5kIHRoZSByZXN1bWUgaXMgcGVyLXN0cmVhbSkuDQoNCj4gDQo+IFRvZGF5IHRoZXJlIGFy
ZSAzIEVYVC1TRUFNQ0FMTHMsIFRESF9TUERNX0NPTk5FQ1QvRElTQ09OTkVDVC9NTkcsDQo+IGly
cSBwcmVlbXB0aW9uIGhhbmRsaW5nIGlzIGEgZ2VuZXJhbCByZXF1aXJlbWVudCBmb3IgdGhlbSwg
YW5kIEkgdGhpbmsNCj4gaXQgaXMgc3RpbGwgdHJ1ZSBmb3IgYW55IGZ1cnRoZXIgRVhULVNFQU1D
QUxMcy4NCj4gDQo+IFNvIEkgdGhpbmsgYSBnZW5lcmFsIGhlbHBlciBmb3IgRVhULVNFQU1DQUxM
cyBtYWtlcyBzZW5zZS4NCg0KWWVzIGNvbmNlcHR1YWxseSBJIGFncmVlLCBidXQgbm90IG5lZWQg
dG8gZGlzdGluZ3Vpc2ggRVhULVNFQU1DQUxMcyBvciBub3QgSU1ITy4NCg0KVGhlIHByb2JsZW0g
aXMgdGhlcmUgaXNuJ3QgYSBjb21tb24gcnVsZSB0byBmb2xsb3cuDQoNCkUuZy4sIGxldCdzIHNh
eSAidGhlIG1vZHVsZSBjYW4gcmVtZW1iZXIgdGh1cyBubyByZXN1bWUgZmxhZyBpcyBuZWVkZWQi
LCBob3cNCmFib3V0IHRoZSBTRUFNQ0FMTCBpbnB1dHM/ICBDYW4gdGhlICJvdXRwdXQiIGFyZ3Mg
YmUgZGlyZWN0bHkgdXNlZCBhcyBpbnB1dCBmb3INCnJldHJ5LCBvciB0aGUgb3JpZ2luYWwgaW5w
dXQgc2hvdWxkIGFsd2F5cyBiZSB1c2VkPw0KDQpOb3QgdG8gbWVudGlvbiB0aGVyZSdzIGV4aXN0
aW5nIFNFQU1DQUxMcyB3aGljaCByZXF1aXJlIGV4cGxpY2l0bHkgc2V0dGluZw0KJ3Jlc3VtZT0x
Jy4NCg0KSSBiZWxpZXZlIHdlIGNhbiB1c2Ugc29tZSBzbWFydCBoYWNrIHRvIGltcGxlbWVudCBh
IGNvbW1vbiBvbmUgdG8gY292ZXIgYWxsDQpjYXNlcyBhYm92ZSwgYnV0IEkgYW0gbm90IHN1cmUg
d2hldGhlciBpdCdzIHdvcnRoIHRvIGRvIChtYXliZSB3ZSBjYW4gaGF2ZSBhIHRyeQ0KdG8gc2Vl
IGhvdyBkb2VzIGl0IGxvb2sgbGlrZSwgdGhvdWdoLCBJIHRoaW5rKS4NCg0KR2l2ZW4gdGhlIFNF
QU1DQUxMcyBmb3IgVERYIENvbm5lY3Qgc2VlbSB0byBmb2xsb3cgb25lIHJ1bGUgdG8gcmV0cnks
IGFuZCBsaXZlDQptaWdyYXRpb24gU0VBTUNBTExzIGZvbGxvdyBhbm90aGVyIHJ1bGUsIGl0IHNl
ZW1zIGZvciBub3cgdGhlIHNpbXBsZXN0IHdheSBpcyB0bw0KaW50cm9kdWNlIHRoZSBuZWVkZWQg
cmV0cnkgaGVscGVyIGluIHRoZSBsYXllciBvZiBTRUFNQ0FMTCAqdXNlciogKFREWCBDb25uZWN0
DQphbmQgbWlncmF0aW9uKS4NCg0KPiBUREguSU9NTVUuU0VUVVAsIGhvd2V2ZXIsIGlzIGFub3Ro
ZXIgY2FzZS4gSXQgaXMgbm90IGEgRVhULVNFQU1DQUxMIGJ1dA0KPiBoYXBwZW5lZCB0byBmb2xs
b3cgdGhlIHNhbWUgaXJxLXJldHJ5IGhhbmRsaW5nIHByb2Nlc3MuIFRvIGF2b2lkIGNvZGUNCj4g
ZHVwbGljYXRpb24gd2UgaGF2ZToNCj4gDQo+ICAvKg0KPiAgICogc2VhbWNhbGxfcmV0X2lyX2V4
ZWMoKSBhbGlhc2VzIHNlYW1jYWxsX3JldF9pcl9yZXNjaGVkKCkgZm9yDQo+ICAgKiBkb2N1bWVu
dGF0aW9uIHB1cnBvc2VzLiBJdCBkb2N1bWVudHMgdGhlIFREWCBNb2R1bGUgZXh0ZW5zaW9uDQo+
ICAgKiBzZWFtY2FsbHMgdGhhdCBhcmUgbG9uZyBydW5uaW5nIC8gaGFyZC1pcnEgcHJlZW1wdGli
bGUgZmxvd3MgdGhhdA0KPiAgICogZ2VuZXJhdGUgZXZlbnRzLiBUaGUgY2FsbHMgdXNpbmcgc2Vh
bWNhbGxfcmV0X2lyX3Jlc2NoZWQoKSBhcmUgbG9uZw0KPiAgICogcnVubmluZyBmbG93cywgdGhh
dCBwZXJpb2RpY2FsbHkgeWllbGQuDQo+ICAgKi8NCj4gICNkZWZpbmUgc2VhbWNhbGxfcmV0X2ly
X2V4ZWMgc2VhbWNhbGxfcmV0X2lyX3Jlc2NoZWQNCj4gDQo+IFRESC5JT01NVS5TRVRVUCB1c2Vz
IHNlYW1jYWxsX3JldF9pcl9yZXNjaGVkKCksIGFuZCBFWFQtU0VBTUNBTExzIHVzZQ0KPiBzZWFt
Y2FsbF9yZXRfaXJfZXhlYygpLg0KPiANCj4gSG93IGRvIHlvdSB0aGluaz8NCg0KU29ycnkgSSBk
b24ndCBxdWl0ZSBnZXQuIMKgV2hhdCBkb2VzICJleGVjIiBwb3N0Zml4IG1lYW4/DQoNCkZyb20g
cGF0Y2ggMjUsIHRoZXkgYXJlIGFsbCBpbiBURFggY29yZSwgc28gSSBkb24ndCBxdWl0ZSBnZXQg
d2h5IHdlIG5lZWQgdG8NCmRpc3Rpbmd1aXNoIEVYVC1TRUFNQ0FMTHMgdnMgbm9ybWFsIG9uZXMu
ICBJTUhPIGl0J3MgYW4gYWRkaXRpb25hbCBsYXllciB3aGljaA0KZG9lc24ndCBhY3R1YWxseSBo
ZWxwIGFkZHJlc3MgYW55IHByb2JsZW0uDQoNCkJ0dywgd2Ugc2hvdWxkIHJlYWxseSBnZXQgcmlk
IG9mIHRoZSAicmVzY2hlZCgpIiBwb3N0Zml4IGZyb20gdGhlIGZ1bmN0aW9uIG5hbWUNCnNpbmNl
IGNvbmRfcmVzY2hlZCgpIGlzIG5vIGxvbmdlciBuZWVkZWQgYW5kIHBvc3NpYmlsaXR5IG9mIHJl
c2NoZWR1bGluZyBpcw0KaW1wbGllZCBwcmV0dHkgbXVjaCBhbGwgcGxhY2VzIGluIHRoZSBrZXJu
ZWwgY29kZSBub3cgKGV4Y2VwdCBzb21lIHNwZWNpYWwgY29kZQ0Kc3VjaCBhcyBjb2RlIGluIElS
USBjb250ZXh0KS4NCg==
