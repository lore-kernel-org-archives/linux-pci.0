Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0549A54A7CD;
	Tue, 29 Sep 2026 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704295; cv=none; b=nE7EhOj+j9IB7Z0v8BZAOB97nRbiFXh0Nvzgmt0UQqzN2pLrhWqmGjthpIxv7Gb0xxZPHdW8182LTPy90oaCGqsniyVZskYlqcIFL2bRGb4TC6CiXUbbVdkKWoGODcbNw+Dh708SKe1H2bcC9hKigyotHnh3reRqT8yaxFsS4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704295; c=relaxed/simple;
	bh=7PigMz/SjXJFUZzXgfFifGRrZ2xo3StMSwMAty9Oezg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UO6wLUISrgbpZEgnJ43kj3gzodvyJOv5Iu6NA+4cpg9qOyIRxU7Gt5eOErjIlQmBP/jnpsHM1/MV+x15VVN3EgoG3DBQxiPT1nFazve0dTVvGBmk1mGygyk7RlQmTYT7a+1p6MbJylGPmgtb3PG74uLb3QFVbvi2hr2KCmsosRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7EF6uDC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7EF6uDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605B51F00893;
	Tue, 29 Sep 2026 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704293;
	bh=14+QWNba9sXjAEe6Nuh+3Ihp0wHQPzmYPpEvS7f3IZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K7EF6uDC7lCFeVj3f8h4iHnSR1MFuGOMFKFg5CuyMYnyeXNex5o/ChkVA601NFX//
	 CR7osJVeqmeCqTyDVEitPkVjzJ3odn7b8JmssTeJsw2iGAxLYjrrpPt/KBu7ij5X8e
	 5Fc4ymQ+NCh3Ygs6BP7hO8HyLPtRNSkFMMx2IzW1Ys88Mm+7MyLaZzA+vB+vZvKTKx
	 hJ6hY3jHpUT2WJK0zUl8Eal5ugPUw721+JoueIJ60BzpaOhFmGuKSlrg7VEozx7hdo
	 q0oZs4sbWydai/Ez46BIVplKWZo4HkoJTd5mKTIRvD8jNaxLYk1nXScpmI1MyQC9nv
	 YgwaIUVo8SYyg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 14/16] vfio/pci: Block device access during host
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260929173305.204856-15-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-15-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:51:33 +0000
Message-Id: <20260929175133.605B51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] cleanup: vfio_pci_core_enable() mixes goto and scoped_guard()
--

commit 054f5c9b3c995b5b332595d9db5677b803d39ed9
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Block device access during host recovery

This patch extends error_detected() to block device access during host
recovery by draining existing SRCU readers. It also masks INTx, revokes
BAR mappings, and manages the host transaction state across device open
and close.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index d6cc34240b250..2ec8022e4a692 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -617,6 +617,15 @@ int vfio_pci_core_enable(struct vfio_pci_core_device=
 *vdev)
>  	u16 cmd;
>  	u8 msix_pos;
> =20
> +	if (vdev->pci_recovery_supported) {
> +		if (pci_dev_is_disconnected(pdev))
> +			return -ENODEV;
> +		scoped_guard(mutex, &vdev->access_lock) {

[Severity: Low]
Does this mix scope-based cleanup with goto-based error handling in the same
function?

The cleanup subsystem guidelines in include/linux/cleanup.h state that goto
and cleanup helpers like scoped_guard() should never be mixed in the same
function to prevent ownership confusion. For a given routine, the expectati=
on
is to convert all resources that need a goto cleanup to scope-based cleanup,
or convert none of them.

Looking at vfio_pci_core_enable(), the function still relies heavily on
legacy goto cleanup labels (like out_disable_device: and out_power:) on its
error paths.=20

Should this function be fully converted to scope-based cleanup first, or
should this new lock acquisition continue using the traditional lock and
unlock pattern to match the rest of the function?

> +			if (vdev->pci_recovery_host_active)
> +				return -EBUSY;
> +		}
> +	}
> +
>  	if (!vdev->disable_idle_d3) {
>  		ret =3D pm_runtime_resume_and_get(&pdev->dev);
>  		if (ret < 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D14
