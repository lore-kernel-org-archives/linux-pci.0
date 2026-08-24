Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010030.outbound.protection.outlook.com [52.101.193.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0A3859D3;
	Mon, 24 Aug 2026 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595221; cv=fail; b=hcgV8y1Eb8YQyuKUtBuIlvnsIJxFF4b1DP/WVRIu/jnPTsxowlFOyjObdlQFtS8H83AsONG8QCDDzvXi0R9tjgHZtI21lPlb8qi4yMJnP9GCoxjrCCqeDI22igQxqxrLVVVDO95C6f/xwt/ZU6x1EUhvvOKXTGCP6x4AgN2e5nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595221; c=relaxed/simple;
	bh=vGnE0Y2FZREm3nKkt9pnHmWIvezbDDDnukBPp/w+P70=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=ST/b3+uIEgOC35k4rqznKnxMa33kQ00Uojqx1i06SlIQMWph+svPEDTZINSno/o050olfKWL+HPgZMpHbzcAsTbH0C/n+o/L/+jLFiWSo9NKc5WkfFtYzjgZbV8PEs6f3otNSeiJQ4YVgIYEnCSMys063AbsheHFopDsNdCsbtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g54+1uaL; arc=fail smtp.client-ip=52.101.193.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g54+1uaL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIdeN5ukRJyhpHP/8l1RISvEqMcnRdkzK0MEbYGx/LHJn46b0WbEN/unU0C2yzE7AUy/x2soNvJTKNpOIbELDr7fedKLH3fXYkAtfh0SSUH2v1OJbD0AqH3R6eRribH1sCfK65l252F3fN1a7gAkLWcsr2Jh2vUea2SJ28JBojMQywxAHkwlnczojW7/Qn4fdtMEcCTLZR9igqr3mMYT3z416wwon+wbQ6ekMZKvUM0OpncNk00TQs00IrMVxawLeNLTVvAddhjBBkXjTRcp2772Z+Mu1RX7NWkIINb5Q+XYnSBMSMj5NsfJUMPBFXhjIk6pWvM1H1qac+12W0uoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N3Mus8UBfRuAkKaeg7Eip6v35RMshgLuW2QcUfX7ks=;
 b=JU6gUHicW7i0u/hdv153j3hhFZi9wZBzkXz67Zv1NmNVjsFW+TPH+763yqE6WGdTqzEvyxdtj9Zk0yAIqEoa2HpEJFLYV0GUubXSVIbj1EqCJRI92IwXQjiox8l6eH2O5V/yZk9Wsu/NCD266HuitZrveK40JVGS6zAZxMb3FdAJ9kmXdoA5qOvNxNUc14KUo90SWmUrp31wmcRXho7gQQ+GbQjLlCPGT6x+sT1vYRVU4p9k6rqdgOdL47lgfpUcyr6sR6iWcyPYuoiX3j7HUCCTmyDEK0NyjQ9UGy8RujQcUPqKwymcUE1wRbo1ug6F0aPTZRi+PNodzrKZePU0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N3Mus8UBfRuAkKaeg7Eip6v35RMshgLuW2QcUfX7ks=;
 b=g54+1uaLmGpnjqzy9ahS2Csd1vWD6lMncXGOctwEoGHm1bGbuEl86NJmyz/M85JkaJdmHLNm0wEQCBWyaG7/sukOgmRxOT+1mP47r9bZ3wNkbPx814UVAr1K/+AyaDLyXSFJhXZ/5w33z9b5CITF3Ua9DZl0KKB8MjKfAWe9KNkQaBsL5Scmv1AVWZ+QHcWiYqeOaW0aHNlSEHzkLv3cr1+MH8eolPQ/lM8IeFqjSPQE9EfSo+yDWtXUiskT3Xk5AOXjbGFWfmpQyhKZ8rJlrSqywydODB9DPp1QhoJFa2jLtdv+PqmlgWopKM54YakYbKyMjQQYH6ORzeH5C1txaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 18:13:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 18:13:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/5] iommu/amd: Refactor device probe and capability
 initialization
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>
In-Reply-To: <20260824122347.1588592-2-praan@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-2-praan@google.com>
Date: Mon, 24 Aug 2026 15:13:21 -0300
Message-Id: <178759520116.3131778.9383172724893797706.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT3PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8bd742-9b5c-469b-3737-08df020b62f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2AJDiwPY6rgvrFk7nw9vs1+4b43s7Bb8icv/z44swx2YbbX/KqPg1dc23B7ow9ASoTG/SgPStGPfWG0DZvaqIDhXrt6laYwLIb2f5ut6q2t1Bh5PxFt4mR3iXMwTCMC+jDl7N2mbjyYkeFzUjl2xNrVA7zjlAK18dZeGEPkN1Zr1+Bn5U/VXznieKVIFEeo9HKBhfcMlyKTpgkHHYpaxjYKQSFOEsI9qXguA2nCmyK/+VDN1sz9XrI8v1hNluqWhY5jec/bVEe40jYsaqQOnayESOV0TeNBXaQrVZYY0ijzkglObJaDN/D9Mp1hlLN0cbDXiMj/d4TNAZiDHtUcKjCpLIEyYr6N9zHx6aipdJqMe4PkAxxL2CueEcYhnEBX5v0bRGiT+ntqDGE/gPO+wozKtkC+vgyk2cp2rQgtUreu03o9DdUbOOTO45LlbUQEHSQ2ky2eMcviAlYUPatEAdw2lwyVOy8bGKPC96VQb+NZcsOtBQ7KPJufmTu1kVSSpaGzlhE/i39tkQsOpOyHwlkRWuoXOflm0pupDG6sGyJUgLx33xaSRFRYnSM10ak+FAwi01MceG0zB9jdptIs0z+9UuOxpxc1hFFafC80TNfqUbi/DHePHwWwvLk3LRgbUTYy3r0mpS9A8uHQzhHwhYfkbY1Q6A81wP7/6XOuTVpA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU44MHYxcER2OEZ6WUVkamVjQTd3amgvK0FkNHcrUm1sYkd2V2lqbjNiNFcy?=
 =?utf-8?B?aUN1QXlYMHVIY3EwaUs5dVJZVmZLVFNKK0dNdTBEeTRmdWNDeGZ6dnNUSXBU?=
 =?utf-8?B?NXdzVmEycFVlczJlSm5OSWJXeG00QXZSaGV6TVhya3Vwd2UwL2xJUWxmYktz?=
 =?utf-8?B?V3NmTkxGUURFbHU2elRISXRCa3FubDg3V3V3c0taU1VQL0hNUXhEN2MrK09m?=
 =?utf-8?B?RGk3V2c0UDFUNHIrT3hqTWdsYUJ2bzFzTG1yL2xtVWJpNWVlRFM1VmIzREda?=
 =?utf-8?B?UEkvTXBSMGVFc0pQek1UZktJM2FzbW1qL2x1UUI1S05KTTlUdTN1dEJnRE9S?=
 =?utf-8?B?ekFzeUF3UlNiVHhGRjJyNjh5c1ZYRGl0bGMvaVNqa096MjE0VUowOFBUSjRY?=
 =?utf-8?B?M2pqYjVsWDRWWEpnZFNSTTVTMFFOcmlWVnpDUUNJeWVQM1RZVi9sdWVkME5s?=
 =?utf-8?B?QUtOeDlhaUFVK1YyWkV2UWlwQm5HTTdkd0lKQUEyVzBCaVhISW1yK21BVVl4?=
 =?utf-8?B?blNoRERrdkhrd28yODZ0eEN6U0dmTmJhOWhkanhJQ0YxVHRZelkrTjhkVnRH?=
 =?utf-8?B?YmI5WWJrY2R4ai96NUZ3dlFsWmlTbG50clI5b0cyejdUdUNFRGpSTWM3ZmpZ?=
 =?utf-8?B?d0JxYmRGZzhJZ0lJWTJIVWU2bm5HakVJZlhqYTNwK1lEK0w2cnpJK0NrMFZW?=
 =?utf-8?B?RFcyc2J2UWhpWml2eU0wdUxyZGljaW1SdHJZM3laSFZXOXRPTFQzVkJRVUxF?=
 =?utf-8?B?WXU2QmtldTFZak55OURxR3J3MUZRcDE3MWtyNktCQTlsSHJUWUpOdTRkcDRa?=
 =?utf-8?B?N2krMldZM242eThaSkxZb1VpSk1zNGdzK3ZDbXFPdVdwWXhNTk41M0V0UGFn?=
 =?utf-8?B?TFBqOWc0S1RqOW1zQWJCaFBxdTJjb043cW5YMzVVMVFwamhUM1doeDNJMVBx?=
 =?utf-8?B?Ti9zMGdzcnltd245Q1hQK1p1dTdrU2gzYVc2SGxzN204TWNvYzQxRC9DeU4x?=
 =?utf-8?B?eC8xTjdZVGw0Q1FCODFJRXFFaHBmdnBOOHFOWmJiUDVKTTlzUWcrSks4Y2Zq?=
 =?utf-8?B?eVBzYnd5NHZEM0lKeWNvelhoQlBYSEtHYisxMHIzWDZlazdMU3NhM21VVTB2?=
 =?utf-8?B?SWkweWU0eTF5OHhWZEdXeUJwM0ZQdDBVNlcybE9mUHgyclloakpRUFhJR3hp?=
 =?utf-8?B?Rzk3Nm04RTlpaDVBRHFCZXVuejZiYU4xNmt1OEdUOWdnVUFaR2tVaHBqUUcz?=
 =?utf-8?B?cllrcEtQa3hYWHlNd3c0L0RrN2lacEhucG1XOStETm9qc2lGRkhGdnptM3pa?=
 =?utf-8?B?bEhWdnlveXpLdFJ1K0ZiUFNJUkNsRXEyT3VtVVZsWXEzQ3M3ZnlIbjFvZXY3?=
 =?utf-8?B?U251eStEZW9VdjY0SlE5a3QrZjRmcVNTWHljaUNOWGJ0ckJwNUlueFVqcmh0?=
 =?utf-8?B?bVJnQXpXT0dzNEMwNjYwSjdmbFR0WFgyWWVYakNlRFRSTEh1QkZBcXJnb1dw?=
 =?utf-8?B?b3hYUHplSGIwUjBURjFWM0JmQlpyL0ZkU1RablcrN3o3eWp3UDM1NDZkeHA1?=
 =?utf-8?B?ZmNKWllESGRYRjVnSVpPaW5MWWZCZWx4U3I0Z0NVWDlyejMvWVdRWUIraURi?=
 =?utf-8?B?SC9HMUs4R011MkgxTGxKUSs1dkFnelZzRVR2WE01eXRFbUpWT1VrVjFSTWhY?=
 =?utf-8?B?ZFRFMFI1QTJMTmYwblVCNThnQXkvQUJyWDNRQS9JMjk3bk0zcUg1N1dwNnVi?=
 =?utf-8?B?Z3hpUXVnL2lOU1V5Vmk0QWJWUSs2RFRGRXhrSGNYSnU3b1FFbDN5dlc2U3B2?=
 =?utf-8?B?OG50azNCOU5zNkE2Znpubnh2bDlHb1FBZ3B1V00welA2MmN2R09MVVkwSjgv?=
 =?utf-8?B?dFNsNFhIQXRTYnF4ZUVVQ1hHTGlodWpjbUxCUVVlZjNkcHNxL2g5ZWZIdlVS?=
 =?utf-8?B?YWlxVGJpVys4T2JPbXhkTWhXSlg2T2dFWU01bGJTVi9HYy96cGlwMjdRVFNk?=
 =?utf-8?B?L1VsZmxnZkJ0K0F3ZHRvbU9PZGl5Yi93eEFScmZnR2tNSk5LdUpLWVBMNkpN?=
 =?utf-8?B?alczaHVLb2ZvSk9PRm1sbElBNC9LblVBZzBvWExBbkx1bWRaYSttYUlKVGR3?=
 =?utf-8?B?aVhVMDQ4U3Z3dytiRVFFNElHYlRTVXpIWVorclZDM2pINXZwMXB3cUJTanBm?=
 =?utf-8?B?a25PeXI1cm90WEI5NUI3dnlQY1FHSkdCL3U2RlBVVWtITXJGbitUME0zamNq?=
 =?utf-8?B?TW1UK3lJZzBPRFhYYWZMR1lyQURxVGFhMzhVNGZlQVRXdDdxYzg4YjJkYWVG?=
 =?utf-8?Q?X66TChOE5CFbRKrU+W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8bd742-9b5c-469b-3737-08df020b62f5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 18:13:24.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygCTYKJEcL6Ha4vY3xrtMAGtgpBxM4iNQW5NuNmkN/akuDWQ025zqPgcY9eAecrt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258

> [ ... 14 lines skipped ... ]
> @@ -675,7 +675,8 @@ static void pdev_disable_caps(struct pci_dev *pdev)
>   * This function checks if the driver got a valid device from the caller to
>   * avoid dereferencing invalid pointers.
>   */
> -static bool check_device(struct device *dev)
> +static bool iommu_lookup_device(struct device *dev,
> +				struct amd_iommu **iommu_out, u16 *devid_out)
>  {

If we are touching the names driver functions should not be called
iommu_*, it is confusing..

Otherwise looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
