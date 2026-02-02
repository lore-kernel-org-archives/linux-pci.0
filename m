Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397AD1D7995;
	Mon,  2 Feb 2026 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019290; cv=fail; b=cEm+OE/r9hfaR3kUmlVyLY3Mofofy8P0R/VdZEgfnbfVcDnHmqlcO+5mzoYv8H3+VIu01t2jd7QKijjjfFaDchX6RKsOtc1LehH/9vEj+jzeHDZrLZ0QHFHfTqTzF3xrHTC9lqWvUii3pobf1nyWZeeAQ41Vh1yi6l3mxBEhxiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019290; c=relaxed/simple;
	bh=ngHe2fg9GFJLmsZ8GZg+X9FAdixcC/Btg1MiJTNyHH0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=vGawSinyQEMQCr+h6/0AhwR6J6OhpsyJh+0wM6Pwv+8YNFhYhInsm7TsB2WOr955xdAJWwVD3S5f2uVHEJsDCraW8JOGjckrCVV0V6K9SjYrnp13rgb7G68prQBG8wxCUCtaNhiZ6qratg3nGpuvsAfI5G0mvnavIL6/fu6yS5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TM+2GgWC; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TM+2GgWC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSc8iOt+Ith36oIcY//8202p3gdeKNJT4IeQxt5zTGDW3Q+4GTaiM97pl6p//flhgQ44mXgQgYXJGBT0nyc26d/M/ViWAbw2AVXIRb5Gy6WLaZsJA37lUt+aw/CA7qv5kUjP98ERi94PYprTTbOAkkJQ3j3nlPfMDtzePxdHWsUMrSDMMoREX/SJiJF6EJtLgRkFXVKaJmkPKHps74lQFfBeO4xXMqyKvTi4k/Lf8uBG3KOrh/1C5yDlbDFGR9wReX6qdz6Yim+IXvv2GOXORWYlaQMHBdgi/gMFBLu/EAs4PKI5Za7Vkv6pWb0YISPZnTF5cM7hfmEdfkae7ebt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngHe2fg9GFJLmsZ8GZg+X9FAdixcC/Btg1MiJTNyHH0=;
 b=wVYcdducCm12jtk5zxzRwua4seDF3dWCLMUtD3jLGKQnEk04JPDcYarOzsZiYbe8umG9QT6DN/67uhoyFWYPjkyxXhVlbnArOCrpK4oAOJZIZENpVWDAesNTqxjQtrrzF5OjURdixhPZCq7gaHdlAIDQScH7tGK2SeWkFNXxvvKms2myEhuSEuuZ/IV+aoYV0cErnFD+AwXry1u1eEpl3FnHgScUBSHUk5MJ2KaEsADNzalrcjdN1hR8FreyihV+xmhlcgM0HvnUbHi4P5q2GNcmvZb5AlqE8icWXhQGphZFLWpW9N9MW/Bl9wotbX7/Csauf2DxVFOztWHSCu6Z4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngHe2fg9GFJLmsZ8GZg+X9FAdixcC/Btg1MiJTNyHH0=;
 b=TM+2GgWC3DWsOJY5nUd0Qpq/gROj29RQNaIGvjt+nfe61aZkX0fZT5AhWQh7paVMLXExlQr7a9/N3g+VUgLUVWqzpo4ucATbTSbbub5dteZVH8+UUlpXobkMHxlJ3lB5quDiQg7l5ddMlu1VzxeUvabE/B9xPtAjYSy3UdS0tz/VJG1d5rRAUQjgCqYLxUNFEhu+qVmImJIZP52L9Mv/3/y+CKV/zP7Vd5A0BvD10bJkPaSYaDpHBIGeQEKYnZPyIB0IXH6ibm+iwaFXMavIM5eBdsfdACO/2QynnQrDYeKnXz2bQXLqZuKgEdXBZ/ffFQiJ1+MB5vLfKQGG2IZQ6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 08:01:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 08:01:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 17:01:14 +0900
Message-Id: <DG4BGT8B9AET.30OW8LQ5NT21A@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <gary@garyguo.net>, <dakr@kernel.org>,
 <ojeda@kernel.org>, <linux-pci@vger.kernel.org>, <kwilczynski@kernel.org>,
 <bhelgaas@google.com>
Subject: Re: [PATCH] samples: rust: pci: Remove some additional `.as_ref()`
 for `dev_*` print
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Dirk Behme" <dirk.behme@de.bosch.com>
References: <20260202064001.176787-1-dirk.behme@de.bosch.com>
In-Reply-To: <20260202064001.176787-1-dirk.behme@de.bosch.com>
X-ClientProxiedBy: TY4P301CA0035.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3b58f2-4a73-4376-c30f-08de62313ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGEzdGxBVnVnKzFVdjhJaUU0dUxENHk5UzhCNjZORWkzOUFOdHo5YWVkRDBa?=
 =?utf-8?B?cjkxQXFGYzRzN1hRWHcwMklndFI5bnlnNU1yQ29JbFRJbFYvaWFST05WSUNR?=
 =?utf-8?B?SDRUaUs3RWhobUxMb1hVZHJHMkJCWTRYWXJoazlVOHR4K1REUmxQcGRIdUlR?=
 =?utf-8?B?aDU5WVp5UFF5bytRZ2VlejBPUXVTeTg2MFJ1bjc4ME9GYnlZaXZIVCtXL0Qx?=
 =?utf-8?B?anVaYkFBSEpBRGx1QlRqeWhVa2xnUFRSeTIvbnpLaE15cyt3a2RsL2I5NGsr?=
 =?utf-8?B?aWVUdUwvY2xpaitpZE5FRUh1TUd5WklnWWdETlhnOFFyaWRpeDlLS1p0cnpw?=
 =?utf-8?B?SHo5NmF6eXFVNHNrUUpNbTdlWFdkSklHdEZtdGZUQXpZTmVqSjZYU3Q1WGJK?=
 =?utf-8?B?NVNhYkRISmQ2THdTZGRDc29ZWDlwTS81Qk1PL0NGOE1ib3FEQ05sSGhGL0NT?=
 =?utf-8?B?ZzNDY29OUytoa3Q0MHZ0T0JlOTVBWmZuQ3RQdENkTlljeHVvZm5SYnJ1dTdS?=
 =?utf-8?B?aFlLNGM3SVFRMEE3YUFKaFB0dDNwQlNoQWNsaTZkOFBvYlc3WCtkNFhOUDk3?=
 =?utf-8?B?SWpsSmRNOFlWZjJnaTdibUlhMDZ6dFY4SkpSOUFvWUtWaTNQTWFWdC91V1VL?=
 =?utf-8?B?aHVKYXlQcGpBVTBFSG9PUEswSGhHalR5eHlVenZsZGo1OWtiZENkaDhMd2d4?=
 =?utf-8?B?VXcwbE94cm5NVEhsRC94UlIwUTJMajVDc2M5N01jYVNYVHdzck9MeVVaUVRB?=
 =?utf-8?B?RmlsMld4ZFd0MER4UCtpMjlDQVF0a1pUN1JFd3ZwbnMvWXhMbUVZMHpCZ3N2?=
 =?utf-8?B?bGJ3UlJYT3JRa1dLVXJFMk9BZnBsRXhhM28xbWRYL3pXQ09oWGZOMmNYN2M3?=
 =?utf-8?B?Y1dDQ1loeHBJYXhDRHVnTjZOWUcwQzcyclpES1lZNVFzSFdxRzJOSVpIa2x0?=
 =?utf-8?B?V2RVaXIrT1FoWUZVYmRiV0VjeDhZTmlyYkpuZ3BCbTliSThibVpKNGYzVjFx?=
 =?utf-8?B?d2R1TUg0WTFjMFA2QnpqNzZPT2VWU2NsOGdkQmI3U3B2S1pON0ZvYmJ5WmdW?=
 =?utf-8?B?THdNSlpqeFhQNUYyMW90bEhCcmNDUXhGLzhibEQrMlZBeFlDL3RYYjA5bUlV?=
 =?utf-8?B?Q0hoSG1XVHZmb3FFRnZXWS8zcnhBWHhLZTVPZ3dLNzhOOWEyc0M2VjJodnJ4?=
 =?utf-8?B?SGc4OVMvQ1lmUDNSNk1kcElUeklKNFRNa3pVdDJBNmJzdlZoVmZVOG15ZlRC?=
 =?utf-8?B?OWFydlFDdDhiNlF1TkltZDFHK3ZhQUtUa0RnMTNEUFRTZ3QvVXp6MkVCeWN1?=
 =?utf-8?B?NWd2Q3dXL21uSjJsdVFaL00yZU1SWG1jZmt1eTdPS1Y3ZkFNd2tRd0UwMFpQ?=
 =?utf-8?B?ankxSUppWk9LcTJrVktZMElhenJLQms2WmdaNDhxbHVlNm5ZQTYrNytrazlM?=
 =?utf-8?B?am0rSFhjNVNFVzVkRkpxay9JSDdpejB0VWdlUW9XQnBjclJ0U3RWNnp6WGZ0?=
 =?utf-8?B?SlFiSjZCRlNOcE45SE9oUUU0UE9Vb1l1VVVSK2xPdE1IMDZjRXh4UzdnWXQ1?=
 =?utf-8?B?SldFNW5rLzUxZjRlL3dQaUQ3T2J5TGtYVjZMczNiWTJTdmdTdVNWSnM5U1lU?=
 =?utf-8?B?aURZSllCTHh0dC8rcTBURUFPUE5RS0pxdmlMTzJoVU9uWU5Md21iRWhlcGVh?=
 =?utf-8?B?SVgwNEV0blFpRURMekROWUt1dFNBVFR2b05adDUxUGJuZHR4eXFEbXNhSzdR?=
 =?utf-8?B?MkpiRWRvL1grUmlOY3k3NlAydzREUG5McHZnMFpFandHYnNDcytudm1IV1Jt?=
 =?utf-8?B?b3BadU4zazEyZjlJQkRkK0FhM2U5aWg4THNwUDBNWktiZXJ0alNWOS9ya2xj?=
 =?utf-8?B?WlB1TWs5allHa2o1UUlmZEJqMnAvcm5iYVhXT0JnS21uNGEvZXBsNFZtOWs1?=
 =?utf-8?B?cHd0TWkwQmdubEh1SExiazYwaEFEVU9TL2w2U0dBdU1yMEtaL1NuM0dzYmpx?=
 =?utf-8?B?LzVNRVlJYmNCN2NlRGxtZlhJa3A2dlNpN2ZWYUExMzB2YVpmZnZkSC9wd1dr?=
 =?utf-8?B?aG5RcEYrRFBWRDkxMXdsVjN2RWMvYnZicjhkZXFHSEp5cW1uRnhwVnlXSkxI?=
 =?utf-8?Q?n89I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDc5SmRGTEVSNTVQQitTbURrd0I3S3U1OW9yUFZVYkViQml4WFpDeWowM2FN?=
 =?utf-8?B?L21PVHBVTEVZMG5aVXFhQlFmZXF5azcrYXhNdGloU2d2MG1ZenFmWGQ5Y1V1?=
 =?utf-8?B?blNkcjgxeEx4dXV4Wm8rQjh6U3dkZ09hWU5sdENDOVJnMEJKRG96RmhWSzZY?=
 =?utf-8?B?ZXlUOFJ2dCtKRFExMmVuZFpLeGYrblhKZUVNc3JiZnNjQUdTQThWckI1KzlI?=
 =?utf-8?B?T2VxanNkT0lSTUxuZ0c2eWFaTTdjOG90U1lpUXZwakhzb25YR1Njd1dMM2p3?=
 =?utf-8?B?azluUHhVU2N2VkQza05lSHJyMTd2QmJianlVajNCUEgxQkFPZFlDVmVrUTRG?=
 =?utf-8?B?M0cxRFMzQW16SzZWMUdVOFNVenQrRXRHWEFxQlUrM2NydTREenJwM1l1dGFT?=
 =?utf-8?B?dWd4VDVDZ1lhM1JiVXN0N3RRWmlhTjd2Qm5EZHhmS3UyWU8wMGxrL0d3MlE4?=
 =?utf-8?B?Z3ZtTHk3SjdhQmJiQVVnQ2IwajRBaEJrSXFpOEJlQnQ5c0R3MUludy9ZdGxk?=
 =?utf-8?B?U0dmUzRHenErVitRQjZvM29OYWxIQ3ZxRmVRU1ZoM0Y4YW9KSjZlMzlTb1VM?=
 =?utf-8?B?aVErQ1d6QWdqaGwxbkFueHIzUGRaVmhiRys4ZW56c05DdzlWdjBmZUEzRnQy?=
 =?utf-8?B?QWw5aE5QL2ZPd0lwQU5vUklrQlFiTFZxOHlEdklrSDN1NlVyVld2ajRJaUVz?=
 =?utf-8?B?UEJCZTlnbjdGL1RIMWdZQ2xiZ3psTDdUVitwazRLZXM5d3ExRlgwSnpLenZw?=
 =?utf-8?B?bDFYV0xRNmwvUHJuQkZrSVpWeE5wNmVlcStpSXV1ZWIxb0d4L20yR2RGVWpF?=
 =?utf-8?B?ZU9XbkR4d2g1NW13MWFsTVFDRi9xWFBYLzljS2JUWU5kY1dHRmc0Y0dDcFR6?=
 =?utf-8?B?elo0cElBNTVRcW44b2tRdGlOYjM3cEIyYjJBNDliODRyYzh5aXRTaFdWa0d2?=
 =?utf-8?B?WXhSTm9id3lvZ2wvVjg5YXhaVEVMTXBmVmZremJoeWp3NzBSd2t3YThGVDJz?=
 =?utf-8?B?WUo5TS9oc0pzckdiNy9MUmwxUXdVMm1oR1BsK0s2QjlFQXU3L1VvQ2VENGpk?=
 =?utf-8?B?Q0laTW1CemY1WXhXUnc5bmhHRllBSTAyZVFMRVFPY1lZazNWZm5WSVNYWld4?=
 =?utf-8?B?dFBWZmJ2VHM3NTZGNnNhNDNxNGRLZ2JyWFZoaFUwT3phbDRSY2dHQXBNaE4z?=
 =?utf-8?B?elZibEswMUZIcE1HMzFCbk9QM29Sc0V6WFRWTWJmM2dLNlNYenVtQzIySFZw?=
 =?utf-8?B?UDlxd0lFb2xVeUo5ZUhJWHRaSGFiNDFhY00vZVpxVFpzMXJzdWJnc1R1Skw0?=
 =?utf-8?B?dE9HaFpYdmcwNkk5SVAxVnp1b3pid0NsMHl3QUd3RENJek8xbTFmaTVrWmdC?=
 =?utf-8?B?Smt4RXlXZGw5UGhUdGMvZlJRWVVFeW1lS0ZsVlk1WjJhQnJFNWFaTitMVXMz?=
 =?utf-8?B?VVd3Qjl2NHdMT1UvZk9vdU5rV21HalJHa2NuQVY1clZGZHhwYml3dnVpUDAy?=
 =?utf-8?B?UWROMGJ1S2xUU0hRL1FYa0NYa1lTcUpNWURUZGNTNVo1ajc0bGhRVlRwRVAw?=
 =?utf-8?B?a0tZUy9aenpkeWJCZi9tb0p1OFI5ZSttTjQ5aittWmRuQUhNemY1cjdZR0xD?=
 =?utf-8?B?a2Y3aUVIVmRGMGREWldIbitBNXR1UHlOVG1vN25WTUg1YVRmZVNEcWxnZlRC?=
 =?utf-8?B?Q25TcEZhdngrQ1hrdVNWSHd4UVJRUUJzaEsvb1hXVGJhNDhZSmgzY01MaEdH?=
 =?utf-8?B?VXQ5WndCL0dlRFBQSzVHZ3F3c29GTnNVdXBJZVNGaW90SFBmMlJyempPRVBu?=
 =?utf-8?B?dDZCWUVSNGdmam9KMXdjU2xwTTlMbjJQZ2l6Z3RVUWtSazd6WFlXVU1MK2xr?=
 =?utf-8?B?ZG82YkZhYWxWT2NSdE9WQ0J6R0hhN2dRZDlnK0RKK2FMWXlxN2YzaFQ4OUNq?=
 =?utf-8?B?SXlRV0lIa0hvZ28vRkRZNExnZkdsQXFpS2lrNjhjMHgveWlkRnpQZTFMRzBM?=
 =?utf-8?B?V2N5Rmd1WVJOK2JOYnU5dHUzSlJFU3ZEcWNUTHdlenBBZ3lTc0JteTR0Nkcz?=
 =?utf-8?B?WVl2aG5NTWxqZC9ycXVqOHRmRzRGN3FZQit5T0M1WnJLcnVEWW1MRTVRajlR?=
 =?utf-8?B?NXBFanB6UGI1TjFkRGJxQW0rNHZob2N1c1F6YzE1SzdWejFxa3FaYlYyRjRD?=
 =?utf-8?B?RUlLUGNBb0NoV212RFNVeDQrbEo0K0RMUndKWFk3SysraitCYVJhVjhPeTRr?=
 =?utf-8?B?WXJJNzBFaytZNlhUV1RSbTZXQjU5cDREYjJlWkFrZWtXNXkwWVpTYXkxMXFB?=
 =?utf-8?B?czFMUVdadjBOTXNkSEZzeTJvYU5MVjI2UEU1dDZvc3JleUNCY3Znb3ZnWXEr?=
 =?utf-8?Q?T6tUVHlShY9af5lJEzvM/3R+BJxYOVKbOLFtIUa2IHVA4?=
X-MS-Exchange-AntiSpam-MessageData-1: taQfcJq5eRrpmg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3b58f2-4a73-4376-c30f-08de62313ffa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 08:01:20.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsGviyL3Bv9PLkkQ+//FxYLZsWPX/UTS0iVKk96eZkHsa6vcE532o2QtizFp7b/mlG2/TD6eVHN3nGOulTzkig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

On Mon Feb 2, 2026 at 3:40 PM JST, Dirk Behme wrote:
> The commit 600de1c008b2 ("rust: pci: remove redundant `.as_ref()` for `de=
v_*`
> print") removed `.as_ref()` for `dev_*` prints. Nearly at the same time
> the commit e62e48adf76c ("sample: rust: pci: add tests for config space
> routines") was merged. Which missed this removal, then.
>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

I noticed it as well but you beat me to it. :)

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

