Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E013B27DB
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778703233; cv=none; b=r0Fa+jRZhjeOsKFDWxysNsnFwUWqniC7i97Z8BFztFPt3qUFdZ7HdjWJ3enwbRSyhCiMsdNG5lq8cxuezqLu1yhDRt5Oa+5cbGnPutLA6YghOFDQwukAjDh3N75OqhGgnKI1KXfg5w42Oev4eUY3M/FSPlANwdYHTl/S4QdC4uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778703233; c=relaxed/simple;
	bh=jbFOfTYJ4Tvs3Ti3bdcURbv0Q2AKgX8YQHYOupWGNgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hhwGaC4jZ/ukIxRXVkqQwnJI8PyQMjdoKtHs+cbtaMcj5FH7FkjfKm0wmj7L7upx1a61R9C6D+DqPkZMCQ6Kf+pJgEASUJsyIsHsObB/q9x0I8L8XaIhMc5enZtfWwZaKI6eTHRkoozwWG3da4xK7gVGetS0w2gsrwHTBUq6NJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJIdFr1r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJIdFr1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACB9C19425;
	Wed, 13 May 2026 20:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778703233;
	bh=jbFOfTYJ4Tvs3Ti3bdcURbv0Q2AKgX8YQHYOupWGNgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EJIdFr1rpoKkd+O+hbs4eqEgL404gjL1ewvdnbW+OfvQ6AMHxASPafp6y6TwrFuyi
	 yKtfegg4noBLZGDRvs5YFglYoTjI1vpUvWat78TOk7t8/yP5YO+YFkLobc/NBN27bK
	 al2aMbdHeQ368zeFvvgYgSjC/h88Z7683Xhwmc1cjdFJw49uxDbdwIqQpijfnD1cR/
	 GttA/KIMJLYQDuDxj9pKyfChYsdt58Fzv+g3H6JRMm0SdzVTEGoYwcI4RfEs29SsBb
	 DGroIy8/FbheVetjhn25kVGEriH6rOA9p8M0VqEdrZH6fpbL3mUIR4u8ShiNlPHB72
	 3wbHWiMVlvB0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/16] vfio/pci: Store incoming Live Update state in
 struct vfio_pci_core_device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511234802.2280368-7-vipinsh@google.com>
References: <20260511234802.2280368-7-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:13:52 +0000
Message-Id: <20260513201353.6ACB9C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing cleanup of `liveupdate_incoming_state` on error paths and =
device closure
- [High] Data race on `liveupdate_incoming_state` modification
--

commit d8de06a6f6edeb0c9ca334c98f9b961bfa08a639
Author: David Matlack <dmatlack@google.com>

vfio/pci: Store incoming Live Update state in struct vfio_pci_core_device

This commit adds a pointer to the incoming Live Update state in struct
vfio_pci_core_device. It modifies vfio_pci_core_enable() to clear this
pointer on the success path to signal that the state has been consumed.
It also updates vfio_pci_liveupdate_can_finish() to wait for this pointer
to become NULL under the dev_set lock.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 1726d4d41b579..da013b4b1e94d 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -568,7 +568,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device =
*vdev)
>  	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>  		vdev->has_vga =3D true;
> =20
> -
> +	vdev->liveupdate_incoming_state =3D NULL;
>  	return 0;
> =20
>  out_free_zdev:

If device enablement fails and the code jumps to an error label like
out_free_zdev, liveupdate_incoming_state will not be cleared.  Will this
cause vfio_pci_liveupdate_can_finish() to stall indefinitely waiting for
this pointer to become NULL?

Additionally, if the orchestrator times out and frees the KHO memory,
could this leave a dangling pointer that results in a use-after-free on
subsequent attempts to open the device?

> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vf=
io_pci_liveupdate.c
> index 731a3e34085fb..7b841a1e7fcc5 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
[ ... ]
> @@ -265,6 +266,9 @@ static int vfio_pci_liveupdate_retrieve(struct liveup=
date_file_op_args *args)
>  		goto out;
>  	}
> =20
> +	vdev =3D container_of(device, struct vfio_pci_core_device, vdev);
> +	vdev->liveupdate_incoming_state =3D ser;

The commit message states "This is synchronized by vfio_pci_core.c setting
vdev->liveupdate_incoming_state to NULL under dev_set lock once it's done
using it."

However, the assignment here does not appear to take device->dev_set->lock.

If userspace triggers this retrieve operation concurrently with device
enablement, does this create a data race?  An unprotected write here
could clobber the NULL value just set by a successful device enablement,
leaving the pointer non-NULL and causing vfio_pci_liveupdate_can_finish()
to wait forever.

> +
>  	args->file =3D file;
>  out:
>  	/* Drop the reference from vfio_find_device() */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511234802.2280=
368-1-vipinsh@google.com?part=3D6
