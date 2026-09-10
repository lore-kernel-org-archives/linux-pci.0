Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B10C3AE718;
	Thu, 10 Sep 2026 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025873; cv=none; b=e3/NVj8Bss7gaHaAu5dcpkoUKNuyspgHpz7oZ2BE7q6DJD+pprYAhBy5whb+KFAnmvQRpyQs1Kw3L44PsRT+pBIYYFr2mcys1h6mavYjdH1UatfgDqSzGWKEzcqwGEDNoDl97tpeXq8mAAYAKBF4kbt7wXItLkTnbnWW8NWZiDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025873; c=relaxed/simple;
	bh=XXtmZnDoic4ODtNc0F/9ln1XBPznxYmZfl2tr5fQWiw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YlOFiZk9VrJaLTst/hHDgLrd7il7kcPGPpyWZNAtXpNCmuzq4i3ckZZjMwGJmDkdX4QHYXVCidUfkQO5K0zTIB42xh0MG3TwFGKTUhp/hnDAw4Nj9yBkISGeaZMADBhwCUrMV7rM/qdUxNlRnhEv6TOfoCvjD2Dw7H/GsMNjM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwpgB/cW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwpgB/cW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907EF1F000FF;
	Thu, 10 Sep 2026 07:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789025862;
	bh=WM/euWA5kKjP9gJ01R5MgwWIRX10xCRp4cy2rXofDZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwpgB/cWKrBV1/sJMYuGsNpwPLC7YtF7JFjPzUTsBKatg6z1aPJpVT2mhJH2lLZ9L
	 4mt1jb5kGJXnK/Ntfo/QZlXO+4OzkgdzrINWUconVmalqDXo/+2ZlV8QG0qJDs8scE
	 XkVXCipv3xd5VSJ3nFPjNKzqYrPvk4DCcMs0lYTQvWq/hu4MbmWx5dQNxHWz3KGYGs
	 rvgSAPGesoO9CwJJUUJefJQoh679FT5mZpyP/iUTboOV6MiiCjEnzPH8gk/4J9JiJr
	 sTejFPQTfAbBCZAl0+tMoBkcDEaoFyVyMVOOtUtUMYpa5LnrrMCVploS3bWUbpbWyI
	 3NBlYQt9snyUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 12/12] PCI/CXL: Restore CXL state after CXL bus
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260910070808.1444264-13-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-13-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 07:37:42 +0000
Message-Id: <20260910073742.907EF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] cxl_reset_bus_function bypasses memory range safety checks and=
 CPU cache invalidation before initiating a bus reset, risking MCEs and sys=
tem crashes.
- [High] Priority inversion in pci_reset_fn_methods[] bypasses cxl_reset_bu=
s_function, causing CXL state restoration to fail if SBR is already unmaske=
d.
--

commit a0905bda4417fb243d6c3399ed1032ddb3d39e35
Author: Srirangan Madhavan <smadhavan@nvidia.com>
Subject: PCI/CXL: Restore CXL state after CXL bus reset

This commit updates the CXL bus reset path to restore CXL HDM decoder
programming and CXL Device DVSEC protocol enables after a successful CXL
bus reset. It introduces a state restoration function that restores PCI
config state first, ensuring BARs are valid before restoring the cached
CXL state. It also rejects CXL bus reset for multifunction devices and PFs
with enabled VFs.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 157f06c576e93..a3ba4c28c62bc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -5054,6 +5057,9 @@ static int cxl_reset_bus_function(struct pci_dev *d=
ev, bool probe)
>  		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>  				      reg);
> =20
> +	if (!rc)
> +		rc =3D cxl_restore_state_after_pci_reset(dev);
> +

[Severity: Critical]
This is a pre-existing issue, but does cxl_reset_bus_function() bypass
memory range safety checks and CPU cache invalidation before initiating a
bus reset?

The hardware bus reset is executed in this function (just prior to this
hunk via rc =3D pci_reset_bus_function()) without any preceding memory range
safety checks or cache invalidation. This bypasses the safety mechanisms
present in the traditional CXL reset path.

While cxl_reset_function() properly invokes cxl_hdm_ranges_prepare() to
verify no memory regions are busy and flush caches,
cxl_reset_bus_function() entirely skips these safety checks before issuing
the reset.

A hardware PCI bus reset instantly clears CXL HDM decoders. If the CXL
backing memory is in active use by the host (e.g., DAX or system RAM),
pulling the memory away can cause Machine Check Exceptions (MCE).

Could this allow a VFIO-assigned VM to crash the host via the sysfs reset
attribute?

[Severity: High]
This isn't a bug introduced by this patch, but does the priority inversion
in pci_reset_fn_methods[] bypass cxl_reset_bus_function() entirely?

The pci_reset_fn_methods[] array defines the fallback priority of reset
mechanisms. The cxl_bus entry is placed after bus:

drivers/pci/pci.c:pci_reset_fn_methods[] =3D {
    ...
    { pci_reset_bus_function, .name =3D "bus" },
    { cxl_reset_bus_function, .name =3D "cxl_bus" },
};

Placing cxl_bus after bus ensures that if the standard bus reset is
physically possible and unmasked, the CXL-specific wrapper with the state
restoration logic will never run.

If a CXL device's Secondary Bus Reset (SBR) is already unmasked,
pci_reset_bus_function() will successfully probe and execute the reset.
Because it returns 0 on success, the PCI reset core stops iterating and
completely bypasses cxl_reset_bus_function().

As a result, the newly added cxl_restore_state_after_pci_reset() is never
called, leaving the device with unprogrammed CXL HDM decoders.

>  	pci_dev_reset_iommu_done(dev);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910070808.1444=
264-1-smadhavan@nvidia.com?part=3D12
