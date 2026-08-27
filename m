Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C54078CE;
	Thu, 27 Aug 2026 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829667; cv=fail; b=FocB1xZaPYCGNwdrRz+BFKttcVZ1bnfjRPI2te9lzRnEZf/vuUDE11gvCv5oEy+6wHg0e4k/oko2iZPfIE7AUehX38kCQig+SCMqATGvJk095cpQXgfg7/Ow62Qb2uFQdoFR94+ZgZrS0LL8LNeYpSz5yrMZSQJCGip+Q8d7vjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829667; c=relaxed/simple;
	bh=ODYBRnj/c5luecoJ0fJHVGUuBHSFqAWgqBBgaHAB2Vw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=sSU83iXsJxbwOXsihipsbwKFCesVzOTC8poS7/51e3+vjZ/of7nKYxWLLyJrV8EmDA6sX5op5WYFg5S1Zq0Pz+i9UIpf57gESFWOcYAvgXieEI6AXnTAnuJqsS2qWUMnjKRE1ly6pgN0BaV/WhFybRvUsytgGtjmR+kECCCNKmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nq+97oXb; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nq+97oXb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dudOlRQOnxmkUPYeb2riD3FOIP7vrB6kMnbnfnMFJbpCnzGbg+cTm4xq66p1ImOGa/lYXE8yogfW0vgGacD7s1wCIZYG82538MAM+8fdmsUj5CAgCiDfSkjXFFCa0bDDAojWtE4PkloW4GXF33KEHE+BNJbauWzwA21y55rGbhgxQH7uLpEai0SNtPOEk4+Z2NleUug/Ur9YE1xG6wFDuQeYR8pq4/uMR681+hCzxFf92L0fGUCi637wbQVB+8Enjte/c6TQMGpqbTu/g6OvUyz+pJl2e1taF3ADQJuHhfIERGi4cw0cjKZIkno7g6Gy6n4oj6d1dzdLktlMf4aLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODYBRnj/c5luecoJ0fJHVGUuBHSFqAWgqBBgaHAB2Vw=;
 b=nFi8F21Kxmo29LT//rDTD0u93Gam0T1mrVh0M7qls6gPWFmRyFai0uVNn3WgtH8h9Rhhv4R5oIcdDQiJEqE7fSPzj+CFXHOn6lQEFpQndeYyb+MZq0j4RWWs+VK2vB0M6LaJYl+Te3jw64y8Ugh1dmLuhyf9hVHAxgN75uyqRMEsMUIbXo4Wk29/gy1ujo+xVkjjWy5xzWVIhlO/9zgKfzQ2v0/NG0l+sNE0JdMZdVOZdW+a1HSN9fZPoecZMc6qnLf3hSEy99lao7z11aCuY6ljVSCbKMCBE/jT0l96aeFTAoRCwsOgVTDkq4H6913qDhsu/GkAl9Rl5KyneN73Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODYBRnj/c5luecoJ0fJHVGUuBHSFqAWgqBBgaHAB2Vw=;
 b=nq+97oXblZG85mJos4xNR6Go1csZIWgv/1972jitdSozNPsdpktnJKgiX3B9RIZ/NUBEKRIYj2Fv98NvaDKuRJDjVFEwe2G3YS4wXiORMjRRD4fSoe6IXBV76IxuFMjn35Q5iOzs1C3YnZUplI1me+iwYVPp4pGgSUUgdWQ7oKYffZaiJvFk6m8bcBXdCr7p/wn28S8RSySJxpW03g/mPTGYDRpvU2J08x7qWcfVuGW/nfnMWUj8WCBSwcK1POthPbhRwY+MPvqlTQMQSbci2Ez/DGqRBibOa1+OEExJyzg/5sj2akzUx8G8sLzwWnDQXclwVwhe8TLRq9WGaS5TfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 11:20:51 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Thu, 27 Aug 2026
 11:20:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 20:20:47 +0900
Message-Id: <DKZOPTU693ME.3VKQ5JADPC7G6@nvidia.com>
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
Subject: Re: [PATCH v3 07/16] gpu: nova-core: specify base type for
 registers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-7-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-7-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: OSTPR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:604:220::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: fd427fc1-eda5-4e41-a822-08df042d40a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|10070799003|7416014|376014|1800799024|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mS0MEQHAHm7djuEFFh/68U+znCmx2lIrNHYQUU8ltwAiwzkVfRU9X10DZuMNpBgq2G9TBCIOudqZmdd/fqyuVPlAHKV7fOyHEHT1S95Vw10aaxHJoSX8R/SNsyM/s1bRIVt+26KLvvISwb5nCaVGZDvlCX5UWzut5SW4GFpbwcJQ8Wsva9ppbOOGF92RFP88GcVXoKP0wXL5O3YHKFYas+KIVD2PIUabICzy/iiNOuSetI+v7hYoQvGabuTXi7ySd+udo6SjdcnO2JbJnvwXucTA2oR3MhGHeiq4Fs+pCON/qYwXpxGo9u3jwpeX6GSeW8HDctqWeIUgvOmqAxi9kpZPfMG9fvK9DkLlW7rejRGoLW1EDbmMzt/WbaiSyBOxsYUGX2RNQGX/BfoO/zmFXJrdwES4HQVAAQ4uJVES9Rozn7q+F5cHFZt81tShZPFPnrnK85pX8z6N/48jzs+LBVi6AolA4UFuJhQraRjfZGs8C77dH+NInB3GHF/aJYuxIcj5/AmmiEVGOhGJoSjJcumLD9jXl1/ibRxLsyoud6uE4RGpQB884s93KvlNvwowpV6In4jjIp0OeE2z1JCaoT+lzQ0MwctbhAzi+o+roSbF0RO0dAS67tQ9WArCjMv8Gbp+NemhW/kgfQqfIIg1wYPzpOaWtfb/OLh+8TAkGjA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(10070799003)(7416014)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUdHM08vZmhYd1AreExJcU83UnFET1pDcldxQmZpLzBtVGJPMzR3VHJzY1N1?=
 =?utf-8?B?aHVrdmdIVXBFVW1uUzN0NlMraFBrSllYYkczNkxjTVhzaGdJTHFtdHFkeFpG?=
 =?utf-8?B?TWxHNXlGRnBvMlFPODVaR2ZtM05nWjE0c2xiNFhoYkIzQzFYV1hnU3FzSXo3?=
 =?utf-8?B?S1hlT2Vqc1U5aGZ1TzdCOWFTbG13dmpGaURnR1hvV3kzbDdhVEdnTXV0cTFD?=
 =?utf-8?B?ZmFPMEp1REhEaUIzcm5GWGlhUW9HdkJQOW9UcHZVdzZGZ0pjME5jWjYrZlVN?=
 =?utf-8?B?TWtrYlAvUkxGZll5TWRObWUzK0pRQWtyOWxtNCtPeEdFc0FtL3FYSlZ1S0Nx?=
 =?utf-8?B?N0FxTHMzRlFBNitrdlVvTnVoYW5wSkgyKzRIcDVxQVIrcjFEcXp0SnJHbldL?=
 =?utf-8?B?aHhCeWZISGpIRitmOHVTMzRUZjJaT1BldFpHdncyV3ZoUElGd3BwTW1xZVo4?=
 =?utf-8?B?dVVoYjdia1orU1dpeHZJa05maWZGRkxlMTByRzhTZjZEQ0J6aXBUaHNtNUxr?=
 =?utf-8?B?RWwrL0VjeklBSG1QUEY4UTVNWUN0dnY3ZGkrNldTTEZJVjRpWW9tYkE5RG1h?=
 =?utf-8?B?eHFvVnUxQ0FhdzVPM3Y0RDZqbHJ6WWVCR3RZbVZIWmpybXRqT3lFWjdpSWFa?=
 =?utf-8?B?TUQ2bzRiM2ZnTUZ4ODF0c3Nxbm1mblBjcklobVoyUzRDUHc3dm4vNklwK1ZN?=
 =?utf-8?B?L2RmMG8xZDk1SFFnUDk0VHh5M3lRa29SOUhzL2ovaVZBV3kvakdJTEpnUFJC?=
 =?utf-8?B?b0lIenliMXpkeDhjY0hRa0c2bHNpdmRaQ25YWHJtL01JWXhZbE0xVzRUdEQw?=
 =?utf-8?B?L2tjOHdTb0JmV3J1WkkwdkNBbW92TFVPUXN0UVRUdWVqZWFwRWFtVEhJUzB3?=
 =?utf-8?B?OFpCZW13bjFWei9oSGJxSXgvRXdXOFlWeVpKOTVYVlhvUExkRW9OcFdWTzQx?=
 =?utf-8?B?QnI0aUM5eVMzbTlDZUZkTmYrczNrRHJnekJXcE9qWU0xRVpWQWt5SStvWUdx?=
 =?utf-8?B?SDJPQXFXUmpxSzh6RDdmU2EzbW93cWJoQXQvRHI1bW91eU1Mem1IVFd6dTdQ?=
 =?utf-8?B?Y20ySFI3TTkyZS9BT0ljclk0cENHZFVtSFgyejZhQktEdnNRMlVMdlI4K0xr?=
 =?utf-8?B?c1JzOFlHU0FFbGo1SnBWdkJ0bXR2YUgwNkZETExBaytNa1NpbmRzeEY5ODBi?=
 =?utf-8?B?Q0RNbnRzS0RuUmY4ek5TQ1ozd0IrWXpTVGthaXNnUmp1VnJjQ0dOQk1CVlFv?=
 =?utf-8?B?RmlvYVpBcjdyS1VOWUdrbW5DZllEOWFIZE5nVzM3ZFp6amE1MWtqV21HL0p6?=
 =?utf-8?B?cVFZSzB1TTFrSW05NlVqWlVFTW1NQmxaaHB6Y0dqVU9XVHJUUURabHFSYkxL?=
 =?utf-8?B?NDY1TzdTbkRtaUs2KzRJclEyZVplTysrbE9pT3A3RFhXRnB0YXFUY1lQV0Q1?=
 =?utf-8?B?VWpQQmN6TlR3cEtDZTlmODZFMHhnd0puSGhYZE5KSm02Qk5pRlVIUGZnd1pS?=
 =?utf-8?B?T2Z5WDFqYUJyYkhvMS9TK2t2bFNNTG9BZjBjMnFoN0tyaENaQnhzTDJrN3Iw?=
 =?utf-8?B?WW1zSllXZVdkNEtqNjBTTTZyNzNqMkU2aFlJbEN3SkNYaWVuaXYxUnJOSHZ1?=
 =?utf-8?B?UXlYeGVKbkkvQjFNa0JMbkMyQThTcm9BQy9mVWFmRjI1MFZhSWo4NG94UHdW?=
 =?utf-8?B?aXI5OForQkFEc3MwaXo2akpyL1dTOHpNaW8ybVB4U21FRDdZWDVuZm81ZFR0?=
 =?utf-8?B?MTBub056dVRYeWRiQmJBZktVdlRKMTJINlhMWmxYTGh0djBaU3dQL01PU0h1?=
 =?utf-8?B?UkJoWGd2cUIzbC9HM0FNRldOSUI5a3VBRWorUnJFbExDeGNwUU42K1Zrbzlo?=
 =?utf-8?B?SS9DaFhwaVdrd3VoTjc0SERFbm4rcllHeG1EenVYMnhaUWpPNy8rZllBTWgr?=
 =?utf-8?B?ZHZ6OWI2cWg0eUl4RTRWNk1kYitKd0tGL1crNG9IR0hrNU5pQjZZdVBHN0Ra?=
 =?utf-8?B?cGVrUG4rbUJjRG0wYVlIcDQ0QXBwY09wQW1TY0pWM3ZhMEJxUlZpU0MvYmds?=
 =?utf-8?B?NlpJZ0xyTk9xcDBPL2dYVnZjazRrNUVubW90aENOM2o0R0lMdHJ1K0dxVkxm?=
 =?utf-8?B?aWZidm80Z0FqZGFFVmtSNnYvQ2pDNW1XcUJPYXlOUTFwa0I2QXpabitTOW1X?=
 =?utf-8?B?c2RvTFRLdjNFWXRUanQ5WUxvUFkzODUyT3pOV0FPWHVub0prTVhTUGkyL3N6?=
 =?utf-8?B?b0FuSndWeExpcnVMV3ZBZXloNXkvVzRvMHIranpkT1MzVEhrdDl4N0xsQTFM?=
 =?utf-8?B?Y3RxNDd0ZW94TFVhaUtja2NibTdHZDNscTlMdldxVmRXd2RvZ3Z0ZU1vcVZu?=
 =?utf-8?Q?SLxkUR9i2IinJdIQPYpREj0KsIvrrqy/O7bO2CJ7Ae16u?=
X-MS-Exchange-AntiSpam-MessageData-1: 4dli0UqLeU9dZQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd427fc1-eda5-4e41-a822-08df042d40a7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 11:20:51.6732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVqIUPDrmTt0/F7OJgmtM68QPsdKF38RklLOM6oXlO3H4fooVIJt//FCOACbszLWMn1gvh9cZPRworFDExi9jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> All registers use the same base type, which is `<Bar0 as IO>::Target`. Th=
us
> add the base parameter to `register!` invocation.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
