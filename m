Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6F037EFE9
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140805; cv=none; b=exQoNetq9HOryqH5xwACY34hWj/0kW/8iQUvvDUnUcCvxImeLa8daGxAzqkY4T3WFS2XbWdoEk06ji4QKRckEuZkaTrVsP97WnJx5x/GtBj/aD7k6xQnWvDQNBgiHFdjlUIFhuBjQDR1V2V9rJpx5DLrW5SxUFJG3ipJHL5DbPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140805; c=relaxed/simple;
	bh=2sdcOrpVOtgCmnA1ifJT86GNPYBGpN3WZxX/hEB7aZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X6WPkrFjq4qsPlXFELuPhaTfq3MQtZse/W1uXAy5prupbUh8GIjsjfOzAt7KOV20L/MpuxS4X2Y6YCiRgbmMsfghRc6h6wXP3A20cBMK3r8mlNK+fB7MG5hFZdRZDHfqg9kXv3L9/dRCqCzR9D6/nvzaXiaLYVSMfuBUOOioUJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdWJNOdu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdWJNOdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE22C2BCC7;
	Thu,  7 May 2026 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778140804;
	bh=2sdcOrpVOtgCmnA1ifJT86GNPYBGpN3WZxX/hEB7aZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jdWJNOduZSi8llRb+VyIBtZGJ4BYlhs1Qsb5U1OVLGZ5sQ4DGwwpMFRk4h9aiwXuE
	 QZ5PH6BOmZmKQpUlZqa2Nwjqn9Xp57GK/cRtIfccWcCx9vyoIzKrztafi+5KywFViu
	 4RiuQJ/gStQcQGI9yG1Guy58EKR1aYaItlSBgJ28fW7nou6dnX/ynQAFCL6V/Ae/Kr
	 e2TK50DwHfiP9iU5jdZOK0IEIPEIepSnasQTS/A3QByc5GymxuN8UAAaAXqS11MDJs
	 rIpHjz3o9U7edROmrYXDe9dY+7DjenrqDAy80TWXhyKRTAIHiWev+tdhs1it8Utucz
	 bR5zt05uBvseg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 phy-next 16/31] usb: host: tegra: avoid direct
 dereference of phy->dev.of_node
Reply-To: sashiko@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260505100523.1922388-17-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-17-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 08:00:04 +0000
Message-Id: <20260507080004.AEE22C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] This problem wasn't introduced by this patch, but a single `struct=
 notifier_block` instance (`tegra->id_nb`) is registered to multiple USB PH=
Y instances in a loop, causing linked list corruption.
- [High] This problem wasn't introduced by this patch, but the devm-managed=
 USB PHY notifier unregistration happens after driver remove, allowing `teg=
ra->id_work` to be scheduled after it is canceled.
--

commit dc45b6840f6afd2c371e491c07e3f59d5e2f3937
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

usb: host: tegra: avoid direct dereference of phy->dev.of_node

This commit modifies the Tegra XHCI driver to use a parallel lookup path
using the 'phys' phandle to obtain the OF node, avoiding direct
dereferencing of phy->dev.of_node as the generic PHY subsystem moves to
opaque pointers.

> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index d2214d309e965..6724a777ca2ac 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -1504,23 +1505,34 @@ static int tegra_xusb_init_usb_phy(struct tegra_x=
usb *tegra)
>  	tegra->otg_usb3_port =3D -EINVAL;
> =20
>  	for (i =3D 0; i < tegra->num_usb_phys; i++) {

[ ... ]

> +		err =3D of_parse_phandle_with_args(np, "phys", "#phy-cells",
> +						 index, &args);
> +		if (err)
> +			continue;
> +
> +		usbphy =3D devm_usb_get_phy_by_node(tegra->dev, args.np,
> +						  &tegra->id_nb);

This problem wasn't introduced by this patch, but does passing the same
&tegra->id_nb instance to multiple USB PHYs in this loop cause a linked list
corruption?

A struct notifier_block has a single next pointer used to maintain the link=
ed
list. Registering the exact same block to multiple different PHY notifier
chains simultaneously could overwrite its next pointer, cross-linking and
corrupting the notifier lists.

Additionally, is there a risk of a use-after-free during driver removal due
to how this notifier is managed?

Because devm_usb_get_phy_by_node() uses devres to manage the PHY and its
notifier block, devres cleanup (which unregisters the notifier) runs after
the driver's remove() function returns.

If the notifier callback tegra_xhci_id_notify() schedules tegra->id_work,
could a hardware event fire after cancel_work_sync(&tegra->id_work) is
called in remove(), but before devres unregisters the notifier?

If so, the still-registered callback might execute and re-queue
tegra->id_work on freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505100523.1922=
388-1-vladimir.oltean@nxp.com?part=3D16
