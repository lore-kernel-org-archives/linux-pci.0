Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020094.outbound.protection.outlook.com [52.101.196.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E863226D02;
	Thu, 22 Jan 2026 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082887; cv=fail; b=LQPkB2SVITl0sHTMdW/iMjaHIHe12wDq4TWP54hMpQ/hhlAfP8CPMhi9XGBAqdiPgTm1F8Nlu1bAJUFszq8+ToodAUo+pJsJRbZrhCwcc9xGPZ761BEKhCu8pu7mGrqTYUKOPphKGhSJfJd/hogjQ6CJAcg2DbRwCWTb2MSu3II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082887; c=relaxed/simple;
	bh=LAjH9wOhvbESYLqw3WIOuGDal3dbeTISv/2wlrYu6X8=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=qfvyJW7agkww1JJF+nWeF+fyQ3+5jIaMCdnq3ZqWsi5tWU/re2IETx2gRHLpn2bUD+KkMTnQu0yU+SKm+dtrH7902ULMISk4I+rBGOxoZ03VZHYKZyHPFxKboHKKHRpdBcq3YiBeqcLU6IqMLZgwIahoecvYa+t86J5035K2V/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=S8dWQjTT; arc=fail smtp.client-ip=52.101.196.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="S8dWQjTT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvEVfAdH5Okj4TwxnwmcGUsIfBajis1NRu7W1YcYvnsaIjJ1VSQ5MGS04cNtFtgie0GRLSST6DqmRr4Z1V23k2oj+ZexvdIiJxxAJ1A2kV5Pv+PrwgyH82hHIuqJGZKNx8HB9l2L5Qt85Jh+058WQ+Ud4jX/mRV3kKxFcnf/RG/8u1VtNw1Gd5pu1p1H7iv7FfvEwCyniS6WpMJiqJ+CqWKi0D8SXO6U2trQYo4mExHEH4tUHWYwlrUhISyvGoHlq2qWnBFzPudhDPIdhCPEKjbM5NfEZbNwpAm5U6HTrxAjs2/jfLDxDCrYIrr4R1lsuUGl5OV6GJaFYXaCCXILTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAjH9wOhvbESYLqw3WIOuGDal3dbeTISv/2wlrYu6X8=;
 b=YUJDml9YRXZS3VQUkKuzl+12Vps+stliZFgUhbzL9y/mSyksZ8oVm9XjyGRoDfFrC9kAjK3KnQMVTkWgYb9ZLQro3HsF7lMCGsUoMghdmc4M042l4ISJFCgHz5vs+fGW3pvnMfdwkS8SaOWRjioIxyq3LdcIYXZkPT75nj7oDDejb4UsYWP0kiMll9UEU9kieA1vLDdRzFaVM3aNcsY6i/AAnFXktML1ybRNbYRZDYMpcKO38cS67QoaeoiNqJXKGhXUqN1zU0hD/GR5fip8KJKTFSxDiY5QL+WiuHm74+bSZjhhDGJ4Pkz873sAWUDo5sXbgMQ6B847UROyrU/rvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAjH9wOhvbESYLqw3WIOuGDal3dbeTISv/2wlrYu6X8=;
 b=S8dWQjTTmU/o8ik7zw2P5ADdgh5yWwkenxYkTYPWzrRPDwPmZYoLLMRqPo9T0oo3SeFRGz9tjqRO0TamjErpKkeJ2sKmtTyrXSYsrTuwLeHa44SUmykzLggfyLodAIfZ4IxruwoD77PIzd6FNuM6Gax8X79iR+vXAqhuWn1n0Jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5969.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 11:54:40 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 11:54:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 11:54:40 +0000
Message-Id: <DFV3JJLHQORR.1RZOH2H5Z3F2B@garyguo.net>
Subject: Re: [PATCH v12 3/5] rust: io: factor out MMIO read/write macros
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
X-Mailer: aerc 0.21.0
References: <20260121202212.4438-1-zhiw@nvidia.com>
 <20260121202212.4438-4-zhiw@nvidia.com>
 <DFUU3EZKTPPV.18K3I0INY03QK@nvidia.com>
In-Reply-To: <DFUU3EZKTPPV.18K3I0INY03QK@nvidia.com>
X-ClientProxiedBy: LO6P123CA0048.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 054a3ed5-e6f2-439b-7caa-08de59ad067c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjRKTWpZQ0pFa1NoVE0yU0FHdHRQNUhhYmw3R1pRR2dsVTZMSFB5bFI4eFUx?=
 =?utf-8?B?NFJJdDBmWTIzTXhnWnEva2NYRGRrRUZRbnZ3VWcvRmp3alkwRWdkOG41VGxX?=
 =?utf-8?B?ZW5xb3ZockJjMCt2RTF1QWQ5UkRxVXp5VWlURS8vUERtVHQxQlB1bHJ2UkU4?=
 =?utf-8?B?TzBiQTNQSWtlZVNUZWtDeVJISnhWWmZ5NklhdDFvbkJvdFVWMnpsL1YxRnd5?=
 =?utf-8?B?V3liWGRhTE1UcnpWV0lxY1VEclF1UlVuckd6KzAzV0pzeVpCK2tySmdRUktk?=
 =?utf-8?B?S1c5TmdMUXVaYlNyV0FWVTducTQ2STJld09uTzF3WTNSVWdnZER5Q3ZIbTZp?=
 =?utf-8?B?YmZKbHhKVjNqbENGSjJoK2FaN2hWQk4wRHNRYlhnQnFqRTkvQ2FvQnZYU3Bo?=
 =?utf-8?B?aytvRnk2OUdhaGl2dm5LZ0tKcm5abVR2RU1jcTE5MTNhYkM1WjlXS1o5SFJu?=
 =?utf-8?B?Q3VUcEJBUmYvYWNBQ0NYd1FkN0EwTzBlZEpBWXVQTkJwRVNUNWZjeEcyOHNY?=
 =?utf-8?B?T0lZR1A0cjJGSVZVM3VxOTJKWi9rUU9YeStoN3lPVWxGOEJYU2wwY1NtbUFE?=
 =?utf-8?B?Y1QyaDdRWHFpQ1hVbFRnckQxQUZIaW5jUHZHMm5vU1lmd3U2eDcwcis1Z09k?=
 =?utf-8?B?UTZQNkc2UjJLSXV4bVZ6SjFSYU1QbC94Q2VHSHY4bms1NVBJZmFBMm5na3Yw?=
 =?utf-8?B?NCtqSXFwNHpOSG4vRE1CS0lYQ3pyeTFYZWh3TWU4L1RHY1QyOUdKVUhRQVVM?=
 =?utf-8?B?bDg3Qks5NjBPRXBNbnVJd2VjV3NockFZSVp1S011MENJenMrRng5dG9YTXdN?=
 =?utf-8?B?MUpYdW8rVkZTTWtTSkc2QS94cjR1Uk1QZ0gxdURON25mY1VNU3ZLZkNWVFhm?=
 =?utf-8?B?bUNLbnNUeFhGKy9XdjV4elJndDBDVUpzRTZ6Mkc5WTJmQllVUFJBbnhMYisw?=
 =?utf-8?B?cnE1L3pYM1hFaFBXYzdocUtuSGpweHpVdkRhZUU4ZTBwRlFDSVMvazB6cXNX?=
 =?utf-8?B?bHpVMXJGbGJMd0pBVDBJTncyNjRmSWtDYi9nb2VnV1BBMnhMOU15Vi94Yk05?=
 =?utf-8?B?N1VpWUI5RlBFU2F0T3E5TnRjVGxUQ0NDZUdHV3hKV0pwcm4ycU02ZVlqTjV5?=
 =?utf-8?B?MEdvdlp5Vzg2UkFkeEQ5STBGUXNzV2kydVNQUFE1TU5GOVZGMGFUeThhNkRQ?=
 =?utf-8?B?NWhKd2NtTjFaNXlDRTFrQzBDZXNPdnVldmRZbkhxRWZxNFhVRGptMkhUdGx6?=
 =?utf-8?B?bmtISFR1SmtrM25JOEtndDZ1WDR2QUdycTZtRVMwZmpxbnFseWcrMVJ5cGxR?=
 =?utf-8?B?eVhJdVArcDFQSDFNT1RrTzdWTTgwMXVGNVNIY3hFb1dMMUhNSThpcFRoMjQ5?=
 =?utf-8?B?RlZPaHJDemRmU1BlN2NibUlQaGdoUzdoYktmRDZGMzZpTmRDWTFuNy9VY0JX?=
 =?utf-8?B?NVdFN2paaTBIeWtrVnBDYXdXU0Rmcm9CSU5mMXRzemhVNTV2ZEMrRHFkMzVy?=
 =?utf-8?B?cWVES3ZsQlJPVXFieGs4TFFkRFVIdGVRVmlVS2F3V1dQL3hMc2FhV0dyUmhE?=
 =?utf-8?B?RVpkZndtbHVqVWpHY3FwaVgrNnFGUUN5QzFMSm4yY2I2UzZvMTRsUkZ5emJO?=
 =?utf-8?B?U0hxYWI4bTVETkpxc21OdTd6c2JPTXN5NkRpM2xrN3g0cEdndVpidUNvYzJH?=
 =?utf-8?B?UkdPZ3dEM1pvd0tXTDB5dnhucm1XdWg5T0NkMUxCdjhCNVRkN21DUXpmM3Mw?=
 =?utf-8?B?OHFjS0t6N2h2NWI0TVc2S1hDazM4aEdna3VGeld5MkRucUFMUnV3a2xkYnZo?=
 =?utf-8?B?T0FScExRbXQ0V3EvbVFGbHY4cG15cGNvOWdKcXVuU0E2QnR1K2oxQzdkR0JN?=
 =?utf-8?B?Qkp5SEhsYkcvRjVpdGtWSEJmMzk5cjFiNTM3d2txUWtqUlBtYnJhRXo2bzdM?=
 =?utf-8?B?cXVuWTg1RXpVVzh6OHZzWkp6Y1ZvVFhvTDBldXBqdlc4YWpLeE9xVGh4dWxI?=
 =?utf-8?B?WHdpVlVlR2NnTG1mNUVsQW4xRmF1U3A2MS90UnVyMHhWbW1tb1pmOGRxQlB2?=
 =?utf-8?B?L3dWWm1ERzkvUGtMMXpTL0paYXlZcGJuZDVoSTFncU1TVll3YlNnelBHbldY?=
 =?utf-8?Q?ptSQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjdiQm5ra3Nydm8zUzJVci9QOVovZmRlVmVnOVBJdDRQSWFSQVZLNnQ5OWUx?=
 =?utf-8?B?YXN1ejlINlBuY3JMRGRnU2xUdFlRNmJkSjFhbDBiQWNlVTV6VVJ2WUtyc2ZD?=
 =?utf-8?B?THdURVpJdHdtV3ROMzB4UVJIcXZnTVVYbG5uVEsrbVdZc1RUVmlNRXZDWFV3?=
 =?utf-8?B?ZVhqVWhKNW5PSll3c2lvZmorNHRJU2tVZjJMR3g5c3hwVzdMMW9PMjJpRXhJ?=
 =?utf-8?B?L2FIaGJDMFV3OVZCODFsQmhTZDFyTVBZdlIzWUpZeVVDMVRLbU9HK25FTy93?=
 =?utf-8?B?T0RuWGc2RE5OZC82dzBEbjYxU2MvaVdaTE14ejFWQmpreFVHQTdLUkVLelhD?=
 =?utf-8?B?OSt3ZURLM1dLUEZJQ0pGMFNjZ1R3SDg2Zm9IWmpjM08xR0NaU000anROb0Ey?=
 =?utf-8?B?L2grMDlTR04wQmk3aFJaR1E3MUp2ay9Ubk9QLzVGUkRjRXhORHNSYXVtYkpZ?=
 =?utf-8?B?d25EbHdaRk9hejJwdDZXVmwwN2ZQbk9XbFoxTnJDRzBsaEFTdmNRTDFReis1?=
 =?utf-8?B?T01FTlpqVjVsU0FwR1FFQnZEMUx6UkFTVkRBbzVRc2NjRDFTS0srUGlOaERW?=
 =?utf-8?B?N1RnMld0c1hYRGNoVHBLLzIrQStOVjZSdjc4WFQ1bmx5V3FzZHJ3MFgvc1kv?=
 =?utf-8?B?NFo2bVd3a0VHamloUUVuYmx4b0hxSkoxcVNRTkZrS2praW83Zk91NmhmRG1D?=
 =?utf-8?B?Q2JCU1E0RTBEOTA1Z3BMcGNQTmdZT09oUVRMVTBFNTRCaHdUUWd5S2JTUGNF?=
 =?utf-8?B?NytHelo3L0QrSEMwMDJXTTJKVVk3ZkU1dDl6QmljUGo3N083bU5nc1hhWDRW?=
 =?utf-8?B?UVhBcGZMZEFzM3M4RnhJSE9tc3lVdzRPajhqNU9Xb05iY2lKTmh6R1ZXK0xB?=
 =?utf-8?B?WEZ5S0tGcnk4SEd2WjVtYndRVlE4ODFKN09TamtibGdFUEhTL3J5WlB6emVX?=
 =?utf-8?B?cStlMFoza2UwRlpHdVBDYVQwUk5Ya3RMOUd1SWc4VmZNeEpjUE5hVUJFYlJv?=
 =?utf-8?B?RVJXWkxoRXNINGZ6V1gvYkQwVlkyc1RLNEhacnAwblFVeXFjcC9GUm9tWjhE?=
 =?utf-8?B?TzNQZksyREJOMlJpTHluMCsxcjRqVTRVQUFFaWVLQWI4dFhoWkVvM3g2bmdh?=
 =?utf-8?B?emVvSlRuRDE5dVAyU21udGl0VlppaFp3RWV2Nk9MSlFGek1CZC83bzcwOXpQ?=
 =?utf-8?B?czZ1Z0g5N0NpekJJSkF5Yjk0cXFpOVAzRGEzaDV2T2FiZThWNmtURlhxSWZB?=
 =?utf-8?B?YmNoNTFuNmJBeHlUUjU5REZZUFhnR05uVlI2RDVFcktOWk96YlJQTWVsaGlZ?=
 =?utf-8?B?Z0l5bS9VNDNuWjFicnV0YkcxK1JCUC9BM2dGdlkxR0syRGd4eDAzRkRHWlZ2?=
 =?utf-8?B?V2loM3htOTNiZDFoR3g2K0NpSkJUQmdLcXNpQjltMWVnb01NUURuQXRpeXAx?=
 =?utf-8?B?Tk5mMG1Wd1pJT0g2Q3dlVEpQODZTTE9oUjhhZ3k1cHpDS0JmUHAxcERpc20r?=
 =?utf-8?B?TnlpMmMzQjNyUTlCSjJlakdyamduQ1oyS0NzOUZLODNBS0ZSOUl5b3R5UGVY?=
 =?utf-8?B?c1k4UERvejg3bnRkTkEyRmlSejFNS1BOcno2SFNiTm5uV3RsRVFtUjNaQi9V?=
 =?utf-8?B?cFNzVHZPa1d4dmtwQWtTLzVPdjlPRlZIZmNhcyszaUgyd3IyMnY2akgrWGVP?=
 =?utf-8?B?UkZYdjJZeEtUUmw0UUxzZWlHczVUUDRxY0RwTklFSURDUWJ6TGJCa2VwWlNl?=
 =?utf-8?B?dUFtenY5a3JMTjR0YktHbXIyVTQzVm5tSUVJSm9wZFg2N2ltWkpmdVVLaVdu?=
 =?utf-8?B?VEo2bGZBSkxzNGVBNk5hejgxbWdkMm1XTy91d3pYQXM0enA1NkJucEtYQWZ4?=
 =?utf-8?B?SVNIbERZSDBEMzQvalNCZkdHT0JrWDVZZnZ2dG5FWEQrZXMvUG5lVVlBejV4?=
 =?utf-8?B?UDFpSng3KzZvMkViWDBvZUo2K1dhTm8wZ2wwVnBTU3N0TDhDUmQvNkZKSC9r?=
 =?utf-8?B?WDl4YjdZd3N5U1Z0RDNMcTV5L2NZSnduaGQ0Y091T3BodVpXT3hXeXRwZE5B?=
 =?utf-8?B?aGFLTy9BMWNQeUM1WUVUYVlNeGR6a0R1Yk1oY2RhMWlwa1kxL0tMQVBnWVR1?=
 =?utf-8?B?bVNPOEdUcVFVc2M2d0prY0IxRTJzZS9zU3hlazdTV2tvajBmNmNqY2RYUVB1?=
 =?utf-8?B?blF5NndRWFl4ZUpVeGNoNkNQaFVvRVIyaVBmc3RGNklTeDR3QUZydi9QQmRV?=
 =?utf-8?B?TEs3RmVVUkNhRHhrNFR6ckN3enFXTmZ2dld1bEZhT2RFVDJXR0dzNGlUR2FT?=
 =?utf-8?B?cDd3Ymc0cGJNaWFVZnBLVzZXb2pTLzFwNHVXTVF5WnpHaXpiMzRUdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 054a3ed5-e6f2-439b-7caa-08de59ad067c
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 11:54:40.6850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAesRjjLSOc9YUNaKL+GTM/x9Z6Bh+HGvPSflbIbTmeX4NihdLYTn1Aho7BFIm5hN0N6S4Qm1x6/J+XqC6P6AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5969

On Thu Jan 22, 2026 at 4:30 AM GMT, Alexandre Courbot wrote:
> On Thu Jan 22, 2026 at 5:22 AM JST, Zhi Wang wrote:
>> Refactor the existing MMIO accessors to use common call macros
>> instead of inlining the bindings calls in each `define_{read,write}!`
>> expansion.
>>
>> This factoring separates the common offset/bounds checks from the
>> low-level call pattern, making it easier to add additional I/O accessor
>> families.
>>
>> No functional change intended.
>>
>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>
> I still want to eventually switch to a trait hierarchy that removes the
> need for these intricate macros, but that's a few more step ahead. For
> now this integrates well with the current design.

I am not sure a actual hierarchy is needed, but the suggestion you have to =
add
`unchecked` method and have the bound checking be part of `Io` should remov=
e the
need of an fallible and infallible variants.

I think we still need macros to actually dispatch the read/write functions
anyway as they're different for each access size.

Best,
Gary

