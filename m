Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57DD328627
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634017; cv=fail; b=h81I+g6YZD6tXLXdPyVNhsJ9y+jA5C89vCYkfa7zXmxjrj9+DrgEyPXdiLjyE+H8g5ob35/GpoiaV3dG6/1z6m7in+sT8VTrJzrU+I48CUWZiEoIwViyYb+kyPyqEEyT2cs9hhRG6hcdf3A02WHB3WaM7Z97FyRTUTq9jI0/Nek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634017; c=relaxed/simple;
	bh=9l6lrhA8igHXj5hOCbEoCKT6MmVznncPOR50l5o5nYA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=DJhSnYwtHspsBsnqCMA+ZbKOme80Bam23v85DipQ/7R84svwJ/nH3E2YzpM12TuI1VoQ6Bjtvuu8iMCTW98MCgnLMI5UVM1BU9fiRXV367lhVOp1JHvIP0bdQr8OfZSpav8hJ2P1qfM4QAzt6l4eqhnViR5gz1s0WPYJN5zo82A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbucFqLA; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbucFqLA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769634016; x=1801170016;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=9l6lrhA8igHXj5hOCbEoCKT6MmVznncPOR50l5o5nYA=;
  b=CbucFqLArUiKL+VDJDsOVOIJMyz7xxPoQr1U8F0cXwP8eRQ4c34VQw6I
   v06H/1lpOO1n2dFkSCgHMbY2L8Uvs7EGYCrmU73SzggEai9fyG+00aHhL
   bo28XmOsV1xFfMGi4ICeoErKE6gjzLiXlLoyyH8qa5e1BS9PSOKKgD4Xn
   rZGCMaNXDGK8KHxNlvDxyfZU9TaqmRaFW7cuhUlQ5IWeOW4fzgNEIfOAd
   rWafjZ2hjV5aaKdL1Qbo2ywRQWHv+J64G7PjhCk/Okx4qSJ1Y9vB9l0NF
   0tF+5eHd804CuV56ZHRyWXsjrTtkqaw+V1CFslXf2l+tYML5TJtUjeSjl
   A==;
X-CSE-ConnectionGUID: vC2bVv6yTq6xWpAJFS1BuQ==
X-CSE-MsgGUID: +wKizCSBTpOyNcF0hC3Vtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="81588556"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81588556"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:00:15 -0800
X-CSE-ConnectionGUID: 3bR6R+HMSWCHAuRYd5+D6Q==
X-CSE-MsgGUID: qu/Z9g9YRKG3EU3zP9Y3YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208269938"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:00:14 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 13:00:13 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 13:00:13 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 13:00:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ng0xaa7q+VfsllUEm0gf9T/Ntr10CozmJDrML2YUxN0tpLHIqvjx8cLQke46SaAXZFTDeWP9uOPa5O/PCJNys3Yz23r+qmBBXe82z4hmch29WclPpvKFZVnDfDc98cvYzejML7s1PLZDo223GtOEiE5whFYRTy/0SNu0pJfBn52GkGZ8c+dTC/P+RjxibHNH0CvvxaEk0Hojjzyq1jpt+NMqAZ2aea8S4Ze2BZ1DvwM5LDPYmUHjM4zA55pZ99MDXjRi+Dol86yTUVUHgZUe8fZ0JzsNHG74oXb19g0bQ3jDuZ+qR2XF6fRo4H0D3RqYgMgEFU+OS1HkpNkhrCe+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8chCfzggpjtEhw7ePUeX+Iev5yPZe3oL7xRttpdDeoE=;
 b=Aj5YpezoWE3+YZjcmL667WWDYcX/9GlqhdlYUt/2olmZSjJjTX+ypxyHl+vmRQZAJPFqK5/CTTn0IJOtcgsbAb8ceYGTt1MJsgomcjRYPD5XD+PDOSvRcRBBQxchJbvdX+Y3YzueoJ71F+Qoru7mbFg3GYaElbj42ox6ofXsDfHJOZx5BlXaQ4VKrsrTgjn9RvnWAWIghsBXpXlKkeUxcD8OWaUE4YkJKLls1HQZNszlWY+EyndMQvt7EclOZADQNVAYLGEqJE0MCdIr4nCA7aNVQ8cgO8gPpQwsSB5T1stAHLEULKHRxmWtsyuGATyaJWoDwT4KbJYVEjDKuU8W4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPFD7E67F036.namprd11.prod.outlook.com (2603:10b6:f:fc00::f54) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 21:00:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 21:00:10 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 28 Jan 2026 13:00:09 -0800
To: Keith Busch <kbusch@meta.com>, <linux-pci@vger.kernel.org>,
	<bhelgaas@google.com>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <helgaas@kernel.org>, Keith Busch
	<kbusch@kernel.org>
Message-ID: <697a78d991860_3095100dd@dwillia2-mobl4.notmuch>
In-Reply-To: <20260116184150.3013258-2-kbusch@meta.com>
References: <20260116184150.3013258-1-kbusch@meta.com>
 <20260116184150.3013258-2-kbusch@meta.com>
Subject: Re: [PATCH 2/2] pci: fix slot reset device locking
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:a03:167::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPFD7E67F036:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebe69c5-73d4-4afc-c37b-08de5eb039a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHBsV3pUN3IvUTVqQUd5ZEcvUWVwd1lvL2NuZFRYTkpjci9VYWNGSGV4Mnpj?=
 =?utf-8?B?NCtDNUtYZ3ZrUXVWVEQrTVJqc0NPL2ZhYy9FRFhmS3UxaVlGc3l0cE5CSUd2?=
 =?utf-8?B?bFdnTFJuNGRGempmYmtWK3MvRzh6dFhydWhwQUtCS0JzT0JtcWFVemd1UmNo?=
 =?utf-8?B?UlQzb0t1ZG5QRjNUbFljU0ExM3ZYbnNuU1dyZjR6aUdvMUFrUFVLSkNiOTh2?=
 =?utf-8?B?QVpzN1U0enFsVlFJYUFaM2ZLQUhoN3BZUHErQzlRMzdxd3d5cjRLczZLTm5B?=
 =?utf-8?B?L0NNbGRaTi9lUXdYNXpyeFBFUDRVd3h0aGc2WkFzdWkySFFWZit0UlFxblV1?=
 =?utf-8?B?K25HUTFtckhWd0J0MXRjMS9hNW81bWtUMWRlSTVnTVRYWlhoM1MyV1pmMGZG?=
 =?utf-8?B?WVpBKzV6Q0F0YTBsTkNyZGQ3MXVoRXVKWksxM2F0RXZieXJnUkIrN0QveTBQ?=
 =?utf-8?B?Y1dBYlhnZWJwMUl0SEtIaEVYMTBVZGsreUdhbVFCRzRiN2ZiZXFtbWVIVWtI?=
 =?utf-8?B?VTRqVzFMeDVYTlExdG9kTEk0QXIyTUN3bmNmL0xGTUtpRjdhRkR6M1dMdUdt?=
 =?utf-8?B?c2t0ZXlSaUVkSldTNHhSY2VEKzlJZ09xcVlWcktLNFdoOVBxa0RKSytvNlVu?=
 =?utf-8?B?eUdzVXQwdHNMbjNxQm5oN0V3dTJML1RQSm1xbUdYK3pEekU4dCt4VlFBUlBG?=
 =?utf-8?B?cUtOZS9LZGpYUW4reVZ1eitraklZTjQyc01kL25wTDFJRnoweFpLNTVKU3RR?=
 =?utf-8?B?SndjS2gyRmRHdDd5SlIxTjRMdldhYmU3czBFZUJWMmZZZ1ZTbTM4djU2MHNX?=
 =?utf-8?B?bVhJZWVFSEt0NDY2ejFJNGFkTVhHazFTNGUzTzU3WlB5RmlxcmpTRVhTLzJC?=
 =?utf-8?B?YjNBYTFHc0k1aGtvaGpaWkM4NVhrVHU0V0NSNFRVc2srR1FKbUtwazlYUWU2?=
 =?utf-8?B?T3NCZXdQVHFlOXRBQXJJdUxmcGRsM3BOejdlcXBZTnBOQXdVdTQ0enpYUkRN?=
 =?utf-8?B?bXpIREMvK3BlOERVNk9BTnJyQXJQVWw5UU1uUnlEVW5GVXY1M3dOUkIvL3pi?=
 =?utf-8?B?ellGdFNPS3NyTk9hZXEyNk83cWwvSnNwZUh5ekhTS2ozTVdUakprTUdaZkdZ?=
 =?utf-8?B?aUJtOC9HMVFHV0lodEQwY1cyTGpLL3NIWVB3ZjRzTHM3cGREK25ETlZhOHNL?=
 =?utf-8?B?c1BGcXlXZWh5a3dnVUt1S2MrYm8rb3BENTJ1RWxtTWRRY2UvSmR4RTllcTFI?=
 =?utf-8?B?U2g2ajI4YVprWFlhQUVwQjRMQVFZNXcrOG54L1g5ZG14dWpMQlRCT3Q1RWlF?=
 =?utf-8?B?bEkwUmlETGl3dVpzTGYxQXVnNzF5MTVJcHJpN28rSmtvaHl4N2pkWUFCSXRD?=
 =?utf-8?B?cFpLWTVCV1lnZHEyK3VxYW1XTlNUM1A4ZFVCYnJQdElmeWw0RUoyNVdWU3lT?=
 =?utf-8?B?S3c0UFU0K3E3dUNabjVHTElhcTBia3ZRcFFLRU9oSm9vTzZBWjNOMDFBZHBB?=
 =?utf-8?B?WUFsTklNTUlRQm9rYmQ3YU80WHBqaWpRRzBmTXBoMEovZjBqOTNWcFVhRzEr?=
 =?utf-8?B?dHVKRFdvQUtPTExRRmlETzI1NS8vWS9sTnMwMmdSOWNnSEYyNFpmSllOQzhH?=
 =?utf-8?B?Tm5zd2p1SW9iRHZucS95SVpJNmhlb1NpR1NWNHltZzNYWnREUW54RHhoZ2xW?=
 =?utf-8?B?QU41YlN0eW1WYzhiYjNoemxLVHoyME15V1hhSzRyN3NaQ3I5YUV2MkoyVG5m?=
 =?utf-8?B?d3MyTXhVWmd3K1lFdldLamZkeHpwSVhOVGFmcDUzRE04bVNrNzBoUzZqaVA5?=
 =?utf-8?B?VzVsWVpTOHduME5ud1VncXYvVHdNb1NYVGRBL3U3RzhmaWhnbkptdWZ5bHQ2?=
 =?utf-8?B?dDdhcEIzYzBQN2ZqWGptKzZoam0weHZPMURuSVRnVnB2ZGFIM3pWYXk2RTdY?=
 =?utf-8?B?NzRNVFIzUmJnR3FSNzBUelJWQ2w2TS9lOWdBRFpwMHRsRXR4UkR5L1JSSWQ5?=
 =?utf-8?B?SWtUV0dqSy9sKzVIR0MzMUtWTEFGYzZnTmJodllzeWtUQ21QTDNya1pteDVz?=
 =?utf-8?B?SVVRV01WMk5Ub04xSFpkWVd6TU1iZzc2Q081K2RHWE0xR0NUdE9ZNzhyMWZB?=
 =?utf-8?Q?YIps=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnZqSitmTjR2Lzh5MHMvY0RHSHo5aVcwS0ovdEdBbE9mdnRLQlBpaFlFQW1r?=
 =?utf-8?B?VWlBZUJhM2lZK1RSWEMxRVdCdVRHbFQ0TlY0Qy81OVNOZnJZTkttU2JPTnhw?=
 =?utf-8?B?elArS2I4ODM4cDF3azZKczFBcGt0SUFWbVI1WDlQc1NDbVpNcmVHN1d0cG1U?=
 =?utf-8?B?SDZpNVRYSXlCbittSlpPa25VUE4xUi9JQzNRb2Y4cVdkdGFOTnVtbkNiTy8r?=
 =?utf-8?B?RTF5RDRrNk9BTUxYQ2o0RUd6a3dpOUd4Vzl3S01Wd2RISFpvTEZnZ1BORURr?=
 =?utf-8?B?YXJhSndMZ1dJWmhVL01haldoV3V6SHp5N2I1TnpEUzNvaFAySzVxWGZYL3JK?=
 =?utf-8?B?a3d1Ym8wZDdFRnA3NkxDaHYwTFFIZHRpdWkxVitsaTJtWGd4WVRiQWdnd3JH?=
 =?utf-8?B?NTVPQ010dmxzM1hSVy95eWRycmN2WXY2MkNmSkRsOGdWWW9JNGhodkZaZnNU?=
 =?utf-8?B?dU5NNURsNzlTcW12L3FqMUw0Y2FkVUVhNUY4Sk1MYUIyNjJuUEduZEk3cXkr?=
 =?utf-8?B?Z2hpUXkwbDJNSVFZR2kzeVp2NzBpWnNxOFcwaU5sd25yOGRMT0lNQU1YVXJ3?=
 =?utf-8?B?QTBoZ2ZVVzdCTHRjRUVScTFWTkVZdlVuMkNPVTFaSGtGUURZNi9ZUCtucGM4?=
 =?utf-8?B?dy8xd3duWStLaDZ4bHRrL1dEa0dWMTFnTnFvUzUvN01MdXRpRDFLZ1VMY2tV?=
 =?utf-8?B?WHZQSEtXQWovQjkzNk1ZMTdzR21ZbDdPaDhlY2tIZVFaQk4wMFBuU1VyNWpB?=
 =?utf-8?B?Zy9yVkI2clRkcU50NkthTHlTOHlBenAwaVRjN3plbEppcW9GdFFiUmhiN1E4?=
 =?utf-8?B?d3NwWk1pZ3hBd3RIY3daSVVZSlNCU3dvbW5IRkNBeVNDUExCb3FhT2JqNGoz?=
 =?utf-8?B?Q21GMC92RUR0cllMYndKUE9DWnB1WXQ3SE1seWsxeTFnbld5YnczVWMrajRj?=
 =?utf-8?B?MzJzMGtLVzkxSjZqQ1MwWENXWERLUFEveE8vTmx3VFJ6V2k2b1VtMmlKWVVP?=
 =?utf-8?B?L3FZb2RnbmhTbmcwQ2doRGoxY1Z2c21nd1hiTlI1cSttVE9TOUZMSUdmN2FS?=
 =?utf-8?B?aUxGQ3V2RkhZRkJvZTBGL0lmUUkxdGZMVGcybWRjVjYwM3Q3cExvMTJsdXdv?=
 =?utf-8?B?VXNQMmp6Uitlb3BTN2tFTlU5UENaQnVSQTdlREhVRWxwdlhITS9BSnA5NGhW?=
 =?utf-8?B?RGF0SEhXN0QrVUpMVFVtTEFUVVhVcFFEbUtMSWk1RWt5UFJmQjlJTXgrUUh4?=
 =?utf-8?B?UmlqUEpDOVJjdFpoNnc4YnZ0d2hwWFJNZ2QxOGRTcWZLU1pWcWRNZ2c3NG1o?=
 =?utf-8?B?M3BENHc0V3pNZHQ1RFNQTmcvSGRZNG45S1Nub1NIN1c0NjROOHgzbDEvdFBM?=
 =?utf-8?B?clFPMldSbHhGZURjMm4yRndsVDJwcTNZRTZCalJFSjVQSGwrdmVjUmRWNWp3?=
 =?utf-8?B?S1NuVkdCczJJNmtoYXQvVEc0akxuMHV1dTlRdU5xS2VJS3RXcU55aExqSkd4?=
 =?utf-8?B?TmRhdUFPQXpia0V0c1E3REFLNGVNa0I0Q2pSZFlJK1UybXk1OGp3ejcwZUF5?=
 =?utf-8?B?c2tJeExWMTVaVEZrSThTVzVXbDJqcm95TUM2N1lMc1VwWWsvWUNqVUZrQWZj?=
 =?utf-8?B?cnBQSTczYU5PakgzOWtzYXYwOFRnY2RmRzJVMzhZaE5YWVNBQU1Ccm9HcWtS?=
 =?utf-8?B?NC96SE5xQjRtU212bURPYmg4cFlvOEtDSitmanhwcTdnVysvdGlLUmF2a0dE?=
 =?utf-8?B?Q2hOY3NlOEpBejdlTUZlUDByanJQcE9uR3lTM2pldDZVczNmZWhPUXdCVFZQ?=
 =?utf-8?B?bk1iWDVYRWhWWTEwcFVRREw3ckM1R1RxQ1VjT29DclBOSm9URWlXMy93WXY3?=
 =?utf-8?B?L3lCUUJwMlpJNkdWKytVTng3Q0RLYncreER1d3FSWmVGck9KcWxHV2hJUEx2?=
 =?utf-8?B?eWFMelNxT0NYMzRzUFlvd1N2R0hIUjRqQVMycUlYU3FNQ1IzaS9TOE55STFH?=
 =?utf-8?B?TGppOE80REdnUzdRR04wbkhmbUY1aGxjVmhneTQ5byt6cFZXcEVubzhvL0RC?=
 =?utf-8?B?SDZVYXJROXVTNDkvNlpGckJjanJrYVo1Y0hadTRMZm83S0RQYmpFUTJoSU05?=
 =?utf-8?B?M3N1dk1kNDZpZlhTSnhiUWNKbVAxZ1ZSTm0vK1pnRXR1K1N1cVRaWmdad1lE?=
 =?utf-8?B?TncxcXlXell4bWN6YUhMckFsaFBYbjY4SndpOVlWSVpsT21iRUxVK3k5SmFP?=
 =?utf-8?B?VjdIUWR2T21UdVBmemU1d0d5amhqc1dWQXVZcXB5Y1dKZ3JjWEFKa3BnSFQ2?=
 =?utf-8?B?TEE5V05BQkEzMG94U0U1bXBhVHJRTWphcFVQNzQwdEdEV2VsS0pUaUEybjR3?=
 =?utf-8?Q?Qfl0/VJ+SCJh6s+Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebe69c5-73d4-4afc-c37b-08de5eb039a7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 21:00:10.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04QowDzkQkq81FkvwcBgGyc83/E3rUIEPoDcoLLMyjB/1VJzQlKXoutCIcpzp4W23YRZWenkt7RblTF+fB0Qcf9vQkunyC2FEMVSkXmiPRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD7E67F036
X-OriginatorOrg: intel.com

Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Like pci_bus_lock, pci_slot_lock needs to lock the bridge device to
> prevent the warning:
> 
>   pcieport 0000:e2:05.0: unlocked secondary bus reset via: pciehp_reset_slot+0x55/0xa0
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/pci.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3378221c5723a..5f8b0d06a1459 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5460,6 +5460,8 @@ static void pci_slot_lock(struct pci_slot *slot)
>  {
>  	struct pci_dev *dev;
>  
> +	if (slot->bus->self)
> +		pci_dev_lock(slot->bus->self);
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>  		if (!dev->slot || dev->slot != slot)
>  			continue;
> @@ -5483,12 +5485,17 @@ static void pci_slot_unlock(struct pci_slot *slot)
>  		else
>  			pci_dev_unlock(dev);
>  	}
> +	if (slot->bus->self)
> +		pci_dev_unlock(slot->bus->self);

Given how much context is needed to understand that this looks right, I
would not say no to a follow-on patch that adds kdoc for these locking
functions.

At a minimum I think a breadcrumb of a local "bridge = slot->bus->self"
variable would help.

>  }
>  
>  /* Return 1 on successful lock, 0 on contention */
>  static int pci_slot_trylock(struct pci_slot *slot)
>  {
> -	struct pci_dev *dev;
> +	struct pci_dev *dev, *bridge = slot->bus->self;
> +
> +	if (bridge && !pci_dev_trylock(bridge))
> +		return 0;
>  
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>  		if (!dev->slot || dev->slot != slot)
> @@ -5511,6 +5518,9 @@ static int pci_slot_trylock(struct pci_slot *slot)
>  		else
>  			pci_dev_unlock(dev);
>  	}
> +
> +	if (bridge)
> +		pci_dev_unlock(bridge);
>  	return 0;

Even without the above cosmetic fixup, looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
