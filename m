Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34C36165D;
	Fri, 20 Mar 2026 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001077; cv=fail; b=JrMq2CJ2jnB/wekiWeTSD3rA7JYlJbQFne1YVs03w+bjFsyz0XYE+Ty3GTuGn039sA7douMWKGaKCMbJk7lv8ngvFAUNtnGWOnt0o82+r9unCY9x8VSHEq0pwPFLb2CsvBUvfRXUDK+VO2p++/h8jaEBWC2JzdzqyWrzfdhUh9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001077; c=relaxed/simple;
	bh=+nm5YslVN1aJGoZZPQjRZbNj0pLxLP1f+Ix7393bNI8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EcNdgBBorV3Hvjncjvck56QBvvtIV2WovgCuZb1b4hLojeUyweoh1euZ6dzDijOPmMkGWFyVMgfYSXEbkQxLLR4ha9WokAWWmNWNC/jlTFvf8lGtpWS1vwYq8N4tT7xhTjv4HZg602GdiCU4SkDHX1BvKqWkYhKsKnYp3QLlV0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NohLOrbD; arc=fail smtp.client-ip=52.101.69.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NohLOrbD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7JAjhMY61uXYmCanQ+VnTnB093G5OvuEyfUIKvp7OFF5wPogR3ZkmXzfeqA6a6Pth/RdBQ/3J9Syb6w/oACm1kw/jMBzvAgiRJnR/zm7dtWAVa2n9xjOMjARZmFEWWC6AethX5leYmCkvRskflvjS8g7ZfLhUrwS3236y6b/861MeeagSBge05i48xotlzRcuzNFH2pjUn/Esg6Aw9z05Gr3AeCu8TOUngS9fgh4W1MSeaIgoMeDQObxqp5kBowZawA/JZCymRzhntQHtGp4lXranFU8sw3GIkgStelrfhq8wL5n1DPo8F3va6XDDoi10tp12/6Io0rP3fQSvAePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QBNy2JLfBOEyQys0aqJmzMmMTtt7VDxz708zYN1f0k=;
 b=Ls1GvhAszcr+vSmUvuVD9OOeRyyeNnI/UFaLZVzUBtvSfHa+jBH8E7n9xI5cSWmugCikaFuzPpJuQKucX69ZXSsSMZUVEeiRPzMG+5VhjGFLRTxzNus7PVjTV6crKL9oVnkDllRr5FGYJdon0m5LLPa88wX2k44cT6IWEOnDbr5AU+Y64DWoVJnOU486Np6QKuj5Otc0XxjqdA4cSl/ZMtEs0tZWYuZl756iNOpets5VeTJOtsF5MFKDyiJCcdCPcdNwsQMor5ikgti1ofhkEj05exdtoc/xsbdnCBDrhsHNM7FmBmfjZ6iV5z/qdUNuSA0Jnq+Eib0wSLLFWsPsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=valinux.co.jp smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QBNy2JLfBOEyQys0aqJmzMmMTtt7VDxz708zYN1f0k=;
 b=NohLOrbDno38s1bQ5BzjCAutN2bLshPGU2TqB40E6iIBNQG7t0GgJPU26tp6Zq4d8yW25uUkhmQ1Tc3jNfAOlbVHFeHwh8xY9q2d0H9nzAOBTVViiEs4aAUw5HJooRsitqWiiIOHUQxwOatZKHt5aj7/ikpLFAirJtuYKd48ebSsGhHXDZxwAg1r7Nu/3yuwYYU/hDIVDot8hnQfPSFb0lWXNqpJ9y45eMAyl767uL3zIX7Ci1AI3W8oVj9Odo28m38G9z7GJ5UDMdYfvppo+7M/2rZaPfwRrIFb6CCiOA03j7ZeunfxAgibuto1rKbxjjVLj7SvDj7TRLqX67t3Ow==
Received: from PAZP264CA0171.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:236::33)
 by DB3PR10MB6907.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 10:04:31 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:102:236:cafe::91) by PAZP264CA0171.outlook.office365.com
 (2603:10a6:102:236::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 10:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Fri, 20 Mar 2026 10:04:31 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 20 Mar
 2026 11:06:50 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 20 Mar
 2026 11:04:30 +0100
Message-ID: <d3e8d869-1a10-4a50-a9ed-3c6bc10a6178@foss.st.com>
Date: Fri, 20 Mar 2026 11:04:28 +0100
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
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <vki7ty3z5jncmzeltk7udsbynffdld4xhcm3b2yjrgx25cfqkm@4ld66m3jbjqo>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F98:EE_|DB3PR10MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a30687-e8df-4ad9-5e47-08de86681497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|18002099003|56012099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	6apsNKiJ7XTGs2MIBSjF4T2y+C3HGWFG7htJbc5XQBue//mhXvldOUgqM4Okp7QqMcekzEsSpQDBvMdLMtGKFhfav8hIKbEFyPJtoy4TK1vQhbUtyWU+OkgoteDXYg8iyeESfKXeCz8ovYlAgufXeUg6sL70QsBxboDrNBk94842ZK/BZQLW0z63fIhsw8Y7UQLQoIM1EuwB0hudJeOvTJRjUIKx40kpU8QTlQN3cxMdpmblC6whERo+UZtcZ4oGA84VdahSn7fMFFioARJoeCb6usd09VAEFLdJuyyO1tzxeIH/IGB5vvLVJpEFDSNTTA9Sv8J4me2rZcKaoGBXf8yp7ApI1slXOP/skeLARgQPD/IW+QDw7q6QNZ2sE+ktDsCF/wicOMRR/fESMFOSD/xtiR8A4v7Epiqf9di9Je/E/2ErTM0wSbJhUF+yYKubaHvRStvZINHz9CFZNIUXWEmGpLJ5H/XiR9LEEDpKaBKn7KvYMYgq2D7TrUwtgD8B1Hu4Wg4gsLjyfpPRqAApvkO0W94fLNtnbZQXo99jJSJQ+VfPkgHWqlYaqvGbGmIFhFnxCtvhVw0QTvUGGGm0lqTlIs7MrOhDUZthq1QWFo/dtmNByRTwJ6jz6VhPiLqHLkoRikDVGlDxYtcJJYMnWJ3b+RkZx9vUEOSRtRutQtph3+Z7vKoroDzvBwCLInWiZXMhioec3ZbBNRYA2ij6SoViXVuAnxYBYpdU5ySSCKY=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	13PHM3Xn53yR0fJWrKPpPOWJUl2ZNdl4x8LM30cdl+Mbhy+bZg906O5lXWqLGGfwmEuoglZE3eIWbknX/BwVMaNWfM+gZmQl/XwYd7m5ZQQOSFRRxs2U1Q4llmLmHb3N3QMkd+wgO0H223IfhwWIVZUYY82WhZOpdcJjb72zugyhPPHH/tqgck2W8kGUEN6y3RIHrqWvCeGT14VES52hucKtNNZqNoLIEygzZ1ybhivi7uOEd/vbz8ifKK39qsY72TcT5fPQWPWxMORogLMYK8H6dTj53ktkOUtR3tOyZKOA3/6C5lXBFiFXaMitCU3A20V2ii8qrWBYrywh/nwD4ttLz35JTvDgN/YFKCXHALAEI33aCm/oCeymGiXokucw5iqZRJbR9jjQZ61qCwPX/EiMW8TizcURdBzhgRsYxCGZuQntkzyUX+03TaEY8mEO
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 10:04:31.2502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a30687-e8df-4ad9-5e47-08de86681497
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6907

Hello Koichiro, thank you for your comment

On 3/19/26 02:28, Koichiro Den wrote:
> On Wed, Mar 18, 2026 at 03:46:27PM +0100, Christian Bruel wrote:
>> Handle -ENOSPC error. If the number of available inbound ATU entries is
>> insufficient to map the subrange, skip the test instead of failing.
>>
>> Link: https://lore.kernel.org/linux-pci/20260317152707.GA85951@bhelgaas/T/#m87e4c24173097a0ea70195b71aab294ad8d6c283
>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>> ---
>>   tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
>> index c417fb3a198b2d92c3060938c23807cc8bea5573..8ea2fda4539d11eb22b22800a7cb8bbaa99c91ba 100644
>> --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
>> +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
>> @@ -88,6 +88,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
>>   		SKIP(return, "Subrange map is not supported");
>>   	if (ret == -ENOBUFS)
>>   		SKIP(return, "BAR is reserved");
>> +	if (ret == -ENOSPC)
>> +		SKIP(return, "Not enough ATU entries to allocate subrange");
> 
> Thank you for handling this!
> 
> pci_endpoint_test_bar_subrange() can also return -ENOSPC locally:
> https://github.com/torvalds/linux/blob/v7.0-rc4/drivers/misc/pci_endpoint_test.c#L538
> While that is a different resource limit case, I think it would still be
> reasonable to treat it as SKIP as well.

Regarding Niklas's feedback to use the local EINVAL instead of ENOSPC in 
pci_endpoint_test_bar_subrange(), I prefer to leave this for you to 
handle. That will cover this case.

> 
> If you agree and keep your current approach, then I think the SKIP message
> might be better phrased more generically, e.g. "Insufficient resources".

OK I agree, the error message should be less specific to DWC 
terminology, even though this case can currently only occur on it.

> 
> If you prefer to keep that local case as FAIL (or at least distinguish it
> with a different SKIP message), that would likely require a bit more
> changes overall. Note: Niklas' earlier feedback on the SKIP message would
> still apply.

OK, as Niklas also suggested, I will not set an additional local bit 
besides the fail bit. The question is whether we should name it SKIP or 
NOSPC. I slightly prefer NOSPC, as this is what is used in the selftest 
to indicate skipping.

thank you

Christian

> 
> Best regards,
> Koichiro
> 
>>   	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
>>   }
>>   
>>
>> -- 
>> 2.34.1
>>

