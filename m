Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F6D3A71B0;
	Fri, 22 May 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441022; cv=fail; b=QUQ3a3Ub7z7UIGh0GnWycLFEzcZky8VGwRe1FWWrzZ9NgwEswZqv2oDJuFSbuIRhh4km5IuNOC2F5IYrU6iHle0xW+zLRfFpOBCCcFJvZfdsCU0Uj3Xm6IZNqBkqAj4RKP/MZcLYJ7mbyjan+1nQv/j+V/Wb4wkN4OnHGaj6zRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441022; c=relaxed/simple;
	bh=1xB+oNIsg1MUpJOCzZj4b+zncO2VAKGDyiYcta5+Q6U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X25fvAXJv27GmmtKgaRUhhFgHthbnMWuDVhMFKA/6rgJ+90WOYCx6Rtz51emKi6tYMo1EmdY98kpvYD+vww7ym/7BF6MvMKRKiXscuzYnonSaglubdKfBQNG6cbjbCqJgApgy3JLuZwBqYYSIKAI4z1M9fPwBTFCm8FNJyvpcqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NB0OfWal; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NB0OfWal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779441021; x=1810977021;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1xB+oNIsg1MUpJOCzZj4b+zncO2VAKGDyiYcta5+Q6U=;
  b=NB0OfWaloWJG6anI+siiuC8uynIACaDaddt6YD6wk2TiiRGCJn3OglV5
   NDTK70PGdKYOG8K0YEK1m5ZyXmivcDDVwEgdZl1GCTFbEfmzJpRl4zUA1
   fJ4kWfmKDUB/Vpinyis0QdHrfeeMFjN4kHa2N8/i5uCzSg/Mm7iu6VKqU
   kX4H8I/S70sjPKkX0UU27b1bWJItH1wbAMEMjGdlGQ+wO3NkfsqeGLz4s
   bOcJpntdjPhv+krNFwGlh1bb5ImR21q9SvSCEeAbF9xIGr3jFAuFNz3nu
   P0LGlVbmucWaJytFItMiP4qfKxEYF1l7hM2/CYe+paU5b9g257Xpa+ZKl
   w==;
X-CSE-ConnectionGUID: PPcRIe/6QpuM+kmRiLFGNA==
X-CSE-MsgGUID: OucFUipQQSiVkc62Ppqf4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="97945036"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="97945036"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 02:10:20 -0700
X-CSE-ConnectionGUID: zFG8ob7hRZe20NmDfOMdzw==
X-CSE-MsgGUID: zKziwdNbRQikfXVBSr0pIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="245137193"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 02:10:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:10:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 02:10:20 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 02:10:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1YM4rGz4xDzxM4c5rds6L260IVuliXGehCbQHd8jINbKilw94LUR6laKKk3ex4xtSCqw/0ZUg/nd8C+bOXwmoCkBq32nnc4VrpMkF8GDCQGE8r5tE/4+gGiL/8tKhjsPvyhO6xelrasWeHu2DbWY19cjpfwQg4R/fsH5pQ9F9jDMispIBL6JVMD79mjAPKtwuZnZez2Rne8wVfvr2aAXFrNOdqSI2bWHYzTiR28D+i49qMdGRXS1EhSn3BbJJIyzrq0D2zCS+g5zCIe+h//LR1uJZZX8SlSbtJXCYEa0vEy9xWA8LJoVBieaOqueuL1b8xWIR8Knb0++gL52CTHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AD3rC4YHzYCGryMwGVBSiidT3ecR9csA8+qDSMjqn4=;
 b=IhgPPdATbm9zHVwhPHETHkPQi200jkCC0zh1Vn7chRMFN1e7JU4Po3475EVpMPfmUbyNdlR1Bwg/lRjH2votZlNVHnOHC6hGhzb25KDpjo7n0ax8MickKwnEnxdomeL7R1opu5K6zbLiA/0l5x4+AHuMRCkz/bPo4qfGJeCsJuK+iAasAacpXM5PsfbKgM/u4j9XBtABpUyN7DVs6uNZuwoe36ykf7LtAb0EzFmq09TUnUiLWiaGjwGWSDLdMRPWMowFSyEg09APPWbMd1repsvJa/nTUUrgW4Hgn8JEPR05EhJ7yCF5Lb9Mb8XP6b5wvETUkzVB0dEGu/2go1NkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS0PR11MB7767.namprd11.prod.outlook.com (2603:10b6:8:138::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:10:11 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 09:10:11 +0000
Message-ID: <ad25c3aa-567a-4bcb-a3a9-decef7313a2a@intel.com>
Date: Fri, 22 May 2026 17:18:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>, <joro@8bytes.org>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <vsethi@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
References: <cover.1777269009.git.nicolinc@nvidia.com>
 <f6734b9dad0050138676f11ecd14e9db1cf6b697.1777269009.git.nicolinc@nvidia.com>
 <e8337102-aecd-48e8-9a2d-10f41ed43c5b@intel.com>
 <20260520143410.GV3602937@nvidia.com>
 <80e7e1be-c384-470f-9949-8c0dbad165ac@intel.com>
 <20260521130544.GE3602937@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260521130544.GE3602937@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:820:d::9) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS0PR11MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb2b80a-d64e-422a-c076-08deb7e1ed82
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|1800799024|7416014|376014|366016|56012099003|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: atWJPi0JToyz2KSc8TQaYvLM89eh1XgcRv3eNp8w0sDVxQfJMCjKNEUHZkN+3sVKRMurHyYZzHTSsgK0JYpuK7VcCAA3hvWQ1K0pNHqLyuNaL27pobQkKKKbN/c284dl2/1fT+lCOWcrHtOSUcwaSqDCyjT6Bzll3ZDgGQ7+eJghno0Rt/G3u3jLvV0SGdTwIni4m51a3/cJLoz41RKfs6X8cHiquXrsbRkXBO35uqTZZqtmUDrOd2XfgKP/ppkP4GmhuGvFwYnlu+w0BmYuX4c132F0flxmnAevY94SDOV/Pm88KAt6hv9b6/muAP8ljUK14KEfRkwci7s7YcOxzEm0ncq72sVYUy7us1nHja1BFuvQCB/K18bBJHKG0SwZf2LmHj8xRvEl58UytNBdxZvfzniu3DYMShR6vQBBgjfpNyvqbFJnw7pezNff3kCfrsivqYUx5okgDr6pJhKSGhAqfho9AqOT73AUAxgEVhcfwxN9zmpCHuQcbmkd8qap2gUzKgipJzpGCqH63EGyr4mEB3hFNTUFsY65tShfh00n+6paSF030oYYFXLWyCWIBfJsKrHRs9hDiLhusHGgIq+GCNbJhwLjvR76Y8rifHdtM98s/u5QR/leQIT9FabOfqajDOyetBp+0oqfTkp3KkWITmfvJ2Pq0Mf/tdbwVEqWVdlC0i1c6ZiCUrslqE3U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(366016)(56012099003)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akZoMXA0UTVRcmsvbUtYUytPd2Mwb3FMYW1YVFNVbkRkVGtCd0NQZ2VsRzUz?=
 =?utf-8?B?QU1GZFF6RVBvVFFKTDZLaEc5Y1lRWkNJc0s1aG16MU1wWlpJbzcrMVZuVDJL?=
 =?utf-8?B?VEFVK2pENTNqQWYxaDlkRXVHQ2pkZWZxaXBVdVBZY2xscFNGb1d4SU5OejJX?=
 =?utf-8?B?ZmluTVp3NFJXeG1Bd1Z0K0NzUTI4ZGZ0Z3Y4RFhWM1lSVENUdVoxaXVMMDlK?=
 =?utf-8?B?aHpvZ1paYmZwUXpiUmwwSWo0L3V3NDI5UWhoZGh6WTJPbWhoRW9VMDFFcEx4?=
 =?utf-8?B?R3lYcGx5OXFNVlJMZWErS0hBWlpKdWRhOS96aXk3dUpXRzArQVVWUlplb0Qx?=
 =?utf-8?B?Z1BwNjkyL3RMamRBSGw4aVFCQmgzSlJtQWxjWlpoU2JBY1A4L1kwTnh4dFQ4?=
 =?utf-8?B?MlI4VUxnckhvRmx3dWhiblZyR3NKd1pyYWhOVjRqTkQxVDJwQ0FGL2dOT1kr?=
 =?utf-8?B?eU92YXlSd0xSdVB5dVZkLytXWWFvVUdLSms5aCtCYmZFMHZiZTRkZlk4RDdT?=
 =?utf-8?B?S1RTNk5OOFAxeTZ3MkxaZG92NFVXN3ZxQ2g1Q01hcGFiZWtGSUhWcnZtNHpU?=
 =?utf-8?B?L3RsWDJKeTlaNzFubDBnWTAybitEZnVVR3I0dW9pMmNLanZTTzVwcmZySy94?=
 =?utf-8?B?bGtKVjNpcmhtdXhLeTBFcFJTRHROaDB1UXVyU2RuSnlmYXM1NEVLc3VEUEZp?=
 =?utf-8?B?TEgxMzRsNEVQSUtCamNWTHFmNEM2UFpZQ3AyZ3JWV2x4ZVBWV2tvMnNyUFJQ?=
 =?utf-8?B?MWlEMFQrNHljcUVwY2ZIR1FMem1uVi81NStkOEpzK3Jjak1pZDNUTTZrNUZl?=
 =?utf-8?B?dkhVay9keGpsUkpRS2RkWFkrdm9qTW9tT1dzR21HR2pPSjZLK0NYYXFMUmpp?=
 =?utf-8?B?L2N4ZVMwb09HUGdKdHBiMXFOTGlFZ3pxb1M4Unk3OUpjSXIwdFYzcllCZXhJ?=
 =?utf-8?B?R0pzZzdiKytuUWhkL0x5WmtGT0g3MkJWTFBQcVlXYlY4TGpET3crdlFKeXNj?=
 =?utf-8?B?UG1qUFpib3daanM2NjBmRnJ1SHdLUFRXU24zcmdGeXUwSEFIeTB6WVl1Nkcw?=
 =?utf-8?B?b0Y4OVllSWZUU0hoK2w3UEVSVjFoRWFyaEovc25vb012UW00VXZyeDNXQW1i?=
 =?utf-8?B?TkRURXNpT0FJRTZDbFlERHo1S1pWZXpkdmtjZWRITW1MbnY5QUpKUEx1VS9y?=
 =?utf-8?B?enpCRC9VdDVMN091Y2JZanQ3cjhiVFVHNHM2bHZIRVFoSWNKNFVRTENjL0FF?=
 =?utf-8?B?dk1xdTUyRHl1Uzl1VmZ1TVpsWitQTnNuNUU2WnB4ZVJYMEgzdVV2djNjYWVZ?=
 =?utf-8?B?d2RjVTY1TklvdG1Hc0xXVUJpNDdJWTNjUllmYkVkT0dqN1BhYmUwNEFVN2Yy?=
 =?utf-8?B?UjNzK0hORmlzNXo0aDFQbDhxRk5HaDN4UUV3L0tmd0xKMG5qMUFZTGhBYmdC?=
 =?utf-8?B?d3JaRDFHUUQyYm9iUmR4ZU5XMFJTU3JPTENVSUR4dEgrcUpSeSszYUxZdE11?=
 =?utf-8?B?dEkreFFKemsvVFZ6a3VQYlNxT1BaODhZcUhBZjZpd3Jyd0ZJbUdJN2FGOWFE?=
 =?utf-8?B?Uy94M2EwRFZjYUUrR2ZQcHR6elhWVnF0WHVUUS9zZ3ZkSzJIRkNVdk93c1Uz?=
 =?utf-8?B?MkplZHZOTjRSTGxiQnF1TlQxQUJXNlo2SFlYdjNMdW5jM1FteTljcHM0QlRZ?=
 =?utf-8?B?L09yU2lmTzVMaGZTVnVZRVAwV2p4VXBKOTJSZ0JlMFZWallMdmdnRTRXZ0Fz?=
 =?utf-8?B?dnJjc0d3MnNuSTdoekgyVTVZRGtrUG9xQncxZTdzeUZzbDNhVXBUZHlZU0ZC?=
 =?utf-8?B?NFAyUXhsbEkrS1pyMjVidVFvbjdIVlRpekxwNFpQNkxEbmJaSUJzcXV1eHJp?=
 =?utf-8?B?TXVMRTlWeEZPWmNlamtYaU1PMGZEL0l5QkJ6a3RXTERVYVZqelZ5cHlmOTQ2?=
 =?utf-8?B?Z3p4WEUyeVNMckZuZDNGbGRock03eEtEdy8vZWFjZ0RTMFNIVXN1Q3JtMUhO?=
 =?utf-8?B?K1QrRnlucEJGc3ByeDd1NTV3Yzc0SlpPYjBqTjRRSWR0S0lrNlNEdVUyZjhE?=
 =?utf-8?B?ZFNFWEN2YmJqQ09qNFh5OU9yZFdXbUNXMWU4SDhBK2JMMGdnVUhpRUlSQlIx?=
 =?utf-8?B?T3N4bG5tM3luUFJ5a3JHOWEvZDkwd2dtMEd5d0xzMGtPKzF6QlZQUCtxS0hR?=
 =?utf-8?B?NHlQWmtLOUVITUFwTnBDajFZZitFbjRUZWZzZS9mOG9WSXVNMWlVb2RyUm9G?=
 =?utf-8?B?UUZvNzdySm1XT3EzYUpmUVgxY1BNSFhZdzQzTXJTYUpBTm1EbWxZNWI2M0FJ?=
 =?utf-8?B?d3JnOWRheGJQK09DK0ZBYkF5YUhVdXJjK1NwMEIzemx1d3lYSjhVZz09?=
X-Exchange-RoutingPolicyChecked: ZU02ZxYkEavfviA93kVSdYMGlQzZEiuXX6btQeBf3aG7okoVFY8n2/z0WvDe6sQbdaA1Ci1IoSr+++efvLZvUheBlR5wWLfVLhJcsEdVdZpJ+JbryqlXrIIy4RrV1Fk0/f6z/ET1YuzM80QAqfOKz6Wc8xGfDHb0i9hB/Nyj6LfG1TNsOW0ynqm3khFl5REA85rnstoUkiDf8fQzMHuQqbKqYPE8Hnhqx+TnQrwHJ82kniINXIBjAo2rEL4GrXBqmT/Jh0eu3wxYyT3ytweiC7KQXeN90EsGd1FTIJWedyi5oplybyBWXfEy2aT1JkLEDyXobejvaNNun3k6A1Z+vw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb2b80a-d64e-422a-c076-08deb7e1ed82
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:10:11.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65u9JnUSVhTFp4yfLdhcWytv4kdDuDPTN/LgzMiANKCDoT+qPz5WuEioYO4QTNfVHEVxQNotEs8G7UnF8so9WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7767
X-OriginatorOrg: intel.com

On 5/21/26 21:05, Jason Gunthorpe wrote:
> On Thu, May 21, 2026 at 03:31:46PM +0800, Yi Liu wrote:
> 
>> Does this hardware behavior satisfy the security expectation you have in
>> mind? Or do you still require that both the DTE bit and the PCI ATS
>> capability be explicitly disabled when a blocking domain is in effect?
> 
> If the HW rejects translated TLPs then you should be clearing the ATS
> enable bit in the device config space prior to rejecting them
> 
> But it does seem secure enough as-is.

got it. thanks for the thoughts.
