Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CAC2EBB8D
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 00:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785371540; cv=none; b=Y3Fy47TUILVvoa12Gq3iuBZ8+MLiVbnhW4PY/gu27e9PE1w0h6opv4QWw76hWHg9tWNmeupmGFAZpNpNRRMQyXjw4DDlV/sP/SJw3yszDBkYPG9ySprtqXKDDj71E8m7y8gh/LRVMJGIrGDCdU/naWnabAENoPZZQSnN55Ui5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785371540; c=relaxed/simple;
	bh=wIN063ezvtqrqngYFyStsRmrejZcDdISezQOXe2MtJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftlZ/DSSfhX9XckPzgv20py2qoCESx1wnW3ElvwJZWRbyLi1mDLxW/3YaIqnXnxfdWgfvyz2DsJRRV4sED5VearrOkW5+2IpBL2tkhG5atZLJU+nu05LLozzbFcEMI9RzUZx1IWHL4EiWT1pa5Ixdz8IjxihmiNih4wKWnhEAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1k63NLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1k63NLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6F01F00ACF
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 00:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785371539;
	bh=zrBDuhJRZUtR91nEShzz3zzvGOSBPmWKWEmvj9/W/G4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=h1k63NLN6cmj1kpQ2QMw0xEfxEH7JiUMtkGEsPQViU1mgkbzvlHJSwQZQ0tW8qdNp
	 jCKdDviRwmKgYm4RSAu5XlG7HktT1YpUX7AMJ5BMPv+XLbdqgK/Lktl9P6wfWdHC3d
	 Xu3x1+eR9hfKogH6XBpnbXniI7/J0DVPwunQQfeYpMbnCj3EDVZijuvPLJrlkf1VuG
	 FekmTSNopJLoaQPL3vLDwjW7dCkUtOe73Hf7gABMIhsXWq+eih2yxuPc11UZTxL9T8
	 FkzSTxy+R8o7c8Jj+dxB6P2c9eYK7p+oW8mPj1ihta5WdCc/6cuNTJjK6PtMQvHHQB
	 E3IRc+53fErag==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15e03c2763so46613266b.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 17:32:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YxUTEI2Sdae6guQ385Pkr0LcAJ3FmKgdtdxUThGos7/hoHD7zY3
	OcREZPdMbY87anzw1x9v+3E26i8y8ZfM20kNyF+1xlDXJjEt9bjiY2F1QYGOBcE8mbBDxqFYFKD
	FGEZZMk3U77BpiANdcRB2/tUABBFDEQ==
X-Received: by 2002:a17:907:3e9d:b0:c08:5bdb:e904 with SMTP id
 a640c23a62f3a-c1facba47a5mr5925766b.9.1785371537782; Wed, 29 Jul 2026
 17:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727234408.296186-1-rosenp@gmail.com>
In-Reply-To: <20260727234408.296186-1-rosenp@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 29 Jul 2026 19:32:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLLME5rN_HW4hEPfGcLBZX-r-10XJ_=cvU1nq1x4cJEEg@mail.gmail.com>
X-Gm-Features: AUfX_mxctybY_ktpTHGhwAesKt4Jprc3RZsV78twWem5e_3ICmeMx7EDwdgtyQg
Message-ID: <CAL_JsqLLME5rN_HW4hEPfGcLBZX-r-10XJ_=cvU1nq1x4cJEEg@mail.gmail.com>
Subject: Re: [PATCHv2] PCI: iproc: platform: use device functions instead of OF.
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	"moderated list:BROADCOM IPROC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 6:44=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> Since this is supposed to be the higher layer file, use higher layer
> than OF to handle this. Remove OF headers as a result.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: fix platform_get_resource() parameters.
>  drivers/pci/controller/pcie-iproc-platform.c | 31 ++++++++------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/c=
ontroller/pcie-iproc-platform.c
> index 4c9a0c4bb923..488ff737ec52 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> @@ -10,12 +10,8 @@
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> -#include <linux/of_address.h>
> -#include <linux/of_pci.h>
> -#include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
>
> -#include "../pci.h"
>  #include "pcie-iproc.h"
>
>  static const struct of_device_id iproc_pcie_of_match_table[] =3D {
> @@ -40,11 +36,14 @@ static int iproc_pltfm_pcie_probe(struct platform_dev=
ice *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
>         struct iproc_pcie *pcie;
> -       struct device_node *np =3D dev->of_node;
> -       struct resource reg;
> +       struct resource *reg;
>         struct pci_host_bridge *bridge;
>         int ret;
>
> +       reg =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!reg)
> +               return -ENODEV;
> +
>         bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
>         if (!bridge)
>                 return -ENOMEM;
> @@ -52,26 +51,20 @@ static int iproc_pltfm_pcie_probe(struct platform_dev=
ice *pdev)
>         pcie =3D pci_host_bridge_priv(bridge);
>
>         pcie->dev =3D dev;
> -       pcie->type =3D (uintptr_t)of_device_get_match_data(dev);
> -
> -       ret =3D of_address_to_resource(np, 0, &reg);
> -       if (ret < 0) {
> -               dev_err(dev, "unable to obtain controller resources\n");
> -               return ret;
> -       }
> +       pcie->type =3D (uintptr_t)device_get_match_data(dev);
>
> -       pcie->base =3D devm_pci_remap_cfgspace(dev, reg.start,
> -                                            resource_size(&reg));
> +       pcie->base =3D devm_pci_remap_cfgspace(dev, reg->start,
> +                                            resource_size(reg));
>         if (!pcie->base) {
>                 dev_err(dev, "unable to map controller registers\n");
>                 return -ENOMEM;
>         }
> -       pcie->base_addr =3D reg.start;
> +       pcie->base_addr =3D reg->start;
>
> -       if (of_property_read_bool(np, "brcm,pcie-ob")) {
> +       if (device_property_present(dev, "brcm,pcie-ob")) {

If the property is boolean, it should use read_bool and vice-versa.

>                 u32 val;
>
> -               ret =3D of_property_read_u32(np, "brcm,pcie-ob-axi-offset=
",
> +               ret =3D device_property_read_u32(dev, "brcm,pcie-ob-axi-o=
ffset",
>                                            &val);
>                 if (ret) {
>                         dev_err(dev,
> @@ -87,7 +80,7 @@ static int iproc_pltfm_pcie_probe(struct platform_devic=
e *pdev)
>          * core driver. For platforms that require explicit inbound mappi=
ng
>          * configuration, "dma-ranges" would have been present in DT
>          */
> -       pcie->need_ib_cfg =3D of_property_read_bool(np, "dma-ranges");
> +       pcie->need_ib_cfg =3D device_property_present(dev, "dma-ranges");

This is correct as dma-ranges may not be bool.

Rob
