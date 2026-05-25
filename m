Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6B6481B1
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712941; cv=none; b=RIyQGWD3nlj4G4J9bGIFOX3dmxT3kLWH5ew4MIPP56fRiRqPx9LX1P3KP6zPGnptGndpNKlmlQmxYNg8FhayTr6Mzyj8WMi2r5BW+3QZzyIFGyuK9aHraoHHCkA8xaOdQxSwLCwHrW1PpK2v58SsPfVSJo/um2dFCW+psFAxvG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712941; c=relaxed/simple;
	bh=PerRx1HTBRvnusNHpUFdrmUgsmAUTW7eMRG6ER3bR44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ErqtK6j9kahdkvwVCGi0PNRz8l1zy7eyrJ0dq+g+X0/tdfPBib7P2KI0w2o29rLi9yu+8oySS49VpnK9HUOT26hw+Mks1WyA9Mq6zFO4gKU7q/h+cyVL09Pjd9hA9nvUP+wilHKX+IhrrqkaIB7P3T6tHfUiDzbd+16W8VSFojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrK5U9Uq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrK5U9Uq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52F61F000E9;
	Mon, 25 May 2026 12:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779712939;
	bh=0jh6Pvnp2/zXhj4TQKhd2ZbNRFpN+JeFpxTtMxQ8fSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PrK5U9UquWNM70jr6iVo5kjotDCMQzN/YgDcJ6VvwR7WOgcnRYB7pJVLma9Vzv70J
	 nFbHjQmKV0g3oPfU1YdEEYxeT6QX6BncnIX9NmVU/MOMD8/Ww/HedG6F9bQpJwO0CF
	 /o57H/xfp5Dc3J0U6ncZEA0RMGaf6VAz8int823R6CGelr+Pmm7p0eSYs5nQKYg0DK
	 PEIjDwVsaeuK3VZjTGpDCguTNadCWG/6xyZwq/Yi1KVPSSLw/WAJYvLELe6pYXfQi4
	 Qj+ZeTlUfkOwHBWZFyyXklxUyMRkxVlrJbpFOSwMkQg734F7ur1OIhXmD2pZfNEcQ8
	 Jge9864diYBJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ppc/pnv: Fix null pointer deref in pci hotplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Gupta" <adityag@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260525121628.3906457-1-adityag@linux.ibm.com>
References: <20260525121628.3906457-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 12:42:19 +0000
Message-Id: <20260525124219.C52F61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unmasked NULL pointer dereferences of `php_slot->pdev` across =
the driver.
--

commit 1c56f7131028dfbaf43301e91e93ecbdba6f09eb
Author: Aditya Gupta <adityag@linux.ibm.com>

ppc/pnv: Fix null pointer deref in pci hotplug

This commit fixes a NULL pointer dereference in pnv_php_get_adapter_state()
for hotplug slots on root buses (like OpenCAPI) where bus->self is NULL.
It adds a check to ensure php_slot->pdev is not NULL before checking the
PCIe type.

> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index ff92a5c301b81..21ce7ead9e19b 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -414,7 +414,8 @@ static int pnv_php_get_adapter_state(struct hotplug_s=
lot *slot, u8 *state)
>  	 */
>  	ret =3D pnv_pci_get_presence_state(php_slot->id, &presence);
>  	if (ret >=3D 0) {
> -		if (pci_pcie_type(php_slot->pdev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM &&
> +		if (php_slot->pdev &&
> +			pci_pcie_type(php_slot->pdev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM &&
>  			presence =3D=3D OPAL_PCI_SLOT_EMPTY) {

[Severity: Critical]
This isn't a bug introduced by this patch, but by allowing initialization to
proceed for root bus slots where php_slot->pdev is NULL, does this expose
other unmasked NULL pointer dereferences across the driver?

For example, reading the world-readable /sys/bus/pci/slots/*/attention sysfs
file calls pnv_php_get_attention_state() and pnv_php_get_raw_indicator_stat=
us()
with a NULL pdev:

pnv_php_get_attention_state()
  pnv_php_get_raw_indicator_status()
    pcie_capability_read_word()
      pcie_capability_reg_implemented()
        pci_is_pcie()
          pci_pcie_cap()
           =20
This unconditionally dereferences the NULL pointer, potentially allowing an
unprivileged local user to crash the kernel.

Similarly, pnv_php_detect_clear_suprise_removal_freeze() passes the NULL
pdev to pci_dev_to_eeh_dev(), which dereferences pdev->dev.archdata.edev
and crashes on hot-unplug events.=20

There also appear to be unprotected usages in pnv_php_enable_irq() which=20
calls pci_dev_msi_enabled(pdev), and in pnv_php_activate_slot() which passes
the NULL pdev to pci_set_pcie_reset_state().

Are additional NULL checks needed for these other php_slot->pdev usages
now that the initial boot crash is bypassed?

>  			/*
>  			 * Similar to pciehp_hpc, check whether the Link Active

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525121628.3906=
457-1-adityag@linux.ibm.com?part=3D1
