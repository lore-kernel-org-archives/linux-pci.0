Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6EE9443
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2026 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770954116; cv=fail; b=LtjN7qDHFxgZ9C8/g6PVmG4Tnzvqsu2St/oASwcb+k8S6ZQI7ghlua4pLGQpchhhXrOXrrUllqZ7DcpXeDa8zC6I6kuz8LNpiu4LfTUEybG1egziBmeQjj0Ra1NibDvc7AV/Pzf7XI+oO27K1uBiqnxs7LAcarut4vPYlSd5Zpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770954116; c=relaxed/simple;
	bh=7zSAstQthB/xL2kmB2inZwMABtOPVspBEwCZS6BGYgU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=DX8GPcfTbVbo5qi1mlJcslKF9K9iSSXBi8njTxDOWgyHhAjEZEAqGiyAk0xodM4OTavL+LQzt9RNfje9+cRC06fM5X3hyXp7Tv2Zte//ZIMl+XcaV3wvAHrxLQ3FrgIU+UwdOboB0eyvW+fDtQ/piSzbLz7Bb7USp812sHb4cZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiKaXAay; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiKaXAay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770954114; x=1802490114;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=7zSAstQthB/xL2kmB2inZwMABtOPVspBEwCZS6BGYgU=;
  b=OiKaXAayzsMaUFtGpzKJ/pM94acf1ihjpMBl3Eaqgl6iE9+XFiVFQYRf
   SMZ0z4c8GcmOXkHonnB1EfNvMKtLScWbQwOvVrUJ6tdpsEB4/QBt9OqZb
   exC8Muu02OBF0U8F1YK1efowoMHbvytXDJY0cw3h763VMpmcZRVGiGpQo
   xoSlWrDdhk7/rOJpN2HOCZb3hjrq6112A70nacvX/RmCb6F1DVsD1a1ak
   +A4IEw8pLByPc0G7qlVrTe4XgQpvVxNzLOZYHOj2de6x1SgGMddU83zTo
   TsP6s/hDtGuBKiNWLlrUX5cbw4EIVzwStmcsiOuMp5AZCb2VO8OcfwQxr
   w==;
X-CSE-ConnectionGUID: Iozx1m9zQmysymeNxP32Ow==
X-CSE-MsgGUID: c6YyRsY6T4m7mSorz6zuIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83580733"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="83580733"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 19:41:53 -0800
X-CSE-ConnectionGUID: GGHR0+NbRhOWs0r6igUzRw==
X-CSE-MsgGUID: 6+TLW1s2RDOBheNBqywijw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="216973447"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 19:41:53 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 19:41:52 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 19:41:52 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 19:41:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og4kVEFOCM/e9bFyW4Ik6yH7Wzdd01rDWglTIMyvS6zaKfvOCx7sBhOZSHJI5W7QsoiGQX+t9u7Fh4ZVoYA2YmSj80Ov5oKUDAmVhLc33ab1fI7cc5FDKP8BOM7c2o/JuJF/RD3zm+felXDYgOl3/4PwEbSIjJM1vLlr8zw77rEg+L62mzNKMyeqLtoV5RI6z9PXS+9tdRTkKiKoeFs1ove6Sk3afe+SFWEbAh926F7ODeSjhslycdKGbsf6WWCJSWXAhRfJrGSJQU587QyUC87RGceKn8/FbLXKgCGak09qb7wpHIFyfOgiLyOF+EwTNJm69mimy7bPaeqPI5ehzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGE2iHqfhK8EptO0mk/9KRbJR+qqpVeR8+ZI+psbHyI=;
 b=Dc2qLZoK00y0EyLROgNhroHw1FOg1jOaZofF0LelQ0Bk+uFLysKst5tUzvSFJ+LGUOMvu+K78TPCDRhMx5HG/+0uhXWcMs8uEDt0nKDkb3xCRgQbs++iGiW2RtfvcZvmMwNs2O989rVeMnr2TDsSZGN+4L30X+BrwAL2ymsY1hj2MfNDsD+SH1U2JocJHlcPL5CAaYLOZz/nUeU+nPz5bTPqNszIGEHRURWn94VePPK2UT3KZJVNdW3njGaoArPXl64GX08zZ8oRkKMPKBn2jH52SZawXHrdYVP+JZVqTi+vyQYpjJulc6r+f/EZq3hezMXqbzsRKKFYAkqTXtM/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYYPR11MB8385.namprd11.prod.outlook.com (2603:10b6:930:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 03:41:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 03:41:50 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 12 Feb 2026 19:41:48 -0800
To: Keith Busch <kbusch@meta.com>, <linux-pci@vger.kernel.org>,
	<helgaas@kernel.org>, <alex@shazbot.org>, <dan.j.williams@intel.com>
CC: <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>
Message-ID: <698e9d7c656da_2f4a100f3@dwillia2-mobl4.notmuch>
In-Reply-To: <20260212224112.1913980-4-kbusch@meta.com>
References: <20260212224112.1913980-1-kbusch@meta.com>
 <20260212224112.1913980-4-kbusch@meta.com>
Subject: Re: [PATCHv4 3/3] pci: make reset_subordinate hotplug safe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:a03:100::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYYPR11MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c40833-ea1b-4bd9-8847-08de6ab1d1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M25nTlJlRVNtMEgyTnR6VktqbDJESlNPalY2aVVrdzZ5NWl1dUxWbitxTCt2?=
 =?utf-8?B?aVhsUDhNVTNSRWZ1MlRUV2lpcWk4S0tDRlRzMERwNnZIYjJFeWREWTB3ZlhG?=
 =?utf-8?B?NU5ZODlraGoyVFk4YXlEZFFnSm00VkRZT29Gc1hUdEFkcENNcmdOWXhKVHpM?=
 =?utf-8?B?MC9uVnhPSmxEclc2RkZva3I3Tk9ETEJnbXBDckQ3K0tSTWFaMEkrSlpBNjFI?=
 =?utf-8?B?SmtYVUNJYmdDekVBT3BSeThDQ1FLZ2x5VVgxcHIxeDJCQmNpUGFrc1NUck1G?=
 =?utf-8?B?M0dYM1hSVTZVTUVubFovejBOcWZEMnRxcVQ5WFlBNjJWcnh6bjByaXpoVDEz?=
 =?utf-8?B?dTQxVU1yUW94R2xtWFplSHJxd2N6eU1yVEQwOUR2dTBMNG9nV09Idk5HRU9i?=
 =?utf-8?B?cUw0ZDJHdHZ0cS9NZnNjb3Irc1VoM3Y4L1ViRGxWbytMZjFaMjdtSlJWc0Fu?=
 =?utf-8?B?UmE2V0FGQ1VvRm1lUTNjQ3gvb0hOSUVVYlcwSWhHQy9DUm1uSnhkaHEwN1Z4?=
 =?utf-8?B?SzNYV2UrOTRSVWdVQ0VhYm95QlU2SlJHdDcxbVRyZnVYNGFFcjhZWkxRUVdt?=
 =?utf-8?B?UGM5NExTMFNNUHFPdnliNklpVG9yZUZCemNaU2oxZHNSbHlGTjhocFVydVFj?=
 =?utf-8?B?UkZ4ZGRweGNIK3hPUHBhTmJzbmkrTXZaMWgvU3dXbTF2SCtPMHpNTTVpQ09J?=
 =?utf-8?B?WjZRN0pDQSs1cktLZnd6czdhSTdvcUowTmVxVWNyVGhNT2NZM3VRdXlHYjhz?=
 =?utf-8?B?VkJyOCtZVUlnWGh3QkdiNXh2em9mQjRKTHhscUFmVllGM1UrdGVQcEIxcWVp?=
 =?utf-8?B?enZIenNVTks1cE5qNTIwTlkvaWdJSUJaVnYzbiswZHZkOWFsYVFmREs0RVN6?=
 =?utf-8?B?aUFlRFBOVTUwM2h1dVJ6aDQzMFZ1YUFGSDJQRDZHQjdwZnVieWhHME5JNDhk?=
 =?utf-8?B?UTB4MkRBTFEwWUlUK0hvUklFZnZHQmQybURMWVRnWE9WaG5kc1lOTjZDM2FT?=
 =?utf-8?B?T0dYOXlaWHdlN1FpTXlJNGlNZnVFVzl5Z0R0ODY4T0FGTW1VSDBsYml2eStO?=
 =?utf-8?B?dXErb0NnSFc2UWdRRUFEOFZJRlJKT3VwYmdBaXNxRGhVTlNCVUJOamthYmZi?=
 =?utf-8?B?OGdrMnozeFNiL1IrUVV2Y3kvRXhyVTlKVnZGMGtFclF2SWdJWHdEeGc0N3hU?=
 =?utf-8?B?TEJUS05aUTFPd3AxSFVkWTMweVdtNEVZM2N6ODBkRE91UWxyNm1pd0J4bVM5?=
 =?utf-8?B?eVFKSlEwbUtlYnN4RVhnQkoxcWhGcXRSZlVjcmh3NUtwMjFNZHhqVjNkYVNT?=
 =?utf-8?B?VkxvVXBWbXRueFd3TmJpeWxwemllTWdlWE56VlNlbnphSnFYRm5LdXhKOVZj?=
 =?utf-8?B?K1dBYkVLZTZoZnNPN2VhMDg2ZWNRdWp5anRSNDVPMGxneFkyS0N3eFRBZDg5?=
 =?utf-8?B?RS9uR2dUKzZwZnJaeHVpdytpWHZ2THptOFhQeW4zWk5xTGRodkdUWlNMUU5M?=
 =?utf-8?B?NldVa2dWLzA1bEdyMFFiUkxNbUhlYm02Ym9yQ0crZlRYNmt3WFVaWTJkSjZp?=
 =?utf-8?B?TXFJeU9BdlhMck9ubnZUSFkxeklXWEJFeTMrSXhUY05wQ01jSVROeis4dHkz?=
 =?utf-8?B?OVVxdWpGbU55Ym5XMEw2S3p2ejFwWFc4c1J3eUtDR0p0V0RQb2JEVmljelNE?=
 =?utf-8?B?NTRUc3FKSXREc2dBWlQ3MGlqcldrMXlhRTBKaUtrZFg2WXNLQlhrTWlRMjlv?=
 =?utf-8?B?NFU3TzlBUGhzMlhrM1JMMStqZnpacVp1SlR5bERqVDRSUGRWdzJ2NU50L1FB?=
 =?utf-8?B?UUJLMXE5OUZFaTMxL0t6M3djNGoraFh3d1FVa25sQWkraVpCZTh1dlB2MStI?=
 =?utf-8?B?OTY1RG1wdTlwbkEzenptTDd1bVhhQXN3bDdZbTZLcURmQXVLM0g0N1pGSTFZ?=
 =?utf-8?B?OEIxZmN5ZHlBK0J1a3g1c2pRNXZZQXFaMFNEeDBDZjhzaThVTnMxaDRWRmVq?=
 =?utf-8?B?NElFdHZBeXF5eWJEbHRQcHA0TmVaZGpXVytFY1hZZEJiY2dNeU9jUHNKVnl0?=
 =?utf-8?B?dVl4dWhFU0lWbTBHeUNwMG5IYjR1VTNOK2lzYWcvbDF2SmtlUHhWd3p0aEFr?=
 =?utf-8?Q?pIrc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTdRWDdKenRPQlpaQ1dMQk5HbHYyMWNueGRIVXlid3RObG5VOVI1aWJYemRP?=
 =?utf-8?B?WDlUV25EOFdDVUJyWnpqcDNlT2tjREhKaE1ZRDNDTHhxaXF1Q1RMbmhhd1F5?=
 =?utf-8?B?MjlpTU8zK1hHS09Dc3RqN2QvcG1TNUVJakJMSTArV1JNbWxVbUF6SjJjb1Rn?=
 =?utf-8?B?ZWhneGRSWkZHd1JYZnNUWGJMRysyRlUreEpVVTYyRk0wazh1dnZpam9zY25S?=
 =?utf-8?B?clg5NkI2cFhlNnp6SmtRb3ljZlFqaWNFTDg0OEVKTi9tUFJUQ1B1QzdxK1Fa?=
 =?utf-8?B?aTJnaHhCU1kyUDNsMlpqWXNlMXNPSFk1NFl0Z3NRclJQYy94c1AxZVdzZkJD?=
 =?utf-8?B?TFRLMEJuR1VlQTB6cHkwSENYeklXaG5Qek14MTliQmRWZkRleHVtR3o3M3U1?=
 =?utf-8?B?M3MvcmllKzZoZUYwYmZKZUtVTGJNR01QQzRxVEdVdCtoYjRyT2wxbXFCU2pQ?=
 =?utf-8?B?TTlqR2Q0Q1R4TzNvbnh6TUpaNFE3UmJTeENodHdiY21Lemc2QXJsNDQvQWp1?=
 =?utf-8?B?UVlrc2lxc05IU0JyalRzaldiVUw5WUFjSXNibkhOdFhnKzhGSnFLQ1JPVUt4?=
 =?utf-8?B?YXVCMjlETmZGSEVGZTNRWnF4cDVnWkF1VXk1OXRmZXBLeFRLUmwrUDB5WXpl?=
 =?utf-8?B?YkFsQVdVbXR0U0UwaEpBbW52a2c5dWora0RTQzJ1MXBqSVUwZXQ3R0toSExQ?=
 =?utf-8?B?MTBkb3YxMWVlSGRIYWZEbzE2TWdRZysxMmREeUVZMFNJZU9vQ3E3c05uWFlv?=
 =?utf-8?B?c3RWVzV5M1JLYUhrb3Q1WHRYUTJUVTM2L3dIeWVSaWc1ekswL0Z5blRXb2J6?=
 =?utf-8?B?ZUh0cko3ZlkvVDlJN3VsdzJBT2hSeHJhUE9CeUJKZmJMMDZIYTIrN1U2aTZp?=
 =?utf-8?B?TnNPRTV5Tngwcm1RSjd0cWtmUmlQZ3I2d2hOV1gvTHdEMWg2Y0cvQk5GYzZl?=
 =?utf-8?B?N2VxSkxvQVRzQlVPbC8yUmx2ZDZJVUh0aTd3MkhWWGVnMGdqejVyT3AyWmJY?=
 =?utf-8?B?Zzc4VHFqRVlXVEQzSWZKaEV1K3daQTdKODlhUFk4dUwrRndnVExJbmttQ1ow?=
 =?utf-8?B?ZzQyRWpmR3BuTTd0ckcxTXlqRmViMTg0L2E2NVYyK1VqZU5EYi8yaVhJZ3pw?=
 =?utf-8?B?enpKcVoySFB5RVdwb28rMFdBZk1vdENWbUhQRWp3L1E4bXVKV29RendsdGZ3?=
 =?utf-8?B?N3ZGN1FMaHRtT3BKQVpmRGRoR2VhWGEwVEdnUEVJUGNzTStDelBRaTdHTjV1?=
 =?utf-8?B?bHZGR2Z5aFBENURFZ1NGRU9KUE9JQVFuRnYyVkFva2NqODlrOGtqS1E4dWlT?=
 =?utf-8?B?LzhxaUNPOWY2STlMb2ppT3RGT0hvT1E4UGcwLzlwTEpzR3FzUHJJV3RrSmZN?=
 =?utf-8?B?bWpoMTlDTDFBWEt2OVIzMmNTNGRkSHZRL0t1Y1VVeTNjbnJZWjIvQ2xsSjc3?=
 =?utf-8?B?VVg0YnBiU1BJRys5QUFzVG9GU29DcU9ZdVhXdk9TbUQwQVJTeS83M3hVbnpK?=
 =?utf-8?B?c0taanVwZVRWOVV6TkFqSGlweGdPaEF3Z1lZbUJTeVd6L2ZpdXNoeEJPTVFa?=
 =?utf-8?B?d1RXZ2loYSs4bndkWHJjdk9wdyt5d1creUhzVTYxTjhqZjlva1hqelRLNWVr?=
 =?utf-8?B?REx3bzNNQllNbkNUZlZNU3VvTHZSUEZzNGxXQUo4V2ErVTRVdmtIZGxUdEVy?=
 =?utf-8?B?UTBYNXpYNUdaUXdzczRwSVIxZWNMVThTYmNZeVVYeXRBOC90QjlZOVpvMkpx?=
 =?utf-8?B?RDkzSDRrOGNEelRZcUdUWDJVRWJJd2FvODhoeDhkYjFiaFhNTkE1N1haLzBx?=
 =?utf-8?B?bEtjYkZSUjhQMTNZS0Y0MG9UZ1JtMktDVTlINmYwTUh5bFNOak00NWxZbGJQ?=
 =?utf-8?B?eEtIeEpFUjhHKy82Nml4SHBuaEx4VThQTWlVRmpEVXFIYjlYZlJXVGZOdXJ3?=
 =?utf-8?B?aDJVdVRNU0RJRzJSUzEwdTdZZ3ExNlZCNXMvOEptNmE1QXozbEFtTmEyMGdM?=
 =?utf-8?B?NE9CMDAxOHZZc3BlVVZ5VE1uYUZ1b2RYTHJMNkNsek1jZ1FaVHJrQmVheDJx?=
 =?utf-8?B?ZmlJakw0dUxsamhXbytXQlh4Nkh2c0RRNHZ4aE9WRFkrbm5WcjNZaVg1MDFS?=
 =?utf-8?B?RDl0SWhyNlhEYkxMVGRmeDF4blU3dEU4MGpWQ1JCWXBSWjJVNC9SK1NrejRV?=
 =?utf-8?B?VTdKOHlsOGNHWHB1ZUZMRkhiQXJZbWc5dm01c3Y3Ymxwb2dBakJUeHBqTlcy?=
 =?utf-8?B?ajVrc2p3bzdnLzVhRzBQUlVjSlpYM2lQTjdZOXVDMjhvQURjWGJnWXBpemVU?=
 =?utf-8?B?bW56a1dENjh6MDZkU3JqVnVtd3VCbytZZ3F4bHNBN1RiQTdUeEc1N3UzMzBG?=
 =?utf-8?Q?QAj2MhzS2huoqYco=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c40833-ea1b-4bd9-8847-08de6ab1d1f6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 03:41:49.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNaALNB8GBz+SMyJlK9Rcz1rY5yx15+OCsj+b19XoLZiMht/hUADyAP3JwLzF6OVujgtwo77I5rm6KvtDvD8Kp1DU9T4eOsvKJ2h9BRXd+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8385
X-OriginatorOrg: intel.com

Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Use the slot reset method when resetting the bridge if the bus contains
> hot plug slots. This fixes spurious hot plug events that are triggered
> by the secondary bus reset that bypasses the slot's detection disabling.

Did you want to copy that useful error report with the GHES details etc
from http://lore.kernel.org/20260205212533.1512153-4-kbusch@meta.com? I
thought it was useful to clarify this can fix panics.

>   # echo 1 > /sys/bus/pci/devices/0000:50:01.0/reset_subordinate
> 
> Prior to this patch, an example kernel message may show something like:
> 
>   pcieport 0000:50:01.0: pciehp: Slot(40): Link Down
> 
> With this change, the pciehp driver ignores the link event during the
> reset, so may show this message instead:
> 
>   pcieport 0000:50:01.0: pciehp: Slot(40): Link Down/Up ignored
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
[..]
> @@ -5670,6 +5648,58 @@ int pci_try_reset_bus(struct pci_bus *bus)
>  	return rc;
>  }
>  
> +/**
> + * pci_reset_bridge - reset a bridge's subordinate bus
> + * @bridge: bridge that connects to the bus to reset
> + * @restore: true if affected device states need to be restored after the reset

Maybe be more explicit and say:

@restore: when true use a reset method that invokes pci_dev_restore() post reset

...because pci_dev_restore() does a little bit more than just state
restoration.

With or without those minor fixups:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
