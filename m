Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE033DEE5;
	Wed, 20 May 2026 05:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779254836; cv=fail; b=B2CAx64MRzECJVmX5OQGEpyQ/67SJK20yF/rZFKk/EA9oW4fsFsQvz/JDtv/uddJIYATuwP7Eo3O5UcXi5iOKJMXSyE3e+9pc2WdfQT20Mk5udh/plmnn2c2pKbhHHRImY6otJQ0sReXQJo5lTCuV7VJkOSYulQURoC+xOJ0flw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779254836; c=relaxed/simple;
	bh=689yovPc9r8uoQiNFsvfZSgw7G6Z4LUH5jhKtu5a0rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VVgsS7iLyFO0Y5mVO/Zl6pAm5H9970sgqiGX/8jD3m8075ecdVy4jix1xepPjWOASZ9DSwjOrTKj2pYYYsBmMMUK249M7UggfGuvxCp2+cB5lRsUp/nukV08q1CZD7yF2DkG7Fn30eX/ElC1iYq+WE4IVC5ZS/YnjNPnVYzP4hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZnW8TKJh; arc=fail smtp.client-ip=52.101.48.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZnW8TKJh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsMpfBLCujD5G9mXhf07E6l4KlQ6dxnml9K8xJyeYQ2m7Qduqs01GxLvwfIgXSzBjs5x32FdrKlOQacPwv40g07B2cOCC/xkWBPZoSrvuYjsLRTORTYXKcQapjIQQCqN+W8sMxfCwun9ANmqREIABmq2hJ1tiQlTIv2Q9nHtHS6khJvAF7aMRDgvv+v8kpyFRH+nOUheYvU5Nvj68zx3jne1JSRFTe0uPZYEnTFoUlxHbZZ3X2Phnb/WCKsPJyH30qnQjXN2CrUbQIUnz0hB0ffxectRXLjoSUrEM/hfF5tHhZv8Fd82fs2u+3T4WHOAQ/mp5XPP/pqj9CjWxXfytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLQjgOfMF2Ox6LsYH3cvzTiza4CMl5ST6fdnodl06jY=;
 b=QKittW/aBegt/VDcvoMeDZXs+hKOHBfv0JkwO/Y4FqcyUvrRPM3xiP1BYPQLzUWr4JZD7DSBfQ1uy9rH90Cy2fJ8xZrTgbvzVTu7GA7162DL7ePAccl3a9XobId96FiNEa7ppNJs1PkL4rHmvFyiap1ZE5bsPmxgnCiJocq5U22oOxIAQ98FaewQ5WYJRYKQX9Dw/9MqO1sJccg7hn4K3gY3XeITmpQ0NS9R+6vbyymwpNr5h7M+rZnKlJ+WmI3IBRoJNjrICpgdp8HoWnciYMF4FqbPzPOmOk0Et2+eU3l72Xnd4+HGAwLpKZiTcyRfKUHz9KjB3vK7AnjOeoAuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLQjgOfMF2Ox6LsYH3cvzTiza4CMl5ST6fdnodl06jY=;
 b=ZnW8TKJhafaWDvZYiTTAWf7AoaEMiL9zLDEOMr/sEUAc79ri/veCcFqnWF93leJOokDbnKfXP6YUq7Yd18QT8c2/U4FbLAVbzaPVGWIc5aBWsogLezb/yZBu2Sy9ZuX7k3GOFAuhQOKiS84AF5GGLa5kTTi5pmePtpVOLCHdygo=
Received: from PH8PR21CA0021.namprd21.prod.outlook.com (2603:10b6:510:2ce::15)
 by IA0PR10MB6820.namprd10.prod.outlook.com (2603:10b6:208:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 05:27:12 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::83) by PH8PR21CA0021.outlook.office365.com
 (2603:10b6:510:2ce::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.6 via Frontend Transport; Wed, 20
 May 2026 05:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 05:27:12 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 00:27:11 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 00:27:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 20 May 2026 00:27:11 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64K5R8nb1322470;
	Wed, 20 May 2026 00:27:08 -0500
Message-ID: <026b1332-1d53-44bb-8528-2b6be5f91233@ti.com>
Date: Wed, 20 May 2026 10:57:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] PCI: cadence: Add LGA IP debugfs for LTSSM status
To: Hans Zhang <18255117159@163.com>, Manikandan Karunakaran Pillai
	<mpillai@cadence.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "s-vadapalli@ti.com"
	<s-vadapalli@ti.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20260519123609.1595280-1-18255117159@163.com>
 <20260519123609.1595280-4-18255117159@163.com>
 <DM6PR07MB6716A1B312BB85439C399D56A2012@DM6PR07MB6716.namprd07.prod.outlook.com>
 <e3fa093e-28a5-46a1-a10e-e8065d127d08@163.com>
 <6ca26fc1-27d8-45ae-8f16-3266e90e74eb@ti.com>
 <4768d23f-b07c-4cb5-b626-cf4aaeca2647@163.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <4768d23f-b07c-4cb5-b626-cf4aaeca2647@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA0PR10MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: c950897f-5c8e-4c82-e482-08deb6307225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|4143699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3XByQpmOxHET9CI3V/p0IL6jdBnTEoVIduhmvMmwS928FO6cJU1c2C1hno5fn58uSOA83YDzhEWy4XOb0SPD9LhUkUoJbes+7ZTs8xs/uoZ1ZlszZPzSrywvSUE+6r95zeu2LcCgE+J2sL/+mCqRtI9QFyuwgbkdepxm1JEH2b7RHFifTAkZsd5/VeX1pC8UpfnqJgc1rn2ijMhGTzKXmdpKByl7xLHmYPiT7BZ1W0Z7hrcMi7c/Cw4i35IeMiVP/bWowvP1gZU9JMSBzV85gFVSEKdPeU9E7heCPe97u2XZfIvi80UAsHM7B55cI0TEow+76rkv/S/8RvxryImqZI7EDfonV6xjNv0/UMd9A2kLJjv473o8dOQ0KjUGJtMunL7wlCcUdUbxodZwxtTVlZ5+UAr/oY+/NEaZX2typiLHGyCOrWAiP/yY11i3tU/Zxt4U5z/WbN+1Tgd5PwjDkY9W5holJHzkpA2Z++XLflO2nQ6SbCW1PpigFJrYmMJWR1h+t/hQe/4RvIqkthUo9IzWy1B5dSYRLsjoH30DZ5Hf6HR2J8TS0cNePnKr3YSVCaMugNCXb4AITdkOE66cZgGLgpMMQ34aTtKJZE/f0itfjxlHMul0BKoZkwQ3hkQdDZesl52nxifQRsY+YVpi5jxTSJZqDwQOrt3HKqKocp0xL1lPxwTHdh4QGTIY6Sd7aRq7EnLS6p1Zl/Eg8pkHy7OREOmcUZM9tKu9NZL6DNo=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(4143699003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GIh75xwnY5hXTuszsqBVa8AMRcTu2mX2soK5TD+PXJ2dndKBZgp4TueB2rySf4qjNWsZnGbUSdO+Fl80bbrHXgmByIOLf7+fpK0gZO740vpH6lPYmJFIRhou69CABWKYvkzvIkI3ejBWCTxNYkscLkSSJuhGOji81CVFo+vtQw12pAQKcLCslbrF5GGSRIU6QNIRtuRQ0+JYs4eCIFPJvuv8lovAsXLLXHr+BiQLKX0sClkfqPoUPbROhPZT7bESakM5uq/vKDukVRXdKhh1f136WNh/bNeDczUVESMdTLdyHdd845Nk7cwJoryMrCg6bJXcU9/72yLAFM0/g/1farHhsz/y74nH+fMDbsPzLAHR60288o1J7FQphGsl8aZn7osFKibY4ipLT67Sj8gK+H2HuzUUk1QpqX2yqNeNVZCZxnVdETbegijs3jTVJCKh
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 05:27:12.2162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c950897f-5c8e-4c82-e482-08deb6307225
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6820



On 20/05/26 10:10, Hans Zhang wrote:
> 
> 
> On 5/20/26 12:36, Aksh Garg wrote:
>>
>>
>> On 20/05/26 08:29, Hans Zhang wrote:
>>>
>>>
>>> On 5/20/26 10:34, Manikandan Karunakaran Pillai wrote:
>>>>> EXTERNAL MAIL
>>>>>
>>>>>
>>>>> Extend debugfs support to LGA-based Cadence PCIe controllers. The
>>>>> 'ltssm_status' file now works for both HPA and LGA IP by selecting the
>>>>> appropriate register access based on the 'is_hpa' flag.
>>>>>
>>>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>>>> ---
>>>>> .../controller/cadence/pcie-cadence-debugfs.c | 61 ++++++++++++++++++-
>>>>> .../pci/controller/cadence/pcie-cadence-ep.c  |  3 +
>>>>> .../controller/cadence/pcie-cadence-host.c    |  9 ++-
>>>>> drivers/pci/controller/cadence/pcie-cadence.h | 43 +++++++++++++
>>>>> 4 files changed, 112 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>>>> b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>>>> index 97c5deef2b1a..0a308f95e9f6 100644
>>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>>>> @@ -13,6 +13,58 @@
>>>>>
>>>>> #define CDNS_DEBUGFS_BUF_MAX        128
>>>>
>>>> Where is CDNS_DEBUGFS_BUF_MAX used for ?
>>>
>>> Hi Manikandan,
>>>
>>> Thank you very much for your reply and reminder.
>>>
>>> This macro definition was used in patch 0002. Since I compiled the 
>>> code after applying all three patches together, I didn't notice this 
>>> issue. The next version will be fixed and will be included in patch 
>>> 0002.
>>
>> I didn't understood the issue here. The macro definition was indeed 
>> introduced in patch 0002 itself right? Am I missing something here?
> 
> Hi Aksh,
> 
> If only patches 0001 and 0002 are applied, there will be a compilation 
> error. Patch 0002 will fail to find CDNS_DEBUGFS_BUF_MAX. Previously, I 
> split LGA into patch 0003. I didn't notice this issue. Do you think I 
> have explained it clearly?

I see no compilation errors after applying only patch 1 and 2.
CDNS_DEBUGFS_BUF_MAX macro is defined in the patch 2 itself.

Patch 3 just uses the CDNS_DEBUGFS_BUF_MAX macro definition code for the 
reference point to add the new code lines in that patch, it didn't 
introduced the macro here.

> 
> Best regards,
> Hans
> 

