Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604034;
	b=ImhPV4E8lFojl8VpmnTITXjnfEfNA+0oubjAwSaZj6S9Va0TgMMwunl4XJd9I71X7LSM
	 tXhY8KidX1QO4/L/4FEzEXBI4KMXb66XGQ5oH/amcbYoLBG+JAE8BJJGNiBhT0l08PVgL
	 ZaWLi5iPHoB/Pq1KXAnULJCbz3WhlW9weB5Li81/aQNqbT2Uro3qb9/VXt9L2369Ymo1y
	 xnW6icwOB3HOtzFx79qTITwwrf4AGvf1BNwHZxGO0Ea72wWLeqON8b0ybnbna3B1MhXd2
	 kGJNlCh1MaN3qKNyq9IPOt+lX+2ai0mZBvGDvPFyqql9vN+XKGWByWvK7NdN07s7H3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604034;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=rUWo+FPc/Fvtl3jVFJEj3Mwn/MNJtiQY0Rii96bVrSc=;
	b=HdeV83i5wc3E722VsawT0PX0mE6u0Zb5jawFU+0QvSjod8UlioYkLxnJqPLCcB8y1kfc
	 LlOWYkZRkaBc0SbIhjDOmZggeSwq7k4/Pk4rwpsfUjmCDaf4VakPK4+l7K7wpwocSsnIj
	 zUFaCL1khrY8cX+n9kKKEx312NhpnjsHWDAjHlVgeTe9C2kVtMa63zjAGAAkYZSFezcd6
	 Nq7ZJ9MlrucjqXa1GYjf+LpLQ7qNXn4fxG+W6JpRODuLmhLqolQfSm07agKOu886xf74O
	 eDyuhI9lntC5a2NpfdrlgYPImUBftWRdElDsKMfmPofy/++oUFyyE2kGk5jWXGJCL6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Aw4/t80y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54137606A321;
	Wed, 25 Nov 2026 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aw4/t80y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298EF1F000C6;
	Wed, 25 Nov 2026 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795604033;
	bh=rUWo+FPc/Fvtl3jVFJEj3Mwn/MNJtiQY0Rii96bVrSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Aw4/t80ySvef4ngdaOfKp90rK8D0F9XG1aCwosnrEMoKDYA8vS+bNLpu0xdI1/O86
	 9vcTTqK2Z/BuvMQ0d64PV3N+SUI56mCpmusIcXXxyXoWtaDk3PPXDtTnHpiSdn1SuW
	 e1mR1/wovj3ilVXlM7Gp3kwcgXPAmesAmB+KhVjoK3GkXkmz7PeCOyw+Bc60Q8dFUP
	 pdI6fy8Dg9/tph2CdPsXmTZGrBBu/qIIiIy1iNaRnfBjfpYKiX8rPYrPNjB2ut+BAY
	 X1gTf02OtxMVs7lfA7ySKR/FGy2A3smd6ZEql9GY/8ZR9SAGGnNTsTreKz80OJoKYP
	 AzzY4iuTLUEfg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v10 18/18] PCI/TSM: Wait for vIOMMUs to release the TSM
 before unregistering
In-Reply-To: <sashiko-outbox-232929@kernel.org>
References: <20261125081121.379481-1-aneesh.kumar@kernel.org>
 <20261125081121.379481-19-aneesh.kumar@kernel.org>
 <sashiko-outbox-232929@kernel.org>
Date: Wed, 25 Nov 2026 16:23:48 +0530
Message-ID: <yq5afqwp9o77.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

 [ ... 24 lines skipped ... ] 

>> @@ -728,52 +750,93 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
>>  
>>  void pci_tsm_destroy(struct pci_dev *pdev)
>>  {
>> -	struct pci_tsm_pf0 *pf0 = NULL;
>> -	struct completion *drained;
>> -	bool interrupted = false;
>> -	long rc;
>> +	struct tsm_dev *tsm_dev = NULL;
>> +	bool registration_locked = false;
>>  
>>  	down_write(&pci_tsm_rwsem);
>> -	if (pdev->tsm &&
>> -	    is_link_tsm(pdev->tsm->tsm_dev) && is_pci_tsm_pf0(pdev)) {
>> -		pf0 = to_pci_tsm_pf0(pdev->tsm);
>> -		drained = &pf0->dsm_context_drain_complete;
>> +	if (pdev->tsm && is_link_tsm(pdev->tsm->tsm_dev) &&
>> +	    is_pci_tsm_pf0(pdev)) {
>> +		struct pci_tsm_pf0 *pf0 = to_pci_tsm_pf0(pdev->tsm);
>> +
>>  		mutex_lock(&pf0->lock);
>>  		pf0->removing = true;
>> -
>>  		mutex_unlock(&pf0->lock);
>> -		/* An unused DSM may never have completed dsm_context_drain_complete. */
>> -		if (pf0->dsm_context_users)
>> -			rc = try_wait_for_completion(drained);
>> -		else
>> -			rc = 1;
>> -
>> -		/* Context release needs the read side of pci_tsm_rwsem. */
>> -		up_write(&pci_tsm_rwsem);
>> -		while (rc <= 0) {
>> -			if (interrupted) {
>> -				rc = wait_for_completion_timeout(drained, HZ * 10);
>> +
>> +		if (pf0->dsm_context_users) {
>> +			struct completion *drain_complete;
>> +			const char *users;
>> +			bool interrupted = false;
>> +			long rc;
>> +
>> +			tsm_dev = pdev->tsm->tsm_dev;
>> +			/*
>> +			 * Retain tsm_dev and its users_drain_complete while waiting
>> +			 * without the TSM registration lock.
>> +			 */
>> +			get_device(&tsm_dev->dev);
>> +			registration_locked = tsm_trylock_registration(tsm_dev);
>> +			if (registration_locked) {
>> +				/* The TSM registration lock prevents freeing PF0 here. */
>> +				drain_complete = &pf0->dsm_context_drain_complete;
>> +				users = "IOMMUFD device assignment contexts";
>>  			} else {
>> -				rc = wait_for_completion_interruptible_timeout(drained,
>> -									       HZ * 10);
>> -				if (rc < 0) {
>> -					interrupted = true;
>> -					pci_warn(pdev, "Task \"%s\" (%d) blocked until vdevices are released\n",
>> -						 current->comm, task_pid_nr(current));
>> +				/*
>> +				 * The DSM completion is embedded in PF0.
>> +				 * If unregister runs while pci_tsm_rwsem
>> +				 * is dropped, it may free PF0 after the
>> +				 * last context signals the completion but
>> +				 * before this waiter finishes accessing
>> +				 * it.
>> +				 *
>> +				 * Without the registration lock, wait on
>> +				 * the TSM's users_drain_complete completion
>> +				 * instead. The device reference keeps that
>> +				 * completion allocated even if unregister
>> +				 * finishes before this waiter resumes.
>> +				 */
>> +
>> +				drain_complete = &tsm_dev->users_drain_complete;
>> +				users = "virtual IOMMUs and other TSM users";
>> +			}
>> +
>> +			/* Context release needs the read side of pci_tsm_rwsem. */
>> +			up_write(&pci_tsm_rwsem);
>> +			rc = try_wait_for_completion(drain_complete);
>> +			while (rc <= 0) {
>> +				if (interrupted) {
>> +					rc = wait_for_completion_timeout(drain_complete, HZ * 10);
>> +				} else {
>> +					rc = wait_for_completion_interruptible_timeout(
>> +						drain_complete, HZ * 10);
>> +					if (rc < 0) {
>> +						interrupted = true;
>> +						pci_warn(pdev, "Task \"%s\" (%d) removing Device Security Manager; waiting for %s\n",
>> +							 current->comm, task_pid_nr(current),
>> +							 users);
>> +					}
>>  				}
>> +
>> +				if (!rc)
>> +					pci_warn(pdev, "Device Security Manager removal blocked; waiting for %s\n",
>> +						 users);
>>  			}
>> -			if (!rc)
>> -				pci_warn(pdev, "TSM connection is in use, waiting for vdevices\n");
>> +
>> +			down_write(&pci_tsm_rwsem);
>>  		}
>> -		down_write(&pci_tsm_rwsem);
>>  	}
>> +
>>  	__pci_tsm_destroy(pdev, NULL);
>>  	up_write(&pci_tsm_rwsem);
>> +	if (registration_locked)
>> +		tsm_unlock_registration(tsm_dev);
>> +
>> +	if (tsm_dev)
>> +		put_device(&tsm_dev->dev);
>>  }
>
> [Severity: Medium]
> Does holding tsm_dev->registration_lock for read across the userspace drain
> wait in pci_tsm_destroy() block a concurrent tsm_unregister() in
> down_write(&tsm_dev->registration_lock) before it can drop its initial
> tsm_dev->users reference?
>
> If tsm_unregister() is called while pci_tsm_destroy() is waiting on
> pf0->dsm_context_drain_complete, tsm_unregister() blocks in an unbounded
> TASK_UNINTERRUPTIBLE sleep on down_write(&tsm_dev->registration_lock)
> instead of reaching tsm_put_user() and the timed wait in
> tsm_wait_for_users().
>
> While tsm_unregister() is queued as a writer on registration_lock,
> down_read_trylock() in tsm_trylock_registration() also fails for any second
> PF0 entering pci_tsm_destroy(), causing that second PF0 to wait on
> tsm_dev->users_drain_complete even though tsm_unregister() has not yet
> called tsm_put_user() to release the initial users reference.  Even when
> tsm_unregister() already holds the write lock, falling back to
> tsm_dev->users_drain_complete makes PF0 removal wait for all vIOMMUs on the
> TSM rather than just PF0's own dsm_context_users, which deadlocks if
> userspace closes PF0's vdevice on hot-unplug and waits for PF0 removal to
> finish before destroying the vIOMMU.
>

I am finding this hard to parse. A PF0 destroy may wait for all TSM
users when it overlaps with TSM unregistration. The code contains a
comment explaining why: the destroy path must wait on a completion, and
the PF0 completion cannot be used safely while TSM unregistration is in
progress.



>
>> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
>> index 8cb6fdaf8a846..fa717e0702088 100644
>> --- a/drivers/virt/coco/tsm-core.c
>> +++ b/drivers/virt/coco/tsm-core.c
> [ ... ]
>> @@ -137,12 +216,63 @@ struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
> [ ... ]
>> +int tsm_unregister(struct tsm_dev *tsm_dev)
>>  {
>> -	/* Remove the class lookup first. */
>> +	down_write(&tsm_dev->registration_lock);
>> +	if (tsm_dev->unregistering) {
>> +		up_write(&tsm_dev->registration_lock);
>> +		return -ENODEV;
>> +	}
>> +
>> +	tsm_dev->unregistering = true;
>> +
>>  	device_del(&tsm_dev->dev);
>> -	pci_tsm_unregister(tsm_dev);
>> +	/* No new user references can be acquired while the write lock is held. */
>> +	tsm_put_user(tsm_dev);
>> +	tsm_wait_for_users(tsm_dev);
>> +
>> +	if (IS_ENABLED(CONFIG_PCI_TSM))
>> +		pci_tsm_unregister(tsm_dev);
>> +
>> +	up_write(&tsm_dev->registration_lock);
>>  	put_device(&tsm_dev->dev);
>> +	return 0;
>>  }
>
> [Severity: High]
> Can a second concurrent call to tsm_unregister() trigger a use-after-free on
> tsm_dev?
>
> tsm_unregister() checks tsm_dev->unregistering under
> tsm_dev->registration_lock to reject a second caller with -ENODEV, but the
> first caller drops the final registration reference with
> put_device(&tsm_dev->dev) immediately after up_write().  In SEV-TIO,
> sev_firmware_shutdown() calls sev_tsm_uninit() outside sev_cmd_mutex, and
> sev_tsm_uninit() leaves sev->tsmdev non-NULL while tsm_wait_for_users()
> sleeps waiting for userspace to close vIOMMUs:
>
> CPU0                                  CPU1
> sev_platform_shutdown()
>   sev_firmware_shutdown()
>     sev_tsm_uninit()
>       tsm_unregister(tsm_dev)
>         down_write(&registration_lock)
>         tsm_dev->unregistering = true
>         device_del(&tsm_dev->dev)
>         tsm_wait_for_users(tsm_dev)
>                                       sev_dev_destroy()
>                                         sev_firmware_shutdown()
>                                           sev_tsm_uninit()
>                                             tsm_unregister(tsm_dev)
>                                               down_write(&registration_lock)
>         ...
>         up_write(&registration_lock)
>         put_device(&tsm_dev->dev)
>           tsm_release()
>             kfree(tsm_dev)
>                                               if (tsm_dev->unregistering)
>                                                 up_write(&registration_lock)
>                                                 <-- use-after-free
>
> In addition, if tsm_unregister() returns -ENODEV to sev_tsm_uninit(),
> sev_tsm_uninit() warns and returns early without waiting for the ongoing
> unregistration, and sev_firmware_shutdown() proceeds to run
> __sev_firmware_shutdown() and kfree(sev->tio_status) while the first caller
> is still draining TSM users or running pci_tsm_unregister().
>

I responded to this in https://lore.kernel.org/all/yq5a7bijtkfi.fsf@kernel.org

-aneesh
