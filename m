Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357413093CD;
	Wed,  4 Feb 2026 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240140; cv=fail; b=BinhUZsZmvQud6y7P4SyrOsP4IS0t2JhRxhh3oEuLt8Icri3k6B1L5Orc3gl9o23X4kwNpBOb+LZw6F9co0FszN/+TcXohm0/jDGqECRY4CIKEOCn/IiukTZBtGm8Kf9bAwsvUhllC9+AX3DJiqHUQLtg0XfLmcopxeyCnyf0UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240140; c=relaxed/simple;
	bh=Ps9E/OQ28DXxie0qtxU7TdrO0iFllQ0UWEE1uUvTV9k=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=rE79oZUmSrmQpAk8NatTB0U2tvtN+VaB6oR3A5eA26U9ubx94dP4y6+LyeFcICeWfE5CGb2B22R9zAXB7NBoCL8sEM+wLd/OfmUK/rFAmAWquKibwUH+Rz5NspSiU4zTJGvTxAKgScXECSvn0i17OUXkdve3Hfm1JHM9qi1PBtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ub0GH3Hu; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ub0GH3Hu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770240140; x=1801776140;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Ps9E/OQ28DXxie0qtxU7TdrO0iFllQ0UWEE1uUvTV9k=;
  b=Ub0GH3Hu2ZJ8+n4ftd1mx/zlwXIr3GGoSfyGF2hxt8IMoMw4YSSrZHaa
   CVVi4Cyhmj/ui0u3UKg4+some9m1be/xrUFyLjDAAeroeZjSQNlKyQAQ3
   T2diNFK6nieY1Dzfe2cF2JjdKmv8Jv5GyYFlClNIhclykqCl1hvhlOZEY
   DwWMbDUrmkRE1AYygXbnEGPcP+3279MkUAPVQIvKZNxtMT+J3Xuag1GS9
   g0vkh+65txkkYnefhCkYPVyk4QWTJ7U3WQ1R8h++wOPaLzeG8qOCVCgGJ
   9lrzY2HuiBfxQgq4IpN9CH8Jle9LmsOY92l6REOvbu6/wI26NOxyu1CAd
   A==;
X-CSE-ConnectionGUID: BO5s9I3vRaupU4Q4Eww2cA==
X-CSE-MsgGUID: 0aC7lk+aRxWnZ40FKmh6AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70632428"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="70632428"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 13:22:19 -0800
X-CSE-ConnectionGUID: B+APsUnyTnW0OUVvz8Dk7g==
X-CSE-MsgGUID: c9P4aiwFQvC6yc2WdQqS6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="209580376"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 13:22:19 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 13:22:18 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 13:22:18 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 13:22:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjElUcPAOxEI4H/XTqD0lkf87kf8TH/7CysPnCNX3VDIOf7Uu75WxkffVLnORqU/OfIP5vlgyMfJryM2g08sNScongTX2oKhIVhVHkdwQbdvhbvt8yx4nYSceGXfBLf2hOLESIb+ezBzzwGcCTTnruognVFZaPd1UBQ/b21rwQByVnCw75ube18wGzyeRsBHvXRjA93oXtzdxGQnCkGsTFSwQDJKZfuusQDKPKTwwevcYPHLHWIkqdbe578X2QGqUI/sAG7SrFy/lrzqqEKh/njCvfEdJgKIxhl3xy4ocLHQXDZedsOeq1iiXqW76zC7KxNoA1NP89KQBpli2GbZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8UD9Sx46CDXQ+s2n4aE1+Jer+EjpaHKJgI49+DP+oo=;
 b=hxHcebV2pd3UMYsgtZkR3nfP7tDjbU6K/aIey9kGgv+26Mgfi+gDGObydHGHgqnCpV+82TIK0/tnqxgPatna/Nn7b+to9Fau8/zgpkum2d81ntu9UrWIDMINcUHTQR+xOFw2Dh1ObtXzmj8cNsZ5dQD8VIR0UqPdz/PaPcL9WPja7o0+pDb5HRThLIWo3LG2UwUiY4amJKbXvz3bA4YPnVPuR8H9sGCp72y5v6PZM8SXuYpQPSmlWkRP8APAJRWSf4iq8ZYnRI7uYgY8Qn7NfVoh6bH5BPmdbjOzyO2tq0tUf3RGDR1PQ01+Uxp6zcK4LH7uGsNeW3QujWdwpNXo+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6545.namprd11.prod.outlook.com (2603:10b6:510:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Wed, 4 Feb
 2026 21:22:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 21:22:15 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 4 Feb 2026 13:22:13 -0800
To: "Bowman, Terry" <terry.bowman@amd.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <6983b885a31cc_55fa1002d@dwillia2-mobl4.notmuch>
In-Reply-To: <e6de891c-e1e0-40de-978b-15f60acea92d@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
 <20260203025244.3093805-6-terry.bowman@amd.com>
 <6982d468e42eb_55fa1002b@dwillia2-mobl4.notmuch>
 <e6de891c-e1e0-40de-978b-15f60acea92d@amd.com>
Subject: Re: [PATCH v15 5/9] PCI: Establish common CXL Port protocol error
 flow
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: df128615-f890-4a05-3380-08de643377d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2RFSlgxM1pCeEdHQmxwK2d6a292YWZLcDBFUkhMVUJPYVg0Vk8yUTVGcmow?=
 =?utf-8?B?U2xKcSs2OFNmZVorQkM4L0tmYWpDbk9NS005a2k5Yi9IbFQzb3I2WGZPRS9j?=
 =?utf-8?B?OUxtZjdPeGgyQVRSMzY1ZUdyUGV2R3VqZ1M0SzhjN21tTjBwQXVINzNMZ2pJ?=
 =?utf-8?B?WEZIbWNyTjBCalpCMnliQ3ZTa3ZtZU9UcHVpLzh3VW9IZTl0dlNjeWdjM1Fu?=
 =?utf-8?B?cEFNRy9WTDRVZUxHRWVNZ2QvMnd1ai84QldYWU9ZNlBxWjUzcVlIbTVnRnlV?=
 =?utf-8?B?Qjg1NXpUNHpXUVpwUU9mam0wZ1Jvb0s5VWJXNFdRd0RtdWRvc0d1QnFHSjU1?=
 =?utf-8?B?R2tUK1BaN2lVYmVxODVVVEVmSWNTUXBpSThyQ255ZlZTZDBvTWJ1VzQxRzhB?=
 =?utf-8?B?andsZ3lXQVNhdWtZVDBtZ0JIRGNUYlR3KzNRcUU0WE9SZjhYbVRCejNHQk9Z?=
 =?utf-8?B?UkNMVGNlOC93MEIwTk12N2hYUEhVZ1Uvb2M1bTIrOGlscnhPZW8wYjJ3N2g1?=
 =?utf-8?B?bjhQb1JMTXdEY0ZSTXhzMkMyREtraFI5cDQ2MUtwYlVEL25WMUsyZExjN2dx?=
 =?utf-8?B?bWJaNEdTd0Z5YTBYb05PeTZmdlhEaDV6dVZ6MXJseU55TWJSMXdBdjhjNmFx?=
 =?utf-8?B?bzB4a2J6VGZLSFpuNG94RW1zKzhHRkpwcXVtbW55YWdjdi9GKy9JOFJubXUv?=
 =?utf-8?B?T0NNaHZhMmxMeCtpcGFkVWxlV09hUHhnL3kvTzMyL3ZUbk5PcGNsV2EyVEpp?=
 =?utf-8?B?VVA5S1A2dmRraUxQRGdIQW4rcU9lc2VsRGdnTDBCQzc3eTFKMUEzRDNMbUNE?=
 =?utf-8?B?WVFXSU92NW0yMG1jNXZzcmk1ZVcyc0Z4VVNZUXFWOGpTSDN2NGUwN0dEc2ZV?=
 =?utf-8?B?Sk9DOUNEdXQ2T1dQMlpPdFUwYVVLd0hlenZoOFRSUWV0QUZmY1F4TU8vZ1dQ?=
 =?utf-8?B?cndvNGNackRTN2tXRkNLRnhNTkNNbk45R3o2NUxZeTR3OXh0RXVscWxVRXlU?=
 =?utf-8?B?U21UbHNXUkFEQW9FS0lmWVl4dktzc29XTDFEb2QrZ2xaZDdYL0Y0N1dMQTQw?=
 =?utf-8?B?NnNFbWxlaE4xQyszWDc2a1J2LzFhR0tpZGwzcHpuU3dPNE1NTllJaU82TEVL?=
 =?utf-8?B?S3BxeEtUU2VhM1REendaWDNjWWdyS2lNVlQzazNTSzlQd21PeFgrWWZNQ1pa?=
 =?utf-8?B?YTZWd1dEM3dENU5PdUIzNHpEZEtNQk9GTHpBKys3Ykg4cDBhaGx1RVZ6UlBP?=
 =?utf-8?B?MWxvSzFzWUFWQ3N3S0RWOVdvNmg0YUNCV2VaRXhISHlrWXExbUJXdDh0TDQr?=
 =?utf-8?B?VGhuS0ZSRHdkMHlUdEkzdUJhUFZERTRvQ09CTjV2ZDltS3hJSkNSNlhsV3d1?=
 =?utf-8?B?NVFXVHo3MVN6dXJySm9JRnRqRTUrUHJGK0ZiYmE3aUc2SExKNUhLaHVyUjBN?=
 =?utf-8?B?SlJYL1NQSTRLeml4MWNwWkNNUThrYlJyMmFVMCtMRHlueEllb3ltbzF2YzdL?=
 =?utf-8?B?ZGtKOHl5WVdPSWszMTc4RUdLZld5UStUc2xVU08zMys3TFVwVnUyQnlVNXFi?=
 =?utf-8?B?Z052R1d3OVdpMXR2TlRuWjlLQ0lUcUNJcFN2S0lPU1QvcWF1ZjhkYUlnYUlo?=
 =?utf-8?B?NHc5YWdWeDAxeWVsSmZmM3VoZFM3NjF4QzMvNUFEeE5COTFjZEpoVnM5RmNM?=
 =?utf-8?B?ekhMcTcrOE45WjdYNkVzQnllRTlTYll1aVVubG9saVZ0WHlyUi84WFIvUUx5?=
 =?utf-8?B?Q2YwbmxGMFNXWE8relJiclk0K1lvK2wvaWpEOUxrS0NLd0xYWjV5S2JhWm1M?=
 =?utf-8?B?ZkUxSzdRNitIUUQ2bytCK0Z2cDZxQ2pIU09DQ0VVSTBVY2JxakxIWGdpaFho?=
 =?utf-8?B?S1lIaFFjQ0h6aU5oYXluOU5rMGExRjk2bzhDNG9veFJjQm15N2JETUIrbGM1?=
 =?utf-8?B?RlJrN1RoQkoyL1lBVFZHV0Rscm5WQlpsUnRCTUNzZjdHbEl5UjcvT3hwSjda?=
 =?utf-8?B?MkNVeC9WNnFhUlJsa1J3SXVQMDA5SkQxd2RWTitFU0hBQy9XRG44WGovSld1?=
 =?utf-8?B?TXFtWUtjTlJKeEI1T0lIT09oejRFNzJFc3JJVnhicHh5SlpPT3JhM1FaTU9p?=
 =?utf-8?B?cWJzV2lnajFpbGxVaXBSTGExWmtLY09UNjZXTW16Mzkya1VPYnhZbmllZ1Nh?=
 =?utf-8?B?ZEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkVFRUxjWmIyUk4xV3lUL0lYZDNPa28vZkttdWk5OU1FcDZMdGxkY0RNK2g0?=
 =?utf-8?B?dXhqNnZzOTNxS2g1UytaKzhHV2JtUFpUNUJEVHVzZGN4cm1wM3VxQzYwQzRJ?=
 =?utf-8?B?WWYxajVnTjU2ZHQvQjNUZ0U3QUxtMTBIZmlrbDEvSGdkL2hoSm1pQk9vN3Rp?=
 =?utf-8?B?aEwzQ0I1UStBV3k3bk1BdG04UE1scndWdE1YQWdsWHB2N3h6V1FVS3lIaE1K?=
 =?utf-8?B?c1FSVENuSDBtejVKZFExSmJZcnpjNXJCK1huRWN0anZQMWtSQzMwYjBzZ1V5?=
 =?utf-8?B?WjgwM21sUTIyNC9ueEROWVEwWTZ4cmppQVFEbng1cnhmOG5FYTRMSHEwekgz?=
 =?utf-8?B?WXI3S0lIK21kdTJ0SFBtRldmVmtZRnExa1RxZSt3TFRPRWMxZGxtTm5OVFNn?=
 =?utf-8?B?Q1NSZFlEczkxNEIwdEU2bEYwKzJ6MzlseC9rRm5lMW53RnkxT2dOei9Lb1BU?=
 =?utf-8?B?aFp5bndhNW9OUXA0NnNFLzY5T3ArSXlsYjlJamlKdVBjdWZKbll6WkF2UG9Z?=
 =?utf-8?B?aHZMaUh0YzhrbmFTN0hrZU4vSkJXd2JEaG0ydSs1NFAzM0RvbFBGeXlpUDdT?=
 =?utf-8?B?YmVuclRKdFBKZGtOeCt6d1FGL0xlcVFmWXN6all0YUxTbWZQRnVxaHVxdmZs?=
 =?utf-8?B?eWk1T2dRcVRXc0Fib1RmNUxUVTZ4M04wZ0tnUUJtanBlRFEvVWhJa1J3bzBw?=
 =?utf-8?B?dWVRMjBzdjQ3ZjhzOUo0VFFFTnlvY2N4WngrUFc2NU5tL2Z2VU9PMzJvOEFy?=
 =?utf-8?B?SjVHa1BkdTRTZ0trc01rR01LYnpMTVp6dnpsWmJqSmRRSlZSVjllNlg5andp?=
 =?utf-8?B?RlFpanVaWWhodFNMUVAzSTRnYW84bFB6MDBqNlpvYTZ3b2x0UzlYczZnUEJu?=
 =?utf-8?B?WktTcTdtWHNHcnl0ZkhrUWhzVFJGZ2JtZE9MWWFEREUxL25kM240ZnlsbHFq?=
 =?utf-8?B?ZThlRVdQcG9GT2dZVTRHYjI0UjdKdDdFOTBjbmdPcC9iUVN4VWppaFVnSE1P?=
 =?utf-8?B?eFFTMSswekxjaEdSbFdqdEtBaUlsOUNua281WTlUZDJDYm0xT3BLa0lSdzJl?=
 =?utf-8?B?RGhieittWGcwMUhZR1Z4MDF0R2ltQ2dZYTM5WGRnRmVCbWNTQVFZYVBZQ1lx?=
 =?utf-8?B?Tis3Z0pZdFI1SUFxWFlGK3ptamErUW9aVXNac0ZydGltalhiWUxMNTlQS1FI?=
 =?utf-8?B?bk15UHpvanM5Ui8rQlc4T053MUlaeng4d0kzZzdZOU1XNzRMZ2drVnh2clIz?=
 =?utf-8?B?RGp3Sndwbi9qeEgvM2xCelJtNGRJSXFrbTluL0FWNXBmTkV1Tnk4MCt5UEJN?=
 =?utf-8?B?WCs4bzhuTS9mZGJ2UmZzU2QvOVNlUFdPOW0rL2ZXNnp4T2dYMktad2pleUQ1?=
 =?utf-8?B?Y2hpbm9zTnFSdEtsemlmOVhlVDFVaWFEMlJkUnhiYUpEMXJRMk12REMxc0xU?=
 =?utf-8?B?VzV0R25ubXpPQVQwNGZhcUpERHpDZFFqandnc1BVTFltWktiV2h1Y0VnZWhU?=
 =?utf-8?B?MXM5dzcxRXp6T0JmQnpJLzVSTW00eW1adFVEL1RjcGNSYUhMVlJseTM2RHJs?=
 =?utf-8?B?bFBDTkF5NzVQdnBycm9scDlnR1IzVVRwWStGMmtvR3RqN1d0OWUzRE9wWU4z?=
 =?utf-8?B?WE5sMHZobElaTFkvdlZuMDRSVjFUek1oL1lNWVhXcmUxSjlvWnBDeEd5dHFs?=
 =?utf-8?B?V2tsc3RJWkhmTDNwWUlQeWhTQUVQc3pJU2IrSE1KT2dqZEVybFNCRENyNjdy?=
 =?utf-8?B?ZklJZGJhWDN5RHdUbjFBSmNaMG9OeFJoQUc3ZUk0SjYzaDMwSjQyVHdmdTVW?=
 =?utf-8?B?Y2pOV3FoRlFMcmRBVno1RTRSMXRiWlZQRGlPaWFMNkZyUUJSSmlhcUpzcFdC?=
 =?utf-8?B?OElKaXRxMFppSlUyaFBXMGdDN3Z4TnhCSzFMR0JBemZjUEYzQkVKWDdlQnhM?=
 =?utf-8?B?aVFGQkdQYlZxVHcrSVBtNFY0eDF2dFJWeVk2L3lDenZGMU5GQ1NzOW5oVFpZ?=
 =?utf-8?B?NEJDNGx6RElrQ1JJeUVHbVFqcE8zUmxyZUZ1RlBUeXdqeXRTS2NJMzMrcTFI?=
 =?utf-8?B?RWdaRm5sK3ZkZlc2RXBMekFnY1JaNlFPNGJEVzFHNkhZMm1mckFGNFh4RDdz?=
 =?utf-8?B?bklhUlc2SldHeGJtUHNXM0JsTDlOcC80T1AwUzFhcE9tN3d6cG8rbUhkM2Z1?=
 =?utf-8?B?dHJoQWxzTWtLL0t4RGFVKzVXdHBUUFVXK05SRDdjL284YjNGY3NQeUlRYkVY?=
 =?utf-8?B?bWFjQWhlcys1UGJNcTNXbHJXTmE2U3dvRmNmbW00eVordi9SdmMxZ2U2Q2JB?=
 =?utf-8?B?M0RjTFNTZ1YvTWsyckJZaUlWVmdCZ2pCZjlTL0xkekxFSFI2SzZ3U3VIQ0o4?=
 =?utf-8?Q?X8pwv/+Lb2sYKX2c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df128615-f890-4a05-3380-08de643377d5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 21:22:15.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZANPfhv0Nl1VfTVBfkKLpHwyQ5eCLOeQpcArTemBeBYrPwbYEbCD5CR5FV58zHkLgMh0bY9MAUCIwKTia0tUfLNusEswSXFbzb0XbblRdMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6545
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
[..]
> >> +static void __iomem *cxl_get_ras_base(struct device *dev)
> >> +{
> >> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> >> +
> >> +	switch (pci_pcie_type(pdev)) {
> >> +	case PCI_EXP_TYPE_ROOT_PORT:
> >> +	case PCI_EXP_TYPE_DOWNSTREAM:
> >> +	{
> >=20
> > Nit, clang-format puts that { on the same line because coding style say=
s
> > only functions get newlines for open brackets.
> >=20
>=20
> Hi Dan,
>=20
> Thanks for the note. Would you like every switch-case to be upodated
> to match the clang recommended format?

Yes, please. See "git grep case.*:\ {" for all the other examples.

[..]
> > Isn't this dead code? Only VH topologies will ever get a forwarded CXL
> > error, right? I realize it gets deleted in a future patch, but then why
> > leave dead code in the git history?
> >=20
>                            =20
> Yes, agreed - I'll remove. Correct, only VH is forwarded. My
> understanding is the cxl_memdev guard and driver check are no longer
> required here. The memdev is only used to source the serial number, so
> I=E2=80=99ll refactor accordingly. Please correct me if Im wrong.

You do not need the memdev to get the serial number, and I note that the
serial number is only mandated for CXL memory class devices. I would
rather stop worrying about serial / pass 0 then add endpoint special
casing. The consumer of the tracepoint can always get the serial number
from sysfs, or this can call "pci_get_dsn(pdev)".

Overall, I expect that this generic error handling is device-type
indepdendent. The aim is it does not need to be touched again when/if
Linux ever sees CXL.cache devices without CXL.mem or the "serial is
mandated" edict for memory class devices.

> I see an additional fix needed: cxl_rch_handle_error_iter() in pci/pcie/a=
er.c
> also needs its callbacks updated. The RCH/RCD path previously invoked the=
 EP
> PCIe handlers, but with RAS now handled at the port level, those callback=
s no
> longer reach the correct logic.
>=20
> I had a coupled ideas. One options is for the CXL logic to make a
> callback into a cxl_core exported function such as
> cxl_handle_rdport_errors(). BTW, the CXL logic in AER and the CXL
> driver's RAS are both built with the CONFIG_CXL_RAS config.

That destroys the modularity of cxl_core.ko.

> Another option is updating the CXL PCIe callbacks. The cxl_pci PCI
> error callbacks currently support only AER and could be updated to
> also support RCH/RCD (no VH) with something along the lines of below?

This continues the abuse of PCI error handlers for what is an odd CXL
aberration.

The answer that feels consistent with unburdening the PCI core with the
vagaries CXL is to include RCH errors in the class of notifications that
get forwarded. Arrange for cxl_proto_err_work_data to carry whether it
is an RCH or VH error and then dispatch either
cxl_handle_rdport_errors() or cxl_handle_proto_error().=
