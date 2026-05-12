Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013034.outbound.protection.outlook.com [40.107.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F2E392C36;
	Tue, 12 May 2026 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575839; cv=fail; b=JtNnwh3ENq7hPh+5UilcQR900GZU6NdabMPX/Dt3Ayzw9jC14DqPzAqXoT+VG1f1HG0dd+A02yaoxa3amJn+KDrm8w6ddQBL7k1WMl7VizS0L7XFWHGiNwmKEXj9fPigoAMuR8FeMqXCM05bbUfHsLb+hXCDf2iqMqlAS/RPidA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575839; c=relaxed/simple;
	bh=wmly2BU9iMWVyUyGZfal6r4oVZCn1PmFMhRFNHxSq/s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UuSF+AZZiaS4uuY+BxNgc4DuyB2z1S9vAFYdbCPQzRfMuO5mMKlrtlRyeUvAJH/GU7YEBoxbn0/CaATBlGo1jPBU6b8fna1AdlF/27O5ZqIeeo9h3IaTdVDYVaF8c2Lndy6EDCmXgGDrvhP3kEHK7KTz9NaRE2xPSPHgqGSC/J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DmWSy/C+; arc=fail smtp.client-ip=40.107.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmWSy/C+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeP60HKMc+E4buZDocaTgoJLakLPWT9OEQqbsZ6i5P0oGfjAzhIdQOe49kT/K6UPdvZHT2DP3o67vvXFZR1xxhC2dOiOUpiy6Eq52dU35K1LwsygLPKjVoPBLXvvE0SCI8j7pzqftOA/tYMz1JNGzADEM/1EtZB+ckeC4Q2Fijx57pRlmb4FR1wBzmFh1QCh29kmZEAM0o0TY/vC+faWIe3R/LI9TgHXAR+jqJ0bmMga5N2wV/NxEuhdIpD56dAh9vs/Tum4sOoKSTJ9Bha3SAzAMXNGv5d9PyVs+4WR3EYorRfQ85JmgoDGUDBX2G00bDJhDzmCE1rYW9TQsew80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3LdLYi7Md5XIu970C4vvC1ugoCcp6VmCiC2KAgtHQ8=;
 b=Y0MqkGGiDoTYnR+EqZb9mNszvxzNTe/pWxt62/ClOB9xh/L5ZV7eHpuUMwtKITnpQakQPTDkuA+HzYsGGZo6B7Ab7RWgvSyVMnvNO3+kuPJV+KeGEuHF6Cy6XFjYd116i/olGjvJKrtekDHHLfb+50mFNtRF7SqdM2YupvwoFGBGYH9770XksGak5rmIScz+5/Hyrn8MFXTeQWRnUhTFutxAuExA+yrdUzedbDZRnOpKxDTN24AVOFqV8pTMPRwFCvEnbQHS8SG2WNlLztBYDy01Cb1UzvJLqwg4sG8uqkMqyQxwreo9TWR0FehFpoul2YHoN/ynZmUVw5zQ09YbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3LdLYi7Md5XIu970C4vvC1ugoCcp6VmCiC2KAgtHQ8=;
 b=DmWSy/C+hsoqPP4vOE/HUFiTRZyspfPE1YUjfHPAI7GeuI/lPiI4CbpMG8IqkHPChfeBjcH0CrAP/yuozruFCJm7bO1xPgHAxUwyokmzG6d+5lLUk7wCSkGRbYMKUVEFrwD4vZ5D/gcDgKS+KdFjN1l5yCzFgQ1X2e4i03+XI4ee5811xUphR7PGD6IoEEFLedXJYjIWtespgOZCtZydRVPzVzPT0h2uiqVVRkOwKr28I5O5nUVaWZYBniMeki5f0WuICyk++SE8Rbo17oT6Ecmh4CULosHfadRU9crrR9G0lkkJewuY2fUOP8OKuv21TuALQY8ncpQ0kiHlBNzPKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 08:50:26 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 08:50:26 +0000
Message-ID: <24bd48a3-0169-4877-bef5-1ca0712c1f44@nvidia.com>
Date: Tue, 12 May 2026 09:50:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: tegra194: Use aspm-l1-entry-delay-ns DT property
 for L1 entrance latency
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, kishon@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp,
 hongxing.zhu@nxp.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260512034821.1320714-1-mmaddireddy@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260512034821.1320714-1-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0168.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::16) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab1e951-60fe-41b0-209c-08deb00382da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|11063799003|921020|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	RafzeZR4+eMrshRzlVktRDAY1nEZbi+FBLZubi6vDEu6sANOAGigtW/U6vi3e7AqInWxxW+9TG7AZTl/e9RZZYqzqQgs+UCa3QcsYkt+fr2PPSRb6JixZZTuY7AlJSmzEAm/W77VZDK/fltamUc/attyyTgXv2sTURHBWrB6EKdzv4QgAkX/c1BciOA5DjQpk9NyNJwDZzLsIMBGi7zKEaKZg91PmWNe/j8ChehfvWC6g1vjnKXUz8hh6x0r/6hRu00FM2nj84iNK9cYtUhMZ6s/j/FtzTeaxvxA9xZqioUZ734mzzJRPbTO0oSCm4W2BE96ReR6LKiJw6XdJdQENu9WYArCwnx07iixb+WC2O8Xz/hi4Asjpw/7fJ73gGbHu4JVWFVcVWlJ3dRc/6yIAONk9Tyg6YyBUEtC6DEyf4KkiyMx1a17w3yDoNA9bOBo0DENeq6zijosq/DmHZgfWjktgD8KCR15XUPxrCJhubENc9Fn08HZMQcJlWnsgXXjkRjyrOFJZWVO7KlHWJJKHvEFZQdfQ1aboIa3VqYKyTGuoSRUuVM/hVPAPj4fBNU7ZzyRMDn0LaMw8bDFiIlazhDHoWnQ4fXapDNxSJT5KhFiAx9EJLx+j+azwsF0xNF7gbx4jHuqNt3CCWwBHiz2GaOeJGmDxCZonSf+s3ehRr8tZuj21fCYCFMMlH8Hij134BJCU7yoV/YsRoWP9XVZYN7F2F1Eyaolx5eGC9YGcT0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(11063799003)(921020)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWhxTzYrK3dsd0hxZnNRd1lHNnBidmJDN3cvc2ZRSk1WTUFWd05ETVhOdU9N?=
 =?utf-8?B?V2UwMzNkNGtnZ2ltSW81c1JLbDhJTEQ0U3dBZ0lIWklCaTIrS2dFRmpQNW05?=
 =?utf-8?B?cStqd1FyV0JmMngyYXZYU0NiZ2o3NmlMN3hyK3ZUVWoybHZXelloN09IWTR6?=
 =?utf-8?B?YzRTYlB1NmE5VERad09QYXMzU3pvNUdpdlpybGd2VWxFL2c3M3BTNEFrWFkx?=
 =?utf-8?B?N2J3MTBVK0RwNk1Vdy9iK3pJVlZDdDFsN1FxSVhiMGpxaTB0dzFJQ0JGTUtk?=
 =?utf-8?B?c2NKMHRSWTR4cWxBR0hlaGxWNUl3ZXZRZGNtM3l6K1FWY1VnNXZRcjBxOHda?=
 =?utf-8?B?M0dSODRYdDNMZ3RpMmR4Y1JLd1JlcTNjUmtIeUdQc3Bqb2UwOGRRYnRMZHVZ?=
 =?utf-8?B?c25pNmZlZ0xPVUdpdEJ2QjU0S3VicHlhdE1xK0Nzb1lvK3JWc3Z2czZvOGxE?=
 =?utf-8?B?bVR0NERNYmFsNTFrbjBsRTFrczUxa3FIclBzandqeHpjclJpck9SRjYvUVBE?=
 =?utf-8?B?bTgzeGk4UzJIQzhmRmJvY1NyejFrUnVETXdPSWQrVWlFcjl5akpmYUVxSng3?=
 =?utf-8?B?eXVrNXEzU3JCZlJSQWhHaldMRGk2a3hpemNpYTZUSisxMmdqckNKVjIwbldP?=
 =?utf-8?B?L3pFSmd0TXRrRHYweHZXcGYvWnJTZFpNbGo2YVlqZ0ZuazUrRkRBZ1BHUjh0?=
 =?utf-8?B?UlR0a1BpSXoyK0ZiUEE5ai8wLzJ3Vy9XM2RwN1dCWDNML0hDZVRyWGxoVkpq?=
 =?utf-8?B?RzNxVnh3SE5Vd0RvV3VKMFdBUW5iaXVONEhlV1VqY1UyN2VEcWhYaFozN1Y1?=
 =?utf-8?B?aEMzM2NsQ1BZdGlKN2YrdWoyclNWdWg2QUxNUklRM1R2YStoYVJTaGVhNnZz?=
 =?utf-8?B?cEExeFdDSXl0SjVHYjMyOUZjRzdNWlNVaXg4a1VFQVVKamtoSDhBMnpFbnFQ?=
 =?utf-8?B?TE15b3JnWFVkWThOUmExNkE4SlRwMHNRd05NaCs4WFFndWpudlFRMHNiVVhS?=
 =?utf-8?B?MllIdStOZnlOdmpSZ2FKQnZBdnNFSTByNkdQbnVicmxlOU1QUm40V2xTWUlx?=
 =?utf-8?B?VXZ1a2xzaC9kdTdqRDEwWngrUW9FUnlpSDVRMUQwUHFPd1J6eFVLQXdZK1R5?=
 =?utf-8?B?SHNUTnRYelZwc2QzK1pvRnZYWXl6bjlJL082OW9KZUhXYmxKdFlMbEh5TlJV?=
 =?utf-8?B?T2E4blF1ZnRqQUhlOTlIbER4TDJEbkRjWDVGREMreS9aaFd3aTIzSDdiaURP?=
 =?utf-8?B?cEU4VXVsbVF2a1kvd3ZrN1BDRTRPcGIyWWE2MFlyb2JNVzlzME1VcDBkdzF5?=
 =?utf-8?B?cS9SWncrNU04azNjVGNLbW9pQmxZSDlXb3FhS0FiTUhEcnRjVlloZ0FzQURX?=
 =?utf-8?B?RjA0Z2JHQzJDeFk2bmR2SUozeU1qdmpCUFVzS0QvVi9FdzBmMUlFMUluVVBP?=
 =?utf-8?B?LzR4Y2g5d0h1aUUrT3hMMmRqU21Zby83RXptYVFuSlRIVCs5STFRWUc4S09p?=
 =?utf-8?B?NjNQUUNKS0x4OEJsZklHckhyczd2UlFpL05kcVZiQ2N0MFkrTVZqODlUTWVI?=
 =?utf-8?B?czZ4cndCV3dvT0hNNnpNQXovelBHSCtocUtkbTVRcjEzTjNmUnZQWlYyTDU2?=
 =?utf-8?B?c1AvRHVlSDQvQjhGWUZvNjRhMStVTFh3STNkUlpJVHNUcGNva1NBb2JwWjlu?=
 =?utf-8?B?KzdINDlXbHdZOUZaSEVKaFl0Q1pOTytvUXFsQlVtcmh6VFg0c2doVHF5L05Y?=
 =?utf-8?B?WXBRcHhXcGltQ2VBUXIrbEp6SEd4U2g5aHJGamhUbER3RnpuUWJvS2dyQXFr?=
 =?utf-8?B?amVUZkV0b3Qya0tuSzJiWFdxcmU0TWZNMEI4T2N0RENoTVdCYnd2RzZyTXVx?=
 =?utf-8?B?YUJQeVY0eldSSjFtUVVScml2NW1qK0xIOHdEOVF1Q2JRWktaRVBEYUdPVjMr?=
 =?utf-8?B?T1RQZkpSNWkxY0lyVmVXc0Fpdyt0Zkh1N0NlM0RlWVRsM3hDdmdrN3hMUUkw?=
 =?utf-8?B?QVJ5bVl5SlhhUFhHZ2RQTmpDMlM4UUdFMC9HN1MzdmxDN0g0MHJraUpTQlNJ?=
 =?utf-8?B?NmVaaFZ0L3hoZDM3QWRhNzF5SExHQ1Uxa2owbUpzTTUzNHZxUEIyTGt1RWw1?=
 =?utf-8?B?Ujd0b0ZkcXl4c0NXSGZ3OGt4eGo3NHdWbE1Ka0lEK2t5dXJiS3cvR0VVeTZQ?=
 =?utf-8?B?c0RkYXVpZ09CK1hyR0JZZXJiWEVBRVJjQnQ0NnlPRGh3WFptTkhvdTBJb2Fy?=
 =?utf-8?B?WjY5ZlRGcE5rUmVPQzlzNDlGQVdkUkgvT1c4UE9MVnB3NnNvVHRUblBWL0t4?=
 =?utf-8?B?VVJiMDU3VzNRbFN0ZStueHRTdkZHWld5NHdzNi92WmFKNTNpamUyQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab1e951-60fe-41b0-209c-08deb00382da
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 08:50:26.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3xMKUO5RDiifIMepvDZ55PE71cslvNCXPevh/iMUsWDbfv0RfVC7b/+0XoP5UEeETCq7BsG5RQTe7Lpp+BaPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595


On 12/05/2026 04:48, Manikanta Maddireddy wrote:
> Program ASPM L1 entrance latency from the optional aspm-l1-entry-delay-ns
> device tree property. Convert the value from nanoseconds to a hardware
> encoded 3-bit value that is equal to log2(ns/1000) + 1. If the property
> is absent or greater than 7 (the maximum latency value supported), then
> default to 7.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Fixed commit message as per review comments.
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 9dcfa194050e..c9716d614451 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -18,6 +18,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/iopoll.h>
>   #include <linux/kernel.h>
> +#include <linux/log2.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_pci.h>
> @@ -272,6 +273,7 @@ struct tegra_pcie_dw {
>   	u32 aspm_cmrt;
>   	u32 aspm_pwr_on_t;
>   	u32 aspm_l0s_enter_lat;
> +	u32 aspm_l1_enter_lat;
>   
>   	struct regulator *pex_ctl_supply;
>   	struct regulator *slot_ctl_3v3;
> @@ -715,6 +717,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>   	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
>   	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
>   	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
> +	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
> +	val |= (pcie->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
>   	val |= PORT_AFR_ENTER_ASPM;
>   	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
>   }
> @@ -1115,6 +1119,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>   {
>   	struct platform_device *pdev = to_platform_device(pcie->dev);
>   	struct device_node *np = pcie->dev->of_node;
> +	u32 val;
>   	int ret;
>   
>   	pcie->dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> @@ -1141,6 +1146,15 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>   		dev_info(pcie->dev,
>   			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
>   
> +	/* Default to max latency of 7. */
> +	pcie->aspm_l1_enter_lat = 7;
> +	ret = of_property_read_u32(np, "aspm-l1-entry-delay-ns", &val);
> +	if (!ret) {
> +		u32 us = max(val / 1000, 1U);
> +
> +		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7);
> +	}
> +
>   	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
>   	if (ret < 0) {
>   		dev_err(pcie->dev, "Failed to read num-lanes: %d\n", ret);


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

