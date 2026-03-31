Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982513A381D;
	Tue, 31 Mar 2026 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984585; cv=fail; b=qquDzk996tJCtky9AQyXsqFlxY2UzM3HxqIC5TXAT70ibk5Mfwz0Fy2w+hZdkU4AkuJv8UzLInBMD8FhYHvY8fzTZegnFfvqVKf1FMoJqjBwVg9UiZqKTXb+AET1LYJCzLQhGslnGmdF1Jd0esoKO320UJbfYbxyvZkyh5cyRKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984585; c=relaxed/simple;
	bh=Q3lOdM7JZeIpzzKbrv36vvHTymCrZPStwFJtJbI1mkI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=tqu00HiYDlW2VbJ7ZO7i+o/Nbny1PFqCLflkNaVLe/T3NEEnPU6y5MhaTKRUcr1ODocPWoSk/CO0w/LBN+AagkSvUqtpY0u+pvHLdGEAdi8ZK6NVtbNLdGSKdv33Mih0FYD4IGEu9DaGj0OM0xYY0YIpLjCPUdRdmM3893rZnw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGNA3cZs; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGNA3cZs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774984584; x=1806520584;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Q3lOdM7JZeIpzzKbrv36vvHTymCrZPStwFJtJbI1mkI=;
  b=HGNA3cZs94AOh0sDxvmi/Pk+O34qpsHWXgvkyzeLcyFXNaHbPyhdrN+o
   mieETC+aAUFlMjVHbXRWeM177kIN3WR30zICWuCCd6y/LS0B7cIkVn0bP
   rZ/iA0BAi6ApJXKI98I13+NFT4wqY/7JVkoorNymW/XAEPJARLkP2ZCO/
   FIfKpHRbd8DdXIcEukUVObL9Kj49DIZIv4UjKl9Us97TbUAPt4hZIKVQG
   0G3NWD/zRKKkO/ZN4vHZEZMDZSdseLDZDpBCgeErSzzbq1Os1TAXJvJ33
   mGjKXxGiCpMS3aQG+VGzkjYW+85jTMpyYl43rpu6auFZHIuOFwEcGSMYN
   A==;
X-CSE-ConnectionGUID: 396ifkDWSQWgI2/SU/tu6w==
X-CSE-MsgGUID: 8Hn7OeJdTRWFbzN9+8+fGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87472509"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="87472509"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 12:16:23 -0700
X-CSE-ConnectionGUID: NLpmHGgGRnCLjOl5VUgobw==
X-CSE-MsgGUID: +D9WH3SHRe2UQtRBNO1ajw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="226700605"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 12:16:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 12:16:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 12:16:22 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 12:16:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4FoClKO1tGdRyGkN8hZTuaafr75gIV6KYg3hDLbnuZaWT9c7PHHi+YLD4+KnetAqb97qFgo9XrlTLOulN19HvwGke2V+mnsTRsHzn0fU9KaboMfr4YNutJXb1xMsG6gzqDo3r7s92WdGR4t0cAcGxjqZ1l2Do1YQCdGaxDlwb+Q0bupgDeOaXfztZMcWCgyNrOF1cySNCPpoWyBW+tYQx0Yk2xZGrza1mvd13CHthYiaUCLw4qgmzojVJlpm/0EX8d88z6ATD+ES2s9WXVprj+4eyahHmDjg8wQQVVCjeqvT2QBetWS7NWMC0xiQiDslkF7Z7zs7g0m6blmBiEaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6h3b+bRrIxBU1+wH2uelf/wdaE+orYmxarFDiwyYX8=;
 b=DNcJdA9CTfVSVcN8w7v+Vge/PcK4VT5x3qod+V8NPjgLjf9yEuthOILu1COP0Nn8FbTHcPLpjs9dYVKXx8p4L3aMz7mu8OdfrJFyYiy9IBSRkF7hBpJMCj5dC+DAv0exuqqpYG9feYUK5L+KomL5StMKLdlzuNqCfa0XAOy3Gm7ceMojjKlt4+H6B/9KFzuMeso87jkUnIXD8ueuhRRGnS/KCHZjWAUqVE5jfQyRLv1CvVt9Kk81YXCJJ4OMiA1D1/B+oGSt+W/89f4/VA3QQw7Qea7PYJDNwTZlV5p448TvRKRmXGmiTK+pbbVG3/ZdAYSxQw6aO0VC53X/oYBxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6115.namprd11.prod.outlook.com (2603:10b6:930:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 19:16:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 19:16:18 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2026 12:16:14 -0700
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
Message-ID: <69cc1d7ee3088_1b0cc6100c3@dwillia2-mobl4.notmuch>
In-Reply-To: <e2583442-55a8-460b-90a0-7b56db0722dd@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-11-terry.bowman@amd.com>
 <69c9d4b8e08f1_17890410047@dwillia2-mobl4.notmuch>
 <e2583442-55a8-460b-90a0-7b56db0722dd@amd.com>
Subject: Re: [PATCH v16 10/10] cxl: Enable CXL protocol error reporting
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:303:8f::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb6687b-0ac8-435c-7925-08de8f59fc39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Fgl1AiZmXj/ohCC94iajP5GUd6FJ4B+TJLoZsHpsFSd0BoHcsvMwOn/fAHN/affoVUev/6vp9D0DGK1mjG+7+3ytIlzk3/RoU4gBnXSCmMDHGBLdF6Ixuzt+sy1PurlHnC4V9HWUtaX0tsXvtG5+4GU2/lWFwB4AKqL/PlD5bjJ2eeeGKjaT6wx2BuApt/NqwtBH6+r631lHnCcwE2kkAfeH22Diya3jdb8gFit6qoCqPXuPUedIT+Qpy1BfXktqw3er5GKIVo5HUmXTFLZhdiZ7yndMIf5VMrjewyno4bfcztqZCWJUz9dUMkByv2/sOoWCLMzN+pwuI5bN/r5ayVr7y9t4jYJ9+jfOIBKxMmkVz1lBdkUnUi4wWYYnNFgaSVkeHWwlmWvYT7g6oSmqxHv1KifxsIeZzaO10j5PfusKfivAgtTBmLvLql+nNIScxmi932lt1X2uz3n1qa2ML4W7WZ2qGxUQK4rDNBMiBj6Z/E1rjB9nHrzx1oKhz+6GbNYmgAucJihJDqmaaPzQrrg7CJgeXPHqf9FkvrzELkEg3aRE/y16zILUtgZE34uh4cdZ0kiIoIO2hEx7ziG6DgPFqRU18heU0AEfAT69e2TPe4Y+rjFAAI6uaop3HJzdQQGZzEt03eLD0r7l8cPQyhNmkq3k3ka5adVBAmcdCGWA8CipEqP+0HXmCBRB66eHYtMhr77bREx6gNLV3M/HB3CECoWkEE19ZvLYk3Ive83XTgyy75IMWCyPlYeQoFNZNFgepxcS5qN9VKt1Qo9jaUBL61DfmsjBo/TpiT33pa0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3gwcWxJQ0tJSWhIczFpOGlpRnFVTnhjYmIxZEFWWURiOWRHZnhERmtnZ3p5?=
 =?utf-8?B?TUUyOXhnaFBaUkd2dzBmaSs4WDRUU3l3OVRubVBWTk5EZUpHN2lrRVlKNWdF?=
 =?utf-8?B?eEE2M3V5S25ZamY5bU9tUS93dVFNZUtHOUdIdnNUd21RelpvS3VSbTlRL0FY?=
 =?utf-8?B?ektPTlB2K2NKNW82RnpkMFIyN2VuVkVjZWFVQ2x6WndUNzgwUUlvTldnU1Q1?=
 =?utf-8?B?NTBBNUZhaHJQOFRVZTA0U242YVdwSUVjcWE5K0JGaGZJbzV6YkRHQlJNRWNR?=
 =?utf-8?B?RFliNVd4TVZYNWhwYXdZTjN0cnVkRTBNUjd2ZVI5cTZFTUVYNXFDTC9RNnc1?=
 =?utf-8?B?c09DeFR4Z0pldGpuQ3ZLTEF5Z2E2Z3FuU2ErOTBWS00rdTc4aW9oY0pmdDI1?=
 =?utf-8?B?Z1ZKbzJBQTF5MjRkelhEYTBJM2ltSmZ5elFQQ2RvM2dJUmFTOUwxUEVidm9N?=
 =?utf-8?B?cnhGNjlEcUcrMk5HK3pyNjVlN1d4K0ZCVmxaOHhldlZ3NGdKWnBSSWI1TjI2?=
 =?utf-8?B?b1M0ZFdGRWJ6bHJBUjZxN2JFcXU2SGxPS0NaR0IzMElrcmVVbmdzVTFob0cr?=
 =?utf-8?B?N1B3Z0h3ZkZVS0tSVklLS1RobW1tdmkrMWs0SDlPT1JXWGVEM3QyOFJXUHJE?=
 =?utf-8?B?Vm1wMjVQRDFWNzF2UGxGNnBabkhuOUtXcTNaeVZvNjJtaGtKR0hNcmtmQVNw?=
 =?utf-8?B?VmhSWWZOR0lTY0tTcXpNaDFMSit2TTZsSzR2ek5vR3RsVzZhUFpSSGpWYlhX?=
 =?utf-8?B?a0ZKMElUTVZFNHo0QXdyTUNLSG5uc2tMdWEzMWNUeW9STzgwSGpJODJVeVdh?=
 =?utf-8?B?SGt1VWRWOUhjY0FrRGVuNTZqTzM3ODN4bFlKdWlSNVE4VFJpMlk0M3JFNk9J?=
 =?utf-8?B?UlNlYXJDRGY2b2xpbWdwZmxQbC80ZDVVcXdYalRwcEh3b011WWNCVFA4YXNC?=
 =?utf-8?B?V055cmVGOU92VE5saU15d2laTEQ5NXRJeml2YlNHdlpQWlZnR1V6QndUUkJH?=
 =?utf-8?B?ZlpUUzI1TmI1L0dQblRJaE0ySTRjS05IdUxrV3pGTExWZXVYRHFNWVJpMnd1?=
 =?utf-8?B?eVRnTzkxa3ozcDVOdGZKUHBvZ0tUcEZxbWh5dmdpWWlRY21WRUxFKzVBRjJq?=
 =?utf-8?B?bEhZWThLU01aUmY1bjhPMEdHeGZ6MGRIejdML25qYnNJNGF4LzZZVTR0bUFE?=
 =?utf-8?B?MSt6WlJHQjBSdWsvWWJPeVJiakl0K3FCZVJEcmFtQlNmeTFpZ0w2MnBxYTl5?=
 =?utf-8?B?RU4razJacHc5VVY1d01oR1hDK05HYS9ZMHljVnI4WDVJZ2hNMW1SY2xvNE9T?=
 =?utf-8?B?K2VDeEN6SXZyMGRGLzhkK2VIc2JDVGFlMVkveHo0cHQ4dXAwRXpQcitBSUEv?=
 =?utf-8?B?dCs3c0NuVjBCZFhjV1A1dXVuUGE5QXJJVzNwRnJrTGQwRWNoQTdCT2dnNi8x?=
 =?utf-8?B?S21uaEwyZDBaZzgwQkpwMzR6VHZzTEJFb2tLa0Jaa29LYjc5dFBqVHRoOGNR?=
 =?utf-8?B?V3NxS2UvNlVlKzR4UTgzWEs0WnlCVGN2WlRUV0ZLMklHQmFZVnZzMkxiZTNI?=
 =?utf-8?B?aVF6ZDVwcVlvUjZCcWk0K2F0Wjk4bkg3bjJMSWxaY1JvWVJscGJlNHdkVWNp?=
 =?utf-8?B?bDllVFhhVWEwRkNnOXNteTRCUnBIY042NWJ0THBXRHFwdjVtbmVsNGZiOXI2?=
 =?utf-8?B?a1Mxd2xLckJFVktpbmdtY1Baa3JOLzQxRzNOenAzOFAxR1pNbDBWMHdKd2Zx?=
 =?utf-8?B?Tkk5T2w4eUZYNXkraGluNEV1TkFmcTZyaGs0UGtEQmhOVmdrUTNPNndnVnBr?=
 =?utf-8?B?aCtyaU55OXVVR2dUOExrTWdDcHBqTlBOdi9Ec2lVYTh3YUxuaDU5bm83WGhr?=
 =?utf-8?B?QzVTTXR1aUU3a3R2VVAzQkZtT0tucG5PZTFLcmJFaVZKbmN4cmtkUHBWWFdV?=
 =?utf-8?B?K0pWdDZUM3RYU1k4VTF5YWM0NW9JNDY1SUVvTExiQWZ2MXFqWHV4VDZCQVBv?=
 =?utf-8?B?VHNsRzZSRWFiSXRKS3o0aGlSYWx6YmtsVXc0MTZ0U3NxQTN6WmxlQ2dTTWhx?=
 =?utf-8?B?aHFhdGREMjZqanRBNmFnTHkvV0t2bHBta245ZGxISHJvbjM4RmlUNitVUTRp?=
 =?utf-8?B?TGt3emRjRlJRRFlKcm1OK2FCNVg0LytLbklIcnZtOSt2amVtSUFpQlYyNzVP?=
 =?utf-8?B?R1c5T0pvWTJQN3BBZmdWWWhrUk51OFBqakNIb3E2VWttVjk1ZUkzUFRpcjJX?=
 =?utf-8?B?eFRyNDlKTlBlQVNYSGNkUWsvajR2Vzg2a0xBa3VKcVUycWRKMWtneE1CUmZH?=
 =?utf-8?B?eWErNTVXU0ttbk5QeFZneTZ3b3lPM1V6OElIY3d6TFBtaWJVTENzRWxpOWxw?=
 =?utf-8?Q?YvfcmczmSSyDaTM4=3D?=
X-Exchange-RoutingPolicyChecked: qgdn+tozTTv/kIZvzh/QUosbzMzonWYiqOb4IoGitFucuEUCLFK7TU+yBUAnwBKHCcai03XT71oB4yV1MMh0ewO5gCNBWJvKvwAth4c8J/bD54pZehf7LzWnjlbQQsj/g+7uKvLPFm3thpjslnTGIJ1Qcvdhs1LyMQKUD5xHJO517Pxn2pzRhQcnt0M0hsxTQEaeAni99LyeRRZaBRJOF/uM6q2OTZtDuXpRtAunObj2lGUK8gqydX1t6OL9X9MhBi70RU4visOvTZK1tmPdpga5N1HwdsbNE2SrLYm4NeBuV6KIJ1544pN+H7THIGKgwPbUK6fu3jpf7ndJOawXBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb6687b-0ac8-435c-7925-08de8f59fc39
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:16:18.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7bFVFwFjTAHyxJ9YxM/Eaf/muHjokmb1HMAJNqL6f/EnpCAiUbZNFfBG3mB38EtIf55OPYlVw6tcc6XXPSOmTJzDkkRF5F4GsvnsDBJuqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6115
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> On 3/29/2026 8:41 PM, Dan Williams wrote:
> > Terry Bowman wrote:
> >> CXL protocol errors are not enabled for all CXL devices after boot. These
> >> must be enabled inorder to process CXL protocol errors.
> >>
> >> Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
> >> pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
> >> But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
> >> Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
> >> correctable internal errors and uncorrectable internal errors for all CXL
> >> devices.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> >>
> >> ---
> >>  drivers/cxl/core/port.c |  2 ++
> >>  drivers/cxl/core/ras.c  | 22 ++++++++++++++++++++++
> >>  drivers/cxl/cxlpci.h    |  4 ++++
> >>  3 files changed, 28 insertions(+)
> >>
> >> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> >> index 27271402915f..c33d58fb7264 100644
> >> --- a/drivers/cxl/core/port.c
> >> +++ b/drivers/cxl/core/port.c
> >> @@ -1852,6 +1852,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> >>  
> >>  			rc = cxl_add_ep(dport, &cxlmd->dev);
> >>  
> >> +			cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
> >> +
> > 
> > Why here? devm_cxl_port_ras_setup() will just redo it, right?
> 
> No, I found this change is needed otherwise injection fails.

Sounds like something worth fixing rather than sprinkling an out of
place workaround. Port resource acquisition should stay logically
grouped. I am also missing where this masking is restored on exit?

I have asked about your test scripts in the past [1]. Those scripts need
to be integrated into cxl_test proper, or at least contributed on the
side such that anyone can clone the tests and run them. It needs to be
the case that incremental refactoring work can move with confidence by
simply running the tests. 

[1]: http://lore.kernel.org/68815a66459e4_134cc710012@dwillia2-xfh.jf.intel.com.notmuch
