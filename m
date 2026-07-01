Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368C927A47F
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937747; cv=none; b=awQE8KS4gj6qv5nGCxq8VjQn/WURWVePbnLCcURvy462M7J8SEqGcByYtOjYRuByp/4R34FmxeqoFj1g7FaDy4pbDBIEeFHydTlAMY8tJ3zfFQAN9sQXzP5wyZyugcnI8uK/PGuIaKXJO6M3/5TTeVdnBIuV8htbTxWjohc/mUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937747; c=relaxed/simple;
	bh=qhCO48VVcv1hmtEzsYr2/UgAHVi3xGjK5D8W3hxq9Kk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f6xjYLzKa9Mk7KD+82iHj4eizlp5vA6sf/9rWk8vco4tJTX3QgQp0/xlcihR+qo3SlHvNJl2Dd/DLW+oRIm55Gl61a1VuOGspDEM1fe0fxHuq25Qf8Py4KnVhZOfpCaTvU5ihaaHMEeN32ROmQHywaVjB3z8QZSXuUVw6RM5eW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3tLjESH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3tLjESH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779531F000E9;
	Wed,  1 Jul 2026 20:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782937745;
	bh=Dr+I3p8ZIjxW6pp0wwweggYhAj35PUYgw3Cl0InNCvo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n3tLjESHQE7UbtAAvkHGaDETxLrVLtGMvisL2IdaNIaP2elP/90hs7ByAcJ8AV9Tj
	 PrfJf1re8Raq/K9+7djfC8iyVEJzL4muclFt96aotaoK8MxqKJSAbR/k8S2oslfwT9
	 TWRD92vu8jrP1UuYm6WjHt1UwPr8D3TPi/z9iyfc0k5jgu60v7lX+6kIQzLLYfXIDw
	 p1fc5HLPZWCL7cMuQjq6z7ME1l30LdzFMkSY3iZ+zH2zxKoc09njoE0r2HQZsswm3Y
	 OK1bkB6ncn6jGpBVKrxDgwd7n61ZBtSDHPMdj68PR1jmWUnbTKhG9Jw2cnG9m6Zhlf
	 HzCIEMMUwjB1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC RESEND 4/7] i3c: master: Reject IBI requests from
 non-IBI-capable devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260701201533.220818-5-adrian.hunter@intel.com>
References: <20260701201533.220818-1-adrian.hunter@intel.com>
 <20260701201533.220818-5-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:29:04 +0000
Message-Id: <20260701202905.779531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Lockless access to `dev->ibi` from interrupt context races wit=
h non-atomic pointer clearing, causing a potential Use-After-Free.
- [High] Recursive read lock acquisition of `bus->lock` leading to potentia=
l AB-BA deadlock with writers.
- [High] Memory and resource leak of the IBI workqueue on the error path of=
 `i3c_dev_request_ibi_locked`.
--

commit f69cfae3be2eea35641a7d0435a4171201d362ea
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Reject IBI requests from non-IBI-capable devices

i3c_device_request_ibi() does not verify that a device advertises IBI
support before attempting to set up IBI handling. Add a check for
I3C_BCR_IBI_REQ_CAP and fail with -EOPNOTSUPP when IBI support is not
reported by the device.

> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index 101eaa77de686..307ca6dc04ca0 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -205,12 +205,14 @@ int i3c_device_request_ibi(struct i3c_device *dev,
>  		return ret;
> =20
>  	i3c_bus_normaluse_lock(dev->bus);

[Severity: High]
This is a pre-existing issue, but can this cause a deadlock with writers
if a writer arrives between two down_read() calls?

In drivers/i3c/master.c:i3c_master_reg_work_fn(), the first read lock is
acquired before triggering synchronous device registration:

	i3c_bus_normaluse_lock(&master->bus);
	if (!master->shutting_down)
		i3c_master_register_new_i3c_devs(master);

This synchronous probe path then calls i3c_device_request_ibi(), which
recursively attempts to acquire the same lock. If a writer such as
i3c_bus_maintenance_lock() (which takes down_write) arrives between the
two down_read() calls, the second down_read() blocks to prevent writer
starvation, while the writer blocks waiting for the first reader.

> -	if (dev->desc) {
> +	if (!dev->desc) {
> +		ret =3D -ENOENT;
> +	} else if (!(dev->desc->info.bcr & I3C_BCR_IBI_REQ_CAP)) {
> +		ret =3D -EOPNOTSUPP;
> +	} else {
>  		mutex_lock(&dev->desc->ibi_lock);
>  		ret =3D i3c_dev_request_ibi_locked(dev->desc, req);

[Severity: High]
This is a pre-existing issue, but does this code leak the workqueue on
the error path?

Looking at drivers/i3c/master.c:i3c_dev_request_ibi_locked():

	ibi->wq =3D alloc_ordered_workqueue(dev_name(i3cdev_to_dev(dev->dev)), WQ_=
MEM_RECLAIM);
	...
	ret =3D master->ops->request_ibi(dev, req);
	if (ret) {
		kfree(ibi);
		dev->ibi =3D NULL;
	}

If master->ops->request_ibi() fails, the ibi struct is freed but there
is no call to destroy_workqueue(ibi->wq), permanently leaking the memory
and associated kernel thread resources.


[Severity: High]
This is a pre-existing issue, but could this lead to a use-after-free
if an interrupt handler accesses dev->ibi concurrently?

In drivers/i3c/master.c:i3c_master_queue_ibi(), the hardware interrupt
handler reads dev->ibi locklessly to queue incoming IBIs:

	if (!dev->ibi || !slot)
		return;
	...
	atomic_inc(&dev->ibi->pending_ibis);
	queue_work(dev->ibi->wq, &slot->work);

However, in the error path of i3c_dev_request_ibi_locked() shown above,
and in i3c_dev_free_ibi_locked(), the memory is freed before the pointer
is cleared:

	kfree(ibi);
	dev->ibi =3D NULL;

Because there is no synchronization, a concurrent interrupt on another
CPU can read the pointer, get delayed, and then dereference it after it
has been freed.

>  		mutex_unlock(&dev->desc->ibi_lock);
> -	} else {
> -		ret =3D -ENOENT;
>  	}
>  	i3c_bus_normaluse_unlock(dev->bus);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701201533.2208=
18-1-adrian.hunter@intel.com?part=3D4
