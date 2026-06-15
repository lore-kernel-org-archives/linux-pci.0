Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574DF3C0A11;
	Mon, 15 Jun 2026 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510668; cv=fail; b=FPlRfx1T5oiZoohHK+0n8D9aefzDYHGGVxO3b/Tw6lBH8DBGXEDcTWxOXr2z1QbRoxnzUcRzLZsYJweHlaPdIOuyMADq7FN1x0lzHEb99Z8dVxct3BGs15zV3gwQbb78c2vP6z4Kq5kQRkZo6SwprIJhxiuXBpW0soZZ8IJhOkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510668; c=relaxed/simple;
	bh=LdrUzyCRdCXSlXWO52Gd61y+RzmnJPx4kvNE8nFN768=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=tCPBF6u9QiPfrRXwiHI3D0xfRnVgcafb+Vc3eeZ4eX0qEDxko2wGt4TQ4/wq147KDUjDbMHXGj1z1pRxEOxYrczP/B7MFUn4q9DQam08xGN69S0E7QCFWNwql9dnkAbee9B7dGiEQQx8Pqm7wj+Y0MXJvmzKPr0ZkKkcAonCwPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LgEu5eic; arc=fail smtp.client-ip=52.101.53.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LgEu5eic"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTw7bwCTrXWwDsC2qUypDEbzmMzeOWDYV87jBvywc7ttPWB434DHdCgIOFyWcaBV1fLeguZtP8PkS+fAL5WVCUtDCWKK7h1nKrCuDTSbX9C3JmVpLtFtsXhqIXOIdAayp4dgyBfBDgAHoSdYMQHXe9gk85GPyt93mly/NTFu+siwa/PScwVhuVhW4CPMMeKf+yuAqjaolpJSxDeEQMD1xkAx5We1pSsM5kcR5W7EUAVwD9BHTuoeOGTTyyKu5a4v8JXes+AcEuJR3Gpvbov0dz8GI5Xe15bBLP1ZMphEochDEEa2NifPqylhJEhAJ2d1fMMGKXAwUloK9s00s7ZKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdrUzyCRdCXSlXWO52Gd61y+RzmnJPx4kvNE8nFN768=;
 b=DJxXzgKGcBr2KuP7XviysZkdY0ba3Xqiwhq6O8jt+5m/gMxWFjdUMV+ZWC9sqiv1N01bZ1BCYnKfcGEEWIsNHYdbCt/93ZMGEXg1HUEBsHAIZH8B5uA1GrOW4YJvr/h1/bEExKNMhDQtAIRX3At/WUUc7dDMtc6J0Y/zacpbenbSeUE9LP9Pr3hPk2q0SJ1CcDD3a8SY+XL36ZVQsrY43JClGK7oyVlhb9pMumM1VaGPJBzE4T8sj5xZMx1wIljoqSOMMf0llh3c41BhxApw4hanhHHLZY5yXRQubtNwZtqioHL3JMdSTuQwrAufmoKtWHoBbtNINYrVBLlnFsRsGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdrUzyCRdCXSlXWO52Gd61y+RzmnJPx4kvNE8nFN768=;
 b=LgEu5eic4PjsYOxiznyyZRpM1PHgN7OPeMGLCTIpNxBCGXqNVEmF+R7rRSNiAdNUgK5cAEHOMot0wtJQR2m4M7fALkLOW43Iluo2agvAx36CiNdeRDBY27P6NyEeKZ6viZ88ACctXgWfjg6a2K3TGrAsMYKuH9R6S06YYdbs7OttEd1mnMTP91XtcOZcuLRaDBi0xiA/cStl64+9263gLryHrwzkoiOxVZySrRZRd5V47SYVqBlcUxEb/RPJ/Iv01pIbLlPPZFHsopwqqhJh1NZmx0hIYCm6gs5gv3QipNT4u+fZk/uMUMj/0aT36tifX8uCk3PqVFph2MLjaijO6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PPFFEC453979.namprd12.prod.outlook.com (2603:10b6:20f:fc04::beb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 08:04:23 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 08:04:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 17:04:19 +0900
Message-Id: <DJ9GTMO2NKMD.1SAVC9OBXNXI9@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 05/20] rust: io: generalize `MmioRaw` to pointer to
 arbitrary type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-5-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-5-1f7224b02dcb@garyguo.net>
X-ClientProxiedBy: TYCPR01CA0173.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PPFFEC453979:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b26bd4e-095b-4591-f1ad-08decab4b5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oighCIf+QAL6WFSF12f4cP6zI2NU+/NyP5ixAnMXRacv0HvXd2DuVjMtirYXDHH0T9xQnyOa1pcLwREcOYwEIT1EpzmZOrwXmlN/rwGfuq+rb9zrfa5Qd2q7N9pzz52G0uAQNiQyFG2LsBLDhgsjSwVrNvaRiFSR3VGxKh8x6MZgTXRURiD70XgHxiZcUkV2zGVYDVjZS99nMkzrI2CWZ+7gXO5CWNuKHFdjV/2Jvy0npYBRaMO+rnfLK8kZF2pGLPv79gdQrak6/Xy5SlRDVz2KnODF94KfoCiuHhcjgA/0PeK7bNWra0SxhqLexEBhWAl4xJ0Nq9ksZRMrnWjt1YK3ME2QuiC0tDX6a36Wpx2l38B74BQ6ivPeoNZqwN907NSmYhfKn1RGEkY4n9Ye03e4qc5rDmtopD41FHcsNXpUPRPOmiiaM5RhcpTanbgWtyswWE5MKkKLM4TrzAiYMh9fyH9NC2t/IS1/z8ae8F/z8buNKVt2zvUpFM0+oEUY4ZlOe81q4/YlmvHxsAREksBbJCQA01SPtZsYthhNovI/i4O1KY0A/vK8Oz399ffLkVN6V6BI1gKCIisZ7eHKYmKfqs2xTnGmMNZNyTWItI0t/0Tuf3eyuw00ZbrSFT2+h6rnzedaFMWyO7XMSS+WZnm8fV/Yvaehuen77dIyAvtuJiljDeCrc/6N9iiPDr6B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WElYZU5RTHVDTDY4WFNPQ2tSYkZRSWRDcVcvYVpWbDVQWEZIblZqc2d5Z05H?=
 =?utf-8?B?c0VpS2tDeFFGbmlwOHcrbWZvUTZQblNPRXJEL2tXK3ExK2l3STJNR0xhY1Bv?=
 =?utf-8?B?S3J1RURMdllpaDh3clJXZUpoRVVEczlOWUtvbnJhV2E1QVhQOStsTWJMVDVl?=
 =?utf-8?B?WnVRd3hKbDlZK0NCeXFMRkgwZ0puaElyUjJnMFRkQnZURzJuUnVnMXd0R0hL?=
 =?utf-8?B?bHJvVU8vQ2FKaUI4dS9JNHQxN3FabEliNW9JQ3RRNzBZZlVxYVhuKzJNM1px?=
 =?utf-8?B?Qy8yaUQxdlplOExvNTFwWTZ3dTRtOFNraVovVW1nZGx5MTB0Vkg0N041Q2lE?=
 =?utf-8?B?cC9NL0wyUWh1N2ZNUDZFOWdWQlBEc1Z1Q21NQ3IzL0NUcjBSRk9SVTlyT3pW?=
 =?utf-8?B?TnFxbWpLTXdJZncyUkxrME9NNzYyU0lIT21wVEFzZXYwTkFMTmRvSDVvS3Ax?=
 =?utf-8?B?TUJVK3JaSVZFWE1ZWGpVUk1HUXFXTytmNEw0V1dGTDJ5Rnc1clZhRHM5UU5I?=
 =?utf-8?B?RmhWcVpKSWt6MFJXNkJ3ZUNneXRuVjlRYUJDTnBnaFNzNzdFeUJxdFF3S01h?=
 =?utf-8?B?Y2EyNHpjeFR1M1ZSdmV6TjRCWWVMZWtZUTRraUowV3BMWkxHUlB3YjZmbHA1?=
 =?utf-8?B?dlVtTWdsZ3FSMTYrbXRGb3AzMDUrYk4xdTZsa3dlTEJpZ1Y3ME05WG1XQmJr?=
 =?utf-8?B?MmtKLzQyOGVVVjNXZThVcDlRcm9XUXZYejlLdzRZNFZqdk9wdXpqdlJMR1kw?=
 =?utf-8?B?UTdaQXA1U0ZGNWJ6K1kzZ2VXV2RPWlE2V1ppYnJxazFZWGNIYTBZWm5UdjB6?=
 =?utf-8?B?MHpEYjN6NTFTajNHMDlVOGdOQWNIeE14amI3U0JDdXY0eWh6cDlMK3g1bjZH?=
 =?utf-8?B?SWREc2dPSnlSMWx4NG9iak4xRk95a2FOMEZFNnZyb3lUWFdWSHNlYU1vRnJP?=
 =?utf-8?B?Sm1JY0hNU0JOOC80OThmL08xVmN0R0krMlJUZUtMTlFrL2U3L2JqVDV5WTNa?=
 =?utf-8?B?NjNjRjlBb2kvVjlkeGttTHQyYmFpdUhuc1RvRlpaOGw1R3ZZZS8yeFRrd05q?=
 =?utf-8?B?bkVSYlZJZE9EU3d6K3AxS01CeE9uUHNRdkFtUWU4SUU5VVF6NTlUWjV6bjlQ?=
 =?utf-8?B?bTVJYkdRVkhnU1JuUEdobFJGSVhCRzhKUURvSENRaitIRXc1SWNXZzNDYmNT?=
 =?utf-8?B?ZHJBZWp6Z1Q3alptVkxIeHhsci9GT1NpaERaY081THAxWG1qTG52OWZaVk91?=
 =?utf-8?B?dmpBcFM1TmVPcW44NjdOYmRja1E1MitkZWZsUTc1WS84SHNESmp2WlRzRmRE?=
 =?utf-8?B?WlBxZ0dJdGJ1ZmVSOXhXN0RoTnlFVFd0Nm9DaTdVaW1LV2gxTkpDejArZGNj?=
 =?utf-8?B?dndablNFaW5HZ2gwVGluMUMxdjZZYVI0STVzV1dBb3N4UWRaUnc0Tmo4VXh6?=
 =?utf-8?B?ZDF0K3hYY3ZjZFpLUWpZYlI4SlVGMXppZDEySWtGRk11a05OczNBVXJMeGlP?=
 =?utf-8?B?Z2lZVTlmQUVWajFoNmJuK3ArRTQzaDJNR0NmZEJqZmJIcUZkbDhrR3Q5dkt5?=
 =?utf-8?B?dVdyTVp4TFRobzh4c2NuUXBQeEppY3J5VmdZbWxRUW9VQ2I1dEdxNkZHZTIr?=
 =?utf-8?B?M2NBNGpFSkxiY3J2RnVHVlhlZDRrREkyNTF3U0prUDJUWEIzYzkvRmE1YkFz?=
 =?utf-8?B?T0xPS2xpeTlsc0FLK2ZhaGNJYThoSm5UaFlZdStOTmhZUHFheFdzYkZWN2g5?=
 =?utf-8?B?RkdwbFJVSUd2TXVVdzFXKzZjODBmNnpaZTJ2OEwyaGo5OWt3alFYUjlHZGE2?=
 =?utf-8?B?K0hTU2p6eGdzYjVsQUdUdXZXSkFZcVkrdG5MQk1Ld0JqdXNUdE5aMEdnMEw3?=
 =?utf-8?B?TGlTTittZEhyMmUzM0p5cWNkc085U014c1RsVTVnTFRsajFzL1NVUU1LbjRy?=
 =?utf-8?B?Z1pJeElwcnp2SjE5eG4xWVVYZFNpYTdKdnN5NDVqTGNobllKMmhaTWRIMTdX?=
 =?utf-8?B?cUF2eGd4elg4Zit0TkpaMCtNcWlCSVFJc1FDT21Xc2RIZkFueURHcjZvYXh3?=
 =?utf-8?B?Z1NacXM0UUxwck10ejNtNHE1cFJlclVQNEFLQW5GNkpSbEZKRHhWQjhVbnlU?=
 =?utf-8?B?dUtoMlV6V1U1VDJkNmFyMS96Um5xRzZvdkNjWHM0RXp1bXhha1BHRjVmdVNy?=
 =?utf-8?B?bm9INEVoOWNoOGxta2lxb3dKN3FzZE1tTW5nbTFndzE1U2luenVmNEpab2w0?=
 =?utf-8?B?WDYrUmM5M0ZUS20rUVNwRlFUVHBWeVMvL3lxSXFvTlUwekxyOVQ1eHd0RUtS?=
 =?utf-8?B?YVNzY2ZpSVJLVGQzMDRTMjFtR2dBL2c2R3RxZGppTVAxM3pIVzBpMGdkaVVR?=
 =?utf-8?Q?8EOur2cz3dE1lIwzrsw0TrGsf0f8sMeMqVBPk+sAVbAVA?=
X-MS-Exchange-AntiSpam-MessageData-1: TLuedq/QAkVOvA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b26bd4e-095b-4591-f1ad-08decab4b5ad
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 08:04:22.7772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3gWSzTGwWE9vz2y83uxDpfmqsSJOo3GzGFvot6AlBynuyUzElNGrqw2xpxL8srWhwofR5EEYoSxzQJz/I/v/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFFEC453979

On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
> Conceptually, `MmioRaw` is just `__iomem *`, so it should work for any
> types. Update the existing use case where it represents a region of
> compile-time known minimum size and run-time known actual size to use the
> dynamic-sized type `Region<SIZE>` instead. Rename `maxsize` method to
> reflect that it is the actual size (not a bound) of the region.
>
> Implement `Clone` and `Copy` manually, which cannot be derived due to the
> generic parameter. The use of raw pointers also cause the `Send` and `Syn=
c`
> auto trait implementation to be lost, so add them back by manual
> implementation.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko's potential leak on ioremap's error path seems worthy of
investigation, but it is not introduced by this patch so:

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
