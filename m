Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2E392C3C;
	Tue,  2 Jun 2026 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390209; cv=fail; b=VZOwD0EjtiY6UBVZZx3vOuNBR5fXO+cuAL4WLEroY8p4YuD2NoksNUeIuC1pf1jJwgRFWTnH5vVNPRNbRmfb61Rd8JrolshY/Qvw/MiiiU+YpfD/7tZlVMwFjaLsLGVeEU4gFITzdo+sioWTjeV/EabtyFzzlpln1ofcBMJX1Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390209; c=relaxed/simple;
	bh=eBeu4u8+n5JQf1/FaiSucCzAtst3GJOaRzGN6XIs4XM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pUvF5lfu8vep0g533owxP9hRu3p2mNFk3YtsNkIr6hh05hgKKYz8LAvdpeXE1/CTyfeSamTfLQ/BIiVwby/P6yMTb70LTjRqoLaOLi8GmD5ivcYHDGIOc8N+V8uC/s+t7mHvq7DsDWYB9rT+RFTsAq8H2rVDnh1EKsueHrxK+sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F/kEn8Nu; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F/kEn8Nu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8r8oY4z8Amqk+5oEfzKhEyJ5K6GwO8BXMkpUcytf/abIrzy+Fh0JEo4jBPaKzMk4KyxYoLqXfTe2JkjRhgYzQFruv23NsKFOYx4yssZJFIXXsIJkDlnmbedE50fqkLpLdI1UtASRldkYdn8VeeK8RvwZdcmZbeot9aHitWegWOKYbnLYNSXs65DIu+qfmkKIZSZyU3VfL/a8B/IsNO8ElaiMZ81KV+T3LgP757nxihl/2u0MwiYW3rDYZd8azjR4wHfdc4Qnb7dz7ybi1dhSaOjTIFHHHXpAvoHTU+T4EN8xZywKT4i16G2TMSBnF7O6BoBOpkZSDwp2NL3soMqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7iFMvU4OmjmbTQ4StUvPkEaOezvSyIzrpMqMnIXl3M=;
 b=fx+IaJ8K19lzJ0pxPx9PJGc6w/pC+tD+jxj+LdxRF4fyNpssiVviFC7JjjphtzPTxOGmvavvRdOvSBSRmDOcAtJVnvgWhyXMqqWgE/gEUEyemKZloN35gwL0eYvoKJIJOR5IdI2uvcuN8p5gR3sx4fWo6qU61Jh2m5kjk/smknk0CwzIMBwTtPcbX2RlL0ZRykRIghI7hspfJkZCwiIwxYD5s+i2EXWdv66ZKEpgkBhuQqv4GFIvq3eK13/soKZDnrJcoWhULRAHWkO2n8yF+JLXUC7iGlu8fxuYOjElSZkD1xWzKY9pUWfXm98PJFFOWcMDMs6GBp9pZXCvpxbf0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7iFMvU4OmjmbTQ4StUvPkEaOezvSyIzrpMqMnIXl3M=;
 b=F/kEn8Nuy+21fuiD5u8MGEWAT3mgXN5ajOjhH9N+QZXAicaijRajnCYjtdm/zvk52kVPWEj9YDK8SRJg2Caias4fyYyAx/6IsU32YE1ayB19Bzy0RTHYkOn+7omu6UwTw/pLB45QmT5v7SB1rhGhTBRoIeboTeSIzeJjUr89ol0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Tue, 2 Jun 2026 08:50:02 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 08:50:01 +0000
Message-ID: <62a4a7bc-091f-4d9b-a0c2-b2368fc399ab@amd.com>
Date: Tue, 2 Jun 2026 14:19:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] iommu/amd: Refactors for ATS updates
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20260601134204.2150602-1-praan@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260601134204.2150602-1-praan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0307.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::10) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4c647d-b9b0-449e-73b9-08dec083eeb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|6133799003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	uLQ3HqmzwnO4Pbjwv8uSLWNM+fe8DxRrhcF24QM+5H8mOyEujLbSuURWX0oMS/OM0IPaWWRw9z/QULV3hEZCQpPhwOVTALK1j/ruCkDP1Wn+N4s3B8SsHJyxVtYsKG4BiTo7TV3yQi0GRcej3S4jD2Y7nbdzQ4aMLDX/LiWzkc016Dimxy8dh0iHGTnddI8EHwqsHhq9qR9jP4nKR2AM4GhW4YzcyQtBrijynOvQXCDYJ0N+qGKQA3AKh81WP5kDAr4hboAfyzmb7xJk4K9P6KVC0jNS9EZx+9uf4l/GdsH/6AOGMi55xliuADPu1HI8ymgAWw3FaoNzxYgW1k+cf5LYT0Ca5tmsKG238N1LHFN2F0RgimACn6kOOL2/b9aXK01jSJhqlLpKZ57qkHSHPpXzeBtLPMI+7WPP5SnOHRtFQkuNaj+uOPDGs0UxWfne5ja2QVi3AL8QyVWb1ymjoyfxs4ORpmvrwhVsF99tjcVhfQ7KKuWou1BVOH7AiiZee8sJ2s99BHNJy7lJ0SA0ZcPCIbth2/Tm9yh/YZ1UUKplxyO+qRtR2HvEvTKhW/i4+Kn+V2yS7P6hkQSO18NcKHeu844kr7TjZo08Pze7BtkBKruFQr96bA45dP5VN6zUwvJ5qdkdYVuOxV03al9p3MnmMxW2jGn7ZJZiIBD0bywqF0R2PEmfr1WWXBZ5PSpuW/1TKDtbiYz0lB7D1H7zAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0Y3VHlURzlnZ04zWFp0SkxCR0Fld1phcnBYQmVUYkdQTVJuREdjcERWYTJr?=
 =?utf-8?B?RVpqUThqeWk2TUp4RC9LendFTDhCM3dRS2E0S1FpNkJEdHNTYm8yZXVLeDJ1?=
 =?utf-8?B?bjZaeGljNEYraEZLRFNpbUcwOWs4SXJmQ2VqRE9xSDNSQ3RpRUo4RkFKdmM5?=
 =?utf-8?B?NHFibU1nczArRjRPdGQ1NXRsY0ZVelNObG8wdmU4NHU3Y0c3VWtpMnlCZ0tF?=
 =?utf-8?B?NzVGT2tmNWp0MjljUFVFVUZqME1sUVNEdmNBcytGR1JpZ0J5azFTODZrdy9V?=
 =?utf-8?B?Z2hVRU9qOTJpUEpPYzhRbnV4TmlLTXk2NTlnOFlxbkRoSzlHUWVEM1V2ZXFM?=
 =?utf-8?B?Q25Vb2J0TEYrMTloL3lWcXJNLzZrZmRKSXZoaFltZlF6Q3Z4QXRBUmVxTlE0?=
 =?utf-8?B?Y1hTbWVKMTZ4c1BWR1QrVHNBTDFZQTRqMWNyektMNzlnUjhhSVo3b2lhcUVv?=
 =?utf-8?B?Qkdzamd0VHFTTERvNitBdGJ1ckN3VmUzTTRaWS9FWXY1bHBNUUpNbFU2djlP?=
 =?utf-8?B?NWJ3bE56eUdUck1uZ1pGeVFmL2FpbzY5VitjeTZ1V0JJbi9XN25lQm16RWFU?=
 =?utf-8?B?blh6MlRlb0ZnaXhCUTgvZlc0QkxFVTBXdStJUG9FbUQ4QXVKbm93TTRROC9C?=
 =?utf-8?B?Y2p2Y0QzU1VmTldZazdaRG1YVCt6VElyR2lxdDNORjNBeVpRT2Y4SnV0YSt1?=
 =?utf-8?B?U2xzUkdLbEVXNW5VNW90d2hwV0piQW5RckJjeFUrN1dxSXM2MTVudlhjVTdx?=
 =?utf-8?B?eEx2bFR3dG9qTXhTSkJtWXRMVWtXVVJjeVdGN1ZQWnFjM1pmakdDME9OWmhJ?=
 =?utf-8?B?RjNlaUZ6dklhcHdidEJiSUl0WVNPMlBQbEdGV2ptVStUaHRXNDlwUENhSWhR?=
 =?utf-8?B?SFpZUzgzRnQza2VyMmNvb0RJcHlnVHg2WkVNR3JlNE1COU4wVUxiWkd5c1N2?=
 =?utf-8?B?TVdLK0ZXWnl6aUxyUFpWdkNZZloydVRnbHhPZld3OVU2akpDU0g3SkxDVnNq?=
 =?utf-8?B?L0t6WWpCUE9PTmNVSytOUThIM3FrdzZ6OWlzYnVLYkk2Sys0cmIvdk1ISWFK?=
 =?utf-8?B?Q2JENWExQmR5b0NJZnF6RURRNG1kbklCV0k5aVlob1VsUG51YmQvVGRYOGgr?=
 =?utf-8?B?S2I3RW5xUUlwKzVleTA5eEJIb0lYQ3pQbjIvZFJVTHJlRjZTYkRoLzNlY1Nw?=
 =?utf-8?B?eFppcGhmc2hndWZoektWUXNHc2NTQysrQ0szZ2wxQyt1MkhUak1PVWdHVUUr?=
 =?utf-8?B?THVnS1ppZEFWM1pQczNReE5HWkZoazdDcGFWVWV1eHFYODVsYTROK0t0bmI3?=
 =?utf-8?B?MHNaTU8wWXp3citOdFJ2Q25NRXNyZTRVa2Q2YjdFMzd3ZkVhOGJ5bUs3Wi9l?=
 =?utf-8?B?Z1VRcXFvNHZzcXUyMFc2c0dpWVR2NnJDM2V2WlBtVUZodGdKNTY3LzZYY0Q5?=
 =?utf-8?B?YnpkejhXQ1BlMGNmRWdxZjIrUC9Cc1FmbDJyaDc2SGZZVWFMREJUYS9qckE4?=
 =?utf-8?B?TEdvRXk1TzlLVU1tZDdQTWthUDRKcTFuQXovalBkZkhybDQ4UDFsUWthSEgv?=
 =?utf-8?B?SUhubjg0M04xcWJTTFl4ejFqRG00RTJhQmw2Q2M1KzNSTWZqaWU1ZDByaDdJ?=
 =?utf-8?B?WlZqdkxJZDZmOFhwdjlFT1ZHc2tUMEg0d3NETEw5S0tTWndITEtLOGRlV29Q?=
 =?utf-8?B?VzlrczlLZU1iTCtKUitlMGFiR3doSmVvUysycnlLbUx5S0Q5TkN6cGs0c0FP?=
 =?utf-8?B?ZW1IaHlVNXRuNjE5Rkp0QXNwd3pVRXFmdlB3RVhCa2ZESEtJYXYzUjNEbzFR?=
 =?utf-8?B?NlIrVWJKNk1SV1pJc1lHeXhPN0NqTUJpL0lFNFZ2QWR1ckY3MFlaREFjMTFZ?=
 =?utf-8?B?MnhSNTR1YlBmeDBjc2VkQlRGMTRpdFZOUU9EQmhzL3dnbEh6UUlJbDFnYkV5?=
 =?utf-8?B?VXlPVFZvNkw5UVRPMjBkNXdpaUYwNk5BK0FxdGNSSFJUN1E3bzd0ci8wVmJO?=
 =?utf-8?B?NEg5WkFNTjVva1haakw2L01rUDl4NXdURXZkbjgvdllZc080NnE0L2t5YW1C?=
 =?utf-8?B?U0lWSkRwMVgwTjMxdE5aR3BxdDAwRnVabGRneWdkeG5laGdqV29IaTNLSW9S?=
 =?utf-8?B?QW5TK1JMcStXVWJHQ3F6b0pYOHAzOFQ0bnI1TUEvdWdSQmFmVFFuT1RtTkhv?=
 =?utf-8?B?TU1SV21oek9YRWRWTTRXUlBqR2dEK1k1L2xHckw5OXQ5ZlVGZ2dORGN4cDJ6?=
 =?utf-8?B?MWdQSWFTcVRnZExBQndkRjMvSHp6VWRHVWpBc3JwNEt5d25MU0xVZnhsR2cw?=
 =?utf-8?B?eTdjZHhNeGFqVWp3WlRCaVl3V3RsTGlqbkxkdmtKVmI2bnJ1TkZiUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4c647d-b9b0-449e-73b9-08dec083eeb9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:50:01.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OnWWB4nGbkycZhKJ0sAovkOxtEqv9uhoyD3E4Aj+FrzlozYW2Xrgu03pDVv2CXrLlL4AlnU2eVE7n1wf1PKFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957

Pranjal,


On 6/1/2026 7:11 PM, Pranjal Shrivastava wrote:
> This series addresses some issues identified by Sashiko in the AMD IOMMU
> driver during the review of the subsystem-wide ATS update work [1].
> 
> Patches 1-2 address the  pre-existing bugs in iommu_ignore_device()
> regarding the order of alias clearing and cleaning up the DTEs. 
> 

Thanks for the series. While this series fixes few important bugs, at the end
certain checks are still scatters. I really want to move around the code bit so
that it makes easy to read.

ex: even after this series, in probe path its calling dev_is_pci() check 3
times! Device capability is still scattered between probe() and
iommu_init_device() function.

Does something like below makes sense (untested code)? This doesn't address
iommu_ignore_device() issues. May be we should rename iommu_ignore_device() to
something liek disable_device_dma that clears TV bit and other things.


-Vasant

---<---

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 57dc8fabc7d9..c628a2e7e3a8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -672,11 +672,12 @@ static void pdev_disable_caps(struct pci_dev *pdev)
  * This function checks if the driver got a valid device from the caller to
  * avoid dereferencing invalid pointers.
  */
-static bool check_device(struct device *dev)
+static bool iommu_lookup_device(struct device *dev,
+				struct amd_iommu **iommu_out, u16 *devid_out)
 {
 	struct amd_iommu_pci_seg *pci_seg;
-	struct amd_iommu *iommu;
-	int devid, sbdf;
+	int sbdf;
+	u16 devid;

 	if (!dev)
 		return false;
@@ -687,7 +688,8 @@ static bool check_device(struct device *dev)
 	devid = PCI_SBDF_TO_DEVID(sbdf);

 	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
+	/* Not registered yet? */
+	if (!iommu || !iommu->iommu.ops)
 		return false;

 	/* Out of our scope? */
@@ -695,25 +697,19 @@ static bool check_device(struct device *dev)
 	if (devid > pci_seg->last_bdf)
 		return false;

+	*iommu_out = iommu;
+	*devid_out = devid;
 	return true;
 }

-static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
+static struct iommu_dev_data *iommu_init_device(struct amd_iommu *iommu,
+						struct device *dev, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
-	int devid, sbdf;
-
-	if (dev_iommu_priv_get(dev))
-		return 0;

-	sbdf = get_device_sbdf_id(dev);
-	if (sbdf < 0)
-		return sbdf;
-
-	devid = PCI_SBDF_TO_DEVID(sbdf);
 	dev_data = find_dev_data(iommu, devid);
 	if (!dev_data)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);

 	dev_data->dev = dev;

@@ -724,6 +720,25 @@ static int iommu_init_device(struct amd_iommu *iommu,
struct device *dev)
 	dev_iommu_priv_set(dev, dev_data);
 	setup_aliases(iommu, dev);

+	iommu_completion_wait(iommu);
+
+	return dev_data;
+}
+
+static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
+				   struct device *dev,
+				   struct amd_iommu *iommu)
+{
+	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
+		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
+	else
+		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
+
+	amd_iommu_set_pci_msi_domain(dev, iommu);
+
+	if (!dev_is_pci(dev))
+		return;
+
 	/*
 	 * By default we use passthrough mode for IOMMUv2 capable device.
 	 * But if amd_iommu=force_isolation is set (e.g. to debug DMA to
@@ -731,11 +746,21 @@ static int iommu_init_device(struct amd_iommu *iommu,
struct device *dev)
 	 * it'll be forced to go into translation mode.
 	 */
 	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
-	    dev_is_pci(dev) && amd_iommu_gt_ppr_supported()) {
+	    amd_iommu_gt_ppr_supported()) {
 		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
 	}

-	return 0;
+	/*
+	 * If IOMMU and device supports PASID then it will contain max
+	 * supported PASIDs, else it will be zero.
+	 */
+	if (amd_iommu_pasid_supported() &&
+	    pdev_pasid_supported(dev_data)) {
+		dev_data->max_pasids = min_t(u32, iommu->iommu.max_pasids,
+					     pci_max_pasids(to_pci_dev(dev)));
+	}
+
+	pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
 }

 static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
@@ -2451,43 +2476,29 @@ static struct iommu_device
*amd_iommu_probe_device(struct device *dev)
 	struct amd_iommu *iommu;
 	struct iommu_dev_data *dev_data;
 	int ret;
+	u16 devid;

-	if (!check_device(dev))
-		return ERR_PTR(-ENODEV);
-
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return ERR_PTR(-ENODEV);
-
-	/* Not registered yet? */
-	if (!iommu->iommu.ops)
+	if (!iommu_lookup_device(dev, &iommu, &devid))
 		return ERR_PTR(-ENODEV);

 	if (dev_iommu_priv_get(dev))
 		return &iommu->iommu;

-	ret = iommu_init_device(iommu, dev);
-	if (ret) {
-		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
-		iommu_dev = ERR_PTR(ret);
+	dev_data = iommu_init_device(iommu, dev, devid);
+	if (IS_ERR(dev_data)) {
+		dev_err(dev, "Failed to initialize \n", devid);
 		iommu_ignore_device(iommu, dev);
-		goto out_err;
+		return ERR_CAST(dev_data);
 	}

-	amd_iommu_set_pci_msi_domain(dev, iommu);
+	iommu_init_device_caps(dev_data, dev, iommu);
 	iommu_dev = &iommu->iommu;

 	/*
-	 * If IOMMU and device supports PASID then it will contain max
-	 * supported PASIDs, else it will be zero.
+	 * When DMA translation is unavailable return error so the iommu core
+	 * won't attempt domain attach for this device. But interrupt-remap
+	 * is still supported. Hence do not ignore the device.
 	 */
-	dev_data = dev_iommu_priv_get(dev);
-	if (amd_iommu_pasid_supported() && dev_is_pci(dev) &&
-	    pdev_pasid_supported(dev_data)) {
-		dev_data->max_pasids = min_t(u32, iommu->iommu.max_pasids,
-					     pci_max_pasids(to_pci_dev(dev)));
-	}
-
 	if (amd_iommu_pgtable == PD_MODE_NONE) {
 		pr_warn_once("%s: DMA translation not supported by iommu.\n",
 			     __func__);
@@ -2495,16 +2506,6 @@ static struct iommu_device *amd_iommu_probe_device(struct
device *dev)
 		goto out_err;
 	}

-	iommu_completion_wait(iommu);
-
-	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
-		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
-	else
-		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
-
-	if (dev_is_pci(dev))
-		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
-
 out_err:
 	return iommu_dev;
 }









> Patches 3-4 refine the probe error paths. As noted[2] by Ankit & Sashiko,
> unconditionally calling iommu_ignore_device() on probe failure breaks
> IRQ remapping for devices in PD_MODE_NONE. We now split the error paths
> in probe_device to preserve interrupt mapping for non-fatal failures
> while ensuring that dangling device pointers are cleared to prevent 
> potential UAFs.
> 
> Finally, patch 5 implements the Fail Hard pattern being standardized
> for ATS, ensuring configuration errors are caught during probe_device and
> ATS enablement failures are reported with a WARN_ON().
> 
> Patch 6 is carried forward as is from the original ATS work [3] to
> maintain bisectibility.
> 
> [1] https://lore.kernel.org/all/20260529111208.387412-1-praan@google.com/
> [2] https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
> [3] https://lore.kernel.org/all/20260529111208.387412-4-praan@google.com/
> 
> Thanks,
> Praan
> 
> Pranjal Shrivastava (6):
>   iommu/amd: Clear aliases before setting the rlookup_table to NULL
>   iommu/amd: Clear DTE with update_dte256 in iommu_ignore_device()
>   iommu/amd: Split probe error paths to preserve IRQ remapping
>   iommu/amd: Fix Use-After-Free in non-fatal probe error path
>   iommu/amd: Fail probe on ATS configuration failure
>   PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
> 
>  drivers/iommu/amd/iommu.c | 61 ++++++++++++++++++++++++++++++++-------
>  drivers/pci/ats.c         |  6 ++--
>  2 files changed, 55 insertions(+), 12 deletions(-)
> 
> base-commit: 283d245468a2b61c41aa8b582f25ed5615d1c304

