Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A30328273;
	Mon,  2 Feb 2026 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020051; cv=fail; b=imGxVdlQP133m7dY8MTik3d4ZlsC/NyGe1K2fFszk+NgywYXW0xC6kT+p5wnXfilS6sxrksMfRADH+ofr6Jeq82XwBBfKPrKWvgMXLFIQw2jcymIA8p4mB0zB9QP/ks/A0ORY8J4z7+iU0iv/Y5plLlXUMRQ3zpXpvkRA642ULE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020051; c=relaxed/simple;
	bh=f2HWLyuuEwKvpIMqcdxzl2UvojO00VUm2L8zG1/Skxs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QmDUj394xy4kGOaLeBGyh3AgIS2EaByolPcOslCESZSW0dwIlUpIjW8Q7Ep89JdSdweX5fI4hsSYXdc99nhsXO6J34M+kISYeDxUYWR3YGf1n30oDTO1onZwvHb0orvirswBbkORoJEHvULXHtq00sUX4DL8bNlm+5lNP86GNOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gIsvi+pd; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gIsvi+pd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKw6Y6et6at0hHErZES93HUGVY1Il+H8k1LLdBU7aT1zt4iJWGRqfdY3sJsQoA81tPKD8dkLa3lZrdLWQrPeNkvkPBgKOfe7SJF61qnhC6SELsiu8slY92QYDwY1QGMn2Yfey/n0t6ZaFhRS6AXBFGcGgToozXM0l8KAgnZpsfqRQf5WoILk/vEtbRRu2YVXHlJ4lnq0ocHUEnFFSgdmMdg6iIrguOhDYxw7eZJNoQwjs2oiiKmkYDW2DXTASrUsFnPdkuBDWd2N5oBJHwXXd7wHP5BDKjb/QqVVc0wmTDcyzrvyPZV+1//XwU/1EfSwcKiMxblbs3zfg3RLAu2/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjldlf8dliVrBChKUPVQGAPWqKsJT6n32/lLFg/yIyU=;
 b=O6QnNUe2qKskjhJ9szp/Yt87po7DZGQ35mLDzMXFRQx9LI9jfgKIQCRt9tIwITBPtNgAqT2WckRhT8pVYnu0l5Av0G51hCVRrnlvLFRnlqAtYFvgGZP83WziNrYYs2Yryys8VpvsTCSlRqexMYEZSNdTEaigBU81Bw7PhH6vJfu/rQHLalEwlmFeGBJS0LSUgL/A8inzpKGIQuUiRrLn1HKUtC5z4GrWBpw3whZC5WtnpRYbBClTOfXCsd85BLEBqWH+pnQLvyeblrkGW5Z432uGbYBBntMhuM8G3SOfWynCy3D7Mf/V5mYGhXFWfvl1HV/bYKlG2L2ZSGEK3i4CNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjldlf8dliVrBChKUPVQGAPWqKsJT6n32/lLFg/yIyU=;
 b=gIsvi+pdKeKvLWi+az5OSTJEaPM3MKRnowZsOoyFgmQSc3ggjkokq/hp5SNstwNB2x3NKhDaCQsulqWrQsOhDQixS3+u3l+uG2YELbtR90LbIwYkwWWCEu6Mh993ZqCxWNENH3ShDJfucmSsJoVoVcW5Bs3YMqn8TN+/4wnHlRZrcVqIi0yZQ8BmK9YG4VhbUtzJfrkgnjt+D0GK5UVt41sTHIZjfry+vRTHK3t4guAA/KlkV7eVCS3/M/xrJnI1r6J3YJXkfb7OgtRwe0Qd+nGYB+1MPgxT5W1rt5O2zH4RWWKtmRRNQq9hvM91oZ5m1LTem0vDeIA2CG0Sna8ABA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Mon, 2 Feb 2026 08:13:35 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 08:13:35 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 02 Feb 2026 17:13:04 +0900
Subject: [PATCH 5/6] rust: pci: io: remove overloaded Io methods of
 ConfigSpace
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260202-io-v1-5-9bb2177d23be@nvidia.com>
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
In-Reply-To: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0369.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: f834371b-76e1-4f8a-357a-08de6232f5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHhaaHBuL01hWXZ3N2hWclhUVDZSdEd6SXJhaGxkcUo2ejBTQ0FhK0FQMlQy?=
 =?utf-8?B?ZldUdDRBSm1rYWR2TTcvcnVPTWcwOUUvYUFuNlpVcEJGWVVPbkpEZ3ZJT1Jp?=
 =?utf-8?B?TUdqV1JtVXp3anlNeHJsZWNWQXY5VkxCNFp6Wks3cEp2MXM4akxOSE5pV0tw?=
 =?utf-8?B?eUJHV0FqcGZHc0FYVDNCNFNWVkVZMVJrSlNtOFkyd002UXgrSzhBTDZ3Qy9i?=
 =?utf-8?B?R2VhY0I5ZEJBK05PSzZrVjRHaUR6TWhCVmM3K2dXNkNyNG9kSjF4OURiYXYv?=
 =?utf-8?B?SmFOMFZ2bWxOc25uSll0cGF4M0QwaUs3VjJuK0M3UmdINTBDdmc3SytuZ2Fk?=
 =?utf-8?B?K1B1cXVHbGNvUjAvWFVSd08zS1V0QzlpZ3NZM0lxOUd1MlJDMkRoSWVmT2hk?=
 =?utf-8?B?dmhyMDRKODFvM0FBMGRlaWJDaWlES3dURktva1lFR0UwVVRMbk05dklWR2V3?=
 =?utf-8?B?bWx6aGtpaVhlQWdIWUUzMjVRUUJKanlMSUprbW5ndlkyTkhiY0pYdE04UThR?=
 =?utf-8?B?TkpINmJBWXhqaFg4ZlZsUWlEQ25Delp1dmFzZkdGNHptQ3F3OERrelZjNmg2?=
 =?utf-8?B?cUdPbUpqVkp0V3dCVWtxQU1uVHBtTEdTWW9zMmJKSi9EbjgwM2FwaEw3Nkp4?=
 =?utf-8?B?MzlrTmVLR3U5MnV4QUV2cURCMWFsbjhPc3oydXJuMExadXZDanZQcjBFbk04?=
 =?utf-8?B?OWlaM1JyU2tLSDdvYXo5cURtK2pOVldqMCtPWVRPM08ySGFrektaWGZ3V01v?=
 =?utf-8?B?TFQybXk4Yng2N1gwYlgwK09kVnYvNjJGVmJoWVF5Q1RiODQ5MVZRU0I3bmRy?=
 =?utf-8?B?WThJdnQ3UTdnSWlweDlRTExndzZuWFYwZXpMU2JIKzdJQml2Mlc2VTJvWDZ0?=
 =?utf-8?B?T0xLS09Ta20wV0trZk0yd2tTbzBDQ3kvMUNZNXRwdUVxaitNd1hMZkNQb0ZD?=
 =?utf-8?B?VFMrMkpZSkZYbEJpMG5oamUxN3NJcjlZeDA4clV0aHVCcFFoVll3UkxqbnZh?=
 =?utf-8?B?UEFnTjczV0NrSUFaU2c0U3Yycm9MT3NxTTVTeXpZMVhMbVc3UUZvVm5BcHNx?=
 =?utf-8?B?N1hrYjFvMGRaSFlZS0I4RnJWRHU4MlU3SmF4Q0JtWHZoL3M2YkQ2bmt3Tk1u?=
 =?utf-8?B?RDNhWlh5N2lyeWhacVVMNnNHWUNKclIxL04zRGZMTGozTE5hOG9BR09GZWwv?=
 =?utf-8?B?c0tSUTloWGdZU1p0NzdjNCtQL3V3WHpXdkRLaG10R2FhazN3UWxtWSt5U1Bl?=
 =?utf-8?B?Ky84SDlRaTd6Qnl1ZkE2S0taWGp0OTRYODJHTlBPUHFQTlBJaVovOWxBYTRk?=
 =?utf-8?B?b0YzZ2xsREhNVE5uMjl6dTZpeDh0WjJmRGxPYisyNEN5Slkzc1FpS3NrdG9r?=
 =?utf-8?B?eUpIYTNJbG01eEhhbDhVM2dnQlhNZnppVkM5OHNBbmZtMlpLZk81eGxOemEv?=
 =?utf-8?B?dTRRMjBlY3pWL3NTa0t5QmtFLysrRVpJT2R4dFNxRHRSeWhYOFhVT3lZWmQ3?=
 =?utf-8?B?VG1kM0w5UytNOUdvN2dFT3RyM1pkelM5dWFUeHJVUWNEUitpdlV4L1d1VlFm?=
 =?utf-8?B?bkl0TkRoMXdMS3pkWGRhWnBaZEJnRmJzOGY2MXU0b09tTU1DeTBycVFiMmVG?=
 =?utf-8?B?Zm9DWk9NUERKTDlpZkpIY1ByWjBVZ2NQczl3ckxRU2J6OEJDTkdkVlpjcm10?=
 =?utf-8?B?TzVzZ05wc05MVjd2aGptdU83T3hZcUUvTzJySENTQVlsRkdlUjJxaTF0TGxZ?=
 =?utf-8?B?TnZVTUFjeWliUEJzUmhadTlOTUxqRytBQnJYTTBSM2FLTTRUbWJqV0pvU0FC?=
 =?utf-8?B?NER3U1JRUmNvc2lpR1F1a2prWUpFYlpSN1lVWndzMlRnenVmN0JIajEwRkZj?=
 =?utf-8?B?VGpJVmVvcTIxb0lBT1V6dEdTOGw5WVNIbDJYWFJJT0U2bkwwaElORnRIN1ZP?=
 =?utf-8?B?SVBYeEpUTHRhT0VEWTVQNGFoRW00VFVKWVBHcGRYTDU4VHI4cHRHMStKeHdx?=
 =?utf-8?B?d0RvQitKdlNIelEzWjZxaHlXWDNRM1RmcWVUeGJtSUNjaDFvZ3ZtSVJ3ZTBI?=
 =?utf-8?B?bTloelRMYXZQN1pML2VrbmJpQmxLbjI5VnRIb25SYm5EWk55L2wzLzVtQ3Zl?=
 =?utf-8?B?ZjU0NDdHNmozcG9OZHpFWExnbTVSTDJxMWM1eGhhMEFwZWtLZ0dkSTJoZjJG?=
 =?utf-8?B?OHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1c1ak56emk1ZFEwM0V6QVlUSU1nWTA2R1FPSzB0S3ZkR1oyNlovZVh2enc2?=
 =?utf-8?B?dXJQdTBwM25UTCs2QldWYzZyYlh1VERHSFluUWx5cjdtcitHU2JBVzZlWHhs?=
 =?utf-8?B?ZVo4VWdtQlVMM2wwdDF0V2tlNm43SDQxWGkxc3B3bjhsZDl3L1dYTjB1RDRn?=
 =?utf-8?B?NTY2TzhVRG0yZzhmZmNKbDU2bVJHRW9Pa3AvaXpsQ3V0SGlja1MwWTkxaGYw?=
 =?utf-8?B?Yk5TVFh2RkRNSDB5U0kzUjZRdWNDcStoaUdVeURwRFdiUHBQZWNCbFY4QjBT?=
 =?utf-8?B?YVJXR0Y3L280Rzd4SEZUdm5Da080SUNNdCtiQ0htYWRpbytPN1hsR1RmVzNQ?=
 =?utf-8?B?dG1UdUZjWkQ5N1RkQjdMOFhXVzFxeWorWlBnS3hiS2toRDVTbmJoZzVPQmIv?=
 =?utf-8?B?WjNjVURhdGtmbmY5SHlRV0RNYlcrTzA0aEdhU0xYMCticUpldXJodGNXNW5z?=
 =?utf-8?B?T2trZGxwUHJUMWJ0ZWliYmxsYTl4N0JyaFVzZFZNT3ZRL1BiMkQrZU1LVlFP?=
 =?utf-8?B?LzFkWFFiVUpYNTFJZE1pN3FDVkxsY2ZzUkEvUkloU3FMOEFYU2UwSDRWb2xj?=
 =?utf-8?B?MHNCVjRKRXNFWGY4UGQ3U0xVWUFXY3BmeW8vTG9uWnBwSVBWTWUrRjcwVkkr?=
 =?utf-8?B?Wmo4UlMxbXpDQ2xCRkFZUEsyeis4bm1PY2JLNTFTUStzay9ZQVdDaFp0azBj?=
 =?utf-8?B?K2FQTzRVMzJvNzJaSVgyaXR1RzN6aGQ4STVpMklNb2VhMlFla1BRbysxQitK?=
 =?utf-8?B?RkVGWlRabmVXczVqR2RXUlljUk9NMmZlKzhuOVJaSDZFNCtsbElNbCtMWVdj?=
 =?utf-8?B?d2dEREp3U1FjQ002dzJ1YkhwOW01bHo2U2M4SlUwY2x0N05USTJwTVg0dnFj?=
 =?utf-8?B?YU5FQ3dEQWkrdU5CRVlnUGtHZEM2cksza2wxaHNvUmhzUGwzWG4vTzVzc0Vz?=
 =?utf-8?B?S1hsQ1pYeDB4YTk4TlF3cW9ldTlSTnRTTUFsdzZJSDhCdEsyMm1TTElUc0VV?=
 =?utf-8?B?ZkIzVmJBT0hhSTdOQnhzekFzRVA3Y0dqbzljZW5hSGhiSnU3NjU4NnBnVnVL?=
 =?utf-8?B?U1FaRk40T3dndy9keEM3akNtV3V6ZmZDUjlwSjlGdDZkMG9qVVBibWNEUlUv?=
 =?utf-8?B?OWFFN1hPUnRIbjBMSDRNem8wbVhFR1JOYXhmMW5pNzVVNHh4Vk1lRmhxNThM?=
 =?utf-8?B?M0R0MWxQNmx4OWRJRWtyVmJud1JUOEpFYkZsR2lUTjF2QVBaS01PR0ZsZ1R1?=
 =?utf-8?B?SEJPNTQxRVY5V3pFUlBoRTdvRC93V3NCYTl0QUtEWWNrWEpmYmpnQmMwWUNs?=
 =?utf-8?B?ZG50ZUY3MnFVSnFOb1lRU1lJVHpQTTFEWS81NWpZU1BhN2ZURlFaN25nS2FG?=
 =?utf-8?B?eW11MTN1bXJCczRVbzM1T1ZLcno1L3gwSXJZNlV3NGNZanNUOFlqQjloMmRF?=
 =?utf-8?B?bWloZFhBYXFDOStJeE9rV1Z1YmR3bi9mNE83KzFnRkZFUmRMcEkwV2ViWTlo?=
 =?utf-8?B?eHdJRFhaZXA0VjRjWEpGMkpTM1NEbjhHbVJGVVNvdW5URjkvczc3S3U2a3Jn?=
 =?utf-8?B?dFQ2S2NXbFF2eUZyWmZXbXV1N1RXVm9HQjQyUlpUR3ZuNjh5QWxuYlpkRGQ4?=
 =?utf-8?B?bktUbDYwYnMwMmlvVHowc21hd1kwRGFDNC9LRWF6dm5FL1o0WVJyM2JlU3pG?=
 =?utf-8?B?ZGE1em5rdW53SWdPWGZRQ1BFbU9RK3VCWk1TQ0pmL3BqcUpUYmp2OGtCaFhh?=
 =?utf-8?B?WGMxWm92QkR0U0g2S0hSeForMStzV0lFSDFvUVk2WCtpd2lEN0NIdjRWckw3?=
 =?utf-8?B?elNNbzdjNjc4MkxSbHVRbE5qZ1BwR3I3ZTF5UGtXU25iVWJTd2Zwb2dWN3k5?=
 =?utf-8?B?US9oa242QmRnR0RjS0dQb3doVlY3MmtQYVhzUVo0Q2dTa0dXdkNqdG1RTXM1?=
 =?utf-8?B?M3QrcWNDZjZqY1pvUkZKajJ3TGRaWEI0M2tOd0tHTkpaTUVSaHo1eWtKVnQ5?=
 =?utf-8?B?bVkyUnQyUFlwQ0hpYkxnVFoyd2FJMzRGWnIreEtNTWZVMzRYRW16K3ZSU3V4?=
 =?utf-8?B?RkZYbzllaFdPNVFRNE5iZVU5Mjl4enFEY2xqd1RNMUx5U3c4Ym5vV1Q1VDRw?=
 =?utf-8?B?ZE93Q3NOdGV3WE5HR2RqVTRFSU1lQmxsQzZncjBsQ3M1SERWZ05RTlhUWWpp?=
 =?utf-8?B?YmlDcHpKdXZRaWpwZWJacWR5QUdwMHVpUEVIRHBvQUpGK2lmL09sOTNxdFFq?=
 =?utf-8?B?T3kxTmhWK1BMeVlVdUtlOUNlMEx2c2VSWWJLTlFrMHZoTTIwSFhCRVRmU1Mw?=
 =?utf-8?B?S2RIbjNvN3VEOEtZeFpZNnRkajhITTRNaXBuSU5uYmNDamYvcm1TY0JIbjd4?=
 =?utf-8?Q?0xsYhO1+BHeUYIKpEUWkqSA929XwZ7L6O5Csncqj+N/Vu?=
X-MS-Exchange-AntiSpam-MessageData-1: jMNp+OV9H7mDoA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f834371b-76e1-4f8a-357a-08de6232f5f2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 08:13:35.1868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DBi4Xxg4NvgFFSPqYgd+7+lJ9CiaEKIdftiHJ7E/O5QMKikjSB/UhroRFUMFdqpnYS3mpRUgCpmpfn6ubFcIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416

Since `ConfigSpace` now has the relevant implementations of `IoCapable`,
the default methods of `Io` can be used in place of the overloaded ones.
Remove them as well as the macros generating them.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io.rs     |  3 ---
 rust/kernel/pci/io.rs | 70 ---------------------------------------------------
 2 files changed, 73 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index e1094a237ff7..0e8031dfe0f0 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -226,8 +226,6 @@ macro_rules! define_read {
         }
     };
 }
-pub(crate) use define_read;
-
 macro_rules! define_write {
     (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) <-
      $type_name:ty) => {
@@ -259,7 +257,6 @@ macro_rules! define_write {
         }
     };
 }
-pub(crate) use define_write;
 
 /// Checks whether an access of type `U` at the given `offset`
 /// is valid within this region.
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 8c8aab2e3f22..ae78676c927f 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -8,8 +8,6 @@
     device,
     devres::Devres,
     io::{
-        define_read,
-        define_write,
         Io,
         IoCapable,
         IoKnownSize,
@@ -85,63 +83,6 @@ pub struct ConfigSpace<'a, S: ConfigSpaceKind = Extended> {
     _marker: PhantomData<S>,
 }
 
-/// Internal helper macros used to invoke C PCI configuration space read functions.
-///
-/// This macro is intended to be used by higher-level PCI configuration space access macros
-/// (define_read) and provides a unified expansion for infallible vs. fallible read semantics. It
-/// emits a direct call into the corresponding C helper and performs the required cast to the Rust
-/// return type.
-///
-/// # Parameters
-///
-/// * `$c_fn` – The C function performing the PCI configuration space write.
-/// * `$self` – The I/O backend object.
-/// * `$ty` – The type of the value to read.
-/// * `$addr` – The PCI configuration space offset to read.
-///
-/// This macro does not perform any validation; all invariants must be upheld by the higher-level
-/// abstraction invoking it.
-macro_rules! call_config_read {
-    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) => {{
-        let mut val: $ty = 0;
-        // SAFETY: By the type invariant `$self.pdev` is a valid address.
-        // CAST: The offset is cast to `i32` because the C functions expect a 32-bit signed offset
-        // parameter. PCI configuration space size is at most 4096 bytes, so the value always fits
-        // within `i32` without truncation or sign change.
-        // Return value from C function is ignored in infallible accessors.
-        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, &mut val) };
-        val
-    }};
-}
-
-/// Internal helper macros used to invoke C PCI configuration space write functions.
-///
-/// This macro is intended to be used by higher-level PCI configuration space access macros
-/// (define_write) and provides a unified expansion for infallible vs. fallible read semantics. It
-/// emits a direct call into the corresponding C helper and performs the required cast to the Rust
-/// return type.
-///
-/// # Parameters
-///
-/// * `$c_fn` – The C function performing the PCI configuration space write.
-/// * `$self` – The I/O backend object.
-/// * `$ty` – The type of the written value.
-/// * `$addr` – The configuration space offset to write.
-/// * `$value` – The value to write.
-///
-/// This macro does not perform any validation; all invariants must be upheld by the higher-level
-/// abstraction invoking it.
-macro_rules! call_config_write {
-    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
-        // SAFETY: By the type invariant `$self.pdev` is a valid address.
-        // CAST: The offset is cast to `i32` because the C functions expect a 32-bit signed offset
-        // parameter. PCI configuration space size is at most 4096 bytes, so the value always fits
-        // within `i32` without truncation or sign change.
-        // Return value from C function is ignored in infallible accessors.
-        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, $value) };
-    };
-}
-
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
@@ -190,17 +131,6 @@ fn addr(&self) -> usize {
     fn maxsize(&self) -> usize {
         self.pdev.cfg_size().into_raw()
     }
-
-    // PCI configuration space does not support fallible operations.
-    // The default implementations from the Io trait are not used.
-
-    define_read!(infallible, read8, call_config_read(pci_read_config_byte) -> u8);
-    define_read!(infallible, read16, call_config_read(pci_read_config_word) -> u16);
-    define_read!(infallible, read32, call_config_read(pci_read_config_dword) -> u32);
-
-    define_write!(infallible, write8, call_config_write(pci_write_config_byte) <- u8);
-    define_write!(infallible, write16, call_config_write(pci_write_config_word) <- u16);
-    define_write!(infallible, write32, call_config_write(pci_write_config_dword) <- u32);
 }
 
 impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {

-- 
2.52.0

