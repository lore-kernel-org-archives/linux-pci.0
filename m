Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793322723;
	b=ulFZUj+WjqYHJpSyoc/7Fvw6NMNuuNggesYj3mO+tHImFrsBuMsO0TqIxXKWpl3IAhJq
	 c8pEV+Dk6b1TB6HbNI3lddaVn87NQmffQNwMUZkYHjcjyhnSkg+yuoYrxiSj9zSLLd6lT
	 7vChxy33Zs08k8SDIy1yUBhp44BucaDZhN6CrB/C8hdfBgLvZ1JG+jUrKxIjiJl+rjyIH
	 DXAneAGte28szdAJ6EiR+IbZsTIoYHDQcLQgzFO0+KphyRrgDU+ICkwiOJNWLUMam2WPl
	 xFgiHXr1BEdAOIyYlwMWU1lgfrAXnRuKIS/4Nohi85hcdE4KPaa9JIlrlt2r91ck77A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793322723;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fUsg0xzQ2rGkBWv0Z8Wd1RoynIVu6mnpqm7ao34IOUo=;
	b=ZnOE/yNyUdGwPlGPcfb3fsFgw0MVFeQe83eR/RvLlvDYb2ZL3NulQl7CTFX5mJ/FJj0p
	 UVJb8Nlvxfe0/U63K16uoSU6FywQvyYcXZLOpnZRiibl/GfV3B3PJmh7tqCrm05QSmR1G
	 3SQail0Au7aLQXZ/K5bFboR3nxBXD4MqF6SZOLMlgOPjfArxdkLN3UlIY/7Tk8ad24u7M
	 G71nx4i71jQIlC8sQjCbZIr4gmzyVeKk4oIi4SiU4qPdq2roXv8eQnVxDpW/8qeHk2JOC
	 I/gG54w/3QDbSod0/tC8HTkSWe5O9gMlnY+MQIQv1R8T4tm0dDuUDUNByGtAEfF+RSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="Q880uf/M";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.67
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA62606A31A;
	Fri, 30 Oct 2026 01:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEA62606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Q880uf/M
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xrz+PKv3xYjGanHTYvvxoK0osQQ7OcV30mfojgBLxh5ZeZSyU68MfdKRJBO0Eu5DW8ptrtFA/zVke1VQ6UDxdhbiawa/xAjJKgiUgnDz23iM805UgyBbF541OBIz1DbIJEW54N4F7zSb+EbkWvwnbbBADxl/QWx8jl+AiDXm2e3cx+3Dn9IUb7WuRVVgIudcJP8OfooClgCx32Y4FBZEoU6sWEGwUd3TBuB3RZzD79O8zmwfNn4+h4t0a8gDX7jz8schFaZfriPQHiy+4HEmmbCeZfl4MXAxf+2REuGIdXxTcGVYQa4bPq4IMDT97OHUfDXA/2uRie6XFIaRrghC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUsg0xzQ2rGkBWv0Z8Wd1RoynIVu6mnpqm7ao34IOUo=;
 b=N4xqOYtt8Ri5Jy9pA/L4vQeA0oUYuxVyw4l7B6KlyR6NXGLzgmxu3mEyXwDY9iTc235oFjCTDgjY69cMhce2mH3y0FkRtWSibRIg5kKAWakaR5upkkHcUkiRyx5TQehEYOdnWWDE/d6gj3++y/1lo+ATW9Yb2GQ+zyKPcYztMlyTCLFHh7939iZe6eH3vzLRJ7jSRNxUAVz6k3db5VpQE8X3QShtyFgk/a5c8kXTMlswogA1M4oYaJByJpdyW/tQtQ+YTd/iTAQ9v1Aq3AfAJpYeIlHFf8jyTZ/OweUmH6Fk7OINm+ctI2qAIBQHNnnoxd4KyLAWOF3bI/8R0c90xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUsg0xzQ2rGkBWv0Z8Wd1RoynIVu6mnpqm7ao34IOUo=;
 b=Q880uf/MXS/CnlxYKzfVr7WulFGyd0tTa7TfOcSzXstYXu0vtH+sIPqAIv4drsBRn6f6eqT9F6IVHpyeYpobFDjsG8RFOp+mkaCfHXsyjkTtD8orMHCoJjA+vSZohlQs+2cq40dT87R0lA13hcs2Gry3DumuKmx9qyhgP8CMq3DkNS1YaU6xjYzMWk4Yzl8SkHVqr5AwpE0a+CugIYWxXqa90H6jeTWaOYEF/4AwSwrZ24/6WFexfWvVebeCM/983ypxd8/nRAJYn76cakRn+XsIKfpXtJDbzdyjtsBHWwZ2ewQY5tbXzPMbJCPFe8d1Sk50ouMGmsVgvQ43Sc91IA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LY0PR12MB461782.namprd12.prod.outlook.com
 (2603:10b6:404:233::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 01:12:00 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 01:12:00 +0000
Message-ID: <8263da30-f226-443a-a00c-9aefcee2b3ec@nvidia.com>
Date: Thu, 29 Oct 2026 18:11:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 09/16] PCI/CXL: Cache endpoint HDM state during PCI
 enumeration
To: Alison Schofield <alison.schofield@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-10-smadhavan@nvidia.com>
 <auK7MxeCI2fsUNZC@aschofie-mobl2.lan>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <auK7MxeCI2fsUNZC@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::40) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LY0PR12MB461782:EE_
X-MS-Office365-Filtering-Correlation-Id: c7586327-79ad-4702-e622-08df3622cc8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|6133799003|22082099003|18002099003|56012099006|4143699003|5023799004|11063799006|261022075727099003|10067099003|261028144727099003|261022105027099003|261021121427099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	52JkTaDEFvUYy4+VQCXtAoaDsFOdNwU07fxujIysL05dj6AoRCXFuYj2En2ZY15TH/U/Ee9TZp0K2rsu7/K6FT7MhAK+xA8ag2Y/BWQtJ+RSq2kyXz7LsSRdd7Xt0+/KEgfiFSulJ8WISvWlBcSa3/R0UP1RVEaTosr/W/4P/lYutV6ePZ7Ka0DVXjB17yu1URKFpezuOqLNrh5q7kdC6+1CcMC3vG9W+fAdIJreHRP8fbz6k8Fjss2QOZuhNNaYD2IPnCpw5sCpQ09J+1WlB80p4RJ47+hdeI0XIIjIj2cQ5xmCs+V7JGcuv6BFvWHGQx+HirBmhhIpWxK5zEAe9x9vpu/aeqQowHVZIxw3q04gvqUjrutj2IoeQ+89SNL9bDCwkPwLkkzZnIrwMPw5DkIzUYU+lb8tSoErtQ8BFxLwbTL0h4jLEfeSkYSy15hAhJTd+SRlNIEJv7FjtZirsG20hTzhejPYeshhH9OgzfHylEvr6vIhJZ7AGxk7hcaoFgbhdzTfCa5AIk1m1U6iWQDFBV1wj+bQOCMwfoKzHT5h078Gklp/kun5S0IkQ5AXgJi0s+iBpJZ/caEevIjWOoUZ34KglDwawJ61AnnygJy4PHQHrizoJar6AtPtFhp9uSg0o9VMx1MOn/dsNX5O4tv+hNZBCmOWcggyEu6NxL0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(11063799006)(261022075727099003)(10067099003)(261028144727099003)(261022105027099003)(261021121427099003)(261009223027099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlBVZHd4ZTdIbjlsK1ZOOVdHVmhXaGIwTlVTZVdOc1BYYXZZWkRhcjAwYjZk?=
 =?utf-8?B?V1lqVXJvWExCMFNyb0p6V2FtQ1d1dTJsVVJvcysrZExLT09NT1JxeFlScXZK?=
 =?utf-8?B?YkF2LzJOWnNGYzJNUEpxNTZkRnZxL2EwVjVLZWZmSk9kbGpORlZjSVlGeGxk?=
 =?utf-8?B?eWY2S1hTbEVSK0dqbVZPNGZUdjU3dGNocVJRTVkzVXEvQ1VXZlJ3K1dwdTBj?=
 =?utf-8?B?NTNzMWpRNzNLcDhJZnNWU0lOdVBlODh0Nm82V0VJS3hJRzBLVTlZdWZLVDBv?=
 =?utf-8?B?d21JdTBGaWdMSzBXN3BFMTJjUXhtWTYwL0loeUNnUklibEI5OGd3NWVocFAz?=
 =?utf-8?B?NGNVbUdpLy9lL1RZT3FKMXcxWVg2NVhMSVJuUkVjVFpmZlNNbGNBakpMMXdH?=
 =?utf-8?B?cDVKTHBFeGpWcnZsVXIvTGhuNi9TTUovdnVHZ05lYzFOcml4WldpOTZ2RkFv?=
 =?utf-8?B?V1QzNys0U0I0cXR1eHdVRFVkUEpLc1JLVUVTaEZiZFZkTFA0SHU3M29vTjZF?=
 =?utf-8?B?WDJnTmRSRFhQY2hHc2tKcmthVENybm5kZzdDdkp4ZEtpRnh6dzJpanlLd3Bx?=
 =?utf-8?B?QWZyRnQ2NTF2Rko5WGkxQTF6MWRRbHFiQS9OS1Z5eG9hWkpqeHhscUZKMEFB?=
 =?utf-8?B?bkVSWVhOdFRLUmx3WEw4dU1ZSEJtbGZicUtMQ0xqN1JTZkowcFpRbmNmUE5S?=
 =?utf-8?B?bWtTbHBEaDVJRFRjR1pOMkwvaFA1Q0Vxekw5RlNkaFVrMncwYS8vVXJQcVJX?=
 =?utf-8?B?OEZlRTE2SmV2cnhqRStVQUJYdHZrQlRRK0F5RlVoRmN5anRMU2ZiVy9zejlF?=
 =?utf-8?B?N3FlbHpOaHN4WXpQemVJYUdTaEt3cFZsQnhJSzRVV1dnODR3cUN4Z09tRzBa?=
 =?utf-8?B?cXM2SE1hRi9jY2RZSW5nZ3RCNEdoM1c0MDhXK0tQMlN2a0Jxc0JSb1AzYmhT?=
 =?utf-8?B?akplRjVhd0d3UU5lUVBNU04rbWZ5ckJRSmxpOStuNlhkV093RkdPSFhobllP?=
 =?utf-8?B?WTFyVFhGK0dObWI1QVRKNjRsaTl2ZVNXWkRUOUxzbzlBRG1WZG5YSi9KZWNJ?=
 =?utf-8?B?bTk0TXZXd3cxczRiQWlnRFpNZXJ3c2w5SFVDSEFFalpkYVlxV3NRZW90aHJ2?=
 =?utf-8?B?czJKWmFuQ0xkM0hYWUd3anMxZHdubWVSUVNvdlE0SXdnZE1FR1l5UGl5SnJV?=
 =?utf-8?B?WkZhZFlTaFYzVkY3QUliazF5ckQ3SHZZa0IrU0ozSGl3R1VqVk1Td2IyVVFp?=
 =?utf-8?B?MkdaR0xXTGxsTGdZZ2dGdTVKbXJLWHJqOEdyYlpmVTVFbFVRUUF3a2Qrb3Bm?=
 =?utf-8?B?YzdYYzdVb1dLUzF6Wlg1UVppOCtuU3VhNXpadXNYbHNCdnU2ZGc1dDM2bUFU?=
 =?utf-8?B?RjZ0cnRmU1BGNVBFY1NrVmhtc0FyTkkvaDBWdVJrdkYrQUJ3QmtrQVQyQkRn?=
 =?utf-8?B?RUt2L0RWUURRTVQxclNjdGZxUEpHVUYwaVVKczBiMXBicU9SMWxVdUgzVEZh?=
 =?utf-8?B?RGRqa0lMNnMwOGEzM3RTdDFKSllmejlEWjRkNXQ1QndvSG1HclpBdlBoYmJ5?=
 =?utf-8?B?c2s4VEF3Z1BRUmlxTlArNXpaV2lpNytZOHFydEVXc0pJR3g0c3QyQ056amZs?=
 =?utf-8?B?c2dLUTlZQ3NCaHZqSitMQmQybi96OCtpVXk0ZzNiVTB1Y0FPdE1QNUdJUnVk?=
 =?utf-8?B?bC9md1Bpbkk0blB1NFJPOUFkTW00RkZPY1FiMnlQVkVBM0R3a3FZWUx4bVZz?=
 =?utf-8?B?YkxCY2tGbDlKa1QwQ3NNcU1PU3dMcVpXa3JYc3NTT20xMVJ2VGNscUNlL244?=
 =?utf-8?B?VE4rM0lrS3plWitFZERibkV2WXJXMWRvV0Ivelc2ejdsdktiUjFmeEpzSGxW?=
 =?utf-8?B?Q2lvR09YZDNXU1N2L0liaU5BNjVRNDdmT3daYzc1YjlNSjRaYWM4NVd0MWY5?=
 =?utf-8?B?L2ZKWmdvSDdjMEhneU8xQzBObEVEamdnK2lJenY5ZHd3cXYzZ1JmejlpY2Jv?=
 =?utf-8?B?KzdxZ0V2NEVHL2FtYmEwU0VzOTQyUXhhTmJtcHJzZ256OWxpNm5NTmVYblJi?=
 =?utf-8?B?WWJrVmt5VmxCaEkxM1k0Zk15OXV2RkNncjRnbGVtR3gxWlZlbnF3bTk4bnJy?=
 =?utf-8?B?cHV2YXVNbXB3RkoxYmU1Um0va2w5SDJRcXNPeE5Nc2RJT1ZwTVpadnJxay9F?=
 =?utf-8?B?T2xnLzkyZmZUSHJLc3JmNnltRll0WXFRUmhLWThSNFZWTWlGNndESmpXYXYw?=
 =?utf-8?B?RmtaQWhGUVlMbDlkdWViT1hMMGdkREpBRk1xYlBOVnZqTHQvVks4ZmFjQ3hI?=
 =?utf-8?B?V3MzNHV2R0NUR1pvV29PY2NYcnFsRGdCYWtTaUJKZjhZTkZMbmVpUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7586327-79ad-4702-e622-08df3622cc8c
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 01:11:59.9792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34x2YKSvK1uMd90FgyDuAkwCc91QzstXhpphHCZnkS6Rcb0dJvROaEheN4GoFX2/+ZCmpPtnYaLrVgz1GaAFsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB461782

On 10/28/26 8:19 PM, Alison Schofield wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, Oct 11, 2026 at 02:14:15AM +0000, Srirangan Madhavan wrote:
>> Cache HDM state in pci_dev->hdm after BAR resource setup and before driver
>> binding, so reset can restore it without a bound CXL driver.
>>
>> Save the HDM register location, decoder settings, and Device DVSEC state.
>> Validate capability reads and decoder counts, and restore PCI_COMMAND
>> after temporary MMIO access, reporting restoration failures.
>>
>> Keep PCI discovery separate from shared HDM helpers. Move cxl_rwsem into
>> built-in state code and protect cache publication with its DPA lock, so
>> the cache remains usable when cxl_core is modular.
> 
> Hi Srirangan,
> 
> I felt the large-ness of this patch, so I'm coming back to the top
> here to add this comment after doing the inline review below.
> 
> The commit message doesn't mention much of the preparation work that's
> included. Could that prep be presented first in prep patches, and then
> add the new code?  Something like:
> 
> cxl: Build register block helpers into the kernel
> - regs.o moves from cxl_core into the built-in objects
> - devm_cxl_iomap_block(), cxl_rcrb_to_aer(), __rcrb_to_component()
>    and cxl_rcd_component_reg_phys() gain exports
> - cxl_find_regblock() and cxl_setup_regs() move to include/cxl/pci.h
> - struct cxl_register_map gains bar and bar_offset
> 
> cxl: Move cxl_rwsem into built-in code
> - a new hdm_state.c holds cxl_rwsem and its export, and hdm.c drops it
> 

Thank you for the break down. In v16 I moved the preparation into 
separate patches before the PCI HDM cache patch:

Patch 8: cxl: Move cxl_rwsem into built-in code
Patch 10: cxl: Build register block helpers into the kernel

>> @@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>>
>>   cxl_core-y := port.o
>>   cxl_core-y += pmem.o
>> -cxl_core-y += regs.o
> 
> Does all of reg.c need to be built in? I'm implying that that you'd
> only build in the part that PCI core needs and leave the rest in
> cxl_core. Maybe moving more code around is not worth it. Just noticing.
> 
> 
> snip
> 

I understand that adding in reg.c includes the unused parts of it.
But I looked at splitting out only the helpers needed by PCI, and that 
would move roughly 300-400 lines into a separate file. I kept the whole 
file built in for now to avoid that code movement.
Please let me know if you feel that this needs to be moved after v16, 
I'll add a patch for that.

> 
>> +static int cxl_hdm_read_decoder_settings(struct device *dev,
>> +                                      struct cxl_endpoint_decoder_settings *settings,
>> +                                      void __iomem *hdm, int id)
>> +{
>> +     u64 base, size;
>> +     u32 ctrl;
>> +     int rc;
>> +
>> +     ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>> +     base = ((u64)readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id)) << 32) |
>> +            readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>> +     size = ((u64)readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id)) << 32) |
>> +            readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
>> +     rc = cxl_hdm_unpack_decoder(&settings->config, id, ctrl, base, size);
> 
> 
> This duplicates work of init_hdm_decoder().
> Could the new shared helper _unpack_decoder() grow to do the register
> reads also, so the code is shared. Also, then you could do the reads
> in low then high order, like init_hdm_decoder() does and like the
> rest of the CXL code reads its Low/High register pairs.
> 
> snip
> 

Done in v16

>> +}
> 
> Add a blank line before the final return please. (subsystem style)
> 
> snip
> 

Added in v16.

>>
>> +static void cxl_hdm_cache_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl)
>> +{
>> +     guard(rwsem_write)(&cxl_rwsem.dpa);
>> +     if (!pdev->hdm)
>> +             return;
>> +
>> +     pdev->hdm->dvsec_ctrl = ctrl;
>> +     pdev->hdm->dvsec_ctrl_valid = true;
> 
> 
> 
> Could hdm_state.c add accessors for this, like the existing
> cxl_hdm_cache_present() and cxl_hdm_cache_publish()? That way cxl_core
> doesn't write pdev->hdm directly and the dpa locking stays in one place.
> The same could be done for cxl_hdm_get_cached_info() and
> cxl_hdm_check_decoder_count() added in Patch 8/16.
> 
> 
Done in v16:
Patch 9, cxl: Refresh cached PCI HDM decoder settings, moves the decoder 
refresh and decoder-count checks into hdm_state.c.

Patch 11, PCI/CXL: Cache endpoint HDM state during PCI enumeration, 
moves the DVSEC control update there as well.

These functions take cxl_rwsem.dpa, so the callers no longer access 
pdev->hdm directly.

> 
> Can this function end in a single return, with the 0 or 1 result
> in a variable, so that the cache is updated in one place?
> 
> snip
> 
Fixed in v16.
>> @@ -200,6 +200,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>>
>>        return ret_val;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
> 
> 
> Why not EXPORT_SYMBOL_FOR_MODULES(..., "cxl_core") here, like the hdm_regs.c
> helpers?
> 
> snip
> 

I changed this to use EXPORT_SYMBOL_FOR_MODULES in v16 patch 10.

>> +static struct cxl_hdm_info *__cxl_pci_hdm_read_info(struct pci_dev *pdev,
>> +                                                 struct cxl_register_map *map,
>> +                                                 int dvsec)
>> +{
>> +     struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
>> +     resource_size_t hdm_offset;
>> +     void __iomem *hdm;
>> +     int decoder_count;
>> +     u16 dvsec_ctrl;
>> +     int rc;
>> +
>> +     hdm = cxl_pci_hdm_map_regs(pdev, map, &hdm_offset, &decoder_count);
>> +     if (IS_ERR(hdm))
>> +             return ERR_CAST(hdm);
>> +
>> +     rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
>> +                               &dvsec_ctrl);
>> +     if (rc) {
>> +             rc = pcibios_err_to_errno(rc);
>> +             goto out_unmap;
>> +     }
>> +
>> +     struct cxl_hdm_info *info =
>> +             kzalloc_flex(*info, settings, decoder_count, GFP_KERNEL);
> 
> Move declaration to top of func.
> checkpatch should be complaining about mixing statement & declarations.
> 
> 

Done in v16. But I rechecked and for some reason checkpatch is not 
flagging this.

>> +     if (!info) {
>> +             rc = -ENOMEM;
>> +             goto out_unmap;

> 
> 
> This returns the __cxl_pci_hdm_read_info() result from two places, and then
> has three more returns after a failed PCI_COMMAND restore. Try to end in a
> single return. Li Ming's suggestion to warn and keep the info on a failed
> restore would also reduce the tail to one return info
> 
> 

Ack. Fixed this in v16.

>> +             return rc;
>> +     if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
>> +         !cxl_dvsec_hdm_count_valid(FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap)))
>> +             return 0;
>> +
> 
> This cache is built for every function w CXL.mem, not just type2.
> So I believe we are needlessly reading Type decoders at PCI enumeration.
> 
> Can this check the capability bits like cxl_reset_function() does
> and limit this work to type2 devices that can use it?
> 
> snip to end...
> 
> -- Alison

Done in v16 patch 11. Cache initialization now checks for CXL.cache, 
CXL.mem, CXL Reset, and Reset Memory Clear capability before reading the 
HDM decoder state.

-- 
Regards,
Srirangan
