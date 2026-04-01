Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17432ED39;
	Wed,  1 Apr 2026 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038427; cv=fail; b=GfM4pxD+Q3PeVpxTyxHuX0spou5noH1R0lHXxXZRGI9fo05UH83zzRkLBJtB3ASQewI70V5gcj6KoCtZH2EhZ3Lq/gM60iPlvqYg6svh3Rug1z6FsajXAz4ySZ1ZgjO7oW4UP63IlCqLSO2QTTzgAiVV5OM5i4r8FQanPhTy6Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038427; c=relaxed/simple;
	bh=zzdIKhdkA9t6o2GiDcVk2RS++w7ZUaSDm6MnKi1YkCY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WbhwsKrP67dBMrHZEEopu1HcGIklkIPlvGVXuSEE9tcfjUt+rC57r6vOeakTZcrZ09Q105IeVZf4riT7SyCJj+Falsq0qi7p/9mv2vlTYtwL/A7dnOqTg+Tq3GjP98VWKVJl0TXr7YVxetX/sxzYgKY/vRMOD311gV6yYnq6ypk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YffwSEsc; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YffwSEsc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775038425; x=1806574425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zzdIKhdkA9t6o2GiDcVk2RS++w7ZUaSDm6MnKi1YkCY=;
  b=YffwSEscMRg2Cw/48M1lV0l5G4z5EwwQNN5zk1H+tbO1DQIVSZ3AqUHP
   9riV2EoIH6Y+ObbYbqKvkdhDn3zG1uHaDqhsvyt8TPeLSDBADRjQDtCsc
   2sfEC78IrFh4Cnd0hdIDdJnO7MRBPiKVsxwBvdkj6Hb0aDdsV/MtXCSHo
   1m7c+m++kqD68S5c83IJeooYS3DxakQ6yDOrc5gkdfxvxMJl/e1jwkKQ4
   LgsNNbNVvU3mXXE3edunJYqGu3Oke7aR194OXsrIoKnYj3b8V36OJZTeM
   OzbSoJKTFSWFefeQpWwNjMFpGR6qtAh5VIA/w2u1UhzdXvxtv8jUNIaRz
   g==;
X-CSE-ConnectionGUID: 5K2K30ptRxepNc3xAMX/Cw==
X-CSE-MsgGUID: hQqom6ivQTCIqrJhzyYxJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="93652966"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="93652966"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 03:13:45 -0700
X-CSE-ConnectionGUID: BucldYwISRuETdotLLzfpg==
X-CSE-MsgGUID: 4749AEy8SxiNpEqzt/bURw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="257123364"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 03:13:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 03:13:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 03:13:44 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 03:13:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRfoVwaOSSsgqwCp9/Iitw3MYhyj60heZbQ4dldHXz2kA5TBxojMSBGXDMr9IezU6/xVQ1N7ARvX3Pera0iBIxjeu6NFjcws26KG69QG+UNJpDaD/hYUFUf2s7d/31UDiOXHzRZGyP0/GXt9719llrmUsxUWtQQ1+c4e3QBsWq2WwiCPoj56OPGNTvjtdMqn4OsLie8GAxo23V2eqyAHz8O35UFWUFYIdmmGPL2ArRvWKpGqrCyA6yRXtobuizkd9to5iUK0akImU7nFZ2ECY+Y5gFxuRsBwNwS1FnHAS8T5rF3WOY715SWrUAo8yqP8qtxWhT9uZmMvVbJd90fGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzdIKhdkA9t6o2GiDcVk2RS++w7ZUaSDm6MnKi1YkCY=;
 b=HfWPgjiEQOaIk+m9EzE7etITHgCXlr5d981ajeNv9dCHJyLPjyZ59CsuXrGFAfsZJkQDOJsyFNSX1PYiyoz8xiiy91gYSbp7MY0NKAaFv07HZeatKbg21Q5Id7JZFkQA/KFjV4Qteq0LQFnUuNZ8TdPNy6aEqoxSb7zJ3Rkw+osAt9hPxheX2M8kW+FCz5RKo9VKS8CYbfVN5JfzazF7oXTxlr/T/5VlQqPxYeVT4aKCaA5L3Lybdoz+6FJBMuhUY12N7vKZ/jvf6HmV5NKsquAEzEyCqkLky8IMHm/kXMMHygTfoM4U/PigOYruFCJZYeJY+pLYkbi99bQa7HlwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CY5PR11MB6236.namprd11.prod.outlook.com (2603:10b6:930:23::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.8; Wed, 1 Apr 2026 10:13:33 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Wed, 1 Apr 2026
 10:13:33 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with optional
 TDX Connect feature
Thread-Topic: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with
 optional TDX Connect feature
Thread-Index: AQHcvgciEO9ja9+YTEeNEsKQg5wh6rXKBFOA
Date: Wed, 1 Apr 2026 10:13:33 +0000
Message-ID: <d563b85664271c4d8510f66222c8a05d77d396e1.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-9-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-9-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CY5PR11MB6236:EE_
x-ms-office365-filtering-correlation-id: d10fafb1-f52b-4df0-b391-08de8fd754ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: lf4ewAAE8SRollhBk96VKcMzH3polZzbo9Z4FV7dW6amA9442ljJJG1G788/BnpTXEgn88RUaeW6F2EOcGPhDWKGh7Tac3FhsFw3wH4UU5WD/lIUnrbiXBmo6uPz/w/DJ6+KMom6dnFIY7e7FLyY6solVn6gghhDaEtJRL7SG6oRyxAYCTuRe3+QAJuArwoN7DGznBzmVgBBVQi/VblkiYMh4gxwce2T2xQnEcEA1tbP4XLo5wrpmGuJEYNygjiNanFRu+nDLb6KLD2hL1oStdwnowKzam23FGw9AKnJm8Zq2kA9AnQxOx080mBv0qCePhQVNZCiTW6y7qG2qSLgpshOzSlfDB21LzFASafKfhKbfMyqcwP99HWBMaQ3GLIyArOqJoYzqd3vslE00V1fvV1nA818PppYvXWF88RmQbC2UFl2U/LPgu4LLxLyyTA3TYeULQB8UuB03SsjQkFAhz7aSgdd1Q1Exj+I0EBUoC2m9hRhtI5ZiinDYqQ1UwHZnCoXUltZ3wMRFC0O0HD9NoFdot51NnMnqaBU1EujLLgcEHYi92LSxHzFzJJNyVquAwOW6fclJIlYaBnZ4JrV9V4tWMOosnMLmovgTKYpQ2DA4bP3gshJFRqff1FfGKOW3ilOWq2kMr8y2UBoWDQdCyqSzIioiRRCmk3n1ZQJ0XsLEk2WmfEoOfW0kPoV2X/3tyhfT8tYiNCzyuAFmRkepvA3y5YVym0mM2TqrroWO0LkIbBXxKjd4XaViffNn7wVNs5x11zlM67oOHBIU9K4DxrEpIYwi2GvFBeBDp8Ltow=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWJlbW5IMHFERkw3SE1Ga1N4MnN2L3I3MHY0YUplRmUrSk40ZHkwR1ZaZmow?=
 =?utf-8?B?WnRtTnpxVjhzQ25FRkNLOVcxT09vbERjb1dLUmZUTkxwUFZUazI2VTRqQWRU?=
 =?utf-8?B?NWk5WHVWMmtGbzBVUzlDVHlDMWxZcTZ5UnQzOHZOSE50Z2JqdmRxQTBTSkM4?=
 =?utf-8?B?aTlJNkpJM0Z4VUMvOGN3cVd4MjdYNGJXbjdYT1lNRFhHdDRKUHo0bE5LR1h4?=
 =?utf-8?B?aDM4R2dLaUR4cVBmeEc3bDZOU3lUODlsUVpKdEdnTFRCUTJTOHdHR29sazdY?=
 =?utf-8?B?OGZ6SG9xUThXUXRwcU9wLzRkbGtqRXJKalMzRHRTNlVqaVMrd1dwb0ZxcTNJ?=
 =?utf-8?B?RGdrajd5QzFhVkJqR1hpaDIySXNZYVpoTWdEZzlQQXowWVhuMGdJR2U5SmZq?=
 =?utf-8?B?eHhPSDRPNDRvem9XZktHMGRISzhFSi9NMjQyVjJQcEpPQngyRUR6VmhEWmcz?=
 =?utf-8?B?OGhVVXBiM1FHcTNqWWcyZGFUektlVENGS3BrRVJoTEVENVV0ekRxWHRzeE02?=
 =?utf-8?B?cU9ycDRrKzZYQVZOOWx0MnAyRnJESFJzalBIb1A2UjNaQjk4NnZodmhITHli?=
 =?utf-8?B?aHNqMFdET2JOdEF6bVZmZE01dWdVR1habi9STWZYWkRwSy9wUXhDTEF6b1Zk?=
 =?utf-8?B?SkdMMmhxc3ozREFnQnJGUWRWZGdwOTN0bzhRZEVmU2t6NTg3cGY0N0QzamVY?=
 =?utf-8?B?dEhMdDlvNHVXWEF3UjhDRUZiR20zZStidGF0eVJTZ1I4citDWklDNHo3SG5H?=
 =?utf-8?B?cExpM094VHV2U05Ecml1MnVBTm82c1ViTzBOdU9uTkpYRVFGZDlnVWNnZXpE?=
 =?utf-8?B?d2pJbG5aVzRzZmhWQ0tzZGdRc1FHdzkrN3ZFRmJoVVBrS1NmTWRZRkhFUG9D?=
 =?utf-8?B?Q0VNVlBLdkZWODlRbDlBcEJBSEh5YUxoV0xaamcweXlSKzJjRllYejRnamxC?=
 =?utf-8?B?dGgrQnNSQWMwTW11c29qQlZoVGJLU1Mzamk5Mll2UkVhdzA5d1kyRlZvNWdt?=
 =?utf-8?B?Szd6alllVTg5a2JzRWZBQ0JHMGp2MU0vZm94eGkwQjZ6RFgxSXJTUmRqSnNK?=
 =?utf-8?B?ekwxQS96dVVFcUc2SmFJdENnNUZFelpYNU81enUzeW1hSStUUjVXMkhlUXZw?=
 =?utf-8?B?bkZGNEZNU0RQUjBBbTRCclowZjJiZDdGRVNVTWIrZFE5VVRTSXQ0TWtUL3JX?=
 =?utf-8?B?aVVYY0hPbEhVR1RvMGVFdWNaUXR0OFlrN2JxR2Z3RHdoc1ZhdSthME5GMWdz?=
 =?utf-8?B?a2xtUm8yQ1R6QWYyczFLV1hTOXA4TVpIdlBRYTBYNW5wWDNwdU14VmVGekNq?=
 =?utf-8?B?OFQxRHJtRWZ5T2tqV2tnUFJjMVhJbEpTU1RPa2k5bU1taGd5VmVFa0pVSTdW?=
 =?utf-8?B?TWdwcTA2R2Z0ckt1R2RaNDMwRk1Sb3YwaE9hZ0NsU1pKSFVRY1gxNGJyRUpH?=
 =?utf-8?B?WmYyRW9wZE1kZFRIZlVoUmhJU3NzUStiK044MjdZem93eEdVR2RGcmxneG80?=
 =?utf-8?B?VXU3UXhUQnF2SlozN3VCTkdQSHVzT2g5VlVuQWZIbnlOeXl4RFVOOXJhd2NF?=
 =?utf-8?B?YnVIcklJTlBqOEQ2M3c5UWxsR3JQdWRuNWNuaGJLaWtPOFUxZEIwWVdqYlBV?=
 =?utf-8?B?c0hSMHNlek5YL0hFZjFzWm9zcW14RG1tOWJpVjU4dTRSb09LMHdkVmNLWUt6?=
 =?utf-8?B?RGtRc3Z0VC93SXVBSnFNWDFQcnVoRE9Mbi9SSlZyNUw4TUlrUVMzUUZaTUFL?=
 =?utf-8?B?ZzJuWmNkR2JIa1ZGUmN6YnZXOWRDRFQ5eldCMlRMQVpWVzlLLzhyTHQ5MUVQ?=
 =?utf-8?B?OTE3QkVhUUlyNm5kY3k4Wk9jdkMwNXN4L0RXUlk5dEFxYUU1blNpdjZ2RUM3?=
 =?utf-8?B?c3BmdVM2WXJXeFkzSkxoYlhvd2JKbWUyR3NCZjIzdldRWWQ3UmpXbTFhT3BX?=
 =?utf-8?B?RnRnV01IZnpFNjlicVVWTCtvWGtiQkt0ZVd6ZG1ENW1xTTBUcjNmZUdtTHJH?=
 =?utf-8?B?WFUvK0FFbEtOa3RvRlZhazlvMU5YR2Q5MmVPS2NKUmZhYTE2TkFidU5uVFhI?=
 =?utf-8?B?L2FCZEdDQlpBQ1NRMHZqRUxSc3I3eW1EcitqMG9xcEc3RWJya2FQSTVCTTJU?=
 =?utf-8?B?SWRzenJaUnNxd1ZwWllUU2hPdlFlU3BwNjQ3ajFSbWVSMEErSElDZC9IU0JU?=
 =?utf-8?B?WklLWnhrc0ZiN0xBRlNCanlGejFFRW5STkoyTkppdEhYZUtYcFpTSGJRVDJD?=
 =?utf-8?B?Rm9kaUpGd25nWXB2YU0yRlFHUWEwdVRkUGF5UzdrdHMwWk5qZXBKSG9iZy90?=
 =?utf-8?B?d3JpeEd3NWQwMkZmRUVrSnpwQjlKdWRuOHVObDdpUFlPK2tBL213dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40A157F6075B2D49A5D83FF41500A2F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Nh8WSbldPqrqf9SqZSue0scnb21Yt6qGceXXJhNFNQddJZMqiFje33lbfOyxOtLZfmKiJcYHzVZwrQ+LwZSAwLFf7dkIJXb7Qfl2GoegppqNnsyfkzyrEn3jQn6apqvd/KJ35UF0LJM1JwjF1RThxn51Vwb4lojoQvci0dAR/whF/9fDCspvB90ez+Ubo2/JUciZZYk5Y8WYZniaB5qYFZVXDoixUIhrFG9VgdXNXuuzIk10aEd5IZ6ztZKRRBiSEwzqJXCtbaatMNCK5NevJCu6Yot/lHrmGjsGbQmUysjO4BVonDgAzXQ14lbe9yVtHE9HNshrLyZne0xNANPNiw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10fafb1-f52b-4df0-b391-08de8fd754ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 10:13:33.6186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bq+zoA+EwO0mF6K2tcAqHNVINjtZs54CGV/5A/EXfjCYQt7DpS0Mq4MxGDa6ZYb1SQjzERaOKhHZbKZzxDnsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6236
X-OriginatorOrg: intel.com

DQo+IA0KPiBURFggTW9kdWxlIHVwZGF0ZXMgZ2xvYmFsIG1ldGFkYXRhIHdoZW4gb3B0aW9uYWwg
ZmVhdHVyZXMgYXJlIGVuYWJsZWQuDQo+IEhvc3Qgc2hvdWxkIHVwZGF0ZSB0aGUgY2FjaGVkIHRk
eF9zeXNpbmZvIHRvIHJlZmxlY3QgdGhlc2UgY2hhbmdlcy4NCj4gDQo+IA0KWy4uLl0NCg0KPiAg
c3RhdGljIGludCBjb25maWdfdGR4X21vZHVsZShzdHJ1Y3QgdGRtcl9pbmZvX2xpc3QgKnRkbXJf
bGlzdCwgdTY0IGdsb2JhbF9rZXlpZCkNCj4gIHsNCj4gIAlzdHJ1Y3QgdGR4X21vZHVsZV9hcmdz
IGFyZ3MgPSB7fTsNCj4gKwl1NjQgc2VhbWNhbGxfZm4gPSBUREhfU1lTX0NPTkZJR19WMDsNCj4g
IAl1NjQgKnRkbXJfcGFfYXJyYXk7DQo+ICAJc2l6ZV90IGFycmF5X3N6Ow0KPiAgCWludCBpLCBy
ZXQ7DQo+IEBAIC0xMzc3LDcgKzEzNzgsMTUgQEAgc3RhdGljIGludCBjb25maWdfdGR4X21vZHVs
ZShzdHJ1Y3QgdGRtcl9pbmZvX2xpc3QgKnRkbXJfbGlzdCwgdTY0IGdsb2JhbF9rZXlpZCkNCj4g
IAlhcmdzLnJjeCA9IF9fcGEodGRtcl9wYV9hcnJheSk7DQo+ICAJYXJncy5yZHggPSB0ZG1yX2xp
c3QtPm5yX2NvbnN1bWVkX3RkbXJzOw0KPiAgCWFyZ3MucjggPSBnbG9iYWxfa2V5aWQ7DQo+IC0J
cmV0ID0gc2VhbWNhbGxfcHJlcnIoVERIX1NZU19DT05GSUcsICZhcmdzKTsNCj4gKw0KPiArCWlm
ICh0ZHhfc3lzaW5mby5mZWF0dXJlcy50ZHhfZmVhdHVyZXMwICYgVERYX0ZFQVRVUkVTMF9URFhD
T05ORUNUKSB7DQo+ICsJCWFyZ3MucjkgfD0gVERYX0ZFQVRVUkVTMF9URFhDT05ORUNUOw0KPiAr
CQlhcmdzLnIxMSA9IGt0aW1lX2dldF9yZWFsX3NlY29uZHMoKTsNCj4gKwkJLyogVGhlc2UgcGFy
YW1ldGVycyByZXF1aXJlcyB2ZXJzaW9uID49IDEgKi8NCj4gKwkJc2VhbWNhbGxfZm4gPSBUREhf
U1lTX0NPTkZJRzsNCj4gKwl9DQo+ICsNCj4gKwlyZXQgPSBzZWFtY2FsbF9wcmVycihzZWFtY2Fs
bF9mbiwgJmFyZ3MpOw0KPiAgDQo+ICAJLyogRnJlZSB0aGUgYXJyYXkgYXMgaXQgaXMgbm90IHJl
cXVpcmVkIGFueW1vcmUuICovDQo+ICAJa2ZyZWUodGRtcl9wYV9hcnJheSk7DQo+IEBAIC0xNTM3
LDYgKzE1NDYsMTEgQEAgc3RhdGljIGludCBpbml0X3RkeF9tb2R1bGUodm9pZCkNCj4gIAlpZiAo
cmV0KQ0KPiAgCQlnb3RvIGVycl9mcmVlX3BhbXRzOw0KPiAgDQo+ICsJLyogY29uZmlndXJhdGlv
biB0byB0ZHggbW9kdWxlIG1heSBjaGFuZ2UgdGR4X3N5c2luZm8sIHVwZGF0ZSBpdCAqLw0KPiAr
CXJldCA9IGdldF90ZHhfc3lzX2luZm8oJnRkeF9zeXNpbmZvKTsNCj4gKwlpZiAocmV0KQ0KPiAr
CQlnb3RvIGVycl9yZXNldF9wYW10czsNCj4gKw0KDQpIb3cgYWJvdXQgcHV0IHRoaXMgaW50byBj
b25maWdfdGR4X21vZHVsZSgpPw0KDQpJbiB0aGlzIHdheSB5b3UgY2FuIG9ubHkgdXBkYXRlIGds
b2JhbCBtZXRhZGF0YSB3aGVuIHRoZXJlJ3MgbmV3IGZlYXR1cmUNCmJlaW5nIG9wdGVkIGluLCBh
bmQgYXQgdGhlIG1lYW50aW1lLCBhdm9pZCBtYWtpbmcgaW5pdF90ZHhfbW9kdWxlKCkgbW9yZQ0K
Y29tcGxpY2F0ZWQuDQo=
