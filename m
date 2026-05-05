Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA132C937
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778021786; cv=none; b=TLAbA6qR/WXUhOggCP0FZ6iTbD95MgElGgeSdcYgZff/1gsTQfxt5TLFnPVWiW4RMlCAVDZ+mBEFkhN28z2eXOaIeFPb9f8kgv3Nm+o8fGMBJYxDqLJCM7B9IiYjeV0iO2hhSw5ejHn/499GtsizajurW25AS/AlBbAkw/EWStU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778021786; c=relaxed/simple;
	bh=s78riUYH4omGMoo57Ve3BIq7OJE5YbXIBLS7N7pyIpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eOBaFgrj52smKX0OsMHNFP11rFzzt6GY5ZCLXz3IkmdkSOvtCbvxV0sx+42JWX43pIlJ4zQZQduu+QCZVLpeSbWim4uR6zvrD9eLvIy3BC9aZ4rjpDzlWdXeyz1NSnlPcVRT7YU8X6zDiXQihMUtNrWwN9lOFJj7uNx5vxD/mOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp0XEbbF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp0XEbbF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC00C2BCB9;
	Tue,  5 May 2026 22:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778021785;
	bh=s78riUYH4omGMoo57Ve3BIq7OJE5YbXIBLS7N7pyIpA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kp0XEbbFhF/BAWJ1gLZm+mq0TRgfqKgqqu+oU/nCpD4/0G+tgbMqZVtpvZbCA/G/l
	 lJHGO2FH/XqujgCX5xe/RjR4TrwEKZlcE+XlGKnMx3pM4bGCL2e2o133rQJQfKp86g
	 tca8JX0Azw+d1IArr+80/oeQIFfFVMNFqIussTMulpGeHSwxAJh7VVzw/uzlBp6oaH
	 bK163+Sg5J7dVNbXhK6U79Ip2+YCuH+O2I0CVp4QzXYFJmK3IsrzPRINJucKfRMYuC
	 0bYTSSxqx94rJWgPIBURhJraUgVU7qcHPdZOLtHmybHZY784uHfu0kNQnaWu5PVkAH
	 AmXIKXvsRWovg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 4/7] s390/pci: Store PCI error information for
 passthrough devices
Reply-To: sashiko@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505200510.2954-5-alifm@linux.ibm.com>
References: <20260505200510.2954-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 22:56:25 +0000
Message-Id: <20260505225625.ADC00C2BCB9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The mediated recovery feature for non-KVM passthrough devices is g=
ated by a KVM-dependent Kconfig option, causing it to be compiled out and f=
ail when KVM is disabled.
- [High] A time-of-check to time-of-use (TOCTOU) race condition exists in `=
zpci_event_attempt_error_recovery` regarding the `mediated_recovery` state,=
 leading to permanently broken passthrough devices.
- [Low] Missing trailing newline (`\n`) characters in `pr_err()` and `pr_in=
fo()` format strings.
--

commit b20dbe013c9c596d29efb7c91a62d8992eaf33b9
Author: Farhan Ali <alifm@linux.ibm.com>

s390/pci: Store PCI error information for passthrough devices

This commit modifies s390 PCI error handling to store error information for
passthrough devices. This allows userspace drivers like vfio-pci to manage
device recovery directly, removing the dependency on a KVM file descriptor.

> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -81,6 +52,46 @@ static bool is_driver_supported(struct pci_driver *dri=
ver)
[ ... ]
> +static void zpci_store_pci_error(struct pci_dev *pdev,
> +				 struct zpci_ccdf_err *ccdf)
> +{
> +	struct zpci_dev *zdev =3D to_zpci(pdev);
> +	int i;
> +
> +	guard(mutex)(&zdev->pending_errs_lock);
> +	if (!zdev->pending_errs.mediated_recovery)
> +		return;
> +
> +	if (zdev->pending_errs.count >=3D ZPCI_ERR_PENDING_MAX) {
> +		pr_err("%s: Maximum number (%d) of pending error events queued",
> +		       pci_name(pdev), ZPCI_ERR_PENDING_MAX);

Is this missing a trailing newline (\n) in the format string?

> +		return;
> +	}
> +
> +	i =3D zdev->pending_errs.tail % ZPCI_ERR_PENDING_MAX;
> +	memcpy(&zdev->pending_errs.err[i], ccdf, sizeof(struct zpci_ccdf_err));
> +	zdev->pending_errs.tail++;
> +	zdev->pending_errs.count++;
> +}
[ ... ]
> +void zpci_stop_mediated_recovery(struct zpci_dev *zdev)
> +{
> +	guard(mutex)(&zdev->pending_errs_lock);
> +	zdev->pending_errs.mediated_recovery =3D false;
> +	if (zdev->pending_errs.count)
> +		pr_info("Unhandled PCI error events count=3D%d for PCI function 0x%x",
> +			zdev->pending_errs.count, zdev->fid);

Does this pr_info() also need a trailing newline (\n)?

> +	memset(&zdev->pending_errs, 0, sizeof(struct zpci_ccdf_pending));
> +}
> +EXPORT_SYMBOL_GPL(zpci_stop_mediated_recovery);
[ ... ]
> @@ -216,12 +221,25 @@ static pci_ers_result_t zpci_event_attempt_error_re=
covery(struct pci_dev *pdev)
>  		goto out_unlock;
>  	}
> =20
> +	zpci_store_pci_error(pdev, ccdf);
> +
>  	ers_res =3D zpci_event_notify_error_detected(pdev, driver);
>  	if (ers_result_indicates_abort(ers_res)) {
>  		status_str =3D "failed (abort on detection)";
>  		goto out_unlock;
>  	}
> =20
> +	mutex_lock(&zdev->pending_errs_lock);
> +	if (zdev->pending_errs.mediated_recovery) {
> +		pr_info("%s: Leaving recovery of pass-through device to user-space\n",
> +			pci_name(pdev));
> +		ers_res =3D PCI_ERS_RESULT_RECOVERED;
> +		status_str =3D "in progress";
> +		mutex_unlock(&zdev->pending_errs_lock);
> +		goto out_unlock;
> +	}
> +	mutex_unlock(&zdev->pending_errs_lock);

Is there a time-of-check to time-of-use race condition here?

zpci_store_pci_error() checks zdev->pending_errs.mediated_recovery and
returns without storing the error if it is false. Later in this function,
we acquire pending_errs_lock again and re-evaluate mediated_recovery to
decide whether to skip host-level recovery.

If a concurrent userspace open of the VFIO device sets mediated_recovery to
true between these two checks, the error is discarded but the host recovery
is still skipped. Could this state be cached once under a single critical
section?

> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci=
_zdev.c
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -144,24 +144,36 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_cor=
e_device *vdev,
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct zpci_dev *zdev =3D to_zpci(vdev->pdev);
> +	int ret;
> =20
>  	if (!zdev)
>  		return -ENODEV;
> =20
> +	zpci_start_mediated_recovery(zdev);

The commit message states the goal is to support userspace drivers without
any KVM fd. However, does placing this logic in vfio_pci_zdev.c inadvertent=
ly
tie the mediated recovery feature to KVM?

Since vfio_pci_zdev.c is only built if CONFIG_VFIO_PCI_ZDEV_KVM is enabled,
if a kernel is configured without KVM, vfio_pci_zdev_open_device() resolves
to an empty inline stub. This means mediated_recovery would never be set to
true, and the host kernel would still attempt recovery on the passthrough
device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505200510.2954=
-1-alifm@linux.ibm.com?part=3D4
