Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638812D46B4;
	Thu, 12 Feb 2026 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770899343; cv=fail; b=jN3mU0OfXo2UTwPOmZYlm7pYQNel6g6+yeL8YKia24dDu22Ca24CqERyzbdAWT+BI9XatNUFSzvS6biC6P8sEFlFc2G7/J3iZm/9xm2mEeXQxDjf/IEoIDXKBnT9PX27iV71e5mDTZZniDSsk0nU7sz5G2EynSsTJouMaVPHLeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770899343; c=relaxed/simple;
	bh=lmekrPrsxpwKMWQJWGVBEqnbGndx4GxDG/Ng13TpeSc=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=VphSLGgfjx/OfBT3wQ06+IcZiJ1zGS693TqX6slwK/+C9d8j1GkOzQ3MW0uk5cYmls/Ll224EP92rhL/BjeeTralJuyfoFgeKnO2bSzXiSkqnAS3CHMaM2jMrGIPECeMoH5l7bru2OcbNdU7KzNbth/LDmAKVBPdYpuC0BMw3kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tgyq6rmG; arc=fail smtp.client-ip=52.101.85.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tgyq6rmG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7BrOxKAqB5GuggLqhbp5BdPb47V/ntY3TszpjyeZfXdFPbt5Ccg+4qumRUjtg8tZ9rG/x6RCckT9WsJCyomT/Ws/o0hIIvVgb9lBktLfHHG6vSyhELhausN4OCCyV/ZaJUmEZ+U+5Z5uvFWJ0vUSWKuW7hg+K3ubIE0qFPDgxgFj+9wZy/xaa/5LYWJhXsnqbuInszRONe7pO6WFGKh17ZbJbjHktkStJfaEyo9NeRQsfT3TVklKIidzIgfkTGzUJ1eWleicsZEd7ZCpnaluHqPaDZXgvXriR0YeMIzIQQLCiDhq8MwPHBXWPR4e5jt0EXURKvKRtsDitng+lipjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmekrPrsxpwKMWQJWGVBEqnbGndx4GxDG/Ng13TpeSc=;
 b=HGKS+CPNUMK971Dao9k2rA8Ca4yBcyBVg5s5FTgvvNfJHUbEmWe8rA8yt03Le/B3go7Mbt2E3TbrElFwK2sSr7Z8HxTue9n1evAcsaXUeJM91utnnuNBGYIUgyKUfYa971nNwdZyTAxEtfP+3472f7++VoZ6rBPzArNtpeFUJ6MNHMZLVGVfhe8ymXzfhd28Z85yJEdwou6K4fZxWV/SSYDwCV5g3JHhzcDg+fYU+H1r52gxN/Fi0U/Iplg9tVEcYqi3kO6P1CsIB0nbbTpwi8aOEt1EgNTtoL+nokBf7iyoEnkUqly+P3QW/D5JRn38L6DEmV9mwXZLxLegUPvqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmekrPrsxpwKMWQJWGVBEqnbGndx4GxDG/Ng13TpeSc=;
 b=Tgyq6rmGVOldDLS8ZxuVBauhPFV8K1IW2tiab29UchBUqSEK818RnAujwtnL/IzrWVNpinVDjvjed7l8PW5Lq0qfn2Jz6xoA59hPOtf49yDsPziITUej9MnFsMHjo4lhz3IjAZSnN9iK/xcrT2BWpv+9/NsaJsTBs0QEEkJiyKK9D62n8R6ycuOD9U3nN68GJgvTkx+D/BfELRz4w2v7o6mTwE6djKxsZS7OZPMJh7Ecs7oPWKnzln1mwMr4nYsak9a7l8l+sdpHJHDZFTx3ymCLDJY6fBak0pV/x8oKVlRoAY1SlqSU76E4+ZN9ztTZGjbT311vRzmlvCyAA8H6fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 12:28:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 12:28:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 21:28:55 +0900
Message-Id: <DGCZF7HF09D2.I8ZU6A0KM91M@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: <lyude@redhat.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v2 0/6] rust: io: turn IoCapable into a functional trait
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
 <9a6adedbfd04eb4c6aa49891453de5bc5cd5bf16.camel@redhat.com>
In-Reply-To: <9a6adedbfd04eb4c6aa49891453de5bc5cd5bf16.camel@redhat.com>
X-ClientProxiedBy: OS0PR01CA0022.jpnprd01.prod.outlook.com
 (2603:1096:604:25::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: f18920c4-cfd2-47c8-d389-08de6a324be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b05icGJGUnYzWGNndzlVajYrTmFxdGFrajNnOEovTjcyTkVpVjZYUGg1c3Jh?=
 =?utf-8?B?dnRxWVJSOTY2c1RqNE12R1Jpa25OK2tTbXgvanZHU1ZkcldPVy9JUlNNN1Fs?=
 =?utf-8?B?SEVnQmY3V2wrK1RzaWUxU3RJUFljTHp6Z1RFOEI5NGFKbVphSzR5QzRRa1cv?=
 =?utf-8?B?V2RkRWxLQnBtYjNOMTJzZ1lndlQ0MXkzamdDMG9FU3hrWUxzU1pJbC85aWRk?=
 =?utf-8?B?enB1T1VnajRDd0lSZHFZamtwaERBdVA5aUZRN3EzNm5GeDIwQ3JYVHBxSEFF?=
 =?utf-8?B?R2JMRmVqbFhFQmNLM2YvVFhWSzVoaTVuVGpJRTRkMVVMSWVTMS9ydlNtTVNt?=
 =?utf-8?B?ZlA1YWUxTzM2K0dySlhvU3IzUkIzWjN3Z0lxbVdlUUFycnp1MHlNT2dNeTJz?=
 =?utf-8?B?a2tyWjdGVGV6UmVkTTBzeEhMbDdIR3IvRmVoVHpqc3BhbThOdkxITHM3bnVF?=
 =?utf-8?B?dUhSNDJ5ZkZNL2JGVVZaeEtOWWY2SVI4Y1RDVENpS2FxUkxIZENPSzlwUzM2?=
 =?utf-8?B?YU1RV3JLcTVCQjExeEtKYVZHZEsyejZ2Vm1XaXl1d0FSZzJNVmQrUm4rSDRK?=
 =?utf-8?B?c0kxTkdmUnFUSklYWFFkSzBIUFIzZm9hQ0hzazluY3ZSUmJFekdxQnhjeXFm?=
 =?utf-8?B?djArOGVQOThiY0lSTG82SHNzMyt6N3JCcDNBWU03ZXpmME0yeE9KUjBmQTkx?=
 =?utf-8?B?bno4TVF6SmlQaTJTWnRiaWNaTGJhbnd1TXVaUUxkQ1BCcU1hZ0VIZjA1TFYv?=
 =?utf-8?B?L1UyK1AxWUNMc3l2a2lmMkY4UDdxU3BKMUtsazVOaGFzaG5kZi8vTDM2c2FX?=
 =?utf-8?B?RkpXWWJPUVgxcnB3c1VaMFFhdllPTVJ3eWJGMWNIN0xCT2pvNDlub3hmNHVP?=
 =?utf-8?B?K3dsWnRYNFBpQnR6dmY0NFIrRlRpS2poa0ZaTUpuM3Z0ZjhpaGl1UloxSE9j?=
 =?utf-8?B?cnVnREdFQzRZK2VBbS90d08raGpqQlpFZHMvaWd3U2Y3dmsvQm1JOUlqdnFm?=
 =?utf-8?B?KzRTRlJUQ1Rvc3E5MHRSczJhdlpvNlhuZTBxOGt4VU5LdWNYemo2cGhhdXlQ?=
 =?utf-8?B?dEg1bHowZG9FSEdZdTJRQngwb1BaNUxkbEdHUUp4MG84K0p2b3pCaC82cU1x?=
 =?utf-8?B?Qm55bldBNHhXNk02Sit5dDUybmFTN1pzcDRVdFZkUXozT29NK2s5VnMzWEJH?=
 =?utf-8?B?VGEwQkFWMTFIL2dYdHFnTnBCeVREWU15QzA3b21UV2xuMVk0N2cwYnNmQkNQ?=
 =?utf-8?B?S3ZyVXZ1bmpabGdLaHAveUZrMC8yTmNjclE3VG01dTF1SUFDNDhwbUdUVmtD?=
 =?utf-8?B?V1M1RDg2Q1lHVGtPMFZ6L051WXZKeVdmWGJ4VVlTU3EvSDV2ZnQ0UzdEc3JI?=
 =?utf-8?B?SU5DMk9hMEdoZlVQRURJN0VQMDZ5ZWErVEpYbVpjYTBUMDFSNFRkL0MrMVVM?=
 =?utf-8?B?Z3pPM2h5NVU2Q1QzRGRLckpmVkMyQXhIKy8yYlh3Y1dlalhvdGhYMFpnUjRK?=
 =?utf-8?B?Q2JOQm43SG1OazVuMXBZT01zTlgvSDBwNmhTN0ErWlNYMDcyakxjL0ZOajFo?=
 =?utf-8?B?SWdXaGNEZDJpOWdLZVZqdXpFbzhhbzlMYjJJNERlNDEwL05iWWk1TGNNeFJS?=
 =?utf-8?B?WmIyMmpkYWo0d093TXl3bGtPTVIrZzFFYWNuVE5MMm9xUG5TQlAwS05heUQ5?=
 =?utf-8?B?Nm1kVi8zM0F4VDB1cWFOcFdNR0R0YzQ2cUlUcjdBTDMyRHYrMWtISk43S2JW?=
 =?utf-8?B?dDYvSFFYT2ZvNXZzTGVwOG9HVDJObTlSY245T0UzaXJlREY5a1N4S3NRTlk2?=
 =?utf-8?B?OElqY09ONzhsL1NtWGZyaHpZYnViVlFSR2J1NUJNeWVmTkNiWDNlcW8xemRQ?=
 =?utf-8?B?YmdyM3pLZHduODAyclhHb2pFM1pWT3YyeHdBZ2NwWGtuQUJBTElWMW80VkFG?=
 =?utf-8?B?T3lMQXFhNkl0Q1U4MFQ3b0xwcXMvSVllNCtKOVVXUXVTK2RlQnVEWmw1RXNR?=
 =?utf-8?B?MjVZTmV2bGxPa3MzVmV0RUVkQjJpNGNNbldUL0UrMDY0V1pHbXgrSTN2cVdp?=
 =?utf-8?B?bndiSDVISGNvbGJUeTNPYUYxM2dmR2d0N3pBUFR5M2VuWFNNOGlZelAxWDlx?=
 =?utf-8?Q?OGTw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGFSdEdQZnpTdWVtS1Nwb2dvdm84cUVFZFlmYmJQaElDOFdsN2R1d1hRTjEw?=
 =?utf-8?B?T3gwb2xSTjltM3Jaa0VOMEdzdVNIYUZVbWNyMVJQdjRGRDRpUzZXLy9YWHR2?=
 =?utf-8?B?Nmo2VFJWTWJNVTRMdkZGRlRjdDUwY2ZPaDA3aDJwL0hqSm1oTnoxWnpTd3hy?=
 =?utf-8?B?WU5wRWZHc2t2RUFmUy9SdithK0Z6Zy9Ic0pzNEgxTlJQWUtldk1CelU0Yytv?=
 =?utf-8?B?U1VsQ3ZGY3JGcy91N3ZtUGJISXZ2VlNCdHRsMmRZTE5pbGJIdUJjUkJIcVNV?=
 =?utf-8?B?Q0dIRFFISUZVREo1UStkWjhoRVNSZGlmWnNKQXVBajRXRDlqdWhVb29OelFK?=
 =?utf-8?B?K1JsUnJ0ZTgwSzVQZ3g4Qkp6NEtEc1BkWFg4OUFpTVltVi9YNnJIa1o1ZGJx?=
 =?utf-8?B?VDFqd20vRjVZelNEeHFrZ25oWUFkdWVJSGNTTWxRYURteU9tNHVjN1MvTzhs?=
 =?utf-8?B?SExmZ2w3TG1xelJQZFNSdkFqdGxoU2RXU3kxYVNTMGhNL1hraXFJV3ZzUG1r?=
 =?utf-8?B?a1BuNjBNa2xXZ2JhUWQ2VVFMVmg2MGVremdMeHpucWFKL0EzNG1MOStLZS9E?=
 =?utf-8?B?azR4T1BTZ3J5WkVaWUFhT3MvbUlDVHhaSlpNcVIreng0bzRQQnZzc1BQb3dh?=
 =?utf-8?B?Rkh5bmRucVdha3RrTHpvKzE2Z1dNc1FlanhzZnpLbUhlNXAzRi9ORHdUclMy?=
 =?utf-8?B?VU5BT0YvUDBqK09TQWI0Ti8vWHdXRWFzS2k3UFBYdTFiZUdGdXVkN04xWEpz?=
 =?utf-8?B?anVscWlTVkhDNUtzQmJCRWI2eHVOdkxiUFJXVG9VSEdtU29pWmpvazUxN3lI?=
 =?utf-8?B?NnFNUjdoMGpGanFJcjVNN3VrK1JGZGxYY0hucldxQUhHVys3VlBnTk5CSFgr?=
 =?utf-8?B?STNDT09mVGVXakp5MGRUbFBBemUzbVVmSFNWZGRVMHVwa0ltTW02b1RheGxs?=
 =?utf-8?B?QWN5Q1VBWWJlYUZ6dVVxZjJHRm8xV3dJYXlmNFdCUzFERlVPSXBhWGttdjlz?=
 =?utf-8?B?eHg2b211MVU5Y01OZ2dJOGhiTmx5ODVuVEhKQmlzUXltbHJuc0tQUXp1YnBq?=
 =?utf-8?B?OFVaL0EzYUpBd3d3OERXampVRlVHdlFVQUZjcHFLNStJRVV4c3dsVkJQSFFP?=
 =?utf-8?B?VXBtZEU1aFRkVlF6M1F2VXlpYURRcUJYM0hNeXJlNWd3TjRmQitxWktYdURC?=
 =?utf-8?B?ejF3ZXhTdUdCblpIVENibVhGZ2RIOVl3Z0Y1eGpOTlZ3d3hnLzJTSU9oSnB5?=
 =?utf-8?B?SlI1NXhzNk5ISW54WStFcVRXNzFQSVZpMUYyeEFuZ0pva09venNuRm1sQ3JB?=
 =?utf-8?B?ZlZRTS82ZW9iYmFwNzJTRTdCczhBS0RsL0xNclhvRC93ZmVpZFU1YktmLzYy?=
 =?utf-8?B?dkhzTy9sN0ZtRS9CVk1JZTQwTFZsaG16bHRHc2lZd2JmcFE1TXBSWWM5dTIx?=
 =?utf-8?B?QTRpYzd2QXpOdUJwSW8vOWtta1pUcUFzeGZNVWRjVVk3ZG9BRWtTemdwN2lO?=
 =?utf-8?B?UWJRdEsvN2pJQ2kwclhqUFJINElpUy9BN1dZSXFSeTZHSUxmMkErMHJYZk9S?=
 =?utf-8?B?Qkh0S1NGRXA4SVdDcHVmdGdvOGVFbkdsbGxRd0VoZFRkejNzMjl4b2lOdnRO?=
 =?utf-8?B?RytlMXdxWWFZNjhXRXpkME42a3RsSTZ0cldiZ21oQ2JjdWg3czNuSjdGVSsr?=
 =?utf-8?B?d3RBS0FrVFZwNjRPbk1yYUtVcldrZlRTTlVrUzE3UGpDdHB6Q05lZVFENDdh?=
 =?utf-8?B?VDRBTHoycCtKbzJ1cGRPL2VPUFlDb21hNWZBSFdsVW02eERaV1d3clhwdTZr?=
 =?utf-8?B?Z1JTcTM4YS85WC81YVRRMUFwbVRjcHAzK1BnYlJoRHVRN3hLNmMzb29NUjhJ?=
 =?utf-8?B?K1k0bVk2c3FOZXpSVFlUeTYvTG5XVklLTWE3NnJlWndub1MrakZiSzZKZ0Y3?=
 =?utf-8?B?alk0SFdtVlZwaU5NNDRlTmI1SGh4bEM1Vk9YL3Nlc2l2dkYzSElEOFllUm9Q?=
 =?utf-8?B?ak5XaWFBSllLNHZhWERKQUJ1SXd0Ukl2elMyMU5ndnVNQXNPYUU2MlY2dkZr?=
 =?utf-8?B?VTFNWkVPRWpzVTBjRURWOTZRMCtVMGxXdTI0ekRMRG5zbEFUdTR1Wk44Tmxk?=
 =?utf-8?B?eVZ6dkZhaVBQR3JYa0JJRE4xZ3NWU09sTEFQUzExSjlEcldRSXltcEg2Z3d2?=
 =?utf-8?B?QjVvbE1UcnpsRUs4cy9XZkZucTNNc0Y5SnIzaGFxNi8rNzI3YktaL1crbEpQ?=
 =?utf-8?B?WVgyeXEwK2tmSVpEZmRSUzFBKzlvUVJ2dkJvcW16cmRYdDNKZGJKMmlZN1FQ?=
 =?utf-8?B?L2tmRlRVYXJieG14YVBrSjBtUGtQaFNCakJyUnVCVWc3N21MZkc1b2xmRnZY?=
 =?utf-8?Q?17ejHjfpq9W/4hg0BqMsn0Tw8cEgotZV/EarT4e4dKUwy?=
X-MS-Exchange-AntiSpam-MessageData-1: v60I7o8nDsXnmg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18920c4-cfd2-47c8-d389-08de6a324be4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 12:28:58.9112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRoxu9o5/ak9+wdP9WGyIuN+Mo3l2ob6agNDPEgJL42zCmIqT9AmIYuFAbsJRSFPhL7AhtPnTuPYozCMlYHA7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950

On Sat Feb 7, 2026 at 4:48 AM JST, lyude wrote:
> A thought that crossed my mind just now with this patch series while I
> was working on converting iosys_map over to it: shouldn't we have some
> unit tests for confirming runtime bounds checking works as well?

I guess we would need a mock I/O type for that - is that what you had in
mind, or did I miss your idea?
