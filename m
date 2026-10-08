Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E877358399;
	Thu,  8 Oct 2026 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440855; cv=none; b=XtUXtJbaZ0TCE3xqSzPohFsNsf+4VI7PMqXkLw87FpXIapeEAx34NmReehR6ceckvwFzuykK6cGcc5s9jhh39NFjxqNC0OT389TADaKGTx693Fd8OQA38/AiRIMs1EAX/b12L7rT86nt4naJ+Rek4c4+jZuhwQcKT/aHyn7ok9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440855; c=relaxed/simple;
	bh=mBy2JhOEuj40P2YGHU9GBpWVnW5NjDCZcFjmAa0Mq/w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=s0zcQPDKggepUGoLWM48DjlTK+dTBo3HFNBa+sjNzXIic+v5QFaW5OY90/TaNrXIgEctAu9PNhra50a6uUP72A/iKg9vA8vpx20JLnzHrY0E+ljDp9qN9C2FEntYKyMUchkQEFIddRiE2syLz4pVpDU5As3Q9ZIWoxaPCvivGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCK1N0qc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCK1N0qc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ADA1F000FF;
	Thu,  8 Oct 2026 06:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791440853;
	bh=kaXUNmFO4lZZpuxEWJtvmB5GYF67+4/om5dYP42E350=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bCK1N0qcTbW0N02392MbaL3i8AMRy1KsTc8AVND9pExx6GTjIhmW852HiTPo1W+ox
	 HwSY0cuQVpoSWjtGCwBhxNo3BjvylvceW3r3n2zuIZOA48qqg9F0dZZRGp+gDldmjT
	 ovRdezQQGAJrAYgoQpbO1pP/oOD+DGUNS+OddhML4gIBNnWhq7hcpVEYdcBW3LVuMr
	 w2bnWerZyHLgzgvlQLxpwttyy/7xAy0qB9o17GbeyG0zBvQWjapuNMfxqBYQpp25w0
	 eZSp2zTG3KRz84lQI5uFPU688h7D71cxJdOp+VsKlXTVcdeLFjTdl7xSkbx4waHYaF
	 lMTOE+ClPfaUw==
Message-ID: <sashiko-outbox-163691@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/16] KVM/vfio: Use file-based reference counting
 for KVM
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261008055955.4014342-5-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-5-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:27:33 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vfio: premature KVM reference release on failed cdev bind
--

commit 3b919032adda2d9cc906ebc24555fad4223ad7c1
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM/vfio: Use file-based reference counting for KVM
   =20
Replace manual module reference counting with file-based reference
counting for KVM integration. Pass struct file pointers instead of
struct kvm pointers throughout the VFIO-KVM interface, leveraging the
kernel's existing file reference counting.

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 423ead48aafe3..ed96acfa86358 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -511,14 +489,7 @@ void vfio_device_put_kvm(struct vfio_device *device)
>  	if (!device->kvm)
>  		return;
> =20
> -	if (WARN_ON(!device->put_kvm))
> -		goto clear;
> -
> -	device->put_kvm(device->kvm);
> -	device->put_kvm =3D NULL;
> -	symbol_put(kvm_put_kvm);
> -
> -clear:
> +	fput(device->kvm);
>  	device->kvm =3D NULL;
>  }
>  #endif

[Severity: High]
Does this code introduce a regression where the globally shared
device->kvm reference is prematurely released on a failed cdev bind?

Looking at drivers/vfio/device_cdev.c:vfio_df_ioctl_bind_iommufd(), if a
secondary cdev open attempts to bind, it can fail because
device->open_count !=3D 0:

	vfio_df_open(df);
	if (ret)
		goto out_put_kvm;
...
out_put_kvm:
	vfio_device_put_kvm(device);

Unlike the group path which checks if device->open_count =3D=3D 0, this cdev
error path unconditionally drops the device->kvm reference via
vfio_device_put_kvm(device). This drops the reference belonging to the
primary opener and clears the pointer to NULL.

When the primary opener eventually accesses KVM (or when it closes the
device), the driver skips unregistering the device from KVM, or relies
on a raw pointer (e.g., matrix_mdev->kvm) to a KVM VM that may have
already been freed. Can this regression result in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D4
