Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC52C08DC;
	Thu, 16 Apr 2026 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776379080; cv=fail; b=XHMIW8ihS9/jAivNzNRmutuRpoKBzORaxkfIXRlr3H/adY7morjbkIT2NueF8jsuGOnUQWecJOPjbQ1xawRIQulxCg7FdO7UoSI8CJErzvyh5JL8pGMiaVeHBjvH3dNc7fmN2jguBJMpQceNBpmE35i05/9opimc9eX+oQve+l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776379080; c=relaxed/simple;
	bh=i7LYvunWbrSaOBJl7N8w7dSO3/Wa0XQcUazZRXb2Jf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m+71pzvPwZ1LPoUF5tlksx7fsI//1NkpgT0IQA1Q5DQ/wyiT6m6jjy0LB80dfqHmE5oaHfqFpQzj10b25PJ4EKlmoxd/Dr1q9TGRvzT3zZXTXIJ+cp1vLbJgZV/zZpcfcqapFWXpXm6ZNytcMTuC1DkuktP0krLGpUe6pNlZ5Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QtLuCwAx; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QtLuCwAx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSkhj0+ETSCWeXLiKM0NBTlSo54M8TsQyvOlzSUYg9Ns1X4t+5DmyM4mHWi7dtNdDlCHG52Tl76ZeKk14FuKa6ci3ldnmd6mfTpBN3U2n2K9beTFXDAuxeirBNPxSc1Vljcz1WkiR2Jh8ps0PuI7Eq9si+UhpVpJPiEu1sf9JB6p21wG55cnVyCat7w0KYOXasOaob4p8ULFFHfYc6D+Wo3bFxxe4qg0WHFOdu3oHX382v+0qeuseCFJcfHcDzj5rDL7bxe+bKAy4Tuz4roAyVLimYrhcCoONbbVZhZUuCQbewaU66lkvWGAeaZfb8uZxDbaQDpzyb8RMhztOJ9gAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EeWwIBeQmzmpu5xrtUX5rDd/fCiAHZ5GpFIWOnmoic=;
 b=Xr2HA32mXW2zbO8fV0PirGJgGWLYDXsd+PnG0wme9PF0/6BhxvTMCNZht+hE3CzJVQ3aVeyZy/VewyYCPZ/lG4IBJWO7dihJTkJkf+YfW9x0dJRux0fTWZfEWlB1VDUHNAnvWfNMuCfTOD0M/uCuqYNfP/WUr3BbwY2BGxDkJJr0UINwxXTLlHYlq+oUe1b1PbbCYzG4qcbe/REY5dItuLIaz8zmhpotSNoWsuwPhS8ncHInreZ5yYJCmqz1Rmdl7qsFlb6l0hcAwDybezreOt3Q07WZ+RKlxi4zJPCJ4/I8g13s7k0i5l0FvJFr3MqwBQo1Vbw8ISZ6KHt59FZ00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EeWwIBeQmzmpu5xrtUX5rDd/fCiAHZ5GpFIWOnmoic=;
 b=QtLuCwAxZo4Mx0x9OQKlqhMW5zaxaDhrxMmNRTZkdBlu2zQ20FcXuAM+pFdjPp+fpBlL7/tBFxL371/0gMtJmGbom1Y264iIPzFnkUt4x6JiRWe/qHCa5R4msaojvuBN5R6ApJTwENmGl7Ws0FZNHKndHLMBAy72h8iWF6EAH4VRhkZQ9Qzmm3qR+gvqKOrgcPphb1hKZkzPlEDbQ3n6FLkUkDVD7bMFdaYnm1MTj/I1K4KsmIc5sz2schaE19rh/+gZ7hE7W3xkDDRpwgyQkDvXpqOPMjHM3P7Je2umxRhmY7zoeMEA7ToamS/HPOj4z/zGpAIoIE17YUMg6EOx+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS2PR12MB9751.namprd12.prod.outlook.com (2603:10b6:8:2ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 22:37:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 22:37:56 +0000
Date: Thu, 16 Apr 2026 19:37:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "yuan.gao" <yuan.gao@ucloud.cn>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH] PCI: Avoid FLR for NVIDIA 5090 GPU
Message-ID: <20260416223754.GC761338@nvidia.com>
References: <20260416070707.3242381-1-yuan.gao@ucloud.cn>
 <20260416173100.GA13378@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416173100.GA13378@bhelgaas>
X-ClientProxiedBy: BL1PR13CA0374.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS2PR12MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: 901b2aa4-5a46-41b7-a0be-08de9c08ce02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xRbwF3jukWMr+Mn24mVehjdQ7K4WTApJ6lmuccnPqTjVt91M5tM0hKiXDz7LWUXqvDM7mlTuqngZvFmcSlFhV1deM61gwKLKxFEUzHLrfUfjTBZ6Upp17RYCKIuV4HP2EDz4atXP+KV4A2zVTo0nKOz89Li9aE9kRhnVjd+mLS9I+mMxQtfnMEmzGMvkERyum1UsIFD284TP9K6o7FY3rvt+A2+tfHFeB/KgY8TNQZe3vKW/YcZu9AcU2qPhAJmnC6x2AY/VNt3uLQoZz81dH6ZraH2Ex43sq1kbmNLjOjYE6lKyhlfMfS/zbBFWDp70DZaPMcjQKg4+ES8bPL6HDVxc9j0ERUwEADWwjtzCqPH1WYgPJAp8p3EEWQqd/bVmI+P5tesLZzVkidYVrfo6aMaOID98xh5HTJwD79hkiCkQKegEB1IZ4BVVfi8/QsrrzwyVCOD6e0xnXofGrcsuZIecfnniWks7l0mkT4O7Fb5VnO5RpLQNXgMMWcsVJ5LLC9rGnXRCBPe/QNK+u8tpEdJKc40V5WMKC8pXLqGOjwxmrSGoY+ylwVCj8DEETDWFoak+aMf7qKI4MI6FKGSVKZ6GLFhzbWt2LupUwTP2fD3ye0B1RSeNtsJvFefLtu1/useYWTvibfXhdzwygXOEbDeXv2LiuKWji3/9uPTKQA9TWjJ47RXtZsHphwC1t2qxWlcrRModjwuh2pWaxpbWXGckbXRkZ6G3FKbPM69Q6RE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VTfUYFW6tZ9x3/p+m4ROSZ/N+LhWUYLDiT5222nBllZqBgc02axQuYz8PfrO?=
 =?us-ascii?Q?Mj0HfrVtMAE+Q5LaerloOxyGkpgsK9IPxhajqQHoCOImnBymbhXeg8ZjD2AS?=
 =?us-ascii?Q?ib7BncfO+UVj7gcM8jAl75WppJq5v48Tq0fzJAjRTAUsc9a84lKXWu+VzGZ/?=
 =?us-ascii?Q?Xn3UpKRTGfEoemXElteePR45PVX9joDZ1G2Atbti7jWevRldEdBluMXL4X/H?=
 =?us-ascii?Q?/WMGlGdDBH47n+QbmWudofvd5rWtPmhsI8t/oSUmJQG32mi4mFi1p4YbNJ9R?=
 =?us-ascii?Q?nLcSkdN7zVJEK679ak/NRCTq3HVXbCX4FNNttr29H91BCyqK11jZvIkOM4bS?=
 =?us-ascii?Q?VJRyJ5LY9RJA9rKndu+O/jR4eRCdmDHETKqeQ84wXGULXOTr0keG2g6XTKmX?=
 =?us-ascii?Q?zG3MsY8shnn0dDvujnf7po9rF49RqjuWShGi8smMZAxW4AZ7YPeeofqUL3D1?=
 =?us-ascii?Q?eb8MCFD0ik3yLdqKaZaNYctXEIO/wEV3ooIHSKtIyQldnKKEBsYUvrWp7Bhk?=
 =?us-ascii?Q?a3J/kw7Dszj2OqypICX191g3LG1qXFFUbdue3kKms+13CNOdiS+SGNNZ8U7N?=
 =?us-ascii?Q?8gtQpnk+iUA4nDVxhvSW7LzFrPDyOtygVNFBgHpeyiMCGQuGZ0/qJLr2BbXb?=
 =?us-ascii?Q?VGsVXXSqhljCS9MbII8QB5M5KDPwJ2rXX35x+ZA6d6Cue7i1oJ73vb62LZxX?=
 =?us-ascii?Q?4sbU76xHmovOrupJCLY9J0+OBIUUZfYIFtjRR7sGbC+NMydP7YJEeGDTFExF?=
 =?us-ascii?Q?wZb/y31TiFyTA1V6qcdfKoySg23YJ99FwBY58FWKKVuLfXKU6fITdnde0aUU?=
 =?us-ascii?Q?g/KwxzT7eSdqygwtLkRZciQ2AEvJiUnezv4bppM8YcF1JdFd5gWBt9FOqDv5?=
 =?us-ascii?Q?aUn/JNezTWlsfVKrKQXAZUq+XeYuKXjBnOt9ADCj48wy43yyvqrcRbC4+rHJ?=
 =?us-ascii?Q?9IDaYAt1q1GJQWq3docw8HODDUmXHMYPZF6p7S0fj1B9h+nzrGmbRa9kEZoQ?=
 =?us-ascii?Q?seAtnHJ3r5Th6eQTMAh5CiLAtUOJ2DuUawF0hiWJfFi8Vu9qnt5PDgejLpLj?=
 =?us-ascii?Q?9+BYVlvqDKReu/ouDic2eFTkiv7GJ0FklDl/LPKunNIqQGZfsTgJUMrR9Fr0?=
 =?us-ascii?Q?I6oul3V1J9Xv0g6vtEluGVDPv+g0XsKX91RgOKncTgImd/QnHfrhldFhAO6R?=
 =?us-ascii?Q?OkjuxW+nx2p1tBftcKSpP4tMXhTDtRwC+6kC96PSimNvovtoQUEbcMRp9I4Q?=
 =?us-ascii?Q?KrlxUjN8NHB9vmlZ0ipJRTc59VoajW3mrugZ2SCQ26XLmrGEZ+rS/jmhzIoG?=
 =?us-ascii?Q?xJ/VAmfEq2nEh6P+eqkdTapoFMRDext3dDIdEmMKbsy+5ia2EkKr+IbxSXUw?=
 =?us-ascii?Q?ltdkCFfk+t47GG6WBkYFA3yDxJQitw8tRI4F7gXm1jMYtL6x7YXcbsYWhiFl?=
 =?us-ascii?Q?OsmcKscK66FX1poJlqVW0IhKp54Vh6+6jSrVT2Qk+iwhuw6WC40A6VIm13ua?=
 =?us-ascii?Q?kXwUKKFSiuE+UI2y6VqSW5nps1ObdSQdS5DfT+rwGRPbjjxBlBZpuUtwZj4x?=
 =?us-ascii?Q?/JdE6oP3uJ70Z3aIgtg6L6eWmmqbPzcRonxUo4dgFkqGtfChFfARDGaG2Gbh?=
 =?us-ascii?Q?2ZHDcBA39F2icvl6/1dZ06LzF+m8kOIJyn7NRtyNR+Y83dnA+a2spD8bTNZz?=
 =?us-ascii?Q?uwKRjerWdQaENR79Ag8q6oRodxLCx0tlvT/PA9MxM2aEhvW6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901b2aa4-5a46-41b7-a0be-08de9c08ce02
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 22:37:56.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOBwenCloqT4+F2xnVaYuWrCGmg/0ylO8uHDzvOqaactn9f1oPlxnu5O/7pr3DpF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9751

On Thu, Apr 16, 2026 at 12:31:00PM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 16, 2026 at 03:07:06PM +0800, yuan.gao wrote:
> > When passing through the NVIDIA 5090 GPU to a vm, there is a certain
> > probability of encountering an flr timeout during vm shutdown, which
> > subsequently leads to a soft lock of the host cpu.
> 
> If possible, would like confirmation of device erratum from Nvidia.
> If there's no known erratum, there might be something wrong in the
> Linux FLR and wait.

I asked and was told there is a known device firmware defect that
causes this.

So blanket disabling FLR without detecting good and bad FW is not a
good idea.

I suggest Yuan try to use an NVIDIA support channel to try to resolve
the issue with their card..

Jason
