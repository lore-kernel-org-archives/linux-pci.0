Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D269475809
	for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787998080; cv=none; b=aEfvwYE1/VVumaNGzcVGBsIHTiZOv531gBFrUtPnbtVmeI4iWsgQis/f2qRAvtW8ojfKbd+VXxjLvt7hkpEeNjW/vJqCt3PS+TV/HICjh5C8u4GmyChqtr+6VNvJ/Qf8vupI9+6Svk0ZNCRf0Wvx5304r53ETYjSFSvdZrkzhnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787998080; c=relaxed/simple;
	bh=LLTSFd+w0UPp9Dfk2APXMg1eZw7QQSL6UdeivK0Cd7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NhVBcE8VRQGBxZo2tFrdSy0UWNV9L0ouni/KMkv6x9nRgVZrdCfORTHc6NSRreeoUQYX01P7xDNbO+Y+L9oFwMt/nV+fupefPYM0BF+Lhx944IYMBmgkMMFjpn3CO2WQBVGMmA9UAIpsRjHMH4txJURKODf1xMBMJ0ioS3c4mlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQlKe/Mq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQlKe/Mq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8491F000E9;
	Sat, 29 Aug 2026 10:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787998078;
	bh=atQRVC8ksjgAwnfsH1Mq1rpfx8h3COScWil2muj3A2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hQlKe/MqmYQzfYZxelbIuKVZtlNwI3dezbmO+k/RF47ISt9wRUrxHuyveT/rLgVYV
	 5BBDjbhug/p8PFuK21f9Tww7xv0hl19KYMLRI085yXauplBi2wHvyLA59w+5rcZQ2J
	 LaoYoCAhAuhIxyrmmOi3Sqn+rxgQgdLjFGhfdCbRH/0rxeyjWTmGR5TWMZEe75CX+C
	 aoieYYNSgXN1aVKkjkgDpi71qE3RjSYKAJ/K3gXLHT19LoiG0cpBsE/GYkjpBZ1SHv
	 4NVc5e7kVp9/p7k6kR6jPPeAR8YdP7kAyOFJ6ib8Lpg52i2fmJNDC1L50v4GaPu9lo
	 HLi17ady+CiIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH wireless 1/2] wifi: iwlwifi: pcie: arm the product reset
 at probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Navon John Lukose" <navonjohnlukose@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260829095437.44716-2-navonjohnlukose@gmail.com>
References: <20260829095437.44716-1-navonjohnlukose@gmail.com>
 <20260829095437.44716-2-navonjohnlukose@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 10:07:58 +0000
Message-Id: <20260829100758.8E8491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Silent disarm failure unintentionally upgrades a function reset to=
 a product reset, causing an unhandled surprise removal of the Bluetooth de=
vice and bypassing ME protections.
- [Medium] Unconditional error log emitted during probe on platforms lackin=
g the product reset _DSM.
--

commit 6aff245a17463ae76f40a95a671116d6cd174711
Author: Navon John Lukose <navonjohnlukose@gmail.com>

wifi: iwlwifi: pcie: arm the product reset at probe

This patch arms the platform-level product reset via ACPI _DSM unconditiona=
lly
during probe instead of device teardown. This is intended to fix recovery
failures on laptops where the device loses power and cannot respond to the
_DSM when the reset is requested later.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221695

> Arm it during probe instead, while the device still answers. The mode is
> sticky in the platform's namespace, so it is still set when the device
> later disappears. _RST is only evaluated when the driver actually asks
> for a reset, and a subsequent non-product reset re-runs the existing
> disarm path as before. On platforms with no such _DSM this is a no-op.

[Severity: Medium]
Will this actually be a no-op on platforms without the _DSM?

Looking at iwl_trans_pcie_set_product_reset(), if the _DSM fails and enable=
 is
true, it prints an error:

	if (IS_ERR(res)) {
		if (enable)
			IWL_ERR_DEV(&pdev->dev,
				    "ACPI _DSM not available (%d), cannot do product reset\n",
				    (int)PTR_ERR(res));
		return;
	}

Because this is now called unconditionally during probe with enable=3Dtrue,=
 won't
this spam dmesg with an error on every boot for unsupported platforms?

> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/dri=
vers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
> index 28b276c659526..a932e068cd0a5 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
> @@ -4252,6 +4252,11 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
>  	iwl_trans_pcie_check_product_reset_status(pdev);
>  	iwl_trans_pcie_check_product_reset_mode(pdev);
> =20
> +	/* must be armed while the device still answers: the _DSM is gated on
> +	 * reading its PCI ID out of config space
> +	 */
> +	iwl_trans_pcie_set_product_reset(pdev, true, mac_cfg->integrated);

[Severity: High]
Does arming the sticky reset here unintentionally upgrade future function r=
esets
to product resets if the device is lost?

If the device falls off the bus (e.g. D3cold), the driver requests a reset.
If Intel ME is present, iwl_trans_pcie_reset() forcibly downgrades a PROD_R=
ESET
to a FUNC_RESET.

When iwl_trans_pcie_removal_wk() later tries to disarm the reset:

	iwl_trans_pcie_set_product_reset(pdev,
					 removal->mode =3D=3D
						IWL_RESET_MODE_PROD_RESET,
					 removal->integrated);

The _DSM call will fail because the device is inaccessible.
iwl_trans_pcie_set_product_reset() ignores this failure silently when
enable=3Dfalse.

Then the worker proceeds to call _RST:

	if (removal->mode >=3D IWL_RESET_MODE_FUNC_RESET)
		iwl_trans_pcie_call_reset(pdev);

Because the disarm failed, the sticky product reset armed here at probe is
still active. Won't this cause the platform to execute an unexpected product
reset, skipping the companion Bluetooth device teardown and bypassing ME
protections?

> +
>  	/* set the things we know so far for the grab NIC access */
>  	iwl_trans_set_info(iwl_trans, &info);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829095437.4471=
6-1-navonjohnlukose@gmail.com?part=3D1
