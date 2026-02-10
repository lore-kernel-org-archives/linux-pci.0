Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8A322C73
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770767332; cv=fail; b=SJcfRpZd0enulamuAA5tTGn9NuIjK+asdJDXSlyG6N0W1T2VziECaPk+7ZfJe6WhJGGClNc94qTMGkyiK4Zvn5nXITRIFmjppFOAbqg0f9BxQkJuiKzCOQisMbfJEm4lg290n2ksfNjia2CEPACFlhWu5pcxakqPCIvLIv05324=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770767332; c=relaxed/simple;
	bh=8dXMLa7w4fxs/+gQMjQI6JSJf4+wzfBTgBtl8cqweIM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ETrAQseV4pnfJ5r0mdpaIPs7+QBoRWe/5BmMs6rv71O38adsQsifI8FGJ2AWy76IHAdEtjFcXLm/fSH+r3lnZWHugYiaPJ3g9/9RZTyuVSn1lWij5XDszTFivFdZR7sPi46f0qB4JNfuJDe2iXTjs1NctUSrwoyqJeuCXZQwaV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bh3SucxO; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bh3SucxO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770767332; x=1802303332;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=8dXMLa7w4fxs/+gQMjQI6JSJf4+wzfBTgBtl8cqweIM=;
  b=Bh3SucxOBnuYzUlfWj/FcZ6DB2+UsPzssxajBzSRmUrerLLl6mOKiHtq
   r+Z0GzrmtnO5yuyaP9qglD/M8n0d/YroArS7ABIylajX0aYUYwZCgo6uA
   LeztCDBqXEmER69u3wT7dBDl0EdqPRPIZbLWBLd+mKC0OtRV65QEKKs6e
   8jPkRLnmJMm2pVmAow0tYWyfqgJ7MbozNM6hjenPcdEcLuoZvHpFNYBsL
   ODsNh0j4JNxwzIoG61Vf5pvf2ADPOYx1cZXIMFKlDVI87mYpmdlzqf8iy
   H9VRDqhDuk1ja5pdGNMIOm4fNW2nER7Ob36DvqqYU+QVjxGZMvA1EVdwY
   g==;
X-CSE-ConnectionGUID: 4CkaphxjSlGNs6R7Kc8DKw==
X-CSE-MsgGUID: PZ3wD/54SxmFI8VaMYRb9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75753656"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="75753656"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 15:48:52 -0800
X-CSE-ConnectionGUID: Z6jwp5/ZQVeSUetP0zzdQA==
X-CSE-MsgGUID: kYbTKNYuRLyJEMAxAvzJQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211511360"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 15:48:51 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 15:48:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 15:48:50 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 15:48:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GW0Lke5fjrStjOcr0/DMEQHEtRXflYMJ9BDtfnqORli2gHZ5iY34REKt9363gWsvP0P/yJ337DL0BZshddAJsPsISSP9PERqZbAyH8M92d6C7CKFc6g/hGZixLfatorRPjnqxNT4sOLsSzNyvaFKOislJDlJ1TTjis3pdm0MYGVflrwxGbWcrRph2S4R8FDr9H+0TL+/s33qRu+7BLDzi0aDEYJs5Iij7QqBVErRu1FznKH2Ahe/z+8VRq8CvnOM55yhCpawGOYCzKWdjTY/opGlao/OAyTGQZUveGt8pknjwO7t8oRFMOHcN3RO+lUZdwERXt4ina8Lo32780De8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTdnHAACu49yDJdh9CGOLM1MrGmNrPZnkOL6OyPTclc=;
 b=DMTSFNzjz/KppXcVdDcWDKqg83ohVeXp8PPZO7DXXnpzwi09wOH0novGhh3QZPERgOcZdK78spD2yZ1T0/yvB7ybeIXw+u/7SvYmjA389Z70EqmZ8A1fvTsoq1U168xYLJCssT7WmAWqTPfYHeOUABuWvYp1eI0RaHe2YUcfE7fDXS1AIyx/vHDdrGpt6H+5IHYV8W1RepG5Hq1kLPjumXjIY+zdcTm5PMCdizFJToNUY8+xvbJnyRSbzi1SLvJdyh81+IURBHJe78n+G9a0wG/HvLhuNDu4NsGoXw28HLc+sLHIewFPJInhLyK8D8cOTS1WiZTkIwoh7IH98vC5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB6049.namprd11.prod.outlook.com (2603:10b6:208:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 23:48:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 23:48:42 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 10 Feb 2026 15:48:40 -0800
To: Keith Busch <kbusch@kernel.org>, <dan.j.williams@intel.com>
CC: Keith Busch <kbusch@meta.com>, <linux-pci@vger.kernel.org>,
	<helgaas@kernel.org>, <alex@shazbot.org>, <lukas@wunner.de>,
	<guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>
Message-ID: <698bc3d88de4_8c3210058@dwillia2-mobl4.notmuch>
In-Reply-To: <aYu-fk1AIXtG-YnF@kbusch-mbp>
References: <20260205212533.1512153-1-kbusch@meta.com>
 <20260205212533.1512153-4-kbusch@meta.com>
 <698bab4a7cf16_2e57100bc@dwillia2-mobl4.notmuch>
 <aYu-fk1AIXtG-YnF@kbusch-mbp>
Subject: Re: [PATCHv3 3/4] pci: remove slot specific lock/unlock and
 save/restore
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:a03:54::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: a8658ce6-a12a-42ae-f368-08de68feebc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2g2TmpwdDNNbnFZVkxuUnNJc05RQjlROWh3RzI3ajNXMldCdlMrMXlkYUFT?=
 =?utf-8?B?VUxua0FUeHlsRDVqTGV0UEJNVStkck5GSWZVbDVoZEFCQ1pyc011dWpNYlQz?=
 =?utf-8?B?VVRFcWxVVTh0TVN6cWR1LzI3SythVFg2ZS9DN3NpS3VMSENFZTY4MjZBSDNy?=
 =?utf-8?B?YUpWQmRCbkw0SmlDdkxzY0tRTE5DWklhUG0waWQrODdSVVhsSlp5b1V3YkVp?=
 =?utf-8?B?L0ppQS9UQUJnYWVzZVRYekRJM09aYzhOSlVvaHk3a0p4MXFFamhNYi83VG5U?=
 =?utf-8?B?eWMyQXZ1bXpLSURzL3N5TVE1b1NtSld1a2hHclVvUHc3Q3hiNEVyWEVXNklw?=
 =?utf-8?B?eHhhVEdzanpFdG1nSTFuaG5pU1A2Zzg0SWorSk0va1d3NGlDbUNrMmtjUXM2?=
 =?utf-8?B?QWxiRmV5cUsyYTkzZnRFYyt5RGp0Kzk5dUpwU2FiSjB0UFlWZlFNdWUxRGM2?=
 =?utf-8?B?Ny9tRlpvUS8vVlhWR09raEFENm1iVmZ6V2NtMzNMYklnRDZUeEFhYzFrcUhK?=
 =?utf-8?B?azY4VTNhWjFGQzZKcDBzd2g5Z0todnd4UGNjaDR0cXVKUktrcjU4clFPa1E2?=
 =?utf-8?B?aFliWkZPZU1sanpLR0NrcWRla2J1RVhGMEIyQVdNWDVkOUNnWTZxQlRmYmlL?=
 =?utf-8?B?YWt3NnZPZTdqUzMwNlo4MG94Vk5sMkwvRXJoTEhBcjY5cm5JanlWVUtOeEtt?=
 =?utf-8?B?TVhaN0FhcnZQbWt2UDlCMHVNUzAvL2NVTzR2aysybWltQ3hvSnpYcDBMYjdR?=
 =?utf-8?B?b0N6Y0NiejVHZG90SFpEbnNOQjNwb0RLeExxaEFOUmJSVlVvWTZBMHEyalpL?=
 =?utf-8?B?TGVlV0F6MEdKakhWVnlKOEw4VHdyM1VzcXR0U1FuVzF4VSs1R0ptTU1vUHRj?=
 =?utf-8?B?cWZQakN1YzV2Z05TSjBXcStGQlJXTG1IRFhDNDYycS93YTZvOFN6ams0NDQx?=
 =?utf-8?B?eGg5MUpJT21HOExhVHNQZis1ZWtYWTI1RlZ4TlVac0Jxd0gxQ3l6dUN1cTZH?=
 =?utf-8?B?RFB0STFBMXI4TkIvR3R1Y1Mwd0JnRE9NaFNpbG53a2I4Tm5VaitVZEdBYy9w?=
 =?utf-8?B?c2JGcWJkdUxDMHRYWi81Q0FndjVlcExFVDM0UFVqVDZqbzRzZUk3Z1lGSGNt?=
 =?utf-8?B?R0Z4NnorRFhpL2ZtcXNPcWZyalJHM0ZZNnNvUkNNL0pxTzV5MWF4cFJKYVpE?=
 =?utf-8?B?YXBJOFJHeHN0UnRGaTJJNmM4MlVhNUt2VUYvVGFCemJMKzl2YTFzZGhxbE1Y?=
 =?utf-8?B?VTVwNi9qQ1QxM2NxWlpwVWFOWVVQQXNndjRYVDdxMjNqVnRQeGtjZnpwa0Yr?=
 =?utf-8?B?N1p0aHVBNFBLRk5KWXNkQitRN1JLQVduMlNLZ1RRc0lRMUMwRTZHcW5Fd0JP?=
 =?utf-8?B?REs1WUpHbzJkR1AxdXVSNkVWWFpKZWhkQUJwT3NuaXYzbHE2VFhDMG1vc09p?=
 =?utf-8?B?bnI2emJMSm13SWVzeEw4bTdLRitwNmZUUEt4OVRHK1RpWDhkTVl5MktjM1Ni?=
 =?utf-8?B?SmxmUGNLYWk1QUxVSzBESkd4dVFyRCtXRDJ2VW5RZFVIL0MrWEM3Vi9kSGYx?=
 =?utf-8?B?V2hoUGFmWjlxc2VrRXNqL1VxMVFtZUx1MWlnVm9BTlJHZFFEbjNYQlJBNWJH?=
 =?utf-8?B?aGd2SjBhOXBTalRkc3pTMVRFK3ZvK2FpTFRIVmthVVZXVDhpQjJmeklmVjUw?=
 =?utf-8?B?U0h0QTN4Ujc1aXkySFZkeS9wamY3aHRtMXU2SUwveUF6a0RlRVBhdDZvRGdq?=
 =?utf-8?B?UFZCVVl4ZXRKUDhiYWdncis0T1NadGtpaUxoamJLTE1zK0c0ZGZPeTdXdzJX?=
 =?utf-8?B?TVdVY2NTbVRwcU1IUzIyclB5Y0FUaE81T1luVDVWK2pmZTY2KzY1ZmI5ZXdu?=
 =?utf-8?B?akJ5SVlFK0NRd0hVRUxjYXVmbVk3UHNRdUt4eEt1dUtiUkJ4N2RCU2l0MEN1?=
 =?utf-8?B?SWNkczdObzBGcTZaZWtpRWhjbE5oV2FXMnB0bEpXRWFnWTRidjR3Y00wbGo5?=
 =?utf-8?B?MUo5OWdqZmQwNnVGOEVzcEx3OFV6Z0UwRGxNRWhtUzJIa040MkZTemlMbUQw?=
 =?utf-8?B?Z0pOSVgxdHdtbkZYSUZGS3RrY1VVamx1ZzFpb0NQUGNiYlFIcE9LSkhMaWQ1?=
 =?utf-8?Q?UmKY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUVQWmlIMHJTZ1lwSU9tZnRVNkJybENaR1c1UzU3aXAyVVFUVUVOai9kckQ5?=
 =?utf-8?B?eGhnTUp5cVBJVTkyblhtSUIydUk5eWNCby8yWTdlbUw3VGtpNUJ2aUJHNnJ1?=
 =?utf-8?B?OENVNzMrV2l3ZjBPL3hFN2VJOGg3U002aVJOYkk1b1FaaFJiVnFKL0pSaHlU?=
 =?utf-8?B?UTBUQWNYczNkTE9MY2dWdWNqYWJ3VjRCQTQ2amhkcXhLU0hraW5vVHQ4bWFo?=
 =?utf-8?B?V3RndmVjM3FCSXRTVzE2bnp3ajRFZHVuQi8rbVd5YWVHN1BBcStCTEVOMDlI?=
 =?utf-8?B?V0VVMG15bldadjF0RGtFZU5qMWRScHU2NjNTWW9lYXpBRzRMOVR1clQ2dnhR?=
 =?utf-8?B?anNUNkRybkU2T2wyQ3AyOGRlUmVuZllBZzhDL2c1blFkdHE3UUxzcVRTMUEz?=
 =?utf-8?B?dkU3SzNkdGxGL0NhVzNOOEtLN0FaV1ZLMXZUN1JhVUNpYlNIQlRodG1NVVEr?=
 =?utf-8?B?dnlKK3J3R1FDeWcrSHMzVENRL2ZTTzZBdFh2bDl4NUdtQUNSUUNqdVNLdmlj?=
 =?utf-8?B?VDNKc253d1JlZzRNLzhmYmRGVjZYeUxxZ2h1OUhwWTB0d3l0QzRXWG5JK1dU?=
 =?utf-8?B?OXEycVBZNzhBZ0xXNWhBeEZFYTRNOFFEMXNpcEtKWkJRNVlVT2tROE9UU0lB?=
 =?utf-8?B?NXdHanYxQ0cxSmw5bVhUcEFCc1BlQ3E3UVJVTVp3bVU4Y2R3WTRjOGJzbDh2?=
 =?utf-8?B?MjZmMGdSUjh4YXN4Y1VncVh5eTBuWGNLejdYbEZZWFQ0bDhLRW1RLzhzZ3Rj?=
 =?utf-8?B?d09nZ0RvcDBhMWJSeGpweEpCWGxzUzViWjY3UkpVRjk0eDJPcVlFbHA4OEk4?=
 =?utf-8?B?MDFTUnJXZTB0bGxhNmJLZGszOThFRW0zSjdtT0YzN25nYXErTkllNmpMWnV5?=
 =?utf-8?B?NldobjJFUGRjeWsyMnQ0MG1yZzBaRVZhTGVOYnZ3MDJyUWZKdFJxNk5aY2VB?=
 =?utf-8?B?L3lTcEViKzQ5enVCTzhOeHVZM1cxclhvYjZVK1FYMmhPa3pFTFovNXlzdFRv?=
 =?utf-8?B?WVNCS3pSYkF0WFFEbENRVmlsL1ZmUVJhV1BIVkRzemxJb2Q3K1RYaVoyN05H?=
 =?utf-8?B?UnZqcGhLQWV4QXYrQkErMG8xYllXTFJIOHdUVlE4RjA0QUh6aU05YzVzR1pD?=
 =?utf-8?B?WHRzcXdRSG1zeWZwNVU5c1ZONlQvVnNVZ1NxUjhwVlFhL3BDeE1sZUtzL0pz?=
 =?utf-8?B?L01KanBzUUo0c2x5dVZQZUxMOWJyMHVXN3UrTldEKytvUElhWFJrZmlGbGQ4?=
 =?utf-8?B?Y3Zva2Q4TkdDSTVVR2FSOFBueVloTmEyZ1U0NXB0M0x6TjJBZE1temVwS3Bx?=
 =?utf-8?B?OHRRcnZObVBKQTZlQTJyN0ZLSFdJOWF3RHp3N3dlYk1tTS9YQkh1NGdhTERS?=
 =?utf-8?B?c2pGOXh1bFlpemVhVlVFby9Wb0luT2VpOFFpWU9BazhXeE5wTUtPZGZGRFV1?=
 =?utf-8?B?RFFQRGJDYWptT1N3dFArLzRlMDZRNndsVDNGcjVVZGFZZmpSaEVRLzBqdnZy?=
 =?utf-8?B?L3hjVzVhSWpkZnJQN2ZCaDd5VzNXZ0pVMWhZbEttMGdCN0hTTk0rY3RTUG4v?=
 =?utf-8?B?MnVXZ25RM2FzdUd1bktCT2wxRG9GQUpEdzMvTEx5Um1WZHNyS1hkbEx3elRx?=
 =?utf-8?B?RFluVys5cUVsTzN2a0JROGY4VWdJMXFwa0R6SnVhZS9BRXBLSERUd29DV20z?=
 =?utf-8?B?eUduWGlOU0dpTHV4L09oRXJ2RVpPNjF4ZjFSVVZ4b0Vscm9UM0V0cDNEcnJy?=
 =?utf-8?B?bXZybDhnMHRkeTVNbFluQzFxMStGRkYzUjRlOE1EYThNUTMyVFZVVW5KcjNT?=
 =?utf-8?B?NGRuYlBtM1lDaGhLRTE0eXpnbktvZ0dxUzJHMmozZEFLL3RHWm01KzNMZGtW?=
 =?utf-8?B?UmIvZ2FkVlhqZGVnV0psMkJLZEZoazU4a0I4WHlpMHJyeFBlTWEwb090cWtl?=
 =?utf-8?B?STlpQklnOXAxNjB1RnRzaGFMQjNUMUFhaDZKNE5nbHB4ZUxveERrMzZHSndY?=
 =?utf-8?B?QmpBQjFZb0lBRnhrZWhRbTVZUmI2RG9RUFByWDk2V0Y0bTVnZ1M2aVpidFFW?=
 =?utf-8?B?RGJUY1ZJaGJObUhWUjJkbmtoQ0x1ZmNaVVpFVUZCSHBrSFp4ZUpzN3RnMG50?=
 =?utf-8?B?ay9iOXdpRkgrWENmLzRlOVNucVpBVjNlaG8zVkxQSDhzYy9hS2dxRk9sL2xa?=
 =?utf-8?B?enY4akVWaUV3TTc1aWtQcWlCa3RObEVCbGl0NzJic0hpMWZqcDA5TGs5TnRt?=
 =?utf-8?B?NStJZzF3NmVudzBMR21mS2J1VEd4OFVxKzJJL2UzWnZhS2N5TSt5YnZsUHZZ?=
 =?utf-8?B?VS9FMlExdVRuVGN3SEJGNlc5YXN4T3VxcjliNXBiYWp2Uit3OU9tekFlMklz?=
 =?utf-8?Q?s7oHX+chl98bjCQE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8658ce6-a12a-42ae-f368-08de68feebc8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 23:48:42.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgikPdgJWQIESs+jzxRJL1uaRHkcj10H+YEoW19wJgGC089gN3HBbbXQ1Fg2fIYnJ1Kve9SJJGkSJRUW91WC51fjmayIP4ONlmntcXQpuNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6049
X-OriginatorOrg: intel.com

Keith Busch wrote:
> On Tue, Feb 10, 2026 at 02:03:54PM -0800, dan.j.williams@intel.com wrote:
> > Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > The Linux pci driver resolves a "slot" to the "D" in the B:D.f (see
> > > PCI_SLOT()). A pcie "slot reset" is a secondary bus reset, which affects
> > 
> > Maybe change "pci" and "pcie" to "pciehp" above to make it clear this problem is
> > specific to the native PCIe hotplug driver?
> 
> Good point, and given that, should I just drop this patch? The previous
> one fixes up this slot assignment issue for pciehp, so we could consider
> taking either "2" or "3", but not necessarily both. I included both in
> this series because I'm not sure if there is a preference. My best
> reasoning to take both is if we want to proactively handle the entire
> bus for all platforms requesting a slot reset, but also leave us an easy
> revert if it causes a problem.

My only comment there would be that the bug fix that happened in "2" was
subtle. So I would say at a minimum clarify "2" as a fix for pciehp and
that "3" is a opportunistic fix for other reset scenarios. ...if I
understand the incremental value of "3" correctly.
