Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8092D0605
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937855; cv=none; b=NOwdN6IU2IHERYPHiHb849Ro0HSp3wr9YPpWizvG9QLYRxh0p5R2wGLav88MFt517PPEZ9qf8io8Qj7cAmVcFeFS5yZxzlEcgrA2TC+2rihY0A+WWmTlnZe8W+3lngenXO5O0dW4woqxHyWOAFAAfkasIu0kiMbajNnc0vcbNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937855; c=relaxed/simple;
	bh=5cIV3XnTqi8shXwQNzGM3qVBVs3Y4x+RJEldrK1Jc44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a4z6ycpBWkeaLsw0IqO94da4h8vsBZKvlvS4eJQrWvdIy2I7RMX8fvXyochFHDr1oe3CnxtEX/tvfj+4xfy6AtNu4v7uRGLMdRcb4aiDTKgXPklqSMTgOh2f8YsOffCRQOAOtbE1nc/1gRxjrupGDvwuci6MrZFGcgc5hJ5SK+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jksGBYXE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jksGBYXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3971F000E9;
	Wed,  1 Jul 2026 20:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782937853;
	bh=/8AD4OkCqqUUNVESKyOnJS50oc0cOHIUm2AjhDgAbOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jksGBYXEvJ1bf0PQtnqDzfAR9jyDb2tXQ2ANpIWS6VpuDrnCeRTWDL4s8QnXiG8Lm
	 vQhgALiqIjKktr+AicRPiX76nRUzjnoc7JFfGKm3dyHtv1chBl9oYZcUSEDSmEdsA2
	 TU+EYZQ6XqDqMmQh8+cuoHWJKNfECbeL7gBEuqxtJTNexXx21zGRME1j2k85bTxYj1
	 QNisXrEV+fSLTbQ/X9aJtZM3YIzLiSWHLBF7ByfNUZ3TNPEupIrw072aoceaN2+Hg6
	 Cr3Kx6hxovWr2XQM815IWiwPqIx9+pq0DfJNka5Zb2QcqgVZdYwlo5QCVwdIOaUKHN
	 tuITYwFgmcPLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC RESEND 1/7] i3c: master: Support IBI-based wakeup
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260701201533.220818-2-adrian.hunter@intel.com>
References: <20260701201533.220818-1-adrian.hunter@intel.com>
 <20260701201533.220818-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:30:53 +0000
Message-Id: <20260701203053.8F3971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free and double-free of I3C device due to dangling point=
er on device_register() failure.
- [High] Reference count underflow of OF node due to missing of_node_get() =
during device registration.
--

commit 9efcfa1df1912edf83596e1ebd38559fc710aaca
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Support IBI-based wakeup capability

This patch adds an ibi_wakeup flag to the I3C master controller. It allows
IBI-capable I3C devices to be marked as wakeup capable during registration
if the controller supports waking the system via In-Band Interrupts.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
[ ... ]
> @@ -1930,6 +1931,13 @@ i3c_master_register_new_i3c_devs(struct i3c_master=
_controller *master)
>  		if (desc->boardinfo)
>  			desc->dev->dev.of_node =3D desc->boardinfo->of_node;

[Severity: High]
This isn't a bug introduced by this patch, but does this assignment cause
an OF node reference count underflow?

The pointer is assigned without taking a new reference via of_node_get().
However, when the device is freed, i3c_device_release() unconditionally
calls of_node_put(i3cdev->dev.of_node).

If device_register() fails just below this, or when the device is eventually
unregistered, the release function will drop a reference that was never
acquired for the device itself.

> =20
> +		/*
> +		 * In the case of IBI wakeup, any IBI-capable device can
> +		 * wakeup.
> +		 */
> +		if (master->ibi_wakeup && (desc->info.bcr & I3C_BCR_IBI_REQ_CAP))
> +			device_set_wakeup_capable(&desc->dev->dev, true);
> +
>  		ret =3D device_register(&desc->dev->dev);
>  		if (ret) {
>  			dev_err(&master->dev,
>  				"Failed to add I3C device (err =3D %d)\n", ret);
>  			put_device(&desc->dev->dev);

[Severity: High]
This is a pre-existing issue, but does this error path leave a dangling
pointer that causes a use-after-free and double-free later?

If device_register() fails, put_device() is called which frees desc->dev
via i3c_device_release(), but desc->dev is never set to NULL.

Later, during controller teardown, i3c_master_unregister_i3c_devs()
iterates over the bus and checks if (!i3cdev->dev). Since the pointer
wasn't cleared, it proceeds to dereference it and free it again:

i3c_master_unregister_i3c_devs() {
    ...
    i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
        if (!i3cdev->dev)
            continue;

        i3cdev->dev->desc =3D NULL;
        ...
        else
            put_device(&i3cdev->dev->dev);
}

Should desc->dev be set to NULL after the put_device() call here?

>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701201533.2208=
18-1-adrian.hunter@intel.com?part=3D1
