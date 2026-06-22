Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5225E286AC;
	Mon, 22 Jun 2026 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782089377; cv=fail; b=S+gMf3UBvz9NDmx/JcuXlX9fL24FX4XUUJ5jrxoq3DTUXHUYQSNzy1J4YJYwGZKab8s0U3ar/HEgbr6dESy6yXFSu5vQXrtd1l6Yy17bRJMURqzulJqjehu1AQI44l3VdoA0ZT0a68UPKNPJ69YyhSm7LM78Bk0jc4dooWqLf6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782089377; c=relaxed/simple;
	bh=HworcNN84H8U47ny/01y1DnDouFW32wqRpx4RIn93/4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=QobcJx159DaAWZGXIg65lhiv2f8a82I1NuVJABroXs9nTbEu/hbvvomAfbTOVVLYqRssnbNA0zQElQgBdzrsO/Yi5pJXNMnj77G69A5MxWIprpTzVQDvzZufgcxz50IY3zoa6Rz2PknbQZWlbSbriCp3oK5Vz3b0I6WXnPay6yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kKw0VHf1; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kKw0VHf1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQD6sHk8kESwdpXbm+23nf74htY/Z6RQ6pP7VEZs974Q6obV4xOhJZjvFfR0kQm0AkflVn5zmUz5CXwtfAJBdc6+x6byrv9yMxgRIWjO+SE2S/ryK/Ogy7nOOo2qHK35T4movWam2aY63jBixtRsHYjOlNbOCRHgc08ih9kNHLk2mYedyuAUGCiDNVXgT1jR8mWL6eg5vbU06JOwWzf2IsrpLI8TN8afladE0GDKqJ1CewlkAU5AwbbDdEf9PgZp2/pqEHKMLY/cPYKOaykGtxfX3+Z4jaIz/q8rfF8BqropiO3MW/SvIVb2kcC5N7G+IDpNV9fnWlWYrfvLD9tBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HworcNN84H8U47ny/01y1DnDouFW32wqRpx4RIn93/4=;
 b=iQgTaIecs+hxg3tLyzDgkqSxNeVAmfCIdFBMAQaNcdzUxC6aFDp5qaWsFmm8csKnZQbFeI+trSVbHRGhbjAsezTqqFGtuho6RISt7ry71fqY517HgRyC/dGeB4MvNM7vWgbmQonS9LekFmya7AurzBlMiWujzwOeY3a7neS1VCpktOQBrnGO7LtdmmWcegiSrXsA8xLaHO6tv6boq18aQvdCkarA9Sw4kVAWf8LnrhEWbPxL/UIl4/RcCZ/Ou8fM9zEf16Mh4a/7jG9so4JSUOMwx62C2GO9KEotgn/HChJr/AeDHsVngFGWxmsC+RjNqR4/zQG2rsOvt6UOk4zxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HworcNN84H8U47ny/01y1DnDouFW32wqRpx4RIn93/4=;
 b=kKw0VHf12TaxTxeoGHU7RMJ95UULualTOp7d/cMA2qGvoURFNBijzxlTKwCjWms7q24yRrvrad0EgfiGMvQaAmThkyrXPXUzFYAeoQBTH+itFMJYQNih2Vfy1Na8DTACBxVoFnGHW6s6Hf7JYAHvQbyXri1Oc8gIaziX9sQgZCVSYKtF82GTEa9vignT2H+xu82Ef67PZW6hyxXUNfhp7lC5AjHF3Mj4aL0ai0d4FND1d5SgPQ1cYUvgTiAWfaZlLK7wLB+bytkfZGeZ1l3bIiq/anoJzMYZZPJhhuPutMpY2vl4ptQzuVlv1g9cbKGK07f8oxjNz6X1siMjagMFag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 00:49:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 00:49:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 09:49:26 +0900
Message-Id: <DJF5YH4ELR47.29OA9NLCHN2RJ@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 09/20] rust: io: use view types instead of addresses
 for `Io`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-9-1f7224b02dcb@garyguo.net>
 <DJAJ51781EOF.1Q2VTH6CQVXYD@nvidia.com>
 <DJAK39S4J6EP.2VY3R7CIBAPOL@garyguo.net>
 <DJEM4MAO7RON.1EC4OJM72BCNB@nvidia.com>
 <DJEUAKFVCM0M.3VV7G8AQRXAGU@garyguo.net>
 <DJEV166T78O2.22Q1ANXGBZNU7@kernel.org>
 <DJEVAQBVC350.1TA0D5TFVU0U6@garyguo.net>
In-Reply-To: <DJEVAQBVC350.1TA0D5TFVU0U6@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0046.jpnprd01.prod.outlook.com
 (2603:1096:405:372::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: a13cb024-dd5e-4e0f-23ce-08decff81ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|10070799003|376014|23010399003|1800799024|18002099003|6133799003|22082099003|5023799004|4143699003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	jMH5qfom0qON9TtLWjvLvf12eRLLfZncWTouNeIB8752OIRLwnSHr7gPrYE750vio+T5ZgwW7tGpjSX7FZlmUzMXfFn6YSTc421MlPORnQlIKTnWl6cRplIcEoE6RwCSYL5Y9UT6WQKSpphqQSaPkP0r5hPAogqiBIP7HGSk3FnYkPX7WSUqxqLBzttjefTlz5XIJZdTyNDX1SrD+VWckRPOCar+yKD1Vipt/LPhfo8wi77KRCSKdcFyvYTUrW7e69YawqPbaBM11pNcpElCDqSAqlkrzr+a/rvYq55HpwCM9rfIeWJekoPn1cRDgELhJHuonpSdqeAVuBpyERlj06z2pZt6tZgbaQQGfpGvkV/606LkWEEaNJUTz1u0E1I7X5CMl39daYjV36yV7jieE4WL48GvWd/h9xCIDHAoeFo2WUdClo5tw1ADeomKuAdjuL3MlH0vKOxTvj8xrigTV77cq/fxpj1NoaSFgLDZYto2n2ywfX+q565nvEMaYI6oBxaJJVQbCkpU4x2j5iUEj5RCCELQJKN88wS29lxEX+OZI5rAWQjqKTChdzqKSbiQLJFv/nUuw/xeSGYbzFtVYaQ0MFxdrYDjjwha20BMMAPqSE12mM0zLI5Fs+wibfErE/cphcRU5lnXizAFsl8ew094409FC0HpCnqhgPDxPiw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(10070799003)(376014)(23010399003)(1800799024)(18002099003)(6133799003)(22082099003)(5023799004)(4143699003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVE5Wk02SHFkd2h3YWZrb3ExR3E5bys0akhkY2NLVjR1K0hHMkZmY0dLb0pQ?=
 =?utf-8?B?cnl2YTFseFVFak1MZjA2UU1jUjQ3TytYVGhZWTJ3Q2kwTVZXYll1K1htc3hM?=
 =?utf-8?B?bWxKOU5ic1N0M3VabkxTRVIzbG1GU2l4VWN4dkZZLzcxQVdjaHVYc3J6OUI1?=
 =?utf-8?B?OFYxM1ZzZk8wOGwzMFd1OG9IYmRoOXVsMnhuUmFxSTZyVTN0cXlkdEJOeFRV?=
 =?utf-8?B?OHk1TklJd1pxamkwS25RczJnY3UrT3dwdUpyTzdabTBjTTkyUTlTYlA5RGdV?=
 =?utf-8?B?cTd0RVdlKzNRakgyWmxoM1VSQjdxWnlieXhCSHRGZ3lGc3U3Y0k1L25xdXdI?=
 =?utf-8?B?U3h6WHBMcE1BTXh5cTdCSmRwRkdoWU16RHhzTzZuenlYWWFhVlBDWlhVcS9R?=
 =?utf-8?B?cnhpeXp2T2hsaXIyS2t3R0FvSXhRME5JVnM0U1I2dlM5QTY3MEFoNGNVVmpE?=
 =?utf-8?B?ak42c3lzT2RXNGpQbkx3SFVmNk9HUGZ0YmpVa1FVRzdGVU9wZDYxWldVajlo?=
 =?utf-8?B?WkxMTmROVE9PNXljTjBnazhxbzBleDNnUGx4SjZCdHJwbzh6c3JLN3pFdzRV?=
 =?utf-8?B?eVJTSHF0YVczMkFlMGJLTitObDJUbjZwS2RNOFcxQWFGMUYyV1VXZmtiMWp6?=
 =?utf-8?B?Uy9GNFJuNzJsUzQxbFlqc0VwbkpnZmJKSDJuWWFSR21MTEVLSEEyTE4wYTU1?=
 =?utf-8?B?VE1rNmdiT3RJQ0poZ29HZ3FBR3gvYXFidUt0cVduWVlaRDllL1FnbGMyTkJu?=
 =?utf-8?B?R2hjWm9taXZzaHBaZmgzUHJOQmdieFBRL29qMFRadFVia2k2SkJsZHB4T2dD?=
 =?utf-8?B?Z3FzdXlxL0JNQi8vbnZVYkZURHJrSmxqa0hKdG8xMGJTbFlQekszTzMydmhR?=
 =?utf-8?B?VWpZVzZtL3d0SEdPZURnMDQ2L1VpZWtxaWVvMm03c1k3aWdqRHhXbUNwdlli?=
 =?utf-8?B?QjFIblhGR0Yzd2t1Q2Q3SmNQRExVSVVEaHJQUGpXQ1R0MEE2eitObTRjaU9W?=
 =?utf-8?B?bWFnaTUrQ1piUmpKd3RLR2VsMEo3VS9HUlFxRGQ4aUhjYlFia0lNYkZNTkU2?=
 =?utf-8?B?WTBSQUNrSXR5Q3ZCMXRzNmZ3bGp3YTNPUFNNcEgzNjZYUVZNTXUweWpVSU5q?=
 =?utf-8?B?YUhLZGhxMC9tVGFqdWpPbFhORGJHU3lrMmpWSFQ5VXR4U216RmZnTG1XcnQy?=
 =?utf-8?B?UFB2cC91UHRWSU5JcWNVeUxPZ2FTQk5lcXlieHh5Q1JTLzk1b0FMQk1MVEg5?=
 =?utf-8?B?TFcvWU1pVktIKzVoTjJicStQdlVrbVdQTmdqNlV5QzYzeUQ1SVh3aXF1UUhR?=
 =?utf-8?B?RWNoWFZYS20xRm9iczV4WVhaYkhyNUFSejZSbGJJUzUvTU9QVUMrNmRYWk1i?=
 =?utf-8?B?MVZiMVI5a2xsU01XelUxRkJVVGQ1anU3Y2VIbFBIMmVpM05PbmpmL0ZuV0Va?=
 =?utf-8?B?TEE4ZzdVWFNNRnV2YnhlcTFQRHZiMlA0cHZXRVM2N0ZDWVJTcksrYmJYcGMz?=
 =?utf-8?B?YmhTV3N3OTc1MXhoNUU0TkplNHQ3RHg4STJQaUd6N0Y2bVloTnVZK3RXcFFn?=
 =?utf-8?B?czcvYmQ3dWpyeXl2ZW4xd3BYRElzUElsMTdQeHpzL2t0MHdXOEtvNVF3Rmgy?=
 =?utf-8?B?aWcvMmd2a3R3ZlhKeHlya0RUWEpSUUIyRGRGdHB1SERFclZPRXkybEM1c2xB?=
 =?utf-8?B?bm1lM0FGbWY0TXNjSElpblptSVJiYlJFRTJhZ29INXd5bUdjeC9OZCtFS2Q4?=
 =?utf-8?B?MXgzd005NWsyajNJSTd4WDN4VkdEUDgxMkQ0aDhGYUhGSWxiV09scEJITkV3?=
 =?utf-8?B?eThBZjhPUjhPMDNRd0RnOEI2aEtXVURqWW5nU3BuQlpKREpERm4vcG5wNU5S?=
 =?utf-8?B?bkVSUzJNMU56STNQZVA0aXFXVzlVd2JSbWJJek9PN2w3ZnQycFZBL1F6SEhZ?=
 =?utf-8?B?NVhKVTZ0cnNoY0RMZHVXa1VPM1dXd3BrMldsdTUwcTU4RjhxSGJQTmVhSEZr?=
 =?utf-8?B?VmhtdU8yemRDT1hYSXBMOFFlV0c1NHhuaWU2T1NqV3JPNlFTUmJXUnZ2U284?=
 =?utf-8?B?VkFnLzdkbEdKSGY2SmJVd04xWWQ4bVhvNnJ5clJUd3p4bEJPcjJZc1lOeGRY?=
 =?utf-8?B?TXd2NVY0VnlEMklnVktYbmpzYXpaUmlCcXV4aG1xeE43eUNOaFFUcVVqMjhr?=
 =?utf-8?B?RVVWaHZlYWJwUVBCdFFrOWNnTnAyS05xWXhsKzMvRVVDRnNQaURua1ZCRTNR?=
 =?utf-8?B?aHhabUthNUs0QUcwRHgwUkJRVFVHUjBZUnFobFkvZGd0VXIwOXA0U3YzV0Uy?=
 =?utf-8?B?RGEzYlVvakVsT2VZY1JVZ1Bpc1oyaUkvT0dwL24rZnpCNmcxZ0VrVFJybWpa?=
 =?utf-8?Q?Cz5HMApDVNItHJcMfNYaQGvh1Py/ns5HaJFYH20pG3OL2?=
X-MS-Exchange-AntiSpam-MessageData-1: rEdQNxYGJy0Tcw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13cb024-dd5e-4e0f-23ce-08decff81ec5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 00:49:32.0124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUMtsQuuJ8LODHQo0Hh3MudU8RdMJIh7k1iOb5qdhtrc7mKI+uUiLFMhU8bUvSxCdYiJ54ryhVJi5+VekblIrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076

On Mon Jun 22, 2026 at 1:28 AM JST, Gary Guo wrote:
> On Sun Jun 21, 2026 at 5:15 PM BST, Danilo Krummrich wrote:
>> On Sun Jun 21, 2026 at 5:41 PM CEST, Gary Guo wrote:
>>> On Sun Jun 21, 2026 at 10:17 AM BST, Alexandre Courbot wrote:
>>>> As you can see, this lets a 32-bit access be done on the upper half of=
 a
>>>> 64-bit register, which sounds like it should not be allowed? Similarly=
 one
>>>> could change register types, and so on. This might not be "unsafe" in =
the
>>>> sense that it is still aligned and in bounds, but it lets the structur=
e set
>>>> by the type system be bypassed. It could also potentially be a violati=
on of
>>>> the hardware contract if the access width is relevant for this particu=
lar
>>>> address.
>>>
>>> I see no reason to prevent any of the case, this can be done by `try_ca=
st()`
>>> API as well. If we need to take access width restriction and other
>>> restrictions into consideration, then a lot of API cannot be exposed at=
 all.
>>> E.g. it is not okay to add `copy_read`/`copy_write` like the patch 19, =
because
>>> it uses memcpy_from/toio which is possibility doing byte-width access.
>>>
>>> in my opinion think people should be able to type casting without reach=
ing out
>>> to `unsafe` if it's not UB. Similar to the logic on why we have `zeroco=
py`
>>> that allows casting between to types, these are "bypassing the typesyst=
em" as
>>> well!
>>
>> I think this is fine as-is. The natural, ergonomic path through the API
>> (io_read!/io_write!/io_project! macros, IoLoc-based accessors, etc.) lea=
ds users
>> toward correct access widths.
>>
>> Whether through io_addr() or a custom IoLoc implementation, reinterpreti=
ng the
>> access type requires explicit, deliberate choices: picking a different t=
ype and
>> computing a byte offset. This is not something anyone would do by accide=
nt.
>>
>> So, as long as the API doesn't provide a subtle way to do the wrong thin=
g by
>> accident, I don't think we need to add restrictions here.
>
> I'm still going to make this a standalone function to be used from `IoLoc=
`
> functions only, given these functions are not intended to be used by user
> directly anyway. But I'll leave `IoLoc` and `try_cast` as-is.

Yes, `io_addr*` look a bit out of place in the public API, and should be
easy to hide anyway. Using `IoLoc` to bypass the assigned type requires
a stronger intent, so as long as we are aware of the possibility and ok
with it, I have no objection to the current API.
