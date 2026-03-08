Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C7274B46;
	Sun,  8 Mar 2026 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773003293; cv=fail; b=BVau7rYmX2hPauK9B+nUdsbGRuK4IoUHntvnAav3/GYS3Ax0B9Yr6FJ7PLaf7buB9yWKywKxY0bRvRTuitR+L1o7TeTsTJVr7NZ3MSQ5PUUF3y2wTlmU8+zgWdeSPaKuqKb9Yy9N7OAvfTwigKMpUMSOrGt10bDn8upGOMSE+ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773003293; c=relaxed/simple;
	bh=4a8OyHDDXOBqq6SwB6EScQsM03fb2t4lNGovUtiOnlE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=COdFEaTrBzgo7pan8Dn+BpMWMdvNjR1exrpXb/F4yrK40Cqde7A07lPJiVKP3VHStcVmN3e8KgBH+UmHjn6QIaxV+GeVQjUb2Vm+CvtXs/x/faWhHSVEBZIU1EZpPlx0wWGDD0VSLwOgjek2hm7IsdnjCQQnQXxCAt9wDvS0Mgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c+8500Wu; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c+8500Wu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKhanG3cHuMl7wxxYr1gCqgCq4dC7PBXHpplmId5iucQ7BNWgtwMoW7tE0XVasnI4nB1L0kBYzfATymmE99haEzmkpL7sEbRdtrOVlSEJd2USWH6oQiEOV0ArwvsCT2nvJGEELtUM4wOw5Xo4thon/jh2MLYSTz7ONeo7PWSox4m7Oie98UJKGIz3+NlyD5GHlFX/ACCC1WkrOdyUV86MeJaCNVZ2lpowAgNMo3BJXZbOoq89Lj2hLx8Bcn0zBf0e5G7m5fbZG8Obje7IoWjImxwgZCsXC4xyEtIMsdLDbbOhRHBVKOD/vy7Ch0vgwuymte+IDbi7cuHWpDd5QnhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBUrHeN7pt7If3s/g1D19NPCVcCwFWVOjJ7so+/1iBA=;
 b=mMRNNbdTiAc5YCQNAs+BT95nXa8Kk2/dxqZDjKjat/BJZUylBJUi175WkTu8B8h8zvwYLTFjLeMAQn/GuBHxe2PN1bAEexq9pQflqV0DdXJvPFT4LO9v1FxXHyG+qCplAAaP4hcABfVtMfpdVj5GkxiOSzdDmg3ruvRW7TCjkResyudaQSERcSruAdyKlH4mS9XwDoFUMJ7A5si1NTlfgPJ4UFoG8vCM6fw7ZoSILbGbZxmLFgYlEZjZWJxVEYvvNE7XeSPdPC8guiftx1H3M/uAIDxH6qveVZyevfPgo1NsoC4NbrhNakowyDH1J2A/3CIy80I+mQlNndlbgyiAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBUrHeN7pt7If3s/g1D19NPCVcCwFWVOjJ7so+/1iBA=;
 b=c+8500Wua19fGBdv12kAyc4TiNChpzToqCouBp3wVKnnV0KCHcDlT6o+JlbPlJ7QCGi9Ykc0jQZ+dNSyYJcsDB3o2vTp7dkf5tjHMVQOnbJgXUV+8knT2Ukk9Twq6LuaArpkKbxWFDDCUKk752aI8JzfRVNEr4wHNOYNyQQt0QpX4583I2OP+f7xpNq1P4vOYW0XctZxKs6NXGwXaaYkGv6u5bnmYlO+S/HE8xab4tlo/GO1BYeHV88n7y8VTbIQlITu+h8j3QaQ67tChLBCsB10C6qXMEPnOLVoXbvRoYl67GBEv8plMwWhwR+A+IO9p0ZkVk5sKGBtCOYyRnGcpA==
Received: from PH7P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::30)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Sun, 8 Mar
 2026 20:54:46 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::6c) by PH7P223CA0029.outlook.office365.com
 (2603:10b6:510:338::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Sun,
 8 Mar 2026 20:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 20:54:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 13:54:34 -0700
Received: from [10.221.136.116] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 13:54:30 -0700
Message-ID: <3d8f1e72-6098-43e8-aefa-e60f07bb81e7@nvidia.com>
Date: Sun, 8 Mar 2026 21:54:22 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] PCI: Allow ATS to be always on for pre-CXL devices
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
 <c715b10b49d50eea5429454108d4221c1a78efaf.1772833963.git.nicolinc@nvidia.com>
 <50281260-62e4-427f-bd66-e8be58062a03@nvidia.com>
Content-Language: en-US
In-Reply-To: <50281260-62e4-427f-bd66-e8be58062a03@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5d2a7a-d26e-4db6-432d-08de7d54ed47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	XBwDY31l9UqNH9zjG+csORGDNY5NIEaX+Ad2XzxAlHB9hXj8vkNaorf8ABiUYQw2+Lkdo0JTKsCH6Qpnfk+4mgIWyVXbwH+9mB+viVNy0eJrW5kNU7mE9Kj6PV/IELbRMTuvPTb/j+V9jXlqnr4r4+rhHuuPNnARL/ngZZy0LaZ6CE9UBnTCVz+jaMO1SpaKLYTrNeNYrSV8qSHM2/GGNGPY2eSI6vWn9SJRqanjRdXuQcdnmSYpw9tvAxHqtYVuEyu+YB3TpUdPBhQ/ph7ssDKvJvKA2zeaY7x0QyoIpkIirMhpVOvs0NHg0U67Xg7EjFWQTeZrt8oZ3mkghgCwGNl6EwuWktuJ1xp6vdwBS99wVH+io+YP3NZTn7F/omPBdl0ejrmkOWv6DhvQqXjlHkKfHpeHHCkbjNRZwDChOC9fTezBDzJQ5m5K6m4jnxeT88uVI6UmCXIYa+jU8UDWsJi5FXb6v8jEa6ucDfI4WW/xpmZFyFWBKMdqcgI/OkapvPZNJci3TcIRRDZp4gLcdnEj2JBcBdKZHVi06ydK3hUb4bD4Ep9a9nvJzFjgd6Q38TS9dADzv75mQ1hvLqTxtbMxCo6Kt3EHSnG7/Jc+XC+LyO3shdfDvckjvdHhXexqnzriEaOMrMcLKzZ/cOZQAT2lZWBJkV7NjtaleSrT8300x9yM3xyVcN8UmakQmcDH25LF67eMfV+p2DOOKuTNAIrp7I07TXPRjG7wf8wCLPjbqybGJBUC38VNhFKIGolfNatNhAXfYUoDjDhHnPC74g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xkvd0rUeDMEd6cYnPCLgpvoUdgwJExNQDGpaLuhWuJvABgRu5+0C5lbCWDbK//E3mIDOq8L8KaiVcTQxn5STowAkqO+W3/zbXK4oOFq688HTrWwuRTO7wONjzC4WGaaJ+rUBeTTy8tWklUSzCi/gUsE7GpS7aqCOZ/nioOvo5kNIHrWtvuhr4e2wuNfbfnEazlbo8jyMcSbujtTSY7TWxyc2ZmFl631/bS10LSl1hALJtLZU0ArL+BcNlGCYQUfN0NA9wncGd/+U8Emer3izGmT9dqJ7JWRf/WbJLtib3WJ9adKGxIFEKqB54V7ZWZbXGpDUF7u/gmejLIjNhDmyt3avlDekI39rRAmRomQIk17DGUleVwGtRMZsCOCJVFmGxCKA0ae/PX8+ntAsFk1NG+ZkRJW0bwhDyRjGYzbgDA98NX8ZBETsneLIoOLuqFYO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 20:54:44.3399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5d2a7a-d26e-4db6-432d-08de7d54ed47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C


On 08.03.26 21:50, Nirmoy Das wrote:
>
> On 07.03.26 00:41, Nicolin Chen wrote:
>> Some NVIDIA GPU/NIC devices, although don't implement the CXL config 
>> space,
>> they have many CXL-like properties. Call this kind "pre-CXL".
>>
>> Similar to CXL.cache capaiblity, these pre-CXL devices also require 
>> the ATS
>> function even when their RIDs are IOMMU bypassed, i.e. keep ATS 
>> "always on"
>> v.s. "on demand" when a non-zero PASID line gets enabled in SVA use 
>> cases.
>>
>> Introduce pci_dev_specific_ats_always_on() quirk function to scan a 
>> list of
>> IDs for these device. Then, include it pci_ats_always_on().
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>
> Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
>
> Reviewed-by: Nirmoy Das <nirmoy@nvidia.com>


Sent with wrong email address

Reviewed-by: Nirmoy Das <nirmoyd@nvidia.com>
>
>> ---
>>   drivers/pci/pci.h    |  9 +++++++++
>>   drivers/pci/ats.c    |  3 ++-
>>   drivers/pci/quirks.c | 26 ++++++++++++++++++++++++++
>>   3 files changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 13d998fbacce6..13fa71f965900 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -1150,6 +1150,15 @@ static inline int 
>> pci_dev_specific_reset(struct pci_dev *dev, bool probe)
>>   }
>>   #endif
>>   +#if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_PCI_ATS)
>> +bool pci_dev_specific_ats_always_on(struct pci_dev *dev);
>> +#else
>> +static inline bool pci_dev_specific_ats_always_on(struct pci_dev *dev)
>> +{
>> +    return false;
>> +}
>> +#endif
>> +
>>   #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
>>   int acpi_get_rc_resources(struct device *dev, const char *hid, u16 
>> segment,
>>                 struct resource *res);
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index cf262eb6e6890..e6995b536ad4c 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -243,7 +243,8 @@ bool pci_ats_always_on(struct pci_dev *pdev)
>>       if (pdev->is_virtfn)
>>           pdev = pci_physfn(pdev);
>>   -    return pci_cxl_ats_always_on(pdev);
>> +    return pci_cxl_ats_always_on(pdev) ||
>> +           pci_dev_specific_ats_always_on(pdev);
>>   }
>>   EXPORT_SYMBOL_GPL(pci_ats_always_on);
>>   diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 48946cca4be72..21451e62f284e 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -5714,6 +5714,32 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 
>> 0x1457, quirk_intel_e2000_no_ats);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, 
>> quirk_intel_e2000_no_ats);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, 
>> quirk_intel_e2000_no_ats);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, 
>> quirk_intel_e2000_no_ats);
>> +
>> +static const struct pci_dev_ats_always_on {
>> +    u16 vendor;
>> +    u16 device;
>> +} pci_dev_ats_always_on[] = {
>> +    /* NVIDIA GPUs */
>> +    { PCI_VENDOR_ID_NVIDIA, 0x2e12, },
>> +    { PCI_VENDOR_ID_NVIDIA, 0x2e2a, },
>> +    { PCI_VENDOR_ID_NVIDIA, 0x2e2b, },
>> +    /* NVIDIA CX10 Family NVlink-C2C */
>> +    { PCI_VENDOR_ID_MELLANOX, 0x2101, },
>> +    { 0 }
>> +};
>> +
>> +/* Some pre-CXL devices require ATS on the RID when it is 
>> IOMMU-bypassed */
>> +bool pci_dev_specific_ats_always_on(struct pci_dev *pdev)
>> +{
>> +    const struct pci_dev_ats_always_on *i;
>> +
>> +    for (i = pci_dev_ats_always_on; i->vendor; i++) {
>> +        if (i->vendor == pdev->vendor && i->device == pdev->device)
>> +            return true;
>> +    }
>> +
>> +    return false;
>> +}
>>   #endif /* CONFIG_PCI_ATS */
>>     /* Freescale PCIe doesn't support MSI in RC mode */
>
