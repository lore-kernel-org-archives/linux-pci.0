Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE835C192
	for <linux-pci@vger.kernel.org>; Mon,  9 Mar 2026 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052775; cv=fail; b=uVwn3gwj7njU59Nk8fD8Ydgi/1nGdUhj5CnySkzeIQDH+RFIHOmG4OU26M8NQ3g9ckTWvtPoksm+WAaJXRPW/qf3ONepf5S+GN3hRdvxnArIzMoHVNta5wo3cE5n6AW5UUv5zNoNCk+CndBPisxIdsFVkro39sJltejV+RcNBrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052775; c=relaxed/simple;
	bh=nLaWz/0CGobm5blodsL4MXU9NDPE2ffqtt6VgPsEE+0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Om8Ev6BDKGlz3/CW62DfAt3c8btenKEeQgtU3YSnbic/4uS+INNsMfe/smptzHeuZpKIq78JIUQY8BgG1W6+Pt+khCrGzLRBsZ1oIt9IB7aOVhOosNyuqVkNOdvdK1kojtNhOhbEjNNJRUr/aGY96O9c+Dln/OyaryiT9LjhnZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8HPbpIU; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8HPbpIU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773052775; x=1804588775;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nLaWz/0CGobm5blodsL4MXU9NDPE2ffqtt6VgPsEE+0=;
  b=F8HPbpIU65ylXJIzAudxzYK7UbyuqfrTHLjv4SxdIoGohw2bY95LZ7cC
   opqb+ZY0u82Np0ymv/6oI5xwsEjkWbaV2KDjCiHDknujgXX3jxeKdJpXg
   x0eu72i55OsrK4Jze6nb2wSXEVsTG+TsCaoD+Ve2U8jYeLYsKQl62XZwv
   68ExFHfdv31qyLmlSt5z+LOHpUPDRGzQbJ/9rArjs18PPEshxLFbdPtMg
   tN885SAMSOgYXCa5tSuGx7MWMMAW0E+GItHOvOECOqCAktupJ/CVMzqXR
   7wJ1mLGi9so1t5xkUNKHwg0+amxu/PDW3Z7WfgXKV0F6q/5bKMzzNUVnj
   w==;
X-CSE-ConnectionGUID: NqQgd78VQDahBwbP1Lv3gw==
X-CSE-MsgGUID: zj0tIzdBQsSmORyHAS1BTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="85545434"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="85545434"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 03:39:34 -0700
X-CSE-ConnectionGUID: ojBPdNK6SfS/lRA/88P7oQ==
X-CSE-MsgGUID: VAMgXJ1QRoStmMK2CpAIMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219657191"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 03:39:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 03:39:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 03:39:31 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 03:39:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqvUx+O5oVHzF5zk7d+rIpVQzuBwqCJFnUHFUPBRraeoja9DJDLIhZ8Pt954IewOaQw3fcGHTqVBXsu+VswkL4ntJuGwIEUG9BnjzpYNn6oJZpKnfbdsJ0WDDpUJil50iM80Cnncj1NyCJ3+PWJq5AhRGNIFT3bItr5ViMtI6uerx4c5PEEc3IDBW+/Log1xi+aqjP2dwKBepdHYEG5uyHxxMXi9yhHT8JPVq/8hB7Ai3gno8zAPioZdSP3X1G7bsLzR7MjftWBo60RUzH1pWSEXuDcnOzujMx6GxVx/J9996CFAuJ5pemGDjG7Gg5ufxqSazHO+qNZaftCthVLePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LH5Gh49vjElnF+2b+kWXDUsMr3Vxtti94UPdWM/O+Oo=;
 b=tkFi6Ck3PKZnG17oVZapsbB+mHomjnzcoyHqHwoqRJHmrK+67rqBVmoujajsNBr4jMjyWuaetP85bEblIC2wqJZbyYLgMA7tKEdxFe3BU12402xDK61th8FxUUgyY5aD8OxqQLCRm/Kd8D2ubqSH3XenSPi7afacL+gpMiYSwULKpAwwHpAoble5pWZSwZya3SheF7zscNdy+Rokz4oi/YIWLN8+HthQ1WPkjeaRpVHUmNpzpSCf9ReV6Nk7AHE3l52Xh7M7jtXv/TU4ztq4hcRqWeaTqnW5DMAC27Npe/UMrq8rTxiOiNulfWhD5AhaHu3AUtBVEFlccr1zeWnWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by SA1PR11MB8445.namprd11.prod.outlook.com (2603:10b6:806:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 10:39:29 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 10:39:29 +0000
Message-ID: <d89776ee-3101-492b-bca3-5c803fd481a0@intel.com>
Date: Mon, 9 Mar 2026 12:39:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 3/5] igc: Don't reset the hardware on
 suspend path
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	<linux-pci@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Richard Cochran
	<richardcochran@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Dima Ruinskiy <dima.ruinskiy@intel.com>
References: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
 <20260224111044.3487873-4-mika.westerberg@linux.intel.com>
Content-Language: en-US
From: "Dahan, AvigailX" <avigailx.dahan@intel.com>
In-Reply-To: <20260224111044.3487873-4-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To PH8PR11MB8013.namprd11.prod.outlook.com
 (2603:10b6:510:239::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|SA1PR11MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d59db89-e292-4c74-0234-08de7dc82447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: saHE9pjybNkMpv7awryFMGJymyJDrFBm3bSuXp/vgENMrL2hoIsbevvUfrlNhk6NqGXzGW78xDJL6l7WyFHf8Q0ir5lvOtmOG7NDM4+yjhw91LT+BoePsopKUKcFMpARqNOjLGRHUmYIDmGQOsYSybX0BmxiWzWJC6j+8OJcfiR+mJAfjG3Jvc9mBSSWChGRe0uwpJktZwVh3u2D7HJbvDyo340t5YzqpPTzHoEn9ESkTlaqCcJ14caACAroBoFJWlPikDZvgKnd56f39uTplo7NsB93Qo7kInwUIYPb1sA0Lj0SYutZjADeY7Ec7QCGZD38HLPpXVDrOWZ3OCEuKFzg/iinBoZ0HlnQgJXvocF4Gi/9VjcF1bNEiw0x2+g4XTt0OiP7BeXkWfryEWs11t9ck0bW6ULgVD393I0fdARuDHhjVcfQlF2iCYrAszj7K+ZqPigAeGOzmPH5IQ0NLf59T6Ebwlq1MY/y2H53/9Xh7bq7xxMExguAnw/J49PrFuPeX9gvnmSoceLM1cmgUhnnd12aGLCYsKlMeWKiEnKALUQaijmXxcetc003L7xvj01gj6Oa62K+6g23oYrWpu2NleGMSXkOGkaFLiGTnlYUewXosvcXBvOKjFS/Y7SHaO7oGXojaz8CM1WaT6Ego3lv/VgLJD2LCKH14AcGZTkxDZBPSm/1E9g48ppnP6q/Z+wzWX/+lrlCaOfyPxq/1i2bMHAQhTrKTCMZ5O/b7Sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3NWODRScFJIVHpwUFJJZ2twajVlYm92RDhUU05BRCtOeUs2NWltanpKVHQw?=
 =?utf-8?B?dDZhbGJEczJyTUVnQlp5Tk0wSlMwU1BJTlc0bTlRNjVmRE5UTUVlQWxOdDNm?=
 =?utf-8?B?WS9mQjNIUGV2Z0ZxNE1LTmY1ZTVsbGxMaWY1STRnWHFyT1lZRnNyU0M5Q2tC?=
 =?utf-8?B?SUduc045T0VQUXlWMG5GR3YxRU5FNkMvQ0J2bFVRVVlKaExjRzR2am8wWFZz?=
 =?utf-8?B?Uk5XdCtpLzJMaTZQQ3YzTVNFWjRLY3FIQ1llM3RhV1YybzVzdkZlWnlvSUw5?=
 =?utf-8?B?U09tRUZDRGJZZVUxY01xaTNOT0JJZTl4ZEhnQWE1NnNqcC9KZGNMMlNXLzlN?=
 =?utf-8?B?cXZaQmQrMEhncDUzdTljNnlYdjVhZ3lBbkh6YWxPZFJPVHNLaTdlMzcxWUlK?=
 =?utf-8?B?N1VNNGtObERsRHVudlIza2NBa0RrWVRNY3dVTGw5QkpRNmpIQ2g5ZC85bWVP?=
 =?utf-8?B?OWQydXhsRDlkb0RLMnJ6MFkrMDg0eUZYcEpqeGhPT09nd3FMUUFSZnNobzkx?=
 =?utf-8?B?Znl6WEJzRFpKV1U0dTJvaFlPb1V5NzMyZmw4NUJMd1hhOFNGbWVyanEwd1Nt?=
 =?utf-8?B?dU5CLzZPMEkrYzBjOGcyM0FrVUQzMnJzNGpac1k2clNWbmZzcEtQQ3dZenl3?=
 =?utf-8?B?cVlnRlVqMzkrVzBOOEpnZFJ3NG5KdGZCZU1NUmRMMmZOT3RTaEZwNVF0N3Mw?=
 =?utf-8?B?VWpidnhqTTB3UVV0dUxXaUJoeThtcDdVS3lkTTBoaysvT3lEQ0gyR3pSZHlx?=
 =?utf-8?B?SDJuemtWYWxnMWREMmFVSWxqOUxQTm9ubklERld2TmVKRjkwZHcwWjB5T09y?=
 =?utf-8?B?ZHFicXVnN1ZQQVJYVzNBa1djZ1p2dFhGS2VpQm9kSGtrekxBTUhyNkpJV2pk?=
 =?utf-8?B?WFUva0dXZ3VpNE9PWVNrcmpWZk1zWHRIN1prVlFaZTVqU3ZoQklCVC9PVENl?=
 =?utf-8?B?V3NlTUp6TU5INDVseUtFQi8xM2xrcXl5NkMrQXZ3T1ZSZFh1Tms4Vjl2WVFz?=
 =?utf-8?B?SnZJWFVNdytzcGxiWTVKNlhIUmJjeVRzZXIrSldIbzRzTkF4VEJiVlh6Z21P?=
 =?utf-8?B?aFg2RHIzdzhOeDN6ZEorNEQwVUh2WUJ2dmR6L0hocTZqNlJvZ28weHA1cHNq?=
 =?utf-8?B?Nm1FSW1LM1psUUUzTkROd1VZWlZrT1dWNkpnZGN4VzZ2bzZNZThLNTNCRUdI?=
 =?utf-8?B?MDhzRFduUDJKblRyL3UyS3RsNTAvQkYzNk9JNWZFVUdXK3BUZWdBcnU3dytt?=
 =?utf-8?B?ZlIwWVNjNCtxaFJCK2JiYWZ0NVg3bWpmOFFya1V6ajlaZGprSGtmWWhTT3Fi?=
 =?utf-8?B?Q1NOdVFkVk9TUEVMN0FOemtEWTczTWttZUVVNEJwcmVOdlRrNTN1a2RLSDU2?=
 =?utf-8?B?aC8wTFllTXl3NVFVYlRtR3o5cE5zeHJHZkFhY1NVSVJ0ZGhPaGoxTXdNbkdp?=
 =?utf-8?B?ekZmMmlLZDJNSllzWnBScERkOGRsV2JTeTEvTkhQYUdQdVY5aFY0MTNrVVRz?=
 =?utf-8?B?bkt1TzVVb0RKbC9KQllaZU1QbGwzUTFCVlhwdGN4Y29hQVpWNTIyVFcrMGpt?=
 =?utf-8?B?djFMWXBzcXZ2OTV3MmRPbVR2cTZoNG13K1p2NzUwcS9vRms5L0FIWjQ0ZHdh?=
 =?utf-8?B?N1RvUlRyNitnd3VBS24yUlVEMkd0QkNzODRlNW4rRU44ZG9qbVRUdGc5Ynoz?=
 =?utf-8?B?RUFucEhaTFZJOUZCc1FlZGpUOXBpMXBkR20rdmg5TFlBa29wRFdxWkF6dklQ?=
 =?utf-8?B?d1hlYTQ2dktsTVIvZHo5T1M1d1ZPWGgzd2lDMVF2RVFjc3YvckpoZUlIeU9j?=
 =?utf-8?B?dzhya29OOUQ1YkhFV1B0OENYdlBSOVBrcjhsZFV3NDI3Nzc2dmlDNlprdnN2?=
 =?utf-8?B?QTRMZVNTNEdrdC9uQkFqTTgrL3dscTlqc01tMTBRNC94RFk5dGdaY05tTWFN?=
 =?utf-8?B?SmtPUm1SQlEvSEREVmxMTVF5anlPc3pOKzkzQnZzaU81Z2lHSXo0eG1EeHM4?=
 =?utf-8?B?b3E0L1B0ZTc2aE5rZ1I5YkhqVnQ0aDZiY2x4cXVyRmo1eDVibGNyclpMdVNn?=
 =?utf-8?B?U0E4OUpOZmVTbC9GdVlRVTlSWUhTNmVpTFZMTEsxWldZUWUyT1FBaUo5L2Vt?=
 =?utf-8?B?aG16a2ZxQnpPVExtTEs3ckhCV2ZDbWRmZGZSdW8rUWlFSzRURTNaREZGazNW?=
 =?utf-8?B?RDVHZWZlZDVEKzVQL1lvR3k4OUplR3JEdE8za0ZaTHZIblRRWS9jMFRHa0dz?=
 =?utf-8?B?OG1rQzl2YXNWOUdFb0EzK0dDRW90RWN6QWwwZUVOWnFVOW9MZWpTN253UE5P?=
 =?utf-8?B?Yk9ESjl0WW9ZWUlLd3lUMnFVdXhlTVgraGV1TzRSSHlxbDZpbmdValcwRlpM?=
 =?utf-8?Q?Xa1Ye3zcsY7J6m5U=3D?=
X-Exchange-RoutingPolicyChecked: q2BPDZRcoQsHTeYp56KjijhJEiqZWAvYT6N9VhPKXnPVPH5boX98icHCjUIgvyG3lLWAZNnkZS8fOt5kvbUEPiSXbjCZY2kxmkNkrjsauEC3ahxwXr1h4i4CMs3So9r1P3P/xGmS1J+lhLWPn63V4NrQLziT+yk54hTMPKtJR2ny0YuLjd2hxXNGQhQBlbtYLM0O8iXhrE1l0Ad7I7sMv9p7rNgGNkdTWqfGIGMZSkyqfUyZkXKRLKNYAqTZOkE8sgMHE0dTg/dBL/pD7TENng5KLqjfwlqE9V9ZkhGFulETDCE73RjLFTj1jWKVqjJ0KizgX36v4nAJ9tBcuU8v8g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d59db89-e292-4c74-0234-08de7dc82447
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 10:39:29.1575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Y00DbdQjI+/46S30lB3KeT/K0xzSR76Es6mLuU38JZ99Gm2eniJmjmGLtoYzgLNJNIJXQO8U5ucBPaC3JtOPSspXR0TOX5tHUn7F3wubEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8445
X-OriginatorOrg: intel.com



On 24/02/2026 13:10, Mika Westerberg wrote:
> Commit c01163dbd1b8 ("PCI/PM: Always disable PTM for all devices during
> suspend") made the PCI core to suspend (disable) PTM before driver
> suspend hooks are called. In case of igc what happens is that on suspend
> path PCI core calls pci_suspend_ptm() then igc suspend hook that calls
> igc_down() that ends up calling igc_ptp_reset() (which according to the
> comment is actually needed for re-enabling the device). Anyways that
> function also poll IGC_PTM_STAT that will end up timing out because PTM
> is already disabled:
> 
>    [  160.716119] igc 0000:03:00.0 enp3s0: Timeout reading IGC_PTM_STAT register
> 
> There should be no reason resetting the hardware on suspend path so fix
> this by avoiding the reset.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h         |  2 +-
>   drivers/net/ethernet/intel/igc/igc_ethtool.c |  6 +++---
>   drivers/net/ethernet/intel/igc/igc_main.c    | 13 +++++++------
>   3 files changed, 11 insertions(+), 10 deletions(-)
> 

Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
