Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794794925;
	b=d4j3Dxeq5YCoxgEjHtC9p2B8NShshA/K3cGjfupXthszP4cKGXO6r1XiwLIUyhu4DMxA
	 by8P7CviHAbpQ/vxVRuBABsfsDhmlAYT9h3fRgUi7Hp0Q6ZEjg3EMrGYJR/OM1u0uLqZT
	 TOizcGW8/0FBMEDaw0uQULE1L9CX6yPgbUNsh4CFdCBLDvoz9wL60wGY1IH7rJslkt16B
	 3zkAAVzGWV5cYX9dWB2eEY56k74ePWIXNwej6SuEu5dgeSy6FdwUZyLq62lgZQN6S0We3
	 82xpYVLn/5LlUsQNJ0PnLj2gE9B5Lz2ApUP4Z98SCWd+YOWF6yAPAT6YCeil/1kNtIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794794925;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V2uKCe0Y1sT6EhZyzPfTC2bGhmyKY3LG7M5p5d4qQRQ=;
	b=yNRLbwKfIxfE3l+VR+y31gZ2ydrSJLdhdUoolvHv0dBl6j3Fco+acLFTFfOhL0RNmsRg
	 FX4Gmt/g8bvKhk+7upYUeKvEqaCS+GqerKUQhXh5z7vqw23cD/5P/5KU2mcGvfu6H2BY9
	 L+BLcfLqo968Zu3FOM34qCj+GCXHXzh1G+/rDPIUf+dNXxQwfRl13swgVUqoC/pFQX8mI
	 u9KyJZaMJPwClA+SSgRwwTqZ9WoDJqJft5vLTFJBanqPD5KlBL6bh+2QSFkm6lH4aYdb4
	 OIuDUW1UugzKjuGqvppfJEdrKPYE0mcVaf6eoJEgUIDzquJm7IYnS1SFDTnPUKiZ2Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="czq/zSle";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED89606A31C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czq/zSle
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F291F000C4;
	Mon, 16 Nov 2026 02:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794794925;
	bh=V2uKCe0Y1sT6EhZyzPfTC2bGhmyKY3LG7M5p5d4qQRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=czq/zSleNf9LBTU2OeTuBTIVw5u0XfzJkx5HWGOtY+aSG4BvbgM1UVyztgTwoOwcx
	 RzNjBKIbPf6X/pSb7WY/H9amBFCqRFT+d3NHDzKwRK+5NQXHe8pLjn/n2KyBsFFceS
	 gs9aTddYtE8Taa/pK4RnupWVStfLzowkiEIyIj07Lwcy413JwbbCWZb4CKusyCULrV
	 lDnlIx2n9GZiD64fyTlQHj5UAa0hbxeVfCH5J/MA/Oa0z3SCQwTzET5m/aW/wggsrr
	 KcamUgwOmgc2smDHqhnB/taGyK+mOOCTUgI9N20qwjhBDnEKMTvxcKFJNXxzl1KCtJ
	 cp28MTi2dgxnA==
Message-ID: <sashiko-outbox-216065@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Disable spurious s2idle wake from the NVMe root
 port on ThinkPad P1 Gen 9
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kean Ren" <rh_king@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116014214.102524-1-rh_king@163.com>
References: <20261113014824.2396883-1-rh_king@163.com>
 <20261116014214.102524-1-rh_king@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 02:08:44 +0000
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
- [Low] PCI: quirks: pci_fixup_p1g9_rp05_wakeup() checks
  device_can_wakeup()
--

commit 214973074b1cd82e39015c9a8ebdc8afb6fbe7d3
Author: Kean Ren <rh_king@163.com>

PCI: Disable spurious s2idle wake from the NVMe root port on ThinkPad P1 Ge=
n 9

This commit adds a DMI quirk for Lenovo ThinkPad P1 Gen 9 (21UF) laptops
to disable wakeup on PCIe root port 00:1c.4 and prevent spurious PMEs
from aborting s2idle when the primary NVMe SSD enters D3.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f7cd4149f8130..d37d225f7f082 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6610,3 +6610,57 @@ static void pci_mask_replay_timer_timeout(struct p=
ci_dev *pdev)
[ ... ]
> +static int __init pci_fixup_p1g9_rp05_wakeup(void)
> +{
> +	struct pci_dev *rp;
> +
> +	if (!dmi_check_system(p1g9_rp05_wakeup_dmi))
> +		return 0;
> +
> +	/* Root port of the primary NVMe SSD (05:00.0). */
> +	rp =3D pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0x1c, 4));
> +	if (!rp)
> +		return 0;
> +
> +	if (device_can_wakeup(&rp->dev)) {
> +		device_set_wakeup_enable(&rp->dev, false);
> +		pci_info(rp, "disabled spurious s2idle wake (BIOS %s)\n",
> +			 dmi_get_system_info(DMI_BIOS_VERSION));
> +	} else {
> +		pci_warn(rp, "wakeup not enabled, cannot disable spurious s2idle wake\=
n");
> +	}

[Severity: Low]
Should this check device_may_wakeup(&rp->dev) instead of
device_can_wakeup(&rp->dev)?

pci_pm_init() and pcie_pme_probe() unconditionally set can_wakeup =3D true
on PCIe root ports advertising PME support, independent of whether ACPI
_PRW and pci_acpi_setup() enabled wakeup on the port.  When wakeup is
not enabled (for example, on a future fixed BIOS that drops _PRW on
RP05), device_can_wakeup(&rp->dev) still returns true, so the quirk
falsely logs that spurious s2idle wake was disabled and the else warning
is never reached for disabled wakeup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116014214.1025=
24-1-rh_king@163.com?part=3D1
