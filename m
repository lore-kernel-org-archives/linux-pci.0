Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA77324B3B;
	Mon,  2 Feb 2026 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020008; cv=fail; b=RRy1QRQGW2n2pThS4ho53dyR9TR+1EFiR4dHXoAU/D5xDrbEVDo3boZvtiQL0d/UkGmFzKaPEOOzzWJs8xBKoRmztO6SJFJPW3wuqe1vqPwPQqubeo0MCmwXNyz0KYSx1ytteqBqDGRI/vIF/b9g9Mes8ktRt6wIAVhUdepzruc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020008; c=relaxed/simple;
	bh=T7ska3ylZ5PJgsdJwRf+gQEtd4XDK1FMVH7Bzlv9fiY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=dHcn5bYoX748VGEXq5mADJpoDl6uQAGToPjQtRgGs/N8xQ/L4NgLmmQDf6obX4CMy0GlYWdmUTm7lQBn5RyQczuSLk5/wG3uDlSInQGm7WMx4wnYumr8t0Mptr4EW8xmS5pMmw8NMDptm2IqVOIxRA+EycueJxwWlKJ5MdT6GhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C1LS5fsy; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C1LS5fsy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVWK170QfDM01ioR41Jkmxsm2SiHAf3yCopYi316kObjgPPDCnFyEPq6/SDu1RSWn3lM0l8sKnUpCqn2Uv5/ubDsWBh84bLyD7inCoiY8nAf8Qbrs7B/n/yUcqL7pB55HOkppnSeLrinmba6yqSrjMt+OCyx+kj0Zrjs/QQ0cDvPbf7n03HsG9zjbJPbAqo3RBHL3UxYe1G7h98eqkuL+uER7ebdTSgd1cltZRCnoIFg9kZJJbc76Xsu36O6IBb4svjF0n8RckxLEFBAEP2skh3GG0Yc1nP84aYmfvfBanJwjp+DLGRSJwvYBNe5wyx1im1PeqJirkHrljhmHAormw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmWAHtJTApPxEBOx0OAIRu/05kwjIIIvma1uvo/AAl4=;
 b=qnHn5hL5Ie5LH9mjtXm5WPfwqe1tRpjNTnPtwr/fOctO9hyamZhXaxX+FKpV8VBbzhTPvxoCeQ/CIkA9GaV5k98DaaTX5LClzwCJf1Nf3ALq2cDhIb7kEASdFHz9hpTtef4ZSYUOYSszIdniTZCFntwQZn6/0vnswpqDq/lggL6hkoJc79oJLFME1g/lx6Iv1PGGNxQ4eW773AkbSzWDLaeRk2j5W5UKB5u9y89AEhWnkwtEBdXc6OIgd+HMI7m1HzscRhPS2apFpiT2PvWTQjSh3RCHdErLGy2hZZJPxdUd9wEo2oqJqm63bp/ty/SsqK2OGqrbpjHlO/zBfu6T3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmWAHtJTApPxEBOx0OAIRu/05kwjIIIvma1uvo/AAl4=;
 b=C1LS5fsyNfOh7eUpK3t3QAvMXy7kOXI7oayzA91K1iu65oo3h/KKGgVhDA4NTW37EphZTW6SMxh0frre+UXA38uOXqIUsVwrXdKyBHoRLj2vSNUB57bIGJcSZ/VvT2AT6ahK29q5FGgts0zH2SZ6V6hF0e6Gw7jH7q9smqnNixEvTvVJXrYsiqgbZeITEW2Ii1gxZenWPMCL6AR83p5mjYOk8+u3LyW9pWCrOnAGGQClsNCDJi3ugpCTooC5lVwXwRxM6ZlIB+Doizlyec/BOZFQ7djkfQiAwWvlH93ZEwtc2e+T59R84UdFDTchbLQhxPaDYRHGyL/qXbBanSFmwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Mon, 2 Feb 2026 08:13:15 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 08:13:15 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 0/6] rust: io: turn IoCapable into a functional trait
Date: Mon, 02 Feb 2026 17:12:59 +0900
Message-Id: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIKGbma9rYZiWYmxmkWZuamaqBFRYUJSallkBNiQ6trYWAOdl9NVUAAA
 A
X-Change-ID: 20260202-io-81fd368f7565
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Zhi Wang <zhiw@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d71a0e-c618-4957-8362-08de6232e942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnRHejl6WHpSUDR0bnJwclpWVHd5VUxnTzNabjdCNCtTNENjSCt1cFZwbWtu?=
 =?utf-8?B?WTJNQ0l1MnRSU0diZVFXYU1pQlNMMVZTRkt1YzRHbEVjaFUyQ1FvUm8rTUcz?=
 =?utf-8?B?MllER3I5Y2NvWEJ6TDc3LzQ2V3lkVTdGaDYydDV3VUtPNU5yb0czZzd3U1Bo?=
 =?utf-8?B?Qm93WHZURzZFdjgxU0RVTWZ5L3Z0L2hpSndUQmgveDloVDM2TCtmMm43UThm?=
 =?utf-8?B?UUljNEhTcFI2NVlvSHdmSTdNSllhdHBUMGgrbSt0eVM4SHRZRVpacXE5K3VJ?=
 =?utf-8?B?bkphSzBrVTRpRklPUDlzWTMzWkdZZlhUa0l2OWk5eWg2RmJxZkhTK3FMazcv?=
 =?utf-8?B?WVNickJ0Z25Ra3h2dE55TDI4Z3Y5dVpEcC9RVzJ4SXRCTi90VUhFODJMbXR5?=
 =?utf-8?B?Q1o4UjZNSUVQcDdLOFEzREU2Q29QM1JqMW9GV3dYLzMyeElyUVpPL0JLeWtu?=
 =?utf-8?B?djdRK2l6dWVSbjF3Wm1rdk1jekw4anJFSXBDS0V0VUJCOFhvRTFHYUFkS1Y5?=
 =?utf-8?B?VFdaTmRrYVV3UW9PUlc1OGM4R3FpWFIzblBGZWlHUkZkd1dRY1Q5SmIyYnRI?=
 =?utf-8?B?WWkvWXd6aXgxYW1heUd2Z214M25ESzQ5U3BDZjJFeGNjOGIyM3FMMHZxbUJs?=
 =?utf-8?B?NmZEM0Vqdno1anl1b3BQZy9kTWhiZHhPNm5KZHJ4QTJMR3ovdTBjV1h0NEZm?=
 =?utf-8?B?amJ3T0hmMnR4R2VIeHNNZFFYNUg1cm05QlNrbXdQV0ZpT3ZqaFd3aDBUOVN6?=
 =?utf-8?B?WmNWZ01QWEtLeUtXUmd0V2s1ZktCWDRnT3g5VkR0MmRDOExWNzFaN3E4OWpp?=
 =?utf-8?B?M251MDNtZm9mUUJRSzhpN0pFMjNhT0VQYm5lN1pqQ2hsQys2S2x5cXB1R1hP?=
 =?utf-8?B?OE5PZ3BIa1g5dTNuM3VBRXZ0eG5qYXFOakpvTVduTHZaSDVCQ0VGMnZhNWNn?=
 =?utf-8?B?US9kZWFUOXhvZ0JwOHFDQXY5c1ZIekJFTUZzbUk4Ymd4dVRiSExOWW9hSDUv?=
 =?utf-8?B?YzJIa2pSbWxMdTlPTG1UdFJlQWNkalZUNmJGYWZKbWVFa2t4Q3V4RWkvNjJH?=
 =?utf-8?B?ejNCOWRDbUNXbzBwZCs1OEZwZmNQQUExcXdPWEdUN1haL2I0bmlCbnNqNHpl?=
 =?utf-8?B?Q3I5aVFKdDRvUmVDeUlYdkhzdFB2Uy90ZDloQldSdGNrZ094NHdIQ1hNUGtp?=
 =?utf-8?B?Vm1pUjlMdU9sRTRBMHA3Ymgya0tPb1FMTXVwOGRvemxNSzk5blJtaFQ2SzRv?=
 =?utf-8?B?b0ZHc21DLy9CREE0bzc5VVNHZUtZMmtodm5XWDA3L3dmVHVSTEZUU3cwajVh?=
 =?utf-8?B?clVaODRCSGRQQ2ZWUjBUYUl4bFpPQkp3TWV6YnBYRUZFWXl2SE03MDFsMUlS?=
 =?utf-8?B?NXl5aWs2VTNIQ0Q0akxSM2ZWL3lMTFVaMXZ3TVZBWElpUnY4M1QyZUJyVS9D?=
 =?utf-8?B?YVluRnRZSzVVNy9tRjgzeGh1WEhiOTVkSzhBdXcrZFNqZ2ZvWFRJUFRXVFVT?=
 =?utf-8?B?K2RNc1dVSjE1K3NoNGNMZCt4MW84S3BtbVZLdlNpMWFzQ1d3VUl0bE5iSnRm?=
 =?utf-8?B?cHduMlF3RVJTdmpFSGhxZCtlQldXcFVuWE55UzBkOTNVV3pOam45WWpFa2sz?=
 =?utf-8?B?VnNpZjcwa09HZXhtTHBHa255TyszYWk5Q3VOTEpqVDdaVU1lQ0c1UkM2VFFX?=
 =?utf-8?B?MlNtT0wvSTJqTGovUFRmdTJrM1JndUtUVDBJUWtkVmhiU2hhNC9TVmRCdnpI?=
 =?utf-8?B?bU93STNIZE5LSFhYT0Z1VXNFVFdMTXgzZ0tNYmN1SHpIMXN5bkFVZzN3TlZZ?=
 =?utf-8?B?K3k1QXA4SEpMdUxNY0IzT0d4ajg5cnVBL0NIeGlMUzZQeXdxVG4zZnhPdmlI?=
 =?utf-8?B?eHdWM0M4cEVaK3M5MFpSQ3UyUGkwekJYR1lWeUFBYUFzUUZsN2Y3VFZlZXJw?=
 =?utf-8?B?bnhSdTAvTDFkWE5xVUc5Ung2Z05ienVxUHhnYWdTcTdOUnFpbEhTK1M0N0Fs?=
 =?utf-8?B?dVdiS3lKbDNWdCtnZnhYUmtMTnhrdThIMUh5MkhYclRud1lmWGpvdy8zQmZ2?=
 =?utf-8?B?Y0ZqT0JBTk5YN1pjbTFMNnJSaTVBcVNqU0R6cnQ1b0RSK3cxeFJsQU9nemlR?=
 =?utf-8?B?SkxLeERpVzFabm9rQTUzd3FMQXk2Nk9WUC9PNUJxZm12ZFRYRmNodUw2aTI2?=
 =?utf-8?B?bFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1lUeklRMGVtcUdkcDVzWlBOWjl3cFhRc3UvZ0wrODRQSDkrcG1TR1lkcXJ4?=
 =?utf-8?B?TXkvZEp6V3pKQzJJUVpuT0tMcGZNbDRZRnRFMXRCMG53U0pKQXlaR29SSjlJ?=
 =?utf-8?B?RW5CYVpTREpsY2xiVEt3V0hqS3lUdm5RTzliQmpydFI3My9tdEZkblQ5OTNX?=
 =?utf-8?B?ODh5NVJCZFRpL3hhbEhDRmw1R0pLUjZOV3Rka05MbU5acUxHZ2NvMy9RUXN3?=
 =?utf-8?B?NmljczdHUFdwTTlla2t4TWFHNVQ4NVQ5SFF4MnYzdEJERUREMGJOR0NWL2Nu?=
 =?utf-8?B?SlE2VHRjWXdhUEd5Q2lYb040WGkvUmFHVUlyTStJUzlRZkR5STFHT0FLRWpk?=
 =?utf-8?B?Z21BMHJBNU1HdHNKRnRUVG9PQ1dBY2sycW95Q1JLSXcrbGp0ZG1GcExvNCtw?=
 =?utf-8?B?cnUxUzM1RjVhSE1DZjR5TENOY25TT3h1a2FDTUtWdmhQMDFJSko5eUFGb0R4?=
 =?utf-8?B?RktPYUs1MHpxc0R0M1RjTTdSSC90eVFubmdjQWlCTi9DSVVYdlJUbDdua1U2?=
 =?utf-8?B?dFVQZTdLMURjTjEwNlc3c2plNnN4M1JtVzF0S2drZVo5ZlQ5RzhkS0dlbHpR?=
 =?utf-8?B?OEo4OUhMd1hidGdnazk4MXd4ZzY2SXZIQm1tL2dBR2llRFhjZFJCeW5HZmVB?=
 =?utf-8?B?MmJnRWFZUmpXbHhtUnhyMjhXYXFnSXR3SmZZdVZhbmxJSDJRNXRQNVBhUjVn?=
 =?utf-8?B?cGZHYytOaDYyMVh0ZzVUZjkzYmEvZjBUaDI5VW00Vis4MUZCeUdXaGI2dmNq?=
 =?utf-8?B?dGRiWE9ibWoyNjA1M0lwWko3S251cDAvVmhmMWRpbFE4SXBZR05Hdjg1NzZH?=
 =?utf-8?B?eWJhOHBLNVBxUmtJU3llU2dKaENTNzBnUjBFWlN0N0xSem5CRC9ZMmd0L3Jj?=
 =?utf-8?B?WDNXY1JqU3J4V3Q1dGJLdGZ1Uis4bnNHbXdjeXBhYm9VYk50RkwzOVE5RmtT?=
 =?utf-8?B?UGRVRm5RVDB6L0FSY1VwNnJFdmZtemtpalhoMGRERmFLbVdvTk83djVtOVI5?=
 =?utf-8?B?REIrUEZITEFSSzlnSEF1eVpyaHFvL0lnL0w0MzV5QyszMFFTTURNYVhGZGFN?=
 =?utf-8?B?WHd3NUtCb0xGd094ekdHRjhZVmNPU2VEKzNtQlMrNTkrUXR5eGpob2Z3Q0hv?=
 =?utf-8?B?SHU5VHFIRktLZWFMYkplRXZrNVVjWUFmb3BxUUNNbmFacUZoZ09OMUNTUkNH?=
 =?utf-8?B?dGphYnhXTmwwSXNDQXhqNEZ3aVhqbEp1NHE5OHRyU05iL1RuS2JFbUxuTnJO?=
 =?utf-8?B?N1A1T3E3cklZcXVwamJqV1NsQjVGOWFaK1o1cTB0VmhLY0w1NVJlMUp0SER1?=
 =?utf-8?B?Zk9hdmlyU1oxMlBYQlA2a1VKdnVFU1oxTCtvNktEYkxlN1oxYVl5blNMNWd2?=
 =?utf-8?B?NUc5VmF3dGlOaTVqajJzRnJFU216OWhQQ3Z1NytyVmNuUjg0cncxdmIvdlhz?=
 =?utf-8?B?a2hOUDFBZy9NYzdzdDYxMGIyMW1ueFR3VW81MU1jYks3UE4yUUQyVmg4YlNi?=
 =?utf-8?B?OXgvRGs3OXBxUWw0ZENabzRKLzBoQWprb3JlV0VFQ3VONHlkVW5Td1cwL09O?=
 =?utf-8?B?SGFDSmRzT1ZDRFBZcTBmSTBzRmpFTFg3V3k2dVptZGcvMzR4QUpyWm5RWUFC?=
 =?utf-8?B?d1piZnY3WWdlemhZOFdHQ0VTMkdNMFY2RFNmSUxHSkFVb05xOCtCU0RwNEFI?=
 =?utf-8?B?eWttbUFTVWtFZHNDVG4xaExnYlM4Y3FRMFBjTmd6M3ZocFBVaFYwb2d5L3ND?=
 =?utf-8?B?Y1dWNEpudDN0QmZSRzQydVFrTHZBTlRudG42RHdUZEc3Szh0bWJXUjRFTEsx?=
 =?utf-8?B?dXhOaitQaGoyZGYraDZaSm1aTnpHRVhCNm5NRlRETUltaDkvbDhSdXZuSHla?=
 =?utf-8?B?ekZsekg3MWdLWUNSR0J5VHBhMnJKckFlcFhFcXc5cDhFaWMrMjRNNStlZU9k?=
 =?utf-8?B?WVdZVTBpNWNZdmN0eW44NmpwR2ROTTNsYThmUDRKbmF0Zi8xK2pBeWhpeHNI?=
 =?utf-8?B?K2l4MWF1RkZrOHM3Q1N0WWNMdWlFdm5sb3ZjUDZkU0ZSQ3g4Nzlqd0NESlRr?=
 =?utf-8?B?Zkp0bEJ6dklac0JyL1BoSHZHTEE4RExONkxsUVVTVFZNZU5ZOWRtL3ZPNGcv?=
 =?utf-8?B?eS92bEtVYm9ncTQySGVENUpYUXM5Rm82T3BHTnZTcTJzZy9hbHIzR1Nxbm5Y?=
 =?utf-8?B?NHpNQ1QzNENBN0xBeG81bXRQVGh5QnlFa3N3cVVyc1QvekFCYWJNMXVsRnBu?=
 =?utf-8?B?WU95Tm1EZnQ1NndBeFdwbXROdVBWM25yckMyaGxGVjFFN3pudEFySGVweThr?=
 =?utf-8?B?cnFCWGZOSXlSaE9JM3U1cElPcEFGM01Vd0dackRlS3NrcHlQYUFyTVR4a1BZ?=
 =?utf-8?Q?nR+4/Zh++fuwwQQ+Bzj3uM8TSAKsST3AiLopQqG6Uaa/2?=
X-MS-Exchange-AntiSpam-MessageData-1: gBD4Tgk2b3klbg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d71a0e-c618-4957-8362-08de6232e942
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 08:13:15.6903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oymVe0f8yg3pTFal8LB/QZnVENIFaHoTVAskqIejSbXdR1vmeGSsQ+ZUExSm3jyj5FYnIHbj00eBt5e14/sqVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416

`IoCapable<T>` is currently used as a marker trait to signal that the
methods of the `Io` trait corresponding to `T` have been overridden by
the implementor (the default implementations triggering a build-time
error).

This goes against the DRY principle and separates the signaling of the
capability from its implementation, making it possible to forget a step
while implementing a new `Io`.

Another undesirable side-effect is that it makes the implementation of
I/O backends boilerplate-y and convoluted: currently this is done using
two levels of imbricated macros that generate unsafe code.

This patchset fixes these issues by turning `IoCapable` into a
functional trait including the raw implementation of the I/O
accessors for `T` using unsafe methods that work with an arbitrary
address, and making the default methods of `Io` call into these
implementations after checking the bounds.

This makes overriding these accessors on all I/O backends unneeded,
resulting in a net -90 LoCs while avoiding a violation of the DRY
principle and reducing (and simplifying) the use of macros generating
unsafe code.

Patch 1 adds the `io_read` and `io_write` unsafe methods to `IoCapable`,
provides the required implementations for `Mmio` and `pci::ConfigSpace`,
and make the default I/O accessors of `Io` call into them instead of
failing.

Patches 2 to 4 get rid of the `_relaxed` variants we had in `Mmio`,
since these are not usable in code generic against `Io` and makes use of
the macros we want to remove. They are replaced by a `RelaxedMmio`
wrapper type that implements the required `IoCapable`s and is thus
usable in generic code.

Patches 5 and 6 remove the overloaded implementations of the `Io`
methods for `pci::ConfigSpace` and `Mmio`, respectively, while also
deleting the macros that have become unused.

There is more work coming on top of this patchset (notably the
`register!` macro with proper I/O), but I wanted to send this work first
as it stands on its own IMHO and is more digestible from a review
perspective.

The base for this patchset is `driver-core-testing`.

Cc: Zhi Wang <zhiw@nvidia.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Alexandre Courbot (6):
      rust: io: turn IoCapable into a functional trait
      rust: io: mem: use non-relaxed I/O ops in examples
      rust: io: provide Mmio relaxed ops through a wrapper type
      rust: io: remove legacy relaxed accessors of Mmio
      rust: pci: io: remove overloaded Io methods of ConfigSpace
      rust: io: remove overloaded Io methods of Mmio

 rust/kernel/io.rs     | 435 ++++++++++++++++++++++----------------------------
 rust/kernel/io/mem.rs |  10 +-
 rust/kernel/pci/io.rs |  99 ++++--------
 3 files changed, 227 insertions(+), 317 deletions(-)
---
base-commit: 289b14592cefe95f7d0ef334873c12b96ce3824f
change-id: 20260202-io-81fd368f7565

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>

