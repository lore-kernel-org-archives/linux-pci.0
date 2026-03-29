Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC927EFE9;
	Sun, 29 Mar 2026 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774816441; cv=fail; b=pu2NaXxCmNrdu/vQPk7TD0YnUuGMJmnsGOq4g8noeKw9VEdY+69pYGkDtQRNeSstc/KFzetKGde5jfcmk+yaMGW8vKHywA10XvDbnccti8zZVt1tzl94drD8KOkYbgSnvTNhOqm7Ke6HmapNH4VQN2+FrJlSSIvPCdqlAuVgZyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774816441; c=relaxed/simple;
	bh=xuuqDMhL9aEIUldvL2hGtU+1dx3yIVwU2e+jLAl3zko=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=k3uk7u/QnUh1tAEnJbHXsqDfjE+zGG02vFurH3uvNYwlK4ozMO+dEofD03QQY2eeHhzvl6ixKY8ilZ24hjMhIQRZP5dvxTRMfckLDdn+4mayd+3xCv+DDY3tyR7OXUHVzWb2p7pHWQghQQisuRMg1Z7ZPpQY2QYvJ+PLgsgdIPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3YM7W+a; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3YM7W+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774816439; x=1806352439;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=xuuqDMhL9aEIUldvL2hGtU+1dx3yIVwU2e+jLAl3zko=;
  b=J3YM7W+aEF6vOmM+6347iXVeqxs3k5BbM7BF2FfOQj8sWtKQqKm8ipRn
   jkjvwMl5kRcqfRBbsqxI8Vk+up2OL8slkw90k9R/gNUvVwLwLMVCDw18c
   3k6YW2SkyncGTNbTX8gCSVUgdE4YJgjIi8OOjYkk7yX4DpdjUKIlcsUOD
   vobgcYRzpUA4Jmdnhy78GMSg3S94gwWh+QxJDv7kLtqTwJlghPxIwNjn5
   sI4u0AHNckTQTnoKmKSq7KBXbssrguq7LiSquTU1uttMOBvmwXEa1jCYp
   Nd1lm8oLzhhbWjriT1MkURk0eMzzku/zRv2x91l6KGmCHXWzgusJcKUPm
   w==;
X-CSE-ConnectionGUID: /k0ZMHTVS4WjxA46jeXHlA==
X-CSE-MsgGUID: M1OubDqbQjiKgdOeHJ2izw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75783896"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="75783896"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 13:33:58 -0700
X-CSE-ConnectionGUID: iGlyzFvPQGe4JZjYMvwatw==
X-CSE-MsgGUID: BXXGJMWvQHCxCpOeoZguWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="219228388"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 13:33:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 13:33:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 13:33:57 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 13:33:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUjgjxkXzQcnROeI4eXxtKluAKakQaHvV421gWlmjuLaZH97uEJNnpjeueAULpRscYao/uvPudyWDK941/xeiQ0B7hWs/2Vbdvn52ERU8fi5Z1+pAMRIyDtcVZEVU/soJd0yTGChg/GWRtUveIULMkTxPteJS3Y1FZmrG4bjuEGPFtrjYtiCgrEFdKRCydwLwoFLcpBW4xylLUXdhxTWBdYnSVrF0oXlUPXCaB7Uw4Ic2E5xnPZrUgSlC/FEzgCaCAGZN3tDYqRzcS6VCTTRFUn0kAlFIgLUas1J80jPl2etRw+cH2ZayYwJ5MLFDpmz0mPPiIHwQOLiDpg1fVQcAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVUMXjzm9b72La2spfJs0hZ+gr+VOJ2g1cYfn4wmgF0=;
 b=ns2ZtMYncnBynNrsiSKGUjmlA91MFuAllZEKKTRa83Ag3TUSsUFixRBstsTvF1JH6kHLnA7+bucuW6gWoglIjWhUoPXk81i4EdNFS2AgEhznx/TEFKh5hXDV92wIDrM7rznlfu8IZymLYQv3Vrawa0asE0qvloRx0AwsMK3ne8twPVfbuyXii+rnXemC6yqwDtxSIJOLZPv1df12rT2QBZcxwBUWML8xRi66pzZgygbGiYb+3KLIr+gWP908tnzNWjzCmx/pNuSCNzO3lA5U/4S+wT0qKk7/aHzmyPnnl/XkjQrZjE+r3b47ziUrhrrT/5r1wlVWSWZkBlMp/cIRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6329.namprd11.prod.outlook.com (2603:10b6:510:1ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Sun, 29 Mar
 2026 20:33:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.006; Sun, 29 Mar 2026
 20:33:53 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 29 Mar 2026 13:33:50 -0700
To: Dan Williams <dan.j.williams@intel.com>, Terry Bowman
	<terry.bowman@amd.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <69c98caef1348_178904100e0@dwillia2-mobl4.notmuch>
In-Reply-To: <69c720adadcd4_1b0cc6100b4@dwillia2-mobl4.notmuch>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-2-terry.bowman@amd.com>
 <69c720adadcd4_1b0cc6100b4@dwillia2-mobl4.notmuch>
Subject: Re: [PATCH v16 01/10] PCI/AER: Introduce AER-CXL Kfifo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:303:16d::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf1da9b-7829-4f03-8a43-08de8dd27e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mbXFNhnoiNSVBU2F05tGmHPrAlvr8737a3UOv4cFzVbG1dODVbiXg1pgzJJapNtsX12sCOnDKJSGgsmpSNXlLTFScn+8sN0M21obiCBc2tALQ2M4KQsycoFtWhsf4JyFsnZrJtcnJ4DOKySXwOtbhqg9EX47LDEfZ3svqOrs0xeJWVBs+G+nBnF7UEtM7jpcsh+pDWrtFp2A+I4tDMTUqOnIN5HyZ/5t1kEZMQe6Af80eSdnsxAncGpQCx7y54MGDxZs8x/ftm41eO4OE4unULJd9DtJmhuex904ayc9XeZ0DdRv1UaFQ+w8WUR9f1rQPL2wopwVvxPUtGvgc0ELMOLf4wLpXhy6WovfVOZ8UfCLU0TZQfD2qasxTo1i8Aw3GWiEGgSuZWvn59AcVIKRSNDRn92NmzdjMuoY/InLJqFAzIdmUbgaxA4nalh3yqVic38QFY7Pipk6XxoG8kjd526anavM3cJt2wXjdqnPgqV7l+8g9kTowXdjGpEeTykoMHMojGoivlPXL2q7j1+sJ2ymRrOxk9f2lLBdWAZMr5/crNFdqVTdjCGZSlEjbChfuLQh4TEnEP4dVVhm17zbbGEQohGsr/18QVJiFec8Np1xVLMMTSSBI1Id2UU16h7JK2fgvQ/x420pyGteWHoKhDAGHCcf0k/sulkFKUrlxaSz/Z6cgNEgfH96x1aKP44pKHOLBI9by5niK5rCKv/QjtUHZ9Bm5Zsn+RiO/4ffk92ZLSQACK0Qw9DfxtIyUisUgVIy8X2XjTalEsopkZbKDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T21nNmhLWUdLSE9WOFJSdkdBNHZMbFhJWkE3RXVDSjg4YlAxMVRETWlPUnBj?=
 =?utf-8?B?cE1XUTZscHplVThkalhHZHFDS1EybDJkZ0E1RUFiaFpFTkFTRkZydHpKSkd4?=
 =?utf-8?B?MzlwSWxzNzl4TUw1RTJjaHhDUjBuQW1sbmkzZmhYdmljZzJBeVI0c0gzK3VC?=
 =?utf-8?B?MzJoWnJNK3h2cFgvVlM0cTdDZlZwTDVQUkViYVFGMDBIZHJsRTNHWVU2RUtr?=
 =?utf-8?B?Nzc2ejMwR2FRbVpEUWpHazZjZCtmUEpGRVJENzFxSENHSjdJMUJycythMUNl?=
 =?utf-8?B?aXYyb0lyV2twc1JUL1RZSnNmTll5VEsxOVY3WXRpRkowdXJxeXNQWUJlK0FY?=
 =?utf-8?B?TFJaQjV6OGdKSmZJU2doNlV6eUFjeDQ4RC9tVVE4clU5MjZwK1h1MHlGeWU1?=
 =?utf-8?B?dTdFOWN3UFJlWTVkMGRqWDk3SGswRlMxQlV6ZEZsSWZ0VXBjQnBRQUJrYkky?=
 =?utf-8?B?WTgvb0dLYWVSajBpaGJBQXhWR0liTFAyTDF1SXJBOFNid215a0l1ZjBoeUNl?=
 =?utf-8?B?VHZneHRSWThrN1BUNDhDbFNhL0t0c2Q5ZWpwRGgrZFJsVlB6YVJid1Y1ZVNu?=
 =?utf-8?B?bEVadnRBU29uL1BGS29YQndKb0ZjR3VEQ0wvRFF5dVBPcGRwU2I0bWcrYm8w?=
 =?utf-8?B?WmFXK3BkRnpBOVQyUXdNazE4Nm9RN2ZnVjBaRm56K2ZobFF6bTJjREw1emlr?=
 =?utf-8?B?MW00LzhGVXBHWDRGa1RidXJ0dVpPYkVhWUVyOTVFSGgzNjRPbndObC9iY2NT?=
 =?utf-8?B?dU40dTRRZ2JlcGlCL3dYSFV2S1p4Nyt5VUFXTUt6SHYzYjVIanpFd29iODRT?=
 =?utf-8?B?V0VJb3NYR3VUQ0ZGRk9td1huRjlxWFZXS0c3cGFndDRSR1JwRWhmUWRsRUtk?=
 =?utf-8?B?UTdOZzJIQkVJWkRLZldYOGVDREhEdFlGV0dhL00wbE9pQ1lvM3pQS3l6YmYy?=
 =?utf-8?B?anhkRHp5a0xkaEwvT0QxbWN6V1c1UncwMm1abUV6by9jSEM3Ni9MMFF6QTZR?=
 =?utf-8?B?Z1NpVlZneGlucW5KelpjZzhXaGYyMUhSK2x5emhqeFpPd0xJaGhBS0gvT3pW?=
 =?utf-8?B?eTVRZmVDd3V2MUs3L1dvaWR4NkljZitWc1ZPRmtINUdTZjZ6bmN3WUcwTlY4?=
 =?utf-8?B?a2xxZW1KSVBTdXZ5TEZiYnlOWGRkYm5mcVRCQkZOQ2piV0Y0Yk1LcmlYbVlD?=
 =?utf-8?B?SjczRlVGUCt6OU1FZWIzUEZ2aUw4a3ZmN3ljUmExWi9VZEFiT1RVZFZrMHZI?=
 =?utf-8?B?Y3BFNXFwSFVCZkJBVGQ4cEgxUDJtSm1PMENLSnVSaDIzajRwdEtJTzN0dWs5?=
 =?utf-8?B?bVZqSGRGMVkvSTFVZThPYVFXTElhdEZ6RHQxTUV1emZzbWxDKzdvcjI1cGtm?=
 =?utf-8?B?S0gzWENBMnRGNmJzcFM1a1o0dnpIOFh1aUJTeEE1OVBHUDJrRnRXS3JXUWpj?=
 =?utf-8?B?WUdXUG91bDRWcko0U0VsNmlZMklzZ090Ly9BTHNmTFhUS0o5REV5ZldGK2Jx?=
 =?utf-8?B?a3liQnJWK1JveGpqNE5xS2NnZFp0Y2FsUUVXM2ZQbWJSNWlYWGVLUG1aRTNl?=
 =?utf-8?B?dmlzR2N5V1NsSi9mN2t0L2FIeW1taGlBbXhZNTJZeWt1WEJGSW5ZTlBOMzl2?=
 =?utf-8?B?R2pZMWN1Ymdmbm4zRitqZGFOenpJc04xdkIzUlBySFJYZjlnTkI1cWFkQjFy?=
 =?utf-8?B?STFQVVVSU3dSOEVkZVMzQ2p2Sm1XV1E0YktNcCtPTmZWM3lWUDRzMnNRVk03?=
 =?utf-8?B?eFM1TjVCM0VobmhLVlZTSkFpaFFaTWVKYmQ5UTZTdDRYbXN1M1d4Qjc4YVMx?=
 =?utf-8?B?TmRoTWNRZWNDZ0pVajZmQmZwSVppekNUU1l0RkhqckwydUJwQXYrUk1BRmpO?=
 =?utf-8?B?TStkNEJpdG80dXJLM0p0UnZMK0RHdEI0U3BVdTF4VllWaEkzbkY5bGFWV1NB?=
 =?utf-8?B?cENTWjNxemUwemQ3dnNKcVUvQW9BYUlJU3F6UWhuWUI3bk85NnhKWW5aVVI3?=
 =?utf-8?B?MHRBNEJCMGg0NDhVV0R1MUlRVkRuY2J3YWFxbW5wTG5VemsyV2txZzR4WVpy?=
 =?utf-8?B?OXVuYzVPdHA2ckgwMW5FQmFmelRDVEJwSk5ib1BSa1VadVJ6NkN0dEl6bDV0?=
 =?utf-8?B?dnhBNFJRQUNOdCt1WXVqSXdyeFlDbE1nMGxkMktCdVppSHJMd1JKb0VhR3Jj?=
 =?utf-8?B?Q0YvM0lJOGFGMjAvTXJUQjQrd2JRMUZUY1YzMkp5a0NMOFJwSXlXaGNiWVNV?=
 =?utf-8?B?dUlzM1oyT1NCUTY2WFRVTTl2T1ZCbWNBNFZuMGZ6c2V4UitkbXhWMGZjQWxY?=
 =?utf-8?B?bGRoTXZiWDNFem1aMHVpRzJjSjkxRzZhb0pzWE1DaFlDUHlDeGRiSElGeUI0?=
 =?utf-8?Q?Ix80817JcUqIFUDQ=3D?=
X-Exchange-RoutingPolicyChecked: qYI0fFbagPvd8yAc3aBOydsnbTHhClV/+ue4yuZCMactBYdgKvcm3jXqL+a63Jbsp5bqt0baEyIJmtHr3VANBMy0wUEJQSWhfEn3GhTr3SlhYydETkWRMMJkEsOiupX/FFc73EDbb4rpTbNHeeIlCpTonRkHzcZhdolFZlSlcdwu8zl+drvIlsxwapYgKjzm9pZmgonh5qy8HI/yAsG6Y+m2tQ4Px7+zOXpw2oIBl73C8ti04PTTscbMHxt7wrJmgro8sKFADHjIId1L2HptYdat12Ic4DjF6HBiYH1w1WVXU7RdWLy9x4AskfU9LClZYAYJicZl42gAgCEC92h4kw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf1da9b-7829-4f03-8a43-08de8dd27e28
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 20:33:53.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WgGCLAIrHpxIULY1QMDOutT1fHlKHx+E5eViaeAIONFZLSDpcW5VFuPIPqadCSU13t2j+NhtoldKX5eLNLvhRHFWqpg394P+ctjwBoujbCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6329
X-OriginatorOrg: intel.com

Dan Williams wrote:
[..]
> I just realized that this reacquires the semaphore on every invocation,
> and leaks stranded references.

Terry, while I think this issue is significant I think we have passed
the point of utility of continuing to spin this series. Specifically we
have general agreement about the approach and the issues being found at
this point are no worse than the maintenance fixes occurring on the
already upstream CXL infrastructure. My proposal is apply this v16 to a
for-7.1/cxl-aer topic branch and start submitting submitting fixes on
top of that.

If that topic is merged for v7.1, great*. If not the commit ids can be
stablized and a for-7.2/cxl-aer topic branch can start up from something
like:

    git checkout -b for-7.2/cxl-aer v7.1-rc1 && git merge for-7.1/cxl-aer

* The primary merge blocker question for me is whether PCI core agrees
to the proposal that CXL AER requires 'struct cxl_port' objects and
forwarding notifications from the built-in PCI AER driver to the modular
CXL core.
