Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289878;
	b=Wup02Bi+QF6ERZ7OuHgrh/cxL2twQe6SMjMaO3Nb8W4nX4PNxVwv/Vr5UycR1jgXueMU
	 Pl/KBmWk+NFmk4W0GyEa22Eu7WyT/xxCNRcIdrs4vhS+q+ReOV94tSRVJ0dFYyx39MHcJ
	 u8wuHCOq3GwYezEbrrg+lVQJzGUKlobl7D6IrWWdiw27ztgNdgv3VT0lRO95O+ZQ8spnT
	 HhH8T8DiPG4vU2/zpAeTcU6Uza4xE3eCbNyqA/07VaYmMZOLQ2PWELLdtulz/xT5PF3qT
	 3J2tIy9N61sPiiLk/r9Le1iL7kSbsO04fr5wn/mQNpN8VrmKj4V5Ym5X7I2cuxtb18Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289878;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OpP5QE1yeBN3iHsPWElCKFy1h8VvrnPG/XKbO3GHc7o=;
	b=jSbpOmWQRB+gDWcKriWQsZiutGgcuY1MAfR+5e43+QugjP//DwjeGWwOTe0tAua45m0f
	 n/ElpeEiDFxPvQTvDmDM+lRfyMC2qic4GtbHw9OvwUWA1J1TGb2tYV5bY81E76ahSi2sd
	 dMSZwMLctghyn1aA0spGmUOuJAzmIt3OTQX5l+IjiU3R1P0TN5tSetMtFxjPyn9+jg3Xg
	 T+HMOCIPVeLPVNrwjifLUdWQ4qioFE+P+Bmn32pX3yK/gVidJWbVlIzUauWc9j4pui8QN
	 9Wqqqi24DVoX7H2Eoj3y/3LExDpuVGdzY1QU6uSB+VHwVJOtNhzLBpxe7axBNkzLf1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCqfjSWP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D1606A333
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCqfjSWP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730971F0089F;
	Tue, 10 Nov 2026 05:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794289877;
	bh=OpP5QE1yeBN3iHsPWElCKFy1h8VvrnPG/XKbO3GHc7o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UCqfjSWP+RvJylpYO2nOuvoKcWo0NyA2tvOZh74WkwD/7kEl3IEYn5zdWWJURp7CO
	 rxI2uU/BFEE6r4IZz2kZb/b+jVh6u4kTmF6vxzV0dzTeH4CZTZdGeWf6bwvS15kEfx
	 7wcrx8IUJsW7IUx9uVX2xxYBM3xrrZKiXP4oB0xyzofdbZ+/1xowVoZ4FFT3z5Wam8
	 v7u+yp//K2UW5hcAboiUGxkElGH0YsGnMT4XfDTIrifpQP1lf88iodGJmQr7X1cvX1
	 dEAkh78VMbog0lu9W6zdH2l9DN0JEQOqjllEf4DJbQYuZ99fe8TckKajFYJ24T/mWZ
	 tI8QlY5FMbQig==
Message-ID: <sashiko-outbox-206347@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Only restore state that was successfully saved
 around a reset
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261110053348.2419-1-lirongqing@baidu.com>
References: <20261110053348.2419-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:51:17 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] PCI: pci_dev_restore() skips restoring preserved state after
  error reset
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] PCI: capability buffer corruption on disconnect in
  pci_save_state() [1]
--

commit 101ae1e1e66a05607699c91780a5db7e8edbbdc0
Author: Li RongQing <lirongqing@baidu.com>

PCI: Only restore state that was successfully saved around a reset

This commit clears dev->state_saved when pci_dev_save_and_disable() skips
saving inaccessible config space and checks dev->state_saved before calling
pci_restore_state() in pci_dev_restore().

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d6590805faeb2..2327f47f3fda5 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5309,8 +5309,10 @@ static void pci_dev_save_and_disable(struct pci_de=
v *dev)
>  	 */
>  	pci_set_power_state(dev, PCI_D0);
> =20
> -	if (!pci_dev_config_accessible(dev, "save state"))
> +	if (!pci_dev_config_accessible(dev, "save state")) {
> +		dev->state_saved =3D false;
>  		return;
> +	}
> =20
>  	pci_save_state(dev);

[Severity: High]
This problem wasn't introduced by this patch, but can pci_save_state()
corrupt the saved PCIe capability state [1] if the device becomes
inaccessible mid-save?

pci_save_state() sets dev->state_saved to true and calls
pci_save_pcie_state(), which reads capability registers into
save_state->cap.data without checking for errors:

drivers/pci/pci.c:pci_save_pcie_state() {
    ...
	cap =3D (u16 *)&save_state->cap.data[0];
	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &cap[i++]);
	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[i++]);
	pcie_capability_read_word(dev, PCI_EXP_SLTCTL, &cap[i++]);
    ...
}

If the device disconnects during this window, these reads store ~0 (or 0 on
explicit read failure) into the persistent save buffer, and
pci_restore_state() later writes those corrupted values back to registers
such as PCI_EXP_DEVCTL.

[ ... ]

> @@ -5328,7 +5330,8 @@ static void pci_dev_restore(struct pci_dev *dev)
>  	const struct pci_error_handlers *err_handler =3D
>  			dev->driver ? dev->driver->err_handler : NULL;
> =20
> -	pci_restore_state(dev);
> +	if (dev->state_saved)
> +		pci_restore_state(dev);

[Severity: High]
Does skipping pci_restore_state() here introduce a regression that leaves
the device unconfigured after a reset recovers it from an error?

Commit a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all times")
saves the initial config space in pci_bus_add_device() and removed the
dev->state_saved check from pci_restore_state() so a valid baseline state
is always available even after a prior restore cleared dev->state_saved.

Commit e18d1abc3bff ("PCI: Avoid saving config space state if inaccessible")
then skipped pci_save_state() in pci_dev_save_and_disable() when config
space is inaccessible (such as during DPC) to avoid overwriting that
preserved state with ~0 before the reset.

Since the hardware reset clears the device's registers back to power-on
defaults, clearing dev->state_saved and skipping pci_restore_state() leaves
BARs, PCI_COMMAND, capabilities, and bridge bus numbers unprogrammed once
the reset makes config space accessible again.

[1] https://sashiko.dev/#/bug/linux-60bae679-5c85-4c49-8042-6817f9cb5c8f

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110053348.2419=
-1-lirongqing@baidu.com?part=3D1
