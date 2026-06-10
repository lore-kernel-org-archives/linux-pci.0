Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB663ED5AE
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100380; cv=none; b=IGA4FmKY5kWN8KxOZ/tjvKmaVsrbnAHRUavsg4r5jOq1Z7CvnQGQQA+yGXEJuXH5lGietlw1HtGaGElkwD6HVX4mmms/1uWZ9yj5A8vEbfwjHWW6dQxUHRctcFUs6ZcRzXvuIMkjl+WpSn2HrHddawtiV2DILyHwSSGodN0deno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100380; c=relaxed/simple;
	bh=jadToFTsnZOxTgaZH8pnzdvJVA2GNbC+3bK0mdAJM2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IUHKMTtavNAGzZL9akLGYut24lAR+Wi17/k2vLnV6MGtlGC5sCMjh+vmfcILBMrPGX5Oucord8jXsYTQE5ZOndugfm8vIWX1DdJ51gn1Qeb+AMuTBUFtS7celRLHst86fKKgAJ/uc0yi5/SKXae7VTMi/+wBz3mlNXcP2X21/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQpfDDDo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQpfDDDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB2B1F00898;
	Wed, 10 Jun 2026 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781100379;
	bh=fRgpuhRSQA3doRE1Mdx8G5O3JorlQUqp3H4ZGaPWkbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fQpfDDDoRC2gCZY2Qh6MUJ9jZiUHNggJvXTdKLkjN7FoG0V3uXDF6KgWVxbqi+vIE
	 E9WRUdY0f29HO8VdEVctbBYR4w1dzqmPD7jIbG8GvzvfuSHYrlAlqNurcj2YEhTjir
	 4vo25boP2syYnlHbAvY8iVch+E5ANenUSt3eo/i1cHWS8YPmabLjfO405hKniF4XKY
	 Dw9gcf1M2K3iJDODNv4VofWj3YySXhMGEyLqkxUzwa9aG3dzFK9URc+WvkVXxcrftI
	 iCuucbdCqefSwc610i1O+lauuni/leeh8Q80XlmwP7pFpY8/AswIo3157Z0lZCT9Zd
	 idDSe92Dtmcmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: setup-res: Guard against bus->self == NULL in
 _pci_assign_resource()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuguo Li" <cs.hugolee@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260610135709.1630627-3-hugoolli@tencent.com>
References: <20260610135709.1630627-3-hugoolli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 14:06:19 +0000
Message-Id: <20260610140619.7DB2B1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL pointer checks for `bus->self` on SR-IOV virtual buse=
s lead to kernel NULL pointer dereferences.
--

commit cceccf0d2941496dffe5f65650c6e24234a1b849
Author: Yuguo Li <cs.hugolee@gmail.com>

PCI: setup-res: Guard against bus->self =3D=3D NULL in _pci_assign_resource=
()

This commit fixes a null pointer dereference in _pci_assign_resource() by
checking that bus->self is not null before checking bus->self->transparent.
This addresses a crash on SR-IOV virtual buses where bus->self is null.

> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index fbc05cda96ee0..76e48be53a575 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -351,7 +351,7 @@ static int _pci_assign_resource(struct pci_dev *dev, =
int resno,
> =20
>  	bus =3D dev->bus;
>  	while ((ret =3D __pci_assign_resource(bus, dev, resno, size, min_align)=
)) {
> -		if (!bus->parent || !bus->self->transparent)
> +		if (!bus->parent || !bus->self || !bus->self->transparent)
>  			break;

[Severity: High]
This is a pre-existing issue, but since you are fixing the SR-IOV virtual
bus null pointer dereference here, could other places traversing bus->parent
suffer from the same vulnerability?

For example, in drivers/pci/pci-sysfs.c:bus_rescan_store(), the code passes
bus->self without checking if it is null:

        if (!pci_is_root_bus(bus) && list_empty(&bus->devices))
                pci_rescan_bus_bridge_resize(bus->self);

If sysfs triggers a rescan on an empty virtual bus, could this cause a
crash when pci_rescan_bus_bridge_resize() unconditionally accesses
bridge->subordinate?

Similarly, in drivers/pci/pci.c:pci_dev_run_wake(), we have:

        while (bus->parent) {
                struct pci_dev *bridge =3D bus->self;

                if (device_can_wakeup(&bridge->dev))
                        return true;

And in drivers/pci/pci-acpi.c:acpi_pci_propagate_wakeup():

        while (bus->parent) {
                if (acpi_pm_device_can_wakeup(&bus->self->dev))
                        return acpi_pm_set_device_wakeup(&bus->self->dev, e=
nable);

Do these compute an invalid offset for &bridge->dev or &bus->self->dev when
bus->self is null, leading to memory corruption or panics when they are
subsequently dereferenced?

>  		bus =3D bus->parent;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610135709.1630=
627-1-hugoolli@tencent.com?part=3D2
