Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E5234751B;
	Fri,  7 Aug 2026 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132497; cv=none; b=m7h8sdIfopCgNk+7f3P4Lbd+YfSBtaRJ0LNGM4YurjJLSUYjIGSQDDTHnHAgdZ0iQjYtlzN9WJDaC/cB0XFMufwhNpv759X8F9VCSX/UvMW3XcQVWSI5lR+uquWhOQc6KQsazp/rWPTBS+j1H1RTmnrkK/Q9CPAnUlkqocDRdbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132497; c=relaxed/simple;
	bh=jAjyhTVj0fsRTE22qSTP+zoD2lEiJNGHPrDvadq6BKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a1mEydu7tW5Ty9ioIna4ClvRE+sdWP1wg1/QkNlcSmWcf+TQbwj8wyRXKiuMm7AvaCy7MzsrVpFbMVu7u2o6cBozG608zGN6ZO0kR6LvV1JrLT7hPtI2UxQeRw8sWJxsCSo1MNiAbf+uf0jo65zwE8uxSQD5JO4sFCCnEd8vqH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcEmUytr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcEmUytr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BAC1F000E9;
	Fri,  7 Aug 2026 19:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786132492;
	bh=eEr4BGo/lYXq2+5T9AIlAMe74Eyck4eAfvWygJMH4wI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UcEmUytr8D5kzu35FCxI7MdDnbTM2xJ9kJ+qoUztwoIWw2fWVBxtzE3Uwgq6Rggt+
	 fiGHXIj615FLGE7pak4NLtC7H2jK/irWSDiOVd2q340p8FxyDMOuzb0EATraudhHxd
	 XAyT1E58OB/XUfGcSBwXVOSADQSJglYhdf+rDUUJOHUM8l52k/JCiPw3h1fmf/5dL+
	 x490XSF6EEFQc3tuNjdm0NbpqpVYD3e6kRZpjDCSb3wdFTxqRxj4Je5CYxwABiSETo
	 p7fUNnLTB1n56K6JgqEne9oGxa1sc/yDaKsHQApqS8pq+kPzZnmJgInzOp3jkaRTQQ
	 mKMe4rKThQwbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] PCI: of: drop the reg_num argument to
 of_pci_set_address()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260807194100.455599-2-elder@riscstar.com>
References: <20260807194100.455599-1-elder@riscstar.com>
 <20260807194100.455599-2-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 19:54:51 +0000
Message-Id: <20260807195451.C3BAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `of_node_put()` in `of_pci_prop_intr_map()` causes a memor=
y leak of interrupt parent device nodes.
- [High] Missing NULL checks for `kasprintf()` returns in `of_pci_prop_comp=
atible()` leads to a kernel crash via `strlen(NULL)`.
--

--- Patch [1]: [PATCH 1/4] PCI: of: drop the reg_num argument to of_pci_set=
_address() ---
commit 2224ebd8fd372dc1822f3ceaf7519520a5ca9bdf
Author: Alex Elder <elder@riscstar.com>

PCI: of: drop the reg_num argument to of_pci_set_address()

The reg_num argument passed to of_pci_set_address() is always zero,
so get rid of it.

> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 75a358f73e694..505226b876c56 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file I
noticed a potential resource leak in of_pci_prop_intr_map().

Does this code leak the interrupt parent device nodes?

drivers/pci/of_property.c:of_pci_prop_intr_map() {
    ...
    for (pin =3D 1; pin <=3D OF_PCI_MAX_INT_PIN;  pin++) {
        i =3D pin - 1;
        out_irq[i].np =3D pnode;
        out_irq[i].args_count =3D 1;
        out_irq[i].args[0] =3D pin;
        ret =3D of_irq_parse_raw(laddr, &out_irq[i]);
        if (ret) {
            out_irq[i].np =3D NULL;
            pci_dbg(pdev, "parse irq %d failed, ret %d", pin, ret);
            continue;
        }
        of_property_read_u32(out_irq[i].np, "#address-cells",
                             &addr_sz[i]);
    }
    ...
    return 0;

failed:
    kfree(int_map);
    return ret;
}

of_irq_parse_raw() populates out_irq[i].np with a device node that has an
incremented reference count.

Should there be a matching of_node_put() called on these successfully parsed
nodes before the function returns?

[Severity: High]
This is a pre-existing issue, but I also noticed a potential NULL pointer
dereference in of_pci_prop_compatible().

Can this crash the kernel if memory allocation fails?

drivers/pci/of_property.c:of_pci_prop_compatible() {
    ...
    compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =3D
        kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
    compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] =3D
        kasprintf(GFP_KERNEL, "pciclass,%06x", pdev->class);
    compat_strs[PROP_COMPAT_PCICLASS_CCSS] =3D
        kasprintf(GFP_KERNEL, "pciclass,%04x", pdev->class >> 8);

    ret =3D of_changeset_add_prop_string_array(ocs, np, "compatible",
                                             compat_strs, PROP_COMPAT_NUM);
    ...
}

If kasprintf() returns NULL, the compat_strs array will contain NULL pointe=
rs.

When this unvalidated array is passed to
of_changeset_add_prop_string_array(), could it lead to a kernel crash when
the string array is processed and strlen() is called on a NULL element?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807194100.4555=
99-1-elder@riscstar.com?part=3D1
