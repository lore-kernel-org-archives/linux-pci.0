Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA0134C124;
	Wed,  4 Feb 2026 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770179164; cv=fail; b=Plpy2vA3IinC9gzfOrVOhVQixcVmRZAlMN6htOsXljuc0Hv3uXLDBuCe7aYOicpRD8ItxNQdysHDl4qgJSl9d/g/ci8J0+OQ6d3fEtu9Vo3cO9yJ3N9DbmN75NgCVpzRZvmAnvncZyA6Bw+zp9y2Ud4pUBjiR5EUp5IuvFrxK/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770179164; c=relaxed/simple;
	bh=CF8eAjKcSegkEdJbUvoo8XmpdtTuwKpUJ38G9opvbA4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=sjnUA+YBgX9WoRrCAfbtGtc6hLkupKRHumz/H2I9qJ5xNNxYGzso7CqFygg3JWM1Dl1Yjb41vwe46PFPPtyJDfOw8AjAsbHz/bNP/kIE2u26wD1+XYOX+2VBznV4CO2R9cqOB/b+VTq5yBKRAVOfPpQonPKW4ej7Z1yHeRaIsiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMX9gISx; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMX9gISx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770179163; x=1801715163;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=CF8eAjKcSegkEdJbUvoo8XmpdtTuwKpUJ38G9opvbA4=;
  b=GMX9gISx5LhuyvOp5Wjgg0D4GZXrhupBwiQB6VAP8WhT4bIsMD6vmXfa
   3fkzM+r1RhDgRNGSe2Q4soStyk/K909Twm64jZ67Y33VGwB++sdBBvzds
   turjZ/spCnZERfs023lFA67JCh8FH9ra95cdnEEbyPhNP95pHvWDTGVAl
   JlPiAKBBZBvtEWo8CfFLed1RIeRGNPQI6t4xkUoysVuLJK+53kgWyeLQT
   /J9qxVQLJgDKdv6ms7mf1lyK02YQS94hN4Iyk6Okwd8eJ5tCvg/pRaBpI
   keEAydypyMAIbLdiT99bCUwON1dHvxkhhpwX6KAmJt6NWjp97NAWf1J1o
   g==;
X-CSE-ConnectionGUID: zV0ojsK3RsSfb136BSyKJA==
X-CSE-MsgGUID: F30yH90ARSCZ7c2sRRmgMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71522557"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71522557"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 20:26:03 -0800
X-CSE-ConnectionGUID: Ix/RCas9TxyK/4wi45GboA==
X-CSE-MsgGUID: O1iLGFGsSoWCaAvh5aXtbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="210134240"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 20:26:01 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 20:26:01 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 20:26:01 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 20:26:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H38IAHMn7bUihEl+g2pizPnfsD39b4cZnWqMnDj8k4t3PYq+oflwD/gClkxCcDKxVaRfheEeGW7NdGc9jqDGNK80j36d1BVDsWXPIK8GjFp6gibGfgWjIwdNLMuQbC6NWl1lYMudOXDzFShwSrSujSCX4swFWVHyRPzPsUv08ltx5sb+DKydn+r1FO93TjEsGvf9MNL9re64M/kVGkZJA/2QHasL4tzBPMmxg9kAKHEvG8rYYSe/ZyrNjBsGFTlyaiL0shvKD2IA1EBjswzSDA2ayjtoL2mtRcDGtR6coERgbBQIr6DbRBNv0d5wfY7w2BDfyCHTlbYaViFF4Ij1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joiZLxtrO9amyBec1NBg70FR7MJIuSpTzQqZd773b30=;
 b=dWdWWT1vAPterJQ7As77qII8pgMd3e3k5ETdxpFzsR/2l5jzA6WNEXJmoJcEANsCjrzdlVE83s0CVqIGKrq2si9yh1DJPEBxd7oWZM5NSR46FEZ3kTzDyhhQhbAdXgnEx+Dczp7YtCYmxVmf1k9VTBGkBmUc/M+vz/9m0iQc4ZHcAld12ehVmSdh8103a/0TT6xQqOP8fHKCXIonChPbjl0QgmdtM82culLkzdXJTF1D4hJDlIBU6QkpP6qYY4/yt4DHW2lJpuAhThQTJfFuRC9Tw7kAxTlvo+hOOaBAO0eDmoOYKSbOOQdXRVvUw2sf0LPuHK5iwX03lWwq4JYhRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7651.namprd11.prod.outlook.com (2603:10b6:8:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 04:25:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Wed, 4 Feb 2026
 04:25:58 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 3 Feb 2026 20:25:56 -0800
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <6982ca54e094b_55fa1005@dwillia2-mobl4.notmuch>
In-Reply-To: <20260203025244.3093805-2-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
 <20260203025244.3093805-2-terry.bowman@amd.com>
Subject: Re: [PATCH v15 1/9] PCI/AER: Introduce AER-CXL Kfifo in new file,
 pcie/aer_cxl_vh.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 839fc654-5344-47d2-1fed-08de63a57eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWFra1d0c2JmUUhIRjlNaUlyeEwrdEhzUmhWM1FoeG9uUWZlazNYM1hvd3I2?=
 =?utf-8?B?eGZFMUNIVmIzZUJSZXVvdXhGNzlnMDQrNW94L3cwOExOYWE4VzJDYW95RHZ4?=
 =?utf-8?B?NHhzZUlXVlJiQkpHU0JrMVRGMWh4Z1IxbDlrYWNkbTZ5L3E3UWZvZXZFdVFt?=
 =?utf-8?B?YlFzbFR2UXNBSTZWZHpFcnFqRUUwNnFuUFpkU1ZlRVVVcXZHcU83ejB0eS9P?=
 =?utf-8?B?MWo2V3hQdWw1M1dCS2Z5dVpKWEJBbkpNNGVLVW9JMkhISVJLTVowOFUrWCtQ?=
 =?utf-8?B?d0paMzhSVStoTjFPY2FTTDRkQ1JUd2ZFUldTZ2FOWDdPWmRxMXgvWWVKY3N3?=
 =?utf-8?B?RTEycUNqL2lPT3hiMWl3MmlyUGhJWmswUTkvNXBHbGo1cHNnOUhVYWhyOG1H?=
 =?utf-8?B?dU5iZG5JUkdpanYyMnNMeW1jdmRpbTA5Z2c3dFhFNW9UUE9KenhnMjIxL0VQ?=
 =?utf-8?B?SndqTnpCTVdFSUVxT01pQllURlJCNFl6NUlKdVJRVHVQdElESEtMcnh0NldJ?=
 =?utf-8?B?ZGZuMjBEUDhnRCtDNVoreTRpY2p0S1VCbVRTTVdXTEVXS0g1aFhVYW1GN3Zr?=
 =?utf-8?B?UVFDTHVMTFVaam9NQ0kyV1pJT2JmY25YbHlNeXRydnJDQXNqYWxNSVVVYTd0?=
 =?utf-8?B?TTN5Y3lram10UituRjUwUnJkL0pQOTc0c1JDei9pdVVXdU5GUG9vUzZ3MXMr?=
 =?utf-8?B?NDZYL2xnVEs4SkZDNzY3MzVrVVRqMEpObjJpYnhGckVNMTdQSURVOWZqZFRM?=
 =?utf-8?B?cFRZbWtka2FxU0pRTlZsd0NFSGZOSG41dm9NRFF4RSt1bDMzZ2xQN2s3eTFm?=
 =?utf-8?B?MUErUm9hZG1NVjNCbkVNTDJ2b3NVcXJEaWpVOVFuNHlhWWJPM0lCcWF1ZTFx?=
 =?utf-8?B?STNITUorL3NPWmMrRXRzM1Q4c0ZoOStSdW8xdU1VU2Z4bmVxZVYxOE9mdzRm?=
 =?utf-8?B?bnU3YURoV0F2cERGbUNObFdPczNkYklzWU1xRllpRUdxZjl6cDlXSmxoTFoy?=
 =?utf-8?B?WHgwdVg1azA1aHlhVGF5Y0tzUWZMQm1NL2VGNmZaZG42RnUvRG5iN05uaExE?=
 =?utf-8?B?ZVlpZXRSb2dYcVBnUGMxaTN6aDZkenVsU2VxU0s5cWNLUUtkOXM3dWJieERw?=
 =?utf-8?B?ZktPRVBxTncwRWhmYzlCT2trMVZDVFJrRE9zdlNNRXFSWUVLOGs0R21OR3F5?=
 =?utf-8?B?Q2lLZkM1VitLRlRnTXh3b0YzKzFsZXh2Y1N0V2FjUjcvdFFsMGpiY2o2THAx?=
 =?utf-8?B?YTQwU09kVzdPaTZSTFM1eXEwTGpGQXBENm4yZzh3bS9NT3ZOYUp6ZWxqMEZl?=
 =?utf-8?B?VlU2bHNGUDY5QmlMVlJzU2ZRd2F0dGl4c3RZL1hDVTdoQ3dYWnVkbkZ6Ulpt?=
 =?utf-8?B?dS9CcDE0VURWU21xQTlkNkdtWG9NSTZIdTZHMkJSYTRaemZaTm9DYjIxNnBS?=
 =?utf-8?B?MTRNTmdCbDNEN0orcTJjdnRJQ1dRZkFHekpoK1JLZW93aXNTOUcyTkhJVlpT?=
 =?utf-8?B?UXhiclNTWWZuVUlsWFI1QVBPTlc4YURYS0dHSHFXWWZtQXBQLzJuTnpqYUd3?=
 =?utf-8?B?bWxaSWluM1A5TE04K2ZEMUlMNTZIdUFCb3FsY3hONkhXZEQwSWNkbmM2VWZs?=
 =?utf-8?B?eW9PVkMxTDg5bmJhZGtDZ1VYOFhubVlVVUIvQk00WmJmakQ0b1JZOUFzeXlL?=
 =?utf-8?B?cVJoWTN5aCtYdHU3ajR3VmR4MzZuYm0zM3JKZ3dla2MrYWNmekZlT3FpWGs0?=
 =?utf-8?B?RE9xck82b0VxZE1FSngyYjdHcjZKY0RyaVBsQS8zMi83aWRjak4yeXRUMTNQ?=
 =?utf-8?B?QTVDYTM0Vlh4aW0yVGJudVlSVFNqSUJzdXpJOUlRd3NFOTlMMEdONUJWblNH?=
 =?utf-8?B?RFNyeXNmanIyeERGYnFnSnhUakpXODZJL3hBZm1ZUzI0cDc0UVp6YXJZbHdT?=
 =?utf-8?B?T0VtT3daRFlWT1ozNXJNZnZEdzg2a1JvQ2dKM2lBY3BmOW9zTnVzU2YzaHVm?=
 =?utf-8?B?d0NlOFpuQ1o5MkxneW1kQXZwY0hvcHA3djZJbEFNQzc0ZEJ5QWxqanRodGpo?=
 =?utf-8?B?d3ZZYmtzQjUvb3c4clVZTm1IcDJBcDJNSHkyNEpRelVyQjBKaExEZGFtay9l?=
 =?utf-8?B?M3A2cUxudjlDUFRoMTlwWlNjSG1CVHRTclE1ck1CSHl6RDV4czZ2bElSUVNW?=
 =?utf-8?B?UXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU4wa21hOThGelQwV0EvOFdReVB3MXhrM25KbzkxVHgwV0NXTmc3OTZ3Z0M1?=
 =?utf-8?B?d0RxYTBVUWNzYWU0Wm1vMEZmMnFDaGtaUTYvd0FNZmhvcElhODkxUHFrQVdo?=
 =?utf-8?B?RVdhNnUzTk9SM3JyUHZRQnJsenR3QlFxMnpoWE1VejYwOStiUHRIcVFmM0xx?=
 =?utf-8?B?K0NOM1pDczlBb2h0VHpKekdBdWRzVmZ1d0x2SWd2bFFSeVpZNVNVa1Vwa3U0?=
 =?utf-8?B?ekRYQ1FwN0JhbXVnNEpsdEd6ZjYrQVBTYjRkWldweGNpSDRXRGxGRzUyZEhF?=
 =?utf-8?B?SS9wVzljcS9lYVQzdGdYcUZxNmI4MEFRY1B4Q1huakh6UnFCSktDVmJkVWor?=
 =?utf-8?B?ZVZLYkhRdHYvZHlOUFNXZHhNK2lkZWhocFVlMHZoK2I5VGhtTFZJQm9BbHdn?=
 =?utf-8?B?RjlPSy9GQjh4Z2k4R2VHdURtZEJ4M1pXWmsrb1pkd0ZTTkROcVdTcm5SOU1N?=
 =?utf-8?B?Um5oSVN4b2x1RWordkpIQkozZjJLbGpvelhvNjVENkk0TXo3UUJwWDM4MTBX?=
 =?utf-8?B?SjhnRVYxdUtwbHRud1VnMkpiYW45cW91RmlCMHNIOEQvLzhreWtVM3lUVHRv?=
 =?utf-8?B?M3Z3dDh4d0Z3a3dNbGJoNURVcW94d1NlWWJGZTF3R2YwREZ3VWpibVc3dFhi?=
 =?utf-8?B?LzZDT1ladFh1OFl6OWY1SjN0TmZWQ2xzaVJtcUsraTNPeTdudFpyQ1RwYmN3?=
 =?utf-8?B?TUdoaXhkZ1phTmwzMm91YUJDSkcyYzNhVFdNeitjYlF5Wjc5ektpU1RsOTBz?=
 =?utf-8?B?Y1Q5MU1hMmZPSVA0U0wrQXR4bExxc3d5dGlPUkh0K0dsYkE5N0U5cVUzYko0?=
 =?utf-8?B?UURKOEhuQnFxeXB5UUFsOEFoSFlRSUd4TXEyeTNlQnJIaHBuc1pzY0ZFTEZZ?=
 =?utf-8?B?VEdvTUlYdzlMV1JuS2w4N3p0VHkxWmExNlE5UC9VU0ZvbWtXc2JtWXVUQWI3?=
 =?utf-8?B?QS9uYWVKdDZEMlU0ZXN1R2lIc3ZDNmlCKzc3UG1HeVdldHd6dlpyMFNZT0E3?=
 =?utf-8?B?VzhVcVFlSDM1bTg3UzZjOURvYTk0b25pWUdNMTRDREl4blpJcTBnTEUwMXY1?=
 =?utf-8?B?b3A4NklzS3cwV1RmL3JQaHhMZXJUcXJoWDhqSC91aUl0YnBZa1p6SUJxNDFQ?=
 =?utf-8?B?eVZLRFpEQmdOWUZHQ1ByZlg2cWxhQlovbnFkZmRmWU56Z0tUUWNOaTdOTlI5?=
 =?utf-8?B?WldXTDdsVjl6WTJOK1NxUStvbkdFNjMydFNLQlMzVHRVRmJtaVlIOUdLZUpi?=
 =?utf-8?B?eVNIYzJoOU5XR1dkZnBoK3M3K3NBSVdFamxKQmNMK0dOUjhFd29PMkVJWldo?=
 =?utf-8?B?Z3F5RWUrczA5WGRxTTcvZVlqRE1yVDk5M3o5Z2RZbUdVazF2TklzcGk2MllP?=
 =?utf-8?B?VGJ3dTFoWjgybkVwOXJKbHRJZUwvOWh1dDVOd3Jlc1dIWHRVUi9OVEFJTTll?=
 =?utf-8?B?RVltaGxaTEVoSEdVUWJMVlpsaUQ0cWhuTkVWNzI4ZlBPN0R1dEQ4VWg0bHM2?=
 =?utf-8?B?dStPODJXT1Y3N2FoOXN0R29tZlhqTGxPQ1BnS0U1Qi9QL3hUUThCWjZWVFN1?=
 =?utf-8?B?UXdGNnhVeDM5YnhYOGEvTC9WVWY1RUJYRCtDenZaRWNwVHNNUDZKeXE4UUVH?=
 =?utf-8?B?YWVQb0FFSXlFV3lNZzVCZ09uTVllZENENUg0bWtqMVZFQkhaSmtOc0NJMitt?=
 =?utf-8?B?ZzhUQWlUZlJXcUNDR1hGSWpKOFU3RXhEeEFpWUdleXU2eXY0U1RqQ1N2b2Mx?=
 =?utf-8?B?YTZCWlZkREgrSkx6ZlpKZC9RSHdPV21yWUE1dzhmQ3dFek5TVXJnSWJPTkU4?=
 =?utf-8?B?SUtuVDc0VUJMQVVqcUIyaUFvUjdMbk5mcUtWZ2VYTjFndEtsNHVCZUtwRGF3?=
 =?utf-8?B?NXJ0VWFzQnhpWkxPWm90SWlrbXZZblFwWDltbk1uZklpMGpsajkxSzZuUDds?=
 =?utf-8?B?bVA2NTllUmpsbGhNRC82d2UxRThtRy82QzNsSVZsS0ZGWHR4Zm9aMWhWQ2tY?=
 =?utf-8?B?YmMwVVMxbkZIMElDcVpIYUNXbGd4QnBIWE8wZmVrc3lhTnpsQ0xCUFRjQXdH?=
 =?utf-8?B?QWVvK0UyMUYveEtLZUhUa2VSbmJwdktaMWZZdXcvQjFZT0l2M1JUKzVlLyt5?=
 =?utf-8?B?ZW9XK3NjVnJtM0J3QzNQa3ZqSC9sMklrRWY2aGt0bDhjUGp5bWdkNWR1cEpY?=
 =?utf-8?B?dy9rekh5d1RGNGZWVitXaGo3ZGNWendrR0EvNWlXS01SVTg0M0wvdGtVR05o?=
 =?utf-8?B?eTk0cTRVQkFsbEVmOEpLYVljUlJ2ckx6dXhqd0ZlUTNaR1dqS1BFNllIUVIw?=
 =?utf-8?B?M01yTjZhS0dNYVJWYUdGVlIwa3k1eGJHV2d2YjQyMDR0enZ1Um5YR0tGeXY0?=
 =?utf-8?Q?w+dZa57k9lC1af1c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 839fc654-5344-47d2-1fed-08de63a57eda
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:25:58.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIVmAE981erDWdXgQ7vm3yGtJqrK0oAU0Crryha+uTnBV71FrSHG6+9C0gKRT3Fr7lTJtCdshywazNX1u8CQvdnNzk4mqGFgqhQtyS40adE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7651
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL virtual hierarchy (VH) RAS handling for CXL Port devices will be added
> soon. This requires a notification mechanism for the AER driver to share
> the AER interrupt with the CXL driver. The notification will be used as an
> indication for the CXL drivers to handle and log the CXL RAS errors.
> 
> Note, 'CXL protocol error' terminology will refer to CXL VH and not
> CXL RCH errors unless specifically noted going forward.
> 
> Introduce a new file in the AER driver to handle the CXL protocol errors
> named pci/pcie/aer_cxl_vh.c.
> 
> Add a kfifo work queue to be used by the AER and CXL drivers. The AER
> driver will be the sole kfifo producer adding work and the cxl_core will be
> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> Encapsulate the kfifo, RW semaphore, and work pointer in a single structure.
> 
> Add CXL work queue handler registration functions in the AER driver. Export
> the functions allowing CXL driver to access. Implement registration
> functions for the CXL driver to assign or clear the work handler function.
> Synchronize accesses using the RW semaphore.
> 
> Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work data.
> This will contain a reference to the PCI error source device and the error
> severity. This will be used when the work is dequeued by the cxl_core driver.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
[..]
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> new file mode 100644
> index 000000000000..de8bca383159
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
> +
> +#include <linux/types.h>
> +#include <linux/bitfield.h>
> +#include <linux/kfifo.h>
> +#include <linux/aer.h>
> +#include "../pci.h"
> +#include "portdrv.h"
> +
> +#define CXL_ERROR_SOURCES_MAX          128
> +
> +struct cxl_proto_err_kfifo {
> +	struct work_struct *work;
> +	struct rw_semaphore rw_sema;
> +	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
> +		      CXL_ERROR_SOURCES_MAX);
> +};
> +
> +static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
> +	.rw_sema = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rw_sema)
> +};

Minor nit, I have never seen "rw_sema" as an identifier for an
rw_semaphore, would have expected "rwsem". Note I am only commenting on
this because there is something real to fix below.

> +
> +bool is_aer_internal_error(struct aer_err_info *info)
> +{
> +	if (info->severity == AER_CORRECTABLE)
> +		return info->status & PCI_ERR_COR_INTERNAL;
> +
> +	return info->status & PCI_ERR_UNC_INTN;
> +}
> +
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	if (!info || !info->is_cxl)
> +		return false;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return false;
> +
> +	return is_aer_internal_error(info);
> +}
> +
> +void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	struct cxl_proto_err_work_data wd = (struct cxl_proto_err_work_data) {
> +		.severity = info->severity,
> +		.pdev = pdev
> +	};
> +
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rw_sema);
> +	pci_dev_get(pdev);

If the work item is not registered, nothing will drop this reference.

I would add a comment that the reference is held as long as the pdev is
live in the kfifo.

> +	if (!cxl_proto_err_kfifo.work || !kfifo_put(&cxl_proto_err_kfifo.fifo, wd)) {

...while fixing the above, go ahead and wrap this at 80 columns.

> +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo error");

At this point we know the pdev did not go live in the kfifo so ref can be
dropped here.

> +		return;
> +	}
> +
> +	schedule_work(cxl_proto_err_kfifo.work);
> +}
> +
> +void cxl_register_proto_err_work(struct work_struct *work)
> +{
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
> +	cxl_proto_err_kfifo.work = work;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
> +
> +void cxl_unregister_proto_err_work(void)
> +{
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
> +	cxl_proto_err_kfifo.work = NULL;

I prefer the cancel_work_sync() inside this function rather than
cxl_ras_exit() so the semantic that no invocations spill outside of the
"unregister" barrier.

I realize cxl_cper_unregister_prot_err_work() originally made this a bit
messy so I am ok if a follow-on cleanup fixes up both.

Maybe Dave can fix the above issues up on applying?

With those addressed you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
