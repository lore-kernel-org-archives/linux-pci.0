Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B81F2BAD;
	Fri, 20 Mar 2026 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774016364; cv=fail; b=YZ5DsjnJ5f0RBjF0MuZBMWYG4BpZ7kExJD/yEd2iExsFnsFYN47HkR1FjmJLFpidtPjImnEXVda7YZFu+nXBLdAKwvTanuEBf+AiUrxod79UCnBPCmOUApET18HGx5jM1DIcz7ebmtzf1+7pETf1XeGAw1Bkyy1m6mQrsBOJeeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774016364; c=relaxed/simple;
	bh=JAYWubtIImsJJmcUAbDSJpp+jZkrvBm5nObDE5kL9FE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o+yXhoD9WT2NLdInJKFkhUdIQPFMCII92TgXif3BrlnXKZpK6o0CWf1p3EaUjFgbigK25/FjZiSpH7b7v8vOXTfXmyL8xkIrUe4ln0Y22zW9C/XMQ7y0CNVRtmqSXXcAjeNmfaicqavEJ4ZxpkZtb1e58W2PaMso34cwefnqOpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=h4vzLiBS; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="h4vzLiBS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjlzy6OawoN/owTXFxeCVRspqj3TEcJ3njKVwTjRm/wS8kZpYJJR/I/xeMuDmnUN40dATnjidgW1SXYUjxhRZeEpHzAjg4tHk3zfwZrAKtA2XUvoZxTTOj9S9l4jcXuxuTyLxdEbcLDZZjDGwzHBH7aKyVGQk6gJ4SzIWxxpx2kiX+27lDXAJC2GdfSDLsvFisEJhltKi+rmmlHVeIjZwJXvBePZVwtbBFMec4SbbiRL5PWo9eWvgBrHm3A9Wx/kGxfbLHY4jvHGhBsXqvS3K2AM/hoQbIMHrHGoEYCUKyXVtiRwgXZWJ7N7eT+MlEH4Kyc0ZIPf8SyUGhssxsDKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYbuAv3aDcby0X6DLQZtkkR6sPse06POB9Bem1Ubn6w=;
 b=W16ZAXPhWNikVnxgXbPiAYS3pDY6gt/jgFsc4FnZAMACjnqjP9o5gNfOS8cZTnabCP/l0ZavRu1sI+StYXpN9juAvfOTu41i99bQ9iMABKcszfXY+a0KcNyNsivQmAVd5FOvXPlAq56BXZ2LKuOFLrL5F+xOQ3chrhkTIfyNRA3KG9V+rH3uvMIlQYERArDWF8e7yUlVvEUIRE2ncEABke+cV+uq1SLh4zPwQ5Euxkt8LBcepPxJcQaEoSM9WDuBnf5lVLYNyjEzD2CrF3V1GKfaFTnikZ7eNwccZ6mYmU6wpETZKGBUePq7c197lgirWEX4JBLyKtK8XB5l0BaA2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=valinux.co.jp smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYbuAv3aDcby0X6DLQZtkkR6sPse06POB9Bem1Ubn6w=;
 b=h4vzLiBSQxsfhESlbiWElB35BMuYa8qWOvSrvzXz0nIzCJBqk/fmLvioqMAUHQ4HdE/wBKY7LqjdM4Gq0jBqkvU0DghUsR7woCQ8A1cvsioU4p8H7uBZRxSjz+Nv0LR9wBFgjZbb2hmmvRvOup3kuFasNReNLzNfx4Wt1yyMOZMzBZgxylJatsyyI9NRlQEprX85A6zjVxebAGgV0uTOpDqhyDFQDorA8WMXKgFOf/R1v6JI9s/OW/RiPYcTletbkdg3QCLniWy46/ZH+ehoeucpx3lMkA87HrfZkG1StFPhpJPqzoGp5Kp28qQP4efzNZf5CUnA3a6ec0YH4wlBVw==
Received: from DU7P194CA0021.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::27)
 by AS8PR10MB6922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 14:19:18 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::92) by DU7P194CA0021.outlook.office365.com
 (2603:10a6:10:553::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 14:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:19:17 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 20 Mar
 2026 15:21:54 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 20 Mar
 2026 15:19:16 +0100
Message-ID: <8da9e382-bf85-431e-bcfe-0b9255e8db66@foss.st.com>
Date: Fri, 20 Mar 2026 15:19:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests: pci_endpoint: Skip subrange map test if
 iATU allocation fails
To: Koichiro Den <den@valinux.co.jp>
CC: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Shuah Khan <shuah@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Niklas Cassel <cassel@kernel.org>,
	<fabrice.gasnier@foss.st.com>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
 <20260318-skip-bar_subrange-tests-if-enospc-v1-1-f1a49534ebea@foss.st.com>
 <vki7ty3z5jncmzeltk7udsbynffdld4xhcm3b2yjrgx25cfqkm@4ld66m3jbjqo>
 <d3e8d869-1a10-4a50-a9ed-3c6bc10a6178@foss.st.com>
 <nk2cc2ikag2ofpskmnnc7mqzsvtizwcjm6rlkrkuqesq673h3l@mamriu2gshit>
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <nk2cc2ikag2ofpskmnnc7mqzsvtizwcjm6rlkrkuqesq673h3l@mamriu2gshit>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D05:EE_|AS8PR10MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfbb24a-a614-4cd7-1652-08de868bac11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|56012099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	P8LVsDI0NqymoluDHc+h4CW4GyrOXIDVzdM+2qujdkGfWr+V6pVVllalq2Dp4De1jWrvdzNPxmcrKnCubzlLdszKzPOJm7t+d3K+WoxoXCA/WM5DT7Ls76pB3KD8n3zmkTIb1ZkPK45ABGfnRq5Th9I1Ss9UwcazrwyulJYVpW5Lpl0KsVxrSSOQx79g7V0OevOufpO2dx0k+Hy3uKwbUp42hlQX6bk3eD1K+j9xZaAHi/h26RoATDRG/3C5Y4F3dJm8Vp2nzXbRcEMMaSVaEpmDZ1e6OMlES7OE5rD6aL46aLUE/S83vDvXt5muzdMNXScx8P7fcsYZV8tWxGFy2dRE/EZuuPqYiawV4YCaF/iyK27zIjXMChRMuQJUZNopdr47Bn0gcQfd/KDjh1JUfRsbvo/qyjdlNPNib+OwcyXT9svqXuh+BYrwi1Zsl8c5b9gpAc1CBVeFbcMYDBYx3V/e6MgyvRpGzH16g5/kheRJQkIJwSL927hIfDgHENLsUeIWA3zQ3FV2UGIV2k+CECFP+XZKhNmUXWmY5SjocRLtOvgrzXpzlxyQUUypv/uXMzLMIwEcc9rMBXldJsZiNEaOYjGbmpsqA8mGYX5MSOqfb6Z5QMhTynLbr7LikvjmbN0Ung+3FhpfxxSV4J8BSZo8o1GG6Uc5FxGHmQUi+AGPxJaWA5I+uChYl7DDAG6KxkuGRJDSbb2lo5sevwzNW8JrzY6l2zwuEg8I2SFM/78=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vxYthYuIERFaZmSAeDZKAMy9hGCPf6Vmqb8aH9XxPKTnmRQ25KGtLNgQgll2UcZ/7BVH16FBWGVi9wJt/0g9C1Ob8X7aZZhhXRVA4nhw9y2uFEXgc0qlJX2OoUU0vCCExK7KDMrJtPSgzkKZMPfJWetGg3c7UIo85zSTCp5FDdCYdHrDf+S8OkQYf9Ha8OAy94OoTVQaXMf7bjUN9u05xHUyv4WpA3UOaesaW1oRbcHLXECp8Jf8yCV9vSzNro7t0PkPP+cjnTETM35wJKyXQahkrUWcrsS/NGuPRvh6ew1cmjoeSpme9xUuAjlfKD6gVcdP6ujOSz9Res8pZmBs+aBi1cF4Wc7uQgbtMrgXMwQj6Dn1W3so8ytfzTLxXR1v95yHamCodyS4POw68PosIQY8VUtO4H2DEssSPbm8NBXBsCOrkKRgrb+XdiRhU4KP
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:19:17.7419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfbb24a-a614-4cd7-1652-08de868bac11
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6922



On 3/20/26 15:05, Koichiro Den wrote:
> On Fri, Mar 20, 2026 at 11:04:28AM +0100, Christian Bruel wrote:
>> Hello Koichiro, thank you for your comment
>>
>> On 3/19/26 02:28, Koichiro Den wrote:
>>> On Wed, Mar 18, 2026 at 03:46:27PM +0100, Christian Bruel wrote:
>>>> Handle -ENOSPC error. If the number of available inbound ATU entries is
>>>> insufficient to map the subrange, skip the test instead of failing.
>>>>
>>>> Link: https://lore.kernel.org/linux-pci/20260317152707.GA85951@bhelgaas/T/#m87e4c24173097a0ea70195b71aab294ad8d6c283
>>>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>>>> ---
>>>>    tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
>>>> index c417fb3a198b2d92c3060938c23807cc8bea5573..8ea2fda4539d11eb22b22800a7cb8bbaa99c91ba 100644
>>>> --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
>>>> +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
>>>> @@ -88,6 +88,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
>>>>    		SKIP(return, "Subrange map is not supported");
>>>>    	if (ret == -ENOBUFS)
>>>>    		SKIP(return, "BAR is reserved");
>>>> +	if (ret == -ENOSPC)
>>>> +		SKIP(return, "Not enough ATU entries to allocate subrange");
>>>
>>> Thank you for handling this!
>>>
>>> pci_endpoint_test_bar_subrange() can also return -ENOSPC locally:
>>> https://github.com/torvalds/linux/blob/v7.0-rc4/drivers/misc/pci_endpoint_test.c#L538
>>> While that is a different resource limit case, I think it would still be
>>> reasonable to treat it as SKIP as well.
>>
>> Regarding Niklas's feedback to use the local EINVAL instead of ENOSPC in
>> pci_endpoint_test_bar_subrange(), I prefer to leave this for you to handle.
>> That will cover this case.
> 
> So could you consider the following tiny patch as a prerequisite for your
> series?
> https://lore.kernel.org/linux-pci/20260320140139.2415480-1-den@valinux.co.jp/

sure, thank you

> 
>>
>>>
>>> If you agree and keep your current approach, then I think the SKIP message
>>> might be better phrased more generically, e.g. "Insufficient resources".
>>
>> OK I agree, the error message should be less specific to DWC terminology,
>> even though this case can currently only occur on it.
> 
> Yes, I agree. As mentioned in my reply to Niklas, the other -ENOSPC is better
> replaced with -EINVAL, so I just submitted a tiny patch. That concern should be
> resolved.
> 
>>
>>>
>>> If you prefer to keep that local case as FAIL (or at least distinguish it
>>> with a different SKIP message), that would likely require a bit more
>>> changes overall. Note: Niklas' earlier feedback on the SKIP message would
>>> still apply.
>>
>> OK, as Niklas also suggested, I will not set an additional local bit besides
>> the fail bit. The question is whether we should name it SKIP or NOSPC. I
>> slightly prefer NOSPC, as this is what is used in the selftest to indicate
>> skipping.
> 
> Personally, Niklas' "errno in struct pci_epf_test_reg" idea sounds the best
> among the options discussed so far.

It is a good solution but does not match very well with the other 
existing API (See the STATUS_SRC/DST_ADDR_INVALID bits). Thus, we will 
keep the existing method of reporting errors using a second bit 
alongside the FAIL bit.


> 
> Best regards,
> Koichiro
> 
>>
>> thank you
>>
>> Christian
>>
>>>
>>> Best regards,
>>> Koichiro
>>>
>>>>    	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
>>>>    }
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>

