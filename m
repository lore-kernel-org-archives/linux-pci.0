Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8932116E0;
	Wed, 18 Feb 2026 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771428691; cv=fail; b=Dd9f76mlVePz7MZQAazRPM7Z7Fi0+eDOUSzkJ9DqJIK181c0erbI92hCANWFh17kLBdQewqLl80I+L7SJ9XpmFMDttpwWnYP1x06YhE1stQc14/mucSfbjWtF3kb3Y9EEg+T4Doz2AtFyYn5KTo4zpdPVM5/u0tRlfpEwtdEKUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771428691; c=relaxed/simple;
	bh=I7yEYNh6Ul4AMvD1xhOKIHMEFJ/8Nf4u/LpI29FT13s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FHFpb+TtdItawMKs1LFnG4pLS+3EvM2cAsY8YQttFdjDvGwhyWfXtDEwQjifT6GforLur9PPnNJTWat5ojWudycKH3/8Yj0OBrdFBheSKn4Z15p6P9T925lb42m9LxStDaLMfgDd5TApzbsm1xcZZv0noOIk4slH14PE4SEgocs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mREe+Ivj; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mREe+Ivj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771428690; x=1802964690;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I7yEYNh6Ul4AMvD1xhOKIHMEFJ/8Nf4u/LpI29FT13s=;
  b=mREe+Ivj+NMVxaMUQBgfF3VJ3bwFmbZqMZKiEImojhgeJjRlEGdqkv2T
   ost3RsHAaR/ZIeHhWF++7/YqWykA3rPsprK3XhCPtoOOL9kZjBbezG89b
   9ygQMrS8KckiYpWVHLcHMTuZSwnM9HBpyWKx2mrZFNz3+D5/Gsh7g3kFk
   GFBZK3uGjxjgsXeAiUrVkLEK8IVlMBuZLxJr7voUhwV1qpz10xuAaBIR7
   +SpvY3Tb1+iEyNuU0yktdCayya19JrROU2LRhtyeMoS+t59MtLzl9cmeZ
   l/PEJp5Rj17AFRNelf+m7WGSh6N1un0Ie5yXcbe+Msl/yHuydSFNPk6V6
   Q==;
X-CSE-ConnectionGUID: yy0KMe8tQrOcj+GQW0Jrfg==
X-CSE-MsgGUID: V2poyklWQx2ZeoLTNuBjiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="71526793"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="71526793"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 07:31:11 -0800
X-CSE-ConnectionGUID: QL2LKkc5SrmzWHikjRe2Hg==
X-CSE-MsgGUID: N+PQxr5zQRq0m2+BT78XxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="219220179"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 07:31:10 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 07:31:09 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 07:31:09 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 07:31:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Euy0IzzGOd2sIy+rZ0PY2RCvM4Lc3OwyjpTu6/oW/JTueQsPVCwgbf/ojWpP2KRgqtR/ALDS9XK7kLx7LdSq48Dral+aQRagZPTB3wpCIkIAbmXleFvaBu9vLjZvbif127nQKcnTj5LgPOsLVtLnf7AzaAawvBQeM1u3vmMLTLDpAcGSKht+R6dhuFed5RjaVmRxUkiiiR2gyPKXfgdVbbEx9H8DFbLwk0zVH0r5mOgYnX8jJpcwCevnm0uV9i67uLUhTnWGGpgray2xdyciWLef9OQfOqVALsdL4zgXBRikJPiFVPpwIajIltaJHuaPt0b9jzg5Ft56IzJBluH94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxLMd2id81oCzVrjGD4WxhWbBkspv7ViWZ4FE8/bJ7I=;
 b=qtXlNdlrEfEKIRY27mA0hueWECtIqYSx++WqVkb8HhhMrentbWluvC5hUpVCoSAMI0EQsQmFg+VBS9Uzxg8fQA9Hu/pY+DG9IDD0LoyZXsO24A6Qv+lbg6Ydo0EyhUJI+pBoxRWJQrBM7S86eGHPIQ36yMj1RTWuzsCyWoDa8MIm5lbCO1aJew1BYGWBHwEeHPXnGHbx8serpRDeGEMUpeg4h0NwRsLQ0fknhxib2AMAZ95viNkqXrJKykPG2ea7xUyUQSCCip0/hjjuUVfLiYoXYhXvuIFMpToJaaOWqPAnJmT5HFOizOAu/RqEb4ifUZKIqxiEMt7Op6mMlogZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5273.namprd11.prod.outlook.com (2603:10b6:408:132::8)
 by CO1PR11MB4996.namprd11.prod.outlook.com (2603:10b6:303:90::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 15:31:07 +0000
Received: from BN9PR11MB5273.namprd11.prod.outlook.com
 ([fe80::cd29:11b3:288a:2794]) by BN9PR11MB5273.namprd11.prod.outlook.com
 ([fe80::cd29:11b3:288a:2794%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 15:31:07 +0000
Message-ID: <561a71f3-dca9-49d7-a9cb-13c916340ad3@intel.com>
Date: Wed, 18 Feb 2026 21:00:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND] PCI/TPH: Skip Root Port completer check for
 RC_END devices
To: Leon Romanovsky <leon@kernel.org>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <giovanni.cabiddu@intel.com>, Wei Huang
	<wei.huang2@amd.com>, Jing Liu <jing2.liu@intel.com>, Paul Luse
	<paul.e.luse@linux.intel.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Yishai Hadas <yishaih@nvidia.com>
References: <20260109052923.1170070-1-george.abraham.p@intel.com>
 <564e872c-ecc0-479c-86c3-68b5d3fda512@intel.com>
 <20260218084254.GA10368@unreal>
Content-Language: en-US
From: George Abraham P <george.abraham.p@intel.com>
In-Reply-To: <20260218084254.GA10368@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::8) To BN9PR11MB5273.namprd11.prod.outlook.com
 (2603:10b6:408:132::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5273:EE_|CO1PR11MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec79835-0109-4a5c-ff6b-08de6f02bc44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEZVUTZacFZDZ2ZBcVRpM0hNR2NuRTRSU1lNemFONnFYTXkxOUVaWU1Lc0dR?=
 =?utf-8?B?ak1oalAyYkxmS1F4cTg0QlZCRi9CZ1B3NUYxQVdwa21jSTJHNnhiSDVMMTgy?=
 =?utf-8?B?M1grT0pVb2dNUTBqa1FRTjBSNkZKbjM1b1pBNWVENUc1eUM0WGI3T0xKdEJl?=
 =?utf-8?B?NEVvVURIZmQ0cTFvZFBvNUJ6RG8xZHlic05DNm16TkwzSlFya2lXNjNhR0Nr?=
 =?utf-8?B?ZHVvbnRTVkFmdVQzdHN6Z1UwT2l6YVNyY2xMVDVVL21RQ2g5RHAraEhKRlZX?=
 =?utf-8?B?NSs0cGVuZlZkUm5MWTMyQ1Ftc0tpUDlDUkVMWWgrQUlZbGNRNkdXNlB0VjJT?=
 =?utf-8?B?eDA1S210QnArTkJDK0d1NGtQbXNJamZPUGpEYVpySGY3Q2lmMElnQ1I2TzZL?=
 =?utf-8?B?MjRqQmhqTmlYQ1dJUWE3OHJVL1VBYTYrZGZUVlZyZkNuU2x5L1JDWWgvVVJh?=
 =?utf-8?B?c04rY3lIZFk0OVMxUy9VWStUditKdTlEUC9KOEdpL3hlSnk2SjdMbGtXdWJX?=
 =?utf-8?B?NzVKSWZuaitUZ0d5NGRza2piOVExd28zRFQvMFY4Z21hV3F4bmFBOFV5bFBo?=
 =?utf-8?B?SnQ1dHRJTncxR05LZ1B2TWZZT2pwOVFiVG1zVlNrZzlXaUVPcSt2eTBGcXJk?=
 =?utf-8?B?Y08xbHVueE9LNnA0MHI1Ynd4VFI5WHQvWVhDQWdLZEVxSjhlbWtDRFhtWFdr?=
 =?utf-8?B?aHJTdXNmUUJnWkpmcVQ0WW5kYWx2YXpTeUJ2RFZ1ZGZrZUIyRWphaHBDejla?=
 =?utf-8?B?aWVXMU1ER2pkTHFkRktzanZwNWVaTG1OdFJDd1VGcjErc09nOFp0MGZBdmNL?=
 =?utf-8?B?aE1wZFZLNFBhRnJiaUZmZU9TcGNDbnNMYmV2dHJzelkxNmZqQkluNFN4SWV6?=
 =?utf-8?B?bW45d3o5Q285eGRoeXVNSGpLRGVWMm5sdkxHRGYyMmNJWElIT1dQdC9aTURR?=
 =?utf-8?B?K0VvMExEbWJaQmFzai9lN2FJbzJNaVkwV3hkSXpZSml4T28rUU0zc242dlps?=
 =?utf-8?B?emZaS3R2OGplZXpSWUZtbWpPZE52bzBQNWlXWk9PUDZlNEkvQzhIVjJqSW8v?=
 =?utf-8?B?bU51TVBKc2xyMHpiNndtUWZQMHd6VWpvK0tUOVJWRDA2cGdBUlVXRlBjTzVx?=
 =?utf-8?B?bStYN0E1TEptR3poa1FMRWxDckxjSE02Z0JCeXpJa1Y0cUNvR0R1T2FPZTRh?=
 =?utf-8?B?Y21KMHBRdGgyeDBRMGxiY3NvcnhzdlpVbU5nTnNsV0pjRDJLbHRFbFFiVDV6?=
 =?utf-8?B?U0QxbnV3RmpyeGZSdTkvYkROZHcrNFA5Y3dTK0xLUitXWDZJOGRzQXpjb3Zj?=
 =?utf-8?B?R1VkSEpPb1JvOTByT1EwQlYxOFAzM3ZRWDVYcFhkVmszTEdQenY4TXBHU3Fs?=
 =?utf-8?B?Y1VzV0U0M09JWHNRWEYvOUVOUjQrOVIrVGNlazRRZ1NMMnZOR2QwL1l4VzJZ?=
 =?utf-8?B?S1JNMURmY1pzZWoxZVBtd24zVGxCREw1cTRaMms5eXpIbGllby9WOERUSW90?=
 =?utf-8?B?TjdaWS9teWQ3MFZUcjJmNUtBblVqWTVhYTVwTEVNR05zN3d6RG9FRVZ1WG92?=
 =?utf-8?B?cG5aZ2xXUzVkSDc3UllqWUpLa1c0dTlGa2U5WEdRN1ZlRHJya1dpQ2Uzamhz?=
 =?utf-8?B?OHFFUzdEa25xa0JjSWlySkNzU1k5MlpEK3c3UzZxcGU5OG1TVGQ1cGZhc0Vp?=
 =?utf-8?B?ellQWFdPQ2RtNU80SUZxV2xEVDhibEY3YmZWUmNWK2p6U0VJd3ltLzFuVTNp?=
 =?utf-8?B?SnJqWTU2YTROeTF0Y1lqVkVQc1pzeXM3YzBBQVdxWjk0WkdrZzljM090RUIr?=
 =?utf-8?B?azlGQUJ3SkdIc3NKdkpYMHlJMXJBejBzaHlURjNrMDRmT0JoUVVOY1pXZE5F?=
 =?utf-8?B?Qi9IYzF0ZENzK2gxNFNBWXNxT1E1VG5VNFljak1jVk1ZK1hOZE1jN2ZlUmxi?=
 =?utf-8?B?eXJyVkY4dlNjZ0RDRnFIRWcvS0NxbkQ0QVNxMVdiaTZiUC9oRkZ5aGtmTkpJ?=
 =?utf-8?B?bStCemZXN2VHOTZlZXRwd2hqZWJ3NW9LRlVodVYwUjFUd0ZuV1kxMWN1WDdl?=
 =?utf-8?B?TVhrVE1yaFFiVnRVTTB4NFdlOGIrSUtyRGRCeXYzVFcvU05Pd2x0Vm10T0Mv?=
 =?utf-8?Q?c6bw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVY2STBxMC9uLzRoUzQ3WWxNVlpqUzQ5SmtNRVVtSG5sbElGck1kYWxEWHYr?=
 =?utf-8?B?SmRaN3hHbEdBU2lmOTJmaHB4SXZ1TWk2bEc1dmxoWVJYVXRMV2pqNWxUQlox?=
 =?utf-8?B?SThDMzJsZjNQb2ZXVWN0Q1NFNW9HU0JtTUNhWkRoNkxDclJBU21Nanp5VzlY?=
 =?utf-8?B?MS80OUppR1F6YkQ0elY4a0pjTEFiZGFPT2crUDZSNGNIblRseFBuMDRJYURE?=
 =?utf-8?B?akg0d3ovektiZlNHRkdWKzRrVjlxaWhKM0VYSkpXNndSTDNvcU1JSFhEbTd2?=
 =?utf-8?B?YkdlOTA4UElRc2VJK3R5aENYNHJDOGprRGdaYzc4Wk1ZVHdVSlZhZE8yeDFi?=
 =?utf-8?B?c09JY3RtbHJKbEc4UXE0V2FDTTBzbjZWV3ZnY3JkVDFjQkdTMDhBMEZkdXg4?=
 =?utf-8?B?V0JFQ2RpUUhnRHgwR1JnaXdRbFFKQmxPcEgvdnV4b0J1VTRBQnh4QkxtUVc5?=
 =?utf-8?B?SC85N2lLQjRGU0ZPQ2ZOVUlLZnZkSlo5SVl3L3FMUmtySUlLWDY2aHYrQnJR?=
 =?utf-8?B?T3lISXR0eDAyVnI0Z2dJYjRoVkF1ZEp3OStxZThsV1NxNVJWRmdBZVZpNEZZ?=
 =?utf-8?B?SGxocmVOaDMwY1RmWkdzblVHZ2Y0RWdNTXozeDZzL0doa29QR3AyUmRHaEN0?=
 =?utf-8?B?dllEVlZINURhbTJTU0d2UEhQUGFCS0hLUGUrMzlrbUpKb3k3ekJabTdwY1Vu?=
 =?utf-8?B?RzU0Qm5NOE45V0dnaWxLejJzVVMxd2tDcVRXSC85TzZwZkdGUWQraGwzSE41?=
 =?utf-8?B?L0dFQ056amNMd0JVbHRNNy81R3h5Tlp2aHdPTExrNUlaaHZiMFVkZVJJd1Iv?=
 =?utf-8?B?OWdtdnFqQUJBUmNrUXJpbWVITjkrdldSRWZGVW5mMFNBcWJzWFZqRXl5TFl3?=
 =?utf-8?B?Wmt5ZjUrZG9tYzR6b2JNUkJTL0hIWHR5ekg2Q1dqTDZWM0dsc0VTOU4yTXdP?=
 =?utf-8?B?WW5OMUxOR2RXS3ZoTXBsTHc0NmtjR2E4aTZUMy8rNnhiYnNSK0hQZmwrR0dy?=
 =?utf-8?B?ckM1YzBSampNQWJWQXlkQXY1OS84ZGEvczZFdytrZmZadVR2eWszMmhnWXBn?=
 =?utf-8?B?SHlMRys0TXFSVVRYYWZEcEo3VFNvdXpWQlFsSnRGSnlZTzV6RmdtUGVjTXN1?=
 =?utf-8?B?TElZL0ZqSzhPOC9MNUplVGt1dnV5YnRLTWZyQUphMEZWbHZUV3dja3I2bVRF?=
 =?utf-8?B?SUZpVzNMUENIdXRFd2hjMFExdkcxRkFZTXFmakgxczJleFNEV1lmU0pESmpV?=
 =?utf-8?B?OVNQeVFjdWZBdU9HRWl6RkV1U3VxbWtHTzZiSmpUZG5heldOY29XbmNOV2cv?=
 =?utf-8?B?dDgxMjBPWmtlYmRRR203c1d4M1grOGZJN1h0alBLV09INmt3am5RZXU0RFBs?=
 =?utf-8?B?SW1tb1g4V0hMdmEvV1ZMR0JRK3kyZEVrejBPb200d2hmbU9UNGp0Q2U2VWhi?=
 =?utf-8?B?c0ZDKzdhSUN6V3VnVm01a01zZU9OS29RQ3FHejFiZzN5RjBQbHRYZkZOdUtX?=
 =?utf-8?B?SmZGdVNsd1J3OStSNlV6dklZMWsvajhCM0tROTZUU3Z3NjkwR0lMd3BDbGxI?=
 =?utf-8?B?a0VTWGtkNEtSb2h5dWZXK1BDdzhDbytEMjBCY1djY05Hc2NEZ1JBbFNwaU1X?=
 =?utf-8?B?NmJBalhqQi9hSFhKUDNVWUlkQkZJb1V4em1KQzMxOUF1bW9zak5paFh0Tm54?=
 =?utf-8?B?TnorT2VSTXgxVmxmUzJhQjlVUmpoUUd4amJSVkZobGVOb1RFNU5SSVhrM1gv?=
 =?utf-8?B?czFVZ2Q4c3U2SW9EeFJ6bmRXS0VyR3g5ZzFxMitOK2lwc1IxMk9JNlQxTmQx?=
 =?utf-8?B?UGxNR05BTVVqcVF3eE5tZGtnRWJlcVNHUGVZWDMvUGoveFgrdE56ZERBb3p1?=
 =?utf-8?B?N2o4emxxc2h5OWpHVlZWNjR2WTFsWXgrcW9yMkJGVGpWVGFVSDR2UVZkajhS?=
 =?utf-8?B?blRxLzNqenA2cXU1UXdjTmtzcE5PcGtNa09mNGhQdFFIN2RoSHkvaUlGcUUz?=
 =?utf-8?B?UHdOVkJ1K2N0cnBFbHJ6WjFpQ1lqN0ZnQ2pBd2M4eks2MGYxSWNJeGlpbTg0?=
 =?utf-8?B?M3gxbCtybTNiK0haL3duL2RVaFp0a0V3NE1idE5JNHBsMm0xVEcyN0VqUjlU?=
 =?utf-8?B?OUp0bzdWaTNvcDdPR3NqZUZQazQ3cStZeUdIVGxmSXFpOG1KOHRPNGo1Yngy?=
 =?utf-8?B?M3pNM1JQci81S2NMaWoweDhxMmkrUEJFNUN6bXV3b00wZU5SRlBpaWsyVktV?=
 =?utf-8?B?WlcyNEc5eEdkeHFjZU9UR1NUSGZMZlMvVyt0WGxZZC9zRWpwWlJrR211ODk3?=
 =?utf-8?B?dG44dm02OFBjOVkrM3h4SExRb2NPZG1pdkplZXc3U25wZ0M5TXExNWlyMXVl?=
 =?utf-8?Q?3NLzZlXfmqDRuSIM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec79835-0109-4a5c-ff6b-08de6f02bc44
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 15:31:07.5757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MttOxVOLFDDU6wNAkAJmM+z/JXXqNjKhImZwF1vuNvZH6CpikVCzqMykf3EdHY5DMLM0vs1jkXm2JE/baLYKAKeMbqYMFNL49+js1/4b1vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4996
X-OriginatorOrg: intel.com

Hi Leon,

On 18-Feb-26 2:12 PM, Leon Romanovsky wrote:
> On Wed, Feb 18, 2026 at 10:24:28AM +0530, George Abraham P wrote:
>> [+cc TPH authors that were missed in the previous mail]
>>
>> On 09-Jan-26 10:59 AM, George Abraham P wrote:
>>> Root Complex Integrated Endpoint devices (PCI_EXP_TYPE_RC_END) are
>>> directly integrated into the root complex and do not have an
>>> associated Root Port in the traditional PCIe hierarchy. The current
>>> TPH implementation incorrectly attempts to find and check a Root Port's
>>> TPH completer capability for these devices.
>>>
>>> Add a check to skip Root Port completer type verification for RC_END
>>> devices, allowing them to use their full TPH requester capability
>>> without being limited by a non-existent Root Port's completer support.
>>>
>>> For RC_END devices, the root complex itself acts as the TPH completer,
>>> and this relationship is handled differently than the standard
>>> endpoint-to-Root-Port model.
>>>
>>> Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")
>>> Signed-off-by: George Abraham P <george.abraham.p@intel.com>
>>> ---
>>> v1->v2:
>>>   - Added "Fixes:" tag to link the commit hash that introduced the code
> 
> I do not have a strong preference; I am fine with adding a Fixes tag or
> leaving it out. Up to commit 2961f841b025, pcie_enable_tph() is called
> in two drivers: bnxt and mlx5. Which of these devices is the RC_END
> device?
> 
> Thanks

qat_6xxx supports TPH and is a RC_END device. The patches to enable TPH on qat_6xxx is yet to be reviewed. However, it requires this fix for the same to work.

Thanks,
George
