Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6E35965;
	Mon, 16 Feb 2026 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771242683; cv=fail; b=oxT2DRkaqWML4P3XogxzrFwR+QtT6Hx3k5fYBSEus79bUZ08pu/M3qdbIDnFQIF35nkLy42AkDe6ALqz/Q+afYD/p2vwDHyT8lCgg2dFr0K88N1JxOy/0FzXHINO0CBedt4y/c8lMvOTGCy+RsMqVJUKeNXCW6+K0QeLLBwCZis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771242683; c=relaxed/simple;
	bh=u0yZcZTxi3iejSkzWp/kzUbhFFsr+uPxK4uRQDn3x2k=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=QEm63bSi9voy9gh4T6KELrA1ayHjI9xnGrJ0hg/6K6zZB3kmiWCyt3jyUG+S3YGwJK+3FnEOtG+1VIGP6W5p62r/4leCy56/L8mFMsAU7bmlyu738Yk0TsDfmETUT/BnCnz+fs+ktYM04wI2Bs4kpTxVg0vPnsxGfFZts71xE5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pN1FgQVG; arc=fail smtp.client-ip=52.101.85.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pN1FgQVG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+CRurwx5vd9d/KYt3nxUFeqWOqeoYIgGY2YsEtkDeF3nXKwivANKTYRMUCDalqy7zM0feX+mfK10S4YKTK66Vh+fogveNre0/iGNPqszyxMqGvBImWNv5c+6fQTHjjQRhqI31vQYj2nIR7Ks5/NYJDVVo11By8dWL+WVSVCIoz3R6euz67N7V84eSSLN8T2hLTd/4ZpDTKxcde3nYXBhvAUdGz/PZ5AyQKe0Ofx3pTXw4hydHY4it5zqcGcXb0kICuV9D2exqThkCqtMXBKE92WwckY6AhOOsaRFNj82duRXzAH0ai0Hs5JFqEbacWXJ3OEbuKHajZct7FsjVAJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO2wYYdTB/v3zrOqzC5SpRbcY7qjhjMGGujW4Szgutk=;
 b=wWSTTJ1zL++K3u8tDVXvkFqG/oLKmO03alpcRESFAoCKtUIy9YaByA1bZ8WO3Q1G6/fW2hNEgHgXyLPRoe72QeW0KwzwRc8qsAG01vJfnG3IKbE2gHISlbUP11Kc3MHXBhV9+NOc1fFh0ZdZJ6Jg26BW6oheTQFEClTuKVcbElGwPH3Q8aOpeCCR9vte6rNIbg1nTuKUicvYGYS+TCmEuhbpW/nCj8u135/wtlGfLBqM26A/2N1jbuRhIw0QZ2JMUjAg2QLHpRXpB7w9IVWY2sNQhch+4TcKbmz6RPy0mPxK3DlqXmv5v51IR0E5B4PC/OT4msp2GGZTTSFW+ECjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO2wYYdTB/v3zrOqzC5SpRbcY7qjhjMGGujW4Szgutk=;
 b=pN1FgQVG5UvJcoqJqbUDkU/rJepCYSbPkBlyySV+eUcMeKiGjrstuBYnuan1cFj6M6ZXYHrM9OhdedLzD2IX+99Szw1ZutfneFmGJExYKI6ShTjgEhYRKSD2ZLqwmA7iHRdTP70qVr02l9Hn7OshdxZOiKcOYww23D9m+GJP5aIIKK9/hX0byacBt6yFETknPzdp0DTLveZuHzuPu8wuU55xOL0BEiLwbafz4yGemKAlnQLwlAKUXrovohzi8lhT6PgHct0kiq1Gta4stXvM9/KawuLGYHfwQkICuEeEU/gGXVxInDoCnKb85RADMUQK2nqSZyY712VPRXLFl6tt9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PPFF4B476A86.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bea) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 16 Feb
 2026 11:51:19 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 11:51:18 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 20:51:15 +0900
Message-Id: <DGGD4JTGJYXR.3THD2I3AA61PN@nvidia.com>
Cc: "Gary Guo" <gary@garyguo.net>, <lyude@redhat.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v2 1/6] rust: io: turn IoCapable into a functional trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
 <20260206-io-v2-1-71dea20a06e6@nvidia.com>
 <97fc6c36933522eaf75f34f8fcd445715432fde4.camel@redhat.com>
 <DGCYWK1UF76I.A565AK23DZXS@nvidia.com>
 <DGD1LDCXJZR6.32S0Z7EHGYDUN@garyguo.net>
 <DGD2GXAFO99J.1Y3BA26PBVTAC@kernel.org>
In-Reply-To: <DGD2GXAFO99J.1Y3BA26PBVTAC@kernel.org>
X-ClientProxiedBy: TYWP286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PPFF4B476A86:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be5f0c1-4f16-4959-e706-08de6d51b24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDBhYWI0aFc5QXFPTHRQT0tpVUwzYnhwOUtMQUZZYXF6WC9Pakdwc1dTN3NW?=
 =?utf-8?B?MG1VTnlFdCszZG5PeVV4bm1YSFJzM25QQkNXaElidW9QK1Jka05UR2NsdDhK?=
 =?utf-8?B?V1I0dUFvdDJrR2I4Z1Jabk9GTG10U0pwSUdiK3ZiQzltREJUSjQ1Y2dBdXA5?=
 =?utf-8?B?VE5wcXpINGVyYVFpWkRrbkE3aVVVRzY5TGJFOXRtUzlMdDhrSzdzYUhDVmMv?=
 =?utf-8?B?cFJyKzJMWmJ3WGxZSjRFQzVodVFSR1JlZmFoVE5IM2FXMWRKcnFNVnZ5KzJh?=
 =?utf-8?B?RGUrUjJZUThjdCtEYXFjZHlKQlNkS0NmSjkxQVNXcEtLWVlEQTRVMmtZY0Va?=
 =?utf-8?B?WEVER2NCNE54Sks5RUY2RUJvR0YxeW1nODBNekYzTjNSSWRZZmYvNXdWQy9w?=
 =?utf-8?B?VnhtaTJJVVovaWtTQlEwMTBLSTB6SW8rSzRFd1dYeEpHYVdEZTVXSk10L3F3?=
 =?utf-8?B?S3hicGs3UkxOclZHLzI1MEs2OUx1M2YwNDBzQkZUT2xhc0J4Ty9pQ3VDTk9J?=
 =?utf-8?B?OURablZoVXdaWjh4SmFFTDQyTEhFeWNISUE0YURDT09UMlNqaVRXdE1ZcHF2?=
 =?utf-8?B?d0RpeFRyTlVxNzZwMCt5OFVlZjErb0pkcU5iZG85TGRsOVN1eFQvc0NCNEdo?=
 =?utf-8?B?K1NzOWd3OVE1NFJ4ZlMvc3VscTlLRHVGc3krL0IwSHR1eGQrYldaQ0xFd212?=
 =?utf-8?B?WXgxYklIbmF3b3RqOGtaSjFxU0dqbk5PVEZ6WUJ2cHN6enVpL28zUGd4QXFy?=
 =?utf-8?B?OXgxdmhUUHpnMnFWMno3U1ZvcWxoRkcwcUtYV1IyWE9Wa3JWQ1hieVZIM2hr?=
 =?utf-8?B?M1M2cTFkc29kc1hiTEJMRnFTZStXV2F0b1E3aEVDczRnMVZkOGs0OHBLVkk4?=
 =?utf-8?B?Rk1ZTytYMkVkdkZpc0pJMnMwR0V3c3F0SFFIT0V3SXdNdCtPQ1F1U3ZyZnBH?=
 =?utf-8?B?TEVkenBZTTRGdU1ndjdRbTRjUUFxMFc1emw5ek92N3dncVdWVTZCaEFVTTIy?=
 =?utf-8?B?a1Y0R2JhNmhyRmYxMEd3eTJEVVFoVmkxOGZRTWlqbmxJU1hNNEpLb010TGlN?=
 =?utf-8?B?M2ZVdTREMHp4cEVaT3g3dlhoQ2R0UEFHSGhXZGpNUCtaa2dma2NmaGlvd3l0?=
 =?utf-8?B?SXpXS2Nid3Fkdmp3VDAzOTI2bkJuMUVWQk5nV2t3VVRPSG5UVVVwOGthNW5T?=
 =?utf-8?B?US9wN0kwMVJKeUhNSWdTRHJnOFUzWHhvQS9jb01PNlRqdEwrRDh4emhVRm5P?=
 =?utf-8?B?K2ZVN1JNSFFYeWpzZGY2VmRvY21wTWFVdHBLZWFOa1B6dzdUbzVBTHFMSzF5?=
 =?utf-8?B?eFFpLzNuRWt4VzUraW5KRzRVOS9aTVUzdkFvblVEbkxDUkxPS2w0b3Z6TXZW?=
 =?utf-8?B?Wmc5T1JXVzNFdGd0cFBYMi9vTUtvNmkwSmcxdnhocUVMV1NyK1ppUXBaelBG?=
 =?utf-8?B?N2lJUlR3UXBwQS9jUjhBNzlNQVpCWWdFa0hUSHNjbWRqckg3VCtCRFpuSmFP?=
 =?utf-8?B?MU9pZ0Zabk85eE51SkxZZ2NSUklwMGJvK2Y1bDlobHBGRXQralhvUVNTOUI2?=
 =?utf-8?B?emQycDUyUFE0VUd5R2FjY1I0Y2xMLzhNWVFJYUtiNm96S0VLcjFBT0VFNEY0?=
 =?utf-8?B?bjRzS1JRamZaTi9yVUdnU0xlYU9TOThVdlhyR2NhM3F4MlZURjFNQ1JSc2s0?=
 =?utf-8?B?cUpvN0p6ZzdHb3lRRElLSkRoQ09DbWsvT2hOR1VkdndRTzhwYmc5bUZTZzZL?=
 =?utf-8?B?eGdBRzl6ZDRudjA4MlRRVXVLSjJnRkFIdERoM3BiaFJXQzA1b1EveVNDU2ph?=
 =?utf-8?B?emxZcG4wSm4ybzlYUFViU0R3d0srTG5La2Y2VjNKTmY2UHl1cjFiWnBES3Nt?=
 =?utf-8?B?aFNDUGx0QnR5cmhtdFBEYmtRVEt2QnEyVDU2ZThqR0F4NVd3azVTRTFDVlNE?=
 =?utf-8?B?aXhKbVN3ckRyQ1d5WWtqRzZOeEc2amZ3clMyTlRuQzdlR2x4NzhtcVMzOER4?=
 =?utf-8?B?WkZwcStHZDBjL1RMWUxnZm1YK0VuQ0ltQ2xMK1J0QlNrRzVxUk1nUHNSdUx5?=
 =?utf-8?B?ZlJKSm5IcUFKdlFTUFdNakROUGlTYlYvcldQaTFPTW1XNXpjUHgyYjNUcmhT?=
 =?utf-8?Q?SKnc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0cyYUVvK3hWS3J6OVkyVDB1K1pzdVBOVlR1YUFaR0NoN1dKR3RQNm5WQVhS?=
 =?utf-8?B?S3UyOUloSENFbTJnYnY0T2QxbjA5MVRjdGIrcEtrOUlSWFkwR1RHbEhKWWMw?=
 =?utf-8?B?MFVaZk1LaWo0R0ZUL2xSN1crYmZqaFlLOWdCUXREdGpHSitzZDhlMXB5SGQy?=
 =?utf-8?B?aitYUHBPOVFwZUFoelB1dWlEamI5emxQaU93RHhaNHR6ZUFoWUszS0RoOHZJ?=
 =?utf-8?B?d3ZLWGpnbEc5cXR5dEZ6TlhyeWtmeHlhdGg1dHlxblpZWkZXQ01iNWlNdUU3?=
 =?utf-8?B?SW9ETStncVI1VVhWZUxWWlppUzNLL2VrMUcxUU40bHFuRjhydUgzMU45MTNP?=
 =?utf-8?B?REJRRzZDSzFOMVEvU3JkcXBTMTcvcHBHOUtFaHU1UEJDdmVLRS8wRktMT1pm?=
 =?utf-8?B?U1lTNkhpNFR4N3ZrSFpKeWpVZGlwOWdxQmZJVjhJTzhqRkl6MmIySWtVWjFr?=
 =?utf-8?B?eVpodVhEZGV2VmRuU2p3Q0MvL0VKQXcwT2ZkYmFSc1NnNXJndEo0OVd1elU1?=
 =?utf-8?B?M0lIbFVNYTJ5empLc08yQ3l2dTdMeEJtdWdac1hXdXp4Nm45N1EyK0I2T2d3?=
 =?utf-8?B?SEU2R1FWMlorS1NjQmhtVjMvamlOelJrTEdXOUQ1N1R2ejVxd1l3eGVONHND?=
 =?utf-8?B?MkxJSUthekNvSkhicjFFR1l1bzV0Y08yZlRWQWZZaDlhZE9WbitwV1VFc3Nq?=
 =?utf-8?B?cWhHWVhPVFpDVjlWQmdobVJtc0JZSHRoQmdjZGtPcnhBcStIb0FqaUNUWU0y?=
 =?utf-8?B?cElJdDRscHBoaEdDSSszWFNocVpqcU5TUlRLa2RvV3VQTzJhT0R6Q0dGcXYw?=
 =?utf-8?B?WVVWditsTEIzWlVjdjF4M3UvSTcyMkZyS2hTcFZqZURXSUU0cGY1d2xhQzBG?=
 =?utf-8?B?ZFBoem5HTjZCS0t0S0RmTC9PdVJTYmhvNkFodUlRd0ZZc0hxbkNJV2x1OVVs?=
 =?utf-8?B?cUUwbW94VTk5VXhPUU5Bak9RR0VRL3E2VmlsOHlRTXpRYlVtdkpKdE56aDQw?=
 =?utf-8?B?VEJnZXJTMUIxVENtaVNHZmNObUk4dWlKaTVET2lhTzdBRHVRWTBlNzl4MENk?=
 =?utf-8?B?V1RvTzRaQW55d3RKaUw2Ti9JcCtYdmcrcVZwNitlSTR0UTI0cmlOdk55eHBl?=
 =?utf-8?B?NGdncnhrZnFydlQxam9MSXl0eWhYOGMvZ0kyTkJtNGFuSUhVOVF3bFBkQ0hT?=
 =?utf-8?B?WWdnZ2pqczVBWEI5eDFwd204cVZiN0lveDAwZng3TUltcDVtaTNSZTEzZWxI?=
 =?utf-8?B?MGIxeEQ2KzYrTGc4SHRUZ0luNnN2bW1QREdFZC9UbzZ0WXVoR3YweGw1QStn?=
 =?utf-8?B?WGZ1NW50N2tWTm5LdUFhQm16SWtBTVRzbUJ4bWdvbzVJZjZGWnJHVlVhVDBv?=
 =?utf-8?B?UGxwWk11SVdrQ1RocGdyWWxXNGM3eE9pT1M3Z1Y5OExlVjJqdXRDemJoY3ZT?=
 =?utf-8?B?Ny9LRjNRWUZnd1hITHNvWG9LeDhkeGpBaFYwbHZaMTBGWWJxa0F5UUowNFFS?=
 =?utf-8?B?aDdJaDZ2ZkRSL2kxNnJLUk4wbSs0MC9OdkdyVkVoQjBTditSbzUxVVN6VTV2?=
 =?utf-8?B?N0Nvai9YbExUK1R4NWZodjRlWmg1eFNJdXZrN2Joc01waXJGQWRDZCtiK1ZG?=
 =?utf-8?B?bnQxQ0gyTzNCaDFRSE1sditVa2RDOUNNN0VXTVJtc1FZOWp3TEdLY1FlNHUw?=
 =?utf-8?B?UTdsUlhaZSt1Qm54VFZGTWRLQWNWOVZCQU11dVBVdW5ZUkxIWFNCYTZiVDd6?=
 =?utf-8?B?ajVzRU5vOVNGNVQvdzN2Rnhna0JTNDZBUm5Od2NoNjZ6Y2hlWVpMQ2hKRUR5?=
 =?utf-8?B?dXp3M3B0K3AxMXNvQUxwc3BtMzJCb3ZUWUxUS00wdnppVDErek5KbWt3ZzlO?=
 =?utf-8?B?dnZON2IxQklubFpYZnFNRFYwUFVTUm5MdU9BL0R6bGZjdFVUWkJzaXY5MDBE?=
 =?utf-8?B?SzBRVlduSGZCa2RHWm83dWFQaUNJQlNBa3RESkZEUlZ6a3hFWjNZNFQ5ZW9B?=
 =?utf-8?B?RlNEeUhpMVFiTG8yR21UMWlRYUluZ0c5Y3hCMlBXb2dZbklOTzFBUU91WnM3?=
 =?utf-8?B?NElBRGZQN2w3emdvdlZKenAzMUtHa0RCeC9jWDNIdVVmcTVjd2RURnRUckhs?=
 =?utf-8?B?TmRqYW5MakQzb0VyeWZKMTBPdk9zK1FZM3BvQVNyb29LYVFSWDB4L1NKY3F0?=
 =?utf-8?B?SStpR2QwOUI1dEw3VkloSmNmUnB4MGh4VUtxVFFXS2txTGc1bEppK1N4V3dL?=
 =?utf-8?B?TGRYVTZQamptVklmQlJROWQ0THI4NDF3U0NqZDVkbG5NQlZxaXlta1RmbVF6?=
 =?utf-8?B?WkNJNzl5OVc0ZnM0b0JYYjZ1RDlMLzBubVQvRmk4dUl3Z3Izc01zRVdyZnJB?=
 =?utf-8?Q?DIvxF0xjUkh523UteRmgiz068+5Liq/5OwFVS0UbdNw6y?=
X-MS-Exchange-AntiSpam-MessageData-1: yezpR7Gk/VSiag==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be5f0c1-4f16-4959-e706-08de6d51b24e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 11:51:18.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qe/n++gDDypQZ7tUwCXb5kmj14DS+a/Wc9h4K/aWHHbP0BNXcuUPkXZXtpbVFWUXk79ungzTNM+aoJuKdrX73w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFF4B476A86

On Thu Feb 12, 2026 at 11:52 PM JST, Danilo Krummrich wrote:
> On Thu Feb 12, 2026 at 3:11 PM CET, Gary Guo wrote:
>> They can, but the `Io` trait just passes the wrong address to the `IoCap=
able`
>> trait, and nothing horrible can happen without doing things unsafely ins=
ide
>> `IoCapable` impl, which is controlled by the user who implements `Io`. I=
t looks
>> to me that unsafe code is still needed to do bogus things.
>
> I think what you mean is that the invariant of `addr` and `maxsize` being=
 valid
> is on the implementing type of `Io`, e.g. `MmioRaw` and `Mmio`. The same =
applies
> to IoKnownSize::MIN_SIZE.
>
> To me this seems like a valid way of arguing.

But still, using only safe code an implementor of `Io` can lie about
this safety statement:

    // SAFETY: `address` has been validated by `io_addr`.
    Ok(unsafe { self.io_read(address) })

Granted, the same person will likely have written the `IoCapable`
implementations, but its safety requirements cannot be fulfilled unless
the caller also guarantees that the offsets it passes are valid, which
the type system alone cannot guarantee - thus the need to make `Io` and
`IoKnownSize` unsafe IMHO.
