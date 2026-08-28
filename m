Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D819F14A8B;
	Fri, 28 Aug 2026 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882883; cv=fail; b=Dqa7H+TfxNAYpojCn+9PxIOuJdWRkuQ4dWuA0XHz5AvcGbwj73nIM4sabpuGliNMDWHwiZjMzkq+C3rNqoEuO2NfDXf0ZkfocA637dXbt2DGPW9bK0/a/hn7iEeW0Ul3fVhH7db+OgT9PQKLCssC+W8mT+ZWTLLQQmKcpwi1hdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882883; c=relaxed/simple;
	bh=vtHH0sUIgfMg7Ej37sivpLCfCT8PCkceMK3NYkt84IQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Z/IP+1ocd7bEc6RVZac9PrJK73w7m8/tgXGmCrS2Ov/T16L7MyOhbwZf0LmoAxrtdEPK7mRvYit90fvQu3CZ/W0Ercf2dNxl/1WPzYXEfSgzpQgczfNyIYuAaoFIiijT1gJ0HXlmziOBSMhAs/gIcOsOON2Vskp+pkyjgnzCL1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=norxD3XL; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="norxD3XL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6AHoVpArgmQsV5g2Q5UleGIFViMoft+t2frBa8E36XcYT/jjVnsjvNlcJf+kyaEXgkW9OJTtyh51x+44S5RsrsGfUqf7/32ee1hVxbiE8RR87+grU6IEBL2fE6YkESBFxWFh9cFQOlkruiF/HOCMC65PfddK95bvDoYV+9kbs7OEvrbDVSkkPI4DSwZwclQa6KcmzbD39+U+oULc7rslX1/f1hwq8FjFLFORAMrbqYuVD7EgKifFVnGw2A8o/RB0vCLrLT21cHa30JCm2JFPuYxlIXomzdfFFX1RynqumYFm0cpKWClhXDK9pLa1u1zkt7llSpYr/QGeSVFIiqNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtHH0sUIgfMg7Ej37sivpLCfCT8PCkceMK3NYkt84IQ=;
 b=bncIMLBG1DLTF8z/eRf77DXefe+eTXvAbwtzpr3IKp3809Ngoh7g+EvcNS9jTRV3xyVHm+wPq2G/VHm+iewuPML3H6JC4sEMWpCHcw+wY4cW18F1BnhbPyWWEDwAbmgrzQfTsJeMAiTq8EPjEXcpsxJR2hwmgM6gIr4XL964a4ZOQpuVRVA8mHb3gntCYFEklxHc2ePjbOepU8FFigLAUEEY33ZCES5avcRkygbVc6Yr++5wma8xM/GXFo5L8OrxGUzlOIbJX3/UO3lC+IABtrQKB3N8ijU7TXsZYwXz4swDnH9xzC7Za90ET2x6GbyOZaKrOK/qUt/r1iDAV6fW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtHH0sUIgfMg7Ej37sivpLCfCT8PCkceMK3NYkt84IQ=;
 b=norxD3XLNgJCu7pI5dXhMC0lWv3DFIrQUCXe1fxD1cRzHnKMfMdDPyZNA0Rh4yBpObxkAsxsp1ucuF76wuD3MinDWX2B6Zdzj587JEFd6o66bK5JgE8DI+Qm4q1XDGSXOrc6aueVizRYX9MwGIv+aL7FpEMIx6ZMqbTHekSxpKu4Om59Cbv2L5z/L4x8xeIaJFDmhFaHbCD79DfxaDBVdroM651WbI1GE7KxMdjg85/X6wuXsHFVPRjgeBn3dHmw12W7FHnI1pMSAzp3W/O8yOgYKekxGlXRKEV5V5sj3frFBhLbETLwY06vhTHK+3Gu5Hm/Rs2gkHx+7EYsL+tiUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 02:07:51 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 02:07:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 11:07:48 +0900
Message-Id: <DL07KZ0JS91S.343R8RX3V5AG@nvidia.com>
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
Subject: Re: [PATCH v3 15/16] rust: io: register: remove `Register` trait
 and cleanup macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-15-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-15-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: TY6P286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f279e0-ee86-46fa-dc7d-08df04a929f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|10070799003|376014|7416014|1800799024|10067099003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	5YAzDsxTytZf5Dl2hdmOTQRAP9nonFpnt8pw5Wr9ItShrWHeg/ENDpkiyeHDBXL3aSupPcUZRuR2O79sqNYkiAPBb7cl6IjyFTeVq1O2jbFdhXJTGeuKgy92ySuN/5oSIiopR4orWJirkDWn4S7ox5J0TQnrC0AQZ/VB8zbgK95/Lk+jRADPjM19RvF0mGQgJ6Ha7CqMXsRv2A+lE0OY3+rQbI8255CoseZNyflhzisPTMH5c4ptEIgYLvNchCpO5qKG7vbhsINQxHb1LAuHThicjUgfaQL8imZQp3cdj215K6uLEP2eoqaR0qWsBt0AUKQPVl4iYXZQL/tLq4yWy2RXMHnfkfDWREiMOgCgmMR0vYmitxxgXjX7Kzixumjgqw2RGULYoqov5tM1TQrkLR+Z6KRk/qrzkhsf3WjAJRvQGqkLycz+6h0XjgB985t6ygk2d+OH+AnQWGufhWoM9O5zVUh0h1d9zg35Cx6XrUjtGTERCovZa8A8G2ycRwevSowSlls55KsFcgJffUjMmRmyP5h//rx5uWcjysu0PbjyxDr+orO3V9QL7CAHssqqukOqEWDW5sWggZ6cS2I4rM0goa9ETmvdzQbZ9GDNZZKmCmMPaj1zypb2GCj52nZ7E9UPONP1PWs1e8iKH1B/jjtD6n820cGe+kviBAEcfBc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(376014)(7416014)(1800799024)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnhLcGdCaFdlMktMSTR3WEpIbE5XeFJmcXI3RmVsWldSa0hxd2lGMVpkdFdY?=
 =?utf-8?B?bmowWTh1WmMzOGFObjZ3eExOMzhoR0htZzJ6VTJTenRmdHhEZWpXcURqaUZ6?=
 =?utf-8?B?azdWRHNMOU9MSXdqTEpWa25nQkhiZDloWWRrM0VPN1NqYkJkU3RJVE9kVGY1?=
 =?utf-8?B?dG41WmExNmRidjY5djBmTXhIZ0VqeEo3dDVZT0pmZzRBbk1JeUJYc1R4VjRr?=
 =?utf-8?B?NXZmWkUxaVdjNmxJMitrQTRuRWxGMDJUVXhjeStwSFJiUkRYUWJkZUZIcjlj?=
 =?utf-8?B?Zk5XdVlRQ2IyYy9ORWhTMVlhbEhmemtjS3hmcHhOWXBDd050NFZISnAwYkk0?=
 =?utf-8?B?RGl6TGgvT21KRTNETWljMFhLU29ZaERxRmxIdzl0MzFzTEpCNlZ1bnFiejFx?=
 =?utf-8?B?Um10dzlQUkk5MEJIRWk2VEI4bVNNa0ZpdnRZdDFnOWdQNjNBeFY0SElqU0g5?=
 =?utf-8?B?NzVacm52VTd1UktwS283MG5WckVVdVZXSmwycXFhZ2luSS9vS0VCc2lmYjNI?=
 =?utf-8?B?UnFwNytCbUJFMFdUaTdxbnRUaG4vR2g5V2Rib1VkejlEZXRvRHB6Z25JUzI3?=
 =?utf-8?B?MWlEdGRTZkJiNVgxZEZqUzI1b3hQb01vdEM4cHVMS2JBdVhTc3g4NWhoUGxh?=
 =?utf-8?B?L2F6eFNvWGN2cS9xTHAxN0tIYVdoeTlGNDFpRTNYVy9TVlN5Qi9SN1UrNDMv?=
 =?utf-8?B?dVJSdEQyNUtqVkNpbktrVng1RWRTbFhQcFhhbHIrNkVXOUlUVEc4czRjdGtZ?=
 =?utf-8?B?RFFXTWl0cVJKOFZJQUhGTGZGQ1ZHTlRGWmVBeTEyUUI5aG1XanFiRGNuV2xv?=
 =?utf-8?B?VkZLZ0trcmRsYkdjKzVtQXRZazU3WkthdGRiZ3NRTytzQjExa0o4WXlYbU96?=
 =?utf-8?B?S1RJSWZsSGtqRFVybndYL0VOOWpNcW1JbWJvb3NPWHVzd1RxZFBtVHNqUmxS?=
 =?utf-8?B?Tm5YTWR2TXVjcXBiTnZCNCtFRE9qSUpia1dVOFkxT0E5cnpTYWtPc2hxSVg3?=
 =?utf-8?B?Z0tKV01wdjlKa0RQT0l2YTZhY1l6NDNPM01mT3E3cTNKa3oycVNaNVhDbk4x?=
 =?utf-8?B?Q01OVnB5NVpvZ1ovc25adVUzMW5ZTUZ3MHVoYk9vYzMyd0JaNkJiYXd4RmZK?=
 =?utf-8?B?WDgycVBmZG05MUVYbGE5NUw0b3c4RlpRaGZEdXE5YUpWOEt1ZUVlYjFjNlNu?=
 =?utf-8?B?bW5BT0hPZ2dlZkhkQklpM1d1eHZVOGkyS3F1S2kzaGFaU0ZnTzE4R0xUNHc0?=
 =?utf-8?B?MW11b3RHbXhWM0lLb0J2d3NGYjJMZGdHejE5VWM1VnVkVUxabnNzNnI2Vkhk?=
 =?utf-8?B?NGhGWExGMEhsWW9NSVBwUUwxeExVeGpqc0FrVVNuaTk5dERWMGVGUFRQenF4?=
 =?utf-8?B?UGNiK3FPTE9DbkVKSUZIVWN6VU5WNW9QdGdvK2MxM21NM0pCb2VJVEl5THph?=
 =?utf-8?B?aWJNelVJOVRUZHViMXpNR3dZb0xjdUQxSW5UMkpTeHJGM0pBQTAvQk96QVFN?=
 =?utf-8?B?RnR4Q2hRTERicnduQzc1aXNxVkQwWnRQd2o5Yzd6K0FlVHJrUzN3eDBvVThx?=
 =?utf-8?B?bmFKZjY3MitSSStnNlhPM1BkMFZIYjVtZ1kzaUp1NzhJYTZBbWdsMmtxWm1q?=
 =?utf-8?B?ZGN3ZXhTTGQ3aEw5c1BPa2gxcEtaVHdDOUxmdkNDdTE1eDVIaFJ3anlVQ2c5?=
 =?utf-8?B?ZHpCb1VsRHpISndLQWFoOGdtTytXaFpIMDQxNCtQWGlCYndLSzdBczV5UFAv?=
 =?utf-8?B?UnRtVTRMdjR6WFlUcVpjY2NRZ2x5MkxXbFZPN3R1ejRETGZsbTJabnJEN05K?=
 =?utf-8?B?UVo5Wkw5c25vbExlL3pKY3RHalNXcTAzalFIeDdyN0JFUFI5WXIzTXJOWEtY?=
 =?utf-8?B?enZyaTVsREY4U3h1bUhKUGozRDVENTlhQ3dVRjJVZVJiem1XRlUrYXlWT0VW?=
 =?utf-8?B?eHM1TEZ0ME9nYUpmSmZwRXRHVkxqM3VrWGd4VnMzRTR3V3FhblNaYy9FZG9k?=
 =?utf-8?B?U1lFWGI1dHR0Zm41YUVLZTJyeVhLZDl6bWg4VGYwSmUzSElpQ016akRQTU84?=
 =?utf-8?B?UDBtUW1PRUVlZVZmd0QwN2tRYTBBdDJ1YUwwekc3eGdvN1ppRUtJdzd4ZGRZ?=
 =?utf-8?B?VUExQ0E1aXdxeEdIUzRHM1RDTDg0NVpYbzh2Mnk0V2ptNStyZ0xBZ1VVcE0y?=
 =?utf-8?B?STJtOTlzQUR6cjdMNmIrb01FbVVrYlFWM3dYcnVGdTdNZmFxR3E2K2NETlBH?=
 =?utf-8?B?R3BmamlpRzJQeExoTnpRa1BWVzU4YTUwbTE0aFVxNFlBNGlrUzZUUXk3TExP?=
 =?utf-8?B?K1I2dFJVc0RHTlB0VlpFM2QzeU5MZHFLaVVIYzZ1amRwcGFFQkd3NXlPRHdu?=
 =?utf-8?Q?6jbfEkJjVUZd5gFebDlZK3XlQ7DL1/qXzgyqwFrOBvxhc?=
X-MS-Exchange-AntiSpam-MessageData-1: Mv4QntfDkt2uRA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f279e0-ee86-46fa-dc7d-08df04a929f6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 02:07:51.0855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUh+uxihFprOQWhJAkgEBSEASqrTVJqna9oeY7aJkIu5jFfACfuVCvOBKNqFRaAGuycb5jP8TBORFn5IM2gSLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> With the removal of relative registers, there are only two type of
> registers left, fixed register and register arrays. There is not much
> benefit in having a common super trait for them anymore, thus remove it,
> and cleanup the macro rules associated with it.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
