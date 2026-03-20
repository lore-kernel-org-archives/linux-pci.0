Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A2D346E43;
	Fri, 20 Mar 2026 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774013120; cv=fail; b=qmaVE3FWKBDVZSrWxUXWbScJq2elHmJIFgU6pHoxpkfievDK/ndK+pYKXzJswJNtfKJx0w2K29M4/G8V2xoVkj+1LmjpVjMOYC/htpm2Y2GqlOvc7U7Epd7n4ow/sOYEL0tb0rQlvdAgTQkAOjce8M285/9bc8B1Nssqu2NioGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774013120; c=relaxed/simple;
	bh=lmeZlPawrAvgBO4sgRPBCLCMp1VstOsy41wQrvbg1rA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F3/hbcndsZGDZ1axJaAztPd05LPEYmRdBHwG2kimnJYKLS9ffQl+PYOSSHnSayE7ilHDTFXZynkw/qQsg2w55RtBupwsxKGQ3Zw1UYyMEcyLICmc2hW4c2/WP100jY11E7kanV0s9pYWcMOrFhpfK6pigOElRRMSBMC29lAgo0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=jUAm07Lc; arc=fail smtp.client-ip=52.101.83.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="jUAm07Lc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0+nmKfyNmqqQvm9mzGxz/BsiXtP485PK3gL5iyBl14YKYY91ZYbjdGQ8MsR3UBP74J90tDThDnHdLo9LjB7N6NBvYYbXjk8JquVegy0cHjyP03ac4Kx4K//EJbh2Mx+qxPXWjoTqwrhSTL/eczqEn/R1z8hHPEdGiaf07mwxP5MMYh76PnJawNME5sWNJ/K3R3W+8WnalElk5Us+YDdaGQkp5rihZj8viR7h4K/tTyX8rb8kiSyX2BbFbVzA5P2IBSQ9U3pksv06pfEDT4ceGhgwurOX4aJxFd2YCikFIvmWlLatlLQWpFyFWnpI1V4T6GNPf0OXfuHkWiXhRh/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7XoB2srRNbQAbXA10Hb3kerZHD9fvUE/8wZqB3WOX8=;
 b=sj3jza0L2vy4/v13UYx+o759UXFYOndpEoCbvnilRkRzXiflr7fCexoPFikVGE0JvM7BOWJOC9K44K7sAHUnBdWkUUHMhydwSWsA9HjPllDz5Qwpq0bbxeN+34K1EfYwBWX6W/c3rQQYcgqO7td6TVCbfXoWDRs1ut1LafUF3daJnZkE8DxjiSFWbmWn2rhkkREWLCDdSm+oAfHuR+pMT73m9Zav7KkHMo3r31SMevWK0SHDIMhsJhalrwtqQgeALDnwU4nVerVHW1YgknmymcrAat6AYsdMH1paTKpUPt6RaBzkkTatY4hp/UcxkieNcRL9bWZEfjLqKPXC/T7bvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7XoB2srRNbQAbXA10Hb3kerZHD9fvUE/8wZqB3WOX8=;
 b=jUAm07LcjDzvCZqxskOcPtjdH0fKXG/iWcSHsSbLuf/u3vTCuYFeTzaPr2EHhmM/5eG/A6JFM5/dU2ln+1ZsscC1Zhr546wvyjBp7e3EHg+WlG+V4rHAH43/UyMuznFzCvMZY6PlnAWLBmKuu7B5SwOATRSaDBHkxxS9zC5uICOa8nUQamfhB19nbT6ebVhnoPo3BVneUTqKQIswSOcG1YtjIoG1W6hcYQnGXFIMZNVatDdbvrls3IZRVQ2Ux0hL+IaRlQtA2Aca/f7UQHq3apJaFB9num3x1wNTmaiPIBlKFTOWZzmz93nRKRkaLSCd7xz4gs4NFWEUpq00kE42ig==
Received: from DU2P251CA0029.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::31)
 by VI0PR10MB9657.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:313::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 13:25:13 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com (2603:10a6:10:230::4)
 by DU2P251CA0029.outlook.office365.com (2603:10a6:10:230::31) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Fri, 20 Mar 2026 13:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 13:25:13 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 20 Mar
 2026 14:27:49 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 20 Mar
 2026 14:25:12 +0100
Message-ID: <e6b385b5-f61c-4b0d-82ed-4018db76538f@foss.st.com>
Date: Fri, 20 Mar 2026 14:25:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] misc: pci_endpoint_test: Handle -ENOSPC in subrange
 mapping test case
To: Niklas Cassel <cassel@kernel.org>
CC: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Shuah Khan <shuah@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Koichiro Den <den@valinux.co.jp>,
	<fabrice.gasnier@foss.st.com>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
 <20260318-skip-bar_subrange-tests-if-enospc-v1-3-f1a49534ebea@foss.st.com>
 <abrM0Jvo_sdWSTLc@ryzen> <28a71759-1095-4403-b356-d291a828daba@foss.st.com>
 <ab0seD_G4ER7R_9N@ryzen>
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <ab0seD_G4ER7R_9N@ryzen>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|VI0PR10MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb64c0e-48cd-4e45-34b6-08de86841e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6rhEWchJLSR7guRcMFK95FL7StBvnOYCb9eas+FoFFgJ548yXJvZq8wv5VtjXLB68ytvoMccyqzEy24349/N8nJLwQWLfVgI1KuwPAVgExs9SMdePKKP3PLn8yFYUtt7irRqH/FisABNrTOxdQgrDsCPmkxSqDhVLYwsvXMVZ51QZfrcuzsBJdORVlTPsGjRKAN0Cy+BIFNljUrJwqFtHxra3oUJSSA8whKnuQy/twiRyZtfA5rSz4liS8bJOTHfLuYZFlwhXxZ9QkyiguHF7RMaLmDxYjXbGc4TMcKKZ2wnjRNS8/xihg3GIay9gsr8IjuHxap44YVS7biUTq719PU4opzoIViQMLUM4GHdoT4QPc8H7p6WSzif8hQga0NulzG/TDNEN0H/JKDGsWSchdcrwqD2ZjrG7D19IUbMJ+2jv5mqRpFeAjQFqUjAiXUT7NX0neJ6NjkTj0Ucb9sAgxI+xID9uH4LrphywN6NTruddd4lHA+TuxORSqxbIKf2jdK4104vqTlqiujVgNOrcEcRIYX1EURrcZtVTE5AMroNVU1t9kHAQjcXJ3ZqZ6m4uWhXxoKxdxL5pI9zc9rmejMT1NLsdAM5hciuemM7Y871frbjWE5XLF9KRMXKg+fLpMEOCaS0RLRtW4tDlffUJ5zDYYz9ksF5rPbgcUOjAnSDcRdHYR2Ezv+pXSndelx7aeoQix/1Iv4aADHm/1l2rnXZf/T/nGJzpYbFdbObLe3CxusGDd7jtdMy1m+xx+TRTPJ6St5W9gLUwsUA7g8ZOg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yuWOmVM+0g0pUNaHG2bZ45sqImD7GvzoCXSqKWm87ss/4ZJWNVvKCsnYVzOLFDvNLe0rlm5xKGZ7wQ0XGv32BslMuZjvqp6JwVHVMiPRs68e6cV7TCtPCFMz0PxDXWhUhi6UoE1OP/tcVpaDLHAAnKgxUKtiIpt609DeHOMJIfyipR+cS5+GFkbpWc0L1urjlvlsVN3i+ozk0RNLJts5oBih19vFAREehBvKAbHEwXOk1YV9pvGHAbe+3M3X4h50XaOdMniR9jgOAaqm5/uX71FXhm6Q/oc/avQ5k55TcYWVHyZKPt/h2bzuSTsv1o3O1D9+RWiQqpHo7S5j17qXannwP2Q8YW9AzzUbUS6a+j/3OwTIMUBwsBEqW7JGR+hV5xxPIZY07DnWm9zYo1JeTSxrgqP3/sVOfFdirYP6lu+dF4BznuynwE7s/yQcclcm
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 13:25:13.3726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb64c0e-48cd-4e45-34b6-08de86841e46
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9657



On 3/20/26 12:16, Niklas Cassel wrote:
> On Fri, Mar 20, 2026 at 10:35:20AM +0100, Christian Bruel wrote:
>> Hello,
>>
>>>>
>>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>>>> index 55e128ed82f00ae13b6fe9768cdbe56adbe8f9da..34ba06fb53f04e48c1c05f4aae85e6ecd03ef447 100644
>>>> --- a/drivers/misc/pci_endpoint_test.c
>>>> +++ b/drivers/misc/pci_endpoint_test.c
>>>> @@ -61,6 +61,7 @@
>>>>    #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
>>>>    #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
>>>>    #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
>>>> +#define STATUS_BAR_SUBRANGE_SETUP_NOSPC		BIT(18)
>>>>    #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
>>>>    #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
>>>> @@ -476,8 +477,11 @@ static int pci_endpoint_test_bar_subrange_cmd(struct pci_endpoint_test *test,
>>>>    		return -ETIMEDOUT;
>>>>    	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
>>>> -	if (status & fail_bit)
>>>> +	if (status & fail_bit) {
>>>> +		if (status & STATUS_BAR_SUBRANGE_SETUP_NOSPC)
>>>> +			return -ENOSPC;
>>>
>>> Perhaps this should be something like:
>>>
>>> if (command == COMMAND_BAR_SUBRANGE_SETUP && status & STATUS_BAR_SUBRANGE_SETUP_SKIP)
>>
>> I'm not sure about replacing STATUS_BAR_SUBRANGE_SETUP_NOSPC by
>> STATUS_BAR_SUBRANGE_SETUP_SKIP
>>
>> The selftest will use if (ret == -ENOSPC), so we need to return this
>> information (bellow). and semantically SKIP does not imply ENOPSC (instead
>> of the contrary)
>>
>> as you prefer,
> 
> FWIW, I think an even better solution is to introduce a new register,
> named e.g. errno in struct pci_epf_test_reg;
> 
> That way, we don't need to take a new bit, e.g.:
> +#define STATUS_BAR_SUBRANGE_SETUP_NOSPC          BIT(18)
> 
> For every unique error code a command can return.
> 
> We would simply return STATUS_BAR_SUBRANGE_CLEAR_FAIL, and then the host
> side driver looks at the errno register to see the specific error code.
> 
> This way, all other _FAIL commands could also return a more specific error
> in case of failure.
> 
> 
>>
>> To minimize changes, what about something like:
>>
>>   unsigned int fail_bit = status & fail_bits;
>>
>>   if (fail_bit == STATUS_BAR_SUBRANGE_SETUP_NOSPC)
>>     return -ENOSPC;
>>
>>   if (fail_bit == STATUS_BAR_SUBRANGE_SETUP_FAIL)
>>     return -EIO;
>>
>> called with
>>
>>         pci_endpoint_test_bar_subrange_cmd(...,
>>         STATUS_BAR_SUBRANGE_SETUP_FAIL | STATUS_BAR_SUBRANGE_SETUP_NOSPC);
>>
>> replacing the fail_bit parameter with fail_bits.
> 
> Sounds okay to me, but I think the idea of adding an errno register is
> more extensible.
> 

But it is not consistent with other tests that use the status field to 
carry error information. For example, pci_epf_test_read/write/copy, set 
the STATUS_SRC/DTS_ADDR_INVALID bit to distinguish these errors from 
other -EINVAL.

Introducing a new errno field would result in having two different APIs 
for returning failure status.

In light of the STATUS_SRC/DST_ADDR_INVALID usage, I wonder if my 
initial proposal to set a status bit along with the FAIL bit might 
actually be simpler and more consistent what is already done here.

thank you,

Christian

> 
> Kind regards,
> Niklas

