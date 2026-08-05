Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020136.outbound.protection.outlook.com [52.101.229.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8B2DF134;
	Wed,  5 Aug 2026 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895426; cv=fail; b=Sxc1pfcxNLpbdeZQe/NnV62SM4+2t0hEWIFHh8y+CA2hL3rRKsKf+xYASi1XVQJRb/omKdakPavbtrABQfPKTjHlKxULljngj65kVrprnnz7i1iCc9QwEldrK2wiUrlIAb0FDojrjTmfGziZJYgINuYYbEdySMH+ss3Ag2ml+H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895426; c=relaxed/simple;
	bh=Z8EB6hANU3IcmFiW1Xcitd352/Px+7AygZ8/UBnkAlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S3Qw6aBtXnZGCki4iPuKqjQIhtAXYboluKoKFsCK7mJwLRKdCzF/A9hiWGZezKBsPL7No0nCJLlUbaaVCV0sWUhgrJIbwcoB9KaCV6jEjarY7UVYCR8v05P5EoU8mWa68JNVc027w9+i7Sq1QHzhmsMbXo1+2NWjHrNTGNJcwqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uqRnbsfc; arc=fail smtp.client-ip=52.101.229.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uqRnbsfc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaZRkzVymbQK1XQzvTd+EVx8ODPBUTSJXxjgRT8hSRR1nXynRc7o90COzKYfXdeg4dGL8V/g60IciMLojbbu4w91ROgHuqgUK/eW75xk61DuwMYRE+xFqibCQJF8qkQCyK89I9FG1gKTH0olJPHyt6JFxAsuTGA91bLIUdBF42JdlsUUNueC9Tl/B52XxJTdnUd/r6wcP/EZNh87VFfRsmFJrRu7THlwdlziFFXxFEQDUMlpq/f24eqLRxXAQJEpgEuRAs31qjHDHOOUJhhD2diTzYUT07dmDQD1NlX/b2354LcNy9KZOlMfcsyCqju0iDwStXxWt46oppwrTjC6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqGTOzACIbrKi+SXuXkfXPczHPINNS6yxe3PlyL/puE=;
 b=hlWYoNDczxJVWxdW/u+bVJibYZWMlSdVUESiTjaJb+pZNpQpkz70+6naYqMoFj8z2qQojoLJFVwB4ilGg9oJQUiqZubLkxqUCcujTg/MeNkTurPn+KaaiDqgl8KLBwR9a8CV/Bspqq2vwrH2DNNfMB+5CB6aFAMHWIiwQNl1FiQUSTZzE8zBDSuA6viGDMMqoZa5aR7NjeqlzfxZSctjmHxMF4KDhtz02IOgowrwqwOEj65QDyC6ZsYSbPaepmtKDmqAxXQFnMWvZQX/qjrc45TuevMwRRGe9ZjpzYYsiVQOpk3K0721dKvjRchriV9QkUnyVEuF2llO3iRvDO7qJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqGTOzACIbrKi+SXuXkfXPczHPINNS6yxe3PlyL/puE=;
 b=uqRnbsfcAG+1j1LhI24wNXQz08mh2CfeMU7H3JkG1zJZQ8/uHa9WGagVC1kzhyqRgAhXeKclmJQqAQPJIOGpp/Rfja7n0n9HJGv/+g4FSnQ8ncars+aKSnteGznrIOWatC5UniXYyhsYwU4eErWAj4jDm7tg4W0S6NME0VhOH3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB5443.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:263::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 02:03:40 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 02:03:40 +0000
Date: Wed, 5 Aug 2026 11:03:39 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] PCI: endpoint: Define endpoint DMA BAR metadata
 format
Message-ID: <viep5vesamn3ty5juq5ruqffwtjv4zze7hxyy45cpcfhfgao5y@75rmylgdsul2>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-2-den@valinux.co.jp>
 <anIEDHaNqg9P4m4E@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anIEDHaNqg9P4m4E@SMW015318>
X-ClientProxiedBy: TY4P301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB5443:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c4f794-d782-4e06-544d-08def295c505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|376014|7416014|4143699003|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cjY70LUwsP/UNMyAI/3nrnq9y6C7eKzlmgTt/ai+ZzaALJfXKIZMoemNhsMINtQdOoL/hOiowtTuD7KLoL0Zm0ZeHJ+6bLsmJtLxVpKjB3fcJuuD6zOL7gRhrPHqkCBI/V7Assh/3eG0jk0PGeir1XPg8ZJL4Cnk5/jxLa3pRHcbcqEM8BnSvwTlvtA+/LRP4YsuW1DigtjOlpZN2guCkn4u5HTrybABIAMsvSPDb8T1CZFxCEclGw02J3SV1O2yeXL4/SNpzt8zuMh+vNJ4XqTkWw4hwy7L5dEMdbyMdJcoBMdZ4xyzj/SE2H9pL3m20kJ2XVC1on1MZZJ0135Vo0Ftd8g9/1hQdgYBzSNhpclc/FiWO3RViAN4cjoZD/7NWWI47CFLvhwdW/AbBtNAFJkye0ocPqXBOiX3EvN2SBswbcqlMwXHCWc2JuCXsn/qOFXuFpYI9bg//1zkkEbyFEU2DJRu6ZdFQWPOoeZAHRe9Sp0xzw60O29fLVl4I/LQxcyyPVVjgNF5e8WWsvj2Tf2W6f/yQcYCX+jiQgcyrbzAgc1hIthrdVZ6/yKsoQECEkb2CKi8RbjTGnKh1hVJuc70DKPx2L+u4AUvgIORIGlf40ixCbeog4+Fm9ecPXa79Qf6dI+PGkzB0/j+Y6irhxE5GJrUnvi5xygqsQICKck=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(7416014)(4143699003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pycMGpGK6FuxIHyp9gaMW0eHTnnHPGvk9GWMtu5TINm0/K0r5UF6r8oCipoG?=
 =?us-ascii?Q?8GI9bB9G1cR35il18LqmOgQYVyRh/F4snGNdFhf5c/yZ006uYg/eG3vLwwEe?=
 =?us-ascii?Q?KYBRKU4rkchL+bQP7NZB8Ajk0e3nKiOF36lsXA4FJdkFcorvKzY86Qzx/2N/?=
 =?us-ascii?Q?XktzupulMQWMHGnj7Jbs94daIqIYxkvl+AXeUls+F8D+HA+UfZZAu2shboXK?=
 =?us-ascii?Q?TUAM2RpY1If33gnXW1w3XOgyxxL+z9EnoMuczqUI9ZS0W4spwfHy7OH0/Lki?=
 =?us-ascii?Q?pp5kG90MFB2+4epk86FaSX4Sm1e9GdUEkuNchBJNktK2zag3EVKyIPIDv+iS?=
 =?us-ascii?Q?p6jTthE93S9JNNBFBA4jc+23nLV6NJirKat7y3CKON/rQQoes+yfUchHiPUf?=
 =?us-ascii?Q?QQDr35+uyPls8q5axOoVGBxXvllE33GJEZzBBX4PP7TF0q0DktcdEMWY1+BW?=
 =?us-ascii?Q?Eq0rNZZ3FHCkVJzMQFLTFizP8tUD/tUru5/6yl7OqoNvrhH9rchbrbLOCUjJ?=
 =?us-ascii?Q?1qzyvabSgvD6lt4tlQDWSSkDY4jK3S3vZB1UpR8lpqMBryv/fc8dYyKfKhC6?=
 =?us-ascii?Q?Htzo7x6IY/LjQ8EIkBDLHYEh92Yc9iIdDZJZZAAaMuewLJ+KUUvgEdFY2Riu?=
 =?us-ascii?Q?jUxc9UVzDqMJcJrxdEtJBkAV0cc7+OILS5RK3SXfb9/cq/mq+BZxvDS/BO1V?=
 =?us-ascii?Q?S0vZWy5wvxaF2iIn+7/8f0PS9O3YvEJqqJHGxVK6cx+e4kFQkc4kpfCFxJ01?=
 =?us-ascii?Q?/tIWwUodjOlp600XzFylJ8bCOLyDMWzH+bz935Rw21f7c9MBXOzxoEXpw4+m?=
 =?us-ascii?Q?ewnOBpQW8hIzSgwSdzyj54ePj3V0nsVE8dfARiBrMsoaTJD3Vf9QM/kl8we7?=
 =?us-ascii?Q?HYzcxz9WEB9RPP4uJaIWBOzu4dLPlKUHtlhFZbts5+yQZT/HGIfRP/jLRvyI?=
 =?us-ascii?Q?veQX4j+gEc+55mN3s0DGM4BlKUWekFiVrqXhkiPSHJKyDIndSHQysL3dJGEA?=
 =?us-ascii?Q?qYhjVjQWnh9gf858ZNzIIna/3AE8Nmby/9tTOHm7UxGbe7DLIuwT6lzpr+Ud?=
 =?us-ascii?Q?xth1JcyQhf+Xn72WqKd6VfXDZOn116NuimxfbksoFstR2BrOXhjfxaZhg6Ls?=
 =?us-ascii?Q?wNZs6uTe3lUKvsLmTtsE1O3XbegxcYuEwJosCnbs76QKJFSOPLpYaJmY3RcD?=
 =?us-ascii?Q?FHFS3AzI2GuEedpn2Z/ZH3scn1ZIpnlpRRTbDSt5v98/PJ1wpyxqEfYjaOsC?=
 =?us-ascii?Q?cDRLoIupGasqCht4SYqntLErjey8XKv9oBFLLGHGeN9dGk1pY2+Vl6vaknoh?=
 =?us-ascii?Q?sMFZr6Lnkoej562zVCYHFRkcdoMrFMISGaRUj6zfkXz9mHKWeOwqncVLin9c?=
 =?us-ascii?Q?y/f3S1X8ZQ/lPTTuTuIoi7/xVslpVeVhWwhwESKkE/uL+mSefUXVfKoRmwN0?=
 =?us-ascii?Q?73q0ck3dA1XswN2nNx9P0ZIj6+DiR27E9nugve2BpROkELKkAChQJQRp7D9h?=
 =?us-ascii?Q?ufZn03+NFUK0Bb9W4ClA5EsEwtqakz+zyMxO8yrDbjAFxEKkbSzdv4QehufK?=
 =?us-ascii?Q?uGOgu88Ikh02XOalZN9kxUQq9q+qGZ3zlDmyd0PqS/s3d26VcwUtSyEojhFA?=
 =?us-ascii?Q?NbLPn74qNo8+jRJjr3GoUbODfyO4fSjnMsfDyvJNOodjsPSKP8eFu3jwCklL?=
 =?us-ascii?Q?C4ETP3v2NQUeyV3HfIDrEgTc5QaIAZPJJx2a2qkCZtDy4dmXZKhbT6xIuxLH?=
 =?us-ascii?Q?MEmEHj/XSYFTJVeZws0dJfDeOL7vmkeyrv3DZOO/rC+M0Mtm/31P?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c4f794-d782-4e06-544d-08def295c505
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 02:03:40.3940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOFwz9k35xus3Y+2xFGSnB/59e+meueFDnUZ9CwsfPovfCmV/dDMRv/y2CeaB4FNaXMbisnYevvJvYxIvF1a5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5443

On Tue, Aug 04, 2026 at 10:23:56AM -0500, Frank Li wrote:
> On Tue, Aug 04, 2026 at 12:38:50PM +0900, Koichiro Den wrote:
> > Define the BAR-resident metadata format used by endpoint functions that
> > expose an endpoint-integrated DMA controller to the host.
> >
> > A VSEC-based discovery scheme would be a natural fit, and existing
> > dw-edma-pcie providers such as Synopsys EDDA and AMD (Xilinx) MDB/CPM6
> > already use VSECs for DMA discovery. However, some endpoint controllers
> > cannot provide enough writable configuration-space storage for a
> > complete, controller-defined payload. Keep the extensible metadata in a
> > BAR instead, where the endpoint function controls the layout and size.
> >
> > The format describes the DMA register window, exported channel counts,
> > descriptor windows, optional auxiliary windows, endpoint-local descriptor
> > and auxiliary DMA addresses, and a ready bit that tells the host when the
> > described BAR windows are usable. Channel entries keep the auxiliary
> > window optional so layouts that need a separate data or auxiliary aperture
> > can describe it without a format bump.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v6:
> >   - No changes.
> >
> >  MAINTAINERS                |   1 +
> >  include/linux/pci-ep-dma.h | 170 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 171 insertions(+)
> >  create mode 100644 include/linux/pci-ep-dma.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 03febbc91a06..c503cf11b5a2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20933,6 +20933,7 @@ F:	Documentation/PCI/endpoint/*
> >  F:	Documentation/misc-devices/pci-endpoint-test.rst
> >  F:	drivers/misc/pci_endpoint_test.c
> >  F:	drivers/pci/endpoint/
> > +F:	include/linux/pci-ep-dma.h
> >  F:	tools/testing/selftests/pci_endpoint/
> >
> >  PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
> > diff --git a/include/linux/pci-ep-dma.h b/include/linux/pci-ep-dma.h
> > new file mode 100644
> > index 000000000000..73f72455843c
> > --- /dev/null
> > +++ b/include/linux/pci-ep-dma.h
> > @@ -0,0 +1,170 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __LINUX_PCI_EP_DMA_H
> > +#define __LINUX_PCI_EP_DMA_H
> > +
> > +#include <linux/bits.h>
> > +
> > +/*
> > + * BAR metadata format used by PCI endpoint functions that expose an
> > + * endpoint-integrated DMA controller to a PCI host.
> > + *
> > + * Offsets are relative to the beginning of the metadata blob. Multi-byte
> > + * fields are little-endian. The blob is normally placed at offset 0 of a
> > + * function BAR selected by the endpoint function and discovered by the host
> > + * driver using device-specific policy. Other data in the same BAR, such as a
> > + * standard MSI-X table or PBA, is outside this metadata format.
> > + *
> > + *          31                                                              0
> > + *          +---------------------------------------------------------------+
> > + * +0x000   | metadata magic                                                |
> > + *          +---------------------------------------------------------------+
> > + *          31                            16 15            8 7              0
> > + *          +-------------------------------+---------------+---------------+
> > + * +0x004   | metadata length               | reserved      | revision      |
> > + *          +-------------------------------+---------------+---------------+
> > + *          31 30 29     27 26          19 18          11 10           3 2  0
> > + *          +--+--+--------+--------------+--------------+--------------+---+
> > + * +0x008   |R |H |reserved| ch entry size| RD count     | WR count     |BAR|
> > + *          +--+--+--------+--------------+--------------+--------------+---+
> > + * +0x00c   | register window offset[31:0]                                  |
> > + *          +---------------------------------------------------------------+
> > + * +0x010   | register window offset[63:32]                                 |
> > + *          +---------------------------------------------------------------+
> > + *          31                            16 15            8 7              0
> > + *          +-------------------------------+---------------+---------------+
> > + * +0x014   | reserved                      | layout data   | layout        |
> > + *          +-------------------------------+---------------+---------------+
> > + * +0x018   | register window size                                          |
> > + *          +---------------------------------------------------------------+
> > + * +0x01c   | write table                                                   |
> > + *          | ( channel table entries #0 ~ #N )                             |
> > + *          +---------------------------------------------------------------+
> > + *          | read table                                                    |
> > + *          | ( channel table entries #0 ~ #N )                             |
> > + *          +---------------------------------------------------------------+
> > + *
> > + *          metadata magic: PCI_EP_DMA_METADATA_MAGIC.
> > + *          metadata length: byte size of the whole metadata blob. The value
> > + *                           must fit in PCI_EP_DMA_METADATA_HDR_LEN_FIELD and
> > + *                           in the BAR allocation that contains the metadata.
> > + *          revision: metadata format revision.
> > + *          R: ready bit. Set only by the endpoint after all fields and BAR
> > + *             windows described by this metadata have been programmed and can
> > + *             be used by the host. The host must not consume the windows
> > + *             before observing this bit.
> > + *          H: host-request bit. Set only by the host driver after it has found
> > + *             this metadata. The endpoint may use this as the trigger to
> > + *             program DMA window BAR subrange mappings, and may clear it while
> > + *             revoking R during teardown or reinitialization.
> 
> Is possible to put all H bit to sperate 32bit space to avoid
> Read-modify-write in case need sync with EP side although other bit is
> read only by host now.

That sounds reasonable. I'll respin it with the H bit in a spearate 32-bit word
and increase PCI_EP_DMA_METADATA_HDR_LEN to 0x20.

Thanks for the review,
Koichiro

> 
> Frank
> 
> > + *          ch entry size: byte stride between consecutive channel table
> > + *                         entries. Revision 1 requires at least
> > + *                         PCI_EP_DMA_METADATA_CH_ENTRY_SIZE bytes.
> > + *          RD count: number of exposed RC-to-endpoint DMA read channels and
> > + *                    read channel-table entries.
> > + *          WR count: number of exposed endpoint-to-RC DMA write channels and
> > + *                    write channel-table entries.
> > + *          BAR: BAR that contains the DMA controller register window.
> > + *          register window offset: BAR-local byte offset of the DMA controller
> > + *                                  register window in BAR.
> > + *          register window size: DMA controller register window size in bytes.
> > + *          layout: DMA controller register layout identifier.
> > + *          layout data: layout-specific data. For
> > + *                       PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA this is the
> > + *                       DesignWare eDMA/HDMA map format.
> > + *          write table: starts at PCI_EP_DMA_METADATA_HDR_LEN if write channel
> > + *                       count is non-zero.
> > + *          read table: starts at PCI_EP_DMA_METADATA_HDR_LEN plus the write
> > + *                      table size if read channel count is non-zero.
> > + *          reserved fields and bits: write zero and ignore on read.
> > + *
> > + *
> > + * Channel table entry:
> > + *
> > + *          31                 17 16 15 14   12 11 10     8 7                0
> > + *          +--------------------+--+--+-------+--+--------+----------------+
> > + * +0x000   | reserved           |A |rs|aux BAR|rs|desc BAR|hardware channel|
> > + *          +--------------------+--+--+-------+--+--------+----------------+
> > + * +0x004   | descriptor window BAR offset[31:0]                            |
> > + *          +---------------------------------------------------------------+
> > + * +0x008   | descriptor window BAR offset[63:32]                           |
> > + *          +---------------------------------------------------------------+
> > + * +0x00c   | descriptor window size                                        |
> > + *          +---------------------------------------------------------------+
> > + * +0x010   | descriptor DMA address[31:0]                                  |
> > + *          +---------------------------------------------------------------+
> > + * +0x014   | descriptor DMA address[63:32]                                 |
> > + *          +---------------------------------------------------------------+
> > + * +0x018   | auxiliary window BAR offset[31:0]                             |
> > + *          +---------------------------------------------------------------+
> > + * +0x01c   | auxiliary window BAR offset[63:32]                            |
> > + *          +---------------------------------------------------------------+
> > + * +0x020   | auxiliary window size                                         |
> > + *          +---------------------------------------------------------------+
> > + * +0x024   | auxiliary DMA address[31:0]                                   |
> > + *          +---------------------------------------------------------------+
> > + * +0x028   | auxiliary DMA address[63:32]                                  |
> > + *          +---------------------------------------------------------------+
> > + *
> > + *          A: auxiliary-window-valid bit. If clear, aux BAR and auxiliary
> > + *             window fields are ignored.
> > + *          aux BAR: BAR that contains the optional auxiliary window.
> > + *          desc BAR: BAR that contains the descriptor window.
> > + *          hardware channel: DMA controller's hardware channel number.
> > + *                            Revision 1 entries are currently consumed in dense
> > + *                            0-based order.
> > + *          descriptor window BAR offset: BAR-local byte offset of the
> > + *                                        descriptor window in desc BAR.
> > + *          descriptor window size: descriptor window size in bytes.
> > + *          descriptor DMA address: endpoint-local address used by the DMA
> > + *                                  controller to fetch descriptors.
> > + *          auxiliary window BAR offset: BAR-local byte offset of the auxiliary
> > + *                                       window in aux BAR.
> > + *          auxiliary window size: auxiliary window size in bytes.
> > + *          auxiliary DMA address: endpoint-local address corresponding to the
> > + *                                 auxiliary window.
> > + *          reserved fields and bits: write zero and ignore on read.
> > + */
> > +#define PCI_EP_DMA_METADATA_MAGIC		0x4d444550 /* "PEDM" */
> > +#define PCI_EP_DMA_METADATA_REV			0x1
> > +
> > +#define PCI_EP_DMA_METADATA_HDR_LEN		0x1c
> > +
> > +#define PCI_EP_DMA_METADATA_HDR			0x04
> > +#define  PCI_EP_DMA_METADATA_HDR_REV		GENMASK(7, 0)
> > +#define  PCI_EP_DMA_METADATA_HDR_LEN_FIELD	GENMASK(31, 16)
> > +
> > +#define PCI_EP_DMA_METADATA_CTRL		0x08
> > +#define  PCI_EP_DMA_METADATA_CTRL_REG_BAR	GENMASK(2, 0)
> > +#define  PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT	GENMASK(10, 3)
> > +#define  PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT	GENMASK(18, 11)
> > +#define  PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE	GENMASK(26, 19)
> > +#define  PCI_EP_DMA_METADATA_CTRL_HOST_REQ	BIT(30)
> > +#define  PCI_EP_DMA_METADATA_CTRL_READY		BIT(31)
> > +
> > +#define PCI_EP_DMA_METADATA_REG_OFF_LO		0x0c
> > +#define PCI_EP_DMA_METADATA_REG_OFF_HI		0x10
> > +#define PCI_EP_DMA_METADATA_REG_LAYOUT		0x14
> > +#define  PCI_EP_DMA_METADATA_REG_LAYOUT_ID	GENMASK(7, 0)
> > +#define  PCI_EP_DMA_METADATA_REG_LAYOUT_DATA	GENMASK(15, 8)
> > +#define PCI_EP_DMA_METADATA_REG_SIZE		0x18
> > +
> > +#define PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA	0x1
> > +
> > +#define PCI_EP_DMA_METADATA_CH_ENTRY_SIZE	0x2c
> > +#define PCI_EP_DMA_METADATA_CH_CTRL		0x00
> > +#define  PCI_EP_DMA_METADATA_CH_CTRL_HW_CH	GENMASK(7, 0)
> > +#define  PCI_EP_DMA_METADATA_CH_CTRL_DESC_BAR	GENMASK(10, 8)
> > +#define  PCI_EP_DMA_METADATA_CH_CTRL_AUX_BAR	GENMASK(14, 12)
> > +#define  PCI_EP_DMA_METADATA_CH_CTRL_AUX_VALID	BIT(16)
> > +#define PCI_EP_DMA_METADATA_CH_DESC_OFF_LO	0x04
> > +#define PCI_EP_DMA_METADATA_CH_DESC_OFF_HI	0x08
> > +#define PCI_EP_DMA_METADATA_CH_DESC_SIZE	0x0c
> > +#define PCI_EP_DMA_METADATA_CH_DESC_ADDR_LO	0x10
> > +#define PCI_EP_DMA_METADATA_CH_DESC_ADDR_HI	0x14
> > +#define PCI_EP_DMA_METADATA_CH_AUX_OFF_LO	0x18
> > +#define PCI_EP_DMA_METADATA_CH_AUX_OFF_HI	0x1c
> > +#define PCI_EP_DMA_METADATA_CH_AUX_SIZE		0x20
> > +#define PCI_EP_DMA_METADATA_CH_AUX_ADDR_LO	0x24
> > +#define PCI_EP_DMA_METADATA_CH_AUX_ADDR_HI	0x28
> > +
> > +#endif /* __LINUX_PCI_EP_DMA_H */
> > --
> > 2.51.0
> >
