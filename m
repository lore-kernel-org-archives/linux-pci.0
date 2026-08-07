Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F459476068
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117281; cv=none; b=Re6jDMJ9IZwpGOF8n7vskz/eENg9Zjie39v9Y2lKGa8tkngMqpcEdVoTYcRtGd1JXdZ5aVYjE5a0nCKqDE0etbzjvKbUHzIaIu0lt5TIUTN54ghYoQsgY6G3mK8qF9H946p34Bkvt1dKqq+S77+2ssBo2S+t00ek89oFqTC+J+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117281; c=relaxed/simple;
	bh=RCmM47B4/6cxCC1F2N8+vqWfOBFiC9hFXTmlIPZDj1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Klk+6Hqxej8YdYLPAFp+BmL71hxZMewxtL0muPtj3CfxOICCDQh9RQ1gwe4raouLmbMqVkhp7xPy2UtNBI1/VBv71CMNSVY+FVQ8yr9yAkX4A+eVwAzw/NLaeQ52xOU4/LM3TeVB9z7saFrC5QhtJyOiItJNj6RKaqzUKocKb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4p0P6VN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4p0P6VN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0251F00A3A;
	Fri,  7 Aug 2026 15:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786117280;
	bh=PE4PrpyaYrRz84BjM/E6+zc5CFMMSSZKMYgKV/KiIp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N4p0P6VNpoL1O6186NyNIGacDfl5JCABW4KgVWn40IjIPUBAHkOUnR/P7bNXB4fFw
	 1YKaUgdeAkr1/TVV0ublns6UChaGubL+YWw5U7igsPUbx9vNSI3Vwv3r94ooAUDPzH
	 BrustQ8qwvbc63YvSeVwNVCHpwmhgNr2pP71/WyEMCwfWtAe3QQFsLag30Um+znbxV
	 r4fVBd3YhCoBHaKa8U26qZGPa7Goc2HyyWOyH4IJLUc+P3xnzGzza/qfvhNhl5g919
	 ++rs4lIKl7NtlpJqzDkESMZJznkah98gJ8UfwEMnjRBYahqiHasemWdapiZXLUFh1j
	 FRfeXzEpIh8fA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 09/14] i3c: master: Report wakeup events for IBIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org, Frank.Li@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260807145638.168865-10-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-10-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:41:19 +0000
Message-Id: <20260807154119.EC0251F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unprotected access to `dev->dev` in `i3c_master_queue_ibi()` intro=
duces a NULL pointer dereference or Use-After-Free during concurrent device=
 teardown.

Pre-existing issues:
- [High] Preexisting lockless access to `dev->ibi` in `i3c_master_queue_ibi=
()` leads to a Use-After-Free (UAF) if an IBI is handled concurrently with =
IBI freeing.
--

--- Patch [9]: [PATCH V5 09/14] i3c: master: Report wakeup events for IBIs =
---
commit b0c07417134eb0c8209460a9c252faf745d3feee
Author: Adrian Hunter <adrian.hunter@intel.com>
Subject: i3c: master: Report wakeup events for IBIs

This commit modifies the I3C master subsystem to report wakeup events for
devices configured as wakeup sources. It queues a wakeup event when an
In-Band Interrupt (IBI) is processed by i3c_master_queue_ibi().

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
Does this code introduce a potential NULL pointer dereference or
use-after-free if a concurrent teardown unregisters the device?

Since i3c_master_queue_ibi() runs locklessly from the master's IRQ handler,
could a concurrent teardown thread reach i3c_master_unregister_i3c_devs():

	put_device(&i3cdev->dev->dev);
	i3cdev->dev =3D NULL;

while the IRQ handler is between the !dev->ibi check and this new wakeup
check?

If the controller's disable_ibi callback does not synchronize with the IRQ
handler using synchronize_irq(), the teardown thread could see
pending_ibis =3D=3D 0 and proceed to unbind the device, which would cause
dereferencing dev->dev->dev here to panic.

>  	atomic_inc(&dev->ibi->pending_ibis);
>  	queue_work(dev->ibi->wq, &slot->work);
[Severity: High]
This is a pre-existing issue, but can this lockless access to dev->ibi cause
a use-after-free during concurrent device unbinding?

If the IRQ handler has passed the !dev->ibi check but hasn't yet reached
this atomic_inc(), a concurrent thread executing i3c_dev_free_ibi_locked()
could disable IBIs.

Because pending_ibis has not been incremented yet, it would see
pending_ibis =3D=3D 0 and proceed to free the IBI resources without waiting:

	kfree(dev->ibi);
	dev->ibi =3D NULL;

When the IRQ handler resumes, it would execute atomic_inc() and queue_work(=
),
writing to the freed dev->ibi structure.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145638.1688=
65-1-adrian.hunter@intel.com?part=3D9
