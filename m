Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0894433508E;
	Thu, 22 Jan 2026 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109008; cv=fail; b=EHJy7fW5dJ3/MRmuAy3typ8HBgSlIV+X6B18rEuWdFxb3Da4NFfwjjyyj/SuCAilGmfyeg2xjK6hhZTq5k0xKdvVOnRtqD4VKfaDV/7DMdi/zMxGqrmDgMX0/koweCsdyJyUFBv8alZu76rmIJUof3eYHcHA8ngsLhSkYrEr8Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109008; c=relaxed/simple;
	bh=KwbgD9GmsEZX7hmhO1HI3cR4rBhhZ3XzT75Pp6qSJew=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=kBQ790SmfNs9uEFiPgcZMjikJ9PfpFozbsWov7nvkY/zPKao91NzhI7FE98U22A5nFPDabqCgVyE6ke662WqfLJANcJWUJRxfpSpJiVnlZvjwLk7sIR62K1h5CD1Xn4bcdlXl6J0pXfvNNF3y44uEHAXWTUN4w84eBVG0QXGx0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhMQnZmY; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhMQnZmY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769108999; x=1800644999;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=KwbgD9GmsEZX7hmhO1HI3cR4rBhhZ3XzT75Pp6qSJew=;
  b=NhMQnZmY+XgtlmRwDknYM+BFriUOd7eLiSo33NXoBAoPnM4lRouXGA7e
   TNgRf/ZHOm4yfWHSdsnwZZ+1eAVFiWu2yXSJcUmc0KhCXucYNNuorbkKb
   ah52ZSOksxIR0YR/R7u8iNBOsjQT+Z7Rvd3ZsoGH2th3ghEDVSyvFFcpn
   zSvYNDLCgGDZUDb35qqapeGMlTdQRdBVUu19X0PLsfcV707hmKjjOv8O4
   5JQfU8u4wFxv8cprSzFoJO3vxEsAyN2QIbeFVfR0zpubPHbKG68Cc70bi
   AuitKHIK9fCPv/TXRvvqQN1O/GXaMsNGcyPsinqTiWPmyo2MC2WnkC72E
   w==;
X-CSE-ConnectionGUID: t29DtM/lQA+u//hHSKGRCg==
X-CSE-MsgGUID: m5csN9JnQresfMLQJoOvUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81802942"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="81802942"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 11:09:55 -0800
X-CSE-ConnectionGUID: /u1Fk9eYQsmlNPWcHOBrYg==
X-CSE-MsgGUID: Nxaq4bTlTdG97Z8dn7naeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206873390"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 11:09:55 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 11:09:53 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 11:09:53 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 11:09:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lI89CdtL6pQJNKYKOhDrscD1ClAEpgrHQ270w63jGQPCbiuGFahcscYdj2FLY0FEa92F8j9hW/Zu4ckJyIT9alH3Sl1sn2xUvqKibPeYUpObzIcjjULOCTDczZg4QJV8OU+kAbWtJ4mIS82S2tK2fxdbhj4wzr/J+HJdgrrg9ZH7bcUbGQTSUtWyJ5sUaC4nWs3+ukJXuS+gwyhOq0Oew9KoNWA8MR15t78rgyNecUuQ5JtUwqkT2EztFs7QWiGK8Y2f6WlxSfqO5V0ttdxtBqvkdnLPs8MTWw4af39V1TV//bdc86ZXEd34GS0j63cE8UDMRSa1ngk0XtB39p0A4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7Msv/+ki7RXjVgcZ9gzUlfWOu+94euGAVxWpHDT+Q0=;
 b=fjmHAJsmdOoGCcFpBpg3NeIuWO/HfxgVB3sTU78tcByTXs44tfuBDOwK/cJAykvLMKEq9t2kwysQr9XFb4Ah/gbAMaWNsrfY1OMLDYBqJobd03Li+Nd9UM+O4Ej49iyxu+DpmfcN3Qu+u2mcnr3g/+fSjAUgHjLGBlQ6v640Q99GzL6B4apBHFCQxgm5q3IANMbwjkse0Mr1Hxlc80ClRqHkOx+9nzYMmvxs2dj+EYByYmcd99nrmw1LQ10fv4FVeFPU2Z+ZdzRqN92MzMVTbKWqhtVjVwAnP1MTZCZr+eZmaXpren4CBRZ4JS7m5OSf5O8M9V7IfniodBaAW5QJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 19:09:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 19:09:50 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 11:09:48 -0800
To: Lukas Wunner <lukas@wunner.de>, <dan.j.williams@intel.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Terry Bowman
	<terry.bowman@amd.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <697275fcc1686_309510085@dwillia2-mobl4.notmuch>
In-Reply-To: <aXInXZiTCSN06si8@wunner.de>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-11-terry.bowman@amd.com>
 <20260114190818.00004112@huawei.com>
 <6969513c2b1a4_34d2a1008a@dwillia2-mobl4.notmuch>
 <aXInXZiTCSN06si8@wunner.de>
Subject: Re: [PATCH v14 10/34] PCI/AER: Update is_internal_error() to be
 non-static is_aer_internal_error()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: db62c494-aa4e-4ed7-e363-08de59e9d136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmx6SFRpTlAvSUcwVHhEd1J4ZjFycUNwODRiWVlzUDNsRHhWcmowQTBNZDBM?=
 =?utf-8?B?WExnMkl0aU9XUDBjNWdqMTVTMVd6bGt1bnU5U0FQMHREOFhPaWdjUWlWZFdL?=
 =?utf-8?B?U0U4U2VxT2k3ODVwVEd1eWR2MkQydDRNa0VvajRVTjJLN2ppaGx4UWZodlhy?=
 =?utf-8?B?U3J5RlR3UWNlOXNwUGdwZEJ3OHV6L3F0TDlMWHJSVzhHQ3ZHUHU2N3prSFNX?=
 =?utf-8?B?MDE3NmFmMHlMc3Y4SHFsd0w0bFh2SnRTUk5lcWVhSG5Jc3pHNjl2WVd1S3hY?=
 =?utf-8?B?ak5oeWhHa2s3QzNRNzJxdFQrY0hxcGtmZEpPUlhJY0IzcUd4YmtadzNYc0Yw?=
 =?utf-8?B?OTNWYTY1WmZ3ckpNMkk3bjRBSHg5TGt2TlRHbGd5MnNjVEN3NU5ILzdrRnF4?=
 =?utf-8?B?My9HT0kzZ2JsSlN1ejFLUDdaQ3JPQm5CTnJDZXIvUkNPYTN5dnJlNTlyU2Vn?=
 =?utf-8?B?OTJkZEdVNXI0OXFUVzlRVGlrcW5aT1Z4T0VtMFA5RUVJRFFCcHV4MEUxQkR1?=
 =?utf-8?B?YnJndUl5WmdTV2dobWdQZkR5SmdQWk96Wm5WRHZCZ3grSmE0c05CYzBHeFZH?=
 =?utf-8?B?LzE1ZXZEQjdCSzRwS2swT2lxMXV2b25pcnJSZFppRlBldlc2VDZxNExtTUhj?=
 =?utf-8?B?QnArTlFnOTlIa0dXTFdQUnJiZ0FmM0N4UFlFNG8zdEM0c1VXYWZFcHpTLzhM?=
 =?utf-8?B?MkRKNHhUcEhvdmdoYVRHci9tNlZweEdROGdMak9rOStvb1Vxdi9Kbk83dnIw?=
 =?utf-8?B?Wm14dEZPdDhNT2twVVZGZUlRaXdxYk8reHN0eHB0U3MyaVJsTUxNTWlJVkJY?=
 =?utf-8?B?SEdjREdSUzBEbzRyeGVmVFZBOGk1NDVpNXREVWNVWWVxNWZmc21xcHNKanV2?=
 =?utf-8?B?UXBoTjhyMWIrT2Q3TmJJeVBHd0k2Si90dHJDVWxPUS9DQVFuemY2bGlGeEJs?=
 =?utf-8?B?RjN2d0cwa2dzQTlVYkE5VHBHaTNtNWJHanUydmxQMENCRzNlWmZuRW9oMWRP?=
 =?utf-8?B?c0E5TGFoa0planI3ZU53Ynhlbkw4bnpteTJTSS94WU1DZVJ5d0psQTN5azRz?=
 =?utf-8?B?bExiNW14b2hYMFJwUUxNTnlidlJFT3lTYmdDbmFnakZaektxQjlHU3ZZbXpk?=
 =?utf-8?B?RGQyZnFRaytiaUhUaTZxQVJWd1kvdnc5eGo3TFBWeU5nWlV0dGRXYXFUWi9V?=
 =?utf-8?B?TU1MbXAyOVFVbk1GNysveXRmeUcySlM1RDFtRkNBNVlaU2FIOHYzSHNrVDNa?=
 =?utf-8?B?Ykt5OVhGdzNaTzR2NlpqM3BpQWpCaXVCdE1lRHFxL0ZBbzFxSHdCak1DNEN4?=
 =?utf-8?B?dndWcm16aUxwUnlXZUVaVW9yTmxSWFNkcE5nM2E2SVJWMVZodlJWc1VDVHRG?=
 =?utf-8?B?bVYrSnJaMEFIVWhpN09tc3Y0MnhyRW81MVBkTnFQSlFiNUJCMnpRdlBKVnlV?=
 =?utf-8?B?SHMrTnNrdC91eEFWc2xvM09qa1JOYmtJbVd1Q1lVYy82bHJOSnNzZ3E1ZnFt?=
 =?utf-8?B?TFFEMU51cEp3dEloR01rcmJ2RUpYaWxCZmlCS3JqSml3Z2pNQzhCaW1QMDI2?=
 =?utf-8?B?NjNDak4rMUR6ay8xTkd0a2FsRjlRSTd3QzBjTGRpYTcxcGdpbUh5bHhrK2hl?=
 =?utf-8?B?Q3o2WGthTHM5T3RTVmw4WTJhMzVHeEZMUHQwcmg2SXBHTkMxVnZPMk5UWDVi?=
 =?utf-8?B?SFVId0svK3BWOWhiSExERFVYWXN2TXc1eDRYRWZlMlhoOVp3RDhmM1c4aUdX?=
 =?utf-8?B?MDVWSGorV2FrMFVhNXBXVzRRNmVQeUFyMmFzRHg2a3Ztd1lWaGwwZGUvdXVB?=
 =?utf-8?B?cEpSblNMT1FnRHJpTlg2dXVYajhwbllVeVNWS2ZkM3BLeVVLb2QwdHVIZ0U4?=
 =?utf-8?B?VnFzY3pxUWgySjdqbDRNdE9Uakx1YThkNHEvVWZuQ20xeVVOM1htN3d6QzFh?=
 =?utf-8?B?T3hWbGV6M2Y2Y1d3cjdzV0cyaldDS1EwUUVyVHV4RE9yMm1wVDl1Rk43Vk1I?=
 =?utf-8?B?Z1FpKy8yUUJhOUYycy9FeHZWeW1nclNlUEl1ZUN5MS92MXZsdGtyYTE4anJW?=
 =?utf-8?B?NG90R2lnQXJReXYwWGlqZmJOZitoZkppWnpDYWRtdmZVUVVUdFkrWUUxelJh?=
 =?utf-8?Q?gtQc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjZ1YWZNa2Q1R3IvRFl1eWsydGdZdWU1U1poNTFIRlM3ck9BZG9pRnY1bVFN?=
 =?utf-8?B?QkFWUnlUQUo1Y3N1NnBVRVpHRjVMTG14TFlONDJpd2tTWnRJNTM4LzdWYzZ3?=
 =?utf-8?B?ZTQ2dUx3RUpwdXRjV2doaVRTZlcvejd2S2tMWWJHanNJZjVLYVhkazExZkZ1?=
 =?utf-8?B?clVkTzZYZnNPSlVWYStWOTdsQUZIRlJwb2NnSVdKdHd2MzQva1daNGdBUGpB?=
 =?utf-8?B?QXNBQld0S0RzQVptb1NRSE1PQWl5UVpqakZwbVJmdlA0TXQrOTJGdTFCRjJW?=
 =?utf-8?B?SnVzVmdSMkw4MVE2aWRQSXRWc2Rrd2xaSW9KbFZBcy9EOWtaL1JFMVBhVjFM?=
 =?utf-8?B?R1E0bDlvcEoyYlF2L1ZzcFFiYjF5U3pDRmxHOEphc3l6Y0xSUDIxa1c3MEVL?=
 =?utf-8?B?dENiYlpZNHhSdGVTVkMrZENteWRjVnNzaHZOUzRGbFpkYkVLRXJaNHNiVWlM?=
 =?utf-8?B?SkY5UnZTVW1vUjFiMVZHSDdWUi9GUjIxV2xFUWFKU3V6cTRySGs1K1pqWHor?=
 =?utf-8?B?dzgvajN5Znc3MnoxZWpsODU4Ymw5bTlxbGVhZ0JqcmZnSVhVc055WGRFa1F2?=
 =?utf-8?B?NUhweEYzK09VL3RBWkE0Wk9LdFlmSTJudm03Z0lMcFhkZEc4YmtGbWdBUW84?=
 =?utf-8?B?UURjSjJQWmVSQllpa2dHM0lkSVhpWkZtYmJoc1VwZmlOeHpNSmV2TTVxWDNu?=
 =?utf-8?B?Nkt2ZXF1dU5Ea041elhxbzcyNGlqZDd2bGdWVWJLS3VUL0w5WmlMblRXR2U4?=
 =?utf-8?B?TUdicVltaUYzQlF6amxXRXpiVXF3bHdVSVdsNzF6cHlac1BrUDkyeXFZek5D?=
 =?utf-8?B?NlNVZDRuRmdWT3FFekl4VlhCL1BXc2xPQXU3eEVOa01OSzljZFpqMzRtUDd4?=
 =?utf-8?B?QXpEUzQ1Ukdhc3pYcWVKUkZadVBKanc4TUJRbXNlZ2hYS25lQTl2cXYvTUgw?=
 =?utf-8?B?UjhoYWNwK0t0ZlUxdm43Si90Vk9NN3pBTzdycWwwZlBlS09QaUIwL2FtbUI5?=
 =?utf-8?B?ZkFMZmltZkFEZTFvUnhlM1FEeXNxNFNyOW9wb0pSb045U1Z0R3lGc1FDOXht?=
 =?utf-8?B?L1Y4eUVkSzk1ZWtuYXNNM1dJTEhwdjBIUmZRcVZyOHdKYmU2VU9DUTJOSmJZ?=
 =?utf-8?B?cFlGK29aWXk1Tzg1cDlreHl4OVRvd25jck4xc3RXWkdsTld4RzZialpwS1dB?=
 =?utf-8?B?clJLUUwzbkJCdmU1d2VnUnhvelRyYzNwaFBJdGZIcG9qQ2p6UVpFNU5zRmty?=
 =?utf-8?B?Q01yMEFWRVFrSzlJMVFmM1U1eUZRMFhHQ0s4TTN5SU5KL1E0eXEvNzZRcS9T?=
 =?utf-8?B?a2E0WUtIb2p0elhUSXFiRm5xUG4yWkxUSjF1VlgxL3RIWEFDUzEySWJzYXpS?=
 =?utf-8?B?YWFIOS9yb3RZbkZ4emZYc1JLU1grWis5ekFHL1VmSHJPSFRnQXB1SWpuSkYv?=
 =?utf-8?B?TVpRT3JobVlEaWlOZGlHVVhJekx1MGMyZGFSeUltS0hQakdRSEk3MHlVTEdP?=
 =?utf-8?B?RGFIWlRNbVo5Y2tjdEFETERoY2dGdWFldGxESkZXUkxLZVpnYmZtWlo4REc5?=
 =?utf-8?B?RkVQcHpQRTNhNFdBMDAzSW40MUxIZmRLNEc5NWc4VDdRNXI2MmJuRHFSOVFz?=
 =?utf-8?B?NmoycjFtWW9JbXpsUitsOEFhUjN5MmdVRGhnaUxYby9PN08zcS96MVdIdzgr?=
 =?utf-8?B?UWZYV3k1RXNpMVBaWlJMS3hrYlhab0JSYm5xWEEvekFkT3VLOWJKSW5lQUZq?=
 =?utf-8?B?VG1wY0lsYXFPU1pydDRRQ3JBV21lbUgyOW9oSG5iaU9xRkJkYjhwNmwyK2ZR?=
 =?utf-8?B?M0VLQnVGN1JYRDBvaU1kK3FjTmFqN0hEaythNGpydzZNTG0rWnpENUp3SkZ1?=
 =?utf-8?B?NXM0WWQ4Y2RTL1Fvd2d1SVg2ZjlXTkJ6ZHlnQjhHZFllb204NEpkS1lENVYy?=
 =?utf-8?B?SVJwR3FlbVFZNjNVendLTWtTQ0s0WnI4VlRJVmpCVW1MRzBFaDJzMlNiLzQz?=
 =?utf-8?B?QjNEZWpZTExuNEVIY2o5T0tWRXhRRlo3UmFyMExwb1d4S09tVmpQMjU3eUZp?=
 =?utf-8?B?OG9Cd1NnREdjRDFOcDBuT0NCMmJGVm9oa0NDNG80ZzJqNWVTVEhqOE5XRUtq?=
 =?utf-8?B?TTlWbER5RU9DenA5cWdIbU1oWmlnOEtqWnBVR0o4SW12WDBVdUlhWUpDZGNN?=
 =?utf-8?B?b2FBKy9mQzlWUVJYTGcyRk1ndHdDOGdJNHhzOSswVEJ6OWZFeWt6TWxXZTRZ?=
 =?utf-8?B?VHo5bTBSaGlzUGhESm5ESStxMkdYVGlQRmdrYm1NdUwrTzdEMjV3SkZ5Q2pr?=
 =?utf-8?B?Y2ZaSisxUzVVTnRpQnZUdWc0SUs2MXpzSjNBTFgvS1E5NzBkSDJwY3pjMnJa?=
 =?utf-8?Q?X5mysoCDYvcy97nA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db62c494-aa4e-4ed7-e363-08de59e9d136
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 19:09:50.7063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPES9QpbXhG8TPpTdFW2ThSSwhYoxtm/EMfdrBKgYKrXZSy57rvj0Qro2bvbZo/RM8MIqnFWCB4HQpUEx7AaNfYzBIjlQkNMzILPC+TwyBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Thu, Jan 15, 2026 at 12:42:36PM -0800, dan.j.williams@intel.com wrote:
> > I agree with the general sentiment, but not the conclusion, especially
> > because this is a private detail. Linux has long ignored internal
> > errors. The only reason to consider them now is because CXL decided to
> > multiplex its error model on top of this oft-ignored feature of PCIe
> > AER.
> > 
> > Specifically, portdrv.h is not in the global include namespace, this is
> > a private detail of the only conumer of internal errors:
> > drivers/pci/pcie/aer_cxl_{rch,vh}.c
> > 
> > At most we should have this as a comment to clarify:
> > 
> > /*
> >  * Note, internal errors are only considered for the CXL error model,
> >  * not for other implementations.
> >  */
> > 
> > ...and the pci_aer_unmask_internal_errors() export should be:
> > 
> > EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core")
> > 
> > ...for the same reason. Steer folks away from thinking that it is open
> > season for adding more internal error support.
> 
> It's not like Internal Errors are a bad thing per se.  They're a way
> to signal "other" errors besides the spec-defined ones.
> 
> As an example, and I'm keeping this in general terms to avoid devulging
> information about future products, a device possessing ECC RAM may raise
> a Correctable Internal Error when ECC successfully recovers from flipped
> bits because it allows alerting the user in advance that the device might
> need to be replaced in the near future.  If ECC recovery fails, the device
> might try to use a reserved spare portion of RAM in lieu of the failing one
> and instruct the AER driver to recover through a bus reset.  Such errors
> are not covered by the spec-defined types.  Using the Internal Error type
> is the only possibility it seems.

The Internal Error type is a poor fit for that. This ECC RAM scenario is simply
an internal device event, not a PCIe visible error case. Consider that CXL
Memory Expanders are nothing if not "devices possessing ECC RAM" that may
encounter correctable errors in that RAM. Yes, the user has need for those
correctable errors to be reported, and no, PCIe AER has no reason to care about
conveying those reports. CXL bypasses AER for internal ECC RAM events.

PCIe AER only notices device-internal ECC RAM events in the case where a PCIe
transaction encounters an error. For example, a completer abort attempting to
pull from bad RAM.

So if CXL saw no need to architect internal ECC events into AER, why does Xe
think it is special in this regard?

The CXL solution is simply a typical device interrupt that notifies new entries
in the device event log. See trace_cxl_dram() and trace_cxl_general_media() for
that event handling.

> My point is, there are valid (upcoming, not theoretical) use cases for
> Internal Errors and creating infrastructure in the kernel to take advantage
> of them is a good thing.  Hence my continued pushing back on hiding or
> discouraging their use.

It is fine to look ahead, but I would not go so far as to pull in future
requirements into a present patch set. Especially when those future
requirements are suspect.
