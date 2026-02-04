Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEB934D90F;
	Wed,  4 Feb 2026 04:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770179375; cv=fail; b=SrtEgF8AvxL2aJiU7qZAHDZztlENRJbiLLxYiKtxEj0cwPoVp1uUd72IuVsx0xfeHgziL1QjDcxJfHylCWUzKN5VOLDAV3e6iOXV3NN8ARqfMXAXRVCsK9sa6I19RBG2bavsA4h75kjFNZhaxo69pkx9YKWpFginanHjAhFEFYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770179375; c=relaxed/simple;
	bh=MYTq1n9Ps9tdB635OicXCbmWco9fHE9qxnawd7T09kg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=P3Fx9fjCdHonv8+Wj55ln+WshWNVtD4Tj4yTlqjuMsfkYREjHpBNC1mVEsNVTFu1lBo/D+XkyqXdUUXw13zlZE6qJesulUPGWpjzSdN0LL2SeDDCbVPPDmPn6Dzk5ZICgPnSRoNf1T91Q4nTgCQPqP1SPtNPzdsFxmWrvlUTscA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/l0c6Uj; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/l0c6Uj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770179369; x=1801715369;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=MYTq1n9Ps9tdB635OicXCbmWco9fHE9qxnawd7T09kg=;
  b=G/l0c6UjH3d7sV05BaSlVounBPhiMdusClBMNPmhsVsUGAwoxqBWbOJ2
   bbK5cmEHJdxeQmJwk76G3LuKgbdW5ks0BtVPlafkg2X4Ypn7Y2ycL8Cma
   f/2GLKkBWjrog3u6A6jqkeZYIWmmOIstcNa9gpvm9dX4+JqrWlJ+9Fxqp
   aZ8hjM+7ToRdjZ+tSfQd+02ZIXymUlKA4u12vUXdK91NLq6qAKFNx3BMl
   BvQaAC0KKr5qQAzbL3igF/6cPkioogW3i+bkEJgOtJK6qmEe5hK4mw2lR
   TuIGgYSVa/tu9WUkXX8/RjZOuYss8apLb3YupZWzvv4CWQbG5qlIvhrAY
   w==;
X-CSE-ConnectionGUID: LC2NH3qWREKrVMi8k0dMqQ==
X-CSE-MsgGUID: 8cZyC4RrRe+DW17Eb3jaDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82792534"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82792534"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 20:29:26 -0800
X-CSE-ConnectionGUID: R7qtS4npQZGFk1y3P/hQzQ==
X-CSE-MsgGUID: TY6iNateTja1Un+T1vuDmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209438068"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 20:29:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 20:29:25 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 20:29:24 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 20:29:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDEgZsnc5OsPugsp4rOxCSNmS1+5Zp96KUJSimQZXsFFVt6Ii6K529KSbK5HyCTuCbjfKPqjv4aO+QCAcqFZHMdj7aI8BR8ZZfOupzlaZM7IotNCkSj4HJakbTTWJCgJupIs5uz2KbBvCWoo02JTR/ZtoRdFmsTRI9IYI3J/9mAgpe2J8JuSzIBCy6LOhjrTNF7RliAkNAnXUnjgbjn4JH9YechqjzZl58nFaWyhh8n78UHoNUe5ZZH7YlwlLOlEbKPNR5aBAllHIIkQQUvogLtffrUv+YExfr6VAJBjoxg4JDy6THRuAId7R8uUMuKn/LiDefMBzX+gELJjtbk48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdIUNb4DThc0cdI+Sgjuop2cNk70hB6JQBRYs1c0/Mw=;
 b=NflIZFJAhkpGICgfFf4xPoV3ttz4UmoHCYqdY+KDgXSlDxN8UVg4HhmTHYcP36Zj9RRuwVPC9wttRnAssodHBFGxNuD1GGiyP1OwChOFrlNBds3wC/CAWUrAXvYbIQjfs6uRiupje2UJZ69U6Ug/a18PUxP/w7ULP7fLpZZPOTo1oc9mfp7qoDEzW08Rv5psHcyiO1YpyvXavpOnwaWu/pIpfVCHILM6s/PhScyIePxfYdXwQZIpGrXZYCKNVlHiVKTSa/DntJWHk0JK22EEcIuwkf62UVga/XD90SJWxdSSBRnDHxfthGxTkQLV2Tc742FVHz0x7rA/yXb/Ht4d+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7651.namprd11.prod.outlook.com (2603:10b6:8:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 04:29:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Wed, 4 Feb 2026
 04:29:16 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 3 Feb 2026 20:29:15 -0800
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
Message-ID: <6982cb1b631d9_55fa1007b@dwillia2-mobl4.notmuch>
In-Reply-To: <20260203025244.3093805-3-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
 <20260203025244.3093805-3-terry.bowman@amd.com>
Subject: Re: [PATCH v15 2/9] cxl: Update CXL Endpoint tracing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:a03:255::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc51cef-2fae-4281-e935-08de63a5f525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHlLK3dPSDJBMlVIRkppeXNFMDh1Y0d2Z1JJekpyeGNlUXJ1WlYxbmg2bWV0?=
 =?utf-8?B?MmRhb3I0ekR0SE1FaElpTUhqbzFyeUh4OFBjT2IyOWFhcUdLVDNDYUJHKyty?=
 =?utf-8?B?eHNJSm9kQjg3S09KMW1DcmlrVWQrSTNFdGJCV2J6L2JlV0I2WWk4RUlsZkFt?=
 =?utf-8?B?WGdLNUFsRnFmbmkvYkRNeWJBVlA0S2ZOUWQ1S2ptdVZLSGc3dXFpVFpFcm9N?=
 =?utf-8?B?Y3BjTU53ZFQ5U3hEb3ZHaTZQb2F1cmJGaU1aQkg4cHVsN3JDMDZoY1Fqb3Bp?=
 =?utf-8?B?ZXdTN3ZhQ21rYThBcFBxVUpFbFpTNkY4UFJiM2xFVm9mZ3ErdlNQcEs3Nnl6?=
 =?utf-8?B?U1RDWUpNLzBtc1NDaFR6cUpTamlEeFFSV040UHZjL0xCZ21OYzBqcDRMTHNq?=
 =?utf-8?B?ZkpQTCtpWVI4K1JqaXQyeGNTVlpRU040bTBnWjVxZ1E0TDFUTXhHSzFxZGNr?=
 =?utf-8?B?czZhZXMvWlc1eksybXVkNndpVVl5ZnRwSmF1M0QzemtYc3RIU2lGUXVjL0FS?=
 =?utf-8?B?ajF3SFhBVkIxcGNraFJrSXZ6ckNFdmFhWmg1WWx1WUZLbjFYcVhlT3hETGZq?=
 =?utf-8?B?WDVXcHQ5ZTdQNm1raWVOczA1YXYydFlveTljNXc3QXNlVHV3ZDdaVXR4cmpp?=
 =?utf-8?B?YW11cXZyVmxyeWl2NTZPS3pHczVMZjh0Y1QvQ0NQS1RlOVpyN09nSlN1dnNH?=
 =?utf-8?B?Nk9iRXozR0diNzBCa2N2K1U2ZjVyMytZMWFIQzREcGQ3RFZsYUNkcWtZa2pB?=
 =?utf-8?B?Ti9PUTFwRW5yS0tYRG95NUxYZVI0NUlMOWVtb05rcmhhZytFdmhyZUh1aGdE?=
 =?utf-8?B?UWpTeUxLemVTQ0FpbHBYcjZVaVFHcmluWHBQanl0YStHdDdMeEpERXZ6TnlZ?=
 =?utf-8?B?aGtGOG1JUmswRGpBVnBIUGI2QlQ5bVdhNFpGRHU5TGlLeWo5RWpwckdNRGVY?=
 =?utf-8?B?SzI2VjFvdFB0Zk5ubERlVExkNVVoQnpYWHpNY2ZKU0xhUXZ2MDdzazJXMDdS?=
 =?utf-8?B?VEtPMVdKY2I2VlpvYmJEbmZDUE15OVJUd0lVbGxuK29lNlFibGZkL0ZQeTRE?=
 =?utf-8?B?ZnhpV1JTS1Q4UUZKdU1oQkEwSTdXa3gzdkRNR0ZOYktISDIvR3kwWWFOUmZt?=
 =?utf-8?B?Tnc4Y1A4WE9od1NWNHhXdFBleUQ0Zis3Z3o4VGV1bHR1anZrZlNudE9vbWR5?=
 =?utf-8?B?RG5jVzBpWHhuSnZyaldlWFU1akpzemxOVVNjazQ3NE9Od2V4NjQyZ3JqVEhX?=
 =?utf-8?B?NW9MUndlZXNzQzFqSnBVZThYSjdUdm5mRVJwQ0JVdGc4MjB5QStIc2dHSS9B?=
 =?utf-8?B?UjZSMmRrQmtNRW0rREtXMlBrOURpOXZVcVpiMURMcGhuSG1YWENVbjBucXBD?=
 =?utf-8?B?V09uNHA5bnUxdXRBNGV2MXBPODhnTWtkTS9XOE1kSXIwWjJGanZMT04xWGVz?=
 =?utf-8?B?NlhTa1lTOXpOWll5RVFxTEh4ZUI2LytoWmlOa0ZZTndZTEYyOTNwc2N2M2Qx?=
 =?utf-8?B?VkJvRUlFNzUydTBqeVo2MEk4cWUyb0xMckpycWxSdmlmTkNZT1RHRHpFWUVQ?=
 =?utf-8?B?dHZxV0c5eE1XUk53OEt4Z1ZiMFk0OHdBcURzQjF6K0EwWUk4TE44TEZid28x?=
 =?utf-8?B?U0ZlSk1EN2kyK1lsd0MxaXc4d0lnMkJlWEU4SjBRMkNTNkVyNXl6UXk0SDVq?=
 =?utf-8?B?YmtiNEZnakU2WlRMaGZLeDFuR3RtZFBVYWtrRmY1bWNKZDdCRVV6TW1RMktQ?=
 =?utf-8?B?bWY5dlRIcTQ5Nkc4bVo4TlhZRGdseUZQUE1BckNTOUhYa0FYenpDY1lWYVl3?=
 =?utf-8?B?RnRiQkxqRVhVOWlYYVRjWDQ3UkROZjE1enVObnlUdDRRdTVzckpyWVJNa0Y0?=
 =?utf-8?B?VUVVem1lRVpWalBWUnhvNlU0cHp5aFhqd1pYenk4RDQ1c1JRVFNGTmtmQlN1?=
 =?utf-8?B?RFFQdzhCQ0wwZlVpU3ZOV0U2cVN1b2N5UVBsb1M4K1B1ZXBJOXZQdjB5dFFC?=
 =?utf-8?B?QmxYclFBQ2ZnSTZMYnZ5L2oxOEdaaHBaN2RBQUphU01URDZBU0Rya1lDWVBR?=
 =?utf-8?B?RVVMNUpIdGtvNHcyQUo2LzdXVHhJTmJ6aHBQNHUzNGE4SE8vSDFrQUU5ZFpU?=
 =?utf-8?B?TnFqeTlDVDk4MGFodlI4Q0dudDNET1BQeWE4S0J0TEltSGROWnpaOXZvVDJB?=
 =?utf-8?B?bFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2pCTzdoczVhQlBlUUU3V1RDVEQ3YkxzZ3AxbURCQUhmUTR1amNjQ3ZpOEYv?=
 =?utf-8?B?bU9Mck56bGhqUE5SbDVrL25mMEdLcVRBU2tpT0RTT0pjSHlVaVpMRFNWc2xi?=
 =?utf-8?B?TVcxU2t3MnJVVXI0aldFVmRNb0lVYWc2cmwvTHZHYnBPdytSWU4vWDhzM29V?=
 =?utf-8?B?T1JkS2pvWEVkaHJESTVOVGxnYmNWcWFtSVl1L1N1MkluVFpoVXBpYUNFMG5O?=
 =?utf-8?B?OGd3UlpVWG1qN2tUK1daZGNLaVBQeXhKTnRhMzJEVkp4YmtxMlRibis5YUVI?=
 =?utf-8?B?K0JHRUNNVzNtZUJadDZUaHl5d29rM2NuQ293dWFMeEVKUlU3bnRONFhmTGMx?=
 =?utf-8?B?enlNTmFJYTRuU3JaNm8yUFlZUnBxclpVZTZTM3NweldwL1h6TnE1eG5vbTFG?=
 =?utf-8?B?eDhKSVdQVW9rZ0ExNTkrUTlvUlRRUGFIdjB0dGVpZEFkbGNqbmtMbmUwTEdQ?=
 =?utf-8?B?QWtuaGJvemNXaWY3OWhDYjhPdVNRVUNxT2pIUUYzNC9GQi9uZlJ2U3kyVzZj?=
 =?utf-8?B?MnoyL2hyOWZwcTZTYW9SelNyQ0dLekw3cDhUSzZqWEhZSzZrRjRIYm1MS0V1?=
 =?utf-8?B?YlhnNjM1MFltNWJ0STNhQ3I4NFJFVXFIa0JJazU2MStrcmNqcmNvc0w2bmhi?=
 =?utf-8?B?bzdsb1NCZnlaU0FhWndyUEE0QitIOVVxNTB1VmpHekFRNldBVUhseHFubjZX?=
 =?utf-8?B?YmFQVUNhcEdXQXpUeExpaFpKdHZjazhxbndINFhpTlVTVVRTYTJzblpSeEFo?=
 =?utf-8?B?U1JlRVVucERKaFZoY0xvRWNUdCtTdTlrVUFwb2l0R0VEandrbDBDZ1ZNdWxQ?=
 =?utf-8?B?Q20yK0dxck5ENEtmNkxpbkVFTFNwdTdOdGdhcThWWkVobHRZLzZScGd2WVNU?=
 =?utf-8?B?WWNFeHpRbytEMTJaYWJic2hrNThsdjhVVzRBTU5KYVdqUSt2c3M5emJXdTJU?=
 =?utf-8?B?SWlOSmxZVnRNb002Qm54bXlOL3lJcitVZ0E4WmExWUVuRGpoTjRKK3Y1Si9r?=
 =?utf-8?B?NktjMzhuS2hXNzJyL2ZLZFpOWklwSmk1K1V1SjF5LyszNlZqTmhWNytBUmhW?=
 =?utf-8?B?cjFIaWR3WmhmMjVRaFZkNUlSUnF3NTI0Rm1Bb2lGSHY0OXB0Umpqbko3Qkh0?=
 =?utf-8?B?alNFZEV3QzZuVXBpQlNjdHAvVStzenZLK1hpdk00M0NWSktjNVNxK1dQSkYv?=
 =?utf-8?B?MlBHbkZpd2pabHk4SVVBd3R5d2JTMXdPQXl5U3Z6emZjd3Zma3dvS2hubjZ6?=
 =?utf-8?B?SnppVmROUUJrYjdod01oVmN2UFRzQ0UyNDUwbXFtV0doS2dDWWp5cXM2RUdz?=
 =?utf-8?B?bTlUK2hIZFZDUkY0by9Fc2FObU1JUjlVS2t6VVlGN2ZJbHBydVZMMk1XMGhZ?=
 =?utf-8?B?Yk80UUovRCsyS1dUTTdmOFRNVkZCczJWU05KZzV2TkhRQ2V1MVJ5VmlRempa?=
 =?utf-8?B?bkdhWW9FRjFMWkhyRlFwVmROMG9vQlY5bDlRaEZMQ2pLcmZ6UHY2bEZMLzR0?=
 =?utf-8?B?M1h4NFN5dEJnbWlzVXNCaXluZmlHVzRHUVlLSGNMMnVKSkRMNEthWTJPSE1I?=
 =?utf-8?B?bWJPTGVaMU5HS2hVR3JrM2lUbjl1SEJiNHJCY3orZWtOSFRBMjlDMzJLYlVD?=
 =?utf-8?B?ZFFwNkFSb3ZBdzkzTlpFSGxpNm42Z3J4MDM0Ri9CelJRRUFQRHE4NnFEeVAr?=
 =?utf-8?B?NkNmUTBnTk8zT1ViVWdLS2NTMEdVbmVWZ1c3c09hWFZCR2YzVnhUam01dXRa?=
 =?utf-8?B?VitCQ1RBV3JHaGR6QzFXS0V0SXdjWSsxQTN0L29oNHFoMVUvMUdjMTBXUWht?=
 =?utf-8?B?ZktwbnVoQ3lMcEJwaERzcStLUkhBalBRcHpvME1nSDVwU2Q3YWJtdWQzZTVn?=
 =?utf-8?B?Y1k5UE53ZU93V2Z2QUdSUnR6SU9TWGcwZmdHUW1rbUVBS05jYVhxWGNIbjZ2?=
 =?utf-8?B?WHBGblZzaFUvMDJtcTRTWW5vdEFualR2K3JpQVBzRHpVMU5tNFBPSmVFWFhE?=
 =?utf-8?B?cG05a1ZxSUNVODgwNUdHVWkvdlRGRU5mREtqMWR0ZUZmMTVLa3ptWUxMK0pq?=
 =?utf-8?B?azgrZUpqR3lueDYyWU92ME1YMFVVelN2M2NpeDF5NmtLdS9lYlplaTFlVFdX?=
 =?utf-8?B?TVlzYWQ5V2pURWFIdHpMcmJ0UENoY0FBODVDWTJuUUdBNTZSSmh4K2cvSXNt?=
 =?utf-8?B?S3dsdXpnTGc0eHpuL05SWmUvWlBYQUN3UnlnOFpQeklIWmlRcTIwSkgzd0s1?=
 =?utf-8?B?SDI0ampvcVd4eEFFaVFLWjhkdlJBN1I2cEp2N3Z4WWt5ckgvOFVGTzhjY2Zp?=
 =?utf-8?B?TTVXQ2lncjdZOUJITzhTdmN5eWgyM0RjM1Z0aDhYWTdkVkY3eWtMbUZDL1BU?=
 =?utf-8?Q?lP50UdTsPmzZUuRI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc51cef-2fae-4281-e935-08de63a5f525
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:29:16.8025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9/MhxHHk+dK9LpOmLJ4sYJnxLrQQjP626b7Tt5vFHKtBkB7fErKhlwxw+PTzM/f0V4+Biq9+WdGCkdxTmepXjKO1dmEwriRXlLEg2OgWkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7651
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL protocol error handling will be expanded to soon include CXL Port
> support along with existing Endpoint support. 2 updates are needed first:
> - Update calling interfaces to use 'struct device*'
> - Log endpoint serial number
> 
> Add serial number parameter to the trace logging. This is used for EPs
> and 0 is provided for CXL port devices without a serial number.
> 
> Leave the correctable and uncorrectable trace routines' TP_STRUCT__entry()
> unchanged with respect to member data types and order.
> 
> Below is output of correctable and uncorrectable protocol error logging.
> CXL Root Port and CXL Endpoint examples are included below.
> 
> The tracing support for CXL Port devices and Endpoints is already implemented.
> Update cxl_handle_ras() & cxl_handle_cor_ras() to also call the CXL trace
> routines.
> 
> Root Port:
> cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c serial: 0 status='CRC Threshold Hit'
> cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
> 
> Endpoint:
> cxl_aer_correctable_error: memdev=mem3 host=0000:0f:00.0 serial=0 status='CRC Threshold Hit'
> cxl_aer_uncorrectable_error: memdev=mem3 host=0000:0f:00.0 serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'

Looks good, adding the serial number at the end should preserve
compatibility with libtraceevent parsing of the parameters.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
