Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596204;
	b=33B4KMWmzKz7EjcU3oJMYUm1jlpGz0fPThZmrA6CZJ9MFb+e6vY4HohnxWQrNWVX2W9O
	 gfLfNyrA/ahplZPHvrjP0T2z0zK0DQAnTwyK5McQgKzk1lwj0nvxxhgl5DTK/xXoYUv4x
	 gviwm1e+RpAVZufB4f8eBAo6myfoWorsUUmQ2owklRgCWbssN7EvoTNMtPty1+uIzIG9d
	 VZKLjfz86Np9A1U7JchGZVcn4fH57SAe1E6onD1BlfOUFe/ocKgX4NwYyQ7z0xL/a/o3x
	 F+8dtg6+qyBmkWx58tisZkR0JiyVp02Y6UQL7rIf0NrU4ZOp4v7L7KtnLzIAXaHex3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596204;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yo5G8/CmAVTOoh3N8NgGFlVdWnXq5Gw9EyEZ+jci7Yc=;
	b=F3vu3bGsotlSPuDFsP4Vyh3vzXqXUNKeZ7iqXACfmlKriftK3KAii/Z2Bc5Z6GLs6L7H
	 tv0GTm9ZecX6xFLjreRddHaJRCry9vPHHQ2kI7CRizxMbgbhARdxOm2GKDMklLJp9ZCrB
	 v0Ai2QP/Ej8OPPB05J2/wK5+sIbEZYcGzgnoX4dhLRUH1zUAPCi+wmL904r2HS9nR72Ir
	 mq9laxpN0UrbiPbCNlYt10OLu2mwANfncVl7vdyUAiBXDMl/Q2ISHJS9oVSo08WnCIoA1
	 Ey7y6yxiWCTTLdz4szKh3rkbEscGxgOeUVlPd10LKg8pWmS6Q4eKSni/oT6yqrEnlDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEkyUBxy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53386606A321;
	Wed, 25 Nov 2026 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEkyUBxy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB091F000CF;
	Wed, 25 Nov 2026 08:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795596203;
	bh=yo5G8/CmAVTOoh3N8NgGFlVdWnXq5Gw9EyEZ+jci7Yc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GEkyUBxye/rkpiIC58cTZhbwYbdtQBwMulYxja6hBfrFEmDlgMq65Yz8x9fH/QmNA
	 MKO25mEoAAtGmOBNNqYfxn3a/flB8n157SpWX1xPFNJET9UM0jbZWQnRArogJgJSUX
	 +I7KERcjwHa5rr7SuEhhNkDRw4+R/u+AC2OucAAbsglJy+WdY0Tugb7uXG+UPFL0G7
	 VVSAmcrmk6/jpf0WkA6lYiKZsUSJKCrMeeJYB0zjlgZnMwki46w5FCNv/nui6aMl4G
	 xm5pQw/dUdSq+cHg8WHwQEQHw1ZqefBW+7w7u+8zulM5HlKRd0PpCecrlgJHK2qyhy
	 nPP1WD+aZhW0g==
Message-ID: <sashiko-outbox-232929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 18/18] PCI/TSM: Wait for vIOMMUs to release the TSM
 before unregistering
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261125081121.379481-19-aneesh.kumar@kernel.org>
References: <20261125081121.379481-1-aneesh.kumar@kernel.org>
 <20261125081121.379481-19-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:43:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] PCI/TSM: use-after-free on tsm_dev in tsm_unregister() and
  sev_tsm_uninit()
- [Medium] PCI/TSM: holding registration_lock across wait in
  pci_tsm_destroy()
--

commit 12207b3dbfdc30d4f6117b169c90eebf960192b8
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

PCI/TSM: Wait for vIOMMUs to release the TSM before unregistering

This commit adds a user reference count to struct tsm_dev so that
tsm_unregister() waits for active TSM users (such as IOMMUFD vIOMMUs) to
drain before tearing down backend resources, and coordinates PF0 removal in
pci_tsm_destroy() with TSM unregistration via registration_lock.

> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index b10bf0b2d5b7b..8b3f6d1513c6c 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
[ ... ]
> @@ -728,52 +750,93 @@ static void __pci_tsm_destroy(struct pci_dev *pdev,=
 struct tsm_dev *tsm_dev)
> =20
>  void pci_tsm_destroy(struct pci_dev *pdev)
>  {
> -	struct pci_tsm_pf0 *pf0 =3D NULL;
> -	struct completion *drained;
> -	bool interrupted =3D false;
> -	long rc;
> +	struct tsm_dev *tsm_dev =3D NULL;
> +	bool registration_locked =3D false;
> =20
>  	down_write(&pci_tsm_rwsem);
> -	if (pdev->tsm &&
> -	    is_link_tsm(pdev->tsm->tsm_dev) && is_pci_tsm_pf0(pdev)) {
> -		pf0 =3D to_pci_tsm_pf0(pdev->tsm);
> -		drained =3D &pf0->dsm_context_drain_complete;
> +	if (pdev->tsm && is_link_tsm(pdev->tsm->tsm_dev) &&
> +	    is_pci_tsm_pf0(pdev)) {
> +		struct pci_tsm_pf0 *pf0 =3D to_pci_tsm_pf0(pdev->tsm);
> +
>  		mutex_lock(&pf0->lock);
>  		pf0->removing =3D true;
> -
>  		mutex_unlock(&pf0->lock);
> -		/* An unused DSM may never have completed dsm_context_drain_complete. =
*/
> -		if (pf0->dsm_context_users)
> -			rc =3D try_wait_for_completion(drained);
> -		else
> -			rc =3D 1;
> -
> -		/* Context release needs the read side of pci_tsm_rwsem. */
> -		up_write(&pci_tsm_rwsem);
> -		while (rc <=3D 0) {
> -			if (interrupted) {
> -				rc =3D wait_for_completion_timeout(drained, HZ * 10);
> +
> +		if (pf0->dsm_context_users) {
> +			struct completion *drain_complete;
> +			const char *users;
> +			bool interrupted =3D false;
> +			long rc;
> +
> +			tsm_dev =3D pdev->tsm->tsm_dev;
> +			/*
> +			 * Retain tsm_dev and its users_drain_complete while waiting
> +			 * without the TSM registration lock.
> +			 */
> +			get_device(&tsm_dev->dev);
> +			registration_locked =3D tsm_trylock_registration(tsm_dev);
> +			if (registration_locked) {
> +				/* The TSM registration lock prevents freeing PF0 here. */
> +				drain_complete =3D &pf0->dsm_context_drain_complete;
> +				users =3D "IOMMUFD device assignment contexts";
>  			} else {
> -				rc =3D wait_for_completion_interruptible_timeout(drained,
> -									       HZ * 10);
> -				if (rc < 0) {
> -					interrupted =3D true;
> -					pci_warn(pdev, "Task \"%s\" (%d) blocked until vdevices are release=
d\n",
> -						 current->comm, task_pid_nr(current));
> +				/*
> +				 * The DSM completion is embedded in PF0.
> +				 * If unregister runs while pci_tsm_rwsem
> +				 * is dropped, it may free PF0 after the
> +				 * last context signals the completion but
> +				 * before this waiter finishes accessing
> +				 * it.
> +				 *
> +				 * Without the registration lock, wait on
> +				 * the TSM's users_drain_complete completion
> +				 * instead. The device reference keeps that
> +				 * completion allocated even if unregister
> +				 * finishes before this waiter resumes.
> +				 */
> +
> +				drain_complete =3D &tsm_dev->users_drain_complete;
> +				users =3D "virtual IOMMUs and other TSM users";
> +			}
> +
> +			/* Context release needs the read side of pci_tsm_rwsem. */
> +			up_write(&pci_tsm_rwsem);
> +			rc =3D try_wait_for_completion(drain_complete);
> +			while (rc <=3D 0) {
> +				if (interrupted) {
> +					rc =3D wait_for_completion_timeout(drain_complete, HZ * 10);
> +				} else {
> +					rc =3D wait_for_completion_interruptible_timeout(
> +						drain_complete, HZ * 10);
> +					if (rc < 0) {
> +						interrupted =3D true;
> +						pci_warn(pdev, "Task \"%s\" (%d) removing Device Security Manager;=
 waiting for %s\n",
> +							 current->comm, task_pid_nr(current),
> +							 users);
> +					}
>  				}
> +
> +				if (!rc)
> +					pci_warn(pdev, "Device Security Manager removal blocked; waiting fo=
r %s\n",
> +						 users);
>  			}
> -			if (!rc)
> -				pci_warn(pdev, "TSM connection is in use, waiting for vdevices\n");
> +
> +			down_write(&pci_tsm_rwsem);
>  		}
> -		down_write(&pci_tsm_rwsem);
>  	}
> +
>  	__pci_tsm_destroy(pdev, NULL);
>  	up_write(&pci_tsm_rwsem);
> +	if (registration_locked)
> +		tsm_unlock_registration(tsm_dev);
> +
> +	if (tsm_dev)
> +		put_device(&tsm_dev->dev);
>  }

[Severity: Medium]
Does holding tsm_dev->registration_lock for read across the userspace drain
wait in pci_tsm_destroy() block a concurrent tsm_unregister() in
down_write(&tsm_dev->registration_lock) before it can drop its initial
tsm_dev->users reference?

If tsm_unregister() is called while pci_tsm_destroy() is waiting on
pf0->dsm_context_drain_complete, tsm_unregister() blocks in an unbounded
TASK_UNINTERRUPTIBLE sleep on down_write(&tsm_dev->registration_lock)
instead of reaching tsm_put_user() and the timed wait in
tsm_wait_for_users().

While tsm_unregister() is queued as a writer on registration_lock,
down_read_trylock() in tsm_trylock_registration() also fails for any second
PF0 entering pci_tsm_destroy(), causing that second PF0 to wait on
tsm_dev->users_drain_complete even though tsm_unregister() has not yet
called tsm_put_user() to release the initial users reference.  Even when
tsm_unregister() already holds the write lock, falling back to
tsm_dev->users_drain_complete makes PF0 removal wait for all vIOMMUs on the
TSM rather than just PF0's own dsm_context_users, which deadlocks if
userspace closes PF0's vdevice on hot-unplug and waits for PF0 removal to
finish before destroying the vIOMMU.

> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index 8cb6fdaf8a846..fa717e0702088 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
[ ... ]
> @@ -137,12 +216,63 @@ struct tsm_dev *tsm_register(struct device *parent,=
 struct pci_tsm_ops *pci_ops)
[ ... ]
> +int tsm_unregister(struct tsm_dev *tsm_dev)
>  {
> -	/* Remove the class lookup first. */
> +	down_write(&tsm_dev->registration_lock);
> +	if (tsm_dev->unregistering) {
> +		up_write(&tsm_dev->registration_lock);
> +		return -ENODEV;
> +	}
> +
> +	tsm_dev->unregistering =3D true;
> +
>  	device_del(&tsm_dev->dev);
> -	pci_tsm_unregister(tsm_dev);
> +	/* No new user references can be acquired while the write lock is held.=
 */
> +	tsm_put_user(tsm_dev);
> +	tsm_wait_for_users(tsm_dev);
> +
> +	if (IS_ENABLED(CONFIG_PCI_TSM))
> +		pci_tsm_unregister(tsm_dev);
> +
> +	up_write(&tsm_dev->registration_lock);
>  	put_device(&tsm_dev->dev);
> +	return 0;
>  }

[Severity: High]
Can a second concurrent call to tsm_unregister() trigger a use-after-free on
tsm_dev?

tsm_unregister() checks tsm_dev->unregistering under
tsm_dev->registration_lock to reject a second caller with -ENODEV, but the
first caller drops the final registration reference with
put_device(&tsm_dev->dev) immediately after up_write().  In SEV-TIO,
sev_firmware_shutdown() calls sev_tsm_uninit() outside sev_cmd_mutex, and
sev_tsm_uninit() leaves sev->tsmdev non-NULL while tsm_wait_for_users()
sleeps waiting for userspace to close vIOMMUs:

CPU0                                  CPU1
sev_platform_shutdown()
  sev_firmware_shutdown()
    sev_tsm_uninit()
      tsm_unregister(tsm_dev)
        down_write(&registration_lock)
        tsm_dev->unregistering =3D true
        device_del(&tsm_dev->dev)
        tsm_wait_for_users(tsm_dev)
                                      sev_dev_destroy()
                                        sev_firmware_shutdown()
                                          sev_tsm_uninit()
                                            tsm_unregister(tsm_dev)
                                              down_write(&registration_lock)
        ...
        up_write(&registration_lock)
        put_device(&tsm_dev->dev)
          tsm_release()
            kfree(tsm_dev)
                                              if (tsm_dev->unregistering)
                                                up_write(&registration_lock)
                                                <-- use-after-free

In addition, if tsm_unregister() returns -ENODEV to sev_tsm_uninit(),
sev_tsm_uninit() warns and returns early without waiting for the ongoing
unregistration, and sev_firmware_shutdown() proceeds to run
__sev_firmware_shutdown() and kfree(sev->tio_status) while the first caller
is still draining TSM users or running pci_tsm_unregister().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125081121.3794=
81-1-aneesh.kumar@kernel.org?part=3D18
