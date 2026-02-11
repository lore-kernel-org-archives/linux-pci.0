Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC1B352FAB;
	Wed, 11 Feb 2026 04:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770782917; cv=fail; b=vE1Xx9UW3KWyEA0Qlh2hjzmCpdOGOHK+1sYgsScgDnmtSF039f9AIZNIaZPwBXCAS4fDOC4pJ5C++pA9n/91lbAMR+JtwH5v2wJYKGlqw5r4m6cmjy32/ytiR5LrKWlFUy4nIEi6zcFm1B0+drZKP6p1+kxM4P3eBqKpY9hXhHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770782917; c=relaxed/simple;
	bh=iUUdAuRRSlqxD1/EW3k1+6RYgEqEl9xOc/6h1WV0mpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lXmZut0O/QsBWVlVAbBDrtQOo0Bg3Ux7PGVMQu1ikmwugCkqB+7S4JIsBKwc9fLLTYhnxmyOeMWraTL0x10EMAZUK0WH8rm43yLg4TyW/+ztmrLAys21EFYvUUhHFPKCLtWMTikwCsCx0ClGfdIrVC4Tuj6/L2IHXTebaoeu4sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TOZ9yL3l; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dL7g/Zoi; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TOZ9yL3l";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dL7g/Zoi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770782915; x=1802318915;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iUUdAuRRSlqxD1/EW3k1+6RYgEqEl9xOc/6h1WV0mpw=;
  b=TOZ9yL3l+jiL5PWo7DBPwx/BkJcxu9GBcuutIK++Ve5oVP19f1zIk/yE
   BW8tK/ouqIamOkRbLUrtjM3RxBIiS+u4FFyKoOP6xtis+VsGyJHUJNpqg
   jd8s1fNUm+BYEiQHU3NaI2gB0ix9+UZGv0PXUbVDwYUnkArbZNMOQgCak
   pt/S5+l35blrHJCtaXmtwu/RfDTB/Y1WLpxuxbUBQxE/5AliHJMVacXau
   r7k8JEwDlgZlX0avtBo55bIQg1YEBpWNg6fVYXeCD15EH/7ERyIjOk0io
   2jdXmTUEpelOv/HYFHrdxJRKzh8jgXfuL0ulY4mS00QdG7EF8Qy/ysRW3
   g==;
X-CSE-ConnectionGUID: zMwNqFhYT72B5iKjX0MHMg==
X-CSE-MsgGUID: XbYiPVKTTVGFP8cZhjnVkA==
X-IronPort-AV: E=Sophos;i="6.21,283,1763395200"; 
   d="scan'208";a="140182100"
Received: from mail-westcentralusazon11013048.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.48])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Feb 2026 12:08:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BO2RZXyEWL5oStfj/bRt9IeCvpkSc7z66rEFkB+Os80MFa76s2LG2amyU2q0+0jA0HKdXy5c+jPiC43kJMdGJG6de84BC+Ho4Hud100fVeg8ww2rhBJZEbTqZJi9CdUVT/CCxjs10VpzBAc9QdA7eq1L0/vTzb8B2Lp7XRJx5Hqpz+4PdMsJLjzfktzPINOf8QzLFVSHbBAA5XiLkCjWxY77/N3hY274xJdaJ1F4TgAqil94awiCGUqyRUPxYJsUYoHv7Ddx4BmD8uwfW2mgOQcSM1ZmNAmOXbXfTV78h1b1ohZ1se0cKDMo++wCcnuo1rtB6SFie8afix2k272BQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUUdAuRRSlqxD1/EW3k1+6RYgEqEl9xOc/6h1WV0mpw=;
 b=y3TSbprmmdnN+7hpNlROogwpjQZIShT8tNjPBQZuVmvcL0v/6SvjR3bVqhbRRms3VUY8OxMV8O95HvxXIm8yzrEEViItfVQuSWwFaZiToYOlJulRQaf09WbK3a3p8+OElntK5koslE5cKrk3VV9qFX7dTSRjZbwE5Y1kcoqDZITpgvcc+Udy88Ujw6S8HIpNZlEPKlBeGULI12dh4Kb3T2WDY8z7f2zeNPXQi6J1dTh6RYXDILj06SVXoz8VnyYk8IJnVBPoq+ldM4x+hC+5/+yJrM25vGoKJUf5p1CSZsPg8siC1RRESz3DECRdW/DFpchQqNXVBCs2Rk3u/rYLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUUdAuRRSlqxD1/EW3k1+6RYgEqEl9xOc/6h1WV0mpw=;
 b=dL7g/ZoixijpWzaoPiBFyBpK+MfJ2RtYXNVYob0+tpBUO7pouijh3q5iVzU57SRx1BY4ikmPMz5UWChfAp5djm80Kj2dJMSqSGp4xNAzWVigyvMsh7h9BTUR4FBHoX1XhVO+XXUwLE+5DKl7NOL5UiifbLOdDKcSXgZdg3ePx5k=
Received: from CO1PR04MB8300.namprd04.prod.outlook.com (2603:10b6:303:157::22)
 by DM8PR04MB7928.namprd04.prod.outlook.com (2603:10b6:5:315::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Wed, 11 Feb
 2026 04:08:32 +0000
Received: from CO1PR04MB8300.namprd04.prod.outlook.com
 ([fe80::a603:6dfb:1d4b:b36a]) by CO1PR04MB8300.namprd04.prod.outlook.com
 ([fe80::a603:6dfb:1d4b:b36a%6]) with mapi id 15.20.9611.006; Wed, 11 Feb 2026
 04:08:32 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "alistair23@gmail.com" <alistair23@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "tmgross@umich.edu" <tmgross@umich.edu>, "benno.lossin@proton.me"
	<benno.lossin@proton.me>, "alistair@alistair23.me" <alistair@alistair23.me>,
	"gary@garyguo.net" <gary@garyguo.net>, "a.hindborg@kernel.org"
	<a.hindborg@kernel.org>, "bjorn3_gh@protonmail.com"
	<bjorn3_gh@protonmail.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "aliceryhl@google.com"
	<aliceryhl@google.com>, "ojeda@kernel.org" <ojeda@kernel.org>
Subject: Re: [RFC v3 13/27] lib: rspdm: Support SPDM get_capabilities
Thread-Topic: [RFC v3 13/27] lib: rspdm: Support SPDM get_capabilities
Thread-Index: AQHcmwbmiLa02ku78UqvhJXObL/2CrV84hsA
Date: Wed, 11 Feb 2026 04:08:32 +0000
Message-ID: <02ff28eb316f6b04f2e539a6d90b0761d9f60b33.camel@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	 <20260211032935.2705841-14-alistair.francis@wdc.com>
In-Reply-To: <20260211032935.2705841-14-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR04MB8300:EE_|DM8PR04MB7928:EE_
x-ms-office365-filtering-correlation-id: c583412a-fa92-4191-1675-08de69233836
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejZycXQ3ZXpMaTFZcVJGVkwzYWttNFN0UUNRQzdCOFVzNkpEeW5zNjFqSklt?=
 =?utf-8?B?QUhZcW4zZk5NTm9UQzJLM3J3MzcycXVPNUJoV1ZTZGwwSlU3Zm8zQXRndEYv?=
 =?utf-8?B?WlgrVmt4Ny81bkJFdVBialdBdjllWUV5MFMyNjB4OEs0Tno2Qk5lZVBVandL?=
 =?utf-8?B?Nkl0TGNPRisxaW52TlNHT0lUaElQVzlVQ0lBdXhWMkgwc2E5dC9FOHlXOVJ3?=
 =?utf-8?B?TE80ZTAyV0QySmJqOUJ5U3JsYUpWZzNmTUZiRWo4ZVBkTWJBZzgwcTlsRkRT?=
 =?utf-8?B?WGVySktheTcyNE82Kzh0WHZaUnF1U1hEMXJqK2JyTC8ySklFZUtZQjI2Z2VJ?=
 =?utf-8?B?RU83cmM1VjlFYUxuOC94SVdrVFBvbUtzUHptdzZnQWd3ZDZYbVpIQkhBSTFS?=
 =?utf-8?B?YXprODNoU1JNS1U1ajVVTU1qZDQ1RXdKZyt5c3p6eUJNTEhzWFBVa3M0cHhs?=
 =?utf-8?B?Y2VybE5PT3F3SXh0aTVjWWY3c0VNTWw4Y2VtNXI5MDVXT1k1UWVpZHNGbmo2?=
 =?utf-8?B?aWwvelRPaEhhbHhaWXp0d3N1RVBjVFZYVE8rK3BsL0NMQVowRE5zR0xqYTBw?=
 =?utf-8?B?Y09hK3ZHeFUvV1E5U1lGMG1NSGhnQndVRXJaeVNiSTBFS2hLWWxOTFQyY0ZC?=
 =?utf-8?B?a1VlZGZTU2VaZFlXVjdJT1ZMemlnSU8yOTc3UzNheWp0dzd1alc4U1ZyN1k0?=
 =?utf-8?B?V3FZQ1hxUFZJMHhBWWpZUDVJSVlPbEZackNhZ3U0c3FaalRjUzRlOU5ETld4?=
 =?utf-8?B?a3gwMmQyU0tySGpBdWlnbmJUNFBjOWJ2L1NpRERCZTArNGlSNzZIVmFwUVAz?=
 =?utf-8?B?bmNCWVFZYUk1TXYzMVkvMWhRaGVaNDdXYWk5K2hsMDd3ZGlIOEVlRlcwbGJ4?=
 =?utf-8?B?MTdib0UwalVDc1FoSlI4clZVYkdrc2kwcVhOemw1QWJxdjRyNjJpUHpnZEpJ?=
 =?utf-8?B?UjFaTTVteitLZW5aWi9sSm8yNk5Ea0l6ZXNCRGpVYzJodWs5TnUrZFJCc0w3?=
 =?utf-8?B?N2FBTkE4RzlwZW9KNkYzdy9TYy9RNDVOV0E5T2FtNG5zZi96Nm45VzZacWw4?=
 =?utf-8?B?YzRLMUpPRWR2b3NDNnNKSmJtNFJpZThMVkozTFZVc212UVBod2JHZFFhRDJq?=
 =?utf-8?B?Mi96bm1hTmJOemFnT0lObjF3a3F0VE1PVHphbFNCZEtBaHR5UFg0bHJ1L3Fz?=
 =?utf-8?B?UWJybFpOSC9uYUpiLzAyUm5mcjROMnRWK2VTOHVtNUluQUQ0TENEUU03eWlT?=
 =?utf-8?B?UUdZaE0zZVZLYUQ4NUFyUlBpMmI3UW44R0Q1ZnNXclVZcGJvRS9UczJSQnJo?=
 =?utf-8?B?TmYzZlRWYmRFTFEzYmNkQjM1aWp1QmRuZkNEbWVFMXFkSExOWWtqYkRKWTk3?=
 =?utf-8?B?UVJTcVdDdXV4c3NkcFF0RlRabytUSlc3czFiU09XYVlHemFPSUFCYjNMU0dR?=
 =?utf-8?B?Wnp5Yk9MOGJRTi9tTCtGYVB6UmxjY1ROVkxOUm5IbUtMV1ZpUDZzLzVhc0t0?=
 =?utf-8?B?dHRXa2d5cFdCTWJ3bzRlZFpyaWZZVnk1dGFwdHBIZ0hBYzFSdVE5ZmZWVHNM?=
 =?utf-8?B?SnVUUWIvVmlpRkNjTTI1VXFSRlRlVy9RTS9wTjdXWmFWK0FmbC9mbjBweDgy?=
 =?utf-8?B?R1k2SEVOcDBOTnJlN2JwaVpaelI0c29EeFRLd1FoY3NtSHdnTVR2b3Y2YzZo?=
 =?utf-8?B?dnJJQTcyQ3VZb0NzV2VoUU5BWUdneXZnVnJPUnJGazg0aEN6SjdRTVNaWHFt?=
 =?utf-8?B?UUNyS0RHelVxQzZ6OUEyeWJSb2M4UWI4dG5xYmFORmFZN01ucGowQllEb2xo?=
 =?utf-8?B?SDljNnFCeEtadjlHUTlMc1oram01V0ZPbWZubXFod3k2UjVEVDloTDU5d1M0?=
 =?utf-8?B?TkM3UHpURk9FcHRZWGlRN1crb0NWTVhoUUdWOThJS1NtVitQN1VkTXhwdjFV?=
 =?utf-8?B?Z1hPQ1FINzF3MktDUzNFZVhzdzdoUFJTUHhXY0xYbFdKWmRmclNhL1UrTVNK?=
 =?utf-8?B?RGp4MXlKdytaN1JBSE5mQWlySzM3dHF3REt6U3RCeVB6ZUw5eUR4Tm9TOHBt?=
 =?utf-8?B?TE5Qb0ZRaVRRa1lMZlZ4TjZuSm5sS3BQUWxQaU9wNmRHWVhib2RpRUxoR1pU?=
 =?utf-8?B?UmdzQzY3Zjl1RVZ0VG9icjY2bEhvUHNkdGdwZGdOZW8yM3ZzRC9hTGJmRWsz?=
 =?utf-8?Q?nwAFjDnqJgIZp4yESECDrYk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR04MB8300.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1MwOENoR1ZCRElPc3JtVzJmQ0dmbjh5QlJnTXZJZ053ekM0QmlQQWltdUdM?=
 =?utf-8?B?OHVWdXhWeHJhdkpic3hCdGg1L1cyMDR1a1N4WW5vMzlFN04zMEViTmRwQmVa?=
 =?utf-8?B?VzEzTU10QmVKVitvekFjY1kyWWVsemhyRHdoVkYyODZEdDRDZUMvTjdFYURz?=
 =?utf-8?B?dlpMZ3VGWG5RbmVGTHkrbXRoc0xCZS83NWhSbHovL2NJMjcxSmdmS1Vtc0Ra?=
 =?utf-8?B?ckZpOEk5UnRJVlhLQ3BEQmJhUHpjQkhXWk1QZ0ZPNE1vRWl4dXByRCs4TlE3?=
 =?utf-8?B?MFhnZENPVnNiNFpXR3BOb1R5OFpOdHRkZStsanhBYWREeWRrOGdwc29NaXFE?=
 =?utf-8?B?RnlBUUtaaXpxVXRlcnRUaWY0QnB2ajFvcUlZVXl5SEdFRm5sTExyTWNkL2N4?=
 =?utf-8?B?TXh6dnJDNnBrNGp5dUNhWFlpVkIyRndDMEZkSUZpeFRPbS9mK2phR01IWW1o?=
 =?utf-8?B?ckhZbzZGcXR4bjdySzJaRitjQkNXSEZ0b0RaR1BxZU92aldnK2tMa1pUOVpC?=
 =?utf-8?B?UWdPYWIwTmp6Y3NWbFRNblc0TnN0am9wTENETi9jMllyLzU5UDhYTktSSHhC?=
 =?utf-8?B?MGpxdHVvQm5aenh6UmcyeElzakRGaHhON3M3RTA1OHR0bnhtdTZ3dStNRlI0?=
 =?utf-8?B?aXdybkJmMU14cER0WHEzbDlSWFlsdHRUM0R5Si91TWJ5WFdRT3FNbFJISGZ1?=
 =?utf-8?B?d2JHM1BBM2VyVng4OXQ0bTNjMFJkMm41enpoMlZFaTRldGRqd2RjNGtweDJM?=
 =?utf-8?B?MTJCMzk4TTNPNUhqb0pVeWE4TU02cEdqeGcyRnVlTjJkWXg4eGxBbXZYbEJL?=
 =?utf-8?B?NkwrMXJoS2U0UytVVm04TnQzSFkzQm1xVHRESlhhcllzTU5sN3hJWHU2T0Fz?=
 =?utf-8?B?UmlmOUtpWHQvNUdDQnVSVEFWRmZ0bzh5d1NscndaY3RXMTNQd3AxWEEyWFRL?=
 =?utf-8?B?c1V4NHJ5cjd5eGNQcFJHVG5oTmg3TEFJOHJ3WURFdFQwRHVSYm5MNkUyaFZs?=
 =?utf-8?B?dytnbUNaM1F6UnhlK3hhcWRxd1VxbkNKSGZUTzFDdVAyUitJV2dqY05wblJ4?=
 =?utf-8?B?alZ1YVRidC9EMlZFMDFRTVRGNlMwRDRMWXQ5QTk5RzBibnlXc25tekhOU21U?=
 =?utf-8?B?N21kN0U3SzlGWTFZcTJMZGRVV1NzQmxFY0FuZXhIV2U5UEZmemM4R0NHdVlD?=
 =?utf-8?B?WW8wb0xzYmoxREdKL1A0ajkvV2U1VFdIYmtQdCszQ2ZudVhmN3V2MGRIaU5i?=
 =?utf-8?B?YUVEWGxwbG9PNDZJQnAvTi9CSmErZnQzVHZzckQ1djEyZ1JUMnJYVlg4UEVh?=
 =?utf-8?B?ZGszSU9WbXlGYVpjanI4UHVqb1dnNDg0UWx6UU5FSnE5d3d0bVl0cFZLNWNV?=
 =?utf-8?B?Z3A3Y1F6MTB0ZC8vTCt2WTE4Q0Z1TXVNbGFDSzU5MXVUTzcxUnRaRlVmUzlS?=
 =?utf-8?B?cFF4RHZuR1ZlWGliWlI2elNKbk9LS0RudXEzSHBQK2pSSExoSGF2UWdBUzEz?=
 =?utf-8?B?aCtWT0FKZVdDMkFQMG05dHZaOW9tNkpEeGdyM2ptK2svemxhMFFMTW0vUTNo?=
 =?utf-8?B?WjU0Tk03QXFROFFSQTNJM1ptYjhFM1l2UVV5VlNYTTdLbXo2QjRJS2IvNndn?=
 =?utf-8?B?ZHJBTHFoaE56STNTbFEwRFZFeE0zajNxNFo0aVd1UW5ETmVuQUdWMVhXclRS?=
 =?utf-8?B?b0pPdWNtbWpGSTN4VTY1ODB4S0txOEhNbDlzZXNqemx1aWRuaXRmWndWMHRB?=
 =?utf-8?B?UE1HenBuT3FqSExmR1FvQ3NBbC9Ic2RQcjRqZ2FvR0k1K2U5OVl6dFVpem5O?=
 =?utf-8?B?UmVQRGZ1S0tsTVdYQm85L0toUjJHZUorRStwcUxWUUliM20rand3ZFBnRFY1?=
 =?utf-8?B?ei90a2RjWUZlcHNOMzUySEJOZ3hiZmF6UDFvcW9iQlJLdjZ0LytVY1g1OXJP?=
 =?utf-8?B?WmJQODZmZHBmNjkvTmtNUzhWaXJ1RGd6YWUySUZ2bVY1RmloeEZiT2ZjU010?=
 =?utf-8?B?OWdUYnBlUDUyVTBMc3RHaW5BS3R4NEhHcGkwWTB1Q2taakFXYkQ0Qy83d0Qw?=
 =?utf-8?B?cTA4RTR3aWJRS0xkNWVqWlpTbUNpYnVPTDhxellxY3VpdlZwS3U4SDIvKzgx?=
 =?utf-8?B?eW10a0Ywa08ySWRzdVNmcCtaMjVvcksyQzRWS2hyeGowYjYyM25OOGpsTnJx?=
 =?utf-8?B?R1V4Yi9QaU1vQldPWHlxVlZueStmSENBd3dMNjlwZXU0N1ZPR3pHMHh0QUZ3?=
 =?utf-8?B?RUxyczFIc2FnVkhsOVBQZXoyVndHSGdNTXJ6ZE5OY0VkNkNYS05iemlyZGhS?=
 =?utf-8?B?Y2JjOUF3TVk2VXVJQjdKRlFNRjNKVkxXSUZUUmF3SnJZL2x1TFdrU1Z1bjhh?=
 =?utf-8?Q?kq15dziJ/lGJskj0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B49C1DA96F691C4892C6CCAAD062C581@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BfrkomUna0Xj2pdXb7M9ssakNjFtpZCftrE1WaqKtdW87fpV43xe/sOdvAGvadac10SoWk4pzsiG6Eoap1PstqK9lIS5HEcGwKuuxVuGhcis6u65JHte4qqEhdgwiFRYILH2I7nM9ifFSMW3b0tx1Sztc/6hJCEbRA2JbN5NXK7bqNWUxw7TWxYPK2B1Yjsxxq04ATzpNyVtBnfwLd/GAF2s43O2e804oLQcVhF9xJraEZ40lzCCOC+s9vNIbeIO5Qk3OCfJMtiLiDdTTZ+9QU7flPVVSVuKsek5tQhoMknYe4QWM3rEE0B0uZJtOwcB5rsMDC3ik/VpLjWBmfjTB+7B/eeHfajaD/3lTwY7FUdTFJ8YB9Shc0c+92uA4aaxBMj85C70/1QCIUs86eaHflGMl1BVcbLiBM6nBMXAfMh8T1CEwDVyRXDMwTDxOw7XnfX0ino+LZVY5J4oDmmcs0KkVX+rcUfsYo/mBVOGe76gdzLoeMruWXQhDMH/EqZ8mQ6Uji6ZYNH6wQLB6LoO4UU4uf7eRGYuOvfnptkyEqe2O8BEOLLEB+Bb3J1RTXRb5gTNUPKRPnxLrGECw87CBB4gHwNVD2Yt7gopW/hw8mQgAcpkc/qCZnbAedjc4blP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR04MB8300.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c583412a-fa92-4191-1675-08de69233836
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 04:08:32.0512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNgYRAA2/FcNAbIBv++349Pm6gWjYWSJIfDzWv+qwZMKlcRXkoQ5Q7dMSAXGcvJzNGHEHF60vjgkXl3vJwsy1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7928

W3NuaXBdCj4gKwo+ICvCoMKgwqAgLy8vIE9idGFpbiB0aGUgc3VwcG9ydGVkIGNhcGFiaWxpdGll
cyBmcm9tIGFuIFNQRE0gc2Vzc2lvbiBhbmQKPiBzdG9yZSB0aGUKPiArwqDCoMKgIC8vLyBpbmZv
cm1hdGlvbiBpbiB0aGUgYFNwZG1TdGF0ZWAuCj4gK8KgwqDCoCBwdWIoY3JhdGUpIGZuIGdldF9j
YXBhYmlsaXRpZXMoJm11dCBzZWxmKSAtPiBSZXN1bHQ8KCksIEVycm9yPiB7Cj4gK8KgwqDCoMKg
wqDCoMKgIGxldCBtdXQgcmVxdWVzdCA9IEdldENhcGFiaWxpdGllc1JlcTo6ZGVmYXVsdCgpOwo+
ICvCoMKgwqDCoMKgwqDCoCByZXF1ZXN0LnZlcnNpb24gPSBzZWxmLnZlcnNpb247Cj4gKwo+ICvC
oMKgwqDCoMKgwqDCoCBsZXQgKHJlcV9zeiwgcnNwX3N6KSA9IG1hdGNoIHNlbGYudmVyc2lvbiB7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU1BETV9WRVJfMTAgPT4gKDQsIDgpLAo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFNQRE1fVkVSXzExID0+ICg4LCA4KSwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBfID0+IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcXVl
c3QuZGF0YV90cmFuc2Zlcl9zaXplID0KPiBzZWxmLnRyYW5zcG9ydF9zei50b19sZSgpOwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVxdWVzdC5tYXhfc3BkbV9tc2dfc2l6ZSA9
Cj4gcmVxdWVzdC5kYXRhX3RyYW5zZmVyX3NpemU7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
b3JlOjptZW06OnNpemVfb2Y6OjxHZXRDYXBhYmlsaXRpZXNSZXE+KCksCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvcmU6Om1lbTo6c2l6ZV9vZjo6PEdldENhcGFi
aWxpdGllc1JzcD4oKSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICkKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gK8KgwqDCoMKgwqDCoMKgIH07Cj4gKwo+ICvCoMKgwqDC
oMKgwqDCoCAvLyBTQUZFVFk6IGByZXF1ZXN0YCBpcyByZXByKEMpIGFuZCBwYWNrZWQsIHNvIHdl
IGNhbgo+IGNvbnZlcnQgaXQgdG8gYSBzbGljZQo+ICvCoMKgwqDCoMKgwqDCoCBsZXQgcmVxdWVz
dF9idWYgPSB1bnNhZmUgeyBmcm9tX3Jhd19wYXJ0c19tdXQoJm11dCByZXF1ZXN0Cj4gYXMgKm11
dCBfIGFzICptdXQgdTgsIHJlcV9zeikgfTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgIGxldCBtdXQg
cmVzcG9uc2VfdmVjOiBLVmVjPHU4PiA9IEtWZWM6OndpdGhfY2FwYWNpdHkocnNwX3N6LAo+IEdG
UF9LRVJORUwpPzsKPiArwqDCoMKgwqDCoMKgwqAgLy8gU0FGRVRZOiBgcmVxdWVzdGAgaXMgcmVw
cihDKSBhbmQgcGFja2VkLCBzbyB3ZSBjYW4KPiBjb252ZXJ0IGl0IHRvIGEgc2xpY2UKClNhbWUg
aGVyZSBhYm91dCB0aGUgU0FGRVRZIGNvbW1lbnQuCgo+ICvCoMKgwqDCoMKgwqDCoCBsZXQgcmVz
cG9uc2VfYnVmID0gdW5zYWZlIHsKPiBmcm9tX3Jhd19wYXJ0c19tdXQocmVzcG9uc2VfdmVjLmFz
X211dF9wdHIoKSwgcnNwX3N6KSB9Owo+ICsKPiArwqDCoMKgwqDCoMKgwqAgbGV0IHJjID0gc2Vs
Zi5zcGRtX2V4Y2hhbmdlKHJlcXVlc3RfYnVmLCByZXNwb25zZV9idWYpPzsKPiArCj4gK8KgwqDC
oMKgwqDCoMKgIGlmIHJjIDwgKHJzcF9zeiBhcyBpMzIpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBwcl9lcnIhKCJUcnVuY2F0ZWQgY2FwYWJpbGl0aWVzIHJlc3BvbnNlXG4iKTsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB0b19yZXN1bHQoLShiaW5kaW5nczo6RUlPIGFzIGkzMikpPzsK
PiArwqDCoMKgwqDCoMKgwqAgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqAgLy8gU0FGRVRZOiBgcmNg
IGlzIHRoZSBsZW5ndGggb2YgZGF0YSByZWFkLCB3aGljaCB3aWxsIGJlCj4gc21hbGxlcgo+ICvC
oMKgwqDCoMKgwqDCoCAvLyB0aGVuIHRoZSBjYXBhY2l0eSBvZiB0aGUgdmVjdG9yCj4gK8KgwqDC
oMKgwqDCoMKgIHVuc2FmZSB7IHJlc3BvbnNlX3ZlYy5pbmNfbGVuKHJjIGFzIHVzaXplKSB9Owo+
ICsKPiArwqDCoMKgwqDCoMKgwqAgbGV0IHJlc3BvbnNlOiAmbXV0IEdldENhcGFiaWxpdGllc1Jz
cCA9Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVW50cnVzdGVkOjpuZXdfbXV0KCZtdXQgcmVz
cG9uc2VfdmVjKS52YWxpZGF0ZV9tdXQoKT87Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLnJz
cF9jYXBzID0gdTMyOjpmcm9tX2xlKHJlc3BvbnNlLmZsYWdzKTsKPiArwqDCoMKgwqDCoMKgwqAg
aWYgKHNlbGYucnNwX2NhcHMgJiBTUERNX1JTUF9NSU5fQ0FQUykgIT0gU1BETV9SU1BfTUlOX0NB
UFMKPiB7CgpNaWdodCBiZSB1c2VmdWwgZm9yIGRlYnVnZ2luZyB0byBoYXZlIGEgcHJfZXJyKCkg
aGVyZS4gIAoKV2lsZnJlZAo=
