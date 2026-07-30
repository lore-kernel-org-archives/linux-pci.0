Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A231716E
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437143; cv=fail; b=bRShP2tubJ2/USwNdUgs1Sm5Xu5SAEARoDvvDkcxLyCwv/6nx2OrxuQD3vxJAUbLDGkNxuNsQtbuiSWJPbHg46nG3+rrnpWOxIU5WRkXuWNbawwi0IrBOETyU5ZAWe5A7mDhhh/ENFI7xoaVR9lPbP5yMXWHvo+AtJ3P+EJ/CLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437143; c=relaxed/simple;
	bh=HvijDUUg+G3rZgfxUPlFBSUIBE64bcY9YtWwhyBiu/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QsTGL7UCOSY4ML3+QP/jOFr9g4SJ5MNMhySlYG6t3Mr6yeo/5HqcWczFOCVTXJZxR3O2Vyjhn9bIzPnmQO5wD0afRe29v4zA2qDyFQPfdNRDe/aJQ1AgTa+i85GTr4LoRVJ4ThfMJinr2ANS0b49nWigvfR6Gji0aOuVdW56WEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kM0l/yps; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kM0l/yps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785437137; x=1816973137;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HvijDUUg+G3rZgfxUPlFBSUIBE64bcY9YtWwhyBiu/U=;
  b=kM0l/ypsgm57DGtkI31kPTd9rhGTIMUSdJKelefq+Nl+wRsfezU+x0ew
   Xgr/t4dmNp3aDnA66LbBZn54lj9YfPUH4nvMpfIN5GbjNjgKoJ3tpiW/f
   JltUkI5D3VDQOUPbCD7PEICY/oHRI+8U69FJ35Bxw7UYKV2LK9jrRhPU+
   ch4CK6wBroqKoRasPYph9ILSk5J/7hd12EFUDVUCQVIotMVQ6ZvSpGbF4
   I8iaAzW1ncig28676kBFrAszcHo91K4rcf1yv/oqN7DbhMLdFJoNivihB
   RUNbM8PQQLwJdcjwss6NwRUXRai0tyCpXILS9gpXYbarkGo8fnhQbUbuq
   Q==;
X-CSE-ConnectionGUID: zFMfW9OpSmKZTvepql6jJA==
X-CSE-MsgGUID: b1KojZ/YQ1OxD81qv1KKCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96425074"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="96425074"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 11:45:32 -0700
X-CSE-ConnectionGUID: i+hOPhMcQciUFu3egyLEEA==
X-CSE-MsgGUID: eoF8ZJgcSzSVTejoAnt7UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="260986610"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 11:45:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 11:45:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 11:45:31 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 11:45:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eo1Q/znHyh6L6NtxthtNOLlZqBoR3CmZIXAMuMdTMkU6Cv9PMVLHreud7riYLMTKjKJ1zEqx83OV68o70zot81zA0l9z/NyuCnakwovtSOHC48PALv20YMVnxIgr6NK6+N5R8qi+yThA44yMOajNf+0fzzdo5WU93PCAt/QRP+8aCF1FNx4SPLmKQz5elrqORcJz7SK0Ls6i9lblw5rJ+SI2jYT7roGASYOsuWdTW6eCHKsJyCZwm53Pw42K8G+UzupHDqkUZn33GMYIqv5LiB9fkK48BXs2p/b/RSk2wvM92iMbxEvNVfM+UXsOez6zQoocsy4+F0M2EzSVZfLDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvijDUUg+G3rZgfxUPlFBSUIBE64bcY9YtWwhyBiu/U=;
 b=FgXeudeYxfThXh2w/nHDDsKQbXn/revRGj/b0ZyCKTL7uFgtUwznWp0EjRb72Pf/LlJRdgQ0YrkjAV8QcMgbeCcPr3h+VYlupnyNmWu55bAYohi1XGDe4gNbJcQxidxXL3PjO+6tof5ukZlpN7o3GIrUkuNZtAtBeE+LdtibgQmgbteTj5ceouCTcVXpH2isJonK31n7hq/PEOV8ufw7E5y5WiMMSDT2ExvfCIMf/GIXB+/WO5zs/wS5IV+UG7CAQKpBYKD0ZaWWiM+75JvJ9jV1zJyQIPsWpRs23WyfKKVaTvCELgMTC3j6gYKOMXcqGYFScTGfxRSRfw4/PLGWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 by DS7PR11MB9451.namprd11.prod.outlook.com (2603:10b6:8:261::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 18:45:29 +0000
Received: from PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083]) by PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 18:45:29 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>
CC: "thierry.reding@kernel.org" <thierry.reding@kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "treding@nvidia.com" <treding@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Topic: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Index: AQHdAUruh/HWEZwEC0iMA6tK8iUSn7ZImB0AgAAE6oCAMTTxAIAABOIAgAAe6wCAARjQAIAAHZOAgAhH+4CAAAUPAIAAEYwAgAAGZYCAAAi/gIAAsEyAgAFxSwCAANOCgIAAFZ0A
Date: Thu, 30 Jul 2026 18:45:29 +0000
Message-ID: <fe27839dfc8c33104ea215912cb7d33c85435fe6.camel@intel.com>
References: <20260730172807.GA1508799@bhelgaas>
In-Reply-To: <20260730172807.GA1508799@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7494:EE_|DS7PR11MB9451:EE_
x-ms-office365-filtering-correlation-id: af47c759-af45-4018-40a0-08deee6aba73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|6133799003|56012099006|3023799007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: EywiNGT4GwiL+q4ZiNtw08bCwoGd4LSrUSB135VMmAfnASyGSCcsAz4f5x0fs664EYi8sIBJYTX6ckr+7sudJFvZZzX+TbSXGRYsdYQNnO4jV58cMPgr67zdrCZ8EF8/VkxBzoSf7QCAStK5YzW7nLAsuFDsZOsrdN2MdNYSE9ZQb+sP5bL5kV2MOw6Wd5eJzTszClw4ORr0oRuBm4yLU6cRCNzN7+xtFRCxhDK2hU65uhRkIUqhn5c7qFz9BvnxGKe9zsR87WfQl8P7vxrX5Ri1FvMtxUAgP/c1ttPG5r8Zb/XBMGQcG2USrbhgOK6oB6YgR/Maepx/OT8IQEbAlDgiqEufJ9ZCtc5fMRFtO/Bo5FWBtJ3IIHJFa+93A+8UgpKUawSgcy3mr7L5nYlXNztefoHkKiAdRQ6DeFmiuukm00mg0VzhI5P24yXVgn+RonfGPThHRDhrHyhro0/RSqdkjVq5PZGedAM2LZ53j89nFlFn7CWDAD6oZB2idKNbnfIlvQx2hAWkZgXrfQCf9pdC5XVS7yIpCD4r0UfHPKzQJkT9ykuEAfjqXckcjM87uWB2GITvKUZWhq8L9Q4bPia39RkMmUDqv2Uy/lZ3eZBkYaGgJVsdrGvNW7RccCgCWVQ6zoq8HKpRtecFH+438W8D2i1W4fjKsqKwFdyEll+sV6bGLXGIrk4tTBeZHFlHbRT/LvRhtOht6O8cjMzbnhvVto+nvDPAhucxBfbxFLk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7494.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHF6NzZNLy85dWw0amk0UUgzVERiemZ3VTZKYjB5RVRzTUlWUUNvVTg3OG4r?=
 =?utf-8?B?bTVrdFhjSnJWbVBjTTNCdkZHWXliTDlpU0xOUkRseVAwenY3QU82Vll2Q1Z2?=
 =?utf-8?B?aHYxTUhBMnpxTW9aek9iZTlCeDhLZnVjWHE1Z0MxSis5eUpTWW9iTjBGYW1V?=
 =?utf-8?B?VzJmVzJSdStqRnFXV1R6WkI1bE9jbjM0WG0zcU41QW41N0hwS2JReGp5ZHdK?=
 =?utf-8?B?OWVzcWZQeWJlbmtXODhVRjdNWkorNmhvekFTREhqSmNHVGpCUW8xN1ZKdGdY?=
 =?utf-8?B?MmZDb1VhRGY1K3Z1eTJTMTVTalRWSWFObklLNDRkNjJDYlJ5bStiTnR3SEdC?=
 =?utf-8?B?Y09sZU5oZmpBbWdzb05ZTHVXNFVyM3FyWWJmeXorcyt3ME4vMW1EVVJiekFh?=
 =?utf-8?B?L043ak9abGliYUVBazJpSHhYR2ZSdTdCTWYySG9uQUUzQXhmTEtJOFRwd0hF?=
 =?utf-8?B?Q1p2dXJXemxwbmN3VWYwbjZ4MzhZK1N3T1ZsTEJzUyt0Q25XRU04WlVsek8z?=
 =?utf-8?B?TDU4a1lMY2lyYURpSVVHRHh2OXNEM3FKdUgvbmx4ZXRPWVQ0SElqZmpBaEJh?=
 =?utf-8?B?MDdlVXlSWWZqTGJFTEtQUHR5KzlENlk5alUvelNpVmVUUDFQcVRRalhVRlc0?=
 =?utf-8?B?ZkQrcnA0cS9rNzAzdmNUTlF1QW5mMUttVTRDOTg1ekQ0SEZWY2NFRTMwRTNr?=
 =?utf-8?B?MTRRWnJQbGxBNWdoNEZxMDFzM0ZXcExhWUx5UGZHVHpkYTVMYmp5Y3gxMTNz?=
 =?utf-8?B?QUtTbjF0RHAxZnNLMTRLc2t4elMyYW1qU25rWVl5RDRCb0taSGhCQmFZYjg2?=
 =?utf-8?B?bTBYQmNEZ1pVZmF3UTRnMEV0UXVWVTZMaDVnL05YTU5DbSttY200bDJwOGs5?=
 =?utf-8?B?TWlvMWRKL0FlL3I5UkhsTGxheWRIVHdSd0p5Z2E2STVmQ0VoN0cyNU9RU2RJ?=
 =?utf-8?B?VzV0VWRzYTRVcWVoWVVsWkVJbDlFVE0vdS9yZW1MTWhxeEc2K2w3SWFuZ1ZL?=
 =?utf-8?B?ckYwMERndy9QZ0ZuQ3BmOG93NktaK0pmNVJMS0VSYlZBU2NVVlRLL2Z1UnlI?=
 =?utf-8?B?QzBCd3VRem9zclZwL0ZjRnZCMEgwNVVIRTM2Vnd3QU9NVytBU1ptUW4zYW9K?=
 =?utf-8?B?V3B3YlhkczZTOUFucDFZbEgrK1N2RThGbWRSaXVSS3AzL0h2Y2xhOUdPY1ZT?=
 =?utf-8?B?aFh1OEJEUTRnTkpESWp5a010UC9SanVncGpBOGN4UytWQkl0bEg3MmtiTVpu?=
 =?utf-8?B?NExVdHJZTTYybHZoOFM2WEhLSEpybjR6UGlsRjVHcDNkVkxKRU9HRkNIUnRY?=
 =?utf-8?B?T2d2T29vMnl6Z1krNGxBY21TeTg5amlUL0R3TWJ0NmM0aENqK1A5L2hGdjBT?=
 =?utf-8?B?dkt1bFRwUzg2TVQrSnplbiswRVovUG42T3Roa2dxckpTMmV3UDJlWnVQcmRX?=
 =?utf-8?B?WGFxU0JYVkdZZDU3enZuRTEwL1Q4UTVPcXp1TzgrUmVVR2dtM0FjYXlvSGpX?=
 =?utf-8?B?aUl4bGU1WlVVdkdZOGF5bDJwR0NLam0yWE4xeTRYSmlLSm9aNndacHhVK3RS?=
 =?utf-8?B?SnFWZDVKdk9MQkJwSVdCVWxiT2Z0WVFtbkNtTWRVdGFmTS9vVEhQeWloUHVV?=
 =?utf-8?B?NXAwSlhXaGxoTHU4bDR1bXVYbDNaTmNOOVBEU2xHVzdvQk1FZWpTdVc4cFkr?=
 =?utf-8?B?YU01TllDcGtkeC9uWkxnakR3Z1JmV21MbVlCTjF3cFh2QXk1d0h0NEMwdzNB?=
 =?utf-8?B?bTFSN1JZSG83U1NDbi9IT2FNZFJiN2Fkd2NIeFdvRytlS21YQkZEWTRXUkpM?=
 =?utf-8?B?TnZXRTV5b3k2aWNOcVdObUJscHZMVzIzSERjS2xybWNyY3ZOWlhGc2wwUlJS?=
 =?utf-8?B?V3JrL1BtVEhlSWJWWFRpcGRibjdZeUg3UE1vanBNRldWSHp1NmhqbUV0NzF6?=
 =?utf-8?B?b1NHQnVNckd0ZEdmSHoyY1c5WHNESDJyU2hWUUNXZEVVaWxsUktYcEVyMXVs?=
 =?utf-8?B?YmFLL3NpSkJOVVU1SzB3T3RzNUc5WEIwMXkwYnVNNWhpZlZCcmMwajdyTzQ3?=
 =?utf-8?B?ZTQ5YTd4ZW9NVjJVY1I5VU5DVzJTMU9iM0E3aEpVZ1BLeEJQbVp1U2xEeEc4?=
 =?utf-8?B?MDJ4cURoSW52MXcwalE0dmpSY05tN0J6MnFVTW05WENzVnUveXpEa2svN2J5?=
 =?utf-8?B?cmNhcTJZTFdjcEFIdkF0M2dabERoRVlQRHFIU0FLMXFhSFYzbmh6cGQ3YTdu?=
 =?utf-8?B?K1F6S2EvR3RZZGFHdDhKOFhPMUdFTlBudjlkSHpYWnZ4V1ZkOFJVTkFSU2NO?=
 =?utf-8?B?UkNLM2hRNFdrdERHUHo1U2gwQmRuVUhLOU51UUMzL1M5M21obzh3VW03ZytR?=
 =?utf-8?Q?tGUnGC4sLUof6N6Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD70D96B03253945B04EBA0039A8BACC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qNoaN1X9Aa2CRzSbG5ep5JGhbBGpb97Y0UiIE1T3Ru7jMfeNMwN88p9fEOsH949WP2OtBGduotbK/gPM433Uy2VIzRdd+JTZdJy/SPbGgRlFXPvWIeSw3xthWpTiHH6/lpEZgY5NYh2Q+aAUcb6Xo70P+oiDAZOL1VKTEVN2MUTJPqXE/L26WimLC1x5AgghVyVQ0gbFFnhDdkyKT472txlgL3PC6y+0K/wuSnh+FoP6zN0C8QWBqWz5m9kgwJewFY/a/RjA2p6MS62kNNU76CQXBs2ghJIrfPUqzbuTOfC4iYZyC63F382abRvbioJa5WTrKVWJLYaejFgAo1VUqg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7494.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af47c759-af45-4018-40a0-08deee6aba73
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 18:45:29.5092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGX3obR/05jZCNJMmw/YIfd0CTwCdCMRvkS5r1C7Vw1hAZWRUagSZIdXPbg02hBzJe5uKFD8mj94iOCRztVCTw4y1M4UezJ12oF0Lyifz0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9451
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA3LTMwIGF0IDEyOjI4IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBUaHUsIEp1bCAzMCwgMjAyNiBhdCAxMDoyMTowNkFNICswNTMwLCBNYW5pa2FudGEgTWFk
ZGlyZWRkeSB3cm90ZToNCj4gPiBPbiAyOS8wNy8yNiAxMjoxOSBwbSwgR3J1bWJhY2gsIEVtbWFu
dWVsIHdyb3RlOg0KPiA+ID4gT24gVHVlLCAyMDI2LTA3LTI4IGF0IDE1OjE4IC0wNTAwLCBCam9y
biBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIEp1bCAyOCwgMjAyNiBhdCAwNzo0Nzow
NFBNICswMDAwLCBHcnVtYmFjaCwgRW1tYW51ZWwNCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4g
T24gVHVlLCAyMDI2LTA3LTI4IGF0IDE0OjI0IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiA+ID4gPiA+ID4gT24gVHVlLCBKdWwgMjgsIDIwMjYgYXQgMDY6MjE6MjNQTSArMDAwMCwgR3J1
bWJhY2gsDQo+ID4gPiA+ID4gPiBFbW1hbnVlbA0KPiA+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+
ID4gPiA+IE9uIFR1ZSwgMjAyNi0wNy0yOCBhdCAxMzowMyAtMDUwMCwgQmpvcm4gSGVsZ2FhcyB3
cm90ZToNCj4gPiA+ID4gPiA+ID4gLi4uDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBB
RkFJQ1Mgd2Ugc3RpbGwgZG9uJ3Qga25vdyB3aHkgVGVncmEyNjQgd291bGQgc2V0DQo+ID4gPiA+
ID4gPiA+ID4gTm9Tbm9vcCBhbmQvb3IgUmx4ZE9yZCBpbiB0aGUgTU1JTyByZWFkLg0KPiA+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gTWUgbmVpdGhlciBidXQuLi4gSSBjYW4ndCBjb21tZW50
IG9uIHRoYXQuIEFuZCBkZS1mYWN0bywNCj4gPiA+ID4gPiA+ID4gb25jZSBpdCBkb2VzIHRoYXQs
IHRoZSBCRTIwMCByZXBsaWVzIHdpdGggdGhlIE5vU25vb3AgYW5kDQo+ID4gPiA+ID4gPiA+IFJs
eE9yZCBjbGVhciBpbiB0aGUgVExQIHdoaWNoIGlzIHRoZW4gY29uc2lkZXJlZCBhcyBhDQo+ID4g
PiA+ID4gPiA+IG1hbGZvcm1lZCBUTFAuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+
IFVubGVzcyBpd2x3aWZpIGFza2VkIGZvciBOb1Nub29wIGFuZC9vciBSbHhkT3JkIHRvIGJlDQo+
ID4gPiA+ID4gPiA+ID4gc2V0LCBJIHRoaW5rIGl0J3MgYSBwb3RlbnRpYWwgcHJvYmxlbSBmb3Ig
ZHJpdmVycyBpZg0KPiA+ID4gPiA+ID4gPiA+IFRlZ3JhMjY0IHNldHMgdGhlbS4NCj4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+IEkgLi4uIGRvbid0IHRoaW5rIHdlIHdvdWxkIGRvIHRoYXQu
IFRoZSBkcml2ZXIgd291bGQNCj4gPiA+ID4gPiA+ID4gY2VydGFpbmx5IG5vdCBkbyB0aGF0Li4u
IFJlZ2FyZGluZyB0aGUgaGFyZHdhcmUgaXRzZWxmLCBJDQo+ID4gPiA+ID4gPiA+IGNhbid0IGNv
bW1lbnQsIGJ1dCBJIGNhbiBjaGVjayBpbnRlcm5hbGx5Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBGb3Jnb3QgdG8gYXNrLCBjYW4geW91IGNvbGxlY3QgdGhlIG91dHB1dCBvZiAic3VkbyBs
c3BjaQ0KPiA+ID4gPiA+ID4gLXZ2IiwgYXQgbGVhc3QgZm9yIHRoZSBSUCBhbmQgdGhlIEJFMjAw
Pw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBBbmQgbWF5YmUgdGhlIGRtZXNnIGxvZyB3aGVu
IGJvb3RlZCB3aXRoICJsb2dfYnVmX2xlbj0xNk0NCj4gPiA+ID4gPiA+IHBjaT1lYXJseWR1bXAi
IGFzIHdlbGwsIHNvIHdlIGNhbiBzZWUgaWYgYXR0cmlidXRlcyB3ZXJlDQo+ID4gPiA+ID4gPiBl
bmFibGVkIGJ5IGEgYm9vdGxvYWRlcj8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIGFzc3VtZSB5
b3Ugd2FudCBhbGwgdGhpcyB3aXRob3V0IHRoZSBxdWlyaywgcmlnaHQ/DQo+ID4gPiA+IA0KPiA+
ID4gPiBSaWdodC4NCj4gPiA+IA0KPiA+ID4gQXR0YWNoZWQuDQo+ID4gPiBOb3RlIHRoYXQgd2Ug
dXNlZCBhbiBvdXQtb2YtdHJlZSBkcml2ZXIgaW4gdGhvc2UgYXR0ZW1wdHMgc28gdGhlDQo+ID4g
PiBrZXJuZWwgaXMgdGFpbnRlZCwgYnV0IHRoaXMgZG9lcyBub3QgaW1wYWN0IHRoZSBpc3N1ZSB3
ZSdyZQ0KPiA+ID4gZGlzY3Vzc2luZyBoZXJlLg0KPiA+IA0KPiA+IFBDSV9FWFBfREVWQ1RMX1JF
TEFYX0VOIGFuZCBQQ0lfRVhQX0RFVkNUTF9OT1NOT09QX0VOIGFyZSBzZXQgYnkgSFcNCj4gPiBk
ZWZhdWx0IHZhbHVlLCB0aGlzIGlzIGlubGluZSB3aXRoIFBDSWUgc3BlYy4gSXQgc2F5cyAidGhl
IGRlZmF1bHQNCj4gPiB2YWx1ZSBvZiB0aGlzIGJpdCBpcyAxYiIgaW4gYm90aCBjYXNlcy4NCj4g
DQo+IEh1aCwgeW91J3JlIHJpZ2h0LsKgIEkgd2FzIGFzc3VtaW5nIDBiIHdhcyB0aGUgZGVmYXVs
dCwgYnV0IGluZGVlZCAxYg0KPiBpcyB0aGUgZGVmYXVsdCB1bmxlc3MgdGhleSdyZSBoYXJkd2ly
ZWQgdG8gMC7CoCBBbmQgdGhleSdyZSBib3RoIHNldA0KPiB0bw0KPiAxYiBvbiBteSB4ODYgKEFN
RCkgUm9vdCBQb3J0cyBhcyB3ZWxsLsKgIA0KDQpOb3Qgb24gbXkgSW50ZWwgUm9vdCBwb3J0Og0K
DQowMDoxZC4wIFBDSSBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIEFsZGVyIExha2UgUENJIEV4
cHJlc3MgUm9vdCBQb3J0IA0KDQo8U25pcD4NCg0KICAgICAgICBDYXBhYmlsaXRpZXM6IFs0MF0g
RXhwcmVzcyAodjIpIFJvb3QgUG9ydCAoU2xvdCspLCBJbnRNc2dOdW0gMA0KICAgICAgICAgICAg
ICAgIERldkNhcDogTWF4UGF5bG9hZCAyNTYgYnl0ZXMsIFBoYW50RnVuYyAwDQogICAgICAgICAg
ICAgICAgICAgICAgICBFeHRUYWctIFJCRSsgVEVFLUlPLQ0KICAgICAgICAgICAgICAgIERldkN0
bDogQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0NCiAgICAgICAgICAg
ICAgICAgICAgICAgIFJseGRPcmQtIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3At
DQogICAgICAgICAgICAgICAgICAgICAgICBNYXhQYXlsb2FkIDEyOCBieXRlcywgTWF4UmVhZFJl
cSAxMjggYnl0ZXMNCg0KPiANCj4gU28gSSB3b3VsZCB0aGluayB3ZSdkIHNlZSB0aGlzIE1hbGZv
cm1lZCBUTFAgZXJyb3Igb24gcHJldHR5IG11Y2gNCj4gZXZlcnkgc3lzdGVtIHdpdGggQkUyMDAg
aW4gaXQuDQoNCkkgZ3Vlc3MgdGhhdCBCRTIwMCBpcyBhbG1vc3Qgb25seSBwbHVnZ2VkIGludG8g
SW50ZWwgc3lzdGVtcyB3aGljaCBpcw0Kd2h5IHRoaXMgYnVnIHdlbnQgdW5ub3RpY2VkIHVudGls
IG5vdy4uDQo=
