Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021089.outbound.protection.outlook.com [40.107.74.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30374014B7;
	Thu, 26 Mar 2026 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537914; cv=fail; b=Jp0g5dpGcu88yr1hDgUuH/MxGPFvXJHDOmbazu8+ao8GYbfiR74Gkyk5arYpdq70CEaAGtrMjg7vVdXbda0uoX6dCtrbRBDZhcX2Dqhc12rCS14HlxfmpmsSBVUUJeuAXByzoU4QKiuyTfwgf5TnhTzoIECmf+sVL97HgL+E80U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537914; c=relaxed/simple;
	bh=Xa11Y57vscgQyUN7x4+YC8qrj+xzWRtLEk2IBWXlfN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IAdNB7ydh+Y4wv/Fl5kuQSf6hSFhzcfCjFuElsiDmq/FPrB3/cgG9U4DxBcSbiSnPvSWIMy2sBCtovptmYMvmy2iLdu5Z3NpR8vc38niEay66qVKfdUbHT88uJ9QXcbg/sswgxDkxWlTOmxJjQKHV+xl2C+Ibo5wfEMG5eLwdeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=p2gMHAeH; arc=fail smtp.client-ip=40.107.74.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="p2gMHAeH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJUUCSzOS5rI0DHmucT15Q6m6iaTRruPWK9YKLuOaJvKdE7DVSecamGLNKOsC23spPMzySnBGEJBASbOCK+hGYg5RN9GVu/8nj4vYnSEbBJKorQ04EkgEgjMHaVyQyR4rm379dNaZoQpHF9yxRoPNSiuKNAyi2Ux6YLeWUX8FTWxsO3HK79P6ENGAdBq0Sx8tupks8EtVKMjmomdAs20NQaoy2g6zKYW37lSLXdN+9jjpauSX7WxcM6XGnhgCuTUApU2GKzZs9dEslp/KnR1LPfkrZ/ir1mS/iaXYE1j0Lunx/GF6Ww82/LU4W0smMvEdCATje6mmpq2vwNrI1MlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvZKnE5KH8afRjzR2nbJ3Zq8n2K0mlWfFV3DAL4UDlU=;
 b=FaNUGdWxGrY5DatF/GVdAnAjuCUySRFe/TZr/xSJk6mjNG3Jcq7IIjcUkIwuYCQ8ORBMwAZWjqX3Mq0CAhfaHAe4os9gt9+PV/EN0VQ4h4acUh0Fy1incZ9xPy7n7AbNG8XoivtP7egDZHVe2cj1iNlUytAPhCzmIb2eFN0evjQf8JqRkhiDr5yQHgigp/SqrKBd+TC/rh3gNYdkzbhLf+yjU0rNXR1tCKi7FSACZJDl3SOMZk+N9c+yDhEZKi52oFor/gXEUjVd88n2+E2ok3EH99aPaWjD5k8HejsDoRXaKhdqxX1l1mveAqacisDctlf4wUjZVynYNCKuYSdQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvZKnE5KH8afRjzR2nbJ3Zq8n2K0mlWfFV3DAL4UDlU=;
 b=p2gMHAeH2m+qeW/dZmrCFdXTc6dp2Wujju/ydSy9yX7gAADdLKbH3fFG+4cMP9SJnF5UqGgpXb5f8xQUJymMV1Qoc4WIMIqXzj2mdjMzezS0EJZxyxzqE2d+QnBEVlZHRHXUn11zQvgSv8qo3GKhTWWKhUNf8UgWzlSzG61UBzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5966.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 15:11:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 15:11:50 +0000
Date: Fri, 27 Mar 2026 00:11:48 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v11 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <r3vshsllq35op2dyajq2sr6el7ibxunmlu4r4hsvfs2v2237go@jcwp7xku6not>
References: <20260324083728.3744734-1-den@valinux.co.jp>
 <20260324083728.3744734-8-den@valinux.co.jp>
 <lfbv6sjevz4xtjr6zt2hl3wap3bfwkvigqb6fdztqmutxgcvld@3t4x5gstr4nj>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lfbv6sjevz4xtjr6zt2hl3wap3bfwkvigqb6fdztqmutxgcvld@3t4x5gstr4nj>
X-ClientProxiedBy: TY1PR01CA0203.jpnprd01.prod.outlook.com (2603:1096:403::33)
 To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dcec189-642b-438d-34c9-08de8b4a014c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	gxCiF9WhnFbEeGkXqPCWe5p26NLa1+5KkD92W/vmexdeu6cWDFSZnqcDv6F7YiTbAoEgF7xy5670/xm+Fm4iiJAU6+ctfHZle9Hft9iAjR/mTAkue1LxJ6LgdfPCQn+6RWBuVJ8k90jewou6dhfwbexqLPtHKdyQIPm1P/TWd7VNHD0qsp6uEaGb/Cd2H5lqjWHKDaBx/y8Mb2lAIBXNFLsL7ncUo7CllSf9eeQBsed/ttq4GJvpFkQnPta0iV1OBFKdVeeCuVQjmvD2AmIMyGpidLp3jr+Kozzu7R2ds84t1dBTsfnWzof45N21DmSKKvx7on9yQEMM+gkN06PC2K5qmS0LAZ5AWzOjQ9LiV6kukmjDDpcKTJST/YGY/VHDsMoIzoa6ApR3qK8CVufjnV7KHXpLmCNGjOUzdUO3yA9rXbSUp7u0OyrU1e+mXN8oFONuFwEImcEzvVOUgKKTX1XRXxD+i/IVVMsqGwl3DRAj4XzSUZ/UC5hPNi5M1OhgFdIeuG7lWarYUZBhu0gS5dGQblGThvi+Pb8Adk+ip+sxS50JkQUPvVVDFJy2kjJIGd5VToSM+KS176I9YplbsbKjXugrAbFmwZHfACNckonlsNA4punW9ymEPbcxE0irEmbXQFG+kQPkslsPmbsCiNs5zrm8iaPXodBWjVxpVjRH7ZBTLgboX9YURiO4bAOfTV4tUvtcZai6j+2to3lfh9zdOtjCT1liCJO26LYZejw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emdIQ3NqdFhIcldBV2ozRnc1NlBTNXFDekhtQTZzSmF6Vkd4MWt5N0I0TDk0?=
 =?utf-8?B?SFRHejBCeGF3Y1RRYnJUeHRYbmZ5Z29VTXpjclR5dS9YZEY4V3pJZUZ5bmpi?=
 =?utf-8?B?QU55OWtJQnZJcjhmYmFUdWxZaWNNd3NqMThJb1BQeU56TGQwY3VjVW9IK1Bm?=
 =?utf-8?B?TVlCS0RkUFp5U29FdmVzUTVGU2xQQlJxZjJKZDhDMllqdlNFdzR1cG1UL3h0?=
 =?utf-8?B?UnNmNWlPSFg1N0lBMnAyWDlsN1pYdkNBZC9SYTFDcm1nVDIyd3psUnNERVgy?=
 =?utf-8?B?N29RRWwzMGp1OXVsVHZsVnNEWkxqaDRTUm8zY3J0RzYxeWNkRUUzd2JRbytD?=
 =?utf-8?B?Z2VxSWZscXNpYVQzNVMvTko2WDYxbGdRLzl1NEsyRHZERFMwY1hGTW9ZRFYw?=
 =?utf-8?B?Wk1pT2R1d1Jva3gwRVJ2RHJDbEFCYk9IVjdMMFJta2lKNUM4TnhBYWtwSlpr?=
 =?utf-8?B?U2dSZDBZZmkzN0M5RmhYWWcrZFBLd1JqU2tIbEZTVjd1dGxQeHlqQnVSLzk3?=
 =?utf-8?B?QTNIdVRoenFZT2plQjVWM3h4SUNWN0ZPdzR0bUxxbWV6ZU9WUnFxS3BWUkJJ?=
 =?utf-8?B?ZmpmaUpoenY5VGFIYU1SY0txbG94bzRiSUV1SENZVGhWNUhNTndUSlR2YVU4?=
 =?utf-8?B?STA2WEU2SEpDa2FvREhxaTN0S2V4b1FJbkZ2bWFUV3B1bE5tUjJEYmxNUzJJ?=
 =?utf-8?B?UVhWQVd4RW1hWmRoRldZc3BUU1VyZXJRd0FhNVVGMHlockJhdlRJQnFjTm1O?=
 =?utf-8?B?QUNBSGVxNVRRem81Tml6em53cHJHRzNhaUx5RldyaUVoYjIrV01TMkNNckZE?=
 =?utf-8?B?T3YvZ2FVQVU5YWtaLzZ4akk3dVhQYng5aUt4TFM1dWN6YkJzekJKQXl6bEND?=
 =?utf-8?B?TEVrcUwvL1B0L3JtUnk5L2lBTEpsUXNwMi9GOGtqdy9PYUx5MGtSbDRBanZC?=
 =?utf-8?B?ZTNnejVWd2duZ3NmSUhUenR0dUVGSmljU0NLM2NCck0ydy8vM3N1N0xjSTJq?=
 =?utf-8?B?WTV2UnZHN05KY1VXbGRyZ0hzZlMvcmZXTzlOTUdnUkFyNmFweXh1VGdTR3Rq?=
 =?utf-8?B?cFBSZ2JjV21oUnVoeGZWbHdrOXhzbmtldHRsOXdmamdTVG0xbnBhTFJma3Zp?=
 =?utf-8?B?bUJMcnpsbHh5V1hKdDlYdHVsM214WUJaV0JuVHhuK1F4eGdRYkJkYUgzb01U?=
 =?utf-8?B?cDNaWTZKNWZldENlamZnckM2VE4vNkFRNUxzQ2xSN001dHkzWVdDUEdUU2Qy?=
 =?utf-8?B?ai9qSEE1YjNaNitYYjVZc2kzeHZ3Y1l4bEFTb0JnWUZmRFg2amdrcFg2UXIx?=
 =?utf-8?B?c0ZXRkRNOThObVRuNDN4WWZKM2s0RFlhQWh2bjRuVzFxeHA5M0I1NEJHbStK?=
 =?utf-8?B?cklnWk15b1VKaTVLcTlLVkJrTXRRRnduSGp4V2YyT0VNUFdHTy8wL2J2T1Aw?=
 =?utf-8?B?QTYrZTRLRlFQb010N0RIeG5SdHJYT0lpa1NZNWVmVUJOMFY4Z2JkSU1QRXFK?=
 =?utf-8?B?TU40NHpHZ2NFYXJLVHJScGlnMTlNay9XOEMxL25BVTcrY0p5NnJRUWV6Mm81?=
 =?utf-8?B?d3djYXJpblhuNFRjMnBhdmJHSmNVaS94WGJpbittZkthZ0NKZTY1Nnhuc1Fa?=
 =?utf-8?B?TEFuait3ZEY4SkZGdTNnbTZ3Z2Fmb1VjNjRIMzU2ZEtYOVl6RXgzV1JwNlBM?=
 =?utf-8?B?cTIwY2dudlJoMDVJQTZwTmYrL2tucGVFV2VuRndENTMwcDNpZDJyWEZoaFlZ?=
 =?utf-8?B?MGZ1Ymp0bTFJRG9NeDZ6cDk5MnZyMEt0eUs5aVZwc1UyRlIvekJ4ZytPNUNB?=
 =?utf-8?B?aWxjS2dWR2lTMFNPM3ppZXJmWlZZeUc4RXZNZUZoM0o2ZGVHUEFXU0F1Tncx?=
 =?utf-8?B?NmJJS1hvZkFKaTdSMzRsK3ZtTXRqa2s0b0NwQjRQNlpuVTNZR0JVUTNPWDlF?=
 =?utf-8?B?MTFSS0Rra2h0N09sdG03NjBQRzlLNU1HUnpZNVR5REwvL0pvZVNIVG1ScHVa?=
 =?utf-8?B?Sm95SWRRTGV4UHJzRXJ5b3dOWFJqUkpBWm1hNWZzRDFiU1NIYUhsQ0gwb3hx?=
 =?utf-8?B?WUNaeUc5T1NrT0o4Y0trcXNzdVJ4ZWM0eHNYMVMyNmc0aittVkMzZWh4VitW?=
 =?utf-8?B?cjFkRWdOTmtBWFBrSFVJWVJnTUtCLzJJbFRqOGRtbWhiQjcxRnpCdFNWRkUv?=
 =?utf-8?B?b0VyY1IzTmM2eFZzdlFjNUVpMktRY2xBUHVoK2FHSFdNVTVuR3d2KzFyL3Ro?=
 =?utf-8?B?cEE3NmdxN005NzVpTDNuVkRNMzZqNHhMbnFycnZURnZTTllrbEU1Mms1Ry83?=
 =?utf-8?B?blBTWTNuRVVqaVIzZFZ2cERpWVljbk5yZjVDNUE1Ry9RdjVITGlIZ2RFT1o5?=
 =?utf-8?Q?V+hSd7+pQhBbAQVvwYhuvqE/DXAaazuaH3bFJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcec189-642b-438d-34c9-08de8b4a014c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 15:11:49.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KM0fvAWCeVOlMwEjWqWbd3TvHNja7M61DGRo8QA7RlCNAEPr5hD3UhkWlLHJqrLNHMYr2I2sYOCAwyWNjA4NQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5966

On Thu, Mar 26, 2026 at 06:09:18PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 24, 2026 at 05:37:28PM +0900, Koichiro Den wrote:
> > Some endpoint platforms cannot use platform MSI / GIC ITS to implement
> > EP-side doorbells. In those cases, EPF drivers cannot provide an
> > interrupt-driven doorbell and often fall back to polling.
> > 
> > Add an "embedded" doorbell backend that uses a controller-integrated
> > doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
> > doorbell).
> > 
> > The backend locates the doorbell register and a corresponding Linux IRQ
> > via the EPC aux-resource API. If the doorbell register is already
> > exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
> > the DMA address returned by dma_map_resource() (which may be an IOVA
> > when an IOMMU is enabled) so EPF drivers can map it into BAR space.
> > 
> > When MSI doorbell allocation fails with -ENODEV,
> > pci_epf_alloc_doorbell() falls back to this embedded backend.
> > 
> > Tested-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/pci-ep-msi.c | 139 +++++++++++++++++++++++++++++-
> >  include/linux/pci-epf.h           |   8 ++
> >  2 files changed, 144 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> > index 85fe46103220..331d84a79193 100644
> > --- a/drivers/pci/endpoint/pci-ep-msi.c
> > +++ b/drivers/pci/endpoint/pci-ep-msi.c
> > @@ -6,6 +6,8 @@
> >   * Author: Frank Li <Frank.Li@nxp.com>
> >   */
> >  
> > +#include <linux/align.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> >  #include <linux/interrupt.h>
> > @@ -36,6 +38,117 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> >  	pci_epc_put(epc);
> >  }
> >  
> > +static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
> > +{
> > +	const struct pci_epc_aux_resource *doorbell = NULL;
> > +	struct pci_epf_doorbell_msg *msg;
> > +	struct pci_epc *epc = epf->epc;
> > +	struct device *dev = &epf->dev;
> > +	size_t map_size = 0, off = 0;
> > +	dma_addr_t iova_base = 0;
> > +	phys_addr_t phys_base;
> > +	int count, ret, i;
> > +	u64 addr;
> > +
> > +	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> > +					  NULL, 0);
> > +	if (count == -EOPNOTSUPP || count == 0)
> > +		return -ENODEV;
> > +	if (count < 0)
> > +		return count;
> 
> This should be avoided...
> 
> resource_count API should return 0 for success and errno for failure with a
> separate argument for resource count.
> 
> And resource_get API should return 0 for success and errno for failure.
> 
> > +
> > +	struct pci_epc_aux_resource *res __free(kfree) =
> > +				kcalloc(count, sizeof(*res), GFP_KERNEL);
> > +	if (!res)
> > +		return -ENOMEM;
> > +
> > +	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> > +					res, count);
> > +	if (ret == -EOPNOTSUPP || ret == 0)
> > +		return -ENODEV;
> > +	if (ret < 0)
> > +		return ret;
> 
> And here, you do the same :/

Thanks for the review.

I'll update these to use the new pci_epc_count_aux_resources(), as suggested in
[PATCH v11 1/7].

> 
> > +
> > +	count = ret;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		if (res[i].type == PCI_EPC_AUX_DOORBELL_MMIO) {
> > +			if (doorbell) {
> > +				dev_warn(dev,
> > +					 "Duplicate DOORBELL_MMIO resource found\n");
> 
> I think technically it makes sense to have more than one doorbell resource per
> endpoint. You may not warn here, but just ensure that you use the first unused
> one. This also means, you need to track the allocated resource.
> 
> If you want to avoid the hassle, just assume that there will be only one
> doorbell resource and add a TODO to extend it if needed.

I think I'll go with the latter approach for now.

The only provider added in this series (see [PATCH v11 3/7]) exposes a single
doorbell resource, so I think it is reasonable to keep that assumption for now
and extend it later if and when a real multi-doorbell provider appears.
This helps keep this series compact and reviewable too.

Best regards,
Koichiro

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
