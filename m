Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14A224AF7
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 02:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778726238; cv=none; b=Ms4DvF7B3UzCZGCNU6FK0nUrNtWCrYhSqQQe2OenvjZZ6kI6hCEpgwrUAUkAT3WbCS6idO/+5ju9I+lMp3Y9La1jPZvJJZehRG3lP3U9NQ3MbMKuftNTb2H2hpY/b5Byq7wPCTgIDHmSoXKzaVRUCbvDNWwVZIYe0DcW8GcNgEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778726238; c=relaxed/simple;
	bh=UUTsAFi2ak7FDQDqU4zuSHShmx5kv5hdg/1oA3+hfcU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l40YAwHtzDPf6pgji8FAYJjltbA+fXZw43kaxPlV5N75nXJ3oO5zRaALSJQmHybICFa6WxCFuut2WxoAiP7Ze+vPx3NjK+IK08SvHz05OEaxGYZFkRRuupD4SMwtJS+GYH73DyHXLwqywEjLuJUN/xsu7oOo9wHdcL5ZAe+YFv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCxHJ3uz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCxHJ3uz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7A4C19425;
	Thu, 14 May 2026 02:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778726238;
	bh=UUTsAFi2ak7FDQDqU4zuSHShmx5kv5hdg/1oA3+hfcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jCxHJ3uzs/+b6VpsVh30Mepubtpo2xRdr4ba1Dz2BNWJJNj4uXX2LOyhPim0X0B0M
	 a23jm4Mof813eyQIVC8wJF8ec5sOxoCzDKnkkcjebp5Sn0n/0S3Po4VBYV0Cbq2blP
	 rY4FkUFZLxrUvnpfrCSAHRDndydtsQdgQQQnsmxdA/zgK+xr/iUi4Sbwg3c7RjVWJm
	 ss+NJPJbHwnmSHzfcTyC8n9goCdwWO+CcfEoHl1s9M7lRb/D9cWuogvMhCiyBacVqC
	 mTsKraE97jpzpJaEkjW5AX3gxx1PLRyn0pVlm837kavZm1MFavjY7u84wLyEDf5Vyi
	 /QPIit+gbXTow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/11] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260512184846.119396-8-dmatlack@google.com>
References: <20260512184846.119396-8-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 02:37:17 +0000
Message-Id: <20260514023718.1A7A4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Modifying pci_dev state while holding only a read lock in pci_live=
update_init_acs().
- [High] Intel SPT PCH root ports bypass the ACS quirk rejection check, cau=
sing their custom ACS control registers to be permanently lost on the new k=
ernel.
--

commit 9befbb904977419650ee202e0854fc1452e0a9de
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Inherit ACS flags in incoming preserved devices

This commit updates the live update process to inherit Access Control
Services (ACS) flags on incoming preserved devices. It caches the
inherited ACS controls established by the previous kernel so they do
not change after a reset.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index d8e06afde2c76..e3cd6d76636c3 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
[ ... ]
> @@ -361,6 +373,16 @@ static int pci_liveupdate_preserve_device_new(struct=
 pci_ser *ser, struct pci_de
>  {
>  	int i;
> =20
> +	/*
> +	 * Do not preserve a devices that rely on device-specific ACS
> +	 * equivalents (for now) since that would complicate keeping ACS
> +	 * flags constant across Live Update.
> +	 */
> +	if (dev->dev_flags & PCI_DEV_FLAGS_ACS_ENABLED_QUIRK) {
> +		pci_warn(dev, "Refusing to preserve device that relies on ACS quirks\n=
");
> +		return -EINVAL;
> +	}

Can Intel SPT PCH root ports bypass this check?

Looking at pci_quirk_enable_intel_spt_pch_acs(), it does not appear to set
the PCI_DEV_FLAGS_ACS_ENABLED_QUIRK flag.

If these ports bypass the check and are preserved, pci_liveupdate_init_acs()
will only cache the standard PCI_ACS_CTRL register, ignoring the
device-specific INTEL_SPT_ACS_CTRL register.

When the new kernel calls pci_enable_acs(), pci_liveupdate_inherit_acs()
will restore the standard register and return true, skipping the
pci_dev_specific_enable_acs() path entirely.

Will this cause a regression where the custom ACS configuration is lost?

[ ... ]
> @@ -671,6 +694,32 @@ void pci_liveupdate_finish(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
> =20
> +void pci_liveupdate_init_acs(struct pci_dev *dev)
> +{
> +	guard(read_lock)(&dev->liveupdate.lock);
> +
> +	if (!dev->acs_cap || !dev->liveupdate.incoming)
> +		return;
> +
> +	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate=
.acs_ctrl);
> +}

Does this mutate dev->liveupdate.acs_ctrl while holding a read lock?

Since pci_read_config_word() writes the read value into the acs_ctrl
pointer, should this use write_lock to avoid a data race regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512184846.1193=
96-1-dmatlack@google.com?part=3D7
