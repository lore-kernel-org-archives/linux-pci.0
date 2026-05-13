Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453B1991D4
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 04:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778646231; cv=none; b=UYrLwopfH6W/Mx4apSJkcj+4CNWMibVqJAvJLNvB+jsPAXcZKTFcY/XhDFT8/7gYptq+trJucimIMXMBjZKVcUNVlwDkvknl4i2JjQFBO1ivbTIO8pag9DTbj2iekS0gRoZkvVesm9sW+jwlOnrmr/oCB6S6MLcBP9Sg/+LcAbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778646231; c=relaxed/simple;
	bh=ro5+Yk3HVUhWn8k3i/8lG98FIk5Y+g6578q+vFiBAxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qo82nVFTasZd8TXP76nuIUzuGkL1k1Mbnjd/n6zXxruQm3Pf4h9PtA32qMuHNbVAaOmdbIsAa7YYn4ic3oDOQLzqcczAy8dhkrtyLfoDI+gnFg0bZIiHzrcJGpYVUtJsNDLYcFDTwxMvA6zOlMeLr0E7sqiWFxD14Nn6VfWr72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7w35laH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7w35laH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345FBC2BCB7;
	Wed, 13 May 2026 04:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778646231;
	bh=ro5+Yk3HVUhWn8k3i/8lG98FIk5Y+g6578q+vFiBAxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=n7w35laHB0k4Ip/p/0zhtZzWj5SWQJofvqPzWOE35MpGWztsLgiH+YteaywZPIxQF
	 K12MMesLCbetXBVayqWMvsiiarnFUD0ghMwTHBRftPLzAAz7THHOz5qj8yc1HL2kWe
	 Wjh+v3OnMAjHHoa7e+W6SgZFPv/ExrHfRp/KOXoS2oZ+0oyRjN9FTW0B/xbwpStkaG
	 h7ohJsArmLyXM12p6vn6NuMgQNjUxN/d47BIUD9qu4ZkpFsXWtO+x/PeTE5XsNzr9e
	 4YxJ4/YnPMGtiMY1Zr5qp/VYrEXlBwRfgfmQqnegguYkNLD/HudFxhEVb6vAQBJDPM
	 rSWq8M1mE+Ndg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/16] vfio/pci: Retrieve preserved device files
 after Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511234802.2280368-4-vipinsh@google.com>
References: <20260511234802.2280368-4-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 04:23:50 +0000
Message-Id: <20260513042351.345FBC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] vfio_pci_liveupdate_can_finish logic error permanently leaks prese=
rved KHO memory and wedges the session.
- [High] TOCTOU race in vfio_pci_liveupdate_freeze allows device reset whil=
e interrupts are active.
--

commit aeb30af9099697f73a40eb35a514bc4eaae76916
Author: Vipin Sharma <vipinsh@google.com>

vfio/pci: Retrieve preserved device files after Live Update

This commit implements the retrieve() and finish() file handler callbacks f=
or
VFIO, enabling userspace to retrieve preserved VFIO device files after a Li=
ve
Update.

> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vf=
io_pci_liveupdate.c
> index 5cc57bf39dbee..9142aaea94f2d 100644
> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c

[ ... ]

> @@ -203,13 +210,53 @@ static int vfio_pci_liveupdate_freeze(struct liveup=
date_file_op_args *args)

[ ... ]

> +static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_arg=
s *args)
> +{
> +	return args->retrieve_status > 0;
> +}

Will this permanently leak preserved KHO memory and wedge the session if
retrieval fails or is never attempted?

If the Live Update Orchestrator (LUO) sets retrieve_status to 0 (userspace
never attempted retrieval) or to a negative error code (retrieval failed),
can_finish() will evaluate to false.

This will cause the LUO core's luo_file_finish() routine to abort with -EBU=
SY,
bypassing the finish() callback and leaking the KHO memory allocated for
args->serialized_data.

>  static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *a=
rgs)
>  {
> +	kho_restore_free(phys_to_virt(args->serialized_data));
>  }
> =20
>  static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops =3D=
 {
> @@ -218,6 +265,7 @@ static const struct liveupdate_file_ops vfio_pci_live=
update_file_ops =3D {
>  	.unpreserve =3D vfio_pci_liveupdate_unpreserve,
>  	.freeze =3D vfio_pci_liveupdate_freeze,

I realize this problem wasn't introduced by this patch, but existed in the
immediately preceding patch in the series.

Is there a TOCTOU race in vfio_pci_liveupdate_freeze() that allows a device
reset while interrupts are active?

vfio_pci_liveupdate_freeze() reads vdev->irq_type to verify that interrupts
are disabled:

    if (vdev->irq_type !=3D VFIO_PCI_NUM_IRQS) {
        pci_err(pdev, "Freeze failed! Interrupts are still enabled.\n");
        return -EINVAL;
    }

It does so without holding vdev->igate, which is the lock that protects VFIO
interrupt configuration.

Could a concurrent VFIO_DEVICE_SET_IRQS ioctl acquire vdev->igate, enable
interrupts, and update vdev->irq_type immediately after the safety check in
freeze() passes?=20

freeze() would then acquire vdev->memory_lock and proceed to reset the PCI
device while interrupts are unsafely active, potentially leading to interru=
pt
storms or state corruption.

>  	.retrieve =3D vfio_pci_liveupdate_retrieve,
> +	.can_finish =3D vfio_pci_liveupdate_can_finish,
>  	.finish =3D vfio_pci_liveupdate_finish,
>  	.owner =3D THIS_MODULE,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511234802.2280=
368-1-vipinsh@google.com?part=3D3
