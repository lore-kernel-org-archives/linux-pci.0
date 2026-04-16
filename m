Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FF39DBE9;
	Thu, 16 Apr 2026 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333999; cv=fail; b=oyWRhKMov00MsfFJUi9xkzvgf4fhQ0GX+xL02c6fAMQdzOoDgaU93KI+qdflmJroOryZi1A/H4vZj1oz2Qf9G0mncrWQOWqDYghncGLf6Z7LJonI+O0IR5uUu4R9cxZfx/lrsUHcixMygpszUAewTl01QgKwuuGlEpTux5sbEUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333999; c=relaxed/simple;
	bh=QkxosdVTFaIzf8GKHx+uzc+K/UD35P80WaW8SBZr2Dw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tBgE29t974ce3aJz8mrO7k0zfPZnbEMdoOdVK9pqv0Dfe5yQiktXckT//Y/8j9rxW6NqHy6crgXey0zMlnHIn/oWfHgvZ65JqxC1yk1BshvFneySElsMwjkdG+5bclBB7LdejHQ/5kPzmcB9qwyKe0LVpGyNinSl5PCX7CbQTXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLgNovZh; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLgNovZh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776333995; x=1807869995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QkxosdVTFaIzf8GKHx+uzc+K/UD35P80WaW8SBZr2Dw=;
  b=VLgNovZhPqy5EtgfSdjD2r3Hzft643wRK+OLr1/hUoje6M4W2tPeJr6u
   rHyoDbOXl6+ADOmzXCJezqe14/MwiTKmx5TbpGYa8SYdFTrSllgf7xp8I
   uuXjp0OoDtmSZ2nDKtNvSx4D+UoM5d4Bn+lebHaGCOZY+Uskqr4Jn/ta1
   nFShSvS7DLR2xQqjhBdciZKWH+Ba3rts+SdHPwGQczhRIpa96dpqNlS16
   84zMKUb6WTskMEZgF5OGclgn63bCHuZD7z+F5RV4rw/ZTshYrWcswPYXQ
   d3nv9Y+VGidXGjdFiLqKzcQaaHL15UD01JC+Zqk6usIffLA4Bx4MSunh1
   A==;
X-CSE-ConnectionGUID: 96paGpzBSROx9X2oP3NX5g==
X-CSE-MsgGUID: poH8ltUDRtSkHlyBBlog/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="88779089"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="88779089"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 03:06:34 -0700
X-CSE-ConnectionGUID: g1qr1RYdRuyxLiYmM2v7uQ==
X-CSE-MsgGUID: PPJteO08TJ6jDTdz3JsM6g==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 03:06:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 03:06:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 03:06:33 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 03:06:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6JAp0t+pwgbsCwrpFrhQVXz8NQHpuu6SKuZpvx9B8Bn+uB4kjW2bq1gPOuk+ytoV74qvp1jkU+WLYeuP9E7g6414Vg3Ocg5OxiJGI1dYPHcFkQvNnhNbnWTL9N0NsDwPJV3kAH8wnuo8qKXvMVGnSEQuRkfClM5Rb9SV+XT3uixbKrH9Cb4knPMkQFnlwC/X9L9utYG90E50zdYbGC72y/P6WeY8EHbvXV1TBG46JJqkcPuevkLvJmCZdD4D29r1QxvYasEAAop5S5I+6QklusRWr86eSmq/voY0sFlb31oUeWkbKdw7qsIZiWHcllMKyveRepoD/aY0Pa7PlUJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkxosdVTFaIzf8GKHx+uzc+K/UD35P80WaW8SBZr2Dw=;
 b=V5BAQYJ9tM0AepJ61uyyigwn1hyB/xdW6x5K6/x76TzXvHvEucgH8zrcCk7Qyz9lxeZTl6bzB46Qk+AFa61WJPhB/yYI3seplcKm3Vr2xUASjksGniWVlRwYqdBA3XwmUS5aU8qY4DDY33QjVBFCua6C/bzbPo/7I90EU/JJx6LwiMfIAi8nVv0J/337REXct2MiddWMpuUNwN8DCdf6Ooh/F3z4dCtl1TE+l6j+rXViAipmbrndt7HxBPSbKciIHJqhwQC3Wa6DPHv7+lBaIlML9hdU5Zg6+vD2aMotLFY4v6zVW5WFDhU1sGFLBHkvGicLLTfyLl+JYvm75CceRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9016.namprd11.prod.outlook.com (2603:10b6:208:582::17)
 by DS7PR11MB8784.namprd11.prod.outlook.com (2603:10b6:8:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 10:06:30 +0000
Received: from IA3PR11MB9016.namprd11.prod.outlook.com
 ([fe80::bb82:7df8:d6c5:5ce0]) by IA3PR11MB9016.namprd11.prod.outlook.com
 ([fe80::bb82:7df8:d6c5:5ce0%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 10:06:30 +0000
From: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "Srivatsa, Ravishankar"
	<ravishankar.srivatsa@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>, lkp <lkp@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel_pcie: Fix build error when
 CONFIG_ACPI is disabled
Thread-Topic: [PATCH v1] Bluetooth: btintel_pcie: Fix build error when
 CONFIG_ACPI is disabled
Thread-Index: AQHczWbpPQsYbLlvu02rZj/omejQ/LXhU80AgAAhrPA=
Date: Thu, 16 Apr 2026 10:06:30 +0000
Message-ID: <IA3PR11MB901655768176563735284629FC232@IA3PR11MB9016.namprd11.prod.outlook.com>
References: <20260416060352.1392139-1-chandrashekar.devegowda@intel.com>
 <8ae5fb2c-7066-4a1b-9798-020ea3290df8@molgen.mpg.de>
In-Reply-To: <8ae5fb2c-7066-4a1b-9798-020ea3290df8@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9016:EE_|DS7PR11MB8784:EE_
x-ms-office365-filtering-correlation-id: 7523969f-1e0a-4922-d43b-08de9b9fd4ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: tf9Pd5DA74cLnb8GUi9rgA+B7c+rIzS2h37vMojfSNPiUon5yJkLulL/fnqcadj/VTHrzfq36L9mpiZZl2yOUcv6N/8VosHhNLDdOfsbDMT0gV1kfsimTGtQ1Y6Omn1GI6UWj/7Vhmj11H5A5Zj47GM8zrofSn4dEVxhfPY7lim0y27q+hNXBaUc9Epr+D+jdtteE2mwhRCjQ5dntO8KSD9+FT7ZofCsWcxaRZgca9sctdaFvt0Qp+VpLg317HZFQ0mZbk7S22d4bBtgVoKuVOOmJRcnErmfMiaEOmJnEmmBOQNtveF940EQHMHcRDHBrostKvjfdMG8CCkPusxYgdj4lz7w1bsQmAX1O4fxxN0zaZi1b7C+ipnbq1PDGfVzLWgdNjGrOHnuUF5NNuqzkl8IfPjsu9UZrS/zTSB84LtJN3yAl6hzTeQyj6XIHEfdQwhacZiBTxPwHDzTYmL+PfiUCALQ4tWCXU6mlvtTrSUrsrcJVJArLHNCGIrq4R3FSvHygpoFOAT70ZlNjp5fjOZP2xqtbLFc1sKTLdrOTmbhFWPjhj5nzuwIDpbpN0X4HWPpfhBcC7BMYCAcBsF8Vn2LlqM6FDDyvDxMw+7bGrHYIdtedG0mrVHt9iYsf+YXKMZtDxSXKxXwH5wyLZdR+g0TzmTH/RTg0I5zqySiR2SO6TjVu9N/LL7HbD0x9KlTl0LGssUwwcRME8b+ZK00IXGAjOA75qFp0vHjaNSeOnqhQunVIcZBtnF2XwhjVVrb0dIkRducCvcTFmXebgEKYzZySKPAz3SObUSBCJgd7yA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9016.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXgxSzViMUY4VGdicGE5ZUhBdURtKzlQai9PUGRTQjhwbkJadEdMN2ZTQzhv?=
 =?utf-8?B?RDAxeE0rK01JVStWSGZRUkdXTUplRmpXQUYwOW84Z2x3eThFU2hIVFNKWThr?=
 =?utf-8?B?OFUyNmN4QkQ0V09SZ2VUMlI0VittMUc1b0FmK2trNUNJVHRHem81VHBHSklj?=
 =?utf-8?B?VzByaHJkanpJK0Q3Q1I4MXZiajV3RUt2RUlrNEYyTVNjNDFpdEpOcnlVS3BV?=
 =?utf-8?B?cFl2Wm9RZTQ4TlJ2bVBUR0ZhbTJkTU1xaTZ3QWNqN3pENU5DcGY5cWNtNFl4?=
 =?utf-8?B?RkJwSmVhZVdlckJmUmZUdnNrRFNlZ2kzbUdiRnV0dkR6NWxLMUgybEZkWFN3?=
 =?utf-8?B?NWdvYUZaWWUrMXZ3ekVNQlB3aDE2WEhDL2VqS1VOTEQ2SlhiTkd4NXhWT2V3?=
 =?utf-8?B?UHhkU2xTVnFNTnVEaHVEblltbzBqMGlTQ0JMYklya3hBbkR0czBZMmh5azBP?=
 =?utf-8?B?N1BUS3puNVdUTzBkTVc0V1hYUUM5S3cvVUFSTXZTOU9uTEpkdFM1WTBXNWVZ?=
 =?utf-8?B?S25YMS93THdaY1p6RUg1WFdPQ1c0UEpzSXo1dENOd2g3K01oR2pCMDlLV3di?=
 =?utf-8?B?RjBYbkZxVE05ZWp4Z1hKZUZQWTM0TTA1Y3FOQ0NkMXNKM0lHZzgyeDVoK2pZ?=
 =?utf-8?B?UGJnQ0lvU2NuaGhJTjlROUJXdUZ4TUJpMTVCVk1WeG9xSnU2MFQ0QjBFSkxI?=
 =?utf-8?B?RFkzTmJLM2VjeUgxVXlKb1RyRVpZZDFaeWxiSVdleG1UQzJiVVhJKzlOZDhB?=
 =?utf-8?B?SWJhTlBGRTY1YndtSFpmTllheUt5dEhiWnduaVNLUUdnRmwwQkpUdmZiUk1q?=
 =?utf-8?B?eHU3aDNHb2tKb3RKSHNFaitSWkVOejdiK3hwdU9RNkRIQVFOZEtJenpETy9p?=
 =?utf-8?B?NS9Eckd5OTNzdHlpZzZKaHJDNUNNUTFYWEtwUXVpSzNUUmRnWG0rTHlBb1lm?=
 =?utf-8?B?dE5zd0trd1d2Um1jTlhCQVg1bysyL0Y5c3ZRWlhhcXVZeDVYc3RrYUZLekR0?=
 =?utf-8?B?aXZBQmY4QWs3UTN1Yjc0aUkrZ2UzbkVZT2hlZWQ1andRS1d2TlJPaE1mS0ti?=
 =?utf-8?B?ajdKQ28vTEwrUXdKTnZIQktFcUNCM2Y3TklvUExEeGlaR1c4T1lQVU93Umgv?=
 =?utf-8?B?V2pqZE5yQnh3R3F5OGROTVFHT3hRS2E2RldMcGVwRnZ5ZnRTbUFYUmc3d3Ar?=
 =?utf-8?B?N2ladDBBVFhVa1N3WnAvazRLY204NXJxVnVNVFQ5c1JWUlB5UjVYYUZKSlpU?=
 =?utf-8?B?N3UyTWlNaE9MU0Y0QkNVbFVTMytjUnFrK0tWSWJlbmJnY1c1WnVtcTZzaU53?=
 =?utf-8?B?TkdZYnFTZW1RcHRWeFZGb2dSRFoxUkJUWmhYTnorVG52cGNWTmlHSmt0UGxt?=
 =?utf-8?B?b2ZlU25Nc2RyNjdkNmN0WHJCSWxhWXVDMk9lb3JCbzMvcytpK2owVEVQZ01L?=
 =?utf-8?B?ajJSKysvOU0zTmNqQWNxVlJKVVR0ajkydkZselBSRGZQRGNpUndKN0NaYmIx?=
 =?utf-8?B?Y2FhYWdtdmFnRng2ai9HR1BPUmJzSHZTeGltY05JVHNhK0NrTGZoTmRpcHUy?=
 =?utf-8?B?WEJRUU9FYXVtQThNWWxGWGg4a3BpOHQwZzBMc1ZLY2hkcGpmMzk1clBnbHRU?=
 =?utf-8?B?MmZQMTVaVlh1amFFT09zNHJvcTA3c3U0SGZITWRHdXlnVFl3ZEdBU3NVSGRm?=
 =?utf-8?B?UStNTU1tK2ZkVWFTWitBaW1OaEtTZDRrLzhNU2RBbjZBVUY1SEtqY3pONXV3?=
 =?utf-8?B?czdPU3RUNHBhNjZQb1dUdlpjdGVWZ3RyMktrQ1VWbm43a1o1aFE1V2xXUW5u?=
 =?utf-8?B?Zy85MUFxRkVZOVBIclJ5bWpJbUxHNW5nN0JMSzRmK2t6SVJoWEErY3R5Q3dX?=
 =?utf-8?B?a0ttM3ZadkZOQ2xLMkMyZ2diZ25zSVhtaDBuTlJlek8yOXh5SG5NaG9idldK?=
 =?utf-8?B?SG1qbDFyM0JPR2ZiSnFHMU8ydVhVZkgrQWlvWndTRHRvWTB5UWQ3VjB2bkpq?=
 =?utf-8?B?dURjdUwrMmpTcldXenJ5bjZRM0h6VGQxckVqUTV6Ky9EWDZvbFdheDhlZkFZ?=
 =?utf-8?B?T0FhQmhRUjF5QkZwRklibGRZWlVPMllnZkFuL0x0YXhMbGhNczV0UVRBU014?=
 =?utf-8?B?NXVSSHd5d3p5dkpOcGpreTNHalRLc1BteXhva1FCWE9icXhDRnFlWEhPRnA4?=
 =?utf-8?B?RnRjWmNaaTdSS1NWTTZ4RWtZZ0tUNHNSczFjdW1vejZkRkN3UWNRczdZSkJU?=
 =?utf-8?B?SnZYNzFuQWEzUTFzOFFLY0NBTDlma1lYT1ZGWTk3dTRCaWlnb2NONnVBckJT?=
 =?utf-8?B?MmVvRDRFanpLUWowVDVxeDdvdkQyemFQL3NqZHIzOUkxS01od2dJN1NrNUJo?=
 =?utf-8?Q?a7YKWu811AdamEu8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lrF8FgVdwwmpWbpe8telwSsom3mec/Udu3JxtfT8KDs/L5PxFtCip+SRO/PGntoePF66Xt73Rejm5DS/JZyMr3hm/TS/High2GoF7kDG5t3IX9S3WXfrubVJvT+3lwrs7q/r6BwKlJlPNjNiHmJ2lNK4G8wcELTXSArxj61xKxst05MF7+pV920Zgo4EpCS+POLGMkx2RRWlIM4qBb91/ELNyoGm9S6Rp4jtKX16FvShXZTGTgjSqlAlFbNgBgprdVNsH6GorWdd/y1WonpYuYqfJ6U1qphhBCF4k+um1ZM6ZX/Ct6wv+i9wxw7ZRPe5OfnMLMR80WhyhHhLfFpLGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9016.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7523969f-1e0a-4922-d43b-08de9b9fd4ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 10:06:30.5152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qhh7E+WfLJ6kUbt3VjYpGDUVA/SRLfDYNxCH4dc6nOumfTPlonzgGRSuo/G0f62aD/lOt6gzlGOkhqsjLlZ39aOrJ7HqupfF20MDll68FFY7KYTP/BNFHS6VOoV+fiPV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8784
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCiAgICBUaGFua3MgZm9yIHRoZSBjb21tZW50cw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+
DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxNiwgMjAyNiAxOjMyIFBNDQo+IFRvOiBEZXZlZ293
ZGEsIENoYW5kcmFzaGVrYXIgPGNoYW5kcmFzaGVrYXIuZGV2ZWdvd2RhQGludGVsLmNvbT4NCj4g
Q2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IFNyaXZhdHNhLCBSYXZpc2hhbmthcg0KPiA8
cmF2aXNoYW5rYXIuc3JpdmF0c2FAaW50ZWwuY29tPjsgVHVta3VyIE5hcmF5YW4sIENoZXRoYW4N
Cj4gPGNoZXRoYW4udHVta3VyLm5hcmF5YW5AaW50ZWwuY29tPjsgbGtwIDxsa3BAaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBCbHVldG9vdGg6IGJ0aW50ZWxfcGNpZTogRml4
IGJ1aWxkIGVycm9yIHdoZW4NCj4gQ09ORklHX0FDUEkgaXMgZGlzYWJsZWQNCj4gDQo+IERlYXIg
Q2hhbmRyYXNoZWthciwNCj4gDQo+IA0KPiBBbSAxNi4wNC4yNiB1bSAwODowMyBzY2hyaWViIENo
YW5kcmFzaGVrYXIgRGV2ZWdvd2RhOg0KPiA+IGJ0aW50ZWxfcGNpZV9hY3BpX3Jlc2V0X21ldGhv
ZCgpIHVzZXMgQUNQSSBBUElzIHN1Y2ggYXMNCj4gPiBhY3BpX2V2YWx1YXRlX29iamVjdCgpIGFu
ZCBhY3BpX2hhc19tZXRob2QoKSB3aGljaCBhcmUgbm90IGF2YWlsYWJsZQ0KPiA+IHdoZW4gQ09O
RklHX0FDUEkgaXMgZGlzYWJsZWQsIGNhdXNpbmcgYnVpbGQgZXJyb3JzIG9uIGFyY2hpdGVjdHVy
ZXMNCj4gPiBsaWtlIHBwYzY0bGUgdGhhdCBsYWNrIEFDUEkgc3VwcG9ydC4NCj4gPg0KPiA+IEd1
YXJkIGJ0aW50ZWxfcGNpZV9hY3BpX3Jlc2V0X21ldGhvZCgpIHdpdGggSVNfRU5BQkxFRChDT05G
SUdfQUNQSSkNCj4gPiBhbmQgcHJvdmlkZSBhIHN0dWIgcmV0dXJuaW5nIC1FTk9ERVYgd2hlbiBB
Q1BJIGlzIG5vdCBlbmFibGVkLg0KPiA+DQo+ID4gRml4ZXM6IDkxMmE0OTlhNzk1NSAoIkJsdWV0
b290aDogYnRpbnRlbF9wY2llOiBTdXBwb3J0IFByb2R1Y3QgbGV2ZWwNCj4gPiByZXNldCIpDQo+
ID4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IENoYW5kcmFzaGVrYXIgRGV2ZWdvd2RhDQo+ID4gPGNoYW5kcmFzaGVrYXIu
ZGV2ZWdvd2RhQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0
aW50ZWxfcGNpZS5jIHwgNyArKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9w
Y2llLmMNCj4gPiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+ID4gaW5kZXgg
MDc2YmViNDVjNDEwLi40ZDEzNmZmMzQyYjggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ibHVl
dG9vdGgvYnRpbnRlbF9wY2llLmMNCj4gPiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVs
X3BjaWUuYw0KPiA+IEBAIC0yMjgwLDYgKzIyODAsNyBAQCBzdGF0aWMgdm9pZA0KPiBidGludGVs
X3BjaWVfaW5jX3JlY292ZXJ5X2NvdW50KHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPiA+ICAgc3Rh
dGljIGludCBidGludGVsX3BjaWVfc2V0dXBfaGRldihzdHJ1Y3QgYnRpbnRlbF9wY2llX2RhdGEg
KmRhdGEpOw0KPiA+ICAgc3RhdGljIHZvaWQgYnRpbnRlbF9wY2llX3Jlc2V0KHN0cnVjdCBoY2lf
ZGV2ICpoZGV2KTsNCj4gPg0KPiA+ICsjaWYgSVNfRU5BQkxFRChDT05GSUdfQUNQSSkNCj4gPiAg
IHN0YXRpYyBpbnQgYnRpbnRlbF9wY2llX2FjcGlfcmVzZXRfbWV0aG9kKHN0cnVjdCBidGludGVs
X3BjaWVfZGF0YSAqZGF0YSkNCj4gPiAgIHsNCj4gPiAgIAl1bmlvbiBhY3BpX29iamVjdCAqb2Jq
LCBhcmd2NDsNCj4gPiBAQCAtMjMzMyw2ICsyMzM0LDEyIEBAIHN0YXRpYyBpbnQgYnRpbnRlbF9w
Y2llX2FjcGlfcmVzZXRfbWV0aG9kKHN0cnVjdA0KPiBidGludGVsX3BjaWVfZGF0YSAqZGF0YSkN
Cj4gPiAgIAlwY2lfZGV2X3VubG9jayhkYXRhLT5wZGV2KTsNCj4gPiAgIAlyZXR1cm4gcmV0Ow0K
PiA+ICAgfQ0KPiA+ICsjZWxzZQ0KPiA+ICtzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9hY3BpX3Jl
c2V0X21ldGhvZChzdHJ1Y3QgYnRpbnRlbF9wY2llX2RhdGENCj4gPiArKmRhdGEpIHsNCj4gPiAr
CXJldHVybiAtRU5PREVWOw0KPiA+ICt9DQo+ID4gKyNlbmRpZg0KPiANCj4gUGxlYXNlIGxvb2sg
aW50byB1c2luZyBzb21ldGhpbmcgc2ltaWxhciBsaWtlIHRoZSBtYWNybyBgUFRSX0lGKClgLCBk
ZWZpbmVkIGluDQo+IGBpbmNsdWRlL2xpbnV4L3V0aWxfbWFjcm9zLmhgLiBJdOKAmXMgcmV0dXJu
aW5nIE5VTEwsIHNvIG5vdCBhcHBsaWNhYmxlIGhlcmUsIGJ1dA0KPiBhbGwgdGhlIGNvZGUgbmVl
ZHMgdG8gYmUgYnVpbGQgdGVzdGVkLg0KPiANCg0KVGVzdGVkIGZvciBmZXcgcGxhdGZvcm1zIGJ1
dCBtaXNzZWQgdGVzdGluZyBmb3IgcHBjNjRsZSAsIHdoZXJlIEFDUEkgaXMgZGlzYWJsZWQgd2ls
bCBjb3ZlciB0aGUgdGVzdGluZyBiZWZvcmUgc2VuZGluZyB0aGUgbmV4dCBwYXRjaC4gDQoNCj4g
QWxzbywgaWYgQUNQSSBpcyBub3QgZW5hYmxlZCwgZG9lcyBpdCBtYWtlIHNlbnNlIHRvIGNhbGwN
Cj4gYGJ0aW50ZWxfcGNpZV9wZXJmb3JtX3BsZHIoKWAgYXQgYWxsPw0KDQpBY2sgd2lsbCB1cGRh
dGUgaW4gdjINCg0KPiANCj4gPg0KPiA+ICAgc3RhdGljIHZvaWQgYnRpbnRlbF9wY2llX3BlcmZv
cm1fcGxkcihzdHJ1Y3QgYnRpbnRlbF9wY2llX2RhdGEgKmRhdGEpDQo+ID4gICB7DQo+IA0KPiAN
Cj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bA0K
