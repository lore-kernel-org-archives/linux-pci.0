Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724C879DA
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544443; cv=none; b=n0g4XoaLjua8jlXFpip7OP+ZOxk/cywVmysGaaf8Tj7mzZmBJ/rD25tAvkmx18Y36P5R85ANnTeFyQj2n32+iUngy/ySS0nZij4N+trcAAVNY286YlMxfG/HZZjk1YI9DCdS1j+JSEBXPqC2ELPhpm6olHQBWvnisO/EttrRxEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544443; c=relaxed/simple;
	bh=WmvyuxXgUXbFvjJTshPtt+34Y5A492fHxGIR4csUa+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qT/ecNPBuxqRlq9034WQcqRtjQyCHa92Escnw4oJVFK6+Ifu06lFYqQcLgW7RD/UY1u/R8/xtMRuSZ/o6KTyzHep9c54qM61T3OdIiC60T7JhAuJpoU0z2TZ0F3ph58E8aOH+GmsebzV6YU97lI+ozLm+QRlOL4OFlMd4nquL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEx30cNI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEx30cNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F382C2BCB0;
	Tue, 12 May 2026 00:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778544443;
	bh=WmvyuxXgUXbFvjJTshPtt+34Y5A492fHxGIR4csUa+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JEx30cNIyuh26FP8YnadkDlYeKi7kBeTH6Gd1/z0S5LukslnkR4H3qz6zbmJrWov2
	 Um9fYkb2y928UctwuZ49sbXZyfnNJVUGqjjcmj33XbmjD80+lDTjKV96socDXwzimI
	 gUWAaI8vPNYdrxWeuQFUFzRARCT93MGpnbrHOqYMLSmA4jgatCsqSbAq7KKgmzwbD8
	 vyu60vHP93z8N9r9UEsQg1RyskGVnoJI61uvSW5KgnKgWki9KZJF7cKKM8CZ2xH/jt
	 g+SNrogVbyXgMOlIZLZDjTYCsY/UH51YyMEAgjvQodbXMNcyCFukqzJFYR0W3AtIrm
	 evbrbvzuYSQeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] PCI: Add pci_host_common_link_train_delay()
 helper
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260511055923.37117-2-18255117159@163.com>
References: <20260511055923.37117-2-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 00:07:22 +0000
Message-Id: <20260512000723.2F382C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Negative error codes passed as `max_link_speed` silently bypass th=
e mandatory PCIe delay.
- [Medium] Architectural modularity violation by placing a generic PCIe hel=
per in an ECAM framework header.
- [Low] The helper API relies on raw integer values for link speed instead =
of the typed `enum pci_bus_speed`, creating a brittle interface.
--

commit 47720e87ef05a9f0115d64b2e2d6eaa190242b88
Author: Hans Zhang <18255117159@163.com>

PCI: Add pci_host_common_link_train_delay() helper

This commit introduces a static inline helper to wait 100 ms after link
training completes if the maximum link speed is greater than 5.0 GT/s,
satisfying the PCIe r6.0 specification.

> diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/contr=
oller/pci-host-common.h
> index b5075d4bd7eb3..d709f7e3e11a3 100644
> --- a/drivers/pci/controller/pci-host-common.h
> +++ b/drivers/pci/controller/pci-host-common.h

This isn't a bug, but this places a generic PCIe helper inside an ECAM
framework header. Unrelated host controller drivers will have to include
an ECAM-specific header just to use this delay function.

Should this generic helper be placed in a more widely accessible internal
header like drivers/pci/pci.h?

[ ... ]

> @@ -20,4 +23,18 @@ void pci_host_common_remove(struct platform_device *pd=
ev);
> =20
>  struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
>  	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
> +
> +/**
> + * pci_host_common_link_train_delay - Wait 100 ms if link speed > 5 GT/s
> + * @max_link_speed: the maximum link speed (2 =3D 5.0 GT/s, 3 =3D 8.0 GT=
/s, ...)
> + *
> + * Must be called after Link training completes and before the first
> + * Configuration Request is sent.
> + */
> +static inline void pci_host_common_link_train_delay(int max_link_speed)

This isn't a bug, but relying on raw integer values for link speed instead
of enum pci_bus_speed creates a brittle interface.

The PCI subsystem uses enum pci_bus_speed for link speeds, where
PCIE_SPEED_2_5GT is 20 and PCIE_SPEED_5_0GT is 21. If a driver mistakenly
passes an enum pci_bus_speed, the condition greater than 2 will evaluate
to true for all speeds, applying the delay unconditionally.

> +{
> +	if (max_link_speed > 2)

Will negative error codes passed as max_link_speed silently bypass the
mandatory PCIe delay?

Drivers retrieve the maximum link speed using of_pci_get_max_link_speed(),
which returns -EINVAL if the max-link-speed property is missing from the
device tree.

If -EINVAL is passed directly to this helper, the condition evaluates to
false and the 100 ms delay is skipped. If the hardware supports greater
than 5.0 GT/s, skipping this delay violates the PCIe r6.0 specification.

> +		msleep(PCIE_RESET_CONFIG_WAIT_MS);
> +}
> +
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511055923.3711=
7-1-18255117159@163.com?part=3D1
