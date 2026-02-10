Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584BD33121E
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770756724; cv=fail; b=feKrlAPvQGfaepJjwqkZUWYHNi0vFnQeVfN9PJBNOphO3fmK9LCVXBodKZ+dmMjwAEwhyhkhz/yH9so3pMmMhnGl+ui2htilkdtRAQ5TKy6IN69z3w9hNVHBQ9vqABBhRFqQArsKzW/q41uDL3+HReqSQlOqUN7cdjjSF7F8/Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770756724; c=relaxed/simple;
	bh=Ljzy5bGFNEq4lg4kWRaFXCtEp6+UcJl98u9W74424fc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nILnNbuTVOLbaJPuTRfT9dHJb/Dy7o/pJXigFWLjCOFW06yN0cVvTronmzuuqB/z6LmxSsB/fdiZsWiz1tNi6paINkwrV1ZfDi1dlAxRC21y0A1RHHSOS4WajVXyDKSfKdPOyEM7uClisKePAdB7pscRTyQilY/8F31q+UNBPTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j25fJwb4; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j25fJwb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770756722; x=1802292722;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Ljzy5bGFNEq4lg4kWRaFXCtEp6+UcJl98u9W74424fc=;
  b=j25fJwb4G7CfCUZil0L6Vry5dsSIq2GEg3ytB87dRdMpZwoBKP6KsCZx
   oTS6wgFJYd8TkvAdEaTNwoHkLKWldKE0BI0uuCsqdtylNnphLyfaUucTT
   CMnjBH1rA/LBw7CqZkU8UzmtPK859ojN3juowmgAjK3va1lC+KFdG6fGo
   pSk0FAO/nUEWoPqzQHnvvE9oXjL5s4BCz7aMkBESZwgXRYR9wBfrJ6bRk
   CN3Dk9xsWWDHdepa0DrtMGhHUacPxCHs1XEPOE38q+R58G7Vh3LQ6GbTV
   q1dazq+Ip9TaAJR+g8flBjhNDdrblQ0GHxQ0Qrvw3dgnnHi652B+6FnHI
   w==;
X-CSE-ConnectionGUID: Ii3EiYZmRzSRsGhf5ez9Aw==
X-CSE-MsgGUID: A3pkYTdeSBOdEnIcUN/cCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59463701"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="59463701"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 12:52:02 -0800
X-CSE-ConnectionGUID: IhH3r1eTQXuhfKFa8eL5ag==
X-CSE-MsgGUID: Ev63YEwvRIu+CiYABaq33w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="216537304"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 12:52:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 12:52:01 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 12:52:01 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 12:52:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQ3fKuB5NZfGDvLqtK3FY1KcNli8EEJykFok0VXIf0Doa05sL5Rp4IukYmkptMOJcFETOK117gGVmfQHtZmib/XhPKGET0475ZoiRRPLUxDvq42quUJZN6MDmjosBIwGN5gXe9D1Fl7Pr3L6ayzXGM7hRLL4eW3HKgKsspTi2I6ZSJxCZW0762qOOuOK8YrPcqNOFMgBbifwEaIQM4TAXjrKYCb/WFk1BGd6+AhoAQmJaUN0dCqsoyyAqOdnrIL1pHJbP9F+FgoBKrmY0h6TGOpzT3DebUHQSKWI6v99eE7Z5qmKSsNOtuMDrgGhgL3KNTTe0aZ2RgTNyKtXEliIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6NrFnhaIa5wmARSwM+UEtibRhffTCt7XENRp/hU1e0=;
 b=kCguZ/hSUM/+prZGlOtXEGtNKlwclCWW2hBa8PG5z85ZihMcbpK0qMND0JCdfx0RFL/3feTNdA45anqVtrlI6MUhkR2iVPtkCAdZhPjARHPiE1lgOrOeceg529m2JGR3mWSaa5ZfECMW+MBHXIgAaJDOMPDuLYKOpQRud08cf1NlSL+kqAubbId0C3ZfdhkJWOTQmErC7C1OMp+uHBYNd9o+1MjDxVxbT+DYPpxQKQaIlRU+wDF1tWS+PS+8g6IDKSx8Sx5FkcfZu+BJ09hc0gvrugI2bmj3qne1H/i161Vqx5lsXvQv4vDVmwqZmmLlj0dCRXVWMWPLyqzhBY9Syg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8069.namprd11.prod.outlook.com (2603:10b6:8:12c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 20:51:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 20:51:57 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 10 Feb 2026 12:51:55 -0800
To: Keith Busch <kbusch@kernel.org>, <dan.j.williams@intel.com>
CC: Keith Busch <kbusch@meta.com>, <linux-pci@vger.kernel.org>,
	<helgaas@kernel.org>, <alex@shazbot.org>, <lukas@wunner.de>,
	<guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>
Message-ID: <698b9a6b2c175_2e57100de@dwillia2-mobl4.notmuch>
In-Reply-To: <aYuU9eI28ubuC9sD@kbusch-mbp>
References: <20260205212533.1512153-1-kbusch@meta.com>
 <20260205212533.1512153-3-kbusch@meta.com>
 <698b8e7894eb4_2e5710078@dwillia2-mobl4.notmuch>
 <aYuU9eI28ubuC9sD@kbusch-mbp>
Subject: Re: [PATCHv3 2/4] pci: allow all bus devices to use the same slot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::49) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3e23cc-a504-48f8-2805-08de68e63ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OS9VWWUwRzUrQ3VpcGhOUGRIQkxZTmJoWEY1ZHhMaGVqWm1sNExsVlRZT2NE?=
 =?utf-8?B?YjhBK2NiWkhSUDdqd3FYU2ZMNFhmQzlvR0tvQjZUZnlBZmlmaUVZTllLZkht?=
 =?utf-8?B?UVFzZC9FN0xCZTlLNlNhaFpDNFJ5d3QxMHRVVWZtMXMzc2UvOHF5dGRjTHdn?=
 =?utf-8?B?MnBWa1QzVXNQYWt4Qm1xdm02aUlUTXJsd2pRdmpReHFEcVZvUFNJbmR5d05v?=
 =?utf-8?B?cy9jZ1BUNEw2VDhGVVB0eVBPa3JMdkNSZ1VXYkI5Tk9UTzlyZk96RmxLS0N2?=
 =?utf-8?B?b29ITWZKbXQwRVdJR2ZySXUyTGNTUmtTdGM3T2NKRGRYb29QelFaQTBJMW05?=
 =?utf-8?B?T1ppVmtHV3h0ZGlRTnBIT1NTcXZ0bHRVdXhVTk55SHpEbHdicUw5TWZ5SURU?=
 =?utf-8?B?MWErc3M1Yk9CK3ZEQmJzak1kaEtld0IwZXVuTGV6dk40anEyd25BbUdrVTFX?=
 =?utf-8?B?dEMwckJ6QXN5OXQ0bGlIalZGNEJscytMbVNmejRUVVljZ3NOcEVQVXg0VjVM?=
 =?utf-8?B?RjJ0UDB6MXVvRVkvSWpwdE1pZ0dpKzZJb2thN3hoeGk1dUpZQWxhT1hHc1Jr?=
 =?utf-8?B?RUozVmthM0NXeFYxUU4wellUYmhEdDQyWmY5OGZ0N3I4S0hkc0Qva2RNNjk4?=
 =?utf-8?B?MG94SDFUNXAwcTlIVWlGL2d6U2hkdk0wSVhoaXIrMGNZVzMxcWcwWithNEJO?=
 =?utf-8?B?N3loQ1pjUlhCZENVaUdOZWprMXRXZEVWRXJtMTA4Y3BBWFVndTA3U0JuUFdN?=
 =?utf-8?B?NlMxL3o3b0RsWkFySzhINVUzcWxNSnNxblllL25pSlhsRVJhYlJuNTM3YUs1?=
 =?utf-8?B?WUpwd0xYZEhJaG5KRlkwVklSWkczRElzS2tYekt4WWtxNlNvNDhkVFhuaHJS?=
 =?utf-8?B?OEI0dTZ2VXdxMHdJZXdTTXRMdGpxMnk1TElnTkNMaVNDVkhucHIzR0lSaER0?=
 =?utf-8?B?TmZRM1NXSmt2dmpLK1BMMVFlTE9sOGNHUzhTNjh4RnJjMU11WlhCZnJjQVI2?=
 =?utf-8?B?ek9BTVBLSk94MTdjVGtZWnBwUWFJNW9Ibk5sVXlkRktvckxrWjZMTENZNVhH?=
 =?utf-8?B?UnZicEZRUnhKdE9KRVJVRWRQN3JCOG9wZTFESVg1UXo4Q3NReUNrc3pLemMw?=
 =?utf-8?B?TWxJVmJLRXlqSEtOR3pEdUtmMFdyRTFMNXFzdTE5UUZkeDlYMU9jZjFsd3J6?=
 =?utf-8?B?aE1CaXJKT0NTSmJBMXM4KzRLa0s5NjhWTU43S0VwZmNjRVNFRDJ4dHF1cVJa?=
 =?utf-8?B?Y0p1c1pTSThoclpMalhnRlBIRnNlSGgwa2ozZmlWR2ZvZWpHcVEvaEMreWVK?=
 =?utf-8?B?Z0ZQTngxcjZqZmhrMUR2UGQzZ3RvZXdvc2VZWTVsN3pwN3I1S29pMFZmZ0ZP?=
 =?utf-8?B?YitWSWVXRWJGRzNtakEyazlJT1cvWFBTUVY1VG8xVmt1ZWJSTDY4THNZWUJR?=
 =?utf-8?B?WVpQdHdQcWtsbXl0MS9odk8rdFZMOVoyd1U1OGhmbmJaa3lPM25BblRMV2xN?=
 =?utf-8?B?bHhkd0Y4bXVPZGY1SmRTSEJ1dTRBQ1lxcTdXMGg4VGxnZDBoNlRCd1VUT2Zq?=
 =?utf-8?B?SFZzR3QxR2NsTU5hdW1QWnBJRGkyQTlqRFZRMVE0OFRFS3EwM2pEd2VnS1pW?=
 =?utf-8?B?VllpRWt3dG52ZXcrTnN3QzdaREwxV2NOTHZ1eGo1MUpQVFZMRkJnb2l4RGlp?=
 =?utf-8?B?MVg3S1FBY3dHQzJJWjdObTMvZStpTFM2alJvNjJRbnJxdFFGY3YrQTRhZEtV?=
 =?utf-8?B?cEV4Smc3UStuVzRVc25RRXJCb2NKb0hHQi9PdDJGcnAxYWFTb05BcDMzU0Fh?=
 =?utf-8?B?cHBiTDBDRkxZMDJZVEpwbTJEWjFoOFc1MzlHSWZIbFFPZ1haeGllcUV1eThC?=
 =?utf-8?B?QTZFc0lvSDNzMnI5ckxDOGUyS2hCK3V4UlhDY21UOGw0U3M4L0FPZWxSYlly?=
 =?utf-8?B?M1N4bUJ1RkZDNnpWLzdETkNqSGNPUE5jNWcxc0M5NVJ4b0NXbnFHcnFobkgv?=
 =?utf-8?B?RmhkZUZqQmp6Mk4yT0paZnBWYXJXMUdDU2ZkNlgwRUJ6YS9Da2FHazFkWkt6?=
 =?utf-8?B?N0k2TzlEK05ZdUk2MGJtS2d4V3NxeGs0RG5XdndxOE8yQ1IrdFY2RHJOQXcv?=
 =?utf-8?Q?NGS8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1FzTHZBb3F4cFozRnIrYXVQRGZQM0YwZC84ZjNVaGxtWkFWSVZhVUVLTFJP?=
 =?utf-8?B?WUtyZDV6eG4xeEhVVEZBd1NDVGZpeXRYMllUeS9XOGkrb2t5ZlZnbGtZT2l1?=
 =?utf-8?B?ZnM2QUZvQjUveFpRQkVLbE56a1RCdDhPTDREQU1ob3hwa0tpRzhYdllIRVNi?=
 =?utf-8?B?MGJEL0FVdXRiSVc5eVhhRlRnazJjcUdkeVJJdlRPYk1hamhaSFNkdmlUV3FV?=
 =?utf-8?B?bVJEUHhFTUFQalVHUXpjZzNPZlV6L3RFR0JINlJjeG5jYk9ERGg2NEVacFhW?=
 =?utf-8?B?Ly90TUpVVlQ0VmxpK08zN1FpcW0xVkthTm81bXRtVForU1VOeXN1WVk3VWs5?=
 =?utf-8?B?UWVzWVR3VkRSQTg0U3o2ajJhNk05T0djbWgzSHc2YUlEd0VOZTIvcHZzWVRM?=
 =?utf-8?B?dGpHV3hHRW96NDE3dTVUWGdmcHJxY2N6U1R6U1JPWDNWUmRhRXFGQmdFRDd6?=
 =?utf-8?B?RVZyTmdYcDVLbWlXUElwMWpvUStjelR3SUpEcUhsL2RNZ1MzcVZ4STlLdS94?=
 =?utf-8?B?UlAwbGl3cFZWV2ZKenppNWtreUpTc3o2em1NMnZjZ2dCMGhRMnlxenlUOW5Q?=
 =?utf-8?B?VE0veHJPTzd0cFFuZlNqZmtIZnlFdnhQMVU2OXphVzJqZW0xMDQ1OWRTci81?=
 =?utf-8?B?V1hFUFhFU0hjT3pyNFA5UGJWK09Od1JETmw0OUQ5NThydDZ0MUpqN0RaOFor?=
 =?utf-8?B?RHY5THNXNWt2Wm04S25RNTJHRHRndEtCYlQwMUxqTjBiZGJ0QjRxejVDSU5O?=
 =?utf-8?B?M2NORUxWajh5MmQxZmJtTStUMjVHUEdjNFNSdHZKVnJIYlVDK0w4eERSTkI4?=
 =?utf-8?B?eW12Qzh2Nk5ubFNjS0twOERrNmlJL0FwTk1OYWUyQkVtcjlmZ01MMDloOGNI?=
 =?utf-8?B?aTdXWlcyWWNmdU5LendzTWxQdHBmR3FVZGxhc2NLUG9mRHl6RmlBZmdhaU1N?=
 =?utf-8?B?L3NDTDlYeDFZRVlqR1dnU1ZVemM4d05IVUwrblg5NEJhNkh6N2xSbzFBMDZZ?=
 =?utf-8?B?ck5CRWRmSHVmVW91UjgycTBrbE96WEhGb3BKcUpzc2JZbE1NMEljZ1k3Z1kv?=
 =?utf-8?B?WHFIb2s5Qkg4THpyUVE1V1haTWRvL0lyL3JEVUxjVngvejFUMjh6cXROaDMr?=
 =?utf-8?B?eE5CVCtuK1JTd2MxaUZER0RMTGJOOExTQnZrZEVmRW9OMGFQMlNFRktlZ1oz?=
 =?utf-8?B?SVI3dFJJOHowK3VSSFZJQnhkZUwvWnZMbGU3Qm9wTU1iZXJNMGc1ekp3K2hV?=
 =?utf-8?B?eTVyQVlLMzg1d0k2QlVVRDdIelBaZEx5bVJ4M0FJSnl6cEJ5Qmd0bzV5aTZy?=
 =?utf-8?B?Vk02ZGhxeUdpVlpLYWl2WEVUNWNFVmRsanhUWlRmQkxraEJud1VHMTBXaHBE?=
 =?utf-8?B?aVMrcTVQcUY4R29BcVFseWNFTndqUWV4YXZ5MDlYZmFOSlVNNmVzYXlkQnQw?=
 =?utf-8?B?dXEzc2IzQTBrNmsrWWhEWEhDL2N0ZWxXdENER2g4WVRzUmU3MXlQekszQ3FV?=
 =?utf-8?B?MjZITmh5L2FNOExiUWhIUjhmaG9SdVkxbStPVlIwVUV6alRPNlZ0WFRxUTNR?=
 =?utf-8?B?eVEyaTIySTJrQWF4cWVGZ0YzdTE5MldVUVJBcEx4aUxnRWZCWXJ3dU1RN0Vi?=
 =?utf-8?B?dnNlSnYwSms3blRIam1rV2tOeHg4azRJZXk1cGczVUtSS3RqUnNpWVBUdDJ1?=
 =?utf-8?B?bEYxUkZGejNOR0FxamsyeXUwVGF6TmM2SVJFZXBkS09CL1p2Q3psMlhtd1g0?=
 =?utf-8?B?TjFNcUI3dzFkR1ltR0xPdHppMVZaRFhtY0pTckV3cnk3Tmx2NTR5dzlONnVt?=
 =?utf-8?B?bCtmM2lLWGJIL0dlMkhTWVRUczJnL1JxR0c1cU8rRFZjTG40b01ET2ZaWU9S?=
 =?utf-8?B?T3JLTUJHUVk5ck5BTTdnVnFMZU1UaERKZ1BMTTVZN1F0U2NXNDZYelB0bDVn?=
 =?utf-8?B?M0NMc0g2c1R4MGZoS2lOUDBUUHNENG52TmQ5QnZudVNGbC9KNXhVc1NvZXhE?=
 =?utf-8?B?OVl0bTRsUlI5TlJaRDZRdGNxdGIyQlJaN3BNa0JPUEYvVHVSMXZzY09xVTIy?=
 =?utf-8?B?Y21EdWtNdEVnY2crY29yM0xJQnJRNk15clg1cTRyTGlOcy9rMzFIbktrMlVk?=
 =?utf-8?B?YUcvK3Y5bk95anYwTjFOVWdUTStXQkJyQlhqbVpLWk5LT0dzeWVveG5jSU0z?=
 =?utf-8?B?ZXBiMXJhbFY0Y214RkNQOUJBQnE5eVV3ZkVEZ3hJd1Z2NlpqRjc2ckY2b0Ru?=
 =?utf-8?B?TWlnU3J6aHpBeUNDUDhoK3JpaVVlMU8ydGlLTzZzcEdEWUtQUnkyRXZtZ2xL?=
 =?utf-8?B?L1lJV2lEajNKNzBGZE9UQ2NCUFNyb1VMU1k2YXFsRzk2UUdRUlB5cFAyR3Fq?=
 =?utf-8?Q?85fjzIJ7WX2R8N5Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3e23cc-a504-48f8-2805-08de68e63ae0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 20:51:57.3998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ff9e4HahtNkPGBwcQwD539ujGj9c0wPH+mhYm1fZdfjJdx5dhLALK4VtEP6zGz4HQq1wMr6pg+E3l6UuOtrdBUjAqxGVI6W7hOfravRDnNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8069
X-OriginatorOrg: intel.com

Keith Busch wrote:
> On Tue, Feb 10, 2026 at 12:00:56PM -0800, dan.j.williams@intel.com wrote:
> > Keith Busch wrote:
> > 
> > > this new feature is 0xfe. This will not clash with any actual slot
> > > number since they are limited to 5 bits.
> > 
> > Can you say a bit more about why other hotplug controller drivers can
> > continue to get away with a single device number as a hotplug slot
> > target?  For example, would you expect that the ACPI hotplug driver is
> > broken if an ARI device is added?
> 
> Right, I don't think acpiphp would work correctly for such a device. I
> didn't change that out an abundance of caution to not introduce
> regressions to platforms I can't readily test.
> 
> I've limited this patch to pciehp since that's the only hotplug driver
> that hard-codes the "devnr" value to 0, and ensures there's only one
> pciehp "hotplug_slot" per bridge. pciehp is uniquely clear that this
> patch is safe.
>
> The remaining hotplug_slot users derive devnr and can make additional
> hotplug_slots for each device on the bus, so I can't tell if it is safe
> to make the others subscribe to this proposed behavior.

Ok, I figured as much, maybe just put these notes in the changelog.

> > It looks like the goal of this sentinel is to turn all
> > pci_try_reset_slot() into pci_try_reset_bus() only for the native PCIe
> > hotplug controller, or did I miss a detail?
> 
> Yes, pretty much that. Since every device on the subordinate bus belongs
> to the same pciehp slot now, we'll get the same locking, notification,
> and state restore as what pci_try_reset_bus() does.
>  
> > > @@ -41,6 +41,10 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
> > >  		return sysfs_emit(buf, "%04x:%02x\n",
> > >  				  pci_domain_nr(slot->bus),
> > >  				  slot->bus->number);
> > > +	if (slot->number == PCI_SLOT_ALL_DEVICES)
> > > +		return sysfs_emit(buf, "%04x:%02x:00\n",
> > > +				  pci_domain_nr(slot->bus),
> > > +				  slot->bus->number);
> > 
> > Why not treat the PCI_SLOT_ALL_DEVICES case the same as the 0xff case?
> 
> Just preserving backward compatibility with what this file would show
> for pciehp slots prior to this patch.

Makes sense, perhaps a comment:

/*
 * Preserve legacy ABI expectations that hotplug drivers that manage
 * multiple devices per slot emit 0 for the device number.
 */

...just to remember that this is due to caution.

With that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
