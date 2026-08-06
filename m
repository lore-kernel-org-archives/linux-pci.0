Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C339CCF3
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024201; cv=none; b=mHa4bpHI0gUEI9SMl+ijnuZtWXQqdOcdWZZcGhDw54Bjmc4X+CPVjpQmejjssyU2dQwfJ+mYS7dtPv4wqVDFGVctag+6eLpcowmPlEl0uNMbvyXRaNRJwBz41VPZyBOrBL7vFMMHtvEWMLIO/6nkFi4Sa8bwUhC4AH4Va1qfmdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024201; c=relaxed/simple;
	bh=uUWkh3mCXSkNyeb8s/Do+ljy+CNTEu7z0u5Ah+0QNJw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iKfvkYfxrCEDjg37X3qQpCTMCcPZTnB4n+YkQ8Tw+eDLfutdAT/2UAI6R+GKbrZgdCAcc5xKzEEPNvwjNFeOswDGJ+rf8zWKOkBDSsM+TccxHp2cQS/Bqpc0nWGRVQf0HqXj55BD8v2qSD3i/HkLX0EoKw21w6af2OnAn+y97DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3RP9lbj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3RP9lbj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A494B1F00A3A;
	Thu,  6 Aug 2026 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024200;
	bh=mzx55sYR17rtWzeVrQP3jxEurNyMq6DyCUsbSTvjsNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F3RP9lbjtTT1JI2v9v0+1QN6f8U7hKGY+S8TKFWQbufG1I1xaZDWDPQxgFv336Nax
	 5ttcYUEol5PPolrQefkbg3FysQgHyBNoaCYYNVzw1Z6570rlm5Vc3ESXmT4xs6QOh5
	 X8m28FzDKB0Ar6bQl85k0M2jeZz0TXWrBmGlt8RDEBByaHTZ0XtYTXCibVOP9Gz+qd
	 sKKK6EDTJfdT2h7Fmy+KIX1ST4xIfFllJM0pznTn86sCRFuWULljEvTfGPlsg/qj/q
	 YjWyXny38KbEiI4WJxNAirEMJqPSNDt91IXRTrZDjoXVeEHSypnLZJGa7yCX3opisY
	 nAztivRsse+/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 09/14] i3c: master: Report wakeup events for IBIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org, linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org
In-Reply-To: <20260806131857.119830-10-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-10-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:49:59 +0000
Message-Id: <20260806134959.A494B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] NULL pointer dereference in `i3c_master_queue_ibi()` when accessin=
g `dev->dev`.

Pre-existing issues:
- [High] Race condition in `i3c_master_queue_ibi()` leading to Use-After-Fr=
ee of `dev->ibi`.
--

--- Patch [9]: [PATCH V4 09/14] i3c: master: Report wakeup events for IBIs =
---
commit 461a49ac6bedf9467539aa8fac5583bf77ad5045
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Report wakeup events for IBIs

An I3C device configured as a wakeup source can wake the system by
generating an In-Band Interrupt (IBI). When an IBI is queued for
processing, record a wakeup event for the device if wakeup is enabled.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 2616354dbe545..6c53414919445 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c

[ ... ]

> @@ -3397,6 +3400,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev,=
 struct i3c_ibi_slot *slot)
>  	if (!dev->ibi || !slot)
>  		return;
> =20
> +	if (device_may_wakeup(&dev->dev->dev))
> +		pm_wakeup_event(&dev->dev->dev, I3C_WAKEUP_PROCESSING_TIME_MS);
> +

[Severity: High]
Can dev->dev be NULL here?

Looking at i3c_master_unregister_i3c_devs(), it sets i3cdev->dev to NULL
during device teardown:

drivers/i3c/master.c:i3c_master_unregister_i3c_devs() {
    ...
		i3cdev->dev->desc =3D NULL;
		put_device(&i3cdev->dev->dev);
		i3cdev->dev =3D NULL;
	}
}

If a hardware IBI is received during or shortly after this teardown,
wouldn't accessing &dev->dev->dev cause a NULL pointer dereference when
evaluated inside device_may_wakeup()?

>  	atomic_inc(&dev->ibi->pending_ibis);

[Severity: High]
This is a pre-existing issue, but does the lack of synchronization here all=
ow
a use-after-free of dev->ibi?

The teardown path in i3c_dev_disable_ibi_locked() checks pending_ibis
locklessly and bypasses waiting if it reads 0:

drivers/i3c/master.c:i3c_dev_disable_ibi_locked() {
    ...
	if (atomic_read(&dev->ibi->pending_ibis))
		wait_for_completion(&dev->ibi->all_ibis_handled);
    ...
}

If an ISR is executing concurrently and passes the check for !dev->ibi at
the top of i3c_master_queue_ibi(), but hasn't yet reached the atomic_inc()
here, the teardown thread could see pending_ibis =3D=3D 0 and proceed to fr=
ee
dev->ibi in i3c_dev_free_ibi_locked():

drivers/i3c/master.c:i3c_dev_free_ibi_locked() {
    ...
	kfree(dev->ibi);
	dev->ibi =3D NULL;
    ...
}

When the ISR resumes, wouldn't the subsequent accesses to
dev->ibi->pending_ibis and dev->ibi->wq cause a use-after-free? Adding
the wakeup event logic slightly widens this existing race window.

>  	queue_work(dev->ibi->wq, &slot->work);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131857.1198=
30-1-adrian.hunter@intel.com?part=3D9
