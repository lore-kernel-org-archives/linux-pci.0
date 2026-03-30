Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE613D3CE4;
	Mon, 30 Mar 2026 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876870; cv=fail; b=Z5rqWV7uiyfhiW5UlZI+nqtS6PLL+MQ0sqVc1qWXDnP/jrA6eDaerQmpq+vJVivDSgiddKlkxM2hba/LYQQY6Jut+3YmLkxxs1lZCdhWOs+TiyUsILn0oO08vaOyJMuHwbimi9ev3jH14BvRMp2KI0Rbhcn0LFUOWlvyQmOnsw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876870; c=relaxed/simple;
	bh=H9cmJHVd58P3SjKfM+N/xKc6Wnku1RGAdgfeHku5BF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YZXHoCrGMDdXPyysFdENRNLEBKE7S1B0YXFArZY+XcDWqv6XV5DiNxaR155ctla2+STqvzvSREq3TAhk7pXiodzj882YPKBxSXq4rd5Vas22/TRu40MrJmSVakF4itJSluBO9UuB5ODknTycLXE0syfvO9PD1v5p4ZWTo85FP/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pt59DRnb; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pt59DRnb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIgC0Gd2S0jnzmDzgaM4E/khlooUyH6XVVObL1sgsK1uLrCmFyR8tmqlzFUyFAI7D6v1gRIDH4IkerJ5sxVBZGXEUME0a/sCehTeswdqOx9OV38sU17WY7zu/vawSv+k2GrcYWF2zFI+eo5yClaZPSsBmA30F9Y6nC4DObayHR1jNxHYjssJR7TZAIWP9ijrrTzhEBzgHqMmU2lq/gR/L9Oo8yV9ReGaw7D5iLd/rTxkU6/3GeMdzI4Jf8PgzPEYSAd4bVHgc8ISwKsK4h8LNhXDpJVxTNG3C/2mciTQIaACmaMPRd+92XQH1I7jWMWOKBfqDQhp7TZ6lgBr7fwebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7MNagYTCHKI/O84hWOTtls8BqcXHr2lgt5OxKgHLdU=;
 b=TdxRqSzNWv0mvgkmv4xqYAroJtS2LrNyAl+gUehIppr1dzpJ/kf9HGu/DgOYkoWpLIHnj281kBPtQOD8Ow816GF6xvund5oj5cz8MsiI2BlRmSWAiCH6bvecRMT/SfCQ30SyhqAQr4OXQxuNnaxkobFJupkyzJ79SWlfu+a7bgENG/SfZ3veN2wS98nAXNS8L7ByEmOt9qrD3vFSpSGmEUdZOZHYjBa0qrutTQoBAMsehR6iAJEiGP+tqx4RPatJmTpnxyPka7+iRWy6t6+Eek8VoMYGz4sgqyGp5J30hPedlQCVC5vq0iZ1ofQ7r1yE80vvi7DqhonkQABgCf89mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7MNagYTCHKI/O84hWOTtls8BqcXHr2lgt5OxKgHLdU=;
 b=pt59DRnbeWcSFt5fSjOmKcvgZqoEiThDeOvhqWl52uGngP8l/YP2bHK3FWUAfAwC7RQuS0TrOJXScDLFdk+EjUozf27bteiIhn1a6pNAil8PdeNEmSAcUPD+z1EQ3bLyqigPeqHWoUkpmUnQByUSHryRMDWanBzjujaTgUYtok565cMNo5oLaCOpt0nMDTSJCZg7CO4qS4QlkkmBMEXkyvdiSfIAcbv4qNG6FazUqM3nzLhPTVqMfuxiVTQ4ohYJdalBBxDswwzDY0fWh+x08Bxpnn/8V/CnfH9t17vlW4kkhEq6BWxAl5mzINATZOFnBzITvVfTMVwtp6H0UGNvyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:21:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 13:21:04 +0000
Date: Mon, 30 Mar 2026 10:21:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: bhelgaas@google.com, jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org, akpm@linux-foundation.org, bp@alien8.de,
	rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 6/6] PCI: Add the enhanced ACS controls check to
 pci_acs_flags_enabled()
Message-ID: <20260330132102.GR310919@nvidia.com>
References: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
 <SEZPR01MB43997A01AC87EC9CEB97077CDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR01MB43997A01AC87EC9CEB97077CDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: BLAP220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 752e8711-7e54-476f-0f70-08de8e5f3194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HGmEkpfl1xysDW5Pj9mkG5eFzzNwrNcuFICkwN+WQ8a3UN87KVqsDHL2eYC4CVFRoIT4QNP09hZZMe6TcVqGDmol4ZbJvf/1IbaMEO83PCRVGB9C8DQL6SVT+JjiwiXsCJjN4biVct2jJvrSuNfqkXvVVGVVr6w12u4Sfapv1OlCpFeGRsJ7eVLOGTn+fHwrM4TFB6dBy0enCXCDIuCnVEG8ll+kau/gfRmv6G0abFdFGo3N93cZGiTOXnEHyKuxvAGxxVpce+Mb4tbihTS6CIJ/xQAWplPqJ/9ezPTwVxkA9I/8yZ7/AQjKuvHFXufI0KuH4ZUGXDIqDIXEqC738Od0m3BOP0Af/6tDcywJHg278jNcsHQZJNFZCTO6gkXFDnrLTplFndNNXVgov9jZNcUk0cwUobwubouOqQwn76+72BJ3/sWNZ2ycxa4UFupc+8VSuDAl4bTjjET4n4VP63gxHBvGiUzKYwLSY+YiE3JDmvh96M/XFMZ6VmMJwlEVY8Z3h39BPmJAG00HEzXlwO1WD4knUbaH4RUYg4o8CqnzRyaTvYghEBUaF8PsitJANl5FC1WYGMlFZgS6S1JcTABBUsnH9kgYAg91DDe8Zmyvv32Yu5CHq5V74HOnC7jaowiMl2CChaWh2oumscyuhdaqI4Ys+rpNQaYAfk2isTaKxM8K1IqP+YjMrNkebhTemWY49nP2UupaC5DYo6/c2UENNCKaL7fzJW4G+unr2o8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?utZ2MIgEvtTZ3mMeynVsProdJ5hpVfqoh9q6WXv4dj2ZG/DWHuK/bbQALhMO?=
 =?us-ascii?Q?9jcNo9MTRtddJQPiYB7x0znLm2refM954wwZDAswnpT6MqEvgfBSIx4Jo9p3?=
 =?us-ascii?Q?lMx3oTM6SsYsGF89sM0SlT0p8EKnltD9kagH7YhFpObGJPTPp6fd9JEJrUc7?=
 =?us-ascii?Q?K1HjcVcW5qD+RJBCrXli7L12qVea5CFaiNb9AiR3X6XwJEObPM/5fFiaenDr?=
 =?us-ascii?Q?eza1ZRyj9vQfbYvXpLdumPxCYpoGUlG9igC0sLVK/k1YAI6Yl0B7pu9pVS15?=
 =?us-ascii?Q?+vwf3Qukio1LHSvXNSTRfvVihLjn3j3prwEwSjTZBr/AI7XdhtdgcvB7zNYv?=
 =?us-ascii?Q?Wdbjlgh+S7s9LvIEjsPxEv8pZsqcPBCiE8FnfzhL/LRO2KA4XZflgLFoE1Px?=
 =?us-ascii?Q?TmQ+Yy+H+OfXH+wZStlVIzg9Hki6MngeCf/HpaLUlWy2WRjPCWyZhXKTe+c4?=
 =?us-ascii?Q?AHtEg+Yz55Lu7gM5WXb7SgcAR9iFLBE4xh2iJGTOdj2rKDazwQ3jaX5RslnD?=
 =?us-ascii?Q?4SwKq1MiwqIEg306bqGVaYfOkLLAd1kM3pI9Am8F+YzLqFPP6UNYY+Dc6xTl?=
 =?us-ascii?Q?ePB1Ii0K849fgDsDD1v/x5jIN+gjgb4LEJEi7KZGS11aL4wCoish/xmNhNo7?=
 =?us-ascii?Q?lsdxq0fKY8lYSIonEzyEt4uCy+C/QFomC5Vtas6WzWHTIpzLpWB5IsXksUQs?=
 =?us-ascii?Q?3IO+ZUzK8NqTy8C4R7lCq6gDOGbjsayTOCTBAbRt1vjN/siPocEU3GMgtPIp?=
 =?us-ascii?Q?duJnpewbStlb6jWhlgTuBiiopjtPkcY9NWKry5+eD+ZHWNZca5JxgqBGOhCM?=
 =?us-ascii?Q?kvlalTrZTfSvJU47jdqHS7nHbJPAZ6WQoYSV6ZS4eHFpY670mgLVmqPt7/Hk?=
 =?us-ascii?Q?YMMQKdNw6RUIWA+zRCMuQ2qq9gsq3ze/Sg59eAv95koGSa7WcAHo9ky0megu?=
 =?us-ascii?Q?Ftb3UoEKd9zLgZE/dthYQxplnt3Z8M+eeyTINJ274IuAZMOo22AMOp5bvMSW?=
 =?us-ascii?Q?zOTYD7ElSbew7tx+3fufnaEKmg2lxRtBOiMrLiCImE7MOeM4ngNgID+P8Sjm?=
 =?us-ascii?Q?f0tXz01WKOGEIDD95jqt8NZ5NxrYjzBuR/A67nhVSBU7IuPIscKMfumDu6Dj?=
 =?us-ascii?Q?pZ85lSfojrrRqQ3JfIeBs2+v5U0v2UwomUodxCZB+sWI7omAR6ua8ydIQ0Eu?=
 =?us-ascii?Q?X29KqZbgrzK+TkRJqDPouHE+xRsNC4GxGa0b1vRNQVL/rqXji3NMGUULU4Uf?=
 =?us-ascii?Q?bST5v4I9A1wIUysOh5JdsppqRrO5mKS54tjfkMpn7HaTEzk4nIr2UrAnZWg2?=
 =?us-ascii?Q?cCQQDzRS79MxK0lJnLYM9Be5l6FNBgBCMr6DAGV/6vf3lzIn5IRJV4I8v8Jm?=
 =?us-ascii?Q?xlsK9rPC8JgNXyAhmkZIb9V4rPhIcRGR5KDADzZnPnMxkB1Pp+GMI1sCx7Zp?=
 =?us-ascii?Q?dBEYSS7h9jgb4BSS6vktY5BG70COGRy6auPqstx+3AEZZCgXGDWMzlxVbrId?=
 =?us-ascii?Q?CW/DE10W6ipCnYmgwGaslmDkT5bTD77HlX6kP1ByjHsK7nGHbUb343j2sD/O?=
 =?us-ascii?Q?Fkr8C8S8S0oSufqv9pFIQJlEPHn6Vq9rjEwwHMvfXklafatVyKMkMMJZNBNR?=
 =?us-ascii?Q?EWZbgyckPmBiXRybA7GVEsGxHlpziOV3HqIkHsM70709D6ocn0ZWOo/xHBc3?=
 =?us-ascii?Q?Jf2vXBtrOB64AbQYQ8WH1etrKGLvoq9DaDDUanLS3MKoLEuH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752e8711-7e54-476f-0f70-08de8e5f3194
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:21:04.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSBalof84SFrIBDBF28Aby2gcRcIA7w7j2INjTeE6vinwSekC8sJ22v5JWOubdxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898

On Thu, Mar 12, 2026 at 05:06:37PM +0800, Wei Wang wrote:
> The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
> isolation. On devices that support the PCI_ACS_ECAP capability, the
> controls are required to be enabled properly:
> - ACS I/O Request Blocking needs to be enabled to avoid unintended
>   upstream I/O requests.
> - ACS DSP and USP Memory Target Access Control needs to be set with
>   Request Redirect or Request Blocking to ensure the Downstream and
>   Upstream Port memory resource ranges are not accessed by upstream
>   memory requests.
> - ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
>   areas that lies within a Switch's Upstream Port memory apertures but not
>   within any Downstream Port memory apertures get redirected.
> 
> To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
> support, pci_acs_enabled() skips checking for the capability.

This seems conservative enough

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
