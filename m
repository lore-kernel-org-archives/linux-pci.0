Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021140.outbound.protection.outlook.com [40.107.74.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908127442;
	Tue, 17 Feb 2026 04:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771300855; cv=fail; b=o3PCTwnM4ts6svdywCNWhdJ0Wy3hhEbSNTXA6Yj6vsfsz0NvvkQkQw3XoRuAcNhv70QrZKe/fihSJm72AC8hQk6AsI/bsH4CJ5YfiEnOgbUOAyYpIW4qpI3Pbg1TltUOdA+AxyBr+XcqR0zVwpMotdzSZ3gZ+a/CMcvGKUmYYDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771300855; c=relaxed/simple;
	bh=DpoWE2uMRQZ5ldpLj4nrjmrPMhglfwadLKMIgWDU3w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hVi8yGEIXSgTH0z/84NV0LKlJL0ezqWJkZqeTdPxvjx5rnF0HXsmJAigp8aS+NTaREEttDNdjmcpru5Fe49BAzcnrlLCwU2hIfKSfOP1CGWVFpPrrHuil2R82sJGEaUJYTkK59bz7PBqcKwe5OxR62kGDqjo/R0gKYqZQhOk8u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WjMS/Syn; arc=fail smtp.client-ip=40.107.74.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WjMS/Syn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGenFSVb5YiYLnJHOuK2n7tJpu27//T92clOCepJ7qkc6IOFBEetz9eUS1rxaOZFV9MYtzw+hpkQg+Iyly39/+34RTG/J/B+hy0ObPb72+L2a5NzB0zcuGe7KcuLumydC3xUP+glut+oiobMIWozuSpFWX6iZhujrsBWeF/ywo6snrcKXnwhjyahHOpzb1NtXUAgd1/cC09CI72VeHHkk3Qk5uESQRouv6aJVxpmFfXSTUn807Zwak3sxjD6jaj4Qk2g7+djCQYKLc6BaNm9q0bofaB7xPuAUav7S+rEcQCVTn9mMFyp3ApIyuHdJKhGwf/pKfaAGGievRGmU+hjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHYfEiQ9a1SAD8Zi6oY61GJ0yfV4c3+wZRvSoC4gjpg=;
 b=ZTBjbSNIOPuwxVX4pUSCenxhlbh7wZAh7y/jyuXkfnmgVF+hohJ9qpGxu2SvyRI/NLnhJjnZeM97pWzU+2q/BS8u4X4pGsAUasHXj3ispt+Dxgn6bY9WDjhcnRiesqt/Ns15V9EMo1YWsM9X0/ojtlcQi+l1HcF+vNSV2pOfdgRsh7d9c7AF7YWMYZUZ/tEhgFHnik5LKQedoJxofVUZOk0NxO4dedlV8IlQSUSeG2JT1vldqCSxw0/0dy3+trjl8XhTuxN+e9nNpz0Z1QEZPiexqlpIRyF9DFNiH2NS0VobVgbXtKnM6pxDRyvm+4n2cmEGkVSyw6w6OCY01IlZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHYfEiQ9a1SAD8Zi6oY61GJ0yfV4c3+wZRvSoC4gjpg=;
 b=WjMS/SynY0cL1d6CiAs/i62buRxBtKdoq6LcWnx6shl02olgKSNgGq9UWh0MA/rkM4b/VY1neZLdcypl9pjaWC2SZm0MulTAs5CSes2o7sv0uYJi6dJkSLEjLvpOnuKWltXzpOhBhgWAyvymHZyXgRXpy8UNAp4itb+KrDiYKLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB3333.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 04:00:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 04:00:48 +0000
Date: Tue, 17 Feb 2026 13:00:47 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, heiko@sntech.de, 
	kishon@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	cassel@kernel.org, shawn.lin@rock-chips.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 9/9] PCI: endpoint: pci-ep-msi: Add embedded eDMA
 doorbell fallback
Message-ID: <tiop7ujeu3igrr7trw3mtsecz3qu7n2zqnylzdy3fqbrhwoein@srvfygwi6g5v>
References: <20260215163847.3522572-1-den@valinux.co.jp>
 <20260215163847.3522572-10-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215163847.3522572-10-den@valinux.co.jp>
X-ClientProxiedBy: TYCP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB3333:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbc91ca-75d3-46e4-a7d1-08de6dd92269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XAl1lYbXjzhUBiCXMuU6P01cExyeePrZ2eyK2cjNjB39zZ48D+4J2kLpm9fD?=
 =?us-ascii?Q?Lu00mXdnaHzY8yyUg+l7CihgEwt63Lw0SLXSJfTGr4JdhjM2b6SWaPSMPX0T?=
 =?us-ascii?Q?XWjjohjFg0fZJJeEA/Zvyepu2ZPqNNm4QC+sGIaaX8b/Y1jtGOrcwm0HwOp0?=
 =?us-ascii?Q?dn9/55dLK7EA/vk0Y31RbyTXTRIVa1bWC9UX2bSGXtX0tQSj1FrBSDQ54C6c?=
 =?us-ascii?Q?cijTHnbNUQp0KoPFduSJyM1ZV6Rc1aGxIVzWPg/RKi1t1pgALRN59Mr/NSLe?=
 =?us-ascii?Q?ghc+qGWCfS9ew5i+w3YIE+TXyi5zdCl2VCr94/deL2LR6ZU5m6uTLJd7jZT0?=
 =?us-ascii?Q?GbzhSTXjMnubyrz3UuGL7+/ZowC/2SPLfSWDjBBD5DUhnsXbOrAUuh30wHdV?=
 =?us-ascii?Q?eEuYNE3qUvtZOIVLLifVibryiEuSq75c4VPP/xnLM7Vgby2sSxdK5P8E6TPD?=
 =?us-ascii?Q?o0tYi7AkL48WCfSJkp3N7OQoCmfbiIrGwQfqcDK9+S2AuP/d1lQMK5waw8hH?=
 =?us-ascii?Q?DETs8NepqscHKX8r67chdEJPC16uxMxT1jxokZa8PRrqeWSrcwqExKvyqPlL?=
 =?us-ascii?Q?mW7z4k4vpB55Q4+gLGopQRHUFEL4VNZ+7qylpVshzdlggDPg4twM/byAFP/A?=
 =?us-ascii?Q?TmxYws92GIxRvGXMhp/I4CAudGi3LBQWf3b2wnDClsUKGgeMMr2+2bfYZE0b?=
 =?us-ascii?Q?2+rD1ZhP1RCkfUsjs5VcBC4HyqS7Jow/zFE1PgMoIhoIQ+czYLXr4hhyzyLj?=
 =?us-ascii?Q?hP/2xYWGQXlF36dziJvKgw3otHF4KAgAUfoyH4GoqzKpfHlH4ollunUcJrr9?=
 =?us-ascii?Q?7yukz8nhI1GuMHCYkf12eiDz2c2qgLTMumVT7tAyiXREl0mNFgke3Y/HJuB2?=
 =?us-ascii?Q?Vyv2Qaq90c+Rd+WxLVDZ/oETA/CXD3MvjeiOs8wfvxF7iTqZBiVcWFj5tMNl?=
 =?us-ascii?Q?ekWzQoIhvigzDkaII7hZDO9L9sW97JfXiC+fcmpdjODAkdV5emHaquXsevVI?=
 =?us-ascii?Q?3B2WT0ZGeRAYE4UhUUEroll61Pklkr9hETQXpYJwejdzfeaMNymHAE7wN+A8?=
 =?us-ascii?Q?dEW45MH14LCqLWf+vsOUiJqSqjoVh0uIC8v+NuH5SzaMWZH7x2NY6GB02Mwz?=
 =?us-ascii?Q?WccXMS3H7vRITSXrqBNupTWMf41p/u/aHcsqtIVXoEqOAn9wi9T5fAQu4M8+?=
 =?us-ascii?Q?S44/veHLToAU5aiaZxxSluUQvc+hheiT2U4JzTq+NDgFhxvVoCbg5ZgqclK5?=
 =?us-ascii?Q?irKojlHzOtRXTg2yMA2sefm7PZX1fG3T1RETv7uLs8WLGN5xvBQcNEQXU0RG?=
 =?us-ascii?Q?giy37Oy9n+JGrgTv6JHCdVoQWox7ncMm91jugUsA+WED26lRtrYrsbALmzVN?=
 =?us-ascii?Q?Vzd3/KvG0vjT63JnVHK9wEY5bIkSaCHKds/i1KrkAyN6R9QSfyjO8Naa+64S?=
 =?us-ascii?Q?cQc1sWazI0C3Yro41fZ+MeQVZ1Kezfw5zE9i5qVvEqnzHPT0NITo6c8hvr/s?=
 =?us-ascii?Q?WUBO17OQfdhthQCs0IRXA56+shxv9dTkecO3jhx1Iw4npT3lHfYuGSjOKCG9?=
 =?us-ascii?Q?W+5DgCZ4KA5mI0hgJSc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XZNEW3pQXCIVkN6wPxf9sDZxsfeQpZiiaskpuoQ7gXzxUB9uCNIYDYbsy81E?=
 =?us-ascii?Q?mdbdrktFB3ndbzaW4iBIHx1f6ToMRaTnhyOOLMNPO8kNJXnUHDB9O3N78x04?=
 =?us-ascii?Q?Yf0e/JNsJlqF2IHLJtecR7HG9VyHvakeJJtrcwBsCNuBgraUxLrO/REieCfF?=
 =?us-ascii?Q?IAudTD0bhETZk/pr6ac+oH+BLKi6LzVjs9dH+MJ9cuONHU1osDXZKo7un7EG?=
 =?us-ascii?Q?x1n3Rdon7cZglH0nTGHXKlNmEiAx99LagzvmWZTVnFvMVWjURLr9RA5ZmVr+?=
 =?us-ascii?Q?PKamTUHZHlf+sEguqu38X0FPFccSN2Seq6yml+sdOtkVYRgc4DJgpdiSBaF1?=
 =?us-ascii?Q?aC8O2fJhMtYo45ATZvCizXmMcqSUkwGe72ircvQW2bRt/8vbU8bhUzJ31BtF?=
 =?us-ascii?Q?3OpLh/+A2BUC0Li3cNLcgwoCa3Tdtpj3tJd4MLaSAGehZblW4o4KC12a/2TY?=
 =?us-ascii?Q?PbZrB/E/neVxMkhyv3Zwk4ahKcKOScR2Z2jVB7VrA1/fjQRG2TVPsO+G7CTt?=
 =?us-ascii?Q?ZTG0EG6VGtXLRXfZuD7WySNk6Z1M8cVf6GVHRK5d6YkYUSE0nhPH//JaWH8O?=
 =?us-ascii?Q?mA4mVBjFDUAuxmHiceIewWMOGz+xnYIzkmh6sxoANlKwmg4LPHE+1d+pMHHE?=
 =?us-ascii?Q?3FYE06HkGw6r0ZyNvlUlILlqcxpWVmC+LdEyY/wWybibdbK9vp3qSCd95PnF?=
 =?us-ascii?Q?xcfWynwXBsGdjq9JuZeWArHOr3K/zT5BbNHlMQTQN2uHYIUnCIllcmxmirXX?=
 =?us-ascii?Q?cwdgg4fq228x+lM//x5wqgGX8LYvD/PAD/0iL4xNpA4NZ4+bNw1MLzmDfScn?=
 =?us-ascii?Q?fg/iKGNs/+O5tdUPZj/4+VdL2TGzICV1cCNABn/4tYiytnai7EAMnlzfl2o+?=
 =?us-ascii?Q?/J5wAqm5cwrytfAbRTiH1pj7mR901E4lTD1RukponZImKmuqI8v3d5uJVCKq?=
 =?us-ascii?Q?QxOJKspuYFOl7OqWOSwH5rGOTQi3/qFoiszkRM715cG9dxmsmPe4nCePTK5f?=
 =?us-ascii?Q?2n9Sr7BIMxjxIJSXP29rJIgzJWKyDP8dy/zPhnotgQetSZJavmudAPkdRq3/?=
 =?us-ascii?Q?VfDYtNC2dudXOg8VtRA5Ui0ycSSnsYptI3kxjULkwrA03F+w0wT1csgcHsF7?=
 =?us-ascii?Q?sGjv0PagXzhfJXHo7u12pxfHgaQ1D5jM8IrC0zIC0/4DcrGv5CiUrKGCW6hC?=
 =?us-ascii?Q?lJcsGsbuiVFwmk3TUIKBkoHvY9haNPF+/E6pbZGGrJUEO3YukUhF8YVmNrgA?=
 =?us-ascii?Q?krzLwngF52AV2xNgeFddaowduB2WJjlpl2falWPUZ2hGvvMgIYM0gSXglJ6V?=
 =?us-ascii?Q?LWjFCj09gr3Jr9MHCL7m9Y7bDQUz/QDIb6tufIgzEqJhZTry/LyVfYWnJBOi?=
 =?us-ascii?Q?oicXsFJFNfJWKg+eE+oyuB3mEF6pPsx7SnO6fr9AtzkYV2X5OZU0ydFmVjak?=
 =?us-ascii?Q?x6YeWuIKC30LtWEhXDQ/f+6WzO31vIl/hGF4/hspZUvfeecaq0JJZKfOkyhh?=
 =?us-ascii?Q?XsFS6kpUdP8wqLRBDjxJyT0nnEbmuNodUNgK6c9rB4dD2l+FbxHmpLf7qZxa?=
 =?us-ascii?Q?+orm8Kcf1/9Nmh7BXo79NckOdk/Q4ffCoG27IF46kp1vKCiNknW/b41zNN8H?=
 =?us-ascii?Q?hPy1lPdmNf7zMFDXpQm4KftQA2IbTvk7tyr41+s3kB1ltpPv/inKsbrzEOpz?=
 =?us-ascii?Q?PSrv3Zcs/4OPWVbLFBvyQofOQiiUanxsCgXgngKIdVtFA9+0xJgD89QO4oXa?=
 =?us-ascii?Q?lYUBr3E9oDMHatpxiS8wJYe7hXNsGP6o3qizhWeLW5kR47z0n4B2?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbc91ca-75d3-46e4-a7d1-08de6dd92269
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 04:00:48.8031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgYhQX9AJ8LG93MtO7L28X3+oepZVsF1deFi1YXc9fgoAOlnr4zeT5a1HJcO/0V5Ik8WIOBGwK/r8mAlqaOc5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3333

On Mon, Feb 16, 2026 at 01:38:47AM +0900, Koichiro Den wrote:
> Some endpoint platforms cannot use platform MSI / GIC ITS to implement
> EP-side doorbells. In those cases, EPF drivers cannot provide an
> interrupt-driven doorbell and often fall back to polling.
> 
> Add an "embedded" doorbell backend that uses a controller-integrated
> doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
> doorbell).
> 
> The backend locates the doorbell register and a corresponding Linux IRQ
> via the EPC aux-resource API. If the doorbell register is already
> exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
> the physical address so EPF drivers can map it into BAR space.
> 
> When MSI doorbell allocation fails with -ENODEV,
> pci_epf_alloc_doorbell() falls back to this embedded backend.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/pci-ep-msi.c | 90 +++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> index a42f69ad24ad..6e1524c2d891 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -6,6 +6,7 @@
>   * Author: Frank Li <Frank.Li@nxp.com>
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
> @@ -36,6 +37,82 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	pci_epc_put(epc);
>  }
>  
> +static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
> +{
> +	const struct pci_epc_aux_resource *doorbell = NULL;
> +	struct pci_epf_doorbell_msg *msg;
> +	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
> +	int count, ret, i;
> +	u64 addr;
> +
> +	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> +					  NULL, 0);
> +	if (count == -EOPNOTSUPP || count == 0)
> +		return -ENODEV;
> +	if (count < 0)
> +		return count;
> +
> +	struct pci_epc_aux_resource *res __free(kfree) =
> +				kcalloc(count, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> +					res, count);
> +	if (ret == -EOPNOTSUPP || ret == 0)
> +		return -ENODEV;
> +	if (ret < 0)
> +		return ret;
> +
> +	count = ret;
> +
> +	for (i = 0; i < count; i++) {
> +		if (res[i].type == PCI_EPC_AUX_DOORBELL_MMIO) {
> +			if (doorbell) {
> +				dev_warn(dev,
> +					 "Duplicate DOORBELL_MMIO resource found\n");
> +				continue;
> +			}
> +			doorbell = &res[i];
> +		}
> +	}
> +	if (!doorbell)
> +		return -ENODEV;
> +
> +	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	addr = doorbell->phys_addr;
> +
> +	/*
> +	 * Embedded doorbell backends (e.g. DesignWare eDMA interrupt emulation)
> +	 * typically provide a single IRQ and do not offer per-doorbell
> +	 * distinguishable address/data pairs. The EPC aux resource therefore
> +	 * exposes one DOORBELL_MMIO entry (u.db_mmio.irq).
> +	 *
> +	 * Still, pci_epf_alloc_doorbell() allows requesting multiple doorbells.
> +	 * For such backends we replicate the same address/data for each entry
> +	 * and mark the IRQ as shared (IRQF_SHARED). Consumers must treat them
> +	 * as equivalent "kick" doorbells.
> +	 */
> +	for (i = 0; i < num_db; i++) {
> +		msg[i].msg.address_lo = (u32)addr;
> +		msg[i].msg.address_hi = (u32)(addr >> 32);
> +		msg[i].msg.data = 0;

Hi Frank,

Thanks for your feedback on [PATCH v7 6/9]:
https://lore.kernel.org/linux-pci/aZNA3lQCne2laAW6@lizhi-Precision-Tower-5810/
I realized that pci_epf_alloc_doorbell_embedded() assumes a "write-0-to-assert"
semantics, which appears to be specific to DesignWare eDMA interrupt emulation.

I'm wondering whether it would be better to extend pci_epc_aux_resource
(introduced in [PATCH v7 3/9]) from the beginning, instead of deferring the
change until another vendor wants to support a PCI_EPC_AUX_DOORBELL_MMIO
resource description with different semantics (i.e. not "write-0-to-assert"):

Personally, I'm inclined to extend it at this point, like this:

     struct pci_epc_aux_resource {
             enum pci_epc_aux_resource_type type;
             phys_addr_t phys_addr;
             resource_size_t size;
             enum pci_barno bar;
             resource_size_t bar_offset;
     
             union {
                     /* PCI_EPC_AUX_DOORBELL_MMIO */
                     struct {
                             int irq;
    +                        u32 data; /* write data to kick */
                     } db_mmio;
             } u;
     };

In that case, I suppose I would need to drop your Reviewed-by tag for that commit.

Best regards,
Koichiro

> +		msg[i].virq = doorbell->u.db_mmio.irq;
> +		msg[i].irq_flags = IRQF_SHARED;
> +		msg[i].type = PCI_EPF_DOORBELL_EMBEDDED;
> +		msg[i].bar = doorbell->bar;
> +		msg[i].offset = (doorbell->bar == NO_BAR) ? 0 : doorbell->bar_offset;
> +	}
> +
> +	epf->num_db = num_db;
> +	epf->db_msg = msg;
> +	return 0;
> +}
> +
>  static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
>  {
>  	struct pci_epf_doorbell_msg *msg;
> @@ -110,6 +187,19 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  	if (!ret)
>  		return 0;
>  
> +	/*
> +	 * Fall back to embedded doorbell only when platform MSI is unavailable
> +	 * for this EPC.
> +	 */
> +	if (ret != -ENODEV)
> +		return ret;
> +
> +	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
> +	if (!ret) {
> +		dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
> +		return 0;
> +	}
> +
>  	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
>  	return ret;
>  }
> -- 
> 2.51.0
> 
> 
