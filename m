Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0A311975;
	Fri, 23 Jan 2026 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132430; cv=fail; b=n1+0N92GPXJPLugSgOIqiGoAclR0CL/x7Q8zdQf1rO8AAwiPu4lkNsqX3Y5QSGEDixixdypeSrTQdOqOD+zJxoS94/f0OfMEsQ4tEqAJl03n44DvLyfgAl1jSadTBZ1TZbSotUXi36RDmE0q9n3SReXZUZSeusDTIE7SteqGt2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132430; c=relaxed/simple;
	bh=Cikmf1Rk4dQ4T342gXnWqdQ7UyP1IuuWwiO1UOv3MzU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=qCkKZZpUVeEgLF0vq3XgpR9ocZkDszOk9ENgju2A1m+08A8SVd8g5CgewWM2dn7jq5FIuy3Pkw1E0THvnxiMDHN2EBwR5m70+nGLND6DhJMBQPLMmHbisiLiQr0xZ4aVB6SHdlWYYltWLy7VUqc7JOLcXm1q6Cmeweao3Ld7uUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=geLT5lf7; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="geLT5lf7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769132412; x=1800668412;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Cikmf1Rk4dQ4T342gXnWqdQ7UyP1IuuWwiO1UOv3MzU=;
  b=geLT5lf7iKN9n3NcRNK3LcsuitH2TAl93fsZ1VkDLsWBqbxHyacO2KV/
   Ykx4Jkdtjidx9V2A9Jmco5kDkg1h5sGF+kL78ZNZaxuzGyR/EyGYC2sNj
   3z9dnNedo7zQ1cSIbF87GLxrPzpYusSPAeQgIunklBCHlXlQ2zjRakxl2
   xcZoWa/8gYszPVOa454KH92Au6Qi/uu2Ng1a+Lh/fcxphYibcfSaO954F
   Vb0oB2jmH/Ik+idIXtLpNLsVyoYPLxkfY/Ihr5DF3XWorBQYb5NdLCoP9
   DcdJlv+DECUK0xOAvu6AI++0kvsmoPUqD2KW25DzlJPy8PgQEHvMXKzwt
   A==;
X-CSE-ConnectionGUID: YG2CwyerSBarhbDEuc2JGA==
X-CSE-MsgGUID: RQ3hZLSQSCew1EScZ49+bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74015649"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="74015649"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 17:40:09 -0800
X-CSE-ConnectionGUID: Sm7t3VLATTOHF9VimOW5dQ==
X-CSE-MsgGUID: Q7qYnmcMTZGXI07c4RtPww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="206008737"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 17:40:09 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 17:40:07 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 17:40:07 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 17:40:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7gKZ2DQGjx4bdUFVCFeVzff1WyNUbkjdfie5E3q4xR5PUQMnEkJ13OXE/zxmGGxFGBmxagntyrujc2JyrxCybwoxi84MMdFD7VFRsjpyOoenlnX8uGhgwyCQy3j0wqjsaMDL3x8wtyNMMPthZN2535QNx3p40CAShwy4pkUD7tvY5YeyzNZ/Z0P/L3oMHt6OjNfz/Er4HBwh0pc1voeV+LVoPV8YMTpMoK7TuYhnuBf3wYtc2ppJxWLSmDMmayACHK2Sdk6q8uvmIy4CPUepxI47ND/rJR+a+RGBDgwix2PFZkTeBooYue+j2ms+J6pc2aVlpNnRgdFJlQiMf2tpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOUyxngpQb1zsakEnJYd16VDYZvVYMWtemhb1z5KLbw=;
 b=J3U0vbTHmIezI0hjqquU9fxTXqK5Vhz8yS/bA0M3gl+nduVBElOtc0NPnMaWdK2JXbzGjUp1ZtDwmpdQcCiebY180eYNG0+qb8eO0ag2pIuFFr81XVJ8tRkMs9KA7tUoQ3MVB8PpETvfUOAybcImloyPQTHi5XRSSHaY27K2ohJcoDd4OgGl8OWRF68OPyOMgxIdrqvQzctGBJZbc3j/Tf08AiQRZD+hYC1MX6nd+NRuVobKBDPNVlNJMZ0aXnB9KD2Uj0z1yo1Y87aGOO0envrOLUfub+P81Mia/3XPMLTGWTE6yZMhREf7M0GswQlzr95/feiTcYYI8Dlaj/CPZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8686.namprd11.prod.outlook.com (2603:10b6:8:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 01:40:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 01:40:05 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 17:40:03 -0800
To: <dan.j.williams@intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Li Ming
	<ming.li@zohomail.com>
CC: <dan.j.williams@intel.com>, <linux-pci@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Message-ID: <6972d173120e1_1d33100d8@dwillia2-mobl4.notmuch>
In-Reply-To: <6967c10429f19_34d2a10027@dwillia2-mobl4.notmuch>
References: <20260111073823.486665-1-ming.li@zohomail.com>
 <20260113191003.GA776139@bhelgaas>
 <6967c10429f19_34d2a10027@dwillia2-mobl4.notmuch>
Subject: Re: [PATCH 1/1] PCI/IDE: Fix reading a wrong reg for unused sel
 stream initialization
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df59dd4-5162-4336-d2ec-08de5a2054f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OG1QTTV5T3BKN2J0SVMreTB2d0pqbHJ6dHJXL1RhbEdocS9xeDZleGI4TGhI?=
 =?utf-8?B?WWxlS0VHOWt1eCs1VVd0L1pBQUpmUmo5dXVhWWgvd2RQZWg5NVhZUDVvQXRM?=
 =?utf-8?B?LzZkU29vQlp3YzQ1ZkxZRkx5dG9SUSt1NVFzTGYvQ2xhSVNEUnhOYWhYN0g0?=
 =?utf-8?B?UTRDdGZzcFl5N0t4L0o5cmNjdjVlRlJnWU0zRjVRMXJ2S0FnUFRZRktxZXkr?=
 =?utf-8?B?eWtrdGpiQ1BTSEZqV1J4TXhWc1pIQ2dqZTJySk9qVG00ZHROcGJHNzh4akQ2?=
 =?utf-8?B?RTdUS3dGblY2YjV3dUprQ0lOdE82QW1LQXc5NzdkUTh0dGtEK0hHTGpycGtB?=
 =?utf-8?B?d1ZZNk5NVUtMdTU2dDlxcEFMdUhwbEQ1WkhaV1hxQTNyYmVJNjZoVnUzOXY0?=
 =?utf-8?B?YjEveVFObURweVBadlI5WFBIU1ZVREJZNzg5MFN3eUZObXloZUxRejR0dXgy?=
 =?utf-8?B?a2dhcnZIektjeHdVS0VobEQvdTdkVXQ4TDZoNFFYMU5zeTJSdFFaNmg1N2xt?=
 =?utf-8?B?cVloU2FSbDNPa3hvdkFQSTROaVhYWVcvc0h6Ujd6V3NaK3ZaTzlJRDhDQ3lF?=
 =?utf-8?B?UWFuVDlERnVhMlEwNHdraW1Nd1phcm5Od1BkMTNYVXVQaHlyUkpsc1ZRRE43?=
 =?utf-8?B?YnZwNkJVbGY4MklDMG9ucTZETUpVVlB5ZXV6b3VQS1FGQUpiazBVdDRwZFRU?=
 =?utf-8?B?WTVuTVRnbkUvSHpFbFBuOFpqVHlOU2FaRFFFTktHTDJBNmlwZ3Jwa3Z1VCtn?=
 =?utf-8?B?by9DUFIvV1Juam5uNVZ5WmkwcDB4Q0g3dzFDNjRVbjRsaitTT2dYUzY0dTVX?=
 =?utf-8?B?b0k4MXo0bkVxWU5PMnFrZ1VWQ2duN0dVT1J5SDdiYnk1ZDRxM1E5cTZiVHB1?=
 =?utf-8?B?NkExdUJGaXB4YStoNElacHpnWldEakpxaW5JYXhaUWw0SWdGWmFHSUFvN0dY?=
 =?utf-8?B?T0JJRjlmZmMrOVlqRVFUSk5jQnNOUDUvN200VnZZeG9idkFRSW83OU5xdEhR?=
 =?utf-8?B?LzM2WUVuczlDVmFXeTJXMko4VmU5UHJWY3pxMmozM2ZWOUVIZ0x5SWV0N09M?=
 =?utf-8?B?aEVkZ3BxWGdrb2I3cGNjZVRyUFhwdjNvVzJNc08vSmZqWnVhUmxtVGRzellh?=
 =?utf-8?B?YmpFUTFlZVpwaldJb0piRWtXMmxaTDN4L3cwaWZjZUdTVGNhMldaY2svSkht?=
 =?utf-8?B?S0lNQThDWERnb0ZHQzNuWE9iWjVra0xoa3Jrc3NtR2lYbzhLMTZDRzhDQnJs?=
 =?utf-8?B?SEtZRTBkR09NQkhyMU9wOVdvME9yT2p2NSt2a1JDU1dLanZlNXJjaWZ6Wldl?=
 =?utf-8?B?Qk5QUTBpK1NOVTZpakY4aDFYMWl5UGFvN0taNTY4dnVZTytqWDhqaDRwcGN5?=
 =?utf-8?B?eS9ndjVZSm1YUnkyZDZCNnJKZHp4Z1NJL0h0a21QYUpjWktndEVXS3JIMFFK?=
 =?utf-8?B?S3Qvdmo2SEd6ckQrU3hwdGR6RWg1RkF0enB4YitxL0xwNlA1UmJnblZ4aWo3?=
 =?utf-8?B?WkU1QXZub0FRRGdMYzY0QjJpNXlUcmUvT2toRGtJbFZmN2dDUTJXN2p3bEtx?=
 =?utf-8?B?MkFYYXZGRXl2VnpNUXk5S1dBTHZTenZyY05YQjN3dDc3QlRhNytTSHFFcW9Q?=
 =?utf-8?B?MnErSVFNV2ZHTlZYV2Y3ZGxOVDdvclI5cHRQTVNHSTRpSzJTNitGQ2FDMWpU?=
 =?utf-8?B?SUFnenRzTVJGdmZROGVkOXNOY01UL0I1QU1qQ1Y1OVNhOVRucTh6QjRIRGtj?=
 =?utf-8?B?WkUyNVc3UVdOVVpsTmJFNExPYjNSelFGd0FJTnU0dlZpOFM5ZXQyOVdBZ1h5?=
 =?utf-8?B?YUdROWJiTGRUMzJNbXlCMDVsU2E1NW5QbEpmYkJ5VVNJSmFTOXNtYVMvSGZ3?=
 =?utf-8?B?RC9zTW94cGlYYjcvR21uRm1sZlJhOHgrQWI1a3NuSGVwaDJUdXB1WWUyK3JK?=
 =?utf-8?B?TFZ5dzRicVBCTENhdXpwdW1TMEVjalVScGVvMFFuVFNpOWx4VDMrSjdBWjRM?=
 =?utf-8?B?elFOWHh0KzB4OUsrL0t1VnZzQ1EwRk4wV0hISm5ZbTE4UDhEMEtxK2xIL2dq?=
 =?utf-8?B?bi9NM1RxeUNjTHk1ZEJZVjRIOTF0TGhCR0VMQjRKUXdybk1rTFFUYkRRMDJl?=
 =?utf-8?Q?mdIU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlFKdDd4UUN0SVB1c0hEL1Y5UVVPY2JHZDBOaHJFMWRocnpheWFzTXRCVjk2?=
 =?utf-8?B?U29qWlo1V3BWRFpJemJWSjg1cmF1ODJlSVlaWGVBSGF6OVAya1daLzVwYWhG?=
 =?utf-8?B?b0RUUkNwREl4UmpUcGw3UGZEcUJ6b1JFaVBIU01kSnBGUms4eDlBRGdRb01D?=
 =?utf-8?B?SURnbmxqTmhpM2xoemtQMURZNStkbTFUMWNLTjNodWdQUmFvZmpteHNqQ1k0?=
 =?utf-8?B?S2wvL256SlFTZkF4ZjFWQjR3djNEeklCM3VzM2FxVFlzOWpubnQxN3NxdFQ5?=
 =?utf-8?B?cVRlZkF5TGxyZytyaHZWOUJhL1RXVlpEeFlBK24rVm9FMXFLN1NTbXVNVHVW?=
 =?utf-8?B?ZS8wZzY0N2VPdDBLRE12R2hmM3doRnFSR2NaOXVIOU8xYjlzcXZ6TUlYL1ND?=
 =?utf-8?B?b0JsSGRCMW9CVlJQaU1Jb1h5TW5SUXpOZ3NuWTJEOU52czBSZnZ5eHh0YlZh?=
 =?utf-8?B?UGRGQUlSblA2T09nUHNLTnVzVkdIVk13UFhxRlhNY1A2a2dBOUIxMnhOZVZa?=
 =?utf-8?B?QS9NeDcvaEpNSys3dDRGYm1NbTlSclNOQ0k4RFpxSE1aZzk1ZU44a0VHV1Jk?=
 =?utf-8?B?WEVEdlpiWGR5Q29HcWNKQWZsNHJwTEZET1VQN1RsTWFjQnZsQlBsTHVocjRG?=
 =?utf-8?B?RHY4cGJkUVBid3ZNVmt1MXJDRlo2QjUvZlBLVFZ6b3RxbVJjcVBtZFZYWHlK?=
 =?utf-8?B?cUNZaWYwS3c1YnR2MVdrZW9iQWw3RVpnMWhLc0YrWlhEc09YUlZMMHU0RTNH?=
 =?utf-8?B?M3lrZHpBcSs2bmJzMkJmOTM2Tk80ZkI2TGZ3TXVhOW1rVWtvZHJMRitpamVs?=
 =?utf-8?B?Kzh1dW1GU28yQm4vYTZXMWRmKzB0WTdXY0Y2bWxLQUhMZmRGN1luU0xGWjlL?=
 =?utf-8?B?RW4ya0JrRjNsSFlJM0prZWxXcTArMUtWSmdFRGo3QitLY09NNHpXRmxWcFVJ?=
 =?utf-8?B?K0diTGU1RFhlbmpuY21STkwwbFgrL3N0SnFTNVJzeXhZRW8wQ1I0N0R5bW1y?=
 =?utf-8?B?ODJaSkJ5by9UUmg5THN1ZUJSLzFDc0dxa0RTejZLa1VFNzhBSzJmTHE0QjZV?=
 =?utf-8?B?aTFpdUhqSXAwcVVBdFdaWkFDbFJSY2pQVklJYng5ZENjcWx2NU54ODUvR3hQ?=
 =?utf-8?B?QzhnTHZyQ3ZIOEE4QnFTQkw0dkR1YW9zOVBOUGx1MlU4N1R1bk9UdUlJYlpG?=
 =?utf-8?B?RWRiWjNkancxYWtZQllOMk91eEpyWlErbVBHYzJxbmttbHpYVkNtbVk4dzRH?=
 =?utf-8?B?SVlwSU5ZclNxck9yRTNmdDkvRjlZbVhCTkVKd20yMEhoa0JVbmdTMDd4NXNR?=
 =?utf-8?B?djUzV29ROGxrSjJVQk9HZU9UUGhiaHBhUDZ1RC9menVrUGxSVmdaZzJ5aEdO?=
 =?utf-8?B?K3Bzb3FGOVhSMU9SNFpUQmlGR2p0M2Nnb2hjN2xGN1owemRZTTNOblpNUFJG?=
 =?utf-8?B?UzhwdjhYb2FzcG1IMUllK3RaaXh1RHI1K25lUnN2SDh2WDR1WHBhd0gzN3Ey?=
 =?utf-8?B?c0hWMW42T2cwangrOEtyNDY4dHN6eityL2lQMXZyekJCK0pCMXRoZ0FlV244?=
 =?utf-8?B?RVo4enMza1RLQmdxdVU2OExYVmxnd3Nua0llS2ZOTExYa0NSblo4TFpGWjhh?=
 =?utf-8?B?dTVsQWdzZThGbmJXZGgzVGtqdjJlNnRwcmdhZG9aMVVsWFVWVmQvZ1pCTzNR?=
 =?utf-8?B?Q1M4NVBIdHlJamlUemZpc1Q5WWpKTytuZWcva3MwSnZmRHh1MTd2dWkrWkE2?=
 =?utf-8?B?YVF5Njdma0lJR2RxM2V0VXVuWXhCNHkwWGN1WFZuMG54b1pNSUhWaENGczNS?=
 =?utf-8?B?bTlLZ05kb1lGTkgxOE03RW9vT1pxV3FWUUlBRWpOZjRTWm9kVnJRdzczVzFw?=
 =?utf-8?B?RHlUOEZ2QTUwM2tZZ0lGREt1WHhxYkM3Yk1JZldiSjZ4NjlhdVZjZEhFcU1a?=
 =?utf-8?B?azdtNDhuSFVWbllsQXlhTXRWU0FyVlNIeVg4VVlJSXViY2RnakpJUXNMZ3Vt?=
 =?utf-8?B?VzluckhDaUZsb0NKT3ZTZ3pBaXRxa0dpMm1OSGUvQ1VzTHdsZHA3bzhmck92?=
 =?utf-8?B?TmhiRkhCSVpWdXBuNnZ1VllaVmlJVHJrMUI4blZmUVZZTVhKZFpkS3ZVL0k4?=
 =?utf-8?B?emdBdWU1VmkwYWtpS2tac0x2ZGQ5VXZWa0VhOXY1aXRESkJnSzFoMm9lYjJD?=
 =?utf-8?B?ck42SUlhZlVxTWlqWW16L09pSFg3VWVJQ0FqUE13eGhOS0lKTkpFVG5pRm5u?=
 =?utf-8?B?V1dFeVNaaHFWRjA1bmpNN3VRQytGSjRUZ0E0dlBjSjhNS0lLV3BkdVM5bEls?=
 =?utf-8?B?dHJpZ2Q4OUdEeHhkSjc5Vm5XQjlKcmxaYjZ4ODZmWUtqZk5MUU5DbUVZaURT?=
 =?utf-8?Q?wMX5jZJxl/KUaNlg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df59dd4-5162-4336-d2ec-08de5a2054f1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 01:40:04.9796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+Se9bwuDGG6Rz64mR98/OnChniIvXkI0YOg/F3ZfdJF/ApViKrAMGaJ7tEvnCh4MSWh4adU54zswxqHYE3UgCR6sRJy0060QKdpQM8L2Qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8686
X-OriginatorOrg: intel.com

dan.j.williams@ wrote:
> Bjorn Helgaas wrote:
> > On Sun, Jan 11, 2026 at 03:38:23PM +0800, Li Ming wrote:
> > > During pci_ide_init(), it will write PCI_ID_RESERVED_STREAM_ID into all
> > > unused selective IDE stream blocks. In a selective IDE stream block, IDE
> > > stream ID field is in selective IDE stream control register instead of
> > > selective IDE stream capability register.
> > > 
> > > Fixes: 079115370d00 ("PCI/IDE: Initialize an ID for all IDE streams")
> > > Signed-off-by: Li Ming <ming.li@zohomail.com>
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Dan, I assume you'll take this?  It looks like you've merged
> > everything to do with ide.c.
> 
> Yes, I have cleared some CXL backlog from over the holidays and will get
> this queued.

Now applied and will show up soon in tsm.git.
