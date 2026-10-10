Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727512F361B
	for <linux-pci@vger.kernel.org>; Sat, 10 Oct 2026 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791601308; cv=none; b=j3V2VQbzB7aWNUDMw0O1htZWH5eDkqkFevxGtvgaQ8jfwob79IdLmNCaZzQTJiPDhneJrxJzsDniX2v4HiY6XhCpig6g2tY/MVxft6TSY+qvjnn+G9fAd+bzPLvUtF6P+rkqctX4jBePC6W2gDYAXTeA8Xf7SNuKcmrrRcGiqCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791601308; c=relaxed/simple;
	bh=bTyBiUHLH4JCn3VEAbSKxT2dRzTzdXp452WXrPiryGA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=btYJkQ5pcrl1abEMwcwowFS4OGtjvsG6/mqzDWWjWAYAc7WZMUJYJBbU7hqTocitT3TTqJlLv4opZX9JeAuuthV7ksio71p2M/pXFN4HQFK+i22b9NiJUIlvOnh21bjOCAZgnnLJZOEX3961S7HpgXtSaaXm/JWWhwIEXB7/BXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETNiGpVj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETNiGpVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36EA1F000FF;
	Sat, 10 Oct 2026 03:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791601306;
	bh=QeSXxZUP/87ApoJigF1F2v7PWilFlnzG0v3rO4g0FNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ETNiGpVjQowAMPvuZpddv4qWH9YFg0++gJtWUoIDinOW9ocd7uk+EGmv45z9od+pj
	 WFw6XQrCRdeqTZELY1vt1w3KYTQR0Hbt555nmaD6Qhwn6zw+aly+BWWl24I/2elYS8
	 RhbPf8kS0Cg2hEmuWAlouODmV236hrURjm6J8TUpi/EMNvW7Wj8lZrkpbp+BOecjqo
	 SPoF5frvbXVUmXRBlSkv2p5Wf925mKk2buhSJzZMSikdwZHFmmchmo+kMzJierVdE4
	 /w/1Fzxu4lKBQiyy6kZzA7TlAl7sycb6vx0uLizW6mVvXgEG4vg0t0hqZ0Qx0B8Dt2
	 E0ejJ0pGQyHHg==
Message-ID: <sashiko-outbox-166236@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/ASPM: Fix NULL pointer dereference in sysfs
 show/store callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1791596305-153177-1-git-send-email-shawn.lin@rock-chips.com>
References: <1791596305-153177-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 03:01:46 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci/aspm: use-after-free race in sysfs callbacks due to lockless p=
cie_link_state check
--

commit 9e5cf0a1d40aaa7028d286ec96a1c08c4a3dfd68
Author: Shawn Lin <shawn.lin@rock-chips.com>

    PCI/ASPM: Fix NULL pointer dereference in sysfs show/store callbacks
   =20
    Reading or writing a link state sysfs attribute after the upstream
    bridge's pcie_link_state has been freed triggers a NULL pointer
    dereference.

Cc: stable@vger.kernel.org

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index f8e64971c6c3d..0e0ba0e677e50 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1777,6 +1777,9 @@ static ssize_t aspm_attr_show_common(struct device =
*dev,
>  	struct pci_dev *pdev =3D to_pci_dev(dev);
>  	struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
> =20
> +	if (!link)
> +		return -ENODEV;
> +
>  	return sysfs_emit(buf, "%d\n", (link->aspm_enabled & state) ? 1 : 0);
>  }

[Severity: High]
Does this locklessly fetch and check the link pointer, leaving it exposed to
concurrent freeing?

If another process triggers the removal of function 0 of the downstream
component concurrently, pcie_aspm_exit_link_state() could acquire the locks,
clear the link state, and free the link after the check but before
sysfs_emit() dereferences it. Can this lead to a use-after-free regression?

> @@ -1788,6 +1791,9 @@ static ssize_t aspm_attr_store_common(struct device=
 *dev,
>  	struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
>  	bool state_enable;
> =20
> +	if (!link)
> +		return -ENODEV;
> +
>  	if (kstrtobool(buf, &state_enable) < 0)
>  		return -EINVAL;
> =20

[Severity: High]
Could this cause a similar regression here?

The pointer is validated locklessly but dereferenced inside the lock. It can
be freed by a concurrent thread while the current thread is waiting for
pci_bus_sem or aspm_lock further down in the function.

> @@ -1836,6 +1842,9 @@ static ssize_t clkpm_show(struct device *dev,
>  	struct pci_dev *pdev =3D to_pci_dev(dev);
>  	struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
> =20
> +	if (!link)
> +		return -ENODEV;
> +
>  	return sysfs_emit(buf, "%d\n", link->clkpm_enabled);
>  }

[Severity: High]
Does this code have the same use-after-free race condition?

The link pointer is validated outside any locks, but could be freed by a
concurrent removal before it is dereferenced in sysfs_emit().

> @@ -1847,6 +1856,9 @@ static ssize_t clkpm_store(struct device *dev,
>  	struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
>  	bool state_enable;
> =20
> +	if (!link)
> +		return -ENODEV;
> +
>  	if (kstrtobool(buf, &state_enable) < 0)
>  		return -EINVAL;
> =20

[Severity: High]
Does this demonstrate the same race condition as aspm_attr_store_common()?

The pointer is validated locklessly, but dereferenced inside the lock. It c=
an
be freed by a concurrent thread while the current thread is waiting for the
locks further down in the function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1791596305-153177-1=
-git-send-email-shawn.lin@rock-chips.com?part=3D1
