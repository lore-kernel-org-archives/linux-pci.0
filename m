Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB5734D3BE
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938018; cv=none; b=UdJSn2UITIaFCLwo/g9VFh7ZdHjqTDU6RRMdQQ+5cWztkqxXi4+cFY8e6uLkBk/Uw8QFW4emhGxmmkS62qt2jdnqbW51iW8MlKlUsN4VLHmpqMa2TOJxr1zWJbL3dX+cheMiKIqtMPXDVnXpPITbMoG7QyCuiar7Y2asrX5q4OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938018; c=relaxed/simple;
	bh=ELZutrj0QBfagOITFRDtjnOLG4ZbOXcswclL+n1kmu0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yq6xLQei8gd/FMAu2aVmqat+kfc/8AeeCyXz9AGHKXX3KfBQv8RrBEOSEik/Bg8cwVEryblnqF96eAdWfNLOath6fvNQsesji2eT1hhqN6ZBzxrR7JczuW+jfbvo/G9KPUPIO3hXqPuHjsT/3oZSUvs1XUhoKyaaTG/YyGpuQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBdmx60U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBdmx60U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13321F000E9;
	Wed,  1 Jul 2026 20:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782938017;
	bh=NyVMPti0TCUuC112Dde4qDthm08jy8jxIFdrJwiV/Oc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GBdmx60UAv5LPWXpzLXTCa5ewIonKVWxFSAsI/PVek5Fn7PdFr3Znd6IpnoKViXWy
	 MrcKC638sAs2xZRxN0oksf/bQxGwD+jYLDZAPHwjo4z16XZVYwfE3Q/IPlWTOlrpQ5
	 KkdpDoQR+Msrz+d5VA6EmROlYF2rWdKgjiyTs4NdltInKwIfgnBUI7VlzlAdNdqwaT
	 uWPOh8h5BIrm351ykYvEe1J8vH3GXl3FTWJenr1vGx7JkbPw5Y0WFlc5IeRnpCeMU0
	 VCha7Un8CEMQhZFCshHo6YHNtPNRukrKuAAWkRNPgHDMvToiBHliV0R4T0Zo2PJHCC
	 Ly2bqS4y8Jp7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC RESEND 2/7] i3c: master: Report wakeup events for
 IBIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org, linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org
In-Reply-To: <20260701201533.220818-3-adrian.hunter@intel.com>
References: <20260701201533.220818-1-adrian.hunter@intel.com>
 <20260701201533.220818-3-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:33:36 +0000
Message-Id: <20260701203336.D13321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unconditional NULL pointer dereference of `dev->dev` in `i3c_maste=
r_queue_ibi` during device teardown

Pre-existing issues:
- [High] Lockless TOCTOU race leading to Use-After-Free of `dev->ibi` durin=
g concurrent IBI teardown
--

commit ffdd9b066a2bdadecaab205d187dab1a5ecff5ae
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Report wakeup events for IBIs

An I3C device configured as a wakeup source can wake the system by
generating an In-Band Interrupt (IBI).

When an IBI is queued for processing, record a wakeup event for the
device if wakeup is enabled.  Use a 100 ms processing interval to give
the I3C device driver time to process the IBI.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index a47e2924bb701..a36f9b617cbf7 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c

[ ... ]

> @@ -3007,6 +3010,9 @@ void i3c_master_queue_ibi(struct i3c_dev_desc *dev,=
 struct i3c_ibi_slot *slot)
>  	if (!dev->ibi || !slot)
>  		return;
> =20
> +	if (device_may_wakeup(&dev->dev->dev))
> +		pm_wakeup_event(&dev->dev->dev, I3C_WAKEUP_PROCESSING_TIME_MS);
> +

[Severity: High]
Does this code introduce a NULL pointer dereference if an interrupt arrives
during device teardown?

During I3C master controller unregistration, i3c_master_unregister_i3c_devs=
()
clears the device description and sets i3cdev->dev to NULL:

	i3cdev->dev->desc =3D NULL;
	if (device_is_registered(&i3cdev->dev->dev))
		device_unregister(&i3cdev->dev->dev);
	else
		put_device(&i3cdev->dev->dev);
	i3cdev->dev =3D NULL;

Since clearing dev->desc prevents the driver's remove callback from disabli=
ng
the hardware IBI, the IBI may still fire. If i3c_master_queue_ibi() executes
at this point, the newly added device_may_wakeup(&dev->dev->dev) will
dereference the NULL dev->dev pointer.

>  	atomic_inc(&dev->ibi->pending_ibis);

[Severity: High]
This is a pre-existing issue, but does this lockless check open a=20
use-after-free race window?

If a hardware IBI interrupt is processed concurrently on another CPU, it can
evaluate if (!dev->ibi) as false, get preempted, and then access
dev->ibi->pending_ibis and dev->ibi->wq after they have been freed by
i3c_dev_free_ibi_locked():

	kfree(dev->ibi);
	dev->ibi =3D NULL;

This is possible for hardware controllers like dw-i3c-master that do not
implicitly synchronize with executing hardware IRQ handlers during their
disable op.

>  	queue_work(dev->ibi->wq, &slot->work);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701201533.2208=
18-1-adrian.hunter@intel.com?part=3D2
