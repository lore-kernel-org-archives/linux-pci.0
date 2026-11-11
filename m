Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413655;
	b=MROL5BhvsGV4dXZhg2uebFs2vmd+AwVsWQ7ss7afeLRIkEeOpdfv0DsIya1PrYo/VcVX
	 udSuj4KaAcK0Tld+byg8zGKTbjpaEEIXtotU8Um2UnJHa7A89Ch3VfSnZ5hc+vzqd2K+k
	 Dq6GMZkeMuaL4DTsFkcgLmVjca13QNjHn1Oovko9aDNlRjHEo/mHLo1B7XAEfoc1qf3/e
	 CBiETEJkkPFRAQgyTQWxevFX1suWk0c+bCvmwv8uOnyXBAoe2mvCGGr28faJviuwJStuk
	 lyVwyKI0unygG6y1iIk0YWYwY1zLxuzeNF58ccGmoMNVIXa1k8BLAzmOFpGZmgI/9yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413655;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=fhQHheKEaAJc/mDlawylid3uIovpR9O+D2BKSUGn9Vo=;
	b=gGWQNNxm4ACh4Q7j3LfkIiHlWQCcc2HWTDdBSXsxH1c5A/ymjRIriyik+vBQ/KGL2+50
	 apzfkMhdc44zdlRAcQwAq1aMIqR3yC08IYp/ngwwLwMVk+yZ6ycRBZn+7iYrRrQQiDF9V
	 xZljhL5cnLZXbqLPeo23rA1D2CerpAn4I48Ejrazl88bBzi7m1pGK9/cMMXI9BkV3fKAx
	 Tb9NoorkgiBKX2PbEI/NPzayjQeU1IOulFfGP3e40/FMQ8a2LDJx86ds8wad1B8YhEj9a
	 /MtSmbxZLYIrzyrOTgD8DsqK0ZOJ0fy7s5RfwG9TCIT/zgFROq2BiFsLeSQiO58EUfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRWEVPiY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526B606A332;
	Wed, 11 Nov 2026 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRWEVPiY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D111F00A08;
	Wed, 11 Nov 2026 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413655;
	bh=fhQHheKEaAJc/mDlawylid3uIovpR9O+D2BKSUGn9Vo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dRWEVPiYcG0hKBRf/YwU2dSU4cimQeXaIRQ0bu/+MrbgOraABgBu5yDQPrJfJYLWn
	 XN/QEaubwn5GB/uAOzTPkCT439K3Y7VIn4h2PphF0AClhC2NilHMZ9M8RKWfSTJmTb
	 5jR90S85H1IoPyBCwkOJHiQKqrbn8zytf1InNigXnPYrIWmetH3aT+AINb0L53YDcB
	 y0ewReN86EEhBtc9NiqiEaFCzwJGbgWa6Y5t0YEL1s1oLNfaWQ8qrsv4sV4/t597oO
	 2WZ6PCLPnH9GVMiXjI1NnQbcj50MBewhxGK+e1Qm7I2zX80C5I+CBfeZNscPc9Kzpn
	 Xrg29sXhePE4g==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 15/15] PCI/TSM: Wait for users during unregister
In-Reply-To: <sashiko-outbox-197810@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-16-aneesh.kumar@kernel.org>
 <sashiko-outbox-197810@kernel.org>
Date: Wed, 11 Nov 2026 21:44:09 +0530
Message-ID: <yq5a7bijtkfi.fsf@kernel.org>
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

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] PCI/TSM: use-after-free in tsm_unregister() and sev_tsm_uninit()
> - [Low] PCI/TSM: mixing guard() and goto in pci_tsm_context_get() and pci_tsm_init()
> --
>
> commit b2546a16b6b6a681e70bba7a7e4c0fbd2665c584
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> PCI/TSM: Wait for users during unregister
>
> This commit adds registration_lock and a user reference count to struct
> tsm_dev so that tsm_unregister() and pci_tsm_destroy() wait for active TSM
> users, including IOMMUFD virtual IOMMUs without vDEVICE objects, before
> tearing down PCI connections.
>
>> diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-dev-tsm.c
>> index 46f2539d2d5ab..5c61ce74ee0f7 100644
>> --- a/drivers/crypto/ccp/sev-dev-tsm.c
>> +++ b/drivers/crypto/ccp/sev-dev-tsm.c
>> @@ -392,8 +392,8 @@ void sev_tsm_init_locked(struct sev_device *sev, void *tio_status_page)
>>  
>>  void sev_tsm_uninit(struct sev_device *sev)
>>  {
>> -	if (sev->tsmdev)
>> -		tsm_unregister(sev->tsmdev);
>> +	if (sev->tsmdev && WARN_ON(tsm_unregister(sev->tsmdev)))
>> +		return;
>>  
>>  	sev->tsmdev = NULL;
>>  }
>
> [Severity: High]
> Can a concurrent call to sev_tsm_uninit() while tsm_unregister() is waiting
> for TSM users trigger a use-after-free or premature teardown?
>
> In drivers/crypto/ccp/sev-dev.c, sev_firmware_shutdown() invokes
> sev_tsm_uninit() outside sev_cmd_mutex:
>
> drivers/crypto/ccp/sev-dev.c:sev_firmware_shutdown() {
> 	if (sev->tio_status)
> 		sev_tsm_uninit(sev);
>
> 	sev_snp_unregister_verify_mitigation(sev);
>
> 	mutex_lock(&sev_cmd_mutex);
>
> 	__sev_firmware_shutdown(sev, false);
>
> 	kfree(sev->tio_status);
> 	sev->tio_status = NULL;
>
> 	mutex_unlock(&sev_cmd_mutex);
> }
>
> Because tsm_unregister() now sleeps in tsm_wait_for_users() and
> sev->tsmdev is only cleared after tsm_unregister() returns, a concurrent
> caller of sev_firmware_shutdown() (such as sev_platform_shutdown() racing
> with sev_dev_destroy() or sev_pci_exit()) can see non-NULL sev->tio_status
> and sev->tsmdev and call tsm_unregister(sev->tsmdev) a second time.
>
> Additionally, if tsm_unregister() returns -ENODEV here, sev_tsm_uninit()
> returns early without clearing sev->tsmdev, and sev_firmware_shutdown()
> proceeds to run __sev_firmware_shutdown() and free sev->tio_status while
> the first caller is still blocked in tsm_wait_for_users() or disconnecting
> PCI devices in pci_tsm_unregister().
>

 [ ... 132 lines skipped ... ] 

>
> [Severity: High]
> Can the tsm_dev->unregistering check in tsm_unregister() cause a
> use-after-free on tsm_dev when two callers race to unregister the same
> device?
>
> tsm_register() initializes tsm_dev->dev with a single registration device
> reference. When a first caller enters tsm_unregister(), it holds
> down_write(&tsm_dev->registration_lock) across device_del(),
> tsm_wait_for_users(), and pci_tsm_unregister().
>
> If a second caller enters tsm_unregister() while the first caller is
> waiting for users to drain, the second caller blocks in
> down_write(&tsm_dev->registration_lock) without holding a device reference
> on tsm_dev->dev. Once all user references have been dropped and the first
> caller finishes:
>
> 	up_write(&tsm_dev->registration_lock);
> 	put_device(&tsm_dev->dev);
>
> put_device(&tsm_dev->dev) drops the final reference and frees tsm_dev via
> tsm_release(), while the second caller wakes from
> down_write(&tsm_dev->registration_lock), reads tsm_dev->unregistering, and
> calls up_write(&tsm_dev->registration_lock) on the freed tsm_dev.
>

I consider both issues pre-existing. The SEV code should ensure that
concurrent calls to tsm_unregister() hold additional references so that
tsm_dev remains valid. Can this be fixed separately from this series?

-aneesh
