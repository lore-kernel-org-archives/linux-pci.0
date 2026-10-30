Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.56.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793341619;
	b=oiY20X/s4zVr1Y1icJNzZa80qXMuQhZxNCLo4EDRM1oeiWKMrln4cJLj7D6amOgPyMJa
	 zcF7rIwuxbTUZDPi4BNDP0w8BIQ89BvNb+D0sIs1kfaxudorKQn2gZdHSMJqMY0loqNcI
	 ZkyrjnFMQik25cPnOenq692VjrpcxWOyTWMVO/PrzwlFRQRuLNUf8eRB3y+ijyR3APuns
	 /E9RwP/TZU+fx+C7VqluiQmhwdxgAv4UwNboGJro6TcGAIbbkE7CXtqD+TymRqGVp6nIG
	 v8As/ccluqgDwKyzKVAohy92TJMHi2roZVDVMLOeUHZGX6a0yiAZMhd2D+y4+lF9EXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341619;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Ad0cNmY3VVbVRL4wX976lXycui2SUDea8wawRCsbSvU=;
	b=H6oBx4DsO1RD46ETVo2QllQQHnn9XlOBNMoM9mIGrwb8J+pxyQm+1k+FwjJlgMvyeurN
	 fEED38tJs6QdYUCzBS76kSw7ejKIX6LuGr07Hy2OFa8qikKBRFmccWZ3J1iwHfJm3LRWp
	 kEfoOnK2UbkPDz17/CVa29WQWeRS3eCSB1AsBdjpX/iFaC6kGxEeSouVsuZUsFPmN3+8f
	 rcpYtjbMldwIv9VLuot2unZKIVOk0PX0ak5pUY8I3wIMFiZ05K5LvzqqiYcojyKOFECNZ
	 2tNU/uGbRZ1x/ft1qegleE/HefNk3w6rhhblqR9bkNojvFypVxT8HklAnomq211P2Fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bS71uRzl;
	arc=fail smtp.remote-ip=52.101.56.71
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C19606A31C;
	Fri, 30 Oct 2026 06:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C19606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bS71uRzl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hexbaFBwRIxZT0I0ZWycpNuVAJcqMTa0ep7Nt04COhZppAb3UXaU//3cYVSeFH94zITPwj+THtRr2etb9MH2j8sYnR0TiZtoiplwEkz/FpyofOWDcIqdEnMwnZwkSUm3xMMrAZy6x1+zkpgHzjyWz6cre5YW9Ab91kKU5Sb7byCEwyQRWbovPkpADzCNPqVdEQ31+cYaIBvKVNWcDSUjORJRKw+BcHZuYIhnqYTB+ZixEYTMtqBwT7oCDTIxRWyWU8hGliU0sfCGx0ZiEdRdXPTNBu/zZqpef4yDeLjKU3MYEV17mXGfk/J3ddKHagVBBv2c8lkK9YLHOFo+tSuviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad0cNmY3VVbVRL4wX976lXycui2SUDea8wawRCsbSvU=;
 b=pZqjnFKeVBqDZ4+J2iNylN4Wi0Bh4HWoUMd/c5hAXfXiIhFaCdlHQ7x6iR8U3Jf1y1qXLCTY47JuvvViuOaGS62IFSKE6VTB3I5nLuVik6WGsltN+M3OwERMK1GUMedrv/JbG4ffAI8VGV6QQ8tfXHHnNrbn2HzwPTlCZZX+dXt1LzjxrvfYzpD2FzfbPXfQfeH/+CnkbfR97jJFE6cvtxYvG+oKfmrtOkY3dJ7tzXki2/U2gebvwfmadql76RPQjSR109cWBdthi3JrqFH7IOvBLBsWRlJnJTsCfgmV2intNQvWGQilb6B7doRxBOOE0Hm5mQbC83AZl8O3YCS/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad0cNmY3VVbVRL4wX976lXycui2SUDea8wawRCsbSvU=;
 b=bS71uRzlwIS2gmcMRgSBMuaHB9tZGu2oziR3fOZqXBgFSAYi5Bql+BF5hXXfu4gXUYs7fZ6Pv9AF4dXRQoC58VCMnGi1iBntmGR20jAJA2dhY39WbDKnJHy2RHLe8g3x4rEZsmRkSPBXpZEK7mbxwJtCej9FMt/sOzHFC8d2BsMooeJGLfiWwRejKuERIAkkEwKT4qZNiTyJ/mVj06w3vGmcqOVNJ1az4dI3reXpCE+cL4ChDxlqTTGuwEp0arobuGi5oopFafDHIytwPMNGTvPF4aKBzdYzfVR4evCO2gC9F3hkR8NrqFHqwo4YJpfDYcJzftxU74p9gm4+DAwvhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CHAPR12MB999226.namprd12.prod.outlook.com (2603:10b6:610:2ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 06:26:53 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 06:26:53 +0000
Date: Fri, 30 Oct 2026 14:26:47 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Li Ming <ming.li@zohomail.com>, Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, 
	alwilliamson@nvidia.com, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v16 08/18] cxl: Move cxl_rwsem into built-in code
Message-ID: <auQ4mKIRuMbaXH3v@MWDK4CY14F>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029145703.2185231-9-smadhavan@nvidia.com>
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CHAPR12MB999226:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f70d4fa-1077-4603-7611-08df364ec99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|4143699003|11063799006|56012099006|261009223027099003|261026121527099003|261022113327099003|261026140227099003|261028144727099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	PK6yvyuaFXhxLqH76vi1+vpzlG+8+5YGQ7xn0oMXGdRfNnKKl1TkEarX9OQ+rFIIhBuVBjGGEiPYIraoHS1zWdVzEN0Et9T8PfspMT6+QHMUx+1CSyO2agKpsO8mCP1xwonz0KNElI5S1PZC2a2Y8gVjompfArpO+BvlqYSQowF3hLhiGw0ZJRWIGVpimJGuJJ3V9tB46rmgJqGYszUYSZ+7GIcIvsa58wJgUmbOPCEPLO1tTz8fb+BJCi/cEKY+XRGXFaDp99f6GSjP8S3QV76GNOrakWnNZwfEoDfA0dgLvXZjHDs2SMh4BzOAVD4d9iozD8EZUfcUWX+pVf/5pKccQ1Gvubplvs51sG23Af6ZlhTlrclc9FmrTKe5AphbgynP/IpYtCEZW2LVVlsCyKgV+n+isfkUL9fkpITuCuGg9mCyePNLlxbeOYWDUwLRHJEHvqVLQaneIClP/ET8PoVJKyLDtuMsit2ltWuihd4paxhYXRO0MnKrjTVWGXaq8B34EV2zU4FM7D4H7t7UpJsiOo1Q62tPQ3YyvrUCEzZpowm2fkFKBJ2ABQCpOzyh2eZZQE3qnHCfEf35lI3cKPlCHWICTQqxwvOv73yUHcZUbi8YDsKf8OT6ztQEQPgM6TwywcqbfK3yfcPROtm4L32V4ENMjL3cYibCr9yDp8o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261022113327099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UFqlyruNsT1YR6MQ9CWqWgjF2SRWg0oK5BMlm1viK6Dnekxb3lAP6Jua42bR?=
 =?us-ascii?Q?sk3mo6pGfBBn+3V7vVyDW//xyrGwZuNI9xdOUvQcqmanU8ogfUjdIqYwSB52?=
 =?us-ascii?Q?rZnOOiyMQ+aOcb38+None13zzf0uvAkzC0nsccNuWh/tj6tZT7EYL8Y9R9DQ?=
 =?us-ascii?Q?EuZqUgTW7EczDkqlRNYDF6xMfIGhmwRatPkWbRHjuTfyAWGao+QL7lVX3dtM?=
 =?us-ascii?Q?jsXnsuWSS4Y8mgFd8NBManZHMSvAnXdpQquK2vN09MunbkTXSeIegHwg4kS+?=
 =?us-ascii?Q?dmyWZHfygCMMQsaLIuWE1RTYOuN8t3w7l4sjL5y7+9i0kI7N460yNf0dCqLb?=
 =?us-ascii?Q?FIDRwXjRsogEVmIZ5V4tOqCPNeWmPYmOa2VGIPLg+y4mwY0NXe53gG+1r17h?=
 =?us-ascii?Q?apy4xCP5RDzRHIWOVBPVfMU0uEL5Fuad091DEMiTQVVkcoGC8YLjvg0Pfife?=
 =?us-ascii?Q?Q2Lv+sNSpQEFSr47qM/pLu2IAzhtQ5xYStEtO3e5CbiS0F7D0ZehFEuzMcPu?=
 =?us-ascii?Q?50sfKgMQghNTpuBqoc6sA/UPeY+tvlGPYkP7+83QqpsurC+YUtdiDeuVbEdv?=
 =?us-ascii?Q?0NxYZpvDAgqu1vVliy3dj1RwswHfgDMZ0+NbOxGuHGBhIJICPlkIoSEVEIO6?=
 =?us-ascii?Q?iFbIYo3e7jbIoKHsC0l0CGOcDyd18KJcdhILGDYZcyArESnVHLCJ2F4m+a1c?=
 =?us-ascii?Q?/1hqeqMMXtfllp55DGC35nsgYQInnNKhGBw9IJJ4kaLYNJEK2kZFUrRt7RuY?=
 =?us-ascii?Q?061T9zBTRtP432lVs5dAekVfzhmABS1G998S0wksMf+Dp+LThJxtD8/T6jh9?=
 =?us-ascii?Q?VSVmenQmWbBbQ0xvVqeX2SfeAh9D9Q/Kd2T0vOKlg8o/v2cqsnuXG00Zp67g?=
 =?us-ascii?Q?DMvVn5/8Udw4crjiKDDkcsT4rSg3vBNxSZOJFIypw+0P18qyyEvjCx4X06aW?=
 =?us-ascii?Q?D7VfoLzrbjSvICAn3jApfq13+4/rkNnisTGeX2fV/9u/4SHgGHoYUyeIlAMg?=
 =?us-ascii?Q?dOcHibrmiehjfDA9Pn1m1OrNiiDEkno157RVkxrvr4AX/EelNaiqhv8gtdmT?=
 =?us-ascii?Q?/VFn87OxDlDalz5cRdnM2Dfw3NAvev/J/Pzrr5isbcIuO/Pi0/ow4sqdZs2P?=
 =?us-ascii?Q?7y2ls1wGYLLI6l8D4bevRG/BKpVeceKGqDWow9tfiLuAiZ5syTnJYp69MJYI?=
 =?us-ascii?Q?s6pwuWZfiUhniTDCSTcTAcbzcReYN/2NWqBDQq0gYYX284hy4xphPRoePds4?=
 =?us-ascii?Q?+zqGUwrcAgBjOuLH6VdlJQ5Bf0rkngHkIiJxJpG1shLBDxuwutl9LfGvNVGh?=
 =?us-ascii?Q?eUc2SOZo8guQOvE+tFnRoa/D1V5wSGEIABerADwjPRf/VEMI8YlukIVOKQzA?=
 =?us-ascii?Q?H6f0rjLxuapOUvk+XldrIqLiK1TJ80EVd7hfobOj4+safX8evs8s9KVh0ezq?=
 =?us-ascii?Q?gml0InwhCo2RxU9FgMZfcPMqDgExwXCq72sr5O/iEXT4sU7aW0EpSGHGlCjB?=
 =?us-ascii?Q?RyzPCsRT1l+wdjIbkbQl0elEH4h0F1JmXhyYD13kFMgyU9bal+36+tT33CAK?=
 =?us-ascii?Q?ofYDweDcDU2eK/KnW3j6T6gS6JTdUeqbEH3cV0czBryXj0eN3XxwahV2gy6L?=
 =?us-ascii?Q?pzuyMgfV2T9muJrD7vJvaqIrjSfElpkYO7GHe1S3MfdyFo7hl1GidfR+bfLe?=
 =?us-ascii?Q?cblbqdfsFmUqg7ZyJP9dNG+pd2m/pJUN/U1kjzemFtjRVThxAdpO0DET0XVf?=
 =?us-ascii?Q?4r2axcLiAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f70d4fa-1077-4603-7611-08df364ec99b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:26:53.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TG3LV3qpcJNWqHkP/BgaWVBcX+paIDqdWY7BRuqkk8a4IqLC33EuPBl4pQvBklehZD0uA0zBQN0YSmtFMufNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999226

On Thu, Oct 29, 2026 at 02:56:53PM +0800, Srirangan Madhavan wrote:
> Keep the region and DPA locks available to built-in CXL state management
> when cxl_core is modular.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

> ---
>  drivers/cxl/core/Makefile    |  2 +-
>  drivers/cxl/core/hdm.c       |  5 -----
>  drivers/cxl/core/hdm_state.c | 15 +++++++++++++++
>  3 files changed, 16 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/cxl/core/hdm_state.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 6703c1729396..9971efb237fb 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o
> +obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 5b5f5f22ea32..85f9abf58a42 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -17,11 +17,6 @@
>   * for enumerating these registers and capabilities.
>   */
>  
> -struct cxl_rwsem cxl_rwsem = {
> -	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
> -	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> -};
> -
>  static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
>  {
>  	int rc;
> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> new file mode 100644
> index 000000000000..c9cc019902ef
> --- /dev/null
> +++ b/drivers/cxl/core/hdm_state.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +#include <linux/export.h>
> +#include <linux/rwsem.h>
> +
> +#include <cxl/hdm.h>
> +
> +#include "cxl.h"
> +#include "core.h"
> +
> +struct cxl_rwsem cxl_rwsem = {
> +	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
> +	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> +};
> +EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
> -- 
> 2.43.0
> 
