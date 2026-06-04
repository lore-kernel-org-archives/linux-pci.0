Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087347B43E;
	Thu,  4 Jun 2026 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581099; cv=none; b=JqUEsqzy7L5mxljMEue9JtBUkpH4LbWTK/Ifw9uF4h5BIx7ty7/TZ1oI4xDNmDNyCNSBU+zkIUEU8cnP0AQ3WiVmqnpGqvz6xvB6Yc2zRDqe14QIRZ7HNWUlyvJtCaYAM1/v1QzanHLMyevVTjY2VqmBd+30Px7H1IG9N0vabLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581099; c=relaxed/simple;
	bh=OPNqLmUyZZlYuTF2bLG5dDMnnC2i7vApk5z7xioVaJ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lpC8ysDH5nJPrJwcvX511+eeJcrOHMOXCAjgm6wONRU3u7k4TgtV2Wjh7nqVk2Isj3k0OO0rIOFv/phALPib8zplsMpBDHfPmdc0KCA3MN38vZ7pzjCYsJxjU1sV2wDETII//0NN/ZR99zF/87qLgj/QFBGDBgBfc3ESR/1b6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaS8IM5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaS8IM5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA0C1F00893;
	Thu,  4 Jun 2026 13:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581098;
	bh=QCYXuhi6kCxZvzAPd/G53MtvB/rIOtzm4UwAqO+EdOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SaS8IM5ljEOlB7nlhbB/CC2lpn4OeMkheNphca4X6w+JwixFlryG3wxianbGeuPd1
	 JU57IP8o+iwtZXGxyoQUOge9NixGwY8zyDYSevQJqTxgwizextgn+fiENbABSN/z1r
	 sMsc8DKKym/UKS8zmH1Xp0MEVeud2eKVOtKPR/eTnYspPU6uFAFJDGvHQRL8D0kBF5
	 akUxhR5CDSR2xdUfrP4xzruG9fB4guBLG2yIcwWKKQROIqET+CBPTqBUlvcCUbQP/e
	 R4JufjIJBsFX75hTPGSTzQ5b1nojCVZmSmM4geNJgVQPvO4oQH5Od626OF6eLByPuJ
	 al8STDRYU1p/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 11/12] vfio/pci: Add TPH_ST_CONFIG for PCIe TPH ST
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260604132804.28678-12-fengchengwen@huawei.com>
References: <20260604132804.28678-12-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 13:51:37 +0000
Message-Id: <20260604135138.1FA0C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Lockless modification of the `tph_permit` bitfield races with upda=
tes to adjacent bitfields, risking data corruption of critical device state=
 flags.
- [Medium] The `tph_permit` flag is not reset when the VFIO device is close=
d, leaking state between user sessions.
--

commit 3866f62cd649303d4e63fcdfae7f9e49073c8b9c
Author: Chengwen Feng <fengchengwen@huawei.com>
Subject: vfio/pci: Add TPH_ST_CONFIG for PCIe TPH ST configuration

This patch adds the VFIO_DEVICE_FEATURE_TPH_ST_CONFIG feature to allow
userspace to configure PCIe TPH Steering Tag table entries. It uses a shadow
table to cache entries, paired with a per-device mutex for concurrent access
protection.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 7c6e3e1213d3e..e20c92a3dfcb1 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -496,6 +496,50 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops =
=3D {
[ ... ]
> +static void vfio_pci_tph_deinit(struct vfio_pci_core_device *vdev)
> +{
> +	kfree(vdev->tph_st_shadow);
> +	vdev->tph_st_shadow =3D NULL;
> +	vdev->tph_st_entries =3D 0;
> +}

[Severity: Medium]
When the VFIO device is closed, should tph_permit be reset to 0 here or in
vfio_pci_core_disable()?

Because struct vfio_pci_core_device persists across opens, a subsequent
user opening the same device will inherit tph_permit =3D 1.

Could this allow the new user to bypass the explicit feature opt-in sequence
required by the API and cause cross-session state leakage?

[ ... ]
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 5f32830766a0f..9cac61c63ead2 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -143,6 +143,9 @@ struct vfio_pci_core_device {
>  	struct notifier_block	nb;
>  	struct rw_semaphore	memory_lock;
>  	struct list_head	dmabufs;
> +	struct mutex		tph_lock;
> +	u16			*tph_st_shadow;
> +	u16			tph_st_entries;
>  };

[Severity: High]
Is it safe to modify tph_permit locklessly?

In struct vfio_pci_core_device, tph_permit is defined as a 1-bit bitfield
adjacent to other state flags like pm_runtime_engaged.

Because bitfields share the same underlying memory word, modifying
tph_permit translates to a non-atomic read-modify-write operation.

If vfio_pci_core_feature_tph_enable() sets vdev->tph_permit =3D 1 without a
lock, could it race with concurrent ioctls modifying adjacent bitfields
(such as pm_runtime_engaged under vdev->igate) and cause silent state
corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604132804.2867=
8-1-fengchengwen@huawei.com?part=3D11
