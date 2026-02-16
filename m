Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013033.outbound.protection.outlook.com [40.93.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647262BE64F;
	Mon, 16 Feb 2026 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215958; cv=fail; b=LXvAX6Heqt0qVXZdYOZifyY/zilUuaskx2kn249hEuHAHQoX+OxinaT4snglE8yBUPA8lyGYqFdqSXD2HRxN5gZ+9hn8Seo+B3vYl2EaL9NRvlJLytwA8p8UC248wX9dZfituaDmNDHn8qose8w7o5LASyOnIG9BiQ9P37vDgI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215958; c=relaxed/simple;
	bh=TYFxmTgYK3ymeNxBYELqNBKMFaFnpJcoIlppXRg1JQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OzNvI3pEEm3GQoHv8vRuh5xeMT0u2ivPWNXMssqFLmCKi84vA6UpstmCBMHuqZdOXeMPo9GsIuSxS9GbSxtC6MPikAmVlxPsGWG552bBUQvpx1AU0uWR3zy+bHhMX72V3bmYzioW/SDM3rH6m9c0e7Fa/ilUgdQuQ5OalHiwV9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n4M8VD0c; arc=fail smtp.client-ip=40.93.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n4M8VD0c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2Yle3XBOV3+WgQDus8fB304uDH3oP8a5GpK/L34NFquDyQX1tlPybdLTNNDSUhp31XxnVauvMJe9wut3seLk8My+WIRMee4YPuxwzGmu3t8y1kyXlRiUDBFa/tsYidwCuQw/X1yQTSkRR23mdRpCBlpsrU5P9RBLJhCRNTmwdE0fpydsBn72lkkvJXrJcVXiyqjUmXg4PHb62kVQKFUATdfqfsDbTbXxd85hfYI/IF0RtQcTZsqAJYTNFZNDqydQpb/2HocEhpDt1AdG/EFzD5JqBdxqHoyKCXPB0F/LwdHN0a+nVevOG2IjBMmwhgb9kME4fSWFj+z05biSW4L9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+byv9gV83vkY/xP94L3YxQ5vScBKvS1Xz2a9Bp33sxc=;
 b=Xw1WMz0E2yoik9UKF/m/CK4AFq6q/wcln9xqW6mI0PCVZ0q/DWmKRtiZ63gQVL+5Y4L+tfZT1y/0MbP8UzWEW7Yo/hM/O/cDysAcIHDPz9QwzwAoLZKV5irq07NxP5od9BnTA5Vv8tyYkjhvuT6YjaeMqguUFsbNHam3PAmli35WvjuKyR9FRHMe7rlbxOObLJTotm8i0x17LUt2aFhI4V/e/FU2ruJU9463CDHsEJ0quWjuqBQQWegSC7gmwbVNkhC8x5sVy3QPBkKEH0VNy+2KdrniuDrUUeHJYNgbxx+bwuq4pnvtKuhQRVfxeHN9Ngiiyny98iY/1sb0ZMhWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=google.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+byv9gV83vkY/xP94L3YxQ5vScBKvS1Xz2a9Bp33sxc=;
 b=n4M8VD0cfwiZ9x3GwvAB9A7BYw8m30qhRZV8SJCOviuvGsDRJiraD1yUcKu1Bx0VwrZ2kmwANCeUmYkE0iVOxQp5IQROMo6Ss7ThtsO+agtkogWTD0ov6AgZCLEnreIJmPQBKyR/mkevOT71HFtHeGQMLyq7U1PSA5/9m/le/b4=
Received: from CY5PR15CA0116.namprd15.prod.outlook.com (2603:10b6:930:68::26)
 by PH7PR10MB6177.namprd10.prod.outlook.com (2603:10b6:510:1f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:25:53 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::12) by CY5PR15CA0116.outlook.office365.com
 (2603:10b6:930:68::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:25:53 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 22:25:53 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 22:25:52 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 15 Feb 2026 22:25:52 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61G4Pluk692682;
	Sun, 15 Feb 2026 22:25:48 -0600
Message-ID: <b709a037-f9be-48c9-936d-22b9fcefc112@ti.com>
Date: Mon, 16 Feb 2026 09:55:47 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 09/27] PCI/CMA: Authenticate devices on enumeration
To: <alistair23@gmail.com>, <bhelgaas@google.com>, <lukas@wunner.de>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <alex.gaynor@gmail.com>, <benno.lossin@proton.me>, <boqun.feng@gmail.com>,
	<a.hindborg@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<tmgross@umich.edu>, <ojeda@kernel.org>, <wilfred.mallawa@wdc.com>,
	<aliceryhl@google.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-10-alistair.francis@wdc.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260211032935.2705841-10-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|PH7PR10MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 079a1c50-e9bd-421f-5737-08de6d137915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUZTT1RGRk5EazF6TDRVajhMdGlETXZsTWtJVjRjcERpVVdmN2dmTXZsallB?=
 =?utf-8?B?MkEreTVqTjk1amFGdHdHQk5PUlJCbVgwc0lFMHMwMWRkTktUK1BPZ0ZYcTd6?=
 =?utf-8?B?aW1YQnp2cmVwcXg5RG1XeXpPOUw4ckR1NzVkY1JBY3Z4cFQ3bzlGaWthWDd1?=
 =?utf-8?B?RmVkUWhmdGRYVUZuUDBQVy9yQmtxVlIrcjBTMjVaZ2VDSE15elFOMS9WcWY3?=
 =?utf-8?B?c1NTQm1jd0VqMFJEd0tIUXFNb0xsTHhuOVFNMUcrZ2pjVXl2eXk1ZmJMbDdz?=
 =?utf-8?B?Rnp3c1hkWUlOMjVnZjJIZXkvVkxQZ1p4SllCUDAydXpWUnArc3F6ZmRWakJn?=
 =?utf-8?B?OU8yTjM5aThDbFplL2hiRXZudjJpUG9rc0xuNHpManZBUGVMWVA4K1JNK0pS?=
 =?utf-8?B?ZU5LMWhrWllQNzEvSWtuRzRSL295SWo2cDNJUndMdnlIcU1hMlRlYjFTMStB?=
 =?utf-8?B?L1kxcXhPUG5tSlJpQy9PRUxydllBcW5Uc2JoQm13T012NFZqVlFWM0RBeTJy?=
 =?utf-8?B?d0tsMlJYek9tN0NGeldzaDF4NG1pSE14czRLdWVMbjZud1d3NEJta283WUR0?=
 =?utf-8?B?Z2pNdzJBNmZEZlMrM0dUUTFqaHVTUDZvekI1YTZDTW1peXcwcU5HN2dmV3kw?=
 =?utf-8?B?VEVBRDdBOFh3dndYN1NCQW13SGt5ZXFGUXdvLyt3Y1NMTTQxT01rMzlWdThu?=
 =?utf-8?B?NmxQRUdKcnJVWTI4V0NnZXBqQjJGNEk4c1h2ektLQUVnN2JnbUtKaGRNZHpa?=
 =?utf-8?B?UjByUFhvQ1VDNWxFbnJ3My8rVmx5MnB1MDNwUEVlN1F2bTdZMmd3QUxQWjJF?=
 =?utf-8?B?cHY3QmFMSlQ5c09jZlU3ZEV1UXVHYXBKYUhiLzRzK0s1a21wZ2xCSG5zbTFj?=
 =?utf-8?B?QituQlp0ckNwSVVueU1lUHBKZFlsM0Fka1NXNDBvTWhDV1NORFluSHd4Yk9k?=
 =?utf-8?B?ZzlKMVpDRHBZbUkrSDBqMEtJVlo3U0szdE1qU0lYeENZUXg3OGthNU1YQlk3?=
 =?utf-8?B?YnN1UjNWbENRQWpLdU1QeHlBNDJGbFRZM2d4V3JxSm0vZTB1WlNMczgwQjdR?=
 =?utf-8?B?V3Z1UXl3ZnptU3RNV240Tkt4UCtpNUFNa2tjY1Z3Y0sreFdISUh1MUdkdjg0?=
 =?utf-8?B?NVhYWC9tdWhXR0JTRitmdC90TGVsWjdVaC95Zm0vbGlTVUNKdFhiMm11bzNV?=
 =?utf-8?B?YmNvajNEVURDeVVtb1o3WHZqd1hOcjlaYXF1QmNINkIxNzBGd3JPUVlmYmQr?=
 =?utf-8?B?RnBjQXVMOFQ4bFNmeFIvdCt4d1VDa0VGNWVZamRiaS8xak5iekRGamJja0kz?=
 =?utf-8?B?R0JhRW5MbkZMNlduNzh3UUxMVzVYOEtyejVNdWxqdm13WTg5YjAwbUpVd2Ra?=
 =?utf-8?B?TXZkM1VMbUhndmR0b1ZqSWFIYWdZQ2xMaHBYUVRWdXBQMC80VjE3ZUFXc0xr?=
 =?utf-8?B?Znkvdm5ZcjlUQVB2VTFRYllhRldGVHgvZ2hDUXFTVXFsc1dqZFU2ZU5PaTRX?=
 =?utf-8?B?V1l2OS85OG5QZ2RWZ2xKOXF2VGVxK2lYcFNqb2FHeFlwWWl1TFk5ZG9DMmgy?=
 =?utf-8?B?TWlZYkczL2h3b1F6cE94WEdHRHVydVo4U3h4M1BURHI4YmdvdXNJMGhTaGY4?=
 =?utf-8?B?WWY1Z3ZvalNETFVWQmxETGxXRTJBRjg2RXQ2TnZhemJDSU1mYUlXaDhuaHIx?=
 =?utf-8?B?Ulg0Z2VBeEw2ZEJNWG5qQ01CY2YvRnNBZUpUcDV1YjVXYUE5cEI5dHA0U2Vs?=
 =?utf-8?B?UkZqVnVBcjBPUjljU0dmZDB2KzJXdmMydVJIU2dMcnJBUDl1TWozTnpCT05C?=
 =?utf-8?B?Znh5Ulh6VDQyajFnOUlxbTZNaHZiUERSZ2JGV0lyVEpXOXE4bStIaVJDbjJk?=
 =?utf-8?B?N3Q5VDlRQXhLQnpxMFFBcEhmTlM4S2Rva2ZWdEhoLzVnMkFuZkczSkQyQW0y?=
 =?utf-8?B?blg0U2VScXB0N1h3eVlscS9MQUNOWHBXcEJKRFRTNXZrZmp1Z0FIWUN5aTkz?=
 =?utf-8?B?VHRQQkVvTzRGTmxEUm91SzNNZ0RScUpiK1h5MVNiTUltZTN3RUNUb3dldDBy?=
 =?utf-8?B?RXlSdHlBOFNhY3c0T1RaZ25YWXZ3NkFtc1kvK1N0N1ZRWWRySyt3SzlwOWg1?=
 =?utf-8?B?NHFrcjcremVkY1Eyd3FkQUtuQ0QvbjVDZnJ1eGtKU09rUDJSWk9qWjRhbHJz?=
 =?utf-8?B?bVNuSkhHdkw4ZC9Xc1o0QUNSVFd1ZTlYbEpXTnpUaVpSaDJVR3VTK1l0bitR?=
 =?utf-8?B?WnIyNm1UU0FoOVIvQXZ2WHh5L1BnPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sShtFTqSmmiVDkP4y/FrPFkZ61AulEQr2S/E46Pmk5T/ARHCwwZq/qz+kIKRrjkGOrTHLLDCvMWHmMWbGgD0SrnuXWCijtD8eSMEitDHFCIubTAb2U881dVU6o1FWOvpdujmaNyYQabFICNHvcHrz09ncJjJFftke9FgY+tQreMS4QlOuWvYTsviFq5vnNqL4jqklfVoSZSqz3pFcmHQL1S11bj3rP1Wi5KqpDWrQNc/TifFbloV+vgzyWseVP6ZcisrB8iT5IfagzbZd03wfUHR0sUEaMp9GlPos+kKOwRDDzynBA3BVEMg8et9vo6fcizNfWLVtsqyy9udrD4+lM5GlyWsDtuBeDBCESnbgwuZkJbfdUftoKZFeUyXWubwv57k1opSDT9eQnmJkiNBX79Oad6XMKOmxVHlr3jbVTbM6uBU6+VRvqfEQ6h0ulnf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:25:53.5601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 079a1c50-e9bd-421f-5737-08de6d137915
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6177

On 11/02/26 08:59, alistair23@gmail.com wrote:
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index e3f848ffb52a..7ea403799d78 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -125,6 +125,22 @@ config PCI_ATS
>   config PCI_IDE
>   	bool
>   
> +config PCI_CMA
> +	bool "Component Measurement and Authentication (CMA-SPDM)"
> +	select CRYPTO_ECDSA
> +	select CRYPTO_RSA
> +	select CRYPTO_SHA256
> +	select CRYPTO_SHA512
> +	select PCI_DOE
> +	select RSPDM
> +	help
> +	  Authenticate devices on enumeration per PCIe r6.2 sec 6.31.
> +	  A PCI DOE mailbox is used as transport for DMTF SPDM based
> +	  authentication, measurement and secure channel establishment.
> +
> +config PCI_DOE
> +	bool
> +

config PCI_DOE is already in this Kconfig file just below config PCI_TSM

>   config PCI_TSM
>   	bool "PCI TSM: Device security protocol support"
>   	select PCI_IDE
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index e10cfe5a280b..f026f5dbb938 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -40,6 +40,8 @@ obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>   obj-$(CONFIG_PCI_NPEM)		+= npem.o
>   obj-$(CONFIG_PCIE_TPH)		+= tph.o
>   
> +obj-$(CONFIG_PCI_CMA)		+= cma.o
> +
>   # Endpoint library must be initialized before its users
>   obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>   
> diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
> new file mode 100644
> index 000000000000..7463cd1179f0
> --- /dev/null
> +++ b/drivers/pci/cma.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Component Measurement and Authentication (CMA-SPDM, PCIe r6.2 sec 6.31)
> + *
> + * Copyright (C) 2021 Huawei
> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + *
> + * Copyright (C) 2022-24 Intel Corporation
> + */
> +
> +#define dev_fmt(fmt) "CMA: " fmt
> +
> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/spdm.h>
> +
> +#include "pci.h"
> +
> +/* Keyring that userspace can poke certs into */
> +static struct key *pci_cma_keyring;
> +
> +#define PCI_DOE_FEATURE_CMA 1

This macro is already present in <linux/pci-doe.h>, which have been
included in this file.

Regards,
Aksh Garg

