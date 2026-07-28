Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D1422E36
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262891; cv=fail; b=MmugqHCQw1AkZDH4rfxMdB79y6T6QUOQdJ07bdmfrPyLOBhmMIRL6ixIRxZQ24TTWU+1gl+7dMTDk61xrodDWcT/7r+epUG0M8EdzxCgM0noYuj75VD9Wmp21SmCoatvyAsfy1Xc6btaDzw2idw5cWbn21U974Wp3PaucwDq3Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262891; c=relaxed/simple;
	bh=O2osj+T+lI7GZ/CMtT9pPDN+IlDKDAxEU8DLv2QrEtA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GMilxclWBk7+i9FW16plTQdJnUz387frOC01PSwTc9tlsPHvFr6OgV6FVM6ZLWT+Wzk4qmFP6EP+VThQsyF6SkWK+U4eHJlpUYoivQnkb65LeSVkq8lEBfzhQPqguKl79XvXJ4G6ajZRrcGI5dXVZQkvhy45p1b+6oiwpGZrhQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5I49rzJ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5I49rzJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785262889; x=1816798889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O2osj+T+lI7GZ/CMtT9pPDN+IlDKDAxEU8DLv2QrEtA=;
  b=O5I49rzJf0slSfDHxCm+wVOPY7P3meAu9XPgN7naMGNKfZHxmODdL7Rk
   8BzZkOWfAwt0kYs7QiGQd19r/MQaS46fNh0M10t3+wlxsNLLVENILlqAf
   6crYawelyPX41hrkCNV6lOFAeT9YX+vooU/Oa/qlpXsZnJpbh+rZSv3s7
   CJzLu2qxcTtaq9HSSW1q+I6XEDwiaq6UMi7VLEKtNTMatkX/H0EbH7kS8
   XxlWzKjGiLyGAvx8r3Uw10jMjO+Qx8vlM7rjpZdnPzNhKPKqrSLJwkFFr
   keIjP+XZpnV3fcea2XLX3fX4VxsbrF9A3fPenn1K9khHLmbawhT7AUjgo
   g==;
X-CSE-ConnectionGUID: W+qwhmPTRgebq9/qp6bHQA==
X-CSE-MsgGUID: cYbjex4VTXKakL//9I6v2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97017074"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="97017074"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 11:21:28 -0700
X-CSE-ConnectionGUID: SMDf2KqbQRilqJP9NFAHOQ==
X-CSE-MsgGUID: lyzKjeqtSQS4Ewsb1qaOJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="263587330"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 11:21:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 11:21:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 11:21:27 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 11:21:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvQe6RN3smMXojNoKjNmLCDo8saQioNoskGdVP1W2VzWFuK10Zv/cNOKZ/Q+tRQ/KuYUx2IlvxbwleFSa8yFOAIvidIsqqGk+DNG+LTSdyHXRb4XwoBZevzaFSHTgZ/8AzCo1cOMNV8BxmLN2Y+r1T2acLXtMja7Jfn6A5Olwe0fFmWJ19xunuctLRH5bVzoHNUfl/FpDJ0AT0tBCone1SvE+M8FMxRA0W00Axc/m12rpqOuTG7wJiFaZ9IXw128ly7GpGF0zglqVmto6PbNR+FocAy7t+7Y4DN6P+OD2tXMAQO2OUpLX/Jnamg4ai3oKMWpNlnnHfupYUjOUIQ3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2osj+T+lI7GZ/CMtT9pPDN+IlDKDAxEU8DLv2QrEtA=;
 b=vB+p76FQT/f/uOzYd/tsgeSLcIeZIiei3yOuq7D0PyjeDuGRdUJGwRkGGAGbGmqi24bUQrpHfk0x+I9pVvtfdiP6klswgC5NEtIeMRkqaEurTVCGPYW84dOElsbJHInsOkulPYzwibf+vWXBKhUnmus7e4C8NkfNTipFXXTfIJkbriN+qXYTgMCItGpVOVGFZvI7BwWXaPSw7mTvhN3QL8ZaPqkO511PyUES5cwBtcdM2YdOVNhHsCgFjB51dlH8jaaL3bfI4txkkRUXBgs1VPff1P+3PRCaRzw83u4+jpL7AXakKrpuh6DSk7XmYK6YXiy6uAlXoD3YTHVBA7qY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 by DM6PR11MB4753.namprd11.prod.outlook.com (2603:10b6:5:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 18:21:23 +0000
Received: from PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083]) by PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 18:21:23 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "helgaas@kernel.org" <helgaas@kernel.org>
CC: "thierry.reding@kernel.org" <thierry.reding@kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>, "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"treding@nvidia.com" <treding@nvidia.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Topic: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Index: AQHdAUruh/HWEZwEC0iMA6tK8iUSn7ZImB0AgAAE6oCAMTTxAIAABOIAgAAe6wCAARjQAIAAHZOAgAhH+4CAAAUPAA==
Date: Tue, 28 Jul 2026 18:21:23 +0000
Message-ID: <a1934c51592fc56c65232b1379680c52c6d0cea3.camel@intel.com>
References: <20260728180315.GA1380884@bhelgaas>
In-Reply-To: <20260728180315.GA1380884@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7494:EE_|DM6PR11MB4753:EE_
x-ms-office365-filtering-correlation-id: 987aec99-2fd7-4d53-8dda-08deecd50797
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003|3023799007|38070700021;
x-microsoft-antispam-message-info: sGyCrnNNbpeexRVAJpBfelaZN1XR1iOIU2Oo2R105lznJ0jM/N18OZELYuGeyk81bkOWAGtQLYseDJLdPKb/qtrfT/FnyoOYVcCc61mX6Ydwuo8W418cXzZ2g+P/122UrI+gslHJfzHUBWHqNE9dYzuAbCEDkL5rF1SPTm8ep5W7zasRfQgwd1ZOSaWNv8YNSM75b5yopefZimwSEA62esIgjyvyFXb0PF54o3n9BDngAvasNCBnIQce3qtjAS12kOf502c8ziRNiinnfMAM7nxvJUvKZwgKNQ2j1cqeiNWH8gtNLVpSqqjnphx8fK38jEC9FrkWOGys6NezDlqJcVQ4Aggw8d4ue3Hq5nTSnOEvvdhTcq62yg4BeZOkPUyCwDaxMd9zr9w7cK/T6MW1RqiMla50OcFrcA4w7LLUvOrVwKw2wvU4KPgXOB8oz3iI0q/HlZjhTSYutLrVbGCiLYjH/Lbu+4HUXY9urKoqaEKhSlqiM85XRAylJc7NcRsS8bdi6txflEeXASbf5VOH9GU8fAAX8Q2n6CfSk5f+bm+P8qqcf9bICjKZ8JmlMvp8R+LwCVk+TiBXTxgi28QAwn0OcoEvdyb1Ua3FTWNuzwAFlc7wJJZmH/p0+hUvPPkgVmkRtyaEgQCqg0R/CwNQ2RmOLtQ/+HuxYeoMOcF5+/Svhd33nmrONEFaO/PBayPZLhPCq9epiQL6n6dFee+CJg/6kWFh0/MuuSWAOat2qTs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7494.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1ZJNGtTWDMzTU9Yd1hWZ1lLVE4vQjFyblI5TXV2akZRTzRRdW9WMmhqZlpW?=
 =?utf-8?B?clliZHJBOGpQTm0vQ25wWWMwLzBLUGxUaTQ2NVlZOVlybC9ROWRHbk04T25T?=
 =?utf-8?B?RGlmS3ppdDlTMlY2c1V0OWFmYjZyV0w5aWdGd256RGxiR2dGMldxLzNJWDdt?=
 =?utf-8?B?QzdaRDFaT2wwRUJlUnVvdkd4WTlna0l1T3g2MlN4R21nRnhkUUM4dFdta0c2?=
 =?utf-8?B?SG5Db0RnNW40WEMvck1JUVRUTnNtMm5lbW56NDRDNXBDcXFPYVZWUnBnaHI5?=
 =?utf-8?B?VVZEdS9VMkdjY3A5RUk1YVBkUVA4WFI2QytDWTF2T2dvenJpUGZkb3VoalFp?=
 =?utf-8?B?M3JPaHF4blVHdFlxMFIxNUl1MHNnZU51Vnh3K01qQnptYWQ0b09ieldyZFlj?=
 =?utf-8?B?TldoYXVydWI5TXQ0OTRDVHYyNHpqenhxZmNvRzZpcXNlNWVGajN5OU1NODJo?=
 =?utf-8?B?RG05S2h5Y2wyM0JQbm45ZmM1RHRhTG9OODFabFhacGxzWTRnTnBsejZoMmJ1?=
 =?utf-8?B?WnUrN094VUlDNzZXRzQwMFJRcFFzcmZ5SGtoeVIrRkx3YWlVbGIwVHdkRHU3?=
 =?utf-8?B?eXpzd01BV1hiNDE4ZXU2bXhKVi9XR1BDdzRyRHhqUUhQVk94UmFNbHZrTlRE?=
 =?utf-8?B?VlRPMkhTUUpMNEZsbXZUTHhVVTZRbHZBMTlFbnc3L3N1aXhpVlo3RE8ycW1I?=
 =?utf-8?B?WUlYTXV0WUpyNzk2TVhYY1R3eHZYRWhwRVdMVVRoWDZaYm9JTHRiOVZZNWc3?=
 =?utf-8?B?R1pXRHdldExQeWhjcTY5dHZ6eUU0L1lzQ2lreVczT2oxTGY4SFZEZ21nT2FJ?=
 =?utf-8?B?cGtTRmhqNjB2Rm5SWFRma0xBRTVKWVVxbFJQZGJKSFkyL0FRS3hZekQ0a3Av?=
 =?utf-8?B?b1hvM3VEdXg1TmlsSlA5R0VJYlpJMGJaTHQzZTVMWWFVdytCZm1CZWZEM3ps?=
 =?utf-8?B?aVUxOXRvQkNjSXcyYnN1VjZML2QxdjdsYXFFY1Z2cVJsVnlDNkxxeVRJK3kz?=
 =?utf-8?B?bVFBc0JMV0JsZG5Iei9Fcy9oSFYzSkliYTJkUGlrMTJGV0x5eTZHMi9nZklm?=
 =?utf-8?B?T3d6cW9TM1JWcm1jVnRnamJxajc4ajY1Z0NkSFdPU3UwVFdCbkpLalg1eHE0?=
 =?utf-8?B?Rmh1bS9JZzRLUzd4aVpKV3pDbW0xMWlJbXdVM0FUVVNiS3pQNzJpcFlqYlpG?=
 =?utf-8?B?bHJ5dHNwWklFSThJaUR4ZC9IQ2ZrdVZoSFJiZjdjKzN5OWRDVXFySVh1djIw?=
 =?utf-8?B?aHVocWJNOElrOGJVaEJMQ1ozaHRuSXgvSHJHK2N4ZFhXQ291YUxsMVN0a0pi?=
 =?utf-8?B?UUw1RGNDQktCS1FJOFVzNytXdkV4ckhHc2dRMXNKWGJ6blJPcWZDSVQ4TnRy?=
 =?utf-8?B?ZWI0SWZEelN5VVNaejBDMGo1SnMzdEplazB3S2Y5YWN0a3hpcUZSd2VQbkNh?=
 =?utf-8?B?L0dyV0dRNGI5YjBVelBvMnFmbTM0MUNEQWkxR3NIMHArTGJTd253RlFPNE1U?=
 =?utf-8?B?ODRMR285Ym4zbzFucE5KYXNCRVQ5ektJZVNGMGQrTncxbzRjVVdBSFdWYmds?=
 =?utf-8?B?NnVZd1lMd09RQ2wvRmlpMlBZQmJwTlFNYUlQUWVVN1JEdjMwb3MwSmRIN3FU?=
 =?utf-8?B?c3hyZzZsbkVkMWVRSmhRZzVGMjZqM3o4N2h4RTBFY0RvNER5NGtaRitnSHky?=
 =?utf-8?B?dkQ0Nlo1eFZabExZdTBFNHYzR0htU0E4TEQ3dFY3dnQ1Mm51eXRzSExoTk5V?=
 =?utf-8?B?ZllqcnR4K1RkdXFQNGFFMFhZVldzN1c5SXBGdUNnR1ZWVWRXazFsVHR5SnVs?=
 =?utf-8?B?Q1JCOGY5MnlqTCtDS1NIREUzUTRnZnA1Si9VRGtVWTd1SXY2RC9kM1lKVElr?=
 =?utf-8?B?RVl2V3R3RVc4VkU0YzdCbEJQeFFleTREY1gvS2Jibm5jcmEwbDJHN1cxMHN3?=
 =?utf-8?B?b3hSdTY2NVdKQzQ3K2dGWHdseHZhaktnQ1VZZmt3RnMvM0pnc1ZFUWJVU0dz?=
 =?utf-8?B?czd5V01HZUl2Rjh4TXRaM1hQZkhZSG5IdXZLSGFPV1NXMmxhZ0hRbVFXVXAz?=
 =?utf-8?B?QTJGbGlrK3FBQnVBSTJYSmlScmNOY1p4SFNMWU1ZVHJlSTNyRmhVSHUwSFZW?=
 =?utf-8?B?Rys5U3FEb05GNFd5Q1RSODJTTlJ5SWIyZFMrS28rZUhNK1JmNXZlTXJwQ2Za?=
 =?utf-8?B?OCtkaUxvVTUxSGZGcUsrVUJET1ZHbURVdFlpZFlqdVVNdHJRT2Njbit2QUJa?=
 =?utf-8?B?dDNGaE1ickFZY1JJRCtjM2pvblV0VjFmWlZydHdKVWgrbFF6dkxySk1HVEFp?=
 =?utf-8?B?UG9GZTZwUnlTZTN0Z01xZE5mRWFjaWtJVEFINWlidGNNN0NZVUM1dDJlcmYz?=
 =?utf-8?Q?vGxIySA44BNQK3NM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67BB30C4DAD0EA41BB844E452A609AEA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CH4mafWFXcEOWO6mRY4dR8Jksmni5G4+B4HIaX0KaZJPVzoAyEnGbOuyS4Scb/avsBzoce4Bzec1Ue0yfMau9P84dUVGkiLawJtF4zXm1gA8+O4WvXqKOdvNCZDTOO2+MGzZj3C3pSdt4Qw8QdiFA3/a6xLwF6uA2AdCGAAFRRidzRFH6DHtRz3IkUT6z9kZDBBom3H3lqu84lURqBCyRHW022ZFxa+Gd72a938jbmaz99GInH/0EQgbDze2nnxlBpx3H/2MayKH16ozaEOfj+7Niacl2WNUDeZ61gSAXwVyrbaueDVN9mIUVf1pfa2bQyD4yas9PKY6Mbcx/5ZDdw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7494.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987aec99-2fd7-4d53-8dda-08deecd50797
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 18:21:23.2261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4YMd7OKEoTZSdWgyI+QXeD6wKZDgqeuahdTsVZQ32xRwxJVWwW1h3Xx0xCfHhLQrkYIj26xO0oSUSSyVrGYSsPMW/14KDL0f2Dr1X5Axd78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4753
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTI4IGF0IDEzOjAzIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBUaHUsIEp1bCAyMywgMjAyNiBhdCAxMTozNTo0MUFNICswMDAwLCBHcnVtYmFjaCwgRW1t
YW51ZWwgd3JvdGU6DQo+ID4gT24gVGh1LCAyMDI2LTA3LTIzIGF0IDE1OjE5ICswNTMwLCBNYW5p
a2FudGEgTWFkZGlyZWRkeSB3cm90ZToNCj4gPiA+IE9uIDIyLzA3LzI2IDEwOjM0IHBtLCBCam9y
biBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gPiA+IFRoZSBwcm9ibGVtIHdhcyB0aGF0IHdlIGRpZG4n
dCBzaG93IHVwIGF0IGFsbCBpbiB0aGUNCj4gPiA+ID4gPiBlbnVtZXJhdGlvbi4NCj4gPiA+ID4g
PiBXZQ0KPiA+ID4gPiA+IHNlbmQgYSBtYWxmb3JtZWQgVExQLiBJJ20gbm90IHF1aXRlIGFuIGV4
cGVydCBhdCB0aGlzLCBidXQNCj4gPiA+ID4gPiBvdXINCj4gPiA+ID4gPiBQQ0llDQo+ID4gPiA+
ID4gZXhwZXJ0cyBydW4gYSBQQ0kgYW5hbHl6ZXIgb24gdGhlIGVudW1lcmF0aW9uIG9uIHRoYXQN
Cj4gPiA+ID4gPiBzcGVjaWZpYw0KPiA+ID4gPiA+IHBsYXRmb3JtIGFuZCB0aGV5IHNhdyB0aGF0
IHBsYXRmb3JtJ3MgUENJIGNvbnRyb2xsZXIgc2V0cyB0aGUNCj4gPiA+ID4gPiBOb1Nub29wIGFu
ZCBSZWxheGVkIG9yZGVyaW5nIGJpdCBpbiB0aGUgVExQLiBBY2NvcmRpbmcgdG8gdGhlDQo+ID4g
PiA+ID4gc3BlYw0KPiA+ID4gPiA+ICh3aGljaCBJIGlnbm9yZSksIHRoZSBCRTIwMCBpcyBzdXBw
b3NlZCB0byByZXR1cm4gdGhlIFRMUCBhcw0KPiA+ID4gPiA+IHJlY2VpdmVkLCBidXQgd2UgcmVw
bHkgd2l0aCAwIEF0dHJpYnV0ZXMgYW5kIHRoZSBlbnVtZXJhdGlvbg0KPiA+ID4gPiA+IGRvZXNu
J3QNCj4gPiA+ID4gPiBjb21wbGV0ZSBzdWNjZXNzZnVsbHkuDQo+ID4gPiA+IEknbSBjdXJpb3Vz
IGFib3V0IHRoZSBkZXRhaWxzIG9mIHRoaXMgZW51bWVyYXRpb24gZmFpbHVyZS7CoCBEbw0KPiA+
ID4gPiB5b3UNCj4gPiA+ID4ga25vdyB3aGljaCBUTFBzIGhhZCBObyBTbm9vcCBhbmQgUmVsYXhl
ZCBPcmRlcmluZyBzZXQ/wqAgUGVyIHRoZQ0KPiA+ID4gPiBQQ0llDQo+ID4gPiA+IHNwZWMsIHRo
ZXkgc2hvdWxkbid0IGJlIHNldCBmb3IgdGhlIGNvbmZpZyByZXF1ZXN0cyB1c2VkIGZvcg0KPiA+
ID4gPiBQQ0kNCj4gPiA+ID4gY29yZQ0KPiA+ID4gPiBlbnVtZXJhdGlvbi4NCj4gPiA+ID4gDQo+
ID4gPiA+IEF0IGxlYXN0KnNvbWUqIGNvbmZpZyByZWFkcyB0byB0aGUgQkUyMDAgbXVzdCB3b3Jr
OyBvdGhlcndpc2UsDQo+ID4gPiA+IHdlDQo+ID4gPiA+IHdvdWxkbid0IGtub3cgdGhlIFZlbmRv
ciBvciBEZXZpY2UgSUQsIHdoaWNoIHdlIG5lZWQgdG8gYXBwbHkNCj4gPiA+ID4gdGhlDQo+ID4g
PiA+IHF1aXJrLsKgIFNvIEkgdGhpbmsgeW91IHNob3VsZCBzZWUgc29tZXRoaW5nIGxpa2UgdGhp
cyBpbiBkbWVzZywNCj4gPiA+ID4gYW5kDQo+ID4gPiA+IEJFMjAwIHdvdWxkIHByb2JhYmx5IGFw
cGVhciBpbiBsc3BjaSBvdXRwdXQ6DQo+ID4gPiA+IA0KPiA+ID4gPiDCoMKgIHBjaSAwMDAwOjA0
OjAwLjA6IFs4MDg2OjI3MmJdIHR5cGUgMDAgY2xhc3MgLi4uDQo+ID4gPiA+IA0KPiA+ID4gPiBJ
cyB0aGUgZmFpbHVyZSB0aGF0IGl3bF9wY2lfcHJvYmUoKSBpdHNlbGYgZmFpbHMgc29tZWhvdz8N
Cj4gPiA+ID4gDQo+ID4gPiA+IFlvdSBtZW50aW9uZWQgdGhhdCB0aGlzIGhhcHBlbnMgb24gSmV0
c29uIFRob3IsIGJ1dCBJJ20gbm90DQo+ID4gPiA+IHN1cmUNCj4gPiA+ID4gd2hhdCBQQ0llIGNv
bnRyb2xsZXIgdGhhdCBpcy7CoCBNeSBndWVzcyBpcyBpdCBtaWdodCBiZSBUZWdyYTI2NA0KPiA+
ID4gPiBbMV0sIHdoaWNoIGRvZXNuJ3QgbG9vayBsaWtlIGl0J3MgbWVyZ2VkIHlldC4NCj4gPiA+
ID4gDQo+ID4gPiA+IFRoaWVycnksIE1hbmlrYW50YSwgZG8geW91IGhhdmUgYW55IGluc2lnaHQg
aW50byB0aGlzP8KgIERvZXMNCj4gPiA+ID4gdGhpcyBQQ0llIGNvbnRyb2xsZXIgc2V0IE5vIFNu
b29wIGFuZCBSZWxheGVkIE9yZGVyaW5nIGZvciBzb21lDQo+ID4gPiA+IHJlYXNvbj/CoCBJIGRv
bid0IHRoaW5rIGVuZHBvaW50IGRyaXZlcnMgYXJlIGV4cGVjdGluZyB0aGF0Lg0KPiA+ID4gPiAN
Cj4gPiA+ID4gWzFdaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpLzIwMjYwNzE2LXRl
Z3JhMjY0LXBjaWUtIA0KPiA+ID4gPiB2OC0wLTIzZTUxNTg5MjI5YkBudmlkaWEuY29tLw0KPiA+
ID4gDQo+ID4gPiBIaSwNCj4gPiA+IA0KPiA+ID4gSmV0c29uIFRob3IoVGVncmEyNjQpIGlzIG5v
dCBzZXR0aW5nIE5vU25vb3AgYW5kIFJseGRPcmQgYml0cyBpbg0KPiA+ID4gY29uZmlnIA0KPiA+
ID4gcmVhZCBUTFAuDQo+ID4gPiANCj4gPiA+IEkgbWFkZSBzdXJlIHRoYXQgYm90aCB0aGVzZSBi
aXRzIGFyZSBzZXQgaW4gUlAncyBEZXZDdGwNCj4gPiA+IA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgRGV2Q3RsOiBDb3JyRXJyKyBOb25GYXRhbEVycisgRmF0YWxFcnIr
DQo+ID4gPiBVbnN1cFJlcSsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBSbHhkT3JkKyBFeHRUYWcrIFBoYW50RnVuYy0gQXV4UHdyLQ0KPiA+
ID4gTm9Tbm9vcCsNCj4gPiA+IA0KPiA+ID4gYW5kIGR1bXBlZCBUTFAgaGVhZGVyIGZvciBhIGNv
bmZpZyByZWFkIHRvd2FyZHMgQkRGIDB4MTAwIHdpdGgNCj4gPiA+IG9mZnNldA0KPiA+ID4gMHgy
NC4NCj4gPiA+IMKgwqDCoCAweDA0MDAwMDAxwqDCoMKgwqDCoCAweDAwMDAwMDBmwqDCoMKgwqDC
oCAweDAxMDAwMDI0wqDCoMKgwqDCoCAweDAwMDAwMDAwDQo+ID4gPiANCj4gPiA+IEkgdGhpbmsg
ZG1lc2cgYW5kIEFFUiBsb2cgd2l0aCBoZWFkZXIgaW5mb3JtYXRpb24gbWlnaHQgaGVscCB3aXRo
DQo+ID4gPiB0aGlzIA0KPiA+ID4gcGFydGljdWxhciBpc3N1ZS4NCj4gPiANCj4gPiBPaywgc28g
SSBjaGVja2VkIGFnYWluIHRoZSBsb2dzIGFuZCBJIHdhcyB3cm9uZy4NCj4gPiBXZSBkbyBzZWUg
dGhlIGRldmljZSBpbiB0aGUgZW51bWVyYXRpb24sIGl0IGRvZXMgc2hvdyB1cCBpbiBsc3BjaS4N
Cj4gPiBQcm9ibGVtcyBzdGFydCB3aGVuIHdlIHdhbnQgdG8gYWNjZXNzIG91ciByZWdpc3RlcnMu
DQo+ID4gSSBhdHRhY2hlZCB0aGUgZnVsbCBkbWVzZyBvdXRwdXQuIEluIHRoYXQgbG9nIHdlIHRy
eSB0byBsb2FkDQo+ID4gaXdsd2lmaQ0KPiA+IHR3aWNlLg0KPiA+IA0KPiA+IEknbSBhZGRpbmcg
aGVyZSB0aGUgc25pcHBldCBvZiB0aGUgZmlyc3QgbG9hZDoNCj4gPiANCj4gPiBbwqDCoCAxNS4y
NzU4ODddIGl3bHdpZmkgMDAwMTowMTowMC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgNTMNCj4g
PiBbwqDCoCAxNS4yNzk3MzddIGl3bHdpZmkgMDAwMTowMTowMC4wOiBlbmFibGluZyBkZXZpY2Ug
KDAxMDAgLT4gMDEwMikNCj4gPiBbwqDCoCAxNS4yODAwNDddIGl3bHdpZmkgMDAwMTowMTowMC4w
OiBIV19SRVY9MHhGRkZGRkZGRiwgUENJDQo+ID4gaXNzdWVzP8KgIFxcICoqDQo+IA0KPiBUaGUg
ImVuYWJsaW5nIGRldmljZSIgbWVzc2FnZSBpcyBmcm9tIHBjaV9lbmFibGVfcmVzb3VyY2VzKCks
IGNhbGxlZA0KPiBpbiB0aGUgcGNpX2VuYWJsZV9kZXZpY2UoKSBwYXRoLsKgIFRoZSAwMTAwIGlz
IGZyb20gYSBjb25maWcgcmVhZCBvZg0KPiBQQ0lfQ09NTUFORCwgYW5kIHRoZSAwMTAyIGlzIGZy
b20gYWRkaW5nIFBDSV9DT01NQU5EX01FTU9SWSB0byBlbmFibGUNCj4gbWVtb3J5IEJBUnMuDQo+
IA0KPiBUaGUgIkhXX1JFVj0iIGlzIGZyb20gaXdsX3BjaV9wcm9iZSgpLCB3aGljaCBsb29rcyBs
aWtlIHRoZSB2ZXJ5DQo+IGZpcnN0DQo+IE1NSU8gcmVhZCB0byBhIEJFMjAwIEJBUi4NCg0KSW5k
ZWVkDQoNCj4gDQo+IFNvIEkgZ3Vlc3MgdGhlIHRoZW9yeSBpcyB0aGF0IFRlZ3JhMjY0IHNldCBO
b1Nub29wIGFuZC9vciBSbHhkT3JkIGluDQo+IHRoZSBNTUlPIHJlYWQsIEJFMjAwIGRpZG4ndCBj
b3B5IHRoZSBhdHRyaWJ1dGVzIGZyb20gdGhlIFJlcXVlc3QgdG8NCj4gdGhlIENvbXBsZXRpb24g
YXMgcmVxdWlyZWQgYnkgUENJZSByNy4wLCBzZWMgMi4yLjkuMSwgYW5kIFRlZ3JhMjY0DQo+IGxv
Z2dlZCBhIE1hbGZvcm1lZCBUTFA/DQoNClRoYXQncyB0aGUgYXNzdW1wdGlvbiBiYXNlZCBvbiB0
aGUgQUVSIGxvZywgeWVzLg0KDQo+IA0KPiBBRkFJQ1Mgd2Ugc3RpbGwgZG9uJ3Qga25vdyB3aHkg
VGVncmEyNjQgd291bGQgc2V0IE5vU25vb3AgYW5kL29yDQo+IFJseGRPcmQgaW4gdGhlIE1NSU8g
cmVhZC4NCg0KTWUgbmVpdGhlciBidXQuLi4gSSBjYW4ndCBjb21tZW50IG9uIHRoYXQuIEFuZCBk
ZS1mYWN0bywgb25jZSBpdCBkb2VzDQp0aGF0LCB0aGUgQkUyMDAgcmVwbGllcyB3aXRoIHRoZSBO
b1Nub29wIGFuZCBSbHhPcmQgY2xlYXIgaW4gdGhlIFRMUA0Kd2hpY2ggaXMgdGhlbiBjb25zaWRl
cmVkIGFzIGEgbWFsZm9ybWVkIFRMUC4NCg0KPiANCj4gVW5sZXNzIGl3bHdpZmkgYXNrZWQgZm9y
IE5vU25vb3AgYW5kL29yIFJseGRPcmQgdG8gYmUgc2V0LCBJIHRoaW5rDQo+IGl0J3MgYSBwb3Rl
bnRpYWwgcHJvYmxlbSBmb3IgZHJpdmVycyBpZiBUZWdyYTI2NCBzZXRzIHRoZW0uDQoNCkkgLi4u
IGRvbid0IHRoaW5rIHdlIHdvdWxkIGRvIHRoYXQuIFRoZSBkcml2ZXIgd291bGQgY2VydGFpbmx5
IG5vdCBkbw0KdGhhdC4uLiBSZWdhcmRpbmcgdGhlIGhhcmR3YXJlIGl0c2VsZiwgSSBjYW4ndCBj
b21tZW50LCBidXQgSSBjYW4gY2hlY2sNCmludGVybmFsbHkuDQoNCj4gDQo+ID4gW8KgwqAgMTUu
MjgwMDcwXSBpd2x3aWZpOiBwcm9iZSBvZiAwMDAxOjAxOjAwLjAgZmFpbGVkIHdpdGggZXJyb3Ig
LTXCoA0KPiA+IFxcICoqDQo+ID4gW8KgwqAgMTUuMjgwMDg3XSBwY2llcG9ydCAwMDAxOjAwOjAw
LjA6IEFFUjogQ29ycmVjdGFibGUgZXJyb3INCj4gPiBtZXNzYWdlIHJlY2VpdmVkIGZyb20gMDAw
MTowMDowMC4wDQo+ID4gW8KgwqAgMTUuMjgwMTA0XSBwY2llcG9ydCAwMDAxOjAwOjAwLjA6IERQ
QzogY29udGFpbm1lbnQgZXZlbnQsDQo+ID4gc3RhdHVzOjB4M2YwMSBzb3VyY2U6MHgwMDAwDQo+
ID4gW8KgwqAgMTUuMjgwMTEwXSBwY2llcG9ydCAwMDAxOjAwOjAwLjA6IERQQzogdW5tYXNrZWQg
dW5jb3JyZWN0YWJsZQ0KPiA+IGVycm9yIGRldGVjdGVkDQo+ID4gW8KgwqAgMTUuMjgwMTI3XSBw
Y2llcG9ydCAwMDAxOjAwOjAwLjA6IEFFUjogZm91bmQgbm8gZXJyb3IgZGV0YWlscw0KPiA+IGZv
ciAwMDAxOjAwOjAwLjANCj4gPiBbwqDCoCAxNS4yODAxNTRdIHBjaWVwb3J0IDAwMDE6MDA6MDAu
MDogUENJZSBCdXMgRXJyb3I6DQo+ID4gc2V2ZXJpdHk9VW5jb3JyZWN0YWJsZSAoRmF0YWwpLCB0
eXBlPVRyYW5zYWN0aW9uIExheWVyLCAoUmVjZWl2ZXINCj4gPiBJRCkNCj4gPiBbwqDCoCAxNS4y
ODAxNTddIHBjaWVwb3J0IDAwMDE6MDA6MDAuMDrCoMKgIGRldmljZSBbMTBkZToyMmQ4XSBlcnJv
cg0KPiA+IHN0YXR1cy9tYXNrPTAwMDQwMDAwLzA0NDAwMDAwDQo+ID4gW8KgwqAgMTUuMjgwMTYw
XSBwY2llcG9ydCAwMDAxOjAwOjAwLjA6wqDCoMKgIFsxOF0NCj4gPiBNYWxmVExQwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIChGaXJzdCkNCj4gPiBbwqDCoCAxNS4yODAxNjNdIHBjaWVw
b3J0IDAwMDE6MDA6MDAuMDogQUVSOsKgwqAgVExQIEhlYWRlcjogNGEwMDgwMDENCj4gPiAwMTAw
MDAwNCAwMDAwMDAyOCA3MjA0MDAwMA0KPiA+IFvCoMKgIDE1LjI4MDI3NF0gcGNpIDAwMDE6MDE6
MDAuMDogQUVSOiBjYW4ndCByZWNvdmVyIChubw0KPiA+IGVycm9yX2RldGVjdGVkIGNhbGxiYWNr
KQ0KPiA+IA0KPiA+IERvZXMgdGhhdCBoZWxwPw0KPiA+IA0KPiA+ID4gDQo+ID4gPiBUaGFua3Ms
DQo+ID4gPiBNYW5pa2FudGENCj4gDQo=
