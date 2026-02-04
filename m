Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF4395DA5;
	Wed,  4 Feb 2026 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241344; cv=fail; b=tv5CSCF0dL7QnZu2/tQSzYOUuWP2h92hmgtMbvioHns+al2Abc5b/mKFCv2hR5ZfWuFakyo6dpy9c1Ag5wDdPI+hNOMCvn0WomzemhP3g3ubrCWav6PtSoh+9KQYc1SFDkZ5ckdslJo+YDe2acV5WXqosWvjB92GdFO+4MbXRZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241344; c=relaxed/simple;
	bh=BxBjGgfmxaRWvB1YHpdAlD0LIWx6xd4mVpWaYj/keug=;
	h=From:Date:To:CC:Message-ID:Subject:Content-Type:MIME-Version; b=EIqyAuS7fYjzX75JW7zocQ2/pvjQNO9HzD0rXirx+TG/5xS/TryD59FnDxBAIWrkuSaRg/Hgq4/VcC/5m1eC8tnWSCSxUEb96NAAUfRW33DdadJmTC0Mq5CU895IPfckm7MzVCzhw8fUWxiQd9a4Yw+Ryb9U60LGZ0jb1TSDAw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIXn4aQ/; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIXn4aQ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770241344; x=1801777344;
  h=from:date:to:cc:message-id:subject:
   content-transfer-encoding:mime-version;
  bh=BxBjGgfmxaRWvB1YHpdAlD0LIWx6xd4mVpWaYj/keug=;
  b=IIXn4aQ/1lcDKvoHYXWzofMfkfVtuTJoOALnPCVjaKOV+pCbAQb/srbA
   aVO3vQoiaH+FUDgmoceEZRA5VoLkdVAZAY7uw8mEz2YBkriIEKEZ+Oizy
   LvmCi4Ox+5SMbFy+dCW7Ed0vHjKMJyD2oSUdoBGEQ3AtptQJX/GpbGWfj
   +vQTvfSUIvdtIYVj0Tba9JDO2N/fmW0sOXKDyqIDmUrN3tZDtFlU/sQw3
   3WDugUiQES/shr3bpxqeTmkC5amG58jdZ/iC5jKQDCxHJUkZKZ3JWJBDk
   FWeJVubjM8nxR5bVcdVDscsGW6ff5y4ZQKbWdhA4RBchmU2tNFL5R4zAQ
   A==;
X-CSE-ConnectionGUID: liRxxi8qRniD93sCBk22RQ==
X-CSE-MsgGUID: oRhkKCZlTwqKLmsOfMxK7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="59013913"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="59013913"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 13:42:24 -0800
X-CSE-ConnectionGUID: p6L8ID6KQq65nVIbqcVZvw==
X-CSE-MsgGUID: YmgErtdTQd6Lnc1wEelJMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="240957171"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 13:42:23 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 13:42:23 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 13:42:23 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 13:42:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwlfSOhWdjoIpK5gxFIy5zjLesLaTLdad+pZstk0VZpzSP5DpsN6kfSgQmXLxyF/ATOanooGgMvzAhIHwKVLQgHMhMZ4yhbciwf+rrGdJt+sTI8sE5UEXiKyntjvPtV8htXKcVv9lvNgrV0/vN9fD7C/AZINUunrSW6LbYHZxf5uhbRKFb6vM5Fdn6W7FL//Z5YxZCIHKCMibl4IGwO8cWrRnEQdeNQXh6a9B3nKUQQElTz9EZbfFiWXnTRhmD/zWiGQil4Hosg6He5MHJdzMRBtMSS6GCCGRjpIUWL1u9i/UZ3dWkyYjMDEEBUQKtIbXSd9wIJTwt5Lwbo32jrlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yxW/2VrrNeuNZ+0DrrjSHgvCf8ioN3K42G7jl7VCTU=;
 b=Jr77kU7DF/oybA0VAys1nOTRSbQQ6t44zVMDN1O9Oyqj7jMvDVJ6N9rb1DC3C3FbecaVnTjc0Nft4tn2nFHid27464mj7I4Ys1d9iV53goBY97c3g0++eyw0h82GbwMiC7mE4IkjxlTvhZmorIz/5+TmKDUyrloZeQ/yg8nA8YYIFSnX7HyH16x1o+tbMQl/6Alm+PmPAAo7A4mbKA3LuERqtURUmaQt78HtMXzuxZVrCyNs52DP0Dlbd0zIGdvxk6dLBI2N5CrrJw30M0UJd6YHj+uXZFj0LdOF82b3U5r5ZUYrmMuTwF4MMCBZJHvmzdqqOMVaonTi/pC991INWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6740.namprd11.prod.outlook.com (2603:10b6:303:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 21:42:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 21:42:19 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 4 Feb 2026 13:42:18 -0800
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, "Aneesh Kumar K.V (Arm)"
	<aneesh.kumar@kernel.org>
Message-ID: <6983bd3a3a3ae_68d310016@dwillia2-mobl4.notmuch>
Subject: [GIT PULL] PCIe Link Encryption fixes for 6.19
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:a03:338::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2fe4ea-186d-42f1-50c5-08de643645d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjlGOUQ2YWJGRm9HSGcvVWI5ZTB2MDM4R2lHQzV1cHF2WlpQeS9vdnZIRnZn?=
 =?utf-8?B?SFJkN0NzVmRMdXlTanlLRXpSVE9jZHNMRUdRS0FVRGFmK2pvYmJsR2pSVmtB?=
 =?utf-8?B?Q0tkd0N3N2FpMVlLRTZQQWxSTWN1ME9yOXRkWXFJZnJrb2JobzdWRVNRSkdz?=
 =?utf-8?B?RXFyakpJV2VWMGlkWTZVN29pTHJPNWdYMTZQZllXRkNHekNZT1REZjZaTEZo?=
 =?utf-8?B?UWtFMXpsVFVaTkZ5QXgvYUtxcVZOL0RybDRaOGJqZjRWUmcza25qYWswYkVs?=
 =?utf-8?B?YSszYUx4dmJrLzJjY0xRQ0x1UHl0aEN1VXQ5WWZFUlpHUUdHOC9RdDNoS2Fl?=
 =?utf-8?B?OE9abFA2ZC9hVUt0Z0wrTnZvYTBMbERzRWFpZ3NJTVArUlVkS1FNbThIVTcr?=
 =?utf-8?B?Y2Y0d2NJRUFjT1dqTnJXaHR4bVlHSHVramlTY1ExdXJrdCtyQzV6anpFZ3Ay?=
 =?utf-8?B?Z2Q5UlJ2bEtLVlpJRDU5OVY2cWFnZ3Vob0pjaGZXYjJNejRMOEloaXI4akQ2?=
 =?utf-8?B?d2FEOExGR2svQzk1S2F4bnRWMS9yWXAzZHZyYWhWaDBRdGlCQmVwL3UwSjBo?=
 =?utf-8?B?N05qckI1MjJxeWVrUkpmU2pDaFZjbDFTMUFJZlBaWGNJalJCRWZncjRvcmhB?=
 =?utf-8?B?RmJVcyswV0FZVzhMU295dE9hTElXdDlwUEwwM2pERFJOOC94cUlCbmc5K1BG?=
 =?utf-8?B?UG9Sak4vWkRRSTdLZVUzYjNLdVNyb3Z6bGJPVXNWb0I2aGFaeU5rZ1J2ZHlZ?=
 =?utf-8?B?L3lubDdtbGMrU3ZNajBpR0Ewb05rdlowSHMwY2tpTUoxTnp2dTdyZC9vcXkx?=
 =?utf-8?B?aVRaMm41VWNzYkpYSjU2RWNPb3NheUlBVllqNGVkdkh1UzNCeFZoYnJLY1dx?=
 =?utf-8?B?M2JoKzBROE12OWRTQytxcHhlMVFWdTVEcGluYzFYbmFkVzh4b1U4SEZxSlNw?=
 =?utf-8?B?M09MQUFkdE5pbFhVV2tNR1FmcHVhWm5yd0hUc0ZDNldHYVE5d0ZHMzM2RmZ3?=
 =?utf-8?B?QXRTYk0vVHZ4Y216cEpDMDQ5REU0ZU16NnhTREsrc0FaeUlHRXRtRTVyZmVu?=
 =?utf-8?B?bCtwdDNMQVMrV0pqM0xnU2xrMk0vYTk5ZThwUDI0S1B6a3Y3S0MvcUJkY3Ar?=
 =?utf-8?B?TGpkNTduYnBoYzBOczR0Zk9NV3BvTlNFMjVWS3gyakFsYXkwamQyYkJtWG1w?=
 =?utf-8?B?akpTZXNCdzhabzZOb3NYbGxHUEJLS0kzTXNEczh3WHgyRVYrVXlGRzJPNEtt?=
 =?utf-8?B?RHdKOEcxRmMrZWFkRGt4b1hXdWZRZm9GdU5CcWJQNnRrNExTZTJJYXUxeEJV?=
 =?utf-8?B?R0kwUS9Iam1kRm1DR1lwc3ZVQmZxNlkzQTRtbURrUmwyZWxXTEJYNlRvSHJq?=
 =?utf-8?B?UmZyV2xtMHhkSi9VNlcyT2dMM1piUWhoTHQ1TzFhKzY5cWVGRTJ4M1NZUE1F?=
 =?utf-8?B?N2RLWXpIc285djhKQVNKQTkrSEJ2emVjL3g0Q0MwczJqc1MvUkl5dGNUWml1?=
 =?utf-8?B?ZGxleVpldUhOczZpYk9IQWNPVXIxakZMc3Nua1IyR05hOFgra3J0WkVkM1Ji?=
 =?utf-8?B?Y2lmSUc3SzBIQzkrNG05eDhFeWFyNXhCa3g3cFNOcHBuNFE3SWcyZWMxeWhW?=
 =?utf-8?B?ZVVMMzdZS1VYMTlWZ0VlMlVkUnIrc2ZtbFNrT0MybUo2RzdYZzF5VkRFZXV3?=
 =?utf-8?B?dWNRdDhVaHR4dFVxM3BZd0txVWZrclBhNktuVmM4dGRTbG5LeHVCMmNGcnRm?=
 =?utf-8?B?RCtINlRmNGs3RlorM3BXY2JTTFl1RnJQbUFDK2FRT0lXcEJUM0hBRGltQkRC?=
 =?utf-8?B?SXg1MkwwQUh3cWNEeXFPTWJ1TWR3dzVlUTlYOUFGVkhwV2VvclBXT1ExSmRM?=
 =?utf-8?B?U2hJa2dCaURFaDNERitaWHlYUHdaZnhKSGRHZWRiRllvczhacXhNbHlUa1RR?=
 =?utf-8?B?b29QYzBuRXZraW5ISEJKRzNIM0FqMzVMWEdXdU01cGZidzA2UlZyakVoemt5?=
 =?utf-8?B?c1Y1WDhyclhheDFPZWlaRnBydTFtOFBjZXFRZ2s1M3dhVTd6SEI1UHMzR2xB?=
 =?utf-8?B?RldGbnRRZDZQTHlRbXZQK2JTRjBYcklTVDUzaHF0b1R1alF1Z3dacGs0Mlhh?=
 =?utf-8?Q?oIco=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWIwNzZEUWtXUWs0a0JUSkhEejlDTm1mMkV5WXAvanBZQ2I4bTkvdEU3MWI3?=
 =?utf-8?B?Nm1LVDFmWXcvOE9uMXlvK1JvS0M1OG9MUFJvVUJNVjYvWUVxcVVQQllUc2tX?=
 =?utf-8?B?RzZUWFh3aVpWY3FBa1dxOENiT0xONDBvanE5Smp6VUFGU2RLZkZCUnFRUmlP?=
 =?utf-8?B?YjlXODZuZTZMcnRIVW81RStOSmppdk9ENG9vS2d4c3VMbTBxQXJzWURwSlVw?=
 =?utf-8?B?U0pPdlF1Nzk1OUc1VnpheFBEaWRBOEk1UVg4c3RVQnN5a2N6ZmZMc0xyQU0z?=
 =?utf-8?B?Mzg5UG00S2hqbitubjl6QWwybktsdGk4cHBtSVlzYUxLMng4cEI2UmlPRWN3?=
 =?utf-8?B?V3pFODJjWFQ4RFVDeDE0REV6NTJOYm1iNHA2a3VXTnNrTnZoSVZXbXIzaS9H?=
 =?utf-8?B?WWhvc0dkVnp1MWorblZha1kwM2JtSGpRanJMakFITDY3QVNzdEsyT1FyaUp6?=
 =?utf-8?B?Z0dDOXYvYUJSTXN4TnAvVnMwRWVpTzBFZW51RVZCSmd3bU01ZitncVhSR2xU?=
 =?utf-8?B?TFdNaWNhY2pFN2JqMjdMY3gxeEdSMHFNRWt2UzJXUXpKVkdGYjJnOFBtdlFY?=
 =?utf-8?B?N0MvU0ZPWW4vZTErQS9TWS9xRGFxQkI2OUloanFUazZzMnhEUzJ5Q1A2SHJl?=
 =?utf-8?B?aTZLdlhUbHdlcUF3VDE0VFp0R1llVkk1d1BjK3NiaFBqOVZvM0VRRUZnNmRl?=
 =?utf-8?B?OVAzTkF0MGhHMFlOcmphRjdxSGQ2QnpxeHRiRzZpaU82b29qdkFOV3RKVnkw?=
 =?utf-8?B?RlFhWHh6S2QzK0FSQ21iU3o5YXhCcDU2MzRGYVM0YjZtNU9nNFBhTno4cW96?=
 =?utf-8?B?VDZKNGZSL1pHQUk5engzRDJCRkRuQi92K1g5UGNxYVJWVDFPSWVUNDQvbGlE?=
 =?utf-8?B?OHJnNWxZeVJpNHRLYXJWOElSZjMvbG1hOVdQd2lNcnVqRC94Y29SbjFCbXly?=
 =?utf-8?B?L2l2L0ZMU3gxR0JUOGdYWTB5U2RNNGVOcFVhTlFFZU1xYnBZaGo3YWpyYW5q?=
 =?utf-8?B?MjUvMzMxeXdKbDdneFBxQ0JzUCtCRlluNDZzYTRJd3RaaVdrekp6M2tqengr?=
 =?utf-8?B?eGJhRk1oS3RlR0lySXN5UXNnVThvVW4xMjhUU1N0eEZTM0FlK3EwdFhseWNw?=
 =?utf-8?B?bitrcjJhNWhHRXJJNEVxS3ZKbmJyVFBUT242b281SzRmQjRDOE1WNkVYcld3?=
 =?utf-8?B?eEFNd0Y5dHczZ2YwREFFM2NGSG1XU3NNME5xVkVsTWtYeGh6Vzc2cFBFSDh0?=
 =?utf-8?B?cFpJL2pCNzNaV3RNb3RxVmgzSHR3TURBL1hUNlQwUGpYMDlJM2xYTGZQbGdx?=
 =?utf-8?B?Z3pBZjMrbnVseEYxdExkUFVvZE5WV3VzNWo3aitiR1RRb1JJQzNFOFNEeEZ3?=
 =?utf-8?B?dnpKRzdtSVNHcnhsSGNtRkt3VWxoV2hzc0xMY0xsUWJSYi9Wa3puVjc2MjBN?=
 =?utf-8?B?elFVTXUvV2lmZFdTb0NmTExEL0lWL3UvSURvN2dvQ1ZDU0hZMVNKRnJ5Q3Jq?=
 =?utf-8?B?dkhqbzlEZGlTZmZYY3Y3NXhxVnFYV3gybUhzZ1ROQXpaeXh1OUEzeFNoSkht?=
 =?utf-8?B?NjZ4N0YwYUlWMXovb2cxRVd1cEVZd0crSlQ1ODlhZzh3b3JEdEwzN2ZHTjRr?=
 =?utf-8?B?SGJHdUdNUTkxQ1V2SmRYbWNhdVBNR2RXZDBGTFZUVExzQ2N6QS9rZ1VrSW0w?=
 =?utf-8?B?YXBzeFJ2SG9aeWxWR0tDcCs4cGlKVHNIK0dHcUpsYlhCVnVveEc3Zi9takt3?=
 =?utf-8?B?M3VSWkRIY0owMWZNWkFTT2pHQUdYc2FVZkNjZHlodzNzd3NZTUVYYTV2WWd1?=
 =?utf-8?B?OXp6eVhnbWtSeWhWTmFRV0ZNallMcFpDcGcwR1RTRlFPLzhsM2dQaXZncWZ6?=
 =?utf-8?B?cjRvdEkzMlcwTTBZcHREUXd4RUE1ZGt0NEx5RkphTFdMcnpZTkVVZ1Q2Y3la?=
 =?utf-8?B?c3FVWGJtNlROSmsvUTZhekYwWldTOFR4alJ1RGd6YitCMkpMcCs2WjhteEJx?=
 =?utf-8?B?QWZuSE83R3Irb0ZFR2RJajBjbHB2ckxUWjcrc2E2Um04ZkNUcjVPQ3c3MDdl?=
 =?utf-8?B?QU9MR1I1aEU4NHJ5Und4VHdoSkszSHJML3JKa21lZS9Va3dhNVFsYTlSeHRF?=
 =?utf-8?B?UEQrVU1zYkt6bSt4a3NRdll4aHhDUkdIOGM3dDNIOGRJYk51eUsybTVhbXVZ?=
 =?utf-8?B?Z09OUUEvT3R5eG85QmJmSGxJSjh4Wk9ybldIeHNwNGlPTEFpSFdlVTdlVzhH?=
 =?utf-8?B?WVU0WlJLQ3NkZUlEb0haUC9NemM4R3kyUFZUbGRDcHhCQjJIb2JxWTZxcW1w?=
 =?utf-8?B?eG43RmcwVGRZOTdnQU5GaGZrNlhwOTgzOHpwQ1JIc090SzA1bjR2dkQ4bzdY?=
 =?utf-8?Q?hnyq1oUQd+R9I4JU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2fe4ea-186d-42f1-50c5-08de643645d9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 21:42:19.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoNxT9Ue4FH3P4jJT9IQdIJdxwKeqdurrflC35RhAETysu6RJ78Qj6DD5cxTGJsFxqe1w4HKSd+tx3kkzcey8pgL2SYZz/V8wk6hxPLLNDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6740
X-OriginatorOrg: intel.com

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm tags/tsm-fixes-f=
or-6.19

...to receive a small collection of fixes for 6.19. The largest change
is reverting part of an ABI that never shipped in a released kernel
(Documentation/ABI/testing/sysfs-class-tsm). The fix / replacement for
that is too large to squeeze in at this late date. The rest is a
collection of small fixups summarized in the tag message.

It has appeared in linux-next with no reports at last check.

Given the tsm.git tree merged the PCIe Link Encryption support for the
AMD "ccp" driver, Alexey asked that the fixes also go through the
tsm.git with an ack from Tom. Bjorn acked taking ide.c fixes through
tsm.git as well.

---

The following changes since commit 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7=
:

  Linux 6.19-rc6 (2026-01-18 15:42:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm tags/tsm-fixes-f=
or-6.19

for you to fetch changes up to c2012263047689e495e81c96d7d5b0586299578d:

  crypto/ccp: Allow multiple streams on the same root bridge (2026-01-30 14=
:27:53 -0800)

----------------------------------------------------------------
tsm fixes for 6.19

- Fix multiple streams per host bridge for SEV-TIO

- Drop the TSM ABI for reporting IDE streams (to be replaced)

- Fix virtual function enumeration

- Fix reserved stream ID initialization

- Fix unused variable compiler warning

----------------------------------------------------------------
Alexey Kardashevskiy (2):
      crypto/ccp: Use PCI bridge defaults for IDE
      crypto/ccp: Allow multiple streams on the same root bridge

Dan Williams (1):
      Revert "PCI/TSM: Report active IDE streams"

Li Ming (2):
      PCI/IDE: Fix off by one error calculating VF RID range
      PCI/IDE: Fix reading a wrong reg for unused sel stream initialization

Thomas Wei=C3=9Fschuh (1):
      coco/tsm: Remove unused variable tsm_rwsem

 Documentation/ABI/testing/sysfs-class-tsm | 10 ----------
 drivers/crypto/ccp/sev-dev-tsm.c          | 15 +--------------
 drivers/pci/ide.c                         | 10 +++-------
 drivers/virt/coco/tsm-core.c              | 30 ---------------------------=
---
 include/linux/pci-ide.h                   |  4 +---
 include/linux/tsm.h                       |  3 ---
 6 files changed, 5 insertions(+), 67 deletions(-)=
