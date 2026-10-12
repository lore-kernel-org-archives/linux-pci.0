Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB543DA53;
	Mon, 12 Oct 2026 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794231; cv=fail; b=RZ2au5ZB7PIjNxIcHYz+sHCaWQeS7u40bKbjq60NX6z2dzk1088pfr9tq0ATMTSCFvMi2KLn6nlzC1pqGVR17FY4lRTKwAJz7l/MOMWqnDKK9fFQSpifWcjf7p7Y0ZZ5K4w7jGEZtG2ezQX2pOwBL0KkM+QjokBHqxr4/TUTfaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794231; c=relaxed/simple;
	bh=pqFgjbIXnpQB4rz+KJSMMVEkvAqNm6iXWyKj/yqZdhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r1je4ft3jNCHB2dtsFCwGbdnjUXQvT/RXHxq/Us9ysnoP8fXW4dSlTnGNeTJYSIe6cLSWPiunTCDx73HydniODtq+zF9UApGXJJe6wPLBwMkWX9mriIeUGEO/1aX7MIe3hUGdoPVXBA9sRvEk456z6e6w0SfEVZy/yAGolzqQE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nPRTSPHJ; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nPRTSPHJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQjgyytUHUAkm2lCXbtAGdDmKL9iSPAsP5Z+FRWdlZbou+xSBnISH/+8umBtP+Q9ZizreSkrfzcwG6lvrZO3GLYQG8OKVWknpsTejFuWhEGkfvX20ouzOtF75eM0ju2WRTJ0y5rMqGPSioJ3CBEQz6oCv4uAWBOXSOgPTC5cxuOrvYzZI7gOY8CCeqecP2nldxD+OnKfWVoQ22nOviV9I0uXNcqMYYSW7tPEa0Jm4amQBWOcZ/hhW+gjwOWBzFWiEEKyWRbJTich6pt3mrBN8f4u0zHW9VNI8tAfyUy8z2xB0bxKBw9nHlmR40eEBDPnIYyVLEI1KBTt8VWa/rbeKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FGiZhE5BmNvUO55jfJpcBAKRCbZw2/vg5nr90UkHQE=;
 b=EUsqmzQ5pY1qM9rEa7kR5i7nyDCurINR6DaDxmtGvdF8VyGGNETFNIZzMDyaQJqOgy/pdV4nKggRTHTCEp1HBIcjERIq4L/KPxea5t8b6O22KGBxt+xHVomIbMowbKLH0MmYUn4LnRheqkj37RS+MwZa+u4+bFETFcNXfWfueu3nV0Ty7UoLJgEOMx/VuSGu7clEEww7AFHyHop8XT/HM9wbQM+6h3jy9+6QaZZBN+gcQAAM0NxrYdrL313EzCl7m8RRVEKKdyuTDYcX5xrj04s941an9gXrY5CdJxVQPG2iI7Z53jIVVTwh3oIZjtgZJV8/QW36nKLgbOfRSnAvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FGiZhE5BmNvUO55jfJpcBAKRCbZw2/vg5nr90UkHQE=;
 b=nPRTSPHJ7GAS/jR9txv0UkNAqSvz4iRjIUic2GMgZUYUQR2C5ncdWN9EUXdPIeu2gONpozBbGIv7e/G6+oAcdHJGw9XKMqn0VPDRrhJg6Hr+NWq45RAAufdxAH592E2/tEDZTIqz/P+PCmg9t4B3lsj9WuOd7QhZ22qTlOwcdTGy9F6VLpn21C5gJAyh1q3FCbxMdSfUwud18byqa8ooSfShWO5ACkQ03P02vhGmFqJz5X89rhSM7cDmq2ynCDyLsYVkEGhJdmRw7gx9MN4VRKf4qUs07frHxzh3L3S4mOipbtVlHuoQi//3kbdciYcBguhvDOM7Qaq/AtxJALR2kg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 08:37:04 +0000
Received: from CY8PR12MB8244.namprd12.prod.outlook.com
 ([fe80::d30c:fb69:3020:73e3]) by CY8PR12MB8244.namprd12.prod.outlook.com
 ([fe80::d30c:fb69:3020:73e3%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 08:37:04 +0000
Message-ID: <923d7875-69f7-4c87-869a-fc66727c70a8@nvidia.com>
Date: Mon, 12 Oct 2026 14:06:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: tegra194: propagate REFCLK select GPIO errors
To: phucduc.bui@gmail.com
Cc: Vidya Sagar <vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>,
 linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 kwilczynski@kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
References: <20261007104847.507776-1-phucduc.bui@gmail.com>
 <20261007104847.507776-2-phucduc.bui@gmail.com>
Content-Language: en-US
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <20261007104847.507776-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::17) To CY8PR12MB8244.namprd12.prod.outlook.com
 (2603:10b6:930:72::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8244:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: c9fae117-225e-4cdc-55c8-08df283bfe22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ftPXAp7JnoKggYRBHKLf9wQMb/3XAwjrAk7AGxWC1Kd5l2tX1sWY1EqfIRMFYLFmRqata6gX53IorqCh+bdcwtT9FrDiH0CfHKoSsa+aLU7rkFP9pWf1MKqgm4op50VQ6tfPBFJX/0Jc+vo7F9Dl+FFmpYDx8pkAZt94284AF3jr5QBDp/qbkjI7XVfituqbwzvirTFUb2mprGc21oLniuekI3ZToiBhldSYgXgcXqH1osziD75zsnVvwskSSny+jpnmGSla8TVEvTVcU+fkd5BIcpIGyLVH8NwmnZSEYoJ10NQmE5GTvnD6DA9QUxOS19b8iO5DaaEwA4ukS4fkHJpw1tp6v0Det9EZ0bE2IceW5RiAZRh9j2GDhvlhHsAgY/uR9F1phrvLIVsMqec6cAfBk14Wc+SRqyS+V4wgJV24ohoMsI8j1W0TBUyX6xdFSTU27LpJce1FT0mmlLPRvyAE9cMttqDmspOHoIGn3RkOAxLcmYyy/XRaZMalVBdXxItVwQQ2pUSLUNR/55bMKTxWnbnReRUDdcEZqN6wScbdTfOgvMJtIBYpM4nNCjVGP360iYfKs5xomKnhOPUKZzHB/i7z9W91HOdPllVQiU6BykpuhwVaHwD39rvENr0HF+yXitaLBtVKqDs9hbD3SUyMP3SnGLJJ7aYpOwouOlE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXUxajQ5QmRWdEhXK0dZVnUrdWFZeVdIMmcwZy9JaGJIU1RGVGZ5QW9IZS9l?=
 =?utf-8?B?MnQyY0llQzFKUm5XQVdNYmg0dmtYRVRVaVlJQkluNlRlVE91SkdnaGhUZ0tY?=
 =?utf-8?B?M25KTXVmdzFybk9lYWlJR2xTNWQwUE1nSkJPclVKMCtwSjVYZW81WVdvSmlN?=
 =?utf-8?B?UlVLWHcyelBEcWZ4UFJYaHNOaFlURzNORGJGVGEwblE1VGhQbzlTSzBGRXox?=
 =?utf-8?B?alo1Ym4vOXZZL04wNitHOHplWFlpd0xqZmE2L0FDRFg1R0tJS0FDQi9tZTJs?=
 =?utf-8?B?RXpZeDFMdCtIOUhVemJjUjhHREJVN3BmZUszZ0QwbGtLMlVieFVqQ2szTk53?=
 =?utf-8?B?RzhZQzJVdUQ5UnVzM3NSZUlRSCt3M2RHTG9wMFJMT0lFS09VTFJ6Y3JCR0hR?=
 =?utf-8?B?S1FkYXIvQWpGRnR4NkNQV3o3U1ZJY2xOb0k3WFd6TlljM3B3bjZ1QjZKeGs5?=
 =?utf-8?B?VTNlaXhwVm03ZVBFRStxd296VGY1ZmpmZXRhSUdwYm9zQnZIdUowOTYrb1Nl?=
 =?utf-8?B?cTRSZjZCK3hLeFN1Y25hbjZ0UXJIaldkUXBHK1RmZ2x5N3hlZFVUWGNtL1U3?=
 =?utf-8?B?cU5RNnBHdC9vbm1EbFRlY1B0L01URzFRdThRNGZ3NFVmR3BuN01tb09VamVC?=
 =?utf-8?B?UDVMUVNpTXJhUm1iRTlZbDNtMUFBTXFUeS9rbVdEcUEvaEZPRVduQm1kQzZJ?=
 =?utf-8?B?b0YvQWlZZnFtNWFjSXZQMnVLd2VKSjV0NEZaKytLd2xoWkRGZXpyVjJ4UndC?=
 =?utf-8?B?NjVoN2x2T0FUMlZQdGFDWmc1QllwL1p2cnhOUWlURDB2MmFkNHlrWXYrcHdC?=
 =?utf-8?B?clNIK2V5MzIwV1ozQ3puVWFSNkNkZ0RWcmZvNmhpQUdZSUZ4d3R2WGVicGV2?=
 =?utf-8?B?S2grL1U4d0Y1ZWZNWW5WdHlZQzZJQWJQbTMvV1hETDlmdUdXR2NuK3FVZnBy?=
 =?utf-8?B?MGkwTU9UdXpGWFVRd0VxNWc0ZlNjOFN6bmw0cnc5VnVUd1NBekhiQ2F6dHZk?=
 =?utf-8?B?VjNSTm5vbloyaEZoR1E0TG82YnB3dTJTZnIvdVBsVHYxSjNvbzg5TUNHbElN?=
 =?utf-8?B?NFhrMS81Rit3Q1BybnViN3E2SDR6ZEQvNElxMVdzZjMxWVVjZ0JoL0plMklI?=
 =?utf-8?B?TTJ0TVpWc0xtb1U5VFVZZmJZMlVUa3lSZ3RtUnNneDZjQ01oKzVMYmFZUmNy?=
 =?utf-8?B?TlRrQ0tDalBob2pNQy9XdjdyMzU1VFVJeXRLSXJFakx0ZmJ6V1lmQ0Y5dXNU?=
 =?utf-8?B?bUNYdlMzd2lvNnY5OXR6c2FDYmRMbDZlOE1Oc3NlUnBSaTlndmlHRVBiSjRj?=
 =?utf-8?B?bFJXSmd6NUk2dS9pcWJ1YVNRMUJ1QVk3d1JoTisxMnp6Y0xyYWZiWlNGZzBi?=
 =?utf-8?B?NkJGbmRkVkpGUitCNURUTjh0aFVVSjZYQ1F0TkNSUXpXbTlwSXRhTmUwazZU?=
 =?utf-8?B?b3ZhdnNwUFBndlNhVHRyVkI5OHZQMUZaVU1QSWNBRTh5djVDOUhYOU1xcHFF?=
 =?utf-8?B?OGlNTUZaZXJndENPcmF6a25EeFRHMzZkMWJpdE1sb2h2eDlOQUFiZElJbElH?=
 =?utf-8?B?cnJYWWZCZlhyM1cvaW1VVGtVZW9DODNCRHZwYVBhMnk3M0RXWVg5Q2NxSVdi?=
 =?utf-8?B?dk8vMTU0TXp4Z3h1U00xOFFtZWJndHFtL0Z5aHlEQS8yenZ0cFR5clZiRHNu?=
 =?utf-8?B?TWV3dm1UMm1PVTNqVVJSbFZTTitTQlVKUEJtVjdBMVRpODRodG1xYUJHdnE4?=
 =?utf-8?B?djVlbmdwei80aUN1SU5IYWt1RTR0QTgrY0IyaUtPNDZWMkpTUm10NloxV1FC?=
 =?utf-8?B?NU1HRUVpcVo4enZHdldSZG5LQSt1NFNtUERaQjhKZ0wxRVVaZHdXaWpGTHJE?=
 =?utf-8?B?OEpTWkdteVFIUGFVQm5XYjlWVlFBTStvdUR3STA0WFlMVlRMMWttVGpxcjhQ?=
 =?utf-8?B?dWhWcDRwbk1jeU5OVlVlSjhwOUhBelRFdCtzcHN0S0hPeXVVMzM1VU1CdVlk?=
 =?utf-8?B?QlpkcHN3M1NwSGhEbUVtcURBVDhZRVJ0NW1tcXlVMmJxOGxjZXUycGkxUW05?=
 =?utf-8?B?bnFjMmpjejVXTnJWeE5zc0thQkY0M0F5d2tENVRLV1dEeUV4NWNjenlvbUNL?=
 =?utf-8?B?ZFVXWU1aVVRKV2REMXdzQ0RaN3hPK1BxYjJFNGNKUmpmcXpGdlBnTmxhcy9k?=
 =?utf-8?B?MFlPMjRYVHo4TlZ6TFFEOUZBVWZiaGhIbkt6SE1qZVdzNDJERVR3bWk0Wkcv?=
 =?utf-8?B?bjQzeTd6VGErSzBrT2dCdmNDMGx1b2ZzWEtJckRHNFJwNmUxWG01WkpQMnVz?=
 =?utf-8?B?ZUNMUVQvVllYdng4a2dzOUhuRUZBalF2L09LdGh6cDB1Szhsbi9IQWQ5dnRx?=
 =?utf-8?Q?2E1idOfkwV6ksvJo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fae117-225e-4cdc-55c8-08df283bfe22
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 08:37:04.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKloLaxddiPuqPeUCtjFnUPKi4QDo8CvPb7xpMTAYz7WRLA2CxfUGqYAO39TNw2acWAjH0JXoml+A74uRfZrpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512



On 07/10/26 4:18 pm, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> devm_gpiod_get_optional() returns NULL when the optional GPIO is not
> present, but may return -EPROBE_DEFER or other errors.
> 
> The current code treats GPIO lookup errors as if the GPIO were not
> present.
> 
> Check the return value and propagate errors from the REFCLK select GPIO
> lookup.
> 
I published similar patch 
https://patchwork.kernel.org/project/linux-pci/patch/20260923072237.1139013-2-mmaddireddy@nvidia.com/

I am OK if this patch is merged, I will drop from my series.

With the subject line capitalization style fix,
Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 767e11216196..5ebe01f72833 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1207,18 +1207,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>   	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
>   							     "nvidia,refclk-select",
>   							     GPIOD_OUT_HIGH);
> -	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
> -		int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
> -		const char *level = KERN_ERR;
> -
> -		if (err == -EPROBE_DEFER)
> -			level = KERN_DEBUG;
> -
> -		dev_printk(level, pcie->dev,
> -			   dev_fmt("Failed to get REFCLK select GPIOs: %d\n"),
> -			   err);
> -		pcie->pex_refclk_sel_gpiod = NULL;
> -	}
> +	if (IS_ERR(pcie->pex_refclk_sel_gpiod))
> +		return dev_err_probe(pcie->dev, PTR_ERR(pcie->pex_refclk_sel_gpiod),
> +				     "Failed to get REFCLK select GPIOs\n");
>   
>   	return 0;
>   }

-- 
nvpublic

