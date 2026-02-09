Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5137E2F7;
	Mon,  9 Feb 2026 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655442; cv=none; b=Xe8wYr8vMaseDFIZu3Xr9Qdbw1FX98i1Ale6ch4dif0SWvuvU2oe9OY/C9ODmmC815Gp5DAeu2TEUcuKqwh/L47zHIEV3iVZ5WiatgMEp497fK8x1NF5BG7Ya1ez6JkxzmTeizb4HsiKomIf+4S26UvVRocWSEgMDieWTPr6PBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655442; c=relaxed/simple;
	bh=OO9iquCzv3A6/fUnWrP3nuqt+Y7a/XrOR9foeOd7wAw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nO9WC2JA/rUqTLpkwe0wncF47SXT4Azm+QspMOzbeAQwSi8i56nriiBvXnNpwPUL58Qyse3RlPNGwWU4qSp+ApSFrO8p9lrPGrrNGPmmkkeryxtHzIwJ0QMcGybEZ10ce3rYOvY8vOYlohOlvh6qNNDD8WF4iTn846xD4xCftLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f8r9q0PQszHnGkS;
	Tue, 10 Feb 2026 00:43:43 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B075540572;
	Tue, 10 Feb 2026 00:43:53 +0800 (CST)
Received: from localhost (10.48.156.2) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Feb
 2026 16:43:52 +0000
Date: Mon, 9 Feb 2026 16:43:49 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Wei Wang <wei.w.wang@hotmail.com>
CC: <bhelgaas@google.com>, <jgg@nvidia.com>, <akpm@linux-foundation.org>,
	<bp@alien8.de>, <rdunlap@infradead.org>, <alex@shazbot.org>,
	<kevin.tian@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] PCI: Enable the enhanced ACS controls introduced
 by PCI_ACS_ECAP
Message-ID: <20260209164349.00003e41@huawei.com>
In-Reply-To: <SI2PR01MB439394223FDDF3F405B40926DC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43932C799AE9111C7D2C319FDC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
	<SI2PR01MB439394223FDDF3F405B40926DC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sat,  7 Feb 2026 19:30:58 +0800
Wei Wang <wei.w.wang@hotmail.com> wrote:

> The ACS Enhanced Capability introduces several new access controls to
> improve device isolation. These new controls are particularly important
> for device passthrough in virtualization scenarios.
>=20
> For example, a DMA transaction from a device may target a guest physical
> address that lies within the memory aperture of the switch's upstream
> port, but not within any memory aperture or BAR space of a downstream
> port. In such cases, the switch would generate an Unsupported Request (UR)
> response to the device, which is undesirable. Enabling Unclaimed Request
> Redirect Control ensures that these DMA requests are forwarded upstream
> instead of being rejected.
>=20
> The ACS DSP and USP Memory Target Access Control and ACS I/O Request
> Blocking features similarly enhance device isolation. Device grouping in
> Linux assumes that devices are properly isolated. Therefore, enable these
> controls by default if PCI_ACS_ECAP is supported by the hardware. As with
> other basic ACS access controls, these new controls can be configured via
> the "config_acs =3D " boot parameter.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Hi Wei Wang,

I'm late to the game here and may be missing something but
I think the validation and defines for the 2 bit fields are both
misleading and not sufficiently careful to reject values that
are not allowed.  Maybe we do want to allow the reserved value
but if so use a 2 bit mask to validate, not two specific
values that the filed can take.

Thanks,

Jonathan

> ---
>  .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++------
>  drivers/pci/pci.c                             | 13 ++++++++++-
>  include/uapi/linux/pci_regs.h                 |  7 ++++++
>  3 files changed, 35 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 7cfbf1102152..fd895716b07d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5301,13 +5301,22 @@ Kernel parameters
>  				flags.
> =20
>  				ACS Flags is defined as follows:
> -				  bit-0 : ACS Source Validation
> -				  bit-1 : ACS Translation Blocking
> -				  bit-2 : ACS P2P Request Redirect
> -				  bit-3 : ACS P2P Completion Redirect
> -				  bit-4 : ACS Upstream Forwarding
> -				  bit-5 : ACS P2P Egress Control
> -				  bit-6 : ACS Direct Translated P2P
> +				  bit-0     : ACS Source Validation
> +				  bit-1     : ACS Translation Blocking
> +				  bit-2     : ACS P2P Request Redirect
> +				  bit-3     : ACS P2P Completion Redirect
> +				  bit-4     : ACS Upstream Forwarding
> +				  bit-5     : ACS P2P Egress Control
> +				  bit-6     : ACS Direct Translated P2P
> +				  bit-7     : ACS I/O Request Blocking
> +				  bit-9:8   : ACS DSP Memory Target Access Ctrl
> +				      00    : Direct Request access enabled
> +				      01    : Request blocking enabled
> +				      10    : Request redirect enabled
> +				      11    : Reserved
> +				  bit-11:10 : ACS USP Memory Target Access Ctrl
> +				              Same encoding as bit-9:8
> +				  bit-12    : ACS Unclaimed Request Redirect Ctrl
>  				Each bit can be marked as:
>  				  '0' =E2=80=93 force disabled
>  				  '1' =E2=80=93 force enabled
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d2810eb97bda..1714e29ce099 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -942,7 +942,10 @@ static void __pci_config_acs(struct pci_dev *dev, st=
ruct pci_acs *caps,
>  		}
> =20
>  		if (mask & ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
> -			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)) {
> +			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT | PCI_ACS_IB |
> +			    PCI_ACS_DMAC_RB | PCI_ACS_DMAC_RR |
> +			    PCI_ACS_UMAC_RB | PCI_ACS_UMAC_RR |
> +			    PCI_ACS_URRC)) {
This used of the RB and RR Bits seems misleading to me as they form parts
of 2 bit field that can only take values 0, 1 and 2.

So if the command line set PCI_ACS_UMAC_RB and PCI_ACS_UMAC_RR it
would have hit the reserved value and that should be detected.

Hence I think you need to do this sort of masking + additional checks that =
these
2 bit fields have valid content.

>  			pci_err(dev, "Invalid ACS flags specified\n");
>  			return;
>  		}
> @@ -1002,6 +1005,14 @@ static void pci_std_enable_acs(struct pci_dev *dev=
, struct pci_acs *caps)
>  	/* Upstream Forwarding */
>  	caps->ctrl |=3D (caps->cap & PCI_ACS_UF);
> =20
> +	/*
> +	 * Downstream and Upstream Port Memory Target Access Redirect,
> +	 * Redirect Unclaimed Request Redirect Control
> +	 */
> +	if (caps->cap & PCI_ACS_ECAP)
> +		caps->ctrl |=3D PCI_ACS_DMAC_RR | PCI_ACS_UMAC_RR |
> +			      PCI_ACS_URRC | PCI_ACS_IB;
> +
>  	/* Enable Translation Blocking for external devices and noats */
>  	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
>  		caps->ctrl |=3D (caps->cap & PCI_ACS_TB);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ec1c54b5a310..593ef522d2ba 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1016,6 +1016,7 @@
> =20
>  /* Access Control Service */
>  #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
> +#define  PCI_ACS_ECAP		0x0080  /* ACS Enhanced Capability */
>  #define  PCI_ACS_SV		0x0001	/* Source Validation */
>  #define  PCI_ACS_TB		0x0002	/* Translation Blocking */
>  #define  PCI_ACS_RR		0x0004	/* P2P Request Redirect */
> @@ -1023,6 +1024,12 @@
>  #define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
>  #define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
>  #define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
> +#define  PCI_ACS_IB		0x0080	/* I/O Request Blocking */
> +#define  PCI_ACS_DMAC_RB	0x0100  /* DSP Memory Target Access Blocking */
> +#define  PCI_ACS_DMAC_RR	0x0200  /* DSP Memory Target Access Redirect */
> +#define  PCI_ACS_UMAC_RB	0x0400  /* USP Memory Target Access Blocking */

If I'm reading this write, those are specific values in the
ACS USP Memory Target Access Control, not what they appear to be here
which is bits that can be combined.
I think you need a _MASK and separate definitions for the 3 values that
are allowed.

> +#define  PCI_ACS_UMAC_RR	0x0800  /* USP Memory Target Access Redirect */
> +#define  PCI_ACS_URRC		0x1000	/* Unclaimed Request Redirect Ctrl */
>  #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
>  #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
>  #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */

