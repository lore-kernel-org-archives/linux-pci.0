Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BE13242D2;
	Tue,  3 Feb 2026 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157519; cv=fail; b=bdecMu96UP8Z+IwgoNojP9aQL/cQKfZ5FKZFZ/D6xnaIjinR1qP4z/X5uvkMOLsRtF+iuzACWc+Tv0J347JKi2qwzjwDQr2G4kyKqtOB5PuMhFvMqCq1rpLvikD/nAhJHT0cAkeRcjx2Qv2GlDwJ8ouGSr1k6rnpAksjTy47tfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157519; c=relaxed/simple;
	bh=Yntcoux8wDCrKLI8bBN/RczpXc1X9LkPsVrXY5ifGzQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ePAzI82PstT+5u1iQqS1ubO8dSFUm9bMVKHu8fa4WtS8DqsCMONng9jqimvF2Tt2LsCCpDVJgkOVVU+hMRT7Ubfd6kTnQgIpqYlM1/mvu3KKLnkj1uIcGMSfV9CYIRy2lW9LmP9JueOmPpqZSj/VvWCciEh92/dXu75JppQZslk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KxW1hdI8; arc=fail smtp.client-ip=40.107.209.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KxW1hdI8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZ0Q+uSBf7EzHqRdJY7eHWGTNq7jdh/yyHNKh9hOVYhiVfcmgr8U38zR+SGqZ8rhlgVaFECMfLcF3NHdmZzP8zsASkCWeYd/U7So7Q85oIRdUYNdCHS3vkhoahVl0N2d9Qs62zNzIiJ4pgGf0XYfUVdUGh3t67rDxzHH5UlwcDNo4gqNVNGDcZ+M8i+d/Rrhw4aUc0hmYzO+//xlNAA92EnrC0rgjwLlMLKfZWSJXoidq39/AGYjIMPAsNHzrJ2JBrEU3BnG+6Pp3vj9nGFO9w+n10HCV1TDmLn55WSVeESn69WD2eAk5amIygbWpAdCA2JKnBQ4BH0FiU1hUZ5tfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TypjwNHdbey6CR9Sh/gtCP2VDEnk6yKkMOmhUoDiKko=;
 b=ohuuTdXgKpxaBjbIxfgcFHXTKBQYcxTwio0F16wuSCiBn+Cw6FyAPxFxL4JWa6OJaLhVUckmqAT4g/teZHn8RxJnrW3T7GoEQI+4w1sJP/554wZaOmox+gnoECbAqluUUdReGm87TjogE+qS2T+EBDOfqN8j77RYCp2g/HlWSIVdYfsczRfvJB6+FYvgE5ItDNipwh6nLyQhk/+EiyckbOsWjxJF9k4iGSkg+RAMv1hW8Ex+cJl/dslsYDJ603lRCe4UZKrcM2hP7fmmVFLWSJn4pJJ7QPsMqzV0War3Lg8N9g317IO6GYFa+aMYx8qL1JqyUftxzvnZvGPmYcYW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TypjwNHdbey6CR9Sh/gtCP2VDEnk6yKkMOmhUoDiKko=;
 b=KxW1hdI8ycNQtwjFDi/9BxpHwfYMAEcPE61ASptieWBtLqEAwLcIJ+DsS86AkJ7dUXKl5WAZxI/qDiu/IesZfeiniafsNe/cz9s//LObUkeFnPDCgPZCQwqcGM4WwgrYRAsmUzgCwhMqYf5qokCIpylM251Ehgd8/v3GYmhGrGMgtmQiOUpGcB/ekJ6Yvo/gpecnEe+PluLEZLWxiO1ofc0Xnb4x+PTK6q5X0iazKyRk3zZMIY19PT3vjRxWfpUZn5u/gKh82Ma5DVggRWF9RspSYUnq+uU5lmyq5p8ih0cCHyU027sg/WFLwZcAdO8rxACuA3b3QOMOTwGG7OyO+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 22:25:15 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 22:25:14 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Feb 2026 07:25:08 +0900
Message-Id: <DG5OGT2N6WGM.3QRRYNCHZFHHX@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
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
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
 <20260202-io-v1-3-9bb2177d23be@nvidia.com>
 <DG4J98HVOUEX.I7XOB7LPB49L@garyguo.net>
 <DG4JHKY0Y19S.24TZ7TAX5ISD@kernel.org>
 <DG4JO8B5SDZU.34MP0GJ9G3J4F@garyguo.net>
In-Reply-To: <DG4JO8B5SDZU.34MP0GJ9G3J4F@garyguo.net>
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: eccd226f-7396-42cc-76e6-08de63731a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDlTT09QSmxNbklGVmRIVVlHRGNiN0tCcUhJMDh6NTVCUGtyTG9zQi9SYnJy?=
 =?utf-8?B?VmR6ZWxUMnVGSTNOdUpPTk9hV1FhV0duOWF4Q2xkTERxbDR3M1Frd3M4ayt6?=
 =?utf-8?B?bVkvYzlzRFd6SEFFNTdSeUNNenNhS3p6N0tqTWk3ci9zZWZqdmpVSzV1KzVr?=
 =?utf-8?B?bXRHdGE4UGE0ck92d3E4SlBKb1FZeHBYSnk1QldQdjh0R3ZySTVNR1JsTVRL?=
 =?utf-8?B?a05tL1p1VmpJT1UvYkdJK1hMVWtYUytXRUZHY0dET01Dbzg4YXZEMjRhSzYx?=
 =?utf-8?B?ajNtcEoyeWJLaVF5Z2lpK0tjQlpUK3F3ZVp1ZGhCTXVHZXFqaGZSL1hVSjgr?=
 =?utf-8?B?azU0MHVoQU0zeVNhVERrSEhBcFRkaFUrU1VqcFFYRHFiS3lBSmRNdCtIVENH?=
 =?utf-8?B?NkRGY05tYWpCZkQ4azhicUZNa0NxdG0wOU55ZHQrejd0Nkg0YVduU280MDdr?=
 =?utf-8?B?MmJWR2ljME1DV1c0YjFSY0tPUFVySTdXZS9ZbFU5Y3MwWlpFbEVTVFppMFpC?=
 =?utf-8?B?TVlhZU1qaXlVZHR5TWM4TzBIeE9LQVJHL2ZoRVFPYWtoS1phSDg0a2QzaDRO?=
 =?utf-8?B?cjY3R2FnclZSZmdBVUZCM09VZkRmdmxhVTN2NmcxTmVSRU1NUXkzR2JXK1RR?=
 =?utf-8?B?WTljbEllK1pPV1JXNUxLemp5QlI1dHEwQmR0M3hMbjliR01jalRRRWQzK2NU?=
 =?utf-8?B?MndrMEdqWnpGK0RQQXljS29XeVR2WHA1NkMxeTlBZE0zeUxFUGZ3L2t4d0Nq?=
 =?utf-8?B?TEdhQ2xUQ2VyMzJFb0VBdFo4M1k2Sm9pUEkxeVQ4T0pzbWQzMm5LV0RHcXNr?=
 =?utf-8?B?UEtJc1lDMExjOU5tUGg1WVYzcHlScmVNK2NiczZEZmpyc0tBSnZNdkpZakZC?=
 =?utf-8?B?dVl0ZU1EY3FLWmNCRFlhaHpCazY0VHRZWmNEVVJ2ZGMrVDRpVlFqVDZHRHVM?=
 =?utf-8?B?Q2ZnSHR4TGxYNG9lUlNYeDg2czRtN3NnMktpR1JFamNCYjNaTFEzMEpyVWg5?=
 =?utf-8?B?MlY1K3pBeDdSSVlPbTV3Z3F1RHJWZW9zcWN4eGVFTEpMVVVLclJ0cnhkcS9X?=
 =?utf-8?B?YUxNMGVUU29MdnhSM1FFTnord3BsSFNYS2RkdjcvSndXZ3Y0VzdHaXBSRWFG?=
 =?utf-8?B?ZzBoRXNHRUozMCtKeGJjMjlIemZvcDk1S0hMVnFLb1B5QnMzZVJpaU5lNDhM?=
 =?utf-8?B?SWxDZm1xWEV3MzNHMGpVaUN0eHllUnEvWnczS2VuYUtMWm5qVkpSaVVXcm9j?=
 =?utf-8?B?b3JGVmdCRmNuUFNRb29SVld2WjM4MTlTalNucG9oNittL2t4T01IZTVqQUty?=
 =?utf-8?B?Smt5NTFxYUhUWGw5dDRxSlpaWWNES0h6UGF6SW9POWlqSDZHZEZ5SXUvNThO?=
 =?utf-8?B?bmdXTE1VOWtpdk9pMm1PV2c3SWZTQ0loTEZJRFc2Q3JyZ3JKR3IvS01JVEVB?=
 =?utf-8?B?SXdlQ3UyTW5RTFgyVEN5eWtMMHlXZm5mVVdZdlUwMWczK0t4bEptRmR1b0RU?=
 =?utf-8?B?T3duczh1dFBWUjhUaVVUZWNJNnVDWWt0emF5bk9Mb2F2RUsrT1ZSTTBFaE1T?=
 =?utf-8?B?Wkg5YU5RT1FZeWc4UHJaQ2ZTNnJET25EUnJicXZXNEdQRnYrVkNGelpkbUdP?=
 =?utf-8?B?QjdsNGFFemhZc3BocDJ1aUVkR1FUZGhTTUpQZ29lOTF4SUxiRk1VZUExNTZ2?=
 =?utf-8?B?U3NkUTZiVm9iRnVCTlcraVc4MURvZDNzL0RsZkh1L3BtUDRDSlJ2Y09XSW1M?=
 =?utf-8?B?VG53UjRmT1dSYW9Ed0pVVWhVZFpDaWk0RXkrbXpRWFB1VS9KeHpqOHJhMzhm?=
 =?utf-8?B?UHdiOVpSWHAwbFBMZUNoN0Z0enRDYXo0T0wxM25tUWM3bXd2RjN6c2J3VWdi?=
 =?utf-8?B?dTd3RzhKcGJUam1Fa1JLNnIwVmJnQVRUY2M2Z0MwS0c5aWNwOUY4N21xN2Rt?=
 =?utf-8?B?aDlCNkg3ZStZNUtja091WTFDYmF3TkhWNlAraVJrYlhXdm1yZlB0azhSUU9P?=
 =?utf-8?B?SlpBcmpBdUJaNXROOENpUTdpUXE2aHJiMkNCVWsyOFA4eUc1MzBYT2RtcEU0?=
 =?utf-8?B?VlNvaTI4S2R4UzROcHNnb1o0VnE5UUhOTUNqRWhaMUJyN3I5ZWp4eFhqNGpP?=
 =?utf-8?Q?53dQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFN6M3BlVlJucTFwcy9zVmtOQloxbXM0aTNFTHFMR2VVNENzUVpwdVpEWXBF?=
 =?utf-8?B?Q0xKa0V3NUdGNGYwc0cybWhmYlhqNkIrTXZaNUwwMzhTMkpheHN0a0xXU0RG?=
 =?utf-8?B?RFZKSVRCMDllanllSUNuWTJWR3owNUo3RU9ZNnFaT1dRVS9RZkRVemsxcU50?=
 =?utf-8?B?ZFlBMnZkVTQ0VG52MWNHUEk0NkRJZXR3Zlg1bDZWMXovWTZNK3hUelJrb1gx?=
 =?utf-8?B?Nit0ZHVjZ3lqUkFwSzZTY2lkVmQyZ2YrR3FwaW5QTHdONkZpbDdOOW8yK1hS?=
 =?utf-8?B?NS9mUVlIUDRodXJLSFJxNVlrT0RrM01Obzl5b3BjQ2RzZW5xMk1yeGsvYTZU?=
 =?utf-8?B?bFJVMnBweWJtQi9vUmo1M3NlSklGZC9WR3RUMWxoWVp0QUx6VFo0TXZsWjZI?=
 =?utf-8?B?bFQzT1ZpeU5Gdzk0K0VrY1k5QjZnelVlVmhaQXY0ejg5eTQ5cGcyNHVqNjdY?=
 =?utf-8?B?b055c0tTNGRnUWVCWEd3ZHpRemJDTzRndVh0ZmdyNmo0Sk9EdS9yQnZLVjYv?=
 =?utf-8?B?M2F4N0gvNjVLR3FabEU3WVNkcmxNMXpoZURSRDd2bEk2Z2lTcFUvMzVkNmtN?=
 =?utf-8?B?ZjVLWFhPOWVPSDBoa0pSdEdKZ2YrVDlBa1ZqOFJyYTY3TmVWTGlkTXlla25W?=
 =?utf-8?B?MTFWVHVvaGxNSmg5Uis3Y0NKaVVuUDkwclU1UXd6MVFGb045TktydUE0cVBx?=
 =?utf-8?B?UDNSMGsrcHRldG5tT3dzSW1hbjBGQjlzNy84WlcwNG00eDB4a0twLzQzUUdC?=
 =?utf-8?B?UWhtYVIxZkFGYW81elMxNytMMFJtQ2ZtYW81NjF4V0czbEluYU4vaTNZa1hj?=
 =?utf-8?B?WkRWeG5lZktQSmRxaFkvTXJnaEdtOE5TNlp2cEJYb0Fsa05hRVVZTEFPUmxM?=
 =?utf-8?B?emRuZkhVNk9IY1RpV3c2Vm85dEo1T01XWG03NGplcW9tU2YwM2tVVjdCQ2lB?=
 =?utf-8?B?Q2tGL3NPSHdobHE1OHFKY01sakI1aHpiS3FqQ3BJR29wVSsxQndSS1gwZlpo?=
 =?utf-8?B?aS9BNzZ6dEswenZna1FiZVQxcTc1emo1Qk04clpEVmFROEJQR1hOZG5EWkJu?=
 =?utf-8?B?dU9IckpQNkE0cTVGc1paTjV6dFZNQ2VlZEw2b2c4b0o2TVZFTkVodkt3TGhB?=
 =?utf-8?B?WlN1Tkg1Ty8raFk4eDUwVjZkQXkySzhHNndaR01iS0RtNWlsRzB2TW5haFNC?=
 =?utf-8?B?S0prYzJ5cGdpOEtGUDF4bm9RUmNrV2d6bGVjQzIxNFB1c0tweFR4RE9HQnVY?=
 =?utf-8?B?SVBTSWNray9JbmxiRzhwUkk4c1B6SHJKU1FHRlNiUVhId05tNlc3ZmlvQkln?=
 =?utf-8?B?bzhYcEtzVUVwaWFFVlkyOHBQbzhsZ3VtMm5hSXF6b0hFWFRiNTJCMU1aQXll?=
 =?utf-8?B?aXBMMm5TUCtJR1puVzRVb3FpTHZSRGZqVjRwY1lXbFhQaENkSUNsQlZhdXZJ?=
 =?utf-8?B?c3BEY1hWWjZlM1psUDJNMEtUbUIxWDJsSW9wamxMajJXWEorbTZoNXhKZE8y?=
 =?utf-8?B?WTZnS0FQT2E5QkRTcTJEUG5MNnZsdmFHb2t0WVlET3VkZDM3V1RsU25yQlEz?=
 =?utf-8?B?RkhDSTJMNHViaUw5NjJhT1A2OTRsTFZLMUUwbGdhK21tVkFFT2xueCszUGU4?=
 =?utf-8?B?ejUyNTg0aFQwcXlHWnR4UUNmUW1nY2k5T05Yc1N2c1lhUnVFQnlCcmhGNTBx?=
 =?utf-8?B?dFlrY3VDcTk3elJTdGx0emVkNUhYcVZ3Yjhtajh3Z2lXeForMWs5WGtsR0FU?=
 =?utf-8?B?YnNiN29Hbjg1TGd5RE91ZUQxcWY4WXU1UWZYeGRCY24zOUtKL2JuYWNPN0NL?=
 =?utf-8?B?Q2lLSFdJc3B6KzVKeEg4RjgrQzQrUk45cSttYWdTQkphamhaRFBoVkV1d3J0?=
 =?utf-8?B?QTVGVEtDb0dtOTJTbmlKUU9nQ0RYdXFGZFZESllqQjVxRVkwc2Y4QlY5WkRS?=
 =?utf-8?B?bGIrTXlMOFkrOEZzbDZmZ2dZblVmZ2s5VXhTT3VRNVFVMlJadXc3ZlJjaFRy?=
 =?utf-8?B?NjJlMS94VE9CSFhnbExoWVhmY3A2Mk5Za1dpUmxqbGhBZ3pKRUhRZnUxUGZs?=
 =?utf-8?B?aWEwNDcwY1NGMjdrU2ExRk12UzJJS0ViS0tzL2d4RlZIM3c4OVhGRDV4T1JB?=
 =?utf-8?B?NjZVZWJJdnFTVGxIWTdrN3JVWDdoUG94S3lORU05YS94MFRZV1dVakV2UEdp?=
 =?utf-8?B?QThLSURMRnRSRFI2WlpleHYrdzNsVHp2SDFUaUFla1ZJTGZaUnNSa0VaUXVP?=
 =?utf-8?B?QkxOMEdGRGpGVHpPUXpMcVNuNzNNTFJiN1VqeENoaDJpcTF4S1dTTEhJZ3Jv?=
 =?utf-8?B?RXMzWno3TmlUWHBnRW5CdUZKWjJlRC9UOEZEM3NxRTdSSGRydGRjZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccd226f-7396-42cc-76e6-08de63731a47
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:25:14.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUffK46Qixx2LEmGxOwllpX8N7dur6ZDFQRrPJEEmp86Lfjs1YWl5J1QVExb5K/Mnv0xY/RGompE17H1QueEAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659

On Mon Feb 2, 2026 at 11:27 PM JST, Gary Guo wrote:
> On Mon Feb 2, 2026 at 2:18 PM GMT, Danilo Krummrich wrote:
>> On Mon Feb 2, 2026 at 3:07 PM CET, Gary Guo wrote:
>>> I think ultimately choice of order to use for each I/O access is local =
to the
>>> specific access, not a global property.
>>>
>>> I guess one alternative design is explicit order on the access, e.g.
>>>
>>>     io.read32(Relaxed)
>>>
>>> Or
>>>
>>>     io.read32(Full)
>>>
>>> however this is verbose in some other ways... I'd like to hear how Boqu=
n thinks
>>> on this one.
>>
>> This apprach would be misleading for a lot of other I/O backends. For in=
stance,
>> the I2C bus has no relaxed ordering.
>
> This is a fair point.
>
>>>
>>> I know you can just do `RelaxedMmio::from(io).access()` for each single=
 access
>>> too, but it feels quite verbose.
>>
>> mmio.relaxed().access() would work as well.
>
> Indeed, this looks nice.

Yup, along with the proper wrapper layout that Gary mentioned that looks
really nice and flows well within the code. I'll wait some more for more
feedback and send v2 if there are no objections about the general
direction of the patchset.
