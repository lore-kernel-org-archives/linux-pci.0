Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C77855930E
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083210; cv=none; b=iEx/6P5vijOFI33zliL9nQCf4CASY5VpRHeFjLP2+ZnKeuGmXhh4+mXB5+n6NWJ483nAbx52Wv8FfQy5XOXyJK9/C5+oUAQqL1e3h+1OecFe4XoNEEF2d7HhiVwE/Jz+FS7Y3/3/TfVCEL2080ROOrVM0UwnG2cyZTZGSghBpz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083210; c=relaxed/simple;
	bh=NjE+NlFHRjTnYBxRv5AeHgCGKiRAUEUn7VOP+IM0y1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mek9qGSK1jDVa2pABUzqznMvis/YjJxrzTAMVSxRGLZxkIkwXX9nOFPg+M6ao2t6GojdeGfd6eshh3iDHqaphsun3StDM0E7UXHs1GzCFMLHBsZ5YSG4DObg4azMyF4fkIyeUI45Ru5VRiO4IGqsgRwFkmlfGVZNP+zuw04lURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYXmhlBL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYXmhlBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11DA1F00898
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083207;
	bh=Yfd11v+qIqeVBxfADXNx2UXL41JFK4uuuXKhTF5VTRI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IYXmhlBL0J/JWT/9lEv4w4y3I/delw8fBoaFW+pjfcontYq2UgiIu+eDzayTmnWgV
	 XY32NjzY1Ez9f6aE1zwF8+q58aHDo7XYv4biT4YNagHxLTi91mBc+Owciyx4YpOyAT
	 J/bBJrLvYpStQTzfxg7ZBA/ckWO5G7dGekFsvwkzCNHeJWCS2c5d2Wtnn3791yLiro
	 KFVIx9blRb0Yr+wYTGO6AuXceB05frpZtx0O8g8xBBD0LT/gfiMJxK3RwlKKuUgZB7
	 fImpeawqrgXM6Ld+SbQ4txBuIM1fT/OBj2MeD/PMUu+LDafsqqXSlJ8S3wweaVX6BE
	 m9WKeEfZEZcrg==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a318299b38so37514491fa.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 06:20:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzLNaeeIOhsPyFSl0S7yDxsCei36jMukdEUFPUGppQwfyuTIAc+K+wJxLkYKJ2tzRaPKGCT7f+mFD8=@vger.kernel.org
X-Gm-Message-State: AFuF++mWaac51YVkO5eMx+20Q1IDQbo67hTDcEUxzd61zQbABfI52jkP
	3fmDdr1urQy0lEfVeHIhTaczvX+Mt7aQ2y1Eil46P86qYxtyUptVvHc15yF1OyNWfbxuHiVtQtf
	Se7DZ/N96NfKa/bjHdgje0DXRPOA7bGw=
X-Received: by 2002:a05:651c:31c3:b0:3a3:7680:67fc with SMTP id
 38308e7fff4ca-3a5fbff7102mr32218851fa.27.1790083206001; Tue, 22 Sep 2026
 06:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260919162655.3499010-4-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260919162655.3499010-4-sathyanarayanan.kuppuswamy@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 15:18:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hBz7=K9nUK1FR206TD7L2xThm+_KYpWj-gDUB=yiBjog@mail.gmail.com>
X-Gm-Features: AcwNN1Uu3qCIZH-07wZWj8LTBcXnzrc7R3ctZIJa8Ej1_FKyYxIBWQG4Z6wokDI
Message-ID: <CAJZ5v0hBz7=K9nUK1FR206TD7L2xThm+_KYpWj-gDUB=yiBjog@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] PCI/ACPI: Tidy _OSC control bit checking
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rafael J Wysocki <rafael@kernel.org>, Guixin Liu <kanie@linux.alibaba.com>, 
	Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 6:27=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Add OSC_OWNER() helper to prettify checking the _OSC control bits to lear=
n
> whether the platform has granted us control of PCI features.  No function=
al
> change intended.
>
> [bhelgaas: split to separate patch, commit log]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
> Changes since v12
>
>  * Rebased to v7.3-rc3.  Parenthesized the OSC_OWNER() arguments, as
>    checkpatch --strict asks.
>  * Also convert native_cxl_error, which v12 left open coded.  Its bit com=
es
>    from the extended control word, so that word gets its own ext_ctrl
>    local.
>
> v12 posting
> https://lore.kernel.org/all/20201126011816.711106-1-helgaas@kernel.org/
>
>  drivers/acpi/pci_root.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 88c65f34e305..756dc2f055f5 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -993,6 +993,12 @@ static void acpi_pci_root_release_info(struct pci_ho=
st_bridge *bridge)
>         __acpi_pci_root_release_info(bridge->release_data);
>  }
>
> +#define OSC_OWNER(ctrl, bit, flag)             \
> +       do {                                    \
> +               if (!((ctrl) & (bit)))          \
> +                       flag =3D 0;               \
> +       } while (0)
> +
>  struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>                                      struct acpi_pci_root_ops *ops,
>                                      struct acpi_pci_root_info *info,
> @@ -1003,6 +1009,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pc=
i_root *root,
>         int node =3D acpi_get_node(device->handle);
>         struct pci_bus *bus;
>         struct pci_host_bridge *host_bridge;
> +       u32 ctrl, ext_ctrl;
>
>         info->root =3D root;
>         info->bridge =3D device;
> @@ -1028,21 +1035,21 @@ struct pci_bus *acpi_pci_root_create(struct acpi_=
pci_root *root,
>                 goto out_release_info;
>
>         host_bridge =3D to_pci_host_bridge(bus->bridge);
> -       if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
> -               host_bridge->native_pcie_hotplug =3D 0;
> -       if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
> -               host_bridge->native_shpc_hotplug =3D 0;
> -       if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
> -               host_bridge->native_aer =3D 0;
> -       if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
> -               host_bridge->native_pme =3D 0;
> -       if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
> -               host_bridge->native_ltr =3D 0;
> -       if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
> -               host_bridge->native_dpc =3D 0;
> -
> -       if (!(root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL=
))
> -               host_bridge->native_cxl_error =3D 0;
> +
> +       ctrl =3D root->osc_control_set;
> +       ext_ctrl =3D root->osc_ext_control_set;
> +
> +       OSC_OWNER(ctrl, OSC_PCI_EXPRESS_NATIVE_HP_CONTROL,
> +                 host_bridge->native_pcie_hotplug);
> +       OSC_OWNER(ctrl, OSC_PCI_SHPC_NATIVE_HP_CONTROL,
> +                 host_bridge->native_shpc_hotplug);
> +       OSC_OWNER(ctrl, OSC_PCI_EXPRESS_AER_CONTROL, host_bridge->native_=
aer);
> +       OSC_OWNER(ctrl, OSC_PCI_EXPRESS_PME_CONTROL, host_bridge->native_=
pme);
> +       OSC_OWNER(ctrl, OSC_PCI_EXPRESS_LTR_CONTROL, host_bridge->native_=
ltr);
> +       OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL, host_bridge->native_=
dpc);
> +
> +       OSC_OWNER(ext_ctrl, OSC_CXL_ERROR_REPORTING_CONTROL,
> +                 host_bridge->native_cxl_error);
>
>         acpi_dev_power_up_children_with_adr(device);
>
> --
> 2.43.0
>
