Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73232212F98;
	Thu, 19 Feb 2026 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771531659; cv=fail; b=sc+nuVYOt2aWNte2EZbr5Oh+eqLAIF2+VuEhcRNM7akS0aaFT2tEWMVDTwpG7nYk9VrG2xTGqGhJHS8CK8V7fFpguJK/4+pzlidlBYLnfuG7s9YMNe4iC1aMMkQw/rVqvYQZp73Sk6lJ0ssRl0k5BwfbNjRosn0BPsaK96oeZc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771531659; c=relaxed/simple;
	bh=z0bqCDZcN/L+Fn++CGHfluRUv5p/BdqezVYVybKtN/c=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=qwTv6r5WJfUsryBvuCthmmieTEoWDu5JxjmgbgyRiYo6WpTTgUOiSl+xLYnBCyL99KbF0Tt82NFvdCRU8biTAIHmJRGEdAz+Zgs+IjNFX6dYWGOecwP6ThRZ3dRAjGoxEyVFiGC38EkfihZ0m7RR8s+WeiRMOtpYpADNcOToAO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwi9oVNj; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwi9oVNj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771531657; x=1803067657;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=z0bqCDZcN/L+Fn++CGHfluRUv5p/BdqezVYVybKtN/c=;
  b=mwi9oVNjyMYy3F5ZKE1y5A/9uuhDneoe8I0Rc23t9eKntE21GtmGteyH
   nvmxl4cNn6ulFGfyb4madhaAkLpxfUbNzESrAFoR6cOUUqE/BGQM9qV5O
   B2Yx1Xmd5o21DQbsUjkOAEbsUYCAE7B+X2dcq0NkF0/Uz94VWJsRsirUm
   TwzuNm36XKqxmEeSMJNbJt64jGmN6VFJ4Yb+SfK+wE8D2p+a92Sp+Jrq6
   RcSYWZ2ldtl0xzgVcfINd+kZyr66wRyJt6zu+hCQ7u9h2AghCFOj6hHhq
   CcdAf4bTUMCQcqfTZ1qmswohCdMwXMZ6jCMmD//MOCBoZ+jgZPWzjK+3o
   g==;
X-CSE-ConnectionGUID: UAQecCbkT9ejb57izr1D0A==
X-CSE-MsgGUID: /f5c46eQQwK/Gt/vXE2B4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72692060"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72692060"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:07:36 -0800
X-CSE-ConnectionGUID: 1miNwjiLT8yPEUSaA2G75Q==
X-CSE-MsgGUID: kQIGVMifRLeJ0KMGhPckVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="213233702"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:07:36 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 12:07:35 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 12:07:35 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 12:07:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVLWRH0lcqmeyo86V9C+a54D2hnLuV5cthDQ1L8Io9JOElDXi50iUMP5QlNt/EGUriXFC7cV7qwD2Er9k8zedHyLID3dVSx4m5Q/aDPKjZgHYF/+AbpQHJsAbZuw1nOfybW4avifC6kajPZXPYEyNo3ArME5Xnmcc3krWbkZiDRr8KhRZaR+u8zTZYGVso5BWMympaGskF4ynLw3zsci+JD7akYutzUqfgmZ1k2RtK+Qj+O2CLGN7Ny1zanvqRulp5toCmdGtjXFHGtDYlpiEMkjWsu1NRFrBMVVcWivEzAU1Ri+6rcDD9DBpNpQtZOe1qxa/Y6D9JmAvPSTpZVvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBa3XSLdoeMCQYy55uGPgKr6asRxFOGV7//RxFsIHbs=;
 b=B5cceGBbISIXm3Ai72LoMJUA2Y9SbjrFO86vJ9iwfp1TBj1AolHDVPxnndCZtn1cq4AlYeH/rQ0sP2FAiJ3/fHYxXdJeH7OWXl3gzTw231Xlerp6af80rzi/8hcR1HpH8Y8l1JZhcWDaeNUPZTN4FKES+rZCWSSzOLSpN5qZ172c096NjaO0Zlp7oJASCmeLlTe/8lpwfmfKGdOznS+FX/Wq0KF5dM3bp60a+LoW54SIQ/xeBecnBuSMK6VDl/UuDiRRjf1WYmt29qZASLpF0+Cf0ebnAEBI0TuKXLjlXpwgh4OCuw6OqnfdgmkZjXGceUgTW5PcYtz1+nR8veGamA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 20:07:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 20:07:27 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 19 Feb 2026 12:07:25 -0800
To: Jason Gunthorpe <jgg@nvidia.com>, Lukas Wunner <lukas@wunner.de>
CC: <dan.j.williams@intel.com>, Alistair Francis <alistair23@gmail.com>,
	<bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
	<akpm@linux-foundation.org>, <linux-pci@vger.kernel.org>,
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	Alistair Francis <alistair.francis@wdc.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>
Message-ID: <69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch>
In-Reply-To: <20260219173937.GH723117@nvidia.com>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <20260219143129.GF723117@nvidia.com>
 <aZcnTnYJ61Kma0yd@wunner.de>
 <20260219173937.GH723117@nvidia.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: a450bd9b-bbed-4107-7be6-08de6ff280ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eklOeHhiRWZMa2F4Rm8rZVZkc3BQNW90K2dmOXg1SzNyKzBDWDV4TzZWcnFD?=
 =?utf-8?B?cmg3dFN2SHV2cWkwNVorUHYvbldiQ2FvSlZMVEg3RHkycExPejhZVFJsM3FI?=
 =?utf-8?B?ZGE5MWl2cGsvd1F0K3IvZG00SnR1WEVEZk9rVWRJaTlUMlo3TXNUUzVZUDJO?=
 =?utf-8?B?YjVnbXdNbG96RjlLQ095eWtvU2IzVXUwZTd1ZktrYm02ZC9lT1g2ZUdHYXAx?=
 =?utf-8?B?WTk5OENGcndiV0FEMTVSTDgrTVZlUjVqdUJnbVJvWTBXUGorT0J6WEVKVWZj?=
 =?utf-8?B?Q2ZSY1E5ejQ2emdJWXd0UDZoR2pkMEY2SFEzdU4xVTVPNGNQUlV0ZmZKU1E1?=
 =?utf-8?B?cHlPd2JoNG1tbFIxOXowMVp1byszclFpS3V2VWdaWlIzVG1MMVlpbnNwSmY3?=
 =?utf-8?B?by9GL3BDSTRZWU81d00zalpzWWtxZTk4YTFlb0JqVmw3cTBQQUFYWkRPNXNr?=
 =?utf-8?B?LzFvbUpJNVBmeHVwdEJQd3pDcXlFK0cyOTVmRGUvemFkOHpRM1VoUlptVDBa?=
 =?utf-8?B?MEwvUWk2ZDlwY2E5N3M3TEY3VzNEYWZWL3JheFlScStZMkRLMSs3dkZYSjY1?=
 =?utf-8?B?cUd6QkVzK0hpUW5OUjBVR1VlMHkyOGptdFJ4RU1QbVljQVFHVmV0R0pIZnAw?=
 =?utf-8?B?d0g5bElwWERmQ0xqVyszdkYvRSsvaDNUV21zUUQzd0xhRFJIRUlMMThKNEQ3?=
 =?utf-8?B?ZEtXQUs0blZZS0g5MTBXQ3QzRlpjZWN1SERVWjVobitHVjFGRlZUakNwdExp?=
 =?utf-8?B?KzdjZWJodmlsUUhWZmV2RVlOL0tpYXVmdC9WV0xwVzUxRldoblpuc0hGc1pr?=
 =?utf-8?B?amdJRFB1bGRNTzhEQmZkSUw4TS9abUkyRWNUZ3dOaVdtN2RqMkRFMkl0VEx2?=
 =?utf-8?B?VWxLUFFJM3hLS2ZxNmZYdDhzQUtCVlk2YWJsVjBXVDJ5QlIxVndJbCtCZm1Z?=
 =?utf-8?B?MlFXVUNYRnhsS0NtVmVZaXF3Z3pjNVQ0NExlMmYyVnk5bC83OFgzOTBneGhv?=
 =?utf-8?B?M0xReUYySWJCcy84NXNhWG81Z2dpOUdJcThrdmQwK1NJTWRHdGdEbDZFRVNW?=
 =?utf-8?B?OG9RTTR3OXlSYklIemRyem83NW1HWktYTXIzVUttTHdaY255ZkVzekZCVWc0?=
 =?utf-8?B?SU90OXJ6Nm1rRElNZUpscWttSXNPa0VLRkllczdJZmdDSHVrN1ZCY0VMQk45?=
 =?utf-8?B?ZVBSVGVudGRsb1FSaklTcFRNSDdFV3Q1aEZCUjRsVmR3SFlFbExKQVErdDdY?=
 =?utf-8?B?UkdaWWEwNk1LTzE4Uy9xSWdpWVo1TkM1ZTBDR3pNVkwyZi9KSzZwNDJqUHhO?=
 =?utf-8?B?U2R2U2RkMkJ3UzlvZ3ZtbGhvZkUvNUlob3g4RkVReitkYXBTOWp2OGxyQTdU?=
 =?utf-8?B?T2xtLzAxd0Zrcm13YmwwcGRTd0xnNDRDVWtycE9OWDRTSDJvQnFTSTdBVlMr?=
 =?utf-8?B?NHBkdHg0OGU1QkJJNkkzQmt3QW02bG5WcjNEZlg3NDhKM3BUbXdkMFZxeHNS?=
 =?utf-8?B?Q3RZL0kwRE1vbWhOYU1CZ3AxckRydXVEWWVuY2d1OFgxb3VZUmFMVjJUUjlU?=
 =?utf-8?B?WWx0NzRTSHhFOHhPUVlXWnN0empMOGJ1Sm9pM3E4UktoZ3ltb3Z4UXNha3hC?=
 =?utf-8?B?SEZ2eUpjaTV6SFR5ZTFxaWJ0TzZFdmROV3p1a0ZTS2pZK2M5WCttY0dWTFNR?=
 =?utf-8?B?ZC9HK3VCejNQL0ZGMkpGR0I1d3RrSXdFdnQ4dGcrdXpEUmJ6RndvTlM2MkJ4?=
 =?utf-8?B?TXZXYTlSZVFJWFRFT3cyOW1wdmg0QlI3cHU1OFA0aVdrWTdnS2tiMkZiOWFk?=
 =?utf-8?B?NkV6VWJZckE5SUlyZ05VWVBMaVBBc1RPTWJGalE4cDBpSVc0RWptMU1ObDBH?=
 =?utf-8?B?d0ZmN0xROUMyeDNqUXlaMVhhUFhHcjQzMmE1OUxpaTNCMS9jeUFHSkc5VUdO?=
 =?utf-8?B?bklrdEVDRjFWa0VxQ241aU43RlIvaWNZL2U0bzBKZzV0VE1rNjYvUGthVnNy?=
 =?utf-8?B?QTBFcGJ1bVF5enZ3UlJHdXczNFRCWHJwNEZBMk1ibVZOVWtiMEwrSmlmMGYv?=
 =?utf-8?B?czJjcjlVMUJEWFlIZW54Q2Zsbnd6UnBVWE9yOXVZRnJ0bGNMWUp1aTFLczB5?=
 =?utf-8?Q?oT0s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2JWZjlxc2dXU0ZOQTFrejNXOUNlc0UxaFpuZGRZN1hmTXZrYnFheDh5MVlM?=
 =?utf-8?B?d09tcndKMFAxYTZLWDMzMkgwOWdGRVBqajdzamhQclUzQTBVNEwxbG5hMUpB?=
 =?utf-8?B?ZTlYQzFpeVJiOTcwQ21aeXRpMjhla3l0VklWNGVNWCs5SmJaL0Fhb1BIVTJn?=
 =?utf-8?B?WEpXMklIcFY2REpXWEJHaGtPYkcrVForQUhJK2dveG9GTy9hVTNNN0cySHhH?=
 =?utf-8?B?UEVJT2R1YXdJbVgyS1g3MGFMWnp5WlJTbmdkTElVY2tycVkrNGVsTk1ST1A5?=
 =?utf-8?B?V0VQTXoxVzRUaVlGWGRUOGswR0FnYjZva3VyWklBd1RzT29BOU5PbG9ZYkFQ?=
 =?utf-8?B?R0U5UmpzYWRTZkRnMTRHbVlVdkovVG9zYW5ieW9DZjdmYTA2ZlpUa3pjYXpD?=
 =?utf-8?B?bEJTWXAwV2lFdkNRMGg3MlZ4ZlQrZG8vMG9ubGp5UTBhVkxmcWkwZVBEY1No?=
 =?utf-8?B?RHZRYVRBYUYzUkNRNEswZGtjVkRTOGNDRWJRVVJSdENKWkdqeXk2eTRESlps?=
 =?utf-8?B?MWZNK3dBSmVZVGhKZFA0VGZVTU1oUjVJb2F1NzFqemcvZ1BWZ0pTWisvM09I?=
 =?utf-8?B?SEQxR28vUlJKamN1eWtnbHExM3dsTW56RDZIamNTQWNDNGFGa2JwemxEcTJa?=
 =?utf-8?B?cHI4R1BkaWVRc28ybkNJa01jZ2s0UndXMG4yKzR3RlFYcG83b1lJUy9leXJw?=
 =?utf-8?B?dHVrc2F3eXdUUG1zcC9wbjUrOWRBYk5sMEE0eHpvZm54ZmhXdjh3TE5TN2lx?=
 =?utf-8?B?RUNvdzRlQkhWeWtCazY3WEhhZXlWdVQ5RGdyWG1KaldOdkZiM2lwdDhBa0Jt?=
 =?utf-8?B?NThSVlE3ZmtDbDdSdkxRRXdNSHA4dk5XRHdUK3dRSEh6NWVvQXJtbHFiVWdN?=
 =?utf-8?B?K0VFVzQxc3M4TnFjUk5ubEFFbFUwdmdMOGp3THF6N2pQTW9iYk8vZS92Y1c4?=
 =?utf-8?B?a2JoNzNIVkYwS0VhUkV1Ui9ZbWQrTkYwaXVUYkJsTDBiVmlQREhPKzdSMng2?=
 =?utf-8?B?dG9KTDR2enFobi96U3owWTQ4Z0hwaDVFTVluRXBENm5SeXVMckV3UUUvQVJF?=
 =?utf-8?B?TUoraWc1Z1IvV1RqQzRIQUZKMDIvVVVQdEdIMkQ4dUFnRjNLN1RjVXYxMUx1?=
 =?utf-8?B?eEFCTWFPai9TK3VXdExNUjdXYzR6UHBML2MyZGJYTGU3czVkNXJFQkRoRDJQ?=
 =?utf-8?B?Q2RQdzBMVVhJNmJPOFRaM1YzTE54WW1nbXgvZ2xGbjMxenFybk5PYTFaWnUw?=
 =?utf-8?B?ZDN6VDFYOE41eUMxcFlTQnd5SU1EamFvTHAvN0o5Kzk2cEFvS2Z3Sm85UHJ3?=
 =?utf-8?B?b3l5U3ZtQnlzdlhrTEp5MklGNFlXVjNZQmwxWmg2YmtlUlNhZG9RbHlYaVJk?=
 =?utf-8?B?dXFpSldickNZazNDejR0cDFCcmN1QTBnUXpMN1owOUUzM0tYazlCQ0JvODhX?=
 =?utf-8?B?Sm9HN2ZKMWE3S25wTm12cC9DaytlaXpLa3RHcTRWRm9qNWZjRkJEbElQc1J2?=
 =?utf-8?B?ZlMySXN1ZTdOMDBHVmU5WHBBajdkZGZGTWowOEcxTEN4RjlEMG1CSU11N3JU?=
 =?utf-8?B?TmhRclNmbk5NU1RLZmVJbUV3VEZ5RkgxdW1RZUdaQ004ZG40OVZFMGpQVWsv?=
 =?utf-8?B?SHRXMmQ1ZmF2aUcwN1hOaHJQLy8zZW53emt4aGZpR3NVR0xxWXcyNW5NSi9Y?=
 =?utf-8?B?L2JnVDRHOUJDKzJINTFxdVJ0WnBENXdUalpZTVNmQWltQytYWFRNTEdLRkx0?=
 =?utf-8?B?R3ZkdUtpSU1mVlNlelU0VVlXL2RvRi9XMTZWb01SQUdPR0phd25YT1FYSzNq?=
 =?utf-8?B?MWF2NUtLak5EalBJZ2VHTlJ0eG1qUjVhZEJ2ajdqcGQ5SStON2JqY0lRWmtm?=
 =?utf-8?B?YmltOElTZit4MTFvMTFjei9hYVNwT1pXMGNwL3hQNE5CLzUvbG1PeU9WS015?=
 =?utf-8?B?ZWZ3aVZuTnUza0hkby9mK2gvVC8vTnExSG43a08vdldKNXM2Z21SNUZwWVY3?=
 =?utf-8?B?S25VTDJjaE5GL0R2azd1VmQ0dVdnMVFyNi82eW5pMlNMRk5nNmozY1I2Ukdp?=
 =?utf-8?B?SnQ4R21MeVZtOXhlUVhzSjZtcWJxeHlsenYvTHI4K01RdzQ5aWxGUXBoWGpO?=
 =?utf-8?B?Vjg0OHVIaEgxQnc2ZWNWc1VjZ1pGUkFZcW1OeVZpWkxpRk0zb2k3bld2bStY?=
 =?utf-8?B?ZDlZMXpBUjJhVHk0QmpSV3hYL1dtZEtpTlE3UFhVeHVZRGM4M3E1ZDdsanV2?=
 =?utf-8?B?MDYzVys0SGl4TndsVVJTekhGSVZOTTNMKzNLTnA0b2MrNFdTSi9yRFYyRFZa?=
 =?utf-8?B?T1g5NUIrMDM1VVBvNUNkVTZZeVNJelM0OGxJQmg1aEVtSTgrNk5EU3p0RU9E?=
 =?utf-8?Q?n6sXHmu38CEJUhEk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a450bd9b-bbed-4107-7be6-08de6ff280ee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 20:07:27.0982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cx07RU+3zAkq4Du3UTnZpVVtd0nKM8huekpodHhfrWKnS2Apng5E4wQsm89ppV4oP1zuxVz82D9rLL6TuLeSu+AeXILPA+jdqoVi7C5BmC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7164
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Thu, Feb 19, 2026 at 04:07:58PM +0100, Lukas Wunner wrote:
> > On Thu, Feb 19, 2026 at 10:31:29AM -0400, Jason Gunthorpe wrote:
> > > On Thu, Feb 19, 2026 at 03:15:34PM +0100, Lukas Wunner wrote:
> > > > The way this works in my series (and I presume Alistair's) is that
> > > > trusted root certificates for devices need to be added to the .cma
> > > > keyring.
> > > > 
> > > > This can be done from user space using keyctl(1) or some other utility
> > > > that can talk to the kernel's existing keyctl ABI.
> > > 
> > > I really don't like this from a verification perspective. We don't
> > > want the kernel checking signatures, that is the verifier's job.
> > 
> > On resume from system sleep, the device is put into D0 already in the
> > ->resume_noirq() phase and drivers are free to access it already at
> > that point.  However a verifier in user space cannot be queried
> > at that point because user space is still frozen.
> > 
> > Likewise after recovery from DPC or AER, the device has been reset
> > and needs to be reauthenticated, yet user space may be unavailable
> > because the device that has been reset may contain the root partition
> > or may be the NIC that you need to query your remote attestation service.
> > 
> > There is no way around some form of in-kernel device authentication
> > to accommodate such use cases.
> 
> I'm arguing there are two very different steps here that must be kept
> separate. Verification is done when the device is first seen and the
> kernel is told it is OK to use the device.
> 
> A same-device check is performed if an already verified and accepted
> device resumes or RAS's in some way.
> 
> same-device does not mean run a kernel verification against the kernel
> keyring, as a second verification could be tricked into accepting
> something that has changed and defeat the userspace verifier.
> 
> Instead the implementation should capture information when the device
> is accepted by the verifier and on resume/RAS it should compare the
> device against that captured information and determine if it is still
> the same device.
> 
> The key north star must be that the userspace verifier alone decides
> if the device is acceptable and if the kernel is configured to
> auto-re-accept the device later on RAS/resume it must not permit a
> device that is different from what userspace approved. In other words
> it is not a verification on resume, it is just a kernel side
> confirmation the device hasn't been changed.
> 
> Hence no keyring should be involved in resume.

I am also struggling to see a role for the .cma keyring as long as the
kernel eventually has a method to cache cert-chain, measurements, and
for TDISP, interface report digests. Support for a recovery flow is not
the first dragon to slay though as just establishing device trust in the
first instance without RAS concerns is a significant amount of work.

Linux should not over index on native bare-metal CMA because that
mechanism only tells you that the SPDM session with device firmware
(DSM) is authenticated, it does nothing to ensure that the kernel's view
of the device's MMIO is and remains associated with that DSM. Better
than nothing, yes, but it certainly assumes a less sophisticated threat
model than TDISP.

So the current 'authenticated' PCI sysfs attribute can simply indicate
"SPDM collateral (cert chain + measurements) available", and leave all
the decisions about what do with that collateral to userspace. For cases
where the full lock + accept TDISP flow is not available the only policy
knob that userspace has is to decline to attach a driver.

Once we have that userspace can optionally tell the kernel to cache
digests for automatic re-accept / keep driver bound, or userspace can
plan to do another round trip with the verifier for recovery if the
device bounces out of the TCB.

My current thought is take and adapt the netlink interface to retrieve
cert chains, change the certificate slot for the authentication attempt,
and retrieve device measurements. None of that requires the x509 parser.
With that in place native CMA SPDM can be modeled as just another TSM
driver that only addresses a subset of the TDISP threat model.

There are 2 flows depending on whether the TSM driver suports the
comprehensive security of the "lock+accept" model or not:

---

# $tsmN is a class device registered by one of amd-tio, intel-tdx,
# arm-cca, or when this spdm library is available a kernel-pci-cma TSM
# driver

# The "lock+accept" model is not available for any of the current tsm
# drivers on bare metal, only the "connect" flow. The connect flow gets
# you an SPDM secure session at a minimum and optionally IDE as well. It
# is a less comprehensive security model than TDISP
echo $tsmN > /sys/bus/pci/devices/$pci_dev/tsm/connect

# Alternatively, when a TDISP interface is assigned, the TSM driver
# publishes "lock+accept" attributes. This provides the comprehensive
# security model that closes "DSM is and remains associated to device
# MMIO" TOCTOU problem.
echo $tsmN > /sys/bus/pci/devices/$pci_dev/tsm/lock

# In either of the above cases the
# /sys/bus/pci/devices/$pci_dev/authenticated attribute toggles to 1 and
# userspace is able to use PCI netlink to gather evidence with nonces
...collect (with netlink) / validate evidence...

# When verifier is satisfied bind the driver, or in the Confidential
# Computing / TDISP case, first "accept" the device so that it is
# allowed to access private memory
echo 1 > /sys/bus/pci/devices/$pci_dev/tsm/accept
echo $pci_dev > /sys/bus/pci/drivers/$driver/bind

---
