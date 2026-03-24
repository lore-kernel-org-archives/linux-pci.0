Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7452DEA7B;
	Tue, 24 Mar 2026 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357225; cv=fail; b=XEtZT1PrEufnJi5mDixjlmyI/D8TrQUYM7xsgw1uZdakiqYvFtAtMdtUWpkD9TOwBOD54PZXE9BGoXaKJBf2xwglpAFrbD/x8N72pqW4rcMiusjbn3gze4R2vY6pCMkhcK8WGUpALtPmpGfvNm9N1dnXF4L7UbtjEV7OR72F5Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357225; c=relaxed/simple;
	bh=cr1zK/4oCAGFEHqWJIIBhO5IvxY+rtnQjG70Ul/vp2k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cGKwJ3bkk6f6nIkWdo2Wc5gFtlEHN8g+L26f1dWoVSO9iJM2EvFHA60Oan2t+DJuwjJIIVC1IKrscvJ2EAcRUEVzMiNPCjW9Y1ncyWvHWIkOmNhWleZJm/AoqWFaP9Wu8mOTOqexM0EJ45KxlaoBcQxaV2Qk+aPab9t5TaYXKYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XM+LHrd6; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XM+LHrd6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774357224; x=1805893224;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cr1zK/4oCAGFEHqWJIIBhO5IvxY+rtnQjG70Ul/vp2k=;
  b=XM+LHrd6fUebEcaHK99uX1fzey39Vna2x7x5b5+wO5h18q7y5745720G
   /d2UjF56gLSVuLMnJhDW3TPK2bWLfLkhHjULuh+giWcglNpp7tsTEMAY3
   gtMv3KmRChtPRMZOQ5DTMkMXTXBpa668C5q+uwjbQbgWpgzuwV/JUJ2y8
   Whc/Yqb3Owq4cZgaNVM6bzrzLwXcQWjdSnfERkApGZ9KyAm7dB2ZeEjem
   DGOQ8Y1MVPA0OS3Po4OQjxr2/6iRvQ39WaG3YTyB+AgMXUZx22zTlEntn
   OifEBOdF8Hqt9bLoRSJGJ65WbzLNOWFNm8FxSWpbXMc3eXf9iucijOYjo
   Q==;
X-CSE-ConnectionGUID: pvKG7vJCQ16ZcGikPVQEfA==
X-CSE-MsgGUID: 6VF+NJqSRnax+C1lILzbHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="62921495"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="62921495"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 06:00:23 -0700
X-CSE-ConnectionGUID: OB4TBlc1QIq62BlgsiCAmQ==
X-CSE-MsgGUID: JW2imWdGTumCQRWRgaH3wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="219908261"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 06:00:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 06:00:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 06:00:19 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.60)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 06:00:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnxwPdQe3D1aTKUaa/SV2rTamV+mmCfY0NNOzadgw7rKA133jVO6QIemKt+KPE1h6Ym4BqCajhtNdjMG21I6vM33NXuucMi+XQB1jY0C244L8MVDVoHjjzy31CIFMGmC7IlpCynB4yznQYgM1qznbbMRID+b/DxGpkbQcIGB6SCcj1foZwyja3C3TSqNQRqlgpQ8JaSP6czrEm5Y16C2lh6TdIXgkmsSYJ3Nd16MvUbGdqlS3lRgMziPpUwlrbW1RGTfs5eIZ37fJjvJS/m/ff4vbYC6/HP0/e2YWZDux1zx8TWspv9oJ4EeWUP7YeNSRog5G1VmkNKcw3VU7UPfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap9xkwBoPWiGKSB/7RGzc7FrJWXP/J/+7OTsijHf58M=;
 b=G8MzYimUZYs1SiUZTzMdREzRo+YNj3OZ3RP6oD75qCgZv24xZrS1jVUXe3kOnCMP1yObic56J0DIlvYnweKv4IrTFo1NfuIkmtty8zV366j4mGwilxblr5tuhsxt3s4jArQUi5fXSXSm2jkfqVs2OMhpI+fzgIeA2ETAdhhLQo7179manD5bvqhk8jWRBci/uJoLmTxhz1c9pCM4TZ1ZgZyuYjDmsWEEK+SCuU0ULWSubRehL3gzzFqtQ2Du4KMdn6cBAm2jFjPAsErX40pQrVmuycb2LhVlm6b/34hUsSx7Sezv/PUTuES5lkLqAZl09Z5+DeKg/oZy4lARtIDDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS4PPF0084F97E3.namprd11.prod.outlook.com (2603:10b6:f:fc02::4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Tue, 24 Mar
 2026 13:00:15 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 13:00:15 +0000
Message-ID: <376910fa-4232-4e58-bf87-0504202866a5@intel.com>
Date: Tue, 24 Mar 2026 21:07:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/24] PCI: Require Live Update preserved devices are
 in singleton iommu_groups
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf
	<graf@amazon.com>, Alex Mastro <amastro@fb.com>, Andrew Morton
	<akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann
	<arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, "Borislav Petkov (AMD)"
	<bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, David Rientjes <rientjes@google.com>, Feng Tang
	<feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Jonathan
 Corbet" <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kees Cook
	<kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	<kexec@lists.infradead.org>, <kvm@vger.kernel.org>, Leon Romanovsky
	<leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-pci@vger.kernel.org>, Li RongQing <lirongqing@baidu.com>, Lukas Wunner
	<lukas@wunner.de>, Marco Elver <elver@google.com>,
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, Mike Rapoport
	<rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Pawan
 Gupta" <pawan.kumar.gupta@linux.intel.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>,
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-4-dmatlack@google.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260323235817.1960573-4-dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS4PPF0084F97E3:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc65314-26d0-4482-8787-08de89a54a9b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|42112799006|366016|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: A3txQW2o3gfWFJgjaW1Xkrklzaa6jN5iyOu3ehyp4+wePg7Vr/Pth/jk9wpk4rvqlGyeqgzx6VCmGvGNzkkOVhMqK16rY0aTbtexFSnpvc983YOcxUnvPQ1K/kA9//RQF71NcOz+7mbFjLLU2PcbK5giNTzkCIQtDjO8u3PeKWGnhLMiPe2hpflavos88pUOboUZq1GR5cCssRdmVKmBjIRyqWDY2qI1YgfY5RWxZQNWQ0EC6efJw2BlQI6aReQRGx3mGa2XFFX8EmLhEYOGo3E991FFM6wzHlwTvGpLgWjdVNfLInSDCcBipduOAOblg94vWyEU1CcsSmWv4Kqyyyy7s0rjlx+CrQDtg+tA2eFuxQAbPz4ZDq2D0uz6MpcQI7TS+gBPLGsesMOzSovvEIj6zgEuBLu/6jf1Vq/7ddOTL0cH6nas3AXxDzbHRq4hHyCPGpCYGSmrPIpHaDqiCqk6rdwzD5sWAZZgkSUTi8nYH6XU/igDJSYbYC/dzcgGTPkJbRpVxXQINhatbMgR7fa2BjIEeyKbf7+15s2EjNOQWzesuK1Q4Wgj9a0Pr0kWhwRvn6WL8ezUEuRJHjX/DcilQ3Vga+DsaDp7J025MBJzllCos08UOb/by/GErqHEgiTzYyhlrzh0D1g6dToU4+SxPf0SVTeewUDERdjdqk8sQOYTTeyMNu5zI6x4/8b4vuFCIsZHlymrr6bRnEIGA0CN+PT9CVbZxdBVOG/SDn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(42112799006)(366016)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0NWWTRHRE1vRHd6R2JHdW5JOU1mSmVmYWJrU25LNk4wSkVUZTNtOFJKMmRB?=
 =?utf-8?B?aEZkNG5HSDZDQmh3eSs2NitleFVxSXR0Z05Kay9LVkFibWxZRHg5cy91MFl3?=
 =?utf-8?B?YXR1Vy9YZ1BmeUtWbmEzWTRaYUxrNDlNL3hFeGlPRkF0NEZaZVRxb1lTMmQr?=
 =?utf-8?B?Qjk4dUdWemtIYzdWSmRGWUlyaHVjR1ZnYndPbDI3U1Jya3BlTUVPUEg4Nm5C?=
 =?utf-8?B?MXBCZDR3VnVhZlFuaWNrNkFmdlpac2ZOSmVOYkRzclk3dTRxSURUSjZzbThL?=
 =?utf-8?B?cEZwOUNRUG9iYUFheXRYc2M0WGlkQmhVV2tNNzJpNzBVaVYySm5wYjlRdzFP?=
 =?utf-8?B?ZGVqYnU5QWpNdFVrOWZINk9CdHlleHBqYjRrNGlhMlNTTlA4bkpJSFhDTW5r?=
 =?utf-8?B?cEJPZWMxajk5RHdXc0dhUjUva3BFMnVrTGFUZEZ6MXBEcnpQc1JoaC95a0pu?=
 =?utf-8?B?Rm04M1FCc1YrRDhyc3lDWTJIUWhvQXExZlZucU5wOURJYkFoYXJ5Rm9JcVA1?=
 =?utf-8?B?OFJCVS92eWg2MmdHRlEyVDB4THd1aHVJYzJaMjZ6Zjh6RHFsT3ZQMktETFRu?=
 =?utf-8?B?K2xmWFI2YllJOXB0NTJSRnBuRE11WWIxL1dNNThWZWdSUGdOY2R1d20zUVRw?=
 =?utf-8?B?ckYvZllIZzFzdytVdURyZmRYRXR1NGFZNnJNQjUxcU5lKy9NM1RreDhGYlZY?=
 =?utf-8?B?K3pGNFJnVGhJcVd2NWhFZzZLL3MvWmZsMEl5Y1JFV2ozRnovNk9vKzlCL1Uy?=
 =?utf-8?B?czI1ZFJEYXBiQjh1amZsVUpocjR3NU9UUlQvNGo2ZHFEMmtEVCtyMEE2K05N?=
 =?utf-8?B?czNvTXdXejl1dnVUd3p0SkhPWDZIYkpLTWNldVlyU3g5MEZIb3c4SVpmRjJY?=
 =?utf-8?B?ZHdHcnNSRUlmV0pIMGVpL2NITEdUYjM5eHNaTkhSRUZrUjVyYk5rVXloRHNz?=
 =?utf-8?B?YndKdlVwdFp0OEVxS21QeUg0dFg1SWJDMUIzeVZFSXlpUXFDNDBxQjREYWZZ?=
 =?utf-8?B?cGg4WjFIWlFodU5Kby9lUFIyNWpVWXNjZ0pTT094d3c1VW5qdWI2Q2VQd2JG?=
 =?utf-8?B?VVd6T0Fhd1E1eEhEWjBnbmZraktmTHJvOVhqWXBEaDdDa0trNDhLNGI3MWla?=
 =?utf-8?B?RWlVWVpyaWJ6amtnMEd3NTBEVjJCZXpXQUEvblVXMEVQOGwzTU5SUkJrbGFk?=
 =?utf-8?B?K2dzNVJ5VzcvUGxlWHZyVVI1VUpqWGdxc2NLRlRyaU43b2VvOXdxU2JRZVlz?=
 =?utf-8?B?R3lDZlF5T2N4UHNyYzNvSTlBbmZpL1BUdmFDVEVKdk5NaEh3c2xodjBLZ3Jx?=
 =?utf-8?B?Qm5nY2s5TXVQQ3RVTGpIenBEMmo3WUg4blluZHNTa0RTYWF0Q3NMVk1MQm5v?=
 =?utf-8?B?aElmNkNYVC80c2ZIMURqRmY1TWlyTjQ5elUzTVVxMXRINWYxcE5xRUhWK1pt?=
 =?utf-8?B?NlZnVWhrQWs0bHJQR2dtYVJOWUdhQlNwSU5wQ1JSWmhiZmJqNmxvMXNQNk1j?=
 =?utf-8?B?NElYbjBHZm1jRmVsNHk1NzIrajZFOURyc0lZQy9XWlNPS24yYUlrY3dZa0Zz?=
 =?utf-8?B?TnlURDZmcDNhYzg5N3kyUXNVYnVRaDdJVXFoTzlsQzRIbmxGWWZHdk9zZEJl?=
 =?utf-8?B?c1RWNXNhMFVoa1hMcFBCNkhDdmVvYzFyRjNxYzE5UDZ4elpiZ0FRTGR0WFF3?=
 =?utf-8?B?RFZKNUxFdGZVTW9RdEY4RFRuYzVVM3N0T0UxQldBMU9EM0h2eGxzM3ljQXYy?=
 =?utf-8?B?K1lMQngrRCs3b0xWUkgxN3lzL3l2SUY0TURRRG8xaDlUbmZ0NjNpYzAwRmNK?=
 =?utf-8?B?eE04NTRQV1BabDlpaUdpWndrWGtPRFB1cmVuZFdyQ1VkeDg0eDlqWlkvL0RF?=
 =?utf-8?B?NXByN1dwMlFsV2YzUW5zL1VESk9zTlppU1hpUU5zVy9zTW5xV0dXNHAxaThx?=
 =?utf-8?B?OVBha0g3QTN6amJNayttaTQ2dmlFakltdzBOeEx5OUZGMlJQeG5NR25Rcmcx?=
 =?utf-8?B?VWhMUXZrTC9TYWxoNmlFaTUrZDJwdDdIeVJGalhWTFphb1RIYUYvMGpxQ2lh?=
 =?utf-8?B?Y3QzNHNkWWg3QldtaERsWmNKQjBZQUJPd01MeUM4MUdPSWhPWGNHTDEySCtp?=
 =?utf-8?B?NHlJVHowZWplaHBFVWNyOTdzdzg3MDhUVmR0cVc3THkxQzNSdkJ6ald4aEVr?=
 =?utf-8?B?bkRubFlIc0FOU21UQmdaeHZTSXdBeitxWXljM0ZvRUJVZXZHa1QzMnd3NW93?=
 =?utf-8?B?cWN3UWRUSDlnTEttOXVISmd2dllVWWtHM254WUp5dko0aFlwSEV6a1NNa1Bq?=
 =?utf-8?B?dE5sODlMZXVCYmRqQm9IVTVFQVc5SW96cWFiQ3lpSFBDQTJQOGxYdz09?=
X-Exchange-RoutingPolicyChecked: ARVS/eeTkmtJ41g6LQMYMeZaORyR/8gKPnOOHk40FsiY8LXHLoxUYA0wFWeJHcivsPP66fFpgsTJEPUbw58G+2m68YdLKHHjkaZVsKMHv68HhNPjGZoLZvIJJjiAiCQ6DOM0sSHezkCj8Ge01uzHeZ2AZiN/RUO6XmWWxrp+AFJSr5JLurCred+sC0O79VlDJ7mpjZWwVIJtNiSuHTPRJDwPLRRSbxhpW1jmfLE2yONaHXukOiuUPpij87Aqd00oxAcgToZEKGrczxmy7HqQhAMS75EWGypybLSYTeRx5Uxm5HFE/z5nk4/WU+wAiYEw3A5MkhBWu+7jJ4VGwMyFzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc65314-26d0-4482-8787-08de89a54a9b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 13:00:14.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6aSwakLe/ulhO8ww1V58ZXG9dn71ElyD6qdpjIuYARkilkwPV4HSZ32GLSMKYtXd7w/l9NpLulh328f3fhCFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0084F97E3
X-OriginatorOrg: intel.com

On 3/24/26 07:57, David Matlack wrote:
> Require that Live Update preserved devices are in singleton iommu_groups
> during preservation (outgoing kernel) and retrieval (incoming kernel).
> 
> PCI devices preserved across Live Update will be allowed to perform
> memory transactions throughout the Live Update. Thus IOMMU groups for
> preserved devices must remain fixed. Since all current use cases for
> Live Update are for PCI devices in singleton iommu_groups, require that
> as a starting point. This avoids the complexity of needing to enforce
> arbitrary iommu_group topologies while still allowing all current use
> cases.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>   drivers/pci/liveupdate.c | 34 +++++++++++++++++++++++++++++++++-
>   1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index bec7b3500057..a3dbe06650ff 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -75,6 +75,8 @@
>    *
>    *  * The device must not be a Physical Function (PF).
>    *
> + *  * The device must be the only device in its IOMMU group.
> + *
>    * Preservation Behavior
>    * =====================
>    *
> @@ -105,6 +107,7 @@
>   
>   #include <linux/bsearch.h>
>   #include <linux/io.h>
> +#include <linux/iommu.h>
>   #include <linux/kexec_handover.h>
>   #include <linux/kho/abi/pci.h>
>   #include <linux/liveupdate.h>
> @@ -222,6 +225,31 @@ static void pci_ser_delete(struct pci_ser *ser, struct pci_dev *dev)
>   	ser->nr_devices--;
>   }
>   
> +static int count_devices(struct device *dev, void *__nr_devices)
> +{
> +	(*(int *)__nr_devices)++;
> +	return 0;
> +}
> +

there was a related discussion on the singleton group check. have you
considered the device_group_immutable_singleton() in below link?

https://lore.kernel.org/linux-iommu/20220421052121.3464100-4-baolu.lu@linux.intel.com/

Regards,
Yi Liu
