Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020102.outbound.protection.outlook.com [52.101.195.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094D44DB85;
	Wed, 19 Aug 2026 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137824; cv=fail; b=OjwNpGEzLc8DLRjBl3RPrx+QLKkuCgW27kC4gECsJtX7qU++2FWCUpC+DXLsDK5Xt15GjXB107J93kxFrQcI0oqt626X1s4zNiBKxsZZgKKiVMHgbVxVFRFpyZRvK8pscraL9nry+LDvdYGSTaSjHYEcEfy1dpBaPOyFiwgYRFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137824; c=relaxed/simple;
	bh=Oc6il3mob2qKpIkIHez4KvHV59qL0UPnl+2Jiw3cI2U=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=kM9EusxDLmR/ob4wcIt1QcNauelYZczwamiDZsyx253BcHFp4/MQpCtrLWY0L3No8tI76QjwjHQ9Ks+FVTrvIm2KhmOntKii3kIbTigu7b0XSLeCr0xAhZgGShDvfYRrtLdgHGFu9fpX9sJFwkkP91V7wHSAgGIg8a+RXNVKkUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=L+CzTY2r; arc=fail smtp.client-ip=52.101.195.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="L+CzTY2r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDpvgoOSnvg8sWGhMZW0L2oJknk569HnlzVMuH8qEoShydl3tutBUuZjWyHmcFKpTenVkSTEn256yYGC3XKFBTARcJutUnpMWbNhRJS7W6j9/sNjDS7qlYI5T/PQ5FL02jp1Kq6wdPzh0JUQlzIe031oUpL6TLQQJHtk8tlgLRgBx69gwAMod6LmqeSH+qAXg5mVEgX4OHHEJUcrqYvyiFh89E66IInG41re/LB9t8srf/xssmSugTl1m70J5cR+3SP7az4m6SScJJjAWnmQ5BNC5BfN4Kym8fKWatB1uH02mlklTenhc5+iiEmJlO2PLYEs838mOpky3Y5B2vmdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlx6uZJKCAWYot3eMOTrDAcO+QvdlmFruwPUoamhrBo=;
 b=rGzaxqkVDJPgpuLBTossfFsPtD4VbSDAuBtol7QIdPJ6eCwJe58yXgVtpnonTWK1NgW9q4Y6vzX/CTa65W/7rOPGq7kUhAdE57LO188ia68LGf09cx+Vxl/OUCoE2oMF4PAHzrK7rr0jdUuLwsnYPYvHag3UX79CT/62DWMY4SAZj2QbVjzV/sjxi9c1ljZmJBYyThknK7isKB4xdXFrFCYMVUvUPIPrBSfzyfPBS2A48/zpgxgB1LgMIVuiIagr4+1CMGb+bi2lBV61tOtL16WX2D8hz8y9ZRp/M+Ejilk678Ewjab3Z5bnonZOKR1cIDe/GBitbJMDGr4Gm/VGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlx6uZJKCAWYot3eMOTrDAcO+QvdlmFruwPUoamhrBo=;
 b=L+CzTY2rCf6tidxGycJpeCtMIqhevtBiVWRNylKOA1yaIpXqRIMlr9zz0rpqGoLBifHOhMjU+lhVjTEkyxJ+Z7baMIk1Ls+tw3hvt6jQ46V2DYfreoYOjfUv2XqGlhdZ4nNpbLUZNcx4YiUVUBJIDnGZ1vRztt6RIgpE39SVEvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB5167.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:283::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:15 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:14 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v3 00/16] rust: io: support register projections and remove
 relative registers
Date: Wed, 19 Aug 2026 12:09:08 +0100
Message-Id: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANWOhWoC/3XOQQrCMBAF0KtI1kaTaW3FlfcQkUk6thFNS5KWl
 tK7m+hCRFz+4c/jz8yTM+TZYTUzR4PxprUxZOsV0w3amripYmYgoBAlSB6mjqqLo9r4QI7LsiB
 UGSqiksWnztHVjC/wdH5n36sb6ZCU1FDoiSuHVjfpdDe2H7mlMWwfmMjUaSLeuum1apDJ+jtgk
 FzwfAdVCaqIHTjW6Ka6bzeWAksTBvgAe7H7ASACOtMocwAQKL6BZVmeMq/MRCUBAAA=
X-Change-ID: 20260721-typed_register-176eab3abee7
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=5528;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=Oc6il3mob2qKpIkIHez4KvHV59qL0UPnl+2Jiw3cI2U=;
 b=Mj5gefuhwNuFKI6PH/GWDk6/tpVKNS0IYBs06CTtpOCOqNA09j2JFZWJPXYw1lwDIfWOxR7T+
 jpx0UZrKkajDS3dIGxNTHiWRpCLJ9nYam6gJl24npJ3D6vpuEqCkJDn
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: 167100c7-00d0-4c2d-9b5b-08defde271bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|23010399003|376014|7416014|366016|18002099003|921020|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	1av63k7nrtQeNO7DMvcP47ZtXDaST/UpW/vxKOMXi5sJDildDPS5pTSuqZFGq1ZlwaOcNP2Ws2sy4g6clGY2PETm7VPBcLpfL6lU8T06dFWrXkKDPKmeD3Mt+av6WiuPx3isB2J6Ggtrx9TygBzVjAb639Mk3G49f2XsKkv6GJcuBqqvZNUZPIApZzkMml2HgaKUyP9cLgCRyBUVD3/XEQpq/esDRWFbGo6b5JiP1Gfw2SJGMc8bW7jWJ4tuUrCQqFffRfvXD0LuxZtcomD1H4MYjXqCrotOQax7d7+V3kJAIeHqeDM4iOCA2eucqxk08gMGx3B8fuvLyMwYaub2MBypT42WAfYtbq23as5ZJB39BwiiVy9HjDvZt1l3cFQOrGq9vyLGyf8ZCKsygoPbUt5sKzt3kGF30tpbvsw+1bmqpyPXnMLetkDc96eLl0p+P+UJU+q0MfSSDm/wjtD+4sNwrhL5iTBdotKXzLxNeT7xv7Qlqo5afaxH03CWcv0hWySm9n/kU0Q13YzGItOKRlV5l34SmAxE8xSXPRlFBmQg+dgrvl/kr4VvzXbyOLAuDfXz0RJPsCx35NKG8foobaqug9Sw977z2ZoSImfvFf/ljrxkR0Sy8/aZKlezqyvGNjUlCtVN6p6YxM3MDvQWxNJ3Bp0dJttcWUidI9gZJTY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(921020)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2QyWUdZcStYYkhGV3h5SHJTOERrTG9UalVGcXFSOWJBRWoxUFVxL3lhMDE3?=
 =?utf-8?B?a3VPMmR0UkhHdVlCR2d2dDVKMExQdWZYMFg1VjEyb0QycXdvc2oyMGFHbmVG?=
 =?utf-8?B?S2dYd243azUxeXRuT0ZSYzZUN01qN1RMNkVldUVKcTFQemhEMVgvbjVaWS9I?=
 =?utf-8?B?UFZ2OUNXRis0K0lTcXlCQ0VBY1VWbFF3cXZmQXpLc0ZzSUNxUmRjdXpHSmNU?=
 =?utf-8?B?YXBaMzRsdmdWOGxMVTJSdEk2L1BkMEJCVXJTMzVEU1E3Wkxlb0NUQ1lqVGNB?=
 =?utf-8?B?amowWEc2dTlrbjRFdFN6MlB4R1BGNHVkT3hIRTVCTEN1ckE2bWlCTVJDb054?=
 =?utf-8?B?V1p2cHFmSzZPNGJoM21xUGlIVmNPRGsxZklUUnIzZlp4Y2NkVWE5aHpvY0th?=
 =?utf-8?B?SUkzYmxkd3plRk5ETkpJNENkQ0t6a0U5cFJpRUplMmsrSm1sZ2hCYjhsRG0x?=
 =?utf-8?B?ODhOdlRwZ3h3SDFxNHBKVThoaXBidUd5RUMyT3ZtN3AyVVhTM3pxUE5FcnVW?=
 =?utf-8?B?UzBqa0hqTXRwOVNna1lwNnAxbi9jclBaK1Y0SjFUNExBMTZla1FvOVpmS3BU?=
 =?utf-8?B?ckpWdUs0b2p2QlQydTdvWitQSXVCUXNIbGp4eUw1SWE3Y3QxTnFzY2Q1V0tQ?=
 =?utf-8?B?MmlTY1dDR1NlU0xoNm9yMXM0bnNRVlRMT1NYQWVHOTFYRjFqWSt5NFBaOEpP?=
 =?utf-8?B?VFFkS3IvZkFWYzNacUdOdGtCR1FJMzR0eDJJaEN4RmUzaTlmZTJUZmxzZEYw?=
 =?utf-8?B?Y29jQzN2Q3BEak55TU9CR01KVFVWODd2cFhRanVBVzExQ2xlWFZhK0FuQkZl?=
 =?utf-8?B?eFlabEtJUU9INUszRXhZL1VLNDRmVkhZRytOYUtpcDM3OWVuYmc5Wm83cjVv?=
 =?utf-8?B?RlhiTjh1YTFQRlNIVGF5RnFCRHNEYm12cW5kcUduL3gxRW0wSVQweGQrNC9l?=
 =?utf-8?B?M2dqU3lxTHN1TWVMVE00Q09TN2hqbDZQQVVQNTVrM291ZEtzOGVHVVo3dG9X?=
 =?utf-8?B?Yyt2M3VmaWtFNEcvWGsxOTAvb2V1aFdjQkpTMWV5c2N6Y1hkdnFYeDRWL3gr?=
 =?utf-8?B?RXFIVUJtUGxxYUlQZTU4VGx3dDVjTDU5ZzBGSG1jRjZDK2huUG1RUGt5d3F1?=
 =?utf-8?B?YlNyLzBXeXdjTUMvelR0MjJsL0RLaXFkOENiM2YwV0dvVTc0OWErcFZ0SmVm?=
 =?utf-8?B?bW1pOEcvM0JzbkhpdlgrVzhORTcycnErazJLY0dzV0p0L1J0RXpnUFp2S1hh?=
 =?utf-8?B?NWJjMVdJZ0g0UWQvem1ycE5HQmZZbkJ6TjlvdzVlK1FPN3B0WDY5Z2oycGJ0?=
 =?utf-8?B?bHpuTEM2QXVZVWdia3hQWCtCSDd3TGQraXR3SG4vTDNENFJJMFA2M2xMVGhY?=
 =?utf-8?B?RzhYbkVRa2kvREZPWXNqZnoxamVXYzhUQXdOcDNORjFOSW0yYS9CUm16Wk04?=
 =?utf-8?B?Y0hIN3BEbEl1MFcrbDB1TWtWZ1hhT2xuQ3AyZnJMWXNaZWMwS1FtZkNoYXdI?=
 =?utf-8?B?amhGeU9mVDlObDJEVTZ5SUNodldtZiswb2NFc3lCdis3TVhmWS83cUdVQldO?=
 =?utf-8?B?bWhhRFdBR1FaVjY3c012b2hHZmZybkdhTjYyMEFqajNBQjJ2ZXA5RStxTTZZ?=
 =?utf-8?B?MWZVa3hIaU1XSEZ6SUNyM0hkVi92MDNrbkZBbUtrWVNLTXI3NEVzNzh2aFVm?=
 =?utf-8?B?c2l5anNvVjRsb2JBVjVoNWlOSXJ0cElndFBUY3ZMYnZDREtSZVhIOHFIdCs4?=
 =?utf-8?B?Ynl6SVRoMzJ3SEN2cXV0eWo0MlpwTlRXVTVlM1ZackR5NEVma0orcElzSXQ0?=
 =?utf-8?B?d3IvUW02UnFFVmh1aEplRHhDMWJNdDNHb0hvbUNvZDRmeE4zcEhpd1Qwb293?=
 =?utf-8?B?NWFjWm1OQlZIa0Z6T2s3UWhxbFpFWGhLZkhDRU4yZWs5YldCSHNZdzkveGpC?=
 =?utf-8?B?SDBSbS84TDV6UTc3cTQ1cUtnQTdsZU1LOHBHN1BkTFI2NVFRdFU2MjFlSkdr?=
 =?utf-8?B?UUdhZTBFQ0pvMTJuNFZxMkw3T0NBYVZSQUkzaXJPTG1PcExOSVJiUVVZb2to?=
 =?utf-8?B?RlE5OXE2L3JCWXI5VTJDTk83SFl0SEpoSEZhbHNzcjl0cjRsODNJWWYrcjhq?=
 =?utf-8?B?dFo0SUdWcjl1M2djdDZGTGx1c3pNV09DWklUY2VOVjhieTh0Sk5aTnR0T3hT?=
 =?utf-8?B?Wm9Ma3gxVXFKV21CeU9YaW5PREdFL1ZlTFlNejV0NDlLT1F5c1ZQYW10aVh3?=
 =?utf-8?B?czdCdnJxcjJEQ3lkbEpsRmV6LzhFcjVTaXdpRjF6QlprS1h0T0VwbldHRWlE?=
 =?utf-8?B?NHRUdFM4Mk5XR1pSaTlncGVOVzlVN3ZwWUdkaHpDQmlRR0lmejJsQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 167100c7-00d0-4c2d-9b5b-08defde271bc
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:14.7424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6+tF3sykfyKTsFPijF6MycxEn88BK6qCiUGW74MoWklV8yc/W/NBJK2r2GDbsPGNcY1PUSBjfJwLSHPg+PwUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5167

Currently registers work for all untyped I/O regions, which is not ideal.
It allows registers defined for device A to work for another device B and
there is no safeguarding at all.

Change this by requiring a base type for registers. `register!` can still
define registers on untyped `Region`s, although users would need to do so
explicitly and supply a concrete type.

This change makes it possible to use projection for relative registers;
relative registers can be implemented by defining new types for the I/O
subregions and just define registers for these subregion types like normal
registers.

This actually results in more ergnomic code for users of relative registers
(currently only nova-core), because non-array registers can be written to
with

    #[...]
    struct Subregion(...);

    register! {
        base: MyBase;
        SUBREGION: Subregion @ ...;
    }

    register! {
        base: Subregion;
        REG(u32) @ .. { .. }
    }

    let subregion = io_project!(bar, build: SUBREGION);
    subregion.read(REG)
    subregion.write_reg(reg)

instead of

    struct SubregionType;
    struct Subregion;
    impl RegisterBase<SubregionType> for Subregion {
        const BASE: usize = ...;
    }

    register! {
        REG(u32) @ Subregion + .. { .. }
    }

    bar.read(REG::of::<Subregion>())
    bar.write(WithBase::of::<Subregion>(), reg)

This also allows a lot more code sharing between I/O projection and
`register!` macro.

The expressiveness power of Rust declarative macros is becoming limiting,
so it is converted to a proc macro before new features being added to it.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Changes in v3:
- Convert the `register!` macro to syn.
- Add check to ensure register and alias share the same base. (Alex)
- Split transmute functionalities to `kernel::mem`. (Alex)
- Remove some stray trait bound in nova code. (Alex)
- Link to v2: https://patch.msgid.link/20260805-typed_register-v2-0-c3ca142220a0@garyguo.net

Changes in v2:
- Extract type conversion from `register!` to `Io`
- Redesign the API to be centered around regsiter projections.
  * Support register projections in `io_project!`
  * Support adding register definition without defining bitfield
  * Subregions is thus unified with other registers.
- Store projected subregions in `Falcon` for nova.
- Link to v1: https://patch.msgid.link/20260721-typed_register-v1-0-452d72b60262@garyguo.net

---
Gary Guo (16):
      rust: io: register: reimplement as proc macro
      rust: mem: add `transmute` with deferred size check
      rust: mem: add `AsRepr` and `AsReprMut`
      rust: io: perform conversions using `AsRepr`
      rust: io: support register projections
      rust: io: register: allow explicit base type specification
      gpu: nova-core: specify base type for registers
      drm/tyr: specify base type for registers
      samples: rust: pci: specify base type for registers
      rust: io: register: make register have a typed base
      rust: io: register: support fixed offset register without bitfield
      gpu: nova-core: use projection for PFALCON and PFALCON2 registers
      gpu: nova-core: convert hshub0 from relative register to projection
      rust: io: register: remove relative registers
      rust: io: register: remove `Register` trait and cleanup macro
      rust: io: register: unify handling of register with/without bitfields

 MAINTAINERS                                        |   1 +
 drivers/gpu/drm/tyr/driver.rs                      |   1 +
 drivers/gpu/drm/tyr/fw.rs                          |   5 +-
 drivers/gpu/drm/tyr/regs.rs                        |  45 +-
 drivers/gpu/nova-core/driver.rs                    |   1 +
 drivers/gpu/nova-core/falcon.rs                    | 157 ++---
 drivers/gpu/nova-core/falcon/fsp.rs                |  63 +-
 drivers/gpu/nova-core/falcon/gsp.rs                |  51 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |  62 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |   9 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |  37 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |  59 +-
 drivers/gpu/nova-core/fb/regs.rs                   |  29 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  18 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |   7 +-
 drivers/gpu/nova-core/gsp/regs.rs                  |   9 +-
 drivers/gpu/nova-core/regs.rs                      | 115 ++--
 drivers/gpu/nova-core/vbios.rs                     |  11 +-
 rust/kernel/bitfield.rs                            |  10 +
 rust/kernel/device_id.rs                           |   3 +-
 rust/kernel/io.rs                                  | 188 +++--
 rust/kernel/io/register.rs                         | 757 +++++----------------
 rust/kernel/lib.rs                                 |   1 +
 rust/kernel/mem.rs                                 | 185 +++++
 rust/kernel/sync/atomic.rs                         |   4 +-
 rust/macros/io/mod.rs                              |   3 +
 rust/macros/io/register.rs                         | 284 ++++++++
 rust/macros/lib.rs                                 |  10 +
 samples/rust/rust_driver_pci.rs                    |   4 +
 29 files changed, 1175 insertions(+), 954 deletions(-)
---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260721-typed_register-176eab3abee7

Best regards,
--  
Gary Guo <gary@garyguo.net>

