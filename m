Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184FE2989A2
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633244; cv=fail; b=RsWYh1GE4qdjFWm+nu+nawCnNIA4uju5SPOo+VsRVWopmmwrfDYAR+t6EWn10GNuaM/nAa8lFsuxfgiyF+/91fYybqudXaP0cosFbsSqELAWjcY7/6AnsDbfHDR7pZk8Dy6l0ZYFtTyiOEvAxmZVTXI2F2Ib6d39ueSMYG7WBvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633244; c=relaxed/simple;
	bh=rIIu7SIGs/O2INyBbqvtWOgrM/Wfe5gOrD6xCK6TTds=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=HgTnM4sRm0hNlS80hcne01pQkBtEE3aaG0B0wRILduO1BpqiKEdd9b1VgvSgdIcSTYo99LD+yF0MDk71tTQxaibK+DaAGersDYWF3qayh9MK/kXHPrDg99gwnbKPARjZE9NdZtTHrgRkvjSdP/5cFwulhgqTACNRAzPFs6jHpj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ko4k+yzl; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ko4k+yzl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769633244; x=1801169244;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=rIIu7SIGs/O2INyBbqvtWOgrM/Wfe5gOrD6xCK6TTds=;
  b=Ko4k+yzlk0+acnQPy0myzTnnjXicBxsjlUEsMBENr6I8lyv9TGU7lB0Y
   vOwXwC7DaeWkXkrAxauAXEbk6FQbGpEsiGipp5/1ZzDMFnXQCvAig2HHI
   3fR8jcDqZH/eHDhaxeoFqemqoIT6tFYCh9OKkXDGHmRIxlsjhkeJ3EyXd
   2NntyBdm15MfF/vQ2Hifg76K0J6qUq4ZBQBqn25Zric4z/VITbuZLj0cN
   YwnrbXpUsoxmJLaZHQV4JA+aMS4htbv6v3gQqzeaDlUBcLe6+G2da2eh4
   AznbsoVEciGRZemcdORmzoWNFyNjUkJ/woWm0Ng+8iMhC20dS7hIp5wtV
   Q==;
X-CSE-ConnectionGUID: NNnq8tm7STih1e1s4rQoyw==
X-CSE-MsgGUID: D6/JfMI0SZ+wc/5jA1L0vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="74707210"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="74707210"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 12:47:23 -0800
X-CSE-ConnectionGUID: ay0mnYAKS4qNRv3QNpVUyg==
X-CSE-MsgGUID: G3TAL5DcQhW3TZOH0PlEWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208802103"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 12:47:21 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 12:47:21 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 12:47:21 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 12:47:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIJI5GAZicnfmVJ9n3kMvlTzo3VZdYhJSmuUND0+nQ3CuX9c6nnFOojUoK1MQYz6wvvINS44GK2uqnNX8Pg41WgMWRlqPhPbN2oTlSpL2lDbLsy8RTavK58jwolOo5ePZiLkCKq6Jz4rOJe0EFGarS0zRDVQK+TBwQo5IdVbPm+Z1uj0oBMXp5Pq14bllxZtsKV3+zqT1FfdOhMBz5A9nK2sRZdgOJI2ABtooTlIU87UBfcNgJtaVsOyHQ3oeo1dtLOBb2i5kTj58F2VubYqfdy+Me5vEsmh7kWOp7y1miv+Zw/Abuy3XCVF3pAcv6B2owBogwZi12zG1o/MjP5mSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oERYcYHCjYNSPNEFXqg7P5DBNbWDZqz9rSPvAUbe0Cs=;
 b=ZYRztR56UZ/m+LiG4k4f0JnS8y/K0cqNjyUcos6bv8z6tgori5F66PFaGOZQJWfL/jUl/uQVGpEvCj31jnWM5vXyNgIuVlCxm4Ht73SKppk9rsmeGF7B8/MnJi/sI/mZjaiysVVZBCeUSJdk7P3Di3WTWziLflZyE2DEu76naa30JA3ZMDtpP43vn+OnyuYLTNELfkq7nKkrdx3hXlHdatLvL8bRkvsV1ieqm9xRczgT9LyfCwIfzFO1Z8aWxLLF0VRRycN+yAR9ECZAuNZvfJZKRnxf1CgpWziHzgczA9Vqo9MzFJlspJLJRi4TMxjGC4R9WAKISRN17N414xYggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB8291.namprd11.prod.outlook.com (2603:10b6:303:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 20:47:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 20:47:18 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 28 Jan 2026 12:47:16 -0800
To: Keith Busch <kbusch@meta.com>, <linux-pci@vger.kernel.org>,
	<bhelgaas@google.com>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <helgaas@kernel.org>, Keith Busch
	<kbusch@kernel.org>
Message-ID: <697a75d4a0af5_3095100aa@dwillia2-mobl4.notmuch>
In-Reply-To: <20260116184150.3013258-1-kbusch@meta.com>
References: <20260116184150.3013258-1-kbusch@meta.com>
Subject: Re: [PATCH 1/2] pci: fix slot trylock error handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: b05e40e7-9ef4-42db-b81c-08de5eae6cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU1VTXNpNHZHczlnUDVhNTlCZk5GckI2K0JpTlF4VHpmQlVqdUE5SXZEaXZH?=
 =?utf-8?B?REI3eVpyTDZwZERZeno2TnVSUm81MVdRcStERDJDaXYrTmRtaHJyaDg5M2JJ?=
 =?utf-8?B?TXVHcUpJL0xZY3lRM09MRDhMNVQ2bzlMVmxBbU4rSHh5dzdJZXorZ0N5cEZi?=
 =?utf-8?B?cGNXT1hkMmZSTis3UytQR1BoK3NKMENMUWhyb09FbitnYWpzc0RNcUY2NkdD?=
 =?utf-8?B?SERGeElDZ1JCelFnOTN0akhsY2NSdkxIZm8wc3UvT2J3MDIvVFRMQjFSK0NN?=
 =?utf-8?B?Q1JKMWh1c3dxTGVWS043MFBVMlhsa3YybnlKQTZmZXZLKzBtRC8wSmd2dGo1?=
 =?utf-8?B?WDVkMUw2VEVJRExkbXk3eXZUN3kxVWxNenk3OHdYaEVGaE44UDhlSFJuUGNz?=
 =?utf-8?B?NFpZNWZLdWRNZUNIRkdzTzdtVXdKcFBCcXdwcWd3OHhnWStTRDFEWVQ5YlZW?=
 =?utf-8?B?QzdTdEp3YnU1OFlGU0hpTWt2K293M1QzbDhVaWVzOTFpbXNFUHBQMVV4a0NF?=
 =?utf-8?B?L0RWcGhadWJZRUUvbVZQTzhQdVZNSHFscFA1ME5way9yeitMT3B1Vm5rNytF?=
 =?utf-8?B?NSt3eWtteWFNZjBLY2pLT2VUck15TkFhUFEyR3FQY3JaSDIrYnljU0RGU1Vw?=
 =?utf-8?B?SUdrWU1GYzQ5QW5oejkrV2h4Q3ZFdGJoK1RsMUdNVTgrM2xjOFBWRjIweUVp?=
 =?utf-8?B?UHVqWThWWjMrd1QvT29tbFY4VUYrVm14RHo3ZEhkeldTZ3JIeWE5ZTZhZE13?=
 =?utf-8?B?aENFcThrTE5Iem9hckFlbDZMVHJTbHlhS2hmaDlSTWFlSldCY0dUVUQ1QmdT?=
 =?utf-8?B?UDMrTUoxN0k2TEJMbmFmZUppYVMrUkkzRlNuMjJVWXppeU9sR3Vuek0xaXQv?=
 =?utf-8?B?Wm1sUGFzT3RDWUNmU3VIT0pWUTRHZ2VheURrdzgvQ3JpUFVOSDJFS0lBS3R1?=
 =?utf-8?B?T0t0TzFuaGNncjIzUk5DeUhKTDR3QVdNa1pjUTM3TUhMSHJCeDllVlJLMWpU?=
 =?utf-8?B?REZvdUVHWDltNXM0YkRRaUV6SDExOFdzVDk2ZFVacmxnWTlyQ1pYNUFma2la?=
 =?utf-8?B?NkpDUUswWlZYWXp3MHdkVEw0aGFva0xBRHBxTmpjYVRvcmpWYVBmUzAxWk1o?=
 =?utf-8?B?T2l3Uk1IbVRIcGVSN1dMRDBheEZqTS9iYjQ1VzhSeUFMOHBWT1RaazJoT3Bl?=
 =?utf-8?B?dFpyeVJrMHg0N1FsWUc4bXRUeThwRm1ScFpiNjh5bFZKVU5NTTR5cEVSS0Nv?=
 =?utf-8?B?TGxja2JZMGMwcFcyL25hK3VjalZzUjE3SXhwZWovczhYQVpsbHVQd2xiRHBa?=
 =?utf-8?B?YWdqaFdxSmo0engzNlNXeUw0MlFlMW5TdVpiUXNsMThua3ZhMEJlTE1od2lS?=
 =?utf-8?B?aDd6ZTRZYjVDWitGckZSVjRFSE9rZ0NJNGJyVlVvcUhlWmY1RlkrMzlDOHpk?=
 =?utf-8?B?RGFlYjF5UnpIRlBIZjFWNGM0RytEWWZvTXZVWnUzajdmLzM2anZOMlJqU0g5?=
 =?utf-8?B?UkdMekM3ZHlYRUlWdGFSRHNTK3dycVcrUngrSHFRSGIxTWNZVnJrYWF6bHlX?=
 =?utf-8?B?YVhma2pLR0lnTDhPN0VYUVpseWg5RGh4aG80bnVPNEt1TSsxVTE1TmhGdzIz?=
 =?utf-8?B?NmM2Z2d2eXhmOUQrYXRDZ3pIajN0UnA0ZGJnamN3R2ZlSTloWEt6UVRXczkr?=
 =?utf-8?B?bFNRYnl1eGJYUzAwVkJzeExLMmNhQm8vSGFvT1k1RHU5aUgwM1lpL2hjOVRS?=
 =?utf-8?B?OTY3UUQyZU4wdDFOaHNDUGkzNWlROWNSNjV1cHpRSkVra2EwVlR6VDhoYUVm?=
 =?utf-8?B?dU1VMFVXRWVhTm1hR2t6UWtIUERacVlmSXdOZmZSUUwrTUFicktlZnNMWVFr?=
 =?utf-8?B?Zm50bnU2TW9XRk9WN0NMMWZYaGp4THhmM2MxL1JQdmhCVVdGT1FualljOTNB?=
 =?utf-8?B?OFBJNjd0OGdGaUVVZDNTTnpKRzlwaGw3TlQreW5PbkVGR1VIWDhUaEpkem5L?=
 =?utf-8?B?Qy8vMWU5amFlc1lRc0JKaVlrQ1ZMaHZFdGo1U3U2cll6YjNlQkFqaVhOS1BH?=
 =?utf-8?B?d1dNaDNCYmNGMGg3VEFRcHhRTUNqZzIxa25MUDZsWmtRLzN6dFdaVmlEay9U?=
 =?utf-8?Q?8qlA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU00MnExdDFuWHF6aGd4VHpZZ0gzc24zWmxzRnlSV0NpbDNTZklCLy9IWlAv?=
 =?utf-8?B?R0hFSlVhMXdyeTFlM05FcERQWU93RUxYRUc2R0lDMU4wajF6L2N4OHpoSzJZ?=
 =?utf-8?B?UGRqdzdDOXg2Mk56YkhjRnVWeUxIT2UxSFUzYlNUT1cwcVMxbldOcERZQ05G?=
 =?utf-8?B?VU9SS0lFNDAzZnFJTTlVTXk4WmpFdGVJbU13SjFlaGNXRTVHdkFvcC9EazdV?=
 =?utf-8?B?ZEkrcWcyblVqK0UwRWtZZE5tM1FZYWI4eDBLaHVnTmxXWlA1OTROdzF2UHFD?=
 =?utf-8?B?WlR2SFRQaDdNM016NGtwT3BsSEdJWlBDMmlramtFdWhVM3FRdXhnWitQR0VG?=
 =?utf-8?B?SjJycHNqdEdDSERPRG0wZFk2VWFvdHU2cXVtMjBwTk5mWElMVHJzMWYxL2xm?=
 =?utf-8?B?ZXA3WjFocjF6L0h4YnVyVHFzdTBUei9yK2pMWUI3V3o5eklYS1pTN2V2bklp?=
 =?utf-8?B?SWIrSzNBMFhzVXUyMkNtdldVNnpLTVlMTVVVbUxsUC9ybzVUUDVDUnN0QTRM?=
 =?utf-8?B?WDR1c000ejNKN1Y3UWpCM0V0Uk0zUENxbEFvc20yQzdyR25uS2VqVXpGL3ow?=
 =?utf-8?B?bDhOVkE2V0hXQTJLeDdLYTZvK0o5c2N0Tmo4OGg4dlc1b2ZkckVnQk1IVkxn?=
 =?utf-8?B?S0htS2F6NytPWm02OU1YRFBKK2tpQVRNdXZULzBvcUFLME1OL3dMdXJwYmY0?=
 =?utf-8?B?L3hyL2s3MWZsemVLTTNSRXVRbnQvUFMwUXdDRVV2M1Q5dnJJU2R4MDlHRUto?=
 =?utf-8?B?ZytwandPZCtoRThmNkJUZVZ0ZkphbUdYRVhuTWFkZGhwYWtmQVhHYnVhZzBC?=
 =?utf-8?B?c1ZMbEVicEF0M2NWSDVONkY5dE50RHUvQ2VLSUNPQjhhY1V4SWhsL1c4YWpT?=
 =?utf-8?B?TVJGS2JJN0xBa3ZSRkwvVnFnOXdVMlcrYzlnQW1PQlk3MUZaMkFkalpGTk0z?=
 =?utf-8?B?bUlGNmx0L1d4UUtCUXpnbmRudDBTRFJsRDJHNm8yeXJaSk51c1djdFpVQlVE?=
 =?utf-8?B?cEVFdEE5VzJrZ2s1bitka2J5aU5qdnEycUNXbmlPSDFJR2NsZysvR0o0Q3hs?=
 =?utf-8?B?OG9iNkwza0ZJbE5xaVFCMWZPdzBDODhSR3JSdG4wc0FxK2UrTkRmUm54TzBx?=
 =?utf-8?B?TDB3dnpnL1NvaEh1NzNYNG5FejdSR2toVlJnYlRyYTk1aEYvQ285V21jWWN1?=
 =?utf-8?B?OWZWMzNHRjZQYzJTSFo5VHlBOGpmc29UbFcwNk1qaXRiMXpaVk1tSWczeXBI?=
 =?utf-8?B?MXJDZkpTbjczYmFYOWlld2grZjBxRGdLcTQxb1lMdmdySEhUNnJoOGxDWTdz?=
 =?utf-8?B?aXdmL3d2bVR1UFp2c1Nyek1wb0syTDR1NEdVaithNVl0d0xLeEhhcVlUQlB1?=
 =?utf-8?B?cGlQemFRazlBbU9aRmd2S1JPVGdQVTFiRHFXRGhUTmoxTlpNek55Z3F4UHVK?=
 =?utf-8?B?Zk5meE5qSVlyRmhheDAycEVIdmVFVFhQOGJ5WGk1MmdZeVhZL21kcVNvUXVS?=
 =?utf-8?B?eWxLeUxTRWxsSk1rcTJvOFBNSm5MTFREWWwyKzIzNWkyTmkyZ2oxUHRYUzhM?=
 =?utf-8?B?N1luZ1M3d0pJYlNWQXRaTURNZ0FQTjVPcHdwa0lxcTFaL0Y5dUZOdlVNTVEz?=
 =?utf-8?B?c2U0UkprYjBUNjRQV29mYUZMaTBicXBpU0s0MkRBRTdUTjdpUjlvREpKYkJG?=
 =?utf-8?B?c05pVlExOEhobTYzaExwMU5FWTBSdWFmSEZCbjhINlBMbHc4bmFtaFRKOW5z?=
 =?utf-8?B?RzRpaVJjVUxlamswdzErK092RmVxZ3pzQzJBejFRck1acWdyOGczanQ3aDI2?=
 =?utf-8?B?U1Z1VzRJVDJkbGxHL1lPNjZLSEgyTWg1b0RrWUxWOTRzY2tLTU9POVl5a2xS?=
 =?utf-8?B?QTBLQ0NSRFBVS2cwVEI0RUZ4VDNXYm8weklkMVZXYW5yNUxWUE9SZ244MzY1?=
 =?utf-8?B?QjZsS3pVS2hoR1lwR2M1NkZxa0NtR0VIRE5JTi84RDVaT1ZzdHNIZ28yQWdo?=
 =?utf-8?B?VFpicGMxc3c5R2g5MW5FZzBndG1FcjNhb0NrMmpNeks3elpzN1FrNXVBTUVK?=
 =?utf-8?B?QlRQaUN0YnY2NElwSlBpUEJLTzJua1QrNnNIZGFBeDRJa1g2VFVqYVVhMzU5?=
 =?utf-8?B?YXFhQ3Y5MkFyYjZXbXBLVzhGWmNUK1kzaWNieVZ3dzZLT0VnZkpnSmc5N0dv?=
 =?utf-8?B?VHFQb2UvbUo0am1zbk0ydXFMdlpoaDhjQjFrZlBpQndTWThLOStzUmJqdUtQ?=
 =?utf-8?B?VDJJeFhsV1FnS3kyMGd4Y1hla0xFZTg2R1drSklIOTgxTURTOXlHbUJhbFd3?=
 =?utf-8?B?UHlIclo0cUIzYmlqdERuZDB1QXNhczNJT0xpekpVeXZsdFgyeXJ3SGxuQmY0?=
 =?utf-8?Q?LKaJVpc0xKIPiPjo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b05e40e7-9ef4-42db-b81c-08de5eae6cff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 20:47:18.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdsXVBTpJN16/m3WxTss1SqeFEggJqjy1mkTOnCfif2E2j/8L7kAG/zJC/+oiqPDRU4x+LtaOTuTeODn0X+UoiG79cTN/BfZQFEr7D/IIp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8291
X-OriginatorOrg: intel.com

Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The device lock isn't held if pci_bus_trylock() fails, so the code had
> been attempting to improperly unlock it.
> 
> Fixes: a4e772898f8bf2 ("PCI: Add missing bridge lock to pci_bus_lock()")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 72d88ea95f3cc..3378221c5723a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5494,10 +5494,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
>  		if (!dev->slot || dev->slot != slot)
>  			continue;
>  		if (dev->subordinate) {
> -			if (!pci_bus_trylock(dev->subordinate)) {
> -				pci_dev_unlock(dev);
> +			if (!pci_bus_trylock(dev->subordinate))
>  				goto unlock;
> -			}
>  		} else if (!pci_dev_trylock(dev))
>  			goto unlock;

This looks right and the original patch missed fixing up this inner
unlock when it moved the @dev lock to be conditional for non-bridge
devices.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
