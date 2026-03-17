Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17135838B;
	Tue, 17 Mar 2026 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741752; cv=fail; b=kltRCy9i5ODleB/0O/nxJnqnJunA2c3x9StUAgUWBzdtU5PecKU0ROtEMtbbJQkIu/R561n3BlCoBoX1RnJHY7IcJL2bIQYFiwCXmkGVg2r5XRR/VRcLjlI3biBR/RAoPGRXPwRHR/B3ZdpwF/xx64xnlq9EH0p1JG3CLgi2ybw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741752; c=relaxed/simple;
	bh=EUPrKx0RbMUiD/lzuSHR6wMPyQLd2P8V+d2xaxWKppc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NhrhMpP5zww8q9B8AqpTCgB1PNRLsXmDB7jt7QqohHB3iItsVVP8El1FqgPnzbGGauss99dOSr9eyQpYKLdO/DqDCAfhULBtdsqcvAp/ULdNQIjSlZRKgqCm0Sk4ja8GRGJ2TYZzVVYX9EN/JN5knp1F6bhABTEozB+5sAde6qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JRM269FP; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JRM269FP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YN+6c6IuuLZQmuAZZpIFKJC6wdNcVnfxhSsRvoaH6X9LNjjmI0vwRvNAZktCS1waPJ2FSCCz9H+JnAWmjDkGAYyEiwg1JMxTybGz+LJEAI6PRYQHjzBA49qd9CZfBDCgGzs8HkONzikjP448SBPxY5e2dIEF38ZAY4lDW95NscgvgQ8JLmLO762HPemRymvTr4fLNkbMsZJ8F6ra5eC0RyFwUENUrBSuVjgrhseUQ6x1A1aaCjJtj8WIPVtJ5kFRMH9SIcdY3cwLoBhwSalduomWM9phqJuBM0urFwlIhhLXvT+ZSmkLz8MS46zQGO3g859OZDvfoTzNcjBwmLbp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkGR2JQSexq5Gu4S8D3XgvH5cDS6iTuYl3MFkjPHDXU=;
 b=T+DDhrT5NlCArOq7ryrI5aEE8UNDRrF6YnAvf4vAcKQWjQjX21PmytNXW+N3j5rKBNm/FBHsFbhbwFMrFp1+cLihcE4GcIoHZpnnyVb4kwxtpI0GtKrGSSHta+CRZOeupLc8RX5dCsFYrUSqYi+o0tQ6h3kW7mf0fGh+tcMEIO97lwLcSHe5OdXvTKTSmK5PP+nrxd489LGU6OKywla5frkhzN/ObTqun1lUMwdZlx2tKQW5m0GqjZ+PF87uQvgYacDMTqEGaQBE3wqT0Pjk8gg6CXxL+yalC0IE3C3xNG3jcHH4HomA8pTFhRa1u8oNKR9u9KlZT6PFcayr7fhBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkGR2JQSexq5Gu4S8D3XgvH5cDS6iTuYl3MFkjPHDXU=;
 b=JRM269FPTpqSZhsGoHmzNGD0I9ku7077ftedUramcLtgdt0NbBM2F/sgp6TxfFjITcepfNl8buxTQnzatduSq0zQdZzMm0rtW29N2EIc/36s5HI2WbuAyv+SNpm6/IHOshk5xAmoFc2eWz3yTwCSG2KvxT2KrzAIwvQfx6CRuFodXxEN5Qc3TZefaXcT6zaUUWSvJIKLTpk3SwvGtqcpAwkcbHz9KATTcTlfVApWYiUDcz+Cpq7YY3A4zuH0lquku+ZBgpHifD5muf1M+g880cjS1w0aTLCG9Xo5b8xEHMlFi4HjCkvMk9Ay0LyOJ6NP2SJKOWZWp7Y2+i579lAk8Q==
Received: from AS9PR04CA0119.eurprd04.prod.outlook.com (2603:10a6:20b:531::15)
 by PA2PR10MB8963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:414::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 10:02:24 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:20b:531:cafe::d9) by AS9PR04CA0119.outlook.office365.com
 (2603:10a6:20b:531::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 10:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 10:02:23 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 11:04:40 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 11:02:21 +0100
Message-ID: <b7482e05-1d3e-4dff-85ca-cf3da7398087@foss.st.com>
Date: Tue, 17 Mar 2026 11:02:21 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	"Bjorn Helgaas" <helgaas@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, "Frank
 Li" <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Bhanu Seshu Kumar Valluri
	<bhanuseshukumar@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
 <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com>
 <rkjsd37e7nmtx3qgwjbostbabknrjtw5cc2pnmzjnwaycw57vp@l3rasonrifwv>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <rkjsd37e7nmtx3qgwjbostbabknrjtw5cc2pnmzjnwaycw57vp@l3rasonrifwv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000044:EE_|PA2PR10MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd7a6f8-9005-47a4-d6e1-08de840c48f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|7416014|82310400026|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	XFxpQEXaWXJnP74oce1+Ts/Y2Y2iGbWsY93o+7IYeRAMsvpDk/lhV+7Hz11aQN8QjbixvKRT5ZAbqrbQhCMjH+zr9/WyTr0rMqHeudO/Vw7+CWe0kAilDMbRDKKkiaQoWptwxlcwhQDqd6H5r1t3GaqCwBDns2BsRsCNZ+/Op8Nha26YBqDP11J3WrnyNSqPNMXMzVvs6/VVTmR+fHoiQynGm/a08QHl2WiVn89v3kHNxPWK5Z+zDLIoLcWUiZGyWN1TIveOTleRAsR9UETzHPoeRa/aXk5uvdGBQSKs+LRB4yoYvpoeP7EjXz8W+ffEs6gDXpQvMA9pBsyJHiysQsCjsElPS9VAnkeeKsln9x08YmZnhTwaSPeiUKfLCu3RqsP9LWIKT8JyTE2tsFjV/g7AjYGYwwlAwYp4xMuIIGDvGGnrs0Yaj9gGOtUFC7lbDPIv3rtR1OMGQYhDGzh70unQ4Iblgz+KWDd5Dv+T5hVOdU/bBGeV+PhblSCcLbpmvrS0Ahl5ti99JT/1UO2qa5NNTDqCCTr7DAN8pgx/t24JeAshsG192kFR6Ig4/5z4qVW7KKSEiGydxpIYwwGfTeLnlWupWbm5oePwKqfj+dCDqn/XTGwP2wDWWsPPeZ2pku+tDm3AkJTESVrmpOLUqfiNTQFrR1EqTBrMqvTKvRJYRdXWP0Y6EkH5twsFpK2ypTVtZBCjbwbH3WLZBi+1lWsj1RcCx7Q7i+smhdcdlpPBK/M/4HzVi3QnWpqX+e/xgVVd5VTiAhw+ByTZvaEvFA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(7416014)(82310400026)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lH1YyHlDvsF5df5d29C2YYr17tinIVobIWOZOL2nQW4g3CvVkfOgtIcHGoK05eKLFXUEBKZI3Wm2JbdVhOKlJ2zeVi79lJoxjecwQlVPwdSP5ndRKfkDC3YR1+RwhV8QGuhzuJDYfW5vX+ZXZjT5QS16VidEKzgmGhKFgZShxp3zi7+XwhqHXzx9uGjyiHkMprDWCE3KRIj9yqtF3PwihwHVIPoM/jJ0jfwcSYigFX5z6wqKtcYdlOjAQpKp41894wEW5bbEuRzZjVoxHNvWTJobXPQsxPcSa7pJrr66CmMl/AxszCWrR9dyEudYp3pqCeEPUs7XwTwgQkBK+VSRDveogY6ig9y5sPvCBJq6yqfxFi2sd8Q/uM7i39TVCGDgIOFBc1/p4REr1n0FNLvptrUOEq5atZAFbRkioW201EpX8N3gRrr8Y+SNvX30t6uf
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 10:02:23.0583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd7a6f8-9005-47a4-d6e1-08de840c48f0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8963



On 3/17/26 10:59, Manivannan Sadhasivam wrote:
> On Tue, Mar 17, 2026 at 10:13:52AM +0100, Christian Bruel wrote:
>>
>>
>> On 3/17/26 03:57, Koichiro Den wrote:
>>> On Mon, Mar 16, 2026 at 05:19:26PM +0100, Niklas Cassel wrote:
>>>> On Mon, Mar 16, 2026 at 11:02:25PM +0900, Koichiro Den wrote:
>>>>> When the BAR subrange mapping test on DWC-based platforms fails due to
>>>>> insufficient free inbound iATU regions,
>>>>> pci_epf_test_bar_subrange_setup() returns an error (-ENOSPC) but does
>>>>> not restore the original BAR mapping. This causes subsequent test runs
>>>>> to become confusing, since the failure may leave room for the next
>>>>> subrange mapping test to pass.
>>>>>
>>>>> Fix this by restoring the original BAR mapping when preparation of the
>>>>> subrange mapping fails, so that no side effect remains regardless of the
>>>>> test success or failure.
>>>>>
>>>>> Fixes: 6c5e6101423b ("PCI: endpoint: pci-epf-test: Add BAR subrange mapping test support")
>>>>> Reported-by: Christian Bruel <christian.bruel@foss.st.com>
>>>>> Closes: https://lore.kernel.org/linux-pci/b2b03ebe-9482-4a13-b22f-7b44da096eed@foss.st.com/
>>>>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>>>>> ---
>>>>>    drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++++
>>>>>    1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>>>>> index 14e61ebe1f11..f44c36f5cac5 100644
>>>>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>>>>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>>>>> @@ -898,16 +898,22 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
>>>>>    	bar->submap = submap;
>>>>>    	bar->num_submap = nsub;
>>>>>    	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
>>>>>    	if (ret) {
>>>>>    		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
>>>>>    		bar->submap = old_submap;
>>>>>    		bar->num_submap = old_nsub;
>>>>> +		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
>>>>> +		if (ret)
>>>>> +			dev_warn(&epf->dev,
>>>>> +				 "failed to restore the original BAR mapping: %d\n",
>>>>
>>>> Nit:
>>>> I would use a capitalized F:
>>>> "Failed to restore ..."
>>>>
>>>> in order to match most other prints in this file.
>>>
>>> Agree. Bjorn or Mani, please feel free to fix this up (i.e. s/failed/Failed/)
>>> when applying, to avoid a respin for such a minor change.
>>>
>>>>
>>>> Reviewed-by: Niklas Cassel <cassel@kernel.org>
>>>
>>> Thanks again for reviewing, Niklas.
>>>
>>> Christian, if possible, it would be very helpful if you could take a look or
>>> test this slightly polished version and add a Tested-by or Reviewed-by.
>>
>> Tested-by: Christian Bruel <christian.bruel@foss.st.com>
>>
>> with the DISABLE BAR dependency
>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint&id=33642e9e36dc084e4fc9245a266c9843bc8303b9
>>
> 
> Why is this dependency?

no not needed, sorry. will be handler in the stm32 part.

> 
> - Mani
> 

