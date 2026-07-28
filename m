Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC4C38236F
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257232; cv=none; b=SSvoLnjaWvdKd0meBxSGlamAFWOpVpPYG2MrH1r/tt1xIU4GiEAU8r7rmvRQWvu2lY/FUsxCJhbllUV5g5P7cidxvqEhsMXfQaC6BfP0chph8jf+epVawolATHwQ8St1Vc8pBBgcelRX1sF++DZTFkeRCR4x9VfO5x6QXTLRjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257232; c=relaxed/simple;
	bh=RwE13vTfJwQTbUvcOWAm+K6eryv+/L2OnEfPB14xBok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MSX+/9Lb1Jr3w4iQ+qupJmIHeOgOEpZiHtDFyWPorT/mWl6OAhvdWtdxy7QhtzrLL5EJ1oUjG7DnOg87U1wH/l6/9vk9+KJ70w+5Cnn8kWgwZV3Vx74vx6hqLdDgmZo0EfQlWT/oDsNwET2DtkQm5nnjxkvHdK/VHlpAtsYo3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmkDtROV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmkDtROV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860FB1F000E9;
	Tue, 28 Jul 2026 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785257230;
	bh=HMHAeeuXfY+CVAND0oKZ1WsRUL1D5V14YHWM8meNrgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cmkDtROVFLTzH2T6Z9ratYoieCFHUGuahMTZER0Idrqb046ZSlSROstzz83jKXaKc
	 eKN0ksMfkL8PRBxeby6kQ7M4mJFp4YI9wxkEC5NqY64YHgmSwm1SLMZtfgue3ojgGU
	 v4kED4oL5DDIoxIn+AhleHmdXh01Q3PRhGxA3863Cy81PLwiO7DUvjFw2TaBExbYgF
	 /hO8etR5xXlDiEAYgELtvpFcFnBBZ1+NwJWSqdV36OjoyxB4Z7YjOlkKfRmczvx/A0
	 2wRK9/piBvdB8EkvWXsdlXcnin3G6PtrR8DvwRdJ0psQpK76J9KsOUDlv/InKGYl+P
	 O3dgGoNBWrgMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 3/8] i3c: master: Report wakeup events for IBIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-pci@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org, Frank.Li@kernel.org
In-Reply-To: <20260728155308.142713-4-adrian.hunter@intel.com>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:47:10 +0000
Message-Id: <20260728164710.860FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Concurrent execution of `i3c_master_queue_ibi()` and device unregi=
stration leads to a NULL pointer dereference or Use-After-Free on `dev->dev=
`.

Pre-existing issues:
- [High] Concurrently accessing `dev->ibi` and its workqueue without synchr=
onization leads to Use-After-Free.
--

--- Patch [3]: [PATCH V2 3/8] i3c: master: Report wakeup events for IBIs ---
commit 1c61ec6aa53c785eceea38530075c6fa6b7794f2
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Report wakeup events for IBIs

This commit records a wakeup event using pm_wakeup_event() when an
In-Band Interrupt (IBI) is queued for processing and the device has
wakeup enabled. It uses a 100 ms processing interval.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index cf3345265ac0b..9d56ca08569a1 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c

[ ... ]

> @@ -3098,6 +3101,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev,=
 struct i3c_ibi_slot *slot)
>  	if (!dev->ibi || !slot)
>  		return;
> =20
> +	if (device_may_wakeup(&dev->dev->dev))
> +		pm_wakeup_event(&dev->dev->dev, I3C_WAKEUP_PROCESSING_TIME_MS);
> +

[Severity: High]
Does this introduce a regression where a race condition with device
unregistration could lead to a NULL pointer dereference or use-after-free
on dev->dev?

If an IBI fires and i3c_master_queue_ibi() executes concurrently with
device unregistration (for example, during driver module removal or
hot-unplug), i3c_master_unregister_i3c_devs() can free dev->dev and set it
to NULL:

drivers/i3c/master.c:i3c_master_unregister_i3c_devs() {
	...
		if (device_is_registered(&i3cdev->dev->dev))
			device_unregister(&i3cdev->dev->dev);
		else
			put_device(&i3cdev->dev->dev);
		i3cdev->dev =3D NULL;
	...
}

If i3c_master_queue_ibi() passes the lockless if (!dev->ibi) check just
before the unregistration runs, could the subsequent call to
device_may_wakeup() dereference a freed or NULL pointer?


>  	atomic_inc(&dev->ibi->pending_ibis);
>  	queue_work(dev->ibi->wq, &slot->work);
>  }

[Severity: High]
This is a pre-existing issue, but can accessing dev->ibi and its workqueue
here race with IBI teardown and cause a use-after-free?

If i3c_master_queue_ibi() passes the if (!dev->ibi) check, and concurrently
the driver is unbound, i3c_dev_free_ibi_locked() will destroy the workqueue
and free dev->ibi:

drivers/i3c/master.c:i3c_dev_free_ibi_locked() {
	...
	if (dev->ibi->wq) {
		destroy_workqueue(dev->ibi->wq);
		dev->ibi->wq =3D NULL;
	}

	kfree(dev->ibi);
	dev->ibi =3D NULL;
	...
}

Could the interrupt handler then continue execution and call atomic_inc()
and queue_work() using the recently freed dev->ibi struct and destroyed
workqueue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728155308.1427=
13-1-adrian.hunter@intel.com?part=3D3
