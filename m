Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC552DB7A3;
	Tue, 25 Aug 2026 02:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787626285; cv=none; b=OE0s1aVTPSkkycp2YZW7JVOAckQuCW08RuHP0d1qlZbFbzDp0w4iVVisqktWVzGTRX9wK+lwYK8EY/UqUvug4xscqWakRX/rd3RzqrZSdDovstpfGHZEYDjUAIfJ+p3m1qJBD4Nsp0/pWvd3fN7cliwcuYeecWP3L30QHAXSPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787626285; c=relaxed/simple;
	bh=mAULVnWVaCETSpy+AdDcf+kXvN8PMQVy103wXuNw9yA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BGvRFGOV5NZSpui2bxW2UACf+r9CvMt4sqswq595TUu6y+/6EM67LrYU64HR1jQRuNauZClmC0317pB1BJcZSc/7rGzJSvEKB+pr6PrVmvd81EPy53PtKurIjNvOUMM3SrHyD5Bz22sKPsJ+hfRhVPz09VKzKTglppZJ+GZoPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPW0LsNc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPW0LsNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7231F000E9;
	Tue, 25 Aug 2026 02:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787626284;
	bh=r/nu8XVXdrWQX7nE+mXCkXgATXBfLQzQCufRhV6E1Pk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MPW0LsNcpaOhEU58z9NEFhufpnIBBiTngA6zF78txnKLvHjJ9Z/gOiHrWvWc5by6/
	 N9YFKYyvFeWeFMtsXH6fgENXi6U6Q9knIYMrYUYK95nSnQgXnOM1D4IKhifelh0842
	 49DJOX9WxaGeGAioefd8kmPNuMUhvL+lRcQW0iNGGmOcy0oY+fqTq8PH5l8MMWQXp0
	 8SD1LpdqGNnah51FpKwsQGix7sgbZ6kdIie9WBK8UAatakRbdA+O4ryCVzDkTyyCBD
	 XGU2tbXm/ftCMkkTWAtjW6QIT8+YV5l6wnlHydnf+MFNA2Acz3i8EJHZVodi/9I2rd
	 OJEoB0Q4oiDTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/13] PCI/CXL: Add a sysfs entry to unmask SBR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260825022628.3651434-13-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
 <20260825022628.3651434-13-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 02:51:23 +0000
Message-Id: <20260825025123.CB7231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent writes to the `cxl_unmask_sbr` bitfield via the sysfs s=
tore function can corrupt adjacent bitfields in `struct pci_dev` due to non=
-atomic read-modify-write operations.
--

--- Patch [12]: [PATCH v2 12/13] PCI/CXL: Add a sysfs entry to unmask SBR -=
--
commit d915ae90bb0b4f81c466e6e9be4cc5b40f737fbb
Author: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

PCI/CXL: Add a sysfs entry to unmask SBR

A Secondary Bus Reset of a CXL Downstream Port only reaches the component
below it when the Port's Unmask SBR bit is set. This commit adds a
cxl_unmask_sbr sysfs attribute to allow the kernel to trigger an SBR of
CXL DPorts.

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
[ ... ]
> @@ -573,6 +573,33 @@ static ssize_t reset_subordinate_store(struct device=
 *dev,
>  }
>  static DEVICE_ATTR_WO(reset_subordinate);
> =20
> +static ssize_t cxl_unmask_sbr_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +
> +	return sysfs_emit(buf, "%u\n", pdev->cxl_unmask_sbr);
> +}
> +
> +static ssize_t cxl_unmask_sbr_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	unsigned long val;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	pdev->cxl_unmask_sbr =3D !!val;

[Severity: High]
Does writing to this bitfield without synchronization risk corrupting adjac=
ent
state flags in struct pci_dev?

Modifying a C bitfield is a non-atomic read-modify-write operation on the
containing 32-bit word.

If a user writes to this sysfs file while the kernel concurrently modifies
other flags sharing this word (like is_busmaster, msi_enabled, or
state_saved), could this silently overwrite those updates?

> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(cxl_unmask_sbr);

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
[ ... ]
> @@ -485,6 +485,7 @@ struct pci_dev {
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
>  	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
> +	unsigned int	cxl_unmask_sbr:1;	/* SBR unmask allowed by user */
>  	/*
>  	 * Devices marked being untrusted are the ones that can potentially
>  	 * execute DMA attacks and similar. They are typically connected

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825022628.3651=
434-1-fabio.m.de.francesco@linux.intel.com?part=3D12
