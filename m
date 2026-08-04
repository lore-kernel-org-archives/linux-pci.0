Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322A44998F
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856221; cv=none; b=pCDtV8nnHi3pmnUOduPPe060aBfpHJYj3vplK32qAUKijcgox8SQhHqPglr3IoM+kIHasJzC/jQzso4hosaZGLOd4EO1jY1Rh6EO0KVnCp/bwW8u78534Spnxd2Qp42nM5xfInCDDArG0icXePFKhNYgkSfgszyi4wW8oIM3xXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856221; c=relaxed/simple;
	bh=k7P3vAykQxhoTnZYgczKRcOcTyFzTw7xSuo/AgCWTS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s/dhAGCLMHLqg2CMqXgXjNj+O/9frJXxcRn6BMgIjRjKCZe8M3YOCOIYpiGir3pjif9IVF7tckwI5faDfeu51PddPcMkOHmwSnAIqlBQ4PFk9nYA+Ay3KCoTMP9UyXNwpU24yhp8AulDpQO8nc7Tk0CSFHCrzDV5m1nvLZdU9MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDgk2ZdY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDgk2ZdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAA81F000E9;
	Tue,  4 Aug 2026 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785856220;
	bh=Cnsggypc6ihctNmR1lbKZANczuzfHh4gesfVpYky0YE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JDgk2ZdYO5vCgGD9y4AmAM3B+ZOwSzgisvRETDrsFBRcISKeSXYMFzhhr8FzcKytq
	 NuDXvysD7uvkY2J3YSVVpRpoCAi0hemdNiqh8broJrByhtYRoktmmzIdlGdLok+ZZu
	 +BTH/mrvrbV366swbqXIM3bumuaLLoCisEyAA+BVhQUb961jL/nfEVEQAtfw6hb4mx
	 /Fde/Toc2vF1TIdtDBbA1BbzdLLWZ7nrEqBwXiYvN0J44EcpWKEBMvGbKU7a6q3fuY
	 U6JR+lkXVHY899LsyuHgCzqYAjAc3605zq4HOHiqrdxZBDA2kCKQQZ20J7FfWAJAPk
	 hO4Z2cVrb4J7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 09/14] i3c: master: Report wakeup events for IBIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org
In-Reply-To: <20260804133810.184905-10-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-10-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:10:18 +0000
Message-Id: <20260804151019.BCAA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unprotected dereference of dev->dev in i3c_master_queue_ibi() lead=
ing to NULL pointer dereference or Use-After-Free during teardown.

Pre-existing issues:
- [High] Race condition between hardware IBI interrupts and IBI teardown le=
ading to Use-After-Free of dev->ibi.
--

--- Patch [9]: [PATCH V3 09/14] i3c: master: Report wakeup events for IBIs =
---
commit 044b30e8813c466ee0c955f282a081170370a564
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Report wakeup events for IBIs

When an IBI is queued for processing, this commit records a wakeup event
for the device if wakeup is enabled. It uses a 100 ms processing interval
to give the I3C device driver time to process the IBI.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index e6b320da475e0..8c9e62e6f1469 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -3398,6 +3401,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev,=
 struct i3c_ibi_slot *slot)
>  	if (!dev->ibi || !slot)
>  		return;
> =20
> +	if (device_may_wakeup(&dev->dev->dev))
> +		pm_wakeup_event(&dev->dev->dev, I3C_WAKEUP_PROCESSING_TIME_MS);
> +

[Severity: High]
Is it possible for an IBI interrupt to fire concurrently with device
unregistration?

Looking at i3c_master_unregister_i3c_devs(), the teardown path sets
dev->dev to NULL:

drivers/i3c/master.c:i3c_master_unregister_i3c_devs() {
    ...
    i3cdev->dev->desc =3D NULL;
    put_device(&i3cdev->dev->dev);
    i3cdev->dev =3D NULL;
    ...
}

If an interrupt occurs during or just after this unregistration, could
dev->dev be NULL when device_may_wakeup() dereferences it here?

>  	atomic_inc(&dev->ibi->pending_ibis);
>  	queue_work(dev->ibi->wq, &slot->work);
>  }

[Severity: High]
This is a pre-existing issue, but is there a race condition between hardware
IBI interrupts and IBI teardown leading to a use-after-free of dev->ibi?

In i3c_dev_disable_ibi_locked(), the code checks the pending_ibis counter:

drivers/i3c/master.c:i3c_dev_disable_ibi_locked() {
    ...
    if (atomic_read(&dev->ibi->pending_ibis))
        wait_for_completion(&dev->ibi->all_ibis_handled);
    ...
}

If a hardirq handler is already executing but has not yet called
i3c_master_queue_ibi() to increment pending_ibis, the teardown path might
assume no IBIs are pending and proceed to free dev->ibi in
i3c_dev_free_ibi_locked().

When the interrupted CPU resumes, wouldn't it execute this atomic_inc() and
queue_work() on the freed dev->ibi pointer since there is no
synchronize_irq() to drain active hardirqs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133810.1849=
05-1-adrian.hunter@intel.com?part=3D9
