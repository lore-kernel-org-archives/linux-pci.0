Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C643B9D9B
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822056; cv=none; b=Hnim1ahFHNMlMqVGmLmaGvIcsF4IF691piA+s+HtIF7XOS6712v+DPGLG0ncnOA7F80tPyZJqhpSkClbvEUEh458oI5uBCAsquF69VT0n+T7ZqIXE+mjmdE8GQDX2qXHrUZrTQJmppZSb5DblyplG+xcqciETNT6tbKv7xElo90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822056; c=relaxed/simple;
	bh=NAqTM/iHvs1CJNgfOdeRKNHSJJzboCUG/g3OUm3c3ww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f+YV+1bs6LlsSbPd8bbFka+PyN4PnfqlzVnP4523CTR2RTTWfe3vFUeAcNhovOj1NdgN0KcS79g3x5DGT8ZgxiQRwQ+poprFrENvBZhRCr60dY6vgDr0W2MnuB/bdPgbNmtssLo+EPZyn/BCFmKixjUfAFZaixruo8O9c4kUjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5buxD9u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5buxD9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BAD1F000E9;
	Tue, 26 May 2026 19:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779822047;
	bh=t4lTsb40wxZvXl+vavOz4+xMdITr9rzuM0hhUOl5tMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A5buxD9utW4vJHjwu1lnIClKcX1/YlMZAN7FD4/eKLR0diLb91/0UaaJ10NxzKt8L
	 WdrGlwMhFxksHHCVlt5+uUYcJ5PzWgQX5AsjUmIUUGRhl0B9PZYz8xZqApfgySdUYY
	 ufYNvy5+CEI50/aKd9Vz8H+juc0atnotvSOn24Y7yu6PWCOPi3koJTLAYM9OWqL8H2
	 xPEXhyp7YE9pjNquhLjkBA0FLmHvUcDSn7ENkhY9q6nGOmCEaZ7KR4iVSyA12vVCsD
	 PM4nF9wI9rES2FVn7OYtFSUCJztjTzMQcRs0k1p46P4aFXFivEk9yCUO7OFlzBZbf+
	 yKxn1hgWNtbOg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] PCI/CXL: Add RDPAS parsing support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260526182334.1010870-2-dave.jiang@intel.com>
References: <20260526182334.1010870-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 19:00:46 +0000
Message-Id: <20260526190047.37BAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] RDPAS entries for an RCEC with multiple downstream ports are incor=
rectly dropped as duplicates.
- [High] Missing length and boundary validation for ACPI CEDT RDPAS subtabl=
e can lead to out-of-bounds memory access.
- [Low] The patch introduces `#include <cxl/ras.h>` in multiple files, but =
the header file itself is missing from the commit.
--

commit 579799797ed7b991cdee3c9ccb1b1c1f0f8e3e23
Author: Dave Jiang <dave.jiang@intel.com>
Subject: PCI/CXL: Add RDPAS parsing support

This commit adds parsing for the RCEC Downstream Port Association Structure
(RDPAS) from the CXL Early Discovery Table (CEDT). It stores the 64-bit base
address for CXL.io in an xarray indexed by the RCEC segment and BDF.

> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 127537628817e..e33cae64def9a 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -7,6 +7,7 @@
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
>  #include <linux/node.h>
> +#include <cxl/ras.h>

[Severity: Low]
Is this missing a new header file? The patch includes <cxl/ras.h> here and =
in
aer_cxl_rch.c, but the file doesn't seem to be added in this commit, which
will cause a build failure.

[ ... ]

> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rc=
h.c
> index e471eefec9c40..3f3f6177a828b 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c

[ ... ]

> +static int __cxl_parse_rdpas(struct acpi_cedt_rdpas *rdpas, struct devic=
e *dev)
> +{
> +	unsigned long index;
> +	int rc;
> +
> +	/* Skip CXL.cachemem as the current RDPAS scheme only supports CXL.io */
> +	if (rdpas->protocol !=3D CXL_RDPAS_PROTO_IO)

[Severity: High]
Does this need to validate the subtable length before accessing fields?

If the ACPI table provides a truncated RDPAS entry where header->length is
less than sizeof(struct acpi_cedt_rdpas), accessing rdpas->protocol (and la=
ter
rdpas->address) could result in an out-of-bounds read.

> +		return 0;
> +
> +	u64 *addr __free(kfree) =3D kzalloc(sizeof(*addr), GFP_KERNEL);
> +	if (!addr)
> +		return -ENOMEM;
> +
> +	*addr =3D rdpas->address;
> +
> +	index =3D __rdpas_index(rdpas->segment, rdpas->bdf);
> +	rc =3D xa_insert(&cxl_rdpas, index, addr, GFP_KERNEL);

[Severity: High]
Will this drop valid RDPAS entries if an RCEC is associated with multiple
downstream ports?

According to the CXL specification, an RCEC with multiple downstream ports =
will
have a separate RDPAS structure for each port. Since the xarray index is ba=
sed
only on the RCEC's segment and BDF, won't xa_insert() return -EBUSY for the
subsequent downstream ports, causing them to be incorrectly discarded as
duplicates?

> +	if (rc) {
> +		if (rc !=3D -EBUSY)
> +			return rc;
> +
> +		dev_dbg(dev, "Duplicate RDPAS: PCI %04x:%02lx:%02lx.%ld\n",
> +			rdpas->segment, FIELD_GET(GENMASK(15, 8), rdpas->bdf),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526182334.1010=
870-1-dave.jiang@intel.com?part=3D1
