Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4E376A18
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036598; cv=fail; b=R2/+04qBjLN7Mb5OmG3QNQ5cjSRbkD9ZMKa/lAZcPxoM4ZwFCEiIp89kvhIcSqBVx4+SZuKNbeurFkpj3P5DI98gq4uWdB7I+INGGGmqE5513++qV4VluuGFG9E5EvLs1S8P1VgYdpzBjQSyVd2yRIBlW610IwYHRt9A9e95ZU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036598; c=relaxed/simple;
	bh=QQTxNXS8csWz3YmR/wX/2kCs4l7DoKKjYnubE++mDlQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NaXZwtElHO62aJI7b/b3UXnzXwn2Ry1EqXmZfe8i2k4m1ZaggQ+NwHE9LT2G/GeRfOzE3CrZQ0y11SmJT2FndmFOqOGm/uIMhcxt3B7URIBOdpsoBh5xDqjKs3vnRqucxyFLbklpZv6UcWvW2U+8CDHS+iZSdrSKVZXpCrmZoTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mts8ngX1; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mts8ngX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786036597; x=1817572597;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QQTxNXS8csWz3YmR/wX/2kCs4l7DoKKjYnubE++mDlQ=;
  b=mts8ngX1ozvNFM4mU3Q6zsaJmzupa4N+FK4+Aw+JtSd0dnAI3xm7KHBV
   Q1gxs49tqsEn+r2NOOPnk1FCi1DzHqB8fheC6V2fYEYyPdU2a4ALAFDT7
   79n08D5WXhuF5Sl4vrAwwtS1T6Ulfgkt29RwlW2tggNtCq4sooJXeiHwu
   e/LTpOjTEuqmONLUxyMVXHv6NjarWpeivMt4cBJ78V1DQGp3krQU+rzFi
   tezztOCD8hd9q1D7X50SA0MoQYzIEOBu8Yu4F25eqOg5fHZvcQmBKEvao
   0/ml+FOdZr9bDZjEYqjgB3KcOOwA3WxM2fUIjCXj9stC1iPtblZ0YIvxI
   w==;
X-CSE-ConnectionGUID: h19GslXQSY+CoKi9TM97kw==
X-CSE-MsgGUID: q4Vq6nz6SFeMh8jnVncfhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85608572"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="85608572"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 10:16:36 -0700
X-CSE-ConnectionGUID: TXMwbeGNTHKOPDDdzaLMZw==
X-CSE-MsgGUID: Nlvjlsk7QSS3ApPg/Yacbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="261645555"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 10:16:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 10:16:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 10:16:35 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 10:16:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qq0x4CETzMDpQgtoaCTWemxlL5MlHIhHRXXpF83Tr1GkhSz8VGdqCrm9cdEapiKg8fVroWcbCQUCyPohWbzq68W+uuwx4izud18hmVKaH7rTP6A7xGZH2DbZ5WIbjaJ9e2+1/Gq5xLHxDCRNIvlbDvGbskx7TGYwixD37oHFqQbemAjL9Fcd3VrrlcawTtyoOywHxV5RYJHhvc+8YYs7Ns9z8Znw999r7mRwHMFD3TvIOFlK77/qRiWyS28K1em2EFsQ6yPfVOCKFeF72liJ4M+2VPkJBMq6vElijBjZXwpck7EQfhTTaGPw7AFfXJ3XlzptAYU+/3Vlqf664bL7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnYPoGgBKP5Qd1YPFG3If0DZV204RMYhygSfCn7vZDw=;
 b=HQ4XJkZhqM/ZtaTpDYd3G8W1dgFdmTpR4wOhaNBH343QSLr9JKeH100qpDWGZ8SExW5XLTx1cRlbzAkls2tmbf/HZbwkuinDiy8JK2711agB7APDQkJQ4SZr0RoBVdSY1nuaPcFATHvF54F11d29Jh7gHwgHxpyvmcBEFxtaBGxEpPZKVl3aRwgxfGZ6Dl4EmyftqHQxx5vl829FUW0KTwNN0QfVUpXHchmK0vDrUZfmqjMps+R/hOucWW5W5V8we4HkBNPgzaGP1TR8U6DxsJdmjQth6AoZd2FQTlNR7J22f3Rd+RY15DZtoW/J929FuuIh5GBaQPA4OWdmkTb1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DSWPR11MB9691.namprd11.prod.outlook.com (2603:10b6:8:355::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 17:16:33 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 17:16:33 +0000
Message-ID: <15f74c26-82df-4540-87cf-c20c42c0d96b@intel.com>
Date: Thu, 6 Aug 2026 20:16:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 09/14] i3c: master: Report wakeup events for IBIs
To: <sashiko-reviews@lists.linux.dev>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, <Frank.Li@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-i3c@lists.infradead.org>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-10-adrian.hunter@intel.com>
 <20260806134959.A494B1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260806134959.A494B1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0010.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::15) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DSWPR11MB9691:EE_
X-MS-Office365-Filtering-Correlation-Id: dd23063b-b80a-4422-62af-08def3de76a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YSbOcu1nUyZO4LYZnn6/b2o+zixb9u5cRpGRDS0x2ilg0/Ex5Jh6H4GlsCqkTKTGT7k5VLGxGi5u49l7D9kg1nP0en1uMn/mXLcsOyh8mK8gsDrLaldy9Q+L4BYNKiJyEWyV/eCxKupiTAy9TP5sqM5KP//kvvv05fB+PsB+6mk0fw2Sqkm+hKs8TcHFNLW0CJkh7+fpr60jttQhVVHd9YhPpJsLKX8Z6BtE2dp0oAtLcCQ23qbgLixb7wdy/2ZWTEgjuGNnenU9VY3c8vJQBFJoYAD/ToJE9hVb7crSeS93HgsQfW7rSXqscIewuet1/Kme4nCY+ANTRlhisrKJZ53wo29ES2rFw/71EEkp87zrQikRnP06l62WgulMMzWSkqt2v/o3L6HbpWyLIJJ2K4w0jUGJcI45v/zP2jJYOqT09pikSFQz/kYOtI1LLhOIR/NfjUbmsDNcdw3K3JqeGLboIe2rSkCLOjDCxYERhgQc9AGGQmspEnlwym32m2jHSZKf9b6CAnIS+BZPP/J3tT0NmsPJiyMmzX6vb96/SabiJhZFFNI6HapMUWY2f6dI5bnAv5KbdH3MBseuonYVmuLJ1yOxJoMvvdObMIN5L1fMkXpf7xBt5rNd+CJ7VW6sDt45akZw57J3aIPJ1NjFlPOOazQjW0Tp86A4LAKzmuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlpsQitiTFFqR2Nac0xPUDF6TnR4dlI4L05OMFlBREw4aWZtR1hnTDVPSDFD?=
 =?utf-8?B?NVNlc3NaaXlkb1E2TGF4b2tKZkhvWitLQlRLOHJNMHF2Mys1VXZ5aEozYnZS?=
 =?utf-8?B?Uk5mSTZ5WFE4MjZEY09LVThkY1ViL05VN21sd2dYcHVvVG4vR2RxSENza3Zp?=
 =?utf-8?B?c2czSWt6NmE0TWh0L1VGQU5HZTJ6Q29jUlVHZE1UYkZOL2hyTVFMSHlRNjBM?=
 =?utf-8?B?Y0ExNmRteVQ4MkYzWGlueVVXbWRzNlF2SEdBbkVtSitXRzErM2thQjdZVGxa?=
 =?utf-8?B?VWcwVlQrQ3ZPVHFPWmp5ZUh4dW5WT1kxaVVtZXE3eDdySDZUL2hXclJVbjZR?=
 =?utf-8?B?a3JpbTg0R3NWczJLQytpZWVyTDlpemVscVRFU2QxcDRveTZsblN6VkQ0R0Vz?=
 =?utf-8?B?Nm1OeTEvVkhNbnV5aUhaQVFUM1ozNzhsUnZYWjNsUXZJMm5GNENvV0NaQkV1?=
 =?utf-8?B?YUhZbnU3YU1pSGdNOS92Znk0YlJMb1VPOVJJR2pjQlFDOHlCRGpjR0FPcG1Q?=
 =?utf-8?B?YU9lbEwwZ29sSHlGWWtidHpXZmR2RGN5bmdhSEg3bncxSTZrZ3NTR09WUEtG?=
 =?utf-8?B?a2hLSzNHNkR2MVhqemdaeXBsSWtpMXdLb0JIL0Z6RDRDRmJLWmZUZldmNzhz?=
 =?utf-8?B?ek8xS0hLNXJkU1BteE1UOWxoZ0ZvaUlFUGFzMVliVjczMGIweXNqZ2FqTjll?=
 =?utf-8?B?RjV6VjJGOFoyZjdyR242ZThPRmc0VG10UGpXeVhaMXdWS0grSjlBOEUyU0h5?=
 =?utf-8?B?YVFBTnZlc29ONFQ1K2xmV0VMWlQ3RC9RcGU1djViNjFZSHVlV3lNdzdHclUv?=
 =?utf-8?B?YjdHQUJRR1FKd05GT3NWU01FdU84VkV5V3F3TzNrWVZnSTlvcWEzUmRRa09v?=
 =?utf-8?B?SE53eVZpcWRDbmx0TFpZOVZSQWRlc2xqMkZ3dk41VFRpcG5MOHdqVmlGMitt?=
 =?utf-8?B?QWlOOHZYamtxOTBqUzI0N3RsUEc0bTEvNnFvSjFDMU1sNXVUZDNqZm9FOFA5?=
 =?utf-8?B?U2x5cmVPZ1hUQ2QwNkVKM3FDSlFwWXBDZngyNzk2djAzN2N6RkhuN2NNT1BZ?=
 =?utf-8?B?ekVuMVo3MVQ1M1lJSlF2ckNIS2JnYkJBZ2hUeWJKbEhTREJBRW9laGszc2R6?=
 =?utf-8?B?dk1KMWtmS2tDMjA0aXdRYkNtOW1tS0hSd0V0andWMHdkNnJpRkRTeUdEdG5B?=
 =?utf-8?B?emRKdytlVnRnR01Oa1BPVkFxaGs2RGh3cTFDZGF6N005TkVTa2RITDVpOGxz?=
 =?utf-8?B?cGtiQWhNUm1qWk5LejJmaUVpUXhWTGlHWlliVmdLNDRITGJ4NW9KS0Mzbklr?=
 =?utf-8?B?eXBTcHYwNEhFaEpLTXRIcUtiQVdHN3VxWHVVaUp2MkJTZnlMWTJYcEREU2I4?=
 =?utf-8?B?SEVpK0NndllNaCthODNGN2xHRE9wa0Fja01iVnBncERsRW9pbU95WUQvNHlu?=
 =?utf-8?B?NFRuZlVxWlJubVBxVDVOMUlIMTBuR2JQbTRoN09MV2ZNOWJlalp4WldJbEpI?=
 =?utf-8?B?M1JpZVRIOGUyeHRGMUtTMlB5eFNUY3dSSVJGd25PYVFsekRjK1VKZVNWU3BP?=
 =?utf-8?B?YkVCOTVLTDMvUU45UkNrWlZlVGtQVUdtcS9pcERxcVF0bGxoWHpKS2F6bjht?=
 =?utf-8?B?azFIVWMwZnhFYWRodmQyRDd2QjRFcDFBd3hlT0V0di82dWNYK04zTGUvZWpm?=
 =?utf-8?B?eGs4UFJIdlZKMnQ5S0Vtc2Z0aThqRGc4d0NCcnhiNklwWE9wSzR2Zk1BeTlO?=
 =?utf-8?B?cFhGZHpTajd6ekdEUmNkd2V0MUtkNW04bHQrMmE1c0k4QmVvVkR4WmFJYTRn?=
 =?utf-8?B?UzVteVlSMUswV3k3YUZMZlB4K2F3Z2xadzJpN01qcElac0Y1YzRCNUNLc3Yx?=
 =?utf-8?B?Sm1Hem5YcDdTUTE1QkJjaEVGYzJ0MlNsVXhiVTBjTm9tOVhDbWtuUWp1OGg3?=
 =?utf-8?B?TW03RDhKSHY4NVlYWEJBY1dFdUFwbjFrSkFFUkFaWDlvRUlGNXdQeFN2L1Mv?=
 =?utf-8?B?bk5MbmtIYVF6VTVScVc2YlhaS2RXYWlsc1hrSzVUcERqbzB0ejdnRUtjWUl5?=
 =?utf-8?B?bVQvd3pTN1RTQ05Ea0pmK1h3dHo4ZFA4b01odmlBWTVPQk5laFVyMHYya3ZY?=
 =?utf-8?B?VitONU9VemU1OHpBbzl4a0IybDk1NFl6RXB0WGY3TmJuWERubTZzbG1Dbk5F?=
 =?utf-8?B?WVlGUlBONDhsQXFiSTRnVmNKZXI4Zm05djJtYWJRVnJPTFdSVVhqUnM5bzRB?=
 =?utf-8?B?dC9VSGdKeURXMkF6emszRE9xOEVyQkZ5L05yb05TbERQazJ2bEpkSlFMaVFQ?=
 =?utf-8?B?M2s0NldaVytZSlo1NjlWWGlRaWVNZWhYblFEUDB5MEJSNFUwWHpWZFkxNWVF?=
 =?utf-8?Q?1+gYfXpsYMsEJRRM=3D?=
X-Exchange-RoutingPolicyChecked: HUXr3QSzgzUULeIG+qBzNgTqI2S4gRNW6wqyB5MRokoveg1vLI1jTT/D+hX81PVRDFruCSXgWy+75pFOJq+IZavM3ZPEgMka3UqD4swkHKADh/VpiI48Vp/cwsv9s6nCSiUErktu+/7ETVbxqMnCTsTMobF85WsjhTDdc6wUKXo4Jdn+aI42XkjlMP2W7LEr/PvI87IMLPW7vZTpPX3isxObPQAiTIay8JhN1u49CiqwzQpJKVQLwSJAfEsEFrNfe1L8GXOfW525GsR0vsDmQg4vuvgBjVPFyrYKcAZK38ij1ZsftbvFK+83Tg6OmzBVH0O8rLUIWljVdliqqO3eRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: dd23063b-b80a-4422-62af-08def3de76a4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 17:16:33.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTmUgcogX8rORE57uZe/ELdgoFji++J2RtNHLnFFirRIhfkrQjhk5v5OB/LPnxIri3H/GCO/m/pQJSD9u6/gpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9691
X-OriginatorOrg: intel.com

On 06/08/2026 16:49, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] NULL pointer dereference in `i3c_master_queue_ibi()` when accessing `dev->dev`.

Refer:

	https://lore.kernel.org/all/59d05b05-37a6-498e-8dc4-3d4ba1c83d93@intel.com/

> 
> Pre-existing issues:
> - [High] Race condition in `i3c_master_queue_ibi()` leading to Use-After-Free of `dev->ibi`.
> --
> 
> --- Patch [9]: [PATCH V4 09/14] i3c: master: Report wakeup events for IBIs ---
> commit 461a49ac6bedf9467539aa8fac5583bf77ad5045
> Author: Adrian Hunter <adrian.hunter@intel.com>
> 
> i3c: master: Report wakeup events for IBIs
> 
> An I3C device configured as a wakeup source can wake the system by
> generating an In-Band Interrupt (IBI). When an IBI is queued for
> processing, record a wakeup event for the device if wakeup is enabled.
> 
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index 2616354dbe545..6c53414919445 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
> 
> [ ... ]
> 
>> @@ -3397,6 +3400,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
>>  	if (!dev->ibi || !slot)
>>  		return;
>>  
>> +	if (device_may_wakeup(&dev->dev->dev))
>> +		pm_wakeup_event(&dev->dev->dev, I3C_WAKEUP_PROCESSING_TIME_MS);
>> +
> 
> [Severity: High]
> Can dev->dev be NULL here?
> 
> Looking at i3c_master_unregister_i3c_devs(), it sets i3cdev->dev to NULL
> during device teardown:
> 
> drivers/i3c/master.c:i3c_master_unregister_i3c_devs() {
>     ...
> 		i3cdev->dev->desc = NULL;
> 		put_device(&i3cdev->dev->dev);
> 		i3cdev->dev = NULL;
> 	}
> }
> 
> If a hardware IBI is received during or shortly after this teardown,
> wouldn't accessing &dev->dev->dev cause a NULL pointer dereference when
> evaluated inside device_may_wakeup()?
> 
>>  	atomic_inc(&dev->ibi->pending_ibis);
> 
> [Severity: High]
> This is a pre-existing issue, but does the lack of synchronization here allow
> a use-after-free of dev->ibi?
> 
> The teardown path in i3c_dev_disable_ibi_locked() checks pending_ibis
> locklessly and bypasses waiting if it reads 0:
> 
> drivers/i3c/master.c:i3c_dev_disable_ibi_locked() {
>     ...
> 	if (atomic_read(&dev->ibi->pending_ibis))
> 		wait_for_completion(&dev->ibi->all_ibis_handled);
>     ...
> }
> 
> If an ISR is executing concurrently and passes the check for !dev->ibi at
> the top of i3c_master_queue_ibi(), but hasn't yet reached the atomic_inc()
> here, the teardown thread could see pending_ibis == 0 and proceed to free
> dev->ibi in i3c_dev_free_ibi_locked():
> 
> drivers/i3c/master.c:i3c_dev_free_ibi_locked() {
>     ...
> 	kfree(dev->ibi);
> 	dev->ibi = NULL;
>     ...
> }
> 
> When the ISR resumes, wouldn't the subsequent accesses to
> dev->ibi->pending_ibis and dev->ibi->wq cause a use-after-free? Adding
> the wakeup event logic slightly widens this existing race window.
> 
>>  	queue_work(dev->ibi->wq, &slot->work);
>>  }
> 

