Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013044.outbound.protection.outlook.com [40.107.159.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D09358361;
	Tue, 17 Mar 2026 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743389; cv=fail; b=ujE2ucD7Dp0K+z/2bCfs73n1sNUVo4pOUPM4Z8UsOT+gPrWU/FFvx2v3pVgkf3BJVNiDxCHxc87Er9nfQtQru2JvrEimbaQPjrmfyWEfj1vd9RSLm68qx5pcPcOPZNTovoiIFHM2571M/yPjvg3KvDcmtxeaoB8VqW+2HYYuXTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743389; c=relaxed/simple;
	bh=zA9lltJaWMQPFaWQzRRnESE+B8F0ZUJSmbBRbf5LPyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bqZTLry54GcclG4vpw6fvGvj9EuRj8BiBMpQ4pG3RidkVviLM5Dr7kq89X7fwLnExksthVcCwyW2/TKIcDf4hqGPhfprfCRrEqMz/nqomh+2GHRNaSxSwdvKZx5qsUH6PvrcVv4gEEUfqyoXmVrIG/oMxE6V96JZrLSYh4Pn9tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LjXvPNlZ; arc=fail smtp.client-ip=40.107.159.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LjXvPNlZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfNs5QEmrlzAwr00ohPnCpQKsPpqFnltjC12o/OFU0PRAFE8e6rv2rKPKgfXu5bNhuDDe21LbA7hJpYn/9q8eMpS9smuOWE+iQAG0hLSiKVbrwbnpEk6HIOdzSTtUw8Vij0/zAC7Pu0e+h9pXaX7RBlnMNVGQ1KAvUrf/tUjY5PROobmDQnukMrdUz7xL/j/sRz4NXMbYpNwPATMZvkbDxxAiQzPX2N7v4Daqd+YMSYqeakDev3+vUTihvjl5l+/WRSDB/TrJ/sFCqcw+/Ntos31WTLj9eCllbgaSWNrnPjLcfaYNZHbp8B0+KAKbQK7cDiikwMBtPZlUNiXk/tl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyLeasf+qj0XLkVqmdk7gYEg2XfwNw6C8d62t4w+T4I=;
 b=xFbIPI5wteSwch/EIb3vVjNVunUSAVchowaByv5nWA3oYL3Xueg4+evZTIRIXz6eiGXSex6rQbDLbxYi9mT+Nt5GRXjMEb1jvfC3tIn2mFv4RPULqodaAIiSwMZ9XTcD7eGUEJo+Tb256aPRfQnufgYF/k+cHbTBUzZOINiNJZtmhaA7YC5/64/MHV+ImNfYC1xo2KR6ILIpGyf8hNXVy32gBI6VN8rn2YTFJk3WY2O93RIrXOhbnu0RGy6IgWTQcnzxsxL+OZ8L40WKgo7uRKxP9+yD9/olNmOn9NybSeGBL1omem4TrfcJX/nufnwmkVDnnBgCEFVqCdbDixCx5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyLeasf+qj0XLkVqmdk7gYEg2XfwNw6C8d62t4w+T4I=;
 b=LjXvPNlZDBLc9OT87Ww3JXpYOmwzgmsrNIEu6lD4vSs3G++afNemZj7zoz3soOcq1yIAuHhtlvPPyO83XVCRnVwwOnyrV1qEZpGbkfQqEBilBZhkaoAElqca6ackVGPAGKs3ddSUO8QiSvLYflK2tFuo30mO6L+p4D9ijRGQpxocZV1faXcEchYDK93tNVS7AnSP3zRp64U5jMy7y6qTSc8p9xdx61/S7IPldfFxBvrbkQYXTlL5O/xPAuOgdCZn53TOF84NYzPsdTIqh07X94EyLOHNyp+n8EIEYY7xTt5ERqkemLQj1O0q4nErvl6/EyI5yakbyXEA2+5+uDrbtA==
Received: from DB9PR02CA0002.eurprd02.prod.outlook.com (2603:10a6:10:1d9::7)
 by VI1PR10MB3198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:132::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 10:29:43 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::94) by DB9PR02CA0002.outlook.office365.com
 (2603:10a6:10:1d9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 10:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 10:29:43 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 11:32:16 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 11:29:42 +0100
Message-ID: <ee9b1b8e-4bc8-4fd3-932e-9b944516e114@foss.st.com>
Date: Tue, 17 Mar 2026 11:29:41 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
 <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com> <abkdu_7n_lePaTIY@ryzen>
 <c3039068-1868-4a08-bd0e-0a9e85b85943@foss.st.com>
 <c9278648-1ec1-419e-89ee-0868a4c7c86d@foss.st.com> <abkpFpD3cM_cI_nB@ryzen>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <abkpFpD3cM_cI_nB@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|VI1PR10MB3198:EE_
X-MS-Office365-Filtering-Correlation-Id: db4fa021-0afd-4b63-38b0-08de84101a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	htI6rPX5ZoE1WvEPFss3u04Qer2w32D965iK3rsYGirJ9Im1MRLRULkudusvp5kmaAJfucQzoEnwp9oMAtOgOAV6LqP3tfCli0Ff9N6BncB/HFAsb7BeTSTtV/zVOAfmX+CG/lZmFp1/ey6WCrMRdWGUuTpSL/u4zzZj0Yor9hF+bWAS+75uVuAS7flRrdqyFqZySn7/hNkB6l+Nd1RTiem2vUNJ1IT8UiM0RDLfUT2UL9vkdGjl0ou0Hj8gcUIH43Tt/cQg/yKbz8zD1msMnB8yq02NP3KQvs2sm2kIn02AEuBc+JIAakVaAZymtmCrc/eLbGwPaFWdKPj85TRq9lGR6zd6AN6PyJnQtSDdbY1rl4k8jJ1hvXwQaLHSiZ9w+5dKbjHo0kJCuZOT9Nka8IvcvnQTwj14yZtPdUlMwQkV4VOF7NVAr1Oxzc0ypUPKfcH4HxaJ0u0AhdMCddZea428ieW67J+fUPBUwSlQNeNK8IgVdLYUtf942deWzOwjKYpvcjODFmCihXj+7i7faZ7/EkLmDWzGJyIukAXDr+h/MhPFYiT3lY19C46lgPBqcUXqiOdt+Ycvh53689kDr2aqi4w5DmpbA6ZqiVzIRKM3B7nVJJ4ufJJ0iqsGwtcldaDfTZrHkxvnplenQB3GkH8tZ5c72EmxFtJS9hnCwQIoUR4oaO6+lD86mypkIB4HTDPPcyebdIZZM5KwGfSM6J3jGOPU9WhPNsM4kupz6MG2im2vIjIBPlAgQickNh2P/zaXweotNHpO0HJZIRLfrOlAPA1IxiG/jRNaLdnKcJ0=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XtR07qsv1gd/MVd3zIOzz4fIYtjSixHiDcfKp61CN0L1BknhkekdI2NHm64x3yQoHM6g9WTsZ9sf6v8xhExWGFKBSU2ui+FOTPpH/YWGTpCQ5hKg8Ukh7EkfuF2v4Bw7koqbUmBJuFKPw+T09dV2dr6VGuRh9cSAyWr8IVZ2idLS/7TXAdZad1rNNHLdgqNldkE+2asmQ08D9WZjBEKEmFWQ/oJV/IoVMv7SMfOdK2bRHz4bjLp5WvonD9eweKd2X646Y2OBH8yyW1jlWRZ9nLMDzVimMcYMSSWXQzP5DbPNKPKJ3vd7TQ4ldvUppq5ebUpvJV9OysjGLlcVbk9jnmIgranExEwp8zes54E9sAbRPkUpzykKm4fP7RTlVERy23s1r81CKp5V8XFvoEs6YXesW+0bGea8fdSfI49S3NLSqOfWmwLRVeK/y7RU1PbK
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 10:29:43.0849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db4fa021-0afd-4b63-38b0-08de84101a7e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3198



On 3/17/26 11:12, Niklas Cassel wrote:
> On Tue, Mar 17, 2026 at 11:01:28AM +0100, Christian Bruel wrote:
>>
>>
>>>
>>> So we will need to add a SKIP ENOSPC case in TEST_F(pci_ep_bar,
>>> BAR_SUBRANGE_TEST)
>>>
>> Re-checking this, no need for ENOSPC test. The real condition would be
>> EBUSY. Which can be handled nicely in a stm32 ep_map_addr helper.
> 
> Are you sure that it returns EBUSY and not ENOSPC?
> 
> I would have expected the error to be ENOSPC when there are no free inbound
> window:
> https://github.com/torvalds/linux/blob/v7.0-rc4/drivers/pci/controller/dwc/pcie-designware-ep.c#L307-L312

dw_pcie_ep_ib_atu_addr() returns ENOSPC. I was thinking to overload 
.set_bar with a stm32 helper to return EBUSY if the subrange bar is 
already reserved.

So whatever is best
  - modify TEST_F to SKIP if ENOSPC
or
  - Add a specific platform .set_bar helper to return EBUSY, already 
handled in the test.

thank you

Christian

> 
> 
> I think a SKIP ENOSPC case in TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST) in
> a better solution than modifying a STM32 specific helper.
> 
> Because the former will ensure that we skip/handle this issue on all SoCs
> with few inbound windows, not only on STM32.
> 
> 
> Kind regards,
> Niklas

