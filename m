Return-Path: <SRS0=Gu6D=Z6=intel.com=ley.foon.tan@kernel.org>
Return-Path: <SRS0=Gu6D=Z6=intel.com=ley.foon.tan@kernel.org>
Message-ID: <1487295140.2424.4.camel@intel.com>
Subject: Re: [PATCH] PCI: altera: Fix TLP completion status
From: Ley Foon Tan <ley.foon.tan@intel.com>
To: Yadi Hu <yadi.hu@windriver.com>, lftan@altera.com
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org, Bjorn Helgaas
	 <helgaas@kernel.org>
Date: Fri, 17 Feb 2017 09:32:20 +0800
In-Reply-To: <1487291230-21495-2-git-send-email-yadi.hu@windriver.com>
References: <1487291230-21495-1-git-send-email-yadi.hu@windriver.com>
	 <1487291230-21495-2-git-send-email-yadi.hu@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Jum, 2017-02-17 at 08:27 +0800, Yadi Hu wrote:
> From: "Hu Yadi" <yadi.hu@windriver.com>
>=20
> the driver does not use exactly 'Completion Status' value in TLP,
> these bits should be b15:13 not b14:12.
>=20
> Signed-off-by: Hu Yadi<yadi.hu@windriver.com>
Thanks for the fix.
Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>

> ---
> =C2=A0drivers/pci/host/pcie-altera.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-
> altera.c
> index dbac6fb..650862e 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -56,7 +56,7 @@
> =C2=A0#define TLP_CFG_DW2(bus, devfn, offset)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(((bus) << 24) | ((devfn) << 1=
6) |
> (offset))
> =C2=A0#define TLP_REQ_ID(bus, devfn)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0(((bus) << 8) | (devfn))
> -#define TLP_COMP_STATUS(s)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(((s) >> 12) & 7)
> +#define TLP_COMP_STATUS(s)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(((s) >> 13) & 7)
> =C2=A0#define TLP_HDR_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03
> =C2=A0#define TLP_LOOP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0500
> =C2=A0#define RP_DEVFN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A00
> --
> 2.9.3
>=20
>=20
> ________________________________
>=20
> Confidentiality Notice.
> This message may contain information that is confidential or
> otherwise protected from disclosure. If you are not the intended
> recipient, you are hereby notified that any use, disclosure,
> dissemination, distribution, or copying of this message, or any
> attachments, is strictly prohibited. If you have received this
> message in error, please advise the sender by reply e-mail, and
> delete the message and any attachments. Thank you.
