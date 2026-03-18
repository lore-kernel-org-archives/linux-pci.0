Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013026.outbound.protection.outlook.com [40.107.159.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496803D75A5;
	Wed, 18 Mar 2026 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773838743; cv=fail; b=od6hiEZzuBIZ+X5lypoDBME1SKaLQgq85fCbVvY4yycVCFqjnp//aqa8gNZJIfUF7ewNTnZ5Uosq0nW3k0FWaI9Mr4rhdwO5epwidX4gjgLtsLdy604zCxeINTVFN1vtwJBSe8DjwpcRdyrSEO4ufVg+HMNKIww9WQHTEtJGe0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773838743; c=relaxed/simple;
	bh=5AQT6yJHge7g7GGXgDpiYxWRLaCyXttrOrRiLXO5dok=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OVaONF0kgrgHm4I2BpMQQrp82gzttt4wZZuHccXQbWB3arUvx6pU7p/lVS+BZxt+cPK34pLNRJr5tN7lky9w0UEPxHbV7OrqfdlSwsyqnME+ZxXjzH59BS+2E/3c96mjrNxxOjTVkfN/oFoHtj7Xe0OtXF15K7f+zt1MNME7MOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=AM0pdTz2; arc=fail smtp.client-ip=40.107.159.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="AM0pdTz2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZ+/X/DuAPradiPAgwyV6LpoFsttt9R7/5RQ7JiciU38C5/Kjzm+u06dLBS/cKWMEsXlX0bG7qB9Kox/wcIMraSPKZAicIm3rweUiHBW7aX9L0Z748kv+s1IY2cHmwtJ+VcUENhomsQt3a4yRyOmSrdL9QaiAE5h/meEXEYIeDyWhS/SvibzEqDMwUzPJ0HTFXGkIVVUU+fr6LTqBOXi/bW1/bLGPUSyLsB+CBSwg5ObHius/YpNUmONaGX7fiI3SsOW7aMDIQ3FV1rEpOTxy8oQj7G4dthtv5g17ZbpZmNuANiL6Ool0MWhqkVtYdqyEaLyr8ls8xqoXiVuy9VD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdx24VLHRWIq/5EPsgIuaMsfSoy0g1fZ3FWr0Y1z6gU=;
 b=nSU7zTxHyQZ5QK6xz8DxuU8PPar6Pvp00f38uB9EXfp7vgBFDQnPa47hDwYP1yliIiFtlLDPx97yifNVGU6jKU2JEN0qzHQiu6H1C7XXqIRYcv0pE8Lkkf4BJA3DRzeCRE+ZJSmTeH/YvOHKqICTP6tf6Xz3sRQoH4fk6Dpk8uWwrGqjn0Dj6vdNPXKzFXL8BQEAAReyPOH4iRJPJ8YpG/Ky6ac9fBjYS5ugE0SuNE0XRV0gtjWVHgnhri9MDEJ6iZqM9zFQRRtZvSp2mSfKMLIuNqPjdCMmKptgAKTl3g0dVQzfaYNQzSJwhudhyXC78AYOB3ReMZaEHWo3DgGb4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdx24VLHRWIq/5EPsgIuaMsfSoy0g1fZ3FWr0Y1z6gU=;
 b=AM0pdTz2fO5VzsdAvLowE7kTtIa7d+yJ+iFxAh7DpFPp2EvZcnUsaT2owkyA/LOeu5epCgyARoSnHROJrsquJHmTNddHD8z3htUv3A8ak7SQpIHZnf8RPYqR/0cxFjjPne/XoeVmmu6YMSdPEOuvoF9iUr+nnDShE5A9pPdCWydCPkBImal0uPSZ3Db+ECW7DZe8Hs09+KxAOwRjh6tHATXU+6JD+PQJygTS/9oL4FcUggGW9ohHZQ9PQui2VScFgdzTxHixFT8IlMGb0zHjJvM2aqtqfe1HeuCgoApAUCdRgNpDs8YFknYssA+zDnAzO+bgKD0rOj4ioHJMdLEz2A==
Received: from DU7PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::17) by PA2PR10MB9020.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:426::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Wed, 18 Mar
 2026 12:58:54 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::96) by DU7PR01CA0003.outlook.office365.com
 (2603:10a6:10:50f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 12:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 12:58:53 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 14:01:11 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 13:58:52 +0100
Message-ID: <eebaf70f-0d05-46c4-85ab-d3332b6229c4@foss.st.com>
Date: Wed, 18 Mar 2026 13:58:50 +0100
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
To: Niklas Cassel <cassel@kernel.org>
CC: Koichiro Den <den@valinux.co.jp>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Frank Li <Frank.Li@nxp.com>, Kees Cook
	<kees@kernel.org>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Bhanu Seshu Kumar Valluri
	<bhanuseshukumar@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com>
 <abkdu_7n_lePaTIY@ryzen> <c3039068-1868-4a08-bd0e-0a9e85b85943@foss.st.com>
 <c9278648-1ec1-419e-89ee-0868a4c7c86d@foss.st.com> <abkpFpD3cM_cI_nB@ryzen>
 <ee9b1b8e-4bc8-4fd3-932e-9b944516e114@foss.st.com> <abkw5dltSWVThJYA@ryzen>
 <gbpwik2ad4cuqg3h3wbahhnvvudai3uesmrqinrzknluw555ff@rdkc6i66rge4>
 <27e7aa65-9464-4de2-b70a-575b99f6187b@foss.st.com>
 <0df07ae2-3e01-41d6-b857-01f5a81adbf8@foss.st.com> <abppG38Zic1Z0Kuq@ryzen>
Content-Language: en-US
In-Reply-To: <abppG38Zic1Z0Kuq@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|PA2PR10MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 12749cd6-ab7c-4e3d-1990-08de84ee1bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	q8hIrefycsdmxlIBun+h3Q11UTmm26UpDQf4b2VLFrGXgB/Jve9Qmk6rWo4LpxHxPuB0sbGI1FFv3AHpAzncGjn7gVz/Jl55GZuEZ9+ouF4fQzP7TJ0PXn8YdtveHsJ3uOJtQcCIjUiGNYFOgj0PGWpG6niYzAgGZ49ovvg+maeGxnpNUQYE/90UoLkU7Gkcuy0wRc8sVX0KP+2IffsqeyJa8/Sqxft3gl0otosztDceI9YUR0WtDayv0JNYdPLDFNKa2Q1R7J5UfMBecUNO1N27iVnpZpHha4RdUxURx8PcjN52LXZnZVghuNo/3UqB2xwZh8X8zAwhTJi2beVzbcq3HiXpBsIwIhLVTX7NT7EbwmVgqxtNZX5ykcl3RmQDPRyUO7MlsYED3CSrrSZdhVrnGhNJa0o4k2PXvV70lygTHya4vbaLe4FhR4GrpHldecggYc5PCfxZj5LvH/rTuAKU9cUPn1o6m+1iwSXdOhgxiYHgzcoX7ZBoXNaaFNEB+ey8bqs74hsl4ttJo/0of4nvypd7MBdfadZHIlbqfqAaBueAS52tmJB4XUXLkX4x3KBkIsSriiNqPtF86mnaFlpMUkcLqocrztzbBuTc1gTa98Vz34RObGaqZ9oZE16tDx56npl1cn/xHninw3uA2yuuxs4pvTkIslkFmNJS9zg1in8q+WmeVg/sWY105Z5o7dPKuyfUhhwmvDa8h5zvwY/Uex0BU4h7YVefP5VhmqnT1hyXgvjK7ogmvDIuLwFpAglXz20yavtRNbqHZYcBow==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RHwo+m5hF36cQydsny7TL/c1toOZ0KsTUAXFle8wJpoaBANzxVwoDfe1T7F6cUyf9izecb25ONw9j6NbykFFdk5zNmPedl9o5THbTjl/3youJ1/FQ/f+2z27dAllHAQocjDCExWwhV50su0h7BCzuNpAYqJh6JrxAl5GKrZXG/RIWHKxDDXqUmUIUjHgWsSVTyPPA3F29ueOO13eJYLRXU+DXcTc/TzP/MSU4SFXp5U6EBhoMYkzwqeJY0Z6UXKTu3l19zs0L9CfF9IOOrSeUQl5bDiVGfUsdopwS1Jv7DfBHTpL4zzj2ZDbS3B3BC45L3eKO6+YxP3IhVWXO4sto1ZB3ryQiM79trInE0iCAPLrlnjtoAKgKZfk748Mvp3zG1DV1dLtA81W+JrK6V4fhd7O0Cctbmj8omdH7VjhsKtpKLubz7OaSX7eug5m8BfV
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 12:58:53.5228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12749cd6-ab7c-4e3d-1990-08de84ee1bdc
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9020



On 3/18/26 09:58, Niklas Cassel wrote:
> On Wed, Mar 18, 2026 at 09:35:10AM +0100, Christian Bruel wrote:
>>
>>
>>>>>
>>>>> I think "modify TEST_F to SKIP if ENOSPC",
>>>>> since it will solve the problem for all platforms that have few
>>>>> inbound iATUs.
>>>>
>>>> That sounds like the right direction, though I think we would first
>>>> need a way
>>>> to propagate -ENOSPC back to the host side, instead of just
>>>> collapsing all
>>>> EP-side setup failures into STATUS_BAR_SUBRANGE_SETUP_FAIL, which
>>>> pci_endpoint_test currently maps to -EIO.
>>>>
>>>
>>> I think the epf test function can return several bits in the status
>>> mask, in addition of STATUS_BAR_SUBRANGE_SETUP_FAIL. e.g
>>> STATUS_BAR_SUBRANGE_SETUP_SKIP, or STATUS_BAR_SUBRANGE_SETUP_NOSPC.
>>> I prefer the former since we want to pass the cause, not the action and
>>> let the skip decision to the host
>>>
>>
>> Rethinking this, having a pci_epc_feature to limit the maximum number of
>> simultaneously allocatable BARs might be a useful addition to the EPC
>> driver. The epc driver would need to keep track of the allocated BARs and
>> check it before calling set_bar() for skipping or not.
> 
> The limitation is not allocatable BARs, it is the number of inbound/outbound
> iATUs/windows.
> 
> (E.g. with inbound subrange mapping one BAR could be split in 3, and require
> three different iATUs, but another BAR is not split, so just requires one
> iATU.)
> 
> 
> Right now, a big limitation in the PCI endpoint framework, is that there is
> currently no API to see how many inbound/outbound iATUs that are currently
> in use.
> 
> So the only thing you can do is to call mem_map() and see if you get an
> error. This is a bit wasteful, as in some cases, you could probably
> skip/wait with a lot of processing, if you knew that there was no free
> iATUs windows available.


Ah yes, I didn't consider mem_map(). For the record, the idea was to 
expose num_ib_windows in the epc_features to cap the number of BARs. 
subranges would consume multiple entries.

But we need to track counts for that, and I'm afraid this is a fragile 
abstraction from the iATU

Today, with the stm32mp2 iATU limitation, the epf test fails not 
gracefully : (unless we disable 2 bars)

[   13.453253] stm32-ep-pcie 48400000.pcie-ep: iATU: unroll T, 4 ob, 4 
ib, align 64K, limit 4G
[   13.456074] pci_epf_test pci_epf_test.0: Failed to get private DMA rx 
channel. Falling back to generic one
[   13.466149] stm32-ep-pcie 48400000.pcie-ep: No free inbound window
[   13.472061] pci_epf_test pci_epf_test.0: Failed to set BAR4
[   13.477626] stm32-ep-pcie 48400000.pcie-ep: No free inbound window
[   13.483981] pci_epf_test pci_epf_test.0: Failed to set BAR5

This could be solved by monitoring the iATU free spaces based on the 
feature, but that's another subject.

For now and the subrange skip, reporting ENOSPC is good enough indeed

Thank you for your advice,

Christian

> However, I think such API would be most useful for outbound mapping.
> I.e. endpoint to host transfers. Think of e.g. nvmet-pci-epf, you can
> easily have a queue depth of 128, so 128 outbound mappings at the same
> time.
>
> 
> For inbound mappings, you can only ever map BARs, so in comparison
> to outbound mappings, inbound mappings are very limited.
> 6 BARs, and sure, with inbound subrange mapping you can have a few
> windows per BAR, but this is usually something the EPF driver does a
> .bind() time, even before any transfers have taken place.
> 
> If set_bar() fails with -ENOSPC or something to indicate no free window,
> I would imagine that that that is good enough for most EPF drivers.
> 
> 
>>
>> Do you think this added (minor) complexity is worth it compared to simply
>> returning ENOSPC in the status?
> 
> TL;DL: I think a number of free windows API would be a good addition,
> but for outbound windows.
> 
> For inbound windows, it seems a bit unnecessary IMO.
> 
> 
> Kind regards,
> Niklas

