Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021087.outbound.protection.outlook.com [52.101.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB693207;
	Mon,  2 Feb 2026 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041256; cv=fail; b=qKlHtQCQYqhnUCoRlZl2ciTTm5eq2IyMishwA72okHMK21vn1XzSV5APGILjBUsm9Wpv/qdItcsGs4EWYYbpygKwXWyhpetVqeLdNhvEJT7rRWp8+NPoA/ZIFYKRN+LNWDkn+l3nOiPWAdfFxftJLiYo0ySVWT5L0dlUa2+KBq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041256; c=relaxed/simple;
	bh=ZYFiguBXOc8+ScEWIyqjb1IqKvyjqoQZfGvgtd+4vbg=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=bp6B4U2kYwjsuc4YCZ24c1jf2JZhpJAGPlw0/dkvi2Ng0zyozjKkt65soP3ptsTq1JMiZrk4koZRYeQtwjorNmTYJQGhKSpOuObbWnlACRsEXScaR99EGZE2Soxsp8B3Rjq8fxC+B+AZ+9IAuJt/KDbZebWsnhBvTfm7Eeo99Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vv154Lkm; arc=fail smtp.client-ip=52.101.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="vv154Lkm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu7RLth9C6a4FILEMB54W8mkrAO0yDNDmYKrJyck5WaMtMDCJXM1Np5RyiAeW+3jXfcjRcf9wxa7jq/fCOb9mnVBfyyJvqeHyKQOX5hIiC3PQc737w8ULVpkTc8iL0wPY0opIv66p1kDP98uyazOymtwTKPauXPh/zuPvgXuIAd1xTgT3a/+PXFj/guaWFuYMrbNs5+4la2FCO5GTuLEDwmGXj+t8SmEZ579hhK6LM8K6fECKzFd6habC4QlGb9JT/lRHMMmTZNfnzjcUs8wp7Tc8c6Xpbf5LbwfXRbhRZvzhsc0f6xlCSdWwb/RKu2rmgSBTefc9M0aGxFYHuVP/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwsGcBs0sGoafAoVijwKGG5O8E0mdB035irkYN2Lg8E=;
 b=uADqNSYDUbdCso1MeSZEf9xpUO0uyXcDOfEjkR2B1RCDSEfQH3W/3uam7HeUFTjxu1T8tvjtZ6pGENsrOwDJLcPvMnad5tjnmRNDl5nM8shQ4NfgYyKPFiLLfcrzVz+OkOuDbGwr/CWX1qJRl6C2zpAoUXIcwWVHrDjLDbQfFXIA82Ak8XMVbhEiOLyBGoyYNpyqszbBK0QzAvzJThl+qCQ1F0Hv3D/yLlZ47zXbDeZqatg4EjEVt9VGcaHiYVjpWuBja4V3XL/+hamkIcRbCp1OGksMBCnW2FWT2n8agIJrXFD9Bs1IXa0hG4HporxPrFOSZ481fFhD185XAdkqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwsGcBs0sGoafAoVijwKGG5O8E0mdB035irkYN2Lg8E=;
 b=vv154LkmVkwXJurFRlogzCsvrPCR8mf2BLCtTDkT2RzP+htSq+90tmy7cnOi2yoeIKGx/05OVyKOYI6Q6jcuBvczQpjvhlAYIpIoxZTCsEpK7vWcHiqKgS/DQ9DxBiPHFwoFsd0DMLsPYbhz38XKeoEH6bee8e2jAFRNUoFq2N8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5941.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:290::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 14:07:30 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 14:07:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 14:07:29 +0000
Message-Id: <DG4J98HVOUEX.I7XOB7LPB49L@garyguo.net>
Subject: Re: [PATCH 3/6] rust: io: provide Mmio relaxed ops through a
 wrapper type
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Lyude Paul" <lyude@redhat.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
 <20260202-io-v1-3-9bb2177d23be@nvidia.com>
In-Reply-To: <20260202-io-v1-3-9bb2177d23be@nvidia.com>
X-ClientProxiedBy: LO4P123CA0195.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ae70ea-be48-4a08-2f7e-08de6264674b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEwzNVlJOHdaWXJzSThOWlczd3ZLQkF3cUY0MDNMTVpIVmdBMUhYOUJRTVZ2?=
 =?utf-8?B?SXB1d0Erd0FLYm5xQnd0VVRMVDE3NEg4c2J6QWlpbXNGeExlL0hOanZIaVhX?=
 =?utf-8?B?MlYyNjYwbjhkR3BqTUVZSzJHcW5QdTZ5bG1mRDRCMHNyVktWTTdyS1Zncm40?=
 =?utf-8?B?QWl3V0EvZng4YUN2YnVwOTlEVk1RWHlqZll4VVQ0L05UbGpROS9pOEhaRUlE?=
 =?utf-8?B?eXhPSzcrR2tGN3hpNjg1STJOU1RBYU1GQm4zQ2dEdURjd2lzSXdGelBQVHFu?=
 =?utf-8?B?d3E1b01IK05xOWUvOEpncVVRUVB0d29wa0s4UHY4Z3F3STM4UGx0UlFOODIy?=
 =?utf-8?B?L2hEVGY4NjlWUy9jWk12RlFMVnRnK0o2aU9EVkNsbXhGRWloanVzS01MNHBn?=
 =?utf-8?B?dnV1VndJMHZ2Q2RzZEgyTjUrUVA2UUJWQS9oUUFSN3BYUDZnVTNOcWtGYW5m?=
 =?utf-8?B?YzFBTENrc1J0VUM0ZmVEQmZKUVE4RHNncU8yRXR2dW5uWEZraGJaZ0tHY3dY?=
 =?utf-8?B?L2NadWc5Qi9MNFRCRU5EdHhGVlpxN3lzV2NtR2hoNndDNjdEK2ZmL2lBeTRD?=
 =?utf-8?B?MHVNeDdLOWtMZ3ZLRDRZTm5raHJnZzVwVEkzRE1kbDJsbytYUm1UMlp5a0Rt?=
 =?utf-8?B?T2doOTlXMnZ2K0dMV1JVVUpEVUZCSW5LdzhHSFRNL3BIQnVNdG9rZnNYZnpv?=
 =?utf-8?B?YURoeEk4UmVkUHRBem12MkoxTVlSRFNjQzVwSk9OM0tHRnpnV1JrTVlhRmxK?=
 =?utf-8?B?dnR6OThqWWgwcWZ0L2F6dE5sMnZqaXZZTHZGZmQwOUE4b2kzVktUV25WQ2lU?=
 =?utf-8?B?QjFabCtQSXorT2UzQVZBbWRPMHorS3lXaUd0S1JXc010cGFqTEI3eUdBR0Jx?=
 =?utf-8?B?ZlY0RGc2S1duZHo0S1FDSDRrc2JzdkNscHhYdGNvZGZTaXFKRGxVNDFzUVh3?=
 =?utf-8?B?VlFYeXVwWmtlVzFWU3BMSy9WZkh6MkF5V3MxNi9nN2h0QmxzeXF5OFNaQ0Vh?=
 =?utf-8?B?bzVSRzdjb002SUFLR2l1SmVsaXM4b0dkeVhPc25CdzJzVkdiY01nNHQ5QTR4?=
 =?utf-8?B?THpZbnMwVUw5eXc1N2Z2djRRd05ISiswdjE5dTErLy91MU9aRGgycDFodnpB?=
 =?utf-8?B?dmk5NTFiWkVrZDNySC9LeldLM0hSdTVmeGVYVjVrOUNjaWM1N3B1bDdKR011?=
 =?utf-8?B?TWhMUDFUL0ZDOC9GdXlPMmlDaGFrNzF3a2JDOU0rVE5XVzYwdjhwL0tGUUJ5?=
 =?utf-8?B?UUdSSnhoUUdyQkhyZ1lZcHdjRDkyamZPR3ZyTlhrdFZtalNWRkt4Z1lUUUVX?=
 =?utf-8?B?NkFYRmJPMHRJNVU2Nnk1Z2xsdmFnamZ4S0NiZi9uaE5IYnBjb2hJajc0eGc1?=
 =?utf-8?B?WkpoaEQrSE5uN2dQOFdtRmpPb2FyNmg1cHZJWHRIak43MWR6RUNQYm1MSFh5?=
 =?utf-8?B?OHdjLzIvTHhDYklyMG5UUk43Mjk3MDVvU3F6WitlRy9IcE83K2w2YUZOTFN3?=
 =?utf-8?B?Y0dtUU9vYmhObnpxbjQvNmVyK2c3MVh6TFpsY0tydlcwVWttaWZyMVd4WXI3?=
 =?utf-8?B?RmUwd2N6QzE3YnlMRHFNSEhlUXRFSTR3S0dMVEtjWjRzUG5idHF2SFdlMWpN?=
 =?utf-8?B?UHoxdzJSN1NVUWVDV2RjTG1ZTG5ZWWtibER0czFyQ0RNMmQzTDVRU0p0N0pF?=
 =?utf-8?B?RTJIWTc1QWFVcDZoMFN1bDM5S3gyM2dKMnNOSURPVm11MFdrMjhMSi9FUm0v?=
 =?utf-8?B?Uk5hdHVLSWlNeHF4bFlSY2d3Yi9nTjJKbXozOXhxRGU2L2xiYUdXRmtXZUh0?=
 =?utf-8?B?elB0bnZUclh2enMvMlpCT0lOc2FpcXpvV0dpUnFrL1dMUmhCWVFRVUFJOHVV?=
 =?utf-8?B?L1NZS0lNdEhsL0U5OGNSUkpxRE1DU2JWLzZJSjVnSEdGTi9qRExqYzZ0VVhs?=
 =?utf-8?B?MllOV3BhZjF3aHpjUnJBQ1RiMVdMV1dYVGhHTWowU2NpbG1PMzVZTXFETXpF?=
 =?utf-8?B?c1FYbTd5ZktsRU5ualNRWmtvV0o1M2pXeHAzT25ZaG44bzA3UmI1ZndyMXRH?=
 =?utf-8?B?WVpwamNPQnhrUm1BUk1PS3c5ZzBVUDBsNUJNTEhQQlROTm5BZnZNOUFkZ1Qw?=
 =?utf-8?B?OGhVcGxNMTFwY0FjbERBSEFGRWpsc0Q3YndVSDM3b2h6UW8vSDdWbmxrdk1W?=
 =?utf-8?B?VHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm9QL3lnMkRPRUpWSHllZ25wL1lLQkxGdmZ6U1YrYk1QRXczY1Q2bHR4VG9l?=
 =?utf-8?B?d0hVbXVYSGY4OVkzRHBJMVRHRW5RZjluMWhkaUZtYk43VmxEb3pKQUlYRk92?=
 =?utf-8?B?Sm1NY1I5K0VoWFlmMlFaV3QzaE5BY1lCVjM4L25keDVwbnptYVZDWlF1MThT?=
 =?utf-8?B?TmI4TEVBOE1waVkyUDlldkFMa3lpYytCWVBXbVU0d1RrVE1HZkl6MVlRVndv?=
 =?utf-8?B?QU1keGJuTVpjakZCVGthbi9SRGE1engrdGVOVUhPTktqQzYydGJuWkxma0I3?=
 =?utf-8?B?SWNyTnkrcTlkdXZNTHVyazdZYTVUbGttWE5kN2kzY0lLVnRqc1NRWXVPSGJ5?=
 =?utf-8?B?TThDK2FweFFkT2xVMzN1TnFPT0lRN1BUZmF6TE9VV2FrZHVXcUo1VzBnQmg4?=
 =?utf-8?B?d1I1S25zY1RITEV3R1p5MmhCcUlLOFY1RXkxZ1ZKWGVpblA0anpndThzdWlU?=
 =?utf-8?B?VDdVcnM1bE5ENWRJc1owa1dZdUF3YWFpRHEyaldVTmJVYTJ0UXp0ajYzNDFj?=
 =?utf-8?B?N3lLUDUrWkwvaTNUTm9NTXAvclM2dVFBZWNXa2lrcFRYOER3enVocGRCT1BU?=
 =?utf-8?B?OFovNGVWUHNrczBTZGF3cXorV1JSdzVVVkx5MnpVN3REbmdyVGNZcTQxY25F?=
 =?utf-8?B?QTZUL2pDSTNiRzBxWVFRYVBSMVMrZ1g0WmFhdHhadUlzOFJyUHZIRnlRYkxG?=
 =?utf-8?B?ZlZvQ1JFUTFyVXFCdmNOTVhmeSs4d3diVjZtZ3lVRExsSHBHU1A0MXlNR3Jr?=
 =?utf-8?B?QUxhY0U2MkcvSXQ3YWxxRHZqVUI4Q2xoS0d0dUUvamFVallqZGFqYm5TV0JI?=
 =?utf-8?B?SHk0Z1ZUenFZaVdQYnBBMm1lRXVjSFVpTGJvSlRvc2gya1NiWC92bDVMQ3Nu?=
 =?utf-8?B?a20zNXdZZk1oWERsMTZ1bWdSTlQyQWJ1emlpbUlIMUZMSHQ4WEVtZDF0QW9r?=
 =?utf-8?B?RHg3S2NXL2w2VitPNkJLUTV2NFJQZlphbFYwVEV3N3lwTzJEbGM3UGVLNjA0?=
 =?utf-8?B?OFJyU2NNWUdUVE5MQmI4ZGpHUUxIWDUyK25rZGdwWW1vMzlyWk5XVEVxRW1j?=
 =?utf-8?B?M2traUR0SkRqQ0R4Y1RlbzlxT3NDUjVGWXUvQWVRMWpNc1JnWFVCd1JUNFhT?=
 =?utf-8?B?am1XK3FnNTdnTFVCRDVRV1U1NnhTdXJXWHdwd1V1S2lrNFNsdjNTdlF1V09K?=
 =?utf-8?B?M3AwYzRWeGVId3V6UWZzRHhFV0w3ckpFYmdRNzZFL21yYXdzWW85emlkclhI?=
 =?utf-8?B?MldjK0ZDVlNxclRhcTRKcW1vSmd0ckRJbU1kVzlKMUxwMFJML052VG8yZzNL?=
 =?utf-8?B?Wm42MDduVlhXRm9HNy9rVGdtWlgySi95b0kyUjF0cllmRm1JSXBuMEpZbERv?=
 =?utf-8?B?OXBIbmpxK2tzSG83NUlSdG9Ld21UT3JGT3J4K3JOZm9CVVZRaWJ6MEhTYjlM?=
 =?utf-8?B?L1h4Y3RoRGkvTWZGaVJCVDhXU2RXQU8zVlVYWlc2ZVVSNlZBL0ZicTJPdDJI?=
 =?utf-8?B?djVYUFFoU1lybCtMUGVMR25rOHNqbTd6bkE5Uy80dCtPRU9PbDBNMjZUYTFT?=
 =?utf-8?B?d3VyZGk4aXNxck8rZ2p6dmUrcklDMXVXcmtydmFSam5pM2JzYXhQbWU3U2Ey?=
 =?utf-8?B?bjUxNStBU1NmWDJlaDgrQ2VWZlpwbVptWkptK1BQNVFnWElpSVQ3bWVoOHMy?=
 =?utf-8?B?YkZLMFp3YjB2MHU2QWs2aGxqdnRnVG9sWVh5VkM5SnJUOUN4K2pIbWJBWDlE?=
 =?utf-8?B?dWVtYnFhMlFlTCttbXRlb0tDcjRvVDNHYytrUGs0THBiRWJ3RHBTS3gzYnBw?=
 =?utf-8?B?Z0swR1Qxai9FRFByUEVReS95VlRZSHl1TndUT3lGQTljbXMvajNyYWNaUkpa?=
 =?utf-8?B?VVFNbDg3SzFYWkdkL0NKUFNLTStKOEJ3VU83NFYwVXBCNyt3M1NkWWM4cEU4?=
 =?utf-8?B?NnJYK2ZITEhGQksvZGZCcXJIU0Raa29JZVBRRnNWaFllVk1xM2VKbjNGdVJn?=
 =?utf-8?B?azllRER6Ym1sK0JubU12TlZISHRuRm1XNWF3WjNYMjhQaVJsS1JWSTFkSXBQ?=
 =?utf-8?B?TWdDWnFqYkRFOTZWeXNVaE14Nzc0dUpKVkVTYnprNVYrSjA2MFF1bmgxY09o?=
 =?utf-8?B?MVZVNlhmOUhINTRKdU5lQWp6NW5BWnVCMmd6aDZYM1JNajk1ZjByZ1JsVW0x?=
 =?utf-8?B?cFA1YUJuRjhHMUllZXBvVUJHZ212bktHSllrOFFiWUhzSXZjWFRUenB4WmlU?=
 =?utf-8?B?dUpVVUtjRzF0NlBDWmpnSHhXeUJVMEhjUy9ZM2J4cEQ2cDRETnBnTU1iYzFR?=
 =?utf-8?B?dTgyblVlMERRVFhhK1U1dUk4czk4Si9lZHl6T3B5cTN1ZTQ1Rk5pdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ae70ea-be48-4a08-2f7e-08de6264674b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 14:07:30.3334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kE9fqMPHwJI+JoZlbHDmpQxKdBauBMz0xYuAMs+hD3nu0URf983Nf6cGvwfr9VH3xjHJlsAH7hmiY2kanPopNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5941

On Mon Feb 2, 2026 at 8:13 AM GMT, Alexandre Courbot wrote:
> Relaxed I/O accessors for `Mmio` are currently implemented as an extra
> set of methods that mirror the ones defined in `Io`, but with the
> `_relaxed` suffix.
>
> This makes these methods impossible to use with generic code, which is a
> highly plausible proposition now that we have the `Io` trait.
>
> Address this by adding a new `RelaxedMmio` wrapper type for `Mmio` that
> provides its own `IoCapable` implementations relying on the relaxed C
> accessors. This makes it possible to use relaxed operations on a `Mmio`
> simply by wrapping it, and to use `RelaxedMmio` in code generic against
> `Io`.

Hi Alex,

I think ultimately choice of order to use for each I/O access is local to t=
he
specific access, not a global property.

I know you can just do `RelaxedMmio::from(io).access()` for each single acc=
ess
too, but it feels quite verbose.

I guess one alternative design is explicit order on the access, e.g.

    io.read32(Relaxed)

Or

    io.read32(Full)

however this is verbose in some other ways... I'd like to hear how Boqun th=
inks
on this one.

>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  rust/kernel/io.rs | 66 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 64 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index dc894a45bbcc..baa8d3baa20c 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -556,9 +556,15 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize =
{
> =20
>  /// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `=
$write_fn`.
>  macro_rules! impl_mmio_io_capable {
> -    ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:id=
ent) =3D> {
> +    (
> +        $mmio:ident $(< $($generics:tt),+ >)*,
> +        $(#[$attr:meta])* $ty:ty,
> +        $read_fn:ident, $write_fn:ident
> +    ) =3D> {
>          $(#[$attr])*
> -        impl<const SIZE: usize> IoCapable<$ty> for $mmio<SIZE> {
> +        impl<$($($generics),+,)* const SIZE: usize> IoCapable<$ty>
> +            for $mmio<$($($generics),+,)* SIZE>
> +        {
>              unsafe fn io_read(&self, address: usize) -> $ty {
>                  // SAFETY: By the trait invariant `address` is a valid a=
ddress for MMIO operations.
>                  unsafe { bindings::$read_fn(address as *const c_void) }
> @@ -695,3 +701,59 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self=
 {
>          call_mmio_write(writeq_relaxed) <- u64
>      );
>  }
> +
> +/// [`Mmio`] wrapper using relaxed accessors.
> +///
> +/// This provides an implementation of [`Io`] that uses relaxed I/O MMIO=
 operands instead of the
> +/// regular ones.
> +///
> +/// # Examples
> +///
> +/// ```no_run
> +/// use kernel::io::{Io, Mmio, RelaxedMmio};
> +///
> +/// fn do_io(io: &Mmio<0x100>) {
> +///     let relaxed_io =3D RelaxedMmio::from(io);
> +///
> +///     // The access is performed using `readl_relaxed` instead of `rea=
dl`.
> +///     let v =3D relaxed_io.read32(0x10);
> +/// }
> +///
> +/// ```
> +#[repr(transparent)]
> +pub struct RelaxedMmio<'a, const SIZE: usize =3D 0>(&'a Mmio<SIZE>);

For a transparent wrapper, it should be=20

#[repr(transparent)]
pub struct RelaxedMmio<const SIZE: usize =3D 0>(Mmio<SIZE>);

Then the construction is

    fn from(value: &'a Mmio<SIZE>) -> &'a RelaxedMmio<SIZE> {
        unsafe { core::mem::transmute(value) }
    }

unfortunately this require unsafe (perhaps can be helped with macros that
auto-generate this for transparent wrappers?), but this has the benefit tha=
t you
get a reference and everything works without indirection (with your approac=
h,
I/O methods take `&RelaxedMmio<'a, SIZE>` and it double dereferencing). Thi=
s
also mean that you can copy the type or reborrow it.

Best,
Gary

> +
> +impl<'a, const SIZE: usize> From<&'a Mmio<SIZE>> for RelaxedMmio<'a, SIZ=
E> {
> +    fn from(value: &'a Mmio<SIZE>) -> Self {
> +        Self(value)
> +    }
> +}
> +
> +impl<'a, const SIZE: usize> Io for RelaxedMmio<'a, SIZE> {
> +    #[inline]
> +    fn addr(&self) -> usize {
> +        self.0.addr()
> +    }
> +
> +    #[inline]
> +    fn maxsize(&self) -> usize {
> +        self.0.maxsize()
> +    }
> +}
> +
> +impl<'a, const SIZE: usize> IoKnownSize for RelaxedMmio<'a, SIZE> {
> +    const MIN_SIZE: usize =3D SIZE;
> +}
> +
> +// MMIO regions support 8, 16, and 32-bit accesses.
> +impl_mmio_io_capable!(RelaxedMmio<'a>, u8, readb_relaxed, writeb_relaxed=
);
> +impl_mmio_io_capable!(RelaxedMmio<'a>, u16, readw_relaxed, writew_relaxe=
d);
> +impl_mmio_io_capable!(RelaxedMmio<'a>, u32, readl_relaxed, writel_relaxe=
d);
> +// MMIO regions on 64-bit systems also support 64-bit accesses.
> +impl_mmio_io_capable!(
> +    RelaxedMmio<'a>,
> +    #[cfg(CONFIG_64BIT)]
> +    u64,
> +    readq_relaxed,
> +    writeq_relaxed
> +);

