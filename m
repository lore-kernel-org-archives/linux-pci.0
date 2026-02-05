Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA535CBAF;
	Thu,  5 Feb 2026 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289138; cv=fail; b=lukL3ApNk0iDpKk88y7NYR0oC4r4g8MD8nS3uok/aRMglgmF+a4y5ZaPRiwhteOu6ZZ3eEL2m54Q6DzYA+BbyOAQB/ZDNPHeveIW1ZlEi7bbXTlqC+FCQuLbFs1GJymSKUgE2WIw28qitj2KUMVDnwKvaxhECjGH49wXO3SVOQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289138; c=relaxed/simple;
	bh=dWVw4Ns41ZFsxVLijLHSwZ6CsJ4FylSqzYgxetBEIeE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kZ8e4Od/tSArh70L7rrxqpzvVtZkQubkZiWAOJzmRTcX9W5pNwXHjIzyiZuDwMygEXHSbi3d41l2rjmcOaocwb3a5nln4GV4Il75rYwX9i2jEg/6Vxol2k90mDQU1bJxNKa/KUVkTvhbn1mPPjMjTP2zbQXSufZRCLh4WTT9ni0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LCYGQARn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kT6dhwUX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LCYGQARn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kT6dhwUX"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614Mi60h1789559;
	Thu, 5 Feb 2026 10:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lABY76DTVe9WbAeHNuOG+bcLGUQLd2lYCuagse9abYI=; b=
	LCYGQARnrLmZW1yDhcgkCPph+3BdAmZDlUyCeZ9BORFeOD2U5ZIK95DvGNlrJfWW
	d/LFTUdq0e4Kk4MsLbmdEDv5N+j0QvsnxD7pRuQmtuRa/xIzsEUbB2vEGBQpiIeH
	oN9xp5vLdLz7E81TuT/RtxOtc1rPzLTa9M39KsetSGYPckeRpZjrHcyBc0PoCUAL
	vlfc1WZJ2wboXoZX/judNWSlJvDD9VYcZptnIqg1ud8Ounxjvoirip0d2wEPcsDx
	5dAJjrHhaq5Nwz0VT836CRNjS4PCOJ0UZkIIqJIR/2WlXJ/1rA13UiZ3v+eO2K1M
	zm5RaksggByVlhch68yDqw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3j8ukjp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 10:58:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6159MMuc001228;
	Thu, 5 Feb 2026 10:58:35 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186d08k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 10:58:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pp0Nes2FsqxMBtIRRbfQ1InvUIBmkzrdwI7urv/ynxCzOI+6vZQxkQ7npl5CsM+OVLqDZEqYfk8ZKlKURurb6sGrfczSKFrZG56NwX8nle91FsUR5m7pGYTey+VSpGre2kCNkXdz1Ko+3WdY9qDiimdTEOCLGxkdf7mSDPA8iqxNgmgNPoyhzu/fWIYytlpu0opUFxMw05k6PVHVYk8CaNEQtSZmgvG0oLGmkexs5d2jjfkEiiYDXIjdydD2w7I7QjdOHtQW0mGJbHZ3gzzvnWKk01nS0Wp/UWddGPD3dJMB2VJm7i7df4Tj2GpzgXXF4TWM/JutwFqxjVKrJC3djw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lABY76DTVe9WbAeHNuOG+bcLGUQLd2lYCuagse9abYI=;
 b=fv/Fi7oKRVlsT4bQlZUqu0JrPx/JV0eIDm6TtVBn4Z0zKHwQn7UzmZt8+g+XTpKzigOJPyD2tmqUdjdH3hod0JBR/nUJh1fBeA5LCaFikaNl0unl20UiakVEdlFBkXjEJbz40AsRqfjsMTetN1n/mu9mNgRq/vHKbehDmy/XhPcGifDphXDSpgHZ5ej468bcgUn4Aqi6byXW7sNwqs3ewZQs8Xvr8DZzOIXsccNvQ0hrAq80XD0RgoARu8xTbcbeevsV0NCHge74b03h5hlICDtHPyx+uOC5uyRaHdupr0jz/AZPs7YrO+ObuE8viuXrjzVD7C/3hgl4a3R7uyiSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lABY76DTVe9WbAeHNuOG+bcLGUQLd2lYCuagse9abYI=;
 b=kT6dhwUXYSfRTevZK3F+jnAKJ0cAf2N9mTprFgVHbNQD1xPs8C1b73Wg2uSR7dw1yJJe09HAoxOBcq/gYDuoKJvHLasW0WXXN2TctE+AYGzH9fZ2ci2QM79hDnxLbGu2nYWn3xAhyIA3+7At2tDeeZ8cNQKDN6y0x2qeeTYFI7c=
Received: from BLAPR10MB5315.namprd10.prod.outlook.com (2603:10b6:208:324::8)
 by DM3PPFEC98198CD.namprd10.prod.outlook.com (2603:10b6:f:fc00::c55) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 10:58:07 +0000
Received: from BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::b110:3df0:e927:dd53]) by BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::b110:3df0:e927:dd53%4]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 10:58:07 +0000
Message-ID: <15cb1eb4-3e9b-4495-ba00-cce10a10cf7b@oracle.com>
Date: Thu, 5 Feb 2026 16:27:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v2 3/3] PCI: Bail out early for 2.5GT/s
 devices in PCIe failed link retraining
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew W Carlis <mattc@purestorage.com>
Cc: ashishk@purestorage.com, msaggi@purestorage.com, sconnor@purestorage.com,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        Jiwei <jiwei.sun.bj@qq.com>, guojinhui.liam@bytedance.com,
        ahuang12@lenovo.com, sunjw10@lenovo.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>
 <alpine.DEB.2.21.2512080356070.49654@angie.orcam.me.uk>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <alpine.DEB.2.21.2512080356070.49654@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::7) To BLAPR10MB5315.namprd10.prod.outlook.com
 (2603:10b6:208:324::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5315:EE_|DM3PPFEC98198CD:EE_
X-MS-Office365-Filtering-Correlation-Id: b913df03-2d95-4dbb-4832-08de64a57156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlNsbmhjeFQyZnB1N1kyR3M4c0NGcyt2VTV5ZnJWTlBDSmc1MHFaa1YyeTV6?=
 =?utf-8?B?RFMyamlCQzFmSDRrdmV6NDcvYmtXd29sMXluU2xha0phU2NBb3huanE3NVNn?=
 =?utf-8?B?MXBKY01QeUFHWGtRWFU5aEZXTW1weUhHS09pOUJFYk85elkzOVdXZVNTa2sv?=
 =?utf-8?B?c3FsYTJKaGQrZ0YxcXljRy9EZDdWMExWSlB6QWMxRE8yVGk3ZS84TW1uOWlK?=
 =?utf-8?B?ZGQwbzR6VTZNNFcyelJKZzBpc3NabW9lTUNHeWNwYkxCUFVyOGdzV1NEQ0NB?=
 =?utf-8?B?WXJodmttRXN2aUhDV1dNQjE3SHlNKy9wb2VjRXd1ekMvSXpidXhxQjB1aFFz?=
 =?utf-8?B?Z3hrNHF3KzdNNkx4TXRlUW56bmFwVDF0VmNvQ2s0bU5kd0FxMjVINjlFYnV6?=
 =?utf-8?B?WGdxR0loSEM5eTNSRjJReDI3ZkQxQmg0ME5mWFRNV25UajBlUjdzbUYvenZp?=
 =?utf-8?B?MFNHZ3g3QjMxNzk3bmFOUmFJRkNQa3lKZjFqL0MzVG1GNVdhdkdDWkoya2Ez?=
 =?utf-8?B?YmNORzRZMTFEd0gzNkEwWnkrSEQ3N05paTBhT1M2TWlFbVBWRHZRQktMcWdv?=
 =?utf-8?B?TlVwNmN0S3pMWVUxL1o5cW5FUHdiK2o5L2NjY0p0R2xBSXg4MmlUaEE0MDVm?=
 =?utf-8?B?MG1oY2RrL0NETi9TNVJCa241YXhDdlBiZldDcUY1OWQ0T24vbWNlU05WL2s5?=
 =?utf-8?B?WEt1dTk3eEhwZlZsWWJqcFZzeCtteitOdWtOdFU2dTBrMmNYYUxWS1Y5RUpM?=
 =?utf-8?B?U0UxWk44WlljQzdySHpHbmdOQWhGck5KSldPWEdhVkVXSEt3SnVxK3luSTN5?=
 =?utf-8?B?OXAxUkQxZjVhLzRDcWpMV1BMMkd6aXE2S2lpRGdIK21sWisrN1dDeWZPaDNP?=
 =?utf-8?B?VHRKdG00V0w3Tk9rWHhDTy8vc243LzdLcjBGemtnMlZ1Q3RqVW8ycDBjU1Zq?=
 =?utf-8?B?RytMRllIc09nUXkxeGVjRmEyNlI1RGVULzYvVVVTYVpyancxSzNMem1QK3Bw?=
 =?utf-8?B?SHZVV3JGZzcweHUrSlNxZWgxdEhFZTdwQlhpdjlQT3YxdmFRQ3lDcllsR1dx?=
 =?utf-8?B?b0FrWkg4ZzVjN1pQankrakVoK2Z3TjZMYzh3SHVoM0tiUEU3M05mQWZxYkN3?=
 =?utf-8?B?ZDFsRGVJVjE5NU1xVmdGWFMvQVhtcHBJMTlNMmtKekVJeFI4czdyYkZRUFdn?=
 =?utf-8?B?ZHUzZko3OXg1YnNKSlQxRjlyVjI2azVUSlkrMUM4RzIrckUrS01uZkl2dDBi?=
 =?utf-8?B?eXF3OEh2MGFKSUUxdXd1WllDUzFVZEpNazE5dzVkWlZVNnNlc3dXenJSdEZE?=
 =?utf-8?B?dUJIUkJBeEhnV25iajFvcnE0NmNpMGJmdFQrd1Baa05MRjlkcTFqNEZYRWlR?=
 =?utf-8?B?KzRXYzMvWVZzZGtHc09lSDYzVWpXd0tqRG9VTWdab21OVDFYUWtXeWFJYzBG?=
 =?utf-8?B?eTh2WGh4ZW5KZW0zelZUTmxTQVdJTFJmZHEyT0I3SmhtMjBLLytHemxaOUQx?=
 =?utf-8?B?L1dXU0p2SlFUYWhMZ2g5eGNyUjNlQlVnOEplOUxyTGdUK01HV0RSK3oraHlC?=
 =?utf-8?B?cWwrQys1UkZ3UGR3eDhFQVlITTAvUXFabGdaMU1RU1lQdHpGbHRHOU5LV0NB?=
 =?utf-8?B?UzdRZUdWNU9yeUo5dG5hNEFWTG5FZzlGRFFoT0Izc2ZuQzZsekcyUDZqRWJn?=
 =?utf-8?B?M1VwcitpN2krQ3JGbWNTTUhieXlpYmZYMkc3djN2MHRQSjRPdmJrbFV4dTZ4?=
 =?utf-8?B?WXJZWEhvZnluUlNEYW1LeU5KK0laSWJqbnJ5VFpYNzhDVHhISFUwTWErRElL?=
 =?utf-8?B?QUNqQ2JXbEtlVHF4U1plVkp2NFZoSU8zcWZvdnlCMlo4dWlKR2crMU1HMUc3?=
 =?utf-8?B?ZjRkd0lCRnRzcWZBbVFiZFQ1Y2V4OGZyZzhHNTg0VkYrblhDTDdlVFFWSnpY?=
 =?utf-8?B?dDNRcmI5SU4vUmhZY09JbjNSUWhWZ2hoREhSbEU1TEd3cm83V09VNktudWFQ?=
 =?utf-8?B?bTRpZm51d054d1B3VDJMazdkaS8vc1V6YnY1bUlmTGw2ZjUwWUI4NWdyRHIy?=
 =?utf-8?B?Qkp1TGljZnhaRDFEazFESS93WFFNdHF3NHhBWG96UHdIVXlhMkpHKzJWZzk1?=
 =?utf-8?Q?leMk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5315.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm10SllrdlY5OHJkblpjWXlhVmwzeER1T09wMUpJK3JaeWxjNGpIa0w4Qmcy?=
 =?utf-8?B?K01ZN1dtV3R3Z2ZJdDBCSXhaeWltQllLRktoTnJZVGtkViszbWoxejBEamlO?=
 =?utf-8?B?cEZFNFg4VTRKbGFlL3hEMkxrTmlNSW5FNmEwTTh0b3EvLyt2bW5BSmxmWHU1?=
 =?utf-8?B?bFMwUnB6VnBXN2ovNVJYR29JVFZlK21qRU5wQkswc1JsQ0x4b0xhajRLUit1?=
 =?utf-8?B?MkZyTm1Vc3llSDBDQlcyYnBLZ1Jua2lqU0o5TDJZYlIvZWluSlRtd3RSQW5z?=
 =?utf-8?B?bHBxRFZtY25WeHZNZ0RITkIzR3FVTGh5azhnWXEyKzFMUnV3Vm5iVWUyeXpY?=
 =?utf-8?B?d1ByOHJXbDJzd01pTnpFOUxrTTJ6WUhvb0oyVFRSVWZNMVZqejFVRHFRZk9I?=
 =?utf-8?B?UVhUUlVPZHJIVEl4TndTS2ZJaUMwdjQ2YWtDWTZLMnJQSEhSa1R0eEJ6dk1B?=
 =?utf-8?B?OEdQSUxIRE5SS2Z4UTZlOVhlYXJpWlhrTzZ0WXVpTkRpZ0Z6UEdNaVRTd2hW?=
 =?utf-8?B?KzZ2OFEzUUN6aktQV09PLzhwdXk2QmNzcFBneFNiREdrS0czYlFNRWlYUEcv?=
 =?utf-8?B?VFFNbmkrUkVjMVhmRHBaUXYrNDAyMnhCdTdUa0JhYVovMUMyMjVRMStzRjlw?=
 =?utf-8?B?UnVqY3JHWDRtTnpEMFhJWHE5Vk9NN0JWaStvRDBJS2N2UVRDK3NKVEhRS2k0?=
 =?utf-8?B?S0pkOU9SNG1jZU9QdjA3ZERkaFNGeVg0Qm5ab1ZSZEpHeFgrTStKNG9aRkVX?=
 =?utf-8?B?dXpVazhFTWM3citoRWE1TFJwakh6MmVRVWxIUHo1bis1N0hDcmswaS9mSDBx?=
 =?utf-8?B?SUw1M21wNjJkaGJ0NHV3QS9UelNacUNZNUpjd0xlbDhBMHZ1WVA4MXBsSjAv?=
 =?utf-8?B?UE1JRU9YOENWMGx2ZFRDSVVmeGhkOXFGL3BQMXNIeExBajJDUmlVOCtvVGNU?=
 =?utf-8?B?SUQ1bmw2L01XZ1IvMllqcWcwcElsUmE4VEhGMDQ2WWx6emk5OU1OMC90YjdY?=
 =?utf-8?B?YUx6YUJnOEN0QU5rbVd6VkdJS2ViN0FvQWRrRDF0SC94YW1DZXNxZHZsQ1Za?=
 =?utf-8?B?bXNTNWpoSE54NHQ4N1FPanEvQUhPTkNnTEsrTXRlRUNRS3o0SHRSR3dtRnpz?=
 =?utf-8?B?ZXhBRFRySHlXekhOQlBQSUhraDJrRkNNNkNKa0FOTlR4eGhHdVhXVDNOU3pE?=
 =?utf-8?B?WkJVYWcyUVZNVGoySExFL0YzS0hSNW5naEF6SnF6T2dLRVJ6SWpzQUt5N0RB?=
 =?utf-8?B?ZVF6OE9KdFhtQ3Vja0MrSTN1bVJWZGZiclRmVWp6eWVRZEtjOEhyMFV5VVdX?=
 =?utf-8?B?dzMyK0Z4RFdkTGRPVXp2QWYyYmJYdUUva1VMNDZyb3JKWjUxS3FtMzFlQzd5?=
 =?utf-8?B?RFdwRlhrZE0xWEhxZktKbFN3bndSRjRibU1sUGVEK25QcjYrbTh0aWQyaURW?=
 =?utf-8?B?WDlsVnpvRURIZ3gyc25GeGU3N3lkT2FTRFhCZW5Jc3N0YnIrZmNKdGdDSFV0?=
 =?utf-8?B?QUJwVVVCaHNjdFpZdGdkckt0eWY5YUtsSU9FQXRvNTBhc1hJWkNjWTJ0NWk3?=
 =?utf-8?B?OUhwYU9aTG15Ym1PYXZZODN1a29mWUpVZjdBU2hyRnMzTnR0WG9XQzRYRHFW?=
 =?utf-8?B?cU1veWRLaHB1MW1JaDRyWTd4ZEJtVXY5QlVNa3BsZldNQ0h0SFgvUlB4UVJu?=
 =?utf-8?B?MGVvVlZqSmtpbHhYWThaQmZaRjFtOW01cHFUeTBBWEtrOXhZNWdEckRRQmMx?=
 =?utf-8?B?S1hNR3dFdDZOSThjN3FhbU85eTlBeHJFSXhRT0RwSnlKZVBYVlE4Qi9STEJC?=
 =?utf-8?B?eDhsUmVIK1dFc3JMWjJtMFhSM1FHdGY3ZXFiRXFKTjdCVks4aG5IN1FEM0cx?=
 =?utf-8?B?WlZzNjdGQU5ESWs1VkRFQWM0ZzZoZ1FrNEl4UzdzM0pEN05SWFF1K0ZZTzVx?=
 =?utf-8?B?M21aNTIwd1psL0V1TlN4T3BCSFpidTAwNVdSQmZyclJVbGhKTUZUb3hnRzVx?=
 =?utf-8?B?d0lCUGVwTlBtODVMaThkOWgrdGJHc05kZkxLRzRRZklhQU5zSlR3cGhlMEFs?=
 =?utf-8?B?MEFXLy8zRFg5UkZQb09UaUhFQ3hMWWNJT2JTZHIzbDIxMmlsN3owRjl3WVBj?=
 =?utf-8?B?ZFFsenVrV2hhaDNSMFVJcTkwa2w0N21INldjRGVKWkUxY1ZyaHpaU0l2R0tF?=
 =?utf-8?B?S0JGK3h4enZmVENNM0xBOTdta1F2dmE3UDB6VVVTZzJJbjRkQWVFdWRSUUQ5?=
 =?utf-8?B?K1h3RWJjM2xURFZCLy9CSDNvR3lRUHRjWThTSVhXSVFRb1FWK0FuV0I5bmEy?=
 =?utf-8?B?RHBsbGp0TzBmcm1SN0ZuNVpFaEtEVFBMbGNEWkRPYVZnRmJKTzdLZUVpbVlP?=
 =?utf-8?Q?+A0eqUeU2BVptLYc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x3nElvgBJ1q96vRpoAkHhNwXidWVgMl5zHdY6Nq8dHfOTGT+Y3lBBZov0LTx6mF65Netr9MOOzpNIVaUaly6P9xuzuVcVP9Y0kafUaMfLxZCyrhx6ZicHK/FKsLQBv40j2QuUkbJCpuRLJdGCMwK5JJGcA+yJDMtR0IBzjG8x7FS3nFegSy4t70tF/U84vfXw//loV71GlLt3hXmPKsZ2+DaLe9UUwazoXcskU33MXvi/JJmiLevKXrR7sPgNvdJpe/tC/mPytTVEV6eKyDgCRQ6cm3ES18g9B43jQO8PDi3ewP0D03rpbuxCI2uAf+AKk8LWPKyguYl6BIdauG1Ry1dN4Vgs1eS47dCpOzn1+jgzzwB12pHk+j6sGASsKbPAS1aWIqF5tCfTCVqeROX2zA0l5y/G1Zzo7ifraYBMUbNyC7gYMeyoWhIf+Me98gywL1uDnfnWtd1uOJS1PklwAxJoM3R/tZjJwngW6K2cVBZxQKo+xuauP3SfDA7Er1kO1+T4D7O/37eZUmib2zRr6iA/xVyKLgAjNzzz/mwmzBac8rGiKA9OlaK758jxVq7kVVvSXs+rfOYxXLXfq1MUoYxUM0lCwJPmzJk8Z8bUUk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b913df03-2d95-4dbb-4832-08de64a57156
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5315.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 10:58:07.0512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5HS6YoktdNvGWiHiuJvCT3dxKbFR/d3OspFA2jUfd+NcqJtyNbC3xFqlIL+BI1Ly9Kpy2qT9PzrMFEOu/5FIW4ZWILtk/zOA9n2FrhyGWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEC98198CD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050081
X-Proofpoint-GUID: ISMpe0aYYaSeQTRZRTfBRcGBaxvesjkl
X-Proofpoint-ORIG-GUID: ISMpe0aYYaSeQTRZRTfBRcGBaxvesjkl
X-Authority-Analysis: v=2.4 cv=BJS+bVQG c=1 sm=1 tr=0 ts=698477dc cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=BcPKCTjPAAAA:8 a=yPCof4ZbAAAA:8 a=FZHLa229W89V3RVqV5sA:9 a=QEXdDO2ut3YA:10
 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA4MSBTYWx0ZWRfX+vyJQn9gPy+X
 PfGFrGHYWT+wo3iihi44m7RwTIvT+ddzePRFDt9ZbJ88ma1yQANmt2eCkw53KotYKd37gBG846U
 LrHuggsI680fepJ40UKpn6WMDIMm5gFwIRikralyXsABb5DIEBlkl+ZEaWy9LTeIlOS1BaX4pbr
 lYVTZtSmnlsDC9tUEvj/df7IVrxENAFh+mU2v1pcZ1yHD4GjQHfmbYPq4iDn7d1nKr/bEQRhBp4
 QLSxDi6lbTtN3Udimdu+KvK0AqtiABfeE4W6ZVtS4Nno3NB5DD2Oz2Q2l5EMooyD8UCxLAAiJYQ
 axycmsGQuoxJV1c4pGz7YsvHAPkV4GtvSajf4ckYBWhV6PW+YVbh++836k0loaX67IOmE6OTME6
 7KxPvIcvxSCNCsfv85xXae/v/F16YuC/QTVQLrtI82qJFzEaYnSDvjD2oRlyvyDTQ6cOuof+GHR
 2z49lSf/YNBeUX1cIhw==



On 12/9/2025 12:54 AM, Maciej W. Rozycki wrote:
> There's no point in retraining a failed 2.5GT/s device at 2.5GT/s, so
> just don't and return early.  While such devices might be unlikely to
> implement Link Active reporting, we need to retrieve the maximum link
> speed and use it in a conditional later on anyway, so the early check
> comes for free.
> 
> Signed-off-by: Maciej W. Rozycki<macro@orcam.me.uk>
> ---
>   drivers/pci/quirks.c |    8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)


Tested-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Tested with LTS 6.18.

Thanks,
Alok
