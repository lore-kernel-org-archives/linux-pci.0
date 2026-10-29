Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292832;
	b=vL58MIQdinkgBYuhrOKt+Lu+hQNEVDcj6fr5KE76Uo0/6JtbKWISIsbdYAE4sUAPLk1v
	 sFqwx6buPczWSNPRjnNOJy4yx4fom36ZIYgAW4bMYkVr1XCo45zS6yrCkWNSZTtVZfOkU
	 eJJfQrAeaMZUUvTUsJPn8lJmMYBc6ZRKQEP4TPzcX9fZKALSAg3WCH4pKMeLtBeYad4F5
	 QdsbXDJFfwT6owCVZCF3DLC0tcK2cIr6YSKP5k0Huc0RH4AEsUd74TN3VVI8kqNi30YEs
	 9Qh8lv5CYkrmJ81LO7rSJvVIfb5znna2JCiVGWzAZD9R7n72OnITkcCVSSDZ4vD2aCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292832;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YnefHGR4J8FUT+Kq7qynNk1gx0FphK44YRHzRuPzOOk=;
	b=2Sp0089ujzytzrn9XTZEqRleeNk0gOsTRoVCguHzmQ58tpnU6eMJV/aIdjKaWkxr7V2r
	 CVV0yP5ZWb2TYMkdWpl+MHZUp4MUlAMG/2GiS9SZa2J6GKul+TibIf7jpYgDNd0WPalrh
	 PBWaimWvCqlA6T77q9NzLaxLPk+bw39+W2Xig6fFGlzHlBNXSQ0QwQT8o0WTIWvcA/7Tl
	 RO854a7UHBipx09/LXEkKnvEAt2og+47oqrt2RRnOlDReEKpPQK3Hw/DhWcMSzJFxTYOF
	 JaPYKBdAQj5FJh318LdTU3s0Ab9hzFciwiihpOEUaFaVOhAkATn7Lj++k8cm1bNKAcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hu4uf0gJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC6606A31A;
	Thu, 29 Oct 2026 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hu4uf0gJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98841F01824;
	Thu, 29 Oct 2026 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292832;
	bh=YnefHGR4J8FUT+Kq7qynNk1gx0FphK44YRHzRuPzOOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hu4uf0gJCR+JeMEhu6yJFO2y2UI5Kr8F6Pu0YkJ6wV5k6DfZbEOzNfMoEOcuVxe17
	 97WqXjV38vgS6/u2d8rzOIkLoonDtGbFGpmZVjBaZuWIQslrr6l9FcJkV5zMHSRvRr
	 244kpza+YQglddHii2//CQSWoVPfsjXMe0od7pT6jlVzgWD4Uq4755uSyPQhtJ+PTa
	 XXINgC6Cn09RqdRAlnz+mSXMF4zkM04cg/WRNfKo8ubnjxWREHKEmhlcFiu9Oq8N9j
	 K44hdSJX4o8E8iG9xEIBAFTgpqLIzB8BYTfJvUnGcF224FngImejDkB/tqK2Q1Cuxb
	 CDkgKfcNTDnnQ==
Message-ID: <sashiko-outbox-189688@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] vfio: add helper to find PCI device by
 vendor/device ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261029163713.1366077-2-jtornosm@redhat.com>
References: <20261029163713.1366077-1-jtornosm@redhat.com>
 <20261029163713.1366077-2-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:53:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] vfio: unreferenced vfio_device return in vfio_file_find_pci_de=
vice()
- [High] vfio: broken cdev lookup in vfio_file_find_pci_device() when !VFIO=
_GROUP
- [Medium] vfio: ambiguous device lookup by vendor/device ID in vfio_file_f=
ind_pci_device()
--

commit df00c747a1dfff6dd20e305bf98f78e19636f45e
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

vfio: add helper to find PCI device by vendor/device ID

This commit adds vfio_file_find_pci_device() and vfio_file_device() to allow
other subsystems to locate a VFIO-owned PCI device by its vendor and device
IDs from a VFIO group or cdev file descriptor.

> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index 185f359f75d38..0b6cf90edda30 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
[ ... ]
> @@ -894,6 +895,46 @@ bool vfio_file_has_dev(struct file *file, struct vfi=
o_device *device)
>  }
>  EXPORT_SYMBOL_GPL(vfio_file_has_dev);
> =20
> +struct vfio_device *vfio_file_find_pci_device(struct file *file,
> +					      u16 vendor, u16 device_id)
> +{
> +	struct vfio_group *group;
> +	struct vfio_device *vdev;
> +	struct vfio_device *ret =3D NULL;
> +
> +	group =3D vfio_group_from_file(file);
> +	if (group) {
> +		mutex_lock(&group->device_lock);
> +		list_for_each_entry(vdev, &group->device_list, group_next) {
> +			struct pci_dev *pdev;
> +
> +			if (!dev_is_pci(vdev->dev))
> +				continue;
> +
> +			pdev =3D to_pci_dev(vdev->dev);
> +			if (pdev->vendor =3D=3D vendor &&
> +			    pdev->device =3D=3D device_id) {
> +				ret =3D vdev;
> +				break;
> +			}

[Severity: Medium]
What happens if a VFIO group contains multiple PCI devices or functions
with the same vendor and device IDs (for example, two identical cards
behind a PCIe switch or bridge without ACS isolation, or a multi-function
device with identical function IDs)?

Since this loop matches only on vendor and device_id and breaks on the
first match in group->device_list without BDF/devfn disambiguation or
checking whether the device is opened by the VM, could this return an
unopened sibling device in the same group or cause multiple assigned
devices to resolve to the first entry in the list?

> +		}
> +		mutex_unlock(&group->device_lock);
> +		return ret;
> +	}

[Severity: Critical]
Can returning ret here after dropping group->device_lock lead to a
use-after-free of struct vfio_device and vdev->dev in the caller?

Unlike a VFIO device file, which holds a registration reference until
vfio_device_fops_release(), an open VFIO group file only pins struct
vfio_group and does not hold a reference on the struct vfio_device entries
in group->device_list. Existing group list lookup code in
drivers/vfio/group.c acquires a reference while holding group->device_lock:

drivers/vfio/group.c:vfio_device_get_from_name() {
	...
		if (ret && vfio_device_try_get_registration(it)) {
			device =3D it;
			break;
		}
	}
	mutex_unlock(&group->device_lock);
}

If the matched device in the group does not have an open device fd (or its
device fd is concurrently closed while the group fd remains open), a
concurrent driver unbind or hot-unplug via:

vfio_pci_remove()
  -> vfio_pci_core_unregister_device()
    -> vfio_unregister_group_dev()
      -> vfio_device_group_unregister()
      -> vfio_device_put_registration()
  -> vfio_put_device()
    -> vfio_device_release()
      -> kvfree(device)

can remove vdev from group->device_list and free it as soon as
mutex_unlock(&group->device_lock) is called. Should this acquire a
reference on vdev before unlocking and provide a corresponding put helper
for callers?

[ ... ]
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 0cc91c6f96d2b..a62fbf42458a4 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -364,6 +364,8 @@ struct iommu_group *vfio_file_iommu_group(struct file=
 *file);
>  #if IS_ENABLED(CONFIG_VFIO_GROUP)
>  bool vfio_file_is_group(struct file *file);
>  bool vfio_file_has_dev(struct file *file, struct vfio_device *device);
> +struct vfio_device *vfio_file_find_pci_device(struct file *file,
> +					      u16 vendor, u16 device_id);
>  #else
>  static inline bool vfio_file_is_group(struct file *file)
>  {
> @@ -374,10 +376,18 @@ static inline bool vfio_file_has_dev(struct file *f=
ile, struct vfio_device *devi
>  {
>  	return false;
>  }
> +
> +static inline struct vfio_device *vfio_file_find_pci_device(struct file =
*file,
> +							    u16 vendor,
> +							    u16 device_id)
> +{
> +	return NULL;
> +}
>  #endif

[Severity: High]
Will vfio_file_find_pci_device() work for cdev-based device files when
CONFIG_VFIO_GROUP is disabled and CONFIG_VFIO_DEVICE_CDEV is enabled?

Because vfio_file_find_pci_device() is defined in drivers/vfio/group.c and
stubbed to return NULL when !CONFIG_VFIO_GROUP, the vfio_file_device(file)
cdev lookup path is never compiled in a cdev-only kernel configuration
(and symbol_get(vfio_file_find_pci_device) callers will not find the
exported symbol).

Should vfio_file_find_pci_device() be placed in drivers/vfio/vfio_main.c
and declared unconditionally in include/linux/vfio.h alongside
vfio_file_is_valid(), vfio_file_enforced_coherent(), and
vfio_file_set_kvm()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029163713.1366=
077-1-jtornosm@redhat.com?part=3D1
