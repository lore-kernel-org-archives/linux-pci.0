Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021102.outbound.protection.outlook.com [52.101.100.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A5315760;
	Sat, 31 Jan 2026 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769820938; cv=fail; b=ChwlWBRWM8Vm0QpY2+bBQqLT4R5G/ZGEbWcB8Nnea51Gmrrott+nnUUoc1rQ1ww6YS85psi9+UwS0meVcexu0s3JgWFVQ/c/KDLjsnsrbMBr7K8Wxd3DYus4HrinjcPcU5T4jnaGeDdLRuQi7CSJhTCqVS7zua3N30i/LsMvs8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769820938; c=relaxed/simple;
	bh=8YowkVOysSGtr/bpCq7OA2E6eTCgGSnmQo+MSc8JKBg=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=VNadhtKctcQ1g+tuaT2kcD/9ZO82CYQvQeQZpcLwuZ0jGF61NbFqzWLuLcBXOpgJVEkxYgYE74/iv/cmosulyJS77T/fla19a+6fISSp/fSK3b0r6QlIlR4SDicD5ivLai4wB9GLyJ7fG/DTY6iq+IEUgFbPBGC79ZO9MK5xxG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ya8M5piz; arc=fail smtp.client-ip=52.101.100.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ya8M5piz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrPszy468oJNWGpWj1C598rEbaDhjLS6adG1vJAMl1wm/1RY+bmFVDgRweMAWroGlj5xpFyWF6rGgjJ6D/XmAddjO5ogGHfhODVO9Zxz8dXNOODqBXhHUauo6eYpI7Fro5lXU1CiB065jyDN+qPqwvZmUt8CUlDbRDa0998mEQwy0/RprzVBNiE5+3AXWtKIfEW1Ql6rUOE8vUG8o+/pHzvAyId/SK3RsHaDBbIWHhh8OOw/3FogG+mfEoRb3A1vFNrIrdkzyHUXQRBpN+BYxT7tGtFw4pQontDBluuOhGHx8IywOot5bqrsICo/+jvTCAr2ouSnJWEQtwodL/PESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/+zBOh99IueF3Icbn2zoC6DO3ANpmRWWteMaVlgDvA=;
 b=vZPNR0c7SsfDjeRHPfr/qRtIymptmGTXwM7toHZoal6v9PMhAQCBgxl0SAH1EyGk6EQPx1R6hh5xl3hGvu5SxiL46c/a1TpI+uS4kW2/jgvmE0bX+y4Vy20uIKNWwIMCRNmTuBLDaBYD6Lvq4F9JR2mTCrvbdb0ml24/NUJTSDfORk4yXzYoukVKKrkFLGt09N8sIurwgw9MygCOQAFwtpC9+vN2ahqL3qh5DWNOdVqbtcTVSLeHwGQEgd4QVBz01/kKsPpEtGdVgadAStrDm1NpguxBPZiMzK59zIWbCtxjOZGBipNo7LQsaw7DQGqoQiQ9PRSn2VA1+1YI3NNmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/+zBOh99IueF3Icbn2zoC6DO3ANpmRWWteMaVlgDvA=;
 b=ya8M5pizekb66QG2ukYafeb1lQrW7l0ajoD1XoeCiImVica3UKs5ctmOZgW3K3fwDSpo6ugys+1bQCtDh9OokfhHPtiqlXNUCagO5MkTq5o/DbVZXBeeH/Ph29AS9DZW3uBiYLIZjxBW9pQA6jMsjf8hFAs4PrKZUpkhUxeTbFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB8471.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:465::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Sat, 31 Jan
 2026 00:55:25 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.010; Sat, 31 Jan 2026
 00:55:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Jan 2026 00:55:24 +0000
Message-Id: <DG2D5ONS18FE.TC7K3O8V8SU1@garyguo.net>
Subject: Re: [RFC PATCH 0/2] rust: pci: add config space accessors (and a
 small in-tree user)
From: "Gary Guo" <gary@garyguo.net>
To: "Zijing Zhang" <zijing.zhang@ry.rs>, <dakr@kernel.org>,
 <ojeda@kernel.org>
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lianux.mm@gmail.com>,
 <zijing.kernel@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260130171026.1138617-1-zijing.zhang@ry.rs>
In-Reply-To: <20260130171026.1138617-1-zijing.zhang@ry.rs>
X-ClientProxiedBy: LO4P123CA0047.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 0daadab2-f2d3-4815-16b7-08de60636b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG1tVHEzSGdKSlo2VUluTWszZ0c3MXR4eFZjdzM3NmZ5QTEwb24xZWQzdVg5?=
 =?utf-8?B?YnZ2bTVQZkJqa1lGMU5aUHNveHE2SXdlYW1OeC9McndCWTBGbVl3bmVYZ3dx?=
 =?utf-8?B?MnBIUVN4SXZmTU5TcjZNRHQweVlkMUd4ZjF2YzJhTWRRZnhtY2NiYnNxd2Jl?=
 =?utf-8?B?NzA1MFNtUkRKQXRSUFU0SjNWK2cyaG50T0tVZXRqaWswZHdlK1ZCYTdmU29t?=
 =?utf-8?B?UDRaRGMwMXJxVnZ5VWIvUnFXWmwvRm4zRVJlcGFzOHhFYVlHUVdsREhWZTlE?=
 =?utf-8?B?SFM2VXlzUnJtUXhxQUxwaTJnL0hNUTBEbW5zZm15STlVbVNkb3dIcVJQeXlp?=
 =?utf-8?B?VEROOFprVGdoVHAvMVcycktwQVQxODRpV1lMVFJuN1BQYW9jaXg5UHcybTNN?=
 =?utf-8?B?clo3Z2ZUTG5ZOGp0SE96QW5rZkFtNmpsYVh1NlFZUmNGMkIvMTVHcFVIMnlW?=
 =?utf-8?B?aUZWTkVnMFZPbSt5KzBTY0IvOHk4U08ydmoxSGZZbjFLdTBaQ3lleklUUTN3?=
 =?utf-8?B?WmpxV0hubVAxNEJqSDJjNU5xais5YWJoaER2azMvM2N2Rko2dHpOVnhOZDIw?=
 =?utf-8?B?UXV2a0lJZ25Pbjl0NnphVzVqd1pIdndDQmlVVzR2NVo2ZDN0KzUxL1hET2tr?=
 =?utf-8?B?c0NXOUg4N1BuejJOMFVBaDBKOVdoT0w3OVI4Y0gxMUkwcXJjdFF3bDM1NjUz?=
 =?utf-8?B?SXJoYTF2MnloWEdBdmVOMG5JanR3NUlDbHc5d3JXNkJpeXRxSXdQNFh5Tmli?=
 =?utf-8?B?dm1vTTlHTHlSaCtqZVZ1TkE3WVNxazNsUEJBdVVhT3FGOFVQTTVKOVl5U1Fi?=
 =?utf-8?B?c3dhcUkvbkxVMkRSaldocGxWOU54aU82SnNSS0ZCOENva0RBRytjTVpkR2FM?=
 =?utf-8?B?U0xrd2lhNTEzZjNHK2liVCtCSHBacTJvRGkxSWFqR2VVUkM1QmxBRnlYNVo4?=
 =?utf-8?B?aFFXcWJUbktoQTllZnBMSUZCakZieGJYa0x4RjR2VkljT2Nyd0dJUDZKRUYw?=
 =?utf-8?B?NW10QWx4QmNOeVAzWGpyZXZYakFZSUhvOXA5USt1QkZqUEFSUVdzdnZiUkJX?=
 =?utf-8?B?WnppUkZkWkFCeDhxNGd1QjVhNnYreFN3bWMzQjF3UmNDL1kvN1BHaW9DaG1B?=
 =?utf-8?B?UkU1aWVmQ0ZwbUhPNnB5T2dYMjl0bzdJY2Jaa2pJQWVSektJSzIyaUZEMlFZ?=
 =?utf-8?B?WWd3OTRJOEdtSkhiU1MvVlR3ZldJdGRuMitEdGltRm9GMlRYeHBjYVA1NUxN?=
 =?utf-8?B?NUp1bTNZMFB4a29lMU5MTmhNbmNJSUwwdUJqT0dVSDk0a0l1VXZXNnN3QW10?=
 =?utf-8?B?OHJHcEJQNFBXY2tKK0ZGNEdiTEE0Q2pzSFozV0FKY1B3M1JqZVFvVEo5RGlH?=
 =?utf-8?B?M0hkQU96Zm9ZMkNldVIvT0VFdmRLZjI2MWFYMHN6clQrVUgva2UyMUllUnZD?=
 =?utf-8?B?ZjZCM2Y4b2FUeTNLSFhnMUlnYWU4RFl1ZmNHMU9LM1htY3VuU0RrNnNiRVRY?=
 =?utf-8?B?YTNzVXZzWjNtdkJEVXdpeU5GWUdxM2Y2SUVzU1AwdGhSWklSUWkvZERVRXFK?=
 =?utf-8?B?Rkx3MXlqbnlCTEpvay96bW1QTG0wajNFdGJwQXYySVMzQ1I0NGVLaWlNKzZW?=
 =?utf-8?B?UytzcFpwVVVUb3MxNzZDYk02MEhvdXpTMDB6TEo5Q3h4VHk5YjdPMlQ4OU5o?=
 =?utf-8?B?VmtjTnhkbmJoU0g3SUREZk9tS3BNcmdwV0FLdWVkcUQ3VWlLdjBHSmVPVHpy?=
 =?utf-8?B?UHErQmRNUVhiU1dQSGpsK2xFV0swQ0o0OGFwYjFGdkM3eFF0dkJEMkZlUGJy?=
 =?utf-8?B?WGhvRmpUekkwVGw1SG1aMW1sa2k2SUk4T05Nd0NaMCtCT1czTEM1T2VZSW9P?=
 =?utf-8?B?RndxUC9iQkowUFp1NjJmcDJLZzR3cmRSRHJReEYrWGFBZ0xIMXpjWWhDVk5w?=
 =?utf-8?B?RFdCS3AxQXBkT0JPaEtoYmFxVElIVUZpN0cvVTA5WXh3N2RTdk8yN3pVUm0x?=
 =?utf-8?B?V2ZlWHZNNnU1dXN1bmhqa1A4aHdpRmFVRHhERDNONUp4T1VxL3pvU3hId3Vr?=
 =?utf-8?B?ZWpwZXkweUpERUJndjRCd1BNY0MvMGRyTTdzM1l0QjdjQzBCVGNoMDhSbThL?=
 =?utf-8?Q?yv9c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXdBV1JEQklyZUZLV1d3NUg0R1AyN28rbWtqM3VSREpwblJ5MmlmaHFxUllq?=
 =?utf-8?B?S0N6YjFlOTJvOFI4NXJMM2d2a0NpZ3VlMmxFanl6SVZ0MkIrcFRleGthNDF0?=
 =?utf-8?B?UitFWHFHbnBYMkRRYndsZ3dzWUV0UE5kTWNpanJidGpXT05FMDBUWlcvbTZy?=
 =?utf-8?B?eldHdUFYcldYVHhNdzBkd2J2d3NaK3N3WmxTdGNqT2p2dmZGUjZzUWpDRGpE?=
 =?utf-8?B?Rk5ITERjUXFveklYd2d1VndKWjZwcWZ0a3ZEbUtaN0xjN1c1RHN6Z1JBbEw2?=
 =?utf-8?B?dmZRb0ZDdmhDNTJSOGhRUnJVZEI5OEorL3lhYjJRTlJ4dURObDliWUh3eS9H?=
 =?utf-8?B?L0lwTWhVU05EZXRsZHhGeWwwczN3V1F6UUFsc0tMWVR4MS9vaURrQjgyRWFp?=
 =?utf-8?B?THJDQk9DYXBpb1FVbUw3U0crUWQ3cWd2QmFpM3B5QTM3WVVaNk9zaW84N2dm?=
 =?utf-8?B?bGsyUDRlWC9uclRBYlErQnJUV1RPbDhocmFQVlFlOFE3Zm9nVWgxcnE0Wm1v?=
 =?utf-8?B?TmM2VHFBNVIxME5MV1VWQk81VStxbTBpSDVqR0lEaE1iMUQ3SFNWODFmUEo0?=
 =?utf-8?B?NlFLanJudkFTOWpPaThFUTA1SFFjWDRjcDZYOUtmTTFtNXJWb0tsYXN4cVFI?=
 =?utf-8?B?YTIvYlB2OGdXdWRIdVZjS1htVGFVeXBWcVFLZ1c5WEQ2bm9rb29tcVMvN2dr?=
 =?utf-8?B?MC8yNW50Zi9iSTR2RSt1dk5XUkpoZFpjYWVIZUo2dkNWMGxXcHRBNUtFT3FD?=
 =?utf-8?B?K0dJWmthQ3FFR0pDMk1zSldjeGo5bWhBTjYxbTRqUG4zL0FENytzRko2QTZF?=
 =?utf-8?B?dXhLY2taaTF2dE9hSHkwNFN0cTZyZ2hoa0M5Y2IwSlhoRTI4QVFpZ2JESW5K?=
 =?utf-8?B?cGFKL25JdDNuWHJqUm5YcjA4aXRhOTI3ZjdiWGlIbzN1QlV0NUkxK3puZjg4?=
 =?utf-8?B?ODlZei9KWlRWRXpLaE5GMmZSU0pjY3ZiQnJkeWludFc4SlRLMjk5cUtyNkY4?=
 =?utf-8?B?SlhRNHRvd2ZFWm5CVC8yYjFlci9CWlQwZkliQktEaUVGVkR0eTNxQVJQR2xR?=
 =?utf-8?B?Y1EvdGQyWGU2OWtYSDNrNUVnWkJxRElLNm1sQTdPRTdsd2RLSFk2aHdyU3V1?=
 =?utf-8?B?WkFVMTM4MjM4MG13MzJXRGNjMFJpa1FzaVpqTC83Ujgrd2F6QnYyWnRiNDln?=
 =?utf-8?B?TWNIekR2TGtmUWhrY1VKaGpMMnkveDRlU0ZsS2FYbFVJZ2EvQlVVeDlDL2w1?=
 =?utf-8?B?Z3VVQXFXQUNJT3pwbHVqMG9tQVNVbjhsR2lQKzMxNkVOQitxVitaaWlMcDd2?=
 =?utf-8?B?V0JIemxyNEtoNWhWZDdqcU0zSkk1elMrRkRVOWx5dnE4MDczL3ZyN0VxbXgr?=
 =?utf-8?B?c0J3R3lTQnNCVmNXYXMweGVOSm1EWm5Scmk5aWltcDlSWGtOT0owZWRrZkha?=
 =?utf-8?B?ZGhuNExMS2pYMHlwd1NyM3NnUDc2QjJjY2NsK0VZUWF3SU1hNC92eXFrNzB5?=
 =?utf-8?B?dWhMdHJ1TU9ncnZzTUVHY1hyN2dxY1V0bU5LYlhNT29icVgyZGVkV3R1QzVE?=
 =?utf-8?B?OXMvL1grc3d2WUxuVk9LN2JXTUhuWGxINENsVXNYcVRURExubTNraEl3TXU3?=
 =?utf-8?B?MkdFUUVDc3crZkJlTGRiZ3NveGd2MVhkZGFGNms3NDhzWDltc25SMUJFbkpT?=
 =?utf-8?B?WDgrV3o0N21jSEdZVzlKbjM4bHdZekdZckVUampNcURrRGdhbHNVcFZJeTlZ?=
 =?utf-8?B?SkNMc1lpVzIrajFRWlN2R1Zva3Rmcy9RZTdMZ2JqWFcxS1FiTmNRSWh4dDVJ?=
 =?utf-8?B?ZEZ4czJmeUg4R2NwWHFMRUlnUmRLdGNBQTV6L1dhejBKYng2NGRhVTFWRjcr?=
 =?utf-8?B?RjkybVR2K3pwZGtpZkVZQ1h5Ty9ia3M1T1NOY3dBZXU4eGJ3bXFpeExSV3Ux?=
 =?utf-8?B?TFFzTGhEdGF4QkJHeTFTSGZrVkNYVHRlejZkNWF2dmF5ZE9jYVJmRkQ1UVgx?=
 =?utf-8?B?QnUzUVlPbEZXV1FsTFNSZHhJc1ZkbkVQVkQ2WFFNeWtvdUY0K1p5blVXdlpv?=
 =?utf-8?B?K0pWNWZYaHhtb3JXL1lPY0lwWG9yRlBwTWZlb2g1M0JSaFhjaXFKVFpMenBL?=
 =?utf-8?B?Tmc1NDk5V3ZzdmFCdWF4L2pGNkVVMkIyQWZzZDFmM1dHL0RTMDZqV0JpRk5U?=
 =?utf-8?B?YWVXYjBuelhvMGNoYXBWSDhTUW9xUXNtRXBENHY0cWxYd09HdlhVWVltZGVM?=
 =?utf-8?B?THhtR3gwenFxaVV5RnVka3Z6VUNrRmtyeVlCTkxjSW9mbmxUeFBzNE93bnV6?=
 =?utf-8?B?U3d2aHRMY1ZYYzM2ZnRZVUZVMGc2Vng3YmZmVGpFdG9PSXBVVXpydz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0daadab2-f2d3-4815-16b7-08de60636b56
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 00:55:25.2775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rbw3004UXEi5d/YZmZ/eqqr+UIwVzc1w0t9fWnlOJ0PAHLT8qVN0lJMCgBrD4lurZlqwI2ZG2dkqcj0Dw+di6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB8471

On Fri Jan 30, 2026 at 5:10 PM GMT, Zijing Zhang wrote:
> This RFC proposes adding basic PCI config space accessors to
> `rust/kernel/pci`.
> It also includes a tiny update to the existing Rust PCI driver sample to
> exercise the new API.
>
> Motivation
> ----------
> Rust PCI drivers occasionally need to access PCI config space (e.g. for
> capability discovery, SR-IOV queries, or MSI-related setup).
>
> Having a small, reviewed API in `kernel::pci` avoids each Rust driver
> growing its own ad-hoc wrappers and error handling around config space.
>
> This RFC is also motivated by the "PCI MISC APIs" TODO item in
> `Documentation/gpu/nova/core/todo.rst`: config space accessors as a first
> step, with capability/MSI/SR-IOV helpers as follow-ups.
>
> Proposed API
> ------------
> Add the following methods to `pci::Device`:
>
>   - read_config_u8/u16/u32(offset: u16) -> Result<T>
>   - write_config_u8/u16/u32(offset: u16, val: T) -> Result

We already have config space merged.

Patch series: https://lore.kernel.org/rust-for-linux/20260121202212.4438-1-=
zhiw@nvidia.com/

Code: https://rust.docs.kernel.org/next/src/kernel/pci/io.rs.html

Although, I do noted that the documentation is not having it. It looks like
while we re-export `ConfigSpaceKind` and `ConfigSpaceSize`, we forgot to ex=
port
the most important `ConfigSpace` struct :/

Best,
Gary

>
> Notes
> -----
> This is intentionally a thin wrapper: it exposes a safe interface and
> translates errors into `Result`, but it does not try to add policy or ext=
ra
> validation.
>
>   - No additional range/alignment checks are performed in Rust. If an
>     argument needs validation beyond what the C PCI accessors already do,
>     it should likely be addressed in the PCI core instead of in a Rust-on=
ly
>     wrapper.
>   - The underlying C helpers may return positive PCIBIOS status codes.
>     These are mapped to the corresponding `-errno` values for Rust caller=
s
>     (same mapping as `pcibios_err_to_errno()` in `include/linux/pci.h`).
>
> `pcibios_err_to_errno` mapping helper
> -------------------------------------
> The mapping logic is kept as a private helper in the `kernel::pci` module
> rather than inside `Device`: it is not tied to any particular device
> instance and may be reused by future PCI helpers.
>
> Also, the C `pcibios_err_to_errno()` is a `static inline`, so Rust cannot
> call it directly without adding an exported wrapper.
>
> In-tree user
> ------------
> The `samples/rust/rust_driver_pci` sample is updated to read vendor/devic=
e
> IDs from config space (0x00/0x02) and print them during probe using
> `dev_dbg!`.
>
> Note: in the current Rust support, `dev_dbg!` does not hook into dynamic
> debug and is compiled out unless Rust debug assertions are enabled.
>
> For local testing, enable `CONFIG_RUST_DEBUG_ASSERTIONS=3Dy` if you want
> to see the `dev_dbg!` line.
>
> Questions for reviewers
> -----------------------
> 1) Does using `u16` for the config-space offset and returning `Result<T>`
>    look OK?
> 2) Is mapping PCIBIOS status codes to `-errno` acceptable for Rust caller=
s,
>    or would you prefer we add a small exported C wrapper so Rust can reus=
e
>    the existing `pcibios_err_to_errno()` helper directly?
>
> Testing
> -------
> Build:
>   - x86_64 defconfig-based kernel with Rust enabled.
>   - Out-of-tree build directory (i.e. `make O=3D...`).
>   - Options enabled for this test:
>       * CONFIG_SAMPLES_RUST=3Dy
>       * CONFIG_SAMPLE_RUST_DRIVER_PCI=3Dy (built-in)
>       * CONFIG_RUST_DEBUG_ASSERTIONS=3Dy
>
> Runtime:
>   - Booted the resulting bzImage under QEMU x86_64 with:
>       * `-device virtio-serial-pci`
>       * `-device pci-testdev`
>   - Kernel command line included:
>       * `loglevel=3D8`
>   - Observed:
>       * `pci-testdev data-match count: 1`
>       * `Probe Rust PCI driver sample (... cfg: 0x1b36:0x0005).`
>
> Zijing Zhang (2):
>   rust: pci: add config space accessors
>   samples: rust: pci: exercise config space accessors
>
>  rust/kernel/pci.rs              | 86 +++++++++++++++++++++++++++++++++
>  samples/rust/rust_driver_pci.rs |  8 ++-
>  2 files changed, 92 insertions(+), 2 deletions(-)

