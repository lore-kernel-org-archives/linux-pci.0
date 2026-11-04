Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815248;
	b=2De9gT2orfI7GEADgYUuU4tXHRey7iq5/oBQAN3e7TiYi4OCbyOiMQakPOCJ8BlwBcln
	 r134FItgs+iNz0PRdJSz/+MwKPvmv1RkTDsA459rWgrXKv/9sbLk1+5KyDwm6eCwdv0nL
	 SgBP+wE4QeqPhBJGmF3+hwxV5dkquDD50lcuy7EfTZPkin3FAyl72j1dB6WwCdJSoAyzT
	 nKNelZvR+eywFj4jM75GSXuvkjZZdwD5vQML7yFF3KVgJaUy37yHUPmm9/Sr8O75kcVEL
	 3umcPCqK3tYATncAC2jndPC9cLQepedc64m/hbpPVndC4sBqV35fsQ/7d33QMsG232A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815248;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FNMewgzwxXMjzgYDlsVH+uOhn5G2WtJZ8n6lgExRd4A=;
	b=Z76gs6IUiuX+GGFL4mH1UgAfNBVpnNLF3UmcbVke3hYZ6pKEG6dFEMcAWTgRwKA/Ks8E
	 q132IGeh+sT4nAmwGbncWY7lbhwWWS/X4FpS7tsZnOTjhRmPKBPz5gM/+JXlwz6o3o13t
	 +DZINYuMyB1rIFnMeHV9f3JfKvWxv0PrA8liKTbLTcTPG1PFWEulUT/tQ4g/hsDAx9tqJ
	 If9d0cIdYJ+RtHIWivXxursBZztas0udwNqxHbI9mKC7LCUuidh3/v8myMugWQ7nJ1hUm
	 ez2eXQvG2I74uITlib5I7LmN6LdBDB44xhRNaXGtO6/hrAQq1RND744fsDlxNzlTgFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTkEIzNc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33C606B206;
	Wed,  4 Nov 2026 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTkEIzNc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35441F000C1;
	Wed,  4 Nov 2026 18:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793815248;
	bh=FNMewgzwxXMjzgYDlsVH+uOhn5G2WtJZ8n6lgExRd4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gTkEIzNcXJ6xrXZdIrw85UkWFf5j+aCZJERNdEBAXA186fP2Q8bQB9l0WrVf/Qrha
	 S8dtaatTY0Zae5lup0cshFrVH8Et1f9ySy2IBtOXw5bLdbThVHkPlj6PP7zzH44eWR
	 gy1/nDrXspCFSU9pHWWzjWAmTlxz9aBBTcVOQCLsS/ovg7FHbbbFfHmDQL+FO7RtbI
	 ZRzD7BCwTZRocu1pNLOkxhBZoxrPF3O4ETm1bbpbfIUKck2U+U9HsB2hAICuFGZX+U
	 Wo0/jMCoYl+hsSIRTCkkgi5E5M9MLyjsf2KGK4I7AY4p+35gOqEuw5f5H6wjvRNkDG
	 rDpD/4DyjZyGA==
Message-ID: <sashiko-outbox-197810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/15] PCI/TSM: Wait for users during unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-16-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-16-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 18:00:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PCI/TSM: use-after-free in tsm_unregister() and sev_tsm_uninit()
- [Low] PCI/TSM: mixing guard() and goto in pci_tsm_context_get() and pci_t=
sm_init()
--

commit b2546a16b6b6a681e70bba7a7e4c0fbd2665c584
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

PCI/TSM: Wait for users during unregister

This commit adds registration_lock and a user reference count to struct
tsm_dev so that tsm_unregister() and pci_tsm_destroy() wait for active TSM
users, including IOMMUFD virtual IOMMUs without vDEVICE objects, before
tearing down PCI connections.

> diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-de=
v-tsm.c
> index 46f2539d2d5ab..5c61ce74ee0f7 100644
> --- a/drivers/crypto/ccp/sev-dev-tsm.c
> +++ b/drivers/crypto/ccp/sev-dev-tsm.c
> @@ -392,8 +392,8 @@ void sev_tsm_init_locked(struct sev_device *sev, void=
 *tio_status_page)
> =20
>  void sev_tsm_uninit(struct sev_device *sev)
>  {
> -	if (sev->tsmdev)
> -		tsm_unregister(sev->tsmdev);
> +	if (sev->tsmdev && WARN_ON(tsm_unregister(sev->tsmdev)))
> +		return;
> =20
>  	sev->tsmdev =3D NULL;
>  }

[Severity: High]
Can a concurrent call to sev_tsm_uninit() while tsm_unregister() is waiting
for TSM users trigger a use-after-free or premature teardown?

In drivers/crypto/ccp/sev-dev.c, sev_firmware_shutdown() invokes
sev_tsm_uninit() outside sev_cmd_mutex:

drivers/crypto/ccp/sev-dev.c:sev_firmware_shutdown() {
	if (sev->tio_status)
		sev_tsm_uninit(sev);

	sev_snp_unregister_verify_mitigation(sev);

	mutex_lock(&sev_cmd_mutex);

	__sev_firmware_shutdown(sev, false);

	kfree(sev->tio_status);
	sev->tio_status =3D NULL;

	mutex_unlock(&sev_cmd_mutex);
}

Because tsm_unregister() now sleeps in tsm_wait_for_users() and
sev->tsmdev is only cleared after tsm_unregister() returns, a concurrent
caller of sev_firmware_shutdown() (such as sev_platform_shutdown() racing
with sev_dev_destroy() or sev_pci_exit()) can see non-NULL sev->tio_status
and sev->tsmdev and call tsm_unregister(sev->tsmdev) a second time.

Additionally, if tsm_unregister() returns -ENODEV here, sev_tsm_uninit()
returns early without clearing sev->tsmdev, and sev_firmware_shutdown()
proceeds to run __sev_firmware_shutdown() and free sev->tio_status while
the first caller is still blocked in tsm_wait_for_users() or disconnecting
PCI devices in pci_tsm_unregister().

> diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
> index 2c77321fa7792..49256638c164c 100644
> --- a/drivers/pci/tsm/core.c
> +++ b/drivers/pci/tsm/core.c

[ ... ]

> @@ -343,24 +352,33 @@ struct pci_tsm_context *pci_tsm_context_get(struct =
pci_dev *pdev,
>  		return ERR_PTR(-EOPNOTSUPP);
>  	/*
>  	 * The vdevice can use a different PCI function from VIOMMU_ALLOC. The
> -	 * module pin keeps the vIOMMU's TSM registered, but does not freeze th=
is
> +	 * caller must retain its tsm_get_device() reference until the context =
is
> +	 * released. This keeps the TSM registered, but does not freeze this
>  	 * function's link. Match its current TSM before pinning the link below.
>  	 */
>  	if (pdev->tsm->tsm_dev !=3D viommu_tsm_dev)
>  		return ERR_PTR(-EXDEV);
> =20
> +	if (!tsm_trylock_registration(viommu_tsm_dev))
> +		return ERR_PTR(-ENODEV);
> +
>  	pf0 =3D to_pci_tsm_pf0(pdev->tsm);
> -	if (!pf0)
> -		return ERR_PTR(-ENXIO);
> +	if (!pf0) {
> +		context =3D ERR_PTR(-ENXIO);
> +		goto out_unlock_registration;
> +	}
> =20
>  	context =3D kzalloc_obj(*context);
> -	if (!context)
> -		return ERR_PTR(-ENOMEM);
> +	if (!context) {
> +		context =3D ERR_PTR(-ENOMEM);
> +		goto out_unlock_registration;
> +	}
> =20
> -	guard(mutex)(&pf0->lock);
> +	mutex_lock(&pf0->lock);
>  	if (pf0->removing) {
>  		kfree(context);
> -		return ERR_PTR(-ENODEV);
> +		context =3D ERR_PTR(-ENODEV);
> +		goto out_unlock_mutex;
>  	}
> =20
>  	if (!pf0->dsm_context_users)
> @@ -370,6 +388,10 @@ struct pci_tsm_context *pci_tsm_context_get(struct p=
ci_dev *pdev,
>  	context->pf0 =3D pf0;
>  	context->pdev =3D pci_dev_get(pdev);
>  	context->dsm_dev =3D pci_dev_get(pf0->base_tsm.pdev);
> +out_unlock_mutex:
> +	mutex_unlock(&pf0->lock);
> +out_unlock_registration:
> +	tsm_unlock_registration(viommu_tsm_dev);
>  	return context;
>  }
>  EXPORT_SYMBOL_GPL(pci_tsm_context_get);

[ ... ]

> @@ -842,11 +901,17 @@ void pci_tsm_init(struct pci_dev *pdev)
>  		if (!dsm->tsm)
>  			return;
> =20
> +		tsm_dev =3D dsm->tsm->tsm_dev;
> +		if (!tsm_trylock_registration(tsm_dev))
> +			return;
> +
>  		if (is_link_tsm(dsm->tsm->tsm_dev) &&
>  		    to_pci_tsm_pf0(dsm->tsm)->removing)
> -			return;
> +			goto out_unlock_registration;
> =20
>  		probe_fn(pdev, dsm);
> +out_unlock_registration:
> +		tsm_unlock_registration(tsm_dev);
>  	}
>  }

[Severity: Low]
This isn't a bug, but pci_tsm_context_get() and pci_tsm_init() both use
guard(rwsem_read)(&pci_tsm_rwsem) and now mix scope-based cleanup with
goto-based error handling (and pci_tsm_context_get() converts
guard(mutex)(&pf0->lock) back to manual mutex_lock() / mutex_unlock() with
goto labels).

Could these functions avoid mixing guard() with goto cleanup labels?

> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index 92ce3337f1ea7..6bb373bc8bae0 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c

[ ... ]

> +/**
> + * tsm_unregister() - unregister a TSM after draining its users
> + * @tsm_dev: TSM to unregister
> + *
> + * Blocks new users and waits for references acquired by tsm_get_device(=
),
> + * including vIOMMUs without vdevices, and pending DSM removals before t=
earing
> + * down PCI connections. The wait cannot be aborted by a signal; userspa=
ce
> + * must release the vIOMMUs and vdevices to let it finish.
> + *
> + * Return: 0 on success, or -ENODEV if unregistration has already starte=
d.
> + */
> +int tsm_unregister(struct tsm_dev *tsm_dev)
>  {
> -	/* Remove the class lookup first. */
> +	down_write(&tsm_dev->registration_lock);
> +	if (tsm_dev->unregistering) {
> +		up_write(&tsm_dev->registration_lock);
> +		return -ENODEV;
> +	}
> +	tsm_dev->unregistering =3D true;
> +
>  	device_del(&tsm_dev->dev);
> -	if (tsm_dev->pci_ops)
> +	/* No new user references can be acquired while the write lock is held.=
 */
> +	tsm_put_user(tsm_dev);
> +	tsm_wait_for_users(tsm_dev);
> +
> +	if (IS_ENABLED(CONFIG_PCI_TSM) && tsm_dev->pci_ops)
>  		pci_tsm_unregister(tsm_dev);
> +
> +	up_write(&tsm_dev->registration_lock);
>  	put_device(&tsm_dev->dev);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(tsm_unregister);

[Severity: High]
Can the tsm_dev->unregistering check in tsm_unregister() cause a
use-after-free on tsm_dev when two callers race to unregister the same
device?

tsm_register() initializes tsm_dev->dev with a single registration device
reference. When a first caller enters tsm_unregister(), it holds
down_write(&tsm_dev->registration_lock) across device_del(),
tsm_wait_for_users(), and pci_tsm_unregister().

If a second caller enters tsm_unregister() while the first caller is
waiting for users to drain, the second caller blocks in
down_write(&tsm_dev->registration_lock) without holding a device reference
on tsm_dev->dev. Once all user references have been dropped and the first
caller finishes:

	up_write(&tsm_dev->registration_lock);
	put_device(&tsm_dev->dev);

put_device(&tsm_dev->dev) drops the final reference and frees tsm_dev via
tsm_release(), while the second caller wakes from
down_write(&tsm_dev->registration_lock), reads tsm_dev->unregistering, and
calls up_write(&tsm_dev->registration_lock) on the freed tsm_dev.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D15
