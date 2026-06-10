Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61364A1383;
	Wed, 10 Jun 2026 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106292; cv=none; b=gY4QQ+U5ZY07xCYDnm+QZN49yu7EPUd27LvrrJYg5gvhq/MnzggF9f2OHaB9pD6welow+XG1dyzfrea9rcsHE34l0JMfgK8f7CJH2EBVenxHFZosANCx6MtWLoVt0v1Jb9bdwW9TsNQpLmqzuPbCjQvFnK2jnmwC/v3ZIt3WUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106292; c=relaxed/simple;
	bh=SJkmwJnsJsgFZR56MAnLUocXLySyupmvXjHcrbFSQOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TUZ0ZYp3HxIT/PmQGNb4zuKYIqYjP37UqImqx9gqu/VHT6n9l+GSosU8JbGcVgn0lgGea1Da2OwY1LFEO5of3r032mAKWPYGC7shEHC/QWGGltDeDKbFONnOcCZ9l7MN7NlPZbKsDPNvKZPFtuxUaa1jsxLOWNanboAb/qcAzek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzDN+ljr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzDN+ljr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C82D1F00893;
	Wed, 10 Jun 2026 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106290;
	bh=n4ffuFAaWcxjzmHev317SCaNTBIPInHCC9h0Cdwloe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VzDN+ljrTdF1g5dQDIyrE69VHTgpdDr1rzJWhvLUNd4UE3yznoUM9jspu/sJ5txAq
	 HxTABeHSTAbdjgi7fHIs/9jHQIy2W1oK0XQyPRvt5Cb6nS26WDoA8sCpiYPJg5YCRW
	 Ea4i+KCourKn00JqMVbNbKO2du6KrhAFk2H+ktKuod012w1uksfnSQ07dzWDMuAdUf
	 7yolUvukXxOkQlN5pkzWWRXDqlScPjB9N6RNEFwiKMCiSRYPqBcKo59YQZSGg3jL+p
	 ZOJXYc2IaF2dNeAr0Bsf/CsQdN6byE5fcZc9QE0esDtvbca1SSYCjisZHozPk7nxix
	 D97rj9JuX4ixA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/5] vfio/pci: Block ZONE_DEVICE registration for
 BARs with active DMABUFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260610151853.3608948-5-praan@google.com>
References: <20260610151853.3608948-5-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 15:44:49 +0000
Message-Id: <20260610154450.0C82D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] vfio_pci_bar_is_dmabuf() is called without holding vdev->memory_lo=
ck, triggering a lockdep splat and causing a list traversal data race.
- [High] Time-of-Check to Time-of-Use (TOCTOU) race allows concurrent regis=
tration of both a native P2P resource and a DMABUF for the same PCI BAR.
- [Medium] Concurrent calls to vfio_pci_core_feature_p2p_register() can res=
ult in lost bit updates to vdev->p2p_registered_bars due to non-atomic read=
-modify-write.
--

commit 2c70089a882afbe16090c5204ddae6a5a5a6ab65
Author: Pranjal Shrivastava <praan@google.com>

vfio/pci: Block ZONE_DEVICE registration for BARs with active DMABUFs

This commit adds a check to ensure that a PCI region cannot be registered
for native peer-to-peer if it is already backing active exported dma-bufs.
It introduces vfio_pci_bar_is_dmabuf() to scan the device's active dma-buf
list and rejects peer-to-peer registration with -EBUSY if a match is found.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 9cf494b765e72..7913b8916df91 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1579,6 +1579,12 @@ static int vfio_pci_core_feature_p2p_register(stru=
ct vfio_pci_core_device *vdev,
>  	if (vdev->p2p_registered_bars & (1 << bar_index))
>  		return 0;
> =20
> +	if (vfio_pci_bar_is_dmabuf(vdev, bar_index)) {

[Severity: High]
Does this function call need to be protected by vdev->memory_lock?

Looking at the newly added vfio_pci_bar_is_dmabuf() helper, it asserts
that the memory_lock is held:

lockdep_assert_held(&vdev->memory_lock);

Calling it here unlocked will trigger a lockdep warning. Since it traverses
the vdev->dmabufs list, could this also lead to a data race or list
corruption if another thread modifies the list concurrently?

[Severity: High]
Could this lockless check result in a time-of-check to time-of-use race?

If vfio_pci_core_feature_p2p_register() and vfio_pci_core_feature_dma_buf()
are called concurrently for the same region, is it possible for one thread
to observe no active dma-bufs here, while the other thread concurrently
observes no peer-to-peer registration?

Both might proceed and commit their state, allowing the same region to
simultaneously back both exported dma-bufs and native peer-to-peer.

> +		pci_warn(vdev->pdev, "BAR %d has active DMABUFs. Cannot register for P=
2P.\n",
> +			 bar_index);
> +		return -EBUSY;
> +	}
> +
>  	ret =3D pci_p2pdma_add_resource(vdev->pdev, bar_index, 0, 0);
>  	if (ret && ret !=3D -EEXIST)
>  		return ret;

[Severity: Medium]
Is there a risk of lost updates when modifying the registration state
shortly after this check?

Looking at the rest of vfio_pci_core_feature_p2p_register():

vdev->p2p_registered_bars |=3D (1 << bar_index);

This performs a non-atomic read-modify-write on the bitmask without a lock.
If multiple threads concurrently register different regions for peer-to-pee=
r,
could they race and overwrite each other's modifications, silently losing a
registration?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610151853.3608=
948-1-praan@google.com?part=3D4
