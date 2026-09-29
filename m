Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5811544D60;
	Tue, 29 Sep 2026 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704130; cv=none; b=lUdpr2MzxFNFjBljl127Yx1AhY3Dw2CpyFDOUm+ODlLCMdwS51XuAClQQJ3MOsPwe1RW1T2UUbXbIh7NmF0OJgMFErYcTO8Ot8l52LZpvVDA6JQLGiukUaSxMck1qX3n6cfBG8MBtp8MlTOCE1RJuDvwjYBvwSq8eXD9pByGulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704130; c=relaxed/simple;
	bh=dvLjeSufS6j54UNBaF7Ctn0RNjfhpWmfvjSbcFxtlMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CPbufQ+KWjSrCwF1fbOwTaejh+3VgX4KLHw2REtAvHTShMtrxfumZBR6+EE8tdBhhI8oDBSknEnNOA7COUlv85M5F/03crCRvc0cP/2uE44/nnURsKm5W5N5rxRBfd91iF9pyHDy6hNaMjCt97CIsFrbtKh+8peeE1TOZK65B8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gda7WNSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gda7WNSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE6E1F000FF;
	Tue, 29 Sep 2026 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704128;
	bh=2BvN3XOcdZYklJcn02KCfi0KtcY4qclQ9jKnxKqNRpA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gda7WNSsP0SE0ZitJpRnRRMAs9dgXpNX5yQB3/R01R6+Iw9cOQa2EK8WTPnsAtYf/
	 eqG38hlH+7nEpLZ4pe4k7/q86kgD4Zms57r1zdzaBnD6FGZBA95998mxangSbGApR0
	 aGNtV7wYxWGdYZiX3d811sbdiHlpfFvVZ/97IFh4V7tZzL0u4CrJLzxbOSJsPppgiS
	 Q/YZgXQUawGFb6PHhpyLRr1OP9I90b2mpQmHSu43H1L0NMxBjW9EIlQKp89vKHqJO0
	 NGJ2vgrYXozvomD62y3KHXVEKsw3U7evDuqkrZZ4tPcmfLOc4AfpU21SGfdaL2VehC
	 S8RxnUxTYSscA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 15/16] vfio/pci: Add
 VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260929173305.204856-16-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-16-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:48:47 +0000
Message-Id: <20260929174848.2BE6E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vfio/pci: mixing goto-based cleanup and guard() in vfio_pci_reco=
very_set()
--

commit a042b1f42248620e0a4adaa43aee23e3f4d393dc
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Add VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY

This commit adds a device feature to enable host PCI error recovery and
query its status via VFIO.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 2ec8022e4a692..314d77868803c 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1752,6 +1752,111 @@ static int vfio_pci_core_feature_token(struct vfi=
o_pci_core_device *vdev,
>  	return 0;
>  }
> =20
> +/* Consumes the eventfd reference on both success and failure. */
> +static int vfio_pci_recovery_set(struct vfio_pci_core_device *vdev,
> +				 struct eventfd_ctx *ctx, bool enable)
> +{
> +	int ret;
> +
> +	guard(mutex)(&vdev->access_lock);
> +	if (!vdev->device_open) {
> +		ret =3D -ENODEV;
> +		goto out_put;
> +	}

[Severity: Medium]
Does this code mix goto-based error handling with scope-based guard()
cleanup?

Subsystem guidelines expect that a given routine should either convert all
resources that need cleanup to scope-based cleanup, or convert none of them.
Mixing the two in the same function creates confusing ownership semantics
that can lead to bugs during future modifications.

[ ... ]
> +
> +out_put:
> +	if (ctx)
> +		eventfd_ctx_put(ctx);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D15
