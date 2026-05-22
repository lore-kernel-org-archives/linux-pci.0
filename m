Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883633A6F2
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486714; cv=none; b=WA1CqneBkQqESelXYjrTHiiwgK5k9IQrbCxYZGf7y6dRKq9cQSnuffrETcyH105e3UQWqm0BGafsyn91Vpovl1tAlb3vSOGX9Hyg4EF5l2rrsMNBvxsISISzIS3pDosT5+ZX8oX5cG3l34zlvCJa5yfhtLvX1RH/6z3Z8ils6gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486714; c=relaxed/simple;
	bh=rnUdWXevyDKqMEbxQCT8+WkOpecXXlef+JtIDVEwAaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cz7LjrMVw/TrJx4Q1I/LW+tCU05pZECbhvU8B6l9WqTLm6RhYXX5C7afE1zYJQ/6hx1E+eb75Th2uXxHfqhdCvwXPmK9VgzswMkAsulLARgob3p+VNj53T/hzAtcwMfqZcXfJE79dVzqq97wKnFk0FatWkouQWjNw97MWnViL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjsMr96l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjsMr96l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3B61F000E9;
	Fri, 22 May 2026 21:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779486712;
	bh=g3cNdeWfpXN/lwITZZNw+38KwCl80lp6Tt97392mQW0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PjsMr96lAEcxv7bG8FXJPxMB4FJs4x5/Y7/6M1DHb5kSR54CD0p65d/O/EnnCrk7+
	 mHsmwp0bs7UORJe/X5fejH5pMtplUzg0CbliMcD4f94Vd4eZOXwaz6eROJRG3yRI9Q
	 9RohB/N6ur0OGKPV7IxIBcxn3cUh0ciDpkNqLLZncPpUEZgOLMQy0voPVSqQNGhN7O
	 mn1UUUE8j+uBc6y3qs4zYWy/qMVU6gqvCPPyBeeoXJiAXNDNJEpzSxD8WQxvM5qh/G
	 kYn1/UplPSELINj34vxcNH0P5lTJyM95334T6yRfI6O2vCEqsINJW+8qNEFsfAksoB
	 wi/D1Y+AxFOSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260522202410.3104264-10-dmatlack@google.com>
References: <20260522202410.3104264-10-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 21:51:52 +0000
Message-Id: <20260522215152.9B3B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Bitfield data race when updating `ari_enabled` on a shared bridge =
device.
--

commit 9819403e762e1d3e8a471294f5aa07554019d8b4
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Inherit ARI Forwarding Enable on preserved bridges
   =20
Inherit the ARI Forwarding Enable on preserved bridges and update
pci_dev->ari_enabled accordingly during a Live Update. This ensures that
the preserved devices on the bridge's secondary bus can be identified
with the same expanded 8-bit function number after a Live Update.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index a93b7ef065f28..701276ef6cfbd 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
[ ... ]
> @@ -756,6 +760,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
>  	return 0;
>  }
> =20
> +int pci_liveupdate_configure_ari(struct pci_dev *dev)
> +{
> +	u16 val;
> +
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +
> +	if (!dev->liveupdate.incoming)
> +		return -EINVAL;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
> +	dev->ari_enabled =3D !!(val & PCI_EXP_DEVCTL2_ARI);

[Severity: High]
This isn't a bug introduced by this patch, but could this bitfield update
cause a data race on the shared bridge device?

Since C bitfield updates are not atomic, modifying dev->ari_enabled compiles
down to a read-modify-write of the entire surrounding machine word.

If another thread concurrently modifies adjacent bitfields on the same brid=
ge
device (for example, if the pcieport driver is unbound from the bridge via
sysfs, invoking pci_disable_msi() and pci_clear_master() to update
msi_enabled and is_busmaster), couldn't one of the updates be lost?

Since pci_setup_device(), which calls pci_configure_ari(), does not hold
device_lock(bridge), these paths can execute concurrently. This might
corrupt the bridge's state by silently dropping updates like MSI enablement,
potentially leading to interrupt routing failures or crashes.

The new code appears to duplicate this unprotected modification pattern from
the preexisting fallback path in pci_configure_ari().

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522202410.3104=
264-1-dmatlack@google.com?part=3D9
