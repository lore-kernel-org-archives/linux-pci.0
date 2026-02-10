Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D0632ED22
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770756273; cv=fail; b=KqXpCv5f3Kthd5+cCf/8HDWw2SNI42Itqt3T0SsaIr31bNQSlPtO/MyBHCL2XJ97j+0D7HSOjVrbuYvDnQOLTs1i8zy9jRz2vBJKmYI3QR6H0PgMDtcH6+zNgQKv7FwU6gEjckllhtAzr4NoTKEK9df6mVAcCfntGHqXkRCf50o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770756273; c=relaxed/simple;
	bh=umVyVdPZuBjv6CCt1dA03lfNSCLH0qlqs+EbCnfPOW8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=HBxDfoSe80IIZYBvl5pJALoaXKyajvzADWeflDdEPI7yJCYymEWJMhs8vdMebJHKINCIZ6TmyLtGO5CHBpO++IaV+uFgGJhPHNYeefZ33P19Dhy3cxLp4phmmjD7wIf20OG9LhxjQ8LiXYdhbKo9uQmcXKtIEeWhZR2xHipsIpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDDlbcC4; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDDlbcC4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770756272; x=1802292272;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=umVyVdPZuBjv6CCt1dA03lfNSCLH0qlqs+EbCnfPOW8=;
  b=TDDlbcC4reFh2jqd1aHzJ0f6DqocdZyUqJVJbXrM2lq5TISRuekIuU3o
   3NBj4Y9qypxJf/p9sn3BwPbpim7uDiQUVYRsWxzliCUevct9bKBV1ZqX4
   GEbjKMynn2M0uVU7Jji8Vu1wzcreqWseRYVJLPzUwQ+RpxOCTfwLprElm
   ZQA7Ffrt2kw/XDFGJUNpYOXxEvGzs+8fqQN2DnpNfMTG/AqaY0YFoqzu+
   GLCNat8mt2jgX/Vekf3VIttZpAhvmMJEgUotM68LfP3iFzvpbh3x51i1p
   1YBBcXtrWAm77QQVf4L4oMgGDork+inuD5QKtGt77wPiOxwrT5Qm8qzLX
   g==;
X-CSE-ConnectionGUID: tvr6UJlcRPC9G7r+8gyovw==
X-CSE-MsgGUID: cYIade5ySHSjoOVWB0w7/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="97353603"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="97353603"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 12:44:32 -0800
X-CSE-ConnectionGUID: fkVX/75SRoWs7YaoPNOp8Q==
X-CSE-MsgGUID: HpHX9zS4SHKWrC042j1zzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="212065028"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 12:44:31 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 12:44:30 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 12:44:30 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 12:44:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPNcF/Uh5fuory7BxDOid3ezDinwwE7hwNtjXMaibGNrNUhWy1cXReVg6tjiv82M9d46lGdH/tWCn/IV2C9HzwAcRNbMCY6JFZjQvLE+bNQMLvTHGuBWahxM7cLDAMs7s/Hm1j6N5XVvAk5al/UcEMx4OuhWLpcHoM4jAeSTgZFCEdNrw6SKpxq2x3eMo4cQcR9ORTr3ConoTWWjDA9cHciDd9gz3zSfvonjv68ZRqaTdxs0ygAu99Pd+1rTE3LZSVoJQeZFv8H1HaULs3m2gg4GK2MalXP+x6vPJ22HhybLWyZxD7bC9lInbeXd8efzCenoniXwRma8T4fwdoEUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnYmz85IcqXYjgnJ/sBC0Vd1YThDLZuExbTQOqetry4=;
 b=qInqSVoMmm2AiDySgUg96L3GuAJY3XrwIlacq/bX9oG/bwFcKULqJTMoAU+gRmLB28FRVGiKjefBQQfVj3YplM0CJ0oRyyIK+ToMO/ODeXVC5QI/LUmtwgrtHniEpveZiNu11nKDzw8hrZEQrAyOzaRKzogV7HVys8/5W5P5SeK+EBvrVAhdaTYrqadYAup7Mwvzq9quj46vsS6olnbI+GBmvO1VdkWtcaUi72u+aJbqnNro/LgYlXIHSu49Fa758WXdDwWZI9iDFXpak3+c9/j+QzmevScwkUploDYYpKpsaejn4tdYcRZPbY9wfRNF4h8PGutCw668BujLdKZ+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7934.namprd11.prod.outlook.com (2603:10b6:208:40d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.20; Tue, 10 Feb
 2026 20:44:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 20:44:28 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 10 Feb 2026 12:44:25 -0800
To: Keith Busch <kbusch@meta.com>, <linux-pci@vger.kernel.org>,
	<helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
	<guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>, Keith Busch
	<kbusch@kernel.org>
Message-ID: <698b98a9aedc7_2e57100e9@dwillia2-mobl4.notmuch>
In-Reply-To: <20260205212533.1512153-2-kbusch@meta.com>
References: <20260205212533.1512153-1-kbusch@meta.com>
 <20260205212533.1512153-2-kbusch@meta.com>
Subject: Re: [PATCHv3 1/4] pci: rename __pci_bus_reset and __pci_slot_reset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:a03:331::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: d90d7107-5346-4c16-3aa1-08de68e52f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkZuTEFTcG1ZY2dpWUptUk1GWE52TkU1V0lRNlZ5c3RRMW9pSlpGWWVPRmtU?=
 =?utf-8?B?V2hBb3RIaWVhMmVMWitodHBBbFNtcGN5ZGpqM0dqQjJuS1UwUTNEWVdjQWNY?=
 =?utf-8?B?Q0tvaWNLeWZxVjFBZHBvRCs1dDJONnNGSG9abU5IOWFUTzAwVEd5TjlMNk1S?=
 =?utf-8?B?NnBjOEs2SlFJVnBpdXhOaW1ybUphN3NoekVJQ1l3cUVhUUw3ZDFMMkhaMS9U?=
 =?utf-8?B?M2pZZDlWaHhQTVVXWUhNRjlXbEQ5NkpVN1lFZlJva2lZMmExVlZNSDFLcjA5?=
 =?utf-8?B?eVVwODhlUHpjSDBNc2JaSHZWQ1VnTlZwUnhmVHZRWmQrRG9ZelRaU1pWaSts?=
 =?utf-8?B?aW1XaE5Cd3dvb2o1M09ycnUyNnJ6VDBDc1dpSXEveG9jeUVZZDZhUUd5c1cy?=
 =?utf-8?B?YVpndys4aG5PdDZjWEtPa0hSbjVXRlVmUXVZa0lNWGg3d3ljRFBRUUJFcjZn?=
 =?utf-8?B?NmN5R2FsU2twU2VMQThUb1dnTkduQXZzdm9XZ3NWeit2NmhXOUR0VUczbGNI?=
 =?utf-8?B?L0d6cTlWb1VlZWlKbEZKWDdqOUd1VGhQNUxkVHBaSmdtRFRCNHdBak1za1I3?=
 =?utf-8?B?cWU0MUpUR0NlY3JZTHhaaWVzNXlqdDJ5bjl6eXFwNXJJS1FWdXBZMjU1QzJo?=
 =?utf-8?B?NFZmeTdzeGRvYUszdlFpSDBFWHNGTEp1NS92OTVaSXFaUm9ubzUzaHBEeUl3?=
 =?utf-8?B?MkpZZS9kSUdtUVlmSExET254T0lrQUdkM2VVNThERTBqa1JXeUtvb05nVlYz?=
 =?utf-8?B?RDhUS0RHOFR2NnlnVVpnSEo2eTUvK05HeVFKQ2FyNHFrZTJjSlNPNlNvSXZh?=
 =?utf-8?B?WTBkMGtzVHVEcmdzZ2tCdDJGU0J2dnFqd3FzRUVrOTdFTVJ2NGtNdGxZRjBO?=
 =?utf-8?B?aWtwamRNZ2s1U0ZQMjM1OGVaMkFvdmdXT0NsSW81UThCSU5EM3g5L2t1RHlW?=
 =?utf-8?B?U25hY2JJWFdybG0ycHJBNU1LMWZ5UWNoQ1ZlUHZsL2c1cncwRUJQbERuck1Y?=
 =?utf-8?B?WGNSYjZHeFFDSWp6a0M0aTZjR292MkplaUxOYzJHOXd6aXd1V0NuTFhhTGVm?=
 =?utf-8?B?S1VNVUg0eXZFd003cWEvMkZiOFlLYUNROUhrVTFJdnp5Mzg2REtrU2dDYkIz?=
 =?utf-8?B?SWdvQ1FFbmp1cFlma2hGcGVHc3ZLN2poS1EzSFlhWWRMUmEvOEM4T29CUlAy?=
 =?utf-8?B?MVhCbFpzcWFkZmtJa0ZiVFZNb2VCdkxmSGpaaHZFaEtVaDVUNWtJMXFtL2J2?=
 =?utf-8?B?TTBKWXc1QXltbmZucVJNSlo4UVlxb01ZK3IwbUlQQUc5ZFFNZTBjdU5ScFNN?=
 =?utf-8?B?QmpzSFlZekdsL3ViWFNHNit3RkJXT3h1QWtFMStEN0RzZ21McmNKTFpOQkh5?=
 =?utf-8?B?N1pSby9VdEFMTHozdU16dUNJd0VXQ05oTm5QTGhOcHY0T3YxNnJNMFJHYUVs?=
 =?utf-8?B?S0UydTdFWmxEZWR5RTM2WmNURjRSWExCVTFxV3BHUTM3Tkc5NUcycVVDem5y?=
 =?utf-8?B?Y21HY282M00wdUZiNFplL1pWNW9GeWUrMExmZU5Ba3NZOFdvYUxCanI0VUdp?=
 =?utf-8?B?N2o3VThoMDBOZ3g4YjRkc0QxK2VIczMxU0NmQ2pqSnBKMFRLeGZ0bkExb3h3?=
 =?utf-8?B?c09OT1FiR2ozT3J3TUo1Y042Mmw2aFlzdjlTYXg5VGplWmlyN1lrUXg2NDZB?=
 =?utf-8?B?ajl0V2VVV1E2YmhnZDhHR0NpQklhUHdrMlcyVzU1c2J5amhvYmplVEw0dVRo?=
 =?utf-8?B?czY4ajdod0dMbW53dm1MNDFNZlZQZjRaa1BROVZOb3BMa0tSS09TNnF3SkIy?=
 =?utf-8?B?UU9BcmFSL1hlTlFFSlhJQUNTUDQwVEQzUk52ekl1VFZxRkpZTGxSOWo0cjBz?=
 =?utf-8?B?ckFKU0o4ZjdkVTIwVmIxYmlsNXdYb1BkUnUwZFZTSjdUT21Kb1ZLUFdXWE1R?=
 =?utf-8?B?aUxPc2xMMEluZkhxSFpYWFMxdWdDeGRpdVZIRk1zck9zaWJZVHRFRDJERnlC?=
 =?utf-8?B?MmZzNnBDVmQ2b2cyeTF5ZGJuNU84MU5HVFR1VkxlNXIxbXNWRDVwUmZySms0?=
 =?utf-8?B?UVJZMldaeHI5VHlpV3N1YTlMNWtHb1E1Tk1hZlk3L0hpVmtPVU9YU0RCdVcw?=
 =?utf-8?Q?oGmQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnlyODZTcnFTVVZQYkwxYjJpVjZrR3VGa3NmdmVERSs1SjFEQ1ZNQmN3TkR5?=
 =?utf-8?B?ZG5oNlFVRFpNR1ZmUGlLbDVtazZqTzVnSjdiWWdFSEx1TVdvTXFkY20xWXJH?=
 =?utf-8?B?ZXR1aC8vaWEreFRQcFNPRWRxN29HOE0yZjJmajZWK1JJYWdpWk82OGJBOHlW?=
 =?utf-8?B?WDZITk9OUG5OOFBqQnBXS05ScklaV01yUFFwWWhud1I5UFBCMHU0NERNZEVN?=
 =?utf-8?B?d0tyaXREMEZlRm9oWldqM2daaEZiclZiWm9HZUdEVWVvc2xkU29PbDNQNDRv?=
 =?utf-8?B?eDZ4ZDFBejhsV1oxSHV4YUVSRUxMb1J4aTA1NTRLRkRoRGMyYm5yRGFxMDNz?=
 =?utf-8?B?dHNSWVJmaFpBTXJZRlhQYXVKYkFiQXoyN3FRaGhlY05NNW1GMWIvaDcxblhs?=
 =?utf-8?B?VWxBcEZ4ckNZK3p4cUlXWXd2WXdwRHEvclUzUk8rLzV5RHY2NVF1UFpWQ1ly?=
 =?utf-8?B?Z0cwZ2JJd3owekZ5dFF6aUtRK1duOG84bjNYVjQ1SDN4blNYZzBNUEJIWDl4?=
 =?utf-8?B?TnBXK3NMK0lYcWJ3TC9MYlR5aDJISFZCNVRZVUhUNXJraEMwRkNya2VHbDNI?=
 =?utf-8?B?V3MyYWFBbjFPNi9xTW5mR3ZZUzFKZVlFdWtzdXpqYzhzNzJWcjAzbGszUTdL?=
 =?utf-8?B?MFZtL0QyWnU0cS8yQXNkalVMUlpRNFhuNkVmOGVXSlNoRkNXWnk5MW16ZlE1?=
 =?utf-8?B?STVuMkZxZkFaMUd4THBlRHZGVGRyYSt3MUlkWm1nVVJPZnQzTVY4Tm1FUjRi?=
 =?utf-8?B?Zmt1ZUhhdEdyUjRZMC9lR0g0c3BFZFArbERodlpkL1g1ZHhDa2laWDIvb3lI?=
 =?utf-8?B?Z3h1RXNReUpmaUV3QTBmWEJTMEoydlhaMjJmVWRxZmxFUmZMckJMcEFJWHFl?=
 =?utf-8?B?VTVOaWt0RjRMMUFPcUVKdE02ZFNFUmJUdGdLUG1NcGxaNHNQQy9lZ2NKczFY?=
 =?utf-8?B?c2FBV0NXYjBCeFk0U0MxYmxKSnpxeHJHSnltVFhsYVdlRGFIZDBocUxNWTVu?=
 =?utf-8?B?bFNwak9FWW50aSt4c1JlTzExMGY3ajV1ZGxBZU1CbWJIbTBuVmVpQVM3L2Ix?=
 =?utf-8?B?L1NiRWhNR3ErRDRIcE9Qa1lYSWR6UnhPKzd3YkUzRXhNM2pXTUFhdzN6eUNp?=
 =?utf-8?B?cUxQQ0ljOVB6eWNlVGFlb1pqbXVodERydTdqM3kyaUlrN3VlL3p5azg3b3lO?=
 =?utf-8?B?YmdSNlhNY0dQQ3BSaTZzVnk1SCtwQUdGZWFUZWJ2V2o0T3VRaHNKTDBuVjZY?=
 =?utf-8?B?YnFoZi9iT25zNTRyRDZnSmJLNzZYSlpRSkVHeStSZzg0QjI0K1ZoeGxsTE9C?=
 =?utf-8?B?dktjRG9IUTVOdHhvZ1NQUnpxM3hiNGE0TWtkUEhwYTJ6NmRIekdRRGpqNFV3?=
 =?utf-8?B?Um5kNE5YMzlBNkFEdW50aGVLdGFDd0dwWFE2YlhDckFWZ0pkblNQUkpVRlFK?=
 =?utf-8?B?UDkvbGlSNUh6TG00aWJld2gxV2dQcHZZZHhMbEhHUzFZRXBKV2YyYWNYQzFD?=
 =?utf-8?B?cWpoU2xaSzNVVjZUZGtuVVVPVWJhbEZoQk1aVVNjNDZwSjhUQndlb1FIbVJn?=
 =?utf-8?B?UWoyL0FFZmlGMWxBdVFzVEg5UGovdkVQcmhZSDlUU0NwM3N6VW5Yekh1eWZJ?=
 =?utf-8?B?blcyL1FuMyt1Wkh1Y2RuV1A1Z2oxbVVDamRwbTdEaWpFUlBTd2xMN0lCekZo?=
 =?utf-8?B?SDdaMk45bmxmM1B3MGZEOGdlcUszOW1OMEl4ZTF3VUJuNlB2QWhEUUpWaXFS?=
 =?utf-8?B?bThhSnNQaWJPcXFOdHlUVkgyL28vZmE3SzdxcEwvMjV2NnhjWExMdk1lZUhs?=
 =?utf-8?B?azJTRUpOVS92RFN4aENVem12S3M2TVl2amxEa2VXQ2tncXA0eHpuM1hBUW9q?=
 =?utf-8?B?RlozZTg1S01WTXBjZU1WWkowMzFWazFxbHJjMlBGMXU4NnVKMSs0L3JyTFlW?=
 =?utf-8?B?Q0R2V0Zpam53RUNjMmpzRGQrdUZUajdaMXM4ZjIrRC9UNHlrYUVkWmJSNVZO?=
 =?utf-8?B?ZDk0VWpzUXlWRC8xQldlTENlSU1zN0JMRGpjdVEwK1c4cFhCSmgrRFNDUEJJ?=
 =?utf-8?B?aUVSMjdqQXBuM215RmJCUW5qUytMd1NKY2FiVlgyL0U5b2d5dWNPaXRtZzdB?=
 =?utf-8?B?ODBtWWtmbHM2SlQ1MDZYVHhnVHFqdW9CZzBMd09hajU2V0dSOUZwdm1Tbk4v?=
 =?utf-8?B?NlVONlFHaHgrZjRXdFRGVDFibTAvTWhoWi9PeTVBQ2g5NTVJY1JlT0loNkFz?=
 =?utf-8?B?NEkrVUZ6dmp1ck1MMnJoN1g5QTMyU0F3TmVzYTc2Szg3RFdlaUhkK1RMOTdZ?=
 =?utf-8?B?WlNJaWViaElHZW8wSDh6S3MyTnFWcEJWVEliWmFDRU5HVEFvWFE5OU83N1Yw?=
 =?utf-8?Q?XKTgKXKotdYOuEgo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d90d7107-5346-4c16-3aa1-08de68e52f40
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 20:44:28.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jypQ3MfhqfBCrfH8W1Lpdp/yL0MplGEkyEGGALfAySjBxqcUWLJ+rJdh2HhS4KJf2lGrUoHXvFtV4RRa9ePeHhdJWQ+F+yYLxw/H1DIIn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7934
X-OriginatorOrg: intel.com

Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Make the code a little easier to navigate with more descriptive
> function names. The two renamed functions here "try" to do to a reset,
> so make that clear in the name to distinguish them from other similarly
> named functions.

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
