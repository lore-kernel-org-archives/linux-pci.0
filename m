Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D80375F86
	for <linux-pci@vger.kernel.org>; Mon,  9 Mar 2026 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052361; cv=fail; b=XxdEUsfzmOP1ic7ovd47g/Gp/8Y6aaJEdY0Okjf5KZVps3QbstN0Bx+0aGqyoccBPc+PNr+x+iRO/b08wQQ5ksXG3+Nsfx+o5cX9IUDVXCnSt8zfzwh15lfpSublgW90Azt3fAmp4YEJUXCNAEG/j8ruE3RCnu5fao5OwPyyJKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052361; c=relaxed/simple;
	bh=yV+wWjBmKcR6TbgffFE+zob6nsbmROAAxVu4tWNU1t4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tVQtbnEkX2TFZLhzsU+0QNqNHuYBz8sVihjHPG2vL0c5xrwxfYuauSuy/3gIySpUKzm42pEhV2oTC8k/3hh5tH83QCLjVML3Kewksekh8/MDnvDuyrBVMB/io/g2uOBhNJq399SH2fuH5OFLq5BmTMz8gZm7EUItvRpuFQ4LzXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OR/3wWZm; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OR/3wWZm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773052359; x=1804588359;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yV+wWjBmKcR6TbgffFE+zob6nsbmROAAxVu4tWNU1t4=;
  b=OR/3wWZmSXqckm887/Fy7A0DlC6J+Pfm0litzcm5Fc9z3t+IeM2r/F1d
   g7AchEaDUuw28d2yeYvC2LNXU1Ad0w4G711t3pzZkgE8oNsZz+OC2qwzt
   wwR+jiSNRHLuAp+/EQpckQG2BJQI3Rb+K4UzEOAcRG+kSAq45FCuSKLC8
   2Pz++tNP3+DrJjmhB5ARNf8+lBNNJFgRNLXINWlJcrG0aNJiti1Dzsw7i
   /CksSIaPx1nlEhBcBSnmdUITzWHzStTRyxayjSbOEOSqL5yEw5rYVOhTF
   O7ATGubHSoy/bkvkKCvpUW9Il8afVpR3DBHn8Lf4VTOuQ4FX9R9Or4bgi
   w==;
X-CSE-ConnectionGUID: NKa6Ds+ySYWs/2KMynL+lw==
X-CSE-MsgGUID: qBnCi3+2TN+kxtptIrFLJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74116782"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74116782"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 03:32:38 -0700
X-CSE-ConnectionGUID: Cz8FWRJjScq9m+zNdj0tTA==
X-CSE-MsgGUID: MptueMyxRAK3A+2TkKbJWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="245697437"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 03:32:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 03:32:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 03:32:37 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 03:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fg+bkof5krS4DtgDfs/Z8ZOj3U8/IsZmkT2YjE1aeGFQJKSpNLocmZmS9eC/JtAkxky8LN+Pb7CFnP4JPqKdAYW+eJB+AAGdkrHBC72HYoEbHZ1Ozm2e1OT1NJAoRriePxig9k2c87tLI+dphEwjvrlnC9Sxtqr5IX7aplABTTpplBQ1v2MgP7BR0QbSgmNNMxBDsj9F9iol/EV23kEznQLMiJoQZECLLLNNrg6yznuAIgglCUb15Xf4VknNUaW6AJnaYWpudJbxyS6nkA7NdOtPAw7d7VFFDGhU6khL+T4AxI3XXfT7gl4wWlZrBsf64B3syIWQ2GuCZ2tehcug5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgJjVoVKQUk05QFFBcRXWBP4IRtbDF5AbNvZYR5fMGY=;
 b=TLdfiaH+iVTp+f8IAAG15gZ/7RlAd17tCJeb8VgAbgLum5MDFueBGU2obgwkw7EJYeMj1Mf326hZn+r9C5E/238FKtjy3T+cWtE5Qln8Z3WU6w/iINnnuPRVlAAzGUQpGhGflkrpyLxpqX6HD21lNqEZuW5lS/8ClXorxxhWOkjVOBCC4axzTPAsCgTyqC/+eKNNX2U/7PVvh1lYszgYHaqhNgOoQs2S5Wk0Nfzw9XD11FaDuNN5wOp+fVxrt5fcASEn6+bd4EDEDHtz4VmSuMMQN01ypErRLg85WrsjBQeuPFt4+s85Qs2fdPJAQZ42sdlKlYPEAMHvrkHsOUazpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by SA1PR11MB7037.namprd11.prod.outlook.com (2603:10b6:806:2ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 10:32:34 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 10:32:34 +0000
Message-ID: <fec0ebc8-09ab-4bbe-916d-6ba524bd60ab@intel.com>
Date: Mon, 9 Mar 2026 12:32:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 1/5] igc: Call netif_queue_set_napi()
 with rntl locked
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
 <20260224111044.3487873-2-mika.westerberg@linux.intel.com>
Content-Language: en-US
From: "Dahan, AvigailX" <avigailx.dahan@intel.com>
In-Reply-To: <20260224111044.3487873-2-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|SA1PR11MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f93bfe-2a57-4b74-ed6b-08de7dc72d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: GRx+Ov7YOGPRC5PIa0rXZMYiAJI9+gg324pb4kJBb12/EakC2rMBjhCORHwWvkxgvLTs17eRXfeZG/ln4OprOsKG8w9KjWob8QhDn3XUtIU21OfYnj5HporJY9uxSoSAvf13AGweyWcZpGCNiU5Hjf0OG9sFLWPkiGbY6D9zer46dmYaAqlOhEw6jmX1j7JZz8LIoa0G2W7WjTIezSsved4Pn4EKc5xhBdtxG3x96tlGS1POjB4XqlrOl08TbZn+DmgS4nAoWSH3GujkG0jGlW/BeFqwenff26q00YlkE7r073bXXY6LMs4lZvbYczvvtJKBovJm3oKBDp4PQ3hCTkIuWC6fJLFYD5OHWUD/nQPTTY3IFqY6rMnHpHj/95LspXbvk/+Q9I0KJMF+togFvKVqgDnJFRJVM3Hs5a/YL37xprsJ/Iioz4oRz4HAFSoe5eD9LyJWHlVGMe/qHIdTQM3p+qI2TIw02/JvK98BUMO5aGQoQUEN61uEO00PdEjX6m6qRosBTJpDjjwy+onMycua6po5L9G1/p/D3Ks7FisEOC8IjdFzt4NyG0tPHpH1oIXc5IE6RzjT8F8ut1Hdp2px7XM916fUv21bMx2oIvdOHoXq0IuLNl6fQRqhuUrE8uJaqrEPe9DVc8d4tgTWFNPPxoBsuVmBLAtGSz1rUiai6w9d4PM4OLaddceta5ctI/CKh0i/1JlNzz00SUc3ikn3p3svHoXuSUseYTEFMQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnNEVnVvMzNrb3JPL0c5bkw4UGgraVJ2RjBFaXVZYlFneFo0aXJDZDN2SHZ4?=
 =?utf-8?B?WHBlVGtMNjhrUlQ2SVozQTNDM2VkU3NBclUyV0owcXM2bjh3SW9IUXRDbGN3?=
 =?utf-8?B?VFppWDdNVkRPbUZuU29mK29vNklycDEwNTY4UEEvb1M5NjNkT0NwbHRJdEhw?=
 =?utf-8?B?bTVIQ1lWcmJSY094ZzFlWUVmMzFSMEdYaGtrRm5FVUhmQXpaK1R3UGpKeXdX?=
 =?utf-8?B?ZDRYd2YrQVN6L3dpSGVSQ1Q1cE9CWWk3aE5hanpYSmtiSzFKSDBicUtLTkdk?=
 =?utf-8?B?VHFEdjdibVlJRnJrb1VqU1JUd2JNdFBTUDdSQ0tTYXhjcncxQW5TMjRIeGQz?=
 =?utf-8?B?cHQyMzlBUXNoVW9PTDZvQWVheFJlMTR4aXZmbjVxcVBHL1dBRmEvbzlMcTFT?=
 =?utf-8?B?YnpJaEtINFRMQk5OejZOUjJXUzNBbmtyVmZNbEdOR3g4WlpOYUY5VXJFcnRW?=
 =?utf-8?B?SWIxNEtOVDFoSjdqYWcxVHdKQXVHRVlkRm5kK0YyVDRQN2Q1cE5abmwrUmNv?=
 =?utf-8?B?b2lqVFhMV0t0VkdpMEhUb2ErYTU3U2NjR0RKcGsvZ0E5T2htT2lUSXVYVFUv?=
 =?utf-8?B?TkhoNWhLMGx1T3EraEJycW5UOVFNbXZsM3pvM3pOeWFXNTdqTndpN0pJMHZF?=
 =?utf-8?B?L005UmwrbzFIMTFOR1l5YUhjZjczWXlVQlB6VER3RmVOcmVqVVZZeG1neEU5?=
 =?utf-8?B?NTljaHkrSXB4Tng4bHpJZC9sdGRPMDgzTkVZeFdFTE90am5aY3lQWG8xRzY0?=
 =?utf-8?B?VVFlQk5sNnJmVnBQS3A2eHFaVk91NE9aL0x1V3N2dUkyZG4xZlVoNnAzYjFE?=
 =?utf-8?B?LzcySjcrSnZiU0hhUSt3K1M5dytnejJGU2JPelEwNWlZTElLSC8zVGtiK3lh?=
 =?utf-8?B?VEoydEtsY2dsYkdLVzZTb0MxOWZLSmFkQ2ZnK01MdXFBS1NWZmhYalZvejZZ?=
 =?utf-8?B?RDR0OE5yYmFpN3EyTVBNOExYWGw2QlhmR1FEOTEvenBFYnhtdE4vd0ZDMVo5?=
 =?utf-8?B?VG9SMXJwOGxaTkNQeCtIRUUwVTViY2ZPeTdLU0dEYmpmbzNrMGErbkFtRTI3?=
 =?utf-8?B?UUtLOUUxbUpwRWJnY0xqZzhUSXhySE9Qb3dUc1Z0YlVEK2hUQjNTRHQvYldm?=
 =?utf-8?B?NkIyN3VNMEQxZHFaTWpEOE0yUVZuN3ExUjZzNmxUUHZLL2JqK0xIZTBKb0hn?=
 =?utf-8?B?TDdHQ0pZWlF3TGQ3MWxuU1V3L21zVUlJOXNLOTdDTk8wMC9Jc29WWThxTXRI?=
 =?utf-8?B?cXprb0c1MC81ZkNxclRpTnFTemtKaDVnSFBJN2U5emJ1TVo4UzM0blNEOG92?=
 =?utf-8?B?ZEFxTzMrNlpFK1Y2NmsrZndtY3hGRG9uT01GeWU5QlcyS1o5Y1lpY3pJODdw?=
 =?utf-8?B?OEhpK3MreVp2MDA3TWtnWWxnZDEzOGxZeEVMdkhQaEJXK2NLbzhzaVVmVFYw?=
 =?utf-8?B?YUFtNkdnaGpZTFZtT2NXL2QzUlUwdkVHc0JaNGt1MlhqQytzMlJYNUdhZy9X?=
 =?utf-8?B?YzBOVzV4NE5CcjdKTDI3UE52Mk9UdWM0eW9jUWdscTAyQkRsQ1Z0MzBYZWxO?=
 =?utf-8?B?WUlvZnlLUFNUSERpYkxETVpFOTJPODB6enBGK0V6MlpBNTVva3Vrb2JNRFp6?=
 =?utf-8?B?ZWwyTXVqd0tGVjA4NFBaeXhwM29yTGxnWmthcUJnYTRtSXdnUlBSU2ZVejNr?=
 =?utf-8?B?cGRkbXNmNkFUVlJVakIvUGdsMVZ3VE50Sm5Jc280Vk1XWTlwcGM0MmVJNVlP?=
 =?utf-8?B?ZmxvL1JTaWRZNmFJUUtrOGdjQkZoTW5BQ2xHSlFtbHc2cXkvVXZnTmFrS0NI?=
 =?utf-8?B?WHFuRWg4SWVsWDY3cE96YmtKQ0lPcjdkM0ZQVFJqVGhvOXpTM1pCUUthaVpL?=
 =?utf-8?B?dDZOUjRaRDJhTUovcURmSzFzZzk4RnAzVUdNaVpqdW41L1RlUUkrUExDT24y?=
 =?utf-8?B?cDFzbTdaaWpUMmJsbUlrTmxnV0VjTmhEM2tKNEdBU3ZDMTJPejFWOTFRQW1Z?=
 =?utf-8?B?K1htRGdGL29XbFpVT0tNMmgwK2lRRE9Kb3hrb0RwOFlHOVN3aytFc0o3Qjcx?=
 =?utf-8?B?dGpiR0gyVFpsMkhnM09ldGU1U1NDZ0luVnlDd2JoUXI2aGRjZklqbjl2YkVW?=
 =?utf-8?B?eERYMUZ2UWE4SkpMTEJjajRjVTJTc1RmNUNJR1lBa0hLdWFkVGxLenFvVFE1?=
 =?utf-8?B?Y2Y5U1loT3lvWnBrd0lKcmxOMVViSVJaSXpqKzhkM0pwYVFIUGU3S3lEMkEz?=
 =?utf-8?B?OVZoemxkRlZiQndlUnRSYjhCV2JTRGRCVTYwejc4WUtscnFJSC9IYTlKWVhU?=
 =?utf-8?B?RWFuUVk0RU91U1lkajJlU0RqZkpmVDBiL0VsVjdOL2xXc2YvYWNCdz09?=
X-Exchange-RoutingPolicyChecked: tWYZer5iwAXj6Sk14yvRWLp0t10HUOUI1xL99GsoWRsitCh7AuvZJGtLN3X977NNP1mvKunHp2UDCmG6nmDGU0P8f3ETvEdhHNmg+0X7puSpJXm9FLGUIb+WS8CfvcUQTVPLLNmO2RWoO5etmDHXJ4tjImwD0iSHLG6h6y8zbklwH6KUBNjl9iwTS3Dgy3Hxhu2rGyDdiyjZOBdtXA8rRdEEglkK6HVFO+28puvI1La02ss7jQQttI7rrn8KjTnes9+3xhPrb2CtfbxXO5GRdZHfnnLxnOIAiHLb2dbz8NTc36+D0b72iNqMcICSCToLFn4YXjmozExwe5TlwkT7uQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f93bfe-2a57-4b74-ed6b-08de7dc72d18
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 10:32:34.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92ZULQGCLzisXxizz28e775D9V5Zg9k8T7AKwW26e1isxx0TGNPxFgJOjq4CZUXflaN84iPKx+8Iv2q7ocUaanMAvYC4KbC0H/AbvBwYbfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7037
X-OriginatorOrg: intel.com



On 24/02/2026 13:10, Mika Westerberg wrote:
> When runtime resuming igc we get:
> 
>    [  516.161666] RTNL: assertion failed at ./include/net/netdev_lock.h (72)
> 
> Happens because commit 310ae9eb2617 ("net: designate queue -> napi
> linking as "ops protected"") added check for this. For this reason drop
> the special case for runtime PM from __igc_resume(). This makes it take
> rtnl lock unconditionally.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 

Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
