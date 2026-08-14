Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021117.outbound.protection.outlook.com [52.101.95.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC946EC95;
	Fri, 14 Aug 2026 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712732; cv=fail; b=FeziX1y1Rzhkl9Mtb8JdqRAILj0ir9J+x+Z+qOzhPkMZeLTqmrieiOyH0lNsK35qVnFsqgZA2Js/qRTXgWudIJhlV96TZnw6j5ZgzGdOwo6dTlS0qWDJ74fF3/ZcMuq6xZxFhY7y+fGX8slih3Tbv8nwZrhD92/Nbqvbk6I6srE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712732; c=relaxed/simple;
	bh=UDk6nOSkAT48IAETSZMgL9RQmAiE9LEnVdeh3qzJ/4g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=NpEs/XN3d19N9dFI7pX9PZHAb+kka+2khi4g6VB44wPjYtN9OGmeIZxbbYflGH9VTByVu1t7bsYFwsCxR+Mh1gntPGo2DHgw3dEIjBz+K1imWxZ5d9dB4KtWaLTcTSG/MY6K9ckba++pNjUNSkRNYKfRKt5yr4Ocu0p4TcnZgOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=EdLw4fem; arc=fail smtp.client-ip=52.101.95.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="EdLw4fem"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhY9ZAENzJb8W49vxAahrEkr5E9CnWFVW5UdLZR7NOkwzgbns8O+7cMdkVV0nB8OzU/rhB2bk9JJzD0vYh7/CBGCPkHMVgQGRYd5V+akAuLhesg8xJbA2ZHPIV6bWm6CNIJwqCs3aX9AqnHCflGmf/WcbDiS/GJuTU2Jv8pE0GRUcoJPcgO3Fnj0cwnZo3IPVJ4xR5l5+jo2HB/tVrk88tELBewfQDww5Gzv4oDvhTq1Ut7rjRedjbhBM5KlC/i956gNsf6mIvtOVy4Fit367hJTrXK3HrSUbAJ3uDCwDM1S8McePQhx9FbTJFD5hdGn8DSUUsJFFghd/7O4tT3tHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heb2WB+gjBpzLcCikgq5lLw1oJ/BlfFSOYMt3NnilFc=;
 b=R+bFI+mVKnj7F6UhTU1u3cPi+qvkcTsgfi5TjJyBZbYagCv3oA86UUXccfAehCztf/MugNq+1KeMB66DOqCDLGCcURbJBYSZmAq9XdmnABuo7mO7FwLSeUDRTOGX7XUE2QNAaLimBbXHHNnUpsRsHq5Mhz2STUkft4rjCXTlrX6ovxSzcTMfbWweUOVjXNZB/SkADiec7DBkp4wWIWb9SOg5XgfXxbD3feeBJdqmmYVWV7lQgnVgPvXdSSl9bSdijsud9TJq8/BUNI56hJXLfIaTe1eURjMcsI6Xq9BU9ID48rTE1D0YwigMmO07UZq0SpW/pRqtHlXvQvF9fIEXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heb2WB+gjBpzLcCikgq5lLw1oJ/BlfFSOYMt3NnilFc=;
 b=EdLw4fem3R2al4lMfDhRtFCc5bVuzBzD3BpPICp64ZgC3KNucggbA44ZnmdyII3OSkSR+UqgBxJ2T9RM7k6QK7MIEh1TtzvWm6/fcr2M7G68OjlHMUj4Hnf0CvHuxYzjRCKtPonciqGOZ4xWowW+dxPBimb7Hk6cF4Y9AVpPrfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO2P265MB3514.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 13:05:22 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 13:05:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Aug 2026 14:05:21 +0100
Message-Id: <DKOOSSXDVVUK.SY5IAXJXUX5F@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 12/16] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-12-c3ca142220a0@garyguo.net>
 <DKN1QEH1HWD1.1ZV0LWLNCZJTH@nvidia.com>
In-Reply-To: <DKN1QEH1HWD1.1ZV0LWLNCZJTH@nvidia.com>
X-ClientProxiedBy: LO4P123CA0310.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::9) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO2P265MB3514:EE_
X-MS-Office365-Filtering-Correlation-Id: b28162e1-53dc-4598-6c47-08defa04b2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|22082099003|18002099003|56012099006|5023799004|4143699003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZtQxL9xQXhbdSmoBV/j7InO/rWadIX47hX9F6k4cjpG1yr+/jsXDRB8m7W8TgqUsYlz6DQ9UqujcKFOUM+jOanq3awuUAlnjMj8CPQy8g7+uIMlWz1K2+DdE1fWKoz2vzQcnWGUYH3O/rTnSEjn7+CtsBjpDgxP46OWWQU6Yr0QJqD4uT+FVr5I9KfjAhPtpjtvGiLrsnXSQQ7OQ9Azej+g12jQIRnB8LWhnx0PPm5ROR2vtrZZQbtZGK0rD4te/qe8t+pSUE6C4xZfF9MsbT6JcfYUSNunEQUXUQS5dSiTxu1tunSpvqytjg4uRaiw7OC8BJ2gPzKOp+zWU5bruX629rV7zh/Hy19ycI3t6SJ6IDMvfiTELR+ONfa/L6T8/LxnffZYpc2Mf9//2tyuaPipgS9bqSRq4G3v9CYjcYqR1aPMtu4lSUfwGf9Ph48f7shB5bMX1nacYI8ZGw8+ch96RX6bDt+Fvn/w5FgyqffnZry6qAj8iRhAmti6ToQWs4N7GamQSXNauq1Jk2crFE6T2PGqY0r2zfiPqqChlIpj04Q4kbqvk8hfAppUBMFp2bP55j8I0ZDw7An2VeG24UZJ0RIu1fERMiyARLTPJaAONH7LUqGiAWw7GRZl8m0sY9LX4vNqNwH8VXUY0+NcfR+YWhmcJeyb8BzyzTdjC9xc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDVTUlgwZ0k1dE9jQ3VweGtyTW1DVGE4VnM4RkJTMlovbUo0UkJCQ1IvTXFZ?=
 =?utf-8?B?S3M5Q2czTkllZk9ka2k2VGFDcGx5VW5NMWpGazZLL0tkcTBZYllPOThKUCt3?=
 =?utf-8?B?WDdWNkFJTWlaWTdVelBSMHZmeUl3bloyc1BCV3ZrWmpwMHg4RXNmaWRMWkY0?=
 =?utf-8?B?by9GVGxFNGhpRVc4cWtQS21LSzYvc09YVmpja1JpZUVEWnF5MFprQmlrRjB5?=
 =?utf-8?B?OEU1UzlFK3RiUUQ2aVU3N3ZBbC9hUjU2TmcwTkRLM0dCNVpwU3l2b0dEOWVY?=
 =?utf-8?B?WjlhZU9GS2pEYnR4cUV1M2tQV3V6MmphK0lHYmVSay9LSTBZaTA0RXBsYWRy?=
 =?utf-8?B?VnNuRVhIU0Z4YWYzd0FObWp6RVdrTndwaWlaVHdkYUlDS3pZS0dqbXhZZVFj?=
 =?utf-8?B?RE15SzNieXJCN0d0S0gwMzJBTlhYK0ZYZFk1MHBBQ2dXWTlJWVgrdFBSZVZH?=
 =?utf-8?B?dTUxaVQrVFY2Y3BwNnNkYUxVTDYyN2k4VWJMVXp5WUxYMVNGZmhBOXhCUm9Y?=
 =?utf-8?B?Ym1HSEpLVEVJdlJVSmlrN2c0d1RUcTdvWERMcmJEaUZQV0gzK3NwYUR5cmIy?=
 =?utf-8?B?cjc3ZnBPOStEOTVEYmFpMVRzUFhaMkJ2dXl0a0VOa0VmOUlOWWpJNHp1SS96?=
 =?utf-8?B?ZjBTY2liRFcvcXZaNTQxTk9MVU1SajZxUlFaOXI2blIwVkFWMGV0TGVTbkgv?=
 =?utf-8?B?RUd0WEhjaVhJbzB6VERIY0J1QUdSOGdvNjF6SDFRd3YzdXRTZFNpeEZNamMv?=
 =?utf-8?B?RS9WZ2VhSGE1YXdLc1JtTlhUQlkrd3ZzdWRmRlAreUI2T3k2bWpHdmUraGI2?=
 =?utf-8?B?RDl0dUk1aGFZcUJ6NC96cTdsZCtlSXZ6Z2trek1tYUljcjBQSDExWU5sSzE3?=
 =?utf-8?B?RlJESlNwYkN6ZGZUQytINXBqVHA1N0NIbTlSSlo5eXIzV0ZJb3Q4MTRJcUVN?=
 =?utf-8?B?YjZNbmxVNGJQUnFrQitFMzRmMnMyOC9VY1AwQ0IralljcDZ6MDFZZitwTGMz?=
 =?utf-8?B?a29WemF4MnE2a3BBQmdQWUhyTTMvTjdNdTlmOXM5aTRVY0hoNzlIWWRMTkNS?=
 =?utf-8?B?c1kxZzlITWpBU1RvM2FSSFFIODNOQlhSY2RoK01iRkNxMHh5UktoWnBWVkd6?=
 =?utf-8?B?WEIrR2pUY205T1N6RVdyVXFaNHVmR0NDOHc3ZXlPUjZMWXdRMk1IM3NQNDVv?=
 =?utf-8?B?VFA1QVBhYUxGV2Fvc1JWTWdDaDFobGREb3JTYXdOdTN2WHJTQzUzZDJUSFhr?=
 =?utf-8?B?d2NIOC9UMFVoNFBEV2Vpbm5OSC9EdWp2eHgwc3YyZUFDeUtxcVQvS21rdmQ3?=
 =?utf-8?B?V1NJZldVcnY5bnI1OEV1MU1iT09hMStadGxUUVBOaFk2eFFCSkRJTkFOYW5E?=
 =?utf-8?B?SWJlU2VjUWYwOXloSDBMMFBHRWQrd2ROM1RHa0R3Njh2amwrR28vRWxYL3Zs?=
 =?utf-8?B?TUQ5Z2x1VTZXM1p6UTE0N0dWNlloV2Uyb3BEcVpMWGFRQkZ5bXRmcnByTmhy?=
 =?utf-8?B?bjdSMm90U2Y0cjk5ejVYMnNia0p3NkN5ZTdkVk4rK0pHd2RXQ3hKNGRVN3Ny?=
 =?utf-8?B?ai9CN0tyby9yL1NIYzBwZmhYSDBrQ3ozZGQycjZGYllYaTQwOVBkNXI4Rjk3?=
 =?utf-8?B?ZjhHQ0RibHhSd2xwaWI5MVZmY0FMR2x0VGxsaUVnd2JlMGpSUXYxRFRsY3RY?=
 =?utf-8?B?cm5UTDM4aEdEMlBqUHY5Ly82a1c5SVIzTnc1Njc5TVo2M3hrY2JSTWpEcWJv?=
 =?utf-8?B?S0Q0ZzBLa2JOdzl2VmhZLzR0M1NGUlUzNFkxQ2tBdGlFci9zaUhZUS9lOTU1?=
 =?utf-8?B?dW5HTU14c3g1OTljNkZFTWQ3Sm1PL21odElWNVNFRnl3Rk1jRzlRdVVUWm1C?=
 =?utf-8?B?ejVLdEJJMCtjRVQ3Sk54SFV3Q2cwS0hZelFtNGg3N2tkcU0rY3k3YjdocHlm?=
 =?utf-8?B?aUlFZDcxNytDVFgwQ3ZJblFpaWRKWWlXY0sydHpYZVpiUDJsUWU4VndNSEZH?=
 =?utf-8?B?VWx5QWI0Vm1zQlFXZGxSSm5LU3FCVXU5WEoxWFFGTmYwcXpDc0lMOGhqSUc4?=
 =?utf-8?B?S2hsRGx1L3VKeVVkRTV4YitVL3U3dWQvYmlxR2V6cXRkVlJkVVlMbklzZy9G?=
 =?utf-8?B?RmxuTUNqOVVRVkh4T3hHTTlIREJKL1crRlZZVThMaTFmWTJ6eXdKek5pSnNO?=
 =?utf-8?B?ejlIaGNXVU1Ea1ZVR1Z2Uk9YYW5NNCtZQnhrZjFvd3c3R3FpMFRWT0pSRFFi?=
 =?utf-8?B?SDJJbFp1RXpzbVRMa2ljWlMrQU1WYS9NdU1tV25ocDRBZ3ZsY0ZjSGF2OE81?=
 =?utf-8?B?Q1N1YlpKbTFBbUZHRmlwWExDaEtLRGRyUC9CbE54cVNVaTIyK0w2Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b28162e1-53dc-4598-6c47-08defa04b2ce
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 13:05:22.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHX4TTEBUazSmNc0u7zKwEP0CIamLDCOaMwaTZfgRSilUS/NY4nDxmHrsrrgPnpgm7cemmm8IFkEW/i0T+ox+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3514

On Wed Aug 12, 2026 at 3:48 PM BST, Alexandre Courbot wrote:
> On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
>> -/// Type used to represent the `PFALCON` registers address base for a g=
iven falcon engine.
>> -pub(crate) struct PFalconBase(());
>> +/// Type used to represent the `PFALCON` registers.
>> +#[repr(align(4))]
>> +#[derive(FromBytes, IntoBytes)]
>> +pub(crate) struct PFalconRegisters([u8; SZ_4K]);
>> =20
>> -/// Type used to represent the `PFALCON2` registers address base for a =
given falcon engine.
>> -pub(crate) struct PFalcon2Base(());
>> +/// Type used to represent the `PFALCON2` registers.
>> +#[repr(align(4))]
>> +#[derive(FromBytes, IntoBytes)]
>> +pub(crate) struct PFalcon2Registers([u8; SZ_4K]);
>> =20
>>  /// Trait defining the parameters of a given Falcon engine.
>>  ///
>>  /// Each engine provides one base for `PFALCON` and `PFALCON2` register=
s.
>> -pub(crate) trait FalconEngine:
>> -    Send + Sync + RegisterBase<PFalconBase> + RegisterBase<PFalcon2Base=
> + Sized
>> -{
>> +pub(crate) trait FalconEngine: Send + Sync + Sized {
>> +    fn pfalcon(io: Bar0<'_>) -> Mmio<'_, PFalconRegisters>;
>> +    fn pfalcon2(io: Bar0<'_>) -> Mmio<'_, PFalcon2Registers>;
>
> Remember on v1 when we contemplated using associated consts? Turns out
> we can with this version:
>
>     // Need a better name, but you get the idea.
>     pub(crate) type PFalconRegs =3D OffsetLoc<NovaRegisters, PFalconRegis=
ters>;
>     pub(crate) type PFalcon2Regs =3D OffsetLoc<NovaRegisters, PFalcon2Reg=
isters>;
>
>     pub(crate) trait FalconEngine: Send + Sync + Sized {
>         const PFALCON: PFalconRegs;
>         const PFALCON2: PFalcon2Regs;
>     }
>
> ... and make `Falcon::new` call `io_project` directly, and it works! At
> the cost of importing `OffsetLoc` in `falcon.rs`, but that removes ~30
> LoCs in total, and I'm not sure `OffsetLoc` should be hidden anyway.

Originally I want the type of consts created by `register!()` to be conside=
red
as implementation detail and thus ideally not to be named by the user. To u=
ser I
want them to treat it as just `impl IoLoc<>`.

However, thinking about this again, I think we might be able to have a sing=
le
type for all registers after all the cleanups, so it'd make sense to make t=
his
public API. However, I do want a better name than `OffsetLoc` if we're goin=
g to
make this use case supported, though.

Best,
Gary

>
>>  }
>> =20
>>  /// Represents a portion of the firmware to be loaded into a particular=
 memory (e.g. IMEM or DMEM)
>> @@ -358,6 +361,8 @@ pub(crate) struct Falcon<'a, E: FalconEngine> {
>>      hal: KBox<dyn FalconHal<E>>,
>>      dev: &'a device::Device<device::Bound>,
>>      bar: Bar0<'a>,
>> +    pub(crate) pfalcon: Mmio<'a, PFalconRegisters>,
>> +    pfalcon2: Mmio<'a, PFalcon2Registers>,
>>  }
>> =20

