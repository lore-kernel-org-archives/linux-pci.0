Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D196377572;
	Wed, 18 Mar 2026 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820993; cv=fail; b=SHXFpSdlaWUoNLxMPb6FyX64/iB6wSuBa6jOS2XMsTF4Os1CbGpAefs/44CBM6y1xI4f6eiiVgBFj+M36b7yVj3QTVR3sTS1/i/oTkeRspqrmzslW6DGd2BngZNxTOWIWZAM0OZRIQVbrsOoX3s8FrcyflOdWhTTGUsm8AUOlyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820993; c=relaxed/simple;
	bh=jzgqPUrcpolIgf1s8TS7MgajvvrMq7+40MY85uiHnuA=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kkc9LvLufNCu7hKI9TQz8bo/WRyZ98IAH/5j9nhAe4yi8mUiHTQQtv2FUmLjA3OZF/GwpAv3pfny0/hTYFl2dz3RwfSq3JAfKgWC1geNWDrpEpoQBTbcO4xrq4ZQ4bu8nllQeHRRHECg1w7Z7etfGsx+qArI56ldS/1JQM6ZTcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hXkvCoos; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hXkvCoos"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dirARqV1bnxgEgdzaqOCV76Oh+fCgOgXrMKUn0VEcvJhZY49JClUta2bcPiWzZdkE6orGNHiw7JET67lTWj8E8xB2TsXQl/jwuo9UPoPixUhxGzzFaWWNavsjI3SN3ruEGIzLFKgWhova0q2/oHKvzj6W5CjUzZxBluRDVKIgpH/pxZrlo9awvmu9OTr0zupDl7xQ5kVM7b93BBJdWBen0FJK1lH72OBieTHYPUSKW4R5qGtElzbGaBJZ6ITB2HA5Rz2d5zjIANTIIqW+sETrhiHfoB+hKWISu1ta6V/LZJcW+Lzv1R8I7OPK5hCodimklXGaHBD0qqZXFghlN2VvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR2BMT6kVWRYOaC1RBn6AbxhbRXkyaukod8o5FI1vlA=;
 b=xN26QFJUuGS98yERRImuGAyi0kJ+7UC7fx8E3W734SWZcXjJj/4GHXEJkamfJtsbs17mDr4bIADXCDyNz1NbqXXnkiCUEnjVvgxW1T5EH/N4nQZ4dhVhPm4F8gjT14QM+ogTe9OW0c0rpFsgU/zkVcrMWmAOF/Qq2ONfxRs2zyuBrL8Qs+6ouGISDvF8rh5Ut9ewQPg3r55ooswuRtVB+6Q9yttkyEHFnKIubjUCY+klN/KTgnNRHY1dB87pbBjibxgvDh964F0jL6fndQJ421p1EGdFJgmscUXgpvBOvKP6MMoahFFQ5tsIVq/Cr3xwb9vY4Q6uKlpbKMoeyucvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=valinux.co.jp smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR2BMT6kVWRYOaC1RBn6AbxhbRXkyaukod8o5FI1vlA=;
 b=hXkvCoosNrGfs7iHouo44gvkOHFaPMu6CHnJ+8maChqiqvSjvweFn7EUZiDQW/oUrSRXH7XhCPP3ui62KEuGVKzMHSY8oJ8bIU2y4FwGefr+jToJlA27L/6myAu7ZGCuHJCTwQx1CcKgmsbc83kwsaCFq/vJB1xoTYfYfdMsQV+Whxx27Ql2sVHSg9AO5h7tPsKo8KuI65DWgrh8RiAVTwXcfASXqbvtHhkwcohScZTfpBm+oxP9qjOgliETqrJELmyIbb0RmD6HS7X+rU7g2OL2doHo9jlDpmDiCx0qN7oXgeEJvjBMj0RYYuMo2C0LUIiZhnKugFnUi4LkkvFc4Q==
Received: from DB8PR06CA0044.eurprd06.prod.outlook.com (2603:10a6:10:120::18)
 by DB3PR10MB6859.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:03:06 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::c6) by DB8PR06CA0044.outlook.office365.com
 (2603:10a6:10:120::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 08:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B94.mail.protection.outlook.com (10.167.8.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 08:03:05 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 09:05:11 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 09:02:51 +0100
Message-ID: <27e7aa65-9464-4de2-b70a-575b99f6187b@foss.st.com>
Date: Wed, 18 Mar 2026 09:02:50 +0100
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
To: Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam
	<mani@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, "Frank
 Li" <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Bhanu Seshu Kumar Valluri
	<bhanuseshukumar@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
 <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com> <abkdu_7n_lePaTIY@ryzen>
 <c3039068-1868-4a08-bd0e-0a9e85b85943@foss.st.com>
 <c9278648-1ec1-419e-89ee-0868a4c7c86d@foss.st.com> <abkpFpD3cM_cI_nB@ryzen>
 <ee9b1b8e-4bc8-4fd3-932e-9b944516e114@foss.st.com> <abkw5dltSWVThJYA@ryzen>
 <gbpwik2ad4cuqg3h3wbahhnvvudai3uesmrqinrzknluw555ff@rdkc6i66rge4>
Content-Language: en-US
In-Reply-To: <gbpwik2ad4cuqg3h3wbahhnvvudai3uesmrqinrzknluw555ff@rdkc6i66rge4>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B94:EE_|DB3PR10MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: f198b94f-9acd-4c35-7d78-08de84c4c8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ruiM8pEYtE+tg4Myzm8+AEovMKX9T1eqne31OnYuBe7WSb7pMwj3QFFwcSWdUCb3JCDWqIX4P7z6Verq35MVgUk1/iGJz8JoPYQjNm7Bx2NoHAOivDNgjyhFw65d0oeR1P1+MAlVGrjX1W+UcqYBZhFI2Jv7NARPTq6zfvl6+MQJC18lWt/VIJNaCOZmrvD16LyNtVzCO3qurR+Vj1z7+3MbIEKSbPXenscvE5N9w11U6+ihELWLUsS0eSbrfkEWNdFIFztoK0JqsE4l0PdFMUcMWnDcJNefWjlIqy9Y0h7DYNu+/Xj0KHXUIOBtRdpo+jgDtr8elNtU4JOZYtTIv34hTy2s4JKNlZWCzvQ5kUkAr2bVAMGMrXD1PXQqdkC6VNTZEa1lyxFqGdlk8XVwXIgzRMeQ4zZNyNfZc6us0ZNnwpM825wFzrD4laZXcgT19CKZr9CXeEUpA1kREvfkZkxZE/6NpjT2wlxjKTCs5MqEMAUndf7rU8ODWWgem+n6WP4beoHiSgvwREDf32zAjMTSupiHX10OVaS2i1ZLDXVurnftmI/z39KJu9jVIhppDwWeq42gIG3r3REGxuefAL3p2rwWm7hU+fnwtQ0+zsVXC4+9zaT6e2Q55BVEmkp4wgUvwc4TOiEC865m1fLw0LscCV2Ts1pMqPvMkKnmTOj2LvbFUdf6NTOYZEOr3ie9gRzKJUmboE4pzpngItVyi4hCs3gAaAwvjWqZsEDvcPs=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(13003099007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	znAhaKUwYfo3Sxds1F25e8yArZ9OCQlvMQAoXSN8l0qsvtK6gR8nWak+V9VA7VrOI9qIl/T99e3crBeFlsdBauGT7vujA33a153GYtFrOHpz+mPwJhWZdkwsA3p1lGKJve4U7q55CrnArY1d++rGBmoZqb3XFkmq8qVZDBP3/C9wgFCdwJmtRQ9dhz01UOKrit9xHek9RWmP5UWGCEujvw5/NiRSZyrviNmKg3XNTMoGriFpg7ZQpMJC/RpCESnZpsNpHR6UjNz3atKgTuFqD7huQUGOimRw0uTQ1ylOJMJTgjX3JjiTUT3Ibcj2VxsSk1sU4jC/7k0vFMLGZkNqqQjJZwGuA5FzgOpVTpWYqG7/5H2nvuptRb7bxCo1YBsOxx+ztAX8dSB9q+SUU0CsotQ/PuGMRckLRmn6m+KIIclnnXRo5Yc0JwJWWyzDV3B2
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:03:05.0646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f198b94f-9acd-4c35-7d78-08de84c4c8e0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6859



On 3/17/26 16:14, Koichiro Den wrote:
> On Tue, Mar 17, 2026 at 11:46:03AM +0100, Niklas Cassel wrote:
>> On Tue, Mar 17, 2026 at 11:29:41AM +0100, Christian Bruel wrote:
>>>
>>>
>>> On 3/17/26 11:12, Niklas Cassel wrote:
>>>> On Tue, Mar 17, 2026 at 11:01:28AM +0100, Christian Bruel wrote:
>>>>>
>>>>>
>>>>>>
>>>>>> So we will need to add a SKIP ENOSPC case in TEST_F(pci_ep_bar,
>>>>>> BAR_SUBRANGE_TEST)
>>>>>>
>>>>> Re-checking this, no need for ENOSPC test. The real condition would be
>>>>> EBUSY. Which can be handled nicely in a stm32 ep_map_addr helper.
>>>>
>>>> Are you sure that it returns EBUSY and not ENOSPC?
>>>>
>>>> I would have expected the error to be ENOSPC when there are no free inbound
>>>> window:
>>>> https://github.com/torvalds/linux/blob/v7.0-rc4/drivers/pci/controller/dwc/pcie-designware-ep.c#L307-L312
>>>
>>> dw_pcie_ep_ib_atu_addr() returns ENOSPC. I was thinking to overload .set_bar
>>> with a stm32 helper to return EBUSY if the subrange bar is already reserved.
>>>
>>> So whatever is best
>>>   - modify TEST_F to SKIP if ENOSPC
>>> or
>>>   - Add a specific platform .set_bar helper to return EBUSY, already handled
>>> in the test.
>>
>> I think "modify TEST_F to SKIP if ENOSPC",
>> since it will solve the problem for all platforms that have few inbound iATUs.
> 
> That sounds like the right direction, though I think we would first need a way
> to propagate -ENOSPC back to the host side, instead of just collapsing all
> EP-side setup failures into STATUS_BAR_SUBRANGE_SETUP_FAIL, which
> pci_endpoint_test currently maps to -EIO.
> 

I think the epf test function can return several bits in the status 
mask, in addition of STATUS_BAR_SUBRANGE_SETUP_FAIL. e.g 
STATUS_BAR_SUBRANGE_SETUP_SKIP, or STATUS_BAR_SUBRANGE_SETUP_NOSPC.
I prefer the former since we want to pass the cause, not the action and 
let the skip decision to the host

> One question is whether it's always safe to treat -ENOSPC as a pure resource
> limitation, rather than something that could also be triggered by other issues
> (e.g. a bug).

Looking at the execution path, it seems that the only ENOSPC return 
point for the DWC controller is from dw_pcie_ep_ib_atu_addr() during 
allocation in the ib_window_map. If there is a bug in this part I 
expected it would be caught by the BAR_TEST

> 
> That said, if preferred, I can prepare a patch (series) for that.
> 
> Thanks,
> Koichiro
> 

Oh, sorry, I'm already testing the patch.

thank you,

Christian

>>
>>
>> Kind regards,
>> Niklas

