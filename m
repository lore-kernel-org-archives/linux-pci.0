Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79A63321A5;
	Fri, 23 Jan 2026 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769130116; cv=fail; b=UrZYPXiKYhR3KMr8fWdfXYiRp6/zFJp3P0O4zQGfy0F2jtixhOKlXjMQumMmMqpP/j0rmiGeCLt9ZwvSJLHou9sh85J8vX6Xh5cTy3Dv+SRwENt7az+8eDS3jNg9Ep8izFg0K06P5/RuzNO4QKJWZPybThCk4hzNY2YjZK8qxY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769130116; c=relaxed/simple;
	bh=6SCSnAqYpDofzb8QMtpvJ8JYPJd5M4HbvB/rfUPoraw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=cX5ZzVO8D5cFde/yiW7ij8LXvm9BJ3Io2iGjwUBKu14AU828RwRz3U48eoOuXQLMOJdb/mo7bujj37mx1ER+X98gJNZYtuPFAhcqJo4O8+JwqT+0RUS7tBCLZQLVkSyS/5TMbd3qoGdr0W92jjSFNY6cxz1yPnqtAmx5p6yRjOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKdDVR0i; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKdDVR0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769130112; x=1800666112;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=6SCSnAqYpDofzb8QMtpvJ8JYPJd5M4HbvB/rfUPoraw=;
  b=NKdDVR0iGXBPDsqCTc8/8EZvAMLG94zPez47AteK7UaSDne60raF/7BB
   9rmmXkL7VDWtqTeUNO9HZfdKMAlC1rthxhCfC9sKq4Rjn0juiX8ghw2zo
   t53lWQKj8UwHZ5eu8z1wUYoA0fEIQz+BqsZoOxiAnXs3D354yBammR1Jn
   V/6ZDCTleYA+zrBUT+KUak6GiyUde3jSaBMPUdg/mCfSNI8+Obggw8i2/
   bEoLGq+NQG8C8/6+ryjKvipvG4mWEWEj7M6ciMyxMZvYowZqKOXmFZXOg
   gbopE9zTtllJOcJ/TFFr/DbW5jKvqxZkxUFPsFiA7LrKJaeVAmwGv8Wy/
   A==;
X-CSE-ConnectionGUID: tiaTips0SDegMVospsh5gQ==
X-CSE-MsgGUID: QQ0BEdtwR8KLH0bV724SGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="93048055"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="93048055"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 17:01:47 -0800
X-CSE-ConnectionGUID: ImU/uk3DTbSdmxNKf+e4MQ==
X-CSE-MsgGUID: mAjmq3COS4WSqx/nOhZ7TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="211892981"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 17:01:47 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 17:01:46 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 17:01:46 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 17:01:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsmPAWWFtFAW1aKEuF5frGv///sIB7NaQMe1yJc3pBqM6UV+XdDoX9oLGtbnKLOiVo1fYMVaLoZ4YECXC7VrqJeaNk0GNvLveDOLW6tnstBLZ6vonKFaR2ftgcWPFD/NwCfrpDUc7e+XcdPh0vsLIi0DohRnedlQRPTM8XwPlbsirNevXH6HeaCoQh7Nc0+jl42s3kHF5qoChKWD657iAtfag5wGfwBMAuOFF201Bm1lQdlECFW1NNzpxXICU7ggodwPXRqBfzEWfBHhjn2DGBB21gTFU4PXUA+wc0zHOmjqai74tDiErH+lB48v8NVtCOqxaiLqxIlcZ+VpXg3LFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiG8LtFgRl2xnJy4xnfH2k0xq4R77Tqdgk6F1GXSSpU=;
 b=cH1TIqB/uzk/+7De9l+L3TffAVZ5gpOBrxC8V3CF3jLRu98luAT+2XYvD1BkTqJJquty5bF5o7CwkLFIAGp3mh4hL9A08Oi3sdagsUhfcqmvEa60L0IfxQ+EwDgdY6WleonWueuX76dbNPWCsj7QWzQQ4dmyrpQWStjsKp+Iav114ppUk0en5IriV3WsJ/hsB805Ko4TiCb3aa6uo3praLZgfw1TXOD4ZxcgOQTTJa9GsOyYHk4Ab8L9t28n0tKGmCLxyySdVdXzF+i9znA97x205TDr84FAm4lTIcN0EUHFSItbtuCOGGAnNhg4dI1UmGEpn088QC97n7BlKSTWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7561.namprd11.prod.outlook.com (2603:10b6:510:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 01:01:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 01:01:40 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 17:01:38 -0800
To: Xu Yilun <yilun.xu@linux.intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>
CC: <yilun.xu@intel.com>, <yilun.xu@linux.intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<linux-kernel@vger.kernel.org>, <yi1.lai@intel.com>, <helgaas@kernel.org>
Message-ID: <6972c872acbb9_1d3310035@dwillia2-mobl4.notmuch>
In-Reply-To: <20260105093516.2645397-1-yilun.xu@linux.intel.com>
References: <20260105093516.2645397-1-yilun.xu@linux.intel.com>
Subject: Re: [PATCH v2] PCI/IDE: Fix duplicate stream symlink names for TSM
 class devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::43) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b08448-9211-4aa1-0a06-08de5a1af76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGQzcGU0VHYxRWpwVkY1UXF3bU9ZWXI4cm1aV2tVWmtNWW1HYWJONkc2Y3Yy?=
 =?utf-8?B?alpmVXlvTHBTK2pWdVI5RmhxMGw3d1Nubk5JQW04NEFPNDVGWWdkNGM4cnB1?=
 =?utf-8?B?RVhsbHE4OFJqZ0QzNlNIZTJ0VzltSlF3c09YR0cyUG9nS1d0UmJsdHpyK0c2?=
 =?utf-8?B?QnlmT3hPY3o4ZnNFTlVxKzAvY2dSMWxSczFxOWFEcm81eXpPcmt4TjE2L0JL?=
 =?utf-8?B?RmFqd2xBck9JTVljemxMMFU2Q1Z3T3pPTTFVWDJIeDFoVStSUHNkeG0rcmRB?=
 =?utf-8?B?N1U3QU90aXZNSTdVblpQWndIQW95cWpHVzRKTVdWaUdwblNDU1F4WDhVcXh0?=
 =?utf-8?B?c2R0WjNwc0I0UlJGb3lHK1luMWpkTE02SEptQ2c0M1phYTNQeXZQQmVUZkhn?=
 =?utf-8?B?NUJxOHB2M2ZMVXlFdXp3bG1iTk1ZbEFkTitramhINGtpdzBPTGJRRWptWk9l?=
 =?utf-8?B?WjNreGo4V05hS2RoN21tbTZkdU50WERPMWpNVEwwVi9UdDJRVVd2ZDl5ZXNL?=
 =?utf-8?B?SjJENWh0bWpKcFJhbTBhNU1TSmNzajN6SGxxOTQ1MzJKWFBjZ3pEMDRBeWxL?=
 =?utf-8?B?Nk9vY3BkUU9oeFBseTY5N0UzSkxRb0graWxEN3puZDJ4WW1QU0JTbEJQSE1w?=
 =?utf-8?B?WStkeHNZOTFRSjNiOXJyMUhDOGpXekQxeW1ZMVBocWxWYjF5L05qbHVjSDgv?=
 =?utf-8?B?ZXMraGxVT295bnhJeGpEREJmaUtRdU91RXgwSXUzV3BBUVpGZWhqMXpIMUZK?=
 =?utf-8?B?c20zOHBVTmpFbU5VVm55UmJQdExpdUJzTHRTSG0zTFJ6c1o1WVlRNHhKQ1di?=
 =?utf-8?B?WDhaSE8rSW1tVUtXZHhLd0tqOVdqbFdjeWdVOFhkT1JKTElra3RMR0xFS0I2?=
 =?utf-8?B?MWpzWEJUWlFmZkROaFI4TWtkWi9MTHdJbC96VmkrdEJCZnpNejJqWE5PVFhM?=
 =?utf-8?B?SWtOZjI1cUw3NkMxQnJCK25NZlh3N040dnA3QTBXbUN6RHAwZFZOKzZIdWlY?=
 =?utf-8?B?c2lHQjdFWjFJdUVOSmk5cUhmbmR4OXUvN2Vhd2NiNDFnK1dvUmR5ZnJjcDBl?=
 =?utf-8?B?NEN2WXBjQWdkeUY0NmZ5MEsxTDhlM0NTb2gvd0J3L1M1b0JkVDBtM25qdTNV?=
 =?utf-8?B?b1VFR2ZDR2hWbCtRZ3dMY3BKTHRkMEE2RGV0NU92YjcwTmF1eXNrNi9pU2hy?=
 =?utf-8?B?ZldQUU5UcFNVNHZNVEdVdktuMUtGZFFoOFBHaWJMZmJHYzlOaXZTNFJUb2U3?=
 =?utf-8?B?bkFRb0NqeWpoTmp2NkNiNGlpSXpOelZQRlNQcE1IMFU1aGJvcDBzMmJEOUNw?=
 =?utf-8?B?aXdZY01YREl6eHhQa2hVVVQ3KzI4WFcvZTJ5M0dxVWcxQlNRUmR0VmRKZG1V?=
 =?utf-8?B?VGdFdWx2SVdLV09qRUMyaEdFaVFSekZJM1lzSTBQOUxVL2VVY24wU2NiblpE?=
 =?utf-8?B?M1NTelNMVDdsQVpuSlhuR29mWGdyMjdCYXNTQzJFM0ZjVWRDT2tnRlZ2YkhU?=
 =?utf-8?B?Y2tjVXVDMjFLclB2RnpFN0VWdkUrZkw3d1IxTDIzRDJMdWZFMWdqMjlHZ09s?=
 =?utf-8?B?ZXFzbUFKMGgwV1NJY0Nvd0xYZVlWd2xudFhXbUxoMzNtS2tWVU5IRjB4S05K?=
 =?utf-8?B?L0ZONzBjWnJ0bGJXSkFUVWtwRlJnZmFYemhVaktvTGtqOTNzZzlmWGFGdWhu?=
 =?utf-8?B?bUIxQTAwNGx0YWswUDJ1OEtqWmREQTRFVStndDNYSlozR3JPUHNKYkhtdzFz?=
 =?utf-8?B?RGVlajgvcjY1R1lXWE5iS2Q5Z3l0L3Yvb0dzcUQ0RUluZUpha2l1Wk4wOE1F?=
 =?utf-8?B?N1JqdW4zOGdEbnlBYmM5SlU4dkdkTDNNdGl0NUJlZ2dNV1MzZGwzc0FOSmdi?=
 =?utf-8?B?dEpYUFprMjNDY01CUE1HOTNRY1NiWlNlZjZ6RjFRL0xkZVBhNlh5QzRnUXdO?=
 =?utf-8?B?anZVS3FGaVRsWnVJYmljMHJ3NHpEdVhXNzBkNHVPdDlYV2kvUE1jZE1SVlZT?=
 =?utf-8?B?Vjh1NGtyNTF4UXZVSGpBRDVhRzBkckYwSDQ0MFk5cllCVmIvZDlPUlRXWG5y?=
 =?utf-8?B?QzRmekFiRzlUT1pYQ1ZSWS9CMWU1OHl5SXZ5dWpHQ1BEajlWNGRhT0w0Qml6?=
 =?utf-8?Q?Jltc/P57nlVlNrr9ePMQgCaPX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkVmRnpHdmdhQ3duS1I5ejdsRHlVSE05SzBoVG5nME5jdUl3S0IrMDNQUHI5?=
 =?utf-8?B?cjErUXZmc0k3emtJZ3BnQm0wZGplY2c3Y0Z6aGNsSC9ncFRhUE5aMzIxSVJa?=
 =?utf-8?B?eWNxWEdCSC9EK0hTcm1tbjVoN3RlUnRLdUE2Y0dHY2Frc3lZVndBdmJRT2o5?=
 =?utf-8?B?V1RjNFJpVHhocGpKeG8zZkI0bE9PMkJuUGUvcUVaMzMvSWxzdFZqMCsyNWMx?=
 =?utf-8?B?UHkyQnVza1ZoREpDK3RUSk9vaklHWHJrbFJwWDdjYnVRUmhKSTMwb1Y1ZTEy?=
 =?utf-8?B?RFdJQnRmcWZ3b0I0TmpubE0yYk0xNU9CSVRoU0I4dUsxSC9WYXNrRE11WjJi?=
 =?utf-8?B?K2pYRXJmbmk0SXk2OWtidFBySjIydTRsUHRUY2FXUXJnZG5uKytSQkVWbkkw?=
 =?utf-8?B?MnJleXQxRXd4SVBxZzFRQVJTNFpneWZrN0hkcGhuckxxUzVPM0ZkdHc4ZDFj?=
 =?utf-8?B?YWVLc3pCa21CemNhMnhYYUJqMmgrUklwUDZLZ0FudDJBMnlXTmdjNE1KNFBn?=
 =?utf-8?B?N0dmUnVXcHpwODd0U1MxbDJTNVNXelZvT1BuZHlJd3VnWStscTZGUE9hczh4?=
 =?utf-8?B?S29UQ21QaExtVGhJd1dqMGhPODNQOHY3blRqbnRsa2pvU2VwZFFNVkttU1dj?=
 =?utf-8?B?NmRqWmh1cTlKV1dsN2pJalpHdXRSYmRDMGhtcGkxODdabmRXUmV0SE54OGNy?=
 =?utf-8?B?VEFGU3JEZnd2STduN29admE4MTQzY0JxRC9NR01lRll6SXJRVGcyZ3lxZjg3?=
 =?utf-8?B?bGdNeG8yeEZWQnNZaFdEbmJqang1YkFVYWQ2Q3hDOGxIVEh4aXFzdlo0SEg5?=
 =?utf-8?B?c0ZBMGt4eTM3OTJvR2svSFZ4anRXaW5uYWZlVGMyckh2UkNzZFI3dU5XMm9Q?=
 =?utf-8?B?TmdNN3FBY3JRNmMvR1ZCZktIYnFGdmpmWDhiZVlRdjRmaDBPR2UvQUt3ajZV?=
 =?utf-8?B?QkE1UDYyRnpGcWFBeE1QQTNqbGVoSTlCUWFOYU1BVm5WNU90RU15MjRhR0Ro?=
 =?utf-8?B?ZTVRU0UwT1F0djViTlczdm9WZU1QZjEvMEdkWUdaUnR0OWw5c25wK3ZHRHp0?=
 =?utf-8?B?MWx2TEJuNFRoL2x0NlJndmJHYnp6VHZPVzlsT1F4RTEranNHcFpQN0NvMTdE?=
 =?utf-8?B?aG9qT0c2cXR6TjNocW95RkdFTGVvejI1SzNwMVBwbmZDS2xMK3c1MWlNanpV?=
 =?utf-8?B?SmVQY1VPWkFzbWk2WWUvZ0U0QWRKaWVjZHc1c3lKbVc0dldoaS96SEJZODNZ?=
 =?utf-8?B?LzdpY05hZERkdTNsWlJEeUNFMWNJbEYySDAxNFRsRmZXL2Nna25MY0RVMHZO?=
 =?utf-8?B?dVhEQ0lGMDNsSzFEcjk5K2taU2U5bFNTd0VScFJGbHlXK042bmkwYVZya2hH?=
 =?utf-8?B?aU5TZW01UWgwNWZEUXp2Nmxvb0xWcnlQamg2UXZnN2NOWkxGcWF5RFJacjJl?=
 =?utf-8?B?bjFXV1RJWHQrSmRiSHRWTFVKcy9UV0JmYkV3QnYyUzdoYVE0ZVZZTUtWa3JF?=
 =?utf-8?B?QzZ0V2U4bWNWWDhMYUF5RXNQZnFuSDBnTXZpVWd6L3pKN3BwZGRwTDkwSi8v?=
 =?utf-8?B?Y1U4ZVFNdGFHRlIwd0dGNGlyWnNOV1pTYW5GZlg5b2VIdkM2L2pzNDlhU3Q1?=
 =?utf-8?B?a2ZnRFhIeW5UMHJKdkcwbHU2YVFJYjMxRmcxNGZLU2xaYzV5TWNBR0VNVDlD?=
 =?utf-8?B?Y3JvWXJ4SGE2YUdweWZnaytoekVHQk4xKy9aY2M0eXpLQS82OWczQUhHbUp5?=
 =?utf-8?B?UW1PLzdpdnV3TDRTVVJMd1hQbnFQMGlORHhxaVNzdXZweDMwMk1tR1ZpcWFN?=
 =?utf-8?B?Z3lPSE52VzlsTDZ5cDZkVjJXNy90VXFiTUZMclIyajFFS3R3WFJGaGNtT1BR?=
 =?utf-8?B?WDN1NXBQU2U3MEJxUndXL0xLK25uaHN3R0RGYy9LTHpxcGwrTW5jQSthWE03?=
 =?utf-8?B?K3NRK1ZmYzlGM245Nm1mRW4wMUlKYmNOdFl5bnpPdldIbU1QSUptNmczREg3?=
 =?utf-8?B?WERQSk1hTjUyMldsYkI5QjNxdzdVZXVhRThYUGcvQnNYelllQ1F6ZFVobU8r?=
 =?utf-8?B?aEZwZEZ1RlhGVWlSd1p1bWU5ejZBSWlTVjJYSmRUVG1sZlNDb1hRS1pRcHNK?=
 =?utf-8?B?ay9tNWtZdW1UTnpLRHVpbDB1cDFsakZnVDQ3VUNEZVF3ZXFkL3h6eUVWRm1n?=
 =?utf-8?B?YUlpT1VzVmhxUFpweDRybFk0RzFsUFhSdm0rNTdGcHlHOXIzZHc3U0pUazBC?=
 =?utf-8?B?VW4ybTJGZWdIL3NWYmlWWU1uOElZZEwzY3VjNkZKWVFUbmZybTNJd0lvc0tr?=
 =?utf-8?B?SWlYTlc4YWxNODZ2WGY5VW1Uai9SU2oxTDJIS3VxQ2dHTGF3UHMraEIrV3FB?=
 =?utf-8?Q?BVI+2H5GlTKkFRTE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b08448-9211-4aa1-0a06-08de5a1af76f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 01:01:40.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuUOavJu/4uZrB8RD+zTKY/7djYEReKUZAeZYIj9esGl2b6PDlFp74sA+gNLnW3qTUYMKOb9kig5jTmZzmvXmAtQLPoovBMmJwsslyXvYhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7561
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> The name streamH.R.E is used for 2 symlinks:
> 
>   1. TSM class devices: /sys/class/tsm/tsmN/streamH.R.E
>   2. host bridge devices: /sys/devices/pciDDDD:BB/streamH.R.E
> 
> The first usage is broken cause streamH.R.E is only unique within a
> specific host bridge but not across the system. Error occurs e.g. when
> creating the first stream on a second host bridge:
> 
>   sysfs: cannot create duplicate filename '/devices/faux/tdx_host/tsm/tsm0/stream0.0.0'

First thanks for fixing this, a significant oversight on my part. I will
add this to the devsec-sample tests as penance.

> Fix this by adding host bridge name into symlink name for TSM class
> devices so they show up as:
> 
>   /sys/class/tsm/tsmN/pciDDDD:BB:streamH.R.E

I do not like that we have this large combo name and the confusion it
causes in the code as Bjorn tripped over it.

> It should be OK to change the uAPI since it's new and has few users.

A better reason is that this ABI has never seen a released kernel.

> The symlink name for host bridge devices keeps unchanged. Keep concise
> as it is already in host bridge context.
> 
> Internally in the IDE library, store the full name in struct pci_ide
> so TSM symlinks can use it directly as before, while host bridge
> symlinks use only the streamH.R.E portion to preserve the existing name.

I think what I would rather do is just back out this ABI for v6.19,
since it is late in the cycle, and fix this properly.

My initial thought of a better way to achieve the same is to create a
kobject named for the host-bridge to namespace the streams. For example:

    /sys/class/tsm/tsmN/pciDDDD:BB/streamH.R.E

However, after seeing Jonathan's feedback and noticing that he missed
that 'H' 'R' and 'E' are documented in the host bridge ABI I think it
would be better to simplify this to just a link back to the host bridge.

    /sys/class/tsm/tsmN/pciDDDD:BB => /sys/devices/pciDDDD:BB

That achieves the same result and is easier to document as "When a TSM
has a established any IDE stream it links to the host bridge. When the
last stream is removed the link is removed." It achieves the goal of
letting an admin do "ls /sys/class/tsm/tsmN/*/stream*" to get a survey
of all consumed stream resources in the system.

That is all a bit too much to do at this late date, so I think for
v6.19-final just delete this ABI, and try again for v7.0.

-- 8< --
From 2d236b203ea155d16d3251bd0e3bf4eeab2fcf6b Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 16:35:56 -0800
Subject: [PATCH] Revert "PCI/TSM: Report active IDE streams"

The proposed ABI failed to account for multiple host bridges with the same
stream name. The fix needs to namespace streams or otherwise link back to
the host bridge, but a change like that is too big for a fix. Given this
ABI never saw a released kernel, delete it for now and bring it back later
with this issue addressed.

Reported-by: Xu Yilun <yilun.xu@linux.intel.com>
Reported-by: Yi Lai <yi1.lai@intel.com>
Closes: http://lore.kernel.org/20251223085601.2607455-1-yilun.xu@linux.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm | 10 --------
 include/linux/pci-ide.h                   |  2 --
 include/linux/tsm.h                       |  3 ---
 drivers/pci/ide.c                         |  4 ----
 drivers/virt/coco/tsm-core.c              | 28 -----------------------
 5 files changed, 47 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
index 6fc1a5ac6da1..2949468deaf7 100644
--- a/Documentation/ABI/testing/sysfs-class-tsm
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -7,13 +7,3 @@ Description:
 		signals when the PCI layer is able to support establishment of
 		link encryption and other device-security features coordinated
 		through a platform tsm.
-
-What:		/sys/class/tsm/tsmN/streamH.R.E
-Contact:	linux-pci@vger.kernel.org
-Description:
-		(RO) When a host bridge has established a secure connection via
-		the platform TSM, symlink appears. The primary function of this
-		is have a system global review of TSM resource consumption
-		across host bridges. The link points to the endpoint PCI device
-		and matches the same link published by the host bridge. See
-		Documentation/ABI/testing/sysfs-devices-pci-host-bridge.
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index 37a1ad9501b0..5d4d56ed088d 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -82,7 +82,6 @@ struct pci_ide_regs {
  * @host_bridge_stream: allocated from host bridge @ide_stream_ida pool
  * @stream_id: unique Stream ID (within Partner Port pairing)
  * @name: name of the established Selective IDE Stream in sysfs
- * @tsm_dev: For TSM established IDE, the TSM device context
  *
  * Negative @stream_id values indicate "uninitialized" on the
  * expectation that with TSM established IDE the TSM owns the stream_id
@@ -94,7 +93,6 @@ struct pci_ide {
 	u8 host_bridge_stream;
 	int stream_id;
 	const char *name;
-	struct tsm_dev *tsm_dev;
 };
 
 /*
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index a3b7ab668eff..22e05b2aac69 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -123,7 +123,4 @@ int tsm_report_unregister(const struct tsm_report_ops *ops);
 struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_dev *tsm_dev);
 struct tsm_dev *find_tsm_dev(int id);
-struct pci_ide;
-int tsm_ide_stream_register(struct pci_ide *ide);
-void tsm_ide_stream_unregister(struct pci_ide *ide);
 #endif /* __TSM_H */
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index f0ef474e1a0d..280941b05969 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -11,7 +11,6 @@
 #include <linux/pci_regs.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/tsm.h>
 
 #include "pci.h"
 
@@ -373,9 +372,6 @@ void pci_ide_stream_release(struct pci_ide *ide)
 	if (ide->partner[PCI_IDE_EP].enable)
 		pci_ide_stream_disable(pdev, ide);
 
-	if (ide->tsm_dev)
-		tsm_ide_stream_unregister(ide);
-
 	if (ide->partner[PCI_IDE_RP].setup)
 		pci_ide_stream_teardown(rp, ide);
 
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index f027876a2f19..0e705f3067a1 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -4,13 +4,11 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/tsm.h>
-#include <linux/pci.h>
 #include <linux/rwsem.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
 #include <linux/pci-tsm.h>
-#include <linux/pci-ide.h>
 
 static struct class *tsm_class;
 static DECLARE_RWSEM(tsm_rwsem);
@@ -108,32 +106,6 @@ void tsm_unregister(struct tsm_dev *tsm_dev)
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
 
-/* must be invoked between tsm_register / tsm_unregister */
-int tsm_ide_stream_register(struct pci_ide *ide)
-{
-	struct pci_dev *pdev = ide->pdev;
-	struct pci_tsm *tsm = pdev->tsm;
-	struct tsm_dev *tsm_dev = tsm->tsm_dev;
-	int rc;
-
-	rc = sysfs_create_link(&tsm_dev->dev.kobj, &pdev->dev.kobj, ide->name);
-	if (rc)
-		return rc;
-
-	ide->tsm_dev = tsm_dev;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(tsm_ide_stream_register);
-
-void tsm_ide_stream_unregister(struct pci_ide *ide)
-{
-	struct tsm_dev *tsm_dev = ide->tsm_dev;
-
-	ide->tsm_dev = NULL;
-	sysfs_remove_link(&tsm_dev->dev.kobj, ide->name);
-}
-EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
-
 static void tsm_release(struct device *dev)
 {
 	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
-- 
2.52.0
