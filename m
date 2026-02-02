Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021096.outbound.protection.outlook.com [52.101.100.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEEC36CDF4;
	Mon,  2 Feb 2026 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042432; cv=fail; b=L333v7WFR8Df2ozmceVRPRcGe2DVz116zp3G3LqV2NzgTfEzGwnmpA1Doo4n8DyaLb8eKk8+b+EQHsV+DteZqWs4stu1D8NmYvnsCVKBZ2zL3yiLy7dEDIPWkNvq7m1r0GSLWt2LPJNTOrA0l9oUwbhRdlSHpChirdc2FC9GAow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042432; c=relaxed/simple;
	bh=4R2nCNEib6rjw3Wp6NMJDHbZ/GuGYJQJmqi7sWZJd7U=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=geOs4t5Hj7B/c8GJ2tcnC4iRpxjY02GaUOfq9erzZuMbN6HuOk6Ibnu6u0H3rW8oEuKMn48qjsARymoq92Ce56Q65aD6OodmabfcU/KtIu9+E0IRAKXF0c/3piInQ+K02X+Ea/7rMAxazzRmAnyV0UlkCRL9K7DV2pwVMyvXi/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ZUi5oT2m; arc=fail smtp.client-ip=52.101.100.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ZUi5oT2m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrF4E2zZ9FsyAbKT6zj+FV6l4pnt3/E6ZvpVK9/bH3xVRhv/i67iCXtU6f1QIHfpBj1PFaY3iwFC45BLQOi6llustjgZHWISR7bWnDkb23eaUK9MdbVhx29f5+gsrRWE8ZW6pz9w61lm5qsBbzqdtC8QPkvh4ghzFLfnyob0+sFmOSq44E2ovIViTINSjvq5hQ4GcruK/oUiX4Xw037DngEfto74+Oy4nzvZSb4X5ZontZbo4BsiuOzGT6otMKQpOR0Req2KhkZibCCEXQQF0mvUo6zIxYkNoO/r2+OBGcOmCxzstTxUWxvu1l/Bc7dPBwxedk0tHoY7UZXx+vZAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7QTdiF8TVKsGj1C67X3fI/KjjGnC8R9PH37y8AuytI=;
 b=bxpYZp6z3tRh4v6IirZppgHQLlAJFLiDpK7IkFY4/yZ077A8KhCcjIKJ5vy8sJudstSmOwDIXjBGPNa+sHnSQw4JszuiZbPQXS4ienwauictYN6vllnPeKOTzMNUrFKa9tkBtfhg9qlBv5gltHPMl9CUzG7ZJDqICL0d2umigiRrU+AmfRHOZqnNQXVDtCeUXR9fQ8tCuWElypSILk+DFNN3d1xBjB/1FaandtdVqKKBzq0TE1mzcCmpANfbOzlbtAYUbXn3QiXWHlmBGX3w7R1tbMwQoP3KD4+jzvLtBnkvvXX7sw1luPaqQgJmJe3dY47xPZylRUygvmu1HD7k1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7QTdiF8TVKsGj1C67X3fI/KjjGnC8R9PH37y8AuytI=;
 b=ZUi5oT2mLqZNzeHphshxkfbpi82JNoUb9UB6plSyhYt2BYK31KqavxbvH1+5wkfObbuGTMgaydcKlL3PlzzFjVg/3/Zc/g8G9F7QFQ4QE/+9Ip/FPAUalILHvmhSip/hyFn/YJdvd+S9mNd2C6b8nuZxdEiAXIt4QmhMf8wLYeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3612.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 14:27:05 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 14:27:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 14:27:04 +0000
Message-Id: <DG4JO8B5SDZU.34MP0GJ9G3J4F@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Lyude Paul" <lyude@redhat.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Subject: Re: [PATCH 3/6] rust: io: provide Mmio relaxed ops through a
 wrapper type
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
 <20260202-io-v1-3-9bb2177d23be@nvidia.com>
 <DG4J98HVOUEX.I7XOB7LPB49L@garyguo.net>
 <DG4JHKY0Y19S.24TZ7TAX5ISD@kernel.org>
In-Reply-To: <DG4JHKY0Y19S.24TZ7TAX5ISD@kernel.org>
X-ClientProxiedBy: LO4P265CA0077.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3612:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbc382a-87fd-4cd5-ef17-08de626723a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nnh5WDU0RENadU1FcFEzZklHREs2R2toV2pWOU12SnZuVmxDaVpnNWs5MUhR?=
 =?utf-8?B?SGhsYmpTZ25PM1dlOVNJLzFFcXpXY2d3dlJRNUp3MmE0bE1PZmJPd2NUYWtk?=
 =?utf-8?B?L2M3WmJlVnB5aGZ6UkRxWDlNeWVIcVBtdldPc2pXNGxMcFBVWitLbFJyVDNR?=
 =?utf-8?B?Tkd3QjRKM21lRVFBZE1SZ3I0MVRrUCtTdGVyR0kvbDdDRkNGREd0aEFWUG1J?=
 =?utf-8?B?d3ZHV3RzanRyRlI5ZEE5OWswZWxIbXdBT0FPVlFvL2dXcVhuRXhMZ3M3RkQ3?=
 =?utf-8?B?TnRubm43YTlKajB6UmpVY2Y2WXU2SmZVc0xFbHMwKzRodVE5V2JyeXBkeXJh?=
 =?utf-8?B?eG5McFdBMjhTQWlNOUg3RkFjUFh1THgrOXBTSnROUTBMSXpFNkM4OTNYOFBD?=
 =?utf-8?B?VldLTmhKMG4wS01wYlZsdGYrZDcxZ3NSazlraXFodCtMalBUSSt1dHk1QUtW?=
 =?utf-8?B?RFhpdy9kRzJ3ak1UemdyS0dUdzJSTWNJdVZLV3Y5VVdKYU5tNmF1M1Q1T1dz?=
 =?utf-8?B?ZTNDOWZWMEl5K2FKdzNtWGFiL0lnMFFBcFVoblZSMXdnVzhicDJxZk5uWTdZ?=
 =?utf-8?B?MVJkenJ1RnRPY3AxdWMzdkh4ZjdoeThSeXZGeXBJRU52bkhKeTBKenoxRnFC?=
 =?utf-8?B?Y21reVBrUi8rcDEybEJGTkN0ZWpDNHJhNnJhTHJoczZueG41QjNGcWtTS1pG?=
 =?utf-8?B?TjJZd1E4c3c4U3FjU1BSWnZyWGVZQy9sTndLdUFadUdJNVRmOFNJeWxqMjYz?=
 =?utf-8?B?SEQzRzBNQjErcG92aEFBTE5GUUNYUEtKeXVxWEhSK3dWbGdNWTROcklVbEZ0?=
 =?utf-8?B?TUsvZFBsbUtBcS83OGlJcFc5bG1xdjdockVuVUJmZWpMVXcyUi9xR2ZDcjlN?=
 =?utf-8?B?ZG9qUDlXMURSYllzTWVwcFAreU1IenhYbnRDcWxHd3dYOUYrNDVzN2wwNUpv?=
 =?utf-8?B?NUpxdE1pcU1kM3lZaWNRYlJFQlQveDJQR0FsMGhkMVMxSjlOZ1Z3YUhKU0pX?=
 =?utf-8?B?SW5mbUt0M0tsY0tUMnZjZk04SVJkaytOd05qREJRenhvYkZKaXNPTkdGcWF0?=
 =?utf-8?B?SUFEU05TWUVQTjIvS29BVCtRc1J0VWZDY21yOHlyVkthMmNFaUVOczFXaHI4?=
 =?utf-8?B?bW1NakQ4eDlVQkxWMjNvcjhCVVIxbURoL1dTZVF5NmxwVks1YVBFZkczNzRi?=
 =?utf-8?B?RG15d0EycS8rNi9KSzhUSG1MVlo2SmYzYjhhOWJmS0hWOG9BV2pKS2piTXVJ?=
 =?utf-8?B?U3paa0ptRUNRZ09PWDFHZVp2ZDU4N2NnR3Z3ZFM5Ky9iazFSeXEzNzIrc21V?=
 =?utf-8?B?dWc3MzZvRVNSd1ZWMTl3TzN1ZnJiY3I0aDl3U3d2dEZHVlJRcGhlNjJZbk92?=
 =?utf-8?B?Vk1pa3hzVWJlQ2VRbkFZN3R6WHAzam5IV2tOakd4OUg4QXV2S3ZpdXZLNTRo?=
 =?utf-8?B?TE82bElkM0E1UzhQcGFUUXhoQkdUekYzTGVOYzRtMGZya2NvQXlPR1h0b1py?=
 =?utf-8?B?N0FJUGhQdGxHWUYyeG9NOUl3RXlhOUZRaURyRG9ZZGF3YmdtSXJOeDB2WXdT?=
 =?utf-8?B?T2lIL2VUK08wUldaQjJSZEhqUVpLbUE5dkd2c1V1a2xVSWFSdG1SUG4yVUt6?=
 =?utf-8?B?VUZiangxT3pJK1oxWHhDZGQ1MktacDk3UUdiV055VUI2VFdiNE8vZ2lsQ29r?=
 =?utf-8?B?MDRlQllBV0Nrb0VCY2IwT3QzSlRxNlFHeE1sM3h2VGQ3MWcxRVlQK3pQVnJE?=
 =?utf-8?B?eHBLMTNtZkhTY3Y2WGRqcm5VZVB4eVliZVlMdFVWTUlVcFF0S1ZZZGpBdXJU?=
 =?utf-8?B?eWpLNFJhU3ppdFVwUG1QWGtTR3Zja0p4SlYzcWxOUEJ6Vis2VXJ1WE5Wbm5G?=
 =?utf-8?B?UG96eTNiUjZSQ1JpenNLeXNzK1YxaVp0RW5PZjlpMUlJMnJHZ0p2T3lHZ3lt?=
 =?utf-8?B?RWJmU2FwLzRoSnZ3WXdmZm5wNlVqdldHNGh1YitaT21kbHFYNld2Y1I0STM3?=
 =?utf-8?B?bnR6ZGN6SVAvamMxR2poQUErdU9rdTZSc3RiQ3ozVFc2OHd6SjV0MCt2bisr?=
 =?utf-8?B?emtST1lJNGpiOE1iSjZabm5EaGJ3RTMvTUFvNUNYRGIrNlZKSjRNSExmaVVz?=
 =?utf-8?Q?UGmY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkxLNkRaOEI5UG5ybUtaRnNJSzZIdWMya1k4dkkyeUdsVHBzUmttd3dPdU1V?=
 =?utf-8?B?czVxVTNQNkZIRk1Hd0NvNm92UTNXa3Y4N3JDS2FYekwxVUxxaXRmeFJqSFZq?=
 =?utf-8?B?UFdnNTh6Mms3UEdsSCt4YmZZNmlmcTNSZjVZZnpqc2hucnVBZ21XeDh4c01V?=
 =?utf-8?B?V1l2ek53SWNObkppYi9pSjg1NEJaRjR5eTM4Z1BoZzRkcVJ2MWNqRlZUZnh1?=
 =?utf-8?B?Tm1jTTdEYmN3eHFSWEZlYko1QTFobEFhTCtJYkovOVZTeFBEMlkwUnlJZ3k5?=
 =?utf-8?B?elVzRXlMY2ViTHR6b2ZtKzJlRzd5VHVVYlJGUFdDQVNuZm9HY2dqODRhK2hn?=
 =?utf-8?B?YXpXU2NiNWdSVVBNQ1I3alhuaGFOcUhaUDFpWHVrb3RxUm9tVnV5bjlZcmFx?=
 =?utf-8?B?NnlQV2tGSVNmdkVQRWxGZGFjUmV5QnNSRDkxbzN1Z3g1dVg1RXUrdCt2SFk1?=
 =?utf-8?B?M3JGTS9HblVHc2l6d2NWZmU3akNSQlh3c2diKzRCeTYwTjRtQW01VERYUm5I?=
 =?utf-8?B?RUlQa1lhb3BUNW0vRU1JZjNMbDZ0bWR4TkZMV3VTRGJuUGMvTVorVm8xQ1kv?=
 =?utf-8?B?cWxXcWM1WC9FNitJR1k0VCtEYldEVnFyL3BTRks2MDAwSnBCOC9WcFp1NlZy?=
 =?utf-8?B?MGd4RWtBSSttMzYrWlF0cTk0czJJSjdVN0ttY2ExK1lIR0I1bzhjU2FVQUtj?=
 =?utf-8?B?S3JJME8vUFJXTlZlR3VOZ3B5V1daMy96Z1FoYkF3N2NPWU1Nci9mR2ZtOVhQ?=
 =?utf-8?B?NzFLcU5IY29iemkxMURMNTFWVlc1YUVLQkk5bmdwb2xvd3cwV094Um9tQkNx?=
 =?utf-8?B?RVJ6S2E3Y0xvYWhBblljaEpBeGVGT2lmbE82RUpiZmpicE00aGNTL2hIS2pl?=
 =?utf-8?B?b2FCOUFTem4zSHVGbUFpb2dwdnFCUlR1S0lPMEU4UTVYcUtYd3p4Nmk3WTNV?=
 =?utf-8?B?c1lzTGdORTViRWd4SnZOMGNrbldaR1hWZlBCTHN4clE2czkvRDJIQ01idnNy?=
 =?utf-8?B?UStuRHFUWm1rQVRIcGpBUVg1Sk1ONURmK2RCbTdWYmdnd2pmQWltNXFEaHBM?=
 =?utf-8?B?SVRIdlNUTytlSlIxWWIreTN5dHlsMFpiUGNCRnQzbGJoVnYwYUpxdEVwR3R6?=
 =?utf-8?B?WHRPdG9jMFBNYUF4eWxIUlE3QU9NenB2cGdKWUFUbHNXZ1QvTzFGZzBMckdU?=
 =?utf-8?B?Y2xta1V0OTdxRzgzRE45NUxLTHJodkxjc2JwMmwydnM3d0JDMm1VL3pvTU9k?=
 =?utf-8?B?ejRNMHN0b3BCN1dyVWFmZVNiT2RkMzYvdFU3SkNzWTdKUTMxNDNjb2NMdTZC?=
 =?utf-8?B?Q1BScWNCMWF5UG9NbVp2cG9mRXJrbmdxckcrd3ZhM285dE5yN2FuSC9PYTdx?=
 =?utf-8?B?QnEybDhoUnJ4Y01JV01KUDEzMk9GY3NHUkcrYkVmMEF6anBzNGdWWUNvalJQ?=
 =?utf-8?B?aHRMcTNneThCK1NweXZ5bUUydWdHUkNjMXQrTERPTEYyekwwcDJBWTFwcHBU?=
 =?utf-8?B?c0lxcWgrbXZPYzdSS2VIeUI5UnNqZUNPWVlRZ1RXeTRsdWMveXBRMjRFS2Vh?=
 =?utf-8?B?cFNONURpeUhtMkJ4c21JcWs3Vjl5NFNLUVhiRms3QmMzSnRzMUZsd1Y5dFRZ?=
 =?utf-8?B?QWx1ZG9mSnplM24vVkRCRkZaMmFQYVMrL1FVWlhaTDdZM0NtcEhLaTVlZ3Rw?=
 =?utf-8?B?SWhha08zU1VueVdNNUVZYUVjWnhtOEQ5NmJudWlVcDVwc09TYjZobzJrNVZD?=
 =?utf-8?B?Zm1wNVVRY2ZyQVdRbjFwYm9uYlc3Z0pCYXY0U0U0c3lac1ovRkdIQ3EydkhQ?=
 =?utf-8?B?azJEZXU5c0ZzbjdzTXN4NGV5OGY5T0FweUdRRFQ4R2VmMHBWQWRORlo1UG9E?=
 =?utf-8?B?UW1yY3FEZEdZNzFMdlhNaW1lUDAzUTVwM2R5UCtXWFBHVkdNcVpTS2FoMXlq?=
 =?utf-8?B?YTBRUWFWUVpEN1NTZVVydXhXeFBtTlBPU3dJT1BjeVVGR1M4RXZTd2RsOTcw?=
 =?utf-8?B?NEdyaFhIRlB6QmlyVWpGZ1p6cnlCaGF5VHlHMEdXK0NXTlNhRFd3R3Y0NHpn?=
 =?utf-8?B?TUtSano4eXpWei85TkZzL0NoVjJmZ0gxRTNZazBzS3FETVFqVlg2YnhUNWhD?=
 =?utf-8?B?ZmRMU2xLbVI2MElIVWp1UkYyRWNQcXAvSzJtSmVaVjVBSndPdmxVVGVCNS9R?=
 =?utf-8?B?anJnREVjTEJVYjNLaG9LaWR4dTVwQTFKZUd6Z0RmWW5Ya3VzRm9CcFpmeURJ?=
 =?utf-8?B?R25aaG1XY20yYzI0bVZWaEJJdFpPRzFFTFRQc0tCUUFqWE4rRHlZaEtFSnB1?=
 =?utf-8?B?d0Y1WFNYcXlhOXdvbW5Xb2xkMW9mcGROcFRNSDI3Q3NhSFVrcUh0dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbc382a-87fd-4cd5-ef17-08de626723a5
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 14:27:05.3594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLgjT+Nn8KvlXGXx0TjvFYGIPpVjD+q2wkEo6obFAFHUXyP5khFYZGWLrKx/nPVoFmZIOlazzmxBJyC33P/kqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3612

On Mon Feb 2, 2026 at 2:18 PM GMT, Danilo Krummrich wrote:
> On Mon Feb 2, 2026 at 3:07 PM CET, Gary Guo wrote:
>> I think ultimately choice of order to use for each I/O access is local t=
o the
>> specific access, not a global property.
>>
>> I guess one alternative design is explicit order on the access, e.g.
>>
>>     io.read32(Relaxed)
>>
>> Or
>>
>>     io.read32(Full)
>>
>> however this is verbose in some other ways... I'd like to hear how Boqun=
 thinks
>> on this one.
>
> This apprach would be misleading for a lot of other I/O backends. For ins=
tance,
> the I2C bus has no relaxed ordering.

This is a fair point.

>>
>> I know you can just do `RelaxedMmio::from(io).access()` for each single =
access
>> too, but it feels quite verbose.
>
> mmio.relaxed().access() would work as well.

Indeed, this looks nice.

Best,
Gary
