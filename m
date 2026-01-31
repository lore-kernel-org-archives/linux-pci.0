Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838673191D6;
	Sat, 31 Jan 2026 01:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821433; cv=fail; b=ECtDVpIhaaBoXJhYlaGRMGP7bEiDb2bkNPDuBA8w+l6mFtYwzJajFj1Ue4+JmiND9OuDr+WqM+uv/To3rdgFV1czocsib0EY3Ozuf4xwkvxG9XKjA3jqwvONBRn9v5plm8apxjxJqmF6HO1Njj0AOOZMKysxbHW8ELcbMxi1zOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821433; c=relaxed/simple;
	bh=bapvAQ9tKHY8T0p/oNAhrBJaAOSAyuo78sML1WX+cmo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=PkL5uTUANdcT5Wm/tACSZC3BeuTzl/ZM7IjB5BZzNh1uj7b8r2G0OT9SKyDrlS1wMqII4yAuzG2p2G+SzK9ohT4glksHpGvHWClZEjGI3PD27PPopRgLOaGyNKZutZ+F9xlrYVhj7hfeb1w16I2xGWPvLTrjxwOG22h3n0H2fFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T2wKwy9m; arc=fail smtp.client-ip=52.101.53.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T2wKwy9m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pwt6pqI9UPszmX6xm34LVlqOVx+P6rVR+dqlhWoCNaJ8s+jmwAYSdg94K4ytsbYyTof1hB00teWLnOMF2kyVct6TbJHMc4Yt/JfA/0qYEPDGe6ljue9B0I1+1uevOkbH9vnJ1/LmuAYICBqru1RpeA+kXo51kR9m/HNIk++msABVZrL5VAECd9yni838Ybnsz4vFeCGh39fhrdXfJrLQvG35wVyTMa4/SRto8gCvfN6HWW41yjpGmCF/076Clqd/VhyaYj9ErC/8q9sPtF9Nug8LILe7rEKY9i9jx/wPG0UkFx5OfPfabMjHKYYKskA/khjGCUvJjcDtIVP7Tu+sBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bapvAQ9tKHY8T0p/oNAhrBJaAOSAyuo78sML1WX+cmo=;
 b=mkVU3njnvT6ssROw30MhbQrEQ/XUXuywpvWzMKssi+acny4Vug2sE7FwrfwVh6BFaHOebgB35O5jEQ5pqL+sYOyaSoM79nL6PhU1tx6J1inHFhxlpzmWokf9Qc+wRt82qv7TyfGMIj9jx13D9kztNIlm3cb/+F1l7ukE/rI6O45ObtfOotfZko1NARYPhbssT7P0eW8Tz7mVJPDcLfzoF/SUeA32joczJ5c5K/8+T+nfSiK+6XHR6Ac4fu0tOX64zbGW0CyxDEDP3gHgJjGdiiiNjdje1gIKZHXn1vHpzcHKeo/injDIoBYdwU4yczraSiZvKBBOQm8eAsTXq+tzOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bapvAQ9tKHY8T0p/oNAhrBJaAOSAyuo78sML1WX+cmo=;
 b=T2wKwy9mFpTFqAmGrkYZHfv/HAt9A/dB2Q/qn7pp9GQeOmNAWpcdHV3UDN5bx5H8ZF+4W+aotnPvaf4WdxB9s7mbBVQmOQMP62biD35svCnq2ygDJrdU8Pt2kqOTeEtg8QYRNmYTIMbPkOarlB3GYZ2tv+/UT7PY5RgBfYG9ydGSAKu7ElCPDIkcX42PL8ldaA/yy63nOwSHd+ZdKnD6VBrk2gMDTpimEgIaAUfy6inTybp8+vFSC/NOB+bE10QIbVi7AehPiOHz6oK+r08umplJzFjHBWJZNfmyhTK0MGi0mjho2M9S3V4mmJu8dCvkMVp6XcGMb0u/YphAOS2nBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Sat, 31 Jan
 2026 01:03:43 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9564.010; Sat, 31 Jan 2026
 01:03:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Jan 2026 10:03:38 +0900
Message-Id: <DG2DBZ94DAL0.XBP0JJSPL3MG@nvidia.com>
Cc: <dakr@kernel.org>, <ojeda@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lianux.mm@gmail.com>, <zijing.kernel@gmail.com>
Subject: Re: [RFC PATCH 0/2] rust: pci: add config space accessors (and a
 small in-tree user)
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zijing Zhang" <zijing.zhang@ry.rs>
References: <20260130171026.1138617-1-zijing.zhang@ry.rs>
In-Reply-To: <20260130171026.1138617-1-zijing.zhang@ry.rs>
X-ClientProxiedBy: TYCP301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: b6015de6-547f-42a8-00a2-08de60649386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzZJWkVaZklJWjhMY0ZVWjhsYi9zOEFjaGdzZW5QL3RQMzIrVnZnalg3NENn?=
 =?utf-8?B?K1JydTNXcjVSQVNsUlhnRy9DSnNsdGs1QUxOS0hRT0FUaUk5aEw1MzdPQUFP?=
 =?utf-8?B?L09VbTdkRTF4dUxpeHUvZEZMOFc2ZnozZU1UV2t6QXNTbUJ4WG5URDNyeG0y?=
 =?utf-8?B?OFJhRGpjUVNyajVzM1Uvd1I5YWRvaUdBM2FKeElNeXQzcVZuYi9GR1pqNTJm?=
 =?utf-8?B?NEt1c3BibDVBQmxOdmttRjdWS0pNeDQ0WVRndXZGMjdNcnNNS3ZyeHl5Y25J?=
 =?utf-8?B?eTBselI2VGRsbUhFeU9uRE9BVi91NFZaeUI2azdmb1VXRis4V1E3YVdpZWQ0?=
 =?utf-8?B?VnFRdTJxd3pTUW44aDBLam9kZlZIMFNWNUJZcndsWk0zN0FTTzlBYUdBSXlI?=
 =?utf-8?B?TFdsMVF3NXRlV2R4MnR2QmczUmN3Mk9ocE5ySS9BU29PVUtoU2FEaHg1S0Y2?=
 =?utf-8?B?bFlnTmhTSHVKeTF6dy8yKzNIc2hwQ3ZZbS92czh6aG5CNGJHRGhBbTE1NzZy?=
 =?utf-8?B?Q21FenorYXNxUWcwQ1F4aWhGTDNncjhZVXZFN0RWZHYyZkZROGN0dmt1QmxY?=
 =?utf-8?B?dTlkNVllRWV2bGl3VjAzdmtBdGh0NHV3ejBrOGF6Q2hyazFwdXJkb1lmQ2U4?=
 =?utf-8?B?MUlwZ1cyd2pHRDFLVUFrQjV2NExxckxXOVBCUUVHcVpCdXllb1BYSWFkWklN?=
 =?utf-8?B?Y0FJd1NuZm13VTdCbFdIU09jdXp2QURibW9ybzlqUG5uYUs4OEM2WlpnaVU3?=
 =?utf-8?B?TnNDZWRQN21kMm1hWFFMWGdzbkgvTit1S1RFdDF4N3VvOVpYN1o4YmYwZUt3?=
 =?utf-8?B?MHQ4SHlKNlFYRXRDQW9oNGs5L3JzcUMwNldiTnFtOXQ3Zm1Jdm9TMVhteWND?=
 =?utf-8?B?S01SM1F1c1F2Z3VnbDFDVmlzbmFFSE5vQVRoKzR6bzYrWFFTN0hhVVFncklU?=
 =?utf-8?B?WGhwS081WElsN2RZc011OGhVanI1clZtTXpvcWN3UU9sYU5uTnNMZ2tJZnpJ?=
 =?utf-8?B?Qlh1NmZNTCtoUGE5QXp1N2xEVXdGSjFhRFY4cjg1UitkMEtKSHFncFJ3N214?=
 =?utf-8?B?RVpTeEpmMmlLNi9nRnU4RlBCV0pwb2p1QzZ4NTBEVGVSbVRwYW1xa1R5WHM3?=
 =?utf-8?B?YXNJMXo4aC9VSStKdEptcDE4aHVKVHFSd0ZUczg1TUozRmRXWllIM081WnBI?=
 =?utf-8?B?ZWkxOTFtb0J5UTlDWnVWUU1tVVRxanVEOEM5ckFSR2R2RGtkOGtUbmhTTUtu?=
 =?utf-8?B?Q0NmbXA0TzRpTUpYa1FEWURNWEVJaDZ2LzNoa0VqK0FOTkxvZU1VanVKaTVl?=
 =?utf-8?B?UDM4OVhTN3hPSFRVb2o2alp0VUNyVHExVlgwcTFjSys2TGRJUVRCbjBQa2VO?=
 =?utf-8?B?MjNvQ3p5OEJ2RUtyNjVBR3E1RHBqNnd2ejFsRVNuRlQvUWYzcHAvcFkvM0kx?=
 =?utf-8?B?SFZ2NVd4dllMK2Z1QmJSaXFaakhya01uOEtFMUl1cGR0S3UyR1Z6OVhENjVu?=
 =?utf-8?B?TmVpV2IxSG9mdmdCZG8zVjJ4SnY5cktiblpqWkU5SUNWM2pFRXAzYitmQUFZ?=
 =?utf-8?B?cVFBait6d2UweS9FaDlyUFAxYTFzcE5iNUo5RS83ZXhLaHpJVzF4b2Y1VDdQ?=
 =?utf-8?B?eGw4WWlMWWYzVmU0TDZyb0ZLVlZ5dkxsd3N0RG96ZjhVWUlVTFZYbDlvdERv?=
 =?utf-8?B?U01QeDEycTZ1TmxTZU02QmNSRDgyTXhwMkF1WjZDSGFnSlV2K2pLNUIzTWEy?=
 =?utf-8?B?VWgxdHM1bnJXZ0wwM0JkV0pBcnRvV09FZ0pJMERicHhjY2o4YmQyUDZqbW15?=
 =?utf-8?B?YitFVkFmVXY5YXdmUXB1cVFmZkxWY3prQ3Nua0tSWkRlbzZjR1JpYm5WRlF2?=
 =?utf-8?B?ZzBKZlFFdVRaRHVwYnBZMm1XTDJzdjZkV3FpUHRIbVAxWExTcnEzZEJwaHAz?=
 =?utf-8?B?WGp2RnNNRDQ5Zm50OGlSSmNjSytoQ2xHVFlSYWpZR09zUUJGeG1rUjlJa09Z?=
 =?utf-8?B?MFRRaHVnVnE5R0VqampKRStYcFVFcEJDSFpvRGp1K3UrSG1YcXJMSHY2Nmlw?=
 =?utf-8?B?YkZST0VROSt5MG1iWjA5ZU5qRlo1bncwaHBOT3F1RVBJTHRpM2hNRkVSRGU1?=
 =?utf-8?Q?NixPEaGM5X2BPNWiXqlzkeI3z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUVkTGJ6c29jVWlNUExwYU4vQUIzK0wxOGVoWU1YdHc4eHpCUUdLcUtNbXM1?=
 =?utf-8?B?czd2VlA3TEExTTM3QVl3VUQ3K0dzYXgwd3hTRHVxUlQxT21qZ2wzb2J4UzJE?=
 =?utf-8?B?THFUMmVZeEU0eVRSblJvWEx6RjdCQUlaOEtkUzd3anVOdGlYZDZyZFpFWmRK?=
 =?utf-8?B?MHQxSSszLzVLSjFZYUFacmhPY0tydmw0RGZhbHlWMWVIR1lTSEdOS3plMnJz?=
 =?utf-8?B?a0JYUHBSeG11dTFyYmRGaE1XcEZjOHc3S2VCSFdKZFlyRVNzRUFTckozUWR2?=
 =?utf-8?B?ejdwemJFL2oyNTVHM2hqaENHQjUrQmhhZDVhaWpUdjVrNHhkVGt4OExWWmhv?=
 =?utf-8?B?WWdRWkg0L1BYU04ySXVKcG5LRjBaYU8yT1g1b0NYaHVhQjJ5RjluY28rd3JQ?=
 =?utf-8?B?TGJVU1MveGVXc2FSUGRnTjErMnJjSkpWWU1ZaWhvbkFlNGVsR2tqZEtaN2gr?=
 =?utf-8?B?b0VJNHR4WjJ1bE1YMExHOEFVQ3hieE9iQVlseVhQciswVmZsRStWRS9BMzRC?=
 =?utf-8?B?ZlNFSU04dzMranBBWXlVZDMxOUpmYmMzVVdndnYvS1h6RHR0SW5ZaGF6Z29j?=
 =?utf-8?B?bGREaHRmSGRSSm9pMHg5LzN3MlBBTFdnN2VvQ09OVFVyZ2U0dUpQb0hXS0xn?=
 =?utf-8?B?ZXN3MmVwT090VXBFT3kyWmRJUUZUeHZEL3o5V2xlcTMvYlJ6QjBWSTIzNVF5?=
 =?utf-8?B?STRucTlNQVNVTldHUzA3RVEyVXdHZHYvd3BhV0NjRzJDaDRGUUtZQWNQUzFX?=
 =?utf-8?B?am1JVU4raHlEN1J6NjRlZG5GS2NIZVByeDJwSGdLMTZsbFN5TTFBNXdnZUZN?=
 =?utf-8?B?dUtNQjk2SnF4QitlRXFTaDUydk1qdTRRZmhZRlRZekkydjlZWWlJYmVVazhy?=
 =?utf-8?B?V3hKYnFUOCswWFBOUkdEM3RveGFrdFJBUmRaWkdqM3Z2d1I3SmhZQ1JKRCsy?=
 =?utf-8?B?bTJNM0E2Zy9zaDdxNGpiVkxVa2IxS0lQa1VvWXR5aGo0eVUzdDVaYnlrMXhp?=
 =?utf-8?B?dU13QmE2YVlLTkl5S0RGZVNHSTZiNEkvd0tEWTViTHVNdFhHQ2NMeXpEZitn?=
 =?utf-8?B?SVJ4M0JQNFk4ZytNVDRpK29hVU9sNXE4TFhDYVpUVXdSWUQrcmhVelNjdU1o?=
 =?utf-8?B?MG1lc0VtVUtwdGVxL0hBczJHeVVWbTZDb3pNbzgrSHhzRjd0RnEwcnF5VFFj?=
 =?utf-8?B?ZnZkRnJaK0JyZy9FRDNHYnpmVngwK01IZ3Y2d0xGNi81U08wd0duTFg2aXQ3?=
 =?utf-8?B?LytjWmFMUU1CTkdibkV2THdLb3QvajdMakpuVERkUThURWVFaEQxeGpxT1RZ?=
 =?utf-8?B?MThlWm1zWEp2ejZnYklMaGRpTW5ka2ZNUzRiQXlSbDljRWgxR3p5R2tncllj?=
 =?utf-8?B?RjNmTnR2RFFTS2loNlVGTVBVZjBQVmhBWmJXdVJQR212WDdHeWU2OGJVN3RG?=
 =?utf-8?B?U0R0ZmhnRDhKUFlXVCtWV2pYL1RLQzZ4Q0ZoREpDbGllUEJkemxwd2J5VUVv?=
 =?utf-8?B?VVRsU2ZqcEQxZTZsZFRTK3N6UHlHcDdqaDQvWjMzWGdkRGRLdXRRSWNRbDZl?=
 =?utf-8?B?WHU1S3pOMHBpMWdxWDlXdnA3Qm5RUzhheWRTMDdMTW9TY1JJLy95SG1rU0h4?=
 =?utf-8?B?QzExZ3kxNWxnYkZoOHl4MlZUV1hsVXVJeEZKRm9TMDBQZEUrY2tLa1B6bDFa?=
 =?utf-8?B?dFVMNXo0YTlFbHh3RmprZGo0SVFPUHN0UVV6UUVySUw3aUo2djY4K3k2VS9F?=
 =?utf-8?B?TTNmaUNSOUFkZ2FWK0tRVmlnblZjbGVENXRwdytPajg5R3hjaHgvb0VhRDlv?=
 =?utf-8?B?N1lXaWFzWGNIZFJDTTdDSURvMlhubFZkYWFJdE5sK2FweCs4UkdvV0w1encr?=
 =?utf-8?B?d2ExYjBkb1FWRlUxN2N6RDMzOGpHUmVjUTViUzR6dm1tQmRYUC90SkREdzZv?=
 =?utf-8?B?Q2k5K0p6ZG92WUptcGI3SVY4YlhWS0IzRVVVeFhxTkRQaVJDMHBnSTlvSElS?=
 =?utf-8?B?TEd6ZjdRTmZHcFdnZjI3QVlINjYyZ1VBMHRFYzYvZ3ViMnJOSjdIbmdUSDlJ?=
 =?utf-8?B?RVZKSjlEbTRaSlZ4a1prRlI3QzBRa09DaEg2SE5HQUczcWNBZ1U3RW5zRW1a?=
 =?utf-8?B?MHQzMWE2djRSeGFIRCtzb0lOT1BBUkNGdW5xVmZ6c3BoQlZXTHY1TTZtWEti?=
 =?utf-8?B?QnBjTUZCNHZYWHZBd1BjUEhTNFptWTg4UUhsQlZ6a04vY1BzL2xETVV0QTk2?=
 =?utf-8?B?UFVGSEZ6Sll5VGJ3WlYyRlFScWFxWWZ1ZFRYdlZVQVlVaTNsSEs4Nm81SkpV?=
 =?utf-8?B?aGRKZjNjNkpOQUdHZFhUTVE5cnYwRmhibkU0byt5UkN2aVpxSStkSWlRaE5M?=
 =?utf-8?Q?j3LVAkoF9ovcvYsO4xGYn2yzHrYaZPDd+DLeK7gg61+3W?=
X-MS-Exchange-AntiSpam-MessageData-1: Hc8zGXeU36gZtw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6015de6-547f-42a8-00a2-08de60649386
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 01:03:42.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkCwauTojpOeoyh88bRjR7IDwndJmPIHds06xKZCwWng4t56vpeN8DFj4bFs+vepif+yGzfTDLfHf85VSrc2gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173

On Sat Jan 31, 2026 at 2:10 AM JST, Zijing Zhang wrote:
> This RFC proposes adding basic PCI config space accessors to
> `rust/kernel/pci`.
> It also includes a tiny update to the existing Rust PCI driver sample to
> exercise the new API.

The following has already been merged:

https://lore.kernel.org/all/20260121202212.4438-1-zhiw@nvidia.com/

