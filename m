Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021078.outbound.protection.outlook.com [40.107.74.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5028B3358D2;
	Fri, 20 Feb 2026 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609362; cv=fail; b=tCMH/6LxdHgMMNCv7TcwpAJ2qhJkIqPF/oVsvrNuJ6TPHQ6KjhyOSk9cgF3vb12VYp8ek3o4v32x5/N5DS+X/lDoPo2oCTE8hEPeqaIeh2u0r0FloRZhH0bY0H2BP0MPnFhAwIykeVXVM0xNCePk555oAJwvQW55Ev7IRQS8Krg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609362; c=relaxed/simple;
	bh=ue6yfg9NQMVV1YTCqW9qly6Rlxuw3/KB9NEWObGHxOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p1JjzxObTak3wrQ7HuYpyE/y+SX4kM1Fgstl9a0NovA1h6dxnBH2uimk4pxy9d0sPqglWKmVV7xLQOK4edRZsZcVOrb93iyfq7J7KWvX1nfJ7EAKMcsQQExO9sMTQ2EOBsf77ReiTdRTuMgrvYlWQOso0nM3E8Ry3bALLWmqg7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mfqE+74b; arc=fail smtp.client-ip=40.107.74.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mfqE+74b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpOC73Z00J0rSyGlGdb2NQMNXXBHAqAyQf7eJQTmx3yd3xvK+S0zLqjK5IrMzfWFkO7AkIoW5OG52bgLkYiSsXzeB5TMBLykoulaymYvGPbOE/pX0GQksOD1/J3+1o+2/0XhNJx6Rcf0AP81nv2XpGDkNTthZioR2ILLt1J4A5CQDdPy8Y+n5JcTFvQzCxsVTMNoCJnPOa3c1kXkbXXUX0mok1P1R/ya/sOT+iYfcrMcBIYeRrU+zYhDObtKJnhhTXLP8L3rSrdXlmvHtpMMThUcO6YD1EBYs6yJrTiWSl5oq2wsLd+Wuq4QfTuFgXnMJXIqeaJkMJiqsnFxXpJsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E7StEjx1R+cH1+CTjhmqwUT5e/8uDWQn+kinKdDXf4=;
 b=rwpbZAEifbIn4sX7Ee5tibVf0cGoitC2gWUUVoBEOy+/fFC3pQFDtm7dByiXibyJPU77hj609tXgGhFQgjNX19U4tICbsKltpaqs7Z4qRngABT5GxJsupvKRfnvBP2OPo9dqr2Uf2GujfPdN5Q8Fz3Fky1ADILedRxMebgViF3KI4NptJzSzELYRSxtCe7biX7SU3S6QLvhBXaZvRICcHyF/pT3BOwQ8PGqvZ9uSkk0tYksZBWjKcgEeAOhHMjstRdm+ITpuygJ6EZkeVPTUqf29LzIOgMXCGACtvrUkproqDKkWkkerIw++O2OrM2ZgVCp/nE03cFW6GjNOFcajqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E7StEjx1R+cH1+CTjhmqwUT5e/8uDWQn+kinKdDXf4=;
 b=mfqE+74bj6PoW2GCvni5768Ok+p1WKqKAi52cBI7kB8W+shGb4YJAACqv+S/njIcI81N2S9fXXkBGA1tbLc5FWWXG94teihEoHL34M6JyZHLnRiIIFWWgBuvyvQduuMctw2ZjuWyaQXZgTGHtFNUyCoz7EIz5bjKbc66pNGEzvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7485.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Fri, 20 Feb
 2026 17:42:37 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 17:42:37 +0000
Date: Sat, 21 Feb 2026 02:42:35 +0900
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, kishon@kernel.org, 
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, cassel@kernel.org, 
	Frank.Li@nxp.com, shinichiro.kawasaki@wdc.com, christian.bruel@foss.st.com
Cc: mmaddireddy@nvidia.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v9 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <u5q2ntwbjlqweodsipkkxcdtyt4zikfbyvriygsi3a3asbujc5@rgpblec4nwa2>
References: <20260219081318.4156901-1-den@valinux.co.jp>
 <20260219081318.4156901-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219081318.4156901-8-den@valinux.co.jp>
X-ClientProxiedBy: TYCPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:405:1::35) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: be51e8ee-cd57-4d03-a70f-08de70a77006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iub6OQf2u2tjuBSSNcmxDKrY4v3cHwXzCZygcNPtmmgd7mIjooZjJkUGXdIu?=
 =?us-ascii?Q?OeW8NgzSnpxB1FM1WUqbVKjvdorNOg7m0HkpRx6tWJX1caYjzEoKpH65Fbr5?=
 =?us-ascii?Q?/C7bj114CxLPrMGJ7kOkS2dKG6lCSWNsnxucjHbuFq0znJZQsEon7NuGsWxo?=
 =?us-ascii?Q?Gi83muEt4jV6YsLBUfwJVaU4EF29Zl2w+hB0lR0wigy1kF4cBYU8DTIXDB9J?=
 =?us-ascii?Q?fG+LE12HwCcbwk83h5xSstsYxqJ+8WNhNZMR9+1URhuk7AamAUF35mwaqG8o?=
 =?us-ascii?Q?hzG0X3ugS9TKwQT7PqUzWhPJ7iNjVDwWfwAM6OgPaHpoYADmD/NujkCDSCcD?=
 =?us-ascii?Q?0wk7mfErxRZUwGalEnyKX7RBAjMVxvxgmBfY5M/uHGQwrzw5BjJ3YdJxjJDW?=
 =?us-ascii?Q?PxXryw2XgVAoA/8bjgetM1Q8mVAfMIK7VsRp7Ob3QvOoGV1rsr2KZIVnPIEs?=
 =?us-ascii?Q?02fK77dDDtxW3VcnMMSEBNZ5thxXF14UpXTcwzOcQ5Hm1yOQFBq5WDx5TTLp?=
 =?us-ascii?Q?Ic+et5oiaGjLDjLwEsU63njUWltd2LGRV0ObgO/mcfmMQRloEo1mOInl3Mqo?=
 =?us-ascii?Q?1uMiS78lKk4yj1EEyrX6b3Oypc6DYPwQfYSPx+YDiCrvNQjVBCp/eEgVCiC9?=
 =?us-ascii?Q?cC/89lNtuCwP4Qi+P1v5DaQGxdLlVA5yBeWpf3RwKVHwdDUO8SuQXN1P+ajz?=
 =?us-ascii?Q?/GnulI6JEsa6/YV6A2j+fJWNCp5SFBXdTsoM24DuI+shmNn2GfsPpTfsxzr7?=
 =?us-ascii?Q?rlry/awCNfKliuCOY6jwXFwvy82yrXaGp8kel9nroRBYkSqys9qflD/PJntz?=
 =?us-ascii?Q?T948XYKqAR9SUl+ix9275mPMrRl0MaIPr8TdKOJfXV/MTqI7Xsz8UT4HGOvJ?=
 =?us-ascii?Q?IWQCMSxz7xOS3PVriE3PAMj7iC/pjCAwQHuQE+pBu7n0xi2mjru10YNJ0MH8?=
 =?us-ascii?Q?26mrpkjayStYgtSW3vkoF5LQa9qBSqwW8jYUaLzuLGg2Re5pKZYSkyL650NI?=
 =?us-ascii?Q?C0408JAktmDMyhN/ls3aaAHZlY0pbYdj0sizAFVPzNx7SFphd2Igb2A+TSfU?=
 =?us-ascii?Q?Bdb4E17iqAIbX/AAzqhcGQt0lOzBfXQXul6d5Z0LwT3a9gxmi93I75E4z6H2?=
 =?us-ascii?Q?Rt1gb69YzcnWLhhumrYuv1LaxB581cXZMF215kEw6pSdc2fWzAlsgMNlwFTb?=
 =?us-ascii?Q?QIpuDmFRwS6PBTZ/p7AiL69MTwp14O/ynbgDGftLtvWcwXvRt/hsGNFaA3Df?=
 =?us-ascii?Q?azu/qQze/3t24VbD0d53ydALF6gkMqu70rShv/0j+eXxx1q7Y6LRS4I/BfjZ?=
 =?us-ascii?Q?oRs9GZm4Ysj4wbcZUgJwHBz+TPkIyIiMxlCidmcfWJJMfL/iJt5/SBsnOgCD?=
 =?us-ascii?Q?ixg56AketCRS1odO62y3QK18OcPflzCY+bDO7u2iqZkQHEOy7+Z8XjDUho0c?=
 =?us-ascii?Q?eHv60j12cR6NOLViZYvmY+U/FqMI51Unya2l9b6xvid/S9DGPiPPcdIO/7UP?=
 =?us-ascii?Q?+Dgiatdws0nn5cEQ1sWva4heU7867AfWjYGbg2M3wwn5W69SEkNH4yXNfdvo?=
 =?us-ascii?Q?GZ/Dzrtnj7fYCpplcVhbMm4T+54IOQEAQP57jQqKPSs/VcnXfzaEisEa7eLo?=
 =?us-ascii?Q?oADczSgZeS8cFlBIs96dIC4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ftybFqyRDIHv2OXRPF8ssHNtHXgh+Afdargc8OFPYKosQB51+Bc5NHhQh7q5?=
 =?us-ascii?Q?YafqwgeFiWfpWlVbw2P2rbHaBAaY8ErRtdLGmiCAFoRxdPOW3DMndHIqFf1V?=
 =?us-ascii?Q?f6ZCDLkodvmK0jZyj5/vV+bYm1CaxjnJ0joNjVxlhjTFEFY/ChPOH5xElsji?=
 =?us-ascii?Q?hDstoPliyA3E9EKplpTXESzbN12R4fwHFxmgQd9FyA+nOnQFJ/fDTuNRigEe?=
 =?us-ascii?Q?Bdo/edkSOym/HLazUAohAYg2dm79+4LndDnSgYSZFQB9rZ9d/BrRrNBFhbcu?=
 =?us-ascii?Q?49GBfrBRS30/yXM9zEEsJwL4gHUx9wF6pHJqquc8iUzi/0ahPlk5KgsX9E+q?=
 =?us-ascii?Q?8ElfcW+uNGe3cD0FWAuliPlpBZeOyqzbLA+Y73uKrIWXnDcWC3J1z1IjOwQ5?=
 =?us-ascii?Q?pwPtwXTP4L65hMTN5moVsM++KTHOkhX27unaJwqSCfBCVNrfpqsuhrhbP5fM?=
 =?us-ascii?Q?qzzEPsIFbUH+rP9XcpxtuAi6exoZVZ15UWM6tIeF/U86oM0SGhB6K1lL7Zi2?=
 =?us-ascii?Q?zdQowGZAIkzM+a9cS/9bvYA4RUl+GM07bD2G4jFvjSUTeaJhfa07Bzq1AmjO?=
 =?us-ascii?Q?XALN5wqop6cHU9tj93NoKPcHDtyKyLltrIBSg1r/teeh238vTLqrD7p2+07v?=
 =?us-ascii?Q?FZ0tB0hx8ruHn73FZnBaUbEfoa2lgWOzZGLHtEhedu6xH4MwHA3/N/fuhMqf?=
 =?us-ascii?Q?WVe7tpXaZw5Qy3UJKpOOFg6CIoBG0Y7yisdNyNQFUQ79o9GxHqEUnlxndD28?=
 =?us-ascii?Q?uKunx6tK0w9sccuvyDQSmBG1UR8qf5Zqou4cC8GYf6FLadJcY9MEqQGUbuRk?=
 =?us-ascii?Q?156MInhLAe1MJD3Ag3gmfhRQLtdGGj8UtAN63IGM8JESRSiPV3L8amcXEzDN?=
 =?us-ascii?Q?JYouW9VUTzSZs7S0lcAKBxE2nhUh7fitAFIMxwq9c8OTH4hJrcUXRh+f1fee?=
 =?us-ascii?Q?hPSXEIzdiUNlPlWJMwVGg3/jicI8gp7asbA2cbEeDit8Gf5OzV3XdQ0L7boS?=
 =?us-ascii?Q?ABo+ELAIdt1GK5GrBuqv1U0wrnC5xTM14wYrZRKMt3PJrWk6uPG5ZN6RZGsM?=
 =?us-ascii?Q?oFv9YljXfGwXdGQmMZUbKB4TO3I2uPEu/LJDO+SzprezoUEjDemZLKvSVhHu?=
 =?us-ascii?Q?yw+yLNIpbkqz8C/qNLIx5vpVX5I7FGpoKiW2XJGtjQTsXTxp1B+F1pD1eSkL?=
 =?us-ascii?Q?ZXO5Nat07uS1aCbo7RB+ennHq0zHHdUM9wRhruii8+N222X9Qxv4vXOLTe6e?=
 =?us-ascii?Q?SZOAlEP6Ipb3iB+09BRhVjZTv+1EQEOvhK7h2mi/axCcKAFDX9CvrQkcg/ay?=
 =?us-ascii?Q?DZ4W8TVy58Ip7276hPDuw0SXuZdtc+K6BLTrhR8zstNECb5jDfGBbTHPwjTO?=
 =?us-ascii?Q?Jy01g9FsE06yydEJGRHmStfTIg42mIshV60H34oAAGtM4jxujdKXxuclKce5?=
 =?us-ascii?Q?uRBUgGGMymMPQITehh8onu6ozt5MVMiAX9x80K+s2mwUEJaCb43idlPsSVpP?=
 =?us-ascii?Q?Oc2P0/pxfHAbmlkEUytszO/++schdVyHzxS7h5qdUBMKqi5nM3jWnSDsfmMU?=
 =?us-ascii?Q?7OJHYyUbnSjPvUGSDLTTKvpmHzZ0bilbw4RIRShVI7a0MEI68M9kcxUxrd/k?=
 =?us-ascii?Q?Ik9x2kp6eQOlL/4kqtDhBeeL7dk/cVT8xsh5WAJaN2RFkHOx9IG/rknUUGzX?=
 =?us-ascii?Q?VYOJYdLJLAKOUV/UDWdhoHka+V7RseCydIkj0ABfHXWvXTe0yWnkwDUbizsL?=
 =?us-ascii?Q?/hmI/3cENMAxX4xT9P9Qk43Ov1ibI9hyRpCN8MhZ1Uk/QwyfQcw3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: be51e8ee-cd57-4d03-a70f-08de70a77006
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 17:42:37.5142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIvz2oXyUl/7BEVwt7ffD6+CuywtVoSMgaogvv342C/sCGCOav+5xaxaXuGVY4VsIXx29oa6xXiUbYu2HdBB8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7485

On Thu, Feb 19, 2026 at 05:13:18PM +0900, Koichiro Den wrote:
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
> Changes since v8:
>   - Add MMIO address alignment check
>   - Drop 'eDMA' word from the subject
> 
>  drivers/pci/endpoint/pci-ep-msi.c | 99 ++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> index 50badffa9d72..f287fbf684ca 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -6,6 +6,8 @@
>   * Author: Frank Li <Frank.Li@nxp.com>
>   */
>  
> +#include <linux/align.h>
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
> @@ -36,6 +38,86 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
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
> +	addr = doorbell->phys_addr;
> +	if (!IS_ALIGNED(addr, sizeof(u32)))
> +		return -EINVAL;
> +
> +	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
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
> +	for (i = 0; i < num_db; i++)
> +		msg[i] = (struct pci_epf_doorbell_msg) {
> +			.msg.address_lo = (u32)addr,
> +			.msg.address_hi = (u32)(addr >> 32),

On second thought, I'm wondering whether it makes sense to handle the case where
the embedded doorbell target resides behind an IOMMU in this series.

In v9, we simply expose the raw physical address without establishing an IOMMU
mapping. When the EPC parent device is attached to an IOMMU domain, a Host->EP
MMIO write through the BAR window may result in an IOMMU fault.

Initially, I planned to submit IOMMU support separately as a follow-up series
once this series is accepted, to avoid making this series too large [1].

However, for consistency with the MSI doorbell case when CONFIG_IRQ_MSI_IOMMU=y,
it might be cleaner to handle the IOVA mapping as part of this series.

[1] Supporting such an IOMMU-backed case would likely require additional
    patches for vNTB + ntb_transport to demonstrate usability, such as:
    https://lore.kernel.org/all/20260118135440.1958279-12-den@valinux.co.jp/
    https://lore.kernel.org/all/20260118135440.1958279-16-den@valinux.co.jp/
    https://lore.kernel.org/all/20260118135440.1958279-19-den@valinux.co.jp/

Perhaps the cleanest option would be to submit these three as a prerequisite
series.

Conceptually, the change would look like the following (to be applied on top of
this v9 Patch 9/9):


diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index f287fbf684ca..05423c83ae45 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -44,6 +44,9 @@ static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
        struct pci_epf_doorbell_msg *msg;
        struct pci_epc *epc = epf->epc;
        struct device *dev = &epf->dev;
+       phys_addr_t phys_base;
+       size_t map_size, off;
+       dma_addr_t iova_base;
        int count, ret, i;
        u64 addr;

@@ -85,6 +88,17 @@ static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
        if (!IS_ALIGNED(addr, sizeof(u32)))
                return -EINVAL;

+       phys_base = addr & PAGE_MASK;
+       off = addr - phys_base;
+       map_size = PAGE_ALIGN(off + sizeof(u32));
+
+       iova_base = dma_map_resource(epc->dev.parent, phys_base, map_size,
+                                    DMA_FROM_DEVICE, 0);
+       if (dma_mapping_error(epc->dev.parent, iova_base))
+               return -EIO;
+
+       addr = iova_base + off;
+
        msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
        if (!msg)
                return -ENOMEM;
@@ -111,6 +125,8 @@ static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
                        .bar = doorbell->bar,
                        .offset = (doorbell->bar == NO_BAR) ? 0 :
                                  doorbell->bar_offset,
+                       .iova_base = iova_base,
+                       .iova_size = map_size,
                };

        epf->num_db = num_db;
@@ -211,11 +227,18 @@ EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);

 void pci_epf_free_doorbell(struct pci_epf *epf)
 {
+       struct pci_epf_doorbell_msg *msg0;
+       struct pci_epc *epc = epf->epc;
+
        if (!epf->db_msg)
                return;

-       if (epf->db_msg[0].type == PCI_EPF_DOORBELL_MSI)
+       msg0 = &epf->db_msg[0];
+       if (msg0->type == PCI_EPF_DOORBELL_MSI)
                platform_device_msi_free_irqs_all(epf->epc->dev.parent);
+       else if (msg0->type == PCI_EPF_DOORBELL_EMBEDDED)
+               dma_unmap_resource(epc->dev.parent, msg0->iova_base,
+                                  msg0->iova_size, DMA_FROM_DEVICE, 0);

        kfree(epf->db_msg);
        epf->db_msg = NULL;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index cd747447a1ea..e39251a5a6f7 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -176,6 +176,8 @@ struct pci_epf_doorbell_msg {
        struct msi_msg msg;
        int virq;
        unsigned long irq_flags;
+       dma_addr_t iova_base;
+       size_t iova_size;
        enum pci_epf_doorbell_type type;
        enum pci_barno bar;
        resource_size_t offset;

----8<----

Note: pci_epc_aux_resource was intentionally designed to expose a common
'phys_addr' field (rather than a DMA address), because some use cases require a
raw physical address. For example, in the remote dw-edma scenario, the host side
programs the (EP-local) physical address directly into
dw_edma_chip->ll_region_*[i].paddr.

Frank, since this would affect Patch 9/9, I would appreciate it if you could
take another look and share your thoughts. I had to drop your Reviewed-by tag in
v9 due to a small change, so a re-review would be very helpful in any case.

Niklas, any comments would be appreciated.

Best regards,
Koichiro


> +			.msg.data = doorbell->u.db_mmio.data,
> +			.virq = doorbell->u.db_mmio.irq,
> +			.irq_flags = IRQF_SHARED,
> +			.type = PCI_EPF_DOORBELL_EMBEDDED,
> +			.bar = doorbell->bar,
> +			.offset = (doorbell->bar == NO_BAR) ? 0 :
> +				  doorbell->bar_offset,
> +		};
> +
> +	epf->num_db = num_db;
> +	epf->db_msg = msg;
> +	return 0;
> +}
> +
>  static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
>  {
>  	struct pci_epf_doorbell_msg *msg;
> @@ -109,8 +191,21 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  	if (!ret)
>  		return 0;
>  
> -	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
> -	return ret;
> +	/*
> +	 * Fall back to embedded doorbell only when platform MSI is unavailable
> +	 * for this EPC.
> +	 */
> +	if (ret != -ENODEV)
> +		return ret;
> +
> +	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
> +	if (ret) {
> +		dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
>  
> -- 
> 2.51.0
> 
> 
