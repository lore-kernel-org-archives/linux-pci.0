Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6739F181;
	Tue, 21 Apr 2026 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761904; cv=fail; b=KGkPZzBVmISGDTHei8i1HdDrUweDQ6cVSvqoi3IjDar4Hpyz5m69oQYy0sLwGlDuSlo+gbYlC16hXstt/ckI5zot+9+VaXMo2C9X5YFGvzi3ZqD75Q9Sw/DwFSHctJ/lByPKRhnW3gE2z0G7BiVSTduizLxnqVopkDmDu6d9zNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761904; c=relaxed/simple;
	bh=WxUg95YEhw8xbBafM9mY9hVSCPdJPZB/GKY/muNtSSI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=qtwcXhpFiIAlW+UP8/nUR/045wEgtSWtRUTTBX6SBaBxTvQQ3ihhMBlYVuD9qPyvXgGejiXDewUQREHwVEe0W/yFBtdVv1EInbDHrZvhEvJ+J+3tXtPt1ST5NSzewbcwOU9Gpw2OJ3eAVKduPkwJeUxtalPsxzLwSDDQdEgAfaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NA38O3VR; arc=fail smtp.client-ip=52.101.56.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NA38O3VR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czvuJrSDJKKkX9BttEQruWF3pvseVgcYw+eDOqW0QRKyi5NY3EYgpRje9OeM4VIhU9dk+GxxG4GFwaknoNm1dYR3z8U/oujKg6ClX0Z206w16tbvUcLmNMjRCNCVBNqHOg7URIJKCuZyd040pnXSXsVlycHza0Q6NVfUeejc7OJKc+bf2h93o/Mz3VX18LvcLKACt1F36t1ZJ4PUJj6HApEwoU3qt6HYEiYQvTrMf2pKAS/u7on8Ex56tQ4FjZKp1/N26cP4jG3gdzWrLndqbd4M6mvyoQqTqayW5tOVXybnHgDJYP68cuzQ8hDVOe51QXNNYiJasQAQBlBV7vjuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxUg95YEhw8xbBafM9mY9hVSCPdJPZB/GKY/muNtSSI=;
 b=LWRC9ycSMu4FayRRFBKwsJna8Ax1vfMeeW86+z/t1le9liO5pGmuxVw2E6PVoTktImD0+VxckK6yQSDko6A+9De5xI3/ep9MkbgKIKPJim+YYjnFd/Q8QsW5LnP4zOd6P4nH3Cn9Hn3Ke8q5in0EfrMgFNQ56CWqoYKyNsftKw7L4oLsR3OYSj4HknDIKctN+uAFEei+KLjTba72p3l86pkd2WoXudkwxQmw3+OlMqLBZL39KO1FVcbyPQwBsauDb3YgtRoHKbw0pzYgqk5VTIwdKlNVc6wGBY4WPPO0RjCzTraBh8nNF4S/rZWoXIz5SvDYzEMGBQgNw1FWTLBerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxUg95YEhw8xbBafM9mY9hVSCPdJPZB/GKY/muNtSSI=;
 b=NA38O3VRYu8Q+H/MF5XOlLpZs1/EdpbnX1NbSmzvoIqN8rK62s0A+rZY9IT+sHgIg0LM2f8vbApiXbqWAa69l8oBFaAmcD7IdzvQz8W8z6K9s3wQSb5ejO1kFQocP9u7l8fttNyzOLPFj6lqLqtrBCYfK9mh90753u8+uDyIfbjcsFrt3ZHondNpdDOwEXJTdz/wP9ir16QsZFlTfmLvWFv36MHKaszfAEbvWS8DAho/vgWo5ABNJO5BGrtAO/KU+YwI5rSPaxphdgMHCkcIUd22/VqZueNUhTm+K9cyMOvQZsTNCzCSSqJQ/bdhfIfOL0dAWMKs3PU5hZO6i8N6qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:58:16 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:58:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 17:58:12 +0900
Message-Id: <DHYPIX2YKU3B.25VE07KIO3TLR@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] gpu: nova-core: do not import firmware commands
 into GSP command module
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Boqun Feng" <boqun@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
 <20260421-nova-unload-v2-3-2fe54963af8b@nvidia.com>
In-Reply-To: <20260421-nova-unload-v2-3-2fe54963af8b@nvidia.com>
X-ClientProxiedBy: TY4P286CA0049.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bcfa981-86a1-4a25-b94d-08de9f84203b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|18002099003|22082099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info:
	8zO/sWtI41nUR97QjPkbAIuz0TAigxRafAQKhqIoVaRkQb9Bh49K6oIr5jCJG/pxwDLE4Cfv8WJtcKPmce+nZ8yblCAzm9Ggq1xkDIY1KR58nlYUx593NrRSllcWqocKZzVW+Rm/AFVs/g6xdZZXl7zfvx5uQYskrvaiZ1CoE5Nev8GxZhNz99aV+69Yo4Y70VaBT+dahosB813CxRBaXJFV28VP80zwXfkOyzbVqKq4iz8otfC8C5RwLFJjqbburreP82nXWCV/jj5PCEC5p7bTjPcWRK/t/dqXGOlnq1j6XLBkohSQ4+6JVuJfbR/YBpnb5qBASBsx92BeBsrRbEiXHrziqoujV3LZGYtcoIgnkGiztqmBFVbLDCOiMgX+uNF5v9mpBeDkE7OxKixqRYMo+wk5XYu/GTGGH03yl8wQqVjdYyL/AzKRrVta9vaPgXDtlEuYQCtsZkQVKrcxORb46ut0wvsovfLuPaMhDtJPDYT2X6kFXL7spN2VX41cvP0qnmfTNfYjK0YQWWGde7jIWNBpjeIsFKG25715CIHQ56Yt+bhJ/hqTVkkG6YFgNu77R09PWXle+mmBEZzyrSENeNnReMjHLDBeALBW8fc5UXy+gLie99awgdkqLI6cZgB2ZcU4cs9WDVt3Rr/byylvQXSdPU9dXR8Apl5HHJxvWlzMwPzfPVT887OlUzExO/8eNzDap2lBKW03S9CM6DAFWWln+kjB51tOPqpyXnp444A9q2C7Ikj6u7jOIq4DOBZMkcyycfCo3EkqV43OTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(18002099003)(22082099003)(921020)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHo1c24zSExQOTJHaFhwRE14ZnkwUW1KYXNHeUdiVUFOVU5sdTdyOE9LbW5h?=
 =?utf-8?B?S0JMTmplVUc1TE1jQUdvNU1qYmRmUUNpZXFBODc3akFIR1kzTWgrTEV0NEtz?=
 =?utf-8?B?b0tLbENBemhha0FYVEpDZXZGekRUSjIxbmw1dkFNaHhLUHFlVDBoNlVUZE9M?=
 =?utf-8?B?MEtQRklBNTVXS1JnWXQ4b0NCUmxOT2ZTNHpRVm9HZmNxRHZtQ3drZ05jMlVi?=
 =?utf-8?B?WjBIUE9wNFRtK1lWSjVIakw0T05wbHpCWWViQXZUaEZmZ2VGZDJQSnNCbXZa?=
 =?utf-8?B?NzZYRkNBYnc1bGNCYVk3ZUwyNkxOS1pWSEw1L2NyZG1qWWRralAyZWdyM0VS?=
 =?utf-8?B?M285b2FwdU9YUUI3VGtHSFc5dnIzbDF0VUdvUFRBbktKbDR2ZVFrdENXanBt?=
 =?utf-8?B?aTcxdU9pN0h5WHZzb2VjaW02MVVGV2Vnbkg4NGJXRzlJTVo2UlA2clNNdWxi?=
 =?utf-8?B?NXVDNzliRHBKdUhLbVUrV3Brclp3Rmc5S1E0ME5YU0IzY09hcHVuTjhjZklQ?=
 =?utf-8?B?aWhqRUc3cWxrMUtnVE8rMHNJUjhzbWlmT1IvcW90SUw3dTA3dWgvWUlNdVJi?=
 =?utf-8?B?eE5OZ1JXSDd0bkdDbDg3TVE1VDBSSHl5UmlSNzNTcDBFbTNGa0tyY2luTU1Z?=
 =?utf-8?B?SVRBcEQ5YTBMOE9PaStZUDlvUDhPaXoxaURpVFFCK1laa3MyMnhJNHFoTlVT?=
 =?utf-8?B?NGRUUExwY2lqUVc0ZUhnTExVTThWdUltQTFoT0JzaEdFUXRhOWZoVWc4Ly9K?=
 =?utf-8?B?bkY5K25ueHJnamd3MlpDZGNuK2V4N0RFQUpCYlI0WkhJL1QzSUpyc3JSd0xB?=
 =?utf-8?B?RmEzNlNzTitzU09vcUFlemdpc2hIbTBsSFVtWlIrK2NGdTlVbWdqM1pMeDdU?=
 =?utf-8?B?OGg4QkwwZ2c1QVlZT3QwcmpFdytMeDhmSUhtNG4xSTQ4VlJBRGprSk5GQm1C?=
 =?utf-8?B?ZnVWbHlWdkNwNUFPU040bXlsMGsvWU5VOHdJeUJVMHFjcUp1a1FMOWg4cWZm?=
 =?utf-8?B?c1RScjBmOGM4UjZvWDBzcXlIcjRJNE82N3dQc1EyNG1UNVFuVTdvS2l6K3I1?=
 =?utf-8?B?K0tJekpiaFRlNzJ3OHBGcFBYTVREMmhhcFdOOElDRTdjbHJjNFR3OVRYc08v?=
 =?utf-8?B?aTRBOUUyZ3lENzMwUVV6Yy9jRW15ZEliQnFTbXlpQUpmaEZLY245QndERGlQ?=
 =?utf-8?B?S2pUc1RpZmdDSlplV25EaHNSeENoaUtCaE1OS1lRMVpkV1lMcGF4NldZRyth?=
 =?utf-8?B?TFVPNFpRNzdNMkN2QXhMZUpGaldtVWVkN0dEQ2tjVFovN2krVjB3UVVlbTl3?=
 =?utf-8?B?ZCtwaWJjWU9sVDEzb2huc21pUkdGK09Wc0k1Vll0cFdTOCtNYU15T29PVUh2?=
 =?utf-8?B?bWpITTR5SWVSdDFLQ2d1dXBuZGlGaWVhY1VzcFBwWlJ3L0FZSFA5R1hLeDJI?=
 =?utf-8?B?OE5zM3RGUUwxR2IyeGZmTGVLeFczTGF4dHFCOCtCaU9EZFZqanYrOTl2Q3pq?=
 =?utf-8?B?SG1uK3RJdExHR0NDczJXb3NlR1ZXVkJKd3dkYjViZkljZFlaUEQrdkRhYlk4?=
 =?utf-8?B?eVYveUhyYWdFQ3o5SUZJUTYyNlcra1ByTzZhV2RSV3ZoYnFiUjA0SXl0UVZV?=
 =?utf-8?B?bzZraE93aXozRnZxUTE2YXB1Z0IyUDhVNVQ2UTdSNVVzYlkzWUhHSlp5amdp?=
 =?utf-8?B?bk4vcndzWmhpVWVkQkV0a2Q5T05ZeVJLMHc0dWJRWFJiL2NTcTRqU1pYNzBl?=
 =?utf-8?B?M2habU9hRzdtMTlQWWt0MEpOdis1cHZWUUlxR3NBR3lkVkNhUklQdjFzczd0?=
 =?utf-8?B?N3pRN2NYRUY4RzRwTElkczJYTFlCTlc0SHF3aE5YenBhUXdNSDJONWE4aFli?=
 =?utf-8?B?bTZ6RjcyLzVvRERNNlZvQy9FREpaWUFLdGFSbmJ3cElZZ2RBTzVzQkExVTBw?=
 =?utf-8?B?TTdadFJVNlBzOXlSTnJYdlp2VTY1UEo0LzhNKzNWYmpkc3o1V1ZjQTBZUDkx?=
 =?utf-8?B?MVFueG9nbnN2cGVDQ2RLSk9vckRWRGloTWpFK0ZQZ2JoeGc1cVlTTWZDbHZD?=
 =?utf-8?B?VWw3bUdvZEdrVE5CTkswTEE5bXd3Y3RNWXFPU0dxV2s5RTNOdUpBZWN5Lzcz?=
 =?utf-8?B?US9tMTBSWEx2V2c5dDIxeGF0YlEzYkNBZmgxNGIwOEdQb0I0WjlGc25GVndp?=
 =?utf-8?B?OC80MnZLWkRzSE8wSmZpaVc2cjM5cUU3K3NvQW5oMDh3dWorbHNjaGM1S3A5?=
 =?utf-8?B?KzBVdW5QMWFhdDB0cE5WTnU5RGY3S1FKWlBrZDE3OWRIN1NmdnkrVXZISG82?=
 =?utf-8?B?R2dmeUQvbWxmU1dYS2VhUFBRMDVNVkhHZ3d4R2lySHgzZFdDY0FXSWI2VzhF?=
 =?utf-8?Q?Byq0v0B/d5XOMZDRq1k8shwQzd65hCNV/gRVEIYzXhbqM?=
X-MS-Exchange-AntiSpam-MessageData-1: hkEHAwqj2o7Yuw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcfa981-86a1-4a25-b94d-08de9f84203b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:58:15.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktx9RbqoYuw68ba8/ggd6D6Q9Sj8M1pPQx7DZMCqwju01S+19yybF4giUErp1Qow7ncQ/Pj8JE/4AnRq4UDCkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059

On Tue Apr 21, 2026 at 3:16 PM JST, Alexandre Courbot wrote:
> Importing all the firmware commands like we did is a bit confusing, as
> the layer of a command type (fw or GSP) cannot be inferred from looking
> at its name alone. Furthermore it makes it impossible to create commands
> that have the same name as their firmware command.
>
> Thus, stop importing all commands and refer to them from the `fw` module
> instead.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

