Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E683BED56;
	Thu,  8 Oct 2026 06:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440432; cv=none; b=DMV9nJbVHl8s34T7fhKdSu0cSTRbSEuBbZ4FqMRhxsB149X+SaRezsBym4xfAbucG2rG7Qv/kfaEUyel9LqYEHld3vLfe0FEVr7OuLoVIzcjB7Bdr7/6is/VPg4uIHBkfkNQ/zI71KW3oPnzUNCPwpHzfoCmVWlPAD1jIVx1ZWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440432; c=relaxed/simple;
	bh=gBUuFQhgphrRfJWIfqfrMUhycKc0sK7cMA4Tj/I7exE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=paJDG0L5ZuxBLWbzCgIuHZrA0aYedqffdCIsTPKOKuvpWEqePSEhhXBKpGhVndFyH9VIqPtGNo7Xf74AJuMKirXkZctsZ69Dik3XCgxBctX8IP/NLZsxy//Ti+Un0n0xTQ+XKgGBDZ4QKJbZSA0TimDQSEqje/BwiVflbmG8BRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxoeIqRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxoeIqRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C361F00893;
	Thu,  8 Oct 2026 06:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791440431;
	bh=BJFiMdZnnY0evqKl56gl6UqxcAfdaoU10h40yy0BmzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OxoeIqRuAFPU+d2o42w1vM0q4sJrmhbevmPqrC5qFQlOyeZmggiBqdBJZOwG6jaDj
	 Cy+mAAvC6ML4jLMj/cyoAKlKmNuztLW+RCoOU52yr4lMmE/ISLwaGVbzXZ8PmsDakv
	 jQeKn+hTiusVPaewsR/hsLkVv8v9eFxlPSlqmV0eOYCzi9cMkm0C2Z2prGa/i0NONm
	 LIqhfFmYIv47VJ5NC9Ie+fb8dHak7lonCx2/5qtspC3xHKtQAp6TaucaP23KaQ2bSN
	 aTD8S78zdlkNEc35MAJz+JMgA7+jn+nPAzUQnqKBZ2QNDmH7NkjcjSFZuy8hbqxihW
	 IKqSne9tst5sQ==
Message-ID: <sashiko-outbox-163681@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/16] iommufd/device: Associate KVM file pointer
 with iommufd_device
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261008055955.4014342-8-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-8-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:20:30 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] iommufd: UAF of kvm_file due to iommufd_device outliving VFIO unbi=
nd
--

commit ddde31c06624779bad69fb77ae7b9503b553dacc
Author: Shameer Kolothum <skolothumtho@nvidia.com>

iommufd/device: Associate KVM file pointer with iommufd_device

TSM vDevice support needs access to the KVM associated with a VFIO device
after the device has been bound to iommufd. Extend iommufd_device_bind() to
accept the device's KVM file and store it in the iommufd_device.

> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/devic=
e.c
> index a664c70a6fe73..f99f7bee2e774 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
[ ... ]
> @@ -308,7 +309,9 @@ static int iommufd_bind_noiommu(struct iommufd_device=
 *idev)
>   * The caller must undo this with iommufd_device_unbind()
>   */
>  struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> -					   struct device *dev, u32 *id)
> +					   struct device *dev,
> +					   struct file *kvm_file,
> +					   u32 *id)
>  {
>  	struct iommufd_device *idev;
>  	int rc;
> @@ -319,6 +322,8 @@ struct iommufd_device *iommufd_device_bind(struct iom=
mufd_ctx *ictx,
> =20
>  	idev->ictx =3D ictx;
>  	idev->dev =3D dev;
> +	/* VFIO holds the file reference while the device is open. */
> +	idev->kvm_file =3D kvm_file;

[Severity: High]
Does this code introduce a use-after-free regression for kvm_file when a
concurrent ioctl is accessing the device?

If an untrusted user thread executes an ioctl that calls iommufd_get_device=
(),
it will increment idev->obj.users to 2.

If another thread concurrently closes the VFIO device fd, it calls
vfio_df_unbind_iommufd() which leads to iommufd_device_unbind() and then
iommufd_object_destroy_user().

Because users is 2, iommufd_object_remove() will return -EBUSY:

drivers/iommu/iommufd/main.c:iommufd_object_remove() {
        ...
        if (!refcount_dec_if_one(&obj->users)) {
                ret =3D -EBUSY;
                goto err_xa;
        }
        ...
}

The unbind operation ignores this error, leaving the idev alive:

drivers/iommu/iommufd/iommufd_private.h:iommufd_object_destroy_user() {
        ...
        ret =3D iommufd_object_remove(ictx, obj, obj->id, REMOVE_WAIT);
        WARN_ON(ret);
}

The VFIO device then drops its KVM reference during the close process, free=
ing
the kvm_file. When the first thread resumes, will it access the freed kvm_f=
ile
stored here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D7
