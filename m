Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE1415B8F
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182414; cv=none; b=VW+qnHcYuWYUz2FvgcDO13rc5RZ8b2zBs6eEBoVxA40FN3DJ8aE7hNQ5Yw2xRdSH71cGflmjYCdddsi4j4quKab4m7gBJ3yxaS+ymthVPGJBr0rPs+u21pUFKJIWUXJ5UgooSyFJ5ZU8PBOXvnJcVjihHUJg8/SSws+pG4YnPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182414; c=relaxed/simple;
	bh=LaojJ32GsjqQkRHF0jeYrEp1qgphXJKDYRE0Nzu3qqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dpIKICGLOprzEnUt+GalUzq27frgckMo+PSG0gKkQbi3C9GfMGo5tGD7NwW1H0E8Sar5JWu1G6vRdOzRhiPQmavdEfiz+JdhEoeUhqnbjEtk6dkdqh74NvvednBL0hlUjwi+k4YEZh8V5qrhFbpAnIZOlZY2RO8lzh8RjN5OZ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMtIicIY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMtIicIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC41B1F000E9;
	Mon, 31 Aug 2026 13:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182410;
	bh=9yCTbr33BMxB/TPHFTYdCn118pWrbJ+9EqXcw9+9J7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WMtIicIYdNG+V5y101GEa2LIpZJiMbKiOXM0cbCutB1mOgF52enoJgOGqQpEdwdRd
	 TuxaKBdKlEcX1UX8l4qZnCF6o6uNZy1YlyMrL9QqRfS4nNCZxpR7PaFfcqD0pbQrY+
	 OcgCV/5CVxoLJkYMzW76G1oGqUhbI7J+Dj8yLZyA1X5sMVrVvdX+0wniLS5VqImzAh
	 +oILYKUraCA+wv+RSVVXq62VVH++g9iG9RBrO/fM7jfwFu59mb8RyWHhbKyqSTyAAv
	 9AKJM/I5KG3GYdiJOUlF+f271nORQg67G6O2jrbIbJLb1iq6wVWYXKuGlmYDFo52+X
	 C4/9oEgusT71Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH wireless v2 3/3] wifi: iwlwifi: pcie: recover a device
 that lost power in D3cold
Reply-To: sashiko-reviews@lists.linux.dev
To: "Navon John Lukose" <navonjohnlukose@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831130332.323549-4-navonjohnlukose@gmail.com>
References: <20260831130332.323549-1-navonjohnlukose@gmail.com>
 <20260831130332.323549-4-navonjohnlukose@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:20:10 +0000
Message-Id: <20260831132010.AC41B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Time-of-check to time-of-use (TOCTOU) race condition when checking=
 and setting STATUS_TRANS_DEAD in iwl_trans_pcie_reset.
--

commit 6f5f8c9b1441f8d8ad9817104244243beaa97d1d
Author: Navon John Lukose <navonjohnlukose@gmail.com>

wifi: iwlwifi: pcie: recover a device that lost power in D3cold
   =20
This commit recovers discrete modules that lose power in D3cold by arming a
product reset via DSM during suspend. If the device does not respond upon
resume, it falls back to a software reset via iwl_trans_pcie_reset().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221695
Link: https://lore.kernel.org/all/20260722021321.68902-1-nika@nikableh.moe/
Link: https://lore.kernel.org/all/20260829093922.37103-1-navonjohnlukose@gm=
ail.com/

> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/=
wireless/intel/iwlwifi/pcie/drv.c
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> @@ -1229,6 +1237,22 @@ static int _iwl_pci_resume(struct device *device, =
bool restore)

[ ... ]

> +	if (trans_pcie->prod_reset_set) {
> +		iwl_trans_pcie_arm_product_reset(trans, false);
> +		if (trans_pcie->prod_reset_set &&
> +		    iwl_read32(trans, CSR_HW_REV) =3D=3D ~0U) {
> +			IWL_ERR(trans, "device not responding after resume\n");
> +			iwl_trans_pcie_reset(trans, IWL_RESET_MODE_PROD_RESET);

[Severity: High]
This is a pre-existing issue, but can this new call to iwl_trans_pcie_reset=
()
trigger a time-of-check to time-of-use (TOCTOU) race condition with concurr=
ent
callers?

Looking at iwl_trans_pcie_reset() in
drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c, the function checks
the STATUS_TRANS_DEAD bit:

    if (test_bit(STATUS_TRANS_DEAD, &trans->status))
        return;

Then there is a wide window involving memory allocation and CSR dumps before
the bit is actually set:

    set_bit(STATUS_TRANS_DEAD, &trans->status);

If this resume path executes concurrently with another error handler (like =
an
interrupt or timer), both threads could pass the test_bit() check before
either sets it.

Could this result in two iwl_trans_pcie_removal_wk work items being queued
for the same device?

The first worker would remove the device, free its state, and rescan the bu=
s,
creating a new pdev and driver instance. The second worker would then opera=
te
on the old pdev reference, potentially calling pci_reset_function() which
issues a hardware FLR and restores the old PCI config state over the new
driver's device.

> +			return 0;
> +		}
> +		trans_pcie->prod_reset_set =3D false;
> +	}
> +
>  	if (!trans->op_mode)
>  		return 0;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831130332.3235=
49-1-navonjohnlukose@gmail.com?part=3D3
