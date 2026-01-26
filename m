Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020081.outbound.protection.outlook.com [52.101.196.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066A2356D9;
	Mon, 26 Jan 2026 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450352; cv=fail; b=dfUjB11Qq9MqXsozWiQ27ajaSDMVx/ba1gduB3eENOhby+Hg/3cdobeqI16jLwsK26rS0pid2DCBXxNxhqHSmTDGka3PZHfXjdkbjeuw6Thcn17i+leiOXxaGGdg3eeZA6vmuNucFHE4oCt1QlWWHyvU7xETcArZ7pMbnCm3v4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450352; c=relaxed/simple;
	bh=Kkm0DlawlUzFmicdoGm7FAxBLKmIy96JZFVeGAji468=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=F8dAn4INCyChqHuMzgeHrV9hF+Ps8KEIa3c4nwkqQfjFptvCRsPCR2zwd+jBL+QCcO85oVHWvKlDtLsplpRUsYmPxWEw3E1rRKx40gA6fLheeEnO8YCKYPdBi9SdHzt5JU5aK5qC6aQ+p6r4lzcODBmYYCmq3gJ0u/yzrvfnFTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xztxHjA8; arc=fail smtp.client-ip=52.101.196.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="xztxHjA8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZdZ2KfUItVb2YDT3fW+Hzb8N9nTRe2fSn6rQHPg/2EXUmNAZDF4dHkhEorPZs9uBVYJHtIP/+YgOWypu1LTFvt5o5OWCtE7IkS6bGm0fvIfm9yUQwV5Cajdk4xgdHhSRvOp6Mu6raKyVH3mDRGnMtkazg3ucxPwhJF8lHmQEndSUvHq61Gx8TnRpfydOX5tLixhWFlB+AhS5niBtNwWCLpKOk15uGJoBZeTqajtMfvVXYeEj+966XFR6SCXd5Yt/awNWgDGaKG2C8uIL0ra15hsCtmIOsteRtM8GDVjygRPBpmoYd0VBPlM4wD35CCvAj6bBiKmCsFLdWbyanaT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kXeS/nccBTO3Dw3N55isdg51xpEuvJA/FGe4sC/uGk=;
 b=goonW9i+AopqGGSzzcklkMy+3MXjBPC5pXbJ+Kordtl5JrIidqoyGJjLu5d8tSCrYTF2PAz2oQmIYyQxg6iAQU4WuAPxDYNTOnXNrrGmDv6D0XMmmkjRle7aXNwBkSwtzvCyxjDGxnQw68TuOzMxrPor9cj5WymM78yEJt+hgEi3f5HpAJz2RAwop2dNHVxQFzi5gOwEAy9fE07e8zRq0fCAjajORx4d+UlsOXZCM/uHUBFvV0ZO/TzC6m/BeaHrDw04fdKsin1RGKQ/MlpiWJnIdKvyAIqoeosX2JDtT8Fm32miK68oHe+0IQXbQ2vBLR9cZl66WyIbBgBm8VnuXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kXeS/nccBTO3Dw3N55isdg51xpEuvJA/FGe4sC/uGk=;
 b=xztxHjA8IoNZoq4byMeFmqY8SWgk2RfVxyFTBZ2hEVC0ddeN6VscsXhJKs/D4PzSM3I8aAP6XRGksXfV5U3BYAneyDnv3M6uu2uu4QQWSk+y+2xt/hBORU0HyLZ8/F8uOFpw758Lw+YsO4cERI2Dvq76QQbisIaOwvdqmLbF184=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB1924.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:69::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 17:59:06 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 17:59:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 17:59:06 +0000
Message-Id: <DFYPSR8ECE0O.2BYC40RIOVHCX@garyguo.net>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>, "Jason Gunthorpe" <jgg@nvidia.com>
Subject: Re: [PATCH v2 2/2] samples: rust: fwctl: add sample code for fwctl
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260122204232.15988-1-zhiw@nvidia.com>
 <20260122204232.15988-3-zhiw@nvidia.com>
In-Reply-To: <20260122204232.15988-3-zhiw@nvidia.com>
X-ClientProxiedBy: LO3P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB1924:EE_
X-MS-Office365-Filtering-Correlation-Id: f81c8849-ab79-4b5a-3758-08de5d049964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnNZdmxJaTZqZi8vZlVXeWQ2eXdGS05aTFREaGFza1J5RmozTDkzRXNUNjRL?=
 =?utf-8?B?OFhQRmtGUnU4bUNkZlRCbExmRzlzN0JocUxVc0ZzQk05WXRSOVNUUzZJZTJY?=
 =?utf-8?B?Y2YzV0tWdG8vVXhYeXpjRU5zTWtTTEZMbXdPVUk1d3J0NHVZazU5bDZWem5Z?=
 =?utf-8?B?RHlvblI1cVloQlliTVlvYURtRjgyYk1lQTFTOXFwQlV6WDJSdVJqK2NCWHNM?=
 =?utf-8?B?cHVGWkl6OXk4c3hTOGdqdjd3ekhZYWpxcm0vZDRpcWZjS1BKc3doTXFYTUZD?=
 =?utf-8?B?Y2N0V1dEYzZ1bG5GRUlBMlR5K0FvaHhwdjVwTXo0UDBBZGpEZFBpaytKcWl5?=
 =?utf-8?B?VEI4UHV0NUt1Sm0xTEZFT1J2bjNCTkdTZTNCUVMxUGd0R090ZllkaTl4cDMz?=
 =?utf-8?B?VjZtMDJEaThPRVVtUmE4emFDaHdMelU2UFZpSkZQbnNTblVPU0FhNTg2VlFa?=
 =?utf-8?B?dGQrTHZ6NWJMZjBXSVprMHZYMVdGWUNOVlJOc3dNdjZmRW1kN0FsVnpEMk1U?=
 =?utf-8?B?WjJPZG5ySTA4ZndXaGNvdklLUHZSYWF0SjMreFRJaWdTZVhlbG4zWWQ3anFr?=
 =?utf-8?B?d0RvVU1RT1kvdEpkVEcvQmFhcS94RWZCeUgvdG9NM015aFphM0RWL3czNk9p?=
 =?utf-8?B?WG54QmJ5NFNoTTBRYmZiM0Qvdm1ENkp1aGlFL0JadHNydUdMZkVKLzhPbmlD?=
 =?utf-8?B?cUxLemtTZFpmanYwY1BhR2ZIekFWKzlFSHdiWXNzYzY1YXdhZlFrbTVwbGcv?=
 =?utf-8?B?ei9Ccllha3lUZjdZeWxPWDhRNUZLQitYTlFTUlUybUZ4eTBlcHJkQlJCNi8y?=
 =?utf-8?B?K3I0SUxPdkVxZjBJSzUxMlNYcFBsejkrVGVwTDVtdjNBdGV4aWhGWEI0WVBH?=
 =?utf-8?B?NzNQVUZCT3p3YUgvK0kyMG9BRlEwcFRVbE9DK3FCaEcxaXBLVktEa2NRQUVw?=
 =?utf-8?B?Z05aeGd3dnJjN2dwTDZpMFcyUUtYc2FBd0M1eVBjVWloNnR5YU5sajRoMU8y?=
 =?utf-8?B?VStzZnNhRGI1c2NSQWYxWVdHbzV4Z3JqQnpRMHlDK3NURWJCaWNkaWlSQ0pi?=
 =?utf-8?B?Qk56ODJDeFBsZHlKM1MzNGJVeUEzalQ1N3lMSlZEK3cwWEZtVEVpTGNnU0Zi?=
 =?utf-8?B?TGcxWGRtbXBDS2lIaE1saVM2UGE4Z3huaGNjemhwQ2dFOXpnaWNLblhHMElX?=
 =?utf-8?B?Z2YyTVN1NkdoMytYdlRXcjExUktGdHhIWEFUbnZjWm9RQmVUdmwraGQ5Vkxk?=
 =?utf-8?B?Zm9zMnN4cTFQUk1MZ0dnR1g2UFlCeGZKZVNkQWhvTmN5WUY0U0s5T0ErRnRQ?=
 =?utf-8?B?TVZhNU9mNUtSajhBVjBJcSt0Ri91ZFN3aEJjZ2FhaEU2WGhWUkRINStvM3Y3?=
 =?utf-8?B?OXkxT0NtcUxnM3BIYlpEZXRZYy8vQkN2OGw0MGdBL2lTZDVHbmdTdmRFSlZR?=
 =?utf-8?B?Wk1VUS92OWEvNGQxQTJEV3AwY281aWExYUFyS0xQdU4rakdqODVtbFRHNFQ1?=
 =?utf-8?B?bVdDRmtQTWZ5Y2ZKMEwraFRYUUNibXpTb1NlOWVlN0RvckUyVkhhV1lFZUtu?=
 =?utf-8?B?YnZYcDZtOW5nUlNlZDNKL3F4VW40TDkzYk03UzhLTlNiQTlCb1RIdkExZnV2?=
 =?utf-8?B?VVpxbk9ZdUJ0c0h1b3JBMlVXODc2NE1XZzZvc2JiVnI2MXN5RDhPRG90dFJx?=
 =?utf-8?B?Z3pQalc4a0dCWVF6WmlxTWs3Qmxsa3BUZURhb0Q4Z3pGa3FkRGN3bzZhaVE3?=
 =?utf-8?B?YWw2bFdsUE1jbUhFYUUwTnlncTFXZkhUMGVHSERJc1REbWszRGEzSjRPUDZT?=
 =?utf-8?B?YlRFNU9kcHhIZkhwUGFIcVE3VkJXQm81QlR6eEl2dGJRaHl0STdyblJPQ3NR?=
 =?utf-8?B?akFnTzZTQnJPdXoweWd5VWhuc3d4V3V2ZlBjN3h6d3V4Y2tIVFp3SVMyc3ZJ?=
 =?utf-8?B?b3Zsby9VL1N4dUV5L3FHQjRtVzRFVU0zVEZZekM1Qi9PZWVRSFYwQUxLVnRm?=
 =?utf-8?B?aDN1c0N4TnJPYjVrczRYK1lEaEhFM0Z4dVZyaExLbndINEorK3IwY2p1dWcx?=
 =?utf-8?B?bUFGRHJSdVZaYTZZa09lNXNMekg2bzR1YTM1bFg1RjBvdEJVMDkvNG5UdjVT?=
 =?utf-8?Q?J748=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1F3Ty9FaEZnNmJWa240MXdCL2lZSGNYUVlla2FnTU9mb2c2QXNGN1BKSy80?=
 =?utf-8?B?Q1F1aEZKbjQ4ampseVhxN20xT1VWRW8zV2NSWmEvWGI1VGRLMUVsQTFFWElW?=
 =?utf-8?B?Skp2WE40cUNVakRDVVdzc0RBbjNDSjBDMTlvQllPUzN0L1VMYzVXVlFNQ29s?=
 =?utf-8?B?WFBHREdYMEJFWjR3UXE2ajgwUmEzQ2pEdjE2MDRRRDUvdHlCamNNZGRodm1U?=
 =?utf-8?B?bTlMeHVwNTlVU0lta2pOa1lnTDJOOU1mRkZvbmYzdk11QXRLaWdSU1dneVlh?=
 =?utf-8?B?Tmg1SXJycmJ2T1JFZGZobkYzR1dCSUlTaGtVaTFQV1RRM1BseDl5QU1zQSs0?=
 =?utf-8?B?UVFDdEtteUljV3ZxaUNiSlY4SDRtb0Z5NGRLeVg4SkxDMEUycWthczYrSU9Y?=
 =?utf-8?B?M0gvUTljekhLVVR2ajJYcnBjSkdKRTRZNFY4NldRcWM2WHNCN1dVdUtFUGE1?=
 =?utf-8?B?NFZRbEdWTG9PcnRRQXpKeFI2SGF0K1hjQzdXTS8zVGNSUnhuZ2Vwb0NwTzNE?=
 =?utf-8?B?MUJlRndnd1lEMVQrK2swSC9WSzA1V0NWaHNRbE1Xa1RRSkJaMllrcDlhdldy?=
 =?utf-8?B?N3pKMjdqa0pUaThHb1JYc1FzYUZPZEtGUzJrbWlkRjRFUnQybWZTNlpKNWZ6?=
 =?utf-8?B?VFpOZVFjR2VlNmhSaFd3UGs3SzJMOVNIRE9McVhjVjU2TXZ0cm5IZUdVbWdF?=
 =?utf-8?B?NGNIa29jNnRGeHkzSjRDZEkzdEsxOUJZcmlXRUcyTW92d3I1dHNYU2FFNW9Z?=
 =?utf-8?B?UUNkUmgvSDh5V1FUbXFEdlNpVkF6SFVXQ0pScW1NTUxZbnMyWDVHUGdLSmU4?=
 =?utf-8?B?Nm5SdnJ6cUxsVXI3eUcrbFM1bHhrTXhyaS9kK0JOY1A2U3VDMWRZemU1bzhI?=
 =?utf-8?B?U05pTVlKWGs1RVF1TWxSd1V4emM2N0piSGhxZU93K1M4cEV5amc1bDhsckxY?=
 =?utf-8?B?Wi9xa2FVd1oyWUhoaENjbHJrdGZuTHV4YndhUk9TaG5DTGJEOWJSemhqTEd4?=
 =?utf-8?B?T1N0ZGorY0FHK1psSE9RODh1WUlTZk1mclB4R1E2M2JnSk9JYm9MODJpVSt1?=
 =?utf-8?B?VUw3WkVBeHJ5Skw2YlBUajhUTVM1Y0xaRERCa2hPNUVJOFpKUkloUHNORm9R?=
 =?utf-8?B?NSs0SVZCcjVmdERtc0lFZXJyY1YzY3dJdjY0S2lYSWN3T1lWbzhYYnVTakhP?=
 =?utf-8?B?eC9DYzVDeVYrb0xGVEl1d0FGMzQwZUFZbWl6WHduK1NUUGNPOW9MTUhIMlRz?=
 =?utf-8?B?RU5qSmR0VCtLWXp4eTZxZlhEYytEMXoyaTRlN1dVZzJoVGVXVVgvMnp4QVVC?=
 =?utf-8?B?NTBBeXRPU1RKMlB3ZXM0QkR5SWlhazVtTVgxdW55L0JiVk8xYk9jSURCa0R6?=
 =?utf-8?B?UjVsemlDbEtQTEJUbTg3a2FySGJDTWhGbGZuUTh5QVFhQTBxamZHM3lqK3c1?=
 =?utf-8?B?YXpWYjJGU09ET2Y5RUZyTC8wbUN1NTM1bXJCRDhlUDNDZm50Y3FBUDROYUt2?=
 =?utf-8?B?cFg5R2s3enBsY21NeXVNQ05uNEtieDgyRkFvZDJoMkpnbVF5UVZmUkhLZnZT?=
 =?utf-8?B?QTBJdGhkcEx0MVh3ME9KaUtNc2JUT29vT0FVWUMyV2JZQy83Q3FvY1hQQUlF?=
 =?utf-8?B?TTg4WHovRWNkejJpSEo5M3BraGhJRTFScHEwOFNodFhqS1d5d2xFcTR3VHVD?=
 =?utf-8?B?enV5emZtN0NHYXZoRlJZSWJ6WnJPTTdhQnZ3VUFwUmpTYTVXejZ2MCt3T2ZJ?=
 =?utf-8?B?RkdpMDI3UWdLQUhXckZGaktCZ2FkUVRIY0tSNTZWeUxiSENqV2lTUGk3SVFQ?=
 =?utf-8?B?NUxXL2Z2Qk9iWlZvdFVIVFRvL2x5OHBVWkIzYkYycENMeWJRazlnYmtuYVpt?=
 =?utf-8?B?cFRRMUpSYWN1c25VenRPTkZLMHQ3a0tmUXc0TmdVbVRQZFEzcVAyQ3hIYnJN?=
 =?utf-8?B?THllTE4vcVdyVS95Yk1wVUxsaHJ0ZytSd205eWNTVGlOSjh6SzFIelBNcXFP?=
 =?utf-8?B?cVlUeE9DL2NNUzZyZzJYcTVCMkwwc1JCM3U5RGhoYVFRSHZYV1VXWHJ1Rm5O?=
 =?utf-8?B?MzF5TTVzY282VGxYekNzUkRQSVV1Z0I3NGR1V1FEY2laRG8zNzFKYmRybGxQ?=
 =?utf-8?B?eWVtM2h0TkdueGdXNitEV0NpZzluZ3JQODVKVnZpMTZoMkxJT3dYVUgvZ0dl?=
 =?utf-8?B?clNWdllodmpvdmdDSXJ6WHdkZGVheHpBc2U2eE9CZmdsQTBxUnhHQSt4ZTZr?=
 =?utf-8?B?dkNFTEJVa3dJb2J3M01uQWR5R09jVUhrUi94dWxPM3g4NGd0WGltSy9SSFRX?=
 =?utf-8?B?SXMzaEdiWE5XeWJLbVBwRno1ekE4VS9NZ2toTzV4Qy9QQXE0Zmo3dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f81c8849-ab79-4b5a-3758-08de5d049964
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 17:59:06.8562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07s06O61P1/7A9xudT9gNR8v1UWJbVYi5ZpukVStx4VipET1RjOMVmlltc7akkSw5X1ri7/9yoxKGNYVlaUnUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1924

On Thu Jan 22, 2026 at 8:42 PM GMT, Zhi Wang wrote:
> This patch adds a sample Rust driver demonstrating the usage of the fwctl
> Rust abstractions. Add sample code for creating a FwCtl device, getting
> device info and issuing an RPC.
>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  samples/rust/Kconfig              |  11 +++
>  samples/rust/Makefile             |   1 +
>  samples/rust/rust_driver_fwctl.rs | 136 ++++++++++++++++++++++++++++++
>  3 files changed, 148 insertions(+)
>  create mode 100644 samples/rust/rust_driver_fwctl.rs
>
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index c49ab9106345..3d0b223caa89 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -172,6 +172,17 @@ config SAMPLE_RUST_SOC
> =20
>  	  If unsure, say N.
> =20
> +config SAMPLE_RUST_DRIVER_FWCTL
> +	tristate "Fwctl Driver"
> +	depends on FWCTL
> +	help
> +	  This option builds the Rust Fwctl driver sample.
> +
> +	  To compile this as a module, choose M here:
> +	  the module will be called rust_driver_fwctl.
> +
> +	  If unsure, say N.
> +
>  config SAMPLE_RUST_HOSTPROGS
>  	bool "Host programs"
>  	help
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index 6c0aaa58cccc..6f6030e64727 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+=3D rust_dri=
ver_platform.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+=3D rust_driver_usb.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+=3D rust_driver_faux.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+=3D rust_driver_auxiliary.o
> +obj-$(CONFIG_SAMPLE_RUST_DRIVER_FWCTL)		+=3D rust_driver_fwctl.o
>  obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+=3D rust_configfs.o
>  obj-$(CONFIG_SAMPLE_RUST_SOC)			+=3D rust_soc.o
> =20
> diff --git a/samples/rust/rust_driver_fwctl.rs b/samples/rust/rust_driver=
_fwctl.rs
> new file mode 100644
> index 000000000000..ac5f979fd73b
> --- /dev/null
> +++ b/samples/rust/rust_driver_fwctl.rs
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust fwctl API test (based on QEMU's `pci-testdev`).
> +//!
> +//! To make this driver probe, QEMU must be run with `-device pci-testde=
v`.
> +
> +use kernel::{
> +    bindings,
> +    device,
> +    device::Core,
> +    devres::Devres,
> +    fwctl,
> +    pci,
> +    prelude::*,
> +    sync::aref::ARef,
> +    types,
> +};
> +
> +struct FwctlSampleUserCtx {
> +    _drvdata: u32,
> +}
> +
> +struct FwctlSampleOps;
> +
> +impl fwctl::Operations for FwctlSampleOps {
> +    type UserCtx =3D FwctlSampleUserCtx;
> +
> +    const DEVICE_TYPE: fwctl::DeviceType =3D fwctl::DeviceType::RustFwct=
lTest;
> +
> +    fn open(
> +        fwctl_uctx: &types::Opaque<bindings::fwctl_uctx>
> +    ) -> Result<impl PinInit<Self::UserCtx, Error>, Error> {
> +        let dev =3D fwctl::UserCtx::<Self::UserCtx>::parent_device_from_=
raw(fwctl_uctx);

Why does this raw binding need to be handled by the user?

> +
> +        dev_info!(dev, "fwctl test driver: open_uctx()");
> +
> +        // Return an initializer for the user context.
> +        // The framework will initialize this in-place in the C-allocate=
d memory.
> +        Ok(try_init!(FwctlSampleUserCtx {
> +            _drvdata: 0,
> +        }))
> +    }
> +
> +    fn close(uctx: &mut fwctl::UserCtx<FwctlSampleUserCtx>) {
> +        let dev =3D uctx.get_parent_device();
> +
> +        dev_info!(dev, "fwctl test driver: close_uctx()");
> +    }
> +
> +    fn info(uctx: &mut fwctl::UserCtx<FwctlSampleUserCtx>) -> Result<KVe=
c<u8>, Error> {

This can just be `Result<KVec<u8>>`.

Best,
Gary

> +        let dev =3D uctx.get_parent_device();
> +
> +        dev_info!(dev, "fwctl test driver: info()");
> +
> +        let mut infobuf =3D KVec::<u8>::new();
> +        infobuf.push(0xef, GFP_KERNEL)?;
> +        infobuf.push(0xbe, GFP_KERNEL)?;
> +        infobuf.push(0xad, GFP_KERNEL)?;
> +        infobuf.push(0xde, GFP_KERNEL)?;
> +
> +        Ok(infobuf)
> +    }
> +
> +    fn fw_rpc(
> +        uctx: &mut fwctl::UserCtx<FwctlSampleUserCtx>,
> +        scope: u32,
> +        rpc_in: &mut [u8],
> +        _out_len: *mut usize,
> +    ) -> Result<Option<KVec<u8>>, Error> {
> +        let dev =3D uctx.get_parent_device();
> +
> +        dev_info!(dev, "fwctl test driver: fw_rpc() scope {}", scope);
> +
> +        if rpc_in.len() !=3D 4 {
> +            return Err(EINVAL);
> +        }
> +
> +        dev_info!(
> +            dev,
> +            "fwctl test driver: inbuf len{} bytes[0-3] {:x} {:x} {:x} {:=
x}",
> +            rpc_in.len(),
> +            rpc_in[0],
> +            rpc_in[1],
> +            rpc_in[2],
> +            rpc_in[3]
> +        );
> +
> +        let mut outbuf =3D KVec::<u8>::new();
> +        outbuf.push(0xef, GFP_KERNEL)?;
> +        outbuf.push(0xbe, GFP_KERNEL)?;
> +        outbuf.push(0xad, GFP_KERNEL)?;
> +        outbuf.push(0xde, GFP_KERNEL)?;
> +
> +        Ok(Some(outbuf))
> +    }
> +}
> +
> +#[pin_data]
> +struct FwctlSampleDriver {
> +    pdev: ARef<pci::Device>,
> +    #[pin]
> +    fwctl: Devres<fwctl::Registration<FwctlSampleOps>>,
> +}
> +
> +kernel::pci_device_table!(
> +    PCI_TABLE,
> +    MODULE_PCI_TABLE,
> +    <FwctlSampleDriver as pci::Driver>::IdInfo,
> +    [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
> +);
> +
> +impl pci::Driver for FwctlSampleDriver {
> +    type IdInfo =3D ();
> +    const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
> +
> +    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl Pin=
Init<Self, Error> {
> +        dev_info!(pdev.as_ref(), "Probe fwctl test driver");
> +
> +        // `pdev` is `Device<Core>`, which derefs to `Device<Bound>` dur=
ing probe.
> +        let pdev_bound: &pci::Device<device::Bound> =3D pdev;
> +
> +        try_pin_init!(Self {
> +            pdev: pdev.into(),
> +            fwctl <- fwctl::Registration::<FwctlSampleOps>::new(pdev_bou=
nd.as_ref()),
> +        })
> +    }
> +}
> +
> +kernel::module_pci_driver! {
> +    type: FwctlSampleDriver,
> +    name: "rust_driver_fwctl",
> +    authors: ["Zhi Wang"],
> +    description: "Rust fwctl test",
> +    license: "GPL v2",
> +    imports_ns: ["FWCTL"],
> +}

