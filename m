Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9835FF5B
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860144; cv=none; b=hjhXvItdk++Py+50Yjk0Dvu57y1yndNkXaUXMzwywn2AYsMlMWHE0N6Rbqza8QPT3D/s74bC7zuoWpEojKfsPPk0PWbwHzxGifSP24R1m8gXPJSbyzLpzrcC/schG7t8fhjLGtuafxunGrt4pxcClTVf5xt+KKCpIAEDXJDF+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860144; c=relaxed/simple;
	bh=31rA+p3InWNeiuGP1u0sCbw9R7FOvVEHLb6izQ/Fhqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hqZeW/GVtZst7v18p37zprVrbBJRKmZYMwXXY1JNeNAdHxxOq00FNcLdr4a1xMdgp1Rc2LUOLEPn965lPOxOj574kP4YxOxjfNdg5bNOO+VVWMFg4TkcIWbZIrgKtX6x028wY+mSA5/S1rXqEaLewHTQ0MMbyJj1HYMZoTfU7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewGeqRT3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewGeqRT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302621F000E9;
	Fri, 19 Jun 2026 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781860143;
	bh=LLDoUfKLosLdfBzCuJ4fodGTgOxGURwkyswJsc3COZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ewGeqRT3euRF5NM/rPzkKCYgDyILsn1Gu3bwEx4OecS53q8ndBMf7gpbXvz2icyyC
	 5HYfc5DVkoQNJ/FQ8UI1n6AXbwI9d8zOlxMLGtc30fiitHaF6RdGxqt90CSRfvwjYg
	 8a5vb9f1kYSMmt5nfjRVX2KjSNA76AR5S0QypxVqrlF4rkt83MjtjAiwWra3hE3tdc
	 KjaH2fZ9wT6h0YYARVuuhYNFgbbh4kjnTAGyFEpIBiEZV5kAXhrO3owF+Zyb/FNW7Q
	 D2nwC4woSPbKKUIOSlw7E3l3WRIE23QE/Qqlp5J5+lqOzwlDdFBIithsyGA3HepgQu
	 2bak7YpGwEUdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/25] PCI/sysfs: Use PCI resource accessor macros
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-2-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-2-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:09:02 +0000
Message-Id: <20260619090903.302621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to the global `vga_default` pointer leads to a Use=
-After-Free.
--

commit be1111a7de2552597e9d80551a60eee90c47b957
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

PCI/sysfs: Use PCI resource accessor macros

Replace direct pdev->resource[] accesses with pci_resource_n(),
and pdev->resource[].flags accesses with pci_resource_flags().

No functional changes intended.

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index d37860841260c..1fbc3daf87cc5 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c

[ ... ]

> @@ -689,7 +689,7 @@ static ssize_t boot_vga_show(struct device *dev, stru=
ct device_attribute *attr,
>  		return sysfs_emit(buf, "%u\n", (pdev =3D=3D vga_dev));
> =20
>  	return sysfs_emit(buf, "%u\n",
> -			  !!(pdev->resource[PCI_ROM_RESOURCE].flags &
> +			  !!(pci_resource_flags(pdev, PCI_ROM_RESOURCE) &
>  			     IORESOURCE_ROM_SHADOW));

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a lockless access
pattern here involving vga_default_device() that could lead to a Use-After-=
Free
elsewhere in the code.

For example, in drivers/pci/vgaarb.c:vga_arb_write():

    if (!strncmp(curr_pos, "default", 7))
        pdev =3D pci_dev_get(vga_default_device());

Could this race with device removal? If vga_arbiter_del_pci_device() takes
vga_lock, updates vga_default to NULL, and drops its reference with
pci_dev_put():

    void vga_set_default_device(struct pci_dev *pdev)
    {
        if (vga_default =3D=3D pdev)
            return;

        pci_dev_put(vga_default);
        vga_default =3D pci_dev_get(pdev);
    }

If the thread executing vga_arb_write() reads vga_default but is preempted
before incrementing the reference count in pci_dev_get(), couldn't the devi=
ce
be entirely freed before pci_dev_get() executes, leading to a Use-After-Fre=
e?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D1
