Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836500;
	b=C+9uf0N4akaS2UpQvUg5tgPXJiQVwH6GFdtWECAd0YwbY2UqEIvduH4Qnww58FZnQ3gn
	 GpkGBWe3OGPEsw4bZyJ/ao1kVAXPpVdw/aJKt4YX9BasPX2eBN93aDGxng5EyMZAfbQTx
	 RV8hcic9NYvId6wUiIeLTbQhoCq/KvjkT7tKT4NCsop3FP5bmcUNTxmO0CPCxA0ozLHep
	 1vszWvHDCPcyh8sLeV6LJzuC1TLk5KcA6TaXHdi+dZnZFPsx8Cy7PFeg9zKRyzU/kSNub
	 SYZG6tdq/W/HqSYh9ZwrZyLnItTPGWLzL34hOnW3xb6BUkQuDNIXykzAS7oHgQBtMgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836500;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T7bgf8GS6WyM+IxvJhj0fqUHI+cDjiNDPd0vUgxMyOI=;
	b=D7L+ia7qqX8G/0o9nzxBCR8PMpqcF2a8/ZiXGhO7Y1dsfx4YAgvM2ztNaOToKkHruRrQ
	 ixBrSSa47k3JXdRWy3DE/EBou+xjhu7Q8hSfj36JBWQ0delmYEZ7eqw51N1gGpnIyMN4S
	 OhTIf/QMFBJcYvt9qDn0FKCj4B/Ff0IARIEwgcwu4iD7JMuE45mnt+Ile0cgSZUEkmIPw
	 ekr56XYn+8O5HzGJLnp4CsL+bS2NajKSbdC+BtBOnELHn5/s8sKPMcXbHt/ZMYa1i1oB9
	 O1wbzKufs5VybFy50SRzx8LVCJIqIRADOCkYtEytGdPOKa5HS9Vsxq2sKcYkNG4xqUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpzD4LLw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838F4606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpzD4LLw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0B91F000C1;
	Wed,  4 Nov 2026 23:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836500;
	bh=T7bgf8GS6WyM+IxvJhj0fqUHI+cDjiNDPd0vUgxMyOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LpzD4LLw8M/qZCoAwhu4EX4nMb2M0t65RyR77YVYnVjGI7gQup/PputD8QCKPxQos
	 qxL6yV/cgR7QYCmv/EnApxKDF3/oYFACvE9ok9LndyjwcjNekLjL89fjdvuG7uO0WN
	 FuXFz017Xtpp4fny8kegw8op4iiVZUE3/OHXayKjG4faHVRJFH3LJ/ot+XZjDL7rQg
	 NDb19wn58aiT9J3MsJQ6zrPSfm0Xpr9sixtmRRhTs86Y/fscCF1lOxJ++JF8cYPDiz
	 HJWV+H6LldEuvRXclZOqQyk0T4yCWP37VF+qiwW1YNqvNnUrw+9svJrzkR1BtzYvjP
	 X/dzYtvz9KCjA==
Message-ID: <sashiko-outbox-198319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/9] PCI: dw-rockchip: Add helper function for DDL
 indicator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v8-6-0434b4f373bc@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v8-6-0434b4f373bc@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:54:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] PCI: dw-rockchip: rockchip_pcie_unmask_dll_indicator() naming and s=
ingle use
--

commit 02422c1fdad3696875f51d4d19c596b663cc9a6c
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

PCI: dw-rockchip: Add helper function for DDL indicator

This commit extracts the PCIE_CLIENT_INTR_MASK_MISC register write in
rockchip_pcie_configure_ep() into a new rockchip_pcie_unmask_dll_indicator()
helper function.

>     PCI: dw-rockchip: Add helper function for DDL indicator
>    =20
>     Remove code duplication and improve readability by introducing a new
>     function to setup the DLL indicator.
>    =20
>     Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>     Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index c6a4649dae2e8..0e26abc509205 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -700,6 +700,16 @@ static void rockchip_pcie_set_controller_mode(struct=
 rockchip_pcie *rockchip, u3
>  	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_SET_MODE(mode), PCIE_CLI=
ENT_GENERAL_CON);
>  }
> =20
> +static void rockchip_pcie_unmask_dll_indicator(struct rockchip_pcie *roc=
kchip)
> +{
> +	u32 val;
> +
> +	/* unmask DLL up/down indicator and hot reset/link-down reset */
> +	val =3D FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0) |
> +	      FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
> +}
> +
>  static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>  				      struct rockchip_pcie *rockchip)
>  {
> @@ -760,7 +770,6 @@ static int rockchip_pcie_configure_ep(struct platform=
_device *pdev,
>  {
>  	struct device *dev =3D &pdev->dev;
>  	int irq, ret;
> -	u32 val;
> =20
>  	if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_EP))
>  		return -ENODEV;
> @@ -800,10 +809,7 @@ static int rockchip_pcie_configure_ep(struct platfor=
m_device *pdev,
> =20
>  	pci_epc_init_notify(rockchip->pci.ep.epc);
> =20
> -	/* unmask DLL up/down indicator and hot reset/link-down reset */
> -	val =3D FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0) |
> -	      FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
> -	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
> +	rockchip_pcie_unmask_dll_indicator(rockchip);

[Severity: Low]
This isn't a bug, but is the commit message description and helper naming
accurate here?

First, there is a typo in the commit subject ("DDL" instead of "DLL").

Second, the commit message states that this change removes code duplication,
but rockchip_pcie_configure_ep() in
drivers/pci/controller/dwc/pcie-dw-rockchip.c is the only caller of
rockchip_pcie_unmask_dll_indicator().

Third, rockchip_pcie_unmask_dll_indicator() unmasks both the DLL up/down
indicator (PCIE_RDLH_LINK_UP_CHGED) and the hot reset/link-down reset
interrupt (PCIE_LINK_REQ_RST_NOT_INT) in PCIE_CLIENT_INTR_MASK_MISC, which =
is
not reflected in the helper's name.

Meanwhile, rockchip_pcie_configure_rc() and
rockchip_pcie_rc_reset_root_port() both open-code the write to
PCIE_CLIENT_INTR_MASK_MISC to unmask PCIE_LINK_REQ_RST_NOT_INT:

	/* unmask hot reset/link-down reset */
	val =3D FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);

Could this helper be parameterized (similar to
rockchip_pcie_enable_enhanced_ltssm_control_mode()) and named to reflect
unmasking miscellaneous interrupts so that the RC paths can also use it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-rockchip-p=
cie-system-suspend-v8-0-0434b4f373bc@collabora.com?part=3D6
