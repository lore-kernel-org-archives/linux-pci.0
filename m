Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EEA7FBA2;
	Sat, 31 Jan 2026 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769831369; cv=fail; b=kGOEhn/JfCm0ORGy+DJo0ILHQAMroz7B24TK9EPtj1ii/+Njhg28xMK0xc3PEs1bzYmn7uTaCL7ZqU2iMgL45nmlZYQVqsvAJP/6YDaZnk+l6nV7vrVpHKBFwq6/nwBPMPZFftuS6/3waH4aXIGH1JXnvRRDMAWREC0V/Mt1S1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769831369; c=relaxed/simple;
	bh=6UwmTf5hvUsgzaRtgFz0nR0OB8AKFiBau4lvIngE618=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=LqOprvdOYJO3AfoVAEjpfChlr+qNAqO/cEFLQ4NUoxAAYQ1IgcS0GadLTuMzyqgKpmSXBd+4e+9THlNroTeTODQ8DM3mKAVNOgEAxMR9E2cLOBDgGkjQ58LmhukIUekANNaaPGVR2SCzjPpLprljX0GmHEh7El4WMz96OZ6VfNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rmOAaBdB; arc=fail smtp.client-ip=52.101.56.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rmOAaBdB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z66URhmsLehz8vKAgYun2EpfekRbLoqIGXhr+/Fc+H4ip7/hDXtwKqMQTLZDqGsncUuva/kfKEfWhZQW/Z/QOv2q24bUTDsOCpWMondItOb4RMu8TGgkreOPWTEUNwDr9b7tms7Pxyhm18bFDlmUHjcWcmJZdl8kbM3l2ZtoBlCRpdfyf8Kord3W2Qe/UkNS36eUjgWNO1hRAPXn2w5nqIhRfuuyqvvTOJuk0Bz3MbTvv8s47Dp+FSeF9hAkeF07OeKeMGO0p6rxaVOeiAYHZ+yXM3/YNx6mRUOkM0nZ4STYJM6Bus0OFi0cmoUnzj4LaGwQbWEFYPOPKi20xPF/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UwmTf5hvUsgzaRtgFz0nR0OB8AKFiBau4lvIngE618=;
 b=N6kSizGxOK2fXWvOWimxn0kGPQRmAZedtvlwGRcn5IZQjg97Uig25r4c9+l9lbnwPUR+WNpAF/NA2XPIym3zhf7miG7OvpWZEDPjAQswKbgals9kOkAjUfBslruU0L6bedejmgMkCN+rmHCJeUHp55hVJ2xCHrtpp5A+Xc9WQcV8OS/jzVqytj5n9WAcrTFUEPvMaY4wc+CtvpEXi58Mls4TL70Yolw543SFCDbJe3Jom2SrOkyxHHLhY6ple6GvmBUUxmjVdLc4pgYGiJki3J4umaWP2KW0V7xqDCewT7NpPSshJAWgokj/QljV4eyjS41ad4TqtFyR35S0Eiqfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UwmTf5hvUsgzaRtgFz0nR0OB8AKFiBau4lvIngE618=;
 b=rmOAaBdB5xvd1jtRUb7uRA22gh4JPtXUQQZXKw5MGTOAgx7eraI42xHV0GZUTp62I1Uf/d905wVmKsyr9MIwuyW941lfBMW1M8LZ3I7Z3Dq1QAE42Lr0bxz64ugDeHyvhQcQmc4AfJsNtmz63BMw98EMSi7wmZgcZJxv4+NggQGBLuTK6lLzqRIBO5xm/Ad/bW0FuL26/8gRYF67/EcPUG2b9jsuzBSzAuODB+CHrCHf2rpALE4mrUmdhRWB9pFptj8eej0/Rt2nDuPWnku7gML6zpJP/mjz3IBSipfp6tT81h3DpGHl96L1Wmu/sSUfAKTj2L9JzLYHrNy2M0Gj6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Sat, 31 Jan
 2026 03:49:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9564.010; Sat, 31 Jan 2026
 03:49:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Jan 2026 12:49:19 +0900
Message-Id: <DG2GUUAQLXYQ.JGJWIF8FEAFY@nvidia.com>
Cc: <dakr@kernel.org>, <gary@garyguo.net>, <ojeda@kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: pci: export ConfigSpace
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zijing Zhang" <zijing.zhang@ry.rs>
References: <20260131022026.1147597-1-zijing.zhang@ry.rs>
In-Reply-To: <20260131022026.1147597-1-zijing.zhang@ry.rs>
X-ClientProxiedBy: TYCP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 180dcdc9-1139-41e8-17c5-08de607bb8dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWc0Um5UOHNkZEhmYUlpNWl4NEdZclQzOVloOURyWXM1dTgrdHMzdXFJSTdP?=
 =?utf-8?B?TXpBck9mb2d2R1crVDNjcWlXWFlTZVpreElKMGxVVzBoZWx2UGF3WTgrZ0JU?=
 =?utf-8?B?UFdQcnJ6ajNiWnk0WjBoOTZhTlB3b21MTHNhcEhROHllb0ZyWEZxZzdJVHVJ?=
 =?utf-8?B?RUN1YjZhMkJ3Tm5QS2hHZUhTNEI1U2xuNkM3WklOQ20vNXBJS3dpakJ4cXhW?=
 =?utf-8?B?dUVXZldqd1pwWnhncEJvZC9td01sWjNnMHVGbnpJTmQ5S3oza1BTa2h0QTFJ?=
 =?utf-8?B?bkZnbXlxajdjWE5EUXdoTFJiWWhMWStGN2dWMTE3dUIvTHhRcEpIN1RFdVcx?=
 =?utf-8?B?cHo0d1FhUGNIVVpIa3pJcXhrTTY2eDI4aHh4KzJ4cmRRbVpPbGxmRFp1MU1S?=
 =?utf-8?B?N3VTYjJubUtKWlNaM3IwN0poSEVvc2hGajUzV0M1a0hEQi91Q3hiSkh2K2Mv?=
 =?utf-8?B?bW4rSndQWEZRa2NyL2lTZnh4VXNqQ3QydWFtaGtvT1hlMUNhZmdzb2tSUnRS?=
 =?utf-8?B?UXp0Z0xCN1Z4d0ZFYWtHYi9kUGJKbUh1clBHb1JBT0lIV1RqajV3WjBSV0Jy?=
 =?utf-8?B?T1IwMC9ncU1vdStWT242K0NOZ2FVblNXczVHWWpZUTAxTkxkRmJrSTFjc3Ji?=
 =?utf-8?B?NkRDNUMwd21HZFVyY1JkZXI2UEkvcjVFNCs3NXlEUDFLZm91OFB3Ymp6R0pw?=
 =?utf-8?B?eFdmdWFVR2pRSmxRcmt5ci80MTREVjhteVcrdnNiOHhjTVpjbTZEaFRVWHVR?=
 =?utf-8?B?RWs5NTNsNFBKVTJrcTRnUTAxOGQ3dlZLRE12UTFsdURCbGdZdWZjRUxZenRT?=
 =?utf-8?B?ZzRnUytrTEpScVl2S2VSTkRoRElCNGd5OXlYY05SZURCOTFWZnRDSW8zcEtC?=
 =?utf-8?B?T0ZxRDFmdTN1Vk9LUzRmNFpYaVpBY2FDenlvZ0x2cnRBTC9JNWpFOHk2WjlB?=
 =?utf-8?B?NTFXaXloWXA4MlNiQVlzT1JFSmgrdnU1enNmUUkvcXVReFlyT1RNVUtGenhv?=
 =?utf-8?B?dVNacVJ3Mk5ISnBhWHlWQ2Z6K01XTWM4UHlWdzJnSEY5RmpkSFkwSFNMUVI1?=
 =?utf-8?B?eEtEczlOdGxrUWZKb0ZWV0pDcjFxOEY0UGF6enRmMVZaQVZ1eWVXaUFISTlo?=
 =?utf-8?B?VmxaVm5qQ05nVk9BVmNLZzdTeHJ3aGtENE5SOXZKYXBCRXNKWDRPVXBKeEVJ?=
 =?utf-8?B?MlNHT05TbndpMk5KSWZOeVVFSGliQ1RxM0pVT1pJdVR5RnFDM3JWN0VFZFA2?=
 =?utf-8?B?NzZJYm5zNGtXZ0Z3eW5YY1FXdGxmQnhQM1l1M0FBcS9LOWhFWGwzaEY0ZDYv?=
 =?utf-8?B?bnhkQkZkUzA4akZjQWVZdUJ5cE5sNDRsbmdyb2tLb09sNmkyQ2EvRDZodWkz?=
 =?utf-8?B?MVZ5NFFCZzI0cFd4ZkNrRHF4QkNFMGNhRjNqUWNMcUNyUGdkMGp6ODZmWkZP?=
 =?utf-8?B?cUE4d3ZFVGZDSEM5dmMyZ2ZxcTBwZHVlLzZmMnQzR1liMXp1ZnJOK09lbGcy?=
 =?utf-8?B?VlhIV2tiNVB4R2d3c200Qk5aQzlUUGlaTUNseENVeHpDVUZVQXNxcm5WQ1c5?=
 =?utf-8?B?UEY4RkJQTXlvVlhhU3lCNlpyMFd2L2dnQmdHQ0tpZ3EvaDFFRktZYkdoK3pU?=
 =?utf-8?B?QXBIeUx5Z1pSZEdsVGxwQnZTcUlFZzVSZHNiZ2dBMTBvSUh0MkFZSHdhWmJF?=
 =?utf-8?B?SlYzKzMrZVhEeWI1RmpIY1Y5OFFOLzRlMVloQTJnOUpBaWFWTWRaZEFJQXZj?=
 =?utf-8?B?cFlSYlVWQzU0Vzd5aEpqZnNQSHdpeis5KzRUemNSak40UXh4K3lwcXBLay8w?=
 =?utf-8?B?WURNcHRDY2ovK0x0WE5YbEpuanBSRUJuYXdKWnkwaE9DTzkrOG9mSE14MmIz?=
 =?utf-8?B?VDJvVEIrNHhHRE1DNURMKzFJRWxDN280NVJ6TUVSalVPdHdaN0ticWNNbWMr?=
 =?utf-8?B?eU5BenVFK2FqSzZFeFlkWVNNdlRldmNic0tXWHlvTGd3Z1JkbnBNMVNqVDVY?=
 =?utf-8?B?K29RcXlvOVF0cWhPSTdmNGxJTW5tbzhTT29BOFBaSVVHUCt3eGdEbmNjZnlo?=
 =?utf-8?B?ek5yVHFGVHZyL0xSQXZvbnl2azNSbjBvUTBkbVBYMDJFZGh6TnZUOWMvdUpi?=
 =?utf-8?Q?nh64=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGl6eEN6TFRLbXMyd2M1TVhZMWZQaG1tckNOSnVOMWp6NDlBSzA0d1NkMHg5?=
 =?utf-8?B?dDZzZVNRbDdrUWp2bnB0ZXNyV1FDR3ZMa1F1SXhJV0pxcWNmMmFadEFCdnZT?=
 =?utf-8?B?TmIvT3dxcWhYVE11UTMrWUJxUit5QVEzQXVGV3RxVW1yc0ZFaXNOTU5uL2E4?=
 =?utf-8?B?TXZGZ1kxdjkxNjJFdzI4UGcycUR6SDRDdHhpSXJ3UjB0NWxnenVyc1BJMEs1?=
 =?utf-8?B?Q3pxbVorT3BlVlhCcCt3NU5PTmE0L05MczdiNGNwNUl2dkF4M3EzcmZDQzl2?=
 =?utf-8?B?aWc5V2haQm04U3FXdG5LMUF5ME5EbGk2K2tya0ZCeFV5dGFUMG5Ja2huTmNr?=
 =?utf-8?B?UDZseUxONWVkTGNnTjQvZUZPNE9OUFMyOHdzdVU4SThReXkxeHlzeHdsUGtT?=
 =?utf-8?B?R0xCQjFZM3dIbkdWb2RKY3Z5VnVMUWlZYUJXZk5PMzNnSE9sN1AvL0FYWHE4?=
 =?utf-8?B?RGZ0ZG9VaDhkNmZSVXFhWVM3ZjJFdVNEVlovYjhzOGdEZGNmNWdiekxHMU9m?=
 =?utf-8?B?cjJpUFYzSm5HK2RuVFUzSGlORmFMcWllT1ZMWVN2a2MwcEZDWGZUNnltSVk1?=
 =?utf-8?B?N1liWE96cTJOb0k1RkNsb1UzUm9NS0EvQUxqZnFlQnR5ajVBUndhM0E1Y0cr?=
 =?utf-8?B?em9FYUZDdWtTZFFVR1QvSGhnNWoyK085Ly8yR1FCMEVLRFAwVUZIN0ZxWmJi?=
 =?utf-8?B?Ymg3bzh1OUhjM0x6RjJaRTdYV0lzWHVTNEllU2tBTDFVbitnMnNiZG5jR2Jh?=
 =?utf-8?B?dFBJemZEa3k1SUpaWU5ibzZHM2QzOWx5OWVRbjJwdWRGdE9HUUZqVTR0bWc2?=
 =?utf-8?B?TkNWU3RSeEh1d0xZMjBTRzYwQkJvOS9kVUxuM0I0TUg3RWM2N2oxMmlIc1o3?=
 =?utf-8?B?dHZaT2JEc2E3RXE5Yk9TNmhDUnk0OXdFZmlzN0ZTeEQ0Nk43alJXd1Nsc2NK?=
 =?utf-8?B?NlhBbVhybkVNSWNuWFJacGRYSjQvTS9aR2JNMlRQYTRsRUVHY1JtTW4vUDlH?=
 =?utf-8?B?QWZHOGtSamNaYnY0bnZmdmlPdlFTaEJIeDJRUlZra0tpN1hWQVBaUkdMdCtY?=
 =?utf-8?B?OUF1aXVOVkVJQ2YxODFCTGVYZnNiU3Y2Vk1VOTRvSG4rVyttenVMeW9FQzI2?=
 =?utf-8?B?amN1TW85QldkaS94YklydVg1aHVLT1o5bG5XVUVrd21qazhyc1BqSTZjcElJ?=
 =?utf-8?B?ZGZ6c0VybDJGais5dGxPR25NaHlyeXJOL2tkRmh6VmZqQVhVV3U4aC9xeVpF?=
 =?utf-8?B?N1RyWWh0ZFErMVRGSzdTT0NPNkx5QzMxZTFXdnNQMWVqWWdCSDJaUVR3RUkv?=
 =?utf-8?B?OWlybXJlLzV3ZkxMNW1wSzltNWlRdytmTS9NcmZhbmhRNWJSYkZFK2ZZRW05?=
 =?utf-8?B?UGQxL2dtN0kydHNRdm5MeHIzT3dUY0ZyM1pqRWJLQ2JNUFdCZU1RRHUxQTBU?=
 =?utf-8?B?NVhVd3RKUFZqK256dFRxV2tLclNYdzBDQStOQVpLWk9CUlc2NXJzVzFzcTV5?=
 =?utf-8?B?aWRUQU1HZlNTVE53d01GZnFsVW4wQ1Q4MCtxUUV6SUlOZThQcGZobVRaUjkz?=
 =?utf-8?B?SFB4RHNoUllRSEZWTmtreTdGc1AxTkthYmN6NUZiR0s2cW1EdXM2REF6ZkRk?=
 =?utf-8?B?Q094bmhBNUg2ckh6cElpSFBOVVZRWi8wNFRnV28rSFVpTFR3Y2UwR1N4cDFu?=
 =?utf-8?B?TUdHT3lmTWVBU1ZLeEZHc2E2blpqK2VEQmtDeVhEVmJRTmd0dXkyK1VRTmdK?=
 =?utf-8?B?Q3V5TlpjclhQUEtVL2ZzaUVwZlRMcDlZSG42VjhkQmh0UUowK1AwcENHMlBH?=
 =?utf-8?B?blIwbWdBeXNyZVdtekIwaExPVE41aGk3ak5qSUl3Y2V4L0NqNml0QVJsTExM?=
 =?utf-8?B?TXcwZzgvZ202MVZBSUdSN3kzbllseTF6ZC9WRmlaQ1djTEFEOUR0TGl2dFRz?=
 =?utf-8?B?aWtqZ0FDb014TDVxWFFkZ2oxQk1WekY4dkFHQU5QSTRrd3VzeFJQblhlcXNK?=
 =?utf-8?B?VmRoK05idHBOcDVBSTI5cUxjNURncmhQRTRxWUtsZEhSNzB3SVJEWDRlRUJY?=
 =?utf-8?B?aGxqV09SanU5THZmdHdUV3lyNGxhUU9yZ3R6TC90cTdnSEttcVU3amhhQlVE?=
 =?utf-8?B?aEowZnFMUmo3c09qVk93WjVhdnFDeUtnWWNDSkNHd2lMZzhGNUp6eU52UkEy?=
 =?utf-8?B?bTdyQW9qZllUS2VNdGpETllkeWkvbjlKWEpGWGxsendhMDE4K1N1eHJ2UlhS?=
 =?utf-8?B?ejhpTklxTWhEUUIyR0lIdGdzMUNXK0wxY0FvRFJBN3hzM0kzWWhxaTN2S2xo?=
 =?utf-8?B?a2JJakFKMEszZG8wMFNJUWN1UldWL3JLREErY0NEYUVKWXpmK3B6dXZFOXRm?=
 =?utf-8?Q?M6Trgka2wvLMIaKg+IJ0607GzJOb9vutyj/Fy5UjQsTgv?=
X-MS-Exchange-AntiSpam-MessageData-1: CWtGgBT1eVh2wg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180dcdc9-1139-41e8-17c5-08de607bb8dc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 03:49:23.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubI2vg8AnF0K/OjmdQnDG1CxbZyQ+pFwmgujVoKn2iHfwOi7GxHkAJDnUEUnehirUAFeCiOkIhCciliYhOeyeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026

On Sat Jan 31, 2026 at 11:20 AM JST, Zijing Zhang wrote:
> Re-export ConfigSpace from kernel::pci so users can name the returned
> type from Device::config_space*().
>
> Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>

This should also have:

Fixes: 4dc0bacb1d3c ("rust: pci: add config space read/write support")

With that,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
