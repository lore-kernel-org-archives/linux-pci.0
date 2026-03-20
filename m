Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B96314D1A;
	Fri, 20 Mar 2026 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999338; cv=fail; b=Fs4lglp8vQq+VVjCUgt6a4Wponp4yMl7FyQv3QS0whsvayIrwSczkFdjb526QK1TjSPqaXbggo2pP4VjXHq7IWcnsnGNgucGlStxbN5h7gl5H0cfsy4coTSwEv0flUv6u0AvysjEDF2B5svyCI7aOp2h7Ls0yidFo+y8rT3QU44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999338; c=relaxed/simple;
	bh=qu+CrzAICwKvjvEB/KzvJfZtaKqQ+8iTIQbcol7j7QQ=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R7MPTJi19/2vFoHFNcjOCJUBInqaRY7NxZEMMwVyjCKZ0jEYE6ee0AO5AvFITHqufGp8UjUsVxWNlaj0VonZ4XRTsqUqCceA0Sf0K70cwS5ndirj3YX20xffS4jpLi3zZ7JpmiLcGech8bZwzuXHXR0+OfXciE7liiS/KMr7K5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RC6X9x5n; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RC6X9x5n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocQ9UvGwvpz99sdUfSJBZnvtYqHrKSC0dWzhS/cxTt1BXOafsT8o6wJIbyQgIuh6NFCPkZivz+YqTSrd23LENNSBMT+97dbmMyIugKP4FnzcEfpTFHXrMzKmQY7/e2PNVu+Sjj40O/gGN39etFoSUZHrMgPys/0j1mLmuRYudNCETg0T+ZzhAbi1ebDEmUTPX3HdjVrK9m51Kf4EBkezE15GMVLMFbtKD31fq51vf9WvcQuX+RX5WuvWDZDAj/s6Z9EQI3LKB4kM7mc9eFw5Arc1MhlNU00oeu4sJWiOXzzN+Ozkv/V5GUBeDzrgvY4Hq/IXTU/xr2scAVPUVWNaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtzhQKipsLnwS017NtLO24ugZeD7FpwfpECzJcshbQg=;
 b=G4Z17E/iDtRVyVeZpCsj/V5MuoRUH0e+0iZZkEpEHBByE+cxvxWs54XG/dl50mDuKQ6dMMGXqeF+VWtCTThLQ1cyKen7cI4RjCpWSihFK7rfsEPPuhTdinBCy7GVZekhAmZXFLQ7gHaj2njYJxKxdjLYOvdRb4aS1yegDqMCLXUiwhIzH4NbZuqM11qdTLvKClROK6JwdpF3Md+yJwxldiIrQ2tr5wJBgRFvZapBMDQeyvCizBVQeWZ/TUTnkja0371bjyfzin0DaAkaWVeWa1A9+8lKe5UZnzzsgJ/ziCdYanGPm32clZZPbEKpylLFSsr8Xgo2yZKLYYQTIWGtJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtzhQKipsLnwS017NtLO24ugZeD7FpwfpECzJcshbQg=;
 b=RC6X9x5nlj4cdFDPmU4QOChV/na1XFVR3jx4ngJF9Mvu8+FUBdiLHZ3DXJ3TY5e/VGis09aLi3QOOtQQ6QnSNpv2M4bEI5wSFpbvUTFMxTwPSeDZ+LEJvQJYQpeipXgYHFvfl59Kl/ZBtErKb0+aFsQzarHThUNSnzwKCUZQhyOvAPN+WmKeLXqeHu7+HS8TP59f4LC5ifNth/QzThwLlnnnWFI17ktcMeC+zPBafy5nklJQyHOYU2PNWx/2dRUJGzsenHDCC037Ku5AAMktAuGB4iMMergeLT77jUzLn3OgXU8qdRjZC5xitxoZoKFO2vYY6j3xgwnyQ1aIyeUtZw==
Received: from DB9PR06CA0023.eurprd06.prod.outlook.com (2603:10a6:10:1db::28)
 by AM7PR10MB3269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 09:35:31 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::27) by DB9PR06CA0023.outlook.office365.com
 (2603:10a6:10:1db::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 09:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 09:35:31 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 20 Mar
 2026 10:38:07 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 20 Mar
 2026 10:35:30 +0100
Message-ID: <28a71759-1095-4403-b356-d291a828daba@foss.st.com>
Date: Fri, 20 Mar 2026 10:35:20 +0100
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
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
 <abrM0Jvo_sdWSTLc@ryzen>
Content-Language: en-US
In-Reply-To: <abrM0Jvo_sdWSTLc@ryzen>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EF:EE_|AM7PR10MB3269:EE_
X-MS-Office365-Filtering-Correlation-Id: 5934a394-038d-46f8-f332-08de866407bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dkInP7MJJnB4Z6VegEirRPu/5K/5J7tlmRyT0Syk4IeUjujmKh95DHXZsU3RxdSOhWE7YkutebuZWdDMTknhmJH7t66+lJZVoV2IPZH+wehHBXKFPcrxMs91DGA1UyBG3/96WHlh7ny4nouIdZLjoo4S0nKK9OFDrB/y0p4nRzt5YzBdXfFFnh7CqR6dmlgqmbWUEp8v872ICf27FcROw8YceaUxAEKVMRQw8cQ/tfU2xcbjiKl73lG50ilkFUamh/levO745dD3Ob6rHT0Dn7irL8VASEaBvvuncRPjxNwLe4zeE62Yn8Ds/jrBqXtByQth7zVwGZCnVvq2fm4pvXNVFQw9hwdXG4ZqA+zuKm7lWmujtNeEenIfOi2bhKYS3rUdfZKKkuoa5up/E+Lacdq0zkbOniQf/xRuEYOP24JtGvZyMVEwgr3XB2MxgQ110DthamZGF++Kgq5HRsIQqnf2w2hbZAv7OIVe+sU2YAUZdLky8lJ6/xfdh8Q/TeHixohQHVTfZbbJGiARtqXoHUMGN8Sm7RbbFFOL5CgpI4hrgjQlZl3m3AYJYGYmj8C7utH9tQHG9OP4mAqHCzamgajvIGWIF1IWV8hla/SOOeGgf/KAhcQsERFbbfEyYdK7bao3YJMyLwu9VfAq91drtIbyn7XOQ5xBnvTmPyN2a9x4KMT40K55mIRVDE6IN9kZ9k+aj9z/TwsWTYGzhTmqDEa4gtf14nLd+a5iYgf2kxZC7O6IR1mFjf5jHI6++DHrzJFIDpjcOkBSwmbBK+mOGA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NIDWb6LQaopvtRYhUzdPRA3EgguPn/hd3570hzwgP9lCwJ4Jg4j2qBLOH/KjpNJo22u6ye96jXV2e6+XCnnATmKkgZLSLF5zv8eAQk0jv0UoiEUNvlZH07zThs0zKNM4UrhEnT4bv4VechyBqgfO0BiUCtwf8aM9GcFpfiN7BrwlmfonrPsOx2n6diWQbyQnKS2UCMmTkoDluA+W6GENPo8PMTTRsqbHP+SNu7vi+Br/BW81CkHTn/kaCjgUwRmWv5vBy6y70n6nOEafrQLudbs3JroASilqW3eWHSCFONOI3bduLIruUruYKf9mpm9ROqY327O/YXJ9KiPKO0EPa7UFz1qilFXrjUwF+erIXXJmWMh57akic44R2Ui+0OQMPhb1A9Tj6ozIl3gCFeRO4aVYbBI/LGWVedthu7xkwL5wzhWCmOrMM+x83gDol8Ig
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 09:35:31.6878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5934a394-038d-46f8-f332-08de866407bd
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3269

Hello,

>>
>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>> index 55e128ed82f00ae13b6fe9768cdbe56adbe8f9da..34ba06fb53f04e48c1c05f4aae85e6ecd03ef447 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
>> @@ -61,6 +61,7 @@
>>   #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
>>   #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
>>   #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
>> +#define STATUS_BAR_SUBRANGE_SETUP_NOSPC		BIT(18)
>>   
>>   #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
>>   #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
>> @@ -476,8 +477,11 @@ static int pci_endpoint_test_bar_subrange_cmd(struct pci_endpoint_test *test,
>>   		return -ETIMEDOUT;
>>   
>>   	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
>> -	if (status & fail_bit)
>> +	if (status & fail_bit) {
>> +		if (status & STATUS_BAR_SUBRANGE_SETUP_NOSPC)
>> +			return -ENOSPC;
> 
> Perhaps this should be something like:
> 
> if (command == COMMAND_BAR_SUBRANGE_SETUP && status & STATUS_BAR_SUBRANGE_SETUP_SKIP)

I'm not sure about replacing STATUS_BAR_SUBRANGE_SETUP_NOSPC by 
STATUS_BAR_SUBRANGE_SETUP_SKIP

The selftest will use if (ret == -ENOSPC), so we need to return this 
information (bellow). and semantically SKIP does not imply ENOPSC 
(instead of the contrary)

as you prefer,


> 
> Personally, I'm not a big fan of having a common function for both
> pci_endpoint_test_bar_subrange_setup() and
> pci_endpoint_test_bar_subrange_clear() and then sending in parameters
> for which bits to check. It make it hard to have small differences
> between them (like checking for an bit that is only valid for one of
> the commands).
> 
> I can understand why Koichiro wrote it why he did, but since we now
> want differences, perhaps add a preparation patch that makes it two
> separate functions?
> 
> It is not like pci_endpoint_test_bar_subrange_cmd() is a big function
> anyway.
> 

To minimize changes, what about something like:

  unsigned int fail_bit = status & fail_bits;

  if (fail_bit == STATUS_BAR_SUBRANGE_SETUP_NOSPC)
    return -ENOSPC;

  if (fail_bit == STATUS_BAR_SUBRANGE_SETUP_FAIL)
    return -EIO;

called with

        pci_endpoint_test_bar_subrange_cmd(...,
        STATUS_BAR_SUBRANGE_SETUP_FAIL | STATUS_BAR_SUBRANGE_SETUP_NOSPC);

replacing the fail_bit parameter with fail_bits.

Thus we don't need to specialize the test with 'command', But I prefer 
to let Koichiro refactor the function if it is better

thank you,

Christian

> 
> Kind regards,
> Niklas

