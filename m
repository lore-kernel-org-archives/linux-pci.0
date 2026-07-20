Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3821F2E2665
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586725; cv=none; b=oi3f8QrJhksKN6eV1Ti79zrU6L2FGN2ytxL0gx3R+emFKycxhxrohGcM5GkGmmqF00iRaKg/1c8VvtwZr1YIk8O5aInIYydH2m+a212JIOd/IRkIaAdBJERxqctZVbXJHwIhkqNhq3UBOmFFX+VUj/78jA2qxwkqj9WDm3WCMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586725; c=relaxed/simple;
	bh=+wMB7jri08XKucpd9B9cpXD1SkcutOj9Vb2KSYNiKuU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LySTp32ABqfmheJD3uxoSqP7V+KY2xNWsJv2xsXQg/xwI2myEUhE2K47KburNu6Y461K20P0mqc2fMdlr8hcVFmnbYxdUVJwrR27WSjik8mm12pNnU4V1S/BATaH/hudEVPabn6zW2y/Yv6FuwW+j5f6DQEfhbq+3TuV5TIhRiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcdZI3io; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcdZI3io"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30841F000E9;
	Mon, 20 Jul 2026 22:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784586723;
	bh=Mu7ol6Sqkxnr5Gzattm+j4E0XjR1883XoSBEcLeFjyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CcdZI3io/BszhoWeMNw8JB3kcmPGqtoAvbqJ9dlbxQj0ROoee4rMVhF/qLBKUZXWb
	 uNW7xx6F9UpimqClWjFLTkxH5Zhvngn8h9L1OEjsQIdR3+9dAbNkg7TLrfgVxV49tx
	 0yC3cXFb+ZeicLzo5fc7IS6m2a0EAs4ARt7irVdor59gDhNdf8cI8hFOkgwSgujh5U
	 jAkXcXRFaz/kY8wt3mfSLRJm/6yZisUPTURvHQDU45jRZpu1sy/Cvi0vWIbOq6fSlw
	 nzTbtvd4macKQAYHrl8RhzkoYnqUNFSex1X3WTwjSDTs6JZVGSHYPoCg+a25Nzzz61
	 lEK6p7dY9Xc2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirk for Pericom PI7C9X2G608 switches
 [12d8:2608]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tim Harvey" <tharvey@gateworks.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260720215718.2139510-1-tharvey@gateworks.com>
References: <20260720215718.2139510-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 22:32:03 +0000
Message-Id: <20260720223203.A30841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked cross-device configuration space write to upstream bridge
--

--- Patch [1]: [PATCH] PCI: Add ACS quirk for Pericom PI7C9X2G608 switches =
[12d8:2608] ---
commit 675033e8622336b73d3cde73c4a110a428c76dc5
Author: Tim Harvey <tharvey@gateworks.com>

PCI: Add ACS quirk for Pericom PI7C9X2G608 switches [12d8:2608]

This commit adds a PCI ACS quirk for the Pericom PI7C9X2G608 switch to
address erratum E2. It applies the existing store-forward workaround to
device ID 0x2608.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846fc..27f7d56c9ac39 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6263,6 +6263,10 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x=
b404,
>  			 pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
>  			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2608,
> +			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2608,
> +			 pci_fixup_pericom_acs_store_forward);

[Severity: High]
This is a pre-existing issue, but does pci_fixup_pericom_acs_store_forward()
safely verify its upstream bridge?

Looking at the callback:

drivers/pci/quirks.c:pci_fixup_pericom_acs_store_forward() {
        ...
        upstream =3D pci_upstream_bridge(pdev);
        if (!upstream)
                return;

        pci_read_config_word(upstream, PI7C9X2Gxxx_MODE_REG, &val);
        if (!(val & PI7C9X2Gxxx_STORE_FORWARD_MODE)) {
                pci_write_config_word(upstream, PI7C9X2Gxxx_MODE_REG, val |
                                      PI7C9X2Gxxx_STORE_FORWARD_MODE);
        }
}

Because it finds the upstream bridge and unconditionally writes to offset
0x74 (PI7C9X2Gxxx_MODE_REG) without checking if the upstream bridge is
actually a Pericom device, could this corrupt standard PCI capabilities
such as MSI-X tables?

If a Pericom switch is passed through to a guest via VFIO, the upstream
bridge in the guest's virtual topology might be a generic virtual Root Port
rather than a Pericom device, exposing the guest kernel to configuration
space corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720215718.2139=
510-1-tharvey@gateworks.com?part=3D1
