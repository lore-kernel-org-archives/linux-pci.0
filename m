Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37616274B46;
	Sun,  8 Mar 2026 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773003234; cv=fail; b=Uqp7t7EM1qCWSL3nUFamHUbD5FkSj9cChtbevCLB30gayjPm8LmTtVwN6H+mIY6oZVTenZX3Agr80hL+s66Y2bWGgxzS01itZssF+uzDL9fyh48H+taf45sNCtU0OfYDBzUQK9ZcSLbVr8y7QBOILs59SWXg9RNdLFz5Xn99+1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773003234; c=relaxed/simple;
	bh=5XKNFYmoHhDt9VN6UmLetuF4dlHrlZMF7TpI8P5sxck=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=K6mcupWTNg73tddJREZ/BJVccoMT4EI/2w7n5KTlM6+G80BX6I+erHPuC0Kx0TnkBQK6UWFFIm6SKgMeBC5a27NbbYUZV4FYTV5BKq1d104Dhg1PVgu61QNv+FYz+0ygne+0QWUvu/VUjGTXN8uVWTCRDrf6eNXwVBCWcvZ269U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GGpc5Mav; arc=fail smtp.client-ip=52.101.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GGpc5Mav"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZrQubr4ODuTFm67kqQC2IC3FswamX72wGIlF2uLm7yQsiaA66RZONq70LWK5Ty2imBYGn7K19cW7NDadwkOLbsfAaudcsY3yHz5v0RyLA4yLz+yAzlpKYZAojF9WFHw89esDBfJoKV7buQ2CyHLUzuJOMdJmERkjJAyyVrPjY7aXmkIKJhyCl/cc6UzQg709SRSPO3u6P3iKDipbmSubx9XVOkMcA9pQQ4g+19aw5pMAnww3HsUS3S4LaRlc3w5GB45uUJcXWtnfydRM3aquKDb85ZJXry6UMsWRDTf0674+r2stVEjEPU/cpex+5s8YZ5ueTGG+X0PSYOreNkoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96NRgRZ6Yx/IlrnWJQYOnXdwtojlOMhFGbF3AS3qmj4=;
 b=nfUwNbstut5Db7TgEQkG+9MuJNYHoLF75H4OjB9GJcrar5DbB6c+6MJtDCxXF+PIqAOxpjRn2GDAZHdOFdCzjcdEZh6kS8OXqCJq1jhlyCoCpzj5+XlHpKcCWb3xVru03XWjTyWMakDEGl/Q/z4EeAd+rmF6WF+bHo37yVg2jbkJy7OY81JDrS+BNZ5/YSJncXaYNWLEYJxAi7HGpoJ/ZYmGHsWQ0CU8Zv56kg15P38qD7GSrDSVlLP0+JZHLAOQOWZS8sN7NneO4nRqDpeu8P/AmbzWSLxqQ2nWVX6OF/P2iXtkEwpm6VNBT5LaAB7IvbQjbzvXz6Xl8+9tGqLN5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96NRgRZ6Yx/IlrnWJQYOnXdwtojlOMhFGbF3AS3qmj4=;
 b=GGpc5Mav0fgaeiYwAEeWOrRtpnLvV9W6YCkhSgEasweG024HXIAnXlxvTWko3Tkbvy+OsbVKIYwElQMc3rbByZTtGZlMbFEJoZqBJsQRshVzxW9svHwVGk9chfiiaORa2RgJZKjXEERDBVsQQzMKupHlm/Tw/K8HDoMyiaVMDL0hekcb3lZcbdDP44nME1RFFKFeSzHyQiMwCv/tAcBX3YHRr8PiqYAxNSTxZvr1ruzBUV9i/KZn4FQ97tDGFhQYlJ2UcWuohwm+Xu3CMSdwNDg1OmJPped1TK9r5843Lg6Tb9zLgxGlD0ae80fa2S6J9/V09OA2OEeNRx3nLk2HzA==
Received: from BY5PR17CA0008.namprd17.prod.outlook.com (2603:10b6:a03:1b8::21)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Sun, 8 Mar
 2026 20:53:48 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::55) by BY5PR17CA0008.outlook.office365.com
 (2603:10b6:a03:1b8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.22 via Frontend Transport; Sun,
 8 Mar 2026 20:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 20:53:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 13:53:32 -0700
Received: from [10.221.136.116] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 13:53:28 -0700
Message-ID: <8dc03385-aede-4774-9951-e76fc5cb2628@nvidia.com>
Date: Sun, 8 Mar 2026 21:53:25 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
From: Nirmoy Das <nirmoyd@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, <jgg@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <a0dd3e4cc5260f55bbec5b3ed6791def33028735.1772833963.git.nicolinc@nvidia.com>
 <2d523f6d-a4a5-44f5-b588-e6ad520322ff@nvidia.com>
Content-Language: en-US
In-Reply-To: <2d523f6d-a4a5-44f5-b588-e6ad520322ff@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 448f261c-efe9-44d0-8048-08de7d54cb43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	YsWJAjStiRXbqKpyX7XNvxF0Yv2iXaZDCSghKKQE2yYAlYLfHW3RH5Rv0/dxkKBHbFycX/FNjQ1m/y5x1ASLHdALIUKSjh/qvaYUsAnR7qJSsUo8KC8hRjZc/NtARCJ10fx9YDnsymKUuAH7HmU5ezEdH6zo3xJjGqdjVtjcY5sLfPdX01RoKWNGNTjfwi6ucscv4X+479KsOP+qP2wNIL+6Y3UvDkbcSJAVx0Hf5gharyFdHmQSZFJPgZhGmH0s+Z/PFTEAfLf1JLchaQ3CvJjQKdaKUdqSiwtVoHSmCWk5VyZ/j+joZuUU8uTIPDUOb5g4ykjFneiuBQ2wq4giBzWumC7ymzkFeE2yF0T/wZFvSXasKPqNjFVR76OvA2auq+LPTSZabPIsK3n0ZxKmXYTMWuicbghe1OyIzlmq6wWx18uL9AvaPrY06XQUACFBwOdRxTG0dZwDBWXHg6k4xg9uQdIG9RtYmPsAs3UPvLTUYgBy/fwUTT1wMJ3ZbPnKdJXNaiiWsrMyQCJiAKYYyWMlXQJvG32JehIRu2MEPXqYagKSCnQEdAoKZW/1cdshZyXkpZapC6o9azvgsps4djUmQd4r1Pj4K3JqWbROSfwr5dDeQ5wPF2nBwiBdh84+Hm7MzfYPCqG3OfKH8yXrIOvwOelcIBLgftxJh+aVUlc3U4r/OxYYyItTE+jS89uFTHZWwnVeUtnxtigvCkbWWsMPSrLdq5tvdDQyhve3+83liE5ovugUuLVmI2kAW35ttRsBJYv7KVuoCGmCa9hH2w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y/+xpEQvzKuyyn3rjhP6XHjATC0eNFHg+8JEkj28MgfaPBS6BUw8yzD/GzLXBxHgjK/3m1i6cly6roiVpDI+5AiF0Pj4n2XvFvs1NMkjSDkzITKYjGLXr0F6SWBKpqJW2JTliwR5TkKa9PLooBG/tOKR6PHtFpXbltBNfwcWwkIhKDI9pjdSx4jo79z+584DujsYvROzhABREvtsUvIKswNnjlLWbGVe5jEF55hIr2/MLXsqs9/ypsEVFSD1xJFAdAO2RejKQUJIgtbXtNQspqm2SvOsluc+jE/d6voy8QEriprxtlpbhGBIKVRVApoWqId/DrD40mei08DnGpR5/F3erZPO1RkqgG3elOtOOvfCyxVAyl5OzFZN6KOUemDTHnwPikvYmjGDV3i3pr5qv0sIuqmZrmOnLZTvkgM0Sk68/u+184US/rupRN+xYzD4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 20:53:47.3189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 448f261c-efe9-44d0-8048-08de7d54cb43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214


On 08.03.26 21:49, Nirmoy Das wrote:
>
> On 07.03.26 00:41, Nicolin Chen wrote:
>> Controlled by the IOMMU driver, ATS is usually enabled "on demand" 
>> when a
>> device requests a translation service from its associated IOMMU HW 
>> running
>> on the channel of a given PASID. This is working even when a device 
>> has no
>> translation on its RID (i.e., the RID is IOMMU bypassed).
>>
>> However, certain PCIe devices require non-PASID ATS on their RID even 
>> when
>> the RID is IOMMU bypassed. Call this "always on".
>>
>> For instance, the CXL spec notes in "3.2.5.13 Memory Type on CXL.cache":
>> "To source requests on CXL.cache, devices need to get the Host Physical
>> Address (HPA) from the Host by means of an ATS request on CXL.io."
>>
>> In other words, the CXL.cache capability requires ATS; otherwise, it 
>> can't
>> access host physical memory.
>>
>> Introduce a new pci_ats_always_on() helper for the IOMMU driver to 
>> scan a
>> PCI device and shift ATS policies between "on demand" and "always on".
>>
>> Add the support for CXL.cache devices first. Pre-CXL devices will be 
>> added
>> in quirks.c file.
>>
>> Note that pci_ats_always_on() validates against pci_ats_supported(), 
>> so we
>> ensure that untrusted devices (e.g. external ports) will not be 
>> always on.
>> This maintains the existing ATS security policy regarding potential 
>> side-
>> channel attacks via ATS.
>>
>> Cc: linux-cxl@vger.kernel.org
>> Suggested-by: Vikram Sethi <vsethi@nvidia.com>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>
> Tested the series with a Type 2 CXL device.
>
> Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
>
> Acked-by: Nirmoy Das <nirmoy@nvidia.com>
Sent with wrong email address
Acked-by: Nirmoy Das <nirmoyd@nvidia.com>
>
>> ---
>>   include/linux/pci-ats.h       |  3 +++
>>   include/uapi/linux/pci_regs.h |  1 +
>>   drivers/pci/ats.c             | 42 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 46 insertions(+)
>>
>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>> index 75c6c86cf09dc..d14ba727d38b3 100644
>> --- a/include/linux/pci-ats.h
>> +++ b/include/linux/pci-ats.h
>> @@ -12,6 +12,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps);
>>   void pci_disable_ats(struct pci_dev *dev);
>>   int pci_ats_queue_depth(struct pci_dev *dev);
>>   int pci_ats_page_aligned(struct pci_dev *dev);
>> +bool pci_ats_always_on(struct pci_dev *dev);
>>   #else /* CONFIG_PCI_ATS */
>>   static inline bool pci_ats_supported(struct pci_dev *d)
>>   { return false; }
>> @@ -24,6 +25,8 @@ static inline int pci_ats_queue_depth(struct 
>> pci_dev *d)
>>   { return -ENODEV; }
>>   static inline int pci_ats_page_aligned(struct pci_dev *dev)
>>   { return 0; }
>> +static inline bool pci_ats_always_on(struct pci_dev *dev)
>> +{ return false; }
>>   #endif /* CONFIG_PCI_ATS */
>>     #ifdef CONFIG_PCI_PRI
>> diff --git a/include/uapi/linux/pci_regs.h 
>> b/include/uapi/linux/pci_regs.h
>> index 14f634ab9350d..6ac45be1008b8 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1349,6 +1349,7 @@
>>   /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
>>   #define PCI_DVSEC_CXL_DEVICE                0
>>   #define  PCI_DVSEC_CXL_CAP                0xA
>> +#define   PCI_DVSEC_CXL_CACHE_CAPABLE            _BITUL(0)
>>   #define   PCI_DVSEC_CXL_MEM_CAPABLE            _BITUL(2)
>>   #define   PCI_DVSEC_CXL_HDM_COUNT            __GENMASK(5, 4)
>>   #define  PCI_DVSEC_CXL_CTRL                0xC
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index ec6c8dbdc5e9c..cf262eb6e6890 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -205,6 +205,48 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
>>       return 0;
>>   }
>>   +/*
>> + * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source 
>> requests on
>> + * CXL.cache, devices need to get the Host Physical Address (HPA) 
>> from the Host
>> + * by means of an ATS request on CXL.io.
>> + *
>> + * In other world, CXL.cache devices cannot access host physical 
>> memory without
>> + * ATS.
>> + */
>> +static bool pci_cxl_ats_always_on(struct pci_dev *pdev)
>> +{
>> +    u16 cap = 0;
>> +    int offset;
>> +
>> +    offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> +                       PCI_DVSEC_CXL_DEVICE);
>> +    if (!offset)
>> +        return false;
>> +
>> +    pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap);
>> +
>> +    return cap & PCI_DVSEC_CXL_CACHE_CAPABLE;
>> +}
>> +
>> +/**
>> + * pci_ats_always_on - Whether the PCI device requires ATS to be 
>> always enabled
>> + * @pdev: the PCI device
>> + *
>> + * Returns true, if the PCI device requires ATS for basic functional 
>> operation.
>> + */
>> +bool pci_ats_always_on(struct pci_dev *pdev)
>> +{
>> +    if (pci_ats_disabled() || !pci_ats_supported(pdev))
>> +        return false;
>> +
>> +    /* A VF inherits its PF's requirement for ATS function */
>> +    if (pdev->is_virtfn)
>> +        pdev = pci_physfn(pdev);
>> +
>> +    return pci_cxl_ats_always_on(pdev);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ats_always_on);
>> +
>>   #ifdef CONFIG_PCI_PRI
>>   void pci_pri_init(struct pci_dev *pdev)
>>   {
>
