Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C393A7F7E
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790437; cv=none; b=ns4MJLe0M/2uDInSXSRzLlFcX/banq/BYSxuC+6iqNMevQqH4UMjSRa33E1cOXLfIvfaK/YbhLzMB87Fp/f9s3SXR2NijKcyblXMVshxF4yIsoe3THdnrAbTv0wldOe+hMRAt1XcgmR73db7SPiYkA6J/ikmbn5m5MUgUo9bmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790437; c=relaxed/simple;
	bh=jkbfG2Q1n1bPthlh6S+lavDEb2cYqcPTC22c1ZRYl2g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xw0DDrRUQw/6YoWViRTap06sfecrebTZyJxcHIvq9VMvgP6ykOWk9oj0HqDbbxkr6hkERXj424kE6752h0GWVenletM3YNYQ5oWB6Jjn8PQ1rwhmOeRMUDlJG8f0LebsDIR4s/uzDfPibisPma8YIIf1+jVF2WczVTzp3qNjjnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVxhNRXO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVxhNRXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834F41F000E9;
	Mon,  3 Aug 2026 20:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790435;
	bh=MryNnn20tWOgzxUf2GejYC0gQuTi8inMfv0pE+oSazg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UVxhNRXO0BW+l8jepAOh8kEQ3G3vsrcW1O85y3WNPbB1X5Vk6jnDn+4WoRSSguZGA
	 PdOX0ieDJJ76F5VjlcybtniUQ4NNGyxxDHZ90BNsbozfASnNTK6tKRDdL+Y5UE3Z/X
	 M1AKoQ/5LXjzlSizox3VQS5/kpvQhaM9g9qEcqkcUYFAtGBxAy9FwpQ/BPFJ5VG7QP
	 1zQW8IYWmSfdHdQ+ChzP/cvXGl/gHX8V3CsETn83IhzH5z79nk8aGEr3F3QXjnqoey
	 Jj1vyWidrPx28TCQ+uRn8qX40yT+jxzynhewoM9T5KLzowTByQL15g+Mck11LM7j/b
	 fUwes3ro8mmMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] acpi: pci_root: Add quirks table for _OSC support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260803203459.10680-1-derekjohn.clark@gmail.com>
References: <20260803203459.10680-1-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 20:53:55 +0000
Message-Id: <20260803205355.834F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch bypasses the global ASPM disablement path, causing the O=
S to illegally configure ASPM registers on the root bridge without acquirin=
g _OSC control from the firmware.
--

--- Patch [1]: [PATCH] acpi: pci_root: Add quirks table for _OSC support ---
commit ae1792c3abcd3cde32bf0136c38058905b107a50
Author: Derek J. Clark <derekjohn.clark@gmail.com>

acpi: pci_root: Add quirks table for _OSC support

This patch introduces a quirk table to dynamically strip specific _OSC
support bits (like ASPM) from certain root complexes. It aims to fix a
hard lock on s2idle resume for the MSI Claw A8 by preventing the OS
from requesting _OSC control when an SD card is present.

> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 84030804a7633..22e97d4064c61 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c

[ ... ]

> @@ -451,6 +513,8 @@ static u32 calculate_support(void)
>  	if (IS_ENABLED(CONFIG_PCIE_EDR))
>  		support |=3D OSC_PCI_EDR_SUPPORT;
> =20
> +	support &=3D pci_osc_support_quirk_mask(root);
> +
[Severity: High]
Does stripping the ASPM support bit here bypass the global ASPM disablement
path?

When this quirk strips OSC_PCI_ASPM_SUPPORT, os_control_query_checks() will
fail because the mask lacks ACPI_PCIE_REQ_SUPPORT:

drivers/acpi/pci_root.c:os_control_query_checks() {
	if ((support & ACPI_PCIE_REQ_SUPPORT) !=3D ACPI_PCIE_REQ_SUPPORT) {
		decode_osc_support(root, "not requesting OS control; OS requires",
				   ACPI_PCIE_REQ_SUPPORT);
		return false;
	}
	...
}

This causes the requested control to default to 0. When
acpi_pci_osc_control_set() is called with ctrl =3D 0, it hits an early exit=
 and
returns AE_OK:

drivers/acpi/pci_root.c:acpi_pci_osc_control_set() {
	/* No need to request _OSC if the control was already granted. */
	if ((root->osc_control_set & ctrl) =3D=3D ctrl &&
	    (root->osc_ext_control_set & cxl_ctrl) =3D=3D cxl_ctrl)
		return AE_OK;
	...
}

Because AE_OK is returned, negotiate_os_control() treats this as a success
and bypasses the failure path that sets *no_aspm =3D 1:

drivers/acpi/pci_root.c:negotiate_os_control() {
	status =3D acpi_pci_osc_control_set(handle, &control, support,
					  &cxl_control, cxl_support);
	if (ACPI_SUCCESS(status)) {
		...
	} else {
		*no_aspm =3D 1;
		...
	}
}

With the global aspm_disabled flag remaining false, won't the ASPM core
proceed to actively configure ASPM on the root bridge in
pcie_aspm_init_link_state() without actually acquiring _OSC control from the
firmware?

>  	return support;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803203459.1068=
0-1-derekjohn.clark@gmail.com?part=3D1
